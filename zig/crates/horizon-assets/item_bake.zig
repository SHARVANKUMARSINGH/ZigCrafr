//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_item_bake
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Baking of item models: a cuboid model's quads, or the layer extrusion of
//! `builtin/generated` (`ItemModelGenerator`), with the display transforms
//! and render properties a `CuboidItemModelWrapper` keeps.
// use crate::{
    // rust: bake::{ModelQuad, bake_block_model, bake_flat_face},
    // rust: item_model::DisplayContext,
    // rust: json::Result,
    // rust: math::{Mat4, quaternion_xyz},
    // rust: model::{Direction, DisplayTransform, GuiLight, ItemTransform, Material},
    // rust: resolve::{ModelLibrary, ResolvedCuboidModel},
}
// use std::{collections::BTreeSet, f32::consts::PI};

pub const MISSING_SPRITE: []const u8 = "minecraft:missingno";

/// The alpha of every unique animation frame of a sprite.
pub const SpriteMask = struct {
    width: usize,
    height: usize,
    /// `frames[f][y * width + x]` is true for alpha 0.
    frames: std.ArrayList(Vec<bool)>,
};
    // rust: impl SpriteMask {
pub fn opaque(width: usize, height: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: width,
    // rust: height,
    // rust: frames: vec![vec![false; width * height]],
}
}
pub fn transparent(self: *Self, frame: usize, x: i64, y: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if x < 0 || y < 0 || x >= self.width as i64 || y >= self.height as i64 {
    // rust: return true;
}
    // rust: self.frames[frame][y as usize * self.width + x as usize]
}
}
/// The sprites of the item and block atlases.
    // rust: pub trait SpriteLookup {
    /// `None` when the sprite is in neither atlas (the missing sprite stands in).
pub fn mask(self: *Self, sprite: []const u8) O;
}

pub const BakedItemModel = struct {
    /// `QuadCollection.getAll`: unculled quads, then north, south, east,
    /// west, up and down.
    quads: std.ArrayList(ModelQuad),
    /// `gui_light: side`.
    uses_block_light: bool,
    particle: Material,
    /// By [`crate::model::DISPLAY_CONTEXTS`]; `None` is `NO_TRANSFORM`.
    transforms: [?ItemTransform,
};

pub fn context_index(context: DisplayContext) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match context {
    // rust: DisplayContext::None => return None,
    // rust: DisplayContext::ThirdPersonLeftHand => 0,
    // rust: DisplayContext::ThirdPersonRightHand => 1,
    // rust: DisplayContext::FirstPersonLeftHand => 2,
    // rust: DisplayContext::FirstPersonRightHand => 3,
    // rust: DisplayContext::Head => 4,
    // rust: DisplayContext::Gui => 5,
    // rust: DisplayContext::Ground => 6,
    // rust: DisplayContext::Fixed => 7,
    // rust: DisplayContext::OnShelf => 8,
    // rust: })
}
    // rust: impl BakedItemModel {
    /// `ItemTransforms.getTransform`.
pub fn transform(self: *Self, context: DisplayContext) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: context_index(context).and_then(|i| self.transforms[i].as_ref())
}
    /// `LayerRenderState.applyTransform`: the display transform followed by
    /// the item model's own local transformation.
pub fn layer_matrix(self: *Self, context: DisplayContext, local: *Mat4) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: item_transform_matrix(self.transform(context), context.left_hand()).mul(local)
}
}
/// `ItemTransform.apply` on an identity pose.
pub fn item_transform_matrix(transform: ?*ItemTransform, left_hand: bool) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(t) = transform else {
    // rust: return Mat4::IDENTITY.translate([-0.5, -0.5, -0.5]);
}
    // rust: let (tx, ry, rz) = if left_hand {
    // rust: (-t.translation[0], -t.rotation[1], -t.rotation[2])
    // rust: } else {
    // rust: (t.translation[0], t.rotation[1], t.rotation[2])
}
    // rust: let radians = PI / 180.0;
    // rust: Mat4::IDENTITY
    // rust: .translate([tx, t.translation[1], t.translation[2]])
    // rust: .rotate(quaternion_xyz(
    // rust: t.rotation[0] * radians,
    // rust: ry * radians,
    // rust: rz * radians,
    // rust: ))
    // rust: .scale(t.scale)
    // rust: .translate([-0.5, -0.5, -0.5])
}

/// Bake the top geometry of `name` the way `CuboidItemModelWrapper` does.
    // rust: pub fn bake_item_model(
    // rust: library: &ModelLibrary,
    // rust: sprites: &dyn SpriteLookup,
    // rust: name: &str,
    // rust: ) -> Result<BakedItemModel> {
    // rust: let model = library
    // rust: .resolve(name)
    // rust: .or_else(|_| library.resolve(crate::resolve::MISSING_MODEL))?;
    // rust: bake_resolved(&model, sprites)
}

/// Bake an already resolved model, e.g. one from
/// [`ModelLibrary::resolve_with_textures`].
    // rust: pub fn bake_resolved(
    // rust: model: &ResolvedCuboidModel,
    // rust: sprites: &dyn SpriteLookup,
    // rust: ) -> Result<BakedItemModel> {
    // rust: let known = |sprite: &str| sprite == MISSING_SPRITE || sprites.mask(sprite).is_some();
    // rust: let material = |m: &Material| {
    // rust: if known(&m.sprite) {
    // rust: m.clone()
    // rust: } else {
    // rust: Material {
    // rust: sprite: MISSING_SPRITE.to_owned(),
    // rust: force_translucent: m.force_translucent,
}
}
}
    // rust: let quads = if model.uses_item_generator() {
    // rust: let mut quads = Vec::new();
    // rust: for (layer, slot) in ["layer0", "layer1", "layer2", "layer3", "layer4"]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let Some(m) = model.material(slot)? else {
    // rust: break;
}
    // rust: let m = material(m);
    // rust: let mask = if m.sprite == MISSING_SPRITE {
    // rust: SpriteMask::opaque(16, 16)
    // rust: } else {
    // rust: sprites
    // rust: .mask(&m.sprite)
    // rust: .unwrap_or_else(|| SpriteMask::opaque(16, 16))
}
    // rust: quads.extend(extrude_layer(&mask, &m, layer as i32)?);
}
    // rust: quads
    // rust: } else {
    // rust: let mut quads =
    // rust: bake_block_model(model, crate::bake::BlockModelTransform::new([0; 3], false))?;
    // rust: for q in &mut quads {
    // rust: q.material = material(&q.material);
}
        // `QuadCollection.Builder.build`: unculled, then each culled direction.
    // rust: let mut ordered: Vec<ModelQuad> =
    // rust: quads.iter().filter(|q| q.cull.is_none()).cloned().collect();
    // rust: for side in [
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: Direction::East,
    // rust: Direction::West,
    // rust: Direction::Up,
    // rust: Direction::Down,
    // rust: ] {
    // rust: ordered.extend(quads.iter().filter(|q| q.cull == Some(side)).cloned());
}
    // rust: ordered
}
    // `resolveParticleMaterial`: a missing `particle` slot is the missing sprite.
    // rust: let particle = model.material("particle")?.map_or_else(
    // rust: || Material {
    // rust: sprite: MISSING_SPRITE.to_owned(),
    // rust: force_translucent: false,
    // rust: },
    // rust: material,
    // rust: );
    // rust: let transforms = std::array::from_fn(|i| match &model.display.contexts[i] {
    // rust: DisplayTransform::Explicit(Some(t)) => Some(t.clone()),
    // rust: _ => None,
    // rust: });
    // rust: Ok(BakedItemModel {
    // rust: quads,
    // rust: uses_block_light: model.gui_light == GuiLight::Side,
    // rust: particle,
    // rust: transforms,
    // rust: })
}
pub const Side = enum {
    Up,
    Down,
    Left,
    Right,
};
    // rust: impl Side {
pub fn step(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Up => (0, 1),
    // rust: Self::Down => (0, -1),
    // rust: Self::Left => (1, 0),
    // rust: Self::Right => (-1, 0),
}
}
pub fn direction(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Up => Direction::Up,
    // rust: Self::Down => Direction::Down,
    // rust: Self::Left => Direction::East,
    // rust: Self::Right => Direction::West,
}
}
}

/// `ItemModelGenerator.bakeExtrudedSprite` for one layer: the front and back
/// faces and one thin face per opaque/transparent pixel edge. The native
/// client collects the sides in a hash set, so their order is unspecified;
/// they are emitted sorted by pixel here.
pub fn extrude_layer(mask: *SpriteMask, material: *Material, layer: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let from = [0.0, 0.0, 7.5];
    // rust: let to = [16.0, 16.0, 8.5];
    // rust: let mut quads = vec![
    // rust: bake_flat_face(
    // rust: from,
    // rust: to,
    // rust: [0.0, 0.0, 16.0, 16.0],
    // rust: Direction::South,
    // rust: material.clone(),
    // rust: layer,
    // rust: )?,
    // rust: bake_flat_face(
    // rust: from,
    // rust: to,
    // rust: [16.0, 0.0, 0.0, 16.0],
    // rust: Direction::North,
    // rust: material.clone(),
    // rust: layer,
    // rust: )?,
    // rust: ];
    // rust: let (width, height) = (mask.width as i64, mask.height as i64);
    // rust: let mut faces = BTreeSet::new();
    // rust: for frame in 0..mask.frames.len() {
    // rust: for y in 0..height {
    // rust: for x in 0..width {
    // rust: if mask.transparent(frame, x, y) {
    // rust: continue;
}
    // rust: for side in [Side::Up, Side::Down, Side::Left, Side::Right] {
    // rust: let (sx, sy) = side.step();
    // rust: if mask.transparent(frame, x - sx, y - sy) {
    // rust: faces.insert((y, x, side));
}
}
}
}
}
    // rust: let x_scale = 16.0 / mask.width as f32;
    // rust: let y_scale = 16.0 / mask.height as f32;
    // rust: for (y, x, side) in faces {
    // rust: let (x, y) = (x as f32, y as f32);
    // rust: let u0 = x + 0.1;
    // rust: let u1 = x + 1.0 - 0.1;
    // rust: let (v0, v1) = if matches!(side, Side::Up | Side::Down) {
    // rust: (y + 0.1, y + 1.0 - 0.1)
    // rust: } else {
    // rust: (y + 1.0 - 0.1, y + 0.1)
}
    // rust: let (mut start_x, mut start_y, mut end_x, mut end_y) = (x, y, x, y);
    // rust: match side {
    // rust: Side::Up => end_x += 1.0,
    // rust: Side::Down => {
    // rust: end_x += 1.0;
    // rust: start_y += 1.0;
    // rust: end_y += 1.0;
}
    // rust: Side::Left => end_y += 1.0,
    // rust: Side::Right => {
    // rust: start_x += 1.0;
    // rust: end_x += 1.0;
    // rust: end_y += 1.0;
}
}
    // rust: start_x *= x_scale;
    // rust: end_x *= x_scale;
    // rust: start_y *= y_scale;
    // rust: end_y *= y_scale;
    // rust: start_y = 16.0 - start_y;
    // rust: end_y = 16.0 - end_y;
    // rust: let (from, to) = match side {
    // rust: Side::Up => ([start_x, start_y, 7.5], [end_x, start_y, 8.5]),
    // rust: Side::Down => ([start_x, end_y, 7.5], [end_x, end_y, 8.5]),
    // rust: Side::Left => ([start_x, start_y, 7.5], [start_x, end_y, 8.5]),
    // rust: Side::Right => ([end_x, start_y, 7.5], [end_x, end_y, 8.5]),
}
    // rust: quads.push(bake_flat_face(
    // rust: from,
    // rust: to,
    // rust: [u0 * x_scale, v0 * y_scale, u1 * x_scale, v1 * y_scale],
    // rust: side.direction(),
    // rust: material.clone(),
    // rust: layer,
    // rust: )?);
}
    // rust: Ok(quads)
}

    // rust: mod tests {
//     use super::*;
//     use crate::model::{CuboidModel, TextureSlot};
//     use std::collections::BTreeMap;

    /// The stick: 2x2 with one transparent pixel. `item/cit`: one opaque pixel, so a bake
    /// shows whose mask it extruded.
pub const Sprites = struct {};
    // rust: impl SpriteLookup for Sprites {
pub fn mask(self: *Self, sprite: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match sprite {
    // rust: "minecraft:item/stick" => Some(SpriteMask {
    // rust: width: 2,
    // rust: height: 2,
    // rust: frames: vec![vec![true, false, false, false]],
    // rust: }),
    // rust: "horizon_cit:item/cit" => Some(SpriteMask {
    // rust: width: 1,
    // rust: height: 1,
    // rust: frames: vec![vec![false]],
    // rust: }),
    // rust: _ => None,
}
}
}
pub fn library() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ModelLibrary::with_item_generator(BTreeMap::from(
    // rust: [
    // rust: ("item/generated", r#"{"parent":"builtin/generated","display":{"gui":{"scale":[2,2,2]}}}"#),
    // rust: ("item/stick", r#"{"parent":"item/generated","textures":{"layer0":"item/stick"}}"#),
    // rust: ("horizon:loop", r#"{"parent":"horizon:loop2"}"#),
    // rust: ("horizon:loop2", r#"{"parent":"horizon:loop"}"#),
    // rust: ("block/slab", r##"{"textures":{"particle":"#side","side":"block/absent"},"elements":[{"from":[0,0,0],"to":[16,8,16],"faces":{"up":{"texture":"#side"},"down":{"texture":"#side","cullface":"down"}}}]}"##),
    // rust: ]
    // rust: .map(|(name, json)| (name.to_owned(), CuboidModel::from_json(json).unwrap())),
    // rust: ))
    // rust: .unwrap()
}
pub fn baking_by_name_falls_back_to_the_missing_model() void {
}
    // rust: let library = library();
        // Front, back, and the 8 unit edges around the L of 3 opaque pixels.
    // rust: let stick = bake_item_model(&library, &Sprites, "item/stick").unwrap();
    // rust: assert_eq!(stick.quads.len(), 10);
        // An unknown sprite bakes as the missing sprite.
    // rust: let slab = bake_item_model(&library, &Sprites, "block/slab").unwrap();
    // rust: assert_eq!(slab.quads.len(), 2);
    // rust: assert_eq!(slab.particle.sprite, MISSING_SPRITE);
        // A cyclic chain, an error to `resolve`, bakes as the missing cube.
    // rust: let cyclic = bake_item_model(&library, &Sprites, "horizon:loop").unwrap();
    // rust: assert_eq!(cyclic.quads.len(), 6);
    // rust: assert!(
    // rust: cyclic
    // rust: .quads
    // rust: .iter()
    // rust: .all(|q| q.material.sprite == MISSING_SPRITE)
    // rust: );
}
pub fn replaced_layer_bakes_with_its_own_sprite() void {
}
    // rust: let library = library();
    // rust: let child = BTreeMap::from([(
    // rust: "layer0".to_owned(),
    // rust: TextureSlot::Material(Material {
    // rust: sprite: "horizon_cit:item/cit".to_owned(),
    // rust: force_translucent: false,
    // rust: }),
    // rust: )]);
    // rust: let model = library.resolve_with_textures("item/stick", &child).unwrap();
    // rust: let baked = bake_resolved(&model, &Sprites).unwrap();
        // The CIT sprite's own mask, one opaque pixel: front, back and 4 edges.
    // rust: assert_eq!(baked.quads.len(), 6);
    // rust: assert!(
    // rust: baked
    // rust: .quads
    // rust: .iter()
    // rust: .all(|q| q.material.sprite == "horizon_cit:item/cit")
    // rust: );
    // rust: assert_eq!(baked.particle.sprite, "horizon_cit:item/cit");
    // rust: assert_eq!(baked.transforms[5].as_ref().unwrap().scale, [2.0; 3]);
}
}
