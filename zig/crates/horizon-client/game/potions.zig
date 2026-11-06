//! Transpiled from Horizon Rust crate
//! Module: horizon-client_potions
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Potions and status effects in the game: drinking (`PotionItem` via
//! `Consumable`), throwing splash/lingering potions (`ThrownSplashPotion`),
//! filling glass bottles (`BottleItem`), the per-tick effect application,
//! effect attribute modifiers and the HUD effect icons (`Hud.extractEffects`).
// use super::{
    // rust: Game, Screen,
    // rust: dragon::{Breath, FightPlayer, FightWho},
    // rust: item_draw::owner_at,
    // rust: remote_projectiles::cloud_client_tick,
    // rust: splash_water::thrown_block_hit,
}
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::{
    // rust: block_entity_render::vertex_light,
    // rust: brewing,
    // rust: effects::{EffectAction, EffectInstance, OmenTick, PlayerEffects},
    // rust: hud::HudBatch,
    // rust: hud_layout, hud_overlays, inventory_effects,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::{Damage, DamageKind, Who},
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: projectiles::{Projectile, ProjectileKind},
    // rust: text::Text,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Direction, Vec3},
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::nbt::Tag;

/// Per-cloud settings; natural lingering clouds keep their creation defaults.
    // rust: pub(super) struct CloudSettings {
    // rust: pub(super) wait_time: i32,
    // rust: pub(super) reapplication_delay: i32,
    // rust: pub(super) radius_on_use: f32,
    // rust: pub(super) duration_on_use: i32,
    // rust: pub(super) duration_scale: f32,
}
    // rust: impl CloudSettings {
pub fn lingering() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: wait_time: LINGERING_WAIT,
    // rust: reapplication_delay: REAPPLICATION_DELAY,
    // rust: radius_on_use: -0.5,
    // rust: duration_on_use: 0,
    // rust: duration_scale: 0.25,
}
}
}

/// A thrown splash or lingering potion in flight.
    // rust: pub(super) struct ThrownPotion {
    /// Its entity id once a server's clients track it (0 until then).
    // rust: id: u32,
    // rust: stack: ItemStack,
    /// The position before the last tick, for drawing between ticks.
    // rust: previous: Vec3,
    // rust: position: Vec3,
    // rust: velocity: Vec3,
    // rust: age: u32,
    /// `Projectile.getOwner`'s display name: the player who threw it (none
    /// for a dispenser's).
    // rust: owner: Option<Text>,
    /// `Projectile.getOwner` as a target: the thrower (`Who::Player`, a
    /// guest's with `guest` set), none for a dispenser's or a server's.
    // rust: thrower: Option<Who>,
    /// On a server, the guest (by connection) who threw it.
    // rust: guest: Option<u32>,
    /// `Projectile.leftOwner`: until then it can't hit its thrower.
    // rust: left_owner: bool,
}
/// The player (not one of `skip`, the thrower and who rides with them before
/// it has left them) whose box, grown by `margin` (`ProjectileUtil.computeMargin`),
/// holds `p` (`Projectile.canHitEntity`).
    // rust: fn thrown_player_at<'a>(
    // rust: players: &'a [(Who, Aabb)],
    // rust: skip: &[Who],
    // rust: p: Vec3,
    // rust: margin: f64,
    // rust: ) -> Option<&'a (Who, Aabb)> {
    // rust: players.iter().find(|(who, b)| {
    // rust: !skip.contains(who) && b.inflate(Vec3::new(margin, margin, margin)).contains(p)
    // rust: })
}
/// `ProjectileUtil.computeMargin`: how far the pick box is grown at `age`.
pub fn thrown_margin(age: u32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((f64::from(age) - 2.0) / 20.0).clamp(0.0, 0.3)
}
/// `Projectile.isOutsideOwnerCollisionRange` (`checkLeftOwner`): none of the
/// boxes of the thrower's vehicle tree (`owner.getRootVehicle().getSelfAndPassengers()`,
/// here `ridden`) is within a block of the potion's (0.25 wide) grown by its
/// motion; true too when there is no thrower (`ridden` empty).
pub fn thrown_left_owner(ridden: *[Aabb], position: Vec3, velocity: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = 0.125;
    // rust: let reach = Aabb::new(
    // rust: Vec3::new(position.x - h, position.y, position.z - h),
    // rust: Vec3::new(position.x + h, position.y + 2.0 * h, position.z + h),
    // rust: )
    // rust: .expand_towards(velocity)
    // rust: .inflate(Vec3::new(1.0, 1.0, 1.0));
    // rust: !ridden.iter().any(|b| b.intersects(reach))
}
/// `AreaEffectCloud` wait time set by `ThrownLingeringPotion.onHitAsPotion`.
    // rust: pub(super) const LINGERING_WAIT: i32 = 10;
/// `AreaEffectCloud.DEFAULT_REAPPLICATION_DELAY`.
pub const REAPPLICATION_DELAY: i32 = 20;
/// An entity a cloud has affected (`AreaEffectCloud.victims`).
    // rust: pub(super) enum Victim {
    // rust: Mob(u32),
    // rust: Player(FightWho),
}
/// A potion-bearing `AreaEffectCloud`: its effects, settings and recent victims.
    // rust: pub(super) struct PotionCloud {
    // rust: pub(super) settings: CloudSettings,
    // rust: effects: Vec<(&'static str, i32, i32)>,
    /// The effects above that were added hidden (`MobEffectInstance.isVisible` false: no
    /// particles); the instances the cloud applies are copies and keep that.
    // rust: hidden: Vec<&'static str>,
    /// The effects above that were ambient (`MobEffectInstance.isAmbient`).
    // rust: ambient: Vec<&'static str>,
    /// `AreaEffectCloud.radiusPerTick`: natural clouds use `-radius / duration`.
    // rust: pub(super) radius_per_tick: f32,
    /// The potion's colour (`PotionContents.getColor`).
    // rust: color: u32,
    /// Each victim and the tick it can be affected again.
    // rust: victims: Vec<(Victim, i32)>,
    /// Who its instant damage names (`indirectMagic(cloud, owner)`): the
    /// thrower, else the cloud.
    // rust: source: Text,
    /// `AreaEffectCloud.getOwner`: the thrower (`ThrownLingeringPotion.onHitAsPotion`), whose
    /// kill a mob's death to its instant damage is.
    // rust: owner: Option<Who>,
    /// On a server, the guest (by connection) who threw it.
    // rust: guest: Option<u32>,
}
    // rust: impl PotionCloud {
    /// `AreaEffectCloud.updateParticle`: an entity effect in the potion's colour.
    // rust: pub(super) fn particle(&self) -> ParticleOptions {
    // rust: let c = |shift: u32| (self.color >> shift & 255) as f32 / 255.0;
    // rust: ParticleOptions::colored(ParticleType::EntityEffect, [c(16), c(8), c(0), 1.0])
}
}
/// `Projectile.getOwner` of a thrown potion: what its `indirectMagic` damage
/// is named after and who it counts against. Nothing for a dispenser's or a
/// summoned potion nobody owns, the potion itself then naming the death
/// message.
    // rust: pub(super) struct PotionOwner {
    /// The thrower's name, when it has one.
    // rust: name: Option<Text>,
    /// The mob that threw it (a witch): the hurt is its kill credit, as
    /// `indirectMagic(potion, owner)` gives it. A player's throw is the
    /// potion's own and only `name`s the message.
    // rust: attacker: Option<u32>,
    /// A player threw it: the water damage `indirectMagic` deals is theirs.
    // rust: player: bool,
    /// On a server, the guest (by connection) who threw it: whose kill the mobs it hurts are
    /// (`LivingEntity.lastHurtByPlayer`).
    // rust: guest: Option<u32>,
}
    // rust: impl PotionOwner {
    /// The owner as a damage source's causing entity.
pub fn who(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.attacker {
    // rust: Some(id) => Some(Who::Mob(id)),
    // rust: None => self.player.then_some(Who::Player),
}
}
}
/// A mob's effect ids carry the `minecraft:` namespace; a mod's has its own.
    // rust: pub(super) fn mob_effect_id(id: &str) -> Option<&'static str> {
    // rust: brewing::effect(id).map(|e| brewing::namespaced(e.id))
}
/// `LivingEntity.canBeAffected` with the mob overrides (`WitherBoss` and
/// `WitherSkeleton` shrug off wither, `Spider` and `AbstractNautilus` poison,
/// `Parched` weakness): the immune-to-infested and immune-to-oozing tags
/// decide first, then the tag of mobs that ignore poison and regeneration.
/// `WitherBoss.addEffect` refusing everything is `Mob::add_effect`'s: a cloud
/// still takes the wither as a victim (`AreaEffectCloud` asks `canBeAffected`),
/// so its instant effects land and it shrinks.
    // rust: pub(super) fn mob_can_be_affected(
    // rust: tags: &std::collections::HashMap<String, std::collections::HashSet<String>>,
    // rust: kind: &str,
    // rust: effect: &str,
    // rust: ) -> bool {
    // rust: let effect = effect.trim_start_matches("minecraft:");
    // rust: let kind = kind.trim_start_matches("minecraft:");
    // rust: let overridden = match kind {
    // rust: "wither" | "wither_skeleton" => effect == "wither",
    // rust: "spider" | "cave_spider" | "nautilus" | "zombie_nautilus" => effect == "poison",
    // rust: "parched" => effect == "weakness",
    // rust: _ => false,
}
    // rust: if overridden {
    // rust: return false;
}
    // rust: let in_tag = |tag: &str| {
    // rust: tags.get(tag)
    // rust: .is_some_and(|t| t.contains(&format!("minecraft:{kind}")))
}
    // rust: if in_tag("minecraft:immune_to_infested") {
    // rust: effect != "infested"
    // rust: } else if in_tag("minecraft:immune_to_oozing") {
    // rust: effect != "oozing"
    // rust: } else {
    // rust: !in_tag("minecraft:ignores_poison_and_regen")
    // rust: || (effect != "regeneration" && effect != "poison")
}
}
    // rust: impl Game<'_> {
    /// The dragon's breath (`AreaEffectCloud` with instant damage at
    /// `amplifier`) on a mob: what a cloud puts on it, `indirectMagic(cloud,
    /// dragon)` with no owner to credit (the dragon is not a mob here).
    // rust: pub(super) fn breath_affect_mob(&mut self, mob: u32, amplifier: i32, at: [f64; 3]) {
    // rust: let source = Text::translate("entity.minecraft.area_effect_cloud", &[]);
    // rust: let effect = [("instant_damage", 1, amplifier)];
        // DragonFireball.onHit and the flame phase: `setPotionDurationScale(0.25)`.
    // rust: self.cloud_affect(
    // rust: Victim::Mob(mob),
    // rust: &effect,
    // rust: (&[], &[], 0.25),
    // rust: at,
    // rust: &source,
    // rust: (None, None),
    // rust: );
}
}
/// `ThrownSplashPotion.onHitAsPotion`: the squared distance from the potion's
/// box at the hit point to an entity's box grown by the hit margin
/// (`ProjectileUtil.computeMargin`), for entities that meet the potion's box
/// grown by (4, 2, 4); none when it is 16 or more.
pub fn splash_distance_sqr(at: Vec3, age: u32, bounds: Aabb) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let potion = Aabb::new(
    // rust: Vec3::new(at.x - 0.125, at.y, at.z - 0.125),
    // rust: Vec3::new(at.x + 0.125, at.y + 0.25, at.z + 0.125),
    // rust: );
    // rust: if !potion.inflate(Vec3::new(4.0, 2.0, 4.0)).intersects(bounds) {
    // rust: return None;
}
    // rust: let margin = ((f64::from(age) - 2.0) / 20.0).clamp(0.0, 0.3);
    // rust: let d2 = potion.distance_squared_to_box(bounds.inflate(Vec3::new(margin, margin, margin)));
    // rust: (d2 < 16.0).then_some(d2)
}
    // rust: impl Game<'_> {
    /// `LivingEntity.triggerOnDeathMobEffects` (`onMobRemoved` with the reason
    /// KILLED) for what Oozing, Weaving and Wind Charged do when their bearer
    /// dies. `bearer` is the dying mob's id, `player` whether it is a player,
    /// `random` the dying mob's own (`mob.getRandom()`; the world's for the
    /// player).
    // rust: pub(super) fn effects_on_death(
    // rust: &mut self,
    // rust: effects: &[&str],
    // rust: bounds: Aabb,
    // rust: player: bool,
    // rust: bearer: Option<u32>,
    // rust: mut random: Option<&mut LegacyRandom>,
    // rust: ) {
    // rust: let feet = bounds.bottom_center();
    // rust: if effects.contains(&"oozing") {
            // OozingMobEffect.numberOfSlimesToSpawn: two, fewer when the
            // slimes close by already fill the cramming limit.
    // rust: let limit = self.ui.rules.int("max_entity_cramming");
    // rust: let mut count = 2;
    // rust: if limit >= 1 {
    // rust: let near = bounds.inflate(Vec3::new(2.0, 2.0, 2.0));
    // rust: let nearby = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: m.species() == horizon_client::mobs::Species::Slime
    // rust: && Some(m.id) != bearer
    // rust: && m.bounds().intersects(near)
    // rust: })
    // rust: .count()
    // rust: .min(limit as usize) as i32;
    // rust: count = (limit - nearby).clamp(0, count);
}
    // rust: for _ in 0..count {
                // spawnSlimeOffspring: a size 2 slime half a block up.
    // rust: if let Some(id) = self.spawn_mob_for(
    // rust: "minecraft:slime",
    // rust: [feet.x, feet.y + 0.5, feet.z],
    // rust: false,
    // rust: true,
    // rust: ) && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: horizon_client::mobs::cube::set_size(m, 2);
}
}
}
    // rust: if effects.contains(&"weaving") && (player || self.ui.rules.bool("mob_griefing")) {
    // rust: self.spawn_cobwebs_around(
    // rust: [
    // rust: feet.x.floor() as i32,
    // rust: feet.y.floor() as i32,
    // rust: feet.z.floor() as i32,
    // rust: ],
    // rust: random.as_deref_mut(),
    // rust: );
}
    // rust: if effects.contains(&"wind_charged") {
            // A burst centred at half the height, radius 3 to 5.
    // rust: let center = [feet.x, feet.y + bounds.size().y / 2.0, feet.z];
    // rust: let r = random.unwrap_or(&mut self.world.random);
    // rust: let radius = 3.0 + r.next_float() * 2.0;
    // rust: let _ = self.wind_burst(center, radius, 1.0, false, false);
}
}
    /// `WeavingMobEffect.spawnCobwebsRandomlyAround`: two or three cobwebs in
    /// free spaces with a solid floor, picked among 15 random blocks within one
    /// block of `pos`.
pub fn spawn_cobwebs_around(self: *Self, pos: [i32; 3], mut random: ?*mut LegacyRandom) void {
}
    // rust: let r = random.as_deref_mut().unwrap_or(&mut self.world.random);
    // rust: let wanted = 2 + r.next_int_bound(2).unwrap_or(0) as usize;
    // rust: let mut chosen: Vec<[i32; 3]> = Vec::new();
    // rust: for _ in 0..15 {
    // rust: let r = random.as_deref_mut().unwrap_or(&mut self.world.random);
    // rust: let at = [
    // rust: pos[0] - 1 + r.next_int_bound(3).unwrap_or(0),
    // rust: pos[1] - 1 + r.next_int_bound(3).unwrap_or(0),
    // rust: pos[2] - 1 + r.next_int_bound(3).unwrap_or(0),
    // rust: ];
    // rust: let facts = self.res.facts();
    // rust: let here = facts.get(self.world.block(at[0], at[1], at[2]));
    // rust: let below = facts.get(self.world.block(at[0], at[1] - 1, at[2]));
    // rust: if !chosen.contains(&at)
    // rust: && here.replaceable
    // rust: && below.sturdy_full & (1 << Direction::Up as u8) != 0
    // rust: {
    // rust: chosen.push(at);
    // rust: if chosen.len() >= wanted {
    // rust: break;
}
}
}
    // rust: for at in chosen {
    // rust: if self.set_state_named(at, "minecraft:cobweb", &[]).is_ok() {
    // rust: self.level_event_at(3018, at, 0);
}
}
}
    /// `InfestedMobEffect.onMobHurt` for the player: from half its height up,
    /// along where it looks.
    // rust: pub(super) fn player_infested(&mut self) {
    // rust: if let Some(p) = self.player.as_ref() {
    // rust: let at = [
    // rust: p.position.x,
    // rust: p.position.y + f64::from(p.dimensions.height) / 2.0,
    // rust: p.position.z,
    // rust: ];
    // rust: let look = super::view_vector(self.yaw, self.pitch);
    // rust: self.infested_hurt(at, look, None);
}
}
    /// A living mob's own random (`Entity.random`), else the world's.
pub fn bearer_random(self: *Self, bearer: ?u32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match bearer.and_then(|id| self.mobs.iter().position(|m| m.id == id)) {
    // rust: Some(i) => &mut self.mobs[i].random,
    // rust: None => &mut self.world.random,
}
}
    /// `InfestedMobEffect.onMobHurt`: a 10% chance of one or two silverfish at
    /// `at` (half the bearer's height up), thrown along its look direction.
    /// The draws are the bearer's (`mob.getRandom()`): `bearer` is the mob,
    /// none for the player (the world's random).
    // rust: pub(super) fn infested_hurt(&mut self, at: [f64; 3], look: [f64; 3], bearer: Option<u32>) {
    // rust: if self.bearer_random(bearer).next_float() > 0.1 {
    // rust: return;
}
    // rust: let count = 1 + self.bearer_random(bearer).next_int_bound(2).unwrap_or(0);
    // rust: for _ in 0..count {
            // Mth.randomBetween(-PI / 2, PI / 2), then the look direction
            // scaled by (0.3, 0.45, 0.3) and turned about the y axis.
    // rust: let half = std::f32::consts::FRAC_PI_2;
    // rust: let angle = self.bearer_random(bearer).next_float() * (2.0 * half) - half;
    // rust: let (sin, cos) = angle.sin_cos();
    // rust: let (x, z) = (look[0] * 0.3, look[2] * 0.3);
    // rust: let velocity = Vec3::new(
    // rust: f64::from(x as f32 * cos + z as f32 * sin),
    // rust: look[1] * 0.3 * 1.5,
    // rust: f64::from(-x as f32 * sin + z as f32 * cos),
    // rust: );
    // rust: if let Some(id) = self.spawn_mob_for("minecraft:silverfish", at, false, true)
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: m.velocity = velocity;
}
    // rust: self.audio
    // rust: .play("minecraft:entity.silverfish.hurt", Some(at), 1.0, 1.0);
}
}
    /// A splash potion, lingering potion or experience bottle in flight (the
    /// player's throws and dispensers both end up here).
    // rust: pub(super) fn launch_thrown(
    // rust: &mut self,
    // rust: stack: ItemStack,
    // rust: position: Vec3,
    // rust: velocity: Vec3,
    // rust: owner: Option<Text>,
    // rust: ) {
    // rust: let id = self.take_entity_id();
    // rust: self.potions.thrown.push(ThrownPotion {
    // rust: id,
    // rust: stack,
    // rust: previous: position,
    // rust: position,
    // rust: velocity,
    // rust: age: 0,
    // rust: thrower: owner.is_some().then_some(Who::Player),
    // rust: guest: self.lan_acting.filter(|_| owner.is_some()),
    // rust: owner,
    // rust: left_owner: false,
    // rust: });
}
}
/// What a player's body was last given for its effects and enchantments:
/// a guest keeps their own while the host's are in `PotionState`.
    // rust: pub(super) struct BodyPotions {
    // rust: applied: Vec<(&'static str, &'static str, f64, &'static str)>,
    // rust: protection_for: Option<(u64, Vec<Option<ItemStack>>)>,
    // rust: enchant_modifiers: Vec<(String, String, f64, String)>,
}
/// Effects, thrown potions and the attribute modifiers last applied.
    // rust: pub(super) struct PotionState {
    // rust: pub(super) effects: PlayerEffects,
    // rust: thrown: Vec<ThrownPotion>,
    /// The area effect clouds a server tracks (game/remote_projectiles.rs).
    // rust: pub(super) clouds: Vec<super::remote_projectiles::RemoteCloud>,
    // rust: applied: Vec<(&'static str, &'static str, f64, &'static str)>,
    /// Armor the protection table was computed for.
    // rust: protection_for: Option<(u64, Vec<Option<ItemStack>>)>,

    /// Enchantment attribute modifiers on the player: (attribute, id, amount, operation).
    // rust: pub(super) enchant_modifiers: Vec<(String, String, f64, String)>,
}

    // rust: impl PotionState {
    /// Trade the player's own state (effects and what their body was given)
    /// with a guest's, around `as_guest`. Potions in flight stay.
    // rust: pub(super) fn swap_player(&mut self, effects: &mut PlayerEffects, body: &mut BodyPotions) {
    // rust: std::mem::swap(&mut self.effects, effects);
    // rust: std::mem::swap(&mut self.applied, &mut body.applied);
    // rust: std::mem::swap(&mut self.protection_for, &mut body.protection_for);
    // rust: std::mem::swap(&mut self.enchant_modifiers, &mut body.enchant_modifiers);
}
    /// Thrown potions in flight as (entity type, position, motion), for the
    /// dispenser parity fixture.
    // rust: pub(super) fn thrown_entities(&self) -> Vec<(&'static str, Vec3, Vec3)> {
    // rust: self.thrown
    // rust: .iter()
    // rust: .map(|t| (thrown_kind(&t.stack), t.position, t.velocity))
    // rust: .collect()
}
    // rust: pub(super) fn clear_thrown(&mut self) {
    // rust: self.thrown.clear();
}
    /// Their entity ids, for a server to number them.
    // rust: pub(super) fn thrown_ids(&mut self) -> impl Iterator<Item = &mut u32> {
    // rust: self.thrown.iter_mut().map(|t| &mut t.id)
}
    /// The numbered ones as a server's clients track them: (id, entity
    /// type, item, position, motion).
    // rust: pub(super) fn thrown_tracked(
    // rust: &self,
    // rust: ) -> impl Iterator<Item = (u32, &'static str, &ItemStack, Vec3, Vec3)> {
    // rust: self.thrown.iter().filter(|t| t.id != 0).map(|t| {
    // rust: (
    // rust: t.id,
    // rust: thrown_kind(&t.stack),
    // rust: &t.stack,
    // rust: t.position,
    // rust: t.velocity,
    // rust: )
    // rust: })
}
    /// `handleAddEntity` for a thrown potion or bottle on a server's client:
    /// drawn where the server says (its item comes in its entity data).
    // rust: pub(super) fn add_remote_thrown(&mut self, id: u32, kind: &str, at: Vec3, velocity: Vec3) {
    // rust: self.thrown.retain(|t| t.id != id);
    // rust: let item = match kind {
    // rust: "minecraft:lingering_potion" | "minecraft:experience_bottle" => kind,
    // rust: _ => "minecraft:splash_potion",
}
    // rust: self.thrown.push(ThrownPotion {
    // rust: id,
    // rust: stack: ItemStack::new(item, 1),
    // rust: previous: at,
    // rust: position: at,
    // rust: velocity,
    // rust: age: 0,
    // rust: owner: None,
    // rust: thrower: None,
    // rust: guest: None,
    // rust: left_owner: false,
    // rust: });
}
    /// ThrowableItemProjectile.DATA_ITEM_STACK: the potion it shows.
    // rust: pub(super) fn remote_thrown_item(&mut self, id: u32, stack: ItemStack) {
    // rust: if let Some(t) = self.thrown.iter_mut().find(|t| t.id == id) {
    // rust: t.stack = stack;
}
}
    /// A server's move: thrown potions have no interpolation handler, so
    /// `moveOrInterpolateTo` puts them there at once. False when `id` isn't one.
    // rust: pub(super) fn move_remote_thrown(&mut self, id: u32, at: Vec3) -> bool {
    // rust: let Some(t) = self.thrown.iter_mut().find(|t| t.id == id) else {
    // rust: return false;
}
    // rust: t.position = at;
    // rust: true
}
    /// `handleSetEntityMotion` for a thrown potion. False when `id` isn't one.
    // rust: pub(super) fn remote_thrown_motion(&mut self, id: u32, velocity: Vec3) -> bool {
    // rust: let Some(t) = self.thrown.iter_mut().find(|t| t.id == id) else {
    // rust: return false;
}
    // rust: t.velocity = velocity;
    // rust: true
}
    // rust: pub(super) fn remove_remote_thrown(&mut self, id: u32) {
    // rust: self.thrown.retain(|t| t.id != id);
}
    // rust: pub(super) fn has_thrown(&self, id: u32) -> bool {
    // rust: self.thrown.iter().any(|t| t.id == id)
}
}

/// The entity type of a thrown potion or bottle.
pub fn thrown_kind(stack: *ItemStack) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &*stack.item {
    // rust: "minecraft:lingering_potion" => "minecraft:lingering_potion",
    // rust: "minecraft:experience_bottle" => "minecraft:experience_bottle",
    // rust: _ => "minecraft:splash_potion",
}
}

/// `BottleItem.use`: find a living `AreaEffectCloud` owned by an `EnderDragon`
/// within the player's box grown by 2, and shrink its radius by 0.5.
    // rust: pub(super) fn collect_dragon_breath(
    // rust: player_box: Aabb,
    // rust: clouds: &mut [super::dragon::Breath],
    // rust: ) -> bool {
    // rust: let search_box = player_box.inflate(Vec3::new(2.0, 2.0, 2.0));
    // rust: if let Some(c) = clouds.iter_mut().find(|c| {
    // rust: if !c.from_dragon || c.potion.is_some() || super::dragon::breath_expired(c.age, c.duration)
    // rust: {
    // rust: return false;
}
    // rust: let r = f64::from(c.radius);
    // rust: let cloud_box = Aabb::new(
    // rust: Vec3::new(c.at[0] - r, c.at[1], c.at[2] - r),
    // rust: Vec3::new(c.at[0] + r, c.at[1] + 0.5, c.at[2] + r),
    // rust: );
    // rust: search_box.intersects(cloud_box)
    // rust: }) {
    // rust: c.radius = (c.radius - 0.5).max(0.0);
    // rust: true
    // rust: } else {
    // rust: false
}
}

    // rust: impl Game<'_> {
    /// Right-click with a potion, splash/lingering potion or glass bottle.
    // rust: pub(super) fn use_potion_item(&mut self, stack: &ItemStack) -> horizon_client::Result<bool> {
    // rust: match &*stack.item {
    // rust: "minecraft:potion" | "minecraft:ominous_bottle" => {
    // rust: self.start_using_item();
    // rust: Ok(true)
}
    // rust: "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion"
    // rust: | "minecraft:experience_bottle" => {
    // rust: let Some(eye) = self.eye_position() else {
    // rust: return Ok(true);
}
    // rust: let pitch = 0.4 / (self.world.random.next_float() * 0.4 + 0.8);
    // rust: let (sound, power) = match &*stack.item {
    // rust: "minecraft:splash_potion" => ("minecraft:entity.splash_potion.throw", 0.5),
    // rust: "minecraft:experience_bottle" => {
    // rust: ("minecraft:entity.experience_bottle.throw", 0.7)
}
    // rust: _ => ("minecraft:entity.lingering_potion.throw", 0.5),
}
    // rust: self.audio.play(sound, Some(eye), 0.5, pitch);
                // Projectile.shootFromRotation(xRot, yRot, -20, 0.5, 1.0).
    // rust: let (yaw, pitch) = (self.yaw.to_radians(), self.pitch.to_radians());
    // rust: let dir = [
    // rust: -yaw.sin() * pitch.cos(),
    // rust: -(self.pitch - 20.0).to_radians().sin(),
    // rust: yaw.cos() * pitch.cos(),
    // rust: ];
    // rust: let l = dir
    // rust: .iter()
    // rust: .map(|c| f64::from(*c).powi(2))
    // rust: .sum::<f64>()
    // rust: .sqrt()
    // rust: .max(1e-9);
                // getMovementToShoot: normalize, add triangle(0, 0.0172275 * uncertainty), scale.
    // rust: let r = &mut self.world.random;
    // rust: let mut jitter = || r.triangle(0.0, 0.0172275);
    // rust: let v = Vec3::new(
    // rust: (f64::from(dir[0]) / l + jitter()) * power,
    // rust: (f64::from(dir[1]) / l + jitter()) * power,
    // rust: (f64::from(dir[2]) / l + jitter()) * power,
    // rust: );
    // rust: let pv = self.known_player_movement();
    // rust: let on_ground = self.player.as_ref().is_some_and(|p| p.ground.on_ground);
    // rust: let v = Vec3::new(
    // rust: v.x + pv.x,
    // rust: v.y + if on_ground { 0.0 } else { pv.y },
    // rust: v.z + pv.z,
    // rust: );
    // rust: self.launch_thrown(
    // rust: ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
    // rust: },
    // rust: Vec3::new(eye[0], eye[1] - 0.1, eye[2]),
    // rust: v,
    // rust: Some(self.player_display_text()),
    // rust: );
    // rust: self.swing_arm();
    // rust: self.consume_held();
    // rust: Ok(true)
}
    // rust: "minecraft:glass_bottle" => {
                // `BottleItem.use`: before the water check, it looks for a living
                // AreaEffectCloud owned by an EnderDragon within the player's box
                // grown by 2. If one is found, it shrinks the cloud's radius by 0.5,
                // plays item.bottle.fill_dragonbreath at the player, emits
                // GameEvent.FLUID_PICKUP, and turns one bottle into dragon_breath.
    // rust: if let Some(player) = self.player.as_ref()
    // rust: && collect_dragon_breath(player.bounds(), &mut self.breath_clouds)
    // rust: {
    // rust: let player_pos = [player.position.x, player.position.y, player.position.z];
    // rust: self.audio.play(
    // rust: "minecraft:item.bottle.fill_dragonbreath",
    // rust: Some(player_pos),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: self.post_entity_event("minecraft:fluid_pickup", Who::Player);
    // rust: self.fill_held(ItemStack::new("minecraft:dragon_breath", 1));
    // rust: return Ok(true);
}
    // rust: let Some(hit) = self.pick_fluid() else {
    // rust: return Ok(false);
}
    // rust: let state = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: if self.res.facts().get(state).fluid != horizon_client::blocks::Fluid::Water {
    // rust: return Ok(false);
}
    // rust: let at = [
    // rust: f64::from(hit.pos[0]) + 0.5,
    // rust: f64::from(hit.pos[1]) + 0.5,
    // rust: f64::from(hit.pos[2]) + 0.5,
    // rust: ];
    // rust: self.audio
    // rust: .play("minecraft:item.bottle.fill", Some(at), 1.0, 1.0);
    // rust: let water = ItemStack::new("minecraft:potion", 1).with_potion("minecraft:water");
    // rust: self.fill_held(water);
    // rust: Ok(true)
}
    // rust: _ => Ok(false),
}
}
    /// `PotionItem.useOn`: a water bottle used on a block that turns to mud
    /// (`#convertible_to_mud`), not on its underside, is poured out and the
    /// block becomes mud.
    // rust: pub(super) fn use_water_bottle_on_block(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: face: [i32; 3],
    // rust: stack: &ItemStack,
    // rust: ) -> horizon_client::Result<bool> {
    // rust: if &*stack.item != "minecraft:potion"
    // rust: || stack.potion() != Some("minecraft:water")
    // rust: || face == [0, -1, 0]
    // rust: || !self.block_in_tag("minecraft:convertible_to_mud", &self.block_name(pos))
    // rust: {
    // rust: return Ok(false);
}
    // rust: let centre = pos.map(|v| f64::from(v) + 0.5);
    // rust: self.audio
    // rust: .play("minecraft:entity.generic.splash", Some(centre), 1.0, 1.0);
    // rust: self.fill_held(ItemStack::new("minecraft:glass_bottle", 1));
        // PotionItem.useOn: five ServerLevel.sendParticles(SPLASH). The level
        // random places each one (count 1, no spread, speed 1). The packet is
        // what the window draws; a window that runs this itself still adds it.
    // rust: for _ in 0..5 {
    // rust: let r = &mut self.world.random;
    // rust: let at = [
    // rust: f64::from(pos[0]) + r.next_double(),
    // rust: f64::from(pos[1] + 1),
    // rust: f64::from(pos[2]) + r.next_double(),
    // rust: ];
    // rust: let options = ParticleOptions::simple(ParticleType::Splash);
    // rust: self.particles.add(&options, at, [0.0; 3]);
    // rust: self.lan_send_particles(super::lan_particles::QueuedParticle {
    // rust: dimension: self.dim.id(),
    // rust: options,
    // rust: state: None,
    // rust: at,
    // rust: spread: [0.0; 3],
    // rust: speed: [1.0; 3],
    // rust: count: 1,
    // rust: randomization: 0,
    // rust: });
}
    // rust: self.audio
    // rust: .play("minecraft:item.bottle.empty", Some(centre), 1.0, 1.0);
    // rust: self.post_block_game_event("minecraft:fluid_place", pos, None, None);
    // rust: if let Some(mud) = self.pack.assets.registry.default_state("minecraft:mud") {
    // rust: self.level_set(pos, mud)?;
}
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
    // rust: Ok(true)
}
    /// `ItemUtils.createFilledResult`: replace one of the held stack.
pub fn fill_held(self: *Self, filled: ItemStack) void {
}
    // rust: if self.creative {
    // rust: let _ = self.give(filled);
    // rust: return;
}
    // rust: self.consume_held();
    // rust: if self.held().is_none() {
    // rust: *self.held_mut() = Some(filled);
    // rust: } else if let Some(rest) = self.give(filled)
    // rust: && let Some(eye) = self.eye_position()
    // rust: {
            // `player.drop(stack, false)`.
    // rust: self.throw_from_eyes(rest, eye, false);
}
}
    /// Drinking a potion while right-click is held; true when handled.
    // rust: pub(super) fn tick_drinking(&mut self, slot: usize, ticks: u32, stack: &ItemStack) -> bool {
    // rust: let ominous = &*stack.item == "minecraft:ominous_bottle";
    // rust: if &*stack.item != "minecraft:potion" && !ominous {
    // rust: return false;
}
        // the duration the use started with (32, as a mod's Start or Tick left it).
    // rust: let duration = self.use_duration;
    // rust: let ticks = ticks + 1;
    // rust: let remaining = duration.saturating_sub_unsigned(ticks).max(0);
    // rust: let eye = self.eye_position().unwrap_or_default();
        // Consumable.emitParticlesAndSounds: the drink sound every 4 ticks near the end.
    // rust: if remaining <= 25 && remaining % 4 == 0 {
    // rust: let pitch = self.world.random.next_float() * 0.1 + 0.9;
    // rust: self.audio
    // rust: .play("minecraft:entity.generic.drink", Some(eye), 0.5, pitch);
}
        // ItemStack.onUseTick: the item's own tick after the consumable's.
    // rust: self.item_on_use_tick(stack, ticks - 1);
    // rust: if i64::from(ticks) < i64::from(duration) {
    // rust: self.using = Some((slot, ticks));
    // rust: return true;
}
    // rust: self.finish_drinking(slot, stack);
    // rust: true
}
    /// `PotionItem.finishUsingItem` (and `OminousBottleItem`'s) of `stack` in
    /// `slot`, the use complete: false for anything else.
    // rust: pub(super) fn finish_drinking(&mut self, slot: usize, stack: &ItemStack) -> bool {
    // rust: let ominous = &*stack.item == "minecraft:ominous_bottle";
    // rust: if &*stack.item != "minecraft:potion" && !ominous {
    // rust: return false;
}
    // rust: let eye = self.eye_position().unwrap_or_default();
    // rust: self.using = None;
    // rust: self.send_use_item_complete();
        // Consumable.onConsume: the used statistic and the consume_item
        // trigger, with the stack as drunk (before it shrinks).
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.trigger_item("minecraft:consume_item", stack);
    // rust: self.post_entity_event("minecraft:drink", horizon_client::mobs::Who::Player);
    // rust: if ominous {
    // rust: self.drink_ominous_bottle(slot, stack);
    // rust: return true;
}
        // PotionContents.onConsume: the potion's and the custom effects, at the
        // stack's POTION_DURATION_SCALE.
    // rust: let (lasting, now) = PlayerEffects::contents_effects(
    // rust: &brewing::contents_effects(stack),
    // rust: stack.potion_duration_scale(),
    // rust: );
    // rust: for e in lasting {
    // rust: self.add_player_effect(e);
}
    // rust: for a in now {
    // rust: self.apply_effect_action(a);
}
    // rust: if !self.creative {
    // rust: if let Some(s) = self.stack_in_mut(slot).as_mut() {
    // rust: s.count -= 1;
    // rust: if s.count == 0 {
    // rust: *self.stack_in_mut(slot) = None;
}
}
    // rust: let bottle = ItemStack::new("minecraft:glass_bottle", 1);
    // rust: if self.stack_in(slot).is_none() {
    // rust: *self.stack_in_mut(slot) = Some(bottle);
    // rust: } else if let Some(rest) = self.give(bottle) {
    // rust: self.spawn_item(rest, eye, [0.0, 0.1, 0.0], 40);
}
}
    // rust: true
}
    /// `Arrow.doPostHurtEffects` and `SpectralArrow.doPostHurtEffects`: the
    /// arrow's item gives its target Glowing (spectral) or its potion contents
    /// at the stack's duration scale (a tipped arrow's default is an eighth);
    /// a mob's arrow without such an item (a stray's) carries its own effect.
    /// Instant effects act at once: harming hurts and healing heals, the
    /// other way round for the undead.
    // rust: pub(super) fn arrow_post_hurt_effects(&mut self, p: &Projectile, who: Who) {
    // rust: let from_item = p.arrow.as_ref().map(|a| &a.pickup_item);
    // rust: let mut effects: Vec<(&'static str, i32, i32)> = match from_item {
    // rust: Some(s) if &*s.item == "minecraft:spectral_arrow" => vec![("glowing", 200, 0)],
    // rust: Some(s) => {
    // rust: let scale = s.potion_duration_scale();
    // rust: brewing::contents_effects(s)
    // rust: .into_iter()
    // rust: .map(|(id, d, amp)| {
    // rust: (id, horizon_client::effects::scaled_duration(d, scale), amp)
    // rust: })
    // rust: .collect()
}
    // rust: None => Vec::new(),
}
    // rust: if effects.is_empty()
    // rust: && let ProjectileKind::Arrow {
    // rust: effect: Some((id, ticks)),
    // rust: ..
    // rust: } = p.kind
    // rust: && let Some(e) = brewing::effect(id)
    // rust: {
    // rust: effects.push((e.id, ticks, 0));
}
    // rust: if effects.is_empty() {
    // rust: return;
}
    // rust: match who {
    // rust: Who::Player => {
    // rust: for (id, duration, amp) in effects {
    // rust: if brewing::effect(id).is_some_and(|e| e.instant) {
    // rust: if let Some(a) = horizon_client::effects::instant(id, amp, 1.0) {
    // rust: self.apply_effect_action(a);
}
    // rust: } else {
    // rust: self.add_player_effect(EffectInstance::new(id, duration, amp));
}
}
}
    // rust: Who::Mob(id) => {
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == id && m.alive()) else {
    // rust: return;
}
    // rust: let inverted = self
    // rust: .res
    // rust: .stations()
    // rust: .enchantments
    // rust: .entity_tags
    // rust: .get("minecraft:inverted_healing_and_harm")
    // rust: .is_some_and(|t| t.contains(&self.mobs[i].kind.id));
    // rust: for (effect, duration, amp) in effects {
    // rust: let tags = &self.res.stations().enchantments.entity_tags;
                    // A mod's `onEffectAdded` may have changed the mobs.
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: match effect {
    // rust: "instant_damage" | "instant_health" => {
                            // `LivingEntity.addEffect` refuses nothing here; the
                            // tick hurts with magic (6 << amp) or heals (4 << amp).
    // rust: if (effect == "instant_damage") != inverted {
    // rust: m.damage((6 << amp.min(30)) as f32, Damage::of(DamageKind::Magic));
    // rust: } else {
    // rust: m.heal((4 << amp.min(30)) as f32);
}
}
    // rust: _ => {
    // rust: if mob_can_be_affected(tags, &m.kind.id, effect)
    // rust: && let Some(name) = mob_effect_id(effect)
    // rust: {
    // rust: let new = !m.has_effect(name);
    // rust: m.add_effect(name, duration, amp);
    // rust: self.mod_effect_added(name, Some(id as i32), amp, new);
}
}
}
}
}
}
}
    // rust: pub(super) fn apply_effect_action(&mut self, action: EffectAction) {
    // rust: let action = match action {
    // rust: EffectAction::Heal(mut amount) => {
    // rust: if let Some(player) = self.player.as_ref() {
    // rust: let mut cancel = false;
    // rust: horizon_client::hunger::native_living_heal(
    // rust: player.entity_id as u32,
    // rust: &mut amount,
    // rust: &mut cancel,
    // rust: );
    // rust: if cancel {
    // rust: return;
}
}
    // rust: EffectAction::Heal(amount)
}
    // rust: action => action,
}
    // rust: let creative = self.creative;
    // rust: let rules = self.world.health_rules;
    // rust: let Some(p) = self.player.as_mut() else {
    // rust: self.combat.forget_noted(false);
    // rust: return;
}
    // rust: match action {
    // rust: EffectAction::Heal(amount) => {
    // rust: let max = p.attribute("minecraft:max_health").unwrap_or(20.0) as f32;
    // rust: let h = p.health.health();
    // rust: if h > 0.0 {
    // rust: let _ = p.set_health((h + amount).min(max), false);
}
}
    // rust: EffectAction::Hurt(source, amount) => {
    // rust: let mut canceled = false;
    // rust: if !creative
    // rust: && let Some(id) = self.health_resources.damage.id(source)
    // rust: && let Ok(o) = p.hurt_blocking(&self.health_resources, rules, id, amount, None)
    // rust: {
    // rust: canceled = o.canceled;
}
    // rust: self.combat.forget_noted(canceled);
}
    // rust: EffectAction::Poison => {
    // rust: if !creative
    // rust: && p.health.health() > 1.0
    // rust: && let Some(id) = self.health_resources.damage.id("minecraft:magic")
    // rust: {
    // rust: let _ = p.hurt(&self.health_resources, rules, id, 1.0);
}
}
    // rust: EffectAction::Exhaust(amount) => {
    // rust: p.cause_food_exhaustion(amount);
}
    // rust: EffectAction::Eat(nutrition, saturation) => {
    // rust: let food = &mut p.health.food;
    // rust: food.food = (food.food + nutrition).clamp(0, 20);
    // rust: food.saturation = (food.saturation + nutrition as f32 * saturation * 2.0)
    // rust: .clamp(0.0, food.food as f32);
}
}
}
    /// The local player's effects (`tick_mob_effects`), then the potions
    /// in flight, which a server without a local player still has. A frozen
    /// tick (`/tick freeze`) leaves the potions where they are
    /// (`TickRateManager.isEntityFrozen`); players' effects still run.
    // rust: pub(super) fn tick_effects(&mut self, running: bool) {
    // rust: self.tick_mob_effects();
    // rust: if running {
    // rust: self.tick_thrown_potions();
    // rust: self.tick_potion_clouds();
}
}
    /// `LivingEntity.tickEffects` (server side) for `self.player`, the local
    /// player or a guest acting (`as_guest`), then its attribute modifiers
    /// and status flags.
    // rust: pub(super) fn tick_mob_effects(&mut self) {
    // rust: let Some(player) = self.player.as_ref() else {
    // rust: return;
}
    // rust: if player.health.dead_or_dying() {
            // LivingEntity.die → removeAllEffects. Vanilla runs the effects
            // that act on death (`onMobRemoved`) when the dead player is
            // removed, up to 20 ticks later; here it is as the effects go.
    // rust: let w = f64::from(player.dimensions.width) / 2.0;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(
    // rust: player.position.x - w,
    // rust: player.position.y,
    // rust: player.position.z - w,
    // rust: ),
    // rust: Vec3::new(
    // rust: player.position.x + w,
    // rust: player.position.y + f64::from(player.dimensions.height),
    // rust: player.position.z + w,
    // rust: ),
    // rust: );
    // rust: let ids: Vec<&'static str> = self.potions.effects.list.iter().map(|e| e.id).collect();
    // rust: self.potions.effects.clear();
    // rust: if !ids.is_empty() {
    // rust: self.effects_on_death(&ids, bounds, true, None, None);
}
}
        // The omens act from inside the effect tick (BadOmenMobEffect,
        // RaidOmenMobEffect), as a content mod's effects do.
    // rust: let absorption_empty = self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.health.absorption() <= 0.0);
    // rust: let mut effects = std::mem::take(&mut self.potions.effects);
    // rust: let (actions, raid_omen_added) = effects.tick_with(
    // rust: &mut |e, t| {
    // rust: if !brewing::is_mod_effect(e.id) {
    // rust: self.omen_tick(e)
    // rust: } else if self.mod_effect_tick(e.id, None, t, e.amplifier) {
    // rust: OmenTick::Continue
    // rust: } else {
    // rust: OmenTick::Remove
}
    // rust: },
    // rust: absorption_empty,
    // rust: );
    // rust: self.potions.effects = effects;
    // rust: if raid_omen_added {
    // rust: self.raid_omen_added();
}
    // rust: for action in actions {
    // rust: self.apply_effect_action(action);
}
    // rust: self.turtle_helmet_tick();
    // rust: self.apply_effect_status();
}
    /// `Player.tick` -> `turtleHelmetTick`: with a turtle helmet on the head
    /// and the eyes out of the water, Water Breathing for 200 ticks (no
    /// particles, an icon).
pub fn turtle_helmet_tick(self: *Self) void {
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let eye_y = p.position.y + f64::from(p.dimensions.eye_height);
    // rust: if !p.health.dead_or_dying()
    // rust: && self.armor[0]
    // rust: .as_ref()
    // rust: .is_some_and(|s| &*s.item == "minecraft:turtle_helmet")
    // rust: && !self.eye_in_water(p.position.x, eye_y, p.position.z)
    // rust: {
    // rust: let mut effect = EffectInstance::new("water_breathing", 200, 0);
    // rust: effect.visible = false;
    // rust: self.potions.effects.add(effect);
}
}
    /// A client's own effects (`LivingEntity.tickEffects` on the client,
    /// `MobEffectInstance.tickClient`): they count down and blend, and the
    /// server removes them. Their modifiers and flags move the predicted
    /// player.
    // rust: pub(super) fn tick_client_effects(&mut self) {
    // rust: client_tick_effects(&mut self.potions.effects, &mut self.sculk.darkness);
    // rust: self.apply_effect_status();
}
    /// Add an active effect to the player and update attributes / absorption.
    // rust: pub(super) fn add_player_effect(&mut self, effect: EffectInstance) -> bool {
    // rust: let id = effect.id;
    // rust: let amp = effect.amplifier;
    // rust: let new = self.potions.effects.get(id).is_none();
    // rust: let changed = self.potions.effects.add(effect);
    // rust: self.apply_effect_status();
    // rust: if id == "absorption"
    // rust: && let Some(p) = self.player.as_mut()
    // rust: {
    // rust: let target = 4.0 * (amp + 1) as f32;
    // rust: let current = p.health.absorption();
    // rust: let _ = p.set_health(current.max(target), true);
}
    // rust: self.mod_effect_added(id, None, amp, new);
    // rust: changed
}
    /// `LivingEntity.addEffect` for a content mod's effect: its
    /// `onEffectAdded` when it is new, then its `onEffectStarted`, on a
    /// server. `entity` is a mob's id, None for the player.
    // rust: pub(super) fn mod_effect_added(
    // rust: &mut self,
    // rust: effect: &str,
    // rust: entity: Option<i32>,
    // rust: amplifier: i32,
    // rust: new: bool,
    // rust: ) {
    // rust: if self.remote.is_none() && brewing::is_mod_effect(effect) {
    // rust: if new {
    // rust: self.native_on_effect_added(effect, entity, amplifier);
}
    // rust: self.native_mob_effect_added(effect, entity, amplifier);
}
}
    /// `MobEffectInstance.tickServer` for a content mod's effect: its
    /// `shouldApplyEffectTickThisTick`, then its `applyEffectTick`, which
    /// may end it. Whether it stays.
    // rust: fn mod_effect_tick(
    // rust: &self,
    // rust: effect: &str,
    // rust: entity: Option<i32>,
    // rust: tick_count: i32,
    // rust: amplifier: i32,
    // rust: ) -> bool {
    // rust: let mut apply = false;
    // rust: self.native_should_apply_effect_tick_this_tick(effect, tick_count, amplifier, &mut apply);
    // rust: let mut keep = true;
    // rust: if apply {
    // rust: self.native_apply_effect_tick(effect, self.dim.id(), entity, amplifier, &mut keep);
}
    // rust: keep
}
    /// The effects' attribute modifiers, armor protection and status flags
    /// on `self.player`.
    // rust: pub(super) fn apply_effect_status(&mut self) {
    // rust: let modifiers = self.potions.effects.modifiers();
    // rust: if modifiers != self.potions.applied
    // rust: && let Some(p) = self.player.as_mut()
    // rust: {
    // rust: for (attr, id, _, op) in &self.potions.applied {
    // rust: let _ = p.set_modifier_unclamped(attr, id, 0.0, op, false);
}
    // rust: for (attr, id, amount, op) in &modifiers {
    // rust: let _ = p.set_modifier_unclamped(attr, id, *amount, op, true);
}
            // onAttributeUpdated, once the batch settled: a lost health_boost.
    // rust: let _ = p.clamp_health_to_max();
    // rust: self.potions.applied = modifiers;
}
    // rust: if let Some(p) = self.player.as_mut()
    // rust: && self.potions.effects.amplifier("absorption").is_none()
    // rust: && p.health.absorption() > 0.0
    // rust: {
    // rust: let _ = p.set_health(0.0, true);
}
        // EnchantmentHelper.getDamageProtection per damage type, recomputed on armor change.
    // rust: let armor: Vec<Option<ItemStack>> = self.armor.to_vec();
    // rust: if !self
    // rust: .potions
    // rust: .protection_for
    // rust: .as_ref()
    // rust: .is_some_and(|(generation, cached)| {
    // rust: *generation == self.damage_tag_generation && cached == &armor
    // rust: })
    // rust: {
    // rust: let mut table = Vec::new();
    // rust: let e = &self.stations().enchantments;
    // rust: let mut random = horizon_core::random::LegacyRandom::new(0);
    // rust: for (_, def) in self.health_resources.damage.entries() {
    // rust: let ctx = horizon_client::enchant::EffectContext {
    // rust: items: Some(self.items()),
    // rust: damage_type: Some(&def.name),
    // rust: this: Some("minecraft:player"),
    // rust: ..Default::default()
}
    // rust: let total: f32 = armor
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(|s| {
    // rust: e.modify_value(
    // rust: Some(s),
    // rust: "minecraft:damage_protection",
    // rust: &ctx,
    // rust: &mut random,
    // rust: 0.0,
    // rust: )
    // rust: })
    // rust: .sum();
    // rust: if total > 0.0 {
    // rust: table.push((def.name.clone(), total));
}
}
    // rust: self.potions.protection_for = Some((self.damage_tag_generation, armor));
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.status.protection = table;
}
}
    // rust: let mut status = self.potions.effects.status();
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: status.protection = std::mem::take(&mut p.status.protection);
    // rust: p.status = status;
}
}
    /// The players a thrown potion can hit (`Projectile.canHitEntity`): the
    /// host and the guests, but not a spectator or a dead one.
pub fn thrown_player_targets(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut targets = Vec::new();
    // rust: if let Some(p) = self.player_view()
    // rust: && p.alive
    // rust: && !self.spectator()
    // rust: {
    // rust: targets.push((Who::Player, p.bounds));
}
    // rust: targets.extend(self.lan_projectile_targets());
    // rust: targets
}
    /// The thrower's vehicle tree as `Projectile` sees it
    /// (`owner.getRootVehicle().getSelfAndPassengers()`): the players in it (the
    /// thrower and who shares their vehicle), the mob that is the vehicle, and
    /// the boxes of all of them. Until the potion has left it, none can be hit
    /// (`canHitEntity`: `isPassengerOfSameVehicle`) and any one near keeps it
    /// from leaving (`isOutsideOwnerCollisionRange`).
    // rust: fn thrown_ridden(
    // rust: &self,
    // rust: owner: Option<Who>,
    // rust: players: &[(Who, Aabb)],
    // rust: ) -> (Vec<Who>, Option<u32>, Vec<Aabb>) {
    // rust: let Some(owner) = owner else {
    // rust: return (Vec::new(), None, Vec::new());
}
    // rust: let vehicle_of = |who: Who| match who {
    // rust: Who::Player => self.riding,
    // rust: Who::Mob(id) => self
    // rust: .lan
    // rust: .as_ref()
    // rust: .and_then(|h| h.hub.guests.iter().find(|g| g.entity_id as u32 == id))
    // rust: .and_then(|g| g.vehicle),
}
    // rust: let vehicle = vehicle_of(owner);
    // rust: let mut who = vec![owner];
    // rust: let mut boxes = Vec::new();
    // rust: for (w, b) in players {
    // rust: if *w == owner || (vehicle.is_some() && vehicle_of(*w) == vehicle) {
    // rust: if *w != owner {
    // rust: who.push(*w);
}
    // rust: boxes.push(*b);
}
}
    // rust: if let Some(v) = vehicle {
    // rust: if let Some(m) = self.mobs.iter().find(|m| m.id == v) {
    // rust: boxes.push(m.bounds());
}
    // rust: if let Some(b) = self.boats.iter().find(|b| b.id == v) {
    // rust: boxes.push(b.bounds());
}
}
    // rust: (who, vehicle, boxes)
}
    /// `ThrowableProjectile.tick` for the potions in flight: the motion, then
    /// the first block, mob or player the step meets
    /// (`ProjectileUtil.getHitResultOnMoveVector`), where the potion splashes
    /// (`Projectile.onHit`). Its thrower is not met until it has left them
    /// (`Projectile.leftOwner`, checked before the move like `Projectile.tick`),
    /// nor anything else in their vehicle tree.
pub fn tick_thrown_potions(self: *Self) void {
}
    // rust: let mut thrown = std::mem::take(&mut self.potions.thrown);
    // rust: let players = if thrown.is_empty() {
    // rust: Vec::new()
    // rust: } else {
    // rust: self.thrown_player_targets()
}
    // rust: let mut landed = Vec::new();
    // rust: thrown.retain_mut(|t| {
    // rust: t.age += 1;
            // Projectile.tick: whether it has left its thrower's vehicle tree,
            // before it moves.
    // rust: let owner = self.shooter_who(t.thrower, t.guest);
    // rust: let (ridden, vehicle, boxes) = self.thrown_ridden(owner, &players);
    // rust: if !t.left_owner {
    // rust: t.left_owner = thrown_left_owner(&boxes, t.position, t.velocity);
}
    // rust: let skip: &[Who] = if t.left_owner { &[] } else { &ridden };
    // rust: t.previous = t.position;
    // rust: self.thrown_potion_motion(t);
    // rust: let next = Vec3::new(
    // rust: t.position.x + t.velocity.x,
    // rust: t.position.y + t.velocity.y,
    // rust: t.position.z + t.velocity.z,
    // rust: );
            // Hit a block along the step (sampled), a mob, a player, or fell out
            // of the world.
    // rust: let margin = thrown_margin(t.age);
    // rust: let steps = 4;
    // rust: let mut hit = None;
    // rust: for i in 1..=steps {
    // rust: let f = f64::from(i) / f64::from(steps);
    // rust: let p = Vec3::new(
    // rust: t.position.x + t.velocity.x * f,
    // rust: t.position.y + t.velocity.y * f,
    // rust: t.position.z + t.velocity.z * f,
    // rust: );
    // rust: let state =
    // rust: self.world
    // rust: .block(p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32);
    // rust: let mob = self.mobs.iter().find(|m| {
    // rust: m.alive()
    // rust: && (t.left_owner || Some(m.id) != vehicle)
    // rust: && (m.position.x - p.x).abs() < m.kind.width / 2.0 + 0.125
    // rust: && (m.position.z - p.z).abs() < m.kind.width / 2.0 + 0.125
    // rust: && p.y >= m.position.y
    // rust: && p.y <= m.position.y + m.kind.height
    // rust: });
                // A player (`canHitEntity`: not the thrower before it has left
                // them), the box grown by the 0.3 pick margin.
    // rust: let player = thrown_player_at(&players, skip, p, margin);
    // rust: if self.res.facts().get(state).full_collision || mob.is_some() || player.is_some() {
                    // A block hit has the face it came in by
                    // (`onHitBlock`); an entity hit has none.
    // rust: let block = (mob.is_none() && player.is_none())
    // rust: .then(|| thrown_block_hit(t.position, p, t.velocity));
    // rust: let at = mob.map(|m| m.position).or_else(|| {
    // rust: player.map(|(_, b)| {
    // rust: let c = b.center();
    // rust: Vec3::new(c.x, b.min(Axis::Y), c.z)
    // rust: })
    // rust: });
    // rust: hit = Some((p, at, block));
    // rust: break;
}
}
    // rust: if let Some((p, mob, block)) = hit {
    // rust: landed.push((
    // rust: t.stack.clone(),
    // rust: p,
    // rust: mob,
    // rust: block,
    // rust: t.age,
    // rust: t.owner.clone(),
    // rust: t.guest,
    // rust: ));
    // rust: return false;
}
    // rust: t.position = next;
    // rust: let bounds = Aabb::new(
    // rust: next.add_vector(Vec3::new(-0.125, 0.0, -0.125)),
    // rust: next.add_vector(Vec3::new(0.125, 0.25, 0.125)),
    // rust: );
    // rust: self.entity_powder_snow_particles(t.previous, next, bounds, t.velocity, false);
    // rust: t.age < 1200 && t.position.y > -128.0
    // rust: });
    // rust: self.potions.thrown = thrown;
    // rust: for (stack, at, mob, block, age, owner, guest) in landed {
            // Projectile.onHit (super.onHit of AbstractThrownPotion): a block
            // is heard at its centre, an entity at the hit.
    // rust: let heard = if mob.is_some() {
    // rust: [at.x, at.y, at.z]
    // rust: } else {
    // rust: [at.x.floor() + 0.5, at.y.floor() + 0.5, at.z.floor() + 0.5]
}
    // rust: let thrower = owner.is_some().then_some(Who::Player);
    // rust: self.projectile_event("minecraft:projectile_land", thrower, heard);
    // rust: let item = stack.item.to_string();
            // A potion a dispenser threw has nobody to name.
    // rust: let owner = PotionOwner {
    // rust: player: owner.is_some(),
    // rust: name: owner,
    // rust: attacker: None,
    // rust: guest,
}
    // rust: self.splash(&stack, at, mob, block, age, &owner);
    // rust: if item != "minecraft:experience_bottle" {
    // rust: self.native_potion_splash(&item, [at.x, at.y, at.z]);
}
}
}
    /// `AreaEffectCloud.readAdditionalSaveData`: loaded clouds join the same
    /// simulation as lingering potions, with their own timing and potion data.
    /// The caller retains their UUID and original compound for command queries.
    // rust: pub(super) fn load_potion_cloud(&mut self, tag: &Tag) -> Option<u32> {
//         use horizon_client::save::{float, number, text};
    // rust: let at = horizon_client::entity_nbt::position(tag)?;
    // rust: let int = |key, default| number(tag.get(key)).map_or(default, |v| v as i32);
    // rust: let real = |key, default| float(tag.get(key)).map_or(default, |v| v as f32);
    // rust: let contents = tag.get("potion_contents");
    // rust: let mut effects = contents
    // rust: .and_then(|c| text(c.get("potion")))
    // rust: .and_then(|id| brewing::potion(&id))
    // rust: .map_or_else(Vec::new, |p| p.effects.to_vec());
    // rust: let (mut hidden, mut ambient) = (Vec::new(), Vec::new());
    // rust: if let Some(Tag::List(custom)) = contents.and_then(|c| c.get("custom_effects")) {
    // rust: for effect in custom {
    // rust: let Some(def) = text(effect.get("id")).and_then(|id| brewing::effect(&id)) else {
    // rust: continue;
}
    // rust: let duration = number(effect.get("duration")).unwrap_or(0) as i32;
    // rust: let amp = number(effect.get("amplifier")).unwrap_or(0).clamp(0, 255) as i32;
    // rust: effects.push((def.id, duration, amp));
    // rust: if number(effect.get("show_particles")) == Some(0) {
    // rust: hidden.push(def.id);
}
    // rust: if number(effect.get("ambient")).unwrap_or(0) != 0 {
    // rust: ambient.push(def.id);
}
}
}
    // rust: let color = contents
    // rust: .and_then(|c| number(c.get("custom_color")))
    // rust: .map_or_else(
    // rust: || {
    // rust: horizon_client_core::potions::effects_color(
    // rust: effects
    // rust: .iter()
    // rust: .filter(|(id, ..)| !hidden.contains(id))
    // rust: .map(|(id, _, amp)| (*id, *amp)),
    // rust: )
    // rust: },
    // rust: |color| color as u32,
    // rust: );
    // rust: let id = self.take_entity_id();
    // rust: self.breath_clouds.push(Breath {
    // rust: id,
    // rust: at: [at.x, at.y, at.z],
    // rust: radius: real("Radius", 3.0).clamp(0.0, 32.0),
    // rust: age: int("Age", 0),
    // rust: duration: int("Duration", -1),
    // rust: from_dragon: false,
    // rust: victims: Vec::new(),
    // rust: potion: Some(PotionCloud {
    // rust: settings: CloudSettings {
    // rust: wait_time: int("WaitTime", 20),
    // rust: reapplication_delay: int("ReapplicationDelay", 20),
    // rust: radius_on_use: real("RadiusOnUse", 0.0),
    // rust: duration_on_use: int("DurationOnUse", 0),
    // rust: duration_scale: real("potion_duration_scale", 1.0),
    // rust: },
    // rust: effects,
    // rust: hidden,
    // rust: ambient,
    // rust: radius_per_tick: real("RadiusPerTick", 0.0),
    // rust: color,
    // rust: victims: Vec::new(),
    // rust: source: Text::translate("entity.minecraft.area_effect_cloud", &[]),
    // rust: owner: None,
    // rust: guest: None,
    // rust: }),
    // rust: });
    // rust: Some(id)
}
    /// `AreaEffectCloud.tick` for the lingering potions' clouds: the client
    /// tick's particles, then the server tick.
pub fn tick_potion_clouds(self: *Self) void {
}
    // rust: if self.breath_clouds.iter().all(|c| c.potion.is_none()) {
    // rust: return;
}
    // rust: let players: Vec<FightPlayer> = self
    // rust: .fight_players()
    // rust: .into_iter()
    // rust: .filter(|p| p.alive)
    // rust: .collect();
    // rust: let mut clouds = std::mem::take(&mut self.breath_clouds);
    // rust: clouds.retain_mut(|c| c.potion.is_none() || self.tick_potion_cloud(c, &players));
    // rust: self.breath_clouds.append(&mut clouds);
}
    /// `AreaEffectCloud.serverTick`: configured lifetime/radius changes and
    /// five-tick doses, with each victim's configured reapplication delay.
    /// False once the cloud is gone.
pub fn tick_potion_cloud(self: *Self, c: *mut Breath, players: *[FightPlayer]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: c.age = c.age.wrapping_add(1);
    // rust: let Some(potion) = c.potion.as_mut() else {
    // rust: return true;
}
    // rust: if c.duration != -1 && c.age.wrapping_sub(potion.settings.wait_time) >= c.duration {
    // rust: return false;
}
    // rust: let waiting = c.age < potion.settings.wait_time;
    // rust: cloud_client_tick(
    // rust: &mut self.particles,
    // rust: c.at,
    // rust: c.radius,
    // rust: waiting,
    // rust: &potion.particle(),
    // rust: );
    // rust: if waiting {
    // rust: return true;
}
    // rust: if potion.radius_per_tick != 0.0 {
    // rust: c.radius += potion.radius_per_tick;
    // rust: if c.radius < 0.5 {
    // rust: return false;
}
    // rust: c.radius = c.radius.clamp(0.0, 32.0);
}
    // rust: if c.age % 5 != 0 {
    // rust: return true;
}
    // rust: potion.victims.retain(|(_, until)| c.age < *until);
    // rust: if potion.effects.is_empty() {
    // rust: potion.victims.clear();
    // rust: return true;
}
    // rust: let r = f64::from(c.radius);
    // rust: let area = Aabb::new(
    // rust: Vec3::new(c.at[0] - r, c.at[1], c.at[2] - r),
    // rust: Vec3::new(c.at[0] + r, c.at[1] + 0.5, c.at[2] + r),
    // rust: );
    // rust: let mut inside = Vec::new();
    // rust: for p in players.iter().filter(|p| p.bounds.intersects(area)) {
    // rust: inside.push((Victim::Player(p.who), p.position.x, p.position.z));
}
    // rust: let effects = potion.effects.clone();
    // rust: let tags = &self.stations().enchantments.entity_tags;
        // Only mobs that at least one of the cloud's effects can affect are
        // taken (`allEffects.stream().anyMatch(entity::canBeAffected)`), so
        // the others neither become victims nor use up its radius.
    // rust: for m in self.mobs.iter().filter(|m| {
    // rust: m.alive()
    // rust: && m.bounds().intersects(area)
    // rust: && effects
    // rust: .iter()
    // rust: .any(|(id, ..)| mob_can_be_affected(tags, &m.kind.id, id))
    // rust: }) {
    // rust: inside.push((Victim::Mob(m.id), m.position.x, m.position.z));
}
    // rust: for (victim, x, z) in inside {
    // rust: let (dx, dz) = (x - c.at[0], z - c.at[2]);
    // rust: if potion.victims.iter().any(|(v, _)| *v == victim)
    // rust: || dx * dx + dz * dz > f64::from(c.radius * c.radius)
    // rust: {
    // rust: continue;
}
    // rust: potion.victims.push((
    // rust: victim,
    // rust: c.age.wrapping_add(potion.settings.reapplication_delay),
    // rust: ));
    // rust: self.cloud_affect(
    // rust: victim,
    // rust: &effects,
    // rust: (
    // rust: &potion.hidden,
    // rust: &potion.ambient,
    // rust: potion.settings.duration_scale,
    // rust: ),
    // rust: c.at,
    // rust: &potion.source,
    // rust: (potion.owner, potion.guest),
    // rust: );
    // rust: if potion.settings.radius_on_use != 0.0 {
    // rust: c.radius += potion.settings.radius_on_use;
    // rust: if c.radius < 0.5 {
    // rust: return false;
}
    // rust: c.radius = c.radius.clamp(0.0, 32.0);
}
    // rust: if potion.settings.duration_on_use != 0 && c.duration != -1 {
    // rust: c.duration = c.duration.wrapping_add(potion.settings.duration_on_use);
    // rust: if c.duration <= 0 {
    // rust: return false;
}
}
}
    // rust: true
}
    /// `Creeper.spawnLingeringCloud`: an `AreaEffectCloud` of radius 2.5, wait time 10, duration 300,
    /// shrinking by `-radius / duration` a tick and by 0.5 for each entity it affects, applying
    /// the creeper's effects at 0.25 of their remaining duration.
    // rust: pub(super) fn spawn_creeper_cloud(
    // rust: &mut self,
    // rust: at: [f64; 3],
    // rust: effects: Vec<(&'static str, i32, i32)>,
    // rust: hidden: Vec<&'static str>,
    // rust: ambient: Vec<&'static str>,
    // rust: color: u32,
    // rust: ) {
    // rust: let id = self.take_entity_id();
    // rust: self.breath_clouds.push(Breath {
    // rust: id,
    // rust: at,
    // rust: radius: 2.5,
    // rust: age: 0,
    // rust: duration: 300,
    // rust: from_dragon: false,
    // rust: victims: Vec::new(),
    // rust: potion: Some(PotionCloud {
    // rust: settings: CloudSettings::lingering(),
    // rust: effects,
    // rust: hidden,
    // rust: ambient,
    // rust: radius_per_tick: -2.5 / 300.0,
    // rust: color,
    // rust: victims: Vec::new(),
    // rust: source: Text::translate("entity.minecraft.area_effect_cloud", &[]),
    // rust: owner: None,
    // rust: guest: None,
    // rust: }),
    // rust: });
}
    /// What a cloud puts on one entity: instant effects at half strength
    /// (`applyInstantaneousEffect` with 0.5), the others at the cloud's duration
    /// scale (`PotionContents.forEachEffect`).
    // rust: fn cloud_affect(
    // rust: &mut self,
    // rust: victim: Victim,
    // rust: effects: &[(&'static str, i32, i32)],
    // rust: (hidden, ambient, duration_scale): (&[&'static str], &[&'static str], f32),
    // rust: at: [f64; 3],
    // rust: source: &Text,
    // rust: (owner, guest): (Option<Who>, Option<u32>),
    // rust: ) {
        // `indirectMagic(cloud, owner)` names the cloud in the death message
        // (it gives no kill credit).
    // rust: let cloud_owner = PotionOwner {
    // rust: name: Some(source.clone()),
    // rust: ..Default::default()
}
        // MobEffectInstance.withScaledDuration: floor(duration * scale), at least 1; an infinite
        // effect stays infinite.
    // rust: let scaled = |duration| horizon_client::effects::scaled_duration(duration, duration_scale);
    // rust: match victim {
    // rust: Victim::Player(who) => self.as_fight_player(who, |g| {
    // rust: for (id, duration, amp) in effects {
    // rust: let Some(e) = brewing::effect(id) else {
    // rust: continue;
}
    // rust: if e.instant {
    // rust: if let Some(a) = horizon_client::effects::instant(id, *amp, 0.5) {
    // rust: g.apply_indirect_effect_action(a, &cloud_owner);
}
    // rust: } else {
    // rust: let mut instance = EffectInstance::new(e.id, scaled(*duration), *amp);
    // rust: instance.visible = !hidden.contains(id);
    // rust: instance.ambient = ambient.contains(id);
    // rust: g.add_player_effect(instance);
}
}
    // rust: }),
    // rust: Victim::Mob(mob) => {
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == mob) else {
    // rust: return;
}
                // Undead invert healing and harming.
    // rust: let tags = &world_stations!(self).enchantments.entity_tags;
    // rust: let inverted = tags
    // rust: .get("minecraft:inverted_healing_and_harm")
    // rust: .is_some_and(|t| t.contains(&self.mobs[i].kind.id));
    // rust: for (id, duration, amp) in effects {
    // rust: let tags = &world_stations!(self).enchantments.entity_tags;
                    // A mod's `onEffectAdded` may have changed the mobs.
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) else {
    // rust: return;
}
    // rust: match *id {
    // rust: "instant_damage" | "instant_health" => {
    // rust: let amount = |base: i32| {
    // rust: (0.5 * f64::from(base.wrapping_shl(*amp as u32)) + 0.5) as i32
    // rust: as f32
}
    // rust: if (*id == "instant_damage") != inverted {
                                // HealOrHarmMobEffect.applyInstantaneousEffect: indirectMagic(cloud, owner).
    // rust: let source = Damage::indirect_magic(owner, at);
    // rust: if m.damage_by(amount(6), source, "minecraft:area_effect_cloud")
    // rust: && owner == Some(Who::Player)
    // rust: {
    // rust: self.last_hurt_by_player.insert(mob, guest);
}
    // rust: } else {
    // rust: m.heal(amount(4));
}
}
    // rust: _ => {
                            // `LivingEntity.addEffect` refuses what the mob
                            // cannot be affected by.
    // rust: if mob_can_be_affected(tags, &m.kind.id, id)
    // rust: && let Some(name) = mob_effect_id(id)
    // rust: {
    // rust: let new = !m.has_effect(name);
    // rust: m.add_effect_with(
    // rust: name,
    // rust: scaled(*duration),
    // rust: *amp,
    // rust: ambient.contains(id),
    // rust: !hidden.contains(id),
    // rust: );
    // rust: self.mod_effect_added(name, Some(mob as i32), *amp, new);
}
}
}
}
}
}
}
    /// `ThrowableProjectile.tick`'s `applyGravity` and `applyInertia`, which
    /// come before the move: gravity 0.05 (0.07 for an experience bottle),
    /// then drag 0.99 (0.8 in water).
pub fn thrown_potion_motion(self: *Self, t: *mut ThrownPotion) void {
}
    // rust: let gravity = if &*t.stack.item == "minecraft:experience_bottle" {
    // rust: 0.07
    // rust: } else {
    // rust: 0.05
}
    // rust: let at = t.position;
    // rust: let water = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: ))
    // rust: .fluid
    // rust: == horizon_client::blocks::Fluid::Water;
    // rust: let inertia = if water { 0.8 } else { 0.99 };
    // rust: t.velocity = Vec3::new(
    // rust: t.velocity.x * inertia,
    // rust: (t.velocity.y - gravity) * inertia,
    // rust: t.velocity.z * inertia,
    // rust: );
}
    /// `ThrowableProjectile.tick` on a server's client: it falls and moves
    /// by itself between the server's updates and stops at a block; only
    /// the server breaks it.
    // rust: pub(super) fn step_remote_thrown(&mut self) {
    // rust: let mut thrown = std::mem::take(&mut self.potions.thrown);
    // rust: for t in &mut thrown {
    // rust: t.previous = t.position;
    // rust: t.age += 1;
    // rust: self.thrown_potion_motion(t);
    // rust: let next = Vec3::new(
    // rust: t.position.x + t.velocity.x,
    // rust: t.position.y + t.velocity.y,
    // rust: t.position.z + t.velocity.z,
    // rust: );
    // rust: let state = self.world.block(
    // rust: next.x.floor() as i32,
    // rust: next.y.floor() as i32,
    // rust: next.z.floor() as i32,
    // rust: );
    // rust: if self.res.facts().get(state).full_collision {
    // rust: t.velocity = Vec3::ZERO;
    // rust: } else {
    // rust: t.position = next;
}
}
    // rust: self.potions.thrown = thrown;
}
    /// `ThrownItemRenderer` for thrown splash and lingering potions and
    /// experience bottles: the item (GROUND) facing the camera at scale 1,
    /// lit at the light probe (the eye, 0.85 of the 0.25 height).
    // rust: pub(super) fn thrown_potion_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let orientation = glam::Mat4::from_quat(self.camera_orientation());
    // rust: for t in &self.potions.thrown {
    // rust: let previous = glam::DVec3::new(t.previous.x, t.previous.y, t.previous.z);
    // rust: let position = glam::DVec3::new(t.position.x, t.position.y, t.position.z);
            // ThrowableProjectile.shouldRenderAtSqrDistance: hidden for its
            // first two ticks within 3.5 blocks (not in the thrower's face).
    // rust: if t.age < 2 && position.distance_squared(camera) < 12.25 {
    // rust: continue;
}
    // rust: if !self.standing_entity_in_view(
    // rust: camera,
    // rust: super::entity_culling::at(t.previous),
    // rust: super::entity_culling::at(t.position),
    // rust: alpha,
    // rust: 0.25,
    // rust: 0.25,
    // rust: 64.0,
    // rust: 0.0,
    // rust: ) {
    // rust: continue;
}
    // rust: let p = previous.lerp(position, alpha);
    // rust: let owner = owner_at(p.to_array(), 0.0, &t.stack.item);
    // rust: let state = self.resolve_item(&t.stack, DisplayContext::Ground, Some(&owner), 0);
    // rust: if state.is_empty() {
    // rust: continue;
}
    // rust: let pose = glam::Mat4::from_translation((p - camera).as_vec3()) * orientation;
    // rust: let light = self.world.light(
    // rust: p.x.floor() as i32,
    // rust: (p.y + 0.2125).floor() as i32,
    // rust: p.z.floor() as i32,
    // rust: );
    // rust: self.submit_item_world(&state, pose, vertex_light(light), out);
}
}
    /// `HealOrHarmMobEffect.applyInstantaneousEffect` with a source (a
    /// potion or a cloud): indirectMagic, not plain magic, credited to the
    /// mob that threw it when there is one.
pub fn apply_indirect_effect_action(self: *Self, a: EffectAction, owner: *PotionOwner) void {
}
    // rust: let a = match a {
    // rust: EffectAction::Hurt("minecraft:magic", amount) => {
    // rust: match (owner.attacker, &owner.name) {
    // rust: (Some(id), Some(name)) => {
    // rust: self.note_named_attacker("minecraft:indirect_magic", id, name.clone())
}
    // rust: _ => {
    // rust: let name = owner.name.clone().unwrap_or_else(|| {
    // rust: Text::translate("entity.minecraft.splash_potion", &[])
    // rust: });
    // rust: self.note_direct_entity("minecraft:indirect_magic", name);
}
}
    // rust: EffectAction::Hurt("minecraft:indirect_magic", amount)
}
    // rust: a => a,
}
    // rust: self.apply_effect_action(a);
}
    /// A splash potion's effects on the player in place, by their distance.
    // rust: fn splash_on_player(
    // rust: &mut self,
    // rust: effects: &'static [(&'static str, i32, i32)],
    // rust: at: Vec3,
    // rust: age: u32,
    // rust: owner: &PotionOwner,
    // rust: ) {
    // rust: if let Some(p) = self.player.as_ref() {
    // rust: let w = f64::from(p.dimensions.width) / 2.0;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(p.position.x - w, p.position.y, p.position.z - w),
    // rust: Vec3::new(
    // rust: p.position.x + w,
    // rust: p.position.y + f64::from(p.dimensions.height),
    // rust: p.position.z + w,
    // rust: ),
    // rust: );
    // rust: if let Some(d2) = splash_distance_sqr(at, age, bounds) {
    // rust: let intensity = 1.0 - d2.sqrt() / 4.0;
    // rust: for (id, duration, amp) in effects {
    // rust: let instant = brewing::effect(id).is_some_and(|e| e.instant);
    // rust: if instant {
    // rust: if let Some(a) = horizon_client::effects::instant(id, *amp, intensity) {
    // rust: self.apply_indirect_effect_action(a, owner);
}
    // rust: } else {
    // rust: let d = (intensity * f64::from(*duration) + 0.5) as i32;
    // rust: if d > 20
    // rust: && let Some(e) = brewing::effect(id)
    // rust: {
    // rust: self.add_player_effect(EffectInstance::new(e.id, d, *amp));
}
}
}
}
}
}
    /// `Projectile.getOwner` of a thrown potion, as [`splash`](Self::splash)
    /// names it: a player's, a mob's (a witch keeps the kill credit), or
    /// nobody's (a dispenser's, a summoned potion's).
    // rust: pub(super) fn potion_owner(&self, owner: Option<Who>) -> PotionOwner {
    // rust: match owner {
    // rust: Some(Who::Player) => PotionOwner {
    // rust: name: Some(self.player_display_text()),
    // rust: attacker: None,
    // rust: player: true,
    // rust: guest: self.lan_acting,
    // rust: },
    // rust: Some(Who::Mob(id)) => PotionOwner {
    // rust: name: self.mob_display_name(id),
    // rust: attacker: Some(id),
    // rust: player: false,
    // rust: guest: None,
    // rust: },
    // rust: None => PotionOwner::default(),
}
}
    /// `AbstractThrownPotion.onHit` with `ThrownSplashPotion.onHitAsPotion`, or
    /// `ThrownLingeringPotion.onHitAsPotion` for a lingering potion, read from
    /// the stack's `potion_contents`; `mob` is where it hit a mob, `hit` the
    /// block and face it hit, `age` its age.
    // rust: pub(super) fn splash(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: at: Vec3,
    // rust: mob: Option<Vec3>,
    // rust: hit: Option<([i32; 3], Direction)>,
    // rust: age: u32,
    // rust: owner: &PotionOwner,
    // rust: ) {
    // rust: let block = [at.x, at.y, at.z].map(|v| v.floor() as i32);
    // rust: if &*stack.item == "minecraft:experience_bottle" {
            // ThrownExperienceBottle.onHit: the water-coloured splash (level
            // event 2002, its sound 1053) and 3 to 11 experience.
    // rust: self.level_event_at(2002, block, 0xFF38_5DC6u32 as i32);
    // rust: self.level_event_at(1053, block, 0);
    // rust: let r = &mut self.world.random;
    // rust: let value = 3 + r.next_int_bound(5).unwrap_or(0) + r.next_int_bound(5).unwrap_or(0);
    // rust: self.spawn_orbs([at.x, at.y, at.z], value as u32);
    // rust: self.native_exp_bottle([at.x, at.y, at.z], value as u32);
    // rust: return;
}
        // Projectile.onHit calls onHitBlock first, then the potion's
        // affectEntitiesAround; both read the stack's `potion_contents`.
    // rust: if let Some((cell, face)) = hit {
    // rust: self.potion_hit_block(stack, cell, face);
}
    // rust: self.affect_entities_around(stack, at, owner.player);
    // rust: let lingering = &*stack.item == "minecraft:lingering_potion";
        // AbstractThrownPotion.onHit: level event 2007 and sound 1054 for a
        // potion with instant effects, 2002 and 1053 otherwise.
    // rust: let potion = stack.potion().and_then(brewing::potion);
    // rust: let instant = potion.is_some_and(|d| {
    // rust: d.effects
    // rust: .iter()
    // rust: .any(|(id, ..)| brewing::effect(id).is_some_and(|e| e.instant))
    // rust: });
    // rust: let color = brewing::potion_color(stack.potion());
    // rust: self.level_event_at(if instant { 2007 } else { 2002 }, block, color as i32);
    // rust: self.level_event_at(if instant { 1054 } else { 1053 }, block, 0);
        // AbstractThrownPotion.affectEntitiesAround: a water potion (the only
        // #rehydrates_axolotls) refills the air of the axolotls in the
        // projectile's box inflated by 4, 2 and 4 (Axolotl.rehydrate, 1800).
    // rust: if stack.potion() == Some("minecraft:water") {
    // rust: let (lo, hi) = (
    // rust: [at.x - 0.125 - 4.0, at.y - 2.0, at.z - 0.125 - 4.0],
    // rust: [at.x + 0.125 + 4.0, at.y + 0.25 + 2.0, at.z + 0.125 + 4.0],
    // rust: );
    // rust: for m in self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .filter(|m| m.species() == horizon_client::mobs::Species::Axolotl && !m.removed)
    // rust: {
    // rust: let (w, h, _) = m.dims();
    // rust: let half = w / 2.0;
    // rust: let (x, y, z) = (m.position.x, m.position.y, m.position.z);
    // rust: if x - half < hi[0]
    // rust: && x + half > lo[0]
    // rust: && y < hi[1]
    // rust: && y + h > lo[1]
    // rust: && z - half < hi[2]
    // rust: && z + half > lo[2]
    // rust: {
    // rust: m.air = (m.air + 1800).min(horizon_client::mobs::axolotl::MAX_AIR);
}
}
}
    // rust: let Some(def) = potion else {
    // rust: return;
}
    // rust: if lingering {
            // The cloud sits at the mob it hit (its feet), else the impact;
            // radius 3, wait 10, 600 ticks, shrinking to nothing, and a
            // potion with no effects leaves none.
    // rust: if !def.effects.is_empty() {
    // rust: let at = mob.unwrap_or(at);
    // rust: let id = self.take_entity_id();
    // rust: self.breath_clouds.push(Breath {
    // rust: id,
    // rust: at: [at.x, at.y, at.z],
    // rust: radius: 3.0,
    // rust: age: 0,
    // rust: duration: 600,
    // rust: from_dragon: false,
    // rust: victims: Vec::new(),
    // rust: potion: Some(PotionCloud {
    // rust: settings: CloudSettings::lingering(),
    // rust: effects: def.effects.to_vec(),
    // rust: hidden: Vec::new(),
    // rust: ambient: Vec::new(),
    // rust: radius_per_tick: -3.0 / 600.0,
    // rust: color,
    // rust: victims: Vec::new(),
    // rust: source: owner.name.clone().unwrap_or_else(|| {
    // rust: Text::translate("entity.minecraft.area_effect_cloud", &[])
    // rust: }),
    // rust: owner: owner.who(),
    // rust: guest: owner.guest,
    // rust: }),
    // rust: });
}
    // rust: return;
}
        // Every player in range (`ThrownSplashPotion.applySplash` over
        // `LivingEntity`s, the players among them).
    // rust: self.for_each_player(|g| g.splash_on_player(def.effects, at, age, owner));
        // Mobs take the instant effects (undead invert healing and harming).
    // rust: let undead = &self.stations().enchantments.entity_tags;
    // rust: let mut hits = Vec::new();
    // rust: for (i, m) in self.mobs.iter().enumerate() {
    // rust: if m.alive()
    // rust: && let Some(d2) = splash_distance_sqr(at, age, m.bounds())
    // rust: {
    // rust: let inverted = undead
    // rust: .get("minecraft:inverted_healing_and_harm")
    // rust: .is_some_and(|t| t.contains(&m.kind.id));
    // rust: hits.push((i, 1.0 - d2.sqrt() / 4.0, inverted));
}
}
    // rust: for (i, intensity, inverted) in hits {
    // rust: for (id, duration, amp) in def.effects {
    // rust: let harm = match *id {
    // rust: "instant_damage" => !inverted,
    // rust: "instant_health" => inverted,
    // rust: _ => {
                        // `Potion.applySplash`: timed effects last in
                        // proportion to how close the mob was.
    // rust: let d = (intensity * f64::from(*duration) + 0.5) as i32;
    // rust: if d > 20
    // rust: && let Some(name) = mob_effect_id(id)
    // rust: {
    // rust: self.mobs[i].add_effect(name, d, *amp);
}
    // rust: continue;
}
}
    // rust: let m = &mut self.mobs[i];
    // rust: if harm {
                    // HealOrHarmMobEffect.applyInstantaneousEffect: indirectMagic(potion, owner).
    // rust: let harm = (intensity * f64::from(6 << amp) + 0.5) as i32 as f32;
    // rust: let source = Damage::indirect_magic(owner.who(), [at.x, at.y, at.z]);
    // rust: if m.damage_by(harm, source, "minecraft:splash_potion") && owner.player {
    // rust: let id = m.id;
    // rust: self.last_hurt_by_player.insert(id, owner.guest);
}
    // rust: } else {
    // rust: m.heal((intensity * f64::from(4 << amp) + 0.5) as i32 as f32);
}
}
}
}
    /// `Screen.showsActiveEffects`: the survival and creative inventories
    /// draw their own effect list when `EffectsInInventory.canSeeEffects`
    /// (32 or more pixels right of the screen).
pub fn screen_shows_active_effects(self: *Self, batch: *HudBatch) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ox, image_width) = match self.screen {
    // rust: Screen::Inventory
    // rust: if self.container.is_none() && self.craft_size == 2 && !self.mount_active() =>
    // rust: {
    // rust: (self.inventory_origin(batch).0, 176)
}
    // rust: Screen::Creative => (
    // rust: Self::creative_origin(batch).0,
    // rust: horizon_client::creative::Creative::WIDTH as i32,
    // rust: ),
    // rust: _ => return false,
}
    // rust: batch.width as i32 - (ox as i32 + image_width + 2) >= 32
}
    /// `Hud.extractEffects`: icons top-right, beneficial row then harmful row;
    /// every screen but the inventories keeps them.
    // rust: pub(super) fn draw_effect_icons(&self, batch: &mut HudBatch) {
    // rust: if self.potions.effects.list.is_empty() || self.screen_shows_active_effects(batch) {
    // rust: return;
}
    // rust: let icons: Vec<hud_overlays::EffectIcon> = self
    // rust: .potions
    // rust: .effects
    // rust: .list
    // rust: .iter()
    // rust: .map(hud_overlays::EffectIcon::from)
    // rust: .collect();
    // rust: let draws = hud_overlays::effects(batch.width as i32, false, &icons);
    // rust: hud_layout::paint(batch, &self.gui.atlas, &draws);
}
    /// `EffectsInInventory`: panels to the right of survival/creative inventory.
    /// The caller draws the returned tooltip after every other tooltip.
    // rust: pub(super) fn draw_inventory_effects(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: origin: (f32, f32),
    // rust: image_width: i32,
    // rust: ) -> Option<[(String, u32); 2]> {
    // rust: let panels = inventory_effects::panels(
    // rust: batch.width as i32,
    // rust: [origin.0 as i32, origin.1 as i32],
    // rust: image_width,
    // rust: &self.potions.effects.list,
    // rust: self.clock.rate(),
    // rust: &|key| self.pack.names.display_get(key),
    // rust: &|text| self.gui.atlas.font.width(text).ceil() as i32,
    // rust: );
    // rust: inventory_effects::paint(
    // rust: batch,
    // rust: &self.gui.atlas,
    // rust: &panels,
    // rust: [self.cursor.0 as i32, self.cursor.1 as i32],
    // rust: )
}
    /// Effects saved in level.dat (`Player.active_effects`).
    // rust: pub(super) fn restore_effects(&mut self) {
    // rust: self.potions = PotionState::default();
    // rust: self.potions.effects = PlayerEffects::from_saved(&self.level.active_effects);
}
    // rust: pub(super) fn effects_json(&self) -> serde_json::Value {
    // rust: serde_json::json!({
    // rust: "active": self.potions.effects.list.iter().map(|e| serde_json::json!({ "id": e.id, "duration": e.duration, "amplifier": e.amplifier })).collect::<Vec<_>>(),
    // rust: "thrown": self.potions.thrown.iter().map(|t| [t.position.x, t.position.y, t.position.z]).collect::<Vec<_>>(),
    // rust: })
}
}

/// A mob's content mod effects tick in its own tick (`ai::tick_effects`).
    // rust: impl horizon_client::mobs::ModEffectTicks for Game<'_> {
pub fn tick_mod_effect(self: *Self, effect: []const u8, mob: u32, tick_count: i32, amplifier: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mod_effect_tick(effect, Some(mob as i32), tick_count, amplifier)
}
}

/// `LivingEntity.tickEffects` on a client: each `MobEffectInstance.tickClient`
/// counts its effect down, then ticks its `BlendState`. The darkness effect's
/// is the fade `darkness_lighting` and `darkness_fog` draw; the integrated
/// level's `tick_sculk_entities` is not run for a server's client (#3393).
pub fn client_tick_effects(effects: *mut PlayerEffects, darkness: *mut (f32) void {
}
    // rust: for e in &mut effects.list {
    // rust: e.tick_client();
}
    // rust: *darkness = super::sculk::darkness_blend_tick(effects, *darkness);
}

    // rust: mod tests {
//     use super::super::sculk::darkness_blend_added;
//     use super::*;
//     use horizon_client::screen_effects::nausea_blend_added;

    /// `WitherBoss.canBeAffected` refuses only the wither effect: its `addEffect`
    /// refuses the rest, but a cloud of strength or healing still counts the boss
    /// as a victim (`AreaEffectCloud.serverTick` asks `canBeAffected`).
pub fn a_cloud_still_counts_the_wither_as_a_victim() void {
}
    // rust: let tags = std::collections::HashMap::new();
    // rust: for effect in ["strength", "instant_health"] {
    // rust: assert!(
    // rust: mob_can_be_affected(&tags, "minecraft:wither", effect),
    // rust: "{effect}"
    // rust: );
}
    // rust: assert!(!mob_can_be_affected(&tags, "minecraft:wither", "wither"));
}

    /// #5876: a potion thrown straight up from inside its thrower's box does
    /// not hit them while it climbs out, then hits them on the way down;
    /// another player in its path is hit at once.
pub fn a_thrown_potion_hits_its_thrower_only_after_leaving_them() void {
}
        // A player's box: 0.6 wide, 1.8 high, feet at the origin.
    // rust: let body = |x: f64| Aabb::new(Vec3::new(x - 0.3, 0.0, -0.3), Vec3::new(x + 0.3, 1.8, 0.3));
    // rust: let thrower = Who::Mob(1);
    // rust: let players = [(thrower, body(0.0)), (Who::Mob(2), body(5.0))];
    // rust: let ridden = [body(0.0)];
    // rust: let eye = Vec3::new(0.0, 1.52, 0.0);
    // rust: let up = Vec3::new(0.0, 0.5, 0.0);
    // rust: let m = thrown_margin(10);
    // rust: assert!((m - 0.3).abs() < 1e-12 && thrown_margin(1) == 0.0);
        // Thrown from the eye: still within a block of its thrower.
    // rust: assert!(!thrown_left_owner(&ridden, eye, up));
    // rust: assert!(thrown_player_at(&players, &[thrower], eye, m).is_none());
        // Without the gate the thrower's box does hold it.
    // rust: assert_eq!(
    // rust: thrown_player_at(&players, &[], eye, m).map(|t| t.0),
    // rust: Some(thrower)
    // rust: );
        // Four blocks up and rising: clear of the box grown by a block.
    // rust: let high = Vec3::new(0.0, 5.0, 0.0);
    // rust: assert!(thrown_left_owner(&ridden, high, up));
        // Falling back (left_owner now set), the thrower is hit at their head.
    // rust: let head = Vec3::new(0.0, 2.0, 0.0);
    // rust: assert_eq!(
    // rust: thrown_player_at(&players, &[], head, m).map(|t| t.0),
    // rust: Some(thrower)
    // rust: );
        // Another player is hit though the thrower has not left; a miss is none.
    // rust: let beside = Vec3::new(5.2, 1.0, 0.0);
    // rust: assert_eq!(
    // rust: thrown_player_at(&players, &[thrower], beside, m).map(|t| t.0),
    // rust: Some(Who::Mob(2))
    // rust: );
    // rust: assert!(thrown_player_at(&players, &[thrower], Vec3::new(2.5, 1.0, 0.0), m).is_none());
        // A passenger sharing the thrower's vehicle is skipped like the thrower.
    // rust: assert!(thrown_player_at(&players, &[thrower, Who::Mob(2)], beside, m).is_none());
        // The vehicle's box keeps it from leaving: a mount 2 blocks wide.
    // rust: let mount = Aabb::new(Vec3::new(-1.0, -1.0, -1.0), Vec3::new(1.0, 1.0, 1.0));
    // rust: let beside_mount = Vec3::new(1.9, 0.0, 0.0);
    // rust: assert!(thrown_left_owner(&[body(0.0)], beside_mount, up));
    // rust: assert!(!thrown_left_owner(&[body(0.0), mount], beside_mount, up));
        // No thrower (a dispenser's potion): it has left them already.
    // rust: assert!(thrown_left_owner(&[], eye, up));
}

    /// A server's client (multiplayer and the default single player) fades
    /// the darkness effect in over its 22 blend ticks, holds it, and fades
    /// it out over the last 22 (#3393).
pub fn a_servers_client_blends_the_darkness_effect() void {
}
    // rust: let mut effects = PlayerEffects::default();
    // rust: effects.add(EffectInstance::new("darkness", 60, 0));
    // rust: let mut darkness = (0.0, 0.0);
    // rust: client_tick_effects(&mut effects, &mut darkness);
    // rust: assert_eq!(darkness, (0.0, 1.0 / 22.0), "the first tick fades in");
    // rust: for _ in 1..22 {
    // rust: client_tick_effects(&mut effects, &mut darkness);
}
    // rust: assert!((darkness.1 - 1.0).abs() < 1e-5, "{darkness:?}");
        // 38 ticks left: full until 22 remain, then the fade out.
    // rust: for _ in 0..16 {
    // rust: client_tick_effects(&mut effects, &mut darkness);
}
    // rust: assert_eq!(effects.get("darkness").map(|e| e.duration), Some(22));
    // rust: assert!(
    // rust: darkness.1 < darkness.0,
    // rust: "fading out at 22 left: {darkness:?}"
    // rust: );
    // rust: for _ in 0..21 {
    // rust: client_tick_effects(&mut effects, &mut darkness);
}
    // rust: assert!(darkness.1.abs() < 1e-5, "{darkness:?}");
}

    /// `ClientPacketListener.handleUpdateMobEffect`: a new darkness fades in
    /// when the server blends it; one sent unblended (joining, changing
    /// dimension) is at full strength at once.
pub fn a_new_darkness_starts_blended_or_at_once() void {
}
    // rust: let e = EffectInstance::new("darkness", 260, 0);
    // rust: assert_eq!(darkness_blend_added(&e, true), (0.0, 0.0));
    // rust: assert_eq!(darkness_blend_added(&e, false), (1.0, 1.0));
    // rust: let ending = EffectInstance::new("darkness", 10, 0);
    // rust: assert_eq!(darkness_blend_added(&ending, false), (0.0, 0.0));
    // rust: let infinite = EffectInstance::new("darkness", -1, 0);
    // rust: assert_eq!(darkness_blend_added(&infinite, false), (1.0, 1.0));
}

    /// `ClientPacketListener.handleUpdateMobEffect`: a new nausea fades in
    /// when the server blends it; one sent unblended (joining, changing
    /// dimension) is at full strength at once, unless it is already within
    /// its blend-out ticks.
pub fn a_new_nausea_starts_blended_or_at_once() void {
}
    // rust: let e = EffectInstance::new("nausea", 600, 0);
    // rust: assert_eq!(nausea_blend_added(&e, true), (0.0, 0.0));
    // rust: assert_eq!(nausea_blend_added(&e, false), (1.0, 1.0));
    // rust: let ending = EffectInstance::new("nausea", 40, 0);
    // rust: assert_eq!(nausea_blend_added(&ending, false), (0.0, 0.0));
    // rust: let infinite = EffectInstance::new("nausea", -1, 0);
    // rust: assert_eq!(nausea_blend_added(&infinite, false), (1.0, 1.0));
}

    /// `BottleItem.use`: collecting dragon's breath from an ender dragon's cloud (#8054).
pub fn glass_bottle_collects_dragon_breath_from_dragon_cloud() void {
}
    // rust: let player_box = Aabb::new(Vec3::new(-0.3, 64.0, -0.3), Vec3::new(0.3, 65.8, 0.3));
    // rust: let mut clouds = vec![super::super::dragon::Breath {
    // rust: id: 1,
    // rust: at: [1.0, 64.0, 0.0],
    // rust: radius: 5.0,
    // rust: age: 0,
    // rust: duration: 200,
    // rust: from_dragon: true,
    // rust: victims: Vec::new(),
    // rust: potion: None,
    // rust: }];
    // rust: assert!(collect_dragon_breath(player_box, &mut clouds));
    // rust: assert_eq!(clouds[0].radius, 4.5);
    // rust: assert!(collect_dragon_breath(player_box, &mut clouds));
    // rust: assert_eq!(clouds[0].radius, 4.0);
}

    /// `BottleItem.use`: clouds that are expired, non-dragon, lingering potions,
    /// or out of reach cannot be bottled (#8054).
pub fn glass_bottle_ignores_non_dragon_or_expired_or_out_of_range_clouds() void {
}
    // rust: let player_box = Aabb::new(Vec3::new(-0.3, 64.0, -0.3), Vec3::new(0.3, 65.8, 0.3));
        // Non-dragon cloud (`from_dragon: false`).
    // rust: let mut non_dragon = vec![super::super::dragon::Breath {
    // rust: id: 1,
    // rust: at: [0.0, 64.0, 0.0],
    // rust: radius: 3.0,
    // rust: age: 0,
    // rust: duration: 600,
    // rust: from_dragon: false,
    // rust: victims: Vec::new(),
    // rust: potion: None,
    // rust: }];
    // rust: assert!(!collect_dragon_breath(player_box, &mut non_dragon));
    // rust: assert_eq!(non_dragon[0].radius, 3.0);

        // Lingering potion cloud (`potion: Some(...)`).
    // rust: let mut lingering = vec![super::super::dragon::Breath {
    // rust: id: 2,
    // rust: at: [0.0, 64.0, 0.0],
    // rust: radius: 3.0,
    // rust: age: 0,
    // rust: duration: 600,
    // rust: from_dragon: true,
    // rust: victims: Vec::new(),
    // rust: potion: Some(PotionCloud {
    // rust: settings: CloudSettings::lingering(),
    // rust: effects: Vec::new(),
    // rust: hidden: Vec::new(),
    // rust: ambient: Vec::new(),
    // rust: radius_per_tick: -3.0 / 600.0,
    // rust: color: 0,
    // rust: victims: Vec::new(),
    // rust: source: Text::empty(),
    // rust: owner: None,
    // rust: guest: None,
    // rust: }),
    // rust: }];
    // rust: assert!(!collect_dragon_breath(player_box, &mut lingering));
    // rust: assert_eq!(lingering[0].radius, 3.0);

        // Its last tick before the wait-shifted end still holds breath
        // (`tickCount - waitTime < duration`).
    // rust: let mut last = vec![super::super::dragon::Breath {
    // rust: id: 3,
    // rust: at: [0.0, 64.0, 0.0],
    // rust: radius: 5.0,
    // rust: age: 219,
    // rust: duration: 200,
    // rust: from_dragon: true,
    // rust: victims: Vec::new(),
    // rust: potion: None,
    // rust: }];
    // rust: assert!(collect_dragon_breath(player_box, &mut last));
    // rust: assert_eq!(last[0].radius, 4.5);

        // Expired cloud (`tickCount - waitTime >= duration`).
    // rust: let mut expired = vec![super::super::dragon::Breath {
    // rust: id: 3,
    // rust: at: [0.0, 64.0, 0.0],
    // rust: radius: 5.0,
    // rust: age: 220,
    // rust: duration: 200,
    // rust: from_dragon: true,
    // rust: victims: Vec::new(),
    // rust: potion: None,
    // rust: }];
    // rust: assert!(!collect_dragon_breath(player_box, &mut expired));
    // rust: assert_eq!(expired[0].radius, 5.0);

        // Out of horizontal reach: cloud at 10 blocks away with radius 1:
        // cloud X range [9.0, 11.0], player inflated X range [-2.3, 2.3] -> no overlap.
    // rust: let mut far = vec![super::super::dragon::Breath {
    // rust: id: 4,
    // rust: at: [10.0, 64.0, 0.0],
    // rust: radius: 1.0,
    // rust: age: 0,
    // rust: duration: 200,
    // rust: from_dragon: true,
    // rust: victims: Vec::new(),
    // rust: potion: None,
    // rust: }];
    // rust: assert!(!collect_dragon_breath(player_box, &mut far));
    // rust: assert_eq!(far[0].radius, 1.0);

        // Out of vertical reach: cloud at Y=64.0 (Y bounds [64.0, 64.5]),
        // player at Y=67.0 (inflated Y bounds [65.0, 70.8] does not reach 64.5).
    // rust: let high_player = Aabb::new(Vec3::new(-0.3, 67.0, -0.3), Vec3::new(0.3, 68.8, 0.3));
    // rust: let mut ground_cloud = vec![super::super::dragon::Breath {
    // rust: id: 5,
    // rust: at: [0.0, 64.0, 0.0],
    // rust: radius: 1.0,
    // rust: age: 0,
    // rust: duration: 200,
    // rust: from_dragon: true,
    // rust: victims: Vec::new(),
    // rust: potion: None,
    // rust: }];
    // rust: assert!(!collect_dragon_breath(high_player, &mut ground_cloud));
    // rust: assert_eq!(ground_cloud[0].radius, 1.0);
}
}
