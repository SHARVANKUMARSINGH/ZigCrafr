//! Transpiled from Horizon Rust crate
package horizon_client_render_lod

import "core:fmt"
import "core:mem"
import "core:math"

// Far meshes share the terrain arenas and passes, with their actual bounds
// rather than the 16³ boxes used by the near-section residency walk.
// use super::{Frustum, Renderer, SectionGpu};
// use crate::{
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: lod::{MAX_LEVEL, TileKey},
    // rust: mesher::SectionMesh,
}
// use glam::{DVec3, Vec3};
// use std::{
    // rust: collections::VecDeque,
    // rust: time::{Duration, Instant},
}

// Finished tile meshes not uploaded yet, the tiles they replace (removed
// once every mesh is in) and the columns they leave out.
    // rust: pub(super) struct Pending {
    // rust: meshes: FxHashMap<TileKey, SectionMesh>,
    // The order they go up in: as handed over (`Lod::update`: finer tiles
    // first, so no tile clipped around a finer one is drawn before it).
    // rust: order: VecDeque<TileKey>,
    // rust: removed: FxHashSet<TileKey>,
    // rust: cutout: Option<FxHashSet<(i32, i32)>>,
}

    // rust: impl Pending {
    // Takes in the next job, with the same result as applying both in
    // turn: newer meshes replace waiting ones, tiles meshed again are not
    // removed, and tiles removed now drop their waiting meshes.
    // rust: fn add(
    // rust: &mut self,
    // rust: meshes: Vec<(TileKey, SectionMesh)>,
    // rust: removed: Vec<TileKey>,
    // rust: cutout: Option<FxHashSet<(i32, i32)>>,
    // rust: ) {
    // rust: for (key, mesh) in meshes {
    // rust: self.removed.remove(&key);
    // rust: if self.meshes.insert(key, mesh).is_none() {
    // rust: self.order.push_back(key);
}
}
    // rust: for key in removed {
    // rust: self.meshes.remove(&key);
    // rust: self.removed.insert(key);
}
    // rust: if cutout.is_some() {
    // rust: self.cutout = cutout;
}
}
}

    // rust: pub(super) struct Tile {
    // rust: pub mesh: SectionGpu,
    // rust: bounds: Bounds,
    // When it began to fade in; none while the rest of its job uploads.
    // rust: shown: Option<Instant>,
    // When its replacements began to fade in; it goes once they have.
    // rust: dying: Option<Instant>,
    // Dying with nothing to replace it (out of range): it fades out.
    // rust: alone: bool,
    // Its mesh before near chunks took some of its columns, drawn in its
    // place until they have faded in (from the job's end, the instant), so
    // no hole shows through them.
    // rust: previous: Option<(SectionGpu, Option<Instant>)>,
    // Its slot in occlusion culling's results (`cull::TILE`), kept while
    // meshes of the same tile replace one another.
    // rust: pub cull_slot: u32,
}

// How long a tile takes to fade in over the ones it replaces.
    // rust: pub(super) const FADE: Duration = Duration::from_millis(600);

// A tile or section fading in: 0 drawn whole, else 1 + `level` * 129 +
// `shown`, `shown` 1 to 63 sixty-fourths of `FADE` (`fade_out_code`: 65 to
// 128, fading out). Chunk by chunk (columns of its own grid, wider for
// coarse tiles: 2^`level` blocks), each starting in turn over the first half
// and fading over the second, as a fine ordered pattern fixed to the terrain
// (terrain.wgsl's `faded`). It is drawn a hair toward the camera, the newest
// most, over the solid tiles it replaces, which stay until it is whole
// (`upload_lods`): no pixel fought over, no hole. None: nothing to draw yet.
    // rust: pub(super) fn fade_code(shown: Option<Instant>, level: u8, now: Instant) -> Option<u32> {
    // rust: let faded = now.saturating_duration_since(shown?).as_secs_f32() / FADE.as_secs_f32();
    // rust: let shown = (faded * 64.0) as u32 + 1;
    // rust: Some(if shown >= 64 {
    // rust: 0
    // rust: } else {
    // rust: 1 + u32::from(level) * 129 + shown
    // rust: })
}
// A section past the render distance that far terrain is coming in under:
// whole, a fading-out code at its start (terrain.wgsl's `fade_depth` draws
// leaving sections in front of far terrain).
    // rust: pub(super) const HELD: u32 = 1 + 64;
// `fade_code` for one leaving since `since`, chunk by chunk as it came, over
// what stays behind it; once `FADE` has passed it draws nothing.
    // rust: pub(super) fn fade_out_code(since: Instant, level: u8, now: Instant) -> u32 {
    // rust: let faded = now.saturating_duration_since(since).as_secs_f32() / FADE.as_secs_f32();
    // rust: 1 + u32::from(level) * 129 + 64 + ((faded * 64.0) as u32 + 1).min(64)
}

Bounds :: struct {
    min: Vec3,
    max: Vec3,
}

    // rust: impl Bounds {
mesh :: proc(mesh: ^SectionMesh) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let [min, max] = mesh.bounds?;
    // rust: Some(Self { min, max })
}

    // In view: the plan alone decides which tiles are in range (a circle),
    // so a tile leaving it fades out (`upload_lods`). Cut here at the range,
    // tiles popped out as the player moved, before the plan dropped them.
visible :: proc(self: ^Self, origin: DVec3, frustum: ^Frustum) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let min = origin + self.min.as_dvec3();
    // rust: let max = origin + self.max.as_dvec3();
    // rust: if !frustum.intersects(min.as_vec3(), max.as_vec3()) {
    // rust: return None;
}
    // rust: Some(((min + max) * 0.5).length_squared().to_bits())
}
}

// A tile's instance: like a section's, with the UV step of merged faces.
// A fading tile's step is negated past its `fade_code`, which the shaders
// read back as the whole part (they take the step as `fract(abs(w))`).
    // rust: pub(super) fn instance(origin: [f32; 3], fade: u32) -> [f32; 4] {
    // rust: let step = 1.0 / crate::mesher::TILED_UV_STEPS;
    // rust: [
    // rust: origin[0],
    // rust: origin[1],
    // rust: origin[2],
    // rust: if fade == 0 {
    // rust: step
    // rust: } else {
    // rust: -(fade as f32 + step)
    // rust: },
    // rust: ]
}

    // rust: pub(super) struct Visible {
    // rust: pub key: TileKey,
    // rust: pub distance: u64,
    // rust: pub origin: [f32; 3],
    // rust: pub fade: u32,
    // Replaced, standing until its replacements are whole: its water goes
    // after theirs (`Renderer::render`'s water tiers), so depth leaves it only
    // where they have none yet.
    // rust: pub old: bool,
}

    // rust: impl Tile {
    // The mesh drawn this frame: the previous one while it stands in.
drawn :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.previous.as_ref().map_or(&self.mesh, |(mesh, _)| mesh)
}
drawn_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match &mut self.previous {
    // rust: Some((mesh, _)) => mesh,
    // rust: None => &mut self.mesh,
}
}
    // The box occlusion culling tests (`cull::Cull`), around its origin: its
    // mesh's bounds grown by a block, while that mesh is the one drawn
    // whole (no stand-in, no fade). A fading tile's dither moves its depth
    // toward the camera (terrain.wgsl's `fade_depth`), out of the box.
cull_bounds :: proc(self: ^Self, fade: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (fade == 0 && self.previous.is_none()).then(|| {
    // rust: [
    // rust: (self.bounds.min - 1.0).to_array(),
    // rust: (self.bounds.max + 1.0).to_array(),
    // rust: ]
    // rust: })
}
    // Both meshes it holds in the arena: its own and the stand-in, if any.
meshes_mut :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: std::iter::once(&mut self.mesh).chain(self.previous.as_mut().map(|(mesh, _)| mesh))
}
    // rust: pub fn visible(
    // rust: &self,
    // rust: key: TileKey,
    // rust: camera: DVec3,
    // rust: frustum: &Frustum,
    // rust: now: Instant,
    // rust: ) -> Option<Visible> {
    // rust: let fade = match self.dying {
    // rust: Some(since) if self.alone => fade_out_code(since, key.level, now),
    // rust: _ => fade_code(self.shown, key.level, now)?,
}
    // rust: let origin = DVec3::from(key.origin().map(f64::from)) - camera;
    // rust: Some(Visible {
    // rust: key,
    // rust: distance: self.bounds.visible(origin, frustum)?,
    // rust: origin: origin.as_vec3().to_array(),
    // rust: fade,
    // rust: old: self.dying.is_some() || self.previous.is_some(),
    // rust: })
}
}

    // rust: impl Renderer {
    // A tile meshed again (finer detail) takes its place at once, but for
    // one meshed around near chunks or finer tiles that are new (`keep`):
    // its old mesh stands in while they fade in. A new one waits for the rest of its job
    // (`upload_lods`), then fades in.
upload_lod :: proc(self: ^Self, key: TileKey, mesh: ^SectionMesh, keep: bool) {
}
    // rust: if let Some(copies) = &mut self.capture_copies {
    // rust: copies.tile(key, mesh);
}
    // rust: let old_slot = self.lods.get(&key).map(|tile| tile.cull_slot);
    // rust: let (shown, previous) = match self.lods.remove(&key) {
    // rust: Some(old) if old.dying.is_none() => match old.previous {
    // rust: Some(previous) => {
    // rust: self.release_mesh(old.mesh);
    // rust: (old.shown, Some(previous))
}
    // rust: None if keep => (old.shown, Some((old.mesh, None))),
    // rust: None => {
    // rust: self.release_mesh(old.mesh);
    // rust: (old.shown, None)
}
    // rust: },
    // rust: Some(old) => {
    // rust: self.release_tile(old);
    // rust: (None, None)
}
    // rust: None => (None, None),
}
    // rust: match Bounds::mesh(mesh).zip(self.upload_mesh(mesh)) {
    // rust: Some((bounds, mesh)) => {
    // rust: let cull_slot = old_slot.unwrap_or_else(|| {
    // rust: self.lod_cull_free.pop().unwrap_or_else(|| {
    // rust: self.lod_cull_next += 1;
    // rust: self.lod_cull_next - 1
    // rust: })
    // rust: });
    // rust: self.lods.insert(
    // rust: key,
    // rust: Tile {
    // rust: mesh,
    // rust: bounds,
    // rust: shown,
    // rust: dying: None,
    // rust: alone: false,
    // rust: previous,
    // rust: cull_slot,
    // rust: },
    // rust: );
}
    // rust: None => {
    // rust: if let Some((previous, _)) = previous {
    // rust: self.release_mesh(previous);
}
    // rust: self.lod_cull_free.extend(old_slot);
}
}
}

release_tile :: proc(self: ^Self, tile: Tile) {
}
    // rust: self.release_mesh(tile.mesh);
    // rust: if let Some((previous, _)) = tile.previous {
    // rust: self.release_mesh(previous);
}
}

remove_lod :: proc(self: ^Self, key: TileKey) {
}
    // rust: if let Some(copies) = &mut self.capture_copies {
    // rust: copies.forget_tile(key);
}
    // rust: if let Some(tile) = self.lods.remove(&key) {
    // rust: self.lod_cull_free.push(tile.cull_slot);
    // rust: self.release_tile(tile);
}
}

clear_lods :: proc(self: ^Self) {
}
    // rust: if let Some(copies) = &mut self.capture_copies {
    // rust: copies.clear_tiles();
}
    // rust: self.lod_pending = None;
        // No far terrain left to fade out over.
    // rust: for (key, since) in std::mem::take(&mut self.lod_leaving) {
    // rust: if self
    // rust: .sections
    // rust: .find(key)
    // rust: .is_some_and(|s| s.leaving == Some(since))
    // rust: {
    // rust: self.release_section(key);
}
}
    // rust: for (_, tile) in std::mem::take(&mut self.lods) {
    // rust: self.release_tile(tile);
}
    // rust: self.lod_cull_free.clear();
    // rust: self.lod_cull_next = 0;
    // rust: self.set_lod_cutout(Default::default());
}

    // Queues a finished mesh job (`Lod::update`, `Lod::removed`,
    // `Lod::take_cutout`) for `upload_lods`, joining one still uploading
    // (`Pending::add`).
    // rust: pub fn queue_lods(
    // rust: &mut self,
    // rust: meshes: Vec<(TileKey, SectionMesh)>,
    // rust: removed: Vec<TileKey>,
    // rust: cutout: Option<FxHashSet<(i32, i32)>>,
    // rust: ) {
    // rust: if meshes.is_empty() && removed.is_empty() && cutout.is_none() {
    // rust: return;
}
    // rust: self.lod_pending
    // rust: .get_or_insert_default()
    // rust: .add(meshes, removed, cutout);
}

    // Uploads queued tile meshes for about `budget` (at least one), then,
    // once all are in, fades them in over the tiles they replace.
upload_lods :: proc(self: ^Self, budget: Duration) {
}
    // rust: let start = Instant::now();
    // rust: if self.lod_pending.is_some() {
            // Far tiles fill the arenas too: large translucent pages wait for them.
    // rust: self.shrink_gate.wait(start, super::SHRINK_SETTLE);
}
    // rust: self.release_left(start);
    // rust: let faded: Vec<_> = self
    // rust: .lods
    // rust: .iter()
    // rust: .filter(|(_, tile)| tile.dying.is_some_and(|d| start - d >= FADE))
    // rust: .map(|(&key, _)| key)
    // rust: .collect();
    // rust: for key in faded {
    // rust: self.remove_lod(key);
}
    // rust: let stood_in: Vec<_> = self
    // rust: .lods
    // rust: .values_mut()
    // rust: .filter_map(|tile| match tile.previous {
    // rust: Some((_, Some(since))) if start - since >= FADE => tile.previous.take(),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: for (previous, _) in stood_in {
    // rust: self.release_mesh(previous);
}
        // The columns near chunks take in this job, and the tiles holding the
        // job's new finer ones: a tile meshed again around them keeps its
        // old mesh until they are in, so no hole shows through them.
    // rust: let mut around_new = FxHashSet::default();
    // rust: let new = self
    // rust: .lod_pending
    // rust: .iter()
    // rust: .flat_map(|pending| pending.meshes.keys())
    // rust: .filter(|key| !self.lods.contains_key(key))
    // rust: .chain(
    // rust: self.lods
    // rust: .iter()
    // rust: .filter(|(_, tile)| tile.shown.is_none())
    // rust: .map(|(key, _)| key),
    // rust: );
    // rust: for &key in new {
    // rust: let mut key = key;
    // rust: while key.level < MAX_LEVEL && around_new.insert(key.parent()) {
    // rust: key = key.parent();
}
}
    // rust: let taken: Vec<_> = self
    // rust: .lod_pending
    // rust: .iter()
    // rust: .flat_map(|pending| pending.cutout.iter().flatten())
    // rust: .filter(|column| !self.lod_cutout.contains(column))
    // rust: .copied()
    // rust: .collect();
    // rust: while let Some(pending) = &mut self.lod_pending {
            // Keys meshed again keep their place; removed ones are skipped.
    // rust: let next = std::iter::from_fn(|| pending.order.pop_front())
    // rust: .find(|key| pending.meshes.contains_key(key));
    // rust: let Some(key) = next else {
    // rust: let pending = self.lod_pending.take().expect("pending tiles");
                // A tile fades in over the ones it replaces. One over nothing
                // shows whole: its hidden chunks would open holes to the sky
                // or the sea bed (dark patches, as far terrain first loads).
    // rust: let replaced: FxHashSet<TileKey> = pending
    // rust: .removed
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|key| self.lods.contains_key(key))
    // rust: .collect();
    // rust: let mut above_replaced = FxHashSet::default();
    // rust: for &key in &replaced {
    // rust: let mut key = key;
    // rust: while key.level < MAX_LEVEL && above_replaced.insert(key.parent()) {
    // rust: key = key.parent();
}
}
    // rust: let over_replaced = |key: TileKey| {
    // rust: let mut ancestor = key;
    // rust: replaced.contains(&key)
    // rust: || above_replaced.contains(&key)
    // rust: || (key.level..MAX_LEVEL).any(|_| {
    // rust: ancestor = ancestor.parent();
    // rust: replaced.contains(&ancestor)
    // rust: })
}
                // A removed tile no new tile overlaps, and no near chunk takes
                // a column of, leaves the plan (out of range): it fades out.
                // Over near chunks fading in it stays whole: two patterns
                // fading at once left holes between them.
                // Two tiles overlap when one is the other or its ancestor:
                // `kept` holds the new tiles and the near chunks' columns
                // (level 0), `above` their ancestors.
    // rust: let mut kept: FxHashSet<TileKey> = self
    // rust: .lods
    // rust: .iter()
    // rust: .filter(|(_, tile)| tile.shown.is_none())
    // rust: .map(|(&key, _)| key)
    // rust: .collect();
    // rust: let cut = pending.cutout.as_ref().unwrap_or(&self.lod_cutout);
    // rust: kept.extend(cut.iter().map(|&(x, z)| TileKey { x, z, level: 0 }));
    // rust: let mut above = FxHashSet::default();
    // rust: for &key in &kept {
    // rust: let mut key = key;
    // rust: while key.level < MAX_LEVEL && above.insert(key.parent()) {
    // rust: key = key.parent();
}
}
    // rust: let alone = |key: TileKey| {
    // rust: let mut ancestor = key;
    // rust: !kept.contains(&key)
    // rust: && !above.contains(&key)
    // rust: && !(key.level..MAX_LEVEL).any(|_| {
    // rust: ancestor = ancestor.parent();
    // rust: kept.contains(&ancestor)
    // rust: })
}
    // rust: let whole = start.checked_sub(FADE).unwrap_or(start);
    // rust: for (&key, tile) in &mut self.lods {
    // rust: if tile.shown.is_none() {
    // rust: tile.shown = Some(if over_replaced(key) { start } else { whole });
}
    // rust: if let Some((_, since)) = &mut tile.previous {
    // rust: since.get_or_insert(start);
}
}
    // rust: for key in pending.removed {
    // rust: let alone = alone(key);
    // rust: if let Some(tile) = self.lods.get_mut(&key)
    // rust: && tile.dying.is_none()
    // rust: {
    // rust: tile.dying = Some(start);
    // rust: tile.alone = alone;
}
}
    // rust: if let Some(cutout) = pending.cutout {
    // rust: self.set_lod_cutout(cutout);
}
    // rust: return;
}
    // rust: let mesh = pending.meshes.remove(&key).expect("pending tile");
    // rust: let [x, _, z] = key.origin();
    // rust: let size = key.size();
    // rust: let keep = mesh.keep
    // rust: || around_new.contains(&key)
    // rust: || taken.iter().any(|&(cx, cz)| {
    // rust: (x..x + size).contains(&(cx * 16)) && (z..z + size).contains(&(cz * 16))
    // rust: });
    // rust: self.upload_lod(key, &mesh, keep);
    // rust: if start.elapsed() >= budget {
    // rust: return;
}
}
}

    // The tiles drawn for good, not fading out (`render-capture`).
    // rust: pub(super) fn standing_lods(&self) -> FxHashSet<TileKey> {
    // rust: self.lods
    // rust: .iter()
    // rust: .filter(|(_, tile)| tile.dying.is_none())
    // rust: .map(|(&key, _)| key)
    // rust: .collect()
}

    // The chunk columns the resident tiles now leave out (`Lod::take_cutout`).
    // Removed sections they no longer leave out are released.
set_lod_cutout :: proc(self: ^Self, cutout: crate::fast_hash::FxHashSet<(i32) {
}
    // rust: self.lod_cutout = cutout;
    // rust: let released: Vec<_> = self
    // rust: .lod_retiring
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|key| !self.lod_cutout.contains(&(key.0, key.2)))
    // rust: .collect();
    // rust: for key in released {
    // rust: self.lod_retiring.remove(&key);
    // rust: self.leave_section(key);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mesher::TerrainVertex;

tiles_fade_in_on_their_own_grid :: proc() {
}
    // rust: let start = Instant::now();
    // rust: let at = |ms| start + Duration::from_millis(ms);
        // terrain.wgsl's `faded` reads the level and sixty-fourths back.
    // rust: let decode = |code: u32| ((code - 1) / 129, (code - 1) % 129);
    // rust: assert_eq!(fade_code(None, 0, at(0)), None, "waits for its job");
    // rust: assert_eq!(fade_code(Some(start), 3, at(0)).map(decode), Some((3, 1)));
    // rust: let mut last = 0;
    // rust: for ms in [0, 100, 300, 500, 590] {
    // rust: let (level, shown) = decode(fade_code(Some(start), 10, at(ms)).unwrap());
    // rust: assert_eq!(level, 10);
    // rust: assert!(shown > last && shown < 64, "{shown} at {ms} ms");
    // rust: last = shown;
}
    // rust: assert_eq!(fade_code(Some(start), 10, at(600)), Some(0), "whole");
        // Fading out: 65 to 128, then nothing drawn (128) until released.
    // rust: let mut last = 64;
    // rust: for ms in [0, 100, 300, 500, 590] {
    // rust: let (level, out) = decode(fade_out_code(start, 3, at(ms)));
    // rust: assert_eq!(level, 3);
    // rust: assert!(out > last && out < 128, "{out} at {ms} ms");
    // rust: last = out;
}
    // rust: assert_eq!(decode(fade_out_code(start, 3, at(700))), (3, 128));
        // A section's largest code keeps its UV step exact (terrain_uv).
    // rust: let w = 129.0f32 + 1.0 / 32768.0;
    // rust: assert_eq!(w.fract(), 1.0 / 32768.0);
}

joined_jobs_apply_as_if_in_turn :: proc() {
}
    // rust: let key = |x| TileKey { x, z: 0, level: 0 };
    // rust: let mut pending = Pending::default();
        // The first job meshes 1 and 2 and retires 3 and 4.
    // rust: pending.add(
    // rust: vec![
    // rust: (key(1), SectionMesh::default()),
    // rust: (key(2), SectionMesh::default()),
    // rust: ],
    // rust: vec![key(3), key(4)],
    // rust: Some([(0, 0)].into_iter().collect()),
    // rust: );
        // The second meshes 3 again and retires 2.
    // rust: pending.add(vec![(key(3), SectionMesh::default())], vec![key(2)], None);
    // rust: let mut meshes: Vec<_> = pending.meshes.keys().map(|k| k.x).collect();
    // rust: meshes.sort_unstable();
    // rust: let mut removed: Vec<_> = pending.removed.iter().map(|k| k.x).collect();
    // rust: removed.sort_unstable();
    // rust: assert_eq!((meshes, removed), (vec![1, 3], vec![2, 4]));
    // rust: assert!(pending.cutout.as_ref().is_some_and(|c| c.contains(&(0, 0))));
        // They go up in the order handed over, each once.
    // rust: pending.add(vec![(key(1), SectionMesh::default())], vec![], None);
    // rust: let order: Vec<_> = pending
    // rust: .order
    // rust: .iter()
    // rust: .filter(|k| pending.meshes.contains_key(k))
    // rust: .map(|k| k.x)
    // rust: .collect();
    // rust: assert_eq!(order, [1, 3]);
}

large_tile_bounds_include_water_and_do_not_cull_by_origin :: proc() {
}
    // rust: let vertex = |pos| TerrainVertex::tiled(pos, [0.0; 2], 0, 0, 0);
    // rust: let mesh = SectionMesh {
    // rust: solid: vec![vertex([0.0, -64.0, 0.0]), vertex([1024.0, 100.0, 1024.0])],
    // rust: translucent: vec![vertex([512.0, 120.0, 512.0])],
    // rust: bounds: Some([Vec3::new(0.0, -64.0, 0.0), Vec3::new(1024.0, 120.0, 1024.0)]),
    // rust: ..Default::default()
}
    // rust: let bounds = Bounds::mesh(&mesh).unwrap();
    // rust: assert_eq!(bounds.min, Vec3::new(0.0, -64.0, 0.0));
    // rust: assert_eq!(bounds.max, Vec3::new(1024.0, 120.0, 1024.0));
    // rust: let view = Frustum {
    // rust: planes: super::super::frustum(
    // rust: super::super::world_projection(70.0, 16.0 / 9.0, 8192.0)
    // rust: * crate::camera::view_matrix(0.0, 0.0),
    // rust: ),
}
        // The tile origin is far behind, but its far edge reaches the camera.
        // Negative world origins therefore remain visible.
    // rust: assert!(
    // rust: bounds
    // rust: .visible(DVec3::new(-1000.0, -80.0, -512.0), &view)
    // rust: .is_some()
    // rust: );
        // Wholly behind the camera: out of view.
    // rust: assert!(
    // rust: bounds
    // rust: .visible(DVec3::new(-512.0, -80.0, -2000.0), &view)
    // rust: .is_none()
    // rust: );
    // rust: assert!(Bounds::mesh(&SectionMesh::default()).is_none());
}
}
