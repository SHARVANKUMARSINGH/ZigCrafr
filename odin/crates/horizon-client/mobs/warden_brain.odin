//! Transpiled from Horizon Rust crate
package horizon_client_warden_brain

import "core:fmt"
import "core:mem"
import "core:math"

// The warden's `Brain` (`Warden.BRAIN_PROVIDER` and `WardenAi`), ported
// behaviour for behaviour on the villager brain's machinery (`Slot`
// memories with their time to live, `Tracker`s, `WalkTarget`s and the
// nearest-visible list): the two sensors and their scan phases, the core,
// emerge, dig, idle, roar, fight, investigate and sniff activities, and their
// behaviours started and ticked in vanilla's order (priority, then the
// activity's slot in `Brain.availableBehaviorsByPriority`'s hash map, then
// the order the activity lists them in).
//
// The level random (`ServerLevel.getRandom`) draws every `Behavior`'s
// duration and the idle `DoNothing`, the sniff cooldown and the spot near a
// disturbance; the warden's own random drives strolls, sounds and swimming.
// `RunOne` shuffles with a random of its own, seeded with the brain's
// shuffle seed.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Who,
    // rust: brain::Timed,
    // rust: goals::Cx,
    // rust: path::Path,
    // rust: villager_brain::{Slot, Tracker, Visible, WalkTarget, compute_path, reached},
    // rust: warden::{self, Pose},
}
// use horizon_core::{
    // rust: geometry::Vec3,
    // rust: random::{LegacyRandom, RandomSource},
}

// `WardenAi` timings.
EMERGE_DURATION :: 134
ROAR_DURATION :: 84
SNIFFING_DURATION :: 84
DIGGING_DURATION :: 100
DIGGING_COOLDOWN :: 1200
MELEE_ATTACK_COOLDOWN :: 18
SONIC_DURATION :: 60
SONIC_SOUND_DELAY :: 34
ROAR_SOUND_DELAY :: 25
DISTURBANCE_EXPIRY :: 100
// `Warden.createAttributes`: the follow range the fight's look target uses.
FOLLOW_RANGE :: 24.0

// `Activity`.
Act :: enum {
    Core,
    Emerge,
    Dig,
    Idle,
    Roar,
    Fight,
    Investigate,
    Sniff,
}
    // rust: impl Act {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Act::Core => "core",
    // rust: Act::Emerge => "emerge",
    // rust: Act::Dig => "dig",
    // rust: Act::Idle => "idle",
    // rust: Act::Roar => "roar",
    // rust: Act::Fight => "fight",
    // rust: Act::Investigate => "investigate",
    // rust: Act::Sniff => "sniff",
}
}
    // The bucket of `HashMap<Activity, ...>` (16 buckets, the hash of the
    // name); roar and investigate share one but never a priority.
slot :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Act::Core => 1,
    // rust: Act::Dig => 3,
    // rust: Act::Idle => 5,
    // rust: Act::Sniff => 6,
    // rust: Act::Emerge => 10,
    // rust: Act::Roar | Act::Investigate => 11,
    // rust: Act::Fight => 14,
}
}
    // Its place in `getActivities` (insertion order inside a bucket).
order :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self as u8
}
}

// The memories the warden's brain registers.
Memories :: struct {
    nearest_players: Slot<[dynamic]Who>,
    nearest_visible_player: Slot<Who>,
    nearest_visible_targetable_player: Slot<Who>,
    nearest_visible_targetable_players: Slot<[dynamic]Who>,
    mobs: Slot<[dynamic]Who>,
    visible_mobs: Slot<Visible>,
    nearest_attackable: Slot<Who>,
    look_target: Slot<Tracker>,
    walk_target: Slot<WalkTarget>,
    path: Slot<Path>,
    cant_reach_walk_target_since: Slot<i64>,
    attack_target: Slot<Who>,
    attack_cooling_down: Slot<bool>,
    roar_target: Slot<Who>,
    disturbance_location: Slot<[i32,
    recent_projectile: Slot<()>,
    is_sniffing: Slot<()>,
    is_emerging: Slot<()>,
    roar_sound_delay: Slot<()>,
    dig_cooldown: Slot<()>,
    roar_sound_cooldown: Slot<()>,
    sniff_cooldown: Slot<()>,
    touch_cooldown: Slot<()>,
    vibration_cooldown: Slot<()>,
    sonic_boom_cooldown: Slot<()>,
    sonic_boom_sound_cooldown: Slot<()>,
    sonic_boom_sound_delay: Slot<()>,
}
    // rust: impl Memories {
tick :: proc(self: ^Self) {
}
    // rust: self.nearest_players.tick();
    // rust: self.nearest_visible_player.tick();
    // rust: self.nearest_visible_targetable_player.tick();
    // rust: self.nearest_visible_targetable_players.tick();
    // rust: self.mobs.tick();
    // rust: self.visible_mobs.tick();
    // rust: self.nearest_attackable.tick();
    // rust: self.look_target.tick();
    // rust: self.walk_target.tick();
    // rust: self.path.tick();
    // rust: self.cant_reach_walk_target_since.tick();
    // rust: self.attack_target.tick();
    // rust: self.attack_cooling_down.tick();
    // rust: self.roar_target.tick();
    // rust: self.disturbance_location.tick();
    // rust: self.recent_projectile.tick();
    // rust: self.is_sniffing.tick();
    // rust: self.is_emerging.tick();
    // rust: self.roar_sound_delay.tick();
    // rust: self.dig_cooldown.tick();
    // rust: self.roar_sound_cooldown.tick();
    // rust: self.sniff_cooldown.tick();
    // rust: self.touch_cooldown.tick();
    // rust: self.vibration_cooldown.tick();
    // rust: self.sonic_boom_cooldown.tick();
    // rust: self.sonic_boom_sound_cooldown.tick();
    // rust: self.sonic_boom_sound_delay.tick();
}
}

// `RunOne`'s `ShufflingList` over a stroll (weight 2) and `DoNothing` (1).
Gate :: struct {
    running: bool,
    random: LegacyRandom,
    kids: Vec<(B,
}

// One behaviour of the warden's activities.
B :: enum {
    Swim(Timed),
    SetWardenLookTarget(bool),
    LookAtTargetSink(Timed),
    MoveToTargetSink {,
    t: Timed,
    cooldown: i32,
    path: Option<Path>,
    last_target: Option<[i32; 3]>,
    speed: f32,
    // rust: },
    Emerging(Timed),
    ForceUnmount(Timed),
    Digging(Timed),
    SetRoarTarget(bool),
    TryToSniff(bool),
    RunOne(Box<Gate>),
    Stroll(bool),
    DoNothing(Timed),
    GoToDisturbance(bool),
    Sniffing(Timed),
    Roar(Timed),
    DigCooldownSetter(bool),
    StopAttackingIfTargetInvalid(bool),
    SetEntityLookTarget(bool),
    SetWalkTargetFromAttackTarget(bool),
    SonicBoom(Timed),
    MeleeAttack(bool),
}

Entry :: struct {
    act: Act,
    b: B,
}

// The warden's brain.
Brain :: struct {
    mem: Memories,
    // `NEAREST_PLAYERS` and `WARDEN_ENTITY_SENSOR`: ticks to the next scan.
    sensors: [i64,
    // The active non-core activity (`CORE` is always active).
    activity: Act,
    list: [dynamic]Entry,
    shuffle_seed: i64,
}
    // rust: impl Default for Brain {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(0)
}
}
    // rust: impl Brain {
new :: proc(shuffle_seed: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: mem: Memories::default(),
    // rust: sensors: [0; 2],
    // rust: activity: Act::Idle,
    // rust: list: activities(shuffle_seed),
    // rust: shuffle_seed,
}
}
is_active :: proc(self: ^Self, a: Act) -> b {
    // Ported from Horizon
    return {}
}
    // rust: a == Act::Core || a == self.activity
}
requirements_met :: proc(self: ^Self, a: Act) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let m = &self.mem;
    // rust: match a {
    // rust: Act::Emerge => m.is_emerging.present(),
    // rust: Act::Dig => !m.roar_target.present() && !m.dig_cooldown.present(),
    // rust: Act::Roar => m.roar_target.present(),
    // rust: Act::Fight => m.attack_target.present(),
    // rust: Act::Investigate => m.disturbance_location.present(),
    // rust: Act::Sniff => m.is_sniffing.present(),
    // rust: Act::Core | Act::Idle => true,
}
}
    // `setActiveActivity`: leaving an activity erases the memory it needed.
set_active :: proc(self: ^Self, a: Act) {
}
    // rust: if self.is_active(a) {
    // rust: return;
}
    // rust: let m = &mut self.mem;
    // rust: match self.activity {
    // rust: Act::Emerge => m.is_emerging.clear(),
    // rust: Act::Roar => m.roar_target.clear(),
    // rust: Act::Fight => m.attack_target.clear(),
    // rust: Act::Investigate => m.disturbance_location.clear(),
    // rust: Act::Sniff => m.is_sniffing.clear(),
    // rust: Act::Core | Act::Dig | Act::Idle => {}
}
    // rust: self.activity = a;
}
    // `WardenAi.updateActivity`: `setActiveActivityToFirstValid`.
update_activity :: proc(self: ^Self) {
}
    // rust: for a in [
    // rust: Act::Emerge,
    // rust: Act::Dig,
    // rust: Act::Roar,
    // rust: Act::Fight,
    // rust: Act::Investigate,
    // rust: Act::Sniff,
    // rust: Act::Idle,
    // rust: ] {
    // rust: if self.requirements_met(a) {
    // rust: self.set_active(a);
    // rust: break;
}
}
}
    // `Sensor.randomlyDelayStart` for both sensors, from the warden's random.
delay_sensors :: proc(self: ^Self, random: ^LegacyRandom) {
}
    // rust: for s in &mut self.sensors {
    // rust: *s = i64::from(random.next_int_bound(20).unwrap_or(0));
}
}
}

// `WardenAi.getActivities`, in the order `Brain.startEachNonRunningBehavior`
// meets the behaviours.
activities :: proc(seed: i64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let gate = Gate {
    // rust: running: false,
    // rust: random: LegacyRandom::new(seed),
    // rust: kids: vec![
    // rust: (B::Stroll(false), 2, 0.0),
    // rust: (B::DoNothing(Timed::new(30, 60)), 1, 0.0),
    // rust: ],
}
    // rust: let mut list = vec![
    // rust: (0, Act::Core, B::Swim(Timed::new(60, 60))),
    // rust: (1, Act::Core, B::SetWardenLookTarget(false)),
    // rust: (2, Act::Core, B::LookAtTargetSink(Timed::new(45, 90))),
    // rust: (
    // rust: 3,
    // rust: Act::Core,
    // rust: B::MoveToTargetSink {
    // rust: t: Timed::new(150, 250),
    // rust: cooldown: 0,
    // rust: path: None,
    // rust: last_target: None,
    // rust: speed: 0.0,
    // rust: },
    // rust: ),
    // rust: (
    // rust: 5,
    // rust: Act::Emerge,
    // rust: B::Emerging(Timed::new(EMERGE_DURATION, EMERGE_DURATION)),
    // rust: ),
    // rust: (0, Act::Dig, B::ForceUnmount(Timed::new(60, 60))),
    // rust: (
    // rust: 1,
    // rust: Act::Dig,
    // rust: B::Digging(Timed::new(DIGGING_DURATION, DIGGING_DURATION)),
    // rust: ),
    // rust: (10, Act::Idle, B::SetRoarTarget(false)),
    // rust: (11, Act::Idle, B::TryToSniff(false)),
    // rust: (12, Act::Idle, B::RunOne(Box::new(gate))),
    // rust: (
    // rust: 10,
    // rust: Act::Roar,
    // rust: B::Roar(Timed::new(ROAR_DURATION, ROAR_DURATION)),
    // rust: ),
    // rust: (10, Act::Fight, B::DigCooldownSetter(false)),
    // rust: (11, Act::Fight, B::StopAttackingIfTargetInvalid(false)),
    // rust: (12, Act::Fight, B::SetEntityLookTarget(false)),
    // rust: (13, Act::Fight, B::SetWalkTargetFromAttackTarget(false)),
    // rust: (
    // rust: 14,
    // rust: Act::Fight,
    // rust: B::SonicBoom(Timed::new(SONIC_DURATION, SONIC_DURATION)),
    // rust: ),
    // rust: (15, Act::Fight, B::MeleeAttack(false)),
    // rust: (5, Act::Investigate, B::SetRoarTarget(false)),
    // rust: (6, Act::Investigate, B::GoToDisturbance(false)),
    // rust: (5, Act::Sniff, B::SetRoarTarget(false)),
    // rust: (
    // rust: 6,
    // rust: Act::Sniff,
    // rust: B::Sniffing(Timed::new(SNIFFING_DURATION, SNIFFING_DURATION)),
    // rust: ),
    // rust: ];
    // A stable sort keeps each activity's own order.
    // rust: list.sort_by_key(|(prio, act, _)| (*prio, act.slot(), act.order()));
    // rust: list.into_iter()
    // rust: .map(|(_, act, b)| Entry { act, b })
    // rust: .collect()
}

// What behaviours read and emit during a brain tick.
Bx :: struct {
    w: ^'a MobWorld<'w>,
    lr: ^'a mut LegacyRandom,
    events: ^'a mut [dynamic]MobEvent,
    now: i64,
}

brain :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.warden.as_ref().map(|w| &w.brain)
}
    // rust: pub(super) fn mem(m: &mut Mob) -> &mut Memories {
    // rust: &mut m.extra.warden.as_mut().expect("a warden").brain.mem
}
// `CANT_REACH_WALK_TARGET_SINCE`, for `compute_path`.
cant_reach :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut mem(m).cant_reach_walk_target_since
}
    // rust: pub(super) fn mem_ref(m: &Mob) -> Option<&Memories> {
    // rust: brain(m).map(|b| &b.mem)
}

// `Brain.tick` (from `Warden.customServerAiStep`).
tick :: proc(m: ^Mob, w: ^MobWorld, lr: ^LegacyRandom, events: ^[dynamic]MobEvent) {
}
    // rust: if m.extra.warden.is_none() {
    // rust: return;
}
    // forgetOutdatedMemories
    // rust: mem(m).tick();
    // rust: tick_sensors(m, w);
    // rust: let Some(st) = m.extra.warden.as_mut() else {
    // rust: return;
}
    // rust: let mut list = std::mem::take(&mut st.brain.list);
    // rust: let mut cx = Bx {
    // rust: w,
    // rust: lr,
    // rust: events,
    // rust: now: w.game_time,
}
    // rust: for e in &mut list {
    // rust: let active = m
    // rust: .extra
    // rust: .warden
    // rust: .as_ref()
    // rust: .is_some_and(|st| st.brain.is_active(e.act));
    // rust: if active && !e.b.running() {
    // rust: e.b.try_start(m, &mut cx);
}
}
    // rust: for e in &mut list {
    // rust: if e.b.running() {
    // rust: e.b.tick_or_stop(m, &mut cx);
}
}
    // rust: if let Some(st) = m.extra.warden.as_mut() {
    // rust: st.brain.list = list;
}
}

// ---- Sensors ------------------------------------------------------------

tick_sensors :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: for i in 0..2 {
    // rust: let fire = {
    // rust: let b = &mut m.extra.warden.as_mut().expect("a warden").brain;
    // rust: b.sensors[i] -= 1;
    // rust: if b.sensors[i] <= 0 {
    // rust: b.sensors[i] = 20;
    // rust: true
    // rust: } else {
    // rust: false
}
}
    // rust: if fire {
    // rust: if i == 0 {
    // rust: sense_players(m, w);
    // rust: } else {
    // rust: sense_entities(m, w);
}
}
}
}
// `TargetingConditions.forNonCombat().range(followRange)` (sensors use the
// follow range of the mob that scanned last).
targetable :: proc(m: ^Mob, w: ^MobWorld, who: Who) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let range = m.attrs.follow_range;
    // rust: match who {
    // rust: Who::Player => m.can_see_player(w, range),
    // rust: Who::Mob(id) => {
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: s.alive && m.distance_sqr(s.position) <= range.max(2.0).powi(2) && m.sees(w, who)
}
}
}
// `PlayerSensor`.
sense_players :: proc(m: ^Mob, w: ^MobWorld) {
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
    // rust: .filter(|_| m.can_target_player(w, range, true))
    // rust: .collect();
    // rust: let mm = mem(m);
    // rust: mm.nearest_players.set_list(players);
    // rust: mm.nearest_visible_player.set_opt(visible.first().copied());
    // rust: mm.nearest_visible_targetable_players
    // rust: .set_list(attackable.clone());
    // rust: mm.nearest_visible_targetable_player
    // rust: .set_opt(attackable.first().copied());
}
// `WardenEntitySensor`: `NearestLivingEntitySensor`, then the nearest
// targetable player, else the nearest other targetable entity.
sense_entities :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let r = m.attrs.follow_range;
    // rust: let area = m.bounds().inflate(Vec3::new(r, r, r));
    // rust: let mut found: Vec<(Who, f64)> = Vec::new();
    // rust: for o in w.others_near(area) {
    // rust: if o.id != m.id && o.alive && o.bounds.intersects(area) {
    // rust: found.push((Who::Mob(o.id), m.distance_sqr(o.position)));
}
}
    // rust: if let Some(p) = &w.player
    // rust: && p.alive
    // rust: && p.bounds.intersects(area)
    // rust: {
    // rust: found.push((Who::Player, m.distance_sqr(p.position)));
}
    // rust: found.sort_by(|a, b| a.1.total_cmp(&b.1));
    // rust: let list: Vec<Who> = found.into_iter().map(|(w, _)| w).collect();
    // rust: let attackable = list
    // rust: .iter()
    // rust: .copied()
    // rust: .find(|&e| e == Who::Player && warden::can_target(w, e))
    // rust: .or_else(|| {
    // rust: list.iter()
    // rust: .copied()
    // rust: .find(|&e| e != Who::Player && warden::can_target(w, e))
    // rust: });
    // rust: let mm = mem(m);
    // rust: mm.mobs.set_list(list.clone());
    // rust: mm.visible_mobs.set(Visible {
    // rust: list,
    // rust: cache: Vec::new(),
    // rust: });
    // rust: mm.nearest_attackable.set_opt(attackable);
}
// The visible-entities memory's line-of-sight test, cached per memory.
visible_test :: proc(m: ^Mob, w: ^MobWorld, who: Who) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match mem_ref(m).and_then(|mm| mm.visible_mobs.get()) {
    // rust: Some(v) => {
    // rust: if let Some(&(_, r)) = v.cache.iter().find(|(k, _)| *k == who) {
    // rust: return r;
}
}
    // rust: None => return false,
}
    // Sensor.isEntityTargetable: the attack target ignores invisibility.
    // rust: let r = targetable(m, w, who);
    // rust: if let Some(v) = mem(m).visible_mobs.get_mut() {
    // rust: v.cache.push((who, r));
}
    // rust: r
}
// `NearestVisibleLivingEntities.contains(entity)`.
visible_contains :: proc(m: ^Mob, w: ^MobWorld, who: Who) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let listed = mem_ref(m)
    // rust: .and_then(|mm| mm.visible_mobs.get())
    // rust: .is_some_and(|v| v.list.contains(&who));
    // rust: listed && visible_test(m, w, who)
}
// `NearestVisibleLivingEntities.findClosest`.
find_closest :: proc(m: ^Mob, w: ^MobWorld, filter: impl Fn(^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let list = mem_ref(m)?.visible_mobs.get()?.list.clone();
    // rust: list.into_iter()
    // rust: .find(|&who| filter(m, who) && visible_test(m, w, who))
}

// ---- Shared warden actions ------------------------------------------------

block_of :: proc(p: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32]
}
dist_sqr :: proc(a: [i32; 3], b: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (0..3).map(|i| i64::from(a[i] - b[i]).pow(2)).sum()
}
// `WardenAi.setDigCooldown`.
    // rust: pub(super) fn set_dig_cooldown(m: &mut Mob) {
    // rust: let mm = mem(m);
    // rust: if mm.dig_cooldown.present() {
    // rust: mm.dig_cooldown.set_ttl((), DIGGING_COOLDOWN);
}
}
// `WardenAi.setDisturbanceLocation`.
    // rust: pub(super) fn set_disturbance(m: &mut Mob, w: &MobWorld, position: [i32; 3]) {
    // rust: if warden::entity_angry_at(m, w).is_some() || mem(m).attack_target.present() {
    // rust: return;
}
    // rust: set_dig_cooldown(m);
    // rust: let mm = mem(m);
    // rust: mm.sniff_cooldown.set_ttl((), DISTURBANCE_EXPIRY);
    // rust: mm.look_target
    // rust: .set_ttl(Tracker::Block(position), DISTURBANCE_EXPIRY);
    // rust: mm.disturbance_location
    // rust: .set_ttl(position, DISTURBANCE_EXPIRY);
    // rust: mm.walk_target.clear();
}
// `Warden.setAttackTarget`.
    // rust: pub(super) fn set_attack_target(m: &mut Mob, target: Who) {
    // rust: let mm = mem(m);
    // rust: mm.roar_target.clear();
    // rust: mm.attack_target.set(target);
    // rust: mm.cant_reach_walk_target_since.clear();
    // rust: mm.sonic_boom_cooldown.set_ttl((), 200);
}
// `Entity.closerThan(target, horizontal, vertical)`.
closer_than :: proc(m: ^Mob, p: Vec3, horizontal: f64, vertical: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (dx, dy, dz) = (p.x - m.position.x, p.y - m.position.y, p.z - m.position.z);
    // rust: dx * dx + dz * dz < horizontal * horizontal && dy * dy < vertical * vertical
}
// `PositionTracker.isVisibleBy`.
tracker_visible :: proc(m: ^Mob, w: ^MobWorld, t: Tracker) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tracker::Entity(who, _) => {
    // rust: w.target_info(who).is_some_and(|i| i.alive) && visible_contains(m, w, who)
}
    // rust: _ => true,
}
}
same_path :: proc(a: Maybe(^Path), b: Maybe(^Path)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (a, b) {
    // rust: (None, None) => true,
    // rust: (Some(a), Some(b)) => a.nodes == b.nodes && a.target == b.target,
    // rust: _ => false,
}
}
sound :: proc(m: ^Mob, name: ^'static str, volume: f32, pitch: f32, events: ^[dynamic]MobEvent) {
}
    // rust: events.push(MobEvent::Sound(
    // rust: name,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: volume,
    // rust: pitch,
    // rust: ));
}

// ---- Behaviours -----------------------------------------------------------

    // rust: impl B {
running :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: B::Swim(t)
    // rust: | B::LookAtTargetSink(t)
    // rust: | B::Emerging(t)
    // rust: | B::ForceUnmount(t)
    // rust: | B::Digging(t)
    // rust: | B::DoNothing(t)
    // rust: | B::Sniffing(t)
    // rust: | B::Roar(t)
    // rust: | B::SonicBoom(t) => t.running,
    // rust: B::MoveToTargetSink { t, .. } => t.running,
    // rust: B::RunOne(g) => g.running,
    // rust: B::SetWardenLookTarget(r)
    // rust: | B::SetRoarTarget(r)
    // rust: | B::TryToSniff(r)
    // rust: | B::Stroll(r)
    // rust: | B::GoToDisturbance(r)
    // rust: | B::DigCooldownSetter(r)
    // rust: | B::StopAttackingIfTargetInvalid(r)
    // rust: | B::SetEntityLookTarget(r)
    // rust: | B::SetWalkTargetFromAttackTarget(r)
    // rust: | B::MeleeAttack(r) => *r,
}
}

    // `BehaviorControl.tryStart`.
try_start :: proc(self: ^Self, m: ^Mob, cx: ^Bx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: B::Swim(t) => {
    // rust: if !swim_condition(m) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::SetWardenLookTarget(r) => one(r, || {
    // rust: let mm = mem(m);
    // rust: if mm.attack_target.present() {
    // rust: return false;
}
    // rust: let target = mm
    // rust: .roar_target
    // rust: .value()
    // rust: .and_then(|who| cx.w.target_info(who))
    // rust: .map(|t| block_of(t.position))
    // rust: .or_else(|| mm.disturbance_location.value());
    // rust: let Some(p) = target else { return false };
    // rust: mem(m).look_target.set(Tracker::Block(p));
    // rust: true
    // rust: }),
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
    // rust: let Some(walk) = mm.walk_target.value() else {
    // rust: return false;
}
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
    // rust: B::Emerging(t) => {
    // rust: let mm = mem(m);
    // rust: if !mm.is_emerging.present() || mm.walk_target.present() {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: warden::set_pose(m, Pose::Emerging);
    // rust: sound(m, "entity.warden.emerge", 5.0, 1.0, cx.events);
    // rust: true
}
            // ForceUnmount: a warden never rides (Warden.canRide).
    // rust: B::ForceUnmount(_) => false,
    // rust: B::Digging(t) => {
    // rust: let mm = mem(m);
    // rust: if mm.attack_target.present() || mm.walk_target.present() {
    // rust: return false;
}
    // rust: let liquid = m.fluids.in_water || m.fluids.in_lava;
    // rust: if !(m.on_ground || liquid) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: if m.on_ground {
    // rust: warden::set_pose(m, Pose::Digging);
    // rust: sound(m, "entity.warden.dig", 5.0, 1.0, cx.events);
    // rust: } else {
    // rust: sound(m, "entity.warden.agitated", 5.0, 1.0, cx.events);
                    // `stop` without `doStop`: discarded, still running.
    // rust: m.removed = true;
}
    // rust: true
}
    // rust: B::SetRoarTarget(r) => one(r, || {
    // rust: let mm = mem(m);
    // rust: if mm.roar_target.present() || mm.attack_target.present() {
    // rust: return false;
}
    // rust: let Some(target) = warden::entity_angry_at(m, cx.w) else {
    // rust: return false;
}
    // rust: if !warden::can_target(cx.w, target) {
    // rust: return false;
}
    // rust: let mm = mem(m);
    // rust: mm.roar_target.set(target);
    // rust: mm.cant_reach_walk_target_since.clear();
    // rust: true
    // rust: }),
    // rust: B::TryToSniff(r) => one(r, || {
    // rust: let mm = mem(m);
    // rust: if mm.sniff_cooldown.present()
    // rust: || !mm.nearest_attackable.present()
    // rust: || mm.disturbance_location.present()
    // rust: {
    // rust: return false;
}
    // rust: mm.is_sniffing.set(());
                // UniformInt.of(100, 200).sample(level.getRandom())
    // rust: let cooldown = 100 + cx.lr.next_int_bound(101).unwrap_or(0);
    // rust: let mm = mem(m);
    // rust: mm.sniff_cooldown.set_ttl((), i64::from(cooldown));
    // rust: mm.walk_target.clear();
    // rust: warden::set_pose(m, Pose::Sniffing);
    // rust: true
    // rust: }),
    // rust: B::RunOne(g) => {
    // rust: if mem(m).is_sniffing.present() {
    // rust: return false;
}
    // rust: g.running = true;
                // ShufflingList.shuffle: a fresh weight for each entry in the
                // current order, then a stable sort.
    // rust: for k in &mut g.kids {
    // rust: let r = g.random.next_float();
    // rust: k.2 = -horizon_core::jmath::pow(f64::from(r), f64::from(1.0_f32 / k.1 as f32));
}
    // rust: g.kids.sort_by(|a, b| a.2.total_cmp(&b.2));
    // rust: for k in &mut g.kids {
    // rust: if !k.0.running() && k.0.try_start(m, cx) {
    // rust: break;
}
}
    // rust: true
}
    // rust: B::Stroll(r) => one(r, || {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
                // RandomStroll.stroll(0.5): LandRandomPos.getPos(body, 10, 7).
    // rust: let target = m.land_random_pos(cx.w, 10, 7);
    // rust: mem(m).walk_target.set_opt(target.map(|p| WalkTarget {
    // rust: target: Tracker::Block([
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ]),
    // rust: speed: 0.5,
    // rust: close: 0,
    // rust: }));
    // rust: true
    // rust: }),
    // rust: B::DoNothing(t) => {
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::GoToDisturbance(r) => one(r, || {
    // rust: let mm = mem(m);
    // rust: if mm.attack_target.present() || mm.walk_target.present() {
    // rust: return false;
}
    // rust: let Some(p) = mm.disturbance_location.value() else {
    // rust: return false;
}
                // Vec3i.closerThan(body.blockPosition(), 2)
    // rust: if dist_sqr(p, block_of(m.position)) >= 4 {
                    // GoToTargetLocation.getNearbyPos: the level random.
    // rust: let dx = cx.lr.next_int_bound(3).unwrap_or(0) - 1;
    // rust: let dz = cx.lr.next_int_bound(3).unwrap_or(0) - 1;
    // rust: let near = [p[0] + dx, p[1], p[2] + dz];
    // rust: let mm = mem(m);
    // rust: mm.look_target.set(Tracker::Block(near));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Block(near),
    // rust: speed: 0.7,
    // rust: close: 2,
    // rust: });
}
    // rust: true
    // rust: }),
    // rust: B::Sniffing(t) => {
    // rust: let mm = mem(m);
    // rust: if !mm.is_sniffing.present()
    // rust: || mm.attack_target.present()
    // rust: || mm.walk_target.present()
    // rust: {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: sound(m, "entity.warden.sniff", 5.0, 1.0, cx.events);
    // rust: true
}
    // rust: B::Roar(t) => {
    // rust: let mm = mem(m);
    // rust: if mm.attack_target.present() {
    // rust: return false;
}
    // rust: let Some(target) = mm.roar_target.value() else {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: let mm = mem(m);
    // rust: mm.roar_sound_delay.set_ttl((), ROAR_SOUND_DELAY);
    // rust: mm.walk_target.clear();
                // BehaviorUtils.lookAtEntity
    // rust: mm.look_target.set(Tracker::Entity(target, true));
    // rust: warden::set_pose(m, Pose::Roaring);
    // rust: warden::increase_anger(m, cx.w, Some(target), 20, false, cx.events);
    // rust: true
}
    // rust: B::DigCooldownSetter(r) => one(r, || {
    // rust: set_dig_cooldown(m);
    // rust: true
    // rust: }),
    // rust: B::StopAttackingIfTargetInvalid(r) => one(r, || {
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return false;
}
    // rust: let alive = cx.w.target_info(target).is_some_and(|t| t.alive);
    // rust: let can = warden::can_target(cx.w, target);
    // rust: let angry = warden::anger_level(m).is_angry();
    // rust: if can && alive && angry {
    // rust: return true;
}
                // WardenAi.onTargetInvalid
    // rust: if !can && let Some(st) = m.extra.warden.as_mut() {
    // rust: st.anger.clear(target);
}
    // rust: set_dig_cooldown(m);
    // rust: mem(m).attack_target.clear();
    // rust: true
    // rust: }),
    // rust: B::SetEntityLookTarget(r) => one(r, || {
    // rust: let mm = mem(m);
    // rust: if mm.look_target.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: let target = mm.attack_target.value();
    // rust: let max = (FOLLOW_RANGE as f32 * FOLLOW_RANGE as f32) as f64;
    // rust: let w = cx.w;
    // rust: let found = find_closest(m, w, |m, who| {
    // rust: Some(who) == target
    // rust: && w.target_info(who)
    // rust: .is_some_and(|t| m.distance_sqr(t.position) <= max)
    // rust: });
    // rust: let Some(found) = found else { return false };
    // rust: mem(m).look_target.set(Tracker::Entity(found, true));
    // rust: true
    // rust: }),
    // rust: B::SetWalkTargetFromAttackTarget(r) => one(r, || {
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let in_reach = mem(m).visible_mobs.present()
    // rust: && visible_contains(m, w, target)
    // rust: && w.target_info(target)
    // rust: .is_some_and(|t| m.within_melee_range(&t));
    // rust: let mm = mem(m);
    // rust: if in_reach {
    // rust: mm.walk_target.clear();
    // rust: } else {
    // rust: mm.look_target.set(Tracker::Entity(target, true));
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity(target, false),
    // rust: speed: 1.2,
    // rust: close: 0,
    // rust: });
}
    // rust: true
    // rust: }),
    // rust: B::SonicBoom(t) => {
    // rust: let mm = mem(m);
    // rust: if mm.sonic_boom_cooldown.present() {
    // rust: return false;
}
    // rust: let Some(target) = mm.attack_target.value() else {
    // rust: return false;
}
    // rust: let close =
    // rust: cx.w.target_info(target)
    // rust: .is_some_and(|i| closer_than(m, i.position, 15.0, 20.0));
    // rust: if !close {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: let mm = mem(m);
    // rust: mm.attack_cooling_down
    // rust: .set_ttl(true, i64::from(SONIC_DURATION));
    // rust: mm.sonic_boom_sound_delay.set_ttl((), SONIC_SOUND_DELAY);
                // Entity event 62: the sonic boom keyframes start.
    // rust: m.anim.states[warden::SONIC_BOOM].start(m.age as f32);
    // rust: cx.events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 62,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
    // rust: sound(m, "entity.warden.sonic_charge", 3.0, 1.0, cx.events);
    // rust: true
}
    // rust: B::MeleeAttack(r) => one(r, || {
    // rust: let mm = mem(m);
    // rust: if mm.attack_cooling_down.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: let Some(target) = mm.attack_target.value() else {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let Some(info) = w.target_info(target) else {
    // rust: return false;
}
    // rust: if !(m.within_melee_range(&info) && visible_contains(m, w, target)) {
    // rust: return false;
}
    // rust: mem(m).look_target.set(Tracker::Entity(target, true));
    // rust: m.swing();
    // rust: warden::do_hurt_target(m, target, w, cx.lr, cx.events);
    // rust: mem(m)
    // rust: .attack_cooling_down
    // rust: .set_ttl(true, MELEE_ATTACK_COOLDOWN);
    // rust: true
    // rust: }),
}
}

    // `BehaviorControl.tickOrStop`.
tick_or_stop :: proc(self: ^Self, m: ^Mob, cx: ^Bx) {
}
    // rust: let now = cx.now;
    // rust: match self {
    // rust: B::Swim(t) => {
    // rust: if now > t.end || !swim_condition(m) {
    // rust: self.do_stop(m, cx);
    // rust: } else if m.random.next_float() < 0.8 {
    // rust: m.ai.jumping = true;
}
}
    // rust: B::LookAtTargetSink(t) => {
    // rust: let target = mem(m).look_target.value();
    // rust: let visible = match target {
    // rust: Some(tr) => tracker_visible(m, cx.w, tr),
    // rust: None => false,
}
    // rust: if now > t.end || !visible {
    // rust: self.do_stop(m, cx);
    // rust: } else if let Some(at) = target.and_then(|tr| tr.position(cx.w)) {
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
    // rust: && mem(m).walk_target.value().is_some_and(|walk| {
    // rust: !m.ai.nav.is_done()
    // rust: && !reached(m, cx.w, &walk)
    // rust: && !matches!(walk.target, Tracker::Entity(Who::Player, _)
    // rust: if cx.w.player.as_ref().is_some_and(|p| p.spectator))
    // rust: });
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
    // rust: && dist_sqr(now_target, last) > 4
    // rust: && compute_path(m, cx.w, cx.now, &walk, path, speed, cant_reach)
    // rust: {
    // rust: *last_target = Some(now_target);
    // rust: mem(m).path.set_opt(path.clone());
    // rust: m.nav_move_to_path(cx.w, path.clone(), f64::from(*speed));
}
}
            // canStillUse is true: they run their duration.
    // rust: B::Emerging(t) | B::Sniffing(t) => {
    // rust: if now > t.end {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::ForceUnmount(t) => {
    // rust: if now > t.end {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::Digging(t) => {
    // rust: if now > t.end || m.removed {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::DoNothing(t) => {
    // rust: if now > t.end {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::RunOne(g) => {
    // rust: for k in &mut g.kids {
    // rust: if k.0.running() {
    // rust: k.0.tick_or_stop(m, cx);
}
}
    // rust: if !g.kids.iter().any(|k| k.0.running()) {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::Roar(t) => {
    // rust: if now > t.end {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: let mm = mem(m);
    // rust: if !mm.roar_sound_delay.present() && !mm.roar_sound_cooldown.present() {
    // rust: mm.roar_sound_cooldown
    // rust: .set_ttl((), i64::from(ROAR_DURATION) - ROAR_SOUND_DELAY);
    // rust: sound(m, "entity.warden.roar", 3.0, 1.0, cx.events);
}
}
    // rust: B::SonicBoom(t) => {
    // rust: if now > t.end {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: warden::tick_sonic_boom(m, cx.w, cx.events);
}
            // OneShot.tickOrStop: they stop the tick they ran.
    // rust: _ => self.do_stop(m, cx),
}
}

    // `BehaviorControl.doStop`.
do_stop :: proc(self: ^Self, m: ^Mob, cx: ^Bx) {
}
    // rust: match self {
    // rust: B::Swim(t) | B::ForceUnmount(t) | B::DoNothing(t) => t.running = false,
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
    // rust: B::Emerging(t) => {
    // rust: t.running = false;
    // rust: if warden::pose(m) == Pose::Emerging {
    // rust: warden::set_pose(m, Pose::Standing);
}
}
    // rust: B::Digging(t) => {
    // rust: t.running = false;
    // rust: m.removed = true;
}
    // rust: B::RunOne(g) => {
    // rust: g.running = false;
    // rust: for k in &mut g.kids {
    // rust: if k.0.running() {
    // rust: k.0.do_stop(m, cx);
}
}
}
    // rust: B::Sniffing(t) => {
    // rust: t.running = false;
    // rust: if warden::pose(m) == Pose::Sniffing {
    // rust: warden::set_pose(m, Pose::Standing);
}
    // rust: mem(m).is_sniffing.clear();
    // rust: let w = cx.w;
    // rust: if let Some(entity) = mem(m).nearest_attackable.value()
    // rust: && warden::can_target(w, entity)
    // rust: && let Some(info) = w.target_info(entity)
    // rust: {
    // rust: if closer_than(m, info.position, 6.0, 20.0) {
    // rust: warden::increase_anger(m, w, Some(entity), 35, true, cx.events);
}
    // rust: if !mem(m).disturbance_location.present() {
    // rust: set_disturbance(m, w, block_of(info.position));
}
}
}
    // rust: B::Roar(t) => {
    // rust: t.running = false;
    // rust: if warden::pose(m) == Pose::Roaring {
    // rust: warden::set_pose(m, Pose::Standing);
}
    // rust: if let Some(target) = mem(m).roar_target.value() {
    // rust: set_attack_target(m, target);
}
    // rust: mem(m).roar_target.clear();
}
    // rust: B::SonicBoom(t) => {
    // rust: t.running = false;
    // rust: mem(m).sonic_boom_cooldown.set_ttl((), 40);
}
    // rust: B::SetWardenLookTarget(r)
    // rust: | B::SetRoarTarget(r)
    // rust: | B::TryToSniff(r)
    // rust: | B::Stroll(r)
    // rust: | B::GoToDisturbance(r)
    // rust: | B::DigCooldownSetter(r)
    // rust: | B::StopAttackingIfTargetInvalid(r)
    // rust: | B::SetEntityLookTarget(r)
    // rust: | B::SetWalkTargetFromAttackTarget(r)
    // rust: | B::MeleeAttack(r) => *r = false,
}
}
}

// `OneShot.tryStart`: running when the trigger fires.
one :: proc(running: ^bool, f: impl FnOnce() -> b {
    // Ported from Horizon
    return {}
}
    // rust: if f() {
    // rust: *running = true;
    // rust: true
    // rust: } else {
    // rust: false
}
}
// `Swim`: deeper than the jump threshold, or in lava.
swim_condition :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.fluids.water > m.fluid_jump_threshold() || m.fluids.in_lava
}
// The `Cx` the mob library's attacks take.
    // rust: pub(super) fn cx<'a, 'w>(
    // rust: w: &'a MobWorld<'w>,
    // rust: lr: &'a mut LegacyRandom,
    // rust: events: &'a mut Vec<MobEvent>,
    // rust: ) -> Cx<'a, 'w> {
    // rust: Cx { w, lr, events }
}

// ---- Printing ---------------------------------------------------------------

who :: proc(w: Who) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match w {
    // rust: Who::Player => "player".into(),
    // rust: Who::Mob(id) => format!("e{id}"),
}
}
pos :: proc(p: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{},{},{}", p[0], p[1], p[2])
}
tracker :: proc(t: Tracker) -> S {
    // Ported from Horizon
    return {}
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
// The active activities and the memories with values, as the mob AI oracle
// prints them (`act core|idle`, `mem name=value...` sorted).
describe :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let b = brain(m)?;
    // rust: let mut acts = ["core", b.activity.name()];
    // rust: acts.sort_unstable();
    // rust: let mm = &b.mem;
    // rust: let mut out: Vec<String> = Vec::new();
    // rust: let mut put = |name: &str, value: String, ttl: i64| {
    // rust: if ttl == i64::MAX {
    // rust: out.push(format!("{name}={value}"));
    // rust: } else {
    // rust: out.push(format!("{name}={value}@{ttl}"));
}
}
    // rust: macro_rules! slot {
    // rust: ($name:expr, $s:expr, $f:expr) => {
    // rust: if let Some(v) = $s.get() {
    // rust: put($name, $f(v), $s.ttl());
}
}
}
    // rust: let unit = |_: &()| "u".to_string();
    // rust: let list = |l: &Vec<Who>| format!("n{}", l.len());
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
    // rust: slot!("mobs", mm.mobs, list);
    // rust: slot!("visible_mobs", mm.visible_mobs, |_: &Visible| {
    // rust: "NearestVisibleLivingEntities".to_string()
    // rust: });
    // rust: slot!("nearest_attackable", mm.nearest_attackable, |e: &Who| who(
    // rust: *e
    // rust: ));
    // rust: slot!("look_target", mm.look_target, |t: &Tracker| tracker(*t));
    // rust: slot!("walk_target", mm.walk_target, |t: &WalkTarget| format!(
    // rust: "{}/{:x}/{}",
    // rust: tracker(t.target),
    // rust: t.speed.to_bits(),
    // rust: t.close
    // rust: ));
    // rust: slot!("path", mm.path, |p: &Path| format!("path{}", pos(p.target)));
    // rust: slot!(
    // rust: "cant_reach_walk_target_since",
    // rust: mm.cant_reach_walk_target_since,
    // rust: |t: &i64| t.to_string()
    // rust: );
    // rust: slot!("attack_target", mm.attack_target, |e: &Who| who(*e));
    // rust: slot!("attack_cooling_down", mm.attack_cooling_down, |t: &bool| t
    // rust: .to_string());
    // rust: slot!("roar_target", mm.roar_target, |e: &Who| who(*e));
    // rust: slot!(
    // rust: "disturbance_location",
    // rust: mm.disturbance_location,
    // rust: |p: &[i32; 3]| pos(*p)
    // rust: );
    // rust: slot!("recent_projectile", mm.recent_projectile, unit);
    // rust: slot!("is_sniffing", mm.is_sniffing, unit);
    // rust: slot!("is_emerging", mm.is_emerging, unit);
    // rust: slot!("roar_sound_delay", mm.roar_sound_delay, unit);
    // rust: slot!("dig_cooldown", mm.dig_cooldown, unit);
    // rust: slot!("roar_sound_cooldown", mm.roar_sound_cooldown, unit);
    // rust: slot!("sniff_cooldown", mm.sniff_cooldown, unit);
    // rust: slot!("touch_cooldown", mm.touch_cooldown, unit);
    // rust: slot!("vibration_cooldown", mm.vibration_cooldown, unit);
    // rust: slot!("sonic_boom_cooldown", mm.sonic_boom_cooldown, unit);
    // rust: slot!(
    // rust: "sonic_boom_sound_cooldown",
    // rust: mm.sonic_boom_sound_cooldown,
    // rust: unit
    // rust: );
    // rust: slot!("sonic_boom_sound_delay", mm.sonic_boom_sound_delay, unit);
    // rust: out.sort();
    // rust: Some((acts.join("|"), out.join(" ")))
}
