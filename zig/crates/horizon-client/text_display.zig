//! Transpiled from Horizon Rust crate
//! Module: horizon-client_text_display
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Display/TextDisplay synced data (26.3), checked against vanilla accessors
//! and ClientboundSetEntityDataPacket's own stream codec.
// use crate::{
    // rust: save::{float, number},
    // rust: text::Text,
}
// use horizon_protocol::entity_data::{Value, serializer};
// use horizon_world::nbt::Tag;
// use serde::Serialize;
// use std::sync::Arc;

/// `TextDisplay.Align`.
pub const Align = enum {
    Center,
    Left,
    Right,
};

/// `Display` and `TextDisplay`'s synced data (ids 8 to 27); the default is
/// what their `defineSynchedData` starts with.
pub const TextDisplayData = struct {
    interpolation_delay: i32,
    interpolation_duration: i32,
    teleport_duration: i32,
    translation: [f32,
    scale: [f32,
    left_rotation: [f32,
    right_rotation: [f32,
    billboard: u8,
    brightness: i32,
    view_range: f32,
    shadow_radius: f32,
    shadow_strength: f32,
    width: f32,
    height: f32,
    glow_color: i32,
    /// Shared: a frame's interpolated copy of the data must not copy it.
    text: *Text,
    line_width: i32,
    background: i32,
    opacity: i8,
    flags: u8,
};

    // rust: impl Default for TextDisplayData {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: interpolation_delay: 0,
    // rust: interpolation_duration: 0,
    // rust: teleport_duration: 0,
    // rust: translation: [0.0; 3],
    // rust: scale: [1.0; 3],
    // rust: left_rotation: [0.0, 0.0, 0.0, 1.0],
    // rust: right_rotation: [0.0, 0.0, 0.0, 1.0],
    // rust: billboard: 0,
    // rust: brightness: -1,
    // rust: view_range: 1.0,
    // rust: shadow_radius: 0.0,
    // rust: shadow_strength: 1.0,
    // rust: width: 0.0,
    // rust: height: 0.0,
    // rust: glow_color: -1,
    // rust: text: Arc::new(Text::empty()),
    // rust: line_width: 200,
    // rust: background: 0x4000_0000,
    // rust: opacity: -1,
    // rust: flags: 0,
}
}
}

    // rust: impl TextDisplayData {
    /// DisplayRenderer's billboard orientation followed by Transformation's T*L*S*R.
pub fn matrix(self: *Self, entity: [f32; 2], camera: [f32; 2]) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [yaw, pitch] = match self.billboard {
    // rust: 1 => [camera[0] - 180.0, entity[1]],
    // rust: 2 => [entity[0], -camera[1]],
    // rust: 3 => [camera[0] - 180.0, -camera[1]],
    // rust: _ => entity,
}
    // rust: let orientation = glam::Quat::from_euler(
    // rust: glam::EulerRot::YXZ,
    // rust: -yaw * 0.017_453_292,
    // rust: pitch * 0.017_453_292,
    // rust: 0.0,
    // rust: );
    // rust: glam::Mat4::from_quat(orientation)
    // rust: * glam::Mat4::from_translation(self.translation.into())
    // rust: * glam::Mat4::from_quat(glam::Quat::from_array(self.left_rotation))
    // rust: * glam::Mat4::from_scale(self.scale.into())
    // rust: * glam::Mat4::from_quat(glam::Quat::from_array(self.right_rotation))
}

pub fn blend(self: *Self, from: *Self, t: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = self.clone();
    // rust: for i in 0..3 {
    // rust: out.translation[i] =
    // rust: from.translation[i] + t * (self.translation[i] - from.translation[i]);
    // rust: out.scale[i] = from.scale[i] + t * (self.scale[i] - from.scale[i]);
}
    // rust: out.left_rotation = glam::Quat::from_array(from.left_rotation)
    // rust: .slerp(glam::Quat::from_array(self.left_rotation), t)
    // rust: .to_array();
    // rust: out.right_rotation = glam::Quat::from_array(from.right_rotation)
    // rust: .slerp(glam::Quat::from_array(self.right_rotation), t)
    // rust: .to_array();
        // Display$LinearFloatInterpolator: Mth.lerp(t, previous, current).
    // rust: out.shadow_radius = from.shadow_radius + t * (self.shadow_radius - from.shadow_radius);
    // rust: out.shadow_strength =
    // rust: from.shadow_strength + t * (self.shadow_strength - from.shadow_strength);
    // rust: let int = |a: i32, b: i32| a + (t * (b as f32 - a as f32)).floor() as i32;
    // rust: out.opacity = int(i32::from(from.opacity), i32::from(self.opacity)) as i8;
    // rust: out.background = (0..4).fold(0, |color, channel| {
    // rust: color
    // rust: | (int(
    // rust: (from.background as u32 >> (channel * 8) & 255) as i32,
    // rust: (self.background as u32 >> (channel * 8) & 255) as i32,
    // rust: ) << (channel * 8))
    // rust: });
    // rust: out
}
}

/// `Display.updateCulling`: either edge at 0 sets `noCulling`, so the renderer
/// skips the frustum box (`DisplayRenderer.affectedByCulling`).
pub fn no_culling(width: f32, height: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: width == 0.0 || height == 0.0
}

/// `Display.updateCulling` / `getInterpolatedBoundingBox` at an interpolated
/// origin: the AABB from `(x − width/2, y, z − width/2)` to
/// `(x + width/2, y + height, z + width/2)`.
pub fn culling_box(origin: glam::DVec3, width: f32, height: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = f64::from(width) * 0.5;
    // rust: let tall = f64::from(height);
    // rust: (
    // rust: glam::DVec3::new(origin.x - half, origin.y, origin.z - half),
    // rust: glam::DVec3::new(origin.x + half, origin.y + tall, origin.z + half),
    // rust: )
}

    // rust: impl TextDisplayData {
    /// Omitted fields retain their previous values.
pub fn apply(self: *Self, values: *[(u8) void {
}
    // rust: for (id, _, value) in values {
    // rust: match (id, value) {
    // rust: (8, Value::Int(v)) => self.interpolation_delay = *v,
    // rust: (9, Value::Int(v)) => self.interpolation_duration = *v,
    // rust: (10, Value::Int(v)) => self.teleport_duration = *v,
    // rust: (11, Value::Floats(v)) if v.len() == 3 => self.translation.copy_from_slice(v),
    // rust: (12, Value::Floats(v)) if v.len() == 3 => self.scale.copy_from_slice(v),
    // rust: (13, Value::Floats(v)) if v.len() == 4 => self.left_rotation.copy_from_slice(v),
    // rust: (14, Value::Floats(v)) if v.len() == 4 => self.right_rotation.copy_from_slice(v),
    // rust: (15, Value::Byte(v)) => self.billboard = *v as u8,
    // rust: (16, Value::Int(v)) => self.brightness = *v,
    // rust: (17, Value::Float(v)) => self.view_range = *v,
    // rust: (18, Value::Float(v)) => self.shadow_radius = *v,
    // rust: (19, Value::Float(v)) => self.shadow_strength = *v,
    // rust: (20, Value::Float(v)) => self.width = *v,
    // rust: (21, Value::Float(v)) => self.height = *v,
    // rust: (22, Value::Int(v)) => self.glow_color = *v,
    // rust: (23, Value::Text(v)) => self.text = Arc::new(crate::entity_nbt::name_text(v)),
    // rust: (24, Value::Int(v)) => self.line_width = *v,
    // rust: (25, Value::Int(v)) => self.background = *v,
    // rust: (26, Value::Byte(v)) => self.opacity = *v,
    // rust: (27, Value::Byte(v)) => self.flags = *v as u8,
    // rust: _ => {}
}
}
}
    /// `TextDisplay.getAlign`: the left flag wins over the right one.
pub fn align(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.flags & 8 != 0 {
    // rust: Align::Left
    // rust: } else if self.flags & 16 != 0 {
    // rust: Align::Right
    // rust: } else {
    // rust: Align::Center
}
}
}

/// One synched data entry: kept when it differs from its default, or always
/// with `all` (the defaults a client is sent when a value goes back to one).
    // rust: fn entry(
    // rust: out: &mut Vec<(u8, i32, Value)>,
    // rust: all: bool,
    // rust: id: u8,
    // rust: kind: i32,
    // rust: value: Value,
    // rust: default: Value,
    // rust: ) {
    // rust: if all || value != default {
    // rust: out.push((id, kind, if all { default } else { value }));
}
}

/// `Display.readAdditionalSaveData`: the synched data entries (ids 8 to 22)
/// of a saved display, or with `all` their defaults.
pub fn display_data(tag: *Tag, all: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let int = |key: &str| number(tag.get(key)).map(|v| v as i32);
    // rust: let real = |key: &str| float(tag.get(key)).map(|v| v as f32);
    // rust: let mut out = Vec::new();
    // rust: let mut set = |id: u8, kind: i32, value: Value, default: Value| {
    // rust: entry(&mut out, all, id, kind, value, default);
}
    // rust: let defaults = TextDisplayData::default();
    // The start delay, the transformation duration, the teleport duration (0 to 59).
    // rust: let ints = [
    // rust: (8, "start_interpolation", 0, i32::MIN, i32::MAX),
    // rust: (9, "interpolation_duration", 0, i32::MIN, i32::MAX),
    // rust: (10, "teleport_duration", 0, 0, 59),
    // rust: (22, "glow_color_override", -1, i32::MIN, i32::MAX),
    // rust: ];
    // rust: for (id, key, default, low, high) in ints {
    // rust: let value = int(key).unwrap_or(default).clamp(low, high);
    // rust: set(id, serializer::INT, Value::Int(value), Value::Int(default));
}
    // `Transformation.EXTENDED_CODEC` (four parts or MATRIX4F), else `Transformation.IDENTITY`.
    // rust: let t = tag.get("transformation").and_then(transformation);
    // rust: let (translation, left, scale, right) = t.unwrap_or((
    // rust: defaults.translation,
    // rust: defaults.left_rotation,
    // rust: defaults.scale,
    // rust: defaults.right_rotation,
    // rust: ));
    // rust: let parts = [
    // rust: (
    // rust: 11,
    // rust: serializer::VECTOR3,
    // rust: translation.to_vec(),
    // rust: defaults.translation.to_vec(),
    // rust: ),
    // rust: (
    // rust: 12,
    // rust: serializer::VECTOR3,
    // rust: scale.to_vec(),
    // rust: defaults.scale.to_vec(),
    // rust: ),
    // rust: (
    // rust: 13,
    // rust: serializer::QUATERNION,
    // rust: left.to_vec(),
    // rust: defaults.left_rotation.to_vec(),
    // rust: ),
    // rust: (
    // rust: 14,
    // rust: serializer::QUATERNION,
    // rust: right.to_vec(),
    // rust: defaults.right_rotation.to_vec(),
    // rust: ),
    // rust: ];
    // rust: for (id, kind, value, default) in parts {
    // rust: set(id, kind, Value::Floats(value), Value::Floats(default));
}
    // rust: let billboard = match tag.get("billboard") {
    // rust: Some(Tag::String(s)) => match s.to_string_lossy().as_str() {
    // rust: "vertical" => 1,
    // rust: "horizontal" => 2,
    // rust: "center" => 3,
    // rust: _ => 0,
    // rust: },
    // rust: _ => 0,
}
    // rust: set(15, serializer::BYTE, Value::Byte(billboard), Value::Byte(0));
    // `Brightness.pack`: block light in bits 4 to 7, sky light in bits 20 to 23.
    // rust: let brightness = tag.get("brightness").and_then(|b| {
    // rust: let light = |key: &str| number(b.get(key)).filter(|v| (0..=15).contains(v));
    // rust: Some((light("block")? as i32) << 4 | (light("sky")? as i32) << 20)
    // rust: });
    // rust: set(
    // rust: 16,
    // rust: serializer::INT,
    // rust: Value::Int(brightness.unwrap_or(-1)),
    // rust: Value::Int(-1),
    // rust: );
    // rust: for (id, key, default) in [
    // rust: (17, "view_range", 1.0),
    // rust: (18, "shadow_radius", 0.0),
    // rust: (19, "shadow_strength", 1.0),
    // rust: (20, "width", 0.0),
    // rust: (21, "height", 0.0),
    // rust: ] {
    // rust: let value = real(key).unwrap_or(default);
    // rust: set(
    // rust: id,
    // rust: serializer::FLOAT,
    // rust: Value::Float(value),
    // rust: Value::Float(default),
    // rust: );
}
    // rust: out
}

/// `TextDisplay.readAdditionalSaveData`: the text, line width, background,
/// opacity and style flags (ids 23 to 27), or with `all` their defaults.
pub fn text_display_data(tag: *Tag, all: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let int = |key: &str| number(tag.get(key)).map(|v| v as i32);
    // rust: let mut out = Vec::new();
    // rust: let mut set = |id: u8, kind: i32, value: Value, default: Value| {
    // rust: entry(&mut out, all, id, kind, value, default);
}
    // rust: let empty = Tag::String("".into());
    // rust: set(
    // rust: 23,
    // rust: serializer::COMPONENT,
    // rust: Value::Text(tag.get("text").unwrap_or(&empty).clone()),
    // rust: Value::Text(empty.clone()),
    // rust: );
    // rust: set(
    // rust: 24,
    // rust: serializer::INT,
    // rust: Value::Int(int("line_width").unwrap_or(200)),
    // rust: Value::Int(200),
    // rust: );
    // rust: let background = Value::Int(int("background").unwrap_or(0x4000_0000));
    // rust: set(25, serializer::INT, background, Value::Int(0x4000_0000));
    // rust: let opacity = Value::Byte(int("text_opacity").unwrap_or(-1) as i8);
    // rust: set(26, serializer::BYTE, opacity, Value::Byte(-1));
    // Shadow 1, see-through 2, default background 4, then the alignment: left 8, right 16.
    // rust: let flag = |key: &str, bit: i8| {
    // rust: if int(key).is_some_and(|v| v != 0) {
    // rust: bit
    // rust: } else {
    // rust: 0
}
}
    // rust: let align = match tag.get("alignment") {
    // rust: Some(Tag::String(s)) => match s.to_string_lossy().as_str() {
    // rust: "left" => 8,
    // rust: "right" => 16,
    // rust: _ => 0,
    // rust: },
    // rust: _ => 0,
}
    // rust: let flags = flag("shadow", 1) | flag("see_through", 2) | flag("default_background", 4) | align;
    // rust: set(27, serializer::BYTE, Value::Byte(flags), Value::Byte(0));
    // rust: out
}

/// `Transformation.EXTENDED_CODEC`'s translation, left rotation, scale and
/// right rotation: all four parts, or a `MATRIX4F` (sixteen floats, row-major)
/// that `new Transformation(matrix)` decomposes (`MatrixUtil.svdDecompose`).
pub fn transformation(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_assets::math::{
    // rust: Mat4, normalize_quaternion, quaternion_from_axis_angle, svd_decompose,
}
    // rust: let list = |tag: Option<&Tag>| -> Option<Vec<f32>> {
    // rust: match tag? {
    // rust: Tag::List(l) => l.iter().map(|v| float(Some(v)).map(|v| v as f32)).collect(),
    // rust: _ => None,
}
}
    // rust: if let Some(values) = list(Some(tag)) {
    // rust: let values: [f32; 16] = values.try_into().ok()?;
    // rust: return Some(svd_decompose(&Mat4::from_row_major(values)));
}
    // rust: let vector = |key: &str| -> Option<[f32; 3]> { list(tag.get(key))?.try_into().ok() };
    // `ExtraCodecs.QUATERNIONF`: four components (normalized) or an axis and an
    // angle (`new Quaternionf(AxisAngle4f)`: the angle wrapped, the axis as given).
    // rust: let rotation = |key: &str| -> Option<[f32; 4]> {
    // rust: let value = tag.get(key)?;
    // rust: if let Some(q) = list(Some(value)) {
    // rust: return Some(normalize_quaternion(q.try_into().ok()?));
}
    // rust: let angle = float(value.get("angle"))? as f32;
    // rust: let axis: [f32; 3] = list(value.get("axis"))?.try_into().ok()?;
    // rust: Some(quaternion_from_axis_angle(angle, axis))
}
    // rust: Some((
    // rust: vector("translation")?,
    // rust: rotation("left_rotation")?,
    // rust: vector("scale")?,
    // rust: rotation("right_rotation")?,
    // rust: ))
}

/// `TextDisplay.CachedInfo`: each line and its width, and the widest.
pub const Lines = struct {
    lines: Vec<(Text,
    width: f32,
};

    // rust: impl Lines {
    /// `TextDisplayRenderer.splitLines`: Font.split, no indent on wrapped lines.
pub fn split(font: *crate::font::Font, text: *Text, line_width: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lines: Vec<_> = font
    // rust: .split_formatted(text, line_width as f32)
    // rust: .into_iter()
    // rust: .map(|line| {
    // rust: let width = font.width_text(&line).ceil();
    // rust: (line, width)
    // rust: })
    // rust: .collect();
    // rust: let width = lines.iter().map(|l| l.1).fold(0.0, f32::max);
    // rust: Self { lines, width }
}
    /// Ten units a line, less the spacing under the last.
pub fn height(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.lines.len() as f32 * 10.0 - 1.0
}
    /// `submitInner`'s pose for the text, after the display's own: half a
    /// turn about y, the mirrored 0.025 scale and `translate(1 - width / 2,
    /// -height, 0)`.
pub fn pose(self: *Self) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: glam::Mat4::from_rotation_y(std::f32::consts::PI)
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(-0.025))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(
    // rust: 1.0 - self.width / 2.0,
    // rust: -self.height(),
    // rust: 0.0,
    // rust: ))
}
}

/// The corners of each six-vertex `HudBatch` quad that `draw` fills, in the
/// order the world draws them: `Font`'s glyphs go top left, bottom left,
/// bottom right, top right, so under `Lines::pose` they wind
/// counter-clockwise on the side the text reads from, the face the culled
/// `TEXT_POLYGON_OFFSET` and `TEXT_SEE_THROUGH` keep.
pub const CORNERS: [usize; 4] = [5, 2, 1, 0];

/// `TextDisplayRenderer.submitInner` after its `translate(1 - width / 2,
/// -height, 0)`: the background and each line, in text units, each quad's
/// `depth` its z (the background 0.01 behind, `Font.prepareBackground`).
/// `default_background` is `Options.getBackgroundOpacity(0.25)` as a colour.
    // rust: pub fn draw(
    // rust: batch: &mut crate::hud::HudBatch,
    // rust: atlas: &crate::hud::HudAtlas,
    // rust: d: &TextDisplayData,
    // rust: lines: &Lines,
    // rust: default_background: u32,
    // rust: ) {
//     use crate::hud::rgba;
    // rust: let (width, height) = (lines.width, lines.height());
    // rust: let bg = if d.flags & 4 != 0 {
    // rust: default_background
    // rust: } else {
    // rust: d.background as u32
}
    // rust: if bg != 0 {
    // rust: let start = batch.vertices.len();
    // rust: batch.fill(
    // rust: atlas,
            // submitTextBackground(-1, -1, width, height): corners, not a size.
    // rust: -1.0,
    // rust: -1.0,
    // rust: width + 1.0,
    // rust: height + 1.0,
    // rust: rgba(
    // rust: (bg >> 16) as u8,
    // rust: (bg >> 8) as u8,
    // rust: bg as u8,
    // rust: (bg >> 24) as u8,
    // rust: ),
    // rust: );
    // rust: for v in &mut batch.vertices[start..] {
    // rust: v.depth = -0.01;
}
}
    // rust: let align = d.align();
    // rust: for (i, (line, line_width)) in lines.lines.iter().enumerate() {
    // rust: let x = match align {
    // rust: Align::Left => 0.0,
    // rust: Align::Right => width - line_width,
    // rust: Align::Center => width / 2.0 - line_width / 2.0,
}
    // rust: batch.text_styled_world(
    // rust: atlas,
    // rust: line,
    // rust: x,
    // rust: i as f32 * 10.0,
    // rust: rgba(255, 255, 255, d.opacity as u8),
    // rust: d.flags & 1 != 0,
    // rust: );
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::Compound;

    /// Whether a text quad seen from `camera` (yaw, pitch, at `eye` from the
    /// display) faces it (counter-clockwise on screen, the face back-face
    /// culling keeps) and whether its text reads left to right.
pub fn seen(d: *TextDisplayData, entity: [f32; 2], camera: [f32; 2], eye: glam::Vec3) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lines = Lines {
    // rust: lines: vec![],
    // rust: width: 10.0,
}
    // rust: let mut batch = crate::hud::HudBatch::new([1, 1]);
    // rust: batch.quad(
    // rust: [[0.0, 0.0], [1.0, 0.0], [1.0, 1.0], [0.0, 1.0]],
    // rust: [[0.0; 2]; 4],
    // rust: u32::MAX,
    // rust: );
    // rust: let view_proj = glam::Mat4::perspective_rh(1.2, 1.0, 1000.0, 0.05)
    // rust: * crate::camera::view_matrix(camera[0], camera[1])
    // rust: * glam::Mat4::from_translation(-eye);
    // rust: let matrix = view_proj * d.matrix(entity, camera) * lines.pose();
    // rust: let [a, b, c, _] = CORNERS.map(|i| {
    // rust: let v = batch.vertices[i];
    // rust: matrix.project_point3(glam::Vec3::new(v.pos[0], v.pos[1], v.depth))
    // rust: });
    // rust: let ccw = (b - a).truncate().perp_dot((c - a).truncate()) > 0.0;
        // The text's x axis, from the left edge to the right, on screen.
    // rust: let right =
    // rust: matrix.project_point3(glam::Vec3::X).x > matrix.project_point3(glam::Vec3::ZERO).x;
    // rust: [ccw, right]
}

pub fn text_quads_face_the_side_they_read_from() void {
}
    // rust: let mut d = TextDisplayData::default();
        // A fixed display at yaw 0 reads from the south: in front it faces
        // the camera, from the north it shows its back, which the text
        // pipelines cull.
    // rust: assert_eq!(
    // rust: seen(&d, [0.0, 0.0], [180.0, 0.0], glam::Vec3::Z * 3.0),
    // rust: [true, true]
    // rust: );
    // rust: assert_eq!(
    // rust: seen(&d, [0.0, 0.0], [0.0, 0.0], glam::Vec3::Z * -3.0),
    // rust: [false, false]
    // rust: );
    // rust: assert_eq!(
    // rust: seen(&d, [90.0, 0.0], [-90.0, 0.0], glam::Vec3::X * -3.0),
    // rust: [true, true]
    // rust: );
        // A mirrored scale turns the readable side round with the front.
    // rust: d.scale = [-1.0, 1.0, 1.0];
    // rust: assert_eq!(
    // rust: seen(&d, [0.0, 0.0], [0.0, 0.0], glam::Vec3::Z * -3.0),
    // rust: [true, true]
    // rust: );
    // rust: assert_eq!(
    // rust: seen(&d, [0.0, 0.0], [180.0, 0.0], glam::Vec3::Z * 3.0),
    // rust: [false, false]
    // rust: );
        // Billboards face the camera from anywhere it looks at them.
    // rust: d.scale = [1.0; 3];
    // rust: for billboard in 1..=3 {
    // rust: d.billboard = billboard;
    // rust: for yaw in [0.0, 37.0, 90.0, 180.0, -135.0] {
    // rust: let pitch = if billboard == 1 { 0.0 } else { 30.0 };
    // rust: let forward = glam::Vec3::new(
    // rust: -f32::to_radians(yaw).sin() * f32::to_radians(pitch).cos(),
    // rust: -f32::to_radians(pitch).sin(),
    // rust: f32::to_radians(yaw).cos() * f32::to_radians(pitch).cos(),
    // rust: );
    // rust: let entity = if billboard == 2 {
    // rust: [180.0 + yaw, 0.0]
    // rust: } else {
    // rust: [0.0, 0.0]
}
    // rust: assert_eq!(
    // rust: seen(&d, entity, [yaw, pitch], forward * -3.0),
    // rust: [true, true],
    // rust: "billboard {billboard} at yaw {yaw}"
    // rust: );
}
}
}
pub fn partial_updates_retain_values_and_bad_vectors_do_not_panic() void {
}
    // rust: let mut d = TextDisplayData::default();
    // rust: d.apply(&[(24, 1, Value::Int(80)), (27, 0, Value::Byte(24))]);
    // rust: d.apply(&[(11, 0, Value::Floats(vec![1.0]))]);
    // rust: assert_eq!(d.line_width, 80);
    // rust: assert_eq!(d.align(), Align::Left);
    // rust: assert_eq!(d.translation, [0.0; 3]);
}
pub fn a_matrix_transformation_is_decomposed() void {
}
    // rust: let matrix = [
    // rust: 2.0, 0.0, 0.0, 1.0, 0.0, 3.0, 0.0, -2.0, 0.0, 0.0, 0.5, 0.25, 0.0, 0.0, 0.0, 1.0,
    // rust: ];
    // rust: let tag = Tag::Compound(
    // rust: [("transformation".into(), crate::save::floats(&matrix))]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: );
    // rust: let data = display_data(&tag, false);
    // rust: let part = |id: u8| data.iter().find(|e| e.0 == id).map(|e| e.2.clone());
    // rust: assert_eq!(part(11), Some(Value::Floats(vec![1.0, -2.0, 0.25])));
    // rust: assert_eq!(part(12), Some(Value::Floats(vec![2.0, 3.0, 0.5])));
    // rust: assert_eq!(part(13), None);
}
pub fn axis_angle_rotations_keep_the_axis_and_wrap_the_angle() void {
}
    // rust: let mut rotation = Compound::new();
    // rust: rotation.insert(
    // rust: "angle".into(),
    // rust: Tag::Float((-std::f32::consts::PI).to_bits()),
    // rust: );
    // rust: rotation.insert("axis".into(), crate::save::floats(&[0.0, 0.0, 2.0]));
    // rust: let mut t = Compound::new();
    // rust: t.insert("translation".into(), crate::save::floats(&[0.0; 3]));
    // rust: t.insert("scale".into(), crate::save::floats(&[1.0; 3]));
    // rust: t.insert("left_rotation".into(), Tag::Compound(rotation));
    // rust: t.insert(
    // rust: "right_rotation".into(),
    // rust: crate::save::floats(&[0.0, 0.0, 0.0, 2.0]),
    // rust: );
    // rust: let (_, left, _, right) = transformation(&Tag::Compound(t)).unwrap();
    // rust: assert_eq!(
    // rust: left,
    // rust: horizon_assets::math::quaternion_from_axis_angle(
    // rust: -std::f32::consts::PI,
    // rust: [0.0, 0.0, 2.0]
    // rust: )
    // rust: );
    // rust: assert!(left[2] > 1.9);
    // rust: assert_eq!(right, [0.0, 0.0, 0.0, 1.0]);
}

    /// `Display.updateCulling`: width or height 0 disables the frustum box.
pub fn zero_width_or_height_disables_display_culling() void {
}
    // rust: assert!(no_culling(0.0, 1.0));
    // rust: assert!(no_culling(2.0, 0.0));
    // rust: assert!(no_culling(0.0, 0.0));
    // rust: assert!(!no_culling(2.0, 1.0));
}

    /// `Display.updateCulling`: the box is width-centred on XZ and rises by height.
pub fn display_culling_box_is_centred_on_xz_and_stands_on_y() void {
}
    // rust: let (lo, hi) = culling_box(glam::DVec3::new(10.0, 64.0, -3.0), 2.0, 1.0);
    // rust: assert_eq!(lo, glam::DVec3::new(9.0, 64.0, -4.0));
    // rust: assert_eq!(hi, glam::DVec3::new(11.0, 65.0, -2.0));
}

    /// `Display$LinearFloatInterpolator`: the shadow radius and strength blend
    /// across the interpolation duration with the transformation's progress.
pub fn the_blend_interpolates_shadow_radius_and_strength() void {
}
    // rust: let from = TextDisplayData::default();
    // rust: let shown = TextDisplayData {
    // rust: shadow_radius: 2.0,
    // rust: shadow_strength: 0.25,
    // rust: ..TextDisplayData::default()
}
    // rust: let half = shown.blend(&from, 0.5);
    // rust: assert_eq!((half.shadow_radius, half.shadow_strength), (1.0, 0.625));
    // rust: assert_eq!(shown.blend(&from, 0.0).shadow_radius, 0.0);
    // rust: assert_eq!(shown.blend(&from, 1.0).shadow_strength, 0.25);
}
}
