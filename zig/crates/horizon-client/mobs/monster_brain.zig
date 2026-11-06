//! Transpiled from Horizon Rust crate
//! Module: horizon-client_monster_brain
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The brains of the breeze (`Breeze.BRAIN_PROVIDER`, `BreezeAi`) and the
//! creaking (`Creaking.BRAIN_PROVIDER`, `CreakingAi`), ported behaviour for
//! behaviour on the villager brain's memories (`villager_brain::Slot`):
//! sensors with vanilla's scan delays, the core, idle and fight activities,
//! and their behaviours started and ticked in `Brain.tick`'s order
//! (priority, then the activity's slot in its hash map, then insertion).
//!
//! Behaviour durations, `DoNothing` and the creaking's look ticker draw from
//! the level random; positions, sounds and jumps from the mob's own random;
//! `RunOne` shuffles with a random of its own (`ShufflingList.random`),
//! seeded when the brain is built.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species, Who,
    // rust: brain::{Timed, living_near},
    // rust: goals::Cx,
    // rust: path::Path,
    // rust: villager_brain::{NEVER, Slot, Tracker, Visible, WalkTarget, compute_path, reached},
}
// use crate::projectiles::{Projectile, ProjectileKind};
// use horizon_core::{
    // rust: geometry::{Vec3, trig},
    // rust: random::{LegacyRandom, RandomSource},
}

/// `Activity` (the ones these brains use).
pub const Act = enum {
    Core,
    Idle,
    Fight,
};
    // rust: impl Act {
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Act::Core => "core",
    // rust: Act::Idle => "idle",
    // rust: Act::Fight => "fight",
}
}
}

/// The memories either brain registers.
pub const Memories = struct {
    attack_target: Slot<Who>,
    attack_cooling_down: Slot<bool>,
    cant_reach_walk_target_since: Slot<i64>,
    /// `HURT_BY`: the damage (its game time).
    hurt_by: Slot<i64>,
    hurt_by_entity: Slot<Who>,
    look_target: Slot<Tracker>,
    mobs: Slot<std.ArrayList(Who)>,
    visible_mobs: Slot<Visible>,
    nearest_attackable: Slot<Who>,
    nearest_players: Slot<std.ArrayList(Who)>,
    nearest_visible_player: Slot<Who>,
    nearest_visible_targetable_player: Slot<Who>,
    nearest_visible_targetable_players: Slot<std.ArrayList(Who)>,
    path: Slot<Path>,
    walk_target: Slot<WalkTarget>,
    breeze_shoot: Slot<()>,
    breeze_shoot_charging: Slot<()>,
    breeze_shoot_recovering: Slot<()>,
    breeze_shoot_cooldown: Slot<()>,
    breeze_jump_cooldown: Slot<()>,
    breeze_jump_inhaling: Slot<()>,
    breeze_jump_target: Slot<[i32,
    breeze_leaving_water: Slot<()>,
};
    // rust: impl Memories {
    /// `Brain.forgetOutdatedMemories`.
pub fn tick(self: *Self) void {
}
    // rust: self.attack_target.tick();
    // rust: self.attack_cooling_down.tick();
    // rust: self.cant_reach_walk_target_since.tick();
    // rust: self.hurt_by.tick();
    // rust: self.hurt_by_entity.tick();
    // rust: self.look_target.tick();
    // rust: self.mobs.tick();
    // rust: self.visible_mobs.tick();
    // rust: self.nearest_attackable.tick();
    // rust: self.nearest_players.tick();
    // rust: self.nearest_visible_player.tick();
    // rust: self.nearest_visible_targetable_player.tick();
    // rust: self.nearest_visible_targetable_players.tick();
    // rust: self.path.tick();
    // rust: self.walk_target.tick();
    // rust: self.breeze_shoot.tick();
    // rust: self.breeze_shoot_charging.tick();
    // rust: self.breeze_shoot_recovering.tick();
    // rust: self.breeze_shoot_cooldown.tick();
    // rust: self.breeze_jump_cooldown.tick();
    // rust: self.breeze_jump_inhaling.tick();
    // rust: self.breeze_jump_target.tick();
    // rust: self.breeze_leaving_water.tick();
}
}

/// The sensors, in `BRAIN_PROVIDER` order (all scan every 20 ticks).
pub const Sensor = enum {
    NearestLiving,
    HurtBy,
    NearestPlayers,
    BreezeAttack,
};

/// A breeze's or creaking's brain.
pub const Brain = struct {
    mem: Memories,
    sensors: Vec<(Sensor,
    /// The active non-core activity (`CORE` is always active).
    activity: Act,
    default_activity: Act,
    list: std.ArrayList(Entry),
};
pub const Entry = struct {
    act: Act,
    b: B,
};

pub fn brain(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.brain.as_deref()
}
pub fn brain_mut(m: *mut Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.brain.as_deref_mut().expect("brain")
}
pub fn mem(m: *mut Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut brain_mut(m).mem
}
/// `CANT_REACH_WALK_TARGET_SINCE`, for `compute_path`.
pub fn cant_reach(m: *mut Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut mem(m).cant_reach_walk_target_since
}
pub fn mem_ref(m: *Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &brain(m).expect("brain").mem
}
/// Whether the species thinks with this brain.
pub fn has_brain(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(s, Species::Breeze | Species::Creaking)
}

/// `Brain.Provider.makeBrain`: the sensors' first scans are delayed by draws
/// from the mob's random; `RunOne` shuffles with `shuffle_seed`.
pub fn init(m: *mut Mob, shuffle_seed: i64) void {
}
    // rust: let breeze = m.species() == Species::Breeze;
    // rust: let kinds: &[Sensor] = if breeze {
    // rust: &[
    // rust: Sensor::NearestLiving,
    // rust: Sensor::HurtBy,
    // rust: Sensor::NearestPlayers,
    // rust: Sensor::BreezeAttack,
    // rust: ]
    // rust: } else {
    // rust: &[Sensor::NearestLiving, Sensor::NearestPlayers]
}
    // rust: let sensors = kinds
    // rust: .iter()
    // rust: .map(|&k| (k, i64::from(m.random.next_int_bound(20).unwrap_or(0))))
    // rust: .collect();
    // rust: let (list, default_activity) = if breeze {
    // rust: (breeze_packages(shuffle_seed), Act::Fight)
    // rust: } else {
    // rust: (creaking_packages(shuffle_seed), Act::Idle)
}
    // rust: m.extra.brain = Some(Box::new(Brain {
    // rust: mem: Memories::default(),
    // rust: sensors,
    // rust: activity: default_activity,
    // rust: default_activity,
    // rust: list,
    // rust: }));
}

/// What behaviours read and emit during a brain tick.
pub const Bx = struct {
    w: *'a MobWorld<'w>,
    lr: *'a mut LegacyRandom,
    events: *'a mut std.ArrayList(MobEvent),
    now: i64,
};

/// `Brain.tick`, then the species' `updateActivity`
/// (`Breeze.customServerAiStep`, `Creaking.customServerAiStep`).
pub fn tick(m: *mut Mob, w: *MobWorld, lr: *mut LegacyRandom, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if brain(m).is_none() {
    // rust: let seed = i64::from(m.id);
    // rust: init(m, seed);
}
    // rust: mem(m).tick();
    // rust: tick_sensors(m, w);
    // rust: let mut list = std::mem::take(&mut brain_mut(m).list);
    // rust: let mut cx = Bx {
    // rust: w,
    // rust: lr,
    // rust: events,
    // rust: now: w.game_time,
}
    // rust: for e in list.iter_mut() {
    // rust: let active = e.act == Act::Core || e.act == brain_mut(m).activity;
    // rust: if active && !e.b.running() {
    // rust: e.b.try_start(m, &mut cx);
}
}
    // rust: for e in list.iter_mut() {
    // rust: if e.b.running() {
    // rust: e.b.tick_or_stop(m, &mut cx);
}
}
    // rust: brain_mut(m).list = list;
    // rust: update_activity(m);
    // rust: sync_target(m);
}
/// `BreezeAi.updateActivity` and `CreakingAi.updateActivity`.
pub fn update_activity(m: *mut Mob) void {
}
    // rust: let frozen = m.species() == Species::Creaking && !super::creaking::can_move(m);
    // rust: let b = brain_mut(m);
    // rust: if frozen {
        // useDefaultActivity
    // rust: b.activity = b.default_activity;
    // rust: return;
}
    // rust: if fight_requirements(b) {
    // rust: b.activity = Act::Fight;
    // rust: } else {
    // rust: b.activity = Act::Idle;
}
}
pub fn fight_requirements(b: *Brain) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: b.mem.attack_target.present()
    // rust: && (b.default_activity != Act::Fight || !b.mem.walk_target.present())
}
/// `Mob.getTarget` is `getTargetFromBrain` for both species.
pub fn sync_target(m: *mut Mob) void {
}
    // rust: m.ai.target = mem_ref(m).attack_target.value();
}
/// Sets or erases the attack target (and the mob's view of it).
pub fn set_attack_target(m: *mut Mob, who: ?Who) void {
}
    // rust: if brain(m).is_none() {
    // rust: let seed = i64::from(m.id);
    // rust: init(m, seed);
}
    // rust: mem(m).attack_target.set_opt(who);
    // rust: m.ai.target = who;
}
/// The attack target the brain remembers.
pub fn attack_target(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: brain(m).and_then(|b| b.mem.attack_target.value())
}
/// `NEAREST_PLAYERS`.
pub fn nearest_players(m: *Mob) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: brain(m)
    // rust: .and_then(|b| b.mem.nearest_players.value())
    // rust: .unwrap_or_default()
}
/// `HURT_BY`'s damage source entity, if a living one.
pub fn hurt_by_entity(m: *Mob, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = brain(m)?.mem.hurt_by.value()?;
    // rust: let (d, at) = m.last_damage?;
    // rust: if at != t {
    // rust: return None;
}
    // rust: let who = d.attacker?;
    // rust: w.target_info(who).map(|_| who)
}

// ---- Sensors ------------------------------------------------------------

pub fn tick_sensors(m: *mut Mob, w: *MobWorld) void {
}
    // rust: for i in 0..brain_mut(m).sensors.len() {
    // rust: let (kind, fire) = {
    // rust: let s = &mut brain_mut(m).sensors[i];
    // rust: s.1 -= 1;
    // rust: if s.1 <= 0 {
    // rust: s.1 = 20;
    // rust: (s.0, true)
    // rust: } else {
    // rust: (s.0, false)
}
}
    // rust: if !fire {
    // rust: continue;
}
    // rust: match kind {
    // rust: Sensor::NearestLiving => sense_living(m, w),
    // rust: Sensor::HurtBy => sense_hurt(m, w),
    // rust: Sensor::NearestPlayers => sense_players(m, w),
    // rust: Sensor::BreezeAttack => {
    // rust: sense_living(m, w);
    // rust: sense_breeze_attack(m, w);
}
}
}
}
/// `NearestLivingEntitySensor`: everything alive within the follow range,
/// nearest first.
pub fn sense_living(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let list = living_near(m, w);
    // rust: let mm = mem(m);
    // rust: mm.mobs.set_list(list.clone());
    // rust: mm.visible_mobs.set(Visible {
    // rust: list,
    // rust: cache: Vec::new(),
    // rust: });
}
/// `HurtBySensor`: the last damage (forgotten 40 ticks after) and who did it.
pub fn sense_hurt(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let age = i64::from(m.age);
    // rust: let last = m
    // rust: .last_damage
    // rust: .as_ref()
    // rust: .filter(|(_, t)| age - t <= 40)
    // rust: .map(|(d, t)| (d.attacker, *t));
    // rust: let mm = mem(m);
    // rust: if let Some((by, t)) = last {
    // rust: mm.hurt_by.set(t);
    // rust: if let Some(by) = by {
    // rust: mm.hurt_by_entity.set(by);
}
    // rust: } else {
    // rust: mm.hurt_by.clear();
}
    // rust: if let Some(who) = mm.hurt_by_entity.value()
    // rust: && !w.target_info(who).is_some_and(|t| t.alive)
    // rust: {
    // rust: mm.hurt_by_entity.clear();
}
}
/// `Sensor.isEntityTargetable`: `TargetingConditions.forNonCombat()` within
/// the follow range, in sight.
pub fn targetable(m: *mut Mob, w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let range = m.attrs.follow_range;
    // rust: match who {
    // rust: Who::Player => m.can_see_player(w, range),
    // rust: Who::Mob(id) => {
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: s.alive && m.distance_sqr(s.position) <= range * range && m.sees(w, who)
}
}
}
/// `LivingEntity.canAttack` with the species' own rule (`Breeze.canAttack`:
/// players and iron golems only).
pub fn can_attack(m: *Mob, w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match who {
    // rust: Who::Player => w
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.alive && !p.creative && !p.spectator),
    // rust: Who::Mob(id) => {
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: s.alive
    // rust: && !s.playing_dead
    // rust: && (m.species() != Species::Breeze || s.species == Species::IronGolem)
}
}
}
/// `Sensor.isEntityAttackable`: `TargetingConditions.forCombat()` within the
/// follow range, in sight.
pub fn attackable(m: *mut Mob, w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // The current ATTACK_TARGET is tested with ignoreInvisibilityTesting.
    // rust: let current = mem_ref(m).attack_target.value() == Some(who);
    // rust: let range = m.attrs.follow_range;
    // rust: if !can_attack(m, w, who) {
    // rust: return false;
}
    // rust: match who {
    // rust: Who::Player if current => m.can_keep_target_player(w, range),
    // rust: Who::Player => m.can_target_player(w, range, true),
    // rust: Who::Mob(id) => {
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: m.distance_sqr(s.position) <= range * range && m.sees(w, who)
}
}
}
/// The visible-entities memory's line-of-sight test, cached per memory.
pub fn visible_test(m: *mut Mob, w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match mem_ref(m).visible_mobs.get() {
    // rust: Some(v) => {
    // rust: if let Some(&(_, r)) = v.cache.iter().find(|(k, _)| *k == who) {
    // rust: return r;
}
}
    // rust: None => return false,
}
    // rust: let r = targetable(m, w, who);
    // rust: if let Some(v) = mem(m).visible_mobs.get_mut() {
    // rust: v.cache.push((who, r));
}
    // rust: r
}
/// `NearestVisibleLivingEntities.findClosest`.
pub fn find_closest(m: *mut Mob, w: *MobWorld, filter: impl Fn(*Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let list = mem_ref(m).visible_mobs.get()?.list.clone();
    // rust: list.into_iter()
    // rust: .find(|&who| filter(m, who) && visible_test(m, w, who))
}
/// `NearestVisibleLivingEntities.contains(entity)`.
pub fn visible_contains(m: *mut Mob, w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let listed = mem_ref(m)
    // rust: .visible_mobs
    // rust: .get()
    // rust: .is_some_and(|v| v.list.contains(&who));
    // rust: listed && visible_test(m, w, who)
}
/// `PlayerSensor`.
pub fn sense_players(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let range = m.attrs.follow_range;
    // rust: let near = w
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| !p.spectator && m.distance_sqr(p.position) < range * range);
    // rust: let players: Vec<Who> = if near { vec![Who::Player] } else { vec![] };
    // rust: let visible: Vec<Who> = players
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&p| targetable(m, w, p))
    // rust: .collect();
    // rust: let attackable: Vec<Who> = visible
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&p| attackable(m, w, p))
    // rust: .collect();
    // rust: let mm = mem(m);
    // rust: mm.nearest_players.set_list(players);
    // rust: mm.nearest_visible_player.set_opt(visible.first().copied());
    // rust: mm.nearest_visible_targetable_players
    // rust: .set_list(attackable.clone());
    // rust: mm.nearest_visible_targetable_player
    // rust: .set_opt(attackable.first().copied());
}
/// `BreezeAttackEntitySensor`: the nearest living entity (not a creative or
/// spectator player) it may attack.
pub fn sense_breeze_attack(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let list = mem_ref(m).mobs.value().unwrap_or_default();
    // rust: let found = list.into_iter().find(|&who| {
    // rust: let shown = match who {
    // rust: Who::Player => w
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| !p.creative && !p.spectator),
    // rust: Who::Mob(_) => true,
}
    // rust: shown && attackable(m, w, who)
    // rust: });
    // rust: mem(m).nearest_attackable.set_opt(found);
}

// ---- Behaviours ---------------------------------------------------------

/// `StartAttacking`'s target finders.
pub const Finder = enum {
    /// The breeze's `NEAREST_ATTACKABLE`.
    NearestAttackable,
    /// The breeze's `HURT_BY` source, if living.
    HurtBy,
    /// The creaking's `NEAREST_VISIBLE_ATTACKABLE_PLAYER`, while active.
    ActiveCreaking,
};

/// The behaviours of both brains.
pub const B = enum {
    Swim {,
    t: Timed,
    creaking: bool,
    // rust: },
    LookAtTargetSink(Timed),
    /// `MoveToTargetSink`, and the breeze's `SlideToTargetSink`.
    MoveToTargetSink {,
    t: Timed,
    cooldown: i32,
    path: Option<Path>,
    last_target: Option<[i32; 3]>,
    speed: f32,
    slide: bool,
    // rust: },
    StartAttacking(bool, Finder),
    /// `StopAttackingIfTargetInvalid`: the breeze's while the target was
    /// attackable within the last 100 ticks (`positives_left`), the
    /// creaking's while a visible attackable player.
    StopAttacking {,
    running: bool,
    breeze: bool,
    positives_left: i32,
    // rust: },
    RunOne(Box<RunOne>),
    DoNothing(Timed),
    RandomStroll(bool, f32),
    SetEntityLookTargetSometimes {,
    running: bool,
    until_next: i32,
    // rust: },
    SetWalkTargetFromLookTarget(bool),
    SetWalkTargetFromAttackTarget(bool),
    MeleeAttack(bool),
    Shoot(Timed),
    LongJump(Timed),
    ShootWhenStuck(Timed),
    Slide(Timed),
};

/// `RunOne`: shuffled by weight, the first that starts runs.
pub const RunOne = struct {
    running: bool,
    random: LegacyRandom,
    kids: Vec<(B,
};
    // rust: impl RunOne {
pub fn try_start(self: *Self, m: *mut Mob, cx: *mut Bx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.running = true;
        // ShufflingList.shuffle: a fresh weight for each entry in the current
        // order, then a stable sort.
    // rust: for k in &mut self.kids {
    // rust: let r = self.random.next_float();
    // rust: k.2 = -horizon_core::jmath::pow(f64::from(r), f64::from(1.0_f32 / k.1 as f32));
}
    // rust: self.kids.sort_by(|a, b| a.2.total_cmp(&b.2));
    // rust: for k in &mut self.kids {
    // rust: if !k.0.running() && k.0.try_start(m, cx) {
    // rust: break;
}
}
    // rust: true
}
pub fn tick_or_stop(self: *Self, m: *mut Mob, cx: *mut Bx) void {
}
    // rust: for k in &mut self.kids {
    // rust: if k.0.running() {
    // rust: k.0.tick_or_stop(m, cx);
}
}
    // rust: if !self.kids.iter().any(|k| k.0.running()) {
    // rust: self.do_stop(m, cx);
}
}
pub fn do_stop(self: *Self, m: *mut Mob, cx: *mut Bx) void {
}
    // rust: self.running = false;
    // rust: for k in &mut self.kids {
    // rust: if k.0.running() {
    // rust: k.0.do_stop(m, cx);
}
}
}
}

    // rust: impl B {
pub fn running(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: B::Swim { t, .. }
    // rust: | B::LookAtTargetSink(t)
    // rust: | B::MoveToTargetSink { t, .. }
    // rust: | B::DoNothing(t)
    // rust: | B::Shoot(t)
    // rust: | B::LongJump(t)
    // rust: | B::ShootWhenStuck(t)
    // rust: | B::Slide(t) => t.running,
    // rust: B::StartAttacking(r, _)
    // rust: | B::StopAttacking { running: r, .. }
    // rust: | B::RandomStroll(r, _)
    // rust: | B::SetEntityLookTargetSometimes { running: r, .. }
    // rust: | B::SetWalkTargetFromLookTarget(r)
    // rust: | B::SetWalkTargetFromAttackTarget(r)
    // rust: | B::MeleeAttack(r) => *r,
    // rust: B::RunOne(g) => g.running,
}
}

pub fn try_start(self: *Self, m: *mut Mob, cx: *mut Bx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: B::RunOne(g) => g.try_start(m, cx),
    // rust: B::Swim { t, creaking } => {
    // rust: if *creaking && !super::creaking::can_move(m) || !swim_condition(m) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::LookAtTargetSink(t) => {
    // rust: if !mem(m).look_target.present() {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::MoveToTargetSink {
    // rust: t,
    // rust: cooldown,
    // rust: path,
    // rust: last_target,
    // rust: speed,
    // rust: slide,
    // rust: } => {
    // rust: let mm = mem(m);
    // rust: if mm.path.present() || !mm.walk_target.present() {
    // rust: return false;
}
                // checkExtraStartConditions
    // rust: if *cooldown > 0 {
    // rust: *cooldown -= 1;
    // rust: return false;
}
    // rust: let walk = mm.walk_target.value().unwrap();
    // rust: let reached = reached(m, cx.w, &walk);
    // rust: if !reached && compute_path(m, cx.w, cx.now, &walk, path, speed, cant_reach) {
    // rust: *last_target = walk.target.block(cx.w);
    // rust: t.begin(cx.lr, cx.now);
                    // start
    // rust: mem(m).path.set_opt(path.clone());
    // rust: m.nav_move_to_path(cx.w, path.clone(), f64::from(*speed));
    // rust: if *slide {
                        // SlideToTargetSink.start
    // rust: let at = m.center();
    // rust: cx.events
    // rust: .push(MobEvent::Sound("entity.breeze.slide", at, 1.0, 1.0));
    // rust: super::breeze::set_pose(m, super::breeze::SLIDING);
}
    // rust: return true;
}
    // rust: let mm = mem(m);
    // rust: mm.walk_target.clear();
    // rust: if reached {
    // rust: mm.cant_reach_walk_target_since.clear();
}
    // rust: false
}
    // rust: B::StartAttacking(running, finder) => {
    // rust: if mem(m).attack_target.present() {
    // rust: return false;
}
    // rust: let target = match finder {
    // rust: Finder::NearestAttackable => mem(m).nearest_attackable.value(),
    // rust: Finder::HurtBy => hurt_by_entity(m, cx.w),
    // rust: Finder::ActiveCreaking => {
    // rust: if !super::creaking::is_active(m) {
    // rust: return false;
}
    // rust: mem(m).nearest_visible_targetable_player.value()
}
}
    // rust: let Some(target) = target else { return false };
    // rust: if !can_attack(m, cx.w, target) {
    // rust: return false;
}
    // rust: set_attack_target(m, Some(target));
    // rust: mem(m).cant_reach_walk_target_since.clear();
    // rust: *running = true;
    // rust: true
}
    // rust: B::StopAttacking {
    // rust: running,
    // rust: breeze,
    // rust: positives_left,
    // rust: } => {
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return false;
}
    // rust: let alive = cx.w.target_info(target).is_some_and(|t| t.alive);
    // rust: let tired = mem(m)
    // rust: .cant_reach_walk_target_since
    // rust: .value()
    // rust: .is_some_and(|since| cx.now - since > 200);
    // rust: let stop_when = if *breeze {
                    // Sensor.wasEntityAttackableLastNTicks(100).negate()
    // rust: if attackable(m, cx.w, target) {
    // rust: *positives_left = 100;
    // rust: false
    // rust: } else {
    // rust: *positives_left -= 1;
    // rust: *positives_left < 0
}
    // rust: } else {
                    // CreakingAi.isAttackTargetStillReachable
    // rust: let reachable = target == Who::Player
    // rust: && mem(m)
    // rust: .nearest_visible_targetable_players
    // rust: .get()
    // rust: .is_some_and(|l| l.contains(&Who::Player));
    // rust: !reachable
}
    // rust: if !can_attack(m, cx.w, target) || tired || !alive || stop_when {
    // rust: set_attack_target(m, None);
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::DoNothing(t) => {
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::RandomStroll(running, speed) => {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let pos = m.land_random_pos(cx.w, 10, 7);
    // rust: mem(m)
    // rust: .walk_target
    // rust: .set_opt(pos.map(|p| WalkTarget::point(p, *speed, 0)));
    // rust: *running = true;
    // rust: true
}
    // rust: B::SetEntityLookTargetSometimes {
    // rust: running,
    // rust: until_next,
    // rust: } => {
    // rust: let mm = mem(m);
    // rust: if mm.look_target.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let found = find_closest(m, w, |m, who| {
    // rust: w.target_info(who)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) <= 64.0)
    // rust: });
    // rust: let Some(t) = found else { return false };
                // Ticker.tickDownAndCheck with UniformInt.of(30, 60).
    // rust: if *until_next == 0 {
    // rust: *until_next = 30 + cx.lr.next_int_bound(31).unwrap_or(0) - 1;
    // rust: return false;
}
    // rust: *until_next -= 1;
    // rust: if *until_next != 0 {
    // rust: return false;
}
    // rust: mem(m).look_target.set(Tracker::Entity(t, true));
    // rust: *running = true;
    // rust: true
}
    // rust: B::SetWalkTargetFromLookTarget(running) => {
    // rust: let mm = mem(m);
    // rust: if mm.walk_target.present() {
    // rust: return false;
}
    // rust: let Some(look) = mm.look_target.value() else {
    // rust: return false;
}
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: look,
    // rust: speed: 0.3,
    // rust: close: 3,
    // rust: });
    // rust: *running = true;
    // rust: true
}
    // rust: B::SetWalkTargetFromAttackTarget(running) => {
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let seen = mem_ref(m).visible_mobs.present() && visible_contains(m, w, target);
    // rust: if seen && within_attack_range(m, w, target) {
    // rust: mem(m).walk_target.clear();
    // rust: } else {
    // rust: let mm = mem(m);
    // rust: mm.look_target.set(Tracker::Entity(target, true));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity(target, false),
    // rust: speed: 1.0,
    // rust: close: 0,
    // rust: });
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::MeleeAttack(running) => {
    // rust: let mm = mem(m);
    // rust: let Some(target) = mm.attack_target.value() else {
    // rust: return false;
}
    // rust: if mm.attack_cooling_down.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let in_reach = w
    // rust: .target_info(target)
    // rust: .is_some_and(|t| m.within_melee_range(&t));
    // rust: if !super::creaking::can_move(m) || !in_reach || !visible_contains(m, w, target) {
    // rust: return false;
}
    // rust: mem(m).look_target.set(Tracker::Entity(target, true));
    // rust: m.swing();
    // rust: let mut gcx = Cx {
    // rust: w,
    // rust: lr: cx.lr,
    // rust: events: cx.events,
}
    // rust: super::ai::do_hurt_target(m, target, &mut gcx);
    // rust: mem(m).attack_cooling_down.set_ttl(true, 40);
    // rust: *running = true;
    // rust: true
}
    // rust: B::Shoot(t) => {
    // rust: let mm = mem(m);
    // rust: if !mm.attack_target.present()
    // rust: || mm.breeze_shoot_cooldown.present()
    // rust: || mm.breeze_shoot_charging.present()
    // rust: || mm.breeze_shoot_recovering.present()
    // rust: || !mm.breeze_shoot.present()
    // rust: || mm.walk_target.present()
    // rust: || mm.breeze_jump_target.present()
    // rust: {
    // rust: return false;
}
                // checkExtraStartConditions
    // rust: if super::breeze::pose(m) != super::breeze::STANDING {
    // rust: return false;
}
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return false;
}
    // rust: let within =
    // rust: cx.w.target_info(target)
    // rust: .is_some_and(|t| m.position.distance_squared(t.position) < 256.0);
    // rust: if !within {
    // rust: mem(m).breeze_shoot.clear();
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
                // start
    // rust: super::breeze::set_pose(m, super::breeze::SHOOTING);
    // rust: mem(m).breeze_shoot_charging.set_ttl((), 15);
    // rust: breeze_sound(m, cx, "entity.breeze.inhale", 1.0);
    // rust: true
}
    // rust: B::LongJump(t) => {
    // rust: let mm = mem(m);
    // rust: if !mm.attack_target.present()
    // rust: || mm.breeze_jump_cooldown.present()
    // rust: || mm.breeze_shoot.present()
    // rust: || mm.walk_target.present()
    // rust: {
    // rust: return false;
}
    // rust: if !long_jump_can_run(m, cx) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
                // start
    // rust: if !mem(m).breeze_jump_inhaling.present() {
    // rust: mem(m).breeze_jump_inhaling.set_ttl((), 10);
}
    // rust: super::breeze::set_pose(m, super::breeze::INHALING);
                // level.playSound(null, breeze, BREEZE_CHARGE, HOSTILE, 1, 1)
    // rust: cx.events.push(MobEvent::entity_sound(
    // rust: m,
    // rust: "entity.breeze.charge",
    // rust: 5,
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
    // rust: if let Some(p) = mem(m).breeze_jump_target.value() {
    // rust: look_at_eyes(
    // rust: m,
    // rust: [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ],
    // rust: );
}
    // rust: true
}
    // rust: B::ShootWhenStuck(t) => {
    // rust: let mm = mem(m);
    // rust: if !mm.attack_target.present()
    // rust: || mm.breeze_jump_inhaling.present()
    // rust: || mm.breeze_jump_target.present()
    // rust: || mm.walk_target.present()
    // rust: || mm.breeze_shoot.present()
    // rust: {
    // rust: return false;
}
    // rust: let stuck = m.extra.mount.is_some()
    // rust: || m.fluids.in_water
    // rust: || m.has_effect("minecraft:levitation");
    // rust: if !stuck {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: mem(m).breeze_shoot.set_ttl((), 60);
    // rust: true
}
    // rust: B::Slide(t) => {
    // rust: let mm = mem(m);
    // rust: if !mm.attack_target.present()
    // rust: || mm.walk_target.present()
    // rust: || mm.breeze_jump_cooldown.present()
    // rust: || mm.breeze_shoot.present()
    // rust: {
    // rust: return false;
}
    // rust: if !m.on_ground
    // rust: || m.fluids.in_water
    // rust: || super::breeze::pose(m) != super::breeze::STANDING
    // rust: {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: slide_start(m, cx);
    // rust: true
}
}
}

pub fn tick_or_stop(self: *Self, m: *mut Mob, cx: *mut Bx) void {
}
    // rust: let now = cx.now;
    // rust: match self {
    // rust: B::RunOne(g) => g.tick_or_stop(m, cx),
            // OneShots stop in the tick they started.
    // rust: B::StartAttacking(r, _)
    // rust: | B::StopAttacking { running: r, .. }
    // rust: | B::RandomStroll(r, _)
    // rust: | B::SetEntityLookTargetSometimes { running: r, .. }
    // rust: | B::SetWalkTargetFromLookTarget(r)
    // rust: | B::SetWalkTargetFromAttackTarget(r)
    // rust: | B::MeleeAttack(r) => *r = false,
    // rust: B::Swim { t, .. } => {
    // rust: if now > t.end || !swim_condition(m) {
    // rust: self.do_stop(m, cx);
    // rust: } else if m.random.next_float() < 0.8 {
    // rust: m.ai.jump = true;
}
}
    // rust: B::LookAtTargetSink(t) => {
    // rust: let visible = match mem(m).look_target.value() {
    // rust: Some(look) => tracker_visible(m, cx.w, look),
    // rust: None => false,
}
    // rust: if now > t.end || !visible {
    // rust: self.do_stop(m, cx);
    // rust: } else if let Some(at) = mem(m).look_target.value().and_then(|l| l.position(cx.w)) {
    // rust: m.look_at(at);
}
}
    // rust: B::MoveToTargetSink {
    // rust: t,
    // rust: path,
    // rust: last_target,
    // rust: speed,
    // rust: ..
    // rust: } => {
    // rust: let still = path.is_some()
    // rust: && last_target.is_some()
    // rust: && mem(m)
    // rust: .walk_target
    // rust: .value()
    // rust: .is_some_and(|walk| !m.ai.nav.is_done() && !reached(m, cx.w, &walk));
    // rust: if now > t.end || !still {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: let new_path = m.ai.nav.path.clone();
    // rust: if !same_path(path.as_ref(), new_path.as_ref()) {
    // rust: *path = new_path.clone();
    // rust: mem(m).path.set_opt(new_path.clone());
}
    // rust: if new_path.is_some()
    // rust: && let Some(last) = *last_target
    // rust: && let Some(walk) = mem(m).walk_target.value()
    // rust: && let Some(now_target) = walk.target.block(cx.w)
    // rust: {
    // rust: let d = manhattan_sq(now_target, last);
    // rust: if d > 4 && compute_path(m, cx.w, cx.now, &walk, path, speed, cant_reach) {
    // rust: *last_target = Some(now_target);
    // rust: mem(m).path.set_opt(path.clone());
    // rust: m.nav_move_to_path(cx.w, path.clone(), f64::from(*speed));
}
}
}
    // rust: B::DoNothing(t) => {
    // rust: if now > t.end {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::Shoot(t) => {
    // rust: let mm = mem(m);
    // rust: if now > t.end || !mm.attack_target.present() || !mm.breeze_shoot.present() {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: shoot_tick(m, cx);
}
    // rust: B::LongJump(t) => {
    // rust: let still = super::breeze::pose(m) != super::breeze::STANDING
    // rust: && !mem(m).breeze_jump_cooldown.present();
    // rust: if now > t.end || !still {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: long_jump_tick(m, cx);
}
            // canStillUse is false: stops at once.
    // rust: B::ShootWhenStuck(_) | B::Slide(_) => self.do_stop(m, cx),
}
}

pub fn do_stop(self: *Self, m: *mut Mob, cx: *mut Bx) void {
}
    // rust: match self {
    // rust: B::RunOne(g) => g.do_stop(m, cx),
    // rust: B::StartAttacking(r, _)
    // rust: | B::StopAttacking { running: r, .. }
    // rust: | B::RandomStroll(r, _)
    // rust: | B::SetEntityLookTargetSometimes { running: r, .. }
    // rust: | B::SetWalkTargetFromLookTarget(r)
    // rust: | B::SetWalkTargetFromAttackTarget(r)
    // rust: | B::MeleeAttack(r) => *r = false,
    // rust: B::Swim { t, .. } | B::DoNothing(t) | B::ShootWhenStuck(t) | B::Slide(t) => {
    // rust: t.running = false
}
    // rust: B::LookAtTargetSink(t) => {
    // rust: t.running = false;
    // rust: mem(m).look_target.clear();
}
    // rust: B::MoveToTargetSink {
    // rust: t,
    // rust: cooldown,
    // rust: path,
    // rust: slide,
    // rust: ..
    // rust: } => {
    // rust: t.running = false;
    // rust: if let Some(walk) = mem(m).walk_target.value()
    // rust: && !reached(m, cx.w, &walk)
    // rust: && m.ai.nav.stuck
    // rust: {
    // rust: *cooldown = cx.lr.next_int_bound(40).unwrap_or(0);
}
    // rust: m.nav_stop();
    // rust: let mm = mem(m);
    // rust: mm.walk_target.clear();
    // rust: mm.path.clear();
    // rust: *path = None;
    // rust: if *slide {
                    // SlideToTargetSink.stop
    // rust: super::breeze::set_pose(m, super::breeze::STANDING);
    // rust: if mem(m).attack_target.present() {
    // rust: mem(m).breeze_shoot.set_ttl((), 60);
}
}
}
    // rust: B::Shoot(t) => {
    // rust: t.running = false;
    // rust: if super::breeze::pose(m) == super::breeze::SHOOTING {
    // rust: super::breeze::set_pose(m, super::breeze::STANDING);
}
    // rust: let mm = mem(m);
    // rust: mm.breeze_shoot_cooldown.set_ttl((), 10);
    // rust: mm.breeze_shoot.clear();
}
    // rust: B::LongJump(t) => {
    // rust: t.running = false;
    // rust: let pose = super::breeze::pose(m);
    // rust: if pose == super::breeze::LONG_JUMPING || pose == super::breeze::INHALING {
    // rust: super::breeze::set_pose(m, super::breeze::STANDING);
}
    // rust: let mm = mem(m);
    // rust: mm.breeze_jump_target.clear();
    // rust: mm.breeze_jump_inhaling.clear();
    // rust: mm.breeze_leaving_water.clear();
}
}
}
}

pub fn manhattan_sq(a: [i32; 3], b: [i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = [
    // rust: i64::from(a[0] - b[0]),
    // rust: i64::from(a[1] - b[1]),
    // rust: i64::from(a[2] - b[2]),
    // rust: ];
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2]
}
pub fn same_path(a: ?*Path, b: ?*Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (a, b) {
    // rust: (None, None) => true,
    // rust: (Some(a), Some(b)) => a.nodes == b.nodes && a.target == b.target,
    // rust: _ => false,
}
}
pub fn block_of(p: Vec3) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32]
}
/// `Swim`: deeper than the jump threshold, or in lava.
pub fn swim_condition(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.fluids.water > m.fluid_jump_threshold() || m.fluids.in_lava
}
/// `PositionTracker.isVisibleBy`.
pub fn tracker_visible(m: *mut Mob, w: *MobWorld, t: Tracker) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match t {
    // rust: Tracker::Entity(who, _) => {
    // rust: w.target_info(who).is_some_and(|i| i.alive) && visible_contains(m, w, who)
}
    // rust: _ => true,
}
}
/// `BehaviorUtils.isWithinAttackRange(body, target, 1)` for a mob without a
/// ranged weapon: `Mob.isWithinMeleeAttackRange`.
pub fn within_attack_range(m: *Mob, w: *MobWorld, target: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.target_info(target)
    // rust: .is_some_and(|t| m.within_melee_range(&t))
}

// ---- The breeze's behaviours --------------------------------------------

/// `Mob.playSound(sound, volume, 1)`: at the mob, no pitch drawn.
pub fn breeze_sound(m: *Mob, cx: *mut Bx, sound: *'static str, volume: f32) void {
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: cx.events.push(MobEvent::Sound(sound, at, volume, 1.0));
}
/// `Entity.lookAt(EntityAnchorArgument.Anchor.EYES, pos)`.
pub fn look_at_eyes(m: *mut Mob, at: [f64; 3]) void {
}
    // rust: let (xd, yd, zd) = (
    // rust: at[0] - m.position.x,
    // rust: at[1] - m.eye_y(),
    // rust: at[2] - m.position.z,
    // rust: );
    // rust: let sd = (xd * xd + zd * zd).sqrt();
    // The compiled code multiplies by the folded `Mth.RAD_TO_DEG`.
    // rust: let deg = f64::from(trig::RAD_TO_DEG);
    // rust: m.head_pitch = wrap_degrees((-(trig::atan2(yd, sd) * deg)) as f32);
    // rust: m.yaw = wrap_degrees((trig::atan2(zd, xd) * deg) as f32 - 90.0);
    // rust: m.head_yaw = m.yaw;
    // rust: m.previous_head_pitch = m.head_pitch;
    // rust: m.previous_yaw = m.yaw;
    // LivingEntity.lookAt: the body follows the head.
    // rust: m.previous_head_yaw = m.head_yaw;
    // rust: m.body_yaw = m.head_yaw;
    // rust: m.previous_body_yaw = m.body_yaw;
}
/// `Mth.wrapDegrees(float)`.
pub fn wrap_degrees(angle: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = angle % 360.0;
    // rust: if w >= 180.0 {
    // rust: w -= 360.0;
}
    // rust: if w < -180.0 {
    // rust: w += 360.0;
}
    // rust: w
}
/// The attack target's position, eye height, facing and height.
pub const Quarry = struct {
    position: Vec3,
    head_yaw: f32,
    height: f64,
    passenger: bool,
};
pub fn quarry(w: *MobWorld, who: Who) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = w.target_info(who)?;
    // rust: let head_yaw = match who {
    // rust: Who::Player => w.player.as_ref().map_or(0.0, |p| p.yaw),
    // rust: Who::Mob(id) => w.seen(id).map_or(0.0, |s| s.yaw),
}
    // rust: Some(Quarry {
    // rust: position: t.position,
    // rust: head_yaw,
    // rust: height: t.bounds.max_position().y - t.bounds.min_position().y,
    // rust: passenger: t.passenger,
    // rust: })
}
/// `BreezeUtil.randomPointBehindTarget`.
pub fn point_behind(m: *mut Mob, q: *Quarry) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let view = q.head_yaw + 180.0 + m.random.next_gaussian() as f32 * 90.0 / 2.0;
    // rust: let f = m.random.next_float();
    // rust: let r = 4.0 + f * (8.0 - 4.0);
    // rust: let d = Vec3::direction_from_rotation(0.0, view).scale(f64::from(r));
    // rust: q.position.add_vector(d)
}
/// `BreezeUtil.hasLineOfSight`.
pub fn line_of_sight(m: *Mob, w: *MobWorld, target: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let from = m.position;
    // rust: let range = 50.0_f64.max(m.attrs.follow_range);
    // rust: target.distance(from) <= range && w.clear_between(from, target, false)
}
/// `Slide.start`.
pub fn slide_start(m: *mut Mob, cx: *mut Bx) void {
}
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return;
}
    // rust: let Some(q) = quarry(cx.w, target) else {
    // rust: return;
}
    // Breeze.withinInnerCircleRange
    // rust: let centre = Vec3::new(
    // rust: m.position.x.floor() + 0.5,
    // rust: m.position.y.floor() + 0.5,
    // rust: m.position.z.floor() + 0.5,
    // rust: );
    // rust: let (dx, dy, dz) = (
    // rust: q.position.x - centre.x,
    // rust: q.position.y - centre.y,
    // rust: q.position.z - centre.z,
    // rust: );
    // rust: let inner = dx * dx + dz * dz < 16.0 && dy.abs() < 10.0;
    // rust: let mut position: Option<Vec3> = None;
    // rust: if inner
    // rust: && let Some(away) =
    // rust: m.default_random_pos_away(cx.w, 5, 5, [q.position.x, q.position.y, q.position.z])
    // rust: {
    // rust: let away = Vec3::new(away[0], away[1], away[2]);
    // rust: if line_of_sight(m, cx.w, away)
    // rust: && q.position.distance_squared(away) > q.position.distance_squared(m.position)
    // rust: {
    // rust: position = Some(away);
}
}
    // rust: let position = match position {
    // rust: Some(p) => p,
    // rust: None => {
    // rust: if m.random.next_boolean() {
    // rust: point_behind(m, &q)
    // rust: } else {
                // randomPointInMiddleCircle
    // rust: let d = q.position.subtract(m.position);
    // rust: let a = m.random.next_double();
    // rust: let distance = d.length() - (8.0 + a * (4.0 - 8.0));
    // rust: let n = d.normalize();
    // rust: m.position
    // rust: .add_vector(Vec3::new(n.x * distance, n.y * distance, n.z * distance))
}
}
}
    // rust: mem(m)
    // rust: .walk_target
    // rust: .set(WalkTarget::block(block_of(position), 0.6, 1));
}
/// `Shoot.tick`.
pub fn shoot_tick(m: *mut Mob, cx: *mut Bx) void {
}
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return;
}
    // rust: let Some(q) = quarry(cx.w, target) else {
    // rust: return;
}
    // rust: look_at_eyes(m, [q.position.x, q.position.y, q.position.z]);
    // rust: let mm = mem(m);
    // rust: if mm.breeze_shoot_charging.present() || mm.breeze_shoot_recovering.present() {
    // rust: return;
}
    // rust: mm.breeze_shoot_recovering.set_ttl((), 4);
    // rust: let firing = super::breeze::firing_y(m);
    // rust: let (xd, yd, zd) = (
    // rust: q.position.x - m.position.x,
        // target.getY(target.isPassenger() ? 0.8 : 0.3).
    // rust: q.position.y + q.height * if q.passenger { 0.8 } else { 0.3 } - firing,
    // rust: q.position.z - m.position.z,
    // rust: );
    // rust: let start = Vec3::new(m.position.x, firing, m.position.z);
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::BreezeWindCharge,
    // rust: start,
    // rust: Some(Who::Mob(m.id)),
    // rust: );
    // The new entity's own random spreads the shot (5 - difficulty id * 4):
    // not the breeze's.
    // rust: let mut own = LegacyRandom::new(
    // rust: cx.now
    // rust: .wrapping_mul(0x5DEE_CE66)
    // rust: .wrapping_add(i64::from(m.id)),
    // rust: );
    // rust: p.shoot(
    // rust: &mut own,
    // rust: [xd, yd, zd],
    // rust: 0.7,
    // rust: 5.0 - f32::from(cx.w.difficulty.id) * 4.0,
    // rust: );
    // rust: cx.events.push(MobEvent::Projectile(p));
    // rust: breeze_sound(m, cx, "entity.breeze.shoot", 1.5);
}
/// `LongJump.canRun`.
pub fn long_jump_can_run(m: *mut Mob, cx: *mut Bx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.on_ground && !m.fluids.in_water {
    // rust: return false;
}
    // rust: if m.fluids.water > m.fluid_jump_threshold() || m.fluids.in_lava {
    // rust: return false;
}
    // rust: if mem(m).breeze_jump_target.present() {
    // rust: return true;
}
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return false;
}
    // rust: let Some(q) = quarry(cx.w, target) else {
    // rust: return false;
}
    // outOfAggroRange: !target.closerThan(breeze, follow range)
    // rust: let follow = m.attrs.follow_range;
    // rust: if q.position.distance_squared(m.position) >= follow * follow {
    // rust: set_attack_target(m, None);
    // rust: return false;
}
    // tooCloseForJump: (float) distance - 4 <= 0
    // rust: if q.position.distance(m.position) as f32 - 4.0 <= 0.0 {
    // rust: return false;
}
    // rust: if !super::breeze::can_jump_from_here(m, cx.w) {
    // rust: return false;
}
    // rust: let behind = point_behind(m, &q);
    // rust: let Some(target_pos) = super::breeze::snap_to_surface(cx.w, behind) else {
    // rust: return false;
}
    // rust: let below =
    // rust: cx.w.block_name(target_pos[0], target_pos[1] - 1, target_pos[2]);
    // rust: if super::breeze::dangerous_block(below) {
    // rust: return false;
}
    // rust: let centre = Vec3::new(
    // rust: f64::from(target_pos[0]) + 0.5,
    // rust: f64::from(target_pos[1]) + 0.5,
    // rust: f64::from(target_pos[2]) + 0.5,
    // rust: );
    // rust: if !line_of_sight(m, cx.w, centre)
    // rust: && !line_of_sight(m, cx.w, centre.add_vector(Vec3::new(0.0, 4.0, 0.0)))
    // rust: {
    // rust: return false;
}
    // rust: mem(m).breeze_jump_target.set(target_pos);
    // rust: true
}
/// `LongJump.tick`.
pub fn long_jump_tick(m: *mut Mob, cx: *mut Bx) void {
}
    // rust: let in_water = m.fluids.in_water;
    // rust: if !in_water && mem(m).breeze_leaving_water.present() {
    // rust: mem(m).breeze_leaving_water.clear();
}
    // rust: let pose = super::breeze::pose(m);
    // rust: let finished_inhaling =
    // rust: !mem(m).breeze_jump_inhaling.present() && pose == super::breeze::INHALING;
    // rust: if finished_inhaling {
    // rust: let target = mem(m).breeze_jump_target.value();
    // rust: let v = target.and_then(|t| {
    // rust: super::breeze::optimal_jump_vector(
    // rust: m,
    // rust: Vec3::new(
    // rust: f64::from(t[0]) + 0.5,
    // rust: f64::from(t[1]),
    // rust: f64::from(t[2]) + 0.5,
    // rust: ),
    // rust: )
    // rust: });
    // rust: let Some(v) = v else {
    // rust: super::breeze::set_pose(m, super::breeze::STANDING);
    // rust: return;
}
    // rust: if in_water {
    // rust: mem(m).breeze_leaving_water.set(());
}
    // rust: breeze_sound(m, cx, "entity.breeze.jump", 1.0);
    // rust: super::breeze::set_pose(m, super::breeze::LONG_JUMPING);
    // rust: m.yaw = m.body_yaw;
    // rust: m.velocity = v;
    // rust: return;
}
    // rust: let landed_in_water = m.fluids.in_water && !mem(m).breeze_leaving_water.present();
    // rust: if pose == super::breeze::LONG_JUMPING && (m.on_ground || landed_in_water) {
    // rust: breeze_sound(m, cx, "entity.breeze.land", 1.0);
    // rust: super::breeze::set_pose(m, super::breeze::STANDING);
    // rust: let hurt = mem(m).hurt_by.present();
    // rust: let mm = mem(m);
    // rust: mm.breeze_jump_cooldown
    // rust: .set_ttl((), if hurt { 2 } else { 10 });
    // rust: mm.breeze_shoot.set_ttl((), 100);
}
}

// ---- The packages -------------------------------------------------------

pub fn timed(min: i32, max: i32) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Timed::new(min, max)
}
/// `availableBehaviorsByPriority`'s order: priority, then the activity's
/// hash slot (core 1, idle 5, fight 14), then insertion order.
pub fn sorted(mut v: Vec<(i32) void {
}
    // rust: let slot = |a: Act| match a {
    // rust: Act::Core => 1,
    // rust: Act::Idle => 5,
    // rust: Act::Fight => 14,
}
    // rust: v.sort_by_key(|(p, a, _)| (*p, slot(*a)));
    // rust: v.into_iter().map(|(_, act, b)| Entry { act, b }).collect()
}
pub fn run_one(seed: i64, kids: Vec<(B) void {
}
    // rust: B::RunOne(Box::new(RunOne {
    // rust: running: false,
    // rust: random: LegacyRandom::new(seed),
    // rust: kids: kids.into_iter().map(|(b, w)| (b, w, 0.0)).collect(),
    // rust: }))
}
pub fn move_sink(min: i32, max: i32, slide: bool) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::MoveToTargetSink {
    // rust: t: timed(min, max),
    // rust: cooldown: 0,
    // rust: path: None,
    // rust: last_target: None,
    // rust: speed: 0.0,
    // rust: slide,
}
}
/// `BreezeAi.getActivities`.
pub fn breeze_packages(seed: i64) V {
    // Implementation ported from Horizon
    return undefined;
}
//     use Act::*;
    // rust: sorted(vec![
    // rust: (
    // rust: 0,
    // rust: Core,
    // rust: B::Swim {
    // rust: t: timed(60, 60),
    // rust: creaking: false,
    // rust: },
    // rust: ),
    // rust: (1, Core, B::LookAtTargetSink(timed(45, 90))),
    // rust: (0, Idle, B::StartAttacking(false, Finder::NearestAttackable)),
    // rust: (1, Idle, B::StartAttacking(false, Finder::HurtBy)),
    // rust: (2, Idle, move_sink(20, 40, true)),
    // rust: (
    // rust: 3,
    // rust: Idle,
    // rust: run_one(
    // rust: seed,
    // rust: vec![
    // rust: (B::DoNothing(timed(20, 100)), 1),
    // rust: (B::RandomStroll(false, 0.6), 2),
    // rust: ],
    // rust: ),
    // rust: ),
    // rust: (
    // rust: 0,
    // rust: Fight,
    // rust: B::StopAttacking {
    // rust: running: false,
    // rust: breeze: true,
    // rust: positives_left: 0,
    // rust: },
    // rust: ),
    // rust: (1, Fight, B::Shoot(timed(20, 20))),
    // rust: (2, Fight, B::LongJump(timed(200, 200))),
    // rust: (3, Fight, B::ShootWhenStuck(timed(60, 60))),
    // rust: (4, Fight, B::Slide(timed(60, 60))),
    // rust: ])
}
/// `CreakingAi.getActivities`.
pub fn creaking_packages(seed: i64) V {
    // Implementation ported from Horizon
    return undefined;
}
//     use Act::*;
    // rust: sorted(vec![
    // rust: (
    // rust: 0,
    // rust: Core,
    // rust: B::Swim {
    // rust: t: timed(60, 60),
    // rust: creaking: true,
    // rust: },
    // rust: ),
    // rust: (1, Core, B::LookAtTargetSink(timed(45, 90))),
    // rust: (2, Core, move_sink(150, 250, false)),
    // rust: (10, Idle, B::StartAttacking(false, Finder::ActiveCreaking)),
    // rust: (
    // rust: 11,
    // rust: Idle,
    // rust: B::SetEntityLookTargetSometimes {
    // rust: running: false,
    // rust: until_next: 0,
    // rust: },
    // rust: ),
    // rust: (
    // rust: 12,
    // rust: Idle,
    // rust: run_one(
    // rust: seed,
    // rust: vec![
    // rust: (B::RandomStroll(false, 0.3), 2),
    // rust: (B::SetWalkTargetFromLookTarget(false), 2),
    // rust: (B::DoNothing(timed(30, 60)), 1),
    // rust: ],
    // rust: ),
    // rust: ),
    // rust: (10, Fight, B::SetWalkTargetFromAttackTarget(false)),
    // rust: (11, Fight, B::MeleeAttack(false)),
    // rust: (
    // rust: 12,
    // rust: Fight,
    // rust: B::StopAttacking {
    // rust: running: false,
    // rust: breeze: false,
    // rust: positives_left: 0,
    // rust: },
    // rust: ),
    // rust: ])
}

// ---- The probe's view ---------------------------------------------------

pub fn who(w: Who) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match w {
    // rust: Who::Player => "player".into(),
    // rust: Who::Mob(id) => format!("e{id}"),
}
}
pub fn pos(p: [i32; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{},{},{}", p[0], p[1], p[2])
}
pub fn tracker(t: Tracker) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match t {
    // rust: Tracker::Entity(e, _) => who(e),
    // rust: Tracker::Block(p) => pos(p),
    // rust: Tracker::Point(v) => pos([
    // rust: v[0].floor() as i32,
    // rust: v[1].floor() as i32,
    // rust: v[2].floor() as i32,
    // rust: ]),
}
}
/// The active activities and the memories with values, as the mob AI
/// oracle prints them.
pub fn describe(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = brain(m)?;
    // rust: let mut acts = ["core", b.activity.name()];
    // rust: acts.sort_unstable();
    // rust: let mm = &b.mem;
    // rust: let mut out: Vec<String> = Vec::new();
    // rust: let mut put = |name: &str, value: String, ttl: i64| {
    // rust: if ttl == NEVER {
    // rust: out.push(format!("{name}={value}"));
    // rust: } else {
    // rust: out.push(format!("{name}={value}@{ttl}"));
}
}
    // rust: macro_rules! slot {
    // rust: ($name:expr, $s:expr, $f:expr) => {
    // rust: if let Some(v) = $s.get() {
    // rust: put($name, $f(v), $s.ttl);
}
}
}
    // rust: let unit = |_: &()| "u".to_string();
    // rust: let list = |l: &Vec<Who>| format!("n{}", l.len());
    // rust: slot!("attack_target", mm.attack_target, |e: &Who| who(*e));
    // rust: slot!("attack_cooling_down", mm.attack_cooling_down, |b: &bool| b
    // rust: .to_string());
    // rust: slot!(
    // rust: "cant_reach_walk_target_since",
    // rust: mm.cant_reach_walk_target_since,
    // rust: |t: &i64| t.to_string()
    // rust: );
    // rust: slot!("hurt_by", mm.hurt_by, |_: &i64| "DamageSource".to_string());
    // rust: slot!("hurt_by_entity", mm.hurt_by_entity, |e: &Who| who(*e));
    // rust: slot!("look_target", mm.look_target, |t: &Tracker| tracker(*t));
    // rust: slot!("mobs", mm.mobs, list);
    // rust: slot!("visible_mobs", mm.visible_mobs, |_: &Visible| {
    // rust: "NearestVisibleLivingEntities".to_string()
    // rust: });
    // rust: slot!("nearest_attackable", mm.nearest_attackable, |e: &Who| who(
    // rust: *e
    // rust: ));
    // rust: slot!("nearest_players", mm.nearest_players, list);
    // rust: slot!(
    // rust: "nearest_visible_player",
    // rust: mm.nearest_visible_player,
    // rust: |e: &Who| who(*e)
    // rust: );
    // rust: slot!(
    // rust: "nearest_visible_targetable_player",
    // rust: mm.nearest_visible_targetable_player,
    // rust: |e: &Who| who(*e)
    // rust: );
    // rust: slot!(
    // rust: "nearest_visible_targetable_players",
    // rust: mm.nearest_visible_targetable_players,
    // rust: list
    // rust: );
    // rust: slot!("path", mm.path, |p: &Path| format!("path{}", pos(p.target)));
    // rust: slot!("walk_target", mm.walk_target, |t: &WalkTarget| format!(
    // rust: "{}/{:x}/{}",
    // rust: tracker(t.target),
    // rust: t.speed.to_bits(),
    // rust: t.close
    // rust: ));
    // rust: slot!("breeze_shoot", mm.breeze_shoot, unit);
    // rust: slot!("breeze_shoot_charging", mm.breeze_shoot_charging, unit);
    // rust: slot!("breeze_shoot_recover", mm.breeze_shoot_recovering, unit);
    // rust: slot!("breeze_shoot_cooldown", mm.breeze_shoot_cooldown, unit);
    // rust: slot!("breeze_jump_cooldown", mm.breeze_jump_cooldown, unit);
    // rust: slot!("breeze_jump_inhaling", mm.breeze_jump_inhaling, unit);
    // rust: slot!(
    // rust: "breeze_jump_target",
    // rust: mm.breeze_jump_target,
    // rust: |p: &[i32; 3]| { pos(*p) }
    // rust: );
    // rust: slot!("breeze_leaving_water", mm.breeze_leaving_water, unit);
    // rust: out.sort();
    // rust: Some((acts.join("|"), out.join(" ")))
}
