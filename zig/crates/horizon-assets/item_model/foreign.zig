//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_foreign
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Nodes and properties of other namespaces (a mod's, NeoForge's) decode to the closest vanilla behaviour.
// use super::{
    // rust: ItemModelNode, ModelLeaf, Result, TintSource, get, ident, identifier, list, object,
    // rust: optional_transformation,
}
// use crate::{json::error as err, math::Mat4};
// use serde_json::{Map, Value};

/// Keys a mod's node usually keeps its real model under, in order of preference.
pub const MODEL_KEYS: [[]const u8; 4] = ["model", "base_model", "base", "fallback"];

pub fn is_foreign(id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !id.starts_with("minecraft:")
}

/// A composite carries the transformation a collapsed node had.
pub fn wrap(node: ItemModelNode, transformation: ?Mat4) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match transformation {
    // rust: None => node,
    // rust: Some(_) => ItemModelNode::Composite {
    // rust: models: vec![node],
    // rust: transformation,
    // rust: },
}
}

pub fn property_is_foreign(m: *Map<[]const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let property = m
    // rust: .get("property")
    // rust: .ok_or_else(|| err("missing property"))
    // rust: .and_then(ident)?;
    // rust: Ok(is_foreign(&property))
}

pub fn leaf(model: []const u8, m: *Map<[]const u8) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tints = get(m, "tints")
    // rust: .and_then(|t| list(t).ok())
    // rust: .map(|t| {
    // rust: t.iter()
    // rust: .filter_map(|t| TintSource::decode(t).ok())
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: ItemModelNode::Model(ModelLeaf {
    // rust: model,
    // rust: transformation: optional_transformation(m).ok().flatten(),
    // rust: tints,
    // rust: })
}

/// A node of an unknown non-vanilla type: its nested node, else its model id, else nothing.
pub fn decode_node(kind: []const u8, m: *Map<[]const u8) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if kind == "neoforge:fluid_container" {
    // rust: return fluid_container(m);
}
    // rust: for key in MODEL_KEYS {
    // rust: match m.get(key) {
    // rust: Some(nested @ Value::Object(_)) => {
    // rust: if let Ok(node) = ItemModelNode::decode(nested) {
    // rust: return wrap(node, optional_transformation(m).ok().flatten());
}
}
    // rust: Some(Value::String(id)) => {
    // rust: if let Ok(id) = identifier(id) {
    // rust: return leaf(id, m);
}
}
    // rust: _ => {}
}
}
    // rust: let by_suffix = m
    // rust: .iter()
    // rust: .filter(|(k, _)| k.ends_with("_model"))
    // rust: .find_map(|(_, v)| v.as_str().and_then(|id| identifier(id).ok()));
    // rust: match by_suffix {
    // rust: Some(id) => leaf(id, m),
    // rust: None => ItemModelNode::Empty,
}
}

// The fluid is not drawn: only the base (and an unmasked cover) texture, taken as a model id (a bucket's).
pub fn fluid_container(m: *Map<[]const u8) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let textures = m.get("textures").and_then(|t| object(t).ok());
    // rust: let texture = |key: &str| {
    // rust: textures
    // rust: .and_then(|t| t.get(key))
    // rust: .and_then(Value::as_str)
    // rust: .and_then(|id| identifier(id).ok())
}
    // rust: let mut layers = vec![texture("base")];
    // rust: if m.get("cover_is_mask") == Some(&Value::Bool(false)) {
    // rust: layers.push(texture("cover"));
}
    // rust: let mut models: Vec<ItemModelNode> = layers
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|model| {
    // rust: ItemModelNode::Model(ModelLeaf {
    // rust: model,
    // rust: transformation: None,
    // rust: tints: Vec::new(),
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let transformation = optional_transformation(m).ok().flatten();
    // rust: match models.len() {
    // rust: 0 => ItemModelNode::Empty,
    // rust: 1 => wrap(models.remove(0), transformation),
    // rust: _ => ItemModelNode::Composite {
    // rust: models,
    // rust: transformation,
    // rust: },
}
}
