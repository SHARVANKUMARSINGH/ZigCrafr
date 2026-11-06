//! Transpiled from Horizon Rust crate
//! Module: horizon-client_waypoints
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The locator bar for remote players: ServerWaypointManager and
//! WaypointTransmitter's connections, for players (the transmitters vanilla has
//! by default: `waypoint_transmit_range` is 0 for every other entity).
//!
//! Vanilla updates a player's connections each time the player's position
//! changes (`Entity.setPosRaw`, then `ServerChunkCache.move`). The hub sees the
//! position once a tick, after the moves it handled, and updates from there:
//! the same packets, since a client sends one move a tick. Hiding (crouching,
//! invisibility, a carved pumpkin or a mob head worn) changes
//! `waypoint_transmit_range` and tracks or untracks the waypoint, as
//! `LivingEntity.onAttributeUpdated` does; joining or leaving a team remakes the
//! connections with the team's colour (`ServerScoreboard.updatePlayerWaypoint`).
// use crate::fast_hash::FxHashMap as HashMap;
// use horizon_protocol::packets::play::{
    // rust: Clientbound as C, TrackedWaypoint, WaypointId, WaypointTarget, waypoint_operation,
}

/// `Player.createAttributes`: both waypoint ranges.
pub const PLAYER_RANGE: f64 = 6.0e7;
/// `WaypointTransmitter.REALLY_FAR_DISTANCE`.
pub const REALLY_FAR: f32 = 332.0;
/// `EntityAzimuthConnection.update`: half a degree.
pub const AZIMUTH_STEP: f32 = 0.008_726_646;

/// Items that hide their wearer (`Waypoint.addHideAttribute` on the head slot).
    // rust: pub const HIDING_HEADS: [&str; 8] = [
    // rust: "minecraft:carved_pumpkin",
    // rust: "minecraft:skeleton_skull",
    // rust: "minecraft:wither_skeleton_skull",
    // rust: "minecraft:player_head",
    // rust: "minecraft:zombie_head",
    // rust: "minecraft:creeper_head",
    // rust: "minecraft:dragon_head",
    // rust: "minecraft:piglin_head",
    // rust: ];

/// A team colour as the locator bar draws it (`Waypoint.Icon.cloneAndAssignStyle`:
/// `TeamColor.rgb()`, black lightened so it shows).
pub fn team_rgb(color: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rgb = match color {
    // rust: "black" => return Some(-13_619_152),
    // rust: "dark_blue" => 0x0000AA,
    // rust: "dark_green" => 0x00AA00,
    // rust: "dark_aqua" => 0x00AAAA,
    // rust: "dark_red" => 0xAA0000,
    // rust: "dark_purple" => 0xAA00AA,
    // rust: "gold" => 0xFFAA00,
    // rust: "gray" => 0xAAAAAA,
    // rust: "dark_gray" => 0x555555,
    // rust: "blue" => 0x5555FF,
    // rust: "green" => 0x55FF55,
    // rust: "aqua" => 0x55FFFF,
    // rust: "red" => 0xFF5555,
    // rust: "light_purple" => 0xFF55FF,
    // rust: "yellow" => 0xFFFF55,
    // rust: "white" => 0xFFFFFF,
    // rust: _ => return None,
}
    // rust: Some(rgb)
}

/// Waypoint.Icon.
pub const Icon = struct {
    style: []const u8,
    color: ?i32,
};

    // rust: impl Default for Icon {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: style: "minecraft:default".into(),
    // rust: color: None,
}
}
}

/// A player as the waypoint manager sees them this tick.
pub const Player = struct {
    uuid: u128,
    /// The connection that receives the player's locator bar (None: the host,
    /// whose own game draws it).
    conn: ?u32,
    position: [f64,
    spectator: bool,
    /// `waypoint_transmit_range`: 0 while hidden.
    transmit_range: f64,
    receive_range: f64,
    /// `Entity.firstTick`: the player has not ticked since joining.
    first_tick: bool,
    /// The chunk view radius (`ChunkMap.getPlayerViewDistance`).
    view_distance: i32,
    /// The player's team and its colour (`TeamColor.rgb`).
    team: Option<([]const u8,
    /// The icon `/waypoint modify` set.
    icon: Icon,
};

    // rust: impl Player {
pub fn block(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.position.map(|v| v.floor() as i32)
}
pub fn chunk(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, _, z] = self.block();
    // rust: [x >> 4, z >> 4]
}
    /// `Entity.distanceTo`.
pub fn distance_to(self: *Self, other: *Player) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d2: f64 = (0..3)
    // rust: .map(|k| (self.position[k] - other.position[k]).powi(2))
    // rust: .sum();
    // rust: d2.sqrt() as f32
}
}

pub const Kind = enum {
    Block([i32; 3]),
    Chunk([i32; 2]),
    Azimuth(f32),
};

pub const Connection = struct {
    kind: Kind,
    icon: Icon,
};

/// What the manager remembers of a player between ticks.
pub const Memo = struct {
    position: [f64,
    /// The centre of the player's ChunkTrackingView (`ChunkMap.move`).
    view_center: [i32,
    transmitting: bool,
    team: Option<([]const u8,
};

/// ServerWaypointManager for one level.
pub const Waypoints = struct {
    /// The transmitters, in the order they were tracked.
    waypoints: std.ArrayList(u128),
    /// The receivers, in the order they joined.
    players: std.ArrayList(u128),
    /// Connections by receiver, then source.
    connections: HashMap<u128,
    memo: HashMap<u128,
    /// The `locator_bar` game rule as last seen.
    enabled: ?bool,
};

/// One tick's players, and the packets for their connections.
pub const Tick = struct {
    players: HashMap<u128,
    /// The connections of the players in other levels: one who just left this level is
    /// still told of the waypoints it loses (`removePlayer` disconnects them).
    away: *'a [(u128,
    view: HashMap<u128,
    /// Players a respawn replaced this tick: a new ServerPlayer, on its first tick.
    fresh: *'a [u128],
    enabled: bool,
    out: Vec<(u32,
};

    // rust: impl<'a> Tick<'a> {
    // rust: fn send(
    // rust: &mut self,
    // rust: receiver: u128,
    // rust: source: u128,
    // rust: operation: i32,
    // rust: icon: &Icon,
    // rust: target: WaypointTarget,
    // rust: ) {
    // rust: let Some(conn) = self
    // rust: .players
    // rust: .get(&receiver)
    // rust: .and_then(|p| p.conn)
    // rust: .or_else(|| {
    // rust: self.away
    // rust: .iter()
    // rust: .find(|(uuid, _)| *uuid == receiver)
    // rust: .map(|&(_, conn)| conn)
    // rust: })
    // rust: else {
    // rust: return;
}
    // rust: self.out
    // rust: .push((conn, waypoint(source, operation, icon, target)));
}
pub fn connect(self: *Self, receiver: u128, source: u128, c: *Connection) void {
}
    // rust: let target = match c.kind {
    // rust: Kind::Block(p) => WaypointTarget::Block(p),
    // rust: Kind::Chunk(p) => WaypointTarget::Chunk(p),
    // rust: Kind::Azimuth(a) => WaypointTarget::Azimuth(a),
}
    // rust: self.send(receiver, source, waypoint_operation::TRACK, &c.icon, target);
}
    /// `ClientboundTrackedWaypointPacket.removeWaypoint`: an empty waypoint with the null icon.
pub fn disconnect(self: *Self, receiver: u128, source: u128) void {
}
    // rust: self.send(
    // rust: receiver,
    // rust: source,
    // rust: waypoint_operation::UNTRACK,
    // rust: &Icon::default(),
    // rust: WaypointTarget::Empty,
    // rust: );
}
    /// `ChunkTrackingView.isInViewDistance` of the receiver's view.
pub fn chunk_visible(self: *Self, z]: [i32; 2], receiver: u128) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(&([cx, cz], r)) = self.view.get(&receiver) else {
    // rust: return false;
}
    // rust: let dx = i64::from(((x - cx).abs() - 1).max(0));
    // rust: let dz = i64::from(((z - cz).abs() - 1).max(0));
    // rust: dx * dx + dz * dz < i64::from(r) * i64::from(r)
}
    /// `WaypointTransmitter.doesSourceIgnoreReceiver`.
pub fn ignores(self: *Self, source: *Player, receiver: *Player) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if receiver.spectator {
    // rust: return false;
}
    // rust: if source.spectator {
    // rust: return true;
}
    // rust: let range = source.transmit_range.min(receiver.receive_range);
    // rust: f64::from(source.distance_to(receiver)) >= range
}
pub fn really_far(source: *Player, receiver: *Player) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: source.distance_to(receiver) > REALLY_FAR
}
    /// `EntityAzimuthConnection`: the angle of the receiver seen from the source,
    /// `Mth.atan2` of the offset turned clockwise.
pub fn azimuth(source: *Player, receiver: *Player) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = [0, 1, 2].map(|k| receiver.position[k] - source.position[k]);
    // rust: horizon_core::geometry::trig::atan2(d[0], -d[2]) as f32
}
    /// The source and the receiver, if both are in the level this tick.
pub fn pair(self: *Self, source: u128, receiver: u128) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some((*self.players.get(&source)?, *self.players.get(&receiver)?))
}
    /// `LivingEntity.makeWaypointConnectionWith`.
pub fn make(self: *Self) void {
}
    // rust: if s.first_tick || self.fresh.contains(&s.uuid) || s.uuid == r.uuid || self.ignores(s, r) {
    // rust: return None;
}
        // Waypoint.Icon.cloneAndAssignStyle: the icon's colour, else the team's.
    // rust: let mut icon = s.icon.clone();
    // rust: if icon.color.is_none() {
    // rust: icon.color = s.team.as_ref().and_then(|t| t.1);
}
    // rust: let kind = if Self::really_far(s, r) {
    // rust: Kind::Azimuth(Self::azimuth(s, r))
    // rust: } else if !self.chunk_visible(s.chunk(), r.uuid) {
    // rust: Kind::Chunk(s.chunk())
    // rust: } else {
    // rust: Kind::Block(s.block())
}
    // rust: Some(Connection { kind, icon })
}
    /// `Connection.isBroken` for each kind.
pub fn broken(self: *Self, c: *Connection) void {
}
    // rust: let receiver = r.uuid;
    // rust: match c.kind {
    // rust: Kind::Block(last) => {
    // rust: let now = s.block();
    // rust: (0..3).map(|k| (now[k] - last[k]).abs()).sum::<i32>() > 1 || self.ignores(s, r)
}
    // rust: Kind::Chunk(last) => {
    // rust: let now = s.chunk();
    // rust: let moved = (now[0] - last[0]).abs().max((now[1] - last[1]).abs());
    // rust: moved > 1 || self.ignores(s, r) || self.chunk_visible(last, receiver)
}
    // rust: Kind::Azimuth(_) => {
    // rust: self.ignores(s, r)
    // rust: || self.chunk_visible(s.chunk(), receiver)
    // rust: || !Self::really_far(s, r)
}
}
}
    /// `Connection.update`: the packet when the waypoint moved.
pub fn update(self: *Self, c: *mut Connection) void {
}
    // rust: let target = match &mut c.kind {
    // rust: Kind::Block(last) => {
    // rust: let now = s.block();
    // rust: if now == *last {
    // rust: return;
}
    // rust: *last = now;
    // rust: WaypointTarget::Block(now)
}
    // rust: Kind::Chunk(last) => {
    // rust: let now = s.chunk();
    // rust: if now == *last {
    // rust: return;
}
    // rust: *last = now;
    // rust: WaypointTarget::Chunk(now)
}
    // rust: Kind::Azimuth(last) => {
    // rust: let now = Self::azimuth(s, r);
    // rust: if (now - *last).abs() <= AZIMUTH_STEP {
    // rust: return;
}
    // rust: *last = now;
    // rust: WaypointTarget::Azimuth(now)
}
}
    // rust: if let Some(conn) = r.conn {
    // rust: self.out.push((
    // rust: conn,
    // rust: waypoint(s.uuid, waypoint_operation::UPDATE, &c.icon, target),
    // rust: ));
}
}
}

pub fn waypoint(source: u128, operation: i32, icon: *Icon, target: WaypointTarget) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: C::TrackedWaypoint(TrackedWaypoint {
    // rust: operation,
    // rust: id: WaypointId::Uuid(source),
    // rust: style: icon.style.clone(),
    // rust: color: icon.color,
    // rust: target,
    // rust: })
}

    // rust: impl Waypoints {
pub fn put(self: *Self, receiver: u128, source: u128, c: Connection) void {
}
    // rust: let row = self.connections.entry(receiver).or_default();
    // rust: match row.iter_mut().find(|(s, _)| *s == source) {
    // rust: Some(slot) => slot.1 = c,
    // rust: None => row.push((source, c)),
}
}
pub fn take(self: *Self, receiver: u128, source: u128) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let row = self.connections.get_mut(&receiver)?;
    // rust: let i = row.iter().position(|(s, _)| *s == source)?;
    // rust: Some(row.remove(i).1)
}

    /// `createConnection`.
pub fn create_connection(self: *Self, t: *mut Tick, receiver: u128, source: u128) void {
}
    // rust: if receiver == source || !t.enabled {
    // rust: return;
}
    // rust: match t.pair(source, receiver).and_then(|pair| t.make(pair)) {
    // rust: Some(c) => {
    // rust: t.connect(receiver, source, &c);
    // rust: self.put(receiver, source, c);
}
    // rust: None => {
    // rust: if self.take(receiver, source).is_some() {
    // rust: t.disconnect(receiver, source);
}
}
}
}
    /// The receiver's connection to the source updated in its place
    /// (`updateConnection`), or made if it has none (`createConnection`).
pub fn update_or_create(self: *Self, t: *mut Tick, receiver: u128, source: u128) void {
}
    // rust: if receiver == source || !t.enabled {
    // rust: return;
}
    // rust: let Some(row) = self.connections.get_mut(&receiver) else {
    // rust: return self.create_connection(t, receiver, source);
}
    // rust: let Some(i) = row.iter().position(|(s, _)| *s == source) else {
    // rust: return self.create_connection(t, receiver, source);
}
    // rust: let c = &mut row[i].1;
        // A connection to a player who isn't in the level is broken.
    // rust: let pair = t.pair(source, receiver);
    // rust: if let Some(pair) = pair
    // rust: && !t.broken(c, pair)
    // rust: {
    // rust: t.update(c, pair);
    // rust: return;
}
    // rust: match pair.and_then(|pair| t.make(pair)) {
    // rust: Some(new) => {
    // rust: t.connect(receiver, source, &new);
    // rust: *c = new;
}
    // rust: None => {
    // rust: t.disconnect(receiver, source);
    // rust: row.remove(i);
}
}
}
    /// `trackWaypoint`.
pub fn track(self: *Self, t: *mut Tick, source: u128) void {
}
    // rust: if !self.waypoints.contains(&source) {
    // rust: self.waypoints.push(source);
}
    // rust: for receiver in self.players.clone() {
    // rust: self.create_connection(t, receiver, source);
}
}
    /// `updateWaypoint`.
pub fn update_waypoint(self: *Self, t: *mut Tick, source: u128) void {
}
    // rust: if !self.waypoints.contains(&source) {
    // rust: return;
}
        // Connections change; the players don't.
    // rust: for k in 0..self.players.len() {
    // rust: self.update_or_create(t, self.players[k], source);
}
}
    /// `untrackWaypoint`.
pub fn untrack(self: *Self, t: *mut Tick, source: u128) void {
}
    // rust: for receiver in self.players.clone() {
    // rust: if self.take(receiver, source).is_some() {
    // rust: t.disconnect(receiver, source);
}
}
    // rust: self.waypoints.retain(|w| *w != source);
}
    /// `addPlayer`.
pub fn add_player(self: *Self, t: *mut Tick, player: u128, transmitting: bool) void {
}
    // rust: if !self.players.contains(&player) {
    // rust: self.players.push(player);
}
    // rust: for source in self.waypoints.clone() {
    // rust: self.create_connection(t, player, source);
}
    // rust: if transmitting {
    // rust: self.track(t, player);
}
}
    /// `updatePlayer`.
pub fn update_player(self: *Self, t: *mut Tick, player: u128) void {
}
        // Connections change; the waypoints don't.
    // rust: for k in 0..self.waypoints.len() {
    // rust: self.update_or_create(t, player, self.waypoints[k]);
}
}
    /// `removePlayer`.
pub fn remove_player(self: *Self, t: *mut Tick, player: u128) void {
}
    // rust: for (source, _) in self.connections.remove(&player).unwrap_or_default() {
    // rust: t.disconnect(player, source);
}
    // rust: self.untrack(t, player);
    // rust: self.players.retain(|p| *p != player);
}
    /// `breakAllConnections`.
pub fn break_all(self: *Self, t: *mut Tick) void {
}
    // rust: for receiver in self.players.clone() {
    // rust: for (source, _) in self.connections.remove(&receiver).unwrap_or_default() {
    // rust: t.disconnect(receiver, source);
}
}
    // rust: self.connections.clear();
}

    /// One tick: players who left, joined, moved, hid or changed team, and the
    /// `locator_bar` game rule. `respawned` players are removed and added again,
    /// as `PlayerList.respawn` replaces the ServerPlayer. Returns the packets for
    /// each connection.
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: players: &[Player],
    // rust: respawned: &[u128],
    // rust: locator_bar: bool,
    // rust: ) -> Vec<(u32, C)> {
    // rust: self.tick_level(players, &[], respawned, locator_bar)
}

    /// [`Self::tick`] for one level of several: `away` are the connections of the players
    /// in the other levels, for the untracks owed to one who has just left this one.
    // rust: pub fn tick_level(
    // rust: &mut self,
    // rust: players: &[Player],
    // rust: away: &[(u128, u32)],
    // rust: respawned: &[u128],
    // rust: locator_bar: bool,
    // rust: ) -> Vec<(u32, C)> {
    // rust: let mut t = Tick {
    // rust: players: players.iter().map(|p| (p.uuid, p)).collect(),
    // rust: away,
    // rust: view: HashMap::default(),
    // rust: fresh: respawned,
    // rust: enabled: locator_bar,
    // rust: out: Vec::new(),
}
        // Vanilla reads the rule when it connects; changing it breaks or remakes
        // every connection (MinecraftServer.onGameRuleChanged).
    // rust: let was = self.enabled.replace(locator_bar);
    // rust: for (uuid, memo) in &self.memo {
    // rust: if let Some(p) = t.players.get(uuid) {
    // rust: t.view.insert(*uuid, (memo.view_center, p.view_distance));
}
}
        // Players who left, and the ServerPlayer a respawn replaced.
    // rust: let gone: Vec<u128> = self
    // rust: .players
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|uuid| !t.players.contains_key(uuid) || respawned.contains(uuid))
    // rust: .collect();
    // rust: for uuid in gone {
    // rust: self.remove_player(&mut t, uuid);
    // rust: self.memo.remove(&uuid);
}
    // rust: if was == Some(true) && !locator_bar {
    // rust: self.break_all(&mut t);
}
        // Players who joined (PlayerList.placeNewPlayer: addPlayer).
    // rust: for p in players {
    // rust: if self.memo.contains_key(&p.uuid) {
    // rust: continue;
}
    // rust: let center = p.chunk();
    // rust: t.view.insert(p.uuid, (center, p.view_distance));
    // rust: let transmitting = p.transmit_range > 0.0;
    // rust: self.memo.insert(
    // rust: p.uuid,
    // rust: Memo {
    // rust: position: p.position,
    // rust: view_center: center,
    // rust: transmitting,
    // rust: team: p.team.clone(),
    // rust: },
    // rust: );
    // rust: if p.receive_range > 0.0 {
    // rust: self.add_player(&mut t, p.uuid, transmitting);
    // rust: } else if transmitting {
    // rust: self.track(&mut t, p.uuid);
}
}
    // rust: if was == Some(false) && locator_bar {
    // rust: for player in self.players.clone() {
    // rust: self.update_player(&mut t, player);
}
}
    // rust: for p in players {
    // rust: let memo = &self.memo[&p.uuid];
            // Entity.setPosRaw, then ServerChunkCache.move.
    // rust: if memo.position != p.position {
    // rust: let moved_view = memo.view_center != p.chunk();
    // rust: let transmitting = memo.transmitting;
    // rust: self.memo.get_mut(&p.uuid).unwrap().position = p.position;
    // rust: if !p.first_tick {
    // rust: if transmitting {
    // rust: self.update_waypoint(&mut t, p.uuid);
}
    // rust: if p.receive_range > 0.0 {
    // rust: self.update_player(&mut t, p.uuid);
}
}
    // rust: if moved_view {
    // rust: self.memo.get_mut(&p.uuid).unwrap().view_center = p.chunk();
    // rust: t.view.insert(p.uuid, (p.chunk(), p.view_distance));
}
    // rust: if p.receive_range > 0.0 {
    // rust: self.update_player(&mut t, p.uuid);
}
}
            // LivingEntity.onAttributeUpdated(WAYPOINT_TRANSMIT_RANGE).
    // rust: let transmitting = p.transmit_range > 0.0;
    // rust: if transmitting != self.memo[&p.uuid].transmitting {
    // rust: self.memo.get_mut(&p.uuid).unwrap().transmitting = transmitting;
    // rust: if transmitting {
    // rust: self.track(&mut t, p.uuid);
    // rust: } else {
    // rust: self.untrack(&mut t, p.uuid);
}
}
            // ServerScoreboard: a team joined, left or recoloured remakes the connections.
    // rust: if p.team != self.memo[&p.uuid].team {
    // rust: self.memo.get_mut(&p.uuid).unwrap().team = p.team.clone();
    // rust: for receiver in self.players.clone() {
    // rust: self.create_connection(&mut t, receiver, p.uuid);
}
}
}
    // rust: t.out
}
}

    // rust: mod tests {
//     use super::*;

pub fn player(uuid: u128, conn: u32, position: [f64; 3]) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Player {
    // rust: uuid,
    // rust: conn: Some(conn),
    // rust: position,
    // rust: spectator: false,
    // rust: transmit_range: PLAYER_RANGE,
    // rust: receive_range: PLAYER_RANGE,
    // rust: first_tick: false,
    // rust: view_distance: 4,
    // rust: team: None,
    // rust: icon: Icon::default(),
}
}

    /// The packets to `conn`, as (operation, target).
pub fn to(out: *[(u32) void {
}
    // rust: out.iter()
    // rust: .filter(|(c, _)| *c == conn)
    // rust: .map(|(_, p)| match p {
    // rust: C::TrackedWaypoint(w) => (w.operation, w.target),
    // rust: other => panic!("{other:?}"),
    // rust: })
    // rust: .collect()
}

pub fn a_new_player_shows_once_it_moves() void {
}
    // rust: let mut w = Waypoints::default();
    // rust: let a = player(1, 10, [0.5, 100.0, 0.5]);
    // rust: let mut b = player(2, 20, [5.5, 100.0, 0.5]);
    // rust: b.first_tick = true;
    // rust: w.tick(std::slice::from_ref(&a), &[], true);
    // rust: let out = w.tick(&[a.clone(), b.clone()], &[], true);
        // B gets A at once; A sees nothing of B while B hasn't ticked.
    // rust: assert_eq!(to(&out, 20), [(0, WaypointTarget::Block([0, 100, 0]))]);
    // rust: assert!(to(&out, 10).is_empty());
    // rust: b.first_tick = false;
    // rust: assert!(w.tick(&[a.clone(), b.clone()], &[], true).is_empty());
    // rust: b.position[0] += 1.0;
    // rust: let out = w.tick(&[a.clone(), b.clone()], &[], true);
    // rust: assert_eq!(to(&out, 10), [(0, WaypointTarget::Block([6, 100, 0]))]);
        // One block: an update. Three: a new connection. Out of view: a chunk.
    // rust: b.position[0] += 1.0;
    // rust: let out = w.tick(&[a.clone(), b.clone()], &[], true);
    // rust: assert_eq!(to(&out, 10), [(2, WaypointTarget::Block([7, 100, 0]))]);
    // rust: b.position[0] += 3.0;
    // rust: let out = w.tick(&[a.clone(), b.clone()], &[], true);
    // rust: assert_eq!(to(&out, 10), [(0, WaypointTarget::Block([10, 100, 0]))]);
    // rust: b.position[0] = 100.5;
    // rust: let out = w.tick(&[a.clone(), b.clone()], &[], true);
    // rust: assert_eq!(to(&out, 10), [(0, WaypointTarget::Chunk([6, 0]))]);
        // Really far: an angle.
    // rust: b.position[0] = 1000.5;
    // rust: let out = w.tick(&[a.clone(), b.clone()], &[], true);
    // rust: assert!(matches!(
    // rust: to(&out, 10)[..],
    // rust: [(0, WaypointTarget::Azimuth(_))]
    // rust: ));
        // Hidden: untracked; the rule off: every connection broken.
    // rust: b.transmit_range = 0.0;
    // rust: let out = w.tick(&[a.clone(), b.clone()], &[], true);
    // rust: assert_eq!(to(&out, 10), [(1, WaypointTarget::Empty)]);
    // rust: let out = w.tick(&[a.clone(), b.clone()], &[], false);
    // rust: assert_eq!(to(&out, 20), [(1, WaypointTarget::Empty)]);
    // rust: assert!(to(&out, 10).is_empty());
        // Leaving untracks what was left.
    // rust: let out = w.tick(&[a.clone(), b.clone()], &[], true);
    // rust: assert!(matches!(
    // rust: to(&out, 20)[..],
    // rust: [(0, WaypointTarget::Azimuth(_))]
    // rust: ));
    // rust: let out = w.tick(&[b.clone()], &[], true);
    // rust: assert_eq!(to(&out, 20), [(1, WaypointTarget::Empty)]);
}

pub fn a_player_leaving_the_level_loses_its_waypoints() void {
}
    // rust: let (a, b) = (
    // rust: player(1, 10, [0.5, 64.0, 0.5]),
    // rust: player(2, 20, [4.5, 64.0, 0.5]),
    // rust: );
    // rust: let mut w = Waypoints::default();
    // rust: w.tick(&[a.clone(), b.clone()], &[], true);
    // rust: let mut moved = b.clone();
    // rust: moved.position = [5.5, 64.0, 0.5];
    // rust: w.tick(&[a.clone(), moved], &[], true);
        // B goes to another level: A loses B, and B (reached through `away`) loses A.
    // rust: let out = w.tick_level(std::slice::from_ref(&a), &[(2, 20)], &[], true);
    // rust: assert_eq!(
    // rust: to(&out, 10),
    // rust: vec![(waypoint_operation::UNTRACK, WaypointTarget::Empty)]
    // rust: );
    // rust: assert_eq!(
    // rust: to(&out, 20),
    // rust: vec![(waypoint_operation::UNTRACK, WaypointTarget::Empty)]
    // rust: );
}

pub fn team_colours() void {
}
    // rust: assert_eq!(team_rgb("red"), Some(0xFF5555));
    // rust: assert_eq!(team_rgb("black"), Some(0xFF30_3030_u32 as i32));
    // rust: assert_eq!(team_rgb("reset"), None);
}
}
