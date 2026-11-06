//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_biome_colors
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Biome colours a client mod changes (`native_biome_colors`), for seasons:
//! the grass, foliage, dry foliage and water tints the mesher blends, as a
//! resource pack's colormaps and biome effects set them, changed while the
//! game runs.

// use super::Game;
// use std::sync::Arc;

// Native mods call it; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// Asks `native_biome_colors` again for every biome and, when the colours
    /// differ from those in use, rebuilds every loaded section and the far
    /// terrain with them (`LevelRenderer.allChanged`, as changing Biome Blend
    /// does). Call it when your colours change (a new season, a new day of a
    /// slow fade) and once when the player joins, not every frame: a rebuild
    /// takes the workers a few seconds. API 107.
    // rust: pub(super) fn native_refresh_biome_colors(&mut self) {
        // A world's own table is asked from the biome files' colours each
        // time, so a mod's colours do not stack; a plain world's is the pack's.
    // rust: if let (Some(base), Some(current)) = (&self.world_biomes_base, &self.world_biomes) {
    // rust: let Some(biomes) = base.recolored_from(current, |biome, colors| {
    // rust: self.native_biome_colors(biome, colors)
    // rust: }) else {
    // rust: return;
}
    // rust: self.world_biomes = Some(Arc::new(biomes));
    // rust: } else {
    // rust: let base = self.res.biomes().clone();
    // rust: let biomes = base
    // rust: .with_colors(|biome, colors| self.native_biome_colors(biome, colors))
    // rust: .map_or_else(|| base.clone(), Arc::new);
    // rust: if Arc::ptr_eq(&biomes, &self.pack.context.biomes) {
    // rust: return;
}
    // rust: self.pack.context = self.pack.context_with(biomes);
}
    // rust: let context = self.worker_context();
    // rust: self.clear_lod();
    // rust: self.streaming.reload_resources(&mut self.world, context);
}
}
