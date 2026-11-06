//! Transpiled from Horizon Rust crate
package horizon_client_render_block_edit

import "core:fmt"
import "core:mem"
import "core:math"

// Bulk block edits: runs of blocks up columns written straight into the
// resident sections, a section unpacked and packed once however many of its
// blocks change, instead of a `World::set` per block. Nothing round them is
// told (as `fill ... strict`); the light of each chunk changed is worked out
// again whole, off the game thread, rather than block by block, and each
// section changed is remeshed once.
// use crate::chunk::index;
// use crate::fast_hash::FxHashMap;
// use crate::world::World;

// A run of one column, resolved: blocks `y0..=y1` of column (x, z) set to
// `state` where filter `only` (if any) passes the block there.
Run :: struct {
    x: i32,
    z: i32,
    y0: i32,
    y1: i32,
    state: u32,
    only: Maybe(u16),
}

// What an edit changed.
Outcome :: struct {
    // Blocks changed.
    changed: u64,
    // Chunks with a change.
    chunks: uint,
    // Changes of the states `tracked` asked for (block entities, watched
    // blocks): position, previous and new state.
    tracked: Vec<((i32,
}

// Per state answers, worked out once each.
Memo :: struct {
    // rust: impl Memo {
get :: proc(self: ^Self, state: u32, ask: impl FnOnce(u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let i = state as usize;
    // rust: if i >= self.0.len() {
    // rust: self.0.resize(i + 1, 0);
}
    // rust: if self.0[i] == 0 {
    // rust: self.0[i] = 1 + u8::from(ask(state));
}
    // rust: self.0[i] == 2
}
}

    // rust: impl World {
    // Make `runs` in order, each seeing the changes of those before it.
    // `matches(filter, state)` says whether a filter passes a state, and
    // `tracked(state)` whether its changes are reported; each is asked once
    // per state. Runs in unloaded chunks and the parts of runs outside each
    // chunk's own column (`Chunk::layout`) are left out.
    //
    // Unlike `World::set`, this records nothing per block: no
    // `block_entities.state_changed` (a caller adds or removes block
    // entities itself, from `Outcome::tracked`), no `watched_writes` (ask
    // for those states through `tracked`), no `block_log` entry (the chunk
    // goes in `bulk_log` instead, sent whole), no `path_writes` (mobs'
    // paths are not recomputed for these blocks) and no `light_edits` (the
    // chunk and its neighbours are lit again whole, through `dirty_light`).
    // rust: pub fn edit_runs(
    // rust: &mut self,
    // rust: runs: &[Run],
    // rust: mut matches: impl FnMut(u16, u32) -> bool,
    // rust: mut tracked: impl FnMut(u32) -> bool,
    // rust: ) -> Outcome {
    // rust: let mut out = Outcome::default();
        // the runs of each chunk, in order, and the chunks in the order they were first named
    // rust: let mut by_chunk: FxHashMap<(i32, i32), Vec<u32>> = FxHashMap::default();
    // rust: let mut order = Vec::new();
    // rust: for (i, r) in runs.iter().enumerate() {
    // rust: if r.y1 < r.y0 {
    // rust: continue;
}
    // rust: let key = (r.x >> 4, r.z >> 4);
    // rust: by_chunk
    // rust: .entry(key)
    // rust: .or_insert_with(|| {
    // rust: order.push(key);
    // rust: Vec::new()
    // rust: })
    // rust: .push(i as u32);
}
    // rust: let mut filter_memo: Vec<Memo> = Vec::new();
    // rust: let mut tracked_memo = Memo(Vec::new());
    // rust: let mut values: Vec<Option<Box<[u32; 4096]>>> = Vec::new();
    // rust: let mut changed: Vec<bool> = Vec::new();
    // rust: for key in order {
    // rust: let Some(chunk) = self.chunks.get(&key) else {
    // rust: continue;
}
    // rust: let (min_y, sections) = (chunk.min_y(), chunk.sections.len());
    // rust: let max_y = chunk.max_y();
    // rust: let list = &by_chunk[&key];
    // rust: changed.clear();
    // rust: changed.resize(sections, false);
    // rust: values.clear();
    // rust: values.resize_with(sections, || None);
    // rust: let mut any = 0u64;
    // rust: for &i in list {
    // rust: let r = runs[i as usize];
    // rust: let (lx, lz) = (r.x & 15, r.z & 15);
    // rust: let (y0, y1) = (r.y0.max(min_y), r.y1.min(max_y - 1));
    // rust: let mut y = y0;
    // rust: while y <= y1 {
    // rust: let s = ((y - min_y) >> 4) as usize;
    // rust: let top = (min_y + (s as i32 + 1) * 16 - 1).min(y1);
    // rust: let vals = values[s].get_or_insert_with(|| {
    // rust: let mut v = Box::new([0u32; 4096]);
    // rust: chunk.sections[s].unpack(&mut v);
    // rust: v
    // rust: });
    // rust: for yy in y..=top {
    // rust: let at = index(lx, yy, lz);
    // rust: let old = vals[at];
    // rust: if old == r.state {
    // rust: continue;
}
    // rust: if let Some(f) = r.only {
    // rust: let f = f as usize;
    // rust: if filter_memo.len() <= f {
    // rust: filter_memo.resize_with(f + 1, || Memo(Vec::new()));
}
    // rust: if !filter_memo[f].get(old, |s| matches(f as u16, s)) {
    // rust: continue;
}
}
    // rust: vals[at] = r.state;
    // rust: changed[s] = true;
    // rust: any += 1;
    // rust: if tracked_memo.get(old, &mut tracked)
    // rust: || tracked_memo.get(r.state, &mut tracked)
    // rust: {
    // rust: out.tracked.push(((r.x, yy, r.z), old, r.state));
}
}
    // rust: y = top + 1;
}
}
    // rust: if any == 0 {
    // rust: continue;
}
    // rust: out.changed += any;
    // rust: out.chunks += 1;
    // rust: let chunk =
    // rust: std::sync::Arc::make_mut(self.chunks.get_mut(&key).expect("looked up above"));
    // rust: for s in 0..sections {
    // rust: if changed[s]
    // rust: && let Some(v) = &values[s]
    // rust: {
    // rust: chunk.replace_blocks(s, v);
}
}
    // rust: self.revision = self.revision.wrapping_add(1);
    // rust: self.modified.insert(key);
    // rust: if self.block_log.is_some() {
    // rust: self.bulk_log.insert(key);
}
            // remeshed once (with the neighbours whose faces and light it touches), lit again whole
    // rust: for (s, _) in changed.iter().enumerate().filter(|c| *c.1) {
    // rust: for ds in -1..=1 {
    // rust: let sy = s as i32 + ds;
    // rust: if !(0..sections as i32).contains(&sy) {
    // rust: continue;
}
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: self.dirty_sections.insert((key.0 + dx, sy, key.1 + dz));
}
}
}
}
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: self.dirty_light.insert((key.0 + dx, key.1 + dz));
}
}
}
    // rust: out
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::chunk::Chunk;
//     use horizon_world::registry::BlockStateId;
//     use std::sync::Arc;

world :: proc() -> W {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = World::new(BlockStateId(0), 0);
    // rust: for cz in -1..=1 {
    // rust: for cx in -1..=1 {
    // rust: w.chunks.insert((cx, cz), Arc::new(Chunk::empty(cx, cz)));
}
}
        // stone up to y 63
    // rust: for z in -16..32 {
    // rust: for x in -16..32 {
    // rust: for y in -64..64 {
    // rust: w.set(x, y, z, BlockStateId(1)).unwrap();
}
}
}
    // rust: w.dirty_light.clear();
    // rust: w.dirty_sections.clear();
    // rust: w.block_log = Some(Vec::new());
    // rust: w
}
run :: proc(x: i32, z: i32, y0: i32, y1: i32, state: u32, only: Maybe(u16)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Run {
    // rust: x,
    // rust: z,
    // rust: y0,
    // rust: y1,
    // rust: state,
    // rust: only,
}
}

runs_change_their_blocks_in_order :: proc() {
}
    // rust: let mut w = world();
    // rust: let runs = [
    // rust: run(3, 4, 10, 40, 0, None),
    // rust: run(3, 4, 10, 12, 5, None),
            // only where it is air: over the stone, and the three blocks of 5 stay
    // rust: run(3, 4, 0, 80, 7, Some(0)),
    // rust: run(-1, 20, -70, 400, 9, None),
    // rust: ];
    // rust: let out = w.edit_runs(&runs, |_, s| s == 0, |_| false);
    // rust: assert_eq!(w.block(3, 9, 4).0, 1);
    // rust: assert_eq!(w.block(3, 11, 4).0, 5);
    // rust: assert_eq!(w.block(3, 13, 4).0, 7);
    // rust: assert_eq!(w.block(3, 70, 4).0, 7);
    // rust: assert_eq!(w.block(3, 81, 4).0, 0);
    // rust: assert_eq!(w.block(3, 0, 4).0, 1);
    // rust: assert_eq!(w.block(-1, -64, 20).0, 9);
    // rust: assert_eq!(w.block(-1, 319, 20).0, 9);
    // rust: assert_eq!(w.block(0, 30, 20).0, 1);
        // 31 dug, 3 set again, the air over them filled (28, and 17 over the stone), the whole of the other column
    // rust: assert_eq!(out.changed, 31 + 3 + 45 + 384);
    // rust: assert_eq!(out.chunks, 2);
    // rust: assert!(w.bulk_log.contains(&(0, 0)) && w.bulk_log.contains(&(-1, 1)));
    // rust: assert!(w.dirty_light.contains(&(1, 1)) && w.dirty_light.contains(&(-2, 2)));
    // rust: assert!(w.dirty_sections.contains(&(1, 4, 1)));
        // the per-block log is left to the blocks set one at a time
    // rust: assert!(w.block_log.as_ref().unwrap().is_empty());
}

unloaded_chunks_and_unchanged_blocks_are_left_out :: proc() {
}
    // rust: let mut w = world();
    // rust: let out = w.edit_runs(
    // rust: &[run(100, 100, 0, 10, 0, None), run(0, 0, 0, 10, 1, None)],
    // rust: |_, _| true,
    // rust: |_| false,
    // rust: );
    // rust: assert_eq!(out.changed, 0);
    // rust: assert_eq!(out.chunks, 0);
    // rust: assert!(w.bulk_log.is_empty() && w.dirty_light.is_empty());
}

tracked_states_are_reported :: proc() {
}
    // rust: let mut w = world();
    // rust: let out = w.edit_runs(&[run(1, 1, 60, 65, 3, None)], |_, _| true, |s| s == 3);
    // rust: assert_eq!(out.tracked.len(), 6);
    // rust: assert_eq!(out.tracked[0], ((1, 60, 1), 1, 3));
    // rust: assert_eq!(out.tracked[5], ((1, 65, 1), 0, 3));
}

heightmaps_follow_the_edit :: proc() {
}
    // rust: let mut w = world();
    // rust: let air = |s: u32| s == 0;
    // rust: assert_eq!(w.world_surface(5, 5, |s| air(s.0)), 64);
    // rust: w.edit_runs(&[run(5, 5, 20, 63, 0, None)], |_, _| true, |_| false);
    // rust: assert_eq!(w.world_surface(5, 5, |s| air(s.0)), 20);
    // rust: w.edit_runs(&[run(5, 5, 90, 90, 2, None)], |_, _| true, |_| false);
    // rust: assert_eq!(w.world_surface(5, 5, |s| air(s.0)), 91);
}

runs_follow_each_chunks_own_layout :: proc() {
}
//         use crate::chunk::ColumnLayout;
        // a data pack's taller dimension: -128..=511
    // rust: let tall = ColumnLayout::new(-128, 640).unwrap();
    // rust: let mut w = World::new(BlockStateId(0), 0);
    // rust: w.chunks
    // rust: .insert((0, 0), Arc::new(Chunk::with_layout(0, 0, tall)));
    // rust: let out = w.edit_runs(&[run(2, 3, -500, 900, 4, None)], |_, _| true, |_| false);
    // rust: assert_eq!(out.changed, 640);
    // rust: let chunk = &w.chunks[&(0, 0)];
    // rust: assert_eq!(chunk.block(2, -128, 3).0, 4);
    // rust: assert_eq!(chunk.block(2, -65, 3).0, 4);
    // rust: assert_eq!(chunk.block(2, 320, 3).0, 4);
    // rust: assert_eq!(chunk.block(2, 511, 3).0, 4);
    // rust: assert!(w.dirty_sections.contains(&(0, 39, 0)));
    // rust: assert!(!w.dirty_sections.contains(&(0, 40, 0)));
}
}
