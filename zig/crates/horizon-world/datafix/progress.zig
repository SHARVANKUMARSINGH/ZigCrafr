//! Transpiled from Horizon Rust crate
//! Module: horizon-world_progress
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `net.minecraft.util.worldupdate.UpgradeProgress`: what a world upgrade has
//! done so far, read by `FileFixerProgressScreen` while another thread works.
// use std::collections::HashMap;
// use std::sync::Mutex;
// use std::sync::atomic::{AtomicBool, AtomicI32, AtomicU8, AtomicU32, Ordering};

/// `UpgradeProgress.FileFixStats`.
pub const FileFixStats = struct {
    finished_operations: AtomicI32,
    total_operations: AtomicI32,
};

    // rust: impl FileFixStats {
pub fn finished_operations(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.finished_operations.load(Ordering::Relaxed)
}
pub fn total_operations(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.total_operations.load(Ordering::Relaxed)
}
pub fn reset(self: *Self) void {
}
    // rust: self.finished_operations.store(0, Ordering::Relaxed);
    // rust: self.total_operations.store(0, Ordering::Relaxed);
}
    /// `getProgress`: finished over total, 0 without operations, in 0..=1.
pub fn progress(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.total_operations() == 0 {
    // rust: 0.0
    // rust: } else {
    // rust: (self.finished_operations() as f32 / self.total_operations() as f32).clamp(0.0, 1.0)
}
}
}

/// `UpgradeProgress.Type`.
pub const UpgradeType = enum {
    Files,
    LegacyStructures,
    Regions,
};

    // rust: impl UpgradeType {
    /// `getSerializedName`.
pub fn serialized_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Files => "files",
    // rust: Self::LegacyStructures => "legacy_structures",
    // rust: Self::Regions => "regions",
}
}
    /// The key of `label()`: `upgradeWorld.progress.type.` + the serialized name.
pub fn label_key(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("upgradeWorld.progress.type.{}", self.serialized_name())
}
pub fn code(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Files => 1,
    // rust: Self::LegacyStructures => 2,
    // rust: Self::Regions => 3,
}
}
}

/// `UpgradeProgress`, as far as the file fixer's screen reads it.
pub const UpgradeProgress = struct {
    total: FileFixStats,
    of_type: FileFixStats,
    running_fixer: FileFixStats,
    canceled: AtomicBool,
    /// `UpgradeProgress.type`: 0 for none.
    ty: AtomicU8,
    /// The upgrade runs the file fixers (`requiresFileFixing`), which is what
    /// opens `FileFixerProgressScreen` (`WorldOpenFlows.upgradeAndOpenWorld`).
    file_fixing: AtomicBool,
    // What `WorldUpgrader` (Optimize World) adds.
    finished: AtomicBool,
    total_progress: AtomicU32,
    total_chunks: AtomicI32,
    converted: AtomicI32,
    skipped: AtomicI32,
    /// `progressMap`: the dimension's id to its progress.
    dimension_progress: Mutex<HashMap<[]const u8,
    status: AtomicU8,
    /// `dataFixType`: 0 for none.
    data_fix_type: AtomicU8,
};

/// `UpgradeProgress.Status`.
pub const UpgradeStatus = enum {
    Counting,
    Failed,
    Finished,
    Upgrading,
};

/// The `DataFixTypes` a `WorldUpgrader` run goes through.
pub const UpgradeDataFixType = enum {
    Chunk,
    EntityChunk,
    PoiChunk,
};

    // rust: impl UpgradeProgress {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::default()
}
pub fn total_file_fix_stats(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.total
}
pub fn type_file_fix_stats(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.of_type
}
pub fn running_file_fixer_stats(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.running_fixer
}
pub fn add_total_file_fix_operations(self: *Self, additional: i32) void {
}
    // rust: self.total
    // rust: .total_operations
    // rust: .fetch_add(additional, Ordering::Relaxed);
    // rust: self.of_type
    // rust: .total_operations
    // rust: .fetch_add(additional, Ordering::Relaxed);
}
pub fn increment_finished_operations(self: *Self) void {
}
    // rust: self.increment_finished_operations_by(1);
}
pub fn increment_finished_operations_by(self: *Self, count: i32) void {
}
    // rust: self.total
    // rust: .finished_operations
    // rust: .fetch_add(count, Ordering::Relaxed);
    // rust: self.of_type
    // rust: .finished_operations
    // rust: .fetch_add(count, Ordering::Relaxed);
}
pub fn set_canceled(self: *Self) void {
}
    // rust: self.canceled.store(true, Ordering::Relaxed);
}
pub fn is_canceled(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.canceled.load(Ordering::Relaxed)
}
    /// `setType`: the type's own stats start over.
pub fn set_type(self: *Self, ty: UpgradeType) void {
}
    // rust: self.ty.store(ty.code(), Ordering::Relaxed);
    // rust: self.of_type.reset();
}
pub fn upgrade_type(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.ty.load(Ordering::Relaxed) {
    // rust: 1 => Some(UpgradeType::Files),
    // rust: 2 => Some(UpgradeType::LegacyStructures),
    // rust: 3 => Some(UpgradeType::Regions),
    // rust: _ => None,
}
}
pub fn set_applicable_fixer_amount(self: *Self, amount: i32) void {
}
    // rust: self.running_fixer
    // rust: .total_operations
    // rust: .store(amount, Ordering::Relaxed);
}
pub fn increment_running_file_fixer(self: *Self) void {
}
    // rust: self.running_fixer
    // rust: .finished_operations
    // rust: .fetch_add(1, Ordering::Relaxed);
}
pub fn is_finished(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.finished.load(Ordering::Relaxed)
}
pub fn set_finished(self: *Self, finished: bool) void {
}
    // rust: self.finished.store(finished, Ordering::Relaxed);
}
pub fn total_progress(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f32::from_bits(self.total_progress.load(Ordering::Relaxed))
}
pub fn set_total_progress(self: *Self, progress: f32) void {
}
    // rust: self.total_progress
    // rust: .store(progress.to_bits(), Ordering::Relaxed);
}
pub fn total_chunks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.total_chunks.load(Ordering::Relaxed)
}
pub fn add_total_chunks(self: *Self, additional: i32) void {
}
    // rust: self.total_chunks.fetch_add(additional, Ordering::Relaxed);
}
pub fn converted(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.converted.load(Ordering::Relaxed)
}
pub fn increment_converted(self: *Self) void {
}
    // rust: self.converted.fetch_add(1, Ordering::Relaxed);
}
pub fn skipped(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.skipped.load(Ordering::Relaxed)
}
pub fn increment_skipped(self: *Self) void {
}
    // rust: self.skipped.fetch_add(1, Ordering::Relaxed);
}
pub fn set_dimension_progress(self: *Self, dimension: []const u8, progress: f32) void {
}
    // rust: if let Ok(mut map) = self.dimension_progress.lock() {
    // rust: map.insert(dimension.to_owned(), progress);
}
}
    /// `getDimensionProgress`: 0 for a dimension nothing was reported for.
pub fn dimension_progress(self: *Self, dimension: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.dimension_progress
    // rust: .lock()
    // rust: .ok()
    // rust: .and_then(|map| map.get(dimension).copied())
    // rust: .unwrap_or(0.0)
}
pub fn status(self: *Self) U {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.status.load(Ordering::Relaxed) {
    // rust: 1 => UpgradeStatus::Failed,
    // rust: 2 => UpgradeStatus::Finished,
    // rust: 3 => UpgradeStatus::Upgrading,
    // rust: _ => UpgradeStatus::Counting,
}
}
pub fn set_status(self: *Self, status: UpgradeStatus) void {
}
    // rust: let code = match status {
    // rust: UpgradeStatus::Counting => 0,
    // rust: UpgradeStatus::Failed => 1,
    // rust: UpgradeStatus::Finished => 2,
    // rust: UpgradeStatus::Upgrading => 3,
}
    // rust: self.status.store(code, Ordering::Relaxed);
}
pub fn data_fix_type(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.data_fix_type.load(Ordering::Relaxed) {
    // rust: 1 => Some(UpgradeDataFixType::Chunk),
    // rust: 2 => Some(UpgradeDataFixType::EntityChunk),
    // rust: 3 => Some(UpgradeDataFixType::PoiChunk),
    // rust: _ => None,
}
}
    /// `reset(DataFixTypes)`: the counts of the next data type start over.
pub fn reset(self: *Self, data_fix_type: UpgradeDataFixType) void {
}
    // rust: self.total.reset();
    // rust: self.of_type.reset();
    // rust: self.total_chunks.store(0, Ordering::Relaxed);
    // rust: self.converted.store(0, Ordering::Relaxed);
    // rust: self.skipped.store(0, Ordering::Relaxed);
    // rust: let code = match data_fix_type {
    // rust: UpgradeDataFixType::Chunk => 1,
    // rust: UpgradeDataFixType::EntityChunk => 2,
    // rust: UpgradeDataFixType::PoiChunk => 3,
}
    // rust: self.data_fix_type.store(code, Ordering::Relaxed);
}
pub fn set_file_fixing(self: *Self) void {
}
    // rust: self.file_fixing.store(true, Ordering::Relaxed);
}
pub fn is_file_fixing(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.file_fixing.load(Ordering::Relaxed)
}
}

    // rust: mod tests {
//     use super::*;

pub fn stats_follow_the_operations_and_the_type_starts_over() void {
}
    // rust: let p = UpgradeProgress::new();
    // rust: assert_eq!(p.total_file_fix_stats().progress(), 0.0);
    // rust: p.set_type(UpgradeType::Files);
    // rust: p.add_total_file_fix_operations(4);
    // rust: p.increment_finished_operations();
    // rust: assert_eq!(p.total_file_fix_stats().progress(), 0.25);
    // rust: p.set_type(UpgradeType::Regions);
    // rust: assert_eq!(p.type_file_fix_stats().total_operations(), 0);
    // rust: assert_eq!(p.total_file_fix_stats().total_operations(), 4);
    // rust: p.increment_finished_operations_by(9);
    // rust: assert_eq!(p.type_file_fix_stats().progress(), 0.0);
    // rust: assert_eq!(p.total_file_fix_stats().progress(), 1.0);
    // rust: assert_eq!(
    // rust: p.upgrade_type().unwrap().label_key(),
    // rust: "upgradeWorld.progress.type.regions"
    // rust: );
}
}
