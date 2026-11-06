//! Transpiled from Horizon Rust crate
package horizon_items_decode

import "core:fmt"
import "core:mem"
import "core:math"

// Typed projection of gameplay facts. Scalar conversions deliberately retain Value's
// permissive defaults; maps retain its last-key-wins behavior. Repeated geometry stays
// borrowed until it is interned, rather than allocating a JSON tree for every state.
// use serde::{
    // rust: Deserialize, Deserializer,
    // rust: de::{MapAccess, SeqAccess, Visitor},
}
// use serde_json::{Value, value::RawValue};
// use std::{
    // rust: collections::{HashMap, hash_map::Entry as MapEntry},
    // rust: fmt,
    // rust: hash::{Hash, Hasher},
    // rust: marker::PhantomData,
    // rust: sync::Arc,
}

// RawValue skips numeric range and depth checks. A non-allocating validation pass
// keeps the original Value loader's JSON errors, even in overwritten/unused fields.
    // rust: pub(super) struct Validate;
    // rust: impl<'de> Container<'de> for Validate {}
    // rust: impl<'de> Deserialize<'de> for Validate {
    // rust: fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
    // rust: container(d)
}
}

    // rust: trait Container<'de>: Default {
    // rust: fn map<A: MapAccess<'de>>(mut map: A) -> Result<Self, A::Error> {
    // rust: while map.next_key::<serde::de::IgnoredAny>()?.is_some() {
    // rust: map.next_value::<Validate>()?;
}
    // rust: Ok(Self::default())
}
    // rust: fn seq<A: SeqAccess<'de>>(mut seq: A) -> Result<Self, A::Error> {
    // rust: while seq.next_element::<Validate>()?.is_some() {}
    // rust: Ok(Self::default())
}
}
ContainerVisitor :: struct {
    // rust: impl<'de, T: Container<'de>> Visitor<'de> for ContainerVisitor<T> {
    // rust: type Value = T;
expecting :: proc(self: ^Self, f: ^fmt::Formatter) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str("JSON facts")
}
    // rust: fn visit_map<A: MapAccess<'de>>(self, map: A) -> Result<T, A::Error> {
    // rust: T::map(map)
}
    // rust: fn visit_seq<A: SeqAccess<'de>>(self, seq: A) -> Result<T, A::Error> {
    // rust: T::seq(seq)
}
    // rust: fn visit_unit<E: serde::de::Error>(self) -> Result<T, E> {
    // rust: Ok(T::default())
}
    // rust: fn visit_bool<E: serde::de::Error>(self, _: bool) -> Result<T, E> {
    // rust: Ok(T::default())
}
    // rust: fn visit_i64<E: serde::de::Error>(self, _: i64) -> Result<T, E> {
    // rust: Ok(T::default())
}
    // rust: fn visit_u64<E: serde::de::Error>(self, _: u64) -> Result<T, E> {
    // rust: Ok(T::default())
}
    // rust: fn visit_f64<E: serde::de::Error>(self, _: f64) -> Result<T, E> {
    // rust: Ok(T::default())
}
    // rust: fn visit_str<E: serde::de::Error>(self, _: &str) -> Result<T, E> {
    // rust: Ok(T::default())
}
}
    // rust: fn container<'de, D: Deserializer<'de>, T: Container<'de>>(d: D) -> Result<T, D::Error> {
    // rust: d.deserialize_any(ContainerVisitor(PhantomData))
}
    // rust: macro_rules! read_field {
    // rust: ($map:ident, typed) => {
    // rust: $map.next_value()?
}
    // rust: ($map:ident, value($convert:expr)) => {
    // rust: ($convert)($map.next_value::<Value>()?)
}
}
    // rust: macro_rules! object {
    // rust: ($name:ident<$life:lifetime> { $($field:ident: $ty:ty = $default:expr => $kind:ident $(($convert:expr))?),* $(,)? }) => {
    // rust: pub(super) struct $name<$life> {
    // rust: $(pub $field: $ty,)*
    // rust: marker: PhantomData<&$life ()>,
}
    // rust: impl Default for $name<'_> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
}
    // rust: impl<$life> Container<$life> for $name<$life> {
    // rust: fn map<A: MapAccess<$life>>(mut map: A) -> Result<Self, A::Error> {
Field :: enum {
    let mut result = Self::default();,
    while let Some(field) = map.next_key::<Field>()? {,
    match field {,
    // rust: $(Field::$field => result.$field = read_field!(map, $kind $(($convert))?),)*
    Field::Unknown => { map.next_value::<Validate>()?; },
}
}
    // rust: Ok(result)
}
}
    // rust: impl<$life> Deserialize<$life> for $name<$life> {
    // rust: fn deserialize<D: Deserializer<$life>>(d: D) -> Result<Self, D::Error> { container(d) }
}
}
}
number :: proc(v: Value) -> f {
    // Ported from Horizon
    return {}
}
    // rust: v.as_f64().unwrap_or(0.0)
}
flag :: proc(v: Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: v.as_bool().unwrap_or(false)
}
unsigned :: proc(v: Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: v.as_u64()
}
text :: proc(v: Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Value::String(s) = v {
    // rust: Some(s)
    // rust: } else {
    // rust: None
}
}

    // rust: pub(super) struct Entries<'a>(pub Option<Vec<Entry<'a>>>);
    // rust: impl<'de> Container<'de> for Entries<'de> {
    // rust: fn seq<A: SeqAccess<'de>>(mut seq: A) -> Result<Self, A::Error> {
    // rust: let mut entries = Vec::new();
    // rust: while let Some(entry) = seq.next_element()? {
    // rust: entries.push(entry);
}
    // rust: Ok(Self(Some(entries)))
}
}
    // rust: impl<'de> Deserialize<'de> for Entries<'de> {
    // rust: fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
    // rust: container(d)
}
}
    // rust: object!(Gameplay<'a> { states: Entries<'a> = Entries::default() => typed });
    // rust: object!(SoundId<'a> { id: Option<String> = None => value(text) });
    // rust: object!(Sound<'a> {
    // rust: volume: f64 = 1.0 => value(|v: Value| v.as_f64().unwrap_or(1.0)),
    // rust: pitch: f64 = 1.0 => value(|v: Value| v.as_f64().unwrap_or(1.0)),
    // rust: r#break: SoundId<'a> = SoundId::default() => typed,
    // rust: step: SoundId<'a> = SoundId::default() => typed,
    // rust: place: SoundId<'a> = SoundId::default() => typed,
    // rust: hit: SoundId<'a> = SoundId::default() => typed,
    // rust: fall: SoundId<'a> = SoundId::default() => typed,
    // rust: });
    // rust: object!(Entry<'a> {
    // rust: id: Option<u64> = None => value(unsigned),
    // rust: emission: Value = Value::Null => typed,
    // rust: dampening: Value = Value::Null => typed,
    // rust: skylight_down: bool = false => value(flag),
    // rust: shape_occlusion: bool = false => value(flag),
    // rust: can_occlude: bool = false => value(flag),
    // rust: solid_render: bool = false => value(flag),
    // rust: hardness: Value = Value::Null => typed,
    // rust: requires_tool: bool = false => value(flag),
    // rust: replaceable: bool = false => value(flag),
    // rust: random_ticks: bool = false => value(flag),
    // rust: block_entity: bool = false => value(flag),
    // rust: liquid: bool = false => value(flag),
    // rust: ignited_by_lava: bool = false => value(flag),
    // rust: push: Option<String> = None => value(text),
    // rust: render_shape: Option<String> = None => value(text),
    // rust: full_collision: bool = false => value(flag),
    // rust: friction: f64 = 0.0 => value(number),
    // rust: explosion_resistance: f64 = 0.0 => value(number),
    // rust: item: Option<String> = None => value(text),
    // rust: sound: Sound<'a> = Sound::default() => typed,
    // rust: offset: bool = false => value(flag),
    // rust: outline_offset: Option<bool> = None => value(|v: Value| v.as_bool()),
    // rust: map_color: Option<u64> = None => value(unsigned),
    // rust: outline: Option<&'a RawValue> = None => typed,
    // rust: outline_edges: Option<&'a RawValue> = None => typed,
    // rust: });

// Match Value::to_string identity without serializing: integer/float spelling is
// distinct, as is the sign of floating zero. Object keys are already sorted by Value.
ShapeKey :: struct {
same :: proc(a: ^Value, b: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (a, b) {
    // rust: (Value::Number(a), Value::Number(b)) => {
    // rust: a == b && a.as_f64().map(f64::to_bits) == b.as_f64().map(f64::to_bits)
}
    // rust: (Value::Array(a), Value::Array(b)) => {
    // rust: a.len() == b.len() && a.iter().zip(b).all(|(a, b)| same(a, b))
}
    // rust: (Value::Object(a), Value::Object(b)) => {
    // rust: a.len() == b.len()
    // rust: && a.iter()
    // rust: .zip(b)
    // rust: .all(|((ak, av), (bk, bv))| ak == bk && same(av, bv))
}
    // rust: _ => a == b,
}
}
    // rust: impl PartialEq for ShapeKey {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: same(&self.0, &other.0)
}
}
    // rust: impl Eq for ShapeKey {}
    // rust: fn shape_hash<H: Hasher>(v: &Value, h: &mut H) {
    // rust: std::mem::discriminant(v).hash(h);
    // rust: match v {
    // rust: Value::Null => {}
    // rust: Value::Bool(b) => b.hash(h),
    // rust: Value::String(s) => s.hash(h),
    // rust: Value::Number(n) => {
    // rust: n.is_f64().hash(h);
    // rust: n.hash(h);
    // rust: n.as_f64().map(f64::to_bits).hash(h);
}
    // rust: Value::Array(a) => {
    // rust: a.len().hash(h);
    // rust: for v in a {
    // rust: shape_hash(v, h);
}
}
    // rust: Value::Object(o) => {
    // rust: o.len().hash(h);
    // rust: for (k, v) in o {
    // rust: k.hash(h);
    // rust: shape_hash(v, h);
}
}
}
}
    // rust: impl Hash for ShapeKey {
    // rust: fn hash<H: Hasher>(&self, h: &mut H) {
    // rust: shape_hash(&self.0, h);
}
}
    // rust: pub(super) struct Shapes<'a> {
    // rust: raw: HashMap<&'a str, usize>,
    // rust: canonical: HashMap<ShapeKey, usize>,
    // rust: values: Vec<Arc<[[f64; 6]]>>,
}
    // rust: impl<'a> Shapes<'a> {
    // rust: pub fn intern(
    // rust: &mut self,
    // rust: raw: Option<&'a RawValue>,
    // rust: fallback: impl FnOnce() -> Vec<[f64; 6]>,
    // rust: ) -> crate::Result<Arc<[[f64; 6]]>> {
    // rust: let Some(raw) = raw else {
    // rust: return Ok(fallback().into());
}
    // rust: if let Some(&id) = self.raw.get(raw.get()) {
    // rust: return Ok(self.values[id].clone());
}
    // rust: let value: Value = serde_json::from_str(raw.get())?;
    // rust: if !value.is_array() {
    // rust: return Ok(fallback().into());
}
    // rust: let id = match self.canonical.entry(ShapeKey(value)) {
    // rust: MapEntry::Occupied(entry) => *entry.get(),
    // rust: MapEntry::Vacant(entry) => {
    // rust: let shape = entry
    // rust: .key()
    // rust: .0
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .filter_map(|b| {
    // rust: let b = b.as_array()?;
    // rust: Some(std::array::from_fn(|i| {
    // rust: b.get(i).and_then(Value::as_f64).unwrap_or(0.0)
    // rust: }))
    // rust: })
    // rust: .collect::<Arc<[[f64; 6]]>>();
    // rust: let id = self.values.len();
    // rust: self.values.push(shape);
    // rust: entry.insert(id);
    // rust: id
}
}
    // rust: self.raw.insert(raw.get(), id);
    // rust: Ok(self.values[id].clone())
}
}

    // rust: mod tests;
