//! Transpiled from Horizon Rust crate
//! Module: horizon-client_villager_brain
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The villager's `Brain` (`Villager.BRAIN_PROVIDER` and
//! `VillagerGoalPackages`), ported behaviour for behaviour: memories that
//! expire, the nine sensors and their scan rates, activities from the
//! `villager_activity` timeline, and the behaviours of each activity, started
//! and ticked in vanilla's order (priority, then the activity's slot in
//! `Brain.availableBehaviorsByPriority`'s hash map, then insertion order).
//!
//! The level random (`ServerLevel.getRandom`) times behaviours and POI scans;
//! the mob's own random drives positions, sounds and jumps. `RunOne` and the
//! other `GateBehavior`s shuffle with a random of their own, seeded with
//! `Brain::shuffle_seed` when the brain is built.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species, Who,
    // rust: brain::{Timed, living_near},
    // rust: path::{Path, PathNode},
}
// use horizon_core::{
    // rust: geometry::Vec3,
    // rust: random::{LegacyRandom, RandomSource},
}

/// `MemorySlot.NEVER_EXPIRE`.
    // rust: pub(super) const NEVER: i64 = i64::MAX;

/// `MemorySlot`: a value and its time to live.
pub const Slot = struct {
    v: ?T,
    // rust: pub(super) ttl: i64,
};
    // rust: impl<T> Default for Slot<T> {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: v: None,
    // rust: ttl: NEVER,
}
}
}
    // rust: impl<T> Slot<T> {
    /// `MemorySlot.tick` (`Brain.forgetOutdatedMemories`).
    // rust: pub(super) fn tick(&mut self) {
    // rust: if self.v.is_some() && self.ttl != NEVER {
    // rust: if self.ttl <= 0 {
    // rust: self.clear();
    // rust: } else {
    // rust: self.ttl -= 1;
}
}
}
pub fn set(self: *Self, v: T) void {
}
    // rust: self.v = Some(v);
    // rust: self.ttl = NEVER;
}
pub fn set_ttl(self: *Self, v: T, ttl: i64) void {
}
    // rust: self.v = Some(v);
    // rust: self.ttl = ttl;
}
pub fn set_opt(self: *Self, v: ?T) void {
}
    // rust: match v {
    // rust: Some(v) => self.set(v),
    // rust: None => self.clear(),
}
}
pub fn clear(self: *Self) void {
}
    // rust: self.v = None;
    // rust: self.ttl = NEVER;
}
pub fn get(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.v.as_ref()
}
pub fn get_mut(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.v.as_mut()
}
pub fn present(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.v.is_some()
}
    /// The time to live (`i64::MAX`: never expires).
pub fn ttl(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ttl
}
}
    // rust: impl<T: Clone> Slot<T> {
pub fn value(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.v.clone()
}
}
    // rust: impl<T> Slot<Vec<T>> {
    /// `Brain.setMemory` of a collection: an empty one erases the memory.
    // rust: pub(super) fn set_list(&mut self, v: Vec<T>) {
    // rust: if v.is_empty() {
    // rust: self.clear();
    // rust: } else {
    // rust: self.set(v);
}
}
}

/// `PositionTracker`: an entity (`EntityTracker`, at its eyes or feet) or a
/// block (`BlockPosTracker`, at its centre or at a given point).
pub const Tracker = enum {
    Entity(Who, bool),
    Block([i32; 3]),
    Point([f64; 3]),
};
    // rust: impl Tracker {
    /// `currentPosition`.
pub fn position(self: *Self, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match *self {
    // rust: Tracker::Entity(who, eye) => w.target_info(who).map(|t| {
    // rust: [
    // rust: t.position.x,
    // rust: if eye { t.eye_y } else { t.position.y },
    // rust: t.position.z,
    // rust: ]
    // rust: }),
    // rust: Tracker::Block(p) => Some([
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ]),
    // rust: Tracker::Point(v) => Some(v),
}
}
    /// `currentBlockPosition`.
pub fn block(self: *Self, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match *self {
    // rust: Tracker::Entity(who, _) => w.target_info(who).map(|t| block_of(t.position)),
    // rust: Tracker::Block(p) => Some(p),
    // rust: Tracker::Point(v) => Some([
    // rust: v[0].floor() as i32,
    // rust: v[1].floor() as i32,
    // rust: v[2].floor() as i32,
    // rust: ]),
}
}
}
pub fn block_of(p: Vec3) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32]
}
/// `WalkTarget`.
pub const WalkTarget = struct {
    target: Tracker,
    speed: f32,
    close: i32,
};
    // rust: impl WalkTarget {
    // rust: pub(super) fn block(p: [i32; 3], speed: f32, close: i32) -> Self {
    // rust: Self {
    // rust: target: Tracker::Block(p),
    // rust: speed,
    // rust: close,
}
}
    /// `new WalkTarget(Vec3, ...)`: the block containing the point.
    // rust: pub(super) fn point(p: [f64; 3], speed: f32, close: i32) -> Self {
    // rust: Self::block(
    // rust: [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ],
    // rust: speed,
    // rust: close,
    // rust: )
}
}

/// `NearestVisibleLivingEntities`: the nearby entities and a lazily filled
/// cache of `Sensor.isEntityTargetable`.
pub const Visible = struct {
    // rust: pub(super) list: Vec<Who>,
    // rust: pub(super) cache: Vec<(Who, bool)>,
};

/// The memories a villager's brain registers.
pub const Memories = struct {
    home: Slot<[i32,
    job_site: Slot<[i32,
    potential_job_site: Slot<[i32,
    meeting_point: Slot<[i32,
    secondary_job_site: Slot<Vec<[i32,
    mobs: Slot<std.ArrayList(Who)>,
    visible_mobs: Slot<Visible>,
    visible_villager_babies: Slot<std.ArrayList(Who)>,
    nearest_players: Slot<std.ArrayList(Who)>,
    nearest_visible_player: Slot<Who>,
    nearest_visible_targetable_player: Slot<Who>,
    nearest_visible_targetable_players: Slot<std.ArrayList(Who)>,
    walk_target: Slot<WalkTarget>,
    look_target: Slot<Tracker>,
    interaction_target: Slot<Who>,
    breed_target: Slot<Who>,
    /// `PATH`: the navigation's path (its target).
    path: Slot<Path>,
    doors_to_close: Slot<Vec<[i32,
    nearest_bed: Slot<[i32,
    /// `HURT_BY`: the damage (its game time).
    hurt_by: Slot<i64>,
    hurt_by_entity: Slot<Who>,
    nearest_hostile: Slot<Who>,
    hiding_place: Slot<[i32,
    heard_bell_time: Slot<i64>,
    /// `NEAREST_VISIBLE_WANTED_ITEM`: where the item entity lies.
    nearest_wanted_item: Slot<[f64,
    cant_reach_walk_target_since: Slot<i64>,
    golem_detected_recently: Slot<bool>,
    last_slept: Slot<i64>,
    last_woken: Slot<i64>,
    last_worked_at_poi: Slot<i64>,
};
    // rust: impl Memories {
pub fn tick(self: *Self) void {
}
    // rust: self.home.tick();
    // rust: self.job_site.tick();
    // rust: self.potential_job_site.tick();
    // rust: self.meeting_point.tick();
    // rust: self.secondary_job_site.tick();
    // rust: self.mobs.tick();
    // rust: self.visible_mobs.tick();
    // rust: self.visible_villager_babies.tick();
    // rust: self.nearest_players.tick();
    // rust: self.nearest_visible_player.tick();
    // rust: self.nearest_visible_targetable_player.tick();
    // rust: self.nearest_visible_targetable_players.tick();
    // rust: self.walk_target.tick();
    // rust: self.look_target.tick();
    // rust: self.interaction_target.tick();
    // rust: self.breed_target.tick();
    // rust: self.path.tick();
    // rust: self.doors_to_close.tick();
    // rust: self.nearest_bed.tick();
    // rust: self.hurt_by.tick();
    // rust: self.hurt_by_entity.tick();
    // rust: self.nearest_hostile.tick();
    // rust: self.hiding_place.tick();
    // rust: self.heard_bell_time.tick();
    // rust: self.nearest_wanted_item.tick();
    // rust: self.cant_reach_walk_target_since.tick();
    // rust: self.golem_detected_recently.tick();
    // rust: self.last_slept.tick();
    // rust: self.last_woken.tick();
    // rust: self.last_worked_at_poi.tick();
}
    /// `Brain.pack`: the memories with a codec, which a rebuilt brain keeps.
pub fn pack(self: *Self) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Memories {
    // rust: home: self.home.clone(),
    // rust: job_site: self.job_site.clone(),
    // rust: potential_job_site: self.potential_job_site.clone(),
    // rust: meeting_point: self.meeting_point.clone(),
    // rust: golem_detected_recently: self.golem_detected_recently.clone(),
    // rust: last_slept: self.last_slept.clone(),
    // rust: last_woken: self.last_woken.clone(),
    // rust: last_worked_at_poi: self.last_worked_at_poi.clone(),
    // rust: ..Memories::default()
}
}
}

/// `Activity`.
pub const Act = enum {
    Core,
    Idle,
    Work,
    Play,
    Rest,
    Meet,
    Panic,
    Raid,
    PreRaid,
    Hide,
};
    // rust: impl Act {
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Act::Core => "core",
    // rust: Act::Idle => "idle",
    // rust: Act::Work => "work",
    // rust: Act::Play => "play",
    // rust: Act::Rest => "rest",
    // rust: Act::Meet => "meet",
    // rust: Act::Panic => "panic",
    // rust: Act::Raid => "raid",
    // rust: Act::PreRaid => "pre_raid",
    // rust: Act::Hide => "hide",
}
}
    /// The bucket order of `HashMap<Activity, ...>` (16 buckets, the hash
    /// of the name; equal buckets keep the villager's insertion order).
pub fn slot(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Act::Play => 0,
    // rust: Act::Core => 1,
    // rust: Act::Rest => 2,
    // rust: Act::Hide => 3,
    // rust: Act::Meet => 4,
    // rust: Act::Idle => 5,
    // rust: Act::PreRaid => 6,
    // rust: Act::Work => 7,
    // rust: Act::Panic => 8,
    // rust: Act::Raid => 9,
}
}
}

/// The scan rate of each sensor, in `BRAIN_PROVIDER` order.
pub const SENSOR_RATES: [i64; 9] = [20, 20, 20, 20, 20, 20, 20, 40, 200];

/// A villager's brain.
pub const Brain = struct {
    mem: Memories,
    sensors: [i64,
    /// The active non-core activity (`CORE` is always active).
    activity: Act,
    default_activity: Act,
    last_schedule_update: i64,
    list: std.ArrayList(Entry),
    shuffle_seed: i64,
    baby: bool,
    /// Whether the nearest-bed sensor's batch cache is used (`NearestBedSensor`).
    bed_cache: Vec<([i32,
    /// `NearestItemSensor` is due; the game, which knows the items, answers.
    scan_items: bool,
};
pub const Entry = struct {
    prio: i32,
    act: Act,
    b: B,
};

pub fn brain(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::villager::ext(m).and_then(|e| e.brain.as_deref())
}
pub fn brain_mut(m: *mut Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (baby, farmer) = (m.is_baby(), super::villager::is_farmer(m));
    // rust: let e = super::villager::ext_mut(m);
    // rust: e.brain
    // rust: .get_or_insert_with(|| Box::new(Brain::new(baby, 0, farmer)))
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
pub fn mem_ref(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: brain(m).map(|b| &b.mem)
}

    // rust: impl Brain {
pub fn new(baby: bool, shuffle_seed: i64, farmer: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut b = Brain {
    // rust: mem: Memories::default(),
    // rust: sensors: [0; 9],
    // rust: activity: Act::Idle,
    // rust: default_activity: Act::Idle,
    // rust: last_schedule_update: -9999,
    // rust: list: Vec::new(),
    // rust: shuffle_seed,
    // rust: baby,
    // rust: bed_cache: Vec::new(),
    // rust: scan_items: false,
}
    // rust: b.list = packages(baby, shuffle_seed, farmer);
    // rust: b
}
pub fn requirements_met(self: *Self, a: Act) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match a {
    // rust: Act::Work => !self.baby && self.mem.job_site.present(),
    // rust: Act::Play => self.baby,
    // rust: Act::Meet => self.mem.meeting_point.present(),
    // rust: Act::Core
    // rust: | Act::Idle
    // rust: | Act::Rest
    // rust: | Act::Panic
    // rust: | Act::Raid
    // rust: | Act::PreRaid
    // rust: | Act::Hide => true,
}
}
pub fn is_active(self: *Self, a: Act) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: a == Act::Core || a == self.activity
}
    /// `setActiveActivityIfPossible`.
pub fn set_active_if_possible(self: *Self, a: Act) void {
}
    // rust: if self.requirements_met(a) {
    // rust: self.activity = a;
    // rust: } else {
    // rust: self.activity = self.default_activity;
}
}
    /// `updateActivityFromSchedule`.
pub fn update_from_schedule(self: *Self, game_time: i64, day_time: i64) void {
}
    // rust: if game_time - self.last_schedule_update > 20 {
    // rust: self.last_schedule_update = game_time;
    // rust: let scheduled = schedule(self.baby, day_time);
    // rust: if !self.is_active(scheduled) {
    // rust: self.set_active_if_possible(scheduled);
}
}
}
}
/// The `villager_activity` and `baby_villager_activity` timelines.
pub fn schedule(baby: bool, day_time: i64) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match super::villager::activity_at(baby, day_time) {
    // rust: super::villager::Activity::Idle => Act::Idle,
    // rust: super::villager::Activity::Work => Act::Work,
    // rust: super::villager::Activity::Play => Act::Play,
    // rust: super::villager::Activity::Meet => Act::Meet,
    // rust: super::villager::Activity::Rest => Act::Rest,
}
}

/// `Brain.Provider.makeBrain` and `Villager.registerBrainGoals`: a new brain
/// from the packed memories (the sensors' first scans are delayed by draws
/// from the mob's random), on the timeline's activity.
pub fn make_brain(m: *mut Mob, packed: Memories, shuffle_seed: i64, w_times: (i64) void {
}
    // rust: let mut b = Brain::new(m.is_baby(), shuffle_seed, super::villager::is_farmer(m));
    // rust: for (i, rate) in SENSOR_RATES.iter().enumerate() {
    // rust: b.sensors[i] = i64::from(m.random.next_int_bound(*rate as i32).unwrap_or(0));
}
    // rust: b.mem = packed;
    // rust: b.update_from_schedule(w_times.0, w_times.1);
    // rust: b
}

/// Builds the villager's brain as its constructor does, at this game time:
/// the memories it remembers (job site, bed, bell) come from the mob.
pub fn init(m: *mut Mob, game_time: i64, day_time: i64, shuffle_seed: i64) void {
}
    // rust: let mut packed = Memories::default();
    // rust: packed.job_site.set_opt(m.extra.home);
    // rust: packed.home.set_opt(m.extra.bed);
    // rust: packed.meeting_point.set_opt(m.extra.meeting);
    // rust: if let Some(t) = super::villager::ext(m).and_then(|e| e.last_slept) {
    // rust: packed.last_slept.set(t);
}
    // rust: let b = make_brain(m, packed, shuffle_seed, (game_time, day_time));
    // rust: super::villager::ext_mut(m).brain = Some(Box::new(b));
}

/// What behaviours read and emit during a brain tick.
pub const Bx = struct {
    w: *'a MobWorld<'w>,
    lr: *'a mut LegacyRandom,
    events: *'a mut std.ArrayList(MobEvent),
    now: i64,
    /// `Villager.refreshBrain` was asked for.
    refresh: bool,
};

/// `Brain.tick` (from `Villager.customServerAiStep`).
pub fn tick(m: *mut Mob, w: *MobWorld, lr: *mut LegacyRandom, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if brain(m).is_none() {
    // rust: let seed = i64::from(m.id);
    // rust: init(m, w.game_time, w.day_time, seed);
}
    // forgetOutdatedMemories
    // rust: mem(m).tick();
    // rust: tick_sensors(m, w, lr);
    // rust: let mut list = std::mem::take(&mut brain_mut(m).list);
    // rust: let mut cx = Bx {
    // rust: w,
    // rust: lr,
    // rust: events,
    // rust: now: w.game_time,
    // rust: refresh: false,
}
    // The brain whose behaviours these are: after a refresh they keep running
    // against the new brain's memories, gated by the old brain's activities.
    // rust: let mut old_activity: Option<Act> = None;
    // rust: let mut refreshed = false;
    // rust: for i in 0..list.len() {
    // rust: let active = match old_activity {
    // rust: Some(a) => list[i].act == Act::Core || list[i].act == a,
    // rust: None => brain_mut(m).is_active(list[i].act),
}
    // rust: if active && !list[i].b.running() {
    // rust: list[i].b.try_start(m, &mut cx);
    // rust: if cx.refresh {
    // rust: cx.refresh = false;
    // rust: old_activity = Some(brain_mut(m).activity);
    // rust: refresh(m, &mut list, i, &mut cx);
    // rust: refreshed = true;
}
}
}
    // rust: for e in list.iter_mut() {
    // rust: if e.b.running() {
    // rust: e.b.tick_or_stop(m, &mut cx);
}
}
    // rust: if !refreshed {
    // rust: brain_mut(m).list = list;
}
    // rust: sync(m, w.game_time);
}

/// `Villager.ageBoundaryReached`: a villager that grew up gets a new brain
/// (the schedule it follows is the adult's), as `refreshBrain` builds it.
    // rust: pub fn age_boundary_reached(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: lr: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if brain(m).is_none() {
    // rust: return;
}
    // rust: let mut list = std::mem::take(&mut brain_mut(m).list);
    // rust: let mut cx = Bx {
    // rust: w,
    // rust: lr,
    // rust: events,
    // rust: now: w.game_time,
    // rust: refresh: false,
}
    // rust: refresh(m, &mut list, usize::MAX, &mut cx);
}

/// `Villager.refreshBrain`: stop every running behaviour, then rebuild the
/// brain from the remembered memories.
pub fn refresh(m: *mut Mob, list: *mut [Entry], current: usize, cx: *mut Bx) void {
}
    // rust: for (i, e) in list.iter_mut().enumerate() {
    // rust: if i != current && e.b.running() {
    // rust: e.b.do_stop(m, cx);
}
}
    // rust: let b = brain_mut(m);
    // rust: let packed = b.mem.pack();
    // rust: let seed = b.shuffle_seed;
    // rust: let nb = make_brain(m, packed, seed, (cx.w.game_time, cx.w.day_time));
    // rust: super::villager::ext_mut(m).brain = Some(Box::new(nb));
}

/// Mirrors the remembered positions onto the mob (saved, seen by others),
/// and the sleep and golem memories onto `villager::Ext`.
pub fn sync(m: *mut Mob, now: i64) void {
}
    // rust: let (job, home, meeting, slept, golem) = {
    // rust: let b = brain_mut(m);
    // rust: (
    // rust: b.mem.job_site.value(),
    // rust: b.mem.home.value(),
    // rust: b.mem.meeting_point.value(),
    // rust: b.mem.last_slept.value(),
    // rust: b.mem
    // rust: .golem_detected_recently
    // rust: .get()
    // rust: .map(|_| now + b.mem.golem_detected_recently.ttl + 1),
    // rust: )
}
    // rust: m.extra.home = job;
    // rust: m.extra.bed = home;
    // rust: m.extra.meeting = meeting;
    // rust: let e = super::villager::ext_mut(m);
    // rust: e.last_slept = slept;
    // rust: e.golem_until = golem.unwrap_or(0);
}

// ---- Sensors ------------------------------------------------------------

pub fn tick_sensors(m: *mut Mob, w: *MobWorld, lr: *mut LegacyRandom) void {
}
    // rust: for i in 0..9 {
    // rust: let fire = {
    // rust: let b = brain_mut(m);
    // rust: b.sensors[i] -= 1;
    // rust: if b.sensors[i] <= 0 {
    // rust: b.sensors[i] = SENSOR_RATES[i];
    // rust: true
    // rust: } else {
    // rust: false
}
}
    // rust: if !fire {
    // rust: continue;
}
    // rust: match i {
    // rust: 0 => sense_living(m, w),
    // rust: 1 => sense_players(m, w),
    // rust: 2 => brain_mut(m).scan_items = true,
    // rust: 3 => sense_bed(m, w, lr),
    // rust: 4 => sense_hurt(m, w),
    // rust: 5 => sense_hostiles(m, w),
    // rust: 6 => sense_babies(m, w),
    // rust: 7 => sense_secondary(m, w),
    // rust: _ => sense_golem(m, w),
}
}
}
pub const FOLLOW_RANGE: f64 = 16.0;
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
/// `Sensor.isEntityTargetable`: `TargetingConditions.forNonCombat()` within
/// the follow range, in sight.
pub fn targetable(m: *mut Mob, w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match who {
    // rust: Who::Player => m.can_see_player(w, FOLLOW_RANGE),
    // rust: Who::Mob(id) => {
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: s.alive && m.distance_sqr(s.position) <= FOLLOW_RANGE * FOLLOW_RANGE && m.sees(w, who)
}
}
}
/// The visible-entities memory's line-of-sight test, cached per memory.
pub fn visible_test(m: *mut Mob, w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(v) = mem_ref(m).and_then(|mm| mm.visible_mobs.get()) {
    // rust: if let Some(&(_, r)) = v.cache.iter().find(|(k, _)| *k == who) {
    // rust: return r;
}
    // rust: } else {
    // rust: return false;
}
    // rust: let r = targetable(m, w, who);
    // rust: if let Some(v) = mem(m).visible_mobs.v.as_mut() {
    // rust: v.cache.push((who, r));
}
    // rust: r
}
/// `NearestVisibleLivingEntities.findClosest`.
pub fn find_closest(m: *mut Mob, w: *MobWorld, filter: impl Fn(*Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let list = mem_ref(m)?.visible_mobs.get()?.list.clone();
    // rust: list.into_iter()
    // rust: .find(|&who| filter(m, who) && visible_test(m, w, who))
}
/// `NearestVisibleLivingEntities.contains(entity)`.
pub fn visible_contains(m: *mut Mob, w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(list) = mem_ref(m)
    // rust: .and_then(|mm| mm.visible_mobs.get())
    // rust: .map(|v| v.list.contains(&who))
    // rust: else {
    // rust: return false;
}
    // rust: list && visible_test(m, w, who)
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
    // rust: .filter(|_| m.can_target_player(w, FOLLOW_RANGE, true))
    // rust: .collect();
    // rust: let mm = mem(m);
    // rust: mm.nearest_players.set_list(players);
    // rust: mm.nearest_visible_player.set_opt(visible.first().copied());
    // rust: mm.nearest_visible_targetable_players
    // rust: .set_list(attackable.clone());
    // rust: mm.nearest_visible_targetable_player
    // rust: .set_opt(attackable.first().copied());
}
/// `NearestBedSensor`: babies remember the nearest reachable bed, trying
/// at most four beds a scan and skipping the ones tried lately.
pub fn sense_bed(m: *mut Mob, w: *MobWorld, lr: *mut LegacyRandom) void {
}
    // rust: if !m.is_baby() {
    // rust: return;
}
    // rust: let last_update = w.game_time + i64::from(lr.next_int_bound(20).unwrap_or(0));
    // rust: let homes = homes_in_range(m, w, 48);
    // rust: let mut cache = std::mem::take(&mut brain_mut(m).bed_cache);
    // rust: let mut tried = 0;
    // rust: let mut targets = Vec::new();
    // rust: for &p in &homes {
    // rust: if cache.iter().any(|(q, _)| *q == p) {
    // rust: continue;
}
    // rust: tried += 1;
    // rust: if tried >= 5 {
    // rust: continue;
}
    // rust: cache.push((p, last_update + 40));
    // rust: targets.push(p);
}
    // rust: let path = if targets.is_empty() {
    // rust: None
    // rust: } else {
    // rust: m.create_path_to_any(w, &targets, 1)
}
    // createPath hands back the current path when it still heads for a
    // target position it was asked: only a bed (a POI) counts.
    // rust: if let Some(path) = path.filter(|p| p.reached) {
    // rust: if homes.contains(&path.target) {
    // rust: mem(m).nearest_bed.set(path.target);
}
    // rust: } else if tried < 5 {
    // rust: cache.retain(|(_, until)| *until >= last_update);
}
    // rust: brain_mut(m).bed_cache = cache;
}
/// `HurtBySensor`: the last damage (forgotten 40 ticks after) and who did it.
pub fn sense_hurt(m: *mut Mob, w: *MobWorld) void {
}
    // LivingEntity.getLastDamageSource: forgotten 40 ticks after the hit.
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
/// `VillagerHostilesSensor.ACCEPTABLE_DISTANCE_FROM_HOSTILES`.
pub fn hostile_distance(s: Species) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match s {
    // rust: Species::Drowned
    // rust: | Species::Husk
    // rust: | Species::Vex
    // rust: | Species::Zombie
    // rust: | Species::ZombieVillager => 8.0,
    // rust: Species::Evoker | Species::Illusioner | Species::Ravager => 12.0,
    // rust: Species::Pillager => 15.0,
    // rust: Species::Vindicator | Species::Zoglin => 10.0,
    // rust: _ => return None,
    // rust: })
}
pub fn sense_hostiles(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let hostile = find_closest(m, w, |m, who| {
    // rust: let Who::Mob(id) = who else { return false };
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: hostile_distance(s.species).is_some_and(|d| m.distance_sqr(s.position) <= f64::from(d * d))
    // rust: });
    // rust: mem(m).nearest_hostile.set_opt(hostile);
}
pub fn sense_babies(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let list = mem_ref(m)
    // rust: .and_then(|mm| mm.visible_mobs.get())
    // rust: .map(|v| v.list.clone())
    // rust: .unwrap_or_default();
    // rust: let mut babies = Vec::new();
    // rust: for who in list {
    // rust: let Who::Mob(id) = who else { continue };
    // rust: if w.seen(id)
    // rust: .is_some_and(|s| s.species == Species::Villager && s.baby)
    // rust: && visible_test(m, w, who)
    // rust: {
    // rust: babies.push(who);
}
}
    // rust: mem(m).visible_villager_babies.set_list(babies);
}
/// `SecondaryPoiSensor.doTick`: a farmer's farmland within four blocks.
pub fn sense_secondary(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let mut sites = Vec::new();
    // rust: if super::villager::is_farmer(m) {
    // rust: let c = block_of(m.position);
    // rust: for x in -4..=4 {
    // rust: for y in -2..=2 {
    // rust: for z in -4..=4 {
    // rust: let p = [c[0] + x, c[1] + y, c[2] + z];
    // rust: if farmland(w, p) {
    // rust: sites.push(p);
}
}
}
}
}
    // rust: mem(m).secondary_job_site.set_list(sites);
}
/// `GolemSensor`.
pub fn sense_golem(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let golem = mem_ref(m)
    // rust: .and_then(|mm| mm.mobs.get())
    // rust: .is_some_and(|list| {
    // rust: list.iter().any(|who| {
    // rust: matches!(who, Who::Mob(id) if w.seen(*id).is_some_and(|s| s.species == Species::IronGolem))
    // rust: })
    // rust: });
    // rust: if golem {
    // rust: mem(m).golem_detected_recently.set_ttl(true, 599);
}
}

/// `GolemSensor.golemDetected`: a golem was summoned near this villager;
/// for 599 ticks it wants no other.
pub fn golem_detected(m: *mut Mob, now: i64) void {
}
    // rust: mem(m).golem_detected_recently.set_ttl(true, 599);
    // What `sync` derives from the memory.
    // rust: super::villager::ext_mut(m).golem_until = now + 599 + 1;
}

// ---- Behaviours ---------------------------------------------------------

    // rust: pub use crate::poi_sections::Poi;
/// The POI a block state is (`PoiTypes`): job site blocks, bed heads, bells.
pub fn poi_at(w: *MobWorld, x: i32, y: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: poi_of_state(w, w.world.block(x, y, z))
}
/// The POI a block state is, if any (`PoiTypes.forState`), from the table
/// of every state built on first use.
pub fn poi_of_state(w: *MobWorld, state: horizon_world::registry::BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let table = w.data.pois.get_or_init(|| {
    // rust: (0..w.registry.len())
    // rust: .map(|i| state_poi(w, horizon_world::registry::BlockStateId(i as u32)))
    // rust: .collect()
    // rust: });
    // rust: match table.get(state.0 as usize) {
    // rust: Some(poi) => *poi,
    // rust: None => state_poi(w, state),
}
}
pub fn state_poi(w: *MobWorld, state: horizon_world::registry::BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = &*w.facts.get(state).name;
    // rust: if name == "minecraft:bell" {
    // rust: return Some(Poi::Meeting);
}
    // rust: if name.ends_with("_bed") {
    // rust: let part = w
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("part"));
    // rust: return (part.map(String::as_str) == Some("head")).then_some(Poi::Home);
}
    // rust: super::villager::job_site_profession(name).map(Poi::Job)
}
/// Which POI types a predicate accepts.
pub const PoiFilter = enum {
    /// `VillagerProfession.heldJobSite` of the current profession.
    Held,
    /// `acquirableJobSite` of the current profession.
    Acquirable,
    Home,
    Meeting,
};
pub fn poi_matches(m: *Mob, f: PoiFilter, p: Poi) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let profession = m.extra.variant2;
    // rust: let employed = profession != super::villager::NONE && profession != super::villager::NITWIT;
    // rust: match (f, p) {
    // rust: (PoiFilter::Held, Poi::Job(j)) => employed && j == profession,
    // rust: (PoiFilter::Acquirable, Poi::Job(j)) => {
    // rust: if profession == super::villager::NONE {
    // rust: true
    // rust: } else {
    // rust: employed && j == profession
}
}
    // rust: (PoiFilter::Home, Poi::Home) | (PoiFilter::Meeting, Poi::Meeting) => true,
    // rust: _ => false,
}
}
/// Tickets taken on a POI: by this villager's memories and by others'
/// (counted once per search by [`others_tickets`]).
pub fn tickets(m: *Mob, others: *crate::fast_hash::FxHashMap<[i32; 3], p: [i32; 3]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut n = 0;
    // rust: if let Some(mm) = mem_ref(m) {
    // rust: for s in [
    // rust: &mm.job_site,
    // rust: &mm.potential_job_site,
    // rust: &mm.home,
    // rust: &mm.meeting_point,
    // rust: ] {
    // rust: if s.get() == Some(&p) {
    // rust: n += 1;
}
}
}
    // rust: n + others.get(&p).copied().unwrap_or(0)
}
/// The tickets the other living villagers' POIs take, by POI.
    // rust: pub(super) fn others_tickets(
    // rust: m: &Mob,
    // rust: w: &MobWorld,
    // rust: ) -> crate::fast_hash::FxHashMap<[i32; 3], usize> {
    // rust: let mut taken = crate::fast_hash::FxHashMap::default();
    // rust: for o in w.others {
    // rust: if o.id != m.id && o.alive && o.species == Species::Villager {
    // rust: for q in [o.job, o.bed, o.potential_job, o.meeting]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: *taken.entry(q).or_insert(0) += 1;
}
}
}
    // rust: taken
}
/// The POIs of chunk `(qx, qz)` from `y0` to `y1` (within the world), in
/// scan order: y, then z, then x. Only the indexed POI blocks of the sections
/// are visited (`PoiManager.getInChunk`).
    // rust: fn chunk_pois(
    // rust: w: &MobWorld,
    // rust: (qx, qz): (i32, i32),
    // rust: y0: i32,
    // rust: y1: i32,
    // rust: mut visit: impl FnMut(Poi, [i32; 3]),
    // rust: ) {
    // rust: let Some(chunk) = w.world.chunks.get(&(qx, qz)) else {
    // rust: return;
}
    // rust: let kind = |state: u32| poi_of_state(w, horizon_world::registry::BlockStateId(state));
    // rust: let min = w.world.bottom_y();
    // rust: for s in (y0 - min) >> 4..=(y1 - min) >> 4 {
    // rust: let section = &chunk.sections[s as usize];
    // rust: for &(i, poi) in w.world.pois.get((qx, s, qz), section, kind).iter() {
    // rust: let i = i32::from(i);
    // rust: let y = min + s * 16 + (i >> 8);
    // rust: if (y0..=y1).contains(&y) {
    // rust: visit(poi, [qx * 16 + (i & 15), y, qz * 16 + (i >> 4 & 15)]);
}
}
}
}
/// `PoiManager.getInRange` with `HAS_SPACE`, nearest first (`distSqr` to the
/// block, ties in scan order: chunk by chunk, z then x, and y, z, x within),
/// filtered by `accept`.
    // rust: fn pois_in_range(
    // rust: m: &Mob,
    // rust: w: &MobWorld,
    // rust: f: PoiFilter,
    // rust: radius: i32,
    // rust: mut accept: impl FnMut([i32; 3]) -> bool,
    // rust: ) -> Vec<(Poi, [i32; 3])> {
    // rust: let c = block_of(m.position);
    // rust: let mut found = Vec::new();
    // Every candidate asks how taken it is: count the others' once.
    // rust: let mut taken = None;
    // rust: let r2 = i64::from(radius) * i64::from(radius);
    // rust: let (cx, cz) = (c[0] >> 4, c[2] >> 4);
    // rust: let chunks = radius.div_euclid(16) + 1;
    // rust: let y0 = (c[1] - radius).max(w.world.bottom_y());
    // rust: let y1 = (c[1] + radius).min(w.world.top_y() - 1);
    // rust: for qz in cz - chunks..=cz + chunks {
    // rust: for qx in cx - chunks..=cx + chunks {
    // rust: chunk_pois(w, (qx, qz), y0, y1, |poi, p| {
    // rust: if (p[0] - c[0]).abs() > radius
    // rust: || (p[2] - c[2]).abs() > radius
    // rust: || dist_sqr(p, c) > r2
    // rust: || !poi_matches(m, f, poi)
    // rust: || tickets(m, taken.get_or_insert_with(|| others_tickets(m, w)), p)
    // rust: >= poi.max_tickets()
    // rust: {
    // rust: return;
}
    // rust: if accept(p) {
    // rust: found.push((poi, p));
}
    // rust: });
}
}
    // rust: found.sort_by_key(|&(_, p)| dist_sqr(p, c));
    // rust: found
}
/// `PoiManager.getInRange(poiType -> true, center, radius, IS_OCCUPIED)`: the
/// POIs within `radius` of `center` that some villager holds a ticket on
/// (`taken`, from [`others_tickets`]), in scan order.
    // rust: pub(super) fn occupied_pois_in_range(
    // rust: w: &MobWorld,
    // rust: taken: &crate::fast_hash::FxHashMap<[i32; 3], usize>,
    // rust: center: [i32; 3],
    // rust: radius: i32,
    // rust: ) -> Vec<[i32; 3]> {
    // rust: let mut found = Vec::new();
    // rust: let r2 = i64::from(radius) * i64::from(radius);
    // rust: let (cx, cz) = (center[0] >> 4, center[2] >> 4);
    // rust: let chunks = radius.div_euclid(16) + 1;
    // rust: let y0 = (center[1] - radius).max(w.world.bottom_y());
    // rust: let y1 = (center[1] + radius).min(w.world.top_y() - 1);
    // rust: for qz in cz - chunks..=cz + chunks {
    // rust: for qx in cx - chunks..=cx + chunks {
    // rust: chunk_pois(w, (qx, qz), y0, y1, |_, p| {
    // rust: if (p[0] - center[0]).abs() <= radius
    // rust: && (p[2] - center[2]).abs() <= radius
    // rust: && dist_sqr(p, center) <= r2
    // rust: && taken.get(&p).is_some_and(|&n| n > 0)
    // rust: {
    // rust: found.push(p);
}
    // rust: });
}
}
    // rust: found
}
/// `PoiManager.exists(pos, predicate)`.
pub fn poi_exists(m: *Mob, w: *MobWorld, p: [i32; 3], f: PoiFilter) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: poi_at(w, p[0], p[1], p[2]).is_some_and(|poi| poi_matches(m, f, poi))
}
/// `BlockPos.closerToCenterThan(position, d)`.
    // rust: pub(super) fn closer_to_center(p: [i32; 3], at: Vec3, d: f64) -> bool {
    // rust: let c = Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: );
    // rust: c.distance_squared(at) < d * d
}
pub fn manhattan(a: [i32; 3], b: [i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (a[0] - b[0]).abs() + (a[1] - b[1]).abs() + (a[2] - b[2]).abs()
}
/// The village sections: sections holding a taken village POI.
    // rust: pub(super) fn village_sections(m: &Mob, w: &MobWorld) -> Vec<[i32; 3]> {
    // rust: let mut out = Vec::new();
    // rust: let mut add = |p: [i32; 3]| {
    // rust: let s = [p[0] >> 4, p[1] >> 4, p[2] >> 4];
    // rust: if !out.contains(&s) {
    // rust: out.push(s);
}
}
    // rust: if let Some(mm) = mem_ref(m) {
    // rust: for s in [
    // rust: &mm.job_site,
    // rust: &mm.potential_job_site,
    // rust: &mm.home,
    // rust: &mm.meeting_point,
    // rust: ] {
    // rust: if let Some(&p) = s.get()
    // rust: && poi_at(w, p[0], p[1], p[2]).is_some()
    // rust: {
    // rust: add(p);
}
}
}
    // rust: let mut villager = |o: &super::Seen| {
    // rust: if o.alive && o.species == Species::Villager {
    // rust: for p in [o.job, o.bed, o.potential_job, o.meeting]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: if poi_at(w, p[0], p[1], p[2]).is_some() {
    // rust: add(p);
}
}
}
}
    // rust: match w.others_villagers {
    // rust: Some(slots) => slots.iter().for_each(|&i| villager(&w.others[i as usize])),
    // rust: None => w.others.iter().for_each(villager),
}
    // rust: out
}
/// `PoiManager.sectionsToVillage`: the Chebyshev distance in sections to a
/// village section, at most 7.
    // rust: pub(super) fn sections_to_village(villages: &[[i32; 3]], s: [i32; 3]) -> i32 {
    // rust: villages
    // rust: .iter()
    // rust: .map(|v| {
    // rust: (v[0] - s[0])
    // rust: .abs()
    // rust: .max((v[1] - s[1]).abs())
    // rust: .max((v[2] - s[2]).abs())
    // rust: })
    // rust: .min()
    // rust: .unwrap_or(7)
    // rust: .min(7)
}

/// A memory a gate or behaviour conditions on.
pub const Mem = enum {
    VisibleBabies,
    InteractionTarget,
    BreedTarget,
    Home,
};
pub fn mem_present(m: *Mob, which: Mem) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(mm) = mem_ref(m) else { return false };
    // rust: match which {
    // rust: Mem::VisibleBabies => mm.visible_villager_babies.present(),
    // rust: Mem::InteractionTarget => mm.interaction_target.present(),
    // rust: Mem::BreedTarget => mm.breed_target.present(),
    // rust: Mem::Home => mm.home.present(),
}
}
pub fn mem_erase(m: *mut Mob, which: Mem) void {
}
    // rust: let mm = mem(m);
    // rust: match which {
    // rust: Mem::VisibleBabies => mm.visible_villager_babies.clear(),
    // rust: Mem::InteractionTarget => mm.interaction_target.clear(),
    // rust: Mem::BreedTarget => mm.breed_target.clear(),
    // rust: Mem::Home => mm.home.clear(),
}
}

/// `GateBehavior`: `RunOne` (shuffled, run one) and the ordered gates.
pub const Gate = struct {
    running: bool,
    /// Entry condition: this memory must be absent.
    absent: ?Mem,
    /// Erased when the gate stops.
    erase: ?Mem,
    shuffled: bool,
    random: LegacyRandom,
    kids: Vec<(B,
};
    // rust: impl Gate {
pub fn run_one(seed: i64, kids: Vec<(B) void {
}
    // rust: Self {
    // rust: running: false,
    // rust: absent: None,
    // rust: erase: None,
    // rust: shuffled: true,
    // rust: random: LegacyRandom::new(seed),
    // rust: kids: kids.into_iter().map(|(b, w)| (b, w, 0.0)).collect(),
}
}
pub fn ordered(seed: i64, erase: Mem, kid: B) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: running: false,
    // rust: absent: None,
    // rust: erase: Some(erase),
    // rust: shuffled: false,
    // rust: random: LegacyRandom::new(seed),
    // rust: kids: vec![(kid, 1, 0.0)],
}
}
pub fn try_start(self: *Self, m: *mut Mob, cx: *mut Bx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.absent.is_some_and(|a| mem_present(m, a)) {
    // rust: return false;
}
    // rust: self.running = true;
    // rust: if self.shuffled {
            // ShufflingList.shuffle: a fresh weight for each entry in the
            // current order, then a stable sort.
    // rust: for k in &mut self.kids {
    // rust: let r = self.random.next_float();
    // rust: k.2 = -horizon_core::jmath::pow(f64::from(r), f64::from(1.0_f32 / k.1 as f32));
}
    // rust: self.kids.sort_by(|a, b| a.2.total_cmp(&b.2));
}
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
    // rust: if let Some(e) = self.erase {
    // rust: mem_erase(m, e);
}
}
}

/// `SetEntityLookTarget`'s predicates.
pub const LookAt = enum {
    Species(Species),
    Player,
    Category(&'static str),
};
/// `InteractWith`'s targets.
pub const Interact = enum {
    Villager,
    BreedVillager,
    Cat,
};
/// The fixed behaviours whose only state is their running flag (OneShots
/// stop in the same tick).
pub const B = enum {
    Swim(Timed),
    InteractWithDoor {,
    running: bool,
    last_node: Option<PathNode>,
    cooldown: i32,
    // rust: },
    LookAtTargetSink(Timed),
    PanicTrigger(Timed),
    WakeUp(bool),
    ReactToBell(bool),
    SetRaidStatus(bool),
    ValidatePoi {,
    running: bool,
    filter: PoiFilter,
    which: PoiMem,
    // rust: },
    MoveToTargetSink {,
    t: Timed,
    cooldown: i32,
    path: Option<Path>,
    last_target: Option<[i32; 3]>,
    speed: f32,
    // rust: },
    PoiCompetitorScan(bool),
    FollowTradingPlayer(Timed),
    GoToWantedItem(bool),
    AcquirePoi {,
    running: bool,
    filter: PoiFilter,
        /// The memory filled (and checked absent): job site, home, meeting.
    poi: Poi,
    only_adult: bool,
    event: bool,
    next: i64,
    retries: Vec<([i32; 3], Retry)>,
    // rust: },
    GoToPotentialJobSite(Timed),
    YieldJobSite(bool),
    AssignProfession(bool),
    ResetProfession(bool),
    Gate(Box<Gate>),
    InteractWith {,
    running: bool,
    kind: Interact,
    // rust: },
    VillageBoundStroll {,
    running: bool,
    speed: f32,
    xz: i32,
    y: i32,
    // rust: },
    WalkToLookTarget(bool),
    JumpOnBed {,
    t: Timed,
    bed: Option<[i32; 3]>,
    time_left: i32,
    jumps: i32,
    cooldown: i32,
    // rust: },
    DoNothing(Timed),
    GiveGiftToHero {,
    t: Timed,
    until_next: i32,
    given: bool,
    started: i64,
    // rust: },
    SetLookAndInteract(bool),
    ShowTrades {,
    t: Timed,
    look_time: i32,
        /// `playerItemStack` (outer `None`: null) and `displayItems`,
        /// `cycleCounter`, `displayIndex`.
    player_item: Option<Option<std::sync::Arc<str>>>,
    items: Vec<crate::items::ItemStack>,
    cycle: i32,
    index: usize,
    // rust: },
    TradeWithVillager(Timed),
    MakeLove {,
    t: Timed,
    birth: i64,
    // rust: },
    LookAtEntity {,
    running: bool,
    what: LookAt,
    // rust: },
    UpdateActivity(bool),
    WorkAtPoi {,
    t: Timed,
    last_check: i64,
        /// `WorkAtComposter` (a farmer's package) rather than `WorkAtPoi`.
    composter: bool,
    // rust: },
    StrollAroundPoi {,
    running: bool,
    next_ok: i64,
    max_dist: i32,
    which: PoiMem,
    // rust: },
    StrollToPoi {,
    running: bool,
    next_ok: i64,
    // rust: },
    StrollToPoiList {,
    running: bool,
    next_ok: i64,
    // rust: },
    HarvestFarmland {,
    t: Timed,
    next_ok: i64,
    target: Option<[i32; 3]>,
    valid: Vec<[i32; 3]>,
    worked: i32,
    // rust: },
    UseBonemeal {,
    t: Timed,
    next_work: i64,
    last_session: i64,
    worked: i32,
    crop: Option<[i32; 3]>,
        /// The next crop is picked on the next tick, when the level shows the
        /// age the meal gave (vanilla grows the crop at once).
    repick: bool,
    // rust: },
    WalkToBlockMemory {,
    running: bool,
    which: PoiMem,
    speed: f32,
    close: i32,
    too_far: i32,
    too_long: i64,
    // rust: },
    SleepInBed {,
    t: Timed,
    next_ok: i64,
    // rust: },
    ClosestHomeAsWalkTarget {,
    running: bool,
    last_update: i64,
    cache: Vec<([i32; 3], i64)>,
    // rust: },
    InsideBrownianWalk {,
    running: bool,
    random: LegacyRandom,
    // rust: },
    GoToClosestVillage(bool),
    TriggerGate {,
    running: bool,
    random: LegacyRandom,
    kids: Vec<(B, i32, f64)>,
    // rust: },
    SocializeAtBell(bool),
    CalmDown(bool),
    WalkAwayFrom {,
    running: bool,
    hostile: bool,
    // rust: },
    RingBell(bool),
    ResetRaidStatus(bool),
    /// `BehaviorBuilder.sequence(triggerIf(raid condition), then)`.
    RaidSequence {,
    running: bool,
    victory: bool,
    then: Box<B>,
    // rust: },
    MoveToSkySeeingSpot {,
    running: bool,
    speed: f32,
    // rust: },
    Celebrate(Timed),
    LocateHidingPlace {,
    running: bool,
    radius: i32,
    speed: f32,
    close: i32,
    // rust: },
    SetHiddenState {,
    running: bool,
    hidden: i32,
    // rust: },
    PlayTag(bool),
};
/// `AcquirePoi.JitteredLinearRetry`.
pub const Retry = struct {
    previous: i64,
    next: i64,
    delay: i32,
};
    // rust: impl Retry {
pub fn new(cx: *mut Bx, now: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Retry {
    // rust: previous: 0,
    // rust: next: 0,
    // rust: delay: 0,
}
    // rust: r.mark(cx, now);
    // rust: r
}
pub fn mark(self: *Self, cx: *mut Bx, now: i64) void {
}
    // rust: self.previous = now;
    // rust: let suggested = self.delay + cx.lr.next_int_bound(40).unwrap_or(0) + 40;
    // rust: self.delay = suggested.min(400);
    // rust: self.next = now + i64::from(self.delay);
}
}

pub fn one(f: impl FnOnce() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = f();
    // rust: if r {
    // rust: *running = true;
}
    // rust: r
}

    // rust: impl B {
pub fn running(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: B::Swim(t)
    // rust: | B::LookAtTargetSink(t)
    // rust: | B::PanicTrigger(t)
    // rust: | B::FollowTradingPlayer(t)
    // rust: | B::GoToPotentialJobSite(t)
    // rust: | B::DoNothing(t)
    // rust: | B::TradeWithVillager(t)
    // rust: | B::Celebrate(t) => t.running,
    // rust: B::MoveToTargetSink { t, .. }
    // rust: | B::GiveGiftToHero { t, .. }
    // rust: | B::ShowTrades { t, .. }
    // rust: | B::WorkAtPoi { t, .. }
    // rust: | B::HarvestFarmland { t, .. }
    // rust: | B::UseBonemeal { t, .. }
    // rust: | B::JumpOnBed { t, .. }
    // rust: | B::MakeLove { t, .. }
    // rust: | B::SleepInBed { t, .. } => t.running,
    // rust: B::InteractWithDoor { running, .. }
    // rust: | B::ValidatePoi { running, .. }
    // rust: | B::AcquirePoi { running, .. }
    // rust: | B::InteractWith { running, .. }
    // rust: | B::VillageBoundStroll { running, .. }
    // rust: | B::LookAtEntity { running, .. }
    // rust: | B::StrollAroundPoi { running, .. }
    // rust: | B::StrollToPoi { running, .. }
    // rust: | B::StrollToPoiList { running, .. }
    // rust: | B::WalkToBlockMemory { running, .. }
    // rust: | B::ClosestHomeAsWalkTarget { running, .. }
    // rust: | B::InsideBrownianWalk { running, .. }
    // rust: | B::TriggerGate { running, .. }
    // rust: | B::WalkAwayFrom { running, .. }
    // rust: | B::RaidSequence { running, .. }
    // rust: | B::MoveToSkySeeingSpot { running, .. }
    // rust: | B::LocateHidingPlace { running, .. }
    // rust: | B::SetHiddenState { running, .. } => *running,
    // rust: B::WakeUp(r)
    // rust: | B::ReactToBell(r)
    // rust: | B::SetRaidStatus(r)
    // rust: | B::PoiCompetitorScan(r)
    // rust: | B::GoToWantedItem(r)
    // rust: | B::YieldJobSite(r)
    // rust: | B::AssignProfession(r)
    // rust: | B::ResetProfession(r)
    // rust: | B::WalkToLookTarget(r)
    // rust: | B::SetLookAndInteract(r)
    // rust: | B::UpdateActivity(r)
    // rust: | B::GoToClosestVillage(r)
    // rust: | B::SocializeAtBell(r)
    // rust: | B::CalmDown(r)
    // rust: | B::RingBell(r)
    // rust: | B::ResetRaidStatus(r)
    // rust: | B::PlayTag(r) => *r,
    // rust: B::Gate(g) => g.running,
}
}
    /// `OneShot` behaviours stop at their first tick.
pub fn one_shot_stop(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: B::InteractWithDoor { running, .. }
    // rust: | B::ValidatePoi { running, .. }
    // rust: | B::AcquirePoi { running, .. }
    // rust: | B::InteractWith { running, .. }
    // rust: | B::VillageBoundStroll { running, .. }
    // rust: | B::LookAtEntity { running, .. }
    // rust: | B::StrollAroundPoi { running, .. }
    // rust: | B::StrollToPoi { running, .. }
    // rust: | B::StrollToPoiList { running, .. }
    // rust: | B::WalkToBlockMemory { running, .. }
    // rust: | B::ClosestHomeAsWalkTarget { running, .. }
    // rust: | B::InsideBrownianWalk { running, .. }
    // rust: | B::TriggerGate { running, .. }
    // rust: | B::WalkAwayFrom { running, .. }
    // rust: | B::RaidSequence { running, .. }
    // rust: | B::MoveToSkySeeingSpot { running, .. }
    // rust: | B::LocateHidingPlace { running, .. }
    // rust: | B::SetHiddenState { running, .. }
    // rust: | B::GoToClosestVillage(running)
    // rust: | B::SocializeAtBell(running)
    // rust: | B::CalmDown(running)
    // rust: | B::RingBell(running)
    // rust: | B::ResetRaidStatus(running)
    // rust: | B::PlayTag(running)
    // rust: | B::WakeUp(running)
    // rust: | B::ReactToBell(running)
    // rust: | B::SetRaidStatus(running)
    // rust: | B::PoiCompetitorScan(running)
    // rust: | B::GoToWantedItem(running)
    // rust: | B::YieldJobSite(running)
    // rust: | B::AssignProfession(running)
    // rust: | B::ResetProfession(running)
    // rust: | B::WalkToLookTarget(running)
    // rust: | B::SetLookAndInteract(running)
    // rust: | B::UpdateActivity(running) => {
    // rust: *running = false;
    // rust: true
}
    // rust: _ => false,
}
}

pub fn try_start(self: *Self, m: *mut Mob, cx: *mut Bx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let now = cx.now;
    // rust: match self {
    // rust: B::Gate(g) => g.try_start(m, cx),
            // -- Behaviours with a duration.
    // rust: B::Swim(t) => {
    // rust: if !swim_condition(m) {
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
    // rust: B::PanicTrigger(t) => {
    // rust: t.begin(cx.lr, cx.now);
                // VillagerPanicTrigger.start
    // rust: if panic_condition(m) {
    // rust: if !brain_mut(m).is_active(Act::Panic) {
    // rust: let mm = mem(m);
    // rust: mm.path.clear();
    // rust: mm.walk_target.clear();
    // rust: mm.look_target.clear();
    // rust: mm.breed_target.clear();
    // rust: mm.interaction_target.clear();
}
    // rust: brain_mut(m).set_active_if_possible(Act::Panic);
}
    // rust: true
}
    // rust: B::MoveToTargetSink {
    // rust: t,
    // rust: cooldown,
    // rust: path,
    // rust: last_target,
    // rust: speed,
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
    // rust: return true;
}
    // rust: let mm = mem(m);
    // rust: mm.walk_target.clear();
    // rust: if reached {
    // rust: mm.cant_reach_walk_target_since.clear();
}
    // rust: false
}
    // rust: B::FollowTradingPlayer(t) => {
    // rust: if !follow_trading_condition(m, cx.w) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: follow_trading_player(m);
    // rust: true
}
    // rust: B::GoToPotentialJobSite(t) => {
    // rust: if !mem(m).potential_job_site.present() {
    // rust: return false;
}
    // rust: let a = brain_mut(m).activity;
    // rust: if !matches!(a, Act::Idle | Act::Work | Act::Play) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::JumpOnBed {
    // rust: t,
    // rust: bed,
    // rust: time_left,
    // rust: jumps,
    // rust: cooldown,
    // rust: } => {
    // rust: let mm = mem(m);
    // rust: let Some(nearest) = mm.nearest_bed.value() else {
    // rust: return false;
}
    // rust: if mm.walk_target.present() || !m.is_baby() {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: *bed = Some(nearest);
    // rust: *time_left = 100;
    // rust: *jumps = 3 + cx.lr.next_int_bound(4).unwrap_or(0);
    // rust: *cooldown = 0;
    // rust: mem(m).walk_target.set(WalkTarget::block(nearest, 0.5, 0));
    // rust: true
}
    // rust: B::DoNothing(t) => {
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::GiveGiftToHero {
    // rust: t,
    // rust: until_next,
    // rust: given,
    // rust: started,
    // rust: } => {
    // rust: if !mem(m).nearest_visible_player.present() {
    // rust: return false;
}
    // rust: if !hero_visible(m, cx.w) {
    // rust: return false;
}
    // rust: if *until_next > 0 {
    // rust: *until_next -= 1;
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: *given = false;
    // rust: *started = now;
    // rust: let mm = mem(m);
    // rust: mm.interaction_target.set(Who::Player);
    // rust: mm.look_target.set(Tracker::Entity(Who::Player, true));
    // rust: true
}
    // rust: B::ShowTrades {
    // rust: t,
    // rust: look_time,
    // rust: cycle,
    // rust: index,
    // rust: ..
    // rust: } => {
    // rust: if !mem(m).interaction_target.present() || !show_trades_condition(m, cx.w) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
                // start
    // rust: if let Some(target) = mem(m).interaction_target.value() {
    // rust: mem(m).look_target.set(Tracker::Entity(target, true));
}
    // rust: *cycle = 0;
    // rust: *index = 0;
    // rust: *look_time = 40;
    // rust: true
}
    // rust: B::TradeWithVillager(t) => {
    // rust: let mm = mem(m);
    // rust: if !mm.interaction_target.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: if !villager_target_valid(m, cx.w, Mem::InteractionTarget) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: let target = mem(m).interaction_target.value().unwrap();
    // rust: lock_gaze(m, target, cx);
    // rust: true
}
    // rust: B::MakeLove { t, birth } => {
    // rust: let mm = mem(m);
    // rust: if !mm.breed_target.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: if !breeding_possible(m, cx.w) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: let target = mem(m).breed_target.value().unwrap();
    // rust: lock_gaze(m, target, cx);
    // rust: *birth = now + 275 + i64::from(m.random.next_int_bound(50).unwrap_or(0));
    // rust: true
}
    // rust: B::WorkAtPoi {
    // rust: t,
    // rust: last_check,
    // rust: composter,
    // rust: } => {
    // rust: let mm = mem(m);
    // rust: let Some(site) = mm.job_site.value() else {
    // rust: return false;
}
    // rust: if now - *last_check < 300 {
    // rust: return false;
}
    // rust: if cx.lr.next_int_bound(2).unwrap_or(0) != 0 {
    // rust: return false;
}
    // rust: *last_check = now;
    // rust: if !closer_to_center(site, m.position, 1.73) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
                // start
    // rust: let mm = mem(m);
    // rust: mm.last_worked_at_poi.set(now);
    // rust: mm.look_target.set(Tracker::Block(site));
    // rust: play_work_sound(m, cx);
                // WorkAtComposter.useWorkstation, before the restock.
    // rust: if *composter {
    // rust: cx.events.push(MobEvent::WorkAtComposter {
    // rust: mob: m.id,
    // rust: pos: site,
    // rust: });
}
    // rust: restock_if_due(m, cx.w);
    // rust: true
}
    // rust: B::HarvestFarmland {
    // rust: t,
    // rust: next_ok,
    // rust: target,
    // rust: valid,
    // rust: ..
    // rust: } => {
    // rust: let mm = mem(m);
    // rust: if mm.look_target.present()
    // rust: || mm.walk_target.present()
    // rust: || !mm.secondary_job_site.present()
    // rust: {
    // rust: return false;
}
    // rust: if !cx.w.mob_griefing || !super::villager::is_farmer(m) {
    // rust: return false;
}
    // rust: *valid = farmland_around(m, cx.w);
    // rust: *target = pick_farmland(valid, cx);
    // rust: let Some(p) = *target else { return false };
    // rust: t.begin(cx.lr, cx.now);
    // rust: if now > *next_ok {
    // rust: let mm = mem(m);
    // rust: mm.look_target.set(Tracker::Block(p));
    // rust: mm.walk_target.set(WalkTarget::block(p, 0.5, 1));
}
    // rust: true
}
    // rust: B::UseBonemeal {
    // rust: t,
    // rust: next_work,
    // rust: last_session,
    // rust: worked,
    // rust: crop,
    // rust: repick,
    // rust: } => {
    // rust: let mm = mem(m);
    // rust: if mm.look_target.present() || mm.walk_target.present() {
    // rust: return false;
}
                // Checked every 10 ticks, and not within 160 ticks of the last session.
    // rust: let age = i64::from(m.age);
    // rust: if age % 10 != 0 || (*last_session != 0 && *last_session + 160 > age) {
    // rust: return false;
}
    // rust: if super::villager::ext(m).is_none_or(|e| e.count_item("minecraft:bone_meal") == 0)
    // rust: {
    // rust: return false;
}
    // rust: *crop = pick_bonemeal_crop(m, cx);
    // rust: if crop.is_none() {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: bonemeal_target(m, *crop);
    // rust: m.extra.set_main_hand(Some("minecraft:bone_meal".into()));
    // rust: *next_work = cx.now;
    // rust: *worked = 0;
    // rust: *repick = false;
    // rust: true
}
            // -- OneShots.
    // rust: B::InteractWithDoor {
    // rust: running,
    // rust: last_node,
    // rust: cooldown,
    // rust: } => {
    // rust: if !mem(m).path.present() {
    // rust: return false;
}
    // rust: let Some(path) = m.ai.nav.path.clone() else {
    // rust: return false;
}
    // rust: if path.next == 0 || path.is_done() {
    // rust: return false;
}
    // rust: let next = path.next_node();
    // rust: if *last_node == Some(next) {
    // rust: *cooldown = 20;
    // rust: } else {
    // rust: *cooldown -= 1;
    // rust: if *cooldown > 0 {
    // rust: return false;
}
}
    // rust: *last_node = Some(next);
    // rust: let from = path.nodes[path.next - 1];
    // rust: interact_with_doors(m, cx, from, next);
    // rust: *running = true;
    // rust: true
}
    // rust: B::WakeUp(r) => one(
    // rust: || {
    // rust: if !brain_mut(m).is_active(Act::Rest) && super::villager::sleeping(m) {
    // rust: super::villager::stop_sleeping(m, cx.w, cx.events);
    // rust: mem(m).last_woken.set(now);
    // rust: true
    // rust: } else {
    // rust: false
}
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::ReactToBell(r) => one(
    // rust: || {
    // rust: if !mem(m).heard_bell_time.present() {
    // rust: return false;
}
    // rust: if !super::villager::raid_nearby(m) {
    // rust: brain_mut(m).set_active_if_possible(Act::Hide);
}
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::SetRaidStatus(r) => one(
    // rust: || {
    // rust: if cx.lr.next_int_bound(20).unwrap_or(0) != 0 {
    // rust: return false;
}
    // rust: match super::villager::raid_state(m) {
    // rust: Some(true) => {
    // rust: let b = brain_mut(m);
    // rust: b.default_activity = Act::Raid;
    // rust: b.set_active_if_possible(Act::Raid);
}
    // rust: Some(false) => {
    // rust: let b = brain_mut(m);
    // rust: b.default_activity = Act::PreRaid;
    // rust: b.set_active_if_possible(Act::PreRaid);
}
    // rust: None => {}
}
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::ValidatePoi {
    // rust: running,
    // rust: filter,
    // rust: which,
    // rust: } => {
    // rust: let Some(p) = which.get(m) else { return false };
    // rust: if !closer_to_center(p, m.position, 16.0) {
    // rust: return false;
}
    // rust: if !poi_exists(m, cx.w, p, *filter) {
    // rust: which.clear(m);
    // rust: } else if cx.w.block_name(p[0], p[1], p[2]).ends_with("_bed")
    // rust: && cx.w.prop(p[0], p[1], p[2], "occupied") == Some("true")
    // rust: && !super::villager::sleeping(m)
    // rust: {
                    // ValidateNearbyPoi.bedIsOccupied: someone else sleeps there.
    // rust: which.clear(m);
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::PoiCompetitorScan(r) => one(
    // rust: || {
    // rust: let mm = mem(m);
    // rust: let (Some(site), true) = (mm.job_site.value(), mm.mobs.present()) else {
    // rust: return false;
}
    // rust: if poi_at(cx.w, site[0], site[1], site[2]).is_some() {
    // rust: let list = mem(m).mobs.value().unwrap_or_default();
    // rust: let my_xp = super::villager::xp(m);
    // rust: let mut winner_xp = my_xp;
    // rust: let mut me_winner = true;
    // rust: for who in list {
    // rust: let Who::Mob(id) = who else { continue };
    // rust: let Some(s) = cx.w.seen(id) else { continue };
    // rust: if s.species != Species::Villager || !s.alive || s.job != Some(site) {
    // rust: continue;
}
    // rust: if s.profession != m.extra.variant2 {
    // rust: continue;
}
                            // selectWinner(first, second): the second wins ties.
    // rust: if winner_xp > s.xp {
                                // The other villager loses its site (it finds out itself).
    // rust: } else {
    // rust: if me_winner {
    // rust: mem(m).job_site.clear();
}
    // rust: me_winner = false;
    // rust: winner_xp = s.xp;
}
}
}
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::GoToWantedItem(r) => one(
    // rust: || {
    // rust: let mm = mem(m);
    // rust: if mm.walk_target.present() {
    // rust: return false;
}
    // rust: let Some(at) = mm.nearest_wanted_item.value() else {
    // rust: return false;
}
                    // item.closerThan(body, 4); a villager can pick up loot.
    // rust: if m.position.distance_squared(Vec3::new(at[0], at[1], at[2])) >= 16.0 {
    // rust: return false;
}
    // rust: let mm = mem(m);
                    // The item's eye height is 0.2125.
    // rust: mm.look_target
    // rust: .set(Tracker::Point([at[0], at[1] + 0.2125, at[2]]));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Point(at),
    // rust: speed: 0.5,
    // rust: close: 0,
    // rust: });
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::AcquirePoi {
    // rust: running,
    // rust: filter,
    // rust: poi,
    // rust: only_adult,
    // rust: event,
    // rust: next,
    // rust: retries,
    // rust: } => {
    // rust: let mm = mem(m);
    // rust: let (target_present, validate_present) = match poi {
    // rust: Poi::Job(_) => (mm.potential_job_site.present(), mm.job_site.present()),
    // rust: Poi::Home => (mm.home.present(), false),
    // rust: Poi::Meeting => (mm.meeting_point.present(), false),
}
    // rust: if target_present || validate_present {
    // rust: return false;
}
    // rust: if *only_adult && m.is_baby() {
    // rust: return false;
}
    // rust: if *next == 0 {
    // rust: *next = cx.w.game_time + i64::from(cx.lr.next_int_bound(20).unwrap_or(0));
    // rust: return false;
}
    // rust: if cx.w.game_time < *next {
    // rust: return false;
}
    // rust: *next = now + 20 + i64::from(cx.lr.next_int_bound(20).unwrap_or(0));
    // rust: retries.retain(|(_, r)| now - r.previous < 400);
    // rust: let w = cx.w;
    // rust: let mut found = pois_in_range(m, w, *filter, 48, |_| true);
                // The cache test runs on every candidate, in scan order.
    // rust: let mut keep = Vec::new();
    // rust: {
    // rust: let order = pois_scan_order(m, &found);
    // rust: for idx in order {
    // rust: let p = found[idx].1;
    // rust: let ok = match retries.iter_mut().find(|(q, _)| *q == p) {
    // rust: None => true,
    // rust: Some((_, r)) => {
    // rust: if now >= r.next {
    // rust: r.mark(cx, now);
    // rust: true
    // rust: } else {
    // rust: false
}
}
}
    // rust: if ok {
    // rust: keep.push(idx);
}
}
}
    // rust: found = found
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .filter(|(i, _)| keep.contains(i))
    // rust: .map(|(_, f)| f)
    // rust: .collect();
    // rust: found.truncate(5);
    // rust: if *poi == Poi::Home {
    // rust: found.retain(|(_, p)| w.prop(p[0], p[1], p[2], "occupied") != Some("true"));
}
    // rust: let path = if found.is_empty() {
    // rust: None
    // rust: } else {
    // rust: let range = found
    // rust: .iter()
    // rust: .map(|(t, _)| t.valid_range())
    // rust: .max()
    // rust: .unwrap_or(1)
    // rust: .max(1);
    // rust: let targets: Vec<[i32; 3]> = found.iter().map(|(_, p)| *p).collect();
    // rust: m.create_path_to_any(w, &targets, range)
}
    // rust: if let Some(path) = path.filter(|p| p.reached) {
    // rust: let target = path.target;
    // rust: if poi_at(w, target[0], target[1], target[2]).is_some() {
    // rust: let mm = mem(m);
    // rust: match poi {
    // rust: Poi::Job(_) => mm.potential_job_site.set(target),
    // rust: Poi::Home => mm.home.set(target),
    // rust: Poi::Meeting => mm.meeting_point.set(target),
}
    // rust: if *event {
    // rust: happy_particles(m, cx);
}
    // rust: retries.clear();
}
    // rust: } else {
    // rust: for (_, p) in &found {
    // rust: if !retries.iter().any(|(q, _)| q == p) {
    // rust: let r = Retry::new(cx, now);
    // rust: retries.push((*p, r));
}
}
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::YieldJobSite(r) => one(
    // rust: || {
    // rust: let mm = mem(m);
    // rust: let Some(site) = mm.potential_job_site.value() else {
    // rust: return false;
}
    // rust: if mm.job_site.present() || !mm.mobs.present() {
    // rust: return false;
}
    // rust: if m.is_baby() || m.extra.variant2 != super::villager::NONE {
    // rust: return false;
}
    // rust: let Some(poi) = poi_at(cx.w, site[0], site[1], site[2]) else {
    // rust: return true;
}
    // rust: let list = mem(m).mobs.value().unwrap_or_default();
    // rust: for who in list {
    // rust: let Who::Mob(id) = who else { continue };
    // rust: let Some(s) = cx.w.seen(id) else { continue };
    // rust: if s.species != Species::Villager || !s.alive || s.potential_job.is_some() {
    // rust: continue;
}
    // rust: let Poi::Job(j) = poi else { continue };
    // rust: if s.profession != j {
    // rust: continue;
}
                        // A nearby villager of that profession takes it over.
    // rust: if s.job.is_none_or(|p| p == site) {
    // rust: let mm = mem(m);
    // rust: mm.walk_target.clear();
    // rust: mm.look_target.clear();
    // rust: mm.potential_job_site.clear();
    // rust: break;
}
}
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::AssignProfession(r) => {
    // rust: let Some(p) = mem(m).potential_job_site.value() else {
    // rust: return false;
}
    // rust: if !closer_to_center(p, m.position, 2.0) {
    // rust: return false;
}
    // rust: let mm = mem(m);
    // rust: mm.potential_job_site.clear();
    // rust: mm.job_site.set(p);
    // rust: happy_particles(m, cx);
    // rust: *r = true;
    // rust: if m.extra.variant2 != super::villager::NONE {
    // rust: return true;
}
    // rust: if let Some(Poi::Job(j)) = poi_at(cx.w, p[0], p[1], p[2]) {
    // rust: super::villager::set_profession(m, j);
    // rust: cx.refresh = true;
}
    // rust: true
}
    // rust: B::ResetProfession(r) => one(
    // rust: || {
    // rust: if mem(m).job_site.present() {
    // rust: return false;
}
    // rust: let prof = m.extra.variant2;
    // rust: let can_be_fired =
    // rust: prof != super::villager::NONE && prof != super::villager::NITWIT;
    // rust: if can_be_fired && super::villager::xp(m) == 0 && m.extra.variant3 <= 1 {
    // rust: super::villager::set_profession(m, super::villager::NONE);
    // rust: cx.refresh = true;
    // rust: true
    // rust: } else {
    // rust: false
}
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::InteractWith { running, kind } => {
    // rust: let mm = mem(m);
    // rust: if mm.walk_target.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: let kind = *kind;
    // rust: if kind == Interact::BreedVillager && !super::villager::can_breed(m) {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let valid = move |who: Who| -> bool {
    // rust: let Who::Mob(id) = who else { return false };
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: match kind {
    // rust: Interact::Villager => s.species == Species::Villager,
    // rust: Interact::BreedVillager => s.species == Species::Villager && s.in_love,
    // rust: Interact::Cat => s.species == Species::Cat,
}
}
    // rust: if find_closest(m, w, |_, who| valid(who)).is_none() {
    // rust: return false;
}
    // rust: if let Some(t) = find_closest(m, w, |m, who| {
    // rust: valid(who)
    // rust: && w.target_info(who)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) <= 64.0)
    // rust: }) {
    // rust: let mm = mem(m);
    // rust: if kind == Interact::BreedVillager {
    // rust: mm.breed_target.set(t);
    // rust: } else {
    // rust: mm.interaction_target.set(t);
}
    // rust: mm.look_target.set(Tracker::Entity(t, true));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity(t, false),
    // rust: speed: 0.5,
    // rust: close: 2,
    // rust: });
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::VillageBoundStroll {
    // rust: running,
    // rust: speed,
    // rust: xz,
    // rust: y,
    // rust: } => {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let here = block_of(m.position);
    // rust: let section = [here[0] >> 4, here[1] >> 4, here[2] >> 4];
    // rust: let villages = village_sections(m, w);
    // rust: let pos = if sections_to_village(&villages, section) <= 1 {
    // rust: m.land_random_pos(w, *xz, *y)
    // rust: } else {
    // rust: let best = closest_section(&villages, section, 2);
    // rust: if best != section {
    // rust: let to = [
    // rust: f64::from(best[0] * 16 + 8) + 0.5,
    // rust: f64::from(best[1] * 16 + 8),
    // rust: f64::from(best[2] * 16 + 8) + 0.5,
    // rust: ];
    // rust: m.default_random_pos_towards(
    // rust: w,
    // rust: *xz,
    // rust: *y,
    // rust: to,
    // rust: f64::from(std::f32::consts::FRAC_PI_2),
    // rust: )
    // rust: } else {
    // rust: m.land_random_pos(w, *xz, *y)
}
}
    // rust: mem(m)
    // rust: .walk_target
    // rust: .set_opt(pos.map(|p| WalkTarget::point(p, *speed, 0)));
    // rust: *running = true;
    // rust: true
}
    // rust: B::WalkToLookTarget(r) => one(
    // rust: || {
    // rust: let mm = mem(m);
    // rust: if mm.walk_target.present() {
    // rust: return false;
}
    // rust: let Some(look) = mm.look_target.value() else {
    // rust: return false;
}
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: look,
    // rust: speed: 0.5,
    // rust: close: 2,
    // rust: });
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::SetLookAndInteract(r) => one(
    // rust: || {
    // rust: let mm = mem(m);
    // rust: if mm.interaction_target.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let found = find_closest(m, w, |m, who| {
    // rust: who == Who::Player
    // rust: && w.target_info(who)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) <= 16.0)
    // rust: });
    // rust: let Some(t) = found else { return false };
    // rust: let mm = mem(m);
    // rust: mm.interaction_target.set(t);
    // rust: mm.look_target.set(Tracker::Entity(t, true));
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::LookAtEntity { running, what } => {
    // rust: let mm = mem(m);
    // rust: if mm.look_target.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: let what = *what;
    // rust: let w = cx.w;
    // rust: let found = find_closest(m, w, |m, who| {
    // rust: let ok = match (what, who) {
    // rust: (LookAt::Player, Who::Player) => true,
    // rust: (LookAt::Species(sp), Who::Mob(id)) => {
    // rust: w.seen(id).is_some_and(|s| s.species == sp)
}
    // rust: (LookAt::Category(c), Who::Mob(id)) => {
    // rust: w.seen(id).is_some_and(|s| s.category == c)
}
    // rust: _ => false,
}
    // rust: ok && w
    // rust: .target_info(who)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) <= 64.0)
    // rust: });
    // rust: let Some(t) = found else { return false };
    // rust: mem(m).look_target.set(Tracker::Entity(t, true));
    // rust: *running = true;
    // rust: true
}
    // rust: B::UpdateActivity(r) => {
    // rust: brain_mut(m).update_from_schedule(cx.w.game_time, cx.w.day_time);
    // rust: *r = true;
    // rust: true
}
    // rust: B::StrollAroundPoi {
    // rust: running,
    // rust: next_ok,
    // rust: max_dist,
    // rust: which,
    // rust: } => {
    // rust: let Some(site) = which.get(m) else {
    // rust: return false;
}
    // rust: if !closer_to_center(site, m.position, f64::from(*max_dist)) {
    // rust: return false;
}
    // rust: if now <= *next_ok {
    // rust: *running = true;
    // rust: return true;
}
    // rust: let pos = m.land_random_pos(cx.w, 8, 6);
    // rust: mem(m)
    // rust: .walk_target
    // rust: .set_opt(pos.map(|p| WalkTarget::point(p, 0.4, 1)));
    // rust: *next_ok = now + 180;
    // rust: *running = true;
    // rust: true
}
    // rust: B::StrollToPoi { running, next_ok } => {
    // rust: let Some(site) = mem(m).job_site.value() else {
    // rust: return false;
}
    // rust: if !closer_to_center(site, m.position, 10.0) {
    // rust: return false;
}
    // rust: if now <= *next_ok {
    // rust: *running = true;
    // rust: return true;
}
    // rust: mem(m).walk_target.set(WalkTarget::block(site, 0.4, 1));
    // rust: *next_ok = now + 80;
    // rust: *running = true;
    // rust: true
}
    // rust: B::StrollToPoiList { running, next_ok } => {
    // rust: let mm = mem(m);
    // rust: let (Some(list), Some(site)) = (mm.secondary_job_site.value(), mm.job_site.value())
    // rust: else {
    // rust: return false;
}
    // rust: if list.is_empty() {
    // rust: return false;
}
    // rust: let target = list[cx.lr.next_int_bound(list.len() as i32).unwrap_or(0) as usize];
    // rust: if !closer_to_center(site, m.position, 6.0) {
    // rust: return false;
}
    // rust: if now > *next_ok {
    // rust: mem(m).walk_target.set(WalkTarget::block(target, 0.5, 1));
    // rust: *next_ok = now + 100;
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::WalkToBlockMemory {
    // rust: running,
    // rust: which,
    // rust: speed,
    // rust: close,
    // rust: too_far,
    // rust: too_long,
    // rust: } => {
    // rust: let r = walk_to_block_memory(m, cx, *which, *speed, *close, *too_far, *too_long);
    // rust: *running = r;
    // rust: r
}
    // rust: B::SleepInBed { t, next_ok } => {
    // rust: if m.extra.mount.is_some() {
    // rust: return false;
}
    // rust: let mm = mem(m);
    // rust: let Some(home) = mm.home.value() else {
    // rust: return false;
}
    // rust: if let Some(woken) = mm.last_woken.value() {
    // rust: let since = cx.w.game_time - woken;
    // rust: if since > 0 && since < 100 {
    // rust: return false;
}
}
    // rust: let w = cx.w;
    // rust: if !(closer_to_center(home, m.position, 2.0)
    // rust: && w.block_name(home[0], home[1], home[2]).ends_with("_bed")
    // rust: && w.prop(home[0], home[1], home[2], "occupied") != Some("true"))
    // rust: {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: if now > *next_ok {
    // rust: close_doors(m, cx, None, None);
    // rust: if super::villager::start_sleeping(m, home, w, cx.events) {
    // rust: mem(m).last_slept.set(now);
}
    // rust: let mm = mem(m);
    // rust: mm.walk_target.clear();
    // rust: mm.cant_reach_walk_target_since.clear();
}
    // rust: true
}
    // rust: B::ClosestHomeAsWalkTarget {
    // rust: running,
    // rust: last_update,
    // rust: cache,
    // rust: } => {
    // rust: let mm = mem(m);
    // rust: if mm.walk_target.present() || mm.home.present() {
    // rust: return false;
}
    // rust: if cx.w.game_time - *last_update < 20 {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let here = block_of(m.position);
    // rust: let homes = homes_in_range(m, w, 48);
    // rust: let Some(closest) = homes.iter().min_by_key(|p| dist_sqr(**p, here)).copied()
    // rust: else {
    // rust: return false;
}
    // rust: if dist_sqr(closest, here) <= 4 {
    // rust: return false;
}
    // rust: let mut tried = 0;
    // rust: *last_update = cx.w.game_time + i64::from(cx.lr.next_int_bound(20).unwrap_or(0));
    // rust: let mut targets = Vec::new();
    // rust: for p in homes {
    // rust: if cache.iter().any(|(q, _)| *q == p) {
    // rust: continue;
}
    // rust: tried += 1;
    // rust: if tried >= 5 {
    // rust: continue;
}
    // rust: cache.push((p, *last_update + 40));
    // rust: targets.push(p);
}
    // rust: let path = if targets.is_empty() {
    // rust: None
    // rust: } else {
    // rust: m.create_path_to_any(w, &targets, 1)
}
    // rust: if let Some(path) = path.filter(|p| p.reached) {
    // rust: mem(m)
    // rust: .walk_target
    // rust: .set(WalkTarget::block(path.target, 0.5, 1));
    // rust: } else if tried < 5 {
    // rust: let limit = *last_update;
    // rust: cache.retain(|(_, until)| *until >= limit);
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::InsideBrownianWalk { running, random } => {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let here = block_of(m.position);
    // rust: if w.can_see_sky(here[0], here[1], here[2]) {
    // rust: return false;
}
    // rust: let mut poses = Vec::new();
    // rust: for z in -1..=1 {
    // rust: for y in -1..=1 {
    // rust: for x in -1..=1 {
    // rust: poses.push([here[0] + x, here[1] + y, here[2] + z]);
}
}
}
                // Collections.shuffle (its own random).
    // rust: for i in (1..poses.len()).rev() {
    // rust: let j = random.next_int_bound(i as i32 + 1).unwrap_or(0) as usize;
    // rust: poses.swap(i, j);
}
    // rust: if let Some(p) = poses
    // rust: .into_iter()
    // rust: .find(|p| !w.can_see_sky(p[0], p[1], p[2]) && w.solid(p[0], p[1], p[2]))
    // rust: {
    // rust: mem(m).walk_target.set(WalkTarget::block(p, 0.5, 0));
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::GoToClosestVillage(r) => {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let villages = village_sections(m, w);
    // rust: let section_of = |p: [i32; 3]| [p[0] >> 4, p[1] >> 4, p[2] >> 4];
    // rust: let here = sections_to_village(&villages, section_of(block_of(m.position)));
    // rust: if here <= 1 {
    // rust: return false;
}
    // rust: let mut target = None;
    // rust: for _ in 0..5 {
    // rust: let pos = m.land_random_pos_scored(w, 15, 7, |p| {
    // rust: -f64::from(sections_to_village(&villages, section_of(p)))
    // rust: });
    // rust: if let Some(p) = pos {
    // rust: let b = [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ];
    // rust: let d = sections_to_village(&villages, section_of(b));
    // rust: if d < here {
    // rust: target = Some(p);
    // rust: break;
}
    // rust: if d == here {
    // rust: target = Some(p);
}
}
}
    // rust: if let Some(p) = target {
    // rust: mem(m).walk_target.set(WalkTarget::point(p, 0.5, 4));
}
    // rust: *r = true;
    // rust: true
}
    // rust: B::TriggerGate {
    // rust: running,
    // rust: random,
    // rust: kids,
    // rust: } => {
    // rust: for k in kids.iter_mut() {
    // rust: let r = random.next_float();
    // rust: k.2 = -horizon_core::jmath::pow(f64::from(r), f64::from(1.0_f32 / k.1 as f32));
}
    // rust: kids.sort_by(|a, b| a.2.total_cmp(&b.2));
    // rust: for k in kids.iter_mut() {
    // rust: let fired = k.0.try_start(m, cx);
    // rust: k.0.one_shot_stop();
    // rust: if fired {
    // rust: break;
}
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::SocializeAtBell(r) => one(
    // rust: || {
    // rust: let mm = mem(m);
    // rust: let Some(bell) = mm.meeting_point.value() else {
    // rust: return false;
}
    // rust: if !mm.visible_mobs.present() || mm.interaction_target.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let is_villager = |who: Who| matches!(who, Who::Mob(id) if w.seen(id).is_some_and(|s| s.species == Species::Villager));
    // rust: if cx.lr.next_int_bound(100).unwrap_or(1) != 0
    // rust: || !closer_to_center(bell, m.position, 4.0)
    // rust: || find_closest(m, w, |_, who| is_villager(who)).is_none()
    // rust: {
    // rust: return false;
}
    // rust: if let Some(t) = find_closest(m, w, |m, who| {
    // rust: is_villager(who)
    // rust: && w.target_info(who)
    // rust: .is_some_and(|i| i.position.distance_squared(m.position) <= 32.0)
    // rust: }) {
    // rust: let mm = mem(m);
    // rust: mm.interaction_target.set(t);
    // rust: mm.look_target.set(Tracker::Entity(t, true));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity(t, false),
    // rust: speed: 0.3,
    // rust: close: 1,
    // rust: });
}
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::CalmDown(r) => {
    // rust: let w = cx.w;
    // rust: let mm = mem(m);
    // rust: let scared = mm.hurt_by.present()
    // rust: || mm.nearest_hostile.present()
    // rust: || mm.hurt_by_entity.value().is_some_and(|e| {
    // rust: w.target_info(e)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) <= 36.0)
    // rust: });
    // rust: if !scared {
    // rust: let mm = mem(m);
    // rust: mm.hurt_by.clear();
    // rust: mm.hurt_by_entity.clear();
    // rust: brain_mut(m).update_from_schedule(w.game_time, w.day_time);
}
    // rust: *r = true;
    // rust: true
}
    // rust: B::WalkAwayFrom { running, hostile } => {
    // rust: let w = cx.w;
    // rust: let mm = mem(m);
    // rust: let from = if *hostile {
    // rust: mm.nearest_hostile.value()
    // rust: } else {
    // rust: mm.hurt_by_entity.value()
}
    // rust: let Some(from) = from else { return false };
    // rust: if mm.walk_target.present() {
    // rust: return false;
}
    // rust: let Some(avoid) = w.target_info(from).map(|t| t.position) else {
    // rust: return false;
}
    // rust: if m.position.distance_squared(avoid) >= 36.0 {
    // rust: return false;
}
    // rust: for _ in 0..10 {
    // rust: if let Some(p) = m.land_random_pos_away(w, 16, 7, [avoid.x, avoid.y, avoid.z]) {
    // rust: mem(m).walk_target.set(WalkTarget::point(p, 0.75, 0));
    // rust: break;
}
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::RingBell(r) => one(
    // rust: || {
    // rust: let Some(bell) = mem(m).meeting_point.value() else {
    // rust: return false;
}
    // rust: if cx.lr.next_float() <= 0.95 {
    // rust: return false;
}
    // rust: if dist_sqr(bell, block_of(m.position)) < 9
    // rust: && cx.w.block_name(bell[0], bell[1], bell[2]) == "minecraft:bell"
    // rust: {
    // rust: cx.events.push(MobEvent::RingBell { bell });
}
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::ResetRaidStatus(r) => one(
    // rust: || {
    // rust: if cx.lr.next_int_bound(20).unwrap_or(0) != 0 {
    // rust: return false;
}
    // rust: if super::villager::raid_over_or_lost(m) {
    // rust: let b = brain_mut(m);
    // rust: b.default_activity = Act::Idle;
    // rust: b.update_from_schedule(cx.w.game_time, cx.w.day_time);
}
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
    // rust: B::RaidSequence {
    // rust: running,
    // rust: victory,
    // rust: then,
    // rust: } => {
    // rust: let state = super::villager::raid_status(m);
    // rust: let ok = if *victory {
    // rust: state == super::villager::RAID_VICTORY
    // rust: } else {
    // rust: state == super::villager::RAID || state == super::villager::PRE_RAID
}
    // rust: if !ok {
    // rust: return false;
}
    // rust: let fired = then.try_start(m, cx);
    // rust: then.one_shot_stop();
    // rust: *running = fired;
    // rust: fired
}
    // rust: B::MoveToSkySeeingSpot { running, speed } => {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let here = block_of(m.position);
    // rust: if w.can_see_sky(here[0], here[1], here[2]) {
    // rust: return false;
}
    // rust: for _ in 0..10 {
    // rust: let p = [
    // rust: here[0] + m.random.next_int_bound(20).unwrap_or(0) - 10,
    // rust: here[1] + m.random.next_int_bound(6).unwrap_or(0) - 3,
    // rust: here[2] + m.random.next_int_bound(20).unwrap_or(0) - 10,
    // rust: ];
    // rust: if no_blocks_above(m, w, p) {
    // rust: mem(m).walk_target.set(WalkTarget::block(p, *speed, 0));
    // rust: break;
}
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::Celebrate(t) => {
    // rust: let here = block_of(m.position);
    // rust: if super::villager::raid_status(m) != super::villager::RAID_VICTORY
    // rust: || !no_blocks_above(m, cx.w, here)
    // rust: {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::LocateHidingPlace {
    // rust: running,
    // rust: radius,
    // rust: speed,
    // rust: close,
    // rust: } => {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let near = homes_in_range(m, w, *close + 1)
    // rust: .into_iter()
    // rust: .next()
    // rust: .filter(|p| closer_to_center(*p, m.position, f64::from(*close)));
    // rust: let place = near
    // rust: .or_else(|| {
    // rust: let mut all = homes_in_range(m, w, *radius);
                        // Util.toShuffledList with the mob's random.
    // rust: for i in (2..=all.len()).rev() {
    // rust: let j = m.random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: all.swap(i - 1, j);
}
    // rust: all.into_iter().next()
    // rust: })
    // rust: .or_else(|| mem(m).home.value());
    // rust: if let Some(p) = place {
    // rust: let far = !closer_to_center(p, m.position, f64::from(*close));
    // rust: let mm = mem(m);
    // rust: mm.path.clear();
    // rust: mm.look_target.clear();
    // rust: mm.breed_target.clear();
    // rust: mm.interaction_target.clear();
    // rust: mm.hiding_place.set(p);
    // rust: if far {
    // rust: mm.walk_target.set(WalkTarget::block(p, *speed, *close));
}
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::SetHiddenState { running, hidden } => {
    // rust: let mm = mem(m);
    // rust: let (Some(place), Some(heard)) =
    // rust: (mm.hiding_place.value(), mm.heard_bell_time.value())
    // rust: else {
    // rust: return false;
}
    // rust: let timed_out = heard + 300 <= now;
    // rust: if *hidden <= 300 && !timed_out {
    // rust: if dist_sqr(place, block_of(m.position)) < 9 {
    // rust: *hidden += 1;
}
    // rust: } else {
    // rust: let mm = mem(m);
    // rust: mm.heard_bell_time.clear();
    // rust: mm.hiding_place.clear();
    // rust: brain_mut(m).update_from_schedule(cx.w.game_time, cx.w.day_time);
    // rust: *hidden = 0;
}
    // rust: *running = true;
    // rust: true
}
    // rust: B::PlayTag(r) => one(
    // rust: || {
    // rust: let mm = mem(m);
    // rust: let Some(friends) = mm.visible_villager_babies.value() else {
    // rust: return false;
}
    // rust: if mm.walk_target.present() {
    // rust: return false;
}
    // rust: if cx.lr.next_int_bound(10).unwrap_or(0) != 0 {
    // rust: return false;
}
                    // What a friend chases is its INTERACTION_TARGET.
    // rust: let chasing = |who: Who| match who {
    // rust: Who::Mob(id) => {
    // rust: cx.w.seen(id)
    // rust: .and_then(|s| s.villager.as_ref())
    // rust: .and_then(|v| v.interaction_target)
}
    // rust: Who::Player => None,
}
    // rust: let me = Who::Mob(m.id);
    // rust: if !friends.iter().any(|&f| chasing(f) == Some(me)) {
                        // The kid chased by the fewest (one to five) chasers, else any friend.
    // rust: let mut chased: Vec<(Who, i32)> = Vec::new();
    // rust: for &f in &friends {
    // rust: if let Some(c) = chasing(f) {
    // rust: match chased.iter_mut().find(|(k, _)| *k == c) {
    // rust: Some(e) => e.1 += 1,
    // rust: None => chased.push((c, 1)),
}
}
}
    // rust: let target = chased
    // rust: .iter()
    // rust: .filter(|(_, n)| *n > 0 && *n <= 5)
    // rust: .min_by_key(|(_, n)| *n)
    // rust: .map(|&(k, _)| k)
    // rust: .or_else(|| friends.first().copied());
    // rust: if let Some(kid) = target {
    // rust: let mm = mem(m);
    // rust: mm.interaction_target.set(kid);
    // rust: mm.look_target.set(Tracker::Entity(kid, true));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity(kid, false),
    // rust: speed: 0.6,
    // rust: close: 1,
    // rust: });
}
    // rust: } else {
                        // Chased: run to a spot inside the village.
    // rust: let villages = village_sections(m, cx.w);
    // rust: for _ in 0..10 {
    // rust: let Some(p) = m.land_random_pos(cx.w, 20, 8) else {
    // rust: continue;
}
    // rust: let at = [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ];
    // rust: let section = [at[0] >> 4, at[1] >> 4, at[2] >> 4];
    // rust: if sections_to_village(&villages, section) <= 1 {
    // rust: mem(m).walk_target.set(WalkTarget::point(p, 0.6, 0));
    // rust: break;
}
}
}
    // rust: true
    // rust: },
    // rust: r,
    // rust: ),
}
}

pub fn tick_or_stop(self: *Self, m: *mut Mob, cx: *mut Bx) void {
}
    // rust: if self.one_shot_stop() {
    // rust: return;
}
    // rust: let now = cx.now;
    // rust: match self {
    // rust: B::Gate(g) => g.tick_or_stop(m, cx),
    // rust: B::Swim(t) => {
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
    // rust: B::PanicTrigger(t) => {
    // rust: if now > t.end || !panic_condition(m) {
    // rust: self.do_stop(m, cx);
    // rust: } else if now % 100 == 0 {
    // rust: cx.events.push(MobEvent::GolemCheck {
    // rust: mob: m.id,
    // rust: needed: 3,
    // rust: });
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
                // tick
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
    // rust: B::FollowTradingPlayer(_) => {
    // rust: if !follow_trading_condition(m, cx.w) {
    // rust: self.do_stop(m, cx);
    // rust: } else {
    // rust: follow_trading_player(m);
}
}
    // rust: B::GoToPotentialJobSite(t) => {
    // rust: let site = mem(m).potential_job_site.value();
    // rust: if now > t.end || site.is_none() {
    // rust: self.do_stop(m, cx);
    // rust: } else if let Some(p) = site {
    // rust: let mm = mem(m);
    // rust: mm.look_target.set(Tracker::Block(p));
    // rust: mm.walk_target.set(WalkTarget::block(p, 0.5, 1));
}
}
    // rust: B::JumpOnBed {
    // rust: bed,
    // rust: time_left,
    // rust: jumps,
    // rust: cooldown,
    // rust: ..
    // rust: } => {
    // rust: let w = cx.w;
    // rust: let here = block_of(m.position);
    // rust: let jumpable = |p: [i32; 3]| w.block_name(p[0], p[1], p[2]).ends_with("_bed");
    // rust: let on_or_over = jumpable(here) || jumpable([here[0], here[1] - 1, here[2]]);
    // rust: let still = m.is_baby()
    // rust: && bed.is_some_and(jumpable)
    // rust: && (on_or_over || *time_left > 0)
    // rust: && (!on_or_over || *jumps > 0);
    // rust: if !still {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: if !on_or_over {
    // rust: *time_left -= 1;
    // rust: } else if *cooldown > 0 {
    // rust: *cooldown -= 1;
    // rust: } else if jumpable(here) {
    // rust: m.ai.jump = true;
    // rust: *jumps -= 1;
    // rust: *cooldown = 5;
}
}
    // rust: B::DoNothing(t) => {
    // rust: if now > t.end {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::GiveGiftToHero {
    // rust: t, given, started, ..
    // rust: } => {
    // rust: if now > t.end || !hero_visible(m, cx.w) || *given {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: let Some(p) = cx.w.player.clone() else { return };
    // rust: mem(m).look_target.set(Tracker::Entity(Who::Player, true));
    // rust: let close = {
    // rust: let a = block_of(p.position);
    // rust: let b = block_of(m.position);
    // rust: let d = (a[0] - b[0]).pow(2) + (a[1] - b[1]).pow(2) + (a[2] - b[2]).pow(2);
    // rust: f64::from(d) < 25.0
}
    // rust: if close {
    // rust: if now - *started > 20 {
    // rust: cx.events.push(MobEvent::ThrowGift {
    // rust: table: super::villager::gift_table(m),
    // rust: from: [m.position.x, m.eye_y() - 0.3, m.position.z],
    // rust: to: [p.position.x, p.position.y, p.position.z],
    // rust: });
    // rust: *given = true;
}
    // rust: } else {
    // rust: let mm = mem(m);
    // rust: mm.look_target.set(Tracker::Entity(Who::Player, true));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity(Who::Player, true),
    // rust: speed: 0.5,
    // rust: close: 5,
    // rust: });
}
}
    // rust: B::ShowTrades {
    // rust: t,
    // rust: look_time,
    // rust: player_item,
    // rust: items,
    // rust: cycle,
    // rust: index,
    // rust: } => {
    // rust: let still = show_trades_condition(m, cx.w)
    // rust: && *look_time > 0
    // rust: && mem(m).interaction_target.present();
    // rust: if now > t.end || !still {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: if let Some(target) = mem(m).interaction_target.value() {
    // rust: mem(m).look_target.set(Tracker::Entity(target, true));
}
                // findItemsToDisplay: the trades the player's item pays for.
    // rust: let current = cx.w.player.as_ref().and_then(|p| p.main_hand.clone());
                // getOffers makes the trades on first use: the level rolls
                // them, and the cost is compared from the next tick on.
    // rust: let unset = m.extra.trade.as_ref().is_none_or(|t| t.unset);
    // rust: if current.is_some() && unset {
    // rust: cx.events.push(MobEvent::VillagerOffers { mob: m.id });
    // rust: } else if player_item.as_ref() != Some(&current) {
    // rust: *player_item = Some(current.clone());
    // rust: items.clear();
    // rust: if let Some(held) = &current {
    // rust: if let Some(trade) = &m.extra.trade {
    // rust: for offer in &trade.offers {
    // rust: if !offer.out_of_stock()
    // rust: && (offer.base_cost_a.stack.item == *held
    // rust: || offer
    // rust: .cost_b
    // rust: .as_ref()
    // rust: .is_some_and(|c| c.stack.item == *held))
    // rust: {
    // rust: items.push(offer.result.clone());
}
}
}
    // rust: if let Some(first) = items.first() {
    // rust: *look_time = 900;
    // rust: m.extra.set_main_hand_stack(Some(first.clone()));
}
}
}
    // rust: if !items.is_empty() {
                    // displayCyclingItems
    // rust: if items.len() >= 2 {
    // rust: *cycle += 1;
    // rust: if *cycle >= 40 {
    // rust: *index += 1;
    // rust: *cycle = 0;
    // rust: if *index > items.len() - 1 {
    // rust: *index = 0;
}
    // rust: m.extra.set_main_hand_stack(Some(items[*index].clone()));
}
}
    // rust: } else {
                    // clearHeldItem; no offer matches: look for a while only.
    // rust: m.extra.set_main_hand(None);
    // rust: *look_time = (*look_time).min(40);
}
    // rust: *look_time -= 1;
}
    // rust: B::TradeWithVillager(t) => {
    // rust: if now > t.end || !villager_target_valid(m, cx.w, Mem::InteractionTarget) {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: if let Some(target) = mem(m).interaction_target.value()
    // rust: && let Some(i) = cx.w.target_info(target)
    // rust: && i.position.distance_squared(m.position) <= 5.0
    // rust: {
    // rust: let Who::Mob(other) = target else { return };
    // rust: lock_gaze(m, target, cx);
    // rust: cx.events.push(MobEvent::VillagerMeet { mob: m.id, other });
}
}
    // rust: B::MakeLove { birth, .. } => {
    // rust: if now > *birth || !breeding_possible(m, cx.w) {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: let Some(target) = mem(m).breed_target.value() else {
    // rust: return;
}
    // rust: let Who::Mob(partner) = target else { return };
    // rust: if cx
    // rust: .w
    // rust: .target_info(target)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) <= 5.0)
    // rust: {
    // rust: lock_gaze(m, target, cx);
    // rust: if now >= *birth {
                        // The parent's half happens in its own tick: it eats,
                        // takes a bed for the child, picks its type and rests.
    // rust: super::villager::ext_mut(m).eat_and_digest();
    // rust: let child = take_bed_for_child(m, cx.w).map(|bed| {
                            // Villager.getBreedOffspring: half the biome's type,
                            // a quarter each parent's.
    // rust: let roll = m.random.next_double();
    // rust: let variant = if roll < 0.5 {
    // rust: None
    // rust: } else if roll < 0.75 {
    // rust: Some(m.extra.variant)
    // rust: } else {
    // rust: Some(cx.w.seen(partner).map_or(m.extra.variant, |s| s.variant))
}
    // rust: m.extra.age = 6000;
    // rust: (bed, variant)
    // rust: });
    // rust: cx.events.push(MobEvent::VillagerBirth {
    // rust: parent: m.id,
    // rust: partner,
    // rust: child,
    // rust: });
    // rust: } else if m.random.next_int_bound(35).unwrap_or(1) == 0 {
                        // Entity event 12 for the partner, then this villager:
                        // AbstractVillager.addParticlesAroundSelf(HEART).
    // rust: let mut bodies = Vec::new();
    // rust: if let Some(t) = cx.w.target_info(target) {
    // rust: let (min, max) = (t.bounds.min_position(), t.bounds.max_position());
    // rust: bodies.push((partner, t.position, max.x - min.x, max.y - min.y));
}
    // rust: bodies.push((
    // rust: m.id,
    // rust: m.position,
    // rust: f64::from(m.width()),
    // rust: f64::from(m.height()),
    // rust: ));
    // rust: for (mob, feet, width, height) in bodies {
    // rust: cx.events.push(MobEvent::AroundSelf {
    // rust: mob,
    // rust: event: 12,
    // rust: kind: "heart",
    // rust: feet: [feet.x, feet.y, feet.z],
    // rust: width,
    // rust: height,
    // rust: burst: crate::particles::Burst::VILLAGER,
    // rust: });
}
}
}
}
    // rust: B::WorkAtPoi { t, .. } => {
    // rust: let still = mem(m)
    // rust: .job_site
    // rust: .value()
    // rust: .is_some_and(|site| closer_to_center(site, m.position, 1.73));
    // rust: if now > t.end || !still {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::HarvestFarmland {
    // rust: t,
    // rust: next_ok,
    // rust: target,
    // rust: valid,
    // rust: worked,
    // rust: } => {
    // rust: if now > t.end || *worked >= 200 {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: if target.is_none_or(|p| closer_to_center(p, m.position, 1.0)) {
    // rust: harvest_tick(m, cx, next_ok, target, valid);
    // rust: *worked += 1;
}
}
    // rust: B::SleepInBed { .. } => {
    // rust: let still = mem(m).home.value().is_some_and(|bed| {
    // rust: brain_mut(m).is_active(Act::Rest)
    // rust: && m.position.y > f64::from(bed[1]) + 0.4
    // rust: && closer_to_center(bed, m.position, 1.14)
    // rust: });
    // rust: if !still {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::Celebrate(t) => {
    // rust: if now > t.end || !super::villager::raid_nearby(m) {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: if m.random.next_int_bound(100).unwrap_or(1) == 0 {
    // rust: m.voice("entity.villager.celebrate", cx.events);
}
    // rust: if m.random.next_int_bound(200).unwrap_or(1) == 0
    // rust: && no_blocks_above(m, cx.w, block_of(m.position))
    // rust: {
    // rust: let color = m.random.next_int_bound(16).unwrap_or(0) as usize;
    // rust: let flight = m.random.next_int_bound(3).unwrap_or(0) as u8;
    // rust: cx.events.push(MobEvent::Firework {
    // rust: at: [m.position.x, m.eye_y(), m.position.z],
    // rust: color,
    // rust: flight,
    // rust: });
}
}
    // rust: B::UseBonemeal {
    // rust: t,
    // rust: next_work,
    // rust: worked,
    // rust: crop,
    // rust: repick,
    // rust: ..
    // rust: } => {
    // rust: if *repick {
    // rust: *repick = false;
    // rust: *crop = pick_bonemeal_crop(m, cx);
    // rust: bonemeal_target(m, *crop);
}
                // canStillUse: fewer than 80 work cycles and a crop to work on.
    // rust: if now > t.end || *worked >= 80 || crop.is_none() {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: let Some(p) = *crop else { return };
    // rust: if now >= *next_work && closer_to_center(p, m.position, 1.0) {
    // rust: let e = super::villager::ext_mut(m);
                    // BoneMealItem.growCrop: a CropBlock below max age takes the meal.
    // rust: if let Some(slot) = e
    // rust: .inventory
    // rust: .iter()
    // rust: .position(|s| s.count > 0 && &*s.item == "minecraft:bone_meal")
    // rust: && bonemeal_valid(cx.w, p)
    // rust: {
    // rust: e.inventory[slot].count -= 1;
    // rust: if e.inventory[slot].count == 0 {
    // rust: e.inventory.remove(slot);
}
    // rust: cx.events.push(MobEvent::Bonemeal { pos: p });
    // rust: *repick = true;
    // rust: *next_work = now + 40;
}
    // rust: *worked += 1;
}
}
    // rust: _ => {}
}
}

pub fn do_stop(self: *Self, m: *mut Mob, cx: *mut Bx) void {
}
    // rust: if self.one_shot_stop() {
    // rust: return;
}
    // rust: let now = cx.now;
    // rust: match self {
    // rust: B::Gate(g) => g.do_stop(m, cx),
    // rust: B::Swim(t) | B::PanicTrigger(t) | B::DoNothing(t) => t.running = false,
    // rust: B::JumpOnBed {
    // rust: t,
    // rust: bed,
    // rust: time_left,
    // rust: jumps,
    // rust: cooldown,
    // rust: } => {
    // rust: t.running = false;
    // rust: *bed = None;
    // rust: *time_left = 0;
    // rust: *jumps = 0;
    // rust: *cooldown = 0;
}
    // rust: B::SleepInBed { t, next_ok } => {
    // rust: t.running = false;
    // rust: if super::villager::sleeping(m) {
    // rust: super::villager::stop_sleeping(m, cx.w, cx.events);
    // rust: mem(m).last_woken.set(now);
    // rust: *next_ok = now + 40;
}
}
    // rust: B::Celebrate(t) => {
    // rust: t.running = false;
    // rust: brain_mut(m).update_from_schedule(cx.w.game_time, cx.w.day_time);
}
    // rust: B::LookAtTargetSink(t) => {
    // rust: t.running = false;
    // rust: mem(m).look_target.clear();
}
    // rust: B::MoveToTargetSink {
    // rust: t, cooldown, path, ..
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
}
    // rust: B::FollowTradingPlayer(t) => {
    // rust: t.running = false;
    // rust: let mm = mem(m);
    // rust: mm.walk_target.clear();
    // rust: mm.look_target.clear();
}
    // rust: B::GoToPotentialJobSite(t) => {
    // rust: t.running = false;
    // rust: mem(m).potential_job_site.clear();
}
    // rust: B::GiveGiftToHero { t, until_next, .. } => {
    // rust: t.running = false;
    // rust: *until_next = 600 + cx.lr.next_int_bound(6001).unwrap_or(0);
    // rust: let mm = mem(m);
    // rust: mm.interaction_target.clear();
    // rust: mm.walk_target.clear();
    // rust: mm.look_target.clear();
}
    // rust: B::ShowTrades { t, player_item, .. } => {
    // rust: t.running = false;
    // rust: mem(m).interaction_target.clear();
                // clearHeldItem
    // rust: m.extra.set_main_hand(None);
    // rust: *player_item = None;
}
    // rust: B::TradeWithVillager(t) => {
    // rust: t.running = false;
    // rust: mem(m).interaction_target.clear();
}
    // rust: B::MakeLove { t, .. } => {
    // rust: t.running = false;
    // rust: mem(m).breed_target.clear();
}
    // rust: B::UseBonemeal {
    // rust: t, last_session, ..
    // rust: } => {
    // rust: t.running = false;
    // rust: m.extra.set_main_hand(None);
    // rust: *last_session = i64::from(m.age);
}
    // rust: B::WorkAtPoi { t, .. } => t.running = false,
    // rust: B::HarvestFarmland {
    // rust: t, next_ok, worked, ..
    // rust: } => {
    // rust: t.running = false;
    // rust: *worked = 0;
    // rust: let mm = mem(m);
    // rust: mm.look_target.clear();
    // rust: mm.walk_target.clear();
    // rust: *next_ok = now + 40;
}
    // rust: _ => {}
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
/// `Swim`: deeper than the jump threshold, or in lava.
pub fn swim_condition(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.fluids.water > m.fluid_jump_threshold() || m.fluids.in_lava
}
pub fn panic_condition(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mem_ref(m).is_some_and(|mm| mm.hurt_by.present() || mm.nearest_hostile.present())
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
/// `MoveToTargetSink.reachedTarget`.
    // rust: pub(super) fn reached(m: &Mob, w: &MobWorld, walk: &WalkTarget) -> bool {
    // rust: walk.target
    // rust: .block(w)
    // rust: .is_some_and(|p| manhattan(p, block_of(m.position)) <= walk.close)
}
/// `MoveToTargetSink.tryComputePath`, for the brains on these memories
/// (villager, monster, warden): `cant_reach` is the brain's
/// `CANT_REACH_WALK_TARGET_SINCE`.
    // rust: pub(super) fn compute_path(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: now: i64,
    // rust: walk: &WalkTarget,
    // rust: path: &mut Option<Path>,
    // rust: speed: &mut f32,
    // rust: cant_reach: fn(&mut Mob) -> &mut Slot<i64>,
    // rust: ) -> bool {
    // rust: let Some(target) = walk.target.block(w) else {
    // rust: return false;
}
    // rust: *path = m.create_path_to(w, target, 0);
    // rust: *speed = walk.speed;
    // rust: if reached(m, w, walk) {
    // rust: cant_reach(m).clear();
    // rust: } else {
    // rust: let can_reach = path.as_ref().is_some_and(|p| p.reached);
    // rust: let since = cant_reach(m);
    // rust: if can_reach {
    // rust: since.clear();
    // rust: } else if !since.present() {
    // rust: since.set(now);
}
    // rust: if path.is_some() {
    // rust: return true;
}
    // rust: let to = [
    // rust: f64::from(target[0]) + 0.5,
    // rust: f64::from(target[1]),
    // rust: f64::from(target[2]) + 0.5,
    // rust: ];
    // rust: if let Some(step) =
    // rust: m.default_random_pos_towards(w, 10, 7, to, f64::from(std::f32::consts::FRAC_PI_2))
    // rust: {
    // rust: let p = [
    // rust: step[0].floor() as i32,
    // rust: step[1].floor() as i32,
    // rust: step[2].floor() as i32,
    // rust: ];
    // rust: *path = m.create_path_to(w, p, 0);
    // rust: return path.is_some();
}
}
    // rust: false
}
/// `LookAndFollowTradingPlayerSink.checkExtraStartConditions`.
pub fn follow_trading_condition(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.flag2
    // rust: && m.alive()
    // rust: && !m.fluids.in_water
    // rust: && m.hurt_time <= 0
    // rust: && w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| m.distance_sqr(p.position) <= 16.0)
}
pub fn follow_trading_player(m: *mut Mob) void {
}
    // rust: let mm = mem(m);
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity(Who::Player, false),
    // rust: speed: 0.5,
    // rust: close: 2,
    // rust: });
    // rust: mm.look_target.set(Tracker::Entity(Who::Player, true));
}
/// `GiveGiftToHero.isHeroVisible`.
pub fn hero_visible(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mem_ref(m).is_some_and(|mm| mm.nearest_visible_player.get() == Some(&Who::Player))
    // rust: && w.player.as_ref().is_some_and(|p| p.hero)
}
/// `ShowTradesToPlayer.checkExtraStartConditions`.
pub fn show_trades_condition(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(target) = mem_ref(m).and_then(|mm| mm.interaction_target.value()) else {
    // rust: return false;
}
    // rust: target == Who::Player
    // rust: && m.alive()
    // rust: && !m.is_baby()
    // rust: && w.target_info(target)
    // rust: .is_some_and(|t| t.alive && m.distance_sqr(t.position) <= 17.0)
}
/// `BehaviorUtils.targetIsValid` for a villager.
pub fn villager_target_valid(m: *mut Mob, w: *MobWorld, which: Mem) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let target = mem_ref(m).and_then(|mm| match which {
    // rust: Mem::InteractionTarget => mm.interaction_target.value(),
    // rust: Mem::BreedTarget => mm.breed_target.value(),
    // rust: _ => None,
    // rust: });
    // rust: let Some(Who::Mob(id)) = target else {
    // rust: return false;
}
    // rust: w.seen(id)
    // rust: .is_some_and(|s| s.species == Species::Villager && s.alive)
    // rust: && visible_contains(m, w, Who::Mob(id))
}
/// `Villager.playWorkSound`.
pub fn play_work_sound(m: *mut Mob, cx: *mut Bx) void {
}
    // rust: if let Some(sound) = super::villager::work_sound(m.extra.variant2) {
    // rust: m.voice(sound, cx.events);
}
}
/// `WorkAtPoi.start`'s restock.
pub fn restock_if_due(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let day = w.day_time.div_euclid(24000);
    // rust: if let Some(t) = m.extra.trade.as_mut()
    // rust: && t.should_restock(w.game_time, day)
    // rust: {
    // rust: t.restock(w.game_time);
}
}
    // rust: mod farming_tests;

/// `HarvestFarmland.validFarmlandAroundVillager`: ripe crops and bare
/// farmland around the villager.
pub fn farmland_around(m: *Mob, w: *MobWorld) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut valid = Vec::new();
    // rust: for x in -1..=1 {
    // rust: for y in -1..=1 {
    // rust: for z in -1..=1 {
    // rust: let p = [
    // rust: (m.position.x + f64::from(x)).floor() as i32,
    // rust: (m.position.y + f64::from(y)).floor() as i32,
    // rust: (m.position.z + f64::from(z)).floor() as i32,
    // rust: ];
    // rust: if farmland_valid(w, p) {
    // rust: valid.push(p);
}
}
}
}
    // rust: valid
}
/// Farmland subclasses include mod templates.
pub fn farmland(w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.facts
    // rust: .get(w.world.block(p[0], p[1], p[2]))
    // rust: .has_class("FarmlandBlock")
}
/// `HarvestFarmland.validPos`: a ripe CropBlock or air above farmland.
pub fn farmland_valid(w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::villager::ripe_crop(w, p)
    // rust: || w.facts.is_air(w.world.block(p[0], p[1], p[2])) && farmland(w, [p[0], p[1] - 1, p[2]])
}
/// `HarvestFarmland.getValidFarmland`: one picked by the level random.
pub fn pick_farmland(valid: *[[i32; 3]], cx: *mut Bx) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if valid.is_empty() {
    // rust: return None;
}
    // rust: let i = cx.lr.next_int_bound(valid.len() as i32).unwrap_or(0) as usize;
    // rust: Some(valid[i])
}
/// A tagged BlockItem plants its block's default state.
pub fn seed_crop(w: *MobWorld, item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let items = w.items?;
    // rust: if !items.item_in_tag("minecraft:villager_plantable_seeds", item) {
    // rust: return None;
}
    // rust: items.get(item)?.block
}
/// `HarvestFarmland.tick` at the farmland: harvest a ripe crop, sow bare
/// farmland, and move on from a growing crop.
    // rust: fn harvest_tick(
    // rust: m: &mut Mob,
    // rust: cx: &mut Bx,
    // rust: next_ok: &mut i64,
    // rust: target: &mut Option<[i32; 3]>,
    // rust: valid: &mut Vec<[i32; 3]>,
    // rust: ) {
    // rust: let Some(p) = *target else { return };
    // rust: if cx.now <= *next_ok {
    // rust: return;
}
    // rust: let w = cx.w;
    // rust: let ripe = super::villager::ripe_crop(w, p);
    // rust: let air = w.facts.is_air(w.world.block(p[0], p[1], p[2]));
    // rust: let growing = !ripe && super::villager::crop(w, p);
    // rust: if ripe {
    // rust: cx.events.push(MobEvent::BreakBlock { pos: p, drop: true });
}
    // rust: if air && farmland(w, [p[0], p[1] - 1, p[2]]) {
    // rust: let e = super::villager::ext_mut(m);
    // rust: if let Some((slot, crop)) = e
    // rust: .inventory
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, s)| s.count > 0)
    // rust: .find_map(|(i, s)| seed_crop(w, &s.item).map(|crop| (i, crop)))
    // rust: {
    // rust: e.inventory[slot].count -= 1;
    // rust: if e.inventory[slot].count == 0 {
    // rust: e.inventory.remove(slot);
}
    // rust: cx.events.push(MobEvent::SetBlock {
    // rust: pos: p,
    // rust: state: crop,
    // rust: });
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "item.crop.plant",
    // rust: [f64::from(p[0]), f64::from(p[1]), f64::from(p[2])],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
}
    // rust: if growing {
    // rust: valid.retain(|q| *q != p);
    // rust: *target = pick_farmland(valid, cx);
    // rust: if let Some(q) = *target {
    // rust: *next_ok = cx.now + 20;
    // rust: let mm = mem(m);
    // rust: mm.walk_target.set(WalkTarget::block(q, 0.5, 1));
    // rust: mm.look_target.set(Tracker::Block(q));
}
}
}
/// `UseBonemeal.validPos`: a `CropBlock` below its max age.
pub fn bonemeal_valid(w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::villager::crop(w, p) && !super::villager::ripe_crop(w, p)
}
/// `UseBonemeal.pickNextTarget`: one of the valid blocks around the villager,
/// each equally likely (reservoir sampling with the level random).
pub fn pick_bonemeal_crop(m: *Mob, cx: *mut Bx) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = block_of(m.position);
    // rust: let mut result = None;
    // rust: let mut count = 0;
    // rust: for x in -1..=1 {
    // rust: for y in -1..=1 {
    // rust: for z in -1..=1 {
    // rust: let p = [c[0] + x, c[1] + y, c[2] + z];
    // rust: if bonemeal_valid(cx.w, p) {
    // rust: count += 1;
    // rust: if cx.lr.next_int_bound(count).unwrap_or(1) == 0 {
    // rust: result = Some(p);
}
}
}
}
}
    // rust: result
}
/// `UseBonemeal.setCurrentCropAsTarget`.
pub fn bonemeal_target(m: *mut Mob, crop: ?[i32; 3]) void {
}
    // rust: if let Some(p) = crop {
    // rust: let mm = mem(m);
    // rust: mm.look_target.set(Tracker::Block(p));
    // rust: mm.walk_target.set(WalkTarget::block(p, 0.5, 1));
}
}
/// The remembered POI positions a behaviour reads.
pub const PoiMem = enum {
    Job,
    Potential,
    Home,
    Meeting,
};
    // rust: impl PoiMem {
pub fn get(self: *Self, m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mm = mem_ref(m)?;
    // rust: match self {
    // rust: PoiMem::Job => mm.job_site.value(),
    // rust: PoiMem::Potential => mm.potential_job_site.value(),
    // rust: PoiMem::Home => mm.home.value(),
    // rust: PoiMem::Meeting => mm.meeting_point.value(),
}
}
pub fn clear(self: *Self, m: *mut Mob) void {
}
    // rust: let mm = mem(m);
    // rust: match self {
    // rust: PoiMem::Job => mm.job_site.clear(),
    // rust: PoiMem::Potential => mm.potential_job_site.clear(),
    // rust: PoiMem::Home => mm.home.clear(),
    // rust: PoiMem::Meeting => mm.meeting_point.clear(),
}
}
}
pub fn dist_sqr(a: [i32; 3], b: [i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: manhattan_sq(a, b)
}
/// Every bed head within `radius` (`PoiManager.getInRange(HOME, ..., ANY)`),
/// in the order of a scan of the cube: y, then z, then x.
pub fn homes_in_range(m: *Mob, w: *MobWorld, radius: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = block_of(m.position);
    // rust: let r2 = i64::from(radius) * i64::from(radius);
    // rust: let mut out = Vec::new();
    // rust: let y0 = (c[1] - radius).max(w.world.bottom_y());
    // rust: let y1 = (c[1] + radius).min(w.world.top_y() - 1);
    // rust: for qz in (c[2] - radius) >> 4..=(c[2] + radius) >> 4 {
    // rust: for qx in (c[0] - radius) >> 4..=(c[0] + radius) >> 4 {
    // rust: chunk_pois(w, (qx, qz), y0, y1, |poi, p| {
    // rust: if poi == Poi::Home && dist_sqr(p, c) <= r2 {
    // rust: out.push(p);
}
    // rust: });
}
}
    // rust: out.sort_unstable_by_key(|p| (p[1], p[2], p[0]));
    // rust: out
}
/// `MoveToSkySeeingSpot.hasNoBlocksAbove`.
pub fn no_blocks_above(m: *Mob, w: *MobWorld, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.can_see_sky(p[0], p[1], p[2])
    // rust: && f64::from(w.motion_blocking_height(p[0], p[2])) <= m.position.y
}
/// `VillagerMakeLove.isBreedingPossible`.
pub fn breeding_possible(m: *mut Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Who::Mob(id)) = mem_ref(m).and_then(|mm| mm.breed_target.value()) else {
    // rust: return false;
}
    // rust: villager_target_valid(m, w, Mem::BreedTarget)
    // rust: && super::villager::can_breed(m)
    // rust: && w.seen(id).is_some_and(|s| s.in_love)
}
/// `VillagerMakeLove.takeVacantBed`: `PoiManager.take(HOME, ..., 48)` over a
/// sphere of 48 blocks, the nearest bed head no villager has claimed that the
/// villager can walk to (`canReach`: a path that gets there).
pub fn take_bed_for_child(m: *mut Mob, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let claimed: Vec<[i32; 3]> = w
    // rust: .others
    // rust: .iter()
    // rust: .filter(|s| s.species == Species::Villager && s.id != m.id)
    // rust: .filter_map(|s| s.bed)
    // rust: .chain(m.extra.bed)
    // rust: .collect();
    // rust: let from = block_of(m.position);
    // rust: let mut beds: Vec<[i32; 3]> = homes_in_range(m, w, 48)
    // rust: .into_iter()
    // rust: .filter(|p| {
    // rust: w.prop(p[0], p[1], p[2], "part") == Some("head")
    // rust: && w.prop(p[0], p[1], p[2], "occupied") != Some("true")
    // rust: && !claimed.contains(p)
    // rust: })
    // rust: .collect();
    // Nearest first; equally near beds stay in scan order.
    // rust: beds.sort_by_key(|p| dist_sqr(*p, from));
    // rust: beds.into_iter().find(|&p| {
    // rust: m.create_path_to(w, p, Poi::Home.valid_range())
    // rust: .is_some_and(|path| path.reached)
    // rust: })
}
/// `BehaviorUtils.lockGazeAndWalkToEachOther`: this villager's half, and
/// the other villager's through a `LockGaze` event.
pub fn lock_gaze(m: *mut Mob, target: Who, cx: *mut Bx) void {
}
    // rust: lock_gaze_half(m, target);
    // rust: if let Who::Mob(other) = target {
    // rust: cx.events.push(MobEvent::LockGaze {
    // rust: mob: other,
    // rust: partner: m.id,
    // rust: });
}
}
/// One villager's half of `lockGazeAndWalkToEachOther`: look at the other
/// and walk to it.
pub fn lock_gaze_half(m: *mut Mob, target: Who) void {
}
    // rust: if super::villager::ext(m).is_none_or(|e| e.brain.is_none()) {
    // rust: return;
}
    // rust: let mm = mem(m);
    // rust: mm.look_target.set(Tracker::Entity(target, true));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity(target, true),
    // rust: speed: 0.5,
    // rust: close: 2,
    // rust: });
}
/// `SetWalkTargetFromBlockMemory`.
    // rust: fn walk_to_block_memory(
    // rust: m: &mut Mob,
    // rust: cx: &mut Bx,
    // rust: which: PoiMem,
    // rust: speed: f32,
    // rust: close: i32,
    // rust: too_far: i32,
    // rust: too_long: i64,
    // rust: ) -> bool {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let Some(target) = which.get(m) else {
    // rust: return false;
}
    // rust: let since = mem(m).cant_reach_walk_target_since.value();
    // rust: let here = block_of(m.position);
    // rust: if since.is_none_or(|s| cx.w.game_time - s <= too_long) {
    // rust: if manhattan(target, here) > too_far {
    // rust: let to = [
    // rust: f64::from(target[0]) + 0.5,
    // rust: f64::from(target[1]),
    // rust: f64::from(target[2]) + 0.5,
    // rust: ];
    // rust: let mut tries = 0;
    // rust: loop {
    // rust: let step = m.default_random_pos_towards(
    // rust: cx.w,
    // rust: 15,
    // rust: 7,
    // rust: to,
    // rust: f64::from(std::f32::consts::FRAC_PI_2),
    // rust: );
    // rust: if let Some(s) = step {
    // rust: let b = [
    // rust: s[0].floor() as i32,
    // rust: s[1].floor() as i32,
    // rust: s[2].floor() as i32,
    // rust: ];
    // rust: if manhattan(b, block_of(m.position)) <= too_far {
    // rust: mem(m).walk_target.set(WalkTarget::point(s, speed, close));
    // rust: break;
}
}
    // rust: tries += 1;
    // rust: if tries == 1000 {
    // rust: which.clear(m);
    // rust: mem(m).cant_reach_walk_target_since.set(cx.now);
    // rust: return true;
}
}
    // rust: } else if manhattan(target, here) > close {
    // rust: mem(m)
    // rust: .walk_target
    // rust: .set(WalkTarget::block(target, speed, close));
}
    // rust: } else {
    // rust: which.clear(m);
    // rust: mem(m).cant_reach_walk_target_since.set(cx.now);
}
    // rust: true
}
/// `InteractWithDoor`: open the doors on the path, close the ones passed.
pub fn interact_with_doors(m: *mut Mob, cx: *mut Bx, from: PathNode, to: PathNode) void {
}
    // rust: let (from, to) = ([from.x, from.y, from.z], [to.x, to.y, to.z]);
    // The door being left is remembered even when it is open already; the
    // one ahead only when this villager opens it.
    // rust: for (p, always) in [(from, true), (to, false)] {
    // rust: let Some(open) = door_open(cx.w, p) else {
    // rust: continue;
}
    // rust: if !open {
    // rust: cx.events.push(MobEvent::SetDoorOpen { pos: p, open: true });
}
    // rust: if always || !open {
    // rust: remember_door(m, p);
}
}
    // rust: close_doors(m, cx, Some(from), Some(to));
}
/// Whether the block at `p` is a door mobs open (`MOB_INTERACTABLE_DOORS`), and
/// then whether it is open.
pub fn door_open(w: *MobWorld, p: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = w.block_name(p[0], p[1], p[2]);
    // rust: (name.ends_with("_door") && w.has_tag("minecraft:mob_interactable_doors", name))
    // rust: .then(|| w.prop(p[0], p[1], p[2], "open") == Some("true"))
}
pub fn remember_door(m: *mut Mob, p: [i32; 3]) void {
}
    // rust: let doors = &mut mem(m).doors_to_close;
    // rust: match doors.get_mut() {
    // rust: Some(list) if list.contains(&p) => {}
    // rust: Some(list) => list.push(p),
    // rust: None => doors.set(vec![p]),
}
}
/// `InteractWithDoor.closeDoorsThatIHaveOpenedOrPassedThrough`: the remembered
/// doors other than the two of the step being taken are forgotten, and closed
/// when still open, near (3 blocks) and no other villager within 2 blocks of
/// one is passing through it.
pub fn close_doors(m: *mut Mob, cx: *mut Bx, from: ?[i32; 3], to: ?[i32; 3]) void {
}
    // rust: let Some(doors) = mem(m).doors_to_close.get().cloned() else {
    // rust: return;
}
    // rust: let near = mem(m).mobs.value().unwrap_or_default();
    // rust: let mut kept = Vec::new();
    // rust: for door in doors {
    // rust: if from == Some(door) || to == Some(door) {
    // rust: kept.push(door);
    // rust: continue;
}
    // rust: if !closer_to_center(door, m.position, 3.0) || door_open(cx.w, door) != Some(true) {
    // rust: continue;
}
    // rust: let passing = near.iter().any(|&who| {
    // rust: let Who::Mob(id) = who else { return false };
    // rust: cx.w.seen(id).is_some_and(|s| {
    // rust: s.species == Species::Villager
    // rust: && closer_to_center(door, s.position, 2.0)
    // rust: && s.villager
    // rust: .as_ref()
    // rust: .and_then(|v| v.path_nodes)
    // rust: .is_some_and(|(prev, next)| prev.is_some_and(|p| p == door || next == door))
    // rust: })
    // rust: });
    // rust: if !passing {
    // rust: cx.events.push(MobEvent::SetDoorOpen {
    // rust: pos: door,
    // rust: open: false,
    // rust: });
}
}
    // rust: mem(m).doors_to_close.set(kept);
}
/// The scan order of POI candidates (before the nearest-first sort).
pub fn pois_scan_order(_m: *Mob, found: *[(Poi) void {
}
    // rust: (0..found.len()).collect()
}
/// Entity event 14: the client shows happy particles (with its own random,
/// not the mob's).
/// Entity event 14 (`AcquirePoi`, `AssignProfessionFromJobSite`):
/// `AbstractVillager.addParticlesAroundSelf(HAPPY_VILLAGER)` on the client.
pub fn happy_particles(m: *Mob, cx: *mut Bx) void {
}
    // rust: cx.events.push(MobEvent::AroundSelf {
    // rust: mob: m.id,
    // rust: event: 14,
    // rust: kind: "happy_villager",
    // rust: feet: [m.position.x, m.position.y, m.position.z],
    // rust: width: f64::from(m.width()),
    // rust: height: f64::from(m.height()),
    // rust: burst: crate::particles::Burst::VILLAGER,
    // rust: });
}
/// `BehaviorUtils.findSectionClosestToVillage`.
    // rust: pub(super) fn closest_section(villages: &[[i32; 3]], center: [i32; 3], radius: i32) -> [i32; 3] {
    // rust: let here = sections_to_village(villages, center);
    // rust: let mut best: Option<([i32; 3], i32)> = None;
    // rust: for z in center[2] - radius..=center[2] + radius {
    // rust: for y in center[1] - radius..=center[1] + radius {
    // rust: for x in center[0] - radius..=center[0] + radius {
    // rust: let s = [x, y, z];
    // rust: let d = sections_to_village(villages, s);
    // rust: if d < here && best.is_none_or(|(_, b)| d < b) {
    // rust: best = Some((s, d));
}
}
}
}
    // rust: best.map_or(center, |(s, _)| s)
}

// ---- Packages -----------------------------------------------------------

pub fn timed(min: i32, max: i32) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Timed::new(min, max)
}
pub fn run_one(seed: i64, kids: Vec<(B) void {
}
    // rust: B::Gate(Box::new(Gate::run_one(seed, kids)))
}
pub fn look_at(what: LookAt) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::LookAtEntity {
    // rust: running: false,
    // rust: what,
}
}
/// `getMinimalLookBehavior`.
pub fn look_minimal(seed: i64) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: run_one(
    // rust: seed,
    // rust: vec![
    // rust: (look_at(LookAt::Species(Species::Villager)), 2),
    // rust: (look_at(LookAt::Player), 2),
    // rust: (B::DoNothing(timed(30, 60)), 8),
    // rust: ],
    // rust: )
}
/// `getFullLookBehavior`.
pub fn look_full(seed: i64) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: run_one(
    // rust: seed,
    // rust: vec![
    // rust: (look_at(LookAt::Species(Species::Cat)), 8),
    // rust: (look_at(LookAt::Species(Species::Villager)), 2),
    // rust: (look_at(LookAt::Player), 2),
    // rust: (look_at(LookAt::Category("creature")), 1),
    // rust: (look_at(LookAt::Category("water_creature")), 1),
    // rust: (look_at(LookAt::Category("axolotls")), 1),
    // rust: (look_at(LookAt::Category("underground_water_creature")), 1),
    // rust: (look_at(LookAt::Category("water_ambient")), 1),
    // rust: (look_at(LookAt::Category("monster")), 1),
    // rust: (B::DoNothing(timed(30, 60)), 2),
    // rust: ],
    // rust: )
}
pub fn stroll(speed: f32, xz: i32, y: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::VillageBoundStroll {
    // rust: running: false,
    // rust: speed,
    // rust: xz,
    // rust: y,
}
}
pub fn walk_to(which: PoiMem, speed: f32, close: i32, too_far: i32, too_long: i64) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::WalkToBlockMemory {
    // rust: running: false,
    // rust: which,
    // rust: speed,
    // rust: close,
    // rust: too_far,
    // rust: too_long,
}
}
pub fn trigger_gate(seed: i64, kids: Vec<(B) void {
}
    // rust: B::TriggerGate {
    // rust: running: false,
    // rust: random: LegacyRandom::new(seed),
    // rust: kids: kids.into_iter().map(|(b, w)| (b, w, 0.0)).collect(),
}
}
pub fn gift() B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::GiveGiftToHero {
    // rust: t: timed(100, 100),
    // rust: until_next: 600,
    // rust: given: false,
    // rust: started: 0,
}
}
pub fn show_trades() B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::ShowTrades {
    // rust: t: timed(400, 1600),
    // rust: look_time: 0,
    // rust: player_item: None,
    // rust: items: Vec::new(),
    // rust: cycle: 0,
    // rust: index: 0,
}
}
pub fn interact(kind: Interact) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::InteractWith {
    // rust: running: false,
    // rust: kind,
}
}
pub fn trade_gate(seed: i64) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::Gate(Box::new(Gate::ordered(
    // rust: seed,
    // rust: Mem::InteractionTarget,
    // rust: B::TradeWithVillager(timed(60, 60)),
    // rust: )))
}
pub fn jump_on_bed() B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::JumpOnBed {
    // rust: t: timed(60, 60),
    // rust: bed: None,
    // rust: time_left: 0,
    // rust: jumps: 0,
    // rust: cooldown: 0,
}
}
pub fn move_to_target_sink(min: i32, max: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::MoveToTargetSink {
    // rust: t: timed(min, max),
    // rust: cooldown: 0,
    // rust: path: None,
    // rust: last_target: None,
    // rust: speed: 0.0,
}
}
pub fn acquire(filter: PoiFilter, poi: Poi, only_adult: bool, event: bool) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::AcquirePoi {
    // rust: running: false,
    // rust: filter,
    // rust: poi,
    // rust: only_adult,
    // rust: event,
    // rust: next: 0,
    // rust: retries: Vec::new(),
}
}
pub fn validate(filter: PoiFilter, which: PoiMem) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::ValidatePoi {
    // rust: running: false,
    // rust: filter,
    // rust: which,
}
}
/// `VillagerGoalPackages`: the behaviours of every activity, in iteration
/// order. `speedModifier` is 0.5 throughout.
pub fn packages(baby: bool, seed: i64, farmer: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v: Vec<Entry> = Vec::new();
    // rust: let mut add = |prio: i32, act: Act, b: B| v.push(Entry { prio, act, b });
    // rust: if baby {
        // PLAY
    // rust: let p = Act::Play;
    // rust: add(0, p, move_to_target_sink(80, 120));
    // rust: add(5, p, look_full(seed));
    // rust: add(5, p, B::PlayTag(false));
    // rust: let mut play = Gate::run_one(
    // rust: seed,
    // rust: vec![
    // rust: (interact(Interact::Villager), 2),
    // rust: (interact(Interact::Cat), 1),
    // rust: (stroll(0.5, 10, 7), 1),
    // rust: (B::WalkToLookTarget(false), 1),
    // rust: (jump_on_bed(), 2),
    // rust: (B::DoNothing(timed(20, 40)), 2),
    // rust: ],
    // rust: );
    // rust: play.absent = Some(Mem::VisibleBabies);
    // rust: add(5, p, B::Gate(Box::new(play)));
    // rust: add(99, p, B::UpdateActivity(false));
    // rust: } else {
        // WORK
    // rust: let w = Act::Work;
    // rust: add(5, w, look_minimal(seed));
    // rust: add(
    // rust: 5,
    // rust: w,
    // rust: run_one(
    // rust: seed,
    // rust: vec![
    // rust: (
    // rust: B::WorkAtPoi {
    // rust: t: timed(60, 60),
    // rust: last_check: 0,
    // rust: composter: farmer,
    // rust: },
    // rust: 7,
    // rust: ),
    // rust: (
    // rust: B::StrollAroundPoi {
    // rust: running: false,
    // rust: next_ok: 0,
    // rust: max_dist: 4,
    // rust: which: PoiMem::Job,
    // rust: },
    // rust: 2,
    // rust: ),
    // rust: (
    // rust: B::StrollToPoi {
    // rust: running: false,
    // rust: next_ok: 0,
    // rust: },
    // rust: 5,
    // rust: ),
    // rust: (
    // rust: B::StrollToPoiList {
    // rust: running: false,
    // rust: next_ok: 0,
    // rust: },
    // rust: 5,
    // rust: ),
    // rust: (
    // rust: B::HarvestFarmland {
    // rust: t: timed(60, 60),
    // rust: next_ok: 0,
    // rust: target: None,
    // rust: valid: Vec::new(),
    // rust: worked: 0,
    // rust: },
    // rust: if farmer { 2 } else { 5 },
    // rust: ),
    // rust: (
    // rust: B::UseBonemeal {
    // rust: t: timed(60, 60),
    // rust: next_work: 0,
    // rust: last_session: 0,
    // rust: worked: 0,
    // rust: crop: None,
    // rust: repick: false,
    // rust: },
    // rust: if farmer { 4 } else { 7 },
    // rust: ),
    // rust: ],
    // rust: ),
    // rust: );
    // rust: add(10, w, show_trades());
    // rust: add(10, w, B::SetLookAndInteract(false));
    // rust: add(2, w, walk_to(PoiMem::Job, 0.5, 9, 100, 1200));
    // rust: add(3, w, gift());
    // rust: add(99, w, B::UpdateActivity(false));
}
    // CORE
    // rust: let c = Act::Core;
    // rust: add(0, c, B::Swim(timed(60, 60)));
    // rust: add(
    // rust: 0,
    // rust: c,
    // rust: B::InteractWithDoor {
    // rust: running: false,
    // rust: last_node: None,
    // rust: cooldown: 0,
    // rust: },
    // rust: );
    // rust: add(0, c, B::LookAtTargetSink(timed(45, 90)));
    // rust: add(0, c, B::PanicTrigger(timed(60, 60)));
    // rust: add(0, c, B::WakeUp(false));
    // rust: add(0, c, B::ReactToBell(false));
    // rust: add(0, c, B::SetRaidStatus(false));
    // rust: add(0, c, validate(PoiFilter::Held, PoiMem::Job));
    // rust: add(0, c, validate(PoiFilter::Acquirable, PoiMem::Potential));
    // rust: add(1, c, move_to_target_sink(150, 250));
    // rust: add(2, c, B::PoiCompetitorScan(false));
    // rust: add(3, c, B::FollowTradingPlayer(timed(i32::MAX, i32::MAX)));
    // rust: add(5, c, B::GoToWantedItem(false));
    // rust: add(
    // rust: 6,
    // rust: c,
    // rust: acquire(PoiFilter::Acquirable, Poi::Job(0), true, false),
    // rust: );
    // rust: add(7, c, B::GoToPotentialJobSite(timed(1200, 1200)));
    // rust: add(8, c, B::YieldJobSite(false));
    // rust: add(10, c, acquire(PoiFilter::Home, Poi::Home, false, true));
    // rust: add(10, c, acquire(PoiFilter::Meeting, Poi::Meeting, true, true));
    // rust: add(10, c, B::AssignProfession(false));
    // rust: add(10, c, B::ResetProfession(false));
    // MEET
    // rust: let me = Act::Meet;
    // rust: add(
    // rust: 2,
    // rust: me,
    // rust: trigger_gate(
    // rust: seed,
    // rust: vec![
    // rust: (
    // rust: B::StrollAroundPoi {
    // rust: running: false,
    // rust: next_ok: 0,
    // rust: max_dist: 40,
    // rust: which: PoiMem::Meeting,
    // rust: },
    // rust: 2,
    // rust: ),
    // rust: (B::SocializeAtBell(false), 2),
    // rust: ],
    // rust: ),
    // rust: );
    // rust: add(10, me, show_trades());
    // rust: add(10, me, B::SetLookAndInteract(false));
    // rust: add(2, me, walk_to(PoiMem::Meeting, 0.5, 6, 100, 200));
    // rust: add(3, me, gift());
    // rust: add(3, me, validate(PoiFilter::Meeting, PoiMem::Meeting));
    // rust: add(3, me, trade_gate(seed));
    // rust: add(5, me, look_full(seed));
    // rust: add(99, me, B::UpdateActivity(false));
    // REST
    // rust: let r = Act::Rest;
    // rust: add(2, r, walk_to(PoiMem::Home, 0.5, 1, 150, 1200));
    // rust: add(3, r, validate(PoiFilter::Home, PoiMem::Home));
    // rust: add(
    // rust: 3,
    // rust: r,
    // rust: B::SleepInBed {
    // rust: t: timed(60, 60),
    // rust: next_ok: 0,
    // rust: },
    // rust: );
    // rust: let mut homeless = Gate::run_one(
    // rust: seed,
    // rust: vec![
    // rust: (
    // rust: B::ClosestHomeAsWalkTarget {
    // rust: running: false,
    // rust: last_update: 0,
    // rust: cache: Vec::new(),
    // rust: },
    // rust: 1,
    // rust: ),
    // rust: (
    // rust: B::InsideBrownianWalk {
    // rust: running: false,
    // rust: random: LegacyRandom::new(seed),
    // rust: },
    // rust: 4,
    // rust: ),
    // rust: (B::GoToClosestVillage(false), 2),
    // rust: (B::DoNothing(timed(20, 40)), 2),
    // rust: ],
    // rust: );
    // rust: homeless.absent = Some(Mem::Home);
    // rust: add(5, r, B::Gate(Box::new(homeless)));
    // rust: add(5, r, look_minimal(seed));
    // rust: add(99, r, B::UpdateActivity(false));
    // IDLE
    // rust: let i = Act::Idle;
    // rust: add(
    // rust: 2,
    // rust: i,
    // rust: run_one(
    // rust: seed,
    // rust: vec![
    // rust: (interact(Interact::Villager), 2),
    // rust: (interact(Interact::BreedVillager), 1),
    // rust: (interact(Interact::Cat), 1),
    // rust: (stroll(0.5, 10, 7), 1),
    // rust: (B::WalkToLookTarget(false), 1),
    // rust: (jump_on_bed(), 1),
    // rust: (B::DoNothing(timed(30, 60)), 1),
    // rust: ],
    // rust: ),
    // rust: );
    // rust: add(3, i, gift());
    // rust: add(3, i, B::SetLookAndInteract(false));
    // rust: add(3, i, show_trades());
    // rust: add(3, i, trade_gate(seed));
    // rust: add(
    // rust: 3,
    // rust: i,
    // rust: B::Gate(Box::new(Gate::ordered(
    // rust: seed,
    // rust: Mem::BreedTarget,
    // rust: B::MakeLove {
    // rust: t: timed(350, 350),
    // rust: birth: 0,
    // rust: },
    // rust: ))),
    // rust: );
    // rust: add(5, i, look_full(seed));
    // rust: add(99, i, B::UpdateActivity(false));
    // PANIC
    // rust: let pa = Act::Panic;
    // rust: add(0, pa, B::CalmDown(false));
    // rust: add(
    // rust: 1,
    // rust: pa,
    // rust: B::WalkAwayFrom {
    // rust: running: false,
    // rust: hostile: true,
    // rust: },
    // rust: );
    // rust: add(
    // rust: 1,
    // rust: pa,
    // rust: B::WalkAwayFrom {
    // rust: running: false,
    // rust: hostile: false,
    // rust: },
    // rust: );
    // rust: add(3, pa, stroll(0.75, 2, 2));
    // rust: add(5, pa, look_minimal(seed));
    // PRE_RAID
    // rust: let pr = Act::PreRaid;
    // rust: add(0, pr, B::RingBell(false));
    // rust: add(
    // rust: 0,
    // rust: pr,
    // rust: trigger_gate(
    // rust: seed,
    // rust: vec![
    // rust: (walk_to(PoiMem::Meeting, 0.75, 2, 150, 200), 6),
    // rust: (stroll(0.75, 10, 7), 2),
    // rust: ],
    // rust: ),
    // rust: );
    // rust: add(5, pr, look_minimal(seed));
    // rust: add(99, pr, B::ResetRaidStatus(false));
    // RAID
    // rust: let ra = Act::Raid;
    // rust: add(
    // rust: 0,
    // rust: ra,
    // rust: B::RaidSequence {
    // rust: running: false,
    // rust: victory: true,
    // rust: then: Box::new(trigger_gate(
    // rust: seed,
    // rust: vec![
    // rust: (
    // rust: B::MoveToSkySeeingSpot {
    // rust: running: false,
    // rust: speed: 0.5,
    // rust: },
    // rust: 5,
    // rust: ),
    // rust: (stroll(0.55, 10, 7), 2),
    // rust: ],
    // rust: )),
    // rust: },
    // rust: );
    // rust: add(0, ra, B::Celebrate(timed(600, 600)));
    // rust: add(
    // rust: 2,
    // rust: ra,
    // rust: B::RaidSequence {
    // rust: running: false,
    // rust: victory: false,
    // rust: then: Box::new(B::LocateHidingPlace {
    // rust: running: false,
    // rust: radius: 24,
    // rust: speed: 0.7,
    // rust: close: 1,
    // rust: }),
    // rust: },
    // rust: );
    // rust: add(5, ra, look_minimal(seed));
    // rust: add(99, ra, B::ResetRaidStatus(false));
    // HIDE
    // rust: let h = Act::Hide;
    // rust: add(
    // rust: 0,
    // rust: h,
    // rust: B::SetHiddenState {
    // rust: running: false,
    // rust: hidden: 0,
    // rust: },
    // rust: );
    // rust: add(
    // rust: 1,
    // rust: h,
    // rust: B::LocateHidingPlace {
    // rust: running: false,
    // rust: radius: 32,
    // rust: speed: 0.625,
    // rust: close: 2,
    // rust: },
    // rust: );
    // rust: add(5, h, look_minimal(seed));
    // rust: v.sort_by_key(|e| (e.prio, e.act.slot()));
    // rust: v
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
/// The active activities and the memories with values, as the oracle
/// prints them (`act core|idle`, `mem name=value...` sorted).
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
    // rust: slot!("home", mm.home, |p: &[i32; 3]| pos(*p));
    // rust: slot!("job_site", mm.job_site, |p: &[i32; 3]| pos(*p));
    // rust: slot!(
    // rust: "potential_job_site",
    // rust: mm.potential_job_site,
    // rust: |p: &[i32; 3]| pos(*p)
    // rust: );
    // rust: slot!("meeting_point", mm.meeting_point, |p: &[i32; 3]| pos(*p));
    // rust: slot!("secondary_job_site", mm.secondary_job_site, |l: &Vec<
    // rust: [i32; 3],
    // rust: >| format!(
    // rust: "n{}",
    // rust: l.len()
    // rust: ));
    // rust: slot!("mobs", mm.mobs, |l: &Vec<Who>| format!("n{}", l.len()));
    // rust: slot!("visible_mobs", mm.visible_mobs, |_: &Visible| {
    // rust: "NearestVisibleLivingEntities".to_string()
    // rust: });
    // rust: slot!(
    // rust: "visible_villager_babies",
    // rust: mm.visible_villager_babies,
    // rust: |l: &Vec<Who>| format!("n{}", l.len())
    // rust: );
    // rust: slot!(
    // rust: "nearest_players",
    // rust: mm.nearest_players,
    // rust: |l: &Vec<Who>| format!("n{}", l.len())
    // rust: );
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
    // rust: |l: &Vec<Who>| format!("n{}", l.len())
    // rust: );
    // rust: slot!("walk_target", mm.walk_target, |t: &WalkTarget| format!(
    // rust: "{}/{:x}/{}",
    // rust: tracker(t.target),
    // rust: t.speed.to_bits(),
    // rust: t.close
    // rust: ));
    // rust: slot!("look_target", mm.look_target, |t: &Tracker| tracker(*t));
    // rust: slot!("interaction_target", mm.interaction_target, |e: &Who| who(
    // rust: *e
    // rust: ));
    // rust: slot!("breed_target", mm.breed_target, |e: &Who| who(*e));
    // rust: slot!("path", mm.path, |p: &Path| format!("path{}", pos(p.target)));
    // rust: slot!(
    // rust: "doors_to_close",
    // rust: mm.doors_to_close,
    // rust: |l: &Vec<[i32; 3]>| format!("n{}", l.len())
    // rust: );
    // rust: slot!("nearest_bed", mm.nearest_bed, |p: &[i32; 3]| pos(*p));
    // rust: slot!("hurt_by", mm.hurt_by, |_: &i64| "DamageSource".to_string());
    // rust: slot!("hurt_by_entity", mm.hurt_by_entity, |e: &Who| who(*e));
    // rust: slot!("nearest_hostile", mm.nearest_hostile, |e: &Who| who(*e));
    // rust: slot!("hiding_place", mm.hiding_place, |p: &[i32; 3]| pos(*p));
    // rust: slot!("heard_bell_time", mm.heard_bell_time, |t: &i64| t
    // rust: .to_string());
    // rust: slot!(
    // rust: "cant_reach_walk_target_since",
    // rust: mm.cant_reach_walk_target_since,
    // rust: |t: &i64| t.to_string()
    // rust: );
    // rust: slot!(
    // rust: "golem_detected_recently",
    // rust: mm.golem_detected_recently,
    // rust: |t: &bool| t.to_string()
    // rust: );
    // rust: slot!("last_slept", mm.last_slept, |t: &i64| t.to_string());
    // rust: slot!("last_woken", mm.last_woken, |t: &i64| t.to_string());
    // rust: slot!("last_worked_at_poi", mm.last_worked_at_poi, |t: &i64| t
    // rust: .to_string());
    // rust: out.sort();
    // rust: Some((acts.join("|"), out.join(" ")))
}
/// `Villager.stopSleeping`: remember waking.
pub fn woken(m: *mut Mob, now: i64) void {
}
    // rust: if brain(m).is_some() {
    // rust: mem(m).last_woken.set(now);
}
}
/// `BellBlockEntity.updateEntities`: a bell rung within 32 blocks sets
/// `HEARD_BELL_TIME` to the game time.
pub fn heard_bell(m: *mut Mob, now: i64) void {
}
    // rust: if brain(m).is_some() {
    // rust: mem(m).heard_bell_time.set(now);
}
}
/// Whether `NearestItemSensor` is due for this villager (it is then reset).
pub fn take_item_scan(m: *mut Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: brain(m).is_some() && std::mem::take(&mut brain_mut(m).scan_items)
}
/// `NearestItemSensor.doTick`: the nearest wanted item in sight, or none.
pub fn set_wanted_item(m: *mut Mob, at: ?[f64; 3]) void {
}
    // rust: mem(m).nearest_wanted_item.set_opt(at);
}
/// What other villagers see of this one's brain.
pub fn potential_job_site(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mem_ref(m).and_then(|mm| mm.potential_job_site.value())
}
/// The memories other villagers read: the interaction target, the path's
/// nodes (while it is not done), whether a golem was seen lately and the
/// last sleep.
    // rust: pub fn seen_memories(
    // rust: m: &Mob,
    // rust: ) -> (
    // rust: Option<Who>,
    // rust: Option<(Option<[i32; 3]>, [i32; 3])>,
    // rust: bool,
    // rust: Option<i64>,
    // rust: ) {
    // rust: let Some(mm) = mem_ref(m) else {
    // rust: return (None, None, false, None);
}
    // rust: let path = mm
    // rust: .path
    // rust: .present()
    // rust: .then_some(m.ai.nav.path.as_ref())
    // rust: .flatten();
    // rust: let nodes = path.filter(|p| !p.is_done()).map(|p| {
    // rust: let n = |i: usize| [p.nodes[i].x, p.nodes[i].y, p.nodes[i].z];
    // rust: ((p.next > 0).then(|| n(p.next - 1)), n(p.next))
    // rust: });
    // rust: (
    // rust: mm.interaction_target.value(),
    // rust: nodes,
    // rust: mm.golem_detected_recently.present(),
    // rust: mm.last_slept.value(),
    // rust: )
}
