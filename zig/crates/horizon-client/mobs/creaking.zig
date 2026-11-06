//! Transpiled from Horizon Rust crate
//! Module: horizon-client_creaking
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Creakings (`Creaking`): they freeze while any player looks at them, wake
//! up when one looks from within 12 blocks, then hunt the nearest visible
//! player and hit every 40 ticks (the brain, `CreakingAi`, is in
//! `monster_brain`). One bound to a creaking heart takes no damage (it only
//! sways and hurts the heart's resin spreader), dies when the heart no
//! longer protects it and falls apart with the heart.
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: keyframes::Animation,
    // rust: monster_brain,
    // rust: path::PathType,
}
// use crate::containers::BlockEntity;
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use std::collections::HashMap;

/// `Extra.ints` slots.
pub const INVULNERABLE: usize = 0;
pub const ATTACKING: usize = 1;
pub const STUCK: usize = 2;
pub const TEARING_DOWN: usize = 3;
pub const EYES: usize = 4;
pub const NEXT_FLICKER: usize = 5;
/// `Extra.counter` bits: hurt while protected, and by a player.
pub const HURT: i32 = 1;
pub const HURT_BY_PLAYER: i32 = 2;

/// `Creaking.ACTIVATION_RANGE_SQ`.
pub const ACTIVATION_RANGE_SQ: f64 = 144.0;
/// `Creaking.INVULNERABILITY_ANIMATION_DURATION` and the attack animation.
pub const INVULNERABILITY_TICKS: i32 = 8;
pub const ATTACK_TICKS: i32 = 15;
/// `Creaking.TWITCH_DEATH_DURATION`.
pub const TWITCH_TICKS: i32 = 45;

/// `Creaking`'s constructor: no goals (the brain thinks), a navigation that
/// floats.
pub fn register(m: *mut Mob) void {
}
    // rust: m.ai.nav.can_float = true;
}
/// Bound to a heart (`getHomePos() != null`).
pub fn heart_bound(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: is_creaking(m) && m.extra.home.is_some()
}
pub fn tearing_down(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: is_creaking(m) && m.extra.ints[TEARING_DOWN] != 0
}
/// `Creaking.canMove`: false while a player looks at it.
pub fn can_move(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !m.extra.flag2
}
/// `Creaking.isActive`.
pub fn is_active(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.flag
}
/// `Creaking.setTransient`: bind to the heart at `pos` and avoid damage.
pub fn set_transient(m: *mut Mob, pos: [i32; 3]) void {
}
    // rust: m.extra.home = Some(pos);
    // rust: m.set_malus(PathType::Damaging, 8.0);
    // rust: m.set_malus(PathType::PowderSnow, 8.0);
    // rust: m.set_malus(PathType::Lava, 8.0);
    // rust: m.set_malus(PathType::Fire, 0.0);
    // rust: m.set_malus(PathType::FireInNeighbor, 0.0);
}
/// `Creaking.setTearingDown`: the heart was broken by someone.
pub fn set_tearing_down(m: *mut Mob) void {
}
    // rust: m.extra.ints[TEARING_DOWN] = 1;
}
/// `Creaking.hasGlowingEyes` / `isActive`: the eyes layer shows.
pub fn eyes_glowing(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if tearing_down(m) {
    // rust: m.extra.ints[EYES] != 0
    // rust: } else {
    // rust: is_active(m)
}
}
/// Ticks of death animation before the mob is removed (`tickDeath`).
pub fn death_limit(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if heart_bound(m) && tearing_down(m) {
    // rust: TWITCH_TICKS + 1
    // rust: } else {
    // rust: 20
}
}
/// `Creaking.tearDown`: crumbles away.
pub fn tear_down(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let b = m.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: events.push(MobEvent::CreakingTearDown {
    // rust: center: [
    // rust: (lo.x + hi.x) / 2.0,
    // rust: (lo.y + hi.y) / 2.0,
    // rust: (lo.z + hi.z) / 2.0,
    // rust: ],
    // rust: spread: [
    // rust: (hi.x - lo.x) * 0.3,
    // rust: (hi.y - lo.y) * 0.3,
    // rust: (hi.z - lo.z) * 0.3,
    // rust: ],
    // rust: });
    // rust: m.voice("entity.creaking.death", events);
    // rust: m.removed = true;
}
/// `Creaking.hurtServer` for a heart-bound creaking: no damage, only the
/// invulnerability animation and the heart's reaction. Returns whether the
/// normal damage path should run.
pub fn accepts_damage(m: *mut Mob, source: *Damage) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !heart_bound(m) || source.kind.bypasses_invulnerability() {
    // rust: return true;
}
    // rust: if source.is_fire() || !m.alive() || m.extra.ints[INVULNERABLE] > 0 {
    // rust: return false;
}
    // rust: let by_player = source.attacker == Some(Who::Player);
    // The direct entity must be living or a projectile (or a player must be to blame).
    // rust: let direct = matches!(
    // rust: source.kind,
    // rust: DamageKind::PlayerAttack
    // rust: | DamageKind::MaceSmash
    // rust: | DamageKind::Spear
    // rust: | DamageKind::MobAttack
    // rust: | DamageKind::Arrow
    // rust: | DamageKind::Thrown
    // rust: | DamageKind::Fireball
    // rust: | DamageKind::WitherSkull
    // rust: | DamageKind::WindCharge
    // rust: | DamageKind::Thorns
    // rust: );
    // rust: if !direct && !by_player {
    // rust: return false;
}
    // rust: m.extra.ints[INVULNERABLE] = INVULNERABILITY_TICKS;
    // rust: m.extra.counter |= HURT | if by_player { HURT_BY_PLAYER } else { 0 };
    // rust: false
}
/// The rest of `Creaking.hurtServer` for a heart-bound creaking, run by the
/// host right after the damage: whether its heart still protects it, and
/// whether a player is to blame (the heart then calls `creakingHurt`). The
/// caller plays [`sway`] after the heart's reaction.
pub fn take_hurt(m: *mut Mob, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.extra.counter & HURT == 0 {
    // rust: return None;
}
    // rust: let by_player = m.extra.counter & HURT_BY_PLAYER != 0;
    // rust: m.extra.counter &= !(HURT | HURT_BY_PLAYER);
    // rust: let home = m.extra.home?;
    // rust: protected(m, w).then_some((home, by_player))
}
/// `Mob.playHurtSound` of a heart-bound creaking: the ambient sound clock
/// restarts and it sways.
pub fn sway(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: m.ambient_timer = -m.kind.ambient_interval;
    // rust: m.voice("entity.creaking.sway", events);
}
/// `Creaking.doHurtTarget`: the attack animation (the sound is the
/// `playAttackSound` that ends `Mob.doHurtTarget`).
pub fn on_attack(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: m.extra.ints[ATTACKING] = ATTACK_TICKS;
    // rust: broadcast(m, 4, events);
}
/// `Level.broadcastEntityEvent` for a creaking (guests run `entity_event`).
pub fn broadcast(m: *Mob, event: i8, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}
/// `Creaking.handleEntityEvent` on a client: 66 the invulnerability flash,
/// 4 the attack swing (the sounds are the server's).
pub fn entity_event(m: *mut Mob, event: u8) void {
}
    // rust: match event {
    // rust: 66 => m.extra.ints[INVULNERABLE] = INVULNERABILITY_TICKS,
    // rust: 4 => m.extra.ints[ATTACKING] = ATTACK_TICKS,
    // rust: _ => {}
}
}
/// The heart this creaking is bound to protects it (`isProtector`); a link
/// read from a save is trusted until the heart resolves it.
pub fn protected(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(home) = m.extra.home else {
    // rust: return true;
}
    // rust: match w.world.block_entities.get(&(home[0], home[1], home[2])) {
    // rust: Some(BlockEntity::CreakingHeart(h)) => match h.creaking {
    // rust: Some((Some(id), _)) => id == m.id,
    // rust: Some((None, _)) => true,
    // rust: None => false,
    // rust: },
    // rust: _ => false,
}
}
/// `Creaking.tick` and the start of `aiStep`: protection, timers, freezing.
pub fn update(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // Creaking.tick: without its heart's protection it dies.
    // rust: if heart_bound(m) && m.alive() && !protected(m, w) {
    // rust: m.health = 0.0;
}
    // hurtServer set the invulnerability clock since the last tick: entity
    // event 66.
    // rust: if m.extra.ints[INVULNERABLE] == INVULNERABILITY_TICKS {
    // rust: broadcast(m, 66, events);
        // hurtServer: `gameEvent(ENTITY_ACTION)` right after the entity event.
    // rust: entity_action(m, events);
}
    // rust: animate(m);
    // rust: if m.extra.counter & HURT != 0 {
        // hurtServer: sway, and the heart reacts to a player's hit.
    // rust: if protected(m, w) {
    // rust: let by_player = m.extra.counter & HURT_BY_PLAYER != 0;
    // rust: if let Some(home) = m.extra.home {
    // rust: events.push(MobEvent::CreakingHurt {
    // rust: home,
    // rust: by_player,
    // rust: id: m.id,
    // rust: });
}
    // rust: sway(m, events);
}
    // rust: m.extra.counter &= !(HURT | HURT_BY_PLAYER);
}
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: let now = check_can_move(m, w, events);
    // rust: if now != can_move(m) {
        // Creaking.aiStep: ENTITY_ACTION, then the sound.
    // rust: entity_action(m, events);
    // rust: if now {
    // rust: m.voice("entity.creaking.unfreeze", events);
    // rust: } else {
    // rust: stop_in_place(m);
    // rust: m.voice("entity.creaking.freeze", events);
}
    // rust: m.extra.flag2 = !now;
}
}
/// The clocks and keyframe states `Creaking.aiStep`, `setupAnimationStates`
/// and `checkEyeBlink` run (the server's and a client's).
pub fn animate(m: *mut Mob) void {
}
    // rust: for slot in [INVULNERABLE, ATTACKING] {
    // rust: if m.extra.ints[slot] > 0 {
    // rust: m.extra.ints[slot] -= 1;
}
}
    // rust: let age = m.age as f32;
    // rust: m.anim.states[0].animate_when(m.extra.ints[ATTACKING] > 0, age);
    // rust: m.anim.states[1].animate_when(m.extra.ints[INVULNERABLE] > 0, age);
    // rust: m.anim.states[2].animate_when(tearing_down(m), age);
    // checkEyeBlink: the eyes of a creaking falling apart flicker.
    // rust: if m.death_time > m.extra.ints[NEXT_FLICKER] {
    // rust: let glowing = m.extra.ints[EYES] != 0;
    // rust: let (lo, hi) = if glowing {
    // rust: (2, 8)
    // rust: } else {
    // rust: (m.death_time / 4, m.death_time / 2)
}
    // rust: let span = (hi - lo + 1).max(1);
    // rust: m.extra.ints[NEXT_FLICKER] = m.death_time + lo + m.random.next_int_bound(span).unwrap_or(0);
    // rust: m.extra.ints[EYES] = i32::from(!glowing);
}
}
/// `Mob.stopInPlace`.
pub fn stop_in_place(m: *mut Mob) void {
}
    // rust: m.nav_stop();
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.yya = 0.0;
    // rust: m.ai.zza = 0.0;
    // rust: m.ai.speed = 0.0;
    // rust: m.velocity = horizon_core::geometry::Vec3::ZERO;
    // rust: m.extra.leash_spin = 0.0;
}
/// `Entity.gameEvent(GameEvent.ENTITY_ACTION)` at the creaking.
pub fn entity_action(m: *Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:entity_action",
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: source: m.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
}
/// `Creaking.activate`.
pub fn activate(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: monster_brain::set_attack_target(m, Some(Who::Player));
    // rust: entity_action(m, events);
    // rust: m.voice("entity.creaking.activate", events);
    // rust: m.extra.flag = true;
}
/// `Creaking.deactivate`.
pub fn deactivate(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: monster_brain::set_attack_target(m, None);
    // rust: entity_action(m, events);
    // rust: m.voice("entity.creaking.deactivate", events);
    // rust: m.extra.flag = false;
}
/// `LivingEntity.isLookingAtMe(player, 0.5, false, true, eyeY, y + 0.5,
/// (eyeY + y) / 2)`: within the player's view cone and seen through
/// transparent blocks.
pub fn looked_at_by(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(p) = &w.player else { return false };
    // rust: let look = normalize(p.look);
    // rust: let eye = m.eye_y();
    // rust: [eye, m.position.y + 0.5, (eye + m.position.y) / 2.0]
    // rust: .into_iter()
    // rust: .any(|y| {
    // rust: let d = normalize([
    // rust: m.position.x - p.position.x,
    // rust: y - p.eye[1],
    // rust: m.position.z - p.position.z,
    // rust: ]);
    // rust: let dot = look[0] * d[0] + look[1] * d[1] + look[2] * d[2];
    // rust: if dot <= 0.5 {
    // rust: return false;
}
            // Player.hasLineOfSight(this, VISUAL, NONE, y).
    // rust: let from = Vec3::new(p.position.x, p.eye[1], p.position.z);
    // rust: let to = Vec3::new(m.position.x, y, m.position.z);
    // rust: to.distance(from) <= 128.0 && w.visual_clear_between(from, to)
    // rust: })
}
/// `Vec3.normalize`.
pub fn normalize(v: [f64; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = (v[0] * v[0] + v[1] * v[1] + v[2] * v[2]).sqrt();
    // rust: if len < f64::from(1.0e-5_f32) {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: [v[0] / len, v[1] / len, v[2] / len]
}
}
/// `Creaking.checkCanMove`: false while looked at; also wakes and calms it.
pub fn check_can_move(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let players = monster_brain::nearest_players(m);
    // rust: let active = is_active(m);
    // rust: if players.is_empty() {
    // rust: if active {
    // rust: deactivate(m, events);
}
    // rust: return true;
}
    // rust: let mut potential = false;
    // rust: if let Some(p) = w.player.as_ref().filter(|_| players.contains(&Who::Player)) {
        // canAttack (not creative, spectator or dead) and not allied.
    // rust: if p.alive && !p.creative && !p.spectator {
    // rust: potential = true;
            // GAZE_DISGUISE_EQUIPMENT hides the player once the creaking is awake.
    // rust: let disguised = p.head.as_deref() == Some("minecraft:carved_pumpkin");
    // rust: if (!active || !disguised) && looked_at_by(m, w) {
    // rust: if active {
    // rust: return false;
}
    // rust: if m.distance_sqr(p.position) < ACTIVATION_RANGE_SQ {
    // rust: activate(m, events);
    // rust: return false;
}
}
}
}
    // rust: if !potential && active {
    // rust: deactivate(m, events);
}
    // rust: true
}
/// `Creaking.playerIsStuckInYou`: the player's eyes inside it for more than 4 ticks.
pub fn player_is_stuck(m: *mut Mob, eye: ?[f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(eye) = eye else {
    // rust: m.extra.ints[STUCK] = 0;
    // rust: return false;
}
    // rust: let b = m.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // AABB.contains: the far faces are outside.
    // rust: let inside = eye[0] >= lo.x
    // rust: && eye[0] < hi.x
    // rust: && eye[1] >= lo.y
    // rust: && eye[1] < hi.y
    // rust: && eye[2] >= lo.z
    // rust: && eye[2] < hi.z;
    // rust: if inside {
    // rust: m.extra.ints[STUCK] += 1;
    // rust: m.extra.ints[STUCK] > 4
    // rust: } else {
    // rust: m.extra.ints[STUCK] = 0;
    // rust: false
}
}
/// `CreakingModel.setupAnim`.
pub fn anim(m: *Mob, s: *State, p: *mut Poses, animations: *HashMap<[]const u8) void {
}
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: let get = |n: &str| animations.get(&format!("CreakingAnimation.CREAKING_{n}"));
    // rust: if can_move(m)
    // rust: && let Some(walk) = get("WALK")
    // rust: {
    // rust: walk.apply_walk(s.pos, s.speed, 1.0, 1.0, p);
}
    // rust: for (state, name) in [
    // rust: (&m.anim.states[0], "ATTACK"),
    // rust: (&m.anim.states[1], "INVULNERABLE"),
    // rust: (&m.anim.states[2], "DEATH"),
    // rust: ] {
    // rust: if let (Some(ms), Some(a)) = (state.millis(s.age), get(name)) {
    // rust: a.apply(ms, 1.0, p);
}
}
}
/// The creaking species exists in the species table.
pub fn is_creaking(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.species() == Species::Creaking
}
/// `Creaking.canUsePortal`: a creaking bound to a heart never travels through
/// a portal, since its heart stays behind; one without a heart goes through
/// like any other monster.
pub fn can_use_portal(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !heart_bound(m)
}
    // rust: mod portal_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use std::sync::Arc;

pub fn mob(species: Species) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = (*kind()).clone();
    // rust: kind.species = species;
    // rust: Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0)
}

    /// `Creaking.canUsePortal`: the creaking's own `!isHeartBound()`; a home
    /// point another species keeps (a wolf's bed) is not a heart, so it does
    /// not stop that mob from travelling.
pub fn only_a_creaking_bound_to_a_heart_is_refused_the_portal() void {
}
    // rust: let mut m = mob(Species::Creaking);
    // rust: assert!(!heart_bound(&m), "born free");
    // rust: assert!(
    // rust: crate::mobs::mob_can_use_portal(&m),
    // rust: "a free creaking travels"
    // rust: );
    // rust: m.extra.home = Some([4, 64, -7]);
    // rust: assert!(heart_bound(&m));
    // rust: assert!(
    // rust: !crate::mobs::mob_can_use_portal(&m),
    // rust: "a creaking bound to its heart must not leave it behind"
    // rust: );
    // rust: let mut wolf = mob(Species::Wolf);
    // rust: wolf.extra.home = Some([4, 64, -7]);
    // rust: assert!(!heart_bound(&wolf));
    // rust: assert!(crate::mobs::mob_can_use_portal(&wolf));
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use std::sync::Arc;

    /// Creaking.activate and deactivate post ENTITY_ACTION, for the sculk sensors and
    /// wardens nearby.
pub fn activating_and_deactivating_post_entity_action() void {
}
    // rust: let mut m = creaking();
    // rust: let id = m.id;
    // rust: let action = |events: &[MobEvent]| {
    // rust: events.iter().any(|e| {
    // rust: matches!(e, MobEvent::GameEvent { event, source, .. }
    // rust: if *event == "minecraft:entity_action" && *source == id)
    // rust: })
}
    // rust: let mut events = Vec::new();
    // rust: activate(&mut m, &mut events);
    // rust: assert!(action(&events), "activating posts entity_action");
    // rust: let mut events = Vec::new();
    // rust: deactivate(&mut m, &mut events);
    // rust: assert!(action(&events), "deactivating posts entity_action");
}

    /// A creaking with no heart bound to it, at the origin.
pub fn creaking() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:creaking".into();
    // rust: k.species = Species::Creaking;
        // The creaking row of the species table, hurt sound and all.
    // rust: k.sounds = [
    // rust: "entity.creaking.ambient",
    // rust: "entity.generic.hurt",
    // rust: "entity.creaking.death",
    // rust: ];
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    /// The sounds a hit on `m` left in its outbox.
pub fn hurt_sounds(m: *Mob) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.outbox
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::Sound(s, ..) => Some(*s),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}

pub fn a_creaking_with_no_heart_hurts_like_a_monster() void {
}
        // Creaking.hurtServer: without a home the blow goes to
        // Monster.hurtServer, whose getHurtSound is the hostile hurt — not
        // the generic one.
    // rust: let mut m = creaking();
    // rust: assert!(m.damage(1.0, Damage::player([0.0, 0.0, 1.0])));
    // rust: assert_eq!(
    // rust: hurt_sounds(&m),
    // rust: ["entity.hostile.hurt"],
    // rust: "an unbound creaking is hurt like a monster"
    // rust: );
}

pub fn a_heart_bound_creaking_sways_when_a_blow_gets_through() void {
}
        // Only #bypasses_invulnerability reaches a bound creaking
        // (Creaking.hurtServer hands those straight to Monster), and that is
        // the blow whose hurt sound Creaking.getHurtSound answers with the sway.
    // rust: let mut m = creaking();
    // rust: m.extra.home = Some([0, 64, 0]);
    // rust: assert!(m.damage(1.0, Damage::of(DamageKind::OutOfWorld)));
    // rust: assert_eq!(
    // rust: hurt_sounds(&m),
    // rust: ["entity.creaking.sway"],
    // rust: "a heart-bound creaking sways"
    // rust: );
}

pub fn a_giant_hurts_and_dies_like_a_monster() void {
}
        // Giant overrides none of Monster's sounds, so its hurt and death are
        // the hostile pair.
    // rust: let mut m = creaking();
    // rust: let k = Arc::make_mut(&mut m.kind);
    // rust: k.id = "minecraft:giant".into();
    // rust: k.species = Species::Giant;
    // rust: k.sounds = ["", "entity.generic.hurt", "entity.generic.death"];
    // rust: m.health = 100.0;
    // rust: assert!(m.damage(1.0, Damage::player([0.0, 0.0, 1.0])));
    // rust: assert_eq!(hurt_sounds(&m), ["entity.hostile.hurt"], "a giant's hurt");
    // rust: m.outbox.clear();
        // The invulnerability frames are over: the next blow is a full one.
    // rust: m.invulnerable = 0;
    // rust: assert!(m.damage(200.0, Damage::player([0.0, 0.0, 1.0])));
    // rust: assert!(!m.alive());
    // rust: assert_eq!(hurt_sounds(&m), ["entity.hostile.death"], "a giant's death");
}
}
