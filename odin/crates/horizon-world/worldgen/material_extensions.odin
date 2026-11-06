//! Transpiled from Horizon Rust crate
package horizon_world_material_extensions

import "core:fmt"
import "core:mem"
import "core:math"

// Eroded-badlands pillars and frozen-ocean icebergs, before chunk integration.
// use super::biome_temperature::BiomeTemperature;
// use crate::registry::BlockStateId;
// use horizon_core::{
    // rust: noise::Noise,
    // rust: position::BlockPos,
    // rust: random::{PositionalRandom, RandomSource},
}
// use std::sync::Arc;

// Reads and writes retain provider order. The chunk adapter supplies vanilla
// out-of-height reads and generation-height write clipping.
    // rust: pub trait MaterialColumn {
    // rust: type Error;
block :: proc(self: ^Self, y: i32) -> R {
    // Ported from Horizon
    return {}
}
set_block :: proc(self: ^Self, y: i32, state: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
is_air :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
same_block :: proc(self: ^Self, left: BlockStateId, right: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
}
ExtensionBlocks :: struct {
    default: BlockStateId,
    water: BlockStateId,
    packed_ice: BlockStateId,
    snow: BlockStateId,
}
ExtensionNoises :: struct {
    badlands_surface: ^dyn Noise,
    badlands_pillar: ^dyn Noise,
    badlands_roof: ^dyn Noise,
    iceberg_surface: ^dyn Noise,
    iceberg_pillar: ^dyn Noise,
    iceberg_roof: ^dyn Noise,
}
ExtensionError :: enum {
    Column(E),
    IterationLimit,
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for ExtensionError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Column(error) => error.fmt(f),
    // rust: Self::IterationLimit => f.write_str("material column iteration bound exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for ExtensionError<E> {}
    // rust: impl<E> From<E> for ExtensionError<E> {
from :: proc(error: E) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Column(error)
}
}

// Random is the world's root positional factory. Noises and biome temperatures
// must be configured for the same immutable world-generation settings.
MaterialExtensions :: struct {
    random: P,
    blocks: ExtensionBlocks,
    noises: ExtensionNoises,
    sea_level: i32,
}
    // rust: impl<P: PositionalRandom> MaterialExtensions<P> {
    // rust: pub fn new(
    // rust: random: P,
    // rust: blocks: ExtensionBlocks,
    // rust: noises: ExtensionNoises,
    // rust: sea_level: i32,
    // rust: ) -> Self {
    // rust: Self {
    // rust: random,
    // rust: blocks,
    // rust: noises,
    // rust: sea_level,
}
}
    // rust: pub fn eroded_badlands<C: MaterialColumn>(
    // rust: &self,
    // rust: column: &mut C,
    // rust: x: i32,
    // rust: z: i32,
    // rust: surface_y: i32,
    // rust: min_y: i32,
    // rust: ) -> Result<(), ExtensionError<C::Error>> {
    // rust: let x = f64::from(x);
    // rust: let z = f64::from(z);
    // rust: let amplitude = java_min(
    // rust: (f64::from(self.noises.badlands_surface.get3(x, 0.0, z)) * 8.25).abs(),
    // rust: f64::from(self.noises.badlands_pillar.get3(x * 0.2, 0.0, z * 0.2) * 15.0),
    // rust: );
    // rust: if amplitude <= 0.0 {
    // rust: return Ok(());
}
    // rust: let roof = (f64::from(self.noises.badlands_roof.get3(x * 0.75, 0.0, z * 0.75)) * 1.5).abs();
    // rust: let top = (64.0 + java_min(amplitude * amplitude * 2.5, (roof * 50.0).ceil() + 24.0))
    // rust: .floor() as i32;
    // rust: if surface_y > top {
    // rust: return Ok(());
}
    // rust: let mut budget = 1 << 20;
    // rust: let mut y = top;
    // rust: while y >= min_y {
    // rust: tick(&mut budget)?;
    // rust: let state = column.block(y)?;
    // rust: if column.same_block(state, self.blocks.default) {
    // rust: break;
}
    // rust: if column.same_block(state, self.blocks.water) {
    // rust: return Ok(());
}
    // rust: y = y.wrapping_sub(1);
}
    // rust: y = top;
    // rust: while y >= min_y {
    // rust: tick(&mut budget)?;
    // rust: let state = column.block(y)?;
    // rust: if !column.is_air(state) {
    // rust: break;
}
    // rust: column.set_block(y, self.blocks.default)?;
    // rust: y = y.wrapping_sub(1);
}
    // rust: Ok(())
}
    // rust: pub fn frozen_ocean<C: MaterialColumn>(
    // rust: &self,
    // rust: column: &mut C,
    // rust: biome: &mut BiomeTemperature,
    // rust: position: [i32; 2],
    // rust: surface_y: i32,
    // rust: minimum_surface_y: i32,
    // rust: ) -> Result<(), ExtensionError<C::Error>> {
    // rust: self.frozen_ocean_with_melt(
    // rust: column,
    // rust: position,
    // rust: surface_y,
    // rust: minimum_surface_y,
    // rust: |position, sea| Ok(biome.should_melt_frozen_ocean_iceberg_slightly(position, sea)),
    // rust: )
}
    // Defer the biome lookup until the native noise/height checks reach it.
    // rust: pub fn frozen_ocean_with_melt<C: MaterialColumn>(
    // rust: &self,
    // rust: column: &mut C,
    // rust: position: [i32; 2],
    // rust: surface_y: i32,
    // rust: minimum_surface_y: i32,
    // rust: melt: impl FnOnce(BlockPos, i32) -> Result<bool, C::Error>,
    // rust: ) -> Result<(), ExtensionError<C::Error>> {
    // rust: let [x, z] = position;
    // rust: let dx = f64::from(x);
    // rust: let dz = f64::from(z);
    // rust: let amplitude = java_min(
    // rust: (f64::from(self.noises.iceberg_surface.get3(dx, 0.0, dz)) * 8.25).abs(),
    // rust: f64::from(self.noises.iceberg_pillar.get3(dx * 1.28, 0.0, dz * 1.28) * 15.0),
    // rust: );
    // rust: if amplitude <= 1.8 {
    // rust: return Ok(());
}
    // rust: let roof =
    // rust: (f64::from(self.noises.iceberg_roof.get3(dx * 1.17, 0.0, dz * 1.17)) * 1.5).abs();
    // rust: let mut height = java_min(amplitude * amplitude * 1.2, (roof * 40.0).ceil() + 14.0);
    // rust: if melt(BlockPos::new(x, self.sea_level, z), self.sea_level)? {
    // rust: height -= 2.0;
}
    // rust: if height <= 2.0 {
    // rust: return Ok(());
}
    // rust: let bottom = f64::from(self.sea_level) - height - 7.0;
    // rust: let top = height + f64::from(self.sea_level);
    // rust: let mut random = self.random.at(BlockPos::new(x, 0, z));
    // rust: let snow_limit = 2 + random.next_int_bound(4).unwrap();
    // rust: let snow_height = self
    // rust: .sea_level
    // rust: .wrapping_add(18)
    // rust: .wrapping_add(random.next_int_bound(10).unwrap());
    // rust: let mut snow_count = 0;
    // rust: let mut y = surface_y.max((top as i32).wrapping_add(1));
    // rust: let mut budget = 1 << 20;
    // rust: while y >= minimum_surface_y {
    // rust: tick(&mut budget)?;
    // rust: let state = column.block(y)?;
    // rust: let air = column.is_air(state) && y < (top as i32) && random.next_double() > 0.01;
    // rust: let fill = if air {
    // rust: true
    // rust: } else {
                // The second getBlock is observable even when the first read
                // found air but failed its height or random test.
    // rust: let state = column.block(y)?;
    // rust: column.same_block(state, self.blocks.water)
    // rust: && y > (bottom as i32)
    // rust: && y < self.sea_level
    // rust: && random.next_double() > 0.15
}
    // rust: if fill {
    // rust: let state = if snow_count <= snow_limit && y > snow_height {
    // rust: snow_count += 1;
    // rust: self.blocks.snow
    // rust: } else {
    // rust: self.blocks.packed_ice
}
    // rust: column.set_block(y, state)?;
}
    // rust: y = y.wrapping_sub(1);
}
    // rust: Ok(())
}
}
    // rust: fn tick<E>(remaining: &mut usize) -> Result<(), ExtensionError<E>> {
    // rust: if *remaining == 0 {
    // rust: return Err(ExtensionError::IterationLimit);
}
    // rust: *remaining -= 1;
    // rust: Ok(())
}
java_min :: proc(a: f64, b: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if b.is_nan() {
    // rust: b
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f64::from_bits(a.to_bits() | b.to_bits())
    // rust: } else if a <= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
