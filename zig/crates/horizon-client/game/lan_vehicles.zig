//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lan_vehicles
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Boats and minecarts for a server's players: LAN guests, players on a
//! dedicated server, and single player's window on its server thread.
//!
//! A player aims at a vehicle, item frame, armor stand or painting as at a
//! mob (`ServerGamePacketListenerImpl.handleInteract`), and the game's own
//! code for it runs as that player (`AbstractBoat.interact` seats it,
//! `VehicleEntity.hurtServer` breaks the vehicle). A boat is driven by its
//! rider's client (`handleMoveVehicle`, `handlePaddleBoat`); a minecart moves
//! here with the rider's input (`ServerPlayer.getLastClientMoveIntent`).
//! Sneaking gets out (`Player.rideTick`: `wantsToStopRiding`), and the client
//! is teleported where the player lands (`ServerPlayer.dismountTo`).
// use super::{Dim, Game, Keys, lan::LanHost, minecarts::SEAT};
// use horizon_client::collisions::SceneCollisions;
// use horizon_client::lan::hub::no_blocks_in;
// use horizon_client::mobs::equine;
// use horizon_core::geometry::{Aabb, Axis, Vec3};
// use horizon_protocol::{
    // rust: packets::play::{self, Clientbound as C},
    // rust: text::translatable,
}

/// `PlayerInput` flags, as the server player's client last sent them.
    // rust: pub(super) fn input_keys(flags: u8) -> Keys {
    // rust: Keys {
    // rust: forward: flags & 1 != 0,
    // rust: backward: flags & 2 != 0,
    // rust: left: flags & 4 != 0,
    // rust: right: flags & 8 != 0,
    // rust: jump: flags & 16 != 0,
    // rust: shift: flags & 32 != 0,
    // rust: sprint: flags & 64 != 0,
    // rust: ..Keys::default()
}
}

pub fn corners(b: Aabb) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: ([lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z])
}

/// A boat or minecart a server player rode, followed for
/// `native_vehicle_moved`.
    // rust: pub(super) struct WatchedVehicle {
    // rust: id: u32,
    // rust: dim: Dim,
    /// The server player it carries now.
    // rust: rider: Option<u128>,
    /// Where the hook last heard of it.
    // rust: at: [f64; 3],
    /// Ticks it has stood still.
    // rust: still: u32,
}

    // rust: impl Game<'_> {
    /// Where the boat or minecart `id` of this level is.
pub fn watched_vehicle_position(self: *Self, id: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let at = |v: Vec3| [v.x, v.y, v.z];
    // rust: self.boats
    // rust: .iter()
    // rust: .find(|b| b.id == id)
    // rust: .map(|b| at(b.position))
    // rust: .or_else(|| {
    // rust: self.carts
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| at(c.position))
    // rust: })
}

    /// `VehicleMoveEvent` for the boats and minecarts server players ride
    /// (and left less than ten seconds ago): once a tick, after they moved.
    // rust: pub(super) fn tick_vehicle_watch(&mut self) {
    // rust: let riders: Vec<(u32, u32, u128)> = self.lan.as_ref().map_or_else(Vec::new, |h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter_map(|g| Some((g.vehicle?, g.conn, g.uuid)))
    // rust: .collect()
    // rust: });
    // rust: if riders.is_empty() && self.watched_vehicles.is_empty() {
    // rust: return;
}
    // rust: let dim = self.dim;
    // rust: for &(id, _, uuid) in &riders {
    // rust: let Some(at) = self.watched_vehicle_position(id) else {
    // rust: continue;
}
    // rust: match self.watched_vehicles.iter_mut().find(|w| w.id == id) {
    // rust: Some(w) => (w.dim, w.rider) = (dim, Some(uuid)),
    // rust: None => self.watched_vehicles.push(WatchedVehicle {
    // rust: id,
    // rust: dim,
    // rust: rider: Some(uuid),
    // rust: at,
    // rust: still: 0,
    // rust: }),
}
}
    // rust: let mut kept = Vec::new();
        // (rider's connection and UUID, vehicle type, from, to)
    // rust: let mut moved = Vec::new();
    // rust: for mut w in std::mem::take(&mut self.watched_vehicles) {
            // Another level's vehicle is told of on that level's tick.
    // rust: if w.dim != dim {
    // rust: kept.push(w);
    // rust: continue;
}
            // Broken, or gone from this level.
    // rust: let Some(now) = self.watched_vehicle_position(w.id) else {
    // rust: continue;
}
    // rust: let rider = riders.iter().find(|r| r.0 == w.id);
    // rust: w.rider = rider.map(|r| r.2);
    // rust: if now != w.at {
    // rust: let from = std::mem::replace(&mut w.at, now);
    // rust: w.still = 0;
    // rust: let kind = self.target_type(
    // rust: self.level_entity(w.id as i32)
    // rust: .unwrap_or(super::commands::Target::Boat(w.id)),
    // rust: );
    // rust: moved.push((rider.map(|r| (r.1, r.2)), kind, from, now));
    // rust: } else {
    // rust: w.still += 1;
    // rust: if w.rider.is_none() && w.still > 200 {
    // rust: continue;
}
}
    // rust: kept.push(w);
}
    // rust: self.watched_vehicles = kept;
        // The rider's state is swapped in for the call, so the helpers reach
        // them; a vehicle nobody rides is told of with nobody swapped in.
    // rust: for (rider, kind, from, to) in moved {
    // rust: let Some((conn, uuid)) = rider else {
    // rust: self.native_vehicle_moved(None, &kind, from, to);
    // rust: continue;
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: continue;
}
    // rust: let hook = |game: &mut Self| game.native_vehicle_moved(Some(uuid), &kind, from, to);
    // rust: if self.lan_acting == Some(conn) {
    // rust: hook(self);
    // rust: } else {
    // rust: self.as_guest(&mut host, conn, hook);
}
    // rust: self.lan = Some(host);
}
}

    /// The box of a boat, minecart, armor stand, item frame or painting, and
    /// the point an interact packet's location is measured from (the
    /// client's `remote_object_hit` uses the same points).
    // rust: pub(super) fn object_target(&self, id: i32) -> Option<([f64; 3], [f64; 3], [f64; 3])> {
    // rust: let at = |v: Vec3| [v.x, v.y, v.z];
    // rust: let centre = |p: [i32; 3]| p.map(|v| f64::from(v) + 0.5);
    // rust: if let Some(i) = self.interactions.get(&id) {
    // rust: let (lo, hi) = corners(i.bounds());
    // rust: return Some((lo, hi, at(i.position)));
}
    // rust: let id = u32::try_from(id).ok()?;
    // rust: if let Some(b) = self.boats.iter().find(|b| b.id == id) {
    // rust: let (lo, hi) = corners(b.bounds());
    // rust: return Some((lo, hi, at(b.position)));
}
    // rust: if let Some(c) = self.carts.iter().find(|c| c.id == id) {
    // rust: let (lo, hi) = corners(c.bounds());
    // rust: return Some((lo, hi, at(c.position)));
}
    // rust: if let Some(a) = self.armor_stands.iter().find(|a| a.id == id) {
    // rust: let (lo, hi) = corners(a.bounds());
    // rust: return Some((lo, hi, at(a.position)));
}
    // rust: if let Some(c) = self.cushions.iter().find(|c| c.id == id) {
    // rust: let (lo, hi) = corners(Aabb::new(
    // rust: Vec3::new(c.position.x - 0.5, c.position.y, c.position.z - 0.5),
    // rust: Vec3::new(c.position.x + 0.5, c.position.y + 0.25, c.position.z + 0.5),
    // rust: ));
    // rust: return Some((lo, hi, at(c.position)));
}
    // rust: if let Some(f) = self.item_frames.iter().find(|f| f.id == id) {
    // rust: let (lo, hi) = f.bounds();
    // rust: return Some((lo, hi, centre(f.pos)));
}
    // rust: let p = self.paintings.iter().find(|p| p.id == id)?;
    // rust: let (lo, hi) = p.bounds();
    // rust: Some((lo, hi, centre(p.pos)))
}

    /// The vehicles the server's players ride: they move with their riders,
    /// not in `tick_boats` and `tick_carts`.
    // rust: pub(super) fn guest_vehicles(&self) -> Vec<u32> {
    // rust: self.lan.as_ref().map_or_else(Vec::new, |h| {
    // rust: h.hub.guests.iter().filter_map(|g| g.vehicle).collect()
    // rust: })
}

    /// Whether a server player other than the one acting rides `vehicle`
    /// (`Entity.canAddPassenger`: a boat or minecart seats one player here).
    // rust: pub(super) fn ridden_by_guest(&self, vehicle: u32) -> bool {
    // rust: self.lan.as_ref().is_some_and(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .any(|g| Some(g.conn) != self.lan_acting && g.vehicle == Some(vehicle))
    // rust: })
}
    /// Whether a server player rides `vehicle` (`Entity.isPassenger`: a
    /// passenger does not use a portal on its own, the vehicle carries it
    /// across, `Entity.teleportCrossDimension`).
    // rust: pub(super) fn guest_rides(&self, vehicle: u32) -> bool {
    // rust: self.lan
    // rust: .as_ref()
    // rust: .is_some_and(|h| h.hub.guests.iter().any(|g| g.vehicle == Some(vehicle)))
}

    /// `Player.rideTick` for a server player, before its moves this tick:
    /// it stays in its seat, steers its minecart, or gets out.
    // rust: pub(super) fn guest_vehicle_tick(&mut self, host: &mut LanHost, conn: u32) {
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let g = &host.hub.guests[gi];
    // rust: let Some(vehicle) = g.vehicle else {
    // rust: return;
}
    // rust: let (keys, dead) = (input_keys(g.input), g.dead || g.health <= 0.0);
    // rust: let boat = self.boats.iter().position(|b| b.id == vehicle);
    // rust: let cart = self.carts.iter().any(|c| c.id == vehicle);
    // rust: let mount = self.mobs.iter().any(|m| m.id == vehicle);
    // rust: let cushion = self.cushions.iter().any(|c| c.id == vehicle);
        // The vehicle is gone (broken, in another level) or the rider died:
        // its client drops it with the entity or the death screen.
    // rust: if dead || (boat.is_none() && !cart && !mount && !cushion) {
    // rust: let g = &mut host.hub.guests[gi];
    // rust: (g.vehicle, g.vehicle_good) = (None, None);
            // Entity.removePassenger: the rider waits 60 ticks to board again.
    // rust: g.boarding_cooldown = super::boat_passengers::BOARDING_COOLDOWN;
    // rust: return;
}
    // rust: let mut ejected = false;
    // rust: if let Some(i) = boat {
            // AbstractBoat.tick on the server for a boat its rider drives:
            // only the hurt animation and the damage wear off here.
    // rust: let b = &mut self.boats[i];
    // rust: b.hurt_time = (b.hurt_time - 1).max(0);
    // rust: b.damage = (b.damage - 1.0).max(0.0);
            // `Entity.ejectPassengers`: every player in the boat must see
            // the request; the common boat tick clears it once nobody rides.
    // rust: ejected = b.eject_riders;
}
        // ServerGamePacketListenerImpl.tick: the vehicle's last good position
        // is where it is now, so a move the server made (a piston, a push)
        // is not held against the rider's next move, which would fail, be
        // sent back, and fail again on every answer.
    // rust: let at = boat.map(|i| self.boats[i].position).or_else(|| {
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == vehicle && equine::moved_by_client(m))
    // rust: .map(|m| m.position)
    // rust: });
    // rust: if let Some(p) = at {
    // rust: host.hub.guests[gi].vehicle_good = Some([p.x, p.y, p.z]);
}
        // Getting out goes through leave_guest, which tells the client and
        // teleports it (ServerPlayer.dismountTo).
    // rust: let seat = self.as_guest(host, conn, |game| {
            // A cushion does not move: the rider sits on it until it sneaks
            // (`Cushion.removePassenger` plays the get-up sound).
    // rust: if game.cushions.iter().any(|c| Some(c.id) == game.riding) {
    // rust: if keys.shift {
    // rust: game.tick_cushion_riding(keys);
    // rust: return None;
}
    // rust: let c = game.cushions.iter().find(|c| Some(c.id) == game.riding)?;
    // rust: let p = c.seat();
    // rust: return Some([p.x, p.y, p.z]);
}
    // rust: if let Some(i) = game.boats.iter().position(|b| Some(b.id) == game.riding) {
    // rust: if keys.shift || ejected {
    // rust: game.dismount(i);
    // rust: return None;
}
    // rust: let p = game.player_boat_seat(i);
    // rust: return Some([p.x, p.y, p.z]);
}
            // The minecart moves with the rider's input, and lets it out when
            // it sneaks or the cart breaks. An animal takes the rider's input
            // for its own tick (`travelRidden`), or lets it off.
    // rust: if !game.tick_cart_riding(keys) && game.tick_mount_riding(keys) {
    // rust: game.riding?;
    // rust: game.position_rider();
}
    // rust: game.riding?;
    // rust: let p = game.player.as_ref()?.position;
    // rust: Some([p.x, p.y, p.z])
    // rust: });
    // rust: if let Some(Some(at)) = seat {
    // rust: let g = &mut host.hub.guests[gi];
    // rust: g.previous_position = g.position;
    // rust: g.position = at;
}
}

    /// After an interaction: a player that got into a vehicle sits in it,
    /// and its last good vehicle position is where the vehicle is.
    // rust: pub(super) fn guest_boarded(&mut self, host: &mut LanHost, conn: u32, before: Option<u32>) {
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let Some(vehicle) = host.hub.guests[gi].vehicle else {
    // rust: return;
}
    // rust: if before == Some(vehicle) {
    // rust: return;
}
        // The host in the window rides it already.
    // rust: if self.riding == Some(vehicle) {
    // rust: host.hub.guests[gi].vehicle = before;
    // rust: return;
}
    // rust: let at = self
    // rust: .boats
    // rust: .iter()
    // rust: .position(|b| b.id == vehicle)
    // rust: .map(|i| (self.boats[i].position, self.player_boat_seat(i)))
    // rust: .or_else(|| {
    // rust: self.carts
    // rust: .iter()
    // rust: .find(|c| c.id == vehicle)
    // rust: .map(|c| (c.position, c.position.add_vector(Vec3::new(0.0, SEAT, 0.0))))
    // rust: })
    // rust: .or_else(|| {
    // rust: self.cushions
    // rust: .iter()
    // rust: .find(|c| c.id == vehicle)
    // rust: .map(|c| (c.position, c.seat()))
    // rust: });
    // rust: if let Some((p, seat)) = at {
    // rust: let g = &mut host.hub.guests[gi];
    // rust: g.vehicle_good = Some([p.x, p.y, p.z]);
    // rust: g.previous_position = g.position;
    // rust: g.position = [seat.x, seat.y, seat.z];
    // rust: g.on_ground = false;
    // rust: return;
}
        // An animal: the rider sits where `positionRider` puts it.
    // rust: let seat = self.as_guest(host, conn, |game| {
    // rust: game.position_rider();
    // rust: game.player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z])
    // rust: });
    // rust: if let Some(Some(at)) = seat {
    // rust: let g = &mut host.hub.guests[gi];
    // rust: g.previous_position = g.position;
    // rust: g.position = at;
    // rust: g.on_ground = false;
}
}

    /// `ServerGamePacketListenerImpl.handleMoveVehicle`: the boat or the
    /// saddled horse its rider drives goes where the client says, unless it
    /// moved too quickly or wrongly; then it stays, and the client is told
    /// where it is.
    // rust: pub(super) fn guest_move_vehicle(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &play::MoveVehicleRequest,
    // rust: ) {
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let [x, y, z] = p.position;
    // rust: if !x.is_finite()
    // rust: || !y.is_finite()
    // rust: || !z.is_finite()
    // rust: || !p.yaw.is_finite()
    // rust: || !p.pitch.is_finite()
    // rust: {
    // rust: host.hub.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.invalid_vehicle_movement", &[]),
    // rust: );
    // rust: return;
}
    // rust: let g = &host.hub.guests[gi];
    // rust: if g.awaiting_teleport.is_some() || !g.client_loaded() {
    // rust: return;
}
    // rust: let owner = host.hub.singleplayer_owner == Some(g.uuid);
    // rust: let (vehicle, good) = (g.vehicle, g.vehicle_good);
    // rust: let back = |host: &mut LanHost, position: Vec3, yaw: f32| {
    // rust: let packet = play::MoveVehicle {
    // rust: position: [position.x, position.y, position.z],
    // rust: yaw,
    // rust: pitch: 0.0,
}
    // rust: host.hub.send_to(conn, &C::MoveVehicle(packet));
}
        // Only a boat, and a horse its rider's client moves, are driven by
        // their rider (getControllingPassenger); a minecart that is elsewhere
        // on the client is put back.
    // rust: let boat = vehicle.and_then(|v| self.boats.iter().position(|b| b.id == v));
    // rust: let mount = vehicle.and_then(|v| {
    // rust: self.mobs
    // rust: .iter()
    // rust: .position(|m| m.id == v && equine::moved_by_client(m))
    // rust: });
        // The vehicle's id, position, rotation, motion, box, step height
        // and ground.
    // rust: let (id, old, yaw, velocity, bounds, step, on_ground) = if let Some(i) = boat {
    // rust: let b = &self.boats[i];
    // rust: (
    // rust: b.id,
    // rust: b.position,
    // rust: b.yaw,
    // rust: b.velocity,
    // rust: b.bounds(),
    // rust: 0.0,
    // rust: b.on_ground,
    // rust: )
    // rust: } else if let Some(i) = mount {
    // rust: let m = &self.mobs[i];
    // rust: let step = m.kind.step_height as f32;
    // rust: (
    // rust: m.id,
    // rust: m.position,
    // rust: m.yaw,
    // rust: m.velocity,
    // rust: m.bounds(),
    // rust: step,
    // rust: m.on_ground,
    // rust: )
    // rust: } else {
    // rust: if let Some(c) = vehicle.and_then(|v| self.carts.iter().find(|c| c.id == v))
    // rust: && c.position.distance_squared(Vec3::new(x, y, z)) > 1.0
    // rust: {
    // rust: back(host, c.position, c.yaw);
}
    // rust: return;
}
    // rust: let good = good.map_or(old, |g| Vec3::new(g[0], g[1], g[2]));
    // rust: let target = Vec3::new(
    // rust: x.clamp(-3.0E7, 3.0E7),
    // rust: y.clamp(-2.0E7, 2.0E7),
    // rust: z.clamp(-3.0E7, 3.0E7),
    // rust: );
        // Moved too quickly: more than 10 blocks past its own motion.
    // rust: let moved = target.distance_squared(old) - velocity.length_squared();
    // rust: if moved > 100.0 && !owner {
    // rust: log::warn!("vehicle {id} moved too quickly! {moved}");
    // rust: back(host, old, yaw);
    // rust: return;
}
        // vehicle.move(PLAYER, target - lastGood) with the vehicle's
        // collisions: where it can't follow the client (a quarter block off,
        // the height aside), it moved wrongly.
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: let wanted = target.subtract(good);
    // rust: let resolved = scene
    // rust: .resolve(bounds, wanted, step, on_ground)
    // rust: .unwrap_or(wanted);
    // rust: let reached = old.add_vector(resolved);
    // rust: let wrongly = (target.x - reached.x).powi(2) + (target.z - reached.z).powi(2) > 0.0625;
    // rust: let free_before = scene.unobstructed(bounds).unwrap_or(true);
        // isEntityCollidingWithAnythingNew: a box that was free is not there.
    // rust: let moved_box = bounds.move_by(target.subtract(old));
    // rust: let free_after = scene
    // rust: .unobstructed(moved_box.deflate(Vec3::new(1.0E-5, 1.0E-5, 1.0E-5)))
    // rust: .unwrap_or(true);
    // rust: if free_before && (wrongly || !free_after) {
    // rust: log::warn!("vehicle {id} moved wrongly");
    // rust: back(host, old, yaw);
    // rust: return;
}
        // clientVehicleIsFloating: the move didn't go down a step, the vehicle hadn't come down onto
        // something on its last move (`verticalCollisionBelow` before this one), and nothing but air is
        // around its box grown by 0.0625 and stretched 0.55 down (water holds a boat up). A flying or
        // no-gravity mount, and a server that allows flight, never float.
    // rust: let (gravity, no_gravity) = match mount {
    // rust: Some(i) => (0.08, self.mobs[i].no_gravity),
    // rust: None => (0.04, false),
}
    // rust: let around = moved_box
    // rust: .inflate(Vec3::new(0.0625, 0.0625, 0.0625))
    // rust: .expand_towards(Vec3::new(0.0, -0.55, 0.0));
    // rust: let corner = |max: bool| {
    // rust: [Axis::X, Axis::Y, Axis::Z].map(|a| if max { around.max(a) } else { around.min(a) })
}
    // rust: let no_blocks = no_blocks_in(&self.world, corner(false), corner(true));
    // rust: let allow_flight = host.hub.config.allow_flight;
    // rust: let g = &mut host.hub.guests[gi];
    // rust: g.vehicle_good = Some([target.x, target.y, target.z]);
    // rust: let rested = std::mem::replace(
    // rust: &mut g.vehicle_rests,
    // rust: wanted.y < 0.0 && resolved.y != wanted.y,
    // rust: );
    // rust: g.vehicle_floating =
    // rust: wanted.y >= -0.03125 && !rested && !allow_flight && !no_gravity && no_blocks;
    // rust: g.vehicle_gravity = gravity;
    // rust: if let Some(i) = mount {
            // absSnapTo: where and how its rider's client turned it; the
            // rider sits on it from its own ride tick.
    // rust: let m = &mut self.mobs[i];
    // rust: m.position = target;
    // rust: m.yaw = p.yaw;
    // rust: m.head_pitch = p.pitch;
    // rust: m.on_ground = p.on_ground;
    // rust: return;
}
    // rust: let Some(i) = boat else {
    // rust: return;
}
    // rust: let b = &mut self.boats[i];
    // rust: b.previous = old;
    // rust: b.velocity = target.subtract(old);
    // rust: b.position = target;
    // rust: b.previous_yaw = b.yaw;
    // rust: b.yaw = p.yaw;
    // rust: b.on_ground = p.on_ground;
    // rust: let seat = self.player_boat_seat(i);
    // rust: let g = &mut host.hub.guests[gi];
    // rust: g.previous_position = g.position;
    // rust: g.position = [seat.x, seat.y, seat.z];
}

    /// `Entity.getControllingPassenger` of a vehicle a server player rides: a
    /// boat has two seats, and only its first player passenger drives it. The
    /// window player sits first when it rides; of the server's players it is
    /// the one that got in first.
    // rust: pub(super) fn guest_controls_vehicle(&self, host: &LanHost, conn: u32, vehicle: u32) -> bool {
    // rust: if self.riding == Some(vehicle) {
    // rust: return false;
}
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.vehicle == Some(vehicle))
    // rust: .min_by_key(|g| g.vehicle_order)
    // rust: .is_some_and(|g| g.conn == conn)
}

    /// `handlePaddleBoat`: the paddles of the boat the player controls
    /// (`player.getControlledVehicle()`); a passenger in the second seat moves
    /// no paddle.
    // rust: pub(super) fn guest_paddle_boat(&mut self, host: &LanHost, conn: u32, paddles: [bool; 2]) {
    // rust: let vehicle = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == conn)
    // rust: .and_then(|g| g.vehicle);
    // rust: let Some(vehicle) = vehicle.filter(|&v| self.guest_controls_vehicle(host, conn, v)) else {
    // rust: return;
}
    // rust: if let Some(b) = self.boats.iter_mut().find(|b| b.id == vehicle) {
    // rust: b.paddling = paddles;
    // rust: b.paddle_controller = true;
}
}
}
