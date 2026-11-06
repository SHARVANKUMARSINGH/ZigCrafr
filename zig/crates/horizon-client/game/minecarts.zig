//! Transpiled from Horizon Rust crate
//! Module: horizon-client_minecarts
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Minecarts (`AbstractMinecart` with `OldMinecartBehavior`): following
//! rails and slopes, powered and activator rails, coming off the track,
//! riding with the rider's push, pushing by players and other carts,
//! `MinecartItem` placement, `VehicleEntity` breaking, the chest, hopper,
//! furnace and TNT variants, saving, and `AbstractMinecartRenderer`'s old
//! rail-following render with the display block.
// use super::{Game, Hit, InteractTarget, Keys, entity::Entity};
// use horizon_client::actions::Action;
// use horizon_client::entity_rules::EntityRules;
// use horizon_client::{
    // rust: blocks::Fluid,
    // rust: collisions::SceneCollisions,
    // rust: containers::BlockEntity,
    // rust: items::{ItemStack, Items},
    // rust: mesher::Vertex,
    // rust: mobs::{Part, Species, Who, anim::Poses, riders},
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: scoreboard::pushable_by,
    // rust: sound_engine::{CartSound, PlayResult, SoundEngine, SoundInstance, Sounds},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, trig},
    // rust: random::RandomSource,
}
// use horizon_world::registry::BlockStateId;
// use std::{collections::HashMap, sync::Arc};

    // rust: pub(super) enum CartKind {
    // rust: Rideable,
    // rust: Chest,
    // rust: Hopper,
    // rust: Furnace,
    // rust: Tnt,
    /// `MinecartCommandBlock`: its `BaseCommandBlock` is `Minecart::command`,
    /// run by a powered activator rail (`game/command_minecarts.rs`).
    // rust: CommandBlock,
    /// `MinecartSpawner`: a `BaseSpawner` that ticks where the cart is
    /// (`Minecart::spawner`). Only `/summon` makes one: there is no item.
    // rust: Spawner,
}
    // rust: impl CartKind {
pub fn from_id(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match id.strip_prefix("minecraft:")? {
    // rust: "minecart" => Self::Rideable,
    // rust: "chest_minecart" => Self::Chest,
    // rust: "hopper_minecart" => Self::Hopper,
    // rust: "furnace_minecart" => Self::Furnace,
    // rust: "tnt_minecart" => Self::Tnt,
    // rust: "command_block_minecart" => Self::CommandBlock,
    // rust: "spawner_minecart" => Self::Spawner,
    // rust: _ => return None,
    // rust: })
}
pub fn id(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Rideable => "minecraft:minecart",
    // rust: Self::Chest => "minecraft:chest_minecart",
    // rust: Self::Hopper => "minecraft:hopper_minecart",
    // rust: Self::Furnace => "minecraft:furnace_minecart",
    // rust: Self::Tnt => "minecraft:tnt_minecart",
    // rust: Self::CommandBlock => "minecraft:command_block_minecart",
    // rust: Self::Spawner => "minecraft:spawner_minecart",
}
}
    /// `AbstractMinecart.getDropItem` and `getPickResult`: the item a cart drops and
    /// is picked as (a spawner minecart's is a plain minecart: there is no item of its own).
pub fn item(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Spawner => "minecraft:minecart",
    // rust: kind => kind.id(),
}
}
    // rust: pub(super) fn slots(self) -> usize {
    // rust: match self {
    // rust: Self::Chest => 27,
    // rust: Self::Hopper => 5,
    // rust: _ => 0,
}
}
    /// Whether this cart's `interact` passes on the client, so that
    /// `Minecraft.startUseItem` uses the held item instead: `MinecartTNT` has
    /// none of its own (`Entity.interact`), `MinecartCommandBlock.interact`
    /// needs a game master, and `Minecart.interact` a player not sneaking at
    /// an empty cart.
pub fn interact_passes(self: *Self, sneaking: bool, ridden: bool, game_master: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Tnt | Self::Spawner => true,
    // rust: Self::CommandBlock => !game_master,
    // rust: Self::Rideable => sneaking || ridden,
    // rust: Self::Chest | Self::Hopper | Self::Furnace => false,
}
}
}
    // rust: pub(super) struct Minecart {
    /// When it joined its list (`horizon_client::join_seq`); set by the list.
    // rust: pub(super) join: horizon_client::join_seq::JoinSeq,
    // rust: pub id: u32,
    // rust: pub kind: CartKind,
    // rust: pub position: Vec3,
    // rust: pub previous: Vec3,
    // rust: pub velocity: Vec3,
    // rust: pub yaw: f32,
    // rust: pub previous_yaw: f32,
    // rust: pub pitch: f32,
    // rust: pub previous_pitch: f32,
    /// Minecart's client-only accumulated turn and the passenger's eased turn.
    // rust: pub rotation_offset: f32,
    // rust: pub player_rotation_offset: f32,
    // rust: pub passenger_yaw_delta: f32,
    /// Experimental track steps, drained by the server entity tracker.
    // rust: pub lerp_steps: Vec<horizon_protocol::packets::play::MinecartStep>,
    // rust: pub flipped: bool,
    /// `AbstractMinecart.onRails`: transitions into rails need a position snap.
    // rust: on_rails: bool,
    // rust: pub(super) on_ground: bool,
    // rust: horizontal_collision: bool,
    /// The horizontal speed the cart wanted when the collision stopped it:
    /// `MinecartTNT.tick` reads the delta after the move, which a cart on a
    /// rail keeps (`AbstractMinecart.moveAlongTrack` re-applies the track's
    /// velocity), so a cart that ran into a block still counts as moving.
    // rust: collision_speed: f64,
    // rust: fall_distance: f64,
    /// The squared speed `MinecartTNT.causeFallDamage` blows up with, set by
    /// a landing of three blocks or more and taken by the cart's next tick
    /// step (vanilla explodes inside the move itself).
    // rust: fall_blast: Option<f64>,
    // rust: pub hurt_time: i32,
    // rust: pub hurt_dir: i32,
    // rust: pub damage: f32,
    /// `Entity.noGravity` (`NoGravity` in its save).
    // rust: pub no_gravity: bool,
    // rust: pub items: Vec<Option<ItemStack>>,
    /// Furnace minecarts: fuel ticks and `MinecartFurnace.push`. Its y part
    /// stays between ticks (it sets the push's length), only saving drops it.
    // rust: pub fuel: i32,
    // rust: pub push: Vec3,
    /// TNT minecarts: ticks until the explosion, -1 when not primed.
    // rust: pub fuse: i32,
    /// Hopper minecarts: an unpowered activator rail enables them.
    // rust: pub enabled: bool,
    /// Chest minecarts: the loot table rolled into `items` on load, saved
    /// again while the items are still that roll.
    // rust: pub loot: Option<horizon_client::save::RolledLoot>,
    /// `Entity.firstTick`: not ticked yet (saved as `HasTicked`).
    // rust: pub first_tick: bool,
    /// `Entity.isInWater` (`wasTouchingWater`): `AbstractMinecart.tick`
    /// updates it after the move (`updateFluidInteraction`), so the move
    /// goes by where the cart was a tick before, and a new cart's first
    /// move is a dry one.
    // rust: pub in_water: bool,
    /// Command block minecarts: the cart's `BaseCommandBlock` (command,
    /// success count, last output, output tracking). The block-only flags of
    /// `CommandBlock` stay unset.
    // rust: pub command: horizon_client::command_block::CommandBlock,
    /// `Entity.tickCount`, which `MinecartCommandBlock.activateMinecart`
    /// measures its `ACTIVATION_DELAY` against.
    // rust: pub tick_count: i32,
    /// `MinecartCommandBlock.lastActivated`.
    // rust: pub last_activated: i32,
    /// An activator rail asked for the command during this tick; it runs once
    /// the cart is back in the level (`command_minecarts.rs`).
    // rust: pub command_due: bool,
    /// Spawner minecarts: the cart's `BaseSpawner` (`Delay`, `SpawnData`,
    /// `SpawnPotentials` and the rest as a spawner block saves them).
    // rust: pub spawner: Option<Box<horizon_client::mobs::spawner::Spawner>>,
    /// The synched `DATA_ID_COMMAND_NAME` and `DATA_ID_LAST_OUTPUT`, which
    /// follow the command block only at `onUpdated`.
    // rust: pub synced_command: String,
    // rust: pub synced_output: String,
    /// `AbstractMinecart.customDisplayBlockState` (`DisplayState`): the block
    /// state's NBT form, resolved against the registry where it draws.
    // rust: pub custom_display: Option<horizon_world::nbt::Tag>,
    /// `AbstractMinecart.customDisplayOffset` (`DisplayOffset`), in sixteenths.
    // rust: pub custom_offset: Option<i32>,
}
/// `EntityType.MINECART`'s `sized(0.98F, 0.7F)`: float dimensions, widened.
    // rust: pub(super) const WIDTH: f64 = 0.98_f32 as f64;
    // rust: pub(super) const HEIGHT: f64 = 0.7_f32 as f64;
/// `EntityEvent.TNT_PRIME`. `MinecartTNT.primeFuse` broadcasts it;
/// `MinecartTNT.handleEntityEvent` answers by calling `primeFuse`.
    // rust: pub(super) const TNT_PRIME_EVENT: i8 = 70;
/// `AbstractMinecart.getDefaultDisplayOffset` (6), in sixteenths of a block, as
/// `MinecartChest` (8) and `MinecartHopper` (1) override it.
    // rust: pub(super) fn default_display_offset(kind: CartKind) -> f64 {
    // rust: match kind {
    // rust: CartKind::Chest => 8.0,
    // rust: CartKind::Hopper => 1.0,
    // rust: CartKind::Rideable
    // rust: | CartKind::Furnace
    // rust: | CartKind::Tnt
    // rust: | CartKind::CommandBlock
    // rust: | CartKind::Spawner => 6.0,
}
}
/// `AbstractMinecart.getDisplayOffset`: the saved `DisplayOffset`, else the default.
pub fn display_offset(c: *Minecart) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: c.custom_offset
    // rust: .map_or_else(|| default_display_offset(c.kind), f64::from)
}

/// World-space envelope of the cart model and its optional displayed block,
/// based on the same root position and display offset used by the renderer.
pub fn cart_render_bounds(position: Vec3, offset: f64, has_display: bool) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (bottom, top) = if has_display {
    // rust: let display_shift = 0.75 * (offset - 8.0) / 16.0;
    // rust: (
    // rust: (position.y - 0.5).min(position.y + 0.375 - 0.4 + display_shift),
    // rust: (position.y + 0.9).max(position.y + 0.375 + 0.4 + display_shift + 0.9),
    // rust: )
    // rust: } else {
    // rust: (position.y - 0.5, position.y + 0.9)
}
    // rust: Aabb::new(
    // rust: Vec3::new(position.x - 1.0, bottom, position.z - 1.0),
    // rust: Vec3::new(position.x + 1.0, top, position.z + 1.0),
    // rust: )
}
/// A display state that is air shows nothing.
    // rust: fn shown_unless_air(
    // rust: state: Option<BlockStateId>,
    // rust: is_air: impl Fn(BlockStateId) -> bool,
    // rust: ) -> Option<BlockStateId> {
    // rust: state.filter(|&s| !is_air(s))
}
/// `readAdditionalSaveData`'s `input.read("DisplayState", CODEC)` is empty
/// when the state does not decode: the cart forgets it (and no longer saves it).
    // rust: pub(super) fn forget_unreadable_display(
    // rust: c: &mut Minecart,
    // rust: resolves: impl Fn(&horizon_world::nbt::Tag) -> bool,
    // rust: ) {
    // rust: if c.custom_display.as_ref().is_some_and(|t| !resolves(t)) {
    // rust: c.custom_display = None;
}
}
/// Where the cart `id` is in `carts`: at `hint` (where it was a moment ago,
/// the usual case while carts tick in order) or found by a scan. A world
/// with hundreds of mineshaft chest carts asked this of every cart several
/// times a tick.
pub fn cart_at(carts: *[Minecart], id: u32, hint: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if carts.get(hint).is_some_and(|c| c.id == id) {
    // rust: return Some(hint);
}
    // rust: carts.iter().position(|c| c.id == id)
}
/// `AbstractMinecart.push(entity)` for a non-cart `entity` at `feet`:
/// the push the cart loses (the entity gets a quarter of it back).
    // rust: pub(super) fn cart_push_from(feet: Vec3, cart: Vec3) -> Option<(f64, f64)> {
    // rust: let (xa, za) = (feet.x - cart.x, feet.z - cart.z);
    // rust: let dd = xa * xa + za * za;
    // rust: if dd < f64::from(1.0e-4f32) {
    // rust: return None;
}
    // rust: let d = dd.sqrt();
    // rust: let pow = (1.0 / d).min(1.0);
    // rust: let k = f64::from(0.1f32) * 0.5;
    // rust: Some((xa / d * pow * k, za / d * pow * k))
}
/// `MinecartFurnace.calculateNewPushAlong`: project the push onto movement.
pub fn push_along(push: Vec3, movement: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if push.horizontal_distance_squared() > 1.0e-4 && movement.horizontal_distance_squared() > 0.001
    // rust: {
    // rust: push.projected_on(movement).normalize().scale(push.length())
    // rust: } else {
    // rust: push
}
}
/// AbstractMinecart passenger attachment Y (EntityAttachments).
pub const PASSENGER_Y: f64 = 0.1875;
/// The minecart's passenger attachment minus Player.DEFAULT_VEHICLE_ATTACHMENT.
    // rust: pub(super) const SEAT: f64 = PASSENGER_Y - 0.6;
/// The placeholder container key under which an open cart's items live.
    // rust: pub(super) const CART_KEY_Y: i32 = horizon_client::lan::menu::VEHICLE_KEY_Y;

/// `OldMinecartBehavior.pushAndPickupEntities`: living entities the cart
/// offers `startRiding` instead of `Entity.push`. Players click to board;
/// iron golems always push; a cart that already has a rider is `isVehicle`.
pub fn pickup_instead_of_push(species: Species, is_passenger: bool, cart_is_vehicle: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !cart_is_vehicle && !is_passenger && species != Species::IronGolem
}

/// `Entity.canRide` for a cart: the boarding cooldown, and a warden or the
/// wither never rides (`canRide` false).
pub fn can_ride_cart(species: Species, boarding_cooldown: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: boarding_cooldown <= 0 && !matches!(species, Species::Warden | Species::Wither)
}

/// `Entity.positionRider` on an `AbstractMinecart`: passenger attachment less
/// the rider's own vehicle attachment.
pub fn cart_seat(cart: Vec3, rider_offset: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(cart.x, cart.y + PASSENGER_Y - rider_offset, cart.z)
}

    // rust: pub(super) enum Shape {
    // rust: NorthSouth,
    // rust: EastWest,
    // rust: AscendingEast,
    // rust: AscendingWest,
    // rust: AscendingNorth,
    // rust: AscendingSouth,
    // rust: SouthEast,
    // rust: SouthWest,
    // rust: NorthWest,
    // rust: NorthEast,
}
    // rust: impl Shape {
pub fn parse(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match s {
    // rust: "east_west" => Self::EastWest,
    // rust: "ascending_east" => Self::AscendingEast,
    // rust: "ascending_west" => Self::AscendingWest,
    // rust: "ascending_north" => Self::AscendingNorth,
    // rust: "ascending_south" => Self::AscendingSouth,
    // rust: "south_east" => Self::SouthEast,
    // rust: "south_west" => Self::SouthWest,
    // rust: "north_west" => Self::NorthWest,
    // rust: "north_east" => Self::NorthEast,
    // rust: _ => Self::NorthSouth,
}
}
    // rust: pub(super) fn is_slope(self) -> bool {
    // rust: matches!(
    // rust: self,
    // rust: Self::AscendingEast | Self::AscendingWest | Self::AscendingNorth | Self::AscendingSouth
    // rust: )
}
    /// `AbstractMinecart.EXITS`.
pub fn exits(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, e, n, s) = ([-1, 0, 0], [1, 0, 0], [0, 0, -1], [0, 0, 1]);
    // rust: let below = |v: [i32; 3]| [v[0], -1, v[2]];
    // rust: match self {
    // rust: Self::NorthSouth => (n, s),
    // rust: Self::EastWest => (w, e),
    // rust: Self::AscendingEast => (below(w), e),
    // rust: Self::AscendingWest => (w, below(e)),
    // rust: Self::AscendingNorth => (n, below(s)),
    // rust: Self::AscendingSouth => (below(n), s),
    // rust: Self::SouthEast => (s, e),
    // rust: Self::SouthWest => (s, w),
    // rust: Self::NorthWest => (n, w),
    // rust: Self::NorthEast => (n, e),
}
}
}
    // rust: pub(super) struct Rail {
    // rust: name: Arc<str>,
    // rust: pub(super) shape: Shape,
    // rust: powered: bool,
}
    // rust: impl Minecart {
    /// `Minecart.tick`: stationary rotation does not turn the passenger.
    // rust: pub(super) fn accumulate_rotation(&mut self) {
    // rust: self.passenger_yaw_delta = 0.0;
    // rust: if self.kind == CartKind::Rideable && self.position.subtract(self.previous).length() > 0.01
    // rust: {
    // rust: self.rotation_offset +=
    // rust: ((f64::from(self.yaw) - f64::from(self.previous_yaw)) % 360.0) as f32;
    // rust: self.rotation_offset %= 360.0;
}
}
    /// `Minecart.positionRider`: double rotLerp, then round back to float.
    /// Only yaw follows; the player's pitch and manual look remain their own.
    // rust: pub(super) fn rotate_passenger(&mut self, yaw: &mut f32) {
    // rust: let mut delta =
    // rust: (f64::from(self.rotation_offset) - f64::from(self.player_rotation_offset)) % 360.0;
    // rust: if delta >= 180.0 {
    // rust: delta -= 360.0;
}
    // rust: if delta < -180.0 {
    // rust: delta += 360.0;
}
    // rust: let next = (f64::from(self.player_rotation_offset) + 0.5 * delta) as f32;
    // rust: let previous = *yaw;
    // rust: *yaw -= next - self.player_rotation_offset;
    // rust: self.passenger_yaw_delta = *yaw - previous;
    // rust: self.player_rotation_offset = next;
}
    /// `Entity.onGround`.
    // rust: pub(super) fn on_ground(&self) -> bool {
    // rust: self.on_ground
}
pub fn new(id: u32, kind: CartKind, position: Vec3) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: join: Default::default(),
    // rust: id,
    // rust: kind,
    // rust: position,
    // rust: previous: position,
    // rust: velocity: Vec3::ZERO,
    // rust: yaw: 0.0,
    // rust: previous_yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: previous_pitch: 0.0,
    // rust: rotation_offset: 0.0,
    // rust: player_rotation_offset: 0.0,
    // rust: passenger_yaw_delta: 0.0,
    // rust: lerp_steps: Vec::new(),
    // rust: flipped: false,
    // rust: on_rails: false,
    // rust: on_ground: false,
    // rust: horizontal_collision: false,
    // rust: collision_speed: 0.0,
    // rust: fall_distance: 0.0,
    // rust: fall_blast: None,
    // rust: hurt_time: 0,
    // rust: hurt_dir: 1,
    // rust: damage: 0.0,
    // rust: no_gravity: false,
    // rust: items: vec![None; kind.slots()],
    // rust: fuel: 0,
    // rust: push: Vec3::ZERO,
    // rust: fuse: -1,
    // rust: enabled: true,
    // rust: loot: None,
    // rust: first_tick: true,
    // rust: in_water: false,
    // rust: command: horizon_client::command_block::CommandBlock::default(),
    // rust: tick_count: 0,
    // rust: last_activated: 0,
    // rust: command_due: false,
            // A fresh `BaseSpawner`, as `MinecartSpawner`'s constructor makes.
    // rust: spawner: (kind == CartKind::Spawner).then(Default::default),
    // rust: synced_command: String::new(),
    // rust: synced_output: String::new(),
    // rust: custom_display: None,
    // rust: custom_offset: None,
}
}
pub fn bounds(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, p) = (WIDTH / 2.0, self.position);
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - w, p.y, p.z - w),
    // rust: Vec3::new(p.x + w, p.y + HEIGHT, p.z + w),
    // rust: )
}
pub fn horizontal(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.velocity.x.hypot(self.velocity.z)
}
    /// `AbstractContainerMenu.getRedstoneSignalFromContainer` of `slots`.
    // rust: pub(super) fn container_signal(slots: &[Option<ItemStack>], items: &Items) -> i32 {
    // rust: let mut total = 0.0f32;
    // rust: for s in slots.iter().flatten() {
    // rust: let max = items.get(&s.item).map_or(64, |i| i.max_stack).min(64);
    // rust: total += s.count as f32 / max as f32;
}
    // rust: total /= slots.len().max(1) as f32;
        // Mth.lerpDiscrete(total, 0, 15)
    // rust: (total * 14.0).floor() as i32 + i32::from(total > 0.0)
}
}
/// `AbstractMinecartContainer.applyNaturalSlowdown`'s keep factor, in the
/// float arithmetic vanilla uses: 0.98 plus a thousandth per empty step of the
/// comparator signal (none while a loot table is still unrolled), times 0.95
/// in water.
pub fn container_keep(signal: i32, loot_pending: bool, in_water: bool) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut keep = 0.98_f32;
    // rust: if !loot_pending {
    // rust: keep += (15 - signal) as f32 * 0.001_f32;
}
    // rust: if in_water {
    // rust: keep *= 0.95_f32;
}
    // rust: f64::from(keep)
}
    // rust: pub(super) struct CartModels {
    // rust: pub models: HashMap<CartKind, Part>,
}
    // rust: impl CartModels {
pub fn load(document: ?*horizon_client::mobs::EntityModelDocument) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kinds = [
    // rust: CartKind::Rideable,
    // rust: CartKind::Chest,
    // rust: CartKind::Hopper,
    // rust: CartKind::Furnace,
    // rust: CartKind::Tnt,
    // rust: CartKind::CommandBlock,
    // rust: CartKind::Spawner,
    // rust: ];
    // rust: let models = kinds
    // rust: .into_iter()
    // rust: .filter_map(|k| document?.model(&format!("{}#main", k.id())).map(|m| (k, m)))
    // rust: .collect();
    // rust: Self { models }
}
}
    // rust: impl Game<'_> {
    // rust: pub(super) fn rail(&self, x: i32, y: i32, z: i32) -> Option<Rail> {
    // rust: let state = self.world.block(x, y, z);
    // rust: let name = self.res.facts().get(state).name.clone();
    // rust: if !matches!(
    // rust: &*name,
    // rust: "minecraft:rail"
    // rust: | "minecraft:powered_rail"
    // rust: | "minecraft:detector_rail"
    // rust: | "minecraft:activator_rail"
    // rust: ) {
    // rust: return None;
}
    // rust: let s = self.pack.assets.registry.state(state)?;
    // rust: let shape = Shape::parse(s.properties.get("shape").map_or("", String::as_str));
    // rust: let powered = s.properties.get("powered").is_some_and(|v| v == "true");
    // rust: Some(Rail {
    // rust: name,
    // rust: shape,
    // rust: powered,
    // rust: })
}
    /// `getCurrentBlockPosOrRailBelow`.
pub fn rail_block(self: *Self, p: Vec3) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, y, z) = (p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32);
    // rust: let below = if self.minecart_improvements() {
    // rust: (p.y - 0.1 - f64::from(1.0e-5_f32)).floor() as i32
    // rust: } else {
    // rust: y - 1
}
    // rust: if self.rail(x, below, z).is_some() {
    // rust: [x, below, z]
    // rust: } else {
    // rust: [x, y, z]
}
}
pub fn conductor(self: *Self, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.res
    // rust: .facts()
    // rust: .get(self.world.block(x, y, z))
    // rust: .full_collision
}
    /// `OldMinecartBehavior.getPos`: the point on the rail under (x, y, z).
pub fn rail_pos(self: *Self, x: f64, y: f64, z: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [xt, yt, zt] = self.rail_block(Vec3::new(x, y, z));
    // rust: let rail = self.rail(xt, yt, zt)?;
    // rust: let (e0, e1) = rail.shape.exits();
    // rust: let (fx, fy, fz) = (f64::from(xt), f64::from(yt), f64::from(zt));
    // rust: let x0 = fx + 0.5 + f64::from(e0[0]) * 0.5;
    // rust: let y0 = fy + 0.0625 + f64::from(e0[1]) * 0.5;
    // rust: let z0 = fz + 0.5 + f64::from(e0[2]) * 0.5;
    // rust: let x1 = fx + 0.5 + f64::from(e1[0]) * 0.5;
    // rust: let y1 = fy + 0.0625 + f64::from(e1[1]) * 0.5;
    // rust: let z1 = fz + 0.5 + f64::from(e1[2]) * 0.5;
    // rust: let (xd, yd, zd) = (x1 - x0, (y1 - y0) * 2.0, z1 - z0);
    // rust: let progress = if xd == 0.0 {
    // rust: z - fz
    // rust: } else if zd == 0.0 {
    // rust: x - fx
    // rust: } else {
    // rust: ((x - x0) * xd + (z - z0) * zd) * 2.0
}
    // rust: let mut out = [x0 + xd * progress, y0 + yd * progress, z0 + zd * progress];
    // rust: if yd < 0.0 {
    // rust: out[1] += 1.0;
    // rust: } else if yd > 0.0 {
    // rust: out[1] += 0.5;
}
    // rust: Some(out)
}
    /// `OldMinecartBehavior.getPosOffs`.
pub fn rail_pos_offs(self: *Self, mut x: f64, y: f64, mut z: f64, offs: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [xt, yt, zt] = self.rail_block(Vec3::new(x, y, z));
    // rust: let rail = self.rail(xt, yt, zt)?;
    // rust: let mut y = f64::from(yt) + if rail.shape.is_slope() { 1.0 } else { 0.0 };
    // rust: let (e0, e1) = rail.shape.exits();
    // rust: let (mut xd, mut zd) = (f64::from(e1[0] - e0[0]), f64::from(e1[2] - e0[2]));
    // rust: let dd = xd.hypot(zd);
    // rust: xd /= dd;
    // rust: zd /= dd;
    // rust: x += xd * offs;
    // rust: z += zd * offs;
    // rust: let at = |e: [i32; 3]| x.floor() as i32 - xt == e[0] && z.floor() as i32 - zt == e[2];
    // rust: if e0[1] != 0 && at(e0) {
    // rust: y += f64::from(e0[1]);
    // rust: } else if e1[1] != 0 && at(e1) {
    // rust: y += f64::from(e1[1]);
}
    // rust: self.rail_pos(x, y, z)
}
    /// `AbstractMinecart.canCollideWith`, for `Entity.collide`'s `getEntityCollisions`:
    /// `AbstractBoat.canVehicleCollide` takes any other cart, boat, shulker or pushable mob and
    /// player, except one riding this cart. A cart that runs into one has a horizontal
    /// collision, which sets a TNT minecart off.
pub fn cart_entity_collisions(self: *Self, c: *Minecart) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let near = c.bounds().inflate(Vec3::new(2.0, 2.0, 2.0));
        // Every cart asks about every entity of the level each tick, and the box
        // turns nearly all of them away: it is tested first, before a mob's
        // pushable state, and only the boxes kept are collected.
    // rust: let close = |b: &Aabb| b.intersects(near);
    // rust: let reach = self.vehicle_mob_reach();
    // rust: let mut boxes: Vec<Aabb> = self
    // rust: .carts
    // rust: .iter()
    // rust: .filter(|o| o.id != c.id)
    // rust: .map(Minecart::bounds)
    // rust: .filter(close)
    // rust: .chain(
    // rust: self.boats
    // rust: .iter()
    // rust: .map(super::boats::Boat::bounds)
    // rust: .filter(close),
    // rust: )
    // rust: .chain(
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| reach.is_none_or(|r| r.may_meet(m, near)))
    // rust: .map(|m| (m, m.bounds()))
    // rust: .filter(|(m, b)| {
    // rust: close(b)
    // rust: && !m.removed
    // rust: && m.extra.mount != Some(c.id)
    // rust: && (m.pushable()
    // rust: || m.species() == horizon_client::mobs::Species::Shulker
    // rust: && m.alive())
    // rust: })
    // rust: .map(|(_, b)| b),
    // rust: )
    // rust: .collect();
    // rust: if self.riding != Some(c.id)
    // rust: && let Some(p) = self.player.as_ref()
    // rust: && !self.spectator()
    // rust: && close(&p.bounds())
    // rust: {
    // rust: boxes.push(p.bounds());
}
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: boxes.extend(
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| {
    // rust: host.hub.here(g)
    // rust: && g.loaded
    // rust: && !g.dead
    // rust: && !g.spectator()
    // rust: && g.vehicle != Some(c.id)
    // rust: })
    // rust: .map(|g| g.bounds())
    // rust: .filter(close),
    // rust: );
}
    // rust: boxes
}
    /// Entity.move for a cart: collisions zero the blocked components, the world border's walls
    /// among them (`CollisionGetter.borderCollision`, asked for every entity).
pub fn move_cart(self: *Self, c: *mut Minecart, delta: Vec3) void {
}
    // rust: let scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
        // A zero move stays zero whatever surrounds it (`Entity.collide`, and the
        // step-up needs a blocked horizontal move): a cart standing on its rails,
        // as most do, gathers no entity boxes.
    // rust: let entities = if delta.length_squared() == 0.0 {
    // rust: Vec::new()
    // rust: } else {
    // rust: self.cart_entity_collisions(c)
}
    // rust: let mut scene = horizon_client::collisions::EntityCollisions {
    // rust: blocks: scene,
    // rust: entities: &entities,
    // rust: border: Some((self.border.geometry(), [c.position.x, c.position.z])),
}
    // rust: if let Ok(moved) = scene.resolve(c.bounds(), delta, 0.0, c.on_ground) {
    // rust: c.position = Vec3::new(
    // rust: c.position.x + moved.x,
    // rust: c.position.y + moved.y,
    // rust: c.position.z + moved.z,
    // rust: );
    // rust: c.on_ground = delta.y < 0.0 && moved.y > delta.y;
    // rust: c.horizontal_collision =
    // rust: (moved.x - delta.x).abs() > 1.0e-7 || (moved.z - delta.z).abs() > 1.0e-7;
    // rust: if c.horizontal_collision {
    // rust: c.collision_speed = delta.x * delta.x + delta.z * delta.z;
}
    // rust: if (moved.x - delta.x).abs() > 1.0e-7 {
    // rust: c.velocity.x = 0.0;
}
    // rust: if (moved.z - delta.z).abs() > 1.0e-7 {
    // rust: c.velocity.z = 0.0;
}
    // rust: if (moved.y - delta.y).abs() > 1.0e-7 {
    // rust: c.velocity.y = 0.0;
}
            // Entity.checkFallDamage: the move's drop counts (not in water, as of
            // the tick before: `isInWater` is `wasTouchingWater`),
            // and a landing hands the whole fall to causeFallDamage, which
            // sets a TNT minecart off at (fall / 10) squared.
    // rust: if moved.y < 0.0 && !c.in_water {
    // rust: c.fall_distance -= f64::from(moved.y as f32);
}
    // rust: if c.on_ground {
    // rust: if c.kind == CartKind::Tnt && c.fall_distance >= 3.0 {
    // rust: let power = c.fall_distance / 10.0;
    // rust: c.fall_blast = Some(power * power);
}
    // rust: c.fall_distance = 0.0;
    // rust: } else if moved.y >= 0.0 {
    // rust: c.fall_distance = 0.0;
}
}
        // OldMinecartBehavior applies block effects here and at tick end.
        // NewMinecartBehavior applies them after recording each track step.
    // rust: if !self.minecart_improvements() {
    // rust: self.cart_block_effects(c);
}
}
pub fn max_speed(self: *Self, c: *Minecart) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let base = if c.in_water { 0.2 } else { 0.4 };
    // rust: if c.kind == CartKind::Furnace {
    // rust: base * if c.in_water { 0.75 } else { 0.5 }
    // rust: } else {
    // rust: base
}
}
    /// `applyNaturalSlowdown` (with `MinecartFurnace`'s push); `factor` is
    /// `getSlowdownFactor`: 0.997 riding, the empty cart's own by behavior.
pub fn natural_slowdown(self: *Self, c: *mut Minecart, ridden: bool, factor: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v = c.velocity;
    // rust: let water = c.in_water;
    // rust: if c.kind == CartKind::Furnace {
    // rust: if c.push.length_squared() > 1.0e-7 {
    // rust: c.push = push_along(c.push, v);
    // rust: v = Vec3::new(v.x * 0.8 + c.push.x, 0.0, v.z * 0.8 + c.push.z);
    // rust: if water {
    // rust: v = Vec3::new(v.x * 0.1, 0.0, v.z * 0.1);
}
    // rust: } else {
    // rust: v = Vec3::new(v.x * 0.98, 0.0, v.z * 0.98);
}
}
    // rust: if matches!(c.kind, CartKind::Chest | CartKind::Hopper) {
            // `AbstractMinecartContainer.applyNaturalSlowdown` replaces the
            // base one whole: the keep factor leans on how empty it is, and
            // riders and the behavior's own factor do not enter.
    // rust: let signal = Minecart::container_signal(&c.items, self.items());
    // rust: let keep = container_keep(signal, c.loot.is_some(), water);
    // rust: return Vec3::new(v.x * keep, 0.0, v.z * keep);
}
    // rust: let f = if ridden { 0.997 } else { factor };
    // rust: let mut out = Vec3::new(v.x * f, 0.0, v.z * f);
    // rust: if water {
            // scale(0.95F): the float widened.
    // rust: let drag = f64::from(0.95_f32);
    // rust: out = Vec3::new(out.x * drag, 0.0, out.z * drag);
}
    // rust: out
}
    /// `Entity.isVehicle` for a cart: the local player, a LAN guest or a mob
    /// sits in it. `getSlowdownFactor` (0.997) and the 0.75 speed scale key on
    /// this, not on who rides.
pub fn cart_is_vehicle(self: *Self, id: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.riding == Some(id)
    // rust: || self.ridden_by_guest(id)
    // rust: || self
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|m| !m.removed && m.extra.mount == Some(id))
}
    /// `OldMinecartBehavior.moveAlongTrack`.
pub fn move_along_track(self: *Self, c: *mut Minecart, pos: [i32; 3], rail: *Rail, intent: [f64; 2]) void {
}
    // rust: c.fall_distance = 0.0;
    // rust: let ridden = self.cart_is_vehicle(c.id);
    // rust: let (x, z) = (c.position.x, c.position.z);
    // rust: let old = self.rail_pos(x, c.position.y, z);
    // rust: let mut y = f64::from(pos[1]);
    // rust: let (mut power, mut halt) = (false, false);
    // rust: if &*rail.name == "minecraft:powered_rail" {
    // rust: power = rail.powered;
    // rust: halt = !power;
}
    // rust: let slide = if c.in_water {
    // rust: 0.0078125 * 0.2
    // rust: } else {
    // rust: 0.0078125
}
    // rust: match rail.shape {
    // rust: Shape::AscendingEast => c.velocity.x -= slide,
    // rust: Shape::AscendingWest => c.velocity.x += slide,
    // rust: Shape::AscendingNorth => c.velocity.z += slide,
    // rust: Shape::AscendingSouth => c.velocity.z -= slide,
    // rust: _ => {}
}
    // rust: if rail.shape.is_slope() {
    // rust: y += 1.0;
}
    // rust: let (e0, e1) = rail.shape.exits();
    // rust: let (mut xd, mut zd) = (f64::from(e1[0] - e0[0]), f64::from(e1[2] - e0[2]));
    // rust: let length = xd.hypot(zd);
    // rust: if c.velocity.x * xd + c.velocity.z * zd < 0.0 {
    // rust: xd = -xd;
    // rust: zd = -zd;
}
    // rust: let pow = c.horizontal().min(2.0);
    // rust: c.velocity = Vec3::new(pow * xd / length, c.velocity.y, pow * zd / length);
    // rust: if ridden
    // rust: && (intent[0] != 0.0 || intent[1] != 0.0)
    // rust: && c.velocity.x.powi(2) + c.velocity.z.powi(2) < 0.01
    // rust: {
    // rust: c.velocity.x += intent[0] * 0.001;
    // rust: c.velocity.z += intent[1] * 0.001;
    // rust: halt = false;
}
    // rust: if halt {
    // rust: if c.horizontal() < 0.03 {
    // rust: c.velocity = Vec3::ZERO;
    // rust: } else {
    // rust: c.velocity = Vec3::new(c.velocity.x * 0.5, 0.0, c.velocity.z * 0.5);
}
}
    // rust: let (fx, fz) = (f64::from(pos[0]), f64::from(pos[2]));
    // rust: let x0 = fx + 0.5 + f64::from(e0[0]) * 0.5;
    // rust: let z0 = fz + 0.5 + f64::from(e0[2]) * 0.5;
    // rust: let x1 = fx + 0.5 + f64::from(e1[0]) * 0.5;
    // rust: let z1 = fz + 0.5 + f64::from(e1[2]) * 0.5;
    // rust: let (xd, zd) = (x1 - x0, z1 - z0);
    // rust: let progress = if xd == 0.0 {
    // rust: z - fz
    // rust: } else if zd == 0.0 {
    // rust: x - fx
    // rust: } else {
    // rust: ((x - x0) * xd + (z - z0) * zd) * 2.0
}
    // rust: c.position = Vec3::new(x0 + xd * progress, y, z0 + zd * progress);
    // rust: let scale = if ridden { 0.75 } else { 1.0 };
    // rust: let max = self.max_speed(c);
    // rust: let delta = Vec3::new(
    // rust: (scale * c.velocity.x).clamp(-max, max),
    // rust: 0.0,
    // rust: (scale * c.velocity.z).clamp(-max, max),
    // rust: );
    // rust: self.move_cart(c, delta);
    // rust: let at = |e: [i32; 3], c: &Minecart| {
    // rust: c.position.x.floor() as i32 - pos[0] == e[0]
    // rust: && c.position.z.floor() as i32 - pos[2] == e[2]
}
    // rust: if e0[1] != 0 && at(e0, c) {
    // rust: c.position.y += f64::from(e0[1]);
    // rust: } else if e1[1] != 0 && at(e1, c) {
    // rust: c.position.y += f64::from(e1[1]);
}
    // rust: c.velocity = self.natural_slowdown(c, ridden, 0.96);
    // rust: if let (Some(new), Some(old)) =
    // rust: (self.rail_pos(c.position.x, c.position.y, c.position.z), old)
    // rust: {
    // rust: let speed = (old[1] - new[1]) * 0.05;
    // rust: let h = c.horizontal();
    // rust: if h > 0.0 {
    // rust: c.velocity.x *= (h + speed) / h;
    // rust: c.velocity.z *= (h + speed) / h;
}
    // rust: c.position.y = new[1];
}
    // rust: let (xn, zn) = (c.position.x.floor() as i32, c.position.z.floor() as i32);
    // rust: if xn != pos[0] || zn != pos[2] {
    // rust: let h = c.horizontal();
    // rust: c.velocity = Vec3::new(
    // rust: h * f64::from(xn - pos[0]),
    // rust: c.velocity.y,
    // rust: h * f64::from(zn - pos[2]),
    // rust: );
}
    // rust: if power {
    // rust: let h = c.horizontal();
    // rust: if h > 0.01 {
    // rust: c.velocity.x += c.velocity.x / h * 0.06;
    // rust: c.velocity.z += c.velocity.z / h * 0.06;
    // rust: } else if rail.shape == Shape::EastWest {
    // rust: if self.conductor(pos[0] - 1, pos[1], pos[2]) {
    // rust: c.velocity.x = 0.02;
    // rust: } else if self.conductor(pos[0] + 1, pos[1], pos[2]) {
    // rust: c.velocity.x = -0.02;
}
    // rust: } else if rail.shape == Shape::NorthSouth {
    // rust: if self.conductor(pos[0], pos[1], pos[2] - 1) {
    // rust: c.velocity.z = 0.02;
    // rust: } else if self.conductor(pos[0], pos[1], pos[2] + 1) {
    // rust: c.velocity.z = -0.02;
}
}
}
}
    /// `AbstractMinecart`: `minecart_improvements` picks the smoother
    /// physics.
    // rust: pub(super) fn minecart_improvements(&self) -> bool {
    // rust: self.remote
    // rust: .as_ref()
    // rust: .map_or(&self.level.enabled_features, |remote| &remote.features)
    // rust: .iter()
    // rust: .any(|f| f == "minecraft:minecart_improvements")
}
    /// `NewMinecartBehavior.getMaxSpeed`: the game rule over water's half,
    /// every cart alike (the old behavior's furnace bonus is its own).
pub fn max_speed_new(self: *Self, c: *Minecart) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from(self.ui.rules.int("max_minecart_speed")) * if c.in_water { 0.5 } else { 1.0 }
    // rust: / 20.0
}
    /// `AbstractMinecart.getRedstoneDirection` (over the old port's
    /// conductor proxy): which way a powered rail pushes a resting cart.
pub fn redstone_direction(self: *Self, pos: [i32; 3], shape: Shape) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (dx, dz) = match shape {
    // rust: Shape::NorthSouth => (0, 1),
    // rust: Shape::EastWest => (1, 0),
    // rust: _ => return Vec3::ZERO,
}
        // The push points away from the signal's side (getRedstoneDirection).
    // rust: if self.conductor(pos[0] - dx, pos[1], pos[2] - dz) {
    // rust: Vec3::new(f64::from(dx), 0.0, f64::from(dz))
    // rust: } else if self.conductor(pos[0] + dx, pos[1], pos[2] + dz) {
    // rust: Vec3::new(f64::from(-dx), 0.0, f64::from(-dz))
    // rust: } else {
    // rust: Vec3::ZERO
}
}
    /// `NewMinecartBehavior.isDecending`: the movement goes down the
    /// shape's rise.
pub fn is_descending(movement: Vec3, shape: Shape) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match shape {
    // rust: Shape::AscendingEast => movement.x < 0.0,
    // rust: Shape::AscendingWest => movement.x > 0.0,
    // rust: Shape::AscendingNorth => movement.z > 0.0,
    // rust: Shape::AscendingSouth => movement.z < 0.0,
    // rust: _ => false,
}
}
    /// `NewMinecartBehavior.setRotation`: preserve the cart's facing when
    /// motion reverses, including the pitch sign on a slope.
pub fn set_cart_rotation(c: *mut Minecart, mut yaw: f32, mut pitch: f32) void {
}
    // rust: if (175.0..=185.0).contains(&f64::from((yaw - c.yaw).abs())) {
    // rust: c.flipped = !c.flipped;
    // rust: yaw -= 180.0;
    // rust: pitch = -pitch;
}
    // rust: c.yaw = yaw % 360.0;
    // rust: c.pitch = pitch.clamp(-45.0, 45.0) % 360.0;
}
    /// `NewMinecartBehavior.MinecartStep`: wire rotations use ROTATION_BYTE.
pub fn record_cart_step(c: *mut Minecart, weight: f32) void {
}
//         use horizon_protocol::buf::pack_degrees;
    // rust: c.lerp_steps
    // rust: .push(horizon_protocol::packets::play::MinecartStep {
    // rust: position: c.position.components(),
    // rust: movement: c.velocity.components(),
    // rust: yaw: pack_degrees(c.yaw),
    // rust: pitch: pack_degrees(c.pitch),
    // rust: weight,
    // rust: });
}
    /// `NewMinecartBehavior.moveAlongTrack`: each step has its own rotation
    /// and interpolation weight, including the final off-rail move.
pub fn finish_cart_step(self: *Self, c: *mut Minecart, old: Vec3, initial: Vec3) void {
}
    // rust: let delta = old.vector_to(c.position);
    // rust: let length = delta.length();
    // rust: if length > f64::from(1.0e-5_f32) {
    // rust: if delta.horizontal_distance_squared() > f64::from(1.0e-5_f32) {
    // rust: let yaw = 180.0 - java_degrees(delta.z, delta.x) as f32
    // rust: + if c.flipped { 180.0 } else { 0.0 };
    // rust: let pitch = if c.on_ground && !c.on_rails {
    // rust: 0.0
    // rust: } else {
    // rust: (90.0 - java_degrees(delta.horizontal_distance(), delta.y) as f32)
    // rust: * if c.flipped { -1.0 } else { 1.0 }
}
    // rust: Self::set_cart_rotation(c, yaw, pitch);
    // rust: } else if !c.on_rails {
    // rust: c.pitch = if c.on_ground {
    // rust: 0.0
    // rust: } else {
    // rust: c.pitch + 0.2 * ((-c.pitch + 180.0).rem_euclid(360.0) - 180.0)
}
}
    // rust: Self::record_cart_step(c, length.min(self.max_speed_new(c)) as f32);
    // rust: } else if initial.horizontal_distance_squared() > 0.0 {
    // rust: Self::record_cart_step(c, 1.0);
}
}
    /// `NewMinecartBehavior.adjustToRails`: snap only on the first tick or
    /// when entering rails; curves project onto the segment between exits.
pub fn adjust_cart_to_rails(c: *mut Minecart, pos: [i32; 3], shape: Shape) void {
}
    // rust: let (e0, e1) = shape.exits();
    // rust: let exit =
    // rust: |e: [i32; 3]| Vec3::new(f64::from(e[0]), f64::from(e[1]), f64::from(e[2])).scale(0.5);
    // rust: let old = c.position;
    // rust: let (exit0, exit1) = (exit(e0), exit(e1));
    // rust: let center = Vec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: );
    // rust: let mut out = Vec3::new(exit0.x, 0.0, exit0.z);
    // rust: let mut into = Vec3::new(exit1.x, 0.0, exit1.z);
    // rust: if c.velocity.length() > f64::from(1.0e-5_f32) && c.velocity.dot(out) < c.velocity.dot(into)
    // rust: || Self::is_descending(into, shape)
    // rust: {
    // rust: std::mem::swap(&mut out, &mut into);
}
    // rust: let mut yaw = 180.0 - java_degrees(out.z, out.x) as f32;
    // rust: if exit0.x != exit1.x && exit0.z != exit1.z {
    // rust: let along = exit1.subtract(exit0);
    // rust: let from = c.position.subtract(center).subtract(exit0);
    // rust: let projected = along.scale(along.dot(from) / along.dot(along));
    // rust: c.position = center.add_vector(exit0).add_vector(projected);
    // rust: yaw = 180.0 - java_degrees(projected.z, projected.x) as f32;
    // rust: } else {
    // rust: if exit0.z != exit1.z {
    // rust: c.position.x = center.x;
}
    // rust: if exit0.x != exit1.x {
    // rust: c.position.z = center.z;
}
    // rust: c.position.y = center.y;
}
    // rust: let pitch = if shape.is_slope() {
    // rust: c.position.y += center.add_vector(into).distance(c.position) + 0.1;
    // rust: if c.flipped { 45.0 } else { -45.0 }
    // rust: } else {
    // rust: c.position.y += 0.1;
    // rust: 0.0
}
    // rust: Self::set_cart_rotation(c, yaw + if c.flipped { 180.0 } else { 0.0 }, pitch);
    // rust: let distance = old.distance(c.position);
    // rust: if distance > 0.0 {
    // rust: Self::record_cart_step(c, if c.first_tick { 0.0 } else { distance as f32 });
}
}
    /// `NewMinecartBehavior.moveAlongTrack`: the iteration keeps moving
    /// while distance is left, over as many rails as it takes, the speed
    /// recomputed per rail (slope, halt, boost).
pub fn move_along_track_new(self: *Self, c: *mut Minecart, intent: [f64; 2]) void {
}
        // `TrackIteration`: the slope, halt and boost speeds each apply once
        // per tick, and the iteration keeps moving while distance is left.
    // rust: let mut first = true;
    // rust: let mut movement_left = 0.0;
    // rust: let mut slope_done = false;
    // rust: let mut halted = false;
    // rust: let mut boosted = false;
    // rust: let mut step_start = c.previous;
    // rust: while first || movement_left > f64::from(1.0e-5_f32) {
    // rust: let initial = c.velocity;
    // rust: let pos = self.rail_block(c.position);
    // rust: let Some(rail) = self.rail(pos[0], pos[1], pos[2]) else {
    // rust: c.on_rails = false;
    // rust: self.come_off_track(c);
    // rust: self.finish_cart_step(c, step_start, initial);
    // rust: if first || c.position.distance(step_start) > f64::from(1.0e-5_f32) {
    // rust: self.cart_block_effects(c);
    // rust: self.cart_block_effects(c);
}
    // rust: return;
}
    // rust: if !c.on_rails {
    // rust: c.on_rails = true;
    // rust: Self::adjust_cart_to_rails(c, pos, rail.shape);
}
    // rust: c.fall_distance = 0.0;
    // rust: step_start = c.position;
    // rust: if &*rail.name == "minecraft:activator_rail" {
    // rust: self.activate_cart(c, rail.powered);
}
    // rust: let ridden = self.cart_is_vehicle(c.id);
    // rust: let initial_h = c.velocity.horizontal_distance();
    // rust: let mut v = Vec3::new(c.velocity.x, 0.0, c.velocity.z);
            // calculateSlopeSpeed (once per tick): the slide grows with the
            // speed, so a descending cart keeps its pace.
    // rust: if !slope_done {
    // rust: let slide =
    // rust: 0.0078125_f64.max(initial_h * 0.02) * if c.in_water { 0.2 } else { 1.0 };
    // rust: let before = v.horizontal_distance_squared();
    // rust: match rail.shape {
    // rust: Shape::AscendingEast => v.x -= slide,
    // rust: Shape::AscendingWest => v.x += slide,
    // rust: Shape::AscendingNorth => v.z += slide,
    // rust: Shape::AscendingSouth => v.z -= slide,
    // rust: _ => {}
}
    // rust: slope_done = v.horizontal_distance_squared() != before;
    // rust: if !slope_done {
    // rust: v = Vec3::new(c.velocity.x, 0.0, c.velocity.z);
}
}
            // calculatePlayerInputSpeed (first iteration).
    // rust: if first
    // rust: && ridden
    // rust: && (intent[0] != 0.0 || intent[1] != 0.0)
    // rust: && v.x * v.x + v.z * v.z < 0.01
    // rust: {
    // rust: let input = Vec3::new(intent[0], 0.0, intent[1])
    // rust: .normalize()
    // rust: .scale(0.001);
    // rust: let pushed = v.add_vector(input);
    // rust: if pushed.horizontal_distance_squared() != v.horizontal_distance_squared() {
    // rust: v = pushed;
    // rust: halted = true;
}
}
            // calculateHaltTrackSpeed (until the input halted).
    // rust: if !halted && &*rail.name == "minecraft:powered_rail" && !rail.powered {
    // rust: let before = v.x.hypot(v.z);
    // rust: if before < 0.03 {
    // rust: v = Vec3::ZERO;
    // rust: } else {
    // rust: v = Vec3::new(v.x * 0.5, v.y, v.z * 0.5);
}
    // rust: halted = v.x.hypot(v.z) != before;
}
            // applyNaturalSlowdown and the speed cap (first iteration).
    // rust: if first {
    // rust: c.velocity = v;
    // rust: v = self.natural_slowdown(c, ridden, 0.975);
    // rust: if v.length_squared() > 0.0 {
    // rust: let speed = v.length().min(self.max_speed_new(c));
    // rust: v = v.normalize().scale(speed);
}
}
            // calculateBoostTrackSpeed (once per tick).
    // rust: if !boosted && &*rail.name == "minecraft:powered_rail" && rail.powered {
    // rust: let before = v;
    // rust: let len = v.length();
    // rust: if len > 0.01 {
    // rust: v = v.normalize().scale(len + 0.06);
    // rust: } else {
    // rust: let dir = self.redstone_direction(pos, rail.shape);
    // rust: if dir != Vec3::ZERO {
    // rust: v = dir.scale(len + 0.2);
}
}
    // rust: boosted = v.horizontal_distance_squared() != before.horizontal_distance_squared();
    // rust: if !boosted {
    // rust: v = before;
}
}
    // rust: c.velocity = v;
    // rust: let new_h = v.horizontal_distance();
    // rust: movement_left = if first {
    // rust: new_h
    // rust: } else {
    // rust: movement_left + (new_h - initial_h)
}
    // rust: movement_left = self.new_step_along_track(c, pos, &rail, movement_left);
    // rust: self.finish_cart_step(c, step_start, initial);
            // NewMinecartBehavior.moveAlongTrack applies block effects twice,
            // after recording the step, including a stationary first step.
    // rust: if first || c.position.distance(step_start) > f64::from(1.0e-5_f32) {
    // rust: self.cart_block_effects(c);
    // rust: self.cart_block_effects(c);
}
    // rust: first = false;
}
}
    /// `NewMinecartBehavior.stepAlongTrack`: toward the rail's exit, the
    /// hill's Y projected, a V of opposing slopes resting a slow cart.
    // rust: fn new_step_along_track(
    // rust: &mut self,
    // rust: c: &mut Minecart,
    // rust: pos: [i32; 3],
    // rust: rail: &Rail,
    // rust: mut movement_left: f64,
    // rust: ) -> f64 {
    // rust: if movement_left < f64::from(1.0e-5_f32) {
    // rust: return 0.0;
}
    // rust: let old = c.position;
    // rust: let (e0, e1) = rail.shape.exits();
    // rust: let movement = Vec3::new(c.velocity.x, 0.0, c.velocity.z);
    // rust: if movement.length() < f64::from(1.0e-5_f32) {
    // rust: c.velocity = Vec3::ZERO;
    // rust: return 0.0;
}
    // rust: let in_hill = e0[1] != e1[1];
    // rust: let mut out_dir = Vec3::new(f64::from(e0[0]) * 0.5, 0.0, f64::from(e0[2]) * 0.5);
    // rust: let in_dir = Vec3::new(f64::from(e1[0]) * 0.5, 0.0, f64::from(e1[2]) * 0.5);
    // rust: if movement.dot(out_dir) < movement.dot(in_dir) {
    // rust: out_dir = in_dir;
}
    // rust: let out_len = out_dir.x.hypot(out_dir.z);
    // rust: let mut out_pos = Vec3::new(
    // rust: f64::from(pos[0]) + 0.5 + out_dir.x + out_dir.x / out_len * f64::from(1.0e-5_f32),
    // rust: f64::from(pos[1]) + 0.1,
    // rust: f64::from(pos[2]) + 0.5 + out_dir.z + out_dir.z / out_len * f64::from(1.0e-5_f32),
    // rust: );
    // rust: if in_hill && !Self::is_descending(c.velocity, rail.shape) {
    // rust: out_pos.y += 1.0;
}
    // rust: let towards_out = c.position.vector_to(out_pos).normalize();
        // The movement turns onto the exit's direction, at the same speed
        // (`this.setDeltaMovement(movement)` at stepAlongTrack's end).
    // rust: let h_speed = movement.x.hypot(movement.z);
    // rust: let th = towards_out.x.hypot(towards_out.z);
    // rust: let movement = towards_out.scale(h_speed / th);
    // rust: let mut new_pos = if in_hill {
    // rust: old.add_vector(
    // rust: movement
    // rust: .normalize()
    // rust: .scale(movement_left * f64::from(std::f32::consts::SQRT_2)),
    // rust: )
    // rust: } else {
    // rust: old.add_vector(movement.normalize().scale(movement_left))
}
    // rust: if out_pos.distance(old) <= new_pos.distance(old) {
    // rust: movement_left = out_pos.vector_to(new_pos).horizontal_distance();
    // rust: new_pos = out_pos;
    // rust: } else {
    // rust: movement_left = 0.0;
}
    // rust: self.move_cart(c, old.vector_to(new_pos));
    // rust: if in_hill {
    // rust: let new_block = [
    // rust: new_pos.x.floor() as i32,
    // rust: new_pos.y.floor() as i32,
    // rust: new_pos.z.floor() as i32,
    // rust: ];
    // rust: if let Some(new_rail) = self.rail(new_block[0], new_block[1], new_block[2]) {
                // restAtVShape: opposing slopes rest a slow cart.
    // rust: if c.velocity.length_squared() < 0.005
    // rust: && new_rail.shape.is_slope()
    // rust: && Self::is_descending(c.velocity, rail.shape)
    // rust: && !Self::is_descending(c.velocity, new_rail.shape)
    // rust: {
    // rust: c.velocity = Vec3::ZERO;
    // rust: return 0.0;
}
}
    // rust: let h_dist = (out_pos.x - c.position.x).hypot(out_pos.z - c.position.z);
    // rust: let project = out_pos.y
    // rust: + if Self::is_descending(movement, rail.shape) {
    // rust: h_dist
    // rust: } else {
    // rust: -h_dist
}
    // rust: if c.position.y < project {
    // rust: c.position.y = project;
}
}
        // The cart did not move but the step would have: it is stuck.
    // rust: if c.position.distance(old) < f64::from(1.0e-5_f32)
    // rust: && new_pos.distance(old) > f64::from(1.0e-5_f32)
    // rust: {
    // rust: c.velocity = Vec3::ZERO;
    // rust: return 0.0;
}
    // rust: c.velocity = movement;
    // rust: movement_left
}
    /// `comeOffTrack`.
pub fn come_off_track(self: *Self, c: *mut Minecart) void {
}
    // rust: let max = if self.minecart_improvements() {
    // rust: self.max_speed_new(c)
    // rust: } else {
    // rust: self.max_speed(c)
}
    // rust: c.velocity.x = c.velocity.x.clamp(-max, max);
    // rust: c.velocity.z = c.velocity.z.clamp(-max, max);
    // rust: if c.on_ground {
    // rust: c.velocity = Vec3::new(c.velocity.x * 0.5, c.velocity.y * 0.5, c.velocity.z * 0.5);
}
    // rust: let v = c.velocity;
    // rust: self.move_cart(c, v);
        // Entity.move's last step: soul sand and honey slow a derailed cart.
        // The rail paths set the track's velocity again after their move, so
        // the factor changes nothing there (measured on a rail over soul sand).
    // rust: let factor = crate::motion::block_speed_factor_at(
    // rust: &self.world,
    // rust: &self.motion.blocks,
    // rust: c.position,
    // rust: None,
    // rust: );
    // rust: c.velocity = horizon_world::entity_move::scale_by_block_speed(c.velocity, factor);
        // `comeOffTrack` moves the cart and keeps the delta the move resolved
        // (then scales it by the air drag), so a cart an obstacle stopped here
        // is not moving any more and `MinecartTNT.tick` does not detonate it -
        // unlike the rail paths, which re-apply the track's velocity.
    // rust: c.collision_speed = 0.0;
    // rust: if !c.on_ground {
            // scale(getAirDrag()): 0.95F, widened.
    // rust: let drag = f64::from(0.95_f32);
    // rust: c.velocity = Vec3::new(
    // rust: c.velocity.x * drag,
    // rust: c.velocity.y * drag,
    // rust: c.velocity.z * drag,
    // rust: );
}
}
    /// `applyEffectsFromBlocks` for a cart: a bubble column lifts or drags it
    /// and resets the fall distance.
pub fn cart_block_effects(self: *Self, c: *mut Minecart) void {
}
    // rust: if c.push_by_bubble_column(
    // rust: &self.world,
    // rust: self.pack.assets.registry,
    // rust: self.res.facts(),
    // rust: self.collision,
    // rust: ) {
    // rust: c.fall_distance = 0.0;
}
}
    /// Runs `push_from_cart` for the cart being ticked (`c` is a copy of the
    /// stored one): the stored cart is replaced by `c` for the push and `c`
    /// takes back what the push changed.
pub fn push_from_ticked_cart(self: *Self, c: *mut Minecart) void {
}
    // rust: let Some(i) = self.carts.iter().position(|x| x.id == c.id) else {
    // rust: return;
}
    // rust: self.carts[i] = c.clone();
    // rust: self.push_from_cart(i);
    // rust: if let Some(i) = self.carts.iter().position(|x| x.id == c.id) {
    // rust: *c = self.carts[i].clone();
}
}
    /// `AbstractMinecart.tick` for one cart; returns false once it is gone.
pub fn tick_cart(self: *Self, c: *mut Minecart, intent: [f64; 2]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: c.tick_count += 1;
    // rust: c.previous = c.position;
    // rust: c.previous_yaw = c.yaw;
    // rust: c.previous_pitch = c.pitch;
    // rust: c.hurt_time = (c.hurt_time - 1).max(0);
    // rust: c.damage = (c.damage - 1.0).max(0.0);
        // NewMinecartBehavior.tick snaps a newly created cart before gravity.
    // rust: if self.minecart_improvements() && c.first_tick {
    // rust: let pos = self.rail_block(c.position);
    // rust: if let Some(rail) = self.rail(pos[0], pos[1], pos[2]) {
    // rust: c.on_rails = true;
    // rust: Self::adjust_cart_to_rails(c, pos, rail.shape);
    // rust: } else {
    // rust: c.on_rails = false;
}
}
        // applyGravity
    // rust: c.velocity.y -= c.get_gravity();
    // rust: let pos = self.rail_block(c.position);
    // rust: if self.minecart_improvements() {
    // rust: self.move_along_track_new(c, intent);
    // rust: } else if let Some(rail) = self.rail(pos[0], pos[1], pos[2]) {
    // rust: self.move_along_track(c, pos, &rail, intent);
    // rust: if &*rail.name == "minecraft:activator_rail" {
    // rust: self.activate_cart(c, rail.powered);
}
    // rust: } else {
    // rust: self.come_off_track(c);
}
    // rust: c.first_tick = false;
        // The old behavior derives yaw once per tick; the experiment has
        // already recorded each step's yaw and pitch.
    // rust: if !self.minecart_improvements() {
    // rust: let (xd, zd) = (c.previous.x - c.position.x, c.previous.z - c.position.z);
    // rust: if xd * xd + zd * zd > 0.001 {
    // rust: c.yaw = zd.atan2(xd).to_degrees() as f32;
    // rust: if c.flipped {
    // rust: c.yaw += 180.0;
}
}
    // rust: let diff = (c.yaw - c.previous_yaw + 180.0).rem_euclid(360.0) - 180.0;
    // rust: if !(-170.0..170.0).contains(&diff) {
    // rust: c.yaw += 180.0;
    // rust: c.flipped = !c.flipped;
}
    // rust: c.yaw %= 360.0;
}
    // rust: if !self.minecart_improvements() {
    // rust: self.cart_block_effects(c);
}
        // OldMinecartBehavior.tick ends with pushAndPickupEntities, before
        // AbstractMinecart.tick's updateFluidInteraction. The experiment still
        // uses this fallback until its per-move pickup/push retry is ported.
    // rust: self.push_from_ticked_cart(c);
        // AbstractMinecart.tick: updateFluidInteraction, a stream pushes the cart.
    // rust: c.in_water = c.push_by_fluid(&self.world, &self.res.motion().fluids).0 > 0.0;
        // updateFluidInteraction: being in water resets the fall distance.
    // rust: if c.in_water {
    // rust: c.fall_distance = 0.0;
}
        // Entity.checkInsideBlocks runs once after the cart tick, sweeping every
        // movement through powder snow. PowderSnowBlock uses getKnownMovement,
        // which is getDeltaMovement for a minecart.
    // rust: self.entity_powder_snow_particles(c.previous, c.position, c.bounds(), c.velocity, false);
    // rust: if self.minecart_improvements() {
            // MinecartTNT.tick reads the final delta after AbstractMinecart.tick,
            // including the pushes and fluid interaction after the track steps.
    // rust: c.collision_speed = c.velocity.horizontal_distance_squared();
}
        // Variants.
    // rust: match c.kind {
    // rust: CartKind::Furnace => {
    // rust: if c.fuel > 0 {
    // rust: c.fuel -= 1;
}
    // rust: if c.fuel <= 0 {
    // rust: c.push = Vec3::ZERO;
}
    // rust: if c.fuel > 0 && self.world.random.next_int_bound(4).unwrap_or(1) == 0 {
    // rust: let at = [c.position.x, c.position.y + 0.8, c.position.z];
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::LargeSmoke),
    // rust: at,
    // rust: [0.0; 3],
    // rust: );
}
}
    // rust: CartKind::Tnt => {
                // MinecartTNT.causeFallDamage ran inside the move.
    // rust: if let Some(speed_sqr) = c.fall_blast.take() {
    // rust: self.explode_cart(c, speed_sqr);
    // rust: return false;
}
                // MinecartTNT.tick: the fuse and the collision check are separate.
    // rust: if c.fuse > 0 {
    // rust: c.fuse -= 1;
    // rust: let at = [c.position.x, c.position.y + 0.5, c.position.z];
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(ParticleType::Smoke), at, [0.0; 3]);
    // rust: } else if c.fuse == 0 {
                    // explode(horizontalDistanceSqr()): a rising cart's
                    // vertical speed adds nothing.
    // rust: let speed = c.velocity.x * c.velocity.x + c.velocity.z * c.velocity.z;
    // rust: self.explode_cart(c, speed);
    // rust: return false;
}
    // rust: if tnt_ignites_by_collision(c.horizontal_collision, c.collision_speed) {
    // rust: self.explode_cart(c, c.collision_speed);
    // rust: return false;
}
}
            // MinecartSpawner.tick: `BaseSpawner.serverTick` at the cart's block.
    // rust: CartKind::Spawner => {
    // rust: if let Some(mut spawner) = c.spawner.take() {
    // rust: let key = (
    // rust: c.position.x.floor() as i32,
    // rust: c.position.y.floor() as i32,
    // rust: c.position.z.floor() as i32,
    // rust: );
    // rust: let _ = self.server_tick_spawner_of(key, &mut spawner, Some(c.id));
    // rust: c.spawner = Some(spawner);
}
}
    // rust: _ => {}
}
    // rust: true
}
    /// `activateMinecart` on an activator rail.
pub fn activate_cart(self: *Self, c: *mut Minecart, powered: bool) void {
}
    // rust: match c.kind {
    // rust: CartKind::Rideable if powered => {
                // Minecart.activateMinecart: ejectPassengers.
    // rust: if self.riding == Some(c.id) {
    // rust: self.riding = None;
}
    // rust: let y = c.position.y;
    // rust: for m in self.mobs.iter_mut().filter(|m| m.extra.mount == Some(c.id)) {
    // rust: let at = Vec3::new(m.position.x, m.position.y.max(y), m.position.z);
    // rust: riders::stop_riding(m, Some(at));
    // rust: m.previous = at;
}
    // rust: if c.hurt_time == 0 {
    // rust: c.hurt_dir = -c.hurt_dir;
    // rust: c.hurt_time = 10;
    // rust: c.damage = 50.0;
}
}
    // rust: CartKind::Tnt if powered && c.fuse < 0 => self.prime_cart(c),
    // rust: CartKind::Hopper => c.enabled = !powered,
            // MinecartCommandBlock.activateMinecart: the command runs at most
            // every ACTIVATION_DELAY ticks.
    // rust: CartKind::CommandBlock if powered && c.tick_count - c.last_activated >= 4 => {
    // rust: c.command_due = true;
    // rust: c.last_activated = c.tick_count;
}
    // rust: _ => {}
}
}
    /// `MinecartTNT.primeFuse`: fuse 80, then `Level.broadcastEntityEvent`
    /// (`EntityEvent.TNT_PRIME`, 70) and `SoundEvents.TNT_PRIMED`. A client
    /// that receives 70 only sets the fuse (`handleEntityEvent`).
pub fn prime_cart(self: *Self, c: *mut Minecart) void {
}
    // rust: if !self.ui.rules.bool("tnt_explodes") {
    // rust: return;
}
    // rust: c.fuse = 80;
    // rust: let at = [c.position.x, c.position.y, c.position.z];
    // rust: let id = c.id as i32;
    // rust: self.lan_entity_event(id, TNT_PRIME_EVENT, at);
    // rust: self.audio
    // rust: .play("minecraft:entity.tnt.primed", Some(at), 1.0, 1.0);
}
    /// `MinecartTNT.handleEntityEvent`: event 70 calls `primeFuse`, which on a
    /// client only sets the fuse to 80. The window then counts it down
    /// (`MinecartTNT.tick`) for the smoke, the flash and the swell.
    // rust: pub(super) fn remote_tnt_cart_event(&mut self, id: i32, event: i8) {
    // rust: if event != TNT_PRIME_EVENT {
    // rust: return;
}
    // rust: if let Some(c) = self
    // rust: .carts
    // rust: .iter_mut()
    // rust: .find(|c| c.id == id as u32 && c.kind == CartKind::Tnt)
    // rust: {
    // rust: c.fuse = 80;
}
}
pub fn explode_cart(self: *Self, c: *Minecart, speed_sqr: f64) void {
}
    // rust: if !self.ui.rules.bool("tnt_explodes") {
    // rust: return;
}
    // rust: let speed = speed_sqr.sqrt().min(5.0);
    // rust: let r = self.world.random.next_double();
    // rust: let power = (4.0 + r * 1.5 * speed) as f32;
    // rust: let at = [c.position.x, c.position.y, c.position.z];
        // The cart is the explosion's source: it is gone before the blast
        // looks for entities, so it can't hit itself.
    // rust: if let Some(i) = self.carts.iter().position(|x| x.id == c.id) {
    // rust: self.eject_cart_mobs(i);
}
    // rust: self.release_vehicle_container(c.id);
    // rust: self.carts.retain(|x| x.id != c.id);
        // ExplosionInteraction.TNT: the tnt_explosion_drop_decay rule.
    // rust: let interaction = self.destroy_type("tnt_explosion_drop_decay");
        // MinecartTNT.isPrimed (fuse > -1): a cart that ran into a wall or
        // fell unprimed blows rails up like any blast.
    // rust: self.combat.rail_proof_blast = c.fuse >= 0;
    // rust: self.combat.explosion_in_water = self.bounds_in_water(c.bounds());
    // rust: let _ = self.with_hive_emptying_blast(|g| g.server_explode(at, power, interaction, false));
    // rust: self.combat.explosion_in_water = false;
    // rust: self.combat.rail_proof_blast = false;
}
    /// `AbstractMinecart.push` from each player walking into a cart
    /// (`LivingEntity.pushEntities`): the window's player and every server
    /// player (single player's own on its server thread, LAN guests). A
    /// player in a vehicle pushes nothing here. The quarter push the player
    /// gets back only moves the server's copy of it (`Entity.push` marks
    /// `needsSync`, which `ServerEntity` sends to the other players only),
    /// so no player feels it.
pub fn push_carts(self: *Self) void {
}
    // rust: if self.carts.is_empty() {
    // rust: return;
}
        // (feet, box)
    // rust: let mut pushers: Vec<(Vec3, Aabb)> = Vec::new();
    // rust: if self.riding.is_none()
    // rust: && let Some(p) = self.player.as_ref()
    // rust: {
    // rust: pushers.push((p.position, p.bounds()));
}
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: for g in host.hub.guests.iter().filter(|g| {
    // rust: host.hub.here(g) && g.loaded && !g.dead && !g.spectator() && g.vehicle.is_none()
    // rust: }) {
    // rust: let [x, y, z] = g.position;
    // rust: pushers.push((Vec3::new(x, y, z), g.bounds()));
}
}
    // rust: let cells =
    // rust: horizon_client::mobs::seen_grid::SeenGrid::new(self.carts.iter().map(Minecart::bounds));
    // rust: let mut near = Vec::new();
    // rust: for (feet, bb) in pushers {
    // rust: if !cells.candidates(bb, &mut near) {
    // rust: near.extend(0..self.carts.len() as u32);
}
    // rust: for &k in &near {
    // rust: let k = k as usize;
    // rust: let c = &mut self.carts[k];
    // rust: if !bb.intersects(c.bounds()) {
    // rust: continue;
}
    // rust: let (mut xa, mut za) = (feet.x - c.position.x, feet.z - c.position.z);
    // rust: let dd = xa * xa + za * za;
    // rust: if dd < f64::from(1.0e-4f32) {
    // rust: continue;
}
    // rust: let d = dd.sqrt();
    // rust: let pow = (1.0 / d).min(1.0);
    // rust: xa = xa / d * pow * f64::from(0.1f32) * 0.5;
    // rust: za = za / d * pow * f64::from(0.1f32) * 0.5;
    // rust: c.velocity.x -= xa;
    // rust: c.velocity.z -= za;
}
}
    // rust: self.push_carts_from_mobs(&cells);
}
    /// `AbstractMinecart.push(mob)` from each mob walking into a cart
    /// (`LivingEntity.pushEntities` -> `doPush`): the cart gets the push and
    /// the mob a quarter of it back (`Entity.push`, which needs the mob to be
    /// pushable and to carry no one). Bats push nothing (`Bat.pushEntities`).
pub fn push_carts_from_mobs(self: *Self, cells: *horizon_client::mobs::seen_grid::SeenGrid) void {
}
    // rust: let teams = self.mob_teams();
        // (mob index, feet, box)
    // rust: let pushers: Vec<(usize, Vec3, Aabb)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| {
    // rust: !m.removed
    // rust: && m.alive()
    // rust: && m.species() != Species::Bat
    // rust: && pushable_by(teams.of(Who::Mob(m.id)), None, true)
    // rust: })
    // rust: .map(|(j, m)| (j, m.position, m.bounds()))
    // rust: .collect();
    // rust: drop(teams);
    // rust: let mut near = Vec::new();
    // rust: for (j, feet, bb) in pushers {
    // rust: if !cells.candidates(bb, &mut near) {
    // rust: near.extend(0..self.carts.len() as u32);
}
    // rust: for &k in &near {
    // rust: let k = k as usize;
    // rust: let c = &mut self.carts[k];
                // hasPassenger(mob): a mob in this cart never pushes it.
    // rust: if self.mobs[j].extra.mount == Some(c.id) || !bb.intersects(c.bounds()) {
    // rust: continue;
}
    // rust: let Some((xa, za)) = cart_push_from(feet, c.position) else {
    // rust: continue;
}
    // rust: c.velocity.x -= xa;
    // rust: c.velocity.z -= za;
    // rust: let m = &mut self.mobs[j];
    // rust: if m.pushable() && m.rider.is_none() && m.extra.rider.is_none() {
    // rust: m.velocity.x += xa / 4.0;
    // rust: m.velocity.z += za / 4.0;
    // rust: m.needs_sync = true;
}
}
}
}
    /// `OldMinecartBehavior.pushAndPickupEntities` for carts, at the end of
    /// cart `i`'s own tick: each other cart in its box (0.2 wider on each
    /// side) gets `push(cart i)`. Running it per cart, after that cart moved
    /// and before the next one does, is what splits stacked carts apart.
pub fn push_from_cart(self: *Self, i: usize) void {
}
    // rust: let reach = f64::from(0.2f32);
    // rust: let hitbox = self.carts[i].bounds().inflate(Vec3::new(reach, 0.0, reach));
    // rust: for j in 0..self.carts.len() {
    // rust: if j == i || !hitbox.intersects(self.carts[j].bounds()) {
    // rust: continue;
}
            // AbstractMinecart.push(entity): `this` is cart j, `entity` cart i.
    // rust: let (this, other) = (&self.carts[j], &self.carts[i]);
    // rust: let (mut xa, mut za) = (
    // rust: other.position.x - this.position.x,
    // rust: other.position.z - this.position.z,
    // rust: );
    // rust: let dd = xa * xa + za * za;
    // rust: if dd < f64::from(1.0e-4f32) {
    // rust: continue;
}
    // rust: let d = dd.sqrt();
    // rust: xa /= d;
    // rust: za /= d;
    // rust: let pow = (1.0 / d).min(1.0);
    // rust: xa = xa * pow * f64::from(0.1f32) * 0.5;
    // rust: za = za * pow * f64::from(0.1f32) * 0.5;
            // pushOtherMinecart (old movement): only along this cart's facing.
    // rust: let dir = glam::DVec2::new(
    // rust: other.position.x - this.position.x,
    // rust: other.position.z - this.position.z,
    // rust: )
    // rust: .normalize_or_zero();
    // rust: let r = f64::from(this.yaw * 0.017453292f32);
    // rust: let facing = glam::DVec2::new(f64::from(trig::cos(r)), f64::from(trig::sin(r)))
    // rust: .normalize_or_zero();
    // rust: if dir.dot(facing).abs() < f64::from(0.8f32) {
    // rust: continue;
}
    // rust: let (mt, mo) = (this.velocity, other.velocity);
    // rust: let (ft, fo) = (
    // rust: this.kind == CartKind::Furnace,
    // rust: other.kind == CartKind::Furnace,
    // rust: );
    // rust: let (nt, no) = if fo && !ft {
    // rust: (
    // rust: Vec3::new(mt.x * 0.2 + (mo.x - xa), mt.y, mt.z * 0.2 + (mo.z - za)),
    // rust: Vec3::new(mo.x * 0.95, mo.y, mo.z * 0.95),
    // rust: )
    // rust: } else if !fo && ft {
    // rust: (
    // rust: Vec3::new(mt.x * 0.95, mt.y, mt.z * 0.95),
    // rust: Vec3::new(mo.x * 0.2 + (mt.x + xa), mo.y, mo.z * 0.2 + (mt.z + za)),
    // rust: )
    // rust: } else {
    // rust: let (xdd, zdd) = ((mo.x + mt.x) / 2.0, (mo.z + mt.z) / 2.0);
    // rust: (
    // rust: Vec3::new(mt.x * 0.2 + (xdd - xa), mt.y, mt.z * 0.2 + (zdd - za)),
    // rust: Vec3::new(mo.x * 0.2 + (xdd + xa), mo.y, mo.z * 0.2 + (zdd + za)),
    // rust: )
}
    // rust: self.carts[j].velocity = nt;
    // rust: self.carts[i].velocity = no;
}
    // rust: self.pickup_from_cart(i);
}
    /// `OldMinecartBehavior.pushAndPickupEntities` for living entities in cart
    /// `i`'s box (0.2 wider on each side): only a rideable cart moving at
    /// `horizontalDistanceSqr() >= 0.01` picks up; an eligible mob boards an
    /// empty cart (`startRiding`); others get `Entity.push`.
pub fn pickup_from_cart(self: *Self, i: usize) void {
}
    // rust: let v = self.carts[i].velocity;
    // rust: if self.carts[i].kind != CartKind::Rideable || v.x * v.x + v.z * v.z < 0.01 {
    // rust: return;
}
    // rust: let reach = f64::from(0.2f32);
    // rust: let id = self.carts[i].id;
    // rust: let pos = self.carts[i].position;
    // rust: let hitbox = self.carts[i].bounds().inflate(Vec3::new(reach, 0.0, reach));
    // rust: let mut occupied = self.riding == Some(id)
    // rust: || self.ridden_by_guest(id)
    // rust: || self.mobs.iter().any(|m| m.extra.mount == Some(id));
    // rust: let teams = self.mob_teams();
    // rust: let candidates: Vec<u32> = (0..self.mobs.len())
    // rust: .filter(|&j| {
    // rust: let m = &self.mobs[j];
                // The box first: it turns away nearly every mob of the level.
    // rust: if m.removed || m.extra.mount == Some(id) || !hitbox.intersects(m.bounds()) {
    // rust: return false;
}
    // rust: m.pushable() && pushable_by(None, teams.of(Who::Mob(m.id)), true)
    // rust: })
    // rust: .map(|j| self.mobs[j].id)
    // rust: .collect();
    // rust: drop(teams);
    // rust: for mob in candidates {
            // By id: a mod's mount hook may have removed mobs since the list
            // was made, which moves the others' indices.
    // rust: let Some(j) = self.mobs.iter().position(|m| m.id == mob) else {
    // rust: continue;
}
    // rust: let species = self.mobs[j].species();
    // rust: let player = &*self.mobs[j].kind.id == "minecraft:player";
    // rust: let cooldown = self.mobs[j].extra.boarding_cooldown;
    // rust: let passenger = self.mobs[j].extra.mount.is_some();
    // rust: if pickup_instead_of_push(species, passenger, occupied) && !player {
                // Entity.startRiding: a mod may cancel it (EntityMountEvent).
    // rust: if can_ride_cart(species, cooldown)
    // rust: && self.native_mob_may_ride(mob, id, true)
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob)
    // rust: {
    // rust: m.extra.mount = Some(id);
    // rust: m.extra.passenger = true;
    // rust: m.ai.nav.stop();
    // rust: m.needs_sync = true;
    // rust: occupied = true;
    // rust: self.break_leash(mob, true, false);
    // rust: self.note_started_riding(id);
}
    // rust: continue;
}
    // rust: let other = self.mobs[j].position;
    // rust: let Some(v) = super::boat_passengers::push_impulse(pos, other) else {
    // rust: continue;
}
    // rust: if !occupied {
    // rust: self.carts[i].velocity = self.carts[i].velocity.subtract(v);
}
    // rust: let m = &mut self.mobs[j];
    // rust: if m.pushable() {
    // rust: m.velocity = m.velocity.add_vector(v);
    // rust: m.needs_sync = true;
}
}
}
    /// `positionRider` for the mobs in minecarts: each sits on the cart's
    /// passenger attachment, less its own vehicle attachment.
    // rust: pub(super) fn seat_cart_mobs(&mut self, riding: &super::passengers::Riders) {
    // rust: for i in 0..self.carts.len() {
    // rust: let id = self.carts[i].id;
    // rust: let Some(js) = riding.get(&id) else {
    // rust: continue;
}
    // rust: let (pos, prev) = (self.carts[i].position, self.carts[i].previous);
    // rust: let seats: Vec<(usize, f64)> = js
    // rust: .iter()
                // Minecart's box is 0.98 wide.
    // rust: .map(|&j| (j, riders::vehicle_attachment(&self.mobs[j], 0.98)))
    // rust: .collect();
    // rust: for (j, offset) in seats {
    // rust: let m = &mut self.mobs[j];
    // rust: m.position = cart_seat(pos, offset);
    // rust: m.previous = cart_seat(prev, offset);
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.fall_distance = 0.0;
    // rust: m.on_ground = false;
    // rust: m.extra.passenger = true;
    // rust: m.ai.nav.stop();
}
}
}
    /// `ejectPassengers` for the mobs in cart `i`.
    // rust: pub(super) fn eject_cart_mobs(&mut self, i: usize) {
    // rust: let (id, y) = (self.carts[i].id, self.carts[i].position.y);
    // rust: let js: Vec<usize> = (0..self.mobs.len())
    // rust: .filter(|&j| self.mobs[j].extra.mount == Some(id))
    // rust: .collect();
    // rust: for j in js {
    // rust: let at = {
    // rust: let m = &self.mobs[j];
    // rust: Vec3::new(m.position.x, m.position.y.max(y), m.position.z)
}
    // rust: riders::stop_riding(&mut self.mobs[j], Some(at));
    // rust: self.mobs[j].previous = at;
}
}
    /// Every cart but the ridden one (which ticks with its rider).
    // rust: pub(super) fn tick_carts(&mut self) {
    // rust: self.vehicles_ticking(true);
    // rust: self.tick_carts_now();
    // rust: self.vehicles_ticking(false);
}
pub fn tick_carts_now(self: *Self) void {
}
    // rust: self.push_carts();
        // ServerLevel.tick: only entities in entity-ticking chunks tick.
    // rust: let ticking = self.entity_ticking_area();
    // rust: let mut round = self.native_tick_round();
        // A server player's minecart moves with its rider (lan_vehicles.rs).
    // rust: let ridden = self.guest_vehicles();
        // By id: an exploding cart can destroy or prime others mid-loop.
    // rust: let ids: Vec<u32> = self.carts.iter().map(|c| c.id).collect();
    // rust: let mut hint = 0;
    // rust: for &id in &ids {
    // rust: let Some(i) = cart_at(&self.carts, id, hint) else {
    // rust: continue;
}
    // rust: hint = i + 1;
    // rust: let p = self.carts[i].position;
    // rust: if Some(id) == self.riding
    // rust: || ridden.contains(&id)
    // rust: || !ticking(p.x.floor() as i32, p.z.floor() as i32)
    // rust: {
    // rust: continue;
}
    // rust: let kind = self.carts[i].kind.id();
    // rust: if !self.native_tick_pre_one(&mut round, id, kind) {
    // rust: continue;
}
    // rust: let Some(i) = cart_at(&self.carts, id, i) else {
    // rust: continue;
}
            // The ticked copy takes the loot roll instead of copying it: only
            // opening the cart, a command or a save reads it, never a tick, and
            // a mineshaft's chest cart carries its whole roll as NBT. The
            // stored cart keeps its slots for whatever reads them meanwhile.
    // rust: let loot = self.carts[i].loot.take();
    // rust: let mut c = self.carts[i].clone();
    // rust: c.loot = loot;
    // rust: let alive = self.tick_cart(&mut c, [0.0; 2]);
    // rust: if c.kind == CartKind::Hopper && c.enabled {
    // rust: self.hopper_cart_suck(&mut c);
}
    // rust: let Some(i) = cart_at(&self.carts, id, i) else {
    // rust: self.native_tick_post_one(&round, id, kind);
    // rust: continue;
}
    // rust: if alive {
    // rust: let due = std::mem::take(&mut c.command_due);
    // rust: self.carts[i] = c;
    // rust: if due {
    // rust: self.perform_cart_command(id);
}
    // rust: } else {
    // rust: self.eject_cart_mobs(i);
    // rust: self.release_vehicle_container(id);
    // rust: self.carts.remove(i);
}
            // After the ticked cart is stored: a mod reads and changes the cart as it is now.
    // rust: self.native_tick_post_one(&round, id, kind);
}
        // On the server for every cart, the ridden ones too.
    // rust: let mut hint = 0;
    // rust: for id in ids {
    // rust: if round.canceled(id) {
    // rust: continue;
}
    // rust: if let Some(i) = cart_at(&self.carts, id, hint) {
    // rust: hint = i + 1;
    // rust: let p = self.carts[i].position;
    // rust: if ticking(p.x.floor() as i32, p.z.floor() as i32) {
    // rust: self.cart_lava_tick(id);
}
}
}
}
    /// `lavaHurt` twice a tick in lava: from `LavaFluid.entityInside` in the
    /// behaviour's `applyEffectsFromBlocks`, then from `AbstractMinecart.tick`'s
    /// own `isInLava`. The second breaks the cart, or primes a TNT minecart
    /// (`MinecartTNT.destroy` for a fire source). A cart has no `baseTick`,
    /// so the fire `lavaIgnite` lights never burns it.
pub fn cart_lava_tick(self: *Self, id: u32) void {
}
    // rust: for _ in 0..2 {
    // rust: let Some(i) = self.carts.iter().position(|c| c.id == id) else {
    // rust: return;
}
    // rust: if !self.in_lava(self.carts[i].bounds()) {
    // rust: return;
}
    // rust: let p = self.carts[i].position;
    // rust: self.hurt_cart(i, 4.0, false, true);
    // rust: self.lava_hurt_sound([p.x, p.y, p.z]);
}
}
    /// `ClientPacketListener.postAddEntitySoundInstance` for the carts that
    /// joined the level since the last tick, and `LocalPlayer.startRiding`'s
    /// two inside sounds when the player got in one; then what the sound
    /// instances read this tick (the ridden cart and every cart).
    // rust: pub(super) fn start_cart_sounds(&mut self) -> (Option<u32>, Vec<CartSound>) {
    // rust: let carts: Vec<CartSound> = self
    // rust: .carts
    // rust: .iter()
    // rust: .map(|c| CartSound {
    // rust: id: c.id,
    // rust: position: [c.position.x, c.position.y, c.position.z],
                // Vec3.horizontalDistance.
    // rust: speed: (c.velocity.x * c.velocity.x + c.velocity.z * c.velocity.z).sqrt(),
    // rust: })
    // rust: .collect();
    // rust: self.cart_sounds
    // rust: .retain(|id| carts.iter().any(|c| c.id == *id));
    // rust: for cart in &carts {
    // rust: if !self.cart_sounds.contains(&cart.id) {
    // rust: let instance = SoundInstance::minecart(cart, SoundEngine::unseeded());
    // rust: let (_, res) = self.audio.play_instance(instance, false);
    // rust: if res != PlayResult::NotStarted {
    // rust: self.cart_sounds.insert(cart.id);
}
}
}
    // rust: let vehicle = self.riding.filter(|id| carts.iter().any(|c| c.id == *id));
    // rust: if vehicle != self.riding_cart_sounds
    // rust: && let Some(cart) = carts.iter().find(|c| Some(c.id) == vehicle)
    // rust: {
    // rust: let mut started = true;
    // rust: for underwater in [true, false] {
    // rust: let instance =
    // rust: SoundInstance::riding_minecart(cart, underwater, SoundEngine::unseeded());
    // rust: let (_, res) = self.audio.play_instance(instance, false);
    // rust: if res == PlayResult::NotStarted {
    // rust: started = false;
}
}
    // rust: if started {
    // rust: self.riding_cart_sounds = vehicle;
}
    // rust: } else if vehicle.is_none() {
    // rust: self.riding_cart_sounds = None;
}
    // rust: (vehicle, carts)
}
    /// The rider's tick: the cart moves with the rider's input as its push.
    // rust: pub(super) fn tick_cart_riding(&mut self, keys: Keys) -> bool {
    // rust: let Some(i) = self.carts.iter().position(|c| Some(c.id) == self.riding) else {
    // rust: return false;
}
    // rust: if keys.shift {
    // rust: self.dismount_cart(i);
    // rust: return true;
}
        // ServerPlayer.getLastClientMoveIntent: getInputVector((left, 0, forward), 1, yRot).
    // rust: let left = f64::from(i8::from(keys.left) - i8::from(keys.right));
    // rust: let forward = f64::from(i8::from(keys.forward) - i8::from(keys.backward));
    // rust: let len = left.hypot(forward);
    // rust: let (left, forward) = if len > 1.0 {
    // rust: (left / len, forward / len)
    // rust: } else {
    // rust: (left, forward)
}
    // rust: let r = self.yaw.to_radians();
    // rust: let (s, co) = (f64::from(r.sin()), f64::from(r.cos()));
    // rust: let intent = [left * co - forward * s, forward * co + left * s];
    // rust: let mut c = self.carts[i].clone();
    // rust: let alive = self.tick_cart(&mut c, intent);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: self.previous_position = p.position;
    // rust: p.position = Vec3::new(c.position.x, c.position.y + SEAT, c.position.z);
    // rust: p.velocity = Vec3::ZERO;
    // rust: p.fall_distance = 0.0;
}
    // rust: let Some(i) = self.carts.iter().position(|x| x.id == c.id) else {
    // rust: self.riding = None;
    // rust: return true;
}
    // rust: if alive {
    // rust: self.carts[i] = c;
    // rust: } else {
    // rust: self.eject_cart_mobs(i);
    // rust: self.release_vehicle_container(c.id);
    // rust: self.carts.remove(i);
    // rust: self.riding = None;
}
        // AbstractMinecart.activateMinecart: a powered activator rail ejects
        // the rider, and getDismountLocationForPassenger places it beside the
        // cart instead of leaving it at the seat.
    // rust: if alive && self.riding.is_none() {
    // rust: self.dismount_cart(i);
}
    // rust: true
}
    /// `getDismountLocationForPassenger`: beside the cart (across its facing), else on top.
    // rust: pub(super) fn dismount_cart(&mut self, i: usize) {
    // rust: let id = self.carts[i].id;
    // rust: if self.riding == Some(id) && !self.native_may_leave(id) {
    // rust: return;
}
    // rust: self.riding = None;
    // rust: let c = &self.carts[i];
    // rust: let (bx, by, bz) = (
    // rust: c.position.x.floor() as i32,
    // rust: c.position.y.floor() as i32,
    // rust: c.position.z.floor() as i32,
    // rust: );
    // rust: let mut target = None;
        // DismountHelper.offsetsForDirection of the cart's facing
        // (Direction.fromYRot of its yaw): right, left, back right, back left,
        // forward right, forward left, back, forward.
    // rust: let step = |q: i32| [(0, 1), (-1, 0), (0, -1), (1, 0)][(q & 3) as usize];
    // rust: let facing = (f64::from(c.yaw) / 90.0 + 0.5).floor() as i32;
    // rust: let (fx, fz) = step(facing);
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
    // rust: 'search: for dy in [0, 1, -1] {
    // rust: for (dx, dz) in offsets {
    // rust: let (x, y, z) = (bx + dx, by + dy, bz + dz);
    // rust: let below = self.res.facts().get(self.world.block(x, y - 1, z));
    // rust: let here = self.res.facts().get(self.world.block(x, y, z));
    // rust: let head = self.res.facts().get(self.world.block(x, y + 1, z));
    // rust: if (below.full_collision || below.legacy_solid)
    // rust: && !here.full_collision
    // rust: && !head.full_collision
    // rust: && here.fluid == Fluid::None
    // rust: {
    // rust: target = Some(Vec3::new(
    // rust: f64::from(x) + 0.5,
    // rust: f64::from(y),
    // rust: f64::from(z) + 0.5,
    // rust: ));
    // rust: break 'search;
}
}
}
    // rust: let top = c.bounds().max_position().y;
    // rust: let target = target.unwrap_or(Vec3::new(c.position.x, top, c.position.z));
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.position = target;
    // rust: p.velocity = Vec3::ZERO;
}
}
    /// `MinecartItem.useOn`: a cart on the clicked rail.
    // rust: pub(super) fn place_minecart(&mut self, hit: &Hit, stack: &ItemStack) -> bool {
    // rust: let Some(kind) = CartKind::from_id(&stack.item) else {
    // rust: return false;
}
    // rust: let Some(rail) = self.rail(hit.pos[0], hit.pos[1], hit.pos[2]) else {
    // rust: return false;
}
    // rust: let offset = if rail.shape.is_slope() { 0.5 } else { 0.0 };
    // rust: let at = Vec3::new(
    // rust: f64::from(hit.pos[0]) + 0.5,
    // rust: f64::from(hit.pos[1]) + 0.0625 + offset,
    // rust: f64::from(hit.pos[2]) + 0.5,
    // rust: );
    // rust: self.next_entity += 1;
    // rust: let cart = Minecart::new(self.next_entity, kind, at);
    // rust: self.world
    // rust: .modified
    // rust: .insert((hit.pos[0] >> 4, hit.pos[2] >> 4));
    // rust: self.carts.push(cart);
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: let cart = self.carts.last().unwrap();
    // rust: self.native_vehicle_create(
    // rust: cart.kind.id(),
    // rust: [cart.position.x, cart.position.y, cart.position.z],
    // rust: );
}
        // MinecartItem.useOn: ENTITY_PLACE at the rail, by the player, with the block under it.
    // rust: let below = self.world.block(hit.pos[0], hit.pos[1] - 1, hit.pos[2]);
    // rust: self.post_block_game_event(
    // rust: "minecraft:entity_place",
    // rust: hit.pos,
    // rust: self.sculk_actor(),
    // rust: Some(below),
    // rust: );
    // rust: if !self.creative {
    // rust: self.consume_held();
}
        // ItemStack.useOn counts the use.
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
    // rust: true
}
    // rust: pub(super) fn cart_hit(&self) -> Option<(usize, f64)> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let reach: f64 = self.entity_reach;
    // rust: let mut best: Option<(usize, f64)> = None;
    // rust: for (i, c) in self.carts.iter().enumerate() {
    // rust: if Some(c.id) == self.riding {
    // rust: continue;
}
    // rust: let bb = c.bounds();
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
    // rust: let (lo, hi) = ([lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z]);
    // rust: let (mut t0, mut t1) = (0.0f64, reach);
    // rust: let mut hit = true;
    // rust: for a in 0..3 {
    // rust: if dir[a].abs() < 1e-9 {
    // rust: hit &= eye[a] >= lo[a] && eye[a] <= hi[a];
    // rust: continue;
}
    // rust: let (mut ta, mut tb) = ((lo[a] - eye[a]) / dir[a], (hi[a] - eye[a]) / dir[a]);
    // rust: if ta > tb {
    // rust: std::mem::swap(&mut ta, &mut tb);
}
    // rust: t0 = t0.max(ta);
    // rust: t1 = t1.min(tb);
}
    // rust: if hit && t0 <= t1 && best.is_none_or(|b| t0 < b.1) {
    // rust: best = Some((i, t0));
}
}
    // rust: best
}
    /// The slots of the cart `id`, for a command: `getChestVehicleItem` and
    /// `setChestVehicleItem` first unpack its loot table with no player, so
    /// no `player_generates_container_loot` fires later. While its menu is
    /// open the live slots are the placeholder copy (`open_cart_container`).
    // rust: pub(super) fn cart_slots(&mut self, id: u32) -> Option<&mut Vec<Option<ItemStack>>> {
    // rust: let c = self.carts.iter_mut().find(|c| c.id == id)?;
    // rust: c.loot = None;
    // rust: match self
    // rust: .world
    // rust: .block_entities
    // rust: .get_mut(&(i32::MAX - 15, CART_KEY_Y, id as i32))
    // rust: {
    // rust: Some(BlockEntity::Chest(open)) => Some(open),
    // rust: _ => Some(&mut c.items),
}
}
    /// `ContainerEntity.unpackChestVehicleLootTable` for a player who opens a
    /// chest minecart: a roll it still holds fires `player_generates_container_loot`
    /// for its table, and the cart keeps its items from then on.
pub fn unpack_cart_loot(self: *Self, i: usize) void {
}
    // rust: let Some(loot) = self.carts[i].loot.take() else {
    // rust: return;
}
    // rust: if loot.items == horizon_client::save::encode_items(&self.carts[i].items) {
    // rust: self.trigger_loot_table(&loot.table);
}
}
    /// `interact`: ride, open, fuel or ignite the cart under the crosshair, or
    /// the one a guest's interact packet named.
    // rust: pub(super) fn interact_cart(&mut self, target: Option<InteractTarget>) -> bool {
    // rust: let Some((i, d)) = (match target {
    // rust: Some(t) => Self::named_entity(&self.carts, t.id, |c| c.id).map(|i| (i, 0.0)),
    // rust: None => self.cart_hit(),
    // rust: }) else {
    // rust: return false;
}
        // Only a client's own pick is stopped by a block: the range check passed.
    // rust: if target.is_none() && !self.before_block(d) {
    // rust: return false;
}
    // rust: let sneaking = self.keys.held(Action::Sneak);
    // rust: let held = self.held().cloned();
    // rust: match self.carts[i].kind {
    // rust: CartKind::Rideable => {
    // rust: let id = self.carts[i].id;
                // isVehicle: a mob already sits in it.
    // rust: let has_mob = self.mobs.iter().any(|m| m.extra.mount == Some(id));
    // rust: if sneaking
    // rust: || self.riding.is_some()
    // rust: || !self.may_board()
    // rust: || self.ridden_by_guest(id)
    // rust: || has_mob
    // rust: {
    // rust: return false;
}
    // rust: if !self.native_may_board(id) {
    // rust: return true;
}
    // rust: self.start_riding(id);
}
            // AbstractMinecartContainer.interact: no sneak check.
    // rust: CartKind::Chest | CartKind::Hopper => self.open_cart_container(i),
    // rust: CartKind::Furnace => {
    // rust: let fuel = held
    // rust: .as_ref()
    // rust: .is_some_and(|s| matches!(&*s.item, "minecraft:coal" | "minecraft:charcoal"));
    // rust: let c = &mut self.carts[i];
    // rust: if fuel && c.fuel + 3600 <= 32000 {
    // rust: c.fuel += 3600;
    // rust: let p = self.player.as_ref().map_or(c.position, |p| p.position);
    // rust: c.push = Vec3::new(c.position.x - p.x, 0.0, c.position.z - p.z);
    // rust: if !self.creative {
    // rust: self.consume_held();
}
}
}
    // rust: CartKind::Tnt => {
    // rust: let lighter = held.as_ref().is_some_and(|s| {
    // rust: matches!(
    // rust: &*s.item,
    // rust: "minecraft:flint_and_steel" | "minecraft:fire_charge"
    // rust: )
    // rust: });
    // rust: if !lighter || self.carts[i].fuse >= 0 {
    // rust: return false;
}
    // rust: let mut c = self.carts[i].clone();
    // rust: self.prime_cart(&mut c);
    // rust: self.carts[i] = c;
}
            // MinecartCommandBlock.interact: a game master gets SUCCESS (the
            // client opens the editor, `open_cart_command_block`), anyone else
            // PASSes to the held item. SUCCESS swings on the client only.
    // rust: CartKind::CommandBlock => return self.can_use_game_master_blocks(),
            // MinecartSpawner has no interact of its own (`Entity.interact` passes).
    // rust: CartKind::Spawner => return false,
}
    // rust: self.swing_arm();
    // rust: true
}
    /// `AbstractMinecartContainer.interact`: the menu opens over the cart's
    /// own slots, kept under a placeholder key until it closes
    /// (`store_cart_items`/`close_cart_container`).
    // rust: pub(super) fn open_cart_container(&mut self, i: usize) {
    // rust: self.unpack_cart_loot(i);
    // rust: let c = self.carts[i].clone();
    // rust: let key = (i32::MAX - 15, CART_KEY_Y, c.id as i32);
    // rust: self.world
    // rust: .block_entities
    // rust: .insert(key, BlockEntity::Chest(c.items.clone()));
    // rust: self.container = Some(key);
    // rust: self.screen = super::Screen::Inventory;
    // rust: self.capture(false);
    // rust: self.right = false;
    // rust: if c.kind == CartKind::Chest {
            // `MinecartChest.interact` (which overrides
            // `AbstractMinecartContainer.interact`): a successful open fires
            // CONTAINER_OPEN with the player and angers the piglins that see
            // it. `MinecartHopper` does not override it, so a hopper minecart
            // fires neither. Vanilla plays no open sound for a chest minecart.
    // rust: let at = [c.position.x, c.position.y, c.position.z];
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event("minecraft:container_open", at, ctx);
    // rust: self.anger_piglins(true);
}
}
    /// Closing the cart's container open under `key` copies the items back.
    // rust: pub(super) fn close_cart_container(&mut self, key: (i32, i32, i32)) {
    // rust: if key.1 != CART_KEY_Y {
    // rust: return;
}
    // rust: self.store_cart_items(key);
    // rust: let guest_viewers = self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|host| Self::vehicle_has_other_viewers(None, &host.hub.guests, None, key));
    // rust: if !guest_viewers {
    // rust: self.world.block_entities.remove(&key);
}
}
    /// A chest or hopper minecart or a chest boat is about to be removed
    /// (`Containers.dropContents` / `AbstractChestBoat.remove`): what an open
    /// menu edited goes back to the vehicle, so it is what drops or travels
    /// with it, and the menu's stand-in leaves the level. A menu that is
    /// still open over it then has nothing left to take.
    // rust: pub(super) fn release_vehicle_container(&mut self, id: u32) {
    // rust: let key = (i32::MAX - 15, CART_KEY_Y, id as i32);
    // rust: self.store_cart_items(key);
    // rust: self.world.block_entities.remove(&key);
    // rust: if self.container == Some(key) {
    // rust: self.container = None;
}
}
    /// The menu of a chest or hopper minecart or a chest boat works on the
    /// vehicle's own items (`ContainerEntity`): the placeholder under `key`
    /// that the menu edits is copied back to the vehicle.
    // rust: pub(super) fn store_cart_items(&mut self, key: (i32, i32, i32)) {
    // rust: if key.1 != CART_KEY_Y {
    // rust: return;
}
    // rust: let Some(BlockEntity::Chest(items)) = self.world.block_entities.get(&key) else {
    // rust: return;
}
    // rust: let items = items.clone();
    // rust: if let Some(c) = self.carts.iter_mut().find(|c| c.id as i32 == key.2) {
    // rust: c.items = items;
    // rust: } else if let Some(b) = self.boats.iter_mut().find(|b| b.id as i32 == key.2) {
    // rust: b.items = items;
}
}
    /// The open cart's kind when a cart container is shown.
    // rust: pub(super) fn open_cart_kind(&self) -> Option<CartKind> {
    // rust: let key = self.container.filter(|k| k.1 == CART_KEY_Y)?;
        // A chest boat's chest shows like a chest minecart's.
    // rust: self.carts
    // rust: .iter()
    // rust: .find(|c| c.id as i32 == key.2)
    // rust: .map(|c| c.kind)
    // rust: .or_else(|| {
    // rust: self.boats
    // rust: .iter()
    // rust: .any(|b| b.chest && b.id as i32 == key.2)
    // rust: .then_some(CartKind::Chest)
    // rust: })
}
    /// `VehicleEntity.hurtServer` from the player's attack.
    // rust: pub(super) fn attack_cart(&mut self) -> bool {
    // rust: let Some((i, d)) = self.cart_hit() else {
    // rust: return false;
}
    // rust: if !self.before_block(d) || self.mob_hit().is_some_and(|m| m.1 < d) {
    // rust: return false;
}
    // rust: let burning = self
    // rust: .held()
    // rust: .is_some_and(|s| s.enchantment_level("minecraft:fire_aspect") > 0);
    // rust: let area = self.carts[i].bounds();
        // Player.attack's full damage against the cart's entity type.
    // rust: let id = self.carts[i].id as i32;
    // rust: let (damage, _, _, magic) = self.melee_damage(self.carts[i].kind.id(), false);
    // rust: self.hurt_cart(i, damage, self.creative, burning);
    // rust: self.vehicle_attack_sounds(area, magic.then_some(id));
        // Player.onAttack: the hit starts the attack strength again.
    // rust: self.attack_ticks = 0;
    // rust: self.swing_arm();
    // rust: true
}
    /// An arrow hit cart `i` (`MinecartTNT.hurtServer`, then
    /// `VehicleEntity.hurtServer`): a burning arrow sets off a TNT minecart.
    // rust: pub(super) fn arrow_hits_cart(
    // rust: &mut self,
    // rust: i: usize,
    // rust: damage: f32,
    // rust: arrow_velocity: Vec3,
    // rust: burning: bool,
    // rust: creative: bool,
    // rust: ) {
    // rust: if i >= self.carts.len() {
    // rust: return;
}
    // rust: if burning && self.carts[i].kind == CartKind::Tnt {
    // rust: self.eject_cart_mobs(i);
    // rust: let id = self.carts[i].id;
    // rust: self.release_vehicle_container(id);
    // rust: let c = self.carts.remove(i);
    // rust: self.explode_cart(&c, arrow_velocity.length_squared());
    // rust: return;
}
    // rust: self.hurt_cart(i, damage, creative, false);
}
    /// `VehicleEntity.hurtServer`: shake, add the damage, break past 40 (at
    /// once for creative players); TNT minecarts prime instead when moving
    /// or hurt by fire or an explosion (`damageSourceIgnitesTnt`).
    // rust: pub(super) fn hurt_cart(&mut self, i: usize, mut damage: f32, creative: bool, fire: bool) {
    // rust: let kind = self.carts[i].kind.id();
    // rust: let mut cancel = false;
    // rust: self.native_vehicle_damage(kind, &mut damage, &mut cancel);
    // rust: if cancel {
    // rust: return;
}
    // rust: let destroyed = {
    // rust: let c = &mut self.carts[i];
    // rust: c.hurt_dir = -c.hurt_dir;
    // rust: c.hurt_time = 10;
    // rust: c.damage += damage * 10.0;
            // MinecartTNT.shouldSourceDestroy: fire and explosions destroy
            // (so ignite) a TNT cart whatever damage it has taken.
    // rust: cart_is_destroyed(creative, c.damage, fire && c.kind == CartKind::Tnt)
}
    // rust: if destroyed {
    // rust: let speed = self.carts[i].velocity.x * self.carts[i].velocity.x
    // rust: + self.carts[i].velocity.z * self.carts[i].velocity.z;
    // rust: let tnt_prime =
    // rust: self.carts[i].kind == CartKind::Tnt && (fire || speed >= f64::from(0.01f32));
    // rust: if !tnt_prime {
    // rust: self.eject_cart_mobs(i);
}
    // rust: let id = self.carts[i].id;
    // rust: if !tnt_prime {
    // rust: self.release_vehicle_container(id);
}
    // rust: if !tnt_prime {
    // rust: let at = [
    // rust: self.carts[i].position.x,
    // rust: self.carts[i].position.y,
    // rust: self.carts[i].position.z,
    // rust: ];
    // rust: self.native_vehicle_destroy(self.carts[i].kind.id(), at);
}
    // rust: let mut c = self.carts.remove(i);
    // rust: if c.kind == CartKind::Tnt && (fire || speed >= f64::from(0.01f32)) {
                // MinecartTNT.destroy: prime instead of breaking.
    // rust: if c.fuse < 0 {
    // rust: self.prime_cart(&mut c);
    // rust: let r = &mut self.world.random;
    // rust: c.fuse = r.next_int_bound(20).unwrap_or(0) + r.next_int_bound(20).unwrap_or(0);
}
    // rust: self.carts.insert(i, c);
    // rust: } else {
    // rust: let at = [c.position.x, c.position.y, c.position.z];
    // rust: if self.ui.rules.bool("entity_drops") {
    // rust: for s in c.items.iter().flatten() {
    // rust: self.spawn_item(s.clone(), at, [0.0, 0.1, 0.0], 10);
}
    // rust: if !creative {
    // rust: self.spawn_item(ItemStack::new(c.kind.item(), 1), at, [0.0, 0.1, 0.0], 10);
}
}
}
}
}
    /// Baked block-state faces with default block tints and terrain shade or diffuse lighting.
    // rust: pub(super) fn block_model_vertices(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: seed: i64,
    // rust: m: glam::Mat4,
    // rust: light: u32,
    // rust: diffuse: bool,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
        // BlockTintSource.color(state) with no level: each tinted face's default colour.
    // rust: let grass = self.pack.item_renderer.grass_color(0.5, 1.0) as u32;
    // rust: let tables = &self.pack.context.tables;
    // rust: let tint = |index: i32| tables.default_tint(state, index, grass);
    // rust: self.tinted_block_model_vertices(state, seed, m, |_| light, diffuse, tint, out);
}
    /// `block_model_vertices` with each face multiplied by `tint` of its
    /// tint index (RGB, `None` for untinted faces) and lit by `light` of
    /// each quad.
    // rust: pub(super) fn tinted_block_model_vertices(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: seed: i64,
    // rust: m: glam::Mat4,
    // rust: light: impl Fn(&horizon_assets::bake::ModelQuad) -> u32,
    // rust: diffuse: bool,
    // rust: tint: impl Fn(i32) -> Option<u32>,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Ok(models) = self.pack.render.model_catalog.collect_seeded(state, seed) else {
    // rust: return;
}
    // rust: let models = models.into_iter().map(|(_, model)| model);
    // rust: self.baked_model_vertices(models, m, light, diffuse, tint, out);
}
    /// `tinted_block_model_vertices` for baked models given as they are (a
    /// state's, or a standalone model).
    // rust: pub(super) fn baked_model_vertices<'m>(
    // rust: &self,
    // rust: models: impl IntoIterator<Item = &'m horizon_client::models::catalog::BakedModel>,
    // rust: m: glam::Mat4,
    // rust: light: impl Fn(&horizon_assets::bake::ModelQuad) -> u32,
    // rust: diffuse: bool,
    // rust: tint: impl Fn(i32) -> Option<u32>,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let mut normals = horizon_client::item_render::FaceNormals::new(m);
    // rust: for model in models {
    // rust: for face in &model.faces {
    // rust: let Some(s) = self
    // rust: .pack
    // rust: .layer_names
    // rust: .get(&face.layer)
    // rust: .and_then(|n| self.gui.atlas.sprites.get(n))
    // rust: else {
    // rust: continue;
}
//                 use horizon_assets::model::Direction as D;
    // rust: let shade: u32 = match face.quad.facing {
    // rust: D::Up => 255,
    // rust: D::Down => 127,
    // rust: D::North | D::South => 204,
    // rust: D::West | D::East => 153,
}
    // rust: let mut color = if diffuse {
    // rust: u32::MAX
    // rust: } else {
    // rust: 0xFF00_0000 | shade << 16 | shade << 8 | shade
}
    // rust: if let Some(t) = tint(face.quad.tint_index) {
    // rust: color = horizon_client::hud_layout::multiply(
    // rust: color,
    // rust: horizon_client::mobs::render::abgr(t),
    // rust: );
}
    // rust: let normal = if diffuse {
    // rust: let n = normals.face(face.quad.facing);
    // rust: let n = n.to_array().map(|v| (v.clamp(-1.0, 1.0) * 127.0) as i8);
    // rust: [n[0], n[1], n[2], 127]
    // rust: } else {
    // rust: [0; 4]
}
    // rust: let light = light(&face.quad);
    // rust: let light = if diffuse {
    // rust: let emission = u32::from(face.quad.light_emission) * 16;
    // rust: (light & 0xFF) | (light >> 8 & 0xFF).max(emission) << 8
    // rust: } else {
    // rust: light
}
    // rust: for k in 0..4 {
    // rust: let p = face.quad.positions[k];
    // rust: let uv = face.quad.uv[k];
    // rust: out.push(Vertex {
    // rust: normal,
    // rust: pos: m.transform_point3(glam::Vec3::from_array(p)).to_array(),
    // rust: uv: [s.u0 + uv[0] * (s.u1 - s.u0), s.v0 + uv[1] * (s.v1 - s.v0)],
    // rust: layer: 0,
    // rust: color,
    // rust: light,
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}
    /// The block the cart shows: `None` for air (`AbstractMinecartRenderer`
    /// draws and stretches its culling box only for a non-air state).
pub fn display_state(self: *Self, c: *Minecart) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: shown_unless_air(self.display_state_unfiltered(c), |s| {
    // rust: self.res.facts().is_air(s)
    // rust: })
}
pub fn display_state_unfiltered(self: *Self, c: *Minecart) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = &self.pack.assets.registry;
    // rust: let with = |name: &str, props: &[(&str, &str)]| {
    // rust: let mut s = registry.state(registry.default_state(name)?)?.clone();
    // rust: for (k, v) in props {
    // rust: s.properties.insert((*k).to_owned(), (*v).to_owned());
}
    // rust: registry.id(&s)
}
        // AbstractMinecart.getDisplayBlockState: a custom state wins.
    // rust: if let Some(state) = c
    // rust: .custom_display
    // rust: .as_ref()
    // rust: .and_then(|tag| horizon_client::entity_nbt::state_from_nbt(registry, tag))
    // rust: {
    // rust: return Some(state);
}
    // rust: match c.kind {
    // rust: CartKind::Rideable => None,
    // rust: CartKind::Chest => with("minecraft:chest", &[("facing", "north")]),
    // rust: CartKind::Hopper => registry.default_state("minecraft:hopper"),
    // rust: CartKind::Furnace => with(
    // rust: "minecraft:furnace",
    // rust: &[
    // rust: ("facing", "north"),
    // rust: ("lit", if c.fuel > 0 { "true" } else { "false" }),
    // rust: ],
    // rust: ),
    // rust: CartKind::Tnt => registry.default_state("minecraft:tnt"),
    // rust: CartKind::CommandBlock => registry.default_state("minecraft:command_block"),
            // MinecartSpawner.getDefaultDisplayBlockState.
    // rust: CartKind::Spawner => registry.default_state("minecraft:spawner"),
}
}
    /// `AbstractMinecartRenderer` (old render): on the rail between the
    /// front and back points, pitched on slopes, with the display block.
    // rust: pub(super) fn cart_geometry(&self, camera: glam::DVec3, alpha: f64, out: &mut Vec<Vertex>) {
    // rust: let a = alpha as f32;
    // rust: let Some(uv) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("entity/minecart/minecart")
    // rust: .map(|r| [r.u0, r.v0, r.u1, r.v1])
    // rust: else {
    // rust: return;
}
        // Entity.shouldRenderAtSqrDistance: 64 times the bounding box's mean
        // edge, scaled by the view scale.
    // rust: let range = (WIDTH + HEIGHT + WIDTH) / 3.0 * 64.0 * self.view_scale();
    // rust: for c in &self.carts {
    // rust: let Some(model) = self.cart_models.models.get(&c.kind) else {
    // rust: continue;
}
    // rust: let lerp = self.remote_minecart_lerp(c.id, a);
    // rust: let new_render = self.minecart_improvements() || lerp.is_some();
    // rust: let (x, y, z) = if let Some((p, _, _)) = lerp {
    // rust: (p[0], p[1], p[2])
    // rust: } else {
    // rust: (
    // rust: c.previous.x + (c.position.x - c.previous.x) * alpha,
    // rust: c.previous.y + (c.position.y - c.previous.y) * alpha,
    // rust: c.previous.z + (c.position.z - c.previous.z) * alpha,
    // rust: )
}
            // LevelExtractor.isEntityVisible: the cart the player rides always draws.
    // rust: let mut shown = None;
    // rust: if self.riding != Some(c.id) {
    // rust: let d = glam::DVec3::new(c.position.x, c.position.y, c.position.z) - camera;
    // rust: if d.length_squared() >= range * range {
    // rust: continue;
}
                // Looked up once, past the distance cut: the cull and the draw both use it.
    // rust: shown = Some(self.display_state(c));
                // EntityRenderer.shouldRender: the interpolated box grown by 0.5;
                // AbstractMinecartRenderer.getBoundingBoxForCulling stretches it
                // up by the display block's offset.
    // rust: if let Some(view) = &self.view_frustum {
    // rust: let top = HEIGHT
    // rust: + if shown.flatten().is_none() {
    // rust: 0.0
    // rust: } else {
    // rust: display_offset(c) * 0.75 / 16.0
}
    // rust: let p = glam::DVec3::new(x, y, z) - camera;
    // rust: let lo = p - glam::DVec3::new(WIDTH / 2.0 + 0.5, 0.5, WIDTH / 2.0 + 0.5);
    // rust: let hi = p + glam::DVec3::new(WIDTH / 2.0 + 0.5, top + 0.5, WIDTH / 2.0 + 0.5);
    // rust: if !view.intersects(lo.as_vec3(), hi.as_vec3()) {
    // rust: continue;
}
}
}
    // rust: let mut yaw =
    // rust: c.previous_yaw + ((c.yaw - c.previous_yaw + 180.0).rem_euclid(360.0) - 180.0) * a;
    // rust: let mut pitch = 0.0f32;
    // rust: let mut offset = glam::DVec3::ZERO;
    // rust: if new_render {
    // rust: (yaw, pitch) = lerp.map_or((c.yaw, c.pitch), |(_, yaw, pitch)| (yaw, pitch));
    // rust: } else if let Some(on) = self.rail_pos(x, y, z) {
    // rust: let front = self.rail_pos_offs(x, y, z, 0.3).unwrap_or(on);
    // rust: let back = self.rail_pos_offs(x, y, z, -0.3).unwrap_or(on);
    // rust: offset = glam::DVec3::new(on[0] - x, (front[1] + back[1]) / 2.0 - y, on[2] - z);
    // rust: let d =
    // rust: glam::DVec3::new(back[0] - front[0], back[1] - front[1], back[2] - front[2]);
    // rust: if d.length() != 0.0 {
    // rust: let d = d.normalize();
    // rust: yaw = d.z.atan2(d.x).to_degrees() as f32;
    // rust: pitch = (d.y.atan() * 73.0) as f32;
}
}
    // rust: let render_position = Vec3::new(x + offset.x, y + offset.y, z + offset.z);
    // rust: let has_display = shown.as_ref().is_some_and(Option::is_some)
    // rust: || (shown.is_none() && self.display_state(c).is_some());
    // rust: let culling = self.entity_cull_decision_in_bounds(
    // rust: c,
    // rust: cart_render_bounds(render_position, display_offset(c), has_display),
    // rust: );
    // rust: if culling.hides_entity() {
    // rust: continue;
}
    // rust: let entity_start = out.len();
            // The per-entity jitter (offsetSeed) that keeps stacked carts from z-fighting.
    // rust: let seed = i64::from(c.id).wrapping_mul(493_286_711);
    // rust: let seed = seed
    // rust: .wrapping_mul(seed)
    // rust: .wrapping_mul(4_392_167_121)
    // rust: .wrapping_add(seed.wrapping_mul(98_761));
    // rust: let jitter = |shift: i64| (((seed >> shift & 7) as f32 + 0.5) / 8.0 - 0.5) * 0.004;
    // rust: let p = glam::DVec3::new(x, y, z) + offset - camera;
    // rust: let jittered = p.as_vec3() + glam::Vec3::new(jitter(16), jitter(20), jitter(24));
    // rust: let mut base = if new_render {
                // AbstractMinecartRenderer.newRender translates the model
                // after rotating, so the seat follows the pitched cart.
    // rust: glam::Mat4::from_translation(jittered)
    // rust: * glam::Mat4::from_rotation_y(yaw.to_radians())
    // rust: * glam::Mat4::from_rotation_z((-pitch).to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.375, 0.0))
    // rust: } else {
    // rust: glam::Mat4::from_translation(jittered + glam::Vec3::new(0.0, 0.375, 0.0))
    // rust: * glam::Mat4::from_rotation_y((180.0 - yaw).to_radians())
    // rust: * glam::Mat4::from_rotation_z((-pitch).to_radians())
}
    // rust: let hurt = c.hurt_time as f32 - a;
    // rust: if hurt > 0.0 {
    // rust: let damage = (c.damage - a).max(0.0);
    // rust: base *= glam::Mat4::from_rotation_x(
    // rust: (hurt.sin() * hurt * damage / 10.0 * c.hurt_dir as f32).to_radians(),
    // rust: );
}
    // rust: let l = self.world.light(
    // rust: c.position.x.floor() as i32,
    // rust: (c.position.y + 0.35).floor() as i32,
    // rust: c.position.z.floor() as i32,
    // rust: );
    // rust: let packed = (u32::from(l >> 4) * 16) | ((u32::from(l & 15) * 16) << 8);
    // rust: if let Some(state) = shown.unwrap_or_else(|| self.display_state(c)) {
    // rust: let display = base
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(0.75))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(
    // rust: -0.5,
    // rust: (display_offset(c) as f32 - 8.0) / 16.0,
    // rust: 0.5,
    // rust: ))
    // rust: * glam::Mat4::from_rotation_y(90f32.to_radians());
    // rust: if c.kind == CartKind::Chest {
    // rust: self.special_block_model(state, display, l, out);
    // rust: } else {
                    // TNT minecarts flash white as the fuse runs out (TntMinecartRenderer).
    // rust: let swell = if c.kind == CartKind::Tnt && c.fuse > -1 {
    // rust: let fuse = c.fuse as f32 - a + 1.0;
    // rust: if fuse < 10.0 {
    // rust: let g = (1.0 - fuse / 10.0).clamp(0.0, 1.0);
    // rust: 1.0 + g * g * g * g * 0.3
    // rust: } else {
    // rust: 1.0
}
    // rust: } else {
    // rust: 1.0
}
    // rust: let m = display
    // rust: * glam::Mat4::from_translation(glam::Vec3::splat(0.5))
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(swell))
    // rust: * glam::Mat4::from_translation(glam::Vec3::splat(-0.5));
    // rust: let flash = c.kind == CartKind::Tnt && c.fuse > -1 && (c.fuse / 5) % 2 == 0;
    // rust: let start = out.len();
    // rust: self.block_model_vertices(state, 0, m, packed, false, out);
    // rust: if flash {
                        // submitWhiteSolidBlock: OverlayTexture.u(1.0) on the cart's own light.
    // rust: for v in &mut out[start..] {
    // rust: v.layer = 5;
}
}
}
}
    // rust: let m = base * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0));
    // rust: let poses = Poses::new(model);
    // rust: horizon_client::mobs::render::draw(model, m, &poses, uv, 0xFFFF_FFFF, packed, 0, out);
    // rust: self.finish_entity_occlusion(culling, c, out, entity_start);
}
}
    /// The model of a block drawn by its block-entity renderer, as a chest
    /// minecart shows its chest and a block display its special block.
    // rust: pub(super) fn special_block_model(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: m: glam::Mat4,
    // rust: light: u8,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let lid = |_: [i32; 3]| 0.0;
    // rust: let scene = horizon_client::block_entity_render::Scene {
    // rust: camera: glam::DVec3::ZERO,
    // rust: orientation: glam::Quat::IDENTITY,
    // rust: anim: &|_| horizon_client::block_entity_render::BlockAnim::default(),
    // rust: texts: None,
    // rust: partial: 0.0,
    // rust: game_time: self.world.game_time,
    // rust: max_y: self.world.shape.max_y() - 1,
    // rust: world: &self.world,
    // rust: sprites: &self.gui.atlas.sprites,
    // rust: emissive: &self.gui.atlas.emissive,
    // rust: translucent_sprites: &self.gui.atlas.translucent,
    // rust: atlas_revision: self.gui.atlas.revision,
    // rust: nether: self.dim == super::Dim::Nether,
    // rust: lid: &lid,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|c| self.gui.atlas.glyph_cell(c),
    // rust: glyphs: self.gui.atlas.font.epoch(),
    // rust: dynamic_visible: None,
}
    // rust: self.res
    // rust: .block_entity_render()
    // rust: .render_state(&scene, state.0, m, light, out);
}
}
/// Saving and loading.
    // rust: impl Minecart {
    // rust: pub fn to_nbt(
    // rust: &self,
    // rust: uuid: [i32; 4],
    // rust: raw: Option<&horizon_world::nbt::Tag>,
    // rust: ) -> horizon_world::nbt::Tag {
//         use horizon_world::nbt::{JavaString, Tag};
    // rust: let mut tag = horizon_client::entity_nbt::vehicle_to_nbt(
    // rust: self.kind.id(),
    // rust: self.position,
    // rust: self.velocity,
    // rust: [self.yaw, self.pitch],
    // rust: uuid,
    // rust: raw,
    // rust: );
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: if self.kind == CartKind::CommandBlock {
    // rust: for key in ["LastOutput", "LastExecution"] {
    // rust: map.remove(&JavaString::from(key));
}
}
    // rust: map.remove(&JavaString::from("DisplayOffset"));
    // rust: map.remove(&JavaString::from("DisplayState"));
    // rust: let mut put = |k: &str, v: Tag| {
    // rust: map.insert(JavaString::from(k), v);
}
    // rust: put("FlippedRotation", Tag::Byte(i8::from(self.flipped)));
            // AbstractMinecart saves firstTick as HasTicked. A cart never burns:
            // Entity.move sets -getFireImmuneTicks(), 0 for all but players.
    // rust: put("HasTicked", Tag::Byte(i8::from(self.first_tick)));
    // rust: put("Fire", Tag::Short(0));
            // addAdditionalSaveData: the offset only off its default, the state only when set.
    // rust: if let Some(offset) = self.custom_offset
    // rust: && f64::from(offset) != default_display_offset(self.kind)
    // rust: {
    // rust: put("DisplayOffset", Tag::Int(offset));
}
    // rust: if let Some(state) = &self.custom_display {
    // rust: put("DisplayState", state.clone());
}
    // rust: match self.kind {
    // rust: CartKind::Chest | CartKind::Hopper => {
    // rust: put("Items", horizon_client::save::encode_items(&self.items));
    // rust: if self.kind == CartKind::Hopper {
    // rust: put("Enabled", Tag::Byte(i8::from(self.enabled)));
}
}
    // rust: CartKind::Furnace => {
    // rust: put("PushX", Tag::Double(self.push.x.to_bits()));
    // rust: put("PushZ", Tag::Double(self.push.z.to_bits()));
    // rust: put("Fuel", Tag::Short(self.fuel as i16));
}
    // rust: CartKind::Tnt => put("fuse", Tag::Int(self.fuse)),
                // BaseCommandBlock.save (its CustomName shares the entity's key).
    // rust: CartKind::CommandBlock => {
    // rust: for (key, value) in self.command.save() {
    // rust: if !matches!(key, "CustomName" | "powered" | "conditionMet" | "auto") {
    // rust: put(key, value);
}
}
}
                // BaseSpawner.save: the delays, ranges, SpawnData and SpawnPotentials.
    // rust: CartKind::Spawner => {
    // rust: if let Some(spawner) = &self.spawner {
    // rust: for (key, value) in
    // rust: horizon_client::mobs::spawner::SpawnerExt::save(&**spawner)
    // rust: {
    // rust: put(key, value);
}
}
}
    // rust: CartKind::Rideable => {}
}
            // A loaded loot table goes back while the items are still its roll;
            // otherwise the items replace it, as vanilla's unpackLootTable does.
    // rust: if !self.loot.as_ref().is_some_and(|l| l.restore(map)) {
    // rust: map.remove(&JavaString::from("LootTable"));
    // rust: map.remove(&JavaString::from("LootTableSeed"));
}
}
    // rust: tag
}
pub fn from_nbt(tag: *horizon_world::nbt::Tag, id: u32, kind: CartKind) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (position, _, _) = horizon_client::entity_nbt::boat_from_nbt(tag)?;
    // rust: let mut c = Self::new(id, kind, position);
    // rust: c.load(tag)?;
    // rust: Some(c)
}
    /// `Entity.load` on this cart: the saved fields are read over the live
    /// ones, the rest (riders, lerp, hurt state) stays; its kind never changes.
    /// `None`, with nothing changed, when the compound has no position.
pub fn load(self: *Self, tag: *horizon_world::nbt::Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_world::nbt::Tag;
    // rust: let (position, velocity, yaw) = horizon_client::entity_nbt::boat_from_nbt(tag)?;
    // rust: let kind = self.kind;
    // rust: let c = self;
    // rust: c.position = position;
    // rust: c.previous = position;
    // rust: c.velocity = velocity;
    // rust: c.yaw = yaw;
    // rust: c.previous_yaw = yaw;
    // rust: c.no_gravity = horizon_client::entity_nbt::flag(tag, "NoGravity");
    // rust: c.pitch = horizon_client::entity_nbt::rotation(tag)[1];
    // rust: c.previous_pitch = c.pitch;
    // rust: let int = |k: &str| match tag.get(k) {
    // rust: Some(Tag::Byte(v)) => Some(i32::from(*v)),
    // rust: Some(Tag::Short(v)) => Some(i32::from(*v)),
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: _ => None,
}
    // rust: let double = |k: &str| match tag.get(k) {
    // rust: Some(Tag::Double(v)) => f64::from_bits(*v),
    // rust: _ => 0.0,
}
    // rust: c.flipped = int("FlippedRotation").unwrap_or(0) != 0;
    // rust: c.first_tick = int("HasTicked").unwrap_or(0) != 0;
    // rust: if kind.slots() > 0 {
    // rust: c.items = horizon_client::save::decode_items(tag.get("Items"), kind.slots());
}
    // rust: c.enabled = int("Enabled").unwrap_or(1) != 0;
    // rust: c.fuel = int("Fuel").unwrap_or(0);
        // readAdditionalSaveData: the saved push has no y.
    // rust: c.push = Vec3::new(double("PushX"), 0.0, double("PushZ"));
    // rust: c.fuse = int("fuse").unwrap_or(-1);
        // readAdditionalSaveData: DisplayState, DisplayOffset (default offset when absent).
    // rust: c.custom_display = tag.get("DisplayState").cloned();
    // rust: c.custom_offset = int("DisplayOffset");
    // rust: if kind == CartKind::CommandBlock {
    // rust: c.command = horizon_client::command_block::CommandBlock::load(tag);
            // MinecartCommandBlock.readAdditionalSaveData sets the synched command.
            // A changed value invokes onSyncedDataUpdated -> setCommand, resetting successes.
    // rust: if c.synced_command != c.command.command {
    // rust: c.synced_command.clone_from(&c.command.command);
    // rust: c.command.set_command(&c.synced_command);
}
    // rust: c.synced_output = c.command.last_output_string();
}
        // MinecartSpawner.readAdditionalSaveData: BaseSpawner.load.
    // rust: if kind == CartKind::Spawner {
    // rust: c.spawner = Some(Box::new(horizon_client::mobs::spawner::SpawnerExt::load(
    // rust: tag,
    // rust: )));
}
    // rust: Some(())
}
}

/// `VehicleEntity.hurtServer`'s destroy test: a creative player, damage past
/// 40, or (`MinecartTNT.shouldSourceDestroy`) fire or an explosion hitting a
/// TNT cart.
pub fn cart_is_destroyed(creative: bool, damage: f32, ignites_tnt: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: creative || damage > 40.0 || ignites_tnt
}

/// `MinecartTNT.tick`'s collision detonation: a cart still moving at a tenth
/// of a block a tick or more when a block stops it blows up.
pub fn tnt_ignites_by_collision(horizontal_collision: bool, speed_sqr: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizontal_collision && speed_sqr >= 0.009_999_999_776_482_582
}

/// NewMinecartBehavior's `(float) (Math.atan2(y, x) * 180.0 / Math.PI)` before
/// the cast: HotSpot's atan2, multiplied then divided in Java's order.
pub fn java_degrees(y: f64, x: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_core::jmath::atan2(y, x) * 180.0 / std::f64::consts::PI
}

    // rust: mod tests {
pub fn mob_walking_into_a_cart_pushes_it_by_a_twentieth() void {
}
        // Issue #6776: a villager at x=0.13 next to a cart at x=0.5 east-west.
    // rust: let (xa, za) =
    // rust: super::cart_push_from(Vec3::new(0.13, 0.0, 0.0), Vec3::new(0.5, 0.0, 0.0)).unwrap();
    // rust: assert!((xa + 0.05).abs() < 1e-6 && za == 0.0, "{xa} {za}");
    // rust: assert!(super::cart_push_from(Vec3::ZERO, Vec3::ZERO).is_none());
}
    /// Issue #6431: a blast too weak to push a cart past 40 damage still
    /// primes a TNT cart.
pub fn a_blast_ignites_a_tnt_cart_however_little_damage_it_does() void {
}
    // rust: assert!(cart_is_destroyed(false, 10.0, true));
    // rust: assert!(!cart_is_destroyed(false, 10.0, false));
    // rust: assert!(cart_is_destroyed(false, 40.5, false));
    // rust: assert!(!cart_is_destroyed(false, 40.0, false));
}
    /// The collision detonation of a TNT minecart needs both the collision and
    /// a cart that was still moving: a nudge below a tenth of a block a tick
    /// does not set it off, and a fast cart on an open track does not either.
pub fn a_tnt_cart_detonates_only_when_a_collision_stops_a_moving_one() void {
}
    // rust: assert!(tnt_ignites_by_collision(true, 0.01));
    // rust: assert!(tnt_ignites_by_collision(true, 0.36), "three tenths a tick");
    // rust: assert!(!tnt_ignites_by_collision(true, 0.0), "stopped at the wall");
    // rust: assert!(!tnt_ignites_by_collision(true, 0.009), "a nudge");
    // rust: assert!(!tnt_ignites_by_collision(false, 0.36), "nothing in the way");
}
//     use super::*;

    /// Issue #8624: chest and hopper carts keep 0.995 of their speed when
    /// empty (0.98 when full), not the plain cart's 0.96, so powered rails
    /// carry them much further.
pub fn container_carts_keep_more_speed_than_the_plain_cart() void {
}
    // rust: assert!((container_keep(0, false, false) - 0.995).abs() < 1e-6);
    // rust: assert!((container_keep(15, false, false) - 0.98).abs() < 1e-6);
    // rust: assert!((container_keep(5, true, false) - 0.98).abs() < 1e-6);
    // rust: assert!((container_keep(0, false, true) - 0.995 * 0.95).abs() < 1e-6);
}

pub fn a_tnt_cart_lets_the_held_item_be_used() void {
}
        // Entity.interact passes: a crossbow aimed at it shoots.
    // rust: assert!(CartKind::Tnt.interact_passes(false, false, true));
    // rust: assert!(CartKind::CommandBlock.interact_passes(false, false, false));
    // rust: assert!(!CartKind::CommandBlock.interact_passes(false, false, true));
    // rust: assert!(!CartKind::Rideable.interact_passes(false, false, false));
    // rust: assert!(CartKind::Rideable.interact_passes(true, false, false));
    // rust: assert!(CartKind::Rideable.interact_passes(false, true, false));
    // rust: for kind in [CartKind::Chest, CartKind::Hopper, CartKind::Furnace] {
    // rust: assert!(!kind.interact_passes(true, true, false));
}
}

//     use horizon_world::nbt::Tag;

pub fn saved_cart(kind: CartKind, extra: *[([]const u8) void {
}
//         use horizon_world::nbt::JavaString;
    // rust: let mut tag = Minecart::new(1, kind, Vec3::ZERO).to_nbt([0; 4], None);
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: for (k, v) in extra {
    // rust: map.insert(JavaString::from(*k), v.clone());
}
}
    // rust: tag
}

    /// AbstractMinecart.read/addAdditionalSaveData: `DisplayState` and
    /// `DisplayOffset` survive a save, the offset only off its default.
pub fn custom_display_state_and_offset_roundtrip() void {
}
        // BlockState.CODEC for a non-default state: {Name, Properties}.
    // rust: let state = Tag::Compound(
    // rust: [
    // rust: ("Name".into(), Tag::String("minecraft:furnace".into())),
    // rust: (
    // rust: "Properties".into(),
    // rust: Tag::Compound(
    // rust: [("lit".into(), Tag::String("true".into()))]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: ),
    // rust: ),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: );
    // rust: let saved = saved_cart(
    // rust: CartKind::Rideable,
    // rust: &[
    // rust: ("DisplayState", state.clone()),
    // rust: ("DisplayOffset", Tag::Int(10)),
    // rust: ],
    // rust: );
    // rust: let cart = Minecart::from_nbt(&saved, 1, CartKind::Rideable).unwrap();
    // rust: assert_eq!(cart.custom_display, Some(state.clone()));
    // rust: assert_eq!(display_offset(&cart), 10.0);
    // rust: let out = cart.to_nbt([0; 4], None);
    // rust: assert_eq!(out.get("DisplayState"), Some(&state));
    // rust: assert_eq!(out.get("DisplayOffset"), Some(&Tag::Int(10)));
}

    /// `/data merge entity` on a cart: `EntityDataAccessor.setData` loads the
    /// merged compound into the live cart (`Entity.load`). Its display state,
    /// offset and name read back; its id, kind and unsaved state stay.
pub fn data_merge_loads_into_a_live_cart() void {
}
    // rust: let mut cart = Minecart::new(7, CartKind::Chest, Vec3::new(1.5, 64.0, 2.5));
    // rust: cart.hurt_time = 5;
    // rust: let old = cart.to_nbt([0; 4], None);
    // rust: let (patch, _) = horizon_world::nbt::parse_snbt(
    // rust: r#"{DisplayState:"minecraft:furnace",DisplayOffset:3,CustomName:"Cart",Pos:[1.5d,70.0d,2.5d]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let merged = horizon_client::data_cmd::merged(&old, &patch);
    // rust: cart.load(&merged).unwrap();
    // rust: assert_eq!(
    // rust: (cart.id, cart.kind, cart.hurt_time),
    // rust: (7, CartKind::Chest, 5)
    // rust: );
    // rust: assert_eq!(cart.position, Vec3::new(1.5, 70.0, 2.5));
    // rust: assert_eq!(display_offset(&cart), 3.0);
    // rust: let out = cart.to_nbt([0; 4], Some(&merged));
    // rust: assert_eq!(out.get("DisplayState"), patch.get("DisplayState"));
    // rust: assert_eq!(out.get("DisplayOffset"), Some(&Tag::Int(3)));
    // rust: assert_eq!(out.get("CustomName"), Some(&Tag::String("Cart".into())));
        // A compound without a position loads nothing.
    // rust: let mut no_pos = merged.clone();
    // rust: if let Tag::Compound(map) = &mut no_pos {
    // rust: map.remove(&"Pos".into());
    // rust: map.insert("DisplayOffset".into(), Tag::Int(9));
}
    // rust: assert!(cart.load(&no_pos).is_none());
    // rust: assert_eq!(display_offset(&cart), 3.0);
}

    /// A merge of an unrelated key loads the cart's own saved state back
    /// unchanged: a furnace cart keeps its fuel and push, a TNT cart its fuse,
    /// a hopper cart its Enabled flag.
pub fn data_merge_of_a_name_keeps_the_carts_state() void {
}
    // rust: let mut furnace = Minecart::new(1, CartKind::Furnace, Vec3::ZERO);
    // rust: (furnace.fuel, furnace.push) = (1200, Vec3::new(0.5, 0.0, -0.25));
    // rust: let mut tnt = Minecart::new(2, CartKind::Tnt, Vec3::ZERO);
    // rust: tnt.fuse = 40;
    // rust: let mut hopper = Minecart::new(3, CartKind::Hopper, Vec3::ZERO);
    // rust: hopper.enabled = false;
    // rust: let (patch, _) = horizon_world::nbt::parse_snbt(r#"{CustomName:"x"}"#).unwrap();
    // rust: for cart in [furnace, tnt, hopper] {
    // rust: let mut merged_cart = cart.clone();
    // rust: let merged = horizon_client::data_cmd::merged(&cart.to_nbt([0; 4], None), &patch);
    // rust: merged_cart.load(&merged).unwrap();
    // rust: assert_eq!(
    // rust: (
    // rust: merged_cart.fuel,
    // rust: merged_cart.push,
    // rust: merged_cart.fuse,
    // rust: merged_cart.enabled
    // rust: ),
    // rust: (cart.fuel, cart.push, cart.fuse, cart.enabled),
    // rust: "{:?}",
    // rust: cart.kind
    // rust: );
}
}

pub fn air_display_state_shows_nothing() void {
}
    // rust: let (air, stone) = (BlockStateId(0), BlockStateId(1));
    // rust: assert_eq!(shown_unless_air(Some(air), |s| s == air), None);
    // rust: assert_eq!(shown_unless_air(Some(stone), |s| s == air), Some(stone));
    // rust: assert_eq!(shown_unless_air(None, |s| s == air), None);
}

pub fn an_unreadable_display_state_is_dropped_and_not_saved() void {
}
    // rust: let bad = Tag::String("mod:gone".into());
    // rust: let saved = saved_cart(CartKind::Rideable, &[("DisplayState", bad)]);
    // rust: let mut cart = Minecart::from_nbt(&saved, 1, CartKind::Rideable).unwrap();
    // rust: forget_unreadable_display(&mut cart, |_| false);
    // rust: assert!(cart.custom_display.is_none());
    // rust: assert!(
    // rust: cart.to_nbt([0; 4], Some(&saved))
    // rust: .get("DisplayState")
    // rust: .is_none()
    // rust: );
        // A readable one is kept.
    // rust: let mut cart = Minecart::from_nbt(&saved, 1, CartKind::Rideable).unwrap();
    // rust: forget_unreadable_display(&mut cart, |_| true);
    // rust: assert!(cart.custom_display.is_some());
}

pub fn display_offset_is_not_saved_at_its_default() void {
}
        // A hopper cart's default is 1, a chest cart's 8, any other kind's 6.
    // rust: for (kind, default) in [
    // rust: (CartKind::Hopper, 1),
    // rust: (CartKind::Chest, 8),
    // rust: (CartKind::Rideable, 6),
    // rust: ] {
    // rust: let saved = saved_cart(kind, &[("DisplayOffset", Tag::Int(default))]);
    // rust: let cart = Minecart::from_nbt(&saved, 1, kind).unwrap();
    // rust: assert_eq!(display_offset(&cart), f64::from(default));
    // rust: let out = cart.to_nbt([0; 4], Some(&saved));
    // rust: assert!(out.get("DisplayOffset").is_none(), "{kind:?}");
    // rust: assert!(out.get("DisplayState").is_none(), "{kind:?}");
}
        // A hopper cart saved with 6 keeps it: that is not its default.
    // rust: let saved = saved_cart(CartKind::Hopper, &[("DisplayOffset", Tag::Int(6))]);
    // rust: let cart = Minecart::from_nbt(&saved, 1, CartKind::Hopper).unwrap();
    // rust: assert_eq!(
    // rust: cart.to_nbt([0; 4], None).get("DisplayOffset"),
    // rust: Some(&Tag::Int(6))
    // rust: );
        // And a chest cart saved with 6, the base default, keeps it too.
    // rust: let saved = saved_cart(CartKind::Chest, &[("DisplayOffset", Tag::Int(6))]);
    // rust: let cart = Minecart::from_nbt(&saved, 1, CartKind::Chest).unwrap();
    // rust: assert_eq!(display_offset(&cart), 6.0);
    // rust: assert_eq!(
    // rust: cart.to_nbt([0; 4], None).get("DisplayOffset"),
    // rust: Some(&Tag::Int(6))
    // rust: );
}

pub fn display_offset_matches_vanilla_for_each_cart_kind() void {
}
        // MinecartChest and MinecartHopper override getDefaultDisplayOffset;
        // the rest keep AbstractMinecart's 6.
    // rust: assert_eq!(default_display_offset(CartKind::Chest), 8.0);
    // rust: assert_eq!(default_display_offset(CartKind::Hopper), 1.0);
    // rust: assert_eq!(default_display_offset(CartKind::Furnace), 6.0);
    // rust: assert_eq!(default_display_offset(CartKind::Tnt), 6.0);
    // rust: assert_eq!(default_display_offset(CartKind::CommandBlock), 6.0);
    // rust: assert_eq!(default_display_offset(CartKind::Spawner), 6.0);
    // rust: assert_eq!(default_display_offset(CartKind::Rideable), 6.0);
        // A cart without a saved offset draws at its kind's default.
    // rust: let chest = Minecart::new(1, CartKind::Chest, Vec3::ZERO);
    // rust: assert_eq!(display_offset(&chest), 8.0);
}

    /// `MinecartSpawner`: its `BaseSpawner` is saved and loaded with the cart (the delay, the
    /// ranges and the `SpawnData`), it drops and is picked as a plain minecart, and it shows a
    /// spawner block.
pub fn a_spawner_cart_keeps_its_spawner_and_drops_a_minecart() void {
}
//         use horizon_world::nbt::Tag;
    // rust: let saved = Tag::compound([
    // rust: ("id", Tag::String("minecraft:spawner_minecart".into())),
    // rust: (
    // rust: "Pos",
    // rust: Tag::List(
    // rust: [0.5f64, 40.5, 0.5]
    // rust: .map(|v| Tag::Double(v.to_bits()))
    // rust: .to_vec(),
    // rust: ),
    // rust: ),
    // rust: ("Delay", Tag::Short(37)),
    // rust: ("MaxSpawnDelay", Tag::Short(120)),
    // rust: ("SpawnRange", Tag::Short(2)),
    // rust: (
    // rust: "SpawnData",
    // rust: Tag::compound([(
    // rust: "entity",
    // rust: Tag::compound([("id", Tag::String("minecraft:zombie".into()))]),
    // rust: )]),
    // rust: ),
    // rust: ]);
    // rust: let mut cart = Minecart::from_nbt(&saved, 1, CartKind::Spawner).unwrap();
    // rust: let spawner = cart.spawner.as_mut().expect("a spawner cart has a spawner");
    // rust: assert_eq!(
    // rust: (
    // rust: spawner.spawn_delay,
    // rust: spawner.max_spawn_delay,
    // rust: spawner.spawn_range
    // rust: ),
    // rust: (37, 120, 2)
    // rust: );
        // No raw tag to copy from: what comes out is the cart's own save.
    // rust: spawner.spawn_delay = 41;
    // rust: let out = cart.to_nbt([0; 4], None);
    // rust: assert_eq!(out.get("Delay"), Some(&Tag::Short(41)));
    // rust: assert_eq!(out.get("MaxSpawnDelay"), Some(&Tag::Short(120)));
    // rust: assert_eq!(
    // rust: out.get("SpawnData")
    // rust: .and_then(|d| d.get("entity"))
    // rust: .and_then(|e| e.get("id")),
    // rust: Some(&Tag::String("minecraft:zombie".into()))
    // rust: );
    // rust: assert_eq!(CartKind::Spawner.item(), "minecraft:minecart");
    // rust: assert_eq!(
    // rust: CartKind::from_id("minecraft:spawner_minecart"),
    // rust: Some(CartKind::Spawner)
    // rust: );
        // A summoned one has a spawner of its own.
    // rust: assert!(
    // rust: Minecart::new(2, CartKind::Spawner, Vec3::ZERO)
    // rust: .spawner
    // rust: .is_some()
    // rust: );
}

pub fn a_cow_boards_an_empty_cart_and_an_iron_golem_does_not() void {
}
    // rust: assert!(pickup_instead_of_push(Species::Cow, false, false));
    // rust: assert!(can_ride_cart(Species::Cow, 0));
    // rust: assert!(!pickup_instead_of_push(Species::IronGolem, false, false));
    // rust: assert!(!pickup_instead_of_push(Species::Cow, false, true));
    // rust: assert!(!pickup_instead_of_push(Species::Cow, true, false));
    // rust: assert!(!can_ride_cart(Species::Cow, 60));
    // rust: assert!(!can_ride_cart(Species::Warden, 0));
}

    /// `WitherBoss.canRide` returns false, so a moving cart cannot scoop the boss up.
pub fn a_wither_never_rides_a_cart() void {
}
    // rust: assert!(!can_ride_cart(Species::Wither, 0));
}

pub fn a_cart_seat_matches_the_player_offset() void {
}
    // rust: let at = Vec3::new(1.0, 10.0, 2.0);
    // rust: assert!((cart_seat(at, 0.0).y - 10.1875).abs() < 1e-12);
    // rust: assert!((cart_seat(at, 0.6).y - (10.0 + SEAT)).abs() < 1e-12);
    // rust: assert_eq!(cart_seat(at, 0.0).x, 1.0);
    // rust: assert_eq!(cart_seat(at, 0.0).z, 2.0);
}

pub fn a_cart_saves_as_never_ticked_until_it_ticks() void {
}
//         use horizon_world::nbt::Tag;
    // rust: let generated = Tag::compound([
    // rust: ("id", Tag::String("minecraft:chest_minecart".into())),
    // rust: (
    // rust: "Pos",
    // rust: Tag::List(
    // rust: [0.5f64, 40.5, 0.5]
    // rust: .map(|v| Tag::Double(v.to_bits()))
    // rust: .to_vec(),
    // rust: ),
    // rust: ),
    // rust: ("HasTicked", Tag::Byte(1)),
    // rust: ("Fire", Tag::Short(0)),
    // rust: ]);
    // rust: let mut cart = Minecart::from_nbt(&generated, 1, CartKind::Chest).unwrap();
    // rust: let saved = cart.to_nbt([0; 4], Some(&generated));
    // rust: assert_eq!(saved.get("HasTicked"), Some(&Tag::Byte(1)));
    // rust: assert_eq!(saved.get("Fire"), Some(&Tag::Short(0)));
    // rust: cart.first_tick = false;
    // rust: let saved = cart.to_nbt([0; 4], Some(&generated));
    // rust: assert_eq!(saved.get("HasTicked"), Some(&Tag::Byte(0)));
    // rust: assert_eq!(saved.get("Fire"), Some(&Tag::Short(0)));
}

pub fn a_command_cart_saves_its_base_command_block() void {
}
//         use horizon_world::nbt::Tag;
    // rust: let saved = Tag::compound([
    // rust: (
    // rust: "Pos",
    // rust: Tag::List(
    // rust: [0.5f64, 40.5, 0.5]
    // rust: .map(|v| Tag::Double(v.to_bits()))
    // rust: .to_vec(),
    // rust: ),
    // rust: ),
    // rust: ("Command", Tag::String("say hi".into())),
    // rust: ("SuccessCount", Tag::Int(3)),
    // rust: ("TrackOutput", Tag::Byte(1)),
    // rust: ("LastOutput", Tag::String("[12:00:00] hi".into())),
    // rust: ("LastExecution", Tag::Long(42)),
    // rust: ]);
    // rust: let cart = Minecart::from_nbt(&saved, 1, CartKind::CommandBlock).unwrap();
    // rust: assert_eq!(cart.command.command, "say hi");
    // rust: assert_eq!(cart.command.success_count, 0);
        // readAdditionalSaveData syncs both values.
    // rust: assert_eq!(cart.synced_command, "say hi");
    // rust: assert_eq!(cart.synced_output, "[12:00:00] hi");
    // rust: let out = cart.to_nbt([0; 4], Some(&saved));
    // rust: assert_eq!(out.get("SuccessCount"), Some(&Tag::Int(0)));
    // rust: for key in ["Command", "TrackOutput", "LastOutput", "LastExecution"] {
    // rust: assert_eq!(out.get(key), saved.get(key), "{key}");
}
    // rust: assert_eq!(out.get("UpdateLastExecution"), Some(&Tag::Byte(1)));
        // A block-only flag never reaches the entity.
    // rust: assert!(out.get("powered").is_none() && out.get("auto").is_none());
        // Untracked output drops the saved last output.
    // rust: let mut quiet = cart.clone();
    // rust: quiet.command.track_output = false;
    // rust: let out = quiet.to_nbt([0; 4], Some(&saved));
    // rust: assert!(out.get("LastOutput").is_none());
    // rust: assert_eq!(out.get("TrackOutput"), Some(&Tag::Byte(0)));
}

pub fn furnace_push_keeps_its_length_under_gravity() void {
}
        // Gravity gives the movement a vertical part. The push turns onto the
        // movement at the same 3D length every tick, as vanilla's does.
    // rust: let movement = Vec3::new(0.2, -0.04, 0.0);
    // rust: let mut push = Vec3::new(0.5, 0.0, 0.0);
    // rust: for _ in 0..1000 {
    // rust: push = push_along(push, movement);
}
    // rust: assert!((push.length() - 0.5).abs() < 1e-12);
    // rust: assert!((push.x - 0.5 * 0.2 / movement.length()).abs() < 1e-12);
}

pub fn a_furnace_saves_its_push_without_y() void {
}
//         use horizon_world::nbt::Tag;
    // rust: let generated = Tag::compound([
    // rust: ("id", Tag::String("minecraft:furnace_minecart".into())),
    // rust: (
    // rust: "Pos",
    // rust: Tag::List(
    // rust: [0.5f64, 40.5, 0.5]
    // rust: .map(|v| Tag::Double(v.to_bits()))
    // rust: .to_vec(),
    // rust: ),
    // rust: ),
    // rust: ]);
    // rust: let mut cart = Minecart::from_nbt(&generated, 1, CartKind::Furnace).unwrap();
    // rust: cart.push = Vec3::new(0.5, 0.7, 0.25);
    // rust: let saved = cart.to_nbt([0; 4], Some(&generated));
    // rust: assert_eq!(saved.get("PushX"), Some(&Tag::Double(0.5f64.to_bits())));
    // rust: assert_eq!(saved.get("PushZ"), Some(&Tag::Double(0.25f64.to_bits())));
    // rust: let loaded = Minecart::from_nbt(&saved, 1, CartKind::Furnace).unwrap();
    // rust: assert_eq!(loaded.push, Vec3::new(0.5, 0.0, 0.25));
}
}
    // rust: horizon_client::impl_joined!(Minecart);
