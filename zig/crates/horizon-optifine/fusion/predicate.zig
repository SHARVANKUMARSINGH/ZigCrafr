//! Transpiled from Horizon Rust crate
//! Module: horizon-optifine_predicate
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Connection predicates: whether a connecting texture joins the neighbour in one of the eight
//! directions of its face. Each direction is tested on its own, and the true ones make the
//! face's [`crate::ctm::connect`] mask.
//!
//! The predicate's block lists are `B`: [`BlockMatch`]es as parsed, which the game turns into
//! whatever it tests block states with ([`Connection::map_blocks`]). What a test reads of the
//! world, the game answers ([`Connection::joins`]).

// use super::kind;
// use crate::BlockMatch;
// use crate::cem::json::Json;
// use crate::ctm::connect::{D, DL, DR, L, R, U, UL, UR};

pub const Connection = enum {
    /// `is_same_block`: the neighbour is the same block.
    SameBlock,
    /// `is_same_state`: the same block in the same state.
    SameState,
    /// `match_block`, `match_state`: the neighbour is one of these.
    Neighbour(B),
    /// `match_block_in_front`, `match_state_in_front`: the block in front of the neighbour (on
    /// the side the face looks out of) is one of these.
    InFront(B),
    /// `is_direction`: the direction is one of these mask bits.
    Direction(u8),
    /// `is_face_visible`: the neighbour's face on this side isn't covered.
    FaceVisible,
    And(Vec<Connection<B>>),
    Or(Vec<Connection<B>>),
    Not(Box<Connection<B>>),
    Const(bool),
};

/// A test only the world answers, for one direction.
pub const Query = enum {
    SameBlock,
    SameState,
    Neighbour(&'a B),
    InFront(&'a B),
    FaceVisible,
};

/// Directions in the texture's terms, as mask bits.
pub fn direction(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match name {
    // rust: "top" => U,
    // rust: "top_right" => UR,
    // rust: "right" => R,
    // rust: "bottom_right" => DR,
    // rust: "bottom" => D,
    // rust: "bottom_left" => DL,
    // rust: "left" => L,
    // rust: "top_left" => UL,
    // rust: _ => return None,
    // rust: })
}

/// A value, or each value of an array.
pub fn one_or_many(value: *Json) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match value {
    // rust: Json::Arr(items) => items,
    // rust: single => std::slice::from_ref(single),
}
}

/// `one` or `many` of a field: a string or an array of them.
    // rust: fn names<'a>(json: &'a Json, one: &str, many: &str) -> Result<Vec<&'a str>, String> {
    // rust: let (key, value) = [one, many]
    // rust: .into_iter()
    // rust: .find_map(|key| Some((key, json.get(key)?)))
    // rust: .ok_or_else(|| format!("no `{one}` or `{many}`"))?;
    // rust: one_or_many(value)
    // rust: .iter()
    // rust: .map(|v| {
    // rust: v.as_str()
    // rust: .ok_or_else(|| format!("`{key}` holds a non-string"))
    // rust: })
    // rust: .collect()
}

/// `block`/`blocks`, each with `properties` (a value or an array of values per property) when
/// `states` is set.
pub fn blocks(json: *Json, states: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut properties = Vec::new();
    // rust: if states && let Some(map) = json.get("properties") {
    // rust: for (key, values) in map.as_object().ok_or("`properties` is not an object")? {
    // rust: let values = one_or_many(values)
    // rust: .iter()
    // rust: .map(|v| match v {
    // rust: Json::Str(s) => Ok(s.clone()),
    // rust: Json::Bool(b) => Ok(b.to_string()),
    // rust: Json::Num(n) => Ok(n.to_string()),
    // rust: _ => Err(format!("property `{key}` has a value that isn't one")),
    // rust: })
    // rust: .collect::<Result<_, String>>()?;
    // rust: properties.push((key.clone(), values));
}
}
    // rust: Ok(names(json, "block", "blocks")?
    // rust: .into_iter()
    // rust: .map(|name| BlockMatch {
    // rust: id: crate::matchers::namespaced(name),
    // rust: states: properties.clone(),
    // rust: })
    // rust: .collect())
}

    // rust: impl Connection {
    /// A predicate, or an array of them that joins when any does (a texture's or a model's
    /// `connections`).
pub fn parse(json: *Json) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(items) = json.as_array() {
    // rust: return Ok(Self::Or(Self::parse_all(items)?));
}
    // rust: let ty = super::str_field(json, "type")?.ok_or("a predicate without a `type`")?;
    // rust: let list = |key: &str| match json.get(key).and_then(Json::as_array) {
    // rust: Some(items) => Self::parse_all(items),
    // rust: None => Err(format!("`{ty}` without a `{key}` array")),
}
    // rust: Ok(match kind(ty) {
    // rust: "is_same_block" => Self::SameBlock,
    // rust: "is_same_state" => Self::SameState,
    // rust: "match_block" => Self::Neighbour(blocks(json, false)?),
    // rust: "match_state" => Self::Neighbour(blocks(json, true)?),
    // rust: "match_block_in_front" => Self::InFront(blocks(json, false)?),
    // rust: "match_state_in_front" => Self::InFront(blocks(json, true)?),
    // rust: "is_direction" => Self::Direction(
    // rust: names(json, "direction", "directions")?
    // rust: .into_iter()
    // rust: .map(|d| direction(d).ok_or_else(|| format!("unknown direction `{d}`")))
    // rust: .try_fold(0, |mask, bit| bit.map(|b| mask | b))?,
    // rust: ),
    // rust: "is_face_visible" => Self::FaceVisible,
    // rust: "and" => Self::And(list("predicates")?),
    // rust: "or" => Self::Or(list("predicates")?),
    // rust: "not" => Self::Not(Box::new(Self::parse(
    // rust: json.get("predicate").ok_or("`not` without a `predicate`")?,
    // rust: )?)),
    // rust: "true" => Self::Const(true),
    // rust: "false" => Self::Const(false),
    // rust: other => return Err(format!("unknown connection predicate `{other}`")),
    // rust: })
}

pub fn parse_all(items: *[Json]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: items.iter().map(Self::parse).collect()
}
}

    // rust: impl<B> Connection<B> {
    /// The same predicate with its block lists turned into `C`s.
    // rust: pub fn map_blocks<C>(self, f: &mut impl FnMut(B) -> C) -> Connection<C> {
    // rust: let all =
    // rust: |items: Vec<Self>, f: &mut _| items.into_iter().map(|p| p.map_blocks(f)).collect();
    // rust: match self {
    // rust: Self::SameBlock => Connection::SameBlock,
    // rust: Self::SameState => Connection::SameState,
    // rust: Self::Neighbour(b) => Connection::Neighbour(f(b)),
    // rust: Self::InFront(b) => Connection::InFront(f(b)),
    // rust: Self::Direction(d) => Connection::Direction(d),
    // rust: Self::FaceVisible => Connection::FaceVisible,
    // rust: Self::And(items) => Connection::And(all(items, f)),
    // rust: Self::Or(items) => Connection::Or(all(items, f)),
    // rust: Self::Not(p) => Connection::Not(Box::new(p.map_blocks(f))),
    // rust: Self::Const(c) => Connection::Const(c),
}
}

    /// Whether the face joins toward `direction` (one mask bit), `world` answering the tests
    /// about the neighbour there. `and` and `or` stop at their first deciding predicate.
pub fn joins(self: *Self, direction: u8, world: *mut impl FnMut(Query<'_) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::SameBlock => world(Query::SameBlock),
    // rust: Self::SameState => world(Query::SameState),
    // rust: Self::Neighbour(b) => world(Query::Neighbour(b)),
    // rust: Self::InFront(b) => world(Query::InFront(b)),
    // rust: Self::Direction(d) => d & direction != 0,
    // rust: Self::FaceVisible => world(Query::FaceVisible),
    // rust: Self::And(items) => items.iter().all(|p| p.joins(direction, world)),
    // rust: Self::Or(items) => items.iter().any(|p| p.joins(direction, world)),
    // rust: Self::Not(p) => !p.joins(direction, world),
    // rust: Self::Const(c) => *c,
}
}

    /// The mask of the eight directions that join, `world` answering for the direction it is
    /// given.
pub fn mask(self: *Self, mut world: impl FnMut(u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [U, UR, R, DR, D, DL, L, UL]
    // rust: .into_iter()
    // rust: .filter(|&bit| self.joins(bit, &mut |q| world(bit, q)))
    // rust: .fold(0, |mask, bit| mask | bit)
}
}

    // rust: mod tests {
//     use super::*;

pub fn parse(text: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Connection::parse(&Json::parse(text).unwrap()).unwrap()
}

pub fn parses_every_predicate() void {
}
    // rust: let p = parse(
    // rust: r#"[
    // rust: {"type": "fusion:is_same_block"},
    // rust: {"type": "match_state", "blocks": ["redstone_torch", "create:lamp"],
    // rust: "properties": {"lit": "false", "facing": ["north", "south"]}},
    // rust: {"type": "and", "predicates": [
    // rust: {"type": "match_block_in_front", "block": "Sand"},
    // rust: {"type": "not", "predicate": {"type": "is_direction", "directions": ["top", "bottom_left"]}},
    // rust: {"type": "is_face_visible"}, {"type": "true"}
    // rust: ]}
    // rust: ]"#,
    // rust: );
    // rust: let states = vec![
    // rust: ("lit".to_owned(), vec!["false".to_owned()]),
    // rust: (
    // rust: "facing".to_owned(),
    // rust: vec!["north".to_owned(), "south".to_owned()],
    // rust: ),
    // rust: ];
    // rust: assert_eq!(
    // rust: p,
    // rust: Connection::Or(vec![
    // rust: Connection::SameBlock,
    // rust: Connection::Neighbour(vec![
    // rust: BlockMatch {
    // rust: id: "minecraft:redstone_torch".into(),
    // rust: states: states.clone(),
    // rust: },
    // rust: BlockMatch {
    // rust: id: "create:lamp".into(),
    // rust: states,
    // rust: },
    // rust: ]),
    // rust: Connection::And(vec![
    // rust: Connection::InFront(vec![BlockMatch {
    // rust: id: "minecraft:sand".into(),
    // rust: states: vec![],
    // rust: }]),
    // rust: Connection::Not(Box::new(Connection::Direction(U | DL))),
    // rust: Connection::FaceVisible,
    // rust: Connection::Const(true),
    // rust: ]),
    // rust: ])
    // rust: );
        // `match_block` has no properties to test.
    // rust: assert_eq!(
    // rust: parse(r#"{"type": "match_block", "block": "stone", "properties": {"a": "b"}}"#),
    // rust: Connection::Neighbour(vec![BlockMatch {
    // rust: id: "minecraft:stone".into(),
    // rust: states: vec![],
    // rust: }])
    // rust: );
}

pub fn directions_and_property_values() void {
}
    // rust: for (name, bit) in [
    // rust: ("top", U),
    // rust: ("top_right", UR),
    // rust: ("right", R),
    // rust: ("bottom_right", DR),
    // rust: ("bottom", D),
    // rust: ("bottom_left", DL),
    // rust: ("left", L),
    // rust: ("top_left", UL),
    // rust: ] {
    // rust: let p = parse(&format!(
    // rust: r#"{{"type": "is_direction", "direction": "{name}"}}"#
    // rust: ));
    // rust: assert_eq!(p, Connection::Direction(bit), "{name}");
}
        // Booleans and numbers as block states write them.
    // rust: assert_eq!(
    // rust: parse(
    // rust: r#"{"type": "match_state", "block": "light", "properties": {"waterlogged": false, "level": 15}}"#
    // rust: ),
    // rust: Connection::Neighbour(vec![BlockMatch {
    // rust: id: "minecraft:light".into(),
    // rust: states: vec![
    // rust: ("waterlogged".into(), vec!["false".into()]),
    // rust: ("level".into(), vec!["15".into()]),
    // rust: ],
    // rust: }])
    // rust: );
}

pub fn refuses_what_it_cannot_read() void {
}
    // rust: for bad in [
    // rust: r#"{"type": "is_same_thing"}"#,
    // rust: r#"{"block": "stone"}"#,
    // rust: r#"{"type": "match_block"}"#,
    // rust: r#"{"type": "is_direction", "direction": "up"}"#,
    // rust: r#"{"type": "and", "predicates": {"type": "true"}}"#,
    // rust: r#"{"type": "not"}"#,
    // rust: r#"{"type": "match_state", "block": "stone", "properties": ["lit"]}"#,
    // rust: ] {
    // rust: assert!(
    // rust: Connection::parse(&Json::parse(bad).unwrap()).is_err(),
    // rust: "{bad}"
    // rust: );
}
}

pub fn masks_from_the_world() void {
}
        // Block transitions' sand edge: sand beside the face, or sand in front of the
        // neighbour, but only where the neighbour's face shows.
    // rust: let p = parse(
    // rust: r#"{"type": "or", "predicates": [
    // rust: {"type": "match_block_in_front", "block": "sand"},
    // rust: {"type": "and", "predicates": [
    // rust: {"type": "match_block", "block": "sand"}, {"type": "is_face_visible"}]}
    // rust: ]}"#,
    // rust: );
        // Sand to the right, its face covered; sand in front of the neighbour above.
    // rust: let mask = p.mask(|dir, q| match q {
    // rust: Query::Neighbour(_) => dir == R,
    // rust: Query::InFront(_) => dir == U,
    // rust: Query::FaceVisible => false,
    // rust: _ => unreachable!("not in the predicate"),
    // rust: });
    // rust: assert_eq!(mask, U);
        // `is_direction` needs no world; `not` and `and` combine it.
    // rust: let p = parse(
    // rust: r#"{"type": "and", "predicates": [{"type": "is_same_state"},
    // rust: {"type": "not", "predicate": {"type": "is_direction", "direction": "left"}}]}"#,
    // rust: );
    // rust: assert_eq!(
    // rust: p.mask(|_, q| q == Query::SameState),
    // rust: !L,
    // rust: "joins everywhere but left"
    // rust: );
}

pub fn map_blocks_keeps_the_shape() void {
}
    // rust: let p = parse(r#"{"type": "not", "predicate": {"type": "match_block", "block": "dirt"}}"#);
    // rust: let mapped = p.map_blocks(&mut |b: Vec<BlockMatch>| b.len());
    // rust: assert_eq!(mapped, Connection::Not(Box::new(Connection::Neighbour(1))));
}
}
