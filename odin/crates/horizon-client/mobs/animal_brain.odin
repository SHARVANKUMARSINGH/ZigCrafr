//! Transpiled from Horizon Rust crate
package horizon_client_animal_brain

import "core:fmt"
import "core:mem"
import "core:math"

// The `Brain`s of the sniffer (`SnifferAi`) and the ghastling
// (`HappyGhastAi`), ported behaviour for behaviour: memories that expire,
// the sensors and their scan rates, the activities and their
// requirements, and the behaviours of each activity, started and ticked in
// vanilla's order (priority, then the activity's slot in
// `Brain.availableBehaviorsByPriority`'s hash map, then insertion order).
//
// The level random (`ServerLevel.getRandom`) times behaviours; the mob's
// own random drives positions, sounds and jumps. `RunOne` shuffles with a
// random of its own, seeded with the brain's `shuffle_seed` when it is
// built.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species, Who,
    // rust: brain::{Timed, living_near},
    // rust: path::{Path, PathNode},
    // rust: sniffer,
}
// use horizon_core::{
    // rust: geometry::Vec3,
    // rust: random::{LegacyRandom, RandomSource},
}

// `MemorySlot.NEVER_EXPIRE`.
NEVER :: i64::MAX

// `MemorySlot`: a value and its time to live.
Slot :: struct {
    v: Maybe(T),
    ttl: i64,
}
    // rust: impl<T> Default for Slot<T> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: v: None,
    // rust: ttl: NEVER,
}
}
}
    // rust: impl<T> Slot<T> {
tick :: proc(self: ^Self) {
}
    // rust: if self.v.is_some() && self.ttl != NEVER {
    // rust: if self.ttl <= 0 {
    // rust: self.clear();
    // rust: } else {
    // rust: self.ttl -= 1;
}
}
}
set :: proc(self: ^Self, v: T) {
}
    // rust: self.v = Some(v);
    // rust: self.ttl = NEVER;
}
set_ttl :: proc(self: ^Self, v: T, ttl: i64) {
}
    // rust: self.v = Some(v);
    // rust: self.ttl = ttl;
}
set_opt :: proc(self: ^Self, v: Maybe(T)) {
}
    // rust: match v {
    // rust: Some(v) => self.set(v),
    // rust: None => self.clear(),
}
}
clear :: proc(self: ^Self) {
}
    // rust: self.v = None;
    // rust: self.ttl = NEVER;
}
get :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.v.as_ref()
}
present :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.v.is_some()
}
    // `MemorySlot.timeToLive`: `i64::MAX` denotes a permanent memory.
ttl :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.ttl
}
}
    // rust: impl<T: Clone> Slot<T> {
value :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.v.clone()
}
}
    // rust: impl<T> Slot<Vec<T>> {
    // `Brain.setMemory` of a collection: an empty one erases the memory.
set_list :: proc(self: ^Self, v: [dynamic]T) {
}
    // rust: if v.is_empty() {
    // rust: self.clear();
    // rust: } else {
    // rust: self.set(v);
}
}
}

// `PositionTracker`: an entity (`EntityTracker`: at its eyes or feet, and
// whether its block is the one at its eyes) or a block (`BlockPosTracker`).
Tracker :: enum {
    Entity {,
    who: Who,
    eye: bool,
    block_eye: bool,
    // rust: },
    Block([i32; 3]),
}
    // rust: impl Tracker {
entity :: proc(who: Who, eye: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Tracker::Entity {
    // rust: who,
    // rust: eye,
    // rust: block_eye: false,
}
}
    // `currentPosition`.
position :: proc(self: ^Self, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match *self {
    // rust: Tracker::Entity { who, eye, .. } => w.target_info(who).map(|t| {
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
}
}
    // `currentBlockPosition`.
block :: proc(self: ^Self, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match *self {
    // rust: Tracker::Entity { who, block_eye, .. } => w.target_info(who).map(|t| {
    // rust: if block_eye {
    // rust: block_of(Vec3::new(t.position.x, t.eye_y, t.position.z))
    // rust: } else {
    // rust: block_of(t.position)
}
    // rust: }),
    // rust: Tracker::Block(p) => Some(p),
}
}
}
block_of :: proc(p: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32]
}

// `WalkTarget`.
WalkTarget :: struct {
    target: Tracker,
    speed: f32,
    close: i32,
}
    // rust: impl WalkTarget {
    // `new WalkTarget(Vec3, ...)`: the block containing the point.
point :: proc(p: [f64; 3], speed: f32, close: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: target: Tracker::Block([
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ]),
    // rust: speed,
    // rust: close,
}
}
}

// `NearestVisibleLivingEntities`: the nearby entities and a lazily filled
// cache of `Sensor.isEntityTargetable`.
Visible :: struct {
    list: [dynamic]Who,
    cache: Vec<(Who,
}

// The memories these brains register.
Memories :: struct {
    mobs: Slot<[dynamic]Who>,
    visible_mobs: Slot<Visible>,
    nearest_players: Slot<[dynamic]Who>,
    nearest_visible_player: Slot<Who>,
    nearest_visible_targetable_player: Slot<Who>,
    nearest_visible_targetable_players: Slot<[dynamic]Who>,
    nearest_visible_adult: Slot<Who>,
    walk_target: Slot<WalkTarget>,
    look_target: Slot<Tracker>,
    breed_target: Slot<Who>,
    path: Slot<Path>,
    // `HURT_BY`: whether the damage is one of `#panic_causes`.
    hurt_by: Slot<bool>,
    hurt_by_entity: Slot<Who>,
    cant_reach_walk_target_since: Slot<i64>,
    tempting_player: Slot<Who>,
    temptation_cooldown_ticks: Slot<i32>,
    is_panicking: Slot<bool>,
    sniffer_digging: Slot<bool>,
    sniffer_sniffing_target: Slot<[i32,
    sniffer_happy: Slot<bool>,
    sniff_cooldown: Slot<()>,
    gaze_cooldown_ticks: Slot<i32>,
    transport_items_cooldown_ticks: Slot<i32>,
    nearest_attackable: Slot<Who>,
    attack_target: Slot<Who>,
    attack_cooling_down: Slot<bool>,
    hunting_cooldown: Slot<bool>,
    play_dead_ticks: Slot<i32>,
    visited_block_positions: Slot<Vec<[i32,
    unreachable_transport_block_positions: Slot<Vec<[i32,
    // `DOORS_TO_CLOSE`: the doors it opened or passed through.
    doors_to_close: Slot<Vec<[i32,
}
    // rust: impl Memories {
tick :: proc(self: ^Self) {
}
    // rust: self.nearest_attackable.tick();
    // rust: self.attack_target.tick();
    // rust: self.attack_cooling_down.tick();
    // rust: self.hunting_cooldown.tick();
    // rust: self.play_dead_ticks.tick();
    // rust: self.mobs.tick();
    // rust: self.visible_mobs.tick();
    // rust: self.nearest_players.tick();
    // rust: self.nearest_visible_player.tick();
    // rust: self.nearest_visible_targetable_player.tick();
    // rust: self.nearest_visible_targetable_players.tick();
    // rust: self.nearest_visible_adult.tick();
    // rust: self.walk_target.tick();
    // rust: self.look_target.tick();
    // rust: self.breed_target.tick();
    // rust: self.path.tick();
    // rust: self.hurt_by.tick();
    // rust: self.hurt_by_entity.tick();
    // rust: self.cant_reach_walk_target_since.tick();
    // rust: self.tempting_player.tick();
    // rust: self.temptation_cooldown_ticks.tick();
    // rust: self.is_panicking.tick();
    // rust: self.sniffer_digging.tick();
    // rust: self.sniffer_sniffing_target.tick();
    // rust: self.sniffer_happy.tick();
    // rust: self.sniff_cooldown.tick();
    // rust: self.gaze_cooldown_ticks.tick();
    // rust: self.transport_items_cooldown_ticks.tick();
    // rust: self.visited_block_positions.tick();
    // rust: self.unreachable_transport_block_positions.tick();
    // rust: self.doors_to_close.tick();
}
}

// `Activity`.
Act :: enum {
    Core,
    Fight,
    PlayDead,
    Idle,
    Sniff,
    Dig,
    Panic,
}
    // rust: impl Act {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Act::Core => "core",
    // rust: Act::Fight => "fight",
    // rust: Act::PlayDead => "play_dead",
    // rust: Act::Idle => "idle",
    // rust: Act::Sniff => "sniff",
    // rust: Act::Dig => "dig",
    // rust: Act::Panic => "panic",
}
}
}

// Which brain.
Kind :: enum {
    Axolotl,
    Sniffer,
    // A happy ghast (the brain ticks while it is a ghastling).
    Ghastling,
    // `CopperGolemAi`.
    CopperGolem,
    // `TadpoleAi`.
    Tadpole,
}

Sensor :: enum {
    Living,
    AxolotlAttackables,
    AdultSameType,
    HurtBy,
    Players,
    Tempting,
    AdultAnyType,
}
    // rust: impl Kind {
    // `BRAIN_PROVIDER`'s sensors, in order (all scan every 20 ticks).
sensors :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Kind::Axolotl => &[
    // rust: Sensor::Living,
    // rust: Sensor::AdultSameType,
    // rust: Sensor::HurtBy,
    // rust: Sensor::AxolotlAttackables,
    // rust: Sensor::Tempting,
    // rust: ],
    // rust: Kind::Sniffer => &[
    // rust: Sensor::Living,
    // rust: Sensor::HurtBy,
    // rust: Sensor::Players,
    // rust: Sensor::Tempting,
    // rust: ],
    // rust: Kind::Ghastling => &[
    // rust: Sensor::Living,
    // rust: Sensor::HurtBy,
    // rust: Sensor::Tempting,
    // rust: Sensor::AdultAnyType,
    // rust: Sensor::Players,
    // rust: ],
    // rust: Kind::CopperGolem => &[Sensor::Living, Sensor::HurtBy],
            // `Tadpole.SENSOR_TYPES`: the living entities, the players, what hurt it and
            // the frog food players hold.
    // rust: Kind::Tadpole => &[
    // rust: Sensor::Living,
    // rust: Sensor::Players,
    // rust: Sensor::HurtBy,
    // rust: Sensor::Tempting,
    // rust: ],
}
}
}

// An animal's brain.
Brain :: struct {
    kind: Kind,
    mem: Memories,
    sensors: Vec<(Sensor,
    // The active non-core activity (`CORE` is always active).
    activity: Act,
    list: [dynamic]Entry,
}
Entry :: struct {
    act: Act,
    b: B,
}

brain :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.animal_brain.as_deref()
}
brain_mut :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: m.extra
    // rust: .animal_brain
    // rust: .as_deref_mut()
    // rust: .expect("the animal brain is built before it is used")
}
    // rust: pub(super) fn mem(m: &mut Mob) -> &mut Memories {
    // rust: &mut brain_mut(m).mem
}
    // rust: pub(super) fn mem_ref(m: &Mob) -> Option<&Memories> {
    // rust: brain(m).map(|b| &b.mem)
}

// The brain kind a mob has, if any.
kind_of :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: kind_for_species(m.species())
}
kind_for_species :: proc(species: Species) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match species {
    // rust: Species::Axolotl => Some(Kind::Axolotl),
    // rust: Species::Sniffer => Some(Kind::Sniffer),
        // Every happy ghast has the brain; only the ghastling's ticks.
    // rust: Species::HappyGhast => Some(Kind::Ghastling),
    // rust: Species::CopperGolem => Some(Kind::CopperGolem),
    // rust: Species::Tadpole => Some(Kind::Tadpole),
    // rust: _ => None,
}
}

// `Brain.Provider.makeBrain`: a new brain whose sensors' first scans are
// delayed by draws from the mob's random, on its default activity (idle).
// The gates shuffle with a random seeded with `shuffle_seed`.
init :: proc(m: ^Mob, shuffle_seed: i64) {
}
    // rust: let Some(kind) = kind_of(m) else { return };
    // The copper golem's constructor: TRANSPORT_ITEMS_COOLDOWN_TICKS of
    // nextInt(60, 100).
    // rust: let cooldown =
    // rust: (kind == Kind::CopperGolem).then(|| 60 + m.random.next_int_bound(40).unwrap_or(0));
    // rust: let sensors = kind
    // rust: .sensors()
    // rust: .iter()
    // rust: .map(|s| (*s, i64::from(m.random.next_int_bound(20).unwrap_or(0))))
    // rust: .collect();
    // rust: let mut b = Brain {
    // rust: kind,
    // rust: mem: Memories::default(),
    // rust: sensors,
    // rust: activity: Act::Idle,
    // rust: list: Vec::new(),
}
    // rust: b.list = match kind {
    // rust: Kind::Axolotl => axolotl_package(shuffle_seed),
    // rust: Kind::Sniffer => sniffer_package(shuffle_seed),
    // rust: Kind::Ghastling => ghastling_package(shuffle_seed),
    // rust: Kind::CopperGolem => copper_golem_package(shuffle_seed),
    // rust: Kind::Tadpole => tadpole_package(shuffle_seed),
}
    // rust: if let Some(c) = cooldown {
    // rust: b.mem.transport_items_cooldown_ticks.set(c);
}
    // rust: m.extra.animal_brain = Some(Box::new(b));
}

// A copper golem's `TRANSPORT_ITEMS_COOLDOWN_TICKS`, or none for 0.
set_transport_cooldown :: proc(m: ^Mob, ticks: i32) {
}
    // rust: if m.extra.animal_brain.is_none() {
    // rust: return;
}
    // rust: let slot = &mut mem(m).transport_items_cooldown_ticks;
    // rust: if ticks > 0 {
    // rust: slot.set(ticks);
    // rust: } else {
    // rust: slot.clear();
}
}

// The happy ghast grew up (`adultGhastSetup`): every running behaviour
// stops (`Brain.stopAll`) and the memories are cleared; the brain no
// longer ticks.
grown_up :: proc(m: ^Mob) {
}
    // rust: let Some(b) = m.extra.animal_brain.as_deref_mut() else {
    // rust: return;
}
    // rust: for e in b.list.iter_mut() {
    // rust: e.b.reset();
}
    // rust: b.mem = Memories::default();
    // rust: m.nav_stop();
}

// `AnimalMakeLove.start` on the partner's side: it remembers `partner`
// as its breed target, looks at it and walks to it
// (`BehaviorUtils.lockGazeAndWalkToEachOther`).
set_breed_partner :: proc(m: ^Mob, partner: u32) {
}
    // rust: if m.extra.animal_brain.is_none() {
    // rust: return;
}
    // rust: let who = Who::Mob(partner);
    // rust: mem(m).breed_target.set(who);
    // rust: lock_gaze_and_walk(
    // rust: m,
    // rust: who,
    // rust: if m.species() == Species::Axolotl {
    // rust: 0.2
    // rust: } else {
    // rust: 1.0
    // rust: },
    // rust: 2,
    // rust: );
}

// `AnimalMakeLove.tick` after the birth: the partner forgets this mob.
forget_breed_target :: proc(m: ^Mob, partner: u32) {
}
    // rust: if m.extra.animal_brain.is_some() && mem(m).breed_target.value() == Some(Who::Mob(partner)) {
    // rust: mem(m).breed_target.clear();
}
}
// The partner's half of `lockGazeAndWalkToEachOther`.
lock_gaze :: proc(m: ^Mob, partner: u32) {
}
    // rust: if m.extra.animal_brain.is_none() {
    // rust: return;
}
    // rust: lock_gaze_and_walk(
    // rust: m,
    // rust: Who::Mob(partner),
    // rust: if m.species() == Species::Axolotl {
    // rust: 0.2
    // rust: } else {
    // rust: 1.0
    // rust: },
    // rust: 2,
    // rust: );
}

// What behaviours read and emit during a brain tick.
Bx :: struct {
    w: ^'a MobWorld<'w>,
    lr: ^'a mut LegacyRandom,
    events: ^'a mut [dynamic]MobEvent,
    now: i64,
}

// `Brain.tick` then `updateActivity` (from `customServerAiStep`).
tick :: proc(m: ^Mob, w: ^MobWorld, lr: ^LegacyRandom, events: ^[dynamic]MobEvent) {
}
    // rust: if brain(m).is_none() {
    // rust: let seed = i64::from(m.id);
    // rust: init(m, seed);
    // rust: if brain(m).is_none() {
    // rust: return;
}
}
    // forgetOutdatedMemories
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
    // rust: m.ai.panicking = is_panicking(m);
    // rust: if m.species() == Species::Axolotl {
    // rust: m.extra.axolotl.playing_dead = mem(m)
    // rust: .play_dead_ticks
    // rust: .value()
    // rust: .is_some_and(|ticks| ticks > 0);
    // rust: m.ai.target = mem(m).attack_target.value();
}
}

// `SnifferAi.updateActivity` / `HappyGhastAi.updateActivity`:
// `setActiveActivityToFirstValid`.
update_activity :: proc(m: ^Mob) {
}
    // rust: let b = brain_mut(m);
    // rust: let mm = &b.mem;
    // rust: if b.kind == Kind::Axolotl {
    // rust: update_axolotl_activity(b);
    // rust: return;
}
    // rust: let order: &[Act] = match b.kind {
    // rust: Kind::Sniffer => &[Act::Dig, Act::Sniff, Act::Idle],
    // rust: Kind::Ghastling => &[Act::Panic, Act::Idle],
        // `TadpoleAi.updateActivity`: `setActiveActivityToFirstValid(IDLE)`.
    // rust: Kind::CopperGolem | Kind::Tadpole => &[Act::Idle],
    // rust: Kind::Axolotl => unreachable!(),
}
    // rust: for &a in order {
    // rust: let ok = match a {
    // rust: Act::Dig => {
    // rust: !mm.is_panicking.present()
    // rust: && !mm.walk_target.present()
    // rust: && mm.sniffer_digging.present()
}
    // rust: Act::Sniff => {
    // rust: !mm.is_panicking.present()
    // rust: && mm.sniffer_sniffing_target.present()
    // rust: && mm.walk_target.present()
}
    // rust: Act::Idle => b.kind != Kind::Sniffer || !mm.sniffer_digging.present(),
    // rust: Act::Panic => mm.is_panicking.present(),
    // rust: Act::Core => true,
    // rust: Act::Fight | Act::PlayDead => false,
}
    // rust: if ok {
    // rust: b.activity = a;
    // rust: break;
}
}
}

// `PathfinderMob.isPanicking` for a mob with this brain.
is_panicking :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: mem_ref(m).is_some_and(|mm| mm.is_panicking.present())
}
// `Sniffer.isTempted`.
is_tempted :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: mem_ref(m).is_some_and(|mm| mm.tempting_player.present())
}
// The explored positions are the sniffer's `SNIFFER_EXPLORED_POSITIONS`.
EXPLORED_MAX :: 20

// ---- Sensors ------------------------------------------------------------

tick_sensors :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let n = brain_mut(m).sensors.len();
    // rust: for i in 0..n {
    // rust: let (sensor, fire) = {
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
    // rust: match sensor {
    // rust: Sensor::Living => sense_living(m, w),
    // rust: Sensor::AxolotlAttackables => sense_axolotl_attackables(m, w),
    // rust: Sensor::AdultSameType => {
    // rust: let found = find_closest(m, w, |m, who| match who {
    // rust: Who::Mob(id) => w
    // rust: .seen(id)
    // rust: .is_some_and(|s| !s.baby && s.species == m.species()),
    // rust: _ => false,
    // rust: });
    // rust: mem(m).nearest_visible_adult.set_opt(found);
}
    // rust: Sensor::HurtBy => sense_hurt(m, w),
    // rust: Sensor::Players => sense_players(m, w),
    // rust: Sensor::Tempting => sense_tempting(m, w),
    // rust: Sensor::AdultAnyType => sense_adult(m, w),
}
}
}
// `NearestLivingEntitySensor`: everything alive within the follow range,
// nearest first.
sense_living :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let list = living_near(m, w);
    // rust: let mm = mem(m);
    // rust: mm.mobs.set_list(list.clone());
    // rust: mm.visible_mobs.set(Visible {
    // rust: list,
    // rust: cache: Vec::new(),
    // rust: });
}
// `Sensor.isEntityTargetable`: `TargetingConditions.forNonCombat()` within
// the follow range, in sight.
targetable :: proc(m: ^Mob, w: ^MobWorld, who: Who) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let range = m.attrs.follow_range;
    // rust: match who {
    // rust: Who::Player => {
            // TargetingConditions.forNonCombat(): in range (scaled by the
            // player's visibility, at least 2) and in sight.
    // rust: let Some(p) = &w.player else { return false };
    // rust: let r = (range * p.visibility_percent(Some(m.kind.id.as_str()), w.items)).max(2.0);
    // rust: p.alive && !p.spectator && m.distance_sqr(p.position) <= r * r && m.sees(w, who)
}
    // rust: Who::Mob(id) => {
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: s.alive && m.distance_sqr(s.position) <= range * range && m.sees(w, who)
}
}
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
    // rust: let r = targetable(m, w, who);
    // rust: if let Some(v) = mem(m).visible_mobs.v.as_mut() {
    // rust: v.cache.push((who, r));
}
    // rust: r
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
// `HurtBySensor`: the last damage (forgotten 40 ticks after) and who did it.
sense_hurt :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let age = i64::from(m.age);
    // rust: let last = m
    // rust: .last_damage
    // rust: .as_ref()
    // rust: .filter(|(_, t)| age - t <= 40)
    // rust: .map(|(d, _)| (d.attacker, d.causes_panic()));
    // rust: let mm = mem(m);
    // rust: if let Some((by, panic)) = last {
    // rust: mm.hurt_by.set(panic);
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
// `TemptingSensor.forAnimal`: the nearest player within the tempt range
// holding the animal's food (and not riding it).
sense_tempting :: proc(m: ^Mob, w: ^MobWorld) {
}
    // Attributes.TEMPT_RANGE: 10 for animals, 16 for the happy ghast.
    // rust: let range = if m.species() == Species::HappyGhast {
    // rust: 16.0
    // rust: } else {
    // rust: 10.0
}
    // rust: let food = &m.kind.food;
    // rust: let holds = |item: &Option<std::sync::Arc<str>>| {
    // rust: item.as_deref()
    // rust: .is_some_and(|i| food.iter().any(|f| f.as_str() == i))
}
    // rust: let tempting = w.player.as_ref().is_some_and(|p| {
    // rust: p.alive
    // rust: && !p.spectator
    // rust: && m.distance_sqr(p.position) <= range * range
    // rust: && (holds(&p.main_hand) || holds(&p.off_hand))
    // rust: && m.rider.is_none()
    // rust: });
    // rust: mem(m)
    // rust: .tempting_player
    // rust: .set_opt(tempting.then_some(Who::Player));
}
// `AdultSensorAnyType`: the nearest visible adult of a followable friendly
// type.
sense_adult :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: if !mem(m).visible_mobs.present() {
    // rust: return;
}
    // rust: let found = find_closest(m, w, |_, who| match who {
    // rust: Who::Mob(id) => w
    // rust: .seen(id)
    // rust: .is_some_and(|s| !s.baby && followable_friendly(s.species)),
    // rust: Who::Player => false,
    // rust: });
    // rust: mem(m).nearest_visible_adult.set_opt(found);
}
// `#followable_friendly_mobs`.
followable_friendly :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Camel
    // rust: | Species::Cat
    // rust: | Species::Chicken
    // rust: | Species::Cow
    // rust: | Species::Donkey
    // rust: | Species::Fox
    // rust: | Species::Goat
    // rust: | Species::HappyGhast
    // rust: | Species::Horse
    // rust: | Species::SkeletonHorse
    // rust: | Species::Llama
    // rust: | Species::Mule
    // rust: | Species::Ocelot
    // rust: | Species::Panda
    // rust: | Species::Parrot
    // rust: | Species::Pig
    // rust: | Species::PolarBear
    // rust: | Species::Rabbit
    // rust: | Species::Sheep
    // rust: | Species::Sniffer
    // rust: | Species::Strider
    // rust: | Species::Villager
    // rust: | Species::Wolf
    // rust: )
}

// ---- Behaviours ------------------------------------------------------------

// `RunOne`: shuffles its children by weight and starts the first that can.
Gate :: struct {
    running: bool,
    shuffle: bool,
    try_all: bool,
    random: LegacyRandom,
    kids: Vec<(B,
    // The gate's memory requirements.
    when: Maybe(fn(^Memories) -) bool>,
}
    // rust: impl Gate {
run_one :: proc(seed: i64, kids: Vec<(B) {
}
    // rust: Self {
    // rust: running: false,
    // rust: shuffle: true,
    // rust: try_all: false,
    // rust: random: LegacyRandom::new(seed),
    // rust: kids: kids.into_iter().map(|(b, w)| (b, w, 0.0)).collect(),
    // rust: when: None,
}
}
when :: proc(f: fn(^Memories) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.when = Some(f);
    // rust: self
}
try_start :: proc(self: ^Self, m: ^Mob, cx: ^Bx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(f) = self.when
    // rust: && !f(mem(m))
    // rust: {
    // rust: return false;
}
    // rust: self.running = true;
        // ShufflingList.shuffle: a fresh weight for each entry in the
        // current order, then a stable sort.
    // rust: if self.shuffle {
    // rust: for k in &mut self.kids {
    // rust: let r = self.random.next_float();
    // rust: k.2 = -horizon_core::jmath::pow(f64::from(r), f64::from(1.0_f32 / k.1 as f32));
}
    // rust: self.kids.sort_by(|a, b| a.2.total_cmp(&b.2));
}
    // rust: for k in &mut self.kids {
    // rust: if !k.0.running() && k.0.try_start(m, cx) && !self.try_all {
    // rust: break;
}
}
    // rust: true
}
tick_or_stop :: proc(self: ^Self, m: ^Mob, cx: ^Bx) {
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
do_stop :: proc(self: ^Self, m: ^Mob, cx: ^Bx) {
}
    // rust: self.running = false;
    // rust: for k in &mut self.kids {
    // rust: if k.0.running() {
    // rust: k.0.do_stop(m, cx);
}
}
}
}

B :: enum {
    AxolotlAction {,
    action: AxolotlAction,
    running: bool,
    until: i64,
    // rust: },
    PlayDead(Timed),
    Swim(Timed),
    // `AnimalPanic`: flying (`AirAndWaterRandomPos`) or on land, and
    // whether the sniffer's override resets its sniffing first.
    AnimalPanic {,
    t: Timed,
    fly: bool,
    speed: f32,
    // rust: },
    MoveToTargetSink {,
    t: Timed,
    cooldown: i32,
    path: Option<Path>,
    last_target: Option<[i32; 3]>,
    speed: f32,
    // rust: },
    CountDownTemptation(Timed),
    MakeLove {,
    t: Timed,
    spawn_at: i64,
    // rust: },
    // `FollowTemptation` and how close is close enough.
    FollowTemptation {,
    t: Timed,
    look_in_the_eyes: bool,
    // rust: },
    LookAtTargetSink(Timed),
    FeelingHappy(Timed),
    Digging(Timed),
    FinishedDigging(Timed),
    Searching(Timed),
    Scenting(Timed),
    Sniffing(Timed),
    DoNothing(Timed),
    // `SetWalkTargetFromLookTarget.create(speed, close)`.
    WalkToLookTarget {,
    running: bool,
    speed: f32,
    close: i32,
    // rust: },
    // `SetEntityLookTarget.create(EntityType.PLAYER, 6)`.
    LookAtPlayer(bool),
    // `RandomStroll.stroll` or `RandomStroll.fly`.
    Stroll {,
    running: bool,
    fly: bool,
    speed: f32,
        // Horizontal and vertical range (land strolls).
    range: (i32, i32),
    // rust: },
    // `BabyFollowAdult.create(3..16, 1.1, memory, true)`: the nearest
    // visible player or adult.
    FollowAdult {,
    running: bool,
    player: bool,
    // rust: },
    Gate(Box<Gate>),
    // `CountDownCooldownTicks(GAZE_COOLDOWN_TICKS)` and
    // `(TRANSPORT_ITEMS_COOLDOWN_TICKS)`.
    CountDownGaze(Timed),
    CountDownTransport(Timed),
    // `SetEntityLookTargetSometimes.create(PLAYER, 6, 40..80)`: running,
    // and the ticker's ticks until the next start.
    LookAtPlayerSometimes(bool, i32),
    // `InteractWithDoor.create()`: opens the doors on the path and closes
    // the ones it has passed.
    InteractWithDoor {,
    running: bool,
    last_node: Option<PathNode>,
    cooldown: i32,
    // rust: },
    // `TransportItemsBetweenContainers`.
    Transport(Box<super::transport_items::Transport>),
}

    // rust: impl B {
running :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: B::PlayDead(t)
    // rust: | B::Swim(t)
    // rust: | B::AnimalPanic { t, .. }
    // rust: | B::MoveToTargetSink { t, .. }
    // rust: | B::CountDownTemptation(t)
    // rust: | B::MakeLove { t, .. }
    // rust: | B::FollowTemptation { t, .. }
    // rust: | B::LookAtTargetSink(t)
    // rust: | B::FeelingHappy(t)
    // rust: | B::Digging(t)
    // rust: | B::FinishedDigging(t)
    // rust: | B::Searching(t)
    // rust: | B::Scenting(t)
    // rust: | B::Sniffing(t)
    // rust: | B::DoNothing(t)
    // rust: | B::CountDownGaze(t)
    // rust: | B::CountDownTransport(t) => t.running,
    // rust: B::Transport(x) => x.running,
    // rust: B::LookAtPlayerSometimes(running, _) => *running,
    // rust: B::InteractWithDoor { running, .. } => *running,
    // rust: B::AxolotlAction { running, .. }
    // rust: | B::WalkToLookTarget { running, .. }
    // rust: | B::LookAtPlayer(running)
    // rust: | B::Stroll { running, .. }
    // rust: | B::FollowAdult { running, .. } => *running,
    // rust: B::Gate(g) => g.running,
}
}
    // Stopped without its stop effects (the memories they would touch are
    // cleared with the rest).
reset :: proc(self: ^Self) {
}
    // rust: match self {
    // rust: B::PlayDead(t)
    // rust: | B::Swim(t)
    // rust: | B::AnimalPanic { t, .. }
    // rust: | B::CountDownTemptation(t)
    // rust: | B::MakeLove { t, .. }
    // rust: | B::FollowTemptation { t, .. }
    // rust: | B::LookAtTargetSink(t)
    // rust: | B::FeelingHappy(t)
    // rust: | B::Digging(t)
    // rust: | B::FinishedDigging(t)
    // rust: | B::Searching(t)
    // rust: | B::Scenting(t)
    // rust: | B::Sniffing(t)
    // rust: | B::DoNothing(t)
    // rust: | B::CountDownGaze(t)
    // rust: | B::CountDownTransport(t) => t.running = false,
    // rust: B::Transport(x) => x.running = false,
    // rust: B::MoveToTargetSink { t, path, .. } => {
    // rust: t.running = false;
    // rust: *path = None;
}
    // rust: B::Gate(g) => {
    // rust: g.running = false;
    // rust: for k in &mut g.kids {
    // rust: k.0.reset();
}
}
    // rust: _ => self.set_one_shot(false),
}
}
    // A one-shot (`OneShot`) runs only until its first tick.
one_shot :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self,
    // rust: B::AxolotlAction { .. }
    // rust: | B::WalkToLookTarget { .. }
    // rust: | B::LookAtPlayer(_)
    // rust: | B::LookAtPlayerSometimes(..)
    // rust: | B::InteractWithDoor { .. }
    // rust: | B::Stroll { .. }
    // rust: | B::FollowAdult { .. }
    // rust: )
}
set_one_shot :: proc(self: ^Self, on: bool) {
}
    // rust: match self {
    // rust: B::AxolotlAction { running, .. }
    // rust: | B::WalkToLookTarget { running, .. }
    // rust: | B::LookAtPlayer(running)
    // rust: | B::LookAtPlayerSometimes(running, _)
    // rust: | B::InteractWithDoor { running, .. }
    // rust: | B::Stroll { running, .. }
    // rust: | B::FollowAdult { running, .. } => *running = on,
    // rust: _ => {}
}
}

    // `BehaviorControl.tryStart`.
try_start :: proc(self: ^Self, m: ^Mob, cx: ^Bx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.one_shot() {
    // rust: let ok = self.trigger(m, cx);
    // rust: if ok {
    // rust: self.set_one_shot(true);
}
    // rust: return ok;
}
    // rust: let now = cx.now;
    // rust: match self {
    // rust: B::Gate(g) => g.try_start(m, cx),
    // rust: B::PlayDead(t) => {
    // rust: if !m.fluids.in_water
    // rust: || !mem(m).play_dead_ticks.present()
    // rust: || !mem(m).hurt_by_entity.present()
    // rust: {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: mem(m).walk_target.clear();
    // rust: mem(m).look_target.clear();
    // rust: m.add_effect("minecraft:regeneration", 200, 0);
    // rust: true
}
    // rust: B::Swim(t) => {
    // rust: if !swim_condition(m) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::AnimalPanic { t, .. } => {
    // rust: let mm = mem(m);
    // rust: if !(mm.hurt_by.get() == Some(&true) || mm.is_panicking.present()) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: if brain_mut(m).kind == Kind::Sniffer {
    // rust: reset_sniffing(m, cx);
}
    // rust: let mm = mem(m);
    // rust: mm.is_panicking.set(true);
    // rust: mm.walk_target.clear();
    // rust: m.nav_stop();
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
    // rust: if *cooldown > 0 {
    // rust: *cooldown -= 1;
    // rust: return false;
}
    // rust: let walk = mm.walk_target.value().unwrap();
    // rust: let reached = reached(m, cx.w, &walk);
    // rust: if !reached && compute_path(m, cx, &walk, path, speed) {
    // rust: *last_target = walk.target.block(cx.w);
    // rust: t.begin(cx.lr, cx.now);
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
    // rust: B::CountDownTemptation(t) => {
    // rust: if !mem(m).temptation_cooldown_ticks.present() {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::CountDownGaze(t) => {
    // rust: if !mem(m).gaze_cooldown_ticks.present() {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::CountDownTransport(t) => {
    // rust: if !mem(m).transport_items_cooldown_ticks.present() {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::Transport(x) => x.try_start(m, cx),
    // rust: B::MakeLove { t, spawn_at } => {
    // rust: let mm = mem(m);
    // rust: if !mm.visible_mobs.present()
    // rust: || mm.breed_target.present()
    // rust: || mm.is_panicking.present()
    // rust: {
    // rust: return false;
}
    // rust: if m.extra.in_love <= 0 {
    // rust: return false;
}
    // rust: let Some(partner) = breed_partner(m, cx.w) else {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: if brain_mut(m).kind == Kind::Sniffer {
    // rust: reset_sniffing(m, cx);
}
    // rust: mem(m).breed_target.set(partner);
    // rust: if let Who::Mob(id) = partner {
    // rust: cx.events.push(MobEvent::BreedTarget {
    // rust: mob: id,
    // rust: partner: m.id,
    // rust: });
}
    // rust: let speed = if m.species() == Species::Axolotl {
    // rust: 0.2
    // rust: } else {
    // rust: 1.0
}
    // rust: lock_gaze_and_walk(m, partner, speed, 2);
    // rust: *spawn_at = now + 60 + i64::from(m.random.next_int_bound(50).unwrap_or(0));
    // rust: true
}
    // rust: B::FollowTemptation { t, .. } => {
    // rust: let mm = mem(m);
    // rust: if mm.temptation_cooldown_ticks.present()
    // rust: || !mm.tempting_player.present()
    // rust: || mm.breed_target.present()
    // rust: || mm.is_panicking.present()
    // rust: {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: if brain_mut(m).kind == Kind::Sniffer {
    // rust: reset_sniffing(m, cx);
}
    // rust: true
}
    // rust: B::LookAtTargetSink(t) => {
    // rust: if !mem(m).look_target.present() {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::FeelingHappy(t) => {
    // rust: if !mem(m).sniffer_happy.present() {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: transition(m, cx, sniffer::FEELING_HAPPY);
    // rust: true
}
    // rust: B::Digging(t) => {
    // rust: let mm = mem(m);
    // rust: if mm.is_panicking.present()
    // rust: || mm.walk_target.present()
    // rust: || !mm.sniffer_digging.present()
    // rust: || mm.sniff_cooldown.present()
    // rust: {
    // rust: return false;
}
    // rust: if !can_sniff(m) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: transition(m, cx, sniffer::DIGGING);
    // rust: true
}
    // rust: B::FinishedDigging(t) => {
    // rust: let mm = mem(m);
    // rust: if mm.is_panicking.present()
    // rust: || mm.walk_target.present()
    // rust: || !mm.sniffer_digging.present()
    // rust: || !mm.sniff_cooldown.present()
    // rust: {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: transition(m, cx, sniffer::RISING);
    // rust: true
}
    // rust: B::Searching(t) => {
    // rust: let mm = mem(m);
    // rust: if !mm.walk_target.present()
    // rust: || mm.is_panicking.present()
    // rust: || !mm.sniffer_sniffing_target.present()
    // rust: {
    // rust: return false;
}
    // rust: if !can_sniff(m) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: transition(m, cx, sniffer::SEARCHING);
    // rust: true
}
    // rust: B::Scenting(t) => {
    // rust: let mm = mem(m);
    // rust: if mm.is_panicking.present()
    // rust: || mm.sniffer_digging.present()
    // rust: || mm.sniffer_sniffing_target.present()
    // rust: || mm.sniffer_happy.present()
    // rust: || mm.breed_target.present()
    // rust: {
    // rust: return false;
}
    // rust: if is_tempted(m) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: transition(m, cx, sniffer::SCENTING);
    // rust: true
}
    // rust: B::Sniffing(t) => {
    // rust: let mm = mem(m);
    // rust: if mm.walk_target.present()
    // rust: || mm.sniffer_sniffing_target.present()
    // rust: || mm.sniff_cooldown.present()
    // rust: {
    // rust: return false;
}
    // rust: if m.is_baby() || !can_sniff(m) {
    // rust: return false;
}
    // rust: t.begin(cx.lr, cx.now);
    // rust: transition(m, cx, sniffer::SNIFFING);
    // rust: true
}
    // rust: B::DoNothing(t) => {
    // rust: t.begin(cx.lr, cx.now);
    // rust: true
}
    // rust: B::AxolotlAction { .. }
    // rust: | B::WalkToLookTarget { .. }
    // rust: | B::LookAtPlayer(_)
    // rust: | B::LookAtPlayerSometimes(..)
    // rust: | B::InteractWithDoor { .. }
    // rust: | B::Stroll { .. }
    // rust: | B::FollowAdult { .. } => unreachable!("one-shots trigger"),
}
}

    // A one-shot's trigger.
trigger :: proc(self: ^Self, m: ^Mob, cx: ^Bx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match *self {
    // rust: B::AxolotlAction {
    // rust: action,
    // rust: ref mut until,
    // rust: ..
    // rust: } => axolotl_action(m, cx, action, until),
    // rust: B::WalkToLookTarget { speed, close, .. } => {
    // rust: let mm = mem(m);
    // rust: if mm.walk_target.present() {
    // rust: return false;
}
    // rust: let Some(look) = mm.look_target.value() else {
    // rust: return false;
}
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: look,
    // rust: speed,
    // rust: close,
    // rust: });
    // rust: true
}
    // rust: B::LookAtPlayer(_) => {
    // rust: let mm = mem(m);
    // rust: if mm.look_target.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let found = find_closest(m, w, |m, who| {
    // rust: who == Who::Player
    // rust: && w.target_info(who)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) <= 36.0)
    // rust: && m.rider.is_none()
    // rust: });
    // rust: let Some(t) = found else { return false };
    // rust: mem(m).look_target.set(Tracker::entity(t, true));
    // rust: true
}
    // rust: B::InteractWithDoor {
    // rust: ref mut last_node,
    // rust: ref mut cooldown,
    // rust: ..
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
    // rust: true
}
    // rust: B::LookAtPlayerSometimes(_, ref mut ticks) => {
    // rust: let mm = mem(m);
    // rust: if mm.look_target.present() || !mm.visible_mobs.present() {
    // rust: return false;
}
    // rust: let w = cx.w;
    // rust: let found = find_closest(m, w, |m, who| {
    // rust: who == Who::Player
    // rust: && w.target_info(who)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) <= 36.0)
    // rust: });
    // rust: let Some(t) = found else { return false };
                // Ticker.tickDownAndCheck (UniformInt 40..80 on the level random).
    // rust: if *ticks == 0 {
    // rust: *ticks = if matches!(m.species(), Species::Axolotl | Species::Tadpole) {
    // rust: 30 + cx.lr.next_int_bound(31).unwrap_or(0) - 1
    // rust: } else {
    // rust: 40 + cx.lr.next_int_bound(41).unwrap_or(0) - 1
}
    // rust: return false;
}
    // rust: *ticks -= 1;
    // rust: if *ticks != 0 {
    // rust: return false;
}
    // rust: mem(m).look_target.set(Tracker::entity(t, true));
    // rust: true
}
    // rust: B::Stroll {
    // rust: fly, speed, range, ..
    // rust: } => {
    // rust: if m.species() == Species::Axolotl && m.fluids.in_water {
    // rust: return false;
}
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let pos = if fly {
    // rust: let view = m.view_vector();
    // rust: m.air_and_water_random_pos(cx.w, 10, 7, -2, view[0], view[2])
    // rust: } else {
    // rust: m.land_random_pos(cx.w, range.0, range.1)
}
    // rust: mem(m)
    // rust: .walk_target
    // rust: .set_opt(pos.map(|p| WalkTarget::point(p, speed, 0)));
    // rust: true
}
    // rust: B::FollowAdult { player, .. } => {
    // rust: let mm = mem(m);
    // rust: let adult = if player {
    // rust: mm.nearest_visible_player.value()
    // rust: } else {
    // rust: mm.nearest_visible_adult.value()
}
    // rust: let Some(adult) = adult else { return false };
    // rust: if mm.walk_target.present() || !m.is_baby() {
    // rust: return false;
}
    // rust: let Some(at) = cx.w.target_info(adult) else {
    // rust: return false;
}
                // closerThan(adult, 17) && !closerThan(adult, 3)
    // rust: let d = m.distance_sqr(at.position);
    // rust: let min = if m.species() == Species::Axolotl {
    // rust: 5.0
    // rust: } else {
    // rust: 3.0
}
    // rust: if !(min * min..17.0 * 17.0).contains(&d) {
    // rust: return false;
}
    // rust: let speed = if m.species() == Species::Axolotl {
    // rust: axolotl_speed(m, true)
    // rust: } else {
    // rust: 1.1
}
    // rust: let close = if m.species() == Species::Axolotl {
    // rust: 4
    // rust: } else {
    // rust: 2
}
    // rust: let eyes = m.species() != Species::Axolotl;
    // rust: let mm = mem(m);
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity {
    // rust: who: adult,
    // rust: eye: eyes,
    // rust: block_eye: eyes,
    // rust: },
    // rust: speed,
    // rust: close,
    // rust: });
    // rust: mm.look_target.set(Tracker::Entity {
    // rust: who: adult,
    // rust: eye: true,
    // rust: block_eye: eyes,
    // rust: });
    // rust: true
}
    // rust: _ => false,
}
}

    // `BehaviorControl.tickOrStop`.
tick_or_stop :: proc(self: ^Self, m: ^Mob, cx: ^Bx) {
}
    // rust: if self.one_shot() {
    // rust: self.set_one_shot(false);
    // rust: return;
}
    // rust: let now = cx.now;
    // rust: match self {
    // rust: B::AxolotlAction { .. } => {}
    // rust: B::PlayDead(t) => {
    // rust: if t.timed_out(now) || !m.fluids.in_water || !mem(m).play_dead_ticks.present() {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::Gate(g) => g.tick_or_stop(m, cx),
    // rust: B::Swim(t) => {
    // rust: if t.timed_out(now) || !swim_condition(m) {
    // rust: self.do_stop(m, cx);
    // rust: } else if m.random.next_float() < 0.8 {
    // rust: m.ai.jump = true;
}
}
    // rust: B::AnimalPanic { t, fly, speed } => {
    // rust: if t.timed_out(now) {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: if m.ai.nav.is_done() {
    // rust: let pos = panic_pos(m, cx.w, *fly);
    // rust: if let Some(p) = pos {
    // rust: mem(m).walk_target.set(WalkTarget::point(p, *speed, 0));
}
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
    // rust: if t.timed_out(now) || !still {
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
    // rust: let d = dist_sqr(now_target, last);
    // rust: if d > 4 && compute_path(m, cx, &walk, path, speed) {
    // rust: *last_target = Some(now_target);
    // rust: mem(m).path.set_opt(path.clone());
    // rust: m.nav_move_to_path(cx.w, path.clone(), f64::from(*speed));
}
}
}
    // rust: B::CountDownTemptation(_) => {
    // rust: let v = mem(m).temptation_cooldown_ticks.value();
    // rust: match v {
    // rust: Some(v) if v > 0 => mem(m).temptation_cooldown_ticks.set(v - 1),
    // rust: _ => self.do_stop(m, cx),
}
}
    // rust: B::CountDownGaze(_) => {
    // rust: let v = mem(m).gaze_cooldown_ticks.value();
    // rust: match v {
    // rust: Some(v) if v > 0 => mem(m).gaze_cooldown_ticks.set(v - 1),
    // rust: _ => self.do_stop(m, cx),
}
}
    // rust: B::CountDownTransport(_) => {
    // rust: let v = mem(m).transport_items_cooldown_ticks.value();
    // rust: match v {
    // rust: Some(v) if v > 0 => mem(m).transport_items_cooldown_ticks.set(v - 1),
    // rust: _ => self.do_stop(m, cx),
}
}
    // rust: B::Transport(x) => x.tick_or_stop(m, cx),
    // rust: B::MakeLove { spawn_at, .. } => {
    // rust: let Some(partner) = mem(m).breed_target.value() else {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: let ok = cx.w.target_info(partner).is_some_and(|t| t.alive)
    // rust: && can_mate_with(m, cx.w, partner)
    // rust: && visible_contains(m, cx.w, partner)
    // rust: && now <= *spawn_at
    // rust: && !is_panicking(m)
    // rust: && !partner_panicking(cx.w, partner);
    // rust: if !ok {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: lock_gaze_and_walk(
    // rust: m,
    // rust: partner,
    // rust: if m.species() == Species::Axolotl {
    // rust: 0.2
    // rust: } else {
    // rust: 1.0
    // rust: },
    // rust: 2,
    // rust: );
    // rust: if let Who::Mob(id) = partner {
    // rust: cx.events.push(MobEvent::LockGaze {
    // rust: mob: id,
    // rust: partner: m.id,
    // rust: });
}
    // rust: if let Some(t) = cx.w.target_info(partner)
    // rust: && m.distance_sqr(t.position) < 9.0
    // rust: && now >= *spawn_at
    // rust: {
                    // spawnChildFromBreeding: the egg (or baby), and both
                    // parents rest (finalizeSpawnChildFromBreeding).
    // rust: let Who::Mob(id) = partner else { return };
    // rust: m.extra.in_love = 0;
    // rust: m.extra.age = 6000;
    // rust: cx.events.push(MobEvent::Breed {
    // rust: parent: m.id,
    // rust: partner: id,
    // rust: llama: None,
    // rust: });
    // rust: if brain_mut(m).kind == Kind::Sniffer {
                        // Sniffer.spawnChildFromBreeding: the experience
                        // (finalizeSpawnChildFromBreeding), then the plop,
                        // both from the parent's random; the game lays the
                        // egg. Vanilla makes the draw inside the `mob_drops`
                        // check, so it is skipped with the rule off.
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: if cx.w.mob_drops {
    // rust: let xp = 1 + m.random.next_int_bound(7).unwrap_or(0);
    // rust: cx.events.push(MobEvent::Experience {
    // rust: at,
    // rust: amount: xp as u32,
    // rust: });
}
    // rust: let pitch = (m.random.next_float() - m.random.next_float()) * 0.2 + 0.5;
    // rust: cx.events
    // rust: .push(MobEvent::Sound("block.sniffer_egg.plop", at, 1.0, pitch));
}
    // rust: mem(m).breed_target.clear();
}
}
    // rust: B::FollowTemptation {
    // rust: look_in_the_eyes, ..
    // rust: } => {
    // rust: let mm = mem(m);
    // rust: let still = mm.tempting_player.present()
    // rust: && !mm.breed_target.present()
    // rust: && !mm.is_panicking.present();
    // rust: if !still {
    // rust: self.do_stop(m, cx);
    // rust: return;
}
    // rust: let eyes = *look_in_the_eyes;
    // rust: let player = mm.tempting_player.value().unwrap();
    // rust: mm.look_target.set(Tracker::entity(player, true));
    // rust: let close = follow_temptation_close(m);
    // rust: let near =
    // rust: cx.w.target_info(player)
    // rust: .is_some_and(|t| m.distance_sqr(t.position) < close * close);
    // rust: let speed = if m.species() == Species::Axolotl {
    // rust: axolotl_speed(m, false)
    // rust: } else {
    // rust: 1.25
}
    // rust: let mm = mem(m);
    // rust: if near {
    // rust: mm.walk_target.clear();
    // rust: } else {
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Entity {
    // rust: who: player,
    // rust: eye: eyes,
    // rust: block_eye: eyes,
    // rust: },
    // rust: speed,
    // rust: close: 2,
    // rust: });
}
}
    // rust: B::LookAtTargetSink(t) => {
    // rust: let visible = match mem(m).look_target.value() {
    // rust: Some(look) => tracker_visible(m, cx.w, look),
    // rust: None => false,
}
    // rust: if t.timed_out(now) || !visible {
    // rust: self.do_stop(m, cx);
    // rust: } else if let Some(at) = mem(m).look_target.value().and_then(|l| l.position(cx.w)) {
    // rust: m.look_at(at);
}
}
    // rust: B::FeelingHappy(t) | B::Scenting(t) | B::DoNothing(t) => {
    // rust: if t.timed_out(now) {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::Digging(t) => {
    // rust: let ok =
    // rust: mem(m).sniffer_digging.present() && can_dig(m, cx.w) && m.extra.in_love <= 0;
    // rust: if t.timed_out(now) || !ok {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::FinishedDigging(t) => {
    // rust: if t.timed_out(now) || !mem(m).sniffer_digging.present() {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::Searching(t) => {
    // rust: let still = if !can_sniff(m) {
    // rust: transition(m, cx, sniffer::IDLING);
    // rust: false
    // rust: } else {
    // rust: let w = cx.w;
    // rust: let mm = mem(m);
    // rust: match (
    // rust: mm.walk_target.value().and_then(|t| t.target.block(w)),
    // rust: mm.sniffer_sniffing_target.value(),
    // rust: ) {
    // rust: (Some(a), Some(b)) => a == b,
    // rust: _ => false,
}
}
    // rust: if t.timed_out(now) || !still {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::Sniffing(t) => {
    // rust: if t.timed_out(now) || !can_sniff(m) {
    // rust: self.do_stop(m, cx);
}
}
    // rust: B::WalkToLookTarget { .. }
    // rust: | B::LookAtPlayer(_)
    // rust: | B::LookAtPlayerSometimes(..)
    // rust: | B::InteractWithDoor { .. }
    // rust: | B::Stroll { .. }
    // rust: | B::FollowAdult { .. } => {}
}
}

    // `BehaviorControl.doStop`.
do_stop :: proc(self: ^Self, m: ^Mob, cx: ^Bx) {
}
    // rust: if self.one_shot() {
    // rust: self.set_one_shot(false);
    // rust: return;
}
    // rust: let now = cx.now;
    // rust: match self {
    // rust: B::AxolotlAction { .. } => {}
    // rust: B::PlayDead(t) => t.running = false,
    // rust: B::Gate(g) => g.do_stop(m, cx),
    // rust: B::Swim(t) | B::DoNothing(t) => t.running = false,
    // rust: B::AnimalPanic { t, .. } => {
    // rust: t.running = false;
    // rust: mem(m).is_panicking.clear();
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
    // rust: B::CountDownTemptation(t) => {
    // rust: t.running = false;
    // rust: mem(m).temptation_cooldown_ticks.clear();
}
    // rust: B::CountDownGaze(t) => {
    // rust: t.running = false;
    // rust: mem(m).gaze_cooldown_ticks.clear();
}
    // rust: B::CountDownTransport(t) => {
    // rust: t.running = false;
    // rust: mem(m).transport_items_cooldown_ticks.clear();
}
    // rust: B::Transport(x) => x.do_stop(m, cx),
    // rust: B::MakeLove { t, spawn_at } => {
    // rust: t.running = false;
    // rust: let mm = mem(m);
    // rust: mm.breed_target.clear();
    // rust: mm.walk_target.clear();
    // rust: mm.look_target.clear();
    // rust: *spawn_at = 0;
}
    // rust: B::FollowTemptation { t, .. } => {
    // rust: t.running = false;
    // rust: let mm = mem(m);
    // rust: mm.temptation_cooldown_ticks.set(100);
    // rust: mm.walk_target.clear();
    // rust: mm.look_target.clear();
}
    // rust: B::LookAtTargetSink(t) => {
    // rust: t.running = false;
    // rust: mem(m).look_target.clear();
}
    // rust: B::FeelingHappy(t) => {
    // rust: t.running = false;
    // rust: transition(m, cx, sniffer::IDLING);
    // rust: mem(m).sniffer_happy.clear();
}
    // rust: B::Digging(t) => {
    // rust: t.running = false;
    // rust: if t.timed_out(now) {
    // rust: mem(m).sniff_cooldown.set_ttl((), 9600);
    // rust: } else {
    // rust: reset_sniffing(m, cx);
}
}
    // rust: B::FinishedDigging(t) => {
    // rust: t.running = false;
    // rust: let finished = t.timed_out(now);
    // rust: transition(m, cx, sniffer::IDLING);
    // rust: if finished {
                    // onDiggingComplete: storeExploredPosition(getOnPos()).
    // rust: let p = sniffer::on_pos(m);
    // rust: m.extra.positions.truncate(EXPLORED_MAX);
    // rust: m.extra.positions.insert(0, p);
}
    // rust: let mm = mem(m);
    // rust: mm.sniffer_digging.clear();
    // rust: mm.sniffer_happy.set(true);
}
    // rust: B::Searching(t) => {
    // rust: t.running = false;
    // rust: if can_dig(m, cx.w) && can_sniff(m) {
    // rust: mem(m).sniffer_digging.set(true);
}
    // rust: let mm = mem(m);
    // rust: mm.walk_target.clear();
    // rust: mm.sniffer_sniffing_target.clear();
}
    // rust: B::Scenting(t) => {
    // rust: t.running = false;
    // rust: transition(m, cx, sniffer::IDLING);
}
    // rust: B::Sniffing(t) => {
    // rust: t.running = false;
    // rust: let finished = t.timed_out(now);
    // rust: transition(m, cx, sniffer::IDLING);
    // rust: if finished && let Some(p) = dig_position(m, cx.w) {
    // rust: let mm = mem(m);
    // rust: mm.sniffer_sniffing_target.set(p);
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: Tracker::Block(p),
    // rust: speed: 1.25,
    // rust: close: 0,
    // rust: });
}
}
    // rust: B::WalkToLookTarget { .. }
    // rust: | B::LookAtPlayer(_)
    // rust: | B::LookAtPlayerSometimes(..)
    // rust: | B::InteractWithDoor { .. }
    // rust: | B::Stroll { .. }
    // rust: | B::FollowAdult { .. } => {}
}
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
dist_sqr :: proc(a: [i32; 3], b: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let d = |i: usize| i64::from(a[i] - b[i]);
    // rust: d(0) * d(0) + d(1) * d(1) + d(2) * d(2)
}
manhattan :: proc(a: [i32; 3], b: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (a[0] - b[0]).abs() + (a[1] - b[1]).abs() + (a[2] - b[2]).abs()
}
// `Swim`: deeper than the jump threshold, or in lava.
swim_condition :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.fluids.water > m.fluid_jump_threshold() || m.fluids.in_lava
}
// `PositionTracker.isVisibleBy`.
tracker_visible :: proc(m: ^Mob, w: ^MobWorld, t: Tracker) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tracker::Entity { who, .. } => {
    // rust: w.target_info(who).is_some_and(|i| i.alive) && visible_contains(m, w, who)
}
    // rust: Tracker::Block(_) => true,
}
}
// `MoveToTargetSink.reachedTarget`.
reached :: proc(m: ^Mob, w: ^MobWorld, walk: ^WalkTarget) -> b {
    // Ported from Horizon
    return {}
}
    // rust: walk.target
    // rust: .block(w)
    // rust: .is_some_and(|p| manhattan(p, block_of(m.position)) <= walk.close)
}
// `MoveToTargetSink.tryComputePath`.
    // rust: fn compute_path(
    // rust: m: &mut Mob,
    // rust: cx: &mut Bx,
    // rust: walk: &WalkTarget,
    // rust: path: &mut Option<Path>,
    // rust: speed: &mut f32,
    // rust: ) -> bool {
    // rust: let Some(target) = walk.target.block(cx.w) else {
    // rust: return false;
}
    // rust: *path = m.create_path_to(cx.w, target, 0);
    // rust: *speed = walk.speed;
    // rust: if reached(m, cx.w, walk) {
    // rust: mem(m).cant_reach_walk_target_since.clear();
    // rust: } else {
    // rust: let can_reach = path.as_ref().is_some_and(|p| p.reached);
    // rust: let mm = mem(m);
    // rust: if can_reach {
    // rust: mm.cant_reach_walk_target_since.clear();
    // rust: } else if !mm.cant_reach_walk_target_since.present() {
    // rust: mm.cant_reach_walk_target_since.set(cx.now);
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
    // rust: m.default_random_pos_towards(cx.w, 10, 7, to, f64::from(std::f32::consts::FRAC_PI_2))
    // rust: {
    // rust: let p = [
    // rust: step[0].floor() as i32,
    // rust: step[1].floor() as i32,
    // rust: step[2].floor() as i32,
    // rust: ];
    // rust: *path = m.create_path_to(cx.w, p, 0);
    // rust: return path.is_some();
}
}
    // rust: false
}
// `AnimalPanic.getPanicPos`: on land 5 blocks out and 4 up or down, or
// for a flyer the air and water around it ahead (water first when burning
// is not reproduced: no fire reaches these scenarios).
panic_pos :: proc(m: ^Mob, w: ^MobWorld, fly: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if fly {
    // rust: let view = m.view_vector();
    // rust: m.air_and_water_random_pos(w, 5, 4, 0, view[0], view[2])
    // rust: } else {
    // rust: m.land_random_pos(w, 5, 4)
}
}
// `BehaviorUtils.lockGazeAndWalkToEachOther` (this mob's half; the
// partner's comes with the breed-target event).
lock_gaze_and_walk :: proc(m: ^Mob, partner: Who, speed: f32, close: i32) {
}
    // rust: let t = Tracker::entity(partner, true);
    // rust: let mm = mem(m);
    // rust: mm.look_target.set(t);
    // rust: mm.walk_target.set(WalkTarget {
    // rust: target: t,
    // rust: speed,
    // rust: close,
    // rust: });
}
// `FollowTemptation`'s close-enough distance.
follow_temptation_close :: proc(m: ^Mob) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match brain_mut(m).kind {
    // rust: Kind::Sniffer => {
    // rust: if m.is_baby() {
    // rust: 2.5
    // rust: } else {
    // rust: 3.5
}
}
        // `new FollowTemptation(speed)`: the default close-enough distance, 2.5.
    // rust: Kind::Axolotl | Kind::Tadpole => 2.5,
    // rust: Kind::Ghastling | Kind::CopperGolem => 3.0,
}
}
can_mate_with :: proc(m: ^Mob, w: ^MobWorld, partner: Who) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Who::Mob(id) = partner else { return false };
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: s.species == m.species()
    // rust: && s.in_love
    // rust: && m.extra.in_love > 0
    // rust: && (m.species() != Species::Sniffer
    // rust: || sniffer::can_mate_state(sniffer::state(m)) && sniffer::can_mate_state(s.variant))
}
partner_panicking :: proc(_w: ^MobWorld, _partner: Who) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
// `AnimalMakeLove.findValidBreedPartner`.
breed_partner :: proc(m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: find_closest(m, w, |m, who| can_mate_with(m, w, who))
}

// ---- The sniffer --------------------------------------------------------

// `Sniffer.transitionTo`: the state and its sound.
transition :: proc(m: ^Mob, cx: ^Bx, to: u8) {
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let sound = |name: &'static str, pitch: f32| MobEvent::Sound(name, at, 1.0, pitch);
    // rust: match to {
    // rust: sniffer::FEELING_HAPPY => cx.events.push(sound("entity.sniffer.happy", 1.0)),
    // rust: sniffer::SCENTING => {
    // rust: let pitch = if m.is_baby() { 1.3 } else { 1.0 };
    // rust: cx.events.push(sound("entity.sniffer.scenting", pitch));
}
    // rust: sniffer::SNIFFING => cx.events.push(sound("entity.sniffer.sniffing", 1.0)),
        // onDiggingStart: the seed drops 120 ticks in.
    // rust: sniffer::DIGGING => m.extra.ints[3] = m.age as i32 + 120,
    // rust: sniffer::RISING => cx.events.push(sound("entity.sniffer.digging_stop", 1.0)),
    // rust: _ => {}
}
    // rust: sniffer::set_state(m, to);
}
// `SnifferAi.resetSniffing`.
reset_sniffing :: proc(m: ^Mob, cx: ^Bx) {
}
    // rust: let mm = mem(m);
    // rust: mm.sniffer_digging.clear();
    // rust: mm.sniffer_sniffing_target.clear();
    // rust: transition(m, cx, sniffer::IDLING);
}
// `Sniffer.canSniff`.
can_sniff :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !is_tempted(m)
    // rust: && !is_panicking(m)
    // rust: && !m.fluids.in_water
    // rust: && m.extra.in_love <= 0
    // rust: && m.on_ground
    // rust: && !m.extra.passenger
    // rust: && m.extra.leash.is_none()
}
// `Sniffer.canDig(BlockPos)`: diggable, unexplored and reachable.
can_dig_at :: proc(m: ^Mob, w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.has_tag(
    // rust: "minecraft:sniffer_diggable_block",
    // rust: w.block_name(p[0], p[1], p[2]),
    // rust: ) && !m.extra.positions.contains(&p)
    // rust: && m.create_path_to(w, p, 1).is_some_and(|path| path.reached)
}
// `Sniffer.canDig()`.
can_dig :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if is_panicking(m)
    // rust: || is_tempted(m)
    // rust: || m.is_baby()
    // rust: || m.fluids.in_water
    // rust: || !m.on_ground
    // rust: || m.extra.passenger
    // rust: {
    // rust: return false;
}
    // rust: let head = sniffer::head_block(m);
    // rust: can_dig_at(m, w, [head[0], head[1] - 1, head[2]])
}
// `Sniffer.calculateDigPosition`: the first of five ever wider land
// positions whose block below can be dug.
dig_position :: proc(m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: for idx in 0..5 {
    // rust: let Some(p) = m.land_random_pos(w, 10 + 2 * idx, 3) else {
    // rust: continue;
}
    // rust: let below = [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32 - 1,
    // rust: p[2].floor() as i32,
    // rust: ];
    // rust: if can_dig_at(m, w, below) {
    // rust: return Some(below);
}
}
    // rust: None
}

// `SnifferAi.getActivities`, in `availableBehaviorsByPriority` order: by
// priority (`ActivityData.create(CORE, 0, ...)` numbers the core
// behaviours 0, 1, 2...), then by the activity's bucket in the 16-bucket
// `HashMap<Activity, ...>` (core 1, dig 3, idle 5, sniff 6, panic 15),
// then in insertion order.
sniffer_package :: proc(seed: i64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let e = |act: Act, b: B| Entry { act, b };
    // rust: let mut l = vec![
        // Priority 0: core, dig, idle, sniff.
    // rust: e(Act::Core, B::Swim(Timed::new(60, 60))),
    // rust: e(Act::Dig, B::Digging(Timed::new(160, 180))),
    // rust: e(Act::Dig, B::FinishedDigging(Timed::new(40, 40))),
    // rust: e(
    // rust: Act::Idle,
    // rust: B::MakeLove {
    // rust: t: Timed::new(110, 110),
    // rust: spawn_at: 0,
    // rust: },
    // rust: ),
    // rust: e(Act::Sniff, B::Searching(Timed::new(600, 600))),
        // Priority 1.
    // rust: e(
    // rust: Act::Core,
    // rust: B::AnimalPanic {
    // rust: t: Timed::new(100, 120),
    // rust: fly: false,
    // rust: speed: 2.0,
    // rust: },
    // rust: ),
    // rust: e(
    // rust: Act::Idle,
    // rust: B::FollowTemptation {
    // rust: t: Timed::new(60, 60),
    // rust: look_in_the_eyes: false,
    // rust: },
    // rust: ),
        // Priority 2.
    // rust: e(Act::Core, move_to_target_sink(500, 700)),
    // rust: e(Act::Idle, B::LookAtTargetSink(Timed::new(45, 90))),
        // Priority 3.
    // rust: e(Act::Core, B::CountDownTemptation(Timed::new(60, 60))),
    // rust: e(Act::Idle, B::FeelingHappy(Timed::new(40, 100))),
    // rust: ];
    // Priority 4.
    // rust: l.push(e(
    // rust: Act::Idle,
    // rust: B::Gate(Box::new(Gate::run_one(
    // rust: seed,
    // rust: vec![
    // rust: (
    // rust: B::WalkToLookTarget {
    // rust: running: false,
    // rust: speed: 1.0,
    // rust: close: 3,
    // rust: },
    // rust: 2,
    // rust: ),
    // rust: (B::Scenting(Timed::new(40, 80)), 1),
    // rust: (B::Sniffing(Timed::new(40, 80)), 1),
    // rust: (B::LookAtPlayer(false), 1),
    // rust: (
    // rust: B::Stroll {
    // rust: running: false,
    // rust: fly: false,
    // rust: speed: 1.0,
    // rust: range: (10, 7),
    // rust: },
    // rust: 1,
    // rust: ),
    // rust: (B::DoNothing(Timed::new(5, 20)), 2),
    // rust: ],
    // rust: ))),
    // rust: ));
    // rust: l
}
// `HappyGhastAi.getActivities`, in `availableBehaviorsByPriority` order.
// `CopperGolemAi.getActivities`, in tick order: the core behaviours take
// priorities 0 to 5 in turn (`ActivityData.create(CORE, 0, ..)`), the idle
// ones 0, 1 and 2.
copper_golem_package :: proc(seed: i64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let e = |act: Act, b: B| Entry { act, b };
    // rust: vec![
        // Priority 0.
    // rust: e(
    // rust: Act::Core,
    // rust: B::AnimalPanic {
    // rust: t: Timed::new(100, 120),
    // rust: fly: false,
    // rust: speed: 1.5,
    // rust: },
    // rust: ),
    // rust: e(Act::Idle, B::Transport(Box::default())),
        // Priority 1.
    // rust: e(Act::Core, B::LookAtTargetSink(Timed::new(45, 90))),
    // rust: e(Act::Idle, B::LookAtPlayerSometimes(false, 0)),
        // Priority 2: RunOne(stroll or do nothing) while there is no walk
        // target and the transport cools down.
    // rust: e(Act::Core, move_to_target_sink(150, 250)),
    // rust: e(
    // rust: Act::Idle,
    // rust: B::Gate(Box::new(
    // rust: Gate::run_one(
    // rust: seed,
    // rust: vec![
    // rust: (
    // rust: B::Stroll {
    // rust: running: false,
    // rust: fly: false,
    // rust: speed: 1.0,
    // rust: range: (2, 2),
    // rust: },
    // rust: 1,
    // rust: ),
    // rust: (B::DoNothing(Timed::new(30, 60)), 1),
    // rust: ],
    // rust: )
    // rust: .when(|mm| {
    // rust: !mm.walk_target.present() && mm.transport_items_cooldown_ticks.present()
    // rust: }),
    // rust: )),
    // rust: ),
        // Priority 3.
    // rust: e(
    // rust: Act::Core,
    // rust: B::InteractWithDoor {
    // rust: running: false,
    // rust: last_node: None,
    // rust: cooldown: 0,
    // rust: },
    // rust: ),
        // Priorities 4 and 5.
    // rust: e(Act::Core, B::CountDownGaze(Timed::new(60, 60))),
    // rust: e(Act::Core, B::CountDownTransport(Timed::new(60, 60))),
    // rust: ]
}

ghastling_package :: proc(seed: i64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let e = |act: Act, b: B| Entry { act, b };
    // rust: vec![
        // Priority 0.
    // rust: e(Act::Core, B::Swim(Timed::new(60, 60))),
        // Priority 1.
    // rust: e(
    // rust: Act::Core,
    // rust: B::AnimalPanic {
    // rust: t: Timed::new(100, 120),
    // rust: fly: true,
    // rust: speed: 2.0,
    // rust: },
    // rust: ),
    // rust: e(
    // rust: Act::Idle,
    // rust: B::FollowTemptation {
    // rust: t: Timed::new(60, 60),
    // rust: look_in_the_eyes: true,
    // rust: },
    // rust: ),
        // Priority 2.
    // rust: e(Act::Core, B::LookAtTargetSink(Timed::new(45, 90))),
    // rust: e(
    // rust: Act::Idle,
    // rust: B::FollowAdult {
    // rust: running: false,
    // rust: player: true,
    // rust: },
    // rust: ),
        // Priority 3.
    // rust: e(Act::Core, move_to_target_sink(150, 250)),
    // rust: e(
    // rust: Act::Idle,
    // rust: B::FollowAdult {
    // rust: running: false,
    // rust: player: false,
    // rust: },
    // rust: ),
        // Priority 4.
    // rust: e(Act::Core, B::CountDownTemptation(Timed::new(60, 60))),
    // rust: e(
    // rust: Act::Idle,
    // rust: B::Gate(Box::new(Gate::run_one(
    // rust: seed,
    // rust: vec![
    // rust: (
    // rust: B::Stroll {
    // rust: running: false,
    // rust: fly: true,
    // rust: speed: 1.0,
    // rust: range: (10, 7),
    // rust: },
    // rust: 1,
    // rust: ),
    // rust: (
    // rust: B::WalkToLookTarget {
    // rust: running: false,
    // rust: speed: 1.0,
    // rust: close: 3,
    // rust: },
    // rust: 1,
    // rust: ),
    // rust: ],
    // rust: ))),
    // rust: ),
    // rust: ]
}
move_to_target_sink :: proc(min: i32, max: i32) -> B {
    // Ported from Horizon
    return {}
}
    // rust: B::MoveToTargetSink {
    // rust: t: Timed::new(min, max),
    // rust: cooldown: 0,
    // rust: path: None,
    // rust: last_target: None,
    // rust: speed: 0.0,
}
}

// ---- AxolotlAi -----------------------------------------------------------

AxolotlAction :: enum {
    ValidateDead,
    StartAttack,
    StopAttack,
    Chase,
    Bite,
    EraseAttackBreeding,
    EraseDeadBreeding,
    FindLiquid,
    SwimStroll,
    WalkFromLook,
    // `SetWalkTargetFromLookTarget.create(0.5, 3)` of the tadpole: no condition on the
    // water, a fixed speed.
    TadpoleWalkFromLook,
    StayWater,
    StayGround,
}
axolotl_speed :: proc(m: ^Mob, chase: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if m.fluids.in_water {
    // rust: if chase { 0.6 } else { 0.5 }
    // rust: } else {
    // rust: 0.15
}
}
set_play_dead :: proc(m: ^Mob) {
}
    // rust: if m.extra.animal_brain.is_none() {
    // rust: init(m, i64::from(m.id));
}
    // rust: mem(m).play_dead_ticks.set(super::axolotl::PLAY_DEAD_TICKS);
}
hunting_cooldown :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: mem_ref(m).and_then(|mm| {
    // rust: mm.hunting_cooldown
    // rust: .get()
    // rust: .and_then(|_| (mm.hunting_cooldown.ttl > 0).then_some(mm.hunting_cooldown.ttl))
    // rust: })
}
set_hunting_cooldown :: proc(m: ^Mob, ticks: i64) {
}
    // rust: if m.extra.animal_brain.is_none() {
    // rust: init(m, i64::from(m.id));
}
    // rust: if ticks > 0 {
    // rust: mem(m).hunting_cooldown.set_ttl(true, ticks);
    // rust: } else {
    // rust: mem(m).hunting_cooldown.clear();
}
}
validate_play_dead :: proc(b: ^Brain) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(ticks) = b.mem.play_dead_ticks.value() else {
    // rust: return false;
}
    // rust: if ticks <= 0 {
    // rust: b.mem.play_dead_ticks.clear();
    // rust: b.mem.hurt_by_entity.clear();
    // rust: b.activity = Act::Idle;
    // rust: } else {
    // rust: b.mem.play_dead_ticks.set(ticks - 1);
}
    // rust: true
}
update_axolotl_activity :: proc(b: ^Brain) {
}
    // rust: let old = b.activity;
    // PLAY_DEAD remains active until ValidatePlayDead resets to default IDLE.
    // rust: if old == Act::PlayDead {
    // rust: return;
}
    // rust: b.activity = if b.mem.play_dead_ticks.present() {
    // rust: Act::PlayDead
    // rust: } else if b.mem.attack_target.present() {
    // rust: Act::Fight
    // rust: } else {
    // rust: Act::Idle
}
    // rust: if old != b.activity && old == Act::Fight {
    // rust: b.mem
    // rust: .hunting_cooldown
    // rust: .set_ttl(true, super::axolotl::HUNTING_COOLDOWN);
    // rust: b.mem.attack_target.clear();
}
}
sense_axolotl_attackables :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let cooldown = mem(m).hunting_cooldown.present();
    // rust: let target = find_closest(m, w, |m, who| {
    // rust: let Who::Mob(id) = who else { return false };
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: let id = format!("minecraft:{}", super::species::def(s.species).name);
    // rust: super::axolotl::prey_eligible(
    // rust: m.distance_sqr(s.position),
    // rust: s.in_water,
    // rust: w.data.entity_has("minecraft:axolotl_always_hostiles", &id),
    // rust: w.data.entity_has("minecraft:axolotl_hunt_targets", &id),
    // rust: cooldown,
    // rust: s.alive && !s.playing_dead,
    // rust: )
    // rust: });
    // rust: mem(m).nearest_attackable.set_opt(target);
}
axolotl_action :: proc(m: ^Mob, cx: ^Bx, action: AxolotlAction, until: ^i64) -> b {
    // Ported from Horizon
    return {}
}
//     use AxolotlAction::*;
    // rust: match action {
    // rust: ValidateDead => validate_play_dead(brain_mut(m)),
    // rust: StartAttack => {
    // rust: let mm = mem(m);
    // rust: if mm.attack_target.present() || mm.breed_target.present() {
    // rust: return false;
}
    // rust: let Some(target) = mm.nearest_attackable.value() else {
    // rust: return false;
}
    // rust: if !cx
    // rust: .w
    // rust: .target_info(target)
    // rust: .is_some_and(|t| t.alive && !t.creative)
    // rust: {
    // rust: return false;
}
    // rust: mem(m).attack_target.set(target);
    // rust: mem(m).cant_reach_walk_target_since.clear();
    // rust: m.ai.target = Some(target);
    // rust: true
}
    // rust: StopAttack => {
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return false;
}
    // rust: let tired = mem(m)
    // rust: .cant_reach_walk_target_since
    // rust: .value()
    // rust: .is_some_and(|t| cx.now - t > 200);
    // rust: let valid =
    // rust: cx.w.target_info(target)
    // rust: .is_some_and(|t| t.alive && !t.creative)
    // rust: && match target {
    // rust: Who::Mob(id) => cx.w.seen(id).is_some_and(|s| !s.playing_dead),
    // rust: Who::Player => true,
}
    // rust: if tired || !valid {
    // rust: super::axolotl::on_stop_attacking(m, cx.w, target, cx.events);
    // rust: mem(m).attack_target.clear();
    // rust: m.ai.target = None;
}
    // rust: true
}
    // rust: Chase => {
    // rust: let Some(target) = mem(m).attack_target.value() else {
    // rust: return false;
}
    // rust: let speed = axolotl_speed(m, true);
    // rust: if cx
    // rust: .w
    // rust: .target_info(target)
    // rust: .is_some_and(|t| m.within_melee_range(&t))
    // rust: && visible_contains(m, cx.w, target)
    // rust: {
    // rust: mem(m).walk_target.clear();
    // rust: } else {
    // rust: let tracker = Tracker::entity(target, true);
    // rust: mem(m).look_target.set(tracker);
    // rust: mem(m).walk_target.set(WalkTarget {
    // rust: target: Tracker::entity(target, false),
    // rust: speed,
    // rust: close: 0,
    // rust: });
}
    // rust: true
}
    // rust: Bite => {
    // rust: let mm = mem(m);
    // rust: if mm.attack_cooling_down.present() {
    // rust: return false;
}
    // rust: let Some(target) = mm.attack_target.value() else {
    // rust: return false;
}
    // rust: if !visible_contains(m, cx.w, target)
    // rust: || !cx
    // rust: .w
    // rust: .target_info(target)
    // rust: .is_some_and(|t| m.within_melee_range(&t))
    // rust: {
    // rust: return false;
}
    // rust: mem(m).look_target.set(Tracker::entity(target, true));
    // rust: m.swing();
    // rust: super::ai::do_hurt_target(
    // rust: m,
    // rust: target,
    // rust: &mut super::goals::Cx {
    // rust: w: cx.w,
    // rust: lr: cx.lr,
    // rust: events: cx.events,
    // rust: },
    // rust: );
    // rust: mem(m).attack_cooling_down.set_ttl(true, 20);
    // rust: true
}
    // rust: EraseAttackBreeding | EraseDeadBreeding => {
    // rust: if !mem(m).breed_target.present() {
    // rust: return false;
}
    // rust: if matches!(action, EraseAttackBreeding) {
    // rust: mem(m).attack_target.clear();
    // rust: } else {
    // rust: mem(m).play_dead_ticks.clear();
}
    // rust: true
}
    // rust: FindLiquid => {
    // rust: if mem(m).walk_target.present() || mem(m).attack_target.present() {
    // rust: return false;
}
    // rust: let p = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: if cx.w.fluid(p[0], p[1], p[2]) == crate::blocks::Fluid::Water {
    // rust: return false;
}
    // rust: if cx.now < *until {
    // rust: *until = cx.now + 22;
    // rust: return true;
}
    // rust: let mut positions = Vec::new();
            // BlockPos.withinManhattan: distance, x, y, then positive/negative z.
    // rust: for distance in 0..=18i32 {
    // rust: for x in -6..=6i32 {
    // rust: for y in -6..=6i32 {
    // rust: let z = distance - x.abs() - y.abs();
    // rust: if !(0..=6).contains(&z) {
    // rust: continue;
}
    // rust: positions.push([p[0] + x, p[1] + y, p[2] + z]);
    // rust: if z != 0 {
    // rust: positions.push([p[0] + x, p[1] + y, p[2] - z]);
}
}
}
}
    // rust: let mut found = None;
    // rust: for q in positions {
    // rust: if (q[0] == p[0] && q[2] == p[2])
    // rust: || cx.w.fluid(q[0], q[1], q[2]) != crate::blocks::Fluid::Water
    // rust: {
    // rust: continue;
}
    // rust: let name = cx.w.block_name(q[0], q[1], q[2]);
    // rust: if name != "minecraft:water" {
    // rust: continue;
}
    // rust: if cx.w.block_name(q[0], q[1] + 1, q[2]).ends_with("air") {
    // rust: found = Some(q);
    // rust: break;
}
    // rust: let v = Vec3::new(
    // rust: f64::from(q[0]) + 0.5,
    // rust: f64::from(q[1]) + 0.5,
    // rust: f64::from(q[2]) + 0.5,
    // rust: );
    // rust: if found.is_none() && m.distance_sqr(v) >= 2.25 {
    // rust: found = Some(q);
}
}
    // rust: if let Some(q) = found {
    // rust: mem(m).look_target.set(Tracker::Block(q));
    // rust: mem(m).walk_target.set(WalkTarget {
    // rust: target: Tracker::Block(q),
    // rust: speed: 0.15,
    // rust: close: 0,
    // rust: });
}
    // rust: *until = cx.now + 40;
    // rust: true
}
    // rust: SwimStroll => {
    // rust: if mem(m).walk_target.present() || !m.fluids.in_water {
    // rust: return false;
}
    // rust: let mut fallback: Option<Vec3> = None;
    // rust: for (h, v) in [(1, 1), (3, 3), (5, 5), (6, 5), (7, 7), (10, 7)] {
    // rust: let point = if let Some(p) = fallback {
    // rust: let delta =
    // rust: Vec3::new(p.x - m.position.x, p.y - m.position.y, p.z - m.position.z);
    // rust: let length = (delta.x * delta.x + delta.y * delta.y + delta.z * delta.z).sqrt();
    // rust: let n = if length < 1.0e-5 {
    // rust: Vec3::ZERO
    // rust: } else {
    // rust: Vec3::new(delta.x / length, delta.y / length, delta.z / length)
}
    // rust: Some(Vec3::new(
    // rust: m.position.x + n.x * f64::from(h),
    // rust: m.position.y + n.y * f64::from(v),
    // rust: m.position.z + n.z * f64::from(h),
    // rust: ))
    // rust: } else {
    // rust: let mut p = m.default_random_pos(cx.w, h, v);
    // rust: let mut count = 0;
    // rust: while let Some(q) = p {
    // rust: let state = cx.w.world.block(
    // rust: q[0].floor() as i32,
    // rust: q[1].floor() as i32,
    // rust: q[2].floor() as i32,
    // rust: );
    // rust: if cx.w.data.state(state).flags & super::data::WATER != 0 || count >= 10 {
    // rust: break;
}
    // rust: count += 1;
    // rust: p = m.default_random_pos(cx.w, h, v);
}
    // rust: p.map(|q| Vec3::new(q[0], q[1], q[2]))
}
    // rust: let Some(point) = point else { break };
    // rust: let q = [
    // rust: point.x.floor() as i32,
    // rust: point.y.floor() as i32,
    // rust: point.z.floor() as i32,
    // rust: ];
    // rust: let restricted = m.restricted(f64::from(h), q);
    // rust: if cx.w.fluid(q[0], q[1], q[2]) == crate::blocks::Fluid::None || restricted {
    // rust: break;
}
    // rust: fallback = Some(point);
}
    // rust: mem(m)
    // rust: .walk_target
    // rust: .set_opt(fallback.map(|p| WalkTarget::point([p.x, p.y, p.z], 0.5, 0)));
    // rust: true
}
    // rust: WalkFromLook => {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let Some(t) = mem(m).look_target.value() else {
    // rust: return false;
}
    // rust: let Some(p) = t.block(cx.w) else { return false };
    // rust: if (cx.w.fluid(p[0], p[1], p[2]) == crate::blocks::Fluid::Water) != m.fluids.in_water {
    // rust: return false;
}
    // rust: let speed = axolotl_speed(m, false);
    // rust: mem(m).walk_target.set(WalkTarget {
    // rust: target: t,
    // rust: speed,
    // rust: close: 3,
    // rust: });
    // rust: true
}
    // rust: TadpoleWalkFromLook => {
    // rust: if mem(m).walk_target.present() {
    // rust: return false;
}
    // rust: let Some(t) = mem(m).look_target.value() else {
    // rust: return false;
}
    // rust: mem(m).walk_target.set(WalkTarget {
    // rust: target: t,
    // rust: speed: 0.5,
    // rust: close: 3,
    // rust: });
    // rust: true
}
    // rust: StayWater => m.fluids.in_water,
    // rust: StayGround => m.on_ground,
}
}
// `TadpoleAi`: the core activity (panic 2.0, the look and move sinks, the temptation
// cooldown) and the idle one (look at a player now and then, follow frog food at 1.25,
// then swim about, walk to what it looks at, or stay put in water).
tadpole_package :: proc(seed: i64) -> V {
    // Ported from Horizon
    return {}
}
//     use Act::*;
//     use AxolotlAction::*;
    // rust: let e = |act, b| Entry { act, b };
    // rust: let action = |action| B::AxolotlAction {
    // rust: action,
    // rust: running: false,
    // rust: until: 0,
}
    // rust: vec![
        // Priority 0.
    // rust: e(
    // rust: Core,
    // rust: B::AnimalPanic {
    // rust: t: Timed::new(100, 120),
    // rust: fly: false,
    // rust: speed: 2.0,
    // rust: },
    // rust: ),
    // rust: e(Idle, B::LookAtPlayerSometimes(false, 0)),
        // Priority 1.
    // rust: e(Core, B::LookAtTargetSink(Timed::new(45, 90))),
    // rust: e(
    // rust: Idle,
    // rust: B::FollowTemptation {
    // rust: t: Timed::new(60, 60),
    // rust: look_in_the_eyes: false,
    // rust: },
    // rust: ),
        // Priority 2.
    // rust: e(Core, move_to_target_sink(150, 250)),
    // rust: e(
    // rust: Idle,
    // rust: B::Gate(Box::new(Gate {
    // rust: running: false,
    // rust: shuffle: false,
    // rust: try_all: true,
    // rust: random: horizon_core::random::LegacyRandom::new(seed),
    // rust: kids: vec![
    // rust: (action(SwimStroll), 2, 0.0),
    // rust: (action(TadpoleWalkFromLook), 3, 0.0),
    // rust: (action(StayWater), 5, 0.0),
    // rust: ],
    // rust: when: Some(|mm| !mm.walk_target.present()),
    // rust: })),
    // rust: ),
        // Priority 3.
    // rust: e(Core, B::CountDownTemptation(Timed::new(60, 60))),
    // rust: ]
}
axolotl_package :: proc(seed: i64) -> V {
    // Ported from Horizon
    return {}
}
//     use Act::*;
//     use AxolotlAction::*;
    // rust: let e = |act, b| Entry { act, b };
    // rust: let action = |action| B::AxolotlAction {
    // rust: action,
    // rust: running: false,
    // rust: until: 0,
}
    // rust: vec![
        // Native activity slots, merged by behavior priority.
    // rust: e(Core, B::LookAtTargetSink(Timed::new(45, 90))),
    // rust: e(Idle, B::LookAtPlayerSometimes(false, 0)),
    // rust: e(Fight, action(StopAttack)),
    // rust: e(PlayDead, B::PlayDead(Timed::new(200, 200))),
    // rust: e(Core, move_to_target_sink(150, 250)),
    // rust: e(
    // rust: Idle,
    // rust: B::MakeLove {
    // rust: t: Timed::new(110, 110),
    // rust: spawn_at: 0,
    // rust: },
    // rust: ),
    // rust: e(Fight, action(Chase)),
    // rust: e(PlayDead, action(EraseDeadBreeding)),
    // rust: e(Core, action(ValidateDead)),
    // rust: e(
    // rust: Idle,
    // rust: B::Gate(Box::new(Gate::run_one(
    // rust: seed,
    // rust: vec![
    // rust: (
    // rust: B::FollowTemptation {
    // rust: t: Timed::new(60, 60),
    // rust: look_in_the_eyes: false,
    // rust: },
    // rust: 1,
    // rust: ),
    // rust: (
    // rust: B::FollowAdult {
    // rust: running: false,
    // rust: player: false,
    // rust: },
    // rust: 1,
    // rust: ),
    // rust: ],
    // rust: ))),
    // rust: ),
    // rust: e(Fight, action(Bite)),
    // rust: e(Core, B::CountDownTemptation(Timed::new(60, 60))),
    // rust: e(Idle, action(StartAttack)),
    // rust: e(Idle, action(FindLiquid)),
    // rust: e(Fight, action(EraseAttackBreeding)),
    // rust: e(
    // rust: Idle,
    // rust: B::Gate(Box::new(Gate {
    // rust: running: false,
    // rust: shuffle: false,
    // rust: try_all: true,
    // rust: random: horizon_core::random::LegacyRandom::new(seed),
    // rust: kids: vec![
    // rust: (action(SwimStroll), 2, 0.0),
    // rust: (
    // rust: B::Stroll {
    // rust: running: false,
    // rust: fly: false,
    // rust: speed: 0.15,
    // rust: range: (10, 7),
    // rust: },
    // rust: 2,
    // rust: 0.0,
    // rust: ),
    // rust: (action(WalkFromLook), 3, 0.0),
    // rust: (action(StayWater), 5, 0.0),
    // rust: (action(StayGround), 5, 0.0),
    // rust: ],
    // rust: when: Some(|mm| !mm.walk_target.present()),
    // rust: })),
    // rust: ),
    // rust: ]
}

// ---- Debug output (the mob AI harness) ------------------------------------

pos :: proc(p: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{},{},{}", p[0], p[1], p[2])
}
who :: proc(w: Who) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match w {
    // rust: Who::Player => "player".into(),
    // rust: Who::Mob(id) => format!("e{id}"),
}
}
tracker :: proc(t: Tracker) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tracker::Entity { who: e, .. } => who(e),
    // rust: Tracker::Block(p) => pos(p),
}
}

// The active activities and the memories, as the mob AI oracle prints
// them.
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
    // rust: let n = |l: &Vec<Who>| format!("n{}", l.len());
    // rust: slot!("nearest_attackable", mm.nearest_attackable, |v: &Who| who(
    // rust: *v
    // rust: ));
    // rust: slot!("attack_target", mm.attack_target, |v: &Who| who(*v));
    // rust: slot!("attack_cooling_down", mm.attack_cooling_down, |v: &bool| v
    // rust: .to_string());
    // rust: slot!("has_hunting_cooldown", mm.hunting_cooldown, |v: &bool| v
    // rust: .to_string());
    // rust: slot!("play_dead_ticks", mm.play_dead_ticks, |v: &i32| v
    // rust: .to_string());
    // rust: slot!("mobs", mm.mobs, n);
    // rust: slot!("visible_mobs", mm.visible_mobs, |_: &Visible| {
    // rust: "NearestVisibleLivingEntities".to_string()
    // rust: });
    // rust: slot!("nearest_players", mm.nearest_players, n);
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
    // rust: n
    // rust: );
    // rust: slot!(
    // rust: "nearest_visible_adult",
    // rust: mm.nearest_visible_adult,
    // rust: |e: &Who| who(*e)
    // rust: );
    // rust: slot!("walk_target", mm.walk_target, |t: &WalkTarget| format!(
    // rust: "{}/{:x}/{}",
    // rust: tracker(t.target),
    // rust: t.speed.to_bits(),
    // rust: t.close
    // rust: ));
    // rust: slot!("look_target", mm.look_target, |t: &Tracker| tracker(*t));
    // rust: slot!("breed_target", mm.breed_target, |e: &Who| who(*e));
    // rust: slot!("path", mm.path, |p: &Path| format!("path{}", pos(p.target)));
    // rust: slot!("hurt_by", mm.hurt_by, |_: &bool| "DamageSource".to_string());
    // rust: slot!("hurt_by_entity", mm.hurt_by_entity, |e: &Who| who(*e));
    // rust: slot!(
    // rust: "cant_reach_walk_target_since",
    // rust: mm.cant_reach_walk_target_since,
    // rust: |t: &i64| t.to_string()
    // rust: );
    // rust: slot!("tempting_player", mm.tempting_player, |e: &Who| who(*e));
    // rust: slot!(
    // rust: "temptation_cooldown_ticks",
    // rust: mm.temptation_cooldown_ticks,
    // rust: |t: &i32| t.to_string()
    // rust: );
    // rust: slot!("is_panicking", mm.is_panicking, |b: &bool| b.to_string());
    // rust: slot!("sniffer_digging", mm.sniffer_digging, |b: &bool| b
    // rust: .to_string());
    // rust: slot!(
    // rust: "sniffer_sniffing_target",
    // rust: mm.sniffer_sniffing_target,
    // rust: |p: &[i32; 3]| pos(*p)
    // rust: );
    // rust: slot!("sniffer_happy", mm.sniffer_happy, |b: &bool| b.to_string());
    // rust: slot!("sniff_cooldown", mm.sniff_cooldown, |_: &()| "u"
    // rust: .to_string());
    // rust: slot!("gaze_cooldown_ticks", mm.gaze_cooldown_ticks, |t: &i32| t
    // rust: .to_string());
    // rust: slot!(
    // rust: "transport_items_cooldown_ticks",
    // rust: mm.transport_items_cooldown_ticks,
    // rust: |t: &i32| t.to_string()
    // rust: );
    // rust: slot!(
    // rust: "doors_to_close",
    // rust: mm.doors_to_close,
    // rust: |l: &Vec<[i32; 3]>| format!("n{}", l.len())
    // rust: );
    // rust: slot!(
    // rust: "visited_block_positions",
    // rust: mm.visited_block_positions,
    // rust: |l: &Vec<[i32; 3]>| format!("n{}", l.len())
    // rust: );
    // rust: slot!(
    // rust: "unreachable_transport_block_positions",
    // rust: mm.unreachable_transport_block_positions,
    // rust: |l: &Vec<[i32; 3]>| format!("n{}", l.len())
    // rust: );
    // rust: if b.kind == Kind::Sniffer && !m.extra.positions.is_empty() {
    // rust: put(
    // rust: "sniffer_explored_positions",
    // rust: format!("n{}", m.extra.positions.len()),
    // rust: NEVER,
    // rust: );
}
    // rust: out.sort();
    // rust: Some((acts.join("|"), out.join(" ")))
}

    // rust: mod axolotl_parity_tests {
//     use super::*;
empty_brain :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: Brain {
    // rust: kind: Kind::Axolotl,
    // rust: mem: Memories::default(),
    // rust: sensors: Vec::new(),
    // rust: activity: Act::Idle,
    // rust: list: Vec::new(),
}
}
fight_exit_sets_hunting_cooldown_and_play_dead_has_priority :: proc() {
}
    // rust: let mut b = empty_brain();
    // rust: b.mem.attack_target.set(Who::Mob(1));
    // rust: update_axolotl_activity(&mut b);
    // rust: assert_eq!(b.activity, Act::Fight);
    // rust: b.mem.play_dead_ticks.set(200);
    // rust: update_axolotl_activity(&mut b);
    // rust: assert_eq!(b.activity, Act::PlayDead);
    // rust: assert_eq!(b.mem.hunting_cooldown.ttl, 2400);
    // rust: assert!(!b.mem.attack_target.present());
    // rust: for _ in 0..2400 {
    // rust: b.mem.hunting_cooldown.tick();
}
    // rust: assert!(b.mem.hunting_cooldown.present());
    // rust: b.mem.hunting_cooldown.tick();
    // rust: assert!(!b.mem.hunting_cooldown.present());
}
play_dead_flag_ends_at_zero_before_memory_is_erased :: proc() {
}
    // rust: let mut b = empty_brain();
    // rust: b.activity = Act::PlayDead;
    // rust: b.mem.play_dead_ticks.set(200);
    // rust: b.mem.hurt_by_entity.set(Who::Mob(7));
    // rust: for _ in 0..200 {
    // rust: assert!(validate_play_dead(&mut b));
}
    // rust: assert_eq!(b.mem.play_dead_ticks.value(), Some(0));
    // rust: assert_eq!(b.activity, Act::PlayDead);
    // rust: assert!(validate_play_dead(&mut b));
    // rust: assert!(!b.mem.play_dead_ticks.present());
    // rust: assert!(!b.mem.hurt_by_entity.present());
    // rust: assert_eq!(b.activity, Act::Idle);
}
axolotl_has_native_activity_brain_not_fallback_goals :: proc() {
}
    // rust: assert!(kind_for_species(Species::Axolotl).is_some());
}
}

    // rust: mod breeding_duration_tests {
//     use super::*;
axolotl_breeding_uses_native_110_tick_timeout :: proc() {
}
    // rust: let package = axolotl_package(1);
    // rust: let timed = package
    // rust: .iter()
    // rust: .find_map(|e| {
    // rust: if let B::MakeLove { t, .. } = &e.b {
    // rust: Some(t)
    // rust: } else {
    // rust: None
}
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!((timed.min, timed.max), (110, 110));
}
}

// `InteractWithDoor`: open the doors on the path, close the ones passed.
interact_with_doors :: proc(m: ^Mob, cx: ^Bx, from: PathNode, to: PathNode) {
}
    // rust: let (from, to) = ([from.x, from.y, from.z], [to.x, to.y, to.z]);
    // The door being left is remembered even when it is open already; the
    // one ahead only when this mob opens it.
    // rust: for (p, always) in [(from, true), (to, false)] {
    // rust: let Some(open) = door_open(cx.w, p) else {
    // rust: continue;
}
    // rust: if !open {
    // rust: cx.events.push(MobEvent::SetDoorOpen { pos: p, open: true });
}
    // rust: if always || !open {
    // rust: let doors = &mut mem(m).doors_to_close;
    // rust: let mut list = doors.get().cloned().unwrap_or_default();
    // rust: if !list.contains(&p) {
    // rust: list.push(p);
    // rust: doors.set(list);
}
}
}
    // rust: close_doors(m, cx, from, to);
}
// Whether the block at `p` is a door mobs open (`MOB_INTERACTABLE_DOORS`),
// and then whether it is open.
door_open :: proc(w: ^MobWorld, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = w.block_name(p[0], p[1], p[2]);
    // rust: (name.ends_with("_door") && w.has_tag("minecraft:mob_interactable_doors", name))
    // rust: .then(|| w.prop(p[0], p[1], p[2], "open") == Some("true"))
}
// `InteractWithDoor.closeDoorsThatIHaveOpenedOrPassedThrough`: the remembered
// doors other than the two of the step being taken are forgotten, and closed
// when still open and within 3 blocks. (Another mob of its kind coming
// through the door is not looked for.)
close_doors :: proc(m: ^Mob, cx: ^Bx, from: [i32; 3], to: [i32; 3]) {
}
    // rust: let Some(doors) = mem(m).doors_to_close.get().cloned() else {
    // rust: return;
}
    // rust: let mut kept = Vec::new();
    // rust: for door in doors {
    // rust: if from == door || to == door {
    // rust: kept.push(door);
    // rust: continue;
}
    // rust: let centre = Vec3::new(
    // rust: f64::from(door[0]) + 0.5,
    // rust: f64::from(door[1]) + 0.5,
    // rust: f64::from(door[2]) + 0.5,
    // rust: );
    // rust: if centre.distance_squared(m.position) >= 9.0 || door_open(cx.w, door) != Some(true) {
    // rust: continue;
}
    // rust: cx.events.push(MobEvent::SetDoorOpen {
    // rust: pos: door,
    // rust: open: false,
    // rust: });
}
    // rust: mem(m).doors_to_close.set(kept);
}
