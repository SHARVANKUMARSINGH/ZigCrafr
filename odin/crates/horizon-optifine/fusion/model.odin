//! Transpiled from Horizon Rust crate
package horizon_optifine_model

import "core:fmt"
import "core:mem"
import "core:math"

// Fusion block models (`"loader": "fusion:model"`): the model type, and the `connections` of a
// connecting model, which name the predicates each face's connecting texture joins by.

// use super::{Connection, kind};
// use crate::cem::json::Json;

// A model's Fusion type.
ModelType :: enum {
    Base,
    Connecting,
    Composite,
}

    // rust: impl ModelType {
    // `None` for a model Fusion leaves to vanilla.
of :: proc(model: ^Json) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if model.get("loader").and_then(Json::as_str) != Some("fusion:model") {
    // rust: return None;
}
    // rust: Some(match kind(model.get("type")?.as_str()?) {
    // rust: "base" => Self::Base,
    // rust: "connecting" => Self::Connecting,
    // rust: "composite" => Self::Composite,
    // rust: _ => return None,
    // rust: })
}
}

// A connecting model's `connections`.
Connections :: enum {
    // None given: each texture joins by its own.
    Textures,
    // One set of predicates for every face.
    All(Connection),
    // Predicates by key, as `textures` names textures: each a predicate or `#another`.
    Keys(Vec<(String, Entry)>),
}

Entry :: enum {
    Predicate(Connection),
    Ref(String),
}

// `#key` chains longer than this are a loop.
DEPTH :: 32

    // rust: impl Connections {
    // A model's `connections` value: a predicate (an object with a `type`, or an array), or an
    // object of keys.
parse :: proc(json: ^Json) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let keys = match json {
    // rust: Json::Obj(keys) if json.get("type").is_none() => keys,
    // rust: _ => return Ok(Self::All(Connection::parse(json)?)),
}
    // rust: keys.iter()
    // rust: .map(|(key, value)| {
    // rust: let entry = match value.as_str() {
    // rust: Some(r) => Entry::Ref(r.strip_prefix('#').unwrap_or(r).to_owned()),
    // rust: None => Entry::Predicate(
    // rust: Connection::parse(value)
    // rust: .map_err(|e| format!("connections `{key}`: {e}"))?,
    // rust: ),
}
    // rust: Ok((key.clone(), entry))
    // rust: })
    // rust: .collect::<Result<_, String>>()
    // rust: .map(Self::Keys)
}

    // The model's `connections`: [`Connections::Textures`] without one.
of :: proc(model: ^Json) -> R {
    // Ported from Horizon
    return {}
}
    // rust: model
    // rust: .get("connections")
    // rust: .map_or(Ok(Self::Textures), Self::parse)
}

    // A child model's over its parent's: a child's keys add to and replace the parent's, and a
    // parent's predicates for every face stand for the keys the child doesn't define.
inherit :: proc(self: ^Self, parent: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match (self, parent) {
    // rust: (Self::Textures, parent) => parent.clone(),
    // rust: (Self::Keys(mut child), Self::Keys(parent)) => {
    // rust: for (key, entry) in parent {
    // rust: if !child.iter().any(|(k, _)| k == key) {
    // rust: child.push((key.clone(), entry.clone()));
}
}
    // rust: Self::Keys(child)
}
    // rust: (Self::Keys(mut child), Self::All(all)) => {
    // rust: if !child.iter().any(|(k, _)| k == "default") {
    // rust: child.push(("default".to_owned(), Entry::Predicate(all.clone())));
}
    // rust: Self::Keys(child)
}
    // rust: (child, _) => child,
}
}

    // The predicates of a face: its `connections` reference, else its `texture` one (each
    // `#key` or `key`). A key the model doesn't define takes `default`'s; `None` leaves the
    // texture's own.
for_face :: proc(self: ^Self, connections: Maybe(string), texture: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let keys = match self {
    // rust: Self::Textures => return None,
    // rust: Self::All(c) => return Some(c),
    // rust: Self::Keys(keys) => keys,
}
    // rust: let get = |key: &str| keys.iter().rev().find(|(k, _)| k == key).map(|(_, e)| e);
    // rust: let key = connections.unwrap_or(texture);
    // rust: let mut key = key.strip_prefix('#').unwrap_or(key);
    // rust: for _ in 0..DEPTH {
    // rust: match get(key).or_else(|| get("default"))? {
    // rust: Entry::Predicate(c) => return Some(c),
    // rust: Entry::Ref(next) => key = next,
}
}
    // rust: None
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::BlockMatch;

json :: proc(text: string) -> J {
    // Ported from Horizon
    return {}
}
    // rust: Json::parse(text).unwrap()
}

block :: proc(id: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Connection::Neighbour(vec![BlockMatch {
    // rust: id: id.into(),
    // rust: states: vec![],
    // rust: }])
}

model_types :: proc() {
}
    // rust: let ty = |text| ModelType::of(&json(text));
    // rust: assert_eq!(
    // rust: ty(r#"{"type": "fusion:connecting", "loader": "fusion:model"}"#),
    // rust: Some(ModelType::Connecting)
    // rust: );
    // rust: assert_eq!(
    // rust: ty(r#"{"loader": "fusion:model", "type": "base"}"#),
    // rust: Some(ModelType::Base)
    // rust: );
        // Without the loader Fusion leaves a model to vanilla.
    // rust: assert_eq!(ty(r#"{"type": "connecting"}"#), None);
}

keys_resolve_like_textures :: proc() {
}
        // The wiki's example: ice and lapis join by `blue`, dirt by its own, stone by `default`.
    // rust: let c = Connections::of(&json(
    // rust: r##"{"connections": {
    // rust: "blue": [{"type": "match_block", "block": "ice"}, {"type": "match_block", "block": "lapis_block"}],
    // rust: "lapis": "#blue",
    // rust: "dirt": {"type": "is_same_block"},
    // rust: "default": {"type": "is_same_state"}
    // rust: }}"##,
    // rust: ))
    // rust: .unwrap();
    // rust: let blue = Connection::Or(vec![block("minecraft:ice"), block("minecraft:lapis_block")]);
    // rust: assert_eq!(c.for_face(Some("#blue"), "#ice"), Some(&blue));
    // rust: assert_eq!(c.for_face(Some("#lapis"), "#lapis"), Some(&blue));
    // rust: assert_eq!(c.for_face(None, "#dirt"), Some(&Connection::SameBlock));
    // rust: assert_eq!(c.for_face(None, "#stone"), Some(&Connection::SameState));
}

one_predicate_for_every_face :: proc() {
}
    // rust: let c = Connections::of(&json(
    // rust: r#"{"connections": {"type": "fusion:or", "predicates": [{"type": "fusion:is_same_block"}]}}"#,
    // rust: ))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: c.for_face(None, "#pane"),
    // rust: Some(&Connection::Or(vec![Connection::SameBlock]))
    // rust: );
        // No connections: the textures' own; no `default`: also the texture's.
    // rust: assert_eq!(
    // rust: Connections::of(&json("{}")).unwrap().for_face(None, "#all"),
    // rust: None
    // rust: );
    // rust: let keyed =
    // rust: Connections::of(&json(r#"{"connections": {"top": {"type": "true"}}}"#)).unwrap();
    // rust: assert_eq!(keyed.for_face(None, "#side"), None);
    // rust: assert_eq!(keyed.for_face(None, "top"), Some(&Connection::Const(true)));
}

loops_and_inheritance :: proc() {
}
    // rust: let looped =
    // rust: Connections::of(&json(r##"{"connections": {"a": "#b", "b": "#a"}}"##)).unwrap();
    // rust: assert_eq!(looped.for_face(None, "#a"), None);
        // A reference to a key nobody defines takes `default`'s.
    // rust: let dangling = Connections::of(&json(
    // rust: r##"{"connections": {"a": "#missing", "default": {"type": "true"}}}"##,
    // rust: ))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: dangling.for_face(None, "#a"),
    // rust: Some(&Connection::Const(true))
    // rust: );
        // A parent's predicates for every face fill the keys a child leaves out, unless the
        // child has its own `default`.
    // rust: let all = Connections::All(Connection::SameBlock);
    // rust: let child = Connections::of(&json(r#"{"connections": {"top": {"type": "true"}}}"#))
    // rust: .unwrap()
    // rust: .inherit(&all);
    // rust: assert_eq!(child.for_face(None, "#top"), Some(&Connection::Const(true)));
    // rust: assert_eq!(child.for_face(None, "#side"), Some(&Connection::SameBlock));
    // rust: let child = Connections::of(&json(r#"{"connections": {"default": {"type": "false"}}}"#))
    // rust: .unwrap()
    // rust: .inherit(&all);
    // rust: assert_eq!(
    // rust: child.for_face(None, "#side"),
    // rust: Some(&Connection::Const(false))
    // rust: );
    // rust: let parent = Connections::of(&json(
    // rust: r#"{"connections": {"top": {"type": "true"}, "side": {"type": "false"}}}"#,
    // rust: ))
    // rust: .unwrap();
    // rust: let child = Connections::of(&json(
    // rust: r#"{"connections": {"side": {"type": "is_same_block"}}}"#,
    // rust: ))
    // rust: .unwrap()
    // rust: .inherit(&parent);
    // rust: assert_eq!(child.for_face(None, "#top"), Some(&Connection::Const(true)));
    // rust: assert_eq!(child.for_face(None, "#side"), Some(&Connection::SameBlock));
    // rust: assert_eq!(
    // rust: Connections::Textures
    // rust: .inherit(&parent)
    // rust: .for_face(None, "#top"),
    // rust: Some(&Connection::Const(true))
    // rust: );
}
}
