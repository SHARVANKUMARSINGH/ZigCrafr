//! Transpiled from Horizon Rust crate
package horizon_optifine_texture

import "core:fmt"
import "core:mem"
import "core:math"

// The `fusion` section of a texture's `.mcmeta` (beside vanilla's `animation`): the texture's
// type and its options.

// use super::{Connection, Layout, bool_field, int_field, kind, str_field};
// use crate::cem::json::Json;

// A texture's Fusion metadata.
Meta :: struct {
    base: Base,
    kind: Kind,
}

// The options every type takes (`base` on its own).
Base :: struct {
    // Drawn fully bright, as at light level 15.
    emissive: bool,
    render_type: Maybe(RenderType),
    // Tinted as this, whatever the block tints.
    tinting: Maybe(Tinting),
}

RenderType :: enum {
    Opaque,
    Cutout,
    Translucent,
}

Tinting :: enum {
    Grass,
    Foliage,
    Water,
}

Kind :: enum {
    Base,
    Connecting {,
    layout: Layout,
        // The texture's own; a `fusion:connecting` model's replace them.
    connections: Connection,
        // Each tile's own metadata, as if it were a texture.
    sub_texture: Option<Box<Meta>>,
        // Each tile holds its animation frames, instead of each frame holding every tile.
    per_tile_animation: bool,
    // rust: },
    Random {,
    columns: u32,
    rows: u32,
    source: RandomSource,
    seed: Option<i64>,
    sub_texture: Option<Box<Meta>>,
    per_tile_animation: bool,
    // rust: },
    // One image stretched over `columns` x `rows` blocks.
    Continuous {,
    columns: u32,
    rows: u32,
    // rust: },
    Scrolling(Scrolling),
}

// What picks a random texture's tile.
RandomSource :: enum {
    Position,
    PositionFacing,
    PositionAxis,
}

// An animation whose frame, `frame_width` x `frame_height` pixels, moves across the image from
// one corner to another, each step shown for `frame_time` ticks.
Scrolling :: struct {
    from: Corner,
    to: Corner,
    frame_width: u32,
    frame_height: u32,
    frame_time: u32,
    loop_type: LoopType,
    // Ticks between loops.
    loop_pause: u32,
}

Corner :: enum {
    TopLeft,
    TopRight,
    BottomLeft,
    BottomRight,
}

LoopType :: enum {
    // Around the image to the start.
    Wrap,
    // Back to the start at once.
    Reset,
    // Back the way it came.
    Reverse,
}

// `key`'s value, which must be one of `options`.
    // rust: fn choice<T: Copy>(json: &Json, key: &str, options: &[(&str, T)]) -> Result<Option<T>, String> {
    // rust: match str_field(json, key)? {
    // rust: None => Ok(None),
    // rust: Some(value) => options
    // rust: .iter()
    // rust: .find(|(name, _)| *name == value)
    // rust: .map(|&(_, v)| Some(v))
    // rust: .ok_or_else(|| format!("`{key}` can't be `{value}`")),
}
}

    // rust: const CORNERS: [(&str, Corner); 4] = [
    // rust: ("top_left", Corner::TopLeft),
    // rust: ("top_right", Corner::TopRight),
    // rust: ("bottom_left", Corner::BottomLeft),
    // rust: ("bottom_right", Corner::BottomRight),
    // rust: ];

    // rust: impl Meta {
    // A `.mcmeta` file's Fusion metadata: `None` when it has no `fusion` section.
from_mcmeta :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let json = Json::parse(text)?;
    // rust: json.get("fusion").map(Self::parse).transpose()
}

    // A `fusion` section (or a `sub_texture`).
parse :: proc(json: ^Json) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if json.as_object().is_none() {
    // rust: return Err("a texture's Fusion metadata that isn't an object".into());
}
    // rust: let base = Base {
    // rust: emissive: bool_field(json, "emissive")?.unwrap_or(false),
    // rust: render_type: choice(
    // rust: json,
    // rust: "render_type",
    // rust: &[
    // rust: ("opaque", RenderType::Opaque),
    // rust: ("cutout", RenderType::Cutout),
    // rust: ("translucent", RenderType::Translucent),
    // rust: ],
    // rust: )?,
    // rust: tinting: choice(
    // rust: json,
    // rust: "tinting",
    // rust: &[
    // rust: ("biome_grass", Tinting::Grass),
    // rust: ("biome_foliage", Tinting::Foliage),
    // rust: ("biome_water", Tinting::Water),
    // rust: ],
    // rust: )?,
}
    // rust: let sub_texture = || {
    // rust: json.get("sub_texture")
    // rust: .map(|s| Self::parse(s).map(Box::new))
    // rust: .transpose()
}
    // rust: let per_tile_animation =
    // rust: || Ok::<_, String>(bool_field(json, "per_tile_animation")?.unwrap_or(false));
        // Without a type the options stand alone (Fusion Emissive Ores' overlays: only
        // `emissive` and `render_type`).
    // rust: let ty = str_field(json, "type")?.unwrap_or("base");
    // rust: let kind = match kind(ty) {
    // rust: "base" => Kind::Base,
    // rust: "connecting" => Kind::Connecting {
    // rust: layout: match str_field(json, "layout")? {
    // rust: None => Layout::Full,
    // rust: Some(l) => Layout::parse(l).ok_or_else(|| format!("unknown layout `{l}`"))?,
    // rust: },
    // rust: connections: match json.get("connections") {
    // rust: None => Connection::SameState,
    // rust: Some(c) => Connection::parse(c)?,
    // rust: },
    // rust: sub_texture: sub_texture()?,
    // rust: per_tile_animation: per_tile_animation()?,
    // rust: },
    // rust: "random" => Kind::Random {
    // rust: columns: int_field(json, "columns", 1..=100)?.unwrap_or(1) as u32,
    // rust: rows: int_field(json, "rows", 1..=100)?.unwrap_or(1) as u32,
    // rust: source: choice(
    // rust: json,
    // rust: "randomness_source",
    // rust: &[
    // rust: ("position", RandomSource::Position),
    // rust: ("position_facing", RandomSource::PositionFacing),
    // rust: ("position_axis", RandomSource::PositionAxis),
    // rust: ],
    // rust: )?
    // rust: .unwrap_or(RandomSource::PositionFacing),
                // JSON numbers here are `f64`s: from 2^53 a seed may not be the one written.
    // rust: seed: int_field(json, "seed", -(1 << 53) + 1..=(1 << 53) - 1)?,
    // rust: sub_texture: sub_texture()?,
    // rust: per_tile_animation: per_tile_animation()?,
    // rust: },
    // rust: "continuous" => Kind::Continuous {
    // rust: columns: int_field(json, "columns", 1..=32)?.unwrap_or(1) as u32,
    // rust: rows: int_field(json, "rows", 1..=32)?.unwrap_or(1) as u32,
    // rust: },
    // rust: "scrolling" => {
    // rust: let positive = |key, default| {
    // rust: Ok::<_, String>(
    // rust: int_field(json, key, 1..=i64::from(u32::MAX))?.unwrap_or(default) as u32,
    // rust: )
}
    // rust: Kind::Scrolling(Scrolling {
    // rust: from: choice(json, "from", &CORNERS)?.unwrap_or(Corner::TopLeft),
    // rust: to: choice(json, "to", &CORNERS)?.unwrap_or(Corner::BottomLeft),
    // rust: frame_width: positive("frame_width", 16)?,
    // rust: frame_height: positive("frame_height", 16)?,
    // rust: frame_time: positive("frame_time", 10)?,
    // rust: loop_type: choice(
    // rust: json,
    // rust: "loop_type",
    // rust: &[
    // rust: ("wrap", LoopType::Wrap),
    // rust: ("reset", LoopType::Reset),
    // rust: ("reverse", LoopType::Reverse),
    // rust: ],
    // rust: )?
    // rust: .unwrap_or(LoopType::Wrap),
    // rust: loop_pause: int_field(json, "loop_pause", 0..=i64::from(u32::MAX))?.unwrap_or(0)
    // rust: as u32,
    // rust: })
}
    // rust: other => return Err(format!("unknown texture type `{other}`")),
}
    // rust: Ok(Self { base, kind })
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::BlockMatch;

meta :: proc(text: string) -> M {
    // Ported from Horizon
    return {}
}
    // rust: Meta::from_mcmeta(text).unwrap().unwrap()
}

vanilla_mcmeta_has_none :: proc() {
}
    // rust: assert_eq!(
    // rust: Meta::from_mcmeta(r#"{"animation": {"frametime": 2}}"#),
    // rust: Ok(None)
    // rust: );
}

options_without_a_type_are_base :: proc() {
}
    // rust: assert_eq!(
    // rust: meta(r#"{"fusion": {"emissive": true, "render_type": "cutout"}}"#),
    // rust: Meta {
    // rust: base: Base {
    // rust: emissive: true,
    // rust: render_type: Some(RenderType::Cutout),
    // rust: tinting: None,
    // rust: },
    // rust: kind: Kind::Base,
}
    // rust: );
}

connecting_with_defaults_and_base_options :: proc() {
}
    // rust: let m = meta(
    // rust: r#"{"fusion": {"type": "connecting", "render_type": "cutout", "tinting": "biome_grass"},
    // rust: "animation": {"frametime": 10}}"#,
    // rust: );
    // rust: assert_eq!(
    // rust: m,
    // rust: Meta {
    // rust: base: Base {
    // rust: emissive: false,
    // rust: render_type: Some(RenderType::Cutout),
    // rust: tinting: Some(Tinting::Grass),
    // rust: },
    // rust: kind: Kind::Connecting {
    // rust: layout: Layout::Full,
    // rust: connections: Connection::SameState,
    // rust: sub_texture: None,
    // rust: per_tile_animation: false,
    // rust: },
}
    // rust: );
}

connecting_with_a_random_sub_texture :: proc() {
}
    // rust: let m = meta(
    // rust: r#"{"fusion": {"type": "fusion:connecting", "layout": "pieced", "emissive": true,
    // rust: "connections": [{"type": "is_same_block"}, {"type": "match_block", "block": "iron_block"}],
    // rust: "sub_texture": {"type": "random", "rows": 5, "columns": 4, "seed": -3},
    // rust: "per_tile_animation": true}}"#,
    // rust: );
    // rust: assert!(m.base.emissive);
    // rust: let Kind::Connecting {
    // rust: layout,
    // rust: connections,
    // rust: sub_texture,
    // rust: per_tile_animation,
    // rust: } = m.kind
    // rust: else {
    // rust: panic!("{m:?}");
}
    // rust: assert_eq!(layout, Layout::Pieced);
    // rust: assert!(per_tile_animation);
    // rust: assert_eq!(
    // rust: connections,
    // rust: Connection::Or(vec![
    // rust: Connection::SameBlock,
    // rust: Connection::Neighbour(vec![BlockMatch {
    // rust: id: "minecraft:iron_block".into(),
    // rust: states: vec![],
    // rust: }]),
    // rust: ])
    // rust: );
    // rust: assert_eq!(
    // rust: sub_texture.unwrap().kind,
    // rust: Kind::Random {
    // rust: columns: 4,
    // rust: rows: 5,
    // rust: source: RandomSource::PositionFacing,
    // rust: seed: Some(-3),
    // rust: sub_texture: None,
    // rust: per_tile_animation: false,
}
    // rust: );
}

continuous_and_scrolling :: proc() {
}
    // rust: assert_eq!(
    // rust: meta(r#"{"fusion": {"type": "continuous", "rows": 2, "columns": 3}}"#).kind,
    // rust: Kind::Continuous {
    // rust: columns: 3,
    // rust: rows: 2,
}
    // rust: );
    // rust: assert_eq!(
    // rust: meta(
    // rust: r#"{"fusion": {"type": "scrolling", "to": "top_right", "frame_time": 4,
    // rust: "frame_height": 8, "loop_type": "reverse", "loop_pause": 20}}"#
    // rust: )
    // rust: .kind,
    // rust: Kind::Scrolling(Scrolling {
    // rust: from: Corner::TopLeft,
    // rust: to: Corner::TopRight,
    // rust: frame_width: 16,
    // rust: frame_height: 8,
    // rust: frame_time: 4,
    // rust: loop_type: LoopType::Reverse,
    // rust: loop_pause: 20,
    // rust: })
    // rust: );
}

defaults :: proc() {
}
    // rust: assert_eq!(
    // rust: meta(r#"{"fusion": {"type": "random", "randomness_source": "position_axis"}}"#).kind,
    // rust: Kind::Random {
    // rust: columns: 1,
    // rust: rows: 1,
    // rust: source: RandomSource::PositionAxis,
    // rust: seed: None,
    // rust: sub_texture: None,
    // rust: per_tile_animation: false,
}
    // rust: );
    // rust: assert_eq!(
    // rust: meta(r#"{"fusion": {"type": "continuous"}}"#).kind,
    // rust: Kind::Continuous {
    // rust: columns: 1,
    // rust: rows: 1
}
    // rust: );
    // rust: assert_eq!(
    // rust: meta(r#"{"fusion": {"type": "scrolling"}}"#).kind,
    // rust: Kind::Scrolling(Scrolling {
    // rust: from: Corner::TopLeft,
    // rust: to: Corner::BottomLeft,
    // rust: frame_width: 16,
    // rust: frame_height: 16,
    // rust: frame_time: 10,
    // rust: loop_type: LoopType::Wrap,
    // rust: loop_pause: 0,
    // rust: })
    // rust: );
}

refuses_bad_values :: proc() {
}
    // rust: for bad in [
    // rust: r#"{"fusion": {"type": "random", "seed": 9007199254740993}}"#,
    // rust: r#"{"fusion": {"type": "random", "rows": 101}}"#,
    // rust: r#"{"fusion": {"type": "scrolling", "frame_time": 0}}"#,
    // rust: r#"{"fusion": {"type": "scrolling", "loop_pause": -1}}"#,
    // rust: r#"{"fusion": {"type": "connecting", "sub_texture": {"type": "random", "rows": 0}}}"#,
    // rust: r#"{"fusion": {"type": "glowing"}}"#,
    // rust: r#"{"fusion": "connecting"}"#,
    // rust: r#"{"fusion": {"type": "connecting", "sub_texture": "random"}}"#,
    // rust: r#"{"fusion": {"type": "connecting", "layout": "diagonal"}}"#,
    // rust: r#"{"fusion": {"type": "base", "emissive": "yes"}}"#,
    // rust: r#"{"fusion": {"type": "base", "render_type": "solid"}}"#,
    // rust: r#"{"fusion": {"type": "random", "rows": 0}}"#,
    // rust: r#"{"fusion": {"type": "continuous", "columns": 33}}"#,
    // rust: r#"{"fusion": {"type": "scrolling", "frame_width": 1.5}}"#,
    // rust: ] {
    // rust: assert!(Meta::from_mcmeta(bad).is_err(), "{bad}");
}
}
}
