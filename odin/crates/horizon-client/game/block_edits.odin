//! Transpiled from Horizon Rust crate
package horizon_client_block_edits

import "core:fmt"
import "core:mem"
import "core:math"

// A server mod's bulk block edit (`native_edit_blocks`): its palette and
// filters read as commands read blocks, its heights read, and its runs made
// at once through `World::edit_runs`, with what `fill ... strict` does for
// the block entities and the watched blocks of each block changed.
// use super::Game;
// use super::native_world_columns::NativeColumnBlocks as ColumnBlocks;
// use super::native_world_edit::{NativeBlockEdit as BlockEdit, NativeHeightmap as Heightmap};
// use horizon_client::{
    // rust: block_edit::Run,
    // rust: chunk::ColumnLayout,
    // rust: command::{Reader, args::BlockInput, block},
    // rust: containers::BlockEntity,
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: world::World,
}
// use horizon_world::{
    // rust: heightmap::HeightmapType, registry::BlockStateId, worldgen::terrain::TerrainBlockStates,
}
// use std::sync::Arc;

// A change `World::edit_runs` reported: position, previous and new state.
    // rust: type Tracked = ((i32, i32, i32), u32, u32);

    // rust: impl Game<'_> {
    // Make a mod's block edit; how many blocks changed, or why none did.
    // Every palette entry, filter and run is checked before anything
    // changes: an entry or filter that doesn't read, one with NBT (`{...}`,
    // refused: the bulk path sets states only), a run naming a palette entry
    // or filter past the end, or more than 65536 filters, and nothing is
    // made.
    // rust: pub(super) fn edit_blocks(&mut self, edit: &BlockEdit) -> Result<u64, String> {
    // rust: let parse = |name: &str, testing: bool| -> Result<BlockInput, String> {
    // rust: let mut reader = Reader::new(name);
    // rust: let b = block::parse(&mut reader, &self.ui.registries, testing)
    // rust: .map_err(|e| format!("{name:?}: {}", e.message.plain()))?;
    // rust: if reader.can_read() {
    // rust: return Err(format!("{name:?}: more after the block"));
}
    // rust: if b.nbt.is_some() {
    // rust: return Err(format!("{name:?}: block NBT is not supported here"));
}
    // rust: Ok(b)
}
    // rust: let mut palette = Vec::with_capacity(edit.palette.len());
    // rust: for name in &edit.palette {
    // rust: let b = parse(name, false)?;
    // rust: let state = self
    // rust: .block_state(&b)
    // rust: .map_err(|e| format!("{name:?}: {}", e.message.plain()))?;
    // rust: palette.push(state.0);
}
    // rust: let filters = edit
    // rust: .filters
    // rust: .iter()
    // rust: .map(|f| parse(f, true))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: let runs = resolve_runs(edit, &palette, filters.len(), |h, x, z| {
    // rust: self.edit_height(h, x, z)
    // rust: })?;
        // (what the registry, the tags and the facts tell of a state, beside the world being changed)
    // rust: let registry = self.pack.assets.registry;
        // (the tags as `block_matches` reads them for commands)
    // rust: let world_items = match &self.world_tables {
    // rust: Some(t) => &t.items,
    // rust: None => self.res.items(),
}
    // rust: let tags = [&self.res.items().block_tags, &world_items.block_tags];
    // rust: let facts = self.res.facts();
    // rust: let watched = std::mem::take(&mut self.world.watched);
    // rust: let out = self.world.edit_runs(
    // rust: &runs,
    // rust: |f, s| {
    // rust: super::commands::block_input_matches(
    // rust: registry,
    // rust: tags,
    // rust: &filters[f as usize],
    // rust: BlockStateId(s),
    // rust: )
    // rust: },
    // rust: |s| {
    // rust: let f = facts.get(BlockStateId(s));
    // rust: watched.get(s as usize).copied().unwrap_or(false)
    // rust: || f.block_entity
    // rust: || BlockEntity::for_block(&f.name).is_some()
    // rust: },
    // rust: );
    // rust: self.world.watched = watched;
        // The block entities the new blocks bring, as `native_set_block` makes them (a mod block's own, API 15,
        // included), in the order `replace_block_entities` takes them: the positions needing a fresh entity.
    // rust: let name = |s: u32| self.res.facts().get(BlockStateId(s)).name.clone();
    // rust: let wanted: Vec<Arc<str>> = out
    // rust: .tracked
    // rust: .iter()
    // rust: .filter(|&&((x, y, z), old, new)| {
    // rust: name(old) != name(new)
    // rust: || !self
    // rust: .world
    // rust: .block_entities
    // rust: .get(&(x, y, z))
    // rust: .is_some_and(|e| e.fits(&name(new)))
    // rust: })
    // rust: .map(|&(_, _, new)| name(new))
    // rust: .collect();
    // rust: let mut made = make_block_entities(&wanted, |n| self.new_block_entity(n)).into_iter();
    // rust: let facts = self.res.facts();
    // rust: let removed = replace_block_entities(
    // rust: &mut self.world,
    // rust: &out.tracked,
    // rust: |s| facts.get(BlockStateId(s)).name.clone(),
    // rust: |_| made.next().flatten(),
    // rust: );
    // rust: for pos in removed {
    // rust: self.jukebox_removed(pos);
}
    // rust: Ok(out.changed)
}

    // Each column's height on `h` as `edit_height` reads it, none where its chunk is not loaded.
    // rust: pub(super) fn surface_heights(&self, columns: &[(i32, i32)], h: Heightmap) -> Vec<Option<i32>> {
    // rust: loaded_heights(&self.world, columns, |x, z| self.edit_height(h, x, z))
}

    // Each column's height on `h` (none where its chunk is not loaded) and its blocks from `below` under it to
    // `above` - 1 over it, bottom first (air outside the column and where it is not loaded), as indices into the
    // names seen, with the biome's grass, foliage and water tints at the column's top (0 where it is not loaded;
    // unblended). `Err`, reading nothing, when `below + above` is 0 or more than the level's height, or the read
    // would be more than `MAX_READ` blocks.
    // rust: pub(super) fn read_columns(
    // rust: &self,
    // rust: columns: &[(i32, i32)],
    // rust: h: Heightmap,
    // rust: below: u32,
    // rust: above: u32,
    // rust: ) -> Result<ColumnBlocks, String> {
    // rust: read_size(columns.len(), below, above, self.world.layout().height())?;
    // rust: let bases = self.surface_heights(columns, h);
    // rust: let facts = self.res.facts();
    // rust: let (palette, blocks) = column_blocks(&self.world, columns, &bases, below, above, |s| {
    // rust: facts.get(s).name.clone()
    // rust: })
    // rust: .ok_or("the read is too big")?;
    // rust: let biomes = self.res.biomes();
    // rust: let mut tints = Vec::with_capacity(columns.len() * 3);
    // rust: for (&(x, z), base) in columns.iter().zip(&bases) {
            // (the biome tints at the column's top, as the block there is tinted)
    // rust: match base.and_then(|b| {
    // rust: self.world
    // rust: .chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .map(|c| c.biome(x, b - 1, z))
    // rust: }) {
    // rust: Some(id) => {
    // rust: let b = biomes.get(id);
    // rust: tints.extend([
    // rust: biomes.grass(id, f64::from(x), f64::from(z)),
    // rust: b.foliage,
    // rust: b.water,
    // rust: ]);
}
    // rust: None => tints.extend([0, 0, 0]),
}
}
    // rust: Ok(ColumnBlocks {
    // rust: palette,
    // rust: bases,
    // rust: blocks,
    // rust: tints,
    // rust: })
}

    // One above the highest block of column (x, z) that counts on heightmap `h`, or the bottom of the column (also
    // where it is not loaded).
edit_height :: proc(self: ^Self, h: Heightmap, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let properties = &self.pack.assets.properties;
    // rust: column_height(
    // rust: &self.world,
    // rust: h,
    // rust: (x, z),
    // rust: |s| self.res.facts().is_air(s),
    // rust: |t, s| t.is_opaque(properties.heightmap_state(s)),
    // rust: )
}
}

// The most blocks one `read_columns` reads (2 MiB of indices): it runs on the
// server tick, so a mod reads a big area in pieces.
    // rust: pub(super) const MAX_READ: usize = 1 << 20;
// The most columns one `surface_heights` reads.
    // rust: pub(super) const MAX_COLUMNS: usize = 1 << 16;

// The blocks a column read of `columns` columns, `below` + `above` each,
// reads, or why it can't: a span of 0 or more than `height` (the level's),
// or the whole more than `MAX_READ`.
read_size :: proc(columns: uint, below: u32, above: u32, height: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let per = below
    // rust: .checked_add(above)
    // rust: .filter(|&per| per > 0 && i64::from(per) <= i64::from(height))
    // rust: .ok_or_else(|| format!("below + above must be 1 to {height}, the level's height"))?;
    // rust: columns
    // rust: .checked_mul(per as usize)
    // rust: .filter(|&n| n <= MAX_READ)
    // rust: .ok_or_else(|| {
    // rust: format!("the read is more than {MAX_READ} blocks: read fewer columns a call")
    // rust: })
}

// One above the highest block of column `(x, z)` on heightmap `h`, or the
// bottom of the column (also where it is not loaded): `air` says which
// blocks the world surface passes over, and `counts(kind, state)` which
// count on the other heightmaps.
    // rust: fn column_height(
    // rust: world: &World,
    // rust: h: Heightmap,
    // rust: (x, z): (i32, i32),
    // rust: air: impl Fn(BlockStateId) -> bool,
    // rust: counts: impl Fn(HeightmapType, BlockStateId) -> bool,
    // rust: ) -> i32 {
    // rust: if h == Heightmap::WorldSurface {
    // rust: return world.world_surface(x, z, air);
}
    // (as `rain_height` reads it: both others count only blocks that block motion, so they are at or under it)
    // rust: let top = world.motion_blocking(x, z, |s| counts(HeightmapType::MotionBlocking, s));
    // rust: let kind = match h {
    // rust: Heightmap::MotionBlockingNoLeaves => HeightmapType::MotionBlockingNoLeaves,
    // rust: Heightmap::OceanFloor => HeightmapType::OceanFloor,
    // rust: _ => return top,
}
    // rust: let bottom = world
    // rust: .chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .map_or(world.layout().min_y(), |c| c.min_y());
    // rust: let mut y = top;
    // rust: while y > bottom && !counts(kind, world.block(x, y - 1, z)) {
    // rust: y -= 1;
}
    // rust: y
}

// `height(x, z)` of each column, none where its chunk is not loaded. (A
// chunk is looked up once for a run of columns in it.)
    // rust: fn loaded_heights(
    // rust: world: &World,
    // rust: columns: &[(i32, i32)],
    // rust: height: impl Fn(i32, i32) -> i32,
    // rust: ) -> Vec<Option<i32>> {
    // rust: let mut last: Option<((i32, i32), bool)> = None;
    // rust: columns
    // rust: .iter()
    // rust: .map(|&(x, z)| {
    // rust: let key = (x >> 4, z >> 4);
    // rust: let loaded = match last {
    // rust: Some((k, l)) if k == key => l,
    // rust: _ => {
    // rust: let l = world.chunks.get(&key).is_some();
    // rust: last = Some((key, l));
    // rust: l
}
}
    // rust: loaded.then(|| height(x, z))
    // rust: })
    // rust: .collect()
}

// The blocks of each column from `below` under its base to `above` - 1 over
// it, bottom first, as indices into the names (`name`) seen: air outside the
// column's chunk's own height and where there is no base. None, reading
// nothing, past `read_size`'s bound.
    // rust: fn column_blocks(
    // rust: world: &World,
    // rust: columns: &[(i32, i32)],
    // rust: bases: &[Option<i32>],
    // rust: below: u32,
    // rust: above: u32,
    // rust: name: impl Fn(BlockStateId) -> Arc<str>,
    // rust: ) -> Option<(Vec<String>, Vec<u16>)> {
    // rust: let total = read_size(
    // rust: columns.len(),
    // rust: below,
    // rust: above,
    // rust: ColumnLayout::HIGHEST_Y + 1 - ColumnLayout::LOWEST_Y,
    // rust: )
    // rust: .ok()?;
    // rust: let per = (below + above) as usize;
    // rust: let mut blocks = Vec::with_capacity(total);
    // rust: let mut palette: Vec<String> = Vec::new();
    // (a state's index into the names, worked out once a state)
    // rust: let mut seen: FxHashMap<u32, u16> = FxHashMap::default();
    // rust: let mut index = |s: BlockStateId| -> u16 {
    // rust: *seen.entry(s.0).or_insert_with(|| {
    // rust: let name = name(s);
    // rust: let i = palette
    // rust: .iter()
    // rust: .position(|n| **n == *name)
    // rust: .unwrap_or_else(|| {
    // rust: palette.push(name.to_string());
    // rust: palette.len() - 1
    // rust: });
    // rust: i as u16
    // rust: })
}
    // rust: for (&(x, z), base) in columns.iter().zip(bases) {
    // rust: let chunk = world.chunks.get(&(x >> 4, z >> 4));
    // rust: match (base, chunk) {
    // rust: (Some(b), Some(chunk)) => {
    // rust: let (bottom, top) = (chunk.min_y(), chunk.max_y());
    // rust: let y0 = i64::from(*b) - i64::from(below);
    // rust: for y in y0..y0 + per as i64 {
    // rust: let s = match i32::try_from(y) {
    // rust: Ok(y) if (bottom..top).contains(&y) => chunk.block(x & 15, y, z & 15),
    // rust: _ => world.air,
}
    // rust: blocks.push(index(s));
}
}
    // rust: _ => {
    // rust: let air = index(world.air);
    // rust: blocks.extend(std::iter::repeat_n(air, per));
}
}
}
    // rust: Some((palette, blocks))
}

// `edit`'s runs as `World::edit_runs` takes them: each palette entry `block`
// as its state in `palette`, each `y` counted from `height(surface, x, z)`
// when the run names a heightmap (read before any change, once a column).
// Err, with nothing resolved, for a run naming a palette entry or a filter
// past the end, or for more filters than a run can name (65536).
    // rust: fn resolve_runs(
    // rust: edit: &BlockEdit,
    // rust: palette: &[u32],
    // rust: filters: usize,
    // rust: mut height: impl FnMut(Heightmap, i32, i32) -> i32,
    // rust: ) -> Result<Vec<Run>, String> {
    // rust: if filters > usize::from(u16::MAX) + 1 {
    // rust: return Err(format!("{filters} filters: 65536 at most"));
}
    // rust: let mut heights: FxHashMap<(i32, i32, u8), i32> = FxHashMap::default();
    // rust: let mut runs = Vec::with_capacity(edit.runs.len());
    // rust: for (i, r) in edit.runs.iter().enumerate() {
    // rust: let Some(&state) = usize::try_from(r.block).ok().and_then(|b| palette.get(b)) else {
    // rust: return Err(format!(
    // rust: "run {i}: palette entry {} of {}",
    // rust: r.block,
    // rust: palette.len()
    // rust: ));
}
    // rust: let only = match r.only {
    // rust: None => None,
    // rust: Some(f) if (f as usize) < filters => Some(f as u16),
    // rust: Some(f) => return Err(format!("run {i}: filter {f} of {filters}")),
}
    // rust: if r.height == 0 {
    // rust: continue;
}
    // rust: let base = match r.surface {
    // rust: None => i64::from(r.y),
    // rust: Some(h) => {
    // rust: let top = *heights
    // rust: .entry((r.x, r.z, h as u8))
    // rust: .or_insert_with(|| height(h, r.x, r.z));
    // rust: i64::from(top) + i64::from(r.y)
}
}
    // rust: let clamp = |v: i64| v.clamp(i64::from(i32::MIN), i64::from(i32::MAX)) as i32;
    // rust: runs.push(Run {
    // rust: x: r.x,
    // rust: z: r.z,
    // rust: y0: clamp(base),
    // rust: y1: clamp(base + i64::from(r.height) - 1),
    // rust: state,
    // rust: only,
    // rust: });
}
    // rust: Ok(runs)
}

// What `fill ... strict` does for the block entities and the watched blocks
// of `tracked`'s changes: the watched writes recorded, the block entities
// told of their new state, and where a different block replaced the block,
// its block entity removed (as `place_state` does) and `new_entity(name)`'s,
// if any, put in its place. Returns the positions whose block was replaced
// (a jukebox there stops).
// A block entity for each new block, in order: made for each position, as vanilla calls
// `EntityBlock.newBlockEntity` for each (a mod's may number its instances). A block that makes none (stone) is
// asked once.
    // rust: fn make_block_entities(
    // rust: names: &[Arc<str>],
    // rust: mut make: impl FnMut(&str) -> Option<BlockEntity>,
    // rust: ) -> Vec<Option<BlockEntity>> {
    // rust: let mut none: FxHashSet<&str> = FxHashSet::default();
    // rust: names
    // rust: .iter()
    // rust: .map(|n| {
    // rust: if none.contains(&**n) {
    // rust: return None;
}
    // rust: let entity = make(n);
    // rust: if entity.is_none() {
    // rust: none.insert(n);
}
    // rust: entity
    // rust: })
    // rust: .collect()
}

    // rust: fn replace_block_entities(
    // rust: world: &mut World,
    // rust: tracked: &[Tracked],
    // rust: name: impl Fn(u32) -> Arc<str>,
    // rust: mut new_entity: impl FnMut(&str) -> Option<BlockEntity>,
    // rust: ) -> Vec<[i32; 3]> {
    // rust: let mut replaced = Vec::new();
    // rust: for &((x, y, z), old, new) in tracked {
    // rust: let watches = |id: u32| world.watched.get(id as usize).copied().unwrap_or(false);
    // rust: if watches(old) || watches(new) {
    // rust: world.watched_writes.push(((x, y, z), old, new));
}
    // rust: world.block_entities.state_changed((x, y, z), old, new);
    // rust: let (was, now) = (name(old), name(new));
    // rust: if was != now {
    // rust: replaced.push([x, y, z]);
}
        // LevelChunk.setBlockState: the entity at the position keeps its
        // place only while it is valid for the block now there
        // (`BlockEntity.isValidBlockState`); a mismatched or missing one
        // makes way for the block's own.
    // rust: if was != now
    // rust: || !world
    // rust: .block_entities
    // rust: .get(&(x, y, z))
    // rust: .is_some_and(|e| e.fits(&now))
    // rust: {
    // rust: world.block_entities.remove(&(x, y, z));
    // rust: if let Some(entity) = new_entity(&now) {
    // rust: world.block_entities.insert((x, y, z), entity);
}
}
}
    // rust: replaced
}

    // rust: mod tests {
//     use super::*;
//     use crate::game::native_world_edit::NativeBlockRun as BlockRun;
//     use horizon_client::chunk::Chunk;

run :: proc(block: u32, only: Maybe(u32)) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BlockRun {
    // rust: x: 1,
    // rust: z: 2,
    // rust: y: 3,
    // rust: height: 4,
    // rust: surface: None,
    // rust: block,
    // rust: only,
}
}
edit :: proc(runs: [dynamic]BlockRun) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BlockEdit {
    // rust: palette: vec!["stone".into(), "air".into()],
    // rust: filters: vec!["#dirt".into()],
    // rust: runs,
}
}

runs_naming_entries_past_the_end_are_refused_whole :: proc() {
}
    // rust: let palette = [1, 0];
    // rust: let ok = resolve_runs(&edit(vec![run(1, Some(0))]), &palette, 1, |_, _, _| 0).unwrap();
    // rust: assert_eq!(
    // rust: ok,
    // rust: [Run {
    // rust: x: 1,
    // rust: z: 2,
    // rust: y0: 3,
    // rust: y1: 6,
    // rust: state: 0,
    // rust: only: Some(0),
    // rust: }]
    // rust: );
        // a bad run after a good one: nothing at all, and no height read
    // rust: let mut asked = 0;
    // rust: let mut bad = |runs| {
    // rust: resolve_runs(&edit(runs), &palette, 1, |_, _, _| {
    // rust: asked += 1;
    // rust: 0
    // rust: })
}
    // rust: assert!(bad(vec![run(0, None), run(2, None)]).is_err());
    // rust: assert!(bad(vec![run(0, None), run(u32::MAX, None)]).is_err());
    // rust: assert!(bad(vec![run(0, Some(1))]).is_err());
    // rust: assert!(bad(vec![run(0, Some(u32::MAX))]).is_err());
    // rust: assert_eq!(asked, 0);
        // more filters than a run's u16 names
    // rust: assert!(resolve_runs(&edit(vec![]), &palette, 65_537, |_, _, _| 0).is_err());
    // rust: assert!(resolve_runs(&edit(vec![]), &palette, 65_536, |_, _, _| 0).is_ok());
}

a_run_counts_from_its_heightmap_read_once_a_column :: proc() {
}
    // rust: let mut r = run(0, None);
    // rust: r.surface = Some(Heightmap::OceanFloor);
    // rust: r.y = -2;
    // rust: let mut asked = Vec::new();
    // rust: let runs = resolve_runs(&edit(vec![r, r]), &[7], 0, |h, x, z| {
    // rust: asked.push((h, x, z));
    // rust: 70
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(asked, [(Heightmap::OceanFloor, 1, 2)]);
    // rust: assert_eq!((runs[0].y0, runs[0].y1, runs[0].state), (68, 71, 7));
    // rust: assert_eq!(runs[1], runs[0]);
        // a run far past the world's height clamps rather than wraps
    // rust: let mut high = run(0, None);
    // rust: high.y = i32::MAX;
    // rust: high.height = u32::MAX;
    // rust: let runs = resolve_runs(&edit(vec![high]), &[7], 0, |_, _, _| 0).unwrap();
    // rust: assert_eq!((runs[0].y0, runs[0].y1), (i32::MAX, i32::MAX));
}

world :: proc() -> W {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = World::new(BlockStateId(0), 0);
    // rust: w.chunks.insert((0, 0), Arc::new(Chunk::empty(0, 0)));
    // rust: w
}
names :: proc(s: u32) -> A {
    // Ported from Horizon
    return {}
}
    // rust: match s {
    // rust: 0 => "minecraft:air",
    // rust: 1 => "minecraft:stone",
    // rust: 2 => "minecraft:chest",
            // another chest state (a `facing` flip): the name is unchanged
    // rust: 4 => "minecraft:chest",
    // rust: _ => "machines:press",
}
    // rust: .into()
}

a_chest_replaced_by_stone_loses_its_block_entity :: proc() {
}
    // rust: let mut w = world();
    // rust: w.set(1, 5, 1, BlockStateId(2)).unwrap();
    // rust: let chest = BlockEntity::for_block("minecraft:chest").expect("a chest's");
    // rust: w.block_entities.insert((1, 5, 1), chest);
    // rust: let out = w.edit_runs(
    // rust: &[Run {
    // rust: x: 1,
    // rust: z: 1,
    // rust: y0: 4,
    // rust: y1: 6,
    // rust: state: 1,
    // rust: only: None,
    // rust: }],
    // rust: |_, _| true,
    // rust: |s| s == 2,
    // rust: );
    // rust: assert_eq!(out.tracked, [((1, 5, 1), 2, 1)]);
    // rust: let replaced = replace_block_entities(&mut w, &out.tracked, names, BlockEntity::for_block);
    // rust: assert_eq!(replaced, [[1, 5, 1]]);
    // rust: assert!(w.block_entities.get(&(1, 5, 1)).is_none());
    // rust: assert_eq!(w.block(1, 5, 1).0, 1);
}

a_new_block_gets_the_block_entity_made_for_it :: proc() {
}
    // rust: let mut w = world();
    // rust: let out = w.edit_runs(
    // rust: &[Run {
    // rust: x: 3,
    // rust: z: 3,
    // rust: y0: 10,
    // rust: y1: 10,
    // rust: state: 3,
    // rust: only: None,
    // rust: }],
    // rust: |_, _| true,
    // rust: |s| s == 3,
    // rust: );
        // a mod block's, as `Game::new_block_entity` makes it
    // rust: let made = |n: &str| {
    // rust: (n == "machines:press").then(|| {
    // rust: BlockEntity::Mod(Box::new(
    // rust: horizon_client::containers::ModBlockEntityFields {
    // rust: id: "machines:press".into(),
    // rust: ..Default::default()
}
    // rust: .into(),
    // rust: ))
    // rust: })
}
    // rust: replace_block_entities(&mut w, &out.tracked, names, made);
    // rust: assert!(matches!(
    // rust: w.block_entities.get(&(3, 10, 3)),
    // rust: Some(BlockEntity::Mod(e)) if e.id == "machines:press"
    // rust: ));
}

    // `LevelChunk.setBlockState` keeps an entity only while
    // `BlockEntity.isValidBlockState` holds: a stale one goes for the
    // block's own (a sculk listener spilled under a same-name write), and
    // a fitting one survives a same-name write (a chest's items stay).
a_kept_block_entity_must_fit_its_block :: proc() {
}
    // rust: let sculk = BlockEntity::for_block("minecraft:sculk_sensor").expect("a sensor's");
    // rust: let chest = BlockEntity::for_block("minecraft:chest").expect("a chest's");
    // rust: assert!(!sculk.fits("minecraft:stone"));
    // rust: assert!(chest.fits("minecraft:chest"));
        // a 27-slot container never fits a hopper's five
    // rust: assert!(!chest.fits("minecraft:hopper"));

    // rust: let mut w = world();
    // rust: w.set(1, 5, 1, BlockStateId(2)).unwrap();
    // rust: w.block_entities.insert((1, 5, 1), sculk);
    // rust: let out = w.edit_runs(
    // rust: &[Run {
    // rust: x: 1,
    // rust: z: 1,
    // rust: y0: 5,
    // rust: y1: 5,
    // rust: state: 4,
    // rust: only: None,
    // rust: }],
    // rust: |_, _| true,
    // rust: |_| true,
    // rust: );
    // rust: assert_eq!(out.tracked, [((1, 5, 1), 2, 4)]);
    // rust: replace_block_entities(&mut w, &out.tracked, names, BlockEntity::for_block);
    // rust: assert!(
    // rust: matches!(
    // rust: w.block_entities.get(&(1, 5, 1)),
    // rust: Some(BlockEntity::Chest(_))
    // rust: ),
    // rust: "the chest's own entity replaces the spilled sculk one"
    // rust: );

    // rust: w.set(2, 5, 1, BlockStateId(2)).unwrap();
    // rust: w.block_entities.insert((2, 5, 1), chest);
    // rust: let out = w.edit_runs(
    // rust: &[Run {
    // rust: x: 2,
    // rust: z: 1,
    // rust: y0: 5,
    // rust: y1: 5,
    // rust: state: 4,
    // rust: only: None,
    // rust: }],
    // rust: |_, _| true,
    // rust: |_| true,
    // rust: );
    // rust: assert_eq!(out.tracked, [((2, 5, 1), 2, 4)]);
    // rust: replace_block_entities(&mut w, &out.tracked, names, BlockEntity::for_block);
    // rust: assert!(matches!(
    // rust: w.block_entities.get(&(2, 5, 1)),
    // rust: Some(BlockEntity::Chest(_))
    // rust: ));
}

    // air 0, stone 1, leaves 2, water 3: column (1, 1) stone to 60, water, then leaves to 64; column (2, 2)
    // stone to 60, leaves, then water to 64; at (3, 3) stone at the top of the world.
columns_world :: proc() -> W {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = world();
    // rust: for (x, z, low, high) in [(1, 1, 3, 2), (2, 2, 2, 3)] {
    // rust: for y in -64..=64 {
    // rust: let s = match y {
    // rust: ..=60 => 1,
    // rust: 61..=62 => low,
    // rust: _ => high,
}
    // rust: w.set(x, y, z, BlockStateId(s)).unwrap();
}
}
    // rust: w.set(3, 319, 3, BlockStateId(1)).unwrap();
    // rust: w
}
height :: proc(w: ^World, h: Heightmap, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: column_height(
    // rust: w,
    // rust: h,
    // rust: (x, z),
    // rust: |s| s.0 == 0,
    // rust: |kind, s| match kind {
    // rust: HeightmapType::MotionBlockingNoLeaves => matches!(s.0, 1 | 3),
    // rust: HeightmapType::OceanFloor => matches!(s.0, 1 | 2),
    // rust: _ => s.0 != 0,
    // rust: },
    // rust: )
}

each_heightmap_has_its_own_height :: proc() {
}
    // rust: let w = columns_world();
    // rust: assert_eq!(height(&w, Heightmap::WorldSurface, 1, 1), 65);
    // rust: assert_eq!(height(&w, Heightmap::MotionBlocking, 1, 1), 65);
    // rust: assert_eq!(height(&w, Heightmap::MotionBlockingNoLeaves, 1, 1), 63);
    // rust: assert_eq!(height(&w, Heightmap::OceanFloor, 1, 1), 65);
    // rust: assert_eq!(height(&w, Heightmap::OceanFloor, 2, 2), 63);
    // rust: assert_eq!(height(&w, Heightmap::MotionBlockingNoLeaves, 2, 2), 65);
        // an empty column, and one not loaded: the bottom
    // rust: assert_eq!(height(&w, Heightmap::OceanFloor, 5, 5), -64);
    // rust: assert_eq!(height(&w, Heightmap::WorldSurface, 100, 100), -64);
}

columns_not_loaded_have_no_height :: proc() {
}
    // rust: let w = columns_world();
    // rust: let heights = loaded_heights(&w, &[(1, 1), (100, 100), (2, 2), (-1, 0)], |x, z| {
    // rust: height(&w, Heightmap::OceanFloor, x, z)
    // rust: });
    // rust: assert_eq!(heights, [Some(65), None, Some(63), None]);
}

column_blocks_read_air_past_the_column_and_where_not_loaded :: proc() {
}
    // rust: let w = columns_world();
    // rust: let (palette, blocks) = column_blocks(
    // rust: &w,
    // rust: &[(1, 1), (3, 3), (100, 100)],
    // rust: &[Some(65), Some(319), None],
    // rust: 2,
    // rust: 3,
    // rust: |s| names(s.0),
    // rust: )
    // rust: .unwrap();
    // rust: let read: Vec<&str> = blocks.iter().map(|&i| &*palette[i as usize]).collect();
        // (`names` calls state 2 a chest: here it stands for leaves)
    // rust: let (leaves, stone, air) = ("minecraft:chest", "minecraft:stone", "minecraft:air");
    // rust: assert_eq!(
    // rust: read,
    // rust: [
    // rust: leaves, leaves, air, air, air, // (1, 1) from 63
    // rust: air, air, stone, air, air, // (3, 3) from 317: stone at 319, nothing over 319
    // rust: air, air, air, air, air, // not loaded
    // rust: ]
    // rust: );
        // names once each
    // rust: assert_eq!(palette.len(), 3);
}

a_read_is_bounded :: proc() {
}
    // rust: assert_eq!(read_size(10, 200, 184, 384), Ok(3840));
    // rust: assert!(
    // rust: read_size(1, 200, 185, 384).is_err(),
    // rust: "more than the level's height"
    // rust: );
    // rust: assert!(read_size(1, 0, 0, 384).is_err(), "an empty span");
    // rust: assert!(read_size(1, u32::MAX, 1, 4064).is_err());
    // rust: assert!(read_size(1 << 14, 100, 0, 384).is_err(), "over MAX_READ");
    // rust: assert!(read_size(usize::MAX, 2, 0, 384).is_err());
    // rust: assert_eq!(read_size(1 << 12, 256, 0, 384), Ok(MAX_READ));
    // rust: let w = columns_world();
    // rust: assert!(column_blocks(&w, &[(1, 1)], &[Some(0)], u32::MAX, 2, |s| names(s.0)).is_none());
}

each_new_block_gets_its_own_block_entity :: proc() {
}
        // a mod's constructor numbering its instances; stone makes none
    // rust: let mut calls = Vec::new();
    // rust: let made = make_block_entities(
    // rust: &[
    // rust: "machines:press",
    // rust: "minecraft:stone",
    // rust: "machines:press",
    // rust: "minecraft:stone",
    // rust: ]
    // rust: .map(Arc::<str>::from),
    // rust: |n| {
    // rust: calls.push(n.to_string());
    // rust: (n == "machines:press").then(|| {
    // rust: BlockEntity::Mod(Box::new(
    // rust: horizon_client::containers::ModBlockEntityFields {
    // rust: id: format!("press-{}", calls.len()),
    // rust: ..Default::default()
}
    // rust: .into(),
    // rust: ))
    // rust: })
    // rust: },
    // rust: );
    // rust: let ids: Vec<Option<String>> = made
    // rust: .iter()
    // rust: .map(|e| match e {
    // rust: Some(BlockEntity::Mod(e)) => Some(e.id.to_string()),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(
    // rust: ids,
    // rust: [
    // rust: Some("press-1".to_string()),
    // rust: None,
    // rust: Some("press-3".to_string()),
    // rust: None
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: calls,
    // rust: ["machines:press", "minecraft:stone", "machines:press"]
    // rust: );
}
}
