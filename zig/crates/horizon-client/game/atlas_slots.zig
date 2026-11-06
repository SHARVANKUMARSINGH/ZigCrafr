//! Transpiled from Horizon Rust crate
//! Module: horizon-client_atlas_slots
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The GUI atlas's fixed slots for runtime images (`horizon/skin{N}`,
//! `horizon/map{N}`): which image each slot holds, least recently shown
//! first. A new atlas (a resource pack reload) has every slot blank, so the
//! table is forgotten with it and each image uploads again.

    // rust: pub(super) struct AtlasSlots<K> {
    // rust: count: usize,
    /// (image, slot), most recently shown last.
    // rust: held: Vec<(K, usize)>,
}

    // rust: impl<K: PartialEq> AtlasSlots<K> {
    // rust: pub(super) fn new(count: usize) -> Self {
    // rust: Self {
    // rust: count,
    // rust: held: Vec::new(),
}
}
    /// The slot holding `key`, marking it recently shown.
    // rust: pub(super) fn show<Q: PartialEq + ?Sized>(&mut self, key: &Q) -> Option<usize>
    // rust: where
    // rust: K: std::borrow::Borrow<Q>,
    // rust: {
    // rust: let i = self.held.iter().position(|e| e.0.borrow() == key)?;
    // rust: let e = self.held.remove(i);
    // rust: let slot = e.1;
    // rust: self.held.push(e);
    // rust: Some(slot)
}
    /// A slot for `key`: a free one, else the least recently shown, returned
    /// with the image it held.
    // rust: pub(super) fn claim(&mut self, key: K) -> (usize, Option<K>) {
    // rust: let (slot, evicted) = if self.held.len() < self.count {
    // rust: (self.held.len(), None)
    // rust: } else {
    // rust: let (old, slot) = self.held.remove(0);
    // rust: (slot, Some(old))
}
    // rust: self.held.push((key, slot));
    // rust: (slot, evicted)
}
    /// The atlas was replaced: every slot is blank.
    // rust: pub(super) fn forget(&mut self) {
    // rust: self.held.clear();
}
}

    // rust: mod tests {
//     use super::*;

pub fn the_least_recently_shown_image_gives_up_its_slot() void {
}
    // rust: let mut slots = AtlasSlots::new(2);
    // rust: assert_eq!(slots.claim("a"), (0, None));
    // rust: assert_eq!(slots.claim("b"), (1, None));
    // rust: assert_eq!(slots.show(&"a"), Some(0));
    // rust: assert_eq!(slots.claim("c"), (1, Some("b")));
    // rust: assert_eq!(slots.show(&"b"), None);
}

pub fn a_new_atlas_shows_no_stored_skin() void {
}
        // #3385: a skin stored before a pack reload must upload again, not
        // name a sprite the new atlas does not have.
    // rust: let mut slots = AtlasSlots::new(4);
    // rust: slots.claim("skins/abc".to_string());
    // rust: assert_eq!(slots.show("skins/abc"), Some(0));
    // rust: slots.forget();
    // rust: assert_eq!(slots.show("skins/abc"), None);
    // rust: assert_eq!(slots.claim("skins/abc".to_string()), (0, None));
}
}
