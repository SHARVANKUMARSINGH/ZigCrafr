//! Transpiled from Horizon Rust crate
package horizon_world_chunk

import "core:fmt"
import "core:mem"
import "core:math"

// Saved section palettes and storage-level chunk access. Changes here do not
// run block behavior, lighting, heightmaps, neighbor updates or scheduled ticks.
    // rust: pub use crate::block_state_properties::BlockProperties;
// use crate::{
    // rust: DATA_VERSION,
    // rust: compression::invalid,
    // rust: nbt::{Compound, JavaString, NamedTag, Tag},
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: tick_data::{self, TickKind},
}
// use horizon_core::{
    // rust: position::{BlockPos, ChunkPos},
    // rust: storage::PackedStorage,
    // rust: ticks::{ChunkTicks, SavedTick, TickTypeId},
}
// use std::io;

key :: proc(value: string) -> J {
    // Ported from Horizon
    return {}
}
    // rust: JavaString::from(value)
}
bits_for_palette :: proc(len: uint, min: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if len <= 1 {
    // rust: 0
    // rust: } else {
    // rust: ((usize::BITS - (len - 1).leading_zeros()) as u8).max(min)
}
}

PalettedContainer :: struct {
    palette: [dynamic]Tag,
    storage: Maybe(PackedStorage),
    entries: uint,
    min_bits: u8,
    extra: Compound,
}
    // rust: impl PalettedContainer {
uniform :: proc(value: Tag, entries: uint, min_bits: u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if entries == 0 || !(1..=32).contains(&min_bits) {
    // rust: return Err(invalid("invalid palette dimensions"));
}
    // rust: if matches!(value, Tag::End) {
    // rust: return Err(invalid("End cannot be a palette entry"));
}
    // rust: Ok(Self {
    // rust: palette: vec![value],
    // rust: storage: None,
    // rust: entries,
    // rust: min_bits,
    // rust: extra: Compound::new(),
    // rust: })
}

from_nbt :: proc(tag: ^Tag, entries: uint, min_bits: u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let Tag::Compound(map) = tag else {
    // rust: return Err(invalid("palette container is not a compound"));
}
    // rust: let Some(Tag::List(palette)) = map.get(&key("palette")) else {
    // rust: return Err(invalid("missing palette list"));
}
    // rust: let first = palette.first().ok_or_else(|| invalid("empty palette"))?;
    // rust: let mut result = Self::uniform(first.clone(), entries, min_bits)?;
    // rust: if palette.len() > i32::MAX as usize || palette.iter().any(|t| matches!(t, Tag::End)) {
    // rust: return Err(invalid("invalid palette"));
}
    // rust: result.palette = palette.clone();
    // rust: let bits = bits_for_palette(palette.len(), min_bits);
    // rust: if bits > 0 {
    // rust: let Some(Tag::LongArray(words)) = map.get(&key("data")) else {
    // rust: return Err(invalid("nonuniform palette is missing data"));
}
    // rust: let storage =
    // rust: PackedStorage::from_words(bits, entries, words.iter().map(|&w| w as u64).collect())
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: for index in 0..entries {
    // rust: if storage.get(index).unwrap() as usize >= palette.len() {
    // rust: return Err(invalid("palette index outside palette"));
}
}
    // rust: result.storage = Some(storage);
}
    // rust: result.extra = map.clone();
    // rust: result.extra.remove(&key("palette"));
    // rust: result.extra.remove(&key("data"));
    // rust: Ok(result)
}

bits :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.storage.as_ref().map_or(0, PackedStorage::bits)
}
palette_len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.palette.len()
}
get :: proc(self: ^Self, index: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if index >= self.entries {
    // rust: return Err(invalid("section index out of bounds"));
}
    // rust: let palette_index = self.storage.as_ref().map_or(0, |s| s.get(index).unwrap()) as usize;
    // rust: Ok(&self.palette[palette_index])
}

set :: proc(self: ^Self, index: uint, value: Tag) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let old = self.get(index)?.clone();
    // rust: if matches!(value, Tag::End) {
    // rust: return Err(invalid("End cannot be a palette entry"));
}
    // rust: let id = if let Some(id) = self.palette.iter().position(|v| *v == value) {
    // rust: id
    // rust: } else {
    // rust: if self.palette.len() >= i32::MAX as usize {
    // rust: return Err(invalid("palette too large"));
}
    // rust: let next_bits = bits_for_palette(self.palette.len() + 1, self.min_bits);
    // rust: if next_bits != self.bits() {
    // rust: let mut next = PackedStorage::new(next_bits, self.entries)
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: if let Some(previous) = &self.storage {
    // rust: for i in 0..self.entries {
    // rust: next.set(i, previous.get(i).unwrap()).unwrap();
}
}
    // rust: self.storage = Some(next);
}
    // rust: self.palette.push(value);
    // rust: self.palette.len() - 1
}
    // rust: if let Some(storage) = &mut self.storage {
    // rust: storage
    // rust: .set(index, id as u32)
    // rust: .map_err(|e| invalid(e.to_string()))?;
}
    // rust: Ok(old)
}

    // Rebuild a minimal palette in first-use order, preserving every entry.
compact :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let values = (0..self.entries)
    // rust: .map(|i| self.get(i).cloned())
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: let mut compact = Self::uniform(values[0].clone(), self.entries, self.min_bits)?;
    // rust: for (i, value) in values.into_iter().enumerate() {
    // rust: compact.set(i, value)?;
}
    // rust: compact.extra = std::mem::take(&mut self.extra);
    // rust: *self = compact;
    // rust: Ok(())
}

to_nbt :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut map = self.extra.clone();
    // rust: map.insert(key("palette"), Tag::List(self.palette.clone()));
    // rust: if let Some(storage) = &self.storage {
    // rust: map.insert(
    // rust: key("data"),
    // rust: Tag::LongArray(storage.words().iter().map(|&v| v as i64).collect()),
    // rust: );
}
    // rust: Tag::Compound(map)
}
}

BlockState :: struct {
    name: string,
    properties: BlockProperties,
}
    // rust: impl BlockState {
to_nbt :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut map = Compound::new();
    // rust: map.insert(key("id"), Tag::String(key(&self.name)));
    // rust: if !self.properties.is_empty() {
    // rust: map.insert(
    // rust: key("properties"),
    // rust: Tag::Compound(
    // rust: self.properties
    // rust: .iter()
    // rust: .map(|(k, v)| (key(k), Tag::String(key(v))))
    // rust: .collect(),
    // rust: ),
    // rust: );
}
    // rust: Tag::Compound(map)
}
from_nbt :: proc(tag: ^Tag) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Tag::String(name) = tag {
    // rust: return Ok(Self {
    // rust: name: name.to_string().map_err(|e| invalid(e.to_string()))?,
    // rust: properties: BlockProperties::new(),
    // rust: });
}
    // rust: let Some(Tag::String(name)) = tag.get("id") else {
    // rust: return Err(invalid("block state is missing id"));
}
    // rust: let mut properties = Vec::new();
    // rust: if let Some(tag) = tag.get("properties") {
    // rust: let Tag::Compound(map) = tag else {
    // rust: return Err(invalid("block properties are not a compound"));
}
    // rust: for (k, v) in map {
    // rust: let Tag::String(v) = v else {
    // rust: return Err(invalid("block property is not a string"));
}
    // rust: properties.push((
    // rust: k.to_string().map_err(|e| invalid(e.to_string()))?,
    // rust: v.to_string().map_err(|e| invalid(e.to_string()))?,
    // rust: ));
}
}
    // rust: Ok(Self {
    // rust: name: name.to_string().map_err(|e| invalid(e.to_string()))?,
    // rust: properties: properties.into_iter().collect(),
    // rust: })
}
}

ChunkData :: struct {
    root: NamedTag,
    position: ChunkPos,
}
    // rust: impl ChunkData {
new :: proc(root: NamedTag) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Tag::Int(x)) = root.tag.get("xPos") else {
    // rust: return Err(invalid("chunk is missing xPos"));
}
    // rust: let Some(Tag::Int(z)) = root.tag.get("zPos") else {
    // rust: return Err(invalid("chunk is missing zPos"));
}
    // rust: let position = ChunkPos::new(*x, *z);
    // rust: let Some(Tag::Int(version)) = root.tag.get("DataVersion") else {
    // rust: return Err(invalid("chunk is missing DataVersion"));
}
    // rust: if *version != DATA_VERSION {
    // rust: return Err(invalid(format!(
    // rust: "expected DataVersion {DATA_VERSION}, got {version}; data fixing is not implemented"
    // rust: )));
}
    // rust: let Some(Tag::List(sections)) = root.tag.get("sections") else {
    // rust: return Err(invalid("chunk is missing sections"));
}
    // rust: let mut seen = std::collections::BTreeSet::new();
    // rust: for section in sections {
    // rust: let Some(Tag::Byte(y)) = section.get("Y") else {
    // rust: return Err(invalid("section is missing byte Y"));
}
    // rust: if !seen.insert(*y) {
    // rust: return Err(invalid("duplicate section Y"));
}
}
    // rust: Ok(Self { root, position })
}
position :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.position
}
into_nbt :: proc(self: ^Self) -> N {
    // Ported from Horizon
    return {}
}
    // rust: self.root
}
root :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.root
}

    // rust: pub fn saved_ticks(
    // rust: &self,
    // rust: kind: TickKind,
    // rust: resolve: impl FnMut(&str) -> Option<TickTypeId>,
    // rust: ) -> io::Result<ChunkTicks> {
    // rust: let Some(tag) = self.root.tag.get(kind.field()) else {
    // rust: return Ok(ChunkTicks::default());
}
    // rust: let mut ticks = tick_data::read_list(tag, resolve)?;
    // rust: ticks.retain(|tick| tick.pos.chunk() == self.position);
    // rust: Ok(ChunkTicks::from_saved(ticks))
}

    // rust: pub fn set_saved_ticks(
    // rust: &mut self,
    // rust: kind: TickKind,
    // rust: ticks: &[SavedTick],
    // rust: name: impl FnMut(TickTypeId) -> Option<String>,
    // rust: ) -> io::Result<()> {
    // rust: if ticks.iter().any(|tick| tick.pos.chunk() != self.position) {
    // rust: return Err(invalid("saved tick is outside this chunk"));
}
    // rust: let tag = tick_data::write_list(ticks, name)?;
    // rust: let Tag::Compound(map) = &mut self.root.tag else {
    // rust: unreachable!()
}
    // rust: map.insert(key(kind.field()), tag);
    // rust: Ok(())
}

section_index :: proc(self: ^Self, block: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if block.chunk() != self.position {
    // rust: return Err(invalid("block is outside this chunk"));
}
    // rust: let section_y = i8::try_from(block.y >> 4)
    // rust: .map_err(|_| invalid("block height outside saved section range"))?;
    // rust: let Tag::List(sections) = self.root.tag.get("sections").unwrap() else {
    // rust: unreachable!()
}
    // rust: Ok(sections
    // rust: .iter()
    // rust: .position(|s| s.get("Y") == Some(&Tag::Byte(section_y))))
}

block :: proc(self: ^Self, block: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let Some(index) = self.section_index(block)? else {
    // rust: return Ok(None);
}
    // rust: let Tag::List(sections) = self.root.tag.get("sections").unwrap() else {
    // rust: unreachable!()
}
    // rust: let Some(container) = sections[index].get("block_states") else {
    // rust: return Ok(None);
}
    // rust: let palette = PalettedContainer::from_nbt(container, 4096, 4)?;
    // rust: Ok(Some(BlockState::from_nbt(
    // rust: palette.get(block.section_index())?,
    // rust: )?))
}

    // Storage-only mutation. The caller must arrange simulation-derived updates
    // before treating this as a gameplay block placement.
set_block_data :: proc(self: ^Self, block: BlockPos, state: BlockState) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let index = self
    // rust: .section_index(block)?
    // rust: .ok_or_else(|| invalid("section is not present"))?;
    // rust: let Tag::List(sections) = self.root.tag.get_mut("sections").unwrap() else {
    // rust: unreachable!()
}
    // rust: let container = sections[index]
    // rust: .get_mut("block_states")
    // rust: .ok_or_else(|| invalid("section has no block-state data"))?;
    // rust: let mut palette = PalettedContainer::from_nbt(container, 4096, 4)?;
    // rust: let old = BlockState::from_nbt(palette.get(block.section_index())?)?;
    // rust: palette.set(block.section_index(), state.to_nbt())?;
    // rust: *container = palette.to_nbt();
    // rust: Ok(old)
}
}

// Resident section: 4,096 blocks stored as numeric palette entries. Uniform
// sections have no word array; property strings live in the shared registry.
// Palettes are almost always tiny, so a local id is a scan of that vector
// (the resident container does the same) with the last lookup cached: a run
// of one state costs a compare, and no section allocates a hash table.
    // rust: fn id_in(
    // rust: palette: &[BlockStateId],
    // rust: counts: &[u16],
    // rust: last: &mut Option<(BlockStateId, u32)>,
    // rust: state: BlockStateId,
    // rust: ) -> Option<u32> {
    // rust: if let Some((seen, id)) = *last
    // rust: && seen == state
    // rust: && counts[id as usize] != 0
    // rust: {
    // rust: return Some(id);
}
    // A dead slot is still on `free`; reviving it without removing it there
    // would let the next new state overwrite it. Only live slots count.
    // rust: let id = palette
    // rust: .iter()
    // rust: .zip(counts)
    // rust: .position(|(&v, &count)| count != 0 && v == state)? as u32;
    // rust: *last = Some((state, id));
    // rust: Some(id)
}
out_of_bounds :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: invalid("section index out of bounds")
}
BlockSection :: struct {
    palette: [dynamic]BlockStateId,
    last: Option<(BlockStateId,
    counts: [dynamic]u16,
    free: [dynamic]u32,
    storage: Maybe(PackedStorage),
    registry: ^'r BlockRegistry,
    extra: Compound,
}
    // rust: impl<'r> BlockSection<'r> {
    // The section's heap bytes: its packed storage, and its palette, counts
    // and free list (`horizon-ctl memory`; extra NBT not counted).
heap_bytes :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: self.storage.as_ref().map_or(0, PackedStorage::heap_bytes),
    // rust: self.palette.capacity() * std::mem::size_of::<BlockStateId>()
    // rust: + self.counts.capacity() * std::mem::size_of::<u16>()
    // rust: + self.free.capacity() * std::mem::size_of::<u32>(),
    // rust: ]
}
    // Bits per block of its packed storage, 0 for a single-state section.
storage_bits :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.storage.as_ref().map_or(0, PackedStorage::bits)
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.registry
}
uniform :: proc(state: BlockStateId, registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if registry.state(state).is_none() {
    // rust: return Err(invalid("state ID outside registry"));
}
    // rust: Ok(Self {
    // rust: palette: vec![state],
    // rust: last: Some((state, 0)),
    // rust: counts: vec![4096],
    // rust: free: Vec::new(),
    // rust: storage: None,
    // rust: registry,
    // rust: extra: Compound::new(),
    // rust: })
}
from_nbt :: proc(tag: ^Tag, registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let container = PalettedContainer::from_nbt(tag, 4096, 4)?;
    // rust: let resolved = container
    // rust: .palette
    // rust: .iter()
    // rust: .map(|tag| registry.resolve(&BlockState::from_nbt(tag)?))
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: let first_index = container.storage.as_ref().map_or(0, |s| s.get(0).unwrap()) as usize;
    // rust: let mut section = Self::uniform(resolved[first_index], registry)?;
    // rust: for index in 0..4096 {
    // rust: let id = container
    // rust: .storage
    // rust: .as_ref()
    // rust: .map_or(0, |s| s.get(index).unwrap()) as usize;
    // rust: section.set(index, resolved[id])?;
}
    // rust: section.extra = container.extra;
    // rust: Ok(section)
}
    // Test current distinct states without unpacking all 4,096 cells. The
    // predicate should be pure; unused palette slots are intentionally skipped.
any_state :: proc(self: ^Self, mut predicate: impl FnMut(BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.palette
    // rust: .iter()
    // rust: .zip(&self.counts)
    // rust: .any(|(&state, &count)| count != 0 && predicate(state))
}
bits :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.storage.as_ref().map_or(0, PackedStorage::bits)
}
get :: proc(self: ^Self, index: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if index >= 4096 {
    // rust: return Err(out_of_bounds());
}
    // rust: Ok(self.state(index))
}
    // Every state in index order, as [`state`](Self::state) reads them one by
    // one, unpacked word by word.
    // rust: pub(crate) fn fill_states(&self, out: &mut [u32; 4096]) {
    // rust: match &self.storage {
    // rust: None => out.fill(self.palette[0].0),
    // rust: Some(storage) => {
    // rust: storage.unpack_into(out);
    // rust: for v in out.iter_mut() {
    // rust: *v = self.palette[*v as usize].0;
}
}
}
}
    // The state at `index`, which must be below 4096 (a `local_index`).
    // rust: pub(crate) fn state(&self, index: usize) -> BlockStateId {
    // rust: debug_assert!(index < 4096);
    // rust: let id = self.storage.as_ref().map_or(0, |s| s.read(index));
    // rust: self.palette[id as usize]
}
    // The state of every block, when the section stores only one (no
    // word array).
    // rust: pub(crate) fn uniform_state(&self) -> Option<BlockStateId> {
    // rust: self.storage.is_none().then(|| self.palette[0])
}
set :: proc(self: ^Self, index: uint, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if index >= 4096 {
    // rust: return Err(invalid("section index out of bounds"));
}
    // rust: if state.0 as usize >= self.registry.len() {
    // rust: return Err(invalid("state ID outside registry"));
}
        // The slot at `index` is the old state's id, so no palette lookup is
        // needed for it; only the new state has to be resolved.
    // rust: let old_id = self.storage.as_ref().map_or(0, |s| s.read(index));
    // rust: let old = self.palette[old_id as usize];
    // rust: if old == state {
    // rust: return Ok(old);
}
    // rust: let id = match id_in(&self.palette, &self.counts, &mut self.last, state) {
    // rust: Some(id) => id,
    // rust: None if self.counts[old_id as usize] == 1 => {
                // Replacing the last occurrence can reuse its slot without repacking.
    // rust: self.palette[old_id as usize] = state;
    // rust: self.last = Some((state, old_id));
    // rust: return Ok(old);
}
    // rust: None => {
    // rust: if let Some(id) = self.free.pop() {
    // rust: self.palette[id as usize] = state;
    // rust: self.last = Some((state, id));
    // rust: id
    // rust: } else {
    // rust: let id = self.palette.len() as u32;
    // rust: let next_bits = bits_for_palette(self.palette.len() + 1, 4);
    // rust: if next_bits != self.bits() {
    // rust: let mut storage = PackedStorage::new(next_bits, 4096)
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: if let Some(old) = &self.storage {
    // rust: for i in 0..4096 {
    // rust: storage.write(i, old.read(i));
}
}
    // rust: self.storage = Some(storage);
}
    // rust: self.palette.push(state);
    // rust: self.counts.push(0);
    // rust: self.last = Some((state, id));
    // rust: id
}
}
}
    // rust: self.storage.as_mut().unwrap().write(index, id);
    // rust: self.counts[old_id as usize] -= 1;
    // rust: self.counts[id as usize] += 1;
    // rust: if self.counts[old_id as usize] == 0 {
    // rust: self.free.push(old_id);
    // rust: if self.last == Some((old, old_id)) {
    // rust: self.last = None;
}
}
    // rust: if self.counts[id as usize] == 4096 {
    // rust: self.palette = vec![state];
    // rust: self.last = Some((state, 0));
    // rust: self.counts = vec![4096];
    // rust: self.free.clear();
    // rust: self.storage = None;
}
    // rust: Ok(old)
}
    // Write `len` consecutive values at (`x`, `y_start..y_start+len`, `z`) with
    // `state`, all inside this section. Resolves the palette id once, then writes
    // the rest directly; returns how many previous blocks were `air` so the
    // caller can update its non-air count. The final palette and counts match
    // `len` calls to `set` in the same top-down order.
    // rust: pub fn fill_run(
    // rust: &mut self,
    // rust: x: i32,
    // rust: y_start: i32,
    // rust: z: i32,
    // rust: len: i32,
    // rust: state: BlockStateId,
    // rust: air: BlockStateId,
    // rust: ) -> io::Result<u16> {
    // rust: if !(0..16).contains(&x)
    // rust: || !(0..16).contains(&z)
    // rust: || len <= 0
    // rust: || y_start < 0
    // rust: || y_start + len > 16
    // rust: {
    // rust: return Err(invalid("section fill outside its bounds"));
}
    // rust: let index = |y: i32| ((y as usize) << 8) | ((z as usize) << 4) | x as usize;
    // rust: let top = y_start + len - 1;
    // rust: let mut added = 0u16;
        // The first write takes the general path: it may add the state to the
        // palette, allocate storage, or find the section already uniform.
    // rust: let old = self.set(index(top), state)?;
    // rust: if old == air {
    // rust: added += 1;
}
    // rust: let Some(id) = id_in(&self.palette, &self.counts, &mut self.last, state) else {
    // rust: return Ok(added);
}
    // rust: let Some(storage) = self.storage.as_mut() else {
    // rust: return Ok(added);
}
    // rust: for y in (y_start..top).rev() {
    // rust: let i = index(y);
    // rust: let old_id = storage.read(i);
    // rust: let old_state = self.palette[old_id as usize];
    // rust: if old_state == state {
    // rust: continue;
}
    // rust: storage.write(i, id);
    // rust: self.counts[old_id as usize] -= 1;
    // rust: self.counts[id as usize] += 1;
    // rust: if old_state == air {
    // rust: added += 1;
}
    // rust: if self.counts[old_id as usize] == 0 {
    // rust: self.free.push(old_id);
    // rust: if self.last == Some((old_state, old_id)) {
    // rust: self.last = None;
}
}
}
    // rust: if self.counts[id as usize] == 4096 {
    // rust: self.palette = vec![state];
    // rust: self.last = Some((state, 0));
    // rust: self.counts = vec![4096];
    // rust: self.free.clear();
    // rust: self.storage = None;
}
    // rust: Ok(added)
}
compact :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let values: Vec<_> = (0..4096).map(|i| self.get(i).unwrap()).collect();
    // rust: self.palette.clear();
    // rust: self.last = None;
    // rust: self.counts.clear();
    // rust: self.free.clear();
    // rust: for state in &values {
    // rust: if let Some(id) = id_in(&self.palette, &self.counts, &mut self.last, *state) {
    // rust: self.counts[id as usize] += 1;
    // rust: } else {
    // rust: self.palette.push(*state);
    // rust: self.counts.push(1);
    // rust: self.last = Some((*state, self.palette.len() as u32 - 1));
}
}
    // rust: let bits = bits_for_palette(self.palette.len(), 4);
    // rust: self.storage = if bits == 0 {
    // rust: None
    // rust: } else {
    // rust: let mut storage = PackedStorage::new(bits, 4096).map_err(|e| invalid(e.to_string()))?;
    // rust: let mut last = None;
    // rust: for (i, state) in values.iter().enumerate() {
    // rust: let id = id_in(&self.palette, &self.counts, &mut last, *state).unwrap();
    // rust: storage.set(i, id).unwrap();
}
    // rust: Some(storage)
}
    // rust: Ok(())
}
to_nbt :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut map = self.extra.clone();
    // rust: let palette = self
    // rust: .palette
    // rust: .iter()
    // rust: .map(|id| {
    // rust: self.registry
    // rust: .state(*id)
    // rust: .map(BlockState::to_nbt)
    // rust: .ok_or_else(|| invalid("state ID outside registry"))
    // rust: })
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: map.insert(key("palette"), Tag::List(palette));
    // rust: if let Some(storage) = &self.storage {
    // rust: map.insert(
    // rust: key("data"),
    // rust: Tag::LongArray(storage.words().iter().map(|&w| w as i64).collect()),
    // rust: );
}
    // rust: Ok(Tag::Compound(map))
}
}

    // rust: mod tests {
//     use super::*;
palette_grows_across_word_widths_and_compacts_to_uniform :: proc() {
}
    // rust: let mut palette = PalettedContainer::uniform(Tag::Int(0), 4096, 4).unwrap();
    // rust: for i in 0..4096 {
    // rust: palette.set(i, Tag::Int(i as i32)).unwrap();
}
    // rust: assert_eq!(palette.bits(), 12);
    // rust: let mut loaded = PalettedContainer::from_nbt(&palette.to_nbt(), 4096, 4).unwrap();
    // rust: for i in 0..4096 {
    // rust: assert_eq!(loaded.get(i).unwrap(), &Tag::Int(i as i32));
    // rust: loaded.set(i, Tag::Int(7)).unwrap();
}
    // rust: loaded.compact().unwrap();
    // rust: assert_eq!(loaded.bits(), 0);
    // rust: assert_eq!(loaded.palette_len(), 1);
    // rust: assert!(loaded.to_nbt().get("data").is_none());
    // rust: assert_eq!(loaded.get(4095).unwrap(), &Tag::Int(7));
}
invalid_palette_data_fails_before_access :: proc() {
}
    // rust: let mut tag = Tag::compound([("palette", Tag::List(vec![Tag::Int(0), Tag::Int(1)]))]);
    // rust: assert!(PalettedContainer::from_nbt(&tag, 4096, 4).is_err());
    // rust: let Tag::Compound(map) = &mut tag else {
    // rust: unreachable!()
}
    // rust: map.insert(key("data"), Tag::LongArray(vec![-1; 256]));
    // rust: assert!(PalettedContainer::from_nbt(&tag, 4096, 4).is_err());
}

    // The pre-optimization `get`, kept to compare against in the benchmark.
baseline_get :: proc(section: ^BlockSection<'_>, index: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if index >= 4096 {
    // rust: return Err(invalid("section index out of bounds"));
}
    // rust: let id = section
    // rust: .storage
    // rust: .as_ref()
    // rust: .map_or(0, |s| s.get(index).unwrap());
    // rust: Ok(section.palette[id as usize])
}
    // The pre-optimization `set`, kept to compare against in the benchmark.
    // rust: fn baseline_set(
    // rust: section: &mut BlockSection<'_>,
    // rust: index: usize,
    // rust: state: BlockStateId,
    // rust: ) -> io::Result<BlockStateId> {
    // rust: let old = baseline_get(section, index)?;
    // rust: if state.0 as usize >= section.registry.len() {
    // rust: return Err(invalid("state ID outside registry"));
}
    // rust: if old == state {
    // rust: return Ok(old);
}
        // Dead slots stay in `palette` but are on the free list: the old map
        // removed them, so only live entries count for either lookup.
    // rust: let old_id = section
    // rust: .palette
    // rust: .iter()
    // rust: .enumerate()
    // rust: .find(|&(id, &s)| s == old && section.counts[id] != 0)
    // rust: .map(|(id, _)| id as u32)
    // rust: .unwrap();
    // rust: let known = section
    // rust: .palette
    // rust: .iter()
    // rust: .enumerate()
    // rust: .find(|&(id, &s)| s == state && section.counts[id] != 0)
    // rust: .map(|(id, _)| id as u32);
    // rust: if section.counts[old_id as usize] == 1 && known.is_none() {
    // rust: section.palette[old_id as usize] = state;
    // rust: return Ok(old);
}
    // rust: let id = if let Some(id) = known {
    // rust: id
    // rust: } else if let Some(id) = section.free.pop() {
    // rust: section.palette[id as usize] = state;
    // rust: id
    // rust: } else {
    // rust: let id = section.palette.len() as u32;
    // rust: let next_bits = bits_for_palette(section.palette.len() + 1, 4);
    // rust: if next_bits != section.bits() {
    // rust: let mut storage =
    // rust: PackedStorage::new(next_bits, 4096).map_err(|e| invalid(e.to_string()))?;
    // rust: if let Some(old) = &section.storage {
    // rust: for i in 0..4096 {
    // rust: storage.set(i, old.get(i).unwrap()).unwrap();
}
}
    // rust: section.storage = Some(storage);
}
    // rust: section.palette.push(state);
    // rust: section.counts.push(0);
    // rust: id
}
    // rust: section
    // rust: .storage
    // rust: .as_mut()
    // rust: .unwrap()
    // rust: .set(index, id)
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: section.counts[old_id as usize] -= 1;
    // rust: section.counts[id as usize] += 1;
    // rust: if section.counts[old_id as usize] == 0 {
    // rust: section.free.push(old_id);
}
    // rust: if section.counts[id as usize] == 4096 {
    // rust: section.palette = vec![state];
    // rust: section.counts = vec![4096];
    // rust: section.free.clear();
    // rust: section.storage = None;
}
    // rust: Ok(old)
}

benchmark_registry :: proc(states: uint) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let list: Vec<Tag> = (0..states)
    // rust: .map(|i| {
    // rust: Tag::compound([("id", Tag::String(format!("minecraft:b{i}").as_str().into()))])
    // rust: })
    // rust: .collect();
    // rust: let defaults: std::collections::BTreeMap<_, _> = (0..states)
    // rust: .map(|i| {
    // rust: (
    // rust: JavaString::from(format!("minecraft:b{i}").as_str()),
    // rust: Tag::Int(i as i32),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let tag = Tag::compound([
    // rust: ("DataVersion", Tag::Int(crate::DATA_VERSION)),
    // rust: ("states", Tag::List(list)),
    // rust: ("defaults", Tag::Compound(defaults)),
    // rust: ]);
    // rust: BlockRegistry::from_nbt(&tag).unwrap()
}

    // `fill_states` reads what `state` reads at every index, from a uniform
    // section (no storage) through every palette width.
fill_states_matches_state :: proc() {
}
    // rust: let registry = benchmark_registry(64);
    // rust: for &(distinct, seed) in &[(1u64, 1u64), (2, 2), (16, 3), (17, 4), (64, 6)] {
    // rust: let mut section = BlockSection::uniform(BlockStateId(0), &registry).unwrap();
    // rust: let mut rng = seed.wrapping_mul(0x9e37_79b9_7f4a_7c15) | 1;
    // rust: let mut out = [0u32; 4096];
    // rust: for round in 0..4 {
    // rust: section.fill_states(&mut out);
    // rust: for (index, &value) in out.iter().enumerate() {
    // rust: assert_eq!(value, section.state(index).0, "round {round} index {index}");
}
    // rust: for _ in 0..2_000 {
    // rust: rng ^= rng << 13;
    // rust: rng ^= rng >> 7;
    // rust: rng ^= rng << 17;
    // rust: let index = (rng % 4096) as usize;
    // rust: let value = ((rng >> 20) % distinct) as u32;
    // rust: section.set(index, BlockStateId(value)).unwrap();
}
}
}
}

    // The optimized `set`/`get` must agree with the pre-optimization ones on
    // every field, across growth, collapse and reclaimed palette slots.
set_matches_baseline_under_random_edits :: proc() {
}
    // rust: let registry = benchmark_registry(64);
    // rust: for &(distinct, seed) in &[(1u64, 1u64), (2, 2), (16, 3), (17, 4), (24, 5), (64, 6)] {
    // rust: let mut base = BlockSection::uniform(BlockStateId(0), &registry).unwrap();
    // rust: let mut fast = BlockSection::uniform(BlockStateId(0), &registry).unwrap();
    // rust: let mut rng = seed.wrapping_mul(0x9e37_79b9_7f4a_7c15) | 1;
    // rust: let mut next = || {
    // rust: rng ^= rng << 13;
    // rust: rng ^= rng >> 7;
    // rust: rng ^= rng << 17;
    // rust: rng
}
    // rust: for step in 0..50_000u32 {
    // rust: if step % 5_000 == 4_999 {
    // rust: let value = (next() % distinct) as u32;
    // rust: for index in 0..4096 {
    // rust: assert_eq!(
    // rust: baseline_set(&mut base, index, BlockStateId(value)).unwrap(),
    // rust: fast.set(index, BlockStateId(value)).unwrap()
    // rust: );
}
    // rust: } else {
    // rust: let index = (next() % 4096) as usize;
    // rust: let value = (next() % distinct) as u32;
    // rust: assert_eq!(
    // rust: baseline_set(&mut base, index, BlockStateId(value)).unwrap(),
    // rust: fast.set(index, BlockStateId(value)).unwrap()
    // rust: );
}
    // rust: assert_eq!(base.bits(), fast.bits());
}
    // rust: assert_eq!(base.palette, fast.palette);
    // rust: assert_eq!(base.counts, fast.counts);
    // rust: assert_eq!(base.free, fast.free);
    // rust: for index in 0..4096 {
    // rust: assert_eq!(
    // rust: baseline_get(&base, index).unwrap(),
    // rust: fast.get(index).unwrap(),
    // rust: "distinct {distinct} index {index}"
    // rust: );
}
    // rust: assert_eq!(base.to_nbt().unwrap(), fast.to_nbt().unwrap());
}
}

    // A lookup must not revive a freed palette slot: the next new state pops
    // that slot off the free list and would silently overwrite it.
lookups_do_not_revive_freed_palette_slots :: proc() {
}
    // rust: let registry = benchmark_registry(8);
    // rust: let mut section = BlockSection::uniform(BlockStateId(0), &registry).unwrap();
    // rust: for (index, state) in [(3, 3), (0, 1), (0, 0), (1, 1), (2, 2)] {
    // rust: section.set(index, BlockStateId(state)).unwrap();
}
    // rust: assert_eq!(section.get(1).unwrap(), BlockStateId(1));
    // rust: assert_eq!(section.get(2).unwrap(), BlockStateId(2));
    // rust: assert_eq!(section.get(3).unwrap(), BlockStateId(3));
}

    // `set` and `get` against the pre-optimization implementations, on the same
    // edit stream. The result is checked before timing; 51 measured rounds
    // alternate order and report the median and best nanosecond-per-operation.
benchmark_section_get_set :: proc() {
}
//         use std::{hint::black_box, time::Instant};
OPS :: 50_000
ROUNDS :: 51
    // rust: let registry = benchmark_registry(32);
    // rust: let mut rng = 0x1234_5678_9abc_def1u64;
    // rust: let mut next = || {
    // rust: rng ^= rng << 13;
    // rust: rng ^= rng >> 7;
    // rust: rng ^= rng << 17;
    // rust: rng
}
    // rust: let ops: Vec<(usize, u32)> = (0..OPS)
    // rust: .map(|_| ((next() % 4096) as usize, (next() % 24) as u32))
    // rust: .collect();
    // rust: let make = || BlockSection::uniform(BlockStateId(0), &registry).unwrap();

    // rust: let mut base = make();
    // rust: let mut fast = make();
    // rust: for &(index, value) in &ops {
    // rust: assert_eq!(
    // rust: baseline_set(&mut base, index, BlockStateId(value)).unwrap(),
    // rust: fast.set(index, BlockStateId(value)).unwrap()
    // rust: );
}
    // rust: assert_eq!(base.bits(), fast.bits());
    // rust: assert_eq!(base.palette, fast.palette);
    // rust: assert_eq!(base.counts, fast.counts);
    // rust: assert_eq!(base.free, fast.free);
    // rust: assert_eq!(base.to_nbt().unwrap(), fast.to_nbt().unwrap());
    // rust: for i in 0..4096 {
    // rust: assert_eq!(baseline_get(&base, i).unwrap(), fast.get(i).unwrap());
}

    // rust: let mut times = [Vec::new(), Vec::new()];
    // rust: for round in 0..ROUNDS {
    // rust: for optimized in [round % 2 == 0, round % 2 != 0] {
    // rust: let mut section = make();
    // rust: let started = Instant::now();
    // rust: for &(index, value) in &ops {
    // rust: if optimized {
    // rust: section
    // rust: .set(black_box(index), black_box(BlockStateId(value)))
    // rust: .unwrap();
    // rust: } else {
    // rust: baseline_set(
    // rust: &mut section,
    // rust: black_box(index),
    // rust: black_box(BlockStateId(value)),
    // rust: )
    // rust: .unwrap();
}
}
    // rust: black_box(&section);
    // rust: if round > 0 {
    // rust: times[usize::from(optimized)]
    // rust: .push(started.elapsed().as_secs_f64() * 1e9 / OPS as f64);
}
}
}
    // rust: for values in &mut times {
    // rust: values.sort_by(f64::total_cmp);
}
    // rust: let median = |v: &[f64]| v[v.len() / 2];
    // rust: println!(
    // rust: "section set median: baseline {:.3} ns/op optimized {:.3} ns/op speedup {:.3}x",
    // rust: median(&times[0]),
    // rust: median(&times[1]),
    // rust: median(&times[0]) / median(&times[1])
    // rust: );
    // rust: println!(
    // rust: "section set best:   baseline {:.3} ns/op optimized {:.3} ns/op speedup {:.3}x",
    // rust: times[0][0],
    // rust: times[1][0],
    // rust: times[0][0] / times[1][0]
    // rust: );

    // rust: let mut get_times = [Vec::new(), Vec::new()];
    // rust: for round in 0..ROUNDS {
    // rust: for optimized in [round % 2 == 0, round % 2 != 0] {
    // rust: let started = Instant::now();
    // rust: let mut acc = 0u32;
    // rust: for &(index, _) in &ops {
    // rust: let state = if optimized {
    // rust: fast.get(black_box(index)).unwrap()
    // rust: } else {
    // rust: baseline_get(&base, black_box(index)).unwrap()
}
    // rust: acc ^= state.0;
}
    // rust: black_box(acc);
    // rust: if round > 0 {
    // rust: get_times[usize::from(optimized)]
    // rust: .push(started.elapsed().as_secs_f64() * 1e9 / OPS as f64);
}
}
}
    // rust: for values in &mut get_times {
    // rust: values.sort_by(f64::total_cmp);
}
    // rust: println!(
    // rust: "section get median: baseline {:.3} ns/op optimized {:.3} ns/op speedup {:.3}x",
    // rust: median(&get_times[0]),
    // rust: median(&get_times[1]),
    // rust: median(&get_times[0]) / median(&get_times[1])
    // rust: );
    // rust: println!(
    // rust: "section get best:   baseline {:.3} ns/op optimized {:.3} ns/op speedup {:.3}x",
    // rust: get_times[0][0],
    // rust: get_times[1][0],
    // rust: get_times[0][0] / get_times[1][0]
    // rust: );
}
}
