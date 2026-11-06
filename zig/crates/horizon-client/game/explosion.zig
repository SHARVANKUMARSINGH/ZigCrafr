//! Transpiled from Horizon Rust crate
//! Module: horizon-client_explosion
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `ServerExplosion`: exploded positions (vanilla ray march over a Java
//! HashSet, so iteration and the following shuffle match vanilla's random
//! draws), entity damage with exposure and knockback, block interaction with
//! merged drops and TNT chain priming, and optional fire.
// use super::{
    // rust: Game,
    // rust: entity::{Blast, Entity, EntityHandle, with_entity, with_entity_mut},
}
// use horizon_client::{
    // rust: Result, blocks::Fluid, collisions::SceneCollisions, items::ItemStack, mobs::Who, text::Text,
}
// use horizon_core::{
    // rust: geometry::{Vec3, VoxelShape},
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::{
    // rust: collision_context::{CollisionContext, CollisionEntity, CollisionItem},
    // rust: entity_obstruction::EntityIdentity,
    // rust: java_hash_map::{JavaHashMap, JavaKey},
    // rust: registry::BlockStateId,
    // rust: world_ray::{RayBlockMode, RayFluidMode, RayWorld, clip_world},
}
// use std::{cmp::Ordering, io};

/// `Level.clip` with `ClipContext.Block.COLLIDER`, no fluids and the
/// collision context of the entity whose exposure is measured.
pub const ColliderRays = struct {
    scene: SceneCollisions<'a,
    context: CollisionContext<'static>,
};
    // rust: impl RayWorld for ColliderRays<'_, '_> {
    // rust: type Error = io::Error;
    // rust: type Block = BlockStateId;
    // rust: type Fluid = ();
pub fn block_state(self: *Self, p: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.world.block(p.x, p.y, p.z))
}
pub fn fluid_state(self: *Self, _: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
    // rust: fn block_shape(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: p: BlockPos,
    // rust: _: RayBlockMode,
    // rust: ) -> io::Result<VoxelShape> {
    // rust: let binding = self.scene.binding;
    // rust: binding
    // rust: .collision_shape_with_context(&mut self.scene, state, p, &self.context)
    // rust: .map_err(|e| io::Error::other(format!("{e:?}")))
}
pub fn interaction_shape(self: *Self, _: BlockStateId, _: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(VoxelShape::empty())
}
pub fn fluid_is_source(self: *Self, _: () void {
}
    // rust: Ok(false)
}
pub fn fluid_is_empty(self: *Self, _: () void {
}
    // rust: Ok(true)
}
pub fn fluid_is_water(self: *Self, _: () void {
}
    // rust: Ok(false)
}
pub fn fluid_shape(self: *Self, _: () void {
}
    // rust: Ok(VoxelShape::empty())
}
}

/// `BlockPos` with Java `Vec3i.hashCode` / `compareTo`.
pub const Key = struct {};
    // rust: impl JavaKey for Key {
pub fn java_hash(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = self.0;
    // rust: y.wrapping_add(z.wrapping_mul(31))
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(x)
}
pub fn comparable_compare(self: *Self, other: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ([x, y, z], [ox, oy, oz]) = (self.0, other.0);
    // rust: Some(y.cmp(&oy).then(z.cmp(&oz)).then(x.cmp(&ox)))
}
pub fn tie_break(self: *Self, _other: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ordering::Less
}
}

/// `Explosion.BlockInteraction` for the explosions Horizon produces.
    // rust: pub(super) enum BlockInteraction {
    // rust: Keep,
    // rust: Destroy,
    // rust: DestroyWithDecay,
}

/// `ServerExplosion.hurtEntities`: an entity is hurt when its position is
/// within the blast's diameter of the centre.
    // rust: pub(super) fn blast_reaches(center: [f64; 3], diameter: f64, at: [f64; 3]) -> bool {
    // rust: let d =
    // rust: ((at[0] - center[0]).powi(2) + (at[1] - center[1]).powi(2) + (at[2] - center[2]).powi(2))
    // rust: .sqrt();
    // rust: d / diameter <= 1.0
}

/// `ItemEntity.ignoreExplosion` through
/// `ServerExplosion.shouldAffectBlocklikeEntities`: an explosion that does not
/// affect blocklike entities is ignored entirely by a dropped item. With
/// `mobGriefing` off that is every blast that keeps blocks; with it on, none
/// (no wind charge goes through `server_explode`).
pub fn items_ignore_explosion(mob_griefing: bool, interaction: BlockInteraction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !mob_griefing && interaction == BlockInteraction::Keep
}

/// Whether a blast leaves item frames, paintings, cushions and armour stands
/// alone. Without `mobGriefing`, a blast that keeps blocks is ignored
/// (`ServerExplosion.shouldAffectBlocklikeEntities` through their
/// `ignoreExplosion`; no wind charge goes through `server_explode`), and one a
/// mob causes does no harm (`BlockAttachedEntity.hurtServer` and
/// `ArmorStand.hurtServer`: `source.getEntity() instanceof Mob`).
    // rust: pub(super) fn blast_spares_decorations(
    // rust: mob_griefing: bool,
    // rust: interaction: BlockInteraction,
    // rust: by_mob: bool,
    // rust: source_in_water: bool,
    // rust: ) -> bool {
    // `BlockAttachedEntity.ignoreExplosion`: a source in water first.
    // rust: source_in_water || (!mob_griefing && (interaction == BlockInteraction::Keep || by_mob))
}

/// How far the blast's `center` is from `p`.
pub fn blast_distance(center: [f64; 3], p: [f64; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((p[0] - center[0]).powi(2) + (p[1] - center[1]).powi(2) + (p[2] - center[2]).powi(2)).sqrt()
}

/// The unit vector from `center` to `origin`, 0 when they coincide.
pub fn blast_direction(center: [f64; 3], origin: [f64; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = [
    // rust: origin[0] - center[0],
    // rust: origin[1] - center[1],
    // rust: origin[2] - center[2],
    // rust: ];
    // rust: let l = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: if l < 1.0e-4 {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: [d[0] / l, d[1] / l, d[2] / l]
}
}

/// The blast as `native_explosion_knockback` tells it: its centre and the
/// blocks it is about to break.
pub const ExplosionHookContext = struct {
    center: [f64,
    blocks: *'a [[i32,
};

/// An entity in the blast's reach: how far (as a share of the blast's
/// diameter), how much of it the rays see, and the knockback.
pub const Hit = struct {
    dist: f64,
    exposure: f32,
    push: Vec3,
};

/// Apply blast damage when the mob's team and wither immunity allow it.
    // rust: fn hurt_mob(
    // rust: m: &mut horizon_client::mobs::Mob,
    // rust: hurtable: bool,
    // rust: cause: Option<horizon_client::mobs::Species>,
    // rust: (amount, source): (f32, horizon_client::mobs::Damage),
    // rust: ) {
    // rust: let shielded =
    // rust: cause.is_some_and(|c| horizon_client::mobs::wither::shielded_from(m.species(), c));
    // rust: if hurtable && !shielded {
    // rust: m.damage(amount, source);
}
}

/// A blast's causing entity and its name (`Explosion.getIndirectSourceEntity`):
/// the mob that owns the exploding projectile while it is in the level
/// (`Projectile.getOwner` is null once it is removed), else the exploding
/// mob. `live` names a mob in the level, `exploded` the mobs whose blast
/// went off this tick and that already left it.
    // rust: fn blast_cause(
    // rust: owner: Option<u32>,
    // rust: exploding: Option<u32>,
    // rust: live: impl Fn(u32) -> Option<Text>,
    // rust: exploded: &[(u32, Text)],
    // rust: ) -> Option<(u32, Text)> {
    // rust: if let Some(owner) = owner {
    // rust: return live(owner).map(|name| (owner, name));
}
    // rust: let id = exploding?;
    // rust: let name = live(id).or_else(|| {
    // rust: exploded
    // rust: .iter()
    // rust: .rfind(|(m, _)| *m == id)
    // rust: .map(|(_, n)| n.clone())
    // rust: })?;
    // rust: Some((id, name))
}

    // rust: thread_local! {
    /// Client-side randomness (explosion sound pitch), separate from the level random.
pub const CLIENT_RANDOM: std::cell::RefCell<LegacyRandom> = std::cell::RefCell::new(LegacyRandom::new(0x5eed));
}
    // rust: pub(super) fn client_float() -> f32 {
    // rust: CLIENT_RANDOM.with(|r| r.borrow_mut().next_float())
}

    // rust: impl Game<'_> {
    /// `blast_cause` for the blast going off now.
    // rust: pub(super) fn blast_attacker(&self) -> Option<(u32, Text)> {
        // `Explosion.getIndirectSourceEntity`: a primed TNT's owner names the
        // blast before any mob does, which makes the damage type
        // `minecraft:player_explosion` (`server_explode` asks this).
    // rust: self.combat.blast_owner.clone().or_else(|| {
    // rust: blast_cause(
    // rust: self.combat.explosion_owner,
    // rust: self.combat.explosion_source,
    // rust: |id| self.mob_display_name(id),
    // rust: &self.combat.exploded,
    // rust: )
    // rust: })
}
    /// `ServerExplosion.getSeenPercent` for an entity box.
    // rust: pub(super) fn seen_percent(&self, center: [f64; 3], min: [f64; 3], max: [f64; 3]) -> f32 {
    // rust: let xs = 1.0 / ((max[0] - min[0]) * 2.0 + 1.0);
    // rust: let ys = 1.0 / ((max[1] - min[1]) * 2.0 + 1.0);
    // rust: let zs = 1.0 / ((max[2] - min[2]) * 2.0 + 1.0);
    // rust: let x_offset = (1.0 - (1.0 / xs).floor() * xs) / 2.0;
    // rust: let z_offset = (1.0 - (1.0 / zs).floor() * zs) / 2.0;
    // rust: if xs < 0.0 || ys < 0.0 || zs < 0.0 {
    // rust: return 0.0;
}
        // ClipContext(..., entity): the entity standing at the box's bottom.
    // rust: let mut rays = ColliderRays {
    // rust: scene: SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
    // rust: },
    // rust: context: CollisionContext::for_entity(
    // rust: CollisionEntity {
    // rust: identity: EntityIdentity(0),
    // rust: y: min[1],
    // rust: descending: false,
    // rust: main_hand: Some(CollisionItem::EMPTY),
    // rust: },
    // rust: false,
    // rust: ),
}
    // rust: let (mut hits, mut count) = (0, 0);
    // rust: let mut xx = 0.0;
    // rust: while xx <= 1.0 {
    // rust: let mut yy = 0.0;
    // rust: while yy <= 1.0 {
    // rust: let mut zz = 0.0;
    // rust: while zz <= 1.0 {
    // rust: let x = min[0] + (max[0] - min[0]) * xx;
    // rust: let y = min[1] + (max[1] - min[1]) * yy;
    // rust: let z = min[2] + (max[2] - min[2]) * zz;
    // rust: let from = Vec3::new(x + x_offset, y, z + z_offset);
    // rust: let to = Vec3::new(center[0], center[1], center[2]);
    // rust: let missed = clip_world(
    // rust: &mut rays,
    // rust: from,
    // rust: to,
    // rust: RayBlockMode::Collider,
    // rust: RayFluidMode::None,
    // rust: 4096,
    // rust: )
    // rust: .is_ok_and(|r| r.miss);
    // rust: if missed {
    // rust: hits += 1;
}
    // rust: count += 1;
    // rust: zz += zs;
}
    // rust: yy += ys;
}
    // rust: xx += xs;
}
    // rust: hits as f32 / count as f32
}
    /// `ServerExplosion.calculateExplodedPositions`; `resists` overrides one
    /// block's resistance (`ExplosionDamageCalculator.getBlockExplosionResistance`).
    // rust: fn exploded_positions(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: resists: Option<([i32; 3], f32)>,
    // rust: ) -> Vec<[i32; 3]> {
    // rust: let (min_y, max_y) = self.with_level(|_, level, _| {
//             use horizon_world::level::LevelAccess;
    // rust: (level.min_y(), level.max_y())
    // rust: });
        // WitherSkull.getBlockExplosionResistance: a dangerous skull's blast
        // caps a block the wither may destroy at 0.8.
    // rust: let cap = self.combat.blast_resistance_cap;
    // rust: let wither_immune = cap.and_then(|_| {
    // rust: self.res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:wither_immune")
    // rust: .cloned()
    // rust: });
    // rust: let mut set: JavaHashMap<Key, ()> = JavaHashMap::default();
    // rust: for xx in 0..16 {
    // rust: for yy in 0..16 {
    // rust: for zz in 0..16 {
    // rust: if !(xx == 0 || xx == 15 || yy == 0 || yy == 15 || zz == 0 || zz == 15) {
    // rust: continue;
}
    // rust: let mut xd = f64::from(xx as f32 / 15.0 * 2.0 - 1.0);
    // rust: let mut yd = f64::from(yy as f32 / 15.0 * 2.0 - 1.0);
    // rust: let mut zd = f64::from(zz as f32 / 15.0 * 2.0 - 1.0);
    // rust: let d = (xd * xd + yd * yd + zd * zd).sqrt();
    // rust: xd /= d;
    // rust: yd /= d;
    // rust: zd /= d;
    // rust: let mut power = radius * (0.7 + self.world.random.next_float() * 0.6);
    // rust: let (mut xp, mut yp, mut zp) = (center[0], center[1], center[2]);
    // rust: while power > 0.0 {
    // rust: let pos = [xp.floor() as i32, yp.floor() as i32, zp.floor() as i32];
    // rust: if pos[1] < min_y
    // rust: || pos[1] >= max_y
    // rust: || !(-30_000_000..30_000_000).contains(&pos[0])
    // rust: || !(-30_000_000..30_000_000).contains(&pos[2])
    // rust: {
    // rust: break;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let f = self.res.facts().get(state);
    // rust: let fluid = if f.fluid != Fluid::None {
    // rust: 100.0f32
    // rust: } else {
    // rust: 0.0
}
                        // A primed TNT minecart's rails and the blocks they
                        // stand on: no resistance, and never blown up.
    // rust: let spared = self.combat.rail_proof_blast
    // rust: && (self.rail(pos[0], pos[1], pos[2]).is_some()
    // rust: || self.rail(pos[0], pos[1] + 1, pos[2]).is_some());
    // rust: match resists {
    // rust: Some((at, resistance)) if at == pos => {
    // rust: power -= (resistance + 0.3) * 0.3;
}
    // rust: _ if !self.res.facts().is_air(state) || f.fluid != Fluid::None => {
    // rust: let base = if spared {
    // rust: 0.0
    // rust: } else {
    // rust: f.explosion_resistance.max(fluid)
}
    // rust: let immune =
    // rust: wither_immune.as_ref().is_some_and(|t| t.contains(&*f.name));
    // rust: power -= (blast_resistance(base, cap, immune) + 0.3) * 0.3;
}
    // rust: _ => {}
}
    // rust: if power > 0.0 && !spared {
    // rust: set.put(Key(pos), ());
}
    // rust: xp += xd * f64::from(0.3f32);
    // rust: yp += yd * f64::from(0.3f32);
    // rust: zp += zd * f64::from(0.3f32);
    // rust: power -= 0.225_000_01;
}
}
}
}
    // rust: set.entries().map(|(k, _)| k.0).collect()
}
    /// `ServerExplosion.hurtEntities` for the player: damage scaled by
    /// distance and exposure, through a raised shield (`hurtServer` blocks
    /// explosions like any attack from where the blast is), then the push
    /// (less with explosion knockback resistance; none for spectators or a
    /// creative player flying).
    ///
    /// Returns the push their client adds from the explosion packet
    /// (`hitPlayers`), unless a hurt marked their velocity: that goes to them
    /// whole, this push in it, once their server copy has travelled
    /// (Entity.markHurt, then ServerEntity.sendChanges), and replaces what the
    /// packet would add.
    ///
    /// `cause` is the blast's source as predicates see it, read before the
    /// guests' turns swap their own combat state in.
    // rust: fn explosion_hurt_player(
    // rust: &mut self,
    // rust: context: &ExplosionHookContext<'_>,
    // rust: radius: f32,
    // rust: damage_type: &str,
    // rust: exploding: Option<u32>,
    // rust: attacker: Option<&(u32, Text)>,
    // rust: cause: Option<&horizon_client::advancements::EntityView>,
    // rust: ) -> Option<[f64; 3]> {
    // rust: let ExplosionHookContext { center, blocks } = *context;
    // rust: let diameter = f64::from(radius * 2.0);
        // Blast protection: `EXPLOSION_KNOCKBACK_RESISTANCE` (0.15 per level and
        // piece, so two Blast Protection IV pieces cancel it).
    // rust: let resistance = self
    // rust: .player
    // rust: .as_mut()
    // rust: .and_then(|p| p.attribute("minecraft:explosion_knockback_resistance").ok())
    // rust: .unwrap_or(0.0);
    // rust: let p = self.player.as_ref()?;
    // rust: let feet = [p.position.x, p.position.y, p.position.z];
    // rust: let dist = ((feet[0] - center[0]).powi(2)
    // rust: + (feet[1] - center[1]).powi(2)
    // rust: + (feet[2] - center[2]).powi(2))
    // rust: .sqrt()
    // rust: / diameter;
    // rust: if dist > 1.0 || p.health.dead_or_dying() {
    // rust: return None;
}
        // ServerPlayer.onExplosionHit: the blast that hit the player is theirs.
    // rust: self.adv.marks.blast = Some((feet, cause.cloned()));
    // rust: let w = f64::from(p.dimensions.width) / 2.0;
    // rust: let h = f64::from(p.dimensions.height);
    // rust: let eye = [
    // rust: feet[0],
    // rust: feet[1] + f64::from(p.dimensions.eye_height),
    // rust: feet[2],
    // rust: ];
    // rust: let exposure = self.seen_percent(
    // rust: center,
    // rust: [feet[0] - w, feet[1], feet[2] - w],
    // rust: [feet[0] + w, feet[1] + h, feet[2] + w],
    // rust: );
    // rust: let pow = (1.0 - dist) * f64::from(exposure);
    // rust: let amount = ((pow * pow + pow) / 2.0 * 7.0 * diameter + 1.0) as f32;
    // rust: let d = [eye[0] - center[0], eye[1] - center[1], eye[2] - center[2]];
    // rust: let l = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: let dir = if l < 1.0e-4 {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: [d[0] / l, d[1] / l, d[2] / l]
}
    // rust: let power = pow * (1.0 - resistance);
        // `source.doTeamsAllowDamage(entity)`.
    // rust: let hurtable = exploding.is_none_or(|id| {
    // rust: horizon_client::scoreboard::teams_allow_damage(self.mob_team(id), self.player_team())
    // rust: });
    // rust: let blocking = self.player_blocking(Some(center), damage_type, false);
    // rust: let raised = blocking.is_some();
    // rust: let (creative, spectator) = (self.creative, self.spectator());
    // rust: let flying = self.player.as_ref().is_some_and(|p| p.flying);
    // rust: let mut outcome = horizon_client::health::BlockOutcome::default();
    // rust: let mut pushed = None;
        // The death message names the blast's causing entity. It goes to this
        // player's tracker, the host's or a guest's.
    // rust: if let Some((id, name)) = attacker.filter(|_| !creative && !spectator && hurtable) {
    // rust: self.note_named_attacker(damage_type, *id, name.clone());
}
    // rust: if let Some(p) = self.player.as_mut()
    // rust: && let Some(id) = self.health_resources.damage.id(damage_type)
    // rust: {
            // Creative players are invulnerable to explosions.
    // rust: if !creative
    // rust: && !spectator
    // rust: && hurtable
    // rust: && let Ok(o) = p.hurt_caused_by(
    // rust: &self.health_resources,
    // rust: self.world.health_rules,
    // rust: id,
    // rust: amount,
    // rust: blocking,
    // rust: attacker.is_some(),
                    // The blast's causing entity.
    // rust: attacker.map_or(0, |(id, _)| *id as i32),
    // rust: )
    // rust: {
    // rust: outcome = o;
                // dealDefaultKnockback's `indicateDamage` points at the blast
                // (the source position), not the no-direction fallback.
    // rust: if o.knockback && o.blocked <= 0.0 {
    // rust: p.health
    // rust: .indicate_damage(center[0] - feet[0], center[2] - feet[2], p.yaw);
}
}
}
    // rust: if !spectator {
    // rust: let mut push = [dir[0] * power, dir[1] * power, dir[2] * power];
    // rust: self.native_explosion_knockback(self.dim.id(), center, blocks, None, &mut push);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.velocity = Vec3::new(
    // rust: p.velocity.x + push[0],
    // rust: p.velocity.y + push[1],
    // rust: p.velocity.z + push[2],
    // rust: );
    // rust: if !(creative && flying) {
                    // ServerExplosion.hitPlayers: the packet carries the push even when the hurt
                    // also marks the velocity (its motion packet follows).
    // rust: pushed = Some(push);
}
}
}
    // rust: self.combat.forget_noted(outcome.canceled);
    // rust: if raised {
    // rust: let source = horizon_client::health::HurtSource {
    // rust: damage_type,
    // rust: causing: attacker.map_or(0, |(id, _)| *id as i32),
    // rust: direct: 0,
}
    // rust: self.after_block(outcome, (None, false), source);
}
    // rust: pushed
}

    /// Where a blast at `center` reaches `entity`, unless it ignores the blast
    /// or is out of range (`getEntities` and `ServerExplosion.hurtEntities`).
    /// Generic over the kind, so every walked list gets its own copy.
    // rust: fn blast_hit<E: Entity>(
    // rust: &self,
    // rust: entity: &E,
    // rust: center: [f64; 3],
    // rust: diameter: f64,
    // rust: blast: &Blast,
    // rust: ) -> Option<Hit> {
    // rust: if entity.ignores_explosion(blast) || !entity.pushed_by_explosion() {
    // rust: return None;
}
    // rust: let feet = entity.position();
    // rust: let dist = blast_distance(center, [feet.x, feet.y, feet.z]) / diameter;
    // rust: if dist > 1.0 {
    // rust: return None;
}
    // rust: let b = entity.explosion_box();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let exposure = self.seen_percent(center, [lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z]);
    // rust: let dir = blast_direction(
    // rust: center,
    // rust: [feet.x, feet.y + entity.explosion_eye_height(), feet.z],
    // rust: );
    // rust: let power = (1.0 - dist) * f64::from(exposure);
    // rust: Some(Hit {
    // rust: dist,
    // rust: exposure,
    // rust: push: Vec3::new(dir[0] * power, dir[1] * power, dir[2] * power),
    // rust: })
}
    /// `ServerExplosion.hurtEntities` (player, mobs, items, primed TNT, minecarts);
    /// the player takes `damage_type`. Returns the players whose clients add a
    /// push from the explosion packet, and how much (`explosion_hurt_player`).
    // rust: fn explosion_hurt_entities(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: damage_type: &str,
    // rust: interaction: BlockInteraction,
    // rust: blocks: &[[i32; 3]],
    // rust: ) -> Vec<(u32, [f64; 3])> {
    // rust: if radius < 1.0e-5 {
    // rust: return Vec::new();
}
    // rust: self.explosion_hits_special(center, radius, blocks);
    // rust: let diameter = f64::from(radius * 2.0);
    // rust: let damage = |dist: f64, exposure: f32| {
    // rust: let pow = (1.0 - dist) * f64::from(exposure);
    // rust: ((pow * pow + pow) / 2.0 * 7.0 * diameter + 1.0) as f32
}
        // `source.doTeamsAllowDamage(entity)`: the exploding mob spares its
        // team mates when its team has no friendly fire (they are still pushed).
    // rust: let exploding = self.combat.explosion_source;
    // rust: let teams_allow = |g: &Self, victim: Option<&horizon_client::scoreboard::Team>| {
    // rust: exploding.is_none_or(|id| {
    // rust: horizon_client::scoreboard::teams_allow_damage(g.mob_team(id), victim)
    // rust: })
}
        // The player, then every other player in the level (LAN guests),
        // each swapped in as the player. In a guest's turn (their hit on an
        // end crystal) the player is that guest. The blast's source is the
        // same for all of them (`onExplosionHit(this.source)`).
    // rust: let attacker = self.blast_attacker();
    // rust: let blast_source = self.combat.explosion_cause.clone();
    // rust: let context = ExplosionHookContext { center, blocks };
    // rust: let own = self.explosion_hurt_player(
    // rust: &context,
    // rust: radius,
    // rust: damage_type,
    // rust: exploding,
    // rust: attacker.as_ref(),
    // rust: blast_source.as_ref(),
    // rust: );
    // rust: let mut pushed: Vec<_> = self.lan_acting.zip(own).into_iter().collect();
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: let guests: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in guests {
    // rust: let push = self.as_guest(&mut host, conn, |g| {
    // rust: g.explosion_hurt_player(
    // rust: &context,
    // rust: radius,
    // rust: damage_type,
    // rust: exploding,
    // rust: attacker.as_ref(),
    // rust: blast_source.as_ref(),
    // rust: )
    // rust: });
    // rust: if let Some(Some(push)) = push {
    // rust: pushed.push((conn, push));
}
}
    // rust: self.lan = Some(host);
}
        // Mobs. `WitherBoss.hurtServer`: a wither shrugs off an undead cause.
    // rust: let cause = self
    // rust: .combat
    // rust: .explosion_owner
    // rust: .or(exploding)
    // rust: .and_then(|id| self.mobs.iter().find(|m| m.id == id))
    // rust: .map(|m| m.species());
        // `ServerExplosion.hurtEntities`: every entity in reach, on the walk. Each
        // answers `ignoreExplosion` itself (`Entity::ignores_explosion`); the rest
        // is the same for all, and only what a blast does to a kind differs. The
        // walk covers the entities there are now: what the blast drops or spawns
        // is not hit by it. Destroyed items and orbs are squeezed out afterwards
        // (as `retain` does), and a destroyed boat or cart shifts its list, so
        // `gone` counts how far.
    // rust: let blast = Blast {
    // rust: vehicles_ignore: self.combat.blast_owner.is_none()
    // rust: && self.blast_attacker().is_some()
    // rust: && !self.ui.rules.bool("mob_griefing"),
    // rust: items_ignore: items_ignore_explosion(self.ui.rules.bool("mob_griefing"), interaction),
    // rust: spared: exploding.filter(|_| self.combat.explosion_source_named),
}
    // rust: let (items_len, orbs_len) = (self.dropped.len(), self.orbs.len());
    // rust: let (mut items_kept, mut orbs_kept) = (0, 0);
    // rust: let (mut boats_gone, mut carts_gone) = (0, 0);
    // rust: for handle in self.entity_handles() {
    // rust: let handle = match handle {
    // rust: EntityHandle::Boat(i) => EntityHandle::Boat(i - boats_gone),
    // rust: EntityHandle::Cart(i) => EntityHandle::Cart(i - carts_gone),
    // rust: other => other,
}
    // rust: let hit = with_entity!(self, handle, e => self.blast_hit(e, center, diameter, &blast));
    // rust: let mut destroyed = false;
    // rust: if let Some(Hit {
    // rust: dist,
    // rust: exposure,
    // rust: push,
    // rust: }) = hit
    // rust: {
    // rust: let amount = damage(dist, exposure);
    // rust: let entity = with_entity!(self, handle, e => e.id());
    // rust: match handle {
    // rust: EntityHandle::Mob(i) => {
    // rust: let hurtable = teams_allow(self, self.mob_team(self.mobs[i].id));
    // rust: let m = &mut self.mobs[i];
                        // The exploding mob is the damage source's entity, so
                        // victims it kills drop its charged-creeper loot
                        // (`Creeper.killedEntity`).
    // rust: let source = horizon_client::mobs::Damage {
    // rust: kind: horizon_client::mobs::DamageKind::Explosion,
                            // A projectile's owner (`getIndirectSourceEntity`),
                            // else the exploding mob itself.
    // rust: attacker: attacker
    // rust: .as_ref()
    // rust: .map(|&(id, _)| id)
    // rust: .filter(|&o| o != m.id)
    // rust: .map(horizon_client::mobs::Who::Mob),
    // rust: from: Some(center),
    // rust: attacker_species: cause,
}
                        // `EXPLOSION_KNOCKBACK_RESISTANCE`, not `KNOCKBACK_RESISTANCE`:
                        // its base is 0 for every mob type, so iron golems and
                        // ravagers are pushed.
    // rust: hurt_mob(m, hurtable, cause, (amount, source));
}
                    // 5 health, destroyed by the explosion damage (nether stars resist).
    // rust: EntityHandle::Item(i) => {
    // rust: destroyed = &*self.dropped[i].stack.item != "minecraft:nether_star"
    // rust: && amount >= 5.0;
}
                    // `ExperienceOrb.hurtServer` takes the damage off their 5 health.
    // rust: EntityHandle::Orb(i) => {
    // rust: destroyed = self.orbs[i].hurt(amount);
}
                    // `VehicleEntity.hurtServer` (explosions ignite TNT carts);
                    // a destroyed one is gone before the push.
    // rust: EntityHandle::Cart(i) => {
    // rust: let len = self.carts.len();
    // rust: self.hurt_cart(i, amount, false, true);
    // rust: carts_gone += len - self.carts.len();
}
                    // `VehicleEntity.hurtServer`: damage * 10, broken past 40.
    // rust: EntityHandle::Boat(i) => {
    // rust: let len = self.boats.len();
    // rust: self.hurt_boat(i, amount, false);
    // rust: boats_gone += len - self.boats.len();
}
                    // `hurtServer` does nothing to the rest.
    // rust: _ => {}
}
    // rust: let mut velocity = [push.x, push.y, push.z];
    // rust: self.native_explosion_knockback(
    // rust: self.dim.id(),
    // rust: center,
    // rust: blocks,
    // rust: Some(entity),
    // rust: &mut velocity,
    // rust: );
    // rust: let push = Vec3::new(velocity[0], velocity[1], velocity[2]);
    // rust: match handle {
    // rust: EntityHandle::Item(_) | EntityHandle::Orb(_) if destroyed => {}
    // rust: EntityHandle::Cart(_) => {
    // rust: if let Some(c) = self.carts.iter_mut().find(|c| c.id == entity) {
    // rust: c.push_from_explosion(push);
}
}
    // rust: EntityHandle::Boat(_) => {
    // rust: if let Some(b) = self.boats.iter_mut().find(|b| b.id == entity) {
    // rust: b.push_from_explosion(push);
}
}
    // rust: other => with_entity_mut!(self, other, e => e.push_from_explosion(push)),
}
}
    // rust: match handle {
    // rust: EntityHandle::Item(i) if !destroyed => {
    // rust: self.dropped.swap(items_kept, i);
    // rust: items_kept += 1;
}
    // rust: EntityHandle::Orb(i) if !destroyed => {
    // rust: self.orbs.swap(orbs_kept, i);
    // rust: orbs_kept += 1;
}
    // rust: _ => {}
}
}
    // rust: self.dropped.drain(items_kept..items_len);
    // rust: self.orbs.drain(orbs_kept..orbs_len);
    // rust: self.native_leaves_flush();
        // Frames, paintings, cushions and armour stands last: vanilla lists
        // the entities in reach before hurting any, so the items they drop
        // here are neither destroyed nor pushed by the same blast.
    // rust: self.explosion_breaks_frames(center, diameter, interaction);
    // rust: self.explosion_breaks_decorations(center, diameter, interaction);
    // rust: pushed
}
    /// `blast_spares_decorations` for the blast going off now: its causing
    /// mob (`blast_attacker`) is the source's entity.
    // rust: pub(super) fn blast_spares_decorations(&self, interaction: BlockInteraction) -> bool {
    // rust: let by_mob = self.blast_attacker().is_some();
    // rust: blast_spares_decorations(
    // rust: self.ui.rules.bool("mob_griefing"),
    // rust: interaction,
    // rust: by_mob,
    // rust: self.combat.explosion_in_water,
    // rust: )
}
    /// `Entity.isInWater` for an entity box: `updateFluidInteraction` over the box.
    // rust: pub(super) fn bounds_in_water(&self, bounds: horizon_core::geometry::Aabb) -> bool {
    // rust: self.mob_world_base(&[])
    // rust: .fluids(bounds, bounds.max_position().y)
    // rust: .in_water
}
    /// `ServerExplosion.hurtEntities` for paintings, cushions and armour
    /// stands (item frames: `explosion_breaks_frames`). A painting or cushion
    /// in reach is killed and dropped (`BlockAttachedEntity.hurtServer`,
    /// `Painting.dropItem`, `Cushion.dropItem`). An armour stand that is
    /// neither invisible nor a marker breaks (`ArmorStand.hurtServer` with
    /// `IS_EXPLOSION`: `brokenByAnything`, then `kill`): its equipment drops,
    /// the stand itself does not.
    // rust: fn explosion_breaks_decorations(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: diameter: f64,
    // rust: interaction: BlockInteraction,
    // rust: ) {
        // An armour stand is no `BlockAttachedEntity`: a source in water does not spare it.
    // rust: let by_mob = self.blast_attacker().is_some();
    // rust: let spares_stands = blast_spares_decorations(
    // rust: self.ui.rules.bool("mob_griefing"),
    // rust: interaction,
    // rust: by_mob,
    // rust: false,
    // rust: );
    // rust: if !self.blast_spares_decorations(interaction) {
    // rust: self.explosion_breaks_hanging(center, diameter);
}
    // rust: if spares_stands {
    // rust: return;
}
    // rust: let mut i = 0;
    // rust: while i < self.armor_stands.len() {
    // rust: let a = &self.armor_stands[i];
    // rust: let p = a.position;
    // rust: if !super::armor_stands::spared_by_blast(a)
    // rust: && blast_reaches(center, diameter, [p.x, p.y, p.z])
    // rust: {
    // rust: self.break_armor_stand_by_anything(i);
    // rust: } else {
    // rust: i += 1;
}
}
}
    /// Paintings and cushions in reach (`BlockAttachedEntity.hurtServer`).
pub fn explosion_breaks_hanging(self: *Self, center: [f64; 3], diameter: f64) void {
}
    // rust: let mut i = 0;
    // rust: while i < self.paintings.len() {
            // HangingEntity.recalculateBoundingBox: a painting stands at the
            // centre of its box.
    // rust: let (lo, hi) = self.paintings[i].bounds();
    // rust: let at = [0, 1, 2].map(|k| (lo[k] + hi[k]) / 2.0);
            // A painting a mod keeps stays at `i`.
    // rust: if !(blast_reaches(center, diameter, at) && self.break_painting(i, false)) {
    // rust: i += 1;
}
}
    // rust: let mut i = 0;
    // rust: while i < self.cushions.len() {
    // rust: let p = self.cushions[i].position;
    // rust: if blast_reaches(center, diameter, [p.x, p.y, p.z]) {
    // rust: self.break_cushion(i, false);
    // rust: } else {
    // rust: i += 1;
}
}
}
    /// `ServerLevel.getDestroyType`: a drop decay rule picks between decaying
    /// and plain destruction.
    // rust: pub(super) fn destroy_type(&self, rule: &str) -> BlockInteraction {
    // rust: if self.ui.rules.bool(rule) {
    // rust: BlockInteraction::DestroyWithDecay
    // rust: } else {
    // rust: BlockInteraction::Destroy
}
}
    /// Runs an explosion whose source empties the hives it destroys
    /// (`BeehiveBlock.getDrops`: primed TNT, creeper, wither skull, wither,
    /// TNT minecart).
    // rust: pub(super) fn with_hive_emptying_blast<R>(&mut self, blast: impl FnOnce(&mut Self) -> R) -> R {
    // rust: self.combat.hive_emptying_blast = true;
    // rust: let result = blast(self);
    // rust: self.combat.hive_emptying_blast = false;
    // rust: result
}
    /// `Level.explode` on the server: positions, entities, blocks, fire; then
    /// the client's explosion sound.
    // rust: pub(super) fn server_explode(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: interaction: BlockInteraction,
    // rust: fire: bool,
    // rust: ) -> Result<()> {
    // rust: let damage_type = super::creatures::damage_type(
    // rust: horizon_client::mobs::DamageKind::Explosion,
    // rust: self.blast_attacker().is_some(),
    // rust: );
    // rust: self.server_explode_as(center, radius, interaction, fire, damage_type, None)
}
    /// `server_explode` with the damage type the player takes and a block
    /// whose explosion resistance the damage calculator overrides.
    // rust: pub(super) fn server_explode_as(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: interaction: BlockInteraction,
    // rust: fire: bool,
    // rust: damage_type: &str,
    // rust: resists: Option<([i32; 3], f32)>,
    // rust: ) -> Result<()> {
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: self.native_explosion_prime(center, radius);
}
    // rust: if let Some(p) = &self.player {
    // rust: let d = [
    // rust: p.position.x - center[0],
    // rust: p.position.y - center[1],
    // rust: p.position.z - center[2],
    // rust: ];
    // rust: let distance = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: self.pad_rumble(horizon_client::gamepad::Rumble::Explosion { distance, radius });
}
        // Explosion.explode: the blast is heard.
    // rust: let ctx = horizon_client::sculk::Context::default();
    // rust: self.post_game_event("minecraft:explode", center, ctx);
    // rust: let mut targets = self.exploded_positions(center, radius, resists);
    // rust: let dimension = self.dim.id();
    // rust: self.native_explosion_detonate(dimension, center, &mut targets);
    // rust: let pushed =
    // rust: self.explosion_hurt_entities(center, radius, damage_type, interaction, &targets);
    // rust: if interaction != BlockInteraction::Keep {
            // Util.shuffle(list, level.random)
    // rust: for i in (2..=targets.len()).rev() {
    // rust: let swap = self.world.random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: targets.swap(i - 1, swap);
}
    // rust: let mut stacks: Vec<([i32; 3], ItemStack)> = Vec::new();
    // rust: for &pos in &targets {
    // rust: self.explosion_hit_block(pos, radius, interaction, &mut stacks)?;
}
    // rust: for (pos, stack) in stacks {
    // rust: self.pop_resource(pos, stack);
}
}
    // rust: if fire {
    // rust: for &pos in &targets {
    // rust: if self.world.random.next_int_bound(3).unwrap_or(1) == 0
    // rust: && self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.world.block(pos[0], pos[1], pos[2]))
    // rust: && self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1] - 1, pos[2]))
    // rust: .solid_render
    // rust: {
                    // BaseFireBlock.getState: soul fire on its base blocks,
                    // fire shaped by its neighbours elsewhere.
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let fire =
    // rust: self.with_level(|b, level, ticks| b.fire_state_for(level, ticks, at));
    // rust: self.level_set(pos, fire)?;
}
}
}
    // rust: let pitch = (1.0 + (client_float() - client_float()) * 0.2) * 0.7;
    // rust: self.audio
    // rust: .play("minecraft:entity.generic.explode", Some(center), 4.0, pitch);
        // ServerLevel.explode sends toBlow.size() whatever the interaction, and
        // `ServerExplosion.isSmall` also covers an explosion that keeps blocks.
    // rust: let block_count = targets.len();
    // rust: let small = radius < 2.0 || interaction == BlockInteraction::Keep;
    // rust: let (world, facts) = (&self.world, self.res.facts());
    // rust: self.particles
    // rust: .explosion(center, small, block_count, radius, &|b| {
    // rust: facts.is_air(world.block(b[0], b[1], b[2]))
    // rust: });
    // rust: self.lan_explode(center, small, radius, block_count, pushed);
    // rust: Ok(())
}
    /// `BlockBehaviour.onExplosionHit` (TNT: `wasExploded` primes a short fuse).
    // rust: fn explosion_hit_block(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: radius: f32,
    // rust: interaction: BlockInteraction,
    // rust: stacks: &mut Vec<([i32; 3], ItemStack)>,
    // rust: ) -> Result<()> {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if self.res.facts().is_air(state) {
    // rust: return Ok(());
}
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: let is_tnt = &*name == "minecraft:tnt";
        // CreakingHeartBlock.onExplosionHit: its creaking dies (no
        // experience, as Horizon does not track a TNT's owner).
    // rust: if &*name == "minecraft:creaking_heart" {
    // rust: self.creaking_heart_broken(pos, false);
}
        // Block.onExplosionHit: the drops copy from the block entity, which
        // then spills its contents as the block turns to air.
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let is_hive = matches!(&*name, "minecraft:beehive" | "minecraft:bee_nest");
        // BeehiveBlock.getDrops: the bees of a hive blown up by TNT, a
        // creeper, a wither skull, a wither or a TNT minecart come out.
    // rust: if is_hive && self.combat.hive_emptying_blast {
    // rust: let facing = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("facing").cloned());
    // rust: self.empty_hive(
    // rust: pos,
    // rust: horizon_client::beehive::facing_step(facing.as_deref()),
    // rust: horizon_client::beehive::Release::Emergency,
    // rust: );
}
    // rust: if let Some(entity) = self.world.block_entities.get(&key).cloned() {
    // rust: let custom = self.world.block_names.get(&key).cloned();
    // rust: self.pending.record(pos, &entity, &name, custom);
    // rust: } else if let Some(tag) = super::spill::saved_entity(&self.world, pos) {
    // rust: self.pending.record_saved(pos, &tag);
}
    // rust: if !is_tnt {
    // rust: let dynamic = self.pending.dynamic(pos);
            // LootContextParams.EXPLOSION_RADIUS under DESTROY_WITH_DECAY: the
            // tables' survives_explosion and explosion_decay draw from their
            // random sequence.
    // rust: let decay = (interaction == BlockInteraction::DestroyWithDecay).then_some(radius);
    // rust: let place = self.loot_place_at(
    // rust: pos.map(|v| f64::from(v) + 0.5),
    // rust: self.loot_block_entity(pos, &name),
    // rust: );
    // rust: let mut drops = horizon_world::loot::with_native_loot_place(place, || {
    // rust: world_items!(self).block_drops_exploded(
    // rust: self.pack.assets.registry,
    // rust: state,
    // rust: None,
    // rust: &dynamic,
    // rust: &mut self.world.random,
    // rust: Some((&mut self.rand_sequences, self.level.seed)),
    // rust: decay,
    // rust: false,
    // rust: )
    // rust: });
    // rust: self.native_block_drops(pos, state, None, None, Some(radius), &mut drops);
    // rust: for mut stack in drops {
    // rust: if &*stack.item == "minecraft:air" || stack.count == 0 {
    // rust: continue;
}
    // rust: self.pending.attach(pos, &mut stack);
    // rust: let items = self.res.items();
    // rust: add_or_append_stack(stacks, stack, pos, &|s| {
    // rust: items.get(&s.item).map_or(64, |i| i.max_stack)
    // rust: });
}
}
    // rust: self.pending.clear(pos);
    // rust: self.level_set(pos, self.world.air)?;
        // BeehiveBlock.onExplosionHit: the bees about turn on the player.
    // rust: if is_hive {
    // rust: self.anger_nearby_bees(pos);
}
        // TntBlock.wasExploded: new PrimedTnt (its push drawn first), then
        // getRandomShortFuse(80); no game event.
    // rust: if is_tnt && self.ui.rules.bool("tnt_explodes") {
    // rust: let r = &mut self.world.random;
    // rust: let rot = r.next_double() * f64::from(std::f32::consts::TAU);
    // rust: let fuse = r.next_int_bound(20).unwrap_or(0) + 10;
            // TntBlock.wasExploded hands the new TNT the blast's indirect
            // source, so a chain reaction keeps the player who started it.
    // rust: let (owner, guest) = match &self.combat.blast_owner {
    // rust: Some(_) => (Some(Who::Player), self.combat.blast_guest),
    // rust: None => (None, None),
}
    // rust: self.add_primed_tnt(
    // rust: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: rot,
    // rust: fuse,
    // rust: owner,
    // rust: guest,
    // rust: );
}
    // rust: Ok(())
}
}

/// `ServerExplosion.addOrAppendStack`: `ItemEntity.areMergable` (same item and
/// components, combined count within the item's max stack size), then
/// `ItemEntity.merge(.., 16)`.
    // rust: fn add_or_append_stack(
    // rust: stacks: &mut Vec<([i32; 3], ItemStack)>,
    // rust: mut stack: ItemStack,
    // rust: pos: [i32; 3],
    // rust: max_stack: &dyn Fn(&ItemStack) -> u32,
    // rust: ) {
    // rust: let max = i64::from(max_stack(&stack));
    // rust: for (_, existing) in stacks.iter_mut() {
    // rust: if existing.same_item_same_components(&stack)
    // rust: && i64::from(existing.count) + i64::from(stack.count) <= max
    // rust: {
    // rust: let moved = (max.min(16) - i64::from(existing.count))
    // rust: .min(i64::from(stack.count))
    // rust: .max(0) as u32;
    // rust: existing.count += moved;
    // rust: stack.count -= moved;
    // rust: if stack.count == 0 {
    // rust: return;
}
}
}
    // rust: stacks.push((pos, stack));
}

/// `WitherSkull.getBlockExplosionResistance`: `isDangerous() &&
/// WitherBoss.canDestroy(state) ? min(0.8, resistance) : resistance`. Air has
/// no resistance to begin with, and `#wither_immune` blocks keep theirs.
pub fn blast_resistance(base: f32, cap: ?f32, wither_immune: bool) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match cap {
    // rust: Some(cap) if !wither_immune => base.min(cap),
    // rust: _ => base,
}
}

    // rust: mod tests {
//     use super::*;

    /// A dangerous wither skull's blast treats a block as at most 0.8 harder to
    /// break, but a `#wither_immune` block keeps its own resistance and any
    /// other blast is unchanged.
pub fn a_dangerous_wither_skull_caps_block_resistance() void {
}
    // rust: assert_eq!(blast_resistance(4.0, Some(0.8), false), 0.8);
    // rust: assert_eq!(blast_resistance(0.3, Some(0.8), false), 0.3, "already low");
    // rust: assert_eq!(blast_resistance(4.0, Some(0.8), true), 4.0, "wither immune");
    // rust: assert_eq!(blast_resistance(4.0, None, false), 4.0, "another blast");
}

    /// A dropped item survives a mob's blast untouched while `mobGriefing` is
    /// off, and is thrown and hurt as usual by one that destroys blocks or by
    /// any blast with the rule back on.
pub fn items_ignore_a_blast_that_keeps_blocks_with_griefing_off() void {
}
    // rust: assert!(items_ignore_explosion(false, BlockInteraction::Keep));
    // rust: assert!(!items_ignore_explosion(false, BlockInteraction::Destroy));
    // rust: assert!(!items_ignore_explosion(
    // rust: false,
    // rust: BlockInteraction::DestroyWithDecay
    // rust: ));
    // rust: assert!(!items_ignore_explosion(true, BlockInteraction::Keep));
}

pub fn blasts_reach_entities_within_their_diameter() void {
}
        // A TNT blast: radius 4, so the entity pass reaches 8 blocks out.
    // rust: let center = [0.5, 64.0, 0.5];
    // rust: assert!(blast_reaches(center, 8.0, [8.5, 64.0, 0.5]));
    // rust: assert!(blast_reaches(center, 8.0, [-3.5, 68.0, 4.5]));
    // rust: assert!(!blast_reaches(center, 8.0, [8.6, 64.0, 0.5]));
}

    /// A zombie's type with only what a hurt and a push read.
pub fn zombie_type() s {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_client::mobs::{Anim, Brain, MobType, Part, Species};
    // rust: std::sync::Arc::new(MobType {
    // rust: id: "minecraft:zombie".into(),
    // rust: species: Species::Zombie,
    // rust: width: 0.6,
    // rust: height: 1.95,
    // rust: eye_height: 1.74,
    // rust: category: "monster".into(),
    // rust: max_health: 20.0,
    // rust: speed: 0.23,
    // rust: flying_speed: 0.02,
    // rust: attack_damage: 3.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 35.0,
    // rust: step_height: 0.6,
    // rust: armor: 2.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Default::default(),
    // rust: item_stack_limits: Default::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.5,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 80,
    // rust: flags: Default::default(),
    // rust: model: std::sync::Arc::new(Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: Vec::new(),
    // rust: children: Vec::new(),
    // rust: }),
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Humanoid { zombie_arms: true },
    // rust: sounds: ["", "", ""],
    // rust: step_sound: None,
    // rust: food: Default::default(),
    // rust: tempt: Default::default(),
    // rust: })
}

pub fn a_mob_that_refuses_the_hit_is_still_pushed() void {
}
//         use horizon_client::mobs::{Damage, DamageKind, Mob, Species};
    // rust: let hit = (10.0, Damage::of(DamageKind::Explosion));
    // rust: let push = Vec3::new(0.5, 0.25, -0.5);
    // rust: let mob = |id, species| {
    // rust: let mut kind = (*zombie_type()).clone();
    // rust: kind.species = species;
    // rust: Mob::new(id, std::sync::Arc::new(kind), Vec3::ZERO, 0.0)
}
    // rust: let pushed = |m: &Mob| {
    // rust: assert_eq!(m.velocity, Vec3::new(0.5, 0.25, -0.5));
    // rust: assert!(m.needs_sync);
}
        // An ordinary mob is hurt and pushed.
    // rust: let mut m = mob(1, Species::Zombie);
    // rust: let health = m.health;
    // rust: hurt_mob(&mut m, true, None, hit);
    // rust: m.push_from_explosion(push);
    // rust: assert!(m.health < health);
    // rust: pushed(&m);
        // An invulnerable one refuses the hit, and is pushed all the same.
    // rust: let mut m = mob(2, Species::Zombie);
    // rust: m.invulnerable_flag = true;
    // rust: let health = m.health;
    // rust: hurt_mob(&mut m, true, None, hit);
    // rust: m.push_from_explosion(push);
    // rust: assert_eq!(m.health, health);
    // rust: pushed(&m);
        // A team mate of the exploding mob is not hurt, but pushed.
    // rust: let mut m = mob(3, Species::Zombie);
    // rust: let health = m.health;
    // rust: hurt_mob(&mut m, false, None, hit);
    // rust: m.push_from_explosion(push);
    // rust: assert_eq!(m.health, health);
    // rust: pushed(&m);
        // A wither shrugs off a blast an undead caused, and is pushed.
    // rust: let mut m = mob(4, Species::Wither);
    // rust: let health = m.health;
    // rust: hurt_mob(&mut m, true, Some(Species::Skeleton), hit);
    // rust: m.push_from_explosion(push);
    // rust: assert_eq!(m.health, health);
    // rust: pushed(&m);
}

pub fn mob_griefing_off_spares_decorations_from_kept_and_mob_blasts() void {
}
//         use BlockInteraction::{Destroy, DestroyWithDecay, Keep};
        // mobGriefing on: every blast breaks them, a creeper's included.
    // rust: assert!(!blast_spares_decorations(
    // rust: true,
    // rust: DestroyWithDecay,
    // rust: true,
    // rust: false
    // rust: ));
    // rust: assert!(!blast_spares_decorations(true, Keep, true, false));
        // Off: TNT still breaks them (ExplosionInteraction.TNT destroys blocks).
    // rust: assert!(!blast_spares_decorations(false, Destroy, false, false));
    // rust: assert!(!blast_spares_decorations(
    // rust: false,
    // rust: DestroyWithDecay,
    // rust: false,
    // rust: false
    // rust: ));
        // Off: a blast that keeps blocks, or one a mob causes, does not.
    // rust: assert!(blast_spares_decorations(false, Keep, false, false));
    // rust: assert!(blast_spares_decorations(false, Destroy, true, false));
        // A source in water spares them whatever the rules (`BlockAttachedEntity.ignoreExplosion`).
    // rust: assert!(blast_spares_decorations(
    // rust: true,
    // rust: DestroyWithDecay,
    // rust: false,
    // rust: true
    // rust: ));
    // rust: assert!(blast_spares_decorations(true, Destroy, true, true));
}

    /// The type a blast hurts with and the attacker its death message names
    /// come from one cause (`DamageSources.explosion`): `player_explosion`
    /// "blown up by" that mob, or `explosion` with no one when it has none.
    // rust: fn blast_hurt(
    // rust: owner: Option<u32>,
    // rust: exploding: Option<u32>,
    // rust: live: &[(u32, Text)],
    // rust: exploded: &[(u32, Text)],
    // rust: ) -> (&'static str, Option<(u32, Text)>) {
    // rust: let find = |id| live.iter().find(|(m, _)| *m == id).map(|(_, n)| n.clone());
    // rust: let cause = blast_cause(owner, exploding, find, exploded);
    // rust: let kind = horizon_client::mobs::DamageKind::Explosion;
    // rust: (
    // rust: super::super::creatures::damage_type(kind, cause.is_some()),
    // rust: cause,
    // rust: )
}

pub fn a_caused_blast_names_its_cause_under_player_explosion() void {
}
    // rust: let creeper = Text::translate("entity.minecraft.creeper", &[]);
    // rust: let ghast = Text::translate("entity.minecraft.ghast", &[]);
        // A creeper's blast: it left the mob list, its event named it.
    // rust: assert_eq!(
    // rust: blast_hurt(None, Some(7), &[], &[(7, creeper.clone())]),
    // rust: ("minecraft:player_explosion", Some((7, creeper)))
    // rust: );
        // A ghast's fireball: its owner is still in the level.
    // rust: assert_eq!(
    // rust: blast_hurt(Some(3), None, &[(3, ghast.clone())], &[]),
    // rust: ("minecraft:player_explosion", Some((3, ghast.clone())))
    // rust: );
        // The ghast was removed before its fireball landed: no owner.
    // rust: assert_eq!(
    // rust: blast_hurt(Some(3), None, &[], &[]),
    // rust: ("minecraft:explosion", None)
    // rust: );
        // Nothing caused it.
    // rust: assert_eq!(
    // rust: blast_hurt(None, None, &[], &[]),
    // rust: ("minecraft:explosion", None)
    // rust: );
        // A projectile's owner wins over the exploding mob, and a removed
        // owner gives no cause even when a mob is exploding.
    // rust: let zombie = Text::translate("entity.minecraft.zombie", &[]);
    // rust: let live = [(3, ghast.clone()), (5, zombie.clone())];
    // rust: assert_eq!(
    // rust: blast_hurt(Some(3), Some(5), &live, &[]),
    // rust: ("minecraft:player_explosion", Some((3, ghast)))
    // rust: );
    // rust: assert_eq!(
    // rust: blast_hurt(Some(4), Some(5), &live, &[]),
    // rust: ("minecraft:explosion", None)
    // rust: );
        // A mob still in the level is named as it is now, before its name
        // in the exploded list.
    // rust: let named = Text::literal("Bob".to_owned());
    // rust: assert_eq!(
    // rust: blast_hurt(None, Some(5), &live, &[(5, named)]),
    // rust: ("minecraft:player_explosion", Some((5, zombie)))
    // rust: );
}

pub fn block_pos_hash_matches_vec3i() void {
}
        // Vec3i.hashCode: (y + z * 31) * 31 + x
    // rust: assert_eq!(Key([1, 2, 3]).java_hash(), (2 + 3 * 31) * 31 + 1);
    // rust: assert_eq!(Key([-5, 64, -7]).java_hash(), (64 - 7 * 31) * 31 - 5);
    // rust: assert_eq!(
    // rust: Key([0, 1, 0]).comparable_compare(&Key([5, 0, 9])),
    // rust: Some(Ordering::Greater)
    // rust: );
    // rust: assert_eq!(
    // rust: Key([1, 0, 2]).comparable_compare(&Key([0, 0, 3])),
    // rust: Some(Ordering::Less)
    // rust: );
}

pub fn drops_merge_up_to_sixteen() void {
}
    // rust: let stack = |item: &str| ItemStack {
    // rust: item: item.into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: let max = |s: &ItemStack| {
    // rust: if &*s.item == "minecraft:diamond_sword" {
    // rust: 1
    // rust: } else {
    // rust: 64
}
}
    // rust: let mut stacks = Vec::new();
    // rust: for _ in 0..20 {
    // rust: add_or_append_stack(&mut stacks, stack("minecraft:dirt"), [0, 0, 0], &max);
}
    // rust: add_or_append_stack(&mut stacks, stack("minecraft:stone"), [1, 0, 0], &max);
    // rust: let counts: Vec<u32> = stacks.iter().map(|(_, s)| s.count).collect();
    // rust: assert_eq!(counts, vec![16, 4, 1]);
}

pub fn unstackable_drops_stay_separate() void {
}
    // rust: let sword = ItemStack {
    // rust: item: "minecraft:diamond_sword".into(),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: let max = |_: &ItemStack| 1;
    // rust: let mut stacks = Vec::new();
    // rust: add_or_append_stack(&mut stacks, sword.clone(), [0, 0, 0], &max);
    // rust: add_or_append_stack(&mut stacks, sword, [0, 0, 0], &max);
    // rust: let counts: Vec<u32> = stacks.iter().map(|(_, s)| s.count).collect();
    // rust: assert_eq!(counts, vec![1, 1]);
}

pub fn drops_with_different_damage_stay_separate() void {
}
    // rust: let pick = |damage| ItemStack {
    // rust: item: "minecraft:iron_pickaxe".into(),
    // rust: count: 1,
    // rust: damage,
    // rust: extra: None,
}
    // rust: let max = |_: &ItemStack| 64;
    // rust: let mut stacks = Vec::new();
    // rust: add_or_append_stack(&mut stacks, pick(0), [0, 0, 0], &max);
    // rust: add_or_append_stack(&mut stacks, pick(5), [0, 0, 0], &max);
    // rust: assert_eq!(stacks.len(), 2);
}

    /// A blast and a burst of wind cast their rays at, and push from the eyes of,
    /// the mob as it stands: a baby's and a size-4 slime's own box and eye
    /// height, not the adult kind's (`Entity.getBoundingBox`, `getEyeHeight`).
pub fn a_scaled_mob_is_blasted_by_its_own_box_and_eye_height() void {
}
//         use crate::game::entity::Entity;
//         use horizon_client::mobs::{Mob, Species};
    // rust: let mob = |species| {
    // rust: let mut kind = (*zombie_type()).clone();
    // rust: kind.species = species;
    // rust: Mob::new(1, std::sync::Arc::new(kind), Vec3::ZERO, 0.0)
}
    // rust: let adult = mob(Species::Zombie);
    // rust: assert_eq!(adult.explosion_box(), adult.bounds());
    // rust: let mut baby = mob(Species::Zombie);
    // rust: baby.extra.age = -24000;
    // rust: let mut slime = mob(Species::Slime);
    // rust: slime.extra.size = 4;
    // rust: for m in [&baby, &slime] {
    // rust: let b = Entity::explosion_box(m);
    // rust: assert_eq!(b, m.bounds());
    // rust: assert_eq!(Entity::explosion_eye_height(m), m.eye_height());
    // rust: assert_ne!(
    // rust: f64::from(m.height()),
    // rust: f64::from(adult.height()),
    // rust: "the case must scale the box"
    // rust: );
    // rust: assert_eq!(
    // rust: b.max_position().y - b.min_position().y,
    // rust: f64::from(m.height())
    // rust: );
}
}
}
