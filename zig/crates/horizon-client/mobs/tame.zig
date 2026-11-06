//! Transpiled from Horizon Rust crate
//! Module: horizon-client_tame
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Tamable animals (`TamableAnimal`): wolves with their variants, taming,
//! sitting, following and defending the owner, begging, anger and shaking
//! off water (`Wolf`, `WolfModel`).
// use super::{
    // rust: Mob, MobEvent, MobWorld, PlayerView, Species, Who,
    // rust: anim::{Poses, State},
    // rust: goals::{
    // rust: Breed, Cx, Float, Goal, HurtByTarget, JUMP, LOOK, LeapAtTarget, LookAtPlayer, MOVE,
    // rust: MeleeAttack, NearestTarget, Panic, Prey, RandomLookAround, Stroll, TARGET, goal_clone,
    // rust: reduced,
    // rust: },
}
// use horizon_core::geometry::trig::Mth;
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Vec3},
    // rust: random::RandomSource,
}
// use std::f32::consts::PI;

/// Wolf variants: registry name and texture file (`WolfVariants`).
    // rust: pub const WOLF_VARIANTS: [(&str, &str); 9] = [
    // rust: ("pale", "wolf"),
    // rust: ("spotted", "wolf_spotted"),
    // rust: ("snowy", "wolf_snowy"),
    // rust: ("black", "wolf_black"),
    // rust: ("ashen", "wolf_ashen"),
    // rust: ("rusty", "wolf_rusty"),
    // rust: ("woods", "wolf_woods"),
    // rust: ("chestnut", "wolf_chestnut"),
    // rust: ("striped", "wolf_striped"),
    // rust: ];
/// The wolf variant a biome spawns (its high-priority `BiomeCheck`).
pub fn wolf_variant_for(biome: []const u8, has_tag: *dyn Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if has_tag("minecraft:is_savanna") {
    // rust: 1
    // rust: } else if biome == "minecraft:grove" {
    // rust: 2
    // rust: } else if biome == "minecraft:old_growth_pine_taiga" {
    // rust: 3
    // rust: } else if biome == "minecraft:snowy_taiga" {
    // rust: 4
    // rust: } else if has_tag("minecraft:is_jungle") {
    // rust: 5
    // rust: } else if biome == "minecraft:forest" {
    // rust: 6
    // rust: } else if biome == "minecraft:old_growth_spruce_taiga" {
    // rust: 7
    // rust: } else if has_tag("minecraft:is_badlands") {
    // rust: 8
    // rust: } else {
    // rust: 0
}
}
/// The default collar: red.
pub const RED: u8 = 14;

// AnimState slots: begging interest and the shake animation.
pub const INTEREST: usize = 0;
pub const SHAKE: usize = 1;

pub fn register(m: *mut Mob) void {
}
    // rust: m.extra.color = RED;
    // rust: let food = m.kind.food.clone();
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Float);
    // rust: g.add(1, TamePanic(Panic::new(1.5)));
    // rust: g.add(2, SitWhenOrdered);
    // rust: g.add(3, AvoidLlamas::new());
    // rust: g.add(4, LeapAtTarget::new(0.4));
    // rust: g.add(5, MeleeAttack::new(1.0, true));
    // rust: g.add(6, FollowOwner::new(1.0, 10.0, 2.0));
    // rust: g.add(7, Breed::new(1.0));
    // rust: g.add(8, Stroll::avoiding_water(1.0));
    // rust: g.add(9, Beg { food, ticks: 0 });
    // rust: g.add(10, LookAtPlayer::new(8.0));
    // rust: g.add(10, RandomLookAround::default());
    // rust: m.ai.targets.add(1, OwnerHurtBy { timestamp: 0 });
    // rust: m.ai.targets.add(2, OwnerHurt { timestamp: 0 });
    // rust: m.ai.targets.add(3, HurtByTarget::new().alert());
    // rust: m.ai.targets
    // rust: .add(4, NearestTarget::player(true).when(angry_at_player));
    // rust: m.ai.targets.add(
    // rust: 5,
    // rust: NearestTarget::new(Prey::Filter(wolf_prey), false).gate(|m, _| !m.extra.tame),
    // rust: );
    // rust: m.ai.targets.add(
    // rust: 6,
    // rust: NearestTarget::new(Prey::Filter(baby_turtle_on_land), false).gate(|m, _| !m.extra.tame),
    // rust: );
    // rust: m.ai.targets.add(
    // rust: 7,
    // rust: NearestTarget::species(
    // rust: &[
    // rust: Species::Skeleton,
    // rust: Species::Stray,
    // rust: Species::Bogged,
    // rust: Species::WitherSkeleton,
    // rust: ],
    // rust: false,
    // rust: ),
    // rust: );
}
/// `Parrot.registerGoals`: a tamed parrot sits when told to and follows its
/// owner from five blocks away; it wanders to trees (`ParrotWanderGoal`) and
/// lands on its owner's shoulder.
pub fn register_parrot(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, TamePanic(Panic::new(1.25)));
    // rust: g.add(0, Float);
    // rust: g.add(1, LookAtPlayer::new(8.0));
    // rust: g.add(2, SitWhenOrdered);
    // rust: g.add(2, FollowOwner::new(1.0, 5.0, 1.0));
    // rust: g.add(2, Stroll::parrot(1.0));
    // rust: g.add(3, LandOnOwnersShoulder);
    // rust: g.add(3, super::goals::FollowMob::new(1.0, 3.0, 7.0));
}
/// `LandOnOwnersShoulderGoal`: a standing parrot, 100 ticks old, lands on
/// the shoulder of the owner it touches; the host does the landing.
pub const LandOnOwnersShoulder = struct {};
    // rust: impl Goal for LandOnOwnersShoulder {
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
        // ShoulderRidingEntity.canSitOnShoulder: rideCooldownCounter > 100.
    // rust: is_owner(m, cx.w)
    // rust: && owner(m, cx.w).is_some_and(|(_, _, spectator)| !spectator)
    // rust: && !m.extra.sitting
    // rust: && m.age > 100
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if !m.extra.sitting
    // rust: && m.extra.leash.is_none()
    // rust: && is_owner(m, cx.w)
    // rust: && cx
    // rust: .w
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| m.bounds().intersects(p.bounds))
    // rust: {
    // rust: cx.events.push(MobEvent::ParrotToShoulder { mob: m.id });
}
}
}
/// `Wolf.PREY_SELECTOR`: sheep, rabbits and foxes.
pub fn wolf_prey(s: *super::Seen) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(s.species, Species::Sheep | Species::Rabbit | Species::Fox)
}
pub fn baby_turtle_on_land(s: *super::Seen) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.species == Species::Turtle && s.baby
}
/// `NeutralMob.isAngryAt(player)`: the player the anger names, or, with the
/// `universal_anger` rule on and no anger target left, any player. Creative and
/// spectator players are dropped first (`isValidPlayerTarget`), by the goal's
/// `can_target_player`.
    // rust: pub(super) fn angry_at_player(m: &Mob, w: &MobWorld) -> bool {
    // rust: m.extra.angry_at == Some(Who::Player)
    // rust: || (w.universal_anger && m.extra.anger > 0 && m.extra.angry_at.is_none())
}
/// `Wolf.isAngry`.
pub fn angry(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.anger > 0
}
/// `TamableAnimal.applyTamingSideEffects` for wolves: 40 health when tame.
pub fn set_tame(m: *mut Mob, tame: bool) void {
}
    // rust: m.extra.tame = tame;
    // rust: if tame {
    // rust: m.attrs.max_health = 40.0;
    // rust: m.health = 40.0;
    // rust: } else {
    // rust: m.attrs.max_health = 8.0;
}
}
/// `TamableAnimal.getOwner`: the player the saved owner UUID names, when it
/// is the one this mob sees; anyone else nearby is not its owner.
    // rust: fn owner_view<'a>(m: &Mob, w: &'a MobWorld) -> Option<&'a PlayerView> {
    // rust: if !m.extra.tame {
    // rust: return None;
}
    // rust: let p = w.player.as_ref()?;
    // rust: (m.extra.owner == Some(p.uuid)).then_some(p)
}
/// The owner's position, eye height and spectator flag when tame.
pub fn owner(m: *Mob, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = owner_view(m, w)?;
    // rust: Some((p.position, p.eye[1], p.spectator))
}
/// Whether the player the mob sees is the one saved as its owner (with
/// guests on, that player is whoever stands nearest).
pub fn is_owner(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| owned_by(m.extra.owner, p.uuid))
}
/// Whether `uuid` is the saved owner. A host with no UUID yet owns what it
/// tamed under the placeholder `[0, 0, 0, 1]`.
pub fn owned_by(owner: ?[i32; 4], uuid: [i32; 4]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: owner.is_some_and(|o| o == uuid || (o == [0, 0, 0, 1] && uuid == [0; 4]))
}
/// `TamableAnimal.unableToMoveToOwner`.
pub fn unable_to_move_to_owner(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.sitting || owner_view(m, w).is_some_and(|p| p.spectator)
}
/// `TamableAnimal.tryToTeleportToOwner`: ten tries around the owner.
pub fn teleport_to_owner(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let Some((at, _, _)) = owner(m, w) else {
    // rust: return;
}
    // rust: let base = [
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: ];
    // rust: for _ in 0..10 {
    // rust: let xd = m.random.next_int_bound(7).unwrap_or(0) - 3;
    // rust: let zd = m.random.next_int_bound(7).unwrap_or(0) - 3;
    // rust: if xd.abs() < 2 && zd.abs() < 2 {
    // rust: continue;
}
    // rust: let yd = m.random.next_int_bound(3).unwrap_or(0) - 1;
    // rust: let p = [base[0] + xd, base[1] + yd, base[2] + zd];
    // rust: if can_teleport_to(m, w, p) {
    // rust: m.position = Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: );
    // rust: m.previous = m.position;
    // rust: m.nav_stop();
    // rust: return;
}
}
}
/// `TamableAnimal.canTeleportTo`: walkable, not on leaves (unless it can
/// fly, `Parrot.canFlyToOwner`), no collision.
pub fn can_teleport_to(m: *Mob, w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let below = w.facts.get(w.world.block(p[0], p[1] - 1, p[2]));
    // rust: let flies = m.species() == Species::Parrot;
    // rust: if !below.full_collision || (!flies && below.name.ends_with("_leaves")) {
    // rust: return false;
}
    // rust: let here = w.facts.get(w.world.block(p[0], p[1], p[2]));
    // rust: if here.fluid != crate::blocks::Fluid::None {
    // rust: return false;
}
    // rust: let half = f64::from(m.width()) / 2.0;
    // rust: let (x, y, z) = (
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: );
    // rust: w.no_collision(Aabb::new(
    // rust: Vec3::new(x - half, y, z - half),
    // rust: Vec3::new(x + half, y + f64::from(m.height()), z + half),
    // rust: ))
}
pub fn owner_distance_sqr(m: *Mob, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: owner(m, w).map(|(at, _, _)| m.distance_sqr(at))
}

/// `TamableAnimal.TamableAnimalPanicGoal`: panic from fire and freezing,
/// teleporting to a far owner.
pub const TamePanic = struct {};
    // rust: impl Goal for TamePanic {
    // rust: goal_clone!();
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
        // PanicGoal with PANIC_ENVIRONMENTAL_CAUSES: only burning or freezing.
    // rust: m.fire_ticks > 0 && self.0.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.can_continue(m, cx)
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
    // rust: if !unable_to_move_to_owner(m, cx.w)
    // rust: && owner_distance_sqr(m, cx.w).is_some_and(|d| d >= 144.0)
    // rust: {
    // rust: teleport_to_owner(m, cx.w);
}
    // rust: self.0.tick(m, cx);
}
}
/// `SitWhenOrderedToGoal`.
pub const SitWhenOrdered = struct {};
    // rust: impl Goal for SitWhenOrdered {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: JUMP | MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.extra.sitting && !m.extra.tame {
    // rust: return false;
}
    // rust: if m.fluids.in_water || !m.on_ground {
    // rust: return false;
}
    // rust: match owner_distance_sqr(m, cx.w) {
    // rust: None => true,
    // rust: Some(d) => {
    // rust: let attacked = owner_view(m, cx.w).is_some_and(|p| p.hurt_by.is_some());
    // rust: !(d < 144.0 && attacked) && m.extra.sitting
}
}
}
pub fn can_continue(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.sitting
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.nav_stop();
    // rust: m.extra.flag = false;
}
}
/// `Wolf.WolfAvoidEntityGoal`: untamed wolves flee llamas.
pub const AvoidLlamas = struct {};
    // rust: impl AvoidLlamas {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(super::goals::AvoidEntity::new(
    // rust: super::goals::Avoid::Species(vec![Species::Llama, Species::TraderLlama]),
    // rust: 24.0,
    // rust: 1.5,
    // rust: 1.5,
    // rust: ))
}
}
/// `Wolf.WolfAvoidEntityGoal`: a wild wolf runs from a llama, the more
/// likely the stronger it is (`strength >= random.nextInt(5)`), and drops
/// its target while it does.
    // rust: impl Goal for AvoidLlamas {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "WolfAvoidEntityGoal"
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
    // rust: if !self.0.can_use(m, cx) {
    // rust: return false;
}
        // Seen.profession is the llama's strength (`variant2`).
    // rust: let Some(strength) = self
    // rust: .0
    // rust: .found
    // rust: .and_then(|id| cx.w.seen(id))
    // rust: .map(|s| s.profession)
    // rust: else {
    // rust: return false;
}
    // rust: !m.extra.tame && i32::from(strength) >= m.random.next_int_bound(5).unwrap_or(0)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.can_continue(m, cx)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: m.ai.target = None;
    // rust: self.0.start(m, cx)
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.stop(m, cx)
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: m.ai.target = None;
    // rust: self.0.tick(m, cx)
}
}
/// `FollowOwnerGoal(speed, startDistance, stopDistance)`.
pub const FollowOwner = struct {
    speed: f64,
    start: f64,
    stop: f64,
    recalc: i32,
};
    // rust: impl FollowOwner {
pub fn new(speed: f64, start: f64, stop: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: speed,
    // rust: start,
    // rust: stop,
    // rust: recalc: 0,
}
}
}
    // rust: impl Goal for FollowOwner {
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
    // rust: let Some(d) = owner_distance_sqr(m, cx.w) else {
    // rust: return false;
}
    // rust: !unable_to_move_to_owner(m, cx.w) && d >= self.start * self.start
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.ai.nav.is_done() || unable_to_move_to_owner(m, cx.w) {
    // rust: return false;
}
    // rust: owner_distance_sqr(m, cx.w).is_some_and(|d| d > self.stop * self.stop)
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: self.recalc = 0;
    // rust: m.set_malus(super::path::PathType::Water, 0.0);
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.nav_stop();
    // rust: let water = super::path::PathType::Water.malus();
    // rust: m.set_malus(super::path::PathType::Water, water);
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some((at, eye, _)) = owner(m, cx.w) else {
    // rust: return;
}
    // rust: let far = m.distance_sqr(at) >= 144.0;
    // rust: if !far {
    // rust: let max = m.max_head_x_rot();
    // rust: m.look_at_speed([at.x, eye, at.z], 10.0, max);
}
    // rust: self.recalc -= 1;
    // rust: if self.recalc <= 0 {
    // rust: self.recalc = reduced(10);
    // rust: if far {
    // rust: teleport_to_owner(m, cx.w);
    // rust: } else {
    // rust: m.nav_move_to_entity(cx.w, [at.x, at.y, at.z], 0, self.speed);
}
}
}
}
/// `OwnerHurtByTargetGoal`: attack what hurt the owner.
pub const OwnerHurtBy = struct {
    timestamp: i64,
};
    // rust: impl Goal for OwnerHurtBy {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TARGET
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.extra.tame || m.extra.sitting {
    // rust: return false;
}
    // rust: let Some((who, at)) = owner_view(m, cx.w).and_then(|p| p.hurt_by) else {
    // rust: return false;
}
    // rust: at != self.timestamp && wants_to_attack(m, cx.w, who)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.ai.target
    // rust: .and_then(|t| cx.w.target_info(t))
    // rust: .is_some_and(|t| t.alive)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some((who, at)) = owner_view(m, cx.w).and_then(|p| p.hurt_by) {
    // rust: m.ai.target = Some(who);
    // rust: self.timestamp = at;
}
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.ai.target = None;
}
}
/// `OwnerHurtTargetGoal`: attack what the owner attacks.
pub const OwnerHurt = struct {
    timestamp: i64,
};
    // rust: impl Goal for OwnerHurt {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TARGET
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.extra.tame || m.extra.sitting {
    // rust: return false;
}
    // rust: let Some((who, at)) = owner_view(m, cx.w).and_then(|p| p.last_hurt) else {
    // rust: return false;
}
    // rust: at != self.timestamp && wants_to_attack(m, cx.w, who)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.ai.target
    // rust: .and_then(|t| cx.w.target_info(t))
    // rust: .is_some_and(|t| t.alive)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some((who, at)) = owner_view(m, cx.w).and_then(|p| p.last_hurt) {
    // rust: m.ai.target = Some(who);
    // rust: self.timestamp = at;
}
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.ai.target = None;
}
}
/// `Wolf.wantsToAttack`: never creepers, ghasts, tame cats and parrots, or a
/// tame wolf of the same owner.
pub fn wants_to_attack(m: *Mob, w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Who::Mob(id) = who else {
    // rust: return false;
}
    // rust: if id == m.id {
    // rust: return false;
}
    // rust: let Some(s) = w.seen(id) else {
    // rust: return false;
}
    // rust: match s.species {
    // rust: Species::Creeper | Species::Ghast => false,
    // rust: Species::Wolf => !s.tame || s.owner != m.extra.owner,
    // rust: Species::Cat | Species::Parrot => !s.tame,
    // rust: Species::Horse | Species::Donkey | Species::Mule | Species::Llama => !s.tame,
    // rust: _ => true,
}
}
/// `BegGoal`: tilt the head at a player holding something interesting.
pub const Beg = struct {
    food: std::sync::*[[]const u8],
    ticks: i32,
};
    // rust: impl Beg {
pub fn interesting(self: *Self, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(p) = &w.player else {
    // rust: return false;
}
    // rust: let held = |i: &Option<std::sync::Arc<str>>| {
            // `BegGoal.playerHoldingInteresting`: a bone or food, tame or not.
    // rust: i.as_deref()
    // rust: .is_some_and(|i| i == "minecraft:bone" || self.food.iter().any(|f| f == i))
}
    // rust: p.alive && !p.spectator && (held(&p.main_hand) || held(&p.off_hand))
}
}
    // rust: impl Goal for Beg {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cx.w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| m.distance_sqr(p.position) <= 64.0)
    // rust: && self.interesting(cx.w)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cx.w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.alive && m.distance_sqr(p.position) <= 64.0)
    // rust: && self.ticks > 0
    // rust: && self.interesting(cx.w)
}
pub fn start(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.extra.flag = true;
    // rust: self.ticks = reduced(40 + m.random.next_int_bound(40).unwrap_or(0));
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.extra.flag = false;
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(p) = &cx.w.player {
    // rust: let max = m.max_head_x_rot();
    // rust: m.look_at_speed([p.position.x, p.eye[1], p.position.z], 10.0, max);
}
    // rust: self.ticks -= 1;
}
}
/// `NeutralMob.isValidPlayerTarget`: a player in survival or adventure, off
/// peaceful.
pub fn valid_player_target(w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| !p.creative && !p.spectator)
    // rust: && w.difficulty.id != 0
}
/// `NeutralMob.stopBeingAngry`.
pub fn stop_being_angry(m: *mut Mob) void {
}
    // setLastHurtByMob(null) also stamps the time.
    // rust: m.ai.last_hurt_by = None;
    // rust: m.ai.last_hurt_by_time = m.age as i32;
    // rust: m.ai.target = None;
    // rust: m.extra.angry_at = None;
    // rust: m.extra.anger = 0;
}
/// `NeutralMob.playerDied`: the anger at the player who died ends.
pub fn forgive_dead_player(m: *mut Mob) void {
}
    // rust: if m.extra.angry_at == Some(Who::Player) {
    // rust: stop_being_angry(m);
}
}
/// `NeutralMob.updatePersistentAnger(level, true)` from `Wolf.aiStep`: any
/// target (the attacker, a pack-mate's attacker the `HurtByTargetGoal` alert
/// gave it, prey, the owner's enemy) is the anger's target, and the 20 to 39
/// seconds of `PERSISTENT_ANGER_TIME` start over every tick it is held.
/// Without a target the anger runs out (`extra.anger` counts down to the end
/// time), and anger at a mob ends when that mob dies.
pub fn update_persistent_anger(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let angry_at = m.extra.angry_at;
    // rust: if let Some(target @ Who::Mob(id)) = m.ai.target
    // rust: && w.seen(id).is_none_or(|s| !s.alive)
    // rust: && angry_at == Some(target)
    // rust: {
    // rust: stop_being_angry(m);
    // rust: return;
}
    // Mob.getTarget: a player in creative or spectator mode is no target.
    // rust: let target = m.ai.target.filter(|t| {
    // rust: *t != Who::Player
    // rust: || w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| !p.creative && !p.spectator)
    // rust: });
    // rust: if let Some(target) = target {
    // rust: m.extra.angry_at = Some(target);
        // Wolf.startPersistentAngerTimer: TimeUtil.rangeOfSeconds(20, 39).
    // rust: m.extra.anger = 400 + m.random.next_int_bound(381).unwrap_or(0);
    // rust: } else if m.extra.anger > 0 {
    // rust: m.extra.anger -= 1;
}
    // rust: if angry_at.is_some()
    // rust: && m.extra.anger == 0
    // rust: && !(target == Some(Who::Player) && valid_player_target(w))
    // rust: {
    // rust: stop_being_angry(m);
}
    // The anger's target as it was when the tick began, once it is found: a
    // player who is not here yet (a reloaded wolf ticks before the player
    // joins) keeps the anger.
    // rust: if angry_at == Some(Who::Player)
    // rust: && w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.creative || p.spectator || w.difficulty.id == 0)
    // rust: {
    // rust: stop_being_angry(m);
}
}
/// The part of `Wolf.tick` both sides run: `interestedAngle` eases toward 1
/// while the wolf begs (`isInterested`, `DATA_INTERESTED_ID`), toward 0
/// otherwise, for `getHeadRollAngle`.
pub fn interest_tick(m: *mut Mob) void {
}
    // rust: let goal = if m.extra.flag { 1.0 } else { 0.0 };
    // rust: m.anim.vo[INTEREST] = m.anim.v[INTEREST];
    // rust: m.anim.v[INTEREST] += (goal - m.anim.v[INTEREST]) * 0.4;
}
/// `Wolf.tick` / `aiStep`: anger, begging tilt and shaking off water.
pub fn ai_step(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: update_persistent_anger(m, w);
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: interest_tick(m);
    // isWet (extra.flag2), isShaking (counter2 > 0).
    // rust: let wet = m.fluids.in_water || super::ai::in_rain(m, w);
    // rust: server_shake(m, wet, events);
}
/// A server's wolf: `Wolf.aiStep` starts shaking a wet wolf that stands on
/// the ground and is not pathing, and tells the clients (entity event 8),
/// then `Wolf.tick` runs the shake (`shake_tick`). `wet` is
/// `isInWaterOrRain`.
pub fn server_shake(m: *mut Mob, wet: bool, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.extra.flag2 && m.extra.counter2 == 0 && m.ai.nav.is_done() && m.on_ground {
    // rust: start_shaking(m);
    // rust: broadcast(m, events, 8);
}
    // rust: shake_tick(m, wet, true, events);
}
/// `Wolf.tick` for a wolf of a server (`rain` is `isInRain` at the wolf):
/// a client knows it is wet on its own, starts and cancels the shake from
/// the server's entity events (`entity_event`) and draws the splashes.
pub fn client_tick(m: *mut Mob, rain: bool, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.alive() {
    // rust: shake_tick(m, m.fluids.in_water || rain, false, events);
}
}
/// `Entity.isInRain`, for a client's wolves.
pub fn in_rain(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::ai::in_rain(m, w)
}
/// `Wolf.handleEntityEvent`: 8 starts the shake, 56 cancels it.
pub fn entity_event(m: *mut Mob, event: u8) void {
}
    // rust: match event {
    // rust: 8 => start_shaking(m),
    // rust: 56 => cancel_shake(m),
    // rust: _ => {}
}
}
/// `isShaking = true`, `shakeAnim` and `shakeAnimO` from 0.
pub fn start_shaking(m: *mut Mob) void {
}
    // rust: m.extra.counter2 = 1;
    // rust: m.anim.v[SHAKE] = 0.0;
    // rust: m.anim.vo[SHAKE] = 0.0;
}
/// `Wolf.die`: the wet and shake state is cleared before the rest of the
/// death, so a wolf killed mid-shake does not shake on the ground.
pub fn die(m: *mut Mob) void {
}
    // rust: m.extra.flag2 = false;
    // rust: cancel_shake(m);
}
/// `Wolf.cancelShake`: it stays wet.
pub fn cancel_shake(m: *mut Mob) void {
}
    // rust: m.extra.counter2 = 0;
    // rust: m.anim.v[SHAKE] = 0.0;
    // rust: m.anim.vo[SHAKE] = 0.0;
}
pub fn broadcast(m: *Mob, events: *mut std.ArrayList(MobEvent), event: i8) void {
}
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}
/// The wet and shaking part of `Wolf.tick`. In water or rain the wolf is
/// wet, and a server cancels its shake (entity event 56). Out of it a
/// shaking wolf shakes for 2 (`shakeAnim` by 0.05 a tick), dry at the end,
/// with splashes past 0.4 (drawn by a client). The sound is the server's:
/// `Entity.playSound` plays nothing on a client (`ClientLevel.playSound`
/// with no player).
pub fn shake_tick(m: *mut Mob, wet: bool, server: bool, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let shaking = m.extra.counter2 > 0;
    // rust: if wet {
    // rust: m.extra.flag2 = true;
    // rust: if shaking && server {
    // rust: broadcast(m, events, 56);
    // rust: cancel_shake(m);
}
    // rust: } else if shaking {
    // rust: if m.anim.v[SHAKE] == 0.0 {
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0;
    // rust: if server {
    // rust: events.push(MobEvent::Sound("entity.wolf.shake", m.center(), 0.4, pitch));
                // Wolf.tick: `gameEvent(GameEvent.ENTITY_ACTION)` with the sound (a client's
                // level hears no game events).
    // rust: events.push(MobEvent::GameEvent {
    // rust: event: "minecraft:entity_action",
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: source: m.id,
    // rust: state: horizon_world::registry::BlockStateId(0),
    // rust: });
}
}
    // rust: m.anim.vo[SHAKE] = m.anim.v[SHAKE];
    // rust: m.anim.v[SHAKE] += 0.05;
    // rust: if m.anim.vo[SHAKE] >= 2.0 {
    // rust: m.extra.flag2 = false;
    // rust: cancel_shake(m);
}
    // rust: if m.anim.v[SHAKE] > 0.4 {
            // The server draws the offsets too (its addParticle draws nothing).
    // rust: let y = m.position.y as f32 + 0.8;
    // rust: let count = (((m.anim.v[SHAKE] - 0.4) * PI).msin() * 7.0) as i32;
    // rust: let half = m.width() * 0.5;
    // rust: let v = m.velocity;
    // rust: for _ in 0..count {
    // rust: let dx = (m.random.next_float() * 2.0 - 1.0) * half;
    // rust: let dz = (m.random.next_float() * 2.0 - 1.0) * half;
    // rust: events.push(MobEvent::ParticleAt {
    // rust: kind: "splash",
    // rust: at: [
    // rust: m.position.x + f64::from(dx),
    // rust: f64::from(y),
    // rust: m.position.z + f64::from(dz),
    // rust: ],
    // rust: velocity: [v.x, v.y, v.z],
    // rust: });
}
}
}
}
/// `Wolf.hurtServer`, `Parrot.hurtServer`: `setOrderedToSit(false)`. A
/// wolf's anger comes with the target (`HurtByTargetGoal`, then
/// `updatePersistentAnger`).
pub fn stand_when_hurt(m: *mut Mob) void {
}
    // rust: m.extra.sitting = false;
}
/// `Wolf.getTailAngle`.
pub fn tail_angle(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if angry(m) {
    // rust: 1.539_380_4
    // rust: } else if m.extra.tame {
    // rust: let max = m.attrs.max_health;
    // rust: let ratio = (max - m.health) / max;
    // rust: (0.55 - ratio * 0.4) * PI
    // rust: } else {
    // rust: PI / 5.0
}
}
/// `WolfRenderState.getBodyRollAngle`.
pub fn body_roll(shake: f32, offset: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = ((shake + offset) / 1.8).clamp(0.0, 1.0);
    // rust: (p * PI).msin() * (p * PI * 11.0).msin() * 0.15 * PI
}
/// `WolfModel.setupAnim` with the adult and baby overrides.
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // rust: let (pos, speed) = (s.pos, s.speed);
    // rust: let baby = m.is_baby();
    // rust: if angry(m) {
    // rust: p.yrot("tail", 0.0);
    // rust: } else {
    // rust: p.yrot("tail", (pos * 0.6662).mcos() * 1.4 * speed);
}
    // rust: if m.extra.sitting {
    // rust: let age = if baby { 0.5 } else { 1.0 };
    // rust: let add = |p: &mut Poses, part: &str, x: f32, y: f32, z: f32| {
    // rust: let v = p.get(part);
    // rust: v[0] += x;
    // rust: v[1] += y;
    // rust: v[2] += z;
}
    // rust: add(p, "body", 0.0, 4.0 * age, -2.0 * age);
    // rust: p.xrot("body", PI / 4.0);
    // rust: add(p, "tail", 0.0, 9.0 * age, -2.0 * age);
    // rust: add(p, "right_hind_leg", 0.0, 6.7 * age, -5.0 * age);
    // rust: p.xrot("right_hind_leg", PI * 3.0 / 2.0);
    // rust: add(p, "left_hind_leg", 0.0, 6.7 * age, -5.0 * age);
    // rust: p.xrot("left_hind_leg", PI * 3.0 / 2.0);
    // rust: p.xrot("right_front_leg", 5.811_947);
    // rust: add(p, "right_front_leg", 0.01 * age, 1.0 * age, 0.0);
    // rust: p.xrot("left_front_leg", 5.811_947);
    // rust: add(p, "left_front_leg", -0.01 * age, 1.0 * age, 0.0);
    // rust: if baby {
    // rust: let x = p.get("body")[3] - PI / 2.0;
    // rust: p.xrot("body", x);
    // rust: } else if p.has("upper_body") {
    // rust: p.get("upper_body")[1] += 2.0;
    // rust: p.xrot("upper_body", PI * 2.0 / 5.0);
    // rust: p.yrot("upper_body", 0.0);
}
    // rust: } else {
    // rust: p.xrot("right_hind_leg", (pos * 0.6662).mcos() * 1.4 * speed);
    // rust: p.xrot("left_hind_leg", (pos * 0.6662 + PI).mcos() * 1.4 * speed);
    // rust: p.xrot("right_front_leg", (pos * 0.6662 + PI).mcos() * 1.4 * speed);
    // rust: p.xrot("left_front_leg", (pos * 0.6662).mcos() * 1.4 * speed);
}
    // shakeOffWater
    // rust: let shake = m.anim.lerp(SHAKE, s.partial);
    // rust: let roll = m.anim.lerp(INTEREST, s.partial) * 0.15 * PI;
    // rust: p.zrot("body", body_roll(shake, -0.16));
    // rust: if baby {
    // rust: p.zrot("head", roll + body_roll(shake, 0.0));
    // rust: p.zrot("tail", body_roll(shake, -0.2));
    // rust: } else {
    // rust: if p.has("real_head") {
    // rust: p.zrot("real_head", roll + body_roll(shake, 0.0));
}
    // rust: if p.has("upper_body") {
    // rust: p.zrot("upper_body", body_roll(shake, -0.08));
}
    // rust: if p.has("real_tail") {
    // rust: p.zrot("real_tail", body_roll(shake, -0.2));
}
}
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: p.xrot("tail", tail_angle(m));
}
/// `Wolf.getWetShade` as a vertex colour.
pub fn tint(m: *Mob, partial: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.extra.flag2 {
    // rust: return 0xFFFF_FFFF;
}
    // rust: let shade = (0.75 + m.anim.lerp(SHAKE, partial) / 2.0 * 0.25).min(1.0);
    // rust: let c = (shade * 255.0) as u32;
    // rust: 0xFF00_0000 | c << 16 | c << 8 | c
}
/// `Wolf.getTexture`.
pub fn texture(m: *Mob) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = WOLF_VARIANTS[(m.extra.variant as usize).min(8)].1;
    // rust: let state = if m.extra.tame {
    // rust: "_tame"
    // rust: } else if angry(m) {
    // rust: "_angry"
    // rust: } else {
    // rust: ""
}
    // rust: let baby = if m.is_baby() { "_baby" } else { "" };
    // rust: format!("entity/wolf/{file}{state}{baby}")
}

/// Cat variants (`CatVariants`): registry name, texture file.
    // rust: pub const CAT_VARIANTS: [&str; 11] = [
    // rust: "tabby",
    // rust: "black",
    // rust: "red",
    // rust: "siamese",
    // rust: "british_shorthair",
    // rust: "calico",
    // rust: "persian",
    // rust: "ragdoll",
    // rust: "white",
    // rust: "jellie",
    // rust: "all_black",
    // rust: ];
// Cat AnimState slots.
pub const LIE: usize = 0;
pub const LIE_TAIL: usize = 1;
pub const RELAX: usize = 2;

/// `Cat.registerGoals` (with `reassessTameGoals`' player avoidance).
pub fn register_cat(m: *mut Mob) void {
}
    // rust: m.extra.color = RED;
    // rust: let food = m.kind.food.clone();
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Float);
    // rust: g.add(1, TamePanic(Panic::new(1.5)));
    // rust: g.add(2, SitWhenOrdered);
    // rust: g.add(3, CatRelaxOnOwner::default());
    // rust: g.add(4, CatTempt(super::goals::Tempt::new(0.6, food, true), None));
    // rust: g.add(
    // rust: 5,
    // rust: CatLieOnBlock(super::goals::MoveToBlock {
    // rust: vertical_start: -2,
    // rust: ..super::goals::MoveToBlock::new(1.1, 8, 6)
    // rust: }),
    // rust: );
    // rust: g.add(6, FollowOwner::new(1.0, 10.0, 5.0));
    // rust: g.add(7, CatSitOnBlock(super::goals::MoveToBlock::new(0.8, 8, 1)));
    // rust: g.add(8, LeapAtTarget::new(0.3));
    // rust: g.add(9, OcelotAttack { attack_time: 0 });
    // rust: g.add(10, Breed::new(0.8));
    // rust: g.add(11, Stroll::avoiding_water(0.8));
    // rust: g.add(12, LookAtPlayer::new(10.0));
    // `reassessTameGoals` adds the avoidance after `registerGoals`: goals run
    // in insertion order, so it comes last.
    // rust: g.add(
    // rust: 4,
    // rust: super::goals::AvoidEntity::new(super::goals::Avoid::Player, 16.0, 0.8, 1.33)
    // rust: .when(|m| !m.extra.tame),
    // rust: );
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: NearestTarget::species(&[Species::Rabbit], false).gate(|m, _| !m.extra.tame),
    // rust: );
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: NearestTarget::new(Prey::Filter(baby_turtle_on_land), false).gate(|m, _| !m.extra.tame),
    // rust: );
}
/// `Ocelot.registerGoals`, then `reassessTrustingGoals` adds the player
/// avoidance last. A trusting ocelot (`Ocelot.mobInteract`, the `Trusting`
/// tag) neither runs from players nor is scared off while tempted.
pub fn register_ocelot(m: *mut Mob) void {
}
    // rust: let food = m.kind.food.clone();
    // rust: let mut stroll = Stroll::avoiding_water(0.8);
    // rust: stroll.water_avoiding = Some(1.000_000_1e-5);
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Float);
    // rust: g.add(3, OcelotTempt(super::goals::Tempt::new(0.6, food, true)));
    // rust: g.add(7, LeapAtTarget::new(0.3));
    // rust: g.add(8, OcelotAttack { attack_time: 0 });
    // rust: g.add(9, Breed::new(0.8));
    // rust: g.add(10, stroll);
    // rust: g.add(11, LookAtPlayer::new(10.0));
    // rust: g.add(4, OcelotAvoid::new());
    // rust: m.ai.targets
    // rust: .add(1, NearestTarget::species(&[Species::Chicken], false));
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: NearestTarget::new(Prey::Filter(baby_turtle_on_land), false),
    // rust: );
}
/// `Ocelot.OcelotTemptGoal(ocelot, 0.6, ocelot food, true)`.
pub const OcelotTempt = struct {};
    // rust: impl Goal for OcelotTempt {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "OcelotTemptGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.flags()
}
    // `OcelotTemptGoal.canScare`: `super.canScare() && !isTrusting()`.
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scared_unless_trusting(m, |t, m| t.can_use(m, cx))
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scared_unless_trusting(m, |t, m| t.can_continue(m, cx))
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx)
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.stop(m, cx)
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.every_tick()
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.scared_unless_trusting(m, |t, m| t.tick(m, cx))
}
}
    // rust: impl OcelotTempt {
    /// Runs `f` with the tempt goal's `can_scare` off for a trusting ocelot.
    // rust: fn scared_unless_trusting<R>(
    // rust: &mut self,
    // rust: m: &mut Mob,
    // rust: f: impl FnOnce(&mut super::goals::Tempt, &mut Mob) -> R,
    // rust: ) -> R {
    // rust: let scare = self.0.can_scare;
    // rust: self.0.can_scare = scare && !m.extra.trusting;
    // rust: let result = f(&mut self.0, m);
    // rust: self.0.can_scare = scare;
    // rust: result
}
}
/// `Ocelot.OcelotAvoidEntityGoal(ocelot, Player.class, 16.0F, 0.8, 1.33)`.
pub const OcelotAvoid = struct {};
    // rust: impl OcelotAvoid {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(super::goals::AvoidEntity::new(
    // rust: super::goals::Avoid::Player,
    // rust: 16.0,
    // rust: 0.8,
    // rust: 1.33,
    // rust: ))
}
}
    // rust: impl Goal for OcelotAvoid {
    // rust: goal_clone!();
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "OcelotAvoidEntityGoal"
}
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.flags()
}
    // `OcelotAvoidEntityGoal.canUse` and `canContinueToUse`: `!isTrusting() && super`.
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !m.extra.trusting && self.0.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !m.extra.trusting && self.0.can_continue(m, cx)
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
/// `Cat.isInSittingPose`: ordered to sit or sitting on a block.
pub fn cat_sitting(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.sitting || m.extra.flag2
}
/// `Cat.CatTemptGoal`: only wild cats come for fish. The second field is
/// `selectedPlayer`, the player the cat has picked to approach unscared.
pub const CatTempt = struct {};
    // rust: impl Goal for CatTempt {
    // rust: goal_clone!();
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
    // rust: !m.extra.tame && self.0.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
        // CatTemptGoal.canScare: a selected player that is the tempter is not scared.
    // rust: let picked = self.1.is_some() && self.1 == cx.w.player.as_ref().map(|p| p.uuid);
    // rust: let scare = self.0.can_scare;
    // rust: self.0.can_scare = scare && !picked;
    // rust: let go = self.0.can_continue(m, cx);
    // rust: self.0.can_scare = scare;
    // rust: go
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx)
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.stop(m, cx)
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.every_tick()
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
        // Cat.tick: a wild cat being tempted begs every 100 ticks.
    // rust: if m.age.is_multiple_of(100) {
    // rust: cx.events.push(MobEvent::Sound(
    // rust: super::finalize::variant_sound(m, "beg_for_food")
    // rust: .unwrap_or("entity.cat.beg_for_food"),
    // rust: m.center(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
    // rust: self.0.tick(m, cx);
        // CatTemptGoal.tick: pick the tempting player with a 1 in 600 chance a
        // tick while none is picked, else drop the pick with a 1 in 500 chance.
    // rust: if self.1.is_none() && m.random.next_int_bound(reduced(600)).unwrap_or(1) == 0 {
    // rust: self.1 = cx.w.player.as_ref().map(|p| p.uuid);
    // rust: } else if m.random.next_int_bound(reduced(500)).unwrap_or(1) == 0 {
    // rust: self.1 = None;
}
}
}
pub fn has_tag(w: *MobWorld, p: [i32; 3], tag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = w.facts.get(w.world.block(p[0], p[1], p[2])).name.clone();
    // rust: w.block_tags.get(tag).is_some_and(|t| t.contains(&*name))
}
pub fn empty_above(w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.facts
    // rust: .get(w.world.block(p[0], p[1] + 1, p[2]))
    // rust: .name
    // rust: .as_ref()
    // rust: == "minecraft:air"
}
/// Whether `p` is the player that owns `m` (a cat without a recorded owner
/// belongs to whoever it sees).
pub fn is_owner_of(m: *Mob, p: *super::PlayerView) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.owner.is_none_or(|o| o == p.uuid)
}
/// `Cat.CatRelaxOnOwnerGoal`: while the owner sleeps, the cat lies down beside
/// them, and may leave a morning gift when they wake up.
pub const CatRelaxOnOwner = struct {
    goal: Option<[i32,
    on_bed_ticks: i32,
};
    // rust: impl CatRelaxOnOwner {
    /// `spaceIsOccupied`: another cat lying or relaxing within two blocks.
pub fn occupied(self: *Self, m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(g) = self.goal else { return true };
    // rust: let area = Aabb::new(
    // rust: Vec3::new(
    // rust: f64::from(g[0]) - 2.0,
    // rust: f64::from(g[1]) - 2.0,
    // rust: f64::from(g[2]) - 2.0,
    // rust: ),
    // rust: Vec3::new(
    // rust: f64::from(g[0]) + 3.0,
    // rust: f64::from(g[1]) + 3.0,
    // rust: f64::from(g[2]) + 3.0,
    // rust: ),
    // rust: );
    // rust: w.others.iter().any(|o| {
    // rust: o.species == Species::Cat && o.id != m.id && o.lying && o.bounds.intersects(area)
    // rust: })
}
    /// The owner's sleeping state, when this cat may relax on them: the
    /// player it sees has to be its owner (`Cat.getOwner`).
    // rust: fn sleeping_owner<'w>(m: &Mob, w: &'w MobWorld) -> Option<&'w super::PlayerView> {
    // rust: w.player
    // rust: .as_ref()
    // rust: .filter(|p| m.extra.tame && !m.extra.sitting && p.sleeping && is_owner_of(m, p))
}
}
    // rust: impl Goal for CatRelaxOnOwner {
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
    // rust: let w = cx.w;
    // rust: let Some(p) = Self::sleeping_owner(m, w) else {
    // rust: return false;
}
    // rust: if m.distance_sqr(p.position) > 100.0 {
    // rust: return false;
}
    // rust: let at = [
    // rust: p.position.x.floor() as i32,
    // rust: p.position.y.floor() as i32,
    // rust: p.position.z.floor() as i32,
    // rust: ];
    // rust: if !has_tag(w, at, "minecraft:cats_can_lie_on") {
    // rust: return false;
}
        // The bed's foot: against `BedBlock.FACING`.
    // rust: let back = match w.prop(at[0], at[1], at[2], "facing") {
    // rust: Some("north") => [0, 0, 1],
    // rust: Some("south") => [0, 0, -1],
    // rust: Some("east") => [-1, 0, 0],
    // rust: Some("west") => [1, 0, 0],
    // rust: Some("up") => [0, -1, 0],
    // rust: Some("down") => [0, 1, 0],
    // rust: _ => [0, 0, 0],
}
    // rust: self.goal = Some([at[0] + back[0], at[1] + back[1], at[2] + back[2]]);
    // rust: !self.occupied(m, w)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::sleeping_owner(m, cx.w).is_some() && self.goal.is_some() && !self.occupied(m, cx.w)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(g) = self.goal {
    // rust: m.extra.flag2 = false;
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: [f64::from(g[0]), f64::from(g[1]), f64::from(g[2])],
    // rust: 1.1,
    // rust: );
}
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: m.extra.flag = false;
        // The `gameplay/cat_waking_up_gift_chance` of the `day` timeline: 0.7
        // from tick 23667 of the day to tick 362 of the next, 0 in between.
    // rust: let day = cx.w.day_time.rem_euclid(24000);
    // rust: let chance = if !cx.w.nether && !cx.w.end && !(362..23667).contains(&day) {
    // rust: 0.7
    // rust: } else {
    // rust: 0.0
}
    // rust: if cx
    // rust: .w
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| is_owner_of(m, p) && p.sleep_timer >= 100)
    // rust: && m.random.next_float() < chance
    // rust: {
    // rust: give_morning_gift(m, cx);
}
    // rust: self.on_bed_ticks = 0;
    // rust: m.extra.relax_one = false;
    // rust: m.nav_stop();
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let (Some(p), Some(g)) = (cx.w.player.as_ref(), self.goal) else {
    // rust: return;
}
    // rust: m.extra.flag2 = false;
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: [f64::from(g[0]), f64::from(g[1]), f64::from(g[2])],
    // rust: 1.1,
    // rust: );
    // rust: if m.distance_sqr(p.position) < 2.5 {
    // rust: self.on_bed_ticks += 1;
    // rust: if self.on_bed_ticks > reduced(16) {
    // rust: m.extra.flag = true;
    // rust: m.extra.relax_one = false;
    // rust: } else {
    // rust: m.look_at_speed(p.eye, 45.0, 45.0);
    // rust: m.extra.relax_one = true;
}
    // rust: } else {
    // rust: m.extra.flag = false;
}
}
}
/// `CatRelaxOnOwnerGoal.giveMorningGift`: hop to a spot within five blocks
/// (`randomTeleport`, avoiding `#dangerous_for_teleportation`) and drop a
/// `gameplay/cat_morning_gift` item at its feet.
pub fn give_morning_gift(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let w = cx.w;
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: let x = at[0] + m.random.next_int_bound(11).unwrap_or(5) - 5;
    // rust: let y = at[1] + m.random.next_int_bound(5).unwrap_or(2) - 2;
    // rust: let z = at[2] + m.random.next_int_bound(11).unwrap_or(5) - 5;
    // rust: let tagged = |p: [i32; 3], tag| has_tag(w, p, tag);
    // rust: let mut ground = y - 1;
    // rust: while ground > w.world.bottom_y()
    // rust: && !tagged([x, ground, z], "minecraft:entities_can_teleport_to")
    // rust: {
    // rust: ground -= 1;
}
    // rust: if w.world.loaded(x, z) && ground > w.world.bottom_y() {
    // rust: let feet = f64::from(ground + 1);
    // rust: let half = f64::from(m.width()) / 2.0;
    // rust: let b = Aabb::new(
    // rust: Vec3::new(f64::from(x) - half, feet, f64::from(z) - half),
    // rust: Vec3::new(
    // rust: f64::from(x) + half,
    // rust: feet + f64::from(m.height()),
    // rust: f64::from(z) + half,
    // rust: ),
    // rust: );
    // rust: let dangerous = |p| tagged(p, "minecraft:dangerous_for_teleportation");
    // rust: let in_box = |f: &dyn Fn([i32; 3]) -> bool| {
    // rust: (b.min(Axis::X).floor() as i32..=b.max(Axis::X).floor() as i32).any(|bx| {
    // rust: (b.min(Axis::Y).floor() as i32..=b.max(Axis::Y).floor() as i32).any(|by| {
    // rust: (b.min(Axis::Z).floor() as i32..=b.max(Axis::Z).floor() as i32)
    // rust: .any(|bz| f([bx, by, bz]))
    // rust: })
    // rust: })
}
    // rust: let fluids = w.fluids(b, feet);
    // rust: if !dangerous([x, ground, z])
    // rust: && w.no_collision(b)
    // rust: && !(fluids.in_water || fluids.in_lava)
    // rust: && !in_box(&dangerous)
    // rust: {
    // rust: m.position = Vec3::new(f64::from(x), feet, f64::from(z));
    // rust: m.previous = m.position;
    // rust: m.velocity = Vec3::ZERO;
}
}
    // rust: let yaw = m.body_yaw * (PI / 180.0);
    // rust: let here = [
    // rust: m.position.x.floor() - f64::from(yaw.msin()),
    // rust: m.position.y.floor(),
    // rust: m.position.z.floor() + f64::from(yaw.mcos()),
    // rust: ];
    // rust: cx.events.push(MobEvent::DropGift {
    // rust: table: "minecraft:gameplay/cat_morning_gift",
    // rust: at: here,
    // rust: });
}
/// `CatLieOnBlockGoal`: tame cats lie on beds and other warm blocks.
pub const CatLieOnBlock = struct {};
pub fn can_lie_on(w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: empty_above(w, p) && has_tag(w, p, "minecraft:cats_can_lie_on")
}
    // rust: impl Goal for CatLieOnBlock {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: JUMP | MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.tame
    // rust: && !m.extra.sitting
    // rust: && !m.extra.flag
    // rust: && self.0.can_use(m, cx.w, reduced(40), can_lie_on)
}
pub fn can_continue(self: *Self, _: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.can_continue(cx.w, can_lie_on)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx.w);
    // rust: m.extra.flag2 = false;
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.extra.flag = false;
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.tick(m, cx.w);
    // rust: m.extra.flag2 = false;
    // rust: m.extra.flag = self.0.reached;
}
}
/// `CatSitOnBlockGoal`: unopened chests, lit furnaces and the foot of beds.
pub const CatSitOnBlock = struct {};
pub fn can_sit_on(w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !empty_above(w, p) || !has_tag(w, p, "minecraft:cats_can_sit_on") {
    // rust: return false;
}
    // rust: let f = w.facts.get(w.world.block(p[0], p[1], p[2]));
    // rust: match f.name.as_ref() {
        // The lit state is the only light source a furnace has.
    // rust: "minecraft:furnace" => f.emission > 0,
        // `ChestBlockEntity.getOpenCount(level, pos) < 1`: players' openers
        // and the copper golems' own count.
    // rust: "minecraft:chest" => {
    // rust: let key = (p[0], p[1], p[2]);
    // rust: !w.lid_openers.contains_key(&key)
    // rust: && w.world.chest_openers.get(&key).is_none_or(|o| o.0 < 1)
}
        // A bed's foot only (`BedBlock.PART != HEAD`).
    // rust: _ => w.prop(p[0], p[1], p[2], "part") != Some("head"),
}
}
    // rust: impl Goal for CatSitOnBlock {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: JUMP | MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.extra.tame || m.extra.sitting {
    // rust: return false;
}
        // MoveToBlockGoal.canUse draws the next delay only once the last one
        // has run out.
    // rust: if self.0.next_start > 0 {
    // rust: self.0.next_start -= 1;
    // rust: return false;
}
    // rust: let next = reduced(200 + m.random.next_int_bound(200).unwrap_or(0));
    // rust: self.0.can_use(m, cx.w, next, can_sit_on)
}
pub fn can_continue(self: *Self, _: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.can_continue(cx.w, can_sit_on)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx.w);
    // rust: m.extra.flag2 = false;
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.extra.flag2 = false;
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.tick(m, cx.w);
    // rust: m.extra.flag2 = self.0.reached;
}
}
/// `OcelotAttackGoal`: stalk slowly, dash in, swipe every second.
pub const OcelotAttack = struct {
    attack_time: i32,
};
    // rust: impl Goal for OcelotAttack {
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
    // rust: m.ai.target.is_some()
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(t) = m.ai.target.and_then(|t| cx.w.target_info(t)) else {
    // rust: return false;
}
    // rust: t.alive
    // rust: && m.distance_sqr(t.position) <= 225.0
    // rust: && (!m.ai.nav.is_done() || m.ai.target.is_some())
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.nav_stop();
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(who) = m.ai.target else {
    // rust: return;
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 30.0, 30.0);
    // rust: let reach = f64::from(m.width() * 2.0);
    // rust: let melee = reach * reach;
    // rust: let d2 = m.distance_sqr(t.position);
    // rust: let speed = if d2 > melee && d2 < 16.0 {
    // rust: 1.33
    // rust: } else if d2 < 225.0 {
    // rust: 0.6
    // rust: } else {
    // rust: 0.8
}
    // rust: m.nav_move_to_entity(cx.w, [t.position.x, t.position.y, t.position.z], 0, speed);
    // rust: self.attack_time = (self.attack_time - 1).max(0);
    // rust: if d2 <= melee && self.attack_time <= 0 {
    // rust: self.attack_time = 20;
    // rust: super::ai::do_hurt_target(m, who, cx);
}
}
}
/// `Cat.tick`: lying and relaxing amounts and the purr.
pub fn cat_ai_step(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: cat_amounts(m);
    // rust: if (m.extra.flag || m.extra.relax_one) && m.age.is_multiple_of(5) {
    // rust: let volume = 0.6 + 0.4 * (m.random.next_float() - m.random.next_float());
    // rust: let sound = super::finalize::variant_sound(m, "purr").unwrap_or("entity.cat.purr");
    // rust: events.push(MobEvent::Sound(sound, m.center(), volume, 1.0));
}
}
/// The lying and relaxing amounts of `Cat.tick` (also a client's, from the
/// synched flags).
pub fn cat_amounts(m: *mut Mob) void {
}
    // rust: let lying = m.extra.flag;
    // rust: let relaxing = m.extra.relax_one;
    // rust: let v = &mut m.anim.v;
    // rust: if lying {
    // rust: v[LIE] = (v[LIE] + 0.15).min(1.0);
    // rust: v[LIE_TAIL] = (v[LIE_TAIL] + 0.08).min(1.0);
    // rust: } else {
    // rust: v[LIE] = (v[LIE] - 0.22).max(0.0);
    // rust: v[LIE_TAIL] = (v[LIE_TAIL] - 0.13).max(0.0);
}
    // rust: v[RELAX] = if relaxing {
    // rust: (v[RELAX] + 0.1).min(1.0)
    // rust: } else {
    // rust: (v[RELAX] - 0.13).max(0.0)
}
}
/// `Cat.finalizeSpawn` variant: any but all-black, which a full moon allows.
pub fn cat_variant(m: *mut Mob, w_moon_full: bool) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = if w_moon_full { 11 } else { 10 };
    // rust: m.random.next_int_bound(n).unwrap_or(0) as u8
}
pub fn cat_texture(m: *Mob) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = CAT_VARIANTS[(m.extra.variant as usize).min(10)];
    // rust: let baby = if m.is_baby() { "_baby" } else { "" };
    // rust: format!("entity/cat/cat_{v}{baby}")
}
/// `CatRenderer.setupRotations`: lying cats roll onto their side.
pub fn cat_rotations(m: *Mob, partial: f32) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lie = m.anim.lerp(LIE, partial);
    // rust: if lie <= 0.0 {
    // rust: return glam::Mat4::IDENTITY;
}
    // rust: let on_top = if m.extra.on_sleeper { 0.15 * lie } else { 0.0 };
    // rust: glam::Mat4::from_translation(glam::Vec3::new(0.4 * lie, 0.15 * lie, 0.1 * lie))
    // rust: * glam::Mat4::from_rotation_z((90.0 * lie).to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(on_top, 0.0, 0.0))
}
/// `Cat.handleLieDown`'s `isLyingOnTopOfSleepingPlayer`: a lying cat with a
/// sleeping player within two blocks of its block (`sleepers` are their
/// bounding boxes).
pub fn cat_lying_on_sleeper(m: *mut Mob, sleepers: *[horizon_core::geometry::Aabb]) void {
}
    // rust: m.extra.on_sleeper = false;
    // rust: if !m.extra.flag {
    // rust: return;
}
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor(),
    // rust: m.position.y.floor(),
    // rust: m.position.z.floor(),
    // rust: );
    // rust: let area = horizon_core::geometry::Aabb::new(
    // rust: Vec3::new(x - 2.0, y - 2.0, z - 2.0),
    // rust: Vec3::new(x + 3.0, y + 3.0, z + 3.0),
    // rust: );
    // rust: m.extra.on_sleeper = sleepers.iter().any(|b| b.intersects(area));
}
/// `Mth.rotLerp`: degrees-wrapping, applied by the feline models to radians.
pub fn rot_lerp(t: f32, from: f32, to: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: from + t * super::living::wrap(to - from)
}
/// `FelineRenderState` values the feline models read.
pub const Feline = struct {
    crouching: bool,
    sprinting: bool,
    sitting: bool,
    lie_down: f32,
    lie_down_tail: f32,
    relax_one: f32,
};
/// `Cat.customServerAiStep` and `Ocelot.customServerAiStep`: crouch while
/// stalking (the move control's 0.6), sprint while dashing (1.33). Sprinting
/// adds `LivingEntity.SPEED_MODIFIER_SPRINTING` (`Mob::movement_speed`) to the
/// move control's tick that follows.
pub fn feline_server_ai_step(m: *mut Mob) void {
}
    // rust: let speed = m.ai.mov.has_wanted().then_some(m.ai.mov.speed_modifier);
    // rust: m.extra.pose = if speed == Some(0.6) {
    // rust: super::sync::CROUCHING
    // rust: } else {
    // rust: super::sync::STANDING
}
    // rust: m.extra.sprinting = speed == Some(1.33);
}
/// `AdultFelineModel` / `BabyFelineModel.setupAnim` for cats and ocelots.
pub fn cat_anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // FelineRenderState: Entity.isCrouching (the pose) and isSprinting.
    // rust: let st = Feline {
    // rust: crouching: m.extra.pose == super::sync::CROUCHING,
    // rust: sprinting: m.extra.sprinting,
    // rust: sitting: cat_sitting(m),
    // rust: lie_down: m.anim.lerp(LIE, s.partial),
    // rust: lie_down_tail: m.anim.lerp(LIE_TAIL, s.partial),
    // rust: relax_one: m.anim.lerp(RELAX, s.partial),
}
    // rust: feline(p, s, &st);
}
pub fn feline(p: *mut Poses, s: *State, st: *Feline) void {
}
    // rust: let baby = s.baby;
    // rust: let age = if baby { 0.5 } else { 1.0 };
    // rust: let (crouching, sprinting, sitting) = (st.crouching, st.sprinting, st.sitting);
    // rust: let add = |p: &mut Poses, part: &str, x: f32, y: f32, z: f32| {
    // rust: let v = p.get(part);
    // rust: v[0] += x;
    // rust: v[1] += y;
    // rust: v[2] += z;
}
    // rust: if crouching {
    // rust: add(p, "body", 0.0, age, 0.0);
    // rust: add(p, "head", 0.0, 2.0 * age, 0.0);
    // rust: add(p, "tail1", 0.0, age, 0.0);
    // rust: add(p, "tail2", 0.0, -4.0 * age, 2.0 * age);
    // rust: p.xrot("tail1", PI / 2.0);
    // rust: p.xrot("tail2", PI / 2.0);
    // rust: } else if sprinting {
    // rust: let y1 = p.get("tail1")[1];
    // rust: p.get("tail2")[1] = y1;
    // rust: add(p, "tail2", 0.0, 0.0, 2.0 * age);
    // rust: p.xrot("tail1", PI / 2.0);
    // rust: p.xrot("tail2", PI / 2.0);
}
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: let (pos, sp) = (s.pos, s.speed);
    // rust: if !sitting {
    // rust: if !baby {
    // rust: p.xrot("body", PI / 2.0);
}
    // rust: if sprinting {
    // rust: p.xrot("left_hind_leg", (pos * 0.6662).mcos() * sp);
    // rust: p.xrot("right_hind_leg", (pos * 0.6662 + 0.3).mcos() * sp);
    // rust: p.xrot("left_front_leg", (pos * 0.6662 + PI + 0.3).mcos() * sp);
    // rust: p.xrot("right_front_leg", (pos * 0.6662 + PI).mcos() * sp);
    // rust: p.xrot("tail2", 1.727_876_1 + PI / 10.0 * pos.mcos() * sp);
    // rust: } else {
    // rust: p.xrot("left_hind_leg", (pos * 0.6662).mcos() * sp);
    // rust: p.xrot("right_hind_leg", (pos * 0.6662 + PI).mcos() * sp);
    // rust: p.xrot("left_front_leg", (pos * 0.6662 + PI).mcos() * sp);
    // rust: p.xrot("right_front_leg", (pos * 0.6662).mcos() * sp);
    // rust: let swing = if crouching { 0.471_238_94 } else { PI / 4.0 };
    // rust: p.xrot("tail2", 1.727_876_1 + swing * pos.mcos() * sp);
}
    // rust: } else if baby {
    // rust: let x = p.get("body")[3] - 0.436_332_32;
    // rust: p.xrot("body", x);
    // rust: add(p, "body", 0.0, 1.25, 0.0);
    // rust: add(p, "head", 0.0, 0.0, 0.75);
    // rust: let t = p.get("tail1")[3] + 0.545_415_4;
    // rust: p.xrot("tail1", t);
    // rust: add(p, "tail1", 0.0, 4.0, -0.9);
    // rust: add(p, "left_hind_leg", 0.0, 0.0, -0.9);
    // rust: add(p, "right_hind_leg", 0.0, 0.0, -0.9);
    // rust: } else {
    // rust: p.xrot("body", PI / 4.0);
    // rust: add(p, "body", 0.0, -4.0 * age, 5.0 * age);
    // rust: add(p, "head", 0.0, -3.3 * age, age);
    // rust: add(p, "tail1", 0.0, 8.0 * age, -2.0 * age);
    // rust: add(p, "tail2", 0.0, 2.0 * age, -0.8 * age);
    // rust: p.xrot("tail1", 1.727_876_1);
    // rust: p.xrot("tail2", 2.670_354);
    // rust: p.xrot("left_front_leg", -PI / 20.0);
    // rust: add(p, "left_front_leg", 0.0, 2.0 * age, -2.0 * age);
    // rust: p.xrot("right_front_leg", -PI / 20.0);
    // rust: add(p, "right_front_leg", 0.0, 2.0 * age, -2.0 * age);
    // rust: p.xrot("left_hind_leg", -PI / 2.0);
    // rust: add(p, "left_hind_leg", 0.0, 3.0 * age, -4.0 * age);
    // rust: p.xrot("right_hind_leg", -PI / 2.0);
    // rust: add(p, "right_hind_leg", 0.0, 3.0 * age, -4.0 * age);
}
    // rust: let lie = st.lie_down;
    // rust: let lie_tail = st.lie_down_tail;
    // rust: if lie > 0.0 && baby {
    // rust: add(p, "body", 1.0, 0.0, 0.0);
    // rust: let hx = p.get("head")[3];
    // rust: p.xrot("head", rot_lerp(lie, hx, PI / 18.0));
    // rust: let hz = p.get("head")[5];
    // rust: p.zrot("head", rot_lerp(lie, hz, -PI * 5.0 / 12.0));
    // rust: add(p, "head", 1.5, 0.75, -0.5);
    // rust: p.xrot("right_front_leg", -PI / 4.0);
    // rust: add(p, "right_front_leg", 3.5, -0.5, 0.0);
    // rust: p.xrot("left_front_leg", -PI / 2.0);
    // rust: add(p, "left_front_leg", 1.5, -1.0, -2.0);
    // rust: p.xrot("right_hind_leg", PI * 2.0 / 9.0);
    // rust: p.yrot("right_hind_leg", PI / 9.0);
    // rust: p.zrot("right_hind_leg", -PI / 9.0);
    // rust: add(p, "right_hind_leg", 2.5, -0.25, 0.5);
    // rust: add(p, "left_hind_leg", 1.5, 0.0, -1.0);
    // rust: let t = p.get("tail1");
    // rust: let (tx, ty, tz) = (t[3], t[4], t[5]);
    // rust: p.xrot("tail1", tx + rot_lerp(lie_tail, tx, -PI / 6.0));
    // rust: p.yrot("tail1", ty + rot_lerp(lie_tail, ty, 0.0));
    // rust: p.zrot("tail1", tz + rot_lerp(lie_tail, tz, -PI / 18.0));
    // rust: add(p, "tail1", 1.0, 0.5, -0.25);
    // rust: } else if lie > 0.0 {
    // rust: let (hz, hy) = (p.get("head")[5], p.get("head")[4]);
    // rust: p.zrot("head", rot_lerp(lie, hz, -1.270_796_3));
    // rust: p.yrot("head", rot_lerp(lie, hy, 1.270_796_3));
    // rust: p.xrot("left_front_leg", -1.270_796_3);
    // rust: p.xrot("right_front_leg", -0.470_796_35);
    // rust: p.zrot("right_front_leg", -0.2);
    // rust: add(p, "right_front_leg", age, 0.0, 0.0);
    // rust: p.xrot("left_hind_leg", -0.4);
    // rust: p.xrot("right_hind_leg", 0.5);
    // rust: p.zrot("right_hind_leg", -0.5);
    // rust: add(p, "right_hind_leg", 0.8 * age, 2.0 * age, 0.0);
    // rust: let (t1, t2) = (p.get("tail1")[3], p.get("tail2")[3]);
    // rust: p.xrot("tail1", rot_lerp(lie_tail, t1, 0.8));
    // rust: p.xrot("tail2", rot_lerp(lie_tail, t2, -0.4));
}
    // rust: let relax = st.relax_one;
    // rust: if relax > 0.0 {
    // rust: let hx = p.get("head")[3];
    // rust: p.xrot("head", rot_lerp(relax, hx, -0.581_776_44));
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::{Damage, sensor_scan_tests::kind};
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

    /// Wolf.tick: a shake starting posts ENTITY_ACTION with its sound, on the server only.
pub fn a_shake_posts_entity_action_on_the_server() void {
}
    // rust: let shaking_wolf = || {
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:wolf".into();
    // rust: k.species = Species::Wolf;
    // rust: let mut m = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: m.extra.counter2 = 1;
    // rust: m
}
    // rust: let action = |events: &[MobEvent]| {
    // rust: events.iter().any(|e| {
    // rust: matches!(e, MobEvent::GameEvent { event, source: 1, .. }
    // rust: if *event == "minecraft:entity_action")
    // rust: })
}
    // rust: let mut events = Vec::new();
    // rust: shake_tick(&mut shaking_wolf(), false, true, &mut events);
    // rust: assert!(action(&events), "the server's wolf posts entity_action");
    // rust: let mut events = Vec::new();
    // rust: shake_tick(&mut shaking_wolf(), false, false, &mut events);
    // rust: assert!(!action(&events), "a client's copy posts nothing");
}

pub const WHITE: u32 = 0xFFFF_FFFF;

pub fn cat() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:cat".into();
    // rust: k.species = Species::Cat;
    // rust: Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0)
}
pub fn a_cat_lying_near_a_sleeper_lies_on_top_of_them() void {
}
//         use horizon_core::geometry::Aabb;
    // rust: let sleeper = Aabb::new(Vec3::new(2.4, 64.0, 0.4), Vec3::new(2.6, 64.2, 0.6));
    // rust: let far = Aabb::new(Vec3::new(5.4, 64.0, 0.4), Vec3::new(5.6, 64.2, 0.6));
    // rust: let mut m = cat();
    // rust: m.anim.v[LIE] = 1.0;
    // rust: m.extra.flag = true;
    // rust: cat_lying_on_sleeper(&mut m, &[far]);
    // rust: assert!(!m.extra.on_sleeper);
    // rust: cat_lying_on_sleeper(&mut m, &[far, sleeper]);
    // rust: assert!(m.extra.on_sleeper);
    // rust: let on_top = cat_rotations(&m, 1.0);
        // The extra `translate(0.15 * lie, 0, 0)` after the roll.
    // rust: m.extra.on_sleeper = false;
    // rust: let plain = cat_rotations(&m, 1.0);
    // rust: assert_ne!(on_top, plain);
    // rust: assert!((on_top.w_axis.y - plain.w_axis.y - 0.15).abs() < 1.0e-4);
        // Not lying: nothing to lie on.
    // rust: m.extra.flag = false;
    // rust: cat_lying_on_sleeper(&mut m, &[sleeper]);
    // rust: assert!(!m.extra.on_sleeper);
}
pub fn wolf() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:wolf".into();
    // rust: k.species = Species::Wolf;
    // rust: k.width = 0.6;
    // rust: k.height = 0.85;
    // rust: let mut m = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: m.on_ground = true;
    // rust: m
}
    /// `Wolf.die`: the wet flag, the shake counter and both shake animations
    /// are cleared before any loot is rolled. The death runs
    /// `drops::death_state` first, so the reset has to be asked there, not
    /// only exist.
pub fn a_wolf_that_dies_mid_shake_is_dry_and_still() void {
}
    // rust: let mut m = wolf();
        // Soaked, and shaking it off: the tick sets the wet flag and entity
        // event 8 starts the shake, which counts up 0.05 a tick.
    // rust: m.extra.flag2 = true;
    // rust: entity_event(&mut m, 8);
    // rust: m.anim.v[SHAKE] = 0.9;
    // rust: m.anim.vo[SHAKE] = 0.85;
    // rust: crate::mobs::drops::death_state(&mut m);
    // rust: assert!(!m.extra.flag2, "a dead wolf is not wet");
    // rust: assert_eq!(m.extra.counter2, 0, "a dead wolf is not shaking");
    // rust: assert_eq!(m.anim.v[SHAKE], 0.0, "shakeAnim");
    // rust: assert_eq!(m.anim.vo[SHAKE], 0.0, "shakeAnimO");
}
pub fn entity_events(events: *[MobEvent]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::EntityEvent { event, .. } => Some(*event),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}

    /// A wolf of a server (the default single player's server thread, a LAN
    /// guest): `Wolf.tick` makes it wet in water on the client too, which
    /// `getWetShade` darkens; entity event 8 starts the shake, which the
    /// client runs to the end, splashing, and then the wolf is dry (#2885).
pub fn a_wolf_of_a_server_darkens_in_water_and_shakes_dry_on_its_event() void {
}
    // rust: let mut m = wolf();
    // rust: let mut events = Vec::new();
    // rust: m.fluids.in_water = true;
    // rust: client_tick(&mut m, false, &mut events);
        // 0.75 of the colour: 191.
    // rust: assert_eq!(tint(&m, 1.0), 0xFFBF_BFBF, "wet in water");
    // rust: m.fluids.in_water = false;
    // rust: client_tick(&mut m, false, &mut events);
    // rust: assert_eq!(tint(&m, 1.0), 0xFFBF_BFBF, "still wet before it shakes");
    // rust: assert_eq!(m.anim.v[SHAKE], 0.0);
        // Rain wets it as well.
    // rust: let mut dry = wolf();
    // rust: client_tick(&mut dry, true, &mut events);
    // rust: assert_ne!(tint(&dry, 1.0), WHITE, "wet in the rain");

    // rust: crate::mobs::sync::entity_event(&mut m, 8);
    // rust: let mut ticks = 0;
    // rust: while m.extra.flag2 && ticks < 100 {
    // rust: client_tick(&mut m, false, &mut events);
    // rust: ticks += 1;
    // rust: if ticks == 1 {
    // rust: assert!((m.anim.v[SHAKE] - 0.05).abs() < 1e-6);
    // rust: assert_eq!(m.anim.vo[SHAKE], 0.0);
}
}
        // shakeAnimO reaches 2 on the 41st tick.
    // rust: assert!((41..=42).contains(&ticks), "shook for {ticks} ticks");
    // rust: assert_eq!(tint(&m, 1.0), WHITE, "dry after the shake");
    // rust: assert_eq!((m.extra.counter2, m.anim.v[SHAKE]), (0, 0.0));
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::ParticleAt { kind: "splash", .. })),
    // rust: "the client draws the splashes"
    // rust: );
    // rust: assert!(
    // rust: !events.iter().any(|e| matches!(e, MobEvent::Sound(..))),
    // rust: "the shake sound is the server's"
    // rust: );
}

    /// `Wolf.handleEntityEvent(56)`: back in the water, the server cancels
    /// the shake; the wolf stays wet. A client does not cancel on its own.
pub fn a_wolf_of_a_server_stops_shaking_on_its_cancel_event() void {
}
    // rust: let mut m = wolf();
    // rust: let mut events = Vec::new();
    // rust: m.fluids.in_water = true;
    // rust: client_tick(&mut m, false, &mut events);
    // rust: m.fluids.in_water = false;
    // rust: crate::mobs::sync::entity_event(&mut m, 8);
    // rust: for _ in 0..10 {
    // rust: client_tick(&mut m, false, &mut events);
}
    // rust: assert!(m.anim.v[SHAKE] > 0.4);
    // rust: m.fluids.in_water = true;
    // rust: client_tick(&mut m, false, &mut events);
    // rust: assert!(m.extra.counter2 > 0, "only the server cancels");
    // rust: crate::mobs::sync::entity_event(&mut m, 56);
    // rust: assert_eq!((m.extra.counter2, m.anim.v[SHAKE]), (0, 0.0));
    // rust: assert_ne!(tint(&m, 1.0), WHITE, "still wet");
}

    /// `Wolf.aiStep` broadcasts entity event 8 when a wet wolf standing on
    /// the ground starts shaking, and `Wolf.tick` event 56 when water or rain
    /// cancels it: the clients' only way to know.
pub fn a_server_tells_the_clients_when_a_wolf_shakes() void {
}
    // rust: let mut m = wolf();
    // rust: let mut events = Vec::new();
    // rust: server_shake(&mut m, true, &mut events);
    // rust: assert!(m.extra.flag2);
        // Out of the water: it starts and makes its sound in the same tick.
    // rust: server_shake(&mut m, false, &mut events);
    // rust: assert_eq!(entity_events(&events), [8]);
    // rust: assert!(m.extra.counter2 > 0);
    // rust: assert!((m.anim.v[SHAKE] - 0.05).abs() < 1e-6);
    // rust: assert!(
    // rust: events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::Sound("entity.wolf.shake", ..)))
    // rust: );
    // rust: server_shake(&mut m, true, &mut events);
    // rust: assert_eq!(entity_events(&events), [8, 56]);
    // rust: assert_eq!((m.extra.counter2, m.anim.v[SHAKE]), (0, 0.0));
    // rust: assert!(m.extra.flag2, "still wet");
}

    /// A tame mob of a species, told to sit.
pub fn sitting(species: Species, name: []const u8) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = name.into();
    // rust: k.species = species;
    // rust: k.max_health = 20.0;
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.0, 64.0, 0.0), 0.0);
    // rust: m.extra.tame = true;
    // rust: m.extra.sitting = true;
    // rust: m
}

pub fn a_hit_stands_a_sitting_wolf_or_parrot_up() void {
}
        // Wolf.hurtServer and Parrot.hurtServer call setOrderedToSit(false)
        // before LivingEntity.hurtServer.
    // rust: for (species, name) in [
    // rust: (Species::Wolf, "minecraft:wolf"),
    // rust: (Species::Parrot, "minecraft:parrot"),
    // rust: ] {
    // rust: let mut m = sitting(species, name);
    // rust: assert!(m.damage(1.0, Damage::player([0.0, 64.0, 1.0])));
    // rust: assert!(!m.extra.sitting, "{name} still sits after a hit");
            // A weaker hit inside the hurt frames deals nothing, but it
            // reached hurtServer, so it still stands the mob up.
    // rust: m.extra.sitting = true;
    // rust: assert!(!m.damage(0.5, Damage::player([0.0, 64.0, 1.0])));
    // rust: assert!(!m.extra.sitting, "{name} still sits after a blocked hit");
}
}

pub fn a_hit_leaves_a_sitting_cat_sitting() void {
}
        // Cat has no hurtServer override: a hit does not stand it up.
    // rust: let mut m = sitting(Species::Cat, "minecraft:cat");
    // rust: assert!(m.damage(1.0, Damage::player([0.0, 64.0, 1.0])));
    // rust: assert!(m.extra.sitting);
}

    /// `Cat.canMate` and `Wolf.canMate`: the seeker only has to be tamed, so a
    /// mob ordered to sit still goes looking for a mate. Only a wolf's
    /// *partner* is refused while it sits (`wolf.isInSittingPose()`), which is
    /// the one sitting check vanilla makes.
pub fn a_sitting_tame_mob_still_looks_for_a_mate() void {
}
//         use crate::mobs::goals::{Breed, Cx, Goal};
//         use crate::mobs::world::with_test_world;
    // rust: let named = |species, name: &str, id: u32, sat: bool| {
    // rust: let mut m = sitting(species, name);
    // rust: m.id = id;
    // rust: m.extra.in_love = 600;
    // rust: m.extra.sitting = sat;
    // rust: m
}
    // rust: for (species, name, seeker_sat, partner_sat, breeds) in [
            // A tamed cat pairs with a tamed cat, sitting or not.
    // rust: (Species::Cat, "minecraft:cat", true, true, true),
    // rust: (Species::Cat, "minecraft:cat", true, false, true),
            // A wolf pairs unless the wolf it would take is sitting.
    // rust: (Species::Wolf, "minecraft:wolf", true, false, true),
    // rust: (Species::Wolf, "minecraft:wolf", true, true, false),
    // rust: (Species::Wolf, "minecraft:wolf", false, true, false),
    // rust: ] {
    // rust: let mut seeker = named(species, name, 1, seeker_sat);
    // rust: let partner = named(species, name, 2, partner_sat);
    // rust: let seen = [partner.seen(None)];
    // rust: with_test_world(&seen, |w, _| {
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: let mut goal = Breed::new(1.0);
    // rust: assert_eq!(
    // rust: goal.can_use(&mut seeker, &mut cx),
    // rust: breeds,
    // rust: "{name}: seeker sits {seeker_sat}, partner sits {partner_sat}"
    // rust: );
    // rust: });
}
}
}

/// `NeutralMob.isAngryAtAllPlayers`: with the `universal_anger` game rule on, a
/// wolf still angry with no target left goes for any player; with the rule off
/// it holds none, and a creative player is never one (`isValidPlayerTarget`).
    // rust: mod universal_anger_tests {
//     use super::*;
//     use crate::mobs::world::{test_player, with_test_world};
//     use std::sync::Arc;

pub fn universal_anger_targets_a_player_the_wolf_was_never_angered_by() void {
}
        // (the `universal_anger` rule, the player is creative, whether the wolf
        // ends up with the player as its target).
    // rust: let cases = [
    // rust: (true, false, true),
    // rust: (false, false, false),
    // rust: (true, true, false),
    // rust: ];
    // rust: with_test_world(&[], |w, types| {
    // rust: for (universal_anger, creative, targets) in cases {
    // rust: let mut w = w.clone();
    // rust: let mut p = test_player(Vec3::new(2.5, 64.0, 0.5));
    // rust: p.creative = creative;
    // rust: w.player = Some(p);
    // rust: w.universal_anger = universal_anger;
    // rust: let kind = Arc::new(types.types["minecraft:wolf"].clone());
    // rust: let mut m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
                // `anger_end_time` still running, `angry_at` gone: angry, with
                // nobody left that it was angered by.
    // rust: m.extra.anger = 600;
    // rust: m.extra.angry_at = None;
    // rust: let mut goals = std::mem::take(&mut m.ai.targets);
    // rust: let mut events = Vec::new();
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: for _ in 0..200 {
    // rust: goals.tick(&mut m, &mut cx);
}
    // rust: m.ai.targets = goals;
    // rust: assert_eq!(
    // rust: m.ai.target == Some(Who::Player),
    // rust: targets,
    // rust: "universal_anger {universal_anger}, creative {creative}"
    // rust: );
}
    // rust: });
}
}
