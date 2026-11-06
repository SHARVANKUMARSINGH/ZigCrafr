//! Transpiled from Horizon Rust crate
package horizon_client_item_render

import "core:fmt"
import "core:mem"
import "core:math"

// Item rendering through the resolved item model pipeline: the
// `ItemModelResolver` of `horizon-assets` fills an [`ItemRenderState`]
// (`ItemStackRenderState`: layers of baked quads or special renderers, each
// with its display transform, local transform, tints and foil), and
// [`ItemRenderState::submit`] turns it into the quads `ItemFeatureRenderer`
// and the special model renderers submit, in pose space. A sink then draws
// them: [`gui`] into the HUD batch with the GUI item lighting, [`WorldSink`]
// into entity vertices with the level's lighting.
    // rust: pub mod cit;
    // rust: mod glint_atlas;
    // rust: mod glint_tests;
    // rust: pub mod gui;
    // rust: mod special;

// use crate::{
    // rust: block_entity_render::{ModelPart, diffuse},
    // rust: hud::Rect,
    // rust: mesher::{CULL_BACK, Vertex},
}
// use glam::{Mat3, Mat4, Vec3};
// use horizon_assets::{
    // rust: animation::AnimationMetadata,
    // rust: item_bake::{BakedItemModel, SpriteLookup, SpriteMask, bake_item_model},
    // rust: item_model::{
    // rust: ClientItem, Components, Context, DisplayContext, FoilType, ItemEnv, ItemModels,
    // rust: LayerContent, LevelState, OwnerState, SpecialModel, StackView,
    // rust: },
    // rust: model::Direction,
    // rust: palette::PalettedPermutations,
    // rust: resolve::{MISSING_MODEL, ModelLibrary},
}
// use horizon_world::nbt::Tag;
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, HashMap},
    // rust: fs,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex},
}

// One quad as submitted for drawing: pose-space corners, atlas UVs, the
// transformed unit normal, ARGB colour (tint, `-1` white) and its glint.
ItemQuad :: struct {
    pos: [Vec3,
    uv: [[f32,
    // The model UVs `GLINT_TEXTURING` scrolls for the glint (vanilla's UV0,
    // or UV3 for a special model).
    foil_uv: [[f32,
    // Standard GUI glint uses the vanilla items atlas; CIT keeps sprite-local UVs.
    gui_glint_uv: Option<[[f32,
    normal: Vec3,
    color: u32,
    foil: Foil,
    // `MaterialInfo.lightEmission` (block light floor).
    light_emission: u8,
    // The render type culls back faces (`entitySolid`): world drawing discards them.
    cull_back: bool,
    // The quad's sprite has translucent pixels (`MaterialInfo.itemRenderType`
    // is a translucent sheet): drawn with the translucent entities.
    translucent: bool,
    // The quad's render type has an `OitPipelineSet` (`entityTranslucent`: a
    // player head's skin): improved transparency draws it in its stages.
    oit: bool,
}
// `TextureTransform.setupGlintTexturing`'s inputs.
Glint :: struct {
    // `options.glintSpeed` (vanilla default 0.5).
    speed: f32,
    // `options.glintStrength` / shader `GlintAlpha` (vanilla default 0.75).
    alpha: f32,
    // `Util.getMillis()`.
    millis: f32,
    // The transform's scale: `GLINT_TEXTURING`'s 8.0 for GUI items,
    // `ENTITY_GLINT_TEXTURING`'s 0.5 for items in the world and
    // `ARMOR_ENTITY_GLINT_TEXTURING`'s 0.16 for armour (entity.wgsl).
    scale: f32,
}
    // rust: impl Glint {
    // `Util.getMillis() * glintSpeed * 8.0` as vanilla's long.
ticks :: proc(millis: f32, speed: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (f64::from(millis) * f64::from(speed) * 8.0) as i64
}
    // The scroll clock modulo the common period of both offsets (110000 and
    // 30000 divide 330000), for `globals.time.w`: the entity shader derives
    // `ARMOR_ENTITY_GLINT_TEXTURING` from it.
scroll_ticks :: proc(millis: f32, speed: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (Self::ticks(millis, speed) % 330_000) as f32
}
    // `TextureTransform.setupGlintTexturing(scale)` applied to the model UV:
    // translation(-o0, o1) * rotateZ(PI/18) * scale. The result repeats:
    // the shader samples the dedicated glint texture with vanilla's
    // repeating `GlintSampler`, so the UVs stay unwrapped.
uv :: proc(self: ^Self, model: [f32; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let ticks = Self::ticks(self.millis, self.speed);
    // rust: let offset0 = (ticks % 110_000) as f32 / 110_000.0;
    // rust: let offset1 = (ticks % 30_000) as f32 / 30_000.0;
    // rust: let angle = std::f32::consts::PI / 18.0;
    // rust: let (sin, cos) = angle.sin_cos();
    // rust: [
    // rust: model[0] * self.scale * cos - model[1] * self.scale * sin - offset0,
    // rust: model[0] * self.scale * sin + model[1] * self.scale * cos + offset1,
    // rust: ]
}
}
// The glint inputs of one frame, read once: `GameRenderer.extract` snapshots
// `glintSpeed` and `glintStrength` into `OptionsRenderState`
// (`extractOptions`), and `TextureTransform.setupGlintTexturing` reads
// `Util.getMillis()` once per glint render-type batch, not per item.
GlintFrame :: struct {
    // `Util.getMillis()` this frame.
    millis: f32,
    // `OptionsRenderState.glintSpeed`.
    speed: f32,
    // `OptionsRenderState.glintStrength`.
    alpha: f32,
    // The atlas has `misc/enchanted_glint_item`.
    sprite: bool,
}
    // rust: impl GlintFrame {
    // The glint at a texturing scale, if the atlas has its sprite.
glint :: proc(self: ^Self, scale: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.sprite.then_some(Glint {
    // rust: speed: self.speed,
    // rust: alpha: self.alpha,
    // rust: millis: self.millis,
    // rust: scale,
    // rust: })
}
    // [`Glint::scroll_ticks`] for this frame.
scroll_ticks :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: Glint::scroll_ticks(self.millis, self.speed)
}
}
// Which glint render type a quad uses.
Foil :: enum {
    None,
    // `GLINT_TEXTURING` over the sprite's UVs (`itemGlintRenderType`,
    // `entitySolidGlint`).
    Standard,
    // `itemGlintSpecialRenderType`: compasses and clocks, a sheeted decal.
    Special,
}
// Where submitted quads go.
    // rust: pub trait ItemSink {
quad :: proc(self: ^Self, quad: ItemQuad) {
}
}
    // rust: impl ItemSink for Vec<ItemQuad> {
quad :: proc(self: ^Self, quad: ItemQuad) {
}
    // rust: self.push(quad);
}
}

// Data special renderers read from the game (registries, skins).
    // rust: pub trait SpecialHost {
    // The banner atlas texture of a banner pattern (`entity/banner/<asset>`).
banner_texture :: proc(self: ^Self, pattern: string) -> O {
    // Ported from Horizon
    return {}
}
    // The shield atlas texture of a banner pattern (`entity/shield/<asset>`).
shield_texture :: proc(self: ^Self, pattern: string) -> O {
    // Ported from Horizon
    return {}
}
    // The skin texture of a `minecraft:profile` component, if loaded.
player_skin :: proc(self: ^Self, _profile: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
}
// A host with no registries: patterns and skins fall back to defaults.
NoHost :: struct {
    // rust: impl SpecialHost for NoHost {
banner_texture :: proc(self: ^Self, _: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
shield_texture :: proc(self: ^Self, _: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
}

// The geometry of one layer.
LayerGeometry :: enum {
    Quads(Arc<BakedItemModel>),
    Special {,
    model: SpecialModel,
    argument: Value,
    // rust: },
}
// `ItemStackRenderState.LayerRenderState`.
LayerRender :: struct {
    geometry: LayerGeometry,
    tints: [dynamic]i32,
    foil: FoilType,
    // `applyTransform`: the display transform, then the local transform.
    matrix: Mat4,
    // `particleMaterial` (atlas sprite name).
    particle: string,
    uses_block_light: bool,
    // Untransformed extents (quad corners or the special model's parts).
    extents: ^[dynamic]Vec3,
}
// `ItemStackRenderState`.
ItemRenderState :: struct {
    display: DisplayContext,
    layers: [dynamic]LayerRender,
    oversized_in_gui: bool,
    animated: bool,
    // The OptiFine CIT glint layers the stack draws in the GUI (`cit_glint`).
    cit_glint: Maybe(^crate::cit_glint::StackGlint),
    // HDR output's tier of an item that glows (`dynamic_light::Luminance::hdr_tier`).
    hdr_tier: u8,
    // In HDR output, the block light of an item that glows: its block's, as a placed one has
    // it, so a torch doesn't go dark in the shade while it shines. 0 for the rest.
    hdr_light: u8,
}
    // rust: impl ItemRenderState {
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.layers.is_empty()
}
    // `usesBlockLight` of the first layer (GUI lighting choice).
uses_block_light :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.layers.first().is_some_and(|l| l.uses_block_light)
}
    // `getModelBoundingBox`: the transformed extents of every layer, as
    // (min, max); a zero box at the origin when there are none.
bounding_box :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut lo = Vec3::splat(f32::INFINITY);
    // rust: let mut hi = Vec3::splat(f32::NEG_INFINITY);
    // rust: for layer in &self.layers {
    // rust: for p in layer.extents.iter() {
    // rust: let q = layer.matrix.transform_point3(*p);
    // rust: lo = lo.min(q);
    // rust: hi = hi.max(q);
}
}
    // rust: if lo.x > hi.x {
    // rust: (Vec3::ZERO, Vec3::ZERO)
    // rust: } else {
    // rust: (lo, hi)
}
}
    // Bounds of the actual submitted item geometry under each world pose.
    // Used for dropped-item occlusion because its collision box omits the
    // render bob, model size, and copies in a stacked item cluster.
posed_bounds :: proc(self: ^Self, poses: ^[Mat4]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut lo = Vec3::splat(f32::INFINITY);
    // rust: let mut hi = Vec3::splat(f32::NEG_INFINITY);
    // rust: for &pose in poses {
    // rust: for layer in &self.layers {
    // rust: let transform = pose * layer.matrix;
    // rust: for &point in layer.extents.iter() {
    // rust: let point = transform.transform_point3(point);
    // rust: if !point.is_finite() {
    // rust: return None;
}
    // rust: lo = lo.min(point);
    // rust: hi = hi.max(point);
}
}
}
    // rust: (lo.x <= hi.x && lo.y <= hi.y && lo.z <= hi.z).then_some((lo, hi))
}
    // `ItemStackRenderState.submit` under `pose`.
    // rust: pub fn submit(
    // rust: &self,
    // rust: renderer: &ItemRenderer,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: host: &dyn SpecialHost,
    // rust: pose: Mat4,
    // rust: sink: &mut dyn ItemSink,
    // rust: ) {
    // rust: for layer in &self.layers {
    // rust: let m = pose * layer.matrix;
    // rust: match &layer.geometry {
    // rust: LayerGeometry::Quads(baked) => {
    // rust: submit_quads(renderer, baked, layer, self.display, m, sprites, sink);
}
    // rust: LayerGeometry::Special { model, argument } => special::submit(
    // rust: renderer,
    // rust: model,
    // rust: argument,
    // rust: layer.foil != FoilType::None,
    // rust: m,
    // rust: sprites,
    // rust: host,
    // rust: sink,
    // rust: ),
}
}
}
    // [`Self::submit`] into a [`WorldSink`] of `light`, `lights` and `tier`,
    // posed on the GPU (`gfx::entity_skin`): the same vertices in the same
    // order. False, with nothing drawn, when a layer cannot take that path: a
    // special model, a glint, or a quad that glows or is translucent (another
    // material).
    // rust: pub fn submit_skinned(
    // rust: &self,
    // rust: renderer: &ItemRenderer,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: pose: Mat4,
    // rust: (light, lights, tier): (u32, Option<(Vec3, Vec3)>, u8),
    // rust: skin: &mut crate::mobs::skin::Skin,
    // rust: ) -> bool {
//         use crate::gfx::entity_skin::{SkinJob, SkinPart};
        // The axes' order in a stored vertex (`SkinVertex::axis`).
    // rust: const AXES: [Direction; 6] = [
    // rust: Direction::East,
    // rust: Direction::Up,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::Down,
    // rust: Direction::North,
    // rust: ];
    // rust: for layer in &self.layers {
    // rust: let LayerGeometry::Quads(baked) = &layer.geometry else {
    // rust: return false;
}
    // rust: if layer.foil != FoilType::None {
    // rust: return false;
}
    // rust: let Some(stored) = skin.models.item(baked, skin.frame) else {
    // rust: return false;
}
    // rust: let translucent = |run: &crate::mobs::skin::ItemRun| {
    // rust: let sprite = &baked.quads[run.quad].material.sprite;
    // rust: renderer.sprites.translucent(sprite_name(sprite))
}
    // rust: if stored.runs.iter().any(translucent) {
    // rust: return false;
}
}
    // rust: for layer in &self.layers {
    // rust: let LayerGeometry::Quads(baked) = &layer.geometry else {
    // rust: continue;
}
    // rust: let m = pose * layer.matrix;
    // rust: let mut normals = FaceNormals::new(m);
    // rust: let Some(stored) = skin.models.item(baked, skin.frame) else {
    // rust: continue;
}
    // rust: for run in &stored.runs {
                // `submit_quads`' sprite and tint, once for the run's quads.
    // rust: let q = &baked.quads[run.quad];
    // rust: let Some(r) = sprites
    // rust: .get(sprite_name(&q.material.sprite))
    // rust: .or_else(|| sprites.get("misc/missingno"))
    // rust: .or_else(|| sprites.get("horizon/missingno"))
    // rust: else {
    // rust: continue;
}
    // rust: let color = if run.tint_index >= 0 {
    // rust: layer
    // rust: .tints
    // rust: .get(run.tint_index as usize)
    // rust: .copied()
    // rust: .unwrap_or(-1)
    // rust: } else {
    // rust: -1
}
    // rust: let colors = AXES.map(|d| shaded(argb(color), normals.face(d), lights));
    // rust: let frame = &mut *skin.frame;
    // rust: frame.jobs.push(SkinJob {
    // rust: first: run.first,
    // rust: count: run.count,
    // rust: part: frame.parts.len() as u32,
    // rust: dst: frame.vertices,
    // rust: rect: [r.u0, r.v0, r.u1, r.v1],
    // rust: light,
    // rust: overlay: u32::from(tier) << 16,
    // rust: mode: SkinJob::ITEM,
    // rust: ..Default::default()
    // rust: });
    // rust: frame.parts.push(SkinPart::item(m, colors));
    // rust: frame.vertices += run.count;
}
    // rust: let bounds = stored.bounds;
    // rust: skin.grow_bounds(m, bounds);
}
    // rust: true
}
}

// The atlas name of a sprite identifier (`minecraft:item/apple` -> `item/apple`).
sprite_name :: proc(sprite: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: sprite.strip_prefix("minecraft:").unwrap_or(sprite)
}
// `Direction.getUnitVec3f`.
direction_vector :: proc(d: Direction) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match d {
    // rust: Direction::Down => Vec3::NEG_Y,
    // rust: Direction::Up => Vec3::Y,
    // rust: Direction::North => Vec3::NEG_Z,
    // rust: Direction::South => Vec3::Z,
    // rust: Direction::West => Vec3::NEG_X,
    // rust: Direction::East => Vec3::X,
}
}
// `PoseStack.Pose.transformNormal`: the normal matrix, renormalized.
transform_normal :: proc(m: Mat4, n: Vec3) -> V {
    // Ported from Horizon
    return {}
}
    // rust: FaceNormals::new(m).transform(n)
}
// [`transform_normal`] of one pose for many quads: its normal matrix inverted once, and
// the normal of each of the six facings worked out the first time a quad uses it.
FaceNormals :: struct {
    normal: Mat3,
    faces: [Maybe(Vec3),
}
    // rust: impl FaceNormals {
new :: proc(m: Mat4) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: normal: Mat3::from_mat4(m).inverse().transpose(),
    // rust: faces: [None; 6],
}
}
transform :: proc(self: ^Self, n: Vec3) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (self.normal * n).normalize_or_zero()
}
    // The pose's normal of a face pointing `d`.
face :: proc(self: ^Self, d: Direction) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let i = d as usize;
    // rust: if let Some(n) = self.faces[i] {
    // rust: return n;
}
    // rust: let n = self.transform(direction_vector(d));
    // rust: self.faces[i] = Some(n);
    // rust: n
}
}
// An `ARGB` int as the `u32` colour of an [`ItemQuad`].
argb :: proc(color: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: color as u32
}

// `ItemFeatureRenderer.prepareMainSubmit` for one cuboid layer.
    // rust: fn submit_quads(
    // rust: renderer: &ItemRenderer,
    // rust: baked: &BakedItemModel,
    // rust: layer: &LayerRender,
    // rust: display: DisplayContext,
    // rust: m: Mat4,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: sink: &mut dyn ItemSink,
    // rust: ) {
    // rust: let foil = match layer.foil {
    // rust: FoilType::None => Foil::None,
    // rust: FoilType::Standard => Foil::Standard,
    // rust: FoilType::Special => Foil::Special,
}
    // rust: let atlas = renderer
    // rust: .glint_atlas
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let mut normals = FaceNormals::new(m);
    // Quads of one layer mostly share a sprite: look its rect and its
    // translucency up once.
    // rust: let mut last: Option<(&str, bool)> = None;
    // rust: let mut last_rect: Option<(&str, Option<Rect>)> = None;
    // rust: for q in &baked.quads {
    // rust: let rect = match last_rect {
    // rust: Some((sprite, rect)) if sprite == q.material.sprite => rect,
    // rust: _ => {
    // rust: let rect = sprites
    // rust: .get(sprite_name(&q.material.sprite))
    // rust: .or_else(|| sprites.get("misc/missingno"))
    // rust: .or_else(|| sprites.get("horizon/missingno"))
    // rust: .copied();
    // rust: last_rect = Some((&q.material.sprite, rect));
    // rust: rect
}
}
    // rust: let Some(r) = rect else {
    // rust: continue;
}
        // `getLayerColorSafe`: an untinted quad, or a tint index past the
        // tints, draws white.
    // rust: let color = if q.tint_index >= 0 {
    // rust: layer
    // rust: .tints
    // rust: .get(q.tint_index as usize)
    // rust: .copied()
    // rust: .unwrap_or(-1)
    // rust: } else {
    // rust: -1
}
    // rust: let pos = q.positions.map(|p| m.transform_point3(Vec3::from(p)));
    // rust: let uv =
    // rust: q.uv.map(|[u, v]| [r.u0 + (r.u1 - r.u0) * u, r.v0 + (r.v1 - r.v0) * v]);
    // rust: let translucent = match last {
    // rust: Some((sprite, translucent)) if sprite == q.material.sprite => translucent,
    // rust: _ => {
    // rust: let translucent = renderer
    // rust: .sprites
    // rust: .translucent(sprite_name(&q.material.sprite));
    // rust: last = Some((&q.material.sprite, translucent));
    // rust: translucent
}
}
        // Every item render type culls back faces: `Sheets.solidBlockSheet`
        // (`entitySolid`), `cutoutBlockSheet` (`entityCutout`) and
        // `translucentItemSheet` (`entityTranslucentCull`). Drawing both sides
        // z-fights the coplanar pairs a two-sided model already carries (a
        // calibrated sculk sensor's tendrils and amethyst planes, #4856; big
        // dripleaf, #4855; the inside of a held hay block, #4801) and stacks a
        // jelly shell's partial alpha until it looks opaque (#4508).
    // rust: let translucent = translucent || q.material.force_translucent;
    // rust: sink.quad(ItemQuad {
    // rust: pos,
    // rust: uv,
    // rust: foil_uv: q.uv,
    // rust: gui_glint_uv: (display == DisplayContext::Gui && foil == Foil::Standard)
    // rust: .then(|| atlas.get(sprite_name(&q.material.sprite)))
    // rust: .flatten()
    // rust: .map(|r| {
    // rust: q.uv.map(|[u, v]| [r.u0 + (r.u1 - r.u0) * u, r.v0 + (r.v1 - r.v0) * v])
    // rust: }),
    // rust: normal: normals.face(q.facing),
    // rust: color: argb(color),
    // rust: foil,
    // rust: light_emission: q.light_emission,
    // rust: cull_back: true,
    // rust: translucent,
    // rust: oit: false,
    // rust: });
}
}

// ---------------------------------------------------------------------------
// Sprites for baking
// ---------------------------------------------------------------------------

// The alpha masks of item and block sprites, read from the texture files
// (every unique animation frame) and the items atlas's palette sprites.
FileSprites :: struct {
    root: PathBuf,
    permutations: [dynamic]PalettedPermutations,
    cache: Mutex<HashMap<string,
    // Sprites with a pixel that is neither fully transparent nor opaque
    // (`Transparency.hasTranslucent`), filled in as sprites load.
    translucent: Mutex<HashMap<string,
}
    // rust: impl SpriteLookup for FileSprites {
mask :: proc(self: ^Self, sprite: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Ok(cache) = self.cache.lock()
    // rust: && let Some(hit) = cache.get(sprite)
    // rust: {
    // rust: return hit.clone();
}
    // rust: let mask = self.load(sprite);
    // rust: if let Ok(mut cache) = self.cache.lock() {
    // rust: cache.insert(sprite.to_owned(), mask.clone());
}
    // rust: mask
}
}
argb_pixels :: proc(rgba: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: rgba.as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|p| u32::from_be_bytes([p[3], p[0], p[1], p[2]]))
    // rust: .collect()
}
    // rust: impl FileSprites {
translucent :: proc(self: ^Self, sprite: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let known = |this: &Self| this.translucent.lock().ok()?.get(sprite).copied();
    // rust: known(self).unwrap_or_else(|| {
    // rust: self.mask(sprite);
    // rust: known(self).unwrap_or(false)
    // rust: })
}
png :: proc(self: ^Self, sprite: string, directory: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: crate::atlas_sources::texture_path(&self.root, sprite, directory)
}
image :: proc(self: ^Self, sprite: string, directory: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (w, h, rgba) = crate::hud::decode(&self.png(sprite, directory)).ok()?;
    // rust: Some((w as usize, h as usize, argb_pixels(&rgba)))
}
load :: proc(self: ^Self, sprite: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let png = self.png(sprite, "textures");
    // rust: let (iw, ih, argb) = match self.image(sprite, "textures") {
    // rust: Some(image) => image,
    // rust: None => {
    // rust: let p = self.permutations.iter().find_map(|s| s.find(sprite))?;
    // rust: let (w, h, mut pixels) = self.image(p.base, "textures")?;
    // rust: let (_, _, key) = self.image(p.palette_key, "textures/palettes")?;
    // rust: let (_, _, target) = self.image(p.palette, "textures/palettes")?;
    // rust: horizon_assets::palette::apply_palette(&mut pixels, &key, &target)?;
    // rust: (w, h, pixels)
}
}
    // rust: let translucent = argb.iter().any(|p| matches!(p >> 24, 1..=254));
    // rust: if let Ok(mut cache) = self.translucent.lock() {
    // rust: cache.insert(sprite.to_owned(), translucent);
}
    // rust: let alpha: Vec<u8> = argb.iter().map(|p| (p >> 24) as u8).collect();
    // rust: let animation =
    // rust: horizon_core::prepared_files::read_to_string(&png.with_extension("png.mcmeta"))
    // rust: .ok()
    // rust: .and_then(|m| serde_json::from_str::<Value>(&m).ok())
    // rust: .and_then(|m| m.get("animation").map(Value::to_string))
    // rust: .and_then(|a| AnimationMetadata::from_json(&a).ok());
    // rust: let (w, h) = match &animation {
    // rust: Some(a) => {
    // rust: let [w, h] = a.frame_size(iw as i32, ih as i32);
    // rust: (w as usize, h as usize)
}
    // rust: None => (iw, ih),
}
    // rust: if w == 0 || h == 0 {
    // rust: return None;
}
    // rust: let columns = iw / w;
    // rust: let total = columns * (ih / h);
    // rust: let clip = animation.and_then(|a| a.clip(total as u32).ok().flatten());
    // rust: let frames: Vec<usize> = match clip {
    // rust: Some(clip) => {
    // rust: let mut unique = Vec::new();
    // rust: for (index, _) in clip.sequence() {
    // rust: if !unique.contains(&(*index as usize)) {
    // rust: unique.push(*index as usize);
}
}
    // rust: unique
}
    // rust: None => vec![0],
}
    // rust: let frames = frames
    // rust: .into_iter()
    // rust: .map(|f| {
    // rust: let (fx, fy) = (f % columns * w, f / columns * h);
    // rust: (0..h)
    // rust: .flat_map(|y| (0..w).map(move |x| (x, y)))
    // rust: .map(|(x, y)| alpha[(fy + y) * iw + fx + x] == 0)
    // rust: .collect()
    // rust: })
    // rust: .collect();
    // rust: Some(SpriteMask {
    // rust: width: w,
    // rust: height: h,
    // rust: frames,
    // rust: })
}
}

// ---------------------------------------------------------------------------
// The renderer
// ---------------------------------------------------------------------------

// The baked item models and everything resolution needs.
ItemRenderer :: struct {
    models: ItemModels,
    library: ^ModelLibrary,
    sprites: FileSprites,
    baked: Mutex<HashMap<string,
    extents: Mutex<HashMap<string,
    // GUI items already drawn: the HUD vertices of a static item at a GUI position
    // (`gui::draw`), which are the same every frame it stays there.
    // rust: pub(crate) gui_drawn: Mutex<HashMap<gui::DrawnKey, Arc<[crate::hud::HudVertex]>>>,
    // Entity model layers of the special renderers.
    parts: HashMap<string,
    // `colormap/grass.png` as ARGB.
    grass: [dynamic]i32,
    // `minecraft:item` registry ids (`Item.getId`).
    item_ids: HashMap<string,
    // The enabled packs' OptiFine CIT rules and their swapped bakes; `None`
    // without rules.
    cit: Maybe(cit::CitModels),
    glint_atlas: Mutex<HashMap<string,
}

// Every `items/**/*.json` client item definition, by identifier. Through
// `json_folder`: from the prepared data file when the root has one.
load_definitions :: proc(root: ^Path) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = BTreeMap::new();
    // rust: let Ok(namespaces) = fs::read_dir(root.join("assets")) else {
    // rust: return out;
}
    // rust: for ns in namespaces.flatten() {
    // rust: let Ok(folder) = horizon_world::json_folder::read(&ns.path().join("items")) else {
    // rust: continue;
}
    // rust: let namespace = ns.file_name().to_string_lossy().into_owned();
    // rust: for file in &folder.files {
    // rust: let Some(text) = file.bytes().ok().and_then(|b| std::str::from_utf8(b).ok()) else {
    // rust: continue;
}
    // rust: match ClientItem::from_json(text) {
    // rust: Ok(item) => {
    // rust: out.insert(format!("{namespace}:{}", file.name), item);
}
    // rust: Err(e) => log::warn!(
    // rust: "Horizon: item definition {namespace}:{} not loaded: {e}",
    // rust: file.name
    // rust: ),
}
}
}
    // rust: out
}

glint_padding :: proc(filtering: i32, bit: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if filtering == 2 {
    // rust: bit.wrapping_sub(1).clamp(0, 4) as usize
    // rust: } else {
    // rust: 0
}
}

    // rust: impl ItemRenderer {
    // Prepare GUI glint after the device exists; propagate packing failures to pack rollback.
prepare_glint_atlas :: proc(self: ^Self, maximum: u32, filtering: (i32) {
}
    // rust: let padding = glint_padding(filtering.0, filtering.1);
    // rust: let sprites = glint_atlas::load(&self.sprites.root, 1 << padding, maximum)?;
    // rust: *self
    // rust: .glint_atlas
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) = sprites;
    // rust: Ok(())
}

    // Load item definitions, item prototypes (`items.json`), every model,
    // the special renderers' entity models and the grass colormap.
load :: proc(root: ^Path) -> c {
    // Ported from Horizon
    return {}
}
    // rust: Self::load_with_library(
    // rust: root,
    // rust: crate::model_library::ParsedModels::load(root).into_item_library(),
    // rust: )
}
    // Reuse the immutable models prepared with the block resources at `root`.
    // Defer item-only validation failures until after item definitions are loaded.
    // rust: pub fn load_with_library(
    // rust: root: &Path,
    // rust: library: std::result::Result<Arc<ModelLibrary>, String>,
    // rust: ) -> crate::Result<Self> {
    // rust: Self::load_tables(root, library, true)
}
    // What a dedicated server reads: the item prototypes (the stacks'
    // default components) and ids, without the client item definitions,
    // the special renderers' entity models and the grass colormap, which
    // only drawing reads (1.4 MB and ~1,500 files).
    // rust: pub fn load_for_server(
    // rust: root: &Path,
    // rust: library: std::result::Result<Arc<ModelLibrary>, String>,
    // rust: ) -> crate::Result<Self> {
    // rust: Self::load_tables(root, library, false)
}
    // rust: fn load_tables(
    // rust: root: &Path,
    // rust: library: std::result::Result<Arc<ModelLibrary>, String>,
    // rust: drawn: bool,
    // rust: ) -> crate::Result<Self> {
    // rust: let prototypes: BTreeMap<String, Components> = horizon_world::item_defaults::shared(root)?
    // rust: .iter()
    // rust: .map(|(item, components)| {
    // rust: Ok((item.clone(), serde::Deserialize::deserialize(components)?))
    // rust: })
    // rust: .collect::<serde_json::Result<_>>()?;
    // rust: let models = ItemModels {
    // rust: definitions: if drawn {
    // rust: load_definitions(root)
    // rust: } else {
    // rust: BTreeMap::new()
    // rust: },
    // rust: prototypes,
}
        // CIT models and glint textures only affect drawing. A server still
        // needs item prototypes and ids, but never these resource-pack assets.
    // rust: let (library, cit) = if drawn {
    // rust: cit::load(root, library?)
    // rust: } else {
    // rust: (library?, None)
}
    // rust: let permutations = PalettedPermutations::from_atlas(
    // rust: &fs::read_to_string(root.join("assets/minecraft/atlases/items.json"))
    // rust: .unwrap_or_default(),
    // rust: );
    // rust: let parts = if drawn {
    // rust: special::load_parts(root)
    // rust: } else {
    // rust: HashMap::new()
}
    // rust: let grass = if drawn {
    // rust: crate::hud::decode(&root.join("assets/minecraft/textures/colormap/grass.png"))
    // rust: .map(|(_, _, rgba)| argb_pixels(&rgba).into_iter().map(|p| p as i32).collect())
    // rust: .unwrap_or_default()
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let item_ids = horizon_protocol::registry::Builtin::find(root)
    // rust: .and_then(|p| horizon_protocol::registry::Builtin::load(&p).ok())
    // rust: .and_then(|b| {
    // rust: let ids = b.get("minecraft:item")?;
    // rust: let mut out = HashMap::new();
    // rust: for i in 0.. {
    // rust: let Some(name) = ids.name(i) else { break };
    // rust: out.insert(name.to_owned(), i);
}
    // rust: Some(out)
    // rust: })
    // rust: .unwrap_or_default();
    // rust: Ok(Self {
    // rust: glint_atlas: Mutex::default(),
    // rust: item_ids,
    // rust: models,
    // rust: library,
    // rust: sprites: FileSprites {
    // rust: root: root.to_path_buf(),
    // rust: permutations,
    // rust: cache: Mutex::default(),
    // rust: translucent: Mutex::default(),
    // rust: },
    // rust: baked: Mutex::default(),
    // rust: extents: Mutex::default(),
    // rust: gui_drawn: Mutex::default(),
    // rust: parts,
    // rust: grass,
    // rust: cit,
    // rust: })
}
    // `ModelBakery` item baking, cached per model.
bake :: proc(self: ^Self, model: string) -> A {
    // Ported from Horizon
    return {}
}
    // rust: if let Ok(cache) = self.baked.lock()
    // rust: && let Some(hit) = cache.get(model)
    // rust: {
    // rust: return hit.clone();
}
    // rust: let baked = bake_item_model(&self.library, &self.sprites, model)
    // rust: .or_else(|_| bake_item_model(&self.library, &self.sprites, MISSING_MODEL))
    // rust: .map(Arc::new)
    // rust: .unwrap_or_else(|_| {
    // rust: Arc::new(BakedItemModel {
    // rust: quads: Vec::new(),
    // rust: uses_block_light: false,
    // rust: particle: horizon_assets::model::Material {
    // rust: sprite: horizon_assets::item_bake::MISSING_SPRITE.to_owned(),
    // rust: force_translucent: false,
    // rust: },
    // rust: transforms: Default::default(),
    // rust: })
    // rust: });
    // rust: if let Ok(mut cache) = self.baked.lock() {
    // rust: cache.insert(model.to_owned(), baked.clone());
}
    // rust: baked
}
    // `CuboidItemModelWrapper.computeExtents`: the distinct quad corners.
quad_extents :: proc(self: ^Self, model: string, baked: ^BakedItemModel) -> A {
    // Ported from Horizon
    return {}
}
    // rust: if let Ok(cache) = self.extents.lock()
    // rust: && let Some(hit) = cache.get(model)
    // rust: {
    // rust: return hit.clone();
}
    // rust: let out = Arc::new(corners(baked));
    // rust: if let Ok(mut cache) = self.extents.lock() {
    // rust: cache.insert(model.to_owned(), out.clone());
}
    // rust: out
}
special_extents :: proc(self: ^Self, model: ^SpecialModel) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let key = model.to_json().to_string();
    // rust: if let Ok(cache) = self.extents.lock()
    // rust: && let Some(hit) = cache.get(&key)
    // rust: {
    // rust: return hit.clone();
}
    // rust: let out = Arc::new(special::extents(self, model));
    // rust: if let Ok(mut cache) = self.extents.lock() {
    // rust: cache.insert(key, out.clone());
}
    // rust: out
}
    // `ItemModelResolver.updateForTopItem`.
    // rust: pub fn resolve(
    // rust: &self,
    // rust: stack: &StackView,
    // rust: display: DisplayContext,
    // rust: owner: Option<&OwnerState>,
    // rust: level: Option<&LevelState>,
    // rust: seed: i32,
    // rust: env: &dyn ItemEnv,
    // rust: ) -> ItemRenderState {
    // rust: self.resolve_with_rule(stack, display, owner, level, seed, env, None)
}
    // [`Self::resolve`] for a stack OptiFine CIT item rule `rule` (an index
    // into `cit.rules.rules`) matched: its model layers draw what the rule
    // swaps them for.
    // rust: pub fn resolve_with_rule(
    // rust: &self,
    // rust: stack: &StackView,
    // rust: display: DisplayContext,
    // rust: owner: Option<&OwnerState>,
    // rust: level: Option<&LevelState>,
    // rust: seed: i32,
    // rust: env: &dyn ItemEnv,
    // rust: rule: Option<usize>,
    // rust: ) -> ItemRenderState {
    // rust: let ctx = Context {
    // rust: display,
    // rust: owner,
    // rust: level,
    // rust: seed,
}
    // rust: let resolved = self.models.resolve(stack, &ctx, env);
    // rust: let mut animated = false;
    // rust: let layers = resolved
    // rust: .layers
    // rust: .into_iter()
    // rust: .map(|layer| {
    // rust: let (geometry, baked, extents) = match layer.content {
    // rust: LayerContent::Model { model } => {
    // rust: let (baked, extents) = rule
    // rust: .and_then(|rule| self.cit_layer(rule, &model))
    // rust: .unwrap_or_else(|| {
    // rust: let baked = self.bake(&model);
    // rust: let extents = self.quad_extents(&model, &baked);
    // rust: (baked, extents)
    // rust: });
    // rust: (LayerGeometry::Quads(baked.clone()), baked, extents)
}
    // rust: LayerContent::Missing => {
    // rust: let baked = self.bake(MISSING_MODEL);
    // rust: let extents = self.quad_extents(MISSING_MODEL, &baked);
    // rust: (LayerGeometry::Quads(baked.clone()), baked, extents)
}
    // rust: LayerContent::Special {
    // rust: base,
    // rust: model,
    // rust: argument,
    // rust: } => {
    // rust: let baked = self.bake(&base);
    // rust: let extents = self.special_extents(&model);
    // rust: (LayerGeometry::Special { model, argument }, baked, extents)
}
}
    // rust: if layer.foil != FoilType::None {
    // rust: animated = true;
}
    // rust: LayerRender {
    // rust: geometry,
    // rust: tints: layer.tints,
    // rust: foil: layer.foil,
    // rust: matrix: glam_matrix(&baked.layer_matrix(display, &layer.transform)),
    // rust: uses_block_light: baked.uses_block_light,
    // rust: particle: sprite_name(&baked.particle.sprite).to_owned(),
    // rust: extents,
}
    // rust: })
    // rust: .collect();
    // rust: ItemRenderState {
    // rust: display,
    // rust: layers,
    // rust: oversized_in_gui: resolved.oversized_in_gui,
    // rust: animated,
    // rust: cit_glint: None,
    // rust: hdr_tier: 0,
    // rust: hdr_light: 0,
}
}
    // `GrassColor.get` over the loaded colormap.
grass_color :: proc(self: ^Self, temperature: f64, downfall: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let rain = downfall * temperature;
    // rust: let x = ((1.0 - temperature) * 255.0) as i64;
    // rust: let y = ((1.0 - rain) * 255.0) as i64;
    // rust: let index = (y << 8 | x) as usize;
    // rust: self.grass.get(index).copied().unwrap_or(-65281)
}
    // Submit a special model renderer directly (worn skulls of
    // `CustomHeadLayer`, which draw the skull model, not the item).
    // rust: pub fn submit_special(
    // rust: &self,
    // rust: model: &SpecialModel,
    // rust: argument: &Value,
    // rust: has_foil: bool,
    // rust: pose: Mat4,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: host: &dyn SpecialHost,
    // rust: sink: &mut dyn ItemSink,
    // rust: ) {
    // rust: special::submit(self, model, argument, has_foil, pose, sprites, host, sink);
}
    // `Item.getId` (0 when the registry report is missing).
item_id :: proc(self: ^Self, item: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.item_ids.get(item).copied().unwrap_or(0)
}
    // rust: pub(crate) fn part(&self, key: &str) -> Option<&ModelPart> {
    // rust: self.parts.get(key)
}
}
// `CuboidItemModelWrapper.computeExtents`: the distinct quad corners.
corners :: proc(baked: ^BakedItemModel) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: Vec<Vec3> = Vec::new();
    // rust: for q in &baked.quads {
    // rust: for p in q.positions {
    // rust: let p = Vec3::from(p);
    // rust: if !out.contains(&p) {
    // rust: out.push(p);
}
}
}
    // rust: out
}
// A `horizon-assets` (row-major, JOML-exact) matrix as glam's.
glam_matrix :: proc(m: ^horizon_assets::math::Mat4) -> M {
    // Ported from Horizon
    return {}
}
    // rust: Mat4::from_cols_array_2d(&m.rows()).transpose()
}

// ---------------------------------------------------------------------------
// Stacks
// ---------------------------------------------------------------------------

// An NBT value as the JSON its component codec reads.
tag_json :: proc(tag: ^Tag) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::End => Value::Null,
    // rust: Tag::Byte(v) => Value::from(*v),
    // rust: Tag::Short(v) => Value::from(*v),
    // rust: Tag::Int(v) => Value::from(*v),
    // rust: Tag::Long(v) => Value::from(*v),
    // rust: Tag::Float(bits) => serde_json::Number::from_f64(f64::from(f32::from_bits(*bits)))
    // rust: .map_or(Value::Null, Value::Number),
    // rust: Tag::Double(bits) => {
    // rust: serde_json::Number::from_f64(f64::from_bits(*bits)).map_or(Value::Null, Value::Number)
}
    // rust: Tag::ByteArray(a) => Value::Array(a.iter().map(|b| Value::from(*b as i8)).collect()),
    // rust: Tag::String(s) => Value::String(s.to_string_lossy()),
    // rust: Tag::List(l) => Value::Array(l.iter().map(tag_json).collect()),
    // rust: Tag::Compound(c) => Value::Object(
    // rust: c.iter()
    // rust: .map(|(k, v)| (k.to_string_lossy(), tag_json(v)))
    // rust: .collect(),
    // rust: ),
    // rust: Tag::IntArray(a) => Value::Array(a.iter().map(|v| Value::from(*v)).collect()),
    // rust: Tag::LongArray(a) => Value::Array(a.iter().map(|v| Value::from(*v)).collect()),
}
}
// Custom model flags use Codec.BOOL even though NBT stores them as numbers.
// Keep the other custom-model fields, and generic NBT JSON, numeric.
custom_model_data_json :: proc(tag: ^Tag) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut value = tag_json(tag);
    // rust: let flags: Option<Vec<Value>> = match tag.get("flags") {
    // rust: Some(Tag::List(flags)) => flags
    // rust: .iter()
    // rust: .map(|flag| crate::item_data::component_bool(flag).map(Value::Bool))
    // rust: .collect(),
    // rust: Some(Tag::ByteArray(flags)) => flags
    // rust: .iter()
    // rust: .map(|flag| crate::item_data::component_bool(&Tag::Byte(*flag as i8)).map(Value::Bool))
    // rust: .collect(),
    // rust: Some(Tag::IntArray(flags)) => flags
    // rust: .iter()
    // rust: .map(|flag| crate::item_data::component_bool(&Tag::Int(*flag)).map(Value::Bool))
    // rust: .collect(),
    // rust: Some(Tag::LongArray(flags)) => flags
    // rust: .iter()
    // rust: .map(|flag| crate::item_data::component_bool(&Tag::Long(*flag)).map(Value::Bool))
    // rust: .collect(),
    // rust: _ => None,
}
    // rust: if let (Some(flags), Some(object)) = (flags, value.as_object_mut()) {
    // rust: object.insert("flags".into(), Value::Array(flags));
}
    // rust: value
}
// The resolver's view of a client stack: its item, count and component patch.
stack_view :: proc(stack: ^crate::items::ItemStack) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut view = StackView::new(&stack.item, stack.count as i32);
    // rust: view.bundle_selected = stack.data().map_or(-1, |d| d.bundle_selected.0);
    // rust: if let Some(Tag::Compound(c)) = crate::item_data::components_tag(stack.damage, stack.data()) {
    // rust: for (k, v) in &c {
    // rust: let key = k.to_string_lossy();
    // rust: match key.strip_prefix('!') {
    // rust: Some(removed) => view.patch.insert(removed.to_owned(), None),
    // rust: None => {
                    // The component codec turns NBT numeric booleans into JSON booleans.
                    // Generic NBT conversion must keep unrelated bytes numeric.
    // rust: let value = if key == "minecraft:enchantment_glint_override" {
    // rust: crate::item_data::component_bool(v)
    // rust: .map(Value::Bool)
    // rust: .unwrap_or_else(|| tag_json(v))
    // rust: } else if key == "minecraft:custom_model_data" {
    // rust: custom_model_data_json(v)
    // rust: } else {
    // rust: tag_json(v)
}
    // rust: view.patch.insert(key, Some(value))
}
}
}
}
    // rust: view
}

// ---------------------------------------------------------------------------
// World drawing
// ---------------------------------------------------------------------------

// Entity vertices for submitted quads: the `item`/`entity` shader's
// `minecraft_mix_light` with the level's diffuse lights on the vertex
// colour, the packed lightmap coordinates (raised by light emission) and
// overlay 7 for the glint.
WorldSink :: struct {
    out: ^'a mut [dynamic]Vertex,
    // Packed light (`block_entity_render::vertex_light`).
    light: u32,
    // The level's diffuse lights; `None` leaves the colour unshaded.
    lights: Option<(Vec3,
    // The `GLINT_TEXTURING` sample for foil quads (`None` leaves them unglinted).
    glint: Maybe(Glint),
    // HDR output's tier (`ItemRenderState::hdr_tier`): rides in the layer's high bits.
    tier: u8,
}
// The vertex colour [`WorldSink`] gives a quad of `color` (ARGB) facing `normal`:
// shaded by `lights` (`None`: unshaded), as ABGR bytes.
shaded :: proc(color: u32, normal: Vec3, lights: Option<(Vec3) {
}
    // rust: let brightness = lights.map_or(1.0, |l| diffuse(normal, l));
    // rust: let [a, r, g, b] = color.to_be_bytes();
    // rust: let c = |v: u8| (f32::from(v) * brightness) as u32;
    // rust: u32::from(a) << 24 | c(b) << 16 | c(g) << 8 | c(r)
}
    // rust: impl ItemSink for WorldSink<'_> {
quad :: proc(self: ^Self, q: ItemQuad) {
}
    // rust: let color = shaded(q.color, q.normal, self.lights);
        // `LightCoordsUtil.lightCoordsWithEmission`: block light at least the emission.
    // rust: let emission = u32::from(q.light_emission) * 16;
    // rust: let light = if (self.light >> 8 & 0xFF) < emission {
    // rust: (self.light & 0xFF) | emission << 8
    // rust: } else {
    // rust: self.light
}
    // rust: let glint = if q.foil == Foil::None {
    // rust: None
    // rust: } else {
    // rust: self.glint
}
    // rust: let overlay = match (glint.is_some(), q.translucent) {
    // rust: (false, true) => crate::gfx::TRANSLUCENT_ITEM_OVERLAY,
    // rust: (false, false) => 0,
    // rust: (true, true) => crate::gfx::TRANSLUCENT_GLINT_ITEM_OVERLAY,
    // rust: (true, false) => 7,
}
        // Only plain and foil quads: the translucent sheet's overlays are their own material.
    // rust: let oit = if q.oit && matches!(overlay, 0 | 7) {
    // rust: crate::gfx::OIT_ENTITY
    // rust: } else {
    // rust: 0
}
    // rust: for (i, (p, uv)) in q.pos.iter().zip(q.uv).enumerate() {
    // rust: let glint_uv = glint.map_or([0.0, 0.0], |glint| glint.uv(q.foil_uv[i]));
    // rust: self.out.push(Vertex {
    // rust: normal: if q.cull_back { CULL_BACK } else { [0; 4] },
    // rust: pos: p.to_array(),
    // rust: uv,
    // rust: layer: overlay | oit | u32::from(self.tier) << 16,
    // rust: color,
    // rust: light,
    // rust: glint_uv,
    // rust: });
}
}
}

// `ItemEntity.getSpin`.
item_spin :: proc(age_in_ticks: f32, bob_offset: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: age_in_ticks / 20.0 + bob_offset
}
// `ItemClusterRenderState.getRenderedAmount`.
rendered_amount :: proc(count: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match count {
    // rust: 0..=1 => 1,
    // rust: 2..=16 => 2,
    // rust: 17..=32 => 3,
    // rust: 33..=48 => 4,
    // rust: _ => 5,
}
}
// `ItemEntityRenderer.submitMultipleFromCount`: the poses of each copy of
// a stack (`seed` is `ItemClusterRenderState.getSeedForItemStack`).
cluster_poses :: proc(state: ^ItemRenderState, pose: Mat4, amount: u32, seed: i64) -> V {
    // Ported from Horizon
    return {}
}
//     use horizon_core::random::{LegacyRandom, RandomSource};
    // rust: let mut out = Vec::new();
    // rust: if amount == 0 {
    // rust: return out;
}
    // rust: let mut random = LegacyRandom::new(seed);
    // rust: let (lo, hi) = state.bounding_box();
    // rust: let depth = hi.z - lo.z;
    // rust: let mut next = || random.next_float() * 2.0 - 1.0;
    // rust: if depth > 0.0625 {
    // rust: out.push(pose);
    // rust: for _ in 1..amount {
    // rust: let (x, y, z) = (next() * 0.15, next() * 0.15, next() * 0.15);
    // rust: out.push(pose * Mat4::from_translation(Vec3::new(x, y, z)));
}
    // rust: } else {
    // rust: let offset = depth * 1.5;
    // rust: let mut p = pose
    // rust: * Mat4::from_translation(Vec3::new(0.0, 0.0, -(offset * (amount - 1) as f32 / 2.0)));
    // rust: out.push(p);
    // rust: p *= Mat4::from_translation(Vec3::new(0.0, 0.0, offset));
    // rust: for _ in 1..amount {
    // rust: let (x, y) = (next() * 0.15 * 0.5, next() * 0.15 * 0.5);
    // rust: out.push(p * Mat4::from_translation(Vec3::new(x, y, 0.0)));
    // rust: p *= Mat4::from_translation(Vec3::new(0.0, 0.0, offset));
}
}
    // rust: out
}

    // rust: mod tests {
//     use super::*;

custom_model_flags_select_their_model_after_stack_nbt_decoding :: proc() {
}
    // rust: let mut actual = Vec::new();
    // rust: for flags in [
    // rust: Tag::List(vec![Tag::Byte(1), Tag::Byte(0)]),
    // rust: Tag::ByteArray(vec![1, 0]),
    // rust: ] {
    // rust: let mut stack = crate::items::ItemStack::new("minecraft:diamond", 1);
    // rust: let component = Tag::compound([
    // rust: ("flags", flags),
    // rust: ("floats", Tag::List(vec![Tag::Float(1.25f32.to_bits())])),
    // rust: ("colors", Tag::List(vec![Tag::Int(0x12_34_56)])),
    // rust: ("strings", Tag::List(vec![Tag::String("keep".into())])),
    // rust: ]);
    // rust: (stack.damage, stack.extra) = crate::item_data::decode_components(Some(
    // rust: &Tag::compound([("minecraft:custom_model_data", component)]),
    // rust: ));
    // rust: let view = stack_view(&stack);
    // rust: for index in 0..3 {
    // rust: let mut models = ItemModels::default();
    // rust: models.prototypes.insert(
    // rust: "minecraft:diamond".into(),
    // rust: BTreeMap::from([(
    // rust: "minecraft:item_model".into(),
    // rust: serde_json::json!("minecraft:diamond"),
    // rust: )]),
    // rust: );
    // rust: models.definitions.insert("minecraft:diamond".into(), ClientItem::decode(&serde_json::json!({
    // rust: "model": {"type": "minecraft:condition", "property": "minecraft:custom_model_data", "index": index,
    // rust: "on_true": {"type": "minecraft:model", "model": "horizon:item/yes"},
    // rust: "on_false": {"type": "minecraft:model", "model": "horizon:item/no"}}
    // rust: })).unwrap());
    // rust: let resolved = models.resolve(
    // rust: &view,
    // rust: &Context {
    // rust: display: DisplayContext::Gui,
    // rust: owner: None,
    // rust: level: None,
    // rust: seed: 0,
    // rust: },
    // rust: &horizon_assets::item_model::NoEnv,
    // rust: );
    // rust: assert_eq!(resolved.layers.len(), 1);
    // rust: actual.push(
    // rust: resolved.layers[0].content
    // rust: == LayerContent::Model {
    // rust: model: "horizon:item/yes".into(),
    // rust: },
    // rust: );
}
            // Non-boolean fields must retain their codec's numeric/string values.
    // rust: let component = view.patch["minecraft:custom_model_data"].as_ref().unwrap();
    // rust: assert_eq!(component["floats"], serde_json::json!([1.25]));
    // rust: assert_eq!(component["colors"], serde_json::json!([0x12_34_56]));
    // rust: assert_eq!(component["strings"], serde_json::json!(["keep"]));
}
    // rust: assert_eq!(actual, [true, false, false, true, false, false]);
}

posed_item_bounds_include_each_cluster_transform :: proc() {
}
    // rust: let state = ItemRenderState {
    // rust: display: DisplayContext::Ground,
    // rust: layers: vec![LayerRender {
    // rust: geometry: LayerGeometry::Special {
    // rust: model: SpecialModel {
    // rust: kind: horizon_assets::item_model::SpecialKind::Trident,
    // rust: },
    // rust: argument: Value::Null,
    // rust: },
    // rust: tints: Vec::new(),
    // rust: foil: FoilType::None,
    // rust: matrix: Mat4::from_translation(Vec3::new(0.0, 2.0, 0.0)),
    // rust: particle: String::new(),
    // rust: uses_block_light: false,
    // rust: extents: Arc::new(vec![
    // rust: Vec3::new(-1.0, -0.5, -0.25),
    // rust: Vec3::new(0.5, 1.0, 0.25),
    // rust: ]),
    // rust: }],
    // rust: oversized_in_gui: false,
    // rust: animated: false,
    // rust: cit_glint: None,
    // rust: hdr_tier: 0,
    // rust: hdr_light: 0,
}
    // rust: let poses = [
    // rust: Mat4::from_translation(Vec3::new(2.0, 0.0, 0.0)),
    // rust: Mat4::from_translation(Vec3::new(-1.0, 0.0, 0.0)),
    // rust: ];
    // rust: let (lo, hi) = state.posed_bounds(&poses).expect("item model has vertices");
    // rust: assert_eq!(lo, Vec3::new(-2.0, 1.5, -0.25));
    // rust: assert_eq!(hi, Vec3::new(2.5, 3.0, 0.25));
}

    // One frame's glint is read once and shared: every item drawn from the
    // same `GlintFrame` scrolls by the same phase, and without the atlas
    // sprite no item gets a glint (`TextureTransform.setupGlintTexturing`
    // once per batch, `GameRenderer.extractOptions` once per frame).
a_frame_glint_is_shared_by_every_item :: proc() {
}
    // rust: let frame = GlintFrame {
    // rust: millis: 123_456.0,
    // rust: speed: 0.5,
    // rust: alpha: 0.75,
    // rust: sprite: true,
}
    // rust: let world = frame.glint(0.5).expect("the atlas has the glint sprite");
    // rust: assert_eq!(
    // rust: (world.speed, world.alpha, world.millis),
    // rust: (0.5, 0.75, 123_456.0)
    // rust: );
    // rust: assert_eq!(world.scale, 0.5);
    // rust: let uvs: Vec<_> = (0..1000)
    // rust: .map(|_| frame.glint(0.5).unwrap().uv([0.25, 0.75]))
    // rust: .collect();
    // rust: assert!(uvs.iter().all(|uv| *uv == uvs[0]));
    // rust: assert_eq!(frame.scroll_ticks(), Glint::scroll_ticks(123_456.0, 0.5));
        // 123456 ms * 0.5 * 8 = 493824 ticks, modulo 330000.
    // rust: assert_eq!(frame.scroll_ticks(), 163_824.0);
    // rust: let missing = GlintFrame {
    // rust: sprite: false,
    // rust: ..frame
}
    // rust: assert!(missing.glint(0.5).is_none());
    // rust: assert_eq!(missing.scroll_ticks(), frame.scroll_ticks());
}

    // A bad item model surfaces only once items.json has loaded, so a broken
    // items.json still reports itself first.
item_model_errors_wait_for_the_item_definitions :: proc() -> c {
    // Ported from Horizon
    return {}
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-item-model-errors-{}", std::process::id()));
    // rust: let model = root.join("assets/horizon/models/INVALID.json");
    // rust: fs::create_dir_all(model.parent().unwrap())?;
    // rust: fs::write(model, "{}")?;
    // rust: let library = crate::model_library::ParsedModels::load(&root).into_item_library();
    // rust: assert!(library.is_err());
    // rust: fs::write(root.join("items.json"), "{")?;
    // rust: let load = || {
    // rust: ItemRenderer::load_with_library(&root, library.clone())
    // rust: .err()
    // rust: .unwrap()
    // rust: .to_string()
}
    // rust: let broken_items = load();
    // rust: fs::write(root.join("items.json"), "{}")?;
    // rust: let bad_model = load();
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: assert!(!broken_items.starts_with("item models:"));
    // rust: assert!(bad_model.starts_with("item models:"));
    // rust: Ok(())
}

    // Definitions live at any depth (`items/<dir>/<name>.json`), as
    // ModelEngine's `modelengine:postman/head` does.
item_definitions_load_from_nested_folders :: proc() -> c {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-item-definitions-nested-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let definitions = root.join("assets/horizon/items");
    // rust: fs::create_dir_all(definitions.join("postman"))?;
    // rust: let empty = r#"{"model":{"type":"minecraft:empty"}}"#;
    // rust: fs::write(definitions.join("top.json"), empty)?;
    // rust: fs::write(definitions.join("postman/head.json"), empty)?;
    // rust: let loaded = load_definitions(&root);
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: assert!(loaded.contains_key("horizon:top"));
    // rust: assert!(loaded.contains_key("horizon:postman/head"));
    // rust: Ok(())
}

    // A dedicated server keeps the stacks' default components but reads
    // none of the client item definitions.
a_server_keeps_prototypes_without_definitions :: proc() -> c {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-item-server-{}", std::process::id()));
    // rust: let definitions = root.join("assets/horizon/items");
    // rust: fs::create_dir_all(&definitions)?;
    // rust: fs::write(
    // rust: definitions.join("top.json"),
    // rust: r#"{"model":{"type":"minecraft:empty"}}"#,
    // rust: )?;
    // rust: fs::write(
    // rust: root.join("items.json"),
    // rust: r#"{"horizon:top":{"minecraft:max_stack_size":16}}"#,
    // rust: )?;
    // rust: let cit = root.join("assets/minecraft/optifine");
    // rust: fs::create_dir_all(&cit)?;
    // rust: fs::write(cit.join("cit.properties"), "useGlint=false\n")?;
    // rust: let library = crate::model_library::ParsedModels::load(&root).into_item_library();
    // rust: let client = ItemRenderer::load_with_library(&root, library.clone())?;
    // rust: let server = ItemRenderer::load_for_server(&root, library)?;
    // rust: let _ = fs::remove_dir_all(&root);
    // rust: assert!(client.models.definitions.contains_key("horizon:top"));
    // rust: assert!(server.models.definitions.is_empty());
    // rust: assert!(client.cit.is_some());
    // rust: assert!(server.cit.is_none());
    // rust: assert_eq!(server.models.prototypes, client.models.prototypes);
    // rust: Ok(())
}

rendered_amounts_follow_the_count_bands :: proc() {
}
    // rust: let bands: Vec<u32> = [0, 1, 2, 16, 17, 32, 33, 48, 49, 64]
    // rust: .iter()
    // rust: .map(|c| rendered_amount(*c))
    // rust: .collect();
    // rust: assert_eq!(bands, [1, 1, 2, 2, 3, 3, 4, 4, 5, 5]);
}
nbt_components_read_as_json :: proc() {
}
    // rust: let tag = Tag::compound([
    // rust: ("a", Tag::Int(3)),
    // rust: ("b", Tag::List(vec![Tag::String("x".into())])),
    // rust: ("c", Tag::Float(1.5f32.to_bits())),
    // rust: ("d", Tag::Byte(1)),
    // rust: ]);
    // rust: assert_eq!(
    // rust: tag_json(&tag),
    // rust: serde_json::json!({"a": 3, "b": ["x"], "c": 1.5, "d": 1})
    // rust: );
}
stack_glint_override_reaches_the_resolved_item_layers :: proc() {
}
//         use horizon_assets::item_model::NoEnv;
    // rust: let mut models = ItemModels::default();
    // rust: models.definitions.insert(
    // rust: "horizon:fixture".into(),
    // rust: ClientItem::from_json(
    // rust: r#"{"model":{"type":"minecraft:model","model":"horizon:item/fixture"}}"#,
    // rust: )
    // rust: .unwrap(),
    // rust: );
    // rust: for default in [false, true] {
    // rust: models.prototypes.insert(
    // rust: "minecraft:diamond".into(),
    // rust: BTreeMap::from([
    // rust: (
    // rust: "minecraft:item_model".into(),
    // rust: serde_json::json!("horizon:fixture"),
    // rust: ),
    // rust: (
    // rust: "minecraft:enchantment_glint_override".into(),
    // rust: Value::Bool(default),
    // rust: ),
    // rust: ]),
    // rust: );
    // rust: for (tag, flag) in [
    // rust: (Tag::Byte(1), true),
    // rust: (Tag::Byte(0), false),
    // rust: (Tag::Byte(-1), true),
    // rust: (Tag::Short(256), true),
    // rust: (Tag::Int(1), true),
    // rust: (Tag::Long(1 << 40), true),
    // rust: (Tag::Float(0.5_f32.to_bits()), true),
    // rust: (Tag::Float((-0.0_f32).to_bits()), false),
    // rust: (Tag::Double(0.5_f64.to_bits()), true),
    // rust: (Tag::Double((-0.0_f64).to_bits()), false),
    // rust: (Tag::Float(f32::NAN.to_bits()), true),
    // rust: (Tag::Double(f64::INFINITY.to_bits()), true),
    // rust: ] {
    // rust: let mut stack = crate::items::ItemStack::new("minecraft:diamond", 1);
    // rust: (stack.damage, stack.extra) = crate::item_data::decode_components(Some(
    // rust: &Tag::compound([("minecraft:enchantment_glint_override", tag)]),
    // rust: ));
    // rust: assert_eq!(stack.has_foil(default), flag);
    // rust: let view = stack_view(&stack);
    // rust: assert_eq!(
    // rust: view.patch["minecraft:enchantment_glint_override"],
    // rust: Some(Value::Bool(flag))
    // rust: );
    // rust: let resolved = models.resolve(
    // rust: &view,
    // rust: &Context {
    // rust: display: DisplayContext::Gui,
    // rust: owner: None,
    // rust: level: None,
    // rust: seed: 0,
    // rust: },
    // rust: &NoEnv,
    // rust: );
    // rust: assert_eq!(resolved.layers.len(), 1);
    // rust: assert_eq!(
    // rust: resolved.layers[0].foil,
    // rust: if flag {
    // rust: FoilType::Standard
    // rust: } else {
    // rust: FoilType::None
}
    // rust: );
}
}
}

palette_trns_partial_alpha_counts_as_translucent :: proc() {
}
        // Slime/honey (and ice) are indexed PNGs with a tRNS chunk. Decode must
        // keep that fractional alpha so FileSprites marks them translucent (#4508).
    // rust: let png: &[u8] = &[
    // rust: 0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, 0x00, 0x00, 0x00, 0x0d, 0x49, 0x48,
    // rust: 0x44, 0x52, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x02, 0x08, 0x03, 0x00, 0x00,
    // rust: 0x00, 0x45, 0x68, 0xfd, 0x16, 0x00, 0x00, 0x00, 0x06, 0x50, 0x4c, 0x54, 0x45, 0x00,
    // rust: 0xff, 0x00, 0x00, 0x80, 0x00, 0x54, 0x80, 0xe6, 0x08, 0x00, 0x00, 0x00, 0x01, 0x74,
    // rust: 0x52, 0x4e, 0x53, 0xb4, 0x8c, 0xea, 0xaf, 0xf3, 0x00, 0x00, 0x00, 0x0e, 0x49, 0x44,
    // rust: 0x41, 0x54, 0x78, 0x9c, 0x63, 0x60, 0x60, 0x64, 0x60, 0x60, 0x04, 0x00, 0x00, 0x0b,
    // rust: 0x00, 0x03, 0x52, 0x29, 0x78, 0x8f, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4e, 0x44,
    // rust: 0xae, 0x42, 0x60, 0x82,
    // rust: ];
    // rust: let dir = std::env::temp_dir().join("horizon-trns-alpha");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let path = dir.join("indexed.png");
    // rust: std::fs::write(&path, png).unwrap();
    // rust: let (_w, _h, rgba) = crate::hud::decode(&path).unwrap();
    // rust: let partial = rgba.chunks(4).filter(|p| matches!(p[3], 1..=254)).count();
    // rust: assert!(partial > 0, "tRNS alpha was stripped: {rgba:?}");
}

normals_follow_the_inverse_transpose :: proc() {
}
    // rust: let m = Mat4::from_scale(Vec3::new(2.0, 1.0, 1.0));
    // rust: assert_eq!(transform_normal(m, Vec3::X), Vec3::X);
    // rust: let r = Mat4::from_rotation_y(std::f32::consts::FRAC_PI_2);
    // rust: assert!((transform_normal(r, Vec3::Z) - Vec3::X).length() < 1e-6);
}

    // Every vanilla item on the ground, held in either hand, framed and worn on the
    // head, turned, shaded and unshaded: the GPU path's vertices (its jobs expanded as
    // `entity_skin.wgsl` does) are the CPU path's, to the bit and in the same order, for
    // each state it takes. Needs the prepared resources.
items_posed_on_the_gpu_draw_what_the_cpu_draws :: proc() {
}
//         use crate::gfx::entity_skin::{SkinFrame, expand};
//         use crate::mobs::skin::{Skin, SkinModels};
//         use horizon_assets::item_model::{NoEnv, StackView};
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-models.json").exists() {
    // rust: eprintln!("no prepared resources: skipped");
    // rust: return;
}
    // rust: let r = ItemRenderer::load(&root).unwrap();
    // rust: let resolve = |id: &str| {
    // rust: let view = StackView::new(id, 1);
    // rust: r.resolve(&view, DisplayContext::Ground, None, None, 7, &NoEnv)
}
        // Each display context's transforms (`ItemTransform`s) pose the same quads.
    // rust: let contexts = [
    // rust: DisplayContext::Ground,
    // rust: DisplayContext::ThirdPersonRightHand,
    // rust: DisplayContext::ThirdPersonLeftHand,
    // rust: DisplayContext::Fixed,
    // rust: DisplayContext::Head,
    // rust: ];
    // rust: let states: Vec<_> = r
    // rust: .models
    // rust: .definitions
    // rust: .keys()
    // rust: .flat_map(|id| {
    // rust: contexts.map(|context| {
    // rust: let view = StackView::new(id, 1);
    // rust: (id, r.resolve(&view, context, None, None, 7, &NoEnv))
    // rust: })
    // rust: })
    // rust: .collect();
        // Each sprite its own rect, so a run drawn with another's shows.
    // rust: let mut sprites: HashMap<String, Rect> = HashMap::new();
    // rust: for (_, state) in &states {
    // rust: for layer in &state.layers {
    // rust: if let LayerGeometry::Quads(baked) = &layer.geometry {
    // rust: for q in &baked.quads {
    // rust: let n = sprites.len() as f32;
    // rust: sprites
    // rust: .entry(sprite_name(&q.material.sprite).to_owned())
    // rust: .or_insert(Rect {
    // rust: u0: n / 4096.0,
    // rust: v0: 0.5 - n / 8192.0,
    // rust: u1: n / 4096.0 + 0.003,
    // rust: v1: 0.5 - n / 8192.0 + 0.007,
    // rust: w: 16,
    // rust: h: 16,
    // rust: });
}
}
}
}
    // rust: let pose = Mat4::from_translation(Vec3::new(-2.3, 0.7, 5.1))
    // rust: * Mat4::from_rotation_y(2.1)
    // rust: * Mat4::from_scale(Vec3::splat(0.5));
    // rust: let mut models = SkinModels::default();
    // rust: let mut frame = SkinFrame::default();
    // rust: let (mut taken, mut left) = (0, 0);
    // rust: for lights in [
    // rust: Some(crate::block_entity_render::diffuse_lights(false)),
    // rust: None,
    // rust: ] {
    // rust: for (id, state) in &states {
    // rust: let mut cpu = Vec::new();
    // rust: let mut sink = WorldSink {
    // rust: out: &mut cpu,
    // rust: light: 0x50_a0,
    // rust: lights,
    // rust: glint: None,
    // rust: tier: 1,
}
    // rust: state.submit(&r, &sprites, &NoHost, pose, &mut sink);
    // rust: frame.clear_draws();
    // rust: let mut skin = Skin::new(&mut models, &mut frame);
    // rust: if !state.submit_skinned(&r, &sprites, pose, (0x50_a0, lights, 1), &mut skin) {
    // rust: assert!(frame.jobs.is_empty(), "{id}: left to the CPU after drawing");
    // rust: left += 1;
    // rust: continue;
}
    // rust: taken += 1;
    // rust: let bounds = skin.bounds;
    // rust: let gpu = expand(&frame.new_model, &frame);
    // rust: assert_eq!(gpu.len(), cpu.len(), "{id}");
    // rust: for (i, (g, c)) in gpu.iter().zip(&cpu).enumerate() {
    // rust: assert_eq!(
    // rust: bytemuck::bytes_of(g),
    // rust: bytemuck::bytes_of(c),
    // rust: "{id} vertex {i}: {g:?} != {c:?}"
    // rust: );
}
    // rust: if let (Some((lo, hi)), false) = (bounds, cpu.is_empty()) {
    // rust: for v in &cpu {
    // rust: let p = Vec3::from_array(v.pos);
    // rust: assert!(
    // rust: p.cmpge(lo - 1e-4).all() && p.cmple(hi + 1e-4).all(),
    // rust: "{id}: {p} outside"
    // rust: );
}
}
}
}
        // The 8 kinds of the `stress_items` scene all take it, and resolved again (as
        // every frame does) they draw the models already stored.
    // rust: let stored = frame.new_model.len();
    // rust: for id in [
    // rust: "stone",
    // rust: "oak_log",
    // rust: "diamond",
    // rust: "apple",
    // rust: "iron_sword",
    // rust: "bread",
    // rust: "redstone",
    // rust: "torch",
    // rust: ] {
    // rust: frame.clear_draws();
    // rust: let mut skin = Skin::new(&mut models, &mut frame);
    // rust: let state = resolve(&format!("minecraft:{id}"));
    // rust: assert!(
    // rust: state.submit_skinned(&r, &sprites, pose, (0, None, 0), &mut skin),
    // rust: "{id}"
    // rust: );
}
    // rust: assert_eq!(frame.new_model.len(), stored, "models stored again");
    // rust: eprintln!("{taken} item states on the GPU path, {left} on the CPU");
    // rust: assert!(taken > left, "{taken} taken, {left} left");
}

face_normals_of_a_pose_are_its_inverse_transpose :: proc() {
}
        // A dropped item's pose: spun, squashed and moved. Each face's normal is the
        // inverse transpose of the pose's 3x3 applied to the face's axis, renormalized,
        // here worked out in f64 from the cofactors.
    // rust: let m = Mat4::from_translation(Vec3::new(3.0, -1.0, 7.5))
    // rust: * Mat4::from_rotation_y(0.7)
    // rust: * Mat4::from_rotation_x(-0.3)
    // rust: * Mat4::from_scale(Vec3::new(0.5, 0.25, 2.0));
    // rust: let c = m.to_cols_array();
    // rust: let a = |row: usize, col: usize| f64::from(c[col * 4 + row]);
    // rust: let cofactor = |row: usize, col: usize| {
    // rust: let (r0, r1) = ((row + 1) % 3, (row + 2) % 3);
    // rust: let (c0, c1) = ((col + 1) % 3, (col + 2) % 3);
    // rust: a(r0, c0) * a(r1, c1) - a(r0, c1) * a(r1, c0)
}
    // rust: let mut normals = FaceNormals::new(m);
        // Twice each: a cached face gives what it gave the first time.
    // rust: for d in Direction::ALL.into_iter().chain(Direction::ALL) {
    // rust: let axis = direction_vector(d).to_array().map(f64::from);
            // inverse^T = cofactors / det: the det's sign is the only part that survives
            // renormalizing, and it is positive here.
    // rust: let n: Vec<f64> = (0..3)
    // rust: .map(|row| (0..3).map(|col| cofactor(row, col) * axis[col]).sum())
    // rust: .collect();
    // rust: let len = n.iter().map(|v| v * v).sum::<f64>().sqrt();
    // rust: let got = normals.face(d);
    // rust: for (g, e) in got.to_array().into_iter().zip(&n) {
    // rust: assert!(
    // rust: (f64::from(g) - e / len).abs() < 1e-6,
    // rust: "{d:?}: {got} vs {n:?}"
    // rust: );
}
    // rust: assert_eq!(got, transform_normal(m, direction_vector(d)), "{d:?}");
}
}
}
