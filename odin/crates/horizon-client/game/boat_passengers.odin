//! Transpiled from Horizon Rust crate
package horizon_client_boat_passengers

import "core:fmt"
import "core:mem"
import "core:math"

// Boats and the entities around them: what a boat runs into
// (`AbstractBoat.canVehicleCollide`), the pushes between a boat and what
// touches it (`AbstractBoat.push`, `LivingEntity.pushEntities`), the mobs
// it picks up (the end of `AbstractBoat.tick`), where they sit
// (`positionRider`, `clampRotation`) and how they get out.
// Saving them under the boat's `Passengers` lives in `persist.rs`.
// use super::{Game, boats::Boat, lan_mobs::guest_bounds};
// use horizon_client::{
    // rust: camera::wrap_degrees,
    // rust: mobs::{BoxReach, Mob, Species, Who, drops::is_animal, equine, riders},
    // rust: scoreboard::pushable_by,
}
// use horizon_core::geometry::{Aabb, Vec3};

// `Entity.boardingCooldown` once a mob leaves its boat.
    // rust: pub(super) const BOARDING_COOLDOWN: i32 = 60;
// `Player.DEFAULT_VEHICLE_ATTACHMENT`: how far below the seat a player's
// feet are.
PLAYER_RIDING_OFFSET :: 0.6

// `Entity.canRide` for a mob species: `Warden` and `WitherBoss` override it
// to return false, so no vehicle ever takes them aboard.
    // rust: pub(super) fn species_can_ride(species: Species) -> bool {
    // rust: !matches!(species, Species::Warden | Species::Wither)
}

// `Entity.isVehicle`: a player or a mob rides it.
carries :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.rider.is_some() || m.extra.rider.is_some()
}
// `isPushable`, as `pushableBy` and `canVehicleCollide` ask it:
// `Mob::pushable` plus the shulkers it leaves out (they take no push, but
// count), less a ridden horse (`AbstractHorse.isPushable`).
pushable :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.removed
    // rust: && (m.pushable() || m.species() == Species::Shulker && m.alive())
    // rust: && !(equine::is_equine(m.species()) && carries(m))
}
// Whether `Entity.push` moves the mob: it is pushable and carries no one.
moved_by_push :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.removed && m.pushable() && !carries(m)
}
// `Entity.push(Entity)`: the push `other` gets from `this` (which takes the
// opposite one), or None when they stand on nearly the same spot.
    // rust: pub(super) fn push_impulse(this: Vec3, other: Vec3) -> Option<Vec3> {
    // rust: let (mut xa, mut za) = (other.x - this.x, other.z - this.z);
    // rust: let mut dd = xa.abs().max(za.abs());
    // rust: if dd < f64::from(0.01_f32) {
    // rust: return None;
}
    // rust: dd = dd.sqrt();
    // rust: xa /= dd;
    // rust: za /= dd;
    // rust: let pow = (1.0 / dd).min(1.0);
    // rust: let k = f64::from(0.05_f32);
    // rust: Some(Vec3::new(xa * pow * k, 0.0, za * pow * k))
}
// `AbstractBoat.push`: another boat is pushed while it is lower than this
// boat's top, anything else while its feet are no higher than the boat's.
    // rust: pub(super) fn boat_pushes(boat: Aabb, other: Aabb, other_is_boat: bool) -> bool {
    // rust: if other_is_boat {
    // rust: other.min_position().y < boat.max_position().y
    // rust: } else {
    // rust: other.min_position().y <= boat.min_position().y
}
}

    // rust: impl Game<'_> {
    // The players in boat `id`: the window's player (or the server player
    // acting as it) and the server's other players.
    // Starts or ends a stretch of vehicle ticks (`tick_boats`, `tick_carts`): while one runs,
    // a vehicle's box query tests the mobs' positions against their [`BoxReach`] first.
    // Nothing a vehicle does resizes a mob, and a mob joining or leaving works it out again.
    // rust: pub(super) fn vehicles_ticking(&self, on: bool) {
    // rust: self.vehicle_mob_reach
    // rust: .set(on.then(|| (self.mobs.len(), BoxReach::of(&self.mobs))));
}
    // The mobs' [`BoxReach`] while vehicles tick, none otherwise.
    // rust: pub(super) fn vehicle_mob_reach(&self) -> Option<BoxReach> {
    // rust: let (count, reach) = self.vehicle_mob_reach.get()?;
    // rust: if count == self.mobs.len() {
    // rust: return Some(reach);
}
    // rust: let reach = BoxReach::of(&self.mobs);
    // rust: self.vehicle_mob_reach.set(Some((self.mobs.len(), reach)));
    // rust: Some(reach)
}
    // rust: pub(super) fn boat_players(&self, id: u32) -> usize {
    // rust: let guests = self.lan.as_ref().map_or(0, |h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| Some(g.conn) != self.lan_acting && g.vehicle == Some(id))
    // rust: .count()
    // rust: });
    // rust: usize::from(self.riding == Some(id)) + guests
}
    // The mobs in boat `id`, in their seat order after the players
    // (`Entity.addPassenger` puts a player first).
    // rust: pub(super) fn boat_mobs(&self, id: u32) -> Vec<usize> {
    // rust: (0..self.mobs.len())
    // rust: .filter(|&j| {
    // rust: let m = &self.mobs[j];
    // rust: m.extra.mount == Some(id) && !m.removed && m.alive()
    // rust: })
    // rust: .collect()
}
    // `getPassengers().size()` of boat `id`.
    // rust: pub(super) fn boat_passengers(&self, id: u32) -> usize {
    // rust: self.boat_players(id) + self.boat_mobs(id).len()
}
    // `AbstractBoat.canAddPassenger`: a seat is free and the boat is not
    // under water.
    // rust: pub(super) fn boat_has_room(&self, i: usize) -> bool {
    // rust: let b = &self.boats[i];
    // rust: self.boat_passengers(b.id) < b.max_passengers() && !b.under_water()
}
    // Where the player in boat `i` sits: in the middle alone, in front of a
    // mob.
    // rust: pub(super) fn player_boat_seat(&self, i: usize) -> Vec3 {
    // rust: let b = &self.boats[i];
    // rust: let count = self.boat_players(b.id).max(1) + self.boat_mobs(b.id).len();
    // rust: b.seat(0, count, false, PLAYER_RIDING_OFFSET, false)
}
    // `getRootVehicle` of mob `j`: the mob or boat at the bottom of what it
    // rides, None when it rides nothing.
mob_root_vehicle :: proc(self: ^Self, mut j: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut root = None;
    // rust: for _ in 0..8 {
    // rust: let Some(v) = self.mobs[j].extra.mount else {
    // rust: break;
}
    // rust: root = Some(v);
    // rust: match self.mobs.iter().position(|m| m.id == v) {
    // rust: Some(k) => j = k,
    // rust: None => break,
}
}
    // rust: root
}
    // The players outside boat `id` that push and block it (living, not
    // spectators), with the window player's team.
players_outside :: proc(self: ^Self, id: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: if let Some(p) = self.player.as_ref()
    // rust: && self.riding != Some(id)
    // rust: && !self.spectator()
    // rust: && !p.health.dead_or_dying()
    // rust: {
    // rust: out.push((p.bounds(), true));
}
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: for g in host.hub.guests.iter().filter(|g| {
    // rust: Some(g.conn) != self.lan_acting
    // rust: && host.hub.here(g)
    // rust: && g.loaded
    // rust: && !g.dead
    // rust: && !g.spectator()
    // rust: && g.vehicle != Some(id)
    // rust: }) {
    // rust: out.push((guest_bounds(g), false));
}
}
    // rust: out
}
    // `getEntityCollisions` of boat `id` within `area`, with
    // `AbstractBoat.canVehicleCollide`: the other boats, minecarts,
    // shulkers and pushable mobs and players, but not its own passengers.
    // rust: pub(super) fn boat_obstacles(&self, id: u32, area: Aabb) -> Vec<Aabb> {
    // rust: let reach = self.vehicle_mob_reach();
    // rust: let mut out: Vec<Aabb> = (0..self.mobs.len())
    // rust: .filter(|&j| {
    // rust: let m = &self.mobs[j];
                // The box first: it turns away nearly every mob of the level.
    // rust: reach.is_none_or(|r| r.may_meet(m, area))
    // rust: && m.bounds().intersects(area)
    // rust: && pushable(m)
    // rust: && (m.extra.mount.is_none() || self.mob_root_vehicle(j) != Some(id))
    // rust: })
    // rust: .map(|j| self.mobs[j].bounds())
    // rust: .collect();
    // rust: out.extend(
    // rust: self.boats
    // rust: .iter()
    // rust: .filter(|b| b.id != id)
    // rust: .map(Boat::bounds)
    // rust: .chain(self.carts.iter().map(|c| c.bounds()))
    // rust: .chain(self.players_outside(id).into_iter().map(|(bb, _)| bb))
    // rust: .filter(|bb| bb.intersects(area)),
    // rust: );
    // rust: out
}
    // What boat `b` may run into this tick.
    // rust: pub(super) fn boat_move_obstacles(&self, b: &Boat) -> Vec<Aabb> {
    // rust: let reach = b.velocity.length() + 1.0;
    // rust: self.boat_obstacles(b.id, b.bounds().inflate(Vec3::new(reach, reach, reach)))
}
    // `noEntityCollision(boat, box)` for a new boat (`BoatItem.use`).
    // rust: pub(super) fn boat_entity_collision(&self, bb: Aabb) -> bool {
        // EntityGetter.getEntityCollisions: the box grown by 1e-7.
    // rust: let area = bb.inflate(Vec3::new(1.0e-7, 1.0e-7, 1.0e-7));
    // rust: !self.boat_obstacles(u32::MAX, area).is_empty()
}

    // The end of `AbstractBoat.tick` on the server for boat `i`: each
    // entity it touches gets in (a mob, while no player steers) or is
    // pushed apart from it, and `LivingEntity.pushEntities` of each mob and
    // player touching it pushes the two apart once more. Only the window's
    // own player is moved here: a server's players are pushed by their
    // clients, which tick the boats near them (`remote_pushes`).
    // rust: pub(super) fn boat_contacts(&mut self, i: usize) {
    // rust: let (id, bb, max) = {
    // rust: let b = &self.boats[i];
    // rust: (b.id, b.bounds(), b.max_passengers())
}
    // rust: let area = bb.inflate(Vec3::new(
    // rust: f64::from(0.2_f32),
    // rust: f64::from(-0.01_f32),
    // rust: f64::from(0.2_f32),
    // rust: ));
    // rust: let mut count = self.boat_passengers(id);
        // getControllingPassenger is a player: one rides it (players sit first).
    // rust: let pick_up = self.boat_players(id) == 0;
        // canAddPassenger, which startRiding asks after the checks below.
    // rust: let room = !self.boats[i].under_water();
        // The box first: it turns away nearly every mob of the level, and the
        // teams are only worked out when something touches the boat.
    // rust: let reach = self.vehicle_mob_reach();
    // rust: let sweep = area.union_bounds(bb);
    // rust: let near: Vec<usize> = (0..self.mobs.len())
    // rust: .filter(|&j| {
    // rust: if reach.is_some_and(|r| !r.may_meet(&self.mobs[j], sweep)) {
    // rust: return false;
}
    // rust: let mb = self.mobs[j].bounds();
    // rust: mb.intersects(area) || mb.intersects(bb)
    // rust: })
    // rust: .collect();
    // rust: let outside = self.players_outside(id);
    // rust: let touching = !near.is_empty()
    // rust: || outside
    // rust: .iter()
    // rust: .any(|(pb, _)| pb.intersects(area) || pb.intersects(bb));
        // (mob, touched by the boat's sweep, its own pushEntities reaches the boat)
    // rust: let teams = if touching {
    // rust: self.mob_teams()
    // rust: } else {
    // rust: Default::default()
}
    // rust: let mobs: Vec<(u32, bool, bool)> = near
    // rust: .into_iter()
    // rust: .filter_map(|j| {
    // rust: let m = &self.mobs[j];
    // rust: if !pushable(m) || m.extra.mount.is_some() && self.mob_root_vehicle(j) == Some(id) {
    // rust: return None;
}
    // rust: let mb = m.bounds();
    // rust: let team = teams.of(Who::Mob(m.id));
    // rust: let touched = mb.intersects(area) && pushable_by(None, team, true);
                // Bats push nothing (Bat.pushEntities).
    // rust: let pushes = m.species() != Species::Bat
    // rust: && mb.intersects(bb)
    // rust: && pushable_by(team, None, true);
    // rust: (touched || pushes).then_some((m.id, touched, pushes))
    // rust: })
    // rust: .collect();
    // rust: let player_team = teams.of(Who::Player);
    // rust: let players: Vec<(Aabb, bool, bool, bool)> = outside
    // rust: .into_iter()
    // rust: .map(|(pb, own)| {
    // rust: let team = if own { player_team } else { None };
    // rust: (
    // rust: pb,
    // rust: own,
    // rust: pb.intersects(area) && pushable_by(None, team, true),
    // rust: pb.intersects(bb) && pushable_by(team, None, true),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: drop(teams);
    // rust: for (mob, touched, pushes) in mobs {
            // By id: a mod's mount hook may have removed mobs since the list
            // was made, which moves the others' indices.
    // rust: let Some(j) = self.mobs.iter().position(|m| m.id == mob) else {
    // rust: continue;
}
    // rust: if touched {
    // rust: let m = &self.mobs[j];
    // rust: let boards = pick_up
    // rust: && count < max
    // rust: && m.extra.mount.is_none()
    // rust: && m.width() < super::boats::WIDTH as f32
    // rust: && !self
    // rust: .res
    // rust: .mob_data()
    // rust: .entity_has("minecraft:cannot_be_pushed_onto_boats", &m.kind.id);
    // rust: if boards {
                    // startRiding fails quietly (no push) while the mob's
                    // boarding cooldown runs (Entity.canRide) or the boat
                    // is under water, or when a mod cancels it
                    // (EntityMountEvent).
    // rust: let ready = m.extra.boarding_cooldown <= 0 && species_can_ride(m.species());
    // rust: if room
    // rust: && ready
    // rust: && self.native_mob_may_ride(mob, id, true)
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob)
    // rust: {
    // rust: m.extra.mount = Some(id);
    // rust: m.extra.passenger = true;
    // rust: m.ai.nav.stop();
    // rust: count += 1;
                        // Mob.startRiding drops its lead.
    // rust: self.break_leash(mob, true, false);
    // rust: self.note_started_riding(id);
}
    // rust: continue;
}
    // rust: self.boat_push_mob(i, j, count);
}
    // rust: if pushes {
    // rust: self.boat_push_mob(i, j, count);
}
}
    // rust: for (pb, own, touched, pushes) in players {
    // rust: let Some(v) = push_impulse(self.boats[i].position, pb.center())
    // rust: .filter(|_| boat_pushes(bb, pb, false))
    // rust: else {
    // rust: continue;
}
    // rust: for _ in 0..usize::from(touched) + usize::from(pushes) {
    // rust: if count == 0 {
    // rust: let b = &mut self.boats[i];
    // rust: b.velocity = b.velocity.subtract(v);
}
    // rust: if own && let Some(p) = self.player.as_mut() {
    // rust: p.velocity = p.velocity.add_vector(v);
}
}
}
    // rust: for k in 0..self.boats.len() {
    // rust: let ob = self.boats[k].bounds();
    // rust: if k == i || !ob.intersects(area) || !boat_pushes(bb, ob, true) {
    // rust: continue;
}
    // rust: let Some(v) = push_impulse(self.boats[i].position, self.boats[k].position) else {
    // rust: continue;
}
    // rust: if count == 0 {
    // rust: self.boats[i].velocity = self.boats[i].velocity.subtract(v);
}
    // rust: if self.boat_passengers(self.boats[k].id) == 0 {
    // rust: self.boats[k].velocity = self.boats[k].velocity.add_vector(v);
}
}
    // rust: let guest_carts = self.guest_vehicles();
    // rust: for c in 0..self.carts.len() {
    // rust: let cb = self.carts[c].bounds();
    // rust: if !cb.intersects(area) || !boat_pushes(bb, cb, false) {
    // rust: continue;
}
    // rust: let Some(v) = push_impulse(self.boats[i].position, self.carts[c].position) else {
    // rust: continue;
}
    // rust: if count == 0 {
    // rust: self.boats[i].velocity = self.boats[i].velocity.subtract(v);
}
    // rust: let cid = self.carts[c].id;
    // rust: let ridden = self.riding == Some(cid)
    // rust: || guest_carts.contains(&cid)
    // rust: || self.mobs.iter().any(|m| m.extra.mount == Some(cid));
    // rust: if !ridden {
    // rust: self.carts[c].velocity = self.carts[c].velocity.add_vector(v);
}
}
}
    // `AbstractBoat.push(mob)` from boat `i`, which has `count` passengers.
boat_push_mob :: proc(self: ^Self, i: uint, j: uint, count: uint) {
}
    // rust: let (b, m) = (&self.boats[i], &self.mobs[j]);
    // rust: if !boat_pushes(b.bounds(), m.bounds(), false) {
    // rust: return;
}
    // rust: let Some(v) = push_impulse(b.position, m.position) else {
    // rust: return;
}
    // rust: if count == 0 {
    // rust: let b = &mut self.boats[i];
    // rust: b.velocity = b.velocity.subtract(v);
}
    // rust: let m = &mut self.mobs[j];
    // rust: if moved_by_push(m) {
    // rust: m.velocity = m.velocity.add_vector(v);
    // rust: m.needs_sync = true;
}
}

    // `positionRider` and `clampRotation` for the mobs in boats: each sits
    // in its seat facing the way the boat does, an animal in a full boat
    // sideways, its head kept within its reach of its body.
    // rust: pub(super) fn seat_boat_mobs(&mut self, riding: &super::passengers::Riders) {
    // rust: for i in 0..self.boats.len() {
    // rust: let id = self.boats[i].id;
            // `boat_mobs`, from the riders found in one pass.
    // rust: let mobs: Vec<usize> = riding
    // rust: .get(&id)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .copied()
    // rust: .filter(|&j| !self.mobs[j].removed && self.mobs[j].alive())
    // rust: .collect();
    // rust: if mobs.is_empty() {
    // rust: continue;
}
    // rust: let players = self.boat_players(id);
    // rust: let count = players + mobs.len();
    // rust: let b = &self.boats[i];
    // rust: let full = count == b.max_passengers();
    // rust: let delta = b.delta_rotation;
    // rust: let seats: Vec<_> = mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(n, &j)| {
    // rust: let m = &self.mobs[j];
    // rust: let animal = is_animal(m.species());
                    // Another player's too, on a server's client.
                    // AbstractBoat's box is 1.375 wide.
    // rust: let offset = riders::vehicle_attachment(m, 1.375);
    // rust: let index = players + n;
                    // calculatePassengerBodyYRot.
    // rust: let turn = match (animal && full, m.id.is_multiple_of(2)) {
    // rust: (false, _) => 0.0,
    // rust: (true, true) => 90.0,
    // rust: (true, false) => 270.0,
}
    // rust: let turns = !self
    // rust: .res
    // rust: .mob_data()
    // rust: .entity_has("minecraft:can_turn_in_boats", &m.kind.id);
    // rust: (
    // rust: j,
    // rust: b.seat(index, count, animal, offset, false),
    // rust: b.seat(index, count, animal, offset, true),
    // rust: turns.then_some((b.yaw + turn, b.previous_yaw + turn)),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: for (j, at, previous, facing) in seats {
    // rust: let m = &mut self.mobs[j];
    // rust: m.position = at;
    // rust: m.previous = previous;
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.fall_distance = 0.0;
    // rust: m.on_ground = false;
    // rust: m.extra.passenger = true;
    // rust: m.ai.nav.stop();
    // rust: let Some((body, previous_body)) = facing else {
    // rust: continue;
}
    // rust: m.head_yaw += delta;
    // rust: m.body_yaw = body;
    // rust: m.previous_body_yaw = previous_body;
    // rust: m.yaw = body;
    // rust: m.previous_yaw = previous_body;
                // Mob.clampHeadRotationToBody.
    // rust: let limit = m.kind.max_head_y_rot;
    // rust: let d = wrap_degrees(body - m.head_yaw);
    // rust: m.head_yaw += d - d.clamp(-limit, limit);
}
}
}
    // `ejectPassengers` for the mobs in boat `i`: each gets out where
    // `getDismountLocationForPassenger` puts it (beside the boat when it
    // broke: `LivingEntity.dismountVehicle`) and can't board for a while.
    // rust: pub(super) fn eject_boat_mobs(&mut self, i: usize, broken: bool) {
    // rust: let b = &self.boats[i];
    // rust: let (id, y) = (b.id, b.position.y);
    // rust: for j in self.boat_mobs(id) {
    // rust: let m = &self.mobs[j];
    // rust: let at = if broken {
    // rust: Vec3::new(m.position.x, m.position.y.max(y), m.position.z)
    // rust: } else {
    // rust: self.boat_dismount_target(i, f64::from(m.width()), m.yaw)
}
    // rust: let m = &mut self.mobs[j];
    // rust: m.extra.mount = None;
    // rust: m.extra.passenger = false;
    // rust: m.extra.boarding_cooldown = BOARDING_COOLDOWN;
    // rust: m.position = at;
    // rust: m.previous = at;
}
}
}

    // rust: mod tests {
//     use super::*;

push_is_capped_and_scaled :: proc() {
}
        // One block apart on x: the full 0.05 along x.
    // rust: let v = push_impulse(Vec3::ZERO, Vec3::new(1.0, 0.0, 0.0)).unwrap();
    // rust: assert!((v.x - f64::from(0.05_f32)).abs() < 1e-12 && v.z == 0.0);
        // Almost on the same spot: no push.
    // rust: assert!(push_impulse(Vec3::ZERO, Vec3::new(0.005, 0.0, 0.0)).is_none());
}

warden_and_wither_never_board :: proc() {
}
    // rust: assert!(!species_can_ride(Species::Warden));
    // rust: assert!(!species_can_ride(Species::Wither));
    // rust: assert!(species_can_ride(Species::Cow));
}

boats_push_by_height :: proc() {
}
    // rust: let boat = Aabb::new(Vec3::new(0.0, 64.0, 0.0), Vec3::new(1.0, 64.5625, 1.0));
    // rust: let at = |y: f64| Aabb::new(Vec3::new(0.0, y, 0.0), Vec3::new(1.0, y + 1.0, 1.0));
    // rust: assert!(boat_pushes(boat, at(64.0), false));
    // rust: assert!(!boat_pushes(boat, at(64.1), false));
    // rust: assert!(boat_pushes(boat, at(64.5), true));
    // rust: assert!(!boat_pushes(boat, at(64.5625), true));
}
}
