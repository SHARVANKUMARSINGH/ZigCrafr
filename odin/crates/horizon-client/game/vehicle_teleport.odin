//! Transpiled from Horizon Rust crate
package horizon_client_vehicle_teleport

import "core:fmt"
import "core:mem"
import "core:math"

// The writers `/tp` and `/rotate` share with a vehicle's riders: a vehicle
// that is teleported takes its passengers along in the same operation, by the
// vehicle's offset and the angles it was placed at (`Entity.teleport` ->
// `teleportSameDimension` -> `calculatePassengerTransition`), and `/rotate`
// turns an entity without teleporting it (`RotateCommand` ->
// `Entity.forceSetRotation`).
// use super::Game;
// use super::commands::Target;
// use horizon_core::geometry::Vec3;
// use horizon_protocol::packets::play::{self, Clientbound as C};

is_horse :: proc(species: horizon_client::mobs::Species) -> b {
    // Ported from Horizon
    return {}
}
//     use horizon_client::mobs::Species::*;
    // rust: matches!(
    // rust: species,
    // rust: Horse
    // rust: | Donkey
    // rust: | Mule
    // rust: | SkeletonHorse
    // rust: | ZombieHorse
    // rust: | Camel
    // rust: | CamelHusk
    // rust: | Llama
    // rust: | TraderLlama
    // rust: )
}

// `Entity.calculatePassengerTransition` with no relative axes: the passenger
// keeps its offset from the vehicle.
    // rust: pub(super) fn passenger_destination(old_vehicle: Vec3, new_vehicle: Vec3, passenger: Vec3) -> Vec3 {
    // rust: Vec3::new(
    // rust: new_vehicle.x + (passenger.x - old_vehicle.x),
    // rust: new_vehicle.y + (passenger.y - old_vehicle.y),
    // rust: new_vehicle.z + (passenger.z - old_vehicle.z),
    // rust: )
}

// `PositionMoveRotation.calculateAbsolute` then `Entity.setXRot`: the pitch
// is clamped to -90..90 first (so 360 and +infinity are +90), and NaN is
// discarded (`None`).
    // rust: pub(super) fn absolute_pitch(pitch: f32) -> Option<f32> {
    // rust: let clamped = pitch.clamp(-90.0, 90.0);
    // rust: (!clamped.is_nan()).then(|| (clamped % 360.0).clamp(-90.0, 90.0))
}

// `Entity.calculatePassengerTransition` for the angles: a rider turns by what
// the vehicle turned, keeping `passenger.getYRot() - getYRot()`. An absolute
// angle adds that offset to the vehicle's new one; a relative one (`~`) is a
// delta the rider adds to its own: the same sum. `after` is the angle before
// the vehicle's pitch clamp; the rider's pitch is clamped on its own
// (`Entity.setXRot`), and an axis the command did not set leaves the rider's.
    // rust: pub(super) fn passenger_rotation(before: [f32; 2], after: [f32; 2], rider: [f32; 2]) -> [f32; 2] {
    // rust: let axis = |i: usize| {
    // rust: if after[i].is_finite() {
    // rust: after[i] + (rider[i] - before[i])
    // rust: } else {
    // rust: rider[i]
}
}
    // rust: [axis(0), absolute_pitch(axis(1)).unwrap_or(rider[1])]
}

// The angles a command turned a vehicle to, with the angles it had before:
// what `Entity.calculatePassengerTransition` needs for the riders.
    // rust: pub(super) struct PlacedRotation {
    // rust: pub before: [f32; 2],
    // rust: pub after: [f32; 2],
}

// The entity id a vehicle's riders point at, for the targets that carry some.
vehicle_id :: proc(t: Target) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Target::Boat(id) | Target::Cart(id) | Target::Mob(id) => Some(id),
    // rust: _ => None,
}
}

    // rust: impl Game<'_> {
    // `AbstractMinecart.getDismountLocationForPassenger` for a standing mob.
    // rust: pub(super) fn cart_dismount_point(&self, vehicle: u32, rider: usize) -> Option<Vec3> {
//         use horizon_core::geometry::Aabb;
    // rust: let cart = self.carts.iter().find(|c| c.id == vehicle)?;
    // rust: let rider = &self.mobs[rider];
    // rust: let direction =
    // rust: (f64::from(cart.yaw) / 90.0 + 0.5).floor() as i32 + if cart.flipped { 3 } else { 1 };
    // rust: let (fx, fz) = [(0, 1), (-1, 0), (0, -1), (1, 0)][(direction & 3) as usize];
    // rust: let (rx, rz) = (-fz, fx);
    // rust: let offsets = [
    // rust: (rx, rz),
    // rust: (-rx, -rz),
    // rust: (rx - fx, rz - fz),
    // rust: (-rx - fx, -rz - fz),
    // rust: (fx + rx, fz + rz),
    // rust: (fx - rx, fz - rz),
    // rust: (-fx, -fz),
    // rust: (fx, fz),
    // rust: ];
    // rust: let [bx, by, bz] =
    // rust: [cart.position.x, cart.position.y, cart.position.z].map(|v| v.floor() as i32);
    // rust: let half = f64::from(rider.width().min(1.0) / 2.0);
    // rust: for dy in [0, 1, -1] {
    // rust: for (dx, dz) in offsets {
    // rust: let p = [bx + dx, by + dy, bz + dz];
    // rust: let shape = self.block_collision_shape(p);
    // rust: let below = self.block_collision_shape([p[0], p[1] - 1, p[2]]);
    // rust: let floor = horizon_core::geometry::block_floor_height(&shape, || &below);
    // rust: if !floor.is_infinite() && floor < 1.0 {
    // rust: let at = Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + floor,
    // rust: f64::from(p[2]) + 0.5,
    // rust: );
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(at.x - half, at.y, at.z - half),
    // rust: Vec3::new(at.x + half, at.y + f64::from(rider.height()), at.z + half),
    // rust: );
    // rust: if self.can_dismount_to(bounds) {
    // rust: return Some(at);
}
}
}
}
    // rust: Some(Vec3::new(
    // rust: cart.position.x,
    // rust: cart.position.y + super::minecarts::HEIGHT,
    // rust: cart.position.z,
    // rust: ))
}

    // `AbstractHorse.getDismountLocationForPassenger`: try either side
    // through the mount's height, then fall back to its feet.
    // rust: pub(super) fn horse_dismount_point(&self, vehicle: u32, rider: usize) -> Option<Vec3> {
//         use horizon_core::geometry::{Aabb, trig};
    // rust: let mount = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == vehicle && is_horse(m.species()))?;
    // rust: let rider = &self.mobs[rider];
    // rust: let turn = if rider.main_arm_left() { -90.0 } else { 90.0 };
    // rust: let reach =
    // rust: (f64::from(mount.width()) + f64::from(rider.width()) + f64::from(1e-5_f32)) / 2.0;
    // rust: let limit = mount.bounds().max_position().y + 0.75;
    // rust: for turn in [turn, -turn] {
    // rust: let radians = f64::from((mount.yaw + turn) * 0.017_453_292);
    // rust: let (dx, dz) = (-trig::sin(radians), trig::cos(radians));
    // rust: let scale = f64::from(dx.abs().max(dz.abs()));
    // rust: let x = mount.position.x + f64::from(dx) * reach / scale;
    // rust: let z = mount.position.z + f64::from(dz) * reach / scale;
    // rust: let mut y = mount.position.y.floor() as i32;
    // rust: loop {
    // rust: let p = [x.floor() as i32, y, z.floor() as i32];
    // rust: let shape = self.block_collision_shape(p);
    // rust: let below = self.block_collision_shape([p[0], p[1] - 1, p[2]]);
    // rust: let floor = horizon_core::geometry::block_floor_height(&shape, || &below);
    // rust: if f64::from(y) + floor > limit {
    // rust: break;
}
    // rust: if !floor.is_infinite() && floor < 1.0 {
    // rust: let at = Vec3::new(x, f64::from(y) + floor, z);
    // rust: let half = f64::from(rider.width()) / 2.0;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(x - half, at.y, z - half),
    // rust: Vec3::new(x + half, at.y + f64::from(rider.height()), z + half),
    // rust: );
    // rust: if self.can_dismount_to(bounds) {
    // rust: return Some(at);
}
}
    // rust: y += 1;
    // rust: if f64::from(y) >= limit {
    // rust: break;
}
}
}
    // rust: Some(mount.position)
}

    // `Entity.teleportCrossDimension` ejects the riders before calculating
    // their transitions. Dismounting also seats their own passengers again.
prepare_vehicle_transition :: proc(self: ^Self, root: u32) {
}
    // rust: let riders: Vec<_> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.extra.mount == Some(root))
    // rust: .map(|m| m.id)
    // rust: .collect();
    // rust: for &rider in riders.iter().rev() {
    // rust: self.dismount_mob(rider);
    // rust: self.snap_mob_passengers(rider);
}
    // rust: for rider in riders {
    // rust: self.prepare_vehicle_transition(rider);
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == rider) {
                // Preserve the tree for serialization after all transitions
                // have used the positions left by ejectPassengers.
    // rust: m.extra.mount = Some(root);
    // rust: m.extra.passenger = true;
}
}
}

    // `Entity.teleportPassengers` on a mob dismounted during a transition.
snap_mob_passengers :: proc(self: ^Self, root: u32) {
}
//         use horizon_client::mobs::riders;
    // rust: let Some(vehicle) = self.mobs.iter().find(|m| m.id == root) else {
    // rust: return;
}
    // rust: let (position, yaw, width, attachment) = (
    // rust: vehicle.position,
    // rust: vehicle.yaw,
    // rust: vehicle.width(),
    // rust: riders::passenger_attachment(vehicle),
    // rust: );
    // rust: let mut children = Vec::new();
    // rust: for m in self.mobs.iter_mut().filter(|m| m.extra.mount == Some(root)) {
    // rust: m.position = riders::seat(
    // rust: attachment,
    // rust: riders::vehicle_attachment(m, width),
    // rust: position,
    // rust: yaw,
    // rust: );
    // rust: m.previous = m.position;
    // rust: children.push(m.id);
}
    // rust: for child in children {
    // rust: self.snap_mob_passengers(child);
}
}

    // `Entity.teleportCrossDimension`: carry a command's entire vehicle tree
    // into the destination level, retaining UUIDs and the passengers' mounts.
    // rust: pub(super) fn teleport_vehicle_across(
    // rust: &mut self,
    // rust: target: Target,
    // rust: destination: super::Dim,
    // rust: at: [f64; 3],
    // rust: rotation: Option<[f32; 2]>,
    // rust: turn_riders: bool,
    // rust: ) -> horizon_client::Result<bool> {
    // rust: let Some(root) = vehicle_id(target) else {
    // rust: return Ok(false);
}
    // rust: self.in_target_level(target, |game| {
    // rust: let source = game.dim;
    // rust: if source == destination {
    // rust: return Ok(false);
}
            // Open the destination before changing or removing any entity.
    // rust: game.enter_level(None, destination)?;
    // rust: game.enter_level(None, source)?;
    // rust: if game
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|m| m.id == root && m.extra.mount.is_some())
    // rust: {
    // rust: game.dismount_mob(root);
    // rust: game.snap_mob_passengers(root);
}
    // rust: game.prepare_vehicle_transition(root);
    // rust: game.teleport_to_in_level(target, at, rotation, turn_riders);
    // rust: let mounts: Vec<_> = game.mobs.iter().map(|m| (m.id, m.extra.mount)).collect();
    // rust: let tree = super::persist::vehicle_tree(root, &mounts);
    // rust: let tag = game.vehicle_tree_nbt(root).ok_or("missing vehicle tree")?;
    // rust: let kind = horizon_client::entity_nbt::kind(&tag).ok_or("missing vehicle type")?;
    // rust: let uuid = horizon_client::entity_nbt::uuid(&tag);
    // rust: let mut players = Vec::new();
            // A command runs with its source player swapped out of the hub.
    // rust: if game.riding.is_some_and(|id| tree.contains(&id))
    // rust: && let (Some(conn), Some(player)) = (game.lan_acting, game.player.as_ref())
    // rust: {
    // rust: players.push((
    // rust: conn,
    // rust: [player.position.x, player.position.y, player.position.z],
    // rust: [game.yaw, game.pitch],
    // rust: game.riding.unwrap(),
    // rust: ));
}
    // rust: if let Some(host) = game.lan.as_ref() {
    // rust: for guest in &host.hub.guests {
    // rust: if Some(guest.conn) != game.lan_acting
    // rust: && guest.vehicle.is_some_and(|id| tree.contains(&id))
    // rust: {
    // rust: players.push((
    // rust: guest.conn,
    // rust: guest.position,
    // rust: [guest.yaw, guest.pitch],
    // rust: guest.vehicle.unwrap(),
    // rust: ));
}
}
}
    // rust: let players: Vec<_> = players
    // rust: .into_iter()
    // rust: .map(|(conn, at, rotation, mount)| (conn, at, rotation, game.uuid_for(mount)))
    // rust: .collect();
    // rust: game.mobs.retain(|m| !tree.contains(&m.id));
    // rust: game.boats.retain(|b| !tree.contains(&b.id));
    // rust: game.carts.retain(|c| !tree.contains(&c.id));
    // rust: for id in tree {
    // rust: game.release_vehicle_container(id);
    // rust: game.detach_entity(id);
}
    // rust: game.native_leaves_flush();
    // rust: game.enter_level(None, destination)?;
            // restoreFrom reloads saved state into fresh entities, rather than
            // retaining navigation paths or goals from the old level.
    // rust: game.load_listed(&kind, uuid, game.level.player_uuid, tag)
    // rust: .map_err(|_| "could not restore vehicle tree")?;
            // AbstractHorse.addPassenger snaps a reattached passenger to the
            // new horse's getViewYRot(0) / getViewXRot(0). A fresh living
            // entity's previous head yaw is still zero, before its first tick.
    // rust: let new_root = uuid
    // rust: .and_then(|uuid| game.vehicle_by_uuid(uuid))
    // rust: .ok_or("restored vehicle is missing")?;
    // rust: let mounts: Vec<_> = game.mobs.iter().map(|m| (m.id, m.extra.mount)).collect();
    // rust: let restored = super::persist::vehicle_tree(new_root, &mounts);
    // rust: let horses: Vec<_> = game
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| restored.contains(&m.id) && is_horse(m.species()))
    // rust: .map(|m| (m.id, m.head_pitch))
    // rust: .collect();
    // rust: for (horse, pitch) in horses {
    // rust: for rider in game
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .filter(|m| m.extra.mount == Some(horse))
    // rust: {
    // rust: rider.yaw = 0.0;
    // rust: rider.previous_yaw = 0.0;
    // rust: rider.head_pitch = pitch;
    // rust: rider.previous_head_pitch = pitch;
}
}
    // rust: for (conn, at, rotation, mount) in players {
    // rust: game.level_teleports
    // rust: .push(super::server_travel::LevelTeleport {
    // rust: conn,
    // rust: dim: destination,
    // rust: at,
    // rust: rotation: Some(rotation),
    // rust: vehicle: game.vehicle_by_uuid(mount),
    // rust: });
}
    // rust: game.native_joins_flush(false, 0);
    // rust: game.enter_level(None, source)?;
    // rust: Ok(true)
    // rust: })
    // rust: .unwrap_or(Ok(false))
}

    // `Entity.teleportSameDimension`: after `t` moved from `from` to `to`, its
    // riders move by the same offset, and to the angles the vehicle was
    // placed at when it turned (`calculatePassengerTransition`), staying
    // seated and recursive. The player in place and the hub's guests (a guest
    // also gets its own position packet, as `ServerPlayer.teleport` sends one
    // for a passenger).
    // rust: pub(super) fn teleport_passengers(
    // rust: &mut self,
    // rust: t: Target,
    // rust: from: [f64; 3],
    // rust: to: [f64; 3],
    // rust: rotation: Option<PlacedRotation>,
    // rust: ) {
    // rust: let Some(id) = vehicle_id(t) else {
    // rust: return;
}
    // rust: let (old, new) = (
    // rust: Vec3::new(from[0], from[1], from[2]),
    // rust: Vec3::new(to[0], to[1], to[2]),
    // rust: );
    // rust: self.move_riders(id, old, new, rotation);
}
    // rust: fn move_riders(
    // rust: &mut self,
    // rust: vehicle: u32,
    // rust: old: Vec3,
    // rust: new: Vec3,
    // rust: rotation: Option<PlacedRotation>,
    // rust: ) {
    // rust: let riders: Vec<u32> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.extra.mount == Some(vehicle))
    // rust: .map(|m| m.id)
    // rust: .collect();
    // rust: for id in riders {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.position = passenger_destination(old, new, m.position);
    // rust: m.previous = m.position;
                // Entity.calculatePassengerTransition turns the rider with the
                // vehicle, then Entity.teleportSetPosition keeps the old angles
                // for the interpolation.
    // rust: if let Some(placed) = rotation {
    // rust: let [yaw, pitch] =
    // rust: passenger_rotation(placed.before, placed.after, [m.yaw, m.head_pitch]);
    // rust: m.yaw = yaw;
    // rust: m.body_yaw = yaw;
    // rust: m.head_yaw = yaw;
    // rust: m.head_pitch = pitch;
    // rust: m.previous_yaw = yaw;
    // rust: m.previous_head_pitch = pitch;
}
}
    // rust: self.move_riders(id, old, new, rotation);
}
    // rust: if self.riding == Some(vehicle)
    // rust: && let Some(p) = self.player.as_mut()
    // rust: {
    // rust: p.position = passenger_destination(old, new, p.position);
    // rust: p.teleported = true;
    // rust: self.previous_position = p.position;
}
    // rust: if let Some(placed) = rotation
    // rust: && self.riding == Some(vehicle)
    // rust: {
    // rust: let [yaw, pitch] =
    // rust: passenger_rotation(placed.before, placed.after, [self.yaw, self.pitch]);
    // rust: if yaw.is_finite() {
    // rust: self.yaw = yaw;
}
    // rust: if pitch.is_finite() {
    // rust: self.pitch = pitch;
}
}
    // rust: let [yaw, pitch] = self.vehicle_rotation(vehicle);
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: for i in 0..host.hub.guests.len() {
    // rust: if host.hub.guests[i].vehicle != Some(vehicle) {
    // rust: continue;
}
                // Entity.sendTeleportTransitionToRidingPlayers: the rider's
                // client moves the vehicle it drives itself, so it hears the
                // vehicle's teleport (else its next MoveVehicle undoes it).
    // rust: host.hub.guests[i].send(&C::TeleportEntity(play::TeleportEntity {
    // rust: id: vehicle as i32,
    // rust: position: [new.x, new.y, new.z],
    // rust: delta: [0.0; 3],
    // rust: yaw,
    // rust: pitch,
    // rust: relatives: 0,
    // rust: on_ground: false,
    // rust: }));
    // rust: if let Some(placed) = rotation {
    // rust: let g = &mut host.hub.guests[i];
    // rust: let [yaw, pitch] =
    // rust: passenger_rotation(placed.before, placed.after, [g.yaw, g.pitch]);
    // rust: g.yaw = yaw;
    // rust: g.head_yaw = yaw;
    // rust: g.pitch = pitch;
}
    // rust: let g = host.hub.guests[i].position;
    // rust: let at = passenger_destination(old, new, Vec3::new(g[0], g[1], g[2]));
    // rust: if rotation.is_some() {
                    // A rider turned with its vehicle: its position packet
                    // carries the new rotation and keeps its motion.
    // rust: host.hub.teleport_rider(i, [at.x, at.y, at.z]);
    // rust: } else {
    // rust: host.hub.teleport_keeping_motion(i, [at.x, at.y, at.z]);
}
}
}
}

    // A vehicle's yaw and pitch, for the riders' teleport packet.
vehicle_rotation :: proc(self: ^Self, id: u32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(b) = self.boats.iter().find(|b| b.id == id) {
    // rust: [b.yaw, b.pitch]
    // rust: } else if let Some(c) = self.carts.iter().find(|c| c.id == id) {
    // rust: [c.yaw, c.pitch]
    // rust: } else if let Some(m) = self.mobs.iter().find(|m| m.id == id) {
    // rust: [m.yaw, m.head_pitch]
    // rust: } else {
    // rust: [0.0, 0.0]
}
}

    // `Entity.forceSetRotation`: yaw, head yaw, pitch and their old values
    // only. Position, motion, the vehicle and the riders stay.
    // rust: pub(super) fn set_rotation(&mut self, t: Target, rotation: [f32; 2]) {
    // rust: let _ = self.in_target_level(t, |g| g.set_rotation_in_level(t, rotation));
}
set_rotation_in_level :: proc(self: ^Self, t: Target, pitch]: [f32; 2]) {
}
    // rust: let pitch = absolute_pitch(pitch);
    // rust: match t {
    // rust: Target::Guest(_) => {
    // rust: self.for_player(t, |g| {
    // rust: g.set_rotation_in_level(Target::Player, [yaw, pitch.unwrap_or(f32::NAN)])
    // rust: });
}
    // rust: Target::Player => {
    // rust: if yaw.is_finite() {
    // rust: self.yaw = yaw;
}
    // rust: if let Some(pitch) = pitch {
    // rust: self.pitch = pitch;
}
                // A server's player hears the turn alone when its turn ends.
    // rust: self.rotation_forced = self.lan_acting.is_some();
}
    // rust: Target::Mob(id) => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: if yaw.is_finite() {
    // rust: m.yaw = yaw;
    // rust: m.body_yaw = yaw;
    // rust: m.head_yaw = yaw;
}
    // rust: if let Some(pitch) = pitch {
    // rust: m.head_pitch = pitch;
}
    // rust: m.previous_yaw = m.yaw;
    // rust: m.previous_head_pitch = m.head_pitch;
}
}
    // rust: Target::Other(id) => {
    // rust: if let Some(o) = self.others.iter_mut().find(|o| o.id == id) {
    // rust: if yaw.is_finite() {
    // rust: o.yaw = yaw;
}
    // rust: if let Some(pitch) = pitch {
    // rust: o.pitch = pitch;
}
}
}
    // rust: Target::Stand(id) if yaw.is_finite() => {
    // rust: if let Some(a) = self.armor_stands.iter_mut().find(|a| a.id == id) {
    // rust: a.yaw = yaw;
}
}
    // rust: Target::Boat(id) if yaw.is_finite() => {
    // rust: if let Some(b) = self.boats.iter_mut().find(|b| b.id == id) {
    // rust: b.yaw = yaw;
    // rust: if let Some(pitch) = pitch {
    // rust: b.pitch = pitch;
}
}
}
    // rust: Target::Cart(id) if yaw.is_finite() => {
    // rust: if let Some(c) = self.carts.iter_mut().find(|c| c.id == id) {
    // rust: c.yaw = yaw;
    // rust: if let Some(pitch) = pitch {
    // rust: c.pitch = pitch;
}
}
}
    // rust: Target::Fangs(id) if yaw.is_finite() => {
    // rust: if let Some(f) = self.fangs.list.iter_mut().find(|f| f.id == id) {
    // rust: f.yaw = yaw;
}
}
    // rust: _ => {}
}
}
}

    // rust: mod tests {
//     use super::*;
passenger_keeps_its_offset :: proc() {
}
    // rust: let at = passenger_destination(
    // rust: Vec3::new(0.0, 64.0, 0.0),
    // rust: Vec3::new(100.0, 70.0, -20.0),
    // rust: Vec3::new(0.0, 64.5, 0.25),
    // rust: );
    // rust: assert_eq!((at.x, at.y, at.z), (100.0, 70.5, -19.75));
}
pitch_clamps_before_the_setter :: proc() {
}
    // rust: assert_eq!(absolute_pitch(360.0), Some(90.0));
    // rust: assert_eq!(absolute_pitch(-360.0), Some(-90.0));
    // rust: assert_eq!(absolute_pitch(f32::INFINITY), Some(90.0));
    // rust: assert_eq!(absolute_pitch(f32::NEG_INFINITY), Some(-90.0));
    // rust: assert_eq!(absolute_pitch(45.0), Some(45.0));
    // rust: assert_eq!(absolute_pitch(f32::NAN), None);
}
an_absolute_turn_keeps_the_riders_angle_to_the_vehicle :: proc() {
}
        // A rider 30 degrees off a vehicle that turns from 0 to 90 ends at
        // 120: it keeps the 30 degrees it had on it.
    // rust: assert_eq!(
    // rust: passenger_rotation([0.0, 0.0], [90.0, 0.0], [30.0, 0.0]),
    // rust: [120.0, 0.0]
    // rust: );
        // The pitch keeps its offset the same way, through Entity.setXRot's
        // clamp: 40 - 10 = 30 degrees off a vehicle placed at 70 would be 100.
    // rust: assert_eq!(
    // rust: passenger_rotation([10.0, 10.0], [0.0, 70.0], [0.0, 40.0]),
    // rust: [-10.0, 90.0]
    // rust: );
}
a_rider_turns_from_the_vehicles_unclamped_pitch :: proc() {
}
        // `~ ~100` on a level vehicle: the vehicle stops at 90, a rider 50
        // below it adds the whole 100 (calculatePassengerTransition) and ends at 50.
    // rust: assert_eq!(
    // rust: passenger_rotation([0.0, 0.0], [0.0, 100.0], [0.0, -50.0]),
    // rust: [0.0, 50.0]
    // rust: );
}
an_axis_the_command_did_not_set_leaves_the_riders_own :: proc() {
}
    // rust: assert!(passenger_rotation([0.0, 0.0], [f32::NAN, 0.0], [30.0, 0.0])[0] == 30.0);
    // rust: assert!(passenger_rotation([0.0, 0.0], [0.0, f32::NAN], [0.0, 40.0])[1] == 40.0);
}
}
