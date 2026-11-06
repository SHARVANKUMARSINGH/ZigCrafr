//! Transpiled from Horizon Rust crate
package horizon_client_structures

import "core:fmt"
import "core:mem"
import "core:math"

// Which structures contain a position (`StructureManager.getStructureAt`
// and `getStructureWithPieceAt`), from the chunk's structure references and
// the generator's cached starts.
// use super::Game;

    // rust: impl Game<'_> {
    // Structures reaching `pos`: (id, inside a piece). `getStructureAt`
    // tests the start's whole box, `getStructureWithPieceAt` a piece's.
    // rust: pub(super) fn structures_reaching(&self, pos: [i32; 3]) -> Vec<(String, bool)> {
    // rust: self.structures_reaching_where(pos, &|_| true)
}
    // The same, for the structures whose id `wanted` takes: the others'
    // starts aren't looked up.
    // rust: pub(super) fn structures_reaching_where(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: wanted: &dyn Fn(&str) -> bool,
    // rust: ) -> Vec<(String, bool)> {
    // rust: let Some(chunk) = self.world.chunks.get(&(pos[0] >> 4, pos[2] >> 4)) else {
    // rust: return Vec::new();
}
    // rust: if chunk.structure_refs.is_empty() {
    // rust: return Vec::new();
}
    // rust: let Some(locator) = self.end.locator() else {
    // rust: return Vec::new();
}
    // rust: let mut out: Vec<(String, bool)> = Vec::new();
    // rust: for (id, (sx, sz)) in &chunk.structure_refs {
    // rust: if !wanted(id) {
    // rust: continue;
}
    // rust: for start in locator.starts_at(*sx, *sz) {
    // rust: if *start.name != **id || !start.bounding_box.is_inside(pos) {
    // rust: continue;
}
    // rust: let piece = start.pieces.iter().any(|p| p.bounding_box().is_inside(pos));
    // rust: match out.iter_mut().find(|(n, _)| *n == start.name) {
    // rust: Some(e) => e.1 |= piece,
    // rust: None => out.push((start.name.clone(), piece)),
}
}
}
    // rust: out
}
    // The structures with a piece containing `pos`.
    // rust: pub(super) fn structures_at(&self, pos: [i32; 3]) -> Vec<String> {
    // rust: self.structures_reaching(pos)
    // rust: .into_iter()
    // rust: .filter(|(_, piece)| *piece)
    // rust: .map(|(n, _)| n)
    // rust: .collect()
}
}
