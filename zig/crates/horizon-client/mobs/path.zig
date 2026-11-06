//! Transpiled from Horizon Rust crate
//! Module: horizon-client_path
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla's A* pathfinder (`PathFinder`, `BinaryHeap`, `Node`, `Path`) with
//! the walking, swimming, flying and amphibious node evaluators
//! (`WalkNodeEvaluator`, `SwimNodeEvaluator`, `FlyNodeEvaluator`,
//! `AmphibiousNodeEvaluator`), ported rule for rule.
// use super::{MobWorld, data};
// use crate::blocks::Fluid;
// use crate::fast_hash::FxHashMap;
// use horizon_core::geometry::{Aabb, Vec3};

pub const PathType = enum {
    Blocked,
    Open,
    Walkable,
    WalkableDoor,
    Trapdoor,
    PowderSnow,
    OnTopOfPowderSnow,
    Fence,
    Lava,
    Water,
    WaterBorder,
    Rail,
    UnpassableRail,
    FireInNeighbor,
    Fire,
    DamagingInNeighbor,
    Damaging,
    DoorOpen,
    DoorWoodClosed,
    DoorIronClosed,
    Breach,
    Leaves,
    StickyHoney,
    Cocoa,
    DamageCautious,
    OnTopOfTrapdoor,
    BigMobsCloseToDanger,
};
pub const PATH_TYPES: usize = 27;
    // rust: impl PathType {
pub fn from_name(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "OPEN" => Self::Open,
    // rust: "WALKABLE" => Self::Walkable,
    // rust: "WALKABLE_DOOR" => Self::WalkableDoor,
    // rust: "TRAPDOOR" => Self::Trapdoor,
    // rust: "POWDER_SNOW" => Self::PowderSnow,
    // rust: "ON_TOP_OF_POWDER_SNOW" => Self::OnTopOfPowderSnow,
    // rust: "FENCE" => Self::Fence,
    // rust: "LAVA" => Self::Lava,
    // rust: "WATER" => Self::Water,
    // rust: "WATER_BORDER" => Self::WaterBorder,
    // rust: "RAIL" => Self::Rail,
    // rust: "UNPASSABLE_RAIL" => Self::UnpassableRail,
    // rust: "FIRE_IN_NEIGHBOR" => Self::FireInNeighbor,
    // rust: "FIRE" => Self::Fire,
    // rust: "DAMAGING_IN_NEIGHBOR" => Self::DamagingInNeighbor,
    // rust: "DAMAGING" => Self::Damaging,
    // rust: "DOOR_OPEN" => Self::DoorOpen,
    // rust: "DOOR_WOOD_CLOSED" => Self::DoorWoodClosed,
    // rust: "DOOR_IRON_CLOSED" => Self::DoorIronClosed,
    // rust: "BREACH" => Self::Breach,
    // rust: "LEAVES" => Self::Leaves,
    // rust: "STICKY_HONEY" => Self::StickyHoney,
    // rust: "COCOA" => Self::Cocoa,
    // rust: "DAMAGE_CAUTIOUS" => Self::DamageCautious,
    // rust: "ON_TOP_OF_TRAPDOOR" => Self::OnTopOfTrapdoor,
    // rust: "BIG_MOBS_CLOSE_TO_DANGER" => Self::BigMobsCloseToDanger,
    // rust: _ => Self::Blocked,
}
}
    /// PathType's default malus.
pub fn malus(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Blocked | Self::PowderSnow | Self::Fence | Self::Lava | Self::UnpassableRail => {
    // rust: -1.0
}
    // rust: Self::Damaging | Self::DoorWoodClosed | Self::DoorIronClosed | Self::Leaves => -1.0,
    // rust: Self::Water
    // rust: | Self::WaterBorder
    // rust: | Self::FireInNeighbor
    // rust: | Self::DamagingInNeighbor
    // rust: | Self::StickyHoney => 8.0,
    // rust: Self::Fire => 16.0,
    // rust: Self::Breach | Self::BigMobsCloseToDanger => 4.0,
    // rust: _ => 0.0,
}
}
}

    // rust: impl MobWorld<'_> {
pub fn path_type_from_state(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data.state(self.world.block(x, y, z)).path
}
    /// WalkNodeEvaluator.getPathTypeStatic.
pub fn path_type_static(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = self.path_type_from_state(x, y, z);
    // rust: if t == PathType::Open && y > self.world.bottom_y() {
    // rust: match self.path_type_from_state(x, y - 1, z) {
    // rust: PathType::Open | PathType::Water | PathType::Lava | PathType::Walkable => {
    // rust: PathType::Open
}
    // rust: PathType::Fire => PathType::Fire,
    // rust: PathType::Damaging => PathType::Damaging,
    // rust: PathType::StickyHoney => PathType::StickyHoney,
    // rust: PathType::PowderSnow => PathType::OnTopOfPowderSnow,
    // rust: PathType::DamageCautious => PathType::DamageCautious,
    // rust: PathType::Trapdoor => PathType::OnTopOfTrapdoor,
    // rust: _ => self.check_neighbours(x, y, z, PathType::Walkable),
}
    // rust: } else {
    // rust: t
}
}
    /// WalkNodeEvaluator.checkNeighbourBlocks.
pub fn check_neighbours(self: *Self, x: i32, y: i32, z: i32, t: PathType) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for dx in -1..=1 {
    // rust: for dy in -1..=1 {
    // rust: for dz in -1..=1 {
    // rust: if dx != 0 || dz != 0 {
    // rust: match self.path_type_from_state(x + dx, y + dy, z + dz) {
    // rust: PathType::Damaging => return PathType::DamagingInNeighbor,
    // rust: PathType::Fire | PathType::Lava => return PathType::FireInNeighbor,
    // rust: PathType::Water => return PathType::WaterBorder,
    // rust: PathType::DamageCautious => return PathType::DamageCautious,
    // rust: _ => {}
}
}
}
}
}
    // rust: t
}
    /// WalkNodeEvaluator.getFloorLevel(level, pos).
pub fn floor_level(self: *Self, x: i32, y: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from(y - 1) + f64::from(self.data.state(self.world.block(x, y - 1, z)).top)
}
}

/// The parts of a mob the node evaluators read (`Mob` accessors at prepare time).
pub const PathMob = struct {
    position: Vec3,
    width: f32,
    height: f32,
    on_ground: bool,
    in_water: bool,
    max_up_step: f32,
    max_fall_distance: i32,
    malus: [?f32,
    can_float: bool,
    can_open_doors: bool,
    can_pass_doors: bool,
    can_walk_over_fences: bool,
    /// Striders stand on lava (`canStandOnFluid`).
    stands_on_lava: bool,
};
    // rust: impl PathMob {
pub fn malus(self: *Self, t: PathType) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.malus[t as usize].unwrap_or_else(|| t.malus())
}
pub fn bounds(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let w = f64::from(self.width) / 2.0;
    // rust: Aabb::new(
    // rust: Vec3::new(self.position.x - w, self.position.y, self.position.z - w),
    // rust: Vec3::new(
    // rust: self.position.x + w,
    // rust: self.position.y + f64::from(self.height),
    // rust: self.position.z + w,
    // rust: ),
    // rust: )
}
pub fn block_position(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: self.position.x.floor() as i32,
    // rust: self.position.y.floor() as i32,
    // rust: self.position.z.floor() as i32,
    // rust: ]
}
}

pub const Evaluator = enum {
    Walk,
    Swim { breach: bool },
    Fly,
    Amphibious { prefers_shallow: bool },
};

pub const Node = struct {
    x: i32,
    y: i32,
    z: i32,
    heap: i32,
    g: f32,
    h: f32,
    f: f32,
    came_from: ?u32,
    closed: bool,
    walked: f32,
    cost_malus: f32,
    kind: PathType,
};
    // rust: impl Node {
pub fn new(x: i32, y: i32, z: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: x,
    // rust: y,
    // rust: z,
    // rust: heap: -1,
    // rust: g: 0.0,
    // rust: h: 0.0,
    // rust: f: 0.0,
    // rust: came_from: None,
    // rust: closed: false,
    // rust: walked: 0.0,
    // rust: cost_malus: 0.0,
    // rust: kind: PathType::Blocked,
}
}
pub fn distance(self: *Self, x: i32, y: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (dx, dy, dz) = (
    // rust: (x - self.x) as f32,
    // rust: (y - self.y) as f32,
    // rust: (z - self.z) as f32,
    // rust: );
    // rust: (dx * dx + dy * dy + dz * dz).sqrt()
}
pub fn manhattan(self: *Self, x: i32, y: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((x - self.x).abs() + (y - self.y).abs() + (z - self.z).abs()) as f32
}
}

/// A computed path: node positions, the requested target and whether it was reached.
pub const Path = struct {
    nodes: std.ArrayList(PathNode),
    next: usize,
    target: [i32,
    dist_to_target: f32,
    reached: bool,
};
pub const PathNode = struct {
    x: i32,
    y: i32,
    z: i32,
    kind: PathType,
};
    // rust: impl Path {
pub fn new(nodes: std.ArrayList(PathNode), target: [i32; 3], reached: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dist_to_target = nodes.last().map_or(f32::MAX, |n| {
    // rust: ((n.x - target[0]).abs() + (n.y - target[1]).abs() + (n.z - target[2]).abs()) as f32
    // rust: });
    // rust: Self {
    // rust: nodes,
    // rust: next: 0,
    // rust: target,
    // rust: dist_to_target,
    // rust: reached,
}
}
pub fn is_done(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next >= self.nodes.len()
}
pub fn advance(self: *Self) void {
}
    // rust: self.next += 1;
}
pub fn end(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.nodes.last().copied()
}
pub fn next_node(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.nodes[self.next]
}
    /// Path.getEntityPosAtNode: node corner plus half the mob's block width.
pub fn entity_pos_at(self: *Self, index: usize, width: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = self.nodes[index];
    // rust: let half = f64::from((width + 1.0) as i32) * 0.5;
    // rust: Vec3::new(f64::from(n.x) + half, f64::from(n.y), f64::from(n.z) + half)
}
pub fn same_as(self: *Self, other: ?*Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: other.is_some_and(|o| o.nodes == self.nodes)
}
    /// `PathNavigation.trimPath`: a node standing on a cauldron
    /// (`BlockTags.CAULDRONS`) is raised onto its rim, and the node after it is
    /// raised to the rim's height too when it is not above the cauldron, so a
    /// route that ends on a cauldron (a leatherworker's job site) aims at the
    /// top face instead of into the block.
pub fn raise_cauldron_nodes(self: *Self, is_cauldron: impl Fn(i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for i in 0..self.nodes.len() {
    // rust: let node = self.nodes[i];
    // rust: if !is_cauldron(node.x, node.y, node.z) {
    // rust: continue;
}
    // rust: self.nodes[i].y = node.y + 1;
    // rust: if let Some(&next) = self.nodes.get(i + 1)
    // rust: && node.y >= next.y
    // rust: {
    // rust: self.nodes[i + 1] = PathNode {
    // rust: y: node.y + 1,
    // rust: ..next
}
}
}
}
}

pub const Target = struct {
    x: i32,
    y: i32,
    z: i32,
    best_h: f32,
    best: ?u32,
    reached: bool,
    pos: [i32,
};

/// One pathfinding query: the node arena, open set and per-query caches.
pub const Finder = struct {
    w: *'a MobWorld<'w>,
    mob: *'a PathMob,
    eval: Evaluator,
    nodes: std.ArrayList(Node),
    index: FxHashMap<(i32,
    heap: std.ArrayList(u32),
    types: FxHashMap<(i32,
    /// `path_type` of each position asked during this query: it reads up to
    /// 26 blocks, and overlapping mob boxes ask for the same positions.
    statics: std::cell::RefCell<FxHashMap<(i32,
    collisions: FxHashMap<[u64,
    entity_width: i32,
    entity_height: i32,
    entity_depth: i32,
};

    // rust: impl<'a, 'w> Finder<'a, 'w> {
pub fn new(w: *'a MobWorld<'w>, mob: *'a PathMob, eval: Evaluator) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: w,
    // rust: mob,
    // rust: eval,
    // rust: nodes: Vec::new(),
    // rust: index: FxHashMap::default(),
    // rust: heap: Vec::new(),
    // rust: types: FxHashMap::default(),
    // rust: statics: Default::default(),
    // rust: collisions: FxHashMap::default(),
    // rust: entity_width: (mob.width + 1.0).floor() as i32,
    // rust: entity_height: (mob.height + 1.0).floor() as i32,
    // rust: entity_depth: (mob.width + 1.0).floor() as i32,
}
}
    /// Mob.getPathfindingMalus; AmphibiousNodeEvaluator.prepare overrides three
    /// maluses for the duration of the query.
pub fn malus(self: *Self, t: PathType) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Evaluator::Amphibious { .. } = self.eval {
    // rust: match t {
    // rust: PathType::Water => return 0.0,
    // rust: PathType::Walkable => return 6.0,
    // rust: PathType::WaterBorder => return 4.0,
    // rust: _ => {}
}
}
    // rust: self.mob.malus(t)
}
    // --- world access -------------------------------------------------
pub fn state(self: *Self, x: i32, y: i32, z: i32) d {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w.data.state(self.w.world.block(x, y, z))
}
pub fn type_from_state(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w.path_type_from_state(x, y, z)
}
pub fn fluid(self: *Self, x: i32, y: i32, z: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w.facts.get(self.w.world.block(x, y, z)).fluid
}
pub fn is_air(self: *Self, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w.facts.is_air(self.w.world.block(x, y, z))
}
    /// WalkNodeEvaluator.getFloorLevel(level, pos).
pub fn static_floor(self: *Self, x: i32, y: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from(y - 1) + f64::from(self.state(x, y - 1, z).top)
}
pub fn floor_level(self: *Self, x: i32, y: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let amphibious = matches!(self.eval, Evaluator::Amphibious { .. });
    // rust: if (self.mob.can_float || amphibious) && self.fluid(x, y, z) == Fluid::Water {
    // rust: f64::from(y) + 0.5
    // rust: } else {
    // rust: self.static_floor(x, y, z)
}
}
pub fn has_collisions(self: *Self, b: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let key = [
    // rust: lo.x.to_bits(),
    // rust: lo.y.to_bits(),
    // rust: lo.z.to_bits(),
    // rust: hi.x.to_bits(),
    // rust: hi.y.to_bits(),
    // rust: hi.z.to_bits(),
    // rust: ];
    // rust: if let Some(v) = self.collisions.get(&key) {
    // rust: return *v;
}
    // rust: let v = !self.w.no_collision(b);
    // rust: self.collisions.insert(key, v);
    // rust: v
}
    // --- path types -----------------------------------------------------
    /// WalkNodeEvaluator.getPathTypeStatic (+ the fly/amphibious overrides).
    /// The world doesn't change during a query, so each position's type is
    /// worked out once.
pub fn path_type(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(t) = self.statics.borrow().get(&(x, y, z)) {
    // rust: return *t;
}
    // rust: let t = self.compute_path_type(x, y, z);
    // rust: self.statics.borrow_mut().insert((x, y, z), t);
    // rust: t
}
pub fn compute_path_type(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.eval {
    // rust: Evaluator::Fly => self.fly_path_type(x, y, z),
    // rust: Evaluator::Amphibious { .. } => {
    // rust: let t = self.type_from_state(x, y, z);
    // rust: if t == PathType::Water {
    // rust: for (dx, dy, dz) in [
    // rust: (0, -1, 0),
    // rust: (0, 1, 0),
    // rust: (0, 0, -1),
    // rust: (0, 0, 1),
    // rust: (-1, 0, 0),
    // rust: (1, 0, 0),
    // rust: ] {
    // rust: if self.type_from_state(x + dx, y + dy, z + dz) == PathType::Blocked {
    // rust: return PathType::WaterBorder;
}
}
    // rust: PathType::Water
    // rust: } else {
    // rust: self.walk_path_type(x, y, z)
}
}
    // rust: _ => self.walk_path_type(x, y, z),
}
}
pub fn walk_path_type(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w.path_type_static(x, y, z)
}
pub fn check_neighbours(self: *Self, x: i32, y: i32, z: i32, t: PathType) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w.check_neighbours(x, y, z, t)
}
pub fn fly_path_type(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut t = self.type_from_state(x, y, z);
    // rust: if t == PathType::Open && y > self.w.world.bottom_y() {
    // rust: let below = self.type_from_state(x, y - 1, z);
    // rust: t = match below {
    // rust: PathType::Fire | PathType::Lava => PathType::Fire,
    // rust: PathType::Damaging => PathType::Damaging,
    // rust: PathType::Cocoa => PathType::Cocoa,
    // rust: PathType::Fence => {
    // rust: if [x, y - 1, z] != self.mob.block_position() {
    // rust: PathType::Fence
    // rust: } else {
    // rust: t
}
}
    // rust: PathType::Walkable | PathType::Open | PathType::Water => PathType::Open,
    // rust: _ => PathType::Walkable,
}
}
    // rust: if t == PathType::Walkable || t == PathType::Open {
    // rust: t = self.check_neighbours(x, y, z, t);
}
    // rust: t
}
pub fn within_bb(self: *Self, x: i32, y: i32, z: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::with_capacity(4);
    // rust: let mp = self.mob.block_position();
    // rust: for dx in 0..self.entity_width {
    // rust: for dy in 0..self.entity_height {
    // rust: for dz in 0..self.entity_depth {
    // rust: let mut t = self.path_type(x + dx, y + dy, z + dz);
    // rust: if t == PathType::DoorWoodClosed
    // rust: && self.mob.can_open_doors
    // rust: && self.mob.can_pass_doors
    // rust: {
    // rust: t = PathType::WalkableDoor;
}
    // rust: if t == PathType::DoorOpen && !self.mob.can_pass_doors {
    // rust: t = PathType::Blocked;
}
    // rust: if t == PathType::Rail
    // rust: && self.path_type(mp[0], mp[1], mp[2]) != PathType::Rail
    // rust: && self.path_type(mp[0], mp[1] - 1, mp[2]) != PathType::Rail
    // rust: {
    // rust: t = PathType::UnpassableRail;
}
    // rust: if !out.contains(&t) {
    // rust: out.push(t);
}
}
}
}
    // rust: out
}
    /// WalkNodeEvaluator.getPathTypeOfMob.
pub fn path_type_of_mob(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Evaluator::Swim { .. } = self.eval {
    // rust: return self.swim_path_type(x, y, z);
}
    // rust: let mut types = self.within_bb(x, y, z);
        // EnumSet iteration follows declaration order.
    // rust: types.sort_by_key(|t| *t as u8);
    // rust: if types.len() == 1 {
    // rust: return types[0];
}
    // rust: if types.contains(&PathType::Fence) {
    // rust: return PathType::Fence;
}
    // rust: if types.contains(&PathType::UnpassableRail) {
    // rust: return PathType::UnpassableRail;
}
    // rust: let mut highest = PathType::Blocked;
    // rust: let mut highest_malus = self.malus(highest);
    // rust: for t in &types {
    // rust: let m = self.malus(*t);
    // rust: if m < 0.0 {
    // rust: return *t;
}
    // rust: if m >= highest_malus {
    // rust: highest_malus = m;
    // rust: highest = *t;
}
}
    // rust: let current = self.path_type(x, y, z);
    // rust: if self.entity_width > 1 {
    // rust: let cheaper = self.malus(current) < highest_malus;
    // rust: if cheaper && self.malus(PathType::BigMobsCloseToDanger) < highest_malus {
    // rust: PathType::BigMobsCloseToDanger
    // rust: } else {
    // rust: highest
}
    // rust: } else if current == PathType::Open && highest != PathType::Open && highest_malus == 0.0 {
    // rust: PathType::Open
    // rust: } else {
    // rust: highest
}
}
pub fn swim_path_type(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut last = (x, y, z);
    // rust: for xx in x..x + self.entity_width {
    // rust: for yy in y..y + self.entity_height {
    // rust: for zz in z..z + self.entity_depth {
    // rust: let fluid = self.fluid(xx, yy, zz);
    // rust: let below = self.state(xx, yy - 1, zz);
    // rust: if fluid == Fluid::None
    // rust: && below.flags & data::WATER != 0
    // rust: && self.is_air(xx, yy, zz)
    // rust: {
    // rust: return PathType::Breach;
}
    // rust: if fluid != Fluid::Water {
    // rust: return PathType::Blocked;
}
    // rust: last = (xx, yy, zz);
}
}
}
    // rust: if self.state(last.0, last.1, last.2).flags & data::WATER != 0 {
    // rust: PathType::Water
    // rust: } else {
    // rust: PathType::Blocked
}
}
pub fn cached(self: *Self, x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(t) = self.types.get(&(x, y, z)) {
    // rust: return *t;
}
    // rust: let t = self.path_type_of_mob(x, y, z);
    // rust: self.types.insert((x, y, z), t);
    // rust: t
}
    // --- node arena -------------------------------------------------------
pub fn node(self: *Self, x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(i) = self.index.get(&(x, y, z)) {
    // rust: return *i;
}
    // rust: let i = self.nodes.len() as u32;
    // rust: self.nodes.push(Node::new(x, y, z));
    // rust: self.index.insert((x, y, z), i);
    // rust: i
}
pub fn start_node(self: *Self, x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = self.node(x, y, z);
    // rust: let t = self.cached(x, y, z);
    // rust: let m = self.malus(t);
    // rust: let node = &mut self.nodes[n as usize];
    // rust: node.kind = t;
    // rust: node.cost_malus = m;
    // rust: n
}
pub fn can_start_at(self: *Self, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = self.cached(x, y, z);
    // rust: if self.eval == Evaluator::Fly {
    // rust: return self.malus(t) >= 0.0;
}
    // rust: t != PathType::Open && self.malus(t) >= 0.0
}
pub fn start(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let m = self.mob.clone();
    // rust: let p = m.position;
    // rust: let b = m.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: match self.eval {
    // rust: Evaluator::Swim { .. } => {
    // rust: return Some(self.node(
    // rust: lo.x.floor() as i32,
    // rust: (lo.y + 0.5).floor() as i32,
    // rust: lo.z.floor() as i32,
    // rust: ));
}
    // rust: Evaluator::Amphibious { .. } if m.in_water => {
    // rust: return Some(self.start_node(
    // rust: lo.x.floor() as i32,
    // rust: (lo.y + 0.5).floor() as i32,
    // rust: lo.z.floor() as i32,
    // rust: ));
}
    // rust: Evaluator::Fly => {
    // rust: let (bx, bz) = (p.x.floor() as i32, p.z.floor() as i32);
    // rust: let mut start_y;
    // rust: if m.can_float && m.in_water {
    // rust: start_y = p.y.floor() as i32;
    // rust: while &*self.w.facts.get(self.w.world.block(bx, start_y, bz)).name
    // rust: == "minecraft:water"
    // rust: {
    // rust: start_y += 1;
}
    // rust: } else {
    // rust: start_y = (p.y + 0.5).floor() as i32;
}
    // rust: if !self.can_start_at(bx, start_y, bz) {
    // rust: let by = p.y.floor() as i32;
    // rust: for (cx, cz) in [(lo.x, lo.z), (lo.x, hi.z), (hi.x, lo.z), (hi.x, hi.z)] {
    // rust: let (cx, cz) = (cx.floor() as i32, cz.floor() as i32);
    // rust: if self.can_start_at(cx, by, cz) {
    // rust: return Some(self.start_node(cx, by, cz));
}
}
}
    // rust: return Some(self.start_node(bx, start_y, bz));
}
    // rust: _ => {}
}
        // WalkNodeEvaluator.getStart
    // rust: let (bx, bz) = (p.x.floor() as i32, p.z.floor() as i32);
    // rust: let mut start_y = p.y.floor() as i32;
    // rust: let fluid_at = |s: &Self, y: i32| s.fluid(bx, y, bz);
    // rust: if !(m.stands_on_lava && fluid_at(self, start_y) == Fluid::Lava) {
    // rust: if m.can_float && fluid_at(self, start_y) == Fluid::Water {
    // rust: while fluid_at(self, start_y) == Fluid::Water {
    // rust: start_y += 1;
}
    // rust: start_y -= 1;
    // rust: } else if m.on_ground {
    // rust: start_y = (p.y + 0.5).floor() as i32;
    // rust: } else {
    // rust: let mut y = (p.y + 1.0).floor() as i32;
    // rust: while y > self.w.world.bottom_y() {
    // rust: start_y = y;
    // rust: y -= 1;
    // rust: let s = self.w.world.block(bx, y, bz);
    // rust: if !self.w.facts.is_air(s) && self.w.data.state(s).flags & data::LAND == 0 {
    // rust: break;
}
}
}
    // rust: } else {
    // rust: while m.stands_on_lava && fluid_at(self, start_y) == Fluid::Lava {
    // rust: start_y += 1;
}
    // rust: start_y -= 1;
}
    // rust: if !self.can_start_at(bx, start_y, bz) {
    // rust: for (cx, cz) in [(lo.x, lo.z), (lo.x, hi.z), (hi.x, lo.z), (hi.x, hi.z)] {
    // rust: let (cx, cz) = (cx.floor() as i32, cz.floor() as i32);
    // rust: if self.can_start_at(cx, start_y, cz) {
    // rust: return Some(self.start_node(cx, start_y, cz));
}
}
}
    // rust: Some(self.start_node(bx, start_y, bz))
}
    // --- walking neighbours ----------------------------------------------
pub fn node_update_max(self: *Self, x: i32, y: i32, z: i32, t: PathType, cost: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = self.node(x, y, z);
    // rust: let node = &mut self.nodes[n as usize];
    // rust: node.kind = t;
    // rust: node.cost_malus = node.cost_malus.max(cost);
    // rust: n
}
pub fn blocked_node(self: *Self, x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = self.node(x, y, z);
    // rust: let node = &mut self.nodes[n as usize];
    // rust: node.kind = PathType::Blocked;
    // rust: node.cost_malus = -1.0;
    // rust: n
}
pub fn closed_node(self: *Self, x: i32, y: i32, z: i32, t: PathType) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = self.node(x, y, z);
    // rust: let node = &mut self.nodes[n as usize];
    // rust: node.closed = true;
    // rust: node.kind = t;
    // rust: node.cost_malus = t.malus();
    // rust: n
}
pub fn jump_height(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from(self.mob.max_up_step).max(1.125)
}
pub fn partial_collision(t: PathType) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: t,
    // rust: PathType::Fence | PathType::DoorWoodClosed | PathType::DoorIronClosed
    // rust: )
}
pub fn can_reach_without_collision(self: *Self, n: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (nx, ny, nz) = {
    // rust: let node = &self.nodes[n as usize];
    // rust: (node.x, node.y, node.z)
}
    // rust: let mut bb = self.mob.bounds();
    // rust: let size = {
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
    // rust: ((hi.x - lo.x) + (hi.y - lo.y) + (hi.z - lo.z)) / 3.0
}
    // rust: let (lo, hi) = (bb.min_position(), bb.max_position());
    // rust: let p = self.mob.position;
    // rust: let mut delta = Vec3::new(
    // rust: f64::from(nx) - p.x + (hi.x - lo.x) / 2.0,
    // rust: f64::from(ny) - p.y + (hi.y - lo.y) / 2.0,
    // rust: f64::from(nz) - p.z + (hi.z - lo.z) / 2.0,
    // rust: );
    // rust: let len = (delta.x * delta.x + delta.y * delta.y + delta.z * delta.z).sqrt();
    // rust: let steps = (len / size).ceil().max(1.0) as i32;
    // rust: delta = Vec3::new(
    // rust: delta.x / f64::from(steps),
    // rust: delta.y / f64::from(steps),
    // rust: delta.z / f64::from(steps),
    // rust: );
    // rust: for _ in 1..=steps {
    // rust: bb = bb.move_by(delta);
    // rust: if self.has_collisions(bb) {
    // rust: return false;
}
}
    // rust: true
}
    // rust: fn find_accepted(
    // rust: &mut self,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: jump: i32,
    // rust: node_height: f64,
    // rust: dir: (i32, i32),
    // rust: current: PathType,
    // rust: ) -> Option<u32> {
    // rust: let amphibious = matches!(self.eval, Evaluator::Amphibious { .. });
    // rust: let max_y_target = self.floor_level(x, y, z);
    // rust: if max_y_target - node_height > self.jump_height() {
    // rust: return None;
}
    // rust: let t = self.cached(x, y, z);
    // rust: let cost = self.malus(t);
    // rust: let mut best = None;
    // rust: if cost >= 0.0 {
    // rust: best = Some(self.node_update_max(x, y, z, t, cost));
}
    // rust: if Self::partial_collision(current)
    // rust: && let Some(b) = best
    // rust: && self.nodes[b as usize].cost_malus >= 0.0
    // rust: && !self.can_reach_without_collision(b)
    // rust: {
    // rust: best = None;
}
    // rust: if t == PathType::Walkable || (amphibious && t == PathType::Water) {
    // rust: return best;
}
    // rust: let best_cost_negative = best.is_none_or(|b| self.nodes[b as usize].cost_malus < 0.0);
    // rust: if best_cost_negative
    // rust: && jump > 0
    // rust: && (t != PathType::Fence || self.mob.can_walk_over_fences)
    // rust: && t != PathType::UnpassableRail
    // rust: && t != PathType::Trapdoor
    // rust: && t != PathType::PowderSnow
    // rust: {
    // rust: best = self.try_jump_on(x, y, z, jump, node_height, dir, current);
    // rust: } else if !amphibious && t == PathType::Water && !self.mob.can_float {
    // rust: best = self.first_non_water_below(x, y, z, best);
    // rust: } else if t == PathType::Open {
    // rust: best = Some(self.first_ground_below(x, y, z));
    // rust: } else if Self::partial_collision(t) && best.is_none() {
    // rust: best = Some(self.closed_node(x, y, z, t));
}
    // rust: best
}
    // rust: fn try_jump_on(
    // rust: &mut self,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: jump: i32,
    // rust: node_height: f64,
    // rust: dir: (i32, i32),
    // rust: current: PathType,
    // rust: ) -> Option<u32> {
    // rust: let above = self.find_accepted(x, y + 1, z, jump - 1, node_height, dir, current)?;
    // rust: if self.mob.width >= 1.0 {
    // rust: return Some(above);
}
    // rust: let (ak, ax, ay, az) = {
    // rust: let n = &self.nodes[above as usize];
    // rust: (n.kind, n.x, n.y, n.z)
}
    // rust: if ak != PathType::Open && ak != PathType::Walkable {
    // rust: return Some(above);
}
    // rust: let cx = f64::from(x - dir.0) + 0.5;
    // rust: let cz = f64::from(z - dir.1) + 0.5;
    // rust: let half = f64::from(self.mob.width) / 2.0;
    // rust: let grow = Aabb::new(
    // rust: Vec3::new(
    // rust: cx - half,
    // rust: self.floor_level(cx.floor() as i32, y + 1, cz.floor() as i32) + 0.001,
    // rust: cz - half,
    // rust: ),
    // rust: Vec3::new(
    // rust: cx + half,
    // rust: f64::from(self.mob.height) + self.floor_level(ax, ay, az) - 0.002,
    // rust: cz + half,
    // rust: ),
    // rust: );
    // rust: if self.has_collisions(grow) {
    // rust: None
    // rust: } else {
    // rust: Some(above)
}
}
    // rust: fn first_non_water_below(
    // rust: &mut self,
    // rust: x: i32,
    // rust: mut y: i32,
    // rust: z: i32,
    // rust: mut best: Option<u32>,
    // rust: ) -> Option<u32> {
    // rust: y -= 1;
    // rust: while y > self.w.world.bottom_y() {
    // rust: let t = self.cached(x, y, z);
    // rust: if t != PathType::Water {
    // rust: return best;
}
    // rust: let m = self.malus(t);
    // rust: best = Some(self.node_update_max(x, y, z, t, m));
    // rust: y -= 1;
}
    // rust: best
}
pub fn first_ground_below(self: *Self, x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut cy = y - 1;
    // rust: while cy >= self.w.world.bottom_y() {
    // rust: if y - cy > self.mob.max_fall_distance {
    // rust: return self.blocked_node(x, cy, z);
}
    // rust: let t = self.cached(x, cy, z);
    // rust: let cost = self.malus(t);
    // rust: if t != PathType::Open {
    // rust: if cost >= 0.0 {
    // rust: return self.node_update_max(x, cy, z, t, cost);
}
    // rust: return self.blocked_node(x, cy, z);
}
    // rust: cy -= 1;
}
    // rust: self.blocked_node(x, y, z)
}
pub fn neighbor_valid(self: *Self, n: ?u32, current: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: n.is_some_and(|n| {
    // rust: let node = &self.nodes[n as usize];
    // rust: !node.closed
    // rust: && (node.cost_malus >= 0.0 || self.nodes[current as usize].cost_malus < 0.0)
    // rust: })
}
pub fn diagonal_pair_valid(self: *Self, pos: u32, ew: ?u32, ns: ?u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (Some(ew), Some(ns)) = (ew, ns) else {
    // rust: return false;
}
    // rust: let (p, e, n) = (
    // rust: &self.nodes[pos as usize],
    // rust: &self.nodes[ew as usize],
    // rust: &self.nodes[ns as usize],
    // rust: );
    // rust: if n.y > p.y || e.y > p.y {
    // rust: return false;
}
    // rust: if e.kind == PathType::WalkableDoor || n.kind == PathType::WalkableDoor {
    // rust: return false;
}
    // rust: if self.mob.width > 1.0 && (e.cost_malus > 0.0 || n.cost_malus > 0.0) {
    // rust: return false;
}
    // rust: let between_posts = n.kind == PathType::Fence
    // rust: && e.kind == PathType::Fence
    // rust: && f64::from(self.mob.width) < 0.5;
    // rust: (n.y < p.y || n.cost_malus >= 0.0 || between_posts)
    // rust: && (e.y < p.y || e.cost_malus >= 0.0 || between_posts)
}
pub fn diagonal_valid(self: *Self, d: ?u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: d.is_some_and(|d| {
    // rust: let n = &self.nodes[d as usize];
    // rust: !n.closed && n.kind != PathType::WalkableDoor && n.cost_malus >= 0.0
    // rust: })
}
pub fn walk_neighbors(self: *Self, pos: u32, out: *mut std.ArrayList(u32)) void {
}
    // rust: let (px, py, pz) = {
    // rust: let n = &self.nodes[pos as usize];
    // rust: (n.x, n.y, n.z)
}
    // rust: let above = self.cached(px, py + 1, pz);
    // rust: let current = self.cached(px, py, pz);
    // rust: let mut jump = 0;
    // rust: if self.malus(above) >= 0.0 && current != PathType::StickyHoney {
    // rust: jump = self.mob.max_up_step.max(1.0).floor() as i32;
}
    // rust: let height = self.floor_level(px, py, pz);
        // Direction.Plane.HORIZONTAL: north, east, south, west; 2D index S=0 W=1 N=2 E=3.
pub const DIRS: [(i32, i32, usize); 4] = [(0, -1, 2), (1, 0, 3), (0, 1, 0), (-1, 0, 1)];
    // rust: let mut by2d: [Option<u32>; 4] = [None; 4];
    // rust: for (dx, dz, i2) in DIRS {
    // rust: let n = self.find_accepted(px + dx, py, pz + dz, jump, height, (dx, dz), current);
    // rust: by2d[i2] = n;
    // rust: if self.neighbor_valid(n, pos) {
    // rust: out.push(n.unwrap_or_default());
}
}
        // Clockwise of north is east, of east south, of south west, of west north.
    // rust: let clockwise = |i2: usize| match i2 {
    // rust: 2 => 3,
    // rust: 3 => 0,
    // rust: 0 => 1,
    // rust: _ => 2,
}
    // rust: for (dx, dz, i2) in DIRS {
    // rust: let c = clockwise(i2);
    // rust: let (cdx, cdz) = match c {
    // rust: 0 => (0, 1),
    // rust: 1 => (-1, 0),
    // rust: 2 => (0, -1),
    // rust: _ => (1, 0),
}
    // rust: if self.diagonal_pair_valid(pos, by2d[i2], by2d[c]) {
    // rust: let d = self.find_accepted(
    // rust: px + dx + cdx,
    // rust: py,
    // rust: pz + dz + cdz,
    // rust: jump,
    // rust: height,
    // rust: (dx, dz),
    // rust: current,
    // rust: );
    // rust: if self.diagonal_valid(d) {
    // rust: out.push(d.unwrap_or_default());
}
}
}
    // rust: if let Evaluator::Amphibious { prefers_shallow } = self.eval {
    // rust: let up = self.find_accepted(px, py + 1, pz, (jump - 1).max(0), height, (0, 0), current);
    // rust: let down = self.find_accepted(px, py - 1, pz, jump, height, (0, 0), current);
    // rust: if self.neighbor_valid(up, pos)
    // rust: && up.is_some_and(|u| self.nodes[u as usize].kind == PathType::Water)
    // rust: {
    // rust: out.push(up.unwrap_or_default());
}
    // rust: if self.neighbor_valid(down, pos)
    // rust: && down.is_some_and(|d| self.nodes[d as usize].kind == PathType::Water)
    // rust: && current != PathType::Trapdoor
    // rust: {
    // rust: out.push(down.unwrap_or_default());
}
    // rust: if prefers_shallow {
    // rust: for &n in out.iter() {
    // rust: let node = &mut self.nodes[n as usize];
    // rust: if node.kind == PathType::Water && node.y < 63 - 10 {
    // rust: node.cost_malus += 1.0;
}
}
}
}
}
    // --- swimming / flying neighbours ------------------------------------
pub fn swim_accepted(self: *Self, x: i32, y: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let breach = matches!(self.eval, Evaluator::Swim { breach: true });
    // rust: let t = self.cached(x, y, z);
    // rust: if (breach && t == PathType::Breach) || t == PathType::Water {
    // rust: let cost = self.malus(t);
    // rust: if cost >= 0.0 {
    // rust: let n = self.node_update_max(x, y, z, t, cost);
    // rust: if self.fluid(x, y, z) == Fluid::None {
    // rust: self.nodes[n as usize].cost_malus += 8.0;
}
    // rust: return Some(n);
}
}
    // rust: None
}
pub fn swim_neighbors(self: *Self, pos: u32, out: *mut std.ArrayList(u32)) void {
}
    // rust: let (px, py, pz) = {
    // rust: let n = &self.nodes[pos as usize];
    // rust: (n.x, n.y, n.z)
}
    // rust: let open = |s: &Self, n: Option<u32>| n.is_some_and(|n| !s.nodes[n as usize].closed);
    // rust: let malus =
    // rust: |s: &Self, n: Option<u32>| n.is_some_and(|n| s.nodes[n as usize].cost_malus >= 0.0);
        // Direction.values(): down, up, north, south, west, east.
    // rust: let dirs = [
    // rust: (0, -1, 0),
    // rust: (0, 1, 0),
    // rust: (0, 0, -1),
    // rust: (0, 0, 1),
    // rust: (-1, 0, 0),
    // rust: (1, 0, 0),
    // rust: ];
    // rust: let mut by_dir: [Option<u32>; 6] = [None; 6];
    // rust: for (slot, (dx, dy, dz)) in by_dir.iter_mut().zip(dirs) {
    // rust: let n = self.swim_accepted(px + dx, py + dy, pz + dz);
    // rust: *slot = n;
    // rust: if open(self, n) {
    // rust: out.push(n.unwrap_or_default());
}
}
    // rust: for (a, b, dx, dz, cx, cz) in [
    // rust: (2usize, 5usize, 0i32, -1i32, 1i32, 0i32),
    // rust: (5usize, 3usize, 1i32, 0i32, 0i32, 1i32),
    // rust: (3usize, 4usize, 0i32, 1i32, -1i32, 0i32),
    // rust: (4usize, 2usize, -1i32, 0i32, 0i32, -1i32),
    // rust: ] {
    // rust: if malus(self, by_dir[a]) && malus(self, by_dir[b]) {
    // rust: let d = self.swim_accepted(px + dx + cx, py, pz + dz + cz);
    // rust: if open(self, d) {
    // rust: out.push(d.unwrap_or_default());
}
}
}
}
pub fn fly_accepted(self: *Self, x: i32, y: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = self.cached(x, y, z);
    // rust: let cost = self.malus(t);
    // rust: if cost >= 0.0 {
    // rust: let n = self.node_update_max(x, y, z, t, cost);
    // rust: if t == PathType::Walkable {
    // rust: self.nodes[n as usize].cost_malus += 1.0;
}
    // rust: return Some(n);
}
    // rust: None
}
pub fn fly_neighbors(self: *Self, pos: u32, out: *mut std.ArrayList(u32)) void {
}
    // rust: let (px, py, pz) = {
    // rust: let n = &self.nodes[pos as usize];
    // rust: (n.x, n.y, n.z)
}
    // rust: let f = |s: &mut Self, dx: i32, dy: i32, dz: i32| s.fly_accepted(px + dx, py + dy, pz + dz);
    // rust: let open = |s: &Self, n: Option<u32>| n.is_some_and(|n| !s.nodes[n as usize].closed);
    // rust: let m = |s: &Self, n: Option<u32>| n.is_some_and(|n| s.nodes[n as usize].cost_malus >= 0.0);
    // rust: let south = f(self, 0, 0, 1);
    // rust: let west = f(self, -1, 0, 0);
    // rust: let east = f(self, 1, 0, 0);
    // rust: let north = f(self, 0, 0, -1);
    // rust: let up = f(self, 0, 1, 0);
    // rust: let down = f(self, 0, -1, 0);
    // rust: for n in [south, west, east, north, up, down] {
    // rust: if open(self, n) {
    // rust: out.push(n.unwrap_or_default());
}
}
    // rust: let push = |s: &mut Self, n: Option<u32>, ok: bool, out: &mut Vec<u32>| {
    // rust: if open(s, n) && ok {
    // rust: out.push(n.unwrap_or_default());
}
}
    // rust: let south_up = f(self, 0, 1, 1);
    // rust: let ok = m(self, south) && m(self, up);
    // rust: push(self, south_up, ok, out);
    // rust: let west_up = f(self, -1, 1, 0);
    // rust: let ok = m(self, west) && m(self, up);
    // rust: push(self, west_up, ok, out);
    // rust: let east_up = f(self, 1, 1, 0);
    // rust: let ok = m(self, east) && m(self, up);
    // rust: push(self, east_up, ok, out);
    // rust: let north_up = f(self, 0, 1, -1);
    // rust: let ok = m(self, north) && m(self, up);
    // rust: push(self, north_up, ok, out);
    // rust: let south_down = f(self, 0, -1, 1);
    // rust: let ok = m(self, south) && m(self, down);
    // rust: push(self, south_down, ok, out);
    // rust: let west_down = f(self, -1, -1, 0);
    // rust: let ok = m(self, west) && m(self, down);
    // rust: push(self, west_down, ok, out);
    // rust: let east_down = f(self, 1, -1, 0);
    // rust: let ok = m(self, east) && m(self, down);
    // rust: push(self, east_down, ok, out);
    // rust: let north_down = f(self, 0, -1, -1);
    // rust: let ok = m(self, north) && m(self, down);
    // rust: push(self, north_down, ok, out);
    // rust: let north_east = f(self, 1, 0, -1);
    // rust: let ok = m(self, north) && m(self, east);
    // rust: push(self, north_east, ok, out);
    // rust: let south_east = f(self, 1, 0, 1);
    // rust: let ok = m(self, south) && m(self, east);
    // rust: push(self, south_east, ok, out);
    // rust: let north_west = f(self, -1, 0, -1);
    // rust: let ok = m(self, north) && m(self, west);
    // rust: push(self, north_west, ok, out);
    // rust: let south_west = f(self, -1, 0, 1);
    // rust: let ok = m(self, south) && m(self, west);
    // rust: push(self, south_west, ok, out);
    // rust: let neu = f(self, 1, 1, -1);
    // rust: let ok = m(self, north_east)
    // rust: && m(self, north)
    // rust: && m(self, east)
    // rust: && m(self, up)
    // rust: && m(self, north_up)
    // rust: && m(self, east_up);
    // rust: push(self, neu, ok, out);
    // rust: let seu = f(self, 1, 1, 1);
    // rust: let ok = m(self, south_east)
    // rust: && m(self, south)
    // rust: && m(self, east)
    // rust: && m(self, up)
    // rust: && m(self, south_up)
    // rust: && m(self, east_up);
    // rust: push(self, seu, ok, out);
    // rust: let nwu = f(self, -1, 1, -1);
    // rust: let ok = m(self, north_west)
    // rust: && m(self, north)
    // rust: && m(self, west)
    // rust: && m(self, up)
    // rust: && m(self, north_up)
    // rust: && m(self, west_up);
    // rust: push(self, nwu, ok, out);
    // rust: let swu = f(self, -1, 1, 1);
    // rust: let ok = m(self, south_west)
    // rust: && m(self, south)
    // rust: && m(self, west)
    // rust: && m(self, up)
    // rust: && m(self, south_up)
    // rust: && m(self, west_up);
    // rust: push(self, swu, ok, out);
    // rust: let ned = f(self, 1, -1, -1);
    // rust: let ok = m(self, north_east)
    // rust: && m(self, north)
    // rust: && m(self, east)
    // rust: && m(self, down)
    // rust: && m(self, north_down)
    // rust: && m(self, east_down);
    // rust: push(self, ned, ok, out);
    // rust: let sed = f(self, 1, -1, 1);
    // rust: let ok = m(self, south_east)
    // rust: && m(self, south)
    // rust: && m(self, east)
    // rust: && m(self, down)
    // rust: && m(self, south_down)
    // rust: && m(self, east_down);
    // rust: push(self, sed, ok, out);
    // rust: let nwd = f(self, -1, -1, -1);
    // rust: let ok = m(self, north_west)
    // rust: && m(self, north)
    // rust: && m(self, west)
    // rust: && m(self, down)
    // rust: && m(self, north_down)
    // rust: && m(self, west_down);
    // rust: push(self, nwd, ok, out);
    // rust: let swd = f(self, -1, -1, 1);
    // rust: let ok = m(self, south_west)
    // rust: && m(self, south)
    // rust: && m(self, west)
    // rust: && m(self, down)
    // rust: && m(self, south_down)
    // rust: && m(self, west_down);
    // rust: push(self, swd, ok, out);
}
    // --- binary heap (vanilla BinaryHeap) --------------------------------
pub fn heap_insert(self: *Self, n: u32) void {
}
    // rust: let i = self.heap.len();
    // rust: self.heap.push(n);
    // rust: self.nodes[n as usize].heap = i as i32;
    // rust: self.up_heap(i);
}
pub fn heap_pop(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let popped = self.heap[0];
    // rust: let last = self.heap.pop().unwrap_or(popped);
    // rust: if !self.heap.is_empty() {
    // rust: self.heap[0] = last;
    // rust: self.nodes[last as usize].heap = 0;
    // rust: self.down_heap(0);
}
    // rust: self.nodes[popped as usize].heap = -1;
    // rust: popped
}
pub fn change_cost(self: *Self, n: u32, cost: f32) void {
}
    // rust: let old = self.nodes[n as usize].f;
    // rust: self.nodes[n as usize].f = cost;
    // rust: let i = self.nodes[n as usize].heap as usize;
    // rust: if cost < old {
    // rust: self.up_heap(i);
    // rust: } else {
    // rust: self.down_heap(i);
}
}
pub fn up_heap(self: *Self, mut i: usize) void {
}
    // rust: let node = self.heap[i];
    // rust: let cost = self.nodes[node as usize].f;
    // rust: while i > 0 {
    // rust: let parent_i = (i - 1) >> 1;
    // rust: let parent = self.heap[parent_i];
    // rust: if cost >= self.nodes[parent as usize].f {
    // rust: break;
}
    // rust: self.heap[i] = parent;
    // rust: self.nodes[parent as usize].heap = i as i32;
    // rust: i = parent_i;
}
    // rust: self.heap[i] = node;
    // rust: self.nodes[node as usize].heap = i as i32;
}
pub fn down_heap(self: *Self, mut i: usize) void {
}
    // rust: let node = self.heap[i];
    // rust: let cost = self.nodes[node as usize].f;
    // rust: let size = self.heap.len();
    // rust: loop {
    // rust: let left_i = 1 + (i << 1);
    // rust: let right_i = left_i + 1;
    // rust: if left_i >= size {
    // rust: break;
}
    // rust: let left = self.heap[left_i];
    // rust: let left_cost = self.nodes[left as usize].f;
    // rust: let (right, right_cost) = if right_i >= size {
    // rust: (u32::MAX, f32::INFINITY)
    // rust: } else {
    // rust: (
    // rust: self.heap[right_i],
    // rust: self.nodes[self.heap[right_i] as usize].f,
    // rust: )
}
    // rust: if left_cost < right_cost {
    // rust: if left_cost >= cost {
    // rust: break;
}
    // rust: self.heap[i] = left;
    // rust: self.nodes[left as usize].heap = i as i32;
    // rust: i = left_i;
    // rust: } else {
    // rust: if right_cost >= cost {
    // rust: break;
}
    // rust: self.heap[i] = right;
    // rust: self.nodes[right as usize].heap = i as i32;
    // rust: i = right_i;
}
}
    // rust: self.heap[i] = node;
    // rust: self.nodes[node as usize].heap = i as i32;
}
    // --- PathFinder.findPath ------------------------------------------------
pub fn best_h(self: *Self, n: u32, targets: *mut [Target]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut best = f32::MAX;
    // rust: let node = &self.nodes[n as usize];
    // rust: for t in targets.iter_mut() {
    // rust: let h = node.distance(t.x, t.y, t.z);
    // rust: if h < t.best_h {
    // rust: t.best_h = h;
    // rust: t.best = Some(n);
}
    // rust: best = best.min(h);
}
    // rust: best
}
    /// PathFinder.findPath over several target positions.
    // rust: pub fn find(
    // rust: mut self,
    // rust: positions: &[[i32; 3]],
    // rust: max_path_length: f32,
    // rust: reach_range: i32,
    // rust: max_visited: i32,
    // rust: ) -> Option<Path> {
    // rust: let from = self.start()?;
    // rust: let mut targets: Vec<Target> = positions
    // rust: .iter()
    // rust: .map(|p| {
                // AmphibiousNodeEvaluator.getTarget floors y + 0.5 (the same block).
    // rust: let n = self.node(p[0], p[1], p[2]);
    // rust: let node = &self.nodes[n as usize];
    // rust: Target {
    // rust: x: node.x,
    // rust: y: node.y,
    // rust: z: node.z,
    // rust: best_h: f32::MAX,
    // rust: best: None,
    // rust: reached: false,
    // rust: pos: *p,
}
    // rust: })
    // rust: .collect();
    // rust: self.nodes[from as usize].g = 0.0;
    // rust: let h = self.best_h(from, &mut targets);
    // rust: self.nodes[from as usize].h = h;
    // rust: self.nodes[from as usize].f = h;
    // rust: self.heap.clear();
    // rust: self.heap_insert(from);
    // rust: let mut count = 0;
    // rust: let mut neighbors = Vec::with_capacity(32);
    // rust: let (fx, fy, fz) = {
    // rust: let n = &self.nodes[from as usize];
    // rust: (n.x, n.y, n.z)
}
    // rust: while !self.heap.is_empty() {
    // rust: count += 1;
    // rust: if count >= max_visited {
    // rust: break;
}
    // rust: let current = self.heap_pop();
    // rust: self.nodes[current as usize].closed = true;
    // rust: let mut any = false;
    // rust: for t in targets.iter_mut() {
    // rust: if self.nodes[current as usize].manhattan(t.x, t.y, t.z) <= reach_range as f32 {
    // rust: t.reached = true;
    // rust: any = true;
}
}
    // rust: if any {
    // rust: break;
}
    // rust: if self.nodes[current as usize].distance(fx, fy, fz) >= max_path_length {
    // rust: continue;
}
    // rust: neighbors.clear();
    // rust: match self.eval {
    // rust: Evaluator::Walk | Evaluator::Amphibious { .. } => {
    // rust: self.walk_neighbors(current, &mut neighbors)
}
    // rust: Evaluator::Swim { .. } => self.swim_neighbors(current, &mut neighbors),
    // rust: Evaluator::Fly => self.fly_neighbors(current, &mut neighbors),
}
    // rust: for &neighbor in &neighbors {
    // rust: let (cx, cy, cz, cg, cw) = {
    // rust: let c = &self.nodes[current as usize];
    // rust: (c.x, c.y, c.z, c.g, c.walked)
}
    // rust: let distance = self.nodes[neighbor as usize].distance(cx, cy, cz);
    // rust: let walked = cw + distance;
    // rust: self.nodes[neighbor as usize].walked = walked;
    // rust: let tentative = cg + distance + self.nodes[neighbor as usize].cost_malus;
    // rust: let in_open = self.nodes[neighbor as usize].heap >= 0;
    // rust: if walked < max_path_length
    // rust: && (!in_open || tentative < self.nodes[neighbor as usize].g)
    // rust: {
    // rust: self.nodes[neighbor as usize].came_from = Some(current);
    // rust: self.nodes[neighbor as usize].g = tentative;
    // rust: let h = self.best_h(neighbor, &mut targets) * 1.5;
    // rust: self.nodes[neighbor as usize].h = h;
    // rust: if in_open {
    // rust: self.change_cost(neighbor, tentative + h);
    // rust: } else {
    // rust: self.nodes[neighbor as usize].f = tentative + h;
    // rust: self.heap_insert(neighbor);
}
}
}
}
    // rust: let reached: Vec<&Target> = targets.iter().filter(|t| t.reached).collect();
    // rust: let build = |s: &Self, t: &Target, reached: bool| -> Option<Path> {
    // rust: let mut n = t.best?;
    // rust: let mut nodes = vec![];
    // rust: loop {
    // rust: let node = &s.nodes[n as usize];
    // rust: nodes.push(PathNode {
    // rust: x: node.x,
    // rust: y: node.y,
    // rust: z: node.z,
    // rust: kind: node.kind,
    // rust: });
    // rust: match node.came_from {
    // rust: Some(c) => n = c,
    // rust: None => break,
}
}
    // rust: nodes.reverse();
    // rust: Some(Path::new(nodes, t.pos, reached))
}
    // rust: if !reached.is_empty() {
    // rust: reached
    // rust: .iter()
    // rust: .filter_map(|t| build(&self, t, true))
    // rust: .min_by_key(|p| p.nodes.len())
    // rust: } else {
    // rust: targets
    // rust: .iter()
    // rust: .filter_map(|t| build(&self, t, false))
    // rust: .min_by(|a, b| {
    // rust: a.dist_to_target
    // rust: .total_cmp(&b.dist_to_target)
    // rust: .then(a.nodes.len().cmp(&b.nodes.len()))
    // rust: })
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn node(x: i32, y: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PathNode {
    // rust: x,
    // rust: y,
    // rust: z,
    // rust: kind: PathType::Open,
}
}

pub fn path(nodes: std.ArrayList(PathNode)) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Path {
    // rust: nodes,
    // rust: next: 0,
    // rust: target: [0, 0, 0],
    // rust: dist_to_target: 0.0,
    // rust: reached: true,
}
}

    /// `PathNavigation.trimPath`: the node standing on a cauldron moves onto its
    /// rim, and the node after it follows when it is not above the cauldron.
pub fn a_node_on_a_cauldron_is_raised_onto_its_rim() void {
}
    // rust: let mut p = path(vec![
    // rust: node(0, 63, 0),
    // rust: node(1, 63, 0),
    // rust: node(2, 63, 0),
    // rust: node(2, 66, 0),
    // rust: ]);
    // rust: p.raise_cauldron_nodes(|x, y, _| x == 2 && y == 63);
    // rust: assert_eq!(p.nodes[0], node(0, 63, 0), "a plain node keeps its height");
    // rust: assert_eq!(p.nodes[1], node(1, 63, 0));
    // rust: assert_eq!(
    // rust: p.nodes[2],
    // rust: node(2, 64, 0),
    // rust: "the cauldron node is raised one block"
    // rust: );
    // rust: assert_eq!(
    // rust: p.nodes[3],
    // rust: node(2, 66, 0),
    // rust: "a node above the cauldron is left alone"
    // rust: );
    // rust: assert_eq!(p.target, [0, 0, 0], "the requested target does not move");
}

    /// The node after a cauldron is raised with it unless it is above it, so a
    /// route that steps off a cauldron does not drop back into the block.
pub fn the_node_after_a_cauldron_follows_it_up() void {
}
    // rust: let mut p = path(vec![node(0, 63, 0), node(1, 63, 0)]);
    // rust: p.raise_cauldron_nodes(|_, y, _| y == 63);
        // The closure still reports the original height, as the block under the
        // raised node is the cauldron itself.
    // rust: assert_eq!(p.nodes, vec![node(0, 64, 0), node(1, 64, 0)]);
}

    /// A path with no cauldron under it is not touched.
pub fn a_path_without_cauldrons_is_unchanged() void {
}
    // rust: let nodes = vec![node(0, 64, 0), node(1, 64, 0), node(1, 65, 0)];
    // rust: let mut p = path(nodes.clone());
    // rust: p.raise_cauldron_nodes(|_, _, _| false);
    // rust: assert_eq!(p.nodes, nodes);
}
}
