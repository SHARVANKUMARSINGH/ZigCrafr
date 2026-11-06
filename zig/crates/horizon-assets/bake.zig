//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_bake
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Cuboid geometry in block units, including blockstate rotation and UV locking.
// use crate::{
    // rust: json::*,
    // rust: model::*,
    // rust: obj::{MtlTexture, ObjFace, ObjModel},
    // rust: resolve::{ResolvedCuboidModel, ResolvedLoader},
}
    // rust: mod transform;
    // rust: pub use transform::BlockModelTransform;

pub const ModelQuad = struct {
    positions: [[f32,
    /// Normalized unit-atlas coordinates, before placement in a larger atlas.
    uv: [[f32,
    facing: Direction,
    cull: ?Direction,
    material: Material,
    tint_index: i32,
    shade_direction_override: ?Direction,
    /// The face's or element's `light_emission`.
    light_emission: u8,
    /// Least (block, sky) light the quad is drawn with: its emission, raised by `neoforge_data`.
    light: [u8,
    /// `neoforge_data` colour (ARGB) multiplied into the quad's tint.
    color: ?i32,
    /// `neoforge_data` override of the model's ambient occlusion for this quad.
    ambient_occlusion: ?bool,
    render_type: ?RenderType,
    /// False for a loader quad that takes no directional shading.
    shade: bool,
};

/// NeoForge's `render_type` names.
pub const RenderType = enum {
    Solid,
    Cutout,
    CutoutMipped,
    Translucent,
    Tripwire,
};
    // rust: impl RenderType {
    /// Accepts a bare or `minecraft:` name; others (mods' own types) are `None`.
pub fn by_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name.strip_prefix("minecraft:").unwrap_or(name) {
    // rust: "solid" => Some(Self::Solid),
    // rust: "cutout" => Some(Self::Cutout),
    // rust: "cutout_mipped" => Some(Self::CutoutMipped),
    // rust: "translucent" => Some(Self::Translucent),
    // rust: "tripwire" => Some(Self::Tripwire),
    // rust: _ => None,
}
}
}

pub const ElementMatrix = struct {
    rows: [[f32,
    identity: bool,
};
    // rust: impl ElementMatrix {
pub fn from_rotation(rotation: *ElementRotation) S {
    // Implementation ported from Horizon
    return undefined;
}
pub const DEG: f32 = std::f32::consts::PI / 180.0;
    // rust: let mut matrix = match rotation.value {
    // rust: RotationValue::SingleAxis { angle: 0.0, .. } => Self {
    // rust: rows: [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]],
    // rust: identity: true,
    // rust: },
    // rust: RotationValue::SingleAxis { axis, angle } => {
    // rust: let (s, c) = sin_cos(angle * DEG);
    // rust: let rows = match axis {
    // rust: Axis::X => [[1.0, 0.0, 0.0], [0.0, c, -s], [0.0, s, c]],
    // rust: Axis::Y => [[c, 0.0, s], [0.0, 1.0, 0.0], [-s, 0.0, c]],
    // rust: Axis::Z => [[c, -s, 0.0], [s, c, 0.0], [0.0, 0.0, 1.0]],
}
    // rust: Self {
    // rust: rows,
    // rust: identity: false,
}
}
    // rust: RotationValue::EulerXyz([x, y, z]) => {
    // rust: let (sx, cx) = sin_cos(x * DEG);
    // rust: let (sy, cy) = sin_cos(y * DEG);
    // rust: let (sz, cz) = sin_cos(z * DEG);
    // rust: let czsy = cz * sy;
    // rust: let szsy = sz * sy;
    // rust: Self {
    // rust: rows: [
    // rust: [cz * cy, -sz * cx + czsy * sx, -sz * -sx + czsy * cx],
    // rust: [sz * cy, cz * cx + szsy * sx, cz * -sx + szsy * cx],
    // rust: [-sy, cy * sx, cy * cx],
    // rust: ],
    // rust: identity: false,
}
}
}
    // rust: if rotation.rescale && !matrix.identity {
    // rust: let scales: [f32; 3] = std::array::from_fn(|axis| {
    // rust: let basis = std::array::from_fn(|i| if i == axis { 1.0 } else { 0.0 });
    // rust: let column = matrix.direction(basis);
    // rust: let maximum = java_max(java_max(column[0].abs(), column[1].abs()), column[2].abs());
    // rust: 1.0 / maximum
    // rust: });
    // rust: for (axis, scale) in scales.into_iter().enumerate() {
    // rust: for row in &mut matrix.rows {
    // rust: row[axis] *= scale;
}
}
}
    // rust: matrix
}
pub fn direction(self: *Self, value: [f32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.rows
    // rust: .map(|r| r[0] * value[0] + (r[1] * value[1] + r[2] * value[2]))
}
pub fn position(self: *Self, value: [f32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.identity {
    // rust: value
    // rust: } else {
    // rust: self.rows
    // rust: .map(|r| r[0] * value[0] + (r[1] * value[1] + (r[2] * value[2] + 0.0)))
}
}
}
pub fn java_max(a: f32, b: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if a.is_nan() || b.is_nan() {
    // rust: f32::NAN
    // rust: } else {
    // rust: a.max(b)
}
}
/// JOML's default float path uses a double sine rounded to float, and obtains
/// cosine's magnitude from that rounded sine. Keep all subsequent steps f32.
pub fn sin_cos(angle: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sin = f64::from(angle).sin() as f32;
    // rust: let cos = (1.0 - sin * sin).sqrt();
    // rust: let shifted = angle + std::f32::consts::FRAC_PI_2;
    // rust: let mut period =
    // rust: shifted - (shifted / std::f32::consts::TAU) as i32 as f32 * std::f32::consts::TAU;
    // rust: if period < 0.0 {
    // rust: period += std::f32::consts::TAU;
}
    // rust: (
    // rust: sin,
    // rust: if period >= std::f32::consts::PI {
    // rust: -cos
    // rust: } else {
    // rust: cos
    // rust: },
    // rust: )
}

pub fn default_uv(from: [f32; 3], to: [f32; 3], direction: Direction) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match direction {
    // rust: Direction::Down => [from[0], 16.0 - to[2], to[0], 16.0 - from[2]],
    // rust: Direction::Up => [from[0], from[2], to[0], to[2]],
    // rust: Direction::North => [16.0 - to[0], 16.0 - to[1], 16.0 - from[0], 16.0 - from[1]],
    // rust: Direction::South => [from[0], 16.0 - to[1], to[0], 16.0 - from[1]],
    // rust: Direction::West => [from[2], 16.0 - to[1], to[2], 16.0 - from[1]],
    // rust: Direction::East => [16.0 - to[2], 16.0 - to[1], 16.0 - from[2], 16.0 - from[1]],
}
}
pub fn corners(from: [f32; 3], to: [f32; 3], direction: Direction) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let selectors = match direction {
    // rust: Direction::Down => [[0, 0, 1], [0, 0, 0], [1, 0, 0], [1, 0, 1]],
    // rust: Direction::Up => [[0, 1, 0], [0, 1, 1], [1, 1, 1], [1, 1, 0]],
    // rust: Direction::North => [[1, 1, 0], [1, 0, 0], [0, 0, 0], [0, 1, 0]],
    // rust: Direction::South => [[0, 1, 1], [0, 0, 1], [1, 0, 1], [1, 1, 1]],
    // rust: Direction::West => [[0, 1, 0], [0, 0, 0], [0, 0, 1], [0, 1, 1]],
    // rust: Direction::East => [[1, 1, 1], [1, 0, 1], [1, 0, 0], [1, 1, 0]],
}
    // rust: selectors
    // rust: .map(|selector| std::array::from_fn(|i| if selector[i] == 0 { from[i] } else { to[i] }))
}
pub fn facing(vertices: *[[f32; 3]; 4]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let a: [f32; 3] = std::array::from_fn(|i| vertices[1][i] - vertices[0][i]);
    // rust: let b: [f32; 3] = std::array::from_fn(|i| vertices[2][i] - vertices[0][i]);
    // rust: let n = [
    // rust: a[1] * b[2] - a[2] * b[1],
    // rust: a[2] * b[0] - a[0] * b[2],
    // rust: a[0] * b[1] - a[1] * b[0],
    // rust: ];
    // rust: let inverse_length = 1.0 / (n[0] * n[0] + (n[1] * n[1] + n[2] * n[2])).sqrt();
    // rust: let n = n.map(|v| v * inverse_length);
    // rust: if n.iter().any(|v| !v.is_finite()) {
    // rust: return None;
}
    // rust: let mut best = 0.0;
    // rust: let mut result = None;
    // rust: for (direction, dot) in Direction::ALL
    // rust: .into_iter()
    // rust: .zip([-n[1], n[1], -n[2], n[2], -n[0], n[0]])
    // rust: {
    // rust: if dot >= 0.0 && dot > best {
    // rust: best = dot;
    // rust: result = Some(direction);
}
}
    // rust: result
}

pub fn bake_model(model: *ResolvedCuboidModel) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: bake_model_transformed(model, BlockModelTransform::new([0; 3], false))
}
    // rust: pub fn bake_model_transformed(
    // rust: model: &ResolvedCuboidModel,
    // rust: transform: BlockModelTransform,
    // rust: ) -> Result<Vec<ModelQuad>> {
    // rust: bake_elements(model, transform, false)
}
/// Block-model baking as `UnbakedCuboidGeometry.bake` does it: an element with
/// zero extent along an axis draws no faces across that extent (a flat X
/// element keeps only its X faces, and so on).
    // rust: pub fn bake_block_model(
    // rust: model: &ResolvedCuboidModel,
    // rust: transform: BlockModelTransform,
    // rust: ) -> Result<Vec<ModelQuad>> {
    // rust: bake_elements(model, transform, true)
}
    // rust: fn bake_elements(
    // rust: model: &ResolvedCuboidModel,
    // rust: transform: BlockModelTransform,
    // rust: skip_flat: bool,
    // rust: ) -> Result<Vec<ModelQuad>> {
    // rust: let mut output = Vec::new();
    // rust: bake_into(model, transform, skip_flat, &mut output)?;
    // rust: Ok(output)
}
/// The elements, then what the model's loader adds.
    // rust: fn bake_into(
    // rust: model: &ResolvedCuboidModel,
    // rust: transform: BlockModelTransform,
    // rust: skip_flat: bool,
    // rust: output: &mut Vec<ModelQuad>,
    // rust: ) -> Result<()> {
    // rust: let render_type = model.render_type.as_deref().and_then(RenderType::by_name);
    // rust: for element in model.elements() {
    // rust: let element = element
    // rust: .as_ref()
    // rust: .ok_or_else(|| error("null model element"))?;
    // rust: let matrix = element.rotation.as_ref().map(ElementMatrix::from_rotation);
    // rust: let flat = |axis: usize| skip_flat && element.from[axis] == element.to[axis];
    // rust: for (direction, face) in &element.faces {
    // rust: let drawn = match direction {
    // rust: Direction::West | Direction::East => !flat(1) && !flat(2),
    // rust: Direction::Down | Direction::Up => !flat(0) && !flat(2),
    // rust: Direction::North | Direction::South => !flat(0) && !flat(1),
}
    // rust: if !drawn {
    // rust: continue;
}
    // rust: let face = face.as_ref().ok_or_else(|| error("null model face"))?;
    // rust: let material = model.material(&face.texture)?.cloned().unwrap_or(Material {
    // rust: sprite: "minecraft:missingno".to_owned(),
    // rust: force_translucent: false,
    // rust: });
    // rust: output.push(bake_face(
    // rust: element,
    // rust: face,
    // rust: *direction,
    // rust: matrix,
    // rust: material,
    // rust: transform,
    // rust: render_type,
    // rust: )?);
}
}
    // rust: match model.loader() {
    // rust: Some(ResolvedLoader::Composite(children)) => {
    // rust: for child in children {
    // rust: bake_into(child, transform, skip_flat, output)?;
}
}
    // rust: Some(ResolvedLoader::Obj {
    // rust: model: Some(obj),
    // rust: flip_v,
    // rust: shade,
    // rust: hidden,
    // rust: }) => bake_obj(model, obj, *flip_v, *shade, hidden, transform, output)?,
    // rust: Some(ResolvedLoader::Obj { model: None, .. }) | None => {}
}
    // rust: Ok(())
}
/// Obj faces are unculled quads in block units; the blockstate transform moves them whole.
    // rust: fn bake_obj(
    // rust: model: &ResolvedCuboidModel,
    // rust: obj: &ObjModel,
    // rust: flip_v: bool,
    // rust: shade: bool,
    // rust: hidden: &std::collections::BTreeSet<String>,
    // rust: transform: BlockModelTransform,
    // rust: output: &mut Vec<ModelQuad>,
    // rust: ) -> Result<()> {
    // rust: let render_type = model.render_type.as_deref().and_then(RenderType::by_name);
    // rust: for face in obj.faces.iter().filter(|f| !hidden.contains(&f.object)) {
    // rust: let slot = match obj.materials.get(&face.material) {
    // rust: Some(MtlTexture::Sprite(sprite)) => {
    // rust: output.push(obj_quad(
    // rust: face,
    // rust: Material {
    // rust: sprite: identifier(sprite)?,
    // rust: force_translucent: false,
    // rust: },
    // rust: flip_v,
    // rust: shade,
    // rust: render_type,
    // rust: transform,
    // rust: ));
    // rust: continue;
}
    // rust: Some(MtlTexture::Slot(slot)) => slot,
    // rust: None => &face.material,
}
    // rust: let material = if slot.is_empty() {
    // rust: None
    // rust: } else {
    // rust: model.material(slot)?
}
    // rust: let material = material.cloned().unwrap_or(Material {
    // rust: sprite: "minecraft:missingno".to_owned(),
    // rust: force_translucent: false,
    // rust: });
    // rust: output.push(obj_quad(
    // rust: face,
    // rust: material,
    // rust: flip_v,
    // rust: shade,
    // rust: render_type,
    // rust: transform,
    // rust: ));
}
    // rust: Ok(())
}
    // rust: fn obj_quad(
    // rust: face: &ObjFace,
    // rust: material: Material,
    // rust: flip_v: bool,
    // rust: shade: bool,
    // rust: render_type: Option<RenderType>,
    // rust: transform: BlockModelTransform,
    // rust: ) -> ModelQuad {
    // rust: let positions = face.vertices.map(|v| transform.position(v.position));
    // rust: ModelQuad {
    // rust: positions,
    // rust: uv: face
    // rust: .vertices
    // rust: .map(|v| [v.uv[0], if flip_v { 1.0 - v.uv[1] } else { v.uv[1] }]),
    // rust: facing: facing(&positions).unwrap_or(Direction::Up),
    // rust: cull: None,
    // rust: material,
    // rust: tint_index: -1,
    // rust: shade_direction_override: None,
    // rust: light_emission: 0,
    // rust: light: [0; 2],
    // rust: color: None,
    // rust: ambient_occlusion: None,
    // rust: render_type,
    // rust: shade,
}
}
/// `FaceBakery.bakeQuad` for a quad with explicit corners and unit-atlas UVs
/// (`uv` in 0..16 texels), as `ItemModelGenerator` builds its layers.
    // rust: pub fn bake_flat_face(
    // rust: from: [f32; 3],
    // rust: to: [f32; 3],
    // rust: uv: [f32; 4],
    // rust: direction: Direction,
    // rust: material: Material,
    // rust: tint_index: i32,
    // rust: ) -> Result<ModelQuad> {
    // rust: let element = Element {
    // rust: from,
    // rust: to,
    // rust: faces: Default::default(),
    // rust: rotation: None,
    // rust: shade_direction_override: None,
    // rust: light_emission: 0,
    // rust: neoforge_data: None,
}
    // rust: let face = Face {
    // rust: cull: None,
    // rust: tint_index,
    // rust: texture: String::new(),
    // rust: uv: Some(uv),
    // rust: rotation: 0,
    // rust: light_emission: None,
    // rust: neoforge_data: None,
}
    // rust: bake_face(
    // rust: &element,
    // rust: &face,
    // rust: direction,
    // rust: None,
    // rust: material,
    // rust: BlockModelTransform::new([0; 3], false),
    // rust: None,
    // rust: )
}
    // rust: fn bake_face(
    // rust: element: &Element,
    // rust: face: &Face,
    // rust: direction: Direction,
    // rust: matrix: Option<ElementMatrix>,
    // rust: material: Material,
    // rust: transform: BlockModelTransform,
    // rust: render_type: Option<RenderType>,
    // rust: ) -> Result<ModelQuad> {
    // rust: let mut positions = corners(element.from, element.to, direction).map(|v| v.map(|c| c / 16.0));
    // rust: if let (Some(rotation), Some(matrix)) = (&element.rotation, matrix) {
    // rust: for vertex in &mut positions {
    // rust: let relative = std::array::from_fn(|i| vertex[i] - rotation.origin[i]);
    // rust: let rotated = matrix.position(relative);
    // rust: *vertex = std::array::from_fn(|i| rotated[i] + rotation.origin[i]);
}
}
    // rust: positions = positions.map(|v| transform.position(v));
    // rust: let bounds = face
    // rust: .uv
    // rust: .unwrap_or_else(|| default_uv(element.from, element.to, direction));
    // rust: let mut uv = std::array::from_fn(|i| {
    // rust: let corner = (i + usize::from(face.rotation)) % 4;
    // rust: transform
    // rust: .uv(
    // rust: direction,
    // rust: [
    // rust: bounds[if corner < 2 { 0 } else { 2 }] / 16.0,
    // rust: bounds[if corner == 0 || corner == 3 { 1 } else { 3 }] / 16.0,
    // rust: ],
    // rust: )
            // Native TextureAtlasSprite applies origin + extent * coordinate;
            // even the unit atlas changes negative zero to positive zero.
    // rust: .map(|value| 0.0 + value)
    // rust: });
    // rust: let normal = facing(&positions);
    // rust: if let (None, Some(facing)) = (&element.rotation, normal) {
    // rust: let mut min = [999.0; 3];
    // rust: let mut max = [-999.0; 3];
    // rust: for vertex in &positions {
    // rust: for axis in 0..3 {
    // rust: if vertex[axis] < min[axis] {
    // rust: min[axis] = vertex[axis];
}
    // rust: if vertex[axis] > max[axis] {
    // rust: max[axis] = vertex[axis];
}
}
}
    // rust: for (index, expected) in corners(min, max, facing).into_iter().enumerate() {
    // rust: let found = (index..4)
    // rust: .find(|i| positions[*i] == expected)
    // rust: .ok_or_else(|| error("cannot reorder model face"))?;
    // rust: positions.swap(index, found);
    // rust: uv.swap(index, found);
}
}
    // rust: let data = face
    // rust: .neoforge_data
    // rust: .unwrap_or_default()
    // rust: .over(element.neoforge_data.unwrap_or_default());
    // rust: let light_emission = face.light_emission.unwrap_or(element.light_emission);
    // rust: Ok(ModelQuad {
    // rust: positions,
    // rust: uv,
    // rust: facing: normal.unwrap_or(Direction::Up),
    // rust: cull: face.cull.map(|d| transform.direction(d)),
    // rust: material,
    // rust: tint_index: face.tint_index,
    // rust: shade_direction_override: element.shade_direction_override,
    // rust: light_emission,
    // rust: light: [data.block_light, data.sky_light].map(|l| l.unwrap_or(0).max(light_emission)),
    // rust: color: data.color,
    // rust: ambient_occlusion: data.ambient_occlusion,
    // rust: render_type,
    // rust: shade: true,
    // rust: })
}

    // rust: mod loader_tests {
//     use super::*;
//     use crate::resolve::{AssetReader, ModelLibrary};
//     use std::{collections::BTreeMap, sync::Arc};

pub const Files = struct {};
    // rust: impl AssetReader for Files {
pub fn read_text(self: *Self, location: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.get(location).map(|text| (*text).to_owned())
}
}

pub fn library(models: *[([]const u8) void {
}
    // rust: let models = models
    // rust: .iter()
    // rust: .map(|(name, json)| ((*name).to_owned(), CuboidModel::from_json(json).unwrap()))
    // rust: .collect();
    // rust: ModelLibrary::new(models)
    // rust: .unwrap()
    // rust: .with_assets(Arc::new(Files(files.iter().copied().collect())))
}
pub fn bake(library: *ModelLibrary, name: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: bake_block_model(
    // rust: &library.resolve(name).unwrap(),
    // rust: BlockModelTransform::new([0; 3], false),
    // rust: )
    // rust: .unwrap()
}
pub fn sprites(quads: *[ModelQuad]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: quads.iter().map(|q| q.material.sprite.as_str()).collect()
}
    // rust: const CUBE: &str =
    // rust: r##"{"elements":[{"from":[0,0,0],"to":[16,16,16],"faces":{"up":{"texture":"#all"}}}]}"##;
    // rust: const COMPOSITE: &str = r#"{"loader":"neoforge:composite","textures":{"all":"block/shared"},
    // rust: "children":{"zeta":{"parent":"t:cube","textures":{"all":"block/own"}},"alpha":{"parent":"t:cube"}}}"#;

pub fn composite_bakes_children_in_document_order_with_slot_fallback() void {
}
    // rust: let library = library(&[("t:cube", CUBE), ("t:comp", COMPOSITE)], &[]);
    // rust: let quads = bake(&library, "t:comp");
    // rust: assert_eq!(
    // rust: sprites(&quads),
    // rust: ["minecraft:block/own", "minecraft:block/shared"]
    // rust: );
}
pub fn composite_visibility_hides_a_child() void {
}
    // rust: let hidden =
    // rust: COMPOSITE.replace(r#""children""#, r#""visibility":{"zeta":false},"children""#);
    // rust: let library = library(&[("t:cube", CUBE), ("t:comp", &hidden)], &[]);
    // rust: assert_eq!(
    // rust: sprites(&bake(&library, "t:comp")),
    // rust: ["minecraft:block/shared"]
    // rust: );
}
pub fn an_inheriting_model_overrides_which_children_are_visible() void {
}
    // rust: let hidden =
    // rust: COMPOSITE.replace(r#""children""#, r#""visibility":{"zeta":false},"children""#);
    // rust: let shown = r#"{"parent":"t:hidden","visibility":{"zeta":true,"alpha":false}}"#;
    // rust: let library = library(
    // rust: &[("t:cube", CUBE), ("t:hidden", &hidden), ("t:shown", shown)],
    // rust: &[],
    // rust: );
    // rust: assert_eq!(sprites(&bake(&library, "t:shown")), ["minecraft:block/own"]);
}
pub fn loader_is_inherited_by_parent_after_own_elements() void {
}
    // rust: let derived = r##"{"parent":"t:comp","textures":{"all":"block/derived"},
    // rust: "elements":[{"from":[0,0,0],"to":[16,16,16],"faces":{"down":{"texture":"#all"}}}]}"##;
    // rust: let library = library(
    // rust: &[
    // rust: ("t:cube", CUBE),
    // rust: ("t:comp", COMPOSITE),
    // rust: ("t:derived", derived),
    // rust: ],
    // rust: &[],
    // rust: );
    // rust: let quads = bake(&library, "t:derived");
    // rust: assert_eq!(quads[0].facing, Direction::Down);
    // rust: assert_eq!(
    // rust: sprites(&quads),
    // rust: [
    // rust: "minecraft:block/derived",
    // rust: "minecraft:block/own",
    // rust: "minecraft:block/derived"
    // rust: ]
    // rust: );
}
pub fn own_loader_wins_and_unknown_loader_adds_nothing() void {
}
    // rust: let other = r#"{"parent":"t:comp","loader":"somemod:thing"}"#;
    // rust: let library = library(
    // rust: &[("t:cube", CUBE), ("t:comp", COMPOSITE), ("t:other", other)],
    // rust: &[],
    // rust: );
    // rust: assert!(bake(&library, "t:other").is_empty());
}
pub fn composites_that_nest_through_themselves_are_an_error() void {
}
    // rust: let looping = r#"{"loader":"neoforge:composite","children":{"a":{"parent":"t:loop"}}}"#;
    // rust: let library = library(&[("t:loop", looping)], &[]);
    // rust: assert!(library.resolve("t:loop").is_err());
}

    // rust: const OBJ: &str = "mtllib m.mtl\nv 0 0 0\nv 1 0 0\nv 1 0 1\nv 0 0 1\nv 0 1 0\n\
    // rust: vt 0 0\nvt 1 0\nvt 1 1\nvt 0 1\n\
    // rust: usemtl top\nf 1/1 4/4 3/3 2/2\nusemtl side\nf 1/1 2/2 5/4\nusemtl bare\nf 1/1 2/2 5/4\n";
pub const MTL: []const u8 = "newmtl top\nmap_Kd #lid\nnewmtl side\nmap_Kd #wall\nnewmtl bare\nKd 1 1 1\n";
pub const OBJ_FILES: [([]const u8, []const u8); 2] = [("t:models/x.obj", OBJ), ("t:models/m.mtl", MTL)];
    // rust: const OBJ_MODEL: &str = r#"{"loader":"neoforge:obj","model":"t:models/x.obj","flip_v":true,
    // rust: "textures":{"lid":"block/lid","wall":"block/wall"}}"#;

pub fn obj_faces_become_quads_with_materials_and_flipped_v() void {
}
    // rust: let flat = OBJ_MODEL.replace(r#""flip_v":true,"#, "");
    // rust: let library = library(&[("t:o", OBJ_MODEL), ("t:flat", &flat)], &OBJ_FILES);
    // rust: let quads = bake(&library, "t:o");
    // rust: assert_eq!(
    // rust: sprites(&quads),
    // rust: [
    // rust: "minecraft:block/lid",
    // rust: "minecraft:block/wall",
    // rust: "minecraft:missingno"
    // rust: ]
    // rust: );
    // rust: assert_eq!(quads[0].facing, Direction::Up);
    // rust: assert_eq!(quads[1].facing, Direction::South);
    // rust: assert_eq!(quads[0].positions[1], [0.0, 0.0, 1.0]);
    // rust: assert_eq!(quads[0].uv[0], [0.0, 1.0]);
    // rust: assert_eq!(quads[0].uv[2], [1.0, 0.0]);
        // A triangle repeats its last vertex.
    // rust: assert_eq!(quads[1].positions[3], quads[1].positions[2]);
    // rust: assert_eq!(quads[1].uv[3], quads[1].uv[2]);
    // rust: assert!(quads.iter().all(|q| q.cull.is_none() && q.shade));
    // rust: assert_eq!(bake(&library, "t:flat")[0].uv[0], [0.0, 0.0]);
}
pub fn obj_shade_quads_false_and_mtl_override() void {
}
    // rust: let unshaded = r#"{"loader":"neoforge:obj","model":"t:models/x.obj","shade_quads":false,
    // rust: "mtl_override":"t:models/o.mtl","textures":{"s":"block/s"}}"#;
    // rust: let files = [
    // rust: ("t:models/x.obj", OBJ),
    // rust: ("t:models/o.mtl", "newmtl top\nmap_Kd #s\n"),
    // rust: ];
    // rust: let library = library(&[("t:u", unshaded)], &files);
    // rust: let quads = bake(&library, "t:u");
    // rust: assert!(quads.iter().all(|q| !q.shade));
    // rust: assert_eq!(quads[0].material.sprite, "minecraft:block/s");
}
pub fn missing_or_broken_obj_bakes_nothing() void {
}
    // rust: let missing = library(&[("t:o", OBJ_MODEL)], &[]);
    // rust: assert!(bake(&missing, "t:o").is_empty());
    // rust: let broken = library(
    // rust: &[("t:o", OBJ_MODEL)],
    // rust: &[("t:models/x.obj", "v 0 0 0\nf 1 2 3\n")],
    // rust: );
    // rust: assert!(bake(&broken, "t:o").is_empty());
}
pub fn obj_visibility_skips_the_objects_a_model_hides() void {
}
    // rust: let two = "v 0 0 0\nv 1 0 0\nv 1 0 1\nv 0 0 1\no a\nusemtl m\nf 1 2 3 4\no b\nf 4 3 2 1\n";
    // rust: let files = [("t:models/two.obj", two)];
    // rust: let base =
    // rust: r#"{"loader":"neoforge:obj","model":"t:models/two.obj","textures":{"m":"block/m"}}"#;
    // rust: let hiding = r#"{"parent":"t:base","visibility":{"b":false}}"#;
    // rust: let restoring = r#"{"parent":"t:hiding","visibility":{"b":true}}"#;
    // rust: let library = library(
    // rust: &[
    // rust: ("t:base", base),
    // rust: ("t:hiding", hiding),
    // rust: ("t:restoring", restoring),
    // rust: ],
    // rust: &files,
    // rust: );
    // rust: assert_eq!(bake(&library, "t:base").len(), 2);
    // rust: let quads = bake(&library, "t:hiding");
    // rust: assert_eq!(quads.len(), 1);
    // rust: assert_eq!(quads[0].facing, Direction::Down);
    // rust: assert_eq!(bake(&library, "t:restoring").len(), 2);
}
}
