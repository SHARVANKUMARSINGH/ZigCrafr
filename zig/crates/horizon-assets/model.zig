//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_model
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The 26.3 cuboid model format, before parent resolution and quad baking.
//!
//! Absent geometry differs from an explicit empty element list. Explicit null
//! elements, faces and display transforms are retained as the native decoder
//! does; render preparation must diagnose these before baking.
// use crate::json::*;
// use serde_json::value::RawValue;
// use std::{collections::BTreeMap, sync::Arc};

pub const Direction = enum {
    Down,
    Up,
    North,
    South,
    West,
    East,
};
    // rust: impl Direction {
    // rust: pub const ALL: [Self; 6] = [
    // rust: Self::Down,
    // rust: Self::Up,
    // rust: Self::North,
    // rust: Self::South,
    // rust: Self::West,
    // rust: Self::East,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Down => "down",
    // rust: Self::Up => "up",
    // rust: Self::North => "north",
    // rust: Self::South => "south",
    // rust: Self::West => "west",
    // rust: Self::East => "east",
}
}
pub fn by_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .find(|direction| direction.name() == name)
}
}
pub const GuiLight = enum {
    Front,
    Side,
};
pub const Material = struct {
    sprite: []const u8,
    force_translucent: bool,
};
pub const TextureSlot = enum {
    Reference(String),
    Material(Material),
};
pub const CuboidModel = struct {
    parent: ?[]const u8,
    loader: ?Loader,
    ambient_occlusion: ?bool,
    gui_light: ?GuiLight,
    textures: BTreeMap<[]const u8,
    elements: ?std.ArrayList(Option<Element)>,
    display: ?ItemTransforms,
    /// NeoForge's `render_type`, without a `minecraft:` prefix.
    render_type: ?[]const u8,
    /// A model's `visibility`: an obj object or composite child name to shown; absent is shown.
    visibility: BTreeMap<[]const u8,
};
/// A custom model loader's payload; a model inherits its parent's loader unless it names its own.
pub const Loader = enum {
    /// `neoforge:composite`: children in document order.
    Composite {,
    children: Vec<(String, Arc<CuboidModel>)>,
        /// Child name to shown; a child absent from the map is shown.
    visibility: BTreeMap<String, bool>,
    // rust: },
    /// `neoforge:obj`: `model` and `mtl_override` are asset locations.
    Obj {,
    model: String,
    flip_v: bool,
    shade_quads: Option<bool>,
    mtl_override: Option<String>,
    // rust: },
    /// A loader this decoder does not know: it adds no geometry.
    Unknown(String),
};
/// NeoForge's `neoforge_data` of an element or a face; a face's keys win.
pub const NeoforgeData = struct {
    block_light: ?u8,
    sky_light: ?u8,
    /// ARGB.
    color: ?i32,
    ambient_occlusion: ?bool,
};
    // rust: impl NeoforgeData {
    /// `self` over `base`, key by key.
pub fn over(self: *Self, base: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: block_light: self.block_light.or(base.block_light),
    // rust: sky_light: self.sky_light.or(base.sky_light),
    // rust: color: self.color.or(base.color),
    // rust: ambient_occlusion: self.ambient_occlusion.or(base.ambient_occlusion),
}
}
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let obj = object(raw)?;
    // rust: let light = |key: &str| -> Result<Option<u8>> {
    // rust: Ok(obj
    // rust: .get(key)
    // rust: .map(|r| integer(r))
    // rust: .transpose()?
    // rust: .map(|v| v.clamp(0, 15) as u8))
}
        // Some mods spell both lights as one `light_emission`.
    // rust: let emission = light("light_emission")?;
    // rust: let color = match obj.get("color") {
    // rust: Some(raw) if raw.get().starts_with('"') => {
    // rust: let text = string(raw)?;
    // rust: let text = text.trim();
    // rust: let hex = text
    // rust: .strip_prefix('#')
    // rust: .or_else(|| text.strip_prefix("0x"))
    // rust: .or_else(|| text.strip_prefix("0X"));
    // rust: match hex {
    // rust: Some(hex) => u32::from_str_radix(hex, 16).ok().map(|v| v as i32),
    // rust: None => text.parse::<u32>().ok().map(|v| v as i32),
}
}
    // rust: Some(raw) => Some(integer(raw)?),
    // rust: None => None,
}
    // rust: Ok(Self {
    // rust: block_light: light("block_light")?.or(emission),
    // rust: sky_light: light("sky_light")?.or(emission),
    // rust: color,
    // rust: ambient_occlusion: obj
    // rust: .get("ambient_occlusion")
    // rust: .map(|r| boolean(r))
    // rust: .transpose()?,
    // rust: })
}
}
pub const Element = struct {
    from: [f32,
    to: [f32,
    faces: BTreeMap<Direction,
    rotation: ?ElementRotation,
    shade_direction_override: ?Direction,
    light_emission: u8,
    neoforge_data: ?NeoforgeData,
};
pub const Face = struct {
    cull: ?Direction,
    tint_index: i32,
    texture: []const u8,
    uv: Option<[f32,
    /// Normalized counterclockwise quadrants, in the range 0..4.
    rotation: u8,
    /// A face-level `light_emission`, which wins over its element's.
    light_emission: ?u8,
    neoforge_data: ?NeoforgeData,
};
pub const Axis = enum {
    X,
    Y,
    Z,
};
pub const RotationValue = enum {
    SingleAxis { axis: Axis, angle: f32 },
    EulerXyz([f32; 3]),
};
pub const ElementRotation = struct {
    /// Block units, converted from model coordinates during decoding.
    origin: [f32,
    value: RotationValue,
    rescale: bool,
};
pub const ItemTransform = struct {
    rotation: [f32,
    translation: [f32,
    scale: [f32,
};
/// Missing transforms inherit later. Explicit identity and null values do not.
pub const DisplayTransform = enum {
    Inherit,
    Explicit(Option<ItemTransform>),
};
    // rust: pub const DISPLAY_CONTEXTS: [&str; 9] = [
    // rust: "thirdperson_lefthand",
    // rust: "thirdperson_righthand",
    // rust: "firstperson_lefthand",
    // rust: "firstperson_righthand",
    // rust: "head",
    // rust: "gui",
    // rust: "ground",
    // rust: "fixed",
    // rust: "on_shelf",
    // rust: ];
pub const ItemTransforms = struct {
    contexts: [DisplayTransform,
};

    // rust: impl CuboidModel {
    /// Decode strict JSON, preserving the native parser's primitive coercions,
    /// optional inheritance fields, nullable children and f32 conversion.
    /// Like the native stream entry point, this reads one value and leaves
    /// trailing input unread. The pinned native entry point uses strict JSON.
pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw = serde_json::Deserializer::from_str(json.strip_prefix('\u{feff}').unwrap_or(json))
    // rust: .into_iter::<&RawValue>()
    // rust: .next()
    // rust: .ok_or_else(|| error("empty model input"))??;
    // rust: validate_number_tokens(raw)?;
    // rust: Self::decode(raw)
}
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let obj = object(raw)?;
    // rust: let parent = obj
    // rust: .get("parent")
    // rust: .map(|r| primitive_string(r))
    // rust: .transpose()?
    // rust: .unwrap_or_default();
    // rust: let parent = if parent.is_empty() {
    // rust: None
    // rust: } else {
    // rust: Some(identifier(&parent)?)
}
    // rust: let loader = obj
    // rust: .get("loader")
    // rust: .filter(|raw| raw.get() != "null")
    // rust: .map(|raw| Loader::decode(raw, &obj))
    // rust: .transpose()?;
    // rust: let ambient_occlusion = obj
    // rust: .get("ambientocclusion")
    // rust: .map(|r| boolean(r))
    // rust: .transpose()?;
    // rust: let gui_light = obj
    // rust: .get("gui_light")
    // rust: .map(|raw| match primitive_string(raw)?.as_str() {
    // rust: "front" => Ok(GuiLight::Front),
    // rust: "side" => Ok(GuiLight::Side),
    // rust: _ => Err(error("invalid gui light")),
    // rust: })
    // rust: .transpose()?;
    // rust: let mut textures = BTreeMap::new();
    // rust: if let Some(raw) = obj.get("textures") {
    // rust: for (key, raw) in object(raw)? {
    // rust: textures.insert(key, texture(raw)?);
}
}
    // rust: let elements = obj
    // rust: .get("elements")
    // rust: .map(|raw| {
    // rust: array(raw)?
    // rust: .into_iter()
    // rust: .map(|raw| nullable(raw, Element::decode))
    // rust: .collect::<Result<Vec<_>>>()
    // rust: })
    // rust: .transpose()?;
    // rust: let display = obj
    // rust: .get("display")
    // rust: .map(|r| ItemTransforms::decode(r))
    // rust: .transpose()?;
    // rust: let render_type = obj
    // rust: .get("render_type")
    // rust: .filter(|raw| raw.get().starts_with('"'))
    // rust: .map(|raw| string(raw))
    // rust: .transpose()?
    // rust: .map(|name| name.strip_prefix("minecraft:").unwrap_or(&name).to_owned());
    // rust: Ok(Self {
    // rust: parent,
    // rust: loader,
    // rust: ambient_occlusion,
    // rust: gui_light,
    // rust: textures,
    // rust: elements,
    // rust: display,
    // rust: render_type,
    // rust: visibility: visibility(&obj)?,
    // rust: })
}
    /// The models this one needs besides itself: its parent and its composite children's parents.
pub fn referenced_models(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut names: Vec<String> = self.parent.iter().cloned().collect();
    // rust: if let Some(Loader::Composite { children, .. }) = &self.loader {
    // rust: for (_, child) in children {
    // rust: names.extend(child.referenced_models());
}
}
    // rust: names
}
}
pub fn visibility(obj: *Object<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut visibility = BTreeMap::new();
    // rust: if let Some(raw) = obj.get("visibility") {
    // rust: for (key, raw) in object(raw)? {
    // rust: visibility.insert(key, boolean(raw)?);
}
}
    // rust: Ok(visibility)
}
    // rust: impl Loader {
pub fn decode(raw: *RawValue, obj: *Object<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = primitive_string(raw)?;
    // rust: match name.as_str() {
    // rust: "neoforge:composite" => {
    // rust: let mut children = Vec::new();
    // rust: if let Some(raw) = obj.get("children") {
    // rust: for (name, raw) in ordered_object(raw)? {
    // rust: children.push((name, Arc::new(CuboidModel::decode(raw)?)));
}
}
    // rust: Ok(Self::Composite {
    // rust: children,
    // rust: visibility: visibility(obj)?,
    // rust: })
}
    // rust: "neoforge:obj" => {
    // rust: let optional = |key: &str| {
    // rust: obj.get(key)
    // rust: .filter(|raw| raw.get() != "null")
    // rust: .map(|raw| primitive_string(raw))
    // rust: .transpose()
}
    // rust: Ok(Self::Obj {
    // rust: model: identifier(&optional("model")?.ok_or_else(|| error("missing model"))?)?,
    // rust: flip_v: obj
    // rust: .get("flip_v")
    // rust: .map(|r| boolean(r))
    // rust: .transpose()?
    // rust: .unwrap_or(false),
    // rust: shade_quads: obj.get("shade_quads").map(|r| boolean(r)).transpose()?,
    // rust: mtl_override: optional("mtl_override")?
    // rust: .map(|name| identifier(&name))
    // rust: .transpose()?,
    // rust: })
}
    // rust: _ => Ok(Self::Unknown(name)),
}
}
}
    // rust: fn nullable<T>(raw: &RawValue, decode: impl FnOnce(&RawValue) -> Result<T>) -> Result<Option<T>> {
    // rust: if raw.get() == "null" {
    // rust: Ok(None)
    // rust: } else {
    // rust: decode(raw).map(Some)
}
}
pub fn texture(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if raw.get().starts_with('"') {
    // rust: let name = string(raw)?;
    // rust: if name.is_empty() {
    // rust: return Err(error("empty texture slot value"));
}
    // rust: if let Some(target) = name.strip_prefix('#') {
    // rust: return Ok(TextureSlot::Reference(target.to_owned()));
}
    // rust: return Ok(TextureSlot::Material(Material {
    // rust: sprite: identifier(&name)?,
    // rust: force_translucent: false,
    // rust: }));
}
    // rust: let obj = object(raw)?;
    // rust: let sprite = identifier(&string(required(&obj, "sprite")?)?)?;
    // rust: let force_translucent = match obj.get("force_translucent") {
    // rust: None => false,
    // rust: Some(raw) if raw.get() == "null" => false,
    // rust: Some(raw) if raw.get() == "true" => true,
    // rust: Some(raw) if raw.get() == "false" => false,
    // rust: Some(_) => return Err(error("invalid material boolean")),
}
    // rust: Ok(TextureSlot::Material(Material {
    // rust: sprite,
    // rust: force_translucent,
    // rust: }))
}
    // rust: impl Element {
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let obj = object(raw)?;
    // rust: let from = vector(required(&obj, "from")?)?;
    // rust: let to = vector(required(&obj, "to")?)?;
    // rust: if from.iter().chain(&to).any(|v| !(-16.0..=32.0).contains(v)) {
    // rust: return Err(error("element outside model bounds"));
}
    // rust: let rotation = obj
    // rust: .get("rotation")
    // rust: .map(|r| ElementRotation::decode(r))
    // rust: .transpose()?;
    // rust: let mut faces = BTreeMap::new();
    // rust: for (name, raw) in object(required(&obj, "faces")?)? {
    // rust: let direction =
    // rust: Direction::by_name(&name).ok_or_else(|| error("invalid face direction"))?;
    // rust: faces.insert(direction, nullable(raw, Face::decode)?);
}
    // rust: if faces.is_empty() {
    // rust: return Err(error("element requires a face"));
}
    // rust: let shade_direction_override = obj
    // rust: .get("shade_direction_override")
    // rust: .map(|raw| {
    // rust: Direction::by_name(&primitive_string(raw)?)
    // rust: .ok_or_else(|| error("invalid shade direction"))
    // rust: })
    // rust: .transpose()?;
    // rust: let light_emission = obj
    // rust: .get("light_emission")
    // rust: .map(|r| integer(r))
    // rust: .transpose()?
    // rust: .unwrap_or(0);
    // rust: if !(0..=15).contains(&light_emission) {
    // rust: return Err(error("invalid light emission"));
}
    // rust: Ok(Self {
    // rust: from,
    // rust: to,
    // rust: faces,
    // rust: rotation,
    // rust: shade_direction_override,
    // rust: light_emission: light_emission as u8,
    // rust: neoforge_data: obj
    // rust: .get("neoforge_data")
    // rust: .map(|r| NeoforgeData::decode(r))
    // rust: .transpose()?,
    // rust: })
}
}
    // rust: impl Face {
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let obj = object(raw)?;
    // rust: let cull = obj
    // rust: .get("cullface")
    // rust: .map(|r| primitive_string(r))
    // rust: .transpose()?
    // rust: .and_then(|s| Direction::by_name(&s));
    // rust: let texture = primitive_string(required(&obj, "texture")?)?;
    // rust: let tint_index = obj
    // rust: .get("tintindex")
    // rust: .map(|r| integer(r))
    // rust: .transpose()?
    // rust: .unwrap_or(-1);
    // rust: let rotation = obj
    // rust: .get("rotation")
    // rust: .map(|r| integer(r))
    // rust: .transpose()?
    // rust: .unwrap_or(0)
    // rust: .rem_euclid(360);
    // rust: if rotation % 90 != 0 {
    // rust: return Err(error("face rotation must be a multiple of 90"));
}
    // rust: let uv = obj.get("uv").map(|r| vector(r)).transpose()?;
    // rust: Ok(Self {
    // rust: cull,
    // rust: tint_index,
    // rust: texture,
    // rust: uv,
    // rust: rotation: (rotation / 90) as u8,
    // rust: light_emission: obj
    // rust: .get("light_emission")
    // rust: .map(|r| integer(r))
    // rust: .transpose()?
    // rust: .map(|v| v.clamp(0, 15) as u8),
    // rust: neoforge_data: obj
    // rust: .get("neoforge_data")
    // rust: .map(|r| NeoforgeData::decode(r))
    // rust: .transpose()?,
    // rust: })
}
}
    // rust: impl ElementRotation {
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let obj = object(raw)?;
    // rust: let origin = vector::<3>(required(&obj, "origin")?)?.map(|v| v * 0.0625);
    // rust: let value = if obj.contains_key("axis") || obj.contains_key("angle") {
    // rust: let axis = match primitive_string(required(&obj, "axis")?)?
    // rust: .to_lowercase()
    // rust: .as_str()
    // rust: {
    // rust: "x" => Axis::X,
    // rust: "y" => Axis::Y,
    // rust: "z" => Axis::Z,
    // rust: _ => return Err(error("invalid rotation axis")),
}
    // rust: RotationValue::SingleAxis {
    // rust: axis,
    // rust: angle: float(required(&obj, "angle")?)?,
}
    // rust: } else if ["x", "y", "z"].iter().any(|key| obj.contains_key(*key)) {
    // rust: let mut angles = [0.0; 3];
    // rust: for (angle, key) in angles.iter_mut().zip(["x", "y", "z"]) {
    // rust: *angle = obj.get(key).map(|r| float(r)).transpose()?.unwrap_or(0.0);
}
    // rust: RotationValue::EulerXyz(angles)
    // rust: } else {
    // rust: return Err(error("missing rotation value"));
}
    // rust: let rescale = obj
    // rust: .get("rescale")
    // rust: .map(|r| boolean(r))
    // rust: .transpose()?
    // rust: .unwrap_or(false);
    // rust: Ok(Self {
    // rust: origin,
    // rust: value,
    // rust: rescale,
    // rust: })
}
}
    // rust: impl ItemTransform {
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let obj = object(raw)?;
    // rust: let rotation = obj
    // rust: .get("rotation")
    // rust: .map(|r| vector(r))
    // rust: .transpose()?
    // rust: .unwrap_or([0.0; 3]);
    // rust: let translation = obj
    // rust: .get("translation")
    // rust: .map(|r| vector(r))
    // rust: .transpose()?
    // rust: .unwrap_or([0.0; 3])
    // rust: .map(|v| (v * 0.0625).clamp(-5.0, 5.0));
    // rust: let scale = obj
    // rust: .get("scale")
    // rust: .map(|r| vector(r))
    // rust: .transpose()?
    // rust: .unwrap_or([1.0; 3])
    // rust: .map(|v| v.clamp(-4.0, 4.0));
    // rust: Ok(Self {
    // rust: rotation,
    // rust: translation,
    // rust: scale,
    // rust: })
}
}
    // rust: impl ItemTransforms {
pub fn decode(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let obj = object(raw)?;
    // rust: let mut contexts = std::array::from_fn(|_| DisplayTransform::Inherit);
    // rust: for (transform, key) in contexts.iter_mut().zip(DISPLAY_CONTEXTS) {
    // rust: if let Some(raw) = obj.get(key) {
    // rust: *transform = DisplayTransform::Explicit(nullable(raw, ItemTransform::decode)?);
}
}
    // rust: for (left, right) in [(0, 1), (2, 3)] {
    // rust: if contexts[left] == DisplayTransform::Inherit {
    // rust: contexts[left] = contexts[right].clone();
}
}
    // rust: Ok(Self { contexts })
}
}
