//! Transpiled from Horizon Rust crate
//! Module: horizon-client_block_pattern
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `BlockPattern`: a grid of block predicates found in the world in any of
//! its 24 orientations (upright, upside down, lying flat, turned sideways).
//! The wither and the golems are built from these.
// use horizon_core::geometry::Direction;

/// A grid of predicate keys: `aisles[z][y]` is a row whose chars are the `x`
/// cells (`BlockPatternBuilder.aisle`). A space matches anything.
pub const BlockPattern = struct {
    aisles: *'static [*'static [*'static str]],
};

/// `WitherSkullBlock.getOrCreateWitherFull`: '^' a wither skeleton skull,
/// '#' a wither summon base block, '~' air.
    // rust: pub const WITHER_FULL: BlockPattern = BlockPattern {
    // rust: aisles: &[&["^^^", "###", "~#~"]],
}
/// `WitherSkullBlock.getOrCreateWitherBase`.
    // rust: pub const WITHER_BASE: BlockPattern = BlockPattern {
    // rust: aisles: &[&["   ", "###", "~#~"]],
}
/// `CarvedPumpkinBlock.getOrCreateSnowGolemFull`: '^' a carved pumpkin or
/// jack o'lantern, '#' a snow block.
    // rust: pub const SNOW_GOLEM_FULL: BlockPattern = BlockPattern {
    // rust: aisles: &[&["^", "#", "#"]],
}
/// `CarvedPumpkinBlock.getOrCreateSnowGolemBase`: the same column with any
/// block where the head will go.
    // rust: pub const SNOW_GOLEM_BASE: BlockPattern = BlockPattern {
    // rust: aisles: &[&[" ", "#", "#"]],
}
/// `CarvedPumpkinBlock.getOrCreateIronGolemFull`: '^' the head, '#' an iron
/// block, '~' air beside the arms and legs.
    // rust: pub const IRON_GOLEM_FULL: BlockPattern = BlockPattern {
    // rust: aisles: &[&["~^~", "###", "~#~"]],
}
/// `CarvedPumpkinBlock.getOrCreateIronGolemBase`.
    // rust: pub const IRON_GOLEM_BASE: BlockPattern = BlockPattern {
    // rust: aisles: &[&["~ ~", "###", "~#~"]],
}
/// `BlockPattern.BlockPatternMatch`: where a pattern was found and how it is turned.
pub const PatternMatch = struct {
    front_top_left: [i32,
    forwards: Direction,
    up: Direction,
    width: i32,
    height: i32,
    depth: i32,
};

    // rust: impl PatternMatch {
    /// `BlockPatternMatch.getBlock(x, y, z)`'s position.
pub fn block(self: *Self, x: i32, y: i32, z: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: translate_and_rotate(self.front_top_left, self.forwards, self.up, x, y, z)
}
    /// The front layer, column by column (`CarvedPumpkinBlock.clearPatternBlocks`
    /// and `updatePatternBlocks`).
pub fn front_cells(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..self.width)
    // rust: .flat_map(|x| (0..self.height).map(move |y| (x, y)))
    // rust: .map(|(x, y)| self.block(x, y, 0))
    // rust: .collect()
}
}

/// `BlockPattern.translateAndRotate`: `x` runs along forwards × up, `y` down
/// against up, `z` along forwards.
    // rust: pub fn translate_and_rotate(
    // rust: pos: [i32; 3],
    // rust: forwards: Direction,
    // rust: up: Direction,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> [i32; 3] {
    // rust: let f = forwards.normal();
    // rust: let u = up.normal();
    // rust: let right = [
    // rust: f[1] * u[2] - f[2] * u[1],
    // rust: f[2] * u[0] - f[0] * u[2],
    // rust: f[0] * u[1] - f[1] * u[0],
    // rust: ];
    // rust: std::array::from_fn(|i| pos[i] - u[i] * y + right[i] * x + f[i] * z)
}

    // rust: impl BlockPattern {
pub fn width(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.aisles
    // rust: .first()
    // rust: .and_then(|a| a.first())
    // rust: .map_or(0, |row| row.len() as i32)
}
pub fn height(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.aisles.first().map_or(0, |a| a.len() as i32)
}
pub fn depth(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.aisles.len() as i32
}
    /// `BlockPattern.matches`: every cell of the pattern with its front top
    /// left at `corner`, turned by `forwards` and `up`, passes `test(key, pos)`.
    // rust: pub fn matches(
    // rust: &self,
    // rust: corner: [i32; 3],
    // rust: forwards: Direction,
    // rust: up: Direction,
    // rust: test: &mut impl FnMut(char, [i32; 3]) -> bool,
    // rust: ) -> Option<PatternMatch> {
    // rust: for x in 0..self.width() {
    // rust: for y in 0..self.height() {
    // rust: for z in 0..self.depth() {
    // rust: let key = self.aisles[z as usize][y as usize]
    // rust: .as_bytes()
    // rust: .get(x as usize)
    // rust: .map_or(' ', |&b| b as char);
    // rust: if key != ' ' && !test(key, translate_and_rotate(corner, forwards, up, x, y, z))
    // rust: {
    // rust: return None;
}
}
}
}
    // rust: Some(PatternMatch {
    // rust: front_top_left: corner,
    // rust: forwards,
    // rust: up,
    // rust: width: self.width(),
    // rust: height: self.height(),
    // rust: depth: self.depth(),
    // rust: })
}
    /// `BlockPattern.find`: the first match whose front top left corner lies
    /// in the cube from `pos` to `pos + size - 1` (x fastest, then y, then z),
    /// trying every forwards and up pair (`Direction.values()` order) that is
    /// not along one axis.
    // rust: pub fn find(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: mut test: impl FnMut(char, [i32; 3]) -> bool,
    // rust: ) -> Option<PatternMatch> {
    // rust: let size = self.width().max(self.height()).max(self.depth());
    // rust: for dz in 0..size {
    // rust: for dy in 0..size {
    // rust: for dx in 0..size {
    // rust: let corner = [pos[0] + dx, pos[1] + dy, pos[2] + dz];
    // rust: for forwards in Direction::ALL {
    // rust: for up in Direction::ALL {
    // rust: if up == forwards || up == forwards.opposite() {
    // rust: continue;
}
    // rust: if let Some(m) = self.matches(corner, forwards, up, &mut test) {
    // rust: return Some(m);
}
}
}
}
}
}
    // rust: None
}
}

    // rust: mod tests {
//     use super::*;
//     use std::collections::HashMap;

    /// A world of named blocks; anything not listed is air.
pub fn world(blocks: *[([i32; 3]) void {
}
    // rust: blocks.iter().copied().collect()
}
    /// Each key tests for its own char in the fixture, '~' for air.
pub fn finder(w: *HashMap<[i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |key, p| match key {
    // rust: '~' => !w.contains_key(&p),
    // rust: k => w.get(&p) == Some(&k),
}
}
    /// The wither T laid out along `right` and `down` from `top_left`.
pub fn wither(top_left: [i32; 3], right: [i32; 3], down: [i32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let at = |x: i32, y: i32| std::array::from_fn(|i| top_left[i] + right[i] * x + down[i] * y);
    // rust: let mut v: Vec<_> = (0..3).map(|x| (at(x, 0), '^')).collect();
    // rust: v.extend((0..3).map(|x| (at(x, 1), '#')));
    // rust: v.push((at(1, 2), '#'));
    // rust: v
}
pub fn found(blocks: *[([i32; 3]) void {
}
    // rust: let w = world(blocks);
    // rust: WITHER_FULL.find(placed, finder(&w))
}

pub fn every_axis_of_rotation_is_tried() void {
}
        // Each forwards/up pair puts x, y and z along three different axes.
    // rust: for f in Direction::ALL {
    // rust: for u in Direction::ALL {
    // rust: if u == f || u == f.opposite() {
    // rust: continue;
}
    // rust: let cells: Vec<_> = (0..2)
    // rust: .flat_map(|x| (0..2).flat_map(move |y| (0..2).map(move |z| (x, y, z))))
    // rust: .map(|(x, y, z)| translate_and_rotate([0; 3], f, u, x, y, z))
    // rust: .collect();
    // rust: let mut unique = cells.clone();
    // rust: unique.sort();
    // rust: unique.dedup();
    // rust: assert_eq!(unique.len(), 8, "{f:?} {u:?}");
}
}
}

pub fn wither_builds_in_any_orientation() void {
}
    // rust: let x = [1, 0, 0];
    // rust: let y = [0, 1, 0];
    // rust: let z = [0, 0, 1];
    // rust: let neg = |v: [i32; 3]| v.map(|c| -c);
        // (right, down) for each layout: upright along X and Z, upside
        // down, lying flat both ways, and the T turned on its side.
    // rust: let layouts = [
    // rust: ("upright along x", x, neg(y)),
    // rust: ("upright along z", z, neg(y)),
    // rust: ("upside down", x, y),
    // rust: ("flat, skulls north", x, z),
    // rust: ("flat, skulls east", z, neg(x)),
    // rust: ("sideways, skulls west", y, x),
    // rust: ("sideways, skulls south", y, neg(z)),
    // rust: ];
    // rust: for (name, right, down) in layouts {
    // rust: let top_left = [10, 64, -5];
    // rust: let blocks = wither(top_left, right, down);
    // rust: for skull in 0..3 {
    // rust: let placed: [i32; 3] = std::array::from_fn(|i| top_left[i] + right[i] * skull);
    // rust: let m = found(&blocks, placed).unwrap_or_else(|| panic!("{name}, skull {skull}"));
                // The wither stands on the middle of the bottom row.
    // rust: let middle: [i32; 3] =
    // rust: std::array::from_fn(|i| top_left[i] + right[i] + down[i] * 2);
    // rust: assert_eq!(m.block(1, 2, 0), middle, "{name}");
    // rust: let mut cells = m.front_cells();
    // rust: cells.sort();
    // rust: let mut expected: Vec<[i32; 3]> = (0..3)
    // rust: .flat_map(|c| (0..3).map(move |r| (c, r)))
    // rust: .map(|(c, r)| std::array::from_fn(|i| top_left[i] + right[i] * c + down[i] * r))
    // rust: .collect();
    // rust: expected.sort();
    // rust: assert_eq!(cells, expected, "{name}");
}
}
}

pub fn wither_faces_along_the_pattern_normal() void {
}
        // WitherSkullBlock.checkSpawn turns the wither by forwards' axis,
        // the normal of the T: an upright T along X faces along Z.
    // rust: let along_x = wither([0, 66, 0], [1, 0, 0], [0, -1, 0]);
    // rust: let m = found(&along_x, [0, 66, 0]).unwrap();
    // rust: assert!(matches!(m.forwards, Direction::North | Direction::South));
    // rust: let along_z = wither([0, 66, 0], [0, 0, 1], [0, -1, 0]);
    // rust: let m = found(&along_z, [0, 66, 0]).unwrap();
    // rust: assert!(matches!(m.forwards, Direction::West | Direction::East));
}

pub fn wither_needs_air_beside_the_leg() void {
}
    // rust: let mut blocks = wither([0, 66, 0], [1, 0, 0], [0, -1, 0]);
    // rust: blocks.push(([0, 64, 0], 's'));
    // rust: assert_eq!(found(&blocks, [1, 66, 0]), None);
}

pub fn the_base_pattern_ignores_the_skull_row() void {
}
    // rust: let base = world(&[
    // rust: ([0, 64, 0], '#'),
    // rust: ([1, 64, 0], '#'),
    // rust: ([2, 64, 0], '#'),
    // rust: ([1, 63, 0], '#'),
    // rust: ]);
    // rust: assert!(WITHER_BASE.find([0, 65, 0], finder(&base)).is_some());
    // rust: assert!(WITHER_FULL.find([0, 65, 0], finder(&base)).is_none());
}
}
