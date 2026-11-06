//! Transpiled from Horizon Rust crate
package horizon_assets_item_model

import "core:fmt"
import "core:mem"
import "core:math"

// The 26.3 client item definitions (`assets/<ns>/items/*.json`): the model
// tree (`model`, `composite`, `condition`, `select`, `range_dispatch`,
// `special`, `bundle/selected_item`, `empty`), its properties and tints, and
// the resolver that turns one stack into render layers
// (`ItemModelResolver.updateForTopItem`).
//
// Baked geometry lives in [`crate::item_bake`]; this module decides *which*
// model, tints, foil and transformation each layer gets.
// use crate::{
    // rust: json::{DecodeError, error as err},
    // rust: math::{Mat4, normalize_quaternion, quaternion_from_axis_angle},
}
// use serde_json::{Map, Value};
// use std::{
    // rust: collections::BTreeMap,
    // rust: sync::{Arc, Mutex},
}

    // rust: mod component_predicate;
    // rust: mod foreign;
    // rust: mod special;
    // rust: pub use special::{SpecialKind, SpecialModel};

    // rust: type Result<T> = std::result::Result<T, DecodeError>;

// `BuiltInRegistries.DATA_COMPONENT_TYPE`, which `has_component` and the
// `component` select validate against (checked by the harness).
    // rust: pub const DATA_COMPONENT_TYPES: [&str; 122] = [
    // rust: "minecraft:additional_trade_cost",
    // rust: "minecraft:attack_animation",
    // rust: "minecraft:attack_range",
    // rust: "minecraft:attribute_modifiers",
    // rust: "minecraft:axolotl/variant",
    // rust: "minecraft:banner_patterns",
    // rust: "minecraft:base_color",
    // rust: "minecraft:bees",
    // rust: "minecraft:block_entity_data",
    // rust: "minecraft:block_state",
    // rust: "minecraft:block_transformer",
    // rust: "minecraft:blocks_attacks",
    // rust: "minecraft:break_sound",
    // rust: "minecraft:brewing_fuel",
    // rust: "minecraft:bucket_entity_data",
    // rust: "minecraft:bundle_contents",
    // rust: "minecraft:can_break",
    // rust: "minecraft:can_place_on",
    // rust: "minecraft:cat/collar",
    // rust: "minecraft:cat/sound_variant",
    // rust: "minecraft:cat/variant",
    // rust: "minecraft:charged_projectiles",
    // rust: "minecraft:chicken/sound_variant",
    // rust: "minecraft:chicken/variant",
    // rust: "minecraft:compostable",
    // rust: "minecraft:consumable",
    // rust: "minecraft:container",
    // rust: "minecraft:container_loot",
    // rust: "minecraft:cooking_fuel",
    // rust: "minecraft:cow/sound_variant",
    // rust: "minecraft:cow/variant",
    // rust: "minecraft:creative_slot_lock",
    // rust: "minecraft:cushion/color",
    // rust: "minecraft:custom_data",
    // rust: "minecraft:custom_model_data",
    // rust: "minecraft:custom_name",
    // rust: "minecraft:damage",
    // rust: "minecraft:damage_resistant",
    // rust: "minecraft:damage_type",
    // rust: "minecraft:death_protection",
    // rust: "minecraft:debug_stick_state",
    // rust: "minecraft:dye",
    // rust: "minecraft:dyed_color",
    // rust: "minecraft:enchantable",
    // rust: "minecraft:enchantment_glint_override",
    // rust: "minecraft:enchantments",
    // rust: "minecraft:entity_data",
    // rust: "minecraft:equippable",
    // rust: "minecraft:firework_explosion",
    // rust: "minecraft:fireworks",
    // rust: "minecraft:food",
    // rust: "minecraft:fox/variant",
    // rust: "minecraft:frog/variant",
    // rust: "minecraft:glider",
    // rust: "minecraft:horse/variant",
    // rust: "minecraft:instrument",
    // rust: "minecraft:intangible_projectile",
    // rust: "minecraft:interact_animation",
    // rust: "minecraft:item_model",
    // rust: "minecraft:item_name",
    // rust: "minecraft:jukebox_playable",
    // rust: "minecraft:kinetic_weapon",
    // rust: "minecraft:llama/variant",
    // rust: "minecraft:lock",
    // rust: "minecraft:lodestone_tracker",
    // rust: "minecraft:lore",
    // rust: "minecraft:map_decorations",
    // rust: "minecraft:map_id",
    // rust: "minecraft:map_post_processing",
    // rust: "minecraft:max_damage",
    // rust: "minecraft:max_stack_size",
    // rust: "minecraft:minimum_attack_charge",
    // rust: "minecraft:mob_visibility",
    // rust: "minecraft:mooshroom/variant",
    // rust: "minecraft:note_block_sound",
    // rust: "minecraft:ominous_bottle_amplifier",
    // rust: "minecraft:painting/variant",
    // rust: "minecraft:parrot/variant",
    // rust: "minecraft:piercing_weapon",
    // rust: "minecraft:pig/sound_variant",
    // rust: "minecraft:pig/variant",
    // rust: "minecraft:pot_decorations",
    // rust: "minecraft:potion_contents",
    // rust: "minecraft:potion_duration_scale",
    // rust: "minecraft:profile",
    // rust: "minecraft:provides_banner_patterns",
    // rust: "minecraft:provides_pottery_pattern",
    // rust: "minecraft:provides_trim_material",
    // rust: "minecraft:rabbit/variant",
    // rust: "minecraft:rarity",
    // rust: "minecraft:recipes",
    // rust: "minecraft:repair_cost",
    // rust: "minecraft:repairable",
    // rust: "minecraft:salmon/size",
    // rust: "minecraft:sheep/color",
    // rust: "minecraft:shulker/color",
    // rust: "minecraft:sign_text_back",
    // rust: "minecraft:sign_text_front",
    // rust: "minecraft:stored_enchantments",
    // rust: "minecraft:sulfur_cube_content",
    // rust: "minecraft:suspicious_stew_effects",
    // rust: "minecraft:tool",
    // rust: "minecraft:tooltip_display",
    // rust: "minecraft:tooltip_style",
    // rust: "minecraft:trim",
    // rust: "minecraft:tropical_fish/base_color",
    // rust: "minecraft:tropical_fish/pattern",
    // rust: "minecraft:tropical_fish/pattern_color",
    // rust: "minecraft:unbreakable",
    // rust: "minecraft:use_cooldown",
    // rust: "minecraft:use_effects",
    // rust: "minecraft:use_remainder",
    // rust: "minecraft:villager/variant",
    // rust: "minecraft:villager_food",
    // rust: "minecraft:waxed",
    // rust: "minecraft:weapon",
    // rust: "minecraft:wolf/collar",
    // rust: "minecraft:wolf/sound_variant",
    // rust: "minecraft:wolf/variant",
    // rust: "minecraft:writable_book_content",
    // rust: "minecraft:written_book_content",
    // rust: "minecraft:zombie_nautilus/variant",
    // rust: ];

// ---------------------------------------------------------------------------
// Display contexts
// ---------------------------------------------------------------------------

// `ItemDisplayContext`.
DisplayContext :: enum {
    None,
    ThirdPersonLeftHand,
    ThirdPersonRightHand,
    FirstPersonLeftHand,
    FirstPersonRightHand,
    Head,
    Gui,
    Ground,
    Fixed,
    OnShelf,
}
    // rust: impl DisplayContext {
    // rust: pub const ALL: [Self; 10] = [
    // rust: Self::None,
    // rust: Self::ThirdPersonLeftHand,
    // rust: Self::ThirdPersonRightHand,
    // rust: Self::FirstPersonLeftHand,
    // rust: Self::FirstPersonRightHand,
    // rust: Self::Head,
    // rust: Self::Gui,
    // rust: Self::Ground,
    // rust: Self::Fixed,
    // rust: Self::OnShelf,
    // rust: ];
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::None => "none",
    // rust: Self::ThirdPersonLeftHand => "thirdperson_lefthand",
    // rust: Self::ThirdPersonRightHand => "thirdperson_righthand",
    // rust: Self::FirstPersonLeftHand => "firstperson_lefthand",
    // rust: Self::FirstPersonRightHand => "firstperson_righthand",
    // rust: Self::Head => "head",
    // rust: Self::Gui => "gui",
    // rust: Self::Ground => "ground",
    // rust: Self::Fixed => "fixed",
    // rust: Self::OnShelf => "on_shelf",
}
}
by_name :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|c| c.name() == name)
}
    // `ItemDisplayContext.leftHand`.
left_hand :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Self::ThirdPersonLeftHand | Self::FirstPersonLeftHand)
}
}

// ---------------------------------------------------------------------------
// Decoding helpers (DataFixerUpper `JsonOps` semantics)
// ---------------------------------------------------------------------------

object :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: v.as_object().ok_or_else(|| err("expected object"))
}
// A present, non-null field (`JsonOps` maps `null` to an absent key).
    // rust: fn get<'a>(m: &'a Map<String, Value>, key: &str) -> Option<&'a Value> {
    // rust: m.get(key).filter(|v| !v.is_null())
}
    // rust: fn required<'a>(m: &'a Map<String, Value>, key: &str) -> Result<&'a Value> {
    // rust: get(m, key).ok_or_else(|| err(&format!("missing {key}")))
}
// `Codec.FLOAT`: numbers, and booleans as 1 and 0.
float :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Number(n) => n
    // rust: .to_string()
    // rust: .parse()
    // rust: .or_else(|_| n.as_f64().map(|f| f as f32).ok_or(()))
    // rust: .map_err(|()| err("invalid float")),
    // rust: _ => Err(err("expected float")),
}
}
// `Codec.INT`: `Number.intValue`, truncating toward zero and saturating
// like a Java narrowing of a double (longs keep their low 32 bits).
int :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Number(n) => {
    // rust: if let Some(i) = n.as_i64() {
    // rust: Ok(i as i32)
    // rust: } else if let Some(u) = n.as_u64() {
    // rust: Ok(u as i32)
    // rust: } else {
    // rust: Ok(n.as_f64().ok_or_else(|| err("invalid int"))? as i32)
}
}
    // rust: _ => Err(err("expected int")),
}
}
boolean :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: v.as_bool().ok_or_else(|| err("expected boolean"))
}
string :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: v.as_str()
    // rust: .map(str::to_owned)
    // rust: .ok_or_else(|| err("expected string"))
}
list :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: v.as_array().ok_or_else(|| err("expected list"))
}
// `Identifier.CODEC`: a lowercase `namespace:path`, defaulting the namespace.
identifier :: proc(name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (namespace, path) = match name.split_once(':') {
    // rust: Some((n, p)) => (if n.is_empty() { "minecraft" } else { n }, p),
    // rust: None => ("minecraft", name),
}
    // rust: let valid = |c: u8| c.is_ascii_lowercase() || c.is_ascii_digit() || b"_.-".contains(&c);
    // rust: if path.contains(':')
    // rust: || !namespace.bytes().all(valid)
    // rust: || !path.bytes().all(|c| valid(c) || c == b'/')
    // rust: {
    // rust: return Err(err("invalid resource identifier"));
}
    // rust: Ok(format!("{namespace}:{path}"))
}
ident :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: identifier(&string(v)?)
}
component_type :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = ident(v)?;
    // rust: if DATA_COMPONENT_TYPES.contains(&id.as_str()) {
    // rust: Ok(id)
    // rust: } else {
    // rust: Err(err("unknown data component type"))
}
}
    // rust: fn vector<const N: usize>(v: &Value) -> Result<[f32; N]> {
    // rust: let values = list(v)?;
    // rust: if values.len() != N {
    // rust: return Err(err("wrong vector length"));
}
    // rust: let mut out = [0.0; N];
    // rust: for (o, v) in out.iter_mut().zip(values) {
    // rust: *o = float(v)?;
}
    // rust: Ok(out)
}
non_negative :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let i = int(v)?;
    // rust: if i < 0 {
    // rust: return Err(err("value must be non-negative"));
}
    // rust: Ok(i)
}
// `ExtraCodecs.RGB_COLOR_CODEC`: an int, or three floats in 0..1.
rgb :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_array() {
    // rust: let [r, g, b] = vector::<3>(v)?;
    // rust: return Ok(argb(255, channel(r), channel(g), channel(b)));
}
    // rust: int(v)
}
argb :: proc(a: i32, r: i32, g: i32, b: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (a & 255) << 24 | (r & 255) << 16 | (g & 255) << 8 | (b & 255)
}
opaque :: proc(color: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: color | (0xFF00_0000u32 as i32)
}

// `Transformation.EXTENDED_CODEC`.
transformation :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_array() {
    // rust: return Ok(Mat4::from_row_major(vector::<16>(v)?));
}
    // rust: let m = object(v)?;
    // rust: let quaternion = |v: &Value| -> Result<[f32; 4]> {
    // rust: if v.is_array() {
    // rust: return Ok(normalize_quaternion(vector::<4>(v)?));
}
    // rust: let o = object(v)?;
    // rust: Ok(quaternion_from_axis_angle(
    // rust: float(required(o, "angle")?)?,
    // rust: vector::<3>(required(o, "axis")?)?,
    // rust: ))
}
    // rust: let translation = vector::<3>(required(m, "translation")?)?;
    // rust: let left = quaternion(required(m, "left_rotation")?)?;
    // rust: let scale = vector::<3>(required(m, "scale")?)?;
    // rust: let right = quaternion(required(m, "right_rotation")?)?;
    // rust: Ok(Mat4::translation(translation)
    // rust: .rotate(left)
    // rust: .scale(scale)
    // rust: .rotate(right))
}
optional_transformation :: proc(m: ^Map<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: get(m, "transformation").map(transformation).transpose()
}
// `Mth.floor(float)` as `ARGB.as8BitChannel` uses it.
// `ARGB.as8BitChannel`: `Mth.floor(value * 255.0F)`.
channel :: proc(v: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let scaled = v * 255.0;
    // rust: let i = scaled as i32;
    // rust: if (i as f32) > scaled { i - 1 } else { i }
}

// ---------------------------------------------------------------------------
// The model tree
// ---------------------------------------------------------------------------

// One `items/<name>.json` file: a model tree plus the client properties.
ClientItem :: struct {
    model: ItemModelNode,
    hand_animation_on_swap: bool,
    oversized_in_gui: bool,
    swap_animation_scale: f32,
}
    // rust: impl ClientItem {
DEFAULT_PROPERTIES :: (true, false, 1.0)
from_json :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let value: Value = serde_json::from_str(text.strip_prefix('\u{feff}').unwrap_or(text))?;
    // rust: Self::decode(&value)
}
decode :: proc(value: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let m = object(value)?;
    // rust: Ok(Self {
    // rust: model: ItemModelNode::decode(required(m, "model")?)?,
    // rust: hand_animation_on_swap: get(m, "hand_animation_on_swap").map_or(Ok(true), boolean)?,
    // rust: oversized_in_gui: get(m, "oversized_in_gui").map_or(Ok(false), boolean)?,
    // rust: swap_animation_scale: get(m, "swap_animation_scale").map_or(Ok(1.0), float)?,
    // rust: })
}
}

ModelLeaf :: struct {
    model: string,
    transformation: Maybe(Mat4),
    tints: [dynamic]TintSource,
}
ItemModelNode :: enum {
    Empty,
    Model(ModelLeaf),
    Composite {,
    models: Vec<ItemModelNode>,
    transformation: Option<Mat4>,
    // rust: },
    Condition {,
    transformation: Option<Mat4>,
    property: ConditionProperty,
    on_true: Box<ItemModelNode>,
    on_false: Box<ItemModelNode>,
    // rust: },
    Select {,
    transformation: Option<Mat4>,
    property: SelectProperty,
    cases: Vec<SwitchCase>,
    fallback: Option<Box<ItemModelNode>>,
    // rust: },
    RangeDispatch {,
    transformation: Option<Mat4>,
    property: NumericProperty,
    scale: f32,
        // Sorted by threshold (a stable sort, as `bake` does).
    entries: Vec<(f32, ItemModelNode)>,
    fallback: Option<Box<ItemModelNode>>,
    // rust: },
    Special {,
    base: String,
    transformation: Option<Mat4>,
    model: SpecialModel,
    // rust: },
    BundleSelectedItem,
}
SwitchCase :: struct {
    // Property values, in their canonical JSON form.
    values: [dynamic]Value,
    model: ItemModelNode,
}

    // rust: impl ItemModelNode {
decode :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let m = object(v)?;
    // rust: let kind = ident(required(m, "type")?)?;
    // rust: if kind == "minecraft:condition" {
    // rust: let property = ident(required(m, "property")?)?;
    // rust: if !property.starts_with("minecraft:") {
    // rust: return Ok(Self::Condition {
    // rust: transformation: optional_transformation(m)?,
    // rust: property: ConditionProperty::Custom(property),
    // rust: on_true: Box::new(Self::decode(required(m, "on_true")?)?),
    // rust: on_false: Box::new(Self::decode(required(m, "on_false")?)?),
    // rust: });
}
}
    // rust: Ok(match kind.as_str() {
    // rust: "minecraft:empty" => Self::Empty,
    // rust: "minecraft:model" => Self::Model(ModelLeaf {
    // rust: model: ident(required(m, "model")?)?,
    // rust: transformation: optional_transformation(m)?,
    // rust: tints: match get(m, "tints") {
    // rust: None => Vec::new(),
    // rust: Some(t) => list(t)?
    // rust: .iter()
    // rust: .map(TintSource::decode)
    // rust: .collect::<Result<_>>()?,
    // rust: },
    // rust: }),
    // rust: "minecraft:composite" => Self::Composite {
    // rust: models: list(required(m, "models")?)?
    // rust: .iter()
    // rust: .map(Self::decode)
    // rust: .collect::<Result<_>>()?,
    // rust: transformation: optional_transformation(m)?,
    // rust: },
    // rust: "minecraft:condition" if foreign::property_is_foreign(m)? => foreign::wrap(
    // rust: Self::decode(required(m, "on_false")?)?,
    // rust: optional_transformation(m)?,
    // rust: ),
    // rust: "minecraft:condition" => Self::Condition {
    // rust: transformation: optional_transformation(m)?,
    // rust: property: ConditionProperty::decode(m)?,
    // rust: on_true: Box::new(Self::decode(required(m, "on_true")?)?),
    // rust: on_false: Box::new(Self::decode(required(m, "on_false")?)?),
    // rust: },
    // rust: "minecraft:select" if foreign::property_is_foreign(m)? => {
                // No case can match a property Horizon cannot read.
    // rust: let fallback = get(m, "fallback").map(Self::decode).transpose()?;
    // rust: foreign::wrap(fallback.unwrap_or(Self::Empty), optional_transformation(m)?)
}
    // rust: "minecraft:select" => {
    // rust: let transformation = optional_transformation(m)?;
    // rust: let property = SelectProperty::decode(m)?;
    // rust: let cases = list(required(m, "cases")?)?
    // rust: .iter()
    // rust: .map(|c| SwitchCase::decode(&property, c))
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: if cases.is_empty() {
    // rust: return Err(err("empty case list"));
}
    // rust: let mut seen: Vec<&Value> = Vec::new();
    // rust: for value in cases.iter().flat_map(|c| &c.values) {
    // rust: if seen.contains(&value) {
    // rust: return Err(err("duplicate case conditions"));
}
    // rust: seen.push(value);
}
    // rust: Self::Select {
    // rust: transformation,
    // rust: property,
    // rust: cases,
    // rust: fallback: get(m, "fallback")
    // rust: .map(|f| Self::decode(f).map(Box::new))
    // rust: .transpose()?,
}
}
    // rust: "minecraft:range_dispatch" => {
    // rust: let foreign_property = foreign::property_is_foreign(m)?;
    // rust: let mut entries = list(required(m, "entries")?)?
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let e = object(e)?;
    // rust: Ok((
    // rust: float(required(e, "threshold")?)?,
    // rust: Self::decode(required(e, "model")?)?,
    // rust: ))
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
                // `Comparator.comparingDouble`: Double.compare, a total order.
    // rust: entries.sort_by(|a, b| f64::from(a.0).total_cmp(&f64::from(b.0)));
    // rust: if foreign_property {
                    // A property Horizon cannot read is 0.
    // rust: let fallback = get(m, "fallback").map(Self::decode).transpose()?;
    // rust: let chosen = last_index_less_or_equal(&entries, 0.0)
    // rust: .map(|i| entries.swap_remove(i).1)
    // rust: .or(fallback);
    // rust: return Ok(foreign::wrap(
    // rust: chosen.unwrap_or(Self::Empty),
    // rust: optional_transformation(m)?,
    // rust: ));
}
    // rust: Self::RangeDispatch {
    // rust: transformation: optional_transformation(m)?,
    // rust: property: NumericProperty::decode(m)?,
    // rust: scale: get(m, "scale").map_or(Ok(1.0), float)?,
    // rust: entries,
    // rust: fallback: get(m, "fallback")
    // rust: .map(|f| Self::decode(f).map(Box::new))
    // rust: .transpose()?,
}
}
    // rust: "minecraft:special" if SpecialModel::is_foreign(required(m, "model")?) => {
                // The mod's own renderer is not run: the base model stands in.
    // rust: Self::Model(ModelLeaf {
    // rust: model: ident(required(m, "base")?)?,
    // rust: transformation: optional_transformation(m)?,
    // rust: tints: Vec::new(),
    // rust: })
}
    // rust: "minecraft:special" => Self::Special {
    // rust: base: ident(required(m, "base")?)?,
    // rust: transformation: optional_transformation(m)?,
    // rust: model: SpecialModel::decode(required(m, "model")?)?,
    // rust: },
    // rust: "minecraft:bundle/selected_item" => Self::BundleSelectedItem,
    // rust: other if foreign::is_foreign(other) => foreign::decode_node(other, m),
    // rust: _ => return Err(err("unknown item model type")),
    // rust: })
}
    // Every model resource id the tree can ask for.
dependencies :: proc(self: ^Self, out: ^[dynamic]string) {
}
    // rust: match self {
    // rust: Self::Empty | Self::BundleSelectedItem => {}
    // rust: Self::Model(leaf) => out.push(leaf.model.clone()),
    // rust: Self::Composite { models, .. } => models.iter().for_each(|m| m.dependencies(out)),
    // rust: Self::Condition {
    // rust: on_true, on_false, ..
    // rust: } => {
    // rust: on_true.dependencies(out);
    // rust: on_false.dependencies(out);
}
    // rust: Self::Select {
    // rust: cases, fallback, ..
    // rust: } => {
    // rust: cases.iter().for_each(|c| c.model.dependencies(out));
    // rust: fallback.iter().for_each(|f| f.dependencies(out));
}
    // rust: Self::RangeDispatch {
    // rust: entries, fallback, ..
    // rust: } => {
    // rust: entries.iter().for_each(|(_, m)| m.dependencies(out));
    // rust: fallback.iter().for_each(|f| f.dependencies(out));
}
    // rust: Self::Special { base, .. } => out.push(base.clone()),
}
}
}
    // rust: impl SwitchCase {
decode :: proc(property: ^SelectProperty, v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let m = object(v)?;
    // rust: let when = required(m, "when")?;
        // `compactListCodec`: a list, or one value; the list must not be empty.
    // rust: let raw: Vec<&Value> = match when {
    // rust: Value::Array(a) if !a.is_empty() => a.iter().collect(),
    // rust: Value::Array(_) => return Err(err("list must have contents")),
    // rust: single => vec![single],
}
    // rust: Ok(Self {
    // rust: values: raw
    // rust: .into_iter()
    // rust: .map(|v| property.decode_value(v))
    // rust: .collect::<Result<_>>()?,
    // rust: model: ItemModelNode::decode(required(m, "model")?)?,
    // rust: })
}
}

// ---------------------------------------------------------------------------
// Tint sources
// ---------------------------------------------------------------------------

TintSource :: enum {
    Constant(i32),
    CustomModelData { index: i32, default: i32 },
    Dye(i32),
    Grass { temperature: f32, downfall: f32 },
    Firework(i32),
    Potion(i32),
    Team(i32),
}
    // rust: impl TintSource {
decode :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let m = object(v)?;
    // rust: let default = || rgb(required(m, "default")?);
    // rust: let unit = |v: &Value| -> Result<f32> {
    // rust: let f = float(v)?;
    // rust: if (0.0..=1.0).contains(&f) {
    // rust: Ok(f)
    // rust: } else {
    // rust: Err(err("value must be within range [0;1]"))
}
}
    // rust: Ok(match ident(required(m, "type")?)?.as_str() {
    // rust: "minecraft:constant" => Self::Constant(opaque(rgb(required(m, "value")?)?)),
    // rust: "minecraft:custom_model_data" => Self::CustomModelData {
    // rust: index: get(m, "index").map_or(Ok(0), non_negative)?,
    // rust: default: default()?,
    // rust: },
    // rust: "minecraft:dye" => Self::Dye(default()?),
    // rust: "minecraft:grass" => Self::Grass {
    // rust: temperature: unit(required(m, "temperature")?)?,
    // rust: downfall: unit(required(m, "downfall")?)?,
    // rust: },
    // rust: "minecraft:firework" => Self::Firework(default()?),
    // rust: "minecraft:potion" => Self::Potion(default()?),
    // rust: "minecraft:team" => Self::Team(default()?),
            // A mod's own tint source, which its Java code computes: untinted here.
    // rust: other if foreign::is_foreign(other) => Self::Constant(-1),
    // rust: _ => return Err(err("unknown item tint source")),
    // rust: })
}
}

// ---------------------------------------------------------------------------
// Properties
// ---------------------------------------------------------------------------

ConditionProperty :: enum {
    Custom(String),
    CustomModelData(i32),
    UsingItem,
    Broken,
    Damaged,
    FishingRodCast,
    HasComponent {,
    component: String,
    ignore_default: bool,
    // rust: },
    BundleHasSelectedItem,
    Selected,
    Carried,
    ExtendedView,
    KeybindDown(String),
    ViewEntity,
    // A single `component` predicate; external predicate types use the host.
    Component(Value),
}
    // rust: impl ConditionProperty {
decode :: proc(m: ^Map<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match ident(required(m, "property")?)?.as_str() {
    // rust: "minecraft:custom_model_data" => {
    // rust: Self::CustomModelData(get(m, "index").map_or(Ok(0), non_negative)?)
}
    // rust: "minecraft:using_item" => Self::UsingItem,
    // rust: "minecraft:broken" => Self::Broken,
    // rust: "minecraft:damaged" => Self::Damaged,
    // rust: "minecraft:fishing_rod/cast" => Self::FishingRodCast,
    // rust: "minecraft:has_component" => Self::HasComponent {
    // rust: component: component_type(required(m, "component")?)?,
    // rust: ignore_default: get(m, "ignore_default").map_or(Ok(false), boolean)?,
    // rust: },
    // rust: "minecraft:bundle/has_selected_item" => Self::BundleHasSelectedItem,
    // rust: "minecraft:selected" => Self::Selected,
    // rust: "minecraft:carried" => Self::Carried,
    // rust: "minecraft:extended_view" => Self::ExtendedView,
    // rust: "minecraft:keybind_down" => Self::KeybindDown(string(required(m, "keybind")?)?),
    // rust: "minecraft:view_entity" => Self::ViewEntity,
    // rust: "minecraft:component" => Self::Component(component_predicate::decode(m)?),
    // rust: _ => return Err(err("unknown condition property")),
    // rust: })
}
}

SelectProperty :: enum {
    CustomModelData(i32),
    MainHand,
    ChargeType,
    TrimMaterial,
    BlockState(String),
    DisplayContext,
    LocalTime {,
    pattern: String,
    locale: String,
    time_zone: Option<String>,
    // rust: },
    ContextEntityType,
    ContextDimension,
    Component(String),
}
    // rust: impl SelectProperty {
decode :: proc(m: ^Map<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match ident(required(m, "property")?)?.as_str() {
    // rust: "minecraft:custom_model_data" => {
    // rust: Self::CustomModelData(get(m, "index").map_or(Ok(0), non_negative)?)
}
    // rust: "minecraft:main_hand" => Self::MainHand,
    // rust: "minecraft:charge_type" => Self::ChargeType,
    // rust: "minecraft:trim_material" => Self::TrimMaterial,
    // rust: "minecraft:block_state" => {
    // rust: Self::BlockState(string(required(m, "block_state_property")?)?)
}
    // rust: "minecraft:display_context" => Self::DisplayContext,
    // rust: "minecraft:local_time" => Self::LocalTime {
    // rust: pattern: string(required(m, "pattern")?)?,
    // rust: locale: get(m, "locale").map_or(Ok(String::new()), string)?,
    // rust: time_zone: get(m, "time_zone").map(string).transpose()?,
    // rust: },
    // rust: "minecraft:context_entity_type" => Self::ContextEntityType,
    // rust: "minecraft:context_dimension" => Self::ContextDimension,
    // rust: "minecraft:component" => Self::Component(component_type(required(m, "component")?)?),
    // rust: _ => return Err(err("unknown select property")),
    // rust: })
}
    // A `when` value in canonical form (identifiers normalised).
decode_value :: proc(self: ^Self, v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match self {
    // rust: Self::CustomModelData(_) | Self::BlockState(_) | Self::LocalTime { .. } => {
    // rust: Value::String(string(v)?)
}
    // rust: Self::MainHand => match string(v)?.as_str() {
    // rust: s @ ("left" | "right") => Value::String(s.to_owned()),
    // rust: _ => return Err(err("invalid arm")),
    // rust: },
    // rust: Self::ChargeType => match string(v)?.as_str() {
    // rust: s @ ("none" | "rocket" | "arrow") => Value::String(s.to_owned()),
    // rust: _ => return Err(err("invalid charge type")),
    // rust: },
    // rust: Self::TrimMaterial | Self::ContextEntityType | Self::ContextDimension => {
    // rust: Value::String(ident(v)?)
}
    // rust: Self::DisplayContext => {
    // rust: let s = string(v)?;
    // rust: DisplayContext::by_name(&s).ok_or_else(|| err("invalid display context"))?;
    // rust: Value::String(s)
}
    // rust: Self::Component(_) => v.clone(),
    // rust: })
}
}

CompassTarget :: enum {
    None,
    Lodestone,
    Spawn,
    Recovery,
}
TimeSource :: enum {
    Random,
    Daytime,
    MoonPhase,
}
// A `NeedleDirectionHelper.Wobbler`.
Wobbler :: struct {
    rotation: f32,
    delta_rotation: f32,
    last_update_tick: i64,
    // Without wobble the needle jumps straight to its target.
    target: f32,
}
    // rust: impl Wobbler {
should_update :: proc(self: ^Self, wobble: bool, tick: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !wobble || self.last_update_tick != tick
}
update :: proc(self: ^Self, wobble: bool, factor: f32, tick: i64, target_rotation: f32) {
}
    // rust: if !wobble {
    // rust: self.target = target_rotation;
    // rust: return;
}
    // rust: self.last_update_tick = tick;
    // rust: let temp = positive_modulo(target_rotation - self.rotation + 0.5, 1.0) - 0.5;
    // rust: self.delta_rotation += temp * 0.1;
    // rust: self.delta_rotation *= factor;
    // rust: self.rotation = positive_modulo(self.rotation + self.delta_rotation, 1.0);
}
value :: proc(self: ^Self, wobble: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if wobble { self.rotation } else { self.target }
}
}
// `Mth.positiveModulo(float, float)`.
positive_modulo :: proc(input: f32, modulus: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (input % modulus + modulus) % modulus
}
// The mutable state a baked `compass` or `time` property keeps.
NeedleState :: struct {
    // rust: impl Clone for NeedleState {
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    Self: :default(),
}
}
    // rust: impl PartialEq for NeedleState {
eq :: proc(self: ^Self, _: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
}

NumericProperty :: enum {
    BundleFullness,
    Compass {,
    wobble: bool,
    target: CompassTarget,
    state: Arc<NeedleState>,
    // rust: },
    Cooldown,
    Count {,
    normalize: bool,
    // rust: },
    CrossbowPull,
    CustomModelData(i32),
    Damage {,
    normalize: bool,
    // rust: },
    Time {,
    wobble: bool,
    source: TimeSource,
    state: Arc<NeedleState>,
    // rust: },
    UseCycle(f32),
    UseDuration {,
    remaining: bool,
    // rust: },
}
    // rust: impl NumericProperty {
decode :: proc(m: ^Map<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let normalize = || get(m, "normalize").map_or(Ok(true), boolean);
    // rust: Ok(match ident(required(m, "property")?)?.as_str() {
    // rust: "minecraft:custom_model_data" => {
    // rust: Self::CustomModelData(get(m, "index").map_or(Ok(0), non_negative)?)
}
    // rust: "minecraft:bundle/fullness" => Self::BundleFullness,
    // rust: "minecraft:damage" => Self::Damage {
    // rust: normalize: normalize()?,
    // rust: },
    // rust: "minecraft:cooldown" => Self::Cooldown,
    // rust: "minecraft:time" => Self::Time {
    // rust: wobble: get(m, "wobble").map_or(Ok(true), boolean)?,
    // rust: source: match string(required(m, "source")?)?.as_str() {
    // rust: "random" => TimeSource::Random,
    // rust: "daytime" => TimeSource::Daytime,
    // rust: "moon_phase" => TimeSource::MoonPhase,
    // rust: _ => return Err(err("invalid time source")),
    // rust: },
    // rust: state: Arc::default(),
    // rust: },
    // rust: "minecraft:compass" => Self::Compass {
    // rust: wobble: get(m, "wobble").map_or(Ok(true), boolean)?,
    // rust: target: match string(required(m, "target")?)?.as_str() {
    // rust: "none" => CompassTarget::None,
    // rust: "lodestone" => CompassTarget::Lodestone,
    // rust: "spawn" => CompassTarget::Spawn,
    // rust: "recovery" => CompassTarget::Recovery,
    // rust: _ => return Err(err("invalid compass target")),
    // rust: },
    // rust: state: Arc::default(),
    // rust: },
    // rust: "minecraft:crossbow/pull" => Self::CrossbowPull,
    // rust: "minecraft:use_cycle" => {
    // rust: let period = get(m, "period").map_or(Ok(1.0), float)?;
    // rust: if period.partial_cmp(&0.0) != Some(std::cmp::Ordering::Greater) {
    // rust: return Err(err("value must be positive"));
}
    // rust: Self::UseCycle(period)
}
    // rust: "minecraft:use_duration" => Self::UseDuration {
    // rust: remaining: get(m, "remaining").map_or(Ok(false), boolean)?,
    // rust: },
    // rust: "minecraft:count" => Self::Count {
    // rust: normalize: normalize()?,
    // rust: },
    // rust: _ => return Err(err("unknown range dispatch property")),
    // rust: })
}
}

// ---------------------------------------------------------------------------
// Stacks and the world around them
// ---------------------------------------------------------------------------

// The item components a stack carries: a prototype plus an explicit patch
// (`None` removes a prototype component).
    // rust: pub type Components = BTreeMap<String, Value>;

// An item stack as the resolver reads it.
StackView :: struct {
    item: string,
    count: i32,
    patch: BTreeMap<string,
    // `BundleContents.selectedItem`, a runtime-only index (-1: none).
    bundle_selected: i32,
}
    // rust: impl StackView {
new :: proc(item: string, count: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: item: item.to_owned(),
    // rust: count,
    // rust: patch: BTreeMap::new(),
    // rust: bundle_selected: -1,
}
}
}

// `ArmorTrim`/`LodestoneTracker`-style positions are plain data.
GlobalPos :: struct {
    dimension: string,
    pos: [i32,
}
// The living entity holding the item (`ItemOwner`).
OwnerState :: struct {
    position: [f64,
    visual_rotation_y_degrees: f32,
    entity_type: string,
    main_arm_left: bool,
    // `isUsingItem() && getUseItem() == stack`.
    using_this_item: bool,
    use_item_remaining_ticks: i32,
    // `stack.getUseDuration(owner)`.
    use_duration: i32,
    // `CrossbowItem.getChargeDuration(stack, owner)`.
    crossbow_charge_duration: i32,
    fishing_cast_with_this_item: bool,
    is_selected: bool,
    is_carried: bool,
    is_view_entity: bool,
    team_color: Maybe(i32),
    // `ItemCooldowns.getCooldownPercent(stack, 0)`.
    cooldown_percent: f32,
    is_local_player: bool,
    last_death_location: Maybe(GlobalPos),
}
// The `ClientLevel` an item is drawn in.
LevelState :: struct {
    dimension: string,
    game_time: i64,
    // `EnvironmentAttributes.SUN_ANGLE` at the owner, in degrees.
    sun_angle: f32,
    // `EnvironmentAttributes.MOON_PHASE` index at the owner.
    moon_phase: i32,
    respawn: Maybe(GlobalPos),
    // `tickRateManager().runsNormally()`.
    runs_normally: bool,
}
// Everything about the surroundings that is not in the stack.
Context :: struct {
    display: DisplayContext,
    owner: Maybe(^'a OwnerState),
    level: Maybe(^'a LevelState),
    seed: i32,
}

// Host services the resolver cannot derive from data alone.
    // rust: pub trait ItemEnv {
    // A mod's namespaced conditional property, false when no mod supplies it.
item_model_property :: proc(self: ^Self, _property: string, _stack: ^StackView) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `PotionContents.getColorOr` for the potion/effects part: the mixed
    // effect colour, or `None` when the contents have no visible effects.
potion_effect_color :: proc(self: ^Self, _potion_contents: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // `GrassColor.get(temperature, downfall)`.
grass_color :: proc(self: ^Self, _temperature: f64, _downfall: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: -65281
}
    // `BundleItem.getFullnessDisplay`.
bundle_fullness :: proc(self: ^Self, _stack: ^StackView, _components: ^Components) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.0
}
    // Additional component predicate types supplied by the host.
component_matches :: proc(self: ^Self, _stack: ^StackView, _predicate: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // Membership in the level's enchantment registry tags.
enchantment_in_tag :: proc(self: ^Self, _enchantment: string, _tag: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
is_keybind_down :: proc(self: ^Self, _keybind: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
has_shift_down :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `LocalTime`: the formatted current time for a pattern.
local_time :: proc(self: ^Self, _pattern: string, _locale: string, _time_zone: Maybe(string)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: String::new()
}
    // A random float for `time` (random source) and the spinning compass.
random_float :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.0
}
}
// An [`ItemEnv`] with the trait defaults.
NoEnv :: struct {
    // rust: impl ItemEnv for NoEnv {}

// ---------------------------------------------------------------------------
// Resolution
// ---------------------------------------------------------------------------

FoilType :: enum {
    None,
    Standard,
    Special,
}
LayerContent :: enum {
    // A cuboid model resource, baked by [`crate::item_bake`].
    Model { model: String },
    // `MissingItemModel`.
    Missing,
    Special {,
    base: String,
    model: SpecialModel,
        // What `extractArgument` reads from the stack.
    argument: Value,
    // rust: },
}
Layer :: struct {
    content: LayerContent,
    tints: [dynamic]i32,
    foil: FoilType,
    transform: Mat4,
}
ResolvedItem :: struct {
    layers: [dynamic]Layer,
    oversized_in_gui: bool,
}

// All item definitions and the default components of every item.
ItemModels :: struct {
    definitions: BTreeMap<string,
    prototypes: BTreeMap<string,
}

    // rust: impl ItemModels {
    // The stack's components: its item's defaults with the stack's patch on top. A stack
    // with no patch (most stacks a screen draws) borrows the defaults instead of copying them.
components :: proc(self: ^Self, stack: ^StackView) -> s {
    // Ported from Horizon
    return {}
}
NONE :: BTreeMap::new()
    // rust: let prototype = self.prototypes.get(&stack.item).unwrap_or(&NONE);
    // rust: if stack.patch.is_empty() {
    // rust: return std::borrow::Cow::Borrowed(prototype);
}
    // rust: let mut out = prototype.clone();
    // rust: for (key, value) in &stack.patch {
    // rust: match value {
    // rust: Some(v) => out.insert(key.clone(), v.clone()),
    // rust: None => out.remove(key),
}
}
    // rust: std::borrow::Cow::Owned(out)
}
    // `ItemModelResolver.updateForTopItem`.
resolve :: proc(self: ^Self, stack: ^StackView, ctx: ^Context, env: ^dyn ItemEnv) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = ResolvedItem::default();
    // rust: if stack.count > 0 && stack.item != "minecraft:air" {
    // rust: self.append_layers(&mut out, stack, ctx, env);
}
    // rust: out
}
    // `ItemModelResolver.appendItemLayers`.
    // rust: pub fn append_layers(
    // rust: &self,
    // rust: out: &mut ResolvedItem,
    // rust: stack: &StackView,
    // rust: ctx: &Context,
    // rust: env: &dyn ItemEnv,
    // rust: ) {
    // rust: let components = self.components(stack);
    // rust: let Some(Value::String(model_id)) = components.get("minecraft:item_model") else {
    // rust: return;
}
    // rust: let id = identifier(model_id).unwrap_or_else(|_| model_id.clone());
    // rust: let definition = self.definitions.get(&id);
    // rust: out.oversized_in_gui = definition.is_some_and(|d| d.oversized_in_gui);
    // rust: let mut state = Resolve {
    // rust: models: self,
    // rust: stack,
    // rust: components: &components,
    // rust: ctx,
    // rust: env,
}
    // rust: match definition {
    // rust: Some(d) => state.node(out, &d.model, &Mat4::IDENTITY),
    // rust: None => state.missing(out, &Mat4::IDENTITY),
}
}
    // `ItemModelResolver.shouldPlaySwapAnimation`.
hand_animation_on_swap :: proc(self: ^Self, stack: ^StackView) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.properties(stack).0
}
    // `ItemModelResolver.swapAnimationScale`.
swap_animation_scale :: proc(self: ^Self, stack: ^StackView) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.properties(stack).2
}
properties :: proc(self: ^Self, stack: ^StackView) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self.components(stack).get("minecraft:item_model") {
    // rust: Some(Value::String(id)) => identifier(id)
    // rust: .ok()
    // rust: .and_then(|id| self.definitions.get(&id))
    // rust: .map_or(ClientItem::DEFAULT_PROPERTIES, |d| {
    // rust: (
    // rust: d.hand_animation_on_swap,
    // rust: d.oversized_in_gui,
    // rust: d.swap_animation_scale,
    // rust: )
    // rust: }),
    // rust: _ => ClientItem::DEFAULT_PROPERTIES,
}
}
}

Resolve :: struct {
    models: ^'a ItemModels,
    stack: ^'a StackView,
    components: ^'a Components,
    ctx: ^'a Context<'a>,
    env: ^'a dyn ItemEnv,
}

compose :: proc(parent: ^Mat4, own: ^Maybe(Mat4)) -> M {
    // Ported from Horizon
    return {}
}
    // rust: own.as_ref().map_or(*parent, |t| parent.mul(t))
}

    // rust: impl Resolve<'_> {
component :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.components.get(key)
}
has_foil :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(v) = self.component("minecraft:enchantment_glint_override") {
    // rust: return v.as_bool().unwrap_or(false);
}
    // rust: let enchanted = self
    // rust: .component("minecraft:enchantments")
    // rust: .is_some_and(enchantments_present);
    // rust: enchanted
    // rust: || (self.stack.item == "minecraft:compass"
    // rust: && self.component("minecraft:lodestone_tracker").is_some())
}
damageable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.component("minecraft:max_damage").is_some()
    // rust: && self.component("minecraft:unbreakable").is_none()
    // rust: && self.component("minecraft:damage").is_some()
}
max_damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.component("minecraft:max_damage")
    // rust: .and_then(|v| int(v).ok())
    // rust: .unwrap_or(0)
}
damage_value :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let d = self
    // rust: .component("minecraft:damage")
    // rust: .and_then(|v| int(v).ok())
    // rust: .unwrap_or(0);
        // `Mth.clamp(int, 0, max)`
    // rust: if d < 0 { 0 } else { d.min(self.max_damage()) }
}
max_stack_size :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.component("minecraft:max_stack_size")
    // rust: .and_then(|v| int(v).ok())
    // rust: .unwrap_or(1)
}
missing :: proc(self: ^Self, out: ^ResolvedItem, transform: ^Mat4) {
}
    // rust: out.layers.push(Layer {
    // rust: content: LayerContent::Missing,
    // rust: tints: Vec::new(),
    // rust: foil: FoilType::None,
    // rust: transform: *transform,
    // rust: });
}
node :: proc(self: ^Self, out: ^ResolvedItem, node: ^ItemModelNode, parent: ^Mat4) {
}
    // rust: match node {
    // rust: ItemModelNode::Empty => {}
    // rust: ItemModelNode::Model(leaf) => {
    // rust: let transform = compose(parent, &leaf.transformation);
    // rust: let foil = if self.has_foil() {
    // rust: if matches!(self.stack.item.as_str(), "minecraft:clock")
    // rust: || self.item_in_compass_tag()
    // rust: {
    // rust: FoilType::Special
    // rust: } else {
    // rust: FoilType::Standard
}
    // rust: } else {
    // rust: FoilType::None
}
    // rust: let tints = leaf.tints.iter().map(|t| self.tint(t)).collect();
    // rust: out.layers.push(Layer {
    // rust: content: LayerContent::Model {
    // rust: model: leaf.model.clone(),
    // rust: },
    // rust: tints,
    // rust: foil,
    // rust: transform,
    // rust: });
}
    // rust: ItemModelNode::Composite {
    // rust: models,
    // rust: transformation,
    // rust: } => {
    // rust: let child = compose(parent, transformation);
    // rust: for m in models {
    // rust: self.node(out, m, &child);
}
}
    // rust: ItemModelNode::Condition {
    // rust: transformation,
    // rust: property,
    // rust: on_true,
    // rust: on_false,
    // rust: } => {
    // rust: let child = compose(parent, transformation);
    // rust: let chosen = if self.condition(property) {
    // rust: on_true
    // rust: } else {
    // rust: on_false
}
    // rust: self.node(out, chosen, &child);
}
    // rust: ItemModelNode::Select {
    // rust: transformation,
    // rust: property,
    // rust: cases,
    // rust: fallback,
    // rust: } => {
    // rust: let child = compose(parent, transformation);
    // rust: let value = self.select_value(property);
    // rust: let chosen = value.and_then(|v| {
    // rust: cases
    // rust: .iter()
    // rust: .find(|c| c.values.contains(&v))
    // rust: .map(|c| &c.model)
    // rust: });
    // rust: match (chosen, fallback) {
    // rust: (Some(m), _) => self.node(out, m, &child),
    // rust: (None, Some(f)) => self.node(out, f, &child),
    // rust: (None, None) => self.missing(out, &child),
}
}
    // rust: ItemModelNode::RangeDispatch {
    // rust: transformation,
    // rust: property,
    // rust: scale,
    // rust: entries,
    // rust: fallback,
    // rust: } => {
    // rust: let child = compose(parent, transformation);
    // rust: let value = self.numeric(property) * scale;
    // rust: let chosen = if value.is_nan() {
    // rust: None
    // rust: } else {
    // rust: last_index_less_or_equal(entries, value).map(|i| &entries[i].1)
}
    // rust: match (chosen, fallback) {
    // rust: (Some(m), _) => self.node(out, m, &child),
    // rust: (None, Some(f)) => self.node(out, f, &child),
    // rust: (None, None) => self.missing(out, &child),
}
}
    // rust: ItemModelNode::Special {
    // rust: base,
    // rust: transformation,
    // rust: model,
    // rust: } => {
    // rust: let transform = compose(parent, transformation);
    // rust: out.layers.push(Layer {
    // rust: content: LayerContent::Special {
    // rust: base: base.clone(),
    // rust: model: model.clone(),
    // rust: argument: model.argument(&|k| self.component(k).cloned()),
    // rust: },
    // rust: tints: Vec::new(),
    // rust: foil: if self.has_foil() {
    // rust: FoilType::Standard
    // rust: } else {
    // rust: FoilType::None
    // rust: },
    // rust: transform,
    // rust: });
}
    // rust: ItemModelNode::BundleSelectedItem => {
    // rust: if let Some(selected) = self.bundle_selected() {
    // rust: self.models
    // rust: .append_layers(out, &selected, self.ctx, self.env);
}
}
}
}
item_in_compass_tag :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
        // `ItemTags.COMPASSES`: the compass and the recovery compass.
    // rust: matches!(
    // rust: self.stack.item.as_str(),
    // rust: "minecraft:compass" | "minecraft:recovery_compass"
    // rust: )
}
    // `BundleItem.getSelectedItem`: the template at the selected index.
bundle_selected :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let items = self.component("minecraft:bundle_contents")?.as_array()?;
    // rust: let template = items.get(usize::try_from(self.stack.bundle_selected).ok()?)?;
    // rust: stack_from_template(template)
}
condition :: proc(self: ^Self, property: ^ConditionProperty) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let owner = self.ctx.owner;
    // rust: match property {
    // rust: ConditionProperty::Custom(property) => {
    // rust: self.env.item_model_property(property, self.stack)
}
    // rust: ConditionProperty::CustomModelData(i) => {
    // rust: self.component("minecraft:custom_model_data")
    // rust: .and_then(|d| custom_data_at(d, "flags", *i))
    // rust: .and_then(|v| v.as_bool())
    // rust: == Some(true)
}
    // rust: ConditionProperty::UsingItem => owner.is_some_and(|o| o.using_this_item),
    // rust: ConditionProperty::Broken => {
    // rust: self.damageable() && self.damage_value() >= self.max_damage() - 1
}
    // rust: ConditionProperty::Damaged => self.damageable() && self.damage_value() > 0,
    // rust: ConditionProperty::FishingRodCast => {
    // rust: owner.is_some_and(|o| o.fishing_cast_with_this_item)
}
    // rust: ConditionProperty::HasComponent {
    // rust: component,
    // rust: ignore_default,
    // rust: } => {
    // rust: if *ignore_default {
    // rust: self.stack.patch.contains_key(component)
    // rust: } else {
    // rust: self.components.contains_key(component)
}
}
    // rust: ConditionProperty::BundleHasSelectedItem => self.bundle_selected().is_some(),
    // rust: ConditionProperty::Selected => {
    // rust: owner.is_some_and(|o| o.is_local_player && o.is_selected)
}
    // rust: ConditionProperty::Carried => owner.is_some_and(|o| o.is_local_player && o.is_carried),
    // rust: ConditionProperty::ExtendedView => {
    // rust: self.ctx.display == DisplayContext::Gui && self.env.has_shift_down()
}
    // rust: ConditionProperty::KeybindDown(key) => self.env.is_keybind_down(key),
    // rust: ConditionProperty::ViewEntity => owner.is_some_and(|o| o.is_view_entity),
    // rust: ConditionProperty::Component(predicate) => {
    // rust: component_predicate::matches(predicate, self.components, self.env)
    // rust: .unwrap_or_else(|| self.env.component_matches(self.stack, predicate))
}
}
}
select_value :: proc(self: ^Self, property: ^SelectProperty) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let owner = self.ctx.owner;
    // rust: match property {
    // rust: SelectProperty::CustomModelData(i) => self
    // rust: .component("minecraft:custom_model_data")
    // rust: .and_then(|d| custom_data_at(d, "strings", *i))
    // rust: .cloned(),
    // rust: SelectProperty::MainHand => owner
    // rust: .map(|o| Value::String(if o.main_arm_left { "left" } else { "right" }.to_owned())),
    // rust: SelectProperty::ChargeType => {
    // rust: let projectiles = self
    // rust: .component("minecraft:charged_projectiles")
    // rust: .and_then(Value::as_array);
    // rust: let kind = match projectiles {
    // rust: None => "none",
    // rust: Some(p) if p.is_empty() => "none",
    // rust: Some(p) => {
    // rust: if p.iter()
    // rust: .any(|t| template_id(t) == Some("minecraft:firework_rocket"))
    // rust: {
    // rust: "rocket"
    // rust: } else {
    // rust: "arrow"
}
}
}
    // rust: Some(Value::String(kind.to_owned()))
}
    // rust: SelectProperty::TrimMaterial => {
    // rust: let material = self
    // rust: .component("minecraft:trim")?
    // rust: .get("material")?
    // rust: .as_str()?;
    // rust: identifier(material).ok().map(Value::String)
}
    // rust: SelectProperty::BlockState(name) => self
    // rust: .component("minecraft:block_state")
    // rust: .and_then(|v| v.get("properties").or(Some(v)))
    // rust: .and_then(|p| p.get(name))
    // rust: .map(|v| Value::String(v.as_str().map_or_else(|| v.to_string(), str::to_owned))),
    // rust: SelectProperty::DisplayContext => {
    // rust: Some(Value::String(self.ctx.display.name().to_owned()))
}
    // rust: SelectProperty::LocalTime {
    // rust: pattern,
    // rust: locale,
    // rust: time_zone,
    // rust: } => Some(Value::String(self.env.local_time(
    // rust: pattern,
    // rust: locale,
    // rust: time_zone.as_deref(),
    // rust: ))),
    // rust: SelectProperty::ContextEntityType => {
    // rust: owner.map(|o| Value::String(o.entity_type.clone()))
}
    // rust: SelectProperty::ContextDimension => {
    // rust: self.ctx.level.map(|l| Value::String(l.dimension.clone()))
}
    // rust: SelectProperty::Component(component) => self.component(component).cloned(),
}
}
numeric :: proc(self: ^Self, property: ^NumericProperty) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let owner = self.ctx.owner;
    // rust: match property {
    // rust: NumericProperty::BundleFullness => {
    // rust: self.env.bundle_fullness(self.stack, self.components)
}
    // rust: NumericProperty::Compass {
    // rust: wobble,
    // rust: target,
    // rust: state,
    // rust: } => self.compass(*wobble, *target, state),
    // rust: NumericProperty::Cooldown => owner.map_or(0.0, |o| o.cooldown_percent),
    // rust: NumericProperty::Count { normalize } => {
    // rust: let count = self.stack.count as f32;
    // rust: let max = self.max_stack_size() as f32;
    // rust: if *normalize {
    // rust: clamp(count / max, 0.0, 1.0)
    // rust: } else {
    // rust: clamp(count, 0.0, max)
}
}
    // rust: NumericProperty::CrossbowPull => {
    // rust: let Some(o) = owner else { return 0.0 };
    // rust: if self
    // rust: .component("minecraft:charged_projectiles")
    // rust: .and_then(Value::as_array)
    // rust: .is_some_and(|p| !p.is_empty())
    // rust: {
    // rust: return 0.0;
}
    // rust: (o.use_duration - o.use_item_remaining_ticks) as f32
    // rust: / o.crossbow_charge_duration as f32
}
    // rust: NumericProperty::CustomModelData(i) => self
    // rust: .component("minecraft:custom_model_data")
    // rust: .and_then(|d| custom_data_at(d, "floats", *i))
    // rust: .and_then(|v| float(v).ok())
    // rust: .unwrap_or(0.0),
    // rust: NumericProperty::Damage { normalize } => {
    // rust: let damage = self.damage_value() as f32;
    // rust: let max = self.max_damage() as f32;
    // rust: if *normalize {
    // rust: clamp(damage / max, 0.0, 1.0)
    // rust: } else {
    // rust: clamp(damage, 0.0, max)
}
}
    // rust: NumericProperty::Time {
    // rust: wobble,
    // rust: source,
    // rust: state,
    // rust: } => self.time(*wobble, *source, state),
    // rust: NumericProperty::UseCycle(period) => match owner {
    // rust: Some(o) if o.using_this_item => (o.use_item_remaining_ticks as f32) % period,
    // rust: _ => 0.0,
    // rust: },
    // rust: NumericProperty::UseDuration { remaining } => match owner {
    // rust: Some(o) if o.using_this_item => {
    // rust: if *remaining {
    // rust: o.use_item_remaining_ticks as f32
    // rust: } else {
    // rust: (o.use_duration - o.use_item_remaining_ticks) as f32
}
}
    // rust: _ => 0.0,
    // rust: },
}
}
    // `Time.calculate` (through `NeedleDirectionHelper.get`).
time :: proc(self: ^Self, wobble: bool, source: TimeSource, state: ^NeedleState) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (Some(_), Some(level)) = (self.ctx.owner, self.ctx.level) else {
    // rust: return 0.0;
}
    // rust: let target = match source {
    // rust: TimeSource::Random => self.env.random_float(),
    // rust: TimeSource::Daytime => level.sun_angle / 360.0,
    // rust: TimeSource::MoonPhase => level.moon_phase as f32 / 8.0,
}
    // rust: let mut wobblers = state.0.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let w = &mut wobblers[0];
    // rust: if w.should_update(wobble, level.game_time) {
    // rust: w.update(wobble, 0.9, level.game_time, target);
}
    // rust: w.value(wobble)
}
    // `CompassAngleState.calculate`.
compass :: proc(self: ^Self, wobble: bool, target: CompassTarget, state: ^NeedleState) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (Some(owner), Some(level)) = (self.ctx.owner, self.ctx.level) else {
    // rust: return 0.0;
}
    // rust: let target_pos: Option<GlobalPos> = match target {
    // rust: CompassTarget::None => None,
    // rust: CompassTarget::Lodestone => self
    // rust: .component("minecraft:lodestone_tracker")
    // rust: .and_then(|t| t.get("target"))
    // rust: .and_then(|t| {
    // rust: Some(GlobalPos {
    // rust: dimension: identifier(t.get("dimension")?.as_str()?).ok()?,
    // rust: pos: {
    // rust: let p = t.get("pos")?.as_array()?;
    // rust: [
    // rust: int(p.first()?).ok()?,
    // rust: int(p.get(1)?).ok()?,
    // rust: int(p.get(2)?).ok()?,
    // rust: ]
    // rust: },
    // rust: })
    // rust: }),
    // rust: CompassTarget::Spawn => level.respawn.clone(),
    // rust: CompassTarget::Recovery => owner.last_death_location.clone(),
}
    // rust: let valid = target_pos.as_ref().filter(|t| {
    // rust: t.dimension == level.dimension && {
    // rust: let c = [
    // rust: f64::from(t.pos[0]) + 0.5,
    // rust: f64::from(t.pos[1]) + 0.5,
    // rust: f64::from(t.pos[2]) + 0.5,
    // rust: ];
    // rust: let d = [
    // rust: c[0] - owner.position[0],
    // rust: c[1] - owner.position[1],
    // rust: c[2] - owner.position[2],
    // rust: ];
                // `distToCenterSqr(position) < 1.0E-5F`
    // rust: let dist = d[0] * d[0] + d[1] * d[1] + d[2] * d[2];
    // rust: dist.is_nan() || dist >= f64::from(1.0E-5_f32)
}
    // rust: });
    // rust: let mut wobblers = state.0.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let game_time = level.game_time;
    // rust: let Some(target) = valid else {
            // `getRandomlySpinningRotation`
    // rust: let no_target = &mut wobblers[1];
    // rust: if no_target.should_update(wobble, game_time) {
    // rust: let r = self.env.random_float();
    // rust: no_target.update(wobble, 0.8, game_time, r);
}
    // rust: let hash = self.ctx.seed.wrapping_mul(1_327_217_883);
    // rust: let rotation = no_target.value(wobble) + hash as f32 / 2.147_483_6E9;
    // rust: return positive_modulo(rotation, 1.0);
}
    // rust: let center = [
    // rust: f64::from(target.pos[0]) + 0.5,
    // rust: f64::from(target.pos[2]) + 0.5,
    // rust: ];
    // rust: let angle_to_target = ((center[1] - owner.position[2]).atan2(center[0] - owner.position[0])
    // rust: / f64::from(std::f32::consts::PI * 2.0)) as f32;
    // rust: let owner_y = positive_modulo(owner.visual_rotation_y_degrees / 360.0, 1.0);
    // rust: let rotation = if owner.is_local_player && level.runs_normally {
    // rust: let w = &mut wobblers[0];
    // rust: if w.should_update(wobble, game_time) {
    // rust: w.update(wobble, 0.8, game_time, 0.5 - (owner_y - 0.25));
}
    // rust: angle_to_target + w.value(wobble)
    // rust: } else {
    // rust: 0.5 - (owner_y - 0.25 - angle_to_target)
}
    // rust: positive_modulo(rotation, 1.0)
}
tint :: proc(self: ^Self, source: ^TintSource) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match source {
    // rust: TintSource::Constant(v) => *v,
    // rust: TintSource::CustomModelData { index, default } => self
    // rust: .component("minecraft:custom_model_data")
    // rust: .and_then(|d| custom_data_at(d, "colors", *index))
    // rust: .and_then(|v| rgb(v).ok())
    // rust: .map_or(opaque(*default), opaque),
    // rust: TintSource::Dye(default) => match self.component("minecraft:dyed_color") {
    // rust: Some(v) => opaque(rgb(v.get("rgb").unwrap_or(v)).unwrap_or(0)),
    // rust: None => *default,
    // rust: },
    // rust: TintSource::Grass {
    // rust: temperature,
    // rust: downfall,
    // rust: } => self
    // rust: .env
    // rust: .grass_color(f64::from(*temperature), f64::from(*downfall)),
    // rust: TintSource::Firework(default) => {
    // rust: let colors: Vec<i32> = self
    // rust: .component("minecraft:firework_explosion")
    // rust: .and_then(|e| e.get("colors"))
    // rust: .and_then(Value::as_array)
    // rust: .map(|c| c.iter().filter_map(|v| int(v).ok()).collect())
    // rust: .unwrap_or_default();
    // rust: match colors.len() {
    // rust: 0 => *default,
    // rust: 1 => opaque(colors[0]),
    // rust: n => {
    // rust: let n = n as i32;
    // rust: let sum = |shift: u32| -> i32 {
    // rust: colors.iter().map(|c| (c >> shift) & 255).sum::<i32>() / n
}
    // rust: argb(255, sum(16), sum(8), sum(0))
}
}
}
    // rust: TintSource::Potion(default) => match self.component("minecraft:potion_contents") {
    // rust: Some(contents) => {
    // rust: let custom = contents.get("custom_color").and_then(|c| int(c).ok());
    // rust: opaque(
    // rust: custom
    // rust: .or_else(|| self.env.potion_effect_color(contents))
    // rust: .unwrap_or(*default),
    // rust: )
}
    // rust: None => opaque(*default),
    // rust: },
    // rust: TintSource::Team(default) => opaque(
    // rust: self.ctx
    // rust: .owner
    // rust: .and_then(|o| o.team_color)
    // rust: .unwrap_or(*default),
    // rust: ),
}
}
}

// `Mth.clamp(float, min, max)` with `Math.min`'s NaN propagation.
clamp :: proc(v: f32, min: f32, max: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if v < min { min } else { java_min(v, max) }
}
java_min :: proc(a: f32, b: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if b.is_nan() {
    // rust: b
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: if a.is_sign_negative() { a } else { b }
    // rust: } else if a < b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
enchantments_present :: proc(v: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // `ItemEnchantments` is a level map, optionally wrapped as {"levels": {...}}.
    // rust: let map = v.get("levels").unwrap_or(v);
    // rust: map.as_object().is_some_and(|m| !m.is_empty())
}
    // rust: fn custom_data_at<'a>(data: &'a Value, list: &str, index: i32) -> Option<&'a Value> {
    // rust: data.get(list)?
    // rust: .as_array()?
    // rust: .get(usize::try_from(index).ok()?)
}
template_id :: proc(t: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: t.get("id")?.as_str()
}
// `ItemStackTemplate.create`: id, count and a component patch.
stack_from_template :: proc(template: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = identifier(template.get("id")?.as_str()?).ok()?;
    // rust: let count = template.get("count").map_or(Some(1), |c| int(c).ok())?;
    // rust: let mut stack = StackView::new(&id, count);
    // rust: if let Some(components) = template.get("components").and_then(Value::as_object) {
    // rust: for (key, value) in components {
    // rust: match key.strip_prefix('!') {
    // rust: Some(removed) => {
    // rust: stack.patch.insert(identifier(removed).ok()?, None);
}
    // rust: None => {
    // rust: stack
    // rust: .patch
    // rust: .insert(identifier(key).ok()?, Some(value.clone()));
}
}
}
}
    // rust: Some(stack)
}

// `RangeSelectItemModel.lastIndexLessOrEqual`.
last_index_less_or_equal :: proc(entries: ^[(f32) {
}
    // rust: let haystack: Vec<f32> = entries.iter().map(|e| e.0).collect();
    // rust: let found = if haystack.len() < 16 {
    // rust: haystack
    // rust: .iter()
    // rust: .position(|h| *h > needle)
    // rust: .map_or(haystack.len() as i64 - 1, |i| i as i64 - 1)
    // rust: } else {
    // rust: match binary_search(&haystack, needle) {
    // rust: Ok(index) => index as i64,
    // rust: Err(insertion) => insertion as i64 - 1,
}
}
    // rust: usize::try_from(found).ok()
}
// `Arrays.binarySearch(float[], float)`, including its handling of equal
// values (-0.0 below 0.0, NaN above everything).
binary_search :: proc(a: ^[f32], key: f32) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let (mut low, mut high) = (0i64, a.len() as i64 - 1);
    // rust: let bits = |v: f32| -> i32 {
    // rust: if v.is_nan() {
    // rust: 0x7fc0_0000
    // rust: } else {
    // rust: v.to_bits() as i32
}
}
    // rust: while low <= high {
    // rust: let mid = (low + high) >> 1;
    // rust: let value = a[mid as usize];
    // rust: if value < key {
    // rust: low = mid + 1;
    // rust: } else if value > key {
    // rust: high = mid - 1;
    // rust: } else {
    // rust: let (mid_bits, key_bits) = (bits(value), bits(key));
    // rust: if mid_bits == key_bits {
    // rust: return Ok(mid as usize);
    // rust: } else if mid_bits < key_bits {
    // rust: low = mid + 1;
    // rust: } else {
    // rust: high = mid - 1;
}
}
}
    // rust: Err(low as usize)
}

    // rust: mod foreign_tests;
    // rust: mod tests;
