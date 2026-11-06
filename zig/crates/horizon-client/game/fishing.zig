//! Transpiled from Horizon Rust crate
//! Module: horizon-client_fishing
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Fishing: `FishingRodItem.use` (cast / reel in), the `FishingHook` (flight,
//! bobbing, lure and bite timers, open water, hooking mobs, retrieving the
//! `gameplay/fishing` loot) and `FishingHookRenderer` (bobber and line).
// use super::{Game, lan::LanHost, lan_mobs::guest_bounds, view_vector};
// use horizon_client::advancements::EntityView;
// use horizon_client::lan::{entity::States, hub::Hub};
// use horizon_client::{
    // rust: blocks::Fluid,
    // rust: collisions::SceneCollisions,
    // rust: gizmos::Line,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: pose::Pose,
    // rust: sound_engine::unique_seed,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, traverse_blocks, trig},
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_protocol::entity_data::{Value, serializer};
// use std::{collections::HashMap, sync::Arc};

// use super::lan_actions::GuestPlay;

/// `FishingHook.retrieve`: the table's named random sequence, or the level
/// random when a datapack table does not name one.
    // rust: fn fishing_loot(
    // rust: loot: &horizon_world::loot::LootData,
    // rust: sequences: &mut horizon_client::random_sequences::RandomSequences,
    // rust: level_random: &mut LegacyRandom,
    // rust: world_seed: i64,
    // rust: luck: f32,
    // rust: biome: Option<&str>,
    // rust: open_water: bool,
    // rust: ) -> Vec<horizon_world::loot::LootStack> {
    // rust: let table = "minecraft:gameplay/fishing";
    // rust: match loot.random_sequence(table) {
    // rust: Some(sequence) => loot.roll(
    // rust: table,
    // rust: sequences.get(sequence, world_seed),
    // rust: luck,
    // rust: biome,
    // rust: Some(open_water),
    // rust: ),
    // rust: None => loot.roll(table, level_random, luck, biome, Some(open_water)),
}
}

pub const State = enum {
    Flying,
    Bobbing,
    Hooked(u32),
};
pub const EntityCollision = enum {
    Hooked,
    Deflected { first: bool },
};
    // rust: pub(super) struct Hook {
    /// Its entity id, which a server's players track it under.
    // rust: id: u32,
    // rust: pub(super) position: Vec3,
    // rust: pub(super) previous: Vec3,
    // rust: velocity: Vec3,
    // rust: state: State,
    // rust: last_deflected_by: Option<u32>,
    // rust: needs_sync: bool,
    // rust: tick_count: i32,
    // rust: life: i32,
    // rust: on_ground: bool,
    // rust: nibble: i32,
    // rust: time_until_lured: i32,
    // rust: time_until_hooked: i32,
    // rust: fish_angle: f32,
    // rust: out_of_water: i32,
    // rust: open_water: bool,
    // rust: luck: i32,
    // rust: lure: i32,
    /// The position a server's update put it heading for.
    // rust: lerp: HookLerp,
    // rust: pub(super) random: LegacyRandom,
}
/// A player a hook can catch (`canHitEntity`): their entity id, which
/// guest they are (none: the host) and their box.
    // rust: pub(super) struct HookTarget {
    // rust: id: u32,
    // rust: conn: Option<u32>,
    // rust: bounds: Aabb,
}
pub const SIZE: f64 = 0.25;
pub fn bounds(p: Vec3) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = SIZE / 2.0;
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - h, p.y, p.z - h),
    // rust: Vec3::new(p.x + h, p.y + SIZE, p.z + h),
    // rust: )
}
pub fn segment_entry(start: Vec3, end: Vec3, bounds: Aabb) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let min = bounds.min_position();
    // rust: let max = bounds.max_position();
    // rust: let start = [start.x, start.y, start.z];
    // rust: let min = [min.x, min.y, min.z];
    // rust: let max = [max.x, max.y, max.z];
    // rust: if (0..3).all(|axis| start[axis] >= min[axis] && start[axis] < max[axis]) {
    // rust: return None;
}
    // rust: let delta = [end.x - start[0], end.y - start[1], end.z - start[2]];
    // rust: let mut entry: f64 = 0.0;
    // rust: let mut exit: f64 = 1.0;
    // rust: for axis in 0..3 {
    // rust: if delta[axis] == 0.0 {
    // rust: if start[axis] < min[axis] || start[axis] > max[axis] {
    // rust: return None;
}
    // rust: continue;
}
    // rust: let a = (min[axis] - start[axis]) / delta[axis];
    // rust: let b = (max[axis] - start[axis]) / delta[axis];
    // rust: entry = entry.max(a.min(b));
    // rust: exit = exit.min(a.max(b));
    // rust: if entry > exit {
    // rust: return None;
}
}
    // rust: (entry <= 1.0 && exit >= 0.0).then_some(entry)
}
/// `ProjectileUtil.computeMargin`: the fishing hook's target-box margin grows
/// to 0.3 blocks over its first eight ticks.
pub fn entity_hit_margin(tick_count: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from((tick_count - 2).clamp(0, 6)) / 20.0
}
    // rust: fn first_entity_hit(
    // rust: start: Vec3,
    // rust: end: Vec3,
    // rust: margin: f64,
    // rust: targets: impl IntoIterator<Item = (u32, Aabb)>,
    // rust: ) -> Option<u32> {
    // rust: let mut hit = None;
    // rust: let mut hit_at = f64::INFINITY;
    // rust: for (id, target_bounds) in targets {
    // rust: if let Some(at) = segment_entry(
    // rust: start,
    // rust: end,
    // rust: target_bounds.inflate(Vec3::new(margin, margin, margin)),
    // rust: ) && at < hit_at
    // rust: {
    // rust: hit = Some(id);
    // rust: hit_at = at;
}
}
    // rust: hit
}
pub fn pull_item(item: *mut horizon_client::entities::ItemEntity, delta: Vec3) void {
}
    // rust: item.velocity = item.velocity.add_vector(delta);
    // The change is made outside ItemEntity::tick, so its velocity comparison
    // cannot request the immediate motion update for tracking clients.
    // rust: item.needs_sync = true;
}
/// `FishingHook.pullEntity`: add a tenth of the vector from the hook to its owner.
pub fn pull_hooked(velocity: Vec3, hook: Vec3, owner: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(
    // rust: velocity.x + (owner.x - hook.x) * 0.1,
    // rust: velocity.y + (owner.y - hook.y) * 0.1,
    // rust: velocity.z + (owner.z - hook.z) * 0.1,
    // rust: )
}
/// Minecarts a hook can catch. `AbstractMinecart.isPickable` is true while the
/// cart exists, and `Projectile.canHitEntity` skips the vehicle the owner rides.
    // rust: fn minecart_hook_targets<'a>(
    // rust: carts: impl Iterator<Item = &'a super::minecarts::Minecart> + 'a,
    // rust: own_vehicle: Option<u32>,
    // rust: ) -> impl Iterator<Item = (u32, Aabb)> + 'a {
    // rust: carts
    // rust: .filter(move |c| Some(c.id) != own_vehicle)
    // rust: .map(|c| (c.id, c.bounds()))
}
    // rust: impl Hook {
pub fn hit_entity(self: *Self, id: u32, deflects: bool) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if deflects {
    // rust: let first = self.last_deflected_by != Some(id);
    // rust: if first {
    // rust: self.velocity = self.velocity.scale(-0.5);
    // rust: self.last_deflected_by = Some(id);
    // rust: self.needs_sync = true;
}
    // rust: return EntityCollision::Deflected { first };
}
    // rust: self.state = State::Hooked(id);
    // rust: self.velocity = Vec3::ZERO;
    // rust: EntityCollision::Hooked
}

    // rust: pub(super) fn bounds(&self) -> Aabb {
    // rust: bounds(self.position)
}
    /// `FishingHook.tick` returns before `applyEffectsFromBlocks` while it
    /// holds an entity.
    // rust: pub(super) fn applies_block_effects(&self) -> bool {
    // rust: !matches!(self.state, State::Hooked(_))
}
    /// `FishingHook.catchingFish`: the nibble timer, and DATA_BITING's plunge
    /// (`onSyncedDataUpdated` runs on the server too).
    // rust: pub(super) fn trigger_bite(&mut self, game_time: i64) {
    // rust: self.nibble = 20 + self.random.next_int_bound(21).unwrap_or(0);
    // rust: self.velocity.y = bite_impulse(&mut synchronized_random(self.id, game_time));
}
}
/// `FishingHook.syncronizedRandom`, reseeded every tick from the hook's UUID and the game
/// time so the server and its clients draw alike. Horizon's hook has no UUID: its entity
/// id stands in. Kept off the level's random, whose draws must stay in vanilla's order.
pub fn synchronized_random(id: u32, game_time: i64) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LegacyRandom::new(i64::from(id) ^ game_time)
}
/// `FishingHook.onSyncedDataUpdated` on DATA_BITING: the downward plunge,
/// `-0.4F * Mth.nextFloat(syncronizedRandom, 0.6F, 1.0F)`, in float as vanilla.
pub fn bite_impulse(r: *mut impl RandomSource) f {
    // Implementation ported from Horizon
    return undefined;
}
    // Mth.nextFloat(random, min, max): `random.nextFloat() * (max - min) + min`.
    // rust: f64::from(-0.4f32 * (r.next_float() * (1.0f32 - 0.6f32) + 0.6f32))
}

/// `FishingHook` constructor's three independent triangle draws.
pub fn cast_velocity(y_sin: f32, y_cos: f32, dir_y: f32, random: *mut LegacyRandom) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = Vec3::new(f64::from(-y_sin), f64::from(dir_y), f64::from(-y_cos));
    // rust: let len = (v.x * v.x + v.y * v.y + v.z * v.z).sqrt();
    // rust: Vec3::new(
    // rust: v.x * (0.6 / len + random.triangle(0.5, 0.0103365)),
    // rust: v.y * (0.6 / len + random.triangle(0.5, 0.0103365)),
    // rust: v.z * (0.6 / len + random.triangle(0.5, 0.0103365)),
    // rust: )
}
/// `FishingHook.onHitBlock`: `getDeltaMovement().normalize().scale(hit.distanceTo(this))`,
/// where `HitResult.distanceTo` is the *squared* distance to the hook: the bobber
/// springs back a little off a wall instead of stopping dead.
pub fn rebound(velocity: Vec3, hit: Vec3, at: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: velocity.normalize().scale(hit.distance_squared(at))
}
    // rust: impl Game<'_> {
    /// Run real `catchingFish` states for the vanilla differential harness.
    // rust: pub(super) fn fishing_tick_reference(&mut self) -> Vec<serde_json::Value> {
    // rust: self.world.weather.raining = false;
    // rust: let mut rows = Vec::new();
    // rust: for seed in [0_i64, 1, 42, 123456789, -1] {
    // rust: for phase in 0..5 {
    // rust: let mut hook = Hook::remote(1, Vec3::new(0.5, 400.0, 0.5));
    // rust: hook.random = LegacyRandom::new(seed);
    // rust: hook.nibble = if phase == 4 { 2 } else { 0 };
    // rust: hook.time_until_lured = if phase == 1 { 2 } else { 0 };
    // rust: hook.time_until_hooked = match phase {
    // rust: 2 => 3,
    // rust: 3 => 1,
    // rust: _ => 0,
}
    // rust: hook.fish_angle = 12.5;
    // rust: self.catching_fish(&mut hook, [0, 400, 0]);
    // rust: rows.push(serde_json::json!({
    // rust: "seed": seed, "phase": phase, "nibble": hook.nibble,
    // rust: "lured": hook.time_until_lured, "hooked": hook.time_until_hooked,
    // rust: "angle_bits": hook.fish_angle.to_bits() as i32, "next": hook.random.next_long(),
    // rust: }));
}
}
    // rust: rows
}
    /// Exercise the actual rod-use path with a table without a named sequence.
    // rust: pub(super) fn fishing_fallback_reference(&mut self) -> Vec<serde_json::Value> {
    // rust: let rod = ItemStack {
    // rust: item: Arc::from("minecraft:fishing_rod"),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: let mut rows = Vec::new();
    // rust: for seed in [0_i64, 1, 42, 123456789, -1] {
    // rust: let position = self.player.as_ref().expect("harness player").position;
    // rust: let mut hook = Hook::remote(1, position);
    // rust: hook.nibble = 10;
    // rust: hook.random = LegacyRandom::new(seed);
    // rust: self.hook = Some(hook);
    // rust: let item_start = self.dropped.len();
    // rust: let orb_start = self.orbs.len();
    // rust: self.world.random = LegacyRandom::new(seed);
    // rust: self.use_fishing_rod(&rod);
    // rust: let items: Vec<_> = self
    // rust: .dropped
    // rust: .iter()
    // rust: .skip(item_start)
    // rust: .map(|item| item.stack.item.to_string())
    // rust: .collect();
    // rust: let xp: Vec<_> = self
    // rust: .orbs
    // rust: .iter()
    // rust: .skip(orb_start)
    // rust: .map(|orb| orb.value)
    // rust: .collect();
    // rust: rows.push(serde_json::json!({
    // rust: "seed": seed, "level_next": self.world.random.next_long(), "items": items, "xp": xp,
    // rust: }));
}
    // rust: rows
}
    /// Exercise `FishingHook.tick` in a still-water block on the server.
    // rust: pub(super) fn fishing_bobbing_reference(&mut self) -> Vec<serde_json::Value> {
    // rust: let old_position = self.player.as_ref().unwrap().position;
    // rust: let block = [
    // rust: old_position.x.floor() as i32,
    // rust: 300,
    // rust: old_position.z.floor() as i32,
    // rust: ];
    // rust: let old_block = self.world.block(block[0], block[1], block[2]);
    // rust: let water = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:water")
    // rust: .unwrap();
    // rust: self.level_set(block, water).unwrap();
    // rust: assert_eq!(
    // rust: self.world.block(block[0], block[1], block[2]),
    // rust: water,
    // rust: "bobbing fixture water not placed"
    // rust: );
    // rust: let x = f64::from(block[0]) + 0.5;
    // rust: let z = f64::from(block[2]) + 0.5;
    // rust: self.player.as_mut().unwrap().position = Vec3::new(x, 300.0, z - 2.0);
    // rust: let old_offhand = self.offhand.replace(ItemStack {
    // rust: item: Arc::from("minecraft:fishing_rod"),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: });
    // rust: let old_hook = self.hook.take();
    // rust: self.world.weather.raining = false;
    // rust: let mut rows = Vec::new();
    // rust: for seed in [0_i64, 1, 42, 123456789, -1] {
    // rust: let mut hook = Hook::remote(1, Vec3::new(x, 300.5, z));
    // rust: hook.state = State::Bobbing;
    // rust: hook.velocity = Vec3::new(0.1, 0.03, -0.2);
    // rust: hook.nibble = 0;
    // rust: hook.random = LegacyRandom::new(seed);
    // rust: self.hook = Some(hook);
    // rust: self.tick_fishing();
    // rust: let mut hook = self.hook.take().expect("bobbing hook removed");
    // rust: rows.push(serde_json::json!({
    // rust: "seed": seed,
    // rust: "vx": hook.velocity.x.to_bits() as i64, "vy": hook.velocity.y.to_bits() as i64,
    // rust: "vz": hook.velocity.z.to_bits() as i64, "nibble": hook.nibble, "next": hook.random.next_long(),
    // rust: }));
}
        // The client must take the same block hit before moving as the server;
        // otherwise it lands farther away and slides back on the next update.
    // rust: let stone = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:stone")
    // rust: .unwrap();
    // rust: self.level_set(block, stone).unwrap();
    // rust: for (case, motion) in [
    // rust: Vec3::new(0.2, -0.4, 0.1),
    // rust: Vec3::new(-0.2, -0.4, 0.1),
    // rust: Vec3::new(0.0, -0.6, -0.2),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let mut state = (Vec3::new(x, 301.1, z), motion, State::Flying, false);
    // rust: let mut random = LegacyRandom::new(0);
    // rust: for tick in 0..5 {
    // rust: state = self.client_hook_step(state, &mut random);
    // rust: rows.push(serde_json::json!({
    // rust: "case": case, "tick": tick,
    // rust: "position": [state.0.x - f64::from(block[0]), state.0.y, state.0.z - f64::from(block[2])],
    // rust: "motion": [state.1.x, state.1.y, state.1.z],
    // rust: }));
}
}
    // rust: self.hook = old_hook;
    // rust: self.offhand = old_offhand;
    // rust: self.player.as_mut().unwrap().position = old_position;
    // rust: self.level_set(block, old_block).unwrap();
    // rust: rows
}
pub fn holds_rod(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held()
    // rust: .is_some_and(|s| &*s.item == "minecraft:fishing_rod")
    // rust: || self
    // rust: .offhand
    // rust: .as_ref()
    // rust: .is_some_and(|s| &*s.item == "minecraft:fishing_rod")
}
    /// `FishingRodItem.use`.
    // rust: pub(super) fn use_fishing_rod(&mut self, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:fishing_rod" {
    // rust: return false;
}
        // The mods hear a server player's cast or reel-in first.
    // rust: if self.player.is_some()
    // rust: && let (Some(uuid), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: let state = match &self.hook {
    // rust: None => 0,
    // rust: Some(h) if matches!(h.state, State::Hooked(_)) => 4,
    // rust: Some(h) if h.nibble > 0 => 2,
    // rust: Some(_) => 3,
}
    // rust: let mut cancel = false;
    // rust: self.native_player_fish(uuid, &name, state, &mut cancel);
    // rust: if cancel {
    // rust: return true;
}
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return false;
}
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: if self.hook.is_some() {
    // rust: let damage = self.retrieve_hook(stack);
    // rust: self.damage_held(damage);
    // rust: let pitch = 0.4 / (self.world.random.next_float() * 0.4 + 0.8);
    // rust: self.audio.play(
    // rust: "minecraft:entity.fishing_bobber.retrieve",
    // rust: Some(at),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
    // rust: } else {
    // rust: let pitch = 0.4 / (self.world.random.next_float() * 0.4 + 0.8);
    // rust: self.audio.play(
    // rust: "minecraft:entity.fishing_bobber.throw",
    // rust: Some(at),
    // rust: 0.5,
    // rust: pitch,
    // rust: );
            // FishingHook(player, level, luck, lureSpeed)
    // rust: let lure = stack.enchantment_level("minecraft:lure") as i32 * 5 * 20;
    // rust: let luck = stack.enchantment_level("minecraft:luck_of_the_sea") as i32;
    // rust: let (yaw, pitch) = (self.yaw, self.pitch);
    // rust: let (y_sin, y_cos, dir_y) = cast_direction(yaw, pitch);
    // rust: let eye_y = p.position.y + f64::from(p.dimensions.eye_height);
            // snapTo(x, getEyeY(), z): the hook's feet start at the owner's eye.
    // rust: let start = Vec3::new(
    // rust: p.position.x - f64::from(y_sin) * 0.3,
    // rust: eye_y,
    // rust: p.position.z - f64::from(y_cos) * 0.3,
    // rust: );
    // rust: let mut random = LegacyRandom::new(unique_seed());
    // rust: let v = cast_velocity(y_sin, y_cos, dir_y, &mut random);
    // rust: self.next_entity += 1;
    // rust: self.hook = Some(Hook {
    // rust: id: self.next_entity,
    // rust: position: start,
    // rust: previous: start,
    // rust: velocity: v,
    // rust: state: State::Flying,
    // rust: last_deflected_by: None,
    // rust: needs_sync: false,
    // rust: tick_count: 0,
    // rust: life: 0,
    // rust: on_ground: false,
    // rust: nibble: 0,
    // rust: time_until_lured: 0,
    // rust: time_until_hooked: 0,
    // rust: fish_angle: 0.0,
    // rust: out_of_water: 0,
    // rust: open_water: true,
    // rust: luck,
    // rust: lure,
    // rust: lerp: HookLerp::default(),
    // rust: random,
    // rust: });
            // FishingRodItem.use counts a cast, not a reel-in.
    // rust: self.award_stat("used", "minecraft:fishing_rod", 1);
}
    // rust: self.swing_arm();
    // rust: true
}
    /// The boat the hook's owner rides (`Entity.isPassengerOfSameVehicle`).
pub fn own_vehicle(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.lan_acting {
    // rust: None => self.riding,
    // rust: Some(conn) => self.lan.as_ref().and_then(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == conn)
    // rust: .and_then(|g| g.vehicle)
    // rust: }),
}
}
    /// `FishingHook.retrieve`: the rod damage it costs.
pub fn retrieve_hook(self: *Self, rod: *ItemStack) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(mut hook) = self.hook.take() else {
    // rust: return 0;
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return 0;
}
    // rust: let owner = p.position;
    // rust: let mut damage = 0;
    // rust: if let State::Hooked(id) = hook.state {
            // pullEntity: 0.1 of the way to the owner.
    // rust: let d = Vec3::new(
    // rust: owner.x - hook.position.x,
    // rust: owner.y - hook.position.y,
    // rust: owner.z - hook.position.z,
    // rust: );
    // rust: let pulled = |v: Vec3| pull_hooked(v, hook.position, owner);
    // rust: let mut hooked_item = false;
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.velocity = pulled(m.velocity);
    // rust: } else if let Some(item) = self.dropped.iter_mut().find(|i| i.id == id) {
    // rust: pull_item(item, Vec3::new(d.x * 0.1, d.y * 0.1, d.z * 0.1));
    // rust: hooked_item = true;
    // rust: } else if let Some(t) = self.tnts.iter_mut().find(|t| t.id != 0 && t.id == id) {
    // rust: t.velocity = pulled(t.velocity);
    // rust: } else if let Some(a) = self.armor_stands.iter_mut().find(|a| a.id == id) {
    // rust: a.velocity = pulled(a.velocity);
    // rust: } else if let Some(b) = self.boats.iter_mut().find(|b| b.id == id) {
    // rust: b.velocity = pulled(b.velocity);
    // rust: } else if let Some(c) = self.carts.iter_mut().find(|c| c.id == id) {
                // `AbstractMinecart` is pickable, so `pullEntity` moves it too.
    // rust: c.velocity = pulled(c.velocity);
    // rust: } else if self.creatures.hook_targets.iter().any(|t| t.id == id) {
                // A player: the hub moves them when the tick ends.
    // rust: self.creatures
    // rust: .hook_pulls
    // rust: .push((id, Vec3::new(d.x * 0.1, d.y * 0.1, d.z * 0.1)));
}
            // CriteriaTriggers.FISHING_ROD_HOOKED with no items.
    // rust: let hooked = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| self.mob_entity(m));
    // rust: if let Some(hooked) = hooked {
    // rust: self.trigger_fishing_rod_hooked(rod, &hooked, &[]);
}
            // `hookedIn instanceof ItemEntity ? 3 : 5`.
    // rust: damage = if hooked_item { 3 } else { 5 };
    // rust: } else if hook.nibble > 0 {
    // rust: let biome = self.biome_name_at(hook.position);
    // rust: let Some(loot) = horizon_client::structure_blocks::loot_data(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: ) else {
    // rust: return damage;
}
            // `withLuck(this.luck + owner.getLuck())`: the rod's Luck of the Sea
            // plus the owner's luck attribute (the Luck and Bad Luck effects).
    // rust: let owner_luck = self
    // rust: .player
    // rust: .as_mut()
    // rust: .and_then(|p| p.attribute("minecraft:luck").ok())
    // rust: .unwrap_or(0.0) as f32;
            // FishingHook.retrieve calls LootTable.getRandomItems without an
            // explicit random source. LootContext uses the table's sequence,
            // or the level random if the table has no sequence.
    // rust: let luck = hook.luck as f32 + owner_luck;
    // rust: let items = fishing_loot(
    // rust: &loot,
    // rust: &mut self.rand_sequences,
    // rust: &mut self.world.random,
    // rust: self.level.seed,
    // rust: luck,
    // rust: biome.as_deref(),
    // rust: hook.open_water,
    // rust: );
    // rust: let mut caught = Vec::new();
    // rust: for stack in items {
                // FishingHook.retrieve: fish_caught for each catch in #minecraft:fishes.
    // rust: if self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:fishes")
    // rust: .is_some_and(|t| t.contains(stack.item.as_str()))
    // rust: {
    // rust: self.award_custom_stat("fish_caught", 1);
}
    // rust: let mut item = ItemStack {
    // rust: item: Arc::from(stack.item.as_str()),
    // rust: count: stack.count.max(1) as u32,
    // rust: damage: stack.damage.max(0) as u32,
    // rust: extra: None,
}
    // rust: for (id, level) in &stack.enchantments {
    // rust: if &*item.item == "minecraft:enchanted_book" {
    // rust: horizon_client::item_data::set_level(
    // rust: &mut item.data_mut().stored_enchantments,
    // rust: id,
    // rust: (*level).max(0) as u32,
    // rust: );
    // rust: } else {
    // rust: item.enchant(id, (*level).max(0) as u32);
}
}
    // rust: if let Some(potion) = &stack.potion {
    // rust: item = item.with_potion(potion);
}
    // rust: caught.push(item.clone());
    // rust: let (dx, dy, dz) = (
    // rust: owner.x - hook.position.x,
    // rust: owner.y - hook.position.y,
    // rust: owner.z - hook.position.z,
    // rust: );
    // rust: let v = [
    // rust: dx * 0.1,
    // rust: dy * 0.1 + (dx * dx + dy * dy + dz * dz).sqrt().sqrt() * 0.08,
    // rust: dz * 0.1,
    // rust: ];
    // rust: self.spawn_item(
    // rust: item,
    // rust: [hook.position.x, hook.position.y, hook.position.z],
    // rust: v,
    // rust: 0,
    // rust: );
    // rust: let xp = hook.random.next_int_bound(6).unwrap_or(0) as u32 + 1;
                // Vanilla constructs a single orb directly; ExperienceOrb.award
                // would split it and draw a merge id from the level random.
    // rust: self.add_orb([owner.x, owner.y + 0.5, owner.z + 0.5], xp);
}
            // CriteriaTriggers.FISHING_ROD_HOOKED: the hook itself is the entity.
    // rust: let bobber = EntityView {
    // rust: kind: "minecraft:fishing_bobber".into(),
    // rust: position: [hook.position.x, hook.position.y, hook.position.z],
    // rust: on_ground: hook.on_ground,
    // rust: fishing_open_water: Some(hook.open_water),
    // rust: ..Default::default()
}
    // rust: self.trigger_fishing_rod_hooked(rod, &bobber, &caught);
    // rust: damage = 1;
}
    // rust: if hook.on_ground {
    // rust: damage = 2;
}
    // rust: damage
}
    // rust: pub(super) fn biome_name_at(&self, p: Vec3) -> Option<String> {
    // rust: let (x, y, z) = (p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32);
    // rust: let c = self.world.chunks.get(&(x >> 4, z >> 4))?;
    // rust: Some(
    // rust: world_biomes!(self).list[c.biome(x, y, z) as usize]
    // rust: .name
    // rust: .clone(),
    // rust: )
}
pub fn water_height(self: *Self, x: i32, y: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = self.res.facts().get(self.world.block(x, y, z));
    // rust: if f.fluid != Fluid::Water {
    // rust: return None;
}
    // rust: let above = self.res.facts().get(self.world.block(x, y + 1, z));
    // rust: let h = if above.fluid == Fluid::Water {
    // rust: 1.0
    // rust: } else {
    // rust: f32::from(f.fluid_level) / 9.0
}
    // rust: Some((h, f.fluid_level == 8 && !f.fluid_falling))
}
    /// getOpenWaterTypeForBlock: 0 above water, 1 inside water, 2 invalid.
pub fn open_water_type(self: *Self, x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = self.res.facts().get(self.world.block(x, y, z));
    // rust: if self.world.is_air(self.world.block(x, y, z)) || &*f.name == "minecraft:lily_pad" {
    // rust: return 0;
}
    // rust: if f.fluid == Fluid::Water
    // rust: && f.fluid_level == 8
    // rust: && !f.fluid_falling
    // rust: && !f.full_collision
    // rust: && !f.legacy_solid
    // rust: {
    // rust: 1
    // rust: } else {
    // rust: 2
}
}
    /// calculateOpenWater over the 5x4x5 area around the hook.
pub fn calculate_open_water(self: *Self, b: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut previous = 2u8;
    // rust: for dy in -1..=2 {
    // rust: let mut layer = None;
    // rust: for dx in -2..=2 {
    // rust: for dz in -2..=2 {
    // rust: let t = self.open_water_type(b[0] + dx, b[1] + dy, b[2] + dz);
    // rust: layer = Some(match layer {
    // rust: None => t,
    // rust: Some(l) if l == t => l,
    // rust: Some(_) => 2,
    // rust: });
}
}
    // rust: let layer = layer.unwrap_or(2);
    // rust: match layer {
    // rust: 0 if previous == 2 => return false,
    // rust: 1 if previous == 0 => return false,
    // rust: 2 => return false,
    // rust: _ => {}
}
    // rust: previous = layer;
}
    // rust: true
}
    /// `FishingHook.catchingFish`.
pub fn catching_fish(self: *Self, h: *mut Hook, b: [i32; 3]) void {
}
    // rust: let mut speed = 1;
    // rust: let above = [b[0], b[1] + 1, b[2]];
    // rust: let sky = self.world.light(above[0], above[1], above[2]) >> 4 == 15;
        // Level.isRainingAt: rain (not snow) reaches the position.
    // rust: if h.random.next_float() < 0.25
    // rust: && self.with_level(|b, level, _| {
    // rust: b.is_raining_at(level, BlockPos::new(above[0], above[1], above[2]))
    // rust: })
    // rust: {
    // rust: speed += 1;
}
    // rust: if h.random.next_float() < 0.5 && !sky {
    // rust: speed -= 1;
}
    // rust: let at = [h.position.x, h.position.y, h.position.z];
    // rust: if h.nibble > 0 {
    // rust: h.nibble -= 1;
    // rust: if h.nibble <= 0 {
    // rust: h.time_until_lured = 0;
    // rust: h.time_until_hooked = 0;
}
    // rust: } else if h.time_until_hooked > 0 {
    // rust: h.time_until_hooked -= speed;
    // rust: if h.time_until_hooked > 0 {
                // The fish swimming up: a bubble now and then, and a fishing
                // particle to each side of its path.
    // rust: h.fish_angle += h.random.triangle(0.0, 9.188) as f32;
    // rust: let angle = h.fish_angle * (std::f64::consts::PI / 180.0) as f32;
    // rust: let (sin, cos) = (trig::sin(f64::from(angle)), trig::cos(f64::from(angle)));
    // rust: let distance = h.time_until_hooked as f32 * 0.1;
    // rust: let fish = [
    // rust: h.position.x + f64::from(sin * distance),
    // rust: f64::from(h.position.y.floor() as f32 + 1.0),
    // rust: h.position.z + f64::from(cos * distance),
    // rust: ];
    // rust: if self.water_block(fish) {
    // rust: if h.random.next_float() < 0.15 {
    // rust: let spread = [f64::from(sin), 0.1, f64::from(cos)];
    // rust: let at = [fish[0], fish[1] - f64::from(0.1f32), fish[2]];
    // rust: self.send_particles(ParticleType::Bubble, at, spread, 0.0, 1);
}
    // rust: let (x, z) = (sin * 0.04, cos * 0.04);
    // rust: for side in [1.0f32, -1.0] {
    // rust: let spread = [f64::from(z * side), 0.01, f64::from(-x * side)];
    // rust: self.send_particles(ParticleType::Fishing, fish, spread, 1.0, 0);
}
}
    // rust: } else {
                // The mods hear a server player's fish bite, and may call it
                // off: the wait starts over.
    // rust: if let (Some(uuid), Some(name)) =
    // rust: (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: let mut cancel = false;
    // rust: self.native_player_fish(uuid, &name, 1, &mut cancel);
    // rust: if cancel {
    // rust: h.time_until_lured = 0;
    // rust: h.time_until_hooked = 0;
    // rust: return;
}
}
    // rust: let pitch = 1.0 + (h.random.next_float() - h.random.next_float()) * 0.4;
    // rust: self.audio.play(
    // rust: "minecraft:entity.fishing_bobber.splash",
    // rust: Some(at),
    // rust: 0.25,
    // rust: pitch,
    // rust: );
                // The bite: bubbles and fishing particles around the bobber.
    // rust: let at = [h.position.x, h.position.y + 0.5, h.position.z];
    // rust: let count = (1.0 + SIZE as f32 * 20.0) as u32;
    // rust: let spread = [SIZE, 0.0, SIZE];
    // rust: for kind in [ParticleType::Bubble, ParticleType::Fishing] {
    // rust: self.send_particles(kind, at, spread, f64::from(0.2f32), count);
}
    // rust: h.trigger_bite(self.world.game_time);
}
    // rust: } else if h.time_until_lured > 0 {
    // rust: h.time_until_lured -= speed;
    // rust: let mut tease = 0.15f32;
    // rust: if h.time_until_lured < 20 {
    // rust: tease += (20 - h.time_until_lured) as f32 * 0.05;
    // rust: } else if h.time_until_lured < 40 {
    // rust: tease += (40 - h.time_until_lured) as f32 * 0.02;
    // rust: } else if h.time_until_lured < 60 {
    // rust: tease += (60 - h.time_until_lured) as f32 * 0.01;
}
    // rust: if h.random.next_float() < tease {
                // A splash where a fish is teasing the bait.
    // rust: let angle = (h.random.next_float() * 360.0) * (std::f64::consts::PI / 180.0) as f32;
    // rust: let distance = h.random.next_float() * 35.0 + 25.0;
    // rust: let fish = [
    // rust: h.position.x + f64::from(trig::sin(f64::from(angle)) * distance) * 0.1,
    // rust: f64::from(h.position.y.floor() as f32 + 1.0),
    // rust: h.position.z + f64::from(trig::cos(f64::from(angle)) * distance) * 0.1,
    // rust: ];
    // rust: if self.water_block(fish) {
    // rust: let count = 2 + h.random.next_int_bound(2).unwrap_or(0) as u32;
    // rust: let spread = [f64::from(0.1f32), 0.0, f64::from(0.1f32)];
    // rust: self.send_particles(ParticleType::Splash, fish, spread, 0.0, count);
}
}
    // rust: if h.time_until_lured <= 0 {
    // rust: h.fish_angle = h.random.next_float() * 360.0;
    // rust: h.time_until_hooked = 20 + h.random.next_int_bound(61).unwrap_or(0);
}
    // rust: } else {
    // rust: h.time_until_lured = 100 + h.random.next_int_bound(501).unwrap_or(0) - h.lure;
}
}
    /// `catchingFish`'s check below a fish: the block under it is water.
pub fn water_block(self: *Self, fish: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(
    // rust: fish[0].floor() as i32,
    // rust: (fish[1] - 1.0).floor() as i32,
    // rust: fish[2].floor() as i32,
    // rust: );
    // rust: &*self.res.facts().get(state).name == "minecraft:water"
}
    /// `ServerLevel.sendParticles` of a simple particle.
    // rust: fn send_particles(
    // rust: &mut self,
    // rust: kind: ParticleType,
    // rust: at: [f64; 3],
    // rust: spread: [f64; 3],
    // rust: speed: f64,
    // rust: count: u32,
    // rust: ) {
    // rust: let options = ParticleOptions::simple(kind);
    // rust: self.particles
    // rust: .send_particles(&options, at, spread, speed, count);
        // The players a server serves are sent them too.
    // rust: self.lan_send_particles(super::lan_particles::QueuedParticle {
    // rust: dimension: self.dim.id(),
    // rust: options,
    // rust: state: None,
    // rust: at,
    // rust: spread,
    // rust: speed: [speed; 3],
    // rust: count: count as i32,
    // rust: randomization: 0,
    // rust: });
}
    /// `FishingHook.tick`.
    // rust: pub(super) fn tick_fishing(&mut self) {
    // rust: let Some(mut h) = self.hook.take() else {
    // rust: return;
}
    // rust: h.needs_sync = false;
    // rust: let Some(owner) = self.player.as_ref().map(|p| p.position) else {
    // rust: return;
}
        // shouldStopFishing: a rod in either hand, within 32 blocks.
    // rust: let d2 = (h.position.x - owner.x).powi(2)
    // rust: + (h.position.y - owner.y).powi(2)
    // rust: + (h.position.z - owner.z).powi(2);
    // rust: if !self.holds_rod() || d2 > 1024.0 {
    // rust: return;
}
    // rust: h.tick_count += 1;
        // The players it can catch, as they stand now (the host's own hook;
        // guests' hooks use the ones taken as their turns start).
    // rust: if self.lan_acting.is_none()
    // rust: && matches!(h.state, State::Flying | State::Hooked(_))
    // rust: && let Some(host) = self.lan.take()
    // rust: {
    // rust: self.refresh_hook_targets(&host);
    // rust: self.lan = Some(host);
}
    // rust: h.previous = h.position;
    // rust: if h.on_ground {
    // rust: h.life += 1;
    // rust: if h.life >= 1200 {
    // rust: return;
}
    // rust: } else {
    // rust: h.life = 0;
}
    // rust: let b = [
    // rust: h.position.x.floor() as i32,
    // rust: h.position.y.floor() as i32,
    // rust: h.position.z.floor() as i32,
    // rust: ];
    // rust: let liquid = self.water_height(b[0], b[1], b[2]).map_or(0.0, |w| w.0);
    // rust: let in_water = liquid > 0.0;
    // rust: match h.state {
    // rust: State::Flying => {
    // rust: if in_water {
    // rust: h.velocity =
    // rust: Vec3::new(h.velocity.x * 0.3, h.velocity.y * 0.2, h.velocity.z * 0.3);
    // rust: h.state = State::Bobbing;
    // rust: self.hook = Some(h);
    // rust: return;
}
                // checkCollision: find the first block and entity on the movement
                // segment so a fast hook cannot tunnel or catch through a wall.
    // rust: let to = h.position.add_vector(h.velocity);
    // rust: let block_hit = self.hook_block_hit(h.position, to);
    // rust: let entity_end = block_hit.unwrap_or(to);
    // rust: let owner = self.lan_acting;
    // rust: let own_vehicle = self.own_vehicle();
    // rust: let hit = first_entity_hit(
    // rust: h.position,
    // rust: entity_end,
    // rust: entity_hit_margin(h.tick_count),
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive())
    // rust: .map(|m| (m.id, m.bounds()))
    // rust: .chain(
    // rust: self.creatures
    // rust: .hook_targets
    // rust: .iter()
    // rust: .filter(|t| t.conn != owner)
    // rust: .map(|t| (t.id, t.bounds)),
    // rust: )
    // rust: .chain(
    // rust: self.armor_stands
    // rust: .iter()
    // rust: .filter(|a| a.health > 0.0 && !a.marker)
    // rust: .map(|a| (a.id, a.bounds())),
    // rust: )
    // rust: .chain(
    // rust: self.boats
    // rust: .iter()
    // rust: .filter(|b| Some(b.id) != own_vehicle)
    // rust: .map(|b| (b.id, b.bounds())),
    // rust: )
    // rust: .chain(minecart_hook_targets(self.carts.iter(), own_vehicle))
    // rust: .chain(self.dropped.iter().map(|i| (i.id, i.bounds())))
    // rust: .chain(
    // rust: self.tnts
    // rust: .iter()
    // rust: .filter(|t| t.id != 0)
    // rust: .map(|t| (t.id, t.bounds())),
    // rust: ),
    // rust: );
    // rust: if let Some(id) = hit {
    // rust: let breeze = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| {
    // rust: m.id == id && m.species() == horizon_client::mobs::Species::Breeze
    // rust: })
    // rust: .map(|m| [m.position.x, m.position.y, m.position.z]);
    // rust: match h.hit_entity(id, breeze.is_some()) {
    // rust: EntityCollision::Deflected { first } => {
    // rust: if first {
    // rust: self.audio.play(
    // rust: "minecraft:entity.breeze.deflect",
    // rust: breeze,
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
}
    // rust: EntityCollision::Hooked => {
                            // Projectile.onHit on an entity: PROJECTILE_LAND.
    // rust: self.projectile_event(
    // rust: "minecraft:projectile_land",
    // rust: Some(horizon_client::mobs::Who::Player),
    // rust: [h.position.x, h.position.y, h.position.z],
    // rust: );
    // rust: self.hook = Some(h);
    // rust: return;
}
}
    // rust: } else if let Some(hit) = block_hit {
                    // Projectile.onHit on a block: PROJECTILE_LAND.
    // rust: self.projectile_event(
    // rust: "minecraft:projectile_land",
    // rust: Some(horizon_client::mobs::Who::Player),
    // rust: [hit.x, hit.y, hit.z],
    // rust: );
    // rust: h.velocity = rebound(h.velocity, hit, h.position);
}
}
    // rust: State::Hooked(id) => {
                // updateHookedEntity: ride the hooked mob, player or item at 0.8 of its height.
    // rust: let hooked = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id && m.alive())
    // rust: .map(|m| (m.position, f64::from(m.height())))
    // rust: .or_else(|| {
    // rust: self.creatures
    // rust: .hook_targets
    // rust: .iter()
    // rust: .find(|t| t.id == id)
    // rust: .map(|t| {
    // rust: let (lo, hi) = (t.bounds.min_position(), t.bounds.max_position());
    // rust: (
    // rust: Vec3::new((lo.x + hi.x) / 2.0, lo.y, (lo.z + hi.z) / 2.0),
    // rust: hi.y - lo.y,
    // rust: )
    // rust: })
    // rust: })
    // rust: .or_else(|| {
    // rust: self.armor_stands.iter().find(|a| a.id == id).map(|a| {
    // rust: let b = a.bounds();
    // rust: (a.position, b.max_position().y - b.min_position().y)
    // rust: })
    // rust: })
    // rust: .or_else(|| {
    // rust: self.boats
    // rust: .iter()
    // rust: .find(|b| b.id == id)
    // rust: .map(|b| (b.position, super::boats::HEIGHT))
    // rust: })
    // rust: .or_else(|| {
    // rust: self.carts
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| (c.position, super::minecarts::HEIGHT))
    // rust: })
    // rust: .or_else(|| {
    // rust: self.dropped
    // rust: .iter()
    // rust: .find(|i| i.id == id)
    // rust: .map(|i| (i.position, horizon_client::entities::ItemEntity::WIDTH))
    // rust: })
    // rust: .or_else(|| {
    // rust: self.tnts
    // rust: .iter()
    // rust: .find(|t| t.id != 0 && t.id == id)
    // rust: .map(|t| (t.position, super::tnt::PrimedTnt::SIZE))
    // rust: });
    // rust: match hooked {
    // rust: Some((at, height)) => h.position = Vec3::new(at.x, at.y + height * 0.8, at.z),
    // rust: None => h.state = State::Flying,
}
    // rust: self.hook = Some(h);
    // rust: return;
}
    // rust: State::Bobbing => {
    // rust: let v = h.velocity;
    // rust: let mut force = h.position.y + v.y - f64::from(b[1]) - f64::from(liquid);
    // rust: if force.abs() < 0.01 {
    // rust: force += force.signum() * 0.1;
}
    // rust: let r = f64::from(h.random.next_float());
    // rust: h.velocity = Vec3::new(v.x * 0.9, v.y - force * r * 0.2, v.z * 0.9);
    // rust: if h.nibble <= 0 && h.time_until_hooked <= 0 {
    // rust: h.open_water = true;
    // rust: } else {
    // rust: h.open_water =
    // rust: h.open_water && h.out_of_water < 10 && self.calculate_open_water(b);
}
    // rust: if in_water {
    // rust: h.out_of_water = (h.out_of_water - 1).max(0);
    // rust: if h.nibble > 0 {
    // rust: let mut sync_random = synchronized_random(h.id, self.world.game_time);
    // rust: let dip = -0.1
    // rust: * f64::from(sync_random.next_float())
    // rust: * f64::from(sync_random.next_float());
    // rust: h.velocity.y += dip;
}
    // rust: self.catching_fish(&mut h, b);
    // rust: } else {
    // rust: h.out_of_water = (h.out_of_water + 1).min(10);
}
}
}
    // rust: if !in_water && !h.on_ground {
    // rust: h.velocity.y -= f64::from(0.03_f32);
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: if let Ok(moved) = scene.resolve(bounds(h.position), h.velocity, 0.0, h.on_ground) {
    // rust: let horizontal =
    // rust: (moved.x - h.velocity.x).abs() > 1.0e-7 || (moved.z - h.velocity.z).abs() > 1.0e-7;
    // rust: h.on_ground = h.velocity.y < 0.0 && moved.y > h.velocity.y;
    // rust: h.position = Vec3::new(
    // rust: h.position.x + moved.x,
    // rust: h.position.y + moved.y,
    // rust: h.position.z + moved.z,
    // rust: );
    // rust: if h.state == State::Flying && (h.on_ground || horizontal) {
    // rust: h.velocity = Vec3::ZERO;
}
}
    // rust: self.entity_powder_snow_particles(h.previous, h.position, h.bounds(), h.velocity, false);
    // rust: h.velocity = Vec3::new(
    // rust: h.velocity.x * 0.92,
    // rust: h.velocity.y * 0.92,
    // rust: h.velocity.z * 0.92,
    // rust: );
    // rust: self.hook = Some(h);
}
    /// The players a hook can catch: everyone but spectators and the dead
    /// (`Projectile.canHitEntity`), the host and the guests in the level.
    // rust: pub(super) fn refresh_hook_targets(&mut self, host: &LanHost) {
    // rust: let mut targets = Vec::new();
    // rust: for g in &host.hub.guests {
    // rust: if host.hub.here(g) && g.loaded && !g.dead && !g.spectator() {
    // rust: targets.push(HookTarget {
    // rust: id: g.entity_id as u32,
    // rust: conn: Some(g.conn),
    // rust: bounds: guest_bounds(g),
    // rust: });
}
}
    // rust: self.creatures.hook_targets = targets;
}
    /// `FishingHook.pullEntity` on the players the hooks reeled in this tick
    /// pulled: their velocity moves, and a guest's reaches their client.
    // rust: pub(super) fn flush_hook_pulls(&mut self) {
    // rust: let pulls = std::mem::take(&mut self.creatures.hook_pulls);
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: for (id, delta) in pulls {
    // rust: let push = |g: &mut Self| {
    // rust: if let Some(p) = g.player.as_mut() {
    // rust: p.velocity = p.velocity.add_vector(delta);
}
}
    // rust: if let Some(conn) = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id as u32 == id)
    // rust: .map(|g| g.conn)
    // rust: {
    // rust: self.guest_hit_by(&mut host, conn, push);
}
}
    // rust: self.lan = Some(host);
}
    /// `FishingRodCast`: the stack in the arm holding the rod
    /// (`FishingHookRenderer.getHoldingArm`) while the hook is out.
    // rust: pub(super) fn cast_rod(&self) -> Option<&ItemStack> {
    // rust: self.hook.as_ref()?;
    // rust: if self.main_hand_rod() {
    // rust: self.held()
    // rust: } else {
    // rust: self.offhand.as_ref()
}
}
    // rust: pub(super) fn main_hand_rod(&self) -> bool {
    // rust: self.held()
    // rust: .is_some_and(|s| &*s.item == "minecraft:fishing_rod")
}
    /// The hook's position this frame.
pub fn hook_position(self: *Self, alpha: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = self.hook.as_ref()?;
    // rust: let lerp = |a: f64, b: f64| a + (b - a) * alpha;
    // rust: Some(glam::DVec3::new(
    // rust: lerp(h.previous.x, h.position.x),
    // rust: lerp(h.previous.y, h.position.y),
    // rust: lerp(h.previous.z, h.position.z),
    // rust: ))
}
    /// FishingHookRenderer: the bobbers (this player's and the others' a
    /// server tracks), camera-facing half-block quads centred on the hooks.
    // rust: pub(super) fn fishing_geometry(&self, camera: glam::DVec3, alpha: f64, out: &mut Vec<Vertex>) {
    // rust: let hooks: Vec<glam::DVec3> = self
    // rust: .hook_position(alpha)
    // rust: .into_iter()
    // rust: .chain(self.remote_hook_ends(alpha).into_iter().map(|(h, _)| h))
    // rust: .collect();
    // rust: if hooks.is_empty() {
    // rust: return;
}
    // rust: let Some(r) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("entity/fishing/fishing_hook")
    // rust: .copied()
    // rust: else {
    // rust: return;
}
    // rust: let forward = glam::DVec3::from_array(view_vector(self.yaw, self.pitch));
    // rust: let right = forward.cross(glam::DVec3::Y).normalize_or_zero();
    // rust: let up = right.cross(forward).normalize_or_zero();
    // rust: let s = 0.25;
    // rust: let uv = [[r.u0, r.v1], [r.u1, r.v1], [r.u1, r.v0], [r.u0, r.v0]];
    // rust: for p in hooks {
    // rust: let light =
    // rust: self.world
    // rust: .light(p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32);
    // rust: let packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
    // rust: let corners = [
    // rust: p - right * s - up * s,
    // rust: p + right * s - up * s,
    // rust: p + right * s + up * s,
    // rust: p - right * s + up * s,
    // rust: ];
    // rust: for (v, uv) in corners.iter().zip(uv) {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: (*v - camera).as_vec3().to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light: packed,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
    /// FishingHookRenderer: each line, 16 black `lines` segments sagging
    /// from a quarter block above the hook to the rod in its owner's hand,
    /// `width` pixels wide (`Window.getAppropriateLineWidth`).
    // rust: pub(super) fn fishing_line(&self, alpha: f64, size: [u32; 2]) -> Vec<Line> {
    // rust: let own = self
    // rust: .hook_position(alpha)
    // rust: .zip(self.rod_hand_position(alpha, size));
    // rust: let width = horizon_client::gfx::outline_width(size[0]);
    // rust: let mut lines = Vec::new();
    // rust: for (hook, hand) in own.into_iter().chain(self.remote_hook_ends(alpha)) {
    // rust: let offset = (hand - (hook + glam::DVec3::new(0.0, 0.25, 0.0))).as_vec3();
    // rust: let point = |a: f32| {
    // rust: let y = offset.y * (a * a + a) * 0.5 + 0.25;
    // rust: hook + glam::Vec3::new(offset.x * a, y, offset.z * a).as_dvec3()
}
    // rust: lines.extend((0..16).map(|i| Line {
    // rust: start: point(i as f32 / 16.0).to_array(),
    // rust: end: point((i + 1) as f32 / 16.0).to_array(),
    // rust: color: 0xFF00_0000,
    // rust: width,
    // rust: }));
}
    // rust: lines
}
    /// `FishingHookRenderer.getPlayerHandPos`: on the near plane in first
    /// person, beside the body otherwise.
pub fn rod_hand_position(self: *Self, alpha: f64, size: [u32; 2]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = self.player.as_ref()?;
    // rust: let right_arm = self.main_hand_rod() != self.settings.main_hand_left;
    // rust: let invert: f32 = if right_arm { 1.0 } else { -1.0 };
    // rust: let swing = trig::sin(f64::from(
    // rust: self.swing.animation(alpha as f32).sqrt() * std::f32::consts::PI,
    // rust: ));
    // rust: let feet = self.previous_position.lerp(p.position, alpha);
    // rust: let eye = glam::DVec3::new(feet.x, feet.y + f64::from(p.dimensions.eye_height), feet.z);
    // rust: if self.camera_type.first_person() {
    // rust: let fov = self.settings.fov as i32 as f32;
            // Camera.getNearPlane(fov).getPointOnPlane(invert * 0.525, -0.1).
    // rust: let aspect = f64::from(size[0]) / f64::from(size[1].max(1));
    // rust: let height =
    // rust: (f64::from(fov * (std::f64::consts::PI / 180.0) as f32) / 2.0).tan() * 0.05;
    // rust: let forward = glam::DVec3::from_array(view_vector(self.yaw, self.pitch));
    // rust: let left = -forward.cross(glam::DVec3::Y).normalize_or_zero();
    // rust: let up = forward.cross(left).normalize_or_zero();
    // rust: let point = forward * 0.05 + up * (height * -0.1)
    // rust: - left * (height * aspect * f64::from(invert * 0.525));
    // rust: let point = point * (960.0 / f64::from(fov));
            // Vec3.yRot(swing * 0.5), then xRot(-swing * 0.7).
    // rust: let (s, c) = (
    // rust: f64::from(trig::sin(f64::from(swing * 0.5))),
    // rust: f64::from(trig::cos(f64::from(swing * 0.5))),
    // rust: );
    // rust: let point = glam::DVec3::new(
    // rust: point.x * c + point.z * s,
    // rust: point.y,
    // rust: point.z * c - point.x * s,
    // rust: );
    // rust: let (s, c) = (
    // rust: f64::from(trig::sin(f64::from(-swing * 0.7))),
    // rust: f64::from(trig::cos(f64::from(-swing * 0.7))),
    // rust: );
    // rust: let point = glam::DVec3::new(
    // rust: point.x,
    // rust: point.y * c + point.z * s,
    // rust: point.z * c - point.y * s,
    // rust: );
    // rust: Some(eye + point)
    // rust: } else {
    // rust: let model = self.player_model.as_ref()?;
    // rust: let body =
    // rust: horizon_client::camera::lerp(alpha as f32, model.previous_body_yaw, model.body_yaw);
    // rust: let angle = f64::from(body * (std::f64::consts::PI / 180.0) as f32);
    // rust: let (sin, cos) = (f64::from(trig::sin(angle)), f64::from(trig::cos(angle)));
    // rust: let right = f64::from(invert) * 0.35;
    // rust: let crouch = if p.pose == Pose::Crouching {
    // rust: -0.1875
    // rust: } else {
    // rust: 0.0
}
    // rust: Some(
    // rust: eye + glam::DVec3::new(
    // rust: -cos * right - sin * 0.8,
    // rust: crouch - 0.45,
    // rust: -sin * right + cos * 0.8,
    // rust: ),
    // rust: )
}
}
}
    // rust: impl Game<'_> {
    /// The hooks drawn here, with their owners' ids (0 for this player's own).
    // rust: pub(super) fn hooks_status(&self) -> Vec<serde_json::Value> {
    // rust: let at = |p: Vec3| [p.x, p.y, p.z];
    // rust: let own = self.hook.iter().map(|h| (h.id, 0, h.position));
    // rust: let others = self
    // rust: .remote_hooks
    // rust: .iter()
    // rust: .map(|h| (h.id, h.owner, h.position));
    // rust: own.chain(others)
    // rust: .map(|(id, owner, p)| {
    // rust: serde_json::json!({"id": id, "kind": "minecraft:fishing_bobber", "owner": owner, "position": at(p)})
    // rust: })
    // rust: .collect()
}
    /// The hook for `horizon-ctl status`.
    // rust: pub(super) fn hook_status(&self) -> Option<serde_json::Value> {
    // rust: let h = self.hook.as_ref()?;
    // rust: Some(serde_json::json!({
    // rust: "state": format!("{:?}", h.state),
    // rust: "nibble": h.nibble,
    // rust: "lured_in": h.time_until_lured,
    // rust: "hooked_in": h.time_until_hooked,
    // rust: "open_water": h.open_water,
    // rust: }))
}
}

/// A hook a server tracks to this client (`FishingHook.recreateFromPacket`)
/// that another player cast: drawn where the server puts it, its line
/// running to that player's hand.
    // rust: pub(super) struct RemoteHook {
    // rust: id: u32,
    // rust: owner: u32,
    // rust: pub(super) position: Vec3,
    // rust: pub(super) previous: Vec3,
    // rust: velocity: Vec3,
    // rust: state: State,
    // rust: on_ground: bool,
    // rust: lerp: HookLerp,
    // rust: pub(super) random: LegacyRandom,
}

/// The `onGround` of a server's update (`handleMoveEntity`), except that a
/// hook resting on the ground stays so while the update does not lift it: the
/// server's tracker can send the flag a tick behind the landing.
pub fn resting(was: bool, at: Vec3, target: [f64; 3], sent: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sent || (was && target[1] <= at.y + 1.0e-3)
}

/// `LinearInterpolationHandler`: where a server's update has a hook heading
/// and the steps left (`DEFAULT_INTERPOLATION_STEPS` 3).
    // rust: pub(super) struct HookLerp {
    // rust: target: Vec3,
    // rust: steps: u32,
}
    // rust: impl HookLerp {
    /// `interpolateTo`: a new target restarts the steps, the same one does not.
pub fn start(self: *Self, target: [f64; 3]) void {
}
    // rust: let target = Vec3::new(target[0], target[1], target[2]);
    // rust: if self.steps == 0 || self.target != target {
    // rust: self.target = target;
    // rust: self.steps = 3;
}
}
    /// `doInterpolate`: a step of the way there.
pub fn step(self: *Self, at: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.steps == 0 {
    // rust: return at;
}
    // rust: let n = f64::from(self.steps);
    // rust: self.steps -= 1;
    // rust: Vec3::new(
    // rust: at.x + (self.target.x - at.x) / n,
    // rust: at.y + (self.target.y - at.y) / n,
    // rust: at.z + (self.target.z - at.z) / n,
    // rust: )
}
    /// `applyPredictedMovement`: what the hook moved by itself carries the
    /// target along while it is heading there.
pub fn moved(self: *Self, by: Vec3) void {
}
    // rust: if self.steps > 0 {
    // rust: self.target = Vec3::new(
    // rust: self.target.x + by.x,
    // rust: self.target.y + by.y,
    // rust: self.target.z + by.z,
    // rust: );
}
}
}

    // rust: impl Hook {
    // rust: pub(super) fn id(&self) -> u32 {
    // rust: self.id
}
    /// A server's update of this client's own hook (`handleMoveEntity` also
    /// sets `onGround`).
    // rust: pub(super) fn move_to(&mut self, target: [f64; 3], on_ground: bool) {
    // rust: self.on_ground = resting(self.on_ground, self.position, target, on_ground);
    // rust: self.lerp.start(target);
}
}
    // rust: impl RemoteHook {
    // rust: pub(super) fn id(&self) -> u32 {
    // rust: self.id
}
    /// A server's update of another player's hook.
    // rust: pub(super) fn move_to(&mut self, target: [f64; 3], on_ground: bool) {
    // rust: self.on_ground = resting(self.on_ground, self.position, target, on_ground);
    // rust: self.lerp.start(target);
}
}

    // rust: impl Hook {
    /// This client's own hook as its server tracks it: drawn, never ticked here.
pub fn remote(id: u32, at: Vec3) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: id,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: state: State::Flying,
    // rust: last_deflected_by: None,
    // rust: needs_sync: false,
    // rust: tick_count: 0,
    // rust: life: 0,
    // rust: on_ground: false,
    // rust: nibble: 0,
    // rust: time_until_lured: 0,
    // rust: time_until_hooked: 0,
    // rust: fish_angle: 0.0,
    // rust: out_of_water: 0,
    // rust: open_water: true,
    // rust: luck: 0,
    // rust: lure: 0,
    // rust: lerp: HookLerp::default(),
    // rust: random: LegacyRandom::new(unique_seed()),
}
}
    /// `FishingHook`'s entity for the players tracking it: the owner's id in
    /// its add packet, DATA_HOOKED_ENTITY (the hooked id plus one) and
    /// DATA_BITING when they differ from their defaults.
pub fn track(self: *Self, owner: i32, out: *mut States) void {
}
    // rust: let p = self.position;
    // rust: let e = out.add(
    // rust: self.id as i32,
    // rust: super::lan::entity_uuid(self.id),
    // rust: "minecraft:fishing_bobber",
    // rust: );
    // rust: e.position = [p.x, p.y, p.z];
    // rust: e.velocity = [self.velocity.x, self.velocity.y, self.velocity.z];
    // rust: e.on_ground = self.on_ground;
    // rust: e.needs_sync = self.needs_sync;
    // rust: e.data = owner;
    // rust: if let State::Hooked(id) = self.state {
    // rust: e.meta.push((8, serializer::INT, Value::Int(id as i32 + 1)));
}
    // rust: if self.nibble > 0 {
    // rust: e.meta.push((9, serializer::BOOLEAN, Value::Bool(true)));
}
}
}

    // rust: impl Game<'_> {
    /// The hooks guests track: each player's in the level.
    // rust: pub(super) fn lan_hook_states(
    // rust: &self,
    // rust: play: &HashMap<u32, GuestPlay>,
    // rust: hub: &Hub,
    // rust: out: &mut States,
    // rust: ) {
    // rust: for g in hub.guests.iter().filter(|g| hub.here(g)) {
    // rust: if let Some(h) = play.get(&g.conn).and_then(|p| p.hook.as_ref()) {
    // rust: h.track(g.entity_id, out);
}
}
}

    /// `handleAddEntity` for a fishing bobber: this player's own becomes its
    /// hook (`Player.fishing`), another player's is drawn on its line to them.
    // rust: pub(super) fn spawn_remote_hook(&mut self, id: u32, at: Vec3, velocity: Vec3, owner: i32) {
    // rust: let own = self.remote.as_ref().map(|r| r.entity_id);
    // rust: if own == Some(owner) {
    // rust: let mut hook = Hook::remote(id, at);
    // rust: hook.velocity = velocity;
    // rust: self.hook = Some(hook);
    // rust: } else {
    // rust: self.remote_hooks.push(RemoteHook {
    // rust: id,
    // rust: owner: owner as u32,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity,
    // rust: state: State::Flying,
    // rust: on_ground: false,
    // rust: lerp: HookLerp::default(),
    // rust: random: LegacyRandom::new(unique_seed()),
    // rust: });
}
}

    /// `FishingHook.onSyncedDataUpdated`: this player's hook is biting
    /// (DATA_BITING), which `status` shows as a nibble.
    // rust: pub(super) fn remote_hook_data(&mut self, id: u32, values: &[(u8, i32, Value)]) {
        // DATA_HOOKED_ENTITY (the hooked id plus one, 0 for none): a hook on a
        // client follows what it hooked (`FishingHook.onSyncedDataUpdated`).
    // rust: let time = self.world.game_time;
    // rust: let hooked = |value: &Value| match value {
    // rust: Value::Int(v) if *v > 0 => State::Hooked(*v as u32 - 1),
    // rust: _ => State::Flying,
}
    // rust: if let Some(h) = self
    // rust: .hook
    // rust: .as_mut()
    // rust: .filter(|h| h.id == id && self.remote.is_some())
    // rust: {
    // rust: for (index, _, value) in values {
    // rust: match (index, value) {
    // rust: (9, Value::Bool(biting)) => {
    // rust: h.nibble = i32::from(*biting);
    // rust: if *biting {
    // rust: h.velocity.y = bite_impulse(&mut synchronized_random(h.id, time));
}
}
    // rust: (8, value) => h.state = hooked(value),
    // rust: _ => {}
}
}
    // rust: } else if let Some(h) = self.remote_hooks.iter_mut().find(|h| h.id == id) {
    // rust: for (index, _, value) in values {
    // rust: match (index, value) {
    // rust: (9, Value::Bool(biting)) => {
    // rust: if *biting {
    // rust: h.velocity.y = bite_impulse(&mut synchronized_random(h.id, time));
}
}
    // rust: (8, value) => h.state = hooked(value),
    // rust: _ => {}
}
}
}
}

    /// `Entity.lerpMotion` for a hook a server tracks: the motion its own tick
    /// moves it on with between the tracker's updates.
    // rust: pub(super) fn remote_hook_motion(&mut self, id: u32, v: Vec3) -> bool {
    // rust: if self.remote.is_none() {
    // rust: return false;
}
    // rust: if let Some(h) = self.hook.as_mut().filter(|h| h.id == id) {
    // rust: h.velocity = v;
    // rust: } else if let Some(h) = self.remote_hooks.iter_mut().find(|h| h.id == id) {
    // rust: h.velocity = v;
    // rust: } else {
    // rust: return false;
}
    // rust: true
}

    /// `FishingHook.tick` on a client: the interpolation step towards the
    /// server's last update, then its own movement between the tracker's
    /// updates (every five ticks), floating in water and riding what it
    /// hooked, as the server's does.
    // rust: pub(super) fn tick_remote_hooks(&mut self) {
    // rust: if self.remote.is_none() {
    // rust: return;
}
    // rust: if let Some(mut h) = self.hook.take() {
    // rust: h.previous = h.position;
    // rust: h.position = h.lerp.step(h.position);
    // rust: let before = h.position;
    // rust: (h.position, h.velocity, h.state, h.on_ground) = self.client_hook_step(
    // rust: (h.position, h.velocity, h.state, h.on_ground),
    // rust: &mut h.random,
    // rust: );
    // rust: h.lerp.moved(h.position.subtract(before));
    // rust: self.hook = Some(h);
}
    // rust: let mut hooks = std::mem::take(&mut self.remote_hooks);
    // rust: for h in &mut hooks {
    // rust: h.previous = h.position;
    // rust: h.position = h.lerp.step(h.position);
    // rust: let before = h.position;
    // rust: (h.position, h.velocity, h.state, h.on_ground) = self.client_hook_step(
    // rust: (h.position, h.velocity, h.state, h.on_ground),
    // rust: &mut h.random,
    // rust: );
    // rust: h.lerp.moved(h.position.subtract(before));
}
    // rust: self.remote_hooks = hooks;
}

    /// `FishingHook.checkCollision` clips blocks on both sides of the connection.
pub fn hook_block_hit(self: *Self, from: Vec3, to: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: traverse_blocks(from, to, 1024, |p: BlockPos| {
    // rust: let state = self.world.block(p.x, p.y, p.z);
    // rust: if self.res.facts().is_air(state) {
    // rust: return None;
}
    // rust: self.collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .ok()?
    // rust: .clip(from, to, p)
    // rust: })
    // rust: .ok()
    // rust: .flatten()
    // rust: .map(|hit| hit.location)
}

    /// `FishingHook.tick`: one tick of movement without the fishing (the
    /// server's): position, motion, state and whether it rests on the ground.
    // rust: fn client_hook_step(
    // rust: &mut self,
    // rust: (mut position, mut velocity, state, mut on_ground): (Vec3, Vec3, State, bool),
    // rust: random: &mut impl RandomSource,
    // rust: ) -> (Vec3, Vec3, State, bool) {
    // rust: let b = [
    // rust: position.x.floor() as i32,
    // rust: position.y.floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ];
    // rust: let liquid = self.water_height(b[0], b[1], b[2]).map_or(0.0, |w| w.0);
    // rust: let in_water = liquid > 0.0;
    // rust: match state {
    // rust: State::Flying if in_water => {
    // rust: velocity = Vec3::new(velocity.x * 0.3, velocity.y * 0.2, velocity.z * 0.3);
    // rust: return (position, velocity, State::Bobbing, on_ground);
}
            // A landed hook: the server stopped it dead (zero motion) and sends no
            // more than the odd update; it does not fall on from here.
    // rust: State::Flying if velocity == Vec3::ZERO && on_ground => {
    // rust: return (position, velocity, state, on_ground);
}
    // rust: State::Flying => {
    // rust: if let Some(hit) = self.hook_block_hit(position, position.add_vector(velocity)) {
    // rust: velocity = rebound(velocity, hit, position);
}
}
    // rust: State::Hooked(id) => {
                // updateHookedEntity: at 0.8 of the hooked entity's height.
    // rust: let hooked = if self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.entity_id as u32 == id)
    // rust: {
    // rust: self.player
    // rust: .as_ref()
    // rust: .map(|p| (p.position, f64::from(p.dimensions.height)))
    // rust: } else {
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id && m.alive())
    // rust: .map(|m| (m.position, f64::from(m.height())))
    // rust: .or_else(|| {
    // rust: self.carts
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| (c.position, super::minecarts::HEIGHT))
    // rust: })
    // rust: .or_else(|| {
    // rust: self.dropped
    // rust: .iter()
    // rust: .find(|i| i.id == id)
    // rust: .map(|i| (i.position, horizon_client::entities::ItemEntity::WIDTH))
    // rust: })
}
    // rust: return match hooked {
    // rust: Some((at, height)) => (
    // rust: Vec3::new(at.x, at.y + height * 0.8, at.z),
    // rust: Vec3::ZERO,
    // rust: state,
    // rust: on_ground,
    // rust: ),
    // rust: None => (position, velocity, State::Flying, on_ground),
}
}
    // rust: State::Bobbing => {
    // rust: let mut force = position.y + velocity.y - f64::from(b[1]) - f64::from(liquid);
    // rust: if force.abs() < 0.01 {
    // rust: force += force.signum() * 0.1;
}
    // rust: let r = f64::from(random.next_float());
    // rust: velocity = Vec3::new(
    // rust: velocity.x * 0.9,
    // rust: velocity.y - force * r * 0.2,
    // rust: velocity.z * 0.9,
    // rust: );
}
}
    // rust: if !in_water && !on_ground {
    // rust: velocity.y -= f64::from(0.03_f32);
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: if let Ok(moved) = scene.resolve(bounds(position), velocity, 0.0, on_ground) {
    // rust: let horizontal =
    // rust: (moved.x - velocity.x).abs() > 1.0e-7 || (moved.z - velocity.z).abs() > 1.0e-7;
    // rust: on_ground = velocity.y < 0.0 && moved.y > velocity.y;
    // rust: position = Vec3::new(
    // rust: position.x + moved.x,
    // rust: position.y + moved.y,
    // rust: position.z + moved.z,
    // rust: );
    // rust: if state == State::Flying && (on_ground || horizontal) {
    // rust: velocity = Vec3::ZERO;
}
}
    // rust: velocity = Vec3::new(velocity.x * 0.92, velocity.y * 0.92, velocity.z * 0.92);
    // rust: (position, velocity, state, on_ground)
}

    // rust: pub(super) fn remove_remote_hook(&mut self, id: u32) {
    // rust: if self.remote.is_some() && self.hook.as_ref().is_some_and(|h| h.id == id) {
    // rust: self.hook = None;
}
    // rust: self.remote_hooks.retain(|h| h.id != id);
}

    // rust: pub(super) fn clear_remote_hooks(&mut self) {
    // rust: if self.remote.is_some() {
    // rust: self.hook = None;
}
    // rust: self.remote_hooks.clear();
}

    /// Other players' hooks: the bobber and its line to the owner's hand
    /// (`FishingHookRenderer.getPlayerHandPos` in third person), as
    /// (hook, hand) this frame.
pub fn remote_hook_ends(self: *Self, alpha: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lerp = |a: Vec3, b: Vec3| {
    // rust: glam::DVec3::new(
    // rust: a.x + (b.x - a.x) * alpha,
    // rust: a.y + (b.y - a.y) * alpha,
    // rust: a.z + (b.z - a.z) * alpha,
    // rust: )
}
    // rust: self.remote_hooks
    // rust: .iter()
    // rust: .filter_map(|h| {
    // rust: let owner = self.mobs.iter().find(|m| m.id == h.owner)?;
    // rust: let feet = lerp(owner.previous, owner.position);
    // rust: let body = horizon_client::camera::lerp(
    // rust: alpha as f32,
    // rust: owner.previous_body_yaw,
    // rust: owner.body_yaw,
    // rust: );
    // rust: let angle = f64::from(body * (std::f64::consts::PI / 180.0) as f32);
    // rust: let (sin, cos) = (f64::from(trig::sin(angle)), f64::from(trig::cos(angle)));
                // The right arm; a crouching owner's eyes are lower.
    // rust: let eye = owner.eye_y() - owner.position.y;
    // rust: let hand = feet
    // rust: + glam::DVec3::new(
    // rust: -cos * 0.35 - sin * 0.8,
    // rust: eye - 0.45,
    // rust: -sin * 0.35 + cos * 0.8,
    // rust: );
    // rust: Some((lerp(h.previous, h.position), hand))
    // rust: })
    // rust: .collect()
}
}

/// `FishingHook(Player, Level, int, int)`: `(ySin, yCos, y)` of the cast direction, using
/// `Mth.sin`/`Mth.cos` (the 65536-entry table), so straight down gives `xCos == -0.0`, y `-5`.
pub fn cast_direction(yaw: f32, pitch: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ya = f64::from(-yaw * trig::DEG_TO_RAD - std::f32::consts::PI);
    // rust: let pa = f64::from(-pitch * trig::DEG_TO_RAD);
    // rust: let (y_sin, y_cos) = (trig::sin(ya), trig::cos(ya));
    // rust: let (x_cos, x_sin) = (-trig::cos(pa), trig::sin(pa));
    // rust: (y_sin, y_cos, (-(x_sin / x_cos)).clamp(-5.0, 5.0))
}

    // rust: mod tests {
//     use super::{Hook, cast_direction, entity_hit_margin, first_entity_hit, pull_item, rebound};

    /// Compare the production loot selector to a real FishingHook.retrieve oracle.
pub fn fishing_retrieve_reference() void {
}
//         use horizon_core::random::{LegacyRandom, RandomSource};
//         use horizon_world::loot::{LootData, PackOverlay};
    // rust: let resources = std::env::var_os("HORIZON_FISHING_RESOURCES").unwrap();
    // rust: let path = std::env::var_os("HORIZON_FISHING_REFERENCE").unwrap();
    // rust: let rows: Vec<serde_json::Value> =
    // rust: serde_json::from_slice(&std::fs::read(path).unwrap()).unwrap();
    // rust: assert_eq!(rows.len(), 5, "missing vanilla retrieval cases");
    // rust: let loot = LootData::load(std::path::Path::new(&resources), &PackOverlay::NONE).unwrap();
    // rust: for row in rows {
    // rust: let seed = row["sequence_seed"].as_i64().unwrap();
    // rust: let mut sequences = horizon_client::random_sequences::RandomSequences::default();
    // rust: let mut level_random = LegacyRandom::new(1);
    // rust: let items = super::fishing_loot(
    // rust: &loot,
    // rust: &mut sequences,
    // rust: &mut level_random,
    // rust: seed,
    // rust: 0.0,
    // rust: None,
    // rust: true,
    // rust: );
    // rust: let drops = row["drops"].as_array().unwrap();
    // rust: let expected_items: Vec<_> = drops.iter().filter(|d| d.get("item").is_some()).collect();
    // rust: assert_eq!(row["damage"].as_i64(), Some(1), "seed {seed}");
    // rust: assert!(
    // rust: !expected_items.is_empty(),
    // rust: "missing vanilla catch for seed {seed}"
    // rust: );
    // rust: assert_eq!(items.len(), expected_items.len(), "seed {seed}");
    // rust: let mut hook_random = LegacyRandom::new(row["hook_seed"].as_i64().unwrap());
    // rust: for (item, expected) in items.iter().zip(expected_items) {
    // rust: assert_eq!(item.item, expected["item"].as_str().unwrap(), "seed {seed}");
    // rust: assert_eq!(i64::from(item.count), expected["count"].as_i64().unwrap());
    // rust: let xp = hook_random.next_int_bound(6).unwrap() + 1;
    // rust: assert!(
    // rust: drops
    // rust: .iter()
    // rust: .any(|d| d["xp"].as_i64() == Some(i64::from(xp)))
    // rust: );
}
    // rust: assert_eq!(
    // rust: hook_random.next_long(),
    // rust: row["hook_next"].as_i64().unwrap(),
    // rust: "seed {seed}"
    // rust: );
    // rust: assert_eq!(
    // rust: sequences
    // rust: .get("minecraft:gameplay/fishing", seed)
    // rust: .next_long(),
    // rust: row["sequence_next"].as_i64().unwrap(),
    // rust: "seed {seed}"
    // rust: );
}
    // rust: let casts: Vec<serde_json::Value> = serde_json::from_slice(
    // rust: &std::fs::read(std::env::var_os("HORIZON_FISHING_CAST_REFERENCE").unwrap()).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(casts.len(), 5, "missing vanilla cast cases");
    // rust: for row in casts {
    // rust: let mut random = LegacyRandom::new(row["seed"].as_i64().unwrap());
    // rust: let (sin, cos, vertical) = super::cast_direction(
    // rust: row["yaw"].as_f64().unwrap() as f32,
    // rust: row["pitch"].as_f64().unwrap() as f32,
    // rust: );
    // rust: let velocity = super::cast_velocity(sin, cos, vertical, &mut random);
    // rust: for (name, value) in [
    // rust: ("x_bits", velocity.x),
    // rust: ("y_bits", velocity.y),
    // rust: ("z_bits", velocity.z),
    // rust: ] {
    // rust: assert_eq!(value.to_bits() as i64, row[name].as_i64().unwrap(), "{row}");
}
    // rust: assert_eq!(random.next_long(), row["next"].as_i64().unwrap(), "{row}");
}
}
pub fn a_breeze_deflects_the_hook_without_attaching_it() void {
}
//         use super::{EntityCollision, Hook, State};
    // rust: let mut hook = Hook::remote(1, Vec3::ZERO);
    // rust: hook.velocity = Vec3::new(2.0, -0.4, 1.0);
    // rust: assert_eq!(
    // rust: hook.hit_entity(10, true),
    // rust: EntityCollision::Deflected { first: true }
    // rust: );
    // rust: assert_eq!(hook.state, State::Flying);
    // rust: assert!(hook.needs_sync);
    // rust: assert_eq!(hook.velocity, Vec3::new(-1.0, 0.2, -0.5));
    // rust: assert_eq!(
    // rust: hook.hit_entity(10, true),
    // rust: EntityCollision::Deflected { first: false }
    // rust: );
    // rust: assert_eq!(hook.velocity, Vec3::new(-1.0, 0.2, -0.5));
    // rust: assert_eq!(
    // rust: hook.hit_entity(11, true),
    // rust: EntityCollision::Deflected { first: true }
    // rust: );
    // rust: assert_eq!(hook.velocity, Vec3::new(0.5, -0.1, 0.25));
}

pub fn ordinary_targets_still_hook_and_a_deflection_is_tracked_immediately() void {
}
//         use super::{EntityCollision, Hook, State};
    // rust: let mut hook = Hook::remote(1, Vec3::ZERO);
    // rust: hook.velocity = Vec3::new(2.0, 0.0, 0.0);
    // rust: hook.hit_entity(10, true);
    // rust: let mut states = horizon_client::lan::entity::States::default();
    // rust: hook.track(99, &mut states);
    // rust: let state = &states.as_slice()[0];
    // rust: assert!(state.needs_sync);
    // rust: assert_eq!(state.velocity, [-1.0, -0.0, -0.0]);
    // rust: assert!(!state.meta.iter().any(|entry| entry.0 == 8));
    // rust: assert_eq!(hook.hit_entity(20, false), EntityCollision::Hooked);
    // rust: assert_eq!(hook.state, State::Hooked(20));
    // rust: assert_eq!(hook.velocity, Vec3::ZERO);
}

pub fn breeze_hook_parity_fixture() void {
}
//         use super::{EntityCollision, Hook, State};
//         use std::io::Write;
    // rust: let input =
    // rust: std::fs::read_to_string(std::env::var("HORIZON_BREEZE_HOOK_INPUT").unwrap()).unwrap();
    // rust: let mut out =
    // rust: std::fs::File::create(std::env::var("HORIZON_BREEZE_HOOK_OUTPUT").unwrap()).unwrap();
    // rust: for line in input.lines() {
    // rust: let parts: Vec<_> = line.split_whitespace().collect();
    // rust: let mut hook = Hook::remote(1, Vec3::ZERO);
    // rust: hook.velocity = Vec3::new(
    // rust: parts[1].parse().unwrap(),
    // rust: parts[2].parse().unwrap(),
    // rust: parts[3].parse().unwrap(),
    // rust: );
    // rust: let mut trace = Vec::new();
    // rust: for target in &parts[4..] {
    // rust: hook.needs_sync = false;
    // rust: let response = hook.hit_entity(target.parse::<u32>().unwrap() + 10, true);
    // rust: let sounds = i32::from(matches!(
    // rust: response,
    // rust: EntityCollision::Deflected { first: true }
    // rust: ));
    // rust: let landed = i32::from(matches!(response, EntityCollision::Hooked));
    // rust: trace.push(format!(
    // rust: "{:016x},{:016x},{:016x}:{sounds}:{landed}:{}:{}",
    // rust: hook.velocity.x.to_bits(),
    // rust: hook.velocity.y.to_bits(),
    // rust: hook.velocity.z.to_bits(),
    // rust: i32::from(hook.needs_sync),
    // rust: i32::from(matches!(hook.state, State::Hooked(_)))
    // rust: ));
}
    // rust: writeln!(out, "{}", trace.join(" ")).unwrap();
}
}

//     use horizon_client::{entities::ItemEntity, items::ItemStack};
//     use horizon_core::geometry::{Aabb, Vec3};

pub fn casting_straight_down_aims_down_and_straight_up_aims_up() void {
}
    // rust: assert_eq!(cast_direction(0.0, 90.0).2, -5.0);
    // rust: assert_eq!(cast_direction(123.0, 89.9).2, -5.0);
    // rust: assert_eq!(cast_direction(0.0, -90.0).2, 5.0);
    // rust: assert_eq!(cast_direction(0.0, 0.0).2, 0.0);
}

pub fn cast_direction_uses_the_vanilla_sine_table() void {
}
        // pitch 45: y = -(sin(-a) / -cos(-a)) with table entries built independently.
    // rust: let a = f64::from(-45.0_f32 * std::f32::consts::PI / 180.0);
    // rust: let table = |i: i64| ((i & 65535) as f64 / 10430.378350470453).sin() as f32;
    // rust: let (s, c) = (
    // rust: table((a * 10430.378350470453) as i64),
    // rust: -table((a * 10430.378350470453 + 16384.0) as i64),
    // rust: );
    // rust: let (_, _, y) = cast_direction(0.0, 45.0);
    // rust: assert!((y - (-(s / c))).abs() < 1e-3, "{y}");
}

    /// `HitResult.distanceTo` is squared: a hit 0.5 away rebounds at 0.25.
pub fn a_block_hit_rebounds_by_the_squared_distance() void {
}
    // rust: let v = Vec3::new(0.0, 0.0, -2.0);
    // rust: let hit = Vec3::new(0.0, 0.0, -0.5);
    // rust: assert_eq!(rebound(v, hit, Vec3::ZERO), Vec3::new(0.0, 0.0, -0.25));
}

pub fn reeling_an_item_requests_an_immediate_motion_update() void {
}
    // rust: let mut item = ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: id: 1,
    // rust: stack: ItemStack::new("minecraft:stone", 1),
    // rust: thrower: None,
    // rust: target: None,
    // rust: position: Vec3::ZERO,
    // rust: previous: Vec3::ZERO,
    // rust: velocity: Vec3::new(0.2, 0.0, -0.1),
    // rust: on_ground: true,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 0,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: 0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}

    // rust: pull_item(&mut item, Vec3::new(0.5, 0.1, -0.2));

    // rust: assert!((item.velocity.x - 0.7).abs() < 1.0e-12);
    // rust: assert!((item.velocity.y - 0.1).abs() < 1.0e-12);
    // rust: assert!((item.velocity.z + 0.3).abs() < 1.0e-12);
    // rust: assert!(item.needs_sync);
}

pub fn a_flying_hook_hits_a_small_target_between_ticks() void {
}
    // rust: let target = Aabb::new(Vec3::new(0.45, -0.1, -0.1), Vec3::new(0.7, 0.15, 0.1));

    // rust: assert!(super::segment_entry(Vec3::ZERO, Vec3::new(0.8, 0.0, 0.0), target).is_some());
    // rust: assert!(super::segment_entry(Vec3::ZERO, Vec3::new(0.4, 0.0, 0.0), target).is_none());
}

pub fn a_flying_hook_uses_vanillas_growing_entity_hit_margin() void {
}
    // rust: let start = Vec3::ZERO;
    // rust: let end = Vec3::new(1.0, 0.0, 0.0);
    // rust: let target = Aabb::new(Vec3::new(0.5, 0.31, -0.1), Vec3::new(0.7, 0.5, 0.1));

    // rust: assert_eq!(entity_hit_margin(2), 0.0);
    // rust: assert_eq!(entity_hit_margin(8), 0.3);
    // rust: assert_eq!(
    // rust: first_entity_hit(start, end, entity_hit_margin(8), [(1, target)]),
    // rust: None
    // rust: );
    // rust: let within_margin = Aabb::new(Vec3::new(0.5, 0.29, -0.1), Vec3::new(0.7, 0.5, 0.1));
    // rust: assert_eq!(
    // rust: first_entity_hit(start, end, entity_hit_margin(8), [(1, within_margin)]),
    // rust: Some(1)
    // rust: );
}

pub fn a_flying_hook_does_not_hit_a_target_it_starts_inside() void {
}
    // rust: let target = Aabb::new(Vec3::new(-0.1, -0.1, -0.1), Vec3::new(0.7, 0.15, 0.1));

    // rust: assert_eq!(
    // rust: first_entity_hit(Vec3::ZERO, Vec3::new(1.0, 0.0, 0.0), 0.0, [(1, target)]),
    // rust: None
    // rust: );
}

pub fn a_flying_hook_uses_the_first_target_along_its_path() void {
}
    // rust: let start = Vec3::ZERO;
    // rust: let end = Vec3::new(1.0, 0.0, 0.0);
    // rust: let near = Aabb::new(Vec3::new(0.45, -0.1, -0.1), Vec3::new(0.7, 0.15, 0.1));
    // rust: let far = Aabb::new(Vec3::new(0.8, -0.1, -0.1), Vec3::new(0.95, 0.15, 0.1));

    // rust: assert_eq!(
    // rust: first_entity_hit(start, end, 0.0, [(2, far), (1, near)]),
    // rust: Some(1)
    // rust: );
}

pub fn bite_triggers_initial_downward_plunge_impulse() void {
}
    // rust: for _ in 0..100 {
    // rust: let mut hook = Hook::remote(1, Vec3::ZERO);
    // rust: assert_eq!(hook.velocity.y, 0.0);
    // rust: hook.trigger_bite(0);
    // rust: assert!(
    // rust: hook.velocity.y < 0.0,
    // rust: "vertical velocity should be negative on bite, got {}",
    // rust: hook.velocity.y
    // rust: );
    // rust: assert!(
    // rust: hook.velocity.y <= -0.24 && hook.velocity.y >= -0.40,
    // rust: "vertical velocity {} not between -0.24 and -0.40",
    // rust: hook.velocity.y
    // rust: );
    // rust: assert!(
    // rust: hook.nibble >= 20 && hook.nibble <= 40,
    // rust: "nibble {} not in 20..=40",
    // rust: hook.nibble
    // rust: );
}
}

    /// A minecart is pickable (`AbstractMinecart.isPickable`), so the hook
    /// meets it. The cart the owner rides is the same vehicle and is skipped.
pub fn a_fishing_hook_meets_a_minecart_but_not_the_one_it_rides() void {
}
//         use super::super::minecarts::{CartKind, Minecart};
    // rust: let cart = Minecart::new(7, CartKind::Rideable, Vec3::new(0.6, 0.0, 0.0));
    // rust: let ridden = Minecart::new(3, CartKind::Chest, Vec3::new(0.2, 0.0, 0.0));
    // rust: let boxes = super::minecart_hook_targets([&cart, &ridden].into_iter(), Some(3));
    // rust: assert_eq!(
    // rust: first_entity_hit(Vec3::ZERO, Vec3::new(1.0, 0.0, 0.0), 0.0, boxes),
    // rust: Some(7)
    // rust: );
}

    /// `FishingHook.pullEntity` scales the hook-to-owner vector by 0.1.
pub fn reeling_pulls_a_hooked_minecart_a_tenth_of_the_way() void {
}
        // Still cart at the origin, owner 10 east and 2 up: +1 x and +0.2 y,
        // on top of the cart's own 0.5.
    // rust: let pulled = super::pull_hooked(
    // rust: Vec3::new(0.5, 0.0, 0.0),
    // rust: Vec3::ZERO,
    // rust: Vec3::new(10.0, 2.0, 0.0),
    // rust: );
    // rust: assert_eq!(pulled, Vec3::new(1.5, 0.2, 0.0));
}
}
