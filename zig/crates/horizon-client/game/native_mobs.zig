//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_mobs
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Mobs for native server mods (docs/native-mods.md, "Mobs", API 37): spawn one,
//! read the mobs of the level in place, and move, hurt or remove one by its id.
//! They act where the world is simulated, never on a client's copy, and only on
//! the level in place, which each names by its `dimension` (`minecraft:overworld`)
//! as `native_set_block` does: another one is refused. While the game ticks its
//! mobs they are out of the level: a mob a hook spawns then joins it after the
//! tick, and the others read as gone.
// use super::{Game, commands::Target};
// use horizon_core::geometry::Vec3;

/// The `EquipmentSlot` names of `Mob::equipment_stacks`, in its order.
    // rust: const MOB_SLOTS: [&str; 8] = [
    // rust: "mainhand", "offhand", "feet", "legs", "chest", "head", "body", "saddle",
    // rust: ];

    // rust: impl Game<'_> {
    /// `LivingEntity.collectEquipmentChanges` for the mobs that tick: each
    /// slot that holds another stack than the mods last heard is told
    /// (`native_living_equipment_change`). A mob new to the level counts from
    /// empty, as vanilla's `lastEquipmentItems` does. Only while a mod
    /// listens (`native_living_equipment_listened`): a mob's first tick after
    /// that counts from empty too.
    // rust: pub(super) fn native_mobs_equipment(&mut self) {
    // rust: if self.remote.is_some() || self.options.execution_role.is_client() {
    // rust: return;
}
        // Reading every mob's equipment each tick costs: only when a mod listens.
    // rust: let mut listened = false;
    // rust: self.native_living_equipment_listened(&mut listened);
    // rust: if !listened {
    // rust: return;
}
    // rust: let ticking = self.entity_ticking_area();
    // rust: let mut changes = Vec::new();
    // rust: for m in self.mobs.iter_mut().filter(|m| !m.removed) {
    // rust: if !ticking(m.position.x.floor() as i32, m.position.z.floor() as i32) {
    // rust: continue;
}
    // rust: let now = m.equipment_stacks();
    // rust: let heard = m.extra.equipment_heard.get_or_insert_with(Default::default);
    // rust: if **heard == now {
    // rust: continue;
}
    // rust: for (slot, name) in MOB_SLOTS.into_iter().enumerate() {
    // rust: if now[slot] != heard[slot] {
    // rust: let from = heard[slot].take();
    // rust: changes.push((m.id, m.kind.id.clone(), name, from, now[slot].clone()));
}
}
    // rust: **heard = now;
}
    // rust: for (id, kind, slot, from, to) in changes {
    // rust: self.native_living_equipment_change(id, &kind, slot, from.as_ref(), to.as_ref());
}
}
}

    // rust: impl Game<'_> {
    /// `LivingEntity.collectEquipmentChanges` for the server's players (they are living entities
    /// too): each slot whose stack differs from what the mods last heard is told, the previous
    /// stack with it, so a hotbar selection that moves the main hand counts. A player new to the
    /// level counts from empty, as for mobs, and only while a mod listens.
    // rust: pub(super) fn native_players_equipment(&mut self, host: &mut super::lan::LanHost) {
    // rust: let mut listened = false;
    // rust: self.native_living_equipment_listened(&mut listened);
    // rust: if !listened {
    // rust: return;
}
    // rust: let mut changes = Vec::new();
    // rust: for g in host.hub.guests.iter().filter(|g| host.hub.here(g)) {
    // rust: let now: [Option<crate::items::ItemStack>; 6] = [
    // rust: g.inventory.get(g.selected).cloned().flatten(),
    // rust: g.offhand.clone(),
    // rust: g.armor[3].clone(),
    // rust: g.armor[2].clone(),
    // rust: g.armor[1].clone(),
    // rust: g.armor[0].clone(),
    // rust: ];
    // rust: let Some(play) = host.play.get_mut(&g.conn) else {
    // rust: continue;
}
    // rust: let heard = play.equipment_heard.get_or_insert_with(Default::default);
    // rust: if **heard == now {
    // rust: continue;
}
    // rust: for (slot, name) in PLAYER_SLOTS.into_iter().enumerate() {
    // rust: if now[slot] != heard[slot] {
    // rust: let from = heard[slot].take();
    // rust: changes.push((g.entity_id as u32, name, from, now[slot].clone()));
}
}
    // rust: **heard = now;
}
    // rust: for (id, slot, from, to) in changes {
    // rust: self.native_living_equipment_change(
    // rust: id,
    // rust: "minecraft:player",
    // rust: slot,
    // rust: from.as_ref(),
    // rust: to.as_ref(),
    // rust: );
}
}
}

/// The `EquipmentSlot` names of a player's equipment, in the order of `native_players_equipment`.
pub const PLAYER_SLOTS: [[]const u8; 6] = ["mainhand", "offhand", "feet", "legs", "chest", "head"];

/// A mob as a native mod reads it.
    // rust: pub(crate) struct NativeMob {
    // rust: pub(crate) id: u32,
    /// The level it is in (`minecraft:overworld`).
    // rust: pub(crate) dimension: String,
    /// `minecraft:zombie`.
    // rust: pub(crate) kind: String,
    // rust: pub(crate) pos: [f64; 3],
    /// Degrees; 0 faces south.
    // rust: pub(crate) yaw: f32,
    // rust: pub(crate) health: f32,
    // rust: pub(crate) max_health: f32,
}

/// What a mob starts with (`native_spawn_mob`); the default is a plain mob.
    // rust: pub(crate) struct NativeSpawn {
    /// A name over it, shown to everyone.
    // rust: pub(crate) name: Option<String>,
    /// Cut to its maximum.
    // rust: pub(crate) health: Option<f32>,
    // rust: pub(crate) no_ai: bool,
    // rust: pub(crate) invisible: bool,
    // rust: pub(crate) silent: bool,
    // rust: pub(crate) invulnerable: bool,
    // rust: pub(crate) no_gravity: bool,
}

pub fn finite(v: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.into_iter().all(f64::is_finite)
}

/// `/summon`'s world bounds (`Level.isInSpawnableBounds`).
pub fn spawnable(pos: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: finite(pos)
    // rust: && (-30_000_000.0..30_000_000.0).contains(&pos[0])
    // rust: && (-30_000_000.0..30_000_000.0).contains(&pos[2])
    // rust: && (-20_000_000.0..20_000_000.0).contains(&pos[1].floor())
}

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// Whether this is a level that simulates (not a client's copy) and the one
    /// in place is `dimension`.
pub fn native_mob_level(self: *Self, dimension: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.remote.is_none() && dimension == self.dim.id()
}
    /// Spawns a mob of `kind` (`minecraft:zombie`) at `pos` in the level in
    /// place, `dimension`, finalized as a natural spawn is, and kept when the
    /// chunk unloads: its id. None for a kind the game doesn't know, another
    /// dimension, a position outside `/summon`'s bounds or in a chunk that isn't
    /// loaded (it would never tick or be saved), or a monster on peaceful (it
    /// would despawn at once). API 37.
    // rust: pub(super) fn native_spawn_mob(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: kind: &str,
    // rust: pos: [f64; 3],
    // rust: options: &NativeSpawn,
    // rust: ) -> Option<u32> {
    // rust: if !self.native_mob_level(dimension) || !spawnable(pos) || !self.native_chunk_loaded(pos) {
    // rust: return None;
}
    // rust: let qualified = if kind.contains(':') {
    // rust: kind.to_owned()
    // rust: } else {
    // rust: ["minecraft:", kind].concat()
}
    // rust: let monster = self
    // rust: .res
    // rust: .mob_types()
    // rust: .get(&qualified)
    // rust: .is_some_and(|t| t.category == "monster");
    // rust: if monster && self.ui.difficulty == 0 {
    // rust: return None;
}
    // rust: let id = self.spawn_mob(kind, pos, true)?;
        // A jockey's other mob comes after it: this one is found by its id.
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.no_ai = options.no_ai;
    // rust: m.invisible = options.invisible;
    // rust: m.silent = options.silent;
    // rust: m.invulnerable_flag = options.invulnerable;
    // rust: m.no_gravity = options.no_gravity;
    // rust: if let Some(name) = &options.name {
    // rust: m.custom_name = Some(name.clone());
    // rust: m.name_visible = true;
}
    // rust: if let Some(health) = options.health.filter(|h| h.is_finite() && *h > 0.0) {
    // rust: m.health = health.min(m.attrs.max_health);
}
}
    // rust: Some(id)
}
    /// Whether the chunk holding `pos` is loaded in the level in place.
pub fn native_chunk_loaded(self: *Self, pos: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, z) = (pos[0].floor() as i32, pos[2].floor() as i32);
    // rust: self.world.chunks.contains_key(&(x >> 4, z >> 4))
}
    /// The living mob `id` in the level in place, `dimension`; none on a
    /// client's copy. API 37.
    // rust: pub(super) fn native_mob(&self, dimension: &str, id: u32) -> Option<NativeMob> {
    // rust: if !self.native_mob_level(dimension) {
    // rust: return None;
}
    // rust: let mob = self.mobs.iter().find(|m| m.id == id && !m.removed)?;
    // rust: mob.alive().then(|| self.native_mob_of(mob))
}
    /// The living mobs in the level in place, `dimension`; none on a client's
    /// copy. API 37.
    // rust: pub(super) fn native_mobs(&self, dimension: &str) -> Vec<NativeMob> {
    // rust: if !self.native_mob_level(dimension) {
    // rust: return Vec::new();
}
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| !m.removed && m.alive())
    // rust: .map(|m| self.native_mob_of(m))
    // rust: .collect()
}
    /// Moves mob `id` to `pos` at once, as `/tp` does: it dismounts, drops its
    /// path and resets its fall. False for no such mob, another dimension or a
    /// position outside `/summon`'s bounds. API 37.
    // rust: pub(super) fn native_teleport_mob(&mut self, dimension: &str, id: u32, pos: [f64; 3]) -> bool {
    // rust: if !self.native_mob_level(dimension) || !spawnable(pos) {
    // rust: return false;
}
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id && !m.removed) else {
    // rust: return false;
}
    // rust: let to = Vec3::new(pos[0], pos[1], pos[2]);
        // `TeleportCommand`: stop the navigation, no vertical motion, and a
        // rider is put back on its vehicle unless it gets off first.
    // rust: m.ai.nav.stop();
    // rust: m.velocity.y = 0.0;
    // rust: m.extra.mount = None;
    // rust: m.extra.passenger = false;
    // rust: m.position = to;
    // rust: m.previous = to;
    // rust: m.fall_distance = 0.0;
    // rust: m.needs_sync = true;
    // rust: true
}
    /// Adds `velocity` to mob `id`'s: false for no such mob, another dimension
    /// or a velocity that isn't finite. API 37.
    // rust: pub(super) fn native_push_mob(&mut self, dimension: &str, id: u32, velocity: [f64; 3]) -> bool {
    // rust: if !self.native_mob_level(dimension) || !finite(velocity) {
    // rust: return false;
}
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id && !m.removed) else {
    // rust: return false;
}
    // rust: m.velocity = Vec3::new(
    // rust: m.velocity.x + velocity[0],
    // rust: m.velocity.y + velocity[1],
    // rust: m.velocity.z + velocity[2],
    // rust: );
    // rust: m.needs_sync = true;
    // rust: true
}
    /// Sets the living mob `id`'s health, cut to its maximum: false for no such
    /// mob, another dimension or a health that isn't above 0 (`native_kill_mob`
    /// kills). API 37.
    // rust: pub(super) fn native_set_mob_health(&mut self, dimension: &str, id: u32, health: f32) -> bool {
    // rust: if !self.native_mob_level(dimension) || !health.is_finite() || health <= 0.0 {
    // rust: return false;
}
    // rust: let Some(m) = self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .find(|m| m.id == id && !m.removed && m.alive())
    // rust: else {
    // rust: return false;
}
    // rust: m.health = health.min(m.attrs.max_health);
    // rust: m.needs_sync = true;
    // rust: true
}
    /// Kills mob `id` as `/kill` does: it falls and drops its loot. False for
    /// no such living mob or another dimension. API 37.
    // rust: pub(super) fn native_kill_mob(&mut self, dimension: &str, id: u32) -> bool {
    // rust: if self.native_mob(dimension, id).is_none() {
    // rust: return false;
}
    // rust: self.kill_target(Target::Mob(id));
    // rust: true
}
    /// Takes mob `id` out of the world with no death and no loot: false for no
    /// such mob or another dimension. API 37.
    // rust: pub(super) fn native_remove_mob(&mut self, dimension: &str, id: u32) -> bool {
    // rust: if !self.native_mob_level(dimension) {
    // rust: return false;
}
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id && !m.removed) else {
    // rust: return false;
}
    // rust: m.removed = true;
    // rust: true
}
pub fn native_mob_of(self: *Self, m: *horizon_client::mobs::Mob) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NativeMob {
    // rust: id: m.id,
    // rust: dimension: self.dim.id().to_owned(),
    // rust: kind: horizon_client::command::args::normalize(&m.kind.id),
    // rust: pos: [m.position.x, m.position.y, m.position.z],
    // rust: yaw: m.yaw,
    // rust: health: m.health,
    // rust: max_health: m.attrs.max_health,
}
}
}
