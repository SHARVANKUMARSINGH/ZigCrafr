//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_bind
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Bind resource selectors to a block's property schema and ordered states.
// use super::{BlockStateDefinition, Condition, Term};
// use crate::json::{Result, error};
// use horizon_core::text::parse_java_integer;
// use std::collections::{BTreeMap, BTreeSet};

    // rust: pub type Properties = BTreeMap<String, String>;
    // rust: pub type PropertySchema = BTreeMap<String, PropertyValues>;
pub const PropertyValues = enum {
    Named(BTreeSet<String>),
    Integer { minimum: i32, maximum: i32 },
};
    // rust: impl PropertyValues {
pub fn parse(self: *Self, text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Named(values) => values.contains(text).then(|| text.to_owned()),
    // rust: Self::Integer { minimum, maximum } => {
    // rust: let value = parse_java_integer(text)?;
    // rust: (value >= *minimum && value <= *maximum).then(|| value.to_string())
}
}
}
}
/// Indices into the original definition. An empty multipart selection is distinct
/// from an absent root: the native root exists but contributes no model parts.
pub const SelectedModels = enum {
    Variant(usize),
    Multipart(Vec<usize>),
};
pub const BoundCondition = enum {
    Or(Vec<Self>),
    And(Vec<Self>),
    Properties(BTreeMap<String, Vec<Term>>),
};
    // rust: impl BoundCondition {
pub fn bind(value: *Condition, schema: *PropertySchema) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(match value {
    // rust: Condition::Or(values) => Self::Or(
    // rust: values
    // rust: .iter()
    // rust: .map(|v| Self::bind(v, schema))
    // rust: .collect::<Result<_>>()?,
    // rust: ),
    // rust: Condition::And(values) => Self::And(
    // rust: values
    // rust: .iter()
    // rust: .map(|v| Self::bind(v, schema))
    // rust: .collect::<Result<_>>()?,
    // rust: ),
    // rust: Condition::Properties(values) => Self::Properties(
    // rust: values
    // rust: .iter()
    // rust: .map(|(key, terms)| {
    // rust: let domain = schema
    // rust: .get(key)
    // rust: .ok_or_else(|| error("unknown multipart property"))?;
    // rust: let terms = terms
    // rust: .iter()
    // rust: .map(|t| {
    // rust: Ok(Term {
    // rust: value: domain
    // rust: .parse(&t.value)
    // rust: .ok_or_else(|| error("unknown multipart property value"))?,
    // rust: negated: t.negated,
    // rust: })
    // rust: })
    // rust: .collect::<Result<_>>()?;
    // rust: Ok((key.clone(), terms))
    // rust: })
    // rust: .collect::<Result<_>>()?,
    // rust: ),
    // rust: })
}
pub fn matches(self: *Self, state: *Properties) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Or(values) => values.iter().any(|v| v.matches(state)),
    // rust: Self::And(values) => values.iter().all(|v| v.matches(state)),
    // rust: Self::Properties(values) => values.iter().all(|(key, terms)| {
    // rust: state
    // rust: .get(key)
    // rust: .is_some_and(|value| terms.iter().any(|t| (value == &t.value) ^ t.negated))
    // rust: }),
}
}
}
pub fn variant_predicate(text: []const u8, schema: *PropertySchema) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut result = Properties::new();
    // rust: for clause in text.split(',') {
    // rust: let (key, value) = clause
    // rust: .split_once('=')
    // rust: .map_or((clause, None), |(k, v)| (k, Some(v)));
    // rust: if let (Some(domain), Some(value)) = (schema.get(key), value) {
    // rust: result.insert(
    // rust: key.to_owned(),
    // rust: domain
    // rust: .parse(value)
    // rust: .ok_or_else(|| error("unknown variant property value"))?,
    // rust: );
    // rust: } else if !key.is_empty() {
    // rust: return Err(error("unknown or incomplete variant property"));
}
}
    // rust: Ok(result)
}
    // rust: impl BlockStateDefinition {
    /// `states` must be the block's canonical possible states in native order.
    /// Invalid variant selectors are skipped. On overlapping selectors, vanilla
    /// replaces the first overlapping state before aborting that selector's walk.
    /// Multipart predicates bind eagerly, even when variants cover every state.
    // rust: pub fn bind(
    // rust: &self,
    // rust: schema: &PropertySchema,
    // rust: states: &[Properties],
    // rust: ) -> Result<Vec<Option<SelectedModels>>> {
    // rust: let mut result = vec![None; states.len()];
    // rust: if let Some(variants) = &self.variants {
    // rust: for (index, (key, _)) in variants.iter().enumerate() {
    // rust: let Ok(predicate) = variant_predicate(key, schema) else {
    // rust: continue;
}
    // rust: for (target, state) in result.iter_mut().zip(states) {
    // rust: if predicate
    // rust: .iter()
    // rust: .all(|(key, value)| state.get(key) == Some(value))
    // rust: && target.replace(SelectedModels::Variant(index)).is_some()
    // rust: {
    // rust: break;
}
}
}
}
    // rust: if let Some(selectors) = &self.multipart {
    // rust: let predicates = selectors
    // rust: .iter()
    // rust: .map(|s| {
    // rust: s.condition
    // rust: .as_ref()
    // rust: .map(|v| BoundCondition::bind(v, schema))
    // rust: .transpose()
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: for (target, state) in result.iter_mut().zip(states) {
    // rust: if target.is_none() {
    // rust: let selected = predicates
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(index, p)| {
    // rust: p.as_ref().is_none_or(|p| p.matches(state)).then_some(index)
    // rust: })
    // rust: .collect();
    // rust: *target = Some(SelectedModels::Multipart(selected));
}
}
}
    // rust: Ok(result)
}
}
