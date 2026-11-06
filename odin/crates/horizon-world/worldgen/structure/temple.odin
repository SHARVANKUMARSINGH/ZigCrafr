//! Transpiled from Horizon Rust crate
package horizon_world_temple

import "core:fmt"
import "core:mem"
import "core:math"

// Desert pyramids and jungle temples (DesertPyramidPiece, JungleTemplePiece).
// use super::{
    // rust: BoundingBox,
    // rust: legacy::{HORIZONTAL, LegacyPiece, PieceContext, Result, random_horizontal},
    // rust: simple::Scattered,
}
// use crate::nbt::{Compound, Tag};
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, PositionalRandom, RandomSource},
}
// use std::sync::Mutex;

DesertPyramidPiece :: struct {
    base: Scattered,
    placed_chest: Mutex<[bool,
}
    // rust: impl DesertPyramidPiece {
new :: proc(random: ^impl RandomSource, west: i32, north: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let direction = random_horizontal(random);
    // rust: Self {
    // rust: base: Scattered::new(west, 64, north, 21, 15, 21, direction),
    // rust: placed_chest: Mutex::new([false; 4]),
}
}
    // getPotentialSuspiciousSandWorldPositions, in placement order.
sand_positions :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let f = self.base.frame();
    // rust: let (x, y, z) = (16, -4, 13);
    // rust: let mut out = Vec::new();
    // rust: for py in y + 1..=y + 3 {
    // rust: for px in x - 2..=x + 2 {
    // rust: for pz in z - 2..=z + 2 {
    // rust: out.push(f.world_pos(px, py, pz));
}
}
}
    // rust: for [px, pz] in [[x + 3, z], [x - 3, z], [x, z + 3], [x, z - 3]] {
    // rust: out.push(f.world_pos(px, y + 1, pz));
    // rust: out.push(f.world_pos(px, y + 2, pz));
}
    // rust: out
}
collapsed_roof :: proc(self: ^Self, seed: i64) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let f = self.base.frame();
    // rust: let [x0, y0, z0] = f.world_pos(14, 0, 11);
    // rust: let mut random = LegacyRandom::new(seed)
    // rust: .fork_positional()
    // rust: .at(BlockPos::new(x0, y0, z0));
    // rust: let rx = 14 + random.next_int_bound(5).unwrap_or(0);
    // rust: let rz = 11 + random.next_int_bound(5).unwrap_or(0);
    // rust: f.world_pos(rx, 0, rz)
}
}
union :: proc(boxes: ^[BoundingBox]) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = boxes[0];
    // rust: for b in &boxes[1..] {
    // rust: out.encapsulate(b);
}
    // rust: out
}
suspicious_sand :: proc(c: ^PieceContext<'_>, pos: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if c.chunk_box.is_inside(pos) {
    // rust: c.world.set(pos, c.state("suspicious_sand"), 2)?;
    // rust: let mut nbt = Compound::new();
    // rust: nbt.insert("id".into(), Tag::String("minecraft:brushable_block".into()));
    // rust: nbt.insert(
    // rust: "LootTable".into(),
    // rust: Tag::String("minecraft:archaeology/desert_pyramid".into()),
    // rust: );
    // rust: nbt.insert(
    // rust: "LootTableSeed".into(),
    // rust: Tag::Long(BlockPos::new(pos[0], pos[1], pos[2]).pack()),
    // rust: );
    // rust: c.world.block_entity(pos, nbt)?;
}
    // rust: Ok(())
}
    // rust: impl LegacyPiece for DesertPyramidPiece {
bounding_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.base.frame().bounding_box
}
save :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = self.base.saved("minecraft:tedp");
    // rust: for (i, placed) in self.placed_chest.lock().unwrap().iter().enumerate() {
    // rust: tag.insert(
    // rust: format!("hasPlacedChest{i}").as_str().into(),
    // rust: crate::nbt::Tag::Byte(i8::from(*placed)),
    // rust: );
}
    // rust: Some(tag)
}
type_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:tedp"
}
post_process :: proc(self: ^Self, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let offset = -c.random.int(3);
    // rust: if !self.base.lowest_ground(c, offset)? {
    // rust: return Ok(());
}
    // rust: let f = self.base.frame();
    // rust: let (w, d) = (21, 21);
    // rust: let sandstone = c.state("sandstone");
    // rust: let cut = c.state("cut_sandstone");
    // rust: let chiseled = c.state("chiseled_sandstone");
    // rust: let air = c.state("air");
    // rust: let orange = c.state("orange_terracotta");
    // rust: let blue = c.state("blue_terracotta");
    // rust: let stairs = |c: &PieceContext<'_>, facing: &str| {
    // rust: c.state_with("sandstone_stairs", &[("facing", facing)])
}
    // rust: let north = stairs(c, "north");
    // rust: let south = stairs(c, "south");
    // rust: let east = stairs(c, "east");
    // rust: let west = stairs(c, "west");
    // rust: f.generate_box(
    // rust: c,
    // rust: [0, -4, 0],
    // rust: [w - 1, 0, d - 1],
    // rust: sandstone,
    // rust: sandstone,
    // rust: false,
    // rust: )?;
    // rust: for p in 1..=9 {
    // rust: f.generate_box(
    // rust: c,
    // rust: [p, p, p],
    // rust: [w - 1 - p, p, d - 1 - p],
    // rust: sandstone,
    // rust: sandstone,
    // rust: false,
    // rust: )?;
    // rust: f.generate_box(
    // rust: c,
    // rust: [p + 1, p, p + 1],
    // rust: [w - 2 - p, p, d - 2 - p],
    // rust: air,
    // rust: air,
    // rust: false,
    // rust: )?;
}
    // rust: for x in 0..w {
    // rust: for z in 0..d {
    // rust: f.fill_column_down(c, sandstone, x, -5, z)?;
}
}
    // rust: f.generate_box(c, [0, 0, 0], [4, 9, 4], sandstone, air, false)?;
    // rust: f.generate_box(c, [1, 10, 1], [3, 10, 3], sandstone, sandstone, false)?;
    // rust: f.place(c, north, 2, 10, 0)?;
    // rust: f.place(c, south, 2, 10, 4)?;
    // rust: f.place(c, east, 0, 10, 2)?;
    // rust: f.place(c, west, 4, 10, 2)?;
    // rust: f.generate_box(c, [w - 5, 0, 0], [w - 1, 9, 4], sandstone, air, false)?;
    // rust: f.generate_box(
    // rust: c,
    // rust: [w - 4, 10, 1],
    // rust: [w - 2, 10, 3],
    // rust: sandstone,
    // rust: sandstone,
    // rust: false,
    // rust: )?;
    // rust: f.place(c, north, w - 3, 10, 0)?;
    // rust: f.place(c, south, w - 3, 10, 4)?;
    // rust: f.place(c, east, w - 5, 10, 2)?;
    // rust: f.place(c, west, w - 1, 10, 2)?;
    // rust: f.generate_box(c, [8, 0, 0], [12, 4, 4], sandstone, air, false)?;
    // rust: f.generate_box(c, [9, 1, 0], [11, 3, 4], air, air, false)?;
    // rust: for [x, y] in [[9, 1], [9, 2], [9, 3], [10, 3], [11, 3], [11, 2], [11, 1]] {
    // rust: f.place(c, cut, x, y, 1)?;
}
    // rust: f.generate_box(c, [4, 1, 1], [8, 3, 3], sandstone, air, false)?;
    // rust: f.generate_box(c, [4, 1, 2], [8, 2, 2], air, air, false)?;
    // rust: f.generate_box(c, [12, 1, 1], [16, 3, 3], sandstone, air, false)?;
    // rust: f.generate_box(c, [12, 1, 2], [16, 2, 2], air, air, false)?;
    // rust: f.generate_box(c, [5, 4, 5], [w - 6, 4, d - 6], sandstone, sandstone, false)?;
    // rust: f.generate_box(c, [9, 4, 9], [11, 4, 11], air, air, false)?;
    // rust: for [x, z] in [[8, 8], [12, 8], [8, 12], [12, 12]] {
    // rust: f.generate_box(c, [x, 1, z], [x, 3, z], cut, cut, false)?;
}
    // rust: f.generate_box(c, [1, 1, 5], [4, 4, 11], sandstone, sandstone, false)?;
    // rust: f.generate_box(
    // rust: c,
    // rust: [w - 5, 1, 5],
    // rust: [w - 2, 4, 11],
    // rust: sandstone,
    // rust: sandstone,
    // rust: false,
    // rust: )?;
    // rust: f.generate_box(c, [6, 7, 9], [6, 7, 11], sandstone, sandstone, false)?;
    // rust: f.generate_box(
    // rust: c,
    // rust: [w - 7, 7, 9],
    // rust: [w - 7, 7, 11],
    // rust: sandstone,
    // rust: sandstone,
    // rust: false,
    // rust: )?;
    // rust: f.generate_box(c, [5, 5, 9], [5, 7, 11], cut, cut, false)?;
    // rust: f.generate_box(c, [w - 6, 5, 9], [w - 6, 7, 11], cut, cut, false)?;
    // rust: f.place(c, air, 5, 5, 10)?;
    // rust: f.place(c, air, 5, 6, 10)?;
    // rust: f.place(c, air, 6, 6, 10)?;
    // rust: f.place(c, air, w - 6, 5, 10)?;
    // rust: f.place(c, air, w - 6, 6, 10)?;
    // rust: f.place(c, air, w - 7, 6, 10)?;
    // rust: f.generate_box(c, [2, 4, 4], [2, 6, 4], air, air, false)?;
    // rust: f.generate_box(c, [w - 3, 4, 4], [w - 3, 6, 4], air, air, false)?;
    // rust: f.place(c, north, 2, 4, 5)?;
    // rust: f.place(c, north, 2, 3, 4)?;
    // rust: f.place(c, north, w - 3, 4, 5)?;
    // rust: f.place(c, north, w - 3, 3, 4)?;
    // rust: f.generate_box(c, [1, 1, 3], [2, 2, 3], sandstone, sandstone, false)?;
    // rust: f.generate_box(c, [w - 3, 1, 3], [w - 2, 2, 3], sandstone, sandstone, false)?;
    // rust: f.place(c, sandstone, 1, 1, 2)?;
    // rust: f.place(c, sandstone, w - 2, 1, 2)?;
    // rust: let slab = c.state("sandstone_slab");
    // rust: f.place(c, slab, 1, 2, 2)?;
    // rust: f.place(c, slab, w - 2, 2, 2)?;
    // rust: f.place(c, west, 2, 1, 2)?;
    // rust: f.place(c, east, w - 3, 1, 2)?;
    // rust: f.generate_box(c, [4, 3, 5], [4, 3, 17], sandstone, sandstone, false)?;
    // rust: f.generate_box(
    // rust: c,
    // rust: [w - 5, 3, 5],
    // rust: [w - 5, 3, 17],
    // rust: sandstone,
    // rust: sandstone,
    // rust: false,
    // rust: )?;
    // rust: f.generate_box(c, [3, 1, 5], [4, 2, 16], air, air, false)?;
    // rust: f.generate_box(c, [w - 6, 1, 5], [w - 5, 2, 16], air, air, false)?;
    // rust: for z in (5..=17).step_by(2) {
    // rust: f.place(c, cut, 4, 1, z)?;
    // rust: f.place(c, chiseled, 4, 2, z)?;
    // rust: f.place(c, cut, w - 5, 1, z)?;
    // rust: f.place(c, chiseled, w - 5, 2, z)?;
}
    // rust: for [x, z] in [
    // rust: [10, 7],
    // rust: [10, 8],
    // rust: [9, 9],
    // rust: [11, 9],
    // rust: [8, 10],
    // rust: [12, 10],
    // rust: [7, 10],
    // rust: [13, 10],
    // rust: [9, 11],
    // rust: [11, 11],
    // rust: [10, 12],
    // rust: [10, 13],
    // rust: ] {
    // rust: f.place(c, orange, x, 0, z)?;
}
    // rust: f.place(c, blue, 10, 0, 10)?;
        // Rows of the corner towers (y 2..=8, three blocks each).
    // rust: let rows = [
    // rust: [cut, orange, cut],
    // rust: [cut, orange, cut],
    // rust: [orange, chiseled, orange],
    // rust: [cut, orange, cut],
    // rust: [orange, chiseled, orange],
    // rust: [orange, orange, orange],
    // rust: [cut, cut, cut],
    // rust: ];
    // rust: for x in [0, w - 1] {
    // rust: for (i, row) in rows.iter().enumerate() {
    // rust: for (j, &state) in row.iter().enumerate() {
    // rust: f.place(c, state, x, 2 + i as i32, 1 + j as i32)?;
}
}
}
    // rust: for x in [2, w - 3] {
    // rust: for (i, row) in rows.iter().enumerate() {
    // rust: for (j, &state) in row.iter().enumerate() {
    // rust: f.place(c, state, x - 1 + j as i32, 2 + i as i32, 0)?;
}
}
}
    // rust: f.generate_box(c, [8, 4, 0], [12, 6, 0], cut, cut, false)?;
    // rust: f.place(c, air, 8, 6, 0)?;
    // rust: f.place(c, air, 12, 6, 0)?;
    // rust: f.place(c, orange, 9, 5, 0)?;
    // rust: f.place(c, chiseled, 10, 5, 0)?;
    // rust: f.place(c, orange, 11, 5, 0)?;
    // rust: f.generate_box(c, [8, -14, 8], [12, -11, 12], cut, cut, false)?;
    // rust: f.generate_box(c, [8, -10, 8], [12, -10, 12], chiseled, chiseled, false)?;
    // rust: f.generate_box(c, [8, -9, 8], [12, -9, 12], cut, cut, false)?;
    // rust: f.generate_box(c, [8, -8, 8], [12, -1, 12], sandstone, sandstone, false)?;
    // rust: f.generate_box(c, [9, -11, 9], [11, -1, 11], air, air, false)?;
    // rust: f.place(c, c.state("stone_pressure_plate"), 10, -11, 10)?;
    // rust: f.generate_box(c, [9, -13, 9], [11, -13, 11], c.state("tnt"), air, false)?;
    // rust: for [x, z, ox, oz] in [
    // rust: [8, 10, 7, 10],
    // rust: [12, 10, 13, 10],
    // rust: [10, 8, 10, 7],
    // rust: [10, 12, 10, 13],
    // rust: ] {
    // rust: f.place(c, air, x, -11, z)?;
    // rust: f.place(c, air, x, -10, z)?;
    // rust: f.place(c, chiseled, ox, -10, oz)?;
    // rust: f.place(c, cut, ox, -11, oz)?;
}
    // rust: for (i, d) in HORIZONTAL.into_iter().enumerate() {
    // rust: if !self.placed_chest.lock().unwrap()[i] {
    // rust: let s = d.normal();
    // rust: let placed = f.create_chest(
    // rust: c,
    // rust: 10 + s[0] * 2,
    // rust: -11,
    // rust: 10 + s[2] * 2,
    // rust: "minecraft:chests/desert_pyramid",
    // rust: )?;
    // rust: self.placed_chest.lock().unwrap()[i] = placed;
}
}
        // addCellar: stairs, then the room.
    // rust: let (x, y, z) = (16, -4, 13);
    // rust: let ccw = stairs(c, "west");
    // rust: f.place(c, ccw, 13, -1, 17)?;
    // rust: f.place(c, ccw, 14, -2, 17)?;
    // rust: f.place(c, ccw, 15, -3, 17)?;
    // rust: let sand = c.state("sand");
    // rust: let variant = c.world.level_boolean()?;
    // rust: for dx in -4..=0 {
    // rust: f.place(c, sand, x + dx, y + 4, z + 4)?;
}
    // rust: f.place(c, sand, x - 2, y + 3, z + 4)?;
    // rust: f.place(
    // rust: c,
    // rust: if variant { sand } else { sandstone },
    // rust: x - 1,
    // rust: y + 3,
    // rust: z + 4,
    // rust: )?;
    // rust: f.place(c, if variant { sandstone } else { sand }, x, y + 3, z + 4)?;
    // rust: f.place(c, sand, x - 1, y + 2, z + 4)?;
    // rust: f.place(c, sandstone, x, y + 2, z + 4)?;
    // rust: f.place(c, sand, x, y + 1, z + 4)?;
    // rust: for (state, yy) in [(cut, y + 1), (chiseled, y + 2), (cut, -1)] {
    // rust: f.generate_box(
    // rust: c,
    // rust: [x - 3, yy, z - 3],
    // rust: [x - 3, yy, z + 2],
    // rust: state,
    // rust: state,
    // rust: true,
    // rust: )?;
    // rust: f.generate_box(
    // rust: c,
    // rust: [x + 3, yy, z - 3],
    // rust: [x + 3, yy, z + 2],
    // rust: state,
    // rust: state,
    // rust: true,
    // rust: )?;
    // rust: f.generate_box(
    // rust: c,
    // rust: [x - 3, yy, z - 3],
    // rust: [x + 3, yy, z - 2],
    // rust: state,
    // rust: state,
    // rust: true,
    // rust: )?;
    // rust: f.generate_box(
    // rust: c,
    // rust: [x - 3, yy, z + 3],
    // rust: [x + 3, yy, z + 3],
    // rust: state,
    // rust: state,
    // rust: true,
    // rust: )?;
}
    // rust: for px in x - 2..=x + 2 {
    // rust: for pz in z - 2..=z + 2 {
    // rust: let state = if c.world.level_float()? < 0.33 {
    // rust: sandstone
    // rust: } else {
    // rust: sand
}
    // rust: f.place(c, state, px, y + 4, pz)?;
}
}
    // rust: f.place(c, blue, x, y, z)?;
    // rust: for [dx, dz] in [
    // rust: [1, -1],
    // rust: [1, 1],
    // rust: [-1, -1],
    // rust: [-1, 1],
    // rust: [2, 0],
    // rust: [-2, 0],
    // rust: [0, 2],
    // rust: [0, -2],
    // rust: ] {
    // rust: f.place(c, orange, x + dx, y, z + dz)?;
}
    // rust: f.place(c, orange, x + 3, y, z)?;
    // rust: f.place(c, cut, x + 4, y + 1, z)?;
    // rust: f.place(c, chiseled, x + 4, y + 2, z)?;
    // rust: f.place(c, orange, x - 3, y, z)?;
    // rust: f.place(c, cut, x - 4, y + 1, z)?;
    // rust: f.place(c, chiseled, x - 4, y + 2, z)?;
    // rust: f.place(c, orange, x, y, z + 3)?;
    // rust: f.place(c, orange, x, y, z - 3)?;
    // rust: f.place(c, cut, x, y + 1, z - 4)?;
    // rust: f.place(c, chiseled, x, -2, z - 4)?;
    // rust: Ok(())
}
    // DesertPyramidStructure.afterPlace.
after_place :: proc(self: ^Self, c: ^PieceContext<'_>, pieces: ^[BoundingBox]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if *self.base.height_position.lock().unwrap() < 0 {
    // rust: return Ok(());
}
    // rust: let seed = c.world.seed()?;
    // rust: let mut positions = self.sand_positions();
    // rust: positions.sort_by_key(|p| (p[1], p[2], p[0]));
    // rust: positions.dedup();
    // rust: suspicious_sand(c, self.collapsed_roof(seed))?;
    // rust: let center = union(pieces).center();
    // rust: let mut random = LegacyRandom::new(seed)
    // rust: .fork_positional()
    // rust: .at(BlockPos::new(center[0], center[1], center[2]));
    // rust: for i in (2..=positions.len()).rev() {
    // rust: let j = random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: positions.swap(i - 1, j);
}
    // rust: let mut remaining = (positions.len() as i32).min(5 + random.next_int_bound(3).unwrap_or(0));
    // rust: let sand = c.state("sand");
    // rust: for pos in positions {
    // rust: if remaining > 0 {
    // rust: remaining -= 1;
    // rust: suspicious_sand(c, pos)?;
    // rust: } else if c.chunk_box.is_inside(pos) {
    // rust: c.world.set(pos, sand, 2)?;
}
}
    // rust: Ok(())
}
}

JungleTemplePiece :: struct {
    base: Scattered,
    // placedMainChest, placedHiddenChest, placedTrap1, placedTrap2.
    placed: Mutex<[bool,
}
    // rust: impl JungleTemplePiece {
new :: proc(random: ^impl RandomSource, west: i32, north: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let direction = random_horizontal(random);
    // rust: Self {
    // rust: base: Scattered::new(west, 64, north, 12, 10, 15, direction),
    // rust: placed: Mutex::new([false; 4]),
}
}
}
    // rust: impl LegacyPiece for JungleTemplePiece {
bounding_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.base.frame().bounding_box
}
save :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = self.base.saved("minecraft:tejp");
    // rust: let placed = *self.placed.lock().unwrap();
    // rust: for (key, value) in [
    // rust: "placedMainChest",
    // rust: "placedHiddenChest",
    // rust: "placedTrap1",
    // rust: "placedTrap2",
    // rust: ]
    // rust: .into_iter()
    // rust: .zip(placed)
    // rust: {
    // rust: tag.insert(key.into(), crate::nbt::Tag::Byte(i8::from(value)));
}
    // rust: Some(tag)
}
type_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:tejp"
}
post_process :: proc(self: ^Self, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !self.base.average_ground(c, 0)? {
    // rust: return Ok(());
}
    // rust: let f = self.base.frame();
    // rust: let cobble = c.state("cobblestone");
    // rust: let mossy = c.state("mossy_cobblestone");
    // rust: let air = c.state("air");
    // rust: let stone = |c: &mut PieceContext<'_>, a: [i32; 3], b: [i32; 3]| {
    // rust: f.generate_box_selector(c, a, b, false, &mut |c, _, _, _, _| {
    // rust: if c.random.float() < 0.4 {
    // rust: cobble
    // rust: } else {
    // rust: mossy
}
    // rust: })
}
    // rust: stone(c, [0, -4, 0], [11, 0, 14])?;
    // rust: for (a, b) in [
    // rust: ([2, 1, 2], [9, 2, 2]),
    // rust: ([2, 1, 12], [9, 2, 12]),
    // rust: ([2, 1, 3], [2, 2, 11]),
    // rust: ([9, 1, 3], [9, 2, 11]),
    // rust: ([1, 3, 1], [10, 6, 1]),
    // rust: ([1, 3, 13], [10, 6, 13]),
    // rust: ([1, 3, 2], [1, 6, 12]),
    // rust: ([10, 3, 2], [10, 6, 12]),
    // rust: ([2, 3, 2], [9, 3, 12]),
    // rust: ([2, 6, 2], [9, 6, 12]),
    // rust: ([3, 7, 3], [8, 7, 11]),
    // rust: ([4, 8, 4], [7, 8, 10]),
    // rust: ] {
    // rust: stone(c, a, b)?;
}
    // rust: for (a, b) in [
    // rust: ([3, 1, 3], [8, 2, 11]),
    // rust: ([4, 3, 6], [7, 3, 9]),
    // rust: ([2, 4, 2], [9, 5, 12]),
    // rust: ([4, 6, 5], [7, 6, 9]),
    // rust: ([5, 7, 6], [6, 7, 8]),
    // rust: ([5, 1, 2], [6, 2, 2]),
    // rust: ([5, 2, 12], [6, 2, 12]),
    // rust: ([5, 5, 1], [6, 5, 1]),
    // rust: ([5, 5, 13], [6, 5, 13]),
    // rust: ] {
    // rust: f.generate_box(c, a, b, air, air, false)?;
}
    // rust: f.place(c, air, 1, 5, 5)?;
    // rust: f.place(c, air, 10, 5, 5)?;
    // rust: f.place(c, air, 1, 5, 9)?;
    // rust: f.place(c, air, 10, 5, 9)?;
    // rust: for z in [0, 14] {
    // rust: for x in [2, 4, 7, 9] {
    // rust: stone(c, [x, 4, z], [x, 5, z])?;
}
}
    // rust: stone(c, [5, 6, 0], [6, 6, 0])?;
    // rust: for x in [0, 11] {
    // rust: for z in (2..=12).step_by(2) {
    // rust: stone(c, [x, 4, z], [x, 5, z])?;
}
    // rust: stone(c, [x, 6, 5], [x, 6, 5])?;
    // rust: stone(c, [x, 6, 9], [x, 6, 9])?;
}
    // rust: for (a, b) in [
    // rust: ([2, 7, 2], [2, 9, 2]),
    // rust: ([9, 7, 2], [9, 9, 2]),
    // rust: ([2, 7, 12], [2, 9, 12]),
    // rust: ([9, 7, 12], [9, 9, 12]),
    // rust: ([4, 9, 4], [4, 9, 4]),
    // rust: ([7, 9, 4], [7, 9, 4]),
    // rust: ([4, 9, 10], [4, 9, 10]),
    // rust: ([7, 9, 10], [7, 9, 10]),
    // rust: ([5, 9, 7], [6, 9, 7]),
    // rust: ] {
    // rust: stone(c, a, b)?;
}
    // rust: let stairs = |c: &PieceContext<'_>, facing: &str| {
    // rust: c.state_with("cobblestone_stairs", &[("facing", facing)])
}
    // rust: let east = stairs(c, "east");
    // rust: let west = stairs(c, "west");
    // rust: let south = stairs(c, "south");
    // rust: let north = stairs(c, "north");
    // rust: f.place(c, north, 5, 9, 6)?;
    // rust: f.place(c, north, 6, 9, 6)?;
    // rust: f.place(c, south, 5, 9, 8)?;
    // rust: f.place(c, south, 6, 9, 8)?;
    // rust: for [x, y, z] in [
    // rust: [4, 0, 0],
    // rust: [5, 0, 0],
    // rust: [6, 0, 0],
    // rust: [7, 0, 0],
    // rust: [4, 1, 8],
    // rust: [4, 2, 9],
    // rust: [4, 3, 10],
    // rust: [7, 1, 8],
    // rust: [7, 2, 9],
    // rust: [7, 3, 10],
    // rust: ] {
    // rust: f.place(c, north, x, y, z)?;
}
    // rust: stone(c, [4, 1, 9], [4, 1, 9])?;
    // rust: stone(c, [7, 1, 9], [7, 1, 9])?;
    // rust: stone(c, [4, 1, 10], [7, 2, 10])?;
    // rust: stone(c, [5, 4, 5], [6, 4, 5])?;
    // rust: f.place(c, east, 4, 4, 5)?;
    // rust: f.place(c, west, 7, 4, 5)?;
    // rust: for i in 0..4 {
    // rust: f.place(c, south, 5, -i, 6 + i)?;
    // rust: f.place(c, south, 6, -i, 6 + i)?;
    // rust: f.generate_box(c, [5, -i, 7 + i], [6, -i, 9 + i], air, air, false)?;
}
    // rust: f.generate_box(c, [1, -3, 12], [10, -1, 13], air, air, false)?;
    // rust: f.generate_box(c, [1, -3, 1], [3, -1, 13], air, air, false)?;
    // rust: f.generate_box(c, [1, -3, 1], [9, -1, 5], air, air, false)?;
    // rust: for z in (1..=13).step_by(2) {
    // rust: stone(c, [1, -3, z], [1, -2, z])?;
}
    // rust: for z in (2..=12).step_by(2) {
    // rust: stone(c, [1, -1, z], [3, -1, z])?;
}
    // rust: stone(c, [2, -2, 1], [5, -2, 1])?;
    // rust: stone(c, [7, -2, 1], [9, -2, 1])?;
    // rust: stone(c, [6, -3, 1], [6, -3, 1])?;
    // rust: stone(c, [6, -1, 1], [6, -1, 1])?;
    // rust: let hook = |c: &PieceContext<'_>, facing: &str| {
    // rust: c.state_with("tripwire_hook", &[("facing", facing), ("attached", "true")])
}
    // rust: let wire = |c: &PieceContext<'_>, a: &str, b: &str| {
    // rust: c.state_with(
    // rust: "tripwire",
    // rust: &[(a, "true"), (b, "true"), ("attached", "true")],
    // rust: )
}
    // rust: let redstone =
    // rust: |c: &PieceContext<'_>, sides: &[(&str, &str)]| c.state_with("redstone_wire", sides);
    // rust: f.place(c, hook(c, "east"), 1, -3, 8)?;
    // rust: f.place(c, hook(c, "west"), 4, -3, 8)?;
    // rust: f.place(c, wire(c, "east", "west"), 2, -3, 8)?;
    // rust: f.place(c, wire(c, "east", "west"), 3, -3, 8)?;
    // rust: let ns = redstone(c, &[("north", "side"), ("south", "side")]);
    // rust: for z in (2..=7).rev() {
    // rust: f.place(c, ns, 5, -3, z)?;
}
    // rust: f.place(
    // rust: c,
    // rust: redstone(c, &[("north", "side"), ("west", "side")]),
    // rust: 5,
    // rust: -3,
    // rust: 1,
    // rust: )?;
    // rust: f.place(
    // rust: c,
    // rust: redstone(c, &[("east", "side"), ("west", "side")]),
    // rust: 4,
    // rust: -3,
    // rust: 1,
    // rust: )?;
    // rust: f.place(c, mossy, 3, -3, 1)?;
    // rust: let dispenser = "minecraft:chests/jungle_temple_dispenser";
    // rust: if !self.placed.lock().unwrap()[2] {
    // rust: let placed = f.create_dispenser(c, 3, -2, 1, Direction::North, dispenser)?;
    // rust: self.placed.lock().unwrap()[2] = placed;
}
    // rust: f.place(c, c.state_with("vine", &[("south", "true")]), 3, -2, 2)?;
    // rust: f.place(c, hook(c, "north"), 7, -3, 1)?;
    // rust: f.place(c, hook(c, "south"), 7, -3, 5)?;
    // rust: for z in 2..=4 {
    // rust: f.place(c, wire(c, "north", "south"), 7, -3, z)?;
}
    // rust: f.place(
    // rust: c,
    // rust: redstone(c, &[("east", "side"), ("west", "side")]),
    // rust: 8,
    // rust: -3,
    // rust: 6,
    // rust: )?;
    // rust: f.place(
    // rust: c,
    // rust: redstone(c, &[("west", "side"), ("south", "side")]),
    // rust: 9,
    // rust: -3,
    // rust: 6,
    // rust: )?;
    // rust: f.place(
    // rust: c,
    // rust: redstone(c, &[("north", "side"), ("south", "up")]),
    // rust: 9,
    // rust: -3,
    // rust: 5,
    // rust: )?;
    // rust: f.place(c, mossy, 9, -3, 4)?;
    // rust: f.place(c, ns, 9, -2, 4)?;
    // rust: if !self.placed.lock().unwrap()[3] {
    // rust: let placed = f.create_dispenser(c, 9, -2, 3, Direction::West, dispenser)?;
    // rust: self.placed.lock().unwrap()[3] = placed;
}
    // rust: let vine_east = c.state_with("vine", &[("east", "true")]);
    // rust: f.place(c, vine_east, 8, -1, 3)?;
    // rust: f.place(c, vine_east, 8, -2, 3)?;
    // rust: if !self.placed.lock().unwrap()[0] {
    // rust: let placed = f.create_chest(c, 8, -3, 3, "minecraft:chests/jungle_temple")?;
    // rust: self.placed.lock().unwrap()[0] = placed;
}
    // rust: for [x, y, z] in [
    // rust: [9, -3, 2],
    // rust: [8, -3, 1],
    // rust: [4, -3, 5],
    // rust: [5, -2, 5],
    // rust: [5, -1, 5],
    // rust: [6, -3, 5],
    // rust: [7, -2, 5],
    // rust: [7, -1, 5],
    // rust: [8, -3, 5],
    // rust: ] {
    // rust: f.place(c, mossy, x, y, z)?;
}
    // rust: stone(c, [9, -1, 1], [9, -1, 5])?;
    // rust: f.generate_box(c, [8, -3, 8], [10, -1, 10], air, air, false)?;
    // rust: let chiseled = c.state("chiseled_stone_bricks");
    // rust: let lever = c.state_with("lever", &[("facing", "north"), ("face", "wall")]);
    // rust: for x in 8..=10 {
    // rust: f.place(c, chiseled, x, -2, 11)?;
}
    // rust: for x in 8..=10 {
    // rust: f.place(c, lever, x, -2, 12)?;
}
    // rust: stone(c, [8, -3, 8], [8, -3, 10])?;
    // rust: stone(c, [10, -3, 8], [10, -3, 10])?;
    // rust: f.place(c, mossy, 10, -2, 9)?;
    // rust: f.place(c, ns, 8, -2, 9)?;
    // rust: f.place(c, ns, 8, -2, 10)?;
    // rust: f.place(
    // rust: c,
    // rust: redstone(
    // rust: c,
    // rust: &[
    // rust: ("north", "side"),
    // rust: ("south", "side"),
    // rust: ("east", "side"),
    // rust: ("west", "side"),
    // rust: ],
    // rust: ),
    // rust: 10,
    // rust: -1,
    // rust: 9,
    // rust: )?;
    // rust: f.place(
    // rust: c,
    // rust: c.state_with("sticky_piston", &[("facing", "up")]),
    // rust: 9,
    // rust: -2,
    // rust: 8,
    // rust: )?;
    // rust: let piston_west = c.state_with("sticky_piston", &[("facing", "west")]);
    // rust: f.place(c, piston_west, 10, -2, 8)?;
    // rust: f.place(c, piston_west, 10, -1, 8)?;
    // rust: f.place(
    // rust: c,
    // rust: c.state_with("repeater", &[("facing", "north")]),
    // rust: 10,
    // rust: -2,
    // rust: 10,
    // rust: )?;
    // rust: if !self.placed.lock().unwrap()[1] {
    // rust: let placed = f.create_chest(c, 9, -3, 10, "minecraft:chests/jungle_temple")?;
    // rust: self.placed.lock().unwrap()[1] = placed;
}
    // rust: Ok(())
}
}
