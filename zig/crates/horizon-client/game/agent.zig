//! Transpiled from Horizon Rust crate
//! Module: horizon-client_agent
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Control-socket commands for agents and scripts that play the game: read
//! the world, the player, the inventory and the open screen as JSON, and act
//! like a player (walk, look, break, place, use, click buttons). Actions that
//! take time run as a task advanced every frame and reply when they finish or
//! time out, so `horizon-ctl break 10 64 3` returns what the block dropped.
    // rust: mod navigation;

// use super::event_loop::EventLoopCtl;
// use super::{Game, Screen};
// use horizon_client::actions::Action;
// use horizon_client::held::Source;
// use horizon_client::{
    // rust: Result,
    // rust: block_entity_anim::Ticker,
    // rust: items::ItemStack,
    // rust: mobs::{
    // rust: Species,
    // rust: render::{PROFESSIONS, VILLAGER_TYPES},
    // rust: },
    // rust: widgets,
}
// use horizon_core::geometry::Vec3;
// use horizon_world::registry::BlockStateId;
// use navigation::{Cell, Node, Plan, Progress};
// use serde_json::{Value, json};
// use std::{
    // rust: collections::{BTreeMap, HashMap, HashSet},
    // rust: sync::mpsc::Sender,
    // rust: time::{Duration, Instant},
}
// use winit::{
    // rust: dpi::PhysicalPosition,
    // rust: event::{DeviceId, ElementState, MouseButton, MouseScrollDelta, TouchPhase, WindowEvent},
    // rust: keyboard::KeyCode,
}

    // rust: pub(super) const HELP: &[&str] = &[
    // rust: "state                          player, world, screen and crosshair target in one reply",
    // rust: "looking-at                     the block or entity under the crosshair (distance, face)",
    // rust: "entities [RADIUS] [TYPE]       mobs, dropped items and orbs near the player, nearest first",
    // rust: "block X Y Z                    the block state at a position",
    // rust: "blocks X1 Y1 Z1 X2 Y2 Z2       the non-air blocks of a box (at most 32768 blocks)",
    // rust: "light X1 Y1 Z1 X2 Y2 Z2        the stored sky and block light of a box (at most 32768 blocks)",
    // rust: "find-block BLOCK [RADIUS]      the nearest loaded blocks of a kind (default radius 32)",
    // rust: "inventory                      hotbar, main inventory, armor, offhand and carried stack",
    // rust: "screen                         the open screen or menu, its slots and its buttons",
    // rust: "messages [N]                   recent chat and system messages, title and action bar",
    // rust: "move DIR SECONDS [--sprint] [--sneak] [--jump]  walk forward|back|left|right",
    // rust: "jump                           jump once",
    // rust: "goto X Y Z [--near R] [--sprint] [--direct] [--timeout S]  walk to a position along a path",
    // rust: "look-at X Y Z | look-at block X Y Z [FACE] | look-at entity ID  [--over S]",
    // rust: "turn DYAW DPITCH --over S      rotate the view with mouse motion spread over S seconds",
    // rust: "mouse-move DX DY               relative mouse motion, turned like a player's mouse",
    // rust: "attack [ID]                    swing at the target (after looking at entity ID)",
    // rust: "break X Y Z [--timeout S]      mine a block until it breaks; reports drops and pickups",
    // rust: "place X Y Z [--item ITEM]      place the held (or given) item at a position",
    // rust: "interact X Y Z [FACE]          right-click a block (open a door, chest, crafting table...)",
    // rust: "use-item [--hold S]            right-click with the held item (eat, drink, throw, draw a bow)",
    // rust: "select SLOT|ITEM               select a hotbar slot (1-9) or the hotbar slot holding ITEM",
    // rust: "drop [all]                     drop one of the held item (all: the stack)",
    // rust: "open-inventory                 open the inventory screen",
    // rust: "click-button LABEL             click a button of the open screen or menu by its label",
    // rust: "click-at X Y [right]           click at GUI pixel X Y of the window",
    // rust: "drag-at [right] X Y X Y...     press at the first GUI point, move through the others, release",
    // rust: "scroll-at X Y STEPS            turn the wheel at GUI pixel X Y (positive scrolls up)",
    // rust: "command TEXT                   run a /command",
    // rust: "pause                          open the pause menu",
    // rust: "wait TICKS                     wait for game ticks to pass (held keys stay held)",
    // rust: "stop                           cancel the running action and release every key",
    // rust: ];

/// Keys the agent holds for a task (the game's movement reads these).
    // rust: const MOVE_KEYS: [KeyCode; 7] = [
    // rust: KeyCode::KeyW,
    // rust: KeyCode::KeyS,
    // rust: KeyCode::KeyA,
    // rust: KeyCode::KeyD,
    // rust: KeyCode::Space,
    // rust: KeyCode::ShiftLeft,
    // rust: KeyCode::ControlLeft,
    // rust: ];

/// Words of a command line: positional values and `--flag [value]` options.
    // rust: pub(super) struct Args<'a> {
    // rust: pub pos: Vec<&'a str>,
    // rust: pub flags: HashMap<&'a str, Option<&'a str>>,
}
/// Options that take a value (`--timeout 10` or `--timeout=10`).
pub const VALUE_FLAGS: *[[]const u8] = &["timeout", "near", "item", "radius", "hold", "face", "over"];

    // rust: pub(super) fn parse_args<'a>(words: &[&'a str]) -> Args<'a> {
    // rust: let mut args = Args::default();
    // rust: let mut i = 0;
    // rust: while i < words.len() {
    // rust: let w = words[i];
    // rust: if let Some(flag) = w.strip_prefix("--") {
    // rust: if let Some((k, v)) = flag.split_once('=') {
    // rust: args.flags.insert(k, Some(v));
    // rust: } else if VALUE_FLAGS.contains(&flag) && i + 1 < words.len() {
    // rust: args.flags.insert(flag, Some(words[i + 1]));
    // rust: i += 1;
    // rust: } else {
    // rust: args.flags.insert(flag, None);
}
    // rust: } else {
    // rust: args.pos.push(w);
}
    // rust: i += 1;
}
    // rust: args
}
    // rust: impl Args<'_> {
pub fn has(self: *Self, flag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.flags.contains_key(flag)
}
pub fn num(self: *Self, flag: []const u8, default: f64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.flags.get(flag) {
    // rust: Some(Some(v)) => Ok(v.parse()?),
    // rust: Some(None) => Err(format!("--{flag} needs a value").into()),
    // rust: None => Ok(default),
}
}
pub fn get(self: *Self, i: usize, what: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pos
    // rust: .get(i)
    // rust: .copied()
    // rust: .ok_or_else(|| format!("missing {what}").into())
}
pub fn f64(self: *Self, i: usize, what: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = self.get(i, what)?;
    // rust: v.parse()
    // rust: .map_err(|_| format!("{what} must be a number, not {v}").into())
}
pub fn i32(self: *Self, i: usize, what: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = self.get(i, what)?;
    // rust: v.parse()
    // rust: .map_err(|_| format!("{what} must be an integer, not {v}").into())
}
pub fn block_pos(self: *Self, from: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok([
    // rust: self.i32(from, "X")?,
    // rust: self.i32(from + 1, "Y")?,
    // rust: self.i32(from + 2, "Z")?,
    // rust: ])
}
}

pub fn namespaced(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
}

    // rust: const FACES: [(&str, [i32; 3]); 6] = [
    // rust: ("down", [0, -1, 0]),
    // rust: ("up", [0, 1, 0]),
    // rust: ("north", [0, 0, -1]),
    // rust: ("south", [0, 0, 1]),
    // rust: ("west", [-1, 0, 0]),
    // rust: ("east", [1, 0, 0]),
    // rust: ];
pub fn face_name(face: [i32; 3]) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FACES
    // rust: .iter()
    // rust: .find(|(_, d)| *d == face)
    // rust: .map_or("?", |(n, _)| n)
}
pub fn face_dir(name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FACES
    // rust: .iter()
    // rust: .find(|(n, _)| *n == name)
    // rust: .map(|(_, d)| *d)
    // rust: .ok_or_else(|| format!("unknown face {name} (down up north south west east)").into())
}
pub fn add(a: [i32; 3], b: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [a[0] + b[0], a[1] + b[1], a[2] + b[2]]
}
pub fn dist(a: [f64; 3], b: [f64; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((a[0] - b[0]).powi(2) + (a[1] - b[1]).powi(2) + (a[2] - b[2]).powi(2)).sqrt()
}
/// Minecraft's yaw and pitch facing from `eye` towards `at` (yaw 0 faces +Z,
/// 90 faces -X; positive pitch looks down).
    // rust: pub(super) fn yaw_pitch(eye: [f64; 3], at: [f64; 3]) -> (f32, f32) {
    // rust: let d = [at[0] - eye[0], at[1] - eye[1], at[2] - eye[2]];
    // rust: let horizontal = (d[0] * d[0] + d[2] * d[2]).sqrt();
    // rust: (
    // rust: (-d[0]).atan2(d[2]).to_degrees() as f32,
    // rust: (-d[1]).atan2(horizontal).to_degrees() as f32,
    // rust: )
}

pub fn counts(items: impl Iterator<Item = ItemStack>) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut map = BTreeMap::new();
    // rust: for s in items {
    // rust: *map.entry(s.item.to_string()).or_insert(0) += i64::from(s.count);
}
    // rust: map
}
/// Item counts that changed between two inventories (positive: gained).
pub fn delta(before: *BTreeMap<[]const u8, after: *BTreeMap<[]const u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = BTreeMap::new();
    // rust: for key in before.keys().chain(after.keys()) {
    // rust: let d = after.get(key).copied().unwrap_or(0) - before.get(key).copied().unwrap_or(0);
    // rust: if d != 0 {
    // rust: out.insert(key.clone(), d);
}
}
    // rust: out
}

pub const TaskKind = enum {
    /// Hold keys until a deadline.
    Move {,
    keys: Vec<KeyCode>,
    until: Instant,
    from: Vec3,
    // rust: },
    Wait {,
    until_tick: u64,
    // rust: },
    Jump {,
    release_tick: u64,
    from_y: f64,
    // rust: },
    Goto(Box<Goto>),
    Break(Box<Break>),
    /// A right click on a block or a placement: report after a few ticks.
    Click {,
    pos: Option<[i32; 3]>,
    before: Option<BlockStateId>,
    inventory: BTreeMap<String, i64>,
    report_tick: u64,
    release: Option<Instant>,
    place: bool,
    // rust: },
    Attack {,
    id: Option<u32>,
    health: Option<f32>,
    report_tick: u64,
    // rust: },
};
    // rust: impl TaskKind {
    /// Whether the keys and buttons are released when the task ends. A wait
    /// holds nothing, so what `key w down` pressed stays down through it.
pub fn releases_input(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !matches!(self, TaskKind::Wait { .. })
}
}
pub const Goto = struct {
    target: [f64,
    near: f64,
    sprint: bool,
    path: Plan,
    blocked: Vec<(Node,
    progress: Progress,
    next: usize,
    /// Tick of the last waypoint progress, and stuck recoveries so far.
    progress_tick: u64,
    replans: u32,
    jump_until: u64,
    warning: ?[]const u8,
};
pub const Break = struct {
    pos: [i32,
    before: BlockStateId,
    items_before: std.AutoHashMap(u32, void),
    inventory: BTreeMap<[]const u8,
    started_tick: u64,
    /// Set once the block changed: collect drops until this tick.
    collect_until: ?u64,
    broke_tick: u64,
    drops: BTreeMap<u32,
};
pub const Task = struct {
    kind: TaskKind,
    reply: Sender<[]const u8>,
    deadline: Instant,
    name: *'static str,
};

/// Mouse motion an agent feeds over frames (`mouse-move`, `turn --over`,
/// `look-at --over`): eased, through `MouseHandler`'s accumulated movement.
pub const Glide = struct {
    /// The whole motion, in mouse units, and how much has been fed.
    total: (f64,
    fed: (f64,
    started: Instant,
    over: Duration,
    /// The frame count when motion was last fed: the reply waits for the
    /// frame that turns the view with it.
    fed_frame: u64,
    deadline: Instant,
    reply: Sender<[]const u8>,
    /// What `look-at` aimed at, reported once the turn is done.
    aim: ?*'static str,
};

    // rust: pub(super) struct Agent {
    // rust: task: Option<Task>,
    // rust: glide: Option<Glide>,
    /// Control-fixture barrier: hold simulation and packet handling, not transport threads.
    // rust: pub hold_server: bool,
}

    // rust: pub(super) enum Handled {
    // rust: Reply(Value),
    /// The reply comes later, from the task.
    // rust: Deferred,
    /// Not an agent command.
    // rust: No,
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn state_string(&self, state: BlockStateId) -> String {
    // rust: let Some(s) = self.pack.assets.registry.state(state) else {
    // rust: return "?".into();
}
    // rust: if s.properties.is_empty() {
    // rust: return s.name.clone();
}
    // rust: let props: Vec<String> = s
    // rust: .properties
    // rust: .iter()
    // rust: .map(|(k, v)| format!("{k}={v}"))
    // rust: .collect();
    // rust: format!("{}[{}]", s.name, props.join(","))
}
pub fn block_json(self: *Self, pos: [i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let mut v = json!({
    // rust: "pos": pos,
    // rust: "block": &*self.res.facts().get(state).name,
    // rust: "state": self.state_string(state),
    // rust: "loaded": self.world.chunks.contains_key(&(pos[0] >> 4, pos[2] >> 4)),
    // rust: });
        // How far a chest's or a shulker box's lid is open, 0..1, as drawn.
    // rust: match self.be_anims.ticker(state.0) {
    // rust: Some(Ticker::Lid) => v["lid"] = json!(self.chest_lid(pos, 1.0)),
    // rust: Some(Ticker::Shulker { .. }) => v["lid"] = json!(self.block_anim(pos, 1.0).shulker.0),
    // rust: _ => {}
}
        // The lines of a sign, as this client has them.
    // rust: if let Some(horizon_client::containers::BlockEntity::Sign(sign)) =
    // rust: self.world.block_entities.get(&(pos[0], pos[1], pos[2]))
    // rust: {
    // rust: v["sign"] = json!({ "front": sign.front.lines, "back": sign.back.lines });
}
        // A block a piston moves, as this client animates it: its own
        // PistonMovingBlockEntity, which a block event's moveBlocks made.
    // rust: if let Some((_, piston)) = self.world.moving_pistons.iter().find(|(p, _)| *p == pos) {
    // rust: v["moving"] = json!({ "progress": piston.progress, "extending": piston.extending });
}
    // rust: v
}
    // rust: pub(super) fn stack_value(&self, s: &ItemStack) -> Value {
    // rust: let mut v = json!({ "item": &*s.item, "count": s.count });
    // rust: if s.damage > 0 {
    // rust: v["damage"] = json!(s.damage);
}
    // rust: if let Some(c) = horizon_client::item_data::encode_components(s) {
    // rust: v["components"] = json!(horizon_client::snbt::to_snbt(&c));
}
    // rust: v
}
pub fn slot_value(self: *Self, slot: usize, s: *?ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match s {
    // rust: Some(s) => {
    // rust: let mut v = self.stack_value(s);
    // rust: v["slot"] = json!(slot);
    // rust: v
}
    // rust: None => json!({ "slot": slot, "item": null }),
}
}
pub fn need_world(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.title.is_some() {
    // rust: return Err("no world open (title screen); use: open WORLD [SEED] [creative]".into());
}
    // rust: Ok(())
}
pub fn playing(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.title.is_some() {
    // rust: return Err("no world open (title screen); use: open WORLD [SEED] [creative]".into());
}
    // rust: if self.player.is_none() {
    // rust: return Err("the player has not spawned yet; try wait-ready".into());
}
    // rust: if self.screen != Screen::Playing || self.book.is_some() || self.sign_edit.is_some() {
    // rust: return Err(format!(
    // rust: "the {} screen is open; close it first (close, or click-button)",
    // rust: self.screen_label()
    // rust: )
    // rust: .into());
}
    // rust: Ok(())
}
    // rust: pub(super) fn screen_label(&self) -> &'static str {
    // rust: if self.dialog_open() {
    // rust: return "dialog";
}
    // rust: if self.title.is_some() {
    // rust: return "title";
}
    // rust: if self.book.is_some() {
    // rust: return "book";
}
    // rust: if self.sign_edit.is_some() {
    // rust: return "sign";
}
    // rust: match self.screen {
    // rust: Screen::Playing => "playing",
    // rust: Screen::GameModeSwitcher => "gamemode-switcher",
    // rust: Screen::EmoteWheel => "emote-wheel",
    // rust: Screen::Paused => "paused",
    // rust: Screen::Options => "options",
    // rust: Screen::Inventory if self.station.is_some() => "station",
    // rust: Screen::Inventory if self.container.is_some() => "container",
    // rust: Screen::Inventory => "inventory",
    // rust: Screen::Creative => "creative",
    // rust: Screen::Dead => "dead",
    // rust: Screen::Chat => "chat",
    // rust: Screen::Stats => "stats",
    // rust: Screen::Advancements => "advancements",
    // rust: Screen::WorldOptions => "world-options",
    // rust: Screen::Friends => "friends",
    // rust: Screen::Social => "social",
    // rust: Screen::ServerLinks => "server-links",
    // rust: Screen::ConfirmLink => "confirm-link",
    // rust: Screen::DialogWarning => "dialog-warning",
    // rust: Screen::CommandBlock => "command-block",
    // rust: Screen::BlockEditor => "block-editor",
    // rust: Screen::Win => "win",
    // rust: Screen::DebugOptions => "debug-options",
    // rust: Screen::Mod => "mod",
    // rust: Screen::HudEditor => "hud-editor",
}
}
    // rust: pub(super) fn inventory_counts(&self) -> BTreeMap<String, i64> {
    // rust: counts(
    // rust: self.inventory
    // rust: .iter()
    // rust: .chain(self.armor.iter())
    // rust: .chain(std::iter::once(&self.offhand))
    // rust: .chain(std::iter::once(&self.carried))
    // rust: .flatten()
    // rust: .cloned(),
    // rust: )
}

    /// The block or entity under the crosshair.
pub fn looking_at(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(eye) = self.eye_position() else {
    // rust: return Value::Null;
}
    // rust: let block = self.pick().map(|hit| {
    // rust: let mut v = self.block_json(hit.pos);
    // rust: v["face"] = json!(face_name(hit.face));
    // rust: v["point"] = json!(hit.point);
    // rust: v["distance"] = json!(dist(eye, hit.point));
    // rust: v
    // rust: });
    // rust: let entity = self.mob_hit().map(|(i, d, _)| {
    // rust: let m = &self.mobs[i];
    // rust: json!({ "id": m.id, "type": m.kind.id, "health": m.health, "distance": d,
    // rust: "pos": [m.position.x, m.position.y, m.position.z] })
    // rust: });
    // rust: let kind = match (&block, &entity) {
    // rust: (Some(b), Some(e)) if e["distance"].as_f64() <= b["distance"].as_f64() => "entity",
    // rust: (_, Some(_)) if block.is_none() => "entity",
    // rust: (Some(_), _) => "block",
    // rust: _ => "none",
}
    // rust: json!({ "kind": kind, "block": block, "entity": entity })
}

    // rust: pub(super) fn state_value(&self) -> Value {
    // rust: let player = self.player.as_ref().map(|p| {
    // rust: json!({
    // rust: "position": [p.position.x, p.position.y, p.position.z],
    // rust: "block_pos": [p.position.x.floor() as i32, p.position.y.floor() as i32, p.position.z.floor() as i32],
    // rust: "eye": self.eye_position(),
    // rust: "yaw": self.yaw,
    // rust: "pitch": self.pitch,
    // rust: "velocity": [p.velocity.x, p.velocity.y, p.velocity.z],
    // rust: "on_ground": p.ground.on_ground,
    // rust: "flying": p.flying,
    // rust: "fall_flying": p.fall_flying,
    // rust: "sneaking": self.keys.held(Action::Sneak),
    // rust: "sprinting": p.sprinting,
    // rust: "fov_modifier": self.view.fov_modifier,
    // rust: "health": p.health.health(),
    // rust: "absorption": p.health.absorption(),
                // The hurt animation's ticks left (the camera's hurt tilt).
    // rust: "hurt_time": p.health.hurt_animation_time,
                // LivingEntity.deathTime while dead (the camera's death roll).
    // rust: "death_time": self.death_time(),
    // rust: "air": p.air,
                // LocalPlayer.portalEffectIntensity: the Nether portal overlay.
    // rust: "portal_effect": self.screen_fx.portal,
    // rust: "food": p.health.food.food,
    // rust: "saturation": p.health.food.saturation,
    // rust: "shield_cooldown": self.shield_cooldown,
    // rust: "xp": { "level": self.experience.level, "progress": self.experience.progress, "total": self.experience.total },
    // rust: "effects": self.potions.effects.list.iter().map(|e| json!({ "id": e.id, "duration_ticks": e.duration, "amplifier": e.amplifier })).collect::<Vec<_>>(),
    // rust: })
    // rust: });
    // rust: let mut state = json!({
    // rust: "dialog": self.dialog_status(),
    // rust: "screen": self.screen_label(),
    // rust: "menu": (self.title.is_some() || self.split_profiles_open() || self.split_setup_open()).then(|| self.title_value()),
    // rust: "world": (self.title.is_none()).then(|| match &self.integrated {
    // rust: Some(server) => server.world_name.clone(),
    // rust: None => self.level.name.clone(),
    // rust: }),
    // rust: "dimension": self.dim.id(),
    // rust: "gamemode": format!("{:?}", self.mode).to_lowercase(),
            // The bed (its head) the player sleeps in.
    // rust: "sleeping": self.sleeping,
            // The item in use: its slot and for how many ticks.
    // rust: "using": self.using.map(|(slot, ticks)| json!({ "slot": slot, "ticks": ticks })),
            // The block being dug: how far along, after how many ticks.
    // rust: "mining": self.mining.as_ref().map(|m| json!({ "pos": m.pos, "progress": m.progress, "ticks": m.ticks })),
            // The arm swings started (LivingEntity.swing).
    // rust: "swings": self.swings_started,
    // rust: "time": { "day_time": self.world.day_time, "day": self.world.day_time.div_euclid(24000), "time_of_day": self.world.day_time.rem_euclid(24000) },
    // rust: "weather": { "raining": self.world.weather.raining, "thundering": self.world.weather.thundering },
    // rust: "paused": self.pause,
            // Mouse movement turns the camera (`apply_mouse_look`): the real
            // pointer is grabbed, or an agent's `mouse-move` stands in for it.
    // rust: "pointer_grabbed": self.captured || self.agent_pointer,
    // rust: "player": player,
    // rust: "selected": self.selected + 1,
    // rust: "held": self.held().map(|s| self.stack_value(s)),
    // rust: "looking_at": self.looking_at(),
    // rust: "busy": self.agent.task.as_ref().map(|t| t.name),
    // rust: "ticks": self.ticks,
    // rust: });
        // Who caused the input, and whether a repro recording runs.
    // rust: let mut input = self.input_trace.summary();
    // rust: self.repro
    // rust: .fill_summary(&mut input, self.input_trace.events());
    // rust: state["input"] = input;
    // rust: state
}

    /// Splitscreen's profile page, a joining player's (`split_profiles`).
pub fn split_profiles_open(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.screen == Screen::Options
    // rust: && self.ui.options.page() == horizon_client::options_ui::Page::SplitProfiles
}
pub fn split_setup_open(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.screen == Screen::Options
    // rust: && self.ui.options.page() == horizon_client::options_ui::Page::SplitSetup
}
pub fn title_value(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_client::title::Mode;
    // rust: if self.split_profiles_open() {
    // rust: return self.ui.options.split_profiles.state();
}
    // rust: if self.split_setup_open() {
    // rust: return json!({ "mode": "splitscreen-setup", "status": self.ui.options.split_setup.status() });
}
    // rust: let Some(title) = &self.title else {
    // rust: return Value::Null;
}
    // rust: let worlds = || {
    // rust: title
    // rust: .recent_worlds()
    // rust: .iter()
    // rust: .map(
    // rust: |w| json!({ "folder": w.folder, "name": w.name, "creative": w.game_mode == 1 }),
    // rust: )
    // rust: .collect::<Vec<_>>()
}
    // rust: match &title.mode {
    // rust: Mode::Main => json!({ "mode": "main", "worlds": worlds() }),
    // rust: Mode::Select {
    // rust: worlds: list,
    // rust: selected,
    // rust: } => json!({
    // rust: "mode": "select-world",
    // rust: "worlds": list.iter().map(|w| json!({ "folder": w.folder, "name": w.name, "creative": w.game_mode == 1, "corrupted": w.corrupted })).collect::<Vec<_>>(),
    // rust: "selected": selected,
    // rust: }),
    // rust: Mode::Create {
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: focus,
    // rust: options,
    // rust: } => json!({
    // rust: "mode": "create-world",
    // rust: "tab": (["game", "world", "more"][options.tab.min(2)]),
    // rust: "fields": { "name": name, "seed": seed },
    // rust: "focus": match focus { 0 => "name", 1 => "seed", _ => "none" },
    // rust: "creative": creative,
    // rust: "hardcore": options.hardcore,
    // rust: "difficulty": horizon_client::title::DIFFICULTIES[options.difficulty()],
    // rust: "allow_commands": options.commands(*creative),
    // rust: "world_type": options.world_type.id(),
    // rust: "generate_structures": options.structures,
    // rust: "bonus_chest": options.bonus_chest(),
    // rust: }),
    // rust: Mode::CreateFlat {
    // rust: name,
    // rust: seed,
    // rust: options,
    // rust: flat,
    // rust: ..
    // rust: } => json!({
    // rust: "mode": "customize-flat",
    // rust: "fields": { "name": name, "seed": seed },
    // rust: "superflat": options.world_type == horizon_client::save::WorldPreset::Flat,
    // rust: "biome": flat.settings().biome,
    // rust: "layers": flat.settings().layers.iter().map(|layer| json!({
    // rust: "block": layer.block,
    // rust: "height": layer.height,
    // rust: })).collect::<Vec<_>>(),
    // rust: }),
    // rust: Mode::CreateBuffet { buffet, .. } => json!({
    // rust: "mode": "customize-single-biome",
    // rust: "biome": buffet.biome(),
    // rust: "query": buffet.query(),
    // rust: }),
    // rust: Mode::Edit {
    // rust: world,
    // rust: name,
    // rust: focused,
    // rust: } => {
    // rust: json!({ "mode": "edit-world", "folder": world.folder, "fields": { "name": name }, "focus": if *focused { "name" } else { "none" } })
}
    // rust: Mode::Backup { world, .. } => {
    // rust: json!({ "mode": "creating-backup", "folder": world.folder })
}
    // rust: Mode::Delete { world } => {
    // rust: json!({ "mode": "delete-world", "folder": world.folder, "name": world.name })
}
    // rust: Mode::BackupBeforeUpgrade { world, .. } => {
    // rust: json!({ "mode": "backup-before-upgrade", "folder": world.folder, "name": world.name })
}
    // rust: Mode::OptimizeConfirm {
    // rust: world, erase_cache, ..
    // rust: } => {
    // rust: json!({ "mode": "optimize-world-confirm", "folder": world.folder, "name": world.name, "erase_cache": erase_cache })
}
    // rust: Mode::Optimize { world } => {
    // rust: json!({ "mode": "optimize-world", "folder": world.folder, "name": world.name })
}
    // rust: Mode::LowDiskSpace { world } => {
    // rust: json!({ "mode": "low-disk-space", "folder": world.folder, "name": world.name })
}
    // rust: Mode::Recover { world, issues } => {
    // rust: let issue = |i: &Option<horizon_client::save::DatIssue>| match i {
    // rust: None => json!(null),
    // rust: Some(horizon_client::save::DatIssue::Missing) => json!("missing file"),
    // rust: Some(horizon_client::save::DatIssue::Unreadable(why)) => json!(why),
}
    // rust: json!({ "mode": "recover-world", "folder": world.folder, "level_dat": issue(&issues[0]), "level_dat_old": issue(&issues[1]) })
}
    // rust: Mode::Recovered { world, success } => {
    // rust: json!({ "mode": "recovery-done", "folder": world.folder, "success": success })
}
    // rust: Mode::Error { message, .. } => {
    // rust: json!({ "mode": "world-operation-error", "message": message })
}
    // rust: Mode::Multiplayer(horizon_client::multiplayer::Screen::Disconnected {
    // rust: reason, ..
    // rust: }) => {
    // rust: json!({ "mode": "multiplayer", "disconnected": reason })
}
    // rust: Mode::Multiplayer(_) => json!({ "mode": "multiplayer" }),
    // rust: Mode::Realms(_) => json!({ "mode": "realms" }),
    // rust: Mode::MultiplayerWarning { check } => {
    // rust: json!({ "mode": "multiplayer-warning", "check": check })
}
    // rust: Mode::Onboarding(_) => json!({ "mode": "accessibility-onboarding" }),
    // rust: Mode::BanNotice(_) => json!({ "mode": "ban-notice" }),
}
}

    // rust: pub(super) fn entities_value(&self, radius: f64, kind: Option<&str>) -> Value {
    // rust: let Some(p) = &self.player else {
    // rust: return json!({ "entities": [] });
}
    // rust: let me = [p.position.x, p.position.y, p.position.z];
    // rust: let want = kind.map(namespaced);
    // rust: let mut list: Vec<(f64, Value)> = Vec::new();
    // rust: let mut push = |pos: [f64; 3], ty: &str, v: Value| {
    // rust: let d = dist(me, pos);
    // rust: if d <= radius && want.as_deref().is_none_or(|w| w == ty) {
    // rust: let mut v = v;
    // rust: v["type"] = json!(ty);
    // rust: v["pos"] = json!(pos);
    // rust: v["distance"] = json!(d);
    // rust: list.push((d, v));
}
}
        // CAN_BE_PICKED's isPickable (`!isRemoved`): a dead-but-tracked mob
        // — a fake player the server keeps at health 0 — is still here.
    // rust: for m in self.mobs.iter().filter(|m| !m.removed) {
    // rust: let mut v = json!({ "id": m.id, "kind": "mob", "health": m.health, "baby": m.is_baby(), "hurt_time": m.hurt_time });
            // VillagerData as this game knows it: on a client, what the
            // server's synched data says.
    // rust: if matches!(m.species(), Species::Villager | Species::ZombieVillager) {
    // rust: v["villager"] = json!({
    // rust: "type": VILLAGER_TYPES[m.extra.variant as usize % VILLAGER_TYPES.len()],
    // rust: "profession": PROFESSIONS[m.extra.variant2 as usize % PROFESSIONS.len()],
    // rust: "level": m.extra.variant3,
    // rust: });
}
    // rust: push(
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: m.kind.id.as_ref(),
    // rust: v,
    // rust: );
}
    // rust: for item in &self.dropped {
    // rust: push(
    // rust: [item.position.x, item.position.y, item.position.z],
    // rust: "minecraft:item",
    // rust: json!({ "id": item.id, "kind": "item", "item": self.stack_value(&item.stack) }),
    // rust: );
}
    // rust: for orb in &self.orbs {
    // rust: push(
    // rust: [orb.position.x, orb.position.y, orb.position.z],
    // rust: "minecraft:experience_orb",
    // rust: json!({ "kind": "orb", "value": orb.value, "velocity": [orb.velocity.x, orb.velocity.y, orb.velocity.z] }),
    // rust: );
}
    // rust: list.sort_by(|a, b| a.0.total_cmp(&b.0));
    // rust: json!({ "entities": list.into_iter().map(|(_, v)| v).collect::<Vec<_>>() })
}

    // rust: pub(super) fn inventory_value(&self) -> Value {
    // rust: let armor = ["head", "chest", "legs", "feet"];
    // rust: json!({
    // rust: "selected": self.selected + 1,
    // rust: "held": self.held().map(|s| self.stack_value(s)),
    // rust: "hotbar": (0..9).map(|i| self.slot_value(i, &self.inventory[i])).collect::<Vec<_>>(),
    // rust: "main": (9..36).map(|i| self.slot_value(i, &self.inventory[i])).collect::<Vec<_>>(),
    // rust: "armor": armor.iter().enumerate().map(|(i, name)| {
    // rust: let mut v = self.slot_value(500 + i, &self.armor[i]);
    // rust: v["part"] = json!(name);
    // rust: v
    // rust: }).collect::<Vec<_>>(),
    // rust: "offhand": self.slot_value(504, &self.offhand),
    // rust: "carried": self.carried.as_ref().map(|s| self.stack_value(s)),
    // rust: "counts": self.inventory_counts(),
    // rust: })
}

pub fn screen_value(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let buttons: Vec<Value> = widgets::last()
    // rust: .iter()
    // rust: .map(|w| json!({ "label": w.label, "enabled": w.enabled, "x": w.x, "y": w.y, "w": w.w, "h": w.h }))
    // rust: .collect();
    // rust: let mut v = json!({
    // rust: "screen": self.screen_label(),
    // rust: "buttons": buttons,
    // rust: });
    // rust: if let Some(chat) = &self.ui.chat_screen {
    // rust: v["chat_input"] = json!(chat.input.value);
    // rust: v["chat_suggestions"] = json!(chat.suggestions_visible());
}
    // rust: if self.title.is_some() || self.split_profiles_open() || self.split_setup_open() {
    // rust: v["menu"] = self.title_value();
}
    // rust: if self.screen == Screen::Inventory && self.title.is_none() {
    // rust: let mut slots = Vec::new();
    // rust: for i in self.slots() {
    // rust: let stack = if i == 200 {
    // rust: self.craft_result()
    // rust: } else {
    // rust: self.slot_mut(i).clone()
}
    // rust: slots.push(self.slot_value(i, &stack));
}
    // rust: v["slots"] = json!(slots);
    // rust: v["carried"] = json!(self.carried.as_ref().map(|s| self.stack_value(s)));
    // rust: v["craft_size"] = json!(self.craft_size);
    // rust: v["station"] = json!(self.station.as_ref().map(|s| format!("{:?}", s.kind)));
    // rust: v["container"] = json!(self.container);
            // The title a server gave the menu, span by span as it is drawn.
    // rust: if let Some(title) = self.remote_menu_title() {
    // rust: let spans = title.spans.iter().map(|s| {
    // rust: json!({
    // rust: "text": s.text,
    // rust: "color": s.style.color.map(|c| format!("#{c:06X}")),
    // rust: "bold": s.style.is_bold(),
    // rust: "italic": s.style.is_italic(),
    // rust: })
    // rust: });
    // rust: v["title"] = json!(spans.collect::<Vec<_>>());
}
            // The recipe book's buttons (GUI pixels): the book button, then
            // the recipe buttons of the page, page arrows, filter and tabs.
    // rust: let book = self.recipe_book_targets();
    // rust: if !book.is_empty() {
    // rust: let (open, filtering) = self.recipe_book_flags().unwrap_or_default();
    // rust: v["recipe_book"] = json!({
    // rust: "targets": book.iter().map(|t| t.rect).collect::<Vec<_>>(),
    // rust: "known": self.recipe_book_known(),
    // rust: "open": open,
    // rust: "filtering": filtering,
    // rust: });
}
    // rust: v["slot_ids"] = json!(
    // rust: "0-8 hotbar, 9-35 inventory, 100+ crafting grid (row-major), 200 crafting result, 300+ container, 500-503 armor, 504 offhand, 600+ station"
    // rust: );
}
    // rust: v
}

pub fn messages_value(self: *Self, n: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let titles = &self.titles;
    // rust: json!({
    // rust: "chat": self.remote_chat(n).unwrap_or_else(|| self.ui.chat.recent_lines(n)),
    // rust: "order": "newest first",
            // The chat lines as drawn: colours, click and hover events.
    // rust: "styled": self.ui.chat.recent_components(n),
    // rust: "title": (titles.time > 0).then(|| titles.title.as_ref().map(|t| t.plain())).flatten(),
    // rust: "subtitle": (titles.time > 0).then(|| titles.subtitle.as_ref().map(|t| t.plain())).flatten(),
    // rust: "actionbar": (titles.overlay_time > 0).then(|| titles.overlay.as_ref().map(|t| t.plain())).flatten(),
    // rust: })
}

    // rust: fn find_path(
    // rust: &self,
    // rust: from: Node,
    // rust: goal: [f64; 3],
    // rust: near: f64,
    // rust: blocked: &[(Node, Node)],
    // rust: ) -> Option<Plan> {
    // rust: navigation::find_path(from, goal, near, blocked, |n| {
    // rust: if !self.world.chunks.contains_key(&(n[0] >> 4, n[2] >> 4)) {
    // rust: return None;
}
    // rust: let f = self.res.facts().get(self.world.block(n[0], n[1], n[2]));
    // rust: Some(Cell {
    // rust: solid: f.full_collision || f.legacy_solid,
    // rust: fluid: f.fluid != horizon_client::blocks::Fluid::None,
    // rust: lava: &*f.name == "minecraft:lava",
    // rust: })
    // rust: })
}

    /// Point the view at `at` from the eye.
pub fn face_point(self: *Self, at: [f64; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let eye = self.eye_position().ok_or("no player")?;
    // rust: let (yaw, pitch) = yaw_pitch(eye, at);
    // rust: self.yaw = yaw;
    // rust: self.pitch = pitch.clamp(-90.0, 90.0);
    // rust: Ok(())
}
    /// Aim at a face of `pos` the crosshair can reach; the face hit.
pub fn aim_block(self: *Self, pos: [i32; 3], face: ?[i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let eye = self.eye_position().ok_or("no player")?;
    // rust: let centre = pos.map(|v| f64::from(v) + 0.5);
    // rust: let mut faces: Vec<[i32; 3]> = match face {
    // rust: Some(f) => vec![f],
    // rust: None => FACES.iter().map(|(_, d)| *d).collect(),
}
        // Faces turned towards the eye first, nearest first.
    // rust: faces.sort_by(|a, b| {
    // rust: let point = |f: &[i32; 3]| [0, 1, 2].map(|i| centre[i] + f64::from(f[i]) * 0.45);
    // rust: dist(eye, point(a)).total_cmp(&dist(eye, point(b)))
    // rust: });
    // rust: for f in faces {
    // rust: for inset in [0.45, 0.3, 0.0] {
    // rust: let point = [0, 1, 2].map(|i| centre[i] + f64::from(f[i]) * inset);
    // rust: let (yaw, pitch) = yaw_pitch(eye, point);
    // rust: let dir = super::view_vector(yaw, pitch);
    // rust: if let Some(hit) = self.clip_ray(eye, dir, self.reach())
    // rust: && hit.pos == pos
    // rust: && (face.is_none() || hit.face == f)
    // rust: {
    // rust: self.yaw = yaw;
    // rust: self.pitch = pitch;
    // rust: return Ok(hit.face);
}
}
}
    // rust: let d = dist(eye, centre);
    // rust: if d > self.reach() + 0.9 {
    // rust: return Err(format!(
    // rust: "block {pos:?} is {d:.1} blocks away, out of reach ({:.1}); goto it first",
    // rust: self.reach()
    // rust: )
    // rust: .into());
}
    // rust: Err(format!("no face of block {pos:?} is visible from here").into())
}

    /// A left or right click, as the mouse would.
pub fn agent_mouse(self: *Self, button: MouseButton, pressed: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mouse_mapping(button, pressed, Source::Agent)
}
pub fn release_agent_keys(self: *Self) void {
}
    // rust: for k in MOVE_KEYS {
    // rust: self.keys.release(&k, Source::Agent);
}
    // rust: if self.left {
    // rust: let _ = self.agent_mouse(MouseButton::Left, false);
}
    // rust: if self.right {
    // rust: let _ = self.agent_mouse(MouseButton::Right, false);
}
}

    /// Synthesize the pointer moving to GUI pixel (x, y) and a click there.
    // rust: pub(super) fn synth_click(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: x: f32,
    // rust: y: f32,
    // rust: button: MouseButton,
    // rust: ) -> Result<()> {
    // rust: self.synth_drag(event_loop, &[(x, y)], button)
}
    /// The window events of a press at the first GUI point, moves through
    /// the others and a release at the last (one point is a click).
    // rust: fn synth_drag(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: points: &[(f32, f32)],
    // rust: button: MouseButton,
    // rust: ) -> Result<()> {
    // rust: let id = self.window.as_ref().ok_or("no window yet")?.id();
    // rust: let scale = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map(|r| horizon_client::hud::HudBatch::new([r.config.width, r.config.height]).scale)
    // rust: .ok_or("no renderer yet")?;
    // rust: let device_id = DeviceId::dummy();
    // rust: for (i, &(x, y)) in points.iter().enumerate() {
    // rust: let position = PhysicalPosition::new(f64::from(x * scale), f64::from(y * scale));
    // rust: self.handle_window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::CursorMoved {
    // rust: device_id,
    // rust: position,
    // rust: },
    // rust: super::input_trace::InputOrigin::Agent,
    // rust: );
    // rust: if i == 0 {
    // rust: self.handle_window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::MouseInput {
    // rust: device_id,
    // rust: state: ElementState::Pressed,
    // rust: button,
    // rust: },
    // rust: super::input_trace::InputOrigin::Agent,
    // rust: );
}
}
    // rust: self.handle_window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::MouseInput {
    // rust: device_id,
    // rust: state: ElementState::Released,
    // rust: button,
    // rust: },
    // rust: super::input_trace::InputOrigin::Agent,
    // rust: );
    // rust: Ok(())
}

    // rust: fn start_task(
    // rust: &mut self,
    // rust: name: &'static str,
    // rust: kind: TaskKind,
    // rust: reply: &Sender<String>,
    // rust: timeout: f64,
    // rust: ) -> Result<Handled> {
    // rust: self.agent.task = Some(Task {
    // rust: kind,
    // rust: reply: reply.clone(),
    // rust: deadline: Instant::now() + Duration::from_secs_f64(timeout.clamp(0.05, 3600.0)),
    // rust: name,
    // rust: });
    // rust: Ok(Handled::Deferred)
}

    /// A deferred agent action (goto, break, wait...) is still running.
    // rust: pub(super) fn agent_busy(&self) -> bool {
    // rust: self.agent.task.is_some()
}

    /// Agent commands; `Handled::No` when `words[0]` is not one of them.
    // rust: pub(super) fn agent_command(
    // rust: &mut self,
    // rust: words: &[&str],
    // rust: line: &str,
    // rust: reply: &Sender<String>,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: ) -> Result<Handled> {
    // rust: let name = words[0];
    // rust: let a = parse_args(&words[1..]);
    // rust: let ok = |v: Value| Ok(Handled::Reply(v));
    // rust: let blocking = matches!(
    // rust: name,
    // rust: "move"
    // rust: | "jump"
    // rust: | "goto"
    // rust: | "break"
    // rust: | "place"
    // rust: | "interact"
    // rust: | "use-item"
    // rust: | "attack"
    // rust: | "wait"
    // rust: );
    // rust: if blocking && let Some(task) = &self.agent.task {
    // rust: return Err(format!("busy with {}; wait for it or send stop", task.name).into());
}
    // rust: match name {
    // rust: "state" => ok(self.state_value()),
    // rust: "looking-at" | "target" => {
    // rust: self.need_world()?;
    // rust: ok(self.looking_at())
}
    // rust: "entities" => {
    // rust: self.need_world()?;
    // rust: let radius = a.pos.first().map_or(Ok(32.0), |r| r.parse::<f64>())?;
    // rust: ok(self.entities_value(radius, a.pos.get(1).copied()))
}
    // rust: "block" => {
    // rust: self.need_world()?;
    // rust: ok(self.block_json(a.block_pos(0)?))
}
    // rust: "blocks" => {
    // rust: self.need_world()?;
    // rust: let (p, q) = (a.block_pos(0)?, a.block_pos(3)?);
    // rust: let lo = [0, 1, 2].map(|i| p[i].min(q[i]));
    // rust: let hi = [0, 1, 2].map(|i| p[i].max(q[i]));
    // rust: let volume: i64 = (0..3).map(|i| i64::from(hi[i] - lo[i] + 1)).product();
    // rust: if volume > 32768 {
    // rust: return Err(format!("{volume} blocks; at most 32768 per request").into());
}
    // rust: let mut list = Vec::new();
    // rust: let mut census: BTreeMap<String, u32> = BTreeMap::new();
    // rust: for y in lo[1]..=hi[1] {
    // rust: for z in lo[2]..=hi[2] {
    // rust: for x in lo[0]..=hi[0] {
    // rust: let state = self.world.block(x, y, z);
    // rust: if self.res.facts().is_air(state) {
    // rust: continue;
}
    // rust: let name = self.res.facts().get(state).name.to_string();
    // rust: *census.entry(name).or_insert(0) += 1;
    // rust: list.push(json!([x, y, z, self.state_string(state)]));
}
}
}
    // rust: ok(json!({ "from": lo, "to": hi, "counts": census, "blocks": list }))
}
    // rust: "light" => {
    // rust: self.need_world()?;
    // rust: let (p, q) = (a.block_pos(0)?, a.block_pos(3)?);
    // rust: let lo = [0, 1, 2].map(|i| p[i].min(q[i]));
    // rust: let hi = [0, 1, 2].map(|i| p[i].max(q[i]));
    // rust: let volume: i64 = (0..3).map(|i| i64::from(hi[i] - lo[i] + 1)).product();
    // rust: if volume > 32768 {
    // rust: return Err(format!("{volume} blocks; at most 32768 per request").into());
}
                // One hex digit per block, x fastest, then z, then y; `.`
                // outside the loaded chunks.
    // rust: let (mut sky, mut block) = (String::new(), String::new());
    // rust: for y in lo[1]..=hi[1] {
    // rust: for z in lo[2]..=hi[2] {
    // rust: for x in lo[0]..=hi[0] {
    // rust: let packed = self
    // rust: .world
    // rust: .chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .filter(|_| {
    // rust: (self.world.bottom_y()..self.world.top_y()).contains(&y)
    // rust: })
    // rust: .map(|c| c.light(x & 15, y, z & 15));
    // rust: let digit = |v: u8| char::from_digit(u32::from(v), 16).unwrap_or('.');
    // rust: sky.push(packed.map_or('.', |v| digit(v >> 4)));
    // rust: block.push(packed.map_or('.', |v| digit(v & 15)));
}
}
}
    // rust: ok(json!({ "from": lo, "to": hi, "sky": sky, "block": block }))
}
    // rust: "find-block" => {
    // rust: self.need_world()?;
    // rust: let want = namespaced(a.get(0, "BLOCK")?);
    // rust: let radius = a
    // rust: .pos
    // rust: .get(1)
    // rust: .map_or(Ok(32), |r| r.parse::<i32>())?
    // rust: .clamp(1, 64);
    // rust: let eye = self.eye_position().ok_or("no player")?;
    // rust: let c = eye.map(|v| v.floor() as i32);
    // rust: let mut found = Vec::new();
    // rust: for y in (c[1] - radius).max(-64)..=(c[1] + radius).min(319) {
    // rust: for z in c[2] - radius..=c[2] + radius {
    // rust: for x in c[0] - radius..=c[0] + radius {
    // rust: let state = self.world.block(x, y, z);
    // rust: if *self.res.facts().get(state).name == *want {
    // rust: let d = dist(eye, [x, y, z].map(|v| f64::from(v) + 0.5));
    // rust: found.push((d, [x, y, z]));
}
}
}
}
    // rust: found.sort_by(|a, b| a.0.total_cmp(&b.0));
    // rust: let total = found.len();
    // rust: ok(json!({
    // rust: "block": want,
    // rust: "count": total,
    // rust: "nearest": found.iter().take(16).map(|(d, p)| json!({ "pos": p, "distance": d })).collect::<Vec<_>>(),
    // rust: }))
}
    // rust: "inventory" => {
    // rust: self.need_world()?;
    // rust: ok(self.inventory_value())
}
    // rust: "screen" => ok(self.screen_value()),
    // rust: "messages" => {
    // rust: let n = a.pos.first().map_or(Ok(20), |n| n.parse::<usize>())?;
    // rust: ok(self.messages_value(n))
}
    // rust: "move" => {
    // rust: self.playing()?;
    // rust: let key = match a.get(0, "DIR")? {
    // rust: "forward" | "w" => KeyCode::KeyW,
    // rust: "back" | "backward" | "s" => KeyCode::KeyS,
    // rust: "left" | "a" => KeyCode::KeyA,
    // rust: "right" | "d" => KeyCode::KeyD,
    // rust: other => {
    // rust: return Err(
    // rust: format!("DIR is forward, back, left or right, not {other}").into()
    // rust: );
}
}
    // rust: let seconds = a.f64(1, "SECONDS")?.clamp(0.0, 600.0);
    // rust: let mut keys = vec![key];
    // rust: if a.has("sprint") {
    // rust: keys.push(KeyCode::ControlLeft);
}
    // rust: if a.has("sneak") {
    // rust: keys.push(KeyCode::ShiftLeft);
}
    // rust: if a.has("jump") {
    // rust: keys.push(KeyCode::Space);
}
    // rust: for &k in &keys {
    // rust: self.keys.press(k, Source::Agent);
}
    // rust: let from = self.player.as_ref().map_or(Vec3::ZERO, |p| p.position);
    // rust: let until = Instant::now() + Duration::from_secs_f64(seconds);
    // rust: self.start_task(
    // rust: "move",
    // rust: TaskKind::Move { keys, until, from },
    // rust: reply,
    // rust: seconds + 5.0,
    // rust: )
}
    // rust: "jump" => {
    // rust: self.playing()?;
    // rust: self.keys.press(KeyCode::Space, Source::Agent);
    // rust: let from_y = self.player.as_ref().map_or(0.0, |p| p.position.y);
    // rust: let release_tick = self.ticks + 3;
    // rust: self.start_task(
    // rust: "jump",
    // rust: TaskKind::Jump {
    // rust: release_tick,
    // rust: from_y,
    // rust: },
    // rust: reply,
    // rust: 5.0,
    // rust: )
}
    // rust: "goto" => {
    // rust: self.playing()?;
    // rust: let target = [a.f64(0, "X")?, a.f64(1, "Y")?, a.f64(2, "Z")?];
    // rust: let near = a.num("near", 0.6)?.max(0.3);
    // rust: let timeout = a.num("timeout", 60.0)?;
    // rust: let p = self.player.as_ref().ok_or("no player")?.position;
    // rust: let from = [p.x.floor() as i32, p.y.round() as i32, p.z.floor() as i32];
    // rust: let (path, warning) = match self.find_path(from, target, near, &[]) {
    // rust: Some(path) => (path, None),
    // rust: None if a.has("direct") => (
    // rust: Plan {
    // rust: nodes: Vec::new(),
    // rust: complete: true,
    // rust: },
    // rust: Some("no path found through loaded terrain; walking straight".to_owned()),
    // rust: ),
    // rust: None => {
    // rust: return Err(format!(
    // rust: "no walking path to {target:?} through loaded terrain (climbs of more than one block, drops of more than three, lava and unloaded chunks are avoided); pick a nearer or lower spot, raise --near, or use --direct to walk straight at it"
    // rust: )
    // rust: .into());
}
}
    // rust: let position = [p.x, p.y, p.z];
    // rust: let mut next = 1;
    // rust: let aim = path.aim(position, &mut next, target).unwrap_or(target);
    // rust: let goto = Goto {
    // rust: target,
    // rust: near,
    // rust: sprint: a.has("sprint"),
    // rust: path,
    // rust: blocked: Vec::new(),
    // rust: progress: Progress::new(position, aim),
    // rust: next,
    // rust: progress_tick: self.ticks,
    // rust: replans: 0,
    // rust: jump_until: 0,
    // rust: warning,
}
    // rust: self.start_task("goto", TaskKind::Goto(Box::new(goto)), reply, timeout)
}
    // rust: "mouse-move" => {
    // rust: self.turning()?;
    // rust: let motion = (a.f64(0, "DX")?, a.f64(1, "DY")?);
    // rust: self.start_glide(motion, 0.0, None, reply)
}
    // rust: "turn" if a.has("over") => {
    // rust: self.turning()?;
    // rust: let (dyaw, dpitch) = (a.f64(0, "DYAW")?, a.f64(1, "DPITCH")?);
    // rust: let motion =
    // rust: horizon_client::mouse::motion_for_turn(dyaw, dpitch, self.look_options());
    // rust: self.start_glide(motion, a.num("over", 0.0)?, None, reply)
}
    // rust: "look-at" => {
    // rust: self.need_world()?;
    // rust: let over = a.has("over").then(|| a.num("over", 0.0)).transpose()?;
    // rust: if over.is_some() {
    // rust: self.turning()?;
}
    // rust: let before = (self.yaw, self.pitch);
    // rust: let (aim, value) = match a.pos.first().copied() {
    // rust: Some("block") => {
    // rust: let pos = a.block_pos(1)?;
    // rust: let face = a.pos.get(4).map(|f| face_dir(f)).transpose()?;
    // rust: let hit = self.aim_block(pos, face)?;
    // rust: (
    // rust: "block",
    // rust: json!({ "ok": true, "yaw": self.yaw, "pitch": self.pitch, "face": face_name(hit) }),
    // rust: )
}
    // rust: Some("entity") => {
    // rust: let id: u32 = a.get(1, "ID")?.parse()?;
    // rust: let m = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .ok_or_else(|| format!("no entity {id}"))?;
    // rust: let c = m.center();
    // rust: self.face_point(c)?;
    // rust: (
    // rust: "entity",
    // rust: json!({ "ok": true, "yaw": self.yaw, "pitch": self.pitch, "target": self.looking_at() }),
    // rust: )
}
    // rust: _ => {
    // rust: let at = [a.f64(0, "X")?, a.f64(1, "Y")?, a.f64(2, "Z")?];
    // rust: self.face_point(at)?;
    // rust: (
    // rust: "point",
    // rust: json!({ "ok": true, "yaw": self.yaw, "pitch": self.pitch }),
    // rust: )
}
}
    // rust: let Some(over) = over else {
    // rust: return ok(value);
}
                // Turn there with the mouse instead: the shorter way round.
    // rust: let target = (self.yaw, self.pitch);
    // rust: (self.yaw, self.pitch) = before;
    // rust: let dyaw = f64::from(target.0 - before.0 + 180.0).rem_euclid(360.0) - 180.0;
    // rust: let dpitch = f64::from(target.1 - before.1);
    // rust: let motion =
    // rust: horizon_client::mouse::motion_for_turn(dyaw, dpitch, self.look_options());
    // rust: self.start_glide(motion, over, Some(aim), reply)
}
    // rust: "attack" => {
    // rust: self.playing()?;
    // rust: let id = a.pos.first().map(|i| i.parse::<u32>()).transpose()?;
    // rust: if let Some(id) = id {
    // rust: let m = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .ok_or_else(|| format!("no entity {id}"))?;
    // rust: let c = m.center();
    // rust: self.face_point(c)?;
}
    // rust: let target = self
    // rust: .mob_hit()
    // rust: .map(|(i, _, _)| (self.mobs[i].id, self.mobs[i].health));
    // rust: if id.is_some() && target.map(|t| t.0) != id {
    // rust: return Err("that entity is out of reach or hidden; get closer".into());
}
    // rust: self.agent_mouse(MouseButton::Left, true)?;
    // rust: self.agent_mouse(MouseButton::Left, false)?;
    // rust: let report_tick = self.ticks + 4;
    // rust: self.start_task(
    // rust: "attack",
    // rust: TaskKind::Attack {
    // rust: id: target.map(|t| t.0),
    // rust: health: target.map(|t| t.1),
    // rust: report_tick,
    // rust: },
    // rust: reply,
    // rust: 5.0,
    // rust: )
}
    // rust: "break" => {
    // rust: self.playing()?;
    // rust: let pos = a.block_pos(0)?;
    // rust: let before = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if self.res.facts().is_air(before) {
    // rust: return Err(format!("there is no block at {pos:?}").into());
}
    // rust: self.aim_block(pos, None)?;
    // rust: let timeout = a.num("timeout", 30.0)?;
    // rust: let task = Break {
    // rust: pos,
    // rust: before,
    // rust: items_before: self.dropped.iter().map(|i| i.id).collect(),
    // rust: inventory: self.inventory_counts(),
    // rust: started_tick: self.ticks,
    // rust: collect_until: None,
    // rust: broke_tick: 0,
    // rust: drops: BTreeMap::new(),
}
    // rust: self.agent_mouse(MouseButton::Left, true)?;
    // rust: self.start_task("break", TaskKind::Break(Box::new(task)), reply, timeout)
}
    // rust: "place" => {
    // rust: self.playing()?;
    // rust: let pos = a.block_pos(0)?;
    // rust: if let Some(Some(item)) = a.flags.get("item") {
    // rust: self.select_item(&namespaced(item))?;
}
    // rust: let held = self
    // rust: .held()
    // rust: .ok_or("nothing in hand to place; select an item")?;
    // rust: let held = held.item.clone();
    // rust: let before = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if !self.res.facts().get(before).replaceable && !self.res.facts().is_air(before) {
    // rust: return Err(format!(
    // rust: "{pos:?} holds {}; break it first",
    // rust: self.res.facts().get(before).name
    // rust: )
    // rust: .into());
}
                // A replaceable block there (grass, snow) is clicked itself, as
                // a player would; otherwise the face of a neighbour touching it.
    // rust: let mut aimed = !self.res.facts().is_air(before)
    // rust: && !self.res.facts().get(before).outline.is_empty()
    // rust: && self.aim_block(pos, None).is_ok();
    // rust: for (_, d) in FACES.iter().filter(|_| !aimed) {
    // rust: let d = *d;
    // rust: let support = add(pos, d);
    // rust: let state = self.world.block(support[0], support[1], support[2]);
    // rust: let f = self.res.facts().get(state);
    // rust: if self.res.facts().is_air(state)
    // rust: || f.replaceable
    // rust: || f.fluid != horizon_client::blocks::Fluid::None && !f.waterlogged
    // rust: {
    // rust: continue;
}
    // rust: let face = d.map(|v| -v);
    // rust: if self.aim_block(support, Some(face)).is_ok() {
    // rust: aimed = true;
    // rust: break;
}
}
    // rust: if !aimed {
    // rust: return Err(format!(
    // rust: "no visible face to place {held} against at {pos:?}; it needs a solid neighbour in reach"
    // rust: )
    // rust: .into());
}
    // rust: let inventory = self.inventory_counts();
    // rust: self.agent_mouse(MouseButton::Right, true)?;
    // rust: self.agent_mouse(MouseButton::Right, false)?;
    // rust: let report_tick = self.ticks + 2;
    // rust: self.start_task(
    // rust: "place",
    // rust: TaskKind::Click {
    // rust: pos: Some(pos),
    // rust: before: Some(before),
    // rust: inventory,
    // rust: report_tick,
    // rust: release: None,
    // rust: place: true,
    // rust: },
    // rust: reply,
    // rust: 5.0,
    // rust: )
}
    // rust: "interact" | "use-item" => {
    // rust: self.playing()?;
    // rust: let hold = a.num("hold", 0.0)?;
    // rust: let pos = if name == "interact" {
    // rust: let pos = a.block_pos(0)?;
    // rust: let face = a.pos.get(3).map(|f| face_dir(f)).transpose()?;
    // rust: self.aim_block(pos, face)?;
    // rust: Some(pos)
    // rust: } else {
    // rust: None
}
    // rust: let before = pos.map(|p| self.world.block(p[0], p[1], p[2]));
    // rust: let inventory = self.inventory_counts();
    // rust: self.agent_mouse(MouseButton::Right, true)?;
    // rust: let release = if hold > 0.0 {
    // rust: Some(Instant::now() + Duration::from_secs_f64(hold))
    // rust: } else {
    // rust: self.agent_mouse(MouseButton::Right, false)?;
    // rust: None
}
    // rust: let report_tick = self.ticks + 2;
    // rust: self.start_task(
    // rust: if name == "interact" {
    // rust: "interact"
    // rust: } else {
    // rust: "use-item"
    // rust: },
    // rust: TaskKind::Click {
    // rust: pos,
    // rust: before,
    // rust: inventory,
    // rust: report_tick,
    // rust: release,
    // rust: place: false,
    // rust: },
    // rust: reply,
    // rust: hold + 5.0,
    // rust: )
}
    // rust: "select" => {
    // rust: self.need_world()?;
    // rust: let what = a.get(0, "SLOT or ITEM")?;
    // rust: match what.parse::<usize>() {
    // rust: Ok(n) if (1..=9).contains(&n) => self.selected = n - 1,
    // rust: Ok(_) => return Err("hotbar slots are 1..9".into()),
    // rust: Err(_) => self.select_item(&namespaced(what))?,
}
    // rust: ok(
    // rust: json!({ "ok": true, "selected": self.selected + 1, "held": self.held().map(|s| self.stack_value(s)) }),
    // rust: )
}
    // rust: "drop" => {
    // rust: self.playing()?;
    // rust: let all = a.pos.first() == Some(&"all");
    // rust: let before = self.held().map(|s| self.stack_value(s));
    // rust: if self.remote.is_some() {
                    // As Q does on a server (and on the single-player server
                    // thread): the server throws the stack, the client predicts it.
    // rust: if !self.spectator() {
    // rust: self.remote_drop(all);
}
    // rust: } else {
    // rust: self.drop_held(all);
}
    // rust: ok(
    // rust: json!({ "ok": true, "dropped_from": before, "held": self.held().map(|s| self.stack_value(s)) }),
    // rust: )
}
    // rust: "open-inventory" => {
    // rust: self.playing()?;
    // rust: self.key_pressed(KeyCode::KeyE, KeyCode::KeyE)?;
    // rust: ok(json!({ "ok": true, "screen": self.screen_label() }))
}
    // rust: "click-button" => {
    // rust: let label = line
    // rust: .trim_start()
    // rust: .strip_prefix("click-button")
    // rust: .unwrap_or("")
    // rust: .trim()
    // rust: .trim_matches('"');
    // rust: if label.is_empty() {
    // rust: return Err("click-button LABEL".into());
}
    // rust: let w = widgets::find(&widgets::last(), label)?;
    // rust: if !w.enabled {
    // rust: return Err(format!("button {:?} is disabled", w.label).into());
}
    // rust: self.synth_click(
    // rust: event_loop,
    // rust: w.x + w.w / 2.0,
    // rust: w.y + w.h / 2.0,
    // rust: MouseButton::Left,
    // rust: )?;
    // rust: ok(json!({ "ok": true, "clicked": w.label, "screen": self.screen_label() }))
}
    // rust: "drag-at" => {
    // rust: let right = a.pos.first() == Some(&"right");
    // rust: let numbers = &a.pos[usize::from(right)..];
    // rust: let points = numbers
    // rust: .chunks(2)
    // rust: .map(|c| match c {
    // rust: [x, y] => Ok((x.parse::<f32>()?, y.parse::<f32>()?)),
    // rust: _ => Err("drag-at needs X Y pairs".into()),
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: if points.is_empty() {
    // rust: return Err("drag-at needs X Y pairs".into());
}
    // rust: let button = if right {
    // rust: MouseButton::Right
    // rust: } else {
    // rust: MouseButton::Left
}
    // rust: self.synth_drag(event_loop, &points, button)?;
    // rust: ok(json!({ "ok": true, "screen": self.screen_label() }))
}
    // rust: "scroll-at" => {
    // rust: let (x, y) = (a.f64(0, "X")? as f32, a.f64(1, "Y")? as f32);
    // rust: let steps = a.f64(2, "STEPS")? as f32;
    // rust: let id = self.window.as_ref().ok_or("no window yet")?.id();
    // rust: let scale = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map(|r| {
    // rust: horizon_client::hud::HudBatch::new([r.config.width, r.config.height]).scale
    // rust: })
    // rust: .ok_or("no renderer yet")?;
    // rust: let device_id = DeviceId::dummy();
    // rust: let position = PhysicalPosition::new(f64::from(x * scale), f64::from(y * scale));
    // rust: self.handle_window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::CursorMoved {
    // rust: device_id,
    // rust: position,
    // rust: },
    // rust: super::input_trace::InputOrigin::Agent,
    // rust: );
    // rust: for _ in 0..steps.abs() as u32 {
    // rust: self.handle_window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::MouseWheel {
    // rust: device_id,
    // rust: delta: MouseScrollDelta::LineDelta(0.0, steps.signum()),
    // rust: phase: TouchPhase::Moved,
    // rust: },
    // rust: super::input_trace::InputOrigin::Agent,
    // rust: );
}
    // rust: ok(json!({ "ok": true, "screen": self.screen_label() }))
}
    // rust: "click-at" => {
    // rust: let (x, y) = (a.f64(0, "X")? as f32, a.f64(1, "Y")? as f32);
    // rust: let button = if a.pos.get(2) == Some(&"right") {
    // rust: MouseButton::Right
    // rust: } else {
    // rust: MouseButton::Left
}
    // rust: self.synth_click(event_loop, x, y, button)?;
    // rust: ok(json!({ "ok": true, "screen": self.screen_label() }))
}
            // Splitscreen's profile page, over a joining player's title screen.
    // rust: "type" if self.split_profiles_open() => {
    // rust: let text = line
    // rust: .trim_start()
    // rust: .strip_prefix("type")
    // rust: .unwrap_or("")
    // rust: .strip_prefix(' ')
    // rust: .unwrap_or("");
    // rust: let page = &mut self.ui.options.split_profiles;
    // rust: if text == "\\b" {
    // rust: page.key(winit::keyboard::KeyCode::Backspace, None);
    // rust: } else {
    // rust: page.type_text(text);
}
    // rust: ok(json!({ "ok": true, "menu": self.title_value() }))
}
    // rust: "type" if self.title.is_some() => {
                // type [--field name|seed] [--replace] TEXT on the title screens.
    // rust: let mut text = line
    // rust: .trim_start()
    // rust: .strip_prefix("type")
    // rust: .unwrap_or("")
    // rust: .strip_prefix(' ')
    // rust: .unwrap_or("");
    // rust: let mut field = None;
    // rust: let mut replace = false;
    // rust: loop {
    // rust: if let Some(rest) = text.strip_prefix("--replace") {
    // rust: replace = true;
    // rust: text = rest.trim_start();
    // rust: } else if let Some(rest) = text.strip_prefix("--field") {
    // rust: let rest = rest.trim_start();
    // rust: let (name, rest) = rest.split_once(' ').unwrap_or((rest, ""));
    // rust: field = Some(name.to_owned());
    // rust: text = rest;
    // rust: } else {
    // rust: break;
}
}
    // rust: let title = self.title.as_mut().ok_or("no title screen")?;
    // rust: if let Some(field) = &field {
    // rust: match &mut title.mode {
    // rust: horizon_client::title::Mode::Create { focus, options, .. } => {
                            // Each box is on its own tab.
    // rust: *focus = match field.as_str() {
    // rust: "name" => {
    // rust: options.tab = 0;
    // rust: 0
}
    // rust: "seed" => {
    // rust: options.tab = 1;
    // rust: 1
}
    // rust: other => {
    // rust: return Err(format!(
    // rust: "the create-world fields are name and seed, not {other}"
    // rust: )
    // rust: .into());
}
}
}
    // rust: horizon_client::title::Mode::Edit { focused, .. } if field == "name" => {
    // rust: *focused = true
}
    // rust: _ => {
    // rust: return Err(
    // rust: "--field works on the create-world or edit-world screen".into()
    // rust: );
}
}
}
    // rust: if replace {
    // rust: for _ in 0..64 {
    // rust: title.backspace();
}
}
    // rust: if text == "\\b" {
    // rust: title.backspace();
    // rust: } else {
    // rust: title.type_text(text);
}
    // rust: ok(json!({ "ok": true, "menu": self.title_value() }))
}
    // rust: "command" => {
    // rust: self.need_world()?;
    // rust: let text = line
    // rust: .trim_start()
    // rust: .strip_prefix("command")
    // rust: .unwrap_or("")
    // rust: .trim()
    // rust: .trim_start_matches('/');
    // rust: if text.is_empty() {
    // rust: return Err("command TEXT".into());
}
                // A native mod's command first, as typed chat does; the
                // server's console cannot run a client mod's command.
    // rust: if self.client_mod_command(text) {
    // rust: return ok(json!({ "ok": true, "chat": self.ui.chat.recent_lines(5) }));
}
    // rust: let command = format!("/{text}");
                // Single player's console is its server thread's.
    // rust: if let Some(server) = &self.integrated {
    // rust: let chat = server
    // rust: .call(move |g| g.owner_console_command(&command))
    // rust: .ok_or(super::integrated::NO_ANSWER)?;
    // rust: return ok(json!({ "ok": true, "chat": chat }));
}
    // rust: if self.remote.is_some() {
    // rust: self.send_chat(&command);
    // rust: return ok(json!({ "ok": true }));
}
    // rust: self.as_console(|g| g.handle_chat_input(&command));
    // rust: ok(json!({ "ok": true, "chat": self.ui.chat.recent_lines(5) }))
}
    // rust: "respawn" if self.remote.is_none() => {
    // rust: if self.screen != Screen::Dead {
    // rust: return Err("respawn needs the death screen".into());
}
    // rust: let key = if self.level.hardcore {
    // rust: "deathScreen.spectate"
    // rust: } else {
    // rust: "deathScreen.respawn"
}
    // rust: let label = horizon_client::text::Text::translate(key, &[]).plain();
    // rust: let w = widgets::find(&widgets::last(), &label)?;
    // rust: if !w.enabled {
                    // DeathScreen enables its buttons after 20 ticks.
    // rust: return Err(
    // rust: "the Respawn button is not active yet; try again in a second (wait 20)"
    // rust: .into(),
    // rust: );
}
    // rust: self.synth_click(
    // rust: event_loop,
    // rust: w.x + w.w / 2.0,
    // rust: w.y + w.h / 2.0,
    // rust: MouseButton::Left,
    // rust: )?;
    // rust: ok(json!({ "ok": true, "screen": self.screen_label() }))
}
    // rust: "pause" => {
    // rust: self.playing()?;
    // rust: self.key_pressed(KeyCode::Escape, KeyCode::Escape)?;
    // rust: ok(json!({ "ok": true, "screen": self.screen_label() }))
}
    // rust: "wait" => {
    // rust: self.need_world()?;
    // rust: let ticks: u64 = a.get(0, "TICKS")?.parse()?;
    // rust: let until_tick = self.ticks + ticks;
    // rust: let timeout = ticks as f64 / 20.0 * 4.0 + 10.0;
    // rust: self.start_task("wait", TaskKind::Wait { until_tick }, reply, timeout)
}
    // rust: "stop" => {
    // rust: let cancelled = self.agent.task.take().map(|t| {
    // rust: let _ = t.reply.send(
    // rust: json!({ "error": "cancelled by stop", "cancelled": true }).to_string(),
    // rust: );
    // rust: t.name
    // rust: });
    // rust: let turning = self.agent.glide.take().map(|g| {
    // rust: let _ = g.reply.send(
    // rust: json!({ "error": "cancelled by stop", "cancelled": true }).to_string(),
    // rust: );
    // rust: "turn"
    // rust: });
    // rust: let cancelled = cancelled.or(turning);
    // rust: self.release_agent_keys();
    // rust: ok(json!({ "ok": true, "cancelled": cancelled }))
}
    // rust: _ => Ok(Handled::No),
}
}

    /// Select the hotbar slot holding `item`.
pub fn select_item(self: *Self, item: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(i) =
    // rust: (0..9).find(|&i| self.inventory[i].as_ref().is_some_and(|s| &*s.item == item))
    // rust: {
    // rust: self.selected = i;
    // rust: return Ok(());
}
    // rust: if self.inventory.iter().flatten().any(|s| &*s.item == item) {
    // rust: return Err(format!(
    // rust: "{item} is in the main inventory, not the hotbar; move it with open-inventory and click-slot"
    // rust: )
    // rust: .into());
}
    // rust: Err(format!("no {item} in the inventory").into())
}

    /// Mouse motion turns the view only in the world with no screen open
    /// (`MouseHandler` turns the player while the mouse is grabbed).
pub fn turning(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.playing()?;
    // rust: if self.agent.glide.is_some() {
    // rust: return Err("already turning; wait for it or send stop".into());
}
    // rust: Ok(())
}

    // rust: fn start_glide(
    // rust: &mut self,
    // rust: total: (f64, f64),
    // rust: over: f64,
    // rust: aim: Option<&'static str>,
    // rust: reply: &Sender<String>,
    // rust: ) -> Result<Handled> {
    // rust: if !over.is_finite() || !(0.0..=60.0).contains(&over) {
    // rust: return Err("--over takes 0 to 60 seconds".into());
}
    // rust: if !(total.0.is_finite() && total.1.is_finite()) {
    // rust: return Err("the motion must be finite".into());
}
    // rust: let now = Instant::now();
    // rust: let over = Duration::from_secs_f64(over);
    // rust: self.agent.glide = Some(Glide {
    // rust: total,
    // rust: fed: (0.0, 0.0),
    // rust: started: now,
    // rust: over,
    // rust: fed_frame: self.frames,
    // rust: deadline: now + over + Duration::from_secs(10),
    // rust: reply: reply.clone(),
    // rust: aim,
    // rust: });
    // rust: self.advance_glide();
    // rust: Ok(Handled::Deferred)
}

    /// Feed the motion due by now (eased over the glide's time); reply once
    /// all of it has been turned by a frame.
pub fn advance_glide(self: *Self) void {
}
    // rust: let Some(mut g) = self.agent.glide.take() else {
    // rust: return;
}
    // rust: let done = |game: &Self, extra: Value| {
    // rust: let mut v = json!({
    // rust: "ok": true,
    // rust: "yaw": game.yaw,
    // rust: "pitch": game.pitch,
    // rust: "motion": [g.total.0, g.total.1],
    // rust: });
    // rust: if let (Value::Object(m), Value::Object(e)) = (&mut v, extra) {
    // rust: m.extend(e);
}
    // rust: v
}
    // rust: if let Err(e) = self.playing() {
    // rust: let _ = g.reply.send(
    // rust: json!({ "error": format!("stopped turning: {e}"), "yaw": self.yaw, "pitch": self.pitch })
    // rust: .to_string(),
    // rust: );
    // rust: return;
}
    // rust: let now = Instant::now();
    // rust: let t = if g.over.is_zero() {
    // rust: 1.0
    // rust: } else {
    // rust: now.duration_since(g.started).as_secs_f64() / g.over.as_secs_f64()
}
    // rust: let f = horizon_client::mouse::ease_in_out(t);
    // rust: let due = (g.total.0 * f, g.total.1 * f);
    // rust: let step = (due.0 - g.fed.0, due.1 - g.fed.1);
    // rust: if step != (0.0, 0.0) {
    // rust: self.mouse.add_motion(step.0, step.1);
    // rust: self.agent_pointer = true;
    // rust: g.fed = due;
    // rust: g.fed_frame = self.frames;
}
    // rust: if t >= 1.0 && self.frames > g.fed_frame {
    // rust: let extra = match g.aim {
    // rust: Some("block") | Some("entity") => json!({ "target": self.looking_at() }),
    // rust: _ => json!({}),
}
    // rust: let _ = g.reply.send(done(self, extra).to_string());
    // rust: return;
}
    // rust: if now >= g.deadline {
    // rust: let _ = g.reply.send(
    // rust: json!({ "error": "no frame was drawn to turn the view", "yaw": self.yaw, "pitch": self.pitch })
    // rust: .to_string(),
    // rust: );
    // rust: return;
}
    // rust: self.agent.glide = Some(g);
}

    /// Advance the running agent task; reply when it ends.
    // rust: pub(super) fn advance_agent(&mut self) {
    // rust: self.advance_glide();
    // rust: let Some(mut task) = self.agent.task.take() else {
    // rust: return;
}
    // rust: let timed_out = Instant::now() >= task.deadline;
    // rust: let result = self.step_task(&mut task.kind, timed_out);
    // rust: match result {
    // rust: Some(value) => {
    // rust: if task.kind.releases_input() {
    // rust: self.release_agent_keys();
}
    // rust: let _ = task.reply.send(value.to_string());
}
    // rust: None => self.agent.task = Some(task),
}
}

pub fn position(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player
    // rust: .as_ref()
    // rust: .map_or([0.0; 3], |p| [p.position.x, p.position.y, p.position.z])
}

    /// One frame of a task: Some(reply) when it is over.
pub fn step_task(self: *Self, kind: *mut TaskKind, timed_out: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
        // Leaving the world (death, a screen, the title) ends movement tasks.
    // rust: let interrupted = if self.title.is_some() || self.player.is_none() {
    // rust: Some("the world closed")
    // rust: } else if self.screen == Screen::Dead {
    // rust: Some("the player died")
    // rust: } else {
    // rust: None
}
    // rust: match kind {
    // rust: TaskKind::Move { keys, until, from } => {
    // rust: if let Some(why) = interrupted {
    // rust: return Some(json!({ "error": why, "position": self.position() }));
}
    // rust: for &k in keys.iter() {
    // rust: self.keys.press(k, Source::Agent);
}
    // rust: if Instant::now() < *until && !timed_out {
    // rust: return None;
}
    // rust: let to = self.position();
    // rust: Some(
    // rust: json!({ "ok": true, "from": [from.x, from.y, from.z], "position": to,
    // rust: "moved": dist([from.x, from.y, from.z], to) }),
    // rust: )
}
    // rust: TaskKind::Wait { until_tick } => {
    // rust: if self.ticks >= *until_tick {
    // rust: Some(json!({ "ok": true, "ticks": self.ticks }))
    // rust: } else if timed_out {
    // rust: Some(
    // rust: json!({ "error": "game ticks are not advancing (paused?)", "ticks": self.ticks }),
    // rust: )
    // rust: } else {
    // rust: None
}
}
    // rust: TaskKind::Jump {
    // rust: release_tick,
    // rust: from_y,
    // rust: } => {
    // rust: if self.ticks >= *release_tick || timed_out {
    // rust: self.keys.release(&KeyCode::Space, Source::Agent);
    // rust: let on_ground = self.player.as_ref().is_some_and(|p| p.ground.on_ground);
    // rust: if on_ground || timed_out {
    // rust: return Some(
    // rust: json!({ "ok": true, "from_y": from_y, "position": self.position() }),
    // rust: );
}
}
    // rust: None
}
    // rust: TaskKind::Goto(goto) => {
    // rust: if let Some(why) = interrupted {
    // rust: return Some(json!({ "error": why, "position": self.position() }));
}
    // rust: if self.screen != Screen::Playing {
    // rust: return Some(
    // rust: json!({ "error": format!("the {} screen opened", self.screen_label()), "position": self.position() }),
    // rust: );
}
    // rust: self.step_goto(goto, timed_out)
}
    // rust: TaskKind::Break(b) => self.step_break(b, timed_out, interrupted),
    // rust: TaskKind::Click {
    // rust: pos,
    // rust: before,
    // rust: inventory,
    // rust: report_tick,
    // rust: release,
    // rust: place,
    // rust: } => {
    // rust: if let Some(at) = release {
    // rust: if Instant::now() < *at && !timed_out && interrupted.is_none() {
    // rust: return None;
}
    // rust: let _ = self.agent_mouse(MouseButton::Right, false);
    // rust: *release = None;
    // rust: *report_tick = self.ticks + 2;
}
    // rust: if self.ticks < *report_tick && !timed_out {
    // rust: return None;
}
    // rust: let changed = match (*pos, *before) {
    // rust: (Some(p), Some(b)) => self.world.block(p[0], p[1], p[2]) != b,
    // rust: _ => false,
}
                // A client of a server (single player's server thread, a LAN
                // guest) sees the block once the server's answer comes.
    // rust: if *place
    // rust: && !changed
    // rust: && self.remote.is_some()
    // rust: && self.ticks < *report_tick + 20
    // rust: && !timed_out
    // rust: {
    // rust: return None;
}
    // rust: let after = pos.map(|p| self.block_json(p));
    // rust: let used = delta(inventory, &self.inventory_counts());
    // rust: let mut v = json!({
    // rust: "ok": !*place || changed,
    // rust: "block_before": before.map(|b| self.state_string(b)),
    // rust: "block": after,
    // rust: "changed": changed,
    // rust: "inventory_change": used,
    // rust: "screen": self.screen_label(),
    // rust: });
    // rust: if *place && !changed {
    // rust: v["error"] = json!(
    // rust: "the block did not change (blocked by an entity, or the item cannot be placed)"
    // rust: );
}
    // rust: Some(v)
}
    // rust: TaskKind::Attack {
    // rust: id,
    // rust: health,
    // rust: report_tick,
    // rust: } => {
    // rust: if self.ticks < *report_tick && !timed_out {
    // rust: return None;
}
    // rust: let now = id.and_then(|id| self.mobs.iter().find(|m| m.id == id));
    // rust: Some(json!({
    // rust: "ok": true,
    // rust: "target": id,
    // rust: "health_before": health,
    // rust: "health": now.map(|m| m.health),
    // rust: "alive": now.is_some_and(|m| m.alive()),
    // rust: "hit": id.is_some(),
    // rust: }))
}
}
}

pub fn step_goto(self: *Self, g: *mut Goto, timed_out: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = self.position();
    // rust: let on_ground = self.player.as_ref().is_some_and(|p| p.ground.on_ground);
    // rust: let horizontal =
    // rust: |a: [f64; 3], b: [f64; 3]| ((a[0] - b[0]).powi(2) + (a[2] - b[2]).powi(2)).sqrt();
    // rust: if navigation::arrived(p, g.target, g.near) {
    // rust: return Some(
    // rust: json!({ "ok": true, "arrived": true, "position": p, "target": g.target,
    // rust: "distance": dist(p, g.target), "warning": g.warning }),
    // rust: );
}
    // rust: if timed_out {
    // rust: return Some(
    // rust: json!({ "error": "timed out before arriving", "arrived": false, "position": p,
    // rust: "target": g.target, "distance": dist(p, g.target), "warning": g.warning }),
    // rust: );
}
    // rust: let previous_next = g.next;
    // rust: let mut aim = g.path.aim(p, &mut g.next, g.target);
    // rust: if let Some(aim) = aim {
    // rust: if g.next != previous_next {
    // rust: g.progress = Progress::new(p, aim);
    // rust: g.progress_tick = self.ticks;
    // rust: } else if g.progress.advance(p, aim) {
    // rust: g.progress_tick = self.ticks;
}
}
    // rust: let stalled = self.ticks.saturating_sub(g.progress_tick);
    // rust: if stalled > 60 && on_ground {
    // rust: g.jump_until = self.ticks + 4;
}
    // rust: if aim.is_none() || stalled > 120 {
    // rust: if stalled > 120 {
    // rust: g.replans += 1;
    // rust: if g.replans > 3 {
    // rust: return Some(
    // rust: json!({ "error": "stuck: cannot make progress", "arrived": false,
    // rust: "position": p, "target": g.target, "distance": dist(p, g.target) }),
    // rust: );
}
    // rust: if g.next > 0 && g.next < g.path.nodes.len() {
    // rust: let edge = (g.path.nodes[g.next - 1], g.path.nodes[g.next]);
    // rust: if edge.0 != edge.1 && !g.blocked.contains(&edge) {
    // rust: g.blocked.push(edge);
}
}
}
    // rust: let from = [
    // rust: p[0].floor() as i32,
    // rust: p[1].round() as i32,
    // rust: p[2].floor() as i32,
    // rust: ];
    // rust: let Some(path) = self.find_path(from, g.target, g.near, &g.blocked) else {
    // rust: return Some(
    // rust: json!({ "error": "no further walking progress through loaded terrain",
    // rust: "arrived": false, "position": p, "target": g.target,
    // rust: "distance": dist(p, g.target), "warning": g.warning }),
    // rust: );
}
    // rust: g.path = path;
    // rust: g.next = 1;
    // rust: g.progress_tick = self.ticks;
    // rust: aim = g.path.aim(p, &mut g.next, g.target);
    // rust: g.progress = Progress::new(p, aim.unwrap_or(g.target));
}
    // rust: let Some(aim) = aim else {
    // rust: return Some(
    // rust: json!({ "error": "path did not provide a new walking waypoint",
    // rust: "arrived": false, "position": p, "target": g.target }),
    // rust: );
}
    // rust: let d = [aim[0] - p[0], aim[2] - p[2]];
    // rust: if d[0].abs() + d[1].abs() > 1e-3 {
    // rust: self.yaw = (-d[0]).atan2(d[1]).to_degrees() as f32;
}
    // rust: self.keys.press(KeyCode::KeyW, Source::Agent);
    // rust: if g.sprint {
    // rust: self.keys.press(KeyCode::ControlLeft, Source::Agent);
}
        // Step up onto the next block, or out of water.
    // rust: let in_water = {
    // rust: let b = p.map(|v| v.floor() as i32);
    // rust: self.res
    // rust: .facts()
    // rust: .get(self.world.block(b[0], b[1], b[2]))
    // rust: .fluid
    // rust: != horizon_client::blocks::Fluid::None
}
    // rust: if aim[1] > p[1] + 0.5 && horizontal(p, aim) < 1.6 && on_ground {
    // rust: g.jump_until = self.ticks + 4;
}
    // rust: if self.ticks < g.jump_until || in_water {
    // rust: self.keys.press(KeyCode::Space, Source::Agent);
    // rust: } else {
    // rust: self.keys.release(&KeyCode::Space, Source::Agent);
}
    // rust: None
}

    // rust: fn step_break(
    // rust: &mut self,
    // rust: b: &mut Break,
    // rust: timed_out: bool,
    // rust: interrupted: Option<&str>,
    // rust: ) -> Option<Value> {
    // rust: let state = self.world.block(b.pos[0], b.pos[1], b.pos[2]);
    // rust: if b.collect_until.is_none() {
    // rust: if let Some(why) = interrupted {
    // rust: return Some(json!({ "error": why, "pos": b.pos }));
}
    // rust: if state != b.before {
                // Broken: collect what drops for a moment.
    // rust: let _ = self.agent_mouse(MouseButton::Left, false);
    // rust: b.broke_tick = self.ticks;
    // rust: b.collect_until = Some(self.ticks + 20);
    // rust: } else if timed_out {
    // rust: let _ = self.agent_mouse(MouseButton::Left, false);
    // rust: return Some(
    // rust: json!({ "error": "timed out before the block broke", "pos": b.pos,
    // rust: "block": self.state_string(state), "ticks": self.ticks - b.started_tick }),
    // rust: );
    // rust: } else if self.screen != Screen::Playing {
    // rust: return Some(
    // rust: json!({ "error": format!("the {} screen opened", self.screen_label()), "pos": b.pos }),
    // rust: );
    // rust: } else {
                // Keep the crosshair on the block (the player may drift).
    // rust: if self.pick().is_none_or(|h| h.pos != b.pos)
    // rust: && let Err(e) = self.aim_block(b.pos, None)
    // rust: {
    // rust: let _ = self.agent_mouse(MouseButton::Left, false);
    // rust: return Some(json!({ "error": e.to_string(), "pos": b.pos }));
}
    // rust: if !self.left {
    // rust: let _ = self.agent_mouse(MouseButton::Left, true);
}
    // rust: return None;
}
}
        // New item entities near the block are its drops.
    // rust: let centre = b.pos.map(|v| f64::from(v) + 0.5);
    // rust: for item in &self.dropped {
    // rust: if !b.items_before.contains(&item.id)
    // rust: && dist(centre, [item.position.x, item.position.y, item.position.z]) < 3.0
    // rust: {
    // rust: b.drops.insert(item.id, item.stack.clone());
}
}
    // rust: let remaining = b
    // rust: .drops
    // rust: .keys()
    // rust: .filter(|id| self.dropped.iter().any(|i| i.id == **id))
    // rust: .count();
    // rust: let until = b.collect_until.unwrap_or(0);
    // rust: if (self.ticks < until && (remaining > 0 || self.ticks < b.broke_tick + 3)) && !timed_out {
    // rust: return None;
}
    // rust: Some(json!({
    // rust: "ok": true,
    // rust: "pos": b.pos,
    // rust: "block_before": self.state_string(b.before),
    // rust: "block": self.state_string(state),
    // rust: "ticks": b.broke_tick - b.started_tick,
    // rust: "drops": counts(b.drops.values().cloned()),
    // rust: "picked_up": delta(&b.inventory, &self.inventory_counts()),
    // rust: "items_left_on_ground": remaining,
    // rust: "on_ground": self.dropped.iter().filter(|i| b.drops.contains_key(&i.id)).map(|i| json!({
    // rust: "id": i.id, "item": &*i.stack.item, "count": i.stack.count,
    // rust: "pos": [i.position.x, i.position.y, i.position.z],
    // rust: })).collect::<Vec<_>>(),
    // rust: }))
}
}

    // rust: mod tests {
//     use super::*;

pub fn only_wait_keeps_held_input() void {
}
    // rust: assert!(!TaskKind::Wait { until_tick: 40 }.releases_input());
    // rust: let jump = TaskKind::Jump {
    // rust: release_tick: 4,
    // rust: from_y: 64.0,
}
    // rust: assert!(jump.releases_input());
}

pub fn parses_flags_and_values() void {
}
    // rust: let a = parse_args(&["1", "2", "--near", "3", "--sprint", "--timeout=9", "-4"]);
    // rust: assert_eq!(a.pos, ["1", "2", "-4"]);
    // rust: assert_eq!(a.flags["near"], Some("3"));
    // rust: assert_eq!(a.flags["sprint"], None);
    // rust: assert_eq!(a.flags["timeout"], Some("9"));
    // rust: assert_eq!(a.num("near", 0.0).unwrap(), 3.0);
    // rust: assert_eq!(a.num("missing", 7.0).unwrap(), 7.0);
    // rust: assert!(a.f64(5, "X").is_err());
    // rust: assert_eq!(a.block_pos(0).ok(), Some([1, 2, -4]));
    // rust: assert!(a.block_pos(1).is_err());
    // rust: assert_eq!(
    // rust: parse_args(&["-1", "64", "2"]).block_pos(0).unwrap(),
    // rust: [-1, 64, 2]
    // rust: );
}

pub fn yaw_and_pitch_follow_minecraft() void {
}
    // rust: let (yaw, pitch) = yaw_pitch([0.0; 3], [0.0, 0.0, 1.0]);
    // rust: assert!(yaw.abs() < 1e-4 && pitch.abs() < 1e-4);
    // rust: let (yaw, _) = yaw_pitch([0.0; 3], [-1.0, 0.0, 0.0]);
    // rust: assert!((yaw - 90.0).abs() < 1e-4);
    // rust: let (_, pitch) = yaw_pitch([0.0; 3], [0.0, -1.0, 0.0]);
    // rust: assert!((pitch - 90.0).abs() < 1e-4);
}

pub fn faces_round_trip() void {
}
    // rust: for (name, dir) in FACES {
    // rust: assert_eq!(face_dir(name).unwrap(), dir);
    // rust: assert_eq!(face_name(dir), name);
}
    // rust: assert!(face_dir("sideways").is_err());
}

pub fn inventory_delta() void {
}
    // rust: let before = BTreeMap::from([("a".to_owned(), 2), ("b".to_owned(), 1)]);
    // rust: let after = BTreeMap::from([("a".to_owned(), 5), ("c".to_owned(), 1)]);
    // rust: let d = delta(&before, &after);
    // rust: assert_eq!(
    // rust: d,
    // rust: BTreeMap::from([
    // rust: ("a".to_owned(), 3),
    // rust: ("b".to_owned(), -1),
    // rust: ("c".to_owned(), 1)
    // rust: ])
    // rust: );
}
}
