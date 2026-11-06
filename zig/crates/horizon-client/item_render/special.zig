//! Transpiled from Horizon Rust crate
//! Module: horizon-client_special
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `SpecialModelRenderer`s: items drawn with entity models (chests, shulker
//! boxes, banners, heads, shields, tridents, decorated pots, conduits, bells,
//! books and copper golem statues). Each submits its model at the layer pose
//! as vanilla's `submit` does (no block-entity placement transform) and
//! reports `getExtents` over the same posed parts.
// use super::{Foil, ItemQuad, ItemRenderer, ItemSink, SpecialHost, argb};
// use crate::{block_entity_render::ModelPart, hud::Rect};
// use glam::{Mat4, Quat, Vec3};
// use horizon_assets::item_model::{SpecialKind, SpecialModel};
// use serde_json::Value;
// use std::{collections::HashMap, f32::consts::PI, path::Path};

/// Entity model layers the special renderers bake (`ModelLayers`).
    // rust: const LAYERS: [(&str, &str); 22] = [
    // rust: ("chest", "minecraft:chest#main"),
    // rust: ("double_chest_left", "minecraft:double_chest_left#main"),
    // rust: ("double_chest_right", "minecraft:double_chest_right#main"),
    // rust: ("shulker_box", "minecraft:shulker_box#main"),
    // rust: ("standing_banner", "minecraft:standing_banner#main"),
    // rust: ("standing_banner_flag", "minecraft:standing_banner#flag"),
    // rust: ("wall_banner", "minecraft:wall_banner#main"),
    // rust: ("wall_banner_flag", "minecraft:wall_banner#flag"),
    // rust: ("skeleton", "minecraft:skeleton_skull#main"),
    // rust: ("wither_skeleton", "minecraft:wither_skeleton_skull#main"),
    // rust: ("zombie", "minecraft:zombie_head#main"),
    // rust: ("creeper", "minecraft:creeper_head#main"),
    // rust: ("dragon", "minecraft:dragon_skull#main"),
    // rust: ("piglin", "minecraft:piglin_head#main"),
    // rust: ("player", "minecraft:player_head#main"),
    // rust: ("bell", "minecraft:bell#main"),
    // rust: ("book", "minecraft:book#main"),
    // rust: ("conduit_shell", "minecraft:conduit#shell"),
    // rust: ("decorated_pot_base", "minecraft:decorated_pot_base#main"),
    // rust: ("decorated_pot_sides", "minecraft:decorated_pot_sides#main"),
    // rust: ("shield", "minecraft:shield#main"),
    // rust: ("trident", "minecraft:trident#main"),
    // rust: ];
    // rust: const COPPER_GOLEM_LAYERS: [(&str, &str); 4] = [
    // rust: ("copper_golem", "minecraft:copper_golem#main"),
    // rust: (
    // rust: "copper_golem_running",
    // rust: "minecraft:copper_golem_running#main",
    // rust: ),
    // rust: (
    // rust: "copper_golem_sitting",
    // rust: "minecraft:copper_golem_sitting#main",
    // rust: ),
    // rust: ("copper_golem_star", "minecraft:copper_golem_star#main"),
    // rust: ];

    // rust: pub(super) fn load_parts(root: &Path) -> HashMap<String, ModelPart> {
    // rust: let Ok(all) = std::fs::read(root.join("entity-models.json"))
    // rust: .map_err(|_| ())
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).map_err(|_| ()))
    // rust: else {
    // rust: return HashMap::new();
}
    // rust: LAYERS
    // rust: .iter()
    // rust: .chain(COPPER_GOLEM_LAYERS.iter())
    // rust: .filter_map(|(key, layer)| {
    // rust: all.get(*layer)
    // rust: .map(|v| ((*key).to_owned(), ModelPart::parse(v)))
    // rust: })
    // rust: .collect()
}

/// Marks every quad passed on as drawn with a back-face-culling render type (`entitySolid`).
pub const CullBack = struct {};
    // rust: impl ItemSink for CullBack<'_> {
pub fn quad(self: *Self, quad: ItemQuad) void {
}
    // rust: self.0.quad(ItemQuad {
    // rust: cull_back: true,
    // rust: ..quad
    // rust: });
}
}

/// Marks every quad passed on as drawn with a render type that has an `OitPipelineSet`
/// (`RenderTypes.entityTranslucent`).
pub const OitEntity = struct {};
    // rust: impl ItemSink for OitEntity<'_> {
pub fn quad(self: *Self, quad: ItemQuad) void {
}
    // rust: self.0.quad(ItemQuad { oit: true, ..quad });
}
}

/// A pose override for a named part (`setupAnim`).
    // rust: type Adjust<'a> = &'a dyn Fn(&str, &mut [f32; 9]);
pub fn none(_: []const u8, _: *mut [f32; 9]) void {
}

/// `ModelPart.translateAndRotate`.
pub fn part_matrix(parent: Mat4, p: *[f32; 9]) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: parent
    // rust: * Mat4::from_translation(Vec3::new(p[0], p[1], p[2]) / 16.0)
    // rust: * Mat4::from_quat(Quat::from_euler(glam::EulerRot::ZYX, p[5], p[4], p[3]))
    // rust: * Mat4::from_scale(Vec3::new(p[6], p[7], p[8]))
}
/// `ModelPart.render` of `part` (named `name`) as item quads.
    // rust: fn draw(
    // rust: part: &ModelPart,
    // rust: name: &str,
    // rust: parent: Mat4,
    // rust: adjust: Adjust,
    // rust: sprite: Rect,
    // rust: color: u32,
    // rust: foil: Foil,
    // rust: sink: &mut dyn ItemSink,
    // rust: ) {
    // rust: let mut p = part.pose;
    // rust: adjust(name, &mut p);
    // rust: let m = part_matrix(parent, &p);
    // rust: for poly in &part.polygons {
    // rust: let pos = poly.map(|v| m.transform_point3(Vec3::new(v[0], v[1], v[2]) / 16.0));
    // rust: let normal = (pos[1] - pos[0]).cross(pos[2] - pos[0]).normalize_or_zero();
    // rust: let normal = if normal == Vec3::ZERO {
    // rust: (pos[2] - pos[1])
    // rust: .cross(pos[3] - pos[1])
    // rust: .normalize_or(Vec3::Y)
    // rust: } else {
    // rust: normal
}
        // A reflection reverses winding, not PoseStack normal directions.
    // rust: let normal = if m.determinant() < 0.0 {
    // rust: -normal
    // rust: } else {
    // rust: normal
}
    // rust: sink.quad(ItemQuad {
    // rust: pos,
    // rust: uv: poly.map(|v| {
    // rust: [
    // rust: sprite.u0 + (sprite.u1 - sprite.u0) * v[3],
    // rust: sprite.v0 + (sprite.v1 - sprite.v0) * v[4],
    // rust: ]
    // rust: }),
    // rust: foil_uv: poly.map(|v| [v[3], v[4]]),
    // rust: gui_glint_uv: None,
    // rust: normal,
    // rust: color,
    // rust: foil,
    // rust: light_emission: 0,
    // rust: cull_back: false,
    // rust: translucent: false,
    // rust: oit: false,
    // rust: });
}
    // rust: for (child_name, child) in &part.children {
    // rust: draw(child, child_name, m, adjust, sprite, color, foil, sink);
}
}
/// `ModelPart.getExtentsForGui` from an identity pose.
pub fn extents_of(part: *ModelPart, name: []const u8, parent: Mat4, adjust: Adjust, out: *mut std.ArrayList(Vec3)) void {
}
    // rust: if part.polygons.is_empty() && part.children.is_empty() {
    // rust: return;
}
    // rust: let mut p = part.pose;
    // rust: adjust(name, &mut p);
    // rust: let m = part_matrix(parent, &p);
    // rust: for poly in &part.polygons {
    // rust: for v in poly {
    // rust: let q = m.transform_point3(Vec3::new(v[0], v[1], v[2]) / 16.0);
    // rust: if !out.contains(&q) {
    // rust: out.push(q);
}
}
}
    // rust: for (child_name, child) in &part.children {
    // rust: extents_of(child, child_name, m, adjust, out);
}
}
    // rust: fn child<'a>(part: &'a ModelPart, name: &str) -> Option<&'a ModelPart> {
    // rust: part.child(name)
}

/// A texture identifier relative to `textures/` (`minecraft:entity/x` or a
/// full `minecraft:textures/entity/x.png`) as its atlas sprite name.
pub fn texture_sprite(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = id.strip_prefix("minecraft:").unwrap_or(id);
    // rust: let path = path.strip_prefix("textures/").unwrap_or(path);
    // rust: path.strip_suffix(".png").unwrap_or(path).to_owned()
}
pub fn mapped(directory: []const u8, id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: "entity/{directory}/{}",
    // rust: id.strip_prefix("minecraft:").unwrap_or(id)
    // rust: )
}
/// `DyeColor.getTextureDiffuseColor` as ARGB.
pub fn dye(name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0xFF00_0000 | crate::banner::dye_rgb(name)
}

/// The chest model of a chest type, with `ChestModel.setupAnim(openness)`.
pub fn chest_model(chest_type: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match chest_type {
    // rust: "left" => "double_chest_left",
    // rust: "right" => "double_chest_right",
    // rust: _ => "chest",
}
}
pub fn skull_layer(kind: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: "skeleton" => "skeleton",
    // rust: "wither_skeleton" => "wither_skeleton",
    // rust: "zombie" => "zombie",
    // rust: "creeper" => "creeper",
    // rust: "dragon" => "dragon",
    // rust: "piglin" => "piglin",
    // rust: _ => "player",
}
}
/// `SkullBlockRenderer.SKIN_BY_TYPE`.
pub fn skull_texture(kind: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: "skeleton" => "entity/skeleton/skeleton",
    // rust: "wither_skeleton" => "entity/skeleton/wither_skeleton",
    // rust: "zombie" => "entity/zombie/zombie",
    // rust: "creeper" => "entity/creeper/creeper",
    // rust: "dragon" => "entity/enderdragon/dragon",
    // rust: "piglin" => "entity/piglin/piglin",
    // rust: _ => "entity/player/wide/steve",
}
}
/// `SkullModelBase.setupAnim` for a head at `animation` (yRot = xRot = 0).
pub fn skull_pose(kind: []const u8, animation: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |name: &str, p: &mut [f32; 9]| match (kind, name) {
    // rust: (_, "head") => {
    // rust: p[3] = 0.0;
    // rust: p[4] = 0.0;
}
    // rust: ("dragon", "jaw") => p[3] = (((animation * PI * 0.2) as f64).sin() as f32 + 1.0) * 0.2,
    // rust: ("piglin", "left_ear") => {
    // rust: p[5] = -((((animation * PI * 0.2 * 1.2) as f64).cos() + 2.5) as f32) * 0.2;
}
    // rust: ("piglin", "right_ear") => {
    // rust: p[5] = ((((animation * PI * 0.2) as f64).cos() + 2.5) as f32) * 0.2;
}
    // rust: _ => {}
}
}
pub fn shulker_pose(progress: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |name: &str, p: &mut [f32; 9]| {
    // rust: if name == "lid" {
    // rust: p[0] = 0.0;
    // rust: p[1] = 24.0 - progress * 0.5 * 16.0;
    // rust: p[2] = 0.0;
    // rust: p[4] = 270.0 * progress * (PI / 180.0);
}
}
}
pub fn chest_pose(open: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |name: &str, p: &mut [f32; 9]| {
    // rust: if name == "lid" || name == "lock" {
    // rust: p[3] = -(open * (PI / 2.0));
}
}
}
/// `BannerFlagModel.setupAnim(0)`.
pub fn flag_pose(name: []const u8, p: *mut [f32; 9]) void {
}
    // rust: if name == "flag" {
    // rust: p[3] = (-0.0125 + 0.01 * (2.0 * PI * 0.0f32).cos()) * PI;
}
}
/// `BookModel.setupAnim`.
pub fn book_pose(openness: f32, flip1: f32, flip2: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |name: &str, p: &mut [f32; 9]| match name {
    // rust: "left_lid" => p[4] = PI + openness,
    // rust: "right_lid" => p[4] = -openness,
    // rust: "left_pages" => {
    // rust: p[4] = openness;
    // rust: p[0] = openness.sin();
}
    // rust: "right_pages" => {
    // rust: p[4] = -openness;
    // rust: p[0] = openness.sin();
}
    // rust: "flip_page1" => {
    // rust: p[4] = openness - openness * 2.0 * flip1;
    // rust: p[0] = openness.sin();
}
    // rust: "flip_page2" => {
    // rust: p[4] = openness - openness * 2.0 * flip2;
    // rust: p[0] = openness.sin();
}
    // rust: _ => {}
}
}
/// `CopperGolemStatueModel.setupAnim`.
pub fn statue_pose(name: []const u8, p: *mut [f32; 9]) void {
}
    // rust: if name == "root" {
    // rust: p[1] = 0.0;
    // rust: p[5] = PI;
}
}
pub fn statue_layer(pose: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match pose {
    // rust: "running" => "copper_golem_running",
    // rust: "sitting" => "copper_golem_sitting",
    // rust: "star" => "copper_golem_star",
    // rust: _ => "copper_golem",
}
}

/// `SpecialModelRenderer.getExtents`.
    // rust: pub(super) fn extents(renderer: &ItemRenderer, model: &SpecialModel) -> Vec<Vec3> {
    // rust: let mut out = Vec::new();
    // rust: let id = Mat4::IDENTITY;
    // rust: let mut add = |key: &str, adjust: Adjust| {
    // rust: if let Some(part) = renderer.part(key) {
    // rust: extents_of(part, "root", id, adjust, &mut out);
}
}
    // rust: match &model.kind {
    // rust: SpecialKind::Bell => add("bell", &none),
    // rust: SpecialKind::Banner { .. } => {
            // `BannerRenderer.getExtents`: the standing models only.
    // rust: add("standing_banner", &none);
    // rust: add("standing_banner_flag", &flag_pose);
}
    // rust: SpecialKind::Book {
    // rust: open_angle,
    // rust: page1,
    // rust: page2,
    // rust: } => add(
    // rust: "book",
    // rust: &book_pose(open_angle * (PI / 180.0), *page1, *page2),
    // rust: ),
    // rust: SpecialKind::Conduit => add("conduit_shell", &none),
    // rust: SpecialKind::Chest {
    // rust: openness,
    // rust: chest_type,
    // rust: ..
    // rust: } => add(chest_model(chest_type), &chest_pose(*openness)),
    // rust: SpecialKind::CopperGolemStatue { pose, .. } => add(statue_layer(pose), &statue_pose),
    // rust: SpecialKind::DecoratedPot => {
    // rust: if let Some(base) = renderer.part("decorated_pot_base") {
                // `neck`, `top` and `bottom` are posed from an identity stack.
    // rust: for name in ["neck", "top", "bottom"] {
    // rust: if let Some(part) = child(base, name) {
    // rust: extents_of(part, name, id, &none, &mut out);
}
}
}
}
    // rust: SpecialKind::EndCube { .. } => {}
    // rust: SpecialKind::Head {
    // rust: kind, animation, ..
    // rust: } => add(skull_layer(kind), &skull_pose(kind, *animation)),
    // rust: SpecialKind::PlayerHead => add("player", &none),
    // rust: SpecialKind::ShulkerBox { openness, .. } => add("shulker_box", &shulker_pose(*openness)),
    // rust: SpecialKind::Shield => add("shield", &none),
    // rust: SpecialKind::Trident => add("trident", &none),
}
    // rust: out
}

/// Banner pattern layers of a `minecraft:banner_patterns` value: the
/// pattern identifier (or inline asset) and the dye.
pub fn pattern_layers(v: *Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|layer| {
    // rust: let pattern = match &layer["pattern"] {
    // rust: Value::String(s) => s.clone(),
    // rust: Value::Object(o) => format!("#asset:{}", o.get("asset_id")?.as_str()?),
    // rust: _ => return None,
}
    // rust: let color = layer["color"].as_str()?.to_owned();
    // rust: Some((pattern, color))
    // rust: })
    // rust: .collect()
}
pub fn pattern_texture(host: *dyn SpecialHost, banner: bool, pattern: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(asset) = pattern.strip_prefix("#asset:") {
    // rust: let path = asset.strip_prefix("minecraft:").unwrap_or(asset);
    // rust: return Some(format!(
    // rust: "entity/{}/{path}",
    // rust: if banner { "banner" } else { "shield" }
    // rust: ));
}
    // rust: if banner {
    // rust: host.banner_texture(pattern)
    // rust: } else {
    // rust: host.shield_texture(pattern)
}
}
/// `DecoratedPotPatterns.getPatternFromItem` for one side's sherd item.
pub fn pot_side(item: ?[]const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let item = item.map(|i| i.strip_prefix("minecraft:").unwrap_or(i));
    // rust: match item.and_then(|i| i.strip_suffix("_pottery_sherd")) {
    // rust: Some(name) => format!("entity/decorated_pot/{name}_pottery_pattern"),
    // rust: None => "entity/decorated_pot/decorated_pot_side".to_owned(),
}
}
/// `PotDecorations` as [back, left, right, front] item ids, from the list
/// codec or a keyed object.
pub fn pot_sides(v: *Value) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = |s: &Value| match s {
    // rust: Value::String(s) => Some(s.clone()),
    // rust: Value::Object(o) => o.get("id").and_then(Value::as_str).map(str::to_owned),
    // rust: _ => None,
}
    // rust: match v {
    // rust: Value::Array(a) => std::array::from_fn(|i| a.get(i).and_then(id)),
    // rust: Value::Object(o) => ["back", "left", "right", "front"].map(|k| o.get(k).and_then(id)),
    // rust: _ => Default::default(),
}
}

/// `GuiBannerResultRenderer.renderToTexture` under `pose`: the standing
/// banner flag (`BannerFlagModel.setupAnim(0)`) in the banner base texture,
/// then `BannerRenderer.submitPatterns` (the base colour and up to 16 layers
/// of `(texture, dye)`).
    // rust: pub(super) fn submit_banner_result(
    // rust: renderer: &ItemRenderer,
    // rust: pose: Mat4,
    // rust: base: &str,
    // rust: layers: &[(String, String)],
    // rust: sprites: &HashMap<String, Rect>,
    // rust: sink: &mut dyn ItemSink,
    // rust: ) {
    // rust: let Some(flag) = renderer.part("standing_banner_flag") else {
    // rust: return;
}
    // rust: let mut part = |texture: &str, color: u32| {
    // rust: if let Some(r) = sprites.get(texture).copied() {
    // rust: draw(flag, "root", pose, &flag_pose, r, color, Foil::None, sink);
}
}
    // rust: part("entity/banner/banner_base", argb(-1));
    // rust: part("entity/banner/base", dye(base));
    // rust: for (texture, color) in layers.iter().take(16) {
    // rust: part(texture, dye(color));
}
}

/// `GuiBookModelRenderer.renderToTexture`'s book under `pose`: `BookModel`
/// set up for `BookModel.State.forAnimation(0, page1, page2, open)`.
    // rust: pub(super) fn submit_book(
    // rust: renderer: &ItemRenderer,
    // rust: pose: Mat4,
    // rust: open: f32,
    // rust: page1: f32,
    // rust: page2: f32,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: sink: &mut dyn ItemSink,
    // rust: ) {
    // rust: let (Some(book), Some(r)) = (
    // rust: renderer.part("book"),
    // rust: sprites
    // rust: .get("entity/enchantment/enchanting_table_book")
    // rust: .copied(),
    // rust: ) else {
    // rust: return;
}
    // forAnimation at time 0: (sin(0) * 0.1 + 1.25) * open.
    // rust: let pose_for = book_pose(1.25 * open, page1, page2);
    // rust: draw(book, "root", pose, &pose_for, r, argb(-1), Foil::None, sink);
}

/// `SpecialModelRenderer.submit`.
    // rust: pub(super) fn submit(
    // rust: renderer: &ItemRenderer,
    // rust: model: &SpecialModel,
    // rust: argument: &Value,
    // rust: has_foil: bool,
    // rust: pose: Mat4,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: host: &dyn SpecialHost,
    // rust: sink: &mut dyn ItemSink,
    // rust: ) {
    // rust: let white = argb(-1);
    // rust: let mut part = |key: &str, adjust: Adjust, texture: &str, color: u32, foil: Foil| {
    // rust: if let (Some(p), Some(r)) = (renderer.part(key), sprites.get(texture).copied()) {
    // rust: draw(p, "root", pose, adjust, r, color, foil, sink);
}
}
    // rust: match &model.kind {
    // rust: SpecialKind::Bell => part("bell", &none, "entity/bell/bell_body", white, Foil::None),
    // rust: SpecialKind::Book {
    // rust: open_angle,
    // rust: page1,
    // rust: page2,
    // rust: } => part(
    // rust: "book",
    // rust: &book_pose(open_angle * (PI / 180.0), *page1, *page2),
    // rust: "entity/enchantment/enchanting_table_book",
    // rust: white,
    // rust: Foil::None,
    // rust: ),
    // rust: SpecialKind::Conduit => {
    // rust: part(
    // rust: "conduit_shell",
    // rust: &none,
    // rust: "entity/conduit/base",
    // rust: white,
    // rust: Foil::None,
    // rust: );
}
    // rust: SpecialKind::Chest {
    // rust: texture,
    // rust: openness,
    // rust: chest_type,
    // rust: } => part(
    // rust: chest_model(chest_type),
    // rust: &chest_pose(*openness),
    // rust: &mapped("chest", texture),
    // rust: white,
    // rust: Foil::None,
    // rust: ),
    // rust: SpecialKind::ShulkerBox { texture, openness } => part(
    // rust: "shulker_box",
    // rust: &shulker_pose(*openness),
    // rust: &mapped("shulker", texture),
    // rust: white,
    // rust: Foil::None,
    // rust: ),
    // rust: SpecialKind::CopperGolemStatue { texture, pose: p } => part(
    // rust: statue_layer(p),
    // rust: &statue_pose,
    // rust: &texture_sprite(texture),
    // rust: white,
    // rust: Foil::None,
    // rust: ),
    // rust: SpecialKind::Head {
    // rust: kind,
    // rust: texture,
    // rust: animation,
    // rust: } => {
    // rust: let skin = texture
    // rust: .as_deref()
    // rust: .map(|t| format!("entity/{}", t.strip_prefix("minecraft:").unwrap_or(t)))
    // rust: .unwrap_or_else(|| skull_texture(kind).to_owned());
    // rust: part(
    // rust: skull_layer(kind),
    // rust: &skull_pose(kind, *animation),
    // rust: &skin,
    // rust: white,
    // rust: Foil::None,
    // rust: );
}
    // rust: SpecialKind::PlayerHead => {
    // rust: let skin = (!argument.is_null())
    // rust: .then(|| host.player_skin(argument))
    // rust: .flatten()
    // rust: .unwrap_or_else(|| "entity/player/slim/steve".to_owned());
            // `PlayerHeadSpecialRenderer`: the skin's `entityTranslucent` render type.
    // rust: if let (Some(p), Some(r)) = (renderer.part("player"), sprites.get(&skin).copied()) {
    // rust: draw(
    // rust: p,
    // rust: "root",
    // rust: pose,
    // rust: &none,
    // rust: r,
    // rust: white,
    // rust: Foil::None,
    // rust: &mut OitEntity(sink),
    // rust: );
}
}
    // rust: SpecialKind::Trident => {
    // rust: let foil = if has_foil { Foil::Standard } else { Foil::None };
    // rust: part("trident", &none, "entity/trident/trident", white, foil);
}
    // rust: SpecialKind::Banner { color, wall } => {
    // rust: let (main, flag) = if *wall {
    // rust: ("wall_banner", "wall_banner_flag")
    // rust: } else {
    // rust: ("standing_banner", "standing_banner_flag")
}
    // rust: part(main, &none, "entity/banner/banner_base", white, Foil::None);
    // rust: part(
    // rust: flag,
    // rust: &flag_pose,
    // rust: "entity/banner/banner_base",
    // rust: white,
    // rust: Foil::None,
    // rust: );
            // `submitPatterns`: the base layer in the banner's colour, then up to 16 layers.
    // rust: part(
    // rust: flag,
    // rust: &flag_pose,
    // rust: "entity/banner/base",
    // rust: dye(color),
    // rust: Foil::None,
    // rust: );
    // rust: for (pattern, color) in pattern_layers(argument).into_iter().take(16) {
    // rust: if let Some(t) = pattern_texture(host, true, &pattern) {
    // rust: part(flag, &flag_pose, &t, dye(&color), Foil::None);
}
}
}
    // rust: SpecialKind::Shield => {
    // rust: let patterns = pattern_layers(&argument["minecraft:banner_patterns"]);
    // rust: let base_color = argument["minecraft:base_color"].as_str();
    // rust: let has_patterns = !patterns.is_empty() || base_color.is_some();
    // rust: let base = if has_patterns {
    // rust: "entity/shield/shield_base"
    // rust: } else {
    // rust: "entity/shield/shield_base_nopattern"
}
            // Without patterns: `entitySolidGlint`. With them, vanilla draws
            // `patternedShieldGlint` last, the glint alone over the finished
            // plate. A foil quad here is its texture with the glint over it
            // (the GUI adds the glint masked by the layer's alpha, the world
            // shader composites it), so every layer carries the foil: each
            // pixel ends with the glint once, over the layers below it.
            // Redrawing the base with the foil would cover the patterns.
    // rust: let foil = if has_foil { Foil::Standard } else { Foil::None };
    // rust: part("shield", &none, base, white, foil);
    // rust: if has_patterns {
    // rust: part(
    // rust: "shield",
    // rust: &none,
    // rust: "entity/shield/base",
    // rust: dye(base_color.unwrap_or("white")),
    // rust: foil,
    // rust: );
    // rust: for (pattern, color) in patterns.into_iter().take(16) {
    // rust: if let Some(t) = pattern_texture(host, false, &pattern) {
    // rust: part("shield", &none, &t, dye(&color), foil);
}
}
}
}
    // rust: SpecialKind::DecoratedPot => {
    // rust: let sides = pot_sides(argument);
            // `DecoratedPotRenderer` draws every part with `entitySolid`.
    // rust: let sink = &mut CullBack(sink);
    // rust: if let Some(base) = renderer.part("decorated_pot_base")
    // rust: && let Some(r) = sprites
    // rust: .get("entity/decorated_pot/decorated_pot_base")
    // rust: .copied()
    // rust: {
    // rust: for name in ["neck", "top", "bottom"] {
    // rust: if let Some(p) = child(base, name) {
    // rust: draw(p, name, pose, &none, r, white, Foil::None, sink);
}
}
}
    // rust: if let Some(side_parts) = renderer.part("decorated_pot_sides") {
    // rust: for (i, name) in ["back", "left", "right", "front"].into_iter().enumerate() {
    // rust: let texture = pot_side(sides[i].as_deref());
    // rust: if let (Some(p), Some(r)) = (child(side_parts, name), sprites.get(&texture)) {
    // rust: draw(p, name, pose, &none, *r, white, Foil::None, sink);
}
}
}
}
        // `EndCubeSpecialRenderer` draws the end portal/gateway effect; no
        // bundled item uses it.
    // rust: SpecialKind::EndCube { .. } => {}
}
}

    // rust: mod tests {
//     use super::*;

pub fn pot_sides_read_both_shapes() void {
}
    // rust: let list = serde_json::json!(["minecraft:brick", "minecraft:angler_pottery_sherd"]);
    // rust: let sides = pot_sides(&list);
    // rust: assert_eq!(
    // rust: pot_side(sides[0].as_deref()),
    // rust: "entity/decorated_pot/decorated_pot_side"
    // rust: );
    // rust: assert_eq!(
    // rust: pot_side(sides[1].as_deref()),
    // rust: "entity/decorated_pot/angler_pottery_pattern"
    // rust: );
    // rust: assert_eq!(
    // rust: pot_side(sides[3].as_deref()),
    // rust: "entity/decorated_pot/decorated_pot_side"
    // rust: );
}
pub fn texture_ids_map_to_sprites() void {
}
    // rust: assert_eq!(
    // rust: texture_sprite("minecraft:textures/entity/copper_golem/copper_golem.png"),
    // rust: "entity/copper_golem/copper_golem"
    // rust: );
    // rust: assert_eq!(
    // rust: mapped("chest", "minecraft:christmas"),
    // rust: "entity/chest/christmas"
    // rust: );
}

pub fn model_normals_follow_the_pose_not_the_mirrored_winding() void {
}
    // rust: let part = ModelPart::parse(&serde_json::json!({
    // rust: "pose": [0, 0, 0, 0, 0, 0, 1, 1, 1],
    // rust: "polygons": [[[0, 0, 0, 0, 0], [1, 0, -1, 1, 0],
    // rust: [0, 1, -1, 1, 1], [-1, 1, 0, 0, 1]]],
    // rust: "children": {}
    // rust: }));
    // rust: let sprite = Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
}
    // rust: let local = Vec3::ONE.normalize();
    // rust: for scale in [
    // rust: Vec3::ONE,
    // rust: Vec3::new(16.0, -16.0, 16.0),
    // rust: Vec3::new(2.0, 3.0, -4.0),
    // rust: Vec3::new(-2.0, -3.0, 4.0),
    // rust: ] {
    // rust: let pose = Mat4::from_rotation_y(0.7) * Mat4::from_scale(scale);
    // rust: let mut quads = Vec::new();
    // rust: draw(
    // rust: &part,
    // rust: "root",
    // rust: pose,
    // rust: &none,
    // rust: sprite,
    // rust: argb(-1),
    // rust: Foil::None,
    // rust: &mut quads,
    // rust: );
    // rust: assert_eq!(quads.len(), 1);
    // rust: let expected = super::super::transform_normal(pose, local);
    // rust: assert!(
    // rust: (quads[0].normal - expected).length() < 1e-6,
    // rust: "scale {scale:?}: {:?} != {expected:?}",
    // rust: quads[0].normal
    // rust: );
}
}
    /// `ShieldSpecialRenderer.submit` of an enchanted shield with a banner:
    /// the glint goes over the patterns, and nothing covers them after.
pub fn an_enchanted_banner_shield_keeps_its_patterns_under_the_glint() void {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-shield-glint-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: std::fs::write(root.join("items.json"), "{}").unwrap();
    // rust: std::fs::write(
    // rust: root.join("entity-models.json"),
    // rust: serde_json::json!({"minecraft:shield#main": {
    // rust: "pose": [0, 0, 0, 0, 0, 0, 1, 1, 1],
    // rust: "polygons": [[[0, 0, 0, 0, 0], [1, 0, 0, 1, 0],
    // rust: [1, 1, 0, 1, 1], [0, 1, 0, 0, 1]]],
    // rust: "children": {}
    // rust: }})
    // rust: .to_string(),
    // rust: )
    // rust: .unwrap();
    // rust: let library = crate::model_library::ParsedModels::default().into_item_library();
    // rust: let renderer = ItemRenderer::load_with_library(&root, library).unwrap();
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let textures = [
    // rust: "entity/shield/shield_base",
    // rust: "entity/shield/shield_base_nopattern",
    // rust: "entity/shield/base",
    // rust: "entity/shield/stripe_bottom",
    // rust: ];
        // A sprite per texture, told apart by its u0.
    // rust: let sprites: HashMap<String, Rect> = textures
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, t)| {
    // rust: let u0 = i as f32 / 8.0;
    // rust: let rect = Rect {
    // rust: u0,
    // rust: v0: 0.0,
    // rust: u1: u0 + 0.1,
    // rust: v1: 0.1,
    // rust: w: 16,
    // rust: h: 16,
}
    // rust: ((*t).to_owned(), rect)
    // rust: })
    // rust: .collect();
    // rust: let drawn = |argument: Value, has_foil: bool| {
    // rust: let mut quads: Vec<ItemQuad> = Vec::new();
    // rust: submit(
    // rust: &renderer,
    // rust: &SpecialModel {
    // rust: kind: SpecialKind::Shield,
    // rust: },
    // rust: &argument,
    // rust: has_foil,
    // rust: Mat4::IDENTITY,
    // rust: &sprites,
    // rust: &super::super::NoHost,
    // rust: &mut quads,
    // rust: );
    // rust: quads
    // rust: .iter()
    // rust: .map(|q| {
    // rust: let texture = textures
    // rust: .iter()
    // rust: .find(|t| sprites[**t].u0 == q.uv[0][0].min(q.uv[1][0]))
    // rust: .unwrap();
    // rust: (*texture, q.foil)
    // rust: })
    // rust: .collect::<Vec<_>>()
}
    // rust: let banner = serde_json::json!({
    // rust: "minecraft:base_color": "red",
    // rust: "minecraft:banner_patterns": [{
    // rust: "pattern": {"asset_id": "minecraft:stripe_bottom",
    // rust: "translation_key": "block.minecraft.banner.stripe_bottom"},
    // rust: "color": "blue"
    // rust: }]
    // rust: });
    // rust: assert_eq!(
    // rust: drawn(banner.clone(), true),
    // rust: [
    // rust: ("entity/shield/shield_base", Foil::Standard),
    // rust: ("entity/shield/base", Foil::Standard),
    // rust: ("entity/shield/stripe_bottom", Foil::Standard),
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: drawn(banner, false),
    // rust: [
    // rust: ("entity/shield/shield_base", Foil::None),
    // rust: ("entity/shield/base", Foil::None),
    // rust: ("entity/shield/stripe_bottom", Foil::None),
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: drawn(Value::Null, true),
    // rust: [("entity/shield/shield_base_nopattern", Foil::Standard)]
    // rust: );
}
    /// `DecoratedPotRenderer` draws every part with `RenderTypes.entitySolid`,
    /// whose pipeline culls back faces: the pot's flat `top` and `bottom`
    /// planes would otherwise show both sides and z-fight in the hand too.
pub fn the_decorated_pot_item_culls_its_back_faces() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let renderer = ItemRenderer::load(&root).unwrap();
    // rust: let sprite = Rect {
    // rust: u0: 0.25,
    // rust: v0: 0.125,
    // rust: u1: 0.375,
    // rust: v1: 0.25,
    // rust: w: 16,
    // rust: h: 16,
}
    // rust: let sprites: HashMap<String, Rect> = [
    // rust: "entity/decorated_pot/decorated_pot_base",
    // rust: "entity/decorated_pot/decorated_pot_side",
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|name| (name.to_owned(), sprite))
    // rust: .collect();
    // rust: let model = SpecialModel {
    // rust: kind: SpecialKind::DecoratedPot,
}
    // rust: let mut quads: Vec<ItemQuad> = Vec::new();
    // rust: submit(
    // rust: &renderer,
    // rust: &model,
    // rust: &Value::Null,
    // rust: false,
    // rust: Mat4::IDENTITY,
    // rust: &sprites,
    // rust: &super::super::NoHost,
    // rust: &mut quads,
    // rust: );
    // rust: assert!(!quads.is_empty(), "the pot item draws its parts");
    // rust: assert!(
    // rust: quads.iter().all(|q| q.cull_back),
    // rust: "entitySolid culls the pot's back faces"
    // rust: );
}
}
