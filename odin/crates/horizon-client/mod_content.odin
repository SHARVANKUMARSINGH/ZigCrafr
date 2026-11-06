//! Transpiled from Horizon Rust crate
package horizon_client_mod_content

import "core:fmt"
import "core:mem"
import "core:math"

// Content mods in the resource root (docs/modpacks.md, registries 0.2).
//
// Every loader reads one resource root, and most of its block and item
// tables are exports from vanilla indexed by block-state id or keyed by
// name. A content mod's block copies a vanilla *template*. So the mods'
// root is an overlay, like the resource-pack one:
// - the base root linked, with the per-state and per-name tables
//   rewritten: each mod block gets its template's rows appended (states
//   after vanilla's, mods and blocks in id order) with names, translation
//   keys and in-table state ids moved over, and the declared overrides
//   applied;
// - each mod's own `assets/` and `data/` files;
// - additions to tags merged into the tag files and bundles.
//
// The loaders need no mod code, vanilla state ids never move, and with no
// content mod the root is the base root itself.
// use crate::{Result, blocks::MAP_COLORS};
// use horizon_core::geometry::{Aabb, Axis, ShapeOp, Vec3, VoxelShape};
// use horizon_mods::content::{
    // rust: Block, BlockShapes, Content, CreativeTab, EntityType, MenuType, MobEffect, Rarity,
    // rust: StateProperty,
}
// use horizon_world::nbt::{self, Compound, JavaString, Limits, Tag};
// use serde::{Deserialize, Serialize, de};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: fmt, fs,
    // rust: ops::Range,
    // rust: path::{Path, PathBuf},
}

// A content mod to put in the root: its id and content.
ContentMod :: struct {
    id: string,
    content: Content,
}

// Leaves out a mod with an item whose `crafting_remainder` names an item the mod does not have:
// a file item that named a code-declared one the declaration check then refused. Left in, the
// overlay would fail on it and no content mod at all would load. Returns what was left out.
drop_dangling_remainders :: proc(mods: ^[dynamic]ContentMod) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut dropped = Vec::new();
    // rust: mods.retain(|m| {
        // The mod's items and its blocks that have an item (`Content::read`'s own rule).
    // rust: let ids: BTreeSet<&str> = m
    // rust: .content
    // rust: .items
    // rust: .iter()
    // rust: .map(|i| i.id.as_str())
    // rust: .chain(
    // rust: m.content
    // rust: .blocks
    // rust: .iter()
    // rust: .filter(|b| b.item)
    // rust: .map(|b| b.id.as_str()),
    // rust: )
    // rust: .collect();
    // rust: let dangling = m.content.items.iter().find(|i| {
    // rust: i.crafting_remainder
    // rust: .as_deref()
    // rust: .is_some_and(|r| !r.starts_with("minecraft:") && !ids.contains(r))
    // rust: });
    // rust: if let Some(item) = dangling {
    // rust: dropped.push(format!(
    // rust: "mod {} content not loaded: {}: crafting_remainder {:?} is not one of its items",
    // rust: m.id,
    // rust: item.id,
    // rust: item.crafting_remainder.as_deref().unwrap_or_default()
    // rust: ));
}
    // rust: dangling.is_none()
    // rust: });
    // rust: dropped
}

// The mods' mob effects in registry order: by id, as items are. Their
// network ids follow vanilla's in this order.
mob_effects :: proc(mods: ^[ContentMod]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut effects: Vec<&MobEffect> = mods.iter().flat_map(|m| &m.content.effects).collect();
    // rust: effects.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: effects
}

// the mods' entity types in registry order, by id as effects are.
entity_types :: proc(mods: ^[ContentMod]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut types: Vec<&EntityType> = mods.iter().flat_map(|m| &m.content.entity_types).collect();
    // rust: types.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: types
}

// the mods' menu types in registry order, by id as effects are.
menu_types :: proc(mods: ^[ContentMod]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut menus: Vec<&MenuType> = mods.iter().flat_map(|m| &m.content.menu_types).collect();
    // rust: menus.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: menus
}

// JSON with its object keys in file order, so a rewritten table differs
// from the original only by what was added.
J :: enum {
    Null,
    Bool(bool),
    Num(serde_json::Number),
    Str(String),
    Arr(Vec<J>),
    Obj(Vec<(String, J)>),
}
    // rust: impl<'de> Deserialize<'de> for J {
    // rust: fn deserialize<D: de::Deserializer<'de>>(d: D) -> std::result::Result<Self, D::Error> {
V :: struct {
    // rust: impl<'de> de::Visitor<'de> for V {
    // rust: type Value = J;
expecting :: proc(self: ^Self, f: ^fmt::Formatter) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str("JSON")
}
    // rust: fn visit_unit<E>(self) -> std::result::Result<J, E> {
    // rust: Ok(J::Null)
}
    // rust: fn visit_bool<E>(self, v: bool) -> std::result::Result<J, E> {
    // rust: Ok(J::Bool(v))
}
    // rust: fn visit_i64<E>(self, v: i64) -> std::result::Result<J, E> {
    // rust: Ok(J::Num(v.into()))
}
    // rust: fn visit_u64<E>(self, v: u64) -> std::result::Result<J, E> {
    // rust: Ok(J::Num(v.into()))
}
    // rust: fn visit_f64<E: de::Error>(self, v: f64) -> std::result::Result<J, E> {
    // rust: serde_json::Number::from_f64(v)
    // rust: .map(J::Num)
    // rust: .ok_or_else(|| E::custom("not a JSON number"))
}
    // rust: fn visit_str<E>(self, v: &str) -> std::result::Result<J, E> {
    // rust: Ok(J::Str(v.to_owned()))
}
    // rust: fn visit_string<E>(self, v: String) -> std::result::Result<J, E> {
    // rust: Ok(J::Str(v))
}
    // rust: fn visit_seq<A: de::SeqAccess<'de>>(
    // rust: self,
    // rust: mut a: A,
    // rust: ) -> std::result::Result<J, A::Error> {
    // rust: let mut out = Vec::new();
    // rust: while let Some(v) = a.next_element()? {
    // rust: out.push(v);
}
    // rust: Ok(J::Arr(out))
}
    // rust: fn visit_map<A: de::MapAccess<'de>>(
    // rust: self,
    // rust: mut a: A,
    // rust: ) -> std::result::Result<J, A::Error> {
    // rust: let mut out = Vec::new();
    // rust: while let Some(kv) = a.next_entry()? {
    // rust: out.push(kv);
}
    // rust: Ok(J::Obj(out))
}
}
    // rust: d.deserialize_any(V)
}
}
    // rust: impl Serialize for J {
    // rust: fn serialize<S: serde::Serializer>(&self, s: S) -> std::result::Result<S::Ok, S::Error> {
//         use serde::ser::{SerializeMap, SerializeSeq};
    // rust: match self {
    // rust: J::Null => s.serialize_unit(),
    // rust: J::Bool(b) => s.serialize_bool(*b),
    // rust: J::Num(n) => n.serialize(s),
    // rust: J::Str(t) => s.serialize_str(t),
    // rust: J::Arr(a) => {
    // rust: let mut seq = s.serialize_seq(Some(a.len()))?;
    // rust: for v in a {
    // rust: seq.serialize_element(v)?;
}
    // rust: seq.end()
}
    // rust: J::Obj(o) => {
    // rust: let mut map = s.serialize_map(Some(o.len()))?;
    // rust: for (k, v) in o {
    // rust: map.serialize_entry(k, v)?;
}
    // rust: map.end()
}
}
}
}
    // rust: impl J {
get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: J::Obj(o) => o.iter().find(|(k, _)| k == key).map(|(_, v)| v),
    // rust: _ => None,
}
}
remove :: proc(self: ^Self, key: string) {
}
    // rust: if let J::Obj(o) = self {
    // rust: o.retain(|(k, _)| k != key);
}
}
get_mut :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: J::Obj(o) => o.iter_mut().find(|(k, _)| k == key).map(|(_, v)| v),
    // rust: _ => None,
}
}
    // Sets `key`, in place if present, else at the end.
set :: proc(self: ^Self, key: string, value: J) {
}
    // rust: if let Some(v) = self.get_mut(key) {
    // rust: *v = value;
    // rust: } else if let J::Obj(o) = self {
    // rust: o.push((key.to_owned(), value));
}
}
    // The value at a `/`-separated path ("" is the document).
at :: proc(self: ^Self, path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: path.split('/')
    // rust: .filter(|p| !p.is_empty())
    // rust: .try_fold(self, |j, key| j.get_mut(key))
}
f64 :: proc(v: f64) -> J {
    // Ported from Horizon
    return {}
}
    // rust: serde_json::Number::from_f64(v).map_or(J::Null, J::Num)
}
as_u32 :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: J::Num(n) => n.as_u64().and_then(|v| u32::try_from(v).ok()),
    // rust: _ => None,
}
}
as_str :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: J::Str(s) => Some(s),
    // rust: _ => None,
}
}
    // Renames strings and, with `ids`, moves state ids, everywhere inside.
rename :: proc(self: ^Self, r: ^Rename, ids: bool) {
}
    // rust: match self {
    // rust: J::Str(s) => {
    // rust: if let Some(new) = r.string(s) {
    // rust: *s = new;
}
}
    // rust: J::Num(n) if ids => {
    // rust: if let Some(new) = n
    // rust: .as_u64()
    // rust: .and_then(|v| u32::try_from(v).ok())
    // rust: .and_then(|id| r.id(id))
    // rust: {
    // rust: *n = new.into();
}
}
    // rust: J::Arr(a) => a.iter_mut().for_each(|v| v.rename(r, ids)),
    // rust: J::Obj(o) => o.iter_mut().for_each(|(_, v)| v.rename(r, ids)),
    // rust: _ => {}
}
}
}

// One id moving to another: `minecraft:iron_block` → `ruby:ruby_block`,
// with its state range for blocks.
Rename :: struct {
    from: string,
    to: string,
    states: Range<u32>,
    first: u32,
    // States this block gives each of its template's: one per combination
    // of the state properties it declares (1 when it declares none). A
    // template state moves to the first of them, which is the one every
    // declared property is at its default for.
    fanout: u32,
    // The lookup from a template state and a declared combination to the state's row, as an
    // offset from `first`: `rows[template offset * fanout + combination]`, laid out as vanilla
    // does (`state_order`). Empty: the template's states times the combinations, in that order.
    rows: [dynamic]u32,
}
    // rust: impl Rename {
new :: proc(from: string, to: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Rename {
    // rust: from: from.to_owned(),
    // rust: to: to.to_owned(),
    // rust: states: 0..0,
    // rust: first: 0,
    // rust: fanout: 1,
    // rust: rows: Vec::new(),
}
}
    // The id itself, `Block{id}`, and `block.<ns>.<path>` / `item.<ns>.<path>` keys.
string :: proc(self: ^Self, s: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if s == self.from {
    // rust: return Some(self.to.clone());
}
    // rust: if s.strip_prefix("Block{").and_then(|x| x.strip_suffix('}')) == Some(&self.from) {
    // rust: return Some(format!("Block{{{}}}", self.to));
}
    // rust: let key = |id: &str| id.replacen(':', ".", 1).replace('/', ".");
    // rust: for kind in ["block", "item"] {
    // rust: if s.strip_prefix(kind).and_then(|x| x.strip_prefix('.')) == Some(&key(&self.from)) {
    // rust: return Some(format!("{kind}.{}", key(&self.to)));
}
}
    // rust: None
}
    // The row of a template state's `combination`, as an offset from `first`.
row :: proc(self: ^Self, at: u32, combination: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let index = at * self.fanout + combination;
    // rust: self.rows.get(index as usize).copied().unwrap_or(index)
}
    // Where a template state moves: its combination with every declared property at its default.
id :: proc(self: ^Self, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .contains(&id)
    // rust: .then(|| self.first + self.row(id - self.states.start, 0))
}
}

// A template's own state properties, sorted by name, each with how many values it takes across
// the template's `states`: how `StateTable::new` reads them back, the first name slowest.
    // rust: fn template_properties<'a>(
    // rust: states: &Range<u32>,
    // rust: properties: impl Fn(u32) -> Option<&'a J>,
    // rust: ) -> Vec<(String, u32)> {
    // rust: let Some(J::Obj(own)) = states.clone().next().and_then(&properties) else {
    // rust: return Vec::new();
}
    // rust: let mut names: Vec<&str> = own.iter().map(|(k, _)| k.as_str()).collect();
    // rust: names.sort_unstable();
    // rust: let mut out = Vec::new();
    // rust: for name in names {
    // rust: let mut seen: Vec<&J> = Vec::new();
    // rust: for id in states.clone() {
    // rust: if let Some(v) = properties(id).and_then(|p| p.get(name))
    // rust: && !seen.contains(&v)
    // rust: {
    // rust: seen.push(v);
}
}
    // rust: out.push((name.to_owned(), (seen.len() as u32).max(1)));
}
    // rust: out
}

// A block's states: in vanilla's order when the template's own properties multiply out to its
// states (every vanilla block's do), else the template's states times the combinations.
    // rust: fn block_order<'a>(
    // rust: states: &Range<u32>,
    // rust: properties: impl Fn(u32) -> Option<&'a J>,
    // rust: declared: &[(String, u32)],
    // rust: combinations: u32,
    // rust: ) -> Vec<(u32, u32)> {
    // rust: let template = template_properties(states, properties);
    // rust: if template.iter().map(|p| p.1).product::<u32>() == states.len() as u32 {
    // rust: return state_order(&template, declared);
}
    // rust: (0..states.len() as u32)
    // rust: .flat_map(|state| (0..combinations).map(move |combo| (state, combo)))
    // rust: .collect()
}

// The states of a block in vanilla's order (`StateDefinition`): every property, the template's
// and the declared ones, sorted by name, the first name varying slowest. Each entry is a
// template state's offset and the index of a declared combination (`combinations`), whose own
// order is by declared name, the first slowest. With every declared name after the template's
// this is the template's states times the combinations, as before.
state_order :: proc(template: ^[(string) {
}
    // (name, values, its own side's stride, from the template)
    // rust: let mut all: Vec<(&str, u32, u32, bool)> = Vec::new();
    // rust: for (side, from_template) in [(template, true), (declared, false)] {
    // rust: let mut stride = 1;
    // rust: let mut strides = Vec::new();
    // rust: for (_, len) in side.iter().rev() {
    // rust: strides.push(stride);
    // rust: stride *= len;
}
    // rust: for ((name, len), stride) in side.iter().zip(strides.into_iter().rev()) {
    // rust: all.push((name, *len, stride, from_template));
}
}
    // rust: all.sort_by(|a, b| a.0.cmp(b.0));
    // rust: let total: u32 = all.iter().map(|p| p.1).product();
    // rust: (0..total)
    // rust: .map(|position| {
    // rust: let (mut state, mut combo, mut rest) = (0, 0, total);
    // rust: for &(_, len, stride, from_template) in &all {
    // rust: rest /= len;
    // rust: let value = (position / rest) % len;
    // rust: if from_template {
    // rust: state += value * stride;
    // rust: } else {
    // rust: combo += value * stride;
}
}
    // rust: (state, combo)
    // rust: })
    // rust: .collect()
}

// The combinations of a block's declared state properties, in a fixed
// order: by name (a `BTreeMap`'s), each one's declared default first, and
// the first name varying slowest. So the first combination is every
// property at its default, which is the one a template state maps to.
    // rust: fn combinations(
    // rust: declared: &BTreeMap<String, StateProperty>,
    // rust: default_state: &BTreeMap<String, String>,
    // rust: ) -> Result<Vec<Vec<(String, String)>>> {
    // rust: let mut orders: Vec<(&str, Vec<&str>)> = Vec::new();
    // rust: for (name, property) in declared {
    // rust: let mut values = property.values();
    // rust: if let Some(default) = default_state.get(name) {
    // rust: let Some(at) = values.iter().position(|v| v == default) else {
    // rust: return Err(
    // rust: format!("{name}: default_state {default:?} is not one of its values").into(),
    // rust: );
}
    // rust: values.rotate_left(at);
}
    // rust: orders.push((name, values));
}
    // Every combination is a state of each of the template's, so a block's run
    // is its template's states times this many: refused before it is built.
    // rust: let mut product: u64 = 1;
    // rust: for (_, values) in &orders {
    // rust: product = product.saturating_mul(values.len() as u64);
}
    // rust: if product > MAX_STATES as u64 {
    // rust: return Err(format!(
    // rust: "{product} state property combinations, more than the {MAX_STATES} a world can hold"
    // rust: )
    // rust: .into());
}
    // rust: let mut combos: Vec<Vec<(String, String)>> = vec![Vec::new()];
    // rust: for (name, values) in orders {
    // rust: let mut next = Vec::with_capacity(combos.len().saturating_mul(values.len()));
    // rust: for combo in &combos {
    // rust: for value in &values {
    // rust: let mut c = combo.clone();
    // rust: c.push((name.to_owned(), (*value).to_owned()));
    // rust: next.push(c);
}
}
    // rust: combos = next;
}
    // rust: Ok(combos)
}

// Puts a declared state property's values on one of a block's state rows.
// Only `facts.json` keeps a state's own row, whose fifth field is
// `{"id": …, "properties": {…}}`; the other files' rows are per block, so
// they have no property map to extend.
set_state_properties :: proc(row: ^J, combo: ^[(string) {
}
    // rust: let J::Arr(parts) = row else {
    // rust: return;
}
    // rust: let Some(J::Obj(state)) = parts.get_mut(4) else {
    // rust: return;
}
    // rust: if !state.iter().any(|(k, _)| k == "properties") {
    // rust: state.push(("properties".into(), J::Obj(Vec::new())));
}
    // rust: let Some((_, properties)) = state.iter_mut().find(|(k, _)| k == "properties") else {
    // rust: return;
}
    // rust: for (name, value) in combo {
    // rust: properties.set(name, J::Str(value.clone()));
}
}

// The same for an NBT table's state, which spells a state the way
// `BlockState::to_nbt` does: `{id: "…", properties: {"<name>": "<value>"}}`,
// with the compound left out when there are no properties.
set_nbt_properties :: proc(state: ^Tag, combo: ^[(string) {
}
    // rust: if combo.is_empty() {
    // rust: return;
}
    // rust: let Tag::Compound(c) = state else {
    // rust: return;
}
    // rust: let properties = c
    // rust: .entry(JavaString::from("properties"))
    // rust: .or_insert_with(|| Tag::Compound(Compound::new()));
    // rust: let Tag::Compound(properties) = properties else {
    // rust: return;
}
    // rust: for (name, value) in combo {
    // rust: properties.insert(
    // rust: JavaString::from(name.as_str()),
    // rust: Tag::String(JavaString::from(value.as_str())),
    // rust: );
}
}

// DiscreteVoxelShape.forAllEdges: merge consecutive boundary edges.
shape_edges :: proc(shape: ^VoxelShape) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let sizes = shape.sizes();
    // rust: let mut result = Vec::new();
    // rust: for axis in [2, 0, 1] {
    // rust: let a = (axis + 1) % 3;
    // rust: let b = (axis + 2) % 3;
    // rust: for u in 0..=sizes[a] {
    // rust: for v in 0..=sizes[b] {
    // rust: let mut start = None;
    // rust: for t in 0..=sizes[axis] {
    // rust: let mut count = 0;
    // rust: let mut odd = 0;
    // rust: for du in 0..=1 {
    // rust: for dv in 0..=1 {
    // rust: let mut p = [0i32; 3];
    // rust: p[axis] = t as i32;
    // rust: p[a] = u as i32 + du - 1;
    // rust: p[b] = v as i32 + dv - 1;
    // rust: if shape.is_full(p[0], p[1], p[2]) {
    // rust: count += 1;
    // rust: odd ^= du ^ dv;
}
}
}
    // rust: let edge = count == 1 || count == 3 || (count == 2 && odd == 0);
    // rust: if edge {
    // rust: if start.is_none() {
    // rust: start = Some(t);
}
    // rust: } else if let Some(first) = start.take() {
    // rust: let mut from = [0.0; 3];
    // rust: let mut to = [0.0; 3];
    // rust: from[a] = shape.coordinates(Axis::ALL[a])[u];
    // rust: from[b] = shape.coordinates(Axis::ALL[b])[v];
    // rust: to[a] = from[a];
    // rust: to[b] = from[b];
    // rust: from[axis] = shape.coordinates(Axis::ALL[axis])[first];
    // rust: to[axis] = shape.coordinates(Axis::ALL[axis])[t];
    // rust: result.push(J::Arr(from.into_iter().chain(to).map(J::f64).collect()));
}
}
}
}
}
    // rust: result
}

encode_shape :: proc(shape: ^VoxelShape) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut c = nbt::Compound::new();
    // rust: let (min, max) = shape.discrete_bounds();
    // rust: c.insert("canonical".into(), Tag::Byte(0));
    // rust: c.insert("cube".into(), Tag::Byte(i8::from(shape.is_cube())));
    // rust: let axes = shape.cube_coordinate_axes();
    // rust: c.insert(
    // rust: "cube_axes".into(),
    // rust: Tag::Byte((axes[0] as i8) | ((axes[1] as i8) << 1) | ((axes[2] as i8) << 2)),
    // rust: );
    // rust: for (name, axis) in ["x", "y", "z"].into_iter().zip(Axis::ALL) {
    // rust: c.insert(
    // rust: name.into(),
    // rust: Tag::LongArray(
    // rust: shape
    // rust: .coordinates(axis)
    // rust: .iter()
    // rust: .map(|n| n.to_bits() as i64)
    // rust: .collect(),
    // rust: ),
    // rust: );
}
    // rust: let [x, y, z] = shape.sizes();
    // rust: let mut occupied = Vec::with_capacity(x * y * z);
    // rust: for i in 0..x {
    // rust: for j in 0..y {
    // rust: for k in 0..z {
    // rust: occupied.push(u8::from(shape.is_full(i as i32, j as i32, k as i32)));
}
}
}
    // rust: c.insert("occupied".into(), Tag::ByteArray(occupied));
    // rust: c.insert("discrete_min".into(), Tag::IntArray(min.to_vec()));
    // rust: c.insert("discrete_max".into(), Tag::IntArray(max.to_vec()));
    // rust: Tag::Compound(c)
}

    // rust: fn resolve_shapes<'a>(
    // rust: spec: &BlockShapes,
    // rust: block: &str,
    // rust: states: &Range<u32>,
    // rust: order: &[(u32, u32)],
    // rust: combos: &[Vec<(String, String)>],
    // rust: properties: impl Fn(u32) -> Option<&'a J>,
    // rust: ) -> Result<Vec<VoxelShape>> {
    // rust: let names = spec.property_names();
    // rust: let mut used = BTreeSet::new();
    // rust: let mut shapes = Vec::with_capacity(order.len());
    // rust: for &(state, combo) in order {
    // rust: let values = names
    // rust: .iter()
    // rust: .map(|name| {
    // rust: combos[combo as usize]
    // rust: .iter()
    // rust: .find(|(key, _)| key == name)
    // rust: .map(|(_, value)| value.as_str())
    // rust: .or_else(|| {
    // rust: match properties(states.start + state).and_then(|props| props.get(name)) {
    // rust: Some(J::Str(value)) => Some(value.as_str()),
    // rust: _ => None,
}
    // rust: })
    // rust: .ok_or_else(|| format!("{block}: state lacks shape property {name}"))
    // rust: })
    // rust: .collect::<std::result::Result<Vec<_>, _>>()?;
    // rust: let key = values.join(",");
    // rust: let boxes = if let Some(boxes) = spec.values.get(&key) {
    // rust: used.insert(key);
    // rust: boxes
    // rust: } else {
    // rust: spec.default
    // rust: .as_ref()
    // rust: .ok_or_else(|| format!("{block}: no shape for {key}"))?
}
    // rust: let mut shape = VoxelShape::empty();
    // rust: for bounds in boxes {
    // rust: let part = VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(bounds[0], bounds[1], bounds[2]),
    // rust: Vec3::new(bounds[3], bounds[4], bounds[5]),
    // rust: ))?;
    // rust: shape = shape.join_unoptimized(&part, ShapeOp::OR)?;
}
    // rust: shapes.push(shape);
}
    // rust: if used.len() != spec.values.len() {
    // rust: return Err(
    // rust: format!("{block}: shape values include an unknown property value tuple").into(),
    // rust: );
}
    // rust: Ok(shapes)
}

// A block being added: its declaration and where its states go.
NewBlock :: struct {
    decl: ^'a Block,
    rename: Rename,
    // The template's item, if it has one.
    item: Maybe(string),
    shapes: Maybe([dynamic]VoxelShape),
    collision_shapes: Maybe([dynamic]VoxelShape),
    default: u32,
    // The declared state properties' combinations, every property at its
    // default first (one empty combination when the block declares none):
    // the block's states are its template's states times these.
    combos: Vec<Vec<(string,
    // Each state's template state offset and combination index, in registry order
    // (`state_order`).
    order: Vec<(u32,
    // The sign whose item places this block on a wall, which makes that item
    // this block's too (`StandingAndWallBlockItem.registerBlocks`).
    wall_of: Maybe(string),
}
    // rust: impl NewBlock<'_> {
    // Template states and declared combinations in registry order.
state_combinations :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.rename.states.start;
    // rust: self.order
    // rust: .iter()
    // rust: .map(move |&(state, combo)| (start + state, self.combos[combo as usize].as_slice()))
}
}
// An item being added (declared, or a block's).
NewItem :: struct {
    rename: Rename,
    max_stack_size: Maybe(u8),
    rarity: Maybe(Rarity),
    components: Vec<(string,
    crafting_remainder: Maybe(string),
    // `StandingAndWallBlockItem.wallBlock`, when its block declares it.
    wall_block: Maybe(string),
}

Plan :: struct {
    blocks: [dynamic]NewBlock<'a>,
    items: [dynamic]NewItem,
    // Every vanilla item id, including items omitted from the search tab.
    vanilla_items: BTreeSet<string>,
    effects: [dynamic]^'a MobEffect,
    entity_types: [dynamic]^'a EntityType,
    menu_types: [dynamic]^'a MenuType,
    // Vanilla's state count (the tables' length before).
    states: uint,
    // Each vanilla block's default state.
    defaults: BTreeMap<string,
    // The gameplay rows' sound objects, by block, for `sounds` overrides.
    sounds: BTreeMap<string,
    // The mods' creative tabs, in mod order.
    tabs: [dynamic]^'a CreativeTab,
    // The mods' English names of their items and blocks (`item.<ns>.<path>`,
    // `block.<ns>.<path>`), for the search tab.
    names: BTreeMap<string,
}

// Component types present in the vanilla item table.
known_components :: proc(base: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = base.join("items.json");
    // rust: if !path.exists() {
    // rust: return Ok(BTreeSet::new());
}
    // rust: Ok(component_types(&read_json(&path)?))
}

component_types :: proc(map: ^J) -> B {
    // Ported from Horizon
    return {}
}
    // rust: match map {
    // rust: J::Obj(entries) => entries
    // rust: .iter()
    // rust: .filter_map(|(_, v)| match v {
    // rust: J::Obj(c) => Some(c.iter().map(|(k, _)| k.clone())),
    // rust: _ => None,
    // rust: })
    // rust: .flatten()
    // rust: .collect(),
    // rust: _ => BTreeSet::new(),
}
}

// Blocks and items native mods declare in code (`native_blocks`,
// `native_items`), joined to the content mods: each namespace's go into
// the content mod of that id when one is on (a native mod's own `.hmod`,
// with its models and textures), else into a content mod with no files of
// its own. Checked as files are ([`horizon_mods::Content::declare`],
// [`accept_mod`]); a namespace whose declarations are refused is left out
// whole, and its error returned.
    // rust: pub fn accept_declared(
    // rust: mods: &mut Vec<ContentMod>,
    // rust: blocks: &[horizon_mods::content::Block],
    // rust: items: &[horizon_mods::content::Item],
    // rust: known: &BTreeSet<String>,
    // rust: ) -> Vec<String> {
    // rust: let namespace = |id: &str| id.split_once(':').map_or("", |(ns, _)| ns).to_owned();
    // rust: let mut by_namespace: std::collections::BTreeMap<String, (Vec<_>, Vec<_>)> = Default::default();
    // rust: for block in blocks {
    // rust: by_namespace
    // rust: .entry(namespace(&block.id))
    // rust: .or_default()
    // rust: .0
    // rust: .push(block.clone());
}
    // rust: for item in items {
    // rust: by_namespace
    // rust: .entry(namespace(&item.id))
    // rust: .or_default()
    // rust: .1
    // rust: .push(item.clone());
}
    // rust: let mut errors = Vec::new();
    // rust: for (ns, (blocks, items)) in by_namespace {
    // rust: let result = match mods.iter().position(|m| m.id == ns) {
    // rust: Some(i) => {
    // rust: let mut content = horizon_mods::Content::declared(&ns);
    // rust: content.blocks.clone_from(&mods[i].content.blocks);
    // rust: content.items.clone_from(&mods[i].content.items);
    // rust: content
    // rust: .declare(&blocks, &items)
    // rust: .and_then(|()| {
    // rust: let mut added = horizon_mods::Content::declared(&ns);
    // rust: added.blocks.clone_from(&blocks);
    // rust: added.items.clone_from(&items);
    // rust: validate_components(&added, known).map_err(|e| e.to_string())
    // rust: })
    // rust: .map(|()| {
    // rust: mods[i].content.blocks.extend(blocks);
    // rust: mods[i].content.items.extend(items);
    // rust: })
}
    // rust: None => {
    // rust: let mut content = horizon_mods::Content::declared(&ns);
    // rust: content.declare(&blocks, &items).and_then(|()| {
    // rust: let candidate = ContentMod {
    // rust: id: ns.clone(),
    // rust: content,
}
    // rust: accept_mod(mods, candidate, known).map_err(|e| e.to_string())
    // rust: })
}
}
    // rust: if let Err(e) = result {
    // rust: errors.push(format!("native blocks and items of {ns}: {e}"));
}
}
    // rust: errors
}

// Check and accept one mod without disturbing previously accepted mods.
    // rust: pub fn accept_mod(
    // rust: mods: &mut Vec<ContentMod>,
    // rust: candidate: ContentMod,
    // rust: known: &BTreeSet<String>,
    // rust: ) -> Result<()> {
    // rust: validate_components(&candidate.content, known)?;
    // rust: let own = (
    // rust: candidate.id.as_str(),
    // rust: candidate.content.namespaces.as_slice(),
    // rust: );
    // rust: if let Some(error) = mods
    // rust: .iter()
    // rust: .find_map(|c| horizon_mods::content::clash((&c.id, &c.content.namespaces), own))
    // rust: {
    // rust: return Err(error.into());
}
    // rust: mods.push(candidate);
    // rust: Ok(())
}

validate_components :: proc(content: ^horizon_mods::Content, known: ^BTreeSet<string>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: for (id, components) in content.items.iter().map(|i| (&i.id, &i.components)).chain(
    // rust: content
    // rust: .blocks
    // rust: .iter()
    // rust: .filter(|b| b.item)
    // rust: .map(|b| (&b.id, &b.components)),
    // rust: ) {
    // rust: let patch = component_patch(id, components)?;
    // rust: patch_components(&mut J::Obj(Vec::new()), &patch, known)
    // rust: .map_err(|e| format!("{id}: {e}"))?;
}
    // rust: Ok(())
}

// An item's component patch on its entry; `known` holds every type a vanilla item has, so typos fail.
    // rust: fn patch_components(
    // rust: entry: &mut J,
    // rust: patch: &[(String, J)],
    // rust: known: &BTreeSet<String>,
    // rust: ) -> std::result::Result<(), String> {
    // rust: for (key, value) in patch {
    // rust: let kind = key.strip_prefix('!').unwrap_or(key);
    // rust: if !known.contains(kind) && horizon_protocol::item::custom::id(kind).is_none() {
    // rust: return Err(format!("{kind} is not a known component type"));
}
    // rust: if kind == key {
    // rust: entry.set(key, value.clone());
    // rust: } else {
    // rust: entry.remove(kind);
}
}
    // rust: Ok(())
}

// A declared component patch, as the overlay's JSON.
    // rust: fn component_patch(
    // rust: id: &str,
    // rust: components: &BTreeMap<String, serde_json::Value>,
    // rust: ) -> Result<Vec<(String, J)>> {
    // rust: components
    // rust: .iter()
    // rust: .map(|(key, value)| {
    // rust: if !key.starts_with('!') && horizon_protocol::item::custom::id(key).is_some() {
    // rust: let tag = horizon_client_core::scoreboard::json_to_tag(value);
    // rust: horizon_protocol::item::custom::validate(&tag)
    // rust: .map_err(|error| format!("{id}: component {key}: {error}"))?;
}
    // rust: Ok((
    // rust: key.clone(),
    // rust: serde_json::from_value(value.clone()).map_err(|error| format!("{id}: {error}"))?,
    // rust: ))
    // rust: })
    // rust: .collect()
}

read_json :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(serde_json::from_slice(&fs::read(path)?).map_err(|e| format!("{}: {e}", path.display()))?)
}

    // rust: impl Plan<'_> {
    // `entity-types.json` with a row for each mod type: its template's, so its
    // size, eyes and category are the template's (`execute anchored eyes`,
    // spawner checks and the commands' entity type list, `reg.entity_types`),
    // with `template` naming it and a living type's own attribute bases
    // (`MobTypes` makes the mob from it). The rows are appended as text, each
    // value as the template has it: parsed and written back, a float such as
    // a zombie's `movement_speed` can come back one ulp off.
entity_types_json :: proc(self: ^Self, bytes: []u8) -> s {
    // Ported from Horizon
    return {}
}
//         use serde_json::value::RawValue;
    // rust: let rows: BTreeMap<String, Box<RawValue>> =
    // rust: serde_json::from_slice(bytes).map_err(|e| e.to_string())?;
    // rust: let mut out = bytes.trim_ascii_end().to_vec();
    // rust: if out.pop() != Some(b'}') {
    // rust: return Err("not an object".into());
}
    // rust: let mut empty = rows.is_empty();
    // rust: for t in &self.entity_types {
    // rust: if rows.contains_key(&t.id) {
    // rust: continue;
}
    // rust: let Some(row) = rows.get(&t.template) else {
    // rust: continue;
}
    // rust: if !std::mem::take(&mut empty) {
    // rust: out.push(b',');
}
    // rust: out.extend(serde_json::to_vec(&t.id).map_err(|e| e.to_string())?);
    // rust: out.push(b':');
    // rust: out.extend(mod_entity_row(row, t)?);
}
    // rust: out.push(b'}');
    // rust: Ok(out)
}
}

// A mod entity type's row in `entity-types.json`: its template's `row` with
// `template` added and the type's attribute bases in place of the
// template's. The other values keep the template's text.
    // rust: fn mod_entity_row(
    // rust: row: &serde_json::value::RawValue,
    // rust: t: &EntityType,
    // rust: ) -> std::result::Result<Vec<u8>, String> {
//     use serde_json::value::{RawValue, to_raw_value};
    // rust: type Raw = BTreeMap<String, Box<RawValue>>;
    // rust: let fail = |e: serde_json::Error| format!("{}: {e}", t.template);
    // rust: let mut fields: Raw = serde_json::from_str(row.get()).map_err(fail)?;
    // rust: if !t.attributes.is_empty() {
    // rust: let mut attributes: Raw = match fields.get("attributes") {
    // rust: Some(a) => serde_json::from_str(a.get()).map_err(fail)?,
    // rust: None => Raw::new(),
}
    // rust: for (id, value) in &t.attributes {
            // Refused rather than added: the mob reads the attributes its
            // template's class has, so an extra one would do nothing.
    // rust: let Some(base) = attributes.get_mut(id) else {
    // rust: return Err(format!(
    // rust: "{}: attribute {id} is not one of {}'s",
    // rust: t.id, t.template
    // rust: ));
}
    // rust: *base = to_raw_value(value).map_err(fail)?;
}
    // rust: fields.insert(
    // rust: "attributes".into(),
    // rust: to_raw_value(&attributes).map_err(fail)?,
    // rust: );
}
    // rust: fields.insert("template".into(), to_raw_value(&t.template).map_err(fail)?);
    // rust: serde_json::to_vec(&fields).map_err(fail)
}

    // rust: impl<'a> Plan<'a> {
new :: proc(base: ^Path, mods: ^'a [ContentMod]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let vanilla_items = match base.join("items.json").exists() {
    // rust: true => match read_json(&base.join("items.json"))? {
    // rust: J::Obj(entries) => entries.into_iter().map(|(id, _)| id).collect(),
    // rust: _ => return Err("items.json is not an object".into()),
    // rust: },
    // rust: false => BTreeSet::new(),
}
    // rust: let mut facts = read_json(&base.join("facts.json"))?;
    // rust: let names: Vec<String> = match facts.at("states") {
    // rust: Some(J::Arr(states)) => states
    // rust: .iter()
    // rust: .map(|s| match s {
    // rust: J::Arr(row) => match row.first() {
    // rust: Some(J::Str(name)) => Ok(name.clone()),
    // rust: _ => Err("facts.json: a state without a name"),
    // rust: },
    // rust: _ => Err("facts.json: a state that is not a row"),
    // rust: })
    // rust: .collect::<std::result::Result<_, _>>()?,
    // rust: _ => return Err("facts.json: no states".into()),
}
    // rust: let defaults: BTreeMap<String, u32> = match facts.at("defaults") {
    // rust: Some(J::Obj(o)) => o
    // rust: .iter()
    // rust: .filter_map(|(k, v)| Some((k.clone(), v.as_u32()?)))
    // rust: .collect(),
    // rust: _ => return Err("facts.json: no defaults".into()),
}
    // rust: let range = |name: &str| -> Option<Range<u32>> {
    // rust: let start = names.iter().position(|n| n == name)?;
    // rust: let len = names[start..].iter().take_while(|n| *n == name).count();
            // A block's states are one run in registry order.
    // rust: (names[start + len..].iter().all(|n| n != name))
    // rust: .then_some(start as u32..(start + len) as u32)
}
    // rust: let mut blocks = Vec::new();
    // rust: let mut next = names.len() as u32;
    // rust: let mut sorted: Vec<&ContentMod> = mods.iter().collect();
    // rust: sorted.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: let mut wanted_sounds = Vec::new();
    // rust: for m in &sorted {
    // rust: let mut declared: Vec<&Block> = m.content.blocks.iter().collect();
    // rust: declared.sort_by(|a, b| a.id.cmp(&b.id));
    // rust: for decl in declared {
    // rust: if defaults.contains_key(&decl.id) {
    // rust: return Err(format!("{}: {} is already a block", m.id, decl.id).into());
}
    // rust: let states = range(&decl.template).ok_or_else(|| {
    // rust: format!("{}: template {} is not a block", decl.id, decl.template)
    // rust: })?;
    // rust: let pipe_shapes = if let Some(size) = decl.thickness {
    // rust: let Some(J::Arr(rows)) = facts.get("states") else {
    // rust: unreachable!()
}
    // rust: let shapes = states.clone().map(|id| {
    // rust: let props = match &rows[id as usize] {
    // rust: J::Arr(row) => row.get(4).and_then(|p| p.get("properties")),
    // rust: _ => None,
}
    // rust: let sides = ["down", "up", "north", "south", "west", "east"]
    // rust: .map(|k| matches!(props.and_then(|p| p.get(k)), Some(J::Str(v)) if v == "true"));
    // rust: horizon_world::collision::pipe_shape(size.into(), sides)
    // rust: });
    // rust: Some(shapes.collect::<std::io::Result<_>>()?)
    // rust: } else {
    // rust: None
}
    // rust: let mut default = *defaults.get(&decl.template).ok_or_else(|| {
    // rust: format!(
    // rust: "{}: template {} has no default state",
    // rust: decl.id, decl.template
    // rust: )
    // rust: })?;
    // rust: let Some(J::Arr(rows)) = facts.get("states") else {
    // rust: unreachable!()
}
    // rust: let properties = |id: u32| -> Option<&J> {
    // rust: let J::Arr(row) = rows.get(id as usize)? else {
    // rust: return None;
}
    // rust: row.get(4)?.get("properties")
}
    // rust: for key in decl.state_properties.keys() {
    // rust: if properties(default).is_some_and(|p| p.get(key).is_some()) {
    // rust: return Err(format!(
    // rust: "{}: state property {key} is already on {}",
    // rust: decl.id, decl.template
    // rust: )
    // rust: .into());
}
}
    // rust: let combos = combinations(&decl.state_properties, &decl.default_state)
    // rust: .map_err(|e| format!("{}: {e}", decl.id))?;
                // A `default_state` key the block itself declares is its own,
                // and `combinations` already checks that value against the
                // property. Only a key the template already has narrows which
                // of the template's states is the default, and only that needs
                // the template's own properties: a template with none (`stone`
                // has a single state) can still be given a property and have
                // it defaulted.
    // rust: let on_template = decl
    // rust: .default_state
    // rust: .keys()
    // rust: .any(|key| !decl.state_properties.contains_key(key));
    // rust: if on_template {
    // rust: let mut wanted = properties(default).cloned().ok_or_else(|| {
    // rust: format!("{}: template default has no state properties", decl.id)
    // rust: })?;
    // rust: for (key, value) in &decl.default_state {
    // rust: if decl.state_properties.contains_key(key) {
    // rust: continue;
}
    // rust: if wanted.get(key).is_none() {
    // rust: return Err(format!(
    // rust: "{}: unknown state property {key} on {}",
    // rust: decl.id, decl.template
    // rust: )
    // rust: .into());
}
    // rust: wanted.set(key, J::Str(value.clone()));
}
    // rust: let matches: Vec<u32> = states
    // rust: .clone()
    // rust: .filter(|id| {
    // rust: properties(*id).is_some_and(|p| {
    // rust: let (J::Obj(a), J::Obj(b)) = (p, &wanted) else {
    // rust: return false;
}
    // rust: a.len() == b.len() && b.iter().all(|(k, v)| p.get(k) == Some(v))
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: if matches.len() != 1 {
    // rust: return Err(format!(
    // rust: "{}: default_state {:?} matches {} states of {}",
    // rust: decl.id,
    // rust: decl.default_state,
    // rust: matches.len(),
    // rust: decl.template
    // rust: )
    // rust: .into());
}
    // rust: default = matches[0];
}
                // The game reads a state table as vanilla's `StateDefinition` does: every
                // property, the template's and the declared ones, sorted by name, the first
                // name slowest. A declared name that sorts before the template's has to
                // interleave with them, so the states are laid out in that order.
    // rust: let declared: Vec<(String, u32)> = decl
    // rust: .state_properties
    // rust: .iter()
    // rust: .map(|(name, property)| (name.clone(), property.values().len() as u32))
    // rust: .collect();
    // rust: let order = block_order(&states, properties, &declared, combos.len() as u32);
    // rust: let resolve = |spec: &BlockShapes| {
    // rust: resolve_shapes(spec, &decl.id, &states, &order, &combos, properties)
}
    // rust: let shapes = if let Some(spec) = &decl.shapes {
    // rust: Some(resolve(spec)?)
    // rust: } else {
    // rust: pipe_shapes.map(|shapes: Vec<VoxelShape>| {
    // rust: order
    // rust: .iter()
    // rust: .map(|&(state, _)| shapes[state as usize].clone())
    // rust: .collect()
    // rust: })
}
    // rust: let collision_shapes = decl.collision_shapes.as_ref().map(resolve).transpose()?;
                // The lookup from (template state, combination) to the state's row.
    // rust: let mut rows = vec![0; order.len()];
    // rust: for (position, &(state, combo)) in order.iter().enumerate() {
    // rust: rows[state as usize * combos.len() + combo as usize] = position as u32;
}
    // rust: let mut rename = Rename::new(&decl.template, &decl.id);
    // rust: rename.first = next;
    // rust: rename.fanout = combos.len() as u32;
    // rust: rename.rows = rows;
    // rust: let count =
    // rust: u32::try_from(states.len() as u64 * combos.len() as u64).unwrap_or(u32::MAX);
    // rust: next = next.saturating_add(count);
    // rust: rename.states = states;
    // rust: if let Some(s) = &decl.properties.sounds {
    // rust: if !defaults.contains_key(s) {
    // rust: return Err(format!("{}: sounds {s} is not a block", decl.id).into());
}
    // rust: wanted_sounds.push(s.clone());
}
    // rust: blocks.push(NewBlock {
    // rust: decl,
    // rust: rename,
    // rust: item: None,
    // rust: shapes,
    // rust: collision_shapes,
    // rust: default,
    // rust: combos,
    // rust: order,
    // rust: wall_of: None,
    // rust: });
}
}
        // A sign's wall form, which `Content` checked against its mod's blocks.
    // rust: let pairs: Vec<_> = blocks
    // rust: .iter()
    // rust: .filter_map(|b| Some((b.decl.wall_block.clone()?, b.decl.id.clone())))
    // rust: .collect();
    // rust: for (wall, sign) in pairs {
    // rust: if let Some(block) = blocks.iter_mut().find(|b| b.decl.id == wall) {
    // rust: block.wall_of = Some(sign);
}
}
    // rust: if next > MAX_STATES {
    // rust: let mut by_mod: BTreeMap<&str, u32> = BTreeMap::new();
    // rust: for b in &blocks {
    // rust: *by_mod
    // rust: .entry(&b.decl.id[..b.decl.id.find(':').unwrap_or(0)])
    // rust: .or_default() += (b.rename.states.len() as u32).saturating_mul(b.rename.fanout);
}
    // rust: let list: Vec<String> = by_mod.iter().map(|(m, n)| format!("{m} {n}")).collect();
    // rust: return Err(format!(
    // rust: "{next} block states, more than the {MAX_STATES} a world can hold ({} in the game; \
    // rust: the mods: {})",
    // rust: names.len(),
    // rust: list.join(", ")
    // rust: )
    // rust: .into());
}
        // Block items copy the template block's item.
    // rust: let gameplay = read_json(&base.join("gameplay-facts.json"))?;
    // rust: let rows = match gameplay.get("states") {
    // rust: Some(J::Arr(rows)) if rows.len() == names.len() => rows,
    // rust: _ => return Err("gameplay-facts.json does not match facts.json".into()),
}
    // rust: let mut sounds = BTreeMap::new();
    // rust: for s in wanted_sounds {
    // rust: let row = &rows[defaults[&s] as usize];
    // rust: sounds.insert(s, row.get("sound").cloned().unwrap_or(J::Null));
}
    // rust: let mut items = Vec::new();
    // rust: for b in &mut blocks {
    // rust: let row = &rows[b.rename.states.start as usize];
    // rust: b.item = match row.get("item") {
    // rust: Some(J::Str(i)) if i != "minecraft:air" => Some(i.clone()),
    // rust: _ => None,
}
    // rust: if b.decl.item {
    // rust: let item = b.item.as_deref().ok_or_else(|| {
    // rust: format!("{}: template {} has no item", b.decl.id, b.decl.template)
    // rust: })?;
    // rust: items.push(NewItem {
    // rust: rename: Rename::new(item, &b.decl.id),
    // rust: max_stack_size: None,
    // rust: rarity: None,
    // rust: components: component_patch(&b.decl.id, &b.decl.components)?,
    // rust: crafting_remainder: None,
    // rust: wall_block: b.decl.wall_block.clone(),
    // rust: });
}
}
    // rust: for m in &sorted {
    // rust: for i in &m.content.items {
    // rust: items.push(NewItem {
    // rust: rename: Rename::new(&i.template, &i.id),
    // rust: max_stack_size: i.max_stack_size,
    // rust: rarity: i.rarity,
    // rust: components: component_patch(&i.id, &i.components)?,
    // rust: crafting_remainder: i.crafting_remainder.clone(),
    // rust: wall_block: None,
    // rust: });
}
}
        // Block items and standalone items share the same registry. Sort
        // them together by mod ID and entry name before assigning IDs.
    // rust: items.sort_by(|a, b| a.rename.to.cmp(&b.rename.to));
    // rust: let mut tabs = Vec::new();
    // rust: let mut lang = BTreeMap::new();
    // rust: for m in &sorted {
    // rust: tabs.extend(m.content.creative_tabs.iter());
    // rust: for ns in &m.content.namespaces {
    // rust: let Ok(bytes) = m.content.file(&format!("assets/{ns}/lang/en_us.json")) else {
    // rust: continue;
}
    // rust: if let Ok(map) = serde_json::from_slice::<BTreeMap<String, String>>(&bytes) {
    // rust: lang.extend(map);
}
}
}
    // rust: Ok(Plan {
    // rust: blocks,
    // rust: items,
    // rust: vanilla_items,
    // rust: effects: mob_effects(mods),
    // rust: entity_types: entity_types(mods),
    // rust: menu_types: menu_types(mods),
    // rust: states: names.len(),
    // rust: defaults,
    // rust: sounds,
    // rust: tabs,
    // rust: names: lang,
    // rust: })
}

    // What moves in a new block's copies of its template's rows: the
    // block, and the template's item when it has another name. A block
    // without an item gets `minecraft:air` where rows name one, except a
    // sign's wall form, whose item is the paired sign's.
renames :: proc(self: ^Self, b: ^NewBlock) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![b.rename.clone()];
    // rust: let own = b.decl.item.then_some(b.decl.id.as_str());
    // rust: if let Some(item) = b.item.as_deref().filter(|i| *i != b.decl.template)
    // rust: && let Some(to) = own.or(b.wall_of.as_deref())
    // rust: {
    // rust: out.push(Rename::new(item, to));
}
    // rust: out
}

    // Appends each new block's copies of the template's states to `list`;
    // `gameplay` rows get their index and the declared overrides.
states :: proc(self: ^Self, list: ^[dynamic]J, ids: bool, gameplay: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if list.len() != self.states {
    // rust: return Err(format!("{} states, not {}", list.len(), self.states).into());
}
    // rust: for b in &self.blocks {
    // rust: let renames = self.renames(b);
            // One row per template state per combination the block declares,
            // so its states stay one run in registry order.
    // rust: for (next, (id, combo)) in (b.rename.first..).zip(b.state_combinations()) {
    // rust: let state_index = (next - b.rename.first) as usize;
    // rust: let mut row = list[id as usize].clone();
    // rust: for r in &renames {
    // rust: row.rename(r, ids);
}
    // rust: if !combo.is_empty() {
    // rust: set_state_properties(&mut row, combo);
}
    // rust: if gameplay {
    // rust: row.set("id", J::Num(next.into()));
    // rust: if !b.decl.item && b.wall_of.is_none() {
    // rust: row.set("item", J::Str("minecraft:air".into()));
}
    // rust: self.override_gameplay(b, combo, &mut row);
    // rust: if let Some(shapes) = &b.shapes {
    // rust: let shape = &shapes[state_index];
    // rust: let boxes = shape
    // rust: .boxes()
    // rust: .iter()
    // rust: .map(|b| {
    // rust: J::Arr(
    // rust: [
    // rust: b.min(Axis::X),
    // rust: b.min(Axis::Y),
    // rust: b.min(Axis::Z),
    // rust: b.max(Axis::X),
    // rust: b.max(Axis::Y),
    // rust: b.max(Axis::Z),
    // rust: ]
    // rust: .into_iter()
    // rust: .map(J::f64)
    // rust: .collect(),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: row.set("outline", J::Arr(boxes));
    // rust: row.set("outline_edges", J::Arr(shape_edges(shape)));
}
    // rust: if let Some(shapes) = b.collision_shapes.as_ref().or(b.shapes.as_ref()) {
    // rust: let shape = &shapes[state_index];
    // rust: row.set(
    // rust: "full_collision",
    // rust: J::Bool(!shape.join_is_not_empty(&VoxelShape::block(), ShapeOp::XOR)?),
    // rust: );
}
}
    // rust: list.push(row);
}
}
    // rust: Ok(())
}

    // The declared properties, on a gameplay row.
override_gameplay :: proc(self: ^Self, b: ^NewBlock, combo: ^[(string) {
}
    // rust: let p = &b.decl.properties;
    // rust: if let Some(ticks) = &p.random_ticks {
    // rust: row.set("random_ticks", J::Bool(ticks.applies(combo)));
}
    // rust: if let Some(shape) = p.render_shape {
    // rust: row.set("render_shape", J::Str(shape.name().into()));
}
        // `noOcclusion`: a block that can't occlude is never a solid render either, and a solid
        // render's full light dampening becomes a non-solid block's (`getLightDampening`: 0 when
        // skylight passes down, else 1, as for leaves and spawners).
    // rust: if p.occludes == Some(false) {
    // rust: let solid = matches!(row.get("solid_render"), Some(J::Bool(true)));
    // rust: if solid {
    // rust: let down = matches!(row.get("skylight_down"), Some(J::Bool(true)));
    // rust: row.set("dampening", J::Num(i64::from(!down).into()));
}
    // rust: row.set("can_occlude", J::Bool(false));
    // rust: row.set("solid_render", J::Bool(false));
}
    // rust: if let Some(v) = p.hardness {
    // rust: row.set("hardness", J::f64(v as f64));
}
    // rust: if let Some(v) = p.explosion_resistance {
    // rust: row.set("explosion_resistance", J::f64(v as f64));
}
    // rust: if let Some(v) = p.light {
    // rust: row.set("emission", J::Num(v.into()));
}
    // rust: if let Some(v) = p.requires_tool {
    // rust: row.set("requires_tool", J::Bool(v));
}
    // rust: if let Some(v) = p.friction {
    // rust: row.set("friction", J::f64(v as f64));
}
    // rust: if let Some(v) = p.map_color {
    // rust: let col = if v == 0 { 0 } else { MAP_COLORS[v as usize] };
    // rust: row.set("map_color", J::Num(col.into()));
}
    // rust: if let Some(s) = &p.sounds {
    // rust: row.set("sound", self.sounds[s].clone());
}
}

    // Adds each new block's copy of the template's entry to a map by name.
names :: proc(self: ^Self, map: ^J, ids: bool) {
}
    // rust: for b in &self.blocks {
    // rust: if let Some(v) = map.get(&b.decl.template) {
    // rust: let mut v = v.clone();
    // rust: for r in &self.renames(b) {
    // rust: v.rename(r, ids);
}
    // rust: map.set(&b.decl.id, v);
}
}
}

    // Adds each new item's copy of its template's entry to a map by name;
    // `components` applies the overrides (items.json).
items :: proc(self: ^Self, map: ^J, components: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let known = if components {
    // rust: component_types(map)
    // rust: } else {
    // rust: BTreeSet::new()
}
    // rust: for i in &self.items {
    // rust: let Some(v) = map.get(&i.rename.from) else {
    // rust: continue;
}
    // rust: let mut v = v.clone();
    // rust: v.rename(&i.rename, false);
    // rust: if let Some(wall) = &i.wall_block
    // rust: && let Some(fields) = v.get_mut("fields")
    // rust: {
    // rust: fields.set("wallBlock", J::Str(wall.clone()));
}
    // rust: if components {
    // rust: if let Some(n) = i.max_stack_size {
    // rust: v.set("minecraft:max_stack_size", J::Num(n.into()));
}
    // rust: if let Some(r) = i.rarity {
    // rust: let r = match r {
    // rust: Rarity::Common => "common",
    // rust: Rarity::Uncommon => "uncommon",
    // rust: Rarity::Rare => "rare",
    // rust: Rarity::Epic => "epic",
}
    // rust: v.set("minecraft:rarity", J::Str(r.into()));
}
    // rust: patch_components(&mut v, &i.components, &known)
    // rust: .map_err(|e| format!("{}: {e}", i.rename.to))?;
}
    // rust: map.set(&i.rename.to, v);
}
    // rust: if components {
    // rust: for i in &self.items {
    // rust: if let Some(rest) = &i.crafting_remainder
    // rust: && map.get(rest).is_none()
    // rust: {
    // rust: return Err(format!(
    // rust: "{}: crafting_remainder {rest:?} is not an item",
    // rust: i.rename.to
    // rust: )
    // rust: .into());
}
}
}
    // rust: Ok(())
}

    // One JSON table, rewritten.
json :: proc(self: ^Self, name: string, doc: ^J) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let states = |doc: &mut J, path: &str, ids: bool, gameplay: bool| -> Result<()> {
    // rust: match doc.at(path) {
    // rust: Some(J::Arr(a)) => self.states(a, ids, gameplay),
    // rust: _ => Err(format!("no list at /{path}").into()),
}
}
    // rust: match name {
    // rust: "facts.json" => {
    // rust: states(doc, "states", false, false)?;
    // rust: let defaults = doc.at("defaults").ok_or("no defaults")?;
    // rust: for b in &self.blocks {
    // rust: let default = b.default;
    // rust: let id = b.rename.id(default).ok_or("a default outside its block")?;
    // rust: defaults.set(&b.decl.id, J::Num(id.into()));
}
}
    // rust: "gameplay-facts.json" => states(doc, "states", false, true)?,
    // rust: "creative-inventory.json" => self.creative_tabs(doc)?,
    // rust: "block-behaviours.json" => {
    // rust: states(doc, "states", false, false)?;
    // rust: let Some(J::Arr(blocks)) = doc.at("blocks") else {
    // rust: return Err("no blocks".into());
}
    // rust: for b in &self.blocks {
    // rust: let template = blocks.iter().find(
    // rust: |x| matches!(x.get("name"), Some(J::Str(n)) if *n == b.decl.template),
    // rust: );
    // rust: if let Some(mut v) = template.cloned() {
    // rust: for r in &self.renames(b) {
    // rust: v.rename(r, false);
}
    // rust: if !b.decl.item && b.wall_of.is_none() {
    // rust: v.set("item", J::Str("minecraft:air".into()));
}
                        // `SignBlock.getWoodType`: the wood's name is what
                        // the editor reads of it.
    // rust: if let Some(wood) = &b.decl.wood_type
    // rust: && let Some(name) = v.at("fields/type/name")
    // rust: {
    // rust: *name = J::Str(wood.clone());
}
                        // A connecting block: the chorus plant's PipeBlock
                        // without its rules, joining the declared tag.
    // rust: if let Some(tag) = &b.decl.connects_to {
    // rust: let classes = ["PipeBlock", "Block"].map(|c| J::Str(c.into()));
    // rust: v.set("class", J::Arr(classes.into()));
    // rust: let mut fields = v
    // rust: .get("fields")
    // rust: .cloned()
    // rust: .unwrap_or(J::Obj(Default::default()));
    // rust: fields.set("connectsTo", J::Str(tag.clone()));
    // rust: v.set("fields", fields);
}
    // rust: blocks.push(v);
}
}
    // rust: self.items(doc.at("items").ok_or("no items")?, false)?;
    // rust: for odds in ["fire/burnOdds", "fire/igniteOdds"] {
    // rust: if let Some(map) = doc.at(odds) {
    // rust: self.names(map, false);
}
}
}
    // rust: "model-states.json" | "render-definitions.json" => {
    // rust: let model = name == "model-states.json";
    // rust: self.names(doc, !model);
    // rust: for b in &self.blocks {
    // rust: let Some(entry) = doc.get_mut(&b.decl.id) else {
    // rust: continue;
}
                    // Faces beside a block that occludes nothing are drawn (`Block.shouldRenderFace`).
    // rust: if !model && b.decl.properties.occludes == Some(false) {
    // rust: entry.set("can_occlude", J::Bool(false));
}
    // rust: if model && let Some(schema) = entry.get_mut("schema") {
    // rust: for (property_name, property) in &b.decl.state_properties {
    // rust: schema.set(
    // rust: property_name,
    // rust: J::Obj(vec![(
    // rust: "named".into(),
    // rust: J::Arr(
    // rust: property
    // rust: .values()
    // rust: .into_iter()
    // rust: .map(|v| J::Str(v.into()))
    // rust: .collect(),
    // rust: ),
    // rust: )]),
    // rust: );
}
}
    // rust: if let Some(J::Arr(states)) = entry.get_mut("states") {
    // rust: let template = states.clone();
    // rust: let mut expanded = Vec::new();
    // rust: for (index, (id, combo)) in b.state_combinations().enumerate() {
    // rust: if model {
    // rust: let mut state = template
    // rust: .get((id - b.rename.states.start) as usize)
    // rust: .ok_or("model states do not match the template")?
    // rust: .clone();
    // rust: for (name, value) in combo {
    // rust: state.set(name, J::Str(value.clone()));
}
    // rust: expanded.push(state);
    // rust: } else {
    // rust: expanded.push(J::Num((b.rename.first + index as u32).into()));
}
}
    // rust: *states = expanded;
}
}
}
    // rust: "landing-definitions.json" | "worldgen/blocks/survival-rules.json" => {
    // rust: self.names(doc, false)
}
    // rust: "worldgen/blocks/survival-extra-definitions.json" => {
    // rust: if let Some(map) = doc.at("ignition_odds") {
    // rust: self.names(map, false);
}
}
    // rust: "items.json" => self.items(doc, true)?,
    // rust: "registries.json" => {
                // Network ids: the game and its server map items, blocks, mob
                // effects and entity types through this report, so new ones get
                // the ids after vanilla's, in plan order. A block entity type for
                // each block too, named after it: a mod names its types only when
                // one is made (`native_block_entity`), and the chunk packet
                // carries the type of each block's entity.
    // rust: let new_items = self.items.iter().map(|i| i.rename.to.clone());
    // rust: let new_blocks: Vec<_> = self.blocks.iter().map(|b| b.decl.id.clone()).collect();
    // rust: let mut registries = vec![
    // rust: ("minecraft:item", new_items.collect::<Vec<_>>()),
    // rust: ("minecraft:block", new_blocks.clone()),
    // rust: ("minecraft:block_entity_type", new_blocks),
    // rust: ];
    // rust: if !self.effects.is_empty() {
    // rust: let new_effects = self.effects.iter().map(|e| e.id.clone());
    // rust: registries.push(("minecraft:mob_effect", new_effects.collect()));
}
    // rust: if !self.entity_types.is_empty() {
    // rust: let new_types = self.entity_types.iter().map(|t| t.id.clone());
    // rust: registries.push(("minecraft:entity_type", new_types.collect()));
}
                // `ClientboundOpenScreenPacket` carries a menu type's id.
    // rust: if !self.menu_types.is_empty() {
    // rust: let new_menus = self.menu_types.iter().map(|m| m.id.clone());
    // rust: registries.push(("minecraft:menu", new_menus.collect()));
}
    // rust: for (registry, names) in registries {
    // rust: let Some(J::Obj(entries)) =
    // rust: doc.get_mut(registry).and_then(|r| r.get_mut("entries"))
    // rust: else {
                        // A report without block entity types gets none.
    // rust: if registry == "minecraft:block_entity_type" {
    // rust: continue;
}
    // rust: return Err(format!("no {registry} entries").into());
}
    // rust: let next = entries
    // rust: .iter()
    // rust: .filter_map(|(_, e)| match e {
    // rust: J::Obj(o) => o.iter().find(|(k, _)| k == "protocol_id")?.1.as_u32(),
    // rust: _ => None,
    // rust: })
    // rust: .max()
    // rust: .map_or(0, |m| m + 1);
    // rust: for (i, name) in names.into_iter().enumerate() {
    // rust: if entries.iter().any(|(k, _)| *k == name) {
    // rust: continue;
}
    // rust: let id = J::Num((next + i as u32).into());
    // rust: entries.push((name, J::Obj(vec![("protocol_id".into(), id)])));
}
}
}
    // rust: "command-registries.json" => {
    // rust: self.names(doc.at("blocks").ok_or("no blocks")?, false);
    // rust: let new_items = || self.items.iter().map(|i| J::Str(i.rename.to.clone()));
    // rust: let new_blocks = || self.blocks.iter().map(|b| J::Str(b.decl.id.clone()));
    // rust: let Some(J::Arr(items)) = doc.at("items") else {
    // rust: return Err("no items".into());
}
    // rust: items.extend(new_items());
                // The registries commands check ids against.
    // rust: if let Some(J::Arr(ids)) = doc.at("by_registry/minecraft:item/ids") {
    // rust: ids.extend(new_items());
}
    // rust: if let Some(J::Arr(ids)) = doc.at("by_registry/minecraft:block/ids") {
    // rust: ids.extend(new_blocks());
}
                // `/effect` and the mob_effect resource arguments.
    // rust: let new_effects = || self.effects.iter().map(|e| J::Str(e.id.clone()));
    // rust: if let Some(J::Arr(ids)) = doc.at("effects") {
    // rust: ids.extend(new_effects());
}
    // rust: if let Some(J::Arr(ids)) = doc.at("by_registry/minecraft:mob_effect/ids") {
    // rust: ids.extend(new_effects());
}
                // entity type arguments and `type=` in selectors.
    // rust: let new_types = || self.entity_types.iter().map(|t| J::Str(t.id.clone()));
    // rust: if let Some(J::Arr(ids)) = doc.at("entity_types") {
    // rust: ids.extend(new_types());
}
    // rust: if let Some(J::Arr(ids)) = doc.at("by_registry/minecraft:entity_type/ids") {
    // rust: ids.extend(new_types());
}
}
    // rust: "mob-data.json" => states(doc, "states", false, false)?,
    // rust: "worldgen/block_flags.json" => states(doc, "", false, false)?,
    // rust: "worldgen/blocks/structure-blocks.json" => {
    // rust: for key in ["rotate", "mirror", "full_block"] {
    // rust: states(doc, key, true, false)?;
}
    // rust: let added: usize = self
    // rust: .blocks
    // rust: .iter()
    // rust: .map(|b| b.rename.states.len() * b.combos.len())
    // rust: .sum();
    // rust: doc.set("states", J::Num(((self.states + added) as u64).into()));
}
    // rust: _ => return Err("no rule for this table".into()),
}
    // rust: Ok(())
}

collision_shapes :: proc(self: ^Self, tag: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Tag::Compound(root) = tag else {
    // rust: return Err("collision table is not a compound".into());
}
    // rust: let mut indices = Vec::new();
    // rust: let Some(Tag::List(entries)) = root.get_mut(&JavaString::from("shapes")) else {
    // rust: return Err("collision table has no shapes".into());
}
    // rust: for block in &self.blocks {
    // rust: if let Some(shapes) = block.collision_shapes.as_ref().or(block.shapes.as_ref()) {
    // rust: let mut encoded = BTreeMap::new();
    // rust: for (offset, shape) in shapes.iter().enumerate() {
    // rust: let key: Vec<_> = shape
    // rust: .boxes()
    // rust: .iter()
    // rust: .map(|bounds| {
    // rust: [
    // rust: bounds.min(Axis::X),
    // rust: bounds.min(Axis::Y),
    // rust: bounds.min(Axis::Z),
    // rust: bounds.max(Axis::X),
    // rust: bounds.max(Axis::Y),
    // rust: bounds.max(Axis::Z),
    // rust: ]
    // rust: .map(f64::to_bits)
    // rust: })
    // rust: .collect();
    // rust: let id = *encoded.entry(key).or_insert_with(|| {
    // rust: entries.push(encode_shape(shape));
    // rust: entries.len() as i32 - 1
    // rust: });
    // rust: indices.push((block.rename.first as usize + offset, id));
}
}
}
    // rust: let Some(Tag::IntArray(mapping)) = root.get_mut(&JavaString::from("cached_shapes")) else {
    // rust: return Err("collision table has no mapping".into());
}
    // rust: for (state, id) in indices {
    // rust: mapping[state] = id;
}
    // rust: Ok(())
}

    // The creative inventory (`creative-inventory.json`): each mod tab after
    // vanilla's, ten to a page as NeoForge pages them (the top row's first
    // five columns, then the bottom row's), with only the items the game has;
    // the mods' new items join the search tab under their English names.
creative_tabs :: proc(self: ^Self, doc: ^J) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(J::Arr(tabs)) = doc.at("tabs") else {
    // rust: return Err("no tabs".into());
}
    // rust: let stack = |id: &str| J::Str(format!("{{count:1,id:\"{id}\"}}"));
        // Blocks' items are among `items` already.
    // rust: let new: Vec<&str> = self.items.iter().map(|i| i.rename.to.as_str()).collect();
    // rust: let search = tabs
    // rust: .iter()
    // rust: .position(|t| matches!(t.get("type"), Some(J::Str(k)) if k == "SEARCH"));
    // rust: let known = |id: &str| new.contains(&id) || self.vanilla_items.contains(id);
    // rust: for (i, tab) in self.tabs.iter().enumerate() {
    // rust: let slot = i % 10;
    // rust: let mut row = J::Obj(Vec::new());
    // rust: row.set("id", J::Str(tab.id.clone()));
    // rust: row.set("type", J::Str("CATEGORY".into()));
    // rust: row.set(
    // rust: "row",
    // rust: J::Str(if slot < 5 { "TOP" } else { "BOTTOM" }.into()),
    // rust: );
    // rust: row.set("column", J::Num((slot % 5).into()));
    // rust: row.set("page", J::Num((1 + i / 10).into()));
    // rust: row.set("title", J::Str(tab.title.clone()));
    // rust: row.set("icon", stack(&tab.icon));
    // rust: row.set("visible", J::Bool(true));
    // rust: let items = tab
    // rust: .items
    // rust: .iter()
    // rust: .filter(|id| known(id))
    // rust: .map(|id| stack(id))
    // rust: .collect();
    // rust: row.set("items", J::Arr(items));
    // rust: tabs.push(row);
}
    // rust: if let Some(search) = search {
    // rust: let name = |id: &str| {
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("", id));
    // rust: ["item", "block"]
    // rust: .iter()
    // rust: .find_map(|kind| self.names.get(&format!("{kind}.{ns}.{path}")))
    // rust: .cloned()
    // rust: .unwrap_or_else(|| path.to_owned())
}
    // rust: let tab = &mut tabs[search];
    // rust: for (key, add) in [
    // rust: ("items", new.iter().map(|id| stack(id)).collect::<Vec<_>>()),
    // rust: (
    // rust: "lines",
    // rust: new.iter()
    // rust: .map(|id| J::Arr(vec![J::Str(name(id))]))
    // rust: .collect(),
    // rust: ),
                // shortcut: a mod item's tags aren't searched by (#tag) yet.
    // rust: ("tags", new.iter().map(|_| J::Arr(Vec::new())).collect()),
    // rust: ] {
    // rust: if let Some(J::Arr(list)) = tab.get_mut(key) {
    // rust: list.extend(add);
}
}
}
    // rust: Ok(())
}
    // One NBT table: `states` lists, `cached_shapes` arrays and `blocks`
    // compounds, wherever they are.
nbt :: proc(self: ^Self, tag: ^Tag) {
}
    // rust: let Tag::Compound(c) = tag else {
    // rust: return;
}
    // rust: for (key, value) in c.iter_mut() {
    // rust: match (key.to_string_lossy().as_str(), value) {
    // rust: ("states", Tag::List(list)) if list.len() == self.states => {
    // rust: for b in &self.blocks {
                        // One row per template state per combination, the same
                        // order `states` numbers them in (`Rename::id`): a
                        // template state's combinations are one run, and the
                        // first of the run is where the template state maps.
    // rust: for (id, combo) in b.state_combinations() {
    // rust: let mut state = list[id as usize].clone();
    // rust: if let Some(slot) = state.get_mut("id") {
    // rust: *slot = Tag::String(b.decl.id.as_str().into());
}
    // rust: set_nbt_properties(&mut state, combo);
    // rust: list.push(state);
}
}
}
    // rust: ("cached_shapes", Tag::IntArray(a)) if a.len() == self.states => {
    // rust: for b in &self.blocks {
                        // Parallel to `states`: every combination of a template
                        // state keeps that state's shape.
    // rust: let mut copy = vec![0; b.order.len()];
    // rust: for (at, id) in b.rename.states.clone().enumerate() {
    // rust: for combination in 0..b.rename.fanout {
    // rust: copy[b.rename.row(at as u32, combination) as usize] =
    // rust: a[id as usize];
}
}
    // rust: a.extend(copy);
}
}
    // rust: ("blocks", Tag::Compound(map)) => {
    // rust: for b in &self.blocks {
    // rust: let Some(mut v) = map
    // rust: .get(&JavaString::from(b.decl.template.as_str()))
    // rust: .cloned()
    // rust: else {
    // rust: continue;
}
    // rust: if let (Some(f), Some(slot)) =
    // rust: (b.decl.properties.friction, v.get_mut("friction"))
    // rust: {
    // rust: *slot = Tag::Float(f.to_bits());
}
    // rust: map.insert(b.decl.id.as_str().into(), v);
}
}
    // rust: (_, inner @ Tag::Compound(_)) => self.nbt(inner),
    // rust: _ => {}
}
}
}
}

// The JSON and NBT tables rewritten for new blocks and items.
    // rust: const JSON_TABLES: [&str; 16] = [
    // rust: "facts.json",
    // rust: "entity-types.json",
    // rust: "creative-inventory.json",
    // rust: "registries.json",
    // rust: "gameplay-facts.json",
    // rust: "block-behaviours.json",
    // rust: "model-states.json",
    // rust: "render-definitions.json",
    // rust: "landing-definitions.json",
    // rust: "items.json",
    // rust: "command-registries.json",
    // rust: "mob-data.json",
    // rust: "worldgen/block_flags.json",
    // rust: "worldgen/blocks/structure-blocks.json",
    // rust: "worldgen/blocks/survival-rules.json",
    // rust: "worldgen/blocks/survival-extra-definitions.json",
    // rust: ];
    // rust: const NBT_TABLES: [&str; 6] = [
    // rust: "occlusion.nbt",
    // rust: "cached-collision.nbt",
    // rust: "movement-properties.nbt",
    // rust: "worldgen/blocks/block-properties.nbt",
    // rust: "worldgen/blocks/cached-support.nbt",
    // rust: "worldgen/blocks/cached-collision.nbt",
    // rust: ];
// use horizon_items::content_namespaces::MARKER;
    // rust: pub use horizon_items::content_namespaces::{namespaces, tag_namespaces};
// Block states a world can hold. Chunk sections widen their global palette
// past vanilla's 16 bits to fit the registry (crate::chunk::set_block_states);
// this caps it at 20 bits, about 29 times vanilla's 35,723 states. Mods past
// it are refused, not wrapped onto other blocks.
MAX_STATES :: 1 << 20

// Bundles of block tag files (tag id → the tag file's text).
TAG_BUNDLES :: ["block-tags.json", "worldgen/block_tags.json"]
// The worldgen loader's bundle of biome tags.
BIOME_TAGS :: "worldgen/biome_tags.json"
// Worldgen registries a content mod may add to, and the bundle the
// worldgen loader reads each from (id → the file's text): what structure
// mods hold. Biomes, noise and density functions change the terrain and
// are not read from mods.
    // rust: const WORLDGEN_BUNDLES: [(&str, &str); 6] = [
    // rust: ("structure", "worldgen/structures.json"),
    // rust: ("structure_set", "worldgen/structure_sets.json"),
    // rust: ("template_pool", "worldgen/template_pools.json"),
    // rust: ("processor_list", "worldgen/processor_lists.json"),
    // rust: ("configured_feature", "worldgen/features.json"),
    // rust: ("placed_feature", "worldgen/placed_features.json"),
    // rust: ];

// The registry of `command-registries.json` that each bundle's ids join,
// for the commands that suggest them (`/locate`, `/place`).
    // rust: const COMMAND_REGISTRIES: [(&str, &str); 6] = [
    // rust: ("worldgen/structures.json", "minecraft:worldgen/structure"),
    // rust: (
    // rust: "worldgen/structure_sets.json",
    // rust: "minecraft:worldgen/structure_set",
    // rust: ),
    // rust: (
    // rust: "worldgen/template_pools.json",
    // rust: "minecraft:worldgen/template_pool",
    // rust: ),
    // rust: (
    // rust: "worldgen/processor_lists.json",
    // rust: "minecraft:worldgen/processor_list",
    // rust: ),
    // rust: ("worldgen/features.json", "minecraft:worldgen/feature"),
    // rust: (
    // rust: "worldgen/placed_features.json",
    // rust: "minecraft:worldgen/placed_feature",
    // rust: ),
    // rust: ];

// A mod file that adds to a worldgen bundle: (bundle, id).
worldgen_entry :: proc(file: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, rest) = file.strip_prefix("data/")?.split_once("/worldgen/")?;
    // rust: let (kind, path) = rest.split_once('/')?;
    // rust: let (_, bundle) = WORLDGEN_BUNDLES.iter().find(|(k, _)| *k == kind)?;
    // rust: Some((bundle, format!("{ns}:{}", path.strip_suffix(".json")?)))
}

// The key of a mod's structure set, template pool or processor list file
// that adds its entries to other sets, pools or lists (vanilla's, another
// mod's) instead of being one of its own. Vanilla data never has it.
ADD_TO :: "horizon:add_to"
// An addition's place among the others (lower first; 1000 by default), as
// Lithostitched's modifiers' `priority`.
PRIORITY :: "horizon:priority"
// The bundles a mod may add to, and the list each entry goes into.
    // rust: const ADDABLE: [(&str, &str); 3] = [
    // rust: ("worldgen/structure_sets.json", "structures"),
    // rust: ("worldgen/template_pools.json", "elements"),
    // rust: ("worldgen/processor_lists.json", "processors"),
    // rust: ];

// A mod file's additions (`horizon:add_to`): its entries appended to the
// list of each set, pool or processor list it names, as Lithostitched's
// `add_structure_set_entries`, `add_template_pool_elements` and
// `add_processor_list_processors` do for NeoForge and Fabric packs.
Addition :: struct {
    targets: [dynamic]string,
    list: ^'static str,
    entries: [dynamic]J,
    priority: i64,
}
    // rust: impl Addition {
    // What a mod file of `bundle` adds, if it is an addition file.
read :: proc(bundle: string, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some((_, list)) = ADDABLE.iter().find(|(b, _)| *b == bundle) else {
    // rust: return Ok(None);
}
    // rust: if !text.contains(ADD_TO) {
    // rust: return Ok(None);
}
    // rust: let doc: J = serde_json::from_str(text)?;
    // rust: let Some(targets) = doc.get(ADD_TO) else {
    // rust: return Ok(None);
}
    // rust: let targets = match targets {
    // rust: J::Str(s) => vec![s.clone()],
    // rust: J::Arr(a) => a
    // rust: .iter()
    // rust: .map(|v| match v {
    // rust: J::Str(s) => Some(s.clone()),
    // rust: _ => None,
    // rust: })
    // rust: .collect::<Option<_>>()
    // rust: .ok_or(format!("{ADD_TO}: not a list of ids"))?,
    // rust: _ => return Err(format!("{ADD_TO}: not an id or a list of ids").into()),
}
    // rust: let Some(J::Arr(entries)) = doc.get(list) else {
    // rust: return Err(format!("{ADD_TO} without a {list} list").into());
}
    // rust: let priority = match doc.get(PRIORITY) {
    // rust: None => 1000,
    // rust: Some(J::Num(n)) => n.as_i64().ok_or(format!("{PRIORITY}: not an integer"))?,
    // rust: Some(_) => return Err(format!("{PRIORITY}: not an integer").into()),
}
    // rust: Ok(Some(Self {
    // rust: targets,
    // rust: list,
    // rust: entries: entries.clone(),
    // rust: priority,
    // rust: }))
}
    // Appends the entries to each target in the bundle `doc` (id → the
    // file's text). A target nobody defines is skipped, as a tag entry
    // naming an unknown id is.
apply :: proc(self: ^Self, doc: ^J) -> R {
    // Ported from Horizon
    return {}
}
    // rust: for target in &self.targets {
    // rust: let Some(J::Str(text)) = doc.get(target) else {
    // rust: continue;
}
    // rust: let mut v: J = serde_json::from_str(text).map_err(|e| format!("{target}: {e}"))?;
    // rust: let Some(J::Arr(list)) = v.get_mut(self.list) else {
    // rust: continue;
}
    // rust: list.extend(self.entries.iter().cloned());
    // rust: doc.set(target, J::Str(serde_json::to_string(&v)?));
}
    // rust: Ok(())
}
}

// The worldgen loader's bundles of biomes and of placed feature tags.
BIOMES :: "worldgen/biomes.json"
FEATURE_TAGS :: "worldgen/feature_tags.json"
PLACED_FEATURES :: "worldgen/placed_features.json"

// Rewrites the biome bundle with the mods' biome modifiers. `biome_tags`
// and `placed` are the bundles as the mods left them (`None`: the base's).
    // rust: fn place_in_biomes(
    // rust: base: &Path,
    // rust: overlay: &Overlay<'_>,
    // rust: modifiers: &[biomes::Modifier],
    // rust: biome_tags: Option<J>,
    // rust: placed: Option<J>,
    // rust: tags: &BTreeMap<String, TagMerge>,
    // rust: warnings: &mut Vec<String>,
    // rust: ) -> Result<()> {
    // rust: let bundle = |doc: Option<J>, name: &str| -> Result<BTreeMap<String, String>> {
    // rust: let doc = match doc {
    // rust: Some(doc) => doc,
    // rust: None if base.join(name).exists() => read_json(&base.join(name))?,
    // rust: None => return Ok(BTreeMap::new()),
}
    // rust: let J::Obj(entries) = doc else {
    // rust: return Err(format!("{name}: not an object").into());
}
    // rust: Ok(entries
    // rust: .into_iter()
    // rust: .filter_map(|(k, v)| match v {
    // rust: J::Str(text) => Some((k, text)),
    // rust: _ => None,
    // rust: })
    // rust: .collect())
}
    // rust: if !base.join(BIOMES).exists() {
    // rust: return Err(format!("biome modifiers need {BIOMES}").into());
}
    // rust: let mut doc = read_json(&base.join(BIOMES))?;
    // rust: let biome_ids: BTreeSet<String> = match &doc {
    // rust: J::Obj(o) => o.iter().map(|(k, _)| k.clone()).collect(),
    // rust: _ => return Err(format!("{BIOMES}: not an object").into()),
}
    // rust: let biome_tags = bundle(biome_tags, BIOME_TAGS)?;
    // rust: let placed: BTreeSet<String> = bundle(placed, PLACED_FEATURES)?.into_keys().collect();
    // rust: let feature_tags = bundle(None, FEATURE_TAGS)?;
    // rust: let entities_path = out_path(overlay, "entity-types.json");
    // rust: let entity_categories: BTreeMap<String, String> = match entities_path.exists() {
    // rust: true => match read_json(&entities_path)? {
    // rust: J::Obj(entries) => entries
    // rust: .into_iter()
    // rust: .map(|(k, v)| {
    // rust: let cat = v
    // rust: .get("category")
    // rust: .and_then(J::as_str)
    // rust: .unwrap_or("misc")
    // rust: .to_owned();
    // rust: (k, cat)
    // rust: })
    // rust: .collect(),
    // rust: _ => return Err("entity-types.json: not an object".into()),
    // rust: },
    // rust: false => BTreeMap::new(),
}
    // rust: let entity_ids: BTreeSet<String> = entity_categories.keys().cloned().collect();
    // rust: let mut entity_tags = BTreeMap::new();
    // rust: let vanilla_entity_tags = base.join("data/minecraft/tags/entity_type");
    // rust: if vanilla_entity_tags.is_dir() {
    // rust: for file in &crate::json_folder::read(&vanilla_entity_tags)?.files {
    // rust: let text = std::str::from_utf8(file.bytes()?)
    // rust: .map_err(|e| format!("entity_type/{}: {e}", file.name))?;
    // rust: entity_tags.insert(format!("minecraft:{}", file.name), text.to_owned());
}
}
    // rust: for file in tags.keys() {
    // rust: if let Some((ns, path)) = file
    // rust: .strip_prefix("data/")
    // rust: .and_then(|r| r.split_once("/tags/entity_type/"))
    // rust: .and_then(|(ns, p)| Some((ns, p.strip_suffix(".json")?)))
    // rust: {
    // rust: entity_tags.insert(
    // rust: format!("{ns}:{path}"),
    // rust: fs::read_to_string(out_path(overlay, file))?,
    // rust: );
}
}
    // rust: let changed = biomes::apply(
    // rust: &mut doc,
    // rust: modifiers,
    // rust: &biomes::Registry {
    // rust: what: "biome",
    // rust: ids: &biome_ids,
    // rust: tags: &biome_tags,
    // rust: },
    // rust: &biomes::Registry {
    // rust: what: "placed feature",
    // rust: ids: &placed,
    // rust: tags: &feature_tags,
    // rust: },
    // rust: &biomes::Registry {
    // rust: what: "entity type",
    // rust: ids: &entity_ids,
    // rust: tags: &entity_tags,
    // rust: },
    // rust: &entity_categories,
    // rust: warnings,
    // rust: )?;
    // rust: for (id, text) in changed {
    // rust: if let Some((ns, path)) = id.split_once(':') {
    // rust: let file = format!("data/{ns}/worldgen/biome/{path}.json");
    // rust: if out_path(overlay, &file).exists() {
    // rust: overlay.write(&file, text.as_bytes())?;
}
}
}
    // rust: overlay.write(BIOMES, &serde_json::to_vec(&doc)?)
}

    // rust: mod biomes;

// The overlay being written: `out` mirrors `base` through links, and a
// directory becomes real only when something inside it is written.
Overlay :: struct {
    base: ^'a Path,
    out: ^'a Path,
}
    // rust: impl Overlay<'_> {
    // rust: fn new<'a>(base: &'a Path, out: &'a Path) -> Result<Overlay<'a>> {
    // rust: if fs::symlink_metadata(out).is_ok() {
    // rust: fs::remove_dir_all(out)?;
}
    // rust: fs::create_dir_all(out)?;
    // rust: let overlay = Overlay { base, out };
    // rust: overlay.link_children(Path::new(""))?;
    // rust: Ok(overlay)
}
link_children :: proc(self: ^Self, rel: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(read) = fs::read_dir(self.base.join(rel)) else {
    // rust: return Ok(());
}
    // rust: for entry in read.flatten() {
    // rust: let rel = rel.join(entry.file_name());
            // The base's files in one file: it describes the base, not this root (and
            // would be copied where links are not made).
    // rust: if rel == Path::new(horizon_core::prepared_files::FILE_NAME) {
    // rust: continue;
}
    // rust: link(&self.base.join(&rel), &self.out.join(&rel))?;
}
    // rust: Ok(())
}
    // Makes `rel`'s directories real, each holding links to the base's.
dir :: proc(self: ^Self, rel: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut at = PathBuf::new();
    // rust: for part in rel.iter() {
    // rust: at.push(part);
    // rust: let path = self.out.join(&at);
    // rust: let meta = fs::symlink_metadata(&path);
    // rust: if meta
    // rust: .as_ref()
    // rust: .is_ok_and(|m| m.is_dir() && !m.file_type().is_symlink())
    // rust: {
    // rust: continue;
}
    // rust: if meta.is_ok() {
    // rust: fs::remove_file(&path)?;
}
    // rust: fs::create_dir(&path)?;
    // rust: self.link_children(&at)?;
}
    // rust: Ok(())
}
write :: proc(self: ^Self, rel: string, bytes: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let rel = Path::new(rel);
    // rust: if let Some(parent) = rel.parent() {
    // rust: self.dir(parent)?;
}
    // rust: let path = self.out.join(rel);
    // rust: if fs::symlink_metadata(&path).is_ok() {
    // rust: fs::remove_file(&path)?;
}
    // rust: fs::write(path, bytes)?;
    // rust: Ok(())
}
}
out_path :: proc(overlay: ^Overlay<'_>, rel: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: overlay.out.join(rel)
}
link :: proc(target: ^Path, at: ^Path) -> s {
    // Ported from Horizon
    return {}
}
    // rust: std::os::unix::fs::symlink(target, at)
}
link :: proc(target: ^Path, at: ^Path) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if target.is_dir() {
    // rust: fs::create_dir_all(at)?;
    // rust: for entry in fs::read_dir(target)?.flatten() {
    // rust: link(&entry.path(), &at.join(entry.file_name()))?;
}
    // rust: Ok(())
    // rust: } else {
    // rust: link_file(target, at, |target, at| fs::hard_link(target, at))
}
}
// A file of the overlay where symlinks need a privilege: a hard link to the base's file, which costs a name where
// a copy costs the file's bytes (the base is ~28,000 files, 0.6 GiB), or a copy when no link can be made (another
// volume, a filesystem without links, the NTFS limit on links to one file). A link shares the base file's data,
// which is safe because the overlay is only ever replaced name by name (`Overlay::write` removes the name before it
// writes), never written in place. A symlink is copied through, as before: linked, it would stay a symlink.
    // rust: fn link_file(
    // rust: target: &Path,
    // rust: at: &Path,
    // rust: hard_link: impl FnOnce(&Path, &Path) -> std::io::Result<()>,
    // rust: ) -> std::io::Result<()> {
    // rust: let symlink = fs::symlink_metadata(target).is_ok_and(|m| m.file_type().is_symlink());
    // rust: if !symlink && hard_link(target, at).is_ok() {
    // rust: return Ok(());
}
    // rust: fs::copy(target, at).map(|_| ())
}

// A tag file's JSON text with `more` appended to its values (no repeats).
merge_tag :: proc(text: Maybe(string), more: ^[J], what: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut doc = match text {
    // rust: Some(t) => serde_json::from_str(t).map_err(|e| format!("{what}: {e}"))?,
    // rust: None => J::Obj(vec![("values".into(), J::Arr(Vec::new()))]),
}
    // rust: let Some(J::Arr(values)) = doc.get_mut("values") else {
    // rust: return Err(format!("{what}: no values").into());
}
    // rust: for v in more {
    // rust: if !values.contains(v) {
    // rust: values.push(v.clone());
}
}
    // rust: Ok(serde_json::to_string_pretty(&doc)?)
}

// An atlas definition's JSON text with `more` sources after its own.
merge_atlas :: proc(text: Maybe(string), more: ^[J], what: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut doc = match text {
    // rust: Some(t) => serde_json::from_str(t).map_err(|e| format!("{what}: {e}"))?,
    // rust: None => J::Obj(vec![("sources".into(), J::Arr(Vec::new()))]),
}
    // rust: let Some(J::Arr(sources)) = doc.get_mut("sources") else {
    // rust: return Err(format!("{what}: no sources").into());
}
    // rust: sources.extend(more.iter().cloned());
    // rust: Ok(serde_json::to_string_pretty(&doc)?)
}

// The block and item ids and tags a content root has, for tag entries.
Known :: struct {
    blocks: std::collections::BTreeSet<string>,
    items: std::collections::BTreeSet<string>,
    // The worldgen loader's biomes and biome tags.
    biomes: std::collections::BTreeSet<string>,
    biome_tags: std::collections::BTreeSet<string>,
    // `data/<ns>/tags/<kind>/<path>.json` files the mods add.
    tag_files: std::collections::BTreeSet<string>,
}
    // rust: impl Known {
new :: proc(base: ^Path, plan: ^Plan, tags: ^BTreeMap<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut blocks: std::collections::BTreeSet<String> =
    // rust: plan.defaults.keys().cloned().collect();
    // rust: blocks.extend(plan.blocks.iter().map(|b| b.decl.id.clone()));
    // rust: let mut items = std::collections::BTreeSet::new();
    // rust: if let J::Obj(o) = read_json(&base.join("items.json"))? {
    // rust: items.extend(o.into_iter().map(|(k, _)| k));
}
    // rust: items.extend(plan.items.iter().map(|i| i.rename.to.clone()));
    // rust: let keys = |name: &str| -> Result<std::collections::BTreeSet<String>> {
    // rust: Ok(match base.join(name).exists() {
    // rust: true => match read_json(&base.join(name))? {
    // rust: J::Obj(o) => o.into_iter().map(|(k, _)| k).collect(),
    // rust: _ => Default::default(),
    // rust: },
    // rust: false => Default::default(),
    // rust: })
}
    // rust: Ok(Known {
    // rust: blocks,
    // rust: items,
    // rust: biomes: keys("worldgen/biomes.json")?,
    // rust: biome_tags: keys(BIOME_TAGS)?,
    // rust: tag_files: tags.keys().cloned().collect(),
    // rust: })
}
    // Whether tag `file` keeps entry `v`: a known id or an existing tag,
    // for block, item and biome tags (other registries are kept as they
    // are). The worldgen loader refuses a biome tag naming what it lacks
    // (another mod's biomes, a loader's tags), so those entries go.
keeps :: proc(self: ^Self, file: string, v: ^J) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = match v {
    // rust: J::Str(s) => s.as_str(),
    // rust: J::Obj(_) => match v.get("id") {
    // rust: Some(J::Str(s)) => s.as_str(),
    // rust: _ => return true,
    // rust: },
    // rust: _ => return true,
}
    // rust: let Some(rest) = file
    // rust: .strip_prefix("data/")
    // rust: .and_then(|r| r.split_once("/tags/"))
    // rust: .map(|(_, rest)| rest)
    // rust: else {
    // rust: return true;
}
    // rust: let kind = match rest.strip_prefix("worldgen/biome/") {
    // rust: Some(_) => "worldgen/biome",
    // rust: None => rest.split_once('/').map_or("", |(k, _)| k),
}
    // rust: let ids = match kind {
    // rust: "block" => &self.blocks,
    // rust: "item" => &self.items,
    // rust: "worldgen/biome" => &self.biomes,
    // rust: _ => return true,
}
    // rust: match id.strip_prefix('#') {
    // rust: Some(tag) => {
    // rust: let (tns, path) = tag.split_once(':').unwrap_or(("minecraft", tag));
    // rust: let rel = format!("data/{tns}/tags/{kind}/{path}.json");
    // rust: self.tag_files.contains(&rel)
    // rust: || match kind {
    // rust: "worldgen/biome" => self.biome_tags.contains(&format!("{tns}:{path}")),
    // rust: _ => tns == "minecraft",
}
}
    // rust: None => ids.contains(id),
}
}
}

// What the mods do to one tag file, in load order (a data pack's
// TagLoader): each adds its values, and one that replaces the tag first
// drops vanilla's entries and the mods' before it.
TagMerge :: struct {
    // A mod replaced the tag: vanilla's entries are left out.
    replaced: bool,
    // The mods whose values are in `values`.
    mods: [dynamic]string,
    values: [dynamic]J,
}

    // rust: impl TagMerge {
    // Adds one mod's tag file. A replace that drops entries (vanilla's in a
    // `shared` tag, one not in the mod's namespaces, or other mods') warns.
    // rust: fn add(
    // rust: &mut self,
    // rust: id: &str,
    // rust: file: &str,
    // rust: replace: bool,
    // rust: shared: bool,
    // rust: values: &[J],
    // rust: ) -> Option<String> {
    // rust: let mut warning = None;
    // rust: if replace {
    // rust: let mut dropped: Vec<String> = Vec::new();
    // rust: if shared && !self.replaced {
    // rust: dropped.push("vanilla's entries".into());
}
    // rust: if !self.mods.is_empty() {
    // rust: dropped.push(format!("those of {}", self.mods.join(", ")));
}
    // rust: if !dropped.is_empty() {
    // rust: warning = Some(format!(
    // rust: "mod {id} replaces {file}: {} are left out, as a data pack's replace \
    // rust: does; the mods after it in load order still add to it",
    // rust: dropped.join(" and ")
    // rust: ));
}
    // rust: self.replaced = true;
    // rust: self.mods.clear();
    // rust: self.values.clear();
}
    // rust: if !self.mods.iter().any(|m| m == id) {
    // rust: self.mods.push(id.to_owned());
}
    // rust: self.values.extend(values.iter().cloned());
    // rust: warning
}
}

// Threads rewriting the tables at once. Each holds a whole table as a tree
// (gameplay-facts.json's is over a gigabyte with ATM10's mods), so more
// would mostly add memory.
TABLE_THREADS :: 3

// Rewrites the base's per-state tables for the mods' states into the
// overlay. They are independent: [`TABLE_THREADS`] threads take them,
// the largest first.
tables :: proc(base: ^Path, plan: ^Plan, overlay: ^Overlay<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut jobs: Vec<(&str, u64)> = JSON_TABLES
    // rust: .iter()
    // rust: .chain(&NBT_TABLES)
    // rust: .filter_map(|name| Some((*name, fs::metadata(base.join(name)).ok()?.len())))
    // rust: .collect();
    // rust: jobs.sort_by_key(|(_, size)| std::cmp::Reverse(*size));
    // Their directories become real here, so the threads only write files.
    // rust: for (name, _) in &jobs {
    // rust: if let Some(parent) = Path::new(name).parent() {
    // rust: overlay.dir(parent)?;
}
}
    // rust: let table = |name: &str| -> Result<()> {
    // rust: let path = base.join(name);
    // rust: let bytes = if name == "entity-types.json" {
    // rust: plan.entity_types_json(&fs::read(&path)?)
    // rust: .map_err(|e| format!("{name}: {e}"))?
    // rust: } else if JSON_TABLES.contains(&name) {
    // rust: let mut doc = read_json(&path)?;
    // rust: plan.json(name, &mut doc)
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: serde_json::to_vec(&doc)?
    // rust: } else {
    // rust: let (mut named, _) = nbt::read_named(&fs::read(&path)?, Limits::tables())
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: plan.nbt(&mut named.tag);
    // rust: if name == "cached-collision.nbt" || name == "worldgen/blocks/cached-collision.nbt" {
    // rust: plan.collision_shapes(&mut named.tag)?;
}
    // rust: nbt::write_named(&named, Limits::tables()).map_err(|e| format!("{name}: {e}"))?
}
    // rust: overlay.write(name, &bytes)
}
    // rust: let next = std::sync::atomic::AtomicUsize::new(0);
    // rust: let threads = horizon_threads::worker_count();
    // rust: std::thread::scope(|scope| {
    // rust: let workers: Vec<_> = (0..threads.min(TABLE_THREADS))
    // rust: .map(|_| {
    // rust: scope.spawn(|| -> std::result::Result<(), String> {
    // rust: loop {
    // rust: let i = next.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: let Some((name, _)) = jobs.get(i) else {
    // rust: return Ok(());
}
    // rust: table(name).map_err(|e| e.to_string())?;
}
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: workers.into_iter().try_for_each(|w| {
    // rust: w.join()
    // rust: .unwrap_or_else(|_| Err("a table thread panicked".into()))
    // rust: })
    // rust: })?;
    // rust: Ok(())
}

// Builds the content root for `mods` over `base` in `out`. Returns the
// warnings for the log: the shared tags a mod replaced.
build :: proc(base: ^Path, mods: ^[ContentMod], out: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // Two mods owning one namespace would mix their files.
    // rust: for (i, a) in mods.iter().enumerate() {
    // rust: for b in &mods[..i] {
    // rust: let (b, a) = (
    // rust: (b.id.as_str(), b.content.namespaces.as_slice()),
    // rust: (a.id.as_str(), a.content.namespaces.as_slice()),
    // rust: );
    // rust: if let Some(e) = horizon_mods::content::clash(b, a) {
    // rust: return Err(e.into());
}
}
}
    // The overlay links to the base: a relative base would leave them dangling.
    // rust: let base = &std::path::absolute(base)?;
    // rust: let plan = Plan::new(base, mods)?;
    // rust: let overlay = Overlay::new(base, out)?;
    // rust: tables(base, &plan, &overlay)?;
    // Mod files, and every tag addition gathered per tag file.
    // rust: let mut tags: BTreeMap<String, TagMerge> = BTreeMap::new();
    // rust: let mut warnings = Vec::new();
    // rust: let mut worldgen: BTreeMap<&str, Vec<(String, String)>> = BTreeMap::new();
    // rust: let mut additions: BTreeMap<&str, Vec<Addition>> = BTreeMap::new();
    // rust: let mut modifiers = Vec::new();
    // rust: let mut atlases: BTreeMap<String, Vec<J>> = BTreeMap::new();
    // rust: for m in mods {
    // rust: let declarations = format!("data/{}/horizon/", m.id);
    // rust: let mut reader = m.content.reader()?;
    // rust: for file in &m.content.files {
    // rust: let bytes = reader.read(file)?;
    // rust: let is_tag = file.starts_with("data/") && file.contains("/tags/");
    // rust: if is_tag && file.ends_with(".json") {
    // rust: let doc: J = serde_json::from_slice(&bytes).map_err(|e| format!("{file}: {e}"))?;
    // rust: let Some(J::Arr(values)) = doc.get("values") else {
    // rust: return Err(format!("{}: {file}: no values", m.id).into());
}
    // rust: let replace = doc.get("replace") == Some(&J::Bool(true));
    // rust: let ns = file.split('/').nth(1).unwrap_or_default();
    // rust: let shared = !m.content.namespaces.iter().any(|n| n == ns);
    // rust: let merge = tags.entry(file.clone()).or_default();
    // rust: warnings.extend(merge.add(&m.id, file, replace, shared, values));
    // rust: } else if file.starts_with("assets/minecraft/atlases/") && file.ends_with(".json") {
    // rust: let doc: J = serde_json::from_slice(&bytes).map_err(|e| format!("{file}: {e}"))?;
    // rust: let Some(J::Arr(sources)) = doc.get("sources") else {
    // rust: return Err(format!("{}: {file}: no sources", m.id).into());
}
    // rust: atlases
    // rust: .entry(file.clone())
    // rust: .or_default()
    // rust: .extend(sources.iter().cloned());
    // rust: } else if !file.starts_with(&declarations) {
    // rust: overlay.write(file, &bytes)?;
    // rust: if biomes::is_modifier(file) {
    // rust: let text = String::from_utf8(bytes).map_err(|e| format!("{file}: {e}"))?;
    // rust: modifiers.extend(biomes::Modifier::read(&m.id, file, &text, &mut warnings)?);
    // rust: } else if let Some((bundle, id)) = worldgen_entry(file) {
    // rust: let text = String::from_utf8(bytes).map_err(|e| format!("{file}: {e}"))?;
    // rust: let entries = worldgen.entry(bundle).or_default();
    // rust: match Addition::read(bundle, &text).map_err(|e| format!("{file}: {e}"))? {
    // rust: Some(addition) => additions.entry(bundle).or_default().push(addition),
    // rust: None => entries.push((id, text)),
}
    // rust: } else if let Some(template) = file
    // rust: .strip_prefix("data/")
    // rust: .and_then(|r| r.split_once("/structure/"))
    // rust: .filter(|(_, path)| path.ends_with(".nbt"))
    // rust: {
                    // The worldgen loader's templates: worldgen/structure/<ns>/<path>.nbt.
    // rust: let (ns, path) = template;
    // rust: overlay.write(&format!("worldgen/structure/{ns}/{path}"), &bytes)?;
}
}
}
}
    // A reload appends every pack's sources for an atlas to the ones below it.
    // rust: for (file, sources) in &atlases {
    // rust: let vanilla = fs::read_to_string(base.join(file)).ok();
    // rust: overlay.write(
    // rust: file,
    // rust: merge_atlas(vanilla.as_deref(), sources, file)?.as_bytes(),
    // rust: )?;
}
    // A tag naming an id nobody registers fails as a whole in vanilla, and
    // carried-over mods name blocks left out or other mods' ids: such
    // entries are dropped instead, so the rest of the tag holds.
    // rust: let known = Known::new(base, &plan, &tags)?;
    // rust: for (file, merge) in &mut tags {
    // rust: merge.values.retain(|v| known.keeps(file, v));
}
    // rust: let mut bundles: Vec<(&str, J)> = Vec::new();
    // rust: for name in TAG_BUNDLES {
    // rust: if base.join(name).exists() {
    // rust: bundles.push((name, read_json(&base.join(name))?));
}
}
    // rust: for (file, merge) in &tags {
    // rust: let vanilla = fs::read_to_string(base.join(file))
    // rust: .ok()
    // rust: .filter(|_| !merge.replaced);
    // rust: overlay.write(
    // rust: file,
    // rust: merge_tag(vanilla.as_deref(), &merge.values, file)?.as_bytes(),
    // rust: )?;
        // data/<ns>/tags/block/<path>.json is the block tag <ns>:<path>.
    // rust: let Some((ns, path)) = file
    // rust: .strip_prefix("data/")
    // rust: .and_then(|r| r.split_once("/tags/block/"))
    // rust: .and_then(|(ns, p)| Some((ns, p.strip_suffix(".json")?)))
    // rust: else {
    // rust: continue;
}
    // rust: let id = format!("{ns}:{path}");
    // rust: for (name, doc) in &mut bundles {
    // rust: let text = match doc.get(&id) {
    // rust: Some(J::Str(t)) if !merge.replaced => Some(t.clone()),
    // rust: _ => None,
}
    // rust: let merged = merge_tag(text.as_deref(), &merge.values, name)?;
    // rust: doc.set(&id, J::Str(merged));
}
}
    // rust: for (name, doc) in &bundles {
    // rust: overlay.write(name, &serde_json::to_vec(doc)?)?;
}
    // Biome tags, merged into the worldgen loader's bundle as block tags are.
    // rust: let biome_tags: Vec<(String, &TagMerge)> = tags
    // rust: .iter()
    // rust: .filter_map(|(file, merge)| {
    // rust: let (ns, path) = file
    // rust: .strip_prefix("data/")?
    // rust: .split_once("/tags/worldgen/biome/")?;
    // rust: Some((format!("{ns}:{}", path.strip_suffix(".json")?), merge))
    // rust: })
    // rust: .collect();
    // rust: let mut biome_tag_doc = None;
    // rust: if !biome_tags.is_empty() && base.join(BIOME_TAGS).exists() {
    // rust: let mut doc = read_json(&base.join(BIOME_TAGS))?;
    // rust: for (id, merge) in biome_tags {
    // rust: let text = match doc.get(&id) {
    // rust: Some(J::Str(t)) if !merge.replaced => Some(t.clone()),
    // rust: _ => None,
}
    // rust: let merged = merge_tag(text.as_deref(), &merge.values, BIOME_TAGS)?;
    // rust: doc.set(&id, J::Str(merged));
}
    // rust: overlay.write(BIOME_TAGS, &serde_json::to_vec(&doc)?)?;
    // rust: biome_tag_doc = Some(doc);
}
    // Structures and the pools, sets, processors and features they use, then
    // what mods add to sets, pools and lists, by priority, then in mod and
    // file order.
    // rust: for list in additions.values_mut() {
    // rust: list.sort_by_key(|a| a.priority);
}
    // rust: let mut placed_doc = None;
    // rust: for (bundle, entries) in &worldgen {
    // rust: if !base.join(bundle).exists() {
    // rust: continue;
}
    // rust: let mut doc = read_json(&base.join(bundle))?;
    // rust: for (id, text) in entries {
    // rust: doc.set(id, J::Str(text.clone()));
}
    // rust: for addition in additions.get(bundle).into_iter().flatten() {
    // rust: addition
    // rust: .apply(&mut doc)
    // rust: .map_err(|e| format!("{bundle}: {e}"))?;
}
    // rust: overlay.write(bundle, &serde_json::to_vec(&doc)?)?;
    // rust: if *bundle == PLACED_FEATURES {
    // rust: placed_doc = Some(doc);
}
}
    // rust: if !modifiers.is_empty() {
    // rust: place_in_biomes(
    // rust: base,
    // rust: &overlay,
    // rust: &modifiers,
    // rust: biome_tag_doc,
    // rust: placed_doc,
    // rust: &tags,
    // rust: &mut warnings,
    // rust: )?;
}
    // The commands suggest ids from `command-registries.json`: add the
    // structures, pools, sets and features the mods bring.
    // rust: let registries = out_path(&overlay, "command-registries.json");
    // rust: if let Ok(mut doc) = read_json(&registries) {
        // Registry names hold `/`, so each key is looked up by itself.
    // rust: let mut add = |keys: &[&str], new: &[J]| {
    // rust: let found = keys.iter().try_fold(&mut doc, |j, k| j.get_mut(k));
    // rust: if let Some(J::Arr(ids)) = found {
    // rust: for id in new {
    // rust: if !ids.contains(id) {
    // rust: ids.push(id.clone());
}
}
}
}
    // rust: for (bundle, registry) in COMMAND_REGISTRIES {
    // rust: let new: Vec<J> = worldgen
    // rust: .get(bundle)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(id, _)| J::Str(id.clone()))
    // rust: .collect();
    // rust: add(&["by_registry", registry, "ids"], &new);
}
    // rust: overlay.write("command-registries.json", &serde_json::to_vec(&doc)?)?;
}
    // A block without its own blockstate looks like its template, so every
    // state still has a model.
    // rust: for m in mods {
    // rust: for block in &m.content.blocks {
    // rust: let (ns, path) = block.id.split_once(':').unwrap_or((&m.id, &block.id));
    // rust: let own = format!("assets/{ns}/blockstates/{path}.json");
    // rust: if m.content.files.contains(&own) {
    // rust: continue;
}
    // rust: let template = block.template.trim_start_matches("minecraft:");
    // rust: let vanilla = base.join(format!("assets/minecraft/blockstates/{template}.json"));
    // rust: overlay.write(&own, &fs::read(&vanilla)?)?;
}
}
    // rust: let mut namespaces: Vec<&str> = mods
    // rust: .iter()
    // rust: .flat_map(|m| m.content.namespaces.iter().map(String::as_str))
    // rust: .collect();
    // rust: namespaces.sort();
    // rust: overlay.write(MARKER, &serde_json::to_vec(&namespaces)?)?;
    // rust: let mod_ids: Vec<&str> = mods.iter().map(|m| m.id.as_str()).collect();
    // rust: overlay.write(
    // rust: horizon_items::content_namespaces::MOD_IDS_MARKER,
    // rust: &serde_json::to_vec(&mod_ids)?,
    // rust: )?;
    // rust: let remainders: BTreeMap<&str, &str> = plan
    // rust: .items
    // rust: .iter()
    // rust: .filter_map(|i| Some((i.rename.to.as_str(), i.crafting_remainder.as_deref()?)))
    // rust: .collect();
    // rust: if !remainders.is_empty() {
    // rust: overlay.write(
    // rust: horizon_items::items::MOD_CRAFT_REMAINDERS,
    // rust: &serde_json::to_vec(&remainders)?,
    // rust: )?;
}
    // clients must agree on the block states and the items', mob effects',
    // entity types' and menu types' network ids.
    // rust: if !plan.blocks.is_empty()
    // rust: || !plan.items.is_empty()
    // rust: || !plan.effects.is_empty()
    // rust: || !plan.entity_types.is_empty()
    // rust: || !plan.menu_types.is_empty()
    // rust: {
    // rust: overlay.write(crate::content_identity::MARKER, b"1")?;
}
    // rust: overlay.write(WARNINGS, warnings.join("\n").as_bytes())?;
    // rust: Ok(warnings)
}

// The root to load: `base` itself with no content, else the mods' overlay
// over it, built in `cache/mod-content/<stamp>`: one folder per mod set, so
// a running game keeps reading the root it was given while a switch builds
// another (docs/design/mod-hotload.md). Roots of other sets unused for a day
// are removed.
//
// The root is built once and kept: later starts with the same build, base
// and mod files reuse it. With ATM10's carried mods a build takes about
// 25 s and peaks above 3 GB, more than everything the game keeps.
resource_root :: proc(base: ^Path, mods: ^[ContentMod], cache: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if mods
    // rust: .iter()
    // rust: .all(|m| m.content.is_empty() && m.content.blocks.is_empty() && m.content.items.is_empty())
    // rust: {
    // rust: return Ok(base.to_owned());
}
    // rust: let stamp = stamp(base, mods)?;
    // rust: let roots = cache.join("mod-content");
    // rust: let out = roots.join(&stamp[..ROOT_NAME]);
    // rust: if fs::read(out.join(STAMP)).is_ok_and(|s| s == stamp.as_bytes()) {
        // A reused root warns as the build did.
    // rust: let warnings = fs::read_to_string(out.join(WARNINGS)).unwrap_or_default();
    // rust: warnings.lines().for_each(|w| log::warn!("Horizon: {w}"));
        // Used again: kept another day.
    // rust: let _ = fs::write(out.join(STAMP), &stamp);
    // rust: return Ok(out);
}
    // rust: for warning in build(base, mods, &out)? {
    // rust: log::warn!("Horizon: {warning}");
}
    // rust: fs::write(out.join(STAMP), stamp)?;
    // rust: prune_roots(&roots, &out, KEEP_ROOTS);
    // rust: Ok(out)
}

// The length of a root's folder name: the start of its stamp.
ROOT_NAME :: 16
// How long a root no start or switch used is kept.
KEEP_ROOTS :: std::time::Duration::from_secs(24 * 3600)

// Removes from `roots` the roots other than `current` whose stamp is older
// than `keep`, and what an older game left there (one root built straight in
// the folder). A game still running on a removed root was started more than
// `keep` ago and reads its tables already; only the folders' own names are
// touched.
prune_roots :: proc(roots: ^Path, current: ^Path, keep: std::time::Duration) {
}
    // rust: let Ok(entries) = fs::read_dir(roots) else {
    // rust: return;
}
    // rust: let old_layout = roots.join(STAMP).exists();
    // rust: for entry in entries.flatten() {
    // rust: let path = entry.path();
    // rust: if path == current {
    // rust: continue;
}
    // rust: let name = entry.file_name();
    // rust: let is_root = name.len() == ROOT_NAME
    // rust: && name
    // rust: .to_string_lossy()
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_hexdigit())
    // rust: && path.is_dir();
    // rust: let stale = match is_root {
    // rust: true => fs::metadata(path.join(STAMP))
    // rust: .and_then(|m| m.modified())
    // rust: .ok()
    // rust: .and_then(|t| t.elapsed().ok())
    // rust: .is_none_or(|age| age > keep),
            // The old single root's files and folders.
    // rust: false => old_layout,
}
    // rust: if !stale {
    // rust: continue;
}
    // rust: let removed = match path.is_dir() {
    // rust: true => fs::remove_dir_all(&path),
    // rust: false => fs::remove_file(&path),
}
    // rust: if let Err(e) = removed {
    // rust: log::warn!(
    // rust: "Horizon: an old mod content root stays: {}: {e}",
    // rust: path.display()
    // rust: );
}
}
}

// Whether turning a content mod on or off can apply in a running game
// (docs/design/mod-hotload.md): its assets and data can, through the
// resource reload and the server's data reload. What a world numbers or
// generates from cannot yet: then the translation key of why.
live_switch :: proc(content: ^Content) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if !content.blocks.is_empty()
    // rust: || !content.items.is_empty()
    // rust: || !content.effects.is_empty()
    // rust: || !content.entity_types.is_empty()
    // rust: || !content.menu_types.is_empty()
    // rust: || !content.creative_tabs.is_empty()
    // rust: {
    // rust: return Err("horizon.mods.switch.registries");
}
    // rust: let worldgen = |file: &&String| {
    // rust: let mut parts = file.split('/');
    // rust: parts.next() == Some("data")
    // rust: && parts.nth(1).is_some_and(|folder| {
    // rust: matches!(folder, "worldgen" | "dimension" | "dimension_type")
    // rust: || folder == "tags" && file.contains("/tags/worldgen/")
    // rust: || matches!(folder, "neoforge" | "forge") && file.contains("/biome_modifier/")
    // rust: })
}
    // rust: if content.files.iter().any(|f| worldgen(&f)) {
    // rust: return Err("horizon.mods.switch.worldgen");
}
    // rust: Ok(())
}

// In a root built by [`build`]: its warnings, one per line.
WARNINGS :: "horizon-mod-content-warnings.txt"

// In a root built by [`resource_root`]: what it was built from.
STAMP :: "horizon-mod-content.stamp"

// What a content root is built from: this build of the game, the base's
// manifest and the tables [`build`] rewrites, and every file of every mod
// in order. Files count by size and modification time, as build tools do.
stamp :: proc(base: ^Path, mods: ^[ContentMod]) -> R {
    // Ported from Horizon
    return {}
}
//     use sha2::{Digest, Sha256};
    // rust: let meta = |path: &Path| -> Result<String> {
    // rust: let m = fs::metadata(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let modified = m
    // rust: .modified()?
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap_or_default();
    // rust: Ok(format!(
    // rust: "{} {} {}",
    // rust: path.display(),
    // rust: m.len(),
    // rust: modified.as_nanos()
    // rust: ))
}
    // rust: let mut parts = vec!["horizon mod content 1".to_owned()];
    // rust: parts.push(meta(&std::env::current_exe()?)?);
    // rust: let base = std::path::absolute(base)?;
    // rust: parts.push(
    // rust: String::from_utf8_lossy(&fs::read(base.join("horizon-resources.json"))?).into_owned(),
    // rust: );
    // rust: for name in JSON_TABLES.iter().chain(&NBT_TABLES).chain(&TAG_BUNDLES) {
    // rust: if base.join(name).exists() {
    // rust: parts.push(meta(&base.join(name))?);
}
}
    // rust: for m in mods {
    // rust: parts.push(m.id.clone());
        // What it declares, so blocks and items from code count too.
    // rust: parts.push(format!("{:?} {:?}", m.content.blocks, m.content.items));
    // rust: let source = m.content.source();
    // rust: if m.content.files.is_empty() {
            // Declared in code only: nothing to read.
    // rust: } else if source.is_dir() {
    // rust: for file in &m.content.files {
    // rust: parts.push(meta(&source.join(file))?);
}
    // rust: } else {
    // rust: parts.push(meta(source)?);
}
}
    // rust: let mut hasher = Sha256::new();
    // rust: for part in &parts {
    // rust: hasher.update((part.len() as u64).to_le_bytes());
    // rust: hasher.update(part.as_bytes());
}
    // rust: Ok(format!("{:x}", hasher.finalize()))
}

    // rust: mod tests;
