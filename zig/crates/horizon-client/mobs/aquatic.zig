//! Transpiled from Horizon Rust crate
//! Module: horizon-client_aquatic
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Water mobs: squid and glow squid (tentacle propulsion), cod, salmon,
//! tropical fish and pufferfish (`AbstractFish`, puffing), and dolphins
//! (breathing, smooth swimming).
// use super::{
    // rust: Damage, Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: control::MoveKind,
    // rust: goals::{
    // rust: Avoid, AvoidEntity, BreathAir, Cx, Goal, HurtByTarget, LookAtPlayer, MeleeAttack, Panic,
    // rust: RandomLookAround, Stroll, TryFindWater, goal_clone, reduced,
    // rust: },
    // rust: nav::NavKind,
}
// use crate::blocks::Fluid;
// use crate::particles::ParticleType;
// use horizon_core::geometry::trig::Mth;
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use std::f32::consts::PI;

// Squid animation slots in AnimState.v.
pub const TENTACLE_MOVEMENT: usize = 0;
pub const TENTACLE_ANGLE: usize = 1;
pub const X_BODY_ROT: usize = 2;
pub const Z_BODY_ROT: usize = 3;
pub const TENTACLE_SPEED: usize = 4;
pub const ROTATE_SPEED: usize = 5;

/// `Squid.spawnInk`: the squirt sound and 30 ink particles shot from under
/// the squid, turned by its body rotation.
pub fn spawn_ink(m: *mut Mob) void {
}
    // rust: let sound = if m.species() == Species::GlowSquid {
    // rust: "entity.glow_squid.squirt"
    // rust: } else {
    // rust: "entity.squid.squirt"
}
    // rust: let kind = if m.species() == Species::GlowSquid {
    // rust: "glow_squid_ink"
    // rust: } else {
    // rust: "squid_ink"
}
    // makeSound draws the voice pitch even for a silent squid.
    // rust: let pitch = m.voice_pitch();
    // rust: if !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: m.outbox.push(MobEvent::Sound(
    // rust: sound,
    // rust: at,
    // rust: super::ai::sound_volume(m),
    // rust: pitch,
    // rust: ));
}
    // rotateVector: xRot(xBodyRotO), then yRot(-yBodyRotO).
    // rust: let to_radians = (std::f64::consts::PI / 180.0) as f32;
    // rust: let (x_rot, y_rot) = (
    // rust: m.anim.vo[X_BODY_ROT] * to_radians,
    // rust: -m.previous_body_yaw * to_radians,
    // rust: );
    // rust: let rotate = |v: Vec3| v.rotate_x(x_rot).rotate_y(y_rot);
    // rust: let pos = rotate(Vec3::new(0.0, -1.0, 0.0)).add_vector(m.position);
    // rust: let offset_scale: f32 = if m.is_baby() { 0.1 } else { 0.3 };
    // rust: for _ in 0..30 {
    // rust: let x = f64::from(m.random.next_float()) * 0.6 - 0.3;
    // rust: let z = f64::from(m.random.next_float()) * 0.6 - 0.3;
    // rust: let dir = rotate(Vec3::new(x, -1.0, z));
    // rust: let d = dir.scale(f64::from(offset_scale + m.random.next_float() * 2.0));
        // ServerLevel.sendParticles with a count of 0 and speed 0.1: one
        // particle moving at the float offset times the float speed, sent to
        // the players within 32 blocks.
    // rust: m.outbox.push(MobEvent::LevelParticles {
    // rust: kind,
    // rust: at: [pos.x, pos.y + 0.5, pos.z],
    // rust: spread: [
    // rust: f64::from(d.x as f32),
    // rust: f64::from(d.y as f32),
    // rust: f64::from(d.z as f32),
    // rust: ],
    // rust: speed: f64::from(0.1f32),
    // rust: count: 0,
    // rust: });
}
}
pub fn register(m: *mut Mob) void {
}
//     use Species as S;
    // WaterAnimal and AgeableWaterCreature: water costs nothing, so swim
    // targets in water pass DefaultRandomPos's malus check.
    // rust: if matches!(
    // rust: m.species(),
    // rust: S::Cod
    // rust: | S::Salmon
    // rust: | S::TropicalFish
    // rust: | S::Pufferfish
    // rust: | S::Tadpole
    // rust: | S::Squid
    // rust: | S::GlowSquid
    // rust: | S::Dolphin
    // rust: ) {
    // rust: m.set_malus(super::path::PathType::Water, 0.0);
}
    // rust: match m.species() {
    // rust: S::Squid | S::GlowSquid => {
    // rust: m.ai.goals.add(0, SquidRandomMovement);
    // rust: m.ai.goals.add(1, SquidFlee { ticks: 0 });
    // rust: m.ai.mov.kind = MoveKind::Custom;
    // rust: m.ai.nav.kind = NavKind::Water { breach: false };
    // rust: let speed = 1.0 / (m.random.next_float() + 1.0) * 0.2;
    // rust: m.anim.v[TENTACLE_SPEED] = speed;
}
    // rust: S::Axolotl => {
    // rust: m.air = super::axolotl::MAX_AIR;
            // Native controller scaling is essential: the base speed attribute is 1.0.
    // rust: m.ai.mov.kind = MoveKind::SmoothSwimming {
    // rust: max_turn_x: 85.0,
    // rust: max_turn_y: 10.0,
    // rust: in_water: 0.1,
    // rust: outside: 0.5,
    // rust: gravity: false,
}
    // rust: m.ai.look.kind = super::control::LookKind::SmoothSwimming(20.0);
    // rust: m.ai.nav.kind = NavKind::Amphibious {
    // rust: prefers_shallow: false,
}
            // `Axolotl()`: water costs nothing, so swim targets in water pass
            // DefaultRandomPos's malus check.
    // rust: m.set_malus(super::path::PathType::Water, 0.0);
    // rust: super::animal_brain::init(m, i64::from(m.id));
}
    // rust: S::Tadpole => {
            // `Tadpole()`: `SmoothSwimmingMoveControl(this, 85, 10, 0.02, 0.1, true)`,
            // `SmoothSwimmingLookControl(this, 10)` and a water-bound navigation.
    // rust: m.ai.mov.kind = MoveKind::SmoothSwimming {
    // rust: max_turn_x: 85.0,
    // rust: max_turn_y: 10.0,
    // rust: in_water: 0.02,
    // rust: outside: 0.1,
    // rust: gravity: true,
}
    // rust: m.ai.look.kind = super::control::LookKind::SmoothSwimming(10.0);
    // rust: m.ai.nav.kind = NavKind::Water { breach: false };
            // A tadpole is an `AbstractFish`: its goals (panic 1.25, avoid the player, the fish
            // swim goal) run beside `TadpoleAi`'s brain (panic 2.0, looking at players, frog
            // food, swimming about).
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Panic::new(1.25));
    // rust: g.add(2, AvoidEntity::new(Avoid::Player, 8.0, 1.6, 1.4));
    // rust: g.add(4, FishSwim(Stroll::swimming(1.0, 40)));
    // rust: super::animal_brain::init(m, i64::from(m.id));
}
    // rust: S::Cod | S::Salmon | S::TropicalFish | S::Pufferfish => {
    // rust: let puffer = m.species() == S::Pufferfish;
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Panic::new(1.25));
    // rust: g.add(2, AvoidEntity::new(Avoid::Player, 8.0, 1.6, 1.4));
    // rust: g.add(4, FishSwim(Stroll::swimming(1.0, 40)));
    // rust: if puffer {
    // rust: g.add(1, PufferfishPuff);
    // rust: } else {
    // rust: let next_start = FollowFlockLeader::next_start_tick(m);
    // rust: m.ai.goals.add(5, FollowFlockLeader::new(next_start));
}
    // rust: m.ai.mov.kind = MoveKind::Custom;
    // rust: m.ai.nav.kind = NavKind::Water { breach: false };
}
    // rust: S::Dolphin => {
            // `Dolphin`'s `moistness` field starts full.
    // rust: m.extra.counter = 2400;
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, BreathAir);
    // rust: g.add(0, TryFindWater::default());
    // rust: g.add(1, super::dolphin::SwimToTreasure::default());
    // rust: g.add(2, super::dolphin::SwimWithPlayer::new(4.0));
    // rust: g.add(4, Stroll::swimming(1.0, 10));
    // rust: g.add(4, RandomLookAround::default());
    // rust: g.add(5, LookAtPlayer::new(6.0));
    // rust: g.add(5, super::dolphin::Jump::new(10));
    // rust: g.add(6, MeleeAttack::new(1.2, true));
    // rust: g.add(7, super::dolphin::MoveToItem::default());
    // rust: g.add(8, super::dolphin::PlayWithItems);
    // rust: g.add(8, super::dolphin::FollowPlayerRidden::new(false));
    // rust: g.add(8, super::dolphin::FollowPlayerRidden::new(true));
            // `Dolphin.registerGoals`: AvoidEntityGoal(Guardian.class, 8, 1, 1).
    // rust: g.add(
    // rust: 9,
    // rust: AvoidEntity::new(
    // rust: Avoid::Species(vec![S::Guardian, S::ElderGuardian]),
    // rust: 8.0,
    // rust: 1.0,
    // rust: 1.0,
    // rust: ),
    // rust: );
            // `HurtByTargetGoal(this, Guardian.class)`: guardians' hits are ignored.
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: HurtByTarget::new()
    // rust: .alert()
    // rust: .ignoring(&[S::Guardian, S::ElderGuardian]),
    // rust: );
    // rust: m.ai.mov.kind = MoveKind::SmoothSwimming {
    // rust: max_turn_x: 85.0,
    // rust: max_turn_y: 10.0,
    // rust: in_water: 0.02,
    // rust: outside: 0.1,
    // rust: gravity: true,
}
    // rust: m.ai.look.kind = super::control::LookKind::SmoothSwimming(10.0);
    // rust: m.ai.nav.kind = NavKind::Water { breach: true };
    // rust: m.air = 4800;
}
    // rust: _ => {}
}
}
/// Pre-tick updates (Pufferfish.tick puff state).
pub fn tick(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.species() != Species::Pufferfish || !m.alive() {
    // rust: return;
}
    // rust: let puff = m.extra.size;
    // rust: if m.extra.counter > 0 {
    // rust: if puff == 0 {
    // rust: m.sound("entity.puffer_fish.blow_up", events);
    // rust: m.extra.size = 1;
    // rust: } else if m.extra.counter > 40 && puff == 1 {
    // rust: m.sound("entity.puffer_fish.blow_up", events);
    // rust: m.extra.size = 2;
}
    // rust: m.extra.counter += 1;
    // rust: } else if puff != 0 {
    // rust: if m.extra.counter2 > 60 && puff == 2 {
    // rust: m.sound("entity.puffer_fish.blow_out", events);
    // rust: m.extra.size = 1;
    // rust: } else if m.extra.counter2 > 100 && puff == 1 {
    // rust: m.sound("entity.puffer_fish.blow_out", events);
    // rust: m.extra.size = 0;
}
    // rust: m.extra.counter2 += 1;
}
}
/// Pufferfish.getScale by puff state (the dimensions scale with it).
/// `Salmon.Variant.boundingBoxScale`: SMALL 0.5, MEDIUM 1.0, LARGE 1.5.
pub fn salmon_scale(variant: u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match variant {
    // rust: 0 => 0.5,
    // rust: 2 => 1.5,
    // rust: _ => 1.0,
}
}
pub fn puff_scale(state: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match state {
    // rust: 0 => 0.5,
    // rust: 1 => 0.7,
    // rust: _ => 1.0,
}
}
/// `Tadpole.setAgeLockedData`: a golden dandelion flips the lock, puts the
/// age back to 0 and starts the particle timer (40 ticks).
pub fn set_age_locked_data(m: *mut Mob) void {
}
    // rust: m.extra.age_locked = !m.extra.age_locked;
    // rust: m.extra.age = 0;
    // rust: m.extra.age_lock_particle_timer = 40;
}
/// Species aiStep additions.
pub fn ai_step(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
//     use Species as S;
    // rust: match m.species() {
    // rust: S::Squid => squid_ai_step(m),
    // rust: S::GlowSquid => {
    // rust: squid_ai_step(m);
    // rust: glow_squid_ai_step(m, events);
}
    // rust: S::Tadpole => {
            // Tadpole.aiStep: growing up into a frog after 24000 ticks.
    // rust: if m.extra.age >= 0 && !m.extra.age_locked {
    // rust: m.extra.age += 1;
    // rust: if m.extra.age >= 24_000 && !m.removed {
    // rust: m.removed = true;
                    // Tadpole.ageUp: playSound at its feet, volume 0.15 (not
                    // when silent: Entity.playSound).
    // rust: if !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: events.push(MobEvent::Sound("entity.tadpole.grow_up", at, 0.15, 1.0));
}
                    // `ConversionParams.single(this, false, false)`; the game
                    // finalizes the frog and keeps it persistent.
    // rust: events.push(MobEvent::Convert {
    // rust: from: Box::new(m.clone()),
    // rust: kind: "minecraft:frog",
    // rust: params: super::conversion::Params {
    // rust: keep_equipment: false,
    // rust: preserve_can_pick_up_loot: false,
    // rust: },
    // rust: });
}
}
    // rust: if !m.fluids.in_water && m.on_ground && m.vertical_collision_below {
    // rust: let (a, b) = (m.random.next_float(), m.random.next_float());
    // rust: m.velocity = Vec3::new(
    // rust: m.velocity.x + f64::from((a * 2.0 - 1.0) * 0.05),
    // rust: m.velocity.y + 0.4,
    // rust: m.velocity.z + f64::from((b * 2.0 - 1.0) * 0.05),
    // rust: );
    // rust: m.on_ground = false;
    // rust: m.sound("entity.tadpole.flop", events);
}
            // Tadpole.aiStep: the age lock's particles, after the age.
    // rust: super::ai::make_age_locked_particle(m, events);
}
    // rust: S::Cod | S::Salmon | S::TropicalFish | S::Pufferfish => {
            // AbstractFish.aiStep flops on land (applied before travel next tick).
    // rust: if !m.fluids.in_water && m.on_ground && m.vertical_collision_below {
    // rust: let (a, b) = (m.random.next_float(), m.random.next_float());
    // rust: m.velocity = Vec3::new(
    // rust: m.velocity.x + f64::from((a * 2.0 - 1.0) * 0.05),
    // rust: m.velocity.y + 0.4,
    // rust: m.velocity.z + f64::from((b * 2.0 - 1.0) * 0.05),
    // rust: );
    // rust: m.on_ground = false;
    // rust: let flop = match m.species() {
    // rust: S::Cod => "entity.cod.flop",
    // rust: S::Salmon => "entity.salmon.flop",
    // rust: S::TropicalFish => "entity.tropical_fish.flop",
    // rust: _ => "entity.puffer_fish.flop",
}
    // rust: m.sound(flop, events);
}
    // rust: if m.species() == S::Pufferfish && m.alive() && m.extra.size > 0 {
                // Preserve the existing AI-side audio path. Player damage
                // and poison are dispatched by the player tick, not fish AI.
    // rust: if let Some(p) = &w.player
    // rust: && p.alive
    // rust: && !p.creative
    // rust: && m.bounds()
    // rust: .inflate(Vec3::new(0.3, 0.3, 0.3))
    // rust: .intersects(p.bounds)
    // rust: && m.ai.no_action_time % 10 == 0
    // rust: {
    // rust: m.sound("entity.puffer_fish.sting", events);
}
}
    // rust: if m.species() == S::Pufferfish {
    // rust: sting_touching_mobs(m, w, events);
}
}
    // rust: S::Dolphin => {
            // Dolphin.tick: moisture out of water, hop on land.
    // rust: if m.fluids.in_water || super::ai::in_rain(m, w) {
    // rust: m.extra.counter = 2400;
    // rust: } else {
    // rust: m.extra.counter -= 1;
    // rust: if m.extra.counter <= 0 {
                    // `Dolphin.tick` hurts with `damageSources().dryOut()`: the
                    // death message names dehydration, not drowning.
    // rust: m.damage(1.0, super::Damage::of(super::DamageKind::DryOut));
}
    // rust: if m.on_ground {
    // rust: let (a, b) = (m.random.next_float(), m.random.next_float());
    // rust: m.velocity = Vec3::new(
    // rust: m.velocity.x + f64::from((a * 2.0 - 1.0) * 0.2),
    // rust: m.velocity.y + 0.5,
    // rust: m.velocity.z + f64::from((b * 2.0 - 1.0) * 0.2),
    // rust: );
    // rust: m.yaw = m.random.next_float() * 360.0;
    // rust: m.on_ground = false;
}
}
            // LivingEntity air: dolphins drown underwater and refill instantly in air.
    // rust: if !m.fluids.eye_in_water {
    // rust: m.air = 4800;
}
}
    // rust: _ => {}
}
}

/// `EntityTypeTags.NOT_SCARY_FOR_PUFFERFISH`: the mobs a pufferfish leaves
/// alone, its own kind and the water mobs it shares a tank with.
pub fn not_scary_for_pufferfish(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Cod
    // rust: | Species::Salmon
    // rust: | Species::TropicalFish
    // rust: | Species::Pufferfish
    // rust: | Species::Squid
    // rust: | Species::GlowSquid
    // rust: | Species::Dolphin
    // rust: | Species::Turtle
    // rust: | Species::Guardian
    // rust: | Species::ElderGuardian
    // rust: | Species::Tadpole
    // rust: | Species::Nautilus
    // rust: | Species::ZombieNautilus
    // rust: | Species::SulfurCube
    // rust: )
}

/// `Pufferfish.aiStep` after `AbstractFish.aiStep`: a puffed pufferfish stings
/// every mob that touches it, not only the player. The query is `Mob.class`
/// in its own box inflated by 0.3, filtered by `TARGETING_CONDITIONS` (alive
/// and not `#not_scary_for_pufferfish`; invisibility and line of sight are
/// not tested), and each one takes `Pufferfish.touch`: `doTeamsAllowDamage`,
/// then a `mobAttack` hit for `getPuffState() + 1`. The poison and the sting
/// sound follow a hit that landed, which only the game layer knows.
    // rust: pub(super) fn sting_touching_mobs(m: &mut Mob, w: &MobWorld, events: &mut Vec<MobEvent>) {
    // rust: if !m.alive() || m.extra.size <= 0 {
    // rust: return;
}
    // rust: let area = m.bounds().inflate(Vec3::new(0.3, 0.3, 0.3));
    // rust: let own = w.teams.of(Who::Mob(m.id));
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: let mob_id = m.id;
    // rust: let size = m.extra.size;
    // rust: let amount = 1.0 + size as f32;
    // rust: let poison_ticks = 60 * size;
    // rust: for o in w.others_near(area) {
    // rust: if o.id != mob_id
    // rust: && o.alive
    // rust: && !not_scary_for_pufferfish(o.species)
    // rust: && o.bounds.intersects(area)
    // rust: && crate::scoreboard::teams_allow_damage(own, w.teams.of(Who::Mob(o.id)))
    // rust: {
    // rust: events.push(MobEvent::PufferfishSting {
    // rust: mob: mob_id,
    // rust: target: o.id,
    // rust: amount,
    // rust: source: Damage::mob(mob_id, from),
    // rust: poison_ticks,
    // rust: });
}
}
}

/// Squid.aiStep: tentacle cycle, propulsion and body rotation.
pub fn squid_ai_step(m: *mut Mob) void {
}
    // rust: squid_step(m, false);
}

/// Squid.aiStep also runs on remote entities: animate from packet velocity,
/// without running goals or replacing that velocity with the server's movement vector.
/// A glow squid's own `aiStep` follows it (the dark timer and the glow).
pub fn squid_client_step(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if matches!(m.species(), Species::Squid | Species::GlowSquid) {
    // rust: m.anim.vo = m.anim.v;
    // rust: squid_step(m, true);
}
    // rust: if m.species() == Species::GlowSquid {
    // rust: glow_squid_ai_step(m, events);
}
}

/// `GlowSquid.getDarkTicksRemaining`: `DATA_DARK_TICKS_REMAINING`, the ticks
/// left of the dimming a hit gave (kept in `extra.counter`).
pub fn dark_ticks(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.counter
}

/// `GlowSquid.setDarkTicks`: a server sends it to its clients as synched data.
pub fn set_dark_ticks(m: *mut Mob, ticks: i32) void {
}
    // rust: m.extra.counter = ticks;
}

/// `GlowSquid.hurtServer`: a hit that went through dims the squid for 100
/// ticks (called after `Squid.hurtServer`'s ink).
pub fn hurt_server(m: *mut Mob) void {
}
    // rust: set_dark_ticks(m, 100);
}

/// `GlowSquid.aiStep` after `super.aiStep()`: the dark timer counts down, and
/// a `glow` particle appears at `getRandomX(0.6)`, `getRandomY()`,
/// `getRandomZ(0.6)` (drawn in that order). A window that simulates the world
/// and a client of a server both draw it, so the server's own `ai_step` pushes
/// the event as well (as the nautilus bubbles do).
pub fn glow_squid_ai_step(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let ticks = dark_ticks(m);
    // rust: if ticks > 0 {
    // rust: set_dark_ticks(m, ticks - 1);
}
    // rust: let (w, h) = (f64::from(m.width()), f64::from(m.height()));
    // rust: let r = &mut m.random;
    // rust: let x = m.position.x + w * ((2.0 * r.next_double() - 1.0) * 0.6);
    // rust: let y = m.position.y + h * r.next_double();
    // rust: let z = m.position.z + w * ((2.0 * r.next_double() - 1.0) * 0.6);
    // rust: events.push(MobEvent::ParticleAt {
    // rust: kind: ParticleType::Glow.name(),
    // rust: at: [x, y, z],
    // rust: velocity: [0.0; 3],
    // rust: });
}

/// `GlowSquidRenderer.getBlockLightLevel`: the block light a glow squid is
/// drawn with, `lit` being what `EntityRenderer.getBlockLightLevel` gives (15
/// when on fire). It glows brighter the fewer dark ticks are left.
pub fn glow_squid_block_light(m: *Mob, lit: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // Mth.clampedLerp(1.0F - darkTicks / 10.0F, 0.0F, 15.0F).
    // rust: let factor = 1.0f32 - dark_ticks(m) as f32 / 10.0;
    // rust: let glow = if factor < 0.0 {
    // rust: 0
    // rust: } else if factor > 1.0 {
    // rust: 15
    // rust: } else {
    // rust: (factor * 15.0) as u32
}
    // rust: if glow == 15 { 15 } else { glow.max(lit) }
}

/// Squid.handleEntityEvent(19): begin the next server-synchronised tentacle cycle.
pub fn squid_cycle_event(m: *mut Mob) void {
}
    // rust: if matches!(m.species(), Species::Squid | Species::GlowSquid) {
    // rust: m.anim.v[TENTACLE_MOVEMENT] = 0.0;
}
}

pub fn squid_step(m: *mut Mob, client: bool) void {
}
    // rust: let v = &mut m.anim.v;
    // rust: v[TENTACLE_MOVEMENT] += v[TENTACLE_SPEED];
    // rust: if f64::from(v[TENTACLE_MOVEMENT]) > std::f64::consts::TAU {
    // rust: if client {
    // rust: v[TENTACLE_MOVEMENT] = PI * 2.0;
    // rust: } else {
    // rust: v[TENTACLE_MOVEMENT] -= PI * 2.0;
    // rust: if m.random.next_int_bound(10).unwrap_or(1) == 0 {
    // rust: m.anim.v[TENTACLE_SPEED] = 1.0 / (m.random.next_float() + 1.0) * 0.2;
}
    // rust: m.outbox.push(MobEvent::SquidCycle {
    // rust: mob: m.id,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}
}
    // rust: let v = &mut m.anim.v;
    // rust: if m.fluids.in_water {
    // rust: if v[TENTACLE_MOVEMENT] < PI {
    // rust: let scale = v[TENTACLE_MOVEMENT] / PI;
    // rust: v[TENTACLE_ANGLE] = (scale * scale * PI).msin() * PI * 0.25;
    // rust: if scale > 0.75 {
    // rust: if !client {
    // rust: let mv = m.extra.vector;
    // rust: m.velocity = Vec3::new(mv[0], mv[1], mv[2]);
}
    // rust: m.anim.v[ROTATE_SPEED] = 1.0;
    // rust: } else {
    // rust: m.anim.v[ROTATE_SPEED] *= 0.8;
}
    // rust: } else {
    // rust: v[TENTACLE_ANGLE] = 0.0;
    // rust: if !client {
    // rust: m.velocity = Vec3::new(m.velocity.x * 0.9, m.velocity.y * 0.9, m.velocity.z * 0.9);
}
    // rust: m.anim.v[ROTATE_SPEED] *= 0.99;
}
    // rust: let mv = m.velocity;
    // rust: let horizontal = (mv.x * mv.x + mv.z * mv.z).sqrt();
    // rust: m.body_yaw += (-(horizon_core::geometry::trig::atan2(mv.x, mv.z) as f32) * 57.295776
    // rust: - m.body_yaw)
    // rust: * 0.1;
    // rust: m.yaw = m.body_yaw;
    // rust: let v = &mut m.anim.v;
    // rust: v[Z_BODY_ROT] += PI * v[ROTATE_SPEED] * 1.5;
    // rust: v[X_BODY_ROT] += (-(horizon_core::geometry::trig::atan2(horizontal, mv.y) as f32)
    // rust: * 57.295776
    // rust: - v[X_BODY_ROT])
    // rust: * 0.1;
    // rust: } else {
    // rust: v[TENTACLE_ANGLE] = v[TENTACLE_MOVEMENT].msin().abs() * PI * 0.25;
    // rust: if !client {
    // rust: let yd = m.velocity.y - m.kind.gravity;
    // rust: m.velocity = Vec3::new(0.0, yd * 0.98, 0.0);
}
    // rust: let v = &mut m.anim.v;
    // rust: v[X_BODY_ROT] += (-90.0 - v[X_BODY_ROT]) * 0.02;
}
}
/// Species travel overrides. Returns true when handled.
pub fn travel(m: *mut Mob, w: *MobWorld, input: Vec3, events: *mut std.ArrayList(MobEvent)) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: match m.species() {
        // Squid.travel: move by the current velocity only.
    // rust: S::Squid | S::GlowSquid => {
    // rust: m.do_move(w, events);
    // rust: true
}
        // Axolotl.travelInWater: no fish sinking or generic water gravity.
    // rust: S::Axolotl if m.fluids.in_water => {
    // rust: m.move_relative(m.ai.speed, input);
    // rust: m.do_move(w, events);
    // rust: m.velocity = Vec3::new(m.velocity.x * 0.9, m.velocity.y * 0.9, m.velocity.z * 0.9);
    // rust: true
}
        // AbstractFish.travelInWater / Dolphin.travelInWater.
    // rust: S::Cod | S::Salmon | S::TropicalFish | S::Pufferfish | S::Tadpole | S::Dolphin
    // rust: if m.fluids.in_water =>
    // rust: {
    // rust: let speed = if m.species() == S::Dolphin {
    // rust: m.ai.speed
    // rust: } else {
    // rust: 0.01
}
    // rust: m.move_relative(speed, input);
    // rust: m.do_move(w, events);
    // rust: m.velocity = Vec3::new(m.velocity.x * 0.9, m.velocity.y * 0.9, m.velocity.z * 0.9);
    // rust: if m.ai.target.is_none() {
                // `Vec3.add(0.0, -0.005, 0.0)`: adding 0.0 turns a -0.0 into 0.0.
    // rust: m.velocity =
    // rust: Vec3::new(m.velocity.x + 0.0, m.velocity.y - 0.005, m.velocity.z + 0.0);
}
    // rust: true
}
    // rust: _ => false,
}
}
/// FishMoveControl.tick (fish use it instead of the default move control).
pub fn fish_move_control(m: *mut Mob) void {
}
    // rust: if !matches!(
    // rust: m.species(),
    // rust: Species::Cod | Species::Salmon | Species::TropicalFish | Species::Pufferfish
    // rust: ) {
    // rust: return;
}
    // rust: if m.fluids.eye_in_water {
    // rust: m.velocity.y += 0.005;
}
    // rust: if m.ai.mov.operation == super::control::Operation::MoveTo && !m.ai.nav.is_done() {
    // rust: let target = (m.ai.mov.speed_modifier * m.movement_speed()) as f32;
    // rust: let speed = m.ai.speed + (target - m.ai.speed) * 0.125;
    // rust: m.set_speed(speed);
    // rust: let [wx, wy, wz] = m.ai.mov.wanted;
    // rust: let (xd, yd, zd) = (wx - m.position.x, wy - m.position.y, wz - m.position.z);
    // rust: if yd != 0.0 {
    // rust: let dd = (xd * xd + yd * yd + zd * zd).sqrt();
    // rust: m.velocity.y += f64::from(m.ai.speed) * (yd / dd) * 0.1;
}
    // rust: if xd != 0.0 || zd != 0.0 {
    // rust: let y_rot = horizon_core::geometry::trig::atan2_degrees(zd, xd) - 90.0;
    // rust: m.yaw = super::control::rotlerp(m.yaw, y_rot, 90.0);
    // rust: m.body_yaw = m.yaw;
}
    // rust: } else {
    // rust: m.set_speed(0.0);
}
}
/// Squid.SquidRandomMovementGoal
pub const SquidRandomMovement = struct {};
    // rust: impl Goal for SquidRandomMovement {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn can_use(self: *Self, _: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: if m.ai.no_action_time > 100 {
    // rust: m.extra.vector = [0.0; 3];
    // rust: } else if m
    // rust: .random
    // rust: .next_int_bound(super::goals::reduced(50))
    // rust: .unwrap_or(1)
    // rust: == 0
    // rust: || !m.fluids.in_water
    // rust: || m.extra.vector == [0.0; 3]
    // rust: {
    // rust: let angle = m.random.next_float() * PI * 2.0;
    // rust: let y = -0.1 + m.random.next_float() * 0.2;
    // rust: m.extra.vector = [
    // rust: f64::from(angle.mcos() * 0.2),
    // rust: f64::from(y),
    // rust: f64::from(angle.msin() * 0.2),
    // rust: ];
}
}
}
/// Squid.SquidFleeGoal (keeps vanilla's discarded normalize()).
pub const SquidFlee = struct {
    ticks: i32,
};
    // rust: impl Goal for SquidFlee {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(by) = m.ai.last_hurt_by.and_then(|w| cx.w.target_info(w)) else {
    // rust: return false;
}
    // rust: m.fluids.in_water && m.distance_sqr(by.position) < 100.0
}
pub fn start(self: *Self, _: *mut Mob, _: *mut Cx) void {
}
    // rust: self.ticks = 0;
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.ticks += 1;
    // rust: let Some(by) = m.ai.last_hurt_by.and_then(|w| cx.w.target_info(w)) else {
    // rust: return;
}
    // rust: let mut f = [
    // rust: m.position.x - by.position.x,
    // rust: m.position.y - by.position.y,
    // rust: m.position.z - by.position.z,
    // rust: ];
    // rust: let at = [
    // rust: (m.position.x + f[0]).floor() as i32,
    // rust: (m.position.y + f[1]).floor() as i32,
    // rust: (m.position.z + f[2]).floor() as i32,
    // rust: ];
    // rust: let air = cx.w.facts.is_air(cx.w.world.block(at[0], at[1], at[2]));
    // rust: if cx.w.fluid(at[0], at[1], at[2]) == Fluid::Water || air {
    // rust: let length = (f[0] * f[0] + f[1] * f[1] + f[2] * f[2]).sqrt();
    // rust: if length > 0.0 {
    // rust: let mut avoid = 3.0;
    // rust: if length > 5.0 {
    // rust: avoid -= (length - 5.0) / 5.0;
}
    // rust: if avoid > 0.0 {
    // rust: f = f.map(|c| c * avoid);
}
}
    // rust: if air {
    // rust: f[1] = 0.0;
}
    // rust: m.extra.vector = [f[0] / 20.0, f[1] / 20.0, f[2] / 20.0];
}
}
}
/// `AbstractSchoolingFish`: cod, salmon and tropical fish.
pub fn schooling(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(s, Species::Cod | Species::Salmon | Species::TropicalFish)
}
/// `getMaxSchoolSize`: `AbstractFish.getMaxSpawnClusterSize` (8), a salmon's
/// own 5.
pub fn max_school_size(s: Species) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if s == Species::Salmon { 5 } else { 8 }
}
/// `isFollower`: its leader is alive.
pub fn follows(w: *MobWorld, leader: ?u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: leader.and_then(|l| w.seen(l)).is_some_and(|s| s.alive)
}
/// `canBeFollowed`: it has followers and room for more.
pub fn can_be_followed(s: Species, followers: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: followers > 0 && followers + 1 < max_school_size(s)
}
/// `startFollowing` on a recruit, applied after the recruiter's tick. A fish
/// another leader took this tick (its snapshot was older) stays with it.
pub fn start_following(mobs: *mut [Mob], fish: u32, leader: u32) void {
}
    // rust: let alive = |mobs: &[Mob], id: u32| mobs.iter().any(|m| m.id == id && m.alive() && !m.removed);
    // rust: let Some(current) = mobs.iter().find(|m| m.id == fish).map(|m| m.extra.leader) else {
    // rust: return;
}
    // rust: if current.is_some_and(|l| alive(mobs, l)) {
    // rust: return;
}
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == fish) {
    // rust: m.extra.leader = Some(leader);
}
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == leader) {
    // rust: m.extra.followers += 1;
}
}
/// `AbstractSchoolingFish.tick`: a leader with no fish of its kind within 8
/// forgets its school, checked once in 200 ticks on the level's random.
pub fn school_tick(m: *mut Mob, w: *MobWorld, level_random: *mut impl RandomSource) void {
}
    // rust: if !schooling(m.species()) || m.extra.followers <= 0 {
    // rust: return;
}
    // rust: if level_random.next_int_bound(200).unwrap_or(0) == 1 {
    // rust: let area = m.bounds().inflate(Vec3::new(8.0, 8.0, 8.0));
    // rust: let species = m.species();
    // rust: let others = w
    // rust: .others_near(area)
    // rust: .filter(|s| {
    // rust: s.id != m.id && s.species == species && s.alive && s.bounds.intersects(area)
    // rust: })
    // rust: .count();
    // rust: if others == 0 {
    // rust: m.extra.followers = 0;
}
}
}
/// `AbstractFish.FishSwimGoal`: random swimming, which a schooling fish
/// that follows a leader leaves (`canRandomSwim`).
pub const FishSwim = struct {};
    // rust: impl Goal for FishSwim {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "FishSwimGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.flags()
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if schooling(m.species()) && follows(cx.w, m.extra.leader) {
    // rust: return false;
}
    // rust: self.0.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.can_continue(m, cx)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx);
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.stop(m, cx);
}
}
/// `FollowFlockLeaderGoal`: a fish with no school, every ten seconds or so,
/// joins a school nearby that has room, or gathers the fish around it that
/// follow no one into a school of its own; a follower swims after its
/// leader while it is within 11 blocks.
pub const FollowFlockLeader = struct {
    next_start: i32,
    recalc: i32,
};
    // rust: impl FollowFlockLeader {
pub fn new(next_start: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: next_start,
    // rust: recalc: 0,
}
}
    /// `nextStartTick`, on the fish's random.
pub fn next_start_tick(m: *mut Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: reduced(200 + m.random.next_int_bound(200).unwrap_or(0) % 20)
}
}
    // rust: impl Goal for FollowFlockLeader {
    // rust: goal_clone!();
pub fn set_start_delay(self: *Self, ticks: i32) void {
}
    // rust: self.next_start = ticks;
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "FollowFlockLeaderGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.extra.followers > 0 {
    // rust: return false;
}
    // rust: if follows(cx.w, m.extra.leader) {
    // rust: return true;
}
    // rust: if self.next_start > 0 {
    // rust: self.next_start -= 1;
    // rust: return false;
}
    // rust: self.next_start = Self::next_start_tick(m);
        // The fish of its kind around it that lead a school with room or
        // follow no one, in level order; itself as it is now.
    // rust: let species = m.species();
    // rust: let area = m.bounds().inflate(Vec3::new(8.0, 8.0, 8.0));
    // rust: let mut near: Vec<&crate::mobs::Seen> =
    // rust: cx.w.others_near(area)
    // rust: .filter(|s| s.species == species && s.alive && s.bounds.intersects(area))
    // rust: .collect();
        // `getEntitiesOfClass`: the sections by x, z, y; in each, as they entered it.
    // rust: near.sort_by_key(|s| (s.section.0[0], s.section.0[2], s.section.0[1], s.section.1));
    // rust: let candidates: Vec<(u32, Option<u32>, i32)> = near
    // rust: .into_iter()
    // rust: .map(|s| {
    // rust: if s.id == m.id {
    // rust: (s.id, m.extra.leader, m.extra.followers)
    // rust: } else {
    // rust: (s.id, s.school.0, s.school.1)
}
    // rust: })
    // rust: .filter(|&(_, leader, followers)| {
    // rust: can_be_followed(species, followers) || !follows(cx.w, leader)
    // rust: })
    // rust: .collect();
    // rust: let (leader, school_size) = candidates
    // rust: .iter()
    // rust: .find(|c| can_be_followed(species, c.2))
    // rust: .map_or((m.id, m.extra.followers + 1), |c| (c.0, c.2 + 1));
        // addFollowers: the limit counts the leader before it is skipped.
    // rust: let room = (max_school_size(species) - school_size).max(0) as usize;
    // rust: for &(id, ..) in candidates
    // rust: .iter()
    // rust: .filter(|c| !follows(cx.w, c.1))
    // rust: .take(room)
    // rust: .filter(|c| c.0 != leader)
    // rust: {
    // rust: if id == m.id {
    // rust: m.extra.leader = Some(leader);
    // rust: cx.events.push(MobEvent::SchoolSize { leader, by: 1 });
    // rust: } else {
    // rust: cx.events
    // rust: .push(MobEvent::StartFollowing { fish: id, leader });
}
}
    // rust: follows(cx.w, m.extra.leader)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra
    // rust: .leader
    // rust: .and_then(|l| cx.w.seen(l))
    // rust: .is_some_and(|l| l.alive && m.distance_sqr(l.position) <= 121.0)
}
pub fn start(self: *Self, _: *mut Mob, _: *mut Cx) void {
}
    // rust: self.recalc = 0;
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(leader) = m.extra.leader.take() {
    // rust: cx.events.push(MobEvent::SchoolSize { leader, by: -1 });
}
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.recalc -= 1;
    // rust: if self.recalc > 0 {
    // rust: return;
}
    // rust: self.recalc = reduced(10);
        // pathToLeader
    // rust: if let Some(l) = m
    // rust: .extra
    // rust: .leader
    // rust: .and_then(|l| cx.w.seen(l))
    // rust: .filter(|l| l.alive)
    // rust: {
    // rust: let at = [l.position.x, l.position.y, l.position.z];
    // rust: m.nav_move_to_entity(cx.w, at, 1, 1.0);
}
}
}
/// Pufferfish.PufferfishPuffGoal: inflate when a mob or player is within 2.
pub const PufferfishPuff = struct {};
    // rust: impl Goal for PufferfishPuff {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let area = m.bounds().inflate(Vec3::new(2.0, 2.0, 2.0));
    // rust: let player =
    // rust: cx.w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.alive && !p.creative && area.intersects(p.bounds));
        // TARGETING_CONDITIONS: not #not_scary_for_pufferfish, and alive.
    // rust: let mob = cx.w.others_near(area).any(|s| {
    // rust: s.id != m.id
    // rust: && s.alive
    // rust: && !not_scary_for_pufferfish(s.species)
    // rust: && area.intersects(s.bounds)
    // rust: });
    // rust: player || mob
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.extra.counter = 1;
    // rust: m.extra.counter2 = 0;
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.extra.counter = 0;
}
}
/// finalizeSpawn variants (tropical fish patterns and colours).
/// TropicalFish.COMMON_VARIANTS: (pattern index, base colour, pattern colour).
    // rust: pub const COMMON_TROPICAL: [(u8, u8, u8); 22] = [
    // rust: (7, 1, 7),
    // rust: (6, 7, 7),
    // rust: (6, 7, 11),
    // rust: (11, 0, 7),
    // rust: (1, 11, 7),
    // rust: (0, 1, 0),
    // rust: (5, 6, 3),
    // rust: (9, 10, 4),
    // rust: (11, 0, 14),
    // rust: (5, 0, 4),
    // rust: (8, 0, 7),
    // rust: (11, 0, 1),
    // rust: (3, 9, 6),
    // rust: (4, 5, 3),
    // rust: (10, 14, 0),
    // rust: (2, 7, 14),
    // rust: (9, 14, 0),
    // rust: (6, 0, 4),
    // rust: (0, 14, 0),
    // rust: (1, 7, 0),
    // rust: (3, 9, 4),
    // rust: (6, 4, 4),
    // rust: ];
pub fn finalize(m: *mut Mob) void {
}
    // rust: if m.species() == Species::TropicalFish {
    // rust: let (p, b, c) = if m.random.next_float() < 0.9 {
    // rust: COMMON_TROPICAL[m
    // rust: .random
    // rust: .next_int_bound(COMMON_TROPICAL.len() as i32)
    // rust: .unwrap_or(0) as usize]
    // rust: } else {
    // rust: (
    // rust: m.random.next_int_bound(12).unwrap_or(0) as u8,
    // rust: m.random.next_int_bound(16).unwrap_or(0) as u8,
    // rust: m.random.next_int_bound(16).unwrap_or(0) as u8,
    // rust: )
}
    // rust: m.extra.variant = p;
    // rust: m.extra.variant2 = b;
    // rust: m.extra.variant3 = c;
}
}
/// Model animation for the water mobs.
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
//     use Species as S;
    // rust: let amp = if m.fluids.in_water { 1.0 } else { 1.5 };
    // rust: match m.species() {
    // rust: S::Squid | S::GlowSquid => {
    // rust: let angle = m.anim.lerp(TENTACLE_ANGLE, s.partial);
    // rust: for i in 0..8 {
    // rust: p.xrot(&format!("tentacle{i}"), angle);
}
}
    // rust: S::Cod => p.yrot("tail_fin", -amp * 0.45 * (0.6 * s.age).msin()),
        // TadpoleModel: a stronger tail swing out of water.
    // rust: S::Tadpole => {
    // rust: let a = if m.fluids.in_water { 1.0 } else { 1.5 };
    // rust: p.yrot("tail", -a * 0.25 * (0.3 * s.age).msin())
}
    // rust: S::TropicalFish => p.yrot("tail", -amp * 0.45 * (0.6 * s.age).msin()),
    // rust: S::Salmon => {
    // rust: let (a, k) = if m.fluids.in_water {
    // rust: (1.0, 1.0)
    // rust: } else {
    // rust: (1.3, 1.7)
}
    // rust: p.yrot("body_back", -a * 0.25 * (k * 0.6 * s.age).msin());
}
    // rust: S::Pufferfish => {
    // rust: let fin = 0.2 - 0.4 * (s.age * 0.2).msin();
    // rust: if p.has("right_blue_fin") {
    // rust: p.zrot("right_blue_fin", -fin);
    // rust: p.zrot("left_blue_fin", fin);
    // rust: } else {
    // rust: p.zrot("right_fin", -fin);
    // rust: p.zrot("left_fin", fin);
}
}
    // rust: S::Dolphin => {
    // rust: p.xrot("body", s.x_rot.to_radians());
    // rust: p.yrot("body", s.y_rot.to_radians());
    // rust: let moving = m.velocity.x * m.velocity.x + m.velocity.z * m.velocity.z > 1.0e-7;
    // rust: if moving {
    // rust: p.get("body")[3] += -0.05 - 0.05 * (s.age * 0.3).mcos();
    // rust: p.xrot("tail", -0.1 * (s.age * 0.3).mcos());
    // rust: p.xrot("tail_fin", -0.2 * (s.age * 0.3).mcos());
}
}
    // rust: _ => {}
}
}
/// Renderer setupRotations for the water mobs (replacing or extending the default).
pub fn rotations(m: *Mob, alpha: f32, body: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: let age = m.age as f32 + alpha;
    // rust: match m.species() {
    // rust: S::Squid | S::GlowSquid => {
    // rust: let baby = m.is_baby();
    // rust: let x = m.anim.lerp(X_BODY_ROT, alpha);
    // rust: let z = m.anim.lerp(Z_BODY_ROT, alpha);
    // rust: Some(
    // rust: glam::Mat4::from_translation(glam::Vec3::new(
    // rust: 0.0,
    // rust: if baby { 0.25 } else { 0.5 },
    // rust: 0.0,
    // rust: )) * glam::Mat4::from_rotation_y((180.0 - body).to_radians())
    // rust: * glam::Mat4::from_rotation_x(x.to_radians())
    // rust: * glam::Mat4::from_rotation_y(z.to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(
    // rust: 0.0,
    // rust: if baby { -0.6 } else { -1.2 },
    // rust: 0.0,
    // rust: )),
    // rust: )
}
    // rust: S::Cod | S::Salmon | S::TropicalFish => {
    // rust: let (a, k) = if m.species() == S::Salmon && !m.fluids.in_water {
    // rust: (1.3, 1.7)
    // rust: } else {
    // rust: (1.0, 1.0)
}
    // rust: let mut t = glam::Mat4::from_rotation_y((180.0 - body).to_radians())
    // rust: * glam::Mat4::from_rotation_y((a * 4.3 * (k * 0.6 * age).msin()).to_radians());
    // rust: if !m.fluids.in_water {
    // rust: let off = if m.species() == S::Cod {
    // rust: glam::Vec3::new(0.1, 0.1, -0.1)
    // rust: } else {
    // rust: glam::Vec3::new(0.2, 0.1, 0.0)
}
    // rust: t *= glam::Mat4::from_translation(off) * glam::Mat4::from_rotation_z(PI / 2.0);
}
    // rust: Some(t)
}
    // rust: S::Pufferfish => Some(
    // rust: glam::Mat4::from_translation(glam::Vec3::new(0.0, (age * 0.05).mcos() * 0.08, 0.0))
    // rust: * glam::Mat4::from_rotation_y((180.0 - body).to_radians()),
    // rust: ),
    // rust: _ => None,
}
}
    // rust: mod school_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use std::sync::Arc;

pub fn cod(id: u32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:cod".into();
    // rust: k.species = Species::Cod;
    // rust: Mob::new(id, kind, Vec3::ZERO, 0.0)
}
    /// `Salmon.getDefaultDimensions` is `getSalmonScale()` applied to the whole
    /// fish box: small 0.5, medium 1.0, large 1.5.
pub fn a_salmon_box_follows_its_variant() void {
}
    // rust: let mut k = kind();
    // rust: Arc::make_mut(&mut k).species = Species::Salmon;
    // rust: let mut m = Mob::new(1, k, Vec3::ZERO, 0.0);
    // rust: m.extra.variant = 1;
    // rust: let (w, h, e) = m.dims();
    // rust: let (bw, bh, be) = (w as f32, h as f32, e as f32);
    // rust: m.extra.variant = 0;
    // rust: assert_eq!(
    // rust: m.dims(),
    // rust: (
    // rust: f64::from(bw * 0.5),
    // rust: f64::from(bh * 0.5),
    // rust: f64::from(be * 0.5)
    // rust: ),
    // rust: "a small salmon is half the medium box"
    // rust: );
    // rust: m.extra.variant = 2;
    // rust: assert_eq!(
    // rust: m.dims(),
    // rust: (
    // rust: f64::from(bw * 1.5),
    // rust: f64::from(bh * 1.5),
    // rust: f64::from(be * 1.5)
    // rust: ),
    // rust: "a large salmon is half again"
    // rust: );
        // The medium variant is the type's box, unchanged.
    // rust: m.extra.variant = 1;
    // rust: assert_eq!(m.dims(), (w, h, e));
        // Salmon.Variant.DEFAULT: a salmon finalizeSpawn never sized is medium.
    // rust: let mut k = kind();
    // rust: Arc::make_mut(&mut k).species = Species::Salmon;
    // rust: assert_eq!(Mob::new(2, k, Vec3::ZERO, 0.0).dims(), (w, h, e));
}
    /// `Squid.spawnInk`: 30 `sendParticles` calls with a count of 0 and a
    /// speed of 0.1, so the server sends them (the clients scale the offset
    /// by the speed). A client-only `ParticleAt` would never leave the server.
pub fn a_squid_sends_its_ink_as_server_particles() void {
}
    // rust: let mut k = kind();
    // rust: let k2 = Arc::make_mut(&mut k);
    // rust: k2.id = "minecraft:squid".into();
    // rust: k2.species = Species::Squid;
    // rust: let mut m = Mob::new(1, k, Vec3::new(0.0, 60.0, 0.0), 0.0);
    // rust: m.silent = true;
    // rust: spawn_ink(&mut m);
    // rust: let ink: Vec<_> = m
    // rust: .outbox
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::LevelParticles {
    // rust: kind: "squid_ink",
    // rust: spread,
    // rust: speed,
    // rust: count: 0,
    // rust: ..
    // rust: } => Some((*spread, *speed)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(ink.len(), 30);
    // rust: assert!(ink.iter().all(|(_, speed)| *speed == f64::from(0.1f32)));
        // The offset is the unscaled direction: `0.3 + nextFloat * 2` long
        // for an adult, mostly downward, never already multiplied by 0.1.
    // rust: assert!(ink.iter().any(|(d, _)| d[1] < -0.3));
    // rust: assert!(
    // rust: !m.outbox
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::ParticleAt { .. }))
    // rust: );
}
pub fn school_sizes() void {
}
    // rust: assert_eq!(max_school_size(Species::Cod), 8);
    // rust: assert_eq!(max_school_size(Species::TropicalFish), 8);
    // rust: assert_eq!(max_school_size(Species::Salmon), 5);
        // canBeFollowed: followers and room (schoolSize below the maximum).
    // rust: assert!(!can_be_followed(Species::Cod, 0));
    // rust: assert!(can_be_followed(Species::Cod, 6));
    // rust: assert!(!can_be_followed(Species::Cod, 7));
    // rust: assert!(!can_be_followed(Species::Salmon, 4));
}
pub fn a_recruit_another_leader_took_stays_with_it() void {
}
    // rust: let mut mobs = vec![cod(1), cod(2), cod(3)];
    // rust: start_following(&mut mobs, 3, 1);
    // rust: assert_eq!(mobs[2].extra.leader, Some(1));
    // rust: assert_eq!(mobs[0].extra.followers, 1);
    // rust: start_following(&mut mobs, 3, 2);
    // rust: assert_eq!(mobs[2].extra.leader, Some(1));
    // rust: assert_eq!(mobs[1].extra.followers, 0);
        // A dead leader's follower is free again.
    // rust: mobs[0].health = 0.0;
    // rust: start_following(&mut mobs, 3, 2);
    // rust: assert_eq!(mobs[2].extra.leader, Some(2));
    // rust: assert_eq!(mobs[1].extra.followers, 1);
}
pub fn schooling_fish_draw_their_start_delay() void {
}
    // rust: let mut m = cod(1);
    // rust: let start = FollowFlockLeader::next_start_tick(&mut m);
    // rust: assert!((100..=110).contains(&start));
}
}

    // rust: mod pufferfish_sting_tests {
//     use super::*;
//     use crate::mobs::apply_brain_events;
//     use crate::mobs::world::with_test_world;
//     use horizon_core::random::LegacyRandom;
//     use std::sync::Arc;

pub fn mob_tick_dispatches_puffed_contacts_with_or_without_ai() void {
}
    // rust: with_test_world(&[], |w, types| {
    // rust: let target = Mob::new(
    // rust: 2,
    // rust: Arc::new(types.types["minecraft:pig"].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: let others = [target.seen(None)];
    // rust: let world = MobWorld {
    // rust: others: &others,
    // rust: ..w.clone()
}
    // rust: for no_ai in [true, false] {
    // rust: for puff in [0, 2] {
    // rust: let mut fish = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:pufferfish"].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: fish.no_ai = no_ai;
    // rust: fish.no_gravity = true;
    // rust: fish.persistent = true;
    // rust: fish.extra.size = puff;
    // rust: let mut events = Vec::new();
    // rust: assert!(fish.tick(&world, &mut LegacyRandom::new(0), &mut events));
    // rust: let stings: Vec<_> = events
    // rust: .iter()
    // rust: .filter_map(|event| match event {
    // rust: MobEvent::PufferfishSting {
    // rust: target,
    // rust: amount,
    // rust: source,
    // rust: poison_ticks,
    // rust: ..
    // rust: } => Some((*target, *amount, *poison_ticks, source.attacker)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let expected = if puff == 2 {
    // rust: vec![(2, 3.0, 120, Some(Who::Mob(1)))]
    // rust: } else {
    // rust: Vec::new()
}
    // rust: assert_eq!(stings, expected, "NoAI={no_ai}, puff={puff}");
}
}
    // rust: });
}

    /// What a pufferfish puffed to `puff` stings in one `ai_step`, as
    /// `(target, damage)`, with `others` standing `x` blocks east of it.
pub fn stings(puff: i32, others: *[([]const u8) void {
}
    // rust: let mut built = None;
    // rust: with_test_world(&[], |_, types| {
    // rust: let mob = |id: u32, name: &str, at: Vec3| {
    // rust: Mob::new(id, Arc::new(types.types[name].clone()), at, 0.0)
}
    // rust: let mut fish = mob(1, "minecraft:pufferfish", Vec3::new(0.5, 64.0, 0.5));
    // rust: fish.extra.size = puff;
    // rust: let seen: Vec<_> = others
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, (name, x))| {
    // rust: mob(i as u32 + 2, name, Vec3::new(0.5 + x, 64.0, 0.5)).seen(None)
    // rust: })
    // rust: .collect();
    // rust: built = Some((fish, seen));
    // rust: });
    // rust: let (mut fish, seen) = built?;
    // rust: let mut events = Vec::new();
    // rust: with_test_world(&seen, |w, _| ai_step(&mut fish, w, &mut events));
    // rust: Some(
    // rust: events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::PufferfishSting {
    // rust: mob: 1,
    // rust: target,
    // rust: amount,
    // rust: source,
    // rust: poison_ticks,
    // rust: } => {
    // rust: assert_eq!(source.attacker, Some(Who::Mob(1)));
    // rust: assert_eq!(
    // rust: *poison_ticks,
    // rust: 60 * puff,
    // rust: "Pufferfish.touch's POISON lasts 60 * getPuffState()"
    // rust: );
    // rust: Some((*target, *amount))
}
    // rust: _ => None,
    // rust: })
    // rust: .collect(),
    // rust: )
}

    /// `Pufferfish.aiStep`: a puffed pufferfish stings every mob whose box
    /// meets its own (inflated by 0.3), not only the player, for
    /// `getPuffState() + 1`.
pub fn a_puffed_pufferfish_stings_the_mobs_that_touch_it() void {
}
    // rust: let Some(half) = stings(1, &[("minecraft:zombie", 0.5)]) else {
    // rust: return;
}
    // rust: assert_eq!(half, vec![(2, 2.0)], "puff state 1 stings for 1 + 1");
    // rust: let full = stings(2, &[("minecraft:zombie", 0.5)]).unwrap();
    // rust: assert_eq!(full, vec![(2, 3.0)], "puff state 2 stings for 1 + 2");
    // rust: assert!(
    // rust: stings(0, &[("minecraft:zombie", 0.5)]).unwrap().is_empty(),
    // rust: "a deflated pufferfish stings nobody"
    // rust: );
    // rust: assert!(
    // rust: stings(2, &[("minecraft:zombie", 1.5)]).unwrap().is_empty(),
    // rust: "a zombie a block away never touches it"
    // rust: );
        // `#not_scary_for_pufferfish`: its tank mates are left alone.
    // rust: assert!(
    // rust: stings(2, &[("minecraft:cod", 0.4), ("minecraft:squid", 0.3)])
    // rust: .unwrap()
    // rust: .is_empty(),
    // rust: "a cod and a squid are not scary"
    // rust: );
}

pub fn pufferfish_sting_parity_scenarios() void {
}
    // rust: with_test_world(&[], |w, types| {
    // rust: let make_mob = |id: u32, name: &str, at: Vec3| {
    // rust: Mob::new(id, Arc::new(types.types[name].clone()), at, 0.0)
}

            // Scenario 1: Default/legacy behavior
            // Deflated pufferfish (PuffState: 0), cod, or separated mob do not get stung or poisoned.
    // rust: {
    // rust: let mut deflated = make_mob(1, "minecraft:pufferfish", Vec3::new(0.5, 64.0, 0.5));
    // rust: deflated.extra.size = 0;
    // rust: let pig = make_mob(2, "minecraft:pig", Vec3::new(0.5, 64.0, 0.5));
    // rust: let seen = [pig.seen(None)];
    // rust: let world = MobWorld {
    // rust: others: &seen,
    // rust: ..w.clone()
}
    // rust: let mut events = Vec::new();
    // rust: deflated.tick(&world, &mut LegacyRandom::new(0), &mut events);
    // rust: assert!(
    // rust: !events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::PufferfishSting { .. })),
    // rust: "deflated pufferfish should not emit sting events"
    // rust: );

    // rust: let mut cod = make_mob(3, "minecraft:cod", Vec3::new(0.5, 64.0, 0.5));
    // rust: let mut events = Vec::new();
    // rust: cod.tick(&world, &mut LegacyRandom::new(0), &mut events);
    // rust: assert!(
    // rust: !events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::PufferfishSting { .. })),
    // rust: "cod should not emit sting events"
    // rust: );

    // rust: let mut fish = make_mob(4, "minecraft:pufferfish", Vec3::new(0.5, 64.0, 0.5));
    // rust: fish.extra.size = 2;
    // rust: let far_pig = make_mob(5, "minecraft:pig", Vec3::new(5.0, 64.0, 5.0));
    // rust: let seen_far = [far_pig.seen(None)];
    // rust: let world_far = MobWorld {
    // rust: others: &seen_far,
    // rust: ..w.clone()
}
    // rust: let mut events = Vec::new();
    // rust: fish.tick(&world_far, &mut LegacyRandom::new(0), &mut events);
    // rust: assert!(
    // rust: !events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::PufferfishSting { .. })),
    // rust: "separated mob should not be stung"
    // rust: );
}

            // Scenario 2: Negative cases (invulnerable mob or cooldown mob)
    // rust: {
                // Invulnerable mob
    // rust: let mut fish = make_mob(1, "minecraft:pufferfish", Vec3::new(0.5, 64.0, 0.5));
    // rust: fish.extra.size = 2;
    // rust: let mut invuln_pig = make_mob(2, "minecraft:pig", Vec3::new(0.5, 64.0, 0.5));
    // rust: invuln_pig.invulnerable_flag = true;
    // rust: let seen = [invuln_pig.seen(None)];
    // rust: let world = MobWorld {
    // rust: others: &seen,
    // rust: ..w.clone()
}
    // rust: let mut events = Vec::new();
    // rust: fish.tick(&world, &mut LegacyRandom::new(0), &mut events);
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::PufferfishSting { .. }))
    // rust: );
    // rust: let mut mobs = vec![fish, invuln_pig];
    // rust: apply_brain_events(&mut mobs, &mut events, 0);
    // rust: assert_eq!(mobs[1].health, 10.0, "invulnerable mob takes no damage");
    // rust: assert!(
    // rust: mobs[1].extra.effects.is_empty(),
    // rust: "invulnerable mob receives no poison"
    // rust: );
    // rust: assert!(
    // rust: !events.iter().any(
    // rust: |e| matches!(e, MobEvent::Sound(s, ..) if *s == "entity.puffer_fish.sting")
    // rust: ),
    // rust: "no sting sound when hit refused"
    // rust: );

                // Cooldown mob (already in invulnerability timer with higher or equal last_hurt)
    // rust: let mut fish = make_mob(1, "minecraft:pufferfish", Vec3::new(0.5, 64.0, 0.5));
    // rust: fish.extra.size = 2;
    // rust: let mut cooldown_pig = make_mob(2, "minecraft:pig", Vec3::new(0.5, 64.0, 0.5));
    // rust: cooldown_pig.invulnerable = 20;
    // rust: cooldown_pig.last_hurt = 3.0; // Pufferfish deals 1 + 2 = 3.0 <= 3.0
    // rust: let seen = [cooldown_pig.seen(None)];
    // rust: let world = MobWorld {
    // rust: others: &seen,
    // rust: ..w.clone()
}
    // rust: let mut events = Vec::new();
    // rust: fish.tick(&world, &mut LegacyRandom::new(0), &mut events);
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::PufferfishSting { .. }))
    // rust: );
    // rust: let mut mobs = vec![fish, cooldown_pig];
    // rust: apply_brain_events(&mut mobs, &mut events, 0);
    // rust: assert_eq!(mobs[1].health, 10.0, "cooldown mob takes no damage");
    // rust: assert!(
    // rust: mobs[1].extra.effects.is_empty(),
    // rust: "cooldown mob receives no poison"
    // rust: );
    // rust: assert!(
    // rust: !events.iter().any(
    // rust: |e| matches!(e, MobEvent::Sound(s, ..) if *s == "entity.puffer_fish.sting")
    // rust: ),
    // rust: "no sting sound on cooldown"
    // rust: );
}

            // Scenario 3: Positive case: touching mob gets stung, takes damage puff_state + 1,
            // plays sound, receives poison, and its duration decrements in the same tick if it ticks.
    // rust: {
    // rust: let mut fish = make_mob(1, "minecraft:pufferfish", Vec3::new(0.5, 64.0, 0.5));
    // rust: fish.extra.size = 2;
    // rust: let pig = make_mob(2, "minecraft:pig", Vec3::new(0.5, 64.0, 0.5));
    // rust: let seen = [pig.seen(None)];
    // rust: let world = MobWorld {
    // rust: others: &seen,
    // rust: ..w.clone()
}
    // rust: let mut events = Vec::new();

                // World Tick 1: Fish ticks first
    // rust: fish.tick(&world, &mut LegacyRandom::new(0), &mut events);
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::PufferfishSting { .. }))
    // rust: );
    // rust: let mut mobs = vec![fish, pig];
    // rust: apply_brain_events(&mut mobs, &mut events, 0);

                // Assertions after fish tick and apply_brain_events:
    // rust: assert_eq!(
    // rust: mobs[1].health, 7.0,
    // rust: "pig takes 1 + 2 = 3.0 damage (10 -> 7)"
    // rust: );
    // rust: assert_eq!(mobs[1].extra.effects.len(), 1);
    // rust: assert_eq!(mobs[1].extra.effects[0].0, "minecraft:poison");
    // rust: assert_eq!(
    // rust: mobs[1].extra.effects[0].1, 120,
    // rust: "poison starts at 120 ticks"
    // rust: );
    // rust: assert_eq!(mobs[1].extra.effects[0].2, 0, "poison amplifier 0");
    // rust: assert!(
    // rust: events.iter().any(
    // rust: |e| matches!(e, MobEvent::Sound(s, ..) if *s == "entity.puffer_fish.sting")
    // rust: ),
    // rust: "sting sound emitted"
    // rust: );

                // World Tick 1 continued: Pig ticks later in the same level tick
    // rust: let fish_seen = [mobs[0].seen(None)];
    // rust: let world_for_pig = MobWorld {
    // rust: others: &fish_seen,
    // rust: ..w.clone()
}
    // rust: let mut pig_events = Vec::new();
    // rust: mobs[1].tick(&world_for_pig, &mut LegacyRandom::new(0), &mut pig_events);
    // rust: assert_eq!(
    // rust: mobs[1].extra.effects[0].1, 119,
    // rust: "poison duration decrements from 120 to 119 in same level tick"
    // rust: );

                // World Tick 2: Pig ticks on second level tick
    // rust: mobs[1].tick(&world_for_pig, &mut LegacyRandom::new(0), &mut pig_events);
    // rust: assert_eq!(
    // rust: mobs[1].extra.effects[0].1, 118,
    // rust: "poison duration decrements from 119 to 118 on second level tick"
    // rust: );
}

            // Scenario 4: Boundary/edge cases: AI and NoAI; multiple touching mobs
    // rust: {
                // NoAI fish and NoAI target
    // rust: let mut noai_fish = make_mob(1, "minecraft:pufferfish", Vec3::new(0.5, 64.0, 0.5));
    // rust: noai_fish.no_ai = true;
    // rust: noai_fish.extra.size = 2;
    // rust: let mut noai_pig = make_mob(2, "minecraft:pig", Vec3::new(0.5, 64.0, 0.5));
    // rust: noai_pig.no_ai = true;
    // rust: let seen = [noai_pig.seen(None)];
    // rust: let world = MobWorld {
    // rust: others: &seen,
    // rust: ..w.clone()
}
    // rust: let mut events = Vec::new();
    // rust: noai_fish.tick(&world, &mut LegacyRandom::new(0), &mut events);
    // rust: let mut mobs = vec![noai_fish, noai_pig];
    // rust: apply_brain_events(&mut mobs, &mut events, 0);
    // rust: assert_eq!(mobs[1].health, 7.0);
    // rust: assert_eq!(mobs[1].extra.effects[0].1, 120);
    // rust: let fish_seen = [mobs[0].seen(None)];
    // rust: let world_for_pig = MobWorld {
    // rust: others: &fish_seen,
    // rust: ..w.clone()
}
    // rust: let mut pig_events = Vec::new();
    // rust: mobs[1].tick(&world_for_pig, &mut LegacyRandom::new(0), &mut pig_events);
    // rust: assert_eq!(
    // rust: mobs[1].extra.effects[0].1, 119,
    // rust: "NoAI pig decrements poison duration to 119 on tick 1"
    // rust: );
    // rust: mobs[1].tick(&world_for_pig, &mut LegacyRandom::new(0), &mut pig_events);
    // rust: assert_eq!(
    // rust: mobs[1].extra.effects[0].1, 118,
    // rust: "NoAI pig decrements poison duration to 118 on tick 2"
    // rust: );

                // Multiple touching mobs: two pigs touching fish simultaneously
    // rust: let mut fish = make_mob(1, "minecraft:pufferfish", Vec3::new(0.5, 64.0, 0.5));
    // rust: fish.extra.size = 2;
    // rust: let pig_a = make_mob(2, "minecraft:pig", Vec3::new(0.6, 64.0, 0.5));
    // rust: let pig_b = make_mob(3, "minecraft:pig", Vec3::new(0.4, 64.0, 0.5));
    // rust: let seen = [pig_a.seen(None), pig_b.seen(None)];
    // rust: let world = MobWorld {
    // rust: others: &seen,
    // rust: ..w.clone()
}
    // rust: let mut events = Vec::new();
    // rust: fish.tick(&world, &mut LegacyRandom::new(0), &mut events);
    // rust: let stings: Vec<_> = events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::PufferfishSting { .. }))
    // rust: .collect();
    // rust: assert_eq!(stings.len(), 2, "both touching pigs stung");
    // rust: let mut mobs = vec![fish, pig_a, pig_b];
    // rust: apply_brain_events(&mut mobs, &mut events, 0);
    // rust: assert_eq!(mobs[1].health, 7.0, "pig A damaged");
    // rust: assert_eq!(mobs[2].health, 7.0, "pig B damaged");
    // rust: assert_eq!(mobs[1].extra.effects[0].1, 120, "pig A receives poison");
    // rust: assert_eq!(mobs[2].extra.effects[0].1, 120, "pig B receives poison");
}
    // rust: });
}
}
