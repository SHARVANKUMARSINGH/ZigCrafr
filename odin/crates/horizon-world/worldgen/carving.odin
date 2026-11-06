//! Transpiled from Horizon Rust crate
package horizon_world_carving

import "core:fmt"
import "core:mem"
import "core:math"

// Apply ordered carving-mask intervals to pre-lighting terrain.
// use super::{
    // rust: material_condition::{
    // rust: CompiledSurfaceRule, MaterialConditions, MaterialDensitySources, MaterialRule,
    // rust: MaterialSurfaceQueries,
    // rust: },
    // rust: material_stage::{SurfaceError, TopMaterialInputs, top_material_cell},
    // rust: terrain::{TerrainAquifer, TerrainBlockStates, TerrainChunk, TerrainError},
}
// use crate::{
    // rust: heightmap::HeightmapState,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::{
    // rust: carving::CarvingMask, density::SamplerContext, noise::DensityVolume, position::BlockPos,
    // rust: random::RandomSource,
}
// use std::collections::BTreeSet;

// Per-state predicates resolved once from the world's block registry and
// `minecraft:uncarvable` tag. Keep these bound to the same registry as the chunk.
CarvingBlocks :: struct {
    flags: [dynamic]u8,
}
    // rust: impl CarvingBlocks {
    // rust: pub fn from_registry(
    // rust: registry: &BlockRegistry,
    // rust: uncarvable: &BTreeSet<String>,
    // rust: ) -> Result<Self, TerrainError> {
    // rust: for name in uncarvable.iter().map(String::as_str).chain([
    // rust: "minecraft:grass_block",
    // rust: "minecraft:mycelium",
    // rust: "minecraft:dirt",
    // rust: ]) {
    // rust: if registry.default_state(name).is_none() {
    // rust: return Err(TerrainError::InvalidState);
}
}
    // rust: let flags = (0..registry.len())
    // rust: .map(|index| {
    // rust: let name = &registry.state(BlockStateId(index as u32)).unwrap().name;
    // rust: u8::from(uncarvable.contains(name))
    // rust: | (u8::from(matches!(
    // rust: name.as_str(),
    // rust: "minecraft:grass_block" | "minecraft:mycelium"
    // rust: )) << 1)
    // rust: | (u8::from(name == "minecraft:dirt") << 2)
    // rust: })
    // rust: .collect();
    // rust: Ok(Self { flags })
}
flags :: proc(self: ^Self, state: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.flags
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .ok_or(TerrainError::InvalidState)
}
}

// Visit mask runs in packed order and each interval top to bottom. The filter
// receives local X/Z and absolute Y before any block or aquifer lookup. A run
// remembers grass/mycelium even if its aquifer returns no replacement. Exposed
// dirt below subsequent carved cells is restored through `top_material`.
// Earlier writes, aquifer state and fluid postprocessing survive later errors.
    // rust: pub fn apply_carving_mask<R: RandomSource, S: MaterialSurfaceQueries, B: TerrainBlockStates>(
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: mask: &CarvingMask,
    // rust: rule: MaterialRule,
    // rust: inputs: TopMaterialInputs<'_, R, S>,
    // rust: aquifer: &mut (impl TerrainAquifer + ?Sized),
    // rust: blocks: &CarvingBlocks,
    // rust: filter: impl FnMut([i32; 3]) -> bool,
    // rust: ) -> Result<(), SurfaceError>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
    // rust: apply_carving_mask_shared(
    // rust: chunk, mask, &rule, &mut None, inputs, aquifer, blocks, filter,
    // rust: )
}
// `apply_carving_mask` with the rule compiled once for the chunks `shared`
// serves (`MaterialConditions::add_shared_rule`).
    // rust: pub fn apply_carving_mask_shared<
    // rust: R: RandomSource,
    // rust: S: MaterialSurfaceQueries,
    // rust: B: TerrainBlockStates,
    // rust: >(
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: mask: &CarvingMask,
    // rust: rule: &MaterialRule,
    // rust: shared: &mut Option<CompiledSurfaceRule<R>>,
    // rust: inputs: TopMaterialInputs<'_, R, S>,
    // rust: aquifer: &mut (impl TerrainAquifer + ?Sized),
    // rust: blocks: &CarvingBlocks,
    // rust: mut filter: impl FnMut([i32; 3]) -> bool,
    // rust: ) -> Result<(), SurfaceError>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
    // rust: if mask.is_empty() {
    // rust: return Ok(());
}
    // Restoring the dirt under a carved cell used to build a fresh material
    // worker, compile the whole surface rule and allocate its bindings for every
    // cell. One worker now serves the pass; only the 1x1x1 bindings move.
    // rust: let TopMaterialInputs {
    // rust: generation,
    // rust: root,
    // rust: surface,
    // rust: preliminary_surface,
    // rust: density_context,
    // rust: } = inputs;
    // rust: let volume =
    // rust: DensityVolume::new([1; 3], [0; 3], [1; 3]).map_err(|_| SurfaceError::InvalidVolume)?;
    // rust: let sources = MaterialDensitySources::new(
    // rust: surface,
    // rust: volume,
    // rust: preliminary_surface,
    // rust: SamplerContext::default(),
    // rust: )?;
    // rust: let mut worker =
    // rust: MaterialConditions::<R, _>::with_possible_biomes(generation, root, sources, None);
    // rust: let rule = worker.add_shared_rule(rule, shared)?;
    // rust: let cx = chunk.position().x.wrapping_shl(4);
    // rust: let cz = chunk.position().z.wrapping_shl(4);
    // rust: for column in mask.columns() {
    // rust: let mut found_surface = false;
    // rust: let x = cx.wrapping_add(column.x);
    // rust: let z = cz.wrapping_add(column.z);
    // rust: for y in (column.min_y..=column.max_y).rev() {
    // rust: if !filter([column.x, y, column.z]) {
    // rust: continue;
}
    // rust: let flags = blocks.flags(chunk.block(x, y, z))?;
    // rust: if flags & 1 != 0 {
    // rust: continue;
}
    // rust: found_surface |= flags & 2 != 0;
    // rust: let Some(state) = aquifer
    // rust: .compute_substance(density_context, [x, y, z], 0.)
    // rust: .map_err(TerrainError::from)?
    // rust: else {
    // rust: continue;
}
    // rust: chunk.set_block_worldgen(x, y, z, state)?;
    // rust: if aquifer.should_schedule_fluid_update() && chunk.block_properties(state).has_fluid() {
    // rust: chunk.mark_postprocessing(x, y, z);
}
    // rust: let below = y.wrapping_sub(1);
    // rust: if found_surface && blocks.flags(chunk.block(x, below, z))? & 4 != 0 {
    // rust: let submerged = chunk.block_properties(state).has_fluid();
    // rust: worker.retarget_surface_densities([x, below, z])?;
    // rust: let replacement = top_material_cell(
    // rust: &mut worker,
    // rust: chunk,
    // rust: rule,
    // rust: BlockPos::new(x, below, z),
    // rust: submerged,
    // rust: )?;
    // rust: if let Some(replacement) = replacement {
    // rust: chunk.set_block_worldgen(x, below, z, replacement)?;
    // rust: if chunk.block_properties(replacement).has_fluid() {
    // rust: chunk.mark_postprocessing(x, below, z);
}
}
}
}
}
    // rust: Ok(())
}
