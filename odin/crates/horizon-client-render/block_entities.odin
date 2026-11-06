//! Transpiled from Horizon Rust crate
package horizon_client_render_block_entities

import "core:fmt"
import "core:mem"
import "core:math"

// The world's block entities and the order they tick in: vanilla's
// `Level.blockEntityTickers`, kept beside the block entity map so a tick
// visits only the block entities that tick, in vanilla's order, instead of
// scanning the whole map once per kind.
//
// The list follows `LevelChunk.updateBlockEntityTicker` and
// `Level.tickBlockEntities`:
// - a block entity whose block state has a ticker gets a slot at the end of
//   the list (through `pendingBlockEntityTickers`, so a slot made during a
//   tick first ticks on the next one);
// - replacing the block entity at a position (`setBlockEntity`), or changing
//   its block state to another state with a ticker, keeps its slot
//   (`RebindableTickingBlockEntityWrapper.rebind`);
// - removing it (`removeBlockEntity`), unloading its chunk
//   (`clearAllBlockEntities`) or changing its state to one without a ticker
//   (a jukebox losing its record) frees the slot; a later ticker there is
//   appended again;
// - a loaded chunk's block entities are added in the iteration order of its
//   `Object2ObjectOpenHashMap<BlockPos, BlockEntity>`
//   (`registerAllBlockEntitiesAfterLevelLoad`), filled in the order the chunk
//   listed them.
//
// Which states tick is a table by state id, built by the game from the block
// registry; whether a slot is made is decided when the slot is promoted at
// the start of the next tick, from the block state then.
// use crate::chunk::block_entity::{BlockEntity, ModContainer, ModEnergyBuffer, ModFluidTanks};
// use crate::fast_hash::{FxHashMap, FxHashSet};
// use std::collections::HashMap;
// use std::sync::Arc;

    // rust: pub type Pos = (i32, i32, i32);

// What a block state's block entity does each tick (`BlockState.getTicker`).
Ticking :: enum {
    // No ticker, and the block has no block entity that could have one.
    No,
    // A ticker.
    Yes,
    // The block's block entity, but this state has no ticker (a jukebox
    // without a record): a state change to it frees the slot.
    Idle,
}

BlockEntities :: struct {
    map: HashMap<Pos,
    attachments: HashMap<Pos,
    // `Level.blockEntityTickers`: positions and the slot each was given.
    tickers: Arc<Vec<(Pos,
    // `LevelChunk.tickersInLevel`: the live slot of each ticking position.
    live: FxHashMap<Pos,
    // Positions that may need a slot, in the order vanilla would have made
    // it (`pendingBlockEntityTickers`), each with a token; decided at the
    // next promotion from the block state then.
    added: Vec<(Pos,
    // The token of each position's pending entry: an entry whose token is
    // not here any more was cancelled.
    pending: FxHashMap<Pos,
    next_slot: u32,
    // Whether a slot was freed since the list was last swept: otherwise
    // every slot in it is still live, unless its block entity is `out`.
    freed: bool,
    // Positions whose block entity `take` took and `put` has not brought
    // back.
    out: FxHashSet<Pos>,
    // Positions a loaded chunk gave a new block entity over an old one: at
    // the next tick their slot stays only if their block state ticks
    // (`updateBlockEntityTicker`: rebind, or remove without a ticker).
    replaced: FxHashSet<Pos>,
    // `Ticking` by block state id; empty until the game builds it.
    states: [dynamic]Ticking,
    // The containers of mod blocks' block entities, by block state id;
    // built with `states`.
    mod_containers: FxHashMap<u32,
    // The fluid tanks of mod blocks' block entities, by block state id;
    // built with `states`, like the containers.
    mod_fluids: FxHashMap<u32,
    // The energy buffers of mod blocks' block entities, by block state id;
    // built with `states`, like the containers.
    mod_energy: FxHashMap<u32,
    // The positions of the mod block entities (`BlockEntity::Mod`) by chunk,
    // for the renderer: the mesher lists block entities by their template,
    // which leaves out a mod block whose template has none. One taken out
    // (`take`) stays listed until `put` or `remove`.
    mods: FxHashMap<(i32,
    // The positions of the block entities that draw a bounding box (structure and test
    // instance blocks, `shows_box`), so a frame looks at them without scanning the map.
    // Like `mods`, one taken out stays listed until `put` or `remove`.
    boxes: FxHashSet<Pos>,
    asleep: FxHashSet<Pos>,
}

// A structure or test instance block: the block entities whose box the frame may draw.
shows_box :: proc(entity: ^BlockEntity) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: entity,
    // rust: BlockEntity::StructureBlock(_) | BlockEntity::TestInstanceBlock(_)
    // rust: )
}

chunk_of :: proc() {
}
    // rust: (x >> 4, z >> 4)
}

// Takes `pos` out of its chunk's mod block entity set.
forget_mod :: proc(mods: ^FxHashMap<(i32) {
}
    // rust: let chunk = chunk_of(pos);
    // rust: if let Some(set) = mods.get_mut(&chunk) {
    // rust: set.remove(&pos);
    // rust: if set.is_empty() {
    // rust: mods.remove(&chunk);
}
}
}

    // rust: impl std::ops::Deref for BlockEntities {
    // rust: type Target = HashMap<Pos, BlockEntity>;
deref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.map
}
}

    // rust: impl<'a> IntoIterator for &'a BlockEntities {
    // rust: type Item = (&'a Pos, &'a BlockEntity);
    // rust: type IntoIter = std::collections::hash_map::Iter<'a, Pos, BlockEntity>;
into_iter :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.map.iter()
}
}

// `Vec3i.hashCode`.
java_hash :: proc() {
}
    // rust: y.wrapping_add(z.wrapping_mul(31))
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(x)
}
// `HashCommon.mix`.
mix :: proc(x: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let h = (x as u32).wrapping_mul(0x9E37_79B9);
    // rust: (h ^ (h >> 16)) as usize
}

// The order `values().forEach` visits a `new Object2ObjectOpenHashMap<>()`
// keyed by these positions, put in this order (repeats keep their first
// slot): open addressing with linear probing, a rehash to twice the size
// past three quarters full, and iteration from the last slot down.
chunk_map_order :: proc(positions: impl IntoIterator<Item = Pos>) -> V {
    // Ported from Horizon
    return {}
}
    // HashCommon.arraySize(16, .75f), and maxFill of each size.
    // rust: let mut slots: Vec<Option<Pos>> = vec![None; 32];
    // rust: let max_fill = |n: usize| (n * 3).div_ceil(4).min(n - 1);
    // rust: let mut size = 0;
    // rust: for p in positions {
    // rust: let mask = slots.len() - 1;
    // rust: let mut at = mix(java_hash(p)) & mask;
    // rust: let mut known = false;
    // rust: while let Some(k) = slots[at] {
    // rust: if k == p {
    // rust: known = true;
    // rust: break;
}
    // rust: at = (at + 1) & mask;
}
    // rust: if known {
    // rust: continue;
}
    // rust: slots[at] = Some(p);
        // `if (size++ >= maxFill) rehash(arraySize(size + 1, f))`, which
        // puts the keys back from the last slot down.
    // rust: size += 1;
    // rust: if size > max_fill(slots.len()) {
    // rust: let n = ((size + 1) * 4).div_ceil(3).next_power_of_two();
    // rust: let old = std::mem::replace(&mut slots, vec![None; n]);
    // rust: for k in old.into_iter().rev().flatten() {
    // rust: let mut at = mix(java_hash(k)) & (n - 1);
    // rust: while slots[at].is_some() {
    // rust: at = (at + 1) & (n - 1);
}
    // rust: slots[at] = Some(k);
}
}
}
    // rust: slots.into_iter().rev().flatten().collect()
}

    // rust: impl BlockEntities {
    // Whether the ticking table has been built.
has_states :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.states.is_empty()
}
set_states :: proc(self: ^Self, states: [dynamic]Ticking) {
}
    // rust: self.states = states;
}
ticking :: proc(self: ^Self, state: u32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: self.states.get(state as usize).copied().unwrap_or_default()
}
set_mod_containers :: proc(self: ^Self, containers: FxHashMap<u32) {
}
    // rust: self.mod_containers = containers;
}
    // The container of a mod block's block entity in block state `state`.
mod_container :: proc(self: ^Self, state: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.mod_containers.get(&state)
}
set_mod_fluids :: proc(self: ^Self, fluids: FxHashMap<u32) {
}
    // rust: self.mod_fluids = fluids;
}
    // The fluid tanks of a mod block's block entity in block state `state`.
mod_fluids :: proc(self: ^Self, state: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.mod_fluids.get(&state)
}
set_mod_energy :: proc(self: ^Self, energy: FxHashMap<u32) {
}
    // rust: self.mod_energy = energy;
}
    // The energy buffer of a mod block's block entity in block state `state`.
mod_energy :: proc(self: ^Self, state: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.mod_energy.get(&state)
}

next :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let n = self.next_slot;
    // rust: self.next_slot = n.wrapping_add(1);
    // rust: n
}
    // A ticker may be made for `pos` now (`updateBlockEntityTicker`).
add :: proc(self: ^Self, pos: Pos) {
}
    // rust: let token = self.next();
    // rust: self.pending.insert(pos, token);
    // rust: self.added.push((pos, token));
}
    // `removeBlockEntityTicker`: no slot, made or pending.
cancel :: proc(self: ^Self, pos: ^Pos) {
}
    // rust: self.asleep.remove(pos);
    // rust: self.freed |= self.live.remove(pos).is_some();
    // rust: self.pending.remove(pos);
}

    // Attachment map for a live block entity.
    // rust: pub fn attachments_mut(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: ) -> Option<&mut horizon_world::attachments::Attachments> {
    // rust: if !self.map.contains_key(&pos) && !self.out.contains(&pos) {
    // rust: return None;
}
    // rust: Some(self.attachments.entry(pos).or_default())
}
    // Attachment maps in a loaded chunk, for a save snapshot.
    // rust: pub fn chunk_attachments(
    // rust: &self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Vec<(Pos, horizon_world::attachments::Attachments)> {
    // rust: self.attachments
    // rust: .iter()
    // rust: .filter(|(p, _)| p.0 >> 4 == x && p.2 >> 4 == z)
    // rust: .map(|(p, data)| (*p, data.clone()))
    // rust: .collect()
}
    // Restore a loaded block entity's attachment map.
restore_attachments :: proc(self: ^Self, pos: Pos, data: horizon_world::attachments::Attachments) {
}
    // rust: if self.map.contains_key(&pos) {
    // rust: self.attachments.insert(pos, data);
}
}
    // Whether any mod block entity is in the map: until one is, a block change
    // never looks one up (`LevelAccess::has_mod_block_entity`).
has_mods :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.mods.is_empty()
}
    // The structure and test instance blocks (a frame draws their boxes), in no order.
boxes :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.boxes
    // rust: .iter()
    // rust: .filter_map(|pos| Some((pos, self.map.get(pos)?)))
}
    // Keeps `pos` listed in `boxes` exactly while `entity` shows a box.
note_box :: proc(self: ^Self, pos: Pos, entity: Maybe(^BlockEntity)) {
}
    // rust: if entity.is_some_and(shows_box) {
    // rust: self.boxes.insert(pos);
    // rust: } else {
    // rust: self.boxes.remove(&pos);
}
}
    // The mod block entities within `radius` blocks of `x`, `z` (by chunk, so
    // far ones are skipped whole; the caller checks each distance).
mods_near :: proc(self: ^Self, x: f64, z: f64, radius: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let far = move |c: i32, at: f64| {
    // rust: let (lo, hi) = (f64::from(c * 16), f64::from(c * 16 + 16));
    // rust: at < lo - radius || at > hi + radius
}
    // rust: self.mods
    // rust: .iter()
    // rust: .filter(move |((cx, cz), _)| !far(*cx, x) && !far(*cz, z))
    // rust: .flat_map(|(_, set)| set)
}
    // `LevelChunk.getBlockEntity`: the block entity at `pos`, if any.
get :: proc(self: ^Self, pos: ^Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.map.get(pos)
}
get_mut :: proc(self: ^Self, pos: ^Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.asleep.remove(pos);
    // rust: self.map.get_mut(pos)
}
iter_mut :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.asleep.clear();
    // rust: self.map.iter_mut()
}
values_mut :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.asleep.clear();
    // rust: self.map.values_mut()
}
sleep :: proc(self: ^Self, pos: Pos) {
}
    // rust: if self.map.contains_key(&pos) {
    // rust: self.asleep.insert(pos);
}
}
is_asleep :: proc(self: ^Self, pos: ^Pos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.asleep.contains(pos)
}
    // `LevelChunk.setBlockEntity` (+ `addAndRegisterBlockEntity`): a new
    // block entity may get a slot; one replacing another keeps its slot.
    // One of the same type rewrites it in place (a jukebox taking a disc,
    // `/data merge block`), where vanilla keeps the object, so its
    // attachments stay; any other replacement starts them over.
insert :: proc(self: ^Self, pos: Pos, entity: BlockEntity) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let new_is_mod = matches!(entity, BlockEntity::Mod(_));
    // rust: let same_type = |old: &BlockEntity| match (old, &entity) {
    // rust: (BlockEntity::Mod(old), BlockEntity::Mod(new)) => old.id == new.id,
    // rust: (old, new) => std::mem::discriminant(old) == std::mem::discriminant(new),
}
    // rust: if !self.map.get(&pos).is_some_and(same_type) {
    // rust: self.attachments.remove(&pos);
}
    // rust: let new_box = shows_box(&entity);
    // rust: self.asleep.remove(&pos);
    // rust: let old = self.map.insert(pos, entity);
    // rust: if old.is_none() {
    // rust: self.add(pos);
}
    // rust: if new_box {
    // rust: self.boxes.insert(pos);
    // rust: } else if old.as_ref().is_some_and(shows_box) {
    // rust: self.boxes.remove(&pos);
}
    // rust: if new_is_mod {
    // rust: self.mods.entry(chunk_of(pos)).or_default().insert(pos);
    // rust: } else if matches!(old, Some(BlockEntity::Mod(_))) {
    // rust: forget_mod(&mut self.mods, pos);
}
    // rust: old
}
    // The block entity at `pos`, made by `make` when there is none.
    // rust: pub fn get_or_insert_with(
    // rust: &mut self,
    // rust: pos: Pos,
    // rust: make: impl FnOnce() -> BlockEntity,
    // rust: ) -> &mut BlockEntity {
    // rust: let absent = !self.map.contains_key(&pos);
    // rust: if absent {
    // rust: self.add(pos);
}
    // rust: self.asleep.remove(&pos);
    // rust: let entity = self.map.entry(pos).or_insert_with(make);
    // rust: if absent && matches!(entity, BlockEntity::Mod(_)) {
    // rust: self.mods.entry(chunk_of(pos)).or_default().insert(pos);
}
    // rust: if absent && shows_box(entity) {
    // rust: self.boxes.insert(pos);
}
    // rust: entity
}
    // `LevelChunk.removeBlockEntity`: the block entity and its slot.
remove :: proc(self: ^Self, pos: ^Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.attachments.remove(pos);
    // rust: self.asleep.remove(pos);
    // rust: self.cancel(pos);
    // rust: let removed = self.map.remove(pos);
    // rust: if matches!(removed, Some(BlockEntity::Mod(_))) {
    // rust: forget_mod(&mut self.mods, *pos);
}
    // rust: self.boxes.remove(pos);
    // rust: removed
}
    // The block entity at `pos`, out of the map for a while: its slot stays
    // for `put` to bring it back (a tick working on it).
take :: proc(self: ^Self, pos: ^Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.asleep.remove(pos);
    // rust: let taken = self.map.remove(pos);
    // rust: if taken.is_some() {
    // rust: self.out.insert(*pos);
}
    // rust: taken
}
    // Brings back what `take` took, in its slot.
put :: proc(self: ^Self, pos: Pos, entity: BlockEntity) {
}
    // rust: self.out.remove(&pos);
    // rust: self.asleep.remove(&pos);
    // rust: if matches!(entity, BlockEntity::Mod(_)) {
    // rust: self.mods.entry(chunk_of(pos)).or_default().insert(pos);
}
    // rust: self.note_box(pos, Some(&entity));
    // rust: if self.map.insert(pos, entity).is_none()
    // rust: && !self.live.contains_key(&pos)
    // rust: && !self.pending.contains_key(&pos)
    // rust: {
    // rust: self.add(pos);
}
}
    // [`Self::retain`] for unloading chunks: removes the block entities at
    // the positions `gone` names and changes none it keeps, so those that
    // sleep stay asleep (a moving player unloads chunks most ticks).
unload :: proc(self: ^Self, mut gone: impl FnMut(^Pos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let asleep = std::mem::take(&mut self.asleep);
    // rust: self.retain(|p, _| !gone(p));
    // rust: self.asleep = asleep;
    // rust: let map = &self.map;
    // rust: self.asleep.retain(|p| map.contains_key(p));
}
    // Removes the block entities `keep` refuses, and their slots
    // (`clearAllBlockEntities` of unloaded chunks).
retain :: proc(self: ^Self, mut keep: impl FnMut(^Pos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (live, pending, freed, attachments) = (
    // rust: &mut self.live,
    // rust: &mut self.pending,
    // rust: &mut self.freed,
    // rust: &mut self.attachments,
    // rust: );
    // rust: let (mods, boxes) = (&mut self.mods, &mut self.boxes);
    // rust: self.asleep.clear();
    // rust: self.map.retain(|p, e| {
    // rust: let kept = keep(p, e);
    // rust: if !kept {
    // rust: attachments.remove(p);
    // rust: *freed |= live.remove(p).is_some();
    // rust: pending.remove(p);
    // rust: forget_mod(mods, *p);
    // rust: boxes.remove(p);
}
    // rust: kept
    // rust: });
}
clear :: proc(self: ^Self) {
}
    // rust: self.attachments.clear();
    // rust: self.map.clear();
    // rust: self.mods.clear();
    // rust: self.boxes.clear();
    // rust: self.asleep.clear();
    // rust: self.tickers = Arc::default();
    // rust: self.live.clear();
    // rust: self.added.clear();
    // rust: self.pending.clear();
    // rust: self.out.clear();
    // rust: self.replaced.clear();
    // rust: self.freed = false;
}
    // A loaded or generated chunk's block entities, in the order the chunk
    // lists them; they tick in its block entity map's order
    // (`registerAllBlockEntitiesAfterLevelLoad`). One replacing an entity
    // already at its position (`LevelChunk.setBlockEntity`) drops that one;
    // its slot is decided by the block state at the next tick.
load_chunk :: proc(self: ^Self, entities: Vec<(Pos) {
}
    // rust: let order = chunk_map_order(entities.iter().map(|(p, _)| *p));
    // rust: for (p, e) in entities {
    // rust: self.attachments.remove(&p);
    // rust: self.asleep.remove(&p);
    // rust: let new_is_mod = matches!(e, BlockEntity::Mod(_));
    // rust: self.note_box(p, Some(&e));
    // rust: let old = self.map.insert(p, e);
    // rust: if old.is_some() {
    // rust: self.replaced.insert(p);
}
    // rust: if new_is_mod {
    // rust: self.mods.entry(chunk_of(p)).or_default().insert(p);
    // rust: } else if matches!(old, Some(BlockEntity::Mod(_))) {
    // rust: forget_mod(&mut self.mods, p);
}
}
    // rust: for p in order {
    // rust: self.add(p);
}
}
    // `LevelChunk.setBlockState` on a block entity's position, from state
    // `old` to `new`: a ticker made, kept or dropped.
state_changed :: proc(self: ^Self, pos: Pos, old: u32, new: u32) {
}
    // rust: self.asleep.remove(&pos);
    // rust: if self.states.is_empty() || !self.map.contains_key(&pos) {
    // rust: return;
}
    // rust: match self.ticking(new) {
            // A new ticker, unless one was made or is pending (rebound).
    // rust: Ticking::Yes => {
    // rust: if self.ticking(old) != Ticking::Yes && !self.live.contains_key(&pos) {
    // rust: self.add(pos);
}
}
    // rust: Ticking::Idle => self.cancel(&pos),
            // Another block: the game removes or replaces the block entity.
    // rust: Ticking::No => {}
}
}
    // The start of `Level.tickBlockEntities`: pending slots join the list
    // and freed ones leave it. `state` reads the block state at a position.
    // Returns the slots to tick, in order; check each with `is_live` before
    // ticking it, as the ticks before it can free it.
tickers :: proc(self: ^Self, state: impl Fn(Pos) -> u {
    // Ported from Horizon
    return {}
}
    // rust: for (pos, token) in std::mem::take(&mut self.added) {
    // rust: if self.pending.get(&pos) != Some(&token) {
    // rust: continue;
}
    // rust: self.pending.remove(&pos);
    // rust: if self.live.contains_key(&pos)
    // rust: || !self.map.contains_key(&pos)
    // rust: || self.ticking(state(pos)) != Ticking::Yes
    // rust: {
    // rust: continue;
}
    // rust: let slot = self.next();
    // rust: self.live.insert(pos, slot);
    // rust: Arc::make_mut(&mut self.tickers).push((pos, slot));
}
    // rust: for pos in std::mem::take(&mut self.replaced) {
    // rust: if self.live.contains_key(&pos) && self.ticking(state(pos)) != Ticking::Yes {
    // rust: self.cancel(&pos);
}
}
    // rust: if !std::mem::take(&mut self.freed) && self.out.is_empty() {
    // rust: return Arc::clone(&self.tickers);
}
    // rust: self.out.clear();
    // rust: let (live, map) = (&mut self.live, &self.map);
    // rust: Arc::make_mut(&mut self.tickers).retain(|(p, slot)| {
    // rust: let mine = live.get(p) == Some(slot);
    // rust: if mine && !map.contains_key(p) {
    // rust: live.remove(p);
}
    // rust: mine && map.contains_key(p)
    // rust: });
    // rust: Arc::clone(&self.tickers)
}
    // Whether a slot from `tickers` still ticks.
is_live :: proc(self: ^Self) {
}
    // rust: self.live.get(&pos) == Some(&slot) && self.map.contains_key(&pos)
}
    // Frees the slot at `pos` (the block entity stays).
forget :: proc(self: ^Self, pos: ^Pos) {
}
    // rust: self.cancel(pos);
}
}

    // rust: mod tests {
//     use super::*;

hopper :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: BlockEntity::Chest(vec![None; 5])
}
    // States: 0 air, 1 ticks, 2 idle.
level :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut b = BlockEntities::default();
    // rust: b.set_states(vec![Ticking::No, Ticking::Yes, Ticking::Idle]);
    // rust: b
}
order :: proc(b: ^BlockEntities, states: ^HashMap<Pos) -> V {
    // Ported from Horizon
    return {}
}
    // rust: b.tickers(|p| states.get(&p).copied().unwrap_or(0))
    // rust: .iter()
    // rust: .map(|(p, _)| *p)
    // rust: .collect()
}

    // Unloading a chunk removes its block entities and leaves the others'
    // sleep alone; `retain`, which may change what it keeps, wakes them all.
unloading_a_chunk_keeps_the_others_asleep :: proc() {
}
    // rust: let mut b = level();
    // rust: let (kept, gone) = ((1, 64, 1), (17, 64, 1));
    // rust: b.insert(kept, hopper());
    // rust: b.insert(gone, hopper());
    // rust: b.sleep(kept);
    // rust: b.sleep(gone);
    // rust: b.unload(|p| p.0 >> 4 == 1);
    // rust: assert!(b.get(&gone).is_none());
    // rust: assert!(!b.is_asleep(&gone));
    // rust: assert!(b.is_asleep(&kept));
    // rust: b.retain(|_, _| true);
    // rust: assert!(!b.is_asleep(&kept));
}

near :: proc(b: ^BlockEntities, x: f64, z: f64, radius: f64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut found: Vec<Pos> = b.mods_near(x, z, radius).copied().collect();
    // rust: found.sort();
    // rust: found
}
a_sleeping_block_entity_wakes_on_any_change :: proc() {
}
    // rust: let p = (1, 64, 1);
    // rust: let mut b = level();
    // rust: b.sleep(p);
    // rust: assert!(!b.is_asleep(&p));
    // rust: b.insert(p, hopper());
    // rust: let asleep = |b: &mut BlockEntities, wake: &dyn Fn(&mut BlockEntities)| {
    // rust: b.sleep(p);
    // rust: assert!(b.is_asleep(&p));
    // rust: wake(b);
    // rust: b.is_asleep(&p)
}
    // rust: assert!(asleep(&mut b, &|_| {}));
    // rust: assert!(!asleep(&mut b, &|b| {
    // rust: b.get_mut(&p);
    // rust: }));
    // rust: assert!(!asleep(&mut b, &|b| {
    // rust: b.insert(p, hopper());
    // rust: }));
    // rust: assert!(!asleep(&mut b, &|b| {
    // rust: b.get_or_insert_with(p, hopper);
    // rust: }));
    // rust: assert!(!asleep(&mut b, &|b| {
    // rust: let held = b.take(&p).unwrap();
    // rust: b.put(p, held);
    // rust: }));
    // rust: assert!(!asleep(&mut b, &|b| b.state_changed(p, 1, 1)));
    // rust: assert!(!asleep(&mut b, &|b| b.forget(&p)));
    // rust: assert!(!asleep(&mut b, &|b| {
    // rust: b.iter_mut().count();
    // rust: }));
    // rust: assert!(!asleep(&mut b, &|b| {
    // rust: b.values_mut().count();
    // rust: }));
    // rust: assert!(!asleep(&mut b, &|b| b.retain(|_, _| true)));
    // rust: assert!(!asleep(&mut b, &|b| b.load_chunk(vec![(p, hopper())])));
    // rust: assert!(!asleep(&mut b, &|b| {
    // rust: b.remove(&p);
    // rust: b.insert(p, hopper());
    // rust: }));
    // rust: b.sleep(p);
    // rust: b.clear();
    // rust: assert!(!b.is_asleep(&p));
}
mod_block_entities_are_listed_by_chunk_until_they_go :: proc() {
}
    // rust: let mut b = level();
    // rust: let modded = || BlockEntity::Mod(Box::default());
    // rust: b.insert((1, 64, 1), modded());
    // rust: b.insert((200, 64, 1), modded());
    // rust: b.insert((2, 64, 2), hopper());
    // rust: b.get_or_insert_with((3, 64, 3), modded);
    // rust: b.load_chunk(vec![((4, 64, 4), modded()), ((5, 64, 5), hopper())]);
        // Only mods, and only chunks within reach.
    // rust: assert_eq!(
    // rust: near(&b, 0.0, 0.0, 64.0),
    // rust: [(1, 64, 1), (3, 64, 3), (4, 64, 4)]
    // rust: );
    // rust: assert_eq!(near(&b, 200.0, 0.0, 8.0), [(200, 64, 1)]);
        // Taken out for a tick, still listed; removed or replaced, gone.
    // rust: let taken = b.take(&(1, 64, 1)).unwrap();
    // rust: assert_eq!(near(&b, 0.0, 0.0, 64.0).len(), 3);
    // rust: b.put((1, 64, 1), taken);
    // rust: b.remove(&(3, 64, 3));
    // rust: b.insert((4, 64, 4), hopper());
    // rust: assert_eq!(near(&b, 0.0, 0.0, 64.0), [(1, 64, 1)]);
    // rust: b.retain(|p, _| p.0 != 1);
    // rust: assert!(near(&b, 0.0, 0.0, 64.0).is_empty());
    // rust: b.clear();
    // rust: assert!(near(&b, 200.0, 0.0, 8.0).is_empty());
}
attachments_follow_block_entity_lifetime :: proc() {
}
//         use horizon_world::attachments::AttachmentType;
    // rust: let ty = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "value",
    // rust: default: || 0,
    // rust: codec: None,
    // rust: copy_on_death: false,
    // rust: sync: false,
}
    // rust: let p = (1, 64, 2);
    // rust: let mut entities = level();
    // rust: assert!(entities.attachments_mut(p).is_none());
    // rust: entities.insert(p, hopper());
    // rust: entities.attachments_mut(p).unwrap().set(&ty, 4).unwrap();
    // rust: let held = entities.take(&p).unwrap();
    // rust: entities.put(p, held);
    // rust: assert_eq!(entities.attachments_mut(p).unwrap().get(&ty), Ok(4));
    // rust: entities.insert(p, hopper());
    // rust: assert_eq!(entities.attachments_mut(p).unwrap().get(&ty), Ok(4));
    // rust: let machine = |id: &str| {
    // rust: BlockEntity::Mod(Box::new(
    // rust: crate::chunk::block_entity::ModBlockEntityFields {
    // rust: id: id.into(),
    // rust: ..Default::default()
}
    // rust: .into(),
    // rust: ))
}
    // rust: entities.insert(p, machine("test:a"));
    // rust: assert_eq!(entities.attachments_mut(p).unwrap().get(&ty), Ok(0));
    // rust: entities.attachments_mut(p).unwrap().set(&ty, 4).unwrap();
    // rust: entities.insert(p, machine("test:a"));
    // rust: assert_eq!(entities.attachments_mut(p).unwrap().get(&ty), Ok(4));
    // rust: entities.insert(p, machine("test:b"));
    // rust: assert_eq!(entities.attachments_mut(p).unwrap().get(&ty), Ok(0));
    // rust: entities.attachments_mut(p).unwrap().set(&ty, 4).unwrap();
    // rust: entities.remove(&p);
    // rust: entities.insert(p, hopper());
    // rust: assert_eq!(entities.attachments_mut(p).unwrap().get(&ty), Ok(0));
    // rust: entities.attachments_mut(p).unwrap().set(&ty, 5).unwrap();
    // rust: entities.retain(|_, _| false);
    // rust: entities.insert(p, hopper());
    // rust: assert_eq!(entities.attachments_mut(p).unwrap().get(&ty), Ok(0));
}

slots_follow_vanilla_lifecycle :: proc() {
}
    // rust: let mut b = level();
    // rust: let mut s = HashMap::new();
    // rust: for p in [(0, 0, 0), (1, 0, 0), (2, 0, 0)] {
    // rust: s.insert(p, 1);
    // rust: b.insert(p, hopper());
}
    // rust: assert_eq!(order(&mut b, &s), [(0, 0, 0), (1, 0, 0), (2, 0, 0)]);
        // Replacing keeps the slot; removing and placing again appends.
    // rust: b.insert((0, 0, 0), hopper());
    // rust: b.remove(&(1, 0, 0));
    // rust: b.insert((1, 0, 0), hopper());
    // rust: assert_eq!(order(&mut b, &s), [(0, 0, 0), (2, 0, 0), (1, 0, 0)]);
        // Take and put keep it; an idle state frees it, ticking again appends.
    // rust: let e = b.take(&(0, 0, 0)).unwrap();
    // rust: b.put((0, 0, 0), e);
    // rust: assert_eq!(order(&mut b, &s), [(0, 0, 0), (2, 0, 0), (1, 0, 0)]);
    // rust: s.insert((2, 0, 0), 2);
    // rust: b.state_changed((2, 0, 0), 1, 2);
    // rust: assert_eq!(order(&mut b, &s), [(0, 0, 0), (1, 0, 0)]);
    // rust: s.insert((2, 0, 0), 1);
    // rust: b.state_changed((2, 0, 0), 2, 1);
    // rust: assert_eq!(order(&mut b, &s), [(0, 0, 0), (1, 0, 0), (2, 0, 0)]);
        // A slot freed during a tick is not live any more.
    // rust: let slots = b.tickers(|p| s.get(&p).copied().unwrap_or(0));
    // rust: b.retain(|p, _| *p != (1, 0, 0));
    // rust: assert!(b.is_live(slots[0]) && !b.is_live(slots[1]));
        // A block entity taken and never brought back loses its slot.
    // rust: b.take(&(0, 0, 0));
    // rust: assert_eq!(order(&mut b, &s), [(2, 0, 0)]);
    // rust: assert_eq!(order(&mut b, &s), [(2, 0, 0)]);
}

chunk_loads_in_open_hash_map_order :: proc() {
}
        // A few keys: their mixed hashes over 32 slots, read from the top.
    // rust: let positions = [
    // rust: (0, 64, 0),
    // rust: (1, 64, 0),
    // rust: (0, 64, 1),
    // rust: (15, -64, 15),
    // rust: (3, 70, 9),
    // rust: ];
    // rust: let slot = |p: &Pos| mix(java_hash(*p)) & 31;
    // rust: let mut expected = positions.to_vec();
    // rust: expected.sort_by_key(|p| std::cmp::Reverse(slot(p)));
    // rust: let distinct: std::collections::HashSet<usize> = positions.iter().map(slot).collect();
    // rust: assert_eq!(distinct.len(), positions.len());
    // rust: assert_eq!(chunk_map_order(positions), expected);
        // Past 24 keys the table doubles; every key stays, once.
    // rust: let many: Vec<Pos> = (0..100).map(|i| (i % 16, i / 16, 3)).collect();
    // rust: let order = chunk_map_order(many.iter().copied().chain(many.iter().copied()));
    // rust: assert_eq!(order.len(), 100);
}

    // A chunk loaded over a block entity already there: the new one replaces
    // it, and keeps the old slot only while its block state ticks.
loaded_chunk_replaces_block_entity_by_state :: proc() {
}
    // rust: let mut b = level();
    // rust: let mut s = HashMap::new();
    // rust: let (p, q) = ((0, 0, 0), (1, 0, 0));
    // rust: for pos in [p, q] {
    // rust: s.insert(pos, 1);
}
        // Two chunks, so the order is the order they load in.
    // rust: b.load_chunk(vec![(p, hopper())]);
    // rust: b.load_chunk(vec![(q, hopper())]);
    // rust: assert_eq!(order(&mut b, &s), [p, q]);
        // Replaced where the state ticks: the slot stays in its place.
    // rust: b.load_chunk(vec![(p, hopper())]);
    // rust: assert_eq!(order(&mut b, &s), [p, q]);
        // Replaced where the state has no ticker: the slot is freed, and the
        // new block entity is the one in the map.
    // rust: s.insert(p, 2);
    // rust: b.load_chunk(vec![(p, BlockEntity::Chest(vec![None; 27]))]);
    // rust: assert_eq!(order(&mut b, &s), [q]);
    // rust: assert!(matches!(b.get(&p), Some(BlockEntity::Chest(items)) if items.len() == 27));
        // Ticking again later appends it, as any new ticker does.
    // rust: s.insert(p, 1);
    // rust: b.state_changed(p, 2, 1);
    // rust: assert_eq!(order(&mut b, &s), [q, p]);
}

boxes_list_exactly_the_structure_and_test_blocks :: proc() {
}
    // rust: let test_block = || BlockEntity::TestInstanceBlock(Box::default());
    // rust: let listed = |b: &BlockEntities| {
    // rust: let mut v: Vec<Pos> = b.boxes().map(|(p, _)| *p).collect();
    // rust: v.sort();
    // rust: v
}
    // rust: let mut b = level();
    // rust: let (p, q, r) = ((0, 0, 0), (1, 0, 0), (2, 0, 0));
    // rust: b.insert(p, test_block());
    // rust: b.insert(q, hopper());
    // rust: assert_eq!(listed(&b), [p]);
        // Replaced by another kind, and back.
    // rust: b.insert(p, hopper());
    // rust: assert_eq!(listed(&b), []);
    // rust: b.insert(q, test_block());
    // rust: b.get_or_insert_with(r, test_block);
    // rust: assert_eq!(listed(&b), [q, r]);
        // Taken out: not shown until put back; put back as another kind: gone.
    // rust: let taken = b.take(&q).unwrap();
    // rust: assert_eq!(listed(&b), [r]);
    // rust: b.put(q, taken);
    // rust: assert_eq!(listed(&b), [q, r]);
    // rust: let taken = b.take(&r).unwrap();
    // rust: drop(taken);
    // rust: b.put(r, hopper());
    // rust: assert_eq!(listed(&b), [q]);
    // rust: b.remove(&q);
    // rust: assert_eq!(listed(&b), []);
    // rust: b.load_chunk(vec![(p, test_block()), (q, hopper())]);
    // rust: assert_eq!(listed(&b), [p]);
    // rust: b.retain(|pos, _| *pos != p);
    // rust: assert_eq!(listed(&b), []);
    // rust: b.insert(r, test_block());
    // rust: b.clear();
    // rust: assert!(b.boxes.is_empty());
}
}
