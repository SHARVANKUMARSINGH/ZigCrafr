//! Transpiled from Horizon Rust crate
//! Module: horizon-client_memory
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-ctl memory`: what holds the game's memory, by category. The
//! process's resident set and the allocator's committed bytes say how much;
//! the census of the client's columns, the integrated server's levels, the
//! renderer's bookkeeping and the GPU allocator's resources by label say
//! where it goes. Bytes the census doesn't reach show as the difference.
// use super::Game;
// use horizon_client::chunk::ColumnCensus;
// use horizon_client::fast_hash::FxHashSet;
// use horizon_client::world::World;
// use serde_json::{Value, json};
// use std::sync::Arc;

pub const MB: f64 = 1048576.0;

pub fn mb(bytes: impl TryInto<u64>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bytes: u64 = bytes.try_into().unwrap_or(0);
    // rust: (bytes as f64 / MB * 10.0).round() / 10.0
}

/// The columns of `worlds`, each section counted once however many columns
/// (or worlds) share it.
    // rust: fn census<'a>(worlds: impl IntoIterator<Item = &'a World>) -> ColumnCensus {
    // rust: let mut census = ColumnCensus::default();
    // rust: let mut seen = FxHashSet::default();
    // rust: for world in worlds {
    // rust: for chunk in world.chunks.values() {
    // rust: chunk.census(&mut census, &mut seen);
}
}
    // rust: census
}

pub fn census_json(c: *ColumnCensus) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({
    // rust: "total_mb": mb(c.total_bytes()),
    // rust: "columns": c.columns,
    // rust: "sections": c.sections,
    // rust: "unique_sections": c.unique_sections,
    // rust: "uniform_block_sections": c.uniform_block_sections,
    // rust: "light_arrays": c.light_arrays,
    // rust: "blocks_mb": mb(c.block_bytes),
    // rust: "biomes_mb": mb(c.biome_bytes),
    // rust: "light_mb": mb(c.light_bytes),
    // rust: "heightmaps_mb": mb(c.heightmap_bytes),
    // rust: "section_records_mb": mb(c.section_record_bytes),
    // rust: "column_records_mb": mb(c.column_bytes),
    // rust: })
}

/// The sections of `worlds` that are also in `others` (by address), and
/// their heap bytes: what one copy of them costs.
    // rust: fn shared<'a>(
    // rust: worlds: impl IntoIterator<Item = &'a World>,
    // rust: others: &FxHashSet<usize>,
    // rust: ) -> (usize, usize) {
    // rust: let mut seen = FxHashSet::default();
    // rust: let (mut count, mut bytes) = (0, 0);
    // rust: for world in worlds {
    // rust: for chunk in world.chunks.values() {
    // rust: for section in &chunk.sections {
    // rust: let at = Arc::as_ptr(section) as usize;
    // rust: if others.contains(&at) && seen.insert(at) {
    // rust: count += 1;
    // rust: bytes += section.heap_bytes();
}
}
}
}
    // rust: (count, bytes)
}

    // rust: impl Game<'_> {
pub fn all_worlds(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::iter::once(&self.world).chain(self.levels.parked_worlds())
}
    /// The census of this game's levels: the one in place and the parked ones.
pub fn level_census(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: census(self.all_worlds())
}
    /// The addresses of this game's sections.
pub fn section_addresses(self: *Self) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.all_worlds()
    // rust: .flat_map(|w| w.chunks.values())
    // rust: .flat_map(|c| c.sections.iter().map(|s| Arc::as_ptr(s) as usize))
    // rust: .collect()
}

    // rust: pub(super) fn memory_report(&self) -> Value {
    // rust: let (commit, peak_commit) = horizon_threads::allocator_commit();
    // rust: let client = self.level_census();
        // The single-player server thread's own levels: a second copy of the
        // columns both hold, unless they share sections.
    // rust: let server = self
    // rust: .integrated
    // rust: .as_ref()
    // rust: .and_then(|i| i.call(|g| (g.level_census(), g.section_addresses())));
        // The server thread's generation: proto chunks waiting for their
        // neighbours, and the light jobs' views of them.
    // rust: let generation = self.integrated.as_ref().and_then(|i| {
    // rust: i.call(|g| {
    // rust: let c = g.streaming.proto_census();
    // rust: let [blocks, lists, heightmaps, other, biomes, records] = c.bytes;
    // rust: json!({
    // rust: "protos": c.protos,
    // rust: "protos_mb": mb(c.bytes.iter().sum::<usize>()),
    // rust: "proto_blocks_mb": mb(blocks),
    // rust: "proto_section_lists_mb": mb(lists),
    // rust: "proto_heightmaps_mb": mb(heightmaps),
    // rust: "proto_other_terrain_mb": mb(other),
    // rust: "proto_biomes_mb": mb(biomes),
    // rust: "proto_records_mb": mb(records),
    // rust: "proto_sections_by_bits": c.sections_by_bits,
    // rust: "light_views": c.light_views,
    // rust: "light_views_mb": mb(c.light_view_bytes),
    // rust: "caches": c.caches.iter().map(|(name, n, bytes)| json!([name, n, bytes.map(mb)])).collect::<Vec<_>>(),
    // rust: "stages": g.streaming.stages().iter().map(|(k, v)| json!([k, v])).collect::<Vec<_>>(),
    // rust: })
    // rust: })
    // rust: });
        // The window's sections the server thread holds too (lan/handoff.rs).
    // rust: let shared = server.as_ref().map(|(_, at)| {
    // rust: let (sections, bytes) = shared(self.all_worlds(), at);
    // rust: json!({ "sections": sections, "mb": mb(bytes) })
    // rust: });
    // rust: let renderer = self.renderer.as_ref().map(|r| {
    // rust: let [arenas, vertices] = r.section_vertex_bytes();
    // rust: let cpu: serde_json::Map<String, Value> = r
    // rust: .cpu_census()
    // rust: .into_iter()
    // rust: .map(|(k, v)| (format!("{k}_mb"), mb(v).into()))
    // rust: .collect();
    // rust: let gpu = r
    // rust: .gpu_memory_by_label()
    // rust: .map(|(allocated, reserved, labels)| {
    // rust: json!({
    // rust: "allocated_mb": mb(allocated),
    // rust: "reserved_mb": mb(reserved),
    // rust: "by_label_mb": labels
    // rust: .iter()
    // rust: .take(40)
    // rust: .map(|(label, bytes)| json!([label, mb(*bytes)]))
    // rust: .collect::<Vec<_>>(),
    // rust: })
    // rust: });
    // rust: json!({
    // rust: "section_arenas_mb": mb(arenas),
    // rust: "section_vertices_mb": mb(vertices),
    // rust: "cpu": cpu,
    // rust: "gpu": gpu,
    // rust: })
    // rust: });
    // rust: json!({
    // rust: "process": {
    // rust: "resident_mb": horizon_threads::process_memory::resident_bytes().map(mb),
    // rust: "allocator_commit_mb": mb(commit),
    // rust: "allocator_peak_commit_mb": mb(peak_commit),
    // rust: },
    // rust: "render_distance": self.streaming.radius,
    // rust: "client_columns": census_json(&client),
    // rust: "server_columns": server.as_ref().map(|(c, _)| census_json(c)),
    // rust: "shared_with_server": shared,
    // rust: "server_generation": generation,
    // rust: "far_tiles": self.lod.as_ref().map(|lod| {
    // rust: let (active, cached) = lod.stats();
    // rust: json!({ "active": active, "cached": cached })
    // rust: }),
    // rust: "renderer": renderer,
            // A build with the `alloc-census` feature: the live heap by the
            // startup step, span or pool job that allocated it, else its thread.
    // rust: "heap_by_tag_mb": horizon_threads::HEAP_CENSUS.then(|| {
    // rust: horizon_threads::heap_census::census()
    // rust: .into_iter()
    // rust: .take(60)
    // rust: .map(|(tag, bytes)| json!([tag, mb(bytes.max(0) as u64)]))
    // rust: .collect::<Vec<_>>()
    // rust: }),
    // rust: })
}
}
