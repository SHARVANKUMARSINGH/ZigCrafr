//! Transpiled from Horizon Rust crate
//! Module: horizon-client_islands
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Small End islands at far distances.
//!
//! The End's small islands are decoration (`minecraft:end_island_decorated` in
//! `minecraft:small_end_islands`), not terrain density. The generator replays
//! vanilla's decoration seed and feature on a no-op world, so the origins and
//! heights are exact without generating chunks; the visible shape is the cone
//! the direct sampler always drew. Refined, visited and saved chunks still win.
// use super::vegetation::hash;
// use crate::{
    // rust: fast_hash::FxHashMap,
    // rust: lod::{Column, Span, Surface},
    // rust: vanillagen::VanillaTerrain,
}
// use horizon_core::position::ChunkPos;
// use horizon_world::registry::BlockStateId;
// use std::{collections::VecDeque, sync::Arc};

/// A cell is drawn as a whole column; past this width a 4–6 block island would
/// be a slab. At 8 blocks a whole island is about one cell, which is enough at
/// the distance where direct sampling takes over.
pub const END_ISLAND_CELL: i32 = 8;
/// `EndIslandFeature` starts at radius 4..=6.
pub const MAX_RADIUS: i32 = 6;
pub const CACHE: usize = 4096;

pub const Island = struct {
    x: i32,
    z: i32,
    y: i32,
    /// Top radius, 4..=6 blocks.
    radius: i32,
    /// Per-layer shrink in half blocks: 1 = 0.5, 3 = 1.5.
    shrink: i32,
};

    // rust: pub(super) struct EndIslands {
    // rust: generator: Arc<VanillaTerrain>,
    // rust: end_stone: Option<BlockStateId>,
    // rust: cache: FxHashMap<(i32, i32), Arc<[Island]>>,
    // rust: order: VecDeque<(i32, i32)>,
}
    // rust: impl EndIslands {
    // rust: pub(super) fn new(generator: Arc<VanillaTerrain>) -> Self {
    // rust: let end_stone = generator
    // rust: .generator
    // rust: .data()
    // rust: .registry()
    // rust: .default_state("minecraft:end_stone");
    // rust: Self {
    // rust: generator,
    // rust: end_stone,
    // rust: cache: FxHashMap::default(),
    // rust: order: VecDeque::new(),
}
}
    /// Independent sampling state: the generator is shared, the cache is not.
    // rust: pub(super) fn fork(&self) -> Self {
    // rust: Self {
    // rust: generator: self.generator.clone(),
    // rust: end_stone: self.end_stone,
    // rust: cache: FxHashMap::default(),
    // rust: order: VecDeque::new(),
}
}
    /// Paint the small islands of the chunks around a direct-sampled void cell.
    // rust: pub(super) fn apply(&mut self, column: &mut Column, x: i32, z: i32, width: i32, light: u16) {
    // rust: let Some(state) = self.end_stone else {
    // rust: return;
}
    // rust: if width > END_ISLAND_CELL || width <= 0 || column.surface.is_some() {
    // rust: return;
}
    // rust: let (last_x, last_z) = (x + width - 1, z + width - 1);
    // rust: let mut spans = Vec::new();
    // rust: for cz in (z - MAX_RADIUS).div_euclid(16)..=(last_z + MAX_RADIUS).div_euclid(16) {
    // rust: for cx in (x - MAX_RADIUS).div_euclid(16)..=(last_x + MAX_RADIUS).div_euclid(16) {
    // rust: let islands = self.layout(cx, cz);
    // rust: for island in islands.iter() {
    // rust: let nx = island.x.clamp(x, last_x);
    // rust: let nz = island.z.clamp(z, last_z);
    // rust: let d2 = (nx - island.x) * (nx - island.x) + (nz - island.z) * (nz - island.z);
    // rust: let Some(bottom) = island_bottom(island, d2) else {
    // rust: continue;
}
    // rust: spans.push((bottom, island.y + 1));
}
}
}
    // rust: if spans.is_empty() {
    // rust: return;
}
    // rust: spans.sort_unstable_by_key(|span| span.0);
    // rust: let mut merged: Vec<(i32, i32)> = Vec::with_capacity(spans.len());
    // rust: for (min, max) in spans {
    // rust: if let Some(last) = merged.last_mut()
    // rust: && min <= last.1
    // rust: {
    // rust: last.1 = last.1.max(max);
    // rust: } else {
    // rust: merged.push((min, max));
}
}
    // rust: for &(min, max) in &merged {
    // rust: column.push(Span {
    // rust: min: min as i16,
    // rust: max: max as i16,
    // rust: state,
    // rust: biome: 0,
    // rust: light,
    // rust: });
}
    // rust: let top = merged.last().unwrap().1;
    // rust: column.surface = Some(Surface {
    // rust: height: top,
    // rust: state,
    // rust: water: None,
    // rust: biome: 0,
    // rust: });
}
pub fn layout(self: *Self, cx: i32, cz: i32) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (cx, cz);
    // rust: if let Some(islands) = self.cache.get(&key) {
    // rust: return islands.clone();
}
    // rust: let origins = self
    // rust: .generator
    // rust: .generator
    // rust: .end_island_origins(ChunkPos::new(cx, cz));
    // rust: let islands: Arc<[Island]> = origins
    // rust: .into_iter()
    // rust: .map(|[x, y, z]| {
    // rust: let n = hash(
    // rust: self.generator.seed as u64
    // rust: ^ (x as u64).rotate_left(17)
    // rust: ^ (z as u64).rotate_left(33)
    // rust: ^ (y as u64),
    // rust: x,
    // rust: z,
    // rust: );
    // rust: Island {
    // rust: x,
    // rust: z,
    // rust: y,
    // rust: radius: 4 + (n % 3) as i32,
    // rust: shrink: 1 + 2 * ((n >> 8) & 1) as i32,
}
    // rust: })
    // rust: .collect();
    // rust: self.cache.insert(key, islands.clone());
    // rust: self.order.push_back(key);
    // rust: while self.cache.len() > CACHE {
    // rust: if let Some(old) = self.order.pop_front() {
    // rust: self.cache.remove(&old);
}
}
    // rust: islands
}
    // rust: pub(super) fn origins(&self, cx: i32, cz: i32) -> Vec<[i32; 3]> {
    // rust: self.generator
    // rust: .generator
    // rust: .end_island_origins(ChunkPos::new(cx, cz))
}
}

/// The lowest layer of the island's cone that reaches a column at squared
/// distance `d2`. The top layer is always `island.y` when this returns `Some`.
pub fn island_bottom(island: *Island, d2: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut half = island.radius * 2;
    // rust: let mut y = island.y;
    // rust: let mut bottom = None;
    // rust: while half > 1 {
    // rust: if d2 * 4 <= half * half {
    // rust: bottom = Some(y);
}
    // rust: half -= island.shrink;
    // rust: y -= 1;
}
    // rust: bottom
}

    // rust: mod tests {
//     use super::*;

pub fn island_columns_are_cones_with_a_flat_top() void {
}
    // rust: let island = Island {
    // rust: x: 0,
    // rust: z: 0,
    // rust: y: 60,
    // rust: radius: 4,
    // rust: shrink: 1,
}
    // rust: assert_eq!(island_bottom(&island, 0), Some(54));
    // rust: assert_eq!(island_bottom(&island, 3), Some(56));
    // rust: assert_eq!(island_bottom(&island, 16), Some(60));
    // rust: assert_eq!(island_bottom(&island, 17), None);
    // rust: let steep = Island {
    // rust: shrink: 3,
    // rust: ..island
}
    // rust: assert_eq!(island_bottom(&steep, 0), Some(58));
}
}
