//! Zigcraft Main Application
//! Minecraft Java Edition rewritten in Zig and Odin.

const std = @import("std");
const math = @import("core/math.zig");
const Vec3 = math.Vec3;
const Mat4 = math.Mat4;
const chunk_mod = @import("world/chunk.zig");
const Chunk = chunk_mod.Chunk;
const mesher = @import("world/mesher.zig");
const ChunkMesh = mesher.ChunkMesh;
const protocol = @import("network/protocol.zig");
const odin = @import("bridge/odin_bridge.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print("=========================================\n", .{});
    std.debug.print("  Zigcraft: Minecraft in Zig & Odin\n", .{});
    std.debug.print("=========================================\n", .{});

    // 1. Initialize Odin gameplay & worldgen engine
    std.debug.print("[Zigcraft] Initializing Odin subsystem...\n", .{});
    odin.odin_init();
    std.debug.print("[Zigcraft] Odin initialized successfully.\n", .{});

    // 2. Allocate and generate a chunk using Odin's worldgen
    std.debug.print("[Zigcraft] Generating chunk (0, 0) via Odin worldgen...\n", .{});
    var chunk = try Chunk.init(allocator, 0, 0);
    defer chunk.deinit(allocator);

    // Call Odin's C ABI to populate the chunk with terrain, caves, ores, and trees
    var raw_blocks: [16 * 256 * 16]u16 = undefined;
    odin.odin_generate_chunk(0, 0, &raw_blocks);

    // Copy populated blocks into the Zig chunk structure
    var y: usize = 0;
    while (y < chunk_mod.CHUNK_HEIGHT) : (y += 1) {
        var z: usize = 0;
        while (z < 16) : (z += 1) {
            var x: usize = 0;
            while (x < 16) : (x += 1) {
                const idx = x + (z * 16) + (y * 256);
                chunk.setBlock(x, y, z, @enumFromInt(raw_blocks[idx]));
            }
        }
    }
    std.debug.print("[Zigcraft] Chunk generated. Non-air sections populated.\n", .{});

    // 3. Mesh the chunk using Zig's high performance face-culling mesher
    std.debug.print("[Zigcraft] Meshing chunk with Zig voxel mesher...\n", .{});
    var mesh = ChunkMesh.init(allocator);
    defer mesh.deinit();

    try mesher.meshChunk(&mesh, chunk);
    std.debug.print("[Zigcraft] Mesh complete: {} vertices, {} indices ({} triangles)\n", .{
        mesh.vertices.items.len,
        mesh.indices.items.len,
        mesh.indices.items.len / 3,
    });

    // 4. Test player physics simulation step in Odin
    var pos = [3]f32{ 8.0, 75.0, 8.0 };
    var vel = [3]f32{ 0.0, 0.0, 0.0 };
    var on_ground: bool = false;

    std.debug.print("[Zigcraft] Running physics tick in Odin...\n", .{});
    odin.odin_tick_physics(&pos, &vel, &on_ground, 0.05, 1.0, 0.0, 0.0, false);
    std.debug.print("[Zigcraft] Player position after tick: ({d:.2}, {d:.2}, {d:.2}), on_ground: {}\n", .{
        pos[0], pos[1], pos[2], on_ground,
    });

    // 5. Test Minecraft protocol encoding
    var writer = protocol.PacketWriter.init(allocator);
    defer writer.deinit();

    const handshake = protocol.HandshakePacket{
        .protocol_version = 765, // Minecraft 1.20.4+ / Java Edition
        .server_address = "localhost",
        .server_port = 25565,
        .next_state = 2, // Login
    };
    try handshake.encode(&writer);
    std.debug.print("[Zigcraft] Encoded Minecraft Handshake packet: {} bytes\n", .{writer.buffer.items.len});

    std.debug.print("[Zigcraft] All Zig & Odin systems operating normally!\n", .{});
}
