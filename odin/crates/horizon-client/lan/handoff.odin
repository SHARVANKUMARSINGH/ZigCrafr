//! Transpiled from Horizon Rust crate
package horizon_client_handoff

import "core:fmt"
import "core:mem"
import "core:math"

// Sections a single-player server thread sends its own window, shared
// instead of copied. The server and the window each held every column they
// both see: the server its level, the window what the chunk packets decoded
// to, the same blocks, biomes and light. When the server sends a column to a
// player on its memory connection it offers the column's sections here, as
// `Weak` references; the window's decoder takes each one whose blocks,
// biomes and light are the same as what it decoded, and drops its own copy.
//
// Nothing changes what either side sees. The packet is still sent and
// decoded, and a section is taken only when it equals the decoded one. A
// `Weak` keeps no section alive, and a server edit to an offered section
// moves it (`Arc::make_mut`), which the window's `Weak` no longer reaches;
// once taken, a section either side edits is copied for that side alone.
//
// The server also hands its window the columns it changed in bulk (`World::edit_runs`) without sending them: ones
// the window doesn't hold, whose far terrain still draws them as the window last saw them (`changed`,
// `take_changed`).
// use crate::chunk::{Chunk, Section};
// use crate::fast_hash::FxHashMap;
// use std::sync::{Arc, Mutex, Weak};

// Columns offered and not taken yet before the dead ones are swept.
SWEEP :: 1 << 13

Offer :: struct {
    // The minimum block Y of `sections[0]`.
    min_y: i32,
    sections: [dynamic]Weak<Section>,
}

OFFERED :: Mutex::new(None)

// Columns changed in bulk and not sent to the window, the latest of each, until the window takes them.
CHANGED :: Mutex::new(None)
// The most columns waiting for the window: past them the later changes are left out (a window that stopped
// taking them, as a server with no window of its own never does, holds no more than this).
CHANGED_MAX :: 1 << 13

// The server changed `chunk` in bulk and didn't send it to the player on its memory connection: the window's far
// terrain is to summarize it again.
changed :: proc(chunk: ^^Chunk) {
}
    // rust: let Ok(mut changed) = CHANGED.lock() else {
    // rust: return;
}
    // rust: let changed = changed.get_or_insert_with(Default::default);
    // rust: let key = (chunk.x, chunk.z);
    // rust: if changed.len() < CHANGED_MAX || changed.contains_key(&key) {
    // rust: changed.insert(key, chunk.clone());
}
}

// The columns changed in bulk since the window last asked (`changed`), each once, as it was last changed.
take_changed :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: match CHANGED.lock() {
    // rust: Ok(mut changed) => changed
    // rust: .take()
    // rust: .map(|c| c.into_values().collect())
    // rust: .unwrap_or_default(),
    // rust: Err(_) => Vec::new(),
}
}

// The server sends `chunk` to a player on its memory connection.
offer :: proc(chunk: ^Chunk) {
}
    // rust: let Ok(mut offered) = OFFERED.lock() else {
    // rust: return;
}
    // rust: let offered = offered.get_or_insert_with(Default::default);
    // rust: if offered.len() >= SWEEP {
    // rust: offered.retain(|_, o| o.sections.iter().any(|w| w.strong_count() > 0));
    // rust: if offered.len() >= SWEEP / 2 {
    // rust: offered.clear();
}
}
    // rust: offered.insert(
    // rust: (chunk.x, chunk.z),
    // rust: Offer {
    // rust: min_y: chunk.min_y(),
    // rust: sections: chunk.sections.iter().map(Arc::downgrade).collect(),
    // rust: },
    // rust: );
}

// The window decoded `chunk` from a packet: each of its sections the same
// as the server's offered one at that height becomes the server's. Returns
// how many did.
take :: proc(chunk: ^Chunk) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let offer = match OFFERED.lock() {
    // rust: Ok(mut offered) => offered.as_mut().and_then(|o| o.remove(&(chunk.x, chunk.z))),
    // rust: Err(_) => None,
}
    // rust: let Some(offer) = offer else {
    // rust: return 0;
}
    // rust: let offset = (chunk.min_y() - offer.min_y) >> 4;
    // rust: let mut taken = 0;
    // rust: for (i, section) in chunk.sections.iter_mut().enumerate() {
    // rust: let Some(theirs) = usize::try_from(i as i32 + offset)
    // rust: .ok()
    // rust: .and_then(|j| offer.sections.get(j))
    // rust: .and_then(Weak::upgrade)
    // rust: else {
    // rust: continue;
}
    // rust: if Arc::ptr_eq(section, &theirs) {
    // rust: continue;
}
    // rust: if theirs.same_as(section) {
    // rust: *section = theirs;
    // rust: taken += 1;
}
}
    // rust: taken
}

    // rust: mod tests {
//     use super::*;
//     use crate::chunk::{Light, MIN_Y};

column :: proc(x: i32) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut chunk = Chunk::empty(x, 7);
    // rust: chunk.set(1, MIN_Y + 3, 2, 5);
    // rust: chunk.set(4, 70, 4, 9);
    // rust: Arc::make_mut(&mut chunk.sections[2]).light =
    // rust: Light::packed(Box::new(std::array::from_fn(|i| {
    // rust: if i % 3 == 0 { 0xF2 } else { 0x70 }
    // rust: })));
    // rust: chunk
}

equal_sections_are_shared_and_edits_stay_apart :: proc() {
}
    // rust: let server = column(901);
    // rust: offer(&server);
    // rust: let mut window = column(901);
    // rust: let taken = take(&mut window);
        // The two edited sections and the lit one; the uniform ones were
        // already the same shared allocation.
    // rust: assert_eq!(taken, 3);
    // rust: for (a, b) in server.sections.iter().zip(&window.sections) {
    // rust: assert!(Arc::ptr_eq(a, b));
}
    // rust: let mut edited = window.clone();
    // rust: edited.set(1, MIN_Y + 3, 2, 6);
    // rust: assert_eq!(server.get(1, MIN_Y + 3, 2), 5);
    // rust: assert_eq!(edited.get(1, MIN_Y + 3, 2), 6);
        // Taken once: a second decode of the column has nothing to take.
    // rust: assert_eq!(take(&mut column(901)), 0);
}

differing_or_edited_sections_are_kept :: proc() {
}
    // rust: let mut server = column(902);
    // rust: offer(&server);
        // Edited after the offer: the server's section moved.
    // rust: server.set(1, MIN_Y + 3, 2, 8);
    // rust: let mut window = column(902);
    // rust: window.set(4, 70, 4, 10);
    // rust: let taken = take(&mut window);
        // Only the lit section is still the same on both sides.
    // rust: assert_eq!(taken, 1);
    // rust: assert_eq!(window.get(1, MIN_Y + 3, 2), 5);
    // rust: assert_eq!(window.get(4, 70, 4), 10);
}

columns_changed_unsent_are_taken_once_as_last_changed :: proc() {
}
    // rust: let first = Arc::new(column(903));
    // rust: let mut again = column(903);
    // rust: again.set(1, MIN_Y + 3, 2, 9);
    // rust: let other = Arc::new(column(904));
    // rust: changed(&first);
    // rust: changed(&other);
    // rust: changed(&Arc::new(again));
    // rust: let mut taken = take_changed();
    // rust: taken.sort_by_key(|c| (c.x, c.z));
    // rust: assert_eq!(taken.len(), 2);
    // rust: assert_eq!(
    // rust: taken[0].get(1, MIN_Y + 3, 2),
    // rust: 9,
    // rust: "the column as it was last changed"
    // rust: );
    // rust: assert!(Arc::ptr_eq(&taken[1], &other));
    // rust: assert!(take_changed().is_empty(), "taken once");
}
}
