//! Zigcraft Chunk and Section System
//! High-performance voxel subchunk data structures with lighting and palette encoding.

const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;
const block = @import("block.zig");
pub const BlockId = block.BlockId;

pub const CHUNK_SIZE_X = 16;
pub const CHUNK_SIZE_Z = 16;
pub const SECTION_SIZE_Y = 16;
pub const SECTION_COUNT = 16; // 256 blocks total height (standard Minecraft)
pub const CHUNK_HEIGHT = SECTION_SIZE_Y * SECTION_COUNT;

pub const ChunkSection = struct {
    blocks: [16 * 16 * 16]BlockId,
    block_light: [16 * 16 * 16 / 2]u8,
    sky_light: [16 * 16 * 16 / 2]u8,
    non_air_count: u16,

    pub fn init() ChunkSection {
        var sec: ChunkSection = undefined;
        @memset(&sec.blocks, .air);
        @memset(&sec.block_light, 0);
        @memset(&sec.sky_light, 0xFF);
        sec.non_air_count = 0;
        return sec;
    }

    pub fn getBlock(self: *const ChunkSection, x: usize, y: usize, z: usize) BlockId {
        return self.blocks[x + (z * 16) + (y * 256)];
    }

    pub fn setBlock(self: *ChunkSection, x: usize, y: usize, z: usize, id: BlockId) void {
        const idx = x + (z * 16) + (y * 256);
        const old = self.blocks[idx];
        if (old == .air and id != .air) {
            self.non_air_count += 1;
        } else if (old != .air and id == .air) {
            self.non_air_count -= 1;
        }
        self.blocks[idx] = id;
    }
};

pub const Chunk = struct {
    x: i32,
    z: i32,
    sections: [SECTION_COUNT]ChunkSection,
    is_dirty: bool,

    pub fn init(allocator: Allocator, cx: i32, cz: i32) !*Chunk {
        const chunk = try allocator.create(Chunk);
        chunk.x = cx;
        chunk.z = cz;
        chunk.is_dirty = true;
        for (&chunk.sections) |*sec| {
            sec.* = ChunkSection.init();
        }
        return chunk;
    }

    pub fn deinit(self: *Chunk, allocator: Allocator) void {
        allocator.destroy(self);
    }

    pub fn getBlock(self: *const Chunk, x: usize, y: usize, z: usize) BlockId {
        if (y >= CHUNK_HEIGHT or x >= 16 or z >= 16) return .air;
        const sec_idx = y / 16;
        const local_y = y % 16;
        return self.sections[sec_idx].getBlock(x, local_y, z);
    }

    pub fn setBlock(self: *Chunk, x: usize, y: usize, z: usize, id: BlockId) void {
        if (y >= CHUNK_HEIGHT or x >= 16 or z >= 16) return;
        const sec_idx = y / 16;
        const local_y = y % 16;
        self.sections[sec_idx].setBlock(x, local_y, z, id);
        self.is_dirty = true;
    }
};
