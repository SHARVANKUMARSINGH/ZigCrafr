//! Transpiled from Horizon Rust crate
//! Module: horizon-client_prediction
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The movement prediction's replay (docs/anticheat.md): each client tick a player's record holds
//! ([`horizon_anticheat::prediction::Record`]) is played again with the client's own movement code,
//! from where the last one ended, and compared with where the client said it went.
//!
//! The inputs are known exactly: a vanilla client sends ServerboundPlayerInputPacket after its tick's
//! aiStep (auto-jump included), its sprinting just before the move, and its item use from the key
//! handling before the tick. So nothing about them is guessed: a candidate that sprinted or skipped
//! the item-use slowdown where the client said otherwise would let speed and no-slowdown cheats
//! through. What the server can't know is tried, every combination of it, the tick as heard first,
//! keeping the closest outcome: whether the client stood on something on the first tick after a
//! start (a teleport), and on the tick where the server's item use changed, the use as it was before
//! (the server ends a use on its own tick, the client on its own).
//!
//! The replay then goes on from where the client said it is, so a small error never builds up, and a
//! client that lies a little each tick is measured against its own last position.
//!
//! A tick that lands farther than the check's tolerance counts against the player, unless the server
//! excuses it ([`Replay::excuse`]: something the replay can't play yet was near), and then the ticks
//! after it too, until the moves agree again or [`DRIFT`] ticks have gone by: a push the replay missed
//! leaves the client's velocity off for a few ticks.

// use std::collections::VecDeque;

// use horizon_anticheat::prediction::{Change, ClientTick, KEPT, Record, Restart};
// use horizon_core::geometry::Vec3;

// use crate::motion::PlayerMotion;
// use crate::sprint::Keys;

/// A move shorter than this isn't sent (LocalPlayer.sendPosition: 2.0E-4).
pub const UNSENT: f64 = 2.0e-4;

/// Below this the replay and the client agree (float noise).
pub const EXACT: f64 = 1e-6;

/// The most ticks an excuse covers after the tick it was for.
pub const DRIFT: u8 = 40;

/// The most a single tick weighs, in tolerances.
pub const MOST_WEIGHT: f64 = 5.0;

/// Ticks after the server's item use ends during which the client may still be slowed by it: half a
/// second. The client finishes a use on its own ticks and the server on its own (food eaten one after
/// another with the key held), and the server stops one for its own reasons (a shield disabled):
/// the client's ends a few ticks later, more with an uneven ping. Slower than its keys allow is no
/// advantage; the other way round (a use the server has and the client may not) would let a no-slow
/// walk, so a start counts at once, as the client's use packet comes before its tick's move.
pub const USE_WINDOW: u8 = 10;

/// The ticks of a catch-up that landed farther than the tolerance, none of them excused.
pub const Over = struct {
    ticks: u32,
    /// The farthest of them, in blocks.
    worst: f64,
    /// Each one's offset in tolerances, at most 5 a tick, added up.
    weight: f32,
    /// The farthest tick, as played: what the log tells of it.
    at_worst: ?Played,
    /// One of them came with a move.
    moved: bool,
};

/// Ticks within the tolerance in a row after which a replay that lands off takes the client's
/// velocity ([`Replay::meet`]): half a second.
pub const STEADY: u8 = 10;

/// The most velocity a replay takes from the client at once, in blocks a tick (a jump is 0.42).
pub const MOST_MET: f64 = 0.5;

/// Below this the moves agree again after an excuse: within the tolerance is not enough, as the
/// replay's velocity is still being brought to the client's.
pub const AGREED: f64 = 1e-3;

/// Whether the block at `block` is near enough a player at `at` to change its next moves, `slack`
/// blocks farther for a fast one (see [`slack`]).
pub fn near(at: [f64; 3], block: [i32; 3], slack: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = |i: usize| f64::from(block[i]) + 0.5 - at[i];
    // rust: let r = 4.5 + slack;
    // rust: d(0).abs() <= r && d(2).abs() <= r && (-4.5 - slack..=6.5 + slack).contains(&d(1))
}

/// How much farther to look around a player that moves `moved` in a tick: two ticks of it, as the
/// server's view of what is around it (a firework flying with it) is a tick or so behind.
pub fn slack(moved: [f64; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (2.0 * moved.iter().map(|v| v * v).sum::<f64>().sqrt()).min(16.0)
}

/// One client tick played again.
pub const Played = struct {
    /// How far the closest outcome ended from where the client said.
    offset: f64,
    /// Which of the unknowns it took: 1, the ground the other way (the first tick after a start); 2,
    /// the item use before the server's change; 4, the jump delay the other way (a jump held soon
    /// after an excuse). 0 is the tick as the server heard it.
    candidate: u8,
    /// The replay and the client agree about the ground (the move's flag 1).
    ground: bool,
    /// Where the client said it went less where the replay ended, in blocks.
    off: [f64,
    /// How far the client said it went in the tick.
    moved: f64,
    /// What the replayed body was doing when the tick ended ([`Played::state`]).
    state: u8,
    /// The tick's keys (ServerboundPlayerInputPacket's flags).
    input: u8,
    /// Where the client said it ended the tick.
    at: [f64,
    /// The replay's velocity at the end of the tick, in blocks a tick.
    velocity: [f64,
};

    // rust: impl Played {
    /// Bits of [`Played::state`].
pub const GROUND: u8 = 1;
pub const WATER: u8 = 2;
pub const GLIDING: u8 = 4;
pub const SPRINTING: u8 = 8;
pub const SNEAKING: u8 = 16;
pub const SWIMMING: u8 = 32;
pub const FLYING: u8 = 64;
pub const RIDING: u8 = 128;

    /// What a log line says of the tick, so a flag can be found again in the world and played:
    /// `off +0.000 +0.173 +0.000, moved 0.281, air sprinting, keys forward jump, at 12.30 64.00
    /// -5.50, velocity +0.000 -0.078 +0.000`.
pub fn describe(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names = [
    // rust: (Self::WATER, "water"),
    // rust: (Self::GLIDING, "gliding"),
    // rust: (Self::SPRINTING, "sprinting"),
    // rust: (Self::SNEAKING, "sneaking"),
    // rust: (Self::SWIMMING, "swimming"),
    // rust: (Self::FLYING, "flying"),
    // rust: (Self::RIDING, "riding"),
    // rust: ];
    // rust: let mut state = String::from(if self.state & Self::GROUND != 0 {
    // rust: "ground"
    // rust: } else {
    // rust: "air"
    // rust: });
    // rust: for (bit, name) in names {
    // rust: if self.state & bit != 0 {
    // rust: state.push(' ');
    // rust: state.push_str(name);
}
}
    // rust: let [x, y, z] = self.off;
    // rust: let keys = [
    // rust: "forward", "backward", "left", "right", "jump", "shift", "sprint",
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .filter(|&(bit, _)| self.input & (1 << bit) != 0)
    // rust: .map(|(_, name)| name)
    // rust: .collect::<Vec<_>>();
    // rust: let keys = if keys.is_empty() {
    // rust: "none".to_owned()
    // rust: } else {
    // rust: keys.join(" ")
}
    // rust: let [ax, ay, az] = self.at;
    // rust: let [vx, vy, vz] = self.velocity;
    // rust: format!(
    // rust: "off {x:+.3} {y:+.3} {z:+.3}, moved {:.3}, {state}, keys {keys}, at {ax:.2} {ay:.2} \
    // rust: {az:.2}, velocity {vx:+.3} {vy:+.3} {vz:+.3}",
    // rust: self.moved
    // rust: )
}
}

/// A player as its client moves it.
pub const Replay = struct {
    /// The player at the end of the last tick played.
    body: *PlayerMotion,
    /// Where the client last said it was.
    said: Vec3,
    /// Where the client was when its moves last agreed (or were excused): where a setback sends it.
    agreed: Vec3,
    /// Ticks an excuse still covers.
    drift: u8,
    /// The record's ticks played so far.
    played: u64,
    /// The record's server changes applied so far.
    applied: u64,
    /// No tick played since the start: whether the client stood on something is unknown.
    fresh: bool,
    /// The server's item-use slowdown at the last tick played.
    using: ?f32,
    /// The one it had before its last change, and the ticks left in which the client may still be
    /// slowed by it after it ended ([`USE_WINDOW`]).
    used: ?f32,
    use_window: u8,
    /// Ticks the client's jump delay is unknown: under an excuse the replay may have jumped where the
    /// client couldn't (on a block it hadn't received), or the other way round.
    jump_unsure: u8,
    /// The last tick played: whether the client said it sprinted, and whether its keys pushed it
    /// forward (for [`Replay::sprints`]).
    claimed: bool,
    forward: bool,
    /// Ticks in a row within the tolerance, at most [`STEADY`].
    steady: u8,
    /// The velocity the client's last tick left it with, less the replay's.
    missed: Vec3,
    /// The next tick also tries this velocity added ([`Replay::meet`]).
    meeting: ?Vec3,
    /// The last ticks played, oldest first, at most [`KEPT`].
    ticks: VecDeque<Played>,
};

    // rust: impl Replay {
    /// A replay that starts at a teleport the client accepted, standing still, with the ticks and
    /// changes the record heard after it. `server` is the server's own copy of the player.
pub fn new(server: *PlayerMotion, restart: *Restart) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut body = Box::new(server.clone());
    // rust: let at = Vec3::new(restart.at[0], restart.at[1], restart.at[2]);
    // rust: (body.position, body.old_position, body.velocity) = (at, at, Vec3::ZERO);
    // rust: body.fall_distance = 0.0;
    // rust: body.events.clear();
        // The server's body carries the sprint modifier while the player sprints, but its flag only
        // while the game handles the player: the replay's first tick sprints as the client did.
    // rust: let _ = body.set_sprint_modifier(body.sprinting);
    // rust: Self {
    // rust: body,
    // rust: said: at,
    // rust: agreed: at,
    // rust: drift: 0,
    // rust: played: restart.ended,
    // rust: applied: restart.changed,
    // rust: fresh: true,
    // rust: using: server.item_use_speed,
    // rust: used: server.item_use_speed,
    // rust: use_window: 0,
    // rust: jump_unsure: 0,
    // rust: claimed: false,
    // rust: forward: false,
    // rust: steady: STEADY,
    // rust: missed: Vec3::ZERO,
    // rust: meeting: None,
    // rust: ticks: VecDeque::new(),
}
}

    /// Goes on from another teleport the client accepted: what the client keeps through it (its jump
    /// delay, a glide) stays as the replay had it; it stands still at the new place.
pub fn restart(self: *Self, restart: *Restart) void {
}
    // rust: let at = Vec3::new(restart.at[0], restart.at[1], restart.at[2]);
    // rust: let body = &mut self.body;
    // rust: (body.position, body.old_position, body.velocity) = (at, at, Vec3::ZERO);
    // rust: body.fall_distance = 0.0;
    // rust: (self.said, self.agreed, self.drift) = (at, at, 0);
    // rust: (self.played, self.applied, self.fresh) = (restart.ended, restart.changed, true);
    // rust: self.steady = STEADY;
}

    /// Plays the record's ticks it hasn't, each after what the server had changed by then (the
    /// changes of the server ticks the client had seen when the tick ended), and returns those that
    /// landed farther than `tolerance`. None when the record no longer keeps them, or a tick couldn't
    /// be played: the replay starts again at a teleport.
    // rust: pub fn catch_up(
    // rust: &mut self,
    // rust: record: &Record,
    // rust: server: &PlayerMotion,
    // rust: tolerance: f64,
    // rust: run: impl FnMut(&mut PlayerMotion, Keys, bool) -> crate::Result<()>,
    // rust: ) -> Option<Over> {
    // rust: self.play_to(record, server, record.ended(), tolerance, run)
}

    /// Plays the ticks the client ended before it accepted a teleport, which the replay hasn't yet
    /// (a burst of them came with the accept): what they did to the body (its jump delay) goes on
    /// through the teleport. Then applies the changes the server sent before the teleport that those
    /// ticks hadn't seen: the client had them all when it accepted it. Nothing counts. False when the
    /// record no longer keeps them.
    // rust: pub fn finish(
    // rust: &mut self,
    // rust: record: &Record,
    // rust: server: &PlayerMotion,
    // rust: restart: &Restart,
    // rust: run: impl FnMut(&mut PlayerMotion, Keys, bool) -> crate::Result<()>,
    // rust: ) -> bool {
    // rust: if self
    // rust: .play_to(record, server, restart.ended, f64::INFINITY, run)
    // rust: .is_none()
    // rust: {
    // rust: return false;
}
    // rust: let Some(changes) = record.changes_since(self.applied) else {
    // rust: return false;
}
    // rust: let left = usize::try_from(restart.changed.saturating_sub(self.applied)).unwrap_or(0);
    // rust: for &(_, change) in changes.take(left) {
    // rust: self.apply(change, server);
    // rust: self.applied += 1;
}
    // rust: true
}

    // rust: fn play_to(
    // rust: &mut self,
    // rust: record: &Record,
    // rust: server: &PlayerMotion,
    // rust: ended: u64,
    // rust: tolerance: f64,
    // rust: mut run: impl FnMut(&mut PlayerMotion, Keys, bool) -> crate::Result<()>,
    // rust: ) -> Option<Over> {
    // rust: let mut over = Over::default();
        // A tick of this catch-up already counted: the client has been displaced by its lie, so a
        // tick that agrees from there must not replace the setback point (#5132).
    // rust: let mut counted = false;
    // rust: let mut changes = record.changes_since(self.applied)?.peekable();
    // rust: let new = usize::try_from(ended.saturating_sub(self.played)).ok()?;
    // rust: for tick in record.since(self.played)?.take(new) {
    // rust: while let Some(&&(sent, change)) = changes.peek()
    // rust: && tick.seen.is_some_and(|seen| sent <= seen)
    // rust: {
    // rust: self.apply(change, server);
    // rust: self.applied += 1;
    // rust: changes.next();
}
    // rust: let played = self.play(tick, server, &mut run)?;
    // rust: let offset = played.offset;
            // A tick that agrees only with the velocity the last one left: that tick lied, or slipped
            // (Replay::meet), and the setback point stays before it.
    // rust: let met = played.candidate & 8 != 0;
    // rust: let steady = self.steady;
    // rust: self.steady = if offset <= tolerance {
    // rust: steady.saturating_add(1).min(STEADY)
    // rust: } else {
    // rust: 0
}
            // The server changed the player's abilities, or something near it, after what the
            // client had seen: the tick had the new ones where the client had the old.
    // rust: let unseen = || {
    // rust: let at = [self.said.x, self.said.y, self.said.z];
    // rust: let v = self.body.velocity;
    // rust: let slack = slack([v.x, v.y, v.z]);
    // rust: changes
    // rust: .clone()
    // rust: .any(|&(_, change)| change == Change::Abilities)
    // rust: || record.unseen_near(tick.seen, |block| near(at, block, slack))
}
    // rust: if offset <= AGREED {
    // rust: if !counted && !met {
    // rust: self.agreed = self.said;
}
    // rust: self.drift = 0;
    // rust: } else if offset <= tolerance {
    // rust: if !counted && !met {
    // rust: self.agreed = self.said;
}
    // rust: self.drift = self.drift.saturating_sub(1);
    // rust: } else if self.drift == 0 && unseen() {
    // rust: self.excuse();
    // rust: } else if self.drift > 0 {
    // rust: self.drift -= 1;
    // rust: self.agreed = self.said;
    // rust: } else {
    // rust: counted = true;
    // rust: over.ticks += 1;
    // rust: over.moved |= tick.position.is_some();
    // rust: if offset > over.worst {
    // rust: over.at_worst = self.ticks.back().copied();
}
    // rust: over.worst = over.worst.max(offset);
    // rust: over.weight += (offset / tolerance).min(MOST_WEIGHT) as f32;
    // rust: if steady == STEADY {
    // rust: self.meet();
}
}
}
    // rust: Some(over)
}

    /// The ticks just caught up landed off for a reason the replay can't play yet: they count for
    /// nothing, and neither do the ones after until the moves agree again (at most [`DRIFT`]).
pub fn excuse(self: *Self) void {
}
    // rust: (self.agreed, self.drift, self.jump_unsure) = (self.said, DRIFT, DRIFT);
}

    /// The first tick off after the moves agreed for a while: the next tick also tries the velocity
    /// the client was left with (up to [`MOST_MET`], across only), and keeps it if it lands closer. A
    /// single slip (a hit the replay missed) then counts once, not on every tick its velocity
    /// takes to die out; a single lie about the position (a blink) leaves the velocity as it was. A
    /// client that lies on every tick is off on every tick all the same: nothing is tried again until
    /// the moves have agreed for [`STEADY`] ticks.
pub fn meet(self: *Self) void {
}
    // rust: let m = self.missed;
    // rust: let length = (m.x * m.x + m.y * m.y + m.z * m.z).sqrt();
    // rust: let scale = if length > MOST_MET {
    // rust: MOST_MET / length
    // rust: } else {
    // rust: 1.0
}
    // rust: self.meeting = Some(Vec3::new(m.x * scale, m.y * scale, m.z * scale));
}

    /// Whether an excuse still covers the ticks.
pub fn excused(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.drift > 0
}

    /// Where the client was when its moves last agreed.
pub fn agreed(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [self.agreed.x, self.agreed.y, self.agreed.z]
}

    /// The client handling a change the server sent.
pub fn apply(self: *Self, change: Change, server: *PlayerMotion) void {
}
    // rust: let body = &mut self.body;
    // rust: let vector = |v: [f64; 3]| Vec3::new(v[0], v[1], v[2]);
    // rust: match change {
    // rust: Change::Velocity(v) => body.velocity = vector(v),
    // rust: Change::Knockback(k) => body.velocity = body.velocity.add_vector(vector(k)),
    // rust: Change::Attributes { sprint } => {
                // ClientPacketListener.handleUpdateAttributes: the client takes the modifiers of
                // the attributes sent, the sprint modifier included, and goes on sprinting or not
                // as it was (a sprint modifier gone while it sprints stays gone until it stops);
                // an attribute not sent keeps its own.
    // rust: let sprint = sprint.unwrap_or_else(|| body.has_sprint_modifier());
    // rust: body.attributes = server.attributes.clone();
    // rust: let _ = body.set_sprint_modifier(sprint);
}
            // ClientPacketListener.handleSetEntityData: the flag alone. A sprint the tick goes on
            // with is then started again (`MotionWorld::replayed_tick`), its modifier with it, as
            // LocalPlayer.aiStep does when the sprint key is held ([`Replay::sprints`]).
    // rust: Change::Sprinting(sprinting) => body.sprinting = sprinting,
    // rust: Change::Effects => body.status = server.status.clone(),
            // `sync` takes them every tick.
    // rust: Change::Abilities => {}
}
}

    /// Whether the client sprints in `tick`: as it said (ServerboundPlayerCommandPacket), but for a
    /// sprint the server stopped (its flag, [`Change::Sprinting`]) that the client says goes on. That
    /// client never said STOP: its LocalPlayer.aiStep started the sprint again, which takes the sprint
    /// key held, or forward pressed again (a double tap). Without either it would have stopped and
    /// said so: one that sprints on is played walking, until it holds the key or says STOP.
pub fn sprints(self: *Self, tick: *ClientTick, keys: Keys) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let restarted = tick.sprinting && self.claimed && !self.body.sprinting;
    // rust: self.claimed = tick.sprinting;
    // rust: let forward = std::mem::replace(&mut self.forward, keys.direction()[1] > 1.0e-5);
    // rust: tick.sprinting && (!restarted || keys.sprint || !forward)
}

    /// Plays `tick` again. `server` is the server's copy of the player, for what the server decides
    /// (abilities, effects, attributes); `run` moves a body one client tick with these keys and
    /// sprinting (`MotionWorld::replayed_tick`). None when no candidate could be played.
    // rust: fn play(
    // rust: &mut self,
    // rust: tick: &ClientTick,
    // rust: server: &PlayerMotion,
    // rust: run: &mut impl FnMut(&mut PlayerMotion, Keys, bool) -> crate::Result<()>,
    // rust: ) -> Option<Played> {
    // rust: self.played += 1;
    // rust: sync(&mut self.body, server);
    // rust: self.body.yaw = tick.yaw;
    // rust: self.body.head_yaw = tick.yaw;
    // rust: self.body.pitch = tick.pitch;
        // The first tick after a start guesses the ground from the client's move; the replay finds
        // it after that.
    // rust: let fresh = std::mem::take(&mut self.fresh);
    // rust: if fresh {
    // rust: self.body.ground.on_ground = tick.flags.is_some_and(|f| f & 1 != 0);
}
    // rust: let using = std::mem::replace(&mut self.using, server.item_use_speed);
    // rust: if using != server.item_use_speed {
    // rust: (self.used, self.use_window) = (using, USE_WINDOW);
    // rust: } else {
    // rust: self.use_window = self.use_window.saturating_sub(1);
}
    // rust: let used = self.used;
    // rust: let use_unsure = using != server.item_use_speed
    // rust: || self.use_window > 0 && server.item_use_speed.is_none() && used.is_some();
    // rust: let said = tick.position.map(|p| Vec3::new(p[0], p[1], p[2]));
    // rust: let keys = keys(tick.input);
    // rust: let sprinting = self.sprints(tick, keys);
    // rust: let last = self.said;
    // rust: let offset = |body: &PlayerMotion| match said {
    // rust: Some(p) => body.position.distance(p),
            // No move: the client is within 2.0E-4 of where it last said.
    // rust: None => (body.position.distance(last) - UNSENT).max(0.0),
}
    // rust: let meeting = self.meeting.take();
    // rust: let jump_unsure = self.jump_unsure > 0 && keys.jump;
    // rust: self.jump_unsure = self.jump_unsure.saturating_sub(1);
    // rust: let unknown = |candidate: u8| {
    // rust: candidate & 1 != 0 && fresh
    // rust: || candidate & 2 != 0 && use_unsure
    // rust: || candidate & 4 != 0 && jump_unsure
    // rust: || candidate & 8 != 0 && meeting.is_some()
}
    // rust: let (offset, candidate) = if ![1, 2, 4, 8].into_iter().any(unknown) {
            // Nothing to try (most ticks): the body itself plays the tick.
    // rust: run(&mut self.body, keys, sprinting).ok()?;
    // rust: (offset(&self.body), 0)
    // rust: } else {
    // rust: let mut best: Option<(f64, u8, Box<PlayerMotion>)> = None;
    // rust: for candidate in (0..16u8)
    // rust: .filter(|&c| c == 0 || [1, 2, 4, 8].into_iter().all(|b| c & b == 0 || unknown(b)))
    // rust: {
    // rust: let mut body = self.body.clone();
    // rust: if candidate & 1 != 0 {
    // rust: body.ground.on_ground = !body.ground.on_ground;
}
    // rust: if candidate & 2 != 0 {
    // rust: body.item_use_speed = used;
}
    // rust: if candidate & 4 != 0 {
    // rust: body.no_jump_delay = i32::from(body.no_jump_delay == 0);
}
    // rust: if let Some(met) = meeting.filter(|_| candidate & 8 != 0) {
    // rust: body.velocity = body.velocity.add_vector(met);
}
    // rust: if run(&mut body, keys, sprinting).is_err() {
    // rust: continue;
}
    // rust: let off = offset(&body);
    // rust: if best.as_ref().is_none_or(|b| off < b.0) {
    // rust: best = Some((off, candidate, body));
}
    // rust: if off <= EXACT {
    // rust: break;
}
}
    // rust: let (off, candidate, body) = best?;
    // rust: self.body = body;
    // rust: (off, candidate)
}
    // rust: let body = &mut self.body;
    // rust: let end = said.unwrap_or(last);
        // The replay's own velocity, before an excuse brings it to the client's.
    // rust: let velocity = body.velocity;
    // rust: let off = [
    // rust: end.x - body.position.x,
    // rust: end.y - body.position.y,
    // rust: end.z - body.position.z,
    // rust: ];
    // rust: let moved = said.map_or(0.0, |p| p.distance(last));
        // The velocity the client's tick left it with, less the replay's, across: the move it missed,
        // slowed as the replay's own move was each way (its drag or friction). Not up and down: there
        // the drag (0.98) is so slight that a client rising a little each tick on its own (a slow
        // fly) would look like one that slipped once for a second or more.
    // rust: let slowed = |missed: f64, moved: f64, left: f64| {
    // rust: if moved.abs() > 1e-3 {
    // rust: missed * (left / moved).clamp(0.0, 1.0)
    // rust: } else {
    // rust: missed * 0.91
}
}
    // rust: self.missed = Vec3::new(
    // rust: slowed(off[0], body.position.x - last.x, body.velocity.x),
    // rust: 0.0,
    // rust: slowed(off[2], body.position.z - last.z, body.velocity.z),
    // rust: );
    // rust: let state = [
    // rust: (body.ground.on_ground, Played::GROUND),
    // rust: (body.fluids.was_touching_water, Played::WATER),
    // rust: (body.fall_flying, Played::GLIDING),
    // rust: (body.sprinting, Played::SPRINTING),
    // rust: (body.shift_key_down, Played::SNEAKING),
    // rust: (body.swimming, Played::SWIMMING),
    // rust: (body.flying, Played::FLYING),
    // rust: (body.is_passenger, Played::RIDING),
    // rust: ]
    // rust: .into_iter()
    // rust: .filter(|&(on, _)| on)
    // rust: .fold(0, |bits, (_, bit)| bits | bit);
    // rust: body.events.clear();
    // rust: body.item_use_speed = server.item_use_speed;
        // Under an excuse the client's velocity is off by about what its move was: take it, and the
        // replay meets the client again within a few ticks. A client that sent no move stayed
        // where it last said (on a boat, say, which the replay doesn't stand on).
    // rust: if self.drift > 0 && offset > 0.0 {
    // rust: let p = said.unwrap_or(last);
    // rust: body.velocity = body.velocity.add_vector(p.subtract(body.position));
}
    // rust: match said {
    // rust: Some(p) => {
    // rust: body.position = p;
    // rust: self.said = p;
}
    // rust: None if offset > 0.0 => body.position = self.said,
    // rust: None => {}
}
    // rust: let ground = tick
    // rust: .flags
    // rust: .is_none_or(|f| (f & 1 != 0) == self.body.ground.on_ground);
    // rust: let velocity = [velocity.x, velocity.y, velocity.z];
    // rust: let played = Played {
    // rust: offset,
    // rust: candidate,
    // rust: ground,
    // rust: off,
    // rust: moved,
    // rust: state,
    // rust: input: tick.input,
    // rust: at: [end.x, end.y, end.z],
    // rust: velocity,
}
    // rust: if self.ticks.len() == KEPT {
    // rust: self.ticks.pop_front();
}
    // rust: self.ticks.push_back(played);
    // rust: Some(played)
}
}

/// ServerboundPlayerInputPacket's flags as keys.
pub fn keys(input: u8) K {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = |bit: u8| input & bit != 0;
    // rust: Keys {
    // rust: forward: key(1),
    // rust: backward: key(2),
    // rust: left: key(4),
    // rust: right: key(8),
    // rust: jump: key(16),
    // rust: shift: key(32),
    // rust: sprint: key(64),
    // rust: analog: None,
}
}

/// What the server decides about the player, from its own copy (its attributes and effects come
/// with the changes the server sent): the rest is the client's.
pub fn sync(body: *mut PlayerMotion, server: *PlayerMotion) void {
}
    // rust: (body.may_fly, body.flying, body.flying_speed) =
    // rust: (server.may_fly, server.flying, server.flying_speed);
    // rust: (body.invulnerable, body.spectator, body.sleeping) =
    // rust: (server.invulnerable, server.spectator, server.sleeping);
    // rust: body.glider = server.glider;
    // rust: (body.item_use_speed, body.item_use_slows_sprint) =
    // rust: (server.item_use_speed, server.item_use_slows_sprint);
    // rust: (
    // rust: body.leather_boots,
    // rust: body.freeze_immune,
    // rust: body.burn_from_stepping_immune,
    // rust: ) = (
    // rust: server.leather_boots,
    // rust: server.freeze_immune,
    // rust: server.burn_from_stepping_immune,
    // rust: );
    // rust: body.border = server.border.clone();
    // The keys already hold the client's auto-jump.
    // rust: (body.auto_jump_enabled, body.auto_jump_time) = (false, 0);
    // rust: (body.client_side, body.server_copy) = (true, false);
}

    // rust: mod tests {
//     use super::*;
//     use crate::{
    // rust: assets::Assets,
    // rust: motion::{MotionResources, MotionWorld},
    // rust: world::World,
}
//     use horizon_anticheat::prediction::Record;
//     use std::path::Path;

    /// Keys for each tick: 20 walking, 12 sprint-jumping, 12 strafing while turning, 6 still.
pub fn script() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut ticks = Vec::new();
    // rust: ticks.extend((0..20).map(|_| (1, 0.0)));
    // rust: ticks.extend((0..12).map(|_| (1 | 16 | 64, 0.0)));
    // rust: ticks.extend((0..12).map(|i| (1 | 4, 3.0 * i as f32)));
    // rust: ticks.extend((0..6).map(|_| (0, 36.0)));
    // rust: ticks
}

    /// A velocity the client gets on a tick of the script: whether the server sent it (`heard`),
    /// whether the server excuses the ticks it is off (`excused`), and whether the client takes it.
pub const Push = struct {
    tick: usize,
    velocity: [f64,
    heard: bool,
    excused: bool,
    taken: bool,
};

    /// One tick of the script as the server saw it.
pub const Step = struct {
    played: Played,
    over: Over,
        /// Where the client said it was, and where the replay last agreed.
    said: [f64,
    agreed: [f64,
};

    /// The offsets of a client that walks `script` in the test scene, its moves passed through
    /// `cheat` (the position it sends and stays at, from the one before and the honest one). Each
    /// tick of the script is a server tick too, whose ping the client answers before its own.
pub fn offsets(cheat: impl Fn(Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(
    // rust: steps(|_, before, honest| cheat(before, honest), push)?
    // rust: .into_iter()
    // rust: .map(|s| s.played)
    // rust: .collect(),
    // rust: )
}

    /// Where the client starts in the test scene and what it plays.
pub const Run = struct {
    start: Vec3,
        /// Keys and yaw for each tick.
    script: Vec<(u8,
    pitch: f32,
        /// An elytra on.
    glider: bool,
        /// From tick `.0` on, the ticks come in a burst that the server only plays at tick `.1`,
        /// when the client accepts a teleport back to where the burst began.
    teleport: Option<(usize,
        /// Ticks `.0 .. .1` arrive together: the server plays them all at tick `.1`, in one
        /// catch-up, as it does when its tick lags the client's.
    burst: Option<(usize,
        /// Blocks set in the scene after the floor.
    blocks: Vec<([i32,
        /// On tick `.0`, the server sends the player attributes (the server's body has no sprint
        /// modifier): `.1` as in [`Change::Attributes`], which the client takes.
    attributes: Option<(usize,
        /// On each tick `.0`, the client handles what the server sent when it heard the client's
        /// sprint `.1`: the shared flags with that sprinting bit, and the movement speed with the
        /// sprint modifier or without ([`Change::Sprinting`], [`Change::Attributes`]).
    server_sprint: Vec<(usize,
        /// The client ignores the sprinting flag and movement speed the server sends (a cheat that
        /// keeps its sprint through a hit).
    keep_sprint: bool,
        /// The first ticks the client is on its loading screen: it ends them without moving or
        /// sending a move.
    frozen: usize,
        /// The ticks the client uses an item (slowed to 0.2), and those the server thinks it does.
    item_use: ?(std::ops::Range<usize,
};

    // rust: impl Run {
        /// [`script`] on the floor.
pub fn walk() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: start: Vec3::new(20.5, 5.0, 20.5),
    // rust: script: script(),
    // rust: pitch: 0.0,
    // rust: glider: false,
    // rust: teleport: None,
    // rust: burst: None,
    // rust: blocks: Vec::new(),
    // rust: attributes: None,
    // rust: server_sprint: Vec::new(),
    // rust: keep_sprint: false,
    // rust: frozen: 0,
    // rust: item_use: None,
}
}
}

    /// [`offsets`], with what the check makes of each tick; `cheat` also gets the tick's index.
pub fn steps(cheat: impl Fn(usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: steps_in(Run::walk(), cheat, push)
}

    /// [`steps`] for any [`Run`].
    // rust: fn steps_in(
    // rust: run: Run,
    // rust: cheat: impl Fn(usize, Vec3, Vec3) -> Vec3,
    // rust: push: Option<Push>,
    // rust: ) -> Option<Vec<Step>> {
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return None;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
        // A clean stone floor with its top at y 5, and a slab on the walk to step up on.
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let air = assets.registry.default_state("minecraft:air").unwrap();
    // rust: for x in 10..=30 {
    // rust: for z in 10..=40 {
    // rust: scene.set(x, 4, z, stone).unwrap();
    // rust: for y in 5..=12 {
    // rust: scene.set(x, y, z, air).unwrap();
}
}
}
    // rust: let slab = assets
    // rust: .registry
    // rust: .default_state("minecraft:smooth_stone_slab")
    // rust: .unwrap();
    // rust: scene.set(20, 5, 23, slab).unwrap();
    // rust: for &(at, block) in &run.blocks {
    // rust: let state = assets.registry.default_state(block).unwrap();
    // rust: scene.set(at[0], at[1], at[2], state).unwrap();
}
    // rust: let start = run.start;
    // rust: let mut client = PlayerMotion::new(&resources, start).unwrap();
    // rust: client.client_side = true;
    // rust: let mut server = PlayerMotion::new(&resources, start).unwrap();
    // rust: (client.glider, server.glider) = (run.glider, run.glider);
    // rust: client.pitch = run.pitch;
    // rust: let mut world = |player: &mut PlayerMotion, f: &mut dyn FnMut(&mut MotionWorld)| {
    // rust: f(&mut MotionWorld {
    // rust: entities: &[],
    // rust: player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
    // rust: })
}
        // Settle on the floor first (or fall for a while).
    // rust: for _ in 0..10 {
    // rust: world(&mut client, &mut |w| {
    // rust: w.controlled_simulation_tick(Keys::default()).unwrap()
    // rust: });
}
        // The start is a teleport: the client goes on from there, standing still.
    // rust: client.velocity = Vec3::ZERO;
    // rust: let at = client.position;
    // rust: let mut record = Record::default();
    // rust: record.teleported([at.x, at.y, at.z], false);
    // rust: let mut replay = Replay::new(&server, &record.take_restart().unwrap());
    // rust: let mut played = Vec::new();
    // rust: let run_teleport = run.teleport;
    // rust: let run_burst = run.burst;
    // rust: let run_attributes = run.attributes;
    // rust: let run_frozen = run.frozen;
    // rust: let run_item_use = run.item_use;
    // rust: let mut back = start;
    // rust: for (i, (input, yaw)) in run.script.into_iter().enumerate() {
    // rust: let tick = i as u64;
    // rust: if let Some(push) = push.as_ref().filter(|p| p.tick == i) {
    // rust: let velocity = horizon_protocol::buf::LpVec3::quantize(push.velocity);
    // rust: if push.heard {
    // rust: record.changed(tick, Change::Velocity(velocity));
}
    // rust: if push.taken {
    // rust: client.velocity = Vec3::new(velocity[0], velocity[1], velocity[2]);
}
}
    // rust: if let Some((_, sprint)) = run_attributes.filter(|&(at, _)| at == i) {
    // rust: record.changed(tick, Change::Attributes { sprint });
    // rust: if let Some(kept) = sprint {
    // rust: client.set_sprint_modifier(kept).unwrap();
}
}
    // rust: for &(_, sprint) in run.server_sprint.iter().filter(|&&(at, _)| at == i) {
    // rust: record.changed(tick, Change::Sprinting(sprint));
    // rust: record.changed(
    // rust: tick,
    // rust: Change::Attributes {
    // rust: sprint: Some(sprint),
    // rust: },
    // rust: );
    // rust: if !run.keep_sprint {
    // rust: client.sprinting = sprint;
    // rust: client.set_sprint_modifier(sprint).unwrap();
}
}
    // rust: record.pong(tick, tick);
    // rust: let before = client.position;
    // rust: if run_teleport.is_some_and(|(burst, _)| burst == i) {
    // rust: back = before;
}
    // rust: client.yaw = yaw;
    // rust: if let Some((ref on_client, ref on_server)) = run_item_use {
    // rust: let speed = |r: &std::ops::Range<usize>| r.contains(&i).then_some(0.2);
    // rust: (client.item_use_speed, server.item_use_speed) =
    // rust: (speed(on_client), speed(on_server));
}
    // rust: if i >= run_frozen {
    // rust: world(&mut client, &mut |w| {
    // rust: w.controlled_simulation_tick(keys(input)).unwrap()
    // rust: });
    // rust: client.position = cheat(i, before, client.position);
    // rust: let p = client.position;
    // rust: let ground = u8::from(client.ground.on_ground);
    // rust: record.moved(Some([p.x, p.y, p.z]), Some((yaw, run.pitch)), ground);
}
    // rust: let p = client.position;
    // rust: record.tick_end(input, client.sprinting);
            // A burst: the server hears these ticks now and plays them together at the last one.
    // rust: if run_burst.is_some_and(|(from, to)| (from..to).contains(&i)) {
    // rust: continue;
}
    // rust: let mut run = |body: &mut PlayerMotion, keys, sprinting| {
    // rust: let mut result = Ok(());
    // rust: world(body, &mut |w| result = w.replayed_tick(keys, sprinting));
    // rust: result
}
    // rust: if run_teleport.is_some_and(|(burst, at)| (burst..at).contains(&i)) {
    // rust: continue;
}
    // rust: if run_teleport.is_some_and(|(_, at)| at == i) {
    // rust: record.teleported([back.x, back.y, back.z], false);
    // rust: (client.position, client.velocity) = (back, Vec3::ZERO);
    // rust: let restart = record.take_restart().unwrap();
    // rust: assert!(replay.finish(&record, &server, &restart, &mut run));
    // rust: replay.restart(&restart);
}
    // rust: let over = replay.catch_up(&record, &server, 0.03, run).unwrap();
    // rust: if over.ticks > 0 && push.as_ref().is_some_and(|p| p.excused) {
    // rust: replay.excuse();
}
    // rust: played.push(Step {
    // rust: played: *replay.ticks.back().unwrap(),
    // rust: over,
    // rust: said: [p.x, p.y, p.z],
    // rust: agreed: replay.agreed(),
    // rust: });
}
    // rust: Some(played)
}

    /// A client still loading the level (#5849) neither moves nor sends a move, while the replay
    /// falls from where it joined: those ticks are over, but none with a move, which is what lets
    /// the server excuse them. Its first move after them counts as any other.
pub fn a_client_on_its_loading_screen_is_over_without_a_move() void {
}
    // rust: let run = Run {
    // rust: start: Vec3::new(20.5, 12.0, 20.5),
    // rust: script: vec![(0, 0.0); 20],
    // rust: frozen: 7,
    // rust: ..Run::walk()
}
    // rust: let Some(steps) = steps_in(run, |_, _, honest| honest, None) else {
    // rust: return;
}
    // rust: let (frozen, after) = steps.split_at(7);
    // rust: assert!(frozen.iter().any(|s| s.over.ticks > 0), "the replay falls");
    // rust: assert!(frozen.iter().all(|s| !s.over.moved));
    // rust: assert!(after.iter().all(|s| s.over.ticks == 0 || s.over.moved));
}

    /// Walking forward the whole script.
pub fn forward() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vec![(1, 0.0); 70]
}

    /// Food eaten one after another with the key held, walking (#5860): the client finishes each a
    /// few ticks after the server does. Nothing counts.
pub fn item_uses_a_few_ticks_apart_from_the_servers_are_played() void {
}
    // rust: let run = Run {
    // rust: script: forward(),
    // rust: item_use: Some((5..40, 5..37)),
    // rust: ..Run::walk()
}
    // rust: let Some(steps) = steps_in(run, |_, _, honest| honest, None) else {
    // rust: return;
}
    // rust: assert!(steps.iter().all(|s| s.over.ticks == 0));
    // rust: let run = Run {
    // rust: script: forward(),
    // rust: item_use: Some((10..42, 10..33)),
    // rust: ..Run::walk()
}
    // rust: let steps = steps_in(run, |_, _, honest| honest, None).unwrap();
    // rust: assert!(steps.iter().all(|s| s.over.ticks == 0));
}

    /// A client that keeps walking at full speed through a use the server started (a no-slow) is
    /// caught once the window has passed.
pub fn a_use_without_its_slowdown_is_caught() void {
}
    // rust: let run = Run {
    // rust: script: forward(),
    // rust: item_use: Some((0..0, 5..65)),
    // rust: ..Run::walk()
}
    // rust: let Some(steps) = steps_in(run, |_, _, honest| honest, None) else {
    // rust: return;
}
    // rust: let counted =
    // rust: |r: std::ops::Range<usize>| steps[r].iter().filter(|s| s.over.ticks > 0).count();
    // rust: assert!(counted(17..65) >= 40, "{}", counted(17..65));
}

pub fn a_played_tick_tells_its_offset_and_state() void {
}
    // rust: let played = Played {
    // rust: offset: 0.173,
    // rust: candidate: 0,
    // rust: ground: true,
    // rust: off: [0.0, 0.1729, -0.001],
    // rust: moved: 0.2806,
    // rust: state: Played::SPRINTING | Played::WATER,
    // rust: input: 1 | 16 | 64,
    // rust: at: [12.3, 63.004, -5.5],
    // rust: velocity: [0.0, 0.0412, -0.25],
}
    // rust: assert_eq!(
    // rust: played.describe(),
    // rust: "off +0.000 +0.173 -0.001, moved 0.281, air water sprinting, keys forward jump sprint, \
    // rust: at 12.30 63.00 -5.50, velocity +0.000 +0.041 -0.250"
    // rust: );
}

pub fn a_cheats_worst_tick_is_kept_with_its_offset() void {
}
    // rust: let Some(steps) = steps(
    // rust: |i, _, honest| honest.add_vector(Vec3::new(if i == 10 { 1.0 } else { 0.0 }, 0.0, 0.0)),
    // rust: None,
    // rust: ) else {
    // rust: return;
}
    // rust: let worst = steps[10].over.at_worst.expect("the lying tick is kept");
    // rust: assert!((worst.off[0] - 1.0).abs() < 0.05, "{worst:?}");
    // rust: assert!(worst.off[1].abs() < 1e-6 && worst.moved > 0.9, "{worst:?}");
    // rust: assert!(
    // rust: worst.describe().starts_with("off +1.0"),
    // rust: "{}",
    // rust: worst.describe()
    // rust: );
}

pub fn an_honest_client_is_played_again_exactly() void {
}
    // rust: let Some(played) = offsets(|_, honest| honest, None) else {
    // rust: return;
}
    // rust: assert_eq!(played.len(), script().len());
    // rust: for (i, p) in played.iter().enumerate() {
    // rust: assert!(p.offset <= EXACT, "tick {i}: {p:?}");
    // rust: assert!(p.ground, "tick {i}: {p:?}");
    // rust: assert!(p.candidate == 0 || i == 0, "tick {i}: {p:?}");
}
}

pub fn a_faster_or_flying_client_is_not() void {
}
    // rust: let Some(speed) = offsets(
    // rust: |before, honest| {
    // rust: let d = honest.subtract(before);
    // rust: before.add_vector(Vec3::new(d.x * 1.3, d.y, d.z * 1.3))
    // rust: },
    // rust: None,
    // rust: ) else {
    // rust: return;
}
    // rust: let far = speed.iter().filter(|p| p.offset > 0.01).count();
    // rust: assert!(far > 30, "{far} of {} ticks off: {speed:?}", speed.len());
    // rust: let fly = offsets(
    // rust: |_, honest| honest.add_vector(Vec3::new(0.0, 0.1, 0.0)),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(fly.iter().all(|p| p.offset > 0.05), "{fly:?}");
}

    /// Attributes sent mid sprint-jump: one without the movement speed leaves the client's sprint
    /// modifier alone (the server's body, which never sprinted here, has none to copy); one with the
    /// movement speed but no sprint modifier takes it away while the client sprints on.
pub fn attributes_sent_mid_sprint_are_played_as_the_client_takes_them() void {
}
    // rust: for sprint in [None, Some(false), Some(true)] {
    // rust: let run = Run {
    // rust: attributes: Some((25, sprint)),
    // rust: ..Run::walk()
}
    // rust: let Some(steps) = steps_in(run, |_, _, honest| honest, None) else {
    // rust: return;
}
    // rust: for (i, s) in steps.iter().enumerate() {
    // rust: assert!(
    // rust: s.played.offset <= EXACT,
    // rust: "{sprint:?}, tick {i}: {:?}",
    // rust: s.played
    // rust: );
}
}
}

    /// A knockback (ClientboundSetEntityMotionPacket) mid-walk: the replay applies it on the first
    /// client tick that had seen the server tick that sent it.
pub fn a_push_is_played_on_the_tick_the_client_took_it() void {
}
    // rust: let push = |taken| Push {
    // rust: tick: 25,
    // rust: velocity: [0.3, 0.42, -0.5],
    // rust: heard: true,
    // rust: excused: false,
    // rust: taken,
}
    // rust: let Some(honest) = offsets(|_, honest| honest, Some(push(true))) else {
    // rust: return;
}
    // rust: for (i, p) in honest.iter().enumerate() {
    // rust: assert!(p.offset <= EXACT && p.ground, "tick {i}: {p:?}");
}
        // Anti-knockback: a client that ignores the push.
    // rust: let ignored = offsets(|_, honest| honest, Some(push(false))).unwrap();
    // rust: assert!(ignored[..25].iter().all(|p| p.offset <= EXACT));
    // rust: assert!(ignored[25].offset > 0.3, "{:?}", ignored[25]);
}

    /// A client that starts flying mid-walk: each tick it flies counts, weighed by how far it is off,
    /// and the setback point stays where it last walked honestly.
pub fn a_cheat_counts_from_where_it_started() void {
}
    // rust: let Some(steps) = steps(
    // rust: |i, _, honest| honest.add_vector(Vec3::new(0.0, if i >= 20 { 0.06 } else { 0.0 }, 0.0)),
    // rust: None,
    // rust: ) else {
    // rust: return;
}
    // rust: for (i, s) in steps.iter().enumerate() {
    // rust: if i < 20 {
    // rust: assert_eq!(s.over, Over::default(), "tick {i}");
    // rust: assert_eq!(s.agreed, s.said, "tick {i}");
    // rust: } else {
    // rust: assert_eq!(s.over.ticks, 1, "tick {i}: {:?}", s.over);
    // rust: assert!(s.over.weight > 1.9, "tick {i}: {:?}", s.over);
    // rust: assert_eq!(s.agreed, steps[19].said, "tick {i}");
}
}
}

    /// Ticks that arrive together when the server's tick lags the client's are played in one
    /// catch-up: a lie on the first makes the replay stand at the client's spot, and the honest
    /// tick after it must not become the setback point (#5132).
pub fn a_burst_keeps_the_setback_before_its_lie() void {
}
    // rust: let Some(steps) = steps_in(
    // rust: Run {
    // rust: burst: Some((20, 21)),
    // rust: ..Run::walk()
    // rust: },
    // rust: |i, _, honest| {
    // rust: if i == 20 {
    // rust: honest.add_vector(Vec3::new(3.0, 0.0, 0.0))
    // rust: } else {
    // rust: honest
}
    // rust: },
    // rust: None,
    // rust: ) else {
    // rust: return;
}
        // Ticks 0-19 each play on their own; tick 20's lie arrives with tick 21, so the burst's
        // single step is the 21st: the lie counts once, and the setback point stays where the walk
        // agreed, before it.
    // rust: assert_eq!(
    // rust: steps.len(),
    // rust: script().len() - 1,
    // rust: "one catch-up for the burst"
    // rust: );
    // rust: let burst = &steps[20];
    // rust: assert_eq!(burst.over.ticks, 1, "{:?}", burst.over);
    // rust: assert!(burst.over.worst > 2.9, "{:?}", burst.over);
    // rust: assert_eq!(
    // rust: burst.agreed, steps[19].said,
    // rust: "the setback point must be the last honest spot"
    // rust: );
}

    /// A push the server never sent (another entity's): excused, the replay takes the client's
    /// velocity, is back within the tolerance in a few ticks, and nothing counts.
pub fn an_excused_push_is_caught_up_with() void {
}
    // rust: let push = Push {
    // rust: tick: 25,
    // rust: velocity: [0.3, 0.42, -0.5],
    // rust: heard: false,
    // rust: excused: true,
    // rust: taken: true,
}
    // rust: let Some(steps) = steps(|_, _, honest| honest, Some(push)) else {
    // rust: return;
}
    // rust: assert!(steps[25].played.offset > 0.3, "{:?}", steps[25].played);
    // rust: assert_eq!(steps[25].over.ticks, 1);
    // rust: for (i, s) in steps.iter().enumerate().skip(26) {
    // rust: assert_eq!(s.over, Over::default(), "tick {i}");
}
    // rust: let met = steps[26..].iter().position(|s| s.played.offset <= 0.03);
    // rust: assert!(
    // rust: met.is_some_and(|t| t < 6),
    // rust: "{:?}",
    // rust: steps.iter().map(|s| s.played.offset).collect::<Vec<_>>()
    // rust: );
}

    /// A push across the server never sent and doesn't excuse (a hit the replay missed): the replay
    /// tries the velocity it left on the next tick, so it counts once, not on each tick it takes to
    /// die out.
pub fn a_missed_push_counts_once() void {
}
    // rust: for velocity in [[0.3, 0.0, -0.2], [-0.25, 0.0, 0.1], [0.0, 0.0, 0.4]] {
            // The client's alone: the record never has it, and nothing excuses it.
    // rust: let push = Push {
    // rust: tick: 25,
    // rust: velocity,
    // rust: heard: false,
    // rust: excused: false,
    // rust: taken: true,
}
    // rust: let Some(steps) = steps(|_, _, honest| honest, Some(push)) else {
    // rust: return;
}
    // rust: let counted: Vec<usize> = steps
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, s)| s.over.ticks > 0)
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: assert_eq!(
    // rust: counted,
    // rust: vec![25],
    // rust: "{velocity:?}: {:?}",
    // rust: steps.iter().map(|s| s.played.offset).collect::<Vec<_>>()
    // rust: );
}
}

    /// What the catch-up of [`a_missed_push_counts_once`] costs: a small speed lie kept up on every
    /// tick of a sprint-jump (a twentieth of a block a tick) goes uncounted only while the velocity
    /// the replay took from its first tick still hides it; then it counts on every tick.
pub fn a_small_speed_lie_kept_up_still_counts() void {
}
    // rust: let run = Run {
    // rust: script: vec![(1 | 16 | 64, 0.0); 60],
    // rust: ..Run::walk()
}
    // rust: let Some(steps) = steps_in(
    // rust: run,
    // rust: |i, _, honest| honest.add_vector(Vec3::new(0.0, 0.0, if i >= 20 { 0.05 } else { 0.0 })),
    // rust: None,
    // rust: ) else {
    // rust: return;
}
    // rust: let counted: Vec<usize> = steps
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, s)| s.over.ticks > 0)
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: assert_eq!(counted.first(), Some(&20), "{counted:?}");
    // rust: assert!(counted.iter().all(|&i| i >= 20), "{counted:?}");
        // Measured: ticks 21 to 25 go uncounted, 35 of the 40 count.
    // rust: assert!(counted.len() >= 30, "{} of 40: {counted:?}", counted.len());
}

    /// A sprint stopped for one tick (forward let go) and started again: the server hears the STOP
    /// and the START in two of its ticks, and sends each back (the shared flags and the movement
    /// speed). The STOP's reach the client `late` ticks after it sprints again: its flag cleared, it
    /// starts the sprint again in its next aiStep, its modifier with it, and says nothing. The
    /// START's come one tick later (the live server's `ground sprinting` flags, 0.045 off).
pub fn sprint_restarted(late: usize, gap: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut script = vec![(1 | 64, 0.0); 20];
    // rust: script.push((0, 0.0));
    // rust: script.extend(vec![(1 | 64, 0.0); 20]);
    // rust: Run {
    // rust: script,
    // rust: server_sprint: vec![(21 + late, false), (21 + late + gap, true)],
    // rust: ..Run::walk()
}
}

pub fn a_sprint_the_server_cleared_is_started_again() void {
}
    // rust: for (late, gap) in [(1, 1), (2, 1), (3, 2)] {
    // rust: let Some(steps) = steps_in(sprint_restarted(late, gap), |_, _, honest| honest, None)
    // rust: else {
    // rust: return;
}
    // rust: for (i, s) in steps.iter().enumerate() {
    // rust: assert!(
    // rust: s.played.offset <= EXACT && s.over == Over::default(),
    // rust: "late {late}, gap {gap}, tick {i}: {:?}",
    // rust: s.played
    // rust: );
}
}
}

    /// The same with a speed lie (a twentieth of a block a tick) from the tick the STOP's packets
    /// reach the client: it counts from that tick on.
pub fn a_speed_lie_through_a_sprint_restart_still_counts() void {
}
    // rust: let Some(steps) = steps_in(
    // rust: sprint_restarted(2, 1),
    // rust: |i, _, honest| honest.add_vector(Vec3::new(0.0, 0.0, if i >= 23 { 0.05 } else { 0.0 })),
    // rust: None,
    // rust: ) else {
    // rust: return;
}
    // rust: let counted: Vec<usize> = steps
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, s)| s.over.ticks > 0)
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: assert_eq!(counted.first(), Some(&23), "{counted:?}");
    // rust: assert!(counted.len() >= 10, "{} of 18: {counted:?}", counted.len());
}

    /// A sprint the server stopped after a hit (Player.causeExtraKnockback), which the client's own
    /// attack on a mob doesn't: the server's flag and movement speed reach the client on tick 14.
    /// Forward is held throughout, the sprint key for the first 10 ticks, and for the rest if `key`.
    /// The client's own commands say what it does: with the key it starts the sprint again in its
    /// next aiStep and says nothing (the live server's `ground, keys forward sprint` flags, where
    /// the record took the server's player and played the rest of the sprint as a walk); without it
    /// it stops and says STOP. `water`: the same swimming across a pool, toward its surface.
pub fn sprint_hit(key: bool, water: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sprint = if key { 64 } else { 0 };
    // rust: let mut script = vec![(1 | 64, 0.0); 10];
    // rust: script.extend(vec![(1 | sprint, 0.0); 40]);
    // rust: let mut blocks = Vec::new();
    // rust: if water {
    // rust: for x in 14..=26 {
    // rust: for y in 5..=7 {
    // rust: for z in 14..=40 {
    // rust: blocks.push(([x, y, z], "minecraft:water"));
}
}
}
}
    // rust: Run {
    // rust: script,
    // rust: pitch: if water { -8.0 } else { 0.0 },
    // rust: blocks,
    // rust: server_sprint: vec![(14, false)],
    // rust: ..Run::walk()
}
}

pub fn a_sprint_the_server_stopped_after_a_hit_is_the_clients() void {
}
    // rust: for (key, water) in [(true, false), (false, false), (true, true), (false, true)] {
    // rust: let Some(steps) = steps_in(sprint_hit(key, water), |_, _, honest| honest, None) else {
    // rust: return;
}
    // rust: for (i, s) in steps.iter().enumerate() {
    // rust: assert!(
    // rust: s.played.offset <= EXACT && s.over == Over::default(),
    // rust: "key {key}, water {water}, tick {i}: {:?}",
    // rust: s.played
    // rust: );
}
            // The client sprints on after the hit only with the key.
    // rust: let last = steps.last().unwrap().played.state;
    // rust: assert_eq!(
    // rust: last & Played::SPRINTING != 0,
    // rust: key,
    // rust: "water {water}: {last:b}"
    // rust: );
}
}

    /// A client that sprints on through the server's stop without the sprint key, which vanilla's
    /// starts again only with it, is played walking from the tick the stop reaches it; one that
    /// holds the key and moves a twentieth of a block a tick too far counts from there too.
pub fn a_sprint_kept_without_the_key_or_sped_up_after_a_hit_counts() void {
}
    // rust: for water in [false, true] {
    // rust: let kept = Run {
    // rust: keep_sprint: true,
    // rust: ..sprint_hit(false, water)
}
    // rust: let fast = |i: usize, _, honest: Vec3| {
    // rust: honest.add_vector(Vec3::new(0.0, 0.0, if i >= 14 { 0.05 } else { 0.0 }))
}
    // rust: for (name, steps) in [
    // rust: ("kept", steps_in(kept, |_, _, honest| honest, None)),
    // rust: ("fast", steps_in(sprint_hit(true, water), fast, None)),
    // rust: ] {
    // rust: let Some(steps) = steps else {
    // rust: return;
}
    // rust: let counted: Vec<usize> = steps
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, s)| s.over.ticks > 0)
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: assert!(
    // rust: counted.first().is_some_and(|&i| (14..=16).contains(&i)),
    // rust: "{name}, water {water}: {counted:?}"
    // rust: );
    // rust: assert!(
    // rust: counted.len() >= 25,
    // rust: "{name}, water {water}: {} of 36: {counted:?}",
    // rust: counted.len()
    // rust: );
}
}
}

    /// An elytra: a jump while falling starts a glide, played again exactly.
pub fn a_glide_is_played_again_exactly() void {
}
    // rust: let mut script = vec![(0, 0.0); 4];
    // rust: script.push((16, 0.0));
    // rust: script.extend(vec![(0, 0.0); 25]);
    // rust: let run = Run {
    // rust: start: Vec3::new(20.5, 40.0, 12.5),
    // rust: script,
    // rust: pitch: 10.0,
    // rust: glider: true,
    // rust: ..Run::walk()
}
    // rust: let Some(steps) = steps_in(run, |_, _, honest| honest, None) else {
    // rust: return;
}
    // rust: let offsets: Vec<f64> = steps.iter().map(|s| s.played.offset).collect();
    // rust: assert!(offsets.iter().all(|&o| o <= EXACT), "{offsets:?}");
        // It glided: forward, not just down.
    // rust: let forward = steps.last().unwrap().said[2] - steps[4].said[2];
    // rust: assert!(forward > 5.0, "{forward}");
}

    /// A teleport accepted after a burst of ticks the server hadn't played yet: the replay plays
    /// them first, so the jump delay they started goes on through the teleport as the client's does.
pub fn a_burst_before_a_teleport_is_played_first() void {
}
    // rust: let mut run = Run::walk();
        // The burst holds the first sprint-jump (tick 20). Back on the floor at tick 23, the client
        // holds jump but its jump delay (10 ticks from 20) holds it until tick 30.
    // rust: run.teleport = Some((19, 23));
    // rust: let Some(steps) = steps_in(run, |_, _, honest| honest, None) else {
    // rust: return;
}
    // rust: let offsets: Vec<f64> = steps.iter().map(|s| s.played.offset).collect();
    // rust: assert!(offsets.iter().all(|&o| o <= EXACT), "{offsets:?}");
    // rust: assert!(steps.iter().all(|s| s.over == Over::default()));
}

    /// A client walking 40 ticks towards +z, over the slab, into `blocks`, its moves passed through
    /// `cheat`: the tick the cheat starts counts, and none before it does.
pub fn caught(blocks: Vec<([i32; 3]) void {
}
    // rust: let run = Run {
    // rust: script: vec![(1, 0.0); 40],
    // rust: blocks,
    // rust: ..Run::walk()
}
    // rust: let started = std::cell::Cell::new(None);
    // rust: let Some(steps) = steps_in(
    // rust: run,
    // rust: |i, before, honest| match cheat(before, honest) {
    // rust: Some(p) => {
    // rust: started.set(started.get().or(Some(i)));
    // rust: p
}
    // rust: None => honest,
    // rust: },
    // rust: None,
    // rust: ) else {
    // rust: return;
}
    // rust: let start = started.get().expect("the cheat never started");
    // rust: for (i, s) in steps.iter().enumerate().take(start) {
    // rust: assert_eq!(s.over, Over::default(), "tick {i}");
}
    // rust: assert_eq!(steps[start].over.ticks, 1, "{:?}", steps[start].played);
    // rust: let counted = steps[start..].iter().filter(|s| s.over.ticks > 0).count();
    // rust: assert!(counted > 0, "{counted}");
}

    /// A wall at z 25 (from y 5 up), which the walk runs into at z 24.7.
pub fn wall(height: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (19..=21)
    // rust: .flat_map(|x| (5..5 + height).map(move |y| ([x, y, 25], "minecraft:stone")))
    // rust: .collect()
}

    /// Step: up onto a full block without a jump (the most a walk steps up is 0.6).
pub fn a_step_is_caught() void {
}
    // rust: caught(wall(1), |before, honest| {
    // rust: (honest.z > 24.6 && before.y < 6.0).then(|| Vec3::new(honest.x, 6.0, 25.1))
    // rust: });
}

    /// Spider: up a wall, 0.2 a tick, with no ladder or vine.
pub fn a_spider_is_caught() void {
}
    // rust: caught(wall(4), |before, honest| {
    // rust: (honest.z > 24.6).then(|| Vec3::new(honest.x, before.y + 0.2, honest.z))
    // rust: });
}

    /// Jesus: walking on water as on the ground.
pub fn a_jesus_is_caught() void {
}
    // rust: let water = (19..=21)
    // rust: .flat_map(|x| (25..=40).map(move |z| ([x, 4, z], "minecraft:water")))
    // rust: .collect();
    // rust: caught(water, |before, honest| {
    // rust: (honest.z > 25.4 && honest.y < before.y)
    // rust: .then(|| Vec3::new(honest.x, before.y, honest.z))
    // rust: });
}
}
