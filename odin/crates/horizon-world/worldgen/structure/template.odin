//! Transpiled from Horizon Rust crate
package horizon_world_template

import "core:fmt"
import "core:mem"
import "core:math"

// StructureTemplate: NBT loading, palettes, transforms and bounding boxes.
// use super::{BoundingBox, Mirror, Rotation, StateTransforms};
// use crate::{
    // rust: chunk::BlockState,
    // rust: nbt::{Compound, Tag},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use std::sync::{Arc, OnceLock};

BlockInfo :: struct {
    pos: [i32,
    state: BlockStateId,
    nbt: Maybe(Compound),
}
JigsawInfo :: struct {
    info: BlockInfo,
    rollable: bool,
    name: string,
    pool: string,
    target: string,
    placement_priority: i32,
    selection_priority: i32,
}
Palette :: struct {
    blocks: [dynamic]BlockInfo,
    jigsaws: OnceLock<[dynamic]JigsawInfo>,
}
    // rust: impl Palette {
blocks :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.blocks
}
}
// StructureTemplate.StructureEntityInfo: an entity saved with the template.
EntityInfo :: struct {
    pos: [f64,
    block_pos: [i32,
    nbt: Compound,
}
StructureTemplate :: struct {
    // The id it was loaded under (`StructureResources::template`); empty
    // for a template read from elsewhere.
    location: ^str,
    size: [i32,
    palettes: [dynamic]Palette,
    entities: [dynamic]EntityInfo,
}

int_list :: proc(tag: Maybe(^Tag)) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = [0; 3];
    // rust: if let Some(Tag::List(values)) = tag {
    // rust: for (slot, value) in out.iter_mut().zip(values) {
    // rust: if let Tag::Int(v) = value {
    // rust: *slot = *v;
}
}
}
    // rust: out
}
string :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
    // rust: fn get<'a>(compound: &'a Compound, key: &str) -> Option<&'a Tag> {
    // rust: compound.get(&crate::nbt::JavaString::from(key))
}
// NbtUtils.readBlockState: unknown blocks read as air; missing or invalid
// properties keep the block's defaults.
    // rust: pub(super) fn read_state(registry: &BlockRegistry, tag: &Tag) -> BlockStateId {
    // rust: let air = registry.default_state("minecraft:air").expect("air");
    // rust: let Tag::Compound(compound) = tag else {
    // rust: return air;
}
    // 26.3 writes `id`/`properties`; older templates use `Name`/`Properties`.
    // rust: let Some(name) = string(get(compound, "id")).or_else(|| string(get(compound, "Name"))) else {
    // rust: return air;
}
    // rust: let Some(default) = registry.default_state(&name) else {
    // rust: return air;
}
    // rust: let mut state = registry.state(default).unwrap().clone();
    // rust: if let Some(Tag::Compound(properties)) =
    // rust: get(compound, "properties").or_else(|| get(compound, "Properties"))
    // rust: {
    // rust: for (key, value) in properties {
    // rust: let (Tag::String(value), key) = (value, key.to_string_lossy()) else {
    // rust: continue;
}
    // rust: let value = value.to_string_lossy();
    // rust: if let Some(slot) = state.properties.get_mut(&key) {
    // rust: let previous = std::mem::replace(slot, value);
    // rust: if registry.id(&state).is_none() {
    // rust: *state.properties.get_mut(&key).unwrap() = previous;
}
}
}
}
    // rust: registry.id(&state).unwrap_or(default)
}
// Parse `name[key=value,...]` (BlockStateParser without NBT); None if invalid.
    // rust: pub(super) fn parse_state_string(registry: &BlockRegistry, text: &str) -> Option<BlockStateId> {
    // rust: let text = text.split('{').next().unwrap_or(text).trim();
    // rust: let (name, properties) = match text.split_once('[') {
    // rust: Some((name, rest)) => (name, rest.strip_suffix(']')?),
    // rust: None => (text, ""),
}
    // rust: let name = if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: let mut descriptor = BlockState {
    // rust: name,
    // rust: properties: Default::default(),
}
    // rust: for pair in properties.split(',').filter(|p| !p.trim().is_empty()) {
    // rust: let (k, v) = pair.split_once('=')?;
    // rust: descriptor
    // rust: .properties
    // rust: .insert(k.trim().to_owned(), v.trim().to_owned());
}
    // rust: registry.resolve(&descriptor).ok()
}

// `StructureTemplate.fillFromWorld`'s result written by `StructureTemplate.save`:
// the blocks (positions relative to the box) sorted full blocks, then other
// blocks, then block entities, each by y, x, z, the palette in first-use
// order, the entities and the size, with the data version. The author is not
// part of the file.
    // rust: pub fn save_nbt(
    // rust: registry: &BlockRegistry,
    // rust: transforms: &StateTransforms,
    // rust: size: [i32; 3],
    // rust: blocks: Vec<BlockInfo>,
    // rust: entities: &[EntityInfo],
    // rust: data_version: i32,
    // rust: ) -> Tag {
    // rust: let mut lists: [Vec<BlockInfo>; 3] = Default::default();
    // rust: for block in blocks {
    // rust: let class = if block.nbt.is_some() {
    // rust: 2
    // rust: } else if transforms.full_block(block.state) {
    // rust: 0
    // rust: } else {
    // rust: 1
}
    // rust: lists[class].push(block);
}
    // rust: let mut ordered = Vec::new();
    // rust: for mut list in lists {
    // rust: list.sort_by_key(|b| (b.pos[1], b.pos[0], b.pos[2]));
    // rust: ordered.extend(list);
}
    // rust: let int_list = |v: [i32; 3]| Tag::List(v.iter().map(|i| Tag::Int(*i)).collect());
    // rust: let mut palette: Vec<BlockStateId> = Vec::new();
    // rust: let mut block_list = Vec::with_capacity(ordered.len());
    // rust: for block in &ordered {
    // rust: let index = palette
    // rust: .iter()
    // rust: .position(|s| *s == block.state)
    // rust: .unwrap_or_else(|| {
    // rust: palette.push(block.state);
    // rust: palette.len() - 1
    // rust: });
    // rust: let mut tag = Compound::new();
    // rust: tag.insert("pos".into(), int_list(block.pos));
    // rust: tag.insert("state".into(), Tag::Int(index as i32));
    // rust: if let Some(nbt) = &block.nbt {
    // rust: tag.insert("nbt".into(), Tag::Compound(nbt.clone()));
}
    // rust: block_list.push(Tag::Compound(tag));
}
    // NbtUtils.writeBlockState: `id` and every property as a string.
    // rust: let palette_list = palette
    // rust: .iter()
    // rust: .map(|id| {
    // rust: let mut tag = Compound::new();
    // rust: if let Some(state) = registry.state(*id) {
    // rust: tag.insert("id".into(), Tag::String(state.name.as_str().into()));
    // rust: if !state.properties.is_empty() {
    // rust: let mut properties = Compound::new();
    // rust: for (k, v) in &state.properties {
    // rust: properties.insert(k.as_str().into(), Tag::String(v.as_str().into()));
}
    // rust: tag.insert("properties".into(), Tag::Compound(properties));
}
}
    // rust: Tag::Compound(tag)
    // rust: })
    // rust: .collect();
    // rust: let entity_list = entities
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let mut tag = Compound::new();
    // rust: tag.insert(
    // rust: "pos".into(),
    // rust: Tag::List(e.pos.iter().map(|v| Tag::Double(v.to_bits())).collect()),
    // rust: );
    // rust: tag.insert("blockPos".into(), int_list(e.block_pos));
    // rust: tag.insert("nbt".into(), Tag::Compound(e.nbt.clone()));
    // rust: Tag::Compound(tag)
    // rust: })
    // rust: .collect();
    // rust: let mut root = Compound::new();
    // rust: root.insert("blocks".into(), Tag::List(block_list));
    // rust: root.insert("palette".into(), Tag::List(palette_list));
    // rust: root.insert("entities".into(), Tag::List(entity_list));
    // rust: root.insert("size".into(), int_list(size));
    // rust: root.insert("DataVersion".into(), Tag::Int(data_version));
    // rust: Tag::Compound(root)
}

    // rust: impl StructureTemplate {
    // A new, never-loaded template: zero size and no palettes.
empty :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: location: "".into(),
    // rust: size: [0; 3],
    // rust: palettes: Vec::new(),
    // rust: entities: Vec::new(),
}
}
    // StructureTemplate.load. Blocks are ordered as vanilla orders them:
    // full collision blocks, then other blocks, then block entities, each
    // sorted by Y, X, Z.
from_nbt :: proc(tag: ^Tag, registry: ^BlockRegistry, transforms: ^StateTransforms) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let empty = Compound::new();
    // rust: let root = match tag {
    // rust: Tag::Compound(c) => c,
    // rust: _ => &empty,
}
    // rust: let size = int_list(get(root, "size"));
    // rust: let blocks = match get(root, "blocks") {
    // rust: Some(Tag::List(list)) => list.as_slice(),
    // rust: _ => &[],
}
    // rust: let mut palettes = Vec::new();
    // rust: let mut load = |palette: &[Tag]| {
    // rust: let states: Vec<BlockStateId> =
    // rust: palette.iter().map(|t| read_state(registry, t)).collect();
    // rust: let air = registry.default_state("minecraft:air").unwrap();
    // rust: let mut lists: [Vec<BlockInfo>; 3] = Default::default();
    // rust: for block in blocks {
    // rust: let Tag::Compound(block) = block else {
    // rust: continue;
}
    // rust: let index = match get(block, "state") {
    // rust: Some(Tag::Int(i)) => *i,
    // rust: _ => 0,
}
    // rust: let state = usize::try_from(index)
    // rust: .ok()
    // rust: .and_then(|i| states.get(i))
    // rust: .copied()
    // rust: .unwrap_or(air);
    // rust: let nbt = match get(block, "nbt") {
    // rust: Some(Tag::Compound(c)) => Some(c.clone()),
    // rust: _ => None,
}
    // rust: let class = if nbt.is_some() {
    // rust: 2
    // rust: } else if transforms.full_block(state) {
    // rust: 0
    // rust: } else {
    // rust: 1
}
    // rust: lists[class].push(BlockInfo {
    // rust: pos: int_list(get(block, "pos")),
    // rust: state,
    // rust: nbt,
    // rust: });
}
    // rust: let mut result = Vec::with_capacity(blocks.len());
    // rust: for mut list in lists {
    // rust: list.sort_by_key(|b| (b.pos[1], b.pos[0], b.pos[2]));
    // rust: result.extend(list);
}
    // rust: palettes.push(Palette {
    // rust: blocks: result,
    // rust: jigsaws: OnceLock::new(),
    // rust: });
}
    // rust: match get(root, "palettes") {
    // rust: Some(Tag::List(lists)) => {
    // rust: for list in lists {
    // rust: match list {
    // rust: Tag::List(p) => load(p),
    // rust: _ => load(&[]),
}
}
}
    // rust: _ => match get(root, "palette") {
    // rust: Some(Tag::List(p)) => load(p),
    // rust: _ => load(&[]),
    // rust: },
}
    // rust: let mut entities = Vec::new();
    // rust: if let Some(Tag::List(list)) = get(root, "entities") {
    // rust: for e in list {
    // rust: let Tag::Compound(e) = e else { continue };
    // rust: let Some(Tag::Compound(nbt)) = get(e, "nbt") else {
    // rust: continue;
}
    // rust: let mut pos = [0.0; 3];
    // rust: if let Some(Tag::List(p)) = get(e, "pos") {
    // rust: for (slot, v) in pos.iter_mut().zip(p) {
    // rust: if let Tag::Double(bits) = v {
    // rust: *slot = f64::from_bits(*bits);
}
}
}
    // rust: entities.push(EntityInfo {
    // rust: pos,
    // rust: block_pos: int_list(get(e, "blockPos")),
    // rust: nbt: nbt.clone(),
    // rust: });
}
}
    // rust: Self {
    // rust: location: "".into(),
    // rust: size,
    // rust: palettes,
    // rust: entities,
}
}
    // StructureTemplate.transform(Vec3, ...): entity positions.
    // rust: pub fn transform_vec(
    // rust: pos: [f64; 3],
    // rust: mirror: Mirror,
    // rust: rotation: Rotation,
    // rust: pivot: [i32; 3],
    // rust: ) -> [f64; 3] {
    // rust: let [mut x, y, mut z] = pos;
    // rust: match mirror {
    // rust: Mirror::LeftRight => z = 1.0 - z,
    // rust: Mirror::FrontBack => x = 1.0 - x,
    // rust: Mirror::None => {}
}
    // rust: let (px, pz) = (f64::from(pivot[0]), f64::from(pivot[2]));
    // rust: match rotation {
    // rust: Rotation::Counterclockwise90 => [px - pz + z, y, px + pz + 1.0 - x],
    // rust: Rotation::Clockwise90 => [px + pz + 1.0 - z, y, pz - px + x],
    // rust: Rotation::Clockwise180 => [px + px + 1.0 - x, y, pz + pz + 1.0 - z],
    // rust: Rotation::None => [x, y, z],
}
}
palettes :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.palettes
}
size :: proc(self: ^Self, rotation: Rotation) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match rotation {
    // rust: Rotation::Clockwise90 | Rotation::Counterclockwise90 => {
    // rust: [self.size[2], self.size[1], self.size[0]]
}
    // rust: _ => self.size,
}
}
    // rust: pub fn transform(
    // rust: pos: [i32; 3],
    // rust: mirror: Mirror,
    // rust: rotation: Rotation,
    // rust: pivot: [i32; 3],
    // rust: ) -> [i32; 3] {
    // rust: let [mut x, y, mut z] = pos;
    // rust: match mirror {
    // rust: Mirror::LeftRight => z = z.wrapping_neg(),
    // rust: Mirror::FrontBack => x = x.wrapping_neg(),
    // rust: Mirror::None => {}
}
    // rust: let (px, pz) = (pivot[0], pivot[2]);
    // rust: match rotation {
    // rust: Rotation::Counterclockwise90 => [px - pz + z, y, px + pz - x],
    // rust: Rotation::Clockwise90 => [px + pz - z, y, pz - px + x],
    // rust: Rotation::Clockwise180 => [px + px - x, y, pz + pz - z],
    // rust: Rotation::None => [x, y, z],
}
}
    // rust: pub fn zero_position_with_transform(
    // rust: zero: [i32; 3],
    // rust: mirror: Mirror,
    // rust: rotation: Rotation,
    // rust: size_x: i32,
    // rust: size_z: i32,
    // rust: ) -> [i32; 3] {
    // rust: let (sx, sz) = (size_x - 1, size_z - 1);
    // rust: let mx = if mirror == Mirror::FrontBack { sx } else { 0 };
    // rust: let mz = if mirror == Mirror::LeftRight { sz } else { 0 };
    // rust: let d = match rotation {
    // rust: Rotation::Counterclockwise90 => [mz, 0, sx - mx],
    // rust: Rotation::Clockwise90 => [sz - mz, 0, mx],
    // rust: Rotation::Clockwise180 => [sx - mx, 0, sz - mz],
    // rust: Rotation::None => [mx, 0, mz],
}
    // rust: [zero[0] + d[0], zero[1], zero[2] + d[2]]
}
    // rust: pub fn bounding_box(
    // rust: &self,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: pivot: [i32; 3],
    // rust: mirror: Mirror,
    // rust: ) -> BoundingBox {
    // rust: let delta = [self.size[0] - 1, self.size[1] - 1, self.size[2] - 1];
    // rust: let a = Self::transform([0; 3], mirror, rotation, pivot);
    // rust: let b = Self::transform(delta, mirror, rotation, pivot);
    // rust: BoundingBox::from_corners(a, b).moved(position)
}
    // The palette selected by StructurePlaceSettings.getRandomPalette.
palette_index :: proc(self: ^Self, random: ^impl horizon_core::random::RandomSource) -> u {
    // Ported from Horizon
    return {}
}
    // rust: random
    // rust: .next_int_bound(self.palettes.len().max(1) as i32)
    // rust: .unwrap_or(0) as usize
}
    // Jigsaw blocks of a palette, parsed from their block-entity data.
    // rust: pub fn jigsaws(
    // rust: &self,
    // rust: palette: usize,
    // rust: jigsaw_states: &dyn Fn(BlockStateId) -> Option<bool>,
    // rust: ) -> &[JigsawInfo] {
    // rust: let Some(palette) = self.palettes.get(palette) else {
    // rust: return &[];
}
    // rust: palette.jigsaws.get_or_init(|| {
    // rust: palette
    // rust: .blocks
    // rust: .iter()
    // rust: .filter_map(|info| {
    // rust: let horizontal = jigsaw_states(info.state)?;
    // rust: let nbt = info.nbt.clone().unwrap_or_default();
    // rust: let joint = string(get(&nbt, "joint"));
    // rust: let text = |key: &str, default: &str| {
    // rust: string(get(&nbt, key)).unwrap_or_else(|| default.to_owned())
}
    // rust: let int = |key: &str| match get(&nbt, key) {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: _ => 0,
}
    // rust: Some(JigsawInfo {
    // rust: rollable: match joint.as_deref() {
    // rust: Some("rollable") => true,
    // rust: Some("aligned") => false,
    // rust: _ => !horizontal,
    // rust: },
    // rust: name: text("name", "minecraft:empty"),
    // rust: pool: text("pool", "minecraft:empty"),
    // rust: target: text("target", "minecraft:empty"),
    // rust: placement_priority: int("placement_priority"),
    // rust: selection_priority: int("selection_priority"),
    // rust: info: info.clone(),
    // rust: })
    // rust: })
    // rust: .collect()
    // rust: })
}
}

    // rust: mod save_tests {
//     use super::*;
//     use horizon_core::version::DATA_VERSION;

registry :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let state = |name: &str| Tag::compound([("id", Tag::String(name.into()))]);
    // rust: let tag = Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![
    // rust: state("minecraft:air"),
    // rust: state("minecraft:stone"),
    // rust: state("minecraft:torch"),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound([
    // rust: ("minecraft:air", Tag::Int(0)),
    // rust: ("minecraft:stone", Tag::Int(1)),
    // rust: ("minecraft:torch", Tag::Int(2)),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: BlockRegistry::from_nbt(&tag).unwrap()
}

save_orders_like_fill_from_world_and_reads_back :: proc() {
}
    // rust: let registry = registry();
    // rust: let transforms = StateTransforms::from_json(
    // rust: r#"{"rotate":[[0,0,0],[1,1,1],[2,2,2]],"mirror":[[0,0],[1,1],[2,2]],
    // rust: "full_block":[false,true,false],"loot_containers":[],"block_entities":{}}"#,
    // rust: 3,
    // rust: )
    // rust: .unwrap();
    // rust: let block = |pos: [i32; 3], state: u32, nbt: bool| BlockInfo {
    // rust: pos,
    // rust: state: BlockStateId(state),
    // rust: nbt: nbt.then(|| {
    // rust: let mut c = Compound::new();
    // rust: c.insert("id".into(), Tag::String("minecraft:chest".into()));
    // rust: c
    // rust: }),
}
    // rust: let blocks = vec![
    // rust: block([0, 1, 0], 2, false),
    // rust: block([1, 0, 0], 1, false),
    // rust: block([0, 0, 0], 1, false),
    // rust: block([0, 0, 1], 2, true),
    // rust: ];
    // rust: let tag = save_nbt(&registry, &transforms, [2, 2, 2], blocks, &[], DATA_VERSION);
    // rust: assert_eq!(tag.get("DataVersion"), Some(&Tag::Int(DATA_VERSION)));
    // rust: assert_eq!(
    // rust: tag.get("size"),
    // rust: Some(&Tag::List(vec![Tag::Int(2), Tag::Int(2), Tag::Int(2)]))
    // rust: );
    // rust: let Some(Tag::List(palette)) = tag.get("palette") else {
    // rust: panic!("palette")
}
        // First use order: the stone full blocks come first.
    // rust: assert_eq!(palette.len(), 2);
    // rust: assert_eq!(
    // rust: palette[0].get("id"),
    // rust: Some(&Tag::String("minecraft:stone".into()))
    // rust: );
    // rust: let read = StructureTemplate::from_nbt(&tag, &registry, &transforms);
    // rust: assert_eq!(read.size, [2, 2, 2]);
    // rust: let blocks = read.palettes()[0].blocks();
    // rust: let order: Vec<_> = blocks.iter().map(|b| b.pos).collect();
        // Full blocks by y, x, z; then other blocks; block entities last.
    // rust: assert_eq!(order, [[0, 0, 0], [1, 0, 0], [0, 1, 0], [0, 0, 1]]);
    // rust: assert!(blocks[3].nbt.is_some());
}
}
