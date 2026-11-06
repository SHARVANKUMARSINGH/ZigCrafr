//! Transpiled from Horizon Rust crate
package horizon_world_material_surface

import "core:fmt"
import "core:mem"
import "core:math"

// Seeded terracotta bands and the material system's surface-noise queries.
// use crate::registry::{BlockRegistry, BlockStateId};
// use horizon_core::{
    // rust: noise::Noise,
    // rust: random::{PositionalRandom, RandomSource},
}
// use std::sync::Arc;

ClayBandBlocks :: struct {
    terracotta: BlockStateId,
    orange: BlockStateId,
    yellow: BlockStateId,
    brown: BlockStateId,
    red: BlockStateId,
    white: BlockStateId,
    light_gray: BlockStateId,
}
    // rust: impl ClayBandBlocks {
from_registry :: proc(registry: ^BlockRegistry) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Self {
    // rust: terracotta: registry.default_state("minecraft:terracotta")?,
    // rust: orange: registry.default_state("minecraft:orange_terracotta")?,
    // rust: yellow: registry.default_state("minecraft:yellow_terracotta")?,
    // rust: brown: registry.default_state("minecraft:brown_terracotta")?,
    // rust: red: registry.default_state("minecraft:red_terracotta")?,
    // rust: white: registry.default_state("minecraft:white_terracotta")?,
    // rust: light_gray: registry.default_state("minecraft:light_gray_terracotta")?,
    // rust: })
}
}
ClayBands :: struct {
    // rust: impl ClayBands {
    // The input is MaterialSystem's clay_bands child stream. Every conditional
    // random draw and overwrite retains vanilla order.
generate :: proc(random: ^impl RandomSource, blocks: ClayBandBlocks) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut bands = [blocks.terracotta; 192];
    // rust: let mut i = 0;
    // rust: while i < bands.len() {
    // rust: i += random.next_int_bound(5).unwrap() as usize + 1;
    // rust: if i < bands.len() {
    // rust: bands[i] = blocks.orange;
}
    // rust: i += 1;
}
    // rust: Self::make_bands(random, &mut bands, 1, blocks.yellow);
    // rust: Self::make_bands(random, &mut bands, 2, blocks.brown);
    // rust: Self::make_bands(random, &mut bands, 1, blocks.red);
    // rust: let count = random.next_int_between_inclusive(9, 15).unwrap();
    // rust: let mut position = 0;
    // rust: for _ in 0..count {
    // rust: if position >= bands.len() {
    // rust: break;
}
    // rust: bands[position] = blocks.white;
    // rust: if position > 1 && random.next_boolean() {
    // rust: bands[position - 1] = blocks.light_gray;
}
    // rust: if position + 1 < bands.len() && random.next_boolean() {
    // rust: bands[position + 1] = blocks.light_gray;
}
    // rust: position += random.next_int_bound(16).unwrap() as usize + 4;
}
    // rust: Self(bands)
}
    // rust: fn make_bands(
    // rust: random: &mut impl RandomSource,
    // rust: bands: &mut [BlockStateId; 192],
    // rust: base_width: usize,
    // rust: state: BlockStateId,
    // rust: ) {
    // rust: let count = random.next_int_between_inclusive(6, 15).unwrap();
    // rust: for _ in 0..count {
    // rust: let width = base_width + random.next_int_bound(3).unwrap() as usize;
    // rust: let start = random.next_int_bound(192).unwrap() as usize;
    // rust: let end = (start + width).min(bands.len());
    // rust: bands[start..end].fill(state);
}
}
states :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.0
}
    // Preserve Java's signed remainder. Extreme or unsupported negative heights
    // can produce an invalid index, which returns None instead of an exception.
at_noise :: proc(self: ^Self, y: i32, noise: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let offset = round_float(noise * 4.);
    // rust: let index = y.wrapping_add(offset).wrapping_add(192) % 192;
    // rust: self.0.get(index as usize).copied()
}
}
round_float :: proc(value: f32) -> i {
    // Ported from Horizon
    return {}
}
    // f64 retains every relevant half-integer boundary of a float that fits an
    // int. Rust's cast supplies Java's NaN-to-zero and saturating endpoints.
    // rust: (f64::from(value) + 0.5).floor() as i32
}
MaterialSurface :: struct {
    bands: ClayBands,
    random: P,
    clay_offset: ^dyn Noise,
    surface: ^dyn Noise,
    secondary: ^dyn Noise,
}
    // rust: impl<P: PositionalRandom> MaterialSurface<P> {
    // `random` is the world's root positional factory, not a surface child.
    // rust: pub fn new(
    // rust: random: P,
    // rust: blocks: ClayBandBlocks,
    // rust: clay_offset: Arc<dyn Noise>,
    // rust: surface: Arc<dyn Noise>,
    // rust: secondary: Arc<dyn Noise>,
    // rust: ) -> Self {
    // rust: let bands = ClayBands::generate(&mut random.from_hash_of("minecraft:clay_bands"), blocks);
    // rust: Self {
    // rust: bands,
    // rust: random,
    // rust: clay_offset,
    // rust: surface,
    // rust: secondary,
}
}
bands :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.bands
}
band :: proc(self: ^Self, z]: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.bands
    // rust: .at_noise(y, self.clay_offset.get3(f64::from(x), 0., f64::from(z)))
}
surface_depth :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let noise = f64::from(self.surface.get3(f64::from(x), 0., f64::from(z)));
    // rust: ((noise * 2.75 + 3.)
    // rust: + self
    // rust: .random
    // rust: .at(horizon_core::position::BlockPos::new(x, 0, z))
    // rust: .next_double()
    // rust: * 0.25) as i32
}
surface_secondary :: proc(self: ^Self, x: i32, z: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(self.secondary.get3(f64::from(x), 0., f64::from(z)))
}
}
