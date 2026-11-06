//! Transpiled from Horizon Rust crate
package horizon_client_native_world_read

import "core:fmt"
import "core:mem"
import "core:math"

// Read-only block and tag queries for native server hooks.
// use super::{Dim, Game};
// use horizon_client::mod_api::NativeLifecycleContext;
// use horizon_client::{
    // rust: items::{ItemStack, Items},
    // rust: world::World,
}
// use horizon_world::{chunk::BlockState, registry::BlockRegistry};

// Why a server block or tag cannot be read.
NativeBlockReadError :: enum {
    // The context is stale or the call is outside its server tick hook.
    InactiveContext,
    // Tag queries require an authoritative server.
    NotServer,
    // The world has not loaded its tag tables yet.
    TagsUnavailable,
    // The dimension is unknown or is not currently open on the server.
    UnavailableDimension,
    OutOfBounds,
    Unloaded,
    InvalidState,
}

    // rust: impl Game<'_> {
    // The world lock is installed after its tag tables are built.
native_tag_items :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.options.execution_role.is_client() {
    // rust: return Err(NativeBlockReadError::NotServer);
}
    // rust: if self.session_lock.is_none() {
    // rust: return Err(NativeBlockReadError::TagsUnavailable);
}
    // rust: Ok(self.items())
}

    // Test a block state's name in an active server tick hook. API 28.
    // rust: pub(super) fn native_block_in_tag(
    // rust: &self,
    // rust: context: &NativeLifecycleContext,
    // rust: state: &BlockState,
    // rust: tag: &str,
    // rust: ) -> Result<bool, NativeBlockReadError> {
    // rust: if !self.native_lifecycle.permits_read(context) {
    // rust: return Err(NativeBlockReadError::InactiveContext);
}
    // rust: self.native_server_block_in_tag(state, tag)
}

    // Test an item stack in an active server tick hook. API 28.
    // rust: pub(super) fn native_item_in_tag(
    // rust: &self,
    // rust: context: &NativeLifecycleContext,
    // rust: stack: &ItemStack,
    // rust: tag: &str,
    // rust: ) -> Result<bool, NativeBlockReadError> {
    // rust: if !self.native_lifecycle.permits_read(context) {
    // rust: return Err(NativeBlockReadError::InactiveContext);
}
    // rust: self.native_server_item_in_tag(stack, tag)
}

    // Test a block state's name against the server's merged block tags.
    // rust: pub(super) fn native_server_block_in_tag(
    // rust: &self,
    // rust: state: &BlockState,
    // rust: tag: &str,
    // rust: ) -> Result<bool, NativeBlockReadError> {
    // rust: Ok(self.native_tag_items()?.block_in_tag(tag, &state.name))
}

    // Test an item stack against the server's merged item tags.
    // rust: pub(super) fn native_server_item_in_tag(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: tag: &str,
    // rust: ) -> Result<bool, NativeBlockReadError> {
    // rust: let items = self.native_tag_items()?;
    // rust: let item = if stack.count == 0 {
    // rust: "minecraft:air"
    // rust: } else {
    // rust: &stack.item
}
    // rust: Ok(items.item_in_tag(tag, item))
}

    // Whether block `block` (`minecraft:oak_log`, as `Host::block` names
    // one) is in block tag `tag` (`minecraft:logs`, or a mod's
    // `create:fan_transparent`) of the server's merged tags, as
    // `BlockState.is(TagKey)`: what `native_server_block_in_tag` answers for
    // a state of that block, from any server hook. API @API:host_bridge@.
    // rust: pub(super) fn native_block_name_in_tag(
    // rust: &self,
    // rust: block: &str,
    // rust: tag: &str,
    // rust: ) -> Result<bool, NativeBlockReadError> {
    // rust: Ok(self.native_tag_items()?.block_in_tag(tag, block))
}

    // Read a loaded block in a server tick hook, without loading a chunk.
    // The returned name and properties are owned and remain valid after the hook.
    // rust: pub(super) fn native_server_block(
    // rust: &self,
    // rust: context: &NativeLifecycleContext,
    // rust: dimension: &str,
    // rust: pos: [i32; 3],
    // rust: ) -> Result<BlockState, NativeBlockReadError> {
    // rust: if !self.native_lifecycle.permits_read(context) {
    // rust: return Err(NativeBlockReadError::InactiveContext);
}
    // rust: let dim = match dimension {
    // rust: "minecraft:overworld" => Dim::Overworld,
    // rust: "minecraft:the_nether" => Dim::Nether,
    // rust: "minecraft:the_end" => Dim::End,
    // rust: _ => return Err(NativeBlockReadError::UnavailableDimension),
}
    // rust: let world = if dim == self.dim {
    // rust: Some(&self.world)
    // rust: } else {
    // rust: self.levels.parked_world(dim)
}
    // rust: .ok_or(NativeBlockReadError::UnavailableDimension)?;
    // rust: read_block(world, self.pack.assets.registry, pos)
}

    // The current of the fluid at `pos` in `dimension`
    // (`FluidState.getFlow(level, pos)`), normalised: the push an item in it
    // gets, a water wheel's speed from the water around it. Zero where there
    // is no fluid or it doesn't move; none where the chunk isn't loaded or
    // the dimension isn't available (a client has only the level it is in,
    // a server also its parked ones), so a caller can keep its last answer.
    // API @API:fluid_flow@.
    // rust: pub(super) fn native_fluid_flow(&self, dimension: &str, pos: [i32; 3]) -> Option<[f64; 3]> {
    // rust: let dim = match dimension {
    // rust: "minecraft:overworld" => Dim::Overworld,
    // rust: "minecraft:the_nether" => Dim::Nether,
    // rust: "minecraft:the_end" => Dim::End,
    // rust: _ => return None,
}
    // rust: let world = if dim == self.dim {
    // rust: &self.world
    // rust: } else {
    // rust: self.levels.parked_world(dim)?
}
    // rust: if !world.loaded(pos[0], pos[2]) {
    // rust: return None;
}
    // rust: Some(horizon_client::entities::fluid_flow(
    // rust: world,
    // rust: &self.res.motion().fluids,
    // rust: pos,
    // rust: ))
}
}

// Resolve an existing world state, preserving unloaded and invalid states.
    // rust: fn read_block(
    // rust: world: &World,
    // rust: registry: &BlockRegistry,
    // rust: [x, y, z]: [i32; 3],
    // rust: ) -> Result<BlockState, NativeBlockReadError> {
    // rust: if !(-30_000_000..30_000_000).contains(&x)
    // rust: || !(-30_000_000..30_000_000).contains(&z)
    // rust: || !(world.shape.min_y..world.shape.max_y()).contains(&y)
    // rust: {
    // rust: return Err(NativeBlockReadError::OutOfBounds);
}
    // rust: if !world.loaded(x, z) {
    // rust: return Err(NativeBlockReadError::Unloaded);
}
    // rust: registry
    // rust: .state(world.block(x, y, z))
    // rust: .cloned()
    // rust: .ok_or(NativeBlockReadError::InvalidState)
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::chunk::Chunk;
//     use horizon_world::registry::BlockStateId;
//     use std::sync::Arc;

reads_only_loaded_in_bounds_states :: proc() {
}
    // rust: let facts = br#"{"defaults":{"minecraft:air":0,"test:pillar":1},"states":[
    // rust: ["air",true,false,"","minecraft:air"],
    // rust: ["pillar",false,false,"",{"id":"test:pillar","properties":{"axis":"x"}}]
    // rust: ]}"#;
    // rust: let registry = BlockRegistry::from_facts_json(&facts[..]).unwrap();
    // rust: let mut world = World::new(BlockStateId(0), 0);
    // rust: world.chunks.insert((-1, 0), Arc::new(Chunk::empty(-1, 0)));
    // rust: world.set(-1, 64, 1, BlockStateId(1)).unwrap();
        // The Nether's build range starts at y 0 (its level's shape).
    // rust: let mut nether = World::new(BlockStateId(0), 0);
    // rust: nether.shape = horizon_client::chunk::LevelShape::NETHER;
    // rust: nether.chunks.insert((-1, 0), Arc::new(Chunk::empty(-1, 0)));
    // rust: let block = read_block(&world, &registry, [-1, 64, 1]).unwrap();
    // rust: assert_eq!(block.name, "test:pillar");
    // rust: assert_eq!(block.properties["axis"], "x");
    // rust: assert_eq!(
    // rust: read_block(&world, &registry, [-1, 65, 1]).unwrap().name,
    // rust: "minecraft:air"
    // rust: );
    // rust: assert_eq!(
    // rust: read_block(&world, &registry, [0, 64, 1]),
    // rust: Err(NativeBlockReadError::Unloaded)
    // rust: );
    // rust: assert_eq!(
    // rust: read_block(&nether, &registry, [-1, -1, 1]),
    // rust: Err(NativeBlockReadError::OutOfBounds)
    // rust: );
    // rust: assert_eq!(
    // rust: read_block(&world, &registry, [30_000_000, 64, 1]),
    // rust: Err(NativeBlockReadError::OutOfBounds)
    // rust: );
    // rust: world.set(-1, 64, 1, BlockStateId(99)).unwrap();
    // rust: assert_eq!(
    // rust: read_block(&world, &registry, [-1, 64, 1]),
    // rust: Err(NativeBlockReadError::InvalidState)
    // rust: );
    // rust: assert_eq!(world.chunks.len(), 1, "reads must not load chunks");
}
}
