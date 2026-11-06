//! Transpiled from Horizon Rust crate
package horizon_world_jigsaw

import "core:fmt"
import "core:mem"
import "core:math"

// Template pools, pool elements and JigsawPlacement.
// use super::{
    // rust: BoundingBox, Mirror, Rotation, StructureResources, StructureTemplate,
    // rust: processor::{PlaceSettings, Processor, ProcessorList, place_in_world},
}
// use crate::{
    // rust: heightmap::HeightmapType,
    // rust: nbt::{Compound, Tag},
    // rust: worldgen::{
    // rust: DecodeError,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: },
}
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource, position_seed},
}
// use serde_json::Value;
// use std::{
    // rust: cell::RefCell,
    // rust: collections::{BTreeMap, BTreeSet, HashMap, VecDeque},
    // rust: rc::Rc,
    // rust: sync::{Arc, Mutex, OnceLock, RwLock},
}

Projection :: enum {
    Rigid,
    TerrainMatching,
}
    // rust: impl Projection {
    // `StructureTemplatePool.Projection.getSerializedName`.
saved_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Rigid => "rigid",
    // rust: Self::TerrainMatching => "terrain_matching",
}
}
}
PoolElement :: enum {
    Empty,
    Single {,
    template: Arc<StructureTemplate>,
    processors: ProcessorList,
        // The element's `processors` as written: a list id or an inline list,
        // saved back as it was.
    processors_source: Value,
    legacy: bool,
    projection: Projection,
    waterlogging: Option<bool>,
        // The piece's own terrain kernel in a structure that has one
        // (`"horizon:enhanced_terrain_adaptation"`).
    enhanced_terrain: Option<Arc<super::enhanced_terrain::Adaptation>>,
        // getGroundLevelDelta: 1, or Formations' `ground_level`
        // (`"horizon:ground_level"`).
    ground_level: i32,
    // rust: },
    Feature {,
    feature: String,
    projection: Projection,
    // rust: },
    List {,
    elements: Vec<PoolElement>,
    projection: Projection,
    // rust: },
}
Jigsaw :: struct {
    pos: [i32,
    front: Direction,
    top: Direction,
    rollable: bool,
    name: Option<std::borrow::Cow<'a,
    pool: std::borrow::Cow<'a,
    target: std::borrow::Cow<'a,
    placement_priority: i32,
    selection_priority: i32,
}
direction :: proc(name: string) -> D {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "down" => Direction::Down,
    // rust: "up" => Direction::Up,
    // rust: "north" => Direction::North,
    // rust: "south" => Direction::South,
    // rust: "west" => Direction::West,
    // rust: _ => Direction::East,
}
}
opposite :: proc(d: Direction) -> D {
    // Ported from Horizon
    return {}
}
    // rust: match d {
    // rust: Direction::Down => Direction::Up,
    // rust: Direction::Up => Direction::Down,
    // rust: Direction::North => Direction::South,
    // rust: Direction::South => Direction::North,
    // rust: Direction::West => Direction::East,
    // rust: Direction::East => Direction::West,
}
}
    // rust: pub(super) fn step(d: Direction) -> [i32; 3] {
    // rust: let n = d.normal();
    // rust: [n[0], n[1], n[2]]
}
// Util.shuffle.
    // rust: pub(super) fn shuffle<T>(list: &mut [T], random: &mut impl RandomSource) {
    // rust: for i in (2..=list.len()).rev() {
    // rust: let swap = random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: list.swap(i - 1, swap);
}
}
projection :: proc(value: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match value["projection"].as_str() {
    // rust: Some("rigid") => Ok(Projection::Rigid),
    // rust: Some("terrain_matching") => Ok(Projection::TerrainMatching),
    // rust: _ => Err(DecodeError::Field("pool element projection")),
}
}
    // rust: impl PoolElement {
    // rust: fn decode(
    // rust: value: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: inherited: Option<Projection>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let kind = value["element_type"].as_str().unwrap_or_default();
    // rust: let projection = || match inherited {
    // rust: Some(p) => Ok(p),
    // rust: None => projection(value),
}
    // rust: Ok(match kind {
    // rust: "minecraft:empty_pool_element" => Self::Empty,
            // Lithostitched's elements place what their `delegate` places;
            // their limits are the pool entry's (`Pool::limits`).
    // rust: "lithostitched:limited" | "lithostitched:guaranteed" | "lithostitched:delegating" => {
    // rust: Self::decode(&value["delegate"], resources, bindings, inherited)?
}
            // YUNG's API's element places what a single element places; its
            // own fields are the pool entry's rules (`Pool::rules`).
    // rust: "minecraft:single_pool_element"
    // rust: | "minecraft:legacy_single_pool_element"
    // rust: | "yungsapi:yung_single_element" => {
    // rust: let location = value["location"]
    // rust: .as_str()
    // rust: .ok_or(DecodeError::Field("location"))?;
    // rust: Self::Single {
    // rust: template: resources.template(location).ok_or_else(|| {
    // rust: DecodeError::Registry(format!("missing template {location}"))
    // rust: })?,
    // rust: processors: ProcessorList::decode(
    // rust: &value["processors"].to_string(),
    // rust: resources,
    // rust: bindings,
    // rust: )?,
    // rust: processors_source: value["processors"].clone(),
    // rust: legacy: kind == "minecraft:legacy_single_pool_element",
    // rust: projection: projection()?,
    // rust: waterlogging: match value
    // rust: .get("override_liquid_settings")
    // rust: .and_then(Value::as_str)
    // rust: {
    // rust: Some("apply_waterlogging") => Some(true),
    // rust: Some("ignore_waterlogging") => Some(false),
    // rust: _ => None,
    // rust: },
    // rust: enhanced_terrain: value
    // rust: .get("horizon:enhanced_terrain_adaptation")
    // rust: .map(|a| super::enhanced_terrain::Adaptation::decode(a).map(Arc::new))
    // rust: .transpose()?,
    // rust: ground_level: match value.get("horizon:ground_level") {
    // rust: None => 1,
    // rust: Some(v) => v
    // rust: .as_u64()
    // rust: .and_then(|g| i32::try_from(g).ok())
    // rust: .ok_or(DecodeError::Field("horizon:ground_level"))?,
    // rust: },
}
}
    // rust: "minecraft:feature_pool_element" => Self::Feature {
    // rust: feature: value["feature"].as_str().unwrap_or_default().to_owned(),
    // rust: projection: projection()?,
    // rust: },
    // rust: "minecraft:list_pool_element" => {
    // rust: let p = projection()?;
    // rust: Self::List {
    // rust: elements: value["elements"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("list elements"))?
    // rust: .iter()
    // rust: .map(|e| Self::decode(e, resources, bindings, Some(p)))
    // rust: .collect::<Result<_, _>>()?,
    // rust: projection: p,
}
}
    // rust: _ => return Err(DecodeError::Field("pool element type")),
    // rust: })
}
    // `StructurePoolElement.CODEC`'s encoding, as a jigsaw piece saves it.
save :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let text = |s: &str| Tag::String(s.into());
    // rust: match self {
    // rust: Self::Empty => Tag::compound([("element_type", text("minecraft:empty_pool_element"))]),
    // rust: Self::Single {
    // rust: template,
    // rust: processors_source,
    // rust: legacy,
    // rust: projection,
    // rust: waterlogging,
    // rust: ..
    // rust: } => {
    // rust: let kind = if *legacy {
    // rust: "minecraft:legacy_single_pool_element"
    // rust: } else {
    // rust: "minecraft:single_pool_element"
}
    // rust: let mut entries = vec![
    // rust: ("element_type", text(kind)),
    // rust: ("location", text(&template.location)),
    // rust: (
    // rust: "processors",
    // rust: super::processor::json_to_nbt(processors_source),
    // rust: ),
    // rust: ("projection", text(projection.saved_name())),
    // rust: ];
    // rust: if let Some(apply) = waterlogging {
    // rust: let settings = if *apply {
    // rust: "apply_waterlogging"
    // rust: } else {
    // rust: "ignore_waterlogging"
}
    // rust: entries.push(("override_liquid_settings", text(settings)));
}
    // rust: Tag::compound(entries)
}
    // rust: Self::Feature {
    // rust: feature,
    // rust: projection,
    // rust: } => Tag::compound([
    // rust: ("element_type", text("minecraft:feature_pool_element")),
    // rust: ("feature", text(feature)),
    // rust: ("projection", text(projection.saved_name())),
    // rust: ]),
    // rust: Self::List {
    // rust: elements,
    // rust: projection,
    // rust: } => Tag::compound([
    // rust: ("element_type", text("minecraft:list_pool_element")),
    // rust: (
    // rust: "elements",
    // rust: Tag::List(elements.iter().map(Self::save).collect()),
    // rust: ),
    // rust: ("projection", text(projection.saved_name())),
    // rust: ]),
}
}
projection :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Empty => Projection::TerrainMatching,
    // rust: Self::Single { projection, .. }
    // rust: | Self::Feature { projection, .. }
    // rust: | Self::List { projection, .. } => *projection,
}
}
size :: proc(self: ^Self, rotation: Rotation) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Empty | Self::Feature { .. } => [0; 3],
    // rust: Self::Single { template, .. } => template.size(rotation),
    // rust: Self::List { elements, .. } => elements.iter().fold([0; 3], |acc, e| {
    // rust: let s = e.size(rotation);
    // rust: std::array::from_fn(|i| acc[i].max(s[i]))
    // rust: }),
}
}
bounding_box :: proc(self: ^Self, position: [i32; 3], rotation: Rotation) -> B {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Empty => BoundingBox::new(position, position),
    // rust: Self::Feature { .. } => BoundingBox::new(position, position),
    // rust: Self::Single { template, .. } => {
    // rust: template.bounding_box(position, rotation, [0; 3], Mirror::None)
}
    // rust: Self::List { elements, .. } => {
    // rust: let mut boxes = elements
    // rust: .iter()
    // rust: .filter(|e| !matches!(e, Self::Empty))
    // rust: .map(|e| e.bounding_box(position, rotation));
    // rust: let mut first = boxes.next().unwrap_or(BoundingBox::new(position, position));
    // rust: for b in boxes {
    // rust: first.encapsulate(&b);
}
    // rust: first
}
}
}
    // getShuffledJigsawBlocks.
    // rust: pub fn shuffled_jigsaws<'a>(
    // rust: &'a self,
    // rust: resources: &StructureResources,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Vec<Jigsaw<'a>> {
    // rust: match self {
    // rust: Self::Empty => Vec::new(),
    // rust: Self::Feature { .. } => vec![Jigsaw {
    // rust: pos: position,
    // rust: front: Direction::Down,
    // rust: top: Direction::South,
    // rust: rollable: true,
    // rust: name: None,
    // rust: pool: "minecraft:empty".into(),
    // rust: target: "minecraft:empty".into(),
    // rust: placement_priority: 0,
    // rust: selection_priority: 0,
    // rust: }],
    // rust: Self::List { elements, .. } => elements
    // rust: .first()
    // rust: .map(|e| e.shuffled_jigsaws(resources, position, rotation, random))
    // rust: .unwrap_or_default(),
    // rust: Self::Single { template, .. } => {
    // rust: let mut jigsaws = template_jigsaws(resources, template, position, rotation);
    // rust: shuffle(&mut jigsaws, random);
    // rust: jigsaws.sort_by_key(|j| std::cmp::Reverse(j.selection_priority));
    // rust: jigsaws
}
}
}
ground_level_delta :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Single { ground_level, .. } => *ground_level,
    // rust: _ => 1,
}
}
    // The piece's own terrain kernel, in place of its structure's.
enhanced_terrain :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Single {
    // rust: enhanced_terrain, ..
    // rust: } => enhanced_terrain.as_deref(),
    // rust: _ => None,
}
}
}
// StructureTemplate.getJigsaws: palette chosen by a position-seeded random.
    // rust: fn template_jigsaws<'a>(
    // rust: resources: &StructureResources,
    // rust: template: &'a StructureTemplate,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: ) -> Vec<Jigsaw<'a>> {
    // rust: if template.palettes().is_empty() {
    // rust: return Vec::new();
}
    // rust: let palette = LegacyRandom::new(position_seed(BlockPos::new(
    // rust: position[0],
    // rust: position[1],
    // rust: position[2],
    // rust: )))
    // rust: .next_int_bound(template.palettes().len() as i32)
    // rust: .unwrap_or(0) as usize;
    // rust: template
    // rust: .jigsaws(palette, &|state| resources.jigsaw_horizontal(state))
    // rust: .iter()
    // rust: .map(|j| {
    // rust: let relative = StructureTemplate::transform(j.info.pos, Mirror::None, rotation, [0; 3]);
    // rust: let state = resources.transforms.rotate(j.info.state, rotation);
    // rust: let orientation = resources
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("orientation").map(String::as_str))
    // rust: .unwrap_or_default();
    // rust: let (front, top) = orientation.split_once('_').unwrap_or(("north", "up"));
    // rust: Jigsaw {
    // rust: pos: std::array::from_fn(|i| relative[i] + position[i]),
    // rust: front: direction(front),
    // rust: top: direction(top),
    // rust: rollable: j.rollable,
    // rust: name: Some(std::borrow::Cow::Borrowed(&j.name)),
    // rust: pool: std::borrow::Cow::Borrowed(&j.pool),
    // rust: target: std::borrow::Cow::Borrowed(&j.target),
    // rust: placement_priority: j.placement_priority,
    // rust: selection_priority: j.selection_priority,
}
    // rust: })
    // rust: .collect()
}
    // rust: pub(super) fn can_attach(source: &Jigsaw, target: &Jigsaw) -> bool {
    // rust: source.front == opposite(target.front)
    // rust: && (source.rollable || source.top == target.top)
    // rust: && target
    // rust: .name
    // rust: .as_ref()
    // rust: .is_none_or(|name| *name == source.target)
}

Pool :: struct {
    // Each element repeated by its weight.
    // rust: pub(super) templates: Vec<Arc<PoolElement>>,
    // The entry of `raw` each of `templates` repeats.
    entries: [dynamic]uint,
    // The elements with their weights, in file order (`rawTemplates`).
    // rust: pub(super) raw: Vec<(Arc<PoolElement>, i32)>,
    // Per entry of `raw`: a YUNG element's rules.
    rules: [dynamic]Rules,
    // Per entry of `raw`: a Lithostitched `limited` or `guaranteed`
    // element's limit.
    limits: [dynamic]Maybe(Limit),
    // The entries of `raw` that are Lithostitched's `guaranteed` elements.
    guaranteed: [dynamic]uint,
    // rust: pub(super) fallback: String,
    max_size: OnceLock<i32>,
}
    // rust: impl Pool {
    // rust: pub(super) fn random_template(&self, random: &mut impl RandomSource) -> Arc<PoolElement> {
    // rust: if self.templates.is_empty() {
    // rust: return Arc::new(PoolElement::Empty);
}
    // rust: self.templates[random
    // rust: .next_int_bound(self.templates.len() as i32)
    // rust: .unwrap_or(0) as usize]
    // rust: .clone()
}
    // The entries of `templates`, shuffled.
shuffled :: proc(self: ^Self, random: ^impl RandomSource) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut order: Vec<usize> = (0..self.templates.len()).collect();
    // rust: shuffle(&mut order, random);
    // rust: order.into_iter().map(|i| self.entries[i]).collect()
}
    // YUNG's API's pick: `nextInt` of the entries' total weight, walked in
    // `order` (indices into `raw`); the entry that takes it below zero.
weighted :: proc(self: ^Self, order: ^[uint], random: ^impl RandomSource) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let total: i32 = order.iter().map(|&i| self.raw[i].1).sum();
    // rust: let mut pick = random.next_int_bound(total).ok()?;
    // rust: order.iter().position(|&i| {
    // rust: pick -= self.raw[i].1;
    // rust: pick < 0
    // rust: })
}
    // rust: pub(super) fn max_size(&self) -> i32 {
    // rust: *self.max_size.get_or_init(|| {
    // rust: self.templates
    // rust: .iter()
    // rust: .filter(|t| !matches!(t.as_ref(), PoolElement::Empty))
    // rust: .map(|t| t.bounding_box([0; 3], Rotation::None).span()[1])
    // rust: .max()
    // rust: .unwrap_or(0)
    // rust: })
}
}
// A `yungsapi:yung_single_element`'s own fields (spec-yungsapi §3, §3.2).
Rules :: struct {
    // `name` and `max_count`: the most pieces of that name in one start,
    // the start not counted.
    limit: Maybe((Arc<str),
    // `is_priority`: tried before the pool's other entries, in the
    // shuffled order and without a weighted draw.
    priority: bool,
    // `min_required_depth`: the least depth of the parent piece (the start
    // is depth 0).
    min_depth: i32,
    // `ignore_bounds`: placed without the free-space test.
    ignore_bounds: bool,
}
    // rust: impl Rules {
of :: proc(element: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if element["element_type"] != "yungsapi:yung_single_element" {
    // rust: return Self::default();
}
    // rust: Self {
    // rust: limit: element["name"]
    // rust: .as_str()
    // rust: .zip(element["max_count"].as_i64())
    // rust: .map(|(name, max)| (name.into(), max as i32)),
    // rust: priority: element["is_priority"].as_bool().unwrap_or(false),
    // rust: min_depth: element["min_required_depth"].as_i64().unwrap_or(0) as i32,
    // rust: ignore_bounds: element["ignore_bounds"].as_bool().unwrap_or(false),
}
}
}
// How many pieces of a Lithostitched `limited` or `guaranteed` element one
// start may hold, and where (spec-lithostitched §3).
Limit :: struct {
    // The pieces counted together: the element itself (its JSON), wherever
    // it is listed.
    key: ^str,
    max: i32,
    // The parent piece's least depth (the start is at 0).
    min_depth: i32,
    // `lithostitched:guaranteed`: tried before its pool's other entries.
    guaranteed: bool,
}
    // rust: impl Limit {
of :: proc(element: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let int = |key: &str| {
    // rust: element[key]
    // rust: .as_i64()
    // rust: .map(|v| v.clamp(0, i32::MAX.into()) as i32)
}
    // rust: let (max, guaranteed) = match element["element_type"].as_str()? {
    // rust: "lithostitched:limited" => (int("limit")?, false),
    // rust: "lithostitched:guaranteed" => (int("count").unwrap_or(1), true),
    // rust: _ => return None,
}
    // rust: Some(Self {
    // rust: key: element.to_string().into(),
    // rust: max,
    // rust: min_depth: int("min_depth").unwrap_or(0),
    // rust: guaranteed,
    // rust: })
}
    // Whether one more piece may go below a parent at `depth`.
allows :: proc(self: ^Self, counts: ^HashMap<^str, depth: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: depth >= self.min_depth && counts.get(&self.key).copied().unwrap_or(0) < self.max
}
}
// Lazily decoded template pools.
Pools :: struct {
    raw: BTreeMap<string,
    decoded: RwLock<HashMap<string,
}
    // rust: impl std::fmt::Debug for Pools {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str("Pools")
}
}
    // rust: impl Pools {
new :: proc(raw: BTreeMap<string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: raw,
    // rust: decoded: RwLock::new(HashMap::new()),
}
}
    // rust: pub fn get(
    // rust: &self,
    // rust: name: &str,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Option<Arc<Pool>> {
    // rust: if let Some(found) = self.decoded.read().unwrap().get(name) {
    // rust: return found.clone();
}
    // rust: let pool = self.raw.get(name).and_then(|json| {
    // rust: let value: Value = serde_json::from_str(json).ok()?;
    // rust: let (mut templates, mut entries, mut raw, mut rules, mut limits) =
    // rust: (Vec::new(), Vec::new(), Vec::new(), Vec::new(), Vec::new());
    // rust: for entry in value["elements"].as_array()? {
    // rust: let element =
    // rust: match PoolElement::decode(&entry["element"], resources, bindings, None) {
    // rust: Ok(element) => Arc::new(element),
    // rust: Err(error) => {
                            // Vanilla refuses the data pack; here every structure using the
                            // pool stops generating, so the reason is the only clue a mod author gets.
                            // Once per pool: each worker decodes its own copy.
WARNED :: Mutex::new(BTreeSet::new())
    // rust: if WARNED.lock().unwrap().insert(name.to_owned()) {
    // rust: log::warn!("Horizon: template pool {name} is left out: {error}");
}
    // rust: return None;
}
}
    // rust: let weight = entry["weight"].as_i64().unwrap_or(1);
    // rust: for _ in 0..weight {
    // rust: templates.push(element.clone());
    // rust: entries.push(raw.len());
}
    // rust: raw.push((element, weight as i32));
    // rust: rules.push(Rules::of(&entry["element"]));
    // rust: limits.push(Limit::of(&entry["element"]));
}
    // rust: let guaranteed = (limits.iter().enumerate())
    // rust: .filter(|(_, l)| l.as_ref().is_some_and(|l| l.guaranteed))
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: Some(Arc::new(Pool {
    // rust: templates,
    // rust: entries,
    // rust: raw,
    // rust: rules,
    // rust: limits,
    // rust: guaranteed,
    // rust: fallback: value["fallback"]
    // rust: .as_str()
    // rust: .unwrap_or("minecraft:empty")
    // rust: .to_owned(),
    // rust: max_size: OnceLock::new(),
    // rust: }))
    // rust: });
    // rust: self.decoded
    // rust: .write()
    // rust: .unwrap()
    // rust: .insert(name.to_owned(), pool.clone());
    // rust: pool
}
}

Junction :: struct {
    source_x: i32,
    source_ground_y: i32,
    source_z: i32,
    // Saved only (`JigsawJunction.deltaY`, `destProjection`).
    delta_y: i32,
    dest_projection: Projection,
}
PoolPiece :: struct {
    element: ^PoolElement,
    position: [i32,
    ground_level_delta: i32,
    rotation: Rotation,
    bounding_box: BoundingBox,
    junctions: [dynamic]Junction,
    waterlogging: bool,
}
    // rust: impl PoolPiece {
    // A piece as a saved start lists it (PoolElementStructurePiece's tag:
    // `pool_element`, `PosX`/`PosY`/`PosZ`, `rotation`, `ground_level_delta`,
    // `BB`, `junctions`, `liquid_settings`), in JSON. Harnesses place another
    // game's layout with it.
    // rust: pub fn from_saved(
    // rust: v: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let int = |v: &Value, key: &'static str| {
    // rust: v[key]
    // rust: .as_i64()
    // rust: .and_then(|i| i32::try_from(i).ok())
    // rust: .ok_or(DecodeError::Field(key))
}
    // rust: let corners: Vec<i32> = v["BB"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|i| i32::try_from(i.as_i64()?).ok())
    // rust: .collect();
    // rust: let [x0, y0, z0, x1, y1, z1]: [i32; 6] =
    // rust: corners.try_into().map_err(|_| DecodeError::Field("BB"))?;
    // rust: let rotation = match v["rotation"].as_str() {
    // rust: Some("NONE") => Rotation::None,
    // rust: Some("CLOCKWISE_90") => Rotation::Clockwise90,
    // rust: Some("CLOCKWISE_180") => Rotation::Clockwise180,
    // rust: Some("COUNTERCLOCKWISE_90") => Rotation::Counterclockwise90,
    // rust: _ => return Err(DecodeError::Field("rotation")),
}
    // rust: let junctions = v["junctions"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|j| {
    // rust: Ok(Junction {
    // rust: source_x: int(j, "source_x")?,
    // rust: source_ground_y: int(j, "source_ground_y")?,
    // rust: source_z: int(j, "source_z")?,
    // rust: delta_y: int(j, "delta_y")?,
    // rust: dest_projection: match j["dest_proj"].as_str() {
    // rust: Some("rigid") => Projection::Rigid,
    // rust: Some("terrain_matching") => Projection::TerrainMatching,
    // rust: _ => return Err(DecodeError::Field("dest_proj")),
    // rust: },
    // rust: })
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: Ok(Self {
    // rust: element: Arc::new(PoolElement::decode(
    // rust: &v["pool_element"],
    // rust: resources,
    // rust: bindings,
    // rust: None,
    // rust: )?),
    // rust: position: [int(v, "PosX")?, int(v, "PosY")?, int(v, "PosZ")?],
    // rust: ground_level_delta: int(v, "ground_level_delta")?,
    // rust: rotation,
    // rust: bounding_box: BoundingBox::new([x0, y0, z0], [x1, y1, z1]),
    // rust: junctions,
    // rust: waterlogging: v["liquid_settings"].as_str() != Some("ignore_waterlogging"),
    // rust: })
}
    // `PoolElementStructurePiece`'s tag (always genDepth 0, no orientation).
save :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = super::legacy::piece_tag("minecraft:jigsaw", self.bounding_box, None, 0);
    // rust: let junctions = self
    // rust: .junctions
    // rust: .iter()
    // rust: .map(|j| {
    // rust: Tag::compound([
    // rust: ("source_x", Tag::Int(j.source_x)),
    // rust: ("source_ground_y", Tag::Int(j.source_ground_y)),
    // rust: ("source_z", Tag::Int(j.source_z)),
    // rust: ("delta_y", Tag::Int(j.delta_y)),
    // rust: (
    // rust: "dest_proj",
    // rust: Tag::String(j.dest_projection.saved_name().into()),
    // rust: ),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: for (key, value) in [
    // rust: ("PosX", Tag::Int(self.position[0])),
    // rust: ("PosY", Tag::Int(self.position[1])),
    // rust: ("PosZ", Tag::Int(self.position[2])),
    // rust: ("ground_level_delta", Tag::Int(self.ground_level_delta)),
    // rust: ("pool_element", self.element.save()),
    // rust: ("rotation", Tag::String(self.rotation.saved_name().into())),
    // rust: ("junctions", Tag::List(junctions)),
    // rust: ] {
    // rust: tag.insert(key.into(), value);
}
        // LiquidSettings.APPLY_WATERLOGGING, the default, is not written.
    // rust: if !self.waterlogging {
    // rust: tag.insert(
    // rust: "liquid_settings".into(),
    // rust: Tag::String("ignore_waterlogging".into()),
    // rust: );
}
    // rust: tag
}
    // rust: pub(super) fn moved(&mut self, dy: i32) {
    // rust: self.position[1] += dy;
    // rust: self.bounding_box = self.bounding_box.moved([0, dy, 0]);
}
    // PoolElementStructurePiece.postProcess.
    // rust: pub fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: random: &mut R,
    // rust: chunk_box: BoundingBox,
    // rust: reference: [i32; 3],
    // rust: keep_jigsaws: bool,
    // rust: place_feature: &mut PlaceFeature<'_, W, R>,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: place_element(
    // rust: &self.element,
    // rust: world,
    // rust: resources,
    // rust: random,
    // rust: chunk_box,
    // rust: self.position,
    // rust: reference,
    // rust: self.rotation,
    // rust: self.waterlogging,
    // rust: keep_jigsaws,
    // rust: place_feature,
    // rust: )
}
}
GRAVITY :: OnceLock::new()
IGNORE_STRUCTURE_BLOCK :: OnceLock::new()
IGNORE_STRUCTURE_AND_AIR :: OnceLock::new()
    // rust: fn place_element<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: element: &PoolElement,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: random: &mut R,
    // rust: chunk_box: BoundingBox,
    // rust: position: [i32; 3],
    // rust: reference: [i32; 3],
    // rust: rotation: Rotation,
    // rust: waterlogging: bool,
    // rust: keep_jigsaws: bool,
    // rust: place_feature: &mut PlaceFeature<'_, W, R>,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: match element {
    // rust: PoolElement::Empty => Ok(true),
    // rust: PoolElement::Feature { feature, .. } => place_feature(world, random, feature, position),
    // rust: PoolElement::List { elements, .. } => {
    // rust: for e in elements {
    // rust: if !place_element(
    // rust: e,
    // rust: world,
    // rust: resources,
    // rust: random,
    // rust: chunk_box,
    // rust: position,
    // rust: reference,
    // rust: rotation,
    // rust: waterlogging,
    // rust: keep_jigsaws,
    // rust: place_feature,
    // rust: )? {
    // rust: return Ok(false);
}
}
    // rust: Ok(true)
}
    // rust: PoolElement::Single {
    // rust: template,
    // rust: processors,
    // rust: legacy,
    // rust: projection,
    // rust: waterlogging: override_liquid,
    // rust: ..
    // rust: } => {
    // rust: let ignore = if *legacy {
    // rust: IGNORE_STRUCTURE_AND_AIR.get_or_init(|| {
    // rust: Processor::BlockIgnore(
    // rust: [
    // rust: "minecraft:structure_block".to_owned(),
    // rust: "minecraft:air".to_owned(),
    // rust: ]
    // rust: .into(),
    // rust: )
    // rust: })
    // rust: } else {
    // rust: IGNORE_STRUCTURE_BLOCK.get_or_init(|| {
    // rust: Processor::BlockIgnore(["minecraft:structure_block".to_owned()].into())
    // rust: })
}
    // rust: let mut settings = PlaceSettings::new(rotation);
    // rust: settings.known_shape = true;
            // SinglePoolElement.getSettings.
    // rust: settings.finalize_entities = true;
    // rust: settings.bounding_box = Some(chunk_box);
    // rust: settings.waterlogging = override_liquid.unwrap_or(waterlogging);
    // rust: if !*legacy {
    // rust: settings.processors.push(ignore);
}
            // SinglePoolElement.getSettings: keepJigsaws skips the replacement.
    // rust: if !keep_jigsaws {
    // rust: settings.processors.push(&Processor::JigsawReplacement);
}
    // rust: settings.processors.extend(processors.0.iter());
    // rust: if *projection == Projection::TerrainMatching {
    // rust: settings
    // rust: .processors
    // rust: .push(GRAVITY.get_or_init(|| Processor::Gravity {
    // rust: heightmap: HeightmapType::WorldSurfaceWg,
    // rust: offset: -1,
    // rust: }));
}
            // LegacySinglePoolElement pops the structure-block ignore and
            // appends STRUCTURE_AND_AIR last, after jigsaw replacement.
    // rust: if *legacy {
    // rust: settings.processors.push(ignore);
}
    // rust: place_in_world(
    // rust: world,
    // rust: resources,
    // rust: template,
    // rust: position,
    // rust: reference,
    // rust: &mut settings,
    // rust: Some(random),
    // rust: 18,
    // rust: )
}
}
}

// Places a named placed feature (feature pool elements) with the piece random.
    // rust: pub type PlaceFeature<'a, W, R> =
    // rust: dyn FnMut(&mut W, &mut R, &str, [i32; 3]) -> Result<bool, PlacementQueryError> + 'a;

// The world queries jigsaw assembly needs from the chunk generator.
    // rust: pub trait JigsawContext {
min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
max_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // ChunkGenerator.getBaseHeight (getFirstFreeHeight).
base_height :: proc(self: ^Self, x: i32, z: i32, kind: HeightmapType) -> i {
    // Ported from Horizon
    return {}
}
    // couldStructureExistInColumn over inclusive block Y bounds.
column_has_valid_biome :: proc(self: ^Self, x: i32, z: i32, min_y: i32, max_y: i32) -> b {
    // Ported from Horizon
    return {}
}
}
// How a jigsaw structure draws its pieces.
Draws :: enum {
    // JigsawPlacement's.
    Vanilla,
    // YUNG's API's `yungsapi:yung_jigsaw` (spec-yungsapi §2.1, §3.1, §3.2):
    // pools are drawn by weight from their file entries, without
    // replacement, priority entries first, and an element at its
    // `max_count` or too shallow is skipped.
    Yung,
}

// The elements a jigsaw tries, in order.
Candidates :: enum {
    // Vanilla: the target pool's weight-expanded entries, then the
    // fallback's, each shuffled up front. A pool's Lithostitched
    // `guaranteed` entries come first when it is reached, in file order,
    // and are not drawn again (spec-lithostitched §3, OPEN-L4).
    Listed(std::vec::IntoIter<(Arc<Pool>, usize)>),
    // YUNG's: picks from each pool in turn (the fallback's only once the
    // target's are spent), each pool's entries shuffled when it is
    // reached: its priority entries in that order, then weighted picks
    // from the others.
    Weighted {,
    pools: Vec<Arc<Pool>>,
    current: Option<Drawing>,
    // rust: },
}
// A YUNG pool being drawn: entries (indices into `raw`) not tried yet.
Drawing :: struct {
    pool: ^Pool,
    priority: VecDeque<uint>,
    others: [dynamic]uint,
}
// An element to try.
Pick :: struct {
    element: ^PoolElement,
    // Its YUNG name or Lithostitched limit's key, counted when it is
    // placed.
    name: Maybe(^str),
    ignore_bounds: bool,
}
    // rust: impl Candidates {
    // rust: fn new(
    // rust: draws: Draws,
    // rust: target: &Arc<Pool>,
    // rust: fallback: &Arc<Pool>,
    // rust: below_max_depth: bool,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Self {
    // rust: let pools = if below_max_depth {
    // rust: vec![target.clone(), fallback.clone()]
    // rust: } else {
    // rust: vec![fallback.clone()]
}
    // rust: match draws {
    // rust: Draws::Vanilla => {
    // rust: let mut listed = Vec::new();
    // rust: for pool in &pools {
    // rust: listed.extend(pool.guaranteed.iter().map(|&e| (pool.clone(), e)));
    // rust: let drawn = pool.shuffled(random).into_iter();
    // rust: let drawn = drawn.filter(|&e| !pool.guaranteed.contains(&e));
    // rust: listed.extend(drawn.map(|e| (pool.clone(), e)));
}
    // rust: Self::Listed(listed.into_iter())
}
    // rust: Draws::Yung => Self::Weighted {
    // rust: pools: pools.into_iter().rev().collect(),
    // rust: current: None,
    // rust: },
}
}
    // The next element to try for a jigsaw of a piece at `depth`.
    // rust: fn next(
    // rust: &mut self,
    // rust: counts: &HashMap<Arc<str>, i32>,
    // rust: depth: i32,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<Pick> {
    // rust: match self {
    // rust: Self::Listed(entries) => entries.find_map(|(pool, entry)| {
    // rust: let limit = pool.limits[entry].as_ref();
    // rust: limit.is_none_or(|l| l.allows(counts, depth)).then(|| Pick {
    // rust: element: pool.raw[entry].0.clone(),
    // rust: name: limit.map(|l| l.key.clone()),
    // rust: ignore_bounds: false,
    // rust: })
    // rust: }),
    // rust: Self::Weighted { pools, current } => loop {
    // rust: let drawing = match current {
    // rust: Some(d) if !d.priority.is_empty() || !d.others.is_empty() => d,
    // rust: _ => {
    // rust: let pool = pools.pop()?;
    // rust: let mut order: Vec<usize> = (0..pool.raw.len()).collect();
    // rust: shuffle(&mut order, random);
    // rust: let (priority, others): (Vec<usize>, _) =
    // rust: order.into_iter().partition(|&i| pool.rules[i].priority);
    // rust: *current = Some(Drawing {
    // rust: pool,
    // rust: priority: priority.into(),
    // rust: others,
    // rust: });
    // rust: continue;
}
}
    // rust: let entry = match drawing.priority.pop_front() {
    // rust: Some(entry) => entry,
    // rust: None => {
    // rust: let Some(at) = drawing.pool.weighted(&drawing.others, random) else {
    // rust: drawing.others.clear();
    // rust: continue;
}
    // rust: drawing.others.remove(at)
}
}
                // spec-yungsapi §3.1 item 8: an empty element ends the
                // jigsaw (the caller's), then `max_count`, then the depth.
    // rust: let rules = &drawing.pool.rules[entry];
    // rust: if let Some((name, max)) = &rules.limit
    // rust: && counts.get(name).copied().unwrap_or(0) >= *max
    // rust: {
    // rust: continue;
}
    // rust: if depth < rules.min_depth {
    // rust: continue;
}
    // rust: let limit = drawing.pool.limits[entry].as_ref();
    // rust: if limit.is_some_and(|l| !l.allows(counts, depth)) {
    // rust: continue;
}
    // rust: return Some(Pick {
    // rust: element: drawing.pool.raw[entry].0.clone(),
    // rust: name: (rules.limit.as_ref().map(|(name, _)| name))
    // rust: .or(limit.map(|l| &l.key))
    // rust: .cloned(),
    // rust: ignore_bounds: rules.ignore_bounds,
    // rust: });
    // rust: },
}
}
}

JigsawConfig :: struct {
    start_pool: ^'a str,
    start_jigsaw: Maybe(^'a str),
    max_depth: i32,
    use_expansion_hack: bool,
    project_to: Maybe(HeightmapType),
    max_distance: [i32,
    aliases: ^'a BTreeMap<string,
    padding: [i32,
    waterlogging: bool,
}

// Free space for children: an inclusive container box minus placed boxes.
    // rust: pub(super) struct Free {
    // rust: pub(super) container: BoundingBox,
    // rust: pub(super) removed: Vec<BoundingBox>,
}
    // rust: impl Free {
    // Whether every point of the (0.25-deflated) box lies in free space.
    // rust: pub(super) fn fits(&self, b: &BoundingBox) -> bool {
    // rust: (0..3).all(|i| b.min[i] >= self.container.min[i] && b.max[i] <= self.container.max[i])
    // rust: && !self.removed.iter().any(|r| r.intersects(b))
}
}
PieceState :: struct {
    piece: uint,
    free: ^RefCell<Free>,
    depth: i32,
}

// JigsawPlacement.addPieces. Returns the structure start position and the
// pieces, or None when the start is invalid.
    // rust: pub fn assemble(
    // rust: config: &JigsawConfig<'_>,
    // rust: context: &mut impl JigsawContext,
    // rust: pools: &Pools,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
    // rust: ) -> Option<([i32; 3], Vec<PoolPiece>)> {
    // rust: assemble_drawing(
    // rust: Draws::Vanilla,
    // rust: config,
    // rust: context,
    // rust: pools,
    // rust: resources,
    // rust: bindings,
    // rust: random,
    // rust: position,
    // rust: )
}

// [`assemble`] with the given draws.
    // rust: pub fn assemble_drawing(
    // rust: draws: Draws,
    // rust: config: &JigsawConfig<'_>,
    // rust: context: &mut impl JigsawContext,
    // rust: pools: &Pools,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
    // rust: ) -> Option<([i32; 3], Vec<PoolPiece>)> {
    // rust: let start = place_start(
    // rust: draws, config, context, pools, resources, bindings, random, position,
    // rust: )?;
    // rust: Some(lay_out_children(
    // rust: draws, start, config, context, pools, resources, bindings, random,
    // rust: ))
}

// A jigsaw's start piece in place ([`place_start`]), its children not laid out yet: vanilla's
// `Structure.GenerationStub`, whose position the structure's biome is checked at before
// `JigsawPlacement.addPieces` lays the rest out.
PlacedStart :: struct {
    // The start position (`[centre x, start y, centre z]`).
    position: [i32,
    center: PoolPiece,
}

// The first half of [`assemble_drawing`]: the start piece drawn, rotated, projected to the
// heightmap and checked against the height limits. None when the start is invalid. The
// draws it makes come first in `random`, as in `assemble_drawing`.
    // rust: pub fn place_start(
    // rust: draws: Draws,
    // rust: config: &JigsawConfig<'_>,
    // rust: context: &mut impl JigsawContext,
    // rust: pools: &Pools,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
    // rust: ) -> Option<PlacedStart> {
    // rust: let alias = |name: &str| {
    // rust: config
    // rust: .aliases
    // rust: .get(name)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| name.to_owned())
}
    // rust: let center_pool = pools.get(&alias(config.start_pool), resources, bindings)?;
    // rust: let (rotation, element) = match draws {
    // rust: Draws::Vanilla => {
    // rust: let rotation = Rotation::random(random);
    // rust: (rotation, center_pool.random_template(random))
}
        // The entries shuffled, then the rotation, then a weighted pick in
        // the shuffled order.
    // rust: Draws::Yung => {
    // rust: let mut order: Vec<usize> = (0..center_pool.raw.len()).collect();
    // rust: shuffle(&mut order, random);
    // rust: let rotation = Rotation::random(random);
    // rust: let entry = order[center_pool.weighted(&order, random)?];
    // rust: (rotation, center_pool.raw[entry].0.clone())
}
}
    // rust: if matches!(element.as_ref(), PoolElement::Empty) {
    // rust: return None;
}
    // rust: let anchored = match config.start_jigsaw {
    // rust: Some(name) => {
    // rust: element
    // rust: .shuffled_jigsaws(resources, position, rotation, random)
    // rust: .into_iter()
    // rust: .find(|j| j.name.as_deref() == Some(name))?
    // rust: .pos
}
    // rust: None => position,
}
    // rust: let local: [i32; 3] = std::array::from_fn(|i| anchored[i] - position[i]);
    // rust: let adjusted: [i32; 3] = std::array::from_fn(|i| position[i] - local[i]);
    // rust: let mut center = PoolPiece {
    // rust: bounding_box: element.bounding_box(adjusted, rotation),
    // rust: ground_level_delta: element.ground_level_delta(),
    // rust: element: element.clone(),
    // rust: position: adjusted,
    // rust: rotation,
    // rust: junctions: Vec::new(),
    // rust: waterlogging: config.waterlogging,
}
    // rust: let b = center.bounding_box;
    // rust: let cx = (b.max[0] + b.min[0]) / 2;
    // rust: let cz = (b.max[2] + b.min[2]) / 2;
    // rust: let bottom = match config.project_to {
    // rust: None => adjusted[1],
    // rust: Some(kind) => {
    // rust: if !context.column_has_valid_biome(cx, cz, context.min_y(), context.max_y()) {
    // rust: return None;
}
    // rust: position[1] + context.base_height(cx, cz, kind)
}
}
    // rust: let old_ground = b.min[1] + center.ground_level_delta;
    // rust: center.moved(bottom - old_ground);
    // rust: let b = center.bounding_box;
    // rust: if config.padding != [0, 0]
    // rust: && (b.min[1] < context.min_y() + config.padding[0]
    // rust: || b.max[1] > context.max_y() - config.padding[1])
    // rust: {
    // rust: return None;
}
    // rust: let cy = bottom + local[1];
    // rust: Some(PlacedStart {
    // rust: position: [cx, cy, cz],
    // rust: center,
    // rust: })
}

// The second half of [`assemble_drawing`]: the children of a [`place_start`]ed start laid out
// to `config.max_depth`, with the same `random`. Returns the start position and every piece.
    // rust: pub fn lay_out_children(
    // rust: draws: Draws,
    // rust: start: PlacedStart,
    // rust: config: &JigsawConfig<'_>,
    // rust: context: &mut impl JigsawContext,
    // rust: pools: &Pools,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> ([i32; 3], Vec<PoolPiece>) {
    // rust: let PlacedStart {
    // rust: position: [cx, cy, cz],
    // rust: center,
    // rust: } = start;
    // rust: let mut pieces = vec![center];
    // rust: if config.max_depth > 0 {
    // rust: let [h, v] = config.max_distance;
    // rust: let low_y = (cy - v).max(context.min_y() + config.padding[0]);
    // rust: let high_y = (cy + v + 1).min(context.max_y() + 1 - config.padding[1]);
    // rust: let container = BoundingBox::new([cx - h, low_y, cz - h], [cx + h, high_y - 1, cz + h]);
        // The start does not count toward `max_count` (spec-yungsapi §3).
    // rust: add_children_drawing(
    // rust: draws,
    // rust: HashMap::new(),
    // rust: config,
    // rust: context,
    // rust: pools,
    // rust: resources,
    // rust: bindings,
    // rust: random,
    // rust: &mut pieces,
    // rust: container,
    // rust: );
}
    // rust: ([cx, cy, cz], pieces)
}

// The inner JigsawPlacement.addPieces: lays out the children of
// `pieces[0]`, a start piece already placed, to `config.max_depth`,
// within `container` (inclusive) less the start's box. A structure with
// its own start (Formations' pieced one) reaches the jigsaw layout here.
    // rust: pub(super) fn add_children(
    // rust: config: &JigsawConfig<'_>,
    // rust: context: &mut impl JigsawContext,
    // rust: pools: &Pools,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: random: &mut impl RandomSource,
    // rust: pieces: &mut Vec<PoolPiece>,
    // rust: container: BoundingBox,
    // rust: ) {
    // rust: add_children_drawing(
    // rust: Draws::Vanilla,
    // rust: HashMap::new(),
    // rust: config,
    // rust: context,
    // rust: pools,
    // rust: resources,
    // rust: bindings,
    // rust: random,
    // rust: pieces,
    // rust: container,
    // rust: );
}
    // rust: fn add_children_drawing(
    // rust: draws: Draws,
    // rust: counts: HashMap<Arc<str>, i32>,
    // rust: config: &JigsawConfig<'_>,
    // rust: context: &mut impl JigsawContext,
    // rust: pools: &Pools,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: random: &mut impl RandomSource,
    // rust: pieces: &mut Vec<PoolPiece>,
    // rust: container: BoundingBox,
    // rust: ) {
    // rust: let free = Rc::new(RefCell::new(Free {
    // rust: container,
    // rust: removed: vec![pieces[0].bounding_box],
    // rust: }));
    // rust: let mut placer = Placer {
    // rust: config,
    // rust: pools,
    // rust: resources,
    // rust: bindings,
    // rust: pieces,
    // rust: queue: BTreeMap::new(),
    // rust: draws,
    // rust: counts,
}
    // rust: placer.children(0, free, 0, context, random);
    // rust: while let Some(state) = placer.next() {
    // rust: placer.children(state.piece, state.free, state.depth, context, random);
}
}
Placer :: struct {
    config: ^'a JigsawConfig<'a>,
    pools: ^'a Pools,
    resources: ^'a StructureResources,
    bindings: ^'a FeatureBlockBindings<'a>,
    pieces: ^'p mut [dynamic]PoolPiece,
    // SequencedPriorityIterator: highest priority first, FIFO within one.
    queue: BTreeMap<i32,
    draws: Draws,
    // Pieces placed per limited element (`Limit::key`).
    counts: HashMap<^str,
}
    // rust: impl Placer<'_, '_> {
next :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut entry = self.queue.last_entry()?;
    // rust: let state = entry.get_mut().pop_front();
    // rust: if entry.get().is_empty() {
    // rust: entry.remove();
}
    // rust: state
}
pool :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = self.config.aliases.get(name).map_or(name, String::as_str);
    // rust: self.pools.get(name, self.resources, self.bindings)
}
    // rust: fn children(
    // rust: &mut self,
    // rust: source_index: usize,
    // rust: context_free: Rc<RefCell<Free>>,
    // rust: depth: i32,
    // rust: context: &mut impl JigsawContext,
    // rust: random: &mut impl RandomSource,
    // rust: ) {
    // rust: let (source_element, source_position, source_rotation, source_box, source_ground) = {
    // rust: let s = &self.pieces[source_index];
    // rust: (
    // rust: s.element.clone(),
    // rust: s.position,
    // rust: s.rotation,
    // rust: s.bounding_box,
    // rust: s.ground_level_delta,
    // rust: )
}
    // rust: let source_rigid = source_element.projection() == Projection::Rigid;
    // rust: let mut source_free: Option<Rc<RefCell<Free>>> = None;
    // rust: let source_y = source_box.min[1];
    // rust: let jigsaws = source_element.shuffled_jigsaws(
    // rust: self.resources,
    // rust: source_position,
    // rust: source_rotation,
    // rust: random,
    // rust: );
    // rust: 'jigsaws: for jigsaw in jigsaws {
    // rust: let direction = jigsaw.front;
    // rust: let s = step(direction);
    // rust: let target_pos: [i32; 3] = std::array::from_fn(|i| jigsaw.pos[i] + s[i]);
    // rust: let local_y = jigsaw.pos[1] - source_y;
    // rust: let mut base_height = i32::MIN;
    // rust: let Some(target_pool) = self.pool(&jigsaw.pool) else {
    // rust: continue;
}
    // rust: if target_pool.templates.is_empty() && jigsaw.pool != "minecraft:empty" {
    // rust: continue;
}
    // rust: let Some(fallback) = self.pool(&target_pool.fallback) else {
    // rust: continue;
}
    // rust: if fallback.templates.is_empty() && target_pool.fallback != "minecraft:empty" {
    // rust: continue;
}
    // rust: let children_free = if source_box.is_inside(target_pos) {
    // rust: source_free
    // rust: .get_or_insert_with(|| {
    // rust: Rc::new(RefCell::new(Free {
    // rust: container: source_box,
    // rust: removed: Vec::new(),
    // rust: }))
    // rust: })
    // rust: .clone()
    // rust: } else {
    // rust: context_free.clone()
}
    // rust: let mut candidates = Candidates::new(
    // rust: self.draws,
    // rust: &target_pool,
    // rust: &fallback,
    // rust: depth != self.config.max_depth,
    // rust: random,
    // rust: );
    // rust: while let Some(Pick {
    // rust: element: target,
    // rust: name,
    // rust: ignore_bounds,
    // rust: }) = candidates.next(&self.counts, depth, random)
    // rust: {
    // rust: if matches!(target.as_ref(), PoolElement::Empty) {
    // rust: break;
}
    // rust: let mut rotations = Rotation::ALL;
    // rust: shuffle(&mut rotations, random);
    // rust: for rotation in rotations {
    // rust: let target_jigsaws =
    // rust: target.shuffled_jigsaws(self.resources, [0; 3], rotation, random);
    // rust: let hack_box = target.bounding_box([0; 3], rotation);
    // rust: let expand_to = if self.config.use_expansion_hack && hack_box.span()[1] <= 16 {
    // rust: target_jigsaws
    // rust: .iter()
    // rust: .map(|tj| {
    // rust: let st = step(tj.front);
    // rust: if !hack_box.is_inside(std::array::from_fn(|i| tj.pos[i] + st[i])) {
    // rust: return 0;
}
    // rust: let child = self.pool(&tj.pool);
    // rust: let child_size = child.as_ref().map_or(0, |p| p.max_size());
    // rust: let fallback_size = child
    // rust: .and_then(|p| self.pool(&p.fallback))
    // rust: .map_or(0, |p| p.max_size());
    // rust: child_size.max(fallback_size)
    // rust: })
    // rust: .max()
    // rust: .unwrap_or(0)
    // rust: } else {
    // rust: 0
}
    // rust: for target_jigsaw in &target_jigsaws {
    // rust: if !can_attach(&jigsaw, target_jigsaw) {
    // rust: continue;
}
    // rust: let target_local = target_jigsaw.pos;
    // rust: let raw_position: [i32; 3] =
    // rust: std::array::from_fn(|i| target_pos[i] - target_local[i]);
    // rust: let raw_box = target.bounding_box(raw_position, rotation);
    // rust: let raw_y = raw_box.min[1];
    // rust: let target_rigid = target.projection() == Projection::Rigid;
    // rust: let target_local_y = target_local[1];
    // rust: let delta_y = local_y - target_local_y + step(jigsaw.front)[1];
    // rust: let target_y = if source_rigid && target_rigid {
    // rust: source_y + delta_y
    // rust: } else {
    // rust: if base_height == i32::MIN {
    // rust: base_height = context.base_height(
    // rust: jigsaw.pos[0],
    // rust: jigsaw.pos[2],
    // rust: HeightmapType::WorldSurfaceWg,
    // rust: );
}
    // rust: base_height - target_local_y
}
    // rust: let offset = target_y - raw_y;
    // rust: let mut target_box = raw_box.moved([0, offset, 0]);
    // rust: let target_position =
    // rust: [raw_position[0], raw_position[1] + offset, raw_position[2]];
    // rust: if expand_to > 0 {
    // rust: let size = (expand_to + 1).max(target_box.max[1] - target_box.min[1]);
    // rust: target_box.max[1] = target_box.max[1].max(target_box.min[1] + size);
}
    // rust: if !ignore_bounds && !children_free.borrow().fits(&target_box) {
    // rust: continue;
}
    // rust: children_free.borrow_mut().removed.push(target_box);
    // rust: let target_ground = if target_rigid {
    // rust: source_ground - delta_y
    // rust: } else {
    // rust: target.ground_level_delta()
}
    // rust: let junction_y = if source_rigid {
    // rust: source_y + local_y
    // rust: } else if target_rigid {
    // rust: target_y + target_local_y
    // rust: } else {
    // rust: if base_height == i32::MIN {
    // rust: base_height = context.base_height(
    // rust: jigsaw.pos[0],
    // rust: jigsaw.pos[2],
    // rust: HeightmapType::WorldSurfaceWg,
    // rust: );
}
    // rust: base_height + delta_y / 2
}
    // rust: self.pieces[source_index].junctions.push(Junction {
    // rust: source_x: target_pos[0],
    // rust: source_ground_y: junction_y - local_y + source_ground,
    // rust: source_z: target_pos[2],
    // rust: delta_y,
    // rust: dest_projection: target.projection(),
    // rust: });
    // rust: self.pieces.push(PoolPiece {
    // rust: element: target.clone(),
    // rust: position: target_position,
    // rust: ground_level_delta: target_ground,
    // rust: rotation,
    // rust: bounding_box: target_box,
    // rust: junctions: vec![Junction {
    // rust: source_x: jigsaw.pos[0],
    // rust: source_ground_y: junction_y - target_local_y + target_ground,
    // rust: source_z: jigsaw.pos[2],
    // rust: delta_y: -delta_y,
    // rust: dest_projection: if source_rigid {
    // rust: Projection::Rigid
    // rust: } else {
    // rust: Projection::TerrainMatching
    // rust: },
    // rust: }],
    // rust: waterlogging: self.config.waterlogging,
    // rust: });
    // rust: if let Some(name) = name {
    // rust: *self.counts.entry(name).or_default() += 1;
}
    // rust: if depth < self.config.max_depth {
    // rust: self.queue
    // rust: .entry(jigsaw.placement_priority)
    // rust: .or_default()
    // rust: .push_back(PieceState {
    // rust: piece: self.pieces.len() - 1,
    // rust: free: children_free.clone(),
    // rust: depth: depth + 1,
    // rust: });
}
    // rust: continue 'jigsaws;
}
}
}
}
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

    // A pool of empty elements, told apart by identity, with these limits.
pool :: proc(entries: ^[(i32) {
}
    // rust: let (mut templates, mut indices, mut raw, mut rules, mut limits) =
    // rust: (Vec::new(), Vec::new(), Vec::new(), Vec::new(), Vec::new());
    // rust: for (i, (weight, element)) in entries.iter().enumerate() {
    // rust: let e = Arc::new(PoolElement::Empty);
    // rust: for _ in 0..*weight {
    // rust: templates.push(e.clone());
    // rust: indices.push(i);
}
    // rust: raw.push((e, *weight));
    // rust: rules.push(Rules::of(element));
    // rust: limits.push(Limit::of(element));
}
    // rust: let guaranteed = (0..entries.len())
    // rust: .filter(|&i| limits[i].as_ref().is_some_and(|l: &Limit| l.guaranteed))
    // rust: .collect();
    // rust: Arc::new(Pool {
    // rust: templates,
    // rust: entries: indices,
    // rust: raw,
    // rust: rules,
    // rust: limits,
    // rust: guaranteed,
    // rust: fallback: "minecraft:empty".into(),
    // rust: max_size: OnceLock::new(),
    // rust: })
}
delegate :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: json!({"element_type": "minecraft:single_pool_element", "location": "a:b"})
}
    // The entries a vanilla jigsaw tries below a parent at `depth`: the
    // target's by index, the fallback's by index plus 100.
    // rust: fn tried(
    // rust: target: &Arc<Pool>,
    // rust: fallback: &Arc<Pool>,
    // rust: counts: &HashMap<Arc<str>, i32>,
    // rust: depth: i32,
    // rust: below_max: bool,
    // rust: ) -> Vec<usize> {
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let mut candidates =
    // rust: Candidates::new(Draws::Vanilla, target, fallback, below_max, &mut random);
    // rust: let index = |pool: &Arc<Pool>, element: &Arc<PoolElement>| {
    // rust: pool.raw.iter().position(|(e, _)| Arc::ptr_eq(e, element))
}
    // rust: let mut out = Vec::new();
    // rust: while let Some(pick) = candidates.next(counts, depth, &mut random) {
    // rust: out.push(
    // rust: index(target, &pick.element)
    // rust: .or_else(|| index(fallback, &pick.element).map(|i| i + 100))
    // rust: .unwrap(),
    // rust: );
}
    // rust: out
}

limits_read_lithostitcheds_fields :: proc() {
}
    // rust: let limited =
    // rust: json!({"element_type": "lithostitched:limited", "limit": 1, "delegate": delegate()});
    // rust: let l = Limit::of(&limited).unwrap();
    // rust: assert_eq!((l.max, l.min_depth, l.guaranteed), (1, 0, false));
    // rust: assert_eq!(*l.key, *limited.to_string());
    // rust: let guaranteed = json!({"element_type": "lithostitched:guaranteed", "count": 2, "min_depth": 3,
    // rust: "delegate": delegate()});
    // rust: let g = Limit::of(&guaranteed).unwrap();
    // rust: assert_eq!((g.max, g.min_depth, g.guaranteed), (2, 3, true));
        // No limit, or YUNG's (`Rules`): none to keep here.
    // rust: for none in [
    // rust: json!({"element_type": "lithostitched:limited", "delegate": delegate()}),
    // rust: json!({"element_type": "yungsapi:yung_single_element", "name": "pile", "max_count": 2}),
    // rust: delegate(),
    // rust: ] {
    // rust: assert!(Limit::of(&none).is_none(), "{none}");
}
}

vanilla_jigsaws_keep_lithostitcheds_limits :: proc() {
}
    // rust: let limited =
    // rust: json!({"element_type": "lithostitched:limited", "limit": 1, "delegate": delegate()});
    // rust: let guaranteed = json!({"element_type": "lithostitched:guaranteed", "count": 1, "min_depth": 3,
    // rust: "delegate": delegate()});
    // rust: let p = pool(&[
    // rust: (3, delegate()),
    // rust: (2, limited.clone()),
    // rust: (1, guaranteed.clone()),
    // rust: ]);
    // rust: let empty = pool(&[]);
    // rust: let mut counts = HashMap::new();
        // Too shallow for the guaranteed entry: the weight-expanded list without it.
    // rust: let mut shallow = tried(&p, &empty, &counts, 2, true);
    // rust: shallow.sort();
    // rust: assert_eq!(shallow, [0, 0, 0, 1, 1]);
        // Deep enough: it comes first, and is not drawn again.
    // rust: let deep = tried(&p, &empty, &counts, 3, true);
    // rust: assert_eq!(deep[0], 2);
    // rust: assert_eq!(deep[1..].iter().filter(|&&e| e == 2).count(), 0);
        // At the most depth only the fallback is tried.
    // rust: assert!(tried(&p, &empty, &counts, 3, false).is_empty());
        // Entries at their limit are skipped.
    // rust: counts.insert(Arc::from(limited.to_string()), 1);
    // rust: counts.insert(Arc::from(guaranteed.to_string()), 1);
    // rust: let full = tried(&p, &empty, &counts, 3, true);
    // rust: assert_eq!(full, [0, 0, 0]);
}

    // A fallback pool's guaranteed entries come first once it is reached,
    // below the most depth as at it (rdbtCVS's review of #1777).
a_fallbacks_guaranteed_entries_are_tried :: proc() {
}
    // rust: let guaranteed = json!({"element_type": "lithostitched:guaranteed", "count": 1,
    // rust: "delegate": delegate()});
    // rust: let target = pool(&[(2, delegate())]);
    // rust: let fallback = pool(&[(1, delegate()), (1, guaranteed)]);
    // rust: let counts = HashMap::new();
    // rust: let below = tried(&target, &fallback, &counts, 0, true);
    // rust: assert_eq!(below[..2], [0, 0]);
    // rust: assert_eq!(below[2..], [101, 100]);
    // rust: assert_eq!(tried(&target, &fallback, &counts, 0, false), [101, 100]);
}
}
