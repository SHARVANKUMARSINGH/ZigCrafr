//! Transpiled from Horizon Rust crate
package horizon_world_fluid_occupancy

import "core:fmt"
import "core:mem"
import "core:math"

// Native section-ordered liquid occupancy over resident registered block states.
// use crate::{
    // rust: chunk::BlockSection,
    // rust: compression::invalid,
    // rust: fluid::FluidState,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::{geometry::Aabb, position::BlockPos};
// use std::{fmt, io};

FluidPresence :: struct {
    registry: ^'r BlockRegistry,
    present: [dynamic]bool,
}
    // rust: impl<'r> FluidPresence<'r> {
new :: proc(registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let present = (0..registry.len())
    // rust: .map(|i| {
    // rust: FluidState::from_block(registry.state(BlockStateId(i as u32)).unwrap())
    // rust: .map(|f| f != FluidState::EMPTY)
    // rust: })
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: Ok(Self { registry, present })
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.registry
}
has_fluid :: proc(self: ^Self, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.present
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("fluid presence state outside registry"))
}
}
    // rust: pub trait FluidOccupancyWorld {
    // rust: type Error;
    // rust: type Chunk: Copy;
minimum_section_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
maximum_section_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Native getChunk, including calls when the requested Y interval is empty.
chunk :: proc(self: ^Self, x: i32, z: i32) -> R {
    // Ported from Horizon
    return {}
}
section :: proc(self: ^Self, chunk: Self::Chunk, y: i32) -> R {
    // Ported from Horizon
    return {}
}
minimum_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
maximum_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
}
FluidOccupancyError :: enum {
    World(E),
    Data(io::Error),
    NonFiniteBounds,
    BudgetExceeded,
}
    // rust: impl<E: fmt::Display> fmt::Display for FluidOccupancyError<E> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::NonFiniteBounds => f.write_str("nonfinite fluid query bounds"),
    // rust: Self::BudgetExceeded => f.write_str("fluid query budget exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for FluidOccupancyError<E> {}
    // rust: fn spend<E>(budget: &mut usize) -> Result<(), FluidOccupancyError<E>> {
    // rust: if *budget == 0 {
    // rust: return Err(FluidOccupancyError::BudgetExceeded);
}
    // rust: *budget -= 1;
    // rust: Ok(())
}
// Inclusive floored AABB endpoints, as in LevelReader.findBlocksIn. Budget
// counts chunk requests, section requests and inspected cells. Exhaustion is an
// explicit error, never an empty-world result. Dry palettes avoid cell scans.
    // rust: pub fn contains_any_liquid<W: FluidOccupancyWorld>(
    // rust: world: &mut W,
    // rust: registry: &FluidPresence<'_>,
    // rust: bounds: Aabb,
    // rust: mut budget: usize,
    // rust: ) -> Result<bool, FluidOccupancyError<W::Error>> {
//     use FluidOccupancyError::{Data, World};
    // rust: let a = bounds.min_position();
    // rust: let b = bounds.max_position();
    // rust: if [a.x, a.y, a.z, b.x, b.y, b.z]
    // rust: .iter()
    // rust: .any(|v| !v.is_finite())
    // rust: {
    // rust: return Err(FluidOccupancyError::NonFiniteBounds);
}
    // rust: let a = BlockPos::new(a.x.floor() as i32, a.y.floor() as i32, a.z.floor() as i32);
    // rust: let b = BlockPos::new(b.x.floor() as i32, b.y.floor() as i32, b.z.floor() as i32);
    // rust: let low = BlockPos::new(a.x.min(b.x), a.y.min(b.y), a.z.min(b.z));
    // rust: let high = BlockPos::new(a.x.max(b.x), a.y.max(b.y), a.z.max(b.z));
    // rust: let min_y = world.minimum_section_y().map_err(World)?.max(low.y >> 4);
    // rust: let max_y = world.maximum_section_y().map_err(World)?.min(high.y >> 4);
    // rust: for x in (low.x >> 4)..=(high.x >> 4) {
    // rust: for z in (low.z >> 4)..=(high.z >> 4) {
    // rust: spend(&mut budget)?;
    // rust: let chunk = world.chunk(x, z).map_err(World)?;
    // rust: for y in min_y..=max_y {
    // rust: spend(&mut budget)?;
    // rust: let section = world.section(chunk, y).map_err(World)?;
    // rust: if !std::ptr::eq(section.registry(), registry.registry) {
    // rust: return Err(Data(invalid("fluid query section registry mismatch")));
}
    // rust: if !section.any_state(|id| registry.present[id.0 as usize]) {
    // rust: continue;
}
    // rust: let origin = BlockPos::new(x.wrapping_shl(4), y.wrapping_shl(4), z.wrapping_shl(4));
    // rust: let min = BlockPos::new(
    // rust: origin.x.max(low.x) & 15,
    // rust: origin.y.max(low.y) & 15,
    // rust: origin.z.max(low.z) & 15,
    // rust: );
    // rust: let max = BlockPos::new(
    // rust: origin.x.wrapping_add(15).min(high.x) & 15,
    // rust: origin.y.wrapping_add(15).min(high.y) & 15,
    // rust: origin.z.wrapping_add(15).min(high.z) & 15,
    // rust: );
    // rust: for sy in min.y..=max.y {
    // rust: for sz in min.z..=max.z {
    // rust: for sx in min.x..=max.x {
    // rust: spend(&mut budget)?;
    // rust: let id = section
    // rust: .get((sy * 256 + sz * 16 + sx) as usize)
    // rust: .map_err(Data)?;
    // rust: if registry.present[id.0 as usize] {
    // rust: return Ok(true);
}
}
}
}
}
}
}
    // Native scans outside world height only if the predicate accepts air. It
    // still evaluates both height guards; the liquid predicate rejects air.
    // rust: world.minimum_y().map_err(World)?;
    // rust: world.maximum_y().map_err(World)?;
    // rust: Ok(false)
}
