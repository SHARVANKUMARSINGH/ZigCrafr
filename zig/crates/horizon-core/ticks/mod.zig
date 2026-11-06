//! Transpiled from Horizon Rust crate
//! Module: horizon-core_mod
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Scheduled block/fluid tick machinery for Java Edition 26.3. Type IDs identify
//! registry-owned types; each block/fluid registry uses its own LevelTicks.
    // rust: mod generation;
    // rust: pub use generation::{
    // rust: ProtoChunkTicks, TickContainerAccess, WorldGenTickAccess, WorldGenTickContainers,
}
    // rust: mod heap;
    // rust: mod index;
// use crate::fast_hash::{FxHashMap, FxHashSet};
// use crate::position::{BlockPos, ChunkPos};
// use heap::Heap;
// use index::DeadlineIndex;
// use std::{cmp::Ordering, collections::VecDeque};

pub const TickTypeId = struct {};

pub const TickPriority = enum {
    ExtremelyHigh = -3,
    VeryHigh = -2,
    High = -1,
    Normal = 0,
    Low = 1,
    VeryLow = 2,
    ExtremelyLow = 3,
};
    // rust: impl TickPriority {
    // rust: pub const fn by_value(value: i32) -> Self {
    // rust: match value {
    // rust: i32::MIN..=-3 => Self::ExtremelyHigh,
    // rust: -2 => Self::VeryHigh,
    // rust: -1 => Self::High,
    // rust: 0 => Self::Normal,
    // rust: 1 => Self::Low,
    // rust: 2 => Self::VeryLow,
    // rust: 3..=i32::MAX => Self::ExtremelyLow,
}
}
}
pub const ScheduledTick = struct {
    kind: TickTypeId,
    pos: BlockPos,
    trigger_tick: i64,
    priority: TickPriority,
    sub_tick_order: i64,
};
    // rust: impl ScheduledTick {
pub fn drain_cmp(self: *Self, other: Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.trigger_tick
    // rust: .cmp(&other.trigger_tick)
    // rust: .then_with(|| self.intra_cmp(other))
}
pub fn intra_cmp(self: *Self, other: Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.priority
    // rust: .cmp(&other.priority)
    // rust: .then_with(|| self.sub_tick_order.cmp(&other.sub_tick_order))
}
pub fn saved(self: *Self, game_time: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SavedTick {
    // rust: kind: self.kind,
    // rust: pos: self.pos,
    // rust: delay: self.trigger_tick.wrapping_sub(game_time) as i32,
    // rust: priority: self.priority,
}
}
pub fn key(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.kind, self.pos)
}
}
pub const SavedTick = struct {
    kind: TickTypeId,
    pos: BlockPos,
    delay: i32,
    priority: TickPriority,
};
    // rust: impl SavedTick {
pub fn unpack(self: *Self, game_time: i64, sub_tick_order: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ScheduledTick {
    // rust: kind: self.kind,
    // rust: pos: self.pos,
    // rust: trigger_tick: game_time.wrapping_add(i64::from(self.delay)),
    // rust: priority: self.priority,
    // rust: sub_tick_order,
}
}
}

pub const ChunkTicks = struct {
    queue: Heap<ScheduledTick>,
    pending: ?std.ArrayList(SavedTick),
    positions: FxHashSet<(TickTypeId,
};
    // rust: impl ChunkTicks {
pub fn from_saved(ticks: std.ArrayList(SavedTick)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: positions: ticks.iter().map(|t| (t.kind, t.pos)).collect(),
    // rust: pending: Some(ticks),
    // rust: ..Self::default()
}
}
pub fn peek(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.queue.peek()
}
pub fn poll(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tick = self.queue.pop(ScheduledTick::drain_cmp)?;
    // rust: self.positions.remove(&tick.key());
    // rust: Some(tick)
}
    /// First schedule wins for a type/position, irrespective of timing/priority.
pub fn schedule(self: *Self, tick: ScheduledTick) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.positions.insert(tick.key()) {
    // rust: return false;
}
    // rust: self.queue.push(tick, ScheduledTick::drain_cmp);
    // rust: true
}
pub fn has_scheduled(self: *Self, pos: BlockPos, kind: TickTypeId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.positions.contains(&(kind, pos))
}
pub fn count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.queue.values.len() + self.pending.as_ref().map_or(0, Vec::len)
}
    /// Heap traversal order, as exposed by vanilla getAll, rather than sorted order.
pub fn queued(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.queue.values
}
pub fn remove_if(self: *Self, mut predicate: impl FnMut(ScheduledTick) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.queue.remove_if(
    // rust: |tick| {
    // rust: if !predicate(tick) {
    // rust: return false;
}
    // rust: self.positions.remove(&tick.key());
    // rust: true
    // rust: },
    // rust: ScheduledTick::drain_cmp,
    // rust: );
}
pub fn pack(self: *Self, game_time: i64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut saved = self.pending.clone().unwrap_or_default();
    // rust: let mut queued = self.queue.values.clone();
    // rust: queued.sort_by_key(|t| t.sub_tick_order);
    // rust: saved.extend(queued.into_iter().map(|t| t.saved(game_time)));
    // rust: saved
}
pub fn unpack(self: *Self, game_time: i64) void {
}
    // rust: if let Some(pending) = self.pending.take() {
    // rust: let mut order = (pending.len() as i32).wrapping_neg() as i64;
    // rust: for saved in pending {
                // Vanilla does not deduplicate a saved list during unpack.
    // rust: self.queue
    // rust: .push(saved.unpack(game_time, order), ScheduledTick::drain_cmp);
    // rust: order = order.wrapping_add(1);
}
}
}
}

    // rust: mod tests {
//     use super::*;
pub fn tick(kind: u32, x: i32, time: i64, priority: i32, order: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ScheduledTick {
    // rust: kind: TickTypeId(kind),
    // rust: pos: BlockPos::new(x, 64, 0),
    // rust: trigger_tick: time,
    // rust: priority: TickPriority::by_value(priority),
    // rust: sub_tick_order: order,
}
}
pub fn level() L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut level = LevelTicks::default();
    // rust: for x in -1..=2 {
    // rust: level
    // rust: .add_chunk(ChunkPos::new(x, 0), ChunkTicks::default())
    // rust: .unwrap();
}
    // rust: level
}
pub fn due_chunks_compete_by_priority_not_trigger_time() void {
}
    // rust: let mut level = level();
    // rust: for tick in [
    // rust: tick(0, 0, 1, 3, 10),
    // rust: tick(1, 1, 2, -3, 11),
    // rust: tick(2, 16, 3, 0, 12),
    // rust: ] {
    // rust: assert_eq!(level.schedule(tick), ScheduleResult::Added);
}
    // rust: assert_eq!(
    // rust: level.schedule(tick(0, 0, -100, -3, -10)),
    // rust: ScheduleResult::Duplicate
    // rust: );
    // rust: let mut ran = Vec::new();
    // rust: level
    // rust: .tick(10, 10, |_| true, |_, tick| ran.push(tick.kind.0))
    // rust: .unwrap();
    // rust: assert_eq!(ran, [2, 0, 1]);
    // rust: assert_eq!(level.count(), 0);
}
pub fn callback_scheduling_waits_until_the_next_collection() void {
}
    // rust: let mut level = level();
    // rust: let original = tick(0, 0, 0, 0, 0);
    // rust: level.schedule(original);
    // rust: let mut ran = 0;
    // rust: level
    // rust: .tick(
    // rust: 0,
    // rust: 100,
    // rust: |_| true,
    // rust: |level, tick| {
    // rust: ran += 1;
    // rust: assert!(!level.will_tick_this_tick(tick.pos, tick.kind));
    // rust: assert_eq!(level.schedule(tick), ScheduleResult::Added);
    // rust: assert!(level.has_scheduled(tick.pos, tick.kind));
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(ran, 1);
    // rust: assert_eq!(level.count(), 1);
    // rust: level.tick(0, 100, |_| true, |_, _| ran += 1).unwrap();
    // rust: assert_eq!(ran, 2);
    // rust: assert_eq!(level.count(), 0);
}
pub fn pending_ticks_keep_list_order_and_java_time_overflow() void {
}
    // rust: let a = tick(0, 0, i64::MAX, -9, 10).saved(i64::MIN);
    // rust: assert_eq!(a.delay, -1);
    // rust: let b = SavedTick {
    // rust: delay: 1,
    // rust: kind: TickTypeId(1),
    // rust: ..a
}
    // rust: let mut chunk = ChunkTicks::from_saved(vec![a, b, a]);
    // rust: assert_eq!(chunk.count(), 3);
    // rust: assert!(chunk.peek().is_none());
    // rust: assert!(!chunk.schedule(tick(0, 0, 100, 0, 0)));
    // rust: chunk.unpack(i64::MAX);
    // rust: assert_eq!(chunk.count(), 3);
    // rust: assert_eq!(chunk.poll().unwrap().trigger_tick, i64::MIN);
    // rust: assert_eq!(chunk.poll().unwrap().sub_tick_order, -3);
    // rust: assert_eq!(chunk.poll().unwrap().sub_tick_order, -1);
    // rust: chunk.unpack(0);
    // rust: assert_eq!(chunk.count(), 0);
}
pub fn disabled_and_removed_chunks_retain_their_queue() void {
}
    // rust: let mut level = level();
    // rust: level.schedule(tick(0, 0, 0, 0, 0));
    // rust: level
    // rust: .tick(10, 10, |_| false, |_, _| panic!("disabled chunk ran"))
    // rust: .unwrap();
    // rust: let chunk = level.remove_chunk(ChunkPos::new(0, 0)).unwrap();
    // rust: assert_eq!(chunk.count(), 1);
    // rust: assert_eq!(
    // rust: level.schedule(tick(1, 0, 0, 0, 0)),
    // rust: ScheduleResult::MissingChunk
    // rust: );
    // rust: level.add_chunk(ChunkPos::new(0, 0), chunk).unwrap();
    // rust: let mut ran = Vec::new();
    // rust: level
    // rust: .tick(10, 1, |_| true, |_, tick| ran.push(tick))
    // rust: .unwrap();
    // rust: assert_eq!(ran, [tick(0, 0, 0, 0, 0)]);
}
pub fn collection_guards_and_membership_survive_area_mutation() void {
}
    // rust: let mut level = level();
    // rust: level.schedule(tick(0, 0, 0, 0, 0));
    // rust: level.schedule(tick(1, 1, 0, 0, 1));
    // rust: level.begin_tick(0, 10, |_| true).unwrap();
    // rust: assert_eq!(
    // rust: level.begin_tick(0, 10, |_| true),
    // rust: Err(TickError::AlreadyCollecting)
    // rust: );
    // rust: assert_eq!(level.finish_tick(), Err(TickError::TicksRemain));
    // rust: assert_eq!(level.next_tick().unwrap().unwrap().kind, TickTypeId(0));
    // rust: let probe = BlockPos::new(1, 64, 0);
    // rust: assert!(level.will_tick_this_tick(probe, TickTypeId(1)));
    // rust: level.clear_area(TickArea::new(probe, probe));
        // Preserve vanilla's stale lazily built set until cleanup.
    // rust: assert!(level.will_tick_this_tick(probe, TickTypeId(1)));
    // rust: assert!(level.next_tick().unwrap().is_none());
    // rust: level.finish_tick().unwrap();
    // rust: assert!(!level.will_tick_this_tick(probe, TickTypeId(1)));
    // rust: assert_eq!(level.next_tick(), Err(TickError::NotCollecting));
}
pub fn copying_active_ticks_preserves_relative_order_and_wraps() void {
}
    // rust: let mut level = level();
    // rust: level.schedule(tick(0, 0, 0, 0, i64::MAX - 1));
    // rust: level.schedule(tick(1, 1, 0, 0, i64::MAX));
    // rust: level.begin_tick(0, 10, |_| true).unwrap();
    // rust: level.next_tick().unwrap();
    // rust: level.copy_area(
    // rust: TickArea::new(BlockPos::new(0, 64, 0), BlockPos::new(1, 64, 0)),
    // rust: BlockPos::new(16, 0, 0),
    // rust: );
    // rust: let copied = level.chunk(ChunkPos::new(1, 0)).unwrap().queued();
    // rust: assert_eq!(copied.len(), 2);
    // rust: assert_eq!(copied[0].sub_tick_order, i64::MIN);
    // rust: assert_eq!(copied[1].sub_tick_order, i64::MIN + 1);
    // rust: while level.next_tick().unwrap().is_some() {}
    // rust: level.finish_tick().unwrap();
}
}

pub const TickArea = struct {
    min: BlockPos,
    max: BlockPos,
};
    // rust: impl TickArea {
pub fn new(a: BlockPos, b: BlockPos) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: min: BlockPos::new(a.x.min(b.x), a.y.min(b.y), a.z.min(b.z)),
    // rust: max: BlockPos::new(a.x.max(b.x), a.y.max(b.y), a.z.max(b.z)),
}
}
pub fn contains(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.min.x..=self.max.x).contains(&pos.x)
    // rust: && (self.min.y..=self.max.y).contains(&pos.y)
    // rust: && (self.min.z..=self.max.z).contains(&pos.z)
}
}
pub const ScheduleResult = enum {
    Added,
    Duplicate,
    MissingChunk,
};
pub const TickError = enum {
    AlreadyCollecting,
    NotCollecting,
    TicksRemain,
    ChunkAlreadyAdded,
    WrongChunk,
};
    // rust: impl std::fmt::Display for TickError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "scheduled tick invariant: {self:?}")
}
}
    // rust: impl std::error::Error for TickError {}

pub const LevelTicks = struct {
    chunks: FxHashMap<i64,
    deadlines: DeadlineIndex,
    containers_to_tick: Heap<i64>,
    to_run: VecDeque<ScheduledTick>,
    already_run: std.ArrayList(ScheduledTick),
    to_run_set: FxHashSet<(TickTypeId,
    collecting: bool,
};
    // rust: impl LevelTicks {
pub fn add_chunk(self: *Self, pos: ChunkPos, ticks: ChunkTicks) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = pos.pack();
    // rust: if self.chunks.contains_key(&key) {
    // rust: return Err(TickError::ChunkAlreadyAdded);
}
    // rust: if ticks.queue.values.iter().any(|t| t.pos.chunk() != pos)
    // rust: || ticks
    // rust: .pending
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.iter().any(|t| t.pos.chunk() != pos))
    // rust: {
    // rust: return Err(TickError::WrongChunk);
}
    // rust: if let Some(tick) = ticks.peek() {
    // rust: self.deadlines.put(key, tick.trigger_tick);
}
    // rust: self.chunks.insert(key, ticks);
    // rust: Ok(())
}
pub fn remove_chunk(self: *Self, pos: ChunkPos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.deadlines.remove(pos.pack());
    // rust: self.chunks.remove(&pos.pack())
}
pub fn chunk(self: *Self, pos: ChunkPos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks.get(&pos.pack())
}
pub fn unpack_chunk(self: *Self, pos: ChunkPos, game_time: i64) void {
}
    // rust: if let Some(chunk) = self.chunks.get_mut(&pos.pack()) {
    // rust: chunk.unpack(game_time);
    // rust: if let Some(tick) = chunk.peek() {
    // rust: self.deadlines.put(pos.pack(), tick.trigger_tick);
}
}
}
pub fn schedule(self: *Self, tick: ScheduledTick) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = tick.pos.chunk().pack();
    // rust: let Some(chunk) = self.chunks.get_mut(&key) else {
    // rust: return ScheduleResult::MissingChunk;
}
    // rust: if !chunk.schedule(tick) {
    // rust: return ScheduleResult::Duplicate;
}
    // rust: if chunk.peek() == Some(tick) {
    // rust: self.deadlines.put(key, tick.trigger_tick);
}
    // rust: ScheduleResult::Added
}
pub fn has_scheduled(self: *Self, pos: BlockPos, kind: TickTypeId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunk(pos.chunk())
    // rust: .is_some_and(|c| c.has_scheduled(pos, kind))
}
pub fn will_tick_this_tick(self: *Self, pos: BlockPos, kind: TickTypeId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.to_run_set.is_empty() && !self.to_run.is_empty() {
    // rust: self.to_run_set.extend(self.to_run.iter().map(|t| t.key()));
}
    // rust: self.to_run_set.contains(&(kind, pos))
}
pub fn count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks.values().map(ChunkTicks::count).sum()
}
    // rust: pub fn begin_tick(
    // rust: &mut self,
    // rust: game_time: i64,
    // rust: maximum: i32,
    // rust: mut can_tick: impl FnMut(ChunkPos) -> bool,
    // rust: ) -> Result<(), TickError> {
    // rust: if self.collecting {
    // rust: return Err(TickError::AlreadyCollecting);
}
    // rust: self.collecting = true;
    // rust: let mut containers = std::mem::take(&mut self.containers_to_tick);
    // rust: let chunks = &mut self.chunks;
    // rust: let compare = |a: i64, b: i64| {
    // rust: chunks[&a]
    // rust: .peek()
    // rust: .unwrap()
    // rust: .intra_cmp(chunks[&b].peek().unwrap())
}
    // rust: self.deadlines.visit(|key, deadline| {
    // rust: if *deadline > game_time {
    // rust: return false;
}
    // rust: let Some(head) = chunks.get(&key).and_then(ChunkTicks::peek) else {
    // rust: return true;
}
    // rust: if head.trigger_tick > game_time {
    // rust: *deadline = head.trigger_tick;
    // rust: return false;
}
    // rust: if !can_tick(ChunkPos::unpack(key)) {
    // rust: return false;
}
    // rust: containers.push(key, compare);
    // rust: true
    // rust: });
    // rust: let maximum = maximum.max(0) as usize;
    // rust: while self.to_run.len() < maximum {
    // rust: let Some(key) = containers.pop(|a, b| {
    // rust: self.chunks[&a]
    // rust: .peek()
    // rust: .unwrap()
    // rust: .intra_cmp(self.chunks[&b].peek().unwrap())
    // rust: }) else {
    // rust: break;
}
    // rust: let chunk = self.chunks.get_mut(&key).unwrap();
    // rust: self.to_run.push_back(chunk.poll().unwrap());
    // rust: let competing = containers.peek().and_then(|key| self.chunks[&key].peek());
    // rust: let chunk = self.chunks.get_mut(&key).unwrap();
    // rust: while self.to_run.len() < maximum {
    // rust: let Some(head) = chunk.peek() else {
    // rust: break;
}
    // rust: if head.trigger_tick > game_time
    // rust: || competing.is_some_and(|other| head.intra_cmp(other) == Ordering::Greater)
    // rust: {
    // rust: break;
}
    // rust: self.to_run.push_back(chunk.poll().unwrap());
}
    // rust: if let Some(head) = chunk.peek() {
    // rust: if head.trigger_tick <= game_time && self.to_run.len() < maximum {
    // rust: containers.push(key, |a, b| {
    // rust: self.chunks[&a]
    // rust: .peek()
    // rust: .unwrap()
    // rust: .intra_cmp(self.chunks[&b].peek().unwrap())
    // rust: });
    // rust: } else {
    // rust: self.deadlines.put(key, head.trigger_tick);
}
}
}
    // rust: for &key in &containers.values {
    // rust: self.deadlines
    // rust: .put(key, self.chunks[&key].peek().unwrap().trigger_tick);
}
    // rust: containers.values.clear();
    // rust: self.containers_to_tick = containers;
    // rust: Ok(())
}
    /// Pop immediately before invoking block/fluid behavior. The current tick is
    /// already-run, absent from will_tick, and available to area copying.
pub fn next_tick(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.collecting {
    // rust: return Err(TickError::NotCollecting);
}
    // rust: let Some(tick) = self.to_run.pop_front() else {
    // rust: return Ok(None);
}
    // rust: if !self.to_run_set.is_empty() {
    // rust: self.to_run_set.remove(&tick.key());
}
    // rust: self.already_run.push(tick);
    // rust: Ok(Some(tick))
}
pub fn finish_tick(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.collecting {
    // rust: return Err(TickError::NotCollecting);
}
    // rust: if !self.to_run.is_empty() {
    // rust: return Err(TickError::TicksRemain);
}
    // rust: self.already_run.clear();
    // rust: self.to_run_set.clear();
    // rust: self.collecting = false;
    // rust: Ok(())
}
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: game_time: i64,
    // rust: maximum: i32,
    // rust: can_tick: impl FnMut(ChunkPos) -> bool,
    // rust: mut run: impl FnMut(&mut Self, ScheduledTick),
    // rust: ) -> Result<(), TickError> {
    // rust: self.begin_tick(game_time, maximum, can_tick)?;
    // rust: while let Some(tick) = self.next_tick()? {
    // rust: run(self, tick);
}
    // rust: self.finish_tick()
}
pub fn chunks_in_area(self: *Self, area: TickArea) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let min = area.min.chunk();
    // rust: let max = area.max.chunk();
    // rust: if min.x > max.x || min.z > max.z {
    // rust: return Vec::new();
}
    // rust: let width = (i64::from(max.x) - i64::from(min.x) + 1) as u64;
    // rust: let depth = (i64::from(max.z) - i64::from(min.z) + 1) as u64;
        // Small edits should probe their grid rather than scan every loaded chunk.
        // Large empty areas should visit loaded chunks rather than the empty grid.
    // rust: if width * depth <= self.chunks.len() as u64 {
    // rust: let mut keys = Vec::new();
    // rust: for x in min.x..=max.x {
    // rust: for z in min.z..=max.z {
    // rust: let key = ChunkPos::new(x, z).pack();
    // rust: if self.chunks.contains_key(&key) {
    // rust: keys.push(key);
}
}
}
    // rust: return keys;
}
    // rust: let mut keys: Vec<_> = self
    // rust: .chunks
    // rust: .keys()
    // rust: .copied()
    // rust: .filter(|key| {
    // rust: let pos = ChunkPos::unpack(*key);
    // rust: (min.x..=max.x).contains(&pos.x) && (min.z..=max.z).contains(&pos.z)
    // rust: })
    // rust: .collect();
    // rust: keys.sort_by_key(|key| {
    // rust: let p = ChunkPos::unpack(*key);
    // rust: (p.x, p.z)
    // rust: });
    // rust: keys
}
pub fn clear_area(self: *Self, area: TickArea) void {
}
    // rust: for key in self.chunks_in_area(area) {
    // rust: let chunk = self.chunks.get_mut(&key).unwrap();
    // rust: let old = chunk.peek();
    // rust: chunk.remove_if(|tick| area.contains(tick.pos));
    // rust: if chunk.peek() != old {
    // rust: if let Some(tick) = chunk.peek() {
    // rust: self.deadlines.put(key, tick.trigger_tick);
    // rust: } else {
    // rust: self.deadlines.remove(key);
}
}
}
    // rust: self.already_run.retain(|tick| !area.contains(tick.pos));
    // rust: self.to_run.retain(|tick| !area.contains(tick.pos));
        // Vanilla clearArea leaves its lazily computed membership set intact.
}
pub fn area_ticks(self: *Self, area: TickArea) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut ticks: Vec<_> = self
    // rust: .already_run
    // rust: .iter()
    // rust: .chain(self.to_run.iter())
    // rust: .copied()
    // rust: .filter(|t| area.contains(t.pos))
    // rust: .collect();
    // rust: for key in self.chunks_in_area(area) {
    // rust: ticks.extend(
    // rust: self.chunks[&key]
    // rust: .queued()
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|t| area.contains(t.pos)),
    // rust: );
}
    // rust: ticks
}
pub fn schedule_copy(self: *Self, ticks: std.ArrayList(ScheduledTick), offset: BlockPos) void {
}
    // rust: let Some(min) = ticks.iter().map(|t| t.sub_tick_order).min() else {
    // rust: return;
}
    // rust: let max = ticks.iter().map(|t| t.sub_tick_order).max().unwrap();
    // rust: for mut tick in ticks {
    // rust: tick.pos = tick.pos.offset(offset.x, offset.y, offset.z);
    // rust: tick.sub_tick_order = tick
    // rust: .sub_tick_order
    // rust: .wrapping_sub(min)
    // rust: .wrapping_add(max)
    // rust: .wrapping_add(1);
    // rust: self.schedule(tick);
}
}
pub fn copy_area(self: *Self, area: TickArea, offset: BlockPos) void {
}
    // rust: self.schedule_copy(self.area_ticks(area), offset);
}
}
