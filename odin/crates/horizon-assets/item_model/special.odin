//! Transpiled from Horizon Rust crate
package horizon_assets_special

import "core:fmt"
import "core:mem"
import "core:math"

// `special` item models: the block-entity style renderers an item can ask
// for (`SpecialModelRenderers`), their codec fields and what each reads from
// the stack (`extractArgument`).
// use super::{Result, float, get, ident, object, required, string};
// use crate::json::error as err;
// use serde_json::{Map, Value, json};

SpecialKind :: enum {
    Bell,
    Banner {,
    color: String,
    wall: bool,
    // rust: },
    Book {,
    open_angle: f32,
    page1: f32,
    page2: f32,
    // rust: },
    Conduit,
    Chest {,
    texture: String,
    openness: f32,
    chest_type: String,
    // rust: },
    CopperGolemStatue {,
    texture: String,
    pose: String,
    // rust: },
    DecoratedPot,
    EndCube {,
    effect: String,
    // rust: },
    Head {,
    kind: String,
    texture: Option<String>,
    animation: f32,
    // rust: },
    PlayerHead,
    ShulkerBox {,
    texture: String,
    openness: f32,
    // rust: },
    Shield,
    Trident,
}
SpecialModel :: struct {
    kind: SpecialKind,
}

    // rust: const DYES: [&str; 16] = [
    // rust: "white",
    // rust: "orange",
    // rust: "magenta",
    // rust: "light_blue",
    // rust: "yellow",
    // rust: "lime",
    // rust: "pink",
    // rust: "gray",
    // rust: "light_gray",
    // rust: "cyan",
    // rust: "purple",
    // rust: "blue",
    // rust: "brown",
    // rust: "green",
    // rust: "red",
    // rust: "black",
    // rust: ];
one_of :: proc(v: ^Value, names: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let s = string(v)?;
    // rust: if names.contains(&s.as_str()) {
    // rust: Ok(s)
    // rust: } else {
    // rust: Err(err("invalid enum name"))
}
}

    // rust: impl SpecialModel {
    // A special model type of another namespace, which Horizon has no renderer for.
is_foreign :: proc(v: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: v.get("type")
    // rust: .and_then(Value::as_str)
    // rust: .and_then(|t| super::identifier(t).ok())
    // rust: .is_some_and(|t| super::foreign::is_foreign(&t))
}
decode :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let m = object(v)?;
    // rust: let float_or = |key: &str, default: f32| get(m, key).map_or(Ok(default), float);
    // rust: let kind = match ident(required(m, "type")?)?.as_str() {
    // rust: "minecraft:bell" => SpecialKind::Bell,
    // rust: "minecraft:banner" => SpecialKind::Banner {
    // rust: color: one_of(required(m, "color")?, &DYES)?,
    // rust: wall: match get(m, "attachment") {
    // rust: None => false,
    // rust: Some(a) => one_of(a, &["wall", "ground"])? == "wall",
    // rust: },
    // rust: },
    // rust: "minecraft:book" => SpecialKind::Book {
    // rust: open_angle: float(required(m, "open_angle")?)?,
    // rust: page1: float(required(m, "page1")?)?,
    // rust: page2: float(required(m, "page2")?)?,
    // rust: },
    // rust: "minecraft:conduit" => SpecialKind::Conduit,
    // rust: "minecraft:chest" => SpecialKind::Chest {
    // rust: texture: ident(required(m, "texture")?)?,
    // rust: openness: float_or("openness", 0.0)?,
    // rust: chest_type: match get(m, "chest_type") {
    // rust: None => "single".to_owned(),
    // rust: Some(t) => one_of(t, &["single", "left", "right"])?,
    // rust: },
    // rust: },
    // rust: "minecraft:copper_golem_statue" => SpecialKind::CopperGolemStatue {
    // rust: texture: ident(required(m, "texture")?)?,
    // rust: pose: one_of(
    // rust: required(m, "pose")?,
    // rust: &["standing", "sitting", "running", "star"],
    // rust: )?,
    // rust: },
    // rust: "minecraft:decorated_pot" => SpecialKind::DecoratedPot,
    // rust: "minecraft:end_cube" => SpecialKind::EndCube {
    // rust: effect: one_of(required(m, "effect")?, &["portal", "gateway"])?,
    // rust: },
    // rust: "minecraft:head" => SpecialKind::Head {
    // rust: kind: one_of(
    // rust: required(m, "kind")?,
    // rust: &[
    // rust: "skeleton",
    // rust: "wither_skeleton",
    // rust: "player",
    // rust: "zombie",
    // rust: "creeper",
    // rust: "piglin",
    // rust: "dragon",
    // rust: ],
    // rust: )?,
    // rust: texture: get(m, "texture").map(ident).transpose()?,
    // rust: animation: float_or("animation", 0.0)?,
    // rust: },
    // rust: "minecraft:player_head" => SpecialKind::PlayerHead,
    // rust: "minecraft:shulker_box" => SpecialKind::ShulkerBox {
    // rust: texture: ident(required(m, "texture")?)?,
    // rust: openness: float_or("openness", 0.0)?,
    // rust: },
    // rust: "minecraft:shield" => SpecialKind::Shield,
    // rust: "minecraft:trident" => SpecialKind::Trident,
    // rust: _ => return Err(err("unknown special model type")),
}
    // rust: Ok(Self { kind })
}
    // The codec's encoding: optional fields equal to their default are omitted.
to_json :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut m = Map::new();
    // rust: let mut put = |k: &str, v: Value| {
    // rust: m.insert(k.to_owned(), v);
}
    // rust: let ty = match &self.kind {
    // rust: SpecialKind::Bell => "bell",
    // rust: SpecialKind::Banner { color, wall } => {
    // rust: put("color", json!(color));
    // rust: if *wall {
    // rust: put("attachment", json!("wall"));
}
    // rust: "banner"
}
    // rust: SpecialKind::Book {
    // rust: open_angle,
    // rust: page1,
    // rust: page2,
    // rust: } => {
    // rust: put("open_angle", json!(open_angle));
    // rust: put("page1", json!(page1));
    // rust: put("page2", json!(page2));
    // rust: "book"
}
    // rust: SpecialKind::Conduit => "conduit",
    // rust: SpecialKind::Chest {
    // rust: texture,
    // rust: openness,
    // rust: chest_type,
    // rust: } => {
    // rust: put("texture", json!(texture));
    // rust: if *openness != 0.0 {
    // rust: put("openness", json!(openness));
}
    // rust: if chest_type != "single" {
    // rust: put("chest_type", json!(chest_type));
}
    // rust: "chest"
}
    // rust: SpecialKind::CopperGolemStatue { texture, pose } => {
    // rust: put("texture", json!(texture));
    // rust: put("pose", json!(pose));
    // rust: "copper_golem_statue"
}
    // rust: SpecialKind::DecoratedPot => "decorated_pot",
    // rust: SpecialKind::EndCube { effect } => {
    // rust: put("effect", json!(effect));
    // rust: "end_cube"
}
    // rust: SpecialKind::Head {
    // rust: kind,
    // rust: texture,
    // rust: animation,
    // rust: } => {
    // rust: put("kind", json!(kind));
    // rust: if let Some(t) = texture {
    // rust: put("texture", json!(t));
}
    // rust: if *animation != 0.0 {
    // rust: put("animation", json!(animation));
}
    // rust: "head"
}
    // rust: SpecialKind::PlayerHead => "player_head",
    // rust: SpecialKind::ShulkerBox { texture, openness } => {
    // rust: put("texture", json!(texture));
    // rust: if *openness != 0.0 {
    // rust: put("openness", json!(openness));
}
    // rust: "shulker_box"
}
    // rust: SpecialKind::Shield => "shield",
    // rust: SpecialKind::Trident => "trident",
}
    // rust: m.insert("type".to_owned(), json!(format!("minecraft:{ty}")));
    // rust: Value::Object(m)
}
type_name :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.to_json()["type"]
    // rust: .as_str()
    // rust: .unwrap_or_default()
    // rust: .to_owned()
}
    // What `extractArgument` reads: banners their pattern layers, shields
    // their base colour and layers, decorated pots their sherds and player
    // heads their profile. Absent components give `null`.
argument :: proc(self: ^Self, component: ^dyn Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match &self.kind {
    // rust: SpecialKind::Banner { .. } => {
    // rust: component("minecraft:banner_patterns").unwrap_or(Value::Null)
}
    // rust: SpecialKind::DecoratedPot => {
    // rust: component("minecraft:pot_decorations").unwrap_or(Value::Null)
}
    // rust: SpecialKind::PlayerHead => component("minecraft:profile").unwrap_or(Value::Null),
    // rust: SpecialKind::Shield => {
    // rust: let mut m = Map::new();
    // rust: for key in ["minecraft:banner_patterns", "minecraft:base_color"] {
    // rust: if let Some(v) = component(key) {
    // rust: m.insert(key.to_owned(), v);
}
}
    // rust: Value::Object(m)
}
    // rust: _ => Value::Null,
}
}
}
