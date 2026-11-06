//! Transpiled from Horizon Rust crate
package horizon_client_cem_anim

import "core:fmt"
import "core:mem"
import "core:math"

// The `animations` of a custom entity model: compiled with the model when the packs load,
// run per entity per frame after the vanilla animation has posed the parts, so `part.rx`
// reads the vanilla pose and `head.rx = ...` overrides it.
//
// One slot array holds everything an expression reads: the entity's parameters
// (`limb_swing`, `is_child`...) at fixed slots, then, in the order the expressions first name
// them, 11 slots per model part (`tx ty tz rx ry rz sx sy sz visible visible_boxes`, as
// `ModelPart` keeps them: pixels, radians, on vanilla's axes) and one per variable: the
// entity's `var.*` / `varb.*`, which persist from frame to frame, the `global_var.*` /
// `global_varb.*` every entity shares, and `render.*`, which nothing reads back yet.

// use super::{Mob, Part, anim::Poses, anim::State};
// use horizon_optifine::cem::expr::{Expr, compile};
// use std::{
    // rust: cell::{Cell, RefCell},
    // rust: collections::HashMap,
    // rust: sync::{Mutex, MutexGuard, PoisonError},
}

// The model variables of a part, in slot order.
    // rust: const PART_VARS: [&str; 11] = [
    // rust: "tx",
    // rust: "ty",
    // rust: "tz",
    // rust: "rx",
    // rust: "ry",
    // rust: "rz",
    // rust: "sx",
    // rust: "sy",
    // rust: "sz",
    // rust: "visible",
    // rust: "visible_boxes",
    // rust: ];

    // rust: macro_rules! params {
    // rust: ($($name:literal => $p:ident),* $(,)?) => {
        // The entity and render parameters, by slot.
Param :: enum {
PARAMS :: &[$(($name, Param::$p)),*]
}
}
    // rust: params! {
    // rust: "limb_swing" => LimbSwing, "limb_speed" => LimbSpeed, "age" => Age,
    // rust: "head_yaw" => HeadYaw, "head_pitch" => HeadPitch, "swing_progress" => SwingProgress,
    // rust: "health" => Health, "max_health" => MaxHealth, "hurt_time" => HurtTime,
    // rust: "death_time" => DeathTime, "pos_x" => PosX, "pos_y" => PosY, "pos_z" => PosZ,
    // rust: "rot_x" => RotX, "rot_y" => RotY, "id" => Id, "time" => Time, "day_time" => DayTime,
    // rust: "day_count" => DayCount, "frame_time" => FrameTime, "frame_counter" => FrameCounter,
    // rust: "dimension" => Dimension, "player_pos_x" => PlayerX, "player_pos_y" => PlayerY,
    // rust: "player_pos_z" => PlayerZ, "player_rot_x" => PlayerRotX, "player_rot_y" => PlayerRotY,
    // rust: "rule_index" => RuleIndex, "anger_time" => AngerTime, "anger_time_start" => AngerTimeStart,
    // rust: "distance" => Distance, "move_forward" => MoveForward, "move_strafing" => MoveStrafing,
    // rust: "height_above_ground" => HeightAboveGround, "fluid_depth" => FluidDepth,
    // rust: "fluid_depth_down" => FluidDepthDown, "fluid_depth_up" => FluidDepthUp,
    // rust: "is_aggressive" => Aggressive, "is_alive" => Alive, "is_burning" => Burning,
    // rust: "is_child" => Child, "is_glowing" => Glowing, "is_hurt" => Hurt, "is_in_hand" => InHand,
    // rust: "is_in_item_frame" => InItemFrame, "is_in_ground" => InGround, "is_in_gui" => InGui,
    // rust: "is_in_lava" => InLava, "is_in_water" => InWater, "is_invisible" => Invisible,
    // rust: "is_on_ground" => OnGround, "is_on_head" => OnHead, "is_on_shoulder" => OnShoulder,
    // rust: "is_ridden" => Ridden, "is_riding" => Riding, "is_sitting" => Sitting,
    // rust: "is_sneaking" => Sneaking, "is_sprinting" => Sprinting, "is_tamed" => Tamed,
    // rust: "is_wet" => Wet, "is_climbing" => Climbing, "is_blocking" => Blocking,
    // rust: "is_crawling" => Crawling, "is_jumping" => Jumping, "is_swimming" => Swimming,
    // rust: "is_right_handed" => RightHanded, "is_swinging_right_arm" => SwingingRight,
    // rust: "is_swinging_left_arm" => SwingingLeft, "is_first_person_hand" => FirstPersonHand,
    // rust: "is_using_item" => UsingItem, "is_holding_item_right" => HoldingRight,
    // rust: "is_holding_item_left" => HoldingLeft, "is_paused" => Paused, "is_hovered" => Hovered,
    // rust: "is_player_first_person" => FirstPerson, "is_player_third_person" => ThirdPerson,
    // rust: "is_player_third_person_reversed" => ThirdPersonReversed,
}

// What every entity of a frame shares, set once per frame by the game.
Frame :: struct {
    // The world's game time and day time in ticks, with the partial tick.
    time: f64,
    day_time: f64,
    frame_time: f32,
    frame_counter: u32,
    // Overworld 0, nether -1, end 1.
    dimension: f32,
    player: [f64,
    player_rot: [f32,
    paused: bool,
    first_person: bool,
    third_person_reversed: bool,
}

    // rust: impl Frame {
    // Before the first frame: in the overworld at the origin, seen in first person.
    // rust: pub const DEFAULT: Self = Self {
    // rust: time: 0.0,
    // rust: day_time: 0.0,
    // rust: frame_time: 0.0,
    // rust: frame_counter: 0,
    // rust: dimension: 0.0,
    // rust: player: [0.0; 3],
    // rust: player_rot: [0.0; 2],
    // rust: paused: false,
    // rust: first_person: true,
    // rust: third_person_reversed: false,
}
}

    // rust: impl Default for Frame {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::DEFAULT
}
}

FRAME :: Mutex::new(Frame::DEFAULT)

// `m`'s value, even if a thread panicked holding it.
    // rust: fn lock<T>(m: &Mutex<T>) -> MutexGuard<'_, T> {
    // rust: m.lock().unwrap_or_else(PoisonError::into_inner)
}

// The frame the next animations see. Its `frame_time` and `frame_counter` come from the
// calls themselves: the time since the previous one, and how many there were.
set_frame :: proc(mut frame: Frame) {
}
LAST :: Mutex::new(None)
    // rust: let now = std::time::Instant::now();
    // rust: let mut last = lock(&LAST);
    // rust: frame.frame_time = last.map_or(0.0, |t| (now - t).as_secs_f32());
    // rust: *last = Some(now);
    // rust: let mut current = lock(&FRAME);
    // rust: frame.frame_counter = current.frame_counter.wrapping_add(1);
    // rust: *current = frame;
}

frame :: proc() -> F {
    // Ported from Horizon
    return {}
}
    // rust: *lock(&FRAME)
}

    // rust: thread_local!(static IN_GUI: Cell<bool> = const { Cell::new(false) });

// Runs `draw` as a screen's preview of an entity (the inventory's player, a mount's box):
// its animations see `is_in_gui = 1` and store no variables, unless the world didn't draw
// the entity this frame or the last. Screens draw before the world in a frame, so a
// preview runs under the previous frame's counter and time. `set_frame` must not be
// called inside it.
    // rust: pub fn in_gui<R>(draw: impl FnOnce() -> R) -> R {
    // Puts the previous value back, even if `draw` panics.
Restore :: struct {
    // rust: impl Drop for Restore {
drop :: proc(self: ^Self) {
}
    // rust: IN_GUI.set(self.0);
}
}
    // rust: let _restore = Restore(IN_GUI.replace(true));
    // rust: draw()
}

// A part an animation names: its `Poses` name and its first slot.
Bound :: struct {
    name: string,
    base: u32,
}

// One compiled `target = expression`.
Step :: struct {
    slot: u32,
    expr: Expr,
}

// The compiled `animations` of one model layer.
Animation :: struct {
    steps: [dynamic]Step,
    parts: [dynamic]Bound,
    // The model's random-model rules, whose matching number feeds `rule_index`.
    rules: [dynamic]super::cem::Rule,
    // The `var.*` and `varb.*` slots, kept per entity.
    vars: [dynamic]u32,
    // The `global_var.*` and `global_varb.*` slots and their index in `GLOBALS`.
    globals: Vec<(u32,
    slots: uint,
    saved: Mutex<Saved>,
}

// Each entity's variables, by entity id.
Saved :: struct {
    entities: HashMap<u32,
    // The frame of the last eviction, so that a full table is scanned once a frame at most.
    evicted: Maybe(u32),
}

// One entity's variables.
Vars :: struct {
    // The frame counter of the last run.
    frame: u32,
    // A run stored `now` in that frame.
    stored: bool,
    // The last frame a draw in the world stored: a preview stores only when the world
    // didn't draw the entity this frame or the last (the inventory's own player in first
    // person, whom the world never draws).
    world: Maybe(u32),
    // The variables when that frame began: a model drawn again in the same frame (the
    // illusioner's copies, a preview, the glowing pass) starts from them, not from the
    // first draw's result.
    start: ^[f32],
    // The variables the frame's storing draw left.
    now: ^[f32],
    // The shared variables (`global_var.*`) when that frame began for this entity, read by
    // every run of the frame like `start`.
    globals_start: ^[f32],
}

// The variables every entity shares (`global_var.*`): their names, then their values.
Globals :: struct {
    names: [dynamic]string,
    values: [dynamic]f32,
}

    // rust: static GLOBALS: Mutex<Globals> = Mutex::new(Globals {
    // rust: names: Vec::new(),
    // rust: values: Vec::new(),
    // rust: });

// The index of the global variable `name`, registered on first sight.
global :: proc(name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut g = lock(&GLOBALS);
    // rust: let i = match g.names.iter().position(|n| n == name) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: g.names.push(name.to_owned());
    // rust: g.values.push(0.0);
    // rust: g.names.len() - 1
}
}
    // rust: i as u32
}

// How an animation finds the parts it names.
    // rust: pub(super) struct Names<'a> {
    // rust: pub model: &'a Part,
    // The OptiFine part name to the vanilla part's name.
    // rust: pub vanilla: &'a dyn Fn(&str) -> String,
    // Custom bones' ids by their part names (`cem#3`).
    // rust: pub ids: &'a HashMap<String, String>,
}

    // rust: impl Names<'_> {
    // The part a model reference names: a part name or bone id, then bone ids below it.
find :: proc(self: ^Self, reference: string, this: string, part: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut path = reference.split(':');
    // rust: let first = path.next()?;
    // rust: let mut at = match first {
    // rust: "this" => find(self.model, &|p| p.name == this)?,
    // rust: "part" => find(self.model, &|p| p.name == part)?,
    // rust: _ => {
    // rust: let vanilla = (self.vanilla)(first);
    // rust: find(self.model, &|p| p.name == vanilla).or_else(|| {
    // rust: find(self.model, &|p| {
    // rust: self.ids.get(&p.name).is_some_and(|i| i == first)
    // rust: })
    // rust: })?
}
}
    // rust: for id in path {
    // rust: at = at
    // rust: .children
    // rust: .iter()
    // rust: .find_map(|c| find(c, &|p| self.ids.get(&p.name).is_some_and(|i| i == id)))?;
}
    // rust: Some(at.name.clone())
}
}

// The first part of the tree, depth first, that passes `test`.
    // rust: fn find<'a>(part: &'a Part, test: &dyn Fn(&Part) -> bool) -> Option<&'a Part> {
    // rust: if test(part) {
    // rust: return Some(part);
}
    // rust: part.children.iter().find_map(|c| find(c, test))
}

// Hands out slots as the expressions name things: the parameters are fixed at
// `0..PARAMS.len()`, then each new part takes the next 11, each variable the next one.
Layout :: struct {
    names: ^'a Names<'n>,
    next: u32,
    parts: [dynamic]Bound,
    vars: Vec<(string,
    globals: Vec<(string,
    render: Vec<(string,
    // The slot every name that is nothing reads, handed out once.
    zero: Maybe(u32),
}

// The slot of `name` in `list`, the next free one on first sight.
named :: proc(list: ^Vec<(string) {
}
    // rust: if let Some((_, slot)) = list.iter().find(|(n, _)| n == name) {
    // rust: return *slot;
}
    // rust: let slot = *next;
    // rust: *next += 1;
    // rust: list.push((name.to_owned(), slot));
    // rust: slot
}

    // rust: impl Layout<'_, '_> {
slot :: proc(self: ^Self, name: string, this: string, part: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(i) = PARAMS.iter().position(|(n, _)| *n == name) {
    // rust: return Some(i as u32);
}
    // rust: let (model, var) = name.rsplit_once('.')?;
    // rust: Some(match model {
    // rust: "var" | "varb" => named(&mut self.vars, &mut self.next, name),
    // rust: "global_var" | "global_varb" => named(&mut self.globals, &mut self.next, name),
    // rust: "render" => named(&mut self.render, &mut self.next, name),
    // rust: _ => {
    // rust: let var = PART_VARS.iter().position(|v| *v == var)? as u32;
    // rust: let found = self.names.find(model, this, part)?;
    // rust: let known = self.parts.iter().find(|b| b.name == found).map(|b| b.base);
    // rust: let base = match known {
    // rust: Some(base) => base,
    // rust: None => {
    // rust: let base = self.next;
    // rust: self.next += PART_VARS.len() as u32;
    // rust: self.parts.push(Bound { name: found, base });
    // rust: base
}
}
    // rust: base + var
}
    // rust: })
}

    // The slot a name that is nothing reads: always zero, as EMF treats a variable it
    // doesn't know ("will treat the variable as zero") rather than losing the whole line.
zero :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: *self.zero.get_or_insert_with(|| {
    // rust: let slot = self.next;
    // rust: self.next += 1;
    // rust: slot
    // rust: })
}
}

// The most expressions one model's animations may have; the rest are left out.
MAX_EXPRESSIONS :: 4096

// Builds an animation from `entries`: each model entry's `this` and `part` names and its
// (target, expression) pairs, under the model's random-model `rules`. An expression that
// doesn't compile is left out, with a warning.
    // rust: pub(super) fn compile_animation(
    // rust: file: &str,
    // rust: names: &Names,
    // rust: entries: &[(String, String, &[(String, String)])],
    // rust: rules: &[super::cem::Rule],
    // rust: ) -> Option<Animation> {
    // rust: let mut layout = Layout {
    // rust: names,
    // rust: next: PARAMS.len() as u32,
    // rust: parts: Vec::new(),
    // rust: vars: Vec::new(),
    // rust: globals: Vec::new(),
    // rust: render: Vec::new(),
    // rust: zero: None,
}
    // rust: let mut steps = Vec::new();
    // rust: let mut count = 0;
    // rust: let mut unknown = std::collections::HashSet::new();
    // rust: 'entries: for (this, part, pairs) in entries {
    // rust: for (target, src) in pairs.iter() {
    // rust: count += 1;
    // rust: if count > MAX_EXPRESSIONS {
    // rust: log::warn!(
    // rust: "Horizon: custom entity model {file}: more than {MAX_EXPRESSIONS} animation \
    // rust: expressions, the rest are left out"
    // rust: );
    // rust: break 'entries;
}
    // rust: let Some(slot) = layout.slot(target, this, part) else {
    // rust: log::warn!("Horizon: custom entity model {file}: unknown target {target}");
    // rust: continue;
}
            // A name that is nothing reads 0, once named in a warning: the line keeps its
            // place, as EMF keeps it ("will treat the variable as zero").
    // rust: let compiled = compile(src, &mut |name: &str| {
    // rust: layout.slot(name, this, part).or_else(|| {
    // rust: if unknown.insert(name.to_owned()) {
    // rust: log::warn!(
    // rust: "Horizon: custom entity model {file}: unknown name {name} reads 0"
    // rust: );
}
    // rust: Some(layout.zero())
    // rust: })
    // rust: });
    // rust: match compiled {
    // rust: Ok(expr) => steps.push(Step { slot, expr }),
    // rust: Err(e) => log::warn!("Horizon: custom entity model {file}: {target}: {e}"),
}
}
}
    // rust: if steps.is_empty() {
    // rust: return None;
}
    // rust: Some(Animation {
    // rust: steps,
    // rust: slots: layout.next as usize,
    // rust: parts: layout.parts,
    // rust: rules: rules.to_vec(),
    // rust: vars: layout.vars.into_iter().map(|(_, slot)| slot).collect(),
    // rust: globals: layout
    // rust: .globals
    // rust: .into_iter()
    // rust: .map(|(name, slot)| (slot, global(&name)))
    // rust: .collect(),
    // rust: saved: Mutex::default(),
    // rust: })
}

    // rust: thread_local!(static SLOTS: RefCell<Vec<f32>> = const { RefCell::new(Vec::new()) });

// Past this many entities, an animation forgets those it hasn't drawn for `STALE` frames,
// and starts over at twice as many.
SAVED :: 4096
STALE :: 600

flag :: proc(b: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f32::from(b)
}

    // rust: impl Animation {
    // Runs the animation for `m` over `poses`, which the vanilla animation has set.
run :: proc(self: ^Self, m: ^Mob, s: ^State, poses: ^Poses) {
}
    // rust: self.run_in(&frame(), m, s, poses);
}

    // `run` in `frame`.
run_in :: proc(self: ^Self, frame: ^Frame, m: ^Mob, s: ^State, poses: ^Poses) {
}
        // The matching random-model rule's number: a grazing cow reads 2.
    // rust: let rule_index = super::cem::rule_index(&self.rules, m);
    // rust: self.run_with(
    // rust: m.id,
    // rust: frame.frame_counter,
    // rust: |slots| params(m, s, frame, rule_index, slots),
    // rust: poses,
    // rust: );
}

    // `run` for the entity `id` in the frame `counter`, whose parameters `fill` writes.
run_with :: proc(self: ^Self, id: u32, counter: u32, fill: impl FnOnce(^[f32]) {
}
    // rust: let preview = IN_GUI.get();
    // rust: SLOTS.with_borrow_mut(|slots| {
    // rust: slots.clear();
    // rust: slots.resize(self.slots, 0.0);
    // rust: fill(slots);
            // What vanilla left: the pose, `visible` and `skipDraw`.
    // rust: for b in &self.parts {
    // rust: let base = b.base as usize;
    // rust: slots[base..base + 9].copy_from_slice(poses.get(&b.name));
    // rust: slots[base + 9] = flag(!poses.is_hidden_named(&b.name));
    // rust: slots[base + 10] = flag(!poses.skips_named(&b.name));
}
    // rust: let mut saved = lock(&self.saved);
            // Each run of a frame starts from the variables the frame began with; only the
            // first one in the world keeps its result, so that drawing again (or in a
            // preview) changes nothing. A preview of an entity the world no longer draws
            // keeps its result too.
    // rust: let mut vars = None;
    // rust: if !self.vars.is_empty() || !self.globals.is_empty() {
    // rust: if saved.entities.len() >= SAVED && !saved.entities.contains_key(&id) {
    // rust: saved.make_room(counter);
}
    // rust: let globals = |into: &mut [f32]| {
    // rust: if !self.globals.is_empty() {
    // rust: let g = lock(&GLOBALS);
    // rust: for (value, &(_, i)) in into.iter_mut().zip(&self.globals) {
    // rust: *value = g.values[i as usize];
}
}
}
    // rust: let v = saved.entities.entry(id).or_insert_with(|| {
                    // Seen for the first time: its variables began this frame at 0.
    // rust: let zero: Box<[f32]> = vec![0.0; self.vars.len()].into_boxed_slice();
    // rust: let mut globals_start = vec![0.0; self.globals.len()].into_boxed_slice();
    // rust: globals(&mut globals_start);
    // rust: Vars {
    // rust: frame: counter,
    // rust: stored: false,
    // rust: world: None,
    // rust: start: zero.clone(),
    // rust: now: zero,
    // rust: globals_start,
}
    // rust: });
    // rust: if v.frame != counter {
    // rust: v.start.copy_from_slice(&v.now);
    // rust: globals(&mut v.globals_start);
    // rust: v.frame = counter;
    // rust: v.stored = false;
}
    // rust: for (&slot, value) in self.vars.iter().zip(v.start.iter()) {
    // rust: slots[slot as usize] = *value;
}
    // rust: for (&(slot, _), value) in self.globals.iter().zip(v.globals_start.iter()) {
    // rust: slots[slot as usize] = *value;
}
    // rust: vars = Some(v);
}
    // rust: for step in &self.steps {
    // rust: let v = step.expr.eval(slots);
                // A part keeps the pose vanilla gave it, a variable its last value.
    // rust: if v.is_finite() {
    // rust: slots[step.slot as usize] = v;
}
}
    // rust: if let Some(v) = vars
    // rust: && !v.stored
    // rust: && (!preview || v.world.is_none_or(|w| counter.wrapping_sub(w) > 1))
    // rust: {
    // rust: v.stored = true;
    // rust: if !preview {
    // rust: v.world = Some(counter);
}
    // rust: for (&slot, value) in self.vars.iter().zip(v.now.iter_mut()) {
    // rust: *value = slots[slot as usize];
}
    // rust: if !self.globals.is_empty() {
    // rust: let mut g = lock(&GLOBALS);
    // rust: for &(slot, i) in &self.globals {
    // rust: g.values[i as usize] = slots[slot as usize];
}
}
}
    // rust: drop(saved);
    // rust: for b in &self.parts {
    // rust: let base = b.base as usize;
                // The slots began as the pose: writing back what no step changed keeps it.
    // rust: poses.get(&b.name).copy_from_slice(&slots[base..base + 9]);
                // Only a change is written: naming a part keeps what vanilla hid.
    // rust: let visible = slots[base + 9] != 0.0;
    // rust: if visible == poses.is_hidden_named(&b.name) {
    // rust: poses.visible(&b.name, visible);
}
                // `visible_boxes = 0` skips the part's own boxes; 1 leaves vanilla's skipDraw.
    // rust: if slots[base + 10] == 0.0 && !poses.skips_named(&b.name) {
    // rust: poses.skip_draw(&b.name);
}
}
    // rust: });
}
}

    // rust: impl Saved {
    // Before a new entity joins a full table, forgets the entities not drawn for a while,
    // and everything if that is not enough.
make_room :: proc(self: ^Self, counter: u32) {
}
    // rust: if self.evicted != Some(counter) {
    // rust: self.evicted = Some(counter);
    // rust: self.entities
    // rust: .retain(|_, v| counter.wrapping_sub(v.frame) <= STALE);
}
    // rust: if self.entities.len() >= 2 * SAVED {
    // rust: self.entities.clear();
}
}
}

params :: proc(m: ^Mob, s: ^State, frame: ^Frame, rule_index: f32, slots: ^[f32]) {
}
    // rust: let max_health = super::finalize::max_health(m);
    // rust: let (dx, dy, dz) = (
    // rust: m.position.x - frame.player[0],
    // rust: m.position.y - frame.player[1],
    // rust: m.position.z - frame.player[2],
    // rust: );
    // The movement's direction against the head's: EMF's move_forward and move_strafing.
    // rust: let (forward, strafing) = {
    // rust: let (vx, vz) = (m.velocity.x as f32, m.velocity.z as f32);
    // rust: let len = (vx * vx + vz * vz).sqrt();
    // rust: if len < 1.0e-4 {
    // rust: (0.0, 0.0)
    // rust: } else {
    // rust: let yaw = m.head_yaw.to_radians();
    // rust: let (fx, fz) = (-yaw.sin(), yaw.cos());
    // rust: ((vx * fx + vz * fz) / len, (vx * -fz + vz * fx) / len)
}
}
    // `Entity.isVisuallySwimming` (`Pose.SWIMMING`, id 3): a player's or mannequin's pose comes
    // in `avatar_pose`, another mob's in `pose`. A drowned has no such pose, only the shared
    // swimming flag (`extra.flag`).
    // rust: let swim_pose = match &*m.kind.id {
    // rust: "minecraft:player" | "minecraft:mannequin" => {
    // rust: m.extra.avatar_pose == crate::pose::Pose::Swimming
}
    // rust: _ => m.extra.pose == 3 || (m.species() == super::Species::Drowned && m.extra.flag),
}
    // The arm the current swing moves: the main arm unless the swing named its hand.
    // rust: let swinging = m.ai.swinging || m.extra.swing_right_arm.is_some();
    // rust: let swing_right = m.extra.swing_right_arm.unwrap_or(!m.main_arm_left());
    // `HumanoidArm`'s items: the main hand is on the main arm.
    // rust: let (right_hand, left_hand) = if m.main_arm_left() {
    // rust: (&m.extra.off_hand, &m.extra.main_hand)
    // rust: } else {
    // rust: (&m.extra.main_hand, &m.extra.off_hand)
}
    // rust: for (i, (_, p)) in PARAMS.iter().enumerate() {
//         use Param::*;
    // rust: slots[i] = match p {
    // rust: LimbSwing => s.pos,
    // rust: LimbSpeed => s.speed,
    // rust: Age => s.age,
    // rust: HeadYaw => s.y_rot,
    // rust: HeadPitch => s.x_rot,
    // rust: SwingProgress => s.swing,
    // rust: Health => m.health,
    // rust: MaxHealth => max_health,
            // Whole ticks, as vanilla's `hurtTime` and `deathTime` are ints and EMF reads
            // them so: an expression comparing exact values stays exact.
    // rust: HurtTime => m.hurt_time.max(0) as f32,
    // rust: DeathTime => m.death_time.max(0) as f32,
    // rust: PosX => m.position.x as f32,
    // rust: PosY => m.position.y as f32,
    // rust: PosZ => m.position.z as f32,
    // rust: RotX => m.head_pitch,
    // rust: RotY => m.body_yaw,
    // rust: Id => m.id as f32,
            // OptiFine's `time` loops at 27720 ticks to keep float precision.
    // rust: Time => (frame.time % 27720.0) as f32,
    // rust: DayTime => (frame.day_time % 24000.0) as f32,
    // rust: DayCount => (frame.day_time / 24000.0).floor() as f32,
    // rust: FrameTime => frame.frame_time,
    // rust: FrameCounter => (frame.frame_counter % 27720) as f32,
    // rust: Dimension => frame.dimension,
    // rust: PlayerX => frame.player[0] as f32,
    // rust: PlayerY => frame.player[1] as f32,
    // rust: PlayerZ => frame.player[2] as f32,
    // rust: PlayerRotX => frame.player_rot[0],
    // rust: PlayerRotY => frame.player_rot[1],
            // The model's matching random-model rule (`optifine/cem/<name>.properties`),
            // whose number the animations read: a grazing cow reads 2.
    // rust: RuleIndex => rule_index,
            // A client knows only a wolf's anger end time (as a remaining time taken when it
            // was synced, which doesn't count down) and never the start: 0 for now.
    // rust: AngerTime | AngerTimeStart => 0.0,
    // rust: Distance => (dx * dx + dy * dy + dz * dz).sqrt() as f32,
    // rust: MoveForward => forward,
    // rust: MoveStrafing => strafing,
            // How deep the entity is in its fluid, which is what `fluid_depth_down` measures
            // once it touches the bottom.
    // rust: FluidDepth | FluidDepthDown => m.fluids.water.max(m.fluids.lava) as f32,
            // Both need the blocks around the mob (the ground below, the fluid's surface
            // above), which the draw doesn't have: 0 for now.
    // rust: HeightAboveGround | FluidDepthUp => 0.0,
            // The synced `Mob.isAggressive`, which a client's mobs have too.
    // rust: Aggressive => flag(m.ai.aggressive),
    // rust: Alive => flag(m.alive()),
    // rust: Burning => flag(m.fire_ticks > 0),
    // rust: Child => flag(s.baby),
    // rust: Glowing => flag(m.glowing),
    // rust: Hurt => flag(m.hurt_time > 0),
    // rust: InWater => flag(m.fluids.in_water),
    // rust: InLava => flag(m.fluids.in_lava),
            // `isInWaterOrRain` without the rain: whether rain reaches the mob needs the
            // weather and the sky above it, which the draw doesn't have.
    // rust: Wet => flag(m.fluids.in_water),
    // rust: Invisible => flag(m.invisible),
    // rust: OnGround => flag(m.on_ground),
    // rust: Riding => flag(m.extra.passenger),
            // `Entity.isVehicle`: SetPassengers names its first rider.
    // rust: Ridden => flag(m.extra.rider.is_some() || m.rider.is_some()),
    // rust: Climbing => flag(m.climbing),
    // rust: Jumping => flag(!m.on_ground && m.velocity.y > 0.0),
    // rust: Paused => flag(frame.paused),
    // rust: InGui => flag(IN_GUI.get()),
    // rust: FirstPerson => flag(frame.first_person),
    // rust: ThirdPerson => flag(!frame.first_person && !frame.third_person_reversed),
    // rust: ThirdPersonReversed => flag(frame.third_person_reversed),
    // rust: RightHanded => flag(!m.main_arm_left()),
            // The tamed animals' DATA_FLAGS_ID, and the species that keep their own.
    // rust: Sitting => flag(match m.species() {
    // rust: super::Species::Fox => super::fox::flag(m, super::fox::SITTING),
    // rust: super::Species::Panda => super::panda::is_sitting(m),
    // rust: super::Species::Camel | super::Species::CamelHusk => super::camel::sitting(m),
    // rust: _ => m.extra.sitting,
    // rust: }),
    // rust: Tamed => flag(m.extra.tame),
    // rust: Sprinting => flag(m.extra.sprinting),
    // rust: Sneaking => flag(m.extra.crouching),
            // A player's `isBlocking`: the item in use blocks attacks.
    // rust: Blocking => flag(m.extra.blocking),
            // `isVisuallyCrawling`: the swimming pose out of water.
    // rust: Crawling => flag(swim_pose && !m.fluids.in_water),
    // rust: Swimming => flag(swim_pose),
            // DATA_LIVING_ENTITY_FLAGS' using bit (the client counts the ticks).
    // rust: UsingItem => flag(m.extra.using_item > 0),
    // rust: SwingingRight => flag(swinging && swing_right),
    // rust: SwingingLeft => flag(swinging && !swing_right),
    // rust: HoldingRight => flag(right_hand.is_some()),
    // rust: HoldingLeft => flag(left_hand.is_some()),
            // Where the model is drawn (a held, framed or worn item, a shoulder): the draw
            // doesn't pass it yet, so 0 until something reads them.
    // rust: InHand | InItemFrame | InGround | OnHead | OnShoulder | FirstPersonHand | Hovered => {
    // rust: 0.0
}
}
}
}

    // rust: mod tests {
//     use super::*;

bone :: proc(name: string, children: [dynamic]Part) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Part {
    // rust: name: name.into(),
    // rust: pose: [1.0, 2.0, 3.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: Vec::new(),
    // rust: children,
}
}
pairs :: proc(list: ^[(string) {
}
    // rust: list.iter()
    // rust: .map(|(a, b)| (a.to_string(), b.to_string()))
    // rust: .collect()
}
LIMB_SWING :: Param::LimbSwing 

animations_override_poses_and_keep_variables_per_entity :: proc() {
}
        // A head (OptiFine's name for it maps to `real_head`) holding a custom bone `brim`.
    // rust: let model = bone(
    // rust: "root",
    // rust: vec![bone(
    // rust: "real_head",
    // rust: vec![bone("cem#0", vec![bone("cem#1", vec![])])],
    // rust: )],
    // rust: );
    // rust: let ids: HashMap<String, String> = [
    // rust: ("cem#0".into(), "hat".into()),
    // rust: ("cem#1".into(), "brim".into()),
    // rust: ]
    // rust: .into();
    // rust: let vanilla = |p: &str| {
    // rust: if p == "head" {
    // rust: "real_head".into()
    // rust: } else {
    // rust: p.to_owned()
}
}
    // rust: let names = Names {
    // rust: model: &model,
    // rust: vanilla: &vanilla,
    // rust: ids: &ids,
}
    // rust: let head = pairs(&[
    // rust: ("var.steps", "var.steps + 1"),
            // Reads the vanilla pose (ty 2) before it changes.
    // rust: ("head.ty", "part.ty * 10"),
    // rust: ("head.rx", "sin(limb_swing) * 0.5"),
    // rust: ("hat:brim.tz", "var.steps"),
    // rust: ("brim.visible", "var.steps < 2"),
    // rust: ("this.sx", "nope + 1"),
    // rust: ]);
    // rust: let hat = pairs(&[("this.ry", "torad(90)"), ("render.shadow_size", "0.5")]);
    // rust: let entries = [
    // rust: (
    // rust: "real_head".to_owned(),
    // rust: "real_head".to_owned(),
    // rust: head.as_slice(),
    // rust: ),
    // rust: ("cem#0".to_owned(), "real_head".to_owned(), hat.as_slice()),
    // rust: ];
    // rust: let animation = compile_animation("test.jem", &names, &entries, &[]).unwrap();
    // rust: let frame = |id: u32, counter: u32, poses: &mut Poses| {
    // rust: animation.run_with(
    // rust: id,
    // rust: counter,
    // rust: |s| s[LIMB_SWING] = std::f32::consts::FRAC_PI_2,
    // rust: poses,
    // rust: );
}
    // rust: let mut poses = Poses::new(&model);
    // rust: frame(7, 1, &mut poses);
    // rust: assert_eq!(poses.get("real_head")[..4], [1.0, 20.0, 3.0, 0.5]);
    // rust: assert_eq!(poses.get("cem#1")[2], 1.0);
    // rust: assert!((poses.get("cem#0")[4] - std::f32::consts::FRAC_PI_2).abs() < 1e-6);
        // The expression with an unknown name reads 0: nope + 1 sets the scale to 1.
    // rust: assert_eq!(poses.get("real_head")[6], 1.0);
    // rust: assert!(!poses.is_hidden(&bone("cem#1", vec![])));
        // The next frame starts from the vanilla pose again, with this entity's counter.
    // rust: let mut poses = Poses::new(&model);
    // rust: frame(7, 2, &mut poses);
    // rust: assert_eq!(poses.get("cem#1")[2], 2.0);
    // rust: assert!(poses.is_hidden(&bone("cem#1", vec![])));
        // Another entity counts on its own.
    // rust: let mut poses = Poses::new(&model);
    // rust: frame(8, 2, &mut poses);
    // rust: assert_eq!(poses.get("cem#1")[2], 1.0);
}

nothing_to_run_without_valid_expressions :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let ids = HashMap::new();
    // rust: let names = Names {
    // rust: model: &model,
    // rust: vanilla: &|p| p.to_owned(),
    // rust: ids: &ids,
}
    // rust: let bad = pairs(&[("missing.rx", "1"), ("root.rx", "1 +")]);
    // rust: let entries = [("root".to_owned(), "root".to_owned(), bad.as_slice())];
    // rust: assert!(compile_animation("test.jem", &names, &entries, &[]).is_none());
}

the_matching_random_model_rule_reaches_rule_index :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let ids = HashMap::new();
    // rust: let names = Names {
    // rust: model: &model,
    // rust: vanilla: &|p| p.to_owned(),
    // rust: ids: &ids,
}
    // rust: let list = pairs(&[("root.tx", "rule_index")]);
    // rust: let entries = [("root".to_owned(), "root".to_owned(), list.as_slice())];
        // Fresh Animations' cow: rule 2 grazes on grass, wheat or hay.
    // rust: let rules =
    // rust: super::super::cem::parse_rules("models.2=1\nblocks.2=grass_block wheat hay_block");
    // rust: let animation = compile_animation("test.jem", &names, &entries, &rules).unwrap();
    // rust: let mut m = mob();
    // rust: m.standing_on = Some("minecraft:grass_block".into());
    // rust: let mut poses = Poses::new(&model);
    // rust: animation.run_in(&Frame::default(), &m, &still(), &mut poses);
    // rust: assert_eq!(poses.get("root")[0], 2.0);
        // Off the grass: the unconditional base 0.
    // rust: m.standing_on = Some("minecraft:stone".into());
    // rust: let mut poses = Poses::new(&model);
    // rust: animation.run_in(&Frame::default(), &m, &still(), &mut poses);
    // rust: assert_eq!(poses.get("root")[0], 0.0);
}

    // The animation `list` over a model whose parts keep their own names.
animate :: proc(model: ^Part, list: ^[(string) {
}
    // rust: let ids = HashMap::new();
    // rust: let names = Names {
    // rust: model,
    // rust: vanilla: &|p| p.to_owned(),
    // rust: ids: &ids,
}
    // rust: let list = pairs(list);
    // rust: let entries = [("root".to_owned(), "root".to_owned(), list.as_slice())];
    // rust: compile_animation("test.jem", &names, &entries, &[]).unwrap()
}

naming_a_part_keeps_what_vanilla_hid :: proc() {
}
    // rust: let model = bone("root", vec![bone("head", vec![])]);
    // rust: let hidden = || {
    // rust: let mut poses = Poses::new(&model);
    // rust: poses.visible("head", false);
    // rust: poses.skip_draw("head");
    // rust: poses
}
        // Only the rotation changes: the part stays hidden and its boxes skipped.
    // rust: let mut poses = hidden();
    // rust: animate(&model, &[("head.rx", "1")]).run_with(1, 1, |_| {}, &mut poses);
    // rust: assert_eq!(poses.get("head")[3], 1.0);
    // rust: assert!(poses.is_hidden_named("head") && poses.skips_named("head"));
        // An animation that reads the flags sees vanilla's: hidden and skipped are 0.
    // rust: let mut poses = hidden();
    // rust: animate(
    // rust: &model,
    // rust: &[("head.tx", "head.visible + head.visible_boxes * 2")],
    // rust: )
    // rust: .run_with(1, 1, |_| {}, &mut poses);
    // rust: assert_eq!(poses.get("head")[0], 0.0);
        // visible 1 shows the part; visible_boxes 1 leaves vanilla's skipDraw.
    // rust: let mut poses = hidden();
    // rust: animate(
    // rust: &model,
    // rust: &[("head.visible", "1"), ("head.visible_boxes", "1")],
    // rust: )
    // rust: .run_with(1, 1, |_| {}, &mut poses);
    // rust: assert!(!poses.is_hidden_named("head") && poses.skips_named("head"));
        // visible_boxes 0 skips the part's own boxes and leaves it visible.
    // rust: let mut poses = Poses::new(&model);
    // rust: animate(&model, &[("head.visible_boxes", "0")]).run_with(1, 1, |_| {}, &mut poses);
    // rust: assert!(poses.skips_named("head") && !poses.is_hidden_named("head"));
        // visible 0 hides a part vanilla showed.
    // rust: let mut poses = Poses::new(&model);
    // rust: animate(&model, &[("head.visible", "0")]).run_with(1, 1, |_| {}, &mut poses);
    // rust: assert!(poses.is_hidden_named("head") && !poses.skips_named("head"));
}

a_value_that_is_not_finite_keeps_the_vanilla_pose_and_the_variable :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let mut poses = Poses::new(&model);
    // rust: animate(
    // rust: &model,
    // rust: &[
    // rust: ("root.tx", "sqrt(-1)"),
    // rust: ("root.ty", "5"),
    // rust: ("root.rx", "1 / 0"),
    // rust: ("var.k", "7"),
    // rust: ("var.k", "0 / 0"),
    // rust: ("var.k", "1 / 0"),
    // rust: ("root.tz", "var.k"),
    // rust: ],
    // rust: )
    // rust: .run_with(1, 1, |_| {}, &mut poses);
    // rust: assert_eq!(poses.get("root")[..4], [1.0, 5.0, 7.0, 0.0]);
}

the_parameters_come_from_the_mob_and_its_state :: proc() {
}
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: crate::mobs::sensor_scan_tests::kind(),
    // rust: horizon_core::geometry::Vec3::new(3.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: m.hurt_time = 5;
    // rust: m.fire_ticks = 3;
    // rust: m.on_ground = false;
    // rust: m.velocity = horizon_core::geometry::Vec3::new(0.0, 0.1, 0.0);
    // rust: let s = State {
    // rust: pos: 1.5,
    // rust: speed: 0.0,
    // rust: age: 0.0,
    // rust: y_rot: 30.0,
    // rust: x_rot: 0.0,
    // rust: swing: 0.0,
    // rust: baby: true,
    // rust: partial: 0.25,
}
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(
    // rust: &model,
    // rust: &[
    // rust: ("root.tx", "hurt_time"),
    // rust: ("root.ty", "limb_swing"),
    // rust: ("root.tz", "head_yaw"),
    // rust: ("root.rx", "is_burning + is_jumping * 2 + is_child * 4"),
    // rust: ("root.ry", "distance"),
    // rust: (
    // rust: "root.rz",
    // rust: "is_player_third_person + is_player_first_person * 2",
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let frame = Frame {
    // rust: player: [0.0, 0.0, 0.0],
    // rust: ..Frame::default()
}
    // rust: let mut poses = Poses::new(&model);
    // rust: animation.run_in(&frame, &m, &s, &mut poses);
        // `hurt_time` reads the whole 5 ticks, not the partial-tick 4.75: vanilla's
        // `hurtTime` is an int and EMF reads it so.
    // rust: assert_eq!(poses.get("root")[..6], [5.0, 1.5, 30.0, 7.0, 5.0, 2.0]);
}

    // A mob at the origin of the test species.
mob :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: Mob::new(
    // rust: 1,
    // rust: crate::mobs::sensor_scan_tests::kind(),
    // rust: horizon_core::geometry::Vec3::ZERO,
    // rust: 0.0,
    // rust: )
}

    // A state with every value at rest.
still :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: State {
    // rust: pos: 0.0,
    // rust: speed: 0.0,
    // rust: age: 0.0,
    // rust: y_rot: 0.0,
    // rust: x_rot: 0.0,
    // rust: swing: 0.0,
    // rust: baby: false,
    // rust: partial: 0.0,
}
}

the_flags_come_from_the_synced_mob_fields :: proc() {
}
    // rust: let mut m = mob();
    // rust: m.ai.aggressive = true;
    // rust: m.extra.sitting = true;
    // rust: m.extra.tame = true;
    // rust: m.extra.sprinting = true;
    // rust: m.extra.crouching = true;
        // The player's main hand option set to left.
    // rust: m.extra.main_hand_left = true;
    // rust: m.extra.blocking = true;
        // The swimming pose out of water: crawling.
    // rust: m.extra.pose = 3;
    // rust: m.extra.using_item = 3;
        // Only the main hand holds something, and it is the left one.
    // rust: m.extra.set_main_hand(Some("minecraft:stick".into()));
        // A swing that names no hand moves the main arm: the left.
    // rust: m.ai.swinging = true;
    // rust: m.extra.rider = Some(7);
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(
    // rust: &model,
    // rust: &[(
    // rust: "root.tx",
    // rust: "is_aggressive + is_sitting * 2 + is_tamed * 4 + is_sprinting * 8 \
    // rust: + is_sneaking * 16 + is_right_handed * 32 + is_blocking * 64 \
    // rust: + is_crawling * 128 + is_swimming * 256 + is_using_item * 512 \
    // rust: + is_holding_item_right * 1024 + is_holding_item_left * 2048 \
    // rust: + is_swinging_right_arm * 4096 + is_swinging_left_arm * 8192 \
    // rust: + is_ridden * 16384",
    // rust: )],
    // rust: );
    // rust: let mut poses = Poses::new(&model);
    // rust: animation.run_in(&Frame::default(), &m, &still(), &mut poses);
    // rust: assert_eq!(
    // rust: poses.get("root")[0],
    // rust: (31 + 64 + 128 + 256 + 512 + 2048 + 8192 + 16384) as f32
    // rust: );
}

the_swimming_pose_in_water_swims_without_crawling :: proc() {
}
    // rust: let mut m = mob();
    // rust: m.extra.pose = 3;
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(&model, &[("root.tx", "is_swimming + is_crawling * 2")]);
    // rust: let mut read = |in_water: bool| {
    // rust: m.fluids.in_water = in_water;
    // rust: let mut poses = Poses::new(&model);
    // rust: animation.run_in(&Frame::default(), &m, &still(), &mut poses);
    // rust: poses.get("root")[0]
}
    // rust: assert_eq!([read(true), read(false)], [1.0, 3.0]);
}

a_fox_sits_by_its_own_flags :: proc() {
}
    // rust: let mut m = mob();
    // rust: m.kind = std::sync::Arc::new(crate::mobs::MobType {
    // rust: species: crate::mobs::Species::Fox,
    // rust: ..(*m.kind).clone()
    // rust: });
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(&model, &[("root.tx", "is_sitting")]);
    // rust: let mut sitting = |flags: i32| {
    // rust: m.extra.ints[0] = flags;
    // rust: let mut poses = Poses::new(&model);
    // rust: animation.run_in(&Frame::default(), &m, &still(), &mut poses);
    // rust: poses.get("root")[0]
}
    // rust: assert_eq!(sitting(crate::mobs::fox::SITTING), 1.0);
    // rust: assert_eq!(sitting(crate::mobs::fox::CROUCHING), 0.0);
}

expressions_past_the_cap_are_left_out :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let list = vec![("root.tx", "1"); MAX_EXPRESSIONS + 1];
    // rust: assert_eq!(animate(&model, &list).steps.len(), MAX_EXPRESSIONS);
}

a_preview_leaves_the_world_entity_variables_alone :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(
    // rust: &model,
    // rust: &[
    // rust: ("var.n", "var.n + 1 + is_in_gui * 100"),
    // rust: ("root.tx", "var.n"),
    // rust: ],
    // rust: );
    // rust: let (m, s) = (mob(), still());
    // rust: let tx = |counter: u32| {
    // rust: let frame = Frame {
    // rust: frame_counter: counter,
    // rust: ..Frame::default()
}
    // rust: let mut poses = Poses::new(&model);
    // rust: animation.run_in(&frame, &m, &s, &mut poses);
    // rust: poses.get("root")[0]
}
        // A preview in a frame the world drew, then one in a frame it didn't: each starts from
        // where its frame began (0, then the world's last 2) and stores nothing itself.
    // rust: assert_eq!(
    // rust: [tx(1), in_gui(|| tx(1)), tx(2), in_gui(|| tx(3)), tx(4)],
    // rust: [1.0, 101.0, 2.0, 103.0, 3.0]
    // rust: );
}

drawing_again_in_the_same_frame_does_not_advance_variables :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(&model, &[("var.n", "var.n + 1"), ("root.tx", "var.n")]);
    // rust: let mut poses = Poses::new(&model);
    // rust: let mut tx = |counter: u32| {
    // rust: animation.run_with(1, counter, |_| {}, &mut poses);
    // rust: poses.get("root")[0]
}
    // rust: assert_eq!(
    // rust: [tx(10), tx(10), tx(11), tx(11), tx(12)],
    // rust: [1.0, 1.0, 2.0, 2.0, 3.0]
    // rust: );
}

global_variables_are_shared_by_every_entity :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(
    // rust: &model,
    // rust: &[
    // rust: (
    // rust: "global_var.cem_anim_test_shared",
    // rust: "global_var.cem_anim_test_shared + 1",
    // rust: ),
    // rust: ("root.tx", "global_var.cem_anim_test_shared"),
    // rust: ],
    // rust: );
    // rust: let mut poses = Poses::new(&model);
    // rust: animation.run_with(1, 1, |_| {}, &mut poses);
    // rust: assert_eq!(poses.get("root")[0], 1.0);
    // rust: animation.run_with(2, 1, |_| {}, &mut poses);
    // rust: assert_eq!(poses.get("root")[0], 2.0);
        // Another model reading the same name sees the same value.
    // rust: let reader = animate(&model, &[("root.ty", "global_var.cem_anim_test_shared")]);
    // rust: reader.run_with(3, 1, |_| {}, &mut poses);
    // rust: assert_eq!(poses.get("root")[1], 2.0);
}

a_full_table_forgets_only_entities_not_seen_for_a_while :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(&model, &[("var.n", "var.n + 1"), ("root.tx", "var.n")]);
    // rust: let mut poses = Poses::new(&model);
    // rust: let mut tx = |id: u32, counter: u32| {
    // rust: animation.run_with(id, counter, |_| {}, &mut poses);
    // rust: poses.get("root")[0]
}
    // rust: for id in 0..SAVED as u32 {
    // rust: tx(id, 1);
}
        // Entity 0 comes back 699 frames later; a new one then fills the table.
    // rust: assert_eq!(tx(0, 700), 2.0);
    // rust: assert_eq!(tx(100_000, 701), 1.0);
        // Entity 0 was seen recently and keeps counting; entity 1 was forgotten.
    // rust: assert_eq!(tx(0, 702), 3.0);
    // rust: assert_eq!(tx(1, 702), 1.0);
}

drawing_an_entity_again_reads_and_stores_the_globals_once :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(
    // rust: &model,
    // rust: &[
    // rust: (
    // rust: "global_var.cem_anim_test_redraw",
    // rust: "global_var.cem_anim_test_redraw + 1 + is_in_gui * 100",
    // rust: ),
    // rust: ("root.tx", "global_var.cem_anim_test_redraw"),
    // rust: ],
    // rust: );
    // rust: let mut poses = Poses::new(&model);
    // rust: let mut tx = |counter: u32| {
            // Only `is_in_gui` matters here: the rest of the parameters stay 0.
    // rust: let fill = |slots: &mut [f32]| slots[Param::InGui as usize] = flag(IN_GUI.get());
    // rust: animation.run_with(7, counter, fill, &mut poses);
    // rust: poses.get("root")[0]
}
        // Two draws in the world and a preview in frame 1 read the same start; only the first
        // stores, so frame 2 counts on from 1, not from the preview's 101.
    // rust: assert_eq!(
    // rust: [tx(1), tx(1), in_gui(|| tx(1)), tx(2)],
    // rust: [1.0, 1.0, 101.0, 2.0]
    // rust: );
}

an_entity_only_a_preview_draws_still_counts :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(&model, &[("var.n", "var.n + 1"), ("root.tx", "var.n")]);
    // rust: let mut poses = Poses::new(&model);
    // rust: let mut tx = |counter: u32| {
    // rust: animation.run_with(5, counter, |_| {}, &mut poses);
    // rust: poses.get("root")[0]
}
        // The inventory's own player in first person: the world never draws it.
    // rust: assert_eq!(
    // rust: [in_gui(|| tx(1)), in_gui(|| tx(2)), in_gui(|| tx(3))],
    // rust: [1.0, 2.0, 3.0]
    // rust: );
}

a_table_of_recent_entities_starts_over_at_twice_its_size :: proc() {
}
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(&model, &[("var.n", "var.n + 1"), ("root.tx", "var.n")]);
    // rust: let mut poses = Poses::new(&model);
    // rust: let mut tx = |id: u32, counter: u32| {
    // rust: animation.run_with(id, counter, |_| {}, &mut poses);
    // rust: poses.get("root")[0]
}
        // Every entity is recent, so none can be forgotten until the table is twice full.
    // rust: for id in 0..2 * SAVED as u32 {
    // rust: tx(id, 1);
}
    // rust: assert_eq!(tx(0, 2), 2.0);
    // rust: tx(1_000_000, 2);
    // rust: assert_eq!(tx(0, 3), 1.0);
}

    // Held by the tests that change `FRAME`.
FRAME_TEST :: Mutex::new(())

a_preview_runs_in_the_gui_and_the_world_frame_comes_back :: proc() {
}
    // rust: let _lock = lock(&FRAME_TEST);
    // rust: set_frame(Frame {
    // rust: time: 77.0,
    // rust: ..Frame::default()
    // rust: });
    // rust: let (m, s) = (mob(), still());
    // rust: let model = bone("root", vec![]);
    // rust: let animation = animate(&model, &[("root.tx", "is_in_gui"), ("root.ty", "time")]);
    // rust: let run = || {
    // rust: let mut poses = Poses::new(&model);
    // rust: animation.run(&m, &s, &mut poses);
    // rust: let p = *poses.get("root");
    // rust: [p[0], p[1]]
}
    // rust: assert_eq!(run(), [0.0, 77.0]);
    // rust: assert_eq!(in_gui(run), [1.0, 77.0]);
    // rust: assert_eq!(run(), [0.0, 77.0]);
}

each_frame_counts_one_more :: proc() {
}
    // rust: let _lock = lock(&FRAME_TEST);
    // rust: let counter = || frame().frame_counter;
    // rust: let a = counter();
    // rust: set_frame(Frame::default());
    // rust: let b = counter();
    // rust: set_frame(Frame::default());
    // rust: let c = counter();
    // rust: assert_eq!([b.wrapping_sub(a), c.wrapping_sub(b)], [1, 1]);
}
}
