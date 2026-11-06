//! Transpiled from Horizon Rust crate
//! Module: horizon-client_golem
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Golems: iron golems (fighting monsters, the heavy swing that throws its
//! target up, cracks as they weaken, iron repairs and poppies for villagers)
//! and snow golems (snowballs at monsters, the snow trail, melting).
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: goals::{
    // rust: Cx, Goal, HurtByTarget, LOOK, LookAtPlayer, MOVE, MeleeAttack, NearestTarget, Prey,
    // rust: RandomLookAround, Stroll, goal_clone, reduced,
    // rust: },
    // rust: villager_brain::{
    // rust: closest_section, occupied_pois_in_range, others_tickets, sections_to_village,
    // rust: village_sections,
    // rust: },
}
// use crate::projectiles::{Projectile, ProjectileKind};
// use horizon_core::{geometry::Vec3, random::RandomSource};

/// `Enemy` monsters an iron golem goes after (never creepers).
    // rust: pub(super) fn golem_prey(s: &super::Seen) -> bool {
    // rust: s.hostile && s.species != Species::Creeper
}
/// `ResetUniversalAngerTargetGoal` with `alertOthersOfSameType` false (the
/// iron golem's): with the `universal_anger` rule on, a golem whose latest
/// attacker is a player, hit after the one it last handled, forgets its
/// target and starts its anger timer over.
pub const ResetUniversalAnger = struct {
    /// `lastHurtByPlayerTimestamp`.
    timestamp: i32,
};
    // rust: impl Goal for ResetUniversalAnger {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "ResetUniversalAngerTargetGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
    /// The rule and `wasHurtByPlayer`.
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cx.w.universal_anger
    // rust: && m.ai.last_hurt_by == Some(Who::Player)
    // rust: && m.ai.last_hurt_by_time > self.timestamp
}
    /// `NeutralMob.forgetCurrentTargetAndRefreshUniversalAnger`:
    /// `stopBeingAngry`, then `startPersistentAngerTimer`.
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: self.timestamp = m.ai.last_hurt_by_time;
        // setLastHurtByMob(null) also stamps the time.
    // rust: m.ai.last_hurt_by = None;
    // rust: m.ai.last_hurt_by_time = m.age as i32;
    // rust: m.ai.target = None;
    // rust: m.extra.angry_at = None;
        // `TimeUtil.rangeOfSeconds(20, 39)`.
    // rust: m.extra.anger = 400 + m.random.next_int_bound(381).unwrap_or(0);
}
}
/// `IronGolem.registerGoals`.
pub fn register_iron(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, MeleeAttack::new(1.0, true));
    // rust: g.add(
    // rust: 2,
    // rust: MoveTowardsTarget {
    // rust: speed: 0.9,
    // rust: within: 32.0,
    // rust: wanted: [0.0; 3],
    // rust: },
    // rust: );
    // rust: let mut back = Stroll::new(0.6)
    // rust: .interval(10)
    // rust: .named("MoveBackToVillageGoal")
    // rust: .gate(outside_village)
    // rust: .position(back_to_village_position);
    // rust: back.check_no_action = false;
    // rust: g.add(2, back);
    // rust: let mut stroll = Stroll::new(0.6)
    // rust: .interval(240)
    // rust: .named("GolemRandomStrollInVillageGoal")
    // rust: .position(village_stroll_position);
    // rust: stroll.check_no_action = false;
    // rust: g.add(4, stroll);
    // rust: g.add(
    // rust: 5,
    // rust: OfferFlower {
    // rust: ticks: 0,
    // rust: villager: None,
    // rust: },
    // rust: );
    // rust: g.add(7, LookAtPlayer::new(6.0));
    // rust: g.add(8, RandomLookAround::default());
    // rust: m.ai.targets.add(1, DefendVillage);
    // rust: m.ai.targets.add(2, HurtByTarget::new());
    // rust: m.ai.targets.add(
    // rust: 3,
    // rust: NearestTarget::player(true)
    // rust: .interval(10)
    // rust: .when(|m, _| m.extra.anger > 0),
    // rust: );
    // rust: m.ai.targets.add(
    // rust: 3,
    // rust: NearestTarget::new(Prey::Filter(golem_prey), false).interval(5),
    // rust: );
    // rust: m.ai.targets.add(4, ResetUniversalAnger::default());
}
/// `SectionPos.of`: the section a position is in.
pub fn section_of(p: Vec3) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: (p.x.floor() as i32) >> 4,
    // rust: (p.y.floor() as i32) >> 4,
    // rust: (p.z.floor() as i32) >> 4,
    // rust: ]
}
/// `SectionPos.center` as `Vec3.atBottomCenterOf` reads it.
pub fn section_center(s: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: f64::from(s[0] * 16 + 8) + 0.5,
    // rust: f64::from(s[1] * 16 + 8),
    // rust: f64::from(s[2] * 16 + 8) + 0.5,
    // rust: ]
}
/// `MoveBackToVillageGoal.canUse`: only a golem outside the village
/// (`ServerLevel.isVillage` at its feet, at most 1 section from a village
/// section) goes back to it.
pub fn outside_village(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sections_to_village(&village_sections(m, w), section_of(m.position)) > 1
}
/// `MoveBackToVillageGoal.getPosition`: toward the section within 2 that
/// is closest to a village, a quarter turn either side; none when the
/// golem's own section already is.
pub fn back_to_village_position(m: *mut Mob, cx: *mut Cx) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let villages = village_sections(m, cx.w);
    // rust: let here = section_of(m.position);
    // rust: let best = closest_section(&villages, here, 2);
    // rust: if best == here {
    // rust: return None;
}
    // rust: m.default_random_pos_towards(
    // rust: cx.w,
    // rust: 10,
    // rust: 7,
    // rust: section_center(best),
    // rust: f64::from(std::f32::consts::FRAC_PI_2),
    // rust: )
}
/// `GolemRandomStrollInVillageGoal.getPosition`: now and then anywhere
/// (3 in 10); else toward a villager who wants a golem or toward a spot in
/// a village section (7 in 10 the villager first), and anywhere if neither
/// is found. The picks draw from the level's random.
pub fn village_stroll_position(m: *mut Mob, cx: *mut Cx) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cx.lr.next_float() < 0.3 {
    // rust: return m.land_random_pos(cx.w, 10, 7);
}
    // rust: let target = if cx.lr.next_float() < 0.7 {
    // rust: towards_villager_who_wants_golem(m, cx).or_else(|| towards_poi(m, cx))
    // rust: } else {
    // rust: towards_poi(m, cx).or_else(|| towards_villager_who_wants_golem(m, cx))
}
    // rust: target.or_else(|| m.land_random_pos(cx.w, 10, 7))
}
/// `GolemRandomStrollInVillageGoal.getPositionTowardsVillagerWhoWantsGolem`:
/// one of the villagers within 32 blocks that want a golem, picked from
/// the level's random.
pub fn towards_villager_who_wants_golem(m: *mut Mob, cx: *mut Cx) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let area = m.bounds().inflate(Vec3::new(32.0, 32.0, 32.0));
    // rust: let now = cx.w.game_time;
    // rust: let villagers: Vec<Vec3> =
    // rust: cx.w.others_near(area)
    // rust: .filter(|s| {
    // rust: s.species == Species::Villager
    // rust: && s.bounds.intersects(area)
    // rust: && s.villager.as_ref().is_some_and(|v| v.wants_golem(now))
    // rust: })
    // rust: .map(|s| s.position)
    // rust: .collect();
    // rust: if villagers.is_empty() {
    // rust: return None;
}
    // rust: let at = villagers[cx.lr.next_int_bound(villagers.len() as i32).unwrap_or(0) as usize];
    // rust: m.land_random_pos_towards(cx.w, 10, 7, [at.x, at.y, at.z])
}
/// `GolemRandomStrollInVillageGoal.getPositionTowardsPoi`: a taken point of
/// interest within 8 blocks of the centre of a random village section
/// (`getRandomVillageSection`, `getRandomPoiWithinSection`) among those
/// within 2 sections of the golem.
pub fn towards_poi(m: *mut Mob, cx: *mut Cx) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let villages = village_sections(m, cx.w);
    // rust: let here = section_of(m.position);
    // rust: let mut sections = Vec::new();
    // rust: for z in here[2] - 2..=here[2] + 2 {
    // rust: for y in here[1] - 2..=here[1] + 2 {
    // rust: for x in here[0] - 2..=here[0] + 2 {
    // rust: if sections_to_village(&villages, [x, y, z]) == 0 {
    // rust: sections.push([x, y, z]);
}
}
}
}
    // rust: if sections.is_empty() {
    // rust: return None;
}
    // rust: let s = sections[cx.lr.next_int_bound(sections.len() as i32).unwrap_or(0) as usize];
    // rust: let taken = others_tickets(m, cx.w);
    // rust: let pois = occupied_pois_in_range(
    // rust: cx.w,
    // rust: &taken,
    // rust: [s[0] * 16 + 8, s[1] * 16 + 8, s[2] * 16 + 8],
    // rust: 8,
    // rust: );
    // rust: if pois.is_empty() {
    // rust: return None;
}
    // rust: let p = pois[cx.lr.next_int_bound(pois.len() as i32).unwrap_or(0) as usize];
    // rust: m.land_random_pos_towards(
    // rust: cx.w,
    // rust: 10,
    // rust: 7,
    // rust: [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ],
    // rust: )
}
/// `DefendVillageTargetGoal`: a player that a villager nearby has no
/// good word for (reputation of -100 or worse) is attacked on sight.
pub const DefendVillage = struct {};
    // rust: impl Goal for DefendVillage {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::goals::TARGET
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(p) = &cx.w.player else { return false };
    // rust: if !p.alive || p.creative || p.spectator || m.spares_players(cx.w) {
    // rust: return false;
}
        // The box around the golem: 10 across, 8 up and down.
    // rust: let b = m.bounds().inflate(Vec3::new(10.0, 8.0, 10.0));
    // rust: if !b.intersects(p.bounds) || m.position.distance_squared(p.position) > 64.0 * 64.0 {
    // rust: return false;
}
        // A position inside `b` puts the box's bottom face there (one block
        // wider, as the box test is strict).
    // rust: let near = b.inflate(Vec3::new(1.0, 1.0, 1.0));
    // rust: let bad = cx.w.others_near(near).any(|s| {
    // rust: s.species == Species::Villager
    // rust: && s.alive
    // rust: && s.player_rep <= -100
    // rust: && b.contains(s.position)
    // rust: && s.position.distance_squared(m.position) <= 64.0 * 64.0
    // rust: });
    // rust: bad && m.sees(cx.w, Who::Player)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let spares = m.spares_players(cx.w);
    // rust: m.target_info(cx.w).is_some_and(|t| {
    // rust: t.alive
    // rust: && !(t.is_player && (t.creative || spares))
    // rust: && m.position.distance_squared(t.position) <= 64.0 * 64.0
    // rust: })
}
pub fn start(self: *Self, m: *mut Mob, _cx: *mut Cx) void {
}
    // rust: m.ai.target = Some(Who::Player);
}
pub fn stop(self: *Self, m: *mut Mob, _cx: *mut Cx) void {
}
    // rust: m.ai.target = None;
}
}
/// `MoveTowardsTargetGoal`: close in on a target within range.
pub const MoveTowardsTarget = struct {
    speed: f64,
    within: f64,
    /// The spot `canUse` picked, which `start` walks to.
    wanted: [f64,
};
    // rust: impl Goal for MoveTowardsTarget {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(t) = m.ai.target.and_then(|t| cx.w.target_info(t)) else {
    // rust: return false;
}
    // rust: if m.distance_sqr(t.position) > self.within * self.within {
    // rust: return false;
}
        // MoveTowardsTargetGoal.canUse: a spot up to 16 blocks out and 7 up or
        // down, within a quarter turn of the target's own position.
    // rust: let Some(p) = m.default_random_pos_towards(
    // rust: cx.w,
    // rust: 16,
    // rust: 7,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: std::f64::consts::FRAC_PI_2,
    // rust: ) else {
    // rust: return false;
}
    // rust: self.wanted = p;
    // rust: true
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
        // MoveTowardsTargetGoal.start: `PathNavigation.moveTo(x, y, z, speed)`.
    // rust: m.nav_move_to(cx.w, self.wanted, self.speed);
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !m.ai.nav.is_done()
    // rust: && m.ai
    // rust: .target
    // rust: .and_then(|t| cx.w.target_info(t))
    // rust: .is_some_and(|t| t.alive && m.distance_sqr(t.position) < self.within * self.within)
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.nav_stop();
}
}
/// `OfferFlowerGoal`: by day, now and then, hold out a poppy to a villager.
pub const OfferFlower = struct {
    ticks: i32,
    villager: ?u32,
};
    // rust: impl Goal for OfferFlower {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !cx.w.daylight || m.random.next_int_bound(8000).unwrap_or(1) != 0 {
    // rust: return false;
}
        // The nearest of #candidate_for_iron_golem_gift: villagers and copper golems.
    // rust: self.villager =
    // rust: cx.w.nearby(m.position, 6.0, |s| {
    // rust: matches!(s.species, Species::Villager | Species::CopperGolem) && s.alive
    // rust: })
    // rust: .map(|s| s.id)
    // rust: .next();
    // rust: self.villager.is_some()
}
pub fn can_continue(self: *Self, _: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ticks > 0
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
        // adjustedTickDelay(400): the goal ticks every other game tick.
    // rust: self.ticks = reduced(400);
    // rust: m.extra.counter = 400;
        // IronGolem.offerFlower(true): entity event 11.
    // rust: entity_event(m, 11, cx);
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: m.extra.counter = 0;
        // IronGolem.offerFlower(false): entity event 34.
    // rust: entity_event(m, 34, cx);
        // A copper golem the offer ran out beside takes the poppy on its
        // antenna (#accepts_iron_golem_gift) when it has none.
    // rust: if self.ticks == 0
    // rust: && let Some(v) = self.villager.and_then(|v| cx.w.seen(v))
    // rust: && v.species == Species::CopperGolem
    // rust: {
    // rust: let b = m.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let (vlo, vhi) = (v.bounds.min_position(), v.bounds.max_position());
    // rust: if lo.x - 6.0 < vhi.x
    // rust: && hi.x + 6.0 > vlo.x
    // rust: && lo.y - 2.0 < vhi.y
    // rust: && hi.y + 2.0 > vlo.y
    // rust: && lo.z - 6.0 < vhi.z
    // rust: && hi.z + 6.0 > vlo.z
    // rust: {
    // rust: cx.events.push(MobEvent::Gift {
    // rust: target: v.id,
    // rust: item: "minecraft:poppy",
    // rust: });
}
}
    // rust: self.villager = None;
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(v) = self.villager.and_then(|v| cx.w.seen(v)) {
    // rust: m.look_at_speed([v.position.x, v.eye_y, v.position.z], 30.0, 30.0);
}
    // rust: self.ticks -= 1;
}
}
/// `IronGolem.doHurtTarget`: half to one and a half times the damage, and
/// the target is thrown upward.
pub fn iron_hurt_target(m: *mut Mob, who: Who, cx: *mut Cx) void {
}
    // rust: m.extra.anim_ticks = 10;
    // rust: entity_event(m, 4, cx);
    // rust: let attack = m.attrs.attack_damage;
    // rust: let amount = if attack as i32 > 0 {
    // rust: attack / 2.0 + m.random.next_int_bound(attack as i32).unwrap_or(0) as f32
    // rust: } else {
    // rust: attack
}
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: match who {
    // rust: Who::Player => cx.events.push(MobEvent::AttackPlayer(amount, from)),
    // rust: Who::Mob(id) => cx.events.push(MobEvent::AttackMob {
    // rust: target: id,
    // rust: amount,
    // rust: source: super::Damage::mob(m.id, from),
    // rust: }),
}
    // rust: cx.events.push(MobEvent::Launch {
    // rust: target: who,
    // rust: up: 0.4,
    // rust: });
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.iron_golem.attack",
    // rust: m.center(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
/// `Level.broadcastEntityEvent` for an iron golem (guests run `client_event`).
pub fn entity_event(m: *Mob, event: i8, cx: *mut Cx) void {
}
    // rust: cx.events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}
/// `IronGolem.handleEntityEvent` on a client: 4 the swing, 11 and 34 the
/// poppy offer starting and stopping.
pub fn client_event(m: *mut Mob, event: u8) void {
}
    // rust: match event {
    // rust: 4 => m.extra.anim_ticks = 10,
    // rust: 11 => m.extra.counter = 400,
    // rust: 34 => m.extra.counter = 0,
    // rust: _ => {}
}
}
/// The swing and offer clocks of `IronGolem.aiStep` on a client.
pub fn client_tick(m: *mut Mob) void {
}
    // rust: if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks -= 1;
}
    // rust: if m.extra.counter > 0 {
    // rust: m.extra.counter -= 1;
}
}
/// `IronGolem.aiStep` timers and anger.
pub fn iron_ai_step(m: *mut Mob) void {
}
    // rust: if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks -= 1;
}
    // rust: if m.extra.counter > 0 {
    // rust: m.extra.counter -= 1;
}
    // rust: if m.extra.anger > 0 {
    // rust: m.extra.anger -= 1;
    // rust: if m.extra.anger == 0 && m.ai.target == Some(Who::Player) {
    // rust: m.ai.target = None;
}
}
}
/// `Crackiness.GOLEM` texture for the health left.
pub fn crackiness(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = m.health / m.attrs.max_health;
    // rust: if f < 0.25 {
    // rust: Some("entity/iron_golem/iron_golem_crackiness_high")
    // rust: } else if f < 0.5 {
    // rust: Some("entity/iron_golem/iron_golem_crackiness_medium")
    // rust: } else if f < 0.75 {
    // rust: Some("entity/iron_golem/iron_golem_crackiness_low")
    // rust: } else {
    // rust: None
}
}
pub fn triangle_wave(x: f32, period: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((x % period) - period * 0.5).abs() / (period * 0.5) * 2.0 - 1.0
}
/// `IronGolemModel.setupAnim`.
pub fn iron_anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // rust: let attack = if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks as f32 - s.partial
    // rust: } else {
    // rust: 0.0
}
    // rust: let (pos, speed) = (s.pos, s.speed);
    // rust: if attack > 0.0 {
    // rust: p.xrot("right_arm", -2.0 + 1.5 * triangle_wave(attack, 10.0));
    // rust: p.xrot("left_arm", -2.0 + 1.5 * triangle_wave(attack, 10.0));
    // rust: } else if m.extra.counter > 0 {
    // rust: p.xrot(
    // rust: "right_arm",
    // rust: -0.8 + 0.025 * triangle_wave(m.extra.counter as f32, 70.0),
    // rust: );
    // rust: p.xrot("left_arm", 0.0);
    // rust: } else {
    // rust: p.xrot("right_arm", (-0.2 + 1.5 * triangle_wave(pos, 13.0)) * speed);
    // rust: p.xrot("left_arm", (-0.2 - 1.5 * triangle_wave(pos, 13.0)) * speed);
}
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.xrot("right_leg", -1.5 * triangle_wave(pos, 13.0) * speed);
    // rust: p.xrot("left_leg", 1.5 * triangle_wave(pos, 13.0) * speed);
    // rust: p.yrot("right_leg", 0.0);
    // rust: p.yrot("left_leg", 0.0);
}

pub fn register_snow(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(
    // rust: 1,
    // rust: super::witch::RangedAttack::new(1.25, 20, 20, 10.0, snowball_attack),
    // rust: );
    // rust: g.add(2, Stroll::avoiding_water(1.0));
    // rust: g.add(3, LookAtPlayer::new(6.0));
    // rust: g.add(4, RandomLookAround::default());
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: NearestTarget::new(Prey::Filter(|s| s.hostile), true).interval(10),
    // rust: );
}
/// `SnowGolem.performRangedAttack`.
pub fn snowball_attack(m: *mut Mob, who: Who, _power: f32, cx: *mut Cx) void {
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let start = Vec3::new(m.position.x, m.eye_y() - 0.1, m.position.z);
    // rust: let xd = t.position.x - m.position.x;
    // rust: let yd = t.eye_y - 1.1;
    // rust: let zd = t.position.z - m.position.z;
    // rust: let yo = (xd * xd + zd * zd).sqrt() * 0.2;
    // rust: let mut p = Projectile::new(ProjectileKind::Snowball, start, Some(Who::Mob(m.id)));
    // SnowGolem.rangedAttackUncertainty: 12 on every difficulty.
    // rust: p.shoot(
    // rust: &mut crate::projectiles::own_random(m),
    // rust: [xd, yd + yo - start.y, zd],
    // rust: 1.6,
    // rust: 12.0,
    // rust: );
    // rust: cx.events.push(MobEvent::Projectile(p));
    // rust: let pitch = 0.4 / (m.random.next_float() * 0.4 + 0.8);
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.snow_golem.shoot",
    // rust: m.center(),
    // rust: 1.0,
    // rust: pitch,
    // rust: ));
}
/// `SnowGolem.aiStep`: melting in hot biomes, the snow trail.
pub fn snow_ai_step(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // EnvironmentAttributes.SNOW_GOLEM_MELTS: the hot biomes and the Nether.
    // rust: if w.nether || w.temperature(x, y, z) > 1.0 {
    // rust: events.push(MobEvent::HurtSelf {
    // rust: mob: m.id,
    // rust: kind: super::DamageKind::OnFire,
    // rust: amount: 1.0,
    // rust: });
}
    // rust: if !w.mob_griefing {
    // rust: return;
}
    // rust: for i in 0..4 {
    // rust: let xx = (m.position.x + f64::from((i % 2 * 2 - 1) as f32 * 0.25)).floor() as i32;
    // rust: let zz = (m.position.z + f64::from((i / 2 % 2 * 2 - 1) as f32 * 0.25)).floor() as i32;
    // rust: let here = w.facts.get(w.world.block(xx, y, zz));
    // rust: let below = w.facts.get(w.world.block(xx, y - 1, zz));
        // SnowLayerBlock.canSurvive: a full top face, not ice.
    // rust: let ice = matches!(
    // rust: below.name.as_ref(),
    // rust: "minecraft:ice" | "minecraft:packed_ice" | "minecraft:barrier"
    // rust: );
    // rust: if here.name.as_ref() == "minecraft:air" && below.full_collision && !ice {
    // rust: events.push(MobEvent::SetBlockName {
    // rust: mob: Some(m.id),
    // rust: pos: [xx, y, zz],
    // rust: name: "minecraft:snow",
    // rust: effect: false,
    // rust: flags: horizon_world::level::flags::UPDATE_ALL,
    // rust: });
}
}
    // rust: let _ = z;
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::world::{test_player, with_test_world};
//     use std::sync::Arc;

pub fn mob(id: u32, species: Species, at: Vec3) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.species = species;
    // rust: Mob::new(id, Arc::new(kind), at, 0.0)
}

    /// `MoveTowardsTargetGoal.canUse` picks a random spot within 16 blocks and
    /// 7 up or down toward the target and keeps it for `start`, so the golem
    /// walks to that spot rather than straight at the entity.
pub fn an_iron_golem_walks_to_a_spot_near_its_target() void {
}
    // rust: let build = |world: &mut crate::world::World,
    // rust: registry: &horizon_world::registry::BlockRegistry| {
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: for cx in -2..2 {
    // rust: for cz in -2..2 {
    // rust: world.chunks.insert(
    // rust: (cx, cz),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(cx, cz)),
    // rust: );
}
}
    // rust: for x in -24..24 {
    // rust: for z in -24..24 {
    // rust: for y in 60..=63 {
    // rust: world.set(x, y, z, stone).unwrap();
}
}
}
}
    // rust: crate::mobs::world::with_built_test_world(&[], build, |w, _| {
    // rust: let mut w = w.clone();
    // rust: w.player = Some(test_player(Vec3::new(8.5, 64.0, 0.5)));
            // The spot is drawn at random, and a flat world only offers a few
            // heights: the seed follows the mob's id, so try the ids in turn
            // (vanilla gives the pick ten candidates before giving up).
    // rust: let mut found = None;
    // rust: for id in 1..400 {
    // rust: let mut m = mob(id, Species::IronGolem, Vec3::new(0.5, 64.0, 0.5));
    // rust: m.ai.target = Some(Who::Player);
    // rust: let mut goal = MoveTowardsTarget {
    // rust: speed: 0.9,
    // rust: within: 32.0,
    // rust: wanted: [0.0; 3],
}
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: if goal.can_use(&mut m, &mut cx) {
    // rust: found = Some((m, goal));
    // rust: break;
}
}
    // rust: let (m, goal) = found.expect("a spot among ten candidates");
    // rust: let wanted = goal.wanted;
    // rust: let (dx, dz) = (wanted[0] - m.position.x, wanted[2] - m.position.z);
    // rust: assert!((dx * dx + dz * dz).sqrt() <= 16.0, "within 16 blocks");
    // rust: assert!(
    // rust: (wanted[1] - m.position.y).abs() <= 7.0,
    // rust: "within 7 up or down"
    // rust: );
            // `DefaultRandomPos.getPosTowards` only accepts a spot within a
            // quarter turn of the target, so the horizontal step to the spot
            // is at most 90 degrees off the step to the target.
    // rust: let to_target = (8.5 - m.position.x, 0.5 - m.position.z);
    // rust: let to_spot = (wanted[0] - m.position.x, wanted[2] - m.position.z);
    // rust: assert!(
    // rust: to_target.0 * to_spot.0 + to_target.1 * to_spot.1 >= 0.0,
    // rust: "the spot is toward the target"
    // rust: );
    // rust: });
}

    /// `ResetUniversalAngerTargetGoal`: with the rule on, a golem hurt by a
    /// player forgets its target once and not again until hurt again; with
    /// the rule off it does nothing.
pub fn a_golem_hurt_by_a_player_forgets_its_target_once_under_universal_anger() void {
}
    // rust: for rule in [true, false] {
    // rust: with_test_world(&[], |w, _| {
    // rust: let mut w = w.clone();
    // rust: w.universal_anger = rule;
    // rust: let mut golem = mob(1, Species::IronGolem, Vec3::new(0.5, 64.0, 0.5));
    // rust: golem.age = 50;
    // rust: golem.ai.target = Some(Who::Mob(2));
    // rust: golem.extra.anger = 5;
    // rust: golem.ai.last_hurt_by = Some(Who::Player);
    // rust: golem.ai.last_hurt_by_time = 10;
    // rust: let mut goal = ResetUniversalAnger::default();
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: assert_eq!(goal.can_use(&mut golem, &mut cx), rule);
    // rust: if !rule {
    // rust: return;
}
    // rust: goal.start(&mut golem, &mut cx);
    // rust: assert_eq!(golem.ai.target, None);
    // rust: assert_eq!(golem.ai.last_hurt_by, None);
    // rust: assert!((400..=780).contains(&golem.extra.anger));
    // rust: assert!(!goal.can_use(&mut golem, &mut cx), "not again");
                // Hurt again: a newer hit by the player.
    // rust: golem.ai.last_hurt_by = Some(Who::Player);
    // rust: golem.ai.last_hurt_by_time = 60;
    // rust: assert!(goal.can_use(&mut golem, &mut cx));
    // rust: });
}
}

    /// `IronGolem.canAttack` refuses creepers, and `HurtByTargetGoal.canUse`
    /// asks it: the creeper that hurt the golem is never fought back, while
    /// a zombie that hurts it is.
pub fn a_creeper_that_hurts_an_iron_golem_is_never_fought_back() void {
}
    // rust: let creeper = mob(2, Species::Creeper, Vec3::new(1.5, 64.0, 0.5));
    // rust: let zombie = mob(3, Species::Zombie, Vec3::new(1.5, 64.0, 0.5));
    // rust: with_test_world(&[creeper.seen(None), zombie.seen(None)], |w, _| {
    // rust: let mut golem = mob(1, Species::IronGolem, Vec3::new(0.5, 64.0, 0.5));
    // rust: let mut goal = HurtByTarget::new();
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}

    // rust: golem.ai.last_hurt_by = Some(Who::Mob(2));
    // rust: golem.ai.last_hurt_by_time = 1;
    // rust: assert!(!goal.can_use(&mut golem, &mut cx));
    // rust: assert_eq!(golem.ai.target, None, "a creeper is refused");

    // rust: golem.ai.last_hurt_by = Some(Who::Mob(3));
    // rust: golem.ai.last_hurt_by_time = 2;
    // rust: assert!(goal.can_use(&mut golem, &mut cx));
    // rust: goal.start(&mut golem, &mut cx);
    // rust: assert_eq!(golem.ai.target, Some(Who::Mob(3)));
    // rust: });
}

    /// A village golem (not built by a player) still goes after the player
    /// who angered it.
pub fn a_village_golem_still_targets_the_player_who_angered_it() void {
}
    // rust: with_test_world(&[], |w, _| {
    // rust: let mut w = w.clone();
    // rust: w.player = Some(test_player(Vec3::new(3.5, 64.0, 0.5)));
    // rust: let mut golem = mob(1, Species::IronGolem, Vec3::new(0.5, 64.0, 0.5));
    // rust: golem.extra.anger = 100;
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: let mut goal = NearestTarget::player(true)
    // rust: .interval(0)
    // rust: .when(|m, _| m.extra.anger > 0);
    // rust: assert!(goal.can_use(&mut golem, &mut cx));
    // rust: goal.start(&mut golem, &mut cx);
    // rust: assert_eq!(golem.ai.target, Some(Who::Player));
    // rust: });
}
}

    // rust: mod created_golem_tests {
//     use super::*;
//     use crate::mobs::world::{test_player, with_test_world};
//     use std::sync::Arc;

    /// The target `m`'s target goals pick over `ticks` ticks in `w`.
pub fn target(m: *mut Mob, w: *MobWorld<'_>, ticks: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut goals = std::mem::take(&mut m.ai.targets);
    // rust: {
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: for _ in 0..ticks {
    // rust: goals.tick(m, &mut cx);
}
}
    // rust: m.ai.targets = goals;
    // rust: m.ai.target
}
    /// A player-built and a village iron golem, both angry at a player, and a
    /// zombie; `None` without the extracted vanilla data.
pub fn angry_golems() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = None;
    // rust: with_test_world(&[], |_, types| {
    // rust: let golem = |id: u32, created: bool| {
    // rust: let kind = Arc::new(types.types["minecraft:iron_golem"].clone());
    // rust: let mut m = Mob::new(id, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
                // `CarvedPumpkinBlock.trySpawnGolem`: setPlayerCreated(true).
    // rust: m.extra.player_created = created;
                // The anger a player's hit gives it (`after_hurt`).
    // rust: m.extra.anger = 400;
    // rust: m
}
    // rust: let zombie = Mob::new(
    // rust: 3,
    // rust: Arc::new(types.types["minecraft:zombie"].clone()),
    // rust: Vec3::new(0.5, 64.0, 2.5),
    // rust: 0.0,
    // rust: );
    // rust: out = Some((golem(1, true), golem(2, false), zombie.seen(None)));
    // rust: });
    // rust: out
}

    /// `IronGolem.canAttack`: a golem a player built never takes a player as
    /// its target, though a village golem does and both still go after
    /// monsters. The world holds one player, so "its builder" and "a player"
    /// are the same check, as they are in vanilla.
pub fn a_golem_a_player_built_never_targets_one() void {
}
    // rust: let Some((mut built, mut village, zombie)) = angry_golems() else {
    // rust: return;
}
    // rust: with_test_world(&[], |w, _| {
    // rust: let mut w = w.clone();
    // rust: w.player = Some(test_player(Vec3::new(2.5, 64.0, 0.5)));
    // rust: assert_eq!(
    // rust: target(&mut built, &w, 200),
    // rust: None,
    // rust: "a golem a player built turned on its builder"
    // rust: );
    // rust: assert_eq!(
    // rust: target(&mut village, &w, 200),
    // rust: Some(Who::Player),
    // rust: "a village golem goes after the player"
    // rust: );
    // rust: });
    // rust: with_test_world(&[zombie], |w, _| {
    // rust: assert_eq!(
    // rust: target(&mut built, w, 200),
    // rust: Some(Who::Mob(3)),
    // rust: "a golem a player built still fights monsters"
    // rust: );
    // rust: });
}
}

    // rust: mod crack_sound_tests {
//     use super::*;
//     use crate::mobs::Damage;
//     use std::sync::Arc;

    /// An iron golem of its 100 health, from a made-up type.
pub fn golem() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:iron_golem".into();
    // rust: k.species = Species::IronGolem;
    // rust: k.max_health = 100.0;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}
    /// `LivingEntity.actuallyHurt`: absorbed damage from a player is credited in
    /// tenths; other attackers and a hit with nothing absorbed credit nothing.
pub fn player_hit_credits_dealt_absorbed() void {
}
    // rust: let mut m = golem();
    // rust: m.absorption = 4.0;
    // rust: assert!(m.damage(1.5, Damage::player([0.0, 0.0, 1.0])));
    // rust: assert_eq!(m.dealt_absorbed, 15);
    // rust: m.invulnerable = 0;
    // rust: assert!(m.damage(10.0, Damage::player([0.0, 0.0, 1.0])));
    // rust: assert_eq!(m.dealt_absorbed, 15 + 25);
    // rust: m.invulnerable = 0;
    // rust: m.damage(2.0, Damage::player([0.0, 0.0, 1.0]));
    // rust: assert_eq!(m.dealt_absorbed, 40);
    // rust: let mut other = golem();
    // rust: other.absorption = 4.0;
    // rust: other.damage(1.5, Damage::of(crate::mobs::DamageKind::Generic));
    // rust: assert_eq!(other.dealt_absorbed, 0);
}
    /// One hit of `amount` past the golem's hurt frames: how often it played
    /// `entity.iron_golem.damage`.
pub fn cracks(m: *mut Mob, amount: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.outbox.clear();
    // rust: m.invulnerable = 0;
    // rust: assert!(m.damage(amount, Damage::player([0.0, 0.0, 1.0])));
    // rust: m.outbox
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::Sound("entity.iron_golem.damage", ..)))
    // rust: .count()
}

    /// `IronGolem.hurtServer`: a hit that leaves the golem in a new
    /// `Crackiness.Level` (`Crackiness.GOLEM` is 0.75, 0.5, 0.25) plays
    /// `entity.iron_golem.damage` once, and hits inside one level play none.
pub fn a_crack_is_heard_once_at_the_threshold() void {
}
    // rust: let mut m = golem();
    // rust: assert_eq!(cracks(&mut m, 30.0), 1, "100 to 70 crosses 0.75");
    // rust: assert_eq!(cracks(&mut m, 10.0), 0, "70 to 60 stays at the same crack");
    // rust: assert_eq!(cracks(&mut m, 20.0), 1, "60 to 40 crosses 0.5");
    // rust: assert_eq!(cracks(&mut m, 10.0), 0, "40 to 30 stays at the same crack");
    // rust: assert_eq!(cracks(&mut m, 10.0), 1, "30 to 20 crosses 0.25");
}
}
