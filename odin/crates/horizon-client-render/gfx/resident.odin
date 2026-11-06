//! Transpiled from Horizon Rust crate
package horizon_client_render_resident

import "core:fmt"
import "core:mem"
import "core:math"

// Resident sections, stored densely and grouped by chunk column for the
// per-frame culling walk: a column whose box misses the frustum or lies past
// the render distance rejects all of its sections with one test, and the
// sections that remain are reached by index rather than by hashing keys.
// use super::Frustum;
// use super::{Cull, SectionKey};
// use crate::{
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: streaming::in_view_distance,
}
// use glam::{DVec3, Vec3};

// One chunk column's resident sections.
Column :: struct {
    x: i32,
    z: i32,
    // Section y (from the world's bottom) and slot, in no particular order.
    sections: Vec<(i32,
    // Those of `sections` that are marked (`Resident::insert_marked`), in no
    // particular order.
    marked: Vec<(i32,
    // The lowest and highest section y of `sections`.
    low: i32,
    high: i32,
}

    // rust: impl Column {
bounds :: proc(self: ^Self) {
}
    // rust: self.low = self.sections.iter().map(|s| s.0).min().unwrap_or(0);
    // rust: self.high = self.sections.iter().map(|s| s.0).max().unwrap_or(0);
}
}

// Values of type `T` per section key, in a dense list with stable keys and
// slots that move only when a section is removed.
Resident :: struct {
    // The minimum Y of section index 0 (the level's column).
    min_y: i32,
    items: Vec<(SectionKey,
    bounds: Vec<Option<[Vec3,
    // Per slot, whether the section is marked: within the render distance,
    // `walk` lists only those when `marked_only_near`.
    marked: [dynamic]bool,
    slots: FxHashMap<SectionKey,
    columns: [dynamic]Column,
    column_index: FxHashMap<(i32,
}

    // rust: impl<T> Default for Resident<T> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: min_y: crate::chunk::MIN_Y,
    // rust: items: Vec::new(),
    // rust: bounds: Vec::new(),
    // rust: marked: Vec::new(),
    // rust: slots: FxHashMap::default(),
    // rust: columns: Vec::new(),
    // rust: column_index: FxHashMap::default(),
}
}
}

    // rust: impl<T> Resident<T> {
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.items.len()
}
    // Heap bytes of its own lists and maps, not counting what a `T` points
    // to (`horizon-ctl memory`). A hash map entry costs its pair and a
    // control byte.
heap_bytes :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
//         use std::mem::size_of;
    // rust: self.items.capacity() * size_of::<(SectionKey, T)>()
    // rust: + self.bounds.capacity() * size_of::<Option<[Vec3; 2]>>()
    // rust: + self.marked.capacity() * size_of::<bool>()
    // rust: + self.slots.capacity() * (size_of::<(SectionKey, u32)>() + 1)
    // rust: + self.columns.capacity() * size_of::<Column>()
    // rust: + self
    // rust: .columns
    // rust: .iter()
    // rust: .map(|c| (c.sections.capacity() + c.marked.capacity()) * size_of::<(i32, u32)>())
    // rust: .sum::<usize>()
    // rust: + self.column_index.capacity() * (size_of::<((i32, i32), u32)>() + 1)
}
contains :: proc(self: ^Self, key: SectionKey) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.slots.contains_key(&key)
}
values :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.items.iter().map(|(_, v)| v)
}
values_mut :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.items.iter_mut().map(|(_, v)| v)
}
    // Every section's key, value and bounds.
iter :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let items = self.items.iter().zip(&self.bounds);
    // rust: items.map(|((key, value), bounds)| (*key, value, *bounds))
}
    // Every section's key, value and bounds.
iter_mut :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let items = self.items.iter_mut().zip(&self.bounds);
    // rust: items.map(|((key, value), bounds)| (*key, value, *bounds))
}
    // Whether the section at `key` is marked (`insert_marked`).
is_marked :: proc(self: ^Self, key: SectionKey) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.slots
    // rust: .get(&key)
    // rust: .is_some_and(|&slot| self.marked[slot as usize])
}
    // `key`'s value, when it is resident.
find :: proc(self: ^Self, key: SectionKey) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.slots.get(&key).map(|&slot| self.get(slot))
}
find_mut :: proc(self: ^Self, key: SectionKey) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let slot = *self.slots.get(&key)?;
    // rust: Some(self.get_mut(slot))
}
    // The section in `slot` (`Visible::slot`).
get :: proc(self: ^Self, slot: u32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.items[slot as usize].1
}
get_mut :: proc(self: ^Self, slot: u32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.items[slot as usize].1
}
    // Sections from now on count from `min_y` (a level of another column).
set_min_y :: proc(self: ^Self, min_y: i32) {
}
    // rust: self.min_y = min_y;
}
    // The minimum Y of section index 0.
min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.min_y
}
clear :: proc(self: ^Self) {
}
    // rust: self.items.clear();
    // rust: self.bounds.clear();
    // rust: self.marked.clear();
    // rust: self.slots.clear();
    // rust: self.columns.clear();
    // rust: self.column_index.clear();
}
    // Adds or replaces `key`'s value with default 16x16x16 bounds.
insert :: proc(self: ^Self, key: SectionKey, value: T) {
}
    // rust: self.insert_with_bounds(key, value, None);
}
    // Adds or replaces `key`'s value with optional tight geometry bounds, unmarked.
insert_with_bounds :: proc(self: ^Self, key: SectionKey, value: T, bounds: Maybe([Vec3; 2])) {
}
    // rust: self.insert_marked(key, value, bounds, false);
}
    // Adds or replaces `key`'s value with optional tight geometry bounds, and
    // whether it is marked: `walk` with `marked_only_near` lists the sections
    // within the render distance that are.
    // rust: pub fn insert_marked(
    // rust: &mut self,
    // rust: key: SectionKey,
    // rust: value: T,
    // rust: bounds: Option<[Vec3; 2]>,
    // rust: marked: bool,
    // rust: ) {
    // rust: if let Some(&slot) = self.slots.get(&key) {
    // rust: self.items[slot as usize].1 = value;
    // rust: self.bounds[slot as usize] = bounds;
    // rust: self.mark_slot(slot, marked);
    // rust: return;
}
    // rust: let slot = self.items.len() as u32;
    // rust: self.items.push((key, value));
    // rust: self.bounds.push(bounds);
    // rust: self.marked.push(marked);
    // rust: self.slots.insert(key, slot);
    // rust: let column = match self.column_index.get(&(key.0, key.2)) {
    // rust: Some(&c) => &mut self.columns[c as usize],
    // rust: None => {
    // rust: self.column_index
    // rust: .insert((key.0, key.2), self.columns.len() as u32);
    // rust: self.columns.push(Column {
    // rust: x: key.0,
    // rust: z: key.2,
    // rust: sections: Vec::new(),
    // rust: marked: Vec::new(),
    // rust: low: key.1,
    // rust: high: key.1,
    // rust: });
    // rust: self.columns.last_mut().expect("just pushed")
}
}
    // rust: column.sections.push((key.1, slot));
    // rust: if marked {
    // rust: column.marked.push((key.1, slot));
}
    // rust: column.low = column.low.min(key.1);
    // rust: column.high = column.high.max(key.1);
}
    // Marks or unmarks the section at `key`, if it is resident.
set_marked :: proc(self: ^Self, key: SectionKey, marked: bool) {
}
    // rust: if let Some(&slot) = self.slots.get(&key) {
    // rust: self.mark_slot(slot, marked);
}
}
    // Marks or unmarks the section in `slot`, in its column's list too.
mark_slot :: proc(self: ^Self, slot: u32, marked: bool) {
}
    // rust: let was = std::mem::replace(&mut self.marked[slot as usize], marked);
    // rust: if was == marked {
    // rust: return;
}
    // rust: let (x, y, z) = self.items[slot as usize].0;
    // rust: let column = &mut self.columns[self.column_index[&(x, z)] as usize];
    // rust: if marked {
    // rust: column.marked.push((y, slot));
    // rust: } else {
    // rust: let at = column
    // rust: .marked
    // rust: .iter()
    // rust: .position(|s| s.1 == slot)
    // rust: .expect("marked section in its column's list");
    // rust: column.marked.swap_remove(at);
}
}
    // Removes every section of the `gone` columns, the others keeping their order and
    // marks: one pass over the store, where `remove` moves a slot and looks its column
    // up for each.
remove_columns :: proc(self: ^Self, gone: ^FxHashSet<(i32) {
}
        // Every column (a far teleport): emptied, without a lookup per section.
    // rust: if self.columns.iter().all(|c| gone.contains(&(c.x, c.z))) {
    // rust: self.bounds.clear();
    // rust: self.marked.clear();
    // rust: self.slots.clear();
    // rust: self.columns.clear();
    // rust: self.column_index.clear();
    // rust: return std::mem::take(&mut self.items)
    // rust: .into_iter()
    // rust: .map(|(_, value)| value)
    // rust: .collect();
}
    // rust: let items = std::mem::take(&mut self.items);
    // rust: let bounds = std::mem::take(&mut self.bounds);
    // rust: let marked = std::mem::take(&mut self.marked);
    // rust: self.slots.clear();
    // rust: self.columns.clear();
    // rust: self.column_index.clear();
    // rust: let mut removed = Vec::new();
    // rust: for (((key, value), bounds), marked) in items.into_iter().zip(bounds).zip(marked) {
    // rust: if gone.contains(&(key.0, key.2)) {
    // rust: removed.push(value);
    // rust: } else {
    // rust: self.insert_marked(key, value, bounds, marked);
}
}
    // rust: removed
}
remove :: proc(self: ^Self, key: SectionKey) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let slot = self.slots.remove(&key)?;
    // rust: self.mark_slot(slot, false);
    // rust: let c = self.column_index[&(key.0, key.2)] as usize;
    // rust: let column = &mut self.columns[c];
    // rust: let at = column
    // rust: .sections
    // rust: .iter()
    // rust: .position(|s| s.1 == slot)
    // rust: .expect("section in its column");
    // rust: column.sections.swap_remove(at);
    // rust: if column.sections.is_empty() {
    // rust: self.column_index.remove(&(key.0, key.2));
    // rust: self.columns.swap_remove(c);
    // rust: if let Some(moved) = self.columns.get(c) {
    // rust: self.column_index.insert((moved.x, moved.z), c as u32);
}
    // rust: } else {
    // rust: column.bounds();
}
    // rust: let _ = self.bounds.swap_remove(slot as usize);
    // rust: let _ = self.marked.swap_remove(slot as usize);
    // rust: let (_, value) = self.items.swap_remove(slot as usize);
        // The last item now sits in `slot`: point its key and column, and its
        // column's marked list if it is marked, at it.
    // rust: if let Some(&(moved, _)) = self.items.get(slot as usize) {
    // rust: let last = self.items.len() as u32;
    // rust: self.slots.insert(moved, slot);
    // rust: let column = &mut self.columns[self.column_index[&(moved.0, moved.2)] as usize];
    // rust: let entry = column
    // rust: .sections
    // rust: .iter_mut()
    // rust: .find(|s| s.1 == last)
    // rust: .expect("moved section in its column");
    // rust: entry.1 = slot;
    // rust: if self.marked[slot as usize] {
    // rust: let entry = column
    // rust: .marked
    // rust: .iter_mut()
    // rust: .find(|s| s.1 == last)
    // rust: .expect("moved marked section in its column's list");
    // rust: entry.1 = slot;
}
}
    // rust: Some(value)
}
}

// A section in view.
Visible :: struct {
    // Its centre's squared distance from the camera, as bits: non-negative
    // floats order like their bits, so sorting compares integers.
    distance: u64,
    key: SectionKey,
    slot: u32,
    // Its camera-relative origin.
    origin: [f32,
}

// The camera-relative origin of the section at `key`.
    // rust: pub(super) fn origin(key: SectionKey, min_y: i32, camera: DVec3) -> DVec3 {
    // rust: DVec3::new(
    // rust: f64::from(key.0 * 16),
    // rust: f64::from(min_y + key.1 * 16),
    // rust: f64::from(key.2 * 16),
    // rust: ) - camera
}

// The camera's chunk column.
    // rust: pub(super) fn camera_column(camera: DVec3) -> (i32, i32) {
    // rust: (
    // rust: (camera.x.floor() as i32) >> 4,
    // rust: (camera.z.floor() as i32) >> 4,
    // rust: )
}

// The world AABB (min, max) of a section from its origin and optional tight bounds.
section_box :: proc(min: Vec3, bounds: Maybe([Vec3; 2])) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match bounds {
    // rust: Some([bmin, bmax]) => (min + bmin, min + bmax),
    // rust: None => (min, min + Vec3::splat(16.0)),
}
}

// Whether the section at `key` is drawn: its column within the render
// distance of the camera's (`SectionOcclusionGraph.isInViewDistance`), and
// partly inside the frustum. `None` when it is not, else its squared centre
// distance and origin. `Resident::visible` walks columns instead.
in_view :: proc(key: SectionKey, camera: DVec3, radius: i32, frustum: ^Frustum) -> O {
    // Ported from Horizon
    return {}
}
    // rust: in_view_with_bounds(key, camera, radius, frustum, None)
}

// `in_view` with optional tight bounds.
    // rust: fn in_view_with_bounds(
    // rust: key: SectionKey,
    // rust: camera: DVec3,
    // rust: radius: i32,
    // rust: frustum: &Frustum,
    // rust: bounds: Option<[Vec3; 2]>,
    // rust: ) -> Option<(f64, Vec3)> {
    // rust: if !in_view_distance(camera_column(camera), radius, key.0, key.2) {
    // rust: return None;
}
    // rust: in_frustum(key, crate::chunk::MIN_Y, camera, frustum, false, bounds)
}

// `in_view` without the distance test; `inside`: the section's column is
// entirely inside the frustum, so the section is too.
    // rust: fn in_frustum(
    // rust: key: SectionKey,
    // rust: min_y: i32,
    // rust: camera: DVec3,
    // rust: frustum: &impl Cull,
    // rust: inside: bool,
    // rust: bounds: Option<[Vec3; 2]>,
    // rust: ) -> Option<(f64, Vec3)> {
    // rust: let origin = origin(key, min_y, camera);
    // rust: let min = origin.as_vec3();
    // rust: if !inside {
    // rust: let (bmin, bmax) = section_box(min, bounds);
    // rust: if !frustum.intersects(bmin, bmax) {
    // rust: return None;
}
}
    // rust: Some(((origin + DVec3::splat(8.0)).length_squared(), min))
}

    // rust: impl<T> Resident<T> {
    // Appends the sections `in_view` and `reachable` to `out`, nearest
    // first (ties by key, so the order never depends on storage), and the
    // sections in the frustum of columns past the render distance that
    // `beyond` keeps (distant terrain still leaves them out; the occlusion
    // graph never reaches them).
    //
    // Columns are tested first, with the same distance test (it depends
    // only on x and z) and a box spanning their sections: every section box
    // lies inside it and the frustum test rounds monotonically, so a column
    // the frustum rejects holds no section it would accept, and one
    // entirely inside holds none it would reject (its sections skip the
    // test). `radius` is the render distance in chunks.
    // rust: pub fn visible(
    // rust: &self,
    // rust: camera: DVec3,
    // rust: radius: i32,
    // rust: frustum: &impl Cull,
    // rust: reachable: impl Fn(SectionKey) -> bool,
    // rust: beyond: impl Fn(i32, i32) -> bool,
    // rust: out: &mut Vec<Visible>,
    // rust: ) {
    // rust: self.walk(camera, radius, frustum, reachable, beyond, false, out);
}
    // `visible`, less the sections within the render distance that are not
    // marked (`insert_marked`) when `marked_only_near`, in the same order: GPU
    // culling's frames, where the GPU draws those. A column's box spans all of
    // its sections either way, so both decide alike on those they share.
    // rust: pub fn walk(
    // rust: &self,
    // rust: camera: DVec3,
    // rust: radius: i32,
    // rust: frustum: &impl Cull,
    // rust: reachable: impl Fn(SectionKey) -> bool,
    // rust: beyond: impl Fn(i32, i32) -> bool,
    // rust: marked_only_near: bool,
    // rust: out: &mut Vec<Visible>,
    // rust: ) {
    // rust: let from = camera_column(camera);
    // rust: for column in &self.columns {
    // rust: let near = in_view_distance(from, radius, column.x, column.z);
    // rust: if !near && !beyond(column.x, column.z) {
    // rust: continue;
}
    // rust: let list = if marked_only_near && near {
    // rust: &column.marked
    // rust: } else {
    // rust: &column.sections
}
    // rust: if list.is_empty() {
    // rust: continue;
}
    // rust: let min = origin((column.x, column.low, column.z), self.min_y, camera).as_vec3();
    // rust: let top = origin((column.x, column.high, column.z), self.min_y, camera).as_vec3();
    // rust: let max = top + Vec3::splat(16.0);
    // rust: let inside = frustum.contains(min, max);
    // rust: if !inside && !frustum.intersects(min, max) {
    // rust: continue;
}
    // rust: let ox = f64::from(column.x * 16) - camera.x;
    // rust: let oz = f64::from(column.z * 16) - camera.z;
    // rust: let min_x = ox as f32;
    // rust: let min_z = oz as f32;
    // rust: let dx8 = ox + 8.0;
    // rust: let dz8 = oz + 8.0;
    // rust: let xz_sq = dx8 * dx8 + dz8 * dz8;

    // rust: if inside {
    // rust: for &(y, slot) in list {
    // rust: let key = (column.x, y, column.z);
    // rust: if near && !reachable(key) {
    // rust: continue;
}
    // rust: let oy = f64::from(self.min_y + y * 16) - camera.y;
    // rust: let min = Vec3::new(min_x, oy as f32, min_z);
    // rust: let dy8 = oy + 8.0;
    // rust: let distance = xz_sq + dy8 * dy8;
    // rust: out.push(Visible {
    // rust: distance: distance.to_bits(),
    // rust: key,
    // rust: slot,
    // rust: origin: min.to_array(),
    // rust: });
}
    // rust: } else {
    // rust: for &(y, slot) in list {
    // rust: let key = (column.x, y, column.z);
    // rust: if near && !reachable(key) {
    // rust: continue;
}
    // rust: let oy = f64::from(self.min_y + y * 16) - camera.y;
    // rust: let min = Vec3::new(min_x, oy as f32, min_z);
    // rust: let bounds = self.bounds[slot as usize].filter(|_| frustum.tight());
    // rust: let (bmin, bmax) = section_box(min, bounds);
    // rust: if !frustum.intersects(bmin, bmax) {
    // rust: continue;
}
    // rust: let dy8 = oy + 8.0;
    // rust: let distance = xz_sq + dy8 * dy8;
    // rust: out.push(Visible {
    // rust: distance: distance.to_bits(),
    // rust: key,
    // rust: slot,
    // rust: origin: min.to_array(),
    // rust: });
}
}
}
    // rust: out.sort_unstable_by_key(|v| (v.distance, v.key));
}
}

    // rust: mod tests {
//     use super::*;
//     use std::collections::{HashMap, HashSet};

column_walk_finds_exactly_the_sections_in_view :: proc() {
}
    // rust: let mut r = Resident::default();
    // rust: for x in -12i32..=12 {
    // rust: for z in -12..=12 {
    // rust: for y in 0..24 {
                    // Leave holes so columns have uneven bounds.
    // rust: if (x * 7 + y * 3 + z * 5).rem_euclid(4) != 0 {
                        // Mix of sections with fallback None and randomized tight bounds.
    // rust: let bounds = if (x + y + z).rem_euclid(2) == 0 {
    // rust: let y_min = ((x + z).rem_euclid(4)) as f32;
    // rust: let y_max = y_min + 2.0 + ((y.rem_euclid(5)) as f32);
    // rust: Some([Vec3::new(0.0, y_min, 0.0), Vec3::new(16.0, y_max, 16.0)])
    // rust: } else {
    // rust: None
}
    // rust: r.insert_with_bounds((x, y, z), (), bounds);
}
}
}
}
    // rust: let reachable = |k: SectionKey| (k.0 + k.1 + k.2).rem_euclid(9) != 0;
    // rust: let cameras = [
    // rust: (DVec3::new(0.5, 70.0, 0.5), 0.0, 0.0),
    // rust: (DVec3::new(-37.25, 130.5, 21.75), 135.0, 35.0),
    // rust: (DVec3::new(100.0, -60.0, -3.0), 270.0, -80.0),
    // rust: (DVec3::new(8.0, 64.0, 8.0), 45.0, 89.0),
    // rust: ];
    // rust: for (camera, yaw, pitch) in cameras {
    // rust: for radius in [2, 6, 10] {
    // rust: let projection = super::super::world_projection(70.0, 16.0 / 9.0, 512.0);
    // rust: let view = crate::camera::view_matrix(yaw, pitch);
    // rust: let frustum = Frustum {
    // rust: planes: super::super::frustum(projection * view),
}
    // rust: let mut fast = Vec::new();
                // Columns past the distance kept for distant terrain.
    // rust: let beyond = |x: i32, z: i32| (x + z).rem_euclid(3) == 0;
    // rust: r.visible(camera, radius, &frustum, reachable, beyond, &mut fast);
    // rust: let mut slow: Vec<(SectionKey, f64, [f32; 3])> = r
    // rust: .items
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(slot, &(k, _))| {
    // rust: let near = in_view_distance(camera_column(camera), radius, k.0, k.2);
    // rust: if near {
    // rust: in_view_with_bounds(k, camera, radius, &frustum, r.bounds[slot])
    // rust: .filter(|_| reachable(k))
    // rust: } else if beyond(k.0, k.2) {
    // rust: in_frustum(
    // rust: k,
    // rust: crate::chunk::MIN_Y,
    // rust: camera,
    // rust: &frustum,
    // rust: false,
    // rust: r.bounds[slot],
    // rust: )
    // rust: } else {
    // rust: None
}
    // rust: .map(|(d, o)| (k, d, o.to_array()))
    // rust: })
    // rust: .collect();
    // rust: slow.sort_unstable_by(|a, b| a.1.total_cmp(&b.1).then(a.0.cmp(&b.0)));
    // rust: let fast: Vec<_> = fast
    // rust: .iter()
    // rust: .map(|v| {
    // rust: assert_eq!(r.items[v.slot as usize].0, v.key);
    // rust: (v.key, f64::from_bits(v.distance), v.origin)
    // rust: })
    // rust: .collect();
    // rust: assert!(!slow.is_empty());
    // rust: assert_eq!(fast, slow, "{camera} {yaw} {pitch} {radius}");
}
}
}

columns_entirely_inside_skip_no_section :: proc() {
}
        // Short columns ahead of the camera: most lie entirely inside.
    // rust: let mut r = Resident::default();
    // rust: for x in -12i32..=12 {
    // rust: for z in 1..=12 {
    // rust: for y in 3..6 {
    // rust: if (x + y + z).rem_euclid(3) != 0 {
    // rust: r.insert((x, y, z), ());
}
}
}
}
    // rust: let camera = DVec3::new(0.5, -8.0, 0.5);
    // rust: let projection = super::super::world_projection(70.0, 16.0 / 9.0, 512.0);
    // rust: let frustum = Frustum {
    // rust: planes: super::super::frustum(projection * crate::camera::view_matrix(0.0, 5.0)),
}
    // rust: let inside = r
    // rust: .columns
    // rust: .iter()
    // rust: .filter(|c| {
    // rust: let min = origin((c.x, c.low, c.z), crate::chunk::MIN_Y, camera).as_vec3();
    // rust: let top = origin((c.x, c.high, c.z), crate::chunk::MIN_Y, camera).as_vec3();
    // rust: frustum.contains(min, top + Vec3::splat(16.0))
    // rust: })
    // rust: .count();
    // rust: assert!(inside > 50 && inside < r.columns.len(), "{inside}");
    // rust: let mut fast = Vec::new();
    // rust: r.visible(camera, 12, &frustum, |_| true, |_, _| false, &mut fast);
    // rust: let mut slow: Vec<_> = r
    // rust: .items
    // rust: .iter()
    // rust: .filter_map(|&(k, _)| in_view(k, camera, 12, &frustum).map(|(d, _)| (d, k)))
    // rust: .collect();
    // rust: slow.sort_unstable_by(|a, b| a.0.total_cmp(&b.0).then(a.1.cmp(&b.1)));
    // rust: let fast: Vec<_> = fast
    // rust: .iter()
    // rust: .map(|v| (f64::from_bits(v.distance), v.key))
    // rust: .collect();
    // rust: assert_eq!(fast, slow);
}

    // Every key reaches its value and mark through its slot and column, every
    // column's bounds and sections match the keys, and its marked list holds
    // its marked sections.
check :: proc(r: ^Resident<u32>, model: ^HashMap<SectionKey) {
}
    // rust: assert_eq!(r.len(), model.len());
    // rust: let mut seen = 0;
    // rust: for column in &r.columns {
    // rust: assert!(!column.sections.is_empty());
    // rust: let ys: Vec<i32> = column.sections.iter().map(|s| s.0).collect();
    // rust: assert_eq!(column.low, *ys.iter().min().unwrap());
    // rust: assert_eq!(column.high, *ys.iter().max().unwrap());
    // rust: for &(y, slot) in &column.sections {
    // rust: let (key, value) = &r.items[slot as usize];
    // rust: assert_eq!(*key, (column.x, y, column.z));
    // rust: assert_eq!(model[key], (*value, r.marked[slot as usize]));
    // rust: seen += 1;
}
    // rust: let mut marked: Vec<(i32, u32)> = column
    // rust: .sections
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&(_, slot)| r.marked[slot as usize])
    // rust: .collect();
    // rust: let mut listed = column.marked.clone();
    // rust: marked.sort_unstable();
    // rust: listed.sort_unstable();
    // rust: assert_eq!(listed, marked, "column ({}, {})", column.x, column.z);
}
    // rust: assert_eq!(seen, model.len());
    // rust: for (key, &(_, marked)) in model {
    // rust: assert!(r.contains(*key));
    // rust: assert_eq!(r.is_marked(*key), marked, "{key:?}");
}
}

slots_and_columns_follow_inserts_and_removals :: proc() {
}
    // rust: let mut r = Resident::default();
    // rust: let mut model = HashMap::new();
        // Bounds that tell values apart.
    // rust: let bounds = |value: u32| {
    // rust: (!value.is_multiple_of(3)).then(|| [Vec3::splat((value % 5) as f32), Vec3::splat(16.0)])
}
        // A deterministic mix of inserts, replacements and removals, marked at
        // random: a replacement can mark or unmark its section, and so can a
        // mark set alone (`set_marked`), which leaves a key not resident alone.
    // rust: let mut seed = 0x2545_f491_u32;
    // rust: for step in 0..4000u32 {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 17;
    // rust: seed ^= seed << 5;
    // rust: let key = (
    // rust: (seed % 5) as i32 - 2,
    // rust: ((seed >> 4) % 6) as i32 - 1,
    // rust: ((seed >> 8) % 5) as i32 - 2,
    // rust: );
    // rust: if (seed >> 12).is_multiple_of(389) {
                // Every column at once (a far teleport), and one that holds nothing.
    // rust: let gone: FxHashSet<(i32, i32)> = (-2..=3)
    // rust: .flat_map(|x| (-2..=2).map(move |z| (x, z)))
    // rust: .collect();
    // rust: let mut removed = r.remove_columns(&gone);
    // rust: let mut expected: Vec<u32> = model.drain().map(|(_, (value, _))| value).collect();
    // rust: removed.sort_unstable();
    // rust: expected.sort_unstable();
    // rust: assert_eq!(removed, expected);
    // rust: assert!(r.columns.is_empty() && r.column_index.is_empty());
    // rust: } else if (seed >> 12).is_multiple_of(97) {
                // Whole columns at once: the column of `key` and the next one along x.
                // The others keep their values, bounds and marks (`check`).
    // rust: let gone: FxHashSet<(i32, i32)> =
    // rust: [(key.0, key.2), (key.0 + 1, key.2)].into_iter().collect();
    // rust: let mut removed = r.remove_columns(&gone);
    // rust: let mut expected: Vec<u32> = model
    // rust: .extract_if(|k: &SectionKey, _| gone.contains(&(k.0, k.2)))
    // rust: .map(|(_, (value, _))| value)
    // rust: .collect();
    // rust: removed.sort_unstable();
    // rust: expected.sort_unstable();
    // rust: assert_eq!(removed, expected);
    // rust: } else if (seed >> 12).is_multiple_of(3) {
    // rust: assert_eq!(r.remove(key), model.remove(&key).map(|(value, _)| value));
    // rust: } else if (seed >> 12).is_multiple_of(5) {
    // rust: let marked = (seed >> 20).is_multiple_of(2);
    // rust: r.set_marked(key, marked);
    // rust: if let Some(held) = model.get_mut(&key) {
    // rust: held.1 = marked;
}
    // rust: } else {
    // rust: let marked = (seed >> 20).is_multiple_of(2);
    // rust: r.insert_marked(key, step, bounds(step), marked);
    // rust: model.insert(key, (step, marked));
}
    // rust: check(&r, &model);
            // `iter_mut` yields every key once, with its value and bounds.
    // rust: let mut seen = HashSet::new();
    // rust: for (key, value, b) in r.iter_mut() {
    // rust: assert_eq!(*value, model[&key].0, "{key:?}");
    // rust: assert_eq!(b, bounds(*value), "{key:?}");
    // rust: assert!(seen.insert(key), "{key:?} twice");
}
    // rust: assert_eq!(seen.len(), model.len());
}
    // rust: for (_, value, _) in r.iter_mut() {
    // rust: *value += 1;
}
    // rust: for (key, (value, _)) in &model {
    // rust: assert_eq!(r.find(*key), Some(&(value + 1)));
}
    // rust: r.clear();
    // rust: assert_eq!(r.len(), 0);
    // rust: assert!(r.columns.is_empty() && r.marked.is_empty());
}

    // GPU frames' walk (`walk` with `marked_only_near`) is `visible` less the
    // sections within the render distance that are not marked, in the same
    // order: with marks at random, bounds reaching out of their cells, short
    // columns entirely inside the frustum, cave reach, and columns past the
    // distance kept for far terrain (GPU frames have no water mirror,
    // `gpu_frame`).
the_marked_walk_is_the_walk_less_unmarked_sections_within_the_distance :: proc() {
}
    // rust: let mut r = Resident::default();
    // rust: let mut seed = 0x9e37_79b9_u32;
    // rust: let mut next = || {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 17;
    // rust: seed ^= seed << 5;
    // rust: seed
}
    // rust: for x in -14i32..=14 {
    // rust: for z in -14i32..=14 {
                // Short columns ahead of the first camera: most lie entirely inside.
    // rust: let rows = if z > 0 && x.abs() <= 12 { 3..6 } else { 0..24 };
    // rust: for y in rows {
    // rust: let bits = next();
    // rust: if bits.is_multiple_of(5) {
    // rust: continue;
}
    // rust: let bounds = match (bits >> 4) % 4 {
    // rust: 0 => None,
    // rust: 1 => Some([Vec3::splat(-1.5), Vec3::splat(17.5)]),
    // rust: 2 => Some([Vec3::new(0.0, 18.0, 0.0), Vec3::new(16.0, 20.0, 16.0)]),
    // rust: _ => Some([Vec3::new(2.0, 0.0, 3.0), Vec3::new(14.0, 5.5, 16.0)]),
}
    // rust: r.insert_marked((x, y, z), (), bounds, (bits >> 8).is_multiple_of(3));
}
}
}
    // rust: let reachable = |k: SectionKey| (3 * k.0 + k.1 + 5 * k.2).rem_euclid(7) != 0;
    // rust: let beyond = |x: i32, z: i32| (x - z).rem_euclid(3) == 0;
    // rust: let projection = super::super::world_projection(70.0, 16.0 / 9.0, 512.0);
    // rust: let (mut kept, mut dropped, mut inside) = (0, 0, 0);
    // rust: for (camera, yaw, pitch) in [
    // rust: (DVec3::new(0.5, -8.0, 0.5), 0.0, 5.0),
    // rust: (DVec3::new(-37.25, 130.5, 21.75), 135.0, 35.0),
    // rust: (DVec3::new(100.0, -60.0, -3.0), 270.0, -80.0),
    // rust: (DVec3::new(8.0, 64.0, 8.0), 45.0, 89.0),
    // rust: ] {
    // rust: let view = Frustum {
    // rust: planes: super::super::frustum(projection * crate::camera::view_matrix(yaw, pitch)),
}
    // rust: inside += r
    // rust: .columns
    // rust: .iter()
    // rust: .filter(|c| {
    // rust: let min = origin((c.x, c.low, c.z), r.min_y, camera).as_vec3();
    // rust: let top = origin((c.x, c.high, c.z), r.min_y, camera).as_vec3();
    // rust: view.contains(min, top + Vec3::splat(16.0))
    // rust: })
    // rust: .count();
    // rust: for radius in [3, 7, 12] {
    // rust: let (mut all, mut marked) = (Vec::new(), Vec::new());
    // rust: r.visible(camera, radius, &view, reachable, beyond, &mut all);
    // rust: r.walk(camera, radius, &view, reachable, beyond, true, &mut marked);
    // rust: let from = camera_column(camera);
    // rust: let near = |v: &Visible| in_view_distance(from, radius, v.key.0, v.key.2);
    // rust: let expected: Vec<Visible> = all
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|v| r.is_marked(v.key) || !near(v))
    // rust: .collect();
    // rust: assert_eq!(marked, expected, "{camera} {yaw} {pitch} {radius}");
    // rust: kept += marked.len();
    // rust: dropped += all.len() - marked.len();
}
}
    // rust: assert!(
    // rust: kept > 100 && dropped > 100,
    // rust: "{kept} kept, {dropped} dropped"
    // rust: );
    // rust: assert!(inside > 50, "{inside} columns entirely inside");
}

    // The old walk (every key of a hash map, sorted by distance, then two
    // lookups per visible section) against `visible` on a render distance
    // 32 world. Run with `cargo test --profile fast -p horizon-client --lib
    // -- --ignored column_walk_speed --nocapture`.
column_walk_speed :: proc() {
}
//         use std::time::{Duration, Instant};
    // rust: let mut r = Resident::default();
    // rust: let mut map = HashMap::new();
    // rust: for x in -33i32..=33 {
    // rust: for z in -33i32..=33 {
    // rust: for y in 0..24 {
    // rust: if (x * 7 + y * 3 + z * 5).rem_euclid(4) != 0 {
    // rust: r.insert((x, y, z), [x, y, z]);
    // rust: map.insert((x, y, z), [x, y, z]);
}
}
}
}
    // rust: let camera = DVec3::new(8.5, 100.0, 8.5);
    // rust: let projection = super::super::world_projection(70.0, 16.0 / 9.0, 1024.0);
    // rust: let frustum = Frustum {
    // rust: planes: super::super::frustum(projection * crate::camera::view_matrix(30.0, 35.0)),
}
    // rust: let (mut old, mut new) = (Duration::MAX, Duration::MAX);
    // rust: let (mut list, mut keys) = (Vec::new(), Vec::new());
    // rust: let mut sum = 0i64;
    // rust: for _ in 0..200 {
    // rust: let t = Instant::now();
    // rust: keys.clear();
    // rust: keys.extend(map.keys().filter_map(|&k| {
    // rust: in_view(k, camera, 32, &frustum).map(|(d, o)| (k, d, o.to_array()))
    // rust: }));
    // rust: keys.sort_unstable_by(|a, b| a.1.total_cmp(&b.1));
    // rust: for (k, _, _) in &keys {
    // rust: sum += i64::from(map[k][1] + map[k][0]);
}
    // rust: old = old.min(t.elapsed());
    // rust: let t = Instant::now();
    // rust: list.clear();
    // rust: r.visible(camera, 32, &frustum, |_| true, |_, _| false, &mut list);
    // rust: for v in &list {
    // rust: sum += i64::from(r.get(v.slot)[1] + r.get(v.slot)[0]);
}
    // rust: new = new.min(t.elapsed());
}
    // rust: assert_eq!(keys.len(), list.len());
    // rust: println!(
    // rust: "{} resident, {} visible: old walk {old:?}, column walk {new:?} (checksum {sum})",
    // rust: r.len(),
    // rust: list.len()
    // rust: );
}

tight_mesh_bounds_culls_section_outside_frustum :: proc() {
}
    // rust: let mut r = Resident::default();
    // rust: let key = (0, 0, 0);
        // Section geometry only occupies local Y in [0.0, 2.0]
    // rust: let tight = Some([Vec3::new(0.0, 0.0, 0.0), Vec3::new(16.0, 2.0, 16.0)]);
    // rust: r.insert_with_bounds(key, (), tight);

    // rust: let camera = DVec3::new(8.0, f64::from(crate::chunk::MIN_Y + 15), -2.0);
    // rust: let projection = super::super::world_projection(70.0, 16.0 / 9.0, 512.0);
    // rust: let view = crate::camera::view_matrix(0.0, -60.0);
    // rust: let frustum = Frustum {
    // rust: planes: super::super::frustum(projection * view),
}

        // Tight bounds culls the section whose geometry is entirely outside the frustum
    // rust: let mut out = Vec::new();
    // rust: r.visible(camera, 4, &frustum, |_| true, |_, _| false, &mut out);
    // rust: assert!(
    // rust: out.is_empty(),
    // rust: "tight bounds should cull section whose geometry is below frustum"
    // rust: );

        // With fallback 16x16x16 bounds, the section intersects the frustum and is visible
    // rust: r.insert_with_bounds(key, (), None);
    // rust: out.clear();
    // rust: r.visible(camera, 4, &frustum, |_| true, |_, _| false, &mut out);
    // rust: assert_eq!(
    // rust: out.len(),
    // rust: 1,
    // rust: "full 16x16x16 bounds intersect frustum and are accepted"
    // rust: );
}

tight_bounds_benchmark :: proc() {
}
//         use std::time::Instant;

    // rust: let mut r_fallback = Resident::default();
    // rust: let mut r_tight = Resident::default();

    // rust: let radius = 16;
    // rust: for x in -radius..=radius {
    // rust: for z in -radius..=radius {
                // Section 0..4: underground rock
    // rust: for y in 0..4 {
    // rust: r_fallback.insert((x, y, z), ());
    // rust: r_tight.insert_with_bounds((x, y, z), (), None);
}
                // Section 4: surface terrain with grass / hills (e.g. Y in [0, 4] or [0, 6])
    // rust: let height = 2.0 + (((x * 3 + z * 5).rem_euclid(5)) as f32) * 1.5;
    // rust: let surface_bounds =
    // rust: Some([Vec3::new(0.0, 0.0, 0.0), Vec3::new(16.0, height, 16.0)]);
    // rust: r_fallback.insert((x, 4, z), ());
    // rust: r_tight.insert_with_bounds((x, 4, z), (), surface_bounds);
}
}

    // rust: println!("\n=== Tight Bounds Culling Benchmark ===");
    // rust: println!("Total Resident Sections: {}", r_tight.len());

    // rust: let test_views = [
    // rust: ("Looking level across terrain (pitch 0°)", 0.0, 0.0),
    // rust: ("Looking slightly up (pitch -15°)", 45.0, -15.0),
    // rust: ("Looking up towards sky (pitch -35°)", 90.0, -35.0),
    // rust: ("Looking down at ground (pitch 25°)", 180.0, 25.0),
    // rust: ("Diagonal view (yaw 135°, pitch -10°)", 135.0, -10.0),
    // rust: ];

    // rust: let camera = DVec3::new(8.0, f64::from(crate::chunk::MIN_Y + 4 * 16 + 10), 8.0);
    // rust: let projection = super::super::world_projection(70.0, 16.0 / 9.0, 512.0);

    // rust: for (desc, yaw, pitch) in test_views {
    // rust: let view = crate::camera::view_matrix(yaw, pitch);
    // rust: let frustum = Frustum {
    // rust: planes: super::super::frustum(projection * view),
}

    // rust: let mut out_fallback = Vec::new();
    // rust: let mut out_tight = Vec::new();

    // rust: r_fallback.visible(
    // rust: camera,
    // rust: radius,
    // rust: &frustum,
    // rust: |_| true,
    // rust: |_, _| false,
    // rust: &mut out_fallback,
    // rust: );
    // rust: r_tight.visible(
    // rust: camera,
    // rust: radius,
    // rust: &frustum,
    // rust: |_| true,
    // rust: |_, _| false,
    // rust: &mut out_tight,
    // rust: );

    // rust: let culled_extra = out_fallback.len().saturating_sub(out_tight.len());
    // rust: let pct_saved = if !out_fallback.is_empty() {
    // rust: (culled_extra as f64 / out_fallback.len() as f64) * 100.0
    // rust: } else {
    // rust: 0.0
}

            // Timing over 1,000 passes
    // rust: let iters = 1_000;
    // rust: let t0 = Instant::now();
    // rust: for _ in 0..iters {
    // rust: out_fallback.clear();
    // rust: r_fallback.visible(
    // rust: camera,
    // rust: radius,
    // rust: &frustum,
    // rust: |_| true,
    // rust: |_, _| false,
    // rust: &mut out_fallback,
    // rust: );
}
    // rust: let dur_fallback = t0.elapsed();

    // rust: let t1 = Instant::now();
    // rust: for _ in 0..iters {
    // rust: out_tight.clear();
    // rust: r_tight.visible(
    // rust: camera,
    // rust: radius,
    // rust: &frustum,
    // rust: |_| true,
    // rust: |_, _| false,
    // rust: &mut out_tight,
    // rust: );
}
    // rust: let dur_tight = t1.elapsed();

    // rust: println!(
    // rust: "{desc}\n  Fallback 16x16: {} sections | {:?}\n  Tight Bounds:   {} sections | {:?}\n  Reduction:      -{} sections ({:.1}% culled)\n",
    // rust: out_fallback.len(),
    // rust: dur_fallback / iters,
    // rust: out_tight.len(),
    // rust: dur_tight / iters,
    // rust: culled_extra,
    // rust: pct_saved
    // rust: );
}
}
}
