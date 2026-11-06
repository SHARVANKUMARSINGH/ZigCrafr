//! Zigcraft Block Definitions & Registry
//! Compatible with Minecraft Java Edition block IDs and attributes.

pub const BlockId = enum(u16) {
    air = 0,
    stone = 1,
    grass_block = 2,
    dirt = 3,
    cobblestone = 4,
    wood_planks = 5,
    bedrock = 7,
    water = 8,
    lava = 10,
    sand = 12,
    gravel = 13,
    gold_ore = 14,
    iron_ore = 15,
    coal_ore = 16,
    wood_log = 17,
    leaves = 18,
    glass = 20,
    diamond_ore = 56,
    obsidian = 49,
    _,

    pub fn isSolid(self: BlockId) bool {
        return switch (self) {
            .air, .water, .lava => false,
            else => true,
        };
    }

    pub fn isTransparent(self: BlockId) bool {
        return switch (self) {
            .air, .water, .leaves, .glass => true,
            else => false,
        };
    }

    pub fn isLiquid(self: BlockId) bool {
        return switch (self) {
            .water, .lava => true,
            else => false,
        };
    }

    pub fn hardness(self: BlockId) f32 {
        return switch (self) {
            .air => 0.0,
            .dirt, .sand, .gravel => 0.5,
            .grass_block => 0.6,
            .leaves => 0.2,
            .wood_planks, .wood_log => 2.0,
            .stone, .cobblestone => 1.5,
            .iron_ore, .coal_ore, .gold_ore => 3.0,
            .diamond_ore => 3.0,
            .obsidian => 50.0,
            .bedrock => -1.0,
            else => 1.0,
        };
    }

    /// Atlas tile index (x, y in a 16x16 block texture atlas)
    pub fn getTextureIndices(self: BlockId, face: BlockFace) struct { u8, u8 } {
        return switch (self) {
            .grass_block => switch (face) {
                .top => .{ 0, 0 },
                .bottom => .{ 2, 0 },
                else => .{ 3, 0 },
            },
            .stone => .{ 1, 0 },
            .dirt => .{ 2, 0 },
            .wood_planks => .{ 4, 0 },
            .wood_log => switch (face) {
                .top, .bottom => .{ 5, 1 },
                else => .{ 4, 1 },
            },
            .leaves => .{ 5, 0 },
            .bedrock => .{ 1, 1 },
            .sand => .{ 2, 1 },
            .gravel => .{ 3, 1 },
            .coal_ore => .{ 2, 2 },
            .iron_ore => .{ 1, 2 },
            .gold_ore => .{ 0, 2 },
            .diamond_ore => .{ 2, 3 },
            .cobblestone => .{ 0, 1 },
            .glass => .{ 1, 3 },
            .water => .{ 13, 12 },
            else => .{ 0, 0 },
        };
    }
};

pub const BlockFace = enum(u3) {
    top = 0,
    bottom = 1,
    north = 2,
    south = 3,
    west = 4,
    east = 5,

    pub fn normal(self: BlockFace) struct { i32, i32, i32 } {
        return switch (self) {
            .top => .{ 0, 1, 0 },
            .bottom => .{ 0, -1, 0 },
            .north => .{ 0, 0, -1 },
            .south => .{ 0, 0, 1 },
            .west => .{ -1, 0, 0 },
            .east => .{ 1, 0, 0 },
        };
    }
};
