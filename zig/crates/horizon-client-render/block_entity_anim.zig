//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_block_entity_anim
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Client-ticked block-entity animation state, as vanilla's block entities
//! keep it: `ChestLidController` (chests, trapped and copper chests, ender
//! chests), `EnchantingTableBlockEntity.bookAnimationTick`,
//! `ShulkerBoxBlockEntity` (open count, animation status, progress),
//! `BellBlockEntity` (ring ticks, shake direction, resonation),
//! `ConduitBlockEntity.clientTick` (tick count, shape check, rotation,
//! hunting, nautilus particles), `SkullBlockEntity.animation` (powered dragon
//! and piglin heads) and `DecoratedPotBlockEntity` wobbles.
//!
//! [`BlockEntityAnims`] holds the state per position and turns it into the
//! renderer's [`BlockAnim`]. Its tick methods take what the level answers
//! (blocks, entities, game time) as closures, so the parity fixture can drive
//! them with scripted inputs (`tools/test_block_entity_anim_parity.py`).
// use crate::block_entity_render::BlockAnim;
// use crate::fast_hash::FxHashMap;
// use horizon_core::{
    // rust: geometry::trig::{self, Mth},
    // rust: random::{LegacyRandom, RandomSource},
}

/// `Direction` names by `get3DDataValue`.
pub const DIRECTIONS: [[]const u8; 6] = ["down", "up", "north", "south", "west", "east"];

pub fn step(direction: u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match direction {
    // rust: 0 => [0, -1, 0],
    // rust: 1 => [0, 1, 0],
    // rust: 2 => [0, 0, -1],
    // rust: 3 => [0, 0, 1],
    // rust: 4 => [-1, 0, 0],
    // rust: _ => [1, 0, 0],
}
}

/// `Direction.from3DDataValue`: `BY_3D_DATA[Mth.abs(data % 6)]`.
pub fn from_3d_data_value(data: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (data % 6).unsigned_abs() as u8
}

/// The 3D data value of a direction name.
pub fn direction_index(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: DIRECTIONS.iter().position(|d| *d == name).map(|i| i as u8)
}

/// `ChestLidController`, shared by `ChestBlockEntity` (chests, trapped and
/// copper chests) and `EnderChestBlockEntity`.
pub const ChestLid = struct {
    should_be_open: bool,
    openness: f32,
    o_openness: f32,
};

    // rust: impl ChestLid {
    /// `triggerEvent(1, openCount)`: the lid opens while anyone has it open.
pub fn trigger_event(self: *Self, b0: i32, b1: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if b0 == 1 {
    // rust: self.should_be_open = b1 > 0;
    // rust: true
    // rust: } else {
    // rust: false
}
}
    /// `tickLid` (the client ticker `lidAnimateTick`).
pub fn tick(self: *Self) void {
}
    // rust: self.o_openness = self.openness;
    // rust: if !self.should_be_open && self.openness > 0.0 {
    // rust: self.openness = (self.openness - 0.1).max(0.0);
    // rust: } else if self.should_be_open && self.openness < 1.0 {
    // rust: self.openness = (self.openness + 0.1).min(1.0);
}
}
    /// `getOpenness(a)`: `Mth.lerp(a, oOpenness, openness)`.
pub fn get_openness(self: *Self, a: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.o_openness + a * (self.openness - self.o_openness)
}
}

/// `ChestBlock.opennessCombiner`: a double chest opens as far as its more
/// open half (`Math.max(first, second)`, first being the `right` half).
pub fn combined_openness(first: f32, second: ?f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match second {
    // rust: Some(second) => java_max(first, second),
    // rust: None => first,
}
}

/// `Math.max(float, float)`.
pub fn java_max(a: f32, b: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if a == 0.0 && b == 0.0 && a.to_bits() != b.to_bits() {
    // rust: 0.0
    // rust: } else if a >= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}

/// `ChestRenderer.submit` and `ChestModel.setupAnim`: the lid and lock
/// `xRot` for a render-state openness.
pub fn chest_lid_x_rot(open: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let open = 1.0 - open;
    // rust: let open = 1.0 - open * open * open;
    // rust: -(open * std::f32::consts::FRAC_PI_2)
}

/// `EnchantingTableBlockEntity` book fields.
pub const EnchantingBook = struct {
    time: i32,
    flip: f32,
    o_flip: f32,
    flip_t: f32,
    flip_a: f32,
    open: f32,
    o_open: f32,
    rot: f32,
    o_rot: f32,
    t_rot: f32,
};

/// The `while (a >= PI) a -= 2PI; while (a < -PI) a += 2PI` loops.
pub fn wrap_pi(mut a: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::f32::consts::PI;
    // rust: while a >= PI {
    // rust: a -= 2.0 * PI;
}
    // rust: while a < -PI {
    // rust: a += 2.0 * PI;
}
    // rust: a
}

/// `Mth.floor(float)`.
pub fn mth_floor(v: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = v as i32;
    // rust: if v < i as f32 { i - 1 } else { i }
}

/// `Mth.frac(float)`.
pub fn mth_frac(v: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v - mth_floor(v) as f32
}

/// `EnchantTableRenderState` (`EnchantTableRenderer.extractRenderState`) and
/// the `BookModel.State` its `submit` builds.
pub const BookRender = struct {
    flip: f32,
    open: f32,
    time: f32,
    y_rot: f32,
    /// `BookModel.State.forAnimation`: openness, pageFlip1, pageFlip2.
    openness: f32,
    page_flip1: f32,
    page_flip2: f32,
};

    // rust: impl EnchantingBook {
    /// `bookAnimationTick`. `players` are the feet positions of the level's
    /// non-spectator players (`getNearestPlayer(centre, 3.0, false)`);
    /// `random` is the block entity class's shared static `RANDOM`.
pub fn tick(self: *Self, pos: [i32; 3], players: *[[f64; 3]], random: *mut impl RandomSource) void {
}
    // rust: self.o_open = self.open;
    // rust: self.o_rot = self.rot;
    // rust: let c = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: let mut best = -1.0;
    // rust: let mut nearest = None;
    // rust: for p in players {
    // rust: let (dx, dy, dz) = (p[0] - c[0], p[1] - c[1], p[2] - c[2]);
    // rust: let dist = dx * dx + dy * dy + dz * dz;
    // rust: if dist < 9.0 && (best == -1.0 || dist < best) {
    // rust: best = dist;
    // rust: nearest = Some(*p);
}
}
    // rust: if let Some(p) = nearest {
    // rust: let xd = p[0] - c[0];
    // rust: let zd = p[2] - c[2];
    // rust: self.t_rot = trig::atan2(zd, xd) as f32;
    // rust: self.open += 0.1;
    // rust: if self.open < 0.5 || random.next_int_bound(40).unwrap_or(1) == 0 {
    // rust: let old = self.flip_t;
    // rust: loop {
    // rust: let a = random.next_int_bound(4).unwrap_or(0);
    // rust: let b = random.next_int_bound(4).unwrap_or(0);
    // rust: self.flip_t += (a - b) as f32;
    // rust: if old != self.flip_t {
    // rust: break;
}
}
}
    // rust: } else {
    // rust: self.t_rot += 0.02;
    // rust: self.open -= 0.1;
}
    // rust: self.rot = wrap_pi(self.rot);
    // rust: self.t_rot = wrap_pi(self.t_rot);
    // rust: let dir = wrap_pi(self.t_rot - self.rot);
    // rust: self.rot += dir * 0.4;
    // rust: self.open = self.open.clamp(0.0, 1.0);
    // rust: self.time += 1;
    // rust: self.o_flip = self.flip;
    // rust: let diff = ((self.flip_t - self.flip) * 0.4).clamp(-0.2, 0.2);
    // rust: self.flip_a += (diff - self.flip_a) * 0.9;
    // rust: self.flip += self.flip_a;
}
    /// `EnchantTableRenderer.extractRenderState` and the book state of its
    /// `submit`.
pub fn render(self: *Self, a: f32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let flip = self.o_flip + a * (self.flip - self.o_flip);
    // rust: let open = self.o_open + a * (self.open - self.o_open);
    // rust: let time = self.time as f32 + a;
    // rust: let y_rot = self.o_rot + wrap_pi(self.rot - self.o_rot) * a;
    // rust: let ff1 = mth_frac(flip + 0.25) * 1.6 - 0.3;
    // rust: let ff2 = mth_frac(flip + 0.75) * 1.6 - 0.3;
    // rust: BookRender {
    // rust: flip,
    // rust: open,
    // rust: time,
    // rust: y_rot,
    // rust: openness: ((time * 0.02).msin() * 0.1 + 1.25) * open,
    // rust: page_flip1: ff1.clamp(0.0, 1.0),
    // rust: page_flip2: ff2.clamp(0.0, 1.0),
}
}
}

/// `ShulkerBoxBlockEntity.AnimationStatus`.
pub const ShulkerStatus = enum {
    Closed,
    Opening,
    Opened,
    Closing,
};

/// `ShulkerBoxBlockEntity` lid state.
pub const Shulker = struct {
    open_count: i32,
    status: ShulkerStatus,
    progress: f32,
    progress_old: f32,
};

/// Side effects of one [`Shulker::tick`].
pub const ShulkerTick = struct {
    /// `doNeighborUpdates` calls (shape and neighbour updates around the box).
    neighbor_updates: u32,
    /// `moveCollidedEntities`: the swept lid box (min x, y, z, max x, y, z);
    /// entities in it move out along the facing.
    push: Option<[f64,
};

/// `Shulker.getProgressDeltaAabb(size, direction, from, to, position)`.
    // rust: pub fn progress_delta_aabb(
    // rust: size: f32,
    // rust: direction: u8,
    // rust: from: f32,
    // rust: to: f32,
    // rust: position: [f64; 3],
    // rust: ) -> [f64; 6] {
    // rust: let size_d = f64::from(size);
    // rust: let mut b = [
    // rust: -size_d * 0.5,
    // rust: 0.0,
    // rust: -size_d * 0.5,
    // rust: size_d * 0.5,
    // rust: size_d,
    // rust: size_d * 0.5,
    // rust: ];
    // rust: let max = f64::from(from.max(to));
    // rust: let min = f64::from(from.min(to));
    // rust: let s = step(direction);
    // rust: for axis in 0..3 {
        // expandTowards
    // rust: let a = f64::from(s[axis]) * max * size_d;
    // rust: if a < 0.0 {
    // rust: b[axis] += a;
    // rust: } else if a > 0.0 {
    // rust: b[axis + 3] += a;
}
}
    // rust: for axis in 0..3 {
        // contract
    // rust: let a = -f64::from(s[axis]) * (1.0 + min) * size_d;
    // rust: if a < 0.0 {
    // rust: b[axis] -= a;
    // rust: } else if a > 0.0 {
    // rust: b[axis + 3] -= a;
}
}
    // new AABB keeps min <= max; then move to the position.
    // rust: let mut out = [0.0; 6];
    // rust: for axis in 0..3 {
    // rust: out[axis] = b[axis].min(b[axis + 3]) + position[axis];
    // rust: out[axis + 3] = b[axis].max(b[axis + 3]) + position[axis];
}
    // rust: out
}

    // rust: impl Shulker {
    /// `triggerEvent(1, openCount)`.
pub fn trigger_event(self: *Self, b0: i32, b1: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if b0 != 1 {
    // rust: return false;
}
    // rust: self.open_count = b1;
    // rust: if b1 == 0 {
    // rust: self.status = ShulkerStatus::Closing;
}
    // rust: if b1 == 1 {
    // rust: self.status = ShulkerStatus::Opening;
}
    // rust: true
}
    /// `startOpen`/`stopOpen` for a non-spectator user: the new open count to
    /// send as block event 1, and whether this was the first opener (open) or
    /// the last closer (close), which play the sound and game event.
pub fn start_open(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.open_count < 0 {
    // rust: self.open_count = 0;
}
    // rust: self.open_count += 1;
    // rust: (self.open_count, self.open_count == 1)
}
pub fn stop_open(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.open_count -= 1;
    // rust: (self.open_count, self.open_count <= 0)
}
    /// `updateAnimation` (`ShulkerBoxBlockEntity.tick`); `facing` is the
    /// block's facing as a 3D data value.
pub fn tick(self: *Self, pos: [i32; 3], facing: u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = ShulkerTick::default();
    // rust: self.progress_old = self.progress;
    // rust: match self.status {
    // rust: ShulkerStatus::Closed => self.progress = 0.0,
    // rust: ShulkerStatus::Opening => {
    // rust: self.progress += 0.1;
    // rust: if self.progress_old == 0.0 {
    // rust: out.neighbor_updates += 1;
}
    // rust: if self.progress >= 1.0 {
    // rust: self.status = ShulkerStatus::Opened;
    // rust: self.progress = 1.0;
    // rust: out.neighbor_updates += 1;
}
    // rust: let bottom = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: out.push = Some(progress_delta_aabb(
    // rust: 1.0,
    // rust: facing,
    // rust: self.progress_old,
    // rust: self.progress,
    // rust: bottom,
    // rust: ));
}
    // rust: ShulkerStatus::Opened => self.progress = 1.0,
    // rust: ShulkerStatus::Closing => {
    // rust: self.progress -= 0.1;
    // rust: if self.progress_old == 1.0 {
    // rust: out.neighbor_updates += 1;
}
    // rust: if self.progress <= 0.0 {
    // rust: self.status = ShulkerStatus::Closed;
    // rust: self.progress = 0.0;
    // rust: out.neighbor_updates += 1;
}
}
}
    // rust: out
}
    /// `ShulkerBoxBlock.canOpen`: a closed box only opens when its lid has room
    /// (`level.noCollision` of the lid box at half progress, deflated by 1e-6).
pub fn lid_box(pos: [i32; 3], facing: u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bottom = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: let mut b = progress_delta_aabb(1.0, facing, 0.0, 0.5, bottom);
    // rust: for axis in 0..3 {
    // rust: b[axis] += 1.0e-6;
    // rust: b[axis + 3] -= 1.0e-6;
}
    // rust: b
}
}

/// What the bell's tick asks about an entity it gathered when rung.
pub const BellEntity = struct {
    position: [f64,
    /// `isAlive() && !isRemoved()`.
    alive: bool,
    /// In `EntityTypeTags.RAIDERS`.
    raider: bool,
};

/// `BellBlockEntity`.
pub const Bell = struct {
    ticks: i32,
    shaking: bool,
    /// `clickDirection` as a 3D data value.
    click_direction: ?u8,
    last_ring_timestamp: i64,
    /// `nearbyEntities`: the living entities around the bell when it was last
    /// gathered, as caller-defined handles.
    nearby: ?std.ArrayList(u64),
    resonating: bool,
    resonation_ticks: i32,
};

/// Side effects of one [`Bell::tick`].
pub const BellTick = struct {
    /// Resonation started: `BELL_RESONATE` (played by the server).
    resonate: bool,
    /// Resonation ended (`ResonationEndAction`): the client's
    /// `showBellParticles` entity-effect particles (position and colour) and
    /// the server's `makeRaidersGlow` targets.
    ended: Option<(Vec<([f64,
};

/// `Vec3i.closerToCenterThan`: `p` is within `distance` of the block's centre.
pub fn closer_to_center_than(pos: [i32; 3], p: [f64; 3], distance: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dx = f64::from(pos[0]) + 0.5 - p[0];
    // rust: let dy = f64::from(pos[1]) + 0.5 - p[1];
    // rust: let dz = f64::from(pos[2]) + 0.5 - p[2];
    // rust: dx * dx + dy * dy + dz * dz < distance * distance
}

    // rust: impl Bell {
    /// `triggerEvent(1, direction)`. `gather` lists the living entities whose
    /// position is inside the bell's block box inflated by 48
    /// (`updateEntities`, refreshed at most every 60 ticks).
    // rust: pub fn trigger_event(
    // rust: &mut self,
    // rust: b0: i32,
    // rust: b1: i32,
    // rust: game_time: i64,
    // rust: gather: impl FnOnce() -> Vec<u64>,
    // rust: ) -> bool {
    // rust: if b0 != 1 {
    // rust: return false;
}
    // rust: if game_time > self.last_ring_timestamp + 60 || self.nearby.is_none() {
    // rust: self.last_ring_timestamp = game_time;
    // rust: self.nearby = Some(gather());
}
    // rust: self.resonation_ticks = 0;
    // rust: self.click_direction = Some(from_3d_data_value(b1));
    // rust: self.ticks = 0;
    // rust: self.shaking = true;
    // rust: true
}
    /// `BellBlockEntity.tick` with the client's resonation end action.
pub fn tick(self: *Self, pos: [i32; 3], entity: impl Fn(u64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = BellTick::default();
    // rust: if self.shaking {
    // rust: self.ticks += 1;
}
    // rust: if self.ticks >= 50 {
    // rust: self.shaking = false;
    // rust: self.ticks = 0;
}
    // rust: let nearby = self.nearby.clone().unwrap_or_default();
    // rust: let raider_in = |e: &BellEntity, distance: f64| {
    // rust: e.alive && closer_to_center_than(pos, e.position, distance) && e.raider
}
    // rust: if self.ticks >= 5
    // rust: && self.resonation_ticks == 0
    // rust: && nearby
    // rust: .iter()
    // rust: .filter_map(|&h| entity(h))
    // rust: .any(|e| raider_in(&e, 32.0))
    // rust: {
    // rust: self.resonating = true;
    // rust: out.resonate = true;
}
    // rust: if self.resonating {
    // rust: if self.resonation_ticks < 40 {
    // rust: self.resonation_ticks += 1;
    // rust: } else {
                // showBellParticles / makeRaidersGlow.
    // rust: let mut color = 16_700_985;
    // rust: let views: Vec<(u64, BellEntity)> = nearby
    // rust: .iter()
    // rust: .filter_map(|&h| Some((h, entity(h)?)))
    // rust: .collect();
    // rust: let count = views
    // rust: .iter()
    // rust: .filter(|(_, e)| closer_to_center_than(pos, e.position, 48.0))
    // rust: .count() as i32;
    // rust: let per = ((count - 21) / -2).clamp(3, 15);
    // rust: let mut particles = Vec::new();
    // rust: let mut glow = Vec::new();
    // rust: for (h, e) in &views {
    // rust: if !raider_in(e, 48.0) {
    // rust: continue;
}
    // rust: glow.push(*h);
    // rust: let (bx, bz) = (f64::from(pos[0]), f64::from(pos[2]));
    // rust: let dist = ((e.position[0] - bx) * (e.position[0] - bx)
    // rust: + (e.position[2] - bz) * (e.position[2] - bz))
    // rust: .sqrt();
    // rust: let x3 = bx + f64::from(0.5f32) + 1.0 / dist * (e.position[0] - bx);
    // rust: let z3 = bz + f64::from(0.5f32) + 1.0 / dist * (e.position[2] - bz);
    // rust: for _ in 0..per {
    // rust: color += 5;
    // rust: particles.push(([x3, f64::from(pos[1]) + 0.5, z3], color));
}
}
    // rust: out.ended = Some((particles, glow));
    // rust: self.resonating = false;
}
}
    // rust: out
}
}

/// The conduit's `destroyTarget` as the client sees it.
pub const ConduitTarget = struct {
    position: [f64,
    eye_y: f64,
    width: f32,
    height: f32,
};

/// `ConduitBlockEntity` (client side).
pub const Conduit = struct {
    tick_count: i32,
    active_rotation: f32,
    is_active: bool,
    is_hunting: bool,
    effect_blocks: Vec<[i32,
};

/// One nautilus particle: position and velocity.
    // rust: pub type Particle = ([f64; 3], [f64; 3]);

    // rust: impl Conduit {
    /// `updateShape`: water all around, then the frame blocks
    /// (`BlockTags.CONDUIT_EFFECT_BLOCK`) in the three 5x5 rings.
    // rust: fn update_shape(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: is_water: &impl Fn([i32; 3]) -> bool,
    // rust: is_frame: &impl Fn([i32; 3]) -> bool,
    // rust: ) -> bool {
    // rust: self.effect_blocks.clear();
    // rust: for ox in -1..=1 {
    // rust: for oy in -1..=1 {
    // rust: for oz in -1..=1 {
    // rust: if !is_water([pos[0] + ox, pos[1] + oy, pos[2] + oz]) {
    // rust: return false;
}
}
}
}
    // rust: for ox in -2i32..=2 {
    // rust: for oy in -2i32..=2 {
    // rust: for oz in -2i32..=2 {
    // rust: let (ax, ay, az) = (ox.abs(), oy.abs(), oz.abs());
    // rust: if (ax > 1 || ay > 1 || az > 1)
    // rust: && (ox == 0 && (ay == 2 || az == 2)
    // rust: || oy == 0 && (ax == 2 || az == 2)
    // rust: || oz == 0 && (ax == 2 || ay == 2))
    // rust: {
    // rust: let p = [pos[0] + ox, pos[1] + oy, pos[2] + oz];
    // rust: if is_frame(p) {
    // rust: self.effect_blocks.push(p);
}
}
}
}
}
    // rust: self.effect_blocks.len() >= 16
}
    /// `ConduitBlockEntity.clientTick`: returns the nautilus particles of
    /// `animationTick`, drawn from the client level's random.
    // rust: pub fn client_tick(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: game_time: i64,
    // rust: is_water: impl Fn([i32; 3]) -> bool,
    // rust: is_frame: impl Fn([i32; 3]) -> bool,
    // rust: target: Option<ConduitTarget>,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Vec<Particle> {
    // rust: self.tick_count += 1;
    // rust: if game_time % 40 == 0 {
    // rust: self.is_active = self.update_shape(pos, &is_water, &is_frame);
    // rust: self.is_hunting = self.effect_blocks.len() >= 42;
}
    // rust: let particles = self.animation_tick(pos, target, random);
    // rust: if self.is_active {
    // rust: self.active_rotation += 1.0;
}
    // rust: particles
}
    // rust: fn animation_tick(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: target: Option<ConduitTarget>,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Vec<Particle> {
    // rust: let mut out = Vec::new();
    // rust: let hh = f64::from(((self.tick_count + 35) as f32 * 0.1).msin() / 2.0 + 0.5);
    // rust: let hh = (hh * hh + hh) * f64::from(0.3f32);
    // rust: let end = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 1.5 + hh,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: for p in &self.effect_blocks {
    // rust: if random.next_int_bound(50).unwrap_or(1) == 0 {
    // rust: let dx = -0.5 + random.next_float() + (p[0] - pos[0]) as f32;
    // rust: let dy = -2.0 + random.next_float() + (p[1] - pos[1]) as f32;
    // rust: let dz = -0.5 + random.next_float() + (p[2] - pos[2]) as f32;
    // rust: out.push((end, [f64::from(dx), f64::from(dy), f64::from(dz)]));
}
}
    // rust: if let Some(t) = target {
    // rust: let randx = (-0.5 + random.next_float()) * (3.0 + t.width);
    // rust: let randy = -1.0 + random.next_float() * t.height;
    // rust: let randz = (-0.5 + random.next_float()) * (3.0 + t.width);
    // rust: out.push((
    // rust: [t.position[0], t.eye_y, t.position[2]],
    // rust: [f64::from(randx), f64::from(randy), f64::from(randz)],
    // rust: ));
}
    // rust: out
}
}

/// What `ConduitBlockEntity.serverTick`'s 40-tick check decided.
pub const ConduitCheck = struct {
    /// The shape changed: `CONDUIT_ACTIVATE` (true) or `CONDUIT_DEACTIVATE`.
    toggled: ?bool,
    /// The frame blocks counted, while the conduit is active: `applyEffects`
    /// and `updateAndAttackTarget` follow (the attack needs 42 or more).
    frames: ?usize,
};

/// `ConduitBlockEntity` (server side): what `serverTick` keeps between ticks.
pub const ConduitServer = struct {
    shape: Conduit,
    /// `destroyTarget`: the mob id of the enemy being struck.
    target: ?u32,
    next_ambient_sound: i64,
};

    // rust: impl ConduitServer {
    /// The `gameTime % 40` part of `serverTick`: the shape is checked again.
    // rust: pub fn check(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: game_time: i64,
    // rust: is_water: impl Fn([i32; 3]) -> bool,
    // rust: is_frame: impl Fn([i32; 3]) -> bool,
    // rust: ) -> Option<ConduitCheck> {
    // rust: if game_time % 40 != 0 {
    // rust: return None;
}
    // rust: let active = self.shape.update_shape(pos, &is_water, &is_frame);
    // rust: let toggled = (active != self.shape.is_active).then_some(active);
    // rust: self.shape.is_active = active;
    // rust: Some(ConduitCheck {
    // rust: toggled,
    // rust: frames: active.then_some(self.shape.effect_blocks.len()),
    // rust: })
}
    /// The sounds of an active conduit at the end of `serverTick`: whether
    /// `CONDUIT_AMBIENT` (every 80 ticks) and `CONDUIT_AMBIENT_SHORT` (every
    /// 60 to 99 ticks) play.
pub fn ambient(self: *Self, game_time: i64, random: *mut impl RandomSource) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.shape.is_active {
    // rust: return (false, false);
}
    // rust: let short = game_time > self.next_ambient_sound;
    // rust: if short {
    // rust: self.next_ambient_sound =
    // rust: game_time + 60 + i64::from(random.next_int_bound(40).unwrap_or(0));
}
    // rust: (game_time % 80 == 0, short)
}
}

/// `SkullBlockEntity` animation (client ticker of dragon and piglin heads).
pub const Skull = struct {
    animating: bool,
    tick_count: i32,
};
    // rust: impl Skull {
    /// `SkullBlockEntity.animation`.
pub fn tick(self: *Self, powered: bool) void {
}
    // rust: if powered {
    // rust: self.animating = true;
    // rust: self.tick_count += 1;
    // rust: } else {
    // rust: self.animating = false;
}
}
}

/// `DecoratedPotBlockEntity.WobbleStyle`.
pub const WobbleStyle = enum {
    Positive,
    Negative,
};
    // rust: impl WobbleStyle {
pub fn duration(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Positive => 7,
    // rust: Self::Negative => 10,
}
}
}

/// `DecoratedPotBlockEntity` wobble fields.
pub const PotWobble = struct {
    started_at: i64,
    style: ?WobbleStyle,
};
    // rust: impl PotWobble {
    /// `triggerEvent(1, style)`.
pub fn trigger_event(self: *Self, event: i32, data: i32, game_time: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if event == 1 && (0..2).contains(&data) {
    // rust: self.started_at = game_time;
    // rust: self.style = Some(if data == 0 {
    // rust: WobbleStyle::Positive
    // rust: } else {
    // rust: WobbleStyle::Negative
    // rust: });
    // rust: true
    // rust: } else {
    // rust: false
}
}
    /// `DecoratedPotRenderer.extractRenderState`'s `wobbleProgress`.
pub fn progress(self: *Self, game_time: i64, partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.style {
    // rust: Some(style) => {
    // rust: ((game_time - self.started_at) as f32 + partial) / style.duration() as f32
}
    // rust: None => 0.0,
}
}
}

/// `TheEndGatewayBlockEntity` fields the beam reads.
pub const EndGateway = struct {
    age: i64,
    teleport_cooldown: i32,
};
    // rust: impl EndGateway {
    /// `beamAnimationTick` (the client ticker).
pub fn tick(self: *Self) void {
}
    // rust: self.age = self.age.wrapping_add(1);
    // rust: if self.teleport_cooldown > 0 {
    // rust: self.teleport_cooldown -= 1;
}
}
    /// `portalTick` on the server copy: whether it called `triggerCooldown`,
    /// whose block event 1 reaches the client copy.
pub fn portal_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cooling = self.teleport_cooldown > 0;
    // rust: self.age = self.age.wrapping_add(1);
    // rust: if cooling {
    // rust: self.teleport_cooldown -= 1;
    // rust: false
    // rust: } else if self.age % 2400 == 0 {
    // rust: self.teleport_cooldown = 40;
    // rust: true
    // rust: } else {
    // rust: false
}
}
    /// `EndGatewayBlock.entityInside` on the server copy: an entity that can
    /// use the portal starts the cooldown unless it is already running.
pub fn enter(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.teleport_cooldown > 0 {
    // rust: return false;
}
    // rust: self.teleport_cooldown = 40;
    // rust: true
}
    /// `triggerEvent`: event 1 starts the 40 tick cooldown.
pub fn trigger_event(self: *Self, event: i32, _data: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if event == 1 {
    // rust: self.teleport_cooldown = 40;
    // rust: true
    // rust: } else {
    // rust: false
}
}
}

/// The client ticker a block entity runs (`getTicker` on a client level),
/// or [`Ticker::Pot`] for decorated pots, which keep wobble state unticked.
pub const Ticker = enum {
    /// `ChestBlockEntity` / `EnderChestBlockEntity.lidAnimateTick`.
    Lid,
    /// `EnchantingTableBlockEntity.bookAnimationTick`.
    Book,
    /// `ShulkerBoxBlockEntity.tick`, with the box's facing.
    Shulker {,
    facing: u8,
    // rust: },
    /// `BellBlockEntity.clientTick`.
    Bell,
    /// `ConduitBlockEntity.clientTick`.
    Conduit,
    /// `SkullBlockEntity.animation` (dragon and piglin heads only).
    Skull {,
    powered: bool,
    // rust: },
    Pot,
    /// `TheEndGatewayBlockEntity.beamAnimationTick`.
    Gateway,
};

/// The [`Ticker`] of a block state, by block name and property lookup.
pub fn ticker(name: []const u8, prop: impl Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: let unwaxed = name.strip_prefix("waxed_").unwrap_or(name);
    // rust: Some(match unwaxed {
    // rust: "chest"
    // rust: | "trapped_chest"
    // rust: | "ender_chest"
    // rust: | "copper_chest"
    // rust: | "exposed_copper_chest"
    // rust: | "weathered_copper_chest"
    // rust: | "oxidized_copper_chest" => Ticker::Lid,
    // rust: "enchanting_table" => Ticker::Book,
    // rust: "bell" => Ticker::Bell,
    // rust: "conduit" => Ticker::Conduit,
    // rust: "decorated_pot" => Ticker::Pot,
    // rust: "end_gateway" => Ticker::Gateway,
    // rust: "dragon_head" | "dragon_wall_head" | "piglin_head" | "piglin_wall_head" => Ticker::Skull {
    // rust: powered: prop("powered").as_deref() == Some("true"),
    // rust: },
    // rust: n if n.ends_with("shulker_box") => Ticker::Shulker {
    // rust: facing: prop("facing")
    // rust: .as_deref()
    // rust: .and_then(direction_index)
    // rust: .unwrap_or(1),
    // rust: },
    // rust: _ => return None,
    // rust: })
}

/// The animated block entities of a level, by position.
pub const BlockEntityAnims = struct {
    chests: FxHashMap<[i32,
    books: FxHashMap<[i32,
    /// `EnchantingTableBlockEntity.RANDOM`, shared by every table.
    book_random: LegacyRandom,
    shulkers: FxHashMap<[i32,
    bells: FxHashMap<[i32,
    conduits: FxHashMap<[i32,
    skulls: FxHashMap<[i32,
    pots: FxHashMap<[i32,
    gateways: FxHashMap<[i32,
    /// The integrated server's copies of the gateways (`portalTick`).
    gateway_servers: FxHashMap<[i32,
    /// The integrated server's copies of the conduits (`serverTick`).
    conduit_servers: FxHashMap<[i32,
    /// The client level's random (conduit particles).
    random: LegacyRandom,
    /// [`Ticker`] by block state id (see [`BlockEntityAnims::classify`]).
    kinds: std.ArrayList(?Ticker),
    /// The drawn block entities with a ticker, sorted by position, and the
    /// renderer's block entity revision they were read at.
    present: Vec<([i32,
    present_revision: ?u64,
};
    // rust: impl Default for BlockEntityAnims {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: chests: FxHashMap::default(),
    // rust: books: FxHashMap::default(),
    // rust: book_random: LegacyRandom::new(0x626f6f6b),
    // rust: shulkers: FxHashMap::default(),
    // rust: bells: FxHashMap::default(),
    // rust: conduits: FxHashMap::default(),
    // rust: skulls: FxHashMap::default(),
    // rust: pots: FxHashMap::default(),
    // rust: gateways: FxHashMap::default(),
    // rust: gateway_servers: FxHashMap::default(),
    // rust: conduit_servers: FxHashMap::default(),
    // rust: random: LegacyRandom::new(0x6c6576656c),
    // rust: kinds: Vec::new(),
    // rust: present: Vec::new(),
    // rust: present_revision: None,
}
}
}
    // rust: impl BlockEntityAnims {
    /// Fills [`Self::kinds`] for every state of the registry.
pub fn classify(self: *Self, registry: *horizon_world::registry::BlockRegistry) void {
}
    // rust: self.kinds = (0..registry.len() as u32)
    // rust: .map(|id| {
    // rust: registry
    // rust: .state(horizon_world::registry::BlockStateId(id))
    // rust: .and_then(|s| ticker(&s.name, |k| s.properties.get(k).cloned()))
    // rust: })
    // rust: .collect();
    // rust: self.present_revision = None;
}
    /// The ticker of a block state.
pub fn ticker(self: *Self, state: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.kinds.get(state as usize).copied().flatten()
}
    /// Drops the state of block entities that are gone or changed kind:
    /// `present` holds the loaded block entities' tickers, sorted by position.
pub fn retain_present(self: *Self, present: *[([i32; 3]) void {
}
    // rust: self.retain_animations(present, false);
}
    /// An integrated server owns bell state independently of renderer visibility.
    /// Its world ticker removes bells when their actual block changes.
pub fn retain_present_preserving_bells(self: *Self, present: *[([i32; 3]) void {
}
    // rust: self.retain_animations(present, true);
}
pub fn retain_animations(self: *Self, present: *[([i32; 3]) void {
}
    // rust: let is = |p: &[i32; 3], f: fn(&Ticker) -> bool| {
    // rust: present
    // rust: .binary_search_by_key(p, |(q, _)| *q)
    // rust: .is_ok_and(|i| f(&present[i].1))
}
    // rust: self.chests.retain(|p, _| is(p, |t| *t == Ticker::Lid));
    // rust: self.books.retain(|p, _| is(p, |t| *t == Ticker::Book));
    // rust: self.shulkers
    // rust: .retain(|p, _| is(p, |t| matches!(t, Ticker::Shulker { .. })));
    // rust: if !keep_bells {
    // rust: self.bells.retain(|p, _| is(p, |t| *t == Ticker::Bell));
}
    // rust: self.conduits
    // rust: .retain(|p, _| is(p, |t| *t == Ticker::Conduit));
    // rust: self.skulls
    // rust: .retain(|p, _| is(p, |t| matches!(t, Ticker::Skull { .. })));
    // rust: self.pots.retain(|p, _| is(p, |t| *t == Ticker::Pot));
    // rust: self.gateways
    // rust: .retain(|p, _| is(p, |t| *t == Ticker::Gateway));
}
    /// Drops the state of positions whose block entity is gone.
pub fn retain(self: *Self, keep: impl Fn([i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chests.retain(|p, _| keep(*p));
    // rust: self.books.retain(|p, _| keep(*p));
    // rust: self.shulkers.retain(|p, _| keep(*p));
    // rust: self.bells.retain(|p, _| keep(*p));
    // rust: self.conduits.retain(|p, _| keep(*p));
    // rust: self.skulls.retain(|p, _| keep(*p));
    // rust: self.pots.retain(|p, _| keep(*p));
    // rust: self.gateways.retain(|p, _| keep(*p));
    // rust: self.gateway_servers.retain(|p, _| keep(*p));
    // rust: self.conduit_servers.retain(|p, _| keep(*p));
}
    /// `getOpenNess(partial)` of the chest or ender chest at `pos`.
pub fn lid(self: *Self, pos: [i32; 3], partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chests
    // rust: .get(&pos)
    // rust: .map_or(0.0, |l| l.get_openness(partial))
}
    /// The renderer's view of the block entity at `pos`; `sherds` are the
    /// pot's decorations (back, left, right, front), when it is a pot.
    // rust: pub fn block_anim(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: game_time: i64,
    // rust: partial: f32,
    // rust: sherds: [Option<String>; 4],
    // rust: ) -> BlockAnim {
    // rust: let mut anim = BlockAnim {
    // rust: sherds,
            // Gateways not ticked yet render settled (no beam).
    // rust: gateway: self
    // rust: .gateways
    // rust: .get(&pos)
    // rust: .map_or((i64::MAX, 0), |g| (g.age, g.teleport_cooldown)),
    // rust: ..BlockAnim::default()
}
    // rust: if let Some(b) = self.books.get(&pos) {
    // rust: anim.book = *b;
}
    // rust: if let Some(s) = self.shulkers.get(&pos) {
    // rust: anim.shulker = (s.progress, s.progress_old);
}
    // rust: if let Some(b) = self.bells.get(&pos) {
    // rust: anim.bell_ticks = b.ticks;
    // rust: anim.bell_shake = b
    // rust: .shaking
    // rust: .then_some(b.click_direction)
    // rust: .flatten()
    // rust: .map(|d| DIRECTIONS[usize::from(d)]);
}
    // rust: if let Some(c) = self.conduits.get(&pos) {
    // rust: anim.conduit = (c.tick_count, c.is_active, c.is_hunting, c.active_rotation);
}
    // rust: if let Some(s) = self.skulls.get(&pos) {
    // rust: anim.skull = (s.animating, s.tick_count);
}
    // rust: if let Some(w) = self.pots.get(&pos)
    // rust: && w.style.is_some()
    // rust: {
            // extractRenderState never copies lastWobbleStyle into the render
            // state, so DecoratedPotRenderer.submit always takes the
            // non-POSITIVE branch (with the style's own duration).
    // rust: anim.wobble = Some((false, w.progress(game_time, partial)));
}
    // rust: anim
}
}
