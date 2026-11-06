//! Transpiled from Horizon Rust crate
//! Module: horizon-client_item_areas
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Where the level's dropped items lie, in 8-block cells, for the passes that
//! test each mob's reach against every item (`Mob.aiStep`'s looting, the
//! foxes' and dolphins' item searches). A reach that meets no cell holding an
//! item meets no item, so its scan, which would find nothing, is skipped; a
//! reach near an item scans as before, in the same order, with the same tests,
//! jumping over the items of the cells it doesn't meet ([`ItemScan`]).
// use horizon_client::{entities::ItemEntity, fast_hash::FxHashMap, join_seq::JoinSeq};
// use horizon_core::geometry::Aabb;

/// Cells of 8 blocks on each axis.
pub const SHIFT: i32 = 3;

    // rust: pub(super) struct ItemAreas {
    /// The items in each cell, by index, in the list's order.
    // rust: cells: FxHashMap<[i32; 3], Vec<u32>>,
    /// What the cells were built from: the list's length, the last entity id
    /// the game handed out and the next join number. An item spawned or
    /// removed since changes one of them, and the cells are built again.
    // rust: built: Option<(usize, u32, u64)>,
}

    // rust: impl ItemAreas {
    /// Whether an item of `items` may meet `area`: false only when none can.
    // rust: pub(super) fn may_meet(&mut self, items: &[ItemEntity], next_entity: u32, area: Aabb) -> bool {
    // rust: self.build(items, next_entity);
    // rust: if self.cells.is_empty() {
    // rust: return false;
}
    // rust: let Some((from, to)) = cell_span(area) else {
    // rust: return true;
}
    // rust: if span(from, to) > self.cells.len() as i64 {
    // rust: return self
    // rust: .cells
    // rust: .keys()
    // rust: .any(|c| (0..3).all(|a| (from[a]..=to[a]).contains(&c[a])));
}
    // rust: (from[2]..=to[2]).any(|z| {
    // rust: (from[1]..=to[1])
    // rust: .any(|y| (from[0]..=to[0]).any(|x| self.cells.contains_key(&[x, y, z])))
    // rust: })
}

    /// A scan of `items` for `area`, which jumps over the items that can't
    /// meet it; empty when none can ([`Self::may_meet`] false).
    // rust: pub(super) fn scan(&mut self, items: &[ItemEntity], next_entity: u32, area: Aabb) -> ItemScan {
    // rust: let all = ItemScan {
    // rust: near: None,
    // rust: passed: 0,
    // rust: len: items.len(),
}
    // rust: if !self.may_meet(items, next_entity, area) {
    // rust: return ItemScan {
    // rust: near: Some(Vec::new()),
    // rust: ..all
}
}
    // rust: let Some((from, to)) = cell_span(area) else {
    // rust: return all;
}
    // rust: if span(from, to) > self.cells.len() as i64 {
    // rust: return all;
}
    // rust: let mut near = Vec::new();
    // rust: for z in from[2]..=to[2] {
    // rust: for y in from[1]..=to[1] {
    // rust: for x in from[0]..=to[0] {
    // rust: if let Some(list) = self.cells.get(&[x, y, z]) {
    // rust: near.extend(list.iter().map(|&i| i as usize));
}
}
}
}
    // rust: near.sort_unstable();
    // rust: ItemScan {
    // rust: near: Some(near),
    // rust: ..all
}
}

pub fn build(self: *Self, items: *[ItemEntity], next_entity: u32) void {
}
    // rust: let key = (items.len(), next_entity, JoinSeq::upcoming().get());
    // rust: if self.built == Some(key) {
    // rust: return;
}
    // rust: self.cells.clear();
    // rust: for (i, e) in items.iter().enumerate() {
    // rust: let p = e.position;
    // rust: let at = [cell(p.x), cell(p.y), cell(p.z)];
    // rust: self.cells.entry(at).or_default().push(i as u32);
}
    // rust: self.built = Some(key);
}
}

/// One reach's walk over the items, in the list's order: [`Self::next_from`] gives
/// the next index to test, past the items that lie in cells the reach doesn't
/// meet. Told of each item the walk removes, it keeps up; if the list changes
/// any other way (an item joins), the walk tests every item from there on.
    // rust: pub(super) struct ItemScan {
    /// The items in the cells the reach meets, by index; `None`: every item.
    // rust: near: Option<Vec<usize>>,
    /// The first of `near` not yet passed.
    // rust: passed: usize,
    /// The list's length as the walk knows it.
    // rust: len: usize,
}

    // rust: impl ItemScan {
    /// Whether no item can meet the reach.
    // rust: pub(super) fn is_empty(&self) -> bool {
    // rust: self.near.as_ref().is_some_and(Vec::is_empty)
}
    /// The first index from `j` the walk must test (`len` or more: done).
    // rust: pub(super) fn next_from(&mut self, j: usize, len: usize) -> usize {
    // rust: if len != self.len {
    // rust: self.near = None;
}
    // rust: let Some(near) = &self.near else {
    // rust: return j;
}
    // rust: while near.get(self.passed).is_some_and(|&i| i < j) {
    // rust: self.passed += 1;
}
    // rust: near.get(self.passed).copied().unwrap_or(len).max(j)
}
    /// The walk removed item `j`: the items after it moved down one.
    // rust: pub(super) fn removed(&mut self, j: usize) {
    // rust: self.len -= 1;
    // rust: if let Some(near) = &mut self.near {
    // rust: for i in near.iter_mut().filter(|i| **i > j) {
    // rust: *i -= 1;
}
}
}
}

/// The cells an item meeting `area` may lie in: an item's box spans its width
/// sideways and upwards from its position, and a margin of a whole width
/// keeps rounding on the safe side. `None` for an area that isn't finite.
pub fn cell_span(area: Aabb) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = (area.min_position(), area.max_position());
    // rust: if !lo.is_finite() || !hi.is_finite() {
    // rust: return None;
}
    // rust: let m = ItemEntity::WIDTH;
    // rust: let from = [cell(lo.x - m), cell(lo.y - 2.0 * m), cell(lo.z - m)];
    // rust: let to = [cell(hi.x + m), cell(hi.y + m), cell(hi.z + m)];
    // rust: Some((from, to))
}

pub fn span(from: [i32; 3], to: [i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..3)
    // rust: .map(|a| i64::from(to[a]) - i64::from(from[a]) + 1)
    // rust: .product()
}

pub fn cell(v: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (v.floor() as i32) >> SHIFT
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;

pub fn item_at(x: f64, y: f64, z: f64) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = Vec3::new(x, y, z);
    // rust: ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: id: 1,
    // rust: stack: horizon_client::items::ItemStack::new("minecraft:egg", 1),
    // rust: thrower: None,
    // rust: target: None,
    // rust: position: p,
    // rust: previous: p,
    // rust: velocity: Vec3::ZERO,
    // rust: on_ground: true,
    // rust: age: 0,
    // rust: pickup_delay: 0,
    // rust: bob_offset: 0.0,
    // rust: ticks: 0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
    // rust: no_gravity: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
}
}

    /// Whether some item's own box meets `area`, as the scans test it.
pub fn scan_meets(items: *[ItemEntity], area: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: items.iter().any(|e| area.intersects(e.bounds()))
}

pub fn a_reach_that_meets_an_item_is_never_skipped() void {
}
        // Items just inside and just outside reach of a box, across cell
        // edges and on both sides of zero.
    // rust: let mut items = Vec::new();
    // rust: for &x in &[-16.13, -8.0, -7.9, -0.125, 0.0, 7.87, 8.0, 15.99] {
    // rust: for &y in &[-64.0, -1.0, 0.0, 7.75, 64.3] {
    // rust: items.push(item_at(x, y, x * 0.5));
}
}
    // rust: let mut cells = ItemAreas::default();
    // rust: for &x in &[-17.0, -9.0, -8.3, -1.0, -0.4, 0.2, 7.0, 7.9, 8.2, 15.0] {
    // rust: for &y in &[-65.0, -2.0, -0.3, 6.9, 7.6, 63.0] {
    // rust: for &w in &[0.3, 1.3, 8.3] {
    // rust: let area = Aabb::new(
    // rust: Vec3::new(x - w, y, x * 0.5 - w),
    // rust: Vec3::new(x + w, y + 1.95, x * 0.5 + w),
    // rust: );
    // rust: if scan_meets(&items, area) {
    // rust: assert!(cells.may_meet(&items, 1, area), "{area:?}");
}
}
}
}
}

pub fn a_reach_far_from_every_item_is_skipped() void {
}
    // rust: let items = vec![item_at(100.5, 64.0, 100.5)];
    // rust: let mut cells = ItemAreas::default();
    // rust: let near = Aabb::new(Vec3::new(98.0, 63.0, 98.0), Vec3::new(101.0, 65.0, 101.0));
    // rust: let far = Aabb::new(Vec3::new(0.0, 63.0, 0.0), Vec3::new(2.6, 65.0, 2.6));
    // rust: assert!(cells.may_meet(&items, 1, near));
    // rust: assert!(!cells.may_meet(&items, 1, far));
    // rust: assert!(!cells.may_meet(&[], 1, near));
}

    /// The items a walk tests that meet `area`, by position: what the scans
    /// act on. `take` removes the item it names when the walk meets it.
pub fn walk(items: *mut std.ArrayList(ItemEntity), area: Aabb, take: ?f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut cells = ItemAreas::default();
    // rust: let mut scan = cells.scan(items, 1, area);
    // rust: let (mut met, mut j) = (Vec::new(), 0);
    // rust: loop {
    // rust: j = scan.next_from(j, items.len());
    // rust: let Some(e) = items.get(j) else {
    // rust: break;
}
    // rust: if !area.intersects(e.bounds()) {
    // rust: j += 1;
    // rust: continue;
}
    // rust: met.push(e.position.x);
    // rust: if take == Some(e.position.x) {
    // rust: items.remove(j);
    // rust: scan.removed(j);
    // rust: } else {
    // rust: j += 1;
}
}
    // rust: met
}

pub fn a_walk_meets_what_a_full_scan_meets_in_the_same_order() void {
}
    // rust: let mut items = Vec::new();
    // rust: for i in 0..60 {
    // rust: let x = -40.0 + f64::from(i) * 1.37;
    // rust: items.push(item_at(
    // rust: x,
    // rust: 64.0 + f64::from(i % 3) * 0.6,
    // rust: (x * 0.7).sin() * 9.0,
    // rust: ));
}
    // rust: for k in 0..40 {
    // rust: let x = -42.0 + f64::from(k) * 2.11;
    // rust: let area = Aabb::new(Vec3::new(x, 63.5, -10.0), Vec3::new(x + 3.3, 65.5, 10.0));
    // rust: let full: Vec<f64> = items
    // rust: .iter()
    // rust: .filter(|e| area.intersects(e.bounds()))
    // rust: .map(|e| e.position.x)
    // rust: .collect();
    // rust: assert_eq!(walk(&mut items.clone(), area, None), full, "{area:?}");
}
}

pub fn a_walk_keeps_up_with_the_items_it_removes() void {
}
    // rust: let xs = [1.0, 30.0, 1.5, 31.0, 2.0, 2.5];
    // rust: let mut items: Vec<ItemEntity> = xs.iter().map(|&x| item_at(x, 64.0, 1.0)).collect();
    // rust: let area = Aabb::new(Vec3::new(0.0, 63.0, 0.0), Vec3::new(3.0, 65.0, 2.0));
    // rust: assert_eq!(walk(&mut items, area, Some(1.5)), vec![1.0, 1.5, 2.0, 2.5]);
    // rust: assert_eq!(items.len(), 5);
}

pub fn a_walk_tests_an_item_that_joins_during_it() void {
}
    // rust: let mut items = vec![item_at(1.0, 64.0, 1.0), item_at(40.0, 64.0, 1.0)];
    // rust: let area = Aabb::new(Vec3::new(0.0, 63.0, 0.0), Vec3::new(3.0, 65.0, 2.0));
    // rust: let mut cells = ItemAreas::default();
    // rust: let mut scan = cells.scan(&items, 1, area);
    // rust: assert_eq!(scan.next_from(0, items.len()), 0);
        // One joins at the end, inside the reach, after the walk began.
    // rust: items.push(item_at(2.0, 64.0, 1.0));
    // rust: assert_eq!(scan.next_from(1, items.len()), 1);
    // rust: assert_eq!(scan.next_from(2, items.len()), 2);
}

pub fn an_item_spawned_after_the_cells_were_built_is_seen() void {
}
    // rust: let mut items = vec![item_at(100.5, 64.0, 100.5)];
    // rust: let mut cells = ItemAreas::default();
    // rust: let area = Aabb::new(Vec3::new(0.0, 63.0, 0.0), Vec3::new(2.6, 65.0, 2.6));
    // rust: assert!(!cells.may_meet(&items, 1, area));
        // Spawned where the first one was taken: the same length, a new id.
    // rust: items[0] = item_at(1.0, 64.0, 1.0);
    // rust: assert!(cells.may_meet(&items, 2, area));
}
}
