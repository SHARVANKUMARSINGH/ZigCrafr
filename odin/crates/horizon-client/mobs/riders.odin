//! Transpiled from Horizon Rust crate
package horizon_client_riders

import "core:fmt"
import "core:mem"
import "core:math"

// Mobs riding mobs (`Entity.getPassengers`): where a rider sits on its
// vehicle (`EntityAttachments`), the rider steering the vehicle toward its
// target (`Mob.getControllingPassenger`, whose navigation and move control
// the rider's goals use), and the saved jockey fields. The game links the
// two (`game/passengers.rs`) and spawns the jockeys.
// use super::{
    // rust: Mob, MobWorld, Seen, Species,
    // rust: goals::{JUMP, LOOK, MOVE, TARGET},
}
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_world::nbt::{Compound, Tag};

// The goal flags a controlling passenger takes from its vehicle.
CONTROLLED :: MOVE | JUMP | LOOK
// `Entity.removePassenger`: a passenger that got off cannot board for 60 ticks.
BOARDING_COOLDOWN :: 60
// `Piglin.startRiding`: how many baby piglins stack on one hoglin.
MAX_PASSENGERS_ON_ONE_HOGLIN :: 3

// `LivingEntity.getScale`: the `minecraft:scale` the server sent on any
// living entity, 1 when unset (`Mob::model_scale`).
    // rust: pub(super) fn scale(m: &Mob) -> f64 {
    // rust: f64::from(m.model_scale())
}
// Players and mannequins (`Avatar`).
avatar :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(&*m.kind.id, "minecraft:player" | "minecraft:mannequin")
}
// `EntityType` passenger attachment of a vehicle (before rotation): where a
// rider's attachment point sits relative to the vehicle's feet, in its
// scale (`getDimensions` scales the attachments with the box).
passenger_attachment :: proc(v: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = base_attachment(v);
    // rust: let s = scale(v);
    // AbstractHorse.getPassengerAttachmentPoint: a rearing horse slides it,
    // after the scaled attachment (`rear_offset` scales with age itself).
    // rust: let rear = super::equine::rear_offset(v);
    // rust: [x * s + rear[0], y * s + rear[1], z * s + rear[2]]
}
// An `EntityType` attachment point: the builder takes floats, so the double
// the position math sees is the float's widening (`Vec3(x, y, z)` of
// `0.86875F` is `0.8687499761581421`).
pt :: proc(x: f32, y: f32, z: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [f64::from(x), f64::from(y), f64::from(z)]
}
// `EntityTypes` `passengerAttachments(y)` with one height.
up :: proc(y: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: pt(0.0, y, 0.0)
}
// `EntityType.HAPPY_GHAST` `passengerAttachments`: four seats at the corners
// of the back (front, left, back, right), picked by the rider's place in
// `getPassengers` (`EntityAttachments.get` clamps the index to the last).
happy_ghast_attachment :: proc(index: uint) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: const SEATS: [[f32; 3]; 4] = [
    // rust: [0.0, 4.0, 1.7],
    // rust: [-1.7, 4.0, 0.0],
    // rust: [0.0, 4.0, -1.7],
    // rust: [1.7, 4.0, 0.0],
    // rust: ];
    // rust: let [x, y, z] = SEATS[index.min(SEATS.len() - 1)];
    // rust: pt(x, y, z)
}
// `Pig.getDefaultDimensions` and other species' age-specific passenger attachments.
base_attachment :: proc(v: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let baby = v.is_baby();
    // Players and mannequins have no `passengerAttachments`: their box top.
    // rust: if avatar(v) {
    // rust: return [0.0, f64::from(v.height()) / scale(v), 0.0];
}
    // rust: match v.species() {
    // rust: Species::Chicken => pt(0.0, 0.7, -0.1),
    // rust: Species::Spider => up(0.765),
    // rust: Species::Ravager => pt(0.0, 2.2625, -0.0625),
    // rust: Species::Horse => up(1.44375),
    // rust: Species::Donkey => up(1.1125),
    // rust: Species::Mule => up(1.2125),
    // rust: Species::SkeletonHorse | Species::ZombieHorse => up(1.31875),
    // rust: Species::Pig if baby => up(0.5),
    // rust: Species::Pig => up(0.86875),
        // `Hoglin.BABY_DIMENSIONS` and `EntityType.HOGLIN`.
    // rust: Species::Hoglin if baby => up(0.875),
    // rust: Species::Hoglin => up(1.49375),
    // rust: Species::Zoglin if !baby => up(1.49375),
    // rust: Species::Nautilus | Species::ZombieNautilus => up(1.1375),
    // rust: Species::Camel | Species::CamelHusk => super::camel::passenger_attachment(v),
        // The rest of the `passengerAttachments(...)` in `EntityTypes`. The
        // humanoids' babies carry their own dimensions (the default below).
    // rust: Species::Cat => up(0.5125),
    // rust: Species::Cow | Species::Mooshroom => up(1.36875),
    // rust: Species::Sheep => up(1.2375),
    // rust: Species::Goat => up(1.1125),
    // rust: Species::Ocelot => up(0.6375),
    // rust: Species::Parrot => up(0.4625),
    // rust: Species::Phantom => up(0.3375),
    // rust: Species::Vex => up(0.7375),
    // rust: Species::Guardian => up(0.975),
    // rust: Species::ElderGuardian => up(2.350625),
    // rust: Species::Endermite | Species::Silverfish => up(0.2375),
    // rust: Species::Enderman => up(2.80625),
    // rust: Species::Ghast => up(4.0625),
    // rust: Species::HappyGhast => happy_ghast_attachment(0),
    // rust: Species::Warden => up(3.15),
    // rust: Species::Sniffer => up(2.09375),
    // rust: Species::Fox => pt(0.0, 0.6375, -0.25),
    // rust: Species::Frog => pt(0.0, 0.375, -0.25),
    // rust: Species::Llama | Species::TraderLlama => pt(0.0, 1.37, -0.3),
    // rust: Species::Turtle => pt(0.0, 0.55625, -0.25),
    // rust: Species::Wolf => pt(0.0, 0.81875, -0.0625),
    // rust: Species::Witch => up(2.2625),
    // rust: Species::Evoker | Species::Illusioner | Species::Pillager | Species::Vindicator => up(2.0),
    // rust: Species::ZombifiedPiglin if !baby => up(2.0),
    // rust: Species::Zombie | Species::Drowned | Species::Piglin | Species::PiglinBrute if !baby => {
    // rust: up(2.0125)
}
    // rust: Species::Husk if !baby => up(2.075),
    // rust: Species::ZombieVillager if !baby => up(2.125),
        // The default attachments: the top of the bounding box, before
        // `passenger_attachment`'s scale — `height()` carries
        // `minecraft:scale` since `getDimensions` grew every living entity's
        // box, so the box's own height divides it out again.
    // rust: _ => [0.0, f64::from(v.height()) / scale(v), 0.0],
}
}
// The rider's own `VEHICLE` attachment height (`ridingOffset`): how far
// below the vehicle's attachment point its feet hang, in its scale.
// `vehicle_width` is the vehicle's `getBbWidth`, which a spider's own rule
// reads.
vehicle_attachment :: proc(r: ^Mob, vehicle_width: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: unscaled_vehicle_attachment(r, vehicle_width) * scale(r)
}
unscaled_vehicle_attachment :: proc(r: ^Mob, vehicle_width: f32) -> f {
    // Ported from Horizon
    return {}
}
//     use Species as S;
    // Avatar.DEFAULT_VEHICLE_ATTACHMENT.
    // rust: if avatar(r) {
    // rust: return f64::from(0.6_f32);
}
    // `Spider.getVehicleAttachmentPoint` and `CaveSpider.getVehicleAttachmentPoint`:
    // a vehicle no wider than the rider takes the spider's fixed seat, and a
    // wider one the type's default. A cave spider's super call reaches the
    // spider's rule, which then sees the same width and takes the default too.
    // rust: if vehicle_width <= r.width() {
    // rust: match r.species() {
    // rust: S::CaveSpider => return 0.21875,
    // rust: S::Spider => return 0.3125,
    // rust: _ => {}
}
}
    // rust: match r.species() {
    // rust: S::Zombie | S::Husk | S::Drowned if r.is_baby() => 0.1875,
    // rust: S::ZombieVillager if r.is_baby() => 0.125,
        // `Piglin.BABY_DIMENSIONS`' vehicle attachment.
    // rust: S::Piglin if r.is_baby() => 0.1875,
    // rust: S::Zombie
    // rust: | S::Husk
    // rust: | S::Drowned
    // rust: | S::ZombieVillager
    // rust: | S::ZombifiedPiglin
    // rust: | S::Piglin
    // rust: | S::PiglinBrute
    // rust: | S::Skeleton
    // rust: | S::Stray
    // rust: | S::Bogged
    // rust: | S::Parched => f64::from(0.7_f32),
    // rust: S::WitherSkeleton => f64::from(0.875_f32),
        // `ridingOffset(0.5F)` and kin: a negative seat offset lifts the rider.
    // rust: S::Ghast | S::HappyGhast => f64::from(-0.5_f32),
    // rust: S::Allay | S::Vex => f64::from(-0.04_f32),
    // rust: S::Phantom => f64::from(0.125_f32),
    // rust: S::Giant => f64::from(3.75_f32),
    // rust: S::Pillager | S::Vindicator | S::Evoker | S::Illusioner => f64::from(0.6_f32),
    // rust: _ => 0.0,
}
}
// `Vec3.yRot(-yaw)` of an attachment point.
rotated :: proc(z]: [f64; 3], yaw: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let a = -f64::from(yaw).to_radians();
    // rust: let (sin, cos) = (a.sin(), a.cos());
    // rust: [x * cos + z * sin, y, z * cos - x * sin]
}
// `Entity.positionRider`: the vehicle's position plus its rotated passenger
// attachment, less the rider's own vehicle attachment.
seat :: proc(attachment: [f64; 3], rider_offset: f64, at: Vec3, yaw: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = rotated(attachment, yaw);
    // rust: Vec3::new(at.x + x, at.y + y - rider_offset, at.z + z)
}

// `Entity.startRiding`: the link it makes, `rider` on `vehicle` as its first
// passenger (`addPassenger`).
link :: proc(mobs: ^[Mob], rider: u32, vehicle: u32) {
}
    // rust: if rider == vehicle {
    // rust: return;
}
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == rider) {
    // rust: super::shulker::on_start_riding(m);
    // rust: m.extra.mount = Some(vehicle);
    // rust: m.extra.passenger = true;
}
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == vehicle)
    // rust: && m.extra.rider.is_none()
    // rust: {
    // rust: m.extra.rider = Some(rider);
}
}
// `canAddPassenger` with `aboard` passengers on `v`: a camel takes another
// while it carries at most two (`Camel`: `getPassengers().size() <= 2`, a baby
// too), a happy ghast up to four, anything else only when empty (`Entity`).
can_add_passenger :: proc(v: ^Mob, aboard: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match v.species() {
    // rust: s if super::camel::is_camel(s) => aboard <= 2,
    // rust: Species::HappyGhast => aboard < 4,
    // rust: _ => aboard == 0,
}
}
// `Piglin.getTopPassenger`: down the chain of first passengers from
// `vehicle`, stopping at the `counter`th seat.
top_passenger :: proc(mobs: ^[Mob], vehicle: u32, counter: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let first = mobs
    // rust: .iter()
    // rust: .find(|m| m.id == vehicle)
    // rust: .and_then(|m| m.extra.rider);
    // rust: match first {
    // rust: Some(passenger) if counter != 1 => top_passenger(mobs, passenger, counter - 1),
    // rust: _ => vehicle,
}
}
// `Piglin.startRiding` over `Entity.startRiding` for two mobs: a baby piglin
// that boards a hoglin sits on the top of up to three piglins stacked on it.
// Not the vehicle it is on already, nor one it carries itself, and only
// after its boarding cooldown, onto a vehicle with no passenger
// (`canRide`, `canAddPassenger`). Returns whether it boarded.
start_riding :: proc(mobs: ^[Mob], rider: u32, vehicle: u32) -> b {
    // Ported from Horizon
    return {}
}
    // `Shulker.startRiding` puts its attach face back before the ride is
    // decided, so a shulker that is refused still ends up lid up.
    // rust: if let Some(m) = mobs.iter_mut().find(|m| m.id == rider) {
    // rust: super::shulker::on_start_riding(m);
}
    // rust: let Some(r) = mobs.iter().find(|m| m.id == rider) else {
    // rust: return false;
}
    // rust: let on_hoglin = mobs
    // rust: .iter()
    // rust: .any(|m| m.id == vehicle && m.species() == Species::Hoglin);
    // rust: let vehicle = if r.species() == Species::Piglin && r.is_baby() && on_hoglin {
    // rust: top_passenger(mobs, vehicle, MAX_PASSENGERS_ON_ONE_HOGLIN)
    // rust: } else {
    // rust: vehicle
}
    // rust: if rider == vehicle || r.extra.mount == Some(vehicle) {
    // rust: return false;
}
    // Nothing that rides the rider (through any number of vehicles) can be
    // its vehicle.
    // rust: let mut up = Some(vehicle);
    // rust: while let Some(v) = up {
    // rust: up = mobs.iter().find(|m| m.id == v).and_then(|m| m.extra.mount);
    // rust: if up == Some(rider) {
    // rust: return false;
}
}
    // rust: let Some(v) = mobs.iter().find(|m| m.id == vehicle) else {
    // rust: return false;
}
    // rust: let count = usize::from(v.rider.is_some())
    // rust: + mobs
    // rust: .iter()
    // rust: .filter(|m| m.extra.mount == Some(vehicle))
    // rust: .count()
    // rust: .max(usize::from(v.extra.rider.is_some()));
    // rust: if r.extra.boarding_cooldown > 0 || !can_add_passenger(v, count) {
    // rust: return false;
}
    // rust: link(mobs, rider, vehicle);
    // rust: true
}
// `LivingEntity.stopRiding` for the mob itself: it leaves its vehicle (which
// forgets it when the riders are next synced), cannot board again for 60
// ticks (`Entity.removePassenger`) and is set down at `at`, where
// `dismountVehicle` puts it (`dismountTo`), or stays where it is.
stop_riding :: proc(m: ^Mob, at: Maybe(Vec3)) {
}
    // rust: if m.extra.mount.take().is_none() {
    // rust: return;
}
    // rust: m.extra.passenger = false;
    // rust: m.extra.boarding_cooldown = BOARDING_COOLDOWN;
    // rust: if let Some(at) = at {
    // rust: m.position = at;
    // rust: m.previous = at;
}
}
// `Animal.getDismountLocationForPassenger` for a standing passenger of
// `width` by `height`: on the floor of the first block around the
// vehicle's, going right, left, behind right, behind left, ahead right,
// ahead left, behind and ahead of its facing, where the passenger's box
// fits (`DismountHelper.canDismountTo`, without the world border); else on
// top of the vehicle. A piglin is no `Animal`: it keeps
// `Entity.getDismountLocationForPassenger`, on top of it.
dismount_location :: proc(w: ^MobWorld, vehicle: ^Seen, width: f32, height: f32) -> V {
    // Ported from Horizon
    return {}
}
    // `Entity.getDismountLocationForPassenger`.
    // rust: let on_top = Vec3::new(
    // rust: vehicle.position.x,
    // rust: vehicle.bounds.max_position().y,
    // rust: vehicle.position.z,
    // rust: );
    // rust: if vehicle.species == Species::Piglin {
    // rust: return on_top;
}
    // rust: let (bx, by, bz) = (
    // rust: vehicle.position.x.floor() as i32,
    // rust: vehicle.position.y.floor() as i32,
    // rust: vehicle.position.z.floor() as i32,
    // rust: );
    // `Direction.fromYRot` of the vehicle's yaw: south, west, north, east.
    // rust: let facing = (f64::from(vehicle.yaw) / 90.0 + 0.5).floor() as i32;
    // rust: let (fx, fz) = [(0, 1), (-1, 0), (0, -1), (1, 0)][(facing & 3) as usize];
    // `DismountHelper.offsetsForDirection`; `right` is `Direction.getClockWise`.
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
    // `EntityDimensions.makeBoundingBox`: the half width is a float.
    // rust: let half = f64::from(width / 2.0);
    // rust: for (dx, dz) in offsets {
    // rust: let (x, z) = (bx + dx, bz + dz);
    // rust: let floor = w.block_floor_height(x, by, z);
        // `DismountHelper.isBlockFloorValid`.
    // rust: if floor.is_infinite() || floor >= 1.0 {
    // rust: continue;
}
        // `Vec3.upFromBottomCenterOf`.
    // rust: let at = Vec3::new(
    // rust: f64::from(x) + 0.5,
    // rust: f64::from(by) + floor,
    // rust: f64::from(z) + 0.5,
    // rust: );
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(at.x - half, at.y, at.z - half),
    // rust: Vec3::new(at.x + half, at.y + f64::from(height), at.z + half),
    // rust: );
    // rust: if w.no_collision(bounds) {
    // rust: return at;
}
}
    // rust: on_top
}

// Ranged riders keep this far from their target instead of closing in.
RANGED_DISTANCE :: 8.0
ranged :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Skeleton
    // rust: | Species::Stray
    // rust: | Species::Bogged
    // rust: | Species::Parched
    // rust: | Species::Pillager
    // rust: | Species::Witch
    // rust: | Species::Piglin
    // rust: )
}
// `Mob.getControllingPassenger`: NoAI belongs to the vehicle, not its rider.
    // rust: fn controller<'a>(m: &Mob, w: &'a MobWorld) -> Option<&'a Seen> {
    // rust: if m.no_ai {
    // rust: return None;
}
    // rust: m.extra.rider.and_then(|id| w.seen(id)).filter(|r| {
    // rust: r.alive
    // rust: && !w.data.entity_has(
    // rust: "minecraft:non_controlling_rider",
    // rust: &format!("minecraft:{}", super::species::def(r.species).name),
    // rust: )
    // rust: })
}
// Vehicle goal flags are independent of whether the rider has a combat target.
// Ravager.updateControlFlags permits raiders, unlike Mob.updateControlFlags.
drive :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let rider = controller(m, w);
    // rust: let disabled = rider
    // rust: .is_some_and(|r| m.species() != Species::Ravager || !super::raider::is_raider(r.species));
    // rust: let flags = CONTROLLED
    // rust: | if m.species() == Species::Ravager {
    // rust: TARGET
    // rust: } else {
    // rust: 0
}
    // rust: if disabled {
    // rust: m.ai.goals.disabled |= flags;
    // rust: } else {
    // rust: m.ai.goals.disabled &= !flags;
}
    // Keep the existing combat steering and ranged stopping distance.
    // rust: let Some((seen, t)) = rider.and_then(|r| {
    // rust: r.target
    // rust: .and_then(|target| w.target_info(target))
    // rust: .filter(|t| t.alive && !(t.is_player && t.creative))
    // rust: .map(|t| (r, t))
    // rust: }) else {
    // rust: return;
}
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 30.0, 30.0);
    // rust: let close =
    // rust: ranged(seen.species) && m.distance_sqr(t.position) < RANGED_DISTANCE * RANGED_DISTANCE;
    // rust: if close {
    // rust: m.nav_stop();
    // rust: } else if m.ai.nav.is_done() || (m.age + m.id).is_multiple_of(10) {
    // rust: m.nav_move_to_entity(w, [t.position.x, t.position.y, t.position.z], 0, 1.0);
}
}
mob_controlled :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: controller(m, w).is_some()
}

// Tick a passenger with Mob.getNavigation's recursive vehicle redirection.
// Navigation is lent, not copied: goal start/stop/path progress all address
// the same object the vehicle ticks. The pathfinder sees the vehicle body.
    // rust: pub fn tick(
    // rust: mobs: &mut [Mob],
    // rust: index: usize,
    // rust: w: &MobWorld,
    // rust: random: &mut horizon_core::random::LegacyRandom,
    // rust: events: &mut Vec<super::MobEvent>,
    // rust: ) -> bool {
    // rust: let mut owner = index;
    // rust: if !mobs[index].no_ai {
    // rust: for _ in 0..mobs.len() {
    // rust: let Some(vehicle) = mobs[owner]
    // rust: .extra
    // rust: .mount
    // rust: .and_then(|id| mobs.iter().position(|m| m.id == id))
    // rust: else {
    // rust: break;
}
    // rust: if vehicle == index
    // rust: || controller(&mobs[vehicle], w).is_none_or(|r| r.id != mobs[owner].id)
    // rust: {
    // rust: break;
}
    // rust: owner = vehicle;
}
}
    // rust: if owner == index {
    // rust: return mobs[index].tick(w, random, events);
}
    // rust: let (rider, vehicle) = if index < owner {
    // rust: let (left, right) = mobs.split_at_mut(owner);
    // rust: (&mut left[index], &mut right[0])
    // rust: } else {
    // rust: let (left, right) = mobs.split_at_mut(index);
    // rust: (&mut right[0], &mut left[owner])
}
    // rust: let body = vehicle.path_mob();
    // rust: std::mem::swap(&mut rider.ai.nav, &mut vehicle.ai.nav);
    // rust: rider.ai.navigation_redirect = Some(Box::new(super::nav::Redirect {
    // rust: own: std::mem::take(&mut vehicle.ai.nav),
    // rust: body,
    // rust: follow_range: vehicle.attrs.follow_range as f32,
    // rust: passenger: vehicle.extra.mount.is_some(),
    // rust: in_liquid: vehicle.is_in_liquid(),
    // rust: }));
    // rust: let kept = rider.tick(w, random, events);
    // rust: let redirect = rider
    // rust: .ai
    // rust: .navigation_redirect
    // rust: .take()
    // rust: .expect("navigation loan lasts for the tick");
    // rust: vehicle.ai.nav = std::mem::replace(&mut rider.ai.nav, redirect.own);
    // rust: kept
}
// `Mob.requiresCustomPersistence`: a passenger never despawns.
keeps_alive :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.mount.is_some()
}

// `IsChickenJockey`, `SkeletonTrap` and `SkeletonTrapTime`.
write_nbt :: proc(m: ^Mob, map: ^Compound) {
}
    // rust: match m.species() {
    // rust: Species::Chicken => {
    // rust: map.insert(
    // rust: "IsChickenJockey".into(),
    // rust: Tag::Byte(i8::from(m.extra.jockey)),
    // rust: );
}
    // rust: Species::SkeletonHorse => {
    // rust: map.insert("SkeletonTrap".into(), Tag::Byte(i8::from(m.extra.trap)));
    // rust: map.insert("SkeletonTrapTime".into(), Tag::Int(m.extra.trap_time));
}
    // rust: _ => {}
}
}
read_nbt :: proc(m: ^Mob, tag: ^Tag) {
}
    // rust: let int = |key: &str| match tag.get(key) {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: Some(Tag::Byte(v)) => i32::from(*v),
    // rust: Some(Tag::Short(v)) => i32::from(*v),
    // rust: _ => 0,
}
    // rust: match m.species() {
    // rust: Species::Chicken => m.extra.jockey = int("IsChickenJockey") != 0,
    // rust: Species::SkeletonHorse => {
    // rust: m.extra.trap = int("SkeletonTrap") != 0;
    // rust: m.extra.trap_time = int("SkeletonTrapTime");
}
    // rust: _ => {}
}
}

    // rust: mod tests {
//     use super::*;

attachments_turn_with_the_vehicle :: proc() {
}
        // A ravager's seat sits a sixteenth behind its centre.
    // rust: let behind = [0.0, 2.2625, -0.0625];
    // rust: let [x, y, z] = rotated(behind, 0.0);
    // rust: assert!(x.abs() < 1e-9 && (z + 0.0625).abs() < 1e-9 && y == 2.2625);
        // Facing west (yaw 90), behind is to the east.
    // rust: let [x, _, z] = rotated(behind, 90.0);
    // rust: assert!((x - 0.0625).abs() < 1e-9 && z.abs() < 1e-9);
}
npc :: proc(scale: f32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:player".into();
    // rust: let mut m = Mob::new(1, std::sync::Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: m.extra.model_scale = scale;
    // rust: m
}
    // An NPC plugin's enlarged fake player: the name it carries sits on the
    // top of its scaled box, and on a seat it hangs `Avatar`'s 0.6 lower, scaled too.
a_scaled_player_carries_and_sits_in_its_scale :: proc() {
}
    // rust: let close = |a: f64, b: f64| (a - b).abs() < 1e-6;
    // rust: assert!(close(passenger_attachment(&npc(0.0))[1], 1.8));
    // rust: assert!(close(passenger_attachment(&npc(1.5))[1], 2.7));
    // rust: assert!(close(vehicle_attachment(&npc(0.0), 1.375), 0.6));
    // rust: assert!(close(vehicle_attachment(&npc(1.5), 1.375), 0.9));
        // On a seat at y 55 (a text display, whose attachment is its feet):
        // a 1.5 NPC's feet at 54.1, where the server puts it.
    // rust: let seat = seat(
    // rust: [0.0; 3],
    // rust: vehicle_attachment(&npc(1.5), 1.375),
    // rust: Vec3::new(0.0, 55.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: assert!(close(seat.y, 54.1));
}
    // A scaled vehicle that is not an avatar: `remote_mob_attributes` puts
    // `minecraft:scale` on any living entity, so the seat rides at the scaled
    // box height on a cow as on a fake player.
a_scaled_vehicle_seat_stays_scaled :: proc() {
}
    // rust: let close = |a: f64, b: f64| (a - b).abs() < 1e-6;
    // rust: let mut cow = Mob::new(1, crate::mobs::sensor_scan_tests::kind(), Vec3::ZERO, 0.0);
        // `EntityTypes.COW`: passengerAttachments(1.36875F).
    // rust: assert!(close(passenger_attachment(&cow)[1], 1.36875));
    // rust: cow.extra.model_scale = 2.0;
    // rust: assert!(close(passenger_attachment(&cow)[1], 2.7375));
}
    // The attachments are `EntityTypes` floats widened to double, and a
    // zombie's seat (2.0125) is above its box (1.95).
seats_are_the_entity_type_floats :: proc() {
}
    // rust: let close = |a: f64, b: f64| (a - b).abs() < 1e-12;
    // rust: assert!(close(up(0.86875)[1], 0.868_749_976_158_142_1));
    // rust: assert!(close(f64::from(0.7_f32), 0.699_999_988_079_071));
    // rust: assert!(close(
    // rust: up(2.0125)[1] - f64::from(0.7_f32),
    // rust: 1.312_500_059_604_645
    // rust: ));
}
    // `Pig.getDefaultDimensions`: BABY_DIMENSIONS overrides PASSENGER.
a_baby_pig_uses_its_own_passenger_attachment :: proc() {
}
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:pig".into();
    // rust: kind.species = Species::Pig;
    // rust: let kind = std::sync::Arc::new(kind);
    // rust: let mut vehicle = Mob::new(1, kind.clone(), Vec3::new(4.5, 200.0, 4.5), 0.0);
    // rust: let rider = Mob::new(2, kind, Vec3::ZERO, 0.0);
    // rust: for (scale, baby_y, adult_y) in [
    // rust: (0.0, 0.5, 0.868_749_976_158_142_1),
    // rust: (1.0, 0.5, 0.868_749_976_158_142_1),
    // rust: (2.0, 1.0, 1.737_499_952_316_284_2),
    // rust: ] {
    // rust: vehicle.extra.model_scale = scale;
    // rust: for (age, expected) in [(-24000, baby_y), (-1, baby_y), (0, adult_y), (42, adult_y)] {
    // rust: vehicle.extra.age = age;
    // rust: let attachment = passenger_attachment(&vehicle);
    // rust: assert_eq!(attachment, [0.0, expected, 0.0], "age={age}, scale={scale}");
    // rust: let offset = vehicle_attachment(&rider, vehicle.width());
    // rust: assert_eq!(offset, 0.0);
    // rust: assert_eq!(
    // rust: seat(attachment, offset, vehicle.position, vehicle.yaw),
    // rust: Vec3::new(4.5, 200.0 + expected, 4.5)
    // rust: );
}
}
}

archers_keep_their_distance_and_brawlers_close_in :: proc() {
}
    // rust: assert!(ranged(Species::Skeleton) && ranged(Species::Pillager));
    // rust: assert!(!ranged(Species::Zombie) && !ranged(Species::Vindicator));
}
    // `Spider.getVehicleAttachmentPoint` and
    // `CaveSpider.getVehicleAttachmentPoint`: a vehicle no wider than the
    // spider takes the spider's fixed seat — 0.3125 of its scale, and a cave
    // spider's 0.21875 — and a wider one the type's default.
a_spider_sits_by_its_own_rule_on_a_narrow_vehicle :: proc() {
}
        // World-gated: without the extracted data the body never runs.
    // rust: let _ = crate::mobs::world::with_test_world(&[], |_, types| {
    // rust: let new = |kind: &str| {
    // rust: Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types[kind].clone()),
    // rust: Vec3::ZERO,
    // rust: 0.0,
    // rust: )
}
    // rust: let close = |a: f64, b: f64| (a - b).abs() < 1e-9;
    // rust: let chicken = 0.4_f32;
            // Wider than either spider (the boat's 1.375 is not).
    // rust: let wide = 2.0_f32;
    // rust: let spider = new("minecraft:spider");
    // rust: let cave = new("minecraft:cave_spider");
    // rust: assert!(spider.width() > chicken && cave.width() > chicken);
    // rust: assert!(spider.width() < wide && cave.width() < wide);
    // rust: assert!(close(vehicle_attachment(&spider, chicken), 0.3125));
    // rust: assert!(close(vehicle_attachment(&cave, chicken), 0.21875));
    // rust: assert!(close(vehicle_attachment(&spider, wide), 0.0));
    // rust: assert!(close(vehicle_attachment(&cave, wide), 0.0));
    // rust: let mut big = new("minecraft:cave_spider");
    // rust: big.extra.model_scale = 2.0;
    // rust: assert!(close(vehicle_attachment(&big, chicken), 0.4375));
    // rust: });
}

    // `Shulker.startRiding`: `setAttachFace(Direction.DOWN)` runs before
    // `Entity.startRiding` decides, so a shulker that boards a vehicle sits
    // lid up whatever face it was stuck to - and one whose board is refused
    // still ends up lid up. No other rider's face data moves.
a_shulker_that_boards_sits_lid_up :: proc() {
}
    // rust: let mob = |id: u32, name: &str, species: Species, face: u8| {
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = name.into();
    // rust: kind.species = species;
    // rust: let mut m = Mob::new(id, std::sync::Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: m.extra.variant3 = face;
    // rust: m
}
        // Attached to the block to its east (face 5) and saddled by nobody.
    // rust: let mut mobs = [
    // rust: mob(1, "minecraft:shulker", Species::Shulker, 5),
    // rust: mob(2, "minecraft:pig", Species::Pig, 0),
    // rust: ];
    // rust: assert!(start_riding(&mut mobs, 1, 2), "the shulker boards");
    // rust: assert_eq!(mobs[0].extra.variant3, 0, "riding lid up");
    // rust: assert_eq!(mobs[1].extra.rider, Some(1));

        // A vehicle that already carries someone refuses the board, but the
        // face has already gone back to `DOWN`.
    // rust: let mut refused = [
    // rust: mob(1, "minecraft:shulker", Species::Shulker, 3),
    // rust: mob(2, "minecraft:pig", Species::Pig, 0),
    // rust: mob(9, "minecraft:zombie", Species::Zombie, 0),
    // rust: ];
    // rust: refused[1].extra.rider = Some(9);
    // rust: assert!(!start_riding(&mut refused, 1, 2));
    // rust: assert_eq!(refused[0].extra.variant3, 0);
    // rust: assert_eq!(refused[0].extra.mount, None);

        // `Entity.startRiding` for anything else leaves the data alone.
    // rust: let mut others = [
    // rust: mob(1, "minecraft:cow", Species::Cow, 4),
    // rust: mob(2, "minecraft:pig", Species::Pig, 0),
    // rust: ];
    // rust: assert!(start_riding(&mut others, 1, 2));
    // rust: assert_eq!(others[0].extra.variant3, 4);

        // A camel takes riders while it carries at most two: the first stays
        // extra.rider, and a fourth is refused.
    // rust: let mut camel_ride = [
    // rust: mob(1, "minecraft:husk", Species::Husk, 0),
    // rust: mob(2, "minecraft:parched", Species::Parched, 0),
    // rust: mob(3, "minecraft:zombie", Species::Zombie, 0),
    // rust: mob(4, "minecraft:husk", Species::Husk, 0),
    // rust: mob(10, "minecraft:camel_husk", Species::CamelHusk, 0),
    // rust: ];
    // rust: assert!(start_riding(&mut camel_ride, 1, 10), "first rider boards");
    // rust: assert_eq!(camel_ride[4].extra.rider, Some(1), "first rider is driver");
    // rust: assert!(start_riding(&mut camel_ride, 2, 10), "second rider boards");
    // rust: assert_eq!(camel_ride[1].extra.mount, Some(10));
    // rust: assert_eq!(camel_ride[4].extra.rider, Some(1), "driver stays");
    // rust: assert!(start_riding(&mut camel_ride, 3, 10), "a third still fits");
    // rust: assert!(!start_riding(&mut camel_ride, 4, 10), "a fourth is refused");
    // rust: assert_eq!(camel_ride[3].extra.mount, None);

        // Any other mob carries one.
    // rust: let mut single = [
    // rust: mob(1, "minecraft:zombie", Species::Zombie, 0),
    // rust: mob(2, "minecraft:husk", Species::Husk, 0),
    // rust: mob(10, "minecraft:chicken", Species::Chicken, 0),
    // rust: ];
    // rust: assert!(start_riding(&mut single, 1, 10));
    // rust: assert!(!start_riding(&mut single, 2, 10));
}
}

    // rust: mod happy_ghast_seat_tests {
//     use super::happy_ghast_attachment;

passengers_take_separate_seats :: proc() {
}
    // rust: assert_eq!(happy_ghast_attachment(0), [0.0, 4.0, f64::from(1.7_f32)]);
    // rust: let seats: Vec<_> = (0..4).map(happy_ghast_attachment).collect();
    // rust: for (i, a) in seats.iter().enumerate() {
    // rust: assert!(seats[i + 1..].iter().all(|b| a != b));
}
    // rust: assert_eq!(happy_ghast_attachment(9), seats[3]);
}
}
