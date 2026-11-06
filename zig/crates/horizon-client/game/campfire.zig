//! Transpiled from Horizon Rust crate
//! Module: horizon-client_campfire
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Campfires' cooking: `CampfireBlock.useItemOn` (`CampfireBlockEntity.placeFood`)
//! and the block entity's `cookTick` (lit) and `cooldownTick` (unlit). The
//! items drawn on the fire are `campfire_geometry`'s; a server's clients get
//! them through the block entity's update tag (`lan::chunks::entity_tag`).
// use super::Game;
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::{
    // rust: Result, block_entities::Pos, block_entity_render::vertex_light, containers::BlockEntity,
    // rust: items::ItemStack, mesher::Vertex, mobs::Who,
}
// use horizon_core::position::BlockPos;

/// The `campfire_cooking` recipe kind (`RecipeType.CAMPFIRE_COOKING`).
pub const KIND: []const u8 = "minecraft:campfire_cooking";

pub fn is_campfire(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name == "minecraft:campfire" || name == "minecraft:soul_campfire"
}

    // rust: impl Game<'_> {
    /// `CampfireBlock.useItemOn` with a held item that is a campfire recipe's
    /// input (`RecipePropertySet.CAMPFIRE_INPUT`): on a server level the food
    /// goes into the first free slot (`placeFood`), and the use is consumed
    /// whether or not there was room. A client of a server leaves the placing
    /// to the server. Whether the food went in; None when this isn't a
    /// campfire use, so the item's own use runs.
    // rust: pub(super) fn use_on_campfire(&mut self, pos: [i32; 3]) -> Result<Option<bool>> {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if !is_campfire(&self.res.facts().get(state).name) {
    // rust: return Ok(None);
}
    // rust: let Some(held) = self.held().cloned() else {
    // rust: return Ok(None);
}
    // rust: let Some(time) = self.recipes().cook(KIND, &held).map(|r| r.time as i32) else {
    // rust: return Ok(None);
}
        // A client of a server predicts the placing; the server decides.
    // rust: if self.remote.is_some() {
    // rust: return Ok(Some(true));
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let placed = match self.world.block_entities.get_mut(&key) {
    // rust: Some(BlockEntity::Campfire(c)) => {
    // rust: let mut one = held.clone();
    // rust: c.place_food(&mut one, time)
}
    // rust: _ => false,
}
    // rust: if placed {
    // rust: self.native_campfire_start(pos, &held.item);
            // ItemStack.consumeAndReturn: creative keeps the item.
    // rust: self.consume_held();
    // rust: self.award_custom_stat("interact_with_campfire", 1);
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_change",
    // rust: pos,
    // rust: Some(Who::Player),
    // rust: Some(state),
    // rust: );
    // rust: self.mark_block_entity_updated(key);
}
    // rust: Ok(Some(placed))
}

    /// `CampfireBlockEntity.cookTick` of a lit campfire, `cooldownTick` of an
    /// unlit one. A finished item's result (the recipe's, or the item itself
    /// when no recipe takes it any more) drops at the block's corner
    /// (`Containers.dropItemStack` at its integer position), then the clients
    /// see the slot empty and a `block_change` goes out.
    // rust: pub(super) fn tick_campfire(&mut self, pos: Pos) -> Result<()> {
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: let lit = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("lit"))
    // rust: .is_some_and(|v| v == "true");
    // rust: let Some(BlockEntity::Campfire(c)) = self.world.block_entities.get_mut(&pos) else {
    // rust: return Ok(());
}
        // BlockEntity.setChanged: a timer that moved is saved with the
        // chunk (no update to the clients, who don't see the timers).
    // rust: let changed = if lit {
    // rust: c.items.iter().any(Option::is_some)
    // rust: } else {
    // rust: c.cooldown_tick()
}
    // rust: if changed {
    // rust: self.world.modified.insert((pos.0 >> 4, pos.2 >> 4));
}
    // rust: if !lit {
    // rust: self.sleep_idle_campfire(pos, false);
    // rust: return Ok(());
}
    // rust: let Some(BlockEntity::Campfire(c)) = self.world.block_entities.get_mut(&pos) else {
    // rust: return Ok(());
}
    // rust: let done = c.cook_tick();
    // rust: for (_, item) in done {
            // The world's table, as placing the item (`self.recipes()`) asked.
    // rust: let result = world_recipes!(self)
    // rust: .cook(KIND, &item)
    // rust: .map_or_else(|| item.clone(), |r| r.result.clone());
    // rust: self.native_block_cook([pos.0, pos.1, pos.2], &item.item, &result.item);
    // rust: self.campfire_drop(pos, result);
    // rust: self.mark_block_entity_updated(pos);
    // rust: self.post_block_game_event(
    // rust: "minecraft:block_change",
    // rust: [pos.0, pos.1, pos.2],
    // rust: None,
    // rust: Some(state),
    // rust: );
}
    // rust: self.sleep_idle_campfire(pos, true);
    // rust: Ok(())
}

pub fn sleep_idle_campfire(self: *Self, pos: Pos, lit: bool) void {
}
    // rust: if matches!(self.world.block_entities.get(&pos), Some(BlockEntity::Campfire(c)) if c.idle(lit))
    // rust: {
    // rust: self.world.block_entities.sleep(pos);
}
}

    /// `CampfireRenderer`: each cooking item lies on the fire, slot `i`
    /// turned to `Direction.from2DDataValue((i + facing) % 4)`, laid flat
    /// (90° about X), at a corner and three eighths of its size, drawn as a
    /// FIXED item seeded by the block's position plus the slot.
    // rust: pub(super) fn campfire_geometry(&self, camera: glam::DVec3, out: &mut Vec<Vertex>) {
    // rust: for (key, entity) in &self.world.block_entities {
    // rust: let BlockEntity::Campfire(c) = entity else {
    // rust: continue;
}
    // rust: if c.items.iter().all(Option::is_none) {
    // rust: continue;
}
    // rust: let at = glam::DVec3::new(f64::from(key.0), f64::from(key.1), f64::from(key.2));
    // rust: if at.distance_squared(camera) >= 64.0 * 64.0 {
    // rust: continue;
}
            // Direction.get2DDataValue: south 0, west 1, north 2, east 3.
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: let facing = match self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("facing"))
    // rust: .map(String::as_str)
    // rust: {
    // rust: Some("west") => 1,
    // rust: Some("north") => 2,
    // rust: Some("east") => 3,
    // rust: _ => 0,
}
    // rust: let light = vertex_light(self.world.light(key.0, key.1, key.2));
    // rust: let packed = BlockPos::new(key.0, key.1, key.2).pack();
    // rust: for (i, stack) in c.items.iter().enumerate() {
    // rust: let Some(stack) = stack else {
    // rust: continue;
}
    // rust: let seed = (packed as i32).wrapping_add(i as i32);
    // rust: let item = self.resolve_item(stack, DisplayContext::Fixed, None, seed);
    // rust: if item.is_empty() {
    // rust: continue;
}
                // Direction.toYRot: 90° per 2D step from south.
    // rust: let yaw = -(((i + facing) % 4) as f32 * 90.0);
    // rust: let pose = glam::Mat4::from_translation(
    // rust: (at - camera).as_vec3() + glam::Vec3::new(0.5, 0.449_218_75, 0.5),
    // rust: ) * glam::Mat4::from_rotation_y(yaw.to_radians())
    // rust: * glam::Mat4::from_rotation_x(90f32.to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(-0.3125, -0.3125, 0.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(0.375));
    // rust: self.submit_item_world(&item, pose, light, out);
}
}
}

    /// `Containers.dropItemStack(level, x, y, z, stack)` at the block's
    /// integer position.
    // rust: pub(super) fn campfire_drop(&mut self, pos: Pos, stack: ItemStack) {
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: for piece in
    // rust: horizon_world::level::removal::drop_item_stack(&mut self.world.random, at, stack.count)
    // rust: {
    // rust: self.spawn_item(
    // rust: ItemStack {
    // rust: count: piece.count,
    // rust: ..stack.clone()
    // rust: },
    // rust: piece.pos,
    // rust: piece.motion,
    // rust: 0,
    // rust: );
}
}
}
