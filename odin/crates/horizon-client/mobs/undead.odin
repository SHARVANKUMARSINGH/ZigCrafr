//! Transpiled from Horizon Rust crate
package horizon_client_undead

import "core:fmt"
import "core:mem"
import "core:math"

// Zombies (zombie, husk, drowned, zombie villager) and skeletons (skeleton,
// stray, bogged, wither skeleton): goals, bow attacks, water conversion.
// use super::{
    // rust: Damage, Mob, MobEvent, Species, Who,
    // rust: doors::{BreakDoor, can_navigate_ground, wooden_door},
    // rust: goals::{
    // rust: Avoid, AvoidEntity, Cx, FleeSun, Goal, HurtByTarget, LOOK, LookAtPlayer, MOVE, MeleeAttack,
    // rust: NearestTarget, RandomLookAround, RestrictSun, Stroll, goal_clone,
    // rust: },
    // rust: path::Path,
    // rust: spear_use::SpearUse,
    // rust: villager_brain::{
    // rust: closer_to_center, occupied_pois_in_range, others_tickets, sections_to_village,
    // rust: village_sections,
    // rust: },
}
// use crate::projectiles::{Projectile, ProjectileKind};
// use horizon_core::{geometry::Vec3, random::RandomSource};

// `Zombie.hurtServer`, once the hit landed: a zombie with a target (its own,
// else a living attacker) asks the game to try calling a reinforcement; the
// difficulty, chance and spawn tests are the game's (`call_reinforcements`).
after_hurt :: proc(m: ^Mob, source: ^Damage) {
}
    // rust: if let Some(target) = m.ai.target.or(source.attacker) {
    // rust: m.outbox
    // rust: .push(MobEvent::Reinforcements { mob: m.id, target });
}
}

register :: proc(m: ^Mob) {
}
//     use Species as S;
    // rust: match m.species() {
    // rust: S::Zombie | S::Husk | S::ZombieVillager => {
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, BreakDoor::zombie());
    // rust: g.add(4, AttackTurtleEgg::default());
    // rust: g.add(8, LookAtPlayer::new(8.0));
    // rust: g.add(8, RandomLookAround::default());
            // Zombie.addBehaviourGoals: a spear in hand is used first.
    // rust: g.add(2, SpearUse::new(1.0, 1.0, 10.0, 2.0));
    // rust: g.add(3, MeleeAttack::new(1.0, false).zombie());
    // rust: g.add(
    // rust: 6,
    // rust: MoveThroughVillage::new(1.0, true, 4, |m| m.extra.can_break_doors),
    // rust: );
    // rust: g.add(7, Stroll::avoiding_water(1.0));
    // rust: let t = &mut m.ai.targets;
    // rust: let mut hurt = HurtByTarget::new().alert();
    // rust: hurt.alert_except = vec![S::ZombifiedPiglin];
    // rust: t.add(1, hurt);
    // rust: t.add(2, NearestTarget::player(true));
    // rust: t.add(
    // rust: 3,
    // rust: NearestTarget::species(&[S::Villager, S::WanderingTrader], false),
    // rust: );
    // rust: t.add(3, NearestTarget::species(&[S::IronGolem], true));
    // rust: t.add(
    // rust: 5,
    // rust: NearestTarget::new(
    // rust: super::goals::Prey::Filter(|s| s.species == Species::Turtle && s.baby),
    // rust: true,
    // rust: )
    // rust: .interval(10),
    // rust: );
}
    // rust: S::ZombifiedPiglin => {
            // ZombifiedPiglin.addBehaviourGoals: neutral until provoked.
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, BreakDoor::zombie());
            // `Zombie.registerGoals`, which `ZombifiedPiglin` extends.
    // rust: g.add(4, AttackTurtleEgg::default());
    // rust: g.add(8, LookAtPlayer::new(8.0));
    // rust: g.add(8, RandomLookAround::default());
    // rust: g.add(1, SpearUse::new(1.0, 1.0, 10.0, 2.0));
    // rust: g.add(2, MeleeAttack::new(1.0, false).zombie());
    // rust: g.add(7, Stroll::avoiding_water(1.0));
    // rust: let t = &mut m.ai.targets;
    // rust: t.add(1, HurtByTarget::new().alert());
    // rust: t.add(
    // rust: 2,
    // rust: NearestTarget::player(true)
    // rust: .interval(10)
    // rust: .when(super::tame::angry_at_player),
    // rust: );
}
    // rust: S::Drowned => {
            // Zombie.registerGoals, then Drowned.addBehaviourGoals.
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, BreakDoor::zombie());
    // rust: g.add(4, AttackTurtleEgg::default());
    // rust: g.add(8, LookAtPlayer::new(8.0));
    // rust: g.add(8, RandomLookAround::default());
    // rust: g.add(1, DrownedGoToWater::default());
    // rust: g.add(
    // rust: 2,
    // rust: DrownedTridentAttack(super::witch::RangedAttack::new(
    // rust: 1.0,
    // rust: 40,
    // rust: 40,
    // rust: 10.0,
    // rust: drowned_throw,
    // rust: )),
    // rust: );
    // rust: g.add(2, DrownedAttack(MeleeAttack::new(1.0, false).zombie()));
    // rust: g.add(
    // rust: 5,
    // rust: DrownedGoToBeach(super::goals::MoveToBlock::new(1.0, 8, 2)),
    // rust: );
    // rust: g.add(6, DrownedSwimUp { stuck: false });
    // rust: g.add(7, Stroll::new(1.0));
    // rust: let t = &mut m.ai.targets;
    // rust: let mut hurt = HurtByTarget::new().alert().ignoring(&[S::Drowned]);
    // rust: hurt.alert_except = vec![S::ZombifiedPiglin];
    // rust: t.add(1, hurt);
    // rust: t.add(2, NearestTarget::player(true).when(drowned_can_attack));
    // rust: t.add(
    // rust: 3,
    // rust: NearestTarget::species(&[S::Villager, S::WanderingTrader], false),
    // rust: );
    // rust: t.add(3, NearestTarget::species(&[S::IronGolem], true));
    // rust: t.add(3, NearestTarget::species(&[S::Axolotl], true));
    // rust: t.add(
    // rust: 5,
    // rust: NearestTarget::new(
    // rust: super::goals::Prey::Filter(|s| s.species == Species::Turtle && s.baby),
    // rust: true,
    // rust: )
    // rust: .interval(10),
    // rust: );
            // DrownedMoveControl, AmphibiousPathNavigation, no water malus.
    // rust: m.ai.mov.kind = super::control::MoveKind::Custom;
    // rust: m.ai.nav.kind = super::nav::NavKind::Amphibious {
    // rust: prefers_shallow: false,
}
    // rust: m.ai.nav.can_float = false;
    // rust: m.set_malus(super::path::PathType::Water, 0.0);
}
    // rust: S::Skeleton | S::Stray | S::Bogged | S::Parched | S::WitherSkeleton => {
    // rust: let species = m.species();
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(2, RestrictSun);
    // rust: g.add(3, FleeSun::new(1.0));
    // rust: g.add(
    // rust: 3,
    // rust: AvoidEntity::new(Avoid::Species(vec![S::Wolf]), 6.0, 1.0, 1.2),
    // rust: );
    // rust: g.add(5, Stroll::avoiding_water(1.0));
    // rust: g.add(6, LookAtPlayer::new(8.0));
    // rust: g.add(6, RandomLookAround::default());
    // rust: let t = &mut m.ai.targets;
            // `WitherSkeleton.registerGoals` adds its piglin goal before
            // calling super, so it comes first among the priority 3 goals.
    // rust: if species == S::WitherSkeleton {
    // rust: t.add(
    // rust: 3,
    // rust: NearestTarget::species(&[S::Piglin, S::PiglinBrute], true),
    // rust: );
}
    // rust: t.add(1, HurtByTarget::new());
    // rust: t.add(2, NearestTarget::player(true));
    // rust: t.add(3, NearestTarget::species(&[S::IronGolem], true));
    // rust: t.add(
    // rust: 3,
    // rust: NearestTarget::new(
    // rust: super::goals::Prey::Filter(|s| s.species == Species::Turtle && s.baby),
    // rust: true,
    // rust: )
    // rust: .interval(10),
    // rust: );
            // The AbstractSkeleton constructor's reassessWeaponGoal, after
            // registerGoals; the weapon itself comes with finalizeSpawn.
            // getHardAttackInterval / getAttackInterval.
    // rust: let (hard, normal) = if matches!(species, S::Bogged | S::Parched) {
    // rust: (50, 70)
    // rust: } else {
    // rust: (20, 40)
}
    // rust: m.ai.goals.add(4, SkeletonWeapon::new(hard, normal));
}
    // rust: _ => {}
}
}
// Drowned.okTarget: at night, or when the target is in water.
drowned_can_attack :: proc(_m: ^Mob, w: ^super::MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(p) = &w.player else { return false };
    // rust: !w.daylight || in_water_at(w, p.position)
}
// The target's isInWater, from the water at its feet.
in_water_at :: proc(w: ^super::MobWorld, p: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (x, y, z) = (p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32);
    // rust: w.fluid(x, y, z) == crate::blocks::Fluid::Water
}
// Drowned.okTarget for the current target.
drowned_ok_target :: proc(m: ^Mob, w: ^super::MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.target_info(w)
    // rust: .is_some_and(|t| !w.daylight || in_water_at(w, t.position))
}
// Drowned state: `flag` wantsToSwim (target in water), `flag2` searchingForLand.
// Drowned.wantsToSwim
drowned_wants_to_swim :: proc(m: ^Mob, w: ^super::MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.flag2 || m.target_info(w).is_some_and(|t| in_water_at(w, t.position))
}
// `Drowned.updateSwimming`: swimming under water while it wants to. `flag`
// holds `isSwimming`, which clients take from the entity's shared flags.
drowned_update_swimming :: proc(m: ^Mob, w: ^super::MobWorld) {
}
    // rust: m.extra.flag =
    // rust: !m.no_ai && m.was_eye_in_water && m.fluids.in_water && drowned_wants_to_swim(m, w);
}
// A drowned on a client: `LivingEntity.updateSwimAmount` follows the
// swimming flag (`Drowned.isVisuallySwimming`).
drowned_client_tick :: proc(m: ^Mob) {
}
    // rust: m.extra.swim.tick(m.extra.flag, m.fluids.in_water);
}
// Drowned.DrownedMoveControl
drowned_move_control :: proc(m: ^Mob, w: ^super::MobWorld) {
}
    // rust: let target = m.target_info(w);
    // rust: if drowned_wants_to_swim(m, w) && m.fluids.in_water {
    // rust: if target.is_some_and(|t| t.position.y > m.position.y) || m.extra.flag2 {
    // rust: m.velocity = Vec3::new(m.velocity.x, m.velocity.y + 0.002, m.velocity.z);
}
    // rust: if m.ai.mov.operation != super::control::Operation::MoveTo || m.ai.nav.is_done() {
    // rust: m.set_speed(0.0);
    // rust: return;
}
    // rust: let [wx, wy, wz] = m.ai.mov.wanted;
    // rust: let (xd, mut yd, zd) = (wx - m.position.x, wy - m.position.y, wz - m.position.z);
    // rust: let dd = (xd * xd + yd * yd + zd * zd).sqrt();
    // rust: yd /= dd;
    // rust: let y_rot = horizon_core::geometry::trig::atan2_degrees(zd, xd) - 90.0;
    // rust: m.yaw = super::control::rotlerp(m.yaw, y_rot, 90.0);
    // rust: m.body_yaw = m.yaw;
    // rust: let target_speed = (m.ai.mov.speed_modifier * m.movement_speed()) as f32;
    // rust: let speed = m.ai.speed + 0.125 * (target_speed - m.ai.speed);
    // rust: m.set_speed(speed);
    // rust: let s = f64::from(speed);
    // rust: m.velocity = Vec3::new(
    // rust: m.velocity.x + s * xd * 0.005,
    // rust: m.velocity.y + s * yd * 0.1,
    // rust: m.velocity.z + s * zd * 0.005,
    // rust: );
    // rust: } else {
    // rust: if !m.on_ground {
    // rust: m.velocity = Vec3::new(m.velocity.x, m.velocity.y - 0.008, m.velocity.z);
}
    // rust: let speed = m.movement_speed();
    // rust: m.ground_move_tick(w, speed);
}
}
// Drowned.travelInWater: swimming under water slowly when it wants to.
    // rust: pub fn drowned_travel(
    // rust: m: &mut Mob,
    // rust: w: &super::MobWorld,
    // rust: input: Vec3,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) -> bool {
    // isUnderWater: wasEyeInWater && isInWater.
    // rust: if !(m.was_eye_in_water && m.fluids.in_water && drowned_wants_to_swim(m, w)) {
    // rust: return false;
}
    // rust: m.move_relative(0.01, input);
    // rust: m.do_move(w, events);
    // rust: m.velocity = Vec3::new(m.velocity.x * 0.9, m.velocity.y * 0.9, m.velocity.z * 0.9);
    // rust: true
}
// `RangedAttackMob.rangedAttackUncertainty`: 14 on peaceful, four less per
// difficulty step, so a hard drowned throws its trident almost straight.
// `Drowned` overrides it to return its own field when that is not negative,
// but nothing in the game sets that field, so the default always applies.
ranged_attack_uncertainty :: proc(difficulty: u8) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 14.0 - 4.0 * f32::from(difficulty)
}
// The trident throw of `Drowned.performRangedAttack`: a `ThrownTrident` of
// the held trident (a plain one when it holds none), owned by the drowned,
// which cannot be picked up and does not return (`AbstractArrow` constructor:
// only a player's projectile is `Pickup.ALLOWED`).
drowned_throw :: proc(m: ^Mob, who: Who, _power: f32, cx: ^Cx) {
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let start = Vec3::new(m.position.x, m.eye_y() - 0.1, m.position.z);
    // rust: let xd = t.position.x - m.position.x;
    // rust: let yd = t.position.y + (t.bounds.max_position().y - t.bounds.min_position().y) / 3.0 - start.y;
    // rust: let zd = t.position.z - m.position.z;
    // rust: let dist = (xd * xd + zd * zd).sqrt();
    // rust: let mut trident = crate::items::ItemStack::new("minecraft:trident", 1);
    // rust: if m.extra.main_hand.as_deref() == Some("minecraft:trident")
    // rust: && let Some(g) = super::gear::gear(m)
    // rust: {
    // rust: for (e, l) in &g.slots[super::gear::MAIN] {
    // rust: trident.enchant(e, *l);
}
}
    // rust: let mut p = Projectile::new(ProjectileKind::Trident, start, Some(Who::Mob(m.id)));
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: a.set_item(&trident);
}
    // rust: p.shoot(
    // rust: &mut crate::projectiles::own_random(m),
    // rust: [xd, yd + dist * f64::from(0.2_f32), zd],
    // rust: 1.6,
    // rust: ranged_attack_uncertainty(cx.w.difficulty.id),
    // rust: );
    // rust: cx.events.push(MobEvent::Projectile(p));
    // rust: let pitch = 1.0 / (m.random.next_float() * 0.4 + 0.8);
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.drowned.shoot",
    // rust: m.center(),
    // rust: 1.0,
    // rust: pitch,
    // rust: ));
}
// Drowned.DrownedTridentAttackGoal: the ranged goal while holding a trident.
DrownedTridentAttack :: struct {
    // rust: impl Goal for DrownedTridentAttack {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "DrownedTridentAttackGoal"
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_use(m, cx) && m.extra.main_hand.as_deref() == Some("minecraft:trident")
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_continue(m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx);
    // rust: m.ai.aggressive = true;
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx);
    // rust: m.ai.aggressive = false;
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.every_tick()
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.tick(m, cx)
}
}
// Drowned.DrownedAttackGoal: ZombieAttackGoal on a target it may attack.
DrownedAttack :: struct {
    // rust: impl Goal for DrownedAttack {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "DrownedAttackGoal"
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_use(m, cx) && drowned_ok_target(m, cx.w)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_continue(m, cx) && drowned_ok_target(m, cx.w)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx)
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.every_tick()
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.tick(m, cx)
}
}
// Drowned.DrownedGoToBeachGoal: at night, swim near the surface to a
// standable block with air above.
DrownedGoToBeach :: struct {
beach_target :: proc(w: ^super::MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let empty = |y: i32| {
    // rust: let state = w.world.block(p[0], y, p[2]);
    // rust: w.facts.is_air(state) && w.facts.get(state).fluid == crate::blocks::Fluid::None
}
    // BlockState.entityCanStandOn: a full top face.
    // rust: empty(p[1] + 1)
    // rust: && empty(p[1] + 2)
    // rust: && w.facts.get(w.world.block(p[0], p[1], p[2])).sturdy_full & (1 << 1) != 0
}
    // rust: impl Goal for DrownedGoToBeach {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | super::goals::JUMP
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "DrownedGoToBeachGoal"
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
        // MoveToBlockGoal.canUse, then the drowned's conditions.
    // rust: if self.0.next_start > 0 {
    // rust: self.0.next_start -= 1;
    // rust: return false;
}
    // rust: self.0.next_start = super::goals::reduced(200 + m.random.next_int_bound(200).unwrap_or(0));
    // rust: self.0.find_nearest(m, cx.w, beach_target)
    // rust: && !cx.w.daylight
    // rust: && m.fluids.in_water
    // rust: && m.position.y >= f64::from(cx.w.sea_level - 3)
}
can_continue :: proc(self: ^Self, _m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_continue(cx.w, beach_target)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.extra.flag2 = false;
    // rust: self.0.start(m, cx.w);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.tick(m, cx.w);
}
}
// Drowned.DrownedSwimUpGoal: at night, deep in water, head for the surface.
DrownedSwimUp :: struct {
    stuck: bool,
}
    // rust: impl Goal for DrownedSwimUp {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "DrownedSwimUpGoal"
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !cx.w.daylight && m.fluids.in_water && m.position.y < f64::from(cx.w.sea_level - 2)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.can_use(m, cx) && !self.stuck
}
start :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: m.extra.flag2 = true;
    // rust: self.stuck = false;
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: m.extra.flag2 = false;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let sea = f64::from(cx.w.sea_level);
    // rust: if m.position.y < sea - 1.0 && (m.ai.nav.is_done() || drowned_close_to_next_pos(m)) {
    // rust: let to = [m.position.x, sea - 1.0, m.position.z];
    // rust: match m.default_random_pos_towards(cx.w, 4, 8, to, std::f64::consts::FRAC_PI_2) {
    // rust: None => self.stuck = true,
    // rust: Some(p) => {
    // rust: m.nav_move_to(cx.w, p, 1.0);
}
}
}
}
}
// Drowned.closeToNextPos: within two blocks of the path's target.
drowned_close_to_next_pos :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.nav.path.as_ref().is_some_and(|p| {
    // rust: let t = p.target;
    // rust: m.distance_sqr(Vec3::new(f64::from(t[0]), f64::from(t[1]), f64::from(t[2]))) < 4.0
    // rust: })
}
// Zombie drowning conversion (Zombie.DrowningTracker) and husk -> zombie.
// `ZombifiedPiglin.customServerAiStep`: faster and loud while angry,
// forgetting the player when the anger runs out, rallying the others.
zombified_piglin_step :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let base = 0.23;
    // NeutralMob.updatePersistentAnger: a new target starts 20-39 s of anger.
    // rust: if m.ai.target.is_some() && !m.extra.flag2 {
    // rust: m.extra.flag2 = true;
    // rust: m.extra.anger = 400 + m.random.next_int_bound(380).unwrap_or(0);
    // rust: m.extra.counter = m.random.next_int_bound(21).unwrap_or(0).max(1);
    // rust: m.extra.counter2 = 80 + m.random.next_int_bound(41).unwrap_or(0);
    // rust: } else if m.ai.target.is_none() {
    // rust: m.extra.flag2 = false;
}
    // The anger's target is whoever the piglin holds as its target, so a
    // piglin hit by another mob is angry at that mob and not at the player
    // (`NearestAttackableTargetGoal` tests `isAngryAt`).
    // rust: if m.ai.target.is_some() {
    // rust: m.extra.angry_at = m.ai.target;
}
    // rust: if m.extra.anger > 0 {
    // rust: m.extra.anger -= 1;
    // rust: if !m.is_baby() {
    // rust: m.attrs.speed = base + 0.05;
}
        // playFirstAngerSoundIn
    // rust: if m.extra.counter > 0 {
    // rust: m.extra.counter -= 1;
    // rust: if m.extra.counter == 0 {
    // rust: let base = if m.is_baby() { 1.5 } else { 1.0 };
    // rust: let pitch = ((m.random.next_float() - m.random.next_float()) * 0.2 + base) * 1.8;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.zombified_piglin.angry",
    // rust: m.center(),
    // rust: 2.0,
    // rust: pitch,
    // rust: ));
}
}
    // rust: if m.extra.anger == 0 {
    // rust: m.ai.target = None;
    // rust: m.extra.angry_at = None;
    // rust: m.extra.flag2 = false;
}
    // rust: } else {
    // rust: m.attrs.speed = base;
}
    // maybeAlertOthers every 4 to 6 seconds while seeing the target.
    // rust: if let Some(target) = m.ai.target {
    // rust: if m.extra.counter2 > 0 {
    // rust: m.extra.counter2 -= 1;
    // rust: } else {
    // rust: if m.sees(cx.w, target) {
    // rust: let range = m.attrs.follow_range;
    // rust: let (id, pos) = (m.id, m.position);
    // rust: let others: Vec<u32> =
    // rust: cx.w.others
    // rust: .iter()
    // rust: .filter(|s| {
    // rust: s.id != id
    // rust: && s.alive
    // rust: && s.species == Species::ZombifiedPiglin
    // rust: && s.target.is_none()
    // rust: && (s.position.x - pos.x).abs() <= range + 1.0
    // rust: && (s.position.y - pos.y).abs() <= 11.0
    // rust: && (s.position.z - pos.z).abs() <= range + 1.0
    // rust: })
    // rust: .map(|s| s.id)
    // rust: .collect();
    // rust: for other in others {
    // rust: cx.events.push(MobEvent::SetTarget { mob: other, target });
}
}
    // rust: m.extra.counter2 = 80 + m.random.next_int_bound(41).unwrap_or(0);
}
}
}
// `Entity.isInPowderSnow`: the mob's box, shrunk by `1.0E-5` as in
// `checkInsideBlocks`, touches powder snow.
in_powder_snow :: proc(m: ^Mob, w: ^super::MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = m.bounds().deflate(Vec3::new(1e-5, 1e-5, 1e-5));
    // rust: let (min, max) = (b.min_position(), b.max_position());
    // rust: for x in min.x.floor() as i32..=max.x.floor() as i32 {
    // rust: for y in min.y.floor() as i32..=max.y.floor() as i32 {
    // rust: for z in min.z.floor() as i32..=max.z.floor() as i32 {
    // rust: if &*w.facts.get(w.world.block(x, y, z)).name == "minecraft:powder_snow" {
    // rust: return true;
}
}
}
}
    // rust: false
}
// `Skeleton.freezingTracker` (`ConversionTracker.tick`): 140 ticks in
// powder snow start a conversion into a stray that takes 300 more; leaving
// the snow stops it. `counter` is the affliction time (-1 outside the snow)
// and `counter2` the conversion time plus one while converting, so that
// reaching 0 is vanilla's `conversionTime < 0`.
skeleton_freezing :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: if !in_powder_snow(m, cx.w) {
    // rust: m.extra.counter = -1;
    // rust: m.extra.counter2 = 0;
    // rust: } else if m.extra.counter2 > 0 {
    // rust: m.extra.counter2 -= 1;
    // rust: if m.extra.counter2 == 0 {
            // ConversionTracker.doConversion: convertTo(STRAY,
            // ConversionParams.single(this, true, true)).
    // rust: convert(m, "minecraft:stray", cx);
            // levelEvent 1048: the conversion sound at the stray, unless it
            // is silent.
    // rust: if !m.silent {
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.skeleton.converted_to_stray",
    // rust: m.center(),
    // rust: 2.0,
    // rust: pitch,
    // rust: ));
}
}
    // rust: } else {
    // rust: m.extra.counter += 1;
    // rust: if m.extra.counter >= 140 {
    // rust: m.extra.counter2 = 301;
}
}
}
// `Mob.convertTo(kind, ConversionParams.single(this, true, true))`: the
// mob is discarded and a new one of `kind` takes its place with its
// equipment, name, effects and flags (`MobEvent::Convert`).
convert :: proc(m: ^Mob, kind: ^'static str, cx: ^Cx) {
}
    // rust: cx.events.push(MobEvent::Convert {
    // rust: from: Box::new(m.clone()),
    // rust: kind,
    // rust: params: super::conversion::Params::KEEP_ALL,
    // rust: });
    // rust: m.removed = true;
}
custom_server_ai_step :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: if m.species() == Species::Skeleton && m.alive() && !m.no_ai {
    // rust: skeleton_freezing(m, cx);
}
    // rust: if m.species() == Species::ZombifiedPiglin {
    // rust: return zombified_piglin_step(m, cx);
}
    // rust: if matches!(m.species(), Species::Zombie | Species::Husk) && m.alive() {
    // rust: if m.extra.counter2 > 0 && !m.fluids.eye_in_water {
            // ConversionTracker.tick: leaving the water ends a started
            // conversion too.
    // rust: m.extra.counter = -1;
    // rust: m.extra.counter2 = 0;
    // rust: } else if m.extra.counter2 > 0 {
    // rust: m.extra.counter2 -= 1;
    // rust: if m.extra.counter2 == 0 {
    // rust: let (kind, sound) = if m.species() == Species::Husk {
    // rust: ("minecraft:zombie", "entity.husk.converted_to_zombie")
    // rust: } else {
    // rust: ("minecraft:drowned", "entity.zombie.converted_to_drowned")
}
                // ConversionTracker.doConversion: convertTo(type,
                // ConversionParams.single(this, true, true)); levelEvent
                // 1040 or 1041 unless the new mob is silent.
    // rust: convert(m, kind, cx);
    // rust: if !m.silent {
    // rust: cx.events.push(MobEvent::Sound(sound, m.center(), 1.0, 1.0));
}
}
    // rust: } else if m.fluids.eye_in_water {
    // rust: m.extra.counter += 1;
    // rust: if m.extra.counter >= 600 {
    // rust: m.extra.counter2 = 300;
}
    // rust: } else {
    // rust: m.extra.counter = -1;
}
}
}
// `AbstractSkeleton.reassessWeaponGoal`'s goal: the bow goal while holding a
// bow, otherwise the melee goal (the anonymous `AbstractSkeleton$1`).
SkeletonWeapon :: struct {
    bow: BowAttack,
    melee: MeleeAttack,
    use_bow: bool,
    // The weapon the goal was last reassessed for.
    assessed: Maybe(bool),
    hard_interval: i32,
    normal_interval: i32,
}
    // rust: impl SkeletonWeapon {
new :: proc(hard_interval: i32, normal_interval: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: bow: BowAttack::new(1.0, normal_interval, 15.0),
    // rust: melee: MeleeAttack::new(1.2, false),
    // rust: use_bow: false,
    // rust: assessed: None,
    // rust: hard_interval,
    // rust: normal_interval,
}
}
}
    // rust: impl Goal for SkeletonWeapon {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if self.use_bow {
    // rust: "BowAttack"
    // rust: } else {
    // rust: "AbstractSkeleton$1"
}
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.use_bow {
    // rust: self.bow.every_tick()
    // rust: } else {
    // rust: self.melee.every_tick()
}
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
        // The goal registered for the weapon in hand.
    // rust: self.use_bow = holding_bow(m);
        // reassessWeaponGoal: a bow gets the hard interval only on Hard; it
        // is picked again when the weapon changes (the first check after
        // spawning or loading stands for finalizeSpawn and
        // readAdditionalSaveData).
    // rust: if self.assessed != Some(self.use_bow) {
    // rust: self.assessed = Some(self.use_bow);
    // rust: self.bow.interval_min = if cx.w.difficulty.hard {
    // rust: self.hard_interval
    // rust: } else {
    // rust: self.normal_interval
}
}
    // rust: if self.use_bow {
    // rust: self.bow.can_use(m, cx)
    // rust: } else {
    // rust: self.melee.can_use(m, cx)
}
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
        // Changing weapons removes the running goal.
    // rust: if self.use_bow != holding_bow(m) {
    // rust: return false;
}
    // rust: if self.use_bow {
    // rust: self.bow.can_continue(m, cx)
    // rust: } else {
    // rust: self.melee.can_continue(m, cx)
}
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if self.use_bow {
    // rust: self.bow.start(m, cx)
    // rust: } else {
    // rust: self.melee.start(m, cx)
}
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if self.use_bow {
    // rust: self.bow.stop(m, cx)
    // rust: } else {
    // rust: self.melee.stop(m, cx)
}
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if self.use_bow {
    // rust: self.bow.tick(m, cx)
    // rust: } else {
    // rust: self.melee.tick(m, cx)
}
}
}
// RangedBowAttackGoal for skeletons.
BowAttack :: struct {
    speed: f64,
    interval_min: i32,
    radius_sqr: f32,
    attack_time: i32,
    see_time: i32,
    strafe_clockwise: bool,
    strafe_back: bool,
    strafe_time: i32,
}
    // rust: impl BowAttack {
new :: proc(speed: f64, interval_min: i32, radius: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: interval_min,
    // rust: radius_sqr: radius * radius,
    // rust: attack_time: -1,
    // rust: see_time: 0,
    // rust: strafe_clockwise: false,
    // rust: strafe_back: false,
    // rust: strafe_time: -1,
}
}
}
// `LivingEntity.isHolding(Items.BOW)`: the bow can sit in either hand.
holding_bow :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.main_hand.as_deref() == Some("minecraft:bow")
    // rust: || m.extra.off_hand.as_deref() == Some("minecraft:bow")
}
    // rust: impl Goal for BowAttack {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.target.is_some() && holding_bow(m)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (self.can_use(m, cx) || !m.ai.nav.is_done()) && holding_bow(m)
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.aggressive = true;
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.aggressive = false;
    // rust: self.see_time = 0;
    // rust: self.attack_time = -1;
    // rust: m.extra.using_item = 0;
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(who) = m.ai.target else { return };
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let d = m.distance_sqr(t.position);
    // rust: let sees = m.sees(cx.w, who);
    // rust: if sees != (self.see_time > 0) {
    // rust: self.see_time = 0;
}
    // rust: if sees {
    // rust: self.see_time += 1;
    // rust: } else {
    // rust: self.see_time -= 1;
}
    // rust: if d <= f64::from(self.radius_sqr) && self.see_time >= 20 {
    // rust: m.nav_stop();
    // rust: self.strafe_time += 1;
    // rust: } else {
    // rust: m.nav_move_to_entity(
    // rust: cx.w,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: 1,
    // rust: self.speed,
    // rust: );
    // rust: self.strafe_time = -1;
}
    // rust: if self.strafe_time >= 20 {
    // rust: if m.random.next_float() < 0.3 {
    // rust: self.strafe_clockwise = !self.strafe_clockwise;
}
    // rust: if m.random.next_float() < 0.3 {
    // rust: self.strafe_back = !self.strafe_back;
}
    // rust: self.strafe_time = 0;
}
    // rust: let eye = [t.position.x, t.eye_y, t.position.z];
    // rust: if self.strafe_time > -1 {
    // rust: if d > f64::from(self.radius_sqr * 0.75) {
    // rust: self.strafe_back = false;
    // rust: } else if d < f64::from(self.radius_sqr * 0.25) {
    // rust: self.strafe_back = true;
}
    // rust: m.ai.mov.strafe(
    // rust: if self.strafe_back { -0.5 } else { 0.5 },
    // rust: if self.strafe_clockwise { 0.5 } else { -0.5 },
    // rust: );
    // rust: m.turn_to(eye, 30.0, 30.0);
    // rust: } else {
    // rust: m.look_at_speed(eye, 30.0, 30.0);
}
    // rust: if m.extra.using_item > 0 {
    // rust: if !sees && self.see_time < -60 {
    // rust: m.extra.using_item = 0;
    // rust: } else if sees {
    // rust: let pull = m.extra.using_item;
    // rust: if pull >= 20 {
    // rust: m.extra.using_item = 0;
    // rust: perform_ranged_attack(m, who, cx, bow_power(pull));
    // rust: self.attack_time = self.interval_min;
}
}
    // rust: if m.extra.using_item > 0 {
    // rust: m.extra.using_item += 1;
}
    // rust: } else {
    // rust: self.attack_time -= 1;
    // rust: if self.attack_time <= 0 && self.see_time >= -60 {
                // mob.startUsingItem(ProjectileUtil.getWeaponHoldingHand):
                // the off hand when the main one doesn't hold the bow.
    // rust: m.extra.using_item = 1;
    // rust: m.extra.using_off_hand = m.extra.main_hand.as_deref() != Some("minecraft:bow");
}
}
}
}
// BowItem.getPowerForTime
bow_power :: proc(ticks: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let t = ticks as f32 / 20.0;
    // rust: ((t * t + t * 2.0) / 3.0).min(1.0)
}
// AbstractSkeleton.performRangedAttack: aim 20% above the target's lower
// third, speed 1.6, uncertainty 14 - 4 * difficulty.
perform_ranged_attack :: proc(m: ^Mob, who: Who, cx: ^Cx, power: f32) {
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let start = Vec3::new(m.position.x, m.eye_y() - 0.1, m.position.z);
    // rust: let height = t.bounds.max_position().y - t.bounds.min_position().y;
    // rust: let xd = t.position.x - m.position.x;
    // rust: let yd = t.position.y + height / 3.0 - start.y;
    // rust: let zd = t.position.z - m.position.z;
    // rust: let dist = (xd * xd + zd * zd).sqrt();
    // AbstractArrow.setBaseDamageFromMob: power * 2 + triangle(difficulty * 0.11, 0.57425).
    // rust: let id = i32::from(cx.w.difficulty.id);
    // rust: let mut arrow_random = crate::projectiles::own_random(m);
    // rust: let base = f64::from(power) * 2.0 + arrow_random.triangle(f64::from(id) * 0.11, 0.574_25);
    // rust: let effect = match m.species() {
    // rust: Species::Stray => Some(("minecraft:slowness", 600)),
    // rust: Species::Bogged => Some(("minecraft:poison", 100)),
    // rust: Species::Parched => Some(("minecraft:weakness", 600)),
    // rust: _ => None,
}
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::Arrow {
    // rust: base_damage: base,
    // rust: critical: false,
    // rust: effect,
    // rust: },
    // rust: start,
    // rust: Some(Who::Mob(m.id)),
    // rust: );
    // rust: p.set_bonus(super::gear::arrow_bonus(m));
    // rust: ignite_for_wither_skeleton(m, &mut p);
    // rust: p.shoot(
    // rust: &mut arrow_random,
    // rust: [xd, yd + dist * 0.2, zd],
    // rust: 1.6,
    // rust: (14 - id * 4) as f32,
    // rust: );
    // rust: cx.events.push(MobEvent::BowShot {
    // rust: mob: m.id,
        // ProjectileUtil.getWeaponHoldingHand(this, Items.BOW).
    // rust: weapon: if m.extra.using_off_hand {
    // rust: m.extra
    // rust: .off_hand
    // rust: .as_ref()
    // rust: .map(|item| crate::items::ItemStack::new(item, 1))
    // rust: } else {
    // rust: m.extra.main_hand_stack().cloned()
}
    // rust: .unwrap_or_else(|| crate::items::ItemStack::new("minecraft:bow", 1)),
    // rust: arrow: p,
    // rust: });
    // rust: let pitch = 1.0 / (m.random.next_float() * 0.4 + 0.8);
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.skeleton.shoot",
    // rust: m.center(),
    // rust: 1.0,
    // rust: pitch,
    // rust: ));
}
// `WitherSkeleton.getArrow`: the arrow the parent made is then
// `igniteForSeconds(100)` — 2000 fire ticks — so it burns on its way and sets
// alight what it hits. The species' own tipped effect rides on the same arrow.
ignite_for_wither_skeleton :: proc(m: ^Mob, p: ^Projectile) {
}
    // rust: if m.species() == Species::WitherSkeleton
    // rust: && let Some(a) = p.arrow.as_mut()
    // rust: {
    // rust: a.ignite_for_seconds(100.0);
}
}
// Drowned.DrownedGoToWaterGoal.
DrownedGoToWater :: struct {
    wanted: [f64,
}
    // rust: impl Goal for DrownedGoToWater {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
    // `Drowned.DrownedGoToWaterGoal.canUse`.
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !cx.w.daylight || m.fluids.in_water {
    // rust: return false;
}
    // rust: let (bx, by, bz) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: for _ in 0..10 {
    // rust: let p = [
    // rust: bx + m.random.next_int_bound(20).unwrap_or(0) - 10,
    // rust: by + 2 - m.random.next_int_bound(8).unwrap_or(0),
    // rust: bz + m.random.next_int_bound(20).unwrap_or(0) - 10,
    // rust: ];
            // getBlockState(pos).is(Blocks.WATER): kelp, seagrass and
            // waterlogged blocks hold water but are not the water block.
    // rust: if cx.w.block_name(p[0], p[1], p[2]) == "minecraft:water" {
    // rust: self.wanted = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: return true;
}
}
    // rust: false
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.nav_move_to(cx.w, self.wanted, 1.0);
}
}

// `MoveThroughVillageGoal`: at night, walk to a village point of interest
// (a taken one) not visited lately, and on to the next.
MoveThroughVillage :: struct {
    speed: f64,
    only_at_night: bool,
    distance: i32,
    can_deal_with_doors: fn(^Mob) -> bool,
    path: Maybe(Path),
    poi: [i32,
    visited: Vec<[i32,
}
    // rust: impl MoveThroughVillage {
    // `MoveThroughVillageGoal.<init>`.
    // rust: pub fn new(
    // rust: speed: f64,
    // rust: only_at_night: bool,
    // rust: distance: i32,
    // rust: can_deal_with_doors: fn(&Mob) -> bool,
    // rust: ) -> Self {
    // rust: Self {
    // rust: speed,
    // rust: only_at_night,
    // rust: distance,
    // rust: can_deal_with_doors,
    // rust: path: None,
    // rust: poi: [0; 3],
    // rust: visited: Vec::new(),
}
}
}
    // rust: impl Goal for MoveThroughVillage {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
    // `MoveThroughVillageGoal.canUse`.
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !can_navigate_ground(m) {
    // rust: return false;
}
        // updateVisited: the list keeps its last 16.
    // rust: if self.visited.len() > 15 {
    // rust: self.visited.remove(0);
}
    // rust: if self.only_at_night && cx.w.daylight {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let block = |p: Vec3| [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32];
    // rust: let section = |p: [i32; 3]| [p[0] >> 4, p[1] >> 4, p[2] >> 4];
    // rust: let pos = block(m.position);
    // rust: let villages = village_sections(m, w);
        // ServerLevel.isCloseToVillage(pos, 6).
    // rust: if sections_to_village(&villages, section(pos)) > 6 {
    // rust: return false;
}
    // rust: let taken = others_tickets(m, w);
    // rust: let visited = &self.visited;
    // rust: let land = m.land_random_pos_scored(w, 15, 7, |p| {
    // rust: if sections_to_village(&villages, section(p)) > 1 {
    // rust: return f64::NEG_INFINITY;
}
            // The first unvisited taken point within 10, by its distance.
    // rust: occupied_pois_in_range(w, &taken, p, 10)
    // rust: .into_iter()
    // rust: .find(|q| !visited.contains(q))
    // rust: .map_or(f64::NEG_INFINITY, |q| {
    // rust: let d = |i: usize| f64::from(q[i] - pos[i]);
    // rust: -(d(0) * d(0) + d(1) * d(1) + d(2) * d(2))
    // rust: })
    // rust: });
    // rust: let Some(land) = land else { return false };
    // rust: let Some(target) =
    // rust: occupied_pois_in_range(w, &taken, block(Vec3::new(land[0], land[1], land[2])), 10)
    // rust: .into_iter()
    // rust: .find(|q| !self.visited.contains(q))
    // rust: else {
    // rust: return false;
}
    // rust: self.poi = target;
    // rust: let doors = (self.can_deal_with_doors)(m);
    // rust: m.ai.nav.can_open_doors = doors;
    // rust: let mut path = m.create_path_to(w, self.poi, 0);
    // rust: m.ai.nav.can_open_doors = true;
    // rust: if path.is_none() {
            // No way there: a step of up to 10 blocks toward it instead.
    // rust: let to = [
    // rust: f64::from(self.poi[0]) + 0.5,
    // rust: f64::from(self.poi[1]),
    // rust: f64::from(self.poi[2]) + 0.5,
    // rust: ];
    // rust: let Some(step) =
    // rust: m.default_random_pos_towards(w, 10, 7, to, f64::from(std::f32::consts::FRAC_PI_2))
    // rust: else {
    // rust: return false;
}
    // rust: m.ai.nav.can_open_doors = doors;
    // rust: path = m.create_path_to(w, block(Vec3::new(step[0], step[1], step[2])), 0);
    // rust: m.ai.nav.can_open_doors = true;
    // rust: if path.is_none() {
    // rust: return false;
}
}
        // A wooden door on the way: only as far as the door.
    // rust: let door = path.as_ref().and_then(|p| {
    // rust: p.nodes
    // rust: .iter()
    // rust: .find(|n| wooden_door(w, [n.x, n.y + 1, n.z]))
    // rust: .map(|n| [n.x, n.y, n.z])
    // rust: });
    // rust: if let Some(at) = door {
    // rust: path = m.create_path_to(w, at, 0);
}
    // rust: self.path = path;
    // rust: self.path.is_some()
}
    // `MoveThroughVillageGoal.canContinueToUse`.
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
    // rust: && !closer_to_center(
    // rust: self.poi,
    // rust: m.position,
    // rust: f64::from(m.width()) + f64::from(self.distance),
    // rust: )
}
    // `MoveThroughVillageGoal.start`.
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.nav_move_to_path(cx.w, self.path.clone(), self.speed);
}
    // `MoveThroughVillageGoal.stop`: a point reached (or the walk ended) is
    // visited.
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: if m.ai.nav.is_done() || closer_to_center(self.poi, m.position, f64::from(self.distance)) {
    // rust: self.visited.push(self.poi);
}
}
}
// `Zombie.ZombieAttackTurtleEggGoal` (a `RemoveBlockGoal` on turtle eggs):
// walk to a turtle egg within 24 blocks and trample it.
AttackTurtleEgg :: struct {
    base: super::goals::MoveToBlock,
    since_reached: i32,
}
    // rust: impl Default for AttackTurtleEgg {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: base: super::goals::MoveToBlock::new(1.0, 24, 3),
    // rust: since_reached: 0,
}
}
}
// RemoveBlockGoal.isValidTarget: the block with two air blocks above, in a loaded chunk.
turtle_egg_target :: proc(w: ^super::MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.world.loaded(p[0], p[2])
    // rust: && w.block_name(p[0], p[1], p[2]) == "minecraft:turtle_egg"
    // rust: && w.facts.is_air(w.world.block(p[0], p[1] + 1, p[2]))
    // rust: && w.facts.is_air(w.world.block(p[0], p[1] + 2, p[2]))
}
    // rust: impl Goal for AttackTurtleEgg {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | super::goals::JUMP
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // RemoveBlockGoal.canUse
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !cx.w.mob_griefing {
    // rust: return false;
}
    // rust: if self.base.next_start > 0 {
    // rust: self.base.next_start -= 1;
    // rust: return false;
}
        // Most of the level holds no turtle egg: its sections' palettes say
        // so without the walk of every cell in reach.
    // rust: let egg = |s| &*cx.w.facts.get(s).name == "minecraft:turtle_egg";
    // rust: if self.base.may_find(m, cx.w, egg) && self.base.find_nearest(m, cx.w, turtle_egg_target) {
    // rust: self.base.next_start = super::goals::reduced(20);
    // rust: return true;
}
        // MoveToBlockGoal.nextStartTick
    // rust: self.base.next_start =
    // rust: super::goals::reduced(200 + m.random.next_int_bound(200).unwrap_or(0));
    // rust: false
}
can_continue :: proc(self: ^Self, _m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.base.can_continue(cx.w, turtle_egg_target)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.base.start(m, cx.w);
    // rust: self.since_reached = 0;
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: m.fall_distance = 1.0;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.base.tick_within(m, cx.w, 1.14);
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: let egg = |p: [i32; 3]| cx.w.block_name(p[0], p[1], p[2]) == "minecraft:turtle_egg";
    // rust: let eat = [
    // rust: at,
    // rust: [at[0], at[1] - 1, at[2]],
    // rust: [at[0] - 1, at[1], at[2]],
    // rust: [at[0] + 1, at[1], at[2]],
    // rust: [at[0], at[1], at[2] - 1],
    // rust: [at[0], at[1], at[2] + 1],
    // rust: [at[0], at[1] - 2, at[2]],
    // rust: ]
    // rust: .into_iter()
    // rust: .find(|p| egg(*p));
    // rust: let Some(eat) = eat.filter(|_| self.base.reached) else {
    // rust: return;
}
    // rust: let center = [
    // rust: f64::from(eat[0]) + 0.5,
    // rust: f64::from(eat[1]) + 0.7,
    // rust: f64::from(eat[2]) + 0.5,
    // rust: ];
    // rust: if self.since_reached > 0 {
    // rust: m.velocity.y = 0.3;
            // The egg crumb particles' spread.
    // rust: for _ in 0..3 {
    // rust: m.random.next_float();
}
    // rust: cx.events.push(MobEvent::Particles {
    // rust: kind: "item_egg",
    // rust: at: center,
    // rust: count: 3,
    // rust: });
}
    // rust: if self.since_reached % 2 == 0 {
    // rust: m.velocity.y = -0.3;
    // rust: if self.since_reached % 6 == 0 {
    // rust: let pitch = 0.9 + m.random.next_float() * 0.2;
    // rust: let b = self.base.block;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.zombie.destroy_egg",
    // rust: [
    // rust: f64::from(b[0]) + 0.5,
    // rust: f64::from(b[1]) + 0.5,
    // rust: f64::from(b[2]) + 0.5,
    // rust: ],
    // rust: 0.5,
    // rust: pitch,
    // rust: ));
}
}
    // rust: if self.since_reached > 60 {
    // rust: cx.events.push(MobEvent::BreakBlock {
    // rust: pos: eat,
    // rust: drop: false,
    // rust: });
            // `sendParticles(POOF, ..., 1, xa, ya, za, 0.15)`, twenty times.
    // rust: for _ in 0..20 {
    // rust: let spread = [
    // rust: m.random.next_gaussian() * 0.02,
    // rust: m.random.next_gaussian() * 0.02,
    // rust: m.random.next_gaussian() * 0.02,
    // rust: ];
    // rust: cx.events.push(MobEvent::LevelParticles {
    // rust: kind: "poof",
    // rust: at: [center[0], f64::from(eat[1]), center[2]],
    // rust: spread,
    // rust: speed: 0.15,
    // rust: count: 1,
    // rust: });
}
            // The break sound's pitch draws from the level random.
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.turtle.egg_break",
    // rust: [
    // rust: f64::from(eat[0]) + 0.5,
    // rust: f64::from(eat[1]) + 0.5,
    // rust: f64::from(eat[2]) + 0.5,
    // rust: ],
    // rust: 0.7,
    // rust: 1.0,
    // rust: ));
}
    // rust: self.since_reached += 1;
}
}

    // rust: mod conversion_tests {
//     use super::*;
//     use crate::{items::ItemStack, mobs::world::with_test_world};
//     use std::sync::Arc;

    // The mob the game makes of a conversion event (`Game::convert_to` or,
    // for a plain spawn, `spawn_mob` plus `apply_setup` without the spawn
    // finalization's random gear).
resolve :: proc(event: ^MobEvent, types: ^crate::mobs::MobTypes) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let new = |kind: &str, at: Vec3, yaw: f32| {
    // rust: Mob::new(2, Arc::new(types.types[kind].clone()), at, yaw)
}
    // rust: match event {
    // rust: MobEvent::Convert { from, kind, params } => {
    // rust: let mut m = new(kind, from.position, from.yaw);
    // rust: crate::mobs::conversion::single(from, &mut m, *params);
    // rust: Some(m)
}
    // rust: MobEvent::SpawnKind { kind, at, setup } => {
    // rust: let mut m = new(kind, Vec3::new(at[0], at[1], at[2]), setup.yaw);
    // rust: m.persistent = setup.persistent;
    // rust: if setup.baby {
    // rust: m.extra.age = -24000;
}
    // rust: Some(m)
}
    // rust: _ => None,
}
}

    // `Zombie.drowningTracker` / `Husk`: the last tick of the conversion
    // under water turns the mob into `into`; what comes out (None only
    // without the extracted vanilla data).
drown :: proc(kind: string, dress: impl FnOnce(^Mob) {
}
    // rust: let mut out = None;
    // rust: with_test_world(&[], |w, types| {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types[kind].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 30.0,
    // rust: );
    // rust: dress(&mut m);
    // rust: m.fluids.eye_in_water = true;
    // rust: m.extra.counter2 = 1;
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: custom_server_ai_step(&mut m, &mut cx);
    // rust: assert!(m.removed, "the {kind} is discarded");
    // rust: let new = events.iter().find_map(|e| resolve(e, types));
    // rust: out = Some(new.expect("the conversion makes a new mob"));
    // rust: });
    // rust: out
}

a_drowning_zombie_keeps_its_gear_and_name_tag :: proc() {
}
    // rust: let Some(d) = drown("minecraft:zombie", |m| {
    // rust: m.custom_name = Some("Bob".into());
    // rust: m.name_visible = true;
    // rust: m.persistent = true;
    // rust: m.extra.head = Some("minecraft:iron_helmet".into());
    // rust: m.extra.armor[0] = Some(ItemStack::new("minecraft:iron_helmet", 1));
    // rust: m.extra
    // rust: .set_main_hand_stack(Some(ItemStack::new("minecraft:iron_sword", 1)));
    // rust: m.extra.drop_chances = Some(Box::new([2.0; 8]));
    // rust: m.extra.pick_up_loot = true;
    // rust: m.add_effect("minecraft:speed", 600, 1);
    // rust: }) else {
    // rust: return;
}
    // rust: assert_eq!(d.species(), Species::Drowned);
    // rust: assert_eq!(d.custom_name.as_deref(), Some("Bob"));
    // rust: assert!(d.name_visible && d.persistent);
    // rust: assert_eq!(d.extra.head.as_deref(), Some("minecraft:iron_helmet"));
    // rust: assert_eq!(
    // rust: d.extra.armor[0].as_ref().map(|s| &*s.item),
    // rust: Some("minecraft:iron_helmet")
    // rust: );
    // rust: assert_eq!(
    // rust: d.extra.main_hand_stack().map(|s| &*s.item),
    // rust: Some("minecraft:iron_sword")
    // rust: );
    // rust: assert_eq!(d.extra.drop_chances.as_deref(), Some(&[2.0; 8]));
    // rust: assert!(d.extra.pick_up_loot);
    // rust: assert!(d.has_effect("minecraft:speed"));
    // rust: assert_eq!(d.position, Vec3::new(0.5, 64.0, 0.5));
}

a_husk_turns_into_a_zombie_with_its_flags :: proc() {
}
    // rust: let Some(z) = drown("minecraft:husk", |m| {
    // rust: m.custom_name = Some("Dusty".into());
    // rust: m.no_ai = false;
    // rust: m.silent = true;
    // rust: m.extra.age = i32::MIN / 2;
    // rust: m.extra.feet = Some("minecraft:golden_boots".into());
    // rust: m.extra.armor[3] = Some(ItemStack::new("minecraft:golden_boots", 1));
    // rust: m.extra.left_handed = true;
    // rust: }) else {
    // rust: return;
}
    // rust: assert_eq!(z.species(), Species::Zombie);
    // rust: assert_eq!(z.custom_name.as_deref(), Some("Dusty"));
    // rust: assert!(z.silent && z.is_baby() && z.extra.left_handed);
    // rust: assert_eq!(z.extra.feet.as_deref(), Some("minecraft:golden_boots"));
}
}

    // rust: mod trident_tests {
//     use super::ranged_attack_uncertainty;

    // `RangedAttackMob.rangedAttackUncertainty` is 14 minus four per
    // difficulty step, so a drowned's trident spread shrinks from 14 on
    // peaceful to 2 on hard. Horizon used to hard-code the normal value.
the_trident_spread_follows_the_difficulty :: proc() {
}
    // rust: assert_eq!(ranged_attack_uncertainty(0), 14.0, "peaceful");
    // rust: assert_eq!(ranged_attack_uncertainty(1), 10.0, "easy");
    // rust: assert_eq!(ranged_attack_uncertainty(2), 6.0, "normal");
    // rust: assert_eq!(ranged_attack_uncertainty(3), 2.0, "hard");
}
}

    // rust: mod creative_target_tests {
//     use super::*;
//     use crate::mobs::world::{test_player, with_test_world};
//     use std::sync::Arc;

    // #6790: an angry zombified piglin lets go of a player in creative mode
    // (`TargetGoal.canContinueToUse` / `TargetingConditions` skip invulnerable
    // players).
an_angry_zombified_piglin_drops_a_creative_player :: proc() {
}
    // rust: with_test_world(&[], |w, types| {
    // rust: let mut w = w.clone();
    // rust: let mut player = test_player(Vec3::new(3.5, 64.0, 0.5));
    // rust: player.creative = true;
    // rust: w.player = Some(player);
    // rust: let kind = Arc::new(types.types["minecraft:zombified_piglin"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: m.ai.target = Some(Who::Player);
    // rust: m.extra.anger = 300;
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: for _ in 0..40 {
    // rust: let mut events = Vec::new();
    // rust: m.tick(&w, &mut lr, &mut events);
}
    // rust: assert_eq!(m.ai.target, None, "anger {}", m.extra.anger);
    // rust: });
}
}

    // rust: mod go_to_water_tests {
//     use super::*;
//     use crate::mobs::world::with_built_test_world;
//     use std::sync::Arc;

    // `DrownedGoToWaterGoal.getWaterPos` takes only `Blocks.WATER` blocks:
    // an area of kelp (which holds water too) gives it nowhere to go.
a_drowned_goes_to_water_blocks_not_kelp :: proc() {
}
    // rust: for (block, expect) in [("minecraft:kelp", false), ("minecraft:water", true)] {
    // rust: let build =
    // rust: |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: for cx in -2..2 {
    // rust: for cz in -2..2 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: let state = registry.default_state(block).unwrap();
    // rust: for x in -12..12 {
    // rust: for z in -12..12 {
    // rust: for y in 58..=66 {
    // rust: world.set(x, y, z, state).unwrap();
}
}
}
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: world.set(0, 63, 0, stone).unwrap();
}
    // rust: let ran = with_built_test_world(&[], build, |w, types| {
    // rust: let mut kind = types.types["minecraft:drowned"].clone();
    // rust: kind.species = Species::Drowned;
    // rust: let mut m = Mob::new(1, Arc::new(kind), Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: assert!(w.fluid(3, 64, 3) == crate::blocks::Fluid::Water, "{block}");
    // rust: let mut goal = DrownedGoToWater::default();
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: assert_eq!(goal.can_use(&mut m, &mut cx), expect, "{block}");
    // rust: });
    // rust: let _ = ran;
}
}
}

    // rust: mod wither_arrow_tests {
//     use super::*;
//     use crate::mobs::world::{test_player, with_test_world};
//     use std::sync::Arc;

mob :: proc(species: Species) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = species;
    // rust: Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0)
}
arrow :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: Projectile::new(
    // rust: ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: false,
    // rust: effect: None,
    // rust: },
    // rust: Vec3::ZERO,
    // rust: None,
    // rust: )
}

    // `WitherSkeleton.getArrow`: `super.getArrow(...)` then
    // `igniteForSeconds(100)` on the arrow it returns — 2000 fire ticks —
    // where a plain skeleton's arrow is not burning at all.
only_a_wither_skeletons_arrow_comes_out_burning :: proc() {
}
    // rust: for (species, fire_ticks) in [(Species::WitherSkeleton, 2000), (Species::Skeleton, 0)] {
    // rust: let m = mob(species);
    // rust: let mut p = arrow();
    // rust: ignite_for_wither_skeleton(&m, &mut p);
    // rust: let a = p.arrow.as_ref().expect("an arrow");
    // rust: assert_eq!(a.fire_ticks, fire_ticks, "{species:?}");
    // rust: assert_eq!(a.on_fire(), fire_ticks > 0, "{species:?}");
}
        // `igniteForTicks` keeps the longer burn: a Flame arrow already alight
        // for 4000 ticks is not shortened to the wither skeleton's 2000.
    // rust: let m = mob(Species::WitherSkeleton);
    // rust: let mut p = arrow();
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: a.ignite_for_seconds(200.0);
}
    // rust: ignite_for_wither_skeleton(&m, &mut p);
    // rust: assert_eq!(p.arrow.as_ref().unwrap().fire_ticks, 4000);
}

    // The same rule through the shooting path: `perform_ranged_attack` hands
    // the arrow to `ignite_for_wither_skeleton` before it flies.
a_wither_skeletons_shot_leaves_with_the_ignite :: proc() {
}
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: let mut w = w.clone();
            // A player four blocks away: the aim needs a visible target.
    // rust: w.player = Some(test_player(Vec3::new(0.5, 64.0, 4.5)));
    // rust: for (name, fire_ticks) in [
    // rust: ("minecraft:wither_skeleton", 2000),
    // rust: ("minecraft:skeleton", 0),
    // rust: ] {
    // rust: let kind = Arc::new(types.types[name].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: perform_ranged_attack(&mut m, Who::Player, &mut cx, 1.0);
    // rust: let arrow = events
    // rust: .iter()
    // rust: .find_map(|e| match e {
    // rust: MobEvent::Projectile(p) | MobEvent::BowShot { arrow: p, .. } => {
    // rust: p.arrow.as_ref()
}
    // rust: _ => None,
    // rust: })
    // rust: .unwrap_or_else(|| panic!("{name} shot nothing"));
    // rust: assert_eq!(arrow.fire_ticks, fire_ticks, "{name}");
}
    // rust: });
    // rust: let _ = ran;
}

    // #9808: a zombified piglin angry at another mob (a skeleton's arrow
    // hit it) is not angry at the player (`NeutralMob.isAngryAt`).
a_piglin_angry_at_a_mob_does_not_target_the_player :: proc() {
}
    // rust: with_test_world(&[], |w, types| {
    // rust: let mut w = w.clone();
    // rust: w.player = Some(test_player(Vec3::new(3.5, 64.0, 0.5)));
    // rust: let kind = Arc::new(types.types["minecraft:zombified_piglin"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: m.extra.anger = 300;
    // rust: m.extra.angry_at = Some(Who::Mob(99));
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: for _ in 0..40 {
    // rust: let mut events = Vec::new();
    // rust: m.tick(&w, &mut lr, &mut events);
    // rust: assert_ne!(m.ai.target, Some(Who::Player));
}
            // Fresh piglin, angry at the player: it does take the player.
    // rust: let kind = Arc::new(types.types["minecraft:zombified_piglin"].clone());
    // rust: let mut m = Mob::new(2, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: m.extra.anger = 300;
    // rust: m.extra.angry_at = Some(Who::Player);
    // rust: let mut hit = false;
    // rust: for _ in 0..60 {
    // rust: let mut events = Vec::new();
    // rust: m.tick(&w, &mut lr, &mut events);
    // rust: hit |= m.ai.target == Some(Who::Player);
}
    // rust: assert!(hit, "angry at the player targets the player");
    // rust: });
}
}
