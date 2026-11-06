//! Transpiled from Horizon Rust crate
//! Module: horizon-client_anticheat
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The anticheat on a dedicated server's hub (docs/anticheat.md): the checks run where the hub handles
//! what players send, and a flag is carried out here (send back, alert, kick, or a ban the game adds to
//! `banned-players.json`: [`HostEvent::Ban`]). The rules and the
//! violation levels are `horizon_anticheat`'s. A dedicated server has it on by default; the hub holds
//! none of this when `server.toml` turns it off (or for a LAN world), and then does exactly what vanilla's
//! server does.
// use super::hub::{HostEvent, Hub, TickCtx};
// use crate::collisions::SceneCollisions;
// use horizon_anticheat::{Check, Config, Strikes};
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_world::nbt::{JavaString, Tag};
// use std::{io::Write, time::Instant};

pub const Anticheat = struct {
    config: Config,
    /// `log`, opened at the first flag.
    log: ?std::fs::File,
    /// The players' kicks by check, read from `strikes` at the first kick.
    strikes: ?Strikes,
    /// When the previous server tick started, for the timer's balance.
    last_tick: ?Instant,
    tick_rate: f32,
};

    // rust: impl Anticheat {
pub fn new(config: Config) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: config,
    // rust: log: None,
    // rust: strikes: None,
    // rust: last_tick: None,
    // rust: tick_rate: 20.0,
}
}

pub fn write_log(self: *Self, line: []const u8) void {
}
    // rust: if self.config.log.is_empty() {
    // rust: return;
}
    // rust: if self.log.is_none() {
    // rust: let path = std::path::Path::new(&self.config.log);
    // rust: if let Some(dir) = path.parent() {
    // rust: let _ = std::fs::create_dir_all(dir);
}
    // rust: self.log = std::fs::OpenOptions::new()
    // rust: .create(true)
    // rust: .append(true)
    // rust: .open(path)
    // rust: .ok();
}
    // rust: if let Some(file) = &mut self.log {
    // rust: let time = chrono::Local::now().format("%Y-%m-%d %H:%M:%S");
    // rust: let _ = writeln!(file, "[{time}] {line}");
}
}

    /// Player `uuid` was kicked by `check`: its kicks by it so far and whether this one bans. The
    /// count is saved at once, so a restart doesn't forgive it.
pub fn strike(self: *Self, uuid: u128, check: Check) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = std::path::Path::new(&self.config.strikes);
    // rust: let strikes = self.strikes.get_or_insert_with(|| {
    // rust: std::fs::read(path)
    // rust: .ok()
    // rust: .and_then(|bytes| serde_json::from_slice(&bytes).ok())
    // rust: .unwrap_or_default()
    // rust: });
    // rust: let ban_after = self.config.actions(check).ban_after;
    // rust: let kick = strikes.kick(&uuid_text(uuid), check, ban_after);
    // rust: if !self.config.strikes.is_empty()
    // rust: && let Ok(json) = serde_json::to_vec_pretty(strikes)
    // rust: {
    // rust: let _ = std::fs::write(path, json);
}
    // rust: kick
}
}

/// A UUID as `banned-players.json` writes it.
pub fn uuid_text(uuid: u128) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = format!("{uuid:032x}");
    // rust: format!(
    // rust: "{}-{}-{}-{}-{}",
    // rust: &h[..8],
    // rust: &h[8..12],
    // rust: &h[12..16],
    // rust: &h[16..20],
    // rust: &h[20..]
    // rust: )
}

/// Server ticks a claim of the ground keeps its height after the ground last held the player.
pub const GROUND_GRACE: u64 = 10;

/// Whether an entity of `kind` at `at` may carry a player standing at `player`: the entities players
/// stand on (boats, rafts, minecarts, shulkers, happy ghasts, 4 blocks tall), within 4 blocks sideways and
/// from a block above the player to a little more than a happy ghast's height below.
pub fn carries_player(kind: []const u8, at: [f64; 3], player: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let carrier = kind.ends_with("boat")
    // rust: || kind.ends_with("raft")
    // rust: || kind.contains("minecart")
    // rust: || kind == "minecraft:shulker"
    // rust: || kind == "minecraft:happy_ghast";
    // rust: let up = player[1] - at[1];
    // rust: carrier
    // rust: && (at[0] - player[0]).abs() < 4.0
    // rust: && (at[2] - player[2]).abs() < 4.0
    // rust: && (-1.0..=4.5).contains(&up)
}

pub fn text(s: []const u8, color: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([
    // rust: ("text", Tag::String(JavaString::from(s))),
    // rust: ("color", Tag::String(JavaString::from(color))),
    // rust: ])
}

    // rust: impl Hub {
    /// Turn the anticheat on with these settings, or off (`config.enabled` false).
pub fn set_anticheat(self: *Self, config: Config) void {
}
    // rust: self.anticheat = config.enabled.then(|| Box::new(Anticheat::new(config)));
}

    /// The start of a server tick: the time since the previous one fills each player's timer balance.
    // rust: pub(super) fn anticheat_tick(&mut self, tick_rate: f32) {
    // rust: let Some(ac) = self.anticheat.as_deref_mut() else {
    // rust: return;
}
    // rust: let now = Instant::now();
    // rust: let elapsed = ac.last_tick.replace(now).map(|t| now - t);
    // rust: if !ac.config.runs(Check::Timer) {
    // rust: return;
}
        // A new tick rate reaches the client a little later: both start again.
    // rust: let restart = ac.tick_rate != tick_rate;
    // rust: ac.tick_rate = tick_rate;
    // rust: let ms = elapsed.map_or(0.0, |e| e.as_secs_f64() * 1000.0);
    // rust: for g in &mut self.guests {
    // rust: if restart {
    // rust: g.anticheat.timer.reset();
}
    // rust: g.anticheat.timer.elapse(ms, &ac.config.timer);
}
}

    /// ServerboundClientTickEndPacket: one client tick spent.
    // rust: pub(super) fn anticheat_tick_end(&mut self, i: usize, events: &mut Vec<HostEvent>) {
    // rust: let Some(ac) = self.anticheat.as_deref() else {
    // rust: return;
}
    // rust: if ac.config.runs(Check::Combat)
    // rust: && let Some(foul) = self.guests[i].anticheat.attacks.tick_end()
    // rust: {
    // rust: self.combat_foul(i, foul, events);
}
    // rust: let Some(ac) = self.anticheat.as_deref() else {
    // rust: return;
}
    // rust: if ac.config.runs(Check::Prediction) {
    // rust: let g = &mut self.guests[i];
    // rust: let (input, sprinting) = (g.input, g.anticheat.sprinting);
    // rust: g.anticheat
    // rust: .record
    // rust: .get_or_insert_default()
    // rust: .tick_end(input, sprinting);
}
    // rust: if !ac.config.runs(Check::Timer) {
    // rust: return;
}
    // rust: let (rate, config) = (ac.tick_rate, &ac.config.timer);
    // rust: if let Some(ahead) = self.guests[i].anticheat.timer.tick_end(rate, config) {
    // rust: self.flag(
    // rust: i,
    // rust: Check::Timer,
    // rust: 1.0,
    // rust: &format!("{ahead:.0} ms ahead"),
    // rust: events,
    // rust: );
}
}

    /// ServerboundAttackPacket on entity `target`: `combat`. Returns whether the attack is dropped:
    /// from `setback` on, every attack is, until the level decays below it.
    // rust: pub(super) fn anticheat_attack(
    // rust: &mut self,
    // rust: i: usize,
    // rust: target: i32,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) -> bool {
    // rust: let Some(ac) = self.anticheat.as_deref() else {
    // rust: return false;
}
    // rust: if !ac.config.runs(Check::Combat) {
    // rust: return false;
}
    // rust: if let Some(foul) = self.guests[i].anticheat.attacks.attack(target)
    // rust: && self.combat_foul(i, foul, events)
    // rust: {
    // rust: return true;
}
    // rust: let Some(ac) = self.anticheat.as_deref() else {
    // rust: return false;
}
    // rust: let setback = ac.config.combat.setback;
    // rust: setback > 0.0
    // rust: && self.guests[i]
    // rust: .anticheat
    // rust: .vl(&ac.config, Check::Combat, self.ticks)
    // rust: >= setback
}

    /// ServerboundPunchPacket: the arm swung, for `combat`.
    // rust: pub(super) fn anticheat_swing(&mut self, i: usize) {
    // rust: if self.anticheat.is_some() {
    // rust: self.guests[i].anticheat.attacks.swing();
}
}

    // rust: fn combat_foul(
    // rust: &mut self,
    // rust: i: usize,
    // rust: foul: horizon_anticheat::combat::Foul,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) -> bool {
//         use horizon_anticheat::combat::Foul;
    // rust: let detail = match foul {
    // rust: Foul::NoSwing(n) => {
    // rust: format!("attacked without swinging ({n} more attacks than swings in a tick)")
}
    // rust: Foul::TwoTargets(first, then) => {
    // rust: format!("attacked entities {first} and {then} in one tick")
}
}
    // rust: self.flag(i, Check::Combat, 1.0, &detail, events)
}

    /// Whether the prediction records the players' client ticks.
pub fn recording(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.anticheat
    // rust: .as_deref()
    // rust: .is_some_and(|ac| ac.config.runs(Check::Prediction))
}

    /// A move packet from guest `i`, as it came: the prediction's record of the client tick.
    // rust: pub(super) fn anticheat_moved(
    // rust: &mut self,
    // rust: i: usize,
    // rust: pos: Option<[f64; 3]>,
    // rust: rot: Option<(f32, f32)>,
    // rust: flags: u8,
    // rust: ) {
    // rust: if self.recording() {
    // rust: let record = self.guests[i].anticheat.record.get_or_insert_default();
    // rust: record.moved(pos, rot, flags);
}
}

    /// ServerboundPongPacket: the client has handled every packet of the server tick `id` (the ping
    /// [`Hub::anticheat_ping`] sent at its end).
    // rust: pub(super) fn anticheat_pong(&mut self, i: usize, id: i32) {
    // rust: let ticks = self.ticks;
    // rust: if self.recording() {
    // rust: let record = self.guests[i].anticheat.record.get_or_insert_default();
            // Ids are server ticks, cut to 32 bits.
    // rust: record.pong(u64::from(id as u32), ticks);
}
}

    /// The end of a server tick, after everything it sent: a ping whose id is the tick to each
    /// player in the world, so the prediction knows from which client tick on that tick's packets
    /// were in effect.
pub fn anticheat_ping(self: *Self) void {
}
    // rust: if !self.recording() {
    // rust: return;
}
        // What the tick sent the players that changes their movement went out before this ping.
    // rust: let ticks = self.ticks;
    // rust: for g in &mut self.guests {
    // rust: let changes = std::mem::take(
    // rust: g.changes
    // rust: .get_mut()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner),
    // rust: );
    // rust: if let Some(record) = g.anticheat.record.as_deref_mut() {
    // rust: for change in changes {
    // rust: record.changed(ticks, change);
}
}
}
    // rust: let ping = horizon_protocol::packets::play::Clientbound::Ping(
    // rust: horizon_protocol::packets::configuration::Ping {
    // rust: id: self.ticks as u32 as i32,
    // rust: },
    // rust: );
    // rust: for g in self.guests.iter().filter(|g| g.placed) {
    // rust: g.send(&ping);
}
}

    /// `ground`, for a move from guest `i` that says it ends on the ground at `to` (`stands`: the move
    /// itself was stopped by something below): None when the claim stands (or isn't judged, or the check
    /// only logs: `setback = 0`), else whether the move is refused because the player was kicked. A
    /// false claim is dropped (vanilla's fall damage follows); the player is never sent back, and the
    /// move doesn't count toward vanilla's floating kick. A claim at the height where the
    /// ground last held the player, within half a second, isn't judged: the block may have gone
    /// server-side (broken, pushed) before the client heard.
    // rust: pub(super) fn anticheat_ground(
    // rust: &mut self,
    // rust: i: usize,
    // rust: to: [f64; 3],
    // rust: stands: bool,
    // rust: ctx: &TickCtx,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) -> Option<bool> {
    // rust: if !self.anticheat.as_deref()?.config.runs(Check::Ground) {
    // rust: return None;
}
        // Standing still: no fall to skip, whatever holds the player up (a block the server doesn't
        // have, seen on the official server after a long teleport). Hovering is vanilla's floating kick.
    // rust: if self.guests[i].position == to {
    // rust: return None;
}
    // rust: let ticks = self.ticks;
        // Entity.move resolves Y first, where the body starts, then X and Z: on the tick a player
        // walks off an edge (or lands on one and slides off it), the client stands on what is under
        // the move's start. A vanilla client did that once a step down every slope and staircase.
    // rust: let from = self.guests[i].position;
    // rust: let held_at_start = || self.ground_holds(i, [from[0], to[1], from[2]], ctx) != Some(false);
    // rust: if stands || self.ground_holds(i, to, ctx)? || held_at_start() {
    // rust: self.guests[i].anticheat.ground = Some((ticks, to[1]));
    // rust: return None;
}
    // rust: if self.guests[i].anticheat.ground.is_some_and(|(t, y)| {
    // rust: ticks.saturating_sub(t) <= GROUND_GRACE && (y - to[1]).abs() < 1.0E-3
    // rust: }) {
    // rust: return None;
}
    // rust: let (fx, fz) = (to[0].floor() as i32, to[2].floor() as i32);
    // rust: let below = if self
    // rust: .encoder
    // rust: .has_fluid(ctx.world.block(fx, to[1].floor() as i32 - 1, fz).0)
    // rust: {
    // rust: "on a fluid"
    // rust: } else {
    // rust: "in the air"
}
    // rust: let detail = format!(
    // rust: "claims the ground {below} at {:.1} {:.1} {:.1}",
    // rust: to[0], to[1], to[2]
    // rust: );
    // rust: self.flag(i, Check::Ground, 1.0, &detail, events);
    // rust: if self.anticheat.as_deref()?.config.ground.setback == 0.0 {
    // rust: return None;
}
        // The correction is the dropped claim, never a setback: sent back into the air it claimed to
        // stand in, an honest player (on a block the server doesn't have) claims it again and again,
        // and hovers there until vanilla's floating kick. Only the anticheat's own kick ends it.
    // rust: Some(!self.guests[i].left_reason.is_empty())
}

    /// Whether something at `to` can hold guest `i` up; None: not judged. Only blocks that can't hold
    /// anyone are judged: nothing but air and fluids around the feet, and no collision a tenth of a block
    /// below. Anything else (powder snow, scaffolding, a block the server doesn't have yet) and a boat,
    /// minecart, shulker or happy ghast under the player: not judged.
pub fn ground_holds(self: *Self, i: usize, to: [f64; 3], ctx: *TickCtx) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let g = &self.guests[i];
        // No fall damage to skip.
    // rust: if g.creative() || g.spectator() || g.fall_flying {
    // rust: return None;
}
    // rust: let binding = ctx.collision?;
    // rust: if !ctx.world.loaded(to[0].floor() as i32, to[2].floor() as i32) {
    // rust: return None;
}
    // rust: let half = f64::from(g.dimensions().width) / 2.0;
    // rust: let lo =
    // rust: [to[0] - half - 0.0625, to[1] - 0.6, to[2] - half - 0.0625].map(|v| v.floor() as i32);
    // rust: let hi = [to[0] + half + 0.0625, to[1], to[2] + half + 0.0625].map(|v| v.floor() as i32);
    // rust: for x in lo[0]..=hi[0] {
    // rust: for z in lo[2]..=hi[2] {
    // rust: for y in lo[1]..=hi[1] {
    // rust: let state = ctx.world.block(x, y, z).0;
    // rust: if !self.encoder.is_air(state) && !self.encoder.has_fluid(state) {
    // rust: return None;
}
}
}
}
    // rust: if ctx
    // rust: .entities
    // rust: .iter()
    // rust: .any(|e| carries_player(&e.kind, e.position, to))
    // rust: {
    // rust: return None;
}
        // A waterlogged slab or stairs: their shape holds the player.
    // rust: let height = f64::from(g.dimensions().height);
    // rust: let feet = Aabb::new(
    // rust: Vec3::new(to[0] - half, to[1], to[2] - half),
    // rust: Vec3::new(to[0] + half, to[1] + height, to[2] + half),
    // rust: );
    // rust: let mut scene = SceneCollisions {
    // rust: world: ctx.world,
    // rust: binding,
    // rust: subject: None,
}
    // rust: let down = Vec3::new(0.0, -0.1, 0.0);
    // rust: Some(
    // rust: scene
    // rust: .resolve(feet, down, 0.0, false)
    // rust: .is_ok_and(|done| done.y > down.y),
    // rust: )
}

    /// `check` failed for guest `i`: raise its level, log it, and act on it. Returns whether the move or
    /// action is cancelled (the player is sent back, or kicked).
    // rust: pub(super) fn flag(
    // rust: &mut self,
    // rust: i: usize,
    // rust: check: Check,
    // rust: weight: f32,
    // rust: detail: &str,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) -> bool {
    // rust: self.flag_to(i, check, weight, detail, events, None)
}

    /// `prediction`: guest `conn`'s ticks that landed off the replay. A setback sends the player
    /// back to `agreed`, where its moves last agreed.
    // rust: pub fn anticheat_prediction(
    // rust: &mut self,
    // rust: conn: u32,
    // rust: over: &super::prediction::Over,
    // rust: agreed: [f64; 3],
    // rust: ) -> Vec<HostEvent> {
    // rust: let mut events = Vec::new();
    // rust: if let Some(i) = self.guests.iter().position(|g| g.conn == conn) {
    // rust: let ticks = if over.ticks == 1 { "tick" } else { "ticks" };
            // The worst tick as played, so the log tells a lag, a glide or a ladder from a cheat.
    // rust: let worst = over
    // rust: .at_worst
    // rust: .map_or(String::new(), |p| format!("; {}", p.describe()));
    // rust: let detail = format!(
    // rust: "moved up to {:.3} blocks off what its keys allow ({} {ticks}{worst})",
    // rust: over.worst, over.ticks
    // rust: );
    // rust: let weight = over.weight;
    // rust: self.flag_to(
    // rust: i,
    // rust: Check::Prediction,
    // rust: weight,
    // rust: &detail,
    // rust: &mut events,
    // rust: Some(agreed),
    // rust: );
}
    // rust: events
}

    /// [`Hub::flag`], whose setback sends the player to `back` (where it was by default).
    // rust: fn flag_to(
    // rust: &mut self,
    // rust: i: usize,
    // rust: check: Check,
    // rust: weight: f32,
    // rust: detail: &str,
    // rust: events: &mut Vec<HostEvent>,
    // rust: back: Option<[f64; 3]>,
    // rust: ) -> bool {
    // rust: let ticks = self.ticks;
    // rust: let Some(ac) = self.anticheat.as_deref_mut() else {
    // rust: return false;
}
        // Kicked or banned already, and leaving: what it still had queued (a lagging client's ticks)
        // is dropped, and counts no second strike in the session the first kick warned.
    // rust: if !self.guests[i].left_reason.is_empty() {
    // rust: return true;
}
    // rust: let g = &mut self.guests[i];
    // rust: let v = g.anticheat.flag(&ac.config, check, weight, ticks);
    // rust: let (uuid, name) = (g.uuid, g.name.clone());
    // rust: let ban_after = ac.config.actions(check).ban_after;
    // rust: let (kicks, ban) = if v.kick {
    // rust: ac.strike(uuid, check)
    // rust: } else {
    // rust: (0, false)
}
    // rust: let warned;
    // rust: let action = if ban {
    // rust: ", banned"
    // rust: } else if v.kick && ban_after > 0 {
    // rust: warned = format!(", kicked ({kicks} of {ban_after} before a ban)");
    // rust: &warned
    // rust: } else if v.kick {
    // rust: ", kicked"
    // rust: } else if v.setback && check == Check::Combat {
    // rust: ", attacks dropped"
    // rust: } else if v.setback && check == Check::Ground {
    // rust: ", claim dropped"
    // rust: } else if v.setback {
    // rust: ", sent back"
    // rust: } else {
    // rust: ""
}
    // rust: let line = format!(
    // rust: "{name} failed {} (VL {:.1}): {detail}{action}",
    // rust: check.name(),
    // rust: v.vl
    // rust: );
    // rust: ac.write_log(&line);
        // A kick or a ban is always told, so an operator can undo one that was wrong.
    // rust: if v.alert || v.kick {
    // rust: events.push(HostEvent::Warn(format!("[Anticheat] {line}")));
    // rust: if ac.config.alerts {
    // rust: let level = ac.config.alert_level;
    // rust: let content = Tag::compound([
    // rust: ("text", Tag::String(JavaString::from("[Anticheat] "))),
    // rust: ("color", Tag::String(JavaString::from("red"))),
    // rust: ("extra", Tag::List(vec![text(&line, "gray")])),
    // rust: ]);
    // rust: let packet = horizon_protocol::packets::play::Clientbound::SystemChat(
    // rust: horizon_protocol::packets::play::SystemChat {
    // rust: content,
    // rust: overlay: false,
    // rust: },
    // rust: );
    // rust: for op in self
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|o| o.placed && o.permission >= level)
    // rust: {
    // rust: op.send(&packet);
}
}
}
    // rust: if ban {
            // The game bans as `/ban` does, and its kick says so.
    // rust: events.push(HostEvent::Ban {
    // rust: uuid,
    // rust: name,
    // rust: reason: format!("Horizon anticheat: {}", check.name()),
    // rust: });
    // rust: } else if v.kick {
    // rust: self.anticheat_kick(self.guests[i].conn);
    // rust: } else if v.setback
    // rust: && !matches!(check, Check::Combat | Check::Ground)
    // rust: && self.guests[i].awaiting_teleport.is_none()
    // rust: {
            // A combat setback drops the attack (`anticheat_attack`), a ground one the claim
            // (`anticheat_ground`); the others send the player back.
    // rust: self.resend_teleport(i, back);
}
    // rust: v.setback || v.kick
}

    /// Disconnects `conn` for the anticheat.
pub fn anticheat_kick(self: *Self, conn: u32) void {
}
    // rust: self.kick(conn, text("Kicked by the server's anticheat", "white"));
}
}

    // rust: mod tests {
//     use super::*;

pub fn uuids_are_written_as_the_ban_list_writes_them() void {
}
    // rust: assert_eq!(
    // rust: uuid_text(0x069a79f4_44e9_4726_a5be_fca90e38aaf5),
    // rust: "069a79f4-44e9-4726-a5be-fca90e38aaf5"
    // rust: );
}

pub fn a_happy_ghasts_rider_and_a_boats_are_carried() void {
}
        // HappyGhast is 4 blocks tall: its rider stands 4.0 above it.
    // rust: assert!(carries_player(
    // rust: "minecraft:happy_ghast",
    // rust: [0.0, 70.0, 0.0],
    // rust: [1.5, 74.0, -1.0]
    // rust: ));
    // rust: assert!(carries_player(
    // rust: "minecraft:oak_boat",
    // rust: [0.0, 62.0, 0.0],
    // rust: [0.0, 62.5625, 0.0]
    // rust: ));
    // rust: assert!(!carries_player(
    // rust: "minecraft:zombie",
    // rust: [0.0, 70.0, 0.0],
    // rust: [0.0, 71.0, 0.0]
    // rust: ));
    // rust: assert!(!carries_player(
    // rust: "minecraft:happy_ghast",
    // rust: [0.0, 70.0, 0.0],
    // rust: [0.0, 80.0, 0.0]
    // rust: ));
}
}
