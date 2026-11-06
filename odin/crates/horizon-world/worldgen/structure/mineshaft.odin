//! Transpiled from Horizon Rust crate
package horizon_world_mineshaft

import "core:fmt"
import "core:mem"
import "core:math"

// Mineshafts: MineshaftStructure and MineshaftPieces.
// use super::{
    // rust: BoundingBox,
    // rust: legacy::{LegacyPiece, PieceContext, PieceFrame, Result, solid_render},
}
// use crate::nbt::Tag;
// use crate::worldgen::biome::BiomeId;
// use horizon_core::{geometry::Direction, random::RandomSource};
// use std::{
    // rust: collections::BTreeSet,
    // rust: sync::{Arc, Mutex},
}

// MineshaftStructure.Type: wood, planks, fence, and the blocks pieces keep.
Wood :: struct {
    log: ^'static str,
    planks: ^'static str,
    fence: ^'static str,
    keep: ^'static [^'static str],
}
    // rust: pub const NORMAL: Wood = Wood {
    // rust: log: "minecraft:oak_log",
    // rust: planks: "minecraft:oak_planks",
    // rust: fence: "minecraft:oak_fence",
    // rust: keep: &[
    // rust: "minecraft:oak_planks",
    // rust: "minecraft:oak_log",
    // rust: "minecraft:oak_fence",
    // rust: "minecraft:iron_chain",
    // rust: ],
}
    // rust: pub const MESA: Wood = Wood {
    // rust: log: "minecraft:dark_oak_log",
    // rust: planks: "minecraft:dark_oak_planks",
    // rust: fence: "minecraft:dark_oak_fence",
    // rust: keep: &[
    // rust: "minecraft:dark_oak_planks",
    // rust: "minecraft:dark_oak_log",
    // rust: "minecraft:dark_oak_fence",
    // rust: "minecraft:iron_chain",
    // rust: ],
}

Kind :: enum {
    Room(Vec<BoundingBox>),
    Corridor {,
    rails: bool,
    spider: bool,
    sections: i32,
    placed_spider: Mutex<bool>,
    // rust: },
    Crossing {,
    direction: Direction,
    two_floored: bool,
    // rust: },
    Stairs,
}
MineshaftPiece :: struct {
    kind: Kind,
    frame: PieceFrame,
    depth: i32,
    wood: Wood,
    blocking: ^BTreeSet<BiomeId>,
}

int :: proc(r: ^impl RandomSource, bound: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: r.next_int_bound(bound).unwrap_or(0)
}
bb :: proc(a: [i32; 3], b: [i32; 3], at: [i32; 3]) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BoundingBox::new(a, b).moved(at)
}

Builder :: struct {
    pieces: [dynamic]MineshaftPiece,
}
    // rust: impl Builder {
collides :: proc(self: ^Self, b: ^BoundingBox) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.pieces
    // rust: .iter()
    // rust: .any(|p| p.frame.bounding_box.intersects(b))
}
    // rust: fn piece(
    // rust: &self,
    // rust: kind: Kind,
    // rust: b: BoundingBox,
    // rust: o: Option<Direction>,
    // rust: depth: i32,
    // rust: ) -> MineshaftPiece {
    // rust: let start = &self.pieces[0];
    // rust: let mut frame = PieceFrame::new(b, o);
    // rust: frame.keep = start.wood.keep;
    // rust: MineshaftPiece {
    // rust: kind,
    // rust: frame,
    // rust: depth,
    // rust: wood: start.wood,
    // rust: blocking: start.blocking.clone(),
}
}
    // MineshaftPieces.createRandomShaftPiece.
    // rust: fn create(
    // rust: &self,
    // rust: r: &mut impl RandomSource,
    // rust: at: [i32; 3],
    // rust: d: Direction,
    // rust: depth: i32,
    // rust: ) -> Option<MineshaftPiece> {
    // rust: let selection = int(r, 100);
    // rust: if selection >= 80 {
    // rust: let y1 = if int(r, 4) == 0 { 6 } else { 2 };
    // rust: let b = match d {
    // rust: Direction::South => bb([-1, 0, 0], [3, y1, 4], at),
    // rust: Direction::West => bb([-4, 0, -1], [0, y1, 3], at),
    // rust: Direction::East => bb([0, 0, -1], [4, y1, 3], at),
    // rust: _ => bb([-1, 0, -4], [3, y1, 0], at),
}
    // rust: if self.collides(&b) {
    // rust: return None;
}
    // rust: let kind = Kind::Crossing {
    // rust: direction: d,
    // rust: two_floored: b.span()[1] > 3,
}
    // rust: Some(self.piece(kind, b, None, depth))
    // rust: } else if selection >= 70 {
    // rust: let b = match d {
    // rust: Direction::South => bb([0, -5, 0], [2, 2, 8], at),
    // rust: Direction::West => bb([-8, -5, 0], [0, 2, 2], at),
    // rust: Direction::East => bb([0, -5, 0], [8, 2, 2], at),
    // rust: _ => bb([0, -5, -8], [2, 2, 0], at),
}
    // rust: (!self.collides(&b)).then(|| self.piece(Kind::Stairs, b, Some(d), depth))
    // rust: } else {
    // rust: let mut length = int(r, 3) + 2;
    // rust: while length > 0 {
    // rust: let l = length * 5 - 1;
    // rust: let b = match d {
    // rust: Direction::South => bb([0, 0, 0], [2, 2, l], at),
    // rust: Direction::West => bb([-l, 0, 0], [0, 2, 2], at),
    // rust: Direction::East => bb([0, 0, 0], [l, 2, 2], at),
    // rust: _ => bb([0, 0, -l], [2, 2, 0], at),
}
    // rust: if !self.collides(&b) {
    // rust: let rails = int(r, 3) == 0;
    // rust: let spider = !rails && int(r, 23) == 0;
    // rust: let axis = if matches!(d, Direction::North | Direction::South) {
    // rust: 2
    // rust: } else {
    // rust: 0
}
    // rust: let kind = Kind::Corridor {
    // rust: rails,
    // rust: spider,
    // rust: sections: b.span()[axis] / 5,
    // rust: placed_spider: Mutex::new(false),
}
    // rust: return Some(self.piece(kind, b, Some(d), depth));
}
    // rust: length -= 1;
}
    // rust: None
}
}
    // MineshaftPieces.generateAndAddPiece; returns the new piece's box.
    // rust: fn add(
    // rust: &mut self,
    // rust: r: &mut impl RandomSource,
    // rust: at: [i32; 3],
    // rust: d: Direction,
    // rust: depth: i32,
    // rust: ) -> Option<BoundingBox> {
    // rust: if depth > 8 {
    // rust: return None;
}
    // rust: let start = self.pieces[0].frame.bounding_box;
    // rust: if (at[0] - start.min[0]).abs() > 80 || (at[2] - start.min[2]).abs() > 80 {
    // rust: return None;
}
    // rust: let piece = self.create(r, at, d, depth + 1)?;
    // rust: let b = piece.frame.bounding_box;
    // rust: self.pieces.push(piece);
    // rust: self.add_children(r, self.pieces.len() - 1);
    // rust: Some(b)
}
add_children :: proc(self: ^Self, r: ^impl RandomSource, index: uint) {
}
    // rust: let p = &self.pieces[index];
    // rust: let (b, depth, orientation) = (p.frame.bounding_box, p.depth, p.frame.orientation);
    // rust: let ([x0, y0, z0], [x1, _y1, z1]) = (b.min, b.max);
//         use Direction::*;
    // rust: match &p.kind {
    // rust: Kind::Room(_) => {
    // rust: let height = (b.span()[1] - 4).max(1);
    // rust: let [xs, _, zs] = b.span();
    // rust: for side in 0..4 {
    // rust: let span = if side < 2 { xs } else { zs };
    // rust: let mut pos = 0;
    // rust: while pos < span {
    // rust: pos += int(r, span);
    // rust: if pos + 3 > span {
    // rust: break;
}
    // rust: let y = y0 + int(r, height) + 1;
    // rust: let (at, d) = match side {
    // rust: 0 => ([x0 + pos, y, z0 - 1], North),
    // rust: 1 => ([x0 + pos, y, z1 + 1], South),
    // rust: 2 => ([x0 - 1, y, z0 + pos], West),
    // rust: _ => ([x1 + 1, y, z0 + pos], East),
}
    // rust: if let Some(c) = self.add(r, at, d, depth) {
    // rust: let entrance = match side {
    // rust: 0 => BoundingBox::new(
    // rust: [c.min[0], c.min[1], z0],
    // rust: [c.max[0], c.max[1], z0 + 1],
    // rust: ),
    // rust: 1 => BoundingBox::new(
    // rust: [c.min[0], c.min[1], z1 - 1],
    // rust: [c.max[0], c.max[1], z1],
    // rust: ),
    // rust: 2 => BoundingBox::new(
    // rust: [x0, c.min[1], c.min[2]],
    // rust: [x0 + 1, c.max[1], c.max[2]],
    // rust: ),
    // rust: _ => BoundingBox::new(
    // rust: [x1 - 1, c.min[1], c.min[2]],
    // rust: [x1, c.max[1], c.max[2]],
    // rust: ),
}
    // rust: if let Kind::Room(entrances) = &mut self.pieces[index].kind {
    // rust: entrances.push(entrance);
}
}
    // rust: pos += 4;
}
}
}
    // rust: Kind::Corridor { .. } => {
    // rust: let end = int(r, 4);
    // rust: let o = orientation.unwrap_or(North);
    // rust: let (forward, left, right) = match o {
    // rust: South => (
    // rust: [x0, z1 + 1],
    // rust: (West, [x0 - 1, z1 - 3]),
    // rust: (East, [x1 + 1, z1 - 3]),
    // rust: ),
    // rust: West => ([x0 - 1, z0], (North, [x0, z0 - 1]), (South, [x0, z1 + 1])),
    // rust: East => (
    // rust: [x1 + 1, z0],
    // rust: (North, [x1 - 3, z0 - 1]),
    // rust: (South, [x1 - 3, z1 + 1]),
    // rust: ),
    // rust: _ => ([x0, z0 - 1], (West, [x0 - 1, z0]), (East, [x1 + 1, z0])),
}
    // rust: let (d, [x, z]) = match end {
    // rust: 0 | 1 => (o, forward),
    // rust: 2 => left,
    // rust: _ => right,
}
    // rust: let y = y0 - 1 + int(r, 3);
    // rust: self.add(r, [x, y, z], d, depth);
    // rust: if depth < 8 {
    // rust: if o != North && o != South {
    // rust: let mut x = x0 + 3;
    // rust: while x + 3 <= x1 {
    // rust: match int(r, 5) {
    // rust: 0 => {
    // rust: self.add(r, [x, y0, z0 - 1], North, depth + 1);
}
    // rust: 1 => {
    // rust: self.add(r, [x, y0, z1 + 1], South, depth + 1);
}
    // rust: _ => {}
}
    // rust: x += 5;
}
    // rust: } else {
    // rust: let mut z = z0 + 3;
    // rust: while z + 3 <= z1 {
    // rust: match int(r, 5) {
    // rust: 0 => {
    // rust: self.add(r, [x0 - 1, y0, z], West, depth + 1);
}
    // rust: 1 => {
    // rust: self.add(r, [x1 + 1, y0, z], East, depth + 1);
}
    // rust: _ => {}
}
    // rust: z += 5;
}
}
}
}
    // rust: Kind::Crossing {
    // rust: direction,
    // rust: two_floored,
    // rust: } => {
    // rust: let two = *two_floored;
    // rust: let n = ([x0 + 1, y0, z0 - 1], North);
    // rust: let s = ([x0 + 1, y0, z1 + 1], South);
    // rust: let w = ([x0 - 1, y0, z0 + 1], West);
    // rust: let e = ([x1 + 1, y0, z0 + 1], East);
    // rust: let order = match direction {
    // rust: South => [s, w, e],
    // rust: West => [n, s, w],
    // rust: East => [n, s, e],
    // rust: _ => [n, w, e],
}
    // rust: for (at, d) in order {
    // rust: self.add(r, at, d, depth);
}
    // rust: if two {
    // rust: for (at, d) in [n, w, e, s] {
    // rust: if r.next_boolean() {
    // rust: self.add(r, [at[0], y0 + 4, at[2]], d, depth);
}
}
}
}
    // rust: Kind::Stairs => {
    // rust: let (at, d) = match orientation.unwrap_or(North) {
    // rust: South => ([x0, y0, z1 + 1], South),
    // rust: West => ([x0 - 1, y0, z0], West),
    // rust: East => ([x1 + 1, y0, z0], East),
    // rust: _ => ([x0, y0, z0 - 1], North),
}
    // rust: self.add(r, at, d, depth);
}
}
}
}

// MineshaftStructure.findGenerationPoint: the pieces and the start position.
    // rust: pub fn generate(
    // rust: r: &mut impl RandomSource,
    // rust: chunk: [i32; 2],
    // rust: mesa: bool,
    // rust: blocking: Arc<BTreeSet<BiomeId>>,
    // rust: sea_level: i32,
    // rust: min_y: i32,
    // rust: surface: &mut dyn FnMut(i32, i32) -> i32,
    // rust: ) -> ([i32; 3], Vec<MineshaftPiece>) {
    // rust: r.next_double();
    // rust: let (west, north) = (chunk[0] * 16 + 2, chunk[1] * 16 + 2);
    // rust: let room = BoundingBox::new(
    // rust: [west, 50, north],
    // rust: [west + 7 + int(r, 6), 54 + int(r, 6), north + 7 + int(r, 6)],
    // rust: );
    // rust: let wood = if mesa { MESA } else { NORMAL };
    // rust: let mut frame = PieceFrame::new(room, None);
    // rust: frame.keep = wood.keep;
    // rust: let mut builder = Builder {
    // rust: pieces: vec![MineshaftPiece {
    // rust: kind: Kind::Room(Vec::new()),
    // rust: frame,
    // rust: depth: 0,
    // rust: wood,
    // rust: blocking,
    // rust: }],
}
    // rust: builder.add_children(r, 0);
    // rust: let mut all = builder.pieces[0].frame.bounding_box;
    // rust: for p in &builder.pieces[1..] {
    // rust: all.encapsulate(&p.frame.bounding_box);
}
    // rust: let dy = if mesa {
    // rust: let center = all.center();
    // rust: let height = surface(center[0], center[2]);
    // rust: let target = if height <= sea_level {
    // rust: sea_level
    // rust: } else {
    // rust: int(r, height - sea_level + 1) + sea_level
}
    // rust: target - center[1]
    // rust: } else {
    // rust: let max = sea_level - 10;
    // rust: let mut y1 = all.span()[1] + min_y + 1;
    // rust: if y1 < max {
    // rust: y1 += int(r, max - y1);
}
    // rust: y1 - all.max[1]
}
    // rust: for p in &mut builder.pieces {
    // rust: p.frame.bounding_box = p.frame.bounding_box.moved([0, dy, 0]);
    // rust: if let Kind::Room(entrances) = &mut p.kind {
    // rust: for e in entrances {
    // rust: *e = e.moved([0, dy, 0]);
}
}
}
    // rust: ([chunk[0] * 16 + 8, 50 + dy, chunk[1] * 16], builder.pieces)
}

replaceable :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:air"
    // rust: | "minecraft:cave_air"
    // rust: | "minecraft:void_air"
    // rust: | "minecraft:water"
    // rust: | "minecraft:lava"
    // rust: | "minecraft:glow_lichen"
    // rust: | "minecraft:seagrass"
    // rust: | "minecraft:tall_seagrass"
    // rust: )
}
falling :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:sand"
    // rust: | "minecraft:red_sand"
    // rust: | "minecraft:gravel"
    // rust: | "minecraft:anvil"
    // rust: | "minecraft:chipped_anvil"
    // rust: | "minecraft:damaged_anvil"
    // rust: | "minecraft:dragon_egg"
    // rust: ) || name.ends_with("_concrete_powder")
}

    // rust: impl MineshaftPiece {
invalid :: proc(self: ^Self, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (b, k) = (self.frame.bounding_box, c.chunk_box);
    // rust: let lo: [i32; 3] = std::array::from_fn(|i| (b.min[i] - 1).max(k.min[i]));
    // rust: let hi: [i32; 3] = std::array::from_fn(|i| (b.max[i] + 1).min(k.max[i]));
    // rust: let center = std::array::from_fn(|i| (lo[i] + hi[i]) / 2);
    // rust: if self.blocking.contains(&c.world.biome(center)?) {
    // rust: return Ok(true);
}
    // rust: let liquid = |c: &mut PieceContext<'_>, p: [i32; 3]| -> Result<bool> {
    // rust: let s = c.world.block(p)?;
    // rust: Ok(c.is_liquid(s))
}
    // rust: for x in lo[0]..=hi[0] {
    // rust: for z in lo[2]..=hi[2] {
    // rust: if liquid(c, [x, lo[1], z])? || liquid(c, [x, hi[1], z])? {
    // rust: return Ok(true);
}
}
}
    // rust: for x in lo[0]..=hi[0] {
    // rust: for y in lo[1]..=hi[1] {
    // rust: if liquid(c, [x, y, lo[2]])? || liquid(c, [x, y, hi[2]])? {
    // rust: return Ok(true);
}
}
}
    // rust: for z in lo[2]..=hi[2] {
    // rust: for y in lo[1]..=hi[1] {
    // rust: if liquid(c, [lo[0], y, z])? || liquid(c, [hi[0], y, z])? {
    // rust: return Ok(true);
}
}
}
    // rust: Ok(false)
}
set_planks :: proc(self: ^Self, c: ^PieceContext<'_>, x: i32, y: i32, z: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.frame.is_interior(c, x, y, z)? {
    // rust: let pos = self.frame.world_pos(x, y, z);
    // rust: if !c.world.face_sturdy(pos, Direction::Up)? {
    // rust: c.world.set(pos, c.state(self.wood.planks), 2)?;
}
}
    // rust: Ok(())
}
air_box :: proc(self: ^Self, c: ^PieceContext<'_>, a: [i32; 3], b: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let air = c.state("cave_air");
    // rust: self.frame.generate_box(c, a, b, air, air, false)
}
room :: proc(self: ^Self, c: ^PieceContext<'_>, entrances: ^[BoundingBox]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.frame.bounding_box;
    // rust: self.air_box(
    // rust: c,
    // rust: [b.min[0], b.min[1] + 1, b.min[2]],
    // rust: [b.max[0], (b.min[1] + 3).min(b.max[1]), b.max[2]],
    // rust: )?;
    // rust: for e in entrances {
    // rust: self.air_box(c, [e.min[0], e.max[1] - 2, e.min[2]], e.max)?;
}
    // rust: let air = c.state("cave_air");
    // rust: self.frame
    // rust: .upper_half_sphere(c, [b.min[0], b.min[1] + 4, b.min[2]], b.max, air, false)
}
crossing :: proc(self: ^Self, c: ^PieceContext<'_>, two_floored: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let ([x0, y0, z0], [x1, y1, z1]) =
    // rust: (self.frame.bounding_box.min, self.frame.bounding_box.max);
    // rust: if two_floored {
    // rust: self.air_box(c, [x0 + 1, y0, z0], [x1 - 1, y0 + 2, z1])?;
    // rust: self.air_box(c, [x0, y0, z0 + 1], [x1, y0 + 2, z1 - 1])?;
    // rust: self.air_box(c, [x0 + 1, y1 - 2, z0], [x1 - 1, y1, z1])?;
    // rust: self.air_box(c, [x0, y1 - 2, z0 + 1], [x1, y1, z1 - 1])?;
    // rust: self.air_box(c, [x0 + 1, y0 + 3, z0 + 1], [x1 - 1, y0 + 3, z1 - 1])?;
    // rust: } else {
    // rust: self.air_box(c, [x0 + 1, y0, z0], [x1 - 1, y1, z1])?;
    // rust: self.air_box(c, [x0, y0, z0 + 1], [x1, y1, z1 - 1])?;
}
    // rust: let planks = c.state(self.wood.planks);
    // rust: let air = c.state("cave_air");
    // rust: for (x, z) in [
    // rust: (x0 + 1, z0 + 1),
    // rust: (x0 + 1, z1 - 1),
    // rust: (x1 - 1, z0 + 1),
    // rust: (x1 - 1, z1 - 1),
    // rust: ] {
    // rust: let above = self.frame.get(c, x, y1 + 1, z)?;
    // rust: if !c.is_air(above) {
    // rust: self.frame
    // rust: .generate_box(c, [x, y0, z], [x, y1, z], planks, air, false)?;
}
}
    // rust: for x in x0..=x1 {
    // rust: for z in z0..=z1 {
    // rust: self.set_planks(c, x, y0 - 1, z)?;
}
}
    // rust: Ok(())
}
stairs :: proc(self: ^Self, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.air_box(c, [0, 5, 0], [2, 7, 1])?;
    // rust: self.air_box(c, [0, 0, 7], [2, 2, 8])?;
    // rust: for i in 0..5 {
    // rust: self.air_box(c, [0, 5 - i - i32::from(i < 4), 2 + i], [2, 7 - i, 2 + i])?;
}
    // rust: Ok(())
}
    // rust: fn corridor(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: rails: bool,
    // rust: spider: bool,
    // rust: sections: i32,
    // rust: placed_spider: &Mutex<bool>,
    // rust: ) -> Result<()> {
    // rust: let f = self.frame;
    // rust: let length = sections * 5 - 1;
    // rust: let air = c.state("cave_air");
    // rust: let web = c.state("cobweb");
    // rust: f.generate_box(c, [0, 0, 0], [2, 1, length], air, air, false)?;
    // rust: f.generate_maybe_box(c, 0.8, [0, 2, 0], [2, 2, length], air, air, false, false)?;
    // rust: if spider {
    // rust: f.generate_maybe_box(c, 0.6, [0, 0, 0], [2, 1, length], web, air, false, true)?;
}
    // rust: for section in 0..sections {
    // rust: let z = 2 + section * 5;
    // rust: self.support(c, z)?;
    // rust: for (p, x, dz) in [
    // rust: (0.1, 0, -1),
    // rust: (0.1, 2, -1),
    // rust: (0.1, 0, 1),
    // rust: (0.1, 2, 1),
    // rust: (0.05, 0, -2),
    // rust: (0.05, 2, -2),
    // rust: (0.05, 0, 2),
    // rust: (0.05, 2, 2),
    // rust: ] {
    // rust: if f.is_interior(c, x, 2, z + dz)?
    // rust: && c.random.float() < p
    // rust: && self.sturdy_neighbours(c, [x, 2, z + dz])?
    // rust: {
    // rust: f.place(c, web, x, 2, z + dz)?;
}
}
    // rust: if c.random.int(100) == 0 {
    // rust: self.minecart_chest(c, 2, 0, z - 1)?;
}
    // rust: if c.random.int(100) == 0 {
    // rust: self.minecart_chest(c, 0, 0, z + 1)?;
}
    // rust: if spider && !*placed_spider.lock().unwrap() {
    // rust: let nz = z - 1 + c.random.int(3);
    // rust: let pos = f.world_pos(1, 0, nz);
    // rust: if c.chunk_box.is_inside(pos) && f.is_interior(c, 1, 0, nz)? {
    // rust: *placed_spider.lock().unwrap() = true;
    // rust: c.spawner(pos, "minecraft:cave_spider")?;
}
}
}
    // rust: for x in 0..=2 {
    // rust: for z in 0..=length {
    // rust: self.set_planks(c, x, -1, z)?;
}
}
    // rust: self.double_support(c, 2)?;
    // rust: if sections > 1 {
    // rust: self.double_support(c, length - 2)?;
}
    // rust: if rails {
    // rust: let rail = c.state_with("rail", &[("shape", "north_south")]);
    // rust: for z in 0..=length {
    // rust: let floor = f.get(c, 1, -1, z)?;
    // rust: if !c.is_air(floor) && solid_render(c, floor) {
    // rust: let p = if f.is_interior(c, 1, 0, z)? { 0.7 } else { 0.9 };
    // rust: f.maybe_block(c, p, 1, 0, z, rail)?;
}
}
}
    // rust: Ok(())
}
    // MineShaftCorridor.createChest: a rail with a chest minecart.
minecart_chest :: proc(self: ^Self, c: ^PieceContext<'_>, x: i32, y: i32, z: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let pos = self.frame.world_pos(x, y, z);
    // rust: if !c.chunk_box.is_inside(pos) {
    // rust: return Ok(());
}
    // rust: let here = c.world.block(pos)?;
    // rust: let below = c.world.block([pos[0], pos[1] - 1, pos[2]])?;
    // rust: if c.is_air(here) && !c.is_air(below) {
    // rust: let shape = if c.random.boolean() {
    // rust: "north_south"
    // rust: } else {
    // rust: "east_west"
}
    // rust: let rail = c.state_with("rail", &[("shape", shape)]);
    // rust: self.frame.place(c, rail, x, y, z)?;
            // A chest minecart with the mineshaft loot table.
    // rust: let seed = c.random.long();
    // rust: let mut nbt = super::legacy::spawn_nbt("minecraft:chest_minecart", pos, false, false);
            // As the proto chunk saves the new cart: not ticked, not burning.
    // rust: nbt.insert("HasTicked".into(), Tag::Byte(1));
    // rust: nbt.insert("Fire".into(), Tag::Short(0));
    // rust: let p = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: nbt.insert(
    // rust: "Pos".into(),
    // rust: Tag::List(p.iter().map(|v| Tag::Double(v.to_bits())).collect()),
    // rust: );
    // rust: nbt.insert(
    // rust: "LootTable".into(),
    // rust: Tag::String("minecraft:chests/abandoned_mineshaft".into()),
    // rust: );
    // rust: nbt.insert("LootTableSeed".into(), Tag::Long(seed));
    // rust: c.world.entity(nbt)?;
}
    // rust: Ok(())
}
    // MineShaftCorridor.placeSupport(x0 0, y0 0, z, y1 2, x1 2).
support :: proc(self: ^Self, c: ^PieceContext<'_>, z: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let f = self.frame;
    // rust: for x in 0..=2 {
    // rust: let above = f.get(c, x, 3, z)?;
    // rust: if c.is_air(above) {
    // rust: return Ok(());
}
}
    // rust: let air = c.state("cave_air");
    // rust: let planks = c.state(self.wood.planks);
    // rust: let west = c.state_with(self.wood.fence, &[("west", "true")]);
    // rust: let east = c.state_with(self.wood.fence, &[("east", "true")]);
    // rust: f.generate_box(c, [0, 0, z], [0, 1, z], west, air, false)?;
    // rust: f.generate_box(c, [2, 0, z], [2, 1, z], east, air, false)?;
    // rust: if c.random.int(4) == 0 {
    // rust: f.generate_box(c, [0, 2, z], [0, 2, z], planks, air, false)?;
    // rust: f.generate_box(c, [2, 2, z], [2, 2, z], planks, air, false)?;
    // rust: } else {
    // rust: f.generate_box(c, [0, 2, z], [2, 2, z], planks, air, false)?;
    // rust: let south = c.state_with("wall_torch", &[("facing", "south")]);
    // rust: let north = c.state_with("wall_torch", &[("facing", "north")]);
    // rust: f.maybe_block(c, 0.05, 1, 2, z - 1, south)?;
    // rust: f.maybe_block(c, 0.05, 1, 2, z + 1, north)?;
}
    // rust: Ok(())
}
sturdy_neighbours :: proc(self: ^Self, c: ^PieceContext<'_>, z]: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let pos = self.frame.world_pos(x, y, z);
    // rust: let mut count = 0;
    // rust: for d in Direction::ALL {
    // rust: let n = super::legacy::offset(pos, d, 1);
    // rust: if c.chunk_box.is_inside(n) && c.world.face_sturdy(n, d.opposite())? {
    // rust: count += 1;
    // rust: if count >= 2 {
    // rust: return Ok(true);
}
}
}
    // rust: Ok(false)
}
double_support :: proc(self: ^Self, c: ^PieceContext<'_>, z: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: for x in [0, 2] {
    // rust: let s = self.frame.get(c, x, -1, z)?;
    // rust: if c.name(s) == self.wood.planks {
    // rust: self.pillar_or_chain(c, x, -1, z)?;
}
}
    // rust: Ok(())
}
    // MineShaftCorridor.fillPillarDownOrChainUp.
pillar_or_chain :: proc(self: ^Self, c: ^PieceContext<'_>, x: i32, y: i32, z: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let [px, wy, pz] = self.frame.world_pos(x, y, z);
    // rust: if !c.chunk_box.is_inside([px, wy, pz]) {
    // rust: return Ok(());
}
    // rust: let (min, max) = (c.world.min_y()?, c.world.max_y()?);
    // rust: let (mut below, mut above) = (true, true);
    // rust: let mut distance = 1;
    // rust: while below || above {
    // rust: if below {
    // rust: let p = [px, wy - distance, pz];
    // rust: let s = c.world.block(p)?;
    // rust: let name = c.name(s).to_owned();
    // rust: let empty = replaceable(&name) && name != "minecraft:lava";
    // rust: if !empty && c.world.face_sturdy(p, Direction::Up)? {
    // rust: let log = c.state(self.wood.log);
    // rust: for py in wy - distance + 1..wy {
    // rust: c.world.set([px, py, pz], log, 2)?;
}
    // rust: return Ok(());
}
    // rust: below = distance <= 20 && empty && p[1] > min + 1;
}
    // rust: if above {
    // rust: let p = [px, wy + distance, pz];
    // rust: let s = c.world.block(p)?;
    // rust: let name = c.name(s).to_owned();
    // rust: let empty = replaceable(&name);
    // rust: if !empty && c.world.center_sturdy(p, Direction::Down)? && !falling(&name) {
    // rust: c.world.set([px, wy + 1, pz], c.state(self.wood.fence), 2)?;
    // rust: let chain = c.state("iron_chain");
    // rust: for py in wy + 2..wy + distance {
    // rust: c.world.set([px, py, pz], chain, 2)?;
}
    // rust: return Ok(());
}
    // rust: above = distance <= 50 && empty && p[1] < max;
}
    // rust: distance += 1;
}
    // rust: Ok(())
}
}
    // rust: impl LegacyPiece for MineshaftPiece {
bounding_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.frame.bounding_box
}
save :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
//         use crate::nbt::Tag;
    // rust: let flag = |b: bool| Tag::Byte(i8::from(b));
    // rust: let mut tag = super::legacy::piece_tag(
    // rust: self.type_name(),
    // rust: self.frame.bounding_box,
    // rust: self.frame.orientation,
    // rust: self.depth,
    // rust: );
        // MineshaftStructure.Type's ordinal: NORMAL, MESA.
    // rust: let mesa = self.wood.log == MESA.log;
    // rust: let mut entries = vec![("MST", Tag::Int(i32::from(mesa)))];
    // rust: match &self.kind {
    // rust: Kind::Room(entrances) => entries.push((
    // rust: "Entrances",
    // rust: Tag::List(
    // rust: entrances
    // rust: .iter()
    // rust: .map(|b| {
    // rust: Tag::IntArray(vec![
    // rust: b.min[0], b.min[1], b.min[2], b.max[0], b.max[1], b.max[2],
    // rust: ])
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: )),
    // rust: Kind::Corridor {
    // rust: rails,
    // rust: spider,
    // rust: sections,
    // rust: placed_spider,
    // rust: } => entries.extend([
    // rust: ("hr", flag(*rails)),
    // rust: ("sc", flag(*spider)),
    // rust: ("hps", flag(*placed_spider.lock().unwrap())),
    // rust: ("Num", Tag::Int(*sections)),
    // rust: ]),
    // rust: Kind::Crossing {
    // rust: direction,
    // rust: two_floored,
    // rust: } => {
    // rust: let d = crate::level::data_2d(*direction) as i8;
    // rust: entries.extend([("tf", flag(*two_floored)), ("D", Tag::Byte(d))]);
}
    // rust: Kind::Stairs => {}
}
    // rust: for (key, value) in entries {
    // rust: tag.insert(key.into(), value);
}
    // rust: Some(tag)
}
type_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self.kind {
    // rust: Kind::Room(_) => "minecraft:msroom",
    // rust: Kind::Corridor { .. } => "minecraft:mscorridor",
    // rust: Kind::Crossing { .. } => "minecraft:mscrossing",
    // rust: Kind::Stairs => "minecraft:msstairs",
}
}
post_process :: proc(self: ^Self, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.invalid(c)? {
    // rust: return Ok(());
}
    // rust: match &self.kind {
    // rust: Kind::Room(entrances) => self.room(c, entrances),
    // rust: Kind::Crossing { two_floored, .. } => self.crossing(c, *two_floored),
    // rust: Kind::Stairs => self.stairs(c),
    // rust: Kind::Corridor {
    // rust: rails,
    // rust: spider,
    // rust: sections,
    // rust: placed_spider,
    // rust: } => self.corridor(c, *rails, *spider, *sections, placed_spider),
}
}
}
