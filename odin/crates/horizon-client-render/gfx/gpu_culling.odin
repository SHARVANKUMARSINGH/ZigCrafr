//! Transpiled from Horizon Rust crate
package horizon_client_render_gpu_culling

import "core:fmt"
import "core:mem"
import "core:math"

// GPU culling: the frame's near solid sections culled and their draws listed
// by a compute pass, and drawn with one `multi_draw_indexed_indirect_count`
// per arena page, where the device can draw a count the GPU wrote
// (`MULTI_DRAW_INDIRECT_COUNT`: DX12, Vulkan 1.2 or
// `VK_KHR_draw_indirect_count`). Walking those sections on the CPU, listing a
// few draws per section by the sides it shows the eye and grouping them by
// page costs the render thread time in proportion to the sections in view.
//
// Every resident section with solid quads has a record here, under an id it
// keeps for as long as it stays (`SectionGpu::gpu_id`; resident slots move on
// every removal). The pass keeps the sections whose column is within the
// render distance (`streaming::in_view_distance`), that cave culling's graph
// reaches and whose box is in the frustum, and draws the runs of each one's
// solid quads that can face the eye (gfx.rs `facing_runs`), with the origin
// the walk would give it: `resident::origin`'s f32 bits, copied, never
// computed on the GPU. Within the render distance the CPU's walk then lists
// only the sections whose translucent quads it draws, that have no record, or
// that fade (`Resident::walk`); past it, it lists every section as before. A
// section whose instance carries a fade, fading in or out, has its record
// flagged (`FADING`, gfx.rs `mark_fades`) until it is whole: the pass leaves
// it out, and the CPU draws it with its fade.
//
// The graph is the one the walk reads that frame (`occlusion::Reach`). Its
// search keeps the cells it reached as bits too, and `Occlusion` a generation
// that changes whenever an answer of its `contains` may: the pass keeps a copy
// of the bits, sent through the staging belt when the generation moves, and
// the shader's `reached` answers as `contains` does, the sky band above a
// clamped box included.
//
// The integer frustum test (`tables`, `rounded_box`) keeps every section the
// walk's would and a thin shell more, alike on every backend; a frame whose
// sums could leave i32 is drawn by the CPU (`Prepared::Cpu`).
//
// Its statistics, the sections the pass kept and their draws (`counts[0]`,
// `counts[1]`), are copied after the pass into one of `READBACKS` small
// buffers with the CPU's part of the same frame (`copy_stats`), mapped once the
// frame is submitted (`submitted`, from the frame's after-submit hook) and
// taken in a frame or a few later (`collect`); nothing waits for them.
//
// A record also holds where its section's buckets of solid quads by the side
// they face end, and what `mesher::Sides::visible_from` compares the eye with
// for each, its margin in (`Sides::thresholds`); the tables hold the eye less
// each origin, the CPU's own f32 difference. Both are keys that order as their
// floats do (`order_key`), so the shader only compares integers and finds the
// CPU's runs on every backend, a GPU that flushes subnormal floats too. The
// buckets that can face the eye lie in at most `RUNS` runs: a draw each.
//
// The pass `apply`s the records that changed, then `cull` keeps the sections
// in view, writes their runs and counts their draws per page and block of ids,
// `scan` turns the counts into where each block's draws start, and `scatter`
// writes every block's draws there in id order, each section's in its runs'.
// Appended with atomics alone, a page's draws would come in the order the GPU
// happens to schedule them, and where faces of two sections meet at exactly
// the same depth the later draw keeps the pixel, so such pixels would flicker;
// in id order they differ from the CPU's front-to-back order only there, and
// stay put.
//
// This is not `cull` (occlusion culling, `HORIZON_GPU_CULL`), which tests the
// CPU's lists against phase 1's depth: frames drawn from here leave it off.
//
// wgpu checks a count draw only against the size of its buffers, never draw by
// draw, so every draw here is in bounds by construction: it draws a run of its
// section's own solid quads (a record's buckets end within them), so its index
// count is at most theirs times 6, which the quad index buffer covers (it grows
// before a larger mesh uploads), and its base vertex lies in its section's own
// range of the page it is drawn from; its first instance is an id below the
// table's end, which `origins` holds; and each page's count is clamped to its
// region, which `scatter` never writes past. A region has room for `RUNS` draws
// of every record of its page, the most a section has, so nothing is clamped.
// use super::{
    // rust: Frustum, SectionKey,
    // rust: arena::{Arena, try_create},
    // rust: occlusion::Reach,
    // rust: pack_timing::PassTiming,
    // rust: resident,
    // rust: submit::Queue,
    // rust: upload::Uploads,
}
// use crate::{graphics::GpuCullingOffer, mesher::Sides};
// use glam::{DVec3, DVec4, Mat4, Vec3};
// use std::{
    // rust: cmp::Reverse,
    // rust: collections::BinaryHeap,
    // rust: sync::{
    // rust: Arc,
    // rust: atomic::{AtomicU8, Ordering},
    // rust: },
    // rust: time::Instant,
}

// One section (`gpu_culling.wgsl`'s `Section`).
    // rust: pub(super) struct Record {
    // Section x, y (from the level's bottom), z and arena page; -1: a free id.
    // rust: key: [i32; 4],
    // The first vertex of its solid quads (a draw's base vertex, an i32: a
    // page holds fewer vertices), its solid quads (where its last bucket by
    // facing side ends), its box (`rounded_box`), then its flags (`FADING`).
    // rust: a: [u32; 4],
    // Where its first six buckets end, in `mesher::Sides` order: +X, +Z, the
    // other bucket, +Y, -Z, -X (`facing`).
    // rust: ends: [u32; 6],
    // What its buckets facing +X, +Z, +Y, -Z, -X and -Y compare the eye's
    // keys with (`facing`).
    // rust: keys: [u32; 6],
}

// In `Record::a[3]`: the CPU draws the section's solid quads while it fades
// (gfx.rs `SectionGpu::gpu_fading`), and the pass leaves it out.
FADING :: 1

    // rust: impl Record {
    // rust: const FREE: Self = Self {
    // rust: key: [0, 0, 0, -1],
    // rust: a: [0; 4],
    // rust: ends: [0; 6],
    // rust: keys: [0; 6],
}
BYTES :: std::mem::size_of::<Self>() as u64
    // `quads` solid quads from vertex `start` of arena page `page`, within the
    // box `boxed` (`rounded_box`), all in the other bucket, drawn from
    // everywhere, as a mesh that was not sorted (`Sides::unsorted`).
new :: proc(key: SectionKey, page: u32, start: u64, quads: u32, boxed: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: key: [key.0, key.1, key.2, page as i32],
    // rust: a: [start as u32, quads, boxed, 0],
    // rust: ends: [0, 0, quads, quads, quads, quads],
    // rust: keys: [0; 6],
}
}
    // The record, its solid quads in `sides`' buckets by the side they face,
    // so that the pass draws the runs of them that can face the eye as the CPU
    // does (gfx.rs `facing_runs`). A mesh sorted for two passes (Metal's,
    // which GPU culling never runs on) stays drawn whole.
facing :: proc(sides: ^Sides) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Some((ends, t)) = sides.thresholds() else {
    // rust: return self;
}
    // rust: let quads = self.a[1];
    // rust: debug_assert_eq!(ends[6], quads, "its buckets hold its solid quads");
        // Within its solid quads whatever its buckets say, so its runs are too.
    // rust: self.ends = std::array::from_fn(|b| ends[b].min(quads));
    // rust: self.keys = [0, 1, 3, 4, 5, 6].map(|b| threshold_key(t[b], b < 4));
    // rust: self
}
    // The record, `FADING` when `on`.
fading :: proc(on: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if on {
    // rust: self.a[3] |= FADING;
}
    // rust: self
}
page :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: u32::try_from(self.key[3]).ok()
}
is_fading :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (self.a[3] & FADING) != 0
}
}

// `x` as a u32 that orders as `x` does among the floats that are not NaN, -0
// as 0: `a < b` exactly when `order_key(a) < order_key(b)`. The shader
// compares these where the CPU compares the floats, so no flush of subnormal
// floats (FXC's, a Vulkan driver's) changes an answer.
order_key :: proc(x: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let bits = if x == 0.0 { 0 } else { x.to_bits() };
    // Below 0, larger bits are smaller floats.
    // rust: if bits < 0x8000_0000 {
    // rust: bits | 0x8000_0000
    // rust: } else {
    // rust: !bits
}
}

// A bucket's threshold as a key (`Record::facing`). A NaN, which
// `Sides::visible_from` finds no eye past, gets a key no eye's passes: above
// +∞'s for a bucket facing a positive direction, which an eye must exceed,
// below -∞'s for one facing a negative direction. `sort` makes none: a quad
// joins a side only when its four corners are equal along its axis, which
// NaN never is.
threshold_key :: proc(t: f32, positive: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match (t.is_nan(), positive) {
    // rust: (false, _) => order_key(t),
    // rust: (true, true) => u32::MAX,
    // rust: (true, false) => 0,
}
}

// The most draws a section has: the runs its buckets that can face the eye
// lie in. Two runs are apart by a bucket left out, so 7 buckets hold at most 4.
RUNS :: 4
// Words per id in `runs` (the shader's `RUN_WORDS`): its page, flags and draws,
// then each draw's first quad and quads, then its two occlusion stamps.
RUN_WORDS :: 1 + 2 * RUNS as u64 + 2

// `rounded_box` for bounds past what a box's codes hold, or not finite: no
// frustum plane rejects it, so it is drawn wherever its column is within the
// render distance.
UNBOUNDED :: 1 << 31
// What a box's ends, -8 to 23 blocks from its section's origin, add to make
// their 5-bit codes.
CODE_OFFSET :: 8

// A record's box: its section's quad bounds (`SectionMesh::bounds`; `None` is
// the whole cell) rounded out to whole blocks, each low end at most 16 and
// each high end at least 0, so that along every axis the box reaches its cell.
// A column the walk finds entirely inside the frustum then holds no box the
// frustum test rejects, whatever its bounds. Packed as 5-bit codes: the low
// ends along x, y and z in bits 0 to 14, the high ends in bits 15 to 29.
// `UNBOUNDED` where an end is past -8 to 23 (never clamped inward) or the
// bounds are not finite.
    // rust: pub(super) fn rounded_box(bounds: Option<[Vec3; 2]>) -> u32 {
    // rust: let [min, max] = bounds.unwrap_or([Vec3::ZERO, Vec3::splat(16.0)]);
    // rust: let mut packed = 0;
    // rust: for axis in 0..3 {
        // `as` takes NaN to 0: tested first.
    // rust: if !(min[axis].is_finite() && max[axis].is_finite()) {
    // rust: return UNBOUNDED;
}
    // rust: let low = (min[axis].floor() as i32).min(16);
    // rust: let high = (max[axis].ceil() as i32).max(0);
    // rust: if low < -CODE_OFFSET || high > 31 - CODE_OFFSET {
    // rust: return UNBOUNDED;
}
    // rust: packed |= (((low + CODE_OFFSET) as u32) << (5 * axis))
    // rust: | (((high + CODE_OFFSET) as u32) << (15 + 5 * axis));
}
    // rust: packed
}

// A changed record, for `apply` (`gpu_culling.wgsl`'s `Update`).
Update :: struct {
    // Its id, and padding to the record's alignment.
    id: [u32,
    record: Record,
}

    // rust: impl Update {
BYTES :: std::mem::size_of::<Self>() as u64
}

// `gpu_culling.wgsl`'s `Params`.
Params :: struct {
    // Ids the pass tests, and the `Update`s `apply` writes.
    ids: u32,
    updates: u32,
    // Arena pages the counts and regions cover (at least one), and where the
    // regions start in `tables`, in words.
    pages: u32,
    regions: u32,
    // Bits 3j, 3j + 1 and 3j + 2: frustum plane j's x, y and z are at least 0.
    signs: u32,
    // The render distance in columns, and the camera's column.
    near: i32,
    cam_x: i32,
    cam_z: i32,
    // The tables' first column: x, 0, z, 0.
    first: [i32,
    // Their entries along x, y and z, and 0.
    cells: [u32,
    // Each frustum plane's w term, its margin in (`tables`), then 0, 0.
    w: [[i32,
    // Cave culling's graph (`Reach`): from x, from z, radius, lowest section y.
    reach: [i32,
    // Its height in sections, and the level's (the sky band's top section).
    reach_height: i32,
    reach_sections: i32,
    // `REACH`, `SKY`, `EYE`, `OCCLUDE`, `PROBE`.
    flags: u32,
    // With `EYE`, where the eye's keys start in `tables`, in words.
    eyes: u32,
    // With `OCCLUDE`: the frame's stamp (never 0), where the boxes to test
    // start in `counts`, in words, 0, 0.
    occl: [u32,
    // The world pass's view projection, which the test draws its boxes with.
    view_proj: [[f32,
}

// Counts before the pages' (the shader's `STATS`): the sections `cull` kept,
// the draws (fewer only where a region was short), then occlusion's: the
// quads of the sections with runs and of the tested boxes not seen (the
// gate's share), the box draw (its instances: the boxes tested), and the
// boxes not seen.
STATS :: 12
QUADS :: 2
HIDDEN_QUADS :: 3
BOX :: 4
HIDDEN :: 9
// Statistics on their way back at once, a frame or a few late so the CPU never
// waits (as `cull`'s results).
READBACKS :: 3
FREE :: 0
PENDING :: 1
MAPPED :: 2
// Its mapping failed or the device lost its buffer: never copied into or
// unmapped again, so the statistics stop (as `timing::GpuTimer`'s).
FAILED :: 3
// In `Params::flags` (the shader's `REACH`): cave culling's graph is in
// `reach`.
REACH :: 1
// In `Params::flags` (the shader's `SKY`): its search reached the box's top
// layer, so the sky band above a clamped box is reached.
SKY :: 2
// In `Params::flags` (the shader's `EYE`): solid quads facing away from the
// eye are left out, its keys in `tables` from `Params::eyes`.
EYE :: 4
// In `Params::flags` (the shader's `OCCLUDE` and `PROBE`): the frame occludes,
// and it tests every box (cull.rs's probe frame).
OCCLUDE :: 8
PROBE :: 16
// Ids per block (the shader's `BLOCK`), and the workgroup of the passes over ids.
WORKGROUP :: 64
// Workgroups along x when there are more (the shader's `ROW`).
ROW :: 65535
// Changed records past which the whole table is written at once: their
// updates would pass a megabyte, the staging belt's chunk (`upload::Uploads`).
DIRTY_LIMIT :: (1 << 20) / Update::BYTES 
// The frustum test's unit: its terms are 256ths of a block.
SCALE :: 256.0
// f32's unit roundoff: one rounding of the walk's f32 frustum test is off by
// at most this share of its result.
UNIT :: f32::EPSILON as f64 / 2.0
// The most a plane's terms may sum to in magnitude: below it no partial sum of
// them, in any order, leaves i32.
HEADROOM :: (1 << 30) as f64

// Tests read the counts, draws and origins back.
    // rust: const TEST_READ: wgpu::BufferUsages = if cfg!(test) {
    // rust: wgpu::BufferUsages::COPY_SRC
    // rust: } else {
    // rust: wgpu::BufferUsages::empty()
}

// What a frame's pass works from.
    // rust: pub(super) struct FrameInputs<'a> {
    // rust: pub camera: DVec3,
    // The level's lowest block y and its height in sections.
    // rust: pub min_y: i32,
    // rust: pub sections: i32,
    // The render distance in columns, as the walk takes it.
    // rust: pub radius: i32,
    // The frustum the walk culls with (a GPU frame has no water mirror).
    // rust: pub frustum: &'a Frustum,
    // The cave-culling graph, while cave culling runs and has one
    // (`Occlusion::reach`); `None`: every section counts as reached.
    // rust: pub reach: Option<Reach<'a>>,
    // The eye (gfx.rs `projection_center`), while solid quads facing away
    // from it are left out (`sides_on`); `None`: every solid quad is drawn. A
    // GPU frame has no water mirror, whose eye below would see more of them.
    // rust: pub eye: Option<Vec3>,
    // The world pass's view projection (gfx.rs `globals.view_proj`), and
    // whether occlusion culling is on: frames that can run its test then
    // do, by its gate (`GpuCulling::occluding`).
    // rust: pub view_proj: Mat4,
    // rust: pub occlude: bool,
}

// What `GpuCulling::prepare` made of a frame.
    // rust: pub(super) enum Prepared {
    // The pass is ready: `dispatch` it, and `draw`.
    // rust: Gpu,
    // The frame's frustum planes would leave the test's integers (`HEADROOM`),
    // its camera is not finite, or its eye less an origin is not a number:
    // the CPU draws it, and the records that changed are written by the next
    // frame the GPU draws.
    // rust: Cpu,
    // A buffer failed to grow.
    // rust: OutOfMemory,
}

// The frame's `tables` before the regions, into `words`, and the parameters
// the frustum test and facing read with them; `None` when the CPU draws the
// frame (`Prepared::Cpu`): a sum of a plane's terms could leave i32
// (`HEADROOM`), the camera is not finite, or the eye less an origin is NaN,
// which no key orders.
//
// The words: the origins' f32 bits along x (the columns within the render
// distance), y (the level's sections) and z, the walk's own
// `resident::origin(..).as_vec3()`; per plane, its terms for those origins
// along x, y and z; per plane and axis, its terms for the 32 box codes; with
// an eye, its keys (`Params::eyes`): the eye less each origin, the f32
// difference `facing_runs_from` takes along that axis, as an `order_key`. A term
// is the plane's component times an origin or a box's end, in 256ths of a
// block, rounded up: the product of two f32 values is exact in f64, so a
// plane's terms for a section sum to at least 256 times its exact value at the
// corner of the box `Frustum::intersects` looks at. Its w carries a margin over
// what the walk's f32 test can round away, at most 6u |p| V + 2u |w| (u is
// `UNIT`, V the largest corner along each axis): the corner `fl(o + b)`, the
// products and sums of `intersects`, and the column top `fl(o + 16)` of
// `contains`, each off by at most u of its size. So the GPU keeps every box the
// walk keeps, and every box of a column the walk finds entirely inside the
// frustum, as each box reaches its cell (`rounded_box`). A plane that is not
// finite rejects nothing, as in `intersects`: its terms are 0, its w 1.
tables :: proc(input: ^FrameInputs<'_>, words: ^[dynamic]u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: words.clear();
    // Before the origins: an infinite camera's column would take
    // `resident::origin` past i32.
    // rust: if !input.camera.is_finite() {
    // rust: return None;
}
    // rust: let radius = input.radius.max(0);
    // rust: let side = 2 * radius + 1;
    // rust: let height = input.sections.max(0);
    // rust: let (cx, cz) = resident::camera_column(input.camera);
    // rust: let (x0, z0) = (cx - radius, cz - radius);
    // rust: let origin = |key| resident::origin(key, input.min_y, input.camera).as_vec3();
    // rust: words.extend((x0..x0 + side).map(|x| origin((x, 0, 0)).x.to_bits()));
    // rust: words.extend((0..height).map(|y| origin((0, y, 0)).y.to_bits()));
    // rust: words.extend((z0..z0 + side).map(|z| origin((0, 0, z)).z.to_bits()));
    // rust: let (nx, ny) = (side as usize, height as usize);
    // rust: let axes = [0..nx, nx..nx + ny, nx + ny..words.len()];
    // Along each axis, the largest origin plus 24: more than any corner of a box
    // (its ends reach 23) or of a column's box.
    // rust: let reach = axes.clone().map(|axis| {
    // rust: let sizes = words[axis]
    // rust: .iter()
    // rust: .map(|&o| f64::from(f32::from_bits(o)).abs());
    // rust: sizes.fold(0.0, f64::max) + 24.0
    // rust: });
    // rust: let planes = input.frustum.planes.map(|p| {
    // rust: if p.is_finite() {
    // rust: p.as_dvec4()
    // rust: } else {
    // rust: DVec4::ZERO
}
    // rust: });
    // Each plane's largest terms in magnitude, along each axis, which bound its
    // sums.
    // rust: let mut largest = [0.0; 6];
    // rust: for (j, p) in planes.iter().enumerate() {
    // rust: for (axis, origins) in axes.iter().enumerate() {
    // rust: let mut most: f64 = 0.0;
    // rust: for i in origins.clone() {
    // rust: let term = (SCALE * (p[axis] * f64::from(f32::from_bits(words[i])))).ceil();
    // rust: most = most.max(term.abs());
    // rust: words.push(term as i32 as u32);
}
    // rust: largest[j] += most;
}
}
    // rust: let mut signs: u32 = 0;
    // rust: for (j, p) in planes.iter().enumerate() {
    // rust: for axis in 0..3 {
            // `intersects` looks at a box's high end where the plane's component
            // is at least 0 (alike in f64).
    // rust: signs |= u32::from(p[axis] >= 0.0) << (3 * j + axis);
    // rust: let mut most: f64 = 0.0;
    // rust: for code in 0..32 {
    // rust: let term = (SCALE * p[axis] * f64::from(code - CODE_OFFSET)).ceil();
    // rust: most = most.max(term.abs());
    // rust: words.push(term as i32 as u32);
}
    // rust: largest[j] += most;
}
}
    // The eye's keys, its own f32 difference with each origin as the CPU takes
    // it for every section it draws (`facing_runs_from`).
    // rust: let (mut eyes, mut nan) = (0, false);
    // rust: if let Some(eye) = input.eye {
    // rust: eyes = words.len() as u32;
    // rust: for (axis, origins) in axes.iter().enumerate() {
    // rust: for i in origins.clone() {
    // rust: let d = eye[axis] - f32::from_bits(words[i]);
    // rust: nan |= d.is_nan();
    // rust: words.push(order_key(d));
}
}
}
    // rust: let w = planes.map(|p| {
    // rust: let rounding: f64 = (0..3).map(|axis| p[axis].abs() * reach[axis]).sum();
    // rust: let margin = (SCALE * (6.0 * UNIT * rounding + 2.0 * UNIT * p.w.abs())).ceil() + 1.0;
    // rust: (SCALE * p.w).ceil() + margin
    // rust: });
    // rust: let fits = (0..6).all(|j| largest[j] + w[j].abs() <= HEADROOM);
    // rust: if !fits || nan {
    // rust: return None;
}
    // rust: let w = w.map(|w| w as i32);
    // rust: Some(Params {
    // rust: signs,
    // rust: near: radius,
    // rust: cam_x: cx,
    // rust: cam_z: cz,
    // rust: first: [x0, 0, z0, 0],
    // rust: cells: [side as u32, height as u32, side as u32, 0],
    // rust: w: [[w[0], w[1], w[2], w[3]], [w[4], w[5], 0, 0]],
    // rust: flags: if input.eye.is_some() { EYE } else { 0 },
    // rust: eyes,
    // rust: ..Default::default()
    // rust: })
}

// Whether GPU culling is offered: where the device draws a count the GPU wrote
// and runs compute shaders, where its multi-draws offset instance-rate origins
// by each draw's first instance (`multi_draw`; Intel Gen11/Gen12's Vulkan
// driver gets that wrong, `flat::is_broken_intel_vulkan`, tested here too for
// when flat draws are off), where Translucent Batching is
// (`translucent_batchable`), and where vanilla frames never draw flat (flat
// draws off, or for a shader pack's terrain alone): flat draws copy the CPU's
// lists.
    // rust: pub(super) fn supported(
    // rust: info: &wgpu::AdapterInfo,
    // rust: features: wgpu::Features,
    // rust: downlevel: wgpu::DownlevelFlags,
    // rust: limits: &wgpu::Limits,
    // rust: multi_draw: bool,
    // rust: flat_min_sections: Option<usize>,
    // rust: ) -> bool {
    // rust: super::translucent_batchable(info, multi_draw)
    // rust: && flat_min_sections.is_none_or(|min| min == usize::MAX)
    // rust: && features.contains(wgpu::Features::MULTI_DRAW_INDIRECT_COUNT)
    // rust: && downlevel.contains(wgpu::DownlevelFlags::COMPUTE_SHADERS)
        // The pass binds 8, the last cave culling's graph.
    // rust: && limits.max_storage_buffers_per_shader_stage >= 8
    // rust: && !super::flat::is_broken_intel_vulkan(info)
    // rust: && !loses_base_vertex(info, flat_min_sections.is_some())
}

// DX12's count draws leave each draw's base vertex out of `vertex_index`, by which the
// pulled solid pipelines (those of a device with flat page groups) read the page.
// shortcut: not offered there, until GPU culling's draws carry their base vertex otherwise.
    // rust: pub(super) fn loses_base_vertex(info: &wgpu::AdapterInfo, flat_page_groups: bool) -> bool {
    // rust: info.backend == wgpu::Backend::Dx12 && flat_page_groups
}

// What the settings offer (`graphics::GpuCullingOffer`): where `supported`
// holds, but not on a software adapter (WARP, lavapipe), whose pass would run
// on the CPU beside the frame, as occlusion culling's default has it; where it
// doesn't, DX12 with flat page groups says why (`loses_base_vertex`).
    // rust: pub(super) fn offer(
    // rust: info: &wgpu::AdapterInfo,
    // rust: supported: bool,
    // rust: flat_page_groups: bool,
    // rust: ) -> GpuCullingOffer {
    // rust: match (supported, super::is_software(info.device_type)) {
    // rust: (false, _) if loses_base_vertex(info, flat_page_groups) => GpuCullingOffer::Dx12,
    // rust: (false, _) => GpuCullingOffer::Unsupported,
    // rust: (true, true) => GpuCullingOffer::Software,
    // rust: (true, false) => GpuCullingOffer::Offered,
}
}

// A buffer that is recreated larger when it must hold more.
Grown :: struct {
    buffer: wgpu::Buffer,
    bytes: u64,
    label: ^'static str,
    usage: wgpu::BufferUsages,
}

    // rust: impl Grown {
    // rust: fn new(
    // rust: device: &wgpu::Device,
    // rust: label: &'static str,
    // rust: bytes: u64,
    // rust: usage: wgpu::BufferUsages,
    // rust: ) -> Option<Self> {
    // rust: Some(Self {
    // rust: buffer: try_create(device, label, bytes, usage)?,
    // rust: bytes,
    // rust: label,
    // rust: usage,
    // rust: })
}
    // Room for `bytes`, in a power of two within the device's limits:
    // `Some(true)` when the buffer was made anew (its contents lost), `None`
    // past the limits or when the memory for it is missing.
reserve :: proc(self: ^Self, device: ^wgpu::Device, bytes: u64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if bytes <= self.bytes {
    // rust: return Some(false);
}
    // rust: let limits = device.limits();
    // rust: let mut limit = limits.max_buffer_size;
    // rust: if self.usage.contains(wgpu::BufferUsages::STORAGE) {
    // rust: limit = limit.min(limits.max_storage_buffer_binding_size);
}
    // rust: if bytes > limit {
    // rust: return None;
}
    // rust: let size = bytes.next_power_of_two().min(limit & !3);
    // rust: self.buffer = try_create(device, self.label, size, self.usage)?;
    // rust: self.bytes = size;
    // rust: Some(true)
}
    // `reserve`, keeping what the buffer held (`runs`' stamps).
    // rust: fn reserve_keeping(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: bytes: u64,
    // rust: ) -> Option<bool> {
    // rust: let (old, old_bytes) = (self.buffer.clone(), self.bytes);
    // rust: let made = self.reserve(device, bytes)?;
    // rust: if made {
    // rust: encoder.copy_buffer_to_buffer(&old, 0, &self.buffer, 0, old_bytes);
}
    // rust: Some(made)
}
}

// The section table as the CPU keeps it, by id, and what changed since
// `GpuCulling::prepare` last wrote it.
    // rust: pub(super) struct Records {
    // rust: records: Vec<Record>,
    // Free ids below the table's end, a bit each (64 a word, lowest bit first).
    // rust: free: Vec<u64>,
    // No free id is below `64 *` this.
    // rust: first_free: usize,
    // Ids changed since, unless there were too many to list (`all_dirty`).
    // rust: dirty: Vec<u32>,
    // rust: all_dirty: bool,
    // Per arena page, the records on it.
    // rust: page_sections: Vec<u32>,
    // The records flagged `FADING`.
    // rust: fading: u32,
}

    // rust: impl Records {
    // A resident section with solid quads, `record` (`SectionGpu::record`):
    // its id, the lowest free one or a new one.
insert :: proc(self: ^Self, record: Record) -> u {
    // Ported from Horizon
    return {}
}
    // rust: debug_assert!(record.page().is_some(), "a record names its page");
    // rust: let id = match self.take_free() {
    // rust: Some(id) => id,
    // rust: None => {
    // rust: self.records.push(Record::FREE);
    // rust: self.records.len() as u32 - 1
}
}
    // rust: self.records[id as usize] = record;
    // rust: self.add_to(record.key[3] as u32);
    // rust: self.fading += u32::from(record.is_fading());
    // rust: self.mark(id);
    // rust: id
}
    // The section with `id` went.
remove :: proc(self: ^Self, id: u32) {
}
    // rust: self.remove_all([id]);
}
    // The sections with `ids` went, a bit set for each (a teleport frees tens of
    // thousands at once, `Renderer::remove_columns_at_once`). Each is marked, so
    // the GPU has it free before the pass next culls: the pass keeps any record
    // in view, and a stale one would draw quads that are gone or another
    // section's.
remove_all :: proc(self: ^Self, ids: impl IntoIterator<Item = u32>) {
}
    // rust: for id in ids {
    // rust: let page = self.records.get(id as usize).and_then(Record::page);
    // rust: debug_assert!(page.is_some(), "no record {id} to remove");
    // rust: let Some(page) = page else {
    // rust: continue;
}
    // rust: self.page_sections[page as usize] -= 1;
    // rust: self.fading -= u32::from(self.records[id as usize].is_fading());
    // rust: self.records[id as usize] = Record::FREE;
            // shortcut: a teleport frees more than `DIRTY_LIMIT`, so `prepare` writes the
            // whole table (0.6-2.6 ms at render distance 64); upgrade to a list of freed ids
            // the pass reads, a word each, if those frames need it.
    // rust: self.mark(id);
    // rust: let word = id as usize / 64;
    // rust: if self.free.len() <= word {
    // rust: self.free.resize(word + 1, 0);
}
    // rust: self.free[word] |= 1 << (id % 64);
    // rust: self.first_free = self.first_free.min(word);
}
        // Free ids at the end leave the table, so the pass tests fewer.
    // rust: while self.records.last().is_some_and(|r| r.page().is_none()) {
    // rust: self.records.pop();
    // rust: let id = self.records.len();
    // rust: self.free[id / 64] &= !(1 << (id % 64));
}
    // rust: self.free.truncate(self.records.len().div_ceil(64));
    // rust: self.first_free = self.first_free.min(self.free.len());
}
    // The lowest free id, taken.
take_free :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: while let Some(&word) = self.free.get(self.first_free) {
    // rust: if word != 0 {
    // rust: self.free[self.first_free] = word & (word - 1);
    // rust: return Some((self.first_free * 64) as u32 + word.trailing_zeros());
}
    // rust: self.first_free += 1;
}
    // rust: None
}
    // The section with `id` moved to vertex `start` of page `page`, its quads
    // with it (`move_off_page`).
relocate :: proc(self: ^Self, id: u32, page: u32, start: u64) {
}
    // rust: let from = self.records.get(id as usize).and_then(Record::page);
    // rust: debug_assert!(from.is_some(), "no record {id} to move");
    // rust: let Some(from) = from else {
    // rust: return;
}
    // rust: let record = &mut self.records[id as usize];
    // rust: record.key[3] = page as i32;
    // rust: record.a[0] = start as u32;
    // rust: self.page_sections[from as usize] -= 1;
    // rust: self.add_to(page);
    // rust: self.mark(id);
}
    // The section with `id` began to draw faded, or stopped (gfx.rs
    // `SectionGpu::gpu_fading`): its record is `FADING` when `on`.
set_fading :: proc(self: ^Self, id: u32, on: bool) {
}
    // rust: let page = self.records.get(id as usize).and_then(Record::page);
    // rust: debug_assert!(page.is_some(), "no record {id} to flag");
    // rust: if page.is_none() || self.records[id as usize].is_fading() == on {
    // rust: return;
}
    // rust: self.records[id as usize].a[3] ^= FADING;
    // rust: if on {
    // rust: self.fading += 1;
    // rust: } else {
    // rust: self.fading -= 1;
}
    // rust: self.mark(id);
}
    // Every section went.
clear :: proc(self: ^Self) {
}
    // rust: self.records.clear();
    // rust: self.free.clear();
    // rust: self.first_free = 0;
    // rust: self.dirty = Vec::new();
    // rust: self.all_dirty = false;
    // rust: self.page_sections.clear();
    // rust: self.fading = 0;
}
    // The sections with a record.
live :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let free: u32 = self.free.iter().map(|word| word.count_ones()).sum();
    // rust: self.records.len() - free as usize
}
    // The sections whose record is `FADING`, which the CPU draws.
fading :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.fading
}
    // The record of the section with `id`; `None` for a free id.
at :: proc(self: ^Self, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.records.get(id as usize).filter(|r| r.page().is_some())
}
page_sections :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.page_sections
}
    // The table's end: the ids the pass tests.
ids :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.records.len() as u32
}
add_to :: proc(self: ^Self, page: u32) {
}
    // rust: let page = page as usize;
    // rust: if self.page_sections.len() <= page {
    // rust: self.page_sections.resize(page + 1, 0);
}
    // rust: self.page_sections[page] += 1;
}
mark :: proc(self: ^Self, id: u32) {
}
    // rust: if self.all_dirty {
    // rust: return;
}
    // rust: if self.dirty.len() >= DIRTY_LIMIT {
    // rust: self.all_dirty = true;
    // rust: self.dirty = Vec::new();
    // rust: } else {
    // rust: self.dirty.push(id);
}
}
}

// The flagged sections by when their fade is over at the latest (gfx.rs
// `SectionGpu::fade_end`), for gfx.rs `mark_fades` to look at them again
// then, and the chunk fade-in time their flags were decided with: `None`
// until a frame has decided them, just after GPU culling was switched on.
// The ends of sections that went or were handed back are skipped as they come.
    // rust: pub(super) struct Fades {
    // rust: due: BinaryHeap<Reverse<(Instant, SectionKey)>>,
    // rust: pub fade_ms: Option<u64>,
}

    // rust: impl Fades {
    // The section at `key` is looked at again at `end`.
push :: proc(self: ^Self, end: Instant, key: SectionKey) {
}
    // rust: self.due.push(Reverse((end, key)));
}
    // The section of the earliest end at or before `now`, taken out.
pop_due :: proc(self: ^Self, now: Instant) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let &Reverse((end, key)) = self.due.peek()?;
    // rust: if end > now {
    // rust: return None;
}
    // rust: self.due.pop();
    // rust: Some(key)
}
    // Every end goes; `fade_ms` stays.
clear :: proc(self: ^Self) {
}
    // rust: self.due.clear();
}
    // The sections an end is waited for.
pending :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.due.iter().map(|r| r.0.1)
}
}

// One GPU frame's statistics on their way back: `counts[..STATS]`, and what
// the CPU drew of the same frame.
Readback :: struct {
    buffer: wgpu::Buffer,
    state: ^AtomicU8,
    // Its frame (gfx.rs `frame_serial`), and the CPU's part of its statistics:
    // the sections it drew that the pass didn't count, its section draws, and
    // every draw call.
    frame: u64,
    cpu: [uint,
    // Its frame occluded: its counts carry the test's.
    occluded: bool,
}

// The occlusion test (`gpu_occlusion.wgsl`): its boxes' pipeline and bind
// group, and phase 2's passes (count2, scan2, scatter2).
BoxTest :: struct {
    pipeline: wgpu::RenderPipeline,
    layout: wgpu::BindGroupLayout,
    group: Maybe(wgpu::BindGroup),
    phase2: [wgpu::ComputePipeline,
}

    // rust: impl BoxTest {
    // `color`: the world pass's colour format. `None` when the device fails to
    // make the pipelines: GPU culling then runs without the test.
    // rust: fn new(
    // rust: device: &wgpu::Device,
    // rust: color: wgpu::TextureFormat,
    // rust: compute: &wgpu::BindGroupLayout,
    // rust: ) -> Option<Self> {
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let internal = device.push_error_scope(wgpu::ErrorFilter::Internal);
    // rust: let entry = |binding, visibility, ty| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
    // rust: let storage = |read_only| wgpu::BufferBindingType::Storage { read_only };
//         use wgpu::ShaderStages as S;
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("GPU culling occlusion test"),
    // rust: entries: &[
    // rust: entry(0, S::VERTEX_FRAGMENT, wgpu::BufferBindingType::Uniform),
    // rust: entry(9, S::VERTEX, storage(true)),
    // rust: entry(10, S::VERTEX, storage(true)),
    // rust: entry(11, S::FRAGMENT, storage(false)),
    // rust: entry(12, S::VERTEX, storage(true)),
    // rust: ],
    // rust: });
    // rust: let source = [
    // rust: include_str!("gpu_culling.wgsl"),
    // rust: include_str!("gpu_occlusion.wgsl"),
    // rust: ]
    // rust: .concat();
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("GPU culling occlusion test"),
    // rust: source: wgpu::ShaderSource::Wgsl(source.into()),
    // rust: });
    // rust: let layouts = [Some(&layout)];
    // rust: let box_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("GPU culling occlusion test"),
    // rust: bind_group_layouts: &layouts,
    // rust: ..Default::default()
    // rust: });
        // cull.rs's `Early` pipeline: front faces against the world pass's
        // reversed depth, without writes.
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("GPU culling occlusion test"),
    // rust: layout: Some(&box_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some("vs_box"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: Some(wgpu::Face::Back),
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some("fs_box"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: color,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::empty(),
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let compute_layouts = [Some(compute)];
    // rust: let compute_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("GPU culling phase 2"),
    // rust: bind_group_layouts: &compute_layouts,
    // rust: ..Default::default()
    // rust: });
    // rust: let phase2 = ["count2", "scan2", "scatter2"].map(|entry| {
    // rust: device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some("GPU culling phase 2"),
    // rust: layout: Some(&compute_layout),
    // rust: module: &module,
    // rust: entry_point: Some(entry),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: })
    // rust: });
    // rust: let internal = pollster::block_on(internal.pop());
    // rust: if let Some(e) = internal.or(pollster::block_on(validation.pop())) {
    // rust: log::warn!("Horizon renderer: GPU culling's occlusion test unavailable ({e})");
    // rust: return None;
}
    // rust: Some(Self {
    // rust: pipeline,
    // rust: layout,
    // rust: group: None,
    // rust: phase2,
    // rust: })
}

    // Its bind group: the parameters, then the test list (`counts`), the
    // origins, the stamps (`runs`) and the records.
bind :: proc(self: ^Self, device: ^wgpu::Device, buffers: [^wgpu::Buffer; 5]) -> w {
    // Ported from Horizon
    return {}
}
    // rust: let entries = [0, 9, 10, 11, 12]
    // rust: .into_iter()
    // rust: .zip(buffers)
    // rust: .map(|(binding, buffer)| wgpu::BindGroupEntry {
    // rust: binding,
    // rust: resource: buffer.as_entire_binding(),
    // rust: });
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("GPU culling occlusion test"),
    // rust: layout: &self.layout,
    // rust: entries: &entries.collect::<Vec<_>>(),
    // rust: })
}
}

// The pass, its buffers and the records it draws from: made when GPU culling
// is switched on, dropped when it is switched off.
    // rust: pub(super) struct GpuCulling {
    // `gpu_culling.wgsl`'s entry points: apply, cull, scan, scatter.
    // rust: pipelines: [wgpu::ComputePipeline; 4],
    // rust: layout: wgpu::BindGroupLayout,
    // rust: params: wgpu::Buffer,
    // rust: sections: Grown,
    // rust: tables: Grown,
    // rust: updates: Grown,
    // rust: counts: Grown,
    // rust: draws: Grown,
    // rust: origins: Grown,
    // rust: runs: Grown,
    // Cave culling's graph, its `Reach::bits`.
    // rust: reach: Grown,
    // The generation `reach` holds (`Reach::generation`); `None` until it is
    // written, or after it was made anew.
    // rust: reach_generation: Option<u64>,
    // Dropped as soon as one of its buffers is made anew.
    // rust: group: Option<wgpu::BindGroup>,
    // What `sections` holds once `prepare` writes it; a field of its own, so
    // that the arena's compaction moves records while it borrows the
    // renderer's other fields.
    // rust: pub records: Records,
    // When the flagged records' fades end, a field of its own as `records`
    // is: gfx.rs `mark_fades` takes both beside the renderer's sections.
    // rust: pub fades: Fades,
    // This frame's pages with records: (page, first draw of its region, the
    // region's size).
    // rust: pages: Vec<(u32, u32, u32)>,
    // This frame's ids to test, records to `apply`, and pages the counts
    // cover (at least one).
    // rust: ids: u32,
    // rust: n_updates: u32,
    // rust: pass_pages: u32,
    // This frame's updates and table words, kept for their room.
    // rust: scratch: Vec<Update>,
    // rust: words: Vec<u32>,
    // The statistics on their way back (`Readback`), the next one to copy
    // into, and this frame's copy.
    // rust: readbacks: Vec<Readback>,
    // rust: next: usize,
    // rust: current: Option<usize>,
    // The occlusion test, where the device can run it (Vulkan, with cull.rs's
    // test forced early: `Cull::early`).
    // rust: test: Option<BoxTest>,
    // Advanced by every frame that may occlude (never 0); the newest share of
    // quads the test hid, with its frame; whether this frame occludes; and the
    // newest result's boxes not seen and tested.
    // rust: stamp: u32,
    // rust: share: (u64, f32),
    // rust: occluding: bool,
    // rust: hidden: Option<[usize; 2]>,
}

    // rust: impl GpuCulling {
    // `None` when the device fails to make the pipelines or the memory for the
    // buffers is missing (caught, not raised: raised errors are fatal). `test`:
    // the world pass's colour format, where frames can run the occlusion test.
new :: proc(device: ^wgpu::Device, test: Maybe(wgpu::TextureFormat)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let internal = device.push_error_scope(wgpu::ErrorFilter::Internal);
    // rust: let entry = |binding, ty| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::COMPUTE,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
    // rust: let storage =
    // rust: |binding, read_only| entry(binding, wgpu::BufferBindingType::Storage { read_only });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("GPU culling"),
    // rust: entries: &[
    // rust: entry(0, wgpu::BufferBindingType::Uniform),
    // rust: storage(1, false),
    // rust: storage(2, true),
    // rust: storage(3, true),
    // rust: storage(4, false),
    // rust: storage(5, false),
    // rust: storage(6, false),
    // rust: storage(7, false),
    // rust: storage(8, true),
    // rust: ],
    // rust: });
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("GPU culling"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("gpu_culling.wgsl").into()),
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("GPU culling"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pipelines = ["apply", "cull", "scan", "scatter"].map(|entry| {
    // rust: device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some("GPU culling"),
    // rust: layout: Some(&pipeline_layout),
    // rust: module: &module,
    // rust: entry_point: Some(entry),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: })
    // rust: });
    // rust: let internal = pollster::block_on(internal.pop());
    // rust: if let Some(e) = internal.or(pollster::block_on(validation.pop())) {
    // rust: log::warn!("Horizon renderer: GPU culling unavailable ({e})");
    // rust: return None;
}
    // rust: let test = test.and_then(|color| BoxTest::new(device, color, &layout));
//         use wgpu::BufferUsages as U;
    // rust: let readbacks = (0..READBACKS)
    // rust: .map(|_| {
    // rust: Some(Readback {
    // rust: buffer: try_create(
    // rust: device,
    // rust: "GPU culling statistics",
    // rust: STATS * 4,
    // rust: U::MAP_READ | U::COPY_DST,
    // rust: )?,
    // rust: state: Arc::new(AtomicU8::new(FREE)),
    // rust: frame: 0,
    // rust: cpu: [0; 3],
    // rust: occluded: false,
    // rust: })
    // rust: })
    // rust: .collect::<Option<Vec<_>>>()?;
    // rust: Some(Self {
    // rust: pipelines,
    // rust: layout,
    // rust: params: try_create(
    // rust: device,
    // rust: "GPU culling params",
    // rust: std::mem::size_of::<Params>() as u64,
    // rust: U::UNIFORM | U::COPY_DST,
    // rust: )?,
    // rust: sections: Grown::new(
    // rust: device,
    // rust: "GPU culling sections",
    // rust: 1024 * Record::BYTES,
    // rust: U::STORAGE | U::COPY_DST,
    // rust: )?,
    // rust: tables: Grown::new(
    // rust: device,
    // rust: "GPU culling tables",
    // rust: 1 << 14,
    // rust: U::STORAGE | U::COPY_DST,
    // rust: )?,
    // rust: updates: Grown::new(
    // rust: device,
    // rust: "GPU culling updates",
    // rust: 1024 * Update::BYTES,
    // rust: U::STORAGE | U::COPY_DST,
    // rust: )?,
    // rust: counts: Grown::new(
    // rust: device,
    // rust: "GPU culling counts",
    // rust: (STATS + 64) * 4,
                // The counts are copied out for the statistics (`copy_stats`).
    // rust: U::STORAGE | U::INDIRECT | U::COPY_DST | U::COPY_SRC,
    // rust: )?,
    // rust: draws: Grown::new(
    // rust: device,
    // rust: "GPU culling draws",
    // rust: 4096 * 20,
    // rust: U::STORAGE | U::INDIRECT | TEST_READ,
    // rust: )?,
    // rust: origins: Grown::new(
    // rust: device,
    // rust: "GPU culling origins",
    // rust: 1024 * 16,
    // rust: U::VERTEX | U::STORAGE | TEST_READ,
    // rust: )?,
            // Kept when it grows (`reserve_keeping`): it holds the stamps.
    // rust: runs: Grown::new(
    // rust: device,
    // rust: "GPU culling runs",
    // rust: 1024 * RUN_WORDS * 4,
    // rust: U::STORAGE | U::COPY_SRC | U::COPY_DST,
    // rust: )?,
            // Room for render distance 64's graph, 57.5 KB.
    // rust: reach: Grown::new(
    // rust: device,
    // rust: "GPU culling reach",
    // rust: 1 << 16,
    // rust: U::STORAGE | U::COPY_DST,
    // rust: )?,
    // rust: reach_generation: None,
    // rust: group: None,
    // rust: records: Records::default(),
    // rust: fades: Fades::default(),
    // rust: pages: Vec::new(),
    // rust: ids: 0,
    // rust: n_updates: 0,
    // rust: pass_pages: 1,
    // rust: scratch: Vec::new(),
    // rust: words: Vec::new(),
    // rust: readbacks,
    // rust: next: 0,
    // rust: current: None,
    // rust: test,
    // rust: stamp: 0,
            // cull.rs's start: culling until a result says otherwise.
    // rust: share: (0, 1.0),
    // rust: occluding: false,
    // rust: hidden: None,
    // rust: })
}

    // Records the frame's uploads into `encoder` and clears its counts, before
    // the walk: the records that changed (through the queue when the whole
    // table goes), the origins along each axis and the frustum planes' terms
    // (`tables`), the pages' regions, cave culling's graph when its generation
    // moved, and the parameters. Then `dispatch` and the world pass's `draw`.
    // Unless the frame is `Prepared::Gpu`, nothing is written, and nothing of
    // the frame is dispatched or drawn.
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &Queue,
    // rust: uploads: &mut Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: input: &FrameInputs<'_>,
    // rust: ) -> Prepared {
    // rust: self.pages.clear();
    // rust: self.ids = 0;
    // rust: self.n_updates = 0;
    // rust: self.occluding = false;
    // rust: self.prepare_buffers(device, queue, uploads, encoder, input)
    // rust: .unwrap_or(Prepared::OutOfMemory)
}

    // rust: fn prepare_buffers(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &Queue,
    // rust: uploads: &mut Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: input: &FrameInputs<'_>,
    // rust: ) -> Option<Prepared> {
        // Every buffer grows before anything is written. One made anew drops
        // the bind group at once, and a new section table needs every record:
        // a failure later, or a frame the CPU draws, keeps both for the next.
    // rust: let ids = self.records.ids();
    // rust: if self
    // rust: .sections
    // rust: .reserve(device, u64::from(ids) * Record::BYTES)?
    // rust: {
    // rust: self.group = None;
    // rust: self.records.all_dirty = true;
}
        // The changed records, each once; ids past the end left with the
        // records they held.
    // rust: self.scratch.clear();
    // rust: if !self.records.all_dirty {
    // rust: let Records { records, dirty, .. } = &mut self.records;
    // rust: dirty.sort_unstable();
    // rust: dirty.dedup();
    // rust: let changed = dirty.iter().filter(|&&id| id < ids);
    // rust: self.scratch.extend(changed.map(|&id| Update {
    // rust: id: [id, 0, 0, 0],
    // rust: record: records[id as usize],
    // rust: }));
}
        // The table words: the origins, the frustum planes' terms and the eye's
        // keys (`tables`), then each page's region.
    // rust: let planes = tables(input, &mut self.words);
    // rust: let regions = self.words.len() as u32;
    // rust: let pass_pages = self.records.page_sections.len().max(1) as u32;
        // A region has room for every draw of every record on its page.
    // rust: let total = RUNS * self.records.page_sections.iter().sum::<u32>();
        // The statistics, each page's count in both phases, each block's per
        // page in both phases, then where the test exists the boxes to test.
    // rust: let blocks = u64::from(ids.div_ceil(WORKGROUP));
    // rust: let phase1_end = STATS + u64::from(pass_pages) * (2 + blocks);
    // rust: let tests_at = phase1_end + u64::from(pass_pages) * blocks;
    // rust: let count_words = match self.test {
    // rust: Some(_) => tests_at + u64::from(ids),
    // rust: None => phase1_end,
}
    // rust: for (buffer, bytes) in [
    // rust: (&mut self.updates, self.scratch.len() as u64 * Update::BYTES),
    // rust: (&mut self.origins, u64::from(ids) * 16),
    // rust: (&mut self.tables, u64::from(regions + 2 * pass_pages) * 4),
    // rust: (&mut self.counts, count_words * 4),
    // rust: (&mut self.draws, u64::from(total.max(1)) * 20),
    // rust: ] {
    // rust: if buffer.reserve(device, bytes)? {
    // rust: self.group = None;
}
}
    // rust: if self
    // rust: .runs
    // rust: .reserve_keeping(device, encoder, u64::from(ids) * RUN_WORDS * 4)?
    // rust: {
    // rust: self.group = None;
}
        // A copy of the graph made anew holds none.
    // rust: if let Some(r) = &input.reach
    // rust: && self.reach.reserve(device, r.bits.len() as u64 * 4)?
    // rust: {
    // rust: self.group = None;
    // rust: self.reach_generation = None;
}
        // The planes past what the test's integers hold, or an eye no key
        // orders: the CPU draws the frame, and the records that changed wait
        // for the next.
    // rust: let Some(params) = planes else {
    // rust: return Some(Prepared::Cpu);
}
        // Occlusion, by cull.rs's gate over the share the newest test hid.
    // rust: let mut occl = 0;
    // rust: if self.test.is_some() && input.occlude {
    // rust: self.stamp = self.stamp.wrapping_add(1).max(1);
    // rust: let (occludes, probe) = super::cull::gate(self.share.1, self.stamp);
    // rust: if occludes && ids > 0 {
    // rust: self.occluding = true;
    // rust: occl = OCCLUDE | if probe { PROBE } else { 0 };
}
}
    // rust: if self.records.all_dirty {
            // The whole table, after it grew or more records changed than
            // updates take (GPU culling switched on in a loaded world, a
            // teleport). Through the queue, which waits for the frame on the
            // submit thread once, rather than the belt, which would keep a
            // staging buffer this large for good.
    // rust: if ids > 0 {
    // rust: queue.write_buffer(
    // rust: &self.sections.buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.records.records),
    // rust: );
}
    // rust: } else {
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.updates.buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.scratch),
    // rust: );
}
    // rust: self.records.dirty.clear();
    // rust: self.records.all_dirty = false;
    // rust: let (sizes, mut first) = (&self.records.page_sections, 0);
    // rust: for page in 0..pass_pages {
    // rust: let size = RUNS * sizes.get(page as usize).copied().unwrap_or(0);
    // rust: self.words.extend([first, size]);
    // rust: if size > 0 {
    // rust: self.pages.push((page, first, size));
}
    // rust: first += size;
}
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.tables.buffer,
    // rust: 0,
    // rust: bytemuck::cast_slice(&self.words),
    // rust: );
    // rust: let mut params = Params {
    // rust: ids,
    // rust: updates: self.scratch.len() as u32,
    // rust: pages: pass_pages,
    // rust: regions,
    // rust: occl: [self.stamp, tests_at as u32, 0, 0],
    // rust: view_proj: input.view_proj.to_cols_array_2d(),
    // rust: ..params
}
    // rust: params.flags |= occl;
    // rust: if let Some(r) = &input.reach {
    // rust: if self.reach_generation != Some(r.generation) {
                // Through the belt: a search lands every few frames while the
                // camera moves or sections load, and a write through the queue
                // waits for the submit thread.
    // rust: uploads.buffer(encoder, &self.reach.buffer, 0, bytemuck::cast_slice(r.bits));
    // rust: self.reach_generation = Some(r.generation);
}
    // rust: params.reach = [r.from_x, r.from_z, r.radius, r.y0];
    // rust: (params.reach_height, params.reach_sections) = (r.height, r.sections);
    // rust: params.flags |= REACH | if r.sky_reached { SKY } else { 0 };
}
    // rust: uploads.buffer(encoder, &self.params, 0, bytemuck::bytes_of(&params));
        // A frame that occludes reads phase 2's blocks too; the boxes to test
        // are written before they are read.
    // rust: let cleared = if self.occluding { tests_at } else { phase1_end };
    // rust: encoder.clear_buffer(&self.counts.buffer, 0, Some(cleared * 4));
    // rust: if self.group.is_none() {
    // rust: self.group = Some(self.bind(device));
    // rust: if let Some(test) = &mut self.test {
    // rust: test.group = Some(test.bind(
    // rust: device,
    // rust: [
    // rust: &self.params,
    // rust: &self.counts.buffer,
    // rust: &self.origins.buffer,
    // rust: &self.runs.buffer,
    // rust: &self.sections.buffer,
    // rust: ],
    // rust: ));
}
}
    // rust: self.ids = ids;
    // rust: self.n_updates = params.updates;
    // rust: self.pass_pages = pass_pages;
    // rust: Some(Prepared::Gpu)
}

bind :: proc(self: ^Self, device: ^wgpu::Device) -> w {
    // Ported from Horizon
    return {}
}
entry :: proc(binding: u32, buffer: ^wgpu::Buffer) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::BindGroupEntry {
    // rust: binding,
    // rust: resource: buffer.as_entire_binding(),
}
}
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("GPU culling"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: entry(0, &self.params),
    // rust: entry(1, &self.sections.buffer),
    // rust: entry(2, &self.tables.buffer),
    // rust: entry(3, &self.updates.buffer),
    // rust: entry(4, &self.counts.buffer),
    // rust: entry(5, &self.draws.buffer),
    // rust: entry(6, &self.origins.buffer),
    // rust: entry(7, &self.runs.buffer),
    // rust: entry(8, &self.reach.buffer),
    // rust: ],
    // rust: })
}

    // The pass, after `prepare`: the changed records into the table, then the
    // draws of the sections it keeps.
dispatch :: proc(self: ^Self, encoder: ^wgpu::CommandEncoder, timing: Maybe(^PassTiming)) {
}
    // rust: let Some(group) = self.group.as_ref().filter(|_| self.ids > 0) else {
    // rust: return;
}
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("GPU culling"),
    // rust: timestamp_writes: timing.and_then(|t| t.compute_writes("GPU culling")),
    // rust: });
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: let [apply, cull, scan, scatter] = &self.pipelines;
    // rust: if self.n_updates > 0 {
    // rust: pass.set_pipeline(apply);
    // rust: pass.dispatch_workgroups(self.n_updates.div_ceil(WORKGROUP), 1, 1);
}
    // rust: let blocks = self.ids.div_ceil(WORKGROUP);
    // rust: pass.set_pipeline(cull);
    // rust: pass.dispatch_workgroups(blocks.min(ROW), blocks.div_ceil(ROW), 1);
    // rust: pass.set_pipeline(scan);
    // rust: pass.dispatch_workgroups(self.pass_pages, 1, 1);
    // rust: pass.set_pipeline(scatter);
    // rust: pass.dispatch_workgroups(blocks.min(ROW), blocks.div_ceil(ROW), 1);
}

    // The kept sections' solid draws, a count draw per page, with the quad
    // indices bound. Leaves the origins at vertex slot 1. `group`: the page's group 1 for
    // pipelines that read the page themselves (`Flat::page_group`), else none.
    // `phase`: 0, or 1 after `compact` in a frame that occludes.
    // rust: pub fn draw<'a>(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: arena: &Arena,
    // rust: group: impl Fn(u32) -> Option<&'a wgpu::BindGroup>,
    // rust: phase: u64,
    // rust: ) {
    // rust: if self.pages.is_empty() {
    // rust: return;
}
    // rust: pass.set_vertex_buffer(1, self.origins.buffer.slice(..));
    // rust: for &(page, first, size) in &self.pages {
    // rust: pass.set_vertex_buffer(0, arena.buffer(page).slice(..));
    // rust: if let Some(group) = group(page) {
    // rust: pass.set_bind_group(1, group, &[]);
}
    // rust: pass.multi_draw_indexed_indirect_count(
    // rust: &self.draws.buffer,
    // rust: u64::from(first) * 20,
    // rust: &self.counts.buffer,
    // rust: (STATS + phase * u64::from(self.pass_pages) + u64::from(page)) * 4,
    // rust: size,
    // rust: );
}
}

    // Draw calls `draw` makes.
draw_calls :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.pages.len()
}

    // Whether the frame occludes (`prepare`): phase 1's `draw`, then `test` in
    // its pass, `compact` after it, and phase 2's `draw` in the next pass.
occluding :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.occluding
}

    // The boxes the newest test read back did not see and those it tested,
    // and the share of quads it hid (cull.rs `Cull::hidden`).
hidden :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.hidden.map(|h| (h, self.share.1))
}

    // In the world pass after phase 1's draws: the listed boxes against its
    // depth. Leaves the pass's pipeline and group 0 changed.
test :: proc(self: ^Self, pass: ^wgpu::RenderPass<'_>) {
}
    // rust: if let Some(BoxTest {
    // rust: pipeline,
    // rust: group: Some(group),
    // rust: ..
    // rust: }) = &self.test
    // rust: && self.occluding
    // rust: {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.draw_indirect(&self.counts.buffer, BOX * 4);
}
}

    // Between the world passes: phase 2's draws, of the sections the test saw,
    // into the regions phase 1 drew from.
compact :: proc(self: ^Self, encoder: ^wgpu::CommandEncoder, timing: Maybe(^PassTiming)) {
}
    // rust: let (Some(test), Some(group)) = (&self.test, &self.group) else {
    // rust: return;
}
    // rust: if !self.occluding {
    // rust: return;
}
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("GPU culling phase 2"),
    // rust: timestamp_writes: timing.and_then(|t| t.compute_writes("GPU culling phase 2")),
    // rust: });
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: let [count2, scan2, scatter2] = &test.phase2;
    // rust: let blocks = self.ids.div_ceil(WORKGROUP);
    // rust: pass.set_pipeline(count2);
    // rust: pass.dispatch_workgroups(blocks.min(ROW), blocks.div_ceil(ROW), 1);
    // rust: pass.set_pipeline(scan2);
    // rust: pass.dispatch_workgroups(self.pass_pages, 1, 1);
    // rust: pass.set_pipeline(scatter2);
    // rust: pass.dispatch_workgroups(blocks.min(ROW), blocks.div_ceil(ROW), 1);
}

    // After the frame's world passes (phase 2's counts too), in the same
    // encoder: the pass's counts copied out with
    // the CPU's part of frame `frame` (`Readback::cpu`), into the next readback
    // if it is free. While three frames' are on their way, this one's
    // statistics are never shown.
copy_stats :: proc(self: ^Self, encoder: ^wgpu::CommandEncoder, frame: u64, cpu: [uint; 3]) {
}
    // rust: let r = &mut self.readbacks[self.next];
    // rust: if r.state.load(Ordering::Acquire) != FREE {
    // rust: return;
}
    // rust: encoder.copy_buffer_to_buffer(&self.counts.buffer, 0, &r.buffer, 0, STATS * 4);
    // rust: (r.frame, r.cpu, r.occluded) = (frame, cpu, self.occluding);
    // rust: self.current = Some(self.next);
}

    // The frame's statistics to read back, started by calling it right after
    // the frame's submission (gfx's after-submit hook, on the submit thread
    // when the frame goes there), as `cull::Cull::submitted`.
submitted :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let i = self.current.take()?;
    // rust: let r = &self.readbacks[i];
    // rust: let (buffer, state) = (r.buffer.clone(), r.state.clone());
    // rust: state.store(PENDING, Ordering::Release);
    // rust: self.next = (i + 1) % READBACKS;
    // rust: Some(move || {
    // rust: buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, move |result| {
    // rust: state.store(
    // rust: if result.is_ok() { MAPPED } else { FAILED },
    // rust: Ordering::Release,
    // rust: );
    // rust: });
    // rust: })
}

    // The statistics that came back, their readbacks freed: the newest
    // frame's, as (frame, [sections drawn, section draws, draw calls]), the
    // pass's counts added to the CPU's part. Called as a frame starts, so a
    // copy no submission took (a frame that failed on the way) is dropped.
collect :: proc(self: ^Self, device: ^wgpu::Device) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.current = None;
    // rust: if device.poll(wgpu::PollType::Poll).is_err() {
    // rust: return None;
}
    // rust: let mut newest: Option<(u64, [usize; 3])> = None;
    // rust: for r in &self.readbacks {
    // rust: if r.state.load(Ordering::Acquire) != MAPPED {
    // rust: continue;
}
    // rust: {
    // rust: let Ok(data) = r.buffer.slice(..).get_mapped_range() else {
                    // Device loss can destroy a buffer after its mapping
                    // succeeded; unmapping it would panic (`timing::GpuTimer`).
    // rust: r.state.store(FAILED, Ordering::Release);
    // rust: continue;
}
                // The mapping need not be 4-byte aligned: read the words unaligned.
    // rust: let words: [u32; STATS as usize] =
    // rust: bytemuck::pod_read_unaligned(&data[..STATS as usize * 4]);
    // rust: let [kept, draws] = [words[0], words[1]];
                // The newest test's share, for the gate (`prepare`).
    // rust: if r.occluded && r.frame > self.share.0 {
    // rust: let quads = words[QUADS].max(1);
    // rust: self.share = (r.frame, words[HIDDEN_QUADS] as f32 / quads as f32);
    // rust: self.hidden = Some([words[HIDDEN] as usize, words[BOX as usize + 1] as usize]);
}
    // rust: let [sections, cpu_draws, calls] = r.cpu;
    // rust: if newest.is_none_or(|(frame, _)| r.frame > frame) {
    // rust: newest = Some((
    // rust: r.frame,
    // rust: [sections + kept as usize, cpu_draws + draws as usize, calls],
    // rust: ));
}
}
    // rust: r.buffer.unmap();
    // rust: r.state.store(FREE, Ordering::Release);
}
    // rust: newest
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::streaming::in_view_distance;
//     use glam::{Mat4, Vec4};
//     use std::collections::BTreeMap;

    // xorshift64*.
Rng :: struct {
    // rust: impl Rng {
bits :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0 ^= self.0 >> 12;
    // rust: self.0 ^= self.0 << 25;
    // rust: self.0 ^= self.0 >> 27;
    // rust: self.0.wrapping_mul(0x2545_F491_4F6C_DD1D)
}
below :: proc(self: ^Self, n: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (self.bits() >> 33) as u32 % n
}
range :: proc(self: ^Self, low: i32, high: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: low + self.below((high - low + 1) as u32) as i32
}
unit :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (self.bits() >> 40) as f32 / (1u64 << 24) as f32
}
}

    // Where a section's solid quads are: key, arena page, first vertex, quads,
    // its box, and whether it fades (`FADING`).
    // rust: type Placed = (SectionKey, u32, u64, u32, u32, bool);

    // `gpu_culling.wgsl`'s `near`, on the CPU.
near :: proc(params: ^Params, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let r = params.near;
    // rust: let gap = |d: i32| d.wrapping_abs().wrapping_sub(1).max(0);
    // rust: let gx = gap(x.wrapping_sub(params.cam_x));
    // rust: let gz = gap(z.wrapping_sub(params.cam_z));
    // rust: if gx >= r || gz >= r {
    // rust: return false;
}
    // rust: gx.wrapping_mul(gx).wrapping_add(gz.wrapping_mul(gz)) < r.wrapping_mul(r)
}

    // `gpu_culling.wgsl`'s `in_frustum`, on the CPU and in its order: the box
    // `b` of the section in cell `c` of the tables.
in_frustum :: proc(params: ^Params, words: ^[u32], c: [u32; 3], b: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if (b & UNBOUNDED) != 0 {
    // rust: return true;
}
    // rust: let [nx, ny, nz, _] = params.cells;
    // rust: let n = nx + ny + nz;
    // rust: let term = |at: u32| words[at as usize] as i32;
    // rust: (0..6u32).all(|j| {
    // rust: let s = params.signs >> (3 * j);
            // The box's code at the corner the plane looks at, along `axis`.
    // rust: let code = |axis: u32| {
    // rust: let high = ((s >> axis) & 1) != 0;
    // rust: (b >> (5 * axis + if high { 15 } else { 0 })) & 31
}
    // rust: let w = params.w[j as usize / 4][j as usize % 4];
    // rust: let (origin_terms, code_terms) = (n + j * n, 7 * n + 96 * j);
    // rust: let sum = w
    // rust: .wrapping_add(term(origin_terms + c[0]))
    // rust: .wrapping_add(term(origin_terms + nx + c[1]))
    // rust: .wrapping_add(term(origin_terms + nx + ny + c[2]))
    // rust: .wrapping_add(term(code_terms + code(0)))
    // rust: .wrapping_add(term(code_terms + 32 + code(1)))
    // rust: .wrapping_add(term(code_terms + 64 + code(2)));
    // rust: sum >= 0
    // rust: })
}

    // `gpu_culling.wgsl`'s `cull` on the CPU, the reference the pass is held
    // to, but for cave culling's graph (its `reached` is `Reach::contains`):
    // whether it draws `record` with the parameters and tables `tables` makes
    // (and the pages `prepare` gives them).
keeps :: proc(params: ^Params, words: ^[u32], record: ^Record) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (key, a) = (record.key, record.a);
    // rust: if key[3] < 0 || a[1] == 0 || (a[3] & FADING) != 0 || !near(params, key[0], key[2]) {
    // rust: return false;
}
    // rust: let c: [u32; 3] = std::array::from_fn(|i| key[i].wrapping_sub(params.first[i]) as u32);
    // rust: (key[3] as u32) < params.pages
    // rust: && (0..3).all(|i| c[i] < params.cells[i])
    // rust: && in_frustum(params, words, c, a[2])
}

    // A frame of the overworld's 24 sections, cave culling off, every solid
    // quad drawn.
inputs :: proc(camera: DVec3, radius: i32, frustum: ^Frustum) -> F {
    // Ported from Horizon
    return {}
}
    // rust: FrameInputs {
    // rust: camera,
    // rust: min_y: crate::chunk::MIN_Y,
    // rust: sections: 24,
    // rust: radius,
    // rust: frustum,
    // rust: reach: None,
    // rust: eye: None,
    // rust: view_proj: Mat4::IDENTITY,
    // rust: occlude: false,
}
}

    // The frustum `draw_frame` culls with for the view and projection `m`, and
    // the eye it leaves out the faces turned away from (`projection_center`).
through :: proc(m: Mat4) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let eye = super::super::projection_center(m).expect("a perspective");
    // rust: let planes = super::super::frustum(m);
    // rust: (Frustum { planes }, eye)
}

    // A view as `draw_frame` builds one, looking `yaw` and `pitch` out to
    // `far`: a field of view and aspect at random, and a little view bobbing,
    // which moves the eye off the camera.
looking :: proc(rng: ^Rng, yaw: f32, pitch: f32, far: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let fov = 30.0 + rng.unit() * 80.0;
    // rust: let aspect = 1.0 + rng.unit() * 1.4;
    // rust: let bob = Vec3::new(rng.unit() - 0.5, rng.unit() - 0.5, 0.0) * 0.2;
    // rust: let lens = super::super::world_projection(fov, aspect, far) * Mat4::from_translation(bob);
    // rust: through(lens * crate::camera::view_matrix(yaw, pitch))
}

    // `looking` anywhere, straight up and down among them, out to 64 to 8,192.
view :: proc(rng: ^Rng) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let yaw = rng.unit() * 360.0;
    // rust: let pitch = match rng.below(8) {
    // rust: 0 => 90.0,
    // rust: 1 => -90.0,
    // rust: _ => rng.unit() * 180.0 - 90.0,
}
    // rust: let far = 64.0 + rng.unit() * 8128.0;
    // rust: looking(rng, yaw, pitch, far)
}

    // Bounds as `SectionMesh::compute_bounds` makes them, the quads' corners
    // padded by `BOUNDS_PAD`, of every kind along each axis: inside the cell,
    // overhanging it, a rotated model's reach, wholly outside it, flat; none
    // (the cell); and now and then past what a box holds.
bounds :: proc(rng: ^Rng) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if rng.below(10) == 0 {
    // rust: return None;
}
    // rust: let pad = crate::mesher::SectionMesh::BOUNDS_PAD;
    // rust: let sixteenths = |rng: &mut Rng| rng.below(257) as f32 / 16.0;
    // rust: let (mut min, mut max) = (Vec3::ZERO, Vec3::ZERO);
    // rust: for axis in 0..3 {
    // rust: let (low, high) = match rng.below(12) {
    // rust: 0 => (-1.0, 17.0),
    // rust: 1 => (-5.5, 21.5),
    // rust: 2 => (18.5, 19.5),
    // rust: 3 => (-4.5, -3.5),
    // rust: 4 => (0.0, 0.0),
    // rust: 5 if rng.below(4) == 0 => (-9.0, 4.0),
    // rust: _ => {
    // rust: let (a, b) = (sixteenths(rng), sixteenths(rng));
    // rust: (a.min(b), a.max(b))
}
}
    // rust: (min[axis], max[axis]) = (low - pad, high + pad);
}
    // rust: Some([min, max])
}

    // Where each part of a mesh sorted for one pass ends, `quads` in all: at
    // random places, about a third of the parts empty.
part_ends :: proc(rng: ^Rng, quads: u32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut cuts: Vec<u32> = (0..13).map(|_| rng.below(quads + 1)).collect();
    // rust: cuts.sort_unstable();
    // rust: let (mut ends, mut end) = ([quads; 14], 0);
    // rust: for (part, cut) in ends.iter_mut().zip(cuts) {
    // rust: if rng.below(3) > 0 {
    // rust: end = cut;
}
    // rust: *part = end;
}
    // rust: ends
}

    // A mesh sorted for one pass with `quads` solid quads (`part_ends`), each
    // bucket's plane on the 1/16 grid, in its section or up to a block out.
sides_of :: proc(rng: ^Rng, quads: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let ends = part_ends(rng, quads);
    // rust: let planes = std::array::from_fn(|_| rng.range(-16, 272) as f32 / 16.0);
    // rust: Sides::from_parts(ends, false, rng.below(4) > 0, planes)
}

    // A section's solid quads sorted by side as the meshing workers sort them
    // (`SectionMesh::sort_solid`): faces on random planes of the 1/16 grid
    // facing either way, opaque or cutout, now and then sloped or a bowtie (the
    // other bucket); sometimes none.
sorted_sides :: proc(rng: ^Rng) -> S {
    // Ported from Horizon
    return {}
}
//         use crate::mesher::{OPAQUE_LAYER, SectionMesh, TerrainVertex};
    // rust: let mut mesh = SectionMesh::default();
    // rust: for _ in 0..rng.below(24) {
    // rust: let axis = rng.below(3) as usize;
    // rust: let (u, w) = ((axis + 1) % 3, (axis + 2) % 3);
    // rust: let plane = rng.below(257) as f32 / 16.0;
    // rust: let (a, b) = (rng.below(16) as f32, rng.below(16) as f32);
    // rust: let mut corners = [(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)].map(|(du, dw)| {
    // rust: let mut corner = [plane; 3];
    // rust: (corner[u], corner[w]) = (a + du, b + dw);
    // rust: corner
    // rust: });
    // rust: match rng.below(8) {
    // rust: 0 => corners[2][axis] += 0.5,
                // Its two triangles wind opposite ways.
    // rust: 1 => corners.swap(1, 2),
    // rust: _ => {}
}
    // rust: if rng.below(2) == 0 {
    // rust: corners.reverse();
}
    // rust: let layer = if rng.below(2) == 0 { OPAQUE_LAYER } else { 0 };
    // rust: let vertices = corners.map(|pos| TerrainVertex::new(pos, [0.0; 2], layer, 0, 0));
    // rust: mesh.solid.extend(vertices);
}
    // rust: mesh.sort_solid();
    // rust: mesh.sides
}

    // `gpu_culling.wgsl`'s run loop in `cull`, on the CPU and in its order: the
    // runs (first quad, quads) of `record`'s solid quads that can face an eye
    // whose keys less its origin are `eye`; without an eye, all of them.
shader_runs :: proc(record: ^Record, eye: Maybe([u32; 3])) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(eye) = eye else {
    // rust: return vec![(0, record.a[1])];
}
    // rust: let seen = |b: usize| {
    // rust: if b == 2 {
    // rust: return true;
}
    // rust: let t = record.keys[b - usize::from(b > 2)];
    // rust: match b {
    // rust: 0 => eye[0] > t,
    // rust: 1 => eye[2] > t,
    // rust: 3 => eye[1] > t,
    // rust: 4 => eye[2] < t,
    // rust: 5 => eye[0] < t,
    // rust: _ => eye[1] < t,
}
}
    // rust: let (mut runs, mut start, mut first, mut open) = (Vec::new(), 0, 0, false);
    // rust: for b in 0..7 {
    // rust: let end = if b == 6 { record.a[1] } else { record.ends[b] };
    // rust: if end == start {
    // rust: continue;
}
    // rust: let shown = seen(b);
    // rust: if shown && !open {
    // rust: (open, first) = (true, start);
    // rust: } else if !shown && open {
    // rust: runs.push((first, start - first));
    // rust: open = false;
}
    // rust: start = end;
}
    // rust: if open {
    // rust: runs.push((first, start - first));
}
    // rust: runs
}

    // The pass's module validates without the early depth test, and the
    // occlusion test's (the pass's with `gpu_occlusion.wgsl`) with it.
the_shaders_validate :: proc() {
}
//         use naga::valid::Capabilities as C;
    // rust: let pass = include_str!("gpu_culling.wgsl");
    // rust: let test = [pass, include_str!("gpu_occlusion.wgsl")].concat();
    // rust: for (source, capabilities) in [(pass, C::all() - C::EARLY_DEPTH_TEST), (&test, C::all())] {
    // rust: let module = naga::front::wgsl::parse_str(source).unwrap();
    // rust: naga::valid::Validator::new(naga::valid::ValidationFlags::all(), capabilities)
    // rust: .validate(&module)
    // rust: .unwrap();
}
}

    // Ids, page counts, flags and changes against a plain list of what each id
    // holds: the lowest free id comes back, flagged only if inserted so, free
    // ids at the end leave, counts follow moves (to pages past the last too), a
    // move keeps the box and the flag, a free is a change, a flag set changes
    // its record only when it differs, the flagged ones are counted through
    // inserts, flags, removals and clears, and more changes than updates take
    // mark the whole table.
records_keep_ids_page_counts_and_moves :: proc() {
}
    // rust: let mut records = Records::default();
    // rust: let a = records.insert(Record::new((0, 0, 0), 0, 0, 1, 7));
    // rust: let b = records.insert(Record::new((1, 0, 0), 0, 256, 2, 9));
    // rust: records.relocate(b, 5, 512);
    // rust: assert_eq!(records.page_sections(), [1, 0, 0, 0, 0, 1]);
    // rust: assert_eq!(records.at(b), Some(&Record::new((1, 0, 0), 5, 512, 2, 9)));
    // rust: records.remove(a);
    // rust: assert_eq!((records.ids(), records.live(), records.at(a)), (2, 1, None));
    // rust: assert_eq!(records.insert(Record::new((2, 0, 0), 1, 0, 3, 11)), a);
    // rust: records.remove(b);
    // rust: assert_eq!(
    // rust: (records.ids(), records.page_sections()),
    // rust: (1, &[0, 1, 0, 0, 0, 0][..])
    // rust: );

        // The free ids by their bits, which must be exactly the free records below the
        // table's end, none of them below `first_free`.
    // rust: let free_ids = |r: &Records| -> Vec<usize> {
    // rust: let set = |id: usize| {
    // rust: r.free
    // rust: .get(id / 64)
    // rust: .is_some_and(|&w| (w >> (id % 64)) & 1 == 1)
}
    // rust: let span = r.records.len().max(r.free.len() * 64);
    // rust: let free = |id: usize| r.records.get(id).is_some_and(|x| x.page().is_none());
    // rust: assert!((0..span).all(|id| set(id) == free(id)), "free bits");
    // rust: assert!(
    // rust: r.free[..r.first_free.min(r.free.len())]
    // rust: .iter()
    // rust: .all(|&w| w == 0)
    // rust: );
    // rust: (0..span).filter(|&id| set(id)).collect()
}
    // rust: let mut rng = Rng(0x9E37_79B9_7F4A_7C15);
        // What each id holds; `None`: a free id.
    // rust: let mut model: Vec<Option<Placed>> = vec![Some(((2, 0, 0), 1, 0, 3, 11, false))];
    // rust: for step in 0..4_000 {
    // rust: let live: Vec<u32> = (0..model.len() as u32)
    // rust: .filter(|&id| model[id as usize].is_some())
    // rust: .collect();
    // rust: let (page, start) = (
    // rust: rng.below(4 + step / 500),
    // rust: u64::from(rng.below(1 << 20)) * 256,
    // rust: );
    // rust: let dirty = records.dirty.len();
    // rust: match rng.below(6) {
    // rust: op if op < 2 || live.is_empty() => {
    // rust: let key = (rng.range(-9, 9), rng.range(0, 23), rng.range(-9, 9));
    // rust: let (quads, boxed) = (1 + rng.below(500), rng.below(1 << 30));
    // rust: let fading = rng.below(4) == 0;
    // rust: let lowest = model
    // rust: .iter()
    // rust: .position(Option::is_none)
    // rust: .unwrap_or(model.len());
    // rust: let record = Record::new(key, page, start, quads, boxed).fading(fading);
    // rust: assert_eq!(records.insert(record) as usize, lowest);
    // rust: if lowest == model.len() {
    // rust: model.push(None);
}
    // rust: model[lowest] = Some((key, page, start, quads, boxed, fading));
}
    // rust: op => {
    // rust: let id = live[rng.below(live.len() as u32) as usize];
    // rust: let held = model[id as usize].as_mut().expect("a live id");
    // rust: if op < 4 {
    // rust: records.relocate(id, page, start);
    // rust: (held.1, held.2) = (page, start);
    // rust: } else if op == 4 {
    // rust: let on = rng.below(2) == 0;
    // rust: records.set_fading(id, on);
    // rust: let changed = usize::from(held.5 != on);
    // rust: assert_eq!(records.dirty.len(), dirty + changed, "step {step}");
    // rust: held.5 = on;
    // rust: } else {
    // rust: records.remove(id);
                        // Marked: the GPU must have it free before the pass culls.
    // rust: assert_eq!(records.dirty.last(), Some(&id), "step {step}");
    // rust: model[id as usize] = None;
    // rust: while model.last() == Some(&None) {
    // rust: model.pop();
}
}
}
}
    // rust: assert_eq!(records.ids() as usize, model.len(), "step {step}");
    // rust: assert_eq!(records.live(), model.iter().flatten().count());
    // rust: let flagged = model.iter().flatten().filter(|held| held.5).count();
    // rust: assert_eq!(records.fading() as usize, flagged, "step {step}");
    // rust: let mut pages = vec![0; records.page_sections().len()];
    // rust: for (id, held) in model.iter().enumerate() {
    // rust: let record = held.map(|(key, page, start, quads, boxed, fading)| {
    // rust: pages[page as usize] += 1;
    // rust: Record::new(key, page, start, quads, boxed).fading(fading)
    // rust: });
    // rust: assert_eq!(
    // rust: records.at(id as u32),
    // rust: record.as_ref(),
    // rust: "step {step}, id {id}"
    // rust: );
}
    // rust: assert_eq!(records.page_sections(), pages, "step {step}");
    // rust: free_ids(&records);
}

        // A few, then many at once, as a teleport drops them (onto free ids, past one
        // at the table's new end): the table removing each leaves.
    // rust: let (mut each, mut all) = (Records::default(), Records::default());
    // rust: for n in 0..1_000 {
    // rust: let (key, page, start) = ((n % 31, n % 24, n / 31), n as u32 % 3, n as u64 * 256);
    // rust: let record = Record::new(key, page, start, 1, 0).fading(n % 7 == 0);
    // rust: assert_eq!(each.insert(record), all.insert(record));
}
    // rust: let gone: Vec<u32> = (0..1_000).filter(|id| id % 3 != 1 || *id >= 900).collect();
    // rust: let counts = |r: &Records| (r.ids(), r.live(), r.fading());
    // rust: for ids in [&[1u32, 4, 898][..], &gone[..]] {
    // rust: for &id in ids {
    // rust: each.remove(id);
}
    // rust: all.remove_all(ids.iter().copied());
    // rust: assert_eq!(counts(&all), counts(&each));
    // rust: assert_eq!(all.page_sections(), each.page_sections());
    // rust: assert_eq!(free_ids(&all), free_ids(&each));
    // rust: assert_eq!(all.dirty, each.dirty);
    // rust: assert!((0..each.ids()).all(|id| all.at(id) == each.at(id)));
}
        // The lowest free id comes back first, then the next (0 left with `gone`, 1 before).
    // rust: assert_eq!((all.take_free(), all.take_free()), (Some(0), Some(1)));
    // rust: assert_eq!(all.ids(), 896);
        // All of them: an empty table.
    // rust: let live: Vec<u32> = (0..all.ids()).filter(|&id| all.at(id).is_some()).collect();
    // rust: all.remove_all(live);
    // rust: assert_eq!((all.ids(), all.live(), all.free.len()), (0, 0, 0));
    // rust: assert!(all.page_sections().iter().all(|&n| n == 0));

    // rust: assert!(records.fading() > 0);
    // rust: records.clear();
    // rust: assert_eq!((records.ids(), records.live(), records.fading()), (0, 0, 0));
    // rust: assert!(records.page_sections().is_empty() && records.dirty.is_empty());
    // rust: for x in 0..DIRTY_LIMIT as i32 {
    // rust: records.insert(Record::new((x, 0, 0), 0, 0, 1, 0));
}
    // rust: assert!(!records.all_dirty && records.dirty.len() == DIRTY_LIMIT);
    // rust: records.relocate(0, 1, 256);
    // rust: assert!(records.all_dirty && records.dirty.is_empty());
    // rust: records.clear();
    // rust: assert!(!records.all_dirty);
    // rust: assert_eq!(records.insert(Record::new((0, 0, 0), 0, 0, 1, 0)), 0);
}

    // A box holds the bounds it is made from, rounded out to whole blocks, and
    // reaches its cell along every axis; bounds past what it holds, or not
    // finite, are `UNBOUNDED`; no bounds are the cell.
boxes_round_outward_and_meet_their_cell :: proc() {
}
        // Each axis's low and high ends.
    // rust: let ends = |packed: u32| -> [[i32; 2]; 3] {
    // rust: std::array::from_fn(|axis| {
    // rust: let code = |shift: usize| ((packed >> (shift + 5 * axis)) & 31) as i32;
    // rust: [code(0) - CODE_OFFSET, code(15) - CODE_OFFSET]
    // rust: })
}
    // rust: assert_eq!(ends(rounded_box(None)), [[0, 16]; 3]);
    // rust: for (low, high, rounded) in [
    // rust: (-1.5, 17.5, Some([-2, 18])),
    // rust: (-6.0, 22.0, Some([-6, 22])),
    // rust: (18.0, 20.0, Some([16, 20])),
    // rust: (-5.0, -3.0, Some([-5, 0])),
    // rust: (-0.5, 0.5, Some([-1, 1])),
    // rust: (-8.0, 23.0, Some([-8, 23])),
    // rust: (-8.5, 4.0, None),
    // rust: (3.0, 23.25, None),
    // rust: (f32::NAN, 4.0, None),
    // rust: (0.0, f32::INFINITY, None),
    // rust: (f32::NEG_INFINITY, 0.0, None),
    // rust: ] {
    // rust: for axis in 0..3 {
    // rust: let mut bounds = [Vec3::new(1.0, 2.0, 3.0), Vec3::new(14.0, 15.0, 16.0)];
    // rust: (bounds[0][axis], bounds[1][axis]) = (low, high);
    // rust: let packed = rounded_box(Some(bounds));
    // rust: match rounded {
    // rust: Some(rounded) => assert_eq!(ends(packed)[axis], rounded, "{low}..{high}"),
    // rust: None => assert_eq!(packed, UNBOUNDED, "{low}..{high}"),
}
}
}
}

    // `Params`, `Section` and `Update` as the shader lays them out, and the
    // constants both sides use.
params_and_records_match_the_shader :: proc() {
}
    // rust: let module = naga::front::wgsl::parse_str(include_str!("gpu_culling.wgsl")).unwrap();
    // rust: let mut layouter = naga::proc::Layouter::default();
    // rust: layouter.update(module.to_ctx()).unwrap();
        // A struct's size and its members' offsets.
    // rust: let layout = |name: &str| {
    // rust: let (handle, ty) = module
    // rust: .types
    // rust: .iter()
    // rust: .find(|(_, t)| t.name.as_deref() == Some(name))
    // rust: .unwrap_or_else(|| panic!("{name}"));
    // rust: let naga::TypeInner::Struct { members, .. } = &ty.inner else {
    // rust: panic!("{name} is a struct");
}
    // rust: let members = members
    // rust: .iter()
    // rust: .map(|m| (m.name.clone().unwrap(), m.offset as usize));
    // rust: (layouter[handle].size as usize, members.collect::<Vec<_>>())
}
//         use std::mem::{offset_of, size_of};
    // rust: let (size, members) = layout("Params");
    // rust: assert_eq!(size, size_of::<Params>());
    // rust: for (name, offset) in [
    // rust: ("ids", offset_of!(Params, ids)),
    // rust: ("updates", offset_of!(Params, updates)),
    // rust: ("pages", offset_of!(Params, pages)),
    // rust: ("regions", offset_of!(Params, regions)),
    // rust: ("signs", offset_of!(Params, signs)),
    // rust: ("near", offset_of!(Params, near)),
    // rust: ("cam_x", offset_of!(Params, cam_x)),
    // rust: ("cam_z", offset_of!(Params, cam_z)),
    // rust: ("first", offset_of!(Params, first)),
    // rust: ("cells", offset_of!(Params, cells)),
    // rust: ("w", offset_of!(Params, w)),
    // rust: ("reach", offset_of!(Params, reach)),
    // rust: ("reach_height", offset_of!(Params, reach_height)),
    // rust: ("reach_sections", offset_of!(Params, reach_sections)),
    // rust: ("flags", offset_of!(Params, flags)),
    // rust: ("eyes", offset_of!(Params, eyes)),
    // rust: ("occl", offset_of!(Params, occl)),
    // rust: ("view_proj", offset_of!(Params, view_proj)),
    // rust: ] {
    // rust: assert!(members.contains(&(name.into(), offset)), "Params.{name}");
}
    // rust: let named = |pairs: &[(&str, usize)]| {
    // rust: let pairs = pairs.iter().map(|&(n, o)| (n.to_owned(), o));
    // rust: pairs.collect::<Vec<_>>()
}
    // rust: let key = [
    // rust: ("key", offset_of!(Record, key)),
    // rust: ("a", offset_of!(Record, a)),
    // rust: ("ends", offset_of!(Record, ends)),
    // rust: ("keys", offset_of!(Record, keys)),
    // rust: ];
    // rust: assert_eq!(layout("Section"), (size_of::<Record>(), named(&key)));
    // rust: let id = [
    // rust: ("id", offset_of!(Update, id)),
    // rust: ("section", offset_of!(Update, record)),
    // rust: ];
    // rust: assert_eq!(layout("Update"), (size_of::<Update>(), named(&id)));
    // rust: assert_eq!((size_of::<Record>(), size_of::<Update>()), (80, 96));
    // rust: assert_eq!(size_of::<Params>(), 208);
    // rust: let constant = |name: &str| {
    // rust: let (_, c) = module
    // rust: .constants
    // rust: .iter()
    // rust: .find(|(_, c)| c.name.as_deref() == Some(name))
    // rust: .unwrap_or_else(|| panic!("{name}"));
    // rust: match module.global_expressions[c.init] {
    // rust: naga::Expression::Literal(naga::Literal::U32(value)) => u64::from(value),
    // rust: ref e => panic!("{name}: {e:?}"),
}
}
        // A whole section's instance w: `section_instance`'s bare UV step.
    // rust: let step = super::super::section_instance([0.0; 3], 0, 1.0)[3];
    // rust: assert_eq!(step, 1.0 / crate::mesher::UV_STEPS);
    // rust: for (name, value) in [
    // rust: ("STEP_BITS", u64::from(step.to_bits())),
    // rust: ("ROW", u64::from(ROW)),
    // rust: ("BLOCK", u64::from(WORKGROUP)),
    // rust: ("STATS", STATS),
    // rust: ("UNBOUNDED", u64::from(UNBOUNDED)),
    // rust: ("REACH", u64::from(REACH)),
    // rust: ("SKY", u64::from(SKY)),
    // rust: ("FADING", u64::from(FADING)),
    // rust: ("EYE", u64::from(EYE)),
    // rust: ("RUN_WORDS", RUN_WORDS),
    // rust: ] {
    // rust: assert_eq!(constant(name), value, "{name}");
}
        // A section's draws fit below its page in its first `runs` word.
    // rust: assert!(u64::from(RUNS) < 1 << constant("PAGE_SHIFT"));
}

    // The shader's `near` is `in_view_distance`, on every column out to 140
    // from the camera's at every render distance to 130.
the_shaders_near_is_in_view_distance :: proc() {
}
    // rust: let (cam_x, cam_z) = (-37, 1_234_567);
    // rust: for r in 0..=130 {
    // rust: let params = Params {
    // rust: near: r,
    // rust: cam_x,
    // rust: cam_z,
    // rust: ..Default::default()
}
    // rust: for dx in -140..=140 {
    // rust: for dz in -140..=140 {
    // rust: let (x, z) = (cam_x + dx, cam_z + dz);
    // rust: assert_eq!(
    // rust: near(&params, x, z),
    // rust: in_view_distance((cam_x, cam_z), r, x, z),
    // rust: "distance {r}, ({dx}, {dz})"
    // rust: );
}
}
}
}

    // Keys order as their floats do, -0 as 0: both zeros, the smallest and
    // largest subnormals, the smallest normal, a sixteenth, a section, millions,
    // the largest float and the infinities, of either sign, and 100,000 random
    // floats, sorted, each against the next, which covers every pair. No
    // float's key passes a NaN threshold's, either way.
order_keys_compare_as_their_floats :: proc() {
}
    // rust: let mut floats = Vec::new();
    // rust: for x in [
    // rust: 0.0,
    // rust: f32::from_bits(1),
    // rust: f32::from_bits(0x007F_FFFF),
    // rust: f32::MIN_POSITIVE,
    // rust: 1.0 / 16.0,
    // rust: 16.0,
    // rust: 3.0e7,
    // rust: f32::MAX,
    // rust: f32::INFINITY,
    // rust: ] {
    // rust: floats.extend([x, -x]);
}
    // rust: let special = floats.len();
    // rust: let mut rng = Rng(0x6A09_E667_F3BC_C908);
    // rust: while floats.len() < special + 100_000 {
    // rust: let x = f32::from_bits(rng.bits() as u32);
    // rust: if !x.is_nan() {
    // rust: floats.push(x);
}
}
    // rust: floats.sort_by(f32::total_cmp);
    // rust: for pair in floats.windows(2) {
    // rust: let (a, b) = (pair[0], pair[1]);
    // rust: let keys = order_key(a).cmp(&order_key(b));
    // rust: assert_eq!(Some(keys), a.partial_cmp(&b), "{a:e}, {b:e}");
}
    // rust: for &x in &floats {
    // rust: assert!(order_key(x) < threshold_key(f32::NAN, true), "{x:e}");
    // rust: assert!(order_key(x) > threshold_key(f32::NAN, false), "{x:e}");
}
}

    // The shader's runs for a record (`shader_runs`, from `Record::facing` and
    // the eye's keys) are the CPU frame's (`facing_runs`, every part): for
    // meshes as the workers sort them, for parts of every size with planes
    // around the section, with planes the sort never makes (±∞, NaN) and
    // sixteenths whose threshold is 0, and for one not sorted; from eyes in and
    // around the section, some millions of blocks away, and on each threshold,
    // a float either side of it, both zeros and the smallest subnormals. They
    // number at most `RUNS`, in order and apart. A mesh sorted for two passes,
    // which GPU culling never meets, is drawn whole.
the_shaders_runs_are_facing_runs :: proc() {
}
    // rust: let mut rng = Rng(0xBB67_AE85_84CA_A73B);
    // rust: let mut meshes: Vec<Sides> = (0..2_000).map(|_| sorted_sides(&mut rng)).collect();
    // rust: let special = [
    // rust: f32::INFINITY,
    // rust: f32::NEG_INFINITY,
    // rust: 1.0 / 16.0,
    // rust: -1.0 / 16.0,
    // rust: 0.0,
    // rust: f32::NAN,
    // rust: ];
    // rust: for n in 0..1_500 {
    // rust: let quads = 1 + rng.below(40);
    // rust: meshes.push(if n < 1_000 {
    // rust: sides_of(&mut rng, quads)
    // rust: } else {
    // rust: let ends = part_ends(&mut rng, quads);
    // rust: let planes = std::array::from_fn(|_| special[rng.below(6) as usize]);
    // rust: Sides::from_parts(ends, false, true, planes)
    // rust: });
}
    // rust: meshes.push(Sides::unsorted(9));
    // rust: let ends = part_ends(&mut rng, 30);
    // rust: meshes.push(Sides::from_parts(ends, true, true, [8.0; 7]));
        // The axis each bucket faces along (`BUCKETS`; the other bucket's unused).
    // rust: let axes = [0, 2, 0, 1, 2, 0, 1];
    // rust: let tiny = f32::from_bits(1);
    // rust: let (mut compared, mut several) = (0, 0);
    // rust: for sides in &meshes {
    // rust: let quads = sides.quads();
    // rust: if quads == 0 {
                // No record (`SectionGpu::gpu_recorded`).
    // rust: continue;
}
    // rust: let record = Record::new((0, 0, 0), 0, 0, quads, 0).facing(sides);
    // rust: let Some((_, t)) = sides.thresholds() else {
    // rust: let eye = [order_key(0.0); 3];
    // rust: assert_eq!(shader_runs(&record, Some(eye)), [(0, quads)], "{sides:?}");
    // rust: continue;
}
    // rust: let around = |rng: &mut Rng| [0, 1, 2].map(|_| rng.range(-4, 19) as f32 + rng.unit());
    // rust: let mut eyes = Vec::new();
    // rust: for b in [0, 1, 3, 4, 5, 6] {
    // rust: for x in [
    // rust: t[b],
    // rust: t[b].next_up(),
    // rust: t[b].next_down(),
    // rust: 0.0,
    // rust: -0.0,
    // rust: tiny,
    // rust: -tiny,
    // rust: ] {
    // rust: if !x.is_nan() {
    // rust: let mut eye = around(&mut rng);
    // rust: eye[axes[b]] = x;
    // rust: eyes.push((eye, [0.0; 3]));
}
}
}
    // rust: for _ in 0..12 {
    // rust: let far = |rng: &mut Rng| match rng.below(8) {
    // rust: 0 => rng.range(-30_000_000, 30_000_000) as f32,
    // rust: _ => rng.range(-3, 2) as f32 * 16.0,
}
    // rust: let origin = [0, 1, 2].map(|_| far(&mut rng));
    // rust: let eye = [0, 1, 2].map(|_| rng.range(-40, 39) as f32 + rng.unit());
    // rust: eyes.push((eye, origin));
}
    // rust: for (eye, origin) in eyes {
    // rust: let keys = [0, 1, 2].map(|a| order_key(eye[a] - origin[a]));
    // rust: let gpu = shader_runs(&record, Some(keys));
    // rust: let mut cpu = Vec::new();
    // rust: let eye = Some(Vec3::from(eye));
    // rust: super::super::facing_runs(sides, eye, origin, |first, count| {
    // rust: cpu.push((first, count));
    // rust: });
    // rust: assert_eq!(gpu, cpu, "{sides:?} from {eye:?} at {origin:?}");
    // rust: assert!(gpu.len() <= RUNS as usize, "{gpu:?}");
    // rust: assert!(gpu.windows(2).all(|w| w[0].0 + w[0].1 < w[1].0), "{gpu:?}");
    // rust: compared += 1;
    // rust: several += usize::from(gpu.len() >= 3);
}
    // rust: let mut every = Vec::new();
    // rust: super::super::facing_runs(sides, None, [0.0; 3], |first, count| {
    // rust: every.push((first, count));
    // rust: });
    // rust: assert_eq!(shader_runs(&record, None), every, "{sides:?}");
}
    // rust: assert!(
    // rust: several > 100,
    // rust: "{several} of {compared} in three runs or more"
    // rust: );
}

    // However its buckets hold quads and face the eye, a section has at most
    // `RUNS` runs, the draws `runs` and the regions have room for: two runs
    // are apart by a bucket left out. Some have that many, and the runs hold
    // exactly the quads of the buckets seen.
a_section_has_at_most_four_runs :: proc() {
}
    // rust: let eye = [order_key(0.0); 3];
    // rust: let mut most = 0;
        // Each bucket empty (0), seen (1) or left out (2); the other never left out.
    // rust: for pattern in 0..3u32.pow(7) {
    // rust: let state: [u32; 7] = std::array::from_fn(|b| pattern / 3u32.pow(b as u32) % 3);
    // rust: if state[2] == 2 {
    // rust: continue;
}
            // A quad in each bucket that holds any.
    // rust: let ends: [u32; 7] =
    // rust: std::array::from_fn(|b| state[..=b].iter().filter(|&&s| s != 0).count() as u32);
    // rust: let mut record = Record::new((0, 0, 0), 0, 0, ends[6], 0);
    // rust: record.ends = std::array::from_fn(|b| ends[b]);
            // Below the eye's keys or past them, as the bucket faces.
    // rust: let key = |b: usize| {
    // rust: if (state[b] == 1) == (b < 4) {
    // rust: 0
    // rust: } else {
    // rust: u32::MAX
}
}
    // rust: record.keys = [0, 1, 3, 4, 5, 6].map(key);
    // rust: let runs = shader_runs(&record, Some(eye));
    // rust: let seen = state.iter().filter(|&&s| s == 1).count() as u32;
    // rust: assert_eq!(runs.iter().map(|r| r.1).sum::<u32>(), seen, "{state:?}");
    // rust: assert!(runs.len() <= RUNS as usize, "{state:?}: {runs:?}");
    // rust: most = most.max(runs.len());
}
    // rust: assert_eq!(most, RUNS as usize);
}

    // A frame whose planes' sums could leave i32 is the CPU's (`tables` gives
    // `None`): the camera 20 million blocks above or below the level, in any
    // view, or not finite; so is one whose eye is NaN along an axis, which no
    // key orders. Three million blocks out, they fit, and so does an eye at
    // infinity.
planes_past_i32_take_the_cpu_path :: proc() {
}
    // rust: let mut rng = Rng(0x0F1E_2D3C_4B5A_6978);
    // rust: let mut words = Vec::new();
    // rust: for _ in 0..500 {
    // rust: let (frustum, _) = view(&mut rng);
    // rust: let x = f64::from(rng.range(-30_000_000, 30_000_000)) + f64::from(rng.unit());
    // rust: let z = f64::from(rng.range(-30_000_000, 30_000_000)) + f64::from(rng.unit());
    // rust: let radius = rng.range(2, 128);
    // rust: for (y, fits) in [
    // rust: (2.0e7, false),
    // rust: (-2.0e7, false),
    // rust: (3.0e6, true),
    // rust: (-3.0e6, true),
    // rust: (64.5, true),
    // rust: ] {
    // rust: let input = inputs(DVec3::new(x, y, z), radius, &frustum);
    // rust: assert_eq!(tables(&input, &mut words).is_some(), fits, "y {y}");
}
    // rust: for camera in [
    // rust: DVec3::new(f64::NAN, 64.0, z),
    // rust: DVec3::new(f64::INFINITY, 64.0, z),
    // rust: DVec3::new(x, f64::INFINITY, z),
    // rust: ] {
    // rust: let input = inputs(camera, radius, &frustum);
    // rust: assert!(tables(&input, &mut words).is_none(), "{camera}");
}
    // rust: for (eye, fits) in [
    // rust: (Vec3::new(0.5, f32::NAN, -0.25), false),
    // rust: (Vec3::NEG_INFINITY, true),
    // rust: ] {
    // rust: let input = FrameInputs {
    // rust: eye: Some(eye),
    // rust: ..inputs(DVec3::new(x, 64.5, z), radius, &frustum)
}
    // rust: assert_eq!(tables(&input, &mut words).is_some(), fits, "eye {eye}");
}
}
}

    // The integer test keeps every section the walk keeps (`Resident::visible`,
    // a GPU frame's camera alone), whatever its bounds: inside its cell,
    // overhanging it, a rotated model's reach, wholly outside it along an axis,
    // flat, none, or past what a box holds; in columns tested section by section
    // and in short columns entirely inside the frustum; around cameras out to 30
    // million blocks and 100,000 above and below the level, in views of every
    // shape, most of them toward the sections, one with a plane that is not
    // finite. It rejects a real share of the sections within the distance. Its
    // eye keys for a section the walk keeps are the view's eye less the walk's
    // origin, the difference facing compares.
the_integer_test_keeps_what_the_walk_keeps :: proc() {
}
    // rust: let mut rng = Rng(0x5DEE_CE66_D1CE_4E5B);
    // rust: let mut words = Vec::new();
    // rust: let (mut listed, mut near_sections, mut rejected, mut inside) = (0, 0, 0, 0);
    // rust: for case in 0..48 {
    // rust: let radius = 2 + case % 11;
            // Short columns of three sections, at the camera's height, in a view
            // along them: many lie entirely inside the frustum.
    // rust: let ahead = case % 4 == 3;
    // rust: let aimed = matches!(case % 8, 0 | 1 | 4 | 5);
    // rust: let wide = |rng: &mut Rng| {
    // rust: let blocks = if case % 3 == 0 { 30_000_000 } else { 2_000 };
    // rust: f64::from(rng.range(-blocks, blocks)) + f64::from(rng.unit())
}
    // rust: let height = match case % 8 {
    // rust: 0 => 1.0e5,
    // rust: 4 => -1.0e5,
    // rust: _ if ahead => 8.0,
    // rust: _ => f64::from(rng.range(-2_100, 2_100)),
}
    // rust: let camera = DVec3::new(
    // rust: wide(&mut rng),
    // rust: height + f64::from(rng.unit()),
    // rust: wide(&mut rng),
    // rust: );
    // rust: let (cx, cz) = resident::camera_column(camera);
    // rust: let (mut frustum, eye) = if ahead {
    // rust: let (yaw, pitch) = (rng.unit() * 360.0, rng.unit() * 10.0 - 5.0);
    // rust: let lens = super::super::world_projection(70.0, 16.0 / 9.0, 512.0);
    // rust: through(lens * crate::camera::view_matrix(yaw, pitch))
    // rust: } else if aimed {
                // Toward the sections, give or take 10 degrees, and out past them.
    // rust: let middle = DVec3::new(f64::from(cx * 16 + 8), 128.0, f64::from(cz * 16 + 8));
    // rust: let to = middle - camera;
    // rust: let yaw = (-to.x).atan2(to.z).to_degrees() as f32;
    // rust: let pitch = (-to.y / to.length()).asin().to_degrees() as f32;
    // rust: let turn = |rng: &mut Rng| (rng.unit() - 0.5) * 20.0;
    // rust: let yaw = yaw + turn(&mut rng);
    // rust: let pitch = (pitch + turn(&mut rng)).clamp(-90.0, 90.0);
    // rust: looking(&mut rng, yaw, pitch, to.length() as f32 + 400.0)
    // rust: } else {
    // rust: view(&mut rng)
}
    // rust: if case == 9 {
                // Not finite: it rejects nothing, as in `intersects`.
    // rust: frustum.planes[3] = Vec4::NAN;
}
    // rust: let rows = if ahead { 3..6 } else { 0..24 };
            // Each section's value is its record's box.
    // rust: let mut r = resident::Resident::default();
    // rust: let mut sections = Vec::new();
    // rust: for x in cx - radius - 2..=cx + radius + 2 {
    // rust: for z in cz - radius - 2..=cz + radius + 2 {
    // rust: let (mut low, mut high) = (i32::MAX, i32::MIN);
    // rust: for y in rows.clone() {
    // rust: if rng.below(4) == 0 {
    // rust: continue;
}
    // rust: let b = bounds(&mut rng);
    // rust: r.insert_with_bounds((x, y, z), rounded_box(b), b);
    // rust: sections.push((x, y, z));
    // rust: (low, high) = (low.min(y), high.max(y));
}
    // rust: if low > high || !in_view_distance((cx, cz), radius, x, z) {
    // rust: continue;
}
    // rust: let min_y = crate::chunk::MIN_Y;
    // rust: let min = resident::origin((x, low, z), min_y, camera).as_vec3();
    // rust: let top = resident::origin((x, high, z), min_y, camera).as_vec3();
    // rust: inside += usize::from(frustum.contains(min, top + Vec3::splat(16.0)));
}
}
    // rust: let input = FrameInputs {
    // rust: eye: Some(eye),
    // rust: ..inputs(camera, radius, &frustum)
}
    // rust: let mut params =
    // rust: tables(&input, &mut words).unwrap_or_else(|| panic!("case {case}: the planes fit"));
    // rust: params.pages = 1;
    // rust: assert_eq!(params.flags, EYE, "case {case}");
    // rust: let [nx, ny, nz, _] = params.cells.map(|n| n as usize);
            // Every term rounds up: at least the plane's component times its
            // origin or box end, which f64 holds exactly.
    // rust: let n = nx + ny + nz;
    // rust: let planes = frustum.planes.iter().enumerate();
    // rust: for (j, p) in planes.filter(|(_, p)| p.is_finite()) {
    // rust: for i in 0..n {
    // rust: let axis = usize::from(i >= nx) + usize::from(i >= nx + ny);
    // rust: let exact = SCALE * f64::from(p[axis]) * f64::from(f32::from_bits(words[i]));
    // rust: assert!(
    // rust: f64::from(words[n + j * n + i] as i32) >= exact,
    // rust: "case {case}, plane {j}"
    // rust: );
}
    // rust: for k in 0..96 {
    // rust: let exact =
    // rust: SCALE * f64::from(p[k / 32]) * f64::from(k as i32 % 32 - CODE_OFFSET);
    // rust: assert!(
    // rust: f64::from(words[7 * n + 96 * j + k] as i32) >= exact,
    // rust: "case {case}, plane {j}"
    // rust: );
}
}
    // rust: let mut out = Vec::new();
    // rust: r.visible(camera, radius, &frustum, |_| true, |_, _| false, &mut out);
    // rust: for v in &out {
    // rust: let record = Record::new(v.key, 0, 0, 1, *r.get(v.slot));
    // rust: assert!(
    // rust: keeps(&params, &words, &record),
    // rust: "case {case}: {:?} in view",
    // rust: v.key
    // rust: );
    // rust: let c = [
    // rust: v.key.0 - params.first[0],
    // rust: v.key.1,
    // rust: v.key.2 - params.first[2],
    // rust: ];
    // rust: let c = c.map(|c| c as usize);
    // rust: let e = params.eyes as usize;
    // rust: let keys = [
    // rust: words[e + c[0]],
    // rust: words[e + nx + c[1]],
    // rust: words[e + nx + ny + c[2]],
    // rust: ];
    // rust: let rel = [0, 1, 2].map(|a| order_key(eye[a] - v.origin[a]));
    // rust: assert_eq!(keys, rel, "case {case}: {:?}'s eye", v.key);
}
    // rust: listed += out.len();
    // rust: for &key in &sections {
    // rust: if in_view_distance((cx, cz), radius, key.0, key.2) {
    // rust: let record = Record::new(key, 0, 0, 1, *r.find(key).expect("resident"));
    // rust: near_sections += 1;
    // rust: rejected += usize::from(!keeps(&params, &words, &record));
}
}
}
    // rust: assert!(listed > 5_000, "{listed} in view");
    // rust: assert!(
    // rust: rejected * 10 > near_sections && rejected < near_sections,
    // rust: "{rejected} of {near_sections} within the distance left out"
    // rust: );
    // rust: assert!(inside > 20, "{inside} columns entirely inside");
}

    // Where the walk's f32 test stops keeping a section, the integer test still
    // keeps it. A plane through a box's corner, or a column box's, and the
    // camera moved along its normal until `Frustum::intersects` (or `contains`)
    // flips, by bisection: at the last camera it keeps, the integer test keeps
    // the section (every section of the column), and the plane's exact value
    // there is below 0 by no more than the margin covers. 100,000 blocks above
    // the level and more, it is below by more than a 256th of a block
    // somewhere: the margin is needed.
the_margin_covers_production_rounding :: proc() {
}
    // rust: let mut rng = Rng(0x1405_7B7E_F767_814F);
    // rust: let min_y = crate::chunk::MIN_Y;
    // rust: let mut words = Vec::new();
        // The largest shortfall found at each height.
    // rust: let mut worst = [0.0f64; 4];
    // rust: for (h, lift) in [64.0, 1.0e4, 1.0e5, 1.0e6].into_iter().enumerate() {
    // rust: for trial in 0..400 {
    // rust: let base = DVec3::new(
    // rust: f64::from(rng.range(-3_000, 3_000)) + f64::from(rng.unit()),
    // rust: lift + f64::from(rng.unit()),
    // rust: f64::from(rng.range(-3_000, 3_000)) + f64::from(rng.unit()),
    // rust: );
    // rust: let (cx, cz) = resident::camera_column(base);
    // rust: let (x, z) = (cx + rng.range(-1, 1), cz + rng.range(-1, 1));
                // Up to four sections of a column, each with whole-block bounds of
                // its own (`rounded_box` keeps them as they are).
    // rust: let low = rng.range(0, 20);
    // rust: let high = low + rng.range(0, 3);
    // rust: let mut rows: Vec<(i32, [Vec3; 2])> = (low..=high)
    // rust: .map(|y| {
    // rust: let [ex, ey, ez] = [0, 1, 2].map(|_| {
    // rust: let start = rng.range(-8, 16);
    // rust: [start, rng.range(start.max(0), 23)].map(|end| end as f32)
    // rust: });
    // rust: let min = Vec3::new(ex[0], ey[0], ez[0]);
    // rust: (y, [min, Vec3::new(ex[1], ey[1], ez[1])])
    // rust: })
    // rust: .collect();
                // A normal leaning along y, where the origins are largest.
    // rust: let normal = loop {
    // rust: let n = DVec3::new(
    // rust: f64::from(rng.unit()) - 0.5,
    // rust: f64::from(rng.unit()) - 0.5,
    // rust: f64::from(rng.unit()) - 0.5,
    // rust: );
    // rust: if n.length() > 0.1 && n.y.abs() > 0.3 * n.length() {
    // rust: break n.normalize();
}
}
    // rust: let column = trial % 2 == 1;
                // The box the plane runs through. In a column, the section at the
                // column box's corner gets that cell's lowest corner along the plane
                // as its box: `keeps` there has only the margin to spare.
    // rust: let at = usize::from(column && normal.y < 0.0) * (rows.len() - 1);
    // rust: if column {
    // rust: let c = Vec3::from_array(std::array::from_fn(|i| {
    // rust: if normal[i] >= 0.0 { 0.0 } else { 16.0 }
    // rust: }));
    // rust: rows[at].1 = [c, c];
}
    // rust: let origin = |camera: DVec3, y: i32| resident::origin((x, y, z), min_y, camera);
                // Along an axis the plane is at least 0 along, `intersects` looks at a
                // box's high end and `contains` at the column box's low end: on the
                // `[c, c]` box, the same corner.
    // rust: let (y, [min, max]) = rows[at];
    // rust: let o = origin(base, y);
    // rust: let corner = DVec3::from_array(std::array::from_fn(|i| {
    // rust: o[i] + f64::from(if normal[i] >= 0.0 { max[i] } else { min[i] })
    // rust: }));
    // rust: let plane = normal.extend(-normal.dot(corner)).as_vec4();
    // rust: let plane = plane / plane.truncate().length();
    // rust: let frustum = Frustum {
    // rust: planes: [plane, Vec4::W, Vec4::W, Vec4::W, Vec4::W, Vec4::W],
}
    // rust: let walk_keeps = |t: f64| {
    // rust: let camera = base + normal * t;
    // rust: let o = origin(camera, low).as_vec3();
    // rust: if column {
    // rust: let top = origin(camera, high).as_vec3() + Vec3::splat(16.0);
    // rust: frustum.contains(o, top)
    // rust: } else {
    // rust: let [min, max] = rows[0].1;
    // rust: frustum.intersects(o + min, o + max)
}
}
    // rust: let (mut kept, mut left) = (-4.0, 4.0);
    // rust: assert!(
    // rust: walk_keeps(kept) && !walk_keeps(left),
    // rust: "height {lift}, trial {trial}: the plane runs by"
    // rust: );
    // rust: for _ in 0..64 {
    // rust: let t = 0.5 * (kept + left);
    // rust: if walk_keeps(t) {
    // rust: kept = t;
    // rust: } else {
    // rust: left = t;
}
}
    // rust: let camera = base + normal * kept;
    // rust: let mut params = tables(&inputs(camera, 3, &frustum), &mut words)
    // rust: .unwrap_or_else(|| panic!("height {lift}, trial {trial}: the planes fit"));
    // rust: params.pages = 1;
    // rust: let tested = if column { &rows[..] } else { &rows[..1] };
    // rust: for &(y, b) in tested {
    // rust: let record = Record::new((x, y, z), 0, 0, 1, rounded_box(Some(b)));
    // rust: assert!(
    // rust: keeps(&params, &words, &record),
    // rust: "height {lift}, trial {trial}: ({x}, {y}, {z}) kept"
    // rust: );
}
                // The plane's lowest exact value, from the f32 origins, at the corner
                // the test looks at of each tested box (in a column the `[c, c]` box's,
                // its cells' lowest), and the margin's bound on what the walk rounds.
    // rust: let p = plane.as_dvec4();
    // rust: let (mut value, mut most) = (f64::INFINITY, 0.0f64);
    // rust: for &(y, [min, max]) in tested {
    // rust: let o = origin(camera, y).as_vec3();
    // rust: let end = |i: usize| f64::from(if p[i] >= 0.0 { max[i] } else { min[i] });
    // rust: let exact: f64 = (0..3).map(|i| p[i] * (f64::from(o[i]) + end(i))).sum();
    // rust: let corners: f64 = (0..3)
    // rust: .map(|i| p[i].abs() * (f64::from(o[i]).abs() + 24.0))
    // rust: .sum();
    // rust: value = value.min(exact + p.w);
    // rust: most = most.max(6.0 * UNIT * corners + 2.0 * UNIT * p.w.abs());
}
    // rust: let short = (-value).max(0.0);
    // rust: assert!(
    // rust: short <= most,
    // rust: "height {lift}, trial {trial}: {short} below 0, past {most}"
    // rust: );
    // rust: worst[h] = worst[h].max(short);
}
}
    // rust: assert!(worst[2].max(worst[3]) > 1.0 / SCALE, "{worst:?}");
}

    // A device of `backends` that draws counts with first instances, if this
    // machine has one; on DirectX 12, `compiler` compiles its shaders. Not
    // Intel's Gen11 and Gen12 Vulkan driver, which gets first instances wrong
    // and is never offered GPU culling (`supported`).
    // rust: fn device(
    // rust: backends: wgpu::Backends,
    // rust: compiler: wgpu::Dx12Compiler,
    // rust: name: &str,
    // rust: ) -> Option<(wgpu::Device, wgpu::Queue)> {
    // rust: let mut desc = wgpu::InstanceDescriptor::new_without_display_handle();
    // rust: desc.backends = backends;
    // rust: desc.backend_options.dx12.shader_compiler = compiler;
    // rust: let instance = wgpu::Instance::new(desc);
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: let needed =
    // rust: wgpu::Features::MULTI_DRAW_INDIRECT_COUNT | wgpu::Features::INDIRECT_FIRST_INSTANCE;
    // rust: if !adapter.features().contains(needed)
    // rust: || super::super::flat::is_broken_intel_vulkan(&adapter.get_info())
    // rust: {
    // rust: return None;
}
    // rust: eprintln!("GPU culling on {} ({name})", adapter.get_info().name);
    // rust: pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_features: needed,
    // rust: ..Default::default()
    // rust: }))
    // rust: .ok()
}

    // `test` on each device here that draws counts with first instances:
    // Vulkan, and DirectX 12 with each of its compilers. Players' DirectX 12
    // compiles with FXC, part of Windows: wgpu takes DXC only where
    // `dxcompiler.dll` loads, and the game ships none.
on_each_device :: proc(test: impl Fn(^wgpu::Device) {
}
    // rust: let mut tested = false;
    // rust: for (backends, compiler, name) in [
    // rust: (wgpu::Backends::VULKAN, Default::default(), "Vulkan"),
    // rust: (
    // rust: wgpu::Backends::DX12,
    // rust: wgpu::Dx12Compiler::Fxc,
    // rust: "DirectX 12, FXC",
    // rust: ),
    // rust: (
    // rust: wgpu::Backends::DX12,
    // rust: wgpu::Dx12Compiler::default_dynamic_dxc(),
    // rust: "DirectX 12, DXC",
    // rust: ),
    // rust: ] {
    // rust: if let Some((device, queue)) = device(backends, compiler, name) {
    // rust: test(&device, &Queue::new(queue, false));
    // rust: tested = true;
}
}
    // rust: if !tested {
    // rust: eprintln!("no GPU with indirect count draws: skipped");
}
}

    // rust: fn read(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: buffer: &wgpu::Buffer,
    // rust: bytes: u64,
    // rust: ) -> Vec<u32> {
    // rust: let (tx, rx) = std::sync::mpsc::channel();
    // rust: wgpu::util::DownloadBuffer::read_buffer(
    // rust: device,
    // rust: queue,
    // rust: &buffer.slice(..bytes),
    // rust: move |result| tx.send(result.unwrap().to_vec()).unwrap(),
    // rust: );
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: bytemuck::pod_collect_to_vec(&rx.recv().unwrap())
}

    // The pass draws exactly what its CPU reference (`keeps`, and cave
    // culling's `Reach::contains`) keeps: a draw of each run of its solid
    // quads that can face the eye, the runs a CPU frame draws
    // (`facing_runs`), or of all of them where a frame has no eye, from its
    // page and the run's first vertex, with the instance the CPU path gives a
    // whole section, every page's draws in id order and each section's in its
    // runs' order. Its buckets by facing side are drawn at random; one case
    // puts the camera on a section's corner, its eye a subnormal float past it
    // along x and on +0 and -0 along y and z, with a quad in each of its side
    // buckets and every threshold 0: a CPU frame draws the +X one alone, and
    // so must a GPU, including one that flushes subnormal floats or compares a
    // bucket's keys loosely. One table serves
    // every case, changed between them as sections come, go and move (ids
    // reused, records written as updates and whole), cleared once as for
    // another world, and kept through a frame the CPU draws; in frusta of every
    // shape, one with a plane that is not finite, with boxes of every kind,
    // and from cameras near the world's origin and 20 million blocks out. Most
    // cases have a cave-culling graph, its box as wide as the walk's,
    // narrower, or a column wider, full height or clamped, its sky band
    // reached or not: the pass reads the copy it holds when a frame brings the
    // same graph (once through a bind group made anew), sends a new one after
    // a frame the CPU draws, and makes its copy anew for one too large for its
    // room. A fifth of the sections fade, flagged anew before each case
    // (`FADING`, sent as updates or with the whole table): the pass leaves
    // them to the CPU.
the_gpu_draws_what_the_integer_test_keeps :: proc() {
}
    // rust: on_each_device(draws_match);
}

draws_match :: proc(device: ^wgpu::Device, queue: ^Queue) {
}
    // rust: let mut rng = Rng(0x2545_F491_4F6C_DD1D);
        // The flags have their own sequence: the cases are otherwise as before.
    // rust: let mut flags = Rng(0x9E37_79B9_7F4A_7C15);
        // So have the sections' buckets and whether a frame has an eye.
    // rust: let mut shapes = Rng(0x3C6E_F372_FE94_F82B);
    // rust: let (min_y, height) = (-64, 24);
    // rust: let mut gpu = GpuCulling::new(device, None).expect("the pass");
    // rust: let mut uploads = Uploads::new(device);
    // rust: let mut held: BTreeMap<u32, (Placed, Sides)> = BTreeMap::new();
        // Fading sections the frustum and the graph keep, left to the CPU.
    // rust: let (mut camera, mut compared, mut culled, mut faded) = (DVec3::ZERO, 0, 0, 0);
    // rust: let mut words = Vec::new();
        // Cave culling's graph while a case has one (its generation, from x and
        // z, radius, height and whether its search reached the sky) and its bits.
    // rust: let (mut graph, mut bits) = (None, Vec::new());
        // Sections the frustum keeps with a graph, those it leaves out, and
        // those above its box it leaves out and keeps.
    // rust: let (mut graphed, mut unreached, mut band) = (0, 0, [0; 2]);
        // Sections drawn from an eye, those with a bucket left out, those in
        // three runs or more; the record at the section's edge, and whether it
        // was drawn.
    // rust: let (mut eyed, mut hidden, mut several) = (0, 0, 0);
    // rust: let (mut edge, mut edge_drawn) = (None, false);
    // rust: for case in 0..25 {
    // rust: let radius = [2, 5, 9][case % 3];
    // rust: let at_edge = case == 24;
            // Case 4 looks from case 3's camera, 20 million blocks out, while
            // every section moves and none comes: the whole table is written
            // though it keeps its room. Cases 11 and 18 look from the camera of
            // the case before, whose graph they keep. Case 24's is on a
            // section's corner, its eye a subnormal float past it along x and
            // on it along y and z.
    // rust: if !matches!(case, 4 | 11 | 18) {
    // rust: let far = |axis| if case % 4 == axis { 10_000.0 } else { 1.0 };
    // rust: camera = DVec3::new(
    // rust: f64::from(rng.range(-2_000, 2_000)) * far(3) + f64::from(rng.unit()),
    // rust: f64::from(rng.range(-60, 300)) + f64::from(rng.unit()),
    // rust: f64::from(rng.range(-2_000, 2_000)) * far(1) + f64::from(rng.unit()),
    // rust: );
}
    // rust: if at_edge {
    // rust: camera.x = (camera.x / 16.0).floor() * 16.0;
    // rust: camera.y = f64::from(min_y + 16 * 3);
    // rust: camera.z = (camera.z / 16.0).floor() * 16.0;
}
    // rust: let (mut frustum, center) = view(&mut rng);
    // rust: if case == 9 {
    // rust: frustum.planes[rng.below(6) as usize] = Vec4::NAN;
}
            // The eye in two cases of three, the view's own (`projection_center`).
    // rust: let eye = if at_edge {
    // rust: Some(Vec3::new(f32::from_bits(1), 0.0, -0.0))
    // rust: } else {
    // rust: (shapes.below(3) > 0).then_some(center)
}
    // rust: let (cx, cz) = resident::camera_column(camera);
            // None in a quarter of the cases (cave culling off). Else around the
            // camera's column, as wide as the walk's search (the distance and 2)
            // or anything from 1 column to past the distance, full height or
            // clamped as over low ground, its sky band reached in half the cases,
            // three quarters of its cells reached. Cases 11 and 18 bring the
            // graph of the case before: the pass reads the copy it holds, 18
            // through a bind group made anew. Case 7's is new and comes first with
            // a frame the CPU draws; case 20's, 131 KB, is past the copy's room.
    // rust: if !matches!(case, 11 | 18) {
    // rust: let given = matches!(case, 4 | 7 | 10 | 17 | 20) || rng.below(4) != 0;
    // rust: graph = given.then(|| {
    // rust: let span = match case {
    // rust: 20 => 100,
    // rust: _ if rng.below(2) == 0 => radius + 2,
    // rust: _ => rng.range(1, radius + 3),
}
    // rust: let rows = if case % 4 < 2 && case != 20 {
    // rust: rng.range(3, 8)
    // rust: } else {
    // rust: height + 2
}
    // rust: let cells = ((2 * span + 1).pow(2) * rows) as usize;
    // rust: bits.clear();
    // rust: bits.extend(
    // rust: (0..cells.div_ceil(32)).map(|_| rng.bits() as u32 | rng.bits() as u32),
    // rust: );
    // rust: let from = (cx + rng.range(-1, 1), cz + rng.range(-1, 1));
    // rust: (rng.bits(), from, span, rows, case % 8 < 4)
    // rust: });
}
            // Cave culling off at the edge: its section is drawn whatever a graph says.
    // rust: let graph_given = graph.filter(|_| !at_edge);
    // rust: let reach = graph_given.map(|(generation, from, span, rows, sky_reached)| Reach {
    // rust: generation,
    // rust: from_x: from.0,
    // rust: from_z: from.1,
    // rust: radius: span,
    // rust: y0: -1,
    // rust: height: rows,
    // rust: sections: height,
    // rust: sky_reached,
    // rust: bits: &bits,
    // rust: });
    // rust: if case == 12 {
                // Another world.
    // rust: gpu.records.clear();
    // rust: held.clear();
}
            // A third of the sections go and a sixth move, some to pages
            // past the last.
    // rust: let mut ids: Vec<u32> = held.keys().copied().collect();
    // rust: for _ in 0..ids.len() / 3 {
    // rust: let id = ids.swap_remove(rng.below(ids.len() as u32) as usize);
    // rust: gpu.records.remove(id);
    // rust: held.remove(&id);
}
    // rust: let mut moves = ids.len() / 6;
    // rust: while !ids.is_empty() && (moves > 0 || (case == 4 && !gpu.records.all_dirty)) {
    // rust: moves = moves.saturating_sub(1);
    // rust: let id = ids[rng.below(ids.len() as u32) as usize];
    // rust: let (page, start) = (rng.below(6), u64::from(rng.below(40_000)) * 256);
    // rust: gpu.records.relocate(id, page, start);
    // rust: let (placed, _) = held.get_mut(&id).expect("a live id");
    // rust: (placed.1, placed.2) = (page, start);
}
            // New sections around the camera, within the distance and past it.
    // rust: let place = |gpu: &mut GpuCulling,
    // rust: held: &mut BTreeMap<u32, (Placed, Sides)>,
    // rust: rng: &mut Rng,
    // rust: shapes: &mut Rng| {
    // rust: let near = |rng: &mut Rng| rng.range(-radius - 3, radius + 3);
    // rust: let key = (cx + near(rng), rng.range(0, height - 1), cz + near(rng));
    // rust: let (page, start) = (rng.below(3), u64::from(rng.below(40_000)) * 256);
    // rust: let quads = 1 + rng.below(2_000);
    // rust: let boxed = rounded_box(bounds(rng));
    // rust: let sides = sides_of(shapes, quads);
    // rust: let record = Record::new(key, page, start, quads, boxed).facing(&sides);
    // rust: let id = gpu.records.insert(record);
    // rust: let placed = (key, page, start, quads, boxed, false);
    // rust: assert!(held.insert(id, (placed, sides)).is_none(), "id {id} twice");
}
    // rust: let new = if case == 4 { 0 } else { 3_000 };
    // rust: for _ in 0..new {
    // rust: place(&mut gpu, &mut held, &mut rng, &mut shapes);
}
    // rust: let room = gpu.sections.bytes;
    // rust: if case == 18 {
                // Past the table's room: it grows, and is written whole.
    // rust: while u64::from(gpu.records.ids()) * Record::BYTES <= room {
    // rust: place(&mut gpu, &mut held, &mut rng, &mut shapes);
}
}
            // A fifth of the sections fade: the flags that change go up as
            // updates, or with the whole table (cases 4 and 18), and through
            // case 7's frame the CPU draws.
    // rust: for (&id, (placed, _)) in held.iter_mut() {
    // rust: placed.5 = flags.below(5) == 0;
    // rust: gpu.records.set_fading(id, placed.5);
}
    // rust: if at_edge {
                // A section at the camera with a quad in each side bucket, each
                // threshold 0: the eye is a subnormal float past +X's, on +Z's,
                // +Y's, -Z's and -Y's, and behind -X's, so only +X's is drawn.
    // rust: let ends = [1, 1, 2, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6];
    // rust: let planes = [1.0, 1.0, 0.0, 1.0, -1.0, -1.0, -1.0].map(|p| p / 16.0);
    // rust: let sides = Sides::from_parts(ends, false, true, planes);
    // rust: let key = (cx, 3, cz);
    // rust: let record = Record::new(key, 0, 0, 6, UNBOUNDED).facing(&sides);
    // rust: let id = gpu.records.insert(record);
    // rust: let placed = (key, 0, 0, 6, UNBOUNDED, false);
    // rust: assert!(held.insert(id, (placed, sides)).is_none(), "id {id} twice");
    // rust: edge = Some(id);
}
    // rust: let whole = gpu.records.all_dirty;
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let input = FrameInputs {
    // rust: camera,
    // rust: min_y,
    // rust: sections: height,
    // rust: radius,
    // rust: frustum: &frustum,
    // rust: reach,
    // rust: eye,
    // rust: view_proj: Mat4::IDENTITY,
    // rust: occlude: false,
}
    // rust: if case == 7 {
                // Planes past the integers: the CPU draws that frame, nothing is
                // written, and the records that changed wait for the next.
    // rust: let up = FrameInputs {
    // rust: camera: camera + DVec3::Y * 2.0e7,
    // rust: ..input
}
    // rust: let prepared = gpu.prepare(device, queue, &mut uploads, &mut encoder, &up);
    // rust: assert_eq!(prepared, Prepared::Cpu, "case 7");
    // rust: assert!(gpu.records.all_dirty || !gpu.records.dirty.is_empty());
}
    // rust: let prepared = gpu.prepare(device, queue, &mut uploads, &mut encoder, &input);
    // rust: assert_eq!(prepared, Prepared::Gpu, "case {case}");
    // rust: match case {
    // rust: 4 => assert!(
    // rust: whole && gpu.sections.bytes == room,
    // rust: "case 4: in place, whole"
    // rust: ),
    // rust: 18 => assert!(gpu.sections.bytes > room, "case 18: the table grows"),
    // rust: 20 => assert!(gpu.reach.bytes > 1 << 16, "case 20: the graph's copy grows"),
    // rust: _ => {}
}
    // rust: let mut params = tables(&input, &mut words).expect("the planes fit");
    // rust: params.pages = gpu.pass_pages;
    // rust: let (mut expected, mut kept_sections) = (Vec::new(), 0);
    // rust: for (&id, &((key, page, start, quads, boxed, fading), sides)) in &held {
    // rust: let record = Record::new(key, page, start, quads, boxed).facing(&sides);
    // rust: let kept = keeps(&params, &words, &record.fading(fading));
    // rust: let reached = reach.is_none_or(|r| r.contains(key));
                // In view, but fading: the CPU's.
    // rust: faded += usize::from(fading && reached && keeps(&params, &words, &record));
    // rust: if kept && let Some(r) = reach {
    // rust: graphed += 1;
    // rust: unreached += usize::from(!reached);
                    // Above the box, over its columns: the sky band.
    // rust: let over = (key.0 - r.from_x).abs() <= r.radius
    // rust: && (key.2 - r.from_z).abs() <= r.radius;
    // rust: if over && key.1 >= r.y0 + r.height {
    // rust: band[usize::from(reached)] += 1;
}
}
    // rust: if kept && reached {
    // rust: let origin = resident::origin(key, min_y, camera).as_vec3();
    // rust: let instance = super::super::section_instance(origin.to_array(), 0, 1.0);
    // rust: let instance = instance.map(f32::to_bits);
                    // A draw per run of it the CPU frame draws, from the run's
                    // first vertex.
    // rust: let (mut runs, mut drawn) = (0, 0);
    // rust: super::super::facing_runs(&sides, eye, origin.to_array(), |first, count| {
    // rust: expected.push((page, start as u32 + first * 4, count * 6, instance));
    // rust: runs += 1;
    // rust: drawn += count;
    // rust: });
    // rust: kept_sections += 1;
    // rust: if eye.is_some() {
    // rust: eyed += 1;
    // rust: hidden += usize::from(drawn < quads);
    // rust: several += usize::from(runs >= 3);
}
    // rust: if Some(id) == edge {
    // rust: assert_eq!((runs, drawn), (1, 1), "case {case}: the bucket at the edge");
    // rust: edge_drawn = true;
}
    // rust: } else if !fading && in_view_distance((cx, cz), radius, key.0, key.2) {
    // rust: culled += 1;
}
}
    // rust: gpu.dispatch(&mut encoder, None);
            // Its statistics come back with a CPU part of the case's own.
    // rust: let cpu = [case * 7, case * 3, case];
    // rust: gpu.copy_stats(&mut encoder, case as u64, cpu);
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: gpu.submitted().expect("a readback free")();
    // rust: let pages = u64::from(gpu.pass_pages);
    // rust: let counts = read(device, queue, &gpu.counts.buffer, (STATS + pages) * 4);
    // rust: let draws = read(device, queue, &gpu.draws.buffer, gpu.draws.bytes);
    // rust: let origins = read(device, queue, &gpu.origins.buffer, u64::from(gpu.ids) * 16);
    // rust: let mut got = Vec::new();
    // rust: for &(page, first, size) in &gpu.pages {
    // rust: let count = counts[(STATS + u64::from(page)) as usize];
    // rust: assert!(
    // rust: count <= size,
    // rust: "case {case}, page {page}: {count} draws, room {size}"
    // rust: );
    // rust: let mut last = None;
    // rust: for d in draws[first as usize * 5..][..count as usize * 5].chunks(5) {
                    // In id order and each section's in its runs' order, the
                    // same every frame.
    // rust: assert!(
    // rust: last < Some((d[4], d[3])),
    // rust: "case {case}, page {page}: out of order"
    // rust: );
    // rust: last = Some((d[4], d[3]));
    // rust: assert_eq!([d[1], d[2]], [1, 0], "case {case}: one instance, index 0");
    // rust: let instance = &origins[d[4] as usize * 4..][..4];
    // rust: let instance: [u32; 4] = instance.try_into().unwrap();
    // rust: got.push((page, d[3], d[0], instance));
}
}
    // rust: let draw_count = expected.len() as u32;
    // rust: expected.sort_unstable();
    // rust: got.sort_unstable();
    // rust: assert_eq!(got.len(), expected.len(), "case {case}: draws");
    // rust: assert_eq!(got, expected, "case {case}");
    // rust: assert_eq!(
    // rust: counts[..2],
    // rust: [kept_sections, draw_count],
    // rust: "case {case}: sections kept, draws"
    // rust: );
            // The reads above waited for the GPU.
    // rust: let (kept, drawn) = (kept_sections as usize, draw_count as usize);
    // rust: assert_eq!(
    // rust: gpu.collect(device),
    // rust: Some((case as u64, [cpu[0] + kept, cpu[1] + drawn, cpu[2]])),
    // rust: "case {case}: statistics"
    // rust: );
    // rust: compared += kept_sections as usize;
}
        // Not a comparison of empty lists, nor of a test that keeps everything.
        // The graphs leave out a real share of what the frustum keeps, and their
        // sky band keeps sections above a box in some cases and not in others.
        // The flags leave out about a fifth of what they would keep. From an eye,
        // most sections have a bucket left out and some take three draws or
        // more, and the bucket at the section's edge is drawn.
    // rust: assert!(compared > 2_000, "{compared} sections drawn");
    // rust: assert!(
    // rust: hidden * 2 > eyed && several * 50 > eyed,
    // rust: "of {eyed} from an eye, {hidden} with a bucket left out, {several} in three runs"
    // rust: );
    // rust: assert!(edge_drawn, "the bucket at the section's edge");
    // rust: assert!(culled > 2_000, "{culled} within the distance left out");
    // rust: assert!(faded * 10 > compared, "{faded} fading of {compared} drawn");
    // rust: assert!(
    // rust: unreached * 10 > graphed && unreached < graphed,
    // rust: "{unreached} of {graphed} in view unreached"
    // rust: );
    // rust: assert!(
    // rust: band[0] > 0 && band[1] > 0,
    // rust: "the sky band left out and kept {band:?}"
    // rust: );
}

    // The statistics come back with their frame, in place and from the submit
    // thread, submitted as gfx.rs submits frames (`submit_later`, or in place
    // with its `after` handed back): three frames on their way fill the ring, a
    // fourth's are skipped, `collect` takes in the newest; and a readback whose
    // buffer the device lost after its mapping goes `FAILED`, never copied into
    // or unmapped again (as `timing::GpuTimer`'s), so the statistics stop.
the_statistics_come_back_with_their_frame :: proc() {
}
//         use super::super::submit::{AfterSubmit, Job};
    // rust: on_each_device(|device, queue| {
    // rust: for threaded in [false, true] {
    // rust: let queue = Queue::new((**queue).clone(), threaded);
    // rust: let mut gpu = GpuCulling::new(device, None).expect("the pass");
                // As if the pass kept 5 sections and drew 7 times.
    // rust: queue.write_buffer(&gpu.counts.buffer, 0, bytemuck::cast_slice(&[5_u32, 7]));
                // Whether the frame's statistics went out.
    // rust: let frame = |gpu: &mut GpuCulling, f: u64| {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: gpu.copy_stats(&mut encoder, f, [f as usize, 10, 3]);
    // rust: let after = gpu.submitted().map(|g| Box::new(g) as AfterSubmit);
    // rust: let sent = after.is_some();
    // rust: let job = Job {
    // rust: encoder,
    // rust: surface: None,
    // rust: after,
}
    // rust: if let Err(back) = queue.submit_later(job) {
    // rust: queue.submit([back.encoder.finish()]);
    // rust: if let Some(read) = back.after {
    // rust: read();
}
}
    // rust: sent
}
    // rust: let landed = |gpu: &mut GpuCulling| {
    // rust: queue.landed();
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: gpu.collect(device)
}
    // rust: for f in 1..=3 {
    // rust: assert!(frame(&mut gpu, f), "frame {f}, threaded {threaded}");
}
    // rust: assert!(!frame(&mut gpu, 4), "a full ring, threaded {threaded}");
    // rust: assert_eq!(landed(&mut gpu), Some((3, [3 + 5, 10 + 7, 3])));
    // rust: assert_eq!(gpu.collect(device), None);
    // rust: assert!(frame(&mut gpu, 5));
    // rust: assert_eq!(landed(&mut gpu), Some((5, [5 + 5, 10 + 7, 3])));
                // Frame 6's buffer destroyed after its mapping (#6320).
    // rust: let lost = gpu.next;
    // rust: assert!(frame(&mut gpu, 6));
    // rust: queue.landed();
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: gpu.readbacks[lost].buffer.destroy();
    // rust: assert_eq!(gpu.collect(device), None);
    // rust: for f in 7..=12 {
    // rust: let sent = frame(&mut gpu, f);
    // rust: let back = landed(&mut gpu);
    // rust: let state = gpu.readbacks[lost].state.load(Ordering::Acquire);
    // rust: assert_eq!(state, FAILED, "frame {f}, threaded {threaded}");
                    // The two other readbacks, then none.
    // rust: assert_eq!(sent, f <= 8, "frame {f}, threaded {threaded}");
    // rust: assert_eq!(back.is_some(), f <= 8, "frame {f}, threaded {threaded}");
}
}
    // rust: });
}

    // `draw`'s count draws draw what the pass kept, page by page: each kept
    // section's quads from its own range, all of them without an eye and those
    // of its runs that can face one with it, with its own origin, which the
    // draw's first instance picks out of the instance-rate origins (on DirectX
    // 12 too, where no count draw's first instance reaches `instance_index`),
    // and nothing past a page's count, though its region still holds the frame
    // before's longer list. Nor the sections that went since, the table's last
    // among them. Drawn through the terrain's vertex layouts, each quad writes
    // its origin's bits to a pixel of its own; a quad turned away leaves its
    // pixel clear.
the_count_draws_draw_each_kept_section_with_its_origin :: proc() {
}
    // rust: on_each_device(draws_land);
}

    // `draws_land`'s shaders: a quad's corners put it on its pixel, which
    // gets the bits of the origin it is drawn with.
    // rust: const ORIGINS: &str = "
Quad :: struct {
    // rust: @builtin(position) clip: vec4<f32>,
    // rust: @location(0) @interpolate(flat) origin: vec4<u32>,
}
    // rust: @vertex fn vs(@location(0) position: vec3<f32>, @location(5) origin: vec4<f32>) -> Quad {
    // rust: return Quad(vec4<f32>(position.xy, 0.0, 1.0), bitcast<vec4<u32>>(origin));
}
    // rust: @fragment fn fs(quad: Quad) -> @location(0) vec4<u32> {
    // rust: return quad.origin;
}
    // rust: ";

draws_land :: proc(device: ^wgpu::Device, queue: ^Queue) {
}
//         use crate::mesher::TerrainVertex;
        // Section i's quad q covers pixel (4 * (i % 16) + q, i / 16). The
        // sections take turns on pages 0, 1 and 3, a grain each: page 2 has none.
SECTIONS :: 192
    // rust: let (width, height) = (64, SECTIONS / 16);
    // rust: let stride = std::mem::size_of::<TerrainVertex>() as u64;
    // rust: let grain = super::super::arena::GRAIN;
    // rust: let mut arena = Arena::new(device, stride, grain, false);
    // rust: for _ in 0..4 {
    // rust: assert!(arena.open_page(device, u64::from(SECTIONS / 3) * grain));
}
    // rust: let mut gpu = GpuCulling::new(device, None).expect("the pass");
    // rust: let mut rng = Rng(0x9E37_79B9_7F4A_7C15);
        // The sections' buckets by facing side have their own sequence.
    // rust: let mut shapes = Rng(0xA54F_F53A_5F1D_36F1);
    // rust: let (radius, min_y, levels) = (4, -64, 24);
    // rust: let corner = |x: u32, y: u32| TerrainVertex {
    // rust: pos: [
    // rust: x as f32 / width as f32 * 2.0 - 1.0,
    // rust: 1.0 - y as f32 / height as f32 * 2.0,
    // rust: 0.0,
    // rust: ],
    // rust: ..bytemuck::Zeroable::zeroed()
}
    // rust: let mut sections = Vec::new();
    // rust: for i in 0..SECTIONS {
    // rust: let (page, start) = ([0, 1, 3][i as usize % 3], u64::from(i / 3) * grain);
    // rust: let quads = 1 + rng.below(4);
    // rust: let (x, y) = (4 * (i % 16), i / 16);
    // rust: let vertices: Vec<_> = (x..x + quads)
    // rust: .flat_map(|x| [(x, y), (x + 1, y), (x + 1, y + 1), (x, y + 1)])
    // rust: .map(|(x, y)| corner(x, y))
    // rust: .collect();
    // rust: let bytes = bytemuck::cast_slice(&vertices);
    // rust: queue.write_buffer(arena.buffer(page), start * stride, bytes);
    // rust: let near = |rng: &mut Rng| rng.range(-radius, radius);
    // rust: let key = (near(&mut rng), rng.range(0, levels - 1), near(&mut rng));
    // rust: let sides = sides_of(&mut shapes, quads);
    // rust: let record = Record::new(key, page, start, quads, rounded_box(bounds(&mut rng)));
    // rust: let record = record.facing(&sides);
    // rust: gpu.records.insert(record);
    // rust: sections.push((key, sides, record));
}
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Wgsl(ORIGINS.into()),
    // rust: });
    // rust: let origins = wgpu::vertex_attr_array![5 => Float32x4];
    // rust: let buffers = [
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: stride,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &super::super::TERRAIN_ATTRIBUTES,
    // rust: }),
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 16,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &origins,
    // rust: }),
    // rust: ];
    // rust: let format = wgpu::TextureFormat::Rgba32Uint;
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: None,
    // rust: layout: None,
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: None,
    // rust: compilation_options: Default::default(),
    // rust: buffers: &buffers,
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: None,
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(format.into())],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let target = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width,
    // rust: height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = target.create_view(&Default::default());
    // rust: let pixels = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(width * height) * 16,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::COPY_SRC,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let indices = super::super::Renderer::quad_indices(device, 4);
    // rust: let mut uploads = Uploads::new(device);
        // The first frame's planes reject nothing: it keeps every section within
        // the distance, and draws all their quads. The second, from another
        // camera in the same column, keeps those in its view: fewer, and draws
        // those of their quads that can face its eye.
    // rust: let all = Frustum {
    // rust: planes: [Vec4::W; 6],
}
    // rust: let lens = super::super::world_projection(70.0, 16.0 / 9.0, 512.0);
    // rust: let (ahead, eye) = through(lens * crate::camera::view_matrix(0.0, 0.0));
    // rust: let frames = [
    // rust: (DVec3::new(8.375, 70.625, 3.125), &all, None),
    // rust: (DVec3::new(2.75, -3.5, 13.875), &ahead, Some(eye)),
    // rust: ];
    // rust: let (mut words, mut before) = (Vec::new(), usize::MAX);
    // rust: for (frame, (camera, frustum, eye)) in frames.into_iter().enumerate() {
    // rust: if frame == 1 {
                // Every fifth section goes before the second frame, and the last 20,
                // which the table's end leaves: the GPU still holds what the first
                // frame drew of them.
    // rust: for (id, section) in sections.iter_mut().enumerate() {
    // rust: if id % 5 == 0 || id >= SECTIONS as usize - 20 {
    // rust: gpu.records.remove(id as u32);
    // rust: section.2 = Record::FREE;
}
}
}
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let input = FrameInputs {
    // rust: camera,
    // rust: min_y,
    // rust: sections: levels,
    // rust: radius,
    // rust: frustum,
    // rust: reach: None,
    // rust: eye,
    // rust: view_proj: Mat4::IDENTITY,
    // rust: occlude: false,
}
    // rust: let prepared = gpu.prepare(device, queue, &mut uploads, &mut encoder, &input);
    // rust: assert_eq!(prepared, Prepared::Gpu, "frame {frame}");
    // rust: let mut params = tables(&input, &mut words).expect("the planes fit");
    // rust: params.pages = gpu.pass_pages;
    // rust: let mut expected = vec![[0; 4]; (width * height) as usize];
    // rust: let (mut kept, mut hidden) = (0, 0);
    // rust: for (i, &(key, sides, record)) in sections.iter().enumerate() {
    // rust: if keeps(&params, &words, &record) {
    // rust: let origin = resident::origin(key, min_y, camera).as_vec3();
    // rust: let instance = super::super::section_instance(origin.to_array(), 0, 1.0);
    // rust: let at = i / 16 * width as usize + 4 * (i % 16);
    // rust: hidden += sides.quads();
    // rust: super::super::facing_runs(&sides, eye, origin.to_array(), |first, count| {
    // rust: let first = at + first as usize;
    // rust: expected[first..first + count as usize].fill(instance.map(f32::to_bits));
    // rust: hidden -= count;
    // rust: });
    // rust: kept += 1;
}
}
    // rust: assert!(kept > 0 && kept < before, "frame {frame}: {kept} kept");
    // rust: assert_eq!(
    // rust: hidden > 0,
    // rust: eye.is_some(),
    // rust: "frame {frame}: {hidden} quads turned away"
    // rust: );
    // rust: before = kept;
    // rust: gpu.dispatch(&mut encoder, None);
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_index_buffer(indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: gpu.draw(&mut pass, &arena, |_| None, 0);
    // rust: drop(pass);
    // rust: encoder.copy_texture_to_buffer(
    // rust: target.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &pixels,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(width * 16),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: target.size(),
    // rust: );
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: let got = read(device, queue, &pixels, pixels.size());
    // rust: let row = width as usize;
    // rust: for (p, (got, want)) in got.chunks(4).zip(&expected).enumerate() {
    // rust: let (i, q) = (p / row * 16 + p % row / 4, p % 4);
    // rust: assert_eq!(got, want, "frame {frame}, section {i}, quad {q}");
}
}
}
}
