//! Transpiled from Horizon Rust crate
//! Module: horizon-client_spear_use
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Mobs using a spear (`KineticWeapon`): `startUsingItem` of the main hand,
//! the stab of every tick of the use (`KineticWeapon.damageEntities`) and
//! what makes a mob use it: `SpearUseGoal` of zombies and zombified piglins,
//! and the fight activity's `SpearApproach`, `SpearAttack` and `SpearRetreat`
//! of piglins.
//! A mob's `using_item` counts the ticks of the use up from 1, which the
//! living entity flags tell the clients (`mob_meta`), so the arm and the
//! spear are drawn charging for them as well.
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, Species, Who,
    // rust: brain::Timed,
    // rust: gear,
    // rust: goals::{Cx, Goal, LOOK, MOVE, goal_clone, reduced},
}
// use crate::spear::{Kinetic, REACH, hits_in_reach};
// use horizon_core::geometry::{Aabb, Vec3, trig::Mth};

/// The kinetic weapon in the main hand (`getMainHandItem().get(KINETIC_WEAPON)`).
pub fn main_hand_kinetic(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.main_hand.as_deref().and_then(Kinetic::of)
}

/// `LivingEntity.isUsingItem`. A piglin admiring what it holds in its off
/// hand counts `using_item` down as well; vanilla keeps that in a memory.
pub fn is_using_item(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.using_item > 0 && !(m.species() == Species::Piglin && m.extra.off_hand.is_some())
}

/// `LivingEntity.startUsingItem(MAIN_HAND)`: the use of a kinetic weapon
/// starts with a new `recentKineticEnemies`.
pub fn start_using_item(m: *mut Mob) void {
}
    // rust: if m.extra.main_hand.is_none() || is_using_item(m) {
    // rust: return;
}
    // rust: m.extra.using_item = 1;
    // rust: m.extra.using_off_hand = false;
    // rust: if main_hand_kinetic(m).is_some() {
    // rust: m.extra.stabbed = Some(Vec::new());
}
}

/// `LivingEntity.stopUsingItem`: `recentKineticEnemies` is gone.
pub fn stop_using_item(m: *mut Mob) void {
}
    // rust: if is_using_item(m) {
    // rust: m.extra.using_item = 0;
}
    // rust: m.extra.stabbed = None;
}

/// `LivingEntity.updatingUsingItem` of a kinetic weapon, in `LivingEntity.tick`
/// before the AI: the stab of this tick, then one more tick used. A use whose
/// weapon left the main hand ends. `known_speed` is what the mob moved last
/// tick (`Entity.lastKnownSpeed`).
pub fn update_using_item(m: *mut Mob, w: *MobWorld, known_speed: Vec3, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.extra.stabbed.is_none() {
    // rust: return;
}
    // rust: let Some(kinetic) = main_hand_kinetic(m).filter(|_| is_using_item(m)) else {
    // rust: stop_using_item(m);
    // rust: return;
}
    // `ItemStack.onUseTick` gets the ticks left; the use began at 1.
    // rust: let ticks_used = m.extra.using_item - 1;
    // rust: damage_entities(m, &kinetic, ticks_used, w, known_speed, events);
    // rust: if is_using_item(m) {
    // rust: m.extra.using_item += 1;
}
}

/// What a stab can meet: who, where and how fast it moves per second.
pub const Candidate = struct {
    who: Who,
    bounds: Aabb,
    speed: Vec3,
};

/// The entities a stab may hit (`PiercingWeapon.canHitEntity`): the player
/// the mob sees and the other living mobs near it, but not the mount it sits
/// on or the rider it carries.
pub fn candidates(m: *Mob, w: *MobWorld) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: if let Some(p) = w.player.as_ref().filter(|p| p.alive && !p.spectator) {
    // rust: out.push(Candidate {
    // rust: who: Who::Player,
    // rust: bounds: p.bounds,
    // rust: speed: p.velocity.scale(20.0),
    // rust: });
}
    // rust: let r = 6.0;
    // rust: let area = m.bounds().inflate(Vec3::new(r, r, r));
    // rust: for s in w.others_near(area) {
    // rust: if s.id == m.id || !s.alive || m.extra.mount == Some(s.id) || m.extra.rider == Some(s.id) {
    // rust: continue;
}
    // rust: out.push(Candidate {
    // rust: who: Who::Mob(s.id),
    // rust: bounds: s.bounds,
    // rust: speed: s.known_speed.scale(20.0),
    // rust: });
}
    // rust: out
}

/// `Entity.getHeadLookAngle`: `calculateViewVector(xRot, yHeadRot)`.
pub fn head_look_angle(m: *Mob) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let to_rad = std::f32::consts::PI / 180.0;
    // rust: let x = m.head_pitch * to_rad;
    // rust: let y = -m.head_yaw * to_rad;
    // rust: let (y_cos, y_sin, x_cos, x_sin) = (y.mcos(), y.msin(), x.mcos(), x.msin());
    // rust: Vec3::new(
    // rust: f64::from(y_sin * x_cos),
    // rust: f64::from(-x_sin),
    // rust: f64::from(y_cos * x_cos),
    // rust: )
}

/// `KineticWeapon.getMotion`: the known speed per second of the attacker, or
/// of the mount it rides.
pub fn motion(m: *Mob, w: *MobWorld, known_speed: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra
    // rust: .mount
    // rust: .and_then(|id| w.seen(id))
    // rust: .map_or(known_speed, |s| s.known_speed)
    // rust: .scale(20.0)
}

/// `KineticWeapon.damageEntities` for a mob: from `delay_ticks` of the use
/// on, every entity along the view that the speed allows is stabbed, once in
/// `contact_cooldown_ticks` each. A mob's conditions are scaled by 0.2 and
/// its reach by the `mob_factor` of the spear's `AttackRange`.
    // rust: fn damage_entities(
    // rust: m: &mut Mob,
    // rust: k: &Kinetic,
    // rust: ticks_used: i32,
    // rust: w: &MobWorld,
    // rust: known_speed: Vec3,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if ticks_used < k.delay_ticks {
    // rust: return;
}
    // rust: let ticks_used = ticks_used - k.delay_ticks;
    // rust: let look = m.look_angle();
    // rust: let look = Vec3::new(look[0], look[1], look[2]);
    // rust: let attacker_speed = look.dot(motion(m, w, known_speed));
    // `AttackRange.effectiveMinRange` and `effectiveMaxRange` of a mob.
    // rust: let reach = (
    // rust: REACH.min * REACH.mob_factor,
    // rust: REACH.max * REACH.mob_factor,
    // rust: REACH.hitbox_margin,
    // rust: );
    // rust: let targets = candidates(m, w);
    // rust: let boxes: Vec<(usize, Aabb)> = targets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, t)| (i, t.bounds))
    // rust: .collect();
    // rust: let eye = Vec3::new(m.position.x, m.eye_y(), m.position.z);
    // rust: let hits = hits_in_reach(
    // rust: &boxes,
    // rust: eye,
    // rust: head_look_angle(m),
    // rust: m.velocity,
    // rust: reach,
    // rust: |from, to| w.clip_block(from, to),
    // rust: );
    // rust: let now = w.game_time;
    // rust: let action_factor = f64::from(0.2_f32);
    // The attack damage attribute's base value.
    // rust: let base = m.attrs.attack_damage;
    // rust: let mut affected = false;
    // rust: for (i, _) in hits {
    // rust: let target = &targets[i];
    // rust: let recent = m.extra.stabbed.as_ref().is_some_and(|stabbed| {
    // rust: stabbed.iter().any(|&(who, at)| {
    // rust: who == target.who && now - at < i64::from(k.contact_cooldown_ticks)
    // rust: })
    // rust: });
    // rust: if recent {
    // rust: continue;
}
        // `LivingEntity.rememberStabbedEntity`.
    // rust: if let Some(stabbed) = m.extra.stabbed.as_mut() {
    // rust: match stabbed.iter_mut().find(|(who, _)| *who == target.who) {
    // rust: Some(entry) => entry.1 = now,
    // rust: None => stabbed.push((target.who, now)),
}
}
    // rust: let relative = (attacker_speed - look.dot(target.speed)).max(0.0);
    // rust: let dismounts = k
    // rust: .dismount
    // rust: .test(ticks_used, attacker_speed, relative, action_factor);
    // rust: let pushes = k
    // rust: .knockback
    // rust: .test(ticks_used, attacker_speed, relative, action_factor);
    // rust: let damages = k
    // rust: .damage
    // rust: .test(ticks_used, attacker_speed, relative, action_factor);
    // rust: if dismounts || pushes || damages {
    // rust: let amount = base + (relative * f64::from(k.damage_multiplier)).floor() as i32 as f32;
    // rust: affected |= stab_attack(
    // rust: m,
    // rust: target.who,
    // rust: amount,
    // rust: (damages, pushes, dismounts),
    // rust: w,
    // rust: events,
    // rust: );
}
}
    // rust: if affected {
        // `Level.broadcastEntityEvent(mob, 2)`: the hit is felt and heard.
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 2,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}
}

/// `LivingEntity.stabAttack` of a mob on `target`, with what the conditions
/// allow (`deals_damage`, `deals_knockback`, `dismounts`): whether it was
/// affected. The damage and the pushes are the game's events; a hit that
/// the target's damage cooldown refuses still counts as landed here.
    // rust: fn stab_attack(
    // rust: m: &mut Mob,
    // rust: target: Who,
    // rust: base_damage: f32,
    // rust: (deals_damage, deals_knockback, dismounts): (bool, bool, bool),
    // rust: w: &MobWorld,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) -> bool {
    // rust: let species = match target {
    // rust: Who::Mob(id) => w.seen(id).map(|s| s.species),
    // rust: Who::Player => None,
}
    // `EnchantmentHelper.modifyDamage`.
    // rust: let damage = base_damage + gear::melee_bonus(m, species);
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // `weaponItem.getDamageSource(this)`: the spear's, for the hurt and the pushes.
    // rust: let source = Damage {
    // rust: kind: DamageKind::Spear,
    // rust: attacker: Some(Who::Mob(m.id)),
    // rust: from: Some(from),
    // rust: attacker_species: Some(m.species()),
}
    // rust: let mut affected = deals_knockback;
    // rust: if deals_damage {
    // rust: match target {
    // rust: Who::Player => events.push(MobEvent::DamagePlayer {
    // rust: amount: damage,
    // rust: from,
    // rust: kind: "minecraft:spear",
    // rust: }),
    // rust: Who::Mob(id) => events.push(MobEvent::AttackMob {
    // rust: target: id,
    // rust: amount: damage,
    // rust: source,
    // rust: }),
}
    // rust: affected = true;
        // `EnchantmentHelper.doPostAttackEffects`: Fire Aspect.
    // rust: let burn = gear::fire_aspect(m);
    // rust: if burn > 0 {
    // rust: events.push(MobEvent::Ignite {
    // rust: target,
    // rust: seconds: burn,
    // rust: });
}
}
    // rust: if deals_knockback {
    // rust: cause_extra_knockback(m, target, 0.4_f32, source, events);
        // `LivingEntity.getKnockback`: the Knockback enchantment, halved.
    // rust: let power = gear::knockback(m) as f32 / 2.0;
    // rust: cause_extra_knockback(m, target, power, source, events);
}
    // rust: if dismounts && w.target_info(target).is_some_and(|t| t.passenger) {
    // rust: affected = true;
    // rust: events.push(MobEvent::StabDismount { target });
}
    // rust: affected
}

/// `LivingEntity.causeExtraKnockback`: a push along the attacker's facing,
/// which slows the attacker.
    // rust: fn cause_extra_knockback(
    // rust: m: &mut Mob,
    // rust: target: Who,
    // rust: power: f32,
    // rust: source: Damage,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if power <= 0.0 {
    // rust: return;
}
    // rust: let to_rad = std::f32::consts::PI / 180.0;
    // rust: events.push(MobEvent::Knockback {
    // rust: target,
    // rust: power: f64::from(power),
    // rust: x: f64::from((m.yaw * to_rad).msin()),
    // rust: z: f64::from(-(m.yaw * to_rad).mcos()),
    // rust: source,
    // rust: });
    // rust: m.velocity = Vec3::new(m.velocity.x * 0.6, m.velocity.y, m.velocity.z * 0.6);
}

/// `Mob.chargeSpeedModifier` of the mount: a zombie horse runs 1.4 times as
/// fast with a charging rider, a camel husk 4 times.
pub fn charge_speed_modifier(m: *Mob, w: *MobWorld) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match m.extra.mount.and_then(|id| w.seen(id)).map(|s| s.species) {
    // rust: Some(Species::ZombieHorse) => 1.4,
    // rust: Some(Species::CamelHusk) => 4.0,
    // rust: _ => 1.0,
}
}

/// `Entity.isPassenger` as the 2 blocks it adds to the charge distances.
pub fn passenger_distance(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.extra.mount.is_some() { 2 } else { 0 }
}

/// `ableToAttack` of `SpearUseGoal` and the spear behaviours: a target and a
/// kinetic weapon in the main hand.
pub fn able_to_attack(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.target_info(w).is_some() && main_hand_kinetic(m).is_some()
}

/// `SpearUseGoal.SpearUseState`: where a charge is.
pub const SpearUseState = struct {
    engage_time: i32,
    fleeing_time: i32,
    away_pos: Option<[f64,
    done: bool,
};
    // rust: impl SpearUseState {
    /// `SpearUseState.<init>`: not engaged and not fleeing yet.
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: engage_time: -1,
    // rust: fleeing_time: -1,
    // rust: away_pos: None,
    // rust: done: false,
}
}
    /// `SpearUseState.notEngagedYet`.
pub fn not_engaged_yet(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.engage_time < 0
}
    /// `SpearUseState.startEngagement`: the spear stays down for `spear_down_time` goal ticks.
pub fn start_engagement(self: *Self, spear_down_time: i32) void {
}
    // rust: self.engage_time = spear_down_time;
}
    /// `SpearUseState.tickAndCheckEngagement`: whether the time ran out.
pub fn tick_and_check_engagement(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.engage_time > 0 {
    // rust: self.engage_time -= 1;
    // rust: if self.engage_time == 0 {
    // rust: return true;
}
}
    // rust: false
}
    /// `SpearUseState.tickAndCheckFleeing`: whether it fled for too long.
pub fn tick_and_check_fleeing(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.fleeing_time > 0 {
    // rust: self.fleeing_time += 1;
    // rust: if self.fleeing_time > SpearUse::MAX_FLEEING_TIME {
    // rust: self.done = true;
    // rust: return true;
}
}
    // rust: false
}
}

/// `SpearUseGoal`: with a spear in hand and a target, walk up to the
/// approach distance, lower the spear and charge until its use time ends,
/// back off 9 to 11 blocks and start over.
pub const SpearUse = struct {
    speed_modifier_when_charging: f64,
    speed_modifier_when_repositioning: f64,
    approach_distance_sq: f32,
    target_in_range_radius_sq: f32,
    state: ?SpearUseState,
};
    // rust: impl SpearUse {
    /// `SpearUseGoal.MAX_FLEEING_TIME`: `reducedTickDelay(100)`.
pub const MAX_FLEEING_TIME: i32 = 50;

    // rust: pub fn new(
    // rust: speed_modifier_when_charging: f64,
    // rust: speed_modifier_when_repositioning: f64,
    // rust: approach_distance: f32,
    // rust: target_in_range_radius: f32,
    // rust: ) -> Self {
    // rust: Self {
    // rust: speed_modifier_when_charging,
    // rust: speed_modifier_when_repositioning,
    // rust: approach_distance_sq: approach_distance * approach_distance,
    // rust: target_in_range_radius_sq: target_in_range_radius * target_in_range_radius,
    // rust: state: None,
}
}

    /// `SpearUseGoal.getKineticWeaponUseDuration`.
pub fn kinetic_weapon_use_duration(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: reduced(main_hand_kinetic(m).map_or(0, |k| k.damage_use_duration()))
}

    /// The part of `SpearUseGoal.tick` that works on the state.
pub fn step(self: *Self, state: *mut SpearUseState, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(who) = m.ai.target else { return };
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let target_dist_sqr = m.distance_sqr(t.position);
    // rust: let speed_modifier = f64::from(charge_speed_modifier(m, cx.w));
    // rust: let mount_distance = passenger_distance(m);
    // rust: let at = [t.position.x, t.eye_y, t.position.z];
    // rust: m.turn_to(at, 30.0, 30.0);
    // rust: m.look_at_speed(at, 30.0, 30.0);
    // rust: if state.not_engaged_yet() {
    // rust: if target_dist_sqr > f64::from(self.approach_distance_sq) {
    // rust: m.nav_move_to_entity(
    // rust: cx.w,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: 1,
    // rust: speed_modifier * self.speed_modifier_when_repositioning,
    // rust: );
    // rust: return;
}
    // rust: state.start_engagement(Self::kinetic_weapon_use_duration(m));
    // rust: start_using_item(m);
}
    // rust: if state.tick_and_check_engagement() {
    // rust: stop_using_item(m);
    // rust: let distance = target_dist_sqr.sqrt();
    // rust: state.away_pos = m.land_random_pos_away_between(
    // rust: cx.w,
    // rust: 0.0_f64.max(f64::from(9 + mount_distance) - distance),
    // rust: 1.0_f64.max(f64::from(11 + mount_distance) - distance),
    // rust: 7,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: );
    // rust: state.fleeing_time = 1;
}
    // rust: if !state.tick_and_check_fleeing() {
    // rust: if let Some(away) = state.away_pos {
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: away,
    // rust: speed_modifier * self.speed_modifier_when_repositioning,
    // rust: );
    // rust: if m.ai.nav.is_done() {
    // rust: if state.fleeing_time > 0 {
    // rust: state.done = true;
    // rust: return;
}
    // rust: state.away_pos = None;
}
    // rust: } else {
    // rust: m.nav_move_to_entity(
    // rust: cx.w,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: 1,
    // rust: speed_modifier * self.speed_modifier_when_charging,
    // rust: );
    // rust: if target_dist_sqr < f64::from(self.target_in_range_radius_sq) || m.ai.nav.is_done()
    // rust: {
    // rust: let distance = target_dist_sqr.sqrt();
    // rust: state.away_pos = m.land_random_pos_away_between(
    // rust: cx.w,
    // rust: f64::from(6 + mount_distance) - distance,
    // rust: f64::from(7 + mount_distance) - distance,
    // rust: 7,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: );
}
}
}
}
}
    // rust: impl Goal for SpearUse {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
}
    /// `SpearUseGoal.canUse`: able to attack and not using an item.
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: able_to_attack(m, cx.w) && !is_using_item(m)
}
    /// `SpearUseGoal.canContinueToUse`.
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.state.as_ref().is_some_and(|s| !s.done) && able_to_attack(m, cx.w)
}
    /// `SpearUseGoal.start`: aggressive, with a new state.
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.ai.aggressive = true;
    // rust: self.state = Some(SpearUseState::new());
}
    /// `SpearUseGoal.stop`: the navigation stops, the spear goes down.
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.nav_stop();
    // rust: m.ai.aggressive = false;
    // rust: self.state = None;
    // rust: stop_using_item(m);
}
    /// `SpearUseGoal.tick`.
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(mut state) = self.state.take() {
    // rust: self.step(&mut state, m, cx);
    // rust: self.state = Some(state);
}
}
}

/// `SpearAttack.SpearStatus`: where a piglin is in its charge.
pub const SpearStatus = enum {
    Approach,
    Charging,
    Retreat,
};

/// The spear memories of a piglin's brain (`SPEAR_STATUS` and the like). None
/// of them is saved: they have no codec.
pub const Memories = struct {
    /// `SPEAR_STATUS`.
    status: ?SpearStatus,
    /// `SPEAR_ENGAGE_TIME`: ticks of the charge left.
    engage_time: ?i32,
    /// `SPEAR_CHARGE_POSITION`: where the charge goes to reposition.
    charge_position: Option<[f64,
    /// `SPEAR_FLEEING_TIME`: ticks spent backing off.
    fleeing_time: ?i32,
    /// `SPEAR_FLEEING_POSITION`: where it backs off to.
    fleeing_position: Option<[f64,
};

/// A piglin's `LOOK_TARGET` of an `EntityTracker(target, true)`: its eyes
/// follow the target's eyes.
pub fn look_at_target(m: *mut Mob, eye: [f64; 3]) void {
}
    // rust: m.look_at(eye);
}

/// `SpearApproach.checkExtraStartConditions`: able to attack and not using an
/// item. The behaviour also needs `SPEAR_STATUS` to be absent.
pub fn approach_check_extra_start_conditions(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: able_to_attack(m, w) && !is_using_item(m)
}

/// `SpearApproach.start`: aggressive, and the status is APPROACH.
pub fn approach_start(m: *mut Mob) void {
}
    // rust: m.ai.aggressive = true;
    // rust: m.extra.piglin.spear.status = Some(SpearStatus::Approach);
}

/// `SpearApproach.canStillUse`: able to attack and still farther from the
/// target than the approach distance (`farEnough`).
pub fn approach_can_still_use(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(t) = m.target_info(w) else {
    // rust: return false;
}
    // rust: able_to_attack(m, w)
    // rust: && m.distance_sqr(t.position) > f64::from(PiglinSpear::APPROACH_DISTANCE_SQ)
}

/// `SpearApproach.tick`: look at the target and walk up to it.
pub fn approach_tick(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(t) = m.target_info(cx.w) else { return };
    // rust: let speed_modifier = f64::from(charge_speed_modifier(m, cx.w));
    // rust: look_at_target(m, [t.position.x, t.eye_y, t.position.z]);
    // rust: m.nav_move_to_entity(
    // rust: cx.w,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: 1,
    // rust: speed_modifier * PiglinSpear::SPEED_MODIFIER_WHEN_REPOSITIONING,
    // rust: );
}

/// `SpearApproach.stop`: the walk ends and the charge is next.
pub fn approach_stop(m: *mut Mob) void {
}
    // rust: m.nav_stop();
    // rust: m.extra.piglin.spear.status = Some(SpearStatus::Charging);
}

/// `SpearAttack.checkExtraStartConditions`: the status is CHARGING, able to
/// attack and not using an item.
pub fn attack_check_extra_start_conditions(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.piglin.spear.status.unwrap_or(SpearStatus::Approach) == SpearStatus::Charging
    // rust: && able_to_attack(m, w)
    // rust: && !is_using_item(m)
}

/// `SpearAttack.getKineticWeaponUseDuration`.
pub fn attack_kinetic_weapon_use_duration(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: main_hand_kinetic(m).map_or(0, |k| k.damage_use_duration())
}

/// `SpearAttack.start`: aggressive, the charge lasts the weapon's use time,
/// and the spear goes up.
pub fn attack_start(m: *mut Mob) void {
}
    // rust: m.ai.aggressive = true;
    // rust: m.extra.piglin.spear.engage_time = Some(attack_kinetic_weapon_use_duration(m));
    // rust: m.extra.piglin.spear.charge_position = None;
    // rust: start_using_item(m);
}

/// `SpearAttack.canStillUse`: time left to charge and able to attack.
pub fn attack_can_still_use(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.piglin.spear.engage_time.unwrap_or(0) > 0 && able_to_attack(m, w)
}

/// `SpearAttack.tick`: look at the target, count the charge down and keep
/// moving: run at the target, and once within 2 blocks of it (or at the end
/// of the path) pick a spot 6 to 7 blocks past it to reposition to, then run
/// at the target again from there.
pub fn attack_tick(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(t) = m.target_info(cx.w) else { return };
    // rust: let target_dist_sqr = m.distance_sqr(t.position);
    // rust: let speed_modifier = f64::from(charge_speed_modifier(m, cx.w));
    // rust: let mount_distance = passenger_distance(m);
    // rust: look_at_target(m, [t.position.x, t.eye_y, t.position.z]);
    // rust: let left = m.extra.piglin.spear.engage_time.unwrap_or(0) - 1;
    // rust: m.extra.piglin.spear.engage_time = Some(left);
    // rust: if let Some(away) = m.extra.piglin.spear.charge_position {
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: away,
    // rust: speed_modifier * PiglinSpear::SPEED_MODIFIER_WHEN_REPOSITIONING,
    // rust: );
    // rust: if m.ai.nav.is_done() {
    // rust: m.extra.piglin.spear.charge_position = None;
}
    // rust: } else {
    // rust: m.nav_move_to_entity(
    // rust: cx.w,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: 1,
    // rust: speed_modifier * PiglinSpear::SPEED_MODIFIER_WHEN_CHARGING,
    // rust: );
    // rust: if target_dist_sqr < f64::from(PiglinSpear::TARGET_IN_RANGE_RADIUS_SQ) || m.ai.nav.is_done()
    // rust: {
    // rust: let distance = target_dist_sqr.sqrt();
    // rust: m.extra.piglin.spear.charge_position = m.land_random_pos_away_between(
    // rust: cx.w,
    // rust: f64::from(6 + mount_distance) - distance,
    // rust: f64::from(7 + mount_distance) - distance,
    // rust: 7,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: );
}
}
}

/// `SpearAttack.stop`: the walk ends, the spear goes down and the retreat is next.
pub fn attack_stop(m: *mut Mob) void {
}
    // rust: m.nav_stop();
    // rust: stop_using_item(m);
    // rust: m.extra.piglin.spear.charge_position = None;
    // rust: m.extra.piglin.spear.engage_time = None;
    // rust: m.extra.piglin.spear.status = Some(SpearStatus::Retreat);
}

/// `SpearRetreat.checkExtraStartConditions`: able to attack, not using an
/// item, the status RETREAT and a spot 9 to 11 blocks from the target to back
/// off to (2 more on a mount), which becomes `SPEAR_FLEEING_POSITION`.
pub fn retreat_check_extra_start_conditions(m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !able_to_attack(m, cx.w) || is_using_item(m) {
    // rust: return false;
}
    // rust: if m.extra.piglin.spear.status.unwrap_or(SpearStatus::Approach) != SpearStatus::Retreat {
    // rust: return false;
}
    // rust: let Some(t) = m.target_info(cx.w) else {
    // rust: return false;
}
    // rust: let mount_distance = passenger_distance(m);
    // rust: let distance = m.distance_sqr(t.position).sqrt();
    // rust: let Some(away) = m.land_random_pos_away_between(
    // rust: cx.w,
    // rust: 0.0_f64.max(f64::from(9 + mount_distance) - distance),
    // rust: 1.0_f64.max(f64::from(11 + mount_distance) - distance),
    // rust: 7,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: ) else {
    // rust: return false;
}
    // rust: m.extra.piglin.spear.fleeing_position = Some(away);
    // rust: true
}

/// `SpearRetreat.start`: aggressive, with no time spent backing off yet.
pub fn retreat_start(m: *mut Mob) void {
}
    // rust: m.ai.aggressive = true;
    // rust: m.extra.piglin.spear.fleeing_time = Some(0);
}

/// `SpearRetreat.canStillUse`: under 100 ticks backing off, with a spot to
/// back off to, a walk going on and able to attack.
pub fn retreat_can_still_use(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.piglin.spear.fleeing_time.unwrap_or(100) < 100
    // rust: && m.extra.piglin.spear.fleeing_position.is_some()
    // rust: && !m.ai.nav.is_done()
    // rust: && able_to_attack(m, w)
}

/// `SpearRetreat.tick`: look at the target, count the time and walk to the spot.
pub fn retreat_tick(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(t) = m.target_info(cx.w) else { return };
    // rust: let speed_modifier = f64::from(charge_speed_modifier(m, cx.w));
    // rust: look_at_target(m, [t.position.x, t.eye_y, t.position.z]);
    // rust: let time = m.extra.piglin.spear.fleeing_time.unwrap_or(0) + 1;
    // rust: m.extra.piglin.spear.fleeing_time = Some(time);
    // rust: if let Some(away) = m.extra.piglin.spear.fleeing_position {
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: away,
    // rust: speed_modifier * PiglinSpear::SPEED_MODIFIER_WHEN_REPOSITIONING,
    // rust: );
}
}

/// `SpearRetreat.stop`: the walk ends, the spear is down and the charge starts over.
pub fn retreat_stop(m: *mut Mob) void {
}
    // rust: m.nav_stop();
    // rust: m.ai.aggressive = false;
    // rust: stop_using_item(m);
    // rust: m.extra.piglin.spear.fleeing_time = None;
    // rust: m.extra.piglin.spear.fleeing_position = None;
    // rust: m.extra.piglin.spear.status = None;
}

/// The spear behaviours of a piglin's fight activity, `SpearApproach`,
/// `SpearAttack` and `SpearRetreat`: each starts on the `SPEAR_STATUS` the
/// one before it leaves. The goal runs them in the order of `Brain.tick`:
/// the ones not running try to start, then the running ones tick or stop.
/// Fight is the activity while the piglin has a target; a piglin with a
/// spear never melees (`NoMeleeWithSpear`).
pub const PiglinSpear = struct {
    approach: Timed,
    attack: Timed,
    retreat: Timed,
};
    // rust: impl PiglinSpear {
    /// `new SpearApproach(1.0, 10.0F)`: the squared approach distance.
pub const APPROACH_DISTANCE_SQ: f32 = 10.0 * 10.0;
    /// `new SpearAttack(1.0, 1.0, 2.0F)`: the speed charging and the squared
    /// radius around the target that ends the run at it.
pub const SPEED_MODIFIER_WHEN_CHARGING: f64 = 1.0;
pub const TARGET_IN_RANGE_RADIUS_SQ: f32 = 2.0 * 2.0;
    /// The `speedModifierWhenRepositioning` of the three behaviours.
pub const SPEED_MODIFIER_WHEN_REPOSITIONING: f64 = 1.0;

pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
            // `Behavior(Map)`: a duration of 60 ticks (which `timedOut` ignores).
    // rust: approach: Timed::new(60, 60),
    // rust: attack: Timed::new(60, 60),
            // `super(Map, 100)`: a timeout of 100 ticks.
    // rust: retreat: Timed::new(100, 100),
}
}

    /// Whether the piglin is fighting (it has a target) with a kinetic weapon.
pub fn fighting_with_spear(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.ai.target.is_some() && main_hand_kinetic(m).is_some()
}
}
    // rust: impl Default for PiglinSpear {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new()
}
}
    // rust: impl Goal for PiglinSpear {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::fighting_with_spear(m)
}
pub fn can_continue(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::fighting_with_spear(m)
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
    /// `Behavior.doStop` of the behaviours still running when the fight ends.
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: if self.approach.running {
    // rust: self.approach.running = false;
    // rust: approach_stop(m);
}
    // rust: if self.attack.running {
    // rust: self.attack.running = false;
    // rust: attack_stop(m);
}
    // rust: if self.retreat.running {
    // rust: self.retreat.running = false;
    // rust: retreat_stop(m);
}
}
    /// `Brain.tick`'s `startEachNonRunningBehavior`, then `tickEachRunningBehavior`.
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let now = cx.w.game_time;
    // rust: if !self.approach.running
    // rust: && m.extra.piglin.spear.status.is_none()
    // rust: && approach_check_extra_start_conditions(m, cx.w)
    // rust: {
    // rust: self.approach.begin(cx.lr, now);
    // rust: approach_start(m);
}
    // rust: if !self.attack.running
    // rust: && m.extra.piglin.spear.status.is_some()
    // rust: && attack_check_extra_start_conditions(m, cx.w)
    // rust: {
    // rust: self.attack.begin(cx.lr, now);
    // rust: attack_start(m);
}
    // rust: if !self.retreat.running
    // rust: && m.extra.piglin.spear.status.is_some()
    // rust: && retreat_check_extra_start_conditions(m, cx)
    // rust: {
    // rust: self.retreat.begin(cx.lr, now);
    // rust: retreat_start(m);
}
    // rust: if self.approach.running {
    // rust: if approach_can_still_use(m, cx.w) {
    // rust: approach_tick(m, cx);
    // rust: } else {
    // rust: self.approach.running = false;
    // rust: approach_stop(m);
}
}
    // rust: if self.attack.running {
    // rust: if attack_can_still_use(m, cx.w) {
    // rust: attack_tick(m, cx);
    // rust: } else {
    // rust: self.attack.running = false;
    // rust: attack_stop(m);
}
}
    // rust: if self.retreat.running {
    // rust: if !self.retreat.timed_out(now) && retreat_can_still_use(m, cx.w) {
    // rust: retreat_tick(m, cx);
    // rust: } else {
    // rust: self.retreat.running = false;
    // rust: retreat_stop(m);
}
}
}
}

/// `MeleeAttack.isHoldingUsableNonMeleeWeapon`: a piglin holding a kinetic
/// weapon (`canUseNonMeleeWeapon`) never melees; its spear behaviours attack.
pub const NoMeleeWithSpear = struct {};
/// A kinetic weapon or a crossbow in the main hand: the melee goal stays off.
    // rust: pub(super) fn holds_non_melee_weapon(m: &Mob) -> bool {
    // rust: main_hand_kinetic(m).is_some() || m.extra.main_hand.as_deref() == Some("minecraft:crossbow")
}
    // rust: impl<G: Goal + Clone + 'static> Goal for NoMeleeWithSpear<G> {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.flags()
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.name()
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !holds_non_melee_weapon(m) && self.0.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !holds_non_melee_weapon(m) && self.0.can_continue(m, cx)
}
pub fn interruptable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.interruptable()
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.every_tick()
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx)
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.stop(m, cx)
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.tick(m, cx)
}
}
