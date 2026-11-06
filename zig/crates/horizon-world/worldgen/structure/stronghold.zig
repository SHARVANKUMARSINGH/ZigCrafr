//! Transpiled from Horizon Rust crate
//! Module: horizon-world_stronghold
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Strongholds: StrongholdStructure, StrongholdPieces and the concentric
//! ring positions of ChunkGeneratorStructureState.
// use super::{
    // rust: BoundingBox,
    // rust: legacy::{LegacyPiece, PieceContext, PieceFrame, Result, make_bounding_box, random_horizontal},
}
// use crate::{registry::BlockStateId, worldgen::biome::BiomeId};
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: position::ChunkPos,
    // rust: random::{LegacyRandom, RandomSource, WorldgenRandom},
}
// use std::{collections::BTreeSet, f64::consts::PI, sync::Mutex};

/// ChunkGeneratorStructureState.generateRingPositions with
/// BiomeSource.findBiomeHorizontal (radius 112, step 1, not closest).
/// `biomes` samples a search's quarts in order, as one caching resolver.
    // rust: pub fn ring_positions(
    // rust: seed: i64,
    // rust: distance: i32,
    // rust: spread: i32,
    // rust: count: i32,
    // rust: preferred: &BTreeSet<BiomeId>,
    // rust: biomes: &mut dyn FnMut(&[[i32; 3]]) -> Vec<BiomeId>,
    // rust: ) -> Vec<ChunkPos> {
    // rust: ring_searches(seed, distance, spread, count)
    // rust: .iter()
    // rust: .map(|search| search.find(preferred, biomes))
    // rust: .collect()
}

/// findBiomeHorizontal's radius, 112 blocks, in quarts.
pub const SEARCH_QUARTS: i32 = 28;

/// One ring position before its biome search: the chunk on the ring and the
/// random its search uses. Vanilla runs each search as its own task.
pub const RingSearch = struct {
    x: i32,
    z: i32,
    random: LegacyRandom,
};
    // rust: impl RingSearch {
    /// Whether the search can end within `margin` chunks of chunk (`x`,
    /// `z`): it ends on its ring chunk or in the square it samples, at most
    /// 120 blocks from the ring chunk's corner (8 chunks, rounded up).
pub fn may_land_near(self: *Self, x: i32, z: i32, margin: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let reach = (SEARCH_QUARTS * 4 + 8 + 15) / 16 + margin;
    // rust: (self.x - x).abs() <= reach && (self.z - z).abs() <= reach
}
    /// BiomeSource.findBiomeHorizontal around the ring chunk's centre: a
    /// random preferred biome within 112 blocks, else the ring chunk itself.
    ///
    /// Vanilla samples the square in order on one thread, and its climate
    /// index (Climate.RTree) starts each lookup from the previous result and
    /// keeps it on a tie; so `biomes` gets the whole square at once, in
    /// vanilla's order. Fresh lookups moved seed 1234's first stronghold 6
    /// chunks: one quart on a lush caves / ocean tie went to the ocean.
    /// `FixedBiomeSource.findBiomeHorizontal`: the one biome is allowed or it is not, and an
    /// allowed one gives a random block of the square (two draws), not the reservoir search.
    // rust: pub fn find_fixed(
    // rust: &self,
    // rust: preferred: &BTreeSet<BiomeId>,
    // rust: biomes: &mut dyn FnMut(&[[i32; 3]]) -> Vec<BiomeId>,
    // rust: ) -> ChunkPos {
    // rust: let mut search = self.random.clone();
    // rust: let (cx, cz) = (self.x * 16 + 8, self.z * 16 + 8);
    // rust: let allowed = biomes(&[[cx >> 2, 0, cz >> 2]])
    // rust: .first()
    // rust: .is_some_and(|biome| preferred.contains(biome));
    // rust: if !allowed {
    // rust: return ChunkPos::new(self.x, self.z);
}
    // rust: let r = SEARCH_QUARTS * 4;
    // rust: let x = cx - r + search.next_int_bound(r * 2 + 1).unwrap_or(0);
    // rust: let z = cz - r + search.next_int_bound(r * 2 + 1).unwrap_or(0);
    // rust: ChunkPos::new(x >> 4, z >> 4)
}
    // rust: pub fn find(
    // rust: &self,
    // rust: preferred: &BTreeSet<BiomeId>,
    // rust: biomes: &mut dyn FnMut(&[[i32; 3]]) -> Vec<BiomeId>,
    // rust: ) -> ChunkPos {
    // rust: let mut search = self.random.clone();
    // rust: let (cx, cz) = ((self.x * 16 + 8) >> 2, (self.z * 16 + 8) >> 2);
    // rust: let r = SEARCH_QUARTS;
    // rust: let quarts: Vec<[i32; 3]> = (-r..=r)
    // rust: .flat_map(|dz| (-r..=r).map(move |dx| [cx + dx, 0, cz + dz]))
    // rust: .collect();
    // rust: let mut found = 0;
    // rust: let mut result = None;
    // rust: for (quart, biome) in quarts.iter().zip(biomes(&quarts)) {
    // rust: if preferred.contains(&biome) {
    // rust: if result.is_none() || search.next_int_bound(found + 1).unwrap_or(1) == 0 {
    // rust: result = Some((quart[0] << 2, quart[2] << 2));
}
    // rust: found += 1;
}
}
    // rust: match result {
    // rust: Some((bx, bz)) => ChunkPos::new(bx >> 4, bz >> 4),
    // rust: None => ChunkPos::new(self.x, self.z),
}
}
}

/// The ring chunks and search randoms of generateRingPositions, in order:
/// the serial part, cheap; the searches can then run anywhere.
pub fn ring_searches(seed: i64, distance: i32, spread: i32, count: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: let mut angle = random.next_double() * PI * 2.0;
    // rust: let (mut in_circle, mut circle, mut spread) = (0, 0, spread);
    // rust: let mut out = Vec::with_capacity(count.max(0) as usize);
    // rust: for i in 0..count {
    // rust: let dist = f64::from(4 * distance + distance * circle * 6)
    // rust: + (random.next_double() - 0.5) * (f64::from(distance) * 2.5);
    // rust: let round = |v: f64| (v + 0.5).floor() as i64 as i32;
    // rust: out.push(RingSearch {
    // rust: x: round(horizon_core::jmath::cos(angle) * dist),
    // rust: z: round(horizon_core::jmath::sin(angle) * dist),
    // rust: random: random.fork(),
    // rust: });
    // rust: angle += PI * 2.0 / f64::from(spread);
    // rust: in_circle += 1;
    // rust: if in_circle == spread {
    // rust: circle += 1;
    // rust: in_circle = 0;
    // rust: spread += 2 * spread / (circle + 1);
    // rust: spread = spread.min(count - i);
    // rust: angle += random.next_double() * PI * 2.0;
}
}
    // rust: out
}

pub const Door = enum {
    Opening,
    Wood,
    Grates,
    Iron,
};
pub const Kind = enum {
    Straight,
    PrisonHall,
    LeftTurn,
    RightTurn,
    RoomCrossing,
    StraightStairsDown,
    StairsDown,
    FiveCrossing,
    ChestCorridor,
    Library,
    PortalRoom,
    Filler,
    Start,
};
/// STRONGHOLD_PIECE_WEIGHTS: kind, weight, max place count.
    // rust: const WEIGHTS: [(Kind, i32, i32); 11] = [
    // rust: (Kind::Straight, 40, 0),
    // rust: (Kind::PrisonHall, 5, 5),
    // rust: (Kind::LeftTurn, 20, 0),
    // rust: (Kind::RightTurn, 20, 0),
    // rust: (Kind::RoomCrossing, 10, 6),
    // rust: (Kind::StraightStairsDown, 5, 5),
    // rust: (Kind::StairsDown, 5, 5),
    // rust: (Kind::FiveCrossing, 5, 4),
    // rust: (Kind::ChestCorridor, 5, 4),
    // rust: (Kind::Library, 10, 2),
    // rust: (Kind::PortalRoom, 20, 1),
    // rust: ];

pub const StrongholdPiece = struct {
    kind: Kind,
    frame: PieceFrame,
    depth: i32,
    door: Door,
    /// Straight: left, right; FiveCrossing: leftLow, leftHigh, rightLow,
    /// rightHigh; Library: tall.
    flags: [bool,
    /// RoomCrossing type or FillerCorridor steps.
    value: i32,
    /// ChestCorridor chest / PortalRoom spawner placed.
    placed: Mutex<bool>,
};

pub fn int(r: *mut impl RandomSource, bound: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.next_int_bound(bound).unwrap_or(0)
}
/// BoundingBox.orientBox.
    // rust: pub(super) fn orient_box(
    // rust: [x, y, z]: [i32; 3],
    // rust: [ox, oy, oz]: [i32; 3],
    // rust: [w, h, d]: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> BoundingBox {
    // rust: match direction {
    // rust: Direction::North => BoundingBox::new(
    // rust: [x + ox, y + oy, z - d + 1 + oz],
    // rust: [x + w - 1 + ox, y + h - 1 + oy, z + oz],
    // rust: ),
    // rust: Direction::West => BoundingBox::new(
    // rust: [x - d + 1 + oz, y + oy, z + ox],
    // rust: [x + oz, y + h - 1 + oy, z + w - 1 + ox],
    // rust: ),
    // rust: Direction::East => BoundingBox::new(
    // rust: [x + oz, y + oy, z + ox],
    // rust: [x + d - 1 + oz, y + h - 1 + oy, z + w - 1 + ox],
    // rust: ),
    // rust: _ => BoundingBox::new(
    // rust: [x + ox, y + oy, z + oz],
    // rust: [x + w - 1 + ox, y + h - 1 + oy, z + d - 1 + oz],
    // rust: ),
}
}
pub fn random_door(r: *mut impl RandomSource) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match int(r, 5) {
    // rust: 2 => Door::Wood,
    // rust: 3 => Door::Grates,
    // rust: 4 => Door::Iron,
    // rust: _ => Door::Opening,
}
}

pub const Builder = struct {
    pieces: std.ArrayList(StrongholdPiece),
    weights: Vec<(Kind,
    imposed: ?Kind,
    previous: ?Kind,
    pending: std.ArrayList(usize),
    portal: bool,
};
    // rust: impl Builder {
pub fn collides(self: *Self, b: *BoundingBox) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pieces
    // rust: .iter()
    // rust: .any(|p| p.frame.bounding_box.intersects(b))
}
pub fn piece(kind: Kind, b: BoundingBox, d: Direction, depth: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: StrongholdPiece {
    // rust: kind,
    // rust: frame: PieceFrame::new(b, Some(d)),
    // rust: depth,
    // rust: door: Door::Opening,
    // rust: flags: [false; 4],
    // rust: value: 0,
    // rust: placed: Mutex::new(false),
}
}
    /// StrongholdPieces.findAndCreatePieceFactory.
    // rust: fn create(
    // rust: &self,
    // rust: kind: Kind,
    // rust: r: &mut impl RandomSource,
    // rust: foot: [i32; 3],
    // rust: d: Direction,
    // rust: depth: i32,
    // rust: ) -> Option<StrongholdPiece> {
    // rust: let ok = |b: &BoundingBox| b.min[1] > 10 && !self.collides(b);
    // rust: let (offset, size) = match kind {
    // rust: Kind::Straight | Kind::ChestCorridor => ([-1, -1, 0], [5, 5, 7]),
    // rust: Kind::PrisonHall => ([-1, -1, 0], [9, 5, 11]),
    // rust: Kind::LeftTurn | Kind::RightTurn => ([-1, -1, 0], [5, 5, 5]),
    // rust: Kind::RoomCrossing => ([-4, -1, 0], [11, 7, 11]),
    // rust: Kind::StraightStairsDown => ([-1, -7, 0], [5, 11, 8]),
    // rust: Kind::StairsDown => ([-1, -7, 0], [5, 11, 5]),
    // rust: Kind::FiveCrossing => ([-4, -3, 0], [10, 9, 11]),
    // rust: Kind::Library => ([-4, -1, 0], [14, 11, 15]),
    // rust: Kind::PortalRoom => ([-4, -1, 0], [11, 8, 16]),
    // rust: Kind::Filler | Kind::Start => return None,
}
    // rust: let mut b = orient_box(foot, offset, size, d);
    // rust: if !ok(&b) {
    // rust: if kind != Kind::Library {
    // rust: return None;
}
    // rust: b = orient_box(foot, offset, [14, 6, 15], d);
    // rust: if !ok(&b) {
    // rust: return None;
}
}
    // rust: let mut piece = Self::piece(kind, b, d, depth);
    // rust: if kind != Kind::PortalRoom {
    // rust: piece.door = random_door(r);
}
    // rust: match kind {
    // rust: Kind::Straight => {
    // rust: piece.flags[0] = int(r, 2) == 0;
    // rust: piece.flags[1] = int(r, 2) == 0;
}
    // rust: Kind::RoomCrossing => piece.value = int(r, 5),
    // rust: Kind::FiveCrossing => {
    // rust: piece.flags[0] = r.next_boolean();
    // rust: piece.flags[1] = r.next_boolean();
    // rust: piece.flags[2] = r.next_boolean();
    // rust: piece.flags[3] = int(r, 3) > 0;
}
    // rust: Kind::Library => piece.flags[0] = b.span()[1] > 6,
    // rust: _ => {}
}
    // rust: Some(piece)
}
    /// StrongholdPieces.generatePieceFromSmallDoor.
    // rust: fn piece_from_small_door(
    // rust: &mut self,
    // rust: r: &mut impl RandomSource,
    // rust: foot: [i32; 3],
    // rust: d: Direction,
    // rust: depth: i32,
    // rust: ) -> Option<StrongholdPiece> {
    // rust: let any = self.weights.iter().any(|w| w.2 > 0 && w.3 < w.2);
    // rust: let total: i32 = self.weights.iter().map(|w| w.1).sum();
    // rust: if !any {
    // rust: return None;
}
    // rust: if let Some(kind) = self.imposed.take() {
    // rust: if let Some(piece) = self.create(kind, r, foot, d, depth) {
    // rust: return Some(piece);
}
}
    // rust: for _ in 0..5 {
    // rust: let mut selection = int(r, total);
    // rust: for i in 0..self.weights.len() {
    // rust: let (kind, weight, max, count) = self.weights[i];
    // rust: selection -= weight;
    // rust: if selection < 0 {
    // rust: let allowed = (max == 0 || count < max)
    // rust: && match kind {
    // rust: Kind::Library => depth > 4,
    // rust: Kind::PortalRoom => depth > 5,
    // rust: _ => true,
}
    // rust: if !allowed || self.previous == Some(kind) {
    // rust: break;
}
    // rust: if let Some(piece) = self.create(kind, r, foot, d, depth) {
    // rust: self.weights[i].3 += 1;
    // rust: self.previous = Some(kind);
    // rust: if max != 0 && count + 1 >= max {
    // rust: self.weights.remove(i);
}
    // rust: return Some(piece);
}
}
}
}
    // rust: let b = orient_box(foot, [-1, -1, 0], [5, 5, 4], d);
    // rust: let collision = self
    // rust: .pieces
    // rust: .iter()
    // rust: .find(|p| p.frame.bounding_box.intersects(&b))?
    // rust: .frame
    // rust: .bounding_box;
    // rust: if collision.min[1] != b.min[1] {
    // rust: return None;
}
    // rust: for length in [2, 1] {
    // rust: if !collision.intersects(&orient_box(foot, [-1, -1, 0], [5, 5, length], d)) {
    // rust: let b = orient_box(foot, [-1, -1, 0], [5, 5, length + 1], d);
    // rust: if b.min[1] <= 1 {
    // rust: return None;
}
    // rust: let mut piece = Self::piece(Kind::Filler, b, d, depth);
    // rust: piece.value = b.span()[if matches!(d, Direction::North | Direction::South) {
    // rust: 2
    // rust: } else {
    // rust: 0
    // rust: }];
    // rust: return Some(piece);
}
}
    // rust: None
}
    /// StrongholdPieces.generateAndAddPiece.
pub fn add(self: *Self, r: *mut impl RandomSource, foot: [i32; 3], d: Direction, depth: i32) void {
}
    // rust: if depth > 50 {
    // rust: return;
}
    // rust: let start = self.pieces[0].frame.bounding_box;
    // rust: if (foot[0] - start.min[0]).abs() > 112 || (foot[2] - start.min[2]).abs() > 112 {
    // rust: return;
}
    // rust: if let Some(piece) = self.piece_from_small_door(r, foot, d, depth + 1) {
    // rust: self.pieces.push(piece);
    // rust: self.pending.push(self.pieces.len() - 1);
}
}
pub fn forward(self: *Self, r: *mut impl RandomSource, i: usize, x_off: i32, y_off: i32) void {
}
    // rust: let p = &self.pieces[i];
    // rust: let (b, depth) = (p.frame.bounding_box, p.depth);
    // rust: let Some(o) = p.frame.orientation else { return };
    // rust: let y = b.min[1] + y_off;
    // rust: let foot = match o {
    // rust: Direction::North => [b.min[0] + x_off, y, b.min[2] - 1],
    // rust: Direction::South => [b.min[0] + x_off, y, b.max[2] + 1],
    // rust: Direction::West => [b.min[0] - 1, y, b.min[2] + x_off],
    // rust: Direction::East => [b.max[0] + 1, y, b.min[2] + x_off],
    // rust: _ => return,
}
    // rust: self.add(r, foot, o, depth);
}
pub fn side(self: *Self, r: *mut impl RandomSource, i: usize, right: bool, y_off: i32, z_off: i32) void {
}
    // rust: let p = &self.pieces[i];
    // rust: let (b, depth) = (p.frame.bounding_box, p.depth);
    // rust: let Some(o) = p.frame.orientation else { return };
    // rust: let y = b.min[1] + y_off;
    // rust: let (foot, d) = match (o, right) {
    // rust: (Direction::North | Direction::South, false) => {
    // rust: ([b.min[0] - 1, y, b.min[2] + z_off], Direction::West)
}
    // rust: (Direction::North | Direction::South, true) => {
    // rust: ([b.max[0] + 1, y, b.min[2] + z_off], Direction::East)
}
    // rust: (Direction::West | Direction::East, false) => {
    // rust: ([b.min[0] + z_off, y, b.min[2] - 1], Direction::North)
}
    // rust: (Direction::West | Direction::East, true) => {
    // rust: ([b.min[0] + z_off, y, b.max[2] + 1], Direction::South)
}
    // rust: _ => return,
}
    // rust: self.add(r, foot, d, depth);
}
pub fn add_children(self: *Self, r: *mut impl RandomSource, i: usize) void {
}
    // rust: let p = &self.pieces[i];
    // rust: let (kind, flags, o) = (p.kind, p.flags, p.frame.orientation);
    // rust: let north_or_east = matches!(o, Some(Direction::North | Direction::East));
    // rust: match kind {
    // rust: Kind::Start | Kind::StairsDown => {
    // rust: if kind == Kind::Start {
    // rust: self.imposed = Some(Kind::FiveCrossing);
}
    // rust: self.forward(r, i, 1, 1);
}
    // rust: Kind::ChestCorridor | Kind::PrisonHall | Kind::StraightStairsDown => {
    // rust: self.forward(r, i, 1, 1)
}
    // rust: Kind::Straight => {
    // rust: self.forward(r, i, 1, 1);
    // rust: if flags[0] {
    // rust: self.side(r, i, false, 1, 2);
}
    // rust: if flags[1] {
    // rust: self.side(r, i, true, 1, 2);
}
}
    // rust: Kind::FiveCrossing => {
    // rust: let (a, b) = if matches!(o, Some(Direction::West | Direction::North)) {
    // rust: (5, 3)
    // rust: } else {
    // rust: (3, 5)
}
    // rust: self.forward(r, i, 5, 1);
    // rust: if flags[0] {
    // rust: self.side(r, i, false, a, 1);
}
    // rust: if flags[1] {
    // rust: self.side(r, i, false, b, 7);
}
    // rust: if flags[2] {
    // rust: self.side(r, i, true, a, 1);
}
    // rust: if flags[3] {
    // rust: self.side(r, i, true, b, 7);
}
}
    // rust: Kind::LeftTurn => self.side(r, i, !north_or_east, 1, 1),
    // rust: Kind::RightTurn => self.side(r, i, north_or_east, 1, 1),
    // rust: Kind::RoomCrossing => {
    // rust: self.forward(r, i, 4, 1);
    // rust: self.side(r, i, false, 1, 4);
    // rust: self.side(r, i, true, 1, 4);
}
    // rust: Kind::PortalRoom => self.portal = true,
    // rust: Kind::Library | Kind::Filler => {}
}
}
}

/// StrongholdStructure.generatePieces: retried with seed + tries until a
/// portal room is placed.
    // rust: pub fn generate(
    // rust: random: &mut WorldgenRandom<LegacyRandom>,
    // rust: seed: i64,
    // rust: chunk: [i32; 2],
    // rust: sea_level: i32,
    // rust: min_y: i32,
    // rust: ) -> Vec<StrongholdPiece> {
    // rust: let mut tries = 0i64;
    // rust: loop {
    // rust: random.set_large_feature_seed(seed.wrapping_add(tries), chunk[0], chunk[1]);
    // rust: tries += 1;
    // rust: let d = random_horizontal(random);
    // rust: let b = make_bounding_box(chunk[0] * 16 + 2, 64, chunk[1] * 16 + 2, d, 5, 11, 5);
    // rust: let mut g = Builder {
    // rust: pieces: vec![Builder::piece(Kind::Start, b, d, 0)],
    // rust: weights: WEIGHTS.iter().map(|&(k, w, m)| (k, w, m, 0)).collect(),
    // rust: imposed: None,
    // rust: previous: None,
    // rust: pending: Vec::new(),
    // rust: portal: false,
}
    // rust: g.add_children(random, 0);
    // rust: while !g.pending.is_empty() {
    // rust: let index = int(random, g.pending.len() as i32) as usize;
    // rust: let next = g.pending.remove(index);
    // rust: g.add_children(random, next);
}
    // rust: let mut all = g.pieces[0].frame.bounding_box;
    // rust: for p in &g.pieces[1..] {
    // rust: all.encapsulate(&p.frame.bounding_box);
}
    // rust: let max = sea_level - 10;
    // rust: let mut y1 = all.span()[1] + min_y + 1;
    // rust: if y1 < max {
    // rust: y1 += int(random, max - y1);
}
    // rust: let dy = y1 - all.max[1];
    // rust: for p in &mut g.pieces {
    // rust: p.frame.bounding_box = p.frame.bounding_box.moved([0, dy, 0]);
}
    // rust: if g.portal {
    // rust: return g.pieces;
}
}
}

pub fn smooth(c: *mut PieceContext<'_>, edge: bool) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !edge {
    // rust: return c.state("cave_air");
}
    // rust: let s = c.random.float();
    // rust: c.state(if s < 0.2 {
    // rust: "cracked_stone_bricks"
    // rust: } else if s < 0.5 {
    // rust: "mossy_stone_bricks"
    // rust: } else if s < 0.55 {
    // rust: "infested_stone_bricks"
    // rust: } else {
    // rust: "stone_bricks"
    // rust: })
}
    // rust: impl StrongholdPiece {
    // rust: fn smooth_box(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: a: [i32; 3],
    // rust: b: [i32; 3],
    // rust: skip_air: bool,
    // rust: ) -> Result<()> {
    // rust: self.frame
    // rust: .generate_box_selector(c, a, b, skip_air, &mut |c, _, _, _, edge| smooth(c, edge))
}
    // rust: fn fill(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: a: [i32; 3],
    // rust: b: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> Result<()> {
    // rust: self.frame.generate_box(c, a, b, state, state, false)
}
pub fn air(self: *Self, c: *mut PieceContext<'_>, a: [i32; 3], b: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let air = c.state("cave_air");
    // rust: self.fill(c, a, b, air)
}
    // rust: fn put(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: state: BlockStateId,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> Result<()> {
    // rust: self.frame.place(c, state, x, y, z)
}
    // rust: fn small_door(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: door: Door,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> Result<()> {
    // rust: let bricks = c.state("stone_bricks");
    // rust: let frame = [(0, 0), (0, 1), (0, 2), (1, 2), (2, 2), (2, 1), (2, 0)];
    // rust: match door {
    // rust: Door::Opening => self.air(c, [x, y, z], [x + 2, y + 2, z])?,
    // rust: Door::Wood | Door::Iron => {
    // rust: for (dx, dy) in frame {
    // rust: self.put(c, bricks, x + dx, y + dy, z)?;
}
    // rust: let block = if door == Door::Wood {
    // rust: "oak_door"
    // rust: } else {
    // rust: "iron_door"
}
    // rust: self.put(c, c.state(block), x + 1, y, z)?;
    // rust: self.put(
    // rust: c,
    // rust: c.state_with(block, &[("half", "upper")]),
    // rust: x + 1,
    // rust: y + 1,
    // rust: z,
    // rust: )?;
    // rust: if door == Door::Iron {
    // rust: self.put(
    // rust: c,
    // rust: c.state_with("stone_button", &[("facing", "north")]),
    // rust: x + 2,
    // rust: y + 1,
    // rust: z + 1,
    // rust: )?;
    // rust: self.put(
    // rust: c,
    // rust: c.state_with("stone_button", &[("facing", "south")]),
    // rust: x + 2,
    // rust: y + 1,
    // rust: z - 1,
    // rust: )?;
}
}
    // rust: Door::Grates => {
    // rust: let air = c.state("cave_air");
    // rust: let west = c.state_with("iron_bars", &[("west", "true")]);
    // rust: let east = c.state_with("iron_bars", &[("east", "true")]);
    // rust: let both = c.state_with("iron_bars", &[("east", "true"), ("west", "true")]);
    // rust: self.put(c, air, x + 1, y, z)?;
    // rust: self.put(c, air, x + 1, y + 1, z)?;
    // rust: self.put(c, west, x, y, z)?;
    // rust: self.put(c, west, x, y + 1, z)?;
    // rust: self.put(c, both, x, y + 2, z)?;
    // rust: self.put(c, both, x + 1, y + 2, z)?;
    // rust: self.put(c, both, x + 2, y + 2, z)?;
    // rust: self.put(c, east, x + 2, y + 1, z)?;
    // rust: self.put(c, east, x + 2, y, z)?;
}
}
    // rust: Ok(())
}
pub fn torch(c: *PieceContext<'_>, facing: []const u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: c.state_with("wall_torch", &[("facing", facing)])
}
pub fn chest_corridor(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.smooth_box(c, [0, 0, 0], [4, 4, 6], true)?;
    // rust: self.small_door(c, self.door, 1, 1, 0)?;
    // rust: self.small_door(c, Door::Opening, 1, 1, 6)?;
    // rust: let bricks = c.state("stone_bricks");
    // rust: self.fill(c, [3, 1, 2], [3, 1, 4], bricks)?;
    // rust: let slab = c.state("stone_brick_slab");
    // rust: for (x, y, z) in [
    // rust: (3, 1, 1),
    // rust: (3, 1, 5),
    // rust: (3, 2, 2),
    // rust: (3, 2, 4),
    // rust: (2, 1, 2),
    // rust: (2, 1, 3),
    // rust: (2, 1, 4),
    // rust: ] {
    // rust: self.put(c, slab, x, y, z)?;
}
    // rust: if !*self.placed.lock().unwrap() && c.chunk_box.is_inside(self.frame.world_pos(3, 2, 3)) {
    // rust: *self.placed.lock().unwrap() = true;
    // rust: self.frame
    // rust: .create_chest(c, 3, 2, 3, "minecraft:chests/stronghold_corridor")?;
}
    // rust: Ok(())
}
pub fn filler(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bricks = c.state("stone_bricks");
    // rust: let air = c.state("cave_air");
    // rust: for i in 0..self.value {
    // rust: for x in 0..=4 {
    // rust: self.put(c, bricks, x, 0, i)?;
}
    // rust: for y in 1..=3 {
    // rust: self.put(c, bricks, 0, y, i)?;
    // rust: for x in 1..=3 {
    // rust: self.put(c, air, x, y, i)?;
}
    // rust: self.put(c, bricks, 4, y, i)?;
}
    // rust: for x in 0..=4 {
    // rust: self.put(c, bricks, x, 4, i)?;
}
}
    // rust: Ok(())
}
pub fn five_crossing(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [left_low, left_high, right_low, right_high] = self.flags;
    // rust: self.smooth_box(c, [0, 0, 0], [9, 8, 10], true)?;
    // rust: self.small_door(c, self.door, 4, 3, 0)?;
    // rust: if left_low {
    // rust: self.air(c, [0, 3, 1], [0, 5, 3])?;
}
    // rust: if right_low {
    // rust: self.air(c, [9, 3, 1], [9, 5, 3])?;
}
    // rust: if left_high {
    // rust: self.air(c, [0, 5, 7], [0, 7, 9])?;
}
    // rust: if right_high {
    // rust: self.air(c, [9, 5, 7], [9, 7, 9])?;
}
    // rust: self.air(c, [5, 1, 10], [7, 3, 10])?;
    // rust: self.smooth_box(c, [1, 2, 1], [8, 2, 6], false)?;
    // rust: self.smooth_box(c, [4, 1, 5], [4, 4, 9], false)?;
    // rust: self.smooth_box(c, [8, 1, 5], [8, 4, 9], false)?;
    // rust: self.smooth_box(c, [1, 4, 7], [3, 4, 9], false)?;
    // rust: self.smooth_box(c, [1, 3, 5], [3, 3, 6], false)?;
    // rust: let slab = c.state("smooth_stone_slab");
    // rust: self.fill(c, [1, 3, 4], [3, 3, 4], slab)?;
    // rust: self.fill(c, [1, 4, 6], [3, 4, 6], slab)?;
    // rust: self.smooth_box(c, [5, 1, 7], [7, 1, 8], false)?;
    // rust: self.fill(c, [5, 1, 9], [7, 1, 9], slab)?;
    // rust: self.fill(c, [5, 2, 7], [7, 2, 7], slab)?;
    // rust: self.fill(c, [4, 5, 7], [4, 5, 9], slab)?;
    // rust: self.fill(c, [8, 5, 7], [8, 5, 9], slab)?;
    // rust: let double = c.state_with("smooth_stone_slab", &[("type", "double")]);
    // rust: self.fill(c, [5, 5, 7], [7, 5, 9], double)?;
    // rust: self.put(c, Self::torch(c, "south"), 6, 5, 6)
}
pub fn turn(self: *Self, c: *mut PieceContext<'_>, left: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.smooth_box(c, [0, 0, 0], [4, 4, 4], true)?;
    // rust: self.small_door(c, self.door, 1, 1, 0)?;
    // rust: let north_or_east = matches!(
    // rust: self.frame.orientation,
    // rust: Some(Direction::North | Direction::East)
    // rust: );
    // rust: if north_or_east == left {
    // rust: self.air(c, [0, 1, 1], [0, 3, 3])
    // rust: } else {
    // rust: self.air(c, [4, 1, 1], [4, 3, 3])
}
}
pub fn library(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tall = self.flags[0];
    // rust: let height = if tall { 11 } else { 6 };
    // rust: self.smooth_box(c, [0, 0, 0], [13, height - 1, 14], true)?;
    // rust: self.small_door(c, self.door, 4, 1, 0)?;
    // rust: let web = c.state("cobweb");
    // rust: self.frame
    // rust: .generate_maybe_box(c, 0.07, [2, 1, 1], [11, 4, 13], web, web, false, false)?;
    // rust: let planks = c.state("oak_planks");
    // rust: let shelf = c.state("bookshelf");
    // rust: for d in 1..=13 {
    // rust: let block = if (d - 1) % 4 == 0 { planks } else { shelf };
    // rust: self.fill(c, [1, 1, d], [1, 4, d], block)?;
    // rust: self.fill(c, [12, 1, d], [12, 4, d], block)?;
    // rust: if block == planks {
    // rust: self.put(c, Self::torch(c, "east"), 2, 3, d)?;
    // rust: self.put(c, Self::torch(c, "west"), 11, 3, d)?;
}
    // rust: if tall {
    // rust: self.fill(c, [1, 6, d], [1, 9, d], block)?;
    // rust: self.fill(c, [12, 6, d], [12, 9, d], block)?;
}
}
    // rust: for d in (3..12).step_by(2) {
    // rust: self.fill(c, [3, 1, d], [4, 3, d], shelf)?;
    // rust: self.fill(c, [6, 1, d], [7, 3, d], shelf)?;
    // rust: self.fill(c, [9, 1, d], [10, 3, d], shelf)?;
}
    // rust: if tall {
    // rust: self.fill(c, [1, 5, 1], [3, 5, 13], planks)?;
    // rust: self.fill(c, [10, 5, 1], [12, 5, 13], planks)?;
    // rust: self.fill(c, [4, 5, 1], [9, 5, 2], planks)?;
    // rust: self.fill(c, [4, 5, 12], [9, 5, 13], planks)?;
    // rust: self.put(c, planks, 9, 5, 11)?;
    // rust: self.put(c, planks, 8, 5, 11)?;
    // rust: self.put(c, planks, 9, 5, 10)?;
    // rust: let fence = |c: &PieceContext<'_>, sides: &[&str]| {
    // rust: let props: Vec<(&str, &str)> = sides.iter().map(|s| (*s, "true")).collect();
    // rust: c.state_with("oak_fence", &props)
}
    // rust: let we = fence(c, &["west", "east"]);
    // rust: let ns = fence(c, &["north", "south"]);
    // rust: self.fill(c, [3, 6, 3], [3, 6, 11], ns)?;
    // rust: self.fill(c, [10, 6, 3], [10, 6, 9], ns)?;
    // rust: self.fill(c, [4, 6, 2], [9, 6, 2], we)?;
    // rust: self.fill(c, [4, 6, 12], [7, 6, 12], we)?;
    // rust: self.put(c, fence(c, &["north", "east"]), 3, 6, 2)?;
    // rust: self.put(c, fence(c, &["south", "east"]), 3, 6, 12)?;
    // rust: self.put(c, fence(c, &["north", "west"]), 10, 6, 2)?;
    // rust: for i in 0..=2 {
    // rust: self.put(c, fence(c, &["south", "west"]), 8 + i, 6, 12 - i)?;
    // rust: if i != 2 {
    // rust: self.put(c, fence(c, &["north", "east"]), 8 + i, 6, 11 - i)?;
}
}
    // rust: let ladder = c.state_with("ladder", &[("facing", "south")]);
    // rust: for y in 1..=7 {
    // rust: self.put(c, ladder, 10, y, 13)?;
}
    // rust: let e = fence(c, &["east"]);
    // rust: let w = fence(c, &["west"]);
    // rust: self.put(c, e, 6, 9, 7)?;
    // rust: self.put(c, w, 7, 9, 7)?;
    // rust: self.put(c, e, 6, 8, 7)?;
    // rust: self.put(c, w, 7, 8, 7)?;
    // rust: let all = fence(c, &["north", "south", "west", "east"]);
    // rust: self.put(c, all, 6, 7, 7)?;
    // rust: self.put(c, all, 7, 7, 7)?;
    // rust: self.put(c, e, 5, 7, 7)?;
    // rust: self.put(c, w, 8, 7, 7)?;
    // rust: self.put(c, fence(c, &["east", "north"]), 6, 7, 6)?;
    // rust: self.put(c, fence(c, &["east", "south"]), 6, 7, 8)?;
    // rust: self.put(c, fence(c, &["west", "north"]), 7, 7, 6)?;
    // rust: self.put(c, fence(c, &["west", "south"]), 7, 7, 8)?;
    // rust: let torch = c.state("torch");
    // rust: for (x, z) in [(5, 7), (8, 7), (6, 6), (6, 8), (7, 6), (7, 8)] {
    // rust: self.put(c, torch, x, 8, z)?;
}
}
    // rust: self.frame
    // rust: .create_chest(c, 3, 3, 5, "minecraft:chests/stronghold_library")?;
    // rust: if tall {
    // rust: self.put(c, c.state("cave_air"), 12, 9, 1)?;
    // rust: self.frame
    // rust: .create_chest(c, 12, 8, 1, "minecraft:chests/stronghold_library")?;
}
    // rust: Ok(())
}
pub fn portal_room(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.smooth_box(c, [0, 0, 0], [10, 7, 15], false)?;
    // rust: self.small_door(c, Door::Grates, 4, 1, 0)?;
    // rust: for (a, b) in [
    // rust: ([1, 6, 1], [1, 6, 14]),
    // rust: ([9, 6, 1], [9, 6, 14]),
    // rust: ([2, 6, 1], [8, 6, 2]),
    // rust: ([2, 6, 14], [8, 6, 14]),
    // rust: ([1, 1, 1], [2, 1, 4]),
    // rust: ([8, 1, 1], [9, 1, 4]),
    // rust: ] {
    // rust: self.smooth_box(c, a, b, false)?;
}
    // rust: let lava = c.state("lava");
    // rust: self.fill(c, [1, 1, 1], [1, 1, 3], lava)?;
    // rust: self.fill(c, [9, 1, 1], [9, 1, 3], lava)?;
    // rust: self.smooth_box(c, [3, 1, 8], [7, 1, 12], false)?;
    // rust: self.fill(c, [4, 1, 9], [6, 1, 11], lava)?;
    // rust: let ns = c.state_with("iron_bars", &[("north", "true"), ("south", "true")]);
    // rust: let we = c.state_with("iron_bars", &[("west", "true"), ("east", "true")]);
    // rust: for z in (3..14).step_by(2) {
    // rust: self.fill(c, [0, 3, z], [0, 4, z], ns)?;
    // rust: self.fill(c, [10, 3, z], [10, 4, z], ns)?;
}
    // rust: for x in (2..9).step_by(2) {
    // rust: self.fill(c, [x, 3, 15], [x, 4, 15], we)?;
}
    // rust: let stairs = c.state_with("stone_brick_stairs", &[("facing", "north")]);
    // rust: self.smooth_box(c, [4, 1, 5], [6, 1, 7], false)?;
    // rust: self.smooth_box(c, [4, 2, 6], [6, 2, 7], false)?;
    // rust: self.smooth_box(c, [4, 3, 7], [6, 3, 7], false)?;
    // rust: for x in 4..=6 {
    // rust: self.put(c, stairs, x, 1, 4)?;
    // rust: self.put(c, stairs, x, 2, 5)?;
    // rust: self.put(c, stairs, x, 3, 6)?;
}
    // rust: let mut eyes = [false; 12];
    // rust: for e in &mut eyes {
    // rust: *e = c.random.float() > 0.9;
}
    // rust: let frames = [
    // rust: ("north", 4, 8),
    // rust: ("north", 5, 8),
    // rust: ("north", 6, 8),
    // rust: ("south", 4, 12),
    // rust: ("south", 5, 12),
    // rust: ("south", 6, 12),
    // rust: ("east", 3, 9),
    // rust: ("east", 3, 10),
    // rust: ("east", 3, 11),
    // rust: ("west", 7, 9),
    // rust: ("west", 7, 10),
    // rust: ("west", 7, 11),
    // rust: ];
    // rust: for (i, (facing, x, z)) in frames.into_iter().enumerate() {
    // rust: let eye = if eyes[i] { "true" } else { "false" };
    // rust: let state = c.state_with("end_portal_frame", &[("facing", facing), ("eye", eye)]);
    // rust: self.put(c, state, x, 3, z)?;
}
    // rust: if eyes.iter().all(|e| *e) {
    // rust: let portal = c.state("end_portal");
    // rust: for z in 9..=11 {
    // rust: for x in 4..=6 {
    // rust: self.put(c, portal, x, 3, z)?;
}
}
}
    // rust: if !*self.placed.lock().unwrap() {
    // rust: let pos = self.frame.world_pos(5, 3, 6);
    // rust: if c.chunk_box.is_inside(pos) {
    // rust: *self.placed.lock().unwrap() = true;
    // rust: c.spawner(pos, "minecraft:silverfish")?;
}
}
    // rust: Ok(())
}
pub fn prison_hall(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.smooth_box(c, [0, 0, 0], [8, 4, 10], true)?;
    // rust: self.small_door(c, self.door, 1, 1, 0)?;
    // rust: self.air(c, [1, 1, 10], [3, 3, 10])?;
    // rust: for z in [1, 3, 7, 9] {
    // rust: self.smooth_box(c, [4, 1, z], [4, 3, z], false)?;
}
    // rust: let ns = c.state_with("iron_bars", &[("north", "true"), ("south", "true")]);
    // rust: let nse = c.state_with(
    // rust: "iron_bars",
    // rust: &[("north", "true"), ("south", "true"), ("east", "true")],
    // rust: );
    // rust: let we = c.state_with("iron_bars", &[("west", "true"), ("east", "true")]);
    // rust: for y in 1..=3 {
    // rust: self.put(c, ns, 4, y, 4)?;
    // rust: self.put(c, nse, 4, y, 5)?;
    // rust: self.put(c, ns, 4, y, 6)?;
    // rust: self.put(c, we, 5, y, 5)?;
    // rust: self.put(c, we, 6, y, 5)?;
    // rust: self.put(c, we, 7, y, 5)?;
}
    // rust: self.put(c, ns, 4, 3, 2)?;
    // rust: self.put(c, ns, 4, 3, 8)?;
    // rust: let bottom = c.state_with("iron_door", &[("facing", "west")]);
    // rust: let top = c.state_with("iron_door", &[("facing", "west"), ("half", "upper")]);
    // rust: for z in [2, 8] {
    // rust: self.put(c, bottom, 4, 1, z)?;
    // rust: self.put(c, top, 4, 2, z)?;
}
    // rust: Ok(())
}
pub fn room_crossing(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.smooth_box(c, [0, 0, 0], [10, 6, 10], true)?;
    // rust: self.small_door(c, self.door, 4, 1, 0)?;
    // rust: self.air(c, [4, 1, 10], [6, 3, 10])?;
    // rust: self.air(c, [0, 1, 4], [0, 3, 6])?;
    // rust: self.air(c, [10, 1, 4], [10, 3, 6])?;
    // rust: let bricks = c.state("stone_bricks");
    // rust: match self.value {
    // rust: 0 => {
    // rust: for y in 1..=3 {
    // rust: self.put(c, bricks, 5, y, 5)?;
}
    // rust: self.put(c, Self::torch(c, "west"), 4, 3, 5)?;
    // rust: self.put(c, Self::torch(c, "east"), 6, 3, 5)?;
    // rust: self.put(c, Self::torch(c, "south"), 5, 3, 4)?;
    // rust: self.put(c, Self::torch(c, "north"), 5, 3, 6)?;
    // rust: let slab = c.state("smooth_stone_slab");
    // rust: for (x, z) in [
    // rust: (4, 4),
    // rust: (4, 5),
    // rust: (4, 6),
    // rust: (6, 4),
    // rust: (6, 5),
    // rust: (6, 6),
    // rust: (5, 4),
    // rust: (5, 6),
    // rust: ] {
    // rust: self.put(c, slab, x, 1, z)?;
}
}
    // rust: 1 => {
    // rust: for i in 0..5 {
    // rust: self.put(c, bricks, 3, 1, 3 + i)?;
    // rust: self.put(c, bricks, 7, 1, 3 + i)?;
    // rust: self.put(c, bricks, 3 + i, 1, 3)?;
    // rust: self.put(c, bricks, 3 + i, 1, 7)?;
}
    // rust: for y in 1..=3 {
    // rust: self.put(c, bricks, 5, y, 5)?;
}
    // rust: self.put(c, c.state("water"), 5, 4, 5)?;
}
    // rust: 2 => {
    // rust: let cobble = c.state("cobblestone");
    // rust: for z in 1..=9 {
    // rust: self.put(c, cobble, 1, 3, z)?;
    // rust: self.put(c, cobble, 9, 3, z)?;
}
    // rust: for x in 1..=9 {
    // rust: self.put(c, cobble, x, 3, 1)?;
    // rust: self.put(c, cobble, x, 3, 9)?;
}
    // rust: for (x, y, z) in [
    // rust: (5, 1, 4),
    // rust: (5, 1, 6),
    // rust: (5, 3, 4),
    // rust: (5, 3, 6),
    // rust: (4, 1, 5),
    // rust: (6, 1, 5),
    // rust: (4, 3, 5),
    // rust: (6, 3, 5),
    // rust: ] {
    // rust: self.put(c, cobble, x, y, z)?;
}
    // rust: for y in 1..=3 {
    // rust: self.put(c, cobble, 4, y, 4)?;
    // rust: self.put(c, cobble, 6, y, 4)?;
    // rust: self.put(c, cobble, 4, y, 6)?;
    // rust: self.put(c, cobble, 6, y, 6)?;
}
    // rust: self.put(c, c.state("wall_torch"), 5, 3, 5)?;
    // rust: let planks = c.state("oak_planks");
    // rust: for z in 2..=8 {
    // rust: self.put(c, planks, 2, 3, z)?;
    // rust: self.put(c, planks, 3, 3, z)?;
    // rust: if z <= 3 || z >= 7 {
    // rust: self.put(c, planks, 4, 3, z)?;
    // rust: self.put(c, planks, 5, 3, z)?;
    // rust: self.put(c, planks, 6, 3, z)?;
}
    // rust: self.put(c, planks, 7, 3, z)?;
    // rust: self.put(c, planks, 8, 3, z)?;
}
    // rust: let ladder = c.state_with("ladder", &[("facing", "west")]);
    // rust: for y in 1..=3 {
    // rust: self.put(c, ladder, 9, y, 3)?;
}
    // rust: self.frame
    // rust: .create_chest(c, 3, 4, 8, "minecraft:chests/stronghold_crossing")?;
}
    // rust: _ => {}
}
    // rust: Ok(())
}
pub fn stairs_down(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.smooth_box(c, [0, 0, 0], [4, 10, 4], true)?;
    // rust: self.small_door(c, self.door, 1, 7, 0)?;
    // rust: self.small_door(c, Door::Opening, 1, 1, 4)?;
    // rust: let bricks = c.state("stone_bricks");
    // rust: let slab = c.state("smooth_stone_slab");
    // rust: for (state, x, y, z) in [
    // rust: (bricks, 2, 6, 1),
    // rust: (bricks, 1, 5, 1),
    // rust: (slab, 1, 6, 1),
    // rust: (bricks, 1, 5, 2),
    // rust: (bricks, 1, 4, 3),
    // rust: (slab, 1, 5, 3),
    // rust: (bricks, 2, 4, 3),
    // rust: (bricks, 3, 3, 3),
    // rust: (slab, 3, 4, 3),
    // rust: (bricks, 3, 3, 2),
    // rust: (bricks, 3, 2, 1),
    // rust: (slab, 3, 3, 1),
    // rust: (bricks, 2, 2, 1),
    // rust: (bricks, 1, 1, 1),
    // rust: (slab, 1, 2, 1),
    // rust: (bricks, 1, 1, 2),
    // rust: (slab, 1, 1, 3),
    // rust: ] {
    // rust: self.put(c, state, x, y, z)?;
}
    // rust: Ok(())
}
pub fn straight(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.smooth_box(c, [0, 0, 0], [4, 4, 6], true)?;
    // rust: self.small_door(c, self.door, 1, 1, 0)?;
    // rust: self.small_door(c, Door::Opening, 1, 1, 6)?;
    // rust: let east = Self::torch(c, "east");
    // rust: let west = Self::torch(c, "west");
    // rust: self.frame.maybe_block(c, 0.1, 1, 2, 1, east)?;
    // rust: self.frame.maybe_block(c, 0.1, 3, 2, 1, west)?;
    // rust: self.frame.maybe_block(c, 0.1, 1, 2, 5, east)?;
    // rust: self.frame.maybe_block(c, 0.1, 3, 2, 5, west)?;
    // rust: if self.flags[0] {
    // rust: self.air(c, [0, 1, 2], [0, 3, 4])?;
}
    // rust: if self.flags[1] {
    // rust: self.air(c, [4, 1, 2], [4, 3, 4])?;
}
    // rust: Ok(())
}
pub fn straight_stairs_down(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.smooth_box(c, [0, 0, 0], [4, 10, 7], true)?;
    // rust: self.small_door(c, self.door, 1, 7, 0)?;
    // rust: self.small_door(c, Door::Opening, 1, 1, 7)?;
    // rust: let stairs = c.state_with("cobblestone_stairs", &[("facing", "south")]);
    // rust: let bricks = c.state("stone_bricks");
    // rust: for i in 0..6 {
    // rust: for x in 1..=3 {
    // rust: self.put(c, stairs, x, 6 - i, 1 + i)?;
}
    // rust: if i < 5 {
    // rust: for x in 1..=3 {
    // rust: self.put(c, bricks, x, 5 - i, 1 + i)?;
}
}
}
    // rust: Ok(())
}
}
    // rust: impl LegacyPiece for StrongholdPiece {
pub fn bounding_box(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.frame.bounding_box
}
pub fn save(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::nbt::Tag;
    // rust: let flag = |b: bool| Tag::Byte(i8::from(b));
    // rust: let mut tag = super::legacy::piece_tag(
    // rust: self.type_name(),
    // rust: self.frame.bounding_box,
    // rust: self.frame.orientation,
    // rust: self.depth,
    // rust: );
        // SmallDoorType.LEGACY_CODEC: the enum name.
    // rust: let door = match self.door {
    // rust: Door::Opening => "OPENING",
    // rust: Door::Wood => "WOOD_DOOR",
    // rust: Door::Grates => "GRATES",
    // rust: Door::Iron => "IRON_DOOR",
}
    // rust: let placed = *self.placed.lock().unwrap();
    // rust: let [a, b, c, d] = self.flags;
    // rust: let mut entries = vec![("EntryDoor", Tag::String(door.into()))];
    // rust: match self.kind {
    // rust: Kind::ChestCorridor => entries.push(("Chest", flag(placed))),
    // rust: Kind::Filler => entries.push(("Steps", Tag::Int(self.value))),
    // rust: Kind::FiveCrossing => entries.extend([
    // rust: ("leftLow", flag(a)),
    // rust: ("leftHigh", flag(b)),
    // rust: ("rightLow", flag(c)),
    // rust: ("rightHigh", flag(d)),
    // rust: ]),
    // rust: Kind::Library => entries.push(("Tall", flag(a))),
    // rust: Kind::PortalRoom => entries.push(("Mob", flag(placed))),
    // rust: Kind::RoomCrossing => entries.push(("Type", Tag::Int(self.value))),
            // StartPiece is a StairsDown that is the source.
    // rust: Kind::StairsDown => entries.push(("Source", flag(false))),
    // rust: Kind::Start => entries.push(("Source", flag(true))),
    // rust: Kind::Straight => entries.extend([("Left", flag(a)), ("Right", flag(b))]),
    // rust: _ => {}
}
    // rust: for (key, value) in entries {
    // rust: tag.insert(key.into(), value);
}
    // rust: Some(tag)
}
pub fn type_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.kind {
    // rust: Kind::Straight => "minecraft:shs",
    // rust: Kind::PrisonHall => "minecraft:shph",
    // rust: Kind::LeftTurn => "minecraft:shlt",
    // rust: Kind::RightTurn => "minecraft:shrt",
    // rust: Kind::RoomCrossing => "minecraft:shrc",
    // rust: Kind::StraightStairsDown => "minecraft:shssd",
    // rust: Kind::StairsDown => "minecraft:shsd",
    // rust: Kind::FiveCrossing => "minecraft:sh5c",
    // rust: Kind::ChestCorridor => "minecraft:shcc",
    // rust: Kind::Library => "minecraft:shli",
    // rust: Kind::PortalRoom => "minecraft:shpr",
    // rust: Kind::Filler => "minecraft:shfc",
    // rust: Kind::Start => "minecraft:shstart",
}
}
pub fn post_process(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.kind {
    // rust: Kind::Straight => self.straight(c),
    // rust: Kind::PrisonHall => self.prison_hall(c),
    // rust: Kind::LeftTurn => self.turn(c, true),
    // rust: Kind::RightTurn => self.turn(c, false),
    // rust: Kind::RoomCrossing => self.room_crossing(c),
    // rust: Kind::StraightStairsDown => self.straight_stairs_down(c),
    // rust: Kind::StairsDown | Kind::Start => self.stairs_down(c),
    // rust: Kind::FiveCrossing => self.five_crossing(c),
    // rust: Kind::ChestCorridor => self.chest_corridor(c),
    // rust: Kind::Library => self.library(c),
    // rust: Kind::PortalRoom => self.portal_room(c),
    // rust: Kind::Filler => self.filler(c),
}
}
}
