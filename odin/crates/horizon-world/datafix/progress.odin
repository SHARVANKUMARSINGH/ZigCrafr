//! Transpiled from Horizon Rust crate
package horizon_world_progress

import "core:fmt"
import "core:mem"
import "core:math"

// `net.minecraft.util.worldupdate.UpgradeProgress`: what a world upgrade has
// done so far, read by `FileFixerProgressScreen` while another thread works.
// use std::collections::HashMap;
// use std::sync::Mutex;
// use std::sync::atomic::{AtomicBool, AtomicI32, AtomicU8, AtomicU32, Ordering};

// `UpgradeProgress.FileFixStats`.
FileFixStats :: struct {
    finished_operations: AtomicI32,
    total_operations: AtomicI32,
}

    // rust: impl FileFixStats {
finished_operations :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.finished_operations.load(Ordering::Relaxed)
}
total_operations :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.total_operations.load(Ordering::Relaxed)
}
reset :: proc(self: ^Self) {
}
    // rust: self.finished_operations.store(0, Ordering::Relaxed);
    // rust: self.total_operations.store(0, Ordering::Relaxed);
}
    // `getProgress`: finished over total, 0 without operations, in 0..=1.
progress :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.total_operations() == 0 {
    // rust: 0.0
    // rust: } else {
    // rust: (self.finished_operations() as f32 / self.total_operations() as f32).clamp(0.0, 1.0)
}
}
}

// `UpgradeProgress.Type`.
UpgradeType :: enum {
    Files,
    LegacyStructures,
    Regions,
}

    // rust: impl UpgradeType {
    // `getSerializedName`.
serialized_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Files => "files",
    // rust: Self::LegacyStructures => "legacy_structures",
    // rust: Self::Regions => "regions",
}
}
    // The key of `label()`: `upgradeWorld.progress.type.` + the serialized name.
label_key :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("upgradeWorld.progress.type.{}", self.serialized_name())
}
code :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Files => 1,
    // rust: Self::LegacyStructures => 2,
    // rust: Self::Regions => 3,
}
}
}

// `UpgradeProgress`, as far as the file fixer's screen reads it.
UpgradeProgress :: struct {
    total: FileFixStats,
    of_type: FileFixStats,
    running_fixer: FileFixStats,
    canceled: AtomicBool,
    // `UpgradeProgress.type`: 0 for none.
    ty: AtomicU8,
    // The upgrade runs the file fixers (`requiresFileFixing`), which is what
    // opens `FileFixerProgressScreen` (`WorldOpenFlows.upgradeAndOpenWorld`).
    file_fixing: AtomicBool,
    // What `WorldUpgrader` (Optimize World) adds.
    finished: AtomicBool,
    total_progress: AtomicU32,
    total_chunks: AtomicI32,
    converted: AtomicI32,
    skipped: AtomicI32,
    // `progressMap`: the dimension's id to its progress.
    dimension_progress: Mutex<HashMap<string,
    status: AtomicU8,
    // `dataFixType`: 0 for none.
    data_fix_type: AtomicU8,
}

// `UpgradeProgress.Status`.
UpgradeStatus :: enum {
    Counting,
    Failed,
    Finished,
    Upgrading,
}

// The `DataFixTypes` a `WorldUpgrader` run goes through.
UpgradeDataFixType :: enum {
    Chunk,
    EntityChunk,
    PoiChunk,
}

    // rust: impl UpgradeProgress {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::default()
}
total_file_fix_stats :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.total
}
type_file_fix_stats :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.of_type
}
running_file_fixer_stats :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.running_fixer
}
add_total_file_fix_operations :: proc(self: ^Self, additional: i32) {
}
    // rust: self.total
    // rust: .total_operations
    // rust: .fetch_add(additional, Ordering::Relaxed);
    // rust: self.of_type
    // rust: .total_operations
    // rust: .fetch_add(additional, Ordering::Relaxed);
}
increment_finished_operations :: proc(self: ^Self) {
}
    // rust: self.increment_finished_operations_by(1);
}
increment_finished_operations_by :: proc(self: ^Self, count: i32) {
}
    // rust: self.total
    // rust: .finished_operations
    // rust: .fetch_add(count, Ordering::Relaxed);
    // rust: self.of_type
    // rust: .finished_operations
    // rust: .fetch_add(count, Ordering::Relaxed);
}
set_canceled :: proc(self: ^Self) {
}
    // rust: self.canceled.store(true, Ordering::Relaxed);
}
is_canceled :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.canceled.load(Ordering::Relaxed)
}
    // `setType`: the type's own stats start over.
set_type :: proc(self: ^Self, ty: UpgradeType) {
}
    // rust: self.ty.store(ty.code(), Ordering::Relaxed);
    // rust: self.of_type.reset();
}
upgrade_type :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.ty.load(Ordering::Relaxed) {
    // rust: 1 => Some(UpgradeType::Files),
    // rust: 2 => Some(UpgradeType::LegacyStructures),
    // rust: 3 => Some(UpgradeType::Regions),
    // rust: _ => None,
}
}
set_applicable_fixer_amount :: proc(self: ^Self, amount: i32) {
}
    // rust: self.running_fixer
    // rust: .total_operations
    // rust: .store(amount, Ordering::Relaxed);
}
increment_running_file_fixer :: proc(self: ^Self) {
}
    // rust: self.running_fixer
    // rust: .finished_operations
    // rust: .fetch_add(1, Ordering::Relaxed);
}
is_finished :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.finished.load(Ordering::Relaxed)
}
set_finished :: proc(self: ^Self, finished: bool) {
}
    // rust: self.finished.store(finished, Ordering::Relaxed);
}
total_progress :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f32::from_bits(self.total_progress.load(Ordering::Relaxed))
}
set_total_progress :: proc(self: ^Self, progress: f32) {
}
    // rust: self.total_progress
    // rust: .store(progress.to_bits(), Ordering::Relaxed);
}
total_chunks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.total_chunks.load(Ordering::Relaxed)
}
add_total_chunks :: proc(self: ^Self, additional: i32) {
}
    // rust: self.total_chunks.fetch_add(additional, Ordering::Relaxed);
}
converted :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.converted.load(Ordering::Relaxed)
}
increment_converted :: proc(self: ^Self) {
}
    // rust: self.converted.fetch_add(1, Ordering::Relaxed);
}
skipped :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.skipped.load(Ordering::Relaxed)
}
increment_skipped :: proc(self: ^Self) {
}
    // rust: self.skipped.fetch_add(1, Ordering::Relaxed);
}
set_dimension_progress :: proc(self: ^Self, dimension: string, progress: f32) {
}
    // rust: if let Ok(mut map) = self.dimension_progress.lock() {
    // rust: map.insert(dimension.to_owned(), progress);
}
}
    // `getDimensionProgress`: 0 for a dimension nothing was reported for.
dimension_progress :: proc(self: ^Self, dimension: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.dimension_progress
    // rust: .lock()
    // rust: .ok()
    // rust: .and_then(|map| map.get(dimension).copied())
    // rust: .unwrap_or(0.0)
}
status :: proc(self: ^Self) -> U {
    // Ported from Horizon
    return {}
}
    // rust: match self.status.load(Ordering::Relaxed) {
    // rust: 1 => UpgradeStatus::Failed,
    // rust: 2 => UpgradeStatus::Finished,
    // rust: 3 => UpgradeStatus::Upgrading,
    // rust: _ => UpgradeStatus::Counting,
}
}
set_status :: proc(self: ^Self, status: UpgradeStatus) {
}
    // rust: let code = match status {
    // rust: UpgradeStatus::Counting => 0,
    // rust: UpgradeStatus::Failed => 1,
    // rust: UpgradeStatus::Finished => 2,
    // rust: UpgradeStatus::Upgrading => 3,
}
    // rust: self.status.store(code, Ordering::Relaxed);
}
data_fix_type :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.data_fix_type.load(Ordering::Relaxed) {
    // rust: 1 => Some(UpgradeDataFixType::Chunk),
    // rust: 2 => Some(UpgradeDataFixType::EntityChunk),
    // rust: 3 => Some(UpgradeDataFixType::PoiChunk),
    // rust: _ => None,
}
}
    // `reset(DataFixTypes)`: the counts of the next data type start over.
reset :: proc(self: ^Self, data_fix_type: UpgradeDataFixType) {
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
set_file_fixing :: proc(self: ^Self) {
}
    // rust: self.file_fixing.store(true, Ordering::Relaxed);
}
is_file_fixing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.file_fixing.load(Ordering::Relaxed)
}
}

    // rust: mod tests {
//     use super::*;

stats_follow_the_operations_and_the_type_starts_over :: proc() {
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
