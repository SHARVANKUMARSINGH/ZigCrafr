//! Transpiled from Horizon Rust crate
package horizon_client_remote_vehicles

import "core:fmt"
import "core:mem"
import "core:math"

// Boats, minecarts, item frames, armor stands and paintings for a server's
// client: single player on its server thread, a LAN guest, a player on a
// dedicated server.
//
// The client aims at them like at mobs (`Minecraft.hitResult`, then
// `ServerboundInteractPacket`), and rides the vehicle the server seats it in
// (`ClientPacketListener.handleSetEntityPassengersPacket`). A boat is
// controlled by its rider's client: it ticks here and its moves go to the
// server (`LocalPlayer.tick`: `ServerboundMoveVehiclePacket`,
// `AbstractBoat.tick`: `ServerboundPaddleBoatPacket`). So is a saddled horse,
// donkey, mule or camel: its rider's client moves it and reports the moves,
// and tells the server of a riding jump (`START_RIDING_JUMP`). Pigs and striders
// also move on their rider's client when saddled and steered with the right stick.
// A minecart
// moves on the server with the rider's input, and the rider sits in it.
// use super::{Game, Keys, ray_box};
// use crate::Result;
// use horizon_client::mobs::{Mob, equine, happy_ghast};
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_protocol::packets::play::{self, Serverbound as S};

// An object under the crosshair: its entity id, how far along the view it
// was hit, and where (`EntityHitResult.getLocation` minus the entity's
// position, the interact packet's location).
    // rust: pub(super) struct ObjectHit {
    // rust: pub id: i32,
    // rust: pub distance: f64,
    // rust: pub location: [f64; 3],
}

    // rust: impl Game<'_> {
    // BlockAttachedEntity.isPickable: the nearest fence knot's box the view meets, with its id,
    // distance and position. Its box is wider than the post inside it, so the crosshair meets it
    // first and LeashFenceKnotEntity.interact takes the click. The fence block behind only ties
    // the player's own mobs (LeadItem.useOn), it never takes one back.
remote_knot_hit :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (eye, dir) = self.aim()?;
    // rust: self.remote_knots
    // rust: .iter()
    // rust: .filter_map(|(&id, &block)| {
    // rust: let knot = horizon_client::mobs::leash::knot_state(block);
    // rust: let p = knot.position;
    // rust: let half = knot.width / 2.0;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(p.x - half, p.y, p.z - half),
    // rust: Vec3::new(p.x + half, p.y + knot.height, p.z + half),
    // rust: );
    // rust: ray_box(eye, dir, self.entity_reach, bounds)
    // rust: .map(|d| (id as i32, d, [p.x, p.y, p.z]))
    // rust: })
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
}

    // Whether a use starts on an entity: the crosshair's `EntityHitResult`, or a fence knot.
    // Only a use: Horizon's attacks still go to the fence behind a knot.
    // rust: pub(super) fn remote_use_targets_entity(&self) -> bool {
    // rust: self.entity_targeted()
    // rust: || self
    // rust: .remote_knot_hit()
    // rust: .is_some_and(|(_, d, _)| self.before_block(d))
}

    // The nearest boat, minecart, item frame, armor stand or painting the
    // view hits within reach; also End crystals when attacking, and fence knots when using.
    // rust: pub(super) fn remote_object_hit(&self, attacking: bool) -> Option<ObjectHit> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let at = |d: f64| {
    // rust: [
    // rust: eye[0] + dir[0] * d,
    // rust: eye[1] + dir[1] * d,
    // rust: eye[2] + dir[2] * d,
    // rust: ]
}
    // rust: let block_centre = |p: [i32; 3]| {
    // rust: [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ]
}
    // rust: let mut hits: Vec<(i32, f64, [f64; 3])> = Vec::new();
    // rust: if let Some((i, d)) = self.painting_hit() {
    // rust: let p = &self.paintings[i];
    // rust: hits.push((p.id as i32, d, block_centre(p.pos)));
}
    // rust: if let Some((i, d)) = self.frame_hit() {
    // rust: let f = &self.item_frames[i];
    // rust: hits.push((f.id as i32, d, block_centre(f.pos)));
}
    // rust: if let Some((i, d, _)) = self.armor_stand_hit() {
    // rust: let a = &self.armor_stands[i];
    // rust: let p = a.position;
    // rust: hits.push((a.id as i32, d, [p.x, p.y, p.z]));
}
    // rust: if let Some((i, d, _)) = self.cushion_hit() {
    // rust: let c = &self.cushions[i];
    // rust: let p = c.position;
    // rust: hits.push((c.id as i32, d, [p.x, p.y, p.z]));
}
    // rust: if let Some((i, d)) = self.boat_hit() {
    // rust: let p = self.boats[i].position;
    // rust: hits.push((self.boats[i].id as i32, d, [p.x, p.y, p.z]));
}
    // rust: if let Some((i, d)) = self.cart_hit() {
    // rust: let p = self.carts[i].position;
    // rust: hits.push((self.carts[i].id as i32, d, [p.x, p.y, p.z]));
}
        // Interaction.isPickable: an invisible box the server clicks through
        // to its scripts, for both uses and attacks.
    // rust: let reach = self.entity_reach;
    // rust: for (&id, i) in &self.interactions {
    // rust: if let Some(d) = ray_box(eye, dir, reach, i.bounds()) {
    // rust: let p = i.position;
    // rust: hits.push((id, d, [p.x, p.y, p.z]));
}
}
    // rust: if !attacking && let Some((id, d, p)) = self.remote_knot_hit() {
    // rust: hits.push((id, d, p));
}
    // rust: if attacking {
            // EndCrystal.isPickable: its 2 x 2 box, with the server's entity
            // id, not special_targets' local projectile target id.
            // Entity.interact passes on a crystal, so right clicks use the item.
    // rust: let reach = self.entity_reach;
    // rust: for c in self.crystals.iter().filter(|c| c.id != 0) {
    // rust: let p = c.position;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(p.x - 1.0, p.y, p.z - 1.0),
    // rust: Vec3::new(p.x + 1.0, p.y + 2.0, p.z + 1.0),
    // rust: );
    // rust: if let Some(d) = ray_box(eye, dir, reach, bounds) {
    // rust: hits.push((c.id as i32, d, [p.x, p.y, p.z]));
}
}
            // EnderDragonPart.isPickable: the server's dragon hurts by part.
    // rust: hits.extend(self.remote_dragon_part_hit(eye, dir, reach));
}
    // rust: let (id, distance, origin) = hits.into_iter().min_by(|a, b| a.1.total_cmp(&b.1))?;
    // rust: let point = at(distance);
    // rust: Some(ObjectHit {
    // rust: id,
    // rust: distance,
    // rust: location: [
    // rust: point[0] - origin[0],
    // rust: point[1] - origin[1],
    // rust: point[2] - origin[2],
    // rust: ],
    // rust: })
}

    // `ClientPacketListener.handleSetEntityPassengersPacket`: who rides
    // `vehicle` now. The local player gets in or out; mobs and other
    // players sit where the server keeps them.
    // rust: pub(super) fn remote_set_passengers(&mut self, vehicle: i32, passengers: &[i32]) {
    // rust: let Some(me) = self.remote.as_ref().map(|r| r.entity_id) else {
    // rust: return;
}
    // rust: let vehicle_id = vehicle as u32;
    // rust: self.remote_seat_passengers(vehicle_id, passengers);
    // rust: let player_controls = passengers.first().is_some_and(|&id| {
    // rust: self.remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.level_player(id).is_some())
    // rust: });
    // rust: if let Some(boat) = self.boats.iter_mut().find(|b| b.id == vehicle_id) {
    // rust: boat.paddle_controller = player_controls;
}

    // rust: for m in &mut self.mobs {
            // `Entity.isVehicle` (the saddle reins of a ridden horse): the
            // server sends no rider on the mob itself, only this list.
    // rust: if m.id == vehicle_id {
    // rust: m.extra.rider = passengers.first().map(|&p| p as u32);
}
    // rust: if m.extra.mount == Some(vehicle_id) && !passengers.contains(&(m.id as i32)) {
    // rust: m.extra.mount = None;
    // rust: m.extra.passenger = false;
    // rust: } else if passengers.contains(&(m.id as i32)) {
    // rust: m.extra.mount = Some(vehicle_id);
    // rust: m.extra.passenger = true;
}
}
    // rust: for (id, display) in &mut self.text_displays {
    // rust: if passengers.contains(id) {
    // rust: display.vehicle = Some(vehicle_id);
    // rust: } else if display.vehicle == Some(vehicle_id) {
    // rust: display.vehicle = None;
}
}
    // rust: for a in &mut self.armor_stands {
    // rust: if passengers.contains(&(a.id as i32)) {
    // rust: a.vehicle = Some(vehicle_id);
    // rust: } else if a.vehicle == Some(vehicle_id) {
    // rust: a.vehicle = None;
}
}
    // rust: for (&id, i) in &mut self.interactions {
    // rust: if passengers.contains(&id) {
    // rust: i.vehicle = Some(vehicle_id);
    // rust: } else if i.vehicle == Some(vehicle_id) {
    // rust: i.vehicle = None;
}
}
    // rust: if passengers.contains(&me)
    // rust: && let Some(r) = self.remote.as_mut()
    // rust: {
    // rust: r.first_passenger = passengers.first() == Some(&me);
    // rust: r.passenger_index = passengers.iter().position(|&p| p == me).unwrap_or(0);
}
    // rust: if passengers.contains(&me) {
    // rust: if self.riding != Some(vehicle_id) {
    // rust: self.riding = Some(vehicle_id);
    // rust: if let Some(c) = self.carts.iter_mut().find(|c| c.id == vehicle_id) {
    // rust: c.passenger_yaw_delta = 0.0;
}
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.velocity = Vec3::ZERO;
    // rust: p.fall_distance = 0.0;
}
}
    // rust: } else if self.riding == Some(vehicle_id) {
            // The server takes the player out, then teleports it.
    // rust: self.riding = None;
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, vehicle_id) {
    // rust: m.rider = None;
}
            // HappyGhast.removePassenger: a still timeout of 10 (the server's
            // STAYS_STILL confirms it), and the rider lands on top of the ghast
            // (`place_ghast_under`).
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| {
    // rust: m.id == vehicle_id && m.species() == horizon_client::mobs::Species::HappyGhast
    // rust: }) {
    // rust: m.extra.counter = 10;
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.ghast_dismount = Some(vehicle_id);
}
}
}
}

    // Camera.alignWithEntity's NewMinecartBehavior branch: sample the
    // vehicle's curved path at this frame, then apply the player's seat
    // attachment. Camera's own eye-height interpolation still runs afterwards.
    // rust: pub(super) fn remote_minecart_rider_position(&self, partial: f32) -> Option<[f64; 3]> {
    // rust: if !self.minecart_improvements() {
    // rust: return None;
}
    // rust: let id = self.riding?;
    // rust: self.carts
    // rust: .iter()
    // rust: .find(|c| c.id == id && c.kind == super::minecarts::CartKind::Rideable)?;
    // rust: let (mut position, _, _) = self.remote_minecart_lerp(id, partial)?;
    // rust: position[1] += super::minecarts::SEAT;
    // rust: Some(position)
}

    // The local player's tick in its vehicle, in place of its own movement:
    // false when it rides nothing.
    // rust: pub(super) fn remote_ride(&mut self, keys: Keys, sprint_window: i32) -> Result<bool> {
    // rust: let Some(id) = self.riding else {
    // rust: return Ok(false);
}
        // LocalPlayer.aiStep runs its sprint decisions in a vehicle too: `canSprint` and
        // this client's authority stand in for food (`isSprintingPossible`).
    // rust: let (can_sprint, local) = self
    // rust: .driven_mount()
    // rust: .map_or((false, false), |m| (equine::can_sprint(m.species()), true));
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.sprint_input_tick_riding(keys, sprint_window, can_sprint, local)?;
}
    // rust: if let Some(i) = self.mobs.iter().position(|m| m.id == id) {
            // LocalPlayer.aiStep: the jump bar charges while jump is held.
    // rust: let jump = self.charge_mount_jump(i, keys);
    // rust: if self.drives(&self.mobs[i]) {
    // rust: self.drive_mount(i, keys, jump);
}
            // Another animal moves on the server with the rider's input
            // (PlayerInput); the rider sits where `positionRider` puts it.
    // rust: self.position_rider();
    // rust: return Ok(true);
}
    // rust: let seat = if let Some(c) = self.cushions.iter().find(|c| c.id == id) {
            // The seat does not move; the rider sits on the cushion.
    // rust: Some(c.seat())
    // rust: } else if let Some(i) = self.boats.iter().position(|b| b.id == id) {
            // AbstractBoat.tick on the controlling client: steer and move.
            // It steers with the input `LocalPlayer.rideTick` latched on the
            // previous tick, so the paddle packet describes the motion the
            // server is sent; this tick's keys are latched after it ticked.
    // rust: let mut b = self.tick_boat(self.boats[i].clone(), true);
    // rust: b.input = [keys.left, keys.right, keys.forward, keys.backward];
            // positionRider: the seat turns with the boat; clampRotation.
    // rust: self.yaw += b.delta_rotation;
    // rust: let delta = (self.yaw - b.yaw + 180.0).rem_euclid(360.0) - 180.0;
    // rust: self.yaw += delta.clamp(-105.0, 105.0) - delta;
    // rust: self.boats[i] = b;
            // In front of a mob that shares the boat.
    // rust: Some(self.player_boat_seat(i))
    // rust: } else {
            // Minecart.positionRider runs on the client after the cart tick.
            // The offset belongs to the cart, so switching vehicles cannot
            // transfer the previous vehicle's pending turn.
    // rust: let rotate =
    // rust: self.minecart_improvements() && self.settings.file.bool("rotateWithMinecart");
    // rust: if let Some(c) = self.carts.iter_mut().find(|c| c.id == id) {
    // rust: c.passenger_yaw_delta = 0.0;
    // rust: if rotate && c.kind == super::minecarts::CartKind::Rideable {
    // rust: c.rotate_passenger(&mut self.yaw);
}
}
            // A minecart: the server moves it, the rider sits in it.
    // rust: let cart = self.carts.iter().find(|c| c.id == id).map(|c| {
    // rust: c.position
    // rust: .add_vector(Vec3::new(0.0, super::minecarts::SEAT, 0.0))
    // rust: });
    // rust: if cart.is_none() {
                // Entity.baseTick: a passenger whose vehicle is gone stops
                // riding it. Nothing with the id is in the level any more (it
                // died, or the world it rode in was left), so the seat goes.
    // rust: self.riding = None;
    // rust: return Ok(false);
}
    // rust: cart
}
    // rust: if let Some(p) = self.player.as_mut() {
            // The tick a rider takes its seat is a teleport (`Entity.moveTo`,
            // which sets the old position too): the camera must not sweep from
            // where the player stood to the cushion, boat or cart. The ticks
            // after it move with the vehicle and interpolate as usual.
    // rust: let first = self.posed_rider != self.riding;
    // rust: self.posed_rider = self.riding;
    // rust: if let Some(v) = seat {
    // rust: self.previous_position = if first { v } else { p.position };
    // rust: p.position = v;
    // rust: } else {
    // rust: self.previous_position = p.position;
}
    // rust: p.velocity = Vec3::ZERO;
    // rust: p.fall_distance = 0.0;
}
    // rust: Ok(true)
}

    // `LocalPlayer.tick` for a passenger: the boat it controls goes to the
    // server every tick with its paddles (the rider's own position does not).
    // rust: pub(super) fn remote_vehicle_packets(&self) -> Vec<S> {
    // rust: if let Some(m) = self.driven_mount() {
    // rust: return vec![mount_move(m)];
}
    // rust: let Some(b) = self
    // rust: .riding
    // rust: .and_then(|id| self.boats.iter().find(|b| b.id == id))
    // rust: else {
    // rust: return Vec::new();
}
    // rust: vec![
    // rust: S::MoveVehicle(play::MoveVehicleRequest {
    // rust: position: [b.position.x, b.position.y, b.position.z],
    // rust: yaw: b.yaw,
    // rust: pitch: 0.0,
    // rust: on_ground: b.on_ground,
    // rust: }),
    // rust: S::PaddleBoat(play::PaddleBoat {
    // rust: left: b.paddling[0],
    // rust: right: b.paddling[1],
    // rust: }),
    // rust: ]
}

    // `ClientPacketListener.handleMoveVehicle`: the server put the boat or
    // the mount the player drives back.
    // rust: pub(super) fn remote_move_vehicle(&mut self, position: [f64; 3], yaw: f32) {
    // rust: let at = Vec3::new(position[0], position[1], position[2]);
    // rust: if let Some(id) = self.driven_mount().map(|m| m.id)
    // rust: && let Some(m) = self.mob_index.get_mut(&mut self.mobs, id)
    // rust: {
    // rust: m.previous = at;
    // rust: m.position = at;
    // rust: m.yaw = yaw;
    // rust: m.previous_yaw = yaw;
    // rust: m.velocity = Vec3::ZERO;
    // rust: return;
}
    // rust: let Some(b) = self
    // rust: .riding
    // rust: .and_then(|id| self.boats.iter_mut().find(|b| b.id == id))
    // rust: else {
    // rust: return;
}
    // rust: b.previous = at;
    // rust: b.position = at;
    // rust: b.yaw = yaw;
    // rust: b.previous_yaw = yaw;
    // rust: b.velocity = Vec3::ZERO;
}

    // `AbstractBoat.handleEntityEvent`: 71 and 72, a bubble column dragging
    // the boat down or throwing it up (`handleBubbleColumnEffect`, which the
    // client applies to the boat it drives).
    // rust: pub(super) fn remote_boat_event(&mut self, id: i32, event: i8) {
    // rust: let drag_down = event == super::boats::BUBBLE_DOWN_EVENT;
    // rust: if !drag_down && event != super::boats::BUBBLE_UP_EVENT {
    // rust: return;
}
    // rust: if let Some(i) = self.boats.iter().position(|b| b.id == id as u32) {
    // rust: self.handle_bubble_column_effect(i, drag_down);
}
}

    // `AbstractBoat.tick`: the part that reaches bubble columns, for every
    // boat on a client: `status`, the two `applyEffectsFromBlocks` (a boat
    // above a column may splash; the boat the player drives is lifted or
    // dragged by a column it is inside) and `tickBubbleColumn`'s wobble from
    // the synched bubble time, followed by the oars on boats this client does not drive.
    // rust: pub(super) fn tick_remote_boat_bubbles(&mut self) {
    // rust: for i in 0..self.boats.len() {
    // rust: let driven = self.riding == Some(self.boats[i].id);
    // rust: if !driven {
                // `AbstractBoat.tick`: the non-authoritative copy carries no
                // cached motion into the next time this player drives it.
    // rust: self.boats[i].velocity = Vec3::ZERO;
    // rust: self.boats[i].delta_rotation = 0.0;
    // rust: self.refresh_boat_status(i);
}
    // rust: let touches = self.boat_bubble_columns(i);
    // rust: for _ in 0..2 {
    // rust: for &column in &touches {
    // rust: if column.surface {
    // rust: if self.boat_splash_roll(i) {
    // rust: self.boat_bubble_splash(i);
}
    // rust: } else if driven {
    // rust: self.boat_inside_bubble_column(i, column);
}
}
}
    // rust: self.boats[i].tick_bubble_wobble();
    // rust: if !driven {
    // rust: Self::tick_boat_paddles(
    // rust: &mut self.boats[i],
    // rust: &mut self.audio,
    // rust: &mut self.world.random,
    // rust: );
}
}
}

    // Whether this client moves `m`, the mount the player rides: as its
    // first passenger (`AbstractHorse.getControllingPassenger`), on its
    // saddle (`isLocalInstanceAuthoritative`).
drives :: proc(self: ^Self, m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.riding == Some(m.id)
    // rust: && client_moves(
    // rust: m,
    // rust: self.remote.as_ref().is_some_and(|r| r.first_passenger),
    // rust: self.steers_mount(m),
    // rust: )
}

steers_mount :: proc(self: ^Self, m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: super::mounts::steering_item(
    // rust: m.species(),
    // rust: self.held().map(|s| s.item.as_ref()),
    // rust: self.offhand.as_ref().map(|s| s.item.as_ref()),
    // rust: )
}

    // The mount this client moves, if the player rides one.
    // rust: pub(super) fn driven_mount(&self) -> Option<&Mob> {
    // rust: let id = self.riding?;
    // rust: self.mobs.iter().find(|m| m.id == id && self.drives(m))
}

    // `LocalPlayer.aiStep` and `LivingEntity.travelRidden` on the
    // controlling client: a released jump goes to the server
    // (`sendRidingJump`), and the mount takes the rider's input and moves
    // here (`tickRidden`, then `travel`).
drive_mount :: proc(self: ^Self, i: uint, keys: Keys, jump: f32) {
}
    // rust: if jump > 0.0
    // rust: && let Some(id) = self.remote.as_ref().map(|r| r.entity_id)
    // rust: {
    // rust: self.send(riding_jump(id, self.mount.jump_scale));
}
    // rust: let strafe = f32::from(u8::from(keys.left)) - f32::from(u8::from(keys.right));
    // rust: let forward = f32::from(u8::from(keys.forward)) - f32::from(u8::from(keys.backward));
    // rust: let steer = self.steers_mount(&self.mobs[i]);
    // rust: let m = &mut self.mobs[i];
    // rust: if jump > 0.0 && equine::is_equine(m.species()) {
            // LocalPlayer.aiStep also runs `onPlayerJump` here: the mount slides
            // on the rider's keys and rears while the server does the same.
    // rust: equine::on_player_jump(m);
}
        // playerJumpPendingScale waits for the ground.
    // rust: let pending = m.rider.map_or(0.0, |r| r.jump);
        // The rider's sprint state, not the key: Camel.getRiddenSpeed reads
        // `controller.isSprinting()`, which keeps the double-tapped sprint
        // after the key is let go (`shouldStopRunSprinting` decides the end).
    // rust: let sprinting = self.player.as_ref().is_some_and(|p| p.sprinting);
    // rust: m.rider = Some(equine::Rider {
    // rust: strafe,
    // rust: forward,
    // rust: yaw: self.yaw,
    // rust: pitch: self.pitch,
    // rust: jump: if jump > 0.0 { jump } else { pending },
    // rust: steer,
    // rust: sprint: sprinting,
    // rust: jumping: keys.jump,
    // rust: client: false,
    // rust: });
    // rust: let mut mob = self.mobs.remove(i);
    // rust: let mut random = self.world.random.clone();
    // rust: let mut events = Vec::new();
    // rust: {
    // rust: let world = self.mob_world_base(&[]);
    // rust: mob.tick(&world, &mut random, &mut events);
}
        // Only the server's packets take the mount away.
    // rust: mob.removed = false;
    // rust: self.world.random = random;
    // rust: self.mobs.insert(i, mob);
        // #4821: footstep, gallop, breathe, splash and landing sounds from mob.tick
    // rust: let _ = self.handle_mob_events(events);
}
}

// Whether a player's client moves `m`, the mount it rides
// (`isLocalInstanceAuthoritative`): a saddled horse, donkey, mule or camel
// it is the first passenger of (`AbstractHorse.getControllingPassenger`),
// or a harnessed adult Happy Ghast it is the first passenger of
// (`HappyGhast.getControllingPassenger`: wearing body armor, player on
// top, not on a still timeout — the rider steers it with `travelRidden`
// on their own client, and the mount goes to the server as `MoveVehicle`).
client_moves :: proc(m: ^Mob, first_passenger: bool, steer: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !first_passenger || !m.alive() {
    // rust: return false;
}
    // rust: if equine::moved_by_rider(m.species()) && m.extra.saddled {
    // rust: return !matches!(
    // rust: m.species(),
    // rust: horizon_client::mobs::Species::Pig | horizon_client::mobs::Species::Strider
    // rust: ) || steer;
}
    // rust: m.species() == horizon_client::mobs::Species::HappyGhast
    // rust: && happy_ghast::harnessed_adult(m)
    // rust: && !happy_ghast::on_still_timeout(m)
}

// `LocalPlayer.sendRidingJump`: START_RIDING_JUMP with
// `floor(getJumpRidingScale() * 100)`, as `onPlayerJump` gets it.
riding_jump :: proc(player: i32, scale: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: S::PlayerCommand(play::PlayerCommand {
    // rust: id: player,
    // rust: action: 3,
    // rust: data: (scale * 100.0).floor() as i32,
    // rust: })
}

// `ServerboundMoveVehiclePacket.fromEntity`: where the mount this client
// moves is, and how it is turned.
mount_move :: proc(m: ^Mob) -> S {
    // Ported from Horizon
    return {}
}
    // rust: S::MoveVehicle(play::MoveVehicleRequest {
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: yaw: m.yaw,
    // rust: pitch: m.head_pitch,
    // rust: on_ground: m.on_ground,
    // rust: })
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::mobs::MobTypes;

steering_mount_control_matches_vanilla :: proc() {
}
//         use super::super::{
    // rust: Audio, Options, Progress, Settings, execution_role::ExecutionRole, load_resources,
}
//         use horizon_client::{items::ItemStack, motion::PlayerMotion};
//         use horizon_protocol::connection::Pipe;
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let reference = std::env::var_os("HORIZON_MOUNT_CONTROL_REFERENCE").unwrap();
    // rust: let rows: Vec<serde_json::Value> =
    // rust: serde_json::from_slice(&std::fs::read(reference).unwrap()).unwrap();
    // rust: assert_eq!(rows.len(), 32, "missing vanilla control cases");
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!("no menu handoff"),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = ExecutionRole::Client;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: let (client, _server) = Pipe::pair();
    // rust: game.connect_local(client, "SteeringTest").unwrap();
    // rust: game.remote.as_mut().unwrap().joined = true;
    // rust: game.player = Some(PlayerMotion::new(game.motion, Vec3::new(0.5, 300.0, 0.5)).unwrap());
    // rust: let types = MobTypes::load(&root).unwrap();
    // rust: for row in rows {
    // rust: let kind = row["kind"].as_str().unwrap();
    // rust: let t = std::sync::Arc::new(types.types[&format!("minecraft:{kind}")].clone());
    // rust: let mut m = Mob::new(7, t, Vec3::new(0.5, 300.0, 0.5), 0.0);
    // rust: if row["saddled"].as_bool().unwrap() {
    // rust: m.set_saddle(Some(ItemStack::new("minecraft:saddle", 1)));
}
    // rust: let stick = if kind == "pig" {
    // rust: "minecraft:carrot_on_a_stick"
    // rust: } else {
    // rust: "minecraft:warped_fungus_on_a_stick"
}
    // rust: let wrong = if kind == "pig" {
    // rust: "minecraft:warped_fungus_on_a_stick"
    // rust: } else {
    // rust: "minecraft:carrot_on_a_stick"
}
    // rust: let hand = row["hand"].as_str().unwrap();
    // rust: game.inventory[game.selected] = match hand {
    // rust: "main" => Some(ItemStack::new(stick, 1)),
    // rust: "wrong" => Some(ItemStack::new(wrong, 1)),
    // rust: _ => None,
}
    // rust: game.offhand = (hand == "off").then(|| ItemStack::new(stick, 1));
    // rust: game.mobs.clear();
    // rust: game.mobs.push(m);
    // rust: game.riding = Some(7);
    // rust: game.remote.as_mut().unwrap().first_passenger = row["first"].as_bool().unwrap();
    // rust: let controlled = row["controlled"].as_bool().unwrap();
    // rust: assert_eq!(game.driven_mount().is_some(), controlled, "{row}");
    // rust: let packets = game.remote_vehicle_packets();
    // rust: assert_eq!(packets.len(), usize::from(controlled), "{row}");
    // rust: if controlled {
    // rust: assert!(matches!(packets[0], S::MoveVehicle(_)), "{row}");
    // rust: let before = game.mobs[0].position;
    // rust: assert!(game.remote_ride(Keys::default(), 0).unwrap());
    // rust: let m = &game.mobs[0];
    // rust: assert_eq!(
    // rust: f64::from(m.ai.zza),
    // rust: row["forward"].as_f64().unwrap(),
    // rust: "{row}"
    // rust: );
    // rust: assert!(m.position.z > before.z, "{row}: mount did not move forward");
    // rust: match &game.remote_vehicle_packets()[0] {
    // rust: S::MoveVehicle(p) => assert_eq!(
    // rust: p.position,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: "{row}"
    // rust: ),
    // rust: packet => panic!("wrong movement packet: {packet:?}"),
}
}
            // The server reads the same held-item requirement, then waits for
            // this controlling client's MoveVehicle rather than traveling twice.
    // rust: if row["first"].as_bool().unwrap() {
    // rust: assert!(game.tick_mount_riding(Keys::default()));
    // rust: game.mobs[0].rider.as_mut().unwrap().client = true;
    // rust: } else {
    // rust: game.mobs[0].rider = None;
}
    // rust: assert_eq!(
    // rust: equine::moved_by_client(&game.mobs[0]),
    // rust: !row["server_simulates"].as_bool().unwrap(),
    // rust: "{row}"
    // rust: );
    // rust: if controlled {
    // rust: let mut server_mount = game.mobs[0].clone();
    // rust: let before = server_mount.position;
    // rust: let mut random = game.world.random.clone();
    // rust: let mut events = Vec::new();
    // rust: server_mount.tick(&game.mob_world_base(&[]), &mut random, &mut events);
    // rust: assert_eq!(
    // rust: server_mount.position, before,
    // rust: "server traveled twice: {row}"
    // rust: );
}
}
}

    // A mob of the prepared resources' type `kind` (None without them).
mob :: proc(kind: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let types = MobTypes::load(&root).ok()?;
    // rust: let t = std::sync::Arc::new(types.types.get(kind)?.clone());
    // rust: Some(Mob::new(7, t, Vec3::new(1.5, 64.0, -2.5), 0.0))
}

    // #2920: on a vanilla server the rider's client moves a saddled horse,
    // donkey, mule or camel; a pig without its stick, a llama, an unsaddled horse or a second
    // passenger's ride is the server's.
the_rider_moves_a_saddled_horse_on_its_client :: proc() {
}
    // rust: for kind in ["horse", "donkey", "mule", "camel", "pig", "llama"] {
    // rust: let Some(mut m) = mob(&format!("minecraft:{kind}")) else {
    // rust: return;
}
    // rust: assert!(!client_moves(&m, true, false), "{kind} without a saddle");
    // rust: m.set_saddle(Some(horizon_client::items::ItemStack::new(
    // rust: "minecraft:saddle",
    // rust: 1,
    // rust: )));
    // rust: let horse = matches!(kind, "horse" | "donkey" | "mule" | "camel");
    // rust: assert_eq!(client_moves(&m, true, false), horse, "{kind}");
    // rust: assert!(
    // rust: !client_moves(&m, false, false),
    // rust: "{kind} behind another rider"
    // rust: );
}
}

    // #4107: on a vanilla server the rider's client moves a harnessed adult
    // Happy Ghast (`getControllingPassenger`); an unharnessed one, a baby
    // or a second passenger's ride is the server's.
the_rider_moves_a_harnessed_ghast_on_its_client :: proc() {
}
    // rust: let Some(mut m) = mob("minecraft:happy_ghast") else {
    // rust: return;
}
    // rust: assert!(!client_moves(&m, true, false), "ghast without a harness");
    // rust: m.extra.body = Some("minecraft:white_happy_ghast_harness".into());
    // rust: assert!(client_moves(&m, true, false), "harnessed adult");
    // rust: assert!(!client_moves(&m, false, false), "behind another rider");
    // rust: m.extra.age = -1;
    // rust: assert!(!client_moves(&m, true, false), "baby ghast");
}

    // #2920: the client reports where it moved the mount, and a released
    // jump with the bar's percentage (`sendRidingJump`).
the_rider_sends_its_mounts_moves_and_jumps :: proc() {
}
    // rust: let Some(mut m) = mob("minecraft:horse") else {
    // rust: return;
}
    // rust: (m.yaw, m.head_pitch, m.on_ground) = (90.0, 10.0, true);
    // rust: match mount_move(&m) {
    // rust: S::MoveVehicle(p) => {
    // rust: assert_eq!(p.position, [1.5, 64.0, -2.5]);
    // rust: assert_eq!((p.yaw, p.pitch, p.on_ground), (90.0, 10.0, true));
}
    // rust: other => panic!("{other:?}"),
}
    // rust: match riding_jump(42, 0.75) {
    // rust: S::PlayerCommand(p) => assert_eq!((p.id, p.action, p.data), (42, 3, 75)),
    // rust: other => panic!("{other:?}"),
}
}
}
