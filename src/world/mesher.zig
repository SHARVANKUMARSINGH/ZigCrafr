//! Zigcraft Voxel Mesher
//! Fast face-culling and quad emission for chunk rendering.

const std = @import("std");
const Allocator = std.mem.Allocator;
const chunk_mod = @import("chunk.zig");
const Chunk = chunk_mod.Chunk;
const block_mod = @import("block.zig");
const BlockId = block_mod.BlockId;
const BlockFace = block_mod.BlockFace;

pub const Vertex = struct {
    pos: [3]f32,
    uv: [2]f32,
    normal: [3]f32,
    ao: f32,
    light: f32,
};

pub const ChunkMesh = struct {
    vertices: std.ArrayList(Vertex),
    indices: std.ArrayList(u32),

    pub fn init(allocator: Allocator) ChunkMesh {
        return .{
            .vertices = std.ArrayList(Vertex).init(allocator),
            .indices = std.ArrayList(u32).init(allocator),
        };
    }

    pub fn deinit(self: *ChunkMesh) void {
        self.vertices.deinit();
        self.indices.deinit();
    }

    pub fn clear(self: *ChunkMesh) void {
        self.vertices.clearRetainingCapacity();
        self.indices.clearRetainingCapacity();
    }
};

pub fn meshChunk(mesh: *ChunkMesh, chunk: *const Chunk) !void {
    mesh.clear();

    const cx: f32 = @floatFromInt(chunk.x * 16);
    const cz: f32 = @floatFromInt(chunk.z * 16);

    var y: usize = 0;
    while (y < chunk_mod.CHUNK_HEIGHT) : (y += 1) {
        var z: usize = 0;
        while (z < 16) : (z += 1) {
            var x: usize = 0;
            while (x < 16) : (x += 1) {
                const b = chunk.getBlock(x, y, z);
                if (b == .air) continue;

                const fx: f32 = cx + @as(f32, @floatFromInt(x));
                const fy: f32 = @floatFromInt(y);
                const fz: f32 = cz + @as(f32, @floatFromInt(z));

                // Check 6 faces
                // Top (+Y)
                if (y + 1 >= chunk_mod.CHUNK_HEIGHT or chunk.getBlock(x, y + 1, z).isTransparent()) {
                    try appendFace(mesh, fx, fy, fz, b, .top);
                }
                // Bottom (-Y)
                if (y == 0 or chunk.getBlock(x, y - 1, z).isTransparent()) {
                    try appendFace(mesh, fx, fy, fz, b, .bottom);
                }
                // North (-Z)
                if (z == 0 or chunk.getBlock(x, y, z - 1).isTransparent()) {
                    try appendFace(mesh, fx, fy, fz, b, .north);
                }
                // South (+Z)
                if (z + 1 >= 16 or chunk.getBlock(x, y, z + 1).isTransparent()) {
                    try appendFace(mesh, fx, fy, fz, b, .south);
                }
                // West (-X)
                if (x == 0 or chunk.getBlock(x - 1, y, z).isTransparent()) {
                    try appendFace(mesh, fx, fy, fz, b, .west);
                }
                // East (+X)
                if (x + 1 >= 16 or chunk.getBlock(x + 1, y, z).isTransparent()) {
                    try appendFace(mesh, fx, fy, fz, b, .east);
                }
            }
        }
    }
}

fn appendFace(mesh: *ChunkMesh, x: f32, y: f32, z: f32, id: BlockId, face: BlockFace) !void {
    const start_idx: u32 = @intCast(mesh.vertices.items.len);
    const tex = id.getTextureIndices(face);
    const tex_u0: f32 = @as(f32, @floatFromInt(tex[0])) / 16.0;
    const tex_v0: f32 = @as(f32, @floatFromInt(tex[1])) / 16.0;
    const tex_u1: f32 = tex_u0 + (1.0 / 16.0);
    const tex_v1: f32 = tex_v0 + (1.0 / 16.0);

    const norm = face.normal();
    const fnorm = [3]f32{ @floatFromInt(norm[0]), @floatFromInt(norm[1]), @floatFromInt(norm[2]) };

    const ao: f32 = 1.0;
    const light: f32 = switch (face) {
        .top => 1.0,
        .bottom => 0.5,
        .north, .south => 0.8,
        .west, .east => 0.6,
    };

    var quad_verts: [4]Vertex = undefined;

    switch (face) {
        .top => {
            quad_verts[0] = .{ .pos = .{ x, y + 1.0, z }, .uv = .{ tex_u0, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[1] = .{ .pos = .{ x, y + 1.0, z + 1.0 }, .uv = .{ tex_u0, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[2] = .{ .pos = .{ x + 1.0, y + 1.0, z + 1.0 }, .uv = .{ tex_u1, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[3] = .{ .pos = .{ x + 1.0, y + 1.0, z }, .uv = .{ tex_u1, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
        },
        .bottom => {
            quad_verts[0] = .{ .pos = .{ x, y, z + 1.0 }, .uv = .{ tex_u0, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[1] = .{ .pos = .{ x, y, z }, .uv = .{ tex_u0, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[2] = .{ .pos = .{ x + 1.0, y, z }, .uv = .{ tex_u1, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[3] = .{ .pos = .{ x + 1.0, y, z + 1.0 }, .uv = .{ tex_u1, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
        },
        .north => {
            quad_verts[0] = .{ .pos = .{ x + 1.0, y, z }, .uv = .{ tex_u0, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[1] = .{ .pos = .{ x, y, z }, .uv = .{ tex_u0, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[2] = .{ .pos = .{ x, y + 1.0, z }, .uv = .{ tex_u1, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[3] = .{ .pos = .{ x + 1.0, y + 1.0, z }, .uv = .{ tex_u1, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
        },
        .south => {
            quad_verts[0] = .{ .pos = .{ x, y, z + 1.0 }, .uv = .{ tex_u0, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[1] = .{ .pos = .{ x + 1.0, y, z + 1.0 }, .uv = .{ tex_u1, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[2] = .{ .pos = .{ x + 1.0, y + 1.0, z + 1.0 }, .uv = .{ tex_u1, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[3] = .{ .pos = .{ x, y + 1.0, z + 1.0 }, .uv = .{ tex_u0, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
        },
        .west => {
            quad_verts[0] = .{ .pos = .{ x, y, z }, .uv = .{ tex_u0, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[1] = .{ .pos = .{ x, y, z + 1.0 }, .uv = .{ tex_u1, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[2] = .{ .pos = .{ x, y + 1.0, z + 1.0 }, .uv = .{ tex_u1, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[3] = .{ .pos = .{ x, y + 1.0, z }, .uv = .{ tex_u0, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
        },
        .east => {
            quad_verts[0] = .{ .pos = .{ x + 1.0, y, z + 1.0 }, .uv = .{ tex_u0, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[1] = .{ .pos = .{ x + 1.0, y, z }, .uv = .{ tex_u1, tex_v1 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[2] = .{ .pos = .{ x + 1.0, y + 1.0, z }, .uv = .{ tex_u1, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
            quad_verts[3] = .{ .pos = .{ x + 1.0, y + 1.0, z + 1.0 }, .uv = .{ tex_u0, tex_v0 }, .normal = fnorm, .ao = ao, .light = light };
        },
    }

    try mesh.vertices.appendSlice(&quad_verts);
    try mesh.indices.appendSlice(&[_]u32{
        start_idx + 0, start_idx + 1, start_idx + 2,
        start_idx + 2, start_idx + 3, start_idx + 0,
    });
}
