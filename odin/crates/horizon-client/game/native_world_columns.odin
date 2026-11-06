//! Transpiled from Horizon Rust crate
package horizon_client_native_world_columns

import "core:fmt"
import "core:mem"
import "core:math"

// Column reads for server mods, as helpers on the level being ticked: many columns' heights, and the blocks round
// them, in one call.
// use super::Game;
// use super::block_edits::MAX_COLUMNS;
// use super::native_world_edit::NativeHeightmap;

// What `native_read_columns` read: the blocks round each column's height (`bases`, none where it isn't loaded),
// as indexes into `palette`, a column after another, and three biome tints a column (grass, foliage, water).
NativeColumnBlocks :: struct {
    palette: [dynamic]string,
    bases: [dynamic]Maybe(i32),
    blocks: [dynamic]u16,
    tints: [dynamic]u32,
}

    // rust: impl Game<'_> {
    // For a server mod: each column's height by `heightmap` in the authoritative level `dimension` (the one being
    // ticked), none for a column not loaded. `Err` says why nothing was read: another dimension or a client of a
    // server, or more than 65,536 columns (`MAX_COLUMNS`). API 127.
    // rust: pub(super) fn native_surface_heights(
    // rust: &self,
    // rust: dimension: &str,
    // rust: columns: &[(i32, i32)],
    // rust: heightmap: NativeHeightmap,
    // rust: ) -> Result<Vec<Option<i32>>, String> {
    // rust: if !self.native_level_open(dimension) {
    // rust: return Err(format!("{dimension} is not the level being ticked"));
}
    // rust: if columns.len() > MAX_COLUMNS {
    // rust: return Err(format!(
    // rust: "{} columns, more than {MAX_COLUMNS} a call",
    // rust: columns.len()
    // rust: ));
}
    // rust: let started = std::time::Instant::now();
    // rust: let out = self.surface_heights(columns, heightmap);
    // rust: self.native_read_logged(started, "height query", columns.len());
    // rust: Ok(out)
}
    // For a server mod: `below` blocks under and `above` blocks from each column's height by `heightmap`, as a
    // palette and indexes, with the biome's grass, foliage and water tints (air outside the column and in columns
    // not loaded). The tints are the biome's at the column's top, not blended over the biome blend radius as the
    // game draws them: near a biome border they can differ from what players see. `Err` says why nothing was
    // read: another dimension or a client of a server, `below + above` of 0 or more than the level's height, or
    // a read of more than 1,048,576 blocks (`MAX_READ`; it runs on the server tick, so read big areas in pieces).
    // API 127.
    // rust: pub(super) fn native_read_columns(
    // rust: &self,
    // rust: dimension: &str,
    // rust: columns: &[(i32, i32)],
    // rust: heightmap: NativeHeightmap,
    // rust: range: (u32, u32),
    // rust: ) -> Result<NativeColumnBlocks, String> {
    // rust: let (below, above) = range;
    // rust: if !self.native_level_open(dimension) {
    // rust: return Err(format!("{dimension} is not the level being ticked"));
}
    // rust: let started = std::time::Instant::now();
    // rust: let out = self.read_columns(columns, heightmap, below, above)?;
    // rust: self.native_read_logged(started, "column read", columns.len());
    // rust: Ok(out)
}
    // A read's time logged with `HORIZON_SPIKES`, as an edit's is.
native_read_logged :: proc(self: ^Self, started: std::time::Instant, what: string, columns: uint) {
}
    // rust: let ms = started.elapsed().as_secs_f32() * 1000.0;
    // rust: if self.options.spikes.is_some_and(|threshold| ms > threshold) {
    // rust: log::info!("Horizon: slow mod {what} {ms:.1} ms ({columns} columns)");
}
}
}
