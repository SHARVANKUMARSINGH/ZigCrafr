package worldgen

import "core:math"

// Minecraft Block IDs matching Zigcraft block enum
BLOCK_AIR         : u16 : 0
BLOCK_STONE       : u16 : 1
BLOCK_GRASS_BLOCK : u16 : 2
BLOCK_DIRT        : u16 : 3
BLOCK_COBBLESTONE : u16 : 4
BLOCK_WOOD_PLANKS : u16 : 5
BLOCK_BEDROCK     : u16 : 7
BLOCK_WATER       : u16 : 8
BLOCK_LAVA        : u16 : 10
BLOCK_SAND        : u16 : 12
BLOCK_GRAVEL      : u16 : 13
BLOCK_GOLD_ORE    : u16 : 14
BLOCK_IRON_ORE    : u16 : 15
BLOCK_COAL_ORE    : u16 : 16
BLOCK_WOOD_LOG    : u16 : 17
BLOCK_LEAVES      : u16 : 18
BLOCK_GLASS       : u16 : 20
BLOCK_DIAMOND_ORE : u16 : 56

SEA_LEVEL :: 64

// Generates an entire 16x256x16 chunk into a linear array
generate_chunk :: proc(cx, cz: i32, blocks: ^[16 * 256 * 16]u16) {
    // Fill air initially
    for i in 0..<(16 * 256 * 16) {
        blocks[i] = BLOCK_AIR
    }

    world_x_base := cx * 16
    world_z_base := cz * 16

    for lz in 0..<16 {
        for lx in 0..<16 {
            wx := f32(world_x_base + i32(lx))
            wz := f32(world_z_base + i32(lz))

            // Continental height noise
            height_factor := fbm2d(wx * 0.005, wz * 0.005, 4, 0.5, 2.0)
            detail := fbm2d(wx * 0.02, wz * 0.02, 3, 0.5, 2.0)

            base_height := 60.0 + height_factor * 30.0 + detail * 10.0
            height := int(math.clamp(base_height, 5.0, 250.0))

            // Column filling
            for y in 0..<256 {
                idx := lx + (lz * 16) + (y * 256)

                if y == 0 {
                    blocks[idx] = BLOCK_BEDROCK
                } else if y < height - 4 {
                    // Ore distribution
                    seed_hash := (int(wx) * 73856093) ~ (int(wz) * 19349663) ~ (y * 83492791)
                    r := (seed_hash >> 8) & 0xFF

                    if y < 16 && r < 3 {
                        blocks[idx] = BLOCK_DIAMOND_ORE
                    } else if y < 32 && r < 6 {
                        blocks[idx] = BLOCK_GOLD_ORE
                    } else if y < 64 && r < 12 {
                        blocks[idx] = BLOCK_IRON_ORE
                    } else if r < 20 {
                        blocks[idx] = BLOCK_COAL_ORE
                    } else {
                        blocks[idx] = BLOCK_STONE
                    }
                } else if y < height {
                    if height <= SEA_LEVEL + 1 {
                        blocks[idx] = BLOCK_SAND
                    } else {
                        blocks[idx] = BLOCK_DIRT
                    }
                } else if y == height {
                    if height < SEA_LEVEL {
                        blocks[idx] = BLOCK_GRAVEL
                    } else if height <= SEA_LEVEL + 2 {
                        blocks[idx] = BLOCK_SAND
                    } else {
                        blocks[idx] = BLOCK_GRASS_BLOCK
                    }
                } else if y <= SEA_LEVEL {
                    // Fill water up to sea level
                    blocks[idx] = BLOCK_WATER
                }
            }

            // Tree generation chance on grass surface
            if height > SEA_LEVEL + 2 && lx >= 2 && lx <= 13 && lz >= 2 && lz <= 13 {
                tree_hash := (int(wx) * 31337) ~ (int(wz) * 71119)
                if (tree_hash & 0x3F) == 7 {
                    spawn_tree(lx, height + 1, lz, blocks)
                }
            }
        }
    }
}

spawn_tree :: proc(x, y, z: int, blocks: ^[16 * 256 * 16]u16) {
    trunk_height := 5
    if y + trunk_height + 2 >= 256 do return

    // Trunk
    for ty in 0..<trunk_height {
        idx := x + (z * 16) + ((y + ty) * 256)
        blocks[idx] = BLOCK_WOOD_LOG
    }

    // Leaves canopy
    leaf_y_start := y + trunk_height - 2
    for ly in leaf_y_start..=(y + trunk_height + 1) {
        radius := (ly >= y + trunk_height) ? 1 : 2
        for ox in -radius..=radius {
            for oz in -radius..=radius {
                nx := x + ox
                nz := z + oz
                if nx >= 0 && nx < 16 && nz >= 0 && nz < 16 && ly < 256 {
                    idx := nx + (nz * 16) + (ly * 256)
                    if blocks[idx] == BLOCK_AIR {
                        blocks[idx] = BLOCK_LEAVES
                    }
                }
            }
        }
    }
}
