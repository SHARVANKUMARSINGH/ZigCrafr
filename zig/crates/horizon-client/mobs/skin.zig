//! Transpiled from Horizon Rust crate
//! Module: horizon-client_skin
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Mob models posed on the GPU (`gfx::entity_skin`): the store of models
//! uploaded once, and the walk that turns one `render::draw` into the parts'
//! matrices and jobs the shader expands into the very vertices `draw` would
//! push, in its order.
//!
//! A model takes this path only when every polygon faces an axis: the
//! normal matrix times an axis is one of its columns, exactly, so the shader's
//! packed normals are the CPU's to the bit. Positions and UVs are the same
//! sums in the same order (`Mat4::transform_point3`).

// use super::{ModelNormals, Part, anim::Poses};
// use crate::fast_hash::FxHashMap;
// use crate::gfx::entity_skin::{SkinFrame, SkinJob, SkinPart, SkinVertex};
// use horizon_assets::item_bake::BakedItemModel;
// use std::sync::Arc;

/// A stored model: where its vertices start, and per part (pre-order) its
/// own vertices and the end of its subtree, for the walk.
pub const Stored = struct {
    first: u32,
    parts: std.ArrayList(StoredPart),
    /// The model's bounds in its parts' own space, per part: min and max of
    /// its own vertices (none: no polygons).
    bounds: Vec<Option<([f32,
    /// The model's render type culls back faces (the bat, the baby turtle).
    cull: bool,
};

pub const StoredPart = struct {
    /// The part's first vertex, from the model's.
    first: u32,
    count: u32,
    /// One past the last part of its subtree.
    end: u32,
};

/// The models on the GPU, by the `Arc` they are drawn from. An entry holds
/// its `Arc`, so the address is never reused while stored; models no one
/// else holds any more are dropped by `begin`.
pub const SkinModels = struct {
    stored: FxHashMap<usize,
    /// Item models, the same way (`item_render::ItemRenderState::submit_skinned`).
    items: FxHashMap<usize,
    vertices: u32,
    /// Whether the layers improved transparency would draw in its stages are
    /// posed here too (`gfx::Renderer::skins_tagged`; set each frame): the eyes
    /// render type's (spiders', endermen's...) as [`SkinJob::FLAT`] draws, and
    /// `entityTranslucent` layers (a horse's markings, a slime's outer cube).
    tagged: bool,
};

/// A stored item model: its quads' vertices in order, by runs of quads that
/// share a sprite and a tint, and its bounds.
pub const StoredItem = struct {
    runs: std.ArrayList(ItemRun),
    bounds: (glam::Vec3,
};

/// Consecutive quads of an item model with one sprite and tint index.
pub const ItemRun = struct {
    /// The run's first vertex in the store, and its vertex count.
    first: u32,
    count: u32,
    /// Its first quad in the model.
    quad: usize,
    tint_index: i32,
};

/// Models whose store would grow past this restart it (a pack reload's
/// models pile up otherwise).
pub const STORE_LIMIT: u32 = 4 << 20;

    // rust: impl SkinModels {
    /// Starts a frame: drops the models nothing else holds (their vertices
    /// stay in the store until it restarts), restarts the store when it grew
    /// too large or the renderer's (`stored`, its size) is out of step.
pub fn begin(self: *Self, frame: *mut SkinFrame, stored: u32) void {
}
    // rust: if self.vertices > STORE_LIMIT || stored + frame.new_model.len() as u32 != self.vertices {
    // rust: self.restart(frame);
}
    // rust: self.stored
    // rust: .retain(|_, (model, _)| Arc::strong_count(model) > 1);
    // rust: self.items
    // rust: .retain(|_, (model, _)| Arc::strong_count(model) > 1);
    // rust: frame.clear_draws();
}

pub fn restart(self: *Self, frame: *mut SkinFrame) void {
}
    // rust: self.stored.clear();
    // rust: self.items.clear();
    // rust: self.vertices = 0;
    // rust: frame.new_model.clear();
    // rust: frame.base = 0;
    // rust: frame.reset = true;
}

pub fn entry(self: *Self, model: **Part, frame: *mut SkinFrame) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = Arc::as_ptr(model) as usize;
    // rust: let vertices = &mut self.vertices;
    // rust: let (_, stored) = self.stored.entry(key).or_insert_with(|| {
            // The renderer appends `new_model` to its store in order, so a
            // model's first vertex is the store's size when it is added.
    // rust: let before = frame.new_model.len();
    // rust: let stored = flatten(model, *vertices, &mut frame.new_model);
    // rust: *vertices += (frame.new_model.len() - before) as u32;
    // rust: (model.clone(), stored)
    // rust: });
    // rust: stored.as_ref()
}

    /// An item model's runs, stored on first sight; `None` when it has no
    /// quads, or one that glows (`light_emission`) or is forced translucent.
    // rust: pub fn item(
    // rust: &mut self,
    // rust: model: &Arc<BakedItemModel>,
    // rust: frame: &mut SkinFrame,
    // rust: ) -> Option<&StoredItem> {
    // rust: let key = Arc::as_ptr(model) as usize;
    // rust: let vertices = &mut self.vertices;
    // rust: let (_, stored) = self.items.entry(key).or_insert_with(|| {
    // rust: let before = frame.new_model.len();
    // rust: let stored = flatten_item(model, *vertices, &mut frame.new_model);
    // rust: *vertices += (frame.new_model.len() - before) as u32;
    // rust: (model.clone(), stored)
    // rust: });
    // rust: stored.as_ref()
}
}

/// The model's quads as `item_render::submit_quads` reads them, appended to
/// `out` (part 0, the layer's pose); `None` when a quad glows or is forced
/// translucent (another material).
    // rust: fn flatten_item(
    // rust: model: &BakedItemModel,
    // rust: first: u32,
    // rust: out: &mut Vec<SkinVertex>,
    // rust: ) -> Option<StoredItem> {
//     use horizon_assets::model::Direction as D;
    // rust: let other =
    // rust: |q: &horizon_assets::bake::ModelQuad| q.light_emission != 0 || q.material.force_translucent;
    // rust: if model.quads.is_empty() || model.quads.iter().any(other) {
    // rust: return None;
}
    // rust: let mut runs: Vec<ItemRun> = Vec::new();
    // rust: let mut lo = glam::Vec3::INFINITY;
    // rust: let mut hi = glam::Vec3::NEG_INFINITY;
    // rust: for (i, q) in model.quads.iter().enumerate() {
    // rust: let vertex = first + 4 * i as u32;
    // rust: match runs.last_mut() {
    // rust: Some(run)
    // rust: if model.quads[run.quad].material.sprite == q.material.sprite
    // rust: && run.tint_index == q.tint_index =>
    // rust: {
    // rust: run.count += 4;
}
    // rust: _ => runs.push(ItemRun {
    // rust: first: vertex,
    // rust: count: 4,
    // rust: quad: i,
    // rust: tint_index: q.tint_index,
    // rust: }),
}
    // rust: let axis = match q.facing {
    // rust: D::East => 0,
    // rust: D::Up => 1,
    // rust: D::South => 2,
    // rust: D::West => 3,
    // rust: D::Down => 4,
    // rust: D::North => 5,
}
    // rust: for (pos, uv) in q.positions.iter().zip(q.uv) {
    // rust: lo = lo.min(glam::Vec3::from_array(*pos));
    // rust: hi = hi.max(glam::Vec3::from_array(*pos));
    // rust: out.push(SkinVertex {
    // rust: pos: *pos,
    // rust: uv,
    // rust: axis,
    // rust: part: 0,
    // rust: });
}
}
    // rust: Some(StoredItem {
    // rust: runs,
    // rust: bounds: (lo, hi),
    // rust: })
}

/// The model's vertices in pre-order (a part's polygons, then its children),
/// appended to `out`; `None` when a polygon does not face an axis.
pub fn flatten(model: *Part, first: u32, out: *mut std.ArrayList(SkinVertex)) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = out.len();
    // rust: let mut parts = Vec::new();
    // rust: let mut bounds = Vec::new();
    // rust: fn walk(
    // rust: part: &Part,
    // rust: start: usize,
    // rust: out: &mut Vec<SkinVertex>,
    // rust: parts: &mut Vec<StoredPart>,
    // rust: bounds: &mut Vec<Option<([f32; 3], [f32; 3])>>,
    // rust: ) -> bool {
    // rust: let index = parts.len();
    // rust: let own = (out.len() - start) as u32;
    // rust: parts.push(StoredPart {
    // rust: first: own,
    // rust: count: 0,
    // rust: end: 0,
    // rust: });
    // rust: bounds.push(None);
    // rust: let mut lo = [f32::INFINITY; 3];
    // rust: let mut hi = [f32::NEG_INFINITY; 3];
    // rust: for poly in &part.polygons {
    // rust: let Some(axis) = axis(poly.normal) else {
    // rust: return false;
}
    // rust: for v in poly.vertices {
    // rust: let pos = (glam::Vec3::new(v[0], v[1], v[2]) / 16.0).to_array();
    // rust: for a in 0..3 {
    // rust: lo[a] = lo[a].min(pos[a]);
    // rust: hi[a] = hi[a].max(pos[a]);
}
    // rust: out.push(SkinVertex {
    // rust: pos,
    // rust: uv: [v[3], v[4]],
    // rust: axis,
    // rust: part: index as u32,
    // rust: });
}
}
    // rust: parts[index].count = (out.len() - start) as u32 - own;
    // rust: if !part.polygons.is_empty() {
    // rust: bounds[index] = Some((lo, hi));
}
    // rust: for child in &part.children {
    // rust: if !walk(child, start, out, parts, bounds) {
    // rust: return false;
}
}
    // rust: parts[index].end = parts.len() as u32;
    // rust: true
}
    // rust: if !walk(model, start, out, &mut parts, &mut bounds) {
    // rust: out.truncate(start);
    // rust: return None;
}
    // rust: Some(Stored {
    // rust: first,
    // rust: parts,
    // rust: bounds,
    // rust: cull: has_cull(model),
    // rust: })
}

/// Whether the model's polygons cull back faces (all or none, set per model).
pub fn has_cull(part: *Part) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: part.polygons.iter().any(|p| p.cull_back) || part.children.iter().any(has_cull)
}

/// 0..2 for +x, +y, +z, 3..5 for -x, -y, -z; `None` for any other normal.
pub fn axis(n: [f32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut found = None;
    // rust: for (a, &c) in n.iter().enumerate() {
    // rust: if c == 1.0 || c == -1.0 {
    // rust: if found.is_some() {
    // rust: return None;
}
    // rust: found = Some(a as u32 + if c < 0.0 { 3 } else { 0 });
    // rust: } else if c != 0.0 {
    // rust: return None;
}
}
    // rust: found
}

/// One draw's parameters (`render::draw_scrolled`'s).
pub const Paint = struct {
    uv: [f32,
    scroll: f32,
    color: u32,
    light: u32,
    overlay: u32,
};

/// Where a frame's posed draws go, and the bounds of the current mob's.
pub const Skin = struct {
    models: *'a mut SkinModels,
    frame: *'a mut SkinFrame,
    /// Camera-relative bounds of what this mob drew here (for culling).
    bounds: Option<(glam::Vec3,
    /// The last walk, for a draw that repeats it.
    last: ?Walked,
};

/// One walk of [`Skin::draw`]: what it drew, and the jobs it pushed.
pub const Walked = struct {
    model: usize,
    base: glam::Mat4,
    poses: u64,
    jobs: std::ops::Range<usize>,
};

    // rust: impl<'a> Skin<'a> {
    /// One entity's draws into `frame`.
pub fn new(models: *'a mut SkinModels, frame: *'a mut SkinFrame) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: models,
    // rust: frame,
    // rust: bounds: None,
    // rust: last: None,
}
}

    /// Grows the bounds of what this entity drew here by `lo..hi` posed by `m`.
pub fn grow_bounds(self: *Self, m: glam::Mat4) void {
}
    // rust: let center = m.transform_point3((lo + hi) * 0.5);
    // rust: let half = (hi - lo) * 0.5;
    // rust: let r = glam::Mat3::from_mat4(m);
    // rust: let extent = r.x_axis.abs() * half.x + r.y_axis.abs() * half.y + r.z_axis.abs() * half.z;
    // rust: let (a, b) = (center - extent, center + extent);
    // rust: self.bounds = Some(match self.bounds {
    // rust: Some((l, h)) => (l.min(a), h.max(b)),
    // rust: None => (a, b),
    // rust: });
}

    /// Whether this model can be posed here (stored on first sight).
pub fn supports(self: *Self, model: **Part) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.models.entry(model, self.frame).is_some()
}

    /// `render::draw_scrolled` on the GPU: false (nothing done) when the
    /// model cannot take this path.
    // rust: pub fn draw(
    // rust: &mut self,
    // rust: model: &Arc<Part>,
    // rust: base: glam::Mat4,
    // rust: poses: &Poses,
    // rust: paint: Paint,
    // rust: ) -> bool {
    // rust: let key = Arc::as_ptr(model) as usize;
        // A draw that repeats the last walk (a villager's type, profession and
        // level over its body, a spider's eyes): the same model, matrix and
        // poses give the same part matrices and parts left out, so its jobs
        // are the last ones' over the same parts, with this paint.
    // rust: if let Some(last) = &self.last
    // rust: && last.model == key
    // rust: && last.base == base
    // rust: && last.poses == poses.version()
    // rust: {
    // rust: for i in last.jobs.clone() {
    // rust: let job = self.frame.jobs[i];
    // rust: self.frame.jobs.push(SkinJob {
    // rust: dst: self.frame.vertices,
    // rust: ..paint.job(job.first, job.count, job.part, job.cull)
    // rust: });
    // rust: self.frame.vertices += job.count;
}
    // rust: return true;
}
    // rust: let Some(stored) = self.models.entry(model, self.frame) else {
    // rust: return false;
}
    // rust: let jobs = self.frame.jobs.len();
    // rust: let first_part = self.frame.parts.len() as u32;
    // rust: self.frame.parts.resize(
    // rust: self.frame.parts.len() + stored.parts.len(),
    // rust: bytemuck::Zeroable::zeroed(),
    // rust: );
    // rust: let mut walk = Walk {
    // rust: stored,
    // rust: poses,
    // rust: parts: &mut self.frame.parts[first_part as usize..],
    // rust: jobs: &mut self.frame.jobs,
    // rust: vertices: &mut self.frame.vertices,
    // rust: bounds: &mut self.bounds,
    // rust: first_part,
    // rust: paint,
    // rust: index: 0,
}
    // rust: walk.part(model, base, ModelNormals::new(base));
        // The walk's first job never extends an earlier draw's: those have
        // other parts.
    // rust: self.last = Some(Walked {
    // rust: model: key,
    // rust: base,
    // rust: poses: poses.version(),
    // rust: jobs: jobs..self.frame.jobs.len(),
    // rust: });
    // rust: true
}
}

    // rust: impl Paint {
    /// A job drawing `count` stored vertices from `first`, posed by the parts
    /// from `part`, in this paint (`dst` left 0).
pub fn job(self: *Self, first: u32, count: u32, part: u32, cull: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SkinJob {
    // rust: first,
    // rust: count,
    // rust: part,
    // rust: dst: 0,
    // rust: rect: self.uv,
    // rust: scroll: self.scroll,
    // rust: color: self.color,
    // rust: light: self.light,
    // rust: overlay: self.overlay,
    // rust: glint: u32::from(self.overlay == super::render::ARMOR_GLINT),
    // rust: mode: SkinJob::MODEL,
    // rust: cull,
    // rust: spare: 0,
}
}
}

pub const Walk = struct {
    stored: *'a Stored,
    poses: *'a Poses,
    parts: *'a mut [SkinPart],
    jobs: *'a mut std.ArrayList(SkinJob),
    vertices: *'a mut u32,
    bounds: *'a mut Option<(glam::Vec3,
    first_part: u32,
    paint: Paint,
    /// The pre-order index of the part being walked.
    index: u32,
};

    // rust: impl Walk<'_> {
    /// `render::draw_normals` without the vertices: the part's matrices, and
    /// its polygons as (part of) a job.
pub fn part(self: *Self, part: *Part, base: glam::Mat4, normals: ModelNormals) void {
}
    // rust: let index = self.index;
    // rust: let stored = self.stored.parts[index as usize];
    // rust: let p = self.poses.pose(part);
    // rust: let m = super::render::posed(base, p);
    // rust: if self.poses.is_hidden(part) || p[6] == 0.0 && p[7] == 0.0 && p[8] == 0.0 {
            // The whole subtree is left out.
    // rust: self.index = stored.end;
    // rust: return;
}
    // rust: let normals = normals.part(p);
    // rust: let n = if normals.trusted {
    // rust: normals.matrix
    // rust: } else {
    // rust: glam::Mat3::from_cols(
    // rust: normals.matrix.x_axis.normalize_or_zero(),
    // rust: normals.matrix.y_axis.normalize_or_zero(),
    // rust: normals.matrix.z_axis.normalize_or_zero(),
    // rust: )
}
    // rust: self.parts[index as usize] = SkinPart {
    // rust: matrix: m.to_cols_array(),
    // rust: normal: n.to_cols_array(),
}
    // rust: if !self.poses.skips(part) && stored.count > 0 {
    // rust: self.emit(stored);
    // rust: if let Some((lo, hi)) = self.stored.bounds[index as usize] {
    // rust: let (lo, hi) = (glam::Vec3::from_array(lo), glam::Vec3::from_array(hi));
    // rust: let center = m.transform_point3((lo + hi) * 0.5);
    // rust: let half = (hi - lo) * 0.5;
    // rust: let r = glam::Mat3::from_mat4(m);
    // rust: let extent =
    // rust: r.x_axis.abs() * half.x + r.y_axis.abs() * half.y + r.z_axis.abs() * half.z;
    // rust: let (a, b) = (center - extent, center + extent);
    // rust: *self.bounds = Some(match *self.bounds {
    // rust: Some((l, h)) => (l.min(a), h.max(b)),
    // rust: None => (a, b),
    // rust: });
}
}
    // rust: self.index += 1;
    // rust: for child in &part.children {
    // rust: self.part(child, m, normals);
}
}

    /// The part's vertices: extends the last job when they follow its own.
pub fn emit(self: *Self, stored: StoredPart) void {
}
    // rust: let first = self.stored.first + stored.first;
    // rust: let paint = self.paint;
    // rust: if let Some(job) = self.jobs.last_mut()
    // rust: && job.first + job.count == first
    // rust: && job.part == self.first_part
    // rust: && job.dst + job.count == *self.vertices
    // rust: {
    // rust: job.count += stored.count;
    // rust: } else {
    // rust: self.jobs.push(SkinJob {
    // rust: dst: *self.vertices,
    // rust: ..paint.job(
    // rust: first,
    // rust: stored.count,
    // rust: self.first_part,
    // rust: u32::from(self.stored.cull),
    // rust: )
    // rust: });
}
    // rust: *self.vertices += stored.count;
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::gfx::entity_skin::expand;
//     use crate::mobs::{Mob, MobData, MobTypes, render};

pub fn restart_clears_models_and_marks_frame_reset() void {
}
    // rust: let mut models = SkinModels::default();
    // rust: let mut frame = SkinFrame::default();
    // rust: frame.jobs.push(Default::default());
    // rust: frame.parts.push(SkinPart {
    // rust: matrix: [0.0; 16],
    // rust: normal: [0.0; 9],
    // rust: });
    // rust: frame.vertices = 4;
    // rust: frame.outline_jobs.push(Default::default());
    // rust: frame.outline_vertices = 4;
    // rust: assert!(frame.pending());

    // rust: models.restart(&mut frame);
    // rust: frame.clear_draws();

    // rust: assert_eq!(models.vertices, 0);
    // rust: assert_eq!(frame.base, 0);
    // rust: assert_eq!(frame.vertices, 0);
    // rust: assert_eq!(frame.outline_vertices, 0);
    // rust: assert!(frame.jobs.is_empty());
    // rust: assert!(frame.parts.is_empty());
    // rust: assert!(frame.outline_jobs.is_empty());
    // rust: assert!(frame.reset);
}

    /// Every vanilla mob, at a few ages and turns: the GPU path's vertices
    /// (its jobs expanded as `entity_skin.wgsl` does) are the CPU path's, to
    /// the bit and in the same order, for each mob it takes; the mobs it
    /// leaves to the CPU draw exactly as before. Twice: with the eyes render
    /// type's layers left to the CPU (improved transparency on), then posed
    /// too with a horse's markings and a slime's outer cube (`SkinModels::tagged`).
    /// Needs the prepared resources.
pub fn posed_on_the_gpu_every_mob_draws_what_the_cpu_draws() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: eprintln!("no prepared resources: skipped");
    // rust: return;
}
    // rust: let types = MobTypes::load(&root).unwrap();
    // rust: let data = MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: MobData::load_animations(&root),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
        // Every texture its own rect, so a swapped texture shows.
    // rust: let atlas = |name: &str| {
    // rust: let h = name
    // rust: .bytes()
    // rust: .fold(7u32, |h, b| h.wrapping_mul(31).wrapping_add(u32::from(b)));
    // rust: let u = (h % 61) as f32 / 64.0;
    // rust: let v = (h / 61 % 61) as f32 / 64.0;
    // rust: Some([u, v, u + 1.0 / 64.0, v + 1.0 / 32.0])
}
    // rust: let camera = glam::DVec3::new(0.3, 62.0, -4.0);
    // rust: let mut models = SkinModels::default();
    // rust: let mut frame = SkinFrame::default();
    // rust: let mut store: Vec<crate::gfx::entity_skin::SkinVertex> = Vec::new();
    // rust: let (mut posed, mut kept) = (0, 0);
    // rust: let mut ids: Vec<_> = types.types.keys().cloned().collect();
    // rust: ids.sort();
        // The mobs posed at least once, without and with the tagged layers.
    // rust: let mut taken = [std::collections::BTreeSet::new(), Default::default()];
    // rust: for eyes in [false, true] {
    // rust: for (n, id) in ids.iter().enumerate() {
    // rust: let kind = Arc::new(types.types[id].clone());
    // rust: for (age, yaw) in [(0u32, 0.0f32), (37, 123.0), (412, -71.5)] {
    // rust: let at = horizon_core::geometry::Vec3::new(1.5 + n as f64 % 5.0, 64.0, 3.25);
    // rust: let mut m = Mob::new(n as u32 + 1, kind.clone(), at, yaw);
    // rust: m.previous = horizon_core::geometry::Vec3::new(at.x - 0.1, at.y, at.z + 0.05);
    // rust: m.age = age;
    // rust: m.limb_speed = 0.6;
    // rust: m.limb_position = age as f32 * 0.37;
                    // A farmer: its type, profession and level layers repeat
                    // the body's draw (`Skin::draw` reuses its walk).
    // rust: if matches!(
    // rust: id.as_str(),
    // rust: "minecraft:villager" | "minecraft:zombie_villager"
    // rust: ) {
    // rust: m.extra.variant2 = 5;
    // rust: m.extra.variant3 = 3;
}
                    // White field markings (`entityTranslucent`).
    // rust: if id == "minecraft:horse" {
    // rust: m.extra.variant2 = 2;
}
    // rust: let mut cpu = Vec::new();
    // rust: render::render_with(&m, 0.4, camera, &atlas, 0x50a0, &data, &[], &mut cpu);
    // rust: models.begin(&mut frame, store.len() as u32);
    // rust: models.tagged = eyes;
    // rust: let mut gpu = Vec::new();
    // rust: let mut skin = Skin::new(&mut models, &mut frame);
    // rust: render::render_skinned(
    // rust: &m, 0.4, camera, &atlas, 0x50a0, &data, &mut gpu, &mut skin,
    // rust: );
    // rust: let bounds = skin.bounds;
    // rust: if frame.reset {
    // rust: store.clear();
}
    // rust: assert_eq!(store.len() as u32, frame.base);
    // rust: store.extend_from_slice(&frame.new_model);
    // rust: frame.handed();
    // rust: if frame.jobs.is_empty() {
    // rust: kept += 1;
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(&gpu),
    // rust: bytemuck::cast_slice::<_, u8>(&cpu),
    // rust: "{id} age {age}: the CPU path changed"
    // rust: );
    // rust: continue;
}
    // rust: posed += 1;
    // rust: taken[usize::from(eyes)].insert(id.as_str());
    // rust: assert!(gpu.is_empty(), "{id}: a posed mob left vertices on the CPU");
    // rust: let expanded = expand(&store, &frame);
    // rust: assert_eq!(expanded.len(), cpu.len(), "{id} age {age}: vertex count");
    // rust: for (i, (a, b)) in expanded.iter().zip(&cpu).enumerate() {
    // rust: assert_eq!(
    // rust: bytemuck::bytes_of(a),
    // rust: bytemuck::bytes_of(b),
    // rust: "{id} age {age} vertex {i}: {a:?} != {b:?}"
    // rust: );
}
                    // The culling bounds hold every vertex.
    // rust: let (lo, hi) = bounds.expect("a posed mob has bounds");
    // rust: for v in &cpu {
    // rust: let p = glam::Vec3::from_array(v.pos);
    // rust: assert!(
    // rust: p.cmpge(lo - 1e-4).all() && p.cmple(hi + 1e-4).all(),
    // rust: "{id}: {p} outside {lo}..{hi}"
    // rust: );
}
}
}
}
    // rust: eprintln!("posed on the GPU: {posed} mob draws; kept on the CPU: {kept}");
    // rust: assert!(posed > 2 * 3 * 40, "only {posed} draws took the GPU path");
    // rust: let added: Vec<_> = taken[1].difference(&taken[0]).copied().collect();
    // rust: eprintln!("posed only with the tagged layers: {added:?}");
    // rust: for id in [
    // rust: "minecraft:spider",
    // rust: "minecraft:cave_spider",
    // rust: "minecraft:enderman",
    // rust: "minecraft:phantom",
    // rust: "minecraft:copper_golem",
    // rust: "minecraft:horse",
    // rust: "minecraft:slime",
    // rust: ] {
    // rust: assert!(added.contains(&id), "{id} not posed with its tagged layers");
}
    // rust: assert!(taken[0].is_subset(&taken[1]));
}

    /// `BatModel` and `BabyTurtleModel` draw with `entityCutoutCull`: their
    /// zero-depth ears, wings, feet and legs put two quads in one place, and
    /// only culling tells them apart. Their vertices ask for the shaded cull
    /// encoding, other mobs keep -127, on both paths (the whole-mob test above
    /// holds them bit-equal).
pub fn only_culled_render_types_ask_for_culled_back_faces() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: eprintln!("no prepared resources: skipped");
    // rust: return;
}
    // rust: let types = MobTypes::load(&root).unwrap();
    // rust: let turtle = &types.types["minecraft:turtle"];
    // rust: let baby_turtle = turtle.layer("turtle_baby#main").expect("baby turtle model");
    // rust: let cases: [(&str, &std::sync::Arc<crate::mobs::Part>, i8, u32); 5] = [
    // rust: (
    // rust: "minecraft:bat",
    // rust: &types.types["minecraft:bat"].model,
    // rust: crate::mesher::SHADED_CULL_W,
    // rust: 1,
    // rust: ),
    // rust: (
    // rust: "minecraft:turtle_baby",
    // rust: baby_turtle,
    // rust: crate::mesher::SHADED_CULL_W,
    // rust: 1,
    // rust: ),
    // rust: ("minecraft:turtle", &turtle.model, -127, 0),
    // rust: (
    // rust: "minecraft:cow",
    // rust: &types.types["minecraft:cow"].model,
    // rust: -127,
    // rust: 0,
    // rust: ),
    // rust: (
    // rust: "minecraft:cat",
    // rust: &types.types["minecraft:cat"].model,
    // rust: -127,
    // rust: 0,
    // rust: ),
    // rust: ];
    // rust: for (id, model, w, _) in cases {
    // rust: let mut part = vec![&**model];
    // rust: let mut seen = 0;
    // rust: while let Some(p) = part.pop() {
    // rust: for poly in &p.polygons {
    // rust: let n = poly.vertex_normal(ModelNormals::new(glam::Mat4::IDENTITY));
    // rust: assert_eq!(n[3], w, "{id}");
    // rust: seen += 1;
}
    // rust: part.extend(&p.children);
}
    // rust: assert!(seen > 0, "{id} has polygons");
}
        // The GPU path flags the job, the CPU path the polygons.
    // rust: let mut models = SkinModels::default();
    // rust: let mut frame = SkinFrame::default();
    // rust: for (id, model, _, cull) in cases {
    // rust: models.begin(&mut frame, 0);
    // rust: let mut skin = Skin::new(&mut models, &mut frame);
    // rust: assert!(skin.draw(
    // rust: model,
    // rust: glam::Mat4::IDENTITY,
    // rust: &Poses::default(),
    // rust: Paint {
    // rust: uv: [0.0, 0.0, 1.0, 1.0],
    // rust: scroll: 0.0,
    // rust: color: u32::MAX,
    // rust: light: 0,
    // rust: overlay: 0
    // rust: },
    // rust: ));
    // rust: assert!(frame.jobs.iter().all(|j| j.cull == cull), "{id}");
    // rust: frame.clear_draws();
}
}

    /// The armor stand's models (`ArmorStandRenderer`: the stand, the small
    /// one, their armour layers) posed like a stand: turned arms and head, a
    /// hidden part (scale 0, as a stand without arms or base plate), the
    /// armour glint on one layer. The GPU path draws what the CPU path draws,
    /// to the bit. Needs the prepared resources.
pub fn armor_stand_models_pose_on_the_gpu_as_on_the_cpu() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: if !root.join("entity-models.json").exists() {
    // rust: eprintln!("no prepared resources: skipped");
    // rust: return;
}
    // rust: let document = crate::mobs::EntityModelDocument::load(&root).unwrap();
    // rust: let base = glam::Mat4::from_translation(glam::Vec3::new(2.5, -1.0, 6.25))
    // rust: * glam::Mat4::from_rotation_y(2.1)
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -1.501, 0.0));
    // rust: let (mut models, mut frame) = (SkinModels::default(), SkinFrame::default());
    // rust: let mut store = Vec::new();
    // rust: let mut drawn = 0;
    // rust: for model in ["armor_stand", "armor_stand_small"] {
    // rust: for slot in ["main", "helmet", "chestplate", "leggings", "boots"] {
    // rust: let key = format!("minecraft:{model}#{slot}");
    // rust: let part = Arc::new(document.model(&key).unwrap_or_else(|| panic!("no {key}")));
    // rust: let mut poses = Poses::new(&part);
    // rust: for (name, turn) in [("head", [0.3, -0.7, 0.1]), ("left_arm", [-1.2, 0.4, 0.25])] {
    // rust: if poses.has(name) {
    // rust: poses.get(name)[3..6].copy_from_slice(&turn);
}
}
    // rust: for hidden in ["base_plate", "right_arm"] {
    // rust: if poses.has(hidden) {
    // rust: poses.get(hidden)[6..9].copy_from_slice(&[0.0; 3]);
}
}
    // rust: let overlay = if slot == "chestplate" {
    // rust: render::ARMOR_GLINT
    // rust: } else {
    // rust: 0
}
    // rust: let uv = [0.125, 0.25, 0.1875, 0.28125];
    // rust: let mut cpu = Vec::new();
    // rust: render::draw(
    // rust: &part,
    // rust: base,
    // rust: &poses,
    // rust: uv,
    // rust: 0xff80_c0ff,
    // rust: 0x70a0,
    // rust: overlay,
    // rust: &mut cpu,
    // rust: );
    // rust: models.begin(&mut frame, store.len() as u32);
    // rust: let mut gpu = Vec::new();
    // rust: let mut skin = Skin::new(&mut models, &mut frame);
    // rust: let paint = (uv, 0.0, 0xff80_c0ff, 0x70a0, overlay);
    // rust: render::put(
    // rust: &mut Some(&mut skin),
    // rust: &part,
    // rust: base,
    // rust: &poses,
    // rust: paint.0,
    // rust: paint.1,
    // rust: paint.2,
    // rust: paint.3,
    // rust: paint.4,
    // rust: &mut gpu,
    // rust: );
    // rust: if frame.reset {
    // rust: store.clear();
}
    // rust: store.extend_from_slice(&frame.new_model);
    // rust: frame.handed();
    // rust: assert!(gpu.is_empty(), "{key} stayed on the CPU");
    // rust: let expanded = expand(&store, &frame);
    // rust: assert_eq!(expanded.len(), cpu.len(), "{key}: vertex count");
    // rust: assert!(!cpu.is_empty(), "{key} drew nothing");
    // rust: for (i, (a, b)) in expanded.iter().zip(&cpu).enumerate() {
    // rust: assert_eq!(
    // rust: bytemuck::bytes_of(a),
    // rust: bytemuck::bytes_of(b),
    // rust: "{key} vertex {i}: {a:?} != {b:?}"
    // rust: );
}
    // rust: drawn += 1;
}
}
    // rust: assert_eq!(drawn, 10);
}
}
