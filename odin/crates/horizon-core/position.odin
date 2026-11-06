//! Transpiled from Horizon Rust crate
package horizon_core_position

import "core:fmt"
import "core:mem"
import "core:math"

// Integer coordinates and vanilla's packed position formats.
    // rust: mod iter;
    // rust: pub use iter::{BlockBoxIter, BlockIterationTooLarge};

BlockPos :: struct {
    x: i32,
    y: i32,
    z: i32,
}

    // rust: impl BlockPos {
    // rust: pub const fn new(x: i32, y: i32, z: i32) -> Self {
    // rust: Self { x, y, z }
}

    // Values outside the signed 26/12/26-bit ranges are truncated as in vanilla.
    // rust: pub const fn pack(self) -> i64 {
    // rust: (((self.x as u64 & 0x3ff_ffff) << 38)
    // rust: | ((self.z as u64 & 0x3ff_ffff) << 12)
    // rust: | (self.y as u64 & 0xfff)) as i64
}

    // rust: pub const fn unpack(value: i64) -> Self {
    // rust: Self::new(
    // rust: (value >> 38) as i32,
    // rust: (value << 52 >> 52) as i32,
    // rust: (value << 26 >> 38) as i32,
    // rust: )
}

    // rust: pub const fn offset(self, dx: i32, dy: i32, dz: i32) -> Self {
    // rust: Self::new(
    // rust: self.x.wrapping_add(dx),
    // rust: self.y.wrapping_add(dy),
    // rust: self.z.wrapping_add(dz),
    // rust: )
}

    // rust: pub const fn section(self) -> SectionPos {
        // Arithmetic shift floors negative coordinates; integer / 16 does not.
    // rust: SectionPos::new(self.x >> 4, self.y >> 4, self.z >> 4)
}

    // rust: pub const fn chunk(self) -> ChunkPos {
    // rust: ChunkPos::new(self.x >> 4, self.z >> 4)
}

    // Section update packet coordinate: X in bits 8..11, Z in 4..7, Y in 0..3.
    // rust: pub const fn section_relative(self) -> u16 {
    // rust: (((self.x & 15) << 8) | ((self.z & 15) << 4) | (self.y & 15)) as u16
}

    // Block-state container index. This is a different layout from packets.
    // rust: pub const fn section_index(self) -> usize {
    // rust: (((self.y & 15) << 8) | ((self.z & 15) << 4) | (self.x & 15)) as usize
}
}

SectionPos :: struct {
    x: i32,
    y: i32,
    z: i32,
}

    // rust: impl SectionPos {
    // rust: pub const fn new(x: i32, y: i32, z: i32) -> Self {
    // rust: Self { x, y, z }
}

    // rust: pub const fn pack(self) -> i64 {
    // rust: (((self.x as u64 & 0x3f_ffff) << 42)
    // rust: | ((self.z as u64 & 0x3f_ffff) << 20)
    // rust: | (self.y as u64 & 0xf_ffff)) as i64
}

    // rust: pub const fn unpack(value: i64) -> Self {
    // rust: Self::new(
    // rust: (value >> 42) as i32,
    // rust: (value << 44 >> 44) as i32,
    // rust: (value << 22 >> 42) as i32,
    // rust: )
}

    // rust: pub const fn relative_to_block(self, relative: u16) -> BlockPos {
    // rust: BlockPos::new(
    // rust: self.x
    // rust: .wrapping_shl(4)
    // rust: .wrapping_add(((relative >> 8) & 15) as i32),
    // rust: self.y.wrapping_shl(4).wrapping_add((relative & 15) as i32),
    // rust: self.z
    // rust: .wrapping_shl(4)
    // rust: .wrapping_add(((relative >> 4) & 15) as i32),
    // rust: )
}
}

ChunkPos :: struct {
    x: i32,
    z: i32,
}

    // rust: impl ChunkPos {
    // rust: pub const fn new(x: i32, z: i32) -> Self {
    // rust: Self { x, z }
}

    // rust: pub const fn pack(self) -> i64 {
    // rust: ((self.x as u32 as u64) | ((self.z as u32 as u64) << 32)) as i64
}

    // rust: pub const fn unpack(value: i64) -> Self {
    // rust: Self::new(value as i32, (value >> 32) as i32)
}

    // rust: pub const fn region(self) -> Self {
    // rust: Self::new(self.x >> 5, self.z >> 5)
}

    // rust: pub const fn region_local(self) -> (u8, u8) {
    // rust: ((self.x & 31) as u8, (self.z & 31) as u8)
}
}

    // rust: mod tests {
//     use super::*;

negative_boundaries_use_floor_division :: proc() {
}
    // rust: for (block, section, local) in [
    // rust: (-17, -2, 15),
    // rust: (-16, -1, 0),
    // rust: (-1, -1, 15),
    // rust: (0, 0, 0),
    // rust: (16, 1, 0),
    // rust: ] {
    // rust: let p = BlockPos::new(block, block, block);
    // rust: assert_eq!(p.section(), SectionPos::new(section, section, section));
    // rust: assert_eq!(p.section_relative(), local * 0x111);
    // rust: assert_eq!(p.section().relative_to_block(p.section_relative()), p);
}
    // rust: assert_eq!(ChunkPos::new(-1, -33).region(), ChunkPos::new(-1, -2));
    // rust: assert_eq!(ChunkPos::new(-1, -33).region_local(), (31, 31));
}

coordinate_formats_are_distinct_and_bijective_in_range :: proc() {
}
    // rust: let mut packet_indices = [false; 4096];
    // rust: let mut storage_indices = [false; 4096];
    // rust: for y in 0..16 {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let p = BlockPos::new(x, y, z);
    // rust: packet_indices[p.section_relative() as usize] = true;
    // rust: storage_indices[p.section_index()] = true;
    // rust: assert_eq!(
    // rust: SectionPos::default().relative_to_block(p.section_relative()),
    // rust: p
    // rust: );
}
}
}
    // rust: assert!(packet_indices.into_iter().all(|x| x));
    // rust: assert!(storage_indices.into_iter().all(|x| x));
    // rust: assert_ne!(
    // rust: BlockPos::new(1, 2, 3).section_relative() as usize,
    // rust: BlockPos::new(1, 2, 3).section_index()
    // rust: );
}

packed_signed_limits_and_java_overflow :: proc() {
}
    // rust: let block = BlockPos::new(-33_554_432, -2048, 33_554_431);
    // rust: assert_eq!(BlockPos::unpack(block.pack()), block);
    // rust: let section = SectionPos::new(-2_097_152, -524_288, 2_097_151);
    // rust: assert_eq!(SectionPos::unpack(section.pack()), section);
    // rust: let chunk = ChunkPos::new(i32::MIN, i32::MAX);
    // rust: assert_eq!(ChunkPos::unpack(chunk.pack()), chunk);
    // rust: assert_eq!(BlockPos::new(i32::MAX, 0, 0).offset(1, 0, 0).x, i32::MIN);
}
}
