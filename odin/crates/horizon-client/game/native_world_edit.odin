//! Transpiled from Horizon Rust crate
package horizon_client_native_world_edit

import "core:fmt"
import "core:mem"
import "core:math"

// Bulk block edits for server mods: a helper on the level being ticked, as `native_set_block` is, that makes many
// runs of blocks up columns at once, straight into the chunks.
// use super::Game;

// Which of a column's heights (`Heightmap.Types`) a run's `y` counts from.
NativeHeightmap :: enum {
    WorldSurface,
    MotionBlocking,
    MotionBlockingNoLeaves,
    OceanFloor,
}
// A run: `height` blocks up a column from `y` (from the column's `surface` height when one is
// given), set to palette entry `block`, only where filter `only` matches when one is given.
NativeBlockRun :: struct {
    x: i32,
    z: i32,
    y: i32,
    height: u32,
    surface: Maybe(NativeHeightmap),
    block: u32,
    only: Maybe(u32),
}
// A bulk edit: block states and block predicates as commands write them (without NBT), and the runs naming them
// by index.
NativeBlockEdit :: struct {
    palette: [dynamic]string,
    filters: [dynamic]string,
    runs: [dynamic]NativeBlockRun,
}

    // rust: impl Game<'_> {
    // For a server mod: the runs made at once, straight into the chunks of the authoritative level `dimension`
    // (the one being ticked, as for `native_set_block`), with what `fill ... strict` does for block entities (a
    // block replaced by another loses its block entity, and a new block gets the one `native_set_block` would
    // give it, a mod block's included); no neighbour is told, and the chunks changed go to the players whole.
    // Runs in chunks not loaded, and the parts of runs outside the column, are left out. The blocks changed, or
    // why the edit was left out, with nothing changed: another dimension, a client of a server, a palette entry
    // or filter that doesn't read or carries NBT (refused), a run naming a palette entry or filter past the end,
    // or more than 65536 filters. API 126.
    // rust: pub(super) fn native_edit_blocks(
    // rust: &mut self,
    // rust: dimension: &str,
    // rust: edit: &NativeBlockEdit,
    // rust: ) -> Result<u64, String> {
    // rust: if !self.native_level_open(dimension) {
    // rust: return Err(format!("{dimension} is not the level being ticked"));
}
    // rust: let started = std::time::Instant::now();
    // rust: let changed = self.edit_blocks(edit)?;
    // rust: let ms = started.elapsed().as_secs_f32() * 1000.0;
    // rust: if self.options.spikes.is_some_and(|threshold| ms > threshold) {
    // rust: log::info!(
    // rust: "Horizon: slow mod block edit {ms:.1} ms ({} runs, {changed} blocks)",
    // rust: edit.runs.len()
    // rust: );
}
    // rust: Ok(changed)
}
    // Whether `dimension` is the authoritative level being ticked: where a server mod's world helpers act.
    // rust: pub(super) fn native_level_open(&self, dimension: &str) -> bool {
    // rust: (self.serving.is_some() || self.options.dedicated.is_some()) && dimension == self.dim.id()
}
}
