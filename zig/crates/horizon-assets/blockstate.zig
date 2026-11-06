//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_blockstate
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Pinned blockstate resource definitions, before registry binding and baking.
    // rust: pub mod bind;
    // rust: pub mod choice;
// use crate::json::*;
// use serde::{
    // rust: Deserializer,
    // rust: de::{MapAccess, Visitor},
}
// use serde_json::value::RawValue;
// use std::{collections::BTreeMap, fmt};

pub const Variant = struct {
    model: []const u8,
    /// X, Y, Z rotations in quarter turns.
    rotations: [u8,
    uv_lock: bool,
};
pub const VariantSet = enum {
    Single(Variant),
    Weighted(Vec<(Variant, i32)>),
};
pub const Term = struct {
    value: []const u8,
    negated: bool,
};
pub const Condition = enum {
    Or(Vec<Condition>),
    And(Vec<Condition>),
    Properties(BTreeMap<String, Vec<Term>>),
};
pub const Selector = struct {
    condition: ?Condition,
    variant: VariantSet,
};
pub const BlockStateDefinition = struct {
    /// Preserve resource order: overlapping variant selectors have order-sensitive
    /// native recovery behavior when bound to a registry.
    variants: Option<Vec<([]const u8,
    multipart: ?std.ArrayList(Selector),
};
    // rust: fn optional<'a>(fields: &Object<'a>, name: &str) -> Option<&'a RawValue> {
    // rust: fields.get(name).copied().filter(|v| v.get() != "null")
}
pub fn ordered_object(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
pub const Ordered = struct {};
    // rust: impl<'de> Visitor<'de> for Ordered {
    // rust: type Value = Vec<(String, &'de RawValue)>;
pub fn expecting(self: *Self, formatter: *mut fmt::Formatter) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: formatter.write_str("an object")
}
    // rust: fn visit_map<M: MapAccess<'de>>(
    // rust: self,
    // rust: mut map: M,
    // rust: ) -> std::result::Result<Self::Value, M::Error> {
    // rust: let mut values: Self::Value = Vec::new();
    // rust: let mut indices = BTreeMap::new();
    // rust: while let Some((name, value)) = map.next_entry::<String, &'de RawValue>()? {
    // rust: if let Some(&index) = indices.get(&name) {
    // rust: values[index] = (name, value);
    // rust: } else {
    // rust: indices.insert(name.clone(), values.len());
    // rust: values.push((name, value));
}
}
    // rust: Ok(values)
}
}
    // rust: Ok(serde_json::Deserializer::from_str(raw.get()).deserialize_map(Ordered)?)
}
    // rust: impl BlockStateDefinition {
pub fn from_json(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw: &RawValue = serde_json::from_str(text.strip_prefix('\u{feff}').unwrap_or(text))?;
    // rust: validate_number_tokens(raw)?;
    // rust: let fields = object(raw)?;
    // rust: let variants = optional(&fields, "variants")
    // rust: .map(|v| {
    // rust: let values = ordered_object(v)?;
    // rust: if values.is_empty() {
    // rust: return Err(error("empty variant map"));
}
    // rust: values
    // rust: .into_iter()
    // rust: .map(|(key, value)| Ok((key, VariantSet::decode(value)?)))
    // rust: .collect::<Result<Vec<_>>>()
    // rust: })
    // rust: .transpose()?;
    // rust: let multipart = optional(&fields, "multipart")
    // rust: .map(|v| {
    // rust: let values = array(v)?;
    // rust: if values.is_empty() {
    // rust: return Err(error("empty multipart list"));
}
    // rust: values
    // rust: .into_iter()
    // rust: .map(|v| {
    // rust: let fields = object(v)?;
    // rust: Ok(Selector {
    // rust: condition: optional(&fields, "when")
    // rust: .map(Condition::decode)
    // rust: .transpose()?,
    // rust: variant: VariantSet::decode(required(&fields, "apply")?)?,
    // rust: })
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()
    // rust: })
    // rust: .transpose()?;
    // rust: if variants.is_none() && multipart.is_none() {
    // rust: return Err(error("no variants or multipart"));
}
    // rust: Ok(Self {
    // rust: variants,
    // rust: multipart,
    // rust: })
}
}
    // rust: impl Variant {
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fields = object(raw)?;
    // rust: let mut rotations = [0; 3];
    // rust: for (target, name) in rotations.iter_mut().zip(["x", "y", "z"]) {
    // rust: let angle = optional(&fields, name)
    // rust: .map(integer)
    // rust: .transpose()?
    // rust: .unwrap_or(0)
    // rust: .rem_euclid(360);
    // rust: if angle % 90 != 0 {
    // rust: return Err(error("model rotation must be a multiple of 90"));
}
    // rust: *target = (angle / 90) as u8;
}
    // rust: Ok(Self {
    // rust: model: identifier(&string(required(&fields, "model")?)?)?,
    // rust: rotations,
    // rust: uv_lock: optional(&fields, "uvlock")
    // rust: .map(|v| serde_json::from_str(v.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false),
    // rust: })
}
}
    // rust: impl VariantSet {
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !raw.get().starts_with('[') {
    // rust: return Ok(Self::Single(Variant::decode(raw)?));
}
    // rust: let values = array(raw)?;
    // rust: if values.is_empty() {
    // rust: return Err(error("empty weighted variants"));
}
    // rust: let mut total = 0i32;
    // rust: let entries = values
    // rust: .into_iter()
    // rust: .map(|v| {
    // rust: let fields = object(v)?;
    // rust: let weight = optional(&fields, "weight")
    // rust: .map(integer)
    // rust: .transpose()?
    // rust: .unwrap_or(1);
    // rust: if weight <= 0 {
    // rust: return Err(error("nonpositive variant weight"));
}
    // rust: total = total
    // rust: .checked_add(weight)
    // rust: .ok_or_else(|| error("variant weight overflow"))?;
    // rust: Ok((Variant::decode(v)?, weight))
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: Ok(Self::Weighted(entries))
}
}
    // rust: impl Condition {
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fields = object(raw)?;
    // rust: if fields.len() == 1 {
    // rust: for name in ["OR", "AND"] {
    // rust: if let Some(raw) = fields.get(name) {
    // rust: if let Ok(values) = array(raw).and_then(|values| {
    // rust: values
    // rust: .into_iter()
    // rust: .map(Self::decode)
    // rust: .collect::<Result<Vec<_>>>()
    // rust: }) {
    // rust: return Ok(if name == "OR" {
    // rust: Self::Or(values)
    // rust: } else {
    // rust: Self::And(values)
    // rust: });
}
}
}
}
    // rust: if fields.is_empty() {
    // rust: return Err(error("empty property conditions"));
}
    // rust: let tests = fields
    // rust: .into_iter()
    // rust: .map(|(key, raw)| {
    // rust: let value = match raw.get().as_bytes().first() {
    // rust: Some(b'"') => string(raw)?,
    // rust: Some(b't' | b'f') => raw.get().to_owned(),
    // rust: _ => integer(raw)?.to_string(),
}
    // rust: let terms = value
    // rust: .split('|')
    // rust: .map(|v| {
    // rust: let negated = v.starts_with('!');
    // rust: let value = v.strip_prefix('!').unwrap_or(v);
    // rust: if value.is_empty() {
    // rust: return Err(error("empty property term"));
}
    // rust: Ok(Term {
    // rust: value: value.to_owned(),
    // rust: negated,
    // rust: })
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: Ok((key, terms))
    // rust: })
    // rust: .collect::<Result<_>>()?;
    // rust: Ok(Self::Properties(tests))
}
}
