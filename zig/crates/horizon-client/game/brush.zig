//! Transpiled from Horizon Rust crate
//! Module: horizon-client_brush
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Brushing suspicious sand and gravel: `BrushItem.onUseTick` and
//! `BrushableBlockEntity`. The block's loot table stays in its saved block
//! entity (like a decorated pot's) until the first counted stroke rolls it.
// use super::{Game, Hit, decorated_pot, view_vector};
// use horizon_client::{
    // rust: block_entity_render::vertex_light,
    // rust: containers::BlockEntity,
    // rust: mesher::Vertex,
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: save,
}
// use horizon_core::random::RandomSource;
// use std::collections::HashMap;

/// `BrushItem.USE_DURATION`.
pub const USE_DURATION: u32 = 200;

/// A brushable block's counters. Vanilla never saves them: the block's
/// `dusted` state is all that is left after a reload.
    // rust: pub(super) struct BrushState {
    // rust: count: i32,
    // rust: resets_at: i64,
    // rust: cooldown_ends_at: i64,
    // rust: hit_face: Option<[i32; 3]>,
}

/// `BrushableBlockEntity.getCompletionState`: the `dusted` property.
pub fn completion_state(count: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match count {
    // rust: 0 => 0,
    // rust: 1..=2 => 1,
    // rust: 3..=5 => 2,
    // rust: _ => 3,
}
}

    // rust: pub(super) type Brushing = HashMap<[i32; 3], BrushState>;

    // rust: impl Game<'_> {
    /// `BrushItem.onUseTick` for a brush used `ticks` ticks so far, the
    /// hand of `slot` acting.
    // rust: pub(super) fn tick_brush(&mut self, slot: usize, ticks: u32) {
        // No block under the crosshair: releaseUsingItem.
    // rust: let Some(hit) = self.pick() else {
    // rust: self.using = None;
    // rust: return;
}
    // rust: let elapsed = ticks + 1;
        // The last tick before the backswing.
    // rust: if elapsed % 10 == 5 {
    // rust: self.brush_stroke(&hit, slot);
}
        // The use ends after 200 ticks; the held button starts it again.
    // rust: self.using = (elapsed < USE_DURATION).then_some((slot, elapsed));
}

    /// One stroke on the block aimed at: dust (this window only), the brush
    /// sound, and the block entity's count. The brush wears when the block
    /// changed state.
pub fn brush_stroke(self: *Self, hit: *Hit, slot: usize) void {
}
    // rust: let state = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: let (sound, brushable) = match &*name {
    // rust: "minecraft:suspicious_sand" => ("minecraft:item.brush.brushing.sand", true),
    // rust: "minecraft:suspicious_gravel" => ("minecraft:item.brush.brushing.gravel", true),
    // rust: _ => ("minecraft:item.brush.brushing.generic", false),
}
    // rust: if self.lan_acting.is_none() {
    // rust: self.brush_dust(hit, slot == super::shield::OFFHAND_SLOT);
}
    // rust: let at = hit.pos.map(|v| f64::from(v) + 0.5);
    // rust: self.audio.play(sound, Some(at), 1.0, 1.0);
    // rust: if brushable && self.brush_block(hit.pos, hit.face, slot) {
    // rust: self.damage_held(1);
}
}

    /// `BrushItem.spawnDustParticles`.
    // rust: pub(super) fn brush_dust(&mut self, hit: &Hit, off_hand: bool) {
    // rust: let state = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let Some((sprite, tint)) = self.particle_sprite(state, hit.pos) else {
    // rust: return;
}
    // rust: let options = ParticleOptions::block(ParticleType::Block, sprite, tint);
        // The arm that brushes: the main arm, or the other one for the off hand.
    // rust: let flip = if off_hand == self.settings.main_hand_left {
    // rust: 1.0
    // rust: } else {
    // rust: -1.0
}
    // rust: let view = view_vector(self.yaw, self.pitch);
        // DustParticlesDelta.fromDirection.
    // rust: let (dx, dz) = match hit.face {
    // rust: [0, _, 0] => (view[2], -view[0]),
    // rust: [0, 0, -1] => (1.0, -0.1),
    // rust: [0, 0, 1] => (-1.0, 0.1),
    // rust: [-1, 0, 0] => (-0.1, -1.0),
    // rust: _ => (0.1, 1.0),
}
    // rust: let count = 7 + self.particles.level_random().next_int_bound(5).unwrap_or(0);
    // rust: let x = hit.point[0] - if hit.face == [-1, 0, 0] { 1.0e-6 } else { 0.0 };
    // rust: let z = hit.point[2] - if hit.face == [0, 0, -1] { 1.0e-6 } else { 0.0 };
    // rust: for _ in 0..count {
    // rust: let random = self.particles.level_random();
    // rust: let v = [
    // rust: dx * flip * 3.0 * random.next_double(),
    // rust: 0.0,
    // rust: dz * flip * 3.0 * random.next_double(),
    // rust: ];
    // rust: self.particles.add(&options, [x, hit.point[1], z], v);
}
}

    /// `BrushableBlockEntity.brush`: whether the block changed (the brush wears).
pub fn brush_block(self: *Self, pos: [i32; 3], face: [i32; 3], slot: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let time = self.world.game_time;
    // rust: let mut brush = self.brushing.remove(&pos).unwrap_or_default();
    // rust: brush.hit_face.get_or_insert(face);
    // rust: let direction = match brush.hit_face.unwrap() {
    // rust: [0, -1, 0] => 0,
    // rust: [0, 1, 0] => 1,
    // rust: [0, 0, -1] => 2,
    // rust: [0, 0, 1] => 3,
    // rust: [-1, 0, 0] => 4,
    // rust: [1, 0, 0] => 5,
    // rust: _ => return false,
}
    // rust: if let Some(BlockEntity::Brushable(b)) =
    // rust: self.world.block_entities.get_mut(&(pos[0], pos[1], pos[2]))
    // rust: {
    // rust: b.hit_direction = Some(direction);
}
    // rust: brush.resets_at = time + 40;
    // rust: if time < brush.cooldown_ends_at {
    // rust: self.brushing.insert(pos, brush);
    // rust: return false;
}
    // rust: brush.cooldown_ends_at = time + 10;
    // rust: self.unpack_brush_loot(pos);
    // rust: let before = completion_state(brush.count);
    // rust: brush.count += 1;
    // rust: if brush.count >= 10 {
    // rust: self.brushing_completed(pos, brush.hit_face, slot);
    // rust: return true;
}
    // rust: self.schedule_brushable_tick(pos);
    // rust: let after = completion_state(brush.count);
    // rust: self.brushing.insert(pos, brush);
    // rust: if before != after {
    // rust: self.set_dusted(pos, after);
}
    // rust: false
}

    /// `BrushableBlockEntity.unpackLootTable`: the table's roll becomes the
    /// block entity's item.
pub fn unpack_brush_loot(self: *Self, pos: [i32; 3]) void {
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(BlockEntity::Brushable(b)) = self.world.block_entities.get(&key) else {
    // rust: return;
}
    // rust: let Some(horizon_world::nbt::Tag::String(table)) = &b.loot_table else {
    // rust: return;
}
    // rust: let table = table.to_string_lossy();
    // rust: let mut tag = save::encode_block_entity(
    // rust: key,
    // rust: &BlockEntity::Brushable(b.clone()),
    // rust: "minecraft:brushable_block",
    // rust: );
    // rust: self.trigger_loot_table(&table);
    // rust: let loot = horizon_client::structure_blocks::loot_data(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: );
    // rust: decorated_pot::unpack_loot(
    // rust: &mut tag,
    // rust: loot.as_deref(),
    // rust: &mut self.world.random,
    // rust: &mut self.rand_sequences,
    // rust: self.level.seed,
    // rust: );
    // rust: if let Some(BlockEntity::Brushable(b)) = self.world.block_entities.get_mut(&key) {
    // rust: b.loot_table = tag.get("LootTable").cloned();
    // rust: b.loot_seed = tag.get("LootTableSeed").cloned();
    // rust: b.item = tag.get("item").and_then(save::item_from_nbt);
}
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
}

    /// `BrushableBlockEntity.brushingCompleted`: the item drops out of the
    /// brushed face and the block turns into its sand or gravel.
pub fn brushing_completed(self: *Self, pos: [i32; 3], face: ?[i32; 3], slot: usize) void {
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let turns_into = match &*self.res.facts().get(state).name {
    // rust: "minecraft:suspicious_sand" => "minecraft:sand",
    // rust: "minecraft:suspicious_gravel" => "minecraft:gravel",
    // rust: _ => "minecraft:air",
}
        // dropContent: the item at the middle of the block beside that face.
    // rust: let item = match self.world.block_entities.get(&(pos[0], pos[1], pos[2])) {
    // rust: Some(BlockEntity::Brushable(b)) => b.item.clone(),
    // rust: _ => None,
}
    // rust: if let Some(mut item) = item {
    // rust: let face = face.unwrap_or([0, 1, 0]);
    // rust: let take = 10 + self.world.random.next_int_bound(21).unwrap_or(0);
    // rust: item.count = item.count.min(take as u32);
    // rust: let at = [
    // rust: f64::from(pos[0] + face[0]) + 0.5,
    // rust: f64::from(pos[1] + face[1]) + 0.625,
    // rust: f64::from(pos[2] + face[2]) + 0.5,
    // rust: ];
    // rust: let mut drops = vec![item];
    // rust: let tool = self.stack_in(slot).cloned();
    // rust: let origin = pos.map(|c| f64::from(c) + 0.5);
    // rust: self.native_use_drops(
    // rust: "",
    // rust: origin,
    // rust: Some((pos, state)),
    // rust: None,
    // rust: tool.as_ref(),
    // rust: &mut drops,
    // rust: );
    // rust: for item in drops {
    // rust: self.spawn_item(item, at, [0.0; 3], 0);
}
}
        // Level event 3008 for every player, then the block change.
    // rust: self.level_event_at(3008, pos, state.0 as i32);
    // rust: if let Some(base) = self.pack.assets.registry.default_state(turns_into) {
    // rust: let _ = self.level_set(pos, base);
}
}

pub fn set_dusted(self: *Self, pos: [i32; 3], dusted: i32) void {
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let Some(mut state) = registry
    // rust: .state(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .cloned()
    // rust: else {
    // rust: return;
}
    // rust: state.properties.insert("dusted".into(), dusted.to_string());
    // rust: if let Ok(state) = registry.resolve(&state) {
    // rust: let _ = self.level_set(pos, state);
}
}

pub fn schedule_brushable_tick(self: *Self, pos: [i32; 3]) void {
}
    // rust: let at = horizon_core::position::BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.schedule_tick(level, ticks, at, 2));
}

    /// `BrushableBlockEntity.checkReset`, from `BrushableBlock.tick`: a block
    /// left alone loses two counts, again every four ticks.
    // rust: pub(super) fn brushable_tick(&mut self, pos: [i32; 3]) {
    // rust: let time = self.world.game_time;
    // rust: let Some(mut brush) = self.brushing.remove(&pos) else {
    // rust: return;
}
    // rust: let before = completion_state(brush.count);
    // rust: if brush.count != 0 && time >= brush.resets_at {
    // rust: brush.count = (brush.count - 2).max(0);
    // rust: brush.resets_at = time + 4;
}
    // rust: let after = completion_state(brush.count);
    // rust: if brush.count != 0 {
    // rust: self.brushing.insert(pos, brush);
    // rust: self.schedule_brushable_tick(pos);
    // rust: } else if let Some(BlockEntity::Brushable(b)) =
    // rust: self.world.block_entities.get_mut(&(pos[0], pos[1], pos[2]))
    // rust: {
    // rust: b.hit_direction = None;
}
    // rust: if before != after {
    // rust: self.set_dusted(pos, after);
}
}

    /// `BrushableBlockRenderer`: reveal the item from the first brushed face.
    // rust: pub(super) fn brushable_geometry(&self, camera: glam::DVec3, out: &mut Vec<Vertex>) {
//         use horizon_assets::item_model::DisplayContext;
    // rust: for (key, entity) in &self.world.block_entities {
    // rust: let BlockEntity::Brushable(b) = entity else {
    // rust: continue;
}
    // rust: let (Some(item), Some(face)) = (&b.item, b.hit_direction) else {
    // rust: continue;
}
    // rust: let at = glam::DVec3::new(f64::from(key.0), f64::from(key.1), f64::from(key.2));
    // rust: if at.distance_squared(camera) >= 64.0 * 64.0 {
    // rust: continue;
}
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: let progress = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("dusted"))
    // rust: .and_then(|s| s.parse::<u8>().ok())
    // rust: .unwrap_or(0);
    // rust: if progress == 0 {
    // rust: continue;
}
    // rust: let offset = f32::from(progress) * 0.075;
    // rust: let (translation, adjacent, east_west) = match face {
    // rust: 0 => (glam::Vec3::new(0.5, -0.23 - offset, 0.5), [0, -1, 0], false),
    // rust: 1 => (glam::Vec3::new(0.5, 0.25 + offset, 0.5), [0, 1, 0], false),
    // rust: 2 => (glam::Vec3::new(0.5, 0.0, 0.25 - offset), [0, 0, -1], false),
    // rust: 3 => (glam::Vec3::new(0.5, 0.0, 0.73 + offset), [0, 0, 1], false),
    // rust: 4 => (glam::Vec3::new(0.25 - offset, 0.0, 0.5), [-1, 0, 0], true),
    // rust: 5 => (glam::Vec3::new(0.73 + offset, 0.0, 0.5), [1, 0, 0], true),
    // rust: _ => continue,
}
    // rust: let item = self.resolve_item(item, DisplayContext::Fixed, None, 0);
    // rust: if item.is_empty() {
    // rust: continue;
}
    // rust: let pose = glam::Mat4::from_translation(
    // rust: (at - camera).as_vec3() + glam::Vec3::new(0.0, 0.5, 0.0) + translation,
    // rust: ) * glam::Mat4::from_rotation_y(
    // rust: (86.0_f32 + if east_west { 90.0 } else { 0.0 }).to_radians(),
    // rust: ) * glam::Mat4::from_scale(glam::Vec3::splat(0.5));
    // rust: let light = self.world.light(
    // rust: key.0 + adjacent[0],
    // rust: key.1 + adjacent[1],
    // rust: key.2 + adjacent[2],
    // rust: );
    // rust: self.submit_item_world(&item, pose, vertex_light(light), out);
}
}

    /// Level event 3008 (`LevelEventHandler`): the finished block's sound
    /// and break particles.
    // rust: pub(super) fn brush_complete_event(&mut self, pos: [i32; 3], data: i32) {
    // rust: let state = horizon_world::registry::BlockStateId(data as u32);
    // rust: let sound = match &*self.res.facts().get(state).name {
    // rust: "minecraft:suspicious_sand" => "minecraft:item.brush.brushing.sand.complete",
    // rust: "minecraft:suspicious_gravel" => "minecraft:item.brush.brushing.gravel.complete",
    // rust: _ => "",
}
    // rust: if !sound.is_empty() {
    // rust: let at = pos.map(|v| f64::from(v) + 0.5);
            // Each client plays it from the event itself.
    // rust: self.audio.play_unshared(sound, Some(at), 1.0, 1.0);
}
    // rust: self.destroy_particles(pos, state);
}
}
