//! Transpiled from Horizon Rust crate
//! Module: horizon-world_fortress
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Nether fortresses: NetherFortressStructure and NetherFortressPieces.
// use super::{
    // rust: BoundingBox,
    // rust: legacy::{LegacyPiece, PieceContext, PieceFrame, Result, make_bounding_box, random_horizontal},
    // rust: stronghold::orient_box,
}
// use crate::registry::BlockStateId;
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: random::{LegacyRandom, RandomSource},
}
// use std::sync::Mutex;

pub const Kind = enum {
    BridgeStraight,
    BridgeCrossing,
    RoomCrossing,
    StairsRoom,
    MonsterThrone,
    CastleEntrance,
    SmallCorridor,
    SmallCorridorCrossing,
    SmallCorridorRightTurn,
    SmallCorridorLeftTurn,
    CorridorStairs,
    CorridorTBalcony,
    StalkRoom,
    BridgeEndFiller,
    Start,
};
/// PieceWeight: kind, weight, max place count, allow in row.
    // rust: type Weight = (Kind, i32, i32, bool);
    // rust: const BRIDGE_WEIGHTS: [Weight; 6] = [
    // rust: (Kind::BridgeStraight, 30, 0, true),
    // rust: (Kind::BridgeCrossing, 10, 4, false),
    // rust: (Kind::RoomCrossing, 10, 4, false),
    // rust: (Kind::StairsRoom, 10, 3, false),
    // rust: (Kind::MonsterThrone, 5, 2, false),
    // rust: (Kind::CastleEntrance, 5, 1, false),
    // rust: ];
    // rust: const CASTLE_WEIGHTS: [Weight; 7] = [
    // rust: (Kind::SmallCorridor, 25, 0, true),
    // rust: (Kind::SmallCorridorCrossing, 15, 5, false),
    // rust: (Kind::SmallCorridorRightTurn, 5, 10, false),
    // rust: (Kind::SmallCorridorLeftTurn, 5, 10, false),
    // rust: (Kind::CorridorStairs, 10, 3, true),
    // rust: (Kind::CorridorTBalcony, 7, 2, false),
    // rust: (Kind::StalkRoom, 5, 2, false),
    // rust: ];

pub const FortressPiece = struct {
    kind: Kind,
    frame: PieceFrame,
    depth: i32,
    /// BridgeEndFiller.selfSeed.
    seed: i32,
    /// Corridor turns: isNeedingChest; MonsterThrone: hasPlacedSpawner.
    flag: Mutex<bool>,
};

pub fn int(r: *mut impl RandomSource, bound: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.next_int_bound(bound).unwrap_or(0)
}

pub const Builder = struct {
    pieces: std.ArrayList(FortressPiece),
    /// (weight, place count) for the bridge and castle lists.
    bridge: Vec<(Weight,
    castle: Vec<(Weight,
    previous: ?Kind,
    pending: std.ArrayList(usize),
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
pub fn piece(kind: Kind, b: BoundingBox, d: Direction, depth: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FortressPiece {
    // rust: kind,
    // rust: frame: PieceFrame::new(b, Some(d)),
    // rust: depth,
    // rust: seed: 0,
    // rust: flag: Mutex::new(false),
}
}
    /// findAndCreateBridgePieceFactory / BridgeEndFiller.createPiece.
    // rust: fn create(
    // rust: &self,
    // rust: kind: Kind,
    // rust: r: &mut impl RandomSource,
    // rust: foot: [i32; 3],
    // rust: d: Direction,
    // rust: depth: i32,
    // rust: ) -> Option<FortressPiece> {
    // rust: let (offset, size) = match kind {
    // rust: Kind::BridgeStraight => ([-1, -3, 0], [5, 10, 19]),
    // rust: Kind::BridgeCrossing => ([-8, -3, 0], [19, 10, 19]),
    // rust: Kind::RoomCrossing => ([-2, 0, 0], [7, 9, 7]),
    // rust: Kind::StairsRoom => ([-2, 0, 0], [7, 11, 7]),
    // rust: Kind::MonsterThrone => ([-2, 0, 0], [7, 8, 9]),
    // rust: Kind::CastleEntrance | Kind::StalkRoom => ([-5, -3, 0], [13, 14, 13]),
    // rust: Kind::SmallCorridor
    // rust: | Kind::SmallCorridorCrossing
    // rust: | Kind::SmallCorridorRightTurn
    // rust: | Kind::SmallCorridorLeftTurn => ([-1, 0, 0], [5, 7, 5]),
    // rust: Kind::CorridorStairs => ([-1, -7, 0], [5, 14, 10]),
    // rust: Kind::CorridorTBalcony => ([-3, 0, 0], [9, 7, 9]),
    // rust: Kind::BridgeEndFiller => ([-1, -3, 0], [5, 10, 8]),
    // rust: Kind::Start => return None,
}
    // rust: let b = orient_box(foot, offset, size, d);
    // rust: if b.min[1] <= 10 || self.collides(&b) {
    // rust: return None;
}
    // rust: let mut piece = Self::piece(kind, b, d, depth);
    // rust: match kind {
    // rust: Kind::BridgeEndFiller => piece.seed = r.next_int(),
    // rust: Kind::SmallCorridorRightTurn | Kind::SmallCorridorLeftTurn => {
    // rust: piece.flag = Mutex::new(int(r, 3) == 0)
}
    // rust: _ => {}
}
    // rust: Some(piece)
}
    /// NetherBridgePiece.generatePiece.
    // rust: fn generate_piece(
    // rust: &mut self,
    // rust: castle: bool,
    // rust: r: &mut impl RandomSource,
    // rust: foot: [i32; 3],
    // rust: d: Direction,
    // rust: depth: i32,
    // rust: ) -> Option<FortressPiece> {
    // rust: let list = if castle { &self.castle } else { &self.bridge };
    // rust: let any = list.iter().any(|(w, n)| w.2 > 0 && *n < w.2);
    // rust: let total: i32 = list.iter().map(|(w, _)| w.1).sum();
    // rust: let total = if any { total } else { -1 };
    // rust: if total > 0 && depth <= 30 {
    // rust: for _ in 0..5 {
    // rust: let mut selection = int(r, total);
    // rust: let len = if castle {
    // rust: self.castle.len()
    // rust: } else {
    // rust: self.bridge.len()
}
    // rust: for i in 0..len {
    // rust: let ((kind, weight, max, allow_in_row), count) = if castle {
    // rust: self.castle[i]
    // rust: } else {
    // rust: self.bridge[i]
}
    // rust: selection -= weight;
    // rust: if selection < 0 {
    // rust: let place = max == 0 || count < max;
    // rust: if !place || (self.previous == Some(kind) && !allow_in_row) {
    // rust: break;
}
    // rust: if let Some(piece) = self.create(kind, r, foot, d, depth) {
    // rust: let list = if castle {
    // rust: &mut self.castle
    // rust: } else {
    // rust: &mut self.bridge
}
    // rust: list[i].1 += 1;
    // rust: self.previous = Some(kind);
    // rust: if max != 0 && count + 1 >= max {
    // rust: list.remove(i);
}
    // rust: return Some(piece);
}
}
}
}
}
    // rust: self.create(Kind::BridgeEndFiller, r, foot, d, depth)
}
    /// NetherBridgePiece.generateAndAddPiece.
    // rust: fn add(
    // rust: &mut self,
    // rust: r: &mut impl RandomSource,
    // rust: foot: [i32; 3],
    // rust: d: Direction,
    // rust: depth: i32,
    // rust: castle: bool,
    // rust: ) {
    // rust: let start = self.pieces[0].frame.bounding_box;
    // rust: if (foot[0] - start.min[0]).abs() <= 112 && (foot[2] - start.min[2]).abs() <= 112 {
    // rust: if let Some(piece) = self.generate_piece(castle, r, foot, d, depth + 1) {
    // rust: self.pieces.push(piece);
    // rust: self.pending.push(self.pieces.len() - 1);
}
    // rust: } else {
            // The end filler is created (drawing its seed) but never added.
    // rust: let _ = self.create(Kind::BridgeEndFiller, r, foot, d, depth);
}
}
    // rust: fn forward(
    // rust: &mut self,
    // rust: r: &mut impl RandomSource,
    // rust: i: usize,
    // rust: x_off: i32,
    // rust: y_off: i32,
    // rust: castle: bool,
    // rust: ) {
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
    // rust: self.add(r, foot, o, depth, castle);
}
    // rust: fn side(
    // rust: &mut self,
    // rust: r: &mut impl RandomSource,
    // rust: i: usize,
    // rust: right: bool,
    // rust: y_off: i32,
    // rust: z_off: i32,
    // rust: castle: bool,
    // rust: ) {
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
    // rust: self.add(r, foot, d, depth, castle);
}
pub fn add_children(self: *Self, r: *mut impl RandomSource, i: usize) void {
}
    // rust: let p = &self.pieces[i];
    // rust: let (kind, o) = (p.kind, p.frame.orientation);
    // rust: match kind {
    // rust: Kind::Start | Kind::BridgeCrossing => {
    // rust: self.forward(r, i, 8, 3, false);
    // rust: self.side(r, i, false, 3, 8, false);
    // rust: self.side(r, i, true, 3, 8, false);
}
    // rust: Kind::BridgeStraight => self.forward(r, i, 1, 3, false),
    // rust: Kind::CorridorStairs | Kind::SmallCorridor => self.forward(r, i, 1, 0, true),
    // rust: Kind::CorridorTBalcony => {
    // rust: let z_off = if matches!(o, Some(Direction::West | Direction::North)) {
    // rust: 5
    // rust: } else {
    // rust: 1
}
    // rust: let castle = int(r, 8) > 0;
    // rust: self.side(r, i, false, 0, z_off, castle);
    // rust: let castle = int(r, 8) > 0;
    // rust: self.side(r, i, true, 0, z_off, castle);
}
    // rust: Kind::CastleEntrance => self.forward(r, i, 5, 3, true),
    // rust: Kind::SmallCorridorCrossing => {
    // rust: self.forward(r, i, 1, 0, true);
    // rust: self.side(r, i, false, 0, 1, true);
    // rust: self.side(r, i, true, 0, 1, true);
}
    // rust: Kind::SmallCorridorLeftTurn => self.side(r, i, false, 0, 1, true),
    // rust: Kind::SmallCorridorRightTurn => self.side(r, i, true, 0, 1, true),
    // rust: Kind::StalkRoom => {
    // rust: self.forward(r, i, 5, 3, true);
    // rust: self.forward(r, i, 5, 11, true);
}
    // rust: Kind::RoomCrossing => {
    // rust: self.forward(r, i, 2, 0, false);
    // rust: self.side(r, i, false, 0, 2, false);
    // rust: self.side(r, i, true, 0, 2, false);
}
    // rust: Kind::StairsRoom => self.side(r, i, true, 6, 2, false),
    // rust: Kind::MonsterThrone | Kind::BridgeEndFiller => {}
}
}
}

/// NetherFortressStructure.generatePieces.
pub fn generate(random: *mut impl RandomSource, chunk: [i32; 2]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = random_horizontal(random);
    // rust: let b = make_bounding_box(chunk[0] * 16 + 2, 64, chunk[1] * 16 + 2, d, 19, 10, 19);
    // rust: let mut g = Builder {
    // rust: pieces: vec![Builder::piece(Kind::Start, b, d, 0)],
    // rust: bridge: BRIDGE_WEIGHTS.iter().map(|w| (*w, 0)).collect(),
    // rust: castle: CASTLE_WEIGHTS.iter().map(|w| (*w, 0)).collect(),
    // rust: previous: None,
    // rust: pending: Vec::new(),
}
    // rust: g.add_children(random, 0);
    // rust: while !g.pending.is_empty() {
    // rust: let index = int(random, g.pending.len() as i32) as usize;
    // rust: let next = g.pending.remove(index);
    // rust: g.add_children(random, next);
}
    // StructurePiecesBuilder.moveInsideHeights(random, 48, 70).
    // rust: let mut all = g.pieces[0].frame.bounding_box;
    // rust: for p in &g.pieces[1..] {
    // rust: all.encapsulate(&p.frame.bounding_box);
}
    // rust: let span = 70 - 48 + 1 - all.span()[1];
    // rust: let y = if span > 1 { 48 + int(random, span) } else { 48 };
    // rust: let dy = y - all.min[1];
    // rust: for p in &mut g.pieces {
    // rust: p.frame.bounding_box = p.frame.bounding_box.moved([0, dy, 0]);
}
    // rust: g.pieces
}

/// Block states used by the fortress pieces.
pub const Palette = struct {
    bricks: BlockStateId,
    air: BlockStateId,
    fence: BlockStateId,
    ns: BlockStateId,
    we: BlockStateId,
    nse: BlockStateId,
    nsw: BlockStateId,
};
pub fn fence(c: *PieceContext<'_>, sides: *[[]const u8]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let props: Vec<(&str, &str)> = sides.iter().map(|s| (*s, "true")).collect();
    // rust: c.state_with("nether_brick_fence", &props)
}
    // rust: impl Palette {
pub fn new(c: *PieceContext<'_>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: bricks: c.state("nether_bricks"),
    // rust: air: c.state("air"),
    // rust: fence: c.state("nether_brick_fence"),
    // rust: ns: fence(c, &["north", "south"]),
    // rust: we: fence(c, &["west", "east"]),
    // rust: nse: fence(c, &["north", "south", "east"]),
    // rust: nsw: fence(c, &["north", "south", "west"]),
}
}
}

    // rust: impl FortressPiece {
    // rust: fn bx(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: [x0, y0, z0, x1, y1, z1]: [i32; 6],
    // rust: s: BlockStateId,
    // rust: ) -> Result<()> {
    // rust: self.frame
    // rust: .generate_box(c, [x0, y0, z0], [x1, y1, z1], s, s, false)
}
pub fn put(self: *Self, c: *mut PieceContext<'_>, s: BlockStateId, x: i32, y: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.frame.place(c, s, x, y, z)
}
pub fn column(self: *Self, c: *mut PieceContext<'_>, p: *Palette, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.frame.fill_column_down(c, p.bricks, x, -1, z)
}
    // rust: fn columns(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: p: &Palette,
    // rust: xs: [i32; 2],
    // rust: zs: [i32; 2],
    // rust: ) -> Result<()> {
    // rust: for x in xs[0]..=xs[1] {
    // rust: for z in zs[0]..=zs[1] {
    // rust: self.column(c, p, x, z)?;
}
}
    // rust: Ok(())
}
pub fn bridge_crossing(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: self.bx(c, [7, 3, 0, 11, 4, 18], b)?;
    // rust: self.bx(c, [0, 3, 7, 18, 4, 11], b)?;
    // rust: self.bx(c, [8, 5, 0, 10, 7, 18], p.air)?;
    // rust: self.bx(c, [0, 5, 8, 18, 7, 10], p.air)?;
    // rust: for r in [
    // rust: [7, 5, 0, 7, 5, 7],
    // rust: [7, 5, 11, 7, 5, 18],
    // rust: [11, 5, 0, 11, 5, 7],
    // rust: [11, 5, 11, 11, 5, 18],
    // rust: [0, 5, 7, 7, 5, 7],
    // rust: [11, 5, 7, 18, 5, 7],
    // rust: [0, 5, 11, 7, 5, 11],
    // rust: [11, 5, 11, 18, 5, 11],
    // rust: [7, 2, 0, 11, 2, 5],
    // rust: [7, 2, 13, 11, 2, 18],
    // rust: [7, 0, 0, 11, 1, 3],
    // rust: [7, 0, 15, 11, 1, 18],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: for x in 7..=11 {
    // rust: for z in 0..=2 {
    // rust: self.column(c, p, x, z)?;
    // rust: self.column(c, p, x, 18 - z)?;
}
}
    // rust: for r in [
    // rust: [0, 2, 7, 5, 2, 11],
    // rust: [13, 2, 7, 18, 2, 11],
    // rust: [0, 0, 7, 3, 1, 11],
    // rust: [15, 0, 7, 18, 1, 11],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: for x in 0..=2 {
    // rust: for z in 7..=11 {
    // rust: self.column(c, p, x, z)?;
    // rust: self.column(c, p, 18 - x, z)?;
}
}
    // rust: Ok(())
}
pub fn end_filler(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = LegacyRandom::new(i64::from(self.seed));
    // rust: let b = p.bricks;
    // rust: for x in 0..=4 {
    // rust: for y in 3..=4 {
    // rust: let z = int(&mut r, 8);
    // rust: self.bx(c, [x, y, 0, x, y, z], b)?;
}
}
    // rust: let z = int(&mut r, 8);
    // rust: self.bx(c, [0, 5, 0, 0, 5, z], b)?;
    // rust: let z = int(&mut r, 8);
    // rust: self.bx(c, [4, 5, 0, 4, 5, z], b)?;
    // rust: for x in 0..=4 {
    // rust: let z = int(&mut r, 5);
    // rust: self.bx(c, [x, 2, 0, x, 2, z], b)?;
}
    // rust: for x in 0..=4 {
    // rust: for y in 0..=1 {
    // rust: let z = int(&mut r, 3);
    // rust: self.bx(c, [x, y, 0, x, y, z], b)?;
}
}
    // rust: Ok(())
}
pub fn bridge_straight(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: self.bx(c, [0, 3, 0, 4, 4, 18], b)?;
    // rust: self.bx(c, [1, 5, 0, 3, 7, 18], p.air)?;
    // rust: for r in [
    // rust: [0, 5, 0, 0, 5, 18],
    // rust: [4, 5, 0, 4, 5, 18],
    // rust: [0, 2, 0, 4, 2, 5],
    // rust: [0, 2, 13, 4, 2, 18],
    // rust: [0, 0, 0, 4, 1, 3],
    // rust: [0, 0, 15, 4, 1, 18],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: for x in 0..=4 {
    // rust: for z in 0..=2 {
    // rust: self.column(c, p, x, z)?;
    // rust: self.column(c, p, x, 18 - z)?;
}
}
    // rust: for r in [
    // rust: [0, 1, 1, 0, 4, 1],
    // rust: [0, 3, 4, 0, 4, 4],
    // rust: [0, 3, 14, 0, 4, 14],
    // rust: [0, 1, 17, 0, 4, 17],
    // rust: ] {
    // rust: self.bx(c, r, p.nse)?;
}
    // rust: for r in [
    // rust: [4, 1, 1, 4, 4, 1],
    // rust: [4, 3, 4, 4, 4, 4],
    // rust: [4, 3, 14, 4, 4, 14],
    // rust: [4, 1, 17, 4, 4, 17],
    // rust: ] {
    // rust: self.bx(c, r, p.nsw)?;
}
    // rust: Ok(())
}
pub fn corridor_stairs(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stairs = c.state_with("nether_brick_stairs", &[("facing", "south")]);
    // rust: let b = p.bricks;
    // rust: for step in 0..=9 {
    // rust: let floor = (7 - step).max(1);
    // rust: let roof = (floor + 5).max(14 - step).min(13);
    // rust: let z = step;
    // rust: self.bx(c, [0, 0, z, 4, floor, z], b)?;
    // rust: self.bx(c, [1, floor + 1, z, 3, roof - 1, z], p.air)?;
    // rust: if step <= 6 {
    // rust: for x in 1..=3 {
    // rust: self.put(c, stairs, x, floor + 1, z)?;
}
}
    // rust: self.bx(c, [0, roof, z, 4, roof, z], b)?;
    // rust: self.bx(c, [0, floor + 1, z, 0, roof - 1, z], b)?;
    // rust: self.bx(c, [4, floor + 1, z, 4, roof - 1, z], b)?;
    // rust: if step & 1 == 0 {
    // rust: self.bx(c, [0, floor + 2, z, 0, floor + 3, z], p.ns)?;
    // rust: self.bx(c, [4, floor + 2, z, 4, floor + 3, z], p.ns)?;
}
    // rust: for x in 0..=4 {
    // rust: self.column(c, p, x, z)?;
}
}
    // rust: Ok(())
}
pub fn t_balcony(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: self.bx(c, [0, 0, 0, 8, 1, 8], b)?;
    // rust: self.bx(c, [0, 2, 0, 8, 5, 8], p.air)?;
    // rust: self.bx(c, [0, 6, 0, 8, 6, 5], b)?;
    // rust: self.bx(c, [0, 2, 0, 2, 5, 0], b)?;
    // rust: self.bx(c, [6, 2, 0, 8, 5, 0], b)?;
    // rust: self.bx(c, [1, 3, 0, 1, 4, 0], p.we)?;
    // rust: self.bx(c, [7, 3, 0, 7, 4, 0], p.we)?;
    // rust: self.bx(c, [0, 2, 4, 8, 2, 8], b)?;
    // rust: self.bx(c, [1, 1, 4, 2, 2, 4], p.air)?;
    // rust: self.bx(c, [6, 1, 4, 7, 2, 4], p.air)?;
    // rust: self.bx(c, [1, 3, 8, 7, 3, 8], p.we)?;
    // rust: self.put(c, fence(c, &["east", "south"]), 0, 3, 8)?;
    // rust: self.put(c, fence(c, &["west", "south"]), 8, 3, 8)?;
    // rust: self.bx(c, [0, 3, 6, 0, 3, 7], p.ns)?;
    // rust: self.bx(c, [8, 3, 6, 8, 3, 7], p.ns)?;
    // rust: self.bx(c, [0, 3, 4, 0, 5, 5], b)?;
    // rust: self.bx(c, [8, 3, 4, 8, 5, 5], b)?;
    // rust: self.bx(c, [1, 3, 5, 2, 5, 5], b)?;
    // rust: self.bx(c, [6, 3, 5, 7, 5, 5], b)?;
    // rust: self.bx(c, [1, 4, 5, 1, 5, 5], p.we)?;
    // rust: self.bx(c, [7, 4, 5, 7, 5, 5], p.we)?;
    // rust: for z in 0..=5 {
    // rust: for x in 0..=8 {
    // rust: self.column(c, p, x, z)?;
}
}
    // rust: Ok(())
}
    /// The walls, roof and battlements shared by CastleEntrance and CastleStalkRoom.
pub fn castle_hall(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: self.bx(c, [0, 3, 0, 12, 4, 12], b)?;
    // rust: self.bx(c, [0, 5, 0, 12, 13, 12], p.air)?;
    // rust: for r in [
    // rust: [0, 5, 0, 1, 12, 12],
    // rust: [11, 5, 0, 12, 12, 12],
    // rust: [2, 5, 11, 4, 12, 12],
    // rust: [8, 5, 11, 10, 12, 12],
    // rust: [5, 9, 11, 7, 12, 12],
    // rust: [2, 5, 0, 4, 12, 1],
    // rust: [8, 5, 0, 10, 12, 1],
    // rust: [5, 9, 0, 7, 12, 1],
    // rust: [2, 11, 2, 10, 12, 10],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: Ok(())
}
pub fn battlements(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: for i in (1..=11).step_by(2) {
    // rust: self.bx(c, [i, 10, 0, i, 11, 0], p.we)?;
    // rust: self.bx(c, [i, 10, 12, i, 11, 12], p.we)?;
    // rust: self.bx(c, [0, 10, i, 0, 11, i], p.ns)?;
    // rust: self.bx(c, [12, 10, i, 12, 11, i], p.ns)?;
    // rust: self.put(c, b, i, 13, 0)?;
    // rust: self.put(c, b, i, 13, 12)?;
    // rust: self.put(c, b, 0, 13, i)?;
    // rust: self.put(c, b, 12, 13, i)?;
    // rust: if i != 11 {
    // rust: self.put(c, p.we, i + 1, 13, 0)?;
    // rust: self.put(c, p.we, i + 1, 13, 12)?;
    // rust: self.put(c, p.ns, 0, 13, i + 1)?;
    // rust: self.put(c, p.ns, 12, 13, i + 1)?;
}
}
    // rust: self.put(c, fence(c, &["north", "east"]), 0, 13, 0)?;
    // rust: self.put(c, fence(c, &["south", "east"]), 0, 13, 12)?;
    // rust: self.put(c, fence(c, &["south", "west"]), 12, 13, 12)?;
    // rust: self.put(c, fence(c, &["north", "west"]), 12, 13, 0)?;
    // rust: Ok(())
}
    /// The floor and supports shared by CastleEntrance and CastleStalkRoom.
pub fn castle_floor(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: for r in [
    // rust: [4, 2, 0, 8, 2, 12],
    // rust: [0, 2, 4, 12, 2, 8],
    // rust: [4, 0, 0, 8, 1, 3],
    // rust: [4, 0, 9, 8, 1, 12],
    // rust: [0, 0, 4, 3, 1, 8],
    // rust: [9, 0, 4, 12, 1, 8],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: for x in 4..=8 {
    // rust: for z in 0..=2 {
    // rust: self.column(c, p, x, z)?;
    // rust: self.column(c, p, x, 12 - z)?;
}
}
    // rust: for x in 0..=2 {
    // rust: for z in 4..=8 {
    // rust: self.column(c, p, x, z)?;
    // rust: self.column(c, p, 12 - x, z)?;
}
}
    // rust: Ok(())
}
pub fn castle_entrance(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.castle_hall(c, p)?;
    // rust: self.bx(c, [5, 8, 0, 7, 8, 0], p.fence)?;
    // rust: self.battlements(c, p)?;
    // rust: for z in (3..=9).step_by(2) {
    // rust: self.bx(c, [1, 7, z, 1, 8, z], p.nsw)?;
    // rust: self.bx(c, [11, 7, z, 11, 8, z], p.nse)?;
}
    // rust: self.castle_floor(c, p)?;
    // rust: self.bx(c, [5, 5, 5, 7, 5, 7], p.bricks)?;
    // rust: self.bx(c, [6, 1, 6, 6, 4, 6], p.air)?;
    // rust: self.put(c, p.bricks, 6, 0, 6)?;
        // The lava source's scheduled tick has no generation-time effect.
    // rust: self.put(c, c.state("lava"), 6, 5, 6)
}
pub fn stalk_room(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: self.castle_hall(c, p)?;
    // rust: self.battlements(c, p)?;
    // rust: for z in (3..=9).step_by(2) {
    // rust: self.bx(c, [1, 7, z, 1, 8, z], p.nsw)?;
    // rust: self.bx(c, [11, 7, z, 11, 8, z], p.nse)?;
}
    // rust: let stairs = c.state_with("nether_brick_stairs", &[("facing", "north")]);
    // rust: for i in 0..=6 {
    // rust: let z = i + 4;
    // rust: for x in 5..=7 {
    // rust: self.put(c, stairs, x, 5 + i, z)?;
}
    // rust: if (5..=8).contains(&z) {
    // rust: self.bx(c, [5, 5, z, 7, i + 4, z], b)?;
    // rust: } else if (9..=10).contains(&z) {
    // rust: self.bx(c, [5, 8, z, 7, i + 4, z], b)?;
}
    // rust: if i >= 1 {
    // rust: self.bx(c, [5, 6 + i, z, 7, 9 + i, z], p.air)?;
}
}
    // rust: for x in 5..=7 {
    // rust: self.put(c, stairs, x, 12, 11)?;
}
    // rust: self.bx(c, [5, 6, 7, 5, 7, 7], p.nse)?;
    // rust: self.bx(c, [7, 6, 7, 7, 7, 7], p.nsw)?;
    // rust: self.bx(c, [5, 13, 12, 7, 13, 12], p.air)?;
    // rust: for r in [
    // rust: [2, 5, 2, 3, 5, 3],
    // rust: [2, 5, 9, 3, 5, 10],
    // rust: [2, 5, 4, 2, 5, 8],
    // rust: [9, 5, 2, 10, 5, 3],
    // rust: [9, 5, 9, 10, 5, 10],
    // rust: [10, 5, 4, 10, 5, 8],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: let east = c.state_with("nether_brick_stairs", &[("facing", "east")]);
    // rust: let west = c.state_with("nether_brick_stairs", &[("facing", "west")]);
    // rust: for z in [2, 3, 9, 10] {
    // rust: self.put(c, west, 4, 5, z)?;
}
    // rust: for z in [2, 3, 9, 10] {
    // rust: self.put(c, east, 8, 5, z)?;
}
    // rust: let soul_sand = c.state("soul_sand");
    // rust: let wart = c.state("nether_wart");
    // rust: self.bx(c, [3, 4, 4, 4, 4, 8], soul_sand)?;
    // rust: self.bx(c, [8, 4, 4, 9, 4, 8], soul_sand)?;
    // rust: self.bx(c, [3, 5, 4, 4, 5, 8], wart)?;
    // rust: self.bx(c, [8, 5, 4, 9, 5, 8], wart)?;
    // rust: self.castle_floor(c, p)
}
pub fn corridor_floor(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.bx(c, [0, 0, 0, 4, 1, 4], p.bricks)?;
    // rust: self.bx(c, [0, 2, 0, 4, 5, 4], p.air)
}
pub fn corridor_roof(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.bx(c, [0, 6, 0, 4, 6, 4], p.bricks)?;
    // rust: self.columns(c, p, [0, 4], [0, 4])
}
pub fn corridor_crossing(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.corridor_floor(c, p)?;
    // rust: for r in [
    // rust: [0, 2, 0, 0, 5, 0],
    // rust: [4, 2, 0, 4, 5, 0],
    // rust: [0, 2, 4, 0, 5, 4],
    // rust: [4, 2, 4, 4, 5, 4],
    // rust: ] {
    // rust: self.bx(c, r, p.bricks)?;
}
    // rust: self.corridor_roof(c, p)
}
pub fn corridor_chest(self: *Self, c: *mut PieceContext<'_>, z]: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut needed = self.flag.lock().unwrap();
    // rust: if *needed && c.chunk_box.is_inside(self.frame.world_pos(x, y, z)) {
    // rust: *needed = false;
    // rust: self.frame
    // rust: .create_chest(c, x, y, z, "minecraft:chests/nether_bridge")?;
}
    // rust: Ok(())
}
pub fn corridor_left(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.corridor_floor(c, p)?;
    // rust: let b = p.bricks;
    // rust: self.bx(c, [4, 2, 0, 4, 5, 4], b)?;
    // rust: self.bx(c, [4, 3, 1, 4, 4, 1], p.ns)?;
    // rust: self.bx(c, [4, 3, 3, 4, 4, 3], p.ns)?;
    // rust: self.bx(c, [0, 2, 0, 0, 5, 0], b)?;
    // rust: self.bx(c, [0, 2, 4, 3, 5, 4], b)?;
    // rust: self.bx(c, [1, 3, 4, 1, 4, 4], p.we)?;
    // rust: self.bx(c, [3, 3, 4, 3, 4, 4], p.we)?;
    // rust: self.corridor_chest(c, [3, 2, 3])?;
    // rust: self.corridor_roof(c, p)
}
pub fn corridor(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.corridor_floor(c, p)?;
    // rust: let b = p.bricks;
    // rust: self.bx(c, [0, 2, 0, 0, 5, 4], b)?;
    // rust: self.bx(c, [4, 2, 0, 4, 5, 4], b)?;
    // rust: for r in [
    // rust: [0, 3, 1, 0, 4, 1],
    // rust: [0, 3, 3, 0, 4, 3],
    // rust: [4, 3, 1, 4, 4, 1],
    // rust: [4, 3, 3, 4, 4, 3],
    // rust: ] {
    // rust: self.bx(c, r, p.ns)?;
}
    // rust: self.corridor_roof(c, p)
}
pub fn corridor_right(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.corridor_floor(c, p)?;
    // rust: let b = p.bricks;
    // rust: self.bx(c, [0, 2, 0, 0, 5, 4], b)?;
    // rust: self.bx(c, [0, 3, 1, 0, 4, 1], p.ns)?;
    // rust: self.bx(c, [0, 3, 3, 0, 4, 3], p.ns)?;
    // rust: self.bx(c, [4, 2, 0, 4, 5, 0], b)?;
    // rust: self.bx(c, [1, 2, 4, 4, 5, 4], b)?;
    // rust: self.bx(c, [1, 3, 4, 1, 4, 4], p.we)?;
    // rust: self.bx(c, [3, 3, 4, 3, 4, 4], p.we)?;
    // rust: self.corridor_chest(c, [1, 2, 3])?;
    // rust: self.corridor_roof(c, p)
}
pub fn monster_throne(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: self.bx(c, [0, 2, 0, 6, 7, 7], p.air)?;
    // rust: for r in [
    // rust: [1, 0, 0, 5, 1, 7],
    // rust: [1, 2, 1, 5, 2, 7],
    // rust: [1, 3, 2, 5, 3, 7],
    // rust: [1, 4, 3, 5, 4, 7],
    // rust: [1, 2, 0, 1, 4, 2],
    // rust: [5, 2, 0, 5, 4, 2],
    // rust: [1, 5, 2, 1, 5, 3],
    // rust: [5, 5, 2, 5, 5, 3],
    // rust: [0, 5, 3, 0, 5, 8],
    // rust: [6, 5, 3, 6, 5, 8],
    // rust: [1, 5, 8, 5, 5, 8],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: let west = fence(c, &["west"]);
    // rust: let east = fence(c, &["east"]);
    // rust: self.put(c, west, 1, 6, 3)?;
    // rust: self.put(c, east, 5, 6, 3)?;
    // rust: self.put(c, fence(c, &["east", "north"]), 0, 6, 3)?;
    // rust: self.put(c, fence(c, &["west", "north"]), 6, 6, 3)?;
    // rust: self.bx(c, [0, 6, 4, 0, 6, 7], p.ns)?;
    // rust: self.bx(c, [6, 6, 4, 6, 6, 7], p.ns)?;
    // rust: self.put(c, fence(c, &["east", "south"]), 0, 6, 8)?;
    // rust: self.put(c, fence(c, &["west", "south"]), 6, 6, 8)?;
    // rust: self.bx(c, [1, 6, 8, 5, 6, 8], p.we)?;
    // rust: self.put(c, east, 1, 7, 8)?;
    // rust: self.bx(c, [2, 7, 8, 4, 7, 8], p.we)?;
    // rust: self.put(c, west, 5, 7, 8)?;
    // rust: self.put(c, east, 2, 8, 8)?;
    // rust: self.put(c, p.we, 3, 8, 8)?;
    // rust: self.put(c, west, 4, 8, 8)?;
    // rust: {
    // rust: let mut placed = self.flag.lock().unwrap();
    // rust: if !*placed {
    // rust: let pos = self.frame.world_pos(3, 5, 5);
    // rust: if c.chunk_box.is_inside(pos) {
    // rust: *placed = true;
    // rust: c.spawner(pos, "minecraft:blaze")?;
}
}
}
    // rust: self.columns(c, p, [0, 6], [0, 6])
}
pub fn room_crossing(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: self.bx(c, [0, 0, 0, 6, 1, 6], b)?;
    // rust: self.bx(c, [0, 2, 0, 6, 7, 6], p.air)?;
    // rust: for r in [
    // rust: [0, 2, 0, 1, 6, 0],
    // rust: [0, 2, 6, 1, 6, 6],
    // rust: [5, 2, 0, 6, 6, 0],
    // rust: [5, 2, 6, 6, 6, 6],
    // rust: [0, 2, 0, 0, 6, 1],
    // rust: [0, 2, 5, 0, 6, 6],
    // rust: [6, 2, 0, 6, 6, 1],
    // rust: [6, 2, 5, 6, 6, 6],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: self.bx(c, [2, 6, 0, 4, 6, 0], b)?;
    // rust: self.bx(c, [2, 5, 0, 4, 5, 0], p.we)?;
    // rust: self.bx(c, [2, 6, 6, 4, 6, 6], b)?;
    // rust: self.bx(c, [2, 5, 6, 4, 5, 6], p.we)?;
    // rust: self.bx(c, [0, 6, 2, 0, 6, 4], b)?;
    // rust: self.bx(c, [0, 5, 2, 0, 5, 4], p.ns)?;
    // rust: self.bx(c, [6, 6, 2, 6, 6, 4], b)?;
    // rust: self.bx(c, [6, 5, 2, 6, 5, 4], p.ns)?;
    // rust: self.columns(c, p, [0, 6], [0, 6])
}
pub fn stairs_room(self: *Self, c: *mut PieceContext<'_>, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = p.bricks;
    // rust: self.bx(c, [0, 0, 0, 6, 1, 6], b)?;
    // rust: self.bx(c, [0, 2, 0, 6, 10, 6], p.air)?;
    // rust: for r in [
    // rust: [0, 2, 0, 1, 8, 0],
    // rust: [5, 2, 0, 6, 8, 0],
    // rust: [0, 2, 1, 0, 8, 6],
    // rust: [6, 2, 1, 6, 8, 6],
    // rust: [1, 2, 6, 5, 8, 6],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: self.bx(c, [0, 3, 2, 0, 5, 4], p.ns)?;
    // rust: self.bx(c, [6, 3, 2, 6, 5, 2], p.ns)?;
    // rust: self.bx(c, [6, 3, 4, 6, 5, 4], p.ns)?;
    // rust: self.put(c, b, 5, 2, 5)?;
    // rust: for r in [
    // rust: [4, 2, 5, 4, 3, 5],
    // rust: [3, 2, 5, 3, 4, 5],
    // rust: [2, 2, 5, 2, 5, 5],
    // rust: [1, 2, 5, 1, 6, 5],
    // rust: [1, 7, 1, 5, 7, 4],
    // rust: ] {
    // rust: self.bx(c, r, b)?;
}
    // rust: self.bx(c, [6, 8, 2, 6, 8, 4], p.air)?;
    // rust: self.bx(c, [2, 6, 0, 4, 8, 0], b)?;
    // rust: self.bx(c, [2, 5, 0, 4, 5, 0], p.we)?;
    // rust: self.columns(c, p, [0, 6], [0, 6])
}
}

    // rust: impl LegacyPiece for FortressPiece {
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
    // rust: let mut tag = super::legacy::piece_tag(
    // rust: self.type_name(),
    // rust: self.frame.bounding_box,
    // rust: self.frame.orientation,
    // rust: self.depth,
    // rust: );
    // rust: let flag = Tag::Byte(i8::from(*self.flag.lock().unwrap()));
    // rust: match self.kind {
    // rust: Kind::BridgeEndFiller => {
    // rust: tag.insert("Seed".into(), Tag::Int(self.seed));
}
    // rust: Kind::SmallCorridorLeftTurn | Kind::SmallCorridorRightTurn => {
    // rust: tag.insert("Chest".into(), flag);
}
    // rust: Kind::MonsterThrone => {
    // rust: tag.insert("Mob".into(), flag);
}
    // rust: _ => {}
}
    // rust: Some(tag)
}
pub fn type_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.kind {
            // StartPiece is built through the BridgeCrossing constructor.
    // rust: Kind::Start | Kind::BridgeCrossing => "minecraft:nebcr",
    // rust: Kind::BridgeEndFiller => "minecraft:nebef",
    // rust: Kind::BridgeStraight => "minecraft:nebs",
    // rust: Kind::CorridorStairs => "minecraft:neccs",
    // rust: Kind::CorridorTBalcony => "minecraft:nectb",
    // rust: Kind::CastleEntrance => "minecraft:nece",
    // rust: Kind::SmallCorridorCrossing => "minecraft:nescsc",
    // rust: Kind::SmallCorridorLeftTurn => "minecraft:nesclt",
    // rust: Kind::SmallCorridor => "minecraft:nesc",
    // rust: Kind::SmallCorridorRightTurn => "minecraft:nescrt",
    // rust: Kind::StalkRoom => "minecraft:necsr",
    // rust: Kind::MonsterThrone => "minecraft:nemt",
    // rust: Kind::RoomCrossing => "minecraft:nerc",
    // rust: Kind::StairsRoom => "minecraft:nesr",
}
}
pub fn post_process(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = Palette::new(c);
    // rust: match self.kind {
    // rust: Kind::Start | Kind::BridgeCrossing => self.bridge_crossing(c, &p),
    // rust: Kind::BridgeEndFiller => self.end_filler(c, &p),
    // rust: Kind::BridgeStraight => self.bridge_straight(c, &p),
    // rust: Kind::CorridorStairs => self.corridor_stairs(c, &p),
    // rust: Kind::CorridorTBalcony => self.t_balcony(c, &p),
    // rust: Kind::CastleEntrance => self.castle_entrance(c, &p),
    // rust: Kind::SmallCorridorCrossing => self.corridor_crossing(c, &p),
    // rust: Kind::SmallCorridorLeftTurn => self.corridor_left(c, &p),
    // rust: Kind::SmallCorridor => self.corridor(c, &p),
    // rust: Kind::SmallCorridorRightTurn => self.corridor_right(c, &p),
    // rust: Kind::StalkRoom => self.stalk_room(c, &p),
    // rust: Kind::MonsterThrone => self.monster_throne(c, &p),
    // rust: Kind::RoomCrossing => self.room_crossing(c, &p),
    // rust: Kind::StairsRoom => self.stairs_room(c, &p),
}
}
}
