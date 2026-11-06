//! Transpiled from Horizon Rust crate
package horizon_client_ominous_item_spawner

import "core:fmt"
import "core:mem"
import "core:math"

// `OminousItemSpawner`: the item an ominous trial spawner drops on its
// fight. It floats, growing and turning (`OminousItemSpawnerRenderer`), for
// 60 to 120 ticks, then falls as an item or is fired straight down as a
// projectile (`spawnItem`). Saved with its chunk's entities (persist.rs).
// use super::Game;
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::{
    // rust: block_entity_render::vertex_light,
    // rust: item_render,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: particles::{ParticleOptions, ParticleType},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};

// `TICKS_BEFORE_ABOUT_TO_SPAWN_SOUND`.
ABOUT_TO_SPAWN :: 36
// `OminousItemSpawnerRenderer`: grows over its first 50 ticks, turning 40
// degrees a tick.
TICKS_SCALING :: 50.0
ROTATION_SPEED :: 40.0

    // rust: pub(super) struct OminousItemSpawner {
    // Its entity id: from the entity counter on the server, the server's on
    // a client.
    // rust: pub(super) id: u32,
    // `DATA_ITEM`; `minecraft:air` stands for `ItemStack.EMPTY`.
    // rust: pub(super) item: ItemStack,
    // rust: pub(super) position: [f64; 3],
    // rust: pub(super) spawn_item_after: i64,
    // rust: tick_count: i64,
    // Its UUID, and the compound it was loaded from (fields Horizon doesn't
    // model survive a save).
    // rust: pub(super) uuid: [i32; 4],
    // rust: pub(super) raw: Option<Box<horizon_world::nbt::Tag>>,
}

// `ProjectileItem.DispenseConfig` of the items fired down: power,
// uncertainty and `overrideDispenseEvent`; None for items that just fall.
projectile :: proc(item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match item {
    // rust: "minecraft:fire_charge" => (1.0, 6.666_666_5, Some(1018)),
    // rust: "minecraft:wind_charge" => (1.0, 6.666_666_5, Some(1051)),
    // rust: "minecraft:firework_rocket" => (0.5, 1.0, Some(1004)),
    // rust: "minecraft:experience_bottle"
    // rust: | "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion" => (1.375, 3.0, None),
    // rust: "minecraft:arrow"
    // rust: | "minecraft:spectral_arrow"
    // rust: | "minecraft:tipped_arrow"
    // rust: | "minecraft:snowball"
    // rust: | "minecraft:egg"
    // rust: | "minecraft:blue_egg"
    // rust: | "minecraft:brown_egg" => (1.1, 6.0, None),
    // rust: _ => return None,
    // rust: })
}

block :: proc(p: [f64; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: p.map(|v| v.floor() as i32)
}

    // rust: impl Game<'_> {
    // `OminousItemSpawner.create` added at `position`.
    // rust: pub(super) fn add_ominous_item_spawner(
    // rust: &mut self,
    // rust: item: ItemStack,
    // rust: position: [f64; 3],
    // rust: delay: i32,
    // rust: ) {
    // rust: self.next_entity += 1;
    // rust: self.ominous_spawners.push(OminousItemSpawner {
    // rust: id: self.next_entity,
    // rust: item,
    // rust: position,
    // rust: spawn_item_after: i64::from(delay),
    // rust: tick_count: 0,
    // rust: uuid: horizon_client::save::random_uuid(),
    // rust: raw: None,
    // rust: });
}
    // A saved spawner, as `readAdditionalSaveData` leaves it: its tick
    // count starts again from 0.
    // rust: pub(super) fn load_ominous_item_spawner(&mut self, tag: horizon_world::nbt::Tag) {
    // rust: let Some((item, at, spawn_item_after)) =
    // rust: horizon_client::entity_nbt::ominous_item_spawner_from_nbt(&tag)
    // rust: else {
    // rust: return;
}
    // rust: self.next_entity += 1;
    // rust: let id = self.next_entity;
    // rust: let saved = horizon_client::entity_nbt::uuid(&tag);
        // Its saved UUID and the attachments saved under it (#7398).
    // rust: self.remember_uuid(id, saved, &tag);
    // rust: let uuid = self.uuid_for(id);
    // rust: self.ominous_spawners.push(OminousItemSpawner {
    // rust: id,
    // rust: item,
    // rust: position: [at.x, at.y, at.z],
    // rust: spawn_item_after,
    // rust: tick_count: 0,
    // rust: uuid,
    // rust: raw: Some(Box::new(tag)),
    // rust: });
}
    // Every item spawner's tick: `commonTick`'s count, `tickServer` (the
    // warning sound, then the item) and `tickClient` (particles every 5
    // game ticks).
    // rust: pub(super) fn tick_ominous_item_spawners(&mut self) {
    // rust: let spawners = std::mem::take(&mut self.ominous_spawners);
    // rust: let mut kept = Vec::with_capacity(spawners.len());
    // rust: for mut s in spawners {
    // rust: s.tick_count += 1;
    // rust: let at = block(s.position);
    // rust: let center = at.map(|v| f64::from(v) + 0.5);
    // rust: if s.tick_count == s.spawn_item_after - ABOUT_TO_SPAWN {
    // rust: self.audio.play(
    // rust: "minecraft:block.trial_spawner.about_to_spawn_item",
    // rust: Some(center),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
    // rust: if s.tick_count >= s.spawn_item_after {
    // rust: self.spawn_ominous_item(&s);
    // rust: continue;
}
    // rust: if self.world.game_time % 5 == 0 {
    // rust: self.ominous_spawner_particles(s.position);
}
    // rust: kept.push(s);
}
    // rust: kept.append(&mut self.ominous_spawners);
    // rust: self.ominous_spawners = kept;
}
    // `handleAddEntity` for a spawner a server sent: its item comes with the
    // entity data (`ItemStack.EMPTY` until then, which draws nothing).
    // rust: pub(super) fn add_remote_ominous_item_spawner(&mut self, id: u32, position: [f64; 3]) {
    // rust: self.ominous_spawners.push(OminousItemSpawner {
    // rust: id,
    // rust: item: ItemStack::new("minecraft:air", 1),
    // rust: position,
    // rust: spawn_item_after: 0,
    // rust: tick_count: 0,
    // rust: uuid: [0; 4],
    // rust: raw: None,
    // rust: });
}
    // `OminousItemSpawner.tick` on a client: `tickCount` and `tickClient`,
    // the particles every 5 game ticks; only the server spawns the item.
    // rust: pub(super) fn tick_remote_ominous_item_spawners(&mut self) {
    // rust: let at: Vec<[f64; 3]> = self.ominous_spawners.iter().map(|s| s.position).collect();
    // rust: for s in &mut self.ominous_spawners {
    // rust: s.tick_count += 1;
}
    // rust: if self.world.game_time % 5 == 0 {
    // rust: for position in at {
    // rust: self.ominous_spawner_particles(position);
}
}
}
    // `spawnItem`: a projectile shot down, or an item entity; level event
    // 3021 and the entity_place game event.
spawn_ominous_item :: proc(self: ^Self, s: ^OminousItemSpawner) {
}
        // An empty item spawns nothing, and no event marks it.
    // rust: if &*s.item.item == "minecraft:air" {
    // rust: return;
}
    // rust: let at = block(s.position);
    // rust: let p = s.position;
    // rust: match projectile(&s.item.item) {
    // rust: Some((power, uncertainty, event)) => {
    // rust: if let Some(event) = event {
    // rust: self.level_event_at(event, at, 0);
}
    // rust: let from = Vec3::new(p[0], p[1], p[2]);
    // rust: self.shoot_projectile_item(from, [0.0, -1.0, 0.0], &s.item, power, uncertainty);
}
    // rust: None => self.spawn_item(s.item.clone(), p, super::dispenser::new_item_motion(), 0),
}
    // rust: self.level_event_at(3021, at, 1);
    // rust: self.post_block_game_event("minecraft:entity_place", at, None, None);
}
    // `OminousItemSpawner.addParticles`: one to three ominous spawning
    // particles from the spawner out to points around it.
ominous_spawner_particles :: proc(self: ^Self, at: [f64; 3]) {
}
    // rust: let options = ParticleOptions::simple(ParticleType::OminousSpawning);
    // rust: let r = self.particles.random();
    // rust: let count = r.next_int_between_inclusive(1, 3).unwrap_or(1);
    // rust: let mut flights = Vec::new();
    // rust: for _ in 0..count {
    // rust: let mut spread = || 0.4 * (r.next_gaussian() - r.next_gaussian());
    // rust: let from = [at[0] + spread(), at[1] + spread(), at[2] + spread()];
    // rust: flights.push([from[0] - at[0], from[1] - at[1], from[2] - at[2]]);
}
    // rust: for v in flights {
    // rust: self.particles.add(&options, at, v);
}
}
    // `OminousItemSpawnerRenderer`: the item, full bright, growing over its
    // first 50 ticks and turning.
    // rust: pub(super) fn ominous_item_spawner_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: for s in &self.ominous_spawners {
    // rust: let at = glam::DVec3::from_array(s.position);
    // rust: if at.distance_squared(camera) >= 64.0 * 64.0 {
    // rust: continue;
}
    // rust: let state = self.resolve_item(&s.item, DisplayContext::Ground, None, 0);
    // rust: if state.is_empty() {
    // rust: continue;
}
    // rust: let age = s.tick_count as f32 + alpha as f32;
    // rust: let scale = if age <= TICKS_SCALING {
    // rust: age.min(TICKS_SCALING) / TICKS_SCALING
    // rust: } else {
    // rust: 1.0
}
    // rust: let spin = (age * ROTATION_SPEED).rem_euclid(360.0);
    // rust: let pose = glam::Mat4::from_translation((at - camera).as_vec3())
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(scale))
    // rust: * glam::Mat4::from_rotation_y(spin.to_radians());
    // rust: let seed =
    // rust: i64::from(self.pack.item_renderer.item_id(&s.item.item)) + i64::from(s.item.damage);
    // rust: for copy in item_render::cluster_poses(
    // rust: &state,
    // rust: pose,
    // rust: item_render::rendered_amount(s.item.count),
    // rust: seed,
    // rust: ) {
    // rust: self.submit_item_world(&state, copy, vertex_light(0xFF), out);
}
}
}
}
