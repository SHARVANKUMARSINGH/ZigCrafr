//! Transpiled from Horizon Rust crate
//! Module: horizon-world_layer
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Layer scanning and its interleaved count-provider sampling.
// use super::{LayerBlock, PlacementContext, PlacementError};
// use crate::{heightmap::HeightmapType, worldgen::value_provider::IntProvider};
// use horizon_core::random::RandomSource;

    // rust: pub(super) fn modify<R: RandomSource, E>(
    // rust: count: &IntProvider,
    // rust: context: &mut impl PlacementContext,
    // rust: random: &mut R,
    // rust: position: [i32; 3],
    // rust: emit: &mut impl FnMut(&mut R, [i32; 3]) -> Result<(), E>,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<(), PlacementError<E>> {
    // rust: let mut layer = 0_i32;
    // rust: loop {
    // rust: let mut found = false;
    // rust: let mut attempt = 0_i32;
    // rust: loop {
    // rust: take(remaining)?;
            // Native samples on every loop condition, including the final check.
    // rust: if attempt >= count.sample(random)? {
    // rust: break;
}
    // rust: let x = position[0].wrapping_add(random.next_int_bound(16)?);
    // rust: let z = position[2].wrapping_add(random.next_int_bound(16)?);
    // rust: let y = context.height(HeightmapType::MotionBlocking, x, z)?;
    // rust: if let Some(y) = ground(context, [x, y, z], layer, remaining)? {
    // rust: emit(random, [x, y, z]).map_err(PlacementError::Output)?;
    // rust: found = true;
}
    // rust: attempt = attempt.wrapping_add(1);
}
    // rust: layer = layer.wrapping_add(1);
    // rust: if !found {
    // rust: return Ok(());
}
}
}
    // rust: fn ground<E>(
    // rust: context: &mut impl PlacementContext,
    // rust: position: [i32; 3],
    // rust: layer: i32,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Option<i32>, PlacementError<E>> {
    // rust: let [x, mut y, z] = position;
    // rust: let mut above = context.layer_block(position)?;
    // rust: let mut found = 0_i32;
    // rust: while y >= context.min_y()?.wrapping_add(1) {
    // rust: take(remaining)?;
    // rust: let below = context.layer_block([x, y.wrapping_sub(1), z])?;
    // rust: if below == LayerBlock::Ground && above == LayerBlock::Empty {
    // rust: if found == layer {
    // rust: return Ok((y != i32::MAX).then_some(y));
}
    // rust: found = found.wrapping_add(1);
}
    // rust: above = below;
    // rust: y = y.wrapping_sub(1);
}
    // rust: Ok(None)
}
    // rust: fn take<E>(remaining: &mut usize) -> Result<(), PlacementError<E>> {
    // rust: if *remaining == 0 {
    // rust: return Err(PlacementError::WorkLimit);
}
    // rust: *remaining -= 1;
    // rust: Ok(())
}
