//! Transpiled from Horizon Rust crate
//! Module: horizon-world_monument
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Ocean monuments (OceanMonumentStructure, OceanMonumentPieces).
// use super::{
    // rust: BoundingBox,
    // rust: legacy::{LegacyPiece, PieceContext, PieceFrame, Result, make_bounding_box},
}
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, random::RandomSource};

pub const DOWN: usize = 0;
pub const UP: usize = 1;
pub const NORTH: usize = 2;
pub const SOUTH: usize = 3;
pub const WEST: usize = 4;
pub const EAST: usize = 5;
pub const OPPOSITE: [usize; 6] = [UP, DOWN, SOUTH, NORTH, EAST, WEST];
    // rust: const STEPS: [[i32; 3]; 6] = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ];

pub const Room = struct {
    index: i32,
    conn: [?usize,
    open: [bool,
    claimed: bool,
    source: bool,
    scan: i32,
};
    // rust: impl Room {
pub fn new(index: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: index,
    // rust: conn: [None; 6],
    // rust: open: [false; 6],
    // rust: claimed: false,
    // rust: source: false,
    // rust: scan: 0,
}
}
}
pub fn room_index(x: i32, y: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: y * 25 + z * 5 + x
}
pub const Graph = struct {
    rooms: std.ArrayList(Room),
};
    // rust: impl Graph {
pub fn connect(self: *Self, a: usize, d: usize, b: usize) void {
}
    // rust: self.rooms[a].conn[d] = Some(b);
    // rust: self.rooms[b].conn[OPPOSITE[d]] = Some(a);
}
pub fn update_openings(self: *Self, a: usize) void {
}
    // rust: let conn = self.rooms[a].conn;
    // rust: self.rooms[a].open = conn.map(|c| c.is_some());
}
pub fn find_source(self: *Self, a: usize, scan: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.rooms[a].source {
    // rust: return true;
}
    // rust: self.rooms[a].scan = scan;
    // rust: for i in 0..6 {
    // rust: if let Some(n) = self.rooms[a].conn[i]
    // rust: && self.rooms[a].open[i]
    // rust: && self.rooms[n].scan != scan
    // rust: && self.find_source(n, scan)
    // rust: {
    // rust: return true;
}
}
    // rust: false
}
pub fn conn(self: *Self, a: usize, d: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.rooms[a].conn[d].unwrap_or(a)
}
pub fn open(self: *Self, a: usize, d: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.rooms[a].open[d]
}
pub fn claim(self: *Self, a: usize) void {
}
    // rust: self.rooms[a].claimed = true;
}
}

pub const Kind = enum {
    Entry,
    Core,
    DoubleX,
    DoubleXY,
    DoubleY,
    DoubleYZ,
    DoubleZ,
    Simple(i32),
    SimpleTop,
    Wing(i32),
    Penthouse,
};
pub const Child = struct {
    kind: Kind,
    frame: PieceFrame,
    room: usize,
};

pub const MonumentBuilding = struct {
    frame: PieceFrame,
    rooms: std.ArrayList(Room),
    children: std.ArrayList(Child),
};
pub fn room_box(direction: Direction, index: i32, w: i32, h: i32, d: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (rx, rz, ry) = (index % 5, index / 5 % 5, index / 25);
    // rust: let b = make_bounding_box(0, 0, 0, direction, w * 8, h * 4, d * 8);
    // rust: b.moved(match direction {
    // rust: Direction::North => [rx * 8, ry * 4, -(rz + d) * 8 + 1],
    // rust: Direction::South => [rx * 8, ry * 4, rz * 8],
    // rust: Direction::West => [-(rz + d) * 8 + 1, ry * 4, rx * 8],
    // rust: _ => [rz * 8, ry * 4, rx * 8],
    // rust: })
}
    // rust: impl MonumentBuilding {
    // rust: pub fn new(
    // rust: random: &mut impl RandomSource,
    // rust: west: i32,
    // rust: north: i32,
    // rust: direction: Direction,
    // rust: ) -> Self {
    // rust: let frame = PieceFrame::new(
    // rust: make_bounding_box(west, 39, north, direction, 58, 23, 58),
    // rust: Some(direction),
    // rust: );
    // rust: let mut g = Graph { rooms: Vec::new() };
    // rust: let mut grid: [Option<usize>; 75] = [None; 75];
    // rust: let mut add = |g: &mut Graph, x: i32, y: i32, z: i32| {
    // rust: let i = room_index(x, y, z);
    // rust: grid[i as usize] = Some(g.rooms.len());
    // rust: g.rooms.push(Room::new(i));
}
    // rust: for x in 0..5 {
    // rust: for z in 0..4 {
    // rust: add(&mut g, x, 0, z);
}
}
    // rust: for x in 0..5 {
    // rust: for z in 0..4 {
    // rust: add(&mut g, x, 1, z);
}
}
    // rust: for x in 1..4 {
    // rust: for z in 0..2 {
    // rust: add(&mut g, x, 2, z);
}
}
    // rust: let source = grid[room_index(2, 0, 0) as usize].unwrap();
    // rust: for x in 0..5 {
    // rust: for z in 0..5 {
    // rust: for y in 0..3 {
    // rust: let Some(a) = grid[room_index(x, y, z) as usize] else {
    // rust: continue;
}
    // rust: for (d, s) in STEPS.iter().enumerate() {
    // rust: let (nx, ny, nz) = (x + s[0], y + s[1], z + s[2]);
    // rust: if !(0..5).contains(&nx) || !(0..5).contains(&nz) || !(0..3).contains(&ny) {
    // rust: continue;
}
    // rust: if let Some(b) = grid[room_index(nx, ny, nz) as usize] {
    // rust: let dir = if nz == z { d } else { OPPOSITE[d] };
    // rust: g.connect(a, dir, b);
}
}
}
}
}
    // rust: let roof = g.rooms.len();
    // rust: g.rooms.push(Room::new(1003));
    // rust: let left = g.rooms.len();
    // rust: g.rooms.push(Room::new(1001));
    // rust: let right = g.rooms.len();
    // rust: g.rooms.push(Room::new(1002));
    // rust: g.connect(grid[room_index(2, 2, 0) as usize].unwrap(), UP, roof);
    // rust: g.connect(grid[room_index(0, 1, 0) as usize].unwrap(), SOUTH, left);
    // rust: g.connect(grid[room_index(4, 1, 0) as usize].unwrap(), SOUTH, right);
    // rust: g.claim(roof);
    // rust: g.claim(left);
    // rust: g.claim(right);
    // rust: g.rooms[source].source = true;
    // rust: let core = grid[room_index(random.next_int_bound(4).unwrap_or(0), 0, 2) as usize].unwrap();
    // rust: let (ce, cn, cu) = (g.conn(core, EAST), g.conn(core, NORTH), g.conn(core, UP));
    // rust: let cen = g.conn(ce, NORTH);
    // rust: for r in [
    // rust: core,
    // rust: ce,
    // rust: cn,
    // rust: cen,
    // rust: cu,
    // rust: g.conn(ce, UP),
    // rust: g.conn(cn, UP),
    // rust: g.conn(cen, UP),
    // rust: ] {
    // rust: g.claim(r);
}
    // rust: let mut defs = Vec::new();
    // rust: for r in grid.iter().flatten() {
    // rust: g.update_openings(*r);
    // rust: defs.push(*r);
}
    // rust: g.update_openings(roof);
    // rust: for i in (2..=defs.len()).rev() {
    // rust: let j = random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: defs.swap(i - 1, j);
}
    // rust: let mut scan = 1;
    // rust: for &def in &defs {
    // rust: let (mut closed, mut attempts) = (0, 0);
    // rust: while closed < 2 && attempts < 5 {
    // rust: attempts += 1;
    // rust: let f = random.next_int_bound(6).unwrap_or(0) as usize;
    // rust: if !g.rooms[def].open[f] {
    // rust: continue;
}
    // rust: let of = OPPOSITE[f];
    // rust: let other = g.conn(def, f);
    // rust: g.rooms[def].open[f] = false;
    // rust: g.rooms[other].open[of] = false;
    // rust: let a = g.find_source(def, scan);
    // rust: scan += 1;
    // rust: let ok = a && {
    // rust: let b = g.find_source(other, scan);
    // rust: scan += 1;
    // rust: b
}
    // rust: if ok {
    // rust: closed += 1;
    // rust: } else {
    // rust: g.rooms[def].open[f] = true;
    // rust: g.rooms[other].open[of] = true;
}
}
}
    // rust: defs.extend([roof, left, right]);
    // rust: g.claim(source);
    // rust: let mut children = Vec::new();
    // rust: let child = |kind: Kind, room: usize, g: &Graph, w: i32, h: i32, d: i32| Child {
    // rust: kind,
    // rust: frame: PieceFrame::new(
    // rust: room_box(direction, g.rooms[room].index, w, h, d),
    // rust: Some(direction),
    // rust: ),
    // rust: room,
}
    // rust: children.push(child(Kind::Entry, source, &g, 1, 1, 1));
    // rust: children.push(child(Kind::Core, core, &g, 2, 2, 2));
    // rust: for def in defs {
    // rust: if g.rooms[def].claimed || g.rooms[def].index >= 75 {
    // rust: continue;
}
    // rust: let free =
    // rust: |g: &Graph, r: usize, d: usize| g.open(r, d) && !g.rooms[g.conn(r, d)].claimed;
    // rust: if free(&g, def, EAST) && free(&g, def, UP) && free(&g, g.conn(def, EAST), UP) {
    // rust: let e = g.conn(def, EAST);
    // rust: for r in [def, e, g.conn(def, UP), g.conn(e, UP)] {
    // rust: g.claim(r);
}
    // rust: children.push(child(Kind::DoubleXY, def, &g, 2, 2, 1));
    // rust: } else if free(&g, def, NORTH) && free(&g, def, UP) && free(&g, g.conn(def, NORTH), UP)
    // rust: {
    // rust: let n = g.conn(def, NORTH);
    // rust: for r in [def, n, g.conn(def, UP), g.conn(n, UP)] {
    // rust: g.claim(r);
}
    // rust: children.push(child(Kind::DoubleYZ, def, &g, 1, 2, 2));
    // rust: } else if free(&g, def, NORTH) {
    // rust: g.claim(def);
    // rust: g.claim(g.conn(def, NORTH));
    // rust: children.push(child(Kind::DoubleZ, def, &g, 1, 1, 2));
    // rust: } else if free(&g, def, EAST) {
    // rust: g.claim(def);
    // rust: g.claim(g.conn(def, EAST));
    // rust: children.push(child(Kind::DoubleX, def, &g, 2, 1, 1));
    // rust: } else if free(&g, def, UP) {
    // rust: g.claim(def);
    // rust: g.claim(g.conn(def, UP));
    // rust: children.push(child(Kind::DoubleY, def, &g, 1, 2, 1));
    // rust: } else if [WEST, EAST, NORTH, SOUTH, UP]
    // rust: .iter()
    // rust: .all(|&d| !g.open(def, d))
    // rust: {
    // rust: g.claim(def);
    // rust: children.push(child(Kind::SimpleTop, def, &g, 1, 1, 1));
    // rust: } else {
    // rust: g.claim(def);
    // rust: let design = random.next_int_bound(3).unwrap_or(0);
    // rust: children.push(child(Kind::Simple(design), def, &g, 1, 1, 1));
}
}
    // rust: let offset = frame.world_pos(9, 0, 22);
    // rust: for c in &mut children {
    // rust: c.frame.bounding_box = c.frame.bounding_box.moved(offset);
}
    // rust: let corners = |a: [i32; 3], b: [i32; 3]| {
    // rust: BoundingBox::from_corners(
    // rust: frame.world_pos(a[0], a[1], a[2]),
    // rust: frame.world_pos(b[0], b[1], b[2]),
    // rust: )
}
    // rust: let wing_random = random.next_int();
    // rust: for (i, b) in [
    // rust: corners([1, 1, 1], [23, 8, 21]),
    // rust: corners([34, 1, 1], [56, 8, 21]),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: children.push(Child {
    // rust: kind: Kind::Wing(wing_random.wrapping_add(i as i32) & 1),
    // rust: frame: PieceFrame::new(b, Some(direction)),
    // rust: room: source,
    // rust: });
}
    // rust: children.push(Child {
    // rust: kind: Kind::Penthouse,
    // rust: frame: PieceFrame::new(corners([22, 13, 22], [35, 17, 35]), Some(direction)),
    // rust: room: source,
    // rust: });
    // rust: Self {
    // rust: frame,
    // rust: rooms: g.rooms,
    // rust: children,
}
}
}

/// OceanMonumentPiece helpers bound to one frame and chunk.
pub const W = struct {
    f: PieceFrame,
    c: *'x mut PieceContext<'c>,
    sea: i32,
    water: BlockStateId,
};
    // rust: impl W<'_, '_> {
    /// OceanMonumentPiece.spawnElder.
pub fn elder(self: *Self, x: i32, y: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pos = self.f.world_pos(x, y, z);
    // rust: if self.c.chunk_box.is_inside(pos) {
    // rust: self.c.world.entity(super::legacy::spawn_nbt(
    // rust: "minecraft:elder_guardian",
    // rust: pos,
    // rust: true,
                // The ElderGuardian constructor's setPersistenceRequired.
    // rust: true,
    // rust: ))?;
}
    // rust: Ok(())
}
    // rust: fn bx(
    // rust: &mut self,
    // rust: x0: i32,
    // rust: y0: i32,
    // rust: z0: i32,
    // rust: x1: i32,
    // rust: y1: i32,
    // rust: z1: i32,
    // rust: s: BlockStateId,
    // rust: ) -> Result<()> {
    // rust: self.f
    // rust: .generate_box(self.c, [x0, y0, z0], [x1, y1, z1], s, s, false)
}
pub fn put(self: *Self, s: BlockStateId, x: i32, y: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.f.place(self.c, s, x, y, z)
}
pub fn water(self: *Self, x0: i32, y0: i32, z0: i32, x1: i32, y1: i32, z1: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let air = self.c.state("air");
    // rust: for y in y0..=y1 {
    // rust: for x in x0..=x1 {
    // rust: for z in z0..=z1 {
    // rust: let s = self.f.get(self.c, x, y, z)?;
    // rust: if matches!(
    // rust: self.c.name(s),
    // rust: "minecraft:ice"
    // rust: | "minecraft:packed_ice"
    // rust: | "minecraft:blue_ice"
    // rust: | "minecraft:water"
    // rust: ) {
    // rust: continue;
}
    // rust: let state = if self.f.world_y(y) >= self.sea && s != self.water {
    // rust: air
    // rust: } else {
    // rust: self.water
}
    // rust: self.f.place(self.c, state, x, y, z)?;
}
}
}
    // rust: Ok(())
}
    // rust: fn fill_only(
    // rust: &mut self,
    // rust: x0: i32,
    // rust: y0: i32,
    // rust: z0: i32,
    // rust: x1: i32,
    // rust: y1: i32,
    // rust: z1: i32,
    // rust: s: BlockStateId,
    // rust: ) -> Result<()> {
    // rust: for y in y0..=y1 {
    // rust: for x in x0..=x1 {
    // rust: for z in z0..=z1 {
    // rust: if self.f.get(self.c, x, y, z)? == self.water {
    // rust: self.f.place(self.c, s, x, y, z)?;
}
}
}
}
    // rust: Ok(())
}
pub fn floor(self: *Self, xo: i32, zo: i32, down: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (g, l) = (
    // rust: self.c.state("prismarine"),
    // rust: self.c.state("prismarine_bricks"),
    // rust: );
    // rust: if down {
    // rust: self.bx(xo, 0, zo, xo + 2, 0, zo + 7, g)?;
    // rust: self.bx(xo + 5, 0, zo, xo + 7, 0, zo + 7, g)?;
    // rust: self.bx(xo + 3, 0, zo, xo + 4, 0, zo + 2, g)?;
    // rust: self.bx(xo + 3, 0, zo + 5, xo + 4, 0, zo + 7, g)?;
    // rust: self.bx(xo + 3, 0, zo + 2, xo + 4, 0, zo + 2, l)?;
    // rust: self.bx(xo + 3, 0, zo + 5, xo + 4, 0, zo + 5, l)?;
    // rust: self.bx(xo + 2, 0, zo + 3, xo + 2, 0, zo + 4, l)?;
    // rust: self.bx(xo + 5, 0, zo + 3, xo + 5, 0, zo + 4, l)
    // rust: } else {
    // rust: self.bx(xo, 0, zo, xo + 7, 0, zo + 7, g)
}
}
pub fn hits(self: *Self, x0: i32, z0: i32, x1: i32, z1: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ax, az) = (self.f.world_x(x0, z0), self.f.world_z(x0, z0));
    // rust: let (bx, bz) = (self.f.world_x(x1, z1), self.f.world_z(x1, z1));
    // rust: let b = self.c.chunk_box;
    // rust: b.max[0] >= ax.min(bx)
    // rust: && b.min[0] <= ax.max(bx)
    // rust: && b.max[2] >= az.min(bz)
    // rust: && b.min[2] <= az.max(bz)
}
}
pub const Palette = struct {
    g: BlockStateId,
    l: BlockStateId,
    k: BlockStateId,
    lamp: BlockStateId,
};

    // rust: impl LegacyPiece for MonumentBuilding {
pub fn bounding_box(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.frame.bounding_box
}
pub fn type_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "minecraft:omb"
}
    /// `MonumentBuilding`: the base fields only; vanilla builds its rooms
    /// again after loading (`OceanMonumentStructure.regeneratePiecesAfterLoad`).
pub fn save(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(super::legacy::piece_tag(
    // rust: "minecraft:omb",
    // rust: self.frame.bounding_box,
    // rust: self.frame.orientation,
    // rust: 0,
    // rust: ))
}
pub fn post_process(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sea = c.world.sea_level()?;
    // rust: let water = c.state("water");
    // rust: let p = Palette {
    // rust: g: c.state("prismarine"),
    // rust: l: c.state("prismarine_bricks"),
    // rust: k: c.state("dark_prismarine"),
    // rust: lamp: c.state("sea_lantern"),
}
    // rust: let mut w = W {
    // rust: f: self.frame,
    // rust: c,
    // rust: sea,
    // rust: water,
}
    // rust: let water_height = sea.max(64) - self.frame.bounding_box.min[1];
    // rust: w.water(0, 0, 0, 58, water_height, 58)?;
    // rust: building(&mut w, &p)?;
    // rust: let c = w.c;
    // rust: for child in &self.children {
    // rust: if child.frame.bounding_box.intersects(&c.chunk_box) {
    // rust: let mut w = W {
    // rust: f: child.frame,
    // rust: c: &mut *c,
    // rust: sea,
    // rust: water,
}
    // rust: room(&mut w, &p, child, &self.rooms)?;
}
}
    // rust: Ok(())
}
}

pub fn wing(w: *mut W<'_, p: *Palette, flipped: bool, xo: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (g, l) = (p.g, p.l);
    // rust: if !w.hits(xo, 0, xo + 23, 20) {
    // rust: return Ok(());
}
    // rust: w.bx(xo, 0, 0, xo + 24, 0, 20, g)?;
    // rust: w.water(xo, 1, 0, xo + 24, 10, 20)?;
    // rust: for i in 0..4 {
    // rust: w.bx(xo + i, i + 1, i, xo + i, i + 1, 20, l)?;
    // rust: w.bx(xo + i + 7, i + 5, i + 7, xo + i + 7, i + 5, 20, l)?;
    // rust: w.bx(xo + 17 - i, i + 5, i + 7, xo + 17 - i, i + 5, 20, l)?;
    // rust: w.bx(xo + 24 - i, i + 1, i, xo + 24 - i, i + 1, 20, l)?;
    // rust: w.bx(xo + i + 1, i + 1, i, xo + 23 - i, i + 1, i, l)?;
    // rust: w.bx(xo + i + 8, i + 5, i + 7, xo + 16 - i, i + 5, i + 7, l)?;
}
    // rust: w.bx(xo + 4, 4, 4, xo + 6, 4, 20, g)?;
    // rust: w.bx(xo + 7, 4, 4, xo + 17, 4, 6, g)?;
    // rust: w.bx(xo + 18, 4, 4, xo + 20, 4, 20, g)?;
    // rust: w.bx(xo + 11, 8, 11, xo + 13, 8, 20, g)?;
    // rust: w.put(l, xo + 12, 9, 12)?;
    // rust: w.put(l, xo + 12, 9, 15)?;
    // rust: w.put(l, xo + 12, 9, 18)?;
    // rust: let left = xo + if flipped { 19 } else { 5 };
    // rust: let right = xo + if flipped { 5 } else { 19 };
    // rust: for z in (5..=20).rev().step_by(3) {
    // rust: w.put(l, left, 5, z)?;
}
    // rust: for z in (7..=19).rev().step_by(3) {
    // rust: w.put(l, right, 5, z)?;
}
    // rust: for i in 0..4 {
    // rust: let x = if flipped {
    // rust: xo + 24 - (17 - i * 3)
    // rust: } else {
    // rust: xo + 17 - i * 3
}
    // rust: w.put(l, x, 5, 5)?;
}
    // rust: w.put(l, right, 5, 5)?;
    // rust: w.bx(xo + 11, 1, 12, xo + 13, 7, 12, g)?;
    // rust: w.bx(xo + 12, 1, 11, xo + 12, 7, 13, g)
}
/// MonumentBuilding.postProcess after the first water box (without children).
pub fn building(w: *mut W<'_, p: *Palette) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (g, l, k, lamp) = (p.g, p.l, p.k, p.lamp);
    // rust: wing(w, p, false, 0)?;
    // rust: wing(w, p, true, 33)?;
    // rust: if w.hits(22, 5, 35, 17) {
    // rust: w.water(25, 0, 0, 32, 8, 20)?;
    // rust: for i in 0..4 {
    // rust: let z = 5 + i * 4;
    // rust: w.bx(24, 2, z, 24, 4, z, l)?;
    // rust: w.bx(22, 4, z, 23, 4, z, l)?;
    // rust: w.put(l, 25, 5, z)?;
    // rust: w.put(l, 26, 6, z)?;
    // rust: w.put(lamp, 26, 5, z)?;
    // rust: w.bx(33, 2, z, 33, 4, z, l)?;
    // rust: w.bx(34, 4, z, 35, 4, z, l)?;
    // rust: w.put(l, 32, 5, z)?;
    // rust: w.put(l, 31, 6, z)?;
    // rust: w.put(lamp, 31, 5, z)?;
    // rust: w.bx(27, 6, z, 30, 6, z, g)?;
}
}
    // rust: if w.hits(15, 20, 42, 21) {
    // rust: w.bx(15, 0, 21, 42, 0, 21, g)?;
    // rust: w.water(26, 1, 21, 31, 3, 21)?;
    // rust: for [x0, y, x1] in [[21, 12, 36], [17, 11, 40], [16, 10, 41]] {
    // rust: w.bx(x0, y, 21, x1, y, 21, g)?;
}
    // rust: w.bx(15, 7, 21, 42, 9, 21, g)?;
    // rust: for [x0, y, x1] in [
    // rust: [16, 6, 41],
    // rust: [17, 5, 40],
    // rust: [21, 4, 36],
    // rust: [22, 3, 26],
    // rust: [31, 3, 35],
    // rust: [23, 2, 25],
    // rust: [32, 2, 34],
    // rust: ] {
    // rust: w.bx(x0, y, 21, x1, y, 21, g)?;
}
    // rust: w.bx(28, 4, 20, 29, 4, 21, l)?;
    // rust: for [x, y] in [[27, 3], [30, 3], [26, 2], [31, 2], [25, 1], [32, 1]] {
    // rust: w.put(l, x, y, 21)?;
}
    // rust: for i in 0..7 {
    // rust: w.put(k, 28 - i, 6 + i, 21)?;
    // rust: w.put(k, 29 + i, 6 + i, 21)?;
}
    // rust: for i in 0..4 {
    // rust: w.put(k, 28 - i, 9 + i, 21)?;
    // rust: w.put(k, 29 + i, 9 + i, 21)?;
}
    // rust: w.put(k, 28, 12, 21)?;
    // rust: w.put(k, 29, 12, 21)?;
    // rust: for i in 0..3 {
    // rust: w.put(k, 22 - i * 2, 8, 21)?;
    // rust: w.put(k, 22 - i * 2, 9, 21)?;
    // rust: w.put(k, 35 + i * 2, 8, 21)?;
    // rust: w.put(k, 35 + i * 2, 9, 21)?;
}
    // rust: w.water(15, 13, 21, 42, 15, 21)?;
    // rust: for [x0, y1, x1] in [
    // rust: [15, 6, 15],
    // rust: [16, 5, 16],
    // rust: [17, 4, 20],
    // rust: [21, 3, 21],
    // rust: [22, 2, 22],
    // rust: [23, 1, 24],
    // rust: [42, 6, 42],
    // rust: [41, 5, 41],
    // rust: [37, 4, 40],
    // rust: [36, 3, 36],
    // rust: [33, 1, 34],
    // rust: [35, 2, 35],
    // rust: ] {
    // rust: w.water(x0, 1, 21, x1, y1, 21)?;
}
}
    // rust: if w.hits(21, 21, 36, 36) {
    // rust: w.bx(21, 0, 22, 36, 0, 36, g)?;
    // rust: w.water(21, 1, 22, 36, 23, 36)?;
    // rust: for i in 0..4 {
    // rust: w.bx(21 + i, 13 + i, 21 + i, 36 - i, 13 + i, 21 + i, l)?;
    // rust: w.bx(21 + i, 13 + i, 36 - i, 36 - i, 13 + i, 36 - i, l)?;
    // rust: w.bx(21 + i, 13 + i, 22 + i, 21 + i, 13 + i, 35 - i, l)?;
    // rust: w.bx(36 - i, 13 + i, 22 + i, 36 - i, 13 + i, 35 - i, l)?;
}
    // rust: w.bx(25, 16, 25, 32, 16, 32, g)?;
    // rust: w.bx(25, 17, 25, 25, 19, 25, l)?;
    // rust: w.bx(32, 17, 25, 32, 19, 25, l)?;
    // rust: w.bx(25, 17, 32, 25, 19, 32, l)?;
    // rust: w.bx(32, 17, 32, 32, 19, 32, l)?;
    // rust: for [a, b, cx, cz] in [
    // rust: [26, 26, 27, 27],
    // rust: [26, 31, 27, 30],
    // rust: [31, 31, 30, 30],
    // rust: [31, 26, 30, 27],
    // rust: ] {
    // rust: w.put(l, a, 20, b)?;
    // rust: w.put(l, cx, 21, cz)?;
    // rust: w.put(lamp, cx, 20, cz)?;
}
    // rust: w.bx(28, 21, 27, 29, 21, 27, g)?;
    // rust: w.bx(27, 21, 28, 27, 21, 29, g)?;
    // rust: w.bx(28, 21, 30, 29, 21, 30, g)?;
    // rust: w.bx(30, 21, 28, 30, 21, 29, g)?;
}
    // generateLowerWall
    // rust: if w.hits(0, 21, 6, 58) {
    // rust: w.bx(0, 0, 21, 6, 0, 57, g)?;
    // rust: w.water(0, 1, 21, 6, 7, 57)?;
    // rust: w.bx(4, 4, 21, 6, 4, 53, g)?;
    // rust: for i in 0..4 {
    // rust: w.bx(i, i + 1, 21, i, i + 1, 57 - i, l)?;
}
    // rust: for z in (23..53).step_by(3) {
    // rust: w.put(l, 5, 5, z)?;
}
    // rust: w.put(l, 5, 5, 52)?;
    // rust: for i in 0..4 {
    // rust: w.bx(i, i + 1, 21, i, i + 1, 57 - i, l)?;
}
    // rust: w.bx(4, 1, 52, 6, 3, 52, g)?;
    // rust: w.bx(5, 1, 51, 5, 3, 53, g)?;
}
    // rust: if w.hits(51, 21, 58, 58) {
    // rust: w.bx(51, 0, 21, 57, 0, 57, g)?;
    // rust: w.water(51, 1, 21, 57, 7, 57)?;
    // rust: w.bx(51, 4, 21, 53, 4, 53, g)?;
    // rust: for i in 0..4 {
    // rust: w.bx(57 - i, i + 1, 21, 57 - i, i + 1, 57 - i, l)?;
}
    // rust: for z in (23..53).step_by(3) {
    // rust: w.put(l, 52, 5, z)?;
}
    // rust: w.put(l, 52, 5, 52)?;
    // rust: w.bx(51, 1, 52, 53, 3, 52, g)?;
    // rust: w.bx(52, 1, 51, 52, 3, 53, g)?;
}
    // rust: if w.hits(0, 51, 57, 57) {
    // rust: w.bx(7, 0, 51, 50, 0, 57, g)?;
    // rust: w.water(7, 1, 51, 50, 10, 57)?;
    // rust: for i in 0..4 {
    // rust: w.bx(i + 1, i + 1, 57 - i, 56 - i, i + 1, 57 - i, l)?;
}
}
    // generateMiddleWall
    // rust: if w.hits(7, 21, 13, 50) {
    // rust: w.bx(7, 0, 21, 13, 0, 50, g)?;
    // rust: w.water(7, 1, 21, 13, 10, 50)?;
    // rust: w.bx(11, 8, 21, 13, 8, 53, g)?;
    // rust: for i in 0..4 {
    // rust: w.bx(i + 7, i + 5, 21, i + 7, i + 5, 54, l)?;
}
    // rust: for z in (21..=45).step_by(3) {
    // rust: w.put(l, 12, 9, z)?;
}
}
    // rust: if w.hits(44, 21, 50, 54) {
    // rust: w.bx(44, 0, 21, 50, 0, 50, g)?;
    // rust: w.water(44, 1, 21, 50, 10, 50)?;
    // rust: w.bx(44, 8, 21, 46, 8, 53, g)?;
    // rust: for i in 0..4 {
    // rust: w.bx(50 - i, i + 5, 21, 50 - i, i + 5, 54, l)?;
}
    // rust: for z in (21..=45).step_by(3) {
    // rust: w.put(l, 45, 9, z)?;
}
}
    // rust: if w.hits(8, 44, 49, 54) {
    // rust: w.bx(14, 0, 44, 43, 0, 50, g)?;
    // rust: w.water(14, 1, 44, 43, 10, 50)?;
    // rust: for x in (12..=45).step_by(3) {
    // rust: w.put(l, x, 9, 45)?;
    // rust: w.put(l, x, 9, 52)?;
    // rust: if matches!(x, 12 | 18 | 24 | 33 | 39 | 45) {
    // rust: for [y, z] in [
    // rust: [9, 47],
    // rust: [9, 50],
    // rust: [10, 45],
    // rust: [10, 46],
    // rust: [10, 51],
    // rust: [10, 52],
    // rust: [11, 47],
    // rust: [11, 50],
    // rust: [12, 48],
    // rust: [12, 49],
    // rust: ] {
    // rust: w.put(l, x, y, z)?;
}
}
}
    // rust: for i in 0..3 {
    // rust: w.bx(8 + i, 5 + i, 54, 49 - i, 5 + i, 54, g)?;
}
    // rust: w.bx(11, 8, 54, 46, 8, 54, l)?;
    // rust: w.bx(14, 8, 44, 43, 8, 53, g)?;
}
    // generateUpperWall
    // rust: if w.hits(14, 21, 20, 43) {
    // rust: w.bx(14, 0, 21, 20, 0, 43, g)?;
    // rust: w.water(14, 1, 22, 20, 14, 43)?;
    // rust: w.bx(18, 12, 22, 20, 12, 39, g)?;
    // rust: w.bx(18, 12, 21, 20, 12, 21, l)?;
    // rust: for i in 0..4 {
    // rust: w.bx(i + 14, i + 9, 21, i + 14, i + 9, 43 - i, l)?;
}
    // rust: for z in (23..=39).step_by(3) {
    // rust: w.put(l, 19, 13, z)?;
}
}
    // rust: if w.hits(37, 21, 43, 43) {
    // rust: w.bx(37, 0, 21, 43, 0, 43, g)?;
    // rust: w.water(37, 1, 22, 43, 14, 43)?;
    // rust: w.bx(37, 12, 22, 39, 12, 39, g)?;
    // rust: w.bx(37, 12, 21, 39, 12, 21, l)?;
    // rust: for i in 0..4 {
    // rust: w.bx(43 - i, i + 9, 21, 43 - i, i + 9, 43 - i, l)?;
}
    // rust: for z in (23..=39).step_by(3) {
    // rust: w.put(l, 38, 13, z)?;
}
}
    // rust: if w.hits(15, 37, 42, 43) {
    // rust: w.bx(21, 0, 37, 36, 0, 43, g)?;
    // rust: w.water(21, 1, 37, 36, 14, 43)?;
    // rust: w.bx(21, 12, 37, 36, 12, 39, g)?;
    // rust: for i in 0..4 {
    // rust: w.bx(15 + i, i + 9, 43 - i, 42 - i, i + 9, 43 - i, l)?;
}
    // rust: for x in (21..=36).step_by(3) {
    // rust: w.put(l, x, 13, 38)?;
}
}
    // rust: for px in 0..7 {
    // rust: let mut pz = 0;
    // rust: while pz < 7 {
    // rust: if pz == 0 && px == 3 {
    // rust: pz = 6;
}
    // rust: let (bx, bz) = (px * 9, pz * 9);
    // rust: for dx in 0..4 {
    // rust: for dz in 0..4 {
    // rust: w.put(l, bx + dx, 0, bz + dz)?;
    // rust: w.f.fill_column_down(w.c, l, bx + dx, -1, bz + dz)?;
}
}
    // rust: pz += if px != 0 && px != 6 { 6 } else { 1 };
}
}
    // rust: for i in 0..5 {
    // rust: w.water(-1 - i, i * 2, -1 - i, -1 - i, 23, 58 + i)?;
    // rust: w.water(58 + i, i * 2, -1 - i, 58 + i, 23, 58 + i)?;
    // rust: w.water(-i, i * 2, -1 - i, 57 + i, 23, -1 - i)?;
    // rust: w.water(-i, i * 2, 58 + i, 57 + i, 23, 58 + i)?;
}
    // rust: Ok(())
}

/// Openings of the doorways shared by the double rooms: (room, side, water box).
pub fn doorways(w: *mut W<'_, list: *[(bool) void {
}
    // rust: for (open, [x0, y0, z0, x1, y1, z1]) in list {
    // rust: if *open {
    // rust: w.water(*x0, *y0, *z0, *x1, *y1, *z1)?;
}
}
    // rust: Ok(())
}
pub fn room(w: *mut W<'_, p: *Palette, child: *Child, rooms: *[Room]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (g, l, k, lamp) = (p.g, p.l, p.k, p.lamp);
    // rust: let r = &rooms[child.room];
    // rust: let conn = |a: &Room, d: usize| a.conn[d].map(|i| &rooms[i]);
    // rust: let upper = r.index / 25 > 0;
    // rust: match child.kind {
    // rust: Kind::Core => {
    // rust: w.fill_only(1, 8, 0, 14, 8, 14, g)?;
    // rust: w.bx(0, 7, 0, 0, 7, 15, l)?;
    // rust: w.bx(15, 7, 0, 15, 7, 15, l)?;
    // rust: w.bx(1, 7, 0, 15, 7, 0, l)?;
    // rust: w.bx(1, 7, 15, 14, 7, 15, l)?;
    // rust: for y in 1..=6 {
    // rust: let b = if y == 2 || y == 6 { g } else { l };
    // rust: for x in [0, 15] {
    // rust: w.bx(x, y, 0, x, y, 1, b)?;
    // rust: w.bx(x, y, 6, x, y, 9, b)?;
    // rust: w.bx(x, y, 14, x, y, 15, b)?;
}
    // rust: w.bx(1, y, 0, 1, y, 0, b)?;
    // rust: w.bx(6, y, 0, 9, y, 0, b)?;
    // rust: w.bx(14, y, 0, 14, y, 0, b)?;
    // rust: w.bx(1, y, 15, 14, y, 15, b)?;
}
    // rust: w.bx(6, 3, 6, 9, 6, 9, k)?;
    // rust: let gold = w.c.state("gold_block");
    // rust: w.bx(7, 4, 7, 8, 5, 8, gold)?;
    // rust: for y in [3, 6] {
    // rust: for x in [6, 9] {
    // rust: w.put(lamp, x, y, 6)?;
    // rust: w.put(lamp, x, y, 9)?;
}
}
    // rust: for [x0, y0, z0, x1, y1, z1] in [
    // rust: [5, 1, 6, 5, 2, 6],
    // rust: [5, 1, 9, 5, 2, 9],
    // rust: [10, 1, 6, 10, 2, 6],
    // rust: [10, 1, 9, 10, 2, 9],
    // rust: [6, 1, 5, 6, 2, 5],
    // rust: [9, 1, 5, 9, 2, 5],
    // rust: [6, 1, 10, 6, 2, 10],
    // rust: [9, 1, 10, 9, 2, 10],
    // rust: [5, 2, 5, 5, 6, 5],
    // rust: [5, 2, 10, 5, 6, 10],
    // rust: [10, 2, 5, 10, 6, 5],
    // rust: [10, 2, 10, 10, 6, 10],
    // rust: [5, 7, 1, 5, 7, 6],
    // rust: [10, 7, 1, 10, 7, 6],
    // rust: [5, 7, 9, 5, 7, 14],
    // rust: [10, 7, 9, 10, 7, 14],
    // rust: [1, 7, 5, 6, 7, 5],
    // rust: [1, 7, 10, 6, 7, 10],
    // rust: [9, 7, 5, 14, 7, 5],
    // rust: [9, 7, 10, 14, 7, 10],
    // rust: [2, 1, 2, 2, 1, 3],
    // rust: [3, 1, 2, 3, 1, 2],
    // rust: [13, 1, 2, 13, 1, 3],
    // rust: [12, 1, 2, 12, 1, 2],
    // rust: [2, 1, 12, 2, 1, 13],
    // rust: [3, 1, 13, 3, 1, 13],
    // rust: [13, 1, 12, 13, 1, 13],
    // rust: [12, 1, 13, 12, 1, 13],
    // rust: ] {
    // rust: w.bx(x0, y0, z0, x1, y1, z1, l)?;
}
}
    // rust: Kind::DoubleX => {
    // rust: let east = conn(r, EAST).unwrap_or(r);
    // rust: let west = r;
    // rust: if upper {
    // rust: w.floor(8, 0, east.open[DOWN])?;
    // rust: w.floor(0, 0, west.open[DOWN])?;
}
    // rust: if west.conn[UP].is_none() {
    // rust: w.fill_only(1, 4, 1, 7, 4, 6, g)?;
}
    // rust: if east.conn[UP].is_none() {
    // rust: w.fill_only(8, 4, 1, 14, 4, 6, g)?;
}
    // rust: for (y, b) in [(3, l), (2, g), (1, l)] {
    // rust: w.bx(0, y, 0, 0, y, 7, b)?;
    // rust: w.bx(15, y, 0, 15, y, 7, b)?;
    // rust: w.bx(1, y, 0, 15, y, 0, b)?;
    // rust: w.bx(1, y, 7, 14, y, 7, b)?;
}
    // rust: w.bx(5, 1, 0, 10, 1, 4, l)?;
    // rust: w.bx(6, 2, 0, 9, 2, 3, g)?;
    // rust: w.bx(5, 3, 0, 10, 3, 4, l)?;
    // rust: w.put(lamp, 6, 2, 3)?;
    // rust: w.put(lamp, 9, 2, 3)?;
    // rust: doorways(
    // rust: w,
    // rust: &[
    // rust: (west.open[SOUTH], [3, 1, 0, 4, 2, 0]),
    // rust: (west.open[NORTH], [3, 1, 7, 4, 2, 7]),
    // rust: (west.open[WEST], [0, 1, 3, 0, 2, 4]),
    // rust: (east.open[SOUTH], [11, 1, 0, 12, 2, 0]),
    // rust: (east.open[NORTH], [11, 1, 7, 12, 2, 7]),
    // rust: (east.open[EAST], [15, 1, 3, 15, 2, 4]),
    // rust: ],
    // rust: )?;
}
    // rust: Kind::DoubleXY => {
    // rust: let east = conn(r, EAST).unwrap_or(r);
    // rust: let west = r;
    // rust: let west_up = conn(west, UP).unwrap_or(r);
    // rust: let east_up = conn(east, UP).unwrap_or(r);
    // rust: if upper {
    // rust: w.floor(8, 0, east.open[DOWN])?;
    // rust: w.floor(0, 0, west.open[DOWN])?;
}
    // rust: if west_up.conn[UP].is_none() {
    // rust: w.fill_only(1, 8, 1, 7, 8, 6, g)?;
}
    // rust: if east_up.conn[UP].is_none() {
    // rust: w.fill_only(8, 8, 1, 14, 8, 6, g)?;
}
    // rust: for y in 1..=7 {
    // rust: let b = if y == 2 || y == 6 { g } else { l };
    // rust: w.bx(0, y, 0, 0, y, 7, b)?;
    // rust: w.bx(15, y, 0, 15, y, 7, b)?;
    // rust: w.bx(1, y, 0, 15, y, 0, b)?;
    // rust: w.bx(1, y, 7, 14, y, 7, b)?;
}
    // rust: for [x0, y0, z0, x1, y1, z1] in [
    // rust: [2, 1, 3, 2, 7, 4],
    // rust: [3, 1, 2, 4, 7, 2],
    // rust: [3, 1, 5, 4, 7, 5],
    // rust: [13, 1, 3, 13, 7, 4],
    // rust: [11, 1, 2, 12, 7, 2],
    // rust: [11, 1, 5, 12, 7, 5],
    // rust: [5, 1, 3, 5, 3, 4],
    // rust: [10, 1, 3, 10, 3, 4],
    // rust: [5, 7, 2, 10, 7, 5],
    // rust: [5, 5, 2, 5, 7, 2],
    // rust: [10, 5, 2, 10, 7, 2],
    // rust: [5, 5, 5, 5, 7, 5],
    // rust: [10, 5, 5, 10, 7, 5],
    // rust: ] {
    // rust: w.bx(x0, y0, z0, x1, y1, z1, l)?;
}
    // rust: w.put(l, 6, 6, 2)?;
    // rust: w.put(l, 9, 6, 2)?;
    // rust: w.put(l, 6, 6, 5)?;
    // rust: w.put(l, 9, 6, 5)?;
    // rust: w.bx(5, 4, 3, 6, 4, 4, l)?;
    // rust: w.bx(9, 4, 3, 10, 4, 4, l)?;
    // rust: w.put(lamp, 5, 4, 2)?;
    // rust: w.put(lamp, 5, 4, 5)?;
    // rust: w.put(lamp, 10, 4, 2)?;
    // rust: w.put(lamp, 10, 4, 5)?;
    // rust: doorways(
    // rust: w,
    // rust: &[
    // rust: (west.open[SOUTH], [3, 1, 0, 4, 2, 0]),
    // rust: (west.open[NORTH], [3, 1, 7, 4, 2, 7]),
    // rust: (west.open[WEST], [0, 1, 3, 0, 2, 4]),
    // rust: (east.open[SOUTH], [11, 1, 0, 12, 2, 0]),
    // rust: (east.open[NORTH], [11, 1, 7, 12, 2, 7]),
    // rust: (east.open[EAST], [15, 1, 3, 15, 2, 4]),
    // rust: (west_up.open[SOUTH], [3, 5, 0, 4, 6, 0]),
    // rust: (west_up.open[NORTH], [3, 5, 7, 4, 6, 7]),
    // rust: (west_up.open[WEST], [0, 5, 3, 0, 6, 4]),
    // rust: (east_up.open[SOUTH], [11, 5, 0, 12, 6, 0]),
    // rust: (east_up.open[NORTH], [11, 5, 7, 12, 6, 7]),
    // rust: (east_up.open[EAST], [15, 5, 3, 15, 6, 4]),
    // rust: ],
    // rust: )?;
}
    // rust: Kind::DoubleY => {
    // rust: if upper {
    // rust: w.floor(0, 0, r.open[DOWN])?;
}
    // rust: let above = conn(r, UP).unwrap_or(r);
    // rust: if above.conn[UP].is_none() {
    // rust: w.fill_only(1, 8, 1, 6, 8, 6, g)?;
}
    // rust: for [x0, z0, x1, z1] in [
    // rust: [0, 0, 0, 7],
    // rust: [7, 0, 7, 7],
    // rust: [1, 0, 6, 0],
    // rust: [1, 7, 6, 7],
    // rust: [2, 1, 2, 2],
    // rust: [1, 2, 1, 2],
    // rust: [5, 1, 5, 2],
    // rust: [6, 2, 6, 2],
    // rust: [2, 5, 2, 6],
    // rust: [1, 5, 1, 5],
    // rust: [5, 5, 5, 6],
    // rust: [6, 5, 6, 5],
    // rust: ] {
    // rust: w.bx(x0, 4, z0, x1, 4, z1, l)?;
}
    // rust: let mut def = r;
    // rust: for y in [1, 5] {
    // rust: for (side, z) in [(SOUTH, 0), (NORTH, 7)] {
    // rust: if def.open[side] {
    // rust: w.bx(2, y, z, 2, y + 2, z, l)?;
    // rust: w.bx(5, y, z, 5, y + 2, z, l)?;
    // rust: w.bx(3, y + 2, z, 4, y + 2, z, l)?;
    // rust: } else {
    // rust: w.bx(0, y, z, 7, y + 2, z, l)?;
    // rust: w.bx(0, y + 1, z, 7, y + 1, z, g)?;
}
}
    // rust: for (side, x) in [(WEST, 0), (EAST, 7)] {
    // rust: if def.open[side] {
    // rust: w.bx(x, y, 2, x, y + 2, 2, l)?;
    // rust: w.bx(x, y, 5, x, y + 2, 5, l)?;
    // rust: w.bx(x, y + 2, 3, x, y + 2, 4, l)?;
    // rust: } else {
    // rust: w.bx(x, y, 0, x, y + 2, 7, l)?;
    // rust: w.bx(x, y + 1, 0, x, y + 1, 7, g)?;
}
}
    // rust: def = above;
}
}
    // rust: Kind::DoubleYZ => {
    // rust: let north = conn(r, NORTH).unwrap_or(r);
    // rust: let south = r;
    // rust: let north_up = conn(north, UP).unwrap_or(r);
    // rust: let south_up = conn(south, UP).unwrap_or(r);
    // rust: if upper {
    // rust: w.floor(0, 8, north.open[DOWN])?;
    // rust: w.floor(0, 0, south.open[DOWN])?;
}
    // rust: if south_up.conn[UP].is_none() {
    // rust: w.fill_only(1, 8, 1, 6, 8, 7, g)?;
}
    // rust: if north_up.conn[UP].is_none() {
    // rust: w.fill_only(1, 8, 8, 6, 8, 14, g)?;
}
    // rust: for y in 1..=7 {
    // rust: let b = if y == 2 || y == 6 { g } else { l };
    // rust: w.bx(0, y, 0, 0, y, 15, b)?;
    // rust: w.bx(7, y, 0, 7, y, 15, b)?;
    // rust: w.bx(1, y, 0, 6, y, 0, b)?;
    // rust: w.bx(1, y, 15, 6, y, 15, b)?;
}
    // rust: for y in 1..=7 {
    // rust: let b = if y == 2 || y == 6 { lamp } else { k };
    // rust: w.bx(3, y, 7, 4, y, 8, b)?;
}
    // rust: doorways(
    // rust: w,
    // rust: &[
    // rust: (south.open[SOUTH], [3, 1, 0, 4, 2, 0]),
    // rust: (south.open[EAST], [7, 1, 3, 7, 2, 4]),
    // rust: (south.open[WEST], [0, 1, 3, 0, 2, 4]),
    // rust: (north.open[NORTH], [3, 1, 15, 4, 2, 15]),
    // rust: (north.open[WEST], [0, 1, 11, 0, 2, 12]),
    // rust: (north.open[EAST], [7, 1, 11, 7, 2, 12]),
    // rust: (south_up.open[SOUTH], [3, 5, 0, 4, 6, 0]),
    // rust: ],
    // rust: )?;
    // rust: if south_up.open[EAST] {
    // rust: w.water(7, 5, 3, 7, 6, 4)?;
    // rust: w.bx(5, 4, 2, 6, 4, 5, l)?;
    // rust: w.bx(6, 1, 2, 6, 3, 2, l)?;
    // rust: w.bx(6, 1, 5, 6, 3, 5, l)?;
}
    // rust: if south_up.open[WEST] {
    // rust: w.water(0, 5, 3, 0, 6, 4)?;
    // rust: w.bx(1, 4, 2, 2, 4, 5, l)?;
    // rust: w.bx(1, 1, 2, 1, 3, 2, l)?;
    // rust: w.bx(1, 1, 5, 1, 3, 5, l)?;
}
    // rust: if north_up.open[NORTH] {
    // rust: w.water(3, 5, 15, 4, 6, 15)?;
}
    // rust: if north_up.open[WEST] {
    // rust: w.water(0, 5, 11, 0, 6, 12)?;
    // rust: w.bx(1, 4, 10, 2, 4, 13, l)?;
    // rust: w.bx(1, 1, 10, 1, 3, 10, l)?;
    // rust: w.bx(1, 1, 13, 1, 3, 13, l)?;
}
    // rust: if north_up.open[EAST] {
    // rust: w.water(7, 5, 11, 7, 6, 12)?;
    // rust: w.bx(5, 4, 10, 6, 4, 13, l)?;
    // rust: w.bx(6, 1, 10, 6, 3, 10, l)?;
    // rust: w.bx(6, 1, 13, 6, 3, 13, l)?;
}
}
    // rust: Kind::DoubleZ => {
    // rust: let north = conn(r, NORTH).unwrap_or(r);
    // rust: let south = r;
    // rust: if upper {
    // rust: w.floor(0, 8, north.open[DOWN])?;
    // rust: w.floor(0, 0, south.open[DOWN])?;
}
    // rust: if south.conn[UP].is_none() {
    // rust: w.fill_only(1, 4, 1, 6, 4, 7, g)?;
}
    // rust: if north.conn[UP].is_none() {
    // rust: w.fill_only(1, 4, 8, 6, 4, 14, g)?;
}
    // rust: for (y, b) in [(3, l), (2, g), (1, l)] {
    // rust: w.bx(0, y, 0, 0, y, 15, b)?;
    // rust: w.bx(7, y, 0, 7, y, 15, b)?;
    // rust: w.bx(1, y, 0, 7, y, 0, b)?;
    // rust: w.bx(1, y, 15, 6, y, 15, b)?;
}
    // rust: for [x0, y0, z0, x1, y1, z1] in [
    // rust: [1, 1, 1, 1, 1, 2],
    // rust: [6, 1, 1, 6, 1, 2],
    // rust: [1, 3, 1, 1, 3, 2],
    // rust: [6, 3, 1, 6, 3, 2],
    // rust: [1, 1, 13, 1, 1, 14],
    // rust: [6, 1, 13, 6, 1, 14],
    // rust: [1, 3, 13, 1, 3, 14],
    // rust: [6, 3, 13, 6, 3, 14],
    // rust: [2, 1, 6, 2, 3, 6],
    // rust: [5, 1, 6, 5, 3, 6],
    // rust: [2, 1, 9, 2, 3, 9],
    // rust: [5, 1, 9, 5, 3, 9],
    // rust: [3, 2, 6, 4, 2, 6],
    // rust: [3, 2, 9, 4, 2, 9],
    // rust: [2, 2, 7, 2, 2, 8],
    // rust: [5, 2, 7, 5, 2, 8],
    // rust: ] {
    // rust: w.bx(x0, y0, z0, x1, y1, z1, l)?;
}
    // rust: for [x, z] in [[2, 5], [5, 5], [2, 10], [5, 10]] {
    // rust: w.put(lamp, x, 2, z)?;
}
    // rust: for [x, z] in [[2, 5], [5, 5], [2, 10], [5, 10]] {
    // rust: w.put(l, x, 3, z)?;
}
    // rust: doorways(
    // rust: w,
    // rust: &[
    // rust: (south.open[SOUTH], [3, 1, 0, 4, 2, 0]),
    // rust: (south.open[EAST], [7, 1, 3, 7, 2, 4]),
    // rust: (south.open[WEST], [0, 1, 3, 0, 2, 4]),
    // rust: (north.open[NORTH], [3, 1, 15, 4, 2, 15]),
    // rust: (north.open[WEST], [0, 1, 11, 0, 2, 12]),
    // rust: (north.open[EAST], [7, 1, 11, 7, 2, 12]),
    // rust: ],
    // rust: )?;
}
    // rust: Kind::Entry => {
    // rust: for [x0, y0, z0, x1, y1, z1] in [
    // rust: [0, 3, 0, 2, 3, 7],
    // rust: [5, 3, 0, 7, 3, 7],
    // rust: [0, 2, 0, 1, 2, 7],
    // rust: [6, 2, 0, 7, 2, 7],
    // rust: [0, 1, 0, 0, 1, 7],
    // rust: [7, 1, 0, 7, 1, 7],
    // rust: [0, 1, 7, 7, 3, 7],
    // rust: [1, 1, 0, 2, 3, 0],
    // rust: [5, 1, 0, 6, 3, 0],
    // rust: ] {
    // rust: w.bx(x0, y0, z0, x1, y1, z1, l)?;
}
    // rust: doorways(
    // rust: w,
    // rust: &[
    // rust: (r.open[NORTH], [3, 1, 7, 4, 2, 7]),
    // rust: (r.open[WEST], [0, 1, 3, 1, 2, 4]),
    // rust: (r.open[EAST], [6, 1, 3, 7, 2, 4]),
    // rust: ],
    // rust: )?;
}
    // rust: Kind::Penthouse => {
    // rust: w.bx(2, -1, 2, 11, -1, 11, l)?;
    // rust: w.bx(0, -1, 0, 1, -1, 11, g)?;
    // rust: w.bx(12, -1, 0, 13, -1, 11, g)?;
    // rust: w.bx(2, -1, 0, 11, -1, 1, g)?;
    // rust: w.bx(2, -1, 12, 11, -1, 13, g)?;
    // rust: w.bx(0, 0, 0, 0, 0, 13, l)?;
    // rust: w.bx(13, 0, 0, 13, 0, 13, l)?;
    // rust: w.bx(1, 0, 0, 12, 0, 0, l)?;
    // rust: w.bx(1, 0, 13, 12, 0, 13, l)?;
    // rust: for i in (2..=11).step_by(3) {
    // rust: w.put(lamp, 0, 0, i)?;
    // rust: w.put(lamp, 13, 0, i)?;
    // rust: w.put(lamp, i, 0, 0)?;
}
    // rust: w.bx(2, 0, 3, 4, 0, 9, l)?;
    // rust: w.bx(9, 0, 3, 11, 0, 9, l)?;
    // rust: w.bx(4, 0, 9, 9, 0, 11, l)?;
    // rust: w.put(l, 5, 0, 8)?;
    // rust: w.put(l, 8, 0, 8)?;
    // rust: w.put(l, 10, 0, 10)?;
    // rust: w.put(l, 3, 0, 10)?;
    // rust: w.bx(3, 0, 3, 3, 0, 7, k)?;
    // rust: w.bx(10, 0, 3, 10, 0, 7, k)?;
    // rust: w.bx(6, 0, 10, 7, 0, 10, k)?;
    // rust: for x in [3, 10] {
    // rust: for z in (2..=8).step_by(3) {
    // rust: w.bx(x, 0, z, x, 2, z, l)?;
}
}
    // rust: w.bx(5, 0, 10, 5, 2, 10, l)?;
    // rust: w.bx(8, 0, 10, 8, 2, 10, l)?;
    // rust: w.bx(6, -1, 7, 7, -1, 8, k)?;
    // rust: w.water(6, -1, 3, 7, -1, 4)?;
    // rust: w.elder(6, 1, 6)?;
}
    // rust: Kind::Simple(design) => {
    // rust: if upper {
    // rust: w.floor(0, 0, r.open[DOWN])?;
}
    // rust: if r.conn[UP].is_none() {
    // rust: w.fill_only(1, 4, 1, 6, 4, 6, g)?;
}
    // rust: let pillar = design != 0
    // rust: && w.c.random.boolean()
    // rust: && !r.open[DOWN]
    // rust: && !r.open[UP]
    // rust: && r.open.iter().filter(|o| **o).count() > 1;
    // rust: match design {
    // rust: 0 => {
    // rust: for (xa, xb, za, zb, gx, gz, lx, lz) in [
    // rust: (0, 2, 0, 2, [0, 0, 0, 2], [1, 2, 0, 0], 1, 1),
    // rust: (5, 7, 0, 2, [7, 7, 0, 2], [5, 6, 0, 0], 6, 1),
    // rust: (0, 2, 5, 7, [0, 0, 5, 7], [1, 2, 7, 7], 1, 6),
    // rust: (5, 7, 5, 7, [7, 7, 5, 7], [5, 6, 7, 7], 6, 6),
    // rust: ] {
    // rust: w.bx(xa, 1, za, xb, 1, zb, l)?;
    // rust: w.bx(xa, 3, za, xb, 3, zb, l)?;
    // rust: w.bx(gx[0], 2, gx[2], gx[1], 2, gx[3], g)?;
    // rust: w.bx(gz[0], 2, gz[2], gz[1], 2, gz[3], g)?;
    // rust: w.put(lamp, lx, 2, lz)?;
}
    // rust: if r.open[SOUTH] {
    // rust: w.bx(3, 3, 0, 4, 3, 0, l)?;
    // rust: } else {
    // rust: w.bx(3, 3, 0, 4, 3, 1, l)?;
    // rust: w.bx(3, 2, 0, 4, 2, 0, g)?;
    // rust: w.bx(3, 1, 0, 4, 1, 1, l)?;
}
    // rust: if r.open[NORTH] {
    // rust: w.bx(3, 3, 7, 4, 3, 7, l)?;
    // rust: } else {
    // rust: w.bx(3, 3, 6, 4, 3, 7, l)?;
    // rust: w.bx(3, 2, 7, 4, 2, 7, g)?;
    // rust: w.bx(3, 1, 6, 4, 1, 7, l)?;
}
    // rust: if r.open[WEST] {
    // rust: w.bx(0, 3, 3, 0, 3, 4, l)?;
    // rust: } else {
    // rust: w.bx(0, 3, 3, 1, 3, 4, l)?;
    // rust: w.bx(0, 2, 3, 0, 2, 4, g)?;
    // rust: w.bx(0, 1, 3, 1, 1, 4, l)?;
}
    // rust: if r.open[EAST] {
    // rust: w.bx(7, 3, 3, 7, 3, 4, l)?;
    // rust: } else {
    // rust: w.bx(6, 3, 3, 7, 3, 4, l)?;
    // rust: w.bx(7, 2, 3, 7, 2, 4, g)?;
    // rust: w.bx(6, 1, 3, 7, 1, 4, l)?;
}
}
    // rust: 1 => {
    // rust: for [x, z] in [[2, 2], [2, 5], [5, 5], [5, 2]] {
    // rust: w.bx(x, 1, z, x, 3, z, l)?;
}
    // rust: for [x, z] in [[2, 2], [2, 5], [5, 5], [5, 2]] {
    // rust: w.put(lamp, x, 2, z)?;
}
    // rust: for [x0, z0, x1, z1] in [
    // rust: [0, 0, 1, 0],
    // rust: [0, 1, 0, 1],
    // rust: [0, 7, 1, 7],
    // rust: [0, 6, 0, 6],
    // rust: [6, 7, 7, 7],
    // rust: [7, 6, 7, 6],
    // rust: [6, 0, 7, 0],
    // rust: [7, 1, 7, 1],
    // rust: ] {
    // rust: w.bx(x0, 1, z0, x1, 3, z1, l)?;
}
    // rust: for [x, z] in [
    // rust: [1, 0],
    // rust: [0, 1],
    // rust: [1, 7],
    // rust: [0, 6],
    // rust: [6, 7],
    // rust: [7, 6],
    // rust: [6, 0],
    // rust: [7, 1],
    // rust: ] {
    // rust: w.put(g, x, 2, z)?;
}
    // rust: for (side, [x0, z0, x1, z1]) in [
    // rust: (SOUTH, [1, 0, 6, 0]),
    // rust: (NORTH, [1, 7, 6, 7]),
    // rust: (WEST, [0, 1, 0, 6]),
    // rust: (EAST, [7, 1, 7, 6]),
    // rust: ] {
    // rust: if !r.open[side] {
    // rust: w.bx(x0, 3, z0, x1, 3, z1, l)?;
    // rust: w.bx(x0, 2, z0, x1, 2, z1, g)?;
    // rust: w.bx(x0, 1, z0, x1, 1, z1, l)?;
}
}
}
    // rust: 2 => {
    // rust: for (y, b) in [(1, l), (2, k), (3, l)] {
    // rust: w.bx(0, y, 0, 0, y, 7, b)?;
    // rust: w.bx(7, y, 0, 7, y, 7, b)?;
    // rust: w.bx(1, y, 0, 6, y, 0, b)?;
    // rust: w.bx(1, y, 7, 6, y, 7, b)?;
}
    // rust: w.bx(0, 1, 3, 0, 2, 4, k)?;
    // rust: w.bx(7, 1, 3, 7, 2, 4, k)?;
    // rust: w.bx(3, 1, 0, 4, 2, 0, k)?;
    // rust: w.bx(3, 1, 7, 4, 2, 7, k)?;
    // rust: doorways(
    // rust: w,
    // rust: &[
    // rust: (r.open[SOUTH], [3, 1, 0, 4, 2, 0]),
    // rust: (r.open[NORTH], [3, 1, 7, 4, 2, 7]),
    // rust: (r.open[WEST], [0, 1, 3, 0, 2, 4]),
    // rust: (r.open[EAST], [7, 1, 3, 7, 2, 4]),
    // rust: ],
    // rust: )?;
}
    // rust: _ => {}
}
    // rust: if pillar {
    // rust: w.bx(3, 1, 3, 4, 1, 4, l)?;
    // rust: w.bx(3, 2, 3, 4, 2, 4, g)?;
    // rust: w.bx(3, 3, 3, 4, 3, 4, l)?;
}
}
    // rust: Kind::SimpleTop => {
    // rust: if upper {
    // rust: w.floor(0, 0, r.open[DOWN])?;
}
    // rust: if r.conn[UP].is_none() {
    // rust: w.fill_only(1, 4, 1, 6, 4, 6, g)?;
}
    // rust: let sponge = w.c.state("wet_sponge");
    // rust: for x in 1..=6 {
    // rust: for z in 1..=6 {
    // rust: if w.c.random.int(3) != 0 {
    // rust: let y0 = 2 + if w.c.random.int(4) == 0 { 0 } else { 1 };
    // rust: w.bx(x, y0, z, x, 3, z, sponge)?;
}
}
}
    // rust: for (y, b) in [(1, l), (2, k), (3, l)] {
    // rust: w.bx(0, y, 0, 0, y, 7, b)?;
    // rust: w.bx(7, y, 0, 7, y, 7, b)?;
    // rust: w.bx(1, y, 0, 6, y, 0, b)?;
    // rust: w.bx(1, y, 7, 6, y, 7, b)?;
}
    // rust: w.bx(0, 1, 3, 0, 2, 4, k)?;
    // rust: w.bx(7, 1, 3, 7, 2, 4, k)?;
    // rust: w.bx(3, 1, 0, 4, 2, 0, k)?;
    // rust: w.bx(3, 1, 7, 4, 2, 7, k)?;
    // rust: if r.open[SOUTH] {
    // rust: w.water(3, 1, 0, 4, 2, 0)?;
}
}
    // rust: Kind::Wing(0) => {
    // rust: for i in 0..4 {
    // rust: w.bx(10 - i, 3 - i, 20 - i, 12 + i, 3 - i, 20, l)?;
}
    // rust: for [x0, y0, z0, x1, y1, z1] in [
    // rust: [7, 0, 6, 15, 0, 16],
    // rust: [6, 0, 6, 6, 3, 20],
    // rust: [16, 0, 6, 16, 3, 20],
    // rust: [7, 1, 7, 7, 1, 20],
    // rust: [15, 1, 7, 15, 1, 20],
    // rust: [7, 1, 6, 9, 3, 6],
    // rust: [13, 1, 6, 15, 3, 6],
    // rust: [8, 1, 7, 9, 1, 7],
    // rust: [13, 1, 7, 14, 1, 7],
    // rust: [9, 0, 5, 13, 0, 5],
    // rust: ] {
    // rust: w.bx(x0, y0, z0, x1, y1, z1, l)?;
}
    // rust: w.bx(10, 0, 7, 12, 0, 7, k)?;
    // rust: w.bx(8, 0, 10, 8, 0, 12, k)?;
    // rust: w.bx(14, 0, 10, 14, 0, 12, k)?;
    // rust: for z in (7..=18).rev().step_by(3) {
    // rust: w.put(lamp, 6, 3, z)?;
    // rust: w.put(lamp, 16, 3, z)?;
}
    // rust: for [x, y, z] in [
    // rust: [10, 0, 10],
    // rust: [12, 0, 10],
    // rust: [10, 0, 12],
    // rust: [12, 0, 12],
    // rust: [8, 3, 6],
    // rust: [14, 3, 6],
    // rust: ] {
    // rust: w.put(lamp, x, y, z)?;
}
    // rust: for [x, z] in [[4, 4], [18, 4], [4, 18], [18, 18]] {
    // rust: w.put(l, x, 2, z)?;
    // rust: w.put(lamp, x, 1, z)?;
    // rust: w.put(l, x, 0, z)?;
}
    // rust: w.put(l, 9, 7, 20)?;
    // rust: w.put(l, 13, 7, 20)?;
    // rust: w.bx(6, 0, 21, 7, 4, 21, l)?;
    // rust: w.bx(15, 0, 21, 16, 4, 21, l)?;
    // rust: w.elder(11, 2, 16)?;
}
    // rust: Kind::Wing(_) => {
    // rust: w.bx(9, 3, 18, 13, 3, 20, l)?;
    // rust: w.bx(9, 0, 18, 9, 2, 18, l)?;
    // rust: w.bx(13, 0, 18, 13, 2, 18, l)?;
    // rust: for x in [9, 13] {
    // rust: w.put(l, x, 6, 20)?;
    // rust: w.put(lamp, x, 5, 20)?;
    // rust: w.put(l, x, 4, 20)?;
}
    // rust: w.bx(7, 3, 7, 15, 3, 14, l)?;
    // rust: for x in [10, 12] {
    // rust: w.bx(x, 0, 10, x, 6, 10, l)?;
    // rust: w.bx(x, 0, 12, x, 6, 12, l)?;
    // rust: w.put(lamp, x, 0, 10)?;
    // rust: w.put(lamp, x, 0, 12)?;
    // rust: w.put(lamp, x, 4, 10)?;
    // rust: w.put(lamp, x, 4, 12)?;
}
    // rust: for x in [8, 14] {
    // rust: w.bx(x, 0, 7, x, 2, 7, l)?;
    // rust: w.bx(x, 0, 14, x, 2, 14, l)?;
}
    // rust: w.bx(8, 3, 8, 8, 3, 13, k)?;
    // rust: w.bx(14, 3, 8, 14, 3, 13, k)?;
    // rust: w.elder(11, 5, 13)?;
}
}
    // rust: Ok(())
}
