//! Transpiled from Horizon Rust crate
package horizon_client_render_sculk

import "core:fmt"
import "core:mem"
import "core:math"

// Game events and the vibration system (`GameEvent`, `VibrationSystem`,
// `VibrationSelector`) shared by sculk sensors, shriekers and wardens, the
// sculk block entities and the per-player warden spawn tracker.
    // rust: pub use crate::chunk::block_entity::{Data, Info, SculkEntity, SculkKind, Selector};
// use horizon_client_core::who::Who;
// use horizon_core::{
    // rust: geometry::{Direction, Vec3, traverse_blocks},
    // rust: position::BlockPos,
}
// use horizon_world::{level::sculk::SculkSpreader, nbt::Tag};

// Every `GameEvent` with its `VibrationSystem` frequency (0: none).
    // rust: const EVENTS: &[(&str, i32)] = &[
    // rust: ("minecraft:step", 1),
    // rust: ("minecraft:swim", 1),
    // rust: ("minecraft:flap", 1),
    // rust: ("minecraft:projectile_land", 2),
    // rust: ("minecraft:hit_ground", 2),
    // rust: ("minecraft:splash", 2),
    // rust: ("minecraft:bounce", 2),
    // rust: ("minecraft:item_interact_finish", 3),
    // rust: ("minecraft:projectile_shoot", 3),
    // rust: ("minecraft:instrument_play", 3),
    // rust: ("minecraft:entity_action", 4),
    // rust: ("minecraft:elytra_glide", 4),
    // rust: ("minecraft:unequip", 4),
    // rust: ("minecraft:entity_dismount", 5),
    // rust: ("minecraft:equip", 5),
    // rust: ("minecraft:entity_interact", 6),
    // rust: ("minecraft:shear", 6),
    // rust: ("minecraft:entity_mount", 6),
    // rust: ("minecraft:entity_damage", 7),
    // rust: ("minecraft:drink", 8),
    // rust: ("minecraft:eat", 8),
    // rust: ("minecraft:container_close", 9),
    // rust: ("minecraft:block_close", 9),
    // rust: ("minecraft:block_deactivate", 9),
    // rust: ("minecraft:block_detach", 9),
    // rust: ("minecraft:container_open", 10),
    // rust: ("minecraft:block_open", 10),
    // rust: ("minecraft:block_activate", 10),
    // rust: ("minecraft:block_attach", 10),
    // rust: ("minecraft:prime_fuse", 10),
    // rust: ("minecraft:note_block_play", 10),
    // rust: ("minecraft:block_change", 11),
    // rust: ("minecraft:block_destroy", 12),
    // rust: ("minecraft:fluid_pickup", 12),
    // rust: ("minecraft:block_place", 13),
    // rust: ("minecraft:fluid_place", 13),
    // rust: ("minecraft:entity_place", 14),
    // rust: ("minecraft:lightning_strike", 14),
    // rust: ("minecraft:teleport", 14),
    // rust: ("minecraft:entity_die", 15),
    // rust: ("minecraft:explode", 15),
    // Events that exist but make no vibration frequency.
    // rust: ("minecraft:item_interact_start", 0),
    // rust: ("minecraft:jukebox_play", 0),
    // rust: ("minecraft:jukebox_stop_play", 0),
    // rust: ("minecraft:sculk_sensor_tendrils_clicking", 0),
    // rust: ("minecraft:shriek", 0),
    // rust: ];
// `GameEvent.RESONATE_1..15`.
    // rust: pub const RESONANCE: [&str; 15] = [
    // rust: "minecraft:resonate_1",
    // rust: "minecraft:resonate_2",
    // rust: "minecraft:resonate_3",
    // rust: "minecraft:resonate_4",
    // rust: "minecraft:resonate_5",
    // rust: "minecraft:resonate_6",
    // rust: "minecraft:resonate_7",
    // rust: "minecraft:resonate_8",
    // rust: "minecraft:resonate_9",
    // rust: "minecraft:resonate_10",
    // rust: "minecraft:resonate_11",
    // rust: "minecraft:resonate_12",
    // rust: "minecraft:resonate_13",
    // rust: "minecraft:resonate_14",
    // rust: "minecraft:resonate_15",
    // rust: ];
SHRIEK :: "minecraft:shriek"
TENDRILS_CLICKING :: "minecraft:sculk_sensor_tendrils_clicking"

// `VibrationSystem.getGameEventFrequency`.
frequency :: proc(event: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(i) = RESONANCE.iter().position(|e| *e == event) {
    // rust: return i as i32 + 1;
}
    // rust: EVENTS
    // rust: .iter()
    // rust: .find(|(name, _)| *name == event)
    // rust: .map_or(0, |(_, f)| *f)
}
// `GameEvent.notificationRadius`.
notification_radius :: proc(event: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match event {
    // rust: "minecraft:jukebox_play" | "minecraft:jukebox_stop_play" => 10,
    // rust: SHRIEK => 32,
    // rust: _ => 16,
}
}
// The identifier as a `'static` string, for loading saved events.
intern :: proc(event: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: RESONANCE
    // rust: .iter()
    // rust: .chain(EVENTS.iter().map(|(name, _)| name))
    // rust: .find(|e| **e == event)
    // rust: .copied()
}
// `GameEventTags.VIBRATIONS`: every event with a frequency, resonance and flap.
is_vibration :: proc(event: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: frequency(event) != 0
}
// `GameEventTags.SHRIEKER_CAN_LISTEN`.
shrieker_can_listen :: proc(event: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: event == TENDRILS_CLICKING
}
// `GameEventTags.WARDEN_CAN_LISTEN`: vibrations except flap, plus shrieks and
// tendril clicks.
warden_can_listen :: proc(event: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (is_vibration(event) && event != "minecraft:flap")
    // rust: || event == SHRIEK
    // rust: || shrieker_can_listen(event)
}
// `GameEventTags.ALLAY_CAN_LISTEN`: note block notes.
allay_can_listen :: proc(event: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: event == "minecraft:note_block_play"
}
// `GameEventTags.IGNORE_VIBRATIONS_SNEAKING`.
ignored_when_sneaking :: proc(event: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: event,
    // rust: "minecraft:hit_ground"
    // rust: | "minecraft:projectile_shoot"
    // rust: | "minecraft:step"
    // rust: | "minecraft:swim"
    // rust: | "minecraft:item_interact_start"
    // rust: | "minecraft:item_interact_finish"
    // rust: )
}
// `VibrationSystem.getRedstoneStrengthForDistance`.
redstone_strength :: proc(distance: f32, listener_radius: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let scale = 15.0 / f64::from(listener_radius);
    // rust: (15 - (scale * f64::from(distance)).floor() as i32).max(1)
}
// `SculkSensorBlock.RESONANCE_PITCH_BEND`: `NoteBlock.getPitchFromNote`.
resonance_pitch :: proc(frequency: i32) -> f {
    // Ported from Horizon
    return {}
}
TONES :: [0, 0, 2, 4, 6, 7, 9, 10, 12, 14, 15, 18, 19, 21, 22, 24]
    // rust: 2.0f32.powf((TONES[frequency.clamp(0, 15) as usize] - 12) as f32 / 12.0)
}

// What an event's source looks like to listeners, captured when it is
// posted (`GameEvent.Context` plus the entity facts listeners ask for).
Context :: struct {
    source: Maybe(Who),
    // The projectile's owner, when the source is a projectile.
    owner: Maybe(Who),
    // `affectedState` is in `dampens_vibrations`.
    dampening_state: bool,
    // The source is a spectator.
    spectator: bool,
    // `isSteppingCarefully` (sneaking).
    stepping_carefully: bool,
    // `dampensVibrations` (a warden).
    dampens: bool,
    // The source is a living entity wardens may target.
    targetable: bool,
    // The source is a living entity at all.
    living: bool,
    // The source is the player, rides with them, or is their projectile
    // (`SculkShriekerBlockEntity.tryGetPlayer`).
    player: bool,
}
// `VibrationSystem.User.isValidVibration` without the tag test.
valid_vibration :: proc(listens: bool, event: string, ctx: ^Context) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !listens {
    // rust: return false;
}
    // rust: if ctx.source.is_some() {
    // rust: if ctx.spectator {
    // rust: return false;
}
    // rust: if ctx.stepping_carefully && ignored_when_sneaking(event) {
    // rust: return false;
}
    // rust: if ctx.dampens {
    // rust: return false;
}
}
    // rust: !ctx.dampening_state
}

    // rust: impl Selector {
add_candidate :: proc(self: ^Self, new: Info, tick: i64) {
}
    // rust: if self.should_replace(&new, tick) {
    // rust: self.current = Some((new, tick));
}
}
should_replace :: proc(self: ^Self, new: ^Info, tick: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((previous, previous_tick)) = &self.current else {
    // rust: return true;
}
    // rust: if tick != *previous_tick {
    // rust: return false;
}
    // rust: if new.distance < previous.distance {
    // rust: true
    // rust: } else if new.distance > previous.distance {
    // rust: false
    // rust: } else {
    // rust: frequency(new.event) > frequency(previous.event)
}
}
chosen_candidate :: proc(self: ^Self, time: i64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.current
    // rust: .filter(|(_, tick)| *tick < time)
    // rust: .map(|(info, _)| info)
}
start_over :: proc(self: ^Self) {
}
    // rust: self.current = None;
}
    // The candidate kept so far and the tick it came in.
current :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.current
}
}
// What one `VibrationSystem.Ticker.tick` did.
Tick :: struct {
    // A vibration was chosen: its travel time (the particle starts).
    started: Option<(Info,
    // A vibration arrived.
    received: Maybe(Info),
    // `onDataChanged`.
    changed: bool,
}
    // rust: impl Data {
    // `Listener.handleGameEvent` once the user accepted the event.
schedule :: proc(self: ^Self, info: Info, game_time: i64) {
}
    // rust: self.selector.add_candidate(info, game_time);
}
    // `VibrationSystem.Ticker.tick`.
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: game_time: i64,
    // rust: chunks_ticking: bool,
    // rust: needs_ticking_chunks: bool,
    // rust: travel_time: impl Fn(f32) -> i32,
    // rust: ) -> Tick {
    // rust: let mut out = Tick::default();
    // rust: if self.current.is_none()
    // rust: && let Some(info) = self.selector.chosen_candidate(game_time)
    // rust: {
    // rust: self.current = Some(info);
    // rust: self.travel = travel_time(info.distance);
    // rust: out.started = Some((info, self.travel));
    // rust: out.changed = true;
    // rust: self.selector.start_over();
}
    // rust: if let Some(info) = self.current {
    // rust: let mut changed = self.travel > 0;
    // rust: self.travel = (self.travel - 1).max(0);
    // rust: if self.travel <= 0 {
    // rust: if needs_ticking_chunks && !chunks_ticking {
    // rust: changed = false;
    // rust: } else {
    // rust: out.received = Some(info);
    // rust: self.current = None;
    // rust: changed = true;
}
}
    // rust: out.changed |= changed;
}
    // rust: out
}
    // The `listener` compound (`VibrationSystem.Data.CODEC`).
to_nbt :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries: Vec<(&str, Tag)> = Vec::new();
    // rust: if let Some(info) = &self.current {
    // rust: entries.push(("event", info_to_nbt(info)));
}
    // rust: let mut selector: Vec<(&str, Tag)> = Vec::new();
    // rust: let chosen = self.selector.current;
    // rust: if let Some((info, _)) = &chosen {
    // rust: selector.push(("event", info_to_nbt(info)));
}
    // rust: selector.push(("tick", Tag::Long(chosen.map_or(-1, |(_, t)| t))));
    // rust: entries.push(("selector", Tag::compound(selector)));
    // rust: entries.push(("event_delay", Tag::Int(self.travel)));
    // rust: Tag::compound(entries)
}
from_nbt :: proc(tag: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut data = Self {
    // rust: current: tag.get("event").and_then(info_from_nbt),
    // rust: ..Self::default()
}
    // rust: if let Some(Tag::Int(t)) = tag.get("event_delay") {
    // rust: data.travel = (*t).max(0);
}
    // rust: if let Some(selector) = tag.get("selector") {
    // rust: let info = selector.get("event").and_then(info_from_nbt);
    // rust: let tick = match selector.get("tick") {
    // rust: Some(Tag::Long(t)) => *t,
    // rust: _ => -1,
}
    // rust: data.selector.current = info.map(|i| (i, tick));
}
    // rust: data
}
}
info_to_nbt :: proc(info: ^Info) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound(vec![
    // rust: ("game_event", Tag::String(info.event.into())),
    // rust: ("distance", Tag::Float(info.distance.to_bits())),
    // rust: (
    // rust: "pos",
    // rust: Tag::List(info.pos.iter().map(|v| Tag::Double(v.to_bits())).collect()),
    // rust: ),
    // rust: ])
}
info_from_nbt :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let event = intern(&horizon_client_core::nbt_value::text(
    // rust: tag.get("game_event"),
    // rust: )?)?;
    // rust: let distance = match tag.get("distance") {
    // rust: Some(Tag::Float(f)) => f32::from_bits(*f),
    // rust: _ => 0.0,
}
    // rust: let pos = match tag.get("pos") {
    // rust: Some(Tag::List(v)) if v.len() == 3 => {
    // rust: let mut p = [0.0; 3];
    // rust: for (i, t) in v.iter().enumerate() {
    // rust: if let Tag::Double(d) = t {
    // rust: p[i] = f64::from_bits(*d);
}
}
    // rust: p
}
    // rust: _ => return None,
}
    // rust: Some(Info {
    // rust: event,
    // rust: distance,
    // rust: pos,
    // rust: source: None,
    // rust: owner: None,
    // rust: })
}

// `Listener.isOccluded`: whether wool-like blocks block every line between
// the centres of the source and listener blocks (nudged one direction each).
    // rust: pub fn is_occluded(
    // rust: origin: [f64; 3],
    // rust: dest: [f64; 3],
    // rust: mut occludes: impl FnMut(BlockPos) -> bool,
    // rust: ) -> bool {
    // rust: let centre =
    // rust: |p: [f64; 3]| Vec3::new(p[0].floor() + 0.5, p[1].floor() + 0.5, p[2].floor() + 0.5);
    // rust: let from = centre(origin);
    // rust: let to = centre(dest);
    // rust: for direction in Direction::ALL {
    // rust: let nudged = from.relative(direction, f64::from(1.0e-5f32));
    // rust: let hit = traverse_blocks(nudged, to, 512, |p| occludes(p).then_some(()));
    // rust: if !matches!(hit, Ok(Some(()))) {
    // rust: return false;
}
}
    // rust: true
}

    // rust: impl SculkEntity {
new :: proc(kind: SculkKind) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: kind,
    // rust: vibration: Data::default(),
    // rust: last_frequency: 0,
    // rust: warning_level: 0,
    // rust: spreader: SculkSpreader::default(),
}
}
    // Whether its block entity tick does nothing: no vibration chosen
    // or on its way, none waiting to be chosen, and no charge to spread.
idle :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.vibration.current.is_none()
    // rust: && self.vibration.selector.current().is_none()
    // rust: && self.spreader.cursors.is_empty()
}
for_block :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Self::new(match name {
    // rust: "minecraft:sculk_sensor" => SculkKind::Sensor,
    // rust: "minecraft:calibrated_sculk_sensor" => SculkKind::Calibrated,
    // rust: "minecraft:sculk_shrieker" => SculkKind::Shrieker,
    // rust: "minecraft:sculk_catalyst" => SculkKind::Catalyst,
    // rust: _ => return None,
    // rust: }))
}
id :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self.kind {
    // rust: SculkKind::Sensor => "minecraft:sculk_sensor",
    // rust: SculkKind::Calibrated => "minecraft:calibrated_sculk_sensor",
    // rust: SculkKind::Shrieker => "minecraft:sculk_shrieker",
    // rust: SculkKind::Catalyst => "minecraft:sculk_catalyst",
}
}
    // `VibrationSystem.User.getListenerRadius`.
listener_radius :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self.kind {
    // rust: SculkKind::Calibrated => 16,
    // rust: SculkKind::Sensor | SculkKind::Shrieker | SculkKind::Catalyst => 8,
}
}
    // The block entity's saved fields.
to_nbt :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match self.kind {
    // rust: SculkKind::Sensor | SculkKind::Calibrated => vec![
    // rust: ("last_vibration_frequency", Tag::Int(self.last_frequency)),
    // rust: ("listener", self.vibration.to_nbt()),
    // rust: ],
    // rust: SculkKind::Shrieker => vec![
    // rust: ("warning_level", Tag::Int(self.warning_level)),
    // rust: ("listener", self.vibration.to_nbt()),
    // rust: ],
    // rust: SculkKind::Catalyst => vec![("cursors", cursors_to_nbt(&self.spreader))],
}
}
load :: proc(self: ^Self, tag: ^Tag) {
}
    // rust: match self.kind {
    // rust: SculkKind::Sensor | SculkKind::Calibrated => {
    // rust: if let Some(Tag::Int(f)) = tag.get("last_vibration_frequency") {
    // rust: self.last_frequency = *f;
}
    // rust: if let Some(l) = tag.get("listener") {
    // rust: self.vibration = Data::from_nbt(l);
}
}
    // rust: SculkKind::Shrieker => {
    // rust: if let Some(Tag::Int(w)) = tag.get("warning_level") {
    // rust: self.warning_level = *w;
}
    // rust: if let Some(l) = tag.get("listener") {
    // rust: self.vibration = Data::from_nbt(l);
}
}
    // rust: SculkKind::Catalyst => {
    // rust: if let Some(c) = tag.get("cursors") {
    // rust: self.spreader = cursors_from_nbt(c);
}
}
}
}
}
cursors_to_nbt :: proc(spreader: ^SculkSpreader) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::List(
    // rust: spreader
    // rust: .cursors
    // rust: .iter()
    // rust: .map(|c| {
    // rust: let mut e: Vec<(&str, Tag)> = vec![
    // rust: ("pos", Tag::IntArray(vec![c.pos.x, c.pos.y, c.pos.z])),
    // rust: ("charge", Tag::Int(c.charge)),
    // rust: ("decay_delay", Tag::Int(c.decay_delay)),
    // rust: ("update_delay", Tag::Int(c.update_delay)),
    // rust: ];
    // rust: if let Some(faces) = &c.facings {
    // rust: e.push((
    // rust: "facings",
    // rust: Tag::List(
    // rust: faces
    // rust: .iter()
    // rust: .map(|d| Tag::String(direction_name(*d).into()))
    // rust: .collect(),
    // rust: ),
    // rust: ));
}
    // rust: Tag::compound(e)
    // rust: })
    // rust: .collect(),
    // rust: )
}
cursors_from_nbt :: proc(tag: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
//     use horizon_world::level::sculk::ChargeCursor;
    // rust: let mut spreader = SculkSpreader::default();
    // rust: let Tag::List(items) = tag else {
    // rust: return spreader;
}
    // rust: for item in items.iter().take(32) {
    // rust: let Some(Tag::IntArray(p)) = item.get("pos") else {
    // rust: continue;
}
    // rust: if p.len() != 3 {
    // rust: continue;
}
    // rust: let int = |k: &str, default: i32| match item.get(k) {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: _ => default,
}
    // rust: let facings = match item.get("facings") {
    // rust: Some(Tag::List(v)) => Some(
    // rust: v.iter()
    // rust: .filter_map(|t| match t {
    // rust: Tag::String(s) => direction_from_name(&String::from_utf16_lossy(&s.0)),
    // rust: _ => None,
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: _ => None,
}
    // rust: spreader.add_cursor(ChargeCursor {
    // rust: pos: BlockPos::new(p[0], p[1], p[2]),
    // rust: charge: int("charge", 0).clamp(0, 1000),
    // rust: update_delay: int("update_delay", 0).max(0),
    // rust: decay_delay: int("decay_delay", 1).clamp(0, 1),
    // rust: facings,
    // rust: });
}
    // rust: spreader
}
direction_name :: proc(d: Direction) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match d {
    // rust: Direction::Down => "down",
    // rust: Direction::Up => "up",
    // rust: Direction::North => "north",
    // rust: Direction::South => "south",
    // rust: Direction::West => "west",
    // rust: Direction::East => "east",
}
}
direction_from_name :: proc(s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Direction::ALL.into_iter().find(|d| direction_name(*d) == s)
}

// `WardenSpawnTracker`: a player's warning level toward summoning a warden.
WardenSpawnTracker :: struct {
    ticks_since_last_warning: i32,
    warning_level: i32,
    cooldown_ticks: i32,
}
    // rust: impl WardenSpawnTracker {
MAX_WARNING_LEVEL :: 4
DECREASE_EVERY :: 12000
INCREASE_COOLDOWN :: 200
tick :: proc(self: ^Self) {
}
    // rust: if self.ticks_since_last_warning >= Self::DECREASE_EVERY {
    // rust: self.set_warning_level(self.warning_level - 1);
    // rust: self.ticks_since_last_warning = 0;
    // rust: } else {
    // rust: self.ticks_since_last_warning += 1;
}
    // rust: if self.cooldown_ticks > 0 {
    // rust: self.cooldown_ticks -= 1;
}
}
reset :: proc(self: ^Self) {
}
    // rust: *self = Self::default();
}
on_cooldown :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.cooldown_ticks > 0
}
    // `increaseWarningLevel`.
increase_warning_level :: proc(self: ^Self) {
}
    // rust: if !self.on_cooldown() {
    // rust: self.ticks_since_last_warning = 0;
    // rust: self.cooldown_ticks = Self::INCREASE_COOLDOWN;
    // rust: self.set_warning_level(self.warning_level + 1);
}
}
set_warning_level :: proc(self: ^Self, level: i32) {
}
    // rust: self.warning_level = level.clamp(0, Self::MAX_WARNING_LEVEL);
}
    // `WardenSpawnTracker.tryWarn` over the trackers of the players around a
    // shrieker (the triggering player included): the new warning level, or
    // None when a warden is near or a player is cooling down. Every tracker
    // takes over the highest one.
try_warn :: proc(trackers: ^[WardenSpawnTracker], warden_nearby: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if warden_nearby || trackers.iter().any(|t| t.on_cooldown()) {
    // rust: return None;
}
        // Stream.max keeps the last of equal maxima.
    // rust: let index = trackers
    // rust: .iter()
    // rust: .enumerate()
    // rust: .max_by_key(|(i, t)| (t.warning_level, *i))
    // rust: .map(|(i, _)| i)?;
    // rust: trackers[index].increase_warning_level();
    // rust: let copy = trackers[index];
    // rust: for t in trackers.iter_mut() {
    // rust: *t = copy;
}
    // rust: Some(copy.warning_level)
}
to_nbt :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound(vec![
    // rust: (
    // rust: "ticks_since_last_warning",
    // rust: Tag::Int(self.ticks_since_last_warning),
    // rust: ),
    // rust: ("warning_level", Tag::Int(self.warning_level)),
    // rust: ("cooldown_ticks", Tag::Int(self.cooldown_ticks)),
    // rust: ])
}
from_nbt :: proc(tag: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let int = |k: &str| match tag.get(k) {
    // rust: Some(Tag::Int(v)) => (*v).max(0),
    // rust: _ => 0,
}
    // rust: Self {
    // rust: ticks_since_last_warning: int("ticks_since_last_warning"),
    // rust: warning_level: int("warning_level").min(Self::MAX_WARNING_LEVEL),
    // rust: cooldown_ticks: int("cooldown_ticks"),
}
}
}

    // rust: mod tests {
//     use super::*;

info :: proc(event: ^'static str, distance: f32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: Info {
    // rust: event,
    // rust: distance,
    // rust: pos: [0.0; 3],
    // rust: source: None,
    // rust: owner: None,
}
}

frequencies_match_the_vanilla_table :: proc() {
}
    // rust: assert_eq!(frequency("minecraft:step"), 1);
    // rust: assert_eq!(frequency("minecraft:hit_ground"), 2);
    // rust: assert_eq!(frequency("minecraft:projectile_shoot"), 3);
    // rust: assert_eq!(frequency("minecraft:entity_damage"), 7);
    // rust: assert_eq!(frequency("minecraft:eat"), 8);
    // rust: assert_eq!(frequency("minecraft:block_open"), 10);
    // rust: assert_eq!(frequency("minecraft:block_change"), 11);
    // rust: assert_eq!(frequency("minecraft:block_place"), 13);
    // rust: assert_eq!(frequency("minecraft:explode"), 15);
    // rust: assert_eq!(frequency("minecraft:resonate_9"), 9);
    // rust: assert_eq!(frequency("minecraft:shriek"), 0);
    // rust: assert_eq!(frequency(TENDRILS_CLICKING), 0);
    // rust: assert_eq!(frequency("minecraft:jukebox_play"), 0);
    // rust: assert_eq!(frequency("minecraft:made_up"), 0);
}

event_tables_cover_resonance :: proc() {
}
    // rust: for (i, name) in RESONANCE.iter().enumerate() {
    // rust: assert_eq!(frequency(name), i as i32 + 1, "{name}");
    // rust: assert!(is_vibration(name));
    // rust: assert!(warden_can_listen(name));
}
    // rust: assert!(warden_can_listen(SHRIEK));
    // rust: assert!(warden_can_listen(TENDRILS_CLICKING));
    // rust: assert!(!warden_can_listen("minecraft:flap"));
    // rust: assert!(is_vibration("minecraft:flap"));
    // rust: assert!(shrieker_can_listen(TENDRILS_CLICKING));
    // rust: assert!(!shrieker_can_listen("minecraft:step"));
    // rust: assert_eq!(notification_radius(SHRIEK), 32);
    // rust: assert_eq!(notification_radius("minecraft:jukebox_play"), 10);
    // rust: assert_eq!(notification_radius("minecraft:step"), 16);
}

redstone_strength_falls_with_distance :: proc() {
}
    // rust: assert_eq!(redstone_strength(0.0, 8), 15);
    // rust: assert_eq!(redstone_strength(1.0, 8), 14);
    // rust: assert_eq!(redstone_strength(4.0, 8), 8);
    // rust: assert_eq!(redstone_strength(8.0, 8), 1);
    // rust: assert_eq!(redstone_strength(8.0, 16), 8);
    // rust: assert_eq!(redstone_strength(16.0, 16), 1);
}

selector_prefers_the_nearest_then_the_loudest :: proc() {
}
    // rust: let mut s = Selector::default();
    // rust: s.add_candidate(info("minecraft:step", 5.0), 10);
    // rust: s.add_candidate(info("minecraft:eat", 6.0), 10);
    // rust: assert_eq!(s.chosen_candidate(11).unwrap().event, "minecraft:step");
    // rust: s.add_candidate(info("minecraft:block_place", 5.0), 10);
    // rust: assert_eq!(
    // rust: s.chosen_candidate(11).unwrap().event,
    // rust: "minecraft:block_place"
    // rust: );
    // rust: s.add_candidate(info("minecraft:eat", 2.0), 10);
    // rust: assert_eq!(s.chosen_candidate(11).unwrap().event, "minecraft:eat");
        // A later tick never replaces the pending candidate.
    // rust: s.add_candidate(info("minecraft:explode", 0.0), 11);
    // rust: assert_eq!(s.chosen_candidate(11).unwrap().event, "minecraft:eat");
        // It is chosen only on a later tick than it was posted.
    // rust: assert!(s.chosen_candidate(10).is_none());
    // rust: s.start_over();
    // rust: assert!(s.chosen_candidate(12).is_none());
}

vibrations_travel_one_block_per_tick :: proc() {
}
    // rust: let mut d = Data::default();
    // rust: d.schedule(info("minecraft:step", 3.2), 100);
    // rust: let travel = |distance: f32| distance.floor() as i32;
        // Posted this tick: nothing yet.
    // rust: let t = d.tick(100, true, true, travel);
    // rust: assert_eq!(t, Tick::default());
        // Chosen next tick with a travel time of three.
    // rust: let t = d.tick(101, true, true, travel);
    // rust: assert_eq!(t.started.map(|(_, n)| n), Some(3));
    // rust: assert!(t.received.is_none());
    // rust: assert!(d.tick(102, true, true, travel).received.is_none());
    // rust: let t = d.tick(103, true, true, travel);
    // rust: assert_eq!(t.received.map(|i| i.event), Some("minecraft:step"));
    // rust: assert!(d.current.is_none());
}

nearby_vibrations_arrive_at_once :: proc() {
}
    // rust: let mut d = Data::default();
    // rust: d.schedule(info("minecraft:eat", 0.4), 5);
    // rust: let t = d.tick(6, true, true, |x| x.floor() as i32);
    // rust: assert!(t.started.is_some());
    // rust: assert!(t.received.is_some());
}

unloaded_neighbours_hold_a_vibration_back :: proc() {
}
    // rust: let mut d = Data::default();
    // rust: d.schedule(info("minecraft:eat", 0.0), 5);
    // rust: let t = d.tick(6, false, true, |_| 0);
    // rust: assert!(t.started.is_some());
    // rust: assert!(t.received.is_none());
    // rust: assert!(d.current.is_some());
    // rust: let t = d.tick(7, true, true, |_| 0);
    // rust: assert!(t.received.is_some());
        // Entities do not need the neighbours.
    // rust: d.schedule(info("minecraft:eat", 0.0), 8);
    // rust: assert!(d.tick(9, false, false, |_| 0).received.is_some());
}

vibration_data_round_trips_through_nbt :: proc() {
}
    // rust: let mut d = Data::default();
    // rust: d.schedule(info("minecraft:block_destroy", 4.0), 40);
    // rust: d.tick(41, true, true, |x| x as i32);
    // rust: d.schedule(info("minecraft:step", 2.0), 41);
    // rust: let back = Data::from_nbt(&d.to_nbt());
    // rust: assert_eq!(back.travel, d.travel);
    // rust: assert_eq!(back.current.map(|i| i.event), d.current.map(|i| i.event));
    // rust: assert_eq!(back.selector.current.map(|(_, t)| t), Some(41));
}

wool_on_the_line_occludes :: proc() {
}
    // rust: let origin = [0.5, 0.5, 0.5];
    // rust: let dest = [4.5, 0.5, 0.5];
        // A full wall of wool between them blocks all six nudged lines.
    // rust: let wall = |p: BlockPos| p.x == 2;
    // rust: assert!(is_occluded(origin, dest, wall));
        // One wool block on the line blocks the nudged lines too.
    // rust: let single = |p: BlockPos| p == BlockPos::new(2, 0, 0);
    // rust: assert!(is_occluded(origin, dest, single));
        // Wool off to the side lets the vibration through.
    // rust: let aside = |p: BlockPos| p == BlockPos::new(2, 1, 0);
    // rust: assert!(!is_occluded(origin, dest, aside));
    // rust: assert!(!is_occluded(origin, dest, |_| false));
}

sneaking_ignores_footsteps_but_not_damage :: proc() {
}
    // rust: let sneaking = Context {
    // rust: source: Some(Who::Player),
    // rust: stepping_carefully: true,
    // rust: ..Context::default()
}
    // rust: assert!(!valid_vibration(true, "minecraft:step", &sneaking));
    // rust: assert!(!valid_vibration(true, "minecraft:hit_ground", &sneaking));
    // rust: assert!(valid_vibration(true, "minecraft:entity_damage", &sneaking));
    // rust: let wardenish = Context {
    // rust: source: Some(Who::Mob(1)),
    // rust: dampens: true,
    // rust: ..Context::default()
}
    // rust: assert!(!valid_vibration(
    // rust: true,
    // rust: "minecraft:entity_damage",
    // rust: &wardenish
    // rust: ));
    // rust: let on_wool = Context {
    // rust: dampening_state: true,
    // rust: ..Context::default()
}
    // rust: assert!(!valid_vibration(true, "minecraft:block_place", &on_wool));
    // rust: assert!(!valid_vibration(
    // rust: false,
    // rust: "minecraft:step",
    // rust: &Context::default()
    // rust: ));
}

resonance_pitch_follows_the_tone_map :: proc() {
}
    // rust: assert!((resonance_pitch(0) - 0.5).abs() < 1e-6);
    // rust: assert!((resonance_pitch(4) - 2.0f32.powf(-6.0 / 12.0)).abs() < 1e-6);
    // rust: assert!((resonance_pitch(15) - 2.0).abs() < 1e-6);
}

warning_levels_rise_with_a_cooldown_and_decay :: proc() {
}
    // rust: let mut t = WardenSpawnTracker::default();
    // rust: t.increase_warning_level();
    // rust: assert_eq!(t.warning_level, 1);
    // rust: assert_eq!(t.cooldown_ticks, 200);
        // Cooling down: no increase.
    // rust: t.increase_warning_level();
    // rust: assert_eq!(t.warning_level, 1);
    // rust: for _ in 0..200 {
    // rust: t.tick();
}
    // rust: t.increase_warning_level();
    // rust: assert_eq!(t.warning_level, 2);
    // rust: t.set_warning_level(9);
    // rust: assert_eq!(t.warning_level, 4);
    // rust: t.cooldown_ticks = 0;
    // rust: t.ticks_since_last_warning = 12000;
    // rust: t.tick();
    // rust: assert_eq!(t.warning_level, 3);
    // rust: assert_eq!(t.ticks_since_last_warning, 0);
}

nearby_players_share_the_highest_warning :: proc() {
}
    // rust: let mut trackers = [
    // rust: WardenSpawnTracker::default(),
    // rust: WardenSpawnTracker {
    // rust: warning_level: 2,
    // rust: ..Default::default()
    // rust: },
    // rust: ];
    // rust: assert_eq!(WardenSpawnTracker::try_warn(&mut trackers, true), None);
    // rust: assert_eq!(WardenSpawnTracker::try_warn(&mut trackers, false), Some(3));
    // rust: assert_eq!(trackers[0], trackers[1]);
    // rust: assert_eq!(trackers[0].cooldown_ticks, 200);
        // Everyone is cooling down now.
    // rust: assert_eq!(WardenSpawnTracker::try_warn(&mut trackers, false), None);
}

cursors_round_trip :: proc() {
}
    // rust: let mut e = SculkEntity::new(SculkKind::Catalyst);
    // rust: e.spreader.add_cursors(BlockPos::new(3, 4, 5), 1500);
    // rust: e.spreader.cursors[1].facings = Some(vec![Direction::Up, Direction::East]);
    // rust: let tag = Tag::compound(e.to_nbt());
    // rust: let mut back = SculkEntity::new(SculkKind::Catalyst);
    // rust: back.load(&tag);
    // rust: assert_eq!(back.spreader, e.spreader);
    // rust: assert_eq!(back.spreader.cursors[0].charge, 1000);
    // rust: assert_eq!(back.spreader.cursors[1].charge, 500);
}
}
