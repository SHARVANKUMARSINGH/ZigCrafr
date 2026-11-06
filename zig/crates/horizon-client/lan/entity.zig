//! Transpiled from Horizon Rust crate
//! Module: horizon-client_entity
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity tracking (ChunkMap.TrackedEntity / ServerEntity): the game describes
//! every entity it simulates as an `EntityState` each tick. A level's
//! `Entities` remember what its clients were last told about each entity,
//! once for all of them as vanilla's ServerEntity does, and produce the
//! movement, motion, metadata and equipment packets that bring them up to
//! date at the entity type's update interval (`tracking`); each client's
//! `Tracker` is the set of entities it has been paired with.
// use super::tracking;
// use horizon_protocol::{
    // rust: buf::pack_degrees,
    // rust: entity_data::{Value, serializer},
    // rust: item::Stack,
    // rust: packets::play::{
    // rust: self, AddEntity, AttributeSnapshot, EntityPositionSync, MoveEntity, MoveEntityPos,
    // rust: MoveEntityPosRot, MoveEntityRot, PositionPath, RotateHead, SetEntityData, SetEntityLink,
    // rust: SetEntityMotion, SetEquipment, SetPassengers, UpdateAttributes, VecDelta,
    // rust: },
}
// use std::sync::Arc;

/// The attribute instances of `now` that differ from what `sent` held (an
/// instance is never removed: one that disappears is left as it was sent).
    // rust: pub fn changed_attributes(
    // rust: now: &[AttributeSnapshot],
    // rust: sent: &[AttributeSnapshot],
    // rust: ) -> Vec<AttributeSnapshot> {
    // rust: now.iter()
    // rust: .filter(|a| {
    // rust: sent.iter()
    // rust: .find(|b| b.attribute == a.attribute)
    // rust: .is_none_or(|b| b != *a)
    // rust: })
    // rust: .cloned()
    // rust: .collect()
}

/// What the game says about one entity this tick.
pub const EntityState = struct {
    id: i32,
    uuid: u128,
    /// Registry id of the entity type (`minecraft:zombie`).
    kind: []const u8,
    position: [f64,
    yaw: f32,
    pitch: f32,
    head_yaw: f32,
    on_ground: bool,
    velocity: [f64,
    /// NewMinecartBehavior steps drained from the simulation since its last
    /// export. None selects the ordinary entity movement packets.
    minecart_steps: ?std.ArrayList(play::MinecartStep),
    /// ClientboundAddEntityPacket.data (item frame direction, block state ...).
    data: i32,
    /// SynchedEntityData entries that differ from the defaults.
    meta: Vec<(u8,
    /// The defaults of entries `meta` leaves out while they are at them,
    /// sent when one goes back to its default (a calf grown up, a mob healed
    /// back to 1, wool grown back white) beyond Entity's own below.
    defaults: Vec<(u8,
    /// EquipmentSlot ordinals (0 main hand, 1 off hand, 2 feet, 3 legs,
    /// 4 chest, 5 head, 6 body, 7 saddle) and their stacks.
    equipment: Vec<(u8,
    /// A living entity's client-syncable attribute instances
    /// (`AttributeMap.getSyncableAttributes`), by registry id.
    attributes: std.ArrayList(AttributeSnapshot),
    /// `Entity.getRequiresPrecisePosition` (primed TNT and falling blocks
    /// touching a block): moves are sent as full position syncs.
    precise: bool,
    /// `Entity.verticalCollision` and `Entity.horizontalCollision`: the last
    /// move's stops. An item that stopped on a block gets a full position
    /// sync rather than a 1/4096 delta whose decoded point is not the one it
    /// came to rest at (`ServerEntity.isFullPrecisionEncodingRequired`).
    vertical_collision: bool,
    horizontal_collision: bool,
    /// `Entity.needsSync`: send its changes this tick, due or not.
    needs_sync: bool,
    /// Outside `DistanceManager.inEntityTickingRange`: `ChunkMap.tick` sends
    /// its changes only if it changed section or needs sync (its lead aside,
    /// which `Leashable` sends at once).
    idle: bool,
    /// Where it is, and none of its data: an idle entity no client can pair
    /// with this tick, whose data the tracker then never reads (game/lan_idle.rs).
    /// It is never paired.
    bare: bool,
    /// `Leashable.getLeashHolder`: the entity holding its lead.
    leash: ?i32,
    /// `ServerPlayer.isSpectator`: a player in spectator mode, whom only the
    /// clients of other spectators track (`ServerPlayer.broadcastToPlayer`).
    spectator: bool,
    /// `ServerPlayer.getCamera() != this`: a spectator watching through
    /// another entity is shown to nobody (`ServerPlayer.broadcastToPlayer`).
    watching: bool,
    /// A player a native mod hid (`native_hide_player`): only clients whose
    /// player has at least this permission level track it.
    hidden: ?u8,
};

    // rust: impl EntityState {
    /// The entity `id` of type `kind` as a fresh state has it: at the origin,
    /// at rest, with no data, equipment or attributes. Keeps the allocations
    /// of the strings and vectors it held.
pub fn reset(self: *Self, id: i32, uuid: u128, kind: []const u8) void {
}
    // rust: self.id = id;
    // rust: self.uuid = uuid;
    // rust: self.kind.clear();
    // rust: self.kind.push_str(kind);
    // rust: self.position = [0.0; 3];
    // rust: (self.yaw, self.pitch, self.head_yaw) = (0.0, 0.0, 0.0);
    // rust: self.on_ground = false;
    // rust: self.velocity = [0.0; 3];
    // rust: self.minecart_steps = None;
    // rust: self.data = 0;
    // rust: self.meta.clear();
    // rust: self.defaults.clear();
    // rust: self.equipment.clear();
    // rust: self.attributes.clear();
    // rust: self.precise = false;
    // rust: self.vertical_collision = false;
    // rust: self.horizontal_collision = false;
    // rust: self.needs_sync = false;
    // rust: self.idle = false;
    // rust: self.bare = false;
    // rust: self.leash = None;
    // rust: self.spectator = false;
    // rust: self.watching = false;
    // rust: self.hidden = None;
}
}

/// The states a level describes its entities with, kept from tick to tick:
/// each tick's are written over the last tick's in place, so the strings and
/// vectors in them are reused instead of being made and freed again for every
/// entity on every tick.
pub const States = struct {
    list: std.ArrayList(EntityState),
    len: usize,
};

    // rust: impl States {
    /// Start a new tick's states.
pub fn clear(self: *Self) void {
}
    // rust: self.len = 0;
}
    /// The next entity's state, reset (`EntityState::reset`).
pub fn add(self: *Self, id: i32, uuid: u128, kind: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.len == self.list.len() {
    // rust: self.list.push(EntityState::default());
}
    // rust: let e = &mut self.list[self.len];
    // rust: self.len += 1;
    // rust: e.reset(id, uuid, kind);
    // rust: e
}
pub fn push(self: *Self, e: EntityState) void {
}
    // rust: match self.list.get_mut(self.len) {
    // rust: Some(slot) => *slot = e,
    // rust: None => self.list.push(e),
}
    // rust: self.len += 1;
}
pub fn as_slice(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.list[..self.len]
}
pub fn as_mut_slice(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.list[..self.len]
}
}

    // rust: impl Extend<EntityState> for States {
    // rust: fn extend<I: IntoIterator<Item = EntityState>>(&mut self, states: I) {
    // rust: for e in states {
    // rust: self.push(e);
}
}
}

/// `AbstractArrow`: every update sends its position and rotation.
pub fn is_arrow(kind: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: kind,
    // rust: "minecraft:arrow" | "minecraft:spectral_arrow" | "minecraft:trident"
    // rust: )
}

/// `AbstractHurtingProjectile.accelerationPower` (0.1, none for wind
/// charges), sent with each velocity update.
pub fn acceleration_power(kind: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: "minecraft:fireball"
    // rust: | "minecraft:small_fireball"
    // rust: | "minecraft:dragon_fireball"
    // rust: | "minecraft:wither_skull" => Some(0.1),
    // rust: "minecraft:wind_charge" | "minecraft:breeze_wind_charge" => Some(0.0),
    // rust: _ => None,
}
}

/// Who rides what this tick (`Entity.getPassengers`, `isPassenger`).
pub const Riding = struct {
    /// Each vehicle's passengers, in order.
    passengers: crate::fast_hash::FxHashMap<i32,
    /// Each passenger's vehicle.
    vehicle: crate::fast_hash::FxHashMap<i32,
};

    // rust: impl Riding {
pub fn clear(self: *Self) void {
}
    // rust: self.passengers.clear();
    // rust: self.vehicle.clear();
}
    /// `passenger` rides `vehicle`, after the ones already riding it.
pub fn add(self: *Self, vehicle: i32, passenger: i32) void {
}
    // rust: self.passengers.entry(vehicle).or_default().push(passenger);
    // rust: self.vehicle.insert(passenger, vehicle);
}
pub fn passengers(self: *Self, id: i32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.passengers.get(&id).map_or(&[], Vec::as_slice)
}
pub fn set_passengers(self: *Self, vehicle: i32) p {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: play::Clientbound::SetPassengers(SetPassengers {
    // rust: vehicle,
    // rust: passengers: self.passengers(vehicle).to_vec(),
    // rust: })
}
}

/// What a level's clients were last told about one entity (ServerEntity's
/// fields), shared by every client that tracks it.
pub const ServerEntity = struct {
    /// What the mods hear of it when a client starts or stops tracking it.
    tracked: *Tracked,
    /// The registry id of its type (None: a type the clients don't know,
    /// never paired).
    kind: ?i32,
    /// The type's tracking range in chunks, update interval (0: never),
    /// whether velocity is tracked, whether it is an `AbstractArrow` and its
    /// `AbstractHurtingProjectile.accelerationPower`.
    range: i32,
    interval: u32,
    track_deltas: bool,
    arrow: bool,
    power: ?f64,
    /// VecDeltaCodec's base: the last position sent.
    base: [f64,
    /// lastSentYRot / lastSentXRot / lastSentYHeadRot.
    rotation: (i8,
    head: i8,
    /// lastSentMovement.
    velocity: [f64,
    /// NewMinecartBehavior.lerpSteps accumulated across tracking intervals.
    minecart_steps: std.ArrayList(play::MinecartStep),
    /// trackedDataValues: the entity data the clients hold.
    meta: Vec<(u8,
    equipment: Vec<(u8,
    /// The attribute instances the clients hold.
    attributes: std.ArrayList(AttributeSnapshot),
    was_on_ground: bool,
    tick: u32,
    teleport_delay: u32,
    /// lastPassengers, and wasRiding: a passenger's position isn't synced,
    /// and the first update after it dismounts is a full position sync.
    passengers: std.ArrayList(i32),
    was_riding: bool,
    /// The lead's holder the clients were told of.
    leash: ?i32,
    /// The level tick it was last seen in, its place in that tick's list, and
    /// whether it was added in it (its first update is the next tick's, but
    /// for one in `Entities::synced`).
    seen: u32,
    index: usize,
    added: bool,
    /// TrackedEntity.lastSectionPos: its pairs are checked again when it
    /// moves to another section.
    section: [i32,
    /// Whether it was a spectator last tick: its pairs are checked again when
    /// that changes, as `ServerPlayer.broadcastToPlayer` answers otherwise.
    spectator: bool,
    /// Likewise for a spectator who watches through a camera.
    watching: bool,
    /// Likewise for a player a native mod hid.
    hidden: ?u8,
};

/// SectionPos.of(entity).
pub fn section_of(position: [f64; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: position.map(|v| (v.floor() as i32) >> 4)
}

/// VecDeltaCodec.encode.
pub fn encode(v: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_core::jmath::round(v * 4096.0)
}

/// `ServerEntity.isFullPrecisionEncodingRequired`: an item whose last move was
/// stopped by a block rests where the collision solver left it, which is not on
/// the 1/4096 grid a delta decodes to; vanilla sends its exact position instead.
/// The axis pairs are vanilla's own: a vertical stop looks at x and z, a
/// horizontal one at z and x.
pub fn full_precision_required(e: *EntityState, delta: [i64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if e.kind != "minecraft:item" {
    // rust: return false;
}
    // rust: let loss = |v: f64| encode(v) as f64 / 4096.0 - v;
    // rust: let vertical =
    // rust: delta[0] != 0 && loss(e.position[0]) != 0.0 || delta[2] != 0 && loss(e.position[2]) != 0.0;
    // rust: let horizontal =
    // rust: delta[0] != 0 && loss(e.position[2]) != 0.0 || delta[2] != 0 && loss(e.position[0]) != 0.0;
    // rust: e.vertical_collision && vertical || e.horizontal_collision && horizontal
}

    // rust: impl ServerEntity {
    /// `new ServerEntity`: the entity as it is when it joins the level.
pub fn new(e: *EntityState, kind: ?i32, riding: *Riding) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (range, interval, track_deltas) = tracking::settings(&e.kind);
    // rust: Self {
    // rust: tracked: Arc::new(Tracked {
    // rust: uuid: e.uuid,
    // rust: kind: Arc::from(e.kind.as_str()),
    // rust: }),
    // rust: kind,
    // rust: range: i32::from(range),
    // rust: interval,
    // rust: track_deltas,
    // rust: arrow: is_arrow(&e.kind),
    // rust: power: acceleration_power(&e.kind),
    // rust: base: e.position,
    // rust: rotation: (pack_degrees(e.pitch), pack_degrees(e.yaw)),
    // rust: head: pack_degrees(e.head_yaw),
    // rust: velocity: e.velocity,
    // rust: minecart_steps: e.minecart_steps.clone().unwrap_or_default(),
    // rust: meta: e.meta.clone(),
    // rust: equipment: e.equipment.clone(),
    // rust: attributes: e.attributes.clone(),
    // rust: was_on_ground: e.on_ground,
    // rust: tick: 0,
    // rust: teleport_delay: 0,
    // rust: passengers: riding.passengers(e.id).to_vec(),
    // rust: was_riding: false,
    // rust: leash: e.leash,
    // rust: seen: 0,
    // rust: index: 0,
    // rust: added: true,
    // rust: section: section_of(e.position),
    // rust: spectator: e.spectator,
    // rust: watching: e.watching,
    // rust: hidden: e.hidden,
}
}

    /// ServerEntity.sendPairingData: the packets that introduce the entity
    /// to a client that starts tracking it.
    // rust: fn pairing(
    // rust: &self,
    // rust: e: &EntityState,
    // rust: kind: i32,
    // rust: riding: &Riding,
    // rust: out: &mut Vec<play::Clientbound>,
    // rust: ) {
    // rust: out.push(play::Clientbound::AddEntity(AddEntity {
    // rust: id: e.id,
    // rust: uuid: e.uuid,
    // rust: kind,
    // rust: position: e.position,
    // rust: velocity: e.velocity,
    // rust: pitch: pack_degrees(e.pitch),
    // rust: yaw: pack_degrees(e.yaw),
    // rust: head_yaw: pack_degrees(e.head_yaw),
    // rust: data: e.data,
    // rust: }));
    // rust: if !self.meta.is_empty() {
    // rust: out.push(play::Clientbound::SetEntityData(SetEntityData {
    // rust: id: e.id,
    // rust: values: self.meta.clone(),
    // rust: }));
}
        // getSyncableAttributes: the instances as they are now.
    // rust: if !e.attributes.is_empty() {
    // rust: out.push(play::Clientbound::UpdateAttributes(UpdateAttributes {
    // rust: id: e.id,
    // rust: values: e.attributes.clone(),
    // rust: }));
}
    // rust: if !self.equipment.is_empty() {
    // rust: out.push(play::Clientbound::SetEquipment(SetEquipment {
    // rust: id: e.id,
    // rust: slots: self.equipment.clone(),
    // rust: }));
}
    // rust: if !riding.passengers(e.id).is_empty() {
    // rust: out.push(riding.set_passengers(e.id));
}
    // rust: if let Some(&vehicle) = riding.vehicle.get(&e.id) {
    // rust: out.push(riding.set_passengers(vehicle));
}
        // A leashed entity: who holds its lead.
    // rust: if let Some(dest) = e.leash {
    // rust: out.push(play::Clientbound::SetEntityLink(SetEntityLink {
    // rust: source: e.id,
    // rust: dest,
    // rust: }));
}
}

    /// Changes since the last update (ServerEntity.sendChanges): movement and
    /// rotation every update interval (positions at least every 60 ticks, a
    /// full position sync every 400 or when the entity lands or leaves the
    /// ground), velocity for types that track it, changed data at once.
pub fn send_changes(self: *Self, e: *EntityState, riding: *Riding, out: *mut std.ArrayList(play::Clientbound)) void {
}
    // rust: if let Some(steps) = &e.minecart_steps {
    // rust: self.minecart_steps.extend_from_slice(steps);
    // rust: } else {
    // rust: self.minecart_steps.clear();
}
    // rust: let passengers = riding.passengers(e.id);
    // rust: if passengers != self.passengers.as_slice() {
    // rust: out.push(riding.set_passengers(e.id));
    // rust: self.passengers.clear();
    // rust: self.passengers.extend_from_slice(passengers);
}
    // rust: self.send_leash(e, out);
        // SynchedEntityData.isDirty: once for every client.
    // rust: let dirty = e.meta != self.meta;
    // rust: let due = self.interval != 0 && self.tick.is_multiple_of(self.interval);
    // rust: if due || dirty || e.needs_sync {
    // rust: let rotation = (pack_degrees(e.pitch), pack_degrees(e.yaw));
    // rust: let turned = |a: i8, b: i8| (i32::from(a) - i32::from(b)).abs() >= 1;
    // rust: let rotate = self.arrow
    // rust: || turned(rotation.1, self.rotation.1)
    // rust: || turned(rotation.0, self.rotation.0);
    // rust: if riding.vehicle.contains_key(&e.id) {
                // A passenger: its rotation alone (its vehicle places it).
    // rust: if rotate {
    // rust: out.push(play::Clientbound::MoveEntityRot(MoveEntityRot(
    // rust: MoveEntity {
    // rust: id: e.id,
    // rust: delta: None,
    // rust: rotation: Some((rotation.1, rotation.0)),
    // rust: on_ground: e.on_ground,
    // rust: },
    // rust: )));
    // rust: self.rotation = rotation;
}
    // rust: self.base = e.position;
    // rust: self.was_riding = true;
    // rust: self.send_dirty(e, dirty, out);
    // rust: self.send_head(e, out);
    // rust: self.tick += 1;
    // rust: self.send_equipment(e, out);
    // rust: return;
}
    // rust: if e.minecart_steps.is_some() {
    // rust: self.send_dirty(e, dirty, out);
    // rust: self.send_minecart(e, rotation, rotate, out);
    // rust: self.send_head(e, out);
    // rust: self.tick += 1;
    // rust: self.send_equipment(e, out);
    // rust: return;
}
    // rust: self.teleport_delay += 1;
    // rust: let d: f64 = (0..3).map(|k| (e.position[k] - self.base[k]).powi(2)).sum();
    // rust: let send_position = self.arrow || d >= 7.629_394_5e-6 || self.tick.is_multiple_of(60);
    // rust: let sync = EntityPositionSync {
    // rust: id: e.id,
    // rust: path: PositionPath::Linear(e.position),
    // rust: yaw: e.yaw,
    // rust: pitch: e.pitch,
    // rust: on_ground: e.on_ground,
}
            // ServerEntity.createMovePacket.
    // rust: let packet = if e.precise
    // rust: || self.teleport_delay > 400
    // rust: || self.was_riding
    // rust: || self.was_on_ground != e.on_ground
    // rust: {
    // rust: self.was_on_ground = e.on_ground;
    // rust: self.teleport_delay = 0;
    // rust: self.was_riding = false;
    // rust: Some(play::Clientbound::EntityPositionSync(sync))
    // rust: } else if send_position {
    // rust: let delta = [0, 1, 2].map(|k| encode(e.position[k]) - encode(self.base[k]));
    // rust: if delta.iter().any(|v| i16::try_from(*v).is_err())
    // rust: || full_precision_required(e, delta)
    // rust: {
    // rust: Some(play::Clientbound::EntityPositionSync(sync))
    // rust: } else {
    // rust: let m = MoveEntity {
    // rust: id: e.id,
    // rust: delta: Some(VecDelta::Linear(delta.map(|v| v as i16))),
    // rust: rotation: rotate.then_some((rotation.1, rotation.0)),
    // rust: on_ground: e.on_ground,
}
    // rust: Some(if rotate {
    // rust: play::Clientbound::MoveEntityPosRot(MoveEntityPosRot(m))
    // rust: } else {
    // rust: play::Clientbound::MoveEntityPos(MoveEntityPos(m))
    // rust: })
}
    // rust: } else if rotate {
    // rust: Some(play::Clientbound::MoveEntityRot(MoveEntityRot(
    // rust: MoveEntity {
    // rust: id: e.id,
    // rust: delta: None,
    // rust: rotation: Some((rotation.1, rotation.0)),
    // rust: on_ground: e.on_ground,
    // rust: },
    // rust: )))
    // rust: } else {
    // rust: None
}
    // rust: if self.track_deltas || e.needs_sync {
    // rust: let diff: f64 = (0..3)
    // rust: .map(|k| (e.velocity[k] - self.velocity[k]).powi(2))
    // rust: .sum();
    // rust: let still = e.velocity.iter().all(|v| *v == 0.0);
    // rust: if diff > 1.0e-7 || diff > 0.0 && still {
    // rust: self.velocity = e.velocity;
    // rust: let motion = play::Clientbound::SetEntityMotion(SetEntityMotion {
    // rust: id: e.id,
    // rust: velocity: e.velocity,
    // rust: });
    // rust: match self.power {
                        // A bundle: the motion and the projectile's power.
    // rust: Some(power) => out.extend([
    // rust: play::Clientbound::BundleDelimiter(horizon_protocol::packets::Empty),
    // rust: motion,
    // rust: play::Clientbound::ProjectilePower(play::ProjectilePower {
    // rust: id: e.id,
    // rust: power,
    // rust: }),
    // rust: play::Clientbound::BundleDelimiter(horizon_protocol::packets::Empty),
    // rust: ]),
    // rust: None => out.push(motion),
}
}
}
    // rust: if let Some(packet) = packet {
    // rust: let (position, rotated) = match &packet {
    // rust: play::Clientbound::EntityPositionSync(_)
    // rust: | play::Clientbound::MoveEntityPosRot(_) => (true, true),
    // rust: play::Clientbound::MoveEntityPos(_) => (true, false),
    // rust: _ => (false, true),
}
    // rust: out.push(packet);
    // rust: if position {
    // rust: self.base = e.position;
}
    // rust: if rotated {
    // rust: self.rotation = rotation;
}
}
    // rust: self.send_dirty(e, dirty, out);
    // rust: self.send_head(e, out);
}
    // rust: self.tick += 1;
    // rust: self.send_equipment(e, out);
}

    /// Leashable.setLeashedTo / dropLeash: sendToTrackingPlayers at once.
pub fn send_leash(self: *Self, e: *EntityState, out: *mut std.ArrayList(play::Clientbound)) void {
}
    // rust: if e.leash != self.leash {
    // rust: out.push(play::Clientbound::SetEntityLink(SetEntityLink {
    // rust: source: e.id,
    // rust: dest: e.leash.unwrap_or(0),
    // rust: }));
    // rust: self.leash = e.leash;
}
}

    /// ServerEntity.handleMinecartPosRot: send every recorded substep in order.
    /// Only an empty queue uses the fallback endpoint (e.g. a stationary cart
    /// teleported by a command); this never replaces a curved track's steps.
    // rust: fn send_minecart(
    // rust: &mut self,
    // rust: e: &EntityState,
    // rust: rotation: (i8, i8),
    // rust: rotate: bool,
    // rust: out: &mut Vec<play::Clientbound>,
    // rust: ) {
    // rust: if self.minecart_steps.is_empty() {
    // rust: let distance: f64 = (0..3).map(|k| (e.position[k] - self.base[k]).powi(2)).sum();
    // rust: let motion: f64 = (0..3)
    // rust: .map(|k| (e.velocity[k] - self.velocity[k]).powi(2))
    // rust: .sum();
    // rust: if distance >= 7.629_394_531_25e-6
    // rust: || self.tick.is_multiple_of(60)
    // rust: || rotate
    // rust: || motion > 1.0e-7
    // rust: {
    // rust: self.minecart_steps.push(play::MinecartStep {
    // rust: position: e.position,
    // rust: movement: e.velocity,
    // rust: yaw: rotation.1,
    // rust: pitch: rotation.0,
    // rust: weight: 1.0,
    // rust: });
}
}
    // rust: if !self.minecart_steps.is_empty() {
    // rust: out.push(play::Clientbound::MoveMinecartAlongTrack(
    // rust: play::MoveMinecartAlongTrack {
    // rust: id: e.id,
    // rust: steps: std::mem::take(&mut self.minecart_steps),
    // rust: },
    // rust: ));
}
        // Vanilla updates these even when no packet was needed; its
        // lastSentMovement is deliberately unchanged in this branch.
    // rust: self.rotation = rotation;
    // rust: self.base = e.position;
}

    /// ServerEntity.sendDirtyEntityData: the changed entity data, then the
    /// attribute instances that changed since they were last sent
    /// (`AttributeMap.getAttributesToSync`).
pub fn send_dirty(self: *Self, e: *EntityState, dirty: bool, out: *mut std.ArrayList(play::Clientbound)) void {
}
    // rust: if dirty {
    // rust: let mut changed: Vec<_> = e
    // rust: .meta
    // rust: .iter()
    // rust: .filter(|m| !self.meta.contains(m))
    // rust: .cloned()
    // rust: .collect();
            // A value back at its default is left out of the state, but the
            // clients still hold the old one: Entity's shared flags and pose go
            // back to 0 (a player standing up again, a mob no longer on fire),
            // a sleeper's bed to none, an item frame's item to empty and its
            // rotation to 0 (ItemFrame.DATA_ITEM and DATA_ROTATION).
    // rust: let frame = e.kind.ends_with("item_frame");
    // rust: for (index, kind, _) in &self.meta {
    // rust: let default = match (*index, *kind) {
    // rust: (0, serializer::BYTE) => Value::Byte(0),
    // rust: (6, serializer::POSE) => Value::Id(0),
    // rust: (14, serializer::OPTIONAL_BLOCK_POS) => Value::OptPos(None),
    // rust: (9, serializer::ITEM_STACK) if frame => Value::Item(None),
    // rust: (10, serializer::INT) if frame => Value::Int(0),
    // rust: _ => match e.defaults.iter().find(|d| (d.0, d.1) == (*index, *kind)) {
    // rust: Some(d) => d.2.clone(),
    // rust: None => continue,
    // rust: },
}
    // rust: if !e.meta.iter().any(|m| m.0 == *index) {
    // rust: changed.push((*index, *kind, default));
}
}
    // rust: if !changed.is_empty() {
    // rust: out.push(play::Clientbound::SetEntityData(SetEntityData {
    // rust: id: e.id,
    // rust: values: changed,
    // rust: }));
}
    // rust: self.meta.clone_from(&e.meta);
}
    // rust: if e.attributes != self.attributes {
    // rust: let changed = changed_attributes(&e.attributes, &self.attributes);
    // rust: if !changed.is_empty() {
    // rust: out.push(play::Clientbound::UpdateAttributes(UpdateAttributes {
    // rust: id: e.id,
    // rust: values: changed,
    // rust: }));
}
    // rust: self.attributes.clone_from(&e.attributes);
}
}

pub fn send_head(self: *Self, e: *EntityState, out: *mut std.ArrayList(play::Clientbound)) void {
}
    // rust: let head = pack_degrees(e.head_yaw);
    // rust: if (i32::from(head) - i32::from(self.head)).abs() >= 1 {
    // rust: out.push(play::Clientbound::RotateHead(RotateHead {
    // rust: id: e.id,
    // rust: head_yaw: head,
    // rust: }));
    // rust: self.head = head;
}
}

    /// LivingEntity.detectEquipmentUpdates: changed slots every tick.
pub fn send_equipment(self: *Self, e: *EntityState, out: *mut std.ArrayList(play::Clientbound)) void {
}
    // rust: if e.equipment != self.equipment {
            // Cleared slots are sent as empty stacks.
    // rust: let mut slots: Vec<(u8, Option<Stack>)> = e
    // rust: .equipment
    // rust: .iter()
    // rust: .filter(|m| !self.equipment.contains(m))
    // rust: .cloned()
    // rust: .collect();
    // rust: for (slot, _) in &self.equipment {
    // rust: if !e.equipment.iter().any(|(k, _)| k == slot) {
    // rust: slots.push((*slot, None));
}
}
    // rust: if !slots.is_empty() {
    // rust: out.push(play::Clientbound::SetEquipment(SetEquipment {
    // rust: id: e.id,
    // rust: slots,
    // rust: }));
}
    // rust: self.equipment.clone_from(&e.equipment);
}
}
}

/// An entity a client tracks, as the mods hear of it.
pub const Tracked = struct {
    uuid: u128,
    /// Its type's registry id (`minecraft:zombie`).
    kind: *str,
};

/// A client started or stopped tracking an entity (`ServerEntity.addPairing`
/// and `removePairing`).
pub const TrackEvent = struct {
    start: bool,
    entity: i32,
    tracked: *Tracked,
};

/// The entities one client tracks (`TrackedEntity.seenBy`, from the
/// client's side), and what started and stopped since the game last took
/// the events.
pub const Tracker = struct {
    seen: crate::fast_hash::FxHashMap<i32,
    events: std.ArrayList(TrackEvent),
};

    // rust: impl Tracker {
pub fn is_tracking(self: *Self, id: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.seen.contains_key(&id)
}
pub fn ids(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.seen.keys().copied().collect()
}
    /// Stop tracking everything without a packet: the caller removes them
    /// from the client.
pub fn clear(self: *Self) void {
}
    // rust: let events = &mut self.events;
    // rust: events.extend(self.seen.drain().map(|(entity, tracked)| TrackEvent {
    // rust: start: false,
    // rust: entity,
    // rust: tracked,
    // rust: }));
}
    /// Stop tracking `id` without a packet: the caller removes it from the
    /// client, and the next tick pairs it again if it is still in range.
pub fn forget(self: *Self, id: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(tracked) = self.seen.remove(&id) else {
    // rust: return false;
}
    // rust: self.events.push(TrackEvent {
    // rust: start: false,
    // rust: entity: id,
    // rust: tracked,
    // rust: });
    // rust: true
}
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.seen.len()
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.seen.is_empty()
}
    /// The starts and stops since the last call, in order.
pub fn take_events(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.events)
}
}

/// Who a level's entities are tracked by this tick: a client's position,
/// view distance and chunks.
pub const Viewer = struct {
    entity_id: i32,
    /// Its player is in spectator mode: it tracks the other spectators too.
    spectator: bool,
    /// Its player's permission level: players a native mod hid from lower
    /// levels are not tracked by it.
    permission: u8,
    /// It accepted a move since the last tick (ChunkMap.move): every pair
    /// of it is checked again.
    moved: bool,
    position: [f64,
    view_distance: i32,
    chunks: *'a crate::fast_hash::FxHashSet<(i32,
    tracker: *'a mut Tracker,
    /// What the tick sends it, in order.
    out: *'a mut std.ArrayList(Vec<u8)>,
    /// Where the entities it stops tracking were last sent, when asked (the prediction's replay).
    gone: Option<*'a mut Vec<[f64,
};

/// One entity as this tick's range checks read it: where it is
/// horizontally, its id, its tracking range in blocks (scaled by
/// `entity-broadcast-range-percentage`) and the chunk it is in (an index
/// into the tick's chunks).
pub const Probe = struct {
    x: f64,
    z: f64,
    id: i32,
    range: i32,
    chunk: u32,
    spectator: bool,
    watching: bool,
    hidden: ?u8,
};

/// `ServerPlayer.broadcastToPlayer` (`Entity`'s is `true`): to a spectator,
/// a player is shown only while its camera is itself; to anyone else, a
/// spectator is hidden. A player a native mod hid is shown only to players
/// of at least its level.
pub fn broadcast_to_player(v: *Viewer, p: *Probe) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shown = if v.spectator {
    // rust: !p.watching
    // rust: } else {
    // rust: !p.spectator
}
    // rust: shown && p.hidden.is_none_or(|level| v.permission >= level)
}

/// TrackedEntity.updatePlayer: within the type's range (capped by the view
/// distance) horizontally, shown to the client (`Entity.broadcastToPlayer`:
/// `ServerPlayer`'s hides a spectator from players who are not spectators;
/// a guest's camera is always its own player, so a spectating client sees
/// every player) and in a chunk the client has. `held` remembers for
/// each of the tick's chunks whether the client has it (0: not looked up
/// yet, 1: no, 2: yes), so each chunk is looked up once per client.
pub fn sees(v: *Viewer, p: *Probe, chunks: *[(i32) void {
}
    // rust: let range = f64::from(p.range.min(v.view_distance * 16));
    // rust: let (dx, dz) = (v.position[0] - p.x, v.position[2] - p.z);
    // rust: dx * dx + dz * dz <= range * range && broadcast_to_player(v, p) && {
    // rust: let held = &mut held[p.chunk as usize];
    // rust: if *held == 0 {
    // rust: *held = 1 + u8::from(v.chunks.contains(&chunks[p.chunk as usize]));
}
    // rust: *held == 2
}
}

/// One level's tracked entities (ChunkMap.entityMap).
pub const Entities = struct {
    /// `entity-broadcast-range-percentage` (None: 100), which scales every
    /// type's tracking range (MinecraftServer.getScaledTrackingDistance).
    range_percent: ?i32,
    /// ServerLevel.tick runs ChunkMap.tick after the block ticks, the raids
    /// and ServerChunkCache.tickChunks' spawning and thunder, and before the
    /// entities: an entity that joined the level by then (ids in these
    /// ranges, each from after its first number up to its second; a player
    /// aside) has its first update in the pass that pairs it, before it
    /// moves. One the entities' own ticks added waits for the next pass, as
    /// vanilla's waits for the next tick.
    synced: Vec<(i32,
    states: crate::fast_hash::FxHashMap<i32,
    /// The level tick, stamped on every entity still in the level.
    tick: u32,
    /// This tick's entities as the range checks read them, the chunks they
    /// are in (and each one's index), whether the client being checked has
    /// each chunk, and what each client makes of each entity ([`SEES`],
    /// [`TRACKS`]), kept between ticks.
    probes: std.ArrayList(Probe),
    chunks: Vec<(i32,
    chunk_index: crate::fast_hash::FxHashMap<(i32,
    /// The entities in each of `chunks` (indices into `probes`): a client
    /// that moved checks only the chunks within its view distance.
    chunk_members: std.ArrayList(Vec<u32)>,
    held: std.ArrayList(u8),
    flags: std.ArrayList(Vec<u8)>,
    /// Whether a client starts tracking each entity this tick.
    pairs: std.ArrayList(bool),
    /// The entities that appeared or moved to another section this tick
    /// (their pairs with every client are checked again), in order and as a
    /// flag per entity.
    moved: std.ArrayList(usize),
    is_moved: std.ArrayList(bool),
    /// One entity's packets and their bodies, kept between entities.
    packets: std.ArrayList(play::Clientbound),
    bodies: std.ArrayList(Vec<u8)>,
};

/// The client sees the entity this tick, and already tracked it.
pub const SEES: u8 = 1;
pub const TRACKS: u8 = 2;

pub fn encode_all(packets: *[play::Clientbound], bodies: *mut std.ArrayList(Vec<u8)>) void {
}
    // rust: bodies.clear();
    // rust: bodies.extend(packets.iter().map(play::Clientbound::encode));
}

    // rust: impl Entities {
    /// `ChunkMap.addEntity` after this tick's tracking pass: pair now without
    /// running sendChanges or advancing either clock. The first sendChanges
    /// belongs to the next pass, including for an arrow that lands meanwhile.
    // rust: pub fn pair_after_tick(
    // rust: &mut self,
    // rust: entities: &[EntityState],
    // rust: riding: &Riding,
    // rust: viewers: &mut [Viewer],
    // rust: mut kind: impl FnMut(&str) -> Option<i32>,
    // rust: ) {
    // rust: for e in entities {
    // rust: if self.states.contains_key(&e.id) {
    // rust: continue;
}
    // rust: let mut s = ServerEntity::new(e, kind(&e.kind), riding);
    // rust: s.seen = self.tick;
            // Pairing has already happened by the time the next pass runs.
    // rust: s.added = false;
    // rust: let mut range = s.range;
    // rust: let mut pending = riding.passengers(e.id).to_vec();
    // rust: while let Some(id) = pending.pop() {
    // rust: if let Some(passenger) = self.states.get(&id) {
    // rust: range = range.max(passenger.range);
    // rust: } else if let Some(passenger) = entities.iter().find(|p| p.id == id) {
    // rust: range = range.max(i32::from(tracking::settings(&passenger.kind).0));
}
    // rust: pending.extend_from_slice(riding.passengers(id));
}
    // rust: let probe = Probe {
    // rust: x: e.position[0],
    // rust: z: e.position[2],
    // rust: id: e.id,
    // rust: range: self
    // rust: .range_percent
    // rust: .map_or(range * 16, |p| p * (range * 16) / 100),
    // rust: chunk: 0,
    // rust: spectator: e.spectator,
    // rust: watching: e.watching,
    // rust: hidden: e.hidden,
}
    // rust: let chunks = [(
    // rust: (e.position[0].floor() as i32) >> 4,
    // rust: (e.position[2].floor() as i32) >> 4,
    // rust: )];
    // rust: let mut bodies = None;
    // rust: for v in &mut *viewers {
    // rust: if v.entity_id == e.id
    // rust: || v.tracker.is_tracking(e.id)
    // rust: || !sees(v, &probe, &chunks, &mut [0])
    // rust: {
    // rust: continue;
}
    // rust: let Some(kind) = s.kind else {
    // rust: continue;
}
    // rust: let bodies = bodies.get_or_insert_with(|| {
    // rust: let mut packets = Vec::new();
    // rust: s.pairing(e, kind, riding, &mut packets);
    // rust: packets
    // rust: .iter()
    // rust: .map(play::Clientbound::encode)
    // rust: .collect::<Vec<_>>()
    // rust: });
    // rust: v.out.extend(bodies.iter().cloned());
    // rust: v.tracker.seen.insert(e.id, Arc::clone(&s.tracked));
    // rust: v.tracker.events.push(TrackEvent {
    // rust: start: true,
    // rust: entity: e.id,
    // rust: tracked: Arc::clone(&s.tracked),
    // rust: });
}
    // rust: self.states.insert(e.id, s);
}
}

pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.states.len()
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.states.is_empty()
}

    /// How many passes the level's tracking has run.
pub fn ticks(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tick
}

    /// Whether the entity `id` is tracked (it was in the last tick's pass).
pub fn tracks(self: *Self, id: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.states.contains_key(&id)
}

    /// ChunkMap.addEntity tracks an entity as it joins the level, so its
    /// clients are paired with it as it was then. An entity the game added
    /// after the last tick's states were taken is first seen a tick later:
    /// it starts from the state it joined with (`joined`), not from where
    /// its first tick took it. Of the joined states, those of entities still
    /// in the level and not tracked yet are kept, with what this tick's own
    /// state carries for this tick alone (the minecart steps drained into it,
    /// `needs_sync`).
    // rust: pub fn joined_states(
    // rust: &self,
    // rust: entities: &[&EntityState],
    // rust: mut joined: Vec<EntityState>,
    // rust: ) -> crate::fast_hash::FxHashMap<i32, EntityState> {
    // rust: if joined.is_empty() {
    // rust: return Default::default();
}
    // rust: let now: crate::fast_hash::FxHashMap<i32, &EntityState> = entities
    // rust: .iter()
    // rust: .filter(|e| !self.tracks(e.id))
    // rust: .map(|e| (e.id, *e))
    // rust: .collect();
    // rust: joined
    // rust: .drain(..)
    // rust: .filter_map(|mut j| {
    // rust: let e = now.get(&j.id)?;
    // rust: j.minecart_steps.clone_from(&e.minecart_steps);
    // rust: j.needs_sync = e.needs_sync;
    // rust: Some((j.id, j))
    // rust: })
    // rust: .collect()
}

    /// Puts the `joined_states` in place of this tick's own.
    // rust: pub fn starting_from<'a>(
    // rust: entities: &mut [&'a EntityState],
    // rust: joined: &'a crate::fast_hash::FxHashMap<i32, EntityState>,
    // rust: ) {
    // rust: if joined.is_empty() {
    // rust: return;
}
    // rust: for e in entities.iter_mut() {
    // rust: if let Some(j) = joined.get(&e.id) {
    // rust: *e = j;
}
}
}

    /// One tick of ChunkMap.tick for the entities in the level now and the
    /// clients in it: each client first loses the entities that left its
    /// range or the level (one ClientboundRemoveEntitiesPacket), then each
    /// entity's changes are made once and go to every client tracking it,
    /// and the clients that start tracking it are paired with it. A client
    /// never tracks its own entity. `kind` names a type's registry id.
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: entities: &[&EntityState],
    // rust: riding: &Riding,
    // rust: viewers: &mut [Viewer],
    // rust: mut kind: impl FnMut(&str) -> Option<i32>,
    // rust: ) {
    // rust: self.tick = self.tick.wrapping_add(1);
    // rust: let now = self.tick;
    // rust: self.probes.clear();
    // rust: self.chunks.clear();
    // rust: self.chunk_index.clear();
    // rust: for members in &mut self.chunk_members {
    // rust: members.clear();
}
    // rust: self.moved.clear();
    // rust: self.is_moved.clear();
    // rust: self.is_moved.resize(entities.len(), false);
    // rust: for (index, e) in entities.iter().enumerate() {
    // rust: let mut added = false;
    // rust: let s = self.states.entry(e.id).or_insert_with(|| {
    // rust: added = true;
    // rust: ServerEntity::new(e, kind(&e.kind), riding)
    // rust: });
    // rust: s.seen = now;
    // rust: s.index = index;
            // ChunkMap.addEntity, ChunkMap.tick's section change, and a
            // player going in or out of spectator mode (which ChunkMap.move
            // catches at the player's next move, a second later at most):
            // updatePlayers.
    // rust: let section = section_of(e.position);
    // rust: if added
    // rust: || section != s.section
    // rust: || e.spectator != s.spectator
    // rust: || e.watching != s.watching
    // rust: || e.hidden != s.hidden
    // rust: {
    // rust: s.section = section;
    // rust: s.spectator = e.spectator;
    // rust: s.watching = e.watching;
    // rust: s.hidden = e.hidden;
    // rust: self.moved.push(index);
    // rust: self.is_moved[index] = true;
}
    // rust: let at = (
    // rust: (e.position[0].floor() as i32) >> 4,
    // rust: (e.position[2].floor() as i32) >> 4,
    // rust: );
    // rust: let next = self.chunks.len() as u32;
    // rust: let chunk = *self.chunk_index.entry(at).or_insert(next);
    // rust: if chunk == next {
    // rust: self.chunks.push(at);
    // rust: if self.chunk_members.len() == chunk as usize {
    // rust: self.chunk_members.push(Vec::new());
}
}
    // rust: self.chunk_members[chunk as usize].push(index as u32);
    // rust: self.probes.push(Probe {
    // rust: x: e.position[0],
    // rust: z: e.position[2],
    // rust: id: e.id,
    // rust: range: self
    // rust: .range_percent
    // rust: .map_or(s.range * 16, |p| p * (s.range * 16) / 100),
    // rust: chunk,
    // rust: spectator: e.spectator,
    // rust: watching: e.watching,
    // rust: hidden: e.hidden,
    // rust: });
}
        // TrackedEntity.getEffectiveRange: a vehicle is tracked as far as its
        // widest indirect passenger, so a rider never leaves before its mount.
    // rust: for (&vehicle, passengers) in &riding.passengers {
    // rust: let Some(own) = self.states.get(&vehicle).filter(|s| s.seen == now) else {
    // rust: continue;
}
    // rust: let (index, mut range) = (own.index, own.range);
    // rust: let mut pending = passengers.clone();
    // rust: while let Some(id) = pending.pop() {
    // rust: if let Some(s) = self.states.get(&id).filter(|s| s.seen == now) {
    // rust: range = range.max(s.range);
}
    // rust: pending.extend_from_slice(riding.passengers(id));
}
    // rust: self.probes[index].range = self
    // rust: .range_percent
    // rust: .map_or(range * 16, |p| p * (range * 16) / 100);
}
    // rust: self.flags.resize_with(viewers.len(), Vec::new);
    // rust: self.pairs.clear();
    // rust: self.pairs.resize(entities.len(), false);
    // rust: for (v, flags) in viewers.iter_mut().zip(&mut self.flags) {
    // rust: flags.clear();
    // rust: self.held.clear();
    // rust: self.held.resize(self.chunks.len(), 0);
    // rust: let (chunks, held, pairs) = (&self.chunks, &mut self.held, &mut self.pairs);
    // rust: let members = &self.chunk_members;
    // rust: let mut kept = 0;
            // A client that moved (ChunkMap.move), or whose own entity
            // appeared or changed section (ChunkMap.tick's movedPlayers), has
            // every pair checked again.
    // rust: let all = v.moved
    // rust: || self
    // rust: .states
    // rust: .get(&v.entity_id)
    // rust: .is_none_or(|s| s.seen != now || self.is_moved[s.index]);
    // rust: if all {
                // `sees` caps the range at its view distance, so only the
                // entities in chunks that far from its own can be seen; the
                // rest stay 0, as checking each of them gave.
    // rust: flags.resize(self.probes.len(), 0);
    // rust: let reach = v.view_distance + 1;
    // rust: let (vx, vz) = (
    // rust: (v.position[0].floor() as i32) >> 4,
    // rust: (v.position[2].floor() as i32) >> 4,
    // rust: );
    // rust: for (&(cx, cz), members) in chunks.iter().zip(members) {
    // rust: if (cx - vx).abs() > reach || (cz - vz).abs() > reach {
    // rust: continue;
}
    // rust: for &index in members {
    // rust: let index = index as usize;
    // rust: let p = &self.probes[index];
    // rust: if p.id == v.entity_id || !sees(v, p, chunks, held) {
    // rust: continue;
}
    // rust: if v.tracker.seen.contains_key(&p.id) {
    // rust: flags[index] = SEES | TRACKS;
    // rust: kept += 1;
    // rust: } else {
    // rust: flags[index] = SEES;
    // rust: pairs[index] = true;
}
}
}
    // rust: } else if v.tracker.seen.len() * 4 > self.probes.len() {
                // Otherwise its pairs stay as they were, but for the entities
                // that appeared or changed section; a client tracking much
                // of the level goes through it in order.
    // rust: let is_moved = &self.is_moved;
    // rust: flags.extend(self.probes.iter().zip(pairs.iter_mut()).zip(is_moved).map(
    // rust: |((p, pairs), &moved)| {
    // rust: let tracks = v.tracker.seen.contains_key(&p.id);
    // rust: if p.id == v.entity_id || (moved && !sees(v, p, chunks, held)) {
    // rust: 0
    // rust: } else if tracks {
    // rust: kept += 1;
    // rust: SEES | TRACKS
    // rust: } else if moved {
    // rust: *pairs = true;
    // rust: SEES
    // rust: } else {
    // rust: 0
}
    // rust: },
    // rust: ));
    // rust: } else {
                // One tracking little of it, from what it tracks.
    // rust: flags.resize(self.probes.len(), 0);
    // rust: for id in v.tracker.seen.keys() {
    // rust: if let Some(s) = self.states.get(id).filter(|s| s.seen == now) {
    // rust: flags[s.index] = SEES | TRACKS;
    // rust: kept += 1;
}
}
    // rust: for &index in &self.moved {
    // rust: let p = &self.probes[index];
    // rust: let tracks = flags[index] & TRACKS != 0;
    // rust: if p.id != v.entity_id && sees(v, p, chunks, held) {
    // rust: if !tracks {
    // rust: flags[index] = SEES;
    // rust: pairs[index] = true;
}
    // rust: } else if tracks {
    // rust: flags[index] = 0;
    // rust: kept -= 1;
}
}
}
            // Usually the client still sees all it tracks.
    // rust: let mut removed = Vec::new();
    // rust: if kept != v.tracker.seen.len() {
    // rust: let states = &self.states;
    // rust: let Tracker { seen, events } = &mut *v.tracker;
    // rust: seen.retain(|id, tracked| match states.get(id) {
    // rust: Some(s) if s.seen == now && flags[s.index] & TRACKS != 0 => true,
    // rust: other => {
    // rust: if let (Some(gone), Some(s)) = (v.gone.as_deref_mut(), other) {
    // rust: gone.push(s.base);
}
    // rust: removed.push(*id);
    // rust: events.push(TrackEvent {
    // rust: start: false,
    // rust: entity: *id,
    // rust: tracked: Arc::clone(tracked),
    // rust: });
    // rust: false
}
    // rust: });
}
    // rust: if !removed.is_empty() {
    // rust: v.out.push(
    // rust: play::Clientbound::RemoveEntities(play::RemoveEntities { ids: removed })
    // rust: .encode(),
    // rust: );
}
}
    // rust: for (index, e) in entities.iter().enumerate() {
    // rust: let Some(s) = self.states.get_mut(&e.id) else {
    // rust: continue;
}
    // rust: self.packets.clear();
            // Paired as it joined, then its first changes go to everyone
            // tracking it, those just paired with it included. Arrows wait for the
            // next tick's send_changes so impact updates (e.g. IN_GROUND) arrive after
            // the client's first tick (#7461).
    // rust: let synced = s.added
    // rust: && e.kind != "minecraft:player"
    // rust: && !s.arrow
    // rust: && self
    // rust: .synced
    // rust: .iter()
    // rust: .any(|&(after, through)| e.id > after && e.id <= through);
    // rust: if !s.added || synced {
                // ChunkMap.tick: sendChanges for an entity that changed
                // section, needs sync or is in entity-ticking range. An idle
                // one's update clock stands still and its changes wait.
    // rust: if e.idle && !self.is_moved[index] && !e.needs_sync {
    // rust: s.send_leash(e, &mut self.packets);
    // rust: } else {
    // rust: s.send_changes(e, riding, &mut self.packets);
}
}
    // rust: s.added = false;
            // Nothing to send: no changes, and nobody starts tracking it.
    // rust: if self.packets.is_empty() && !self.pairs[index] {
    // rust: continue;
}
    // rust: let mut encoded = false;
    // rust: let mut pairing: Option<Vec<Vec<u8>>> = None;
    // rust: for (v, flags) in viewers.iter_mut().zip(&self.flags) {
    // rust: let f = flags[index];
    // rust: if f & TRACKS != 0 {
    // rust: if self.packets.is_empty() {
    // rust: continue;
}
    // rust: if !encoded {
    // rust: encode_all(&self.packets, &mut self.bodies);
    // rust: encoded = true;
}
    // rust: v.out.extend(self.bodies.iter().cloned());
    // rust: } else if f & SEES != 0
    // rust: && !e.bare
    // rust: && let Some(kind) = s.kind
    // rust: {
    // rust: let bodies = pairing.get_or_insert_with(|| {
    // rust: let mut packets = Vec::new();
    // rust: s.pairing(e, kind, riding, &mut packets);
    // rust: packets.iter().map(play::Clientbound::encode).collect()
    // rust: });
    // rust: v.out.extend(bodies.iter().cloned());
    // rust: if synced && !self.packets.is_empty() {
    // rust: if !encoded {
    // rust: encode_all(&self.packets, &mut self.bodies);
    // rust: encoded = true;
}
    // rust: v.out.extend(self.bodies.iter().cloned());
}
    // rust: if v.tracker
    // rust: .seen
    // rust: .insert(e.id, Arc::clone(&s.tracked))
    // rust: .is_none()
    // rust: {
    // rust: v.tracker.events.push(TrackEvent {
    // rust: start: true,
    // rust: entity: e.id,
    // rust: tracked: Arc::clone(&s.tracked),
    // rust: });
}
}
}
}
    // rust: self.states.retain(|_, s| s.seen == now);
}
}

    // rust: mod late_pair_tests;

    // rust: mod tests {
//     use super::*;

pub fn encode_rounds_ties_toward_positive_infinity() void {
}
    // rust: assert_eq!(encode(-2.5 / 4096.0), -2);
    // rust: assert_eq!(encode(2.5 / 4096.0), 3);
}

pub fn state(x: f64) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: EntityState {
    // rust: id: 7,
    // rust: uuid: 1,
    // rust: kind: "minecraft:zombie".into(),
    // rust: position: [x, 64.0, 0.0],
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: head_yaw: 0.0,
    // rust: on_ground: true,
    // rust: velocity: [0.0; 3],
    // rust: minecart_steps: None,
    // rust: data: 0,
    // rust: meta: Vec::new(),
    // rust: defaults: Vec::new(),
    // rust: equipment: Vec::new(),
    // rust: attributes: Vec::new(),
    // rust: precise: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: needs_sync: false,
    // rust: idle: false,
    // rust: bare: false,
    // rust: leash: None,
    // rust: spectator: false,
    // rust: watching: false,
    // rust: hidden: None,
}
}

pub fn states_are_written_over_last_ticks_in_place() void {
}
    // rust: let mut states = States::default();
    // rust: let e = states.add(1, 1, "minecraft:zombie");
    // rust: e.position = [1.0, 2.0, 3.0];
    // rust: e.meta.push((9, serializer::FLOAT, Value::Float(20.0)));
    // rust: e.equipment.push((0, None));
    // rust: let (kind, meta) = (e.kind.as_ptr(), e.meta.as_ptr());
    // rust: states.push(state(2.0));
    // rust: states.clear();
    // rust: let e = states.add(3, 3, "minecraft:husk");
        // Nothing of the last tick's state is left, but its allocations are.
    // rust: let fresh = EntityState {
    // rust: id: 3,
    // rust: uuid: 3,
    // rust: kind: "minecraft:husk".into(),
    // rust: ..EntityState::default()
}
    // rust: assert_eq!(*e, fresh);
    // rust: assert_eq!((e.kind.as_ptr(), e.meta.as_ptr()), (kind, meta));
    // rust: assert_eq!(states.as_slice(), std::slice::from_ref(&fresh));
    // rust: states.extend([state(5.0), state(6.0)]);
    // rust: assert_eq!(states.as_slice(), [fresh, state(5.0), state(6.0)]);
}

    /// The entity as added this tick, then its updates (one a tick).
pub fn added(e: *EntityState) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ServerEntity::new(e, Some(100), &Riding::default())
}
pub fn changes(s: *mut ServerEntity, e: *EntityState) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: s.send_changes(e, &Riding::default(), &mut out);
    // rust: out
}

pub fn furnace_cart_sends_unpowered_metadata_when_fuel_runs_out() void {
}
    // rust: let mut powered = state(0.0);
    // rust: powered.kind = "minecraft:furnace_minecart".into();
    // rust: powered
    // rust: .defaults
    // rust: .push((13, serializer::BOOLEAN, Value::Bool(false)));
    // rust: powered
    // rust: .meta
    // rust: .push((13, serializer::BOOLEAN, Value::Bool(true)));
    // rust: let mut tracker = added(&powered);
    // rust: let mut empty = powered.clone();
    // rust: empty.meta.clear();
    // rust: let mut packets = Vec::new();
    // rust: tracker.send_dirty(&empty, true, &mut packets);
    // rust: assert!(packets.iter().any(|packet| matches!(packet,
    // rust: play::Clientbound::SetEntityData(data)
    // rust: if data.values.contains(&(13, serializer::BOOLEAN, Value::Bool(false)))
    // rust: )));
}

pub fn moves_go_out_every_update_interval() void {
}
    // rust: let mut s = added(&state(0.0));
    // rust: let mut spawn = Vec::new();
    // rust: s.pairing(&state(0.0), 100, &Riding::default(), &mut spawn);
    // rust: assert!(matches!(spawn[..], [play::Clientbound::AddEntity(_)]));
        // Tick 0 is due and a multiple of 60: the position goes out unchanged.
    // rust: assert!(matches!(
    // rust: changes(&mut s, &state(0.0))[..],
    // rust: [play::Clientbound::MoveEntityPos(_)]
    // rust: ));
        // A zombie updates every third tick.
    // rust: assert!(changes(&mut s, &state(0.5)).is_empty());
    // rust: assert!(changes(&mut s, &state(0.5)).is_empty());
    // rust: assert!(matches!(
    // rust: changes(&mut s, &state(0.5))[..],
    // rust: [play::Clientbound::MoveEntityPos(_)]
    // rust: ));
    // rust: for _ in 0..2 {
    // rust: changes(&mut s, &state(40.0));
}
    // rust: let jump = changes(&mut s, &state(40.0));
    // rust: assert!(matches!(jump[0], play::Clientbound::EntityPositionSync(_)));
}

pub fn a_knocked_back_mob_is_sent_at_once() void {
}
    // rust: let mut s = added(&state(0.0));
    // rust: changes(&mut s, &state(0.0));
        // Not due (tick 1 of 3), but LivingEntity.knockback set needsSync:
        // its move and its new motion go out now.
    // rust: let mut knocked = state(0.3);
    // rust: knocked.velocity = [0.2, 0.3, 0.0];
    // rust: knocked.needs_sync = true;
    // rust: let out = changes(&mut s, &knocked);
    // rust: assert!(
    // rust: matches!(
    // rust: out[..],
    // rust: [
    // rust: play::Clientbound::SetEntityMotion(_),
    // rust: play::Clientbound::MoveEntityPos(_)
    // rust: ]
    // rust: ),
    // rust: "{out:?}"
    // rust: );
        // Then every third tick again.
    // rust: assert!(changes(&mut s, &state(0.5)).is_empty());
    // rust: assert!(matches!(
    // rust: changes(&mut s, &state(0.6))[..],
    // rust: [
    // rust: play::Clientbound::SetEntityMotion(_),
    // rust: play::Clientbound::MoveEntityPos(_)
    // rust: ]
    // rust: ));
}

    /// `ServerEntity.getRequiresPrecisePosition` is false for an item, so a
    /// drop whose data has to be sent again still moves by a delta; only the
    /// collision case takes the exact-position packet.
pub fn an_item_that_needs_its_data_sent_again_still_moves_by_a_delta() void {
}
    // rust: let mut e = state(0.0);
    // rust: e.kind = "minecraft:item".into();
    // rust: e.position = [0.3, 64.0, 0.3];
    // rust: let mut s = added(&e);
    // rust: e.needs_sync = true;
    // rust: e.position = [0.7, 64.0, 0.3];
    // rust: assert!(matches!(
    // rust: changes(&mut s, &e)[..],
    // rust: [play::Clientbound::MoveEntityPos(_)]
    // rust: ));
}

pub fn fireballs_bundle_their_motion_with_their_power() void {
}
    // rust: let mut e = state(0.0);
    // rust: e.kind = "minecraft:fireball".into();
    // rust: e.on_ground = false;
    // rust: let mut s = added(&e);
    // rust: e.velocity = [0.0, 0.0, 0.5];
    // rust: let out = changes(&mut s, &e);
    // rust: assert!(matches!(
    // rust: out[..],
    // rust: [
    // rust: play::Clientbound::BundleDelimiter(_),
    // rust: play::Clientbound::SetEntityMotion(_),
    // rust: play::Clientbound::ProjectilePower(play::ProjectilePower { power, .. }),
    // rust: play::Clientbound::BundleDelimiter(_),
    // rust: play::Clientbound::MoveEntityPos(_),
    // rust: ] if power == 0.1
    // rust: ));
}

pub fn arrows_send_position_and_rotation_every_update() void {
}
    // rust: let mut e = state(0.0);
    // rust: e.kind = "minecraft:arrow".into();
    // rust: let mut s = added(&e);
    // rust: assert!(matches!(
    // rust: changes(&mut s, &e)[..],
    // rust: [play::Clientbound::MoveEntityPosRot(_)]
    // rust: ));
}

    /// `ServerEntity.isFullPrecisionEncodingRequired`: an item that came to
    /// rest against a block gets its exact position, because a delta decodes
    /// to the 1/4096 grid. Vanilla's axis pairs cross over, and another kind
    /// of entity that collided is not an item.
pub fn an_item_stopped_by_a_block_needs_full_precision() void {
}
    // rust: let mut item = state(0.0);
    // rust: item.kind = "minecraft:item".into();
    // rust: item.position = [0.3, 64.0, 0.3];
    // rust: assert!(!full_precision_required(&item, [1, 0, 0]));
    // rust: item.vertical_collision = true;
    // rust: assert!(full_precision_required(&item, [1, 0, 0]));
    // rust: item.vertical_collision = false;
    // rust: item.horizontal_collision = true;
        // A horizontal stop pairs an x delta with z, exactly as vanilla does.
    // rust: assert!(full_precision_required(&item, [1, 0, 0]));
    // rust: item.position[2] = 0.5;
    // rust: assert!(!full_precision_required(&item, [1, 0, 0]));
        // A drop that only moved in y says nothing about x and z.
    // rust: item.position[2] = 0.3;
    // rust: assert!(!full_precision_required(&item, [0, 9, 0]));
    // rust: item.kind = "minecraft:zombie".into();
    // rust: assert!(!full_precision_required(&item, [1, 0, 0]));
}

    /// The same through `send_changes`: a slow item stopped by a wall would
    /// have its resting point rounded to the delta grid, so at its next update
    /// (an item's is every 20 ticks) it goes out as a position sync carrying
    /// the exact point; one that hit nothing keeps the quantised delta.
pub fn a_slow_item_stopped_by_a_wall_syncs_its_exact_position() void {
}
    // rust: let stop = |collision: bool| {
    // rust: let mut e = state(0.0);
    // rust: e.kind = "minecraft:item".into();
    // rust: let mut s = added(&e);
    // rust: changes(&mut s, &e);
    // rust: e.position = [0.3, 64.0, 0.3];
    // rust: e.horizontal_collision = collision;
    // rust: for _ in 0..19 {
    // rust: assert!(changes(&mut s, &e).is_empty());
}
    // rust: changes(&mut s, &e)
}
    // rust: let out = stop(true);
    // rust: assert!(
    // rust: matches!(&out[..], [play::Clientbound::EntityPositionSync(p)]
    // rust: if p.path.end() == [0.3, 64.0, 0.3]),
    // rust: "{out:?}"
    // rust: );
    // rust: let out = stop(false);
    // rust: assert!(matches!(&out[..], [play::Clientbound::MoveEntityPos(_)]));
}

pub fn precise_entities_sync_their_position() void {
}
    // rust: let mut e = state(0.0);
    // rust: e.kind = "minecraft:tnt".into();
    // rust: e.precise = true;
    // rust: let mut s = added(&e);
    // rust: assert!(matches!(
    // rust: changes(&mut s, &e)[..],
    // rust: [play::Clientbound::EntityPositionSync(_)]
    // rust: ));
}

pub fn landing_sends_a_position_sync() void {
}
    // rust: let mut e = state(0.0);
    // rust: let mut s = added(&e);
    // rust: changes(&mut s, &e);
    // rust: e.on_ground = false;
    // rust: changes(&mut s, &e);
    // rust: changes(&mut s, &e);
    // rust: assert!(matches!(
    // rust: changes(&mut s, &e)[..],
    // rust: [play::Clientbound::EntityPositionSync(_)]
    // rust: ));
}

pub fn attributes_pair_whole_then_send_the_changed_instances_when_due() void {
}
    // rust: let speed = |base| AttributeSnapshot {
    // rust: attribute: 26,
    // rust: base,
    // rust: modifiers: Vec::new(),
}
    // rust: let armor = AttributeSnapshot {
    // rust: attribute: 1,
    // rust: base: 0.0,
    // rust: modifiers: Vec::new(),
}
    // rust: let mut e = state(0.0);
    // rust: e.attributes = vec![speed(0.23), armor];
    // rust: let mut s = added(&e);
    // rust: let mut spawn = Vec::new();
    // rust: s.pairing(&e, 100, &Riding::default(), &mut spawn);
    // rust: let Some(play::Clientbound::UpdateAttributes(p)) = spawn.get(1) else {
    // rust: panic!("expected the attributes after the add");
}
    // rust: assert_eq!(p.values, e.attributes);
    // rust: changes(&mut s, &e);
    // rust: e.attributes[0] = speed(0.3);
        // Not due (a zombie's interval is 3): sendDirtyEntityData waits for the update.
    // rust: assert!(changes(&mut s, &e).is_empty());
    // rust: assert!(changes(&mut s, &e).is_empty());
    // rust: let out = changes(&mut s, &e);
    // rust: let Some(play::Clientbound::UpdateAttributes(p)) = out
    // rust: .iter()
    // rust: .find(|p| matches!(p, play::Clientbound::UpdateAttributes(_)))
    // rust: else {
    // rust: panic!("expected the changed attribute");
}
    // rust: assert_eq!(p.values, vec![speed(0.3)]);
}

pub fn cleared_flags_and_pose_go_back_to_their_default() void {
}
    // rust: let mut e = state(0.0);
    // rust: let mut s = added(&e);
    // rust: changes(&mut s, &e);
        // A crouching player: the crouch flag and the crouching pose.
    // rust: e.meta = vec![
    // rust: (0, serializer::BYTE, Value::Byte(2)),
    // rust: (6, serializer::POSE, Value::Id(5)),
    // rust: ];
    // rust: changes(&mut s, &e);
    // rust: e.meta.clear();
    // rust: let data = changes(&mut s, &e)
    // rust: .into_iter()
    // rust: .find_map(|p| match p {
    // rust: play::Clientbound::SetEntityData(d) => Some(d),
    // rust: _ => None,
    // rust: })
    // rust: .expect("standing up is sent");
    // rust: assert_eq!(
    // rust: data.values,
    // rust: vec![
    // rust: (0, serializer::BYTE, Value::Byte(0)),
    // rust: (6, serializer::POSE, Value::Id(0)),
    // rust: ]
    // rust: );
    // rust: assert!(changes(&mut s, &e).is_empty());
}

pub fn an_emptied_item_frame_sends_its_empty_item_and_rotation() void {
}
    // rust: let mut e = state(0.0);
    // rust: e.kind = "minecraft:item_frame".into();
    // rust: let mut s = added(&e);
    // rust: changes(&mut s, &e);
    // rust: e.meta = vec![
    // rust: (
    // rust: 9,
    // rust: serializer::ITEM_STACK,
    // rust: Value::Item(Some(Stack::new(5, 1))),
    // rust: ),
    // rust: (10, serializer::INT, Value::Int(3)),
    // rust: ];
    // rust: changes(&mut s, &e);
        // Punched out (ItemFrame.removeFramedMap, setItem(EMPTY)): both back to the default.
    // rust: e.meta.clear();
    // rust: let data = changes(&mut s, &e)
    // rust: .into_iter()
    // rust: .find_map(|p| match p {
    // rust: play::Clientbound::SetEntityData(d) => Some(d),
    // rust: _ => None,
    // rust: })
    // rust: .expect("the empty frame is sent");
    // rust: assert_eq!(
    // rust: data.values,
    // rust: vec![
    // rust: (9, serializer::ITEM_STACK, Value::Item(None)),
    // rust: (10, serializer::INT, Value::Int(0)),
    // rust: ]
    // rust: );
}

pub fn a_cleared_crystal_beam_is_sent() void {
}
    // rust: let mut e = state(0.0);
    // rust: e.kind = "minecraft:end_crystal".into();
    // rust: e.defaults = vec![(8, serializer::OPTIONAL_BLOCK_POS, Value::OptPos(None))];
    // rust: e.meta = vec![(
    // rust: 8,
    // rust: serializer::OPTIONAL_BLOCK_POS,
    // rust: Value::OptPos(Some([0, 128, 0])),
    // rust: )];
    // rust: let mut s = added(&e);
    // rust: e.meta.clear();
    // rust: let mut packets = Vec::new();
    // rust: s.send_dirty(&e, true, &mut packets);
    // rust: let sent: Vec<_> = packets
    // rust: .iter()
    // rust: .filter_map(|p| match p {
    // rust: play::Clientbound::SetEntityData(d) => Some(d.values.clone()),
    // rust: _ => None,
    // rust: })
    // rust: .flatten()
    // rust: .collect();
    // rust: assert_eq!(
    // rust: sent,
    // rust: vec![(8, serializer::OPTIONAL_BLOCK_POS, Value::OptPos(None))]
    // rust: );
}

pub fn a_value_back_at_a_listed_default_is_sent() void {
}
    // rust: let mut e = state(0.0);
    // rust: e.defaults = vec![(16, serializer::BOOLEAN, Value::Bool(false))];
        // A calf: paired with its baby flag, then grown up.
    // rust: e.meta = vec![(16, serializer::BOOLEAN, Value::Bool(true))];
    // rust: let mut s = added(&e);
    // rust: changes(&mut s, &e);
    // rust: e.meta.clear();
    // rust: let data = changes(&mut s, &e)
    // rust: .into_iter()
    // rust: .find_map(|p| match p {
    // rust: play::Clientbound::SetEntityData(d) => Some(d),
    // rust: _ => None,
    // rust: })
    // rust: .expect("growing up is sent");
    // rust: assert_eq!(
    // rust: data.values,
    // rust: vec![(16, serializer::BOOLEAN, Value::Bool(false))]
    // rust: );
    // rust: assert!(changes(&mut s, &e).is_empty());
}

pub fn metadata_and_equipment_send_only_the_changes() void {
}
    // rust: let mut e = state(0.0);
    // rust: let mut s = added(&e);
    // rust: changes(&mut s, &e);
    // rust: e.meta.push((0, 0, Value::Byte(1)));
    // rust: e.equipment.push((0, Some(Stack::new(5, 1))));
    // rust: let out = changes(&mut s, &e);
    // rust: assert!(
    // rust: out.iter()
    // rust: .any(|p| matches!(p, play::Clientbound::SetEntityData(_)))
    // rust: );
    // rust: assert!(
    // rust: out.iter()
    // rust: .any(|p| matches!(p, play::Clientbound::SetEquipment(_)))
    // rust: );
    // rust: assert!(changes(&mut s, &e).is_empty());
    // rust: e.equipment.clear();
    // rust: let out = changes(&mut s, &e);
    // rust: let Some(play::Clientbound::SetEquipment(eq)) = out.first() else {
    // rust: panic!("expected equipment");
}
    // rust: assert_eq!(eq.slots, vec![(0, None)]);
}

pub fn a_lead_tied_and_untied_reaches_the_clients() void {
}
    // rust: let link = |out: &[play::Clientbound]| {
    // rust: out.iter().find_map(|p| match p {
    // rust: play::Clientbound::SetEntityLink(l) => Some((l.source, l.dest)),
    // rust: _ => None,
    // rust: })
}
    // rust: let mut e = state(0.0);
    // rust: let mut s = added(&e);
    // rust: changes(&mut s, &e);
    // rust: e.leash = Some(7);
    // rust: assert_eq!(link(&changes(&mut s, &e)), Some((e.id, 7)));
    // rust: assert_eq!(link(&changes(&mut s, &e)), None);
    // rust: e.leash = None;
    // rust: assert_eq!(link(&changes(&mut s, &e)), Some((e.id, 0)));
}

    /// Two clients at the origin; the chunks they hold.
pub const Clients = struct {
    chunks: crate::fast_hash::FxHashSet<(i32,
    trackers: [Tracker,
    out: [std.ArrayList(Vec<u8)>,
    positions: [[f64,
    moved: [bool,
    spectators: [bool,
    permissions: [u8,
        /// The first client's entities gone, where they were last sent.
    gone: Vec<[f64,
};

    // rust: impl Clients {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: chunks: (-4..4).flat_map(|x| (-4..4).map(move |z| (x, z))).collect(),
    // rust: trackers: Default::default(),
    // rust: out: Default::default(),
    // rust: positions: [[0.0, 64.0, 0.0]; 2],
    // rust: moved: [false; 2],
    // rust: spectators: [false; 2],
    // rust: permissions: [0; 2],
    // rust: gone: Vec::new(),
}
}
pub fn tick(self: *Self, level: *mut Entities, entities: *[*EntityState]) void {
}
    // rust: for out in &mut self.out {
    // rust: out.clear();
}
    // rust: let [t0, t1] = &mut self.trackers;
    // rust: let [o0, o1] = &mut self.out;
    // rust: let mut viewers = [
    // rust: Viewer {
    // rust: entity_id: 1,
    // rust: spectator: self.spectators[0],
    // rust: permission: self.permissions[0],
    // rust: moved: self.moved[0],
    // rust: position: self.positions[0],
    // rust: view_distance: 10,
    // rust: chunks: &self.chunks,
    // rust: tracker: t0,
    // rust: out: o0,
    // rust: gone: Some(&mut self.gone),
    // rust: },
    // rust: Viewer {
    // rust: entity_id: 2,
    // rust: spectator: self.spectators[1],
    // rust: permission: self.permissions[1],
    // rust: moved: self.moved[1],
    // rust: position: self.positions[1],
    // rust: view_distance: 10,
    // rust: chunks: &self.chunks,
    // rust: tracker: t1,
    // rust: out: o1,
    // rust: gone: None,
    // rust: },
    // rust: ];
    // rust: level.tick(entities, &Riding::default(), &mut viewers, |_| Some(100));
}
}

pub fn body(p: play::Clientbound) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: p.encode()
}

    /// ChunkMap checks a pair again only when one side moves: a zombie
    /// walking into range within its section isn't paired with a client
    /// standing still until the client moves, and one walking out stays
    /// tracked until it changes section.
pub fn pairs_are_checked_again_when_a_side_moves() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut clients = Clients::new();
    // rust: clients.positions[0] = [-108.0, 64.0, 0.0];
    // rust: let mut me = state(-108.0);
    // rust: (me.id, me.kind) = (1, "minecraft:player".into());
        // 128.5 blocks away: past a zombie's 8 chunks.
    // rust: let tracks = |clients: &Clients| clients.trackers[0].is_tracking(7);
    // rust: clients.tick(&mut level, &[&me, &state(20.5)]);
    // rust: assert!(!tracks(&clients));
        // 127.5 blocks away, in the same section: not checked again.
    // rust: clients.tick(&mut level, &[&me, &state(19.5)]);
    // rust: assert!(!tracks(&clients));
        // The client's move checks every pair of it.
    // rust: clients.moved[0] = true;
    // rust: clients.tick(&mut level, &[&me, &state(19.5)]);
    // rust: assert!(tracks(&clients));
    // rust: clients.moved[0] = false;
    // rust: clients.tick(&mut level, &[&me, &state(20.5)]);
    // rust: assert!(tracks(&clients));
        // Into the next section, out of range: no longer tracked.
    // rust: clients.tick(&mut level, &[&me, &state(40.0)]);
    // rust: assert!(!tracks(&clients));
        // The other client (at the origin, its entity not in the level)
        // checks every pair each tick.
    // rust: assert!(clients.trackers[1].is_tracking(7));
}

pub fn every_client_gets_the_same_changes_and_late_ones_are_paired() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
        // The second client is out of range at first.
    // rust: c.positions[1] = [500.0, 64.0, 0.0];
    // rust: let mut e = state(0.0);
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert!(c.trackers[0].is_tracking(7) && !c.trackers[1].is_tracking(7));
    // rust: assert!(c.out[1].is_empty());
        // Tick 0's forced position goes to the client tracking it.
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert_eq!(c.out[0].len(), 1);
        // The second client comes in range: paired with the entity as it is,
        // then sent the same changes as the first.
    // rust: c.positions[1] = [0.0, 64.0, 0.0];
    // rust: e.position[0] = 1.0;
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert!(c.trackers[1].is_tracking(7));
    // rust: assert!(c.out[0].is_empty());
    // rust: assert_eq!(c.out[1].len(), 1);
    // rust: c.tick(&mut level, &[&e]);
    // rust: e.position[0] = 2.0;
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert!(!c.out[0].is_empty());
    // rust: assert_eq!(c.out[0], c.out[1]);
}

    /// ChunkMap.tick runs sendChanges only for an entity in entity-ticking
    /// range, one that changed section or one that needs sync. An idle
    /// zombie sends nothing, not even the position every 60 ticks (its
    /// update clock stands still); a data change waits until it is back in
    /// range, and then goes out as vanilla sends it. A lead goes out at once
    /// (Leashable), needsSync and a section change send its changes now.
pub fn an_idle_entity_sends_only_what_chunk_map_sends() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
    // rust: let mut e = state(15.5);
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert!(c.trackers.iter().all(|t| t.is_tracking(7)));
        // Its first update: tick 0's position.
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert_eq!(c.out[0].len(), 1);
    // rust: e.idle = true;
    // rust: for _ in 0..100 {
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert!(c.out.iter().all(Vec::is_empty));
}
    // rust: let health = |h: f32| {
    // rust: body(play::Clientbound::SetEntityData(SetEntityData {
    // rust: id: 7,
    // rust: values: vec![(9, serializer::FLOAT, Value::Float(h))],
    // rust: }))
}
    // rust: e.meta.push((9, serializer::FLOAT, Value::Float(5.0)));
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert!(c.out.iter().all(Vec::is_empty));
        // Back in range: the change alone (update tick 1 is not a position one).
    // rust: e.idle = false;
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert_eq!(c.out, [vec![health(5.0)], vec![health(5.0)]]);
    // rust: e.idle = true;
    // rust: e.meta[0].2 = Value::Float(4.0);
    // rust: e.needs_sync = true;
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert_eq!(c.out[0], [health(4.0)]);
    // rust: e.needs_sync = false;
    // rust: e.leash = Some(3);
    // rust: c.tick(&mut level, &[&e]);
    // rust: let link = body(play::Clientbound::SetEntityLink(SetEntityLink {
    // rust: source: 7,
    // rust: dest: 3,
    // rust: }));
    // rust: assert_eq!(c.out[0], [link]);
        // Into the next section: a move.
    // rust: e.position[0] = 16.5;
    // rust: c.tick(&mut level, &[&e]);
    // rust: let moved = MoveEntityPos(MoveEntity {
    // rust: id: 7,
    // rust: delta: Some(VecDelta::Linear([4096, 0, 0])),
    // rust: rotation: None,
    // rust: on_ground: true,
    // rust: });
    // rust: assert_eq!(c.out[0], [body(play::Clientbound::MoveEntityPos(moved))]);
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert!(c.out.iter().all(Vec::is_empty));
}

    /// A bare state carries none of the entity's data, so it is never paired:
    /// a client that could pair is sent the entity once it is described in full.
pub fn a_bare_state_is_never_paired() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
    // rust: c.positions[1] = [500.0, 64.0, 0.0];
    // rust: let mut e = state(0.0);
    // rust: e.meta.push((9, serializer::FLOAT, Value::Float(5.0)));
    // rust: c.tick(&mut level, &[&e]);
    // rust: e.idle = true;
    // rust: let bare = EntityState {
    // rust: meta: Vec::new(),
    // rust: bare: true,
    // rust: ..e.clone()
}
    // rust: c.positions[1] = [0.0, 64.0, 0.0];
    // rust: c.tick(&mut level, &[&bare]);
    // rust: assert!(!c.trackers[1].is_tracking(7) && c.out[1].is_empty());
    // rust: c.tick(&mut level, &[&e]);
    // rust: assert!(c.trackers[1].is_tracking(7));
    // rust: let data = body(play::Clientbound::SetEntityData(SetEntityData {
    // rust: id: 7,
    // rust: values: e.meta.clone(),
    // rust: }));
    // rust: assert!(c.out[1].contains(&data));
}

    /// ChunkMap.addEntity pairs an entity as it joined the level: one the
    /// game added after the last tick's pass (an item a landing falling
    /// block drops) is paired from where it joined, not from where its first
    /// tick took it, and its first update moves it from there; what its
    /// first tick alone carries (needs_sync) is kept. Once tracked, its own
    /// state is used again.
pub fn an_entity_added_after_the_pass_is_paired_as_it_joined() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
    // rust: let mut joined = state(1.0);
    // rust: joined.velocity = [0.0, 0.2, 0.0];
    // rust: let mut first = state(1.5);
    // rust: first.needs_sync = true;
    // rust: let mut entities = vec![&first];
    // rust: let joins = level.joined_states(&entities, vec![joined.clone()]);
    // rust: assert!(joins[&7].needs_sync);
    // rust: Entities::starting_from(&mut entities, &joins);
    // rust: assert_eq!(entities[0].position, [1.0, 64.0, 0.0]);
    // rust: c.tick(&mut level, &entities);
    // rust: let add = body(play::Clientbound::AddEntity(AddEntity {
    // rust: id: 7,
    // rust: uuid: 1,
    // rust: kind: 100,
    // rust: position: [1.0, 64.0, 0.0],
    // rust: velocity: [0.0, 0.2, 0.0],
    // rust: pitch: 0,
    // rust: yaw: 0,
    // rust: head_yaw: 0,
    // rust: data: 0,
    // rust: }));
    // rust: assert_eq!(c.out[0], [add]);
    // rust: let later = state(2.0);
    // rust: let entities = vec![&later];
    // rust: assert!(level.joined_states(&entities, vec![joined]).is_empty());
    // rust: c.tick(&mut level, &entities);
    // rust: let moved = body(play::Clientbound::MoveEntityPos(MoveEntityPos(
    // rust: MoveEntity {
    // rust: id: 7,
    // rust: delta: Some(VecDelta::Linear([4096, 0, 0])),
    // rust: rotation: None,
    // rust: on_ground: true,
    // rust: },
    // rust: )));
    // rust: assert!(c.out[0].contains(&moved), "{:?}", c.out[0]);
}

    /// An entity that joined before the tick's ChunkMap.tick point (a
    /// falling block from a block tick, a naturally spawned mob) has its
    /// first update in the pass that pairs it: tick 0 of its interval,
    /// before it moves, which the client just paired with gets too (a move
    /// by nothing: `tickCount % 60 == 0`). A falling block that lands within
    /// 20 ticks is never sent a move. One added by the entities' ticks has
    /// its first update in the next pass.
pub fn an_entity_joined_before_the_chunk_map_tick_is_updated_as_it_is_paired() void {
}
    // rust: let mut sand = state(0.5);
    // rust: sand.kind = "minecraft:falling_block".into();
    // rust: let move_by = |dy: i16| {
    // rust: body(play::Clientbound::MoveEntityPos(MoveEntityPos(
    // rust: MoveEntity {
    // rust: id: 7,
    // rust: delta: Some(VecDelta::Linear([0, dy, 0])),
    // rust: rotation: None,
    // rust: on_ground: true,
    // rust: },
    // rust: )))
}
    // rust: let passes = |synced: Vec<(i32, i32)>| {
    // rust: let mut level = Entities {
    // rust: synced,
    // rust: ..Entities::default()
}
    // rust: let mut c = Clients::new();
    // rust: c.tick(&mut level, &[&sand]);
    // rust: let paired = c.out[0][1..].to_vec();
    // rust: let mut fallen = sand.clone();
    // rust: fallen.position[1] -= 0.04;
    // rust: c.tick(&mut level, &[&fallen]);
    // rust: (paired, c.out[0].clone())
}
        // Updated in place as it was paired; its fall waits for tick 20.
    // rust: for synced in [vec![(i32::MIN, 7)], vec![(i32::MIN, 3), (5, 9)]] {
    // rust: assert_eq!(passes(synced), (vec![move_by(0)], vec![]));
}
        // Its first update is the next pass's, after it fell.
    // rust: for synced in [vec![], vec![(i32::MIN, 6)], vec![(7, 9)]] {
    // rust: assert_eq!(passes(synced), (vec![], vec![move_by(-164)]));
}
}

    /// ChunkMap.addEntity (#7461): a fresh arrow (shot point-blank into a wall)
    /// is paired with IN_GROUND=false, and its first update is deferred to the
    /// next tick's send_changes so that IN_GROUND=true arrives after the client's
    /// first tick has completed, satisfying AbstractArrow.onSyncedDataUpdated's
    /// !this.firstTick guard and triggering the shake animation.
pub fn fresh_arrow_pairs_as_joined_and_defers_in_ground_update_to_next_tick() void {
}
    // rust: let mut level = Entities {
    // rust: synced: vec![(i32::MIN, 7)],
    // rust: ..Entities::default()
}
    // rust: let mut c = Clients::new();
    // rust: let mut joined = state(0.0);
    // rust: joined.kind = "minecraft:arrow".into();
    // rust: joined.meta = vec![(8, serializer::BYTE, Value::Byte(0))];

    // rust: let mut stuck = joined.clone();
    // rust: stuck.meta = vec![(8, serializer::BYTE, Value::Byte(1))];

    // rust: let mut entities = vec![&stuck];
    // rust: let joins = level.joined_states(&entities, vec![joined.clone()]);
    // rust: Entities::starting_from(&mut entities, &joins);
    // rust: assert_eq!(
    // rust: entities[0].meta,
    // rust: vec![(8, serializer::BYTE, Value::Byte(0))]
    // rust: );

        // Tick 0: arrow is paired. Because it's an arrow, send_changes does not run on tick 0
        // even though level.synced contains its id.
    // rust: c.tick(&mut level, &entities);
    // rust: let in_ground_true = body(play::Clientbound::SetEntityData(SetEntityData {
    // rust: id: 7,
    // rust: values: vec![(8, serializer::BYTE, Value::Byte(1))],
    // rust: }));
    // rust: assert!(!c.out[0].contains(&in_ground_true));

        // Tick 1: arrow is in the wall (IN_GROUND = true).
    // rust: let next_entities = vec![&stuck];
    // rust: c.tick(&mut level, &next_entities);

        // Tick 1 sends SetEntityData with IN_GROUND=true.
    // rust: assert!(c.out[0].contains(&in_ground_true), "{:?}", c.out[0]);
}

pub fn clients_lose_what_leaves_range_or_the_level_and_never_track_themselves() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
    // rust: let mut me = state(0.0);
    // rust: me.id = 1;
    // rust: me.kind = "minecraft:player".into();
    // rust: let mut e = state(0.0);
    // rust: c.tick(&mut level, &[&me, &e]);
    // rust: assert!(!c.trackers[0].is_tracking(1) && c.trackers[1].is_tracking(1));
    // rust: assert!(c.trackers[0].is_tracking(7));
        // Out of the zombie's 8 chunks: the client last had it where it started.
    // rust: let start = e.position;
    // rust: e.position[0] = 200.0;
    // rust: c.tick(&mut level, &[&me, &e]);
    // rust: assert!(!c.trackers[0].is_tracking(7));
    // rust: assert_eq!(c.gone, [start]);
    // rust: let removed = body(play::Clientbound::RemoveEntities(play::RemoveEntities {
    // rust: ids: vec![7],
    // rust: }));
    // rust: assert_eq!(c.out[0].first(), Some(&removed));
        // Gone from the level: the other client loses it too, and so does
        // the level.
    // rust: e.position[0] = 0.0;
    // rust: c.tick(&mut level, &[&me, &e]);
    // rust: assert!(c.trackers[0].is_tracking(7));
    // rust: c.tick(&mut level, &[&me]);
    // rust: assert!(!c.trackers[0].is_tracking(7) && !c.trackers[1].is_tracking(7));
    // rust: assert_eq!(c.out[0].first(), Some(&removed));
    // rust: assert_eq!(level.len(), 1);
}

pub fn entities_in_chunks_a_client_lacks_wait_for_them() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
        // Two zombies in range in chunk (4, 0), which the clients don't have
        // yet, and one in chunk (0, 0).
    // rust: let mut far = state(70.0);
    // rust: let mut near = state(66.0);
    // rust: near.id = 8;
    // rust: let mut home = state(1.0);
    // rust: home.id = 9;
    // rust: c.tick(&mut level, &[&far, &near, &home]);
    // rust: for t in &c.trackers {
    // rust: assert!(!t.is_tracking(7) && !t.is_tracking(8) && t.is_tracking(9));
}
        // The chunk arrives: both are paired, in order.
    // rust: c.chunks.insert((4, 0));
    // rust: c.tick(&mut level, &[&far, &near, &home]);
    // rust: for t in &c.trackers {
    // rust: assert!(t.is_tracking(7) && t.is_tracking(8) && t.is_tracking(9));
}
        // One walks back into chunk (3, 0) and the other out of range.
    // rust: far.position[0] = 200.0;
    // rust: near.position[0] = 60.0;
    // rust: c.tick(&mut level, &[&far, &near, &home]);
    // rust: for t in &c.trackers {
    // rust: assert!(!t.is_tracking(7) && t.is_tracking(8) && t.is_tracking(9));
}
}

    /// ServerPlayer.broadcastToPlayer: a spectator is shown only to other
    /// spectators, who see everyone. Going in or out of spectator mode checks
    /// its pairs again, though nobody moved.
pub fn spectators_are_tracked_only_by_spectators() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
    // rust: let player = |id: i32| {
    // rust: let mut p = state(0.0);
    // rust: (p.id, p.uuid, p.kind) = (id, id as u128, "minecraft:player".into());
    // rust: p
}
    // rust: let (mut one, mut two) = (player(1), player(2));
        // A third player, already spectating, that neither client plays.
    // rust: let mut three = player(3);
    // rust: three.spectator = true;
    // rust: c.tick(&mut level, &[&one, &two, &three]);
    // rust: c.tick(&mut level, &[&one, &two, &three]);
    // rust: assert!(c.trackers[0].is_tracking(2) && c.trackers[1].is_tracking(1));
    // rust: assert!(!c.trackers[0].is_tracking(3) && !c.trackers[1].is_tracking(3));
        // The second player starts spectating: the first client loses it,
        // and it sees the first player and the other spectator.
    // rust: (two.spectator, c.spectators[1]) = (true, true);
    // rust: c.tick(&mut level, &[&one, &two, &three]);
    // rust: assert!(!c.trackers[0].is_tracking(2));
    // rust: let removed = body(play::Clientbound::RemoveEntities(play::RemoveEntities {
    // rust: ids: vec![2],
    // rust: }));
    // rust: assert_eq!(c.out[0].first(), Some(&removed));
    // rust: assert!(c.trackers[1].is_tracking(1) && c.trackers[1].is_tracking(3));
        // Its armour changes go to nobody who doesn't track it.
    // rust: two.equipment.push((5, Some(Stack::new(5, 1))));
    // rust: c.tick(&mut level, &[&one, &two, &three]);
    // rust: assert!(c.out[0].is_empty());
        // The first player starts spectating too: both spectators show up.
    // rust: (one.spectator, c.spectators[0]) = (true, true);
    // rust: c.tick(&mut level, &[&one, &two, &three]);
    // rust: assert!(c.trackers[0].is_tracking(2) && c.trackers[0].is_tracking(3));
        // Both back in survival: they still see each other, and lose the
        // third player.
    // rust: (one.spectator, c.spectators[0]) = (false, false);
    // rust: (two.spectator, c.spectators[1]) = (false, false);
    // rust: c.tick(&mut level, &[&one, &two, &three]);
    // rust: assert!(c.trackers[0].is_tracking(2) && c.trackers[1].is_tracking(1));
    // rust: assert!(!c.trackers[0].is_tracking(3) && !c.trackers[1].is_tracking(3));
}

    /// ServerPlayer.broadcastToPlayer for a spectator: a spectator watching
    /// through a camera is hidden from the other spectators too.
pub fn a_spectator_with_a_camera_is_hidden_from_spectators() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
    // rust: let player = |id: i32| {
    // rust: let mut p = state(0.0);
    // rust: (p.id, p.uuid, p.kind) = (id, id as u128, "minecraft:player".into());
    // rust: p
}
    // rust: let (mut one, mut two) = (player(1), player(2));
    // rust: (one.spectator, two.spectator) = (true, true);
    // rust: c.spectators = [true, true];
    // rust: c.tick(&mut level, &[&one, &two]);
    // rust: c.tick(&mut level, &[&one, &two]);
    // rust: assert!(c.trackers[0].is_tracking(2) && c.trackers[1].is_tracking(1));
        // The second spectator takes a camera: the first loses sight of it.
    // rust: two.watching = true;
    // rust: c.tick(&mut level, &[&one, &two]);
    // rust: assert!(!c.trackers[0].is_tracking(2) && c.trackers[1].is_tracking(1));
        // Back to its own view: it shows up again.
    // rust: two.watching = false;
    // rust: c.tick(&mut level, &[&one, &two]);
    // rust: assert!(c.trackers[0].is_tracking(2));
}

    /// A player a native mod hid is tracked only by clients whose player has
    /// at least its level, and by everyone again once shown.
pub fn a_hidden_player_is_tracked_only_from_its_level_up() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
    // rust: c.permissions = [0, 3];
    // rust: let mut op = state(0.0);
    // rust: (op.id, op.uuid, op.kind) = (9, 9, "minecraft:player".into());
    // rust: op.hidden = Some(3);
    // rust: c.tick(&mut level, &[&op]);
    // rust: c.tick(&mut level, &[&op]);
    // rust: assert!(
    // rust: !c.trackers[0].is_tracking(9),
    // rust: "a player of level 0 doesn't see it"
    // rust: );
    // rust: assert!(c.trackers[1].is_tracking(9), "an operator of level 3 does");
        // Hidden after it was seen: the client below the level loses it.
    // rust: op.hidden = None;
    // rust: c.tick(&mut level, &[&op]);
    // rust: assert!(c.trackers[0].is_tracking(9));
    // rust: op.hidden = Some(4);
    // rust: c.tick(&mut level, &[&op]);
    // rust: assert!(!c.trackers[0].is_tracking(9) && !c.trackers[1].is_tracking(9));
        // A client whose player was made an operator (its pairs checked again).
    // rust: c.permissions = [4, 3];
    // rust: c.moved = [true, false];
    // rust: c.tick(&mut level, &[&op]);
    // rust: assert!(c.trackers[0].is_tracking(9) && !c.trackers[1].is_tracking(9));
}

pub fn pairing_and_unpairing_are_kept_for_the_game() void {
}
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
    // rust: let zombie = state(0.0);
    // rust: c.tick(&mut level, &[&zombie]);
    // rust: c.tick(&mut level, &[&zombie]);
        // Both clients were paired with it, once.
    // rust: for t in &mut c.trackers {
    // rust: let events = t.take_events();
    // rust: assert_eq!(events.len(), 1, "{events:?}");
    // rust: assert!(events[0].start && events[0].entity == 7);
    // rust: assert_eq!(&*events[0].tracked.kind, "minecraft:zombie");
    // rust: assert_eq!(events[0].tracked.uuid, 1);
    // rust: assert!(t.take_events().is_empty());
}
        // It leaves the level: both clients lose it.
    // rust: c.tick(&mut level, &[]);
    // rust: for t in &mut c.trackers {
    // rust: let events = t.take_events();
    // rust: assert!(
    // rust: matches!(&events[..], [e] if !e.start && e.entity == 7),
    // rust: "{events:?}"
    // rust: );
}
        // Back, then forgotten and cleared without a tick.
    // rust: c.tick(&mut level, &[&zombie]);
    // rust: c.tick(&mut level, &[&zombie]);
    // rust: c.trackers[0].take_events();
    // rust: c.trackers[1].take_events();
    // rust: assert!(c.trackers[0].forget(7));
    // rust: c.trackers[1].clear();
    // rust: for t in &mut c.trackers {
    // rust: let events = t.take_events();
    // rust: assert!(
    // rust: matches!(&events[..], [e] if !e.start && e.entity == 7),
    // rust: "{events:?}"
    // rust: );
}
}

pub fn a_forgotten_entity_is_paired_again_at_the_next_tick() void {
}
        // A respawned player: the hub removes it from the other clients and
        // forgets it, and the next tick pairs it again as a new entity.
    // rust: let mut level = Entities::default();
    // rust: let mut c = Clients::new();
    // rust: let mut player = state(0.0);
    // rust: player.id = 1;
    // rust: player.kind = "minecraft:player".into();
    // rust: c.tick(&mut level, &[&player]);
    // rust: c.tick(&mut level, &[&player]);
    // rust: assert!(c.trackers[1].forget(1));
    // rust: assert!(!c.trackers[1].forget(1));
    // rust: c.tick(&mut level, &[&player]);
    // rust: assert!(c.trackers[1].is_tracking(1));
    // rust: let paired = c.out[1]
    // rust: .first()
    // rust: .and_then(|p| play::Clientbound::decode(i32::from(p[0]), &p[1..]).ok());
    // rust: assert!(
    // rust: matches!(paired, Some(play::Clientbound::AddEntity(ref a)) if a.id == 1),
    // rust: "{paired:?}"
    // rust: );
}
}
