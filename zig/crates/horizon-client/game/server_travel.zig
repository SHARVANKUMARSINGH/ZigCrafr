//! Transpiled from Horizon Rust crate
//! Module: horizon-client_server_travel
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A server's players between dimensions.
//!
//! A server holds a level per dimension (game/levels.rs). A player who steps
//! into a Nether or End portal moves to the destination's level, which opens
//! if nobody was there: the portal plans and arrival search pick the exit,
//! and the player hears it as `ServerPlayer.teleport` into
//! another level: a Respawn packet keeping all data, then a teleport to the
//! exit once the destination has loaded around them.

// use super::end::GatewayJob;
// use super::nether_portal::{PLAYER_DELAY, Plan};
// use super::respawn_anchor::RespawnConfig;
// use super::{Dim, Game, Mob, boats, lan::LanHost, minecarts};
// use horizon_client::{lan::hub::TickCtx, world_spawn::PlayerSpawnFinder};
// use horizon_core::{geometry::Vec3, position::BlockPos};
// use horizon_protocol::packets::play::{self, Clientbound as C};

/// A trip under way: the player is in the destination's level, whose
/// chunks are loading around `target`.
    // rust: pub(super) struct Trip {
    // rust: conn: u32,
    // rust: dim: Dim,
    /// The level the player came from: the vehicle it rides waits there
    /// until the exit is found.
    // rust: source: Dim,
    // rust: target: Vec3,
    /// Through an End portal.
    // rust: end: bool,
    /// The Nether portal plan, whose exit is found or built on arrival.
    // rust: plan: Option<Plan>,
    /// The vehicle the player rides, which travels with it
    /// (`Entity.teleportCrossDimension` carries the passengers).
    // rust: vehicle: Option<u32>,
    /// Through an End gateway, within the level: its exit, found or built
    /// on arrival.
    // rust: gateway: Option<GatewayJob>,
    /// A respawn at this point outside the Overworld, resolved through its
    /// block on arrival.
    // rust: respawn: Option<RespawnConfig>,
    /// A respawn at the world spawn, moved onto a free column within the
    /// respawn radius once the chunks around it have loaded.
    // rust: world_spawn: bool,
    /// The search for that column while a candidate's chunk loads.
    // rust: finder: Option<PlayerSpawnFinder>,
    /// Sent by a command: the player is already where it goes.
    // rust: placed: bool,
    /// The level the player left for another one: the mods are told they
    /// changed dimension when the trip ends (`tell_mods_changed_dimension`).
    // rust: pub(super) left: Option<Dim>,
}

/// A vehicle a player rides: an animal, a boat or a minecart. It travels
/// with the player through a portal (`Entity.teleportCrossDimension` carries
/// the passengers, and they ride the vehicle that is recreated in the other
/// dimension).
    // rust: trait Rideable {
pub fn id(self: *Self) u;
    /// The vehicle stands where its rider arrives, with the motion it crossed
    /// with (none for the kinds that keep none).
pub fn arrive(self: *Self, at: Vec3, yaw: f32, motion: Vec3) void;
}

    // rust: impl Rideable for Mob {
pub fn id(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.id
}
pub fn arrive(self: *Self, at: Vec3, yaw: f32, _motion: Vec3) void {
}
    // rust: self.position = at;
    // rust: self.previous = at;
    // rust: self.velocity = Vec3::ZERO;
    // rust: self.yaw = yaw;
    // rust: self.previous_yaw = yaw;
    // rust: self.fall_distance = 0.0;
}
}

    // rust: impl Rideable for boats::Boat {
pub fn id(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.id
}
pub fn arrive(self: *Self, at: Vec3, yaw: f32, _motion: Vec3) void {
}
    // rust: self.position = at;
    // rust: self.previous = at;
    // rust: self.velocity = Vec3::ZERO;
    // rust: self.yaw = yaw;
    // rust: self.previous_yaw = yaw;
    // rust: self.delta_rotation = 0.0;
}
}

    // rust: impl Rideable for minecarts::Minecart {
pub fn id(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.id
}
pub fn arrive(self: *Self, at: Vec3, yaw: f32, motion: Vec3) void {
}
    // rust: self.position = at;
    // rust: self.previous = at;
        // `PositionMoveRotation.of(this)` takes the cart's `getKnownMovement`
        // (`OldMinecartBehavior` clamps it to 0.4 either way along x and z):
        // it rolls on at that speed instead of arriving at rest.
    // rust: self.velocity = Vec3::new(
    // rust: motion.x.clamp(-0.4, 0.4),
    // rust: motion.y,
    // rust: motion.z.clamp(-0.4, 0.4),
    // rust: );
    // rust: self.yaw = yaw;
    // rust: self.previous_yaw = yaw;
}
}

/// The vehicle `id` leaves the level it is in, at the point its rider
/// arrives. It keeps its entity id, so the ride is never broken.
/// A guest leaving for another level leaves its fishing hook behind in the
/// old one, where vanilla's hook stays until its distance check ends it. A
/// guest's hook lives on the guest here, so it ends now: it must not act on
/// the blocks of the level the guest arrives in.
pub fn drop_hook(host: *mut LanHost, conn: u32) void {
}
    // rust: if let Some(play) = host.play.get_mut(&conn) {
    // rust: play.hook = None;
}
}

    // rust: fn take_vehicle<T: Rideable>(
    // rust: list: &mut Vec<T>,
    // rust: id: u32,
    // rust: at: Vec3,
    // rust: yaw: f32,
    // rust: motion: Vec3,
    // rust: ) -> Option<T> {
    // rust: let i = list.iter().position(|v| v.id() == id)?;
    // rust: let mut v = list.remove(i);
    // rust: v.arrive(at, yaw, motion);
    // rust: Some(v)
}

/// `TeleportCommand` into another level for a server's player: where, and
/// the rotation it sets (none keeps the player's).
    // rust: pub(super) struct LevelTeleport {
    // rust: pub conn: u32,
    // rust: pub dim: Dim,
    // rust: pub at: [f64; 3],
    // rust: pub rotation: Option<[f32; 2]>,
    /// `TeleportTransition.asPassenger`: the vehicle already moved with its tree.
    // rust: pub vehicle: Option<u32>,
}

/// A teleport a command made inside a level: told to the mods once it has
/// reached the hub (`native_player_teleported`).
    // rust: pub(super) struct TeleportNote {
    // rust: pub conn: u32,
    // rust: pub uuid: u128,
    // rust: pub name: String,
    // rust: pub from: [f64; 3],
    // rust: pub to: [f64; 3],
    // rust: pub dimension: String,
}

/// A player's box: Player's standing dimensions.
pub const WIDTH: f64 = 0.6;
pub const HEIGHT: f64 = 1.8;

    // rust: impl Trip {
    // rust: pub(super) fn is(&self, conn: u32) -> bool {
    // rust: self.conn == conn
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn gateway_source_chunks(&self) -> Vec<(i32, i32)> {
    // rust: self.server_trips
    // rust: .iter()
    // rust: .filter(|t| t.dim == self.dim)
    // rust: .filter_map(|t| t.gateway.and_then(GatewayJob::source_chunk))
    // rust: .collect()
}
    /// Whether `conn` is between two levels: the server leaves its body
    /// alone until it arrives.
    // rust: pub(super) fn on_server_trip(&self, conn: u32) -> bool {
    // rust: self.server_trips.iter().any(|t| t.conn == conn)
}

    /// Whether a vehicle waits in `dim` for its rider to arrive elsewhere:
    /// that level stays open until it has moved.
    // rust: pub(super) fn vehicle_waits_in(&self, dim: Dim) -> bool {
    // rust: self.server_trips
    // rust: .iter()
    // rust: .any(|t| t.vehicle.is_some() && t.source == dim)
}

    /// Per server tick in each level, after the guests' own: the arrivals of
    /// the trips into this level, then `Entity.handlePortal` for each player
    /// in it (Nether portals count up their transition time, End portals
    /// take them at once).
    // rust: pub(super) fn tick_server_travel(&mut self, host: &mut LanHost) {
        // Outside a server only the respawns at the world spawn wait for chunks.
    // rust: self.arrive_server_trips(host);
    // rust: if self.options.dedicated.is_none() {
    // rust: return;
}
    // rust: self.carry_riders_through_portals(host);
    // rust: let conns: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead && !g.spectator())
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in conns {
    // rust: if self.on_server_trip(conn) {
    // rust: continue;
}
            // `Entity.portalProcess` and `portalCooldown` are the player's own.
    // rust: let mut portal = host.play.entry(conn).or_default().portal;
    // rust: std::mem::swap(&mut self.portals.player, &mut portal);
    // rust: self.handle_server_portal(host, conn);
    // rust: std::mem::swap(&mut self.portals.player, &mut portal);
    // rust: host.play.entry(conn).or_default().portal = portal;
}
}

    /// Whether this guest's dimension change may start (`native_player_portal`).
    // rust: fn server_player_portal_allowed(
    // rust: &mut self,
    // rust: host: &LanHost,
    // rust: conn: u32,
    // rust: target: Dim,
    // rust: cause: &str,
    // rust: ) -> bool {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return false;
}
    // rust: let (player, name) = (g.uuid, g.name.clone());
    // rust: let (from, to) = (self.dim.id(), target.id());
    // rust: let mut cancel = false;
    // rust: self.native_player_portal(player, &name, from, to, cause, &mut cancel);
    // rust: !cancel
}

    /// `Entity.handlePortal` for one player, whose portal state is in place.
pub fn handle_server_portal(self: *Self, host: *mut LanHost, conn: u32) void {
}
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let (at, invulnerable, sleeping, riding) = (
    // rust: Vec3::new(g.position[0], g.position[1], g.position[2]),
    // rust: g.creative(),
    // rust: g.sleeping,
    // rust: g.vehicle.is_some(),
    // rust: );
        // Entity.checkInsideBlocks: the Nether portal blocks the box is in.
        // `canUsePortal(false)` is false for a passenger: its vehicle goes
        // through and carries it (`carry_riders_through_portals`).
    // rust: if !riding && let Some(pos) = self.nether_portal_inside(at) {
    // rust: self.portals.player.set_inside(pos, PLAYER_DELAY);
}
        // `ServerPlayer.showEndCredits`: the player stays out of the world while the
        // poem rolls, then PERFORM_RESPAWN takes it to its respawn point.
    // rust: if host.play.get(&conn).is_some_and(|play| play.won_game) {
    // rust: if host
    // rust: .play
    // rust: .get(&conn)
    // rust: .is_some_and(|play| play.respawn_requested)
    // rust: {
    // rust: if !self.server_player_portal_allowed(host, conn, Dim::Overworld, "end_portal") {
    // rust: return;
}
    // rust: if let Some(play) = host.play.get_mut(&conn) {
    // rust: play.respawn_requested = false;
    // rust: play.won_game = false;
}
                // PlayerList.respawn(keepAllPlayerData = true), CHANGED_DIMENSION:
                // PlayerEvent.Clone with `wasDeath` false.
    // rust: if let Some(g) = host.hub.guest(conn) {
    // rust: let (uuid, name) = (g.uuid, g.name.clone());
    // rust: self.native_player_clone(uuid, &name, false);
}
    // rust: self.start_server_trip(host, conn, Dim::Overworld, None);
    // rust: self.portals.player.cooldown = 10;
}
    // rust: return;
}
    // rust: let (end_portal, gateway) = self.inside_end_portals(at, WIDTH, HEIGHT);
    // rust: if end_portal && !riding {
            // EndPortalBlock.entityInside: the first exit from the End shows the credits.
    // rust: if self.dim == Dim::End && !host.hub.guest(conn).is_some_and(|g| g.seen_credits) {
    // rust: if let Some(g) = host.hub.guests.iter_mut().find(|g| g.conn == conn) {
    // rust: g.seen_credits = true;
}
    // rust: host.play.entry(conn).or_default().won_game = true;
                // ClientboundGameEventPacket.WIN_GAME.
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::GameEvent(play::GameEvent {
    // rust: event: 4,
    // rust: param: 0.0,
    // rust: }),
    // rust: );
    // rust: return;
}
    // rust: if self.portals.player.cooldown == 0 {
    // rust: let target = if self.dim == Dim::End {
    // rust: Dim::Overworld
    // rust: } else {
    // rust: Dim::End
}
    // rust: if !self.server_player_portal_allowed(host, conn, target, "end_portal") {
    // rust: return;
}
    // rust: self.start_server_trip(host, conn, target, None);
}
            // Entity.setAsInsidePortal while cooling down restarts the cooldown.
    // rust: self.portals.player.cooldown = 10;
    // rust: return;
}
        // EndGatewayBlock.entityInside: a gateway that is not cooling down
        // takes the player at once (no transition time) and cools down
        // (triggerCooldown), even for a player still on its own cooldown.
    // rust: if !riding
    // rust: && let Some(g) = gateway
    // rust: && self.gateway_available(g)
    // rust: {
    // rust: if self.portals.player.cooldown == 0 {
    // rust: let Some(player) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let (id, name) = (player.uuid, player.name.clone());
    // rust: let mut cancel = false;
    // rust: self.native_player_teleport_end_gateway(id, &name, g, &mut cancel);
    // rust: if cancel {
    // rust: return;
}
    // rust: if !self.server_player_portal_allowed(host, conn, self.dim, "end_gateway") {
    // rust: return;
}
}
    // rust: if self.gateway_enter(g) {
    // rust: if self.portals.player.cooldown == 0 {
    // rust: self.start_gateway_trip(host, conn, g);
}
                // setPortalCooldown: after the trip, or again while cooling down.
    // rust: self.portals.player.cooldown = 10;
    // rust: return;
}
}
    // rust: let rule = if invulnerable {
    // rust: "players_nether_portal_creative_delay"
    // rust: } else {
    // rust: "players_nether_portal_default_delay"
}
    // rust: let transition = self.ui.rules.int(rule).max(0);
    // rust: let Some(entry) = self
    // rust: .portals
    // rust: .player
    // rust: .handle(!sleeping, transition, PLAYER_DELAY)
    // rust: else {
    // rust: return;
}
    // rust: let plan = self.portal_plan(entry, at, WIDTH as f32, HEIGHT as f32, true);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: if !self.server_player_portal_allowed(host, conn, plan.dim, "nether_portal") {
            // The processor already reached its threshold. Forget this attempt
            // so a canceled trip must complete a fresh portal wait before retrying.
    // rust: self.portals.player.process = None;
    // rust: return;
}
    // rust: self.start_server_trip(host, conn, plan.dim, Some(plan));
}

    /// `Entity.handlePortal` of a vehicle server players ride, once through
    /// a portal (a vehicle's transition time is 0): the riders travel with
    /// it and ride it again on arrival (`Entity.teleportCrossDimension`), so
    /// a rider never waits for its own portal delay.
pub fn carry_riders_through_portals(self: *Self, host: *mut LanHost) void {
}
    // rust: for (vehicle, entry) in self.take_carrying(self.dim) {
    // rust: let Some(plan) = self.vehicle_plan(vehicle, entry) else {
    // rust: continue;
}
    // rust: if !self.may_enter(plan.dim) {
    // rust: continue;
}
    // rust: let riders: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.vehicle == Some(vehicle) && !self.on_server_trip(g.conn))
    // rust: .map(|g| g.conn)
    // rust: .collect();
            // Entity.canTeleport: out of the End, every rider has seen the
            // credits.
    // rust: if plan.end
    // rust: && self.dim == Dim::End
    // rust: && riders
    // rust: .iter()
    // rust: .any(|c| !host.hub.guest(*c).is_some_and(|g| g.seen_credits))
    // rust: {
    // rust: continue;
}
            // An End portal's exit is found as a player's (its own respawn
            // point out of the End).
    // rust: let (target, plan) = (plan.dim, (!plan.end).then_some(plan));
    // rust: for conn in riders {
    // rust: self.start_server_trip(host, conn, target, plan);
}
}
}

    /// A Nether portal block a player's box is in.
pub fn nether_portal_inside(self: *Self, at: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let w = WIDTH / 2.0 - 1.0e-5;
    // rust: let lo = [at.x - w, at.y + 1.0e-5, at.z - w];
    // rust: let hi = [at.x + w, at.y + HEIGHT - 1.0e-5, at.z + w];
    // rust: for x in lo[0].floor() as i32..=hi[0].floor() as i32 {
    // rust: for y in lo[1].floor() as i32..=hi[1].floor() as i32 {
    // rust: for z in lo[2].floor() as i32..=hi[2].floor() as i32 {
    // rust: if &*self.block_name([x, y, z]) == "minecraft:nether_portal" {
    // rust: return Some(BlockPos::new(x, y, z));
}
}
}
}
    // rust: None
}

    /// The player moves to `target`'s level (opened if nobody was there)
    /// and is told it is there, at the approximate exit, while it loads. The
    /// level whose tick is running is put back in place afterwards.
    // rust: pub(super) fn start_server_trip(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: target: Dim,
    // rust: plan: Option<Plan>,
    // rust: ) {
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: if target != self.dim {
    // rust: drop_hook(host, conn);
}
    // rust: let g = &host.hub.guests[i];
    // rust: let from = Vec3::new(g.position[0], g.position[1], g.position[2]);
    // rust: let yaw = g.yaw;
        // The vehicle the player rides travels with it: the player is its
        // passenger, and the vehicle is recreated in the other dimension,
        // where they ride it again (`Entity.teleportCrossDimension`). It
        // keeps its entity id, so the ride is never broken.
    // rust: let vehicle = g.vehicle.filter(|id| {
    // rust: self.mobs.iter().any(|m| m.id == *id)
    // rust: || self.boats.iter().any(|b| b.id == *id)
    // rust: || self.carts.iter().any(|c| c.id == *id)
    // rust: });
    // rust: let source = self.dim;
    // rust: let end = plan.is_none();
        // Coordinates scale by 8 between the Overworld and the Nether; an
        // End portal has fixed destinations.
    // rust: let scale = match (source, target) {
    // rust: (Dim::Overworld, Dim::Nether) | (Dim::End, Dim::Nether) => 1.0 / 8.0,
    // rust: (Dim::Nether, Dim::Overworld) => 8.0,
    // rust: _ => 1.0,
}
    // rust: self.end_portal_travel = end;
        // Leaving the End: the player's own respawn point.
    // rust: let own = if end {
    // rust: self.as_guest(host, conn, |g| g.end_destination(target))
    // rust: .flatten()
    // rust: } else {
    // rust: None
}
    // rust: let scaled = own
    // rust: .or_else(|| self.end_destination(target))
    // rust: .unwrap_or(Vec3::new(from.x * scale, from.y, from.z * scale));
    // rust: self.end_portal_travel = false;
    // rust: if let Err(e) = self.enter_level(Some(host), target) {
    // rust: log::error!("could not open {}: {e}", target.id());
    // rust: return;
}
    // rust: let destination = match plan {
    // rust: Some(plan) => self.arrival_centre(&plan),
    // rust: None => scaled,
}
    // rust: let at = [destination.x, destination.y, destination.z];
    // rust: let ctx = self.server_ctx();
        // Through a portal: the client waits on its loading screen until
        // the exit is found (`arrive_server_trips`). The cooldown is the one
        // Entity.handlePortal set before the teleport.
    // rust: host.hub
    // rust: .change_level(i, at, yaw, None, true, PLAYER_DELAY, &ctx);
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.trigger_dimension(source, target, [from.x, from.y, from.z])
    // rust: });
    // rust: self.server_trips.push(Trip {
    // rust: conn,
    // rust: dim: target,
    // rust: source,
    // rust: target: destination,
    // rust: end,
    // rust: plan,
    // rust: vehicle,
    // rust: gateway: None,
    // rust: respawn: None,
    // rust: world_spawn: false,
    // rust: finder: None,
    // rust: placed: false,
    // rust: left: Some(source),
    // rust: });
    // rust: if let Err(e) = self.enter_level(Some(host), source) {
    // rust: log::error!("could not reopen {}: {e}", source.id());
}
}

    /// A respawned player waits at its point outside the Overworld for the
    /// level to load around it.
    // rust: pub(super) fn respawn_trip(&mut self, conn: u32, config: RespawnConfig) {
    // rust: let [x, y, z] = config.pos;
    // rust: self.server_trips.push(Trip {
    // rust: conn,
    // rust: dim: config.dim,
    // rust: source: self.dim,
    // rust: target: Vec3::new(f64::from(x) + 0.5, f64::from(y), f64::from(z) + 0.5),
    // rust: end: false,
    // rust: plan: None,
    // rust: vehicle: None,
    // rust: gateway: None,
    // rust: respawn: Some(config),
    // rust: world_spawn: false,
    // rust: finder: None,
    // rust: placed: false,
    // rust: left: None,
    // rust: });
}

    /// `findRespawnAndUseSpawnBlock` for the player in place, at its point
    /// in the level in place: where it stands up, facing the anchor (with
    /// the deplete sound) or the bed; else the point is forgotten, and the
    /// caller tells the player (`Hub::missing_respawn_block`).
    // rust: pub(super) fn resolve_server_respawn(&mut self, config: RespawnConfig) -> Option<(Vec3, f32)> {
    // rust: let [x, y, z] = config.pos;
    // rust: let anchor = self.is_anchor(self.world.block(x, y, z));
    // rust: match self.find_respawn_and_use(config, true) {
    // rust: Ok(Some((at, yaw))) => {
    // rust: if !config.forced && anchor {
    // rust: let [x, y, z] = config.pos.map(f64::from);
    // rust: self.audio.play(
    // rust: "minecraft:block.respawn_anchor.deplete",
    // rust: Some([x, y, z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
    // rust: Some((at, yaw))
}
    // rust: Ok(None) | Err(_) => {
    // rust: let mut cancel = false;
    // rust: if let (Some(player), Some(name)) =
    // rust: (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_spawn_point_set(
    // rust: player,
    // rust: &name,
    // rust: config.dim.id(),
    // rust: config.pos,
    // rust: "death_reset",
    // rust: &mut cancel,
    // rust: );
}
    // rust: if cancel {
    // rust: return None;
}
    // rust: self.respawn_config = None;
    // rust: None
}
}
}

    /// TeleportTransition.createDefault and missingRespawnBlock: the player
    /// waits at the world spawn for its chunks, then PlayerSpawnFinder puts
    /// it on a free column within the respawn radius.
    // rust: pub(super) fn world_spawn_trip(&mut self, conn: u32) {
    // rust: let Some([x, y, z]) = self.level.world_spawn else {
    // rust: return;
}
    // rust: self.server_trips.retain(|t| !t.is(conn));
    // rust: self.server_trips.push(Trip {
    // rust: conn,
    // rust: dim: Dim::Overworld,
    // rust: source: self.dim,
    // rust: target: Vec3::new(f64::from(x) + 0.5, f64::from(y), f64::from(z) + 0.5),
    // rust: end: false,
    // rust: plan: None,
    // rust: vehicle: None,
    // rust: gateway: None,
    // rust: respawn: None,
    // rust: world_spawn: true,
    // rust: finder: None,
    // rust: placed: false,
    // rust: left: None,
    // rust: });
}

    /// TeleportTransition.missingRespawnBlock: the world spawn, in the
    /// Overworld.
pub fn respawn_at_world_spawn(self: *Self, host: *mut LanHost, conn: u32) void {
}
    // rust: let at = self.level.world_spawn.map_or(
    // rust: self.spawn.map_or([0.5, 80.0, 0.5], |s| [s.x, s.y, s.z]),
    // rust: |[x, y, z]| [f64::from(x) + 0.5, f64::from(y), f64::from(z) + 0.5],
    // rust: );
    // rust: self.level_teleports.push(LevelTeleport {
    // rust: conn,
    // rust: dim: Dim::Overworld,
    // rust: at,
    // rust: rotation: None,
    // rust: vehicle: None,
    // rust: });
    // rust: self.run_level_teleports(host);
    // rust: self.world_spawn_trip(conn);
}

    /// `TheEndGatewayBlockEntity.getPortalPosition` and the teleport within
    /// the End (keeping the player's motion and look): straight to an exact
    /// exit, else once the destination has loaded around the player, who
    /// waits there (its exit is found among those blocks, or built).
pub fn start_gateway_trip(self: *Self, host: *mut LanHost, conn: u32, gateway: [i32; 3]) void {
}
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let (job, destination) = self.gateway_job(gateway);
    // rust: let at = [destination.x, destination.y, destination.z];
        // Relative.union(DELTA, ROTATION).
    // rust: host.hub.teleport_keeping_motion(i, at);
    // rust: if let GatewayJob::Known { exact: true, .. } = job {
    // rust: return;
}
    // rust: self.server_trips.push(Trip {
    // rust: conn,
    // rust: dim: self.dim,
    // rust: source: self.dim,
    // rust: target: destination,
    // rust: end: false,
    // rust: plan: None,
    // rust: vehicle: None,
    // rust: gateway: Some(job),
    // rust: respawn: None,
    // rust: world_spawn: false,
    // rust: finder: None,
    // rust: placed: false,
    // rust: left: None,
    // rust: });
}

    /// The trips into the level in place whose destination has loaded
    /// around their target: the exit (the Nether portal found or built, the
    /// End platform, the Overworld's spawn column) and the teleport there.
pub fn arrive_server_trips(self: *Self, host: *mut LanHost) void {
}
    // rust: let mut k = 0;
    // rust: while k < self.server_trips.len() {
    // rust: let trip = &self.server_trips[k];
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == trip.conn) else {
                // They left on the way.
    // rust: self.server_trips.remove(k);
    // rust: continue;
}
    // rust: let (cx, cz) = (
    // rust: (trip.target.x.floor() as i32) >> 4,
    // rust: (trip.target.z.floor() as i32) >> 4,
    // rust: );
    // rust: if trip.dim != self.dim
    // rust: || !(-2..=2).all(|dz| (-2..=2).all(|dx| self.streaming.is_lit(cx + dx, cz + dz)))
    // rust: || trip
    // rust: .gateway
    // rust: .and_then(GatewayJob::source_chunk)
    // rust: .is_some_and(|c| !self.world.chunks.contains_key(&c))
    // rust: {
    // rust: k += 1;
    // rust: continue;
}
    // rust: let mut trip = self.server_trips.remove(k);
    // rust: if trip.placed {
    // rust: self.tell_mods_changed_dimension(host, trip.conn, trip.left, trip.dim);
    // rust: continue;
}
            // A portal's trip (`start_server_trip`): its client waits to land.
    // rust: let portal = trip.end || trip.plan.is_some();
    // rust: self.resolve_arrivals();
    // rust: let yaw = host.hub.guests[i].yaw;
    // rust: let (position, yaw) = if let Some(config) = trip.respawn {
    // rust: match self.as_guest(host, trip.conn, |g| g.resolve_server_respawn(config)) {
    // rust: Some(Some(found)) => found,
    // rust: _ => {
    // rust: host.hub.missing_respawn_block(trip.conn);
    // rust: self.respawn_at_world_spawn(host, trip.conn);
                        // The move to the world spawn ends the player's move
                        // from the level they left.
    // rust: if let Some(left) = trip.left
    // rust: && let Some(t) = self.server_trips.iter_mut().find(|t| t.is(trip.conn))
    // rust: {
    // rust: t.left = Some(left);
}
    // rust: continue;
}
}
    // rust: } else if trip.world_spawn {
                // PlayerSpawnFinder.findSpawn around the world spawn.
    // rust: let suggestion =
    // rust: [trip.target.x, trip.target.y, trip.target.z].map(|v| v.floor() as i32);
    // rust: match self.search_spawn(suggestion, &mut trip.finder) {
                    // The respawn already put the player on this column:
                    // vanilla teleports once, so no second move.
    // rust: Ok(at) if host.hub.guests[i].position == [at.x, at.y, at.z] => {
    // rust: self.tell_mods_changed_dimension(host, trip.conn, trip.left, trip.dim);
    // rust: continue;
}
    // rust: Ok(at) => (at, yaw),
    // rust: Err(chunk) => {
    // rust: self.spawn_wait.push(chunk);
    // rust: self.server_trips.insert(k, trip);
    // rust: k += 1;
    // rust: continue;
}
}
    // rust: } else if let Some(job) = trip.gateway {
    // rust: match self.resolve_gateway(job, trip.target) {
    // rust: Ok(at) => (at, yaw),
    // rust: Err(e) => {
    // rust: log::error!("End gateway exit: {e}");
    // rust: (trip.target, yaw)
}
}
    // rust: } else if trip.end {
    // rust: let arrival = match self.as_guest(host, trip.conn, |g| {
    // rust: g.end_arrival(trip.target, &mut trip.finder)
    // rust: }) {
    // rust: Some(arrival) => arrival,
    // rust: None => self.end_arrival(trip.target, &mut trip.finder),
}
    // rust: match arrival {
    // rust: Ok(Some((at, turned))) => {
                        // EndPortalBlock.getPortalDestination: PLACE_PORTAL_TICKET.
    // rust: self.place_portal_ticket(Self::chunk_of(at));
    // rust: (at, turned.unwrap_or(yaw))
}
    // rust: Ok(None) => {
    // rust: self.server_trips.insert(k, trip);
    // rust: k += 1;
    // rust: continue;
}
    // rust: Err(e) => {
    // rust: log::error!("End arrival: {e}");
    // rust: (trip.target, yaw)
}
}
    // rust: } else {
    // rust: let exit = trip
    // rust: .plan
    // rust: .as_ref()
    // rust: .and_then(|plan| self.nether_exit_portal(plan));
    // rust: match (trip.plan, exit) {
    // rust: (Some(plan), Some(exit)) => {
    // rust: let (at, rotation) = self.arrival(&plan, exit);
    // rust: (at, yaw + rotation)
}
    // rust: _ => (trip.target, yaw),
}
}
            // The vehicle the player rode comes with it, and waits for it
            // where it arrives (`Entity.teleportCrossDimension` carries the
            // passengers).
    // rust: if let Some(vehicle) = trip.vehicle {
    // rust: self.arrive_vehicle(trip.source, vehicle, position, yaw);
}
            // Player.getDimensionChangingDelay.
    // rust: host.play.entry(trip.conn).or_default().portal.cooldown = 10;
    // rust: let g = &mut host.hub.guests[i];
    // rust: g.yaw = yaw;
            // A new body at the exit: no fall distance or motion carried over,
            // but the player's attributes (ServerPlayer.teleport keeps the entity).
    // rust: g.new_body(true);
    // rust: let at = [position.x, position.y, position.z];
    // rust: if portal {
    // rust: host.hub.land(i, at);
    // rust: } else {
    // rust: host.hub.teleport(i, Some(at));
}
    // rust: self.tell_mods_changed_dimension(host, trip.conn, trip.left, trip.dim);
}
}

    /// The vehicle the player rode arrives with it, at the point the player
    /// arrives: it keeps its entity id, so the ride is never broken
    /// (`Entity.teleportCrossDimension` recreates the vehicle in the other
    /// dimension, and its passengers ride it again).
pub fn arrive_vehicle(self: *Self, source: Dim, id: u32, at: Vec3, yaw: f32) void {
}
    // rust: let motion = self
    // rust: .portals
    // rust: .carried_motion
    // rust: .remove(&id)
    // rust: .unwrap_or(Vec3::ZERO);
    // rust: let Some(parked) = self.levels.parked_mut(source) else {
    // rust: return;
}
    // rust: if let Some(b) = take_vehicle(&mut parked.boats, id, at, yaw, motion) {
    // rust: self.boats.push(b);
    // rust: } else if let Some(c) = take_vehicle(&mut parked.carts, id, at, yaw, motion) {
    // rust: self.carts.push(c);
    // rust: } else if let Some(m) = take_vehicle(&mut parked.mobs, id, at, yaw, motion) {
    // rust: self.mobs.push(m);
    // rust: } else {
    // rust: return;
}
        // Its memory (its UUID and the compound it was loaded with) moves
        // with it, so it is saved in this level as it was in the other.
    // rust: self.move_entity_memory(source, id);
        // The vehicle that came through a portal does not go back through it
        // for a while (`Entity.setPortalCooldown`).
    // rust: self.set_portal_cooldown(id);
}

    /// Tells the mods of the teleports a command made inside a level, with
    /// each player's state swapped in: where the move has reached the hub.
    // rust: pub(super) fn flush_teleport_notes(&mut self, host: &mut LanHost) {
    // rust: for note in std::mem::take(&mut self.teleport_notes) {
    // rust: let TeleportNote {
    // rust: conn,
    // rust: uuid,
    // rust: name,
    // rust: from,
    // rust: to,
    // rust: dimension,
    // rust: } = note;
            // In place when it is their turn already (as_guest finds them swapped in).
    // rust: if self.lan_acting == Some(conn) {
    // rust: self.native_player_teleported(uuid, &name, from, to, &dimension);
    // rust: } else {
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.native_player_teleported(uuid, &name, from, to, &dimension);
    // rust: });
}
}
}

    /// The players the command just run sends to another level
    /// (`ServerPlayer.teleport` from TeleportCommand): a Respawn packet
    /// keeping all data and the teleport, with no portal sound. The server
    /// leaves the body alone until the level has loaded around it.
    // rust: pub(super) fn run_level_teleports(&mut self, host: &mut LanHost) {
    // rust: for t in std::mem::take(&mut self.level_teleports) {
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == t.conn) else {
    // rust: continue;
}
    // rust: let source = self.dim;
    // rust: if t.dim != source {
    // rust: drop_hook(host, t.conn);
}
    // rust: if let Err(e) = self.enter_level(Some(host), t.dim) {
    // rust: log::error!("could not open {}: {e}", t.dim.id());
    // rust: continue;
}
    // rust: let (uuid, name) = (host.hub.guests[i].uuid, host.hub.guests[i].name.clone());
    // rust: let g = &mut host.hub.guests[i];
    // rust: let [yaw, pitch] = t.rotation.unwrap_or([g.yaw, g.pitch]);
    // rust: let origin = g.position;
            // A new body there: no fall distance or motion carried over, but
            // the player's attributes (ServerPlayer.teleport keeps the entity).
    // rust: let passenger_body = if t.vehicle.is_some() {
    // rust: g.motion.take()
    // rust: } else {
    // rust: g.new_body(true);
    // rust: None
}
    // rust: let cooldown = host.play.get(&t.conn).map_or(0, |p| p.portal.cooldown);
    // rust: let ctx = self.server_ctx();
    // rust: host.hub
    // rust: .change_level(i, t.at, yaw, Some(pitch), false, cooldown, &ctx);
    // rust: let g = &mut host.hub.guests[i];
    // rust: g.vehicle = t.vehicle;
    // rust: if let Some(mut body) = passenger_body {
    // rust: body.position = Vec3::new(t.at[0], t.at[1], t.at[2]);
    // rust: g.motion = Some(body);
}
    // rust: self.as_guest(host, t.conn, |g| {
    // rust: g.trigger_dimension(source, t.dim, origin);
                // The mods hear the teleport into another level, with the
                // player's state swapped in.
    // rust: g.native_player_teleported(uuid, &name, origin, t.at, t.dim.id());
    // rust: });
    // rust: self.server_trips.retain(|trip| !trip.is(t.conn));
    // rust: self.server_trips.push(Trip {
    // rust: conn: t.conn,
    // rust: dim: t.dim,
    // rust: source,
    // rust: target: Vec3::new(t.at[0], t.at[1], t.at[2]),
    // rust: end: false,
    // rust: plan: None,
                // A command teleports the player alone: it is not a
                // passenger any more (`ServerPlayer.teleport`).
    // rust: vehicle: None,
    // rust: gateway: None,
    // rust: respawn: None,
    // rust: world_spawn: false,
    // rust: finder: None,
    // rust: placed: true,
    // rust: left: Some(source),
    // rust: });
    // rust: if let Err(e) = self.enter_level(Some(host), source) {
    // rust: log::error!("could not reopen {}: {e}", source.id());
}
}
}

    /// `native_player_changed_dimension` for a guest who has ended a move
    /// from the level `left` to the one in place, `to`, with their state
    /// swapped in so that the helpers reach them. Nothing is heard when they
    /// did not leave a level, or ended where they started.
    // rust: pub(super) fn tell_mods_changed_dimension(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: left: Option<Dim>,
    // rust: to: Dim,
    // rust: ) {
    // rust: let Some(from) = left.filter(|from| *from != to) else {
    // rust: return;
}
    // rust: let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone())) else {
    // rust: return;
}
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.native_player_changed_dimension(uuid, &name, from.id(), to.id());
    // rust: });
}

    /// The hub's view of the server for packets sent outside its own tick.
    // rust: pub(super) fn server_ctx(&mut self) -> TickCtx<'_> {
    // rust: let spawn = self.spawn.map_or([0.5, 80.0, 0.5], |s| [s.x, s.y, s.z]);
    // rust: let clock_rate = self.network_clock_rate();
    // rust: TickCtx {
    // rust: world: &mut self.world,
    // rust: entities: &[],
    // rust: next_entity: &mut self.next_entity,
    // rust: spawn,
    // rust: difficulty: i32::from(self.ui.difficulty),
    // rust: difficulty_locked: self.level.difficulty_locked,
    // rust: clock_rate,
    // rust: tick_rate: self.clock.rate(),
    // rust: tick_frozen: self.clock.frozen(),
    // rust: tick_steps: self.clock.step_state(),
    // rust: collision: Some(self.collision),
    // rust: border: &self.border,
    // rust: streaming: Some(&self.streaming),
}
}
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::Arc;

    /// A minecart a player rides through a portal rolls on at the motion it
    /// crossed with, clamped to 0.4 along x and z (`PositionMoveRotation.of`
    /// takes `OldMinecartBehavior.getKnownMovement`), not at rest. Vanilla
    /// 26.3 sent the client a cart arriving with motion (0.4, 0, 0).
pub fn a_minecart_a_player_rides_keeps_its_clamped_motion_through_a_portal() void {
}
    // rust: let mut carts = vec![minecarts::Minecart::new(
    // rust: 3,
    // rust: minecarts::CartKind::Rideable,
    // rust: Vec3::new(9.9, 100.0, 4.5),
    // rust: )];
    // rust: let at = Vec3::new(1.5, 100.0, 0.5);
    // rust: let cart = take_vehicle(&mut carts, 3, at, 0.0, Vec3::new(1.6, -0.1, -0.7))
    // rust: .expect("the cart travels");
    // rust: assert_eq!(cart.position, at);
    // rust: assert_eq!(cart.velocity, Vec3::new(0.4, -0.1, -0.4));
}

    /// The vehicle a player rides travels with it through a portal: it
    /// leaves the level the player came from, keeps its entity id (so the
    /// ride is never broken) and stands where its rider arrives
    /// (`Entity.teleportCrossDimension` carries the passengers, and they
    /// ride the vehicle that is recreated in the other dimension).
pub fn the_vehicle_a_player_rides_travels_with_it() void {
}
    // rust: let mut boats = vec![boats::Boat::new(
    // rust: 7,
    // rust: Arc::from("oak"),
    // rust: Vec3::new(0.0, 64.0, 0.0),
    // rust: 0.0,
    // rust: )];
    // rust: let mut carts: Vec<minecarts::Minecart> = Vec::new();
    // rust: let mut mobs: Vec<Mob> = Vec::new();
    // rust: let at = Vec3::new(1.5, 65.0, -2.5);
    // rust: let boat = take_vehicle(&mut boats, 7, at, 90.0, Vec3::ZERO)
    // rust: .expect("the vehicle the player rides travels with it");
    // rust: assert!(
    // rust: boats.is_empty(),
    // rust: "the vehicle left the level the player came from"
    // rust: );
    // rust: assert_eq!(boat.id, 7, "the vehicle keeps its entity id");
    // rust: assert_eq!(boat.position, at, "it stands where its rider arrives");
    // rust: assert_eq!(boat.yaw, 90.0, "it looks where its rider looks");
    // rust: assert_eq!(boat.velocity, Vec3::ZERO, "it comes with no motion");
        // A vehicle that is not in the level does not travel.
    // rust: assert!(take_vehicle(&mut carts, 9, at, 0.0, Vec3::ZERO).is_none());
    // rust: assert!(carts.is_empty());
    // rust: assert!(take_vehicle(&mut mobs, 9, at, 0.0, Vec3::ZERO).is_none());
    // rust: assert!(mobs.is_empty());
}
}
