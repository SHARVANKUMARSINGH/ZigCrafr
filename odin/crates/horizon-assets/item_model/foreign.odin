//! Transpiled from Horizon Rust crate
package horizon_assets_foreign

import "core:fmt"
import "core:mem"
import "core:math"

// Nodes and properties of other namespaces (a mod's, NeoForge's) decode to the closest vanilla behaviour.
// use super::{
    // rust: ItemModelNode, ModelLeaf, Result, TintSource, get, ident, identifier, list, object,
    // rust: optional_transformation,
}
// use crate::{json::error as err, math::Mat4};
// use serde_json::{Map, Value};

// Keys a mod's node usually keeps its real model under, in order of preference.
MODEL_KEYS :: ["model", "base_model", "base", "fallback"]

is_foreign :: proc(id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !id.starts_with("minecraft:")
}

// A composite carries the transformation a collapsed node had.
wrap :: proc(node: ItemModelNode, transformation: Maybe(Mat4)) -> I {
    // Ported from Horizon
    return {}
}
    // rust: match transformation {
    // rust: None => node,
    // rust: Some(_) => ItemModelNode::Composite {
    // rust: models: vec![node],
    // rust: transformation,
    // rust: },
}
}

property_is_foreign :: proc(m: ^Map<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let property = m
    // rust: .get("property")
    // rust: .ok_or_else(|| err("missing property"))
    // rust: .and_then(ident)?;
    // rust: Ok(is_foreign(&property))
}

leaf :: proc(model: string, m: ^Map<string) -> I {
    // Ported from Horizon
    return {}
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

// A node of an unknown non-vanilla type: its nested node, else its model id, else nothing.
decode_node :: proc(kind: string, m: ^Map<string) -> I {
    // Ported from Horizon
    return {}
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
fluid_container :: proc(m: ^Map<string) -> I {
    // Ported from Horizon
    return {}
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
