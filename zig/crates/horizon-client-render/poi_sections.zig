//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_poi_sections
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The points of interest of each resident section (`PoiSection`), so a
//! search visits the few POI blocks of the sections in range instead of
//! reading every block of them.
//!
//! Vanilla keeps its records up to date from `onBlockStateChange`; here a
//! section's list is rebuilt from its blocks after any edit. Resident
//! sections are immutable behind `Arc` and edited through `Arc::make_mut`, so
//! a weak reference tells an edited or replaced section from the one the list
//! was built from (see `random_tick_sections`), without keeping its blocks.
// use crate::{chunk::Section, fast_hash::FxHashMap};
// use std::sync::{Arc, Mutex, Weak};

/// A section's POIs: the block index in the section (`y << 8 | z << 4 | x`)
/// and its kind, in ascending index order.
    // rust: pub type SectionPois<T> = Arc<[(u16, T)]>;

pub const Cached = struct {
    section: Weak<Section>,
    pois: SectionPois<T>,
};
/// Cached POI lists by section, `(chunk x, section index, chunk z)`.
pub const PoiSections = struct {
    sections: Mutex<Lists<T>>,
};
pub const Lists = struct {
    by_section: FxHashMap<(i32,
    /// Size above which lists of sections no longer resident are dropped.
    prune_at: usize,
};
pub const MIN_PRUNE: usize = 4096;
    // rust: impl<T> Default for PoiSections<T> {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: sections: Mutex::new(Lists {
    // rust: by_section: FxHashMap::default(),
    // rust: prune_at: MIN_PRUNE,
    // rust: }),
}
}
}
    // rust: impl<T: Copy> PoiSections<T> {
    /// The POIs of `section`, whose block states `kind` classifies. `kind`
    /// must give the same answer for a state on every call.
    // rust: pub fn get(
    // rust: &self,
    // rust: key: (i32, i32, i32),
    // rust: section: &Arc<Section>,
    // rust: mut kind: impl FnMut(u32) -> Option<T>,
    // rust: ) -> SectionPois<T> {
    // rust: let mut lists = self.sections.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some(cached) = lists.by_section.get(&key)
    // rust: && cached.section.as_ptr() == Arc::as_ptr(section)
    // rust: {
    // rust: return cached.pois.clone();
}
    // rust: let pois: SectionPois<T> = if section.blocks.maybe_has(|v| kind(v).is_some()) {
    // rust: let mut states = [0u32; 4096];
    // rust: section.unpack(&mut states);
    // rust: states
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, &state)| kind(state).map(|poi| (i as u16, poi)))
    // rust: .collect()
    // rust: } else {
    // rust: Arc::from([])
}
    // rust: if lists.by_section.len() >= lists.prune_at {
    // rust: lists.by_section.retain(|_, c| c.section.strong_count() > 0);
    // rust: lists.prune_at = (lists.by_section.len() * 2).max(MIN_PRUNE);
}
    // rust: lists.by_section.insert(
    // rust: key,
    // rust: Cached {
    // rust: section: Arc::downgrade(section),
    // rust: pois: pois.clone(),
    // rust: },
    // rust: );
    // rust: pois
}
}

/// The POI types villagers use.
pub const Poi = enum {
    /// A job site, by profession index.
    Job(u8),
    Home,
    Meeting,
};
    // rust: impl Poi {
    /// `PoiType.maxTickets`.
pub fn max_tickets(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Poi::Meeting => 32,
    // rust: _ => 1,
}
}
    /// `PoiType.validRange`.
pub fn valid_range(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Poi::Meeting => 6,
    // rust: _ => 1,
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::chunk::{Chunk, MIN_Y};

pub fn lists_follow_edits_and_replacement() void {
}
    // rust: let index = PoiSections::<u8>::default();
    // rust: let kind = |v: u32| (v == 5 || v == 6).then_some(v as u8);
    // rust: let mut chunk = Arc::new(Chunk::empty(0, 0));
    // rust: assert!(index.get((0, 0, 0), &chunk.sections[0], kind).is_empty());
    // rust: Arc::make_mut(&mut chunk).set(3, MIN_Y + 2, 1, 6);
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y, 0, 5);
    // rust: let found = index.get((0, 0, 0), &chunk.sections[0], kind);
    // rust: assert_eq!(&*found, &[(0, 5), (2 << 8 | 1 << 4 | 3, 6)]);
        // Unchanged: the cached list, not a rescan.
    // rust: let again = index.get((0, 0, 0), &chunk.sections[0], |_| panic!("rescanned"));
    // rust: assert!(Arc::ptr_eq(&found, &again));
        // An edit in place (no other owner) still invalidates the list.
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y, 0, 1);
    // rust: assert_eq!(
    // rust: &*index.get((0, 0, 0), &chunk.sections[0], kind),
    // rust: &[(2 << 8 | 1 << 4 | 3, 6)]
    // rust: );
        // So does replacing the section, or the chunk.
    // rust: Arc::make_mut(&mut chunk).sections[0] = Arc::new(Section::default());
    // rust: assert!(index.get((0, 0, 0), &chunk.sections[0], kind).is_empty());
    // rust: let mut other = Chunk::empty(0, 0);
    // rust: other.set(1, MIN_Y, 1, 5);
    // rust: chunk = Arc::new(other);
    // rust: assert_eq!(
    // rust: &*index.get((0, 0, 0), &chunk.sections[0], kind),
    // rust: &[(1 << 4 | 1, 5)]
    // rust: );
        // An unused palette entry alone yields no POI.
    // rust: Arc::make_mut(&mut chunk).set(1, MIN_Y, 1, 2);
    // rust: assert!(index.get((0, 0, 0), &chunk.sections[0], kind).is_empty());
}

pub fn unloaded_sections_are_dropped() void {
}
    // rust: let index = PoiSections::<u8>::default();
    // rust: let kind = |v: u32| (v == 5).then_some(5);
    // rust: let kept = Arc::new(Section::default());
    // rust: index.get((0, 0, 0), &kept, kind);
    // rust: for i in 0..MIN_PRUNE as i32 {
    // rust: index.get((1, i, 0), &Arc::new(Section::default()), kind);
}
    // rust: let lists = index.sections.lock().unwrap();
    // rust: assert!(lists.by_section.len() <= 2);
    // rust: assert!(lists.by_section.contains_key(&(0, 0, 0)));
}
}
