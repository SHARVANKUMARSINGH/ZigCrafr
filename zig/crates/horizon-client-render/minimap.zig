//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_minimap
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The minimap extra (`docs/extras.md`): a 16x16 tile per loaded chunk with
//! each column's vanilla map colour (`MapColor`, as `MapItem.update` picks
//! it), height and water depth, and a 128x128 image composed from the tiles
//! around the player with the map item's height and water shading.
//!
//! Tiles are filled nearest first within a time budget and rescanned after
//! block changes; the image is recomposed only when the view moved or a tile
//! changed.
// use crate::{
    // rust: blocks::{BlockFacts, Fluid, MAP_COLORS},
    // rust: chunk::Chunk,
    // rust: fast_hash::FxHashMap,
    // rust: world::World,
}
// use std::time::{Duration, Instant};

/// The image's side in texels.
pub const SIZE: usize = 128;
/// Marks a column the map cuts through (a wall at the player's height).
pub const WALL: u8 = 0x80;
/// Water's and lava's map colours (`MapColor.WATER`, `FIRE`).
pub const WATER: u8 = 12;
pub const LAVA: u8 = 4;
/// A tile whose chunk changed is rescanned at most this often.
pub const RESCAN: Duration = Duration::from_secs(1);

/// What the map shows of each column.
pub const Layer = enum {
    /// The top block, as map items show it.
    Surface,
    /// Underground, in the Nether or under a roof: the floor below this
    /// height (the player's head), and walls cut at it.
    Below(i32),
};

/// What the scan needs of each block state.
pub const Palette = struct {
    /// Map colour id, 0 for none.
    color: std.ArrayList(u8),
    /// 0 none, 1 water, 2 lava; | 4 for air; | 8 when sturdy on top.
    flags: std.ArrayList(u8),
};
pub const FLUID: u8 = 3;
pub const AIR: u8 = 4;
pub const STURDY_TOP: u8 = 8;
    // rust: impl Palette {
pub fn new(facts: *BlockFacts) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut color = Vec::with_capacity(facts.states.len());
    // rust: let mut flags = Vec::with_capacity(facts.states.len());
    // rust: for (i, f) in facts.states.iter().enumerate() {
    // rust: color.push(f.map_color);
    // rust: let mut b = match f.fluid {
    // rust: Fluid::None => 0,
    // rust: Fluid::Water => 1,
    // rust: Fluid::Lava => 2,
}
    // rust: if facts.is_air(horizon_world::registry::BlockStateId(i as u32)) {
    // rust: b |= AIR;
}
            // isFaceSturdy(UP, FULL): Direction.UP's ordinal is 1.
    // rust: if f.sturdy_full >> 1 & 1 != 0 {
    // rust: b |= STURDY_TOP;
}
    // rust: flags.push(b);
}
    // rust: Self { color, flags }
}
    /// A palette from (colour, flags) per state id (tests).
pub fn from_parts(parts: *[(u8) void {
}
    // rust: Self {
    // rust: color: parts.iter().map(|p| p.0).collect(),
    // rust: flags: parts.iter().map(|p| p.1).collect(),
}
}
pub fn get(self: *Self, id: u32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = id as usize;
    // rust: (
    // rust: self.color.get(i).copied().unwrap_or(0),
    // rust: self.flags.get(i).copied().unwrap_or(AIR),
    // rust: )
}
}

pub const Tile = struct {
    /// Map colour id per column (`z * 16 + x`), `| WALL` for cut walls.
    color: [u8,
    height: [i16,
    /// Water depth below the surface, for the map's water shading.
    depth: [u8,
    revision: u64,
    layer: Layer,
    scanned: Instant,
};
/// `MapItem.update` for one column: the first block with a map colour
/// going down, the fluid's colour over a fluid unless the block is sturdy on
/// top (`getCorrectStateForFluidBlock`), and the fluid's depth.
    // rust: fn scan_column(
    // rust: chunk: &Chunk,
    // rust: palette: &Palette,
    // rust: x: i32,
    // rust: z: i32,
    // rust: top: i32,
    // rust: layer: Layer,
    // rust: ) -> (u8, i16, u8) {
    // rust: let mut y = top;
    // rust: if let Layer::Below(head) = layer {
    // rust: let (color, flags) = palette.get(chunk.get(x, head, z));
    // rust: if flags & AIR == 0 && color != 0 && flags & FLUID == 0 {
    // rust: return (color | WALL, head as i16, 0);
}
}
    // rust: let bottom = chunk.min_y();
    // rust: while y > bottom {
    // rust: let (mut color, flags) = palette.get(chunk.get(x, y, z));
    // rust: if color == 0 {
    // rust: y -= 1;
    // rust: continue;
}
    // rust: let mut depth = 0u8;
    // rust: let fluid = flags & FLUID;
    // rust: if fluid != 0 {
    // rust: let mut below = y - 1;
    // rust: while below > bottom && palette.get(chunk.get(x, below, z)).1 & FLUID != 0 {
    // rust: depth = depth.saturating_add(1);
    // rust: below -= 1;
}
    // rust: depth = depth.saturating_add(1);
    // rust: if flags & STURDY_TOP == 0 {
    // rust: color = if fluid == 2 { LAVA } else { WATER };
}
}
    // rust: return (color, y as i16, depth);
}
    // rust: (0, bottom as i16, 0)
}
/// The highest block of a chunk worth scanning from.
pub fn top_of(chunk: *Chunk, air: u32, layer: Layer) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let surface = (0..chunk.sections.len())
    // rust: .rev()
    // rust: .find(|&s| {
    // rust: chunk
    // rust: .sections
    // rust: .get(s)
    // rust: .is_some_and(|sec| !sec.is_uniform(air))
    // rust: })
    // rust: .map_or(chunk.min_y(), |s| chunk.min_y() + s as i32 * 16 + 15);
    // rust: match layer {
    // rust: Layer::Surface => surface,
    // rust: Layer::Below(head) => surface.min(head),
}
}
pub fn scan_tile(chunk: *Chunk, palette: *Palette, air: u32, layer: Layer, revision: u64) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let top = top_of(chunk, air, layer);
    // rust: let mut tile = Tile {
    // rust: color: [0; 256],
    // rust: height: [chunk.min_y() as i16; 256],
    // rust: depth: [0; 256],
    // rust: revision,
    // rust: layer,
    // rust: scanned: Instant::now(),
}
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let (c, h, d) = scan_column(chunk, palette, x, z, top, layer);
    // rust: let i = (z * 16 + x) as usize;
    // rust: tile.color[i] = c;
    // rust: tile.height[i] = h;
    // rust: tile.depth[i] = d;
}
}
    // rust: tile
}

/// Where the map looks from and how.
pub const View = struct {
    x: f64,
    z: f64,
    /// The player's yaw in degrees (0 faces south).
    yaw: f32,
    /// The map turns with the player (forward is up), or north is up.
    rotate: bool,
    blocks_per_pixel: f32,
    round: bool,
};
    // rust: impl View {
    /// Whether the image for `self` would look different from `other`'s.
pub fn differs(self: *Self, other: *View) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let moved = ((self.x - other.x).abs().max((self.z - other.z).abs()) as f32)
    // rust: >= self.blocks_per_pixel / 4.0;
    // rust: let turned = self.rotate && (self.yaw - other.yaw).abs() >= 0.5;
    // rust: moved
    // rust: || turned
    // rust: || self.rotate != other.rotate
    // rust: || self.round != other.round
    // rust: || self.blocks_per_pixel != other.blocks_per_pixel
}
    /// The world's right and forward directions as the map's x and up.
pub fn axes(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.rotate {
    // rust: return ([1.0, 0.0], [0.0, -1.0]);
}
    // rust: let (s, c) = f64::from(self.yaw).to_radians().sin_cos();
    // rust: ([-c, -s], [-s, c])
}
    /// Where north is on the map's rim, as a unit direction (x right, y down).
pub fn north(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (r, f) = self.axes();
        // The direction (0, -1) in the map's (right, -forward) basis.
    // rust: (-r[1] as f32, f[1] as f32)
}
}

/// `MapColor.getColorFromPackedId` as RGBA.
pub fn packed_rgba(id: u8, brightness: u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = usize::from(id);
    // rust: if id == 0 || id >= MAP_COLORS.len() {
    // rust: return [0; 4];
}
    // rust: let modifier = [180u32, 220, 255, 135][usize::from(brightness & 3)];
    // rust: let col = MAP_COLORS[id];
    // rust: let ch = |s: u32| ((col >> s & 255) * modifier / 255) as u8;
    // rust: [ch(16), ch(8), ch(0), 255]
}
/// The map item's shading at scale 1: brighter facing a lower north
/// neighbour, darker facing a higher one, dithered; water by depth.
pub fn brightness(color: u8, height: i16, north: ?i16, depth: u8, parity: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if color & WALL != 0 {
    // rust: return 3;
}
    // rust: let parity = f64::from(parity & 1);
    // rust: if color == WATER {
    // rust: let diff = f64::from(depth) * 0.1 + parity * 0.2;
    // rust: return if diff < 0.5 {
    // rust: 2
    // rust: } else if diff > 0.9 {
    // rust: 0
    // rust: } else {
    // rust: 1
}
}
    // rust: let north = north.unwrap_or(height);
    // rust: let diff = f64::from(height - north) * 4.0 / 5.0 + (parity - 0.5) * 0.4;
    // rust: if diff > 0.6 {
    // rust: 2
    // rust: } else if diff < -0.6 {
    // rust: 0
    // rust: } else {
    // rust: 1
}
}
pub const UNKNOWN: [u8; 4] = [20, 20, 20, 200];
pub const BORDER: [u8; 4] = [10, 10, 10, 230];

pub const Minimap = struct {
    tiles: FxHashMap<(i32,
    palette: ?Palette,
    composed: ?View,
    /// Tiles changed since the image was composed.
    changed: bool,
    /// The composed image, `SIZE` x `SIZE` RGBA.
    image: std.ArrayList(u8),
};
    // rust: impl Minimap {
    /// Forget everything (a new world or dimension, or the minimap turned off).
pub fn clear(self: *Self) void {
}
    // rust: let palette = self.palette.take();
    // rust: *self = Self {
    // rust: palette,
    // rust: ..Self::default()
}
}
    /// Fill and refresh tiles around chunk `center` within `radius` chunks,
    /// nearest first, until `budget` is spent. Returns the tiles scanned.
    // rust: pub fn update(
    // rust: &mut self,
    // rust: world: &World,
    // rust: facts: &BlockFacts,
    // rust: center: (i32, i32),
    // rust: radius: i32,
    // rust: layer: Layer,
    // rust: budget: Duration,
    // rust: ) -> usize {
    // rust: let palette = self.palette.get_or_insert_with(|| Palette::new(facts));
    // rust: let started = Instant::now();
    // rust: let air = world.air.0;
        // Tiles of unloaded or distant chunks go.
    // rust: self.tiles.retain(|k, _| {
    // rust: (k.0 - center.0).abs() <= radius + 2
    // rust: && (k.1 - center.1).abs() <= radius + 2
    // rust: && world.chunks.contains_key(k)
    // rust: });
    // rust: let mut scanned = 0;
    // rust: for ring in 0..=radius {
    // rust: for (dx, dz) in ring_offsets(ring) {
    // rust: let key = (center.0 + dx, center.1 + dz);
    // rust: let Some(chunk) = world.chunks.get(&key) else {
    // rust: continue;
}
    // rust: let stale = match self.tiles.get(&key) {
    // rust: None => true,
    // rust: Some(t) if t.layer != layer => true,
    // rust: Some(t) => t.revision != world.revision && t.scanned.elapsed() >= RESCAN,
}
    // rust: if !stale {
    // rust: continue;
}
    // rust: let tile = scan_tile(chunk, palette, air, layer, world.revision);
    // rust: if self.tiles.get(&key).is_none_or(|t| {
    // rust: t.color != tile.color || t.height != tile.height || t.depth != tile.depth
    // rust: }) {
    // rust: self.changed = true;
}
    // rust: self.tiles.insert(key, tile);
    // rust: scanned += 1;
    // rust: if started.elapsed() >= budget {
    // rust: return scanned;
}
}
}
    // rust: scanned
}
    /// Recompose the image if the view or the tiles changed; true when it did.
pub fn compose(self: *Self, view: View) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.changed
    // rust: && self.composed.is_some_and(|c| !view.differs(&c))
    // rust: && !self.image.is_empty()
    // rust: {
    // rust: return false;
}
    // rust: self.changed = false;
    // rust: self.composed = Some(view);
    // rust: self.image.resize(SIZE * SIZE * 4, 0);
    // rust: let (r, f) = view.axes();
    // rust: let bpp = f64::from(view.blocks_per_pixel);
    // rust: let half = SIZE as f64 / 2.0;
    // rust: let mut cached: Option<((i32, i32), &Tile)> = None;
    // rust: let mut column = |x: i32, z: i32| -> Option<(u8, i16, u8)> {
    // rust: let key = (x >> 4, z >> 4);
    // rust: let tile = match cached {
    // rust: Some((k, t)) if k == key => t,
    // rust: _ => {
    // rust: let t = self.tiles.get(&key)?;
    // rust: cached = Some((key, t));
    // rust: t
}
}
    // rust: let i = ((z & 15) * 16 + (x & 15)) as usize;
    // rust: Some((tile.color[i], tile.height[i], tile.depth[i]))
}
    // rust: for j in 0..SIZE {
    // rust: for i in 0..SIZE {
    // rust: let (u, v) = (i as f64 + 0.5 - half, j as f64 + 0.5 - half);
    // rust: let o = (j * SIZE + i) * 4;
    // rust: let edge = if view.round {
    // rust: let d = (u * u + v * v).sqrt();
    // rust: if d > half {
    // rust: self.image[o..o + 4].copy_from_slice(&[0; 4]);
    // rust: continue;
}
    // rust: d > half - 1.5
    // rust: } else {
    // rust: i == 0 || j == 0 || i == SIZE - 1 || j == SIZE - 1
}
    // rust: if edge {
    // rust: self.image[o..o + 4].copy_from_slice(&BORDER);
    // rust: continue;
}
    // rust: let wx = view.x + bpp * (u * r[0] - v * f[0]);
    // rust: let wz = view.z + bpp * (u * r[1] - v * f[1]);
    // rust: let (x, z) = (wx.floor() as i32, wz.floor() as i32);
    // rust: let rgba = match column(x, z) {
    // rust: Some((color, height, depth)) if color & !WALL != 0 => {
    // rust: let north = column(x, z - 1).filter(|c| c.0 & !WALL != 0).map(|c| c.1);
    // rust: let b = brightness(color, height, north, depth, x + z);
    // rust: packed_rgba(color & !WALL, b)
}
    // rust: _ => UNKNOWN,
}
    // rust: self.image[o..o + 4].copy_from_slice(&rgba);
}
}
    // rust: true
}
pub fn tile_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tiles.len()
}
}
/// Chunk offsets at Chebyshev distance `ring`.
pub fn ring_offsets(ring: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (-ring..=ring).flat_map(move |dz| {
    // rust: (-ring..=ring)
    // rust: .filter(move |&dx| dx.abs() == ring || dz.abs() == ring)
    // rust: .map(move |dx| (dx, dz))
    // rust: })
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::Arc;

    // States: 0 air, 1 grass (colour 1), 2 stone (11), 3 water, 4 glass (no
    // colour), 5 waterlogged slab (sturdy on top? no), 6 lava.
pub fn palette() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Palette::from_parts(&[
    // rust: (0, AIR),
    // rust: (1, STURDY_TOP),
    // rust: (11, STURDY_TOP),
    // rust: (WATER, 1),
    // rust: (0, 0),
    // rust: (11, 1),
    // rust: (LAVA, 2),
    // rust: ])
}
pub fn chunk(columns: *[(i32) void {
}
    // rust: let mut c = Chunk::empty(0, 0);
    // rust: for &(x, z, blocks) in columns {
    // rust: for &(y, id) in blocks {
    // rust: c.set(x, y, z, id);
}
}
    // rust: c
}

pub fn columns_take_the_first_coloured_block_and_fluids_over_it() void {
}
    // rust: let p = palette();
    // rust: let c = chunk(&[
    // rust: (0, 0, &[(60, 2), (61, 1)]),
            // Glass has no map colour: the grass under it shows.
    // rust: (1, 0, &[(61, 1), (62, 4)]),
            // Three water over stone.
    // rust: (2, 0, &[(60, 2), (61, 3), (62, 3), (63, 3)]),
    // rust: (3, 0, &[(70, 6)]),
    // rust: ]);
    // rust: let top = top_of(&c, 0, Layer::Surface);
    // rust: assert_eq!(top, 79);
    // rust: assert_eq!(scan_column(&c, &p, 0, 0, top, Layer::Surface), (1, 61, 0));
    // rust: assert_eq!(scan_column(&c, &p, 1, 0, top, Layer::Surface), (1, 61, 0));
    // rust: assert_eq!(
    // rust: scan_column(&c, &p, 2, 0, top, Layer::Surface),
    // rust: (WATER, 63, 3)
    // rust: );
    // rust: assert_eq!(
    // rust: scan_column(&c, &p, 3, 0, top, Layer::Surface),
    // rust: (LAVA, 70, 1)
    // rust: );
    // rust: assert_eq!(scan_column(&c, &p, 4, 0, top, Layer::Surface).0, 0);
}

pub fn a_waterlogged_block_not_sturdy_on_top_shows_water() void {
}
    // rust: let p = palette();
    // rust: let c = chunk(&[(0, 0, &[(60, 2), (61, 5)])]);
    // rust: assert_eq!(
    // rust: scan_column(&c, &p, 0, 0, 70, Layer::Surface),
    // rust: (WATER, 61, 1)
    // rust: );
}

pub fn below_a_height_shows_the_floor_and_cuts_walls() void {
}
    // rust: let p = palette();
        // A cave: stone everywhere from 0 to 20, air at 10 and 11 in column 0.
    // rust: let mut blocks: Vec<(i32, u32)> = (0..=20).map(|y| (y, 2)).collect();
    // rust: let solid = blocks.clone();
    // rust: blocks.retain(|&(y, _)| y != 10 && y != 11);
    // rust: let c = chunk(&[(0, 0, &blocks), (1, 0, &solid)]);
    // rust: let layer = Layer::Below(11);
    // rust: let top = top_of(&c, 0, layer);
    // rust: assert_eq!(top, 11);
    // rust: assert_eq!(scan_column(&c, &p, 0, 0, top, layer), (11, 9, 0));
    // rust: assert_eq!(scan_column(&c, &p, 1, 0, top, layer), (11 | WALL, 11, 0));
        // The surface view sees the roof.
    // rust: assert_eq!(scan_column(&c, &p, 0, 0, 31, Layer::Surface), (11, 20, 0));
}

pub fn shading_follows_the_map_item() void {
}
        // Higher than the north neighbour: bright; lower: dark; level: normal.
    // rust: assert_eq!(brightness(1, 65, Some(64), 0, 0), 2);
    // rust: assert_eq!(brightness(1, 63, Some(64), 0, 1), 0);
    // rust: assert_eq!(brightness(1, 64, Some(64), 0, 0), 1);
    // rust: assert_eq!(brightness(1, 64, Some(64), 0, 1), 1);
        // Shallow water is bright, deep water dark.
    // rust: assert_eq!(brightness(WATER, 62, None, 1, 0), 2);
    // rust: assert_eq!(brightness(WATER, 62, None, 10, 0), 0);
    // rust: assert_eq!(brightness(1 | WALL, 0, None, 0, 0), 3);
    // rust: assert_eq!(packed_rgba(1, 2), [127, 178, 56, 255]);
    // rust: assert_eq!(packed_rgba(0, 2), [0; 4]);
}

pub fn world_with(chunks: std.ArrayList(Chunk)) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: for c in chunks {
    // rust: w.chunks.insert((c.x, c.z), Arc::new(c));
}
    // rust: w
}
pub fn grass_chunk(x: i32, z: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut c = Chunk::empty(x, z);
    // rust: for bz in 0..16 {
    // rust: for bx in 0..16 {
    // rust: c.set(bx, 64, bz, 1);
}
}
    // rust: c
}

pub fn tiles_fill_nearest_first_and_follow_changes() void {
}
    // rust: let mut map = Minimap {
    // rust: palette: Some(palette()),
    // rust: ..Default::default()
}
    // rust: let facts = BlockFacts {
    // rust: states: Vec::new(),
    // rust: air: horizon_world::registry::BlockStateId(0),
    // rust: woods: Default::default(),
}
    // rust: let mut world = world_with(
    // rust: (-2..=2)
    // rust: .flat_map(|x| (-2..=2).map(move |z| grass_chunk(x, z)))
    // rust: .collect(),
    // rust: );
        // A zero budget still scans one tile: the player's own chunk.
    // rust: assert_eq!(
    // rust: map.update(&world, &facts, (0, 0), 2, Layer::Surface, Duration::ZERO),
    // rust: 1
    // rust: );
    // rust: assert!(map.tiles.contains_key(&(0, 0)));
    // rust: let n = map.update(
    // rust: &world,
    // rust: &facts,
    // rust: (0, 0),
    // rust: 2,
    // rust: Layer::Surface,
    // rust: Duration::from_secs(1),
    // rust: );
    // rust: assert_eq!(n, 24);
    // rust: assert_eq!(map.tile_count(), 25);
        // Nothing changed: nothing to scan.
    // rust: assert_eq!(
    // rust: map.update(
    // rust: &world,
    // rust: &facts,
    // rust: (0, 0),
    // rust: 2,
    // rust: Layer::Surface,
    // rust: Duration::from_secs(1)
    // rust: ),
    // rust: 0
    // rust: );
        // A changed world is rescanned once the tiles are old enough.
    // rust: world
    // rust: .set(0, 70, 0, horizon_world::registry::BlockStateId(2))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: map.update(
    // rust: &world,
    // rust: &facts,
    // rust: (0, 0),
    // rust: 2,
    // rust: Layer::Surface,
    // rust: Duration::from_secs(1)
    // rust: ),
    // rust: 0
    // rust: );
    // rust: for t in map.tiles.values_mut() {
    // rust: t.scanned -= RESCAN;
}
    // rust: assert_eq!(
    // rust: map.update(
    // rust: &world,
    // rust: &facts,
    // rust: (0, 0),
    // rust: 2,
    // rust: Layer::Surface,
    // rust: Duration::from_secs(1)
    // rust: ),
    // rust: 25
    // rust: );
    // rust: assert_eq!(map.tiles[&(0, 0)].color[0], 11);
        // A new layer rescans everything; unloaded chunks drop out.
    // rust: world.chunks.remove(&(2, 2));
    // rust: let n = map.update(
    // rust: &world,
    // rust: &facts,
    // rust: (0, 0),
    // rust: 2,
    // rust: Layer::Below(70),
    // rust: Duration::from_secs(1),
    // rust: );
    // rust: assert_eq!(n, 24);
    // rust: assert!(!map.tiles.contains_key(&(2, 2)));
}

pub fn the_image_is_north_up_or_turns_with_the_player() void {
}
    // rust: let mut map = Minimap {
    // rust: palette: Some(palette()),
    // rust: ..Default::default()
}
    // rust: let facts = BlockFacts {
    // rust: states: Vec::new(),
    // rust: air: horizon_world::registry::BlockStateId(0),
    // rust: woods: Default::default(),
}
        // Grass everywhere, one stone block 10 blocks north of the player.
    // rust: let mut world = world_with(
    // rust: (-4..=4)
    // rust: .flat_map(|x| (-4..=4).map(move |z| grass_chunk(x, z)))
    // rust: .collect(),
    // rust: );
    // rust: world
    // rust: .set(0, 64, -10, horizon_world::registry::BlockStateId(2))
    // rust: .unwrap();
    // rust: map.update(
    // rust: &world,
    // rust: &facts,
    // rust: (0, 0),
    // rust: 4,
    // rust: Layer::Surface,
    // rust: Duration::from_secs(1),
    // rust: );
    // rust: let pixel = |map: &Minimap, i: usize, j: usize| {
    // rust: let o = (j * SIZE + i) * 4;
    // rust: [map.image[o], map.image[o + 1], map.image[o + 2]]
}
    // rust: let stone = [96, 96, 96];
    // rust: let mut view = View {
    // rust: x: 0.0,
    // rust: z: 0.0,
    // rust: yaw: 0.0,
    // rust: rotate: false,
    // rust: blocks_per_pixel: 1.0,
    // rust: round: false,
}
    // rust: assert!(map.compose(view));
    // rust: assert!(!map.compose(view), "the same view is not recomposed");
        // North up: the stone is 10 pixels above the centre.
    // rust: assert_eq!(pixel(&map, 64, 54), stone);
        // Turning with the player facing east (yaw -90): north is to the left.
    // rust: view.rotate = true;
    // rust: view.yaw = -90.0;
    // rust: assert!(map.compose(view));
    // rust: assert_eq!(pixel(&map, 54, 63), stone);
    // rust: let (nx, ny) = view.north();
    // rust: assert!((nx + 1.0).abs() < 1e-5 && ny.abs() < 1e-5, "{nx} {ny}");
        // Facing north, north is up.
    // rust: view.yaw = 180.0;
    // rust: map.compose(view);
    // rust: assert_eq!(pixel(&map, 64, 54), stone);
        // Round maps are transparent in the corners, framed at the edge.
    // rust: view.round = true;
    // rust: map.compose(view);
    // rust: assert_eq!(map.image[3], 0);
    // rust: assert_eq!(&map.image[(64 * SIZE) * 4..(64 * SIZE) * 4 + 4], &BORDER);
        // A small move recomposes only once it is visible.
    // rust: view.x += 0.1;
    // rust: assert!(!map.compose(view));
    // rust: view.x += 0.2;
    // rust: assert!(map.compose(view));
}

pub fn rings_cover_each_offset_once() void {
}
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for r in 0..=3 {
    // rust: for o in ring_offsets(r) {
    // rust: assert!(seen.insert(o));
}
}
    // rust: assert_eq!(seen.len(), 49);
}
}
