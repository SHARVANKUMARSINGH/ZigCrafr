//! Transpiled from Horizon Rust crate
//! Module: horizon-client_nether_portal
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Nether portals for the player and the other entities:
//! `Entity.setAsInsidePortal` / `handlePortal` with `PortalProcessor`,
//! `NetherPortalBlock.getPortalTransitionTime` and `getPortalDestination`
//! (`PortalForcer` through `horizon_world::level::portal_travel`), and
//! `LocalPlayer.handlePortalTransitionEffect`. Items and mobs also go through
//! End portals here (`EndPortalBlock.entityInside` / `getPortalDestination`);
//! the player's End portals are game/end.rs's.
//!
//! A server keeps one level per dimension. Entity portal processes and
//! cooldowns follow their level; shared `Arrival`s hold each traveller's
//! saved compound until its destination chunks are loaded.
// use super::entity::{Entity as _, entity_lists_of, for_each_entity};
// use super::{Dim, Game, Screen};
// use horizon_client::fast_hash::FxHashMap;
// use horizon_client::nether_portal::{ENTITY_DELAY, PortalState};
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::{
    // rust: level::portal_travel::{
    // rust: BorderBounds, FoundRectangle, closest_portal, collision_free_position, exit_position,
    // rust: largest_rectangle_around, relative_position,
    // rust: },
    // rust: nbt::Tag,
}
// use std::collections::HashMap;

/// `Player.getDimensionChangingDelay`.
    // rust: pub(super) const PLAYER_DELAY: i32 = 10;

/// Where in its portal a traveller stood, and where its exit is to be found.
    // rust: pub(super) struct Plan {
    // rust: pub(super) dim: Dim,
    /// The border-clamped, scaled position (`approximateExitPos`).
    // rust: pub(super) approximate: BlockPos,
    // rust: entry_x_axis: bool,
    // rust: offset: Vec3,
    // rust: width: f32,
    // rust: height: f32,
    /// Through an End portal: `approximate` is the End's spawn point, or the
    /// Overworld's shared spawn.
    // rust: pub(super) end: bool,
}

    // rust: impl Plan {
    /// `EndPortalBlock.getPortalDestination` for an entity other than a
    /// player in `from`: the End's spawn point, or out of the End the
    /// Overworld's shared spawn `world_spawn`.
pub fn end_portal(from: Dim, world_spawn: BlockPos, width: f32, height: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (dim, approximate) = if from == Dim::End {
    // rust: (Dim::Overworld, world_spawn)
    // rust: } else {
    // rust: let [x, y, z] = super::end::END_SPAWN;
    // rust: (Dim::End, BlockPos::new(x, y, z))
}
    // rust: Self {
    // rust: dim,
    // rust: approximate,
    // rust: entry_x_axis: true,
    // rust: offset: Vec3::ZERO,
    // rust: width,
    // rust: height,
    // rust: end: true,
}
}
}

/// An entity on its way to a dimension that isn't loaded.
pub const Arrival = struct {
    plan: Plan,
    tag: Tag,
};

/// The nether portal state of the world (`Game::portals`).
    // rust: pub(super) struct Portals {
    /// The player's.
    // rust: pub(super) player: PortalState,
    /// `LocalPlayer.portalProcess.isInsidePortalThisTick`.
    // rust: client_inside: bool,
    /// Whether the last tick's `handlePortalTransitionEffect` found the
    /// player inside a nether portal: it closes any screen opened meanwhile.
    // rust: client_was_inside: bool,
    /// Items and mobs, by entity id.
    // rust: pub(super) entities: HashMap<u32, PortalState>,
    /// Positions before this tick's moves, by entity id.
    // rust: pub(super) before: FxHashMap<u32, Vec3>,
    // rust: arrivals: Vec<Arrival>,
    /// The vehicles server players ride that went through a portal this
    /// tick, in their level, with their entry: they carry their riders
    /// (`tick_server_travel`).
    // rust: carrying: Vec<(Dim, u32, BlockPos)>,
    /// What a carrying minecart moved by when its portal was handled, at the
    /// start of its tick: its motion is what crosses (`arrive_vehicle`).
    // rust: pub(super) carried_motion: HashMap<u32, Vec3>,
    /// Where a carrying vehicle stood then: its plan is taken from there
    /// (`vehicle_plan`), as vanilla's is, not from where its rider's own tick
    /// has moved it on to since.
    // rust: pub(super) carried_at: HashMap<u32, Vec3>,
    // rust: loaded: bool,
    // rust: dirty: bool,
    /// Per-chunk portal palette masks, kept across ticks (portal_sections).
    // rust: pub(super) sections: horizon_client::portal_sections::PortalSections,
}

pub fn rotate_y(v: Vec3, degrees: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // Vec3.yRot((float)Math.toRadians(degrees))
    // rust: let angle = f64::from(degrees.to_radians());
    // rust: let (cos, sin) = (
    // rust: f64::from(horizon_core::geometry::trig::cos(angle)),
    // rust: f64::from(horizon_core::geometry::trig::sin(angle)),
    // rust: );
    // rust: Vec3::new(v.x * cos + v.z * sin, v.y, v.z * cos - v.x * sin)
}
/// Whether a projectile is an arrow, which goes through a portal like the
/// other entities.
    // rust: pub(super) fn is_arrow(p: &horizon_client::projectiles::Projectile) -> bool {
    // rust: matches!(
    // rust: p.kind,
    // rust: horizon_client::projectiles::ProjectileKind::Arrow { .. }
    // rust: )
}
/// The projectiles besides arrows that a portal sends on: the thrown items
/// and fireballs a chunk saves. A pearl has its own rules (it keeps its owner's
/// dimension) and a wind charge is not saved, so both stay.
    // rust: pub(super) fn is_portal_projectile(p: &horizon_client::projectiles::Projectile) -> bool {
//     use horizon_client::projectiles::ProjectileKind;
    // rust: !is_arrow(p)
    // rust: && !matches!(
    // rust: p.kind,
    // rust: ProjectileKind::EnderPearl
    // rust: | ProjectileKind::WindCharge
    // rust: | ProjectileKind::BreezeWindCharge
    // rust: )
    // rust: && horizon_client::entity_nbt::saved_with_chunk(p)
}
/// Width and height of a projectile that goes through a portal.
    // rust: pub(super) fn projectile_box(p: &horizon_client::projectiles::Projectile) -> (f32, f32) {
    // rust: if is_arrow(p) {
    // rust: (
    // rust: horizon_client::arrows::WIDTH,
    // rust: horizon_client::arrows::HEIGHT,
    // rust: )
    // rust: } else {
    // rust: let size = p.kind.size() as f32;
    // rust: (size, size)
}
}
/// `Entity.calculatePassengerTransition`: the riders under `tag`'s
/// `Passengers`, and theirs, keep their place on the vehicle: they move by
/// what it moved and turn by what it turned.
pub fn move_passengers(tag: *mut Tag, by: Vec3, turn: f32) void {
}
    // rust: let Tag::Compound(c) = tag else {
    // rust: return;
}
    // rust: let Some(Tag::List(riders)) = c.get_mut(&"Passengers".into()) else {
    // rust: return;
}
    // rust: for rider in riders {
    // rust: if let Some(at) = horizon_client::entity_nbt::position(rider)
    // rust: && let Tag::Compound(r) = rider
    // rust: {
    // rust: r.insert(
    // rust: "Pos".into(),
    // rust: doubles([at.x + by.x, at.y + by.y, at.z + by.z]),
    // rust: );
    // rust: let [yaw, pitch] = horizon_client::entity_nbt::rotation(rider);
    // rust: if let Tag::Compound(r) = rider {
    // rust: r.insert(
    // rust: "Rotation".into(),
    // rust: Tag::List(vec![
    // rust: Tag::Float((yaw + turn).to_bits()),
    // rust: Tag::Float(pitch.to_bits()),
    // rust: ]),
    // rust: );
}
}
    // rust: move_passengers(rider, by, turn);
}
}
pub fn doubles(values: [f64; 3]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::List(values.iter().map(|v| Tag::Double(v.to_bits())).collect())
}
/// Whether a `width` by `height` box moving from `from` to `to` meets the End
/// portal at `pos`: `Entity.collidedWithShapeMovingFrom` against its
/// entity-inside shape, y 6/16..12/16 of the block.
pub fn touches_end_portal(from: Vec3, to: Vec3, width: f32, height: f32, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = f64::from(width) / 2.0;
    // rust: let start = Aabb::new(
    // rust: Vec3::new(from.x - half, from.y, from.z - half),
    // rust: Vec3::new(from.x + half, from.y + f64::from(height), from.z + half),
    // rust: );
    // rust: let (x, y, z) = (f64::from(pos.x), f64::from(pos.y), f64::from(pos.z));
    // rust: let shape = Aabb::new(
    // rust: Vec3::new(x, y + 0.375, z),
    // rust: Vec3::new(x + 1.0, y + 0.75, z + 1.0),
    // rust: );
    // rust: start.collided_along_vector(to.subtract(from), &[shape])
}
/// `PositionMoveRotation.calculateAbsolute` for an End portal's transition
/// of an entity facing `[yaw, pitch]`: into the End it faces west and keeps
/// its pitch (`Relative.X_ROT`); out of it both turn by the world spawn's
/// angles (`Relative.ROTATION`). The pitch stays within ±90.
pub fn end_portal_rotation(into_end: bool, pitch]: [f32; 2], spawn: [f32; 2]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (yaw, pitch) = if into_end {
        // Direction.WEST.toYRot().
    // rust: (90.0, pitch)
    // rust: } else {
    // rust: (yaw + spawn[0], pitch + spawn[1])
}
    // rust: [yaw, pitch.clamp(-90.0, 90.0)]
}
/// A waiting entity as `horizon_portal_arrivals.dat` keeps it.
pub fn arrival_tag(a: *Arrival) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = &a.plan;
    // rust: Tag::compound([
    // rust: ("dimension", Tag::String(p.dim.id().into())),
    // rust: ("x", Tag::Int(p.approximate.x)),
    // rust: ("y", Tag::Int(p.approximate.y)),
    // rust: ("z", Tag::Int(p.approximate.z)),
    // rust: ("x_axis", Tag::Int(i32::from(p.entry_x_axis))),
    // rust: ("right", Tag::Double(p.offset.x.to_bits())),
    // rust: ("up", Tag::Double(p.offset.y.to_bits())),
    // rust: ("forward", Tag::Double(p.offset.z.to_bits())),
    // rust: ("width", Tag::Float(p.width.to_bits())),
    // rust: ("height", Tag::Float(p.height.to_bits())),
    // rust: ("end", Tag::Int(i32::from(p.end))),
    // rust: ("entity", a.tag.clone()),
    // rust: ])
}
/// The waiting entity `arrival_tag` wrote.
pub fn arrival_from_tag(a: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let int = |k: &str| match a.get(k) {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: _ => None,
}
    // rust: let float = |k: &str| match a.get(k) {
    // rust: Some(Tag::Float(v)) => Some(f32::from_bits(*v)),
    // rust: _ => None,
}
    // rust: let double = |k: &str| match a.get(k) {
    // rust: Some(Tag::Double(v)) => Some(f64::from_bits(*v)),
    // rust: _ => None,
}
    // rust: let dim = Dim::from_id(&horizon_client::save::text(a.get("dimension"))?);
    // rust: let (Some(x), Some(y), Some(z), Some(tag)) = (int("x"), int("y"), int("z"), a.get("entity"))
    // rust: else {
    // rust: return None;
}
    // rust: Some(Arrival {
    // rust: plan: Plan {
    // rust: dim,
    // rust: approximate: BlockPos::new(x, y, z),
    // rust: entry_x_axis: int("x_axis").unwrap_or(1) != 0,
    // rust: offset: Vec3::new(
    // rust: double("right").unwrap_or(0.5),
    // rust: double("up").unwrap_or(0.0),
    // rust: double("forward").unwrap_or(0.0),
    // rust: ),
    // rust: width: float("width").unwrap_or(0.25),
    // rust: height: float("height").unwrap_or(0.25),
    // rust: end: int("end").unwrap_or(0) != 0,
    // rust: },
    // rust: tag: tag.clone(),
    // rust: })
}

    // rust: impl Game<'_> {
    /// The world border's extent.
    // rust: pub(super) fn border_bounds(&self) -> BorderBounds {
    // rust: let [min_x, min_z, max_x, max_z] = self.border.bounds();
    // rust: BorderBounds {
    // rust: min_x,
    // rust: min_z,
    // rust: max_x,
    // rust: max_z,
}
}
    /// `ServerLevel.isAllowedToEnterPortal`.
    // rust: pub(super) fn may_enter(&self, target: Dim) -> bool {
    // rust: target != Dim::Nether || self.ui.rules.bool("allow_entering_nether_using_portals")
}
    /// The plan of an entity of `width` by `height` at `at` going through the
    /// portal at `entry` (`getDimensionTransitionFromExit` and the scaled,
    /// clamped exit of `getPortalDestination`).
    // rust: pub(super) fn portal_plan(
    // rust: &self,
    // rust: entry: BlockPos,
    // rust: at: Vec3,
    // rust: width: f32,
    // rust: height: f32,
    // rust: reset_forward: bool,
    // rust: ) -> Plan {
    // rust: let target = if self.dim == Dim::Nether {
    // rust: Dim::Overworld
    // rust: } else {
    // rust: Dim::Nether
}
    // rust: let state = self.world.block(entry.x, entry.y, entry.z);
    // rust: let b = self.res.behaviours();
    // rust: let (entry_x_axis, offset) = match b.portal_axis(state) {
    // rust: Some(x_axis) => {
    // rust: let area = largest_rectangle_around(
    // rust: entry,
    // rust: if x_axis { Axis::X } else { Axis::Z },
    // rust: 21,
    // rust: Axis::Y,
    // rust: 21,
    // rust: |p| self.world.block(p.x, p.y, p.z) == state,
    // rust: );
    // rust: let mut offset = relative_position(area, x_axis, at, width, height);
    // rust: if reset_forward {
    // rust: offset.z = 0.0;
}
    // rust: (x_axis, offset)
}
    // rust: None => (true, Vec3::new(0.5, 0.0, 0.0)),
}
        // DimensionType.getTeleportationScale: 8 out of the Nether, 1/8 into it.
    // rust: let scale = if self.dim == Dim::Nether {
    // rust: 8.0
    // rust: } else {
    // rust: 1.0 / 8.0
}
    // rust: Plan {
    // rust: dim: target,
    // rust: approximate: self.border_bounds().clamp(at.x * scale, at.y, at.z * scale),
    // rust: entry_x_axis,
    // rust: offset,
    // rust: width,
    // rust: height,
    // rust: end: false,
}
}
    /// The plan of an item or mob going through the portal block at `entry`:
    /// an End portal's fixed destination, else the Nether portal's.
    // rust: fn entity_plan(
    // rust: &self,
    // rust: entry: BlockPos,
    // rust: at: Vec3,
    // rust: width: f32,
    // rust: height: f32,
    // rust: reset_forward: bool,
    // rust: ) -> Plan {
    // rust: if !self.is_end_portal(self.world.block(entry.x, entry.y, entry.z)) {
    // rust: return self.portal_plan(entry, at, width, height, reset_forward);
}
    // rust: let spawn = self.level.world_spawn.unwrap_or_else(|| {
    // rust: self.spawn.map_or([0, 64, 0], |s| {
    // rust: [s.x.floor() as i32, s.y.floor() as i32, s.z.floor() as i32]
    // rust: })
    // rust: });
    // rust: Plan::end_portal(
    // rust: self.dim,
    // rust: BlockPos::new(spawn[0], spawn[1], spawn[2]),
    // rust: width,
    // rust: height,
    // rust: )
}
pub fn is_end_portal(self: *Self, state: horizon_world::registry::BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &*self.res.facts().get(state).name == "minecraft:end_portal"
}
    /// Where an item or mob through an End portal lands once `plan`'s level
    /// has loaded around it: the bottom centre of the End's spawn point,
    /// above the platform built below it (`EndPlatformFeature.createEndPlatform`);
    /// out of the End, the top of the shared spawn's column
    /// (`Entity.adjustSpawnLocation`).
pub fn end_portal_exit(self: *Self, plan: *Plan) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = plan.approximate;
    // rust: let centre = Vec3::new(f64::from(p.x) + 0.5, f64::from(p.y), f64::from(p.z) + 0.5);
    // rust: if plan.dim == Dim::End {
            // In the End the arrival only builds the platform: no spawn search.
    // rust: if let Err(e) = self.end_arrival(centre, &mut None) {
    // rust: log::error!("End platform: {e}");
}
    // rust: return centre;
}
    // rust: let y = self.motion_top(p.x, p.z);
    // rust: Vec3::new(centre.x, f64::from(y), centre.z)
}
    /// The nether portal blocks of the chunks within `radius` of `center`
    /// (the points of interest `PortalForcer` searches): loaded chunks as
    /// they are, the others as saved; chunks never generated have none.
pub fn portal_blocks(self: *Self, center: BlockPos, radius: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.res.behaviours();
    // rust: let chunk_radius = radius.div_euclid(16) + 1;
    // rust: let (cx, cz) = (center.x >> 4, center.z >> 4);
    // rust: let mut out = Vec::new();
    // rust: for z in cz - chunk_radius..=cz + chunk_radius {
    // rust: for x in cx - chunk_radius..=cx + chunk_radius {
    // rust: let saved;
    // rust: let chunk = match self.world.chunks.get(&(x, z)) {
    // rust: Some(c) => &**c,
    // rust: None => {
    // rust: match self
    // rust: .save
    // rust: .load(x, z, self.pack.assets.registry, world_biomes!(self))
    // rust: {
    // rust: Some(c) => {
    // rust: saved = c;
    // rust: &saved
}
    // rust: None => continue,
}
}
}
    // rust: for (s, section) in chunk.sections.iter().enumerate() {
    // rust: if !section.blocks.maybe_has(|v| {
    // rust: b.portal_axis(horizon_world::registry::BlockStateId(v))
    // rust: .is_some()
    // rust: }) {
    // rust: continue;
}
    // rust: let base = self.world.bottom_y() + 16 * s as i32;
    // rust: for y in base..base + 16 {
    // rust: for lz in 0..16 {
    // rust: for lx in 0..16 {
    // rust: let (wx, wz) = (x * 16 + lx, z * 16 + lz);
    // rust: if b.portal_axis(chunk.block(wx, y, wz)).is_some() {
    // rust: out.push(BlockPos::new(wx, y, wz));
}
}
}
}
}
}
}
    // rust: out
}
    /// The exit portal of `plan` in the loaded dimension: the closest one
    /// within reach, else one built by `PortalForcer.createPortal`.
    // rust: pub(super) fn nether_exit_portal(&mut self, plan: &Plan) -> Option<FoundRectangle> {
    // rust: let to_nether = plan.dim == Dim::Nether;
    // rust: let radius = if to_nether { 16 } else { 128 };
    // rust: let border = self.border_bounds();
    // rust: let portals = self.portal_blocks(plan.approximate, radius);
    // rust: let (min_section, max_section) = if to_nether { (0, 15) } else { (-4, 19) };
    // rust: let found = closest_portal(
    // rust: &portals,
    // rust: plan.approximate,
    // rust: to_nether,
    // rust: &border,
    // rust: min_section,
    // rust: max_section,
    // rust: );
    // rust: if let Some(found) = found {
            // NetherPortalBlock.getExitPortal: the ticket goes on the chunk
            // of the portal found.
    // rust: self.place_portal_ticket((found.x >> 4, found.z >> 4));
    // rust: let state = self.world.block(found.x, found.y, found.z);
    // rust: let x_axis = self.res.behaviours().portal_axis(state).unwrap_or(true);
    // rust: return Some(largest_rectangle_around(
    // rust: found,
    // rust: if x_axis { Axis::X } else { Axis::Z },
    // rust: 21,
    // rust: Axis::Y,
    // rust: 21,
    // rust: |p| self.world.block(p.x, p.y, p.z) == state,
    // rust: ));
}
    // rust: let logical = if to_nether { 128 } else { 384 };
    // rust: let (approximate, x_axis) = (plan.approximate, plan.entry_x_axis);
    // rust: let created = self.with_level(|b, level, ticks| {
    // rust: b.create_portal(level, ticks, approximate, x_axis, &border, logical)
    // rust: });
    // rust: let _ = self.process_level_events();
    // rust: if let Some(exit) = created {
    // rust: let dim = if to_nether {
    // rust: "minecraft:the_nether"
    // rust: } else {
    // rust: "minecraft:overworld"
}
    // rust: let corner = exit.min_corner;
    // rust: self.native_portal_create(dim, [corner.x, corner.y, corner.z]);
            // A portal built for the entity: the ticket goes on the chunk it
            // arrives in (`TeleportTransition.PLACE_PORTAL_TICKET`).
    // rust: let (at, _) = self.arrival(plan, exit);
    // rust: self.place_portal_ticket(Self::chunk_of(at));
}
    // rust: created
}
    /// `ChunkPos.containing`: the chunk a position is in.
    // rust: pub(super) fn chunk_of(at: Vec3) -> (i32, i32) {
    // rust: ((at.x.floor() as i32) >> 4, (at.z.floor() as i32) >> 4)
}
    /// `Entity.placePortalTicket`: a `TicketType.PORTAL` ticket of radius 3
    /// on `chunk` in the level in place, which keeps the area running for 300
    /// ticks with no player in it (the entity that just came through ticks
    /// there, and goes back through the portal when its cooldown ends).
    /// Only a server holds levels with tickets of their own.
    // rust: pub(super) fn place_portal_ticket(&mut self, chunk: (i32, i32)) {
    // rust: if !self.options.execution_role.is_client() {
    // rust: self.tickets.add_portal(chunk);
}
}
    /// `NetherPortalBlock.createDimensionTransition`: the arrival position
    /// and the yaw turned by.
    // rust: pub(super) fn arrival(&self, plan: &Plan, exit: FoundRectangle) -> (Vec3, f32) {
    // rust: let b = self.res.behaviours();
    // rust: let corner = exit.min_corner;
    // rust: let exit_x_axis = b
    // rust: .portal_axis(self.world.block(corner.x, corner.y, corner.z))
    // rust: .unwrap_or(true);
    // rust: let (bottom, rotation) = exit_position(
    // rust: exit,
    // rust: exit_x_axis,
    // rust: plan.entry_x_axis,
    // rust: plan.offset,
    // rust: plan.width,
    // rust: plan.height,
    // rust: );
    // rust: let border = self.border_bounds();
    // rust: let at = collision_free_position(bottom, plan.width, plan.height, &border, |p| {
    // rust: b.collision_shape(self.world.block(p.x, p.y, p.z))
    // rust: .map(|s| s.moved(Vec3::new(f64::from(p.x), f64::from(p.y), f64::from(p.z))))
    // rust: });
    // rust: (at, rotation)
}

    // ---- the player ----

    /// Whether the inventory key opens nothing: vanilla opens the screen,
    /// then `LocalPlayer.handlePortalTransitionEffect` closes it in the same
    /// tick while the player stands in a nether portal, so it is never drawn.
    /// The fading effect after leaving the portal closes nothing.
    // rust: pub(super) fn in_portal_transition(&self) -> bool {
    // rust: self.portals.client_was_inside
}

    /// The same on a server's client: `Entity.canUsePortal` (alive, not a
    /// passenger), then only the client's `setAsInsidePortal`, which drives
    /// the confusion effect (`client_portal_effect`). On a server's client
    /// `portals.player` holds only the LocalPlayer's `portalCooldown`.
    // rust: pub(super) fn client_inside_nether_portal(&mut self) {
    // rust: let alive = self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| !p.health.dead_or_dying());
    // rust: if !alive || self.riding.is_some() {
    // rust: return;
}
    // rust: if self.portals.player.cooldown > 0 {
    // rust: self.portals.player.cooldown = PLAYER_DELAY;
    // rust: } else {
    // rust: self.portals.client_inside = true;
}
}
    /// Where to wait for the destination of `plan` to load, once its level
    /// is open: the portal its points of interest lead to, or the
    /// approximate exit.
    // rust: pub(super) fn arrival_centre(&self, plan: &Plan) -> Vec3 {
    // rust: let to_nether = plan.dim == Dim::Nether;
    // rust: let portals = self.portal_blocks(plan.approximate, if to_nether { 16 } else { 128 });
    // rust: let (min_section, max_section) = if to_nether { (0, 15) } else { (-4, 19) };
    // rust: let border = self.border_bounds();
    // rust: let found = closest_portal(
    // rust: &portals,
    // rust: plan.approximate,
    // rust: to_nether,
    // rust: &border,
    // rust: min_section,
    // rust: max_section,
    // rust: );
    // rust: let centre = found.unwrap_or(plan.approximate);
    // rust: Vec3::new(
    // rust: f64::from(centre.x) + 0.5,
    // rust: f64::from(centre.y),
    // rust: f64::from(centre.z) + 0.5,
    // rust: )
}
    /// `LocalPlayer.handlePortalTransitionEffect`: whether the confusion
    /// effect grows this tick. Entering a portal closes screens other than
    /// the chat and death screens and plays `block.portal.trigger` when the
    /// effect starts from nothing.
    // rust: pub(super) fn client_portal_effect(&mut self) -> bool {
    // rust: let inside = std::mem::take(&mut self.portals.client_inside);
    // rust: self.portals.client_was_inside = inside;
    // rust: if !inside {
    // rust: return false;
}
    // rust: match self.screen {
    // rust: Screen::Playing | Screen::Chat | Screen::Dead => {}
    // rust: Screen::Inventory | Screen::Creative => {
    // rust: self.close_container();
    // rust: self.carried = None;
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
    // rust: _ => {
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
}
    // rust: if self.screen_fx.portal == 0.0 {
    // rust: let pitch = self.world.random.next_float() * 0.4 + 0.8;
    // rust: self.audio
    // rust: .play("minecraft:block.portal.trigger", None, 0.25, pitch);
}
    // rust: true
}

    // ---- other entities ----

    /// Positions before the entities move this tick, and `Entity.handlePortal`
    /// at the start of their tick: an item or mob that stayed in a portal
    /// goes through (transition time 0) and waits for its dimension.
    // rust: pub(super) fn handle_entity_portals(&mut self) {
    // rust: self.handle_portals(false);
}
    /// `Entity.handlePortal` of the boats and minecarts, which `tick_boats`
    /// and `tick_carts` move: it runs before them, from the position they
    /// ended the last tick at, as the start of a vehicle's own tick does.
    // rust: pub(super) fn handle_vehicle_portals(&mut self) {
    // rust: self.handle_portals(true);
}
pub fn handle_portals(self: *Self, vehicles: bool) void {
}
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: self.load_portal_arrivals();
    // rust: let mut leaving: Vec<(u32, BlockPos)> = Vec::new();
        // Positions before the entities move, and (only for an entity in a
        // portal, or cooling down from one, which has a state here) whether it
        // can use one: asking every entity on every tick is not worth it. The
        // vehicles' pass opens the tick and the other kinds' pass follows, so
        // each walk takes only its own group.
    // rust: let mut before = std::mem::take(&mut self.portals.before);
    // rust: if vehicles {
    // rust: before.clear();
}
    // rust: let mut ids: Vec<(u32, bool)> = Vec::new();
    // rust: let tracked = &self.portals.entities;
    // rust: for_each_entity!(entity_lists_of!(self), entity => {
    // rust: if entity.portal_size().is_some() && entity.is_vehicle() == vehicles {
    // rust: if entity.portal_from().is_none() {
    // rust: before.insert(entity.id(), entity.position());
}
    // rust: if tracked.contains_key(&entity.id()) {
    // rust: ids.push((entity.id(), entity.can_use_portal(self)));
}
}
    // rust: });
    // rust: self.portals.before = before;
    // rust: let present: std::collections::HashSet<u32> = ids.iter().map(|(id, _)| *id).collect();
        // Each pass keeps the other group's states.
    // rust: let (boats, carts) = (&self.boats, &self.carts);
    // rust: self.portals.entities.retain(|id, _| {
    // rust: let vehicle = boats.iter().any(|b| b.id == *id) || carts.iter().any(|c| c.id == *id);
    // rust: present.contains(id) || vehicle != vehicles
    // rust: });
    // rust: for (id, allowed) in ids {
    // rust: let Some(state) = self.portals.entities.get_mut(&id) else {
    // rust: continue;
}
    // rust: if let Some(entry) = state.handle(allowed, 0, ENTITY_DELAY) {
    // rust: leaving.push((id, entry));
}
    // rust: if state.cooldown == 0 && state.process.is_none() {
    // rust: self.portals.entities.remove(&id);
}
}
    // rust: for (id, entry) in leaving {
            // `Entity.teleportCrossDimension` carries the passengers: a
            // vehicle server players ride takes them along.
    // rust: if self.guest_rides(id) {
    // rust: if let Some(c) = self.carts.iter().find(|c| c.id == id) {
    // rust: self.portals.carried_motion.insert(id, c.velocity);
    // rust: self.portals.carried_at.insert(id, c.position);
    // rust: } else if let Some(b) = self.boats.iter().find(|b| b.id == id) {
    // rust: self.portals.carried_at.insert(id, b.position);
    // rust: } else if let Some(m) = self.mobs.iter().find(|m| m.id == id) {
    // rust: self.portals.carried_at.insert(id, m.position);
}
    // rust: self.portals.carrying.push((self.dim, id, entry));
    // rust: } else {
    // rust: self.send_through_portal(id, entry);
}
}
}
    /// `Entity.load`: the saved `PortalCooldown` (an entity that just came
    /// through stands in its exit portal for 300 ticks without going back).
    // rust: pub(super) fn restore_portal_cooldown(&mut self, id: u32, tag: &Tag) {
    // rust: if let Some(Tag::Int(cooldown)) = tag.get("PortalCooldown")
    // rust: && *cooldown > 0
    // rust: {
    // rust: self.portals.entities.insert(
    // rust: id,
    // rust: PortalState {
    // rust: cooldown: *cooldown,
    // rust: process: None,
    // rust: },
    // rust: );
}
}
    /// `Entity.setAsInsidePortal` on an entity that is still on its portal
    /// cooldown, whatever the portal: the cooldown restarts and it stays.
    // rust: pub(super) fn restart_portal_cooldown(&mut self, id: u32) -> bool {
    // rust: match self.portals.entities.get_mut(&id) {
    // rust: Some(state) if state.cooldown > 0 => {
    // rust: state.cooldown = ENTITY_DELAY;
    // rust: true
}
    // rust: _ => false,
}
}
    /// `Entity.setPortalCooldown` on an entity that has just spawned in a
    /// portal: it stands in the portal for 300 ticks without going through.
    // rust: pub(super) fn set_portal_cooldown(&mut self, id: u32) {
    // rust: self.portals.entities.insert(
    // rust: id,
    // rust: PortalState {
    // rust: cooldown: ENTITY_DELAY,
    // rust: process: None,
    // rust: },
    // rust: );
}
    /// `canUsePortal(false)` of a mob: what the mob itself decides
    /// (`mobs::mob_can_use_portal`), riding nothing, not asleep, and not
    /// carrying the players this side does.
    // rust: pub(super) fn mob_can_use_portal(&self, m: &horizon_client::mobs::Mob) -> bool {
    // rust: horizon_client::mobs::mob_can_use_portal(m)
    // rust: && m.extra.mount.is_none()
    // rust: && self.riding != Some(m.id)
    // rust: && (!self.guest_rides(m.id) || self.carries_riders())
}
    /// `Entity.canUsePortal(false)` for a primed TNT: it carries no mob.
    // rust: pub(super) fn tnt_can_use_portal(&self, id: u32) -> bool {
        // Id 0: not tracked yet, nothing to key its portal state by.
    // rust: id != 0 && !self.mobs.iter().any(|m| m.extra.mount == Some(id))
}
    /// `canUsePortal(false)` of a boat or minecart: it is nobody's passenger;
    /// the mobs riding it, and on a server the players, cross with it.
    // rust: pub(super) fn vehicle_can_use_portal(&self, id: u32) -> bool {
        // The window's player is moved by its own trip, not by the vehicle's.
    // rust: if self.riding == Some(id) {
    // rust: return false;
}
        // Mob riders always go along; server players only on a server.
    // rust: !self.ridden_by_guest(id) || self.carries_riders()
}
    /// Whether a vehicle can take the server players riding it through a
    /// portal: only a server moves players between its levels. Elsewhere a
    /// ridden vehicle stays, rather than leave its rider behind.
pub fn carries_riders(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.options.dedicated.is_some()
}
    /// The vehicles that went through a portal in `dim` with server players
    /// on them.
    // rust: pub(super) fn take_carrying(&mut self, dim: Dim) -> Vec<(u32, BlockPos)> {
    // rust: let (here, other) = std::mem::take(&mut self.portals.carrying)
    // rust: .into_iter()
    // rust: .partition(|(d, ..)| *d == dim);
    // rust: self.portals.carrying = other;
    // rust: here.into_iter().map(|(_, id, entry)| (id, entry)).collect()
}
    /// The plan of vehicle `id` through the portal at `entry`: from its own
    /// position and size (`getPortalDestination(level, vehicle)`). A boat or
    /// minecart, like a mob, lands in the middle of the exit portal's depth
    /// (`AbstractBoat` and `AbstractMinecart.getRelativePortalPosition`).
    // rust: pub(super) fn vehicle_plan(&self, id: u32, entry: BlockPos) -> Option<Plan> {
    // rust: let at = |own: Vec3| self.portals.carried_at.get(&id).copied().unwrap_or(own);
    // rust: if let Some(m) = self.mobs.iter().find(|m| m.id == id) {
    // rust: return Some(self.entity_plan(entry, at(m.position), m.width(), m.height(), true));
}
    // rust: if let Some(b) = self.boats.iter().find(|b| b.id == id) {
    // rust: let (width, height) = (super::boats::WIDTH as f32, super::boats::HEIGHT as f32);
    // rust: return Some(self.entity_plan(entry, at(b.position), width, height, true));
}
    // rust: let c = self.carts.iter().find(|c| c.id == id)?;
    // rust: let (width, height) = (
    // rust: super::minecarts::WIDTH as f32,
    // rust: super::minecarts::HEIGHT as f32,
    // rust: );
    // rust: Some(self.entity_plan(entry, at(c.position), width, height, true))
}
    /// `NetherPortalBlock.entityInside` and `EndPortalBlock.entityInside`
    /// for the items, mobs, empty boats and minecarts, and arrows that moved
    /// this tick: the portal blocks their box swept through (an End portal's
    /// transition time is 0 too).
    // rust: pub(super) fn find_entity_portals(&mut self) {
    // rust: self.find_portals(None);
}
    /// The same for the vehicles server players ride, once `tick_guests` has
    /// moved them: a ridden vehicle moves with its rider, after the other
    /// entities were swept, so without this pass its portal is found a tick
    /// late, from where it has already moved on to.
    // rust: pub(super) fn find_ridden_vehicle_portals(&mut self, ridden: &[u32]) {
    // rust: if !ridden.is_empty() {
    // rust: self.find_portals(Some(ridden));
}
}
pub fn find_portals(self: *Self, only: ?*[u32]) void {
}
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: let ridden = if only.is_none() {
    // rust: self.guest_vehicles()
    // rust: } else {
    // rust: Vec::new()
}
        // A trident or rocket in flight gets its id here, before the walk.
    // rust: for t in self
    // rust: .tridents
    // rust: .iter_mut()
    // rust: .filter(|t| only.is_none() && (!t.in_ground || t.previous != t.position))
    // rust: {
    // rust: super::lan_entities::assign_entity_id(&mut self.next_entity, &mut t.id);
}
    // rust: for r in self
    // rust: .rockets
    // rust: .iter_mut()
    // rust: .filter(|r| only.is_none() && r.attached_to.is_none() && !r.attached)
    // rust: {
    // rust: super::lan_entities::assign_entity_id(&mut self.next_entity, &mut r.id);
}
    // rust: let mut inside: Vec<(u32, BlockPos)> = Vec::new();
    // rust: let mut portal_sections = std::mem::take(&mut self.portals.sections);
        // The first portal block each entity's box swept through since the
        // start of its tick (a stuck arrow that did not move enters none).
    // rust: for_each_entity!(entity_lists_of!(self), entity => {
    // rust: let Some((width, height)) = entity.portal_size() else {
    // rust: continue;
}
    // rust: if !entity.portal_sweeps() || !entity.can_use_portal(self) {
    // rust: continue;
}
    // rust: let (id, to) = (entity.id(), entity.position());
    // rust: let swept_later = match only {
    // rust: Some(ids) => !ids.contains(&id),
    // rust: None => ridden.contains(&id),
}
    // rust: if swept_later {
    // rust: continue;
}
    // rust: let from = entity
    // rust: .portal_from()
    // rust: .unwrap_or_else(|| self.portals.before.get(&id).copied().unwrap_or(to));
    // rust: if let Some(pos) = self.swept_portal(from, to, width, height, &mut portal_sections) {
    // rust: inside.push((id, pos));
}
    // rust: });
    // rust: self.portals.sections = portal_sections;
    // rust: for (id, pos) in inside {
    // rust: self.portals
    // rust: .entities
    // rust: .entry(id)
    // rust: .or_default()
    // rust: .set_inside(pos, ENTITY_DELAY);
}
}
    /// The first nether or End portal block an entity box swept through
    /// (`Entity.checkInsideBlocks`, whose first portal sets the entry).
    // rust: fn swept_portal(
    // rust: &self,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: width: f32,
    // rust: height: f32,
    // rust: portal_sections: &mut horizon_client::portal_sections::PortalSections,
    // rust: ) -> Option<BlockPos> {
    // rust: let half = f64::from(width) / 2.0;
    // rust: let bounds = horizon_core::geometry::Aabb::new(
    // rust: Vec3::new(to.x - half, to.y, to.z - half),
    // rust: Vec3::new(to.x + half, to.y + f64::from(height), to.z + half),
    // rust: )
    // rust: .deflate(Vec3::new(
    // rust: f64::from(1.0e-5_f32),
    // rust: f64::from(1.0e-5_f32),
    // rust: f64::from(1.0e-5_f32),
    // rust: ));
        // Every block the sweep visits lies in the box covering both ends.
    // rust: let reach = bounds
    // rust: .union_bounds(bounds.move_by(from.subtract(to)))
    // rust: .inflate(Vec3::new(1.0, 1.0, 1.0));
    // rust: if !self.may_hold_portal(reach, portal_sections) {
    // rust: return None;
}
    // rust: let mut found = None;
    // rust: let _ = horizon_core::geometry::sweep_intersected_blocks(
    // rust: from,
    // rust: to,
    // rust: bounds,
    // rust: 1_000_000,
    // rust: |p, _| {
    // rust: let state = self.world.block(p.x, p.y, p.z);
    // rust: if self.res.behaviours().portal_axis(state).is_some()
    // rust: || (self.is_end_portal(state) && touches_end_portal(from, to, width, height, p))
    // rust: {
    // rust: found = Some(p);
    // rust: return false;
}
    // rust: true
    // rust: },
    // rust: );
    // rust: found
}
    /// Whether a section `reach` touches has a nether or End portal state in
    /// its palette: without one, no block there is a portal. Palette answers are
    /// kept per chunk across ticks (`portal_sections`); a box over many
    /// sections is not checked.
    // rust: fn may_hold_portal(
    // rust: &self,
    // rust: reach: horizon_core::geometry::Aabb,
    // rust: sections: &mut horizon_client::portal_sections::PortalSections,
    // rust: ) -> bool {
//         use horizon_client::section_mask::SectionMask;
    // rust: let (min, max) = (reach.min_position(), reach.max_position());
    // rust: if !min.is_finite() || !max.is_finite() {
    // rust: return true;
}
    // rust: let (min, max) = (BlockPos::containing(min), BlockPos::containing(max));
    // rust: let top = self.world.layout().sections() as i32 - 1;
    // rust: let (x0, x1) = (min.x >> 4, max.x >> 4);
    // rust: let (z0, z1) = (min.z >> 4, max.z >> 4);
    // rust: let (y0, y1) = (
    // rust: ((min.y - self.world.bottom_y()) >> 4).clamp(0, top),
    // rust: ((max.y - self.world.bottom_y()) >> 4).clamp(0, top),
    // rust: );
    // rust: let count = (i64::from(x1) - i64::from(x0) + 1)
    // rust: * (i64::from(y1) - i64::from(y0) + 1)
    // rust: * (i64::from(z1) - i64::from(z0) + 1);
    // rust: if count > 64 {
    // rust: return true;
}
    // rust: let y_mask = SectionMask::below(y1 as usize + 1).from(y0 as usize);
    // rust: let behaviours = self.res.behaviours();
    // rust: let chunks = &self.world.chunks;
    // rust: (x0..=x1).any(|cx| {
    // rust: (z0..=z1).any(|cz| {
    // rust: chunks.get(&(cx, cz)).is_some_and(|chunk| {
    // rust: let portals = sections.get((cx, cz), chunk, |v| {
    // rust: let state = horizon_world::registry::BlockStateId(v);
    // rust: behaviours.portal_axis(state).is_some() || self.is_end_portal(state)
    // rust: });
    // rust: !(portals & y_mask).is_empty()
    // rust: })
    // rust: })
    // rust: })
}
    /// `Entity.teleportCrossDimension` away from the loaded dimension: the
    /// entity is saved and removed, and waits for its dimension to load.
pub fn send_through_portal(self: *Self, id: u32, entry: BlockPos) void {
}
    // rust: let arrivals = self.portals.arrivals.len();
    // rust: if let Some(i) = self.dropped.iter().position(|e| e.id == id) {
    // rust: let e = &self.dropped[i];
    // rust: let plan = self.entity_plan(entry, e.position, 0.25, 0.25, false);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: let uuid = self.uuid_for(id);
    // rust: let tag = horizon_client::entity_nbt::item_entity_to_nbt(
    // rust: &self.dropped[i],
    // rust: uuid,
    // rust: self.persist_raw(id),
    // rust: );
    // rust: self.remove_dropped(i);
    // rust: self.detach_entity(id);
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
    // rust: } else if let Some(i) = self.tnts.iter().position(|t| t.id == id) {
    // rust: let t = &self.tnts[i];
    // rust: let plan = self.entity_plan(entry, t.position, 0.98, 0.98, false);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: let uuid = self.uuid_for(id);
    // rust: let t = &self.tnts[i];
    // rust: let tag = horizon_client::entity_nbt::tnt_to_nbt(
    // rust: t.position,
    // rust: t.velocity,
    // rust: t.on_ground,
    // rust: t.fuse,
    // rust: t.power,
    // rust: t.block_state_nbt(self.pack.assets.registry),
    // rust: t.rotation,
    // rust: uuid,
    // rust: self.persist_raw(id),
    // rust: );
    // rust: self.tnts.remove(i);
    // rust: self.forget_entity(id);
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
    // rust: } else if let Some(i) = self.tridents.iter().position(|t| t.id == id) {
    // rust: let plan = self.entity_plan(entry, self.tridents[i].position, 0.5, 0.5, false);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: let uuid = self.uuid_for(id);
    // rust: let tag = self.tridents[i].to_nbt(uuid, self.persist_raw(id));
    // rust: self.tridents.remove(i);
    // rust: self.forget_entity(id);
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
    // rust: } else if let Some(i) = self.rockets.iter().position(|r| r.id == id) {
    // rust: let plan = self.entity_plan(entry, self.rockets[i].position, 0.25, 0.25, false);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: let uuid = self.uuid_for(id);
    // rust: let tag = self.rockets[i].to_nbt(uuid, self.level.player_uuid, self.persist_raw(id));
    // rust: self.rockets.remove(i);
    // rust: self.forget_entity(id);
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
    // rust: } else if let Some(i) = self.orbs.iter().position(|o| o.id == id) {
    // rust: let plan = self.entity_plan(entry, self.orbs[i].position, 0.5, 0.5, false);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: let uuid = self.uuid_for(id);
    // rust: let tag = horizon_client::entity_nbt::orb_to_nbt(&self.orbs[i], uuid);
    // rust: self.orbs.remove(i);
    // rust: self.forget_entity(id);
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
    // rust: } else if let Some(i) = self.mobs.iter().position(|m| m.id == id) {
    // rust: let m = &self.mobs[i];
    // rust: let plan = self.entity_plan(entry, m.position, m.width(), m.height(), true);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: let mut tag = self.mob_tree_nbt(i);
            // Entity.removeAfterChangingDimensions drops the leash.
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: c.remove(&"leash".into());
}
    // rust: let mut gone = vec![id];
    // rust: gone.extend(self.remove_mob_riders(id));
    // rust: self.mobs.retain(|m| m.id != id);
    // rust: for g in gone {
    // rust: self.detach_entity(g);
}
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
    // rust: } else if let Some(i) = self.boats.iter().position(|b| b.id == id) {
    // rust: let b = &self.boats[i];
    // rust: let (width, height) = (super::boats::WIDTH as f32, super::boats::HEIGHT as f32);
    // rust: let plan = self.entity_plan(entry, b.position, width, height, true);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: self.release_vehicle_container(id);
    // rust: let uuid = self.uuid_for(id);
    // rust: let b = &self.boats[i];
    // rust: let mut tag = horizon_client::entity_nbt::boat_to_nbt(
    // rust: &b.entity_type(),
    // rust: b.position,
    // rust: b.velocity,
    // rust: [b.yaw, b.pitch],
    // rust: uuid,
    // rust: self.persist_raw(id),
    // rust: b.chest.then_some(&b.items[..]),
    // rust: );
            // The mobs riding it cross with it and mount it again.
    // rust: self.put_mob_passengers(&mut tag, id);
    // rust: for rider in self.remove_mob_riders(id) {
    // rust: self.detach_entity(rider);
}
    // rust: self.boats.remove(i);
    // rust: self.detach_entity(id);
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
    // rust: } else if let Some(i) = self.carts.iter().position(|c| c.id == id) {
    // rust: let c = &self.carts[i];
    // rust: let (width, height) = (
    // rust: super::minecarts::WIDTH as f32,
    // rust: super::minecarts::HEIGHT as f32,
    // rust: );
    // rust: let plan = self.entity_plan(entry, c.position, width, height, true);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: self.release_vehicle_container(id);
    // rust: let uuid = self.uuid_for(id);
    // rust: let mut tag = self.carts[i].to_nbt(uuid, self.persist_raw(id));
            // `PositionMoveRotation.of(this)` takes the cart's `getKnownMovement`:
            // `OldMinecartBehavior` clamps it to 0.4 either way along x and z.
    // rust: let m = horizon_client::entity_nbt::motion(&tag);
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: c.insert(
    // rust: "Motion".into(),
    // rust: doubles([m.x.clamp(-0.4, 0.4), m.y, m.z.clamp(-0.4, 0.4)]),
    // rust: );
}
            // The mobs riding it cross with it and mount it again.
    // rust: self.put_mob_passengers(&mut tag, id);
    // rust: for rider in self.remove_mob_riders(id) {
    // rust: self.detach_entity(rider);
}
    // rust: self.carts.remove(i);
    // rust: self.detach_entity(id);
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
    // rust: } else if let Some(i) = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .position(|p| p.id == id && (is_arrow(p) || is_portal_projectile(p)))
    // rust: {
    // rust: let p = &self.creatures.projectiles[i];
    // rust: let (width, height) = projectile_box(p);
    // rust: let plan = self.entity_plan(entry, p.position, width, height, false);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return;
}
    // rust: let uuid = self.uuid_for(id);
    // rust: let p = &self.creatures.projectiles[i];
    // rust: let in_block = p
    // rust: .arrow
    // rust: .as_ref()
    // rust: .and_then(|a| a.last_state)
    // rust: .map(|s| self.state_to_nbt(s));
    // rust: let raw = self.persist_raw(id);
    // rust: let Some(tag) =
    // rust: horizon_client::entity_nbt::arrow_to_nbt(p, uuid, p.owner_uuid, in_block, raw)
    // rust: .or_else(|| {
    // rust: horizon_client::entity_nbt::fireball_to_nbt(p, uuid, p.owner_uuid, raw)
    // rust: })
    // rust: .or_else(|| {
    // rust: horizon_client::entity_nbt::throwable_to_nbt(p, uuid, p.owner_uuid, raw)
    // rust: })
    // rust: else {
    // rust: return;
}
    // rust: self.creatures.projectiles.remove(i);
    // rust: self.forget_entity(id);
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
}
    // rust: if self.portals.arrivals.len() > arrivals {
    // rust: self.native_entity_portal(self.dim.id(), id, [entry.x, entry.y, entry.z]);
}
}
    /// Removes the mobs riding `vehicle`, and those riding them, from the
    /// level: `Entity.teleportCrossDimension` takes the whole tree with its
    /// root. Their ids.
pub fn remove_mob_riders(self: *Self, vehicle: u32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut tree = vec![vehicle];
    // rust: let mut k = 0;
    // rust: while k < tree.len() {
    // rust: let v = tree[k];
    // rust: tree.extend(
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| m.extra.mount == Some(v))
    // rust: .map(|m| m.id),
    // rust: );
    // rust: k += 1;
}
    // rust: tree.remove(0);
    // rust: self.mobs.retain(|m| !tree.contains(&m.id));
    // rust: tree
}
    /// The chunks of the arrivals still waiting to land in `dim`, for the
    /// streaming `extra` areas that light them: vanilla's portal ticket
    /// (`Entity.teleport` adds `TicketType.PORTAL` at the destination) keeps
    /// the area loaded without a player.
    // rust: pub(super) fn arrival_chunks(&self, dim: Dim) -> Vec<(i32, i32)> {
    // rust: self.portals
    // rust: .arrivals
    // rust: .iter()
    // rust: .filter(|a| a.plan.dim == dim)
    // rust: .map(|a| (a.plan.approximate.x >> 4, a.plan.approximate.z >> 4))
    // rust: .collect()
}
    /// `ServerLevel.addDuringTeleport`: the entities that arrive in the level in
    /// place join it now, before its entities tick, so a vehicle that crossed
    /// from an earlier level this server tick moves in its new level the same
    /// tick, and one that crossed from a later level stands there until the
    /// next. Only the portal arrivals join; the chunks' entities wait.
    // rust: pub(super) fn land_portal_arrivals(&mut self) {
    // rust: if self.remote.is_some() || self.portals.arrivals.is_empty() {
    // rust: return;
}
    // rust: let waiting = std::mem::take(&mut self.world.loaded_entities);
    // rust: self.resolve_arrivals();
    // rust: self.spawn_loaded_entities();
    // rust: self.world.loaded_entities.extend(waiting);
}
    /// Entities waiting for the loaded dimension whose exit area is loaded:
    /// their exit portal (found or built) or End destination, position,
    /// turned yaw and motion, and portal cooldown; they join the world with the chunk entities.
    // rust: pub(super) fn resolve_arrivals(&mut self) {
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: let mut i = 0;
    // rust: while i < self.portals.arrivals.len() {
    // rust: let plan = self.portals.arrivals[i].plan;
    // rust: let (cx, cz) = (plan.approximate.x >> 4, plan.approximate.z >> 4);
    // rust: let ready = plan.dim == self.dim
    // rust: && (-1..=1).all(|dz| (-1..=1).all(|dx| self.streaming.is_lit(cx + dx, cz + dz)));
    // rust: if !ready {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let Arrival { plan, mut tag } = self.portals.arrivals.remove(i);
    // rust: self.portals.dirty = true;
    // rust: let motion = horizon_client::entity_nbt::motion(&tag);
    // rust: let [yaw, pitch] = horizon_client::entity_nbt::rotation(&tag);
    // rust: let was_yaw = yaw;
    // rust: let (at, motion, [yaw, pitch]) = if plan.end {
                // Relative.DELTA: the motion is kept.
    // rust: let at = self.end_portal_exit(&plan);
                // EndPortalBlock.getPortalDestination: PLACE_PORTAL_TICKET.
    // rust: self.place_portal_ticket(Self::chunk_of(at));
    // rust: let into_end = plan.dim == Dim::End;
    // rust: let turn =
    // rust: end_portal_rotation(into_end, [yaw, pitch], self.level.world_spawn_angle);
    // rust: (at, motion, turn)
    // rust: } else {
    // rust: let Some(exit) = self.nether_exit_portal(&plan) else {
    // rust: continue;
}
    // rust: let (at, rotation) = self.arrival(&plan, exit);
    // rust: (at, rotate_y(motion, -rotation), [yaw + rotation, pitch])
}
    // rust: let yaw_turn = yaw - was_yaw;
    // rust: if let Some(was) = horizon_client::entity_nbt::position(&tag) {
    // rust: move_passengers(&mut tag, at.subtract(was), yaw_turn);
}
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: c.insert("Pos".into(), doubles([at.x, at.y, at.z]));
    // rust: c.insert("Motion".into(), doubles([motion.x, motion.y, motion.z]));
    // rust: c.insert(
    // rust: "Rotation".into(),
    // rust: Tag::List(vec![Tag::Float(yaw.to_bits()), Tag::Float(pitch.to_bits())]),
    // rust: );
                // setPortalCooldown before the teleport, copied by restoreFrom.
    // rust: c.insert("PortalCooldown".into(), Tag::Int(ENTITY_DELAY));
}
            // ServerLevel.addDuringTeleport: a fresh add, not loaded from disk.
    // rust: super::persist::mark_fresh(&mut tag);
    // rust: let key = ((at.x.floor() as i32) >> 4, (at.z.floor() as i32) >> 4);
    // rust: match self
    // rust: .world
    // rust: .loaded_entities
    // rust: .iter_mut()
    // rust: .find(|(k, _)| *k == key)
    // rust: {
    // rust: Some((_, tags)) => tags.push(tag),
    // rust: None => self.world.loaded_entities.push((key, vec![tag])),
}
}
}

    /// `FallingBlockEntity.tick`: block effects mark its portal, then
    /// `Entity.handlePortal` transfers it before the landing branch runs.
    // rust: pub(super) fn falling_through_portal(&mut self, f: &mut super::FallingBlock) -> Option<Dim> {
    // rust: if self.remote.is_some() {
    // rust: return None;
}
    // rust: let mut sections = std::mem::take(&mut self.portals.sections);
    // rust: let entry = self.swept_portal(f.previous, f.position, 0.98, 0.98, &mut sections);
    // rust: self.portals.sections = sections;
    // rust: if let Some(entry) = entry {
    // rust: f.portal.set_inside(entry, ENTITY_DELAY);
}
    // rust: let entry = f.portal.handle(true, 0, ENTITY_DELAY)?;
    // rust: let plan = self.entity_plan(entry, f.position, 0.98, 0.98, false);
    // rust: if !self.may_enter(plan.dim) {
    // rust: return None;
}
    // rust: let uuid = f.saved.as_ref().map_or_else(
    // rust: || {
    // rust: if f.id == 0 {
    // rust: horizon_client::save::random_uuid()
    // rust: } else {
    // rust: self.uuid_for(f.id)
}
    // rust: },
    // rust: |saved| saved.0,
    // rust: );
    // rust: let modelled = horizon_client::entity_nbt::falling_block_to_nbt(
    // rust: self.state_to_nbt(f.state),
    // rust: f.position,
    // rust: f.velocity,
    // rust: f.age,
    // rust: f.drop_item,
    // rust: f.damage,
    // rust: f.fall_distance,
    // rust: f.rotation,
    // rust: uuid,
    // rust: );
    // rust: let mut tag = super::persist::with_raw(modelled, f.saved.as_ref().map(|s| &s.1));
    // rust: if let Tag::Compound(fields) = &mut tag {
    // rust: fields.insert("PortalCooldown".into(), Tag::Int(ENTITY_DELAY));
    // rust: if f.no_gravity {
    // rust: fields.insert("NoGravity".into(), Tag::Byte(1));
    // rust: } else {
    // rust: fields.remove(&"NoGravity".into());
}
}
    // rust: if f.id != 0 {
    // rust: self.forget_entity(f.id);
}
    // rust: self.portals.arrivals.push(Arrival { plan, tag });
    // rust: self.portals.dirty = true;
    // rust: Some(plan.dim)
}

    // ---- persistence ----

pub fn arrivals_path(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_root
    // rust: .join("data")
    // rust: .join("horizon_portal_arrivals.dat")
}
    /// The waiting entities of the open world (read once).
    // rust: pub(super) fn load_portal_arrivals(&mut self) {
    // rust: if self.portals.loaded || self.remote.is_some() {
    // rust: return;
}
    // rust: self.portals.loaded = true;
    // rust: let Some(root) = horizon_client::save::read_dat(&self.arrivals_path()) else {
    // rust: return;
}
    // rust: let Some(Tag::List(list)) = root.get("arrivals") else {
    // rust: return;
}
    // rust: self.portals
    // rust: .arrivals
    // rust: .extend(list.iter().filter_map(arrival_from_tag));
}
    /// Write the waiting entities when they changed.
    // rust: pub(super) fn save_portal_arrivals(&mut self) {
    // rust: if !self.portals.dirty || self.remote.is_some() {
    // rust: return;
}
    // rust: let list = self
    // rust: .portals
    // rust: .arrivals
    // rust: .iter()
    // rust: .map(|arrival| {
    // rust: let mut tag = arrival_tag(arrival);
    // rust: if let Tag::Compound(root) = &mut tag
    // rust: && let Some(entity) = root.get_mut(&"entity".into())
    // rust: {
    // rust: super::persist::write_attachments(entity, &self.entity_attachments);
}
    // rust: tag
    // rust: })
    // rust: .collect();
    // rust: let root = Tag::compound([("arrivals", Tag::List(list))]);
    // rust: if horizon_client::save::write_dat(&self.arrivals_path(), root).is_ok() {
    // rust: self.portals.dirty = false;
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn end_portals_lead_to_the_end_spawn_and_back_to_the_world_spawn() void {
}
    // rust: let spawn = BlockPos::new(-7, 70, 12);
    // rust: for from in [Dim::Overworld, Dim::Nether] {
    // rust: let plan = Plan::end_portal(from, spawn, 0.9, 1.4);
    // rust: assert_eq!(plan.dim, Dim::End);
    // rust: assert_eq!(plan.approximate, BlockPos::new(100, 50, 0));
    // rust: assert!(plan.end);
}
    // rust: let plan = Plan::end_portal(Dim::End, spawn, 0.25, 0.25);
    // rust: assert_eq!(plan.dim, Dim::Overworld);
    // rust: assert_eq!(plan.approximate, spawn);
}

pub fn the_end_portal_shape_takes_falling_items_and_standing_mobs() void {
}
    // rust: let portal = BlockPos::new(0, 100, 3);
    // rust: let at = |y| Vec3::new(0.5, y, 3.5);
        // A dropped item falling through the slab, or in it.
    // rust: assert!(touches_end_portal(
    // rust: at(100.6),
    // rust: at(100.56),
    // rust: 0.25,
    // rust: 0.25,
    // rust: portal
    // rust: ));
        // One tick's fall across the whole slab, in it at neither end.
    // rust: assert!(touches_end_portal(at(101.0), at(99.9), 0.25, 0.25, portal));
        // Resting below the slab (on the floor) or above it.
    // rust: assert!(!touches_end_portal(
    // rust: at(100.0),
    // rust: at(100.0),
    // rust: 0.25,
    // rust: 0.25,
    // rust: portal
    // rust: ));
    // rust: assert!(!touches_end_portal(
    // rust: at(100.8),
    // rust: at(100.8),
    // rust: 0.25,
    // rust: 0.25,
    // rust: portal
    // rust: ));
        // A cow standing in the portal block.
    // rust: assert!(touches_end_portal(at(100.0), at(100.0), 0.9, 1.4, portal));
        // Beside it.
    // rust: let beside = Vec3::new(2.0, 100.0, 3.5);
    // rust: assert!(!touches_end_portal(beside, beside, 0.9, 1.4, portal));
}

pub fn end_portals_turn_entities_like_their_teleport_transition() void {
}
        // Into the End: facing west, pitch kept.
    // rust: assert_eq!(
    // rust: end_portal_rotation(true, [-30.0, 20.0], [45.0, 10.0]),
    // rust: [90.0, 20.0]
    // rust: );
        // Out of it: turned by the world spawn's yaw and pitch, pitch clamped.
    // rust: assert_eq!(
    // rust: end_portal_rotation(false, [-30.0, 20.0], [45.0, 10.0]),
    // rust: [15.0, 30.0]
    // rust: );
    // rust: assert_eq!(
    // rust: end_portal_rotation(false, [0.0, 80.0], [0.0, 30.0]),
    // rust: [0.0, 90.0]
    // rust: );
}

pub fn waiting_arrivals_keep_their_end_destination_when_saved() void {
}
    // rust: let tag = Tag::compound([("id", Tag::String("minecraft:cow".into()))]);
    // rust: for (from, dim) in [(Dim::Overworld, Dim::End), (Dim::End, Dim::Overworld)] {
    // rust: let arrival = Arrival {
    // rust: plan: Plan::end_portal(from, BlockPos::new(3, 64, -5), 0.9, 1.4),
    // rust: tag: tag.clone(),
}
    // rust: let back = arrival_from_tag(&arrival_tag(&arrival)).unwrap();
    // rust: assert_eq!(back.plan.dim, dim);
    // rust: assert_eq!(back.plan.approximate, arrival.plan.approximate);
    // rust: assert!(back.plan.end);
    // rust: assert_eq!(back.tag, tag);
}
        // Arrivals saved before End portals were Nether portal plans.
    // rust: let mut old = arrival_tag(&Arrival {
    // rust: plan: Plan::end_portal(Dim::End, BlockPos::new(0, 64, 0), 0.25, 0.25),
    // rust: tag,
    // rust: });
    // rust: if let Tag::Compound(c) = &mut old {
    // rust: c.remove(&"end".into());
}
    // rust: assert!(!arrival_from_tag(&old).unwrap().plan.end);
}
}
