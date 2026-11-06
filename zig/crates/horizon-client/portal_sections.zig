//! Transpiled from Horizon Rust crate
//! Module: horizon-client_portal_sections
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Memoized nether-portal palette eligibility per resident chunk.
//!
//! `Game::find_entity_portals` asks the same sections every tick whether their
//! palette may hold a portal state. The answer only changes when a chunk's
//! blocks change, so it is kept per chunk until the weak handle stops matching.
// use crate::{chunk::Chunk, fast_hash::FxHashMap, section_mask::SectionMask};
// use std::sync::{Arc, Weak};

pub const Cached = struct {
    chunk: Weak<Chunk>,
    /// The sections whose palette may hold a portal.
    sections: SectionMask,
};

/// Resident chunks are immutable behind `Arc`; edits use `Arc::make_mut`.
/// A weak reference detects both edits and replacement, without retaining block
/// data or forcing a deep copy on the next edit. It also prevents address reuse.
/// Clear this cache whenever the gameplay facts change (including resource reload).
pub const PortalSections = struct {
    chunks: FxHashMap<(i32,
};

    // rust: impl PortalSections {
pub fn clear(self: *Self) void {
}
    // rust: self.chunks.clear();
}
pub fn remove(self: *Self, key: *(i32) void {
}
    // rust: self.chunks.remove(key);
}
    /// The sections of `chunk` whose palette may hold a portal, by index
    /// (`MIN_Y`'s section is 0). `portal` is only called while
    /// (re)building an entry, so an unchanged chunk scans its palette once.
    // rust: pub fn get(
    // rust: &mut self,
    // rust: key: (i32, i32),
    // rust: chunk: &Arc<Chunk>,
    // rust: mut portal: impl FnMut(u32) -> bool,
    // rust: ) -> SectionMask {
    // rust: let cached = self.chunks.entry(key).or_insert_with(|| Cached {
    // rust: chunk: Weak::new(),
    // rust: sections: SectionMask::EMPTY,
    // rust: });
    // rust: if cached.chunk.as_ptr() != Arc::as_ptr(chunk) {
            // Preserve maybe_has, including unused entries and global palettes.
    // rust: cached.sections = chunk
    // rust: .sections
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, section)| section.blocks.maybe_has(&mut portal))
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: cached.chunk = Arc::downgrade(chunk);
}
    // rust: cached.sections
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::chunk::{MIN_Y, SECTIONS, Section};

pub fn edits_replacements_compaction_and_reload() void {
}
    // rust: let mut cache = PortalSections::default();
    // rust: let mut chunk = Arc::new(Chunk::empty(0, 0));
    // rust: assert_eq!(cache.get((0, 0), &chunk, |id| id == 7), SectionMask::EMPTY);
    // rust: cache.get((0, 0), &chunk, |_| panic!("unchanged chunk rescanned"));
    // rust: let worker = chunk.clone();
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y, 0, 7);
    // rust: assert_eq!(
    // rust: cache.get((0, 0), &chunk, |id| id == 7),
    // rust: SectionMask::single(0)
    // rust: );
    // rust: assert_eq!(worker.get(0, MIN_Y, 0), 0);
        // Even after the last portal block is removed, its unused palette entry counts.
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y, 0, 0);
    // rust: assert_eq!(
    // rust: cache.get((0, 0), &chunk, |id| id == 7),
    // rust: SectionMask::single(0)
    // rust: );
    // rust: Arc::make_mut(&mut Arc::make_mut(&mut chunk).sections[0]).compact();
    // rust: assert_eq!(cache.get((0, 0), &chunk, |id| id == 7), SectionMask::EMPTY);
    // rust: Arc::make_mut(&mut chunk).sections[SECTIONS - 1] = Arc::new(Section::default());
    // rust: cache.clear(); // resource reload, with changed facts for the same state IDs
    // rust: assert_eq!(
    // rust: cache.get((0, 0), &chunk, |id| id == 0),
    // rust: SectionMask::below(SECTIONS),
    // rust: "a fresh palette is rescanned for every section"
    // rust: );
    // rust: cache.remove(&(0, 0));
    // rust: assert!(cache.chunks.is_empty());
}

pub fn replacement_at_same_coordinates_and_early_snapshot() void {
}
    // rust: let mut cache = PortalSections::default();
    // rust: let mut chunk = Arc::new(Chunk::empty(-2, 3));
    // rust: let before = cache.get((-2, 3), &chunk, |id| id == 1);
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y + 16, 0, 1);
    // rust: assert_eq!(before, SectionMask::EMPTY);
    // rust: assert_eq!(
    // rust: cache.get((-2, 3), &chunk, |id| id == 1),
    // rust: SectionMask::single(1)
    // rust: );
    // rust: let weak = Arc::downgrade(&chunk);
    // rust: drop(chunk);
    // rust: assert!(weak.upgrade().is_none()); // cache does not retain unloaded block data
    // rust: let replacement = Arc::new(Chunk::empty(-2, 3));
    // rust: assert_eq!(
    // rust: cache.get((-2, 3), &replacement, |id| id == 1),
    // rust: SectionMask::EMPTY
    // rust: );
}

pub fn global_palette_covers_the_whole_id_range() void {
}
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for i in [0, 9, SECTIONS - 1] {
    // rust: Arc::make_mut(&mut chunk.sections[i]).blocks =
    // rust: Section::from_blocks(&std::array::from_fn(|j| (j % 300) as u32));
}
    // rust: let chunk = Arc::new(chunk);
    // rust: let mut cache = PortalSections::default();
        // Global maybe_has considers the entire ID range, including absent states.
    // rust: assert_eq!(
    // rust: cache.get((0, 0), &chunk, |id| id == 40000),
    // rust: SectionMask::from_iter([0, 9, SECTIONS - 1])
    // rust: );
}
}
