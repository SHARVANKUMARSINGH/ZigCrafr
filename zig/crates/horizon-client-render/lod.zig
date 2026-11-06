//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_lod
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Bounded voxel-column terrain for distances beyond the resident chunk area.
//! Far tiles never enter World, lighting, simulation or the section cave graph.
// use crate::{
    // rust: blocks::BlockFacts,
    // rust: chunk::{Chunk, MIN_Y},
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: mesher::SectionMesh,
    // rust: streaming::{LodSource, WorkerContext},
}
    // rust: pub mod cache;
    // rust: mod mesh;
// use horizon_world::registry::BlockStateId;
// use std::{
    // rust: collections::VecDeque,
    // rust: sync::{
    // rust: Arc, Condvar, Mutex,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: mpsc,
    // rust: },
    // rust: thread,
}

pub const CELLS: usize = 16;
pub const MAX_SAVED: usize = 1024;
/// How many resident chunks may wait for the worker's summary at once
/// (`Lod::observing`).
pub const OBSERVE_AHEAD: usize = 8;
/// How long a tile whose sample waited for data (`Lod::finish_waited`) waits
/// before it is sampled again without word of it.
pub const WAIT_RETRY: std::time::Duration = std::time::Duration::from_secs(10);
pub const SAMPLE_JOBS: usize = 4;
/// Sample jobs queued per sampling thread once the near terrain is in.
/// Results are taken and jobs started once a frame: with four in flight, a
/// tile taking milliseconds left the threads idle for most of a slow frame
/// (2-3 fps on a CPU renderer, with far terrain a few tiles a frame).
pub const QUEUED_PER_SAMPLER: usize = 32;
/// The last `refresh`es `Lod::refreshed_since` tells apart by area.
pub const MAX_REFRESHED: usize = 64;
/// Threads that sample far tiles beside the mesher. Sampling is the cold-load
/// bottleneck (each task evaluates a shared density lattice for 256 columns),
/// so medium machines use two thirds of their cores, not half.
///
/// The mesher has little to do until tiles are sampled, so its threads sit
/// idle through the part of a cold build that waits on sampling. Measured on
/// a 12-thread machine building 4336 tiles at LOD distance 256, from the game
/// answering the control socket until every target tile is sampled, four runs
/// a configuration:
///
/// | samplers / meshers | sampling | whole build |
/// |---|---|---|
/// | 6 / 5 (before) | 15.0 s | 23.9 s |
/// | 8 / 3 | 11.8 s | 18.6 s |
/// | 9 / 2 | 10.6 s | 19.1 s |
///
/// Nine samplers finish sampling sooner still, but leave the mesher two
/// threads and the whole build ends later. The cap keeps a large machine
/// from starving its mesher, and `meshing_threads` keeps the frame and the
/// ticks a core either way.
pub fn sampling_threads(cores: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cores >= 8 {
    // rust: (cores * 2 / 3).min(8)
    // rust: } else {
    // rust: (cores / 4).clamp(1, 3)
}
}
/// Tile meshing used to be one worker with a whole selection batch at a time.
/// It now has its own pool, sized so ticks and the frame keep a core.
pub fn meshing_threads(cores: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cores
    // rust: .saturating_sub(sampling_threads(cores) + 1)
    // rust: .clamp(1, 16)
}
/// While the near terrain loads on a machine with four threads or fewer, far
/// terrain starts one sample job at most this often and no detail: it would
/// otherwise take the cores the near chunks and the frame need.
pub const HELD_SAMPLE_STEP: std::time::Duration = std::time::Duration::from_millis(500);
/// How long a tile whose sampling failed (`LodSampler::grid` gave no
/// columns: a server refused or lost it) waits before it is asked again.
pub const RETRY: std::time::Duration = std::time::Duration::from_secs(2);
/// The most a tile a zoomed view magnifies may split past the plan it would
/// have had ([`ZoomAim`]): cells three times smaller, so nine times the tiles
/// where it applies. A spyglass covers about a sixteenth of the circle, so at
/// the 4078 tiles and ~1500 quads a tile measured at `lodDistance` 256 this
/// asks for roughly 45% more far tiles while the zoom is held, and gives them
/// back when it is released. Four would be about 85%: raise it only with a
/// measurement, because the cost grows with the square.
pub const MAX_ZOOM_BOOST: i32 = 3;
/// Yaw is rounded to this many degrees before it reaches the plan, so turning
/// the mouse does not rebuild the quadtree every frame. The cone is widened by
/// as much, so rounding never swings it off a tile being looked at.
pub const ZOOM_YAW_STEP: f32 = 5.0;

/// Where a zoomed view asks for finer far tiles (the `lodZoomDetail` extra).
///
/// `Plan::visit`'s falloff keeps a tile's cells roughly the same size on
/// screen, which silently assumes the field of view never changes. A spyglass
/// (`SpyglassItem`, a tenth of it) or the zoom mod breaks that: the same tile
/// covers many times more pixels, so its cells look as coarse as a tile ten
/// times nearer would. This asks the tiles the zoom actually magnifies to
/// split further.
///
/// Only those: lifting the whole circle would ask for about a hundred times
/// the tiles, which at the quads measured above is gigabytes of vertices. The
/// cone is the narrowed view's, and `MAX_ZOOM_BOOST` caps how far it goes.
pub const ZoomAim = struct {
    /// The view direction in x/z, in thousandths of a unit vector.
    dir: [i32,
    /// The cosine of the cone's half-angle, in thousandths.
    cos_half: i32,
    /// How many times further than the unzoomed plan a tile inside the cone
    /// may split. Two or more; [`ZoomAim::new`] gives `None` for less.
    boost: i32,
};

    // rust: impl ZoomAim {
    /// `fov_degrees` is the zoomed field of view and `magnification` how many
    /// times the view is magnified (1 when it is not). `None` when the zoom is
    /// too slight to be worth replanning for.
pub fn new(yaw: f32, fov_degrees: f32, magnification: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !magnification.is_finite() || !fov_degrees.is_finite() || fov_degrees <= 0.0 {
    // rust: return None;
}
    // rust: let boost = (magnification.round() as i64).clamp(1, i64::from(MAX_ZOOM_BOOST)) as i32;
    // rust: if boost < 2 {
    // rust: return None;
}
        // Half the field of view spans the screen's width; three quarters of
        // it reaches the corners, and the rounding step is added on top.
    // rust: let half = (fov_degrees * 0.75 + ZOOM_YAW_STEP).clamp(5.0, 90.0);
    // rust: let radians = ((yaw / ZOOM_YAW_STEP).round() * ZOOM_YAW_STEP).to_radians();
        // `view_vector`'s x and z: yaw 0 looks toward +z.
    // rust: let thousandths = |v: f32| (v * 1000.0).round() as i32;
    // rust: Some(Self {
    // rust: dir: [thousandths(-radians.sin()), thousandths(radians.cos())],
    // rust: cos_half: thousandths(half.to_radians().cos()),
    // rust: boost,
    // rust: })
}
    /// Whether the cone reaches `key`, so the zoom magnifies it.
    ///
    /// The tile is taken as the circle around its centre that covers it, and
    /// that circle's own angular radius widens the cone for the test, so a
    /// tile straddling the edge counts in rather than out. A tile whose circle
    /// reaches the camera is always in: there is no direction to compare, and
    /// it fills the view whichever way the player faces.
pub fn covers(self: *Self, key: TileKey, camera: [i32; 2]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [ox, _, oz] = key.origin();
    // rust: let size = key.size();
        // The camera stands in the tile: it is in view whichever way the
        // player faces, and there is no direction to compare it with. Tested
        // on the box rather than on the circle below, whose radius a camera
        // on a corner matches exactly -- a float coin-toss.
        // In i64: a level 22 tile is 67 million blocks wide, so the sum
        // at the far edge of the world overflows an i32.
    // rust: let (ox64, oz64, size64) = (i64::from(ox), i64::from(oz), i64::from(size));
    // rust: if (ox64..ox64 + size64).contains(&i64::from(camera[0]))
    // rust: && (oz64..oz64 + size64).contains(&i64::from(camera[1]))
    // rust: {
    // rust: return true;
}
    // rust: let half = f64::from(size) / 2.0;
    // rust: let cx = f64::from(ox) + half - f64::from(camera[0]);
    // rust: let cz = f64::from(oz) + half - f64::from(camera[1]);
    // rust: let distance = (cx * cx + cz * cz).sqrt();
    // rust: let radius = half * std::f64::consts::SQRT_2;
    // rust: if distance <= radius {
    // rust: return true;
}
    // rust: let dir = [
    // rust: f64::from(self.dir[0]) / 1000.0,
    // rust: f64::from(self.dir[1]) / 1000.0,
    // rust: ];
    // rust: let cos = (cx * dir[0] + cz * dir[1]) / distance;
    // rust: let sin = (1.0 - cos * cos).max(0.0).sqrt();
        // cos(angle - tile radius), expanded so no inverse trigonometry runs
        // per tile: the quadtree asks this of every node it visits.
    // rust: let radius_sin = (radius / distance).min(1.0);
    // rust: let radius_cos = (1.0 - radius_sin * radius_sin).max(0.0).sqrt();
    // rust: cos * radius_cos + sin * radius_sin >= f64::from(self.cos_half) / 1000.0
}
}

/// The coarsest tile level: `Plan` roots cover at most `MAX_CHUNKS` chunks
/// around (a level-22 tile is 67 million blocks wide: the whole world).
    // rust: pub(crate) const MAX_LEVEL: u8 = 22;
/// Tiles this far from the camera (1024 chunks, as far as far terrain went
/// before it covered the world) are planned with `WORLD_SPLIT`.
pub const WORLD_START: i32 = 1024 * 16;
/// How many tile widths away from the camera a tile of the world-wide terrain
/// splits (`Plan::visit`: cells then span about 1/48 of the distance).
pub const WORLD_SPLIT: i32 = 3;
/// A split tile stays split until its distance passes the threshold by this
/// ratio (`Plan::visit`): 1 / 0.95.
pub const RETURN: (i64, i64) = (20, 19);
/// The farthest `Plan` reaches, in chunks.
pub const MAX_CHUNKS: u32 = 1 << 22;
/// The coarsest tile level whose chunks are generated in full (trees,
/// structures) rather than sampled: cells of up to 4 blocks, out to about
/// 1024 blocks at Full far detail.
pub const DETAIL_LEVEL: u8 = 2;
/// The most chunks one detail request asks for, one request each 250 ms:
/// generated ones arrive at the decoration threads' pace, cached ones at once.
pub const DETAIL_REQUEST: usize = 512;
/// How long one frame spends applying far detail and visited summaries
/// (`Lod::receive`).
///
/// Cached chunks answer a `DETAIL_REQUEST` all at once, and applying one
/// copies the columns of every tile over it (`Arc::make_mut` on a snapshot a
/// mesh job shares) and reduces the chunk to that tile's cell width. A whole
/// burst in one frame cost 273 ms of it on the render thread, flying over far
/// terrain at `lodDistance` 256: 18 FPS average, 482 ms at the 99th
/// percentile, where the median frame was 6 ms. What the budget leaves waits
/// in `Lod::detail_backlog` for the frames after it.
pub const DETAIL_BUDGET: std::time::Duration = std::time::Duration::from_millis(3);
/// Top solid face and optional fluid face, in absolute block coordinates.
pub const Surface = struct {
    height: i32,
    state: BlockStateId,
    water: Option<(i32,
    biome: u16,
};
/// A half-open material run; gaps between runs remain air.
pub const Span = struct {
    min: i16,
    max: i16,
    state: BlockStateId,
    biome: u16,
    light: u16,
};
/// A column's material runs. Almost every far column has one to four, so
/// they live inline: the sampler builds millions of columns and a heap
/// allocation each dominated its memory and allocator time.
pub const Spans = struct {};
    // rust: impl Spans {
    // rust: pub const fn new() -> Self {
    // rust: Self(smallvec::SmallVec::new_const())
}
pub fn with_capacity(capacity: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(smallvec::SmallVec::with_capacity(capacity))
}
pub fn push(self: *Self, span: Span) void {
}
    // rust: self.0.push(span);
}
pub fn reserve(self: *Self, additional: usize) void {
}
    // rust: self.0.reserve(additional);
}
pub fn as_slice(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.0
}
}
    // rust: impl std::ops::Deref for Spans {
    // rust: type Target = [Span];
pub fn deref(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.0
}
}
    // rust: impl std::ops::DerefMut for Spans {
pub fn deref_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.0
}
}
    // rust: impl From<Vec<Span>> for Spans {
pub fn from(spans: std.ArrayList(Span)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(spans.into())
}
}
    // rust: impl FromIterator<Span> for Spans {
    // rust: fn from_iter<I: IntoIterator<Item = Span>>(iter: I) -> Self {
    // rust: Self(iter.into_iter().collect())
}
}
    // rust: impl IntoIterator for Spans {
    // rust: type Item = Span;
    // rust: type IntoIter = smallvec::IntoIter<[Span; 4]>;
pub fn into_iter(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.into_iter()
}
}
    // rust: impl<'a> IntoIterator for &'a Spans {
    // rust: type Item = &'a Span;
    // rust: type IntoIter = std::slice::Iter<'a, Span>;
pub fn into_iter(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.iter()
}
}
    // rust: impl<'a> IntoIterator for &'a mut Spans {
    // rust: type Item = &'a mut Span;
    // rust: type IntoIter = std::slice::IterMut<'a, Span>;
pub fn into_iter(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.iter_mut()
}
}
    // rust: impl<const N: usize> PartialEq<[Span; N]> for Spans {
pub fn eq(self: *Self, other: *[Span; N]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.as_slice() == other
}
}
    // rust: impl PartialEq<Vec<Span>> for Spans {
pub fn eq(self: *Self, other: *std.ArrayList(Span)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.as_slice() == other.as_slice()
}
}
pub const Column = struct {
    surface: ?Surface,
    spans: Spans,
};
    // rust: impl Column {
    /// Reduce an entire horizontal footprint, rather than inflating its corner
    /// column. A height is drawn where any column of the footprint holds a
    /// block there, in the material most of them hold: anything joined to
    /// the ground stays joined at every width. Drawing only heights most of
    /// the footprint held dropped trunks (one column of 16 or 256) under the
    /// crowns they hold up, and the crowns hung in the air as slabs.
pub fn reduced(columns: *[Column; 256], x: usize, z: usize, width: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if width == 1 {
    // rust: return columns[z * 16 + x].clone();
}
    // rust: let mut events = Vec::new();
    // rust: for dz in z..z + width {
    // rust: for dx in x..x + width {
    // rust: for span in &columns[dz * 16 + dx].spans {
    // rust: let material = (span.state, span.biome, span.light);
    // rust: events.push((span.min, material, 1));
    // rust: events.push((span.max, material, -1));
}
}
}
    // rust: events.sort_unstable_by_key(|event| event.0);
    // rust: let mut result = Self::default();
    // rust: let mut votes = Vec::<((BlockStateId, u16), i32)>::new();
    // rust: let mut sky = [0i32; 16];
    // rust: let mut block = [0i32; 16];
    // rust: let mut occupied = 0;
    // rust: let mut bottom = MIN_Y as i16;
    // rust: for (y, material, change) in events {
    // rust: if bottom < y {
    // rust: if occupied > 0
    // rust: && let Some(&((state, biome), _)) =
    // rust: votes.iter().max_by_key(|&(material, count)| {
    // rust: (*count, std::cmp::Reverse((material.0.0, material.1)))
    // rust: })
    // rust: {
                    // Lighting must not split votes for the same material.
                    // Reduction can expose buried faces; retain the brightest
                    // actual light in this occupied footprint, per channel.
    // rust: let light = (sky.iter().rposition(|&n| n > 0).unwrap_or(0) << 4)
    // rust: | (block.iter().rposition(|&n| n > 0).unwrap_or(0) << 12);
    // rust: result.push(Span {
    // rust: min: bottom,
    // rust: max: y,
    // rust: state,
    // rust: biome,
    // rust: light: light as u16,
    // rust: });
}
    // rust: bottom = y;
}
    // rust: occupied += change;
    // rust: sky[usize::from((material.2 >> 4) & 15)] += change;
    // rust: block[usize::from((material.2 >> 12) & 15)] += change;
    // rust: let material = (material.0, material.1);
    // rust: if let Some(vote) = votes.iter_mut().find(|vote| vote.0 == material) {
    // rust: vote.1 += change;
    // rust: } else {
    // rust: votes.push((material, change));
}
}
    // rust: result
}
pub fn from_surface(surface: ?Surface) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut column = Self {
    // rust: surface,
    // rust: spans: Spans::new(),
}
    // rust: if let Some(s) = surface {
    // rust: if s.height > MIN_Y {
    // rust: column.spans.push(Span {
    // rust: min: MIN_Y as i16,
    // rust: max: s.height as i16,
    // rust: state: s.state,
    // rust: biome: s.biome,
    // rust: light: 240,
    // rust: });
}
    // rust: if let Some((height, state)) = s.water {
    // rust: column.spans.push(Span {
    // rust: min: s.height as i16,
    // rust: max: height as i16,
    // rust: state,
    // rust: biome: s.biome,
    // rust: light: 240,
    // rust: });
}
}
    // rust: column
}
pub fn push(self: *Self, span: Span) void {
}
    // rust: if let Some(last) = self.spans.last_mut()
    // rust: && last.max == span.min
    // rust: && last.state == span.state
    // rust: && last.biome == span.biome
    // rust: && last.light == span.light
    // rust: {
    // rust: last.max = span.max;
    // rust: } else {
    // rust: self.spans.push(span);
}
}
    /// `kinds`: `state_kinds`, per block state; `water`: `water_source(kinds)`,
    /// what blocks holding water (kelp, seagrass, waterlogged ones) are drawn as.
    // rust: fn from_chunk(
    // rust: chunk: &Chunk,
    // rust: kinds: &[u8],
    // rust: water: Option<BlockStateId>,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Self {
    // rust: let kind = |state: BlockStateId| kinds.get(state.0 as usize).copied().unwrap_or(0);
    // rust: let face_light = |y: i32| {
    // rust: let mut sky = 0;
    // rust: let mut block = 0;
    // rust: for (dx, dy, dz) in [
    // rust: (0, 0, 0),
    // rust: (-1, 0, 0),
    // rust: (1, 0, 0),
    // rust: (0, -1, 0),
    // rust: (0, 1, 0),
    // rust: (0, 0, -1),
    // rust: (0, 0, 1),
    // rust: ] {
    // rust: if !(0..16).contains(&(x + dx)) || !(0..16).contains(&(z + dz)) {
    // rust: continue;
}
    // rust: let value = chunk.light(x + dx, y + dy, z + dz);
    // rust: sky = sky.max(value & 0xf0);
    // rust: block = block.max(value & 15);
}
    // rust: sky | block
}
    // rust: let mut column = Self::default();
    // rust: for (sy, section) in chunk.sections.iter().enumerate() {
    // rust: let min = chunk.min_y() + sy as i32 * 16;
    // rust: let uniform = section.blocks.bits() == 0
    // rust: && section.biomes.bits() == 0
    // rust: && matches!(section.light, crate::chunk::Light::Uniform(_));
    // rust: let uniform = uniform
    // rust: && face_light(min) == chunk.light(x, min, z)
    // rust: && face_light(min + 15) == chunk.light(x, min, z);
    // rust: let step = if uniform { 16 } else { 1 };
    // rust: for offset in (0..16).step_by(step) {
    // rust: let y = min + offset;
    // rust: let mut state = BlockStateId(chunk.get(x, y, z));
    // rust: let mut kind = kind(state);
    // rust: if kind & KEPT == 0 {
    // rust: continue;
}
    // rust: if kind & WATERY != 0
    // rust: && let Some(water) = water
    // rust: {
    // rust: state = water;
    // rust: kind = kinds[water.0 as usize];
}
    // rust: let light = face_light(y);
    // rust: column.push(Span {
    // rust: min: y as i16,
    // rust: max: (y + step as i32) as i16,
    // rust: state,
    // rust: biome: chunk.biome(x, y, z),
    // rust: light: u16::from(light & 0xf0) | (u16::from((light & 15).max(kind >> 4)) << 12),
    // rust: });
}
}
    // rust: let mut water = None;
    // rust: for span in column.spans.iter().rev() {
    // rust: if kind(span.state) & FLUID != 0 {
    // rust: water.get_or_insert((i32::from(span.max), span.state));
    // rust: } else {
    // rust: column.surface = Some(Surface {
    // rust: height: i32::from(span.max),
    // rust: state: span.state,
    // rust: water,
    // rust: biome: span.biome,
    // rust: });
    // rust: break;
}
}
    // rust: if column.surface.is_none()
    // rust: && let Some((height, state)) = water
    // rust: {
    // rust: column.surface = Some(Surface {
    // rust: height: chunk.min_y(),
    // rust: state: BlockStateId(
    // rust: kinds.iter().position(|&kind| kind & AIR != 0).unwrap_or(0) as u32
    // rust: ),
    // rust: water: Some((height, state)),
    // rust: biome: chunk.biome(x, height - 1, z),
    // rust: });
}
    // rust: column
}
}
/// A chunk's 256 columns (`Column::from_chunk`), on the far-terrain worker.
    // rust: pub(crate) fn summarize(chunk: &Chunk, kinds: &[u8]) -> Arc<[Column; 256]> {
    // rust: let water = water_source(kinds);
    // rust: Arc::new(std::array::from_fn(|i| {
    // rust: Column::from_chunk(chunk, kinds, water, (i & 15) as i32, (i >> 4) as i32)
    // rust: }))
}
/// The water source state: the first plain kept fluid without light
/// (`minecraft:water` comes before lava, and its level 0 first).
pub fn water_source(kinds: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: kinds
    // rust: .iter()
    // rust: .position(|&kind| kind == KEPT | FLUID)
    // rust: .map(|i| BlockStateId(i as u32))
}
/// `state_kinds` bits: kept in columns, a fluid, the air state, a block
/// holding water; the light emission is in the high nibble.
pub const KEPT: u8 = 1;
pub const FLUID: u8 = 2;
pub const AIR: u8 = 4;
/// A block holding water that draws as none (kelp, seagrass, bubble columns,
/// waterlogged blocks that aren't kept): far terrain draws water there, or
/// kelp reaching the surface leaves holes in the sea.
pub const WATERY: u8 = 8;
/// What `Column::from_chunk` needs of each block state, read from the facts
/// once: matching their names for every block made observing a chunk slow.
    // rust: pub(crate) fn state_kinds(facts: &BlockFacts) -> Vec<u8> {
    // rust: (0..facts.states.len())
    // rust: .map(|i| {
    // rust: let state = BlockStateId(i as u32);
    // rust: let f = facts.get(state);
    // rust: let fluid = matches!(&*f.name, "minecraft:water" | "minecraft:lava");
            // Chorus is thin and non-solid but a visible part of the far End.
    // rust: let chorus = matches!(
    // rust: &*f.name,
    // rust: "minecraft:chorus_plant" | "minecraft:chorus_flower"
    // rust: );
    // rust: let kept = !facts.is_air(state)
    // rust: && (f.solid_render
    // rust: || f.full_collision
    // rust: || f.name.ends_with("_leaves")
    // rust: || chorus
    // rust: || fluid
    // rust: || nearly_full(&f.name));
    // rust: let watery = !kept && !facts.is_air(state) && f.fluid == crate::blocks::Fluid::Water;
    // rust: (u8::from(kept || watery) * KEPT)
    // rust: | (u8::from(fluid || watery) * FLUID)
    // rust: | (u8::from(watery) * WATERY)
    // rust: | (u8::from(state == facts.air) * AIR)
    // rust: | (f.emission.min(15) << 4)
    // rust: })
    // rust: .collect()
}
/// Blocks that fill their cell but neither draw solid nor collide as a full
/// block: far terrain draws them as blocks, or patches of powder snow leave
/// holes in mountains (and paths and fields dips).
pub fn nearly_full(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:powder_snow"
    // rust: | "minecraft:dirt_path"
    // rust: | "minecraft:farmland"
    // rust: | "minecraft:honey_block"
    // rust: ) || name.ends_with("_stairs")
    // rust: || name.contains("fence")
    // rust: || name.contains("_wall")
    // rust: || name.contains("bars")
    // rust: || name.contains("_pane")
    // rust: || name.contains("chain")
    // rust: || name.contains("ladder")
}
/// Clears the detail bits of a tile's cells whose chunk lies in `area`, but
/// for the chunks `kept` (seen in the world): `request_detail` asks for them
/// again.
    // rust: fn forget_detail(
    // rust: key: TileKey,
    // rust: area: [i32; 4],
    // rust: mask: &mut [u64; 4],
    // rust: kept: impl Fn((i32, i32)) -> bool,
    // rust: ) {
    // rust: let [ox, _, oz] = key.origin();
    // rust: let stride = key.size() / 16;
    // rust: for index in 0..256 {
    // rust: let chunk = (
    // rust: (ox + (index as i32 % 16) * stride).div_euclid(16),
    // rust: (oz + (index as i32 / 16) * stride).div_euclid(16),
    // rust: );
    // rust: let fine = TileKey {
    // rust: x: chunk.0,
    // rust: z: chunk.1,
    // rust: level: 0,
}
    // rust: if fine.overlaps(area) && !kept(chunk) {
    // rust: mask[index / 64] &= !(1 << (index % 64));
}
}
}
/// The tiles over `chunk` to sample again once their source keeps it
/// (`Lod::resample_over`): those whose sample is still being taken, maybe
/// from before, and those of cells wider than a chunk sampled empty there,
/// which a chunk's own detail can't fill (`apply_detail`). The others hold
/// it once `finish_detail` applies it.
    // rust: fn resampled_over(
    // rust: ready: &FxHashMap<TileKey, Arc<Vec<Column>>>,
    // rust: pending: &FxHashSet<TileKey>,
    // rust: (cx, cz): (i32, i32),
    // rust: ) -> Vec<TileKey> {
    // rust: (1..=MAX_LEVEL)
    // rust: .filter_map(|level| {
    // rust: let size = 16 << level;
    // rust: let key = TileKey {
    // rust: x: (cx * 16).div_euclid(size),
    // rust: z: (cz * 16).div_euclid(size),
    // rust: level,
}
    // rust: let resample = match ready.get(&key) {
    // rust: None => pending.contains(&key),
    // rust: Some(samples) => {
    // rust: let stride = size / CELLS as i32;
    // rust: let [ox, _, oz] = key.origin();
    // rust: let cell = (cz * 16 - oz) / stride * CELLS as i32 + (cx * 16 - ox) / stride;
    // rust: stride > 16
    // rust: && (pending.contains(&key)
    // rust: || samples
    // rust: .get(cell as usize)
    // rust: .is_some_and(|c| *c == Column::default()))
}
}
    // rust: resample.then_some(key)
    // rust: })
    // rust: .collect()
}
pub const TileKey = struct {
    x: i32,
    z: i32,
    level: u8,
};
    // rust: impl TileKey {
pub fn size(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 16 << self.level
}
pub fn origin(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [self.x * self.size(), 0, self.z * self.size()]
}
    // rust: pub(crate) fn parent(self) -> Self {
    // rust: Self {
    // rust: x: self.x.div_euclid(2),
    // rust: z: self.z.div_euclid(2),
    // rust: level: self.level + 1,
}
}
pub fn children(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::array::from_fn(|i| Self {
    // rust: x: self.x * 2 + (i & 1) as i32,
    // rust: z: self.z * 2 + (i >> 1) as i32,
    // rust: level: self.level - 1,
    // rust: })
}
    /// The squared horizontal distance from `camera` to the tile's nearest point.
pub fn reach(self: *Self, camera: [i32; 2]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, _, z] = self.origin();
    // rust: let gap = |c: i32, lo: i32| i64::from((lo - c).max(c - lo - self.size()).max(0));
    // rust: gap(camera[0], x).pow(2) + gap(camera[1], z).pow(2)
}
    /// Whether the tile covers any of the blocks `[x0, z0, x1, z1)`.
pub fn overlaps(self: *Self, z1]: [i32; 4]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [ox, _, oz] = self.origin();
    // rust: let size = self.size();
    // rust: ox < x1 && oz < z1 && ox + size > x0 && oz + size > z0
}
    /// Whether new data for `area` drawn in cells `widths` wide changes the
    /// tile's samples: its cells are that wide, and it covers `area` or the
    /// blocks around it a cell's depth reads (`bluemap::SKIRT`: a block
    /// around a chunk, the next cells' middles past one).
pub fn refreshed_by(self: *Self, area: [i32; 4], widths: (i32) void {
}
    // rust: let cell = self.size() / CELLS as i32;
    // rust: (widths.0..=widths.1).contains(&cell) && self.overlaps(Self::around(area, cell))
}
pub fn around(z1]: [i32; 4], cell: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let m = if cell <= 16 { 1 } else { cell };
    // rust: [x0 - m, z0 - m, x1 + m, z1 + m]
}
pub fn distance(self: *Self, camera: [i32; 2]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, _, z] = self.origin();
    // rust: (x - camera[0])
    // rust: .max(camera[0] - x - self.size())
    // rust: .max(z - camera[1])
    // rust: .max(camera[1] - z - self.size())
    // rust: .max(0)
}
}
pub const Plan = struct {
    roots: std.ArrayList(TileKey),
    nodes: FxHashSet<TileKey>,
    split: FxHashSet<TileKey>,
    /// `nodes` by level: children (level - 1) come before their parents when
    /// selection is rebuilt, without sorting the whole set.
    by_level: [std.ArrayList(TileKey),
    elevation: i32,
    camera: [i32,
    /// The squared distance within which no coarser tile stands in for
    /// missing detail (`stands_in`): the seam with the near chunks waits
    /// for its own tiles instead of showing broad boxes beside them.
    near: i64,
    /// The squared distance within which planned tiles load before the
    /// coarse backdrop (`wanted_tiles`).
    first: i64,
    /// Where a zoomed view asks for finer tiles, if it does ([`ZoomAim`]).
    aim: ?ZoomAim,
};
/// Chunks past the render distance where only planned tiles are drawn (two
/// past the last near chunk, `streaming::in_view_distance`), and where they
/// load first.
pub const SEAM_CHUNKS: i32 = 3;
pub const FIRST_CHUNKS: i32 = 4;
    // rust: impl Plan {
pub fn new(camera: [i32; 2], detail: i32, distance: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_previous(camera, detail, distance, &Self::default(), 0, false, None)
}
    /// `reduced`: Reduced far detail (`graphics::FarDetail`), each level from
    /// half the distance.
    // rust: fn with_previous(
    // rust: camera: [i32; 2],
    // rust: detail: i32,
    // rust: distance: u32,
    // rust: previous: &Self,
    // rust: elevation: i32,
    // rust: reduced: bool,
    // rust: aim: Option<ZoomAim>,
    // rust: ) -> Self {
    // rust: let range = distance.min(MAX_CHUNKS) as i32 * 16;
    // rust: let mut level = 0;
    // rust: while (16 << level) < range {
    // rust: level += 1;
}
    // rust: let size = 16 << level;
    // rust: let mut result = Self {
    // rust: elevation,
    // rust: camera,
    // rust: near: i64::from((detail + SEAM_CHUNKS) * 16).pow(2),
    // rust: first: i64::from((detail + FIRST_CHUNKS) * 16).pow(2),
    // rust: aim,
    // rust: ..Self::default()
}
    // rust: for z in (camera[1] - range).div_euclid(size)..=(camera[1] + range).div_euclid(size) {
    // rust: for x in (camera[0] - range).div_euclid(size)..=(camera[0] + range).div_euclid(size) {
    // rust: let key = TileKey { x, z, level };
    // rust: result.roots.push(key);
    // rust: result.visit(key, camera, detail, range, previous, reduced);
}
}
    // rust: result
}
    // rust: fn visit(
    // rust: &mut self,
    // rust: key: TileKey,
    // rust: camera: [i32; 2],
    // rust: detail: i32,
    // rust: range: i32,
    // rust: previous: &Self,
    // rust: reduced: bool,
    // rust: ) {
        // The range is a circle, as the renderer's: a tile leaves it, and
        // fades out (gfx/lod.rs), as the player moves.
    // rust: if key.reach(camera) > i64::from(range) * i64::from(range) {
    // rust: return;
}
    // rust: if self.nodes.insert(key) {
    // rust: self.by_level[key.level as usize].push(key);
}
        // Keep distant cells small on screen; finest tiles retain individual
        // blocks. Reduced keeps them twice as large (a quarter of the cells).
    // rust: let held = previous.split.contains(&key);
    // rust: let split = if held { 10 } else { 8 };
        // Beyond the old 1024-chunk limit the cells are as large as `reduced`'s:
        // the whole world is 22 levels, not all of them worth full cells.
    // rust: let world = key.distance(camera) >= WORLD_START;
        // A zoomed view magnifies the tiles its cone covers, so those split
        // further; every other tile keeps the plan it would have had
        // ([`ZoomAim`]). The world-wide threshold is boosted too: the horizon is
        // where a spyglass shows the coarsest cells of all.
    // rust: let boost = match self.aim {
    // rust: Some(aim) if aim.covers(key, camera) => i64::from(aim.boost),
    // rust: _ => 1,
}
    // rust: let threshold = i64::from(key.size())
    // rust: * i64::from(if world {
    // rust: WORLD_SPLIT
    // rust: } else if reduced {
    // rust: split / 2
    // rust: } else {
    // rust: split
    // rust: })
    // rust: * boost;
        // The 8 to 10 band above is wide already. The ring of full detail
        // around the camera and the world-wide threshold have none: a tile
        // split last plan stays split until it is 5% past them, or it
        // flickered between two levels as the camera moved a block to and
        // fro across the line.
    // rust: let hold = |bound: i64| {
    // rust: if held {
    // rust: bound * RETURN.0 / RETURN.1
    // rust: } else {
    // rust: bound
}
}
    // rust: let distance = i64::from(key.distance(camera));
    // rust: if key.level > 0
    // rust: && (distance < hold(i64::from(detail) * 16 + 16)
    // rust: || distance.max(i64::from(self.elevation))
    // rust: < if world { hold(threshold) } else { threshold })
    // rust: {
    // rust: self.split.insert(key);
    // rust: for child in key.children() {
    // rust: self.visit(child, camera, detail, range, previous, reduced);
}
}
}
    // rust: fn select(
    // rust: &self,
    // rust: key: TileKey,
    // rust: ready: &FxHashMap<TileKey, impl Sized>,
    // rust: out: &mut Vec<TileKey>,
    // rust: ) -> bool {
    // rust: if !self.nodes.contains(&key) {
    // rust: return true;
}
    // rust: if self.split.contains(&key) {
            // Visit every child: a missing sibling must not hide ready detail.
    // rust: let complete = key
    // rust: .children()
    // rust: .into_iter()
    // rust: .map(|child| self.select(child, ready, out))
    // rust: .fold(true, |complete, child| complete & child);
    // rust: if complete {
    // rust: return true;
}
    // rust: if ready.contains_key(&key) && self.stands_in(key) {
                // Its mesh is clipped around every selected finer tile.
    // rust: out.push(key);
    // rust: return true;
}
    // rust: false
    // rust: } else if ready.contains_key(&key) {
    // rust: out.push(key);
    // rust: true
    // rust: } else {
    // rust: false
}
}
    /// Whether a split tile may draw for its missing children: only away
    /// from the near chunks, where its cells are small on screen.
pub fn stands_in(self: *Self, key: TileKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: key.reach(self.camera) >= self.near
}
    /// The coarse tile sampled to cover `leaf` while it loads: two levels
    /// up (16 times fewer tiles, each as cheap as a leaf to sample), one
    /// where that would reach the seam, none beside it.
pub fn backdrop(self: *Self, leaf: TileKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut backdrop = None;
    // rust: let mut key = leaf;
    // rust: for _ in 0..2 {
    // rust: key = key.parent();
    // rust: if !self.nodes.contains(&key) || !self.stands_in(key) {
    // rust: break;
}
    // rust: backdrop = Some(key);
}
    // rust: backdrop
}
    /// Whether chunk column (x, z) is drawn by the tile planned there (ready;
    /// at level 0, also `filled`) rather than by a coarser ancestor standing
    /// in for it, or is past the far terrain.
    // rust: fn replaces(
    // rust: &self,
    // rust: (x, z): (i32, i32),
    // rust: ready: &FxHashMap<TileKey, impl Sized>,
    // rust: filled: impl Fn(TileKey) -> bool,
    // rust: ) -> bool {
    // rust: let Some(key) = (0..=MAX_LEVEL)
    // rust: .map(|level| TileKey {
    // rust: x: (x * 16).div_euclid(16 << level),
    // rust: z: (z * 16).div_euclid(16 << level),
    // rust: level,
    // rust: })
    // rust: .find(|key| self.nodes.contains(key))
    // rust: else {
    // rust: return true;
}
        // A split node's child there is out of range: nothing is drawn.
    // rust: self.split.contains(&key) || (ready.contains_key(&key) && (key.level > 0 || filled(key)))
}
}
/// The tiles to sample, `Wanted`'s order best first. First the planned
/// tiles at the seam with the near chunks, nearest first: coarse tiles
/// there cost a far tile's work for broad boxes that fine tiles replace
/// moments later. Then a coarse backdrop (`Plan::backdrop`) out to the
/// horizon, then every other planned tile nearest first, each replacing its
/// part of the backdrop: the horizon fills in early and sharpens from the
/// player outward, whichever way they look.
/// A tile `ready` and `stale` (`Lod::refresh`) is wanted again, its old
/// samples drawn meanwhile: it needs no backdrop.
    // rust: fn wanted_tiles(
    // rust: plan: &Plan,
    // rust: ready: &FxHashMap<TileKey, impl Sized>,
    // rust: stale: &FxHashSet<TileKey>,
    // rust: camera: [i32; 2],
    // rust: ) -> impl Iterator<Item = Wanted> {
    // rust: let sampled = |key: &TileKey| ready.contains_key(key) && !stale.contains(key);
    // rust: let wanted = |class, key: TileKey| Wanted {
    // rust: class,
    // rust: distance: i64::from(key.distance(camera)),
    // rust: x: key.x,
    // rust: z: key.z,
    // rust: level: key.level,
}
    // rust: let mut backdrop = FxHashSet::default();
    // rust: let mut tiles: Vec<_> = plan
    // rust: .nodes
    // rust: .iter()
    // rust: .filter(|key| !plan.split.contains(key) && !sampled(key))
    // rust: .map(|&key| {
    // rust: if !ready.contains_key(&key)
    // rust: && let Some(coarse) = plan.backdrop(key)
    // rust: && !sampled(&coarse)
    // rust: {
    // rust: backdrop.insert(coarse);
}
    // rust: let first = key.reach(camera) < plan.first;
    // rust: wanted(if first { SEAM } else { REST }, key)
    // rust: })
    // rust: .collect();
    // rust: tiles.extend(backdrop.into_iter().map(|key| wanted(BACKDROP, key)));
    // rust: tiles.into_iter()
}
/// `Wanted::class`es, best first.
pub const SEAM: u8 = 0;
pub const BACKDROP: u8 = 1;
pub const REST: u8 = 2;
/// Visited chunks' summaries (`Lod::saved`) and their reductions.
    // rust: type Saved = FxHashMap<(i32, i32), Arc<[Column; 256]>>;
    // rust: type Reduced = FxHashMap<(i32, i32), Arc<ReducedColumns>>;
/// What a mesh job reads, as it was when the job began: the worker gathers
/// every tile's inputs from it (gathering on the render thread stalled the
/// frame, tens of milliseconds for a large job on a 4-thread machine).
pub const Snapshot = struct {
    samples: FxHashMap<TileKey,
    saved: Saved,
    reduced: Reduced,
    /// The plan's tiles, to tell terrain not drawn yet from terrain out of
    /// range (`Snapshot::planned_leaf`).
    nodes: FxHashSet<TileKey>,
    split: FxHashSet<TileKey>,
};
/// One column of a mesh input, by reference into the snapshot. Mesh jobs used
/// to clone all 256 columns of a tile (each with its own span allocation);
/// now an input is a base tile plus a handful of overrides.
pub const ColumnSource = enum {
    Tile(Arc<Vec<Column>>, u16),
    Saved(Arc<[Column; 256]>, u16),
    Reduced(Arc<ReducedColumns>, u8, u16, u16),
    Empty,
};
    // rust: static EMPTY_COLUMN: Column = Column {
    // rust: surface: None,
    // rust: spans: Spans::new(),
}
    // rust: impl ColumnSource {
pub fn get(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Tile(columns, index) => &columns[*index as usize],
    // rust: Self::Saved(columns, index) => &columns[*index as usize],
    // rust: Self::Reduced(columns, width, x, z) => {
    // rust: columns.get(*x as usize, *z as usize, *width as usize)
}
    // rust: Self::Empty => &EMPTY_COLUMN,
}
}
}
pub const EdgeSource = struct {
    start: i32,
    end: i32,
    column: ColumnSource,
    /// Planned but not drawn yet (`mesh::EdgeColumn::unknown`).
    unknown: bool,
};
pub const MeshInput = struct {
    /// The tile's samples, with `overrides` replacing some of them.
    base: *std.ArrayList(Column),
    overrides: [?ColumnSource,
    neighbors: [std.ArrayList(EdgeSource),
    finer: std.ArrayList(TileKey),
};
pub const ReducedColumns = struct {
    columns: Arc<[Column,
    /// The chunk reduced to cells 2, 4, 8 and 16 blocks wide, each built the
    /// first time a tile of that width asks for it.
    ///
    /// One chunk is covered by one far tile, so one of the four is what gets
    /// read, and a chunk whose detail arrives while full-detail terrain still
    /// draws it reads none. Building all four up front cost 405 us of a far
    /// terrain thread for every chunk the world sent (`Column::reduced` walks
    /// every span of the footprint four times over), and held 85 columns
    /// beside the chunk's 256.
    levels: [std::sync::OnceLock<std.ArrayList(Column)>,
};
    // rust: impl MeshInput {
    /// The column of every cell: the tile's own samples unless the snapshot
    /// has actual visited detail there.
pub fn columns(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut columns: Vec<&Column> = self.base.iter().collect();
    // rust: for (index, source) in self.overrides.iter().enumerate() {
    // rust: if let Some(source) = source {
    // rust: columns[index] = source.get();
}
}
    // rust: columns
}
pub fn edges(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::array::from_fn(|side| {
    // rust: self.neighbors[side]
    // rust: .iter()
    // rust: .map(|edge| mesh::EdgeColumn {
    // rust: start: edge.start,
    // rust: end: edge.end,
    // rust: column: edge.column.get(),
    // rust: unknown: edge.unknown,
    // rust: })
    // rust: .collect()
    // rust: })
}
}
    // rust: impl ReducedColumns {
pub fn new(columns: *[Column; 256]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: columns,
    // rust: levels: std::array::from_fn(|_| std::sync::OnceLock::new()),
}
}
    /// Builds the reduction levels whose bit is set in `levels`
    /// (`Shared::detail_widths`), off the render thread.
pub fn warm(self: *Self, levels: u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for level in 0..self.levels.len() {
    // rust: if levels & (1 << level) != 0 {
    // rust: self.level(level);
}
}
    // rust: self
}
    /// The chunk reduced to cells `2 << level` blocks wide, built once.
pub fn level(self: *Self, level: usize) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let width = 2 << level;
    // rust: self.levels[level].get_or_init(|| {
            // Timed on whichever thread first asks for this width, so the
            // frame profile tells a reduction apart from the column copying
            // around it (`Lod::apply_detail` does both).
    // rust: crate::spans::time("lod_reduce", || {
    // rust: let columns = &self.columns;
    // rust: (0..16 / width)
    // rust: .flat_map(|z| {
    // rust: (0..16 / width)
    // rust: .map(move |x| Column::reduced(columns, x * width, z * width, width))
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: })
}
pub fn get(self: *Self, x: usize, z: usize, width: usize) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if width == 1 {
    // rust: return &self.columns[z * 16 + x];
}
    // rust: let level = width.trailing_zeros() as usize - 1;
    // rust: &self.level(level)[(z / width) * (16 / width) + x / width]
}
}
pub const Job = enum {
    Sample(TileKey),
    /// Summarize the chunk `Shared::observed` holds for this column.
    Observe((i32, i32)),
    RequestDetail {,
    chunks: Vec<(i32, i32)>,
    center: [i32; 2],
        /// `Lod::refreshes` when asked: what was read before a later
        /// `refresh` may be older than what it announced.
    refreshes: u64,
    // rust: },
};
/// A chunk's columns on their way to the tiles over it: what `Lod::receive`
/// defers when a frame's [`DETAIL_BUDGET`] is spent.
pub const Summary = enum {
    /// A chunk's detail, and the `refreshes` of the request it answers.
    Detail((i32, i32), ReducedColumns, u64),
    /// A visited chunk's summary.
    Observed((i32, i32), ReducedColumns),
};
pub const Done = enum {
    /// A chunk's detail, and the `refreshes` of the request it answers.
    Detail((i32, i32), ReducedColumns, u64),
    /// A visited chunk's summary (`Job::Observe`).
    Observed((i32, i32), ReducedColumns),
    DetailRequested,
    Sample {,
    key: TileKey,
    samples: Vec<Column>,
        /// Some of it is still on its way (`LodSampler::waited`).
    waited: bool,
    // rust: },
    Mesh {,
    key: TileKey,
    version: u64,
    mesh: SectionMesh,
    canceled: Arc<AtomicBool>,
    // rust: },
    MeshCanceled {,
    key: TileKey,
    version: u64,
    // rust: },
};
/// One tile's mesh job. Every job of a batch shares one immutable snapshot,
/// so tiles are meshed in parallel without cloning columns or maps.
pub const MeshJob = struct {
    snapshot: *Snapshot,
    key: TileKey,
    version: u64,
    finer: std.ArrayList(TileKey),
    covered: Arc<FxHashSet<(i32,
    bounds: Option<[i32,
    canceled: *AtomicBool,
};
pub const MeshQueued = struct {
    /// Lower is more urgent: near tiles first.
    priority: i64,
    order: u64,
    job: MeshJob,
};
    // rust: impl PartialEq for MeshQueued {
pub fn eq(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.priority == other.priority && self.order == other.order
}
}
    // rust: impl Eq for MeshQueued {}
    // rust: impl PartialOrd for MeshQueued {
pub fn partial_cmp(self: *Self, other: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(self.cmp(other))
}
}
    // rust: impl Ord for MeshQueued {
pub fn cmp(self: *Self, other: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
        // `BinaryHeap` is a max-heap: lower priority values pop first.
    // rust: other
    // rust: .priority
    // rust: .cmp(&self.priority)
    // rust: .then(other.order.cmp(&self.order))
}
}
/// A tile the sampler should produce next: by `class`
/// (`wanted_tiles`), then nearest first.
pub const Wanted = struct {
    class: u8,
    distance: i64,
    x: i32,
    z: i32,
    level: u8,
};
pub const Shared = struct {
    jobs: Mutex<VecDeque<Job>>,
    /// Tile meshes, nearest and most urgent first.
    mesh_jobs: Mutex<std::collections::BinaryHeap<MeshQueued>>,
    /// The latest chunk to summarize per column, queued as `Job::Observe`
    /// once: edits made before the worker gets to it are summarized once.
    observed: Mutex<FxHashMap<(i32,
    /// `state_kinds`, from the first observed chunk's facts.
    kinds: std::sync::OnceLock<std.ArrayList(u8)>,
    wake: Condvar,
    mesh_wake: Condvar,
    stop: AtomicBool,
    /// Reduced far detail: samplers approximate wide cells.
    approximate: AtomicBool,
    /// The reduction levels `Lod::apply_detail` reads, one bit each (level
    /// `i` is a cell `2 << i` blocks wide), so the far terrain thread builds
    /// them before it sends a chunk's columns on.
    ///
    /// Learned rather than derived from the plan: a chunk's ancestors are
    /// read only where they were sampled, which the plan alone does not say.
    /// `apply_detail` sets a bit the first time it reads that width, so the
    /// first chunk of a width still reduces on the render thread and every
    /// chunk after it finds the work done. Bits are never cleared: a width
    /// the view has stopped using costs the worker a reduction nothing
    /// reads, and holding all four is exactly the eager behaviour this
    /// replaces.
    detail_widths: std::sync::atomic::AtomicU8,
    /// On small machines, hold queued far meshing while near terrain loads.
    mesh_held: AtomicBool,
    /// The near terrain is loading: the far threads step behind it
    /// (`horizon_threads::far_terrain_behind`) and come back once it is in.
    near_loading: AtomicBool,
};
/// Puts the calling far terrain thread behind the near terrain while it
/// loads, and back once it is in. `behind`: where the thread is now.
pub fn step_behind(shared: *Shared, behind: *mut bool) void {
}
    // rust: let loading = shared.near_loading.load(Ordering::Relaxed);
    // rust: if loading != *behind {
    // rust: horizon_threads::far_terrain_behind(loading);
    // rust: *behind = loading;
}
}
/// A background worker, sampling and meshing threads, and a bounded queue of
/// sample jobs (`sample_jobs`). Only the current view's quadtree and a
/// bounded set of visited summaries are retained.
pub const Lod = struct {
    shared: *Shared,
    thread: ?thread::JoinHandle<()>,
    mesh_threads: std.ArrayList(thread::JoinHandle<())>,
    results: mpsc::Receiver<Done>,
    context: ?*WorkerContext,
    /// A finished mesh job may have changed the selection of its ancestors.
    reselect: bool,
    area: Option<([i32,
    plan: Plan,
    /// Reduced far detail (`set_reduced_detail`).
    reduced_detail: bool,
    pending: FxHashSet<TileKey>,
    detail_masks: FxHashMap<TileKey,
    detail_request_pending: bool,
    /// Detail and visited summaries past a frame's [`DETAIL_BUDGET`], applied
    /// on the frames after it. Bounded by what the worker sends: a detail
    /// request is one per 250 ms and only for chunks whose detail is missing,
    /// so this drains between bursts rather than growing with the view.
    detail_backlog: std::collections::VecDeque<Summary>,
    /// `refresh`es so far (`Job::RequestDetail`), and the areas of the last
    /// ones, each with its number.
    refreshes: u64,
    refreshed: VecDeque<(u64,
    detail_request_at: std::time::Instant,
    /// Four threads or fewer: far work waits for the near terrain (`hold`).
    small: bool,
    /// Sample jobs that may be queued or running at once.
    sample_jobs: usize,
    /// The near terrain is loading (`set_near_loading`).
    near_loading: bool,
    /// When `request_samples` last started a job while held.
    held_sample_at: std::time::Instant,
    /// Tiles whose sampling failed, and when they may be asked again.
    retry: FxHashMap<TileKey,
    /// Each tile's samples, shared with mesh jobs in flight.
    ready: FxHashMap<TileKey,
    /// Fully covered subtrees, by tile.
    complete: FxHashMap<TileKey,
    /// Sampled tiles whose source has more since (`refresh`): sampled again,
    /// their old samples drawn meanwhile.
    stale: FxHashSet<TileKey>,
    /// Stale tiles `refresh`ed again while sampled: that sample may be older.
    restale: FxHashSet<TileKey>,
    active: FxHashSet<TileKey>,
    /// Tiles needing a mesh, with the revision their job must carry.
    dirty: FxHashMap<TileKey,
    /// The newest revision of each active tile's mesh.
    mesh_version: FxHashMap<TileKey,
    /// The newest revision accepted by the renderer for each active tile.
    /// Older in-flight results can still fill a hole while a newer job waits.
    shown_version: FxHashMap<TileKey,
    /// Cancellation tokens for queued or running jobs of active tiles.
    mesh_cancel: FxHashMap<TileKey,
    next_version: u64,
    /// Mesh jobs queued or running; the cutout waits for all of them.
    outstanding_meshes: usize,
    /// Workers in the mesh pool (dispatch coalesces above four each).
    mesh_workers: usize,
    /// Tiles whose active replacement mesh has been returned and applied.
    meshed: FxHashSet<TileKey>,
    /// Active tiles whose current revision has no mesh yet.
    unmeshed: FxHashSet<TileKey>,
    /// Tiles that left the selection. The renderer may only fade them out
    /// once every active tile overlapping them has its mesh, or a hole opens.
    removed_pending: FxHashSet<TileKey>,
    /// Released removals, returned to the renderer this update.
    removed: std.ArrayList(TileKey),
    /// The columns left out: `full` and `retiring`.
    covered: FxHashSet<(i32,
    covered_bounds: Option<[i32,
    /// The full-detail columns `update` was last given.
    full: FxHashSet<(i32,
    /// Columns that left the full-detail area, still left out (their
    /// full-detail meshes still drawn) until the tile planned there is ready
    /// (`Plan::replaces`). Tiles inside that area are never sampled: when the
    /// render distance shrinks, their coarsest ancestors would otherwise
    /// stand in for it for minutes.
    retiring: FxHashSet<(i32,
    /// The covered columns the active meshes leave out, when a mesh job
    /// has finished since the last `take_cutout`.
    cutout: Option<FxHashSet<(i32,
    /// Covered columns changed while meshes were in flight: the renderer must
    /// not drop full-detail sections before every replacement is uploaded.
    cutout_pending: Option<FxHashSet<(i32,
    /// Active tiles whose mesh must be accepted before the cutout publishes.
    cutout_waiting: FxHashSet<TileKey>,
    /// Unsample final tiles, nearest first. Rebuilt when the view changes,
    /// not scanned every frame.
    wanted: std::collections::BinaryHeap<std::cmp::Reverse<Wanted>>,
    wanted_at: Option<[i32,
    wanted_stale: bool,
    saved: Saved,
    reduced: Reduced,
    saved_order: VecDeque<(i32,
    /// `LodSource::keeps_observed`: tiles sampled without an observed chunk
    /// are sampled again (`resample_over`).
    keeps_observed: bool,
};
    // rust: impl Lod {
pub fn new(source: *dyn LodSource, context: *WorkerContext) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::assemble(Some(source), Some(context), true)
}
    /// Scheduler-only instance for tests: no worker threads, so a test can
    /// pop the jobs it queued and finish samples itself.
pub fn scheduler_for_test() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::assemble(None, None, false)
}
    // rust: fn assemble(
    // rust: source: Option<Arc<dyn LodSource>>,
    // rust: context: Option<Arc<WorkerContext>>,
    // rust: workers: bool,
    // rust: ) -> Self {
    // rust: let keeps_observed = source
    // rust: .as_ref()
    // rust: .is_some_and(|source| source.keeps_observed());
    // rust: let cores = horizon_threads::worker_count();
    // rust: let shared = Arc::new(Shared {
    // rust: jobs: Mutex::new(VecDeque::new()),
    // rust: mesh_jobs: Mutex::new(std::collections::BinaryHeap::new()),
    // rust: observed: Mutex::new(FxHashMap::default()),
    // rust: kinds: std::sync::OnceLock::new(),
    // rust: wake: Condvar::new(),
    // rust: mesh_wake: Condvar::new(),
    // rust: stop: AtomicBool::new(false),
    // rust: approximate: AtomicBool::new(false),
    // rust: detail_widths: std::sync::atomic::AtomicU8::new(0),
    // rust: mesh_held: AtomicBool::new(false),
    // rust: near_loading: AtomicBool::new(false),
    // rust: });
    // rust: let worker = shared.clone();
    // rust: let (tx, results) = mpsc::channel();
    // rust: let lod_context = context.clone();
        // Meshing runs on its own pool: one worker serialized every dirty
        // tile of a batch, however many cores the machine had.
    // rust: let mut mesh_threads = Vec::new();
    // rust: let mut handle = None;
    // rust: if workers {
    // rust: let source = source.expect("workers need a terrain source");
    // rust: for _ in 0..meshing_threads(cores) {
    // rust: let shared = shared.clone();
    // rust: let tx = tx.clone();
    // rust: let context = context.clone().expect("mesh workers need a context");
    // rust: mesh_threads.push(
    // rust: thread::Builder::new()
    // rust: .name("Far meshing".into())
    // rust: .spawn(move || {
    // rust: horizon_threads::far_terrain_current();
    // rust: let mut behind = true;
    // rust: let mut mesher = mesh::Mesher::default();
    // rust: loop {
    // rust: let job = {
    // rust: let mut jobs = shared.mesh_jobs.lock().unwrap();
    // rust: loop {
    // rust: if shared.stop.load(Ordering::Relaxed) {
    // rust: return;
}
    // rust: if shared.mesh_held.load(Ordering::Relaxed) {
    // rust: jobs = shared.mesh_wake.wait(jobs).unwrap();
    // rust: continue;
}
    // rust: if let Some(job) = jobs.pop() {
    // rust: break job.job;
}
    // rust: jobs = shared.mesh_wake.wait(jobs).unwrap();
}
}
    // rust: if job.canceled.load(Ordering::Acquire) {
    // rust: if tx
    // rust: .send(Done::MeshCanceled {
    // rust: key: job.key,
    // rust: version: job.version,
    // rust: })
    // rust: .is_err()
    // rust: {
    // rust: return;
}
    // rust: continue;
}
    // rust: step_behind(&shared, &mut behind);
    // rust: let keep_finer = !job.finer.is_empty();
    // rust: let input = job.snapshot.mesh_input(job.key, job.finer);
    // rust: let columns = input.columns();
    // rust: let edges = input.edges();
    // rust: let mut mesh = mesher.mesh(
    // rust: job.key,
    // rust: &columns,
    // rust: &job.covered,
    // rust: job.bounds,
    // rust: &context,
    // rust: &edges,
    // rust: &input.finer,
    // rust: );
    // rust: mesh.sort_solid();
    // rust: let [ox, _, oz] = job.key.origin();
    // rust: let size = job.key.size();
    // rust: mesh.keep = keep_finer
    // rust: || job.covered.iter().any(|&(cx, cz)| {
    // rust: let x = cx * 16;
    // rust: let z = cz * 16;
    // rust: x < ox + size && x + 16 > ox && z < oz + size && z + 16 > oz
    // rust: });
    // rust: if job.canceled.load(Ordering::Acquire) {
    // rust: if tx
    // rust: .send(Done::MeshCanceled {
    // rust: key: job.key,
    // rust: version: job.version,
    // rust: })
    // rust: .is_err()
    // rust: {
    // rust: return;
}
    // rust: continue;
}
    // rust: if tx
    // rust: .send(Done::Mesh {
    // rust: key: job.key,
    // rust: version: job.version,
    // rust: mesh,
    // rust: canceled: job.canceled,
    // rust: })
    // rust: .is_err()
    // rust: {
    // rust: return;
}
}
    // rust: })
    // rust: .expect("far meshing worker"),
    // rust: );
}
    // rust: handle = Some(
    // rust: thread::Builder::new()
    // rust: .name("Far terrain".into())
    // rust: .spawn(move || {
                        // Ticks and frames come first (horizon_threads).
    // rust: horizon_threads::far_terrain_current();
    // rust: let mut behind = true;
    // rust: let mut sampler = source.sampler();
    // rust: let count = sampling_threads(cores);
    // rust: let mut sampling = Vec::new();
    // rust: for _ in 0..count {
    // rust: let Some(mut sample) = sampler.fork() else {
    // rust: break;
}
    // rust: let shared = worker.clone();
    // rust: let tx = tx.clone();
    // rust: sampling.push(
    // rust: thread::Builder::new()
    // rust: .name("Far sampling".into())
    // rust: .spawn(move || {
    // rust: horizon_threads::far_terrain_current();
    // rust: let mut behind = true;
    // rust: loop {
    // rust: let key = {
    // rust: let mut jobs = shared.jobs.lock().unwrap();
    // rust: loop {
    // rust: if shared.stop.load(Ordering::Relaxed) {
    // rust: return;
}
    // rust: if let Some(index) =
    // rust: jobs.iter().position(|job| {
    // rust: matches!(job, Job::Sample(_))
    // rust: })
    // rust: {
    // rust: let Some(Job::Sample(key)) =
    // rust: jobs.remove(index)
    // rust: else {
    // rust: unreachable!()
}
    // rust: break key;
}
    // rust: jobs = shared.wake.wait(jobs).unwrap();
}
}
    // rust: step_behind(&shared, &mut behind);
    // rust: let [x, _, z] = key.origin();
    // rust: sample.set_approximate(
    // rust: shared.approximate.load(Ordering::Relaxed),
    // rust: );
    // rust: let samples =
    // rust: sample.grid(x, z, key.size() / CELLS as i32, CELLS);
    // rust: if shared.stop.load(Ordering::Relaxed) {
    // rust: return;
}
    // rust: let waited = sample.waited();
    // rust: if tx
    // rust: .send(Done::Sample {
    // rust: key,
    // rust: samples,
    // rust: waited,
    // rust: })
    // rust: .is_err()
    // rust: {
    // rust: return;
}
}
    // rust: })
    // rust: .expect("far sampling worker"),
    // rust: );
}
    // rust: let mut asked = 0;
    // rust: 'work: loop {
    // rust: for (key, columns) in sampler.drain_details() {
    // rust: if tx
    // rust: .send(Done::Detail(
    // rust: key,
    // rust: ReducedColumns::new(columns)
    // rust: .warm(worker.detail_widths.load(Ordering::Relaxed)),
    // rust: asked,
    // rust: ))
    // rust: .is_err()
    // rust: {
    // rust: break 'work;
}
}
    // rust: let job = {
    // rust: let mut jobs = worker.jobs.lock().unwrap();
    // rust: if (jobs.is_empty()
    // rust: || (!sampling.is_empty()
    // rust: && jobs.iter().all(|job| matches!(job, Job::Sample(_)))))
    // rust: && !worker.stop.load(Ordering::Relaxed)
    // rust: {
    // rust: jobs = worker
    // rust: .wake
    // rust: .wait_timeout(jobs, std::time::Duration::from_millis(100))
    // rust: .unwrap()
    // rust: .0;
}
    // rust: if worker.stop.load(Ordering::Relaxed) {
    // rust: break;
}
                                // Summaries and detail requests first: they
                                // would otherwise wait behind a whole queue of
                                // samples where no sampling threads take them.
    // rust: let other =
    // rust: jobs.iter().position(|job| !matches!(job, Job::Sample(_)));
    // rust: if let Some(index) = other {
    // rust: jobs.remove(index)
    // rust: } else if sampling.is_empty() {
    // rust: jobs.pop_front()
    // rust: } else {
    // rust: None
}
}
    // rust: let Some(job) = job else { continue };
    // rust: step_behind(&worker, &mut behind);
    // rust: let done = match job {
    // rust: Job::Observe(key) => {
    // rust: let chunk = worker.observed.lock().unwrap().remove(&key);
    // rust: let (Some(chunk), Some(kinds)) = (chunk, worker.kinds.get())
    // rust: else {
    // rust: continue;
}
    // rust: let columns = summarize(&chunk, kinds);
    // rust: sampler.observed(key, &columns);
    // rust: Done::Observed(
    // rust: key,
    // rust: ReducedColumns::new(columns)
    // rust: .warm(worker.detail_widths.load(Ordering::Relaxed)),
    // rust: )
}
    // rust: Job::RequestDetail {
    // rust: chunks,
    // rust: center,
    // rust: refreshes,
    // rust: } => {
    // rust: asked = refreshes;
    // rust: sampler.request_detail(&chunks, center);
    // rust: Done::DetailRequested
}
    // rust: Job::Sample(key) => {
    // rust: let [x, _, z] = key.origin();
    // rust: sampler.set_approximate(
    // rust: worker.approximate.load(Ordering::Relaxed),
    // rust: );
    // rust: let samples =
    // rust: sampler.grid(x, z, key.size() / CELLS as i32, CELLS);
    // rust: let waited = sampler.waited();
    // rust: Done::Sample {
    // rust: key,
    // rust: samples,
    // rust: waited,
}
}
}
    // rust: if tx.send(done).is_err() {
    // rust: break;
}
}
    // rust: let jobs = worker.jobs.lock();
    // rust: worker.stop.store(true, Ordering::Relaxed);
    // rust: drop(jobs);
    // rust: worker.wake.notify_all();
    // rust: for handle in sampling {
    // rust: let _ = handle.join();
}
    // rust: })
    // rust: .expect("far terrain worker"),
    // rust: );
}

    // rust: Self {
    // rust: shared,
    // rust: thread: handle,
    // rust: mesh_threads,
    // rust: results,
    // rust: context: lod_context,
    // rust: reselect: true,
    // rust: area: None,
    // rust: reduced_detail: false,
    // rust: plan: Plan::default(),
    // rust: pending: FxHashSet::default(),
    // rust: detail_masks: FxHashMap::default(),
    // rust: detail_request_pending: false,
    // rust: detail_backlog: std::collections::VecDeque::new(),
    // rust: refreshes: 0,
    // rust: refreshed: VecDeque::new(),
    // rust: detail_request_at: std::time::Instant::now(),
    // rust: small: cores <= 4,
    // rust: sample_jobs: sampling_threads(cores) * QUEUED_PER_SAMPLER,
    // rust: near_loading: false,
    // rust: held_sample_at: std::time::Instant::now(),
    // rust: retry: FxHashMap::default(),
    // rust: ready: FxHashMap::default(),
    // rust: complete: FxHashMap::default(),
    // rust: active: FxHashSet::default(),
    // rust: dirty: FxHashMap::default(),
    // rust: mesh_version: FxHashMap::default(),
    // rust: shown_version: FxHashMap::default(),
    // rust: mesh_cancel: FxHashMap::default(),
    // rust: next_version: 1,
    // rust: outstanding_meshes: 0,
    // rust: mesh_workers: meshing_threads(cores),
    // rust: meshed: FxHashSet::default(),
    // rust: unmeshed: FxHashSet::default(),
    // rust: removed_pending: FxHashSet::default(),
    // rust: stale: FxHashSet::default(),
    // rust: restale: FxHashSet::default(),
    // rust: removed: Vec::new(),
    // rust: covered: FxHashSet::default(),
    // rust: covered_bounds: None,
    // rust: full: FxHashSet::default(),
    // rust: retiring: FxHashSet::default(),
    // rust: cutout: None,
    // rust: cutout_pending: None,
    // rust: cutout_waiting: FxHashSet::default(),
    // rust: wanted: std::collections::BinaryHeap::new(),
    // rust: wanted_at: None,
    // rust: wanted_stale: true,
    // rust: saved: FxHashMap::default(),
    // rust: reduced: FxHashMap::default(),
    // rust: saved_order: VecDeque::new(),
    // rust: keeps_observed,
}
}
    /// The solid ground at block column (x, z): its top face's height and
    /// its block, from the finest tile sampled there. For aiming past the
    /// resident chunks (`game.raycast`); water is passed, as the view's ray
    /// passes it.
pub fn ground(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..=MAX_LEVEL).find_map(|level| {
    // rust: let size = 16 << level;
    // rust: let key = TileKey {
    // rust: x: x.div_euclid(size),
    // rust: z: z.div_euclid(size),
    // rust: level,
}
    // rust: let columns = self.ready.get(&key).filter(|c| c.len() == CELLS * CELLS)?;
    // rust: let cell = size / CELLS as i32;
    // rust: let (cx, cz) = ((x - key.x * size) / cell, (z - key.z * size) / cell);
    // rust: let surface = columns[cz as usize * CELLS + cx as usize].surface?;
    // rust: Some((surface.height, surface.state))
    // rust: })
}
pub fn stats(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.active.len(), self.ready.len())
}
pub fn progress(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut desired = 0;
    // rust: let mut sampled = 0;
    // rust: for key in &self.plan.nodes {
    // rust: if !self.plan.split.contains(key) {
    // rust: desired += 1;
    // rust: sampled += usize::from(self.ready.contains_key(key));
}
}
    // rust: (desired, sampled)
}
    /// Drawn columns that take their chunk's generated detail (trees,
    /// structures; `request_detail`), and how many of them have it.
    /// `refined_samples` counts the detail of every drawn tile instead.
pub fn detail_progress(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.active
    // rust: .iter()
    // rust: .filter(|key| self.wants_detail(key))
    // rust: .fold((0, 0), |(wanted, refined), key| {
    // rust: let mask = self.detail_masks.get(key).map_or(0, detail_count);
    // rust: (wanted + CELLS * CELLS, refined + mask)
    // rust: })
}
pub fn refined_samples(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.active
    // rust: .iter()
    // rust: .filter_map(|key| self.detail_masks.get(key))
    // rust: .map(detail_count)
    // rust: .sum()
}
    /// An active tile whose columns take generated chunks' detail.
pub fn wants_detail(self: *Self, key: *TileKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: key.level <= DETAIL_LEVEL
    // rust: && !self.plan.split.contains(key)
    // rust: && !(key.level == 0 && self.covered.contains(&(key.x, key.z)))
}
pub fn removed(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.removed)
}
    /// The full-detail columns the active meshes leave out, once per finished
    /// mesh job. Until a column leaves this set, nothing distant stands in for
    /// it: its full-detail terrain must still be drawn, in or past the render
    /// distance, or a hole opens there.
pub fn take_cutout(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.cutout.take()
}
    /// Marks an active tile for remeshing. Versioned so a result from an
    /// older batch can never overwrite a newer one.
pub fn cancel_mesh(self: *Self, key: TileKey) void {
}
    // rust: if let Some(token) = self.mesh_cancel.remove(&key) {
    // rust: token.store(true, Ordering::Release);
    // rust: self.shared.mesh_wake.notify_all();
}
}
pub fn mark_mesh(self: *Self, key: TileKey) void {
}
    // rust: if !self.active.contains(&key) {
    // rust: return;
}
    // rust: let version = self.next_version;
    // rust: self.next_version += 1;
    // rust: self.dirty.insert(key, version);
    // rust: self.mesh_version.insert(key, version);
    // rust: self.meshed.remove(&key);
    // rust: self.unmeshed.insert(key);
}
    /// The tile's selection changed: its own mesh, every selected fallback
    /// ancestor that clips around its footprint, and its face neighbours.
pub fn mark_selection_changed(self: *Self, key: TileKey) void {
}
    // rust: self.mark_mesh(key);
        // A fallback ancestor's mesh is clipped around this tile.
    // rust: let mut node = key;
    // rust: while node.level < MAX_LEVEL {
    // rust: node = node.parent();
    // rust: if self.active.contains(&node) {
    // rust: self.mark_mesh(node);
}
}
    // rust: self.mark_side_neighbors_of(key);
    // rust: self.mark_active_descendants(key);
}
    /// The tile's columns changed but its footprint did not. A fallback
    /// ancestor clips around footprints, not column values, so only the tile
    /// and the neighbours whose edge columns read it need remeshing.
pub fn mark_data_changed(self: *Self, key: TileKey) void {
}
    // rust: self.mark_mesh(key);
    // rust: self.mark_side_neighbors_of(key);
    // rust: if self.active.contains(&key) {
    // rust: self.mark_active_descendants(key);
}
}
    /// An active descendant's edge columns can resolve to this tile when the
    /// finer tile it faces is not selected; its mesh must follow this one.
pub fn mark_active_descendants(self: *Self, key: TileKey) void {
}
    // rust: if !self.plan.split.contains(&key) {
    // rust: return;
}
    // rust: for child in key.children() {
    // rust: if !self.plan.nodes.contains(&child) {
    // rust: continue;
}
    // rust: if self.active.contains(&child) {
    // rust: self.mark_mesh(child);
}
    // rust: self.mark_active_descendants(child);
}
}
    /// Neighbours only along the sides this footprint touches: a large
    /// changed tile otherwise marks the whole world.
pub fn mark_side_neighbors_of(self: *Self, key: TileKey) void {
}
    // rust: let [kx, _, kz] = key.origin();
    // rust: let size = key.size();
    // rust: let mut node = key;
    // rust: loop {
    // rust: let [nx, _, nz] = node.origin();
    // rust: let extent = node.size();
    // rust: if kx == nx {
    // rust: self.mark_side_neighbors(node, 0, key);
}
    // rust: if kx + size == nx + extent {
    // rust: self.mark_side_neighbors(node, 1, key);
}
    // rust: if kz == nz {
    // rust: self.mark_side_neighbors(node, 2, key);
}
    // rust: if kz + size == nz + extent {
    // rust: self.mark_side_neighbors(node, 3, key);
}
    // rust: if node.level == MAX_LEVEL {
    // rust: break;
}
    // rust: node = node.parent();
}
}
    /// The interval a tile covers along the edge of `side` (west/east run
    /// along z, north/south along x).
pub fn side_interval(key: TileKey, side: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, _, z] = key.origin();
    // rust: if side < 2 {
    // rust: (z, z + key.size())
    // rust: } else {
    // rust: (x, x + key.size())
}
}
pub fn side_overlaps(candidate: TileKey, side: usize, changed: TileKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (c0, c1) = Self::side_interval(candidate, side);
    // rust: let (k0, k1) = Self::side_interval(changed, side);
    // rust: c0 < k1 && k0 < c1
}
    /// Whether `child` sits on the face of `parent` shared with the tile the
    /// walk came from. Children behind that face are not adjacent to it.
pub fn side_flush(child: TileKey, side: usize, parent: TileKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (cs, ps) = (child.size(), parent.size());
    // rust: match side {
    // rust: 0 => (child.x + 1) * cs == (parent.x + 1) * ps,
    // rust: 1 => child.x * cs == parent.x * ps,
    // rust: 2 => (child.z + 1) * cs == (parent.z + 1) * ps,
    // rust: _ => child.z * cs == parent.z * ps,
}
}
    /// The selected tiles across one side of `node`, descending only through
    /// split neighbours that face the changed footprint.
pub fn mark_side_neighbors(self: *Self, node: TileKey, side: usize, changed: TileKey) void {
}
    // rust: let (dx, dz) = match side {
    // rust: 0 => (-1, 0),
    // rust: 1 => (1, 0),
    // rust: 2 => (0, -1),
    // rust: _ => (0, 1),
}
    // rust: let neighbor = TileKey {
    // rust: x: node.x + dx,
    // rust: z: node.z + dz,
    // rust: level: node.level,
}
    // rust: self.mark_neighbor_tree(neighbor, side, changed);
}
pub fn mark_neighbor_tree(self: *Self, neighbor: TileKey, side: usize, changed: TileKey) void {
}
    // rust: if !self.plan.nodes.contains(&neighbor) {
    // rust: return;
}
    // rust: if self.active.contains(&neighbor) {
    // rust: self.mark_mesh(neighbor);
}
    // rust: if self.plan.split.contains(&neighbor) {
    // rust: for child in neighbor.children() {
    // rust: if Self::side_flush(child, side, neighbor)
    // rust: && Self::side_overlaps(child, side, changed)
    // rust: {
    // rust: self.mark_neighbor_tree(child, side, changed);
}
}
}
}
    /// `Plan::select` as a cached state: a node is complete when its ready
    /// subtree can stand alone, and active when its own mesh is drawn.
pub fn evaluate(self: *Self, key: TileKey) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let present = self.ready.contains_key(&key);
        // Covered level-0 stand-ins complete their parent but are never drawn.
    // rust: let ready = present && !(key.level == 0 && self.covered.contains(&(key.x, key.z)));
        // Mirrors `Plan::select`: a ready split tile away from the seam is a
        // complete stand-in even while its children are still incomplete,
        // so no second fallback is drawn above it.
    // rust: let (complete, active) = if self.plan.split.contains(&key) {
    // rust: let children = key.children().into_iter().all(|child| {
    // rust: !self.plan.nodes.contains(&child)
    // rust: || self.complete.get(&child).copied().unwrap_or(false)
    // rust: });
    // rust: let ready = ready && self.plan.stands_in(key);
    // rust: (children || ready, ready && !children)
    // rust: } else {
    // rust: (present, ready)
}
    // rust: (complete, active)
}
    /// Re-evaluates `key` and its ancestors after its readiness or coverage
    /// changed. Work is O(tree depth), not O(plan), per finished sample.
pub fn refresh_path(self: *Self, key: TileKey) void {
}
    // rust: let mut node = key;
    // rust: loop {
    // rust: if !self.plan.nodes.contains(&node) {
    // rust: break;
}
    // rust: let (complete, active) = self.evaluate(node);
    // rust: let old = self.complete.insert(node, complete);
    // rust: let was_active = self.active.contains(&node);
    // rust: if active != was_active {
    // rust: if active {
    // rust: self.active.insert(node);
    // rust: self.removed_pending.remove(&node);
    // rust: } else {
    // rust: self.active.remove(&node);
    // rust: self.removed_pending.insert(node);
    // rust: self.cancel_mesh(node);
    // rust: self.mesh_version.remove(&node);
    // rust: self.shown_version.remove(&node);
    // rust: self.meshed.remove(&node);
    // rust: self.unmeshed.remove(&node);
    // rust: self.dirty.remove(&node);
    // rust: self.transfer_cutout_wait(node);
}
}
            // A pure completion change on an undrawn node changes no mesh;
            // only the ancestors' own transitions can. Marking descendants
            // here made tree completion remesh the whole view.
    // rust: if active != was_active {
    // rust: self.mark_selection_changed(node);
}
    // rust: if old == Some(complete) || node.level >= MAX_LEVEL {
    // rust: break;
}
    // rust: node = node.parent();
}
}
    /// New or replaced samples for `key`. `existed`: its old data was drawn,
    /// so the tile and its edge neighbours must be remeshed; a new tile is
    /// already dirty through its selection change.
pub fn refresh_ready(self: *Self, key: TileKey, existed: bool) void {
}
    // rust: self.refresh_path(key);
    // rust: if existed {
    // rust: self.mark_data_changed(key);
}
}
pub fn invalidate_chunk(self: *Self, x: i32, z: i32) void {
}
        // The tiles touching the chunk: a few per level, not every active one.
    // rust: for level in 0..=MAX_LEVEL {
    // rust: let size = 16 << level;
    // rust: for kz in (z * 16).div_euclid(size) - 1..=((z + 1) * 16).div_euclid(size) {
    // rust: for kx in (x * 16).div_euclid(size) - 1..=((x + 1) * 16).div_euclid(size) {
    // rust: let key = TileKey {
    // rust: x: kx,
    // rust: z: kz,
    // rust: level,
}
    // rust: let [ox, _, oz] = key.origin();
    // rust: if x * 16 <= ox + size
    // rust: && (x + 1) * 16 >= ox
    // rust: && z * 16 <= oz + size
    // rust: && (z + 1) * 16 >= oz
    // rust: && self.active.contains(&key)
    // rust: {
    // rust: self.mark_mesh(key);
}
}
}
}
}
    /// The source has new data for the blocks `[x0, z0, x1, z1)` (a map tile
    /// downloaded since), drawn in cells `widths` `(min, max)` blocks wide:
    /// the tiles of those cells over them or beside (`refreshed_by`) are
    /// sampled again, and their chunks' detail asked again, but for the
    /// chunks seen in the world. A tile whose new samples are the old ones
    /// isn't meshed again.
pub fn refresh(self: *Self, area: [i32; 4], widths: (i32) void {
}
    // rust: self.refreshes += 1;
    // rust: if self.refreshed.len() >= MAX_REFRESHED {
    // rust: self.refreshed.pop_front();
}
        // Detail is of cells up to a chunk wide, which read a block around:
        // a chunk around is plenty.
    // rust: let m = 16;
    // rust: let [x0, z0, x1, z1] = area;
    // rust: self.refreshed.push_back((
    // rust: self.refreshes,
    // rust: [
    // rust: x0.saturating_sub(m),
    // rust: z0.saturating_sub(m),
    // rust: x1.saturating_add(m),
    // rust: z1.saturating_add(m),
    // rust: ],
    // rust: ));
        // Tiles waiting out a retry (`finish_waited`) are asked again now.
    // rust: let retrying = self.retry.len();
    // rust: self.retry.retain(|key, _| !key.refreshed_by(area, widths));
    // rust: if self.retry.len() != retrying {
    // rust: self.wanted_stale = true;
}
        // A first sample in flight read the old data too.
    // rust: let keys: Vec<_> = self
    // rust: .ready
    // rust: .keys()
    // rust: .chain(self.pending.iter())
    // rust: .copied()
    // rust: .filter(|key| {
    // rust: key.refreshed_by(area, widths)
    // rust: && !(key.level == 0 && self.covered.contains(&(key.x, key.z)))
    // rust: })
    // rust: .collect();
    // rust: for key in keys {
    // rust: self.mark_stale(key);
    // rust: if let Some(mask) = self.detail_masks.get_mut(&key) {
    // rust: let area = TileKey::around(area, key.size() / CELLS as i32);
    // rust: forget_detail(key, area, mask, |chunk| self.saved.contains_key(&chunk));
}
}
}
    /// Whether chunk `(cx, cz)` was under a `refresh` after request `asked`
    /// (or one too old to tell).
pub fn refreshed_since(self: *Self) void {
}
    // rust: if asked >= self.refreshes {
    // rust: return false;
}
    // rust: let oldest = self.refreshed.front().map_or(u64::MAX, |&(n, _)| n);
    // rust: asked + 1 < oldest
    // rust: || self.refreshed.iter().any(|&(n, [x0, z0, x1, z1])| {
    // rust: n > asked
    // rust: && cx * 16 < x1
    // rust: && (cx + 1) * 16 > x0
    // rust: && cz * 16 < z1
    // rust: && (cz + 1) * 16 > z0
    // rust: })
}
    /// The tile's samples lack data its source has now: sampled again, the
    /// old ones drawn meanwhile, and once more after a sample in flight.
pub fn mark_stale(self: *Self, key: TileKey) void {
}
    // rust: self.stale.insert(key);
    // rust: self.wanted_stale = true;
    // rust: if self.pending.contains(&key) {
    // rust: self.restale.insert(key);
}
}
    /// Capture actual block columns, including canopy gaps and material
    /// layers: the worker summarizes the chunk (`summarize`, a few
    /// milliseconds a chunk), then `finish_observed` keeps it.
pub fn observe(self: *Self, chunk: *Chunk, facts: *BlockFacts) void {
}
    // rust: self.shared.kinds.get_or_init(|| state_kinds(facts));
    // rust: let key = (chunk.x, chunk.z);
    // rust: if self
    // rust: .shared
    // rust: .observed
    // rust: .lock()
    // rust: .unwrap()
    // rust: .insert(key, chunk)
    // rust: .is_none()
    // rust: {
    // rust: self.shared
    // rust: .jobs
    // rust: .lock()
    // rust: .unwrap()
    // rust: .push_back(Job::Observe(key));
    // rust: self.shared.wake.notify_all();
}
}
    /// Chunks waiting for the worker to summarize them. A resident chunk
    /// held here is copied by its next edit (`Arc::make_mut`), so callers
    /// hand over a few at a time (`OBSERVE_AHEAD`).
pub fn observing(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shared.observed.lock().unwrap().len()
}
    /// Whether tiles new to the plan are being sampled: far terrain on its way,
    /// meshed as soon as it is.
pub fn sampling(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.pending.is_empty()
}
    /// Keeps a visited chunk's summary, unless it is unchanged.
pub fn finish_observed(self: *Self, key: (i32) void {
}
    // rust: if self
    // rust: .saved
    // rust: .get(&key)
    // rust: .is_some_and(|saved| **saved == *columns.columns)
    // rust: {
    // rust: return;
}
    // rust: if !self.saved.contains_key(&key) {
    // rust: while self.saved.len() >= MAX_SAVED {
    // rust: if let Some(old) = self.saved_order.pop_front() {
    // rust: self.saved.remove(&old);
    // rust: self.reduced.remove(&old);
}
}
    // rust: self.saved_order.push_back(key);
}
    // rust: self.saved.insert(key, columns.columns.clone());
    // rust: if self.keeps_observed {
    // rust: self.resample_over(key);
}
    // rust: self.finish_detail(key, columns);
}
    /// The source keeps the chunk now: the tiles over it whose samples lack
    /// it are sampled again (`stale`), their old samples drawn meanwhile.
pub fn resample_over(self: *Self, chunk: (i32) void {
}
    // rust: for key in resampled_over(&self.ready, &self.pending, chunk) {
    // rust: self.mark_stale(key);
}
}
    /// A chunk's own columns as its level-0 tile; the same columns again
    /// (asked again after a `refresh`) mesh nothing.
pub fn apply_fine(self: *Self) void {
}
    // rust: let fine = TileKey {
    // rust: x: cx,
    // rust: z: cz,
    // rust: level: 0,
}
    // rust: if !self.plan.nodes.contains(&fine) && !self.ready.contains_key(&fine) {
    // rust: return;
}
    // rust: self.detail_masks.insert(fine, [u64::MAX; 4]);
    // rust: if self
    // rust: .ready
    // rust: .get(&fine)
    // rust: .is_some_and(|old| old[..] == columns[..])
    // rust: {
    // rust: return;
}
    // rust: let existed = self
    // rust: .ready
    // rust: .insert(fine, Arc::new(columns.to_vec()))
    // rust: .is_some();
    // rust: self.refresh_ready(fine, existed);
}
pub fn apply_detail(self: *Self) void {
}
    // rust: self.apply_fine((cx, cz), &columns.columns);
    // rust: let mut modified = Vec::new();
        // A single generated chunk cannot describe a larger cell's area
        // (strides over 16 blocks, levels over 4); at each level up to that,
        // only the tile holding the chunk overlaps it.
    // rust: for level in 0..=4u8 {
    // rust: let size = 16 << level;
    // rust: let key = TileKey {
    // rust: x: (cx * 16).div_euclid(size),
    // rust: z: (cz * 16).div_euclid(size),
    // rust: level,
}
    // rust: let Some(samples) = self.ready.get_mut(&key) else {
    // rust: continue;
}
    // rust: let [ox, _, oz] = key.origin();
    // rust: let stride = key.size() / 16;
            // What the far terrain thread should have ready next time.
    // rust: if stride > 1 {
    // rust: self.shared
    // rust: .detail_widths
    // rust: .fetch_or(1 << (stride.trailing_zeros() - 1), Ordering::Relaxed);
}
    // rust: let x0 = ((cx * 16 - ox + stride - 1).div_euclid(stride)).clamp(0, 16);
    // rust: let x1 = (((cx + 1) * 16 - ox + stride - 1).div_euclid(stride)).clamp(0, 16);
    // rust: let z0 = ((cz * 16 - oz + stride - 1).div_euclid(stride)).clamp(0, 16);
    // rust: let z1 = (((cz + 1) * 16 - oz + stride - 1).div_euclid(stride)).clamp(0, 16);
    // rust: if x0 == x1 || z0 == z1 {
    // rust: continue;
}
    // rust: let mask = self.detail_masks.entry(key).or_default();
    // rust: let mut changed = false;
    // rust: for z in z0..z1 {
    // rust: for x in x0..x1 {
    // rust: let index = (z * 16 + x) as usize;
    // rust: let column = columns.get(
    // rust: (ox + x * stride).rem_euclid(16) as usize,
    // rust: (oz + z * stride).rem_euclid(16) as usize,
    // rust: stride as usize,
    // rust: );
                    // Copied (from a mesh job's snapshot) only to change it.
    // rust: if samples[index] != *column {
    // rust: Arc::make_mut(samples)[index] = column.clone();
    // rust: changed = true;
}
    // rust: mask[index / 64] |= 1 << (index % 64);
}
}
    // rust: if changed {
    // rust: modified.push(key);
}
}
    // rust: for key in modified {
    // rust: self.mark_data_changed(key);
}
}
    /// A sample with a hole, its data still on its way and nothing coarser
    /// to stand in: drawn, the hole stood where the coarser tile or the older
    /// sample it replaces had terrain, until the data came (`refresh`) and
    /// the tile was sampled again. So it is thrown away, and the tile sampled
    /// again then (at once if it came while this one was taken), or after
    /// `WAIT_RETRY`: a shorter wait let the retries of near tiles take every
    /// slot while the rest waited. One whose waiting cells BlueMap's coarser
    /// levels stood in for is drawn (`finish_any_sample`).
pub fn finish_waited(self: *Self, key: TileKey) void {
}
    // rust: self.pending.remove(&key);
    // rust: if self.restale.remove(&key) {
    // rust: self.wanted_stale = true;
    // rust: } else if self.plan.nodes.contains(&key) {
    // rust: self.retry
    // rust: .insert(key, std::time::Instant::now() + WAIT_RETRY);
}
}
    /// A sample in: thrown away when a cell of it is a hole, its data on its
    /// way (`finish_waited`); one whose waiting cells a coarser level stood
    /// in for is drawn (`LodSampler::waited`).
pub fn finish_any_sample(self: *Self, key: TileKey, samples: std.ArrayList(Column), waited: bool) void {
}
    // rust: if waited {
    // rust: self.finish_waited(key);
    // rust: } else {
    // rust: self.finish_sample(key, samples);
}
}
pub fn finish_sample(self: *Self, key: TileKey, samples: std.ArrayList(Column)) void {
}
    // rust: self.pending.remove(&key);
    // rust: if samples.len() != CELLS * CELLS {
    // rust: let now = std::time::Instant::now();
    // rust: if self.retry.len() > 4096 {
    // rust: self.retry.retain(|_, at| *at > now);
}
    // rust: self.retry.insert(key, now + RETRY);
    // rust: self.restale.remove(&key);
    // rust: return;
}
    // rust: self.retry.remove(&key);
    // rust: if self.plan.nodes.contains(&key) {
    // rust: let mut samples = samples;
    // rust: if let (Some(old), Some(mask)) = (self.ready.get(&key), self.detail_masks.get(&key)) {
    // rust: for i in 0..256 {
    // rust: if mask[i / 64] & (1 << (i % 64)) != 0 {
    // rust: samples[i] = old[i].clone();
}
}
}
            // Refreshed again meanwhile: sampled once more after this.
    // rust: if self.restale.remove(&key) {
    // rust: self.wanted_stale = true;
    // rust: } else {
    // rust: self.stale.remove(&key);
}
    // rust: if self.ready.get(&key).is_some_and(|old| **old == samples) {
    // rust: return;
}
    // rust: let existed = self.ready.insert(key, Arc::new(samples)).is_some();
    // rust: self.refresh_ready(key, existed);
}
}
pub fn finish_detail(self: *Self, key: (i32) void {
}
    // rust: if let Some(visited) = self.saved.get(&key).cloned()
    // rust: && !Arc::ptr_eq(&visited, &columns.columns)
    // rust: {
            // Its latest reduction is queued; never restore old edits or seed data.
    // rust: self.apply_fine(key, &visited);
    // rust: return;
}
    // rust: self.apply_detail(key, &columns);
    // rust: if self.saved.contains_key(&key) {
    // rust: self.reduced.insert(key, Arc::new(columns));
}
        // `apply_detail` marks every tile whose columns it replaced, and their
        // neighbours. Coarser tiles do not read visited columns (stride > 16),
        // so re-meshing every tile touching the chunk was pure waste.
}
    /// Whether the near terrain is still loading: far terrain then queues
    /// `SAMPLE_JOBS` at most, and on small machines holds back
    /// (`HELD_SAMPLE_STEP`).
pub fn set_near_loading(self: *Self, loading: bool) void {
}
    // rust: if loading && !self.near_loading {
            // The queue filled while nothing loaded nearby; the near chunks
            // must not wait behind it. Larger machines keep its first
            // `SAMPLE_JOBS`, small ones none.
    // rust: let mut keep = if self.small { 0 } else { SAMPLE_JOBS };
    // rust: let dropped = drop_queued_samples(&self.shared, &mut self.pending, |_| {
    // rust: let kept = keep > 0;
    // rust: keep = keep.saturating_sub(1);
    // rust: kept
    // rust: });
            // Sampled again from the queue: they read what `refresh` announced.
    // rust: for key in &dropped {
    // rust: self.restale.remove(key);
}
            // Back in line where `wanted_tiles` put them: the near terrain can
            // start and stop loading every few frames, and rebuilding the whole
            // queue each time cost more than the samples it held back.
    // rust: let camera = self.plan.camera;
    // rust: self.wanted.extend(dropped.into_iter().map(|key| {
    // rust: let class = if self.plan.split.contains(&key) {
    // rust: BACKDROP
    // rust: } else if key.reach(camera) < self.plan.first {
    // rust: SEAM
    // rust: } else {
    // rust: REST
}
    // rust: std::cmp::Reverse(Wanted {
    // rust: class,
    // rust: distance: i64::from(key.distance(camera)),
    // rust: x: key.x,
    // rust: z: key.z,
    // rust: level: key.level,
    // rust: })
    // rust: }));
            // A sample may still be running: the held pace starts from now.
    // rust: self.held_sample_at = std::time::Instant::now();
}
    // rust: self.near_loading = loading;
    // rust: self.shared.near_loading.store(loading, Ordering::Relaxed);
    // rust: let held = self.held();
    // rust: if self.shared.mesh_held.swap(held, Ordering::Release) && !held {
    // rust: self.shared.mesh_wake.notify_all();
}
}
    /// Reduced far detail (`graphics::FarDetail::Reduced`): the next update
    /// replans when it changes, and tiles sampled from then on approximate
    /// wide cells (`GeneratorWorker::lod_grid`).
pub fn set_reduced_detail(self: *Self, reduced: bool) void {
}
    // rust: self.reduced_detail = reduced;
    // rust: self.shared.approximate.store(reduced, Ordering::Relaxed);
}
pub fn held(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.small && self.near_loading
}
pub fn request_detail(self: *Self, camera: [i32; 2]) void {
}
    // rust: if self.held()
    // rust: || self.detail_request_pending
            // Nothing new while summaries wait: a chunk whose detail is still
            // in the backlog has its mask clear, so it would be asked for
            // again, and answered from the cache at once. Without this the
            // backlog grew by a request every 250 ms and never drained --
            // 0.5 FPS, with `update` averaging 9.7 s a frame.
    // rust: || !self.detail_backlog.is_empty()
    // rust: || self.detail_request_at.elapsed() < std::time::Duration::from_millis(250)
    // rust: {
    // rust: return;
}
    // rust: self.detail_request_at = std::time::Instant::now();
    // rust: let mut keys: Vec<_> = self
    // rust: .active
    // rust: .iter()
    // rust: .filter(|key| {
    // rust: self.wants_detail(key) && self.detail_masks.get(key) != Some(&[u64::MAX; 4])
    // rust: })
    // rust: .copied()
    // rust: .collect();
        // Retiring fine columns are empty stand-ins, excluded from `active`
        // while their normal meshes still cover the gap. Request their detail
        // explicitly: neither the active-tile requests nor sampling an already
        // ready stand-in can fill it, so its GPU sections would never retire.
    // rust: keys.extend(retiring_detail(
    // rust: &self.plan,
    // rust: &self.retiring,
    // rust: &self.saved,
    // rust: &self.detail_masks,
    // rust: ));
    // rust: keys.sort_unstable_by_key(|key| (key.distance(camera), *key));
    // rust: let mut chunks = FxHashSet::default();
    // rust: for key in keys {
    // rust: let [ox, _, oz] = key.origin();
    // rust: let stride = key.size() / 16;
    // rust: let mask = self.detail_masks.get(&key).copied().unwrap_or_default();
    // rust: for index in 0..256 {
    // rust: if mask[index / 64] & (1 << (index % 64)) == 0 {
    // rust: let chunk = (
    // rust: (ox + (index as i32 % 16) * stride).div_euclid(16),
    // rust: (oz + (index as i32 / 16) * stride).div_euclid(16),
    // rust: );
                    // A retiring column's tile is drawn soon: it needs its detail.
    // rust: if self.full.contains(&chunk) {
    // rust: self.detail_masks.entry(key).or_default()[index / 64] |= 1 << (index % 64);
    // rust: } else {
    // rust: chunks.insert(chunk);
}
}
}
    // rust: if chunks.len() >= DETAIL_REQUEST {
    // rust: break;
}
}
    // rust: let mut chunks: Vec<_> = chunks.into_iter().collect();
    // rust: chunks.sort_unstable_by_key(|&(x, z)| {
    // rust: let dx = i64::from(x * 16 + 8 - camera[0]);
    // rust: let dz = i64::from(z * 16 + 8 - camera[1]);
    // rust: dx * dx + dz * dz
    // rust: });
    // rust: chunks.truncate(DETAIL_REQUEST);
    // rust: if !chunks.is_empty() {
    // rust: self.detail_request_pending = true;
    // rust: self.shared
    // rust: .jobs
    // rust: .lock()
    // rust: .unwrap()
    // rust: .push_back(Job::RequestDetail {
    // rust: chunks,
    // rust: center: camera,
    // rust: refreshes: self.refreshes,
    // rust: });
    // rust: self.shared.wake.notify_all();
}
}
    /// `aim` asks the tiles a zoomed view magnifies for finer detail
    /// ([`ZoomAim`]); `None` plans exactly as before.
    // rust: pub fn update(
    // rust: &mut self,
    // rust: camera: [f64; 3],
    // rust: detail: i32,
    // rust: distance: u32,
    // rust: covered: Option<FxHashSet<(i32, i32)>>,
    // rust: aim: Option<ZoomAim>,
    // rust: ) -> Vec<(TileKey, SectionMesh)> {
    // rust: let elevation =
    // rust: (((camera[1] - f64::from(MIN_Y + crate::chunk::HEIGHT)).clamp(0., 16384.)) as i32 / 32)
    // rust: * 32;
    // rust: let camera = [camera[0].floor() as i32, camera[2].floor() as i32];
        // Replan at chunk boundaries, not on every camera movement.
        // `ZoomAim` rounds its yaw, so a zoom held still keeps one area and the
        // quadtree is not rebuilt as the player nudges the mouse.
    // rust: let area = (
    // rust: [camera[0].div_euclid(16), camera[1].div_euclid(16)],
    // rust: detail,
    // rust: distance,
    // rust: elevation,
    // rust: self.reduced_detail,
    // rust: aim,
    // rust: );
    // rust: if self.area != Some(area) {
    // rust: crate::spans::time("lod_plan", || {
    // rust: self.area = Some(area);
    // rust: self.replan(camera, detail, distance, elevation, aim);
    // rust: });
}
    // rust: let mut meshes = Vec::new();
    // rust: crate::spans::time("lod_results", || self.receive(&mut meshes));
    // rust: crate::spans::time("lod_retiring", || self.prune_retiring());
        // Uploaded over frames in this order (`Renderer::upload_lods`): a
        // tile is meshed clipped around its finer ones, so they go first,
        // and the nearest first, where far terrain meets the near chunks.
    // rust: meshes.sort_by_key(|(key, _)| (key.level, key.distance(camera)));
    // rust: crate::spans::time("lod_covered", || self.cover(covered));
    // rust: if std::mem::take(&mut self.reselect) {
    // rust: self.rebuild_selection();
}
    // rust: crate::spans::time("lod_request", || self.request_detail(camera));
    // rust: crate::spans::time("lod_wanted", || self.request_samples(camera));
    // rust: crate::spans::time("lod_dispatch", || self.dispatch_meshes(camera));
    // rust: crate::spans::time("lod_removed", || self.release_removed());
    // rust: self.publish_cutout_if_ready();
    // rust: meshes
}
    /// Rebuilds the quadtree and the selection it implies. Only runs when the
    /// planned area changes (a chunk boundary), never per finished sample.
    // rust: fn replan(
    // rust: &mut self,
    // rust: camera: [i32; 2],
    // rust: detail: i32,
    // rust: distance: u32,
    // rust: elevation: i32,
    // rust: aim: Option<ZoomAim>,
    // rust: ) {
    // rust: let plan = Plan::with_previous(
    // rust: camera,
    // rust: detail,
    // rust: distance,
    // rust: &self.plan,
    // rust: elevation,
    // rust: self.reduced_detail,
    // rust: aim,
    // rust: );
        // A tile that leaves the range before it was drawn stops being
        // unknown to its neighbours (`Snapshot::planned_leaf`): they remesh
        // with walls against it, as against any terrain out of range.
    // rust: let gone: Vec<_> = self
    // rust: .plan
    // rust: .nodes
    // rust: .iter()
    // rust: .filter(|key| !plan.nodes.contains(key) && !self.ready.contains_key(key))
    // rust: .copied()
    // rust: .collect();
    // rust: self.plan = plan;
    // rust: self.ready.retain(|key, _| self.plan.nodes.contains(key));
        // Queued tiles the view left are not sampled (a running one is
        // dropped when it finishes, `finish_sample`).
    // rust: drop_queued_samples(&self.shared, &mut self.pending, |key| {
    // rust: self.plan.nodes.contains(key)
    // rust: });
    // rust: self.stale.retain(|key| self.plan.nodes.contains(key));
    // rust: self.restale.retain(|key| self.plan.nodes.contains(key));
    // rust: self.detail_masks
    // rust: .retain(|key, _| self.plan.nodes.contains(key));
        // Complete resident columns need no duplicate noise work.
    // rust: let mut standins = Vec::new();
    // rust: for &key in &self.plan.by_level[0] {
    // rust: if self.covered.contains(&(key.x, key.z)) && !self.ready.contains_key(&key) {
    // rust: self.ready
    // rust: .insert(key, Arc::new(vec![Column::default(); CELLS * CELLS]));
    // rust: standins.push(key);
}
}
    // rust: self.rebuild_selection();
    // rust: for key in standins {
    // rust: self.refresh_path(key);
}
    // rust: for key in gone {
    // rust: self.mark_side_neighbors_of(key);
}
}
    /// Recomputes every active tile after a plan change, then marks only the
    /// tiles whose selection changed (plus their neighbours).
pub fn rebuild_selection(self: *Self) void {
}
    // rust: self.reselect = false;
    // rust: let old = std::mem::take(&mut self.active);
    // rust: self.complete.clear();
        // The plan indexes nodes by level, children before parents. Plans
        // built by tests may not; sort those once.
    // rust: let keys: Vec<TileKey> = if self.plan.by_level.iter().any(|level| !level.is_empty()) {
    // rust: self.plan.by_level.iter().flatten().copied().collect()
    // rust: } else {
    // rust: let mut keys: Vec<_> = self.plan.nodes.iter().copied().collect();
    // rust: keys.sort_unstable_by_key(|key| (key.level, key.x, key.z));
    // rust: keys
}
    // rust: for key in keys {
    // rust: let (complete, active) = self.evaluate(key);
    // rust: self.complete.insert(key, complete);
    // rust: if active {
    // rust: self.active.insert(key);
}
}
    // rust: self.mesh_version.retain(|key, _| self.active.contains(key));
    // rust: self.shown_version
    // rust: .retain(|key, _| self.active.contains(key));
    // rust: self.dirty.retain(|key, _| self.active.contains(key));
    // rust: self.meshed.retain(|key| self.active.contains(key));
    // rust: self.unmeshed.retain(|key| self.active.contains(key));
    // rust: let inactive_waiting: Vec<_> = self
    // rust: .cutout_waiting
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|key| !self.active.contains(key))
    // rust: .collect();
    // rust: for key in inactive_waiting {
    // rust: self.transfer_cutout_wait(key);
}
    // rust: self.removed_pending
    // rust: .retain(|key| !self.active.contains(key));
    // rust: let changed: Vec<_> = old.symmetric_difference(&self.active).copied().collect();
    // rust: for &key in &changed {
    // rust: if old.contains(&key) && !self.active.contains(&key) {
    // rust: self.cancel_mesh(key);
    // rust: self.removed_pending.insert(key);
    // rust: self.meshed.remove(&key);
    // rust: self.dirty.remove(&key);
}
    // rust: self.mark_selection_changed(key);
}
    // rust: self.wanted_stale = true;
}
pub fn receive(self: *Self, meshes: *mut Vec<(TileKey) void {
}
    // rust: let started = std::time::Instant::now();
        // What an earlier frame left, before anything new: a chunk's detail
        // must not overtake the detail of a chunk that arrived before it.
    // rust: while started.elapsed() < DETAIL_BUDGET {
    // rust: let Some(summary) = self.detail_backlog.pop_front() else {
    // rust: break;
}
    // rust: self.apply_summary(summary);
}
    // rust: while let Ok(done) = self.results.try_recv() {
    // rust: match done {
    // rust: Done::Detail(key, columns, asked) => self.take_summary(
    // rust: Summary::Detail(key, columns, asked),
    // rust: started.elapsed() < DETAIL_BUDGET,
    // rust: ),
    // rust: Done::Observed(key, columns) => self.take_summary(
    // rust: Summary::Observed(key, columns),
    // rust: started.elapsed() < DETAIL_BUDGET,
    // rust: ),
    // rust: Done::DetailRequested => self.detail_request_pending = false,
    // rust: Done::Sample {
    // rust: key,
    // rust: samples,
    // rust: waited,
    // rust: } => self.finish_any_sample(key, samples, waited),
    // rust: Done::Mesh {
    // rust: key,
    // rust: version,
    // rust: mesh,
    // rust: canceled,
    // rust: } => {
    // rust: self.outstanding_meshes = self.outstanding_meshes.saturating_sub(1);
    // rust: self.accept_mesh(key, version, mesh, canceled.load(Ordering::Acquire), meshes);
}
    // rust: Done::MeshCanceled { key, version } => {
    // rust: self.outstanding_meshes = self.outstanding_meshes.saturating_sub(1);
    // rust: if self.mesh_version.get(&key) == Some(&version) {
    // rust: self.mesh_cancel.remove(&key);
}
}
}
}
}
    /// Applies a summary while the frame has budget and nothing is already
    /// waiting, else leaves it for a later frame.
pub fn take_summary(self: *Self, summary: Summary, within_budget: bool) void {
}
    // rust: if within_budget && self.detail_backlog.is_empty() {
    // rust: self.apply_summary(summary);
    // rust: } else {
    // rust: self.detail_backlog.push_back(summary);
}
}
    /// A chunk's columns applied to the tiles over it.
    ///
    /// `refreshed_since` is tested here and not when the result arrives, so a
    /// refresh over the chunk while the summary waited still drops it: it was
    /// read before that refresh, and the tiles ask again with their bits
    /// clear.
pub fn apply_summary(self: *Self, summary: Summary) void {
}
    // rust: crate::spans::time("lod_detail", || match summary {
    // rust: Summary::Detail(key, _, asked) if self.refreshed_since(key, asked) => {}
    // rust: Summary::Detail(key, columns, _) => self.finish_detail(key, columns),
    // rust: Summary::Observed(key, columns) => self.finish_observed(key, columns),
    // rust: });
}
    /// A finished mesh: shown when it is newer than what the tile shows now.
    /// A result newer than the frame's current one is still useful while a
    /// newer job is pending — re-marking a tile re-dirties its neighbours and
    /// ancestors, so on a busy frontier the newest job is not the one that
    /// arrives next, and accepting only it left tiles unmeshed with their
    /// removals blocked.
    // rust: fn accept_mesh(
    // rust: &mut self,
    // rust: key: TileKey,
    // rust: version: u64,
    // rust: mesh: SectionMesh,
    // rust: canceled: bool,
    // rust: meshes: &mut Vec<(TileKey, SectionMesh)>,
    // rust: ) {
    // rust: let newest = self.mesh_version.get(&key) == Some(&version);
    // rust: if canceled
    // rust: || !self.active.contains(&key)
    // rust: || self
    // rust: .shown_version
    // rust: .get(&key)
    // rust: .is_some_and(|shown| version <= *shown)
    // rust: {
    // rust: return;
}
    // rust: self.shown_version.insert(key, version);
    // rust: meshes.push((key, mesh));
    // rust: self.meshed.insert(key);
        // Only the newest revision settles the tile; an older one fills the
        // frame and stays dirty, so the pending job still runs.
    // rust: if newest {
    // rust: self.mesh_cancel.remove(&key);
    // rust: self.unmeshed.remove(&key);
    // rust: self.cutout_waiting.remove(&key);
}
}
    /// Takes the new full-detail columns, when they changed (`None`: not).
pub fn cover(self: *Self, covered: Option<FxHashSet<(i32) void {
}
    // rust: if let Some(full) = covered
    // rust: && self.full != full
    // rust: {
    // rust: self.retiring.extend(self.full.difference(&full).copied());
    // rust: self.retiring.retain(|column| !full.contains(column));
    // rust: self.full = full;
    // rust: self.leave_out();
}
}
    /// Releases retiring columns whose replacement is ready, then leaves out
    /// the full-detail and retiring columns: tiles touching a change remesh.
pub fn prune_retiring(self: *Self) void {
}
    // rust: if self.retiring.is_empty() {
    // rust: return;
}
    // rust: let (plan, ready, masks) = (&self.plan, &self.ready, &self.detail_masks);
    // rust: let keep: FxHashSet<_> = self
    // rust: .retiring
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&column| {
                // A saved summary alone is not detail: the tile may still be
                // the empty covered stand-in. Only a completed mask proves
                // its columns replaced the full-detail mesh.
    // rust: !plan.replaces(column, ready, |key| masks.get(&key) == Some(&[u64::MAX; 4]))
    // rust: })
    // rust: .collect();
    // rust: if keep.len() != self.retiring.len() {
    // rust: self.retiring = keep;
    // rust: self.leave_out();
}
}
pub fn leave_out(self: *Self) void {
}
    // rust: let covered: FxHashSet<_> = self.full.union(&self.retiring).copied().collect();
    // rust: if self.covered == covered {
    // rust: return;
}
    // rust: let added: Vec<_> = covered.difference(&self.covered).copied().collect();
    // rust: let changes: Vec<_> = self
    // rust: .covered
    // rust: .symmetric_difference(&covered)
    // rust: .copied()
    // rust: .collect();
    // rust: self.covered = covered;
    // rust: self.covered_bounds = self.covered.iter().fold(None, |bounds, &(x, z)| {
    // rust: Some(match bounds {
    // rust: None => [x * 16, z * 16, (x + 1) * 16, (z + 1) * 16],
    // rust: Some([x0, z0, x1, z1]) => [
    // rust: x0.min(x * 16),
    // rust: z0.min(z * 16),
    // rust: x1.max((x + 1) * 16),
    // rust: z1.max((z + 1) * 16),
    // rust: ],
    // rust: })
    // rust: });
    // rust: for &(x, z) in &changes {
    // rust: self.invalidate_chunk(x, z);
}
    // rust: let mut standins = Vec::new();
    // rust: for &(x, z) in &added {
    // rust: let key = TileKey { x, z, level: 0 };
    // rust: if self.plan.nodes.contains(&key) && !self.ready.contains_key(&key) {
    // rust: self.ready
    // rust: .insert(key, Arc::new(vec![Column::default(); CELLS * CELLS]));
    // rust: standins.push(key);
}
}
    // rust: for key in standins {
    // rust: self.refresh_path(key);
}
    // rust: for &(x, z) in &changes {
    // rust: self.refresh_path(TileKey { x, z, level: 0 });
}
    // rust: self.cutout_pending = Some(self.covered.clone());
        // Every active tile whose mesh clips an old/new covered column is
        // dirty now; the cutout waits for their replacement meshes, not for
        // every later job.
    // rust: self.cutout_waiting.extend(
    // rust: self.dirty
    // rust: .keys()
    // rust: .filter(|key| self.active.contains(key))
    // rust: .copied(),
    // rust: );
}
    /// A waiting tile that left the selection is replaced by its active
    /// descendants; the cutout must wait for those meshes instead.
pub fn transfer_cutout_wait(self: *Self, key: TileKey) void {
}
    // rust: if !self.cutout_waiting.remove(&key) {
    // rust: return;
}
    // rust: if key.level == 0 {
    // rust: return;
}
    // rust: let mut descendants = Vec::new();
    // rust: self.collect_active_descendants(key, &mut descendants);
    // rust: self.cutout_waiting.extend(
    // rust: descendants
    // rust: .into_iter()
    // rust: .filter(|key| !self.meshed.contains(key)),
    // rust: );
}
    /// Publishes the pending cutout once every active tile that had to stop
    /// clipping the changed columns has an accepted mesh.
pub fn publish_cutout_if_ready(self: *Self) void {
}
    // rust: if self.cutout_pending.is_none() || !self.cutout_waiting.is_empty() {
    // rust: return;
}
    // rust: self.cutout = self.cutout_pending.take();
}
    /// Releases tiles whose every overlapping replacement already has a mesh.
    /// Quadtree tiles are nested or disjoint, so blocking is an ancestor test:
    /// O(pending + unm meshed active) tree walks, not pending x active.
pub fn release_removed(self: *Self) void {
}
    // rust: if self.removed_pending.is_empty() {
    // rust: return;
}
    // rust: let mut blocked = FxHashSet::default();
    // rust: for &removed in &self.removed_pending {
    // rust: let mut node = removed;
    // rust: loop {
    // rust: if self.active.contains(&node) && !self.meshed.contains(&node) {
    // rust: blocked.insert(removed);
    // rust: break;
}
    // rust: if node.level >= MAX_LEVEL {
    // rust: break;
}
    // rust: node = node.parent();
}
}
    // rust: for &active in &self.unmeshed {
    // rust: let mut node = active;
    // rust: loop {
    // rust: if self.removed_pending.contains(&node) {
    // rust: blocked.insert(node);
}
    // rust: if node.level >= MAX_LEVEL {
    // rust: break;
}
    // rust: node = node.parent();
}
}
    // rust: let pending: Vec<_> = self.removed_pending.iter().copied().collect();
    // rust: for key in pending {
    // rust: if self.active.contains(&key) || blocked.contains(&key) {
    // rust: continue;
}
    // rust: self.removed_pending.remove(&key);
    // rust: self.removed.push(key);
}
    // rust: self.removed_pending
    // rust: .retain(|key| !self.active.contains(key));
}
    /// Queues every dirty active tile with a shared immutable snapshot. One
    /// batch used to clone all maps and serialize the whole view on one worker.
pub fn dispatch_meshes(self: *Self, camera: [i32; 2]) void {
}
    // rust: if self.dirty.is_empty() || self.held() {
    // rust: return;
}
        // Under load, let the pool drain and send one larger batch with one
        // snapshot instead of rebuilding the snapshot 20 times a second.
    // rust: if self.outstanding_meshes >= self.mesh_workers * 4 {
    // rust: return;
}
    // rust: let keys: Vec<(TileKey, u64)> = self
    // rust: .dirty
    // rust: .drain()
    // rust: .filter(|(key, _)| self.active.contains(key) && self.ready.contains_key(key))
    // rust: .collect();
    // rust: if keys.is_empty() {
    // rust: return;
}
    // rust: let snapshot = Arc::new(Snapshot {
    // rust: samples: self
    // rust: .active
    // rust: .iter()
    // rust: .filter_map(|key| self.ready.get(key).map(|columns| (*key, columns.clone())))
    // rust: .collect(),
    // rust: saved: self.saved.clone(),
    // rust: reduced: self.reduced.clone(),
    // rust: nodes: self.plan.nodes.clone(),
    // rust: split: self.plan.split.clone(),
    // rust: });
    // rust: let covered = Arc::new(self.covered.clone());
    // rust: let mut queued = self.shared.mesh_jobs.lock().unwrap();
    // rust: let count = keys.len();
    // rust: for (key, version) in keys {
    // rust: let finer = self.finer_of(key);
    // rust: let canceled = Arc::new(AtomicBool::new(false));
    // rust: self.mesh_cancel.insert(key, canceled.clone());
            // Screen-space urgency: nearer blocks cost more pixels per work.
    // rust: let priority = i64::from(key.distance(camera)) * 16 / i64::from(key.size());
    // rust: queued.push(MeshQueued {
    // rust: priority,
    // rust: order: version,
    // rust: job: MeshJob {
    // rust: snapshot: snapshot.clone(),
    // rust: key,
    // rust: version,
    // rust: finer,
    // rust: covered: covered.clone(),
    // rust: bounds: self.covered_bounds,
    // rust: canceled,
    // rust: },
    // rust: });
}
    // rust: drop(queued);
    // rust: self.outstanding_meshes += count;
    // rust: self.shared.mesh_wake.notify_all();
}
pub fn finer_of(self: *Self, key: TileKey) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.plan.split.contains(&key) {
    // rust: return Vec::new();
}
    // rust: let mut finer = Vec::new();
    // rust: self.collect_active_descendants(key, &mut finer);
    // rust: finer
}
pub fn collect_active_descendants(self: *Self, key: TileKey, out: *mut std.ArrayList(TileKey)) void {
}
    // rust: for child in key.children() {
    // rust: if !self.plan.nodes.contains(&child) {
    // rust: continue;
}
    // rust: if self.active.contains(&child) {
    // rust: out.push(child);
}
    // rust: if self.plan.split.contains(&child) {
    // rust: self.collect_active_descendants(child, out);
}
}
}
pub fn request_samples(self: *Self, camera: [i32; 2]) void {
}
        // Every sample slot busy: no tile can be requested this frame.
    // rust: let free = if self.held() {
    // rust: usize::from(
    // rust: self.pending.is_empty() && self.held_sample_at.elapsed() >= HELD_SAMPLE_STEP,
    // rust: )
    // rust: } else {
            // `SAMPLE_JOBS` while the near terrain loads, the full queue
            // (`QUEUED_PER_SAMPLER` a thread) once it is in.
    // rust: let slots = if self.near_loading {
    // rust: SAMPLE_JOBS
    // rust: } else {
    // rust: self.sample_jobs
}
    // rust: slots.saturating_sub(self.pending.len())
}
    // rust: if free == 0 {
    // rust: return;
}
    // rust: let now = std::time::Instant::now();
    // rust: if self.held() {
    // rust: self.held_sample_at = now;
}
        // A tile whose sampling failed waits out `RETRY`; once it has, the
        // queue is rebuilt so the tile is asked again.
    // rust: let retrying = self.retry.len();
    // rust: self.retry.retain(|_, at| *at > now);
    // rust: if self.retry.len() != retrying {
    // rust: self.wanted_stale = true;
}
        // The queue is rebuilt when the view moves a chunk, not scanned and
        // sorted on every frame.
    // rust: let view = [camera[0].div_euclid(16), camera[1].div_euclid(16)];
    // rust: if self.wanted_stale || self.wanted_at != Some(view) {
    // rust: self.rebuild_wanted(camera);
    // rust: self.wanted_at = Some(view);
    // rust: self.wanted_stale = false;
}
    // rust: let mut issued = 0;
    // rust: let mut jobs = self.shared.jobs.lock().unwrap();
    // rust: while issued < free {
    // rust: let Some(std::cmp::Reverse(wanted)) = self.wanted.pop() else {
    // rust: break;
}
    // rust: let key = TileKey {
    // rust: x: wanted.x,
    // rust: z: wanted.z,
    // rust: level: wanted.level,
}
            // Final tiles and the backdrop only (`wanted_tiles`).
    // rust: if self.pending.contains(&key)
    // rust: || self.sampled(key)
    // rust: || (self.plan.split.contains(&key) && wanted.class != BACKDROP)
    // rust: || !self.plan.nodes.contains(&key)
    // rust: || self.retry.contains_key(&key)
    // rust: {
    // rust: continue;
}
    // rust: self.pending.insert(key);
    // rust: jobs.push_back(Job::Sample(key));
    // rust: issued += 1;
}
    // rust: drop(jobs);
    // rust: if issued > 0 {
    // rust: self.shared.wake.notify_all();
}
}
    /// Sampled, and not since `refresh`ed.
pub fn sampled(self: *Self, key: TileKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ready.contains_key(&key) && !self.stale.contains(&key)
}
pub fn rebuild_wanted(self: *Self, camera: [i32; 2]) void {
}
    // rust: self.wanted.clear();
        // A failed tile waits out its retry delay (`retry`) before it is asked again.
    // rust: let retry = &self.retry;
    // rust: self.wanted.extend(
    // rust: wanted_tiles(&self.plan, &self.ready, &self.stale, camera)
    // rust: .filter(|w| {
    // rust: !retry.contains_key(&TileKey {
    // rust: x: w.x,
    // rust: z: w.z,
    // rust: level: w.level,
    // rust: })
    // rust: })
    // rust: .map(std::cmp::Reverse),
    // rust: );
}

pub fn snapshot(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Snapshot {
    // rust: samples: self
    // rust: .active
    // rust: .iter()
    // rust: .filter_map(|key| self.ready.get(key).map(|columns| (*key, columns.clone())))
    // rust: .collect(),
    // rust: saved: self.saved.clone(),
    // rust: reduced: self.reduced.clone(),
    // rust: nodes: self.plan.nodes.clone(),
    // rust: split: self.plan.split.clone(),
}
}
pub fn mesh(self: *Self, key: TileKey) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let finer = self.finer_of(key);
    // rust: let input = self.snapshot().mesh_input(key, finer);
    // rust: let columns = input.columns();
    // rust: let edges = input.edges();
    // rust: mesh::Mesher::default().mesh(
    // rust: key,
    // rust: &columns,
    // rust: &self.covered,
    // rust: self.covered_bounds,
    // rust: self.context.as_deref().expect("test mesh context"),
    // rust: &edges,
    // rust: &input.finer,
    // rust: )
}
}
    // rust: impl Snapshot {
    /// Actual visited columns at this cell, when a saved/observed chunk has
    /// them. Sampled stand-ins are coarser.
pub fn visited_source(self: *Self, wx: i32, wz: i32, width: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (wx.div_euclid(16), wz.div_euclid(16));
    // rust: if width == 1 {
    // rust: self.saved.get(&key).map(|columns| {
    // rust: ColumnSource::Saved(
    // rust: columns.clone(),
    // rust: (wz.rem_euclid(16) * 16 + wx.rem_euclid(16)) as u16,
    // rust: )
    // rust: })
    // rust: } else if width <= 16 {
    // rust: self.reduced.get(&key).map(|columns| {
    // rust: ColumnSource::Reduced(
    // rust: columns.clone(),
    // rust: width as u8,
    // rust: wx.rem_euclid(16) as u16,
    // rust: wz.rem_euclid(16) as u16,
    // rust: )
    // rust: })
    // rust: } else {
    // rust: None
}
}
pub fn neighbor_source(self: *Self, wx: i32, wz: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for level in 0..=MAX_LEVEL {
    // rust: let size = 16 << level;
    // rust: let key = TileKey {
    // rust: x: wx.div_euclid(size),
    // rust: z: wz.div_euclid(size),
    // rust: level,
}
            // `samples` holds exactly the active tiles.
    // rust: let Some(columns) = self.samples.get(&key) else {
    // rust: continue;
}
    // rust: let stride = 1 << level;
    // rust: let [ox, _, oz] = key.origin();
    // rust: let x = (wx - ox) / stride;
    // rust: let z = (wz - oz) / stride;
    // rust: let (sx, sz) = (ox + x * stride, oz + z * stride);
    // rust: if let Some(column) = self.visited_source(sx, sz, stride) {
    // rust: return Some((column, stride));
}
    // rust: return Some((
    // rust: ColumnSource::Tile(columns.clone(), (z * CELLS as i32 + x) as u16),
    // rust: stride,
    // rust: ));
}
    // rust: None
}
    /// Whether block column (wx, wz) lies in a planned tile that is not
    /// split, whatever drew it (nothing, here): the finest planned tile
    /// there. Past a split tile's out-of-range children, or past the plan,
    /// there is no terrain to wait for.
pub fn planned_leaf(self: *Self, wx: i32, wz: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..=MAX_LEVEL)
    // rust: .map(|level| {
    // rust: let size = 16 << level;
    // rust: TileKey {
    // rust: x: wx.div_euclid(size),
    // rust: z: wz.div_euclid(size),
    // rust: level,
}
    // rust: })
    // rust: .find(|key| self.nodes.contains(key))
    // rust: .is_some_and(|key| !self.split.contains(&key))
}
pub fn mesh_input(self: *Self, key: TileKey, finer: std.ArrayList(TileKey)) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stride = key.size() / CELLS as i32;
    // rust: let [ox, _, oz] = key.origin();
    // rust: let base = self
    // rust: .samples
    // rust: .get(&key)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| Arc::new(vec![Column::default(); CELLS * CELLS]));
    // rust: let overrides = std::array::from_fn(|index| {
    // rust: let x = index % CELLS;
    // rust: let z = index / CELLS;
    // rust: self.visited_source(ox + x as i32 * stride, oz + z as i32 * stride, stride)
    // rust: });
    // rust: let neighbors = std::array::from_fn(|direction| {
    // rust: let mut edge = Vec::new();
    // rust: let mut offset = 0;
    // rust: while offset < key.size() {
    // rust: let (wx, wz) = match direction {
    // rust: 0 => (ox - 1, oz + offset),
    // rust: 1 => (ox + key.size(), oz + offset),
    // rust: 2 => (ox + offset, oz - 1),
    // rust: _ => (ox + offset, oz + key.size()),
}
                // Nothing drawn across the edge: still to come when planned,
                // so no wall is drawn against it; empty past the plan.
    // rust: let (column, neighbor_stride, unknown) = match self.neighbor_source(wx, wz) {
    // rust: Some((column, stride)) => (column, stride, false),
    // rust: None => (ColumnSource::Empty, stride, self.planned_leaf(wx, wz)),
}
    // rust: let coordinate = if direction < 2 { wz } else { wx };
    // rust: let width = (neighbor_stride - coordinate.rem_euclid(neighbor_stride))
    // rust: .min(key.size() - offset);
    // rust: edge.push(EdgeSource {
    // rust: start: offset,
    // rust: end: offset + width,
    // rust: column,
    // rust: unknown,
    // rust: });
    // rust: offset += width;
}
    // rust: edge
    // rust: });
    // rust: MeshInput {
    // rust: base,
    // rust: overrides,
    // rust: neighbors,
    // rust: finer,
}
}
}
    // rust: impl Drop for Lod {
pub fn drop(self: *Self) void {
}
        // Under each pool's own lock: a worker between its stop check and its
        // wait must not miss the wake, or join() hangs.
    // rust: let jobs = self.shared.jobs.lock();
    // rust: let mesh_jobs = self.shared.mesh_jobs.lock();
    // rust: self.shared.stop.store(true, Ordering::Relaxed);
    // rust: drop(mesh_jobs);
    // rust: drop(jobs);
    // rust: self.shared.wake.notify_all();
    // rust: self.shared.mesh_wake.notify_all();
    // rust: if let Some(thread) = self.thread.take() {
    // rust: let _ = thread.join();
}
    // rust: for thread in self.mesh_threads.drain(..) {
    // rust: let _ = thread.join();
}
}
}
/// The columns of a tile's `detail_masks` entry that have their detail.
pub fn detail_count(mask: *[u64; 4]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mask.iter().map(|bits| bits.count_ones() as usize).sum()
}
/// Removes the queued sample jobs `keep` rejects (in queue order, best
/// first) and frees their slots; the tiles removed.
    // rust: fn drop_queued_samples(
    // rust: shared: &Shared,
    // rust: pending: &mut FxHashSet<TileKey>,
    // rust: mut keep: impl FnMut(&TileKey) -> bool,
    // rust: ) -> Vec<TileKey> {
    // rust: let mut dropped = Vec::new();
    // rust: shared.jobs.lock().unwrap().retain(|job| match job {
    // rust: Job::Sample(key) if !keep(key) => {
    // rust: pending.remove(key);
    // rust: dropped.push(*key);
    // rust: false
}
    // rust: _ => true,
    // rust: });
    // rust: dropped
}
/// Fine retiring stand-ins need actual column detail before `Plan::replaces`
/// can release their normal meshes. The caller keeps the usual detail-request
/// budget and waits for the replacement mesh before changing cutout.
    // rust: fn retiring_detail<'a>(
    // rust: plan: &'a Plan,
    // rust: retiring: &'a FxHashSet<(i32, i32)>,
    // rust: _saved: &'a Saved,
    // rust: masks: &'a FxHashMap<TileKey, [u64; 4]>,
    // rust: ) -> impl Iterator<Item = TileKey> + 'a {
    // rust: retiring.iter().filter_map(move |&(x, z)| {
    // rust: let key = TileKey { x, z, level: 0 };
    // rust: (plan.nodes.contains(&key) && masks.get(&key) != Some(&[u64::MAX; 4])).then_some(key)
    // rust: })
}
    // rust: mod tests {
    /// A spyglass or the zoom mod magnifies only what the narrowed view
    /// covers, so `ZoomAim` asks for finer tiles there and nowhere else. Without
    /// that cone the same request would reach the whole circle, which at the
    /// measured quads a tile is gigabytes of vertices.
pub fn a_zoomed_view_asks_for_finer_tiles_only_where_it_looks() void {
}
        // Yaw 0 looks toward +z (`view_vector`), ten times magnified.
    // rust: let aim = ZoomAim::new(0.0, 7.0, 10.0).expect("a tenth of the field of view zooms");
        // Capped, however far the zoom goes.
    // rust: assert_eq!(aim.boost, MAX_ZOOM_BOOST);
    // rust: let camera = [0, 0];
    // rust: let tile = |x, z, level| TileKey { x, z, level };
        // Straight ahead, far enough that the direction decides it.
    // rust: assert!(aim.covers(tile(0, 8, 4), camera), "ahead");
        // Behind, beside, and the opposite diagonal: the zoom does not
        // magnify these, so they keep the plan they would have had.
    // rust: assert!(!aim.covers(tile(0, -9, 4), camera), "behind");
    // rust: assert!(!aim.covers(tile(8, 0, 4), camera), "beside");
    // rust: assert!(!aim.covers(tile(-9, -9, 4), camera), "diagonally behind");
        // A tile the camera stands in is in view whichever way it faces.
    // rust: assert!(aim.covers(tile(0, 0, 4), camera), "underfoot");
}

    /// A zoom too slight to change which level a tile wants is not worth
    /// rebuilding the quadtree for, and an unzoomed view must plan exactly as
    /// it did before this feature.
pub fn a_slight_zoom_does_not_replan() void {
}
    // rust: assert_eq!(ZoomAim::new(0.0, 70.0, 1.0), None, "not zoomed");
    // rust: assert_eq!(
    // rust: ZoomAim::new(0.0, 60.0, 1.2),
    // rust: None,
    // rust: "a fifth is under one level"
    // rust: );
    // rust: assert!(ZoomAim::new(0.0, 35.0, 2.0).is_some(), "twice is worth it");
        // Nothing finite comes of a broken field of view.
    // rust: assert_eq!(ZoomAim::new(0.0, f32::NAN, 4.0), None);
    // rust: assert_eq!(ZoomAim::new(0.0, 0.0, 4.0), None);
    // rust: assert_eq!(ZoomAim::new(0.0, 70.0, f32::INFINITY), None);
}

    /// The cone turns with the player, and its yaw is rounded so that a
    /// mouse-twitch does not rebuild the quadtree: two aims within the
    /// rounding step compare equal, and `Lod::update` replans on that.
pub fn the_cone_turns_and_rounds_with_the_view() void {
}
    // rust: let camera = [0, 0];
    // rust: let east = ZoomAim::new(-90.0, 7.0, 10.0).expect("zoomed");
    // rust: let tile = |x, z| TileKey { x, z, level: 4 };
        // Yaw -90 looks toward +x.
    // rust: assert!(east.covers(tile(8, 0), camera), "ahead when facing +x");
    // rust: assert!(!east.covers(tile(0, 8), camera), "+z is no longer ahead");
        // Within the rounding step: the same aim, so no replan.
    // rust: assert_eq!(ZoomAim::new(0.0, 7.0, 10.0), ZoomAim::new(1.0, 7.0, 10.0));
        // Past it: a different aim, so the cone follows.
    // rust: assert_ne!(ZoomAim::new(0.0, 7.0, 10.0), ZoomAim::new(20.0, 7.0, 10.0));
}

    /// Inside the cone a tile splits further than it would unzoomed, and
    /// outside it the plan is unchanged, tile for tile.
pub fn the_plan_is_finer_ahead_and_untouched_behind() void {
}
    // rust: let camera = [0, 0];
    // rust: let plain = Plan::with_previous(camera, 12, 256, &Plan::default(), 0, false, None);
    // rust: let zoomed = Plan::with_previous(
    // rust: camera,
    // rust: 12,
    // rust: 256,
    // rust: &Plan::default(),
    // rust: 0,
    // rust: false,
    // rust: ZoomAim::new(0.0, 7.0, 10.0),
    // rust: );
        // Finer somewhere: the zoomed plan holds tiles the plain one split
        // no further.
    // rust: assert!(
    // rust: zoomed.nodes.len() > plain.nodes.len(),
    // rust: "zoomed {} tiles, plain {}",
    // rust: zoomed.nodes.len(),
    // rust: plain.nodes.len()
    // rust: );
        // Behind the camera the two agree. Tiles there are the same level in
        // both, so every plain node well behind is still a node when zoomed.
    // rust: let behind = |key: &&TileKey| {
    // rust: let [_, _, oz] = key.origin();
    // rust: oz + key.size() < -1024
}
    // rust: let plain_behind: std::collections::BTreeSet<_> =
    // rust: plain.nodes.iter().filter(behind).copied().collect();
    // rust: let zoomed_behind: std::collections::BTreeSet<_> =
    // rust: zoomed.nodes.iter().filter(behind).copied().collect();
    // rust: assert!(!plain_behind.is_empty(), "nothing behind to compare");
    // rust: assert_eq!(
    // rust: plain_behind, zoomed_behind,
    // rust: "the zoom changed the plan behind the player"
    // rust: );
}

//     use super::*;
//     use crate::mesher::TerrainVertex;
pub fn retiring_fine_stand_ins_request_detail_before_their_gpu_meshes_can_retire() void {
}
    // rust: let column = (12, 0);
    // rust: let fine = TileKey {
    // rust: x: 12,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: let mut plan = Plan::default();
    // rust: plan.nodes.insert(fine);
    // rust: let ready: FxHashMap<TileKey, ()> = [(fine, ())].into_iter().collect();
    // rust: let retiring = [column].into_iter().collect();
    // rust: let saved = Saved::default();
    // rust: let mut masks = FxHashMap::default();
        // A covered stand-in is ready, but empty: ordinary sampling skips it,
        // and selection leaves it out of `active`. It cannot yet replace the
        // old full-detail column, even though the near world has unloaded it.
    // rust: assert!(!plan.replaces(column, &ready, |key| masks.get(&key)
    // rust: == Some(&[u64::MAX; 4])));
    // rust: assert_eq!(
    // rust: retiring_detail(&plan, &retiring, &saved, &masks).collect::<Vec<_>>(),
    // rust: [fine]
    // rust: );
        // The existing RequestDetail -> apply_fine path marks complete detail;
        // only then may selection retire it and publish the new mesh cutout.
    // rust: masks.insert(fine, [u64::MAX; 4]);
    // rust: assert!(
    // rust: retiring_detail(&plan, &retiring, &saved, &masks)
    // rust: .next()
    // rust: .is_none()
    // rust: );
    // rust: assert!(plan.replaces(column, &ready, |key| masks.get(&key)
    // rust: == Some(&[u64::MAX; 4])));
}
pub fn retiring_detail_requests_only_planned_columns_still_missing_detail() void {
}
    // rust: let fine = |x| TileKey { x, z: 0, level: 0 };
    // rust: let mut plan = Plan::default();
    // rust: plan.nodes.extend((0..4).map(fine));
    // rust: plan.nodes.insert(fine(5));
    // rust: let retiring = (0..5).map(|x| (x, 0)).collect();
    // rust: let saved = [((1, 0), Arc::new(std::array::from_fn(|_| Column::default())))]
    // rust: .into_iter()
    // rust: .collect();
    // rust: let masks = [
    // rust: (fine(2), [u64::MAX; 4]),
    // rust: (fine(3), [u64::MAX, u64::MAX, u64::MAX, u64::MAX - 1]),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect();
    // rust: let mut requested: Vec<_> = retiring_detail(&plan, &retiring, &saved, &masks).collect();
    // rust: requested.sort_unstable();
        // Complete detail needs no request. A saved summary without a
        // completed mask still does: it may predate the tile's stand-in.
        // An unplanned retiree and a planned column that is not retiring
        // must not consume the budget.
    // rust: assert_eq!(requested, [fine(0), fine(1), fine(3)]);
}
pub fn reduced_far_detail_only_merges_tiles_away_from_the_near_terrain() void {
}
    // rust: let leaves = |plan: &Plan| {
    // rust: plan.nodes
    // rust: .iter()
    // rust: .filter(|k| !plan.split.contains(k))
    // rust: .count()
}
    // rust: for camera in [[0, 0], [100, -40]] {
    // rust: for distance in [64, 128, 512, 1024] {
    // rust: let full = Plan::new(camera, 12, distance);
    // rust: let reduced =
    // rust: Plan::with_previous(camera, 12, distance, &Plan::default(), 0, true, None);
                // Never finer than Full anywhere, and as fine next to the
                // full-detail area, whose edge the finest tiles match.
    // rust: assert!(reduced.split.is_subset(&full.split));
    // rust: assert_eq!(reduced.roots, full.roots);
    // rust: for key in reduced.nodes.iter().filter(|k| !reduced.split.contains(k)) {
    // rust: if key.distance(camera) < 12 * 16 + 16 {
    // rust: assert_eq!(key.level, 0, "{key:?}");
}
}
    // rust: let (full, reduced) = (leaves(&full), leaves(&reduced));
                // At 64 chunks most tiles are the near area's finest, the
                // same in both: about half there, well under from 128.
    // rust: let bound = if distance == 64 { full * 21 / 20 } else { full };
    // rust: assert!(
    // rust: reduced * 2 < bound,
    // rust: "{reduced} of {full} tiles at {distance}"
    // rust: );
}
}
}
pub fn far_plan_is_bounded_and_near_tiles_align_with_chunks() void {
}
    // rust: for camera in [[0, 0], [-1, -17], [1023, -4097]] {
    // rust: for distance in [64, 256, 1024] {
    // rust: let plan = Plan::new(camera, 12, distance);
    // rust: assert!(plan.nodes.len() < 12000, "{} nodes", plan.nodes.len());
    // rust: assert!(plan.roots.iter().all(|key| key.level <= MAX_LEVEL));
    // rust: for key in &plan.nodes {
    // rust: if !plan.split.contains(key) && key.distance(camera) < 12 * 16 {
    // rust: assert_eq!(key.level, 0);
}
}
    // rust: let cells = plan
    // rust: .nodes
    // rust: .iter()
    // rust: .filter(|k| !plan.split.contains(k))
    // rust: .count();
    // rust: assert!(cells < 10000);
}
}
    // rust: assert_eq!(
    // rust: TileKey {
    // rust: x: -1,
    // rust: z: -2,
    // rust: level: 1
}
    // rust: .origin(),
    // rust: [-32, 0, -64]
    // rust: );
}
pub fn world_wide_plans_stay_small_and_cover_every_level() void {
}
        // About 10 000 nodes at a corner of the world, 9 000 at its centre.
pub const WORLD_PLAN_NODES: usize = 16_384;
    // rust: for (camera, elevation) in [
    // rust: ([0, 0], 0),
    // rust: ([115, 135], 49_000_000),
    // rust: ([-30_000_000, 29_999_000], 90),
    // rust: ] {
    // rust: let plan = Plan::with_previous(
    // rust: camera,
    // rust: 12,
    // rust: MAX_CHUNKS,
    // rust: &Plan::default(),
    // rust: elevation,
    // rust: false,
    // rust: None,
    // rust: );
    // rust: let reduced = Plan::with_previous(
    // rust: camera,
    // rust: 12,
    // rust: MAX_CHUNKS,
    // rust: &Plan::default(),
    // rust: elevation,
    // rust: true,
    // rust: None,
    // rust: );
    // rust: let top = plan.nodes.iter().map(|k| k.level).max().unwrap();
    // rust: assert_eq!(top, MAX_LEVEL, "{camera:?} y={elevation}: roots stop short");
    // rust: assert!(
    // rust: plan.nodes.len() < WORLD_PLAN_NODES,
    // rust: "{camera:?} y={elevation}: {} nodes",
    // rust: plan.nodes.len()
    // rust: );
    // rust: assert!(
    // rust: reduced.nodes.len() <= plan.nodes.len(),
    // rust: "{camera:?} y={elevation}: reduced has {} nodes, full {}",
    // rust: reduced.nodes.len(),
    // rust: plan.nodes.len()
    // rust: );
            // Every level from the finest planned one up to the roots has tiles.
    // rust: let finest = plan.nodes.iter().map(|k| k.level).min().unwrap();
    // rust: for level in finest..=MAX_LEVEL {
    // rust: assert!(
    // rust: plan.nodes.iter().any(|k| k.level == level),
    // rust: "{camera:?} y={elevation}: no level-{level} tile"
    // rust: );
}
}
}
pub fn aerial_distance_avoids_unseen_full_detail_outside_the_near_area() void {
}
    // rust: let ground = Plan::new([0, 0], 12, 1024);
    // rust: let high = Plan::with_previous([0, 0], 12, 1024, &Plan::default(), 1024, false, None);
    // rust: assert!(high.nodes.len() < ground.nodes.len());
    // rust: assert!(
    // rust: high.nodes.contains(&TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0
    // rust: }),
    // rust: "near full-detail footprint stays exact"
    // rust: );
    // rust: assert!(
    // rust: !high.nodes.contains(&TileKey {
    // rust: x: 20,
    // rust: z: 0,
    // rust: level: 0
    // rust: }),
    // rust: "far terrain viewed from high above needs distance-appropriate detail"
    // rust: );
}
pub fn late_parent_keeps_ready_detail_and_only_fills_missing_children() void {
}
    // rust: let parent = TileKey {
    // rust: x: -1,
    // rust: z: 0,
    // rust: level: 1,
}
    // rust: let mut plan = Plan::default();
    // rust: plan.roots.push(parent);
    // rust: plan.nodes.insert(parent);
    // rust: plan.split.insert(parent);
    // rust: plan.nodes.extend(parent.children());
    // rust: let mut ready: FxHashMap<TileKey, Vec<Column>> = FxHashMap::default();
    // rust: ready.insert(parent, vec![]);
    // rust: ready.insert(parent.children()[0], vec![]);
    // rust: let mut selected = Vec::new();
    // rust: ready.remove(&parent);
    // rust: assert!(!plan.select(parent, &ready, &mut selected));
    // rust: assert_eq!(selected, [parent.children()[0]]);
    // rust: ready.insert(parent, vec![]);
    // rust: selected.clear();
    // rust: assert!(plan.select(parent, &ready, &mut selected));
    // rust: assert_eq!(selected, [parent.children()[0], parent]);
    // rust: for child in parent.children() {
    // rust: ready.insert(child, vec![]);
}
    // rust: selected.clear();
    // rust: assert!(plan.select(parent, &ready, &mut selected));
    // rust: assert_eq!(selected, parent.children());
}
pub fn a_shrunk_render_distance_keeps_columns_until_their_planned_tiles_are_ready() void {
}
        // Render distance 64 under LOD 64: every tile inside it is a level-0
        // stand-in for a covered column, and only the roots are sampled.
    // rust: let camera = [8, 8];
    // rust: let before = Plan::new(camera, 64, 64);
    // rust: let after = Plan::with_previous(camera, 8, 64, &before, 0, false, None);
    // rust: let mut ready: FxHashMap<TileKey, ()> = before
    // rust: .nodes
    // rust: .iter()
    // rust: .filter(|key| key.level == 0 || before.roots.contains(key))
    // rust: .map(|&key| (key, ()))
    // rust: .collect();
    // rust: ready.retain(|key, _| after.nodes.contains(key));
    // rust: let contains = |key: &TileKey, (x, z): (i32, i32)| {
    // rust: let [ox, _, oz] = key.origin();
    // rust: (ox..ox + key.size()).contains(&(x * 16)) && (oz..oz + key.size()).contains(&(z * 16))
}
        // 24 chunks out, now past the render distance: its planned tile was
        // split before, so never sampled. The ready root reaches the seam, so
        // it stands in for nothing: the column stays until its tile is in.
    // rust: let column = (24, 0);
    // rust: let mut selected = Vec::new();
    // rust: for &root in &after.roots {
    // rust: after.select(root, &ready, &mut selected);
}
    // rust: assert!(!selected.iter().any(|key| contains(key, column)));
    // rust: assert!(!after.replaces(column, &ready, |_| true));
    // rust: let planned = TileKey {
    // rust: x: 12,
    // rust: z: 0,
    // rust: level: 1,
}
    // rust: assert!(after.nodes.contains(&planned) && before.split.contains(&planned));
    // rust: ready.insert(planned, ());
    // rust: assert!(after.replaces(column, &ready, |_| true));
        // 12 chunks out, its level-0 tile is the stand-in until filled.
    // rust: assert!(!after.replaces((12, 0), &ready, |_| false));
    // rust: assert!(after.replaces((12, 0), &ready, |_| true));
        // Past the far terrain nothing waits.
    // rust: assert!(after.replaces((100, 0), &ready, |_| false));
}
pub fn detail_survives_movement_across_a_split_threshold() void {
}
    // rust: let before = Plan::new([0, 0], 2, 256);
    // rust: let after = Plan::with_previous([16, 0], 2, 256, &before, 0, false, None);
    // rust: let mut retained = 0;
    // rust: let range = i64::from(256 * 16);
    // rust: for key in &before.split {
    // rust: if key.distance([16, 0]) < key.size() * 10 && key.reach([16, 0]) <= range * range {
    // rust: assert!(after.split.contains(key));
    // rust: retained += 1;
}
}
    // rust: assert!(retained > 100);
    // rust: assert!(after.nodes.len() < 16000);
}
pub fn a_split_tile_stays_split_a_little_past_the_detail_ring() void {
}
        // Detail 40 puts the ring of full detail at 656 blocks, past where
        // level 2 tiles split by their width (8 * 64 = 512): the ring alone
        // splits this one, 640 blocks away.
    // rust: let tile = TileKey {
    // rust: x: 10,
    // rust: z: 0,
    // rust: level: 2,
}
    // rust: let before = Plan::new([0, 0], 40, 256);
    // rust: assert!(before.split.contains(&tile));
        // 670 blocks: past the ring, inside 5% of it.
    // rust: let held = Plan::with_previous([-30, 0], 40, 256, &before, 0, false, None);
    // rust: assert!(held.split.contains(&tile));
        // Not held without having been split: it was never in the ring.
    // rust: assert!(!Plan::new([-30, 0], 40, 256).split.contains(&tile));
        // 700 blocks: past the margin.
    // rust: let gone = Plan::with_previous([-60, 0], 40, 256, &before, 0, false, None);
    // rust: assert!(!gone.split.contains(&tile));
}
pub fn reduced_material_votes_ignore_light_and_retain_exposure() void {
}
    // rust: let mut columns: [Column; 256] = std::array::from_fn(|_| Column::default());
    // rust: for i in 0..16 {
    // rust: columns[(i / 4) * 16 + i % 4].spans.push(Span {
    // rust: min: 60,
    // rust: max: 64,
    // rust: state: BlockStateId(if i < 10 { 2 } else { 1 }),
    // rust: biome: 0,
    // rust: light: if i < 10 { (i as u16 + 6) << 4 } else { 0 },
    // rust: });
}
    // rust: let coarse = Column::reduced(&columns, 0, 0, 4);
    // rust: assert_eq!(coarse.spans.len(), 1);
    // rust: assert_eq!(
    // rust: coarse.spans[0].state,
    // rust: BlockStateId(2),
    // rust: "majority grass must beat dark dirt"
    // rust: );
    // rust: assert_eq!(coarse.spans[0].light, 240, "retain sampled sky exposure");
    // rust: for column in &mut columns {
    // rust: for span in &mut column.spans {
    // rust: span.light = 0;
}
}
    // rust: assert_eq!(
    // rust: Column::reduced(&columns, 0, 0, 4).spans[0].light,
    // rust: 0,
    // rust: "unlit caves stay unlit"
    // rust: );
    // rust: columns[0].spans[0].light = 7 << 12;
    // rust: assert_eq!(
    // rust: Column::reduced(&columns, 0, 0, 4).spans[0].light,
    // rust: 7 << 12,
    // rust: "block light does not invent skylight"
    // rust: );
}
pub fn nearly_full_blocks_are_kept() void {
}
    // rust: assert!(nearly_full("minecraft:powder_snow"));
    // rust: assert!(nearly_full("minecraft:dirt_path"));
    // rust: assert!(nearly_full("minecraft:oak_stairs"));
    // rust: assert!(nearly_full("minecraft:oak_fence"));
    // rust: assert!(!nearly_full("minecraft:wheat"));
}
pub fn kelp_to_the_surface_is_drawn_as_water() void {
}
        // 0 air, 1 stone, 2 water, 3 kelp (holds water, draws as none).
    // rust: let kinds = [AIR, KEPT, KEPT | FLUID, KEPT | FLUID | WATERY];
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for x in [3, 4] {
    // rust: for y in MIN_Y..40 {
    // rust: chunk.set(x, y, 3, 1);
}
}
    // rust: for y in 40..63 {
    // rust: chunk.set(3, y, 3, 3);
    // rust: chunk.set(4, y, 3, 2);
}
    // rust: let water = water_source(&kinds);
    // rust: assert_eq!(water, Some(BlockStateId(2)));
    // rust: let kelp = Column::from_chunk(&chunk, &kinds, water, 3, 3);
    // rust: let sea = Column::from_chunk(&chunk, &kinds, water, 4, 3);
    // rust: assert_eq!(kelp.spans, sea.spans);
    // rust: assert_eq!(
    // rust: kelp.spans.last().map(|s| (s.min, s.max, s.state)),
    // rust: Some((40, 63, BlockStateId(2)))
    // rust: );
    // rust: assert_eq!(kelp.surface.unwrap().water, Some((63, BlockStateId(2))));
    // rust: assert_eq!(kelp.surface.unwrap().height, 40);
}
pub fn coarse_voxels_keep_what_any_column_holds_so_crowns_stay_on_trunks() void {
}
    // rust: let span = |min, max, state| Span {
    // rust: min,
    // rust: max,
    // rust: state: BlockStateId(state),
    // rust: biome: 0,
    // rust: light: 240,
}
    // rust: let mut columns = std::array::from_fn(|_| Column {
    // rust: surface: None,
    // rust: spans: vec![span(0, 4, 1)].into(),
    // rust: });
        // One trunk column under a crown over the whole footprint.
    // rust: columns[0].spans.push(span(4, 12, 2));
    // rust: for z in 0..4 {
    // rust: for x in 0..4 {
    // rust: columns[z * 16 + x].spans.push(span(12, 14, 3));
}
}
    // rust: assert_eq!(
    // rust: Column::reduced(&columns, 0, 0, 4).spans,
    // rust: [span(0, 4, 1), span(4, 12, 2), span(12, 14, 3)]
    // rust: );
    // rust: assert_eq!(Column::reduced(&columns, 0, 0, 1), columns[0]);
    // rust: let reduced = ReducedColumns::new(Arc::new(columns));
    // rust: assert_eq!(
    // rust: reduced.get(0, 0, 4).spans,
    // rust: [span(0, 4, 1), span(4, 12, 2), span(12, 14, 3)]
    // rust: );
    // rust: assert_eq!(reduced.get(4, 8, 4).spans, [span(0, 4, 1)]);
    // rust: assert_eq!(
    // rust: reduced.get(0, 0, 16).spans,
    // rust: [span(0, 4, 1), span(4, 12, 2), span(12, 14, 3)],
    // rust: "a crown over one corner of a wide cell still sits on its trunk"
    // rust: );
}
    /// A chunk is reduced to the one cell width that reads it, when it does.
    ///
    /// Reducing to all four widths up front cost 405 us of a far terrain
    /// thread for every chunk the world sent, where at most one is read.
pub fn a_chunk_is_reduced_only_to_the_width_that_reads_it() void {
}
    // rust: let built = |reduced: &ReducedColumns| {
    // rust: reduced
    // rust: .levels
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, level)| level.get().is_some())
    // rust: .map(|(level, _)| 2usize << level)
    // rust: .collect::<Vec<_>>()
}
    // rust: let reduced = ReducedColumns::new(Arc::new(std::array::from_fn(|i| Column {
    // rust: surface: None,
    // rust: spans: vec![Span {
    // rust: min: 0,
    // rust: max: 4 + (i % 3) as i16,
    // rust: state: BlockStateId(1),
    // rust: biome: 0,
    // rust: light: 240,
    // rust: }]
    // rust: .into(),
    // rust: })));
    // rust: assert!(built(&reduced).is_empty(), "nothing is reduced unread");
        // A tile of full-detail cells reads the chunk's own columns.
    // rust: reduced.get(3, 5, 1);
    // rust: assert!(built(&reduced).is_empty());
    // rust: reduced.get(4, 8, 4);
    // rust: assert_eq!(built(&reduced), [4]);
        // Read again, and the reduction is the one already built.
    // rust: reduced.get(0, 0, 4);
    // rust: assert_eq!(built(&reduced), [4]);
    // rust: reduced.get(0, 0, 16);
    // rust: assert_eq!(built(&reduced), [4, 16]);
}
    /// A summary past a frame's budget waits for a later frame rather than
    /// being dropped, and no new detail is asked for while any waits.
    ///
    /// Without the second part the backlog grew by a `DETAIL_REQUEST` every
    /// 250 ms and never drained: a chunk whose summary is still waiting has
    /// its detail mask clear, so it was asked for again and the cache
    /// answered at once. That measured 0.5 FPS, `update` averaging 9.7 s.
pub fn a_summary_past_the_budget_waits_and_holds_back_the_next_request() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let chunk = (3, 5);
    // rust: let columns = || ReducedColumns::new(Arc::new(std::array::from_fn(|_| Column::default())));

        // Within budget and with nothing waiting, a summary applies at once.
    // rust: lod.take_summary(Summary::Observed(chunk, columns()), true);
    // rust: assert!(lod.detail_backlog.is_empty(), "applied, not deferred");
    // rust: assert!(lod.saved.contains_key(&chunk), "and it reached `saved`");

        // Past the budget it waits, and anything after it waits behind it so
        // a chunk's detail cannot overtake a chunk that arrived earlier.
    // rust: lod.take_summary(Summary::Observed((9, 9), columns()), false);
    // rust: lod.take_summary(Summary::Observed((10, 9), columns()), true);
    // rust: assert_eq!(
    // rust: lod.detail_backlog.len(),
    // rust: 2,
    // rust: "the second waits behind the first"
    // rust: );
    // rust: assert!(!lod.saved.contains_key(&(9, 9)));

        // Nothing new is asked for while summaries wait, whatever the
        // request interval allows. Asserted on `detail_request_at`, which
        // `request_detail` records once it is past its guards: a test
        // scheduler has no active tile wanting detail, so `pending` would
        // stay false either way and prove nothing.
    // rust: let long_ago = std::time::Instant::now() - std::time::Duration::from_secs(10);
    // rust: lod.detail_request_at = long_ago;
    // rust: lod.detail_request_pending = false;
    // rust: lod.request_detail([0, 0]);
    // rust: assert_eq!(lod.detail_request_at, long_ago, "held back by the backlog");

        // A later frame applies what waited, in the order it arrived.
    // rust: while let Some(summary) = lod.detail_backlog.pop_front() {
    // rust: lod.apply_summary(summary);
}
    // rust: assert!(lod.saved.contains_key(&(9, 9)), "nothing was dropped");
    // rust: assert!(lod.saved.contains_key(&(10, 9)));

        // Drained, requests resume.
    // rust: lod.detail_request_at = long_ago;
    // rust: lod.request_detail([0, 0]);
    // rust: assert!(
    // rust: lod.detail_request_at > long_ago,
    // rust: "asked once the backlog drained"
    // rust: );
}
    /// `warm` builds exactly the levels asked for, off the render thread, and
    /// `get` then finds them built.
pub fn warming_builds_the_levels_asked_for_and_no_others() void {
}
    // rust: let built = |reduced: &ReducedColumns| {
    // rust: reduced
    // rust: .levels
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, level)| level.get().is_some())
    // rust: .map(|(level, _)| 2usize << level)
    // rust: .collect::<Vec<_>>()
}
    // rust: let chunk = || {
    // rust: Arc::new(std::array::from_fn::<Column, 256, _>(|i| Column {
    // rust: surface: None,
    // rust: spans: vec![Span {
    // rust: min: 0,
    // rust: max: 4 + (i % 3) as i16,
    // rust: state: BlockStateId(1),
    // rust: biome: 0,
    // rust: light: 240,
    // rust: }]
    // rust: .into(),
    // rust: }))
}
        // No bits: nothing is built, as before.
    // rust: assert!(built(&ReducedColumns::new(chunk()).warm(0)).is_empty());
        // Widths 2 and 8 are levels 0 and 2.
    // rust: let warmed = ReducedColumns::new(chunk()).warm(0b101);
    // rust: assert_eq!(built(&warmed), [2, 8]);
        // Reading a warmed width builds nothing more; an unwarmed one does.
    // rust: warmed.get(0, 0, 2);
    // rust: warmed.get(6, 6, 8);
    // rust: assert_eq!(built(&warmed), [2, 8], "already built");
    // rust: warmed.get(0, 0, 4);
    // rust: assert_eq!(built(&warmed), [2, 4, 8]);
        // Warming is the same reduction as reading would have made.
    // rust: let lazy = ReducedColumns::new(chunk());
    // rust: for (x, z, width) in [(0, 0, 2), (6, 6, 8), (4, 8, 4), (0, 0, 16)] {
    // rust: assert_eq!(
    // rust: warmed.get(x, z, width),
    // rust: lazy.get(x, z, width),
    // rust: "width {width} at {x},{z}"
    // rust: );
}
}
    /// Applying a chunk's detail records the cell widths it read, so the far
    /// terrain thread reduces them before it sends the next chunk.
pub fn applying_detail_records_the_widths_it_read() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: assert_eq!(lod.shared.detail_widths.load(Ordering::Relaxed), 0);
    // rust: let chunk = (0, 0);
    // rust: let columns = || ReducedColumns::new(Arc::new(std::array::from_fn(|_| Column::default())));
        // Only tiles in `ready` are read. A level-0 tile has cells one block
        // wide, which is the chunk's own columns: no reduction, no bit.
    // rust: lod.ready.insert(
    // rust: TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
    // rust: },
    // rust: Arc::new(vec![Column::default(); CELLS * CELLS]),
    // rust: );
    // rust: lod.apply_detail(chunk, &columns());
    // rust: assert_eq!(
    // rust: lod.shared.detail_widths.load(Ordering::Relaxed),
    // rust: 0,
    // rust: "full-detail cells read the chunk itself"
    // rust: );
        // A level-2 tile has cells 4 blocks wide: reduction level 1.
    // rust: lod.ready.insert(
    // rust: TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 2,
    // rust: },
    // rust: Arc::new(vec![Column::default(); CELLS * CELLS]),
    // rust: );
    // rust: lod.apply_detail(chunk, &columns());
    // rust: assert_eq!(lod.shared.detail_widths.load(Ordering::Relaxed), 0b10);
}
    /// Detail read before a refresh over its chunk is dropped (asked
    /// again); elsewhere, or read after, it is kept.
pub fn only_detail_a_later_refresh_covers_is_dropped() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let asked = lod.refreshes;
    // rust: lod.refresh([0, 0, 64, 64], (1, 16));
    // rust: assert!(lod.refreshed_since((1, 1), asked));
    // rust: assert!(lod.refreshed_since((4, 0), asked), "a chunk around");
    // rust: assert!(!lod.refreshed_since((40, 40), asked), "elsewhere");
    // rust: assert!(!lod.refreshed_since((1, 1), lod.refreshes), "read after");
    // rust: for _ in 0..MAX_REFRESHED {
    // rust: lod.refresh([10_000, 10_000, 10_064, 10_064], (1, 16));
}
    // rust: assert!(lod.refreshed_since((40, 40), asked), "too old to tell");
}
pub fn refreshed_areas_forget_detail_but_seen_chunks() void {
}
    // rust: let key = TileKey {
    // rust: x: 1,
    // rust: z: 0,
    // rust: level: 1,
}
    // rust: assert!(key.overlaps([40, 0, 50, 1]) && !key.overlaps([64, 0, 80, 32]));
        // Only cells of the widths the new data is drawn in, a cell around.
    // rust: assert!(key.refreshed_by([64, 0, 80, 32], (1, 16)));
    // rust: assert!(!key.refreshed_by([65, 0, 80, 32], (1, 16)));
    // rust: assert!(!key.refreshed_by([40, 0, 50, 1], (25, i32::MAX)));
    // rust: let root = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: MAX_LEVEL,
}
    // rust: assert!(!root.refreshed_by([40, 0, 72, 32], (1, 16)));
    // rust: assert!(root.refreshed_by([0, 0, 800, 800], (25, i32::MAX)));
        // Level 1: 2 × 2 cells a chunk, chunks 2..4 × 0..2.
    // rust: let mut mask = [u64::MAX; 4];
    // rust: forget_detail(key, [48, 0, 64, 16], &mut mask, |_| false);
    // rust: let cleared: Vec<_> = (0..256)
    // rust: .filter(|i| mask[i / 64] & (1 << (i % 64)) == 0)
    // rust: .collect();
    // rust: assert_eq!(cleared.len(), 64);
    // rust: assert!(cleared.contains(&8) && cleared.contains(&(7 * 16 + 15)));
    // rust: let mut mask = [u64::MAX; 4];
    // rust: forget_detail(key, [0, 0, 1024, 1024], &mut mask, |chunk| chunk == (2, 1));
    // rust: assert_eq!(mask.iter().map(|m| m.count_ones()).sum::<u32>(), 64);
}
pub fn tiles_sampled_without_a_kept_chunk_are_sampled_again() void {
}
    // rust: let tile = |level: u8| {
    // rust: let size = 16 << level;
    // rust: TileKey {
    // rust: x: (3 * 16i32).div_euclid(size),
    // rust: z: (-5 * 16i32).div_euclid(size),
    // rust: level,
}
}
    // rust: let empty = || Arc::new(vec![Column::default(); CELLS * CELLS]);
    // rust: let filled = || {
    // rust: let column = Column {
    // rust: surface: None,
    // rust: spans: vec![Span {
    // rust: min: -64,
    // rust: max: 70,
    // rust: state: BlockStateId(1),
    // rust: biome: 0,
    // rust: light: 0,
    // rust: }]
    // rust: .into(),
}
    // rust: Arc::new(vec![column; CELLS * CELLS])
}
    // rust: let mut ready = FxHashMap::default();
    // rust: let mut pending = FxHashSet::default();
        // Cells of a chunk or less take its detail; wider ones sampled empty
        // there are sampled again, and filled ones aren't.
    // rust: ready.insert(tile(2), empty());
    // rust: ready.insert(tile(5), empty());
    // rust: ready.insert(tile(6), filled());
    // rust: assert_eq!(resampled_over(&ready, &pending, (3, -5)), [tile(5)]);
        // Samples in flight may predate it: those that detail can't patch.
    // rust: pending.extend([tile(1), tile(2), tile(6), tile(7)]);
    // rust: assert_eq!(
    // rust: resampled_over(&ready, &pending, (3, -5)),
    // rust: [tile(1), tile(5), tile(6), tile(7)]
    // rust: );
    // rust: assert!(resampled_over(&ready, &FxHashSet::default(), (40, 40)).is_empty());
}
pub fn real_mesh_clips_near_chunks_and_preserves_water_and_edited_surfaces() c {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::{
    // rust: assets::Assets, biome::Biomes, light::LightTables, mesher::MeshTables,
    // rust: testgen::TestTerrain,
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES"),
    // rust: );
    // rust: let assets = Arc::new(Assets::load(&root)?);
    // rust: let render = Arc::new(assets.reload(&root)?);
    // rust: let facts = BlockFacts::load(&root, assets.registry)?;
    // rust: let biomes = Arc::new(Biomes::load(&root)?);
    // rust: let tables = Arc::new(MeshTables::new(
    // rust: &assets,
    // rust: &render,
    // rust: &facts,
    // rust: crate::models::load_visibility(&root, assets.registry)?,
    // rust: )?);
    // rust: let context = Arc::new(WorkerContext {
    // rust: light: Arc::new(LightTables::load(&root, assets.registry, &facts)?),
    // rust: tables,
    // rust: assets: assets.clone(),
    // rust: render,
    // rust: biomes: biomes.clone(),
    // rust: });
    // rust: let source = Arc::new(TestTerrain::new(assets.registry, &biomes)?);
    // rust: let mut lod = Lod::new(source, context);
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let key = TileKey {
    // rust: x: -1,
    // rust: z: -1,
    // rust: level: 5,
}
    // rust: lod.ready.insert(
    // rust: key,
    // rust: Arc::new(vec![
    // rust: Column::from_surface(Some(Surface {
    // rust: height: 70,
    // rust: state: stone,
    // rust: water: Some((80, water)),
    // rust: biome: biomes.id("minecraft:plains"),
    // rust: }));
    // rust: CELLS * CELLS
    // rust: ]),
    // rust: );
        // A chunk covers only one quarter of this parent's 32² cell. Both
        // opaque terrain and water must leave precisely that 16² footprint.
        // Only active tiles enter the mesher snapshot, even when samples are ready.
    // rust: lod.active.insert(key);
    // rust: lod.covered.insert((-1, -2));
    // rust: lod.covered_bounds = Some([-16, -32, 0, -16]);
    // rust: let mesh = lod.mesh(key);
    // rust: lod.active.remove(&key);
    // rust: let top_area = |vertices: &[TerrainVertex], y: f32| {
    // rust: vertices
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|quad| quad.iter().all(|v| (v.pos[1] - y).abs() < 0.001))
    // rust: .map(|quad| {
    // rust: let a = glam::Vec3::from(quad[0].pos);
    // rust: let b = glam::Vec3::from(quad[1].pos);
    // rust: let c = glam::Vec3::from(quad[2].pos);
    // rust: let normal = (b - a).cross(c - a);
    // rust: assert!(normal.y > 0.0, "surface must face the camera from above");
    // rust: let center = (a + c) * 0.5;
    // rust: let [ox, _, oz] = key.origin();
    // rust: let chunk = (
    // rust: ((center.x as i32) + ox).div_euclid(16),
    // rust: ((center.z as i32) + oz).div_euclid(16),
    // rust: );
    // rust: assert!(
    // rust: !lod.covered.contains(&chunk),
    // rust: "LOD overlaps a full-detail chunk"
    // rust: );
    // rust: normal.y
    // rust: })
    // rust: .sum::<f32>()
}
    // rust: let expected = (key.size() * key.size() - 16 * 16) as f32;
    // rust: assert_eq!(top_area(&mesh.solid, 70.0), expected);
    // rust: assert_eq!(top_area(&mesh.translucent, 80.0 - 1.0 / 9.0), expected);
    // rust: assert!(mesh.translucent.iter().all(|v| v.light == 240));
    // rust: let side = |axis: usize, plane: f32, low: f32, high: f32| {
    // rust: let other = if axis == 0 { 2 } else { 0 };
    // rust: mesh.solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|quad| {
    // rust: quad.iter().all(|v| v.pos[axis] == plane)
    // rust: && quad.iter().map(|v| v.pos[1]).fold(f32::INFINITY, f32::min)
    // rust: == MIN_Y as f32
    // rust: && quad
    // rust: .iter()
    // rust: .map(|v| v.pos[1])
    // rust: .fold(f32::NEG_INFINITY, f32::max)
    // rust: == 70.0
    // rust: && quad
    // rust: .iter()
    // rust: .map(|v| v.pos[other])
    // rust: .fold(f32::INFINITY, f32::min)
    // rust: == low
    // rust: && quad
    // rust: .iter()
    // rust: .map(|v| v.pos[other])
    // rust: .fold(f32::NEG_INFINITY, f32::max)
    // rust: == high
    // rust: })
    // rust: .map(move |quad| {
    // rust: let a = glam::Vec3::from(quad[0].pos);
    // rust: (glam::Vec3::from(quad[1].pos) - a).cross(glam::Vec3::from(quad[2].pos) - a)
    // rust: [axis]
    // rust: })
    // rust: .collect::<Vec<_>>()
}
        // The two exposed edges face the missing full-detail chunk and seal
        // the height mismatch all the way down. Shared subpieces add no walls.
    // rust: let east_cut = side(0, 496.0, 480.0, 496.0);
    // rust: assert_eq!(east_cut.len(), 1);
    // rust: assert!(east_cut[0] > 0.0);
    // rust: let north_cut = side(2, 496.0, 496.0, 512.0);
    // rust: assert_eq!(north_cut.len(), 1);
    // rust: assert!(north_cut[0] < 0.0);
    // rust: assert!(side(0, 496.0, 496.0, 512.0).is_empty());

        // Block edits do not refresh Chunk.heights; observation must scan the
        // actual blocks, including builds above the old heightmap. The worker
        // summarizes the chunk; its result is kept on receipt.
    // rust: let receive_observed = |lod: &mut Lod| {
    // rust: let Done::Observed(key, columns) = lod
    // rust: .results
    // rust: .recv_timeout(std::time::Duration::from_secs(5))
    // rust: .unwrap()
    // rust: else {
    // rust: panic!("expected the observed chunk's summary");
}
    // rust: lod.finish_observed(key, columns);
}
    // rust: let mut chunk = Chunk::empty(-1, -1);
    // rust: chunk.set(0, 120, 0, stone.0);
    // rust: chunk.set(4, 54, 4, stone.0);
    // rust: for y in 55..64 {
    // rust: chunk.set(4, y, 4, water.0);
}
        // Chorus is thin and non-solid but must survive the visit summary.
    // rust: let end_stone = assets
    // rust: .registry
    // rust: .default_state("minecraft:end_stone")
    // rust: .unwrap();
    // rust: let chorus = assets
    // rust: .registry
    // rust: .default_state("minecraft:chorus_plant")
    // rust: .unwrap();
    // rust: let flower = assets
    // rust: .registry
    // rust: .default_state("minecraft:chorus_flower")
    // rust: .unwrap();
    // rust: chunk.set(8, 70, 8, end_stone.0);
    // rust: chunk.set(8, 71, 8, chorus.0);
    // rust: chunk.set(8, 72, 8, chorus.0);
    // rust: chunk.set(8, 73, 8, flower.0);
        // Kelp to the surface is water; powder snow and a waterlogged stair
        // are kept as themselves.
    // rust: let state = |name: &str| assets.registry.default_state(name).unwrap();
    // rust: let (kelp, powder_snow) = (state("minecraft:kelp"), state("minecraft:powder_snow"));
    // rust: let stair = facts
    // rust: .states
    // rust: .iter()
    // rust: .position(|f| &*f.name == "minecraft:oak_stairs" && f.waterlogged)
    // rust: .map(|i| BlockStateId(i as u32))
    // rust: .unwrap();
    // rust: chunk.set(2, 54, 2, stone.0);
    // rust: for y in 55..64 {
    // rust: chunk.set(2, y, 2, kelp.0);
}
    // rust: chunk.set(6, 90, 6, stone.0);
    // rust: chunk.set(6, 91, 6, powder_snow.0);
    // rust: chunk.set(10, 54, 10, stone.0);
    // rust: chunk.set(10, 55, 10, stair.0);
    // rust: lod.observe(Arc::new(chunk.clone()), &facts);
    // rust: receive_observed(&mut lod);
    // rust: let observed = &lod.saved[&(-1, -1)];
    // rust: assert_eq!(observed[0].surface.unwrap().height, 121);
    // rust: assert_eq!(observed[0].surface.unwrap().state, stone);
    // rust: assert_eq!(observed[68].surface.unwrap().height, 55);
    // rust: assert_eq!(observed[68].surface.unwrap().water, Some((64, water)));
    // rust: let chorus_column = &observed[8 * 16 + 8];
    // rust: assert_eq!(chorus_column.surface.unwrap().state, flower);
    // rust: assert_eq!(
    // rust: chorus_column
    // rust: .spans
    // rust: .iter()
    // rust: .map(|span| (span.min, span.max, span.state))
    // rust: .collect::<Vec<_>>(),
    // rust: vec![(70, 71, end_stone), (71, 73, chorus), (73, 74, flower)]
    // rust: );
    // rust: let kelp_column = &observed[2 * 16 + 2];
    // rust: assert_eq!(kelp_column.surface.unwrap().height, 55);
    // rust: assert_eq!(kelp_column.surface.unwrap().water, Some((64, water)));
    // rust: assert_eq!(observed[6 * 16 + 6].surface.unwrap().state, powder_snow);
    // rust: assert_eq!(observed[6 * 16 + 6].surface.unwrap().height, 92);
    // rust: assert_eq!(observed[10 * 16 + 10].surface.unwrap().state, stair);

    // rust: let fine = TileKey {
    // rust: x: -1,
    // rust: z: -1,
    // rust: level: 0,
}
    // rust: lod.ready
    // rust: .insert(fine, Arc::new(vec![Column::default(); 256]));
    // rust: lod.finish_detail(
    // rust: (-1, -1),
    // rust: ReducedColumns::new(Arc::new(std::array::from_fn(|_| Column::default()))),
    // rust: );
    // rust: assert_eq!(
    // rust: lod.ready[&fine][0].surface.unwrap().height,
    // rust: 121,
    // rust: "late seed generation cannot overwrite a visited build"
    // rust: );
    // rust: assert_eq!(lod.detail_masks[&fine], [u64::MAX; 4]);
    // rust: lod.plan.nodes.insert(fine);
    // rust: lod.pending.insert(fine);
    // rust: lod.finish_sample(fine, vec![Column::default(); 256]);
    // rust: assert_eq!(
    // rust: lod.ready[&fine][0].surface.unwrap().height,
    // rust: 121,
    // rust: "a late coarse sampling job cannot erase completed detail"
    // rust: );
    // rust: assert_eq!(lod.detail_masks[&fine], [u64::MAX; 4]);
    // rust: lod.plan.nodes.remove(&fine);

        // The worker's summary comes with the reusable pyramid; a newer
        // observation replaces both, and an unchanged one changes nothing.
    // rust: assert!(Arc::ptr_eq(
    // rust: &lod.reduced[&(-1, -1)].columns,
    // rust: &lod.saved[&(-1, -1)]
    // rust: ));
    // rust: let reduced_spans = |lod: &Lod| {
    // rust: lod.snapshot()
    // rust: .visited_source(-16, -16, 2)
    // rust: .unwrap()
    // rust: .get()
    // rust: .spans
    // rust: .iter()
    // rust: .map(|span| (span.min, span.max, span.state))
    // rust: .collect::<Vec<_>>()
}
        // Reduction keeps a block held by any column of the footprint, so
        // this single-column build survives the cached two-block reduction.
    // rust: assert_eq!(reduced_spans(&lod), vec![(120, 121, stone)]);
    // rust: let old = lod.saved[&(-1, -1)].clone();
    // rust: lod.observe(Arc::new(chunk.clone()), &facts);
    // rust: receive_observed(&mut lod);
    // rust: assert!(Arc::ptr_eq(&lod.saved[&(-1, -1)], &old));
    // rust: chunk.set(0, 130, 0, stone.0);
    // rust: lod.observe(Arc::new(chunk.clone()), &facts);
    // rust: receive_observed(&mut lod);
    // rust: assert_eq!(lod.ready[&fine][0].surface.unwrap().height, 131);
    // rust: assert!(Arc::ptr_eq(
    // rust: &lod.reduced[&(-1, -1)].columns,
    // rust: &lod.saved[&(-1, -1)]
    // rust: ));
    // rust: assert_eq!(
    // rust: reduced_spans(&lod),
    // rust: vec![(120, 121, stone), (130, 131, stone)]
    // rust: );
        // A seed reduction arriving after the edit cannot restore old data.
    // rust: lod.finish_detail((-1, -1), ReducedColumns::new(old));
    // rust: assert_eq!(lod.ready[&fine][0].surface.unwrap().height, 131);
    // rust: assert_eq!(
    // rust: reduced_spans(&lod),
    // rust: vec![(120, 121, stone), (130, 131, stone)]
    // rust: );

        // Exercise the actual worker/update seam: a parent stays displayed
        // until all four child meshes have arrived, possibly over several updates.
    // rust: let camera = [-256.0, 100.0, -256.0];
    // rust: lod.area = Some(([-16, -16], 2, 64, 0, false, None));
    // rust: lod.plan.roots = vec![key];
    // rust: lod.plan.nodes.insert(key);
        // As a replan does (`update` only selects after a change).
    // rust: lod.reselect = true;
    // rust: let await_meshes = |lod: &mut Lod, count: usize| {
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(5);
    // rust: let mut uploaded = Vec::new();
    // rust: loop {
    // rust: uploaded.extend(lod.update(camera, 2, 64, None, None));
    // rust: if uploaded.len() >= count {
    // rust: return uploaded;
}
    // rust: assert!(
    // rust: lod.removed().is_empty(),
    // rust: "retired before replacement meshes"
    // rust: );
    // rust: assert!(std::time::Instant::now() < deadline, "mesh worker stalled");
    // rust: std::thread::sleep(std::time::Duration::from_millis(1));
}
}
    // rust: let uploaded = await_meshes(&mut lod, 1);
    // rust: assert_eq!(uploaded.len(), 1);
    // rust: assert_eq!(uploaded[0].0, key);
    // rust: assert!(lod.active.contains(&key));
    // rust: lod.plan.split.insert(key);
    // rust: for child in key.children() {
    // rust: lod.plan.nodes.insert(child);
    // rust: lod.ready.insert(child, lod.ready[&key].clone());
}
    // rust: lod.reselect = true;
    // rust: let uploaded = await_meshes(&mut lod, 4);
    // rust: assert_eq!(uploaded.len(), 4);
    // rust: assert!(
    // rust: key.children()
    // rust: .iter()
    // rust: .all(|child| lod.active.contains(child))
    // rust: );
    // rust: assert_eq!(lod.removed(), [key]);

    // rust: let covered_fine = TileKey {
    // rust: x: -1,
    // rust: z: -2,
    // rust: level: 0,
}
    // rust: lod.plan = Plan::default();
    // rust: lod.plan.roots.push(covered_fine);
    // rust: lod.plan.nodes.insert(covered_fine);
    // rust: lod.ready
    // rust: .insert(covered_fine, Arc::new(vec![Column::default(); 256]));
    // rust: lod.covered.insert((-1, -2));
    // rust: lod.reselect = true;
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(5);
    // rust: loop {
    // rust: lod.update(camera, 2, 64, None, None);
    // rust: if lod.outstanding_meshes == 0 && lod.active.is_empty() {
    // rust: break;
}
    // rust: assert!(
    // rust: std::time::Instant::now() < deadline,
    // rust: "covered normal chunk remained an active LOD mask"
    // rust: );
    // rust: std::thread::sleep(std::time::Duration::from_millis(1));
}
    // rust: assert_eq!(lod.progress(), (1, 1));

        // Keep one sample outstanding, as on ordinary frames. Completing just
        // one job at a time must still let both loading queues make progress.
    // rust: lod.shared.stop.store(true, Ordering::Relaxed);
    // rust: lod.shared.wake.notify_all();
    // rust: lod.thread.take().unwrap().join().unwrap();
    // rust: while lod.results.try_recv().is_ok() {}
    // rust: lod.shared.jobs.lock().unwrap().clear();
    // rust: lod.plan = Plan::new([-256, -256], 2, 64);
    // rust: let parent = TileKey {
    // rust: x: -2,
    // rust: z: -2,
    // rust: level: 3,
}
    // rust: lod.plan.roots = vec![parent];
    // rust: lod.ready.clear();
    // rust: lod.ready
    // rust: .insert(parent, Arc::new(vec![Column::default(); 256]));
    // rust: lod.active = [parent].into_iter().collect();
    // rust: lod.sample_jobs = SAMPLE_JOBS;
    // rust: lod.pending = (0..SAMPLE_JOBS - 1)
    // rust: .map(|i| TileKey {
    // rust: x: 999 + i as i32,
    // rust: z: 999,
    // rust: level: 0,
    // rust: })
    // rust: .collect();
    // rust: lod.detail_request_pending = true;
    // rust: lod.wanted_stale = true;
    // rust: lod.update(camera, 2, 64, Some(FxHashSet::default()), None);
    // rust: let Some(Job::Sample(nearby)) = lod.shared.jobs.lock().unwrap().pop_front() else {
    // rust: panic!("nearby detail was not scheduled");
}
    // rust: assert_eq!(nearby.level, 0);
    // rust: assert_eq!(
    // rust: nearby.distance([-256, -256]),
    // rust: 0,
    // rust: "the nearest tiles load first"
    // rust: );
    // rust: lod.finish_sample(nearby, vec![Column::default(); 256]);
    // rust: lod.update(camera, 2, 64, Some(FxHashSet::default()), None);
    // rust: let Some(Job::Sample(next)) = lod.shared.jobs.lock().unwrap().pop_front() else {
    // rust: panic!("the next ring was not scheduled");
}
    // rust: assert!(
    // rust: !lod.plan.split.contains(&next) && next.distance([-256, -256]) <= 64,
    // rust: "the next nearest final tile, never a coarse one under it: {next:?}"
    // rust: );
    // rust: lod.shared.jobs.lock().unwrap().clear();
    // rust: let near = TileKey {
    // rust: x: -4,
    // rust: z: -4,
    // rust: level: 2,
}
    // rust: let far = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 6,
}
    // rust: lod.plan = Plan::default();
    // rust: lod.plan.roots = vec![near, far];
    // rust: lod.ready.clear();
    // rust: for parent in [near, far] {
    // rust: lod.plan.nodes.insert(parent);
    // rust: lod.plan.split.insert(parent);
    // rust: lod.plan.nodes.extend(parent.children());
    // rust: lod.ready
    // rust: .insert(parent, Arc::new(vec![Column::default(); 256]));
}
    // rust: lod.active = [near, far].into_iter().collect();
    // rust: lod.wanted_stale = true;
    // rust: lod.shared.jobs.lock().unwrap().clear();
    // rust: lod.sample_jobs = SAMPLE_JOBS;
    // rust: lod.pending = (0..SAMPLE_JOBS - 1)
    // rust: .map(|i| TileKey {
    // rust: x: 999 + i as i32,
    // rust: z: 999,
    // rust: level: 0,
    // rust: })
    // rust: .collect();
    // rust: lod.update(camera, 2, 64, Some(FxHashSet::default()), None);
    // rust: let Some(Job::Sample(first)) = lod.shared.jobs.lock().unwrap().pop_front() else {
    // rust: panic!("no final tile scheduled")
}
    // rust: assert_eq!(
    // rust: (first.level, first.parent()),
    // rust: (1, near),
    // rust: "the nearest parent's final tiles come first"
    // rust: );
    // rust: lod.shared.jobs.lock().unwrap().clear();
    // rust: lod.active = (0..DETAIL_REQUEST as i32 + 8)
    // rust: .map(|x| TileKey { x, z: 0, level: 0 })
    // rust: .collect();
    // rust: lod.plan.split.clear();
    // rust: lod.detail_masks.clear();
    // rust: lod.covered = [(0, 0)].into_iter().collect();
    // rust: lod.full = lod.covered.clone();
    // rust: lod.detail_request_pending = false;
    // rust: lod.detail_request_at = std::time::Instant::now() - std::time::Duration::from_secs(1);
    // rust: lod.request_detail([0, 0]);
    // rust: let Some(Job::RequestDetail { chunks, .. }) = lod.shared.jobs.lock().unwrap().pop_front()
    // rust: else {
    // rust: panic!("detail batch was not requested");
}
    // rust: assert_eq!(
    // rust: chunks,
    // rust: (1..=DETAIL_REQUEST as i32)
    // rust: .map(|x| (x, 0))
    // rust: .collect::<Vec<_>>(),
    // rust: "one unfinished fine tile must not starve neighbouring requests"
    // rust: );

        // The extra sampling threads' slots open once the near terrain is in.
    // rust: lod.small = false;
    // rust: lod.sample_jobs = SAMPLE_JOBS + 3;
    // rust: lod.plan = Plan::new([-256, -256], 2, 64);
    // rust: lod.ready.clear();
    // rust: lod.active.clear();
    // rust: lod.pending.clear();
    // rust: lod.shared.jobs.lock().unwrap().clear();
    // rust: let queued = |lod: &mut Lod, near_loading: bool| {
    // rust: lod.set_near_loading(near_loading);
    // rust: lod.shared.jobs.lock().unwrap().clear();
    // rust: lod.pending.clear();
    // rust: lod.wanted_stale = true;
    // rust: lod.update([-256., 64., -256.], 2, 64, Some(FxHashSet::default()), None);
    // rust: let jobs = lod.shared.jobs.lock().unwrap();
    // rust: jobs.iter()
    // rust: .filter(|job| matches!(job, Job::Sample(_)))
    // rust: .count()
}
    // rust: assert_eq!(queued(&mut lod, true), SAMPLE_JOBS);
    // rust: assert_eq!(queued(&mut lod, false), SAMPLE_JOBS + 3);
    // rust: Ok(())
}

pub fn far_cells_past_render_distance_12_start_one_block_wide() void {
}
        // Leaves' cells: 1 block to 256 blocks out, 2 to 512 (Full); Reduced
        // keeps 1 to the near terrain's edge and 2 to 256.
    // rust: for (reduced, [one, two]) in [(false, [256, 512]), (true, [208, 256])] {
    // rust: let plan = Plan::with_previous([8, 8], 12, 128, &Plan::default(), 0, reduced, None);
    // rust: for key in plan.nodes.iter().filter(|key| !plan.split.contains(key)) {
    // rust: let distance = key.distance([8, 8]);
    // rust: if distance < one {
    // rust: assert_eq!(key.size() / 16, 1, "{key:?} reduced {reduced}");
    // rust: } else if distance < two {
    // rust: assert!(key.size() / 16 <= 2, "{key:?} reduced {reduced}");
}
}
}
}
    /// Loads a render distance 12 view one sample job at a time, in
    /// `wanted_tiles`' order. Counts the jobs, and their density lattice
    /// points (each job's cost), before every far column within two chunks
    /// of the near terrain is drawn as finely as the plan wants it (one
    /// block wide in Full): until then nothing is drawn there. And before
    /// every far column is drawn, by its tile or a coarse stand-in: until
    /// then the far terrain ends short of the horizon. Checks that no coarse
    /// tile is ever drawn at the seam.
pub fn jobs_until_fine_seam(camera: [i32; 2], reduced: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (detail, distance) = (12, 128);
    // rust: let center = (camera[0].div_euclid(16), camera[1].div_euclid(16));
    // rust: let mut covered = FxHashSet::default();
    // rust: for z in center.1 - detail..=center.1 + detail {
    // rust: for x in center.0 - detail..=center.0 + detail {
    // rust: if crate::streaming::in_view_distance(center, detail, x, z) {
    // rust: covered.insert((x, z));
}
}
}
    // rust: let plan =
    // rust: Plan::with_previous(camera, detail, distance, &Plan::default(), 0, reduced, None);
    // rust: let leaf = |x: i32, z: i32| {
    // rust: (0..=MAX_LEVEL)
    // rust: .map(|level| TileKey {
    // rust: x: x.div_euclid(16 << level),
    // rust: z: z.div_euclid(16 << level),
    // rust: level,
    // rust: })
    // rust: .find(|key| plan.nodes.contains(key) && !plan.split.contains(key))
}
    // rust: let mut seam = Vec::new();
    // rust: for z in (camera[1] - 256..camera[1] + 256).step_by(2) {
    // rust: for x in (camera[0] - 256..camera[0] + 256).step_by(2) {
    // rust: let chunk = (x.div_euclid(16), z.div_euclid(16));
    // rust: let near = (-2..=2)
    // rust: .any(|dz| (-2..=2).any(|dx| covered.contains(&(chunk.0 + dx, chunk.1 + dz))));
    // rust: if !covered.contains(&chunk) && near {
    // rust: seam.push((x, z, leaf(x, z).unwrap()));
}
}
}
    // rust: let mut horizon = Vec::new();
    // rust: for z in (camera[1] - 2048..camera[1] + 2048).step_by(64) {
    // rust: for x in (camera[0] - 2048..camera[0] + 2048).step_by(64) {
    // rust: if !covered.contains(&(x.div_euclid(16), z.div_euclid(16))) && leaf(x, z).is_some()
    // rust: {
    // rust: horizon.push((x, z));
}
}
}
    // rust: let mut ready: FxHashMap<TileKey, ()> = FxHashMap::default();
    // rust: for key in &plan.nodes {
    // rust: if key.level == 0 && covered.contains(&(key.x, key.z)) {
    // rust: ready.insert(*key, ());
}
}
    // rust: let leaves = plan
    // rust: .nodes
    // rust: .iter()
    // rust: .filter(|k| !plan.split.contains(k))
    // rust: .count();
    // rust: let (mut cost, mut fine, mut reached) = (0, None, None);
    // rust: for jobs in 0.. {
    // rust: let mut selected = Vec::new();
    // rust: for &root in &plan.roots {
    // rust: plan.select(root, &ready, &mut selected);
}
    // rust: let active: FxHashSet<_> = selected.into_iter().collect();
    // rust: let drawn = |x: i32, z: i32, levels: u8| {
    // rust: (0..=levels).any(|level| {
    // rust: active.contains(&TileKey {
    // rust: x: x.div_euclid(16 << level),
    // rust: z: z.div_euclid(16 << level),
    // rust: level,
    // rust: })
    // rust: })
}
    // rust: for &(x, z, leaf) in &seam {
    // rust: assert!(drawn(x, z, leaf.level) || !drawn(x, z, MAX_LEVEL));
}
    // rust: if fine.is_none() && seam.iter().all(|&(x, z, leaf)| drawn(x, z, leaf.level)) {
    // rust: fine = Some((jobs, cost));
}
    // rust: if reached.is_none() && horizon.iter().all(|&(x, z)| drawn(x, z, MAX_LEVEL)) {
    // rust: reached = Some((jobs, cost));
}
    // rust: if let (Some(fine), Some(reached)) = (fine, reached) {
    // rust: return ([fine, reached], leaves);
}
    // rust: let next = wanted_tiles(&plan, &ready, &FxHashSet::default(), camera)
    // rust: .min()
    // rust: .unwrap();
    // rust: let next = TileKey {
    // rust: x: next.x,
    // rust: z: next.z,
    // rust: level: next.level,
}
            // `lod_grid`'s density lattice: one point per max(stride, 4) blocks.
    // rust: let stride = next.size() / 16;
    // rust: let lattice = 16 * stride / stride.max(4) + 1;
    // rust: cost += lattice * lattice;
    // rust: ready.insert(next, ());
}
    // rust: unreachable!()
}
pub fn the_far_terrain_next_to_the_near_chunks_loads_first() void {
}
        // Measured: 270 to 301 jobs, all of them fine tiles (7500 to 8500
        // lattice points). A coarse tile first costs up to 289 points; the
        // order that filled a ring ahead first and refined broad tiles every
        // other job took 54000 to 119000 for the seam in view alone.
    // rust: for camera in [[8, 8], [40, -9], [-300, 517]] {
    // rust: for reduced in [false, true] {
    // rust: let ([(jobs, cost), _], _) = jobs_until_fine_seam(camera, reduced);
    // rust: assert!(jobs < 320, "{jobs} jobs");
    // rust: assert!(cost < 9000, "{cost} lattice points");
}
}
}
pub fn a_coarse_backdrop_reaches_the_horizon_early() void {
}
        // Sampling only planned tiles, nearest first, reached the horizon
        // with the last of ~3000 jobs in Full (500000 lattice points), ~1050
        // in Reduced (200000): for minutes on a slow machine the far terrain
        // ended in a hard edge. The backdrop adds ~230 coarse tiles (~80 in
        // Reduced), about a tenth more work in all.
    // rust: for camera in [[8, 8], [40, -9], [-300, 517]] {
    // rust: for reduced in [false, true] {
    // rust: let ([_, (jobs, cost)], leaves) = jobs_until_fine_seam(camera, reduced);
    // rust: assert!(jobs < 1000 && jobs < leaves, "{jobs} jobs of {leaves}");
    // rust: assert!(cost < 100_000, "{cost} lattice points");
}
}
}
pub fn extra_sampling_threads_only_on_large_machines() void {
}
        // Small machines are unchanged: a quarter of their cores, never more
        // than three, so the near chunks and the frame keep theirs.
    // rust: assert_eq!([1, 2, 4].map(sampling_threads), [1, 1, 1]);
        // From eight, two thirds rather than half, still capped at eight.
    // rust: assert_eq!([8, 11, 12].map(sampling_threads), [5, 7, 8]);
    // rust: assert_eq!([16, 64].map(sampling_threads), [8, 8]);
    // rust: assert_eq!([2, 8, 12, 16].map(meshing_threads), [1, 2, 3, 7]);
        // From four cores up the two pools together leave one for the frame
        // and the ticks. Below that both clamp to one and there is nothing
        // to spare, which is the existing behaviour.
    // rust: for cores in [4usize, 8, 11, 12, 16, 64] {
    // rust: assert!(
    // rust: sampling_threads(cores) + meshing_threads(cores) < cores,
    // rust: "{cores} cores leaves nothing for the frame"
    // rust: );
}
}

    /// Review point 3 on #4747: a result from a batch that is no longer the
    /// newest still fills the frame when it is newer than what the tile shows,
    /// and the tile keeps waiting for the job that is still pending. Accepting
    /// only the newest revision threw every older result away — and re-marking
    /// a tile happens again before its mesh arrives on a busy frontier, so no
    /// result was ever accepted and the tile's removal stayed blocked.
pub fn a_result_newer_than_the_shown_one_is_kept_while_a_newer_one_is_pending() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let key = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: lod.active.insert(key);
        // Two marks: the second revision is what the tile is waiting for.
    // rust: lod.mark_mesh(key);
    // rust: let older = *lod.mesh_version.get(&key).unwrap();
    // rust: lod.mark_mesh(key);
    // rust: let newest = *lod.mesh_version.get(&key).unwrap();
    // rust: assert!(newest > older);
    // rust: let mut meshes = Vec::new();

        // The older batch's result arrives while the newer job is pending.
    // rust: lod.accept_mesh(key, older, SectionMesh::default(), false, &mut meshes);
    // rust: assert_eq!(meshes.len(), 1, "an older result newer than shown is used");
    // rust: assert_eq!(lod.shown_version.get(&key), Some(&older));
    // rust: assert!(lod.meshed.contains(&key));
        // Still waiting: the pending job owns the tile, so it stays unmeshed
        // and keeps being dispatched.
    // rust: assert!(lod.unmeshed.contains(&key), "the pending job still owns it");

        // A result older than what is shown is not drawn again.
    // rust: lod.accept_mesh(key, older, SectionMesh::default(), false, &mut meshes);
    // rust: assert_eq!(meshes.len(), 1, "the same revision is not redrawn");

        // The newest settles the tile.
    // rust: lod.accept_mesh(key, newest, SectionMesh::default(), false, &mut meshes);
    // rust: assert_eq!(meshes.len(), 2);
    // rust: assert_eq!(lod.shown_version.get(&key), Some(&newest));
    // rust: assert!(
    // rust: !lod.unmeshed.contains(&key),
    // rust: "the newest revision settles it"
    // rust: );

        // A canceled result, and one for a tile that left the view, are dropped
        // however new they are.
    // rust: lod.mark_mesh(key);
    // rust: let next = *lod.mesh_version.get(&key).unwrap();
    // rust: lod.accept_mesh(key, next, SectionMesh::default(), true, &mut meshes);
    // rust: assert_eq!(meshes.len(), 2, "a canceled result is dropped");
    // rust: lod.active.remove(&key);
    // rust: lod.accept_mesh(key, next + 1, SectionMesh::default(), false, &mut meshes);
    // rust: assert_eq!(meshes.len(), 2, "a tile that left the view is dropped");
}

    /// A neighbour inside the plan that is not drawn yet is unknown, not
    /// empty, and its arrival remeshes the tile that faced it. One past the
    /// planned range is still empty.
pub fn a_planned_neighbor_that_is_not_ready_is_unknown_not_empty() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let a = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: let b = TileKey {
    // rust: x: 1,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: lod.plan = Plan::default();
    // rust: lod.plan.roots = vec![a, b];
    // rust: lod.plan.nodes.extend([a, b]);
    // rust: lod.finish_sample(a, vec![Column::default(); CELLS * CELLS]);
    // rust: assert!(lod.active.contains(&a));
    // rust: let sides = |lod: &Lod| {
    // rust: let input = lod.snapshot().mesh_input(a, Vec::new());
    // rust: [0, 1].map(|side| {
    // rust: input.neighbors[side]
    // rust: .iter()
    // rust: .map(|edge| (edge.unknown, matches!(edge.column, ColumnSource::Tile(..))))
    // rust: .collect::<Vec<_>>()
    // rust: })
}
    // rust: let [west, east] = sides(&lod);
    // rust: assert!(west.iter().all(|&edge| edge == (false, false)), "range end");
    // rust: assert!(east.iter().all(|&edge| edge == (true, false)), "planned");

        // Its arrival draws the neighbour and remeshes the tile facing it.
    // rust: lod.dirty.clear();
    // rust: lod.finish_sample(b, vec![Column::default(); CELLS * CELLS]);
    // rust: assert!(lod.dirty.contains_key(&a), "the tile facing it is remeshed");
    // rust: let [_, east] = sides(&lod);
    // rust: assert!(east.iter().all(|&edge| edge == (false, true)), "drawn");

        // Past a split tile's out-of-range child there is nothing to wait for.
    // rust: let parent = TileKey {
    // rust: x: 4,
    // rust: z: 4,
    // rust: level: 1,
}
    // rust: lod.plan.nodes.insert(parent);
    // rust: lod.plan.split.insert(parent);
    // rust: lod.plan.nodes.extend(parent.children().into_iter().take(3));
    // rust: let snapshot = lod.snapshot();
    // rust: let [x, _, z] = parent.origin();
    // rust: assert!(snapshot.planned_leaf(x + 1, z + 1), "a planned leaf");
    // rust: assert!(!snapshot.planned_leaf(x + 17, z + 17), "no child planned");
    // rust: assert!(!snapshot.planned_leaf(x - 40, z), "outside the plan");
}

pub fn a_planned_neighbor_leaving_the_range_unready_remeshes_the_tile_that_waited() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let a = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: let b = TileKey {
    // rust: x: 1,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: lod.plan = Plan::default();
    // rust: lod.plan.roots = vec![a, b];
    // rust: lod.plan.nodes.extend([a, b]);
    // rust: lod.finish_sample(a, vec![Column::default(); CELLS * CELLS]);
    // rust: lod.dirty.clear();
        // A range of one chunk around (-10, 0) keeps `a` and drops `b`.
    // rust: lod.replan([-10, 0], 0, 1, 0, None);
    // rust: assert!(lod.plan.nodes.contains(&a) && !lod.plan.nodes.contains(&b));
    // rust: assert!(lod.dirty.contains_key(&a), "its east wall is drawn now");
}

pub fn far_meshing_holds_while_small_machine_near_terrain_loads() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let key = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: lod.small = true;
    // rust: lod.active.insert(key);
    // rust: lod.ready
    // rust: .insert(key, Arc::new(vec![Column::default(); CELLS * CELLS]));
    // rust: lod.mark_mesh(key);
    // rust: lod.set_near_loading(true);
    // rust: lod.dispatch_meshes([0, 0]);
    // rust: assert!(lod.shared.mesh_jobs.lock().unwrap().is_empty());

    // rust: lod.set_near_loading(false);
    // rust: lod.dispatch_meshes([0, 0]);
    // rust: assert_eq!(lod.shared.mesh_jobs.lock().unwrap().len(), 1);
}

pub fn queued_samples_follow_the_view_and_make_way_for_the_near_terrain() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: lod.small = true;
    // rust: lod.sample_jobs = 16;
    // rust: let queued = |lod: &Lod| -> Vec<TileKey> {
    // rust: let jobs = lod.shared.jobs.lock().unwrap();
    // rust: jobs.iter()
    // rust: .filter_map(|job| match job {
    // rust: Job::Sample(key) => Some(*key),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}
    // rust: let observing = |lod: &Lod| {
    // rust: let jobs = lod.shared.jobs.lock().unwrap();
    // rust: jobs.iter().any(|job| matches!(job, Job::Observe((5, 5))))
}
    // rust: let pending = |lod: &Lod| -> Vec<TileKey> {
    // rust: let mut keys: Vec<_> = lod.pending.iter().copied().collect();
    // rust: keys.sort();
    // rust: keys
}
    // rust: let sorted = |mut keys: Vec<TileKey>| {
    // rust: keys.sort();
    // rust: keys
}
    // rust: let none = || Some(FxHashSet::default());
    // rust: lod.update([8., 64., 8.], 2, 64, none(), None);
    // rust: let before = queued(&lod);
    // rust: assert_eq!(before.len(), 16, "a full queue once the near terrain is in");
    // rust: lod.shared
    // rust: .jobs
    // rust: .lock()
    // rust: .unwrap()
    // rust: .push_back(Job::Observe((5, 5)));

        // A chunk's move: the tiles still planned keep their place in line.
    // rust: lod.update([24., 64., 8.], 2, 64, none(), None);
    // rust: let moved = queued(&lod);
    // rust: let kept: Vec<_> = before
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|key| lod.plan.nodes.contains(key))
    // rust: .collect();
    // rust: assert!(!kept.is_empty());
    // rust: assert_eq!(moved[..kept.len()], kept[..]);
    // rust: assert_eq!(moved.len(), 16);
    // rust: assert!(observing(&lod), "only sample jobs are dropped");

        // A teleport: none of the old view's tiles is sampled any more.
    // rust: lod.update([100_000., 64., 100_000.], 2, 64, none(), None);
    // rust: let after = queued(&lod);
    // rust: assert_eq!(after.len(), 16);
    // rust: assert!(after.iter().all(|key| !moved.contains(key)));
    // rust: assert!(after.iter().all(|key| lod.plan.nodes.contains(key)));
    // rust: assert_eq!(
    // rust: pending(&lod),
    // rust: sorted(after.clone()),
    // rust: "dropped jobs free their slots"
    // rust: );

        // New chunks load nearby: the queue gives way at once, not after it
        // drained, and the dropped tiles come back, best first, once they are in.
    // rust: lod.set_near_loading(true);
    // rust: assert!(queued(&lod).is_empty());
    // rust: assert!(lod.pending.is_empty());
    // rust: assert!(observing(&lod));
    // rust: lod.set_near_loading(false);
    // rust: lod.update([100_000., 64., 100_000.], 2, 64, none(), None);
    // rust: assert_eq!(queued(&lod), after);

        // Larger machines keep the first `SAMPLE_JOBS` of the queue.
    // rust: lod.small = false;
    // rust: lod.set_near_loading(true);
    // rust: assert_eq!(queued(&lod), after[..SAMPLE_JOBS]);
    // rust: assert_eq!(pending(&lod), sorted(after[..SAMPLE_JOBS].to_vec()));
}

pub fn detail_progress_counts_the_columns_that_take_generated_detail() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let tile = |x, level| TileKey { x, z: 0, level };
    // rust: let (fine, covered, coarse, split) = (tile(0, 0), tile(1, 0), tile(1, 3), tile(1, 2));
    // rust: lod.active = [fine, covered, coarse, split].into_iter().collect();
    // rust: lod.covered.insert((1, 0));
    // rust: lod.plan.split.insert(split);
    // rust: lod.detail_masks.insert(fine, [u64::MAX, 1, 0, 0]);
    // rust: lod.detail_masks.insert(coarse, [u64::MAX; 4]);
        // Only the fine tile: the covered one is the near chunk's, the split
        // one stands in for finer tiles and the coarse one is past the detail.
    // rust: assert_eq!(lod.detail_progress(), (256, 65));
}

    /// Drives the scheduler by hand: every sample the new incremental path
    /// produces must select exactly the tiles `Plan::select` selects, after
    /// every single sample, and across camera moves and distance changes.
pub fn marking_a_tile_dirties_fallback_ancestors_and_touching_neighbors_only() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let key = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: let parent = key.parent();
    // rust: let grand = parent.parent();
    // rust: let west = TileKey {
    // rust: x: -1,
    // rust: z: 0,
    // rust: level: 2,
}
    // rust: let near = TileKey {
    // rust: x: -1,
    // rust: z: 0,
    // rust: level: 1,
}
    // rust: let far = TileKey {
    // rust: x: -1,
    // rust: z: 1,
    // rust: level: 1,
}
    // rust: let near_child = TileKey {
    // rust: x: -1,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: let behind_child = TileKey {
    // rust: x: -2,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: let far_child = TileKey {
    // rust: x: -1,
    // rust: z: 2,
    // rust: level: 0,
}
    // rust: lod.plan.nodes.extend([
    // rust: key,
    // rust: parent,
    // rust: grand,
    // rust: west,
    // rust: near,
    // rust: far,
    // rust: near_child,
    // rust: behind_child,
    // rust: far_child,
    // rust: ]);
    // rust: lod.plan.split.extend([parent, grand, west, near, far]);
    // rust: lod.active
    // rust: .extend([key, grand, near_child, behind_child, far_child]);
    // rust: lod.mark_selection_changed(key);
    // rust: let dirty: FxHashSet<_> = lod.dirty.keys().copied().collect();
    // rust: assert!(dirty.contains(&key), "the tile itself");
    // rust: assert!(dirty.contains(&grand), "the active fallback ancestor");
    // rust: assert!(dirty.contains(&near_child), "the neighbor across the side");
    // rust: assert!(
    // rust: !dirty.contains(&far_child),
    // rust: "a neighbor child beyond the changed interval"
    // rust: );
    // rust: assert!(
    // rust: !dirty.contains(&behind_child),
    // rust: "a neighbor child behind the shared face"
    // rust: );
    // rust: assert!(!dirty.contains(&near) && !dirty.contains(&west));
        // New column data does not move footprints: no fallback ancestor.
    // rust: lod.dirty.clear();
    // rust: lod.mark_data_changed(key);
    // rust: let dirty: FxHashSet<_> = lod.dirty.keys().copied().collect();
    // rust: assert!(dirty.contains(&key));
    // rust: assert!(dirty.contains(&near_child), "edge columns still change");
    // rust: assert!(
    // rust: !dirty.contains(&grand),
    // rust: "a fallback ancestor's clipping did not"
    // rust: );
}

pub fn only_children_on_the_shared_face_are_walked() void {
}
    // rust: let west = TileKey {
    // rust: x: -1,
    // rust: z: 0,
    // rust: level: 1,
}
    // rust: assert!(Lod::side_flush(
    // rust: TileKey {
    // rust: x: -1,
    // rust: z: 0,
    // rust: level: 0
    // rust: },
    // rust: 0,
    // rust: west
    // rust: ));
    // rust: assert!(!Lod::side_flush(
    // rust: TileKey {
    // rust: x: -2,
    // rust: z: 0,
    // rust: level: 0
    // rust: },
    // rust: 0,
    // rust: west
    // rust: ));
    // rust: let east = TileKey {
    // rust: x: 1,
    // rust: z: 0,
    // rust: level: 1,
}
    // rust: assert!(Lod::side_flush(
    // rust: TileKey {
    // rust: x: 2,
    // rust: z: 0,
    // rust: level: 0
    // rust: },
    // rust: 1,
    // rust: east
    // rust: ));
    // rust: assert!(!Lod::side_flush(
    // rust: TileKey {
    // rust: x: 3,
    // rust: z: 0,
    // rust: level: 0
    // rust: },
    // rust: 1,
    // rust: east
    // rust: ));
    // rust: let north = TileKey {
    // rust: x: 0,
    // rust: z: -1,
    // rust: level: 1,
}
    // rust: assert!(Lod::side_flush(
    // rust: TileKey {
    // rust: x: 0,
    // rust: z: -1,
    // rust: level: 0
    // rust: },
    // rust: 2,
    // rust: north
    // rust: ));
    // rust: assert!(!Lod::side_flush(
    // rust: TileKey {
    // rust: x: 0,
    // rust: z: -2,
    // rust: level: 0
    // rust: },
    // rust: 2,
    // rust: north
    // rust: ));
    // rust: let south = TileKey {
    // rust: x: 0,
    // rust: z: 1,
    // rust: level: 1,
}
    // rust: assert!(Lod::side_flush(
    // rust: TileKey {
    // rust: x: 0,
    // rust: z: 2,
    // rust: level: 0
    // rust: },
    // rust: 3,
    // rust: south
    // rust: ));
    // rust: assert!(!Lod::side_flush(
    // rust: TileKey {
    // rust: x: 0,
    // rust: z: 3,
    // rust: level: 0
    // rust: },
    // rust: 3,
    // rust: south
    // rust: ));
}

pub fn a_cutout_wait_follows_a_retired_tile_to_its_children() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let parent = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 1,
}
    // rust: let child = parent.children()[0];
    // rust: lod.plan.nodes.insert(parent);
    // rust: lod.plan.split.insert(parent);
    // rust: lod.plan.nodes.insert(child);
    // rust: lod.active.insert(child);
    // rust: lod.unmeshed.insert(child);
    // rust: lod.cutout_pending = Some([(0, 0)].into_iter().collect());
    // rust: lod.cutout_waiting.insert(parent);
    // rust: lod.transfer_cutout_wait(parent);
    // rust: assert!(!lod.cutout_waiting.contains(&parent));
    // rust: assert!(lod.cutout_waiting.contains(&child));
    // rust: lod.publish_cutout_if_ready();
    // rust: assert!(lod.take_cutout().is_none());
    // rust: lod.cutout_waiting.remove(&child);
    // rust: lod.publish_cutout_if_ready();
    // rust: assert!(lod.take_cutout().is_some());
        // A level-0 waiter has no children to hand the wait to.
    // rust: let fine = TileKey {
    // rust: x: 5,
    // rust: z: 5,
    // rust: level: 0,
}
    // rust: lod.cutout_pending = Some([(5, 5)].into_iter().collect());
    // rust: lod.cutout_waiting.insert(fine);
    // rust: lod.transfer_cutout_wait(fine);
    // rust: assert!(!lod.cutout_waiting.contains(&fine));
    // rust: lod.publish_cutout_if_ready();
    // rust: assert!(lod.take_cutout().is_some());
}

pub fn a_cutout_waits_for_the_tiles_it_affected() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let tile = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: lod.cutout_pending = Some([(1, 2)].into_iter().collect());
    // rust: lod.cutout_waiting.insert(tile);
    // rust: lod.publish_cutout_if_ready();
    // rust: assert!(lod.take_cutout().is_none(), "cutout before its replacement");
        // A later, unrelated mesh does not stand in for the affected tile.
    // rust: lod.meshed.insert(TileKey {
    // rust: x: 8,
    // rust: z: 8,
    // rust: level: 0,
    // rust: });
    // rust: lod.publish_cutout_if_ready();
    // rust: assert!(lod.take_cutout().is_none());
    // rust: lod.cutout_waiting.remove(&tile);
    // rust: lod.publish_cutout_if_ready();
    // rust: assert_eq!(lod.take_cutout(), Some([(1, 2)].into_iter().collect()));
        // A second change unions tiles still waiting from the first.
    // rust: lod.cutout_pending = Some([(3, 4)].into_iter().collect());
    // rust: lod.cutout_waiting.insert(tile);
    // rust: lod.cutout_waiting.remove(&tile);
    // rust: lod.publish_cutout_if_ready();
    // rust: assert_eq!(lod.take_cutout(), Some([(3, 4)].into_iter().collect()));
}

    /// A saved summary is not detail: a covered empty stand-in must not let
    /// the cutout release the full-detail columns under it.
pub fn a_saved_summary_does_not_release_an_unfilled_stand_in() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let key = TileKey {
    // rust: x: 3,
    // rust: z: -2,
    // rust: level: 0,
}
    // rust: lod.plan.nodes.insert(key);
    // rust: lod.ready
    // rust: .insert(key, Arc::new(vec![Column::default(); 256]));
    // rust: lod.saved.insert(
    // rust: (3, -2),
    // rust: Arc::new(std::array::from_fn(|_| Column::default())),
    // rust: );
    // rust: lod.retiring.insert((3, -2));
    // rust: lod.covered.insert((3, -2));
    // rust: lod.prune_retiring();
    // rust: assert!(lod.retiring.contains(&(3, -2)), "released without detail");
    // rust: assert!(lod.covered.contains(&(3, -2)));
    // rust: lod.detail_masks.insert(key, [u64::MAX; 4]);
    // rust: lod.prune_retiring();
    // rust: assert!(!lod.retiring.contains(&(3, -2)));
    // rust: assert!(!lod.covered.contains(&(3, -2)));
}

    /// Completing a subtree must not remesh every tile inside it: only a
    /// tile's own active transition changes the meshes below it.
pub fn completing_an_undrawn_subtree_marks_no_descendants() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let parent = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 1,
}
    // rust: let children = parent.children();
    // rust: lod.plan.nodes.insert(parent);
    // rust: lod.plan.split.insert(parent);
    // rust: lod.active.extend(children);
    // rust: for child in children {
    // rust: lod.plan.nodes.insert(child);
    // rust: lod.ready
    // rust: .insert(child, Arc::new(vec![Column::default(); 256]));
    // rust: lod.complete.insert(child, true);
}
    // rust: lod.complete.insert(parent, false);
    // rust: lod.dirty.clear();
    // rust: lod.refresh_path(parent);
    // rust: assert!(lod.dirty.is_empty(), "completion remeshed descendants");
    // rust: assert!(lod.complete[&parent]);
    // rust: assert!(!lod.active.contains(&parent));
}

pub fn removals_wait_for_every_overlapping_replacement_mesh() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let parent = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 1,
}
    // rust: let child = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0,
}
    // rust: lod.active.insert(child);
    // rust: lod.unmeshed.insert(child);
    // rust: lod.removed_pending.insert(parent);
    // rust: lod.release_removed();
    // rust: assert!(
    // rust: lod.removed().is_empty(),
    // rust: "removed before the replacement was meshed"
    // rust: );
    // rust: lod.meshed.insert(child);
    // rust: lod.unmeshed.remove(&child);
    // rust: lod.release_removed();
    // rust: assert_eq!(lod.removed(), [parent]);
        // Out of range: nothing overlaps it, so it may fade out at once.
    // rust: let gone = TileKey {
    // rust: x: 100,
    // rust: z: 100,
    // rust: level: 3,
}
    // rust: lod.removed_pending.insert(gone);
    // rust: lod.release_removed();
    // rust: assert_eq!(lod.removed(), [gone]);
}

pub fn incremental_selection_matches_plan_select_after_every_sample() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let column = Column::from_surface(Some(Surface {
    // rust: height: 64,
    // rust: state: BlockStateId(1),
    // rust: water: None,
    // rust: biome: 0,
    // rust: }));
    // rust: let columns = vec![column; CELLS * CELLS];
    // rust: let mut camera = [0.0, 80.0, 0.0];
    // rust: let finish_queued = |lod: &mut Lod| {
    // rust: let mut keys = Vec::new();
    // rust: {
    // rust: let mut jobs = lod.shared.jobs.lock().unwrap();
    // rust: let mut i = 0;
    // rust: while i < jobs.len() {
    // rust: if matches!(jobs[i], Job::Sample(_)) {
    // rust: let Some(Job::Sample(key)) = jobs.remove(i) else {
    // rust: unreachable!()
}
    // rust: keys.push(key);
    // rust: } else {
    // rust: i += 1;
}
}
}
    // rust: for key in &keys {
    // rust: lod.finish_sample(*key, columns.clone());
}
    // rust: !keys.is_empty()
}
    // rust: let check = |lod: &Lod| {
    // rust: let mut expected = Vec::new();
    // rust: for &root in &lod.plan.roots {
    // rust: lod.plan.select(root, &lod.ready, &mut expected);
}
    // rust: expected.retain(|key| key.level != 0 || !lod.covered.contains(&(key.x, key.z)));
    // rust: let expected: FxHashSet<_> = expected.into_iter().collect();
    // rust: assert_eq!(lod.active, expected);
}
    // rust: for _ in 0..2 {
    // rust: for _ in 0..4000 {
    // rust: lod.update(camera, 2, 64, Some(FxHashSet::default()), None);
    // rust: check(&lod);
    // rust: if !finish_queued(&mut lod) {
    // rust: break;
}
}
    // rust: let (desired, sampled) = lod.progress();
    // rust: assert_eq!((desired, sampled), (desired, desired), "all leaves sampled");
    // rust: check(&lod);
            // Move a chunk: retained samples stay selected, new ones join.
    // rust: camera[0] += 16.0;
    // rust: lod.update(camera, 2, 64, Some(FxHashSet::default()), None);
    // rust: check(&lod);
}
        // A covered level-0 stand-in completes its parent but is not drawn.
    // rust: lod.update(camera, 2, 64, Some([(0, 0)].into_iter().collect()), None);
    // rust: check(&lod);
    // rust: assert!(lod.ready.contains_key(&TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0
    // rust: }));
    // rust: assert!(!lod.active.contains(&TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 0
    // rust: }));
        // Shrinking the distance retires tiles and reports them once.
    // rust: lod.update(camera, 0, 32, Some(FxHashSet::default()), None);
    // rust: check(&lod);
    // rust: let _ = lod.removed();
}
    /// The prepared resources' far-terrain worker context and block facts.
pub fn test_context() c {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::{assets::Assets, biome::Biomes, light::LightTables, mesher::MeshTables};
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES"),
    // rust: );
    // rust: let assets = Arc::new(Assets::load(&root)?);
    // rust: let render = Arc::new(assets.reload(&root)?);
    // rust: let facts = BlockFacts::load(&root, assets.registry)?;
    // rust: let biomes = Arc::new(Biomes::load(&root)?);
    // rust: let tables = Arc::new(MeshTables::new(
    // rust: &assets,
    // rust: &render,
    // rust: &facts,
    // rust: crate::models::load_visibility(&root, assets.registry)?,
    // rust: )?);
    // rust: let context = Arc::new(WorkerContext {
    // rust: light: Arc::new(LightTables::load(&root, assets.registry, &facts)?),
    // rust: tables,
    // rust: assets,
    // rust: render,
    // rust: biomes,
    // rust: });
    // rust: Ok((context, facts))
}
    /// A server's far terrain (`server_terrain`) in a scratch folder, and a
    /// chunk of stone at y 70 to observe.
pub const ServerLod = struct {
    lod: Lod,
    facts: BlockFacts,
    stone: BlockStateId,
    dir: std::path::PathBuf,
};
    // rust: impl ServerLod {
pub fn new(name: []const u8) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with(name, |dir| {
    // rust: crate::server_terrain::ServerTerrain::new(dir.into(), None)
    // rust: })
}
    // rust: fn with(
    // rust: name: &str,
    // rust: source: impl FnOnce(&std::path::Path) -> Arc<dyn LodSource>,
    // rust: ) -> crate::Result<Self> {
    // rust: let (context, facts) = test_context()?;
    // rust: let stone = context
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:stone")
    // rust: .unwrap();
    // rust: let dir = std::env::temp_dir().join(format!("horizon-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: Ok(Self {
    // rust: lod: Lod::new(source(&dir), context),
    // rust: facts,
    // rust: stone,
    // rust: dir,
    // rust: })
}
pub fn observe(self: *Self, x: i32, z: i32) void {
}
    // rust: let mut chunk = Chunk::empty(x, z);
    // rust: for i in 0..256 {
    // rust: chunk.set(i % 16, 70, i / 16, self.stone.0);
}
    // rust: self.lod.observe(Arc::new(chunk), &self.facts);
}
        /// Updates until nothing is left to sample, summarize or mesh (`settle`:
        /// for a while), or only a few times.
    // rust: fn run(
    // rust: &mut self,
    // rust: camera: [f64; 3],
    // rust: detail: i32,
    // rust: distance: u32,
    // rust: covered: &FxHashSet<(i32, i32)>,
    // rust: settle: bool,
    // rust: ) {
    // rust: let lod = &mut self.lod;
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(120);
    // rust: let mut covered = Some(covered.clone());
    // rust: let mut quiet = 0;
    // rust: while quiet < if settle { 50 } else { 3 } {
    // rust: lod.update(camera, detail, distance, covered.take(), None);
    // rust: lod.removed();
                // Every tile sampled, but those waiting for their data.
    // rust: let unsampled = lod.plan.nodes.iter().any(|key| {
    // rust: !lod.plan.split.contains(key)
    // rust: && !lod.ready.contains_key(key)
    // rust: && !lod.retry.contains_key(key)
    // rust: });
    // rust: let idle = lod.pending.is_empty()
    // rust: && lod.outstanding_meshes == 0
    // rust: && lod.dirty.is_empty()
    // rust: && lod.observing() == 0
    // rust: && lod
    // rust: .shared
    // rust: .jobs
    // rust: .lock()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .all(|job| matches!(job, Job::RequestDetail { .. }))
    // rust: && !unsampled;
    // rust: quiet = if idle { quiet + 1 } else { 0 };
    // rust: assert!(
    // rust: std::time::Instant::now() < deadline,
    // rust: "far terrain never settled: {} pending, {} meshing, {} observing, {} jobs, {} unsampled, {} waiting",
    // rust: lod.pending.len(),
    // rust: lod.outstanding_meshes,
    // rust: lod.observing(),
    // rust: lod.shared.jobs.lock().unwrap().len(),
    // rust: lod.plan
    // rust: .nodes
    // rust: .iter()
    // rust: .filter(|key| !lod.plan.split.contains(key)
    // rust: && !lod.ready.contains_key(key)
    // rust: && !lod.retry.contains_key(key))
    // rust: .count(),
    // rust: lod.retry.len(),
    // rust: );
    // rust: std::thread::sleep(std::time::Duration::from_millis(2));
}
}
        /// The chunks of `chunks` the active tiles don't draw as observed:
        /// the visited column or the tile's sample there, at the chunk's middle.
pub fn missing(self: *Self, chunks: impl Iterator<Item = (i32) void {
}
    // rust: chunks
    // rust: .filter(|&chunk| {
    // rust: self.drawn(chunk)
    // rust: .is_none_or(|c| c.spans.last().is_none_or(|s| s.max != 71))
    // rust: })
    // rust: .collect()
}
        /// The column the active tiles draw at a chunk's middle.
pub fn drawn(self: *Self) void {
}
    // rust: let lod = &self.lod;
    // rust: let snapshot = lod.snapshot();
    // rust: let drawn = |x: i32, z: i32| {
    // rust: let key = lod.active.iter().copied().find(|key| {
    // rust: let [ox, _, oz] = key.origin();
    // rust: (ox..ox + key.size()).contains(&x) && (oz..oz + key.size()).contains(&z)
    // rust: })?;
    // rust: let stride = key.size() / CELLS as i32;
    // rust: let [ox, _, oz] = key.origin();
    // rust: let (cx, cz) = ((x - ox) / stride, (z - oz) / stride);
    // rust: let (wx, wz) = (ox + cx * stride, oz + cz * stride);
    // rust: Some(match snapshot.visited_source(wx, wz, stride) {
    // rust: Some(source) => source.get().clone(),
    // rust: None => lod.ready[&key][(cz * CELLS as i32 + cx) as usize].clone(),
    // rust: })
}
    // rust: drawn(cx * 16 + 8, cz * 16 + 8)
}
}
    // rust: impl Drop for ServerLod {
pub fn drop(self: *Self) void {
}
    // rust: let _ = std::fs::remove_dir_all(&self.dir);
}
}
pub fn chunks_a_server_dropped_stay_drawn_as_far_terrain() c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut far = ServerLod::new("lod-dropped")?;
        // A server's view distance of 10 (it sends a ring more), drawn to a
        // render distance of 32 (`streaming.radius`, the covered area).
    // rust: let (view, detail, distance) = (10, 32, 64);
    // rust: let mut resident = FxHashSet::default();
    // rust: let mut dropped = FxHashSet::default();
        // The player flies east past some 1800 chunks: more than `MAX_SAVED`.
    // rust: let end = 60;
    // rust: for step in 0..=end {
    // rust: let center = (step, 0);
    // rust: let now: FxHashSet<_> = (-view..=view)
    // rust: .flat_map(|dz| (-view..=view).map(move |dx| (center.0 + dx, center.1 + dz)))
    // rust: .collect();
    // rust: for &(x, z) in now.difference(&resident) {
    // rust: far.observe(x, z);
}
    // rust: for &(x, z) in resident.difference(&now) {
                // `forget_remote_chunk`: the last of it, for far terrain.
    // rust: far.observe(x, z);
    // rust: dropped.insert((x, z));
}
    // rust: resident = now;
    // rust: let covered = resident
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&(x, z)| crate::streaming::in_view_distance(center, detail, x, z))
    // rust: .collect();
    // rust: let camera = [f64::from(center.0 * 16 + 8), 100.0, 8.0];
    // rust: far.run(camera, detail, distance, &covered, step == end);
}
        // Those within the LOD distance of where the player is now.
    // rust: let near = |&(x, z): &(i32, i32)| (x - end).pow(2) + z * z < (distance as i32 - 4).pow(2);
    // rust: let missing = far.missing(dropped.iter().copied().filter(near));
    // rust: assert!(
    // rust: missing.is_empty(),
    // rust: "{} dropped chunks aren't drawn, as {:?}",
    // rust: missing.len(),
    // rust: &missing[..missing.len().min(8)]
    // rust: );
    // rust: Ok(())
}
pub fn far_cells_sampled_before_their_chunks_were_kept_fill_in() c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut far = ServerLod::new("lod-late")?;
        // Seen from 5000 blocks: cells of 32 blocks and wider over them.
    // rust: let camera = [-5000.0, 100.0, 8.0];
    // rust: let (detail, distance) = (10, 512);
    // rust: let none = FxHashSet::default();
        // Every tile sampled while nothing is kept, then 32 × 32 chunks are.
    // rust: far.run(camera, detail, distance, &none, true);
    // rust: let chunks: Vec<_> = (0..32).flat_map(|z| (0..32).map(move |x| (x, z))).collect();
    // rust: assert_eq!(far.missing(chunks.iter().copied()).len(), chunks.len());
    // rust: for &(x, z) in &chunks {
    // rust: far.observe(x, z);
}
    // rust: far.run(camera, detail, distance, &none, true);
    // rust: let missing = far.missing(chunks.iter().copied());
    // rust: assert!(
    // rust: missing.is_empty(),
    // rust: "{} kept chunks aren't drawn",
    // rust: missing.len()
    // rust: );
    // rust: Ok(())
}
    /// A BlueMap whose coarse levels are in, its finest (cells up to a
    /// chunk) still downloading until `arrived`.
pub const Downloading = struct {
    stone: BlockStateId,
    arrived: *std::sync::atomic::AtomicBool,
};
pub const DownloadingSampler = struct {
    stone: BlockStateId,
    arrived: *std::sync::atomic::AtomicBool,
    details: std.ArrayList(crate::streaming::LodDetail),
};
    // rust: impl LodSource for Downloading {
pub fn sampler(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Box::new(DownloadingSampler {
    // rust: stone: self.stone,
    // rust: arrived: self.arrived.clone(),
    // rust: details: Vec::new(),
    // rust: })
}
}
    // rust: impl crate::streaming::LodSampler for DownloadingSampler {
pub fn fork(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(Box::new(Self {
    // rust: stone: self.stone,
    // rust: arrived: self.arrived.clone(),
    // rust: details: Vec::new(),
    // rust: }))
}
pub fn sample(self: *Self, _x: i32, _z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
        /// The coarse levels' stone, the finest's next state, and the
        /// coarse one's while the finest is on its way (`server_terrain`):
        /// stood in for, so not `waited`.
pub fn reduced_column(self: *Self, _x: i32, _z: i32, width: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = if width > 16 {
    // rust: self.stone
    // rust: } else if self.arrived.load(Ordering::Relaxed) {
    // rust: BlockStateId(self.stone.0 + 1)
    // rust: } else {
    // rust: self.stone
}
    // rust: Column {
    // rust: surface: None,
    // rust: spans: vec![Span {
    // rust: min: MIN_Y as i16,
    // rust: max: 71,
    // rust: state,
    // rust: biome: 0,
    // rust: light: 0xF0,
    // rust: }]
    // rust: .into(),
}
}
        /// Chunks' detail once arrived, as `server_terrain`'s: asked again
        /// while on its way.
pub fn request_detail(self: *Self, chunks: *[(i32) void {
}
    // rust: if self.arrived.load(Ordering::Relaxed) {
    // rust: let columns = Arc::new(std::array::from_fn(|_| self.reduced_column(0, 0, 1)));
    // rust: self.details
    // rust: .extend(chunks.iter().map(|&chunk| (chunk, columns.clone())));
}
}
pub fn drain_details(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.details)
}
}
pub fn coarser_stand_ins_keep_the_ring_past_the_near_chunks_drawn() c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let arrived = Arc::new(std::sync::atomic::AtomicBool::new(false));
    // rust: let mut far = ServerLod::with("lod-waiting", |_| {
    // rust: let stone = BlockStateId(1);
    // rust: Arc::new(Downloading {
    // rust: stone,
    // rust: arrived: arrived.clone(),
    // rust: })
    // rust: })?;
    // rust: let (camera, detail, distance) = ([8.0, 100.0, 8.0], 10, 64);
    // rust: let none = FxHashSet::default();
        // The ring past the near terrain, where nothing stood.
    // rust: let ring: Vec<_> = (-24..=24)
    // rust: .flat_map(|z| (-24..=24).map(move |x| (x, z)))
    // rust: .filter(|&(x, z)| x * x + z * z > 11 * 11)
    // rust: .collect();
    // rust: far.run(camera, detail, distance, &none, true);
    // rust: let missing = far.missing(ring.iter().copied());
    // rust: assert!(
    // rust: missing.is_empty(),
    // rust: "{} of {} chunks past the near terrain show nothing while their tiles wait",
    // rust: missing.len(),
    // rust: ring.len()
    // rust: );
        // The map's tiles arrive (`BlueMap::take_changed`): the finest replace them.
    // rust: arrived.store(true, Ordering::Relaxed);
    // rust: far.lod.refresh([-1024, -1024, 1024, 1024], (1, 24));
    // rust: far.run(camera, detail, distance, &none, true);
    // rust: assert!(far.lod.retry.is_empty());
    // rust: let fine = BlockStateId(2);
    // rust: let coarse: Vec<_> = ring
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&chunk| {
    // rust: far.drawn(chunk)
    // rust: .is_none_or(|c| c.spans.last().is_none_or(|s| s.state != fine))
    // rust: })
    // rust: .collect();
    // rust: assert!(
    // rust: coarse.is_empty(),
    // rust: "{} chunks still drawn coarse",
    // rust: coarse.len()
    // rust: );
    // rust: assert!(far.lod.active.iter().any(|key| key.level == 0));
    // rust: Ok(())
}

    /// The sample jobs `request_samples` queues now, taken off the queue.
pub fn queued(lod: *mut Lod) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lod.request_samples([0, 0]);
    // rust: let mut jobs = lod.shared.jobs.lock().unwrap();
    // rust: jobs.drain(..)
    // rust: .filter_map(|job| match job {
    // rust: Job::Sample(key) => Some(key),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}
pub fn samples(top: i16) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut column = Column::default();
    // rust: column.spans.push(Span {
    // rust: min: -64,
    // rust: max: top,
    // rust: state: BlockStateId(1),
    // rust: biome: 0,
    // rust: light: 0,
    // rust: });
    // rust: vec![column; CELLS * CELLS]
}
pub const AREA: [i32; 4] = [0, 0, 128, 128];
pub const ALL: (i32, i32) = (1, i32::MAX);

    /// A first sample that read a map tile still downloading is thrown
    /// away; if the tile came while it was taken, it is sampled again at
    /// once, else after `WAIT_RETRY` or when the tile comes.
pub fn waited_samples_are_taken_again_when_their_data_comes() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let key = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 3,
}
    // rust: lod.plan.nodes.insert(key);
    // rust: assert_eq!(queued(&mut lod), [key]);
    // rust: lod.finish_any_sample(key, vec![Column::default(); CELLS * CELLS], true);
    // rust: assert!(lod.retry.contains_key(&key) && !lod.ready.contains_key(&key));
    // rust: assert!(queued(&mut lod).is_empty(), "it waits for its data");
    // rust: lod.refresh(AREA, ALL);
    // rust: assert!(!lod.retry.contains_key(&key));
    // rust: assert_eq!(queued(&mut lod), [key], "the data came");

        // The data comes while it is being sampled.
    // rust: lod.refresh(AREA, ALL);
    // rust: lod.finish_any_sample(key, vec![Column::default(); CELLS * CELLS], true);
    // rust: assert!(!lod.retry.contains_key(&key));
    // rust: assert_eq!(queued(&mut lod), [key], "sampled again at once");
        // Coarser levels stood in for what waited: drawn.
    // rust: lod.finish_any_sample(key, samples(70), false);
    // rust: assert!(lod.ready.contains_key(&key) && !lod.stale.contains(&key));
    // rust: assert!(queued(&mut lod).is_empty());
        // Refreshed, then sampled with a hole where a tile is still on its
        // way: what is drawn stays, the hole isn't.
    // rust: lod.refresh(AREA, ALL);
    // rust: assert_eq!(queued(&mut lod), [key]);
    // rust: let mut holed = samples(80);
    // rust: holed[..CELLS].fill(Column::default());
    // rust: lod.finish_any_sample(key, holed, true);
    // rust: assert_eq!(lod.ready[&key][0], samples(70)[0]);
    // rust: assert!(lod.retry.contains_key(&key));
}

    /// A tile refreshed while its sample is in flight is sampled once more:
    /// that sample read the old data. Samples equal to the drawn ones mesh
    /// nothing.
pub fn refreshed_tiles_are_sampled_again_and_only_meshed_when_changed() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: let key = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 3,
}
    // rust: lod.plan.nodes.insert(key);
    // rust: lod.active.insert(key);
    // rust: lod.ready.insert(key, Arc::new(samples(70)));
    // rust: assert!(queued(&mut lod).is_empty());
    // rust: lod.refresh(AREA, ALL);
    // rust: assert_eq!(queued(&mut lod), [key]);
    // rust: lod.refresh(AREA, ALL);
    // rust: lod.finish_sample(key, samples(80));
    // rust: assert!(lod.stale.contains(&key), "refreshed again meanwhile");
    // rust: assert!(lod.dirty.contains_key(&key), "new samples are meshed");
    // rust: assert_eq!(queued(&mut lod), [key]);
    // rust: lod.dirty.clear();
    // rust: lod.finish_sample(key, samples(80));
    // rust: assert!(!lod.stale.contains(&key));
    // rust: assert!(lod.dirty.is_empty(), "the same samples mesh nothing");
    // rust: assert!(queued(&mut lod).is_empty());
        // Data drawn in other cell widths leaves it alone.
    // rust: lod.refresh(AREA, (17, 24));
    // rust: assert!(queued(&mut lod).is_empty());
}

    /// With a source that keeps what it observes (a server's chunks), a wide
    /// tile sampled empty where a chunk is now kept is sampled again.
pub fn kept_chunks_resample_the_wide_tiles_over_them() void {
}
    // rust: let mut lod = Lod::scheduler_for_test();
    // rust: lod.keeps_observed = true;
    // rust: let key = TileKey {
    // rust: x: 0,
    // rust: z: 0,
    // rust: level: 5,
}
    // rust: lod.plan.nodes.insert(key);
    // rust: lod.ready
    // rust: .insert(key, Arc::new(vec![Column::default(); CELLS * CELLS]));
    // rust: let column = samples(70).swap_remove(0);
    // rust: let columns: Arc<[Column; 256]> = Arc::new(std::array::from_fn(|_| column.clone()));
    // rust: lod.finish_observed((1, 1), ReducedColumns::new(columns));
    // rust: assert!(lod.stale.contains(&key));
    // rust: assert_eq!(queued(&mut lod), [key]);
}
}
