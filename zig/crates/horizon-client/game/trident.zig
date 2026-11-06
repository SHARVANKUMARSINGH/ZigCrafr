//! Transpiled from Horizon Rust crate
//! Module: horizon-client_trident
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Tridents: `TridentItem.releaseUsing` (throw after 10 ticks, or Riptide in
//! water or rain) and `ThrownTrident` (arrow flight with 0.99 water inertia,
//! 8 damage plus Impaling, the reversed bounce off a hit, sticking, Loyalty's
//! return to the owner, pickup) with `ThrownTridentRenderer`, and Channeling's
//! lightning on a hit (`channeling.json`).
// use super::{Game, view_vector};
// use horizon_client::{
    // rust: arrows::{back_off, clip_block_hit},
    // rust: collisions::SceneCollisions,
    // rust: enchant::EffectContext,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::{Damage, DamageKind, Species, Who, anim::Poses},
    // rust: projectiles::ProjectileWorld,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, traverse_blocks},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}

    // rust: pub(super) struct ThrownTrident {
    /// When it joined its list (`horizon_client::join_seq`); set by the list.
    // rust: pub(super) join: horizon_client::join_seq::JoinSeq,
    /// The entity id a server tracks it by (0 until it is tracked).
    // rust: pub id: u32,
    // rust: pub(super) stack: ItemStack,
    // rust: pub(super) position: Vec3,
    // rust: pub(super) previous: Vec3,
    // rust: pub(super) velocity: Vec3,
    // rust: pub(super) yaw: f32,
    // rust: pub(super) pitch: f32,
    // rust: pub(super) in_ground: bool,
    // rust: in_ground_time: u32,
    /// `AbstractArrow.shakeTime`: seven ticks after sticking, no pickup.
    // rust: shake: u32,
    // rust: dealt_damage: bool,
    // rust: pub(super) loyalty: u32,
    // rust: pub(super) no_physics: bool,
    // rust: returning: u32,
    // rust: creative_only: bool,
    /// `Entity.isNoGravity`: `AbstractArrow.applyGravity` then skips the pull.
    // rust: pub(super) no_gravity: bool,
    /// `Entity.remainingFireTicks`; on clients, the synchronized on-fire flag.
    // rust: pub(super) fire_ticks: i32,
    /// Water membership from the preceding `baseTick` (not updated while stuck).
    // rust: was_touching_water: bool,
    /// `Entity.random`, used for the extinguishing sound and a breeze's turn.
    // rust: random: horizon_core::random::LegacyRandom,
    /// `Projectile.lastDeflectedBy`: the breeze that already turned this trident.
    // rust: deflected_by: Option<u32>,
    /// `Entity.tickCount`: `ProjectileUtil.computeMargin` grows with it.
    // rust: age: u32,
    /// The entity id a server sent as its owner (the one Loyalty returns it to).
    // rust: pub(super) owner: u32,
    /// The guest that threw it (`Projectile.getOwner`); `None` for the host.
    // rust: pub(super) guest: Option<u32>,
}
/// A player a trident can return to (its owner) or that can pick it up: this
/// game's own, or a server's guest in this level, which is all a server has.
pub const Catcher = struct {
    /// The guest's connection; `None` for this game's player.
    guest: ?u32,
    /// The guest's entity id (unused for this game's player).
    id: i32,
    feet: Vec3,
    eye: Vec3,
    /// `Player.aiStep` touches things only while alive and not a spectator.
    touches: bool,
};
    // rust: impl ThrownTrident {
    /// A trident loaded from its NBT (`AbstractArrow.readAdditionalSaveData`).
    // rust: pub(super) fn from_nbt(n: horizon_client::entity_nbt::TridentNbt) -> Self {
    // rust: let mut t = Self::remote(0, n.position, n.yaw, n.pitch);
    // rust: t.loyalty = n.item.enchantment_level("minecraft:loyalty");
    // rust: t.stack = n.item;
    // rust: t.velocity = n.motion;
    // rust: t.in_ground = n.in_ground;
    // rust: t.in_ground_time = n.life.max(0) as u32;
    // rust: t.shake = n.shake;
    // rust: t.dealt_damage = n.dealt_damage;
    // rust: t.creative_only = n.creative_only;
    // rust: t.no_gravity = n.no_gravity;
    // rust: t.fire_ticks = n.fire_ticks;
    // rust: t
}
    /// `AbstractArrow.addAdditionalSaveData` + `DealtDamage`.
    // rust: pub(super) fn to_nbt(
    // rust: &self,
    // rust: uuid: [i32; 4],
    // rust: raw: Option<&horizon_world::nbt::Tag>,
    // rust: ) -> horizon_world::nbt::Tag {
    // rust: horizon_client::entity_nbt::trident_to_nbt(
    // rust: &horizon_client::entity_nbt::TridentSave {
    // rust: position: self.position,
    // rust: motion: self.velocity,
    // rust: yaw: self.yaw,
    // rust: pitch: self.pitch,
    // rust: in_ground: self.in_ground,
    // rust: life: self.in_ground_time as i32,
    // rust: shake: self.shake,
    // rust: dealt_damage: self.dealt_damage,
    // rust: creative_only: self.creative_only,
    // rust: no_gravity: self.no_gravity,
    // rust: fire_ticks: self.fire_ticks,
    // rust: item: &self.stack,
    // rust: },
    // rust: uuid,
    // rust: raw,
    // rust: )
}
    /// A trident a server sent (`handleAddEntity`): placed and moved by it.
    // rust: pub(super) fn remote(id: u32, position: Vec3, yaw: f32, pitch: f32) -> Self {
    // rust: Self {
    // rust: join: Default::default(),
    // rust: id,
    // rust: stack: ItemStack::new("minecraft:trident", 1),
    // rust: position,
    // rust: previous: position,
    // rust: velocity: Vec3::ZERO,
    // rust: yaw,
    // rust: pitch,
    // rust: in_ground: false,
    // rust: in_ground_time: 0,
    // rust: shake: 0,
    // rust: dealt_damage: false,
    // rust: loyalty: 0,
    // rust: no_physics: false,
    // rust: returning: 0,
    // rust: creative_only: false,
    // rust: no_gravity: false,
    // rust: fire_ticks: 0,
    // rust: was_touching_water: false,
    // rust: random: horizon_core::random::LegacyRandom::new(i64::from(id)),
    // rust: age: 0,
    // rust: owner: 0,
    // rust: guest: None,
    // rust: deflected_by: None,
}
}
    /// `ThrownTrident.tick`'s Loyalty return: pulled up and towards the
    /// owner's eye.
pub fn loyalty_pull(self: *Self, owner_eye: Vec3) void {
}
    // rust: let v = Vec3::new(
    // rust: owner_eye.x - self.position.x,
    // rust: owner_eye.y - self.position.y,
    // rust: owner_eye.z - self.position.z,
    // rust: );
    // rust: self.position.y += v.y * 0.015 * f64::from(self.loyalty);
    // rust: let len = (v.x * v.x + v.y * v.y + v.z * v.z).sqrt().max(1e-9);
    // rust: let accel = 0.05 * f64::from(self.loyalty);
    // rust: self.velocity = Vec3::new(
    // rust: self.velocity.x * 0.95 + v.x / len * accel,
    // rust: self.velocity.y * 0.95 + v.y / len * accel,
    // rust: self.velocity.z * 0.95 + v.z / len * accel,
    // rust: );
}
    /// `ThrownTrident.tick` on a server's client: it flies on by itself
    /// between the server's updates (`AbstractArrow.tick`: gravity and drag,
    /// a block holds it), and Loyalty pulls it back to its owner; only the
    /// server decides what it hits.
    // rust: pub(super) fn remote_tick(&mut self, w: &impl ProjectileWorld, owner_eye: Option<Vec3>) {
    // rust: self.previous = self.position;
    // rust: self.shake = self.shake.saturating_sub(1);
    // rust: if self.in_ground_time > 4 {
    // rust: self.dealt_damage = true;
}
    // rust: if self.loyalty > 0
    // rust: && (self.dealt_damage || self.no_physics)
    // rust: && let Some(eye) = owner_eye
    // rust: {
    // rust: self.no_physics = true;
    // rust: self.in_ground = false;
    // rust: self.loyalty_pull(eye);
}
    // rust: if self.in_ground && !self.no_physics {
    // rust: self.in_ground_time += 1;
    // rust: return;
}
    // rust: self.in_ground_time = 0;
    // rust: let m = self.velocity;
    // rust: let (x, z) = if self.no_physics {
    // rust: (-m.x, -m.z)
    // rust: } else {
    // rust: (m.x, m.z)
}
    // rust: self.yaw = x.atan2(z).to_degrees() as f32;
    // rust: self.pitch = m.y.atan2(m.x.hypot(m.z)).to_degrees() as f32;
    // rust: let to = self.position.add_vector(m);
    // rust: if !self.no_physics
    // rust: && let Some((at, _, _)) = w.clip(self.position, to)
    // rust: {
            // AbstractArrow.onHitBlock's back-off, as the server's tick does it.
    // rust: self.position = back_off(at, m);
    // rust: self.velocity = Vec3::ZERO;
    // rust: self.in_ground = true;
    // rust: self.shake = 7;
    // rust: return;
}
    // rust: self.position = to;
        // A trident's water inertia (0.99) equals the air drag.
    // rust: self.velocity = self.velocity.scale(0.99);
    // rust: if !self.no_physics && !self.no_gravity {
    // rust: self.velocity.y -= 0.05;
}
}
}
pub const HALF: f64 = 0.25;
/// `Breeze.PROJECTILE_DEFLECTION`: `ProjectileDeflection.REVERSE` at power
/// `(1, 1, 1)`. Each axis is multiplied by `-0.5`, and the yaw turns by
/// `170 + nextFloat * 20`.
pub fn breeze_deflect(velocity: Vec3, yaw: f32, jitter: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: Vec3::new(velocity.x * -0.5, velocity.y * -0.5, velocity.z * -0.5),
    // rust: yaw + 170.0 + jitter * 20.0,
    // rust: )
}
/// The entry distance of a segment into a box, if it crosses it.
pub fn segment_box(from: Vec3, d: Vec3, b: Aabb) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let (o, d, lo, hi) = (
    // rust: [from.x, from.y, from.z],
    // rust: [d.x, d.y, d.z],
    // rust: [lo.x, lo.y, lo.z],
    // rust: [hi.x, hi.y, hi.z],
    // rust: );
    // rust: let (mut t0, mut t1) = (0.0f64, 1.0f64);
    // rust: for a in 0..3 {
    // rust: if d[a].abs() < 1e-12 {
    // rust: if o[a] < lo[a] || o[a] > hi[a] {
    // rust: return None;
}
    // rust: continue;
}
    // rust: let (mut ta, mut tb) = ((lo[a] - o[a]) / d[a], (hi[a] - o[a]) / d[a]);
    // rust: if ta > tb {
    // rust: std::mem::swap(&mut ta, &mut tb);
}
    // rust: t0 = t0.max(ta);
    // rust: t1 = t1.min(tb);
}
    // rust: (t0 <= t1).then_some(t0)
}
    // rust: impl Game<'_> {
    /// The trident stack's maximum damage component, else its item's default.
    // rust: pub(super) fn trident_max_damage(&self, stack: &ItemStack) -> u32 {
    // rust: stack
    // rust: .data()
    // rust: .and_then(|data| match data.other("minecraft:max_damage") {
    // rust: Some(horizon_world::nbt::Tag::Int(value)) => u32::try_from(*value).ok(),
    // rust: _ => None,
    // rust: })
    // rust: .unwrap_or_else(|| self.items().get(&stack.item).map_or(250, |i| i.max_damage))
}
    /// `TridentItem.use`: start the throw unless one more use would break it.
    /// Returns false for `InteractionResult.FAIL` (about to break, or Riptide
    /// while dry) so callers neither dip the hand nor consume the click.
    // rust: pub(super) fn use_trident(&mut self, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:trident" {
    // rust: return false;
}
    // rust: let max = self.trident_max_damage(stack);
    // rust: let riptide = stack.enchantment_level("minecraft:riptide") > 0;
    // rust: if stack.damage >= max.saturating_sub(1) || (riptide && !self.in_water_or_rain()) {
    // rust: return false;
}
    // rust: self.start_using_item();
    // rust: true
}
pub fn in_water_or_rain(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(p) = &self.player else { return false };
    // rust: let (x, y, z) = (
    // rust: p.position.x.floor() as i32,
    // rust: p.position.y.floor() as i32,
    // rust: p.position.z.floor() as i32,
    // rust: );
    // rust: let water = self.res.facts().get(self.world.block(x, y, z)).fluid
    // rust: == horizon_client::blocks::Fluid::Water;
    // rust: let (at, top) = (p.position, p.bounds().max_position().y);
    // rust: water || self.in_rain(at, top)
}
    /// The `summon_entity` and `play_sound` effects of `channeling.json`: in a
    /// thunderstorm (`weather_check`) a spot that sees the sky (`can_see_sky`)
    /// gets a lightning bolt and the thunder sound.
pub fn channel_lightning(self: *Self, at: [f64; 3], guest: ?u32) void {
}
        // Level.isThundering: the thunder level, in dimensions with weather.
    // rust: if !self.can_have_weather() || self.weather_levels(1.0).1 <= 0.9 {
    // rust: return;
}
        // BlockAndLightGetter.canSeeSky: full sky light.
    // rust: let (x, y, z) = (
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: if self.world.light(x, y, z) >> 4 != 15 {
    // rust: return;
}
    // rust: if !self.lightning_strike_allowed(self.lan_acting_uuid, [x, y, z], "trident") {
    // rust: return;
}
    // rust: self.spawn_bolt(at, false);
        // The summon effect's owner is the thrower: LightningBolt.setCause.
    // rust: if let Some(bolt) = self.bolts.last_mut() {
    // rust: bolt.cause = Some(guest);
}
    // rust: self.audio
    // rust: .play("minecraft:item.trident.thunder", Some(at), 5.0, 1.0);
}
    /// `minecraft:hit_block` of Channeling (`AbstractArrow.hitBlockEnchantmentEffects`):
    /// the block the trident's path first hits, if it is a lightning rod, with
    /// the hit location clamped into the block (`BlockPos.clampLocationWithin`).
pub fn channel_rod_hit(self: *Self, from: Vec3, velocity: Vec3, guest: ?u32) void {
}
    // rust: let to = Vec3::new(
    // rust: from.x + velocity.x,
    // rust: from.y + velocity.y,
    // rust: from.z + velocity.z,
    // rust: );
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
        // ClipContext.Block.COLLIDER with Fluid.NONE.
    // rust: let hit = traverse_blocks(from, to, 1024, |p: BlockPos| {
    // rust: let state = self.world.block(p.x, p.y, p.z);
    // rust: if self.res.facts().is_air(state) {
    // rust: return None;
}
    // rust: let shape = self
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .ok()?;
    // rust: shape.clip(from, to, p)
    // rust: });
    // rust: let Some(hit) = hit.ok().flatten() else {
    // rust: return;
}
    // rust: let state = self.world.block(hit.block.x, hit.block.y, hit.block.z);
    // rust: if !self.res.facts().get(state).name.ends_with("lightning_rod") {
    // rust: return;
}
    // rust: let edge = f64::from(1.0e-5f32);
    // rust: let clamp =
    // rust: |v: f64, origin: i32| v.clamp(f64::from(origin) + edge, f64::from(origin) + 1.0 - edge);
    // rust: self.channel_lightning(
    // rust: [
    // rust: clamp(hit.location.x, hit.block.x),
    // rust: clamp(hit.location.y, hit.block.y),
    // rust: clamp(hit.location.z, hit.block.z),
    // rust: ],
    // rust: guest,
    // rust: );
}
    /// `TridentItem.releaseUsing`.
    // rust: pub(super) fn release_trident(&mut self, ticks: u32) {
    // rust: if ticks < 10 {
    // rust: return;
}
    // rust: let Some(stack) = self.held().cloned() else {
    // rust: return;
}
    // rust: let Some(eye) = self.eye_position() else {
    // rust: return;
}
    // rust: let riptide = stack.enchantment_level("minecraft:riptide");
        // `releaseUsing` checks the wet/passenger conditions, then nextDamageWillBreak again.
    // rust: if riptide > 0 && (!self.in_water_or_rain() || self.riding.is_some()) {
    // rust: return;
}
    // rust: if stack.damage >= self.trident_max_damage(&stack).saturating_sub(1) {
    // rust: return;
}
        // Counted (on the server) before the throw or the spin.
    // rust: if self.remote.is_none() {
    // rust: self.award_stat("used", "minecraft:trident", 1);
}
    // rust: if riptide > 0 {
            // `hurtWithoutBreaking` and the sound belong to the server; a server's
            // client only launches.
    // rust: let server_client = self.remote.is_some();
    // rust: if !server_client {
    // rust: self.hurt_held_without_breaking(1);
}
            // trident_spin_attack_strength: 1.5 + 0.75 per level above the first.
    // rust: let strength = 1.5 + 0.75 * (riptide as f32 - 1.0);
    // rust: let d = view_vector(self.yaw, self.pitch);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.velocity = Vec3::new(
    // rust: p.velocity.x + d[0] * f64::from(strength),
    // rust: p.velocity.y + d[1] * f64::from(strength),
    // rust: p.velocity.z + d[2] * f64::from(strength),
    // rust: );
                // Player.startAutoSpinAttack(20, 8, stack).
    // rust: p.auto_spin_attack_ticks = 20;
    // rust: p.auto_spin_attack_dmg = 8.0;
}
            // `player.move(SELF, (0, 1.1999999, 0))` when on the ground: the lift
            // stops at a ceiling.
    // rust: let lift = self
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|p| p.ground.on_ground)
    // rust: .map(|p| p.bounds());
    // rust: if let Some(bounds) = lift {
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let up = Vec3::new(0.0, f64::from(1.1999999f32), 0.0);
    // rust: let moved = scene.resolve(bounds, up, 0.0, true).unwrap_or(Vec3::ZERO);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.position.y += moved.y;
}
}
    // rust: if !server_client {
    // rust: let sound = format!("minecraft:item.trident.riptide_{}", riptide.min(3));
    // rust: self.play_player_bound_sound(&sound, 7, 1.0, 1.0, false);
    // rust: if let (Some(player), Some(name)) =
    // rust: (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_riptide(player, &name);
}
}
    // rust: return;
}
        // The server throws the trident.
    // rust: if self.remote.is_some() {
    // rust: return;
}
        // hurtWithoutBreaking (Unbreaking applies), then the thrown copy.
    // rust: self.hurt_held_without_breaking(1);
    // rust: let thrown = self.held().cloned().unwrap_or(stack);
    // rust: if !self.creative {
    // rust: *self.held_mut() = None;
}
    // rust: let start = Vec3::new(eye[0], eye[1] - 0.1, eye[2]);
    // rust: let mut projectile = horizon_client::projectiles::Projectile::new(
    // rust: horizon_client::projectiles::ProjectileKind::Snowball,
    // rust: start,
    // rust: Some(Who::Player),
    // rust: );
    // rust: let (v, on_ground) = self.player.as_ref().map_or((Vec3::ZERO, true), |p| {
    // rust: (self.known_player_movement(), p.ground.on_ground)
    // rust: });
    // rust: projectile.shoot_from_rotation(
    // rust: &mut self.world.random,
    // rust: self.pitch,
    // rust: self.yaw,
    // rust: 0.0,
    // rust: 2.5,
    // rust: 1.0,
    // rust: v,
    // rust: on_ground,
    // rust: );
    // rust: let id = self.take_entity_id();
    // rust: self.tridents.push(ThrownTrident {
    // rust: join: Default::default(),
    // rust: id,
    // rust: loyalty: thrown.enchantment_level("minecraft:loyalty"),
    // rust: stack: thrown,
    // rust: position: start,
    // rust: previous: start,
    // rust: velocity: projectile.velocity,
    // rust: yaw: projectile.yaw,
    // rust: pitch: projectile.pitch,
    // rust: in_ground: false,
    // rust: in_ground_time: 0,
    // rust: shake: 0,
    // rust: dealt_damage: false,
    // rust: no_physics: false,
    // rust: returning: 0,
    // rust: creative_only: self.creative,
    // rust: no_gravity: false,
    // rust: fire_ticks: 0,
    // rust: was_touching_water: false,
    // rust: random: horizon_core::random::LegacyRandom::new(i64::from(id)),
    // rust: age: 0,
    // rust: owner: 0,
    // rust: guest: self.lan_acting,
    // rust: deflected_by: None,
    // rust: });
    // rust: self.player_projectile_shot();
    // rust: self.audio.play_bound(
    // rust: "minecraft:item.trident.throw",
    // rust: 7,
    // rust: 1.0,
    // rust: 1.0,
    // rust: horizon_client::sound_engine::SoundEntity::new(id, [start.x, start.y, start.z], false),
    // rust: None,
    // rust: );
}
    /// The thrower's `PLAYER_HURT_ENTITY` for a trident hit: run as the
    /// guest that threw it, and not at all once they have left.
    // rust: fn thrower_hit(
    // rust: &mut self,
    // rust: guest: Option<u32>,
    // rust: victim: &horizon_client::advancements::EntityView,
    // rust: direct: horizon_client::advancements::EntityView,
    // rust: damage: f32,
    // rust: ) {
    // rust: let Some(conn) = guest.filter(|c| self.lan_acting != Some(*c)) else {
    // rust: self.player_hit(victim, "minecraft:trident", Some(direct), damage);
    // rust: return;
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: self.as_guest(&mut host, conn, |g| {
    // rust: g.player_hit(victim, "minecraft:trident", Some(direct), damage)
    // rust: });
    // rust: self.lan = Some(host);
}
    /// The players tridents fly back to or land at: this game's player and the
    /// guests in this level. A server has no player of its own, so its
    /// tridents belong to guests.
pub fn trident_catchers(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: if let Some(eye) = self.eye_position() {
    // rust: let feet = self.player.as_ref().map_or(Vec3::ZERO, |p| p.position);
    // rust: out.push(Catcher {
    // rust: guest: None,
    // rust: id: 0,
    // rust: feet,
    // rust: eye: Vec3::new(eye[0], eye[1], eye[2]),
    // rust: touches: true,
    // rust: });
}
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: for g in host.hub.guests.iter().filter(|g| host.hub.here(g)) {
    // rust: let [x, y, z] = g.position;
    // rust: out.push(Catcher {
    // rust: guest: Some(g.conn),
    // rust: id: g.entity_id,
    // rust: feet: Vec3::new(x, y, z),
    // rust: eye: Vec3::new(x, y + g.eye_height(), z),
    // rust: touches: !g.dead && !g.spectator(),
    // rust: });
}
}
    // rust: out
}
    /// `AbstractArrow.playerTouch` for a trident that has landed or is
    /// returning: the player takes the item (a creative thrower's trident is
    /// only removed) and the rest that does not fit drops at their feet.
    /// False when it could not be given.
pub fn trident_taken(self: *Self, t: *ThrownTrident, by: *Catcher) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !t.creative_only {
    // rust: let rest = match by.guest {
    // rust: None => self.give(t.stack.clone()),
    // rust: Some(conn) => {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return false;
}
    // rust: let rest = self.as_guest(&mut host, conn, |g| g.give(t.stack.clone()));
    // rust: self.lan = Some(host);
    // rust: let Some(rest) = rest else {
    // rust: return false;
}
    // rust: rest
}
}
    // rust: if let Some(rest) = rest {
    // rust: self.spawn_item(rest, [by.feet.x, by.feet.y, by.feet.z], [0.0; 3], 0);
}
}
        // Player.take, for a creative thrower's trident too: the clients near
        // play the pickup sound and fly the trident to its collector.
    // rust: if by.guest.is_some()
    // rust: && let Some(host) = self.lan.as_ref()
    // rust: {
    // rust: let at = [t.position.x, t.position.y, t.position.z];
    // rust: host.hub.take_item(t.id as i32, by.id, 1, at);
}
    // rust: if by.guest.is_none() {
    // rust: let pitch = ((self.world.random.next_float() - self.world.random.next_float()) * 0.7
    // rust: + 1.0)
    // rust: * 2.0;
    // rust: self.audio.play(
    // rust: "minecraft:entity.item.pickup",
    // rust: Some([by.feet.x, by.feet.y, by.feet.z]),
    // rust: 0.2,
    // rust: pitch,
    // rust: );
}
    // rust: true
}
    /// Apply the environment before impact callbacks can change the world.
pub fn trident_block_effects(self: *Self, t: *mut ThrownTrident, from: Vec3, to: Vec3) void {
}
    // rust: let extinguished = {
    // rust: let rain = self.arrow_rain();
            // Block-contact hooks are already delivered by the game's inside pass.
    // rust: let (ticks, extinguished) =
    // rust: self.arrow_scene(&rain)
    // rust: .apply_block_effects(from, to, t.fire_ticks, |_, _, _| {});
    // rust: t.fire_ticks = ticks;
    // rust: extinguished
}
    // rust: if extinguished {
    // rust: let pitch = 1.6 + (t.random.next_float() - t.random.next_float()) * 0.4;
    // rust: self.audio.play(
    // rust: "minecraft:entity.generic.extinguish_fire",
    // rust: Some([to.x, to.y, to.z]),
    // rust: 0.7,
    // rust: pitch,
    // rust: );
}
}
    // rust: pub(super) fn tick_tridents(&mut self) {
    // rust: if self.tridents.is_empty() {
    // rust: return;
}
    // rust: let catchers = self.trident_catchers();
    // rust: let mut i = 0;
    // rust: while i < self.tridents.len() {
    // rust: let mut t = self.tridents.remove(i);
    // rust: t.previous = t.position;
    // rust: t.age += 1;
            // AbstractArrow.tick: `if (shakeTime > 0) --shakeTime;`.
    // rust: t.shake = t.shake.saturating_sub(1);
    // rust: if t.in_ground_time > 4 {
    // rust: t.dealt_damage = true;
}
            // ThrownTrident.tick: Loyalty needs its owner, who is in this level.
    // rust: let owner_eye = catchers.iter().find(|c| c.guest == t.guest).map(|c| c.eye);
            // `isAcceptibleReturnOwner` fails for a dead or spectating owner: the
            // trident drops as an item when it can be picked up, then goes.
    // rust: if t.loyalty > 0
    // rust: && (t.dealt_damage || t.no_physics)
    // rust: && catchers.iter().any(|c| c.guest == t.guest && !c.touches)
    // rust: {
    // rust: if !t.creative_only {
    // rust: self.spawn_at_location(t.position, f64::from(0.1f32), t.stack.clone());
}
    // rust: continue;
}
    // rust: if t.loyalty > 0
    // rust: && (t.dealt_damage || t.no_physics)
    // rust: && let Some(owner_eye) = owner_eye
    // rust: {
    // rust: t.no_physics = true;
    // rust: t.in_ground = false;
    // rust: t.loyalty_pull(owner_eye);
    // rust: if t.returning == 0 {
    // rust: self.audio.play(
    // rust: "minecraft:item.trident.return",
    // rust: Some([t.position.x, t.position.y, t.position.z]),
    // rust: 10.0,
    // rust: 1.0,
    // rust: );
}
    // rust: t.returning += 1;
}
            // AbstractArrow clears cached water/rain before its stuck branch.
    // rust: let in_rain = {
    // rust: let rain = self.arrow_rain();
    // rust: self.arrow_scene(&rain).in_rain(t.position)
}
    // rust: if t.was_touching_water || in_rain {
    // rust: t.fire_ticks = t.fire_ticks.min(0);
}
    // rust: let stuck_tick = t.in_ground && !t.no_physics;
    // rust: if t.in_ground {
    // rust: t.in_ground_time += 1;
    // rust: if !t.no_physics {
    // rust: let at = t.position;
    // rust: self.trident_block_effects(&mut t, at, at);
}
    // rust: } else if t.no_physics {
    // rust: t.position = Vec3::new(
    // rust: t.position.x + t.velocity.x,
    // rust: t.position.y + t.velocity.y,
    // rust: t.position.z + t.velocity.z,
    // rust: );
    // rust: } else {
                // Mobs on the path, then blocks.
    // rust: let mut hit_mob = None;
                // ProjectileUtil.computeMargin: the boxes it meets grow from
                // nothing to 0.3 over its first ticks.
    // rust: let margin = f64::from(((t.age as i32 - 2) as f32 / 20.0).clamp(0.0, 0.3));
    // rust: let grow = Vec3::new(margin, margin, margin);
    // rust: if !t.dealt_damage {
    // rust: for m in self.mobs.iter().filter(|m| m.alive()) {
    // rust: if let Some(d) =
    // rust: segment_box(t.position, t.velocity, m.bounds().inflate(grow))
    // rust: && hit_mob.is_none_or(|(_, best)| d < best)
    // rust: {
    // rust: hit_mob = Some((m.id, d));
}
}
}
                // Boats and minecarts are pickable too (`VehicleEntity.isPickable`).
    // rust: if !t.dealt_damage {
    // rust: for (who, b) in self.vehicle_targets() {
    // rust: if let Who::Mob(id) = who
    // rust: && let Some(d) = segment_box(t.position, t.velocity, b.inflate(grow))
    // rust: && hit_mob.is_none_or(|(_, best)| d < best)
    // rust: {
    // rust: hit_mob = Some((id, d));
}
}
}
                // ProjectileImpactEvent for the mob hit: a canceled one does
                // nothing, and the trident stays where it would have hit.
    // rust: let canceled_mob = hit_mob.is_some_and(|(id, d)| {
                    // `at` is where the movement enters the mob's box.
    // rust: let at = Vec3::new(
    // rust: t.position.x + t.velocity.x * d,
    // rust: t.position.y + t.velocity.y * d,
    // rust: t.position.z + t.velocity.z * d,
    // rust: );
    // rust: let from = t.position;
    // rust: self.trident_block_effects(&mut t, from, at);
    // rust: self.native_trident_impact(t.id, t.guest, Some(id), [0; 3], [0; 3], at)
    // rust: });
    // rust: if canceled_mob {
                    // No damage, sound or deflection: it flies on.
    // rust: } else if let Some((id, d)) = hit_mob {
                    // The trident stops where it met the box.
    // rust: let at = Vec3::new(
    // rust: t.position.x + t.velocity.x * d,
    // rust: t.position.y + t.velocity.y * d,
    // rust: t.position.z + t.velocity.z * d,
    // rust: );
    // rust: t.position = at;
                    // `Breeze.deflection`: a trident is not a wind charge, so
                    // `PROJECTILE_DEFLECTION` turns it around. `onHit` does not
                    // run, so the breeze takes no damage and Channeling never fires.
    // rust: let breeze = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id && m.alive() && m.species() == Species::Breeze);
    // rust: if let Some(breeze) = breeze {
    // rust: if t.deflected_by != Some(id) {
    // rust: let sound_at =
    // rust: [breeze.position.x, breeze.position.y, breeze.position.z];
    // rust: self.audio.play(
    // rust: "minecraft:entity.breeze.deflect",
    // rust: Some(sound_at),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: let jitter = t.random.next_float();
    // rust: let (velocity, yaw) = breeze_deflect(t.velocity, t.yaw, jitter);
    // rust: t.velocity = velocity;
    // rust: t.yaw = yaw;
    // rust: t.deflected_by = Some(id);
}
    // rust: } else {
                        // ThrownTrident.getDamage: `EnchantmentHelper.modifyDamage` on 8
                        // (impaling hits `#sensitive_to_impaling`, the aquatic tag).
    // rust: let victim = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| m.kind.id.clone())
    // rust: .or_else(|| {
    // rust: self.boats
    // rust: .iter()
    // rust: .find(|b| b.id == id)
    // rust: .map(|b| b.entity_type())
    // rust: })
    // rust: .or_else(|| {
    // rust: self.carts
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| c.kind.id().to_owned())
    // rust: });
    // rust: let ctx = EffectContext {
    // rust: this: victim.as_deref(),
    // rust: attacker: Some("minecraft:player"),
    // rust: direct_attacker: Some("minecraft:trident"),
    // rust: is_direct: true,
    // rust: damage_type: Some("minecraft:trident"),
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: let damage = world_stations!(self).enchantments.modify_value(
    // rust: Some(&t.stack),
    // rust: "minecraft:damage",
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: 8.0,
    // rust: );
    // rust: t.dealt_damage = true;
    // rust: let mut hurt_at = None;
    // rust: let aim = self.attacker_aim(Some(Who::Player));
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: let from = Some([t.position.x, t.position.y, t.position.z]);
    // rust: let hurt = m.damage_projectile(
    // rust: damage,
    // rust: Damage {
    // rust: kind: DamageKind::Arrow,
    // rust: attacker: Some(Who::Player),
    // rust: from,
    // rust: attacker_species: None,
    // rust: },
    // rust: aim,
    // rust: [t.velocity.x, t.velocity.z],
    // rust: );
    // rust: if hurt {
    // rust: hurt_at = Some([m.position.x, m.position.y, m.position.z]);
}
}
                        // ThrownTrident.onHitEntity on a boat or minecart:
                        // VehicleEntity.hurtServer takes the damage.
    // rust: let creative = t.guest.is_none() && self.creative;
    // rust: if let Some(i) = self.boats.iter().position(|b| b.id == id) {
    // rust: self.hurt_boat(i, damage, creative);
    // rust: } else if let Some(i) = self.carts.iter().position(|c| c.id == id) {
    // rust: self.hurt_cart(i, damage, creative, false);
}
                        // `minecraft:post_attack` of Channeling, on the victim.
    // rust: if let Some(at) = hurt_at
    // rust: && t.stack.enchantment_level("minecraft:channeling") > 0
    // rust: {
    // rust: self.channel_lightning(at, t.guest);
}
    // rust: if hurt_at.is_some()
    // rust: && let Some(m) = self.mobs.iter().find(|m| m.id == id)
    // rust: {
                            // LivingEntity.hurtServer: PLAYER_HURT_ENTITY.
    // rust: let victim = self.mob_entity(m);
    // rust: let direct = horizon_client::advancements::EntityView {
    // rust: kind: "minecraft:trident".into(),
    // rust: position: [t.position.x, t.position.y, t.position.z],
    // rust: ..Default::default()
}
    // rust: self.thrower_hit(t.guest, &victim, direct, damage);
}
                        // Projectile.onHit: the landing is heard, at the hit.
    // rust: self.projectile_event(
    // rust: "minecraft:projectile_land",
    // rust: Some(Who::Player),
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: );
    // rust: self.audio.play(
    // rust: "minecraft:item.trident.hit",
    // rust: Some([t.position.x, t.position.y, t.position.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
                        // ProjectileDeflection.REVERSE (half, reversed) scaled by
                        // (0.02, 0.2, 0.02).
    // rust: t.velocity = Vec3::new(
    // rust: t.velocity.x * (-0.02 * 0.5),
    // rust: t.velocity.y * (-0.2 * 0.5),
    // rust: t.velocity.z * (-0.02 * 0.5),
    // rust: );
}
    // rust: } else {
                    // AbstractArrow.tick: a zero-width ray clip of the movement
                    // (`ClipContext.Block.COLLIDER`, no fluids), then
                    // `AbstractArrow.onHitBlock` on a hit.
    // rust: let from = t.position;
    // rust: let flight = t.velocity;
    // rust: let clip =
    // rust: clip_block_hit(&self.world, self.res.facts(), self.collision, from, flight);
                    // Block effects reach the clip location before onHitBlock backs off.
    // rust: let fire_to = clip.map_or(from.add_vector(flight), |(at, _, _)| at);
    // rust: self.trident_block_effects(&mut t, from, fire_to);
                    // ProjectileImpactEvent for the block hit: a canceled one
                    // doesn't stick the trident, which stays where it would
                    // have hit, still flying.
                    // The hook's `at` is the clip's hit location, before the back-off.
    // rust: let canceled_block = clip.is_some_and(|(at, block, face)| {
    // rust: self.native_trident_impact(
    // rust: t.id,
    // rust: t.guest,
    // rust: None,
    // rust: [block.x, block.y, block.z],
    // rust: face,
    // rust: at,
    // rust: )
    // rust: });
    // rust: let clip = clip.map(|(at, block, face)| (back_off(at, flight), block, face));
    // rust: if canceled_block && let Some((stop, _, _)) = clip {
    // rust: t.position = stop;
    // rust: } else if let Some((stop, block, _)) = clip {
                        // Projectile.onHit on a block: PROJECTILE_LAND at the
                        // block's centre.
    // rust: self.projectile_event(
    // rust: "minecraft:projectile_land",
    // rust: Some(Who::Player),
    // rust: [
    // rust: f64::from(block.x) + 0.5,
    // rust: f64::from(block.y) + 0.5,
    // rust: f64::from(block.z) + 0.5,
    // rust: ],
    // rust: );
    // rust: if t.stack.enchantment_level("minecraft:channeling") > 0 {
    // rust: self.channel_rod_hit(from, flight, t.guest);
}
                        // 0.05 back along signum(movement), stopped, stuck, shaking.
    // rust: t.position = stop;
    // rust: t.velocity = Vec3::ZERO;
    // rust: t.in_ground = true;
    // rust: t.shake = 7;
    // rust: self.audio.play(
    // rust: "minecraft:item.trident.hit_ground",
    // rust: Some([stop.x, stop.y, stop.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: } else {
                        // A MISS moves the whole segment.
    // rust: t.position =
    // rust: Vec3::new(from.x + flight.x, from.y + flight.y, from.z + flight.z);
}
}
    // rust: if !t.in_ground {
                    // A trident's water inertia (0.99) equals the air drag, a float in
                    // vanilla (`AbstractArrow.tick`); gravity 0.05.
    // rust: let drag = f64::from(0.99f32);
    // rust: let gravity = if t.no_gravity { 0.0 } else { 0.05 };
    // rust: t.velocity = Vec3::new(
    // rust: t.velocity.x * drag,
    // rust: t.velocity.y * drag - gravity,
    // rust: t.velocity.z * drag,
    // rust: );
    // rust: let h = (t.velocity.x * t.velocity.x + t.velocity.z * t.velocity.z).sqrt();
    // rust: t.yaw = t.velocity.x.atan2(t.velocity.z).to_degrees() as f32;
    // rust: t.pitch = t.velocity.y.atan2(h).to_degrees() as f32;
}
}
    // rust: if !t.no_physics {
    // rust: let half = 0.25;
    // rust: let bounds = Aabb::new(
    // rust: t.position.add_vector(Vec3::new(-half, 0.0, -half)),
    // rust: t.position.add_vector(Vec3::new(half, 0.5, half)),
    // rust: );
    // rust: self.entity_powder_snow_particles(
    // rust: t.previous, t.position, bounds, t.velocity, false,
    // rust: );
}
            // The stuck branch returns before Entity.baseTick. A flight that
            // just hit a block still reaches it, as does a noPhysics return.
    // rust: if !stuck_tick {
    // rust: let rain = self.arrow_rain();
    // rust: t.was_touching_water = self.arrow_scene(&rain).in_water(t.position);
    // rust: if t.fire_ticks > 0 {
    // rust: t.fire_ticks -= 1;
}
}
            // playerTouch: stuck or returning tridents go back to a player.
            // ThrownTrident.playerTouch: only its owner takes it, or anyone
            // once the owner is not in this level (`getOwner() == null`), and
            // not while `AbstractArrow.shakeTime` still runs.
    // rust: if (t.in_ground || t.no_physics) && t.shake == 0 {
    // rust: let near = |c: &&Catcher| {
    // rust: c.touches
    // rust: && (owner_eye.is_none() || c.guest == t.guest)
    // rust: && (t.position.x - c.feet.x).abs() < 1.0
    // rust: && (t.position.z - c.feet.z).abs() < 1.0
    // rust: && t.position.y > c.feet.y - 1.0
    // rust: && t.position.y < c.feet.y + 2.5
}
    // rust: if let Some(by) = catchers.iter().find(near)
    // rust: && self.trident_taken(&t, by)
    // rust: {
    // rust: continue;
}
}
    // rust: self.tridents.insert(i, t);
    // rust: i += 1;
}
}
    /// ThrownTridentRenderer.
    // rust: pub(super) fn trident_geometry(&self, camera: glam::DVec3, alpha: f64, out: &mut Vec<Vertex>) {
    // rust: let Some(model) = &self.trident_model else {
    // rust: return;
}
    // rust: let Some(uv) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("entity/trident/trident")
    // rust: .map(|r| [r.u0, r.v0, r.u1, r.v1])
    // rust: else {
    // rust: return;
}
        // The texture's OptiFine emissive overlay, drawn again full bright.
    // rust: let glow = self
    // rust: .res
    // rust: .mob_data()
    // rust: .emissive
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
    // rust: .overlay("entity/trident/trident")
    // rust: .and_then(|e| self.gui.atlas.sprites.get(e))
    // rust: .map(|r| [r.u0, r.v0, r.u1, r.v1]);
        // AbstractArrow.shouldRenderAtSqrDistance: ten times the default.
    // rust: let range = 10.0
    // rust: * super::entity_culling::default_range(
    // rust: glam::DVec3::splat(2.0 * HALF),
    // rust: self.view_scale(),
    // rust: );
    // rust: let live = self
    // rust: .tridents
    // rust: .iter()
    // rust: .filter(|t| {
                // EntityRenderer.shouldRender; ThrownTridentRenderer grows the box by 1.5.
    // rust: self.standing_entity_in_view(
    // rust: camera,
    // rust: super::entity_culling::at(t.previous),
    // rust: super::entity_culling::at(t.position),
    // rust: alpha,
    // rust: 2.0 * HALF,
    // rust: 2.0 * HALF,
    // rust: range,
    // rust: 1.5,
    // rust: )
    // rust: })
    // rust: .map(|t| {
    // rust: let at = [
    // rust: t.previous.x + (t.position.x - t.previous.x) * alpha,
    // rust: t.previous.y + (t.position.y - t.previous.y) * alpha,
    // rust: t.previous.z + (t.position.z - t.previous.z) * alpha,
    // rust: ];
    // rust: (t, at)
    // rust: });
        // ItemPickupParticle: a picked-up trident flying to its collector,
        // drawn with the render state extracted at partial tick 1.
    // rust: let taken = self.pickups.live.iter().filter_map(|p| match &p.taken {
    // rust: super::pickups::Taken::Trident(t) => Some((&**t, super::pickups::position(p, alpha))),
    // rust: _ => None,
    // rust: });
    // rust: for (t, at) in live.chain(taken) {
    // rust: let p = glam::DVec3::from_array(at) - camera;
    // rust: let base = glam::Mat4::from_translation(p.as_vec3())
    // rust: * glam::Mat4::from_rotation_y((t.yaw - 90.0).to_radians())
    // rust: * glam::Mat4::from_rotation_z((t.pitch + 90.0).to_radians());
    // rust: let l = self.world.light(
    // rust: t.position.x.floor() as i32,
    // rust: t.position.y.floor() as i32,
    // rust: t.position.z.floor() as i32,
    // rust: );
    // rust: if t.fire_ticks > 0 {
                // The flames face the camera, turned round in the front view.
    // rust: let fire_yaw =
    // rust: if self.camera_type == super::perspective::CameraType::ThirdPersonFront {
    // rust: self.yaw + 180.0
    // rust: } else {
    // rust: self.yaw
}
    // rust: horizon_client::fire_render::flames(
    // rust: at,
    // rust: 0.5,
    // rust: 0.5,
    // rust: camera,
    // rust: fire_yaw,
    // rust: &self.gui.atlas.sprites,
    // rust: l,
    // rust: out,
    // rust: );
}
    // rust: let packed = (u32::from(l >> 4) * 16) | ((u32::from(l & 15) * 16) << 8);
    // rust: let poses = Poses::new(model);
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: uv,
    // rust: 0xFFFF_FFFF,
    // rust: packed,
    // rust: 0,
    // rust: out,
    // rust: );
    // rust: if let Some(glow) = glow {
    // rust: let full = horizon_client::mobs::render::FULL_BRIGHT;
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: glow,
    // rust: 0xFFFF_FFFF,
    // rust: full,
    // rust: 0,
    // rust: out,
    // rust: );
}
}
}
}
    // rust: horizon_client::impl_joined!(ThrownTrident);

    // rust: mod tests {
//     use super::breeze_deflect;
//     use horizon_core::geometry::Vec3;

    /// `ProjectileDeflection.REVERSE` at power 1: half speed, the other way,
    /// and a turn of 170 degrees plus a fifth of the random draw.
pub fn a_breeze_turns_a_trident_around_at_half_speed() void {
}
    // rust: let (velocity, yaw) = breeze_deflect(Vec3::new(4.0, -2.0, 1.0), 10.0, 0.25);
    // rust: assert_eq!(velocity, Vec3::new(-2.0, 1.0, -0.5));
    // rust: assert_eq!(yaw, 185.0);
}

    /// A stack can reach its final durability point after use began. The release
    /// guard is independent of admission, and short charges still do nothing.
pub fn trident_release_rechecks_stack_durability_after_charge() void {
}
//         use crate::game::{Audio, Options, PlayerMotion, Progress, Settings, load_resources};
//         use horizon_world::nbt::Tag;
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = super::Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.player =
    // rust: Some(PlayerMotion::new(game.motion, super::Vec3::new(4.5, 200.0, 4.5)).unwrap());
    // rust: let mut stack = super::ItemStack::new("minecraft:trident", 1);
    // rust: stack.damage = 8;
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other("minecraft:max_damage", Some(Tag::Int(10)));
    // rust: *game.held_mut() = Some(stack.clone());
    // rust: assert!(game.use_trident(&stack));
    // rust: assert!(game.using.is_some());
    // rust: game.held_mut().as_mut().unwrap().damage = 9;
    // rust: game.release_trident(10);
    // rust: assert!(game.tridents.is_empty());
    // rust: assert_eq!(game.held().unwrap().damage, 9);
    // rust: game.using = None;

    // rust: stack.damage = 249;
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other("minecraft:max_damage", Some(Tag::Int(500)));
    // rust: *game.held_mut() = Some(stack.clone());
    // rust: assert!(game.use_trident(&stack));
    // rust: assert!(game.using.is_some());
    // rust: game.release_trident(9);
    // rust: assert!(game.tridents.is_empty());
    // rust: assert_eq!(game.held().unwrap().damage, 249);
    // rust: game.release_trident(10);
    // rust: assert_eq!(game.tridents.len(), 1);
    // rust: assert_eq!(game.tridents[0].stack.damage, 250);
    // rust: assert!(game.held().is_none());
}
}
