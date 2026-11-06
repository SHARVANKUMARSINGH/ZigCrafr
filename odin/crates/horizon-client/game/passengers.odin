//! Transpiled from Horizon Rust crate
package horizon_client_passengers

import "core:fmt"
import "core:mem"
import "core:math"

// Mobs riding mobs: boarding and dismounting, keeping riders on their
// vehicles, the jockeys that spawn mounted (chicken jockeys, spider
// jockeys, strider jockeys, zombie horsemen) and the skeleton horse trap.
// Saving riders under `Passengers` lives in `persist.rs`.
// use super::Game;
// use horizon_client::mobs::{Species, riders};
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use std::collections::HashMap;

// The mobs riding each vehicle, by the vehicle's id: their indices, in the mobs' order.
    // rust: pub(super) type Riders = HashMap<u32, Vec<usize>>;

// `Zombie.finalizeSpawn`: a baby zombie takes a chicken one time in twenty,
// and another one time in twenty of the rest.
CHICKEN_JOCKEY_ODDS :: 0.05
// The seconds a skeleton horse trap waits for a player: 15 minutes.
TRAP_LIFETIME :: 18000
// `SkeletonTrapGoal`: a player this close springs the trap.
TRAP_RANGE :: 10.0
// Ticks of invulnerability the trap's riders and horses start with.
TRAP_INVULNERABLE :: 60

zombie_kind :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Zombie | Species::Husk | Species::Drowned | Species::ZombieVillager
    // rust: )
}

// Which `finalizeSpawn` mounts a mob may roll for its spawn reason.
MountRolls :: struct {
    zombie_horse_rider: bool,
    camel_husk: bool,
    nautilus: bool,
}

// `ZombieHorse.finalizeSpawn` (NATURAL only), `Husk.finalizeSpawn`
// (`triedToSpawnCamelHusk = reason != NATURAL`) and `Drowned.finalizeSpawn`
// (never a baby; vanilla also allows STRUCTURE, which comes from worldgen and
// never reaches `spawn_jockeys`, so only `natural` is modelled here).
mount_rolls :: proc(species: Species, baby: bool, natural: bool) -> M {
    // Ported from Horizon
    return {}
}
    // rust: MountRolls {
    // rust: zombie_horse_rider: natural && species == Species::ZombieHorse,
    // rust: camel_husk: natural && species == Species::Husk,
    // rust: nautilus: natural && species == Species::Drowned && !baby,
}
}

    // rust: impl Game<'_> {
    // `Entity.startRiding` for two mobs.
    // rust: pub(super) fn mount_mob(&mut self, rider: u32, vehicle: u32) {
    // rust: self.try_mount_mob(rider, vehicle);
}
    // `Entity.startRiding` for two mobs: false when a mod canceled it.
    // rust: pub(super) fn try_mount_mob(&mut self, rider: u32, vehicle: u32) -> bool {
    // rust: if !self.native_mob_may_ride(rider, vehicle, true) {
    // rust: return false;
}
    // rust: riders::link(&mut self.mobs, rider, vehicle);
        // sendEventAndTriggers: the server players already on the vehicle.
    // rust: self.note_started_riding(vehicle);
    // rust: true
}
    // Riders sit on their vehicles (`Entity.positionRider`), mobs or boats,
    // and let go when the vehicle dies or is gone.
    // rust: pub(super) fn sync_riders(&mut self) {
        // Entity.baseTick.
    // rust: for m in &mut self.mobs {
    // rust: if m.extra.boarding_cooldown > 0 {
    // rust: m.extra.boarding_cooldown -= 1;
}
}
    // rust: let boats: std::collections::HashSet<u32> = self.boats.iter().map(|b| b.id).collect();
    // rust: let carts: std::collections::HashSet<u32> = self.carts.iter().map(|c| c.id).collect();
    // rust: let tnts: std::collections::HashSet<u32> = self
    // rust: .tnts
    // rust: .iter()
    // rust: .map(|t| t.id)
    // rust: .filter(|&id| id != 0)
    // rust: .collect();
    // rust: let index: HashMap<u32, usize> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, m)| (m.id, i))
    // rust: .collect();
    // rust: let mut riding: HashMap<u32, u32> = HashMap::new();
        // If the vehicle already has a first rider that is still validly riding it, preserve it.
    // rust: for m in &self.mobs {
    // rust: if let Some(r) = m.extra.rider
    // rust: && let Some(&j) = index.get(&r)
    // rust: && self.mobs[j].extra.mount == Some(m.id)
    // rust: && self.mobs[j].alive()
    // rust: && !self.mobs[j].removed
    // rust: {
    // rust: riding.insert(m.id, r);
}
}
    // rust: for i in 0..self.mobs.len() {
    // rust: let Some(v) = self.mobs[i].extra.mount else {
    // rust: continue;
}
            // Not a text display: a server's display mounts come through
            // `remote_set_passengers`, which seats them in `position_riders`.
    // rust: let valid = self.mobs[i].alive()
    // rust: && !self.mobs[i].removed
    // rust: && (boats.contains(&v)
    // rust: || carts.contains(&v)
    // rust: || tnts.contains(&v)
    // rust: || index
    // rust: .get(&v)
    // rust: .is_some_and(|&j| self.mobs[j].alive() && !self.mobs[j].removed));
    // rust: if valid {
    // rust: riding.entry(v).or_insert(self.mobs[i].id);
    // rust: } else {
    // rust: let m = &mut self.mobs[i];
    // rust: m.extra.mount = None;
    // rust: m.extra.passenger = false;
}
}
    // rust: for m in &mut self.mobs {
    // rust: m.extra.rider = riding.get(&m.id).copied();
}
    // rust: self.position_riders();
}
    // `Entity.positionRider` for every mob passenger: in its boat, then on
    // its mob. A server's client places them itself too, as the server sends
    // no passenger's position.
    // rust: pub(super) fn position_riders(&mut self) {
        // Every vehicle's riders in one pass over the mobs, not one pass per
        // boat, minecart and primed TNT. Seating moves the riders but changes
        // no one's vehicle, so it holds for all three.
    // rust: let mut riders = Riders::default();
    // rust: for (j, m) in self.mobs.iter().enumerate() {
    // rust: if let Some(v) = m.extra.mount {
    // rust: riders.entry(v).or_default().push(j);
}
}
    // rust: self.seat_boat_mobs(&riders);
    // rust: self.seat_cart_mobs(&riders);
    // rust: self.seat_tnt_mobs(&riders);
    // rust: let index: HashMap<u32, usize> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, m)| (m.id, i))
    // rust: .collect();
        // Riders of riders settle over a few passes.
    // rust: for pass in 0..3 {
    // rust: for i in 0..self.mobs.len() {
    // rust: let Some(v) = self.mobs[i].extra.mount else {
    // rust: continue;
}
    // rust: let Some(&j) = index.get(&v) else {
                    // The display doesn't move between passes.
    // rust: if pass > 0 {
    // rust: continue;
}
                    // A mob on a text display: NPC plugins seat their sitting
                    // NPCs on one. The server's position for a passenger
                    // gives way to its seat, as `rideTick` places it.
    // rust: let Some((at, before)) = self.text_displays.get(&(v as i32)).map(|d| d.seat())
    // rust: else {
    // rust: continue;
}
    // rust: let m = &mut self.mobs[i];
                    // EntityType.TEXT_DISPLAY's box is zero wide.
    // rust: let offset = riders::vehicle_attachment(m, 0.0);
    // rust: m.position = Vec3::new(at.x, at.y - offset, at.z);
    // rust: m.previous = Vec3::new(before.x, before.y - offset, before.z);
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.fall_distance = 0.0;
    // rust: m.on_ground = false;
    // rust: m.extra.passenger = true;
    // rust: m.ai.nav.stop();
    // rust: continue;
}
    // rust: let vehicle = &self.mobs[j];
    // rust: let mut attach = riders::passenger_attachment(vehicle);
    // rust: if horizon_client::mobs::camel::is_camel(vehicle.species()) {
                    // Camel.getPassengerAttachmentPoint: the seat follows the
                    // rider's place in `getPassengers` (load order).
    // rust: let mut aboard: Vec<usize> = (0..self.mobs.len())
    // rust: .filter(|&k| self.mobs[k].extra.mount == Some(v))
    // rust: .collect();
    // rust: let player_aboard = vehicle.rider.is_some() || self.riding == Some(v);
    // rust: let (seat, count) = if player_aboard {
    // rust: let mob_seat = aboard.iter().position(|&k| k == i).unwrap_or(0);
    // rust: (mob_seat + 1, aboard.len() + 1)
    // rust: } else {
    // rust: if let Some(driver) = vehicle.extra.rider
    // rust: && let Some(pos) =
    // rust: aboard.iter().position(|&k| self.mobs[k].id == driver)
    // rust: && pos != 0
    // rust: {
    // rust: let driver_idx = aboard.remove(pos);
    // rust: aboard.insert(0, driver_idx);
}
    // rust: let seat = aboard.iter().position(|&k| k == i).unwrap_or(0);
    // rust: (seat, aboard.len())
}
    // rust: let animal = horizon_client::mobs::drops::is_animal(self.mobs[i].species());
    // rust: attach = horizon_client::mobs::camel::passenger_attachment_at(
    // rust: vehicle, seat, count, animal,
    // rust: );
}
    // rust: if vehicle.species() == horizon_client::mobs::Species::HappyGhast {
                    // EntityType.HAPPY_GHAST: four seats, by the rider's place
                    // in `getPassengers`.
    // rust: let seat = self.mobs[..i]
    // rust: .iter()
    // rust: .filter(|r| r.extra.mount == Some(v))
    // rust: .count();
    // rust: attach = riders::happy_ghast_attachment(seat);
}
    // rust: let (pos, prev) = (vehicle.position, vehicle.previous);
    // rust: let (yaw, prev_yaw) = (vehicle.yaw, vehicle.previous_yaw);
    // rust: let (body, prev_body) = (vehicle.body_yaw, vehicle.previous_body_yaw);
    // rust: let vehicle_width = vehicle.width();
    // rust: let m = &mut self.mobs[i];
    // rust: let offset = riders::vehicle_attachment(m, vehicle_width);
    // rust: m.position = riders::seat(attach, offset, pos, yaw);
    // rust: m.previous = riders::seat(attach, offset, prev, prev_yaw);
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.fall_distance = 0.0;
    // rust: m.on_ground = false;
    // rust: m.body_yaw = body;
    // rust: m.previous_body_yaw = prev_body;
    // rust: m.extra.passenger = true;
                // A rider never walks off on its own.
    // rust: m.ai.nav.stop();
}
}
        // Displays and interaction boxes riding anything the client tracks,
        // as NPC plugins put a name over a head or a model's bones on a
        // pivot: `Entity.rideTick` -> `positionRider`, the vehicle's passenger
        // attachment (the top of its box in its pose and scale) less the rider's own,
        // which is 0 for both (Display and Interaction are 0 by 0). On the
        // local player, the top of its box in its pose and scale
        // (`Avatar.POSES`).
    // rust: let me = self.remote.as_ref().map(|r| r.entity_id as u32);
    // rust: let own_seat = self.player.as_ref().map(|p| {
    // rust: p.position
    // rust: .add_vector(Vec3::new(0.0, f64::from(p.dimensions.height), 0.0))
    // rust: });
        // A rider of a rider settles over a few passes, as the mobs above.
    // rust: for _ in 0..3 {
    // rust: let mut vehicles: Vec<u32> = self
    // rust: .text_displays
    // rust: .values()
    // rust: .filter_map(|d| d.vehicle)
    // rust: .chain(self.interactions.values().filter_map(|i| i.vehicle))
    // rust: .collect();
    // rust: vehicles.sort_unstable();
    // rust: vehicles.dedup();
    // rust: let seats: HashMap<u32, glam::DVec3> = vehicles
    // rust: .into_iter()
    // rust: .filter_map(|v| {
    // rust: self.passenger_riding_position(v, me, own_seat, &index)
    // rust: .map(|at| (v, at))
    // rust: })
    // rust: .collect();
    // rust: for display in self.text_displays.values_mut() {
    // rust: if let Some(at) = display.vehicle.and_then(|v| seats.get(&v)) {
    // rust: display.ride(*at);
}
}
    // rust: for interaction in self.interactions.values_mut() {
    // rust: if let Some(at) = interaction.vehicle.and_then(|v| seats.get(&v)) {
    // rust: interaction.ride_to(*at);
}
}
}
        // Armor stands riding a mob (a server's name tag hologram): seated
        // like the displays above, so the name follows its vehicle instead of
        // staying where the stand spawned. The stand's own vehicle attachment
        // is the default 0, so its feet sit on the seat. The seat at the
        // start of the tick too (`commonTick` runs before `rideTick`), so the
        // stand is drawn between the two even while the level is frozen and
        // its vehicle is not. Those riding the local player are seated after
        // its move (`seat_own_stands`).
    // rust: for i in 0..self.armor_stands.len() {
    // rust: let Some(vehicle) = self.armor_stands[i].vehicle else {
    // rust: continue;
}
    // rust: let Some(&j) = index.get(&vehicle).filter(|_| Some(vehicle) != me) else {
    // rust: continue;
}
    // rust: let vehicle = &self.mobs[j];
    // rust: let attach = riders::passenger_attachment(vehicle);
    // rust: let at = riders::seat(attach, 0.0, vehicle.position, vehicle.yaw);
    // rust: let before = riders::seat(attach, 0.0, vehicle.previous, vehicle.previous_yaw);
    // rust: let stand = &mut self.armor_stands[i];
    // rust: stand.position = at;
    // rust: stand.previous = before;
    // rust: stand.velocity = Vec3::ZERO;
}
}

    // Armor stands riding the local player, on the top of its box. Vanilla
    // ticks the player (`tickNonPassenger`) before its passengers
    // (`tickPassenger` -> `positionRider`), so a rider's `xo` and `x` are the
    // seats before and after the same move: call this after the player's.
    // rust: pub(super) fn seat_own_stands(&mut self) {
    // rust: let (Some(me), Some(p)) = (
    // rust: self.remote.as_ref().map(|r| r.entity_id as u32),
    // rust: self.player.as_ref(),
    // rust: ) else {
    // rust: return;
}
    // rust: let up = Vec3::new(0.0, f64::from(p.dimensions.height), 0.0);
    // rust: let (at, before) = (
    // rust: p.position.add_vector(up),
    // rust: self.previous_position.add_vector(up),
    // rust: );
    // rust: for stand in self
    // rust: .armor_stands
    // rust: .iter_mut()
    // rust: .filter(|a| a.vehicle == Some(me))
    // rust: {
    // rust: stand.position = at;
    // rust: stand.previous = before;
    // rust: stand.velocity = Vec3::ZERO;
}
}

    // `Entity.getPassengerRidingPosition` of a vehicle: where the feet of a
    // passenger whose own vehicle attachment is 0 land.
    // rust: fn passenger_riding_position(
    // rust: &self,
    // rust: vehicle: u32,
    // rust: me: Option<u32>,
    // rust: own_seat: Option<Vec3>,
    // rust: index: &HashMap<u32, usize>,
    // rust: ) -> Option<glam::DVec3> {
    // rust: if Some(vehicle) == me {
    // rust: let at = own_seat?;
    // rust: return Some(glam::DVec3::new(at.x, at.y, at.z));
}
    // rust: if let Some(&j) = index.get(&vehicle) {
    // rust: let v = &self.mobs[j];
    // rust: let at = riders::seat(riders::passenger_attachment(v), 0.0, v.position, v.yaw);
    // rust: return Some(glam::DVec3::new(at.x, at.y, at.z));
}
    // rust: if let Some(d) = self.text_displays.get(&(vehicle as i32)) {
    // rust: return Some(d.position());
}
    // rust: if let Some(i) = self.interactions.get(&(vehicle as i32)) {
    // rust: let at = i.position;
    // rust: return Some(glam::DVec3::new(at.x, at.y, at.z));
}
    // rust: if let Some(b) = self.boats.iter().find(|b| b.id == vehicle) {
    // rust: let count = self.boat_players(vehicle).max(1) + self.boat_mobs(vehicle).len();
    // rust: let at = b.seat(0, count, false, 0.0, false);
    // rust: return Some(glam::DVec3::new(at.x, at.y, at.z));
}
    // rust: if let Some(c) = self.carts.iter().find(|c| c.id == vehicle) {
    // rust: let at = c
    // rust: .position
    // rust: .add_vector(Vec3::new(0.0, super::minecarts::SEAT, 0.0));
    // rust: return Some(glam::DVec3::new(at.x, at.y, at.z));
}
    // rust: if let Some(a) = self.armor_stands.iter().find(|a| a.id == vehicle) {
            // ArmorStand.getDefaultDimensions: a marker has no box to sit on.
    // rust: let height = if a.marker {
    // rust: 0.0
    // rust: } else if a.small {
    // rust: 0.9875
    // rust: } else {
    // rust: 1.975
}
    // rust: return Some(glam::DVec3::new(
    // rust: a.position.x,
    // rust: a.position.y + height,
    // rust: a.position.z,
    // rust: ));
}
        // Any other tracked entity sits on its feet; an area effect cloud is
        // 0.5 tall, and ModelEngine parks a model's pivot half a block below
        // its feet for exactly that.
    // rust: let (kind, position) = self.remote.as_ref()?.tracked(vehicle as i32)?;
    // rust: let lift = if kind == "minecraft:area_effect_cloud" {
    // rust: 0.5
    // rust: } else {
    // rust: 0.0
}
    // rust: Some(glam::DVec3::new(
    // rust: position[0],
    // rust: position[1] + lift,
    // rust: position[2],
    // rust: ))
}

    // `finalizeSpawn` jockeys of a naturally spawned mob: baby zombies on
    // chickens, skeletons on spiders, piglins and baby striders on striders,
    // zombies on zombie horses.
    // rust: pub(super) fn spawn_jockeys(&mut self, id: u32, natural: bool) {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let (species, baby) = (m.species(), m.is_baby());
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let mounts = mount_rolls(species, baby, natural);
    // rust: match species {
    // rust: s if zombie_kind(s) && baby => {
    // rust: if self.world.random.next_float() < CHICKEN_JOCKEY_ODDS {
    // rust: if let Some(chicken) = self.free_chicken_near(at) {
    // rust: self.make_chicken_jockey(chicken);
    // rust: self.mount_mob(id, chicken);
}
    // rust: } else if self.world.random.next_float() < CHICKEN_JOCKEY_ODDS
    // rust: && let Some(chicken) = self.spawn_mob("minecraft:chicken", at, false)
    // rust: {
    // rust: self.make_chicken_jockey(chicken);
    // rust: self.mount_mob(id, chicken);
}
}
            // Spider.finalizeSpawn: one in a hundred carries a skeleton.
    // rust: Species::Spider if self.world.random.next_int_bound(100).unwrap_or(1) == 0 => {
    // rust: if let Some(skeleton) = self.spawn_mob("minecraft:skeleton", at, false) {
    // rust: self.mount_mob(skeleton, id);
}
}
    // rust: Species::Strider if !baby => self.spawn_strider_jockey(id, at),
            // ZombieHorse.finalizeSpawn: a zombie with an iron spear. The rider
            // comes from EntityType.create, which makes no zombie in peaceful
            // (canSpawn), so a peaceful zombie horse spawns without one.
    // rust: Species::ZombieHorse
    // rust: if mounts.zombie_horse_rider
    // rust: && (self.ui.difficulty != 0
    // rust: || horizon_client::mobs::spawn_rules::allowed_in_peaceful(
    // rust: Species::Zombie,
    // rust: )) =>
    // rust: {
    // rust: if let Some(zombie) = self.spawn_mob("minecraft:zombie", at, false) {
    // rust: if let Some(z) = self.mobs.iter_mut().find(|m| m.id == zombie) {
    // rust: z.extra.set_main_hand(Some("minecraft:iron_spear".into()));
}
    // rust: self.mount_mob(zombie, id);
}
}
    // rust: _ => {}
}
        // After Zombie.finalizeSpawn's chickens: Husk and Drowned mounts.
    // rust: match species {
    // rust: Species::Husk if mounts.camel_husk => self.spawn_camel_husk_jockey(id, at),
    // rust: Species::Drowned if mounts.nautilus => self.spawn_zombie_nautilus_jockey(id, at),
    // rust: _ => {}
}
}
    // `Husk.finalizeSpawn`: where a camel husk fits, one natural husk in ten
    // takes an iron spear and rides one, with a parched in its second seat.
spawn_camel_husk_jockey :: proc(self: ^Self, id: u32, at: [f64; 3]) {
}
    // rust: let (bx, by, bz) = (at[0].floor(), at[1].floor(), at[2].floor());
    // rust: let room = {
    // rust: let w = self.mob_world_base(&[]);
    // rust: w.no_collision(horizon_core::geometry::Aabb::new(
    // rust: Vec3::new(bx + 0.5 - 0.85, by, bz + 0.5 - 0.85),
    // rust: Vec3::new(bx + 0.5 + 0.85, by + 2.375, bz + 0.5 + 0.85),
    // rust: ))
}
    // rust: if !room || self.world.random.next_float() >= 0.1 {
    // rust: return;
}
    // rust: if let Some(h) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: h.extra.set_main_hand(Some("minecraft:iron_spear".into()));
}
    // rust: let Some(camel) = self.spawn_mob("minecraft:camel_husk", at, false) else {
    // rust: return;
}
    // rust: self.mount_mob(id, camel);
    // rust: if let Some(parched) = self.spawn_mob("minecraft:parched", at, false) {
    // rust: self.mount_mob(parched, camel);
}
}
    // `Drowned.finalizeSpawn`: half the natural drowned holding a trident,
    // outside the rivers and oceans that breed more drowned, ride a zombie
    // nautilus.
spawn_zombie_nautilus_jockey :: proc(self: ^Self, id: u32, at: [f64; 3]) {
}
    // rust: let Some(d) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: if d.extra.main_hand.as_deref() != Some("minecraft:trident")
    // rust: || self.world.random.next_float() >= 0.5
    // rust: {
    // rust: return;
}
    // rust: let (x, y, z) = (
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: let frequent = self.world.chunks.get(&(x >> 4, z >> 4)).is_some_and(|c| {
    // rust: let b = world_biomes!(self).get(c.biome(x, y, z));
    // rust: self.res
    // rust: .mob_data()
    // rust: .biome_has("minecraft:more_frequent_drowned_spawns", &b.name)
    // rust: });
    // rust: if frequent {
    // rust: return;
}
    // rust: if let Some(n) = self.spawn_mob("minecraft:zombie_nautilus", at, false) {
    // rust: self.mount_mob(id, n);
}
}
free_chicken_near :: proc(self: ^Self, at: [f64; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|c| {
    // rust: c.species() == Species::Chicken
    // rust: && c.alive()
    // rust: && c.extra.rider.is_none()
    // rust: && c.extra.mount.is_none()
    // rust: && (c.position.x - at[0]).abs() <= 5.3
    // rust: && (c.position.y - at[1]).abs() <= 3.0 + 1.0
    // rust: && (c.position.z - at[2]).abs() <= 5.3
    // rust: })
    // rust: .map(|c| c.id)
}
make_chicken_jockey :: proc(self: ^Self, chicken: u32) {
}
    // rust: if let Some(c) = self.mobs.iter_mut().find(|m| m.id == chicken) {
    // rust: c.extra.jockey = true;
}
}
    // `Strider.finalizeSpawn`: one strider in thirty carries a zombified
    // piglin holding a warped fungus on a stick (and wears a saddle), one in
    // ten of the rest a baby strider.
spawn_strider_jockey :: proc(self: ^Self, id: u32, at: [f64; 3]) {
}
    // rust: if self.world.random.next_int_bound(30).unwrap_or(1) == 0 {
    // rust: if !self.ui.rules.bool("spawn_mobs") {
    // rust: return;
}
    // rust: if let Some(piglin) = self.spawn_mob("minecraft:zombified_piglin", at, false) {
    // rust: let baby = self.world.random.next_float() < CHICKEN_JOCKEY_ODDS;
    // rust: if let Some(p) = self.mobs.iter_mut().find(|m| m.id == piglin) {
    // rust: p.extra
    // rust: .set_main_hand(Some("minecraft:warped_fungus_on_a_stick".into()));
    // rust: p.extra.age = if baby { i32::MIN / 2 } else { 0 };
}
    // rust: if let Some(s) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: s.extra.saddled = true;
}
    // rust: self.mount_mob(piglin, id);
}
    // rust: } else if self.world.random.next_int_bound(10).unwrap_or(1) == 0
    // rust: && let Some(baby) = self.spawn_mob("minecraft:strider", at, false)
    // rust: {
    // rust: if let Some(b) = self.mobs.iter_mut().find(|m| m.id == baby) {
    // rust: b.extra.age = -24000;
}
    // rust: self.mount_mob(baby, id);
}
}

    // `SkeletonHorse.customServerAiStep` and `SkeletonTrapGoal`: a trap
    // horse is a trap for fifteen minutes; a player within ten blocks springs
    // it.
    // rust: pub(super) fn tick_skeleton_traps(&mut self) {
        // `Level.hasNearbyAlivePlayer`: alive, not a spectator, in the level.
    // rust: let players: Vec<_> = self
    // rust: .level_players()
    // rust: .into_iter()
    // rust: .filter(|p| p.alive && !p.spectator)
    // rust: .map(|p| p.position)
    // rust: .collect();
    // rust: let mut sprung = Vec::new();
    // rust: for m in &mut self.mobs {
    // rust: if m.species() != Species::SkeletonHorse || !m.extra.trap || !m.alive() {
    // rust: continue;
}
    // rust: if !m.persistent {
    // rust: m.extra.trap_time += 1;
    // rust: if m.extra.trap_time > TRAP_LIFETIME {
    // rust: m.removed = true;
    // rust: continue;
}
}
    // rust: if players
    // rust: .iter()
    // rust: .any(|&p| m.distance_sqr(p) < TRAP_RANGE * TRAP_RANGE)
    // rust: {
    // rust: sprung.push(m.id);
}
}
    // rust: for id in sprung {
    // rust: self.spring_skeleton_trap(id);
}
}
spring_skeleton_trap :: proc(self: ^Self, id: u32) {
}
    // rust: let Some(horse) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: horse.extra.trap = false;
    // rust: horse.extra.tame = true;
    // rust: horse.extra.age = 0;
    // rust: let at = [horse.position.x, horse.position.y, horse.position.z];
    // rust: self.spawn_bolt(at, true);
    // rust: let Some(skeleton) = self.trap_skeleton(at) else {
    // rust: return;
}
    // rust: self.mount_mob(skeleton, id);
    // rust: for _ in 0..3 {
    // rust: let Some(other) = self.spawn_mob("minecraft:skeleton_horse", at, true) else {
    // rust: continue;
}
    // rust: let (dx, dz) = (
    // rust: self.world.random.triangle(0.0, 1.1485),
    // rust: self.world.random.triangle(0.0, 1.1485),
    // rust: );
    // rust: if let Some(h) = self.mobs.iter_mut().find(|m| m.id == other) {
    // rust: h.invulnerable = TRAP_INVULNERABLE;
    // rust: h.extra.tame = true;
    // rust: h.extra.age = 0;
    // rust: h.velocity = Vec3::new(h.velocity.x + dx, h.velocity.y, h.velocity.z + dz);
}
    // rust: if let Some(rider) = self.trap_skeleton(at) {
    // rust: self.mount_mob(rider, other);
}
}
}
    // `SkeletonTrapGoal.createSkeleton`: an iron helmet unless it already
    // has a helm.
trap_skeleton :: proc(self: ^Self, at: [f64; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = self.spawn_mob("minecraft:skeleton", at, true)?;
    // rust: let m = self.mobs.iter_mut().find(|m| m.id == id)?;
    // rust: m.invulnerable = TRAP_INVULNERABLE;
    // rust: if m.extra.head.is_none() {
    // rust: m.extra.head = Some("minecraft:iron_helmet".into());
}
    // rust: let (weapon, helmet) = (m.extra.main_hand.clone(), m.extra.head.clone());
    // rust: let special = self.local_difficulty(at).special();
        // `SkeletonTrapGoal.enchant`: the weapon and the helmet, always.
    // rust: for (slot, item) in [
    // rust: (horizon_client::mobs::gear::MAIN, weapon),
    // rust: (horizon_client::mobs::gear::HEAD, helmet),
    // rust: ] {
    // rust: if let Some(item) = item {
    // rust: self.enchant_item(id, slot, &item, special);
}
}
    // rust: Some(id)
}
}

    // rust: mod tests {
//     use super::*;

spawner_and_reinforcement_spawns_get_no_mounts :: proc() {
}
    // rust: for (species, baby) in [
    // rust: (Species::ZombieHorse, false),
    // rust: (Species::Husk, false),
    // rust: (Species::Drowned, false),
    // rust: ] {
    // rust: let none = MountRolls {
    // rust: zombie_horse_rider: false,
    // rust: camel_husk: false,
    // rust: nautilus: false,
}
    // rust: assert_eq!(mount_rolls(species, baby, false), none, "{species:?}");
}
}

natural_spawns_roll_their_own_mount :: proc() {
}
    // rust: let r = |s, b| mount_rolls(s, b, true);
    // rust: assert!(r(Species::ZombieHorse, false).zombie_horse_rider);
    // rust: assert!(r(Species::Husk, false).camel_husk);
    // rust: assert!(r(Species::Drowned, false).nautilus);
    // rust: assert!(!r(Species::Drowned, true).nautilus);
    // rust: assert!(!r(Species::Zombie, false).camel_husk);
}
}
