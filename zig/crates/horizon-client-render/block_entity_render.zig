//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_block_entity_render
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Block-entity renderers (`BlockEntityRenderers`): chests (single, double,
//! trapped, ender, copper), shulker boxes, banners, skulls and heads, bells,
//! decorated pots, conduits, enchanting-table and lectern books and copper
//! golem statues, End portals and End gateways. Models are vanilla's baked `LayerDefinitions` layers
//! (`entity-models.json`); transforms, animation and textures follow each
//! vanilla renderer. Faces are lit like the `entity` shader: the lightmap at
//! the block plus `minecraft_mix_light` with the level's two diffuse lights.
// use crate::{
    // rust: Result,
    // rust: bidi::visual,
    // rust: block_entity_anim::{self, EnchantingBook},
    // rust: breaking::entity_geometry,
    // rust: fast_hash::FxHashMap,
    // rust: font::Glyph,
    // rust: gfx::mark_oit,
    // rust: hud::Rect,
    // rust: mesher::{CULL_BACK, Vertex},
    // rust: models::load_visibility,
    // rust: signs::{self, SignData, SignText},
    // rust: world::World,
}
// use glam::{DVec3, Mat4, Quat, Vec3};
// use horizon_core::geometry::{
    // rust: Direction,
    // rust: trig::{self, Mth},
}
// use horizon_world::{
    // rust: block_render::FaceVisibility,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use serde_json::Value;
// use std::{
    // rust: collections::{HashMap, HashSet},
    // rust: f32::consts::PI,
    // rust: path::Path,
    // rust: sync::{
    // rust: Arc, Mutex, PoisonError, RwLock,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: },
}

/// One baked `ModelPart`: initial pose, textured polygons (pixel units,
/// normalized UVs) and named children.
pub const ModelPart = struct {
    /// x, y, z, xRot, yRot, zRot, xScale, yScale, zScale.
    pose: [f32,
    polygons: Vec<[[f32,
    children: Vec<([]const u8,
};
    // rust: impl ModelPart {
pub fn parse(v: *Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut pose = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0];
    // rust: if let Some(a) = v["pose"].as_array() {
    // rust: for (p, x) in pose.iter_mut().zip(a) {
    // rust: *p = x.as_f64().unwrap_or(0.0) as f32;
}
}
    // rust: let polygons = v["polygons"]
    // rust: .as_array()
    // rust: .map(|polys| {
    // rust: polys
    // rust: .iter()
    // rust: .filter_map(|poly| {
    // rust: let verts = poly.as_array()?;
    // rust: if verts.len() != 4 {
    // rust: return None;
}
    // rust: let mut out = [[0f32; 5]; 4];
    // rust: for (o, vert) in out.iter_mut().zip(verts) {
    // rust: for (c, x) in o.iter_mut().zip(vert.as_array()?) {
    // rust: *c = x.as_f64().unwrap_or(0.0) as f32;
}
}
    // rust: Some(out)
    // rust: })
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let children = v["children"]
    // rust: .as_object()
    // rust: .map(|m| m.iter().map(|(k, c)| (k.clone(), Self::parse(c))).collect())
    // rust: .unwrap_or_default();
    // rust: Self {
    // rust: pose,
    // rust: polygons,
    // rust: children,
}
}
pub fn child(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.children
    // rust: .iter()
    // rust: .find(|(n, _)| n == name)
    // rust: .map(|(_, c)| c)
}
}

/// `Lighting` level light directions (overworld/end and nether).
pub fn diffuse_lights(nether: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let l0 = Vec3::new(0.2, 1.0, -0.7).normalize();
    // rust: let l1 = if nether {
    // rust: Vec3::new(-0.2, -1.0, 0.7)
    // rust: } else {
    // rust: Vec3::new(-0.2, 1.0, 0.7)
}
    // rust: .normalize();
    // rust: (l0, l1)
}
/// `minecraft_mix_light`: 0.6 power, 0.4 ambient.
pub fn diffuse(normal: Vec3, lights: (Vec3) void {
}
    // rust: ((lights.0.dot(normal).max(0.0) + lights.1.dot(normal).max(0.0)) * 0.6 + 0.4).min(1.0)
}
/// Packed vertex light from the level's packed `sky << 4 | block` byte.
pub fn vertex_light(packed: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (u32::from(packed >> 4) * 16) | ((u32::from(packed & 15) * 16) << 8)
}
/// `ChestRenderer.xmasTextures`: `SpecialDates.isExtendedChristmas` (24 to 26
/// December in the local time zone), read once when the renderer is created.
pub fn extended_christmas() b {
    // Implementation ported from Horizon
    return undefined;
}
//     use chrono::Datelike;
pub const XMAS: std::sync::OnceLock<bool> = std::sync::OnceLock::new();
    // rust: *XMAS.get_or_init(|| {
    // rust: let now = chrono::Local::now();
    // rust: now.month() == 12 && (24..=26).contains(&now.day())
    // rust: })
}
pub fn pack_color(rgb: u32, alpha: u32, brightness: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = |shift: u32| (((rgb >> shift) & 255) as f32 * brightness) as u32;
    // rust: alpha << 24 | c(0) << 16 | c(8) << 8 | c(16)
}

/// Everything a draw call needs besides the geometry.
pub const Paint = struct {
    sprite: Rect,
    /// 0xRRGGBB multiplied with the texture (`-1` = white in vanilla).
    tint: u32,
    light: u32,
    lights: (Vec3,
    /// The texture's OptiFine emissive overlay (`_e`): drawn again over it at full
    /// brightness, with the same shading.
    glow: ?Rect,
};
/// Full sky and block light, in [`vertex_light`]'s form.
pub const FULL_BRIGHT: u32 = 240 | (240 << 8);
/// `ModelPart.render`: translate by pose/16, rotate ZYX, scale; children inherit.
/// `adjust` may change a part's pose by name (`setupAnim`); `skip` hides parts.
    // rust: pub fn draw_part(
    // rust: part: &ModelPart,
    // rust: name: &str,
    // rust: parent: Mat4,
    // rust: adjust: &dyn Fn(&str, &mut [f32; 9]),
    // rust: paint: Paint,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let mut p = part.pose;
    // rust: adjust(name, &mut p);
    // rust: let m = parent
    // rust: * Mat4::from_translation(Vec3::new(p[0], p[1], p[2]) / 16.0)
    // rust: * Mat4::from_quat(Quat::from_euler(glam::EulerRot::ZYX, p[5], p[4], p[3]))
    // rust: * Mat4::from_scale(Vec3::new(p[6], p[7], p[8]));
    // rust: let Paint {
    // rust: sprite: r,
    // rust: tint,
    // rust: light,
    // rust: lights,
    // rust: glow,
    // rust: } = paint;
    // rust: for poly in &part.polygons {
    // rust: let pos = poly.map(|v| m.transform_point3(Vec3::new(v[0], v[1], v[2]) / 16.0));
    // rust: let normal = (pos[1] - pos[0]).cross(pos[2] - pos[0]).normalize_or_zero();
    // rust: let normal = if normal == Vec3::ZERO {
            // Degenerate polygon: use the other diagonal.
    // rust: (pos[2] - pos[1])
    // rust: .cross(pos[3] - pos[1])
    // rust: .normalize_or(Vec3::Y)
    // rust: } else {
    // rust: normal
}
    // rust: let color = pack_color(tint, 255, diffuse(normal, lights));
    // rust: for (r, light) in std::iter::once((r, light)).chain(glow.map(|g| (g, FULL_BRIGHT))) {
    // rust: for (v, position) in poly.iter().zip(pos) {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: position.to_array(),
    // rust: uv: [r.u0 + (r.u1 - r.u0) * v[3], r.v0 + (r.v1 - r.v0) * v[4]],
    // rust: layer: 0,
    // rust: color,
    // rust: light,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
    // rust: for (child_name, child) in &part.children {
    // rust: draw_part(child, child_name, m, adjust, paint, out);
}
}

/// `Direction.toYRot` for horizontal facings (south 0, west 90, north 180, east 270).
pub fn y_rot(facing: []const u8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match facing {
    // rust: "west" => 90.0,
    // rust: "north" => 180.0,
    // rust: "east" => 270.0,
    // rust: _ => 0.0,
}
}
pub fn opposite(facing: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match facing {
    // rust: "north" => "south",
    // rust: "south" => "north",
    // rust: "west" => "east",
    // rust: "east" => "west",
    // rust: "up" => "down",
    // rust: _ => "up",
}
}
pub fn clockwise(facing: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match facing {
    // rust: "north" => "east",
    // rust: "east" => "south",
    // rust: "south" => "west",
    // rust: _ => "north",
}
}
pub fn step(facing: []const u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match facing {
    // rust: "north" => [0, 0, -1],
    // rust: "south" => [0, 0, 1],
    // rust: "west" => [-1, 0, 0],
    // rust: "east" => [1, 0, 0],
    // rust: "up" => [0, 1, 0],
    // rust: _ => [0, -1, 0],
}
}
/// `Direction.getRotation`.
pub fn direction_rotation(facing: []const u8) Q {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let xyz = |x: f32, y: f32, z: f32| Quat::from_euler(glam::EulerRot::XYZ, x, y, z);
    // rust: match facing {
    // rust: "down" => Quat::from_rotation_x(PI),
    // rust: "north" => xyz(PI / 2.0, 0.0, PI),
    // rust: "south" => Quat::from_rotation_x(PI / 2.0),
    // rust: "west" => xyz(PI / 2.0, 0.0, PI / 2.0),
    // rust: "east" => xyz(PI / 2.0, 0.0, -PI / 2.0),
    // rust: _ => Quat::IDENTITY,
}
}
pub fn around(rotation: Mat4, pivot: Vec3) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Mat4::from_translation(pivot) * rotation * Mat4::from_translation(-pivot)
}

/// `DyeColor` names and texture diffuse colours, by id.
    // rust: pub const DYES: [(&str, u32); 16] = [
    // rust: ("white", 0xF9FFFE),
    // rust: ("orange", 0xF9801D),
    // rust: ("magenta", 0xC74EBD),
    // rust: ("light_blue", 0x3AB3DA),
    // rust: ("yellow", 0xFED83D),
    // rust: ("lime", 0x80C71F),
    // rust: ("pink", 0xF38BAA),
    // rust: ("gray", 0x474F52),
    // rust: ("light_gray", 0x9D9D97),
    // rust: ("cyan", 0x169C9C),
    // rust: ("purple", 0x8932B8),
    // rust: ("blue", 0x3C44AA),
    // rust: ("brown", 0x835432),
    // rust: ("green", 0x5E7C16),
    // rust: ("red", 0xB02E26),
    // rust: ("black", 0x1D1D21),
    // rust: ];
pub fn dye_prefix(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // Longest names first; this is the same stable order as sorting DYES by
    // descending prefix length, without a Vec allocation or comparison sort.
pub const ORDER: [usize; 16] = [3, 8, 2, 1, 4, 10, 0, 12, 13, 15, 5, 6, 7, 9, 11, 14];
    // rust: ORDER.into_iter().find_map(|i| {
    // rust: name.strip_prefix(DYES[i].0)
    // rust: .and_then(|rest| rest.strip_prefix('_'))
    // rust: .map(|rest| (i, rest))
    // rust: })
}

pub const ChestPart = enum {
    Single,
    Left,
    Right,
};
pub const SkullType = enum {
    Skeleton,
    WitherSkeleton,
    Zombie,
    Creeper,
    Dragon,
    Piglin,
    Player,
};
pub const Kind = enum {
    None,
    Chest {,
        /// The block (`neighbourState.is(state.getBlock())`).
    block: String,
    texture: &'static str,
    part: ChestPart,
    y_rot: f32,
    double_with: Option<[i32; 3]>,
    // rust: },
    Shulker {,
    texture: String,
    facing: &'static str,
    // rust: },
    Banner {,
    color: u32,
    wall: bool,
    angle: f32,
    // rust: },
    Skull {,
    kind: SkullType,
    wall: Option<&'static str>,
    segment: u8,
    // rust: },
    Bell,
    DecoratedPot {,
    y_rot: f32,
    // rust: },
    Conduit,
    EnchantingTable,
    Lectern {,
    y_rot: f32,
    // rust: },
    CopperGolem {,
    texture: &'static str,
    pose: &'static str,
    facing: &'static str,
    // rust: },
    /// `TheEndPortalRenderer`: the top and bottom faces of a 6/16-tall slab.
    EndPortal,
    /// `TheEndGatewayRenderer`: the visible faces of the cube and the beam.
    EndGateway {,
    state: u32,
    // rust: },
    /// Sign text (`StandingSignRenderer` / `HangingSignRenderer`); the boards are block models.
    Sign {,
    hanging: bool,
    wall: bool,
    angle: f32,
    // rust: },
};
pub fn intern(facing: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match facing {
    // rust: "north" => "north",
    // rust: "south" => "south",
    // rust: "west" => "west",
    // rust: "east" => "east",
    // rust: "up" => "up",
    // rust: _ => "down",
}
}
/// A sign's way of standing: a wall sign faces away from its wall, another
/// turns by its rotation segment.
pub fn sign(hanging: bool, wall: bool, prop: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let angle = if wall {
    // rust: y_rot(intern(&prop("facing").unwrap_or_default()))
    // rust: } else {
    // rust: prop("rotation")
    // rust: .and_then(|r| r.parse::<f32>().ok())
    // rust: .unwrap_or(0.0)
    // rust: * 22.5
}
    // rust: Kind::Sign {
    // rust: hanging,
    // rust: wall,
    // rust: angle,
}
}
pub fn classify(name: []const u8, prop: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: let facing = || intern(&prop("facing").unwrap_or_default());
    // rust: let chest = |texture: &'static str, left: &'static str, right: &'static str| {
    // rust: let facing = facing();
    // rust: let part = match prop("type").as_deref() {
    // rust: Some("left") => ChestPart::Left,
    // rust: Some("right") => ChestPart::Right,
    // rust: _ => ChestPart::Single,
}
        // ChestBlock.getConnectedDirection: left connects clockwise, right counter-clockwise.
    // rust: let other = match part {
    // rust: ChestPart::Single => None,
    // rust: ChestPart::Left => Some(step(clockwise(facing))),
    // rust: ChestPart::Right => Some(step(opposite(clockwise(facing)))),
}
    // rust: Kind::Chest {
    // rust: block: name.to_owned(),
    // rust: texture: match part {
    // rust: ChestPart::Single => texture,
    // rust: ChestPart::Left => left,
    // rust: ChestPart::Right => right,
    // rust: },
    // rust: part,
    // rust: y_rot: y_rot(facing),
    // rust: double_with: other,
}
}
    // rust: if let Some(hanging) = signs::sign_kind(name) {
    // rust: return sign(hanging, name.contains("_wall_"), prop);
}
    // rust: let unwaxed = name.strip_prefix("waxed_").unwrap_or(name);
    // rust: match unwaxed {
    // rust: "chest" => {
    // rust: return chest(
    // rust: "entity/chest/normal",
    // rust: "entity/chest/normal_left",
    // rust: "entity/chest/normal_right",
    // rust: );
}
    // rust: "trapped_chest" => {
    // rust: return chest(
    // rust: "entity/chest/trapped",
    // rust: "entity/chest/trapped_left",
    // rust: "entity/chest/trapped_right",
    // rust: );
}
    // rust: "ender_chest" => {
    // rust: return chest(
    // rust: "entity/chest/ender",
    // rust: "entity/chest/ender",
    // rust: "entity/chest/ender",
    // rust: );
}
    // rust: "copper_chest" => {
    // rust: return chest(
    // rust: "entity/chest/copper",
    // rust: "entity/chest/copper_left",
    // rust: "entity/chest/copper_right",
    // rust: );
}
    // rust: "exposed_copper_chest" => {
    // rust: return chest(
    // rust: "entity/chest/copper_exposed",
    // rust: "entity/chest/copper_exposed_left",
    // rust: "entity/chest/copper_exposed_right",
    // rust: );
}
    // rust: "weathered_copper_chest" => {
    // rust: return chest(
    // rust: "entity/chest/copper_weathered",
    // rust: "entity/chest/copper_weathered_left",
    // rust: "entity/chest/copper_weathered_right",
    // rust: );
}
    // rust: "oxidized_copper_chest" => {
    // rust: return chest(
    // rust: "entity/chest/copper_oxidized",
    // rust: "entity/chest/copper_oxidized_left",
    // rust: "entity/chest/copper_oxidized_right",
    // rust: );
}
    // rust: "shulker_box" => {
    // rust: return Kind::Shulker {
    // rust: texture: "entity/shulker/shulker".into(),
    // rust: facing: facing(),
}
}
    // rust: "bell" => return Kind::Bell,
    // rust: "decorated_pot" => {
    // rust: return Kind::DecoratedPot {
    // rust: y_rot: y_rot(facing()),
}
}
    // rust: "conduit" => return Kind::Conduit,
    // rust: "end_portal" => return Kind::EndPortal,
    // rust: "end_gateway" => return Kind::EndGateway { state: 0 },
    // rust: "enchanting_table" => return Kind::EnchantingTable,
    // rust: "lectern" => {
    // rust: return if prop("has_book").as_deref() == Some("true") {
    // rust: Kind::Lectern {
    // rust: y_rot: y_rot(clockwise(facing())),
}
    // rust: } else {
    // rust: Kind::None
}
}
    // rust: _ => {}
}
    // rust: for (prefix, texture) in [
    // rust: ("copper_golem_statue", "entity/copper_golem/copper_golem"),
    // rust: (
    // rust: "exposed_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem_exposed",
    // rust: ),
    // rust: (
    // rust: "weathered_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem_weathered",
    // rust: ),
    // rust: (
    // rust: "oxidized_copper_golem_statue",
    // rust: "entity/copper_golem/copper_golem_oxidized",
    // rust: ),
    // rust: ] {
    // rust: if unwaxed == prefix {
    // rust: let pose = match prop("copper_golem_pose").as_deref() {
    // rust: Some("running") => "running",
    // rust: Some("sitting") => "sitting",
    // rust: Some("star") => "star",
    // rust: _ => "standing",
}
    // rust: return Kind::CopperGolem {
    // rust: texture,
    // rust: pose,
    // rust: facing: facing(),
}
}
}
    // rust: let skull = |base: &str| -> Option<SkullType> {
    // rust: Some(match base {
    // rust: "skeleton_skull" => SkullType::Skeleton,
    // rust: "wither_skeleton_skull" => SkullType::WitherSkeleton,
    // rust: "zombie_head" => SkullType::Zombie,
    // rust: "creeper_head" => SkullType::Creeper,
    // rust: "dragon_head" => SkullType::Dragon,
    // rust: "piglin_head" => SkullType::Piglin,
    // rust: "player_head" => SkullType::Player,
    // rust: _ => return None,
    // rust: })
}
    // rust: if let Some(kind) = skull(name) {
    // rust: let segment = prop("rotation").and_then(|r| r.parse().ok()).unwrap_or(0);
    // rust: return Kind::Skull {
    // rust: kind,
    // rust: wall: None,
    // rust: segment,
}
}
    // rust: if name.contains("_wall_")
    // rust: && let Some(kind) = skull(&name.replace("_wall_", "_"))
    // rust: {
    // rust: return Kind::Skull {
    // rust: kind,
    // rust: wall: Some(facing()),
    // rust: segment: 0,
}
}
    // rust: if let Some((dye, rest)) = dye_prefix(name) {
    // rust: match rest {
    // rust: "shulker_box" => {
    // rust: return Kind::Shulker {
    // rust: texture: format!("entity/shulker/shulker_{}", DYES[dye].0),
    // rust: facing: facing(),
}
}
    // rust: "banner" => {
    // rust: let segment: f32 = prop("rotation").and_then(|r| r.parse().ok()).unwrap_or(0.0);
    // rust: return Kind::Banner {
    // rust: color: DYES[dye].1,
    // rust: wall: false,
    // rust: angle: segment * 22.5,
}
}
    // rust: "wall_banner" => {
    // rust: return Kind::Banner {
    // rust: color: DYES[dye].1,
    // rust: wall: true,
    // rust: angle: y_rot(facing()),
}
}
    // rust: _ => {}
}
}
    // rust: Kind::None
}

/// `BookModel.setupAnim` for `BookModel.State(openness, pageFlip1, pageFlip2)`.
pub fn book_pose(openness: f32, flip1: f32, flip2: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |name, p| match name {
    // rust: "left_lid" => p[4] = PI + openness,
    // rust: "right_lid" => p[4] = -openness,
    // rust: "left_pages" => {
    // rust: p[4] = openness;
    // rust: p[0] = openness.msin();
}
    // rust: "right_pages" => {
    // rust: p[4] = -openness;
    // rust: p[0] = openness.msin();
}
    // rust: "flip_page1" => {
    // rust: p[4] = openness - openness * 2.0 * flip1;
    // rust: p[0] = openness.msin();
}
    // rust: "flip_page2" => {
    // rust: p[4] = openness - openness * 2.0 * flip2;
    // rust: p[0] = openness.msin();
}
    // rust: _ => {}
}
}
pub fn frac(x: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: x - x.floor()
}

/// `StringSplitter.splitLines(...).get(0)` for plain text: the first line,
/// wrapped at the last space that fits or mid-word when none does.
pub fn first_line(line: []const u8, max_width: f32, advance: *dyn Fn(char) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut width = 0.0;
    // rust: let mut last_space = None;
    // rust: for (i, c) in line.char_indices() {
    // rust: if c == '\n' {
    // rust: return line[..i].to_owned();
}
    // rust: if c == ' ' {
    // rust: last_space = Some(i);
}
    // rust: width += advance(c);
    // rust: if width > max_width {
    // rust: let end = match last_space {
    // rust: Some(s) if s > 0 => s,
    // rust: _ if i > 0 => i,
                // The first char alone is too wide: take that one char.
    // rust: _ => c.len_utf8(),
}
    // rust: return line[..end].to_owned();
}
}
    // rust: line.to_owned()
}

/// `AbstractSignRenderer.isOutlineVisible`: the camera within 16 blocks of
/// the sign's centre.
pub fn sign_text_near(pos: [i32; 3], camera: DVec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: DVec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: )
    // rust: .distance_squared(camera)
    // rust: < 256.0
}

/// `AbstractSignRenderer.submitSignText`: four centred lines, glowing text
/// full-bright with an 8x outline in the dark colour. The font colours each
/// glyph by its style (`Font.StringRenderOutput`): a line's own colour wins,
/// else the sign's. A line is one call per run of one colour.
    // rust: fn sign_text_calls(
    // rust: scene: &Scene,
    // rust: data: &SignData,
    // rust: text: &SignText,
    // rust: m: Mat4,
    // rust: packed: u8,
    // rust: near: bool,
    // rust: ) -> Vec<TextCall> {
    // rust: let line_height = data.line_height();
    // rust: let midpoint = (4.0 * line_height / 2.0).floor();
    // rust: let dark = 0xFF00_0000 | text.dark_color();
    // rust: let (color, outline, light) = if text.glowing {
    // rust: let c = text.text_color();
    // rust: (
    // rust: 0xFF00_0000 | c,
    // rust: if c == 0 || near { dark } else { 0 },
    // rust: 240 | 240 << 8,
    // rust: )
    // rust: } else {
    // rust: (dark, 0, vertex_light(packed))
}
    // rust: let advance = |c: char| (scene.glyph)(c).advance;
    // rust: let mut calls: Vec<TextCall> = Vec::with_capacity(text.lines.len());
    // rust: for i in 0..text.lines.len() {
        // The line that fits, in the order it is drawn (getVisualOrder).
    // rust: let line = text.line_text(i);
    // rust: let line = line.resolved();
    // rust: let flat: String = line.chars().map(|(c, _)| c).collect();
    // rust: let fits = first_line(&flat, data.max_line_width(), &advance);
    // rust: let shown = line.slice(0, fits.chars().count());
    // rust: let shown = visual(&shown);
    // rust: let width = shown.chars().map(|(c, _)| advance(c)).sum::<f32>().ceil();
    // rust: let x = -((width as i32) / 2) as f32;
    // rust: let y = i as f32 * line_height - midpoint;
    // rust: let first = calls.len();
    // rust: let mut pen = 0.0;
    // rust: for span in shown.spans.iter().filter(|s| !s.text.is_empty()) {
    // rust: let run = span
    // rust: .style
    // rust: .color
    // rust: .map_or(color, |rgb| 0xFF00_0000 | (rgb & 0xFF_FFFF));
    // rust: match calls[first..].last_mut() {
    // rust: Some(last) if last.color == run => last.text.push_str(&span.text),
    // rust: _ => calls.push(TextCall {
    // rust: matrix: m,
    // rust: x: x + pen,
    // rust: y,
    // rust: text: span.text.clone(),
    // rust: color: run,
    // rust: outline,
    // rust: light,
    // rust: }),
}
    // rust: pen += span.text.chars().map(advance).sum::<f32>();
}
    // rust: if calls.len() == first {
            // A line with no text is still a call, of no glyphs.
    // rust: calls.push(TextCall {
    // rust: matrix: m,
    // rust: x,
    // rust: y,
    // rust: text: String::new(),
    // rust: color,
    // rust: outline,
    // rust: light,
    // rust: });
}
}
    // rust: calls
}

/// How far the text of an outlined call sits in front of its outline, in
/// text units (`Font.DisplayMode.POLYGON_OFFSET`, see `draw_text`).
pub const TEXT_OVER_OUTLINE: f32 = 0.05;

/// Draws a text call with the font atlas: 8x8 glyph cells, the outline as
/// eight one-pixel offsets under the text.
///
/// `TextFeatureRenderer.renderText` draws the outline glyphs NORMAL and the
/// text over them POLYGON_OFFSET, so the coplanar text always wins the depth
/// test. Here both share one mesh, so the text is lifted a hair towards the
/// reader instead (a twentieth of a font pixel, invisible) rather than
/// z-fighting with the outline under it.
pub fn draw_text(scene: *Scene, call: *TextCall, out: *mut std.ArrayList(Vertex)) void {
}
    // rust: text_vertices(scene.glyph, call, out);
}

/// `draw_text` with the font's glyph cells and advances from `glyph`: the
/// text of `call` as glyph quads in its matrix's plane, 1 unit a font pixel,
/// y down as the font's, with its outline when it has one. A native mod's
/// block entity draws its text this way (`native_draw_text`).
pub fn text_vertices(glyph: *dyn Fn(char) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut emit = |dx: f32, dy: f32, z: f32, argb: u32| {
    // rust: let mut x = call.x + dx;
    // rust: let y0 = call.y + dy;
    // rust: for ch in call.text.chars() {
    // rust: let g = glyph(ch);
    // rust: if let Some(cell) = g.rect {
                // BakedSheetGlyph: the glyph's own box from the pen, not a
                // fixed 8x8 cell (a Unifont glyph is 0.5 units per texel).
    // rust: let (x0, x1) = (x + g.left, x + g.right);
    // rust: let (top, bottom) = (y0 + g.top, y0 + g.bottom);
    // rust: let corners = [(x0, bottom), (x1, bottom), (x1, top), (x0, top)];
    // rust: let uvs = [
    // rust: [cell.u0, cell.v1],
    // rust: [cell.u1, cell.v1],
    // rust: [cell.u1, cell.v0],
    // rust: [cell.u0, cell.v0],
    // rust: ];
    // rust: let c =
    // rust: 0xFF00_0000 | (argb & 255) << 16 | (argb >> 8 & 255) << 8 | (argb >> 16 & 255);
    // rust: for ((cx, cy), uv) in corners.into_iter().zip(uvs) {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: call
    // rust: .matrix
    // rust: .transform_point3(Vec3::new(cx, cy, z))
    // rust: .to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: c,
    // rust: light: call.light,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
    // rust: x += g.advance;
}
}
    // rust: if call.outline != 0 {
    // rust: for (dx, dy) in [
    // rust: (-1.0, -1.0),
    // rust: (0.0, -1.0),
    // rust: (1.0, -1.0),
    // rust: (-1.0, 0.0),
    // rust: (1.0, 0.0),
    // rust: (-1.0, 1.0),
    // rust: (0.0, 1.0),
    // rust: (1.0, 1.0),
    // rust: ] {
    // rust: emit(dx, dy, 0.0, call.outline);
}
}
    // rust: let z = if call.outline != 0 {
    // rust: TEXT_OVER_OUTLINE
    // rust: } else {
    // rust: 0.0
}
    // rust: emit(0.0, 0.0, z, call.color);
}

/// Block-entity fields the level ticks, at one position (vanilla's own field
/// values; extraction to render state happens here as in each renderer).
pub const BlockAnim = struct {
    /// `ShulkerBoxBlockEntity` progress and progressOld.
    shulker: (f32,
    /// `BellBlockEntity.ticks` and the click direction while `shaking`.
    bell_ticks: i32,
    bell_shake: ?*'static str,
    /// `ConduitBlockEntity` tickCount, isActive, isHunting and activeRotation.
    conduit: (i32,
    /// `SkullBlockEntity` isAnimating and animationTickCount.
    skull: (bool,
    /// `DecoratedPotBlockEntity` decorations as item ids: back, left, right, front.
    sherds: [?[]const u8,
    /// `DecoratedPotRenderState` wobble style (positive) and progress.
    wobble: Option<(bool,
    /// `EnchantingTableBlockEntity` book fields.
    book: EnchantingBook,
    /// `TheEndGatewayBlockEntity` age and teleportCooldown.
    gateway: (i64,
};

/// One `submitText` call (`AbstractSignRenderer.submitSignText`).
pub const TextCall = struct {
    matrix: Mat4,
    x: f32,
    y: f32,
    text: []const u8,
    /// ARGB.
    color: u32,
    /// ARGB outline colour, 0 for none.
    outline: u32,
    /// Horizon packed light (sky*16 | block*16 << 8).
    light: u32,
};

/// Inputs from the game for one frame of block-entity rendering.
pub const Scene = struct {
    camera: DVec3,
    /// `Camera.rotation` (conduit eyes face the camera).
    orientation: Quat,
    /// Ticked block-entity state at a position.
    anim: *'a dyn Fn([i32,
    /// When set, sign text is recorded here as text calls instead of drawn.
    texts: ?*'a std::cell::RefCell<std.ArrayList(TextCall)>,
    partial: f32,
    game_time: i64,
    /// `Level.getMaxY` (End gateway beams while spawning).
    max_y: i32,
    world: *'a World,
    sprites: *'a HashMap<[]const u8,
    /// The packs' OptiFine emissive overlays of the sprites.
    emissive: *'a horizon_optifine::emissive::Emissive,
    /// Atlas sprites that contain a texel with fractional alpha. Static
    /// geometry stays on the cutout pipeline; these models keep the blended
    /// entity path so resource packs retain their alpha behavior.
    translucent_sprites: *'a std.AutoHashMap([]const u8, void),
    /// Changes on every atlas/resource reload, even if sprite rectangles do not.
    atlas_revision: u64,
    nether: bool,
    /// Chest lid openness (`ChestLidController.getOpenNess`) at a position.
    lid: *'a dyn Fn([i32,
    /// Sign block-entity data at a position.
    sign: *'a dyn Fn([i32,
    /// Banner layers at a position: pattern texture and RGB tint, bottom first.
    banner: *'a dyn Fn([i32,
    /// The skin sprite a `player_head` shows at a position (`SkullBlockRenderer`
    /// profile → skin): a downloaded `skins/<sha1>` slot or the profile's
    /// `DefaultPlayerSkin` fallback; None keeps `SKIN_BY_TYPE` (`DefaultPlayerSkin.getDefaultTexture`, slim steve).
    skull: *'a dyn Fn([i32,
    /// Font glyph: atlas cell (none for blank glyphs such as the space), box and advance.
    glyph: *'a dyn Fn(char) -> Glyph,
    /// Changes whenever `glyph` may answer differently (`Font::epoch`): sign
    /// text laid out under another value is laid out again.
    glyphs: u64,
    /// Per-block visibility for dynamic, animated, or uncached models. Bounds
    /// are world-space and conservatively include model animation extents.
    dynamic_visible: Option<*'a dyn Fn([i32,
};

/// Empty by default (a dedicated server): no state has a block entity model.
pub const BlockEntityRenderer = struct {
    vanilla: *BlockEntityShapes,
    /// What draws: `vanilla`, or the packs' custom entity models over it.
    shapes: RwLock<*BlockEntityShapes>,
    kinds: std.ArrayList(Kind),
    /// Item id to its `PROVIDES_POTTERY_PATTERN` side texture (`Sheets.DECORATED_POT_MAPPER`).
    pot_patterns: HashMap<[]const u8,
    /// `Block.shouldRenderFace` for End gateway faces (its occlusion pair cache needs a lock).
    visibility: ?Mutex<FaceVisibility>,
    sign_texts: Mutex<SignTexts>,
    /// Stable model geometry, relative to its block, for cacheable entities.
    static_geometry: Mutex<StaticGeometry>,
    sign_cache_enabled: AtomicBool,
};
/// Individually enabled caches for block entities with static or separable
/// geometry. Sign boards and beds are block models in the terrain mesh; only
/// sign text has a renderer-side cache.
pub const CacheOptions = struct {
    shulker_boxes: bool,
    signs: bool,
    decorated_pots: bool,
    bells: bool,
    chests: bool,
    banners: bool,
    copper_golem_statues: bool,
};
/// Independent section inputs to cached block-entity geometry. `mesh` changes
/// on every upload (including light updates); `block_entities` changes only
/// when that section's block-entity membership or states change.
pub const StaticSectionRevision = struct {
    mesh: u64,
    block_entities: u64,
};
    // rust: impl CacheOptions {
    /// Whether any per-section model cache is on (the sign-text cache is not one).
pub fn any_model_cache(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shulker_boxes
    // rust: || self.decorated_pots
    // rust: || self.bells
    // rust: || self.chests
    // rust: || self.banners
    // rust: || self.copper_golem_statues
}
}
/// The block-entity models and what is baked from them: vanilla's, or the packs' custom entity
/// models over them ([`crate::block_entity_cem`]).
pub const BlockEntityShapes = struct {
    models: HashMap<*'static str,
    /// Closed chest geometry by chest model: dimension lighting, horizontal facing.
    closed_chests: HashMap<*'static str,
    /// A `.jem`'s texture (atlas name) by model, drawn instead of vanilla's.
    textures: HashMap<*'static str,
};
/// The chest models, each baked with its lid closed.
    // rust: const CHEST_MODELS: [&str; 7] = [
    // rust: "chest",
    // rust: "double_chest_left",
    // rust: "double_chest_right",
    // rust: "trapped_chest",
    // rust: "trapped_chest_left",
    // rust: "trapped_chest_right",
    // rust: "ender_chest",
    // rust: ];
    // rust: impl BlockEntityShapes {
    // rust: fn new(
    // rust: models: HashMap<&'static str, ModelPart>,
    // rust: textures: HashMap<&'static str, String>,
    // rust: ) -> Self {
    // rust: let closed_chests = CHEST_MODELS
    // rust: .iter()
    // rust: .filter_map(|key| Some((*key, closed_chest(models.get(key)?))))
    // rust: .collect();
    // rust: Self {
    // rust: models,
    // rust: closed_chests,
    // rust: textures,
}
}
    /// The texture model `key` draws with: its `.jem`'s when the atlas has it, else `vanilla`.
    // rust: fn texture<'a>(
    // rust: &'a self,
    // rust: key: &str,
    // rust: vanilla: &'a str,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: ) -> &'a str {
    // rust: match self.textures.get(key) {
    // rust: Some(texture) if sprites.contains_key(texture) => texture,
    // rust: _ => vanilla,
}
}
}
/// A chest model with its lid closed, for each dimension lighting and horizontal facing, its UVs
/// over the whole texture.
pub fn closed_chest(model: *ModelPart) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [false, true].map(|nether| {
    // rust: [0.0f32, 90.0, 180.0, 270.0].map(|y_rot| {
    // rust: let mut vertices = Vec::new();
    // rust: draw_part(
    // rust: model,
    // rust: "root",
    // rust: around(
    // rust: Mat4::from_rotation_y((-y_rot).to_radians()),
    // rust: Vec3::new(0.5, 0.0, 0.5),
    // rust: ),
    // rust: &|name, p| {
    // rust: if name == "lid" || name == "lock" {
    // rust: p[3] = crate::block_entity_anim::chest_lid_x_rot(0.0);
}
    // rust: },
    // rust: Paint {
    // rust: sprite: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
    // rust: },
    // rust: tint: 0xFFFFFF,
    // rust: light: 0,
    // rust: lights: diffuse_lights(nether),
    // rust: glow: None,
    // rust: },
    // rust: &mut vertices,
    // rust: );
    // rust: vertices
    // rust: })
    // rust: })
}
/// Laid-out sign text by position. `AbstractSignRenderer` lays the text out
/// again each frame, glyph by glyph; its vertices only change with what is
/// in the key, so they are kept relative to the block and moved to the camera.
pub const SignTexts = struct {
    signs: FxHashMap<[i32,
    /// Game time of the last sweep of signs out of view.
    swept: i64,
};
pub const SignTextEntry = struct {
    state: u32,
    data: SignData,
    packed: u8,
    /// Within the glowing text outline's distance (only kept for glowing text).
    near: bool,
    glyphs: u64,
    /// Game time it was last drawn.
    used: i64,
    vertices: std.ArrayList(Vertex),
};
pub const StaticKey = struct {
    state: u32,
    light: u8,
    nether: bool,
    /// Stable model pose inputs, used by opened but settled shulker boxes.
    pose: [u32,
    /// Atlas coordinates detect UV changes. The enclosing StaticEntry also
    /// carries an atlas identity for reloads that preserve these coordinates.
    /// Static candidates use at most five sprites (a decorated pot's sides).
    sprite_rects: [Option<[u32,
    sprite_count: u8,
};
pub const StaticEntry = struct {
    key: StaticKey,
    pot_sherds: ?[Option<[]const u8,
    section_revision: StaticSectionRevision,
    atlas_revision: u64,
    used: i64,
    vertices: std.ArrayList(Vertex),
};
/// One section of cached block-entity geometry, stored in section-local space.
/// The render thread uploads each section independently and only draws the
/// sections intersecting its coarse frustum set.
pub const StaticSectionSnapshot = struct {
    section: [i32,
    origin: [i32,
    revision: u64,
    entities: u32,
    vertices: *[Vertex],
};
pub const StaticCacheFrameStats = struct {
    /// Number of per-section CPU snapshots rebuilt this frame.
    snapshot_rebuilds: u64,
    /// Vertex bytes generated by those CPU rebuilds.
    snapshot_bytes_built: u64,
    /// Identity of the published section list; changes only when cached
    /// geometry changes so the GPU cache can skip per-frame scans.
    snapshot_revision: u64,
    /// Vertex bytes actually written to static GPU buffers this frame.
    static_bytes_uploaded: u64,
    static_entities_drawn: u64,
    dynamic_entities_drawn: u64,
};
pub const StaticSectionGeometry = struct {
    revision: u64,
    entities: u32,
    vertices: *[Vertex],
    dirty: bool,
};
pub const RenderCacheResult = struct {
    visible_sections: Vec<[i32,
    stats: StaticCacheFrameStats,
};
pub fn static_candidate(kind: *Kind, options: CacheOptions) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(kind, Kind::Chest { .. } if options.chests)
    // rust: || matches!(kind, Kind::Shulker { .. } if options.shulker_boxes)
    // rust: || matches!(kind, Kind::Bell if options.bells)
    // rust: || matches!(kind, Kind::Banner { .. } if options.banners)
    // rust: || matches!(kind, Kind::DecoratedPot { .. } if options.decorated_pots)
    // rust: || matches!(kind, Kind::CopperGolem { .. } if options.copper_golem_statues)
}
pub fn static_pot_sherds(scene: *Scene, pos: [i32; 3], kind: *Kind) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(kind, Kind::DecoratedPot { .. }).then(|| (scene.anim)(pos).sherds)
}
pub const StaticGeometry = struct {
    /// Small sorted lists by section. Block entities arrive section by
    /// section, so the map is touched only at section boundaries and a local
    /// 12-bit position index replaces a hash lookup for each model.
    sections: FxHashMap<[i32,
    section_geometry: FxHashMap<[i32,
    dirty_sections: Vec<[i32,
    len: usize,
    swept: i64,
    options: ?CacheOptions,
    published: *[StaticSectionSnapshot],
    published_dirty: bool,
    published_revision: u64,
    visible_sections: Vec<[i32,
    reconciled_membership_revision: ?u64,
    next_section_revision: u64,
    snapshot_rebuilds: u64,
    snapshot_bytes_built: u64,
};
    // rust: impl StaticGeometry {
pub fn mark_section_dirty(self: *Self, section: [i32; 3]) void {
}
    // rust: let geometry = self.section_geometry.entry(section).or_default();
    // rust: if !geometry.dirty {
    // rust: geometry.dirty = true;
    // rust: self.dirty_sections.push(section);
}
    // rust: self.published_dirty = true;
}

pub fn reconcile_sections(self: *Self, revision: *dyn Fn([i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cached = self.sections.keys().copied().collect::<Vec<_>>();
    // rust: for section in cached {
    // rust: let current = revision(section);
    // rust: let membership_changed = self
    // rust: .sections
    // rust: .get(&section)
    // rust: .and_then(|entries| entries.first())
    // rust: .is_some_and(|(_, entry)| {
    // rust: current.is_none_or(|current| {
    // rust: current.block_entities != entry.section_revision.block_entities
    // rust: })
    // rust: });
    // rust: if membership_changed {
    // rust: if let Some(entries) = self.sections.remove(&section) {
    // rust: self.len = self.len.saturating_sub(entries.len());
}
    // rust: self.section_geometry.remove(&section);
    // rust: self.published_dirty = true;
}
}
}

pub fn sweep(self: *Self, now: i64) void {
}
    // rust: if (now - self.swept).abs() >= SIGN_TEXT_KEEP {
    // rust: self.swept = now;
    // rust: let before = self.len;
    // rust: let mut emptied = Vec::new();
    // rust: let mut changed = Vec::new();
    // rust: self.sections.retain(|section, entries| {
    // rust: let old_len = entries.len();
    // rust: entries.retain(|(_, entry)| (now - SIGN_TEXT_KEEP..=now).contains(&entry.used));
    // rust: if entries.len() != old_len {
    // rust: changed.push(*section);
}
    // rust: if entries.is_empty() {
    // rust: emptied.push(*section);
}
    // rust: !entries.is_empty()
    // rust: });
    // rust: for section in changed {
    // rust: self.mark_section_dirty(section);
}
    // rust: for section in emptied {
    // rust: self.section_geometry.remove(&section);
}
    // rust: self.len = self.sections.values().map(Vec::len).sum();
    // rust: self.published_dirty |= self.len != before;
}
}

    // rust: fn snapshot(
    // rust: &mut self,
    // rust: min_y: i32,
    // rust: mut visible_sections: Vec<[i32; 3]>,
    // rust: ) -> (
    // rust: Arc<[StaticSectionSnapshot]>,
    // rust: Vec<[i32; 3]>,
    // rust: StaticCacheFrameStats,
    // rust: ) {
    // rust: visible_sections.sort_unstable();
    // rust: visible_sections.dedup();
    // rust: self.visible_sections = visible_sections;

    // rust: let mut rebuilt = 0;
    // rust: let mut bytes_built = 0;
    // rust: for section in std::mem::take(&mut self.dirty_sections) {
    // rust: let Some(entries) = self.sections.get(&section) else {
    // rust: continue;
}
    // rust: let Some(geometry) = self.section_geometry.get_mut(&section) else {
    // rust: continue;
}
    // rust: if !geometry.dirty {
    // rust: continue;
}
    // rust: let mut vertices = Vec::new();
    // rust: for &(local, ref entry) in entries {
    // rust: let block_offset = Vec3::new(
    // rust: f32::from(local & 15),
    // rust: f32::from((local >> 8) & 15),
    // rust: f32::from((local >> 4) & 15),
    // rust: );
    // rust: vertices.extend(entry.vertices.iter().map(|vertex| Vertex {
    // rust: pos: (Vec3::from_array(vertex.pos) + block_offset).to_array(),
    // rust: ..*vertex
    // rust: }));
}
    // rust: bytes_built += (vertices.len() * std::mem::size_of::<Vertex>()) as u64;
    // rust: rebuilt += 1;
    // rust: geometry.vertices = vertices.into();
    // rust: geometry.entities = entries
    // rust: .iter()
    // rust: .filter(|(_, entry)| !entry.vertices.is_empty())
    // rust: .count() as u32;
    // rust: self.next_section_revision = next_static_snapshot_revision();
    // rust: geometry.revision = self.next_section_revision;
    // rust: geometry.dirty = false;
    // rust: self.published_dirty = true;
}
    // rust: if self.published_dirty {
    // rust: let mut published = self
    // rust: .section_geometry
    // rust: .iter()
    // rust: .filter(|(_, geometry)| !geometry.vertices.is_empty())
    // rust: .map(|(&section, geometry)| StaticSectionSnapshot {
    // rust: section,
    // rust: origin: [section[0] * 16, min_y + section[1] * 16, section[2] * 16],
    // rust: revision: geometry.revision,
    // rust: entities: geometry.entities,
    // rust: vertices: geometry.vertices.clone(),
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: published.sort_unstable_by_key(|snapshot| snapshot.section);
    // rust: self.published = published.into();
    // rust: self.published_revision = next_static_snapshot_revision();
    // rust: self.published_dirty = false;
}
    // rust: self.snapshot_rebuilds += rebuilt;
    // rust: self.snapshot_bytes_built += bytes_built;
    // rust: let stats = StaticCacheFrameStats {
    // rust: snapshot_rebuilds: rebuilt,
    // rust: snapshot_bytes_built: bytes_built,
    // rust: snapshot_revision: self.published_revision,
    // rust: ..Default::default()
}
    // rust: (
    // rust: self.published.clone(),
    // rust: std::mem::take(&mut self.visible_sections),
    // rust: stats,
    // rust: )
}
}
pub fn sprite_rect_key(scene: *Scene, texture: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: scene.sprites.get(texture).copied().map(|sprite| {
    // rust: [
    // rust: sprite.u0.to_bits(),
    // rust: sprite.v0.to_bits(),
    // rust: sprite.u1.to_bits(),
    // rust: sprite.v1.to_bits(),
    // rust: sprite.w,
    // rust: sprite.h,
    // rust: ]
    // rust: })
}
pub fn static_section(pos: [i32; 3], min_y: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [pos[0] >> 4, (pos[1] - min_y) >> 4, pos[2] >> 4]
}
pub fn static_local_index(pos: [i32; 3], min_y: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((((pos[1] - min_y) & 15) << 8) | ((pos[2] & 15) << 4) | (pos[0] & 15)) as u16
}
/// Game ticks a sign's text is kept after it was last drawn.
pub const SIGN_TEXT_KEEP: i64 = 100;
/// Bound retained static model geometry when a player has visited many
/// block-entity positions in the last few seconds.
pub const STATIC_GEOMETRY_MAX_ENTRIES: usize = 4096;
pub fn next_static_snapshot_revision() u {
    // Implementation ported from Horizon
    return undefined;
}
pub const NEXT: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(1);
    // rust: NEXT.fetch_add(1, Ordering::Relaxed)
}
    // rust: const MODELS: [(&str, &str); 27] = [
    // rust: ("chest", "minecraft:chest#main"),
    // rust: ("double_chest_left", "minecraft:double_chest_left#main"),
    // rust: ("double_chest_right", "minecraft:double_chest_right#main"),
    // rust: ("shulker_box", "minecraft:shulker_box#main"),
    // rust: ("standing_banner", "minecraft:standing_banner#main"),
    // rust: ("standing_banner_flag", "minecraft:standing_banner#flag"),
    // rust: ("wall_banner", "minecraft:wall_banner#main"),
    // rust: ("wall_banner_flag", "minecraft:wall_banner#flag"),
    // rust: ("skeleton_skull", "minecraft:skeleton_skull#main"),
    // rust: (
    // rust: "wither_skeleton_skull",
    // rust: "minecraft:wither_skeleton_skull#main",
    // rust: ),
    // rust: ("zombie_head", "minecraft:zombie_head#main"),
    // rust: ("creeper_head", "minecraft:creeper_head#main"),
    // rust: ("dragon_skull", "minecraft:dragon_skull#main"),
    // rust: ("piglin_head", "minecraft:piglin_head#main"),
    // rust: ("player_head", "minecraft:player_head#main"),
    // rust: ("bell", "minecraft:bell#main"),
    // rust: ("book", "minecraft:book#main"),
    // rust: ("conduit_shell", "minecraft:conduit#shell"),
    // rust: ("conduit_cage", "minecraft:conduit#cage"),
    // rust: ("conduit_wind", "minecraft:conduit#wind"),
    // rust: ("conduit_eye", "minecraft:conduit#eye"),
    // rust: ("decorated_pot_base", "minecraft:decorated_pot_base#main"),
    // rust: ("decorated_pot_sides", "minecraft:decorated_pot_sides#main"),
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
/// `BlockEntityRenderer.getViewDistance` default.
pub const VIEW_DISTANCE: f64 = 64.0;

    // rust: impl BlockEntityRenderer {
pub fn load(root: *Path, registry: *BlockRegistry) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let visibility = load_visibility(root, registry)?;
    // rust: Self::load_with_visibility(root, registry, visibility)
}
    /// [`BlockEntityRenderer::load`] over the face visibility the meshes use
    /// (`MeshTables::visibility`): a clone shares its shapes and their faces.
    // rust: pub fn load_with_visibility(
    // rust: root: &Path,
    // rust: registry: &BlockRegistry,
    // rust: visibility: FaceVisibility,
    // rust: ) -> Result<Self> {
    // rust: let all: Value = serde_json::from_slice(&std::fs::read(root.join("entity-models.json"))?)?;
    // rust: let models = MODELS
    // rust: .iter()
    // rust: .filter_map(|(key, layer)| all.get(*layer).map(|v| (*key, ModelPart::parse(v))))
    // rust: .collect();
    // rust: let mut renderer = Self::new(models, registry);
    // rust: renderer.visibility = Some(Mutex::new(visibility));
        // The packs' custom entity models (`.jem` files), before anything draws.
    // rust: renderer.set_shapes(renderer.shapes_for(root));
        // Sherd items: provides_pottery_pattern -> decorated_pot_pattern asset id.
    // rust: let items = match horizon_world::item_defaults::read(root) {
    // rust: Ok(items) => items,
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => Default::default(),
    // rust: Err(e) => return Err(e.into()),
}
    // rust: for (item, components) in &items {
    // rust: let Some(pattern) = components["minecraft:provides_pottery_pattern"].as_str() else {
    // rust: continue;
}
    // rust: let name = pattern.strip_prefix("minecraft:").unwrap_or(pattern);
    // rust: let file = root.join(format!("data/minecraft/decorated_pot_pattern/{name}.json"));
    // rust: let Ok(def) = std::fs::read(file) else {
    // rust: continue;
}
    // rust: let def: Value = serde_json::from_slice(&def)?;
    // rust: if let Some(asset) = def["asset_id"].as_str() {
    // rust: let asset = asset.strip_prefix("minecraft:").unwrap_or(asset);
    // rust: renderer
    // rust: .pot_patterns
    // rust: .insert(item.clone(), format!("entity/decorated_pot/{asset}"));
}
}
    // rust: Ok(renderer)
}
pub fn new(models: HashMap<*'static str, registry: *BlockRegistry) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let vanilla = Arc::new(BlockEntityShapes::new(models, HashMap::new()));
    // rust: let kinds = (0..registry.len() as u32)
    // rust: .map(|id| {
    // rust: registry.state(BlockStateId(id)).map_or(Kind::None, |s| {
    // rust: let prop = |k: &str| s.properties.get(k).cloned();
    // rust: match classify(&s.name, &prop) {
    // rust: Kind::EndGateway { .. } => Kind::EndGateway { state: id },
    // rust: kind => kind,
}
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: shapes: RwLock::new(vanilla.clone()),
    // rust: vanilla,
    // rust: kinds,
    // rust: pot_patterns: HashMap::new(),
    // rust: visibility: None,
    // rust: sign_texts: Mutex::default(),
    // rust: static_geometry: Mutex::default(),
    // rust: sign_cache_enabled: AtomicBool::new(false),
}
}
    /// The models the packs under `root` give, their `.jem` files over vanilla's, for
    /// [`Self::set_shapes`] (a pack reload): vanilla's own, shared, without any.
pub fn shapes_for(self: *Self, root: *Path) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match crate::block_entity_cem::reshape(root, &self.vanilla.models) {
    // rust: Some((models, textures)) => Arc::new(BlockEntityShapes::new(models, textures)),
    // rust: None => self.vanilla.clone(),
}
}
pub fn set_shapes(self: *Self, shapes: *BlockEntityShapes) void {
}
    // rust: let changed = {
    // rust: let mut current = self.shapes.write().unwrap_or_else(PoisonError::into_inner);
    // rust: if Arc::ptr_eq(&current, &shapes) {
    // rust: false
    // rust: } else {
    // rust: *current = shapes;
    // rust: true
}
}
    // rust: if changed && let Ok(mut cache) = self.static_geometry.lock() {
    // rust: *cache = StaticGeometry::default();
}
}
pub fn shapes(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shapes
    // rust: .read()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .clone()
}
    /// A mod's signs, known by class where vanilla's go by name (`classify`).
pub fn add_mod_signs(self: *Self, facts: *crate::blocks::BlockFacts, registry: *BlockRegistry) void {
}
    // rust: for (id, kind) in self.kinds.iter_mut().enumerate() {
    // rust: let state = BlockStateId(id as u32);
    // rust: if let (Some(form), Some(s)) = (facts.get(state).sign_form(), registry.state(state)) {
    // rust: let prop = |k: &str| s.properties.get(k).cloned();
    // rust: *kind = sign(form.hanging, form.wall, &prop);
}
}
}
pub fn kind(self: *Self, state: u32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.kinds.get(state as usize).unwrap_or(&Kind::None)
}
    // rust: fn dynamic_bounds(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: pos: [i32; 3],
    // rust: kind: &Kind,
    // rust: chest_openness: Option<(f32, Option<[i32; 3]>)>,
    // rust: ) -> (DVec3, DVec3) {
    // rust: let [x, y, z] = pos.map(f64::from);
    // rust: let mut lo = DVec3::new(x, y, z);
    // rust: let mut hi = DVec3::new(x + 1.0, y + 1.0, z + 1.0);
    // rust: match kind {
    // rust: Kind::Chest { double_with, .. } => {
    // rust: if let Some(offset) = double_with {
    // rust: lo.x += f64::from(offset[0].min(0));
    // rust: lo.z += f64::from(offset[2].min(0));
    // rust: hi.x += f64::from(offset[0].max(0));
    // rust: hi.z += f64::from(offset[2].max(0));
}
    // rust: let is_open = chest_openness.map_or_else(
    // rust: || {
    // rust: (scene.lid)(pos) != 0.0
    // rust: || double_with.is_some_and(|offset| {
    // rust: let other = [
    // rust: pos[0].saturating_add(offset[0]),
    // rust: pos[1].saturating_add(offset[1]),
    // rust: pos[2].saturating_add(offset[2]),
    // rust: ];
    // rust: (scene.lid)(other) != 0.0
    // rust: })
    // rust: },
    // rust: |(open, _)| open != 0.0,
    // rust: );
    // rust: if is_open {
                    // The lid pivots up from the rear edge. Its longest corner
                    // rises by less than one block in the fully open pose.
    // rust: hi.y += 0.8;
}
}
    // rust: Kind::Shulker { facing, .. } => {
    // rust: let offset = step(facing);
    // rust: lo.x += f64::from(offset[0].min(0)) * 0.52;
    // rust: lo.y += f64::from(offset[1].min(0)) * 0.52;
    // rust: lo.z += f64::from(offset[2].min(0)) * 0.52;
    // rust: hi.x += f64::from(offset[0].max(0)) * 0.52;
    // rust: hi.y += f64::from(offset[1].max(0)) * 0.52;
    // rust: hi.z += f64::from(offset[2].max(0)) * 0.52;
}
    // rust: Kind::Banner { wall: false, .. } => {
    // rust: hi.y += 1.0;
    // rust: lo.x -= 0.05;
    // rust: lo.z -= 0.05;
    // rust: hi.x += 0.05;
    // rust: hi.z += 0.05;
}
    // rust: Kind::Banner { wall: true, .. } => {
    // rust: lo.y -= 1.0;
    // rust: lo.x -= 0.05;
    // rust: lo.z -= 0.05;
    // rust: hi.x += 0.05;
    // rust: hi.z += 0.05;
}
    // rust: Kind::Sign { hanging: true, .. } => {
    // rust: lo.y -= 1.0;
    // rust: lo.x -= 0.15;
    // rust: lo.z -= 0.15;
    // rust: hi.x += 0.15;
    // rust: hi.z += 0.15;
}
    // rust: Kind::Sign { hanging: false, .. } => {
    // rust: hi.y += 0.3;
    // rust: lo.x -= 0.02;
    // rust: lo.z -= 0.02;
    // rust: hi.x += 0.02;
    // rust: hi.z += 0.02;
}
    // rust: Kind::EnchantingTable | Kind::Lectern { .. } => {
                // The book and statue models rise above the block's collision
                // cube; include their full rendered height and rotated corners.
    // rust: hi.y += 1.0;
    // rust: lo.x -= 0.25;
    // rust: lo.z -= 0.25;
    // rust: hi.x += 0.25;
    // rust: hi.z += 0.25;
}
    // rust: Kind::CopperGolem { .. } => {
                // The statue pose rotates around the root, so some variants
                // extend below the block as well as above it.
    // rust: lo.y -= 1.0;
    // rust: hi.y += 1.0;
    // rust: lo.x -= 0.25;
    // rust: lo.z -= 0.25;
    // rust: hi.x += 0.25;
    // rust: hi.z += 0.25;
}
    // rust: Kind::Conduit => {
                // Its animated cage is centered above the conduit block and
                // the wind model spans multiple cells. The caller bypasses
                // voxel occlusion for envelopes this tall, but retains frustum
                // culling with this conservative volume.
    // rust: lo.x -= 1.0;
    // rust: lo.y -= 1.0;
    // rust: lo.z -= 1.0;
    // rust: hi.x += 1.0;
    // rust: hi.y += 1.0;
    // rust: hi.z += 1.0;
}
    // rust: Kind::Bell => {
                // The bell's pivoted swing moves its corners slightly outside
                // the block even though the model starts centered in it.
    // rust: lo.x -= 0.1;
    // rust: lo.y -= 0.1;
    // rust: lo.z -= 0.1;
    // rust: hi.x += 0.1;
    // rust: hi.y += 0.1;
    // rust: hi.z += 0.1;
}
    // rust: Kind::Skull { .. } => {
                // Wall-mounted and dragon heads can protrude from their block.
    // rust: lo.x -= 0.25;
    // rust: lo.y -= 0.25;
    // rust: lo.z -= 0.25;
    // rust: hi.x += 0.25;
    // rust: hi.y += 0.25;
    // rust: hi.z += 0.25;
}
    // rust: Kind::EndGateway { .. } => {
    // rust: let anim = (scene.anim)(pos);
    // rust: let beam = gateway_beam(anim.gateway, scene.partial, scene.max_y, scene.game_time);
    // rust: let height = f64::from(beam.height.max(0));
    // rust: lo.y -= height;
    // rust: hi.y += height;
}
    // rust: _ => {}
}
    // rust: (lo, hi)
}

    // rust: fn is_dynamic_visible(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: shapes: &Arc<BlockEntityShapes>,
    // rust: pos: [i32; 3],
    // rust: state: u32,
    // rust: kind: &Kind,
    // rust: chest_openness: Option<(f32, Option<[i32; 3]>)>,
    // rust: ) -> bool {
    // rust: let Some(visible) = scene.dynamic_visible else {
    // rust: return true;
}
    // rust: if matches!(kind, Kind::EndGateway { .. }) {
    // rust: return true;
}
        // A pack model may extend outside the vanilla envelope. Keep that
        // geometry on the uncullable path unless its model bounds are known.
    // rust: if !Arc::ptr_eq(shapes, &self.vanilla) {
    // rust: return true;
}
    // rust: let (lo, hi) = self.dynamic_bounds(scene, pos, kind, chest_openness);
    // rust: visible(pos, state, lo, hi)
}

    // rust: fn cached_entry_is_current(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: pos: [i32; 3],
    // rust: state: u32,
    // rust: kind: &Kind,
    // rust: options: CacheOptions,
    // rust: entry: &StaticEntry,
    // rust: section_revision: StaticSectionRevision,
    // rust: chest_openness: Option<(f32, Option<[i32; 3]>)>,
    // rust: ) -> bool {
    // rust: if entry.key.state != state
    // rust: || entry.key.nether != scene.nether
    // rust: || entry.section_revision != section_revision
    // rust: || entry.atlas_revision != scene.atlas_revision
    // rust: || !static_candidate(kind, options)
    // rust: {
    // rust: return false;
}
    // rust: match kind {
    // rust: Kind::Chest { .. } => {
    // rust: let (open, other) = chest_openness.unwrap_or_else(|| {
    // rust: self.chest_openness(
    // rust: pos,
    // rust: kind,
    // rust: &|p| scene.world.block(p[0], p[1], p[2]).0,
    // rust: scene.lid,
    // rust: )
    // rust: });
    // rust: if open != 0.0 {
    // rust: return false;
}
    // rust: let mut light = scene.world.light(pos[0], pos[1], pos[2]);
    // rust: if let Some(other) = other {
    // rust: let other_light = scene.world.light(other[0], other[1], other[2]);
    // rust: light = (light >> 4).max(other_light >> 4) << 4
    // rust: | (light & 15).max(other_light & 15);
}
    // rust: entry.key.light == light
}
    // rust: Kind::Shulker { .. } => {
    // rust: let (progress, old) = (scene.anim)(pos).shulker;
    // rust: progress == old && progress.to_bits() == entry.key.pose[0]
}
    // rust: Kind::Bell => (scene.anim)(pos).bell_shake.is_none(),
    // rust: Kind::Banner { .. } | Kind::CopperGolem { .. } => true,
            // Sherd textures come from block-entity NBT. Re-resolve these few
            // item ids without repeating five atlas lookups on every frame.
    // rust: Kind::DecoratedPot { .. } => {
    // rust: let anim = (scene.anim)(pos);
    // rust: !anim
    // rust: .wobble
    // rust: .is_some_and(|(_, progress)| (0.0..=1.0).contains(&progress))
    // rust: && entry.pot_sherds.as_ref() == Some(&anim.sherds)
}
    // rust: _ => false,
}
}
    // rust: pub fn render<'a>(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: blocks: impl Iterator<Item = &'a ([i32; 3], u32)>,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let _ = self.render_inner(
    // rust: scene,
    // rust: blocks,
    // rust: CacheOptions {
                // Sign geometry has been cached by the renderer for years;
                // keep that behavior for callers that do not provide settings.
    // rust: signs: true,
    // rust: ..CacheOptions::default()
    // rust: },
    // rust: out,
    // rust: |_, _, _| {},
    // rust: |_, _, _, _| {},
    // rust: false,
    // rust: None,
    // rust: false,
    // rust: None,
    // rust: );
}
    /// Draws block entities with only the requested renderer caches enabled.
    /// Dynamic portions continue to use their ordinary animation path.
    // rust: pub fn render_with_cache_options<'a>(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: blocks: impl Iterator<Item = &'a ([i32; 3], u32)>,
    // rust: options: CacheOptions,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let _ = self.render_inner(
    // rust: scene,
    // rust: blocks,
    // rust: options,
    // rust: out,
    // rust: |_, _, _| {},
    // rust: |_, _, _, _| {},
    // rust: false,
    // rust: None,
    // rust: false,
    // rust: None,
    // rust: );
}
    /// Renders cacheable block-entity models into per-section snapshots. The
    /// frustum-visible set controls only which section buffers draw; it does
    /// not change their geometry or force an upload.
    // rust: pub fn render_with_gpu_cache_options<'a>(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: blocks: impl Iterator<Item = &'a ([i32; 3], u32)>,
    // rust: cache_candidates: impl Iterator<Item = &'a ([i32; 3], u32)>,
    // rust: options: CacheOptions,
    // rust: membership_revision: u64,
    // rust: section_revision: impl Fn([i32; 3]) -> Option<StaticSectionRevision>,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) -> (
    // rust: Arc<[StaticSectionSnapshot]>,
    // rust: Vec<[i32; 3]>,
    // rust: StaticCacheFrameStats,
    // rust: ) {
        // Warm every static model in the nearby loaded sections. This is
        // deliberately independent of the camera frustum, so a turn only
        // changes the section draw list below.
    // rust: if options.any_model_cache() {
    // rust: let _ = self.render_inner(
    // rust: scene,
    // rust: cache_candidates,
    // rust: options,
    // rust: &mut Vec::new(),
    // rust: |_, _, _| {},
    // rust: |_, _, _, _| {},
    // rust: true,
    // rust: Some(&section_revision),
    // rust: true,
    // rust: Some(membership_revision),
    // rust: );
}
    // rust: let visible = self.render_inner(
    // rust: scene,
    // rust: blocks,
    // rust: options,
    // rust: out,
    // rust: |_, _, _| {},
    // rust: |_, _, _, _| {},
    // rust: true,
    // rust: Some(&section_revision),
    // rust: false,
    // rust: None,
    // rust: );
    // rust: self.static_geometry
    // rust: .lock()
    // rust: .map(|mut cache| {
    // rust: let (sections, visible_sections, mut stats) =
    // rust: cache.snapshot(scene.world.layout().min_y(), visible.visible_sections);
    // rust: stats.static_entities_drawn = visible_sections
    // rust: .iter()
    // rust: .filter_map(|section| {
    // rust: sections
    // rust: .binary_search_by_key(section, |snapshot| snapshot.section)
    // rust: .ok()
    // rust: .map(|index| u64::from(sections[index].entities))
    // rust: })
    // rust: .sum();
    // rust: stats.dynamic_entities_drawn = visible.stats.dynamic_entities_drawn;
    // rust: (sections, visible_sections, stats)
    // rust: })
    // rust: .unwrap_or_default()
}
    /// Draws block entities in one section-grouped pass while preserving a
    /// callback boundary around each entity for shader-pack spans.
    // rust: pub fn render_with_cache_options_and_callbacks<'a>(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: blocks: impl Iterator<Item = &'a ([i32; 3], u32)>,
    // rust: options: CacheOptions,
    // rust: membership_revision: u64,
    // rust: section_revision: Option<&dyn Fn([i32; 3]) -> Option<StaticSectionRevision>>,
    // rust: out: &mut Vec<Vertex>,
    // rust: before: impl FnMut([i32; 3], u32, usize),
    // rust: after: impl FnMut([i32; 3], u32, usize, &mut Vec<Vertex>),
    // rust: ) -> StaticCacheFrameStats {
    // rust: self.render_inner(
    // rust: scene,
    // rust: blocks,
    // rust: options,
    // rust: out,
    // rust: before,
    // rust: after,
    // rust: false,
    // rust: section_revision,
    // rust: false,
    // rust: Some(membership_revision),
    // rust: )
    // rust: .stats
}
    // rust: fn render_inner<'a>(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: blocks: impl Iterator<Item = &'a ([i32; 3], u32)>,
    // rust: options: CacheOptions,
    // rust: out: &mut Vec<Vertex>,
    // rust: mut before: impl FnMut([i32; 3], u32, usize),
    // rust: mut after: impl FnMut([i32; 3], u32, usize, &mut Vec<Vertex>),
    // rust: gpu_static: bool,
    // rust: section_revision: Option<&dyn Fn([i32; 3]) -> Option<StaticSectionRevision>>,
    // rust: cache_only: bool,
    // rust: membership_revision: Option<u64>,
    // rust: ) -> RenderCacheResult {
    // rust: let lights = diffuse_lights(scene.nether);
    // rust: let shapes = self.shapes();
    // rust: let clear_sign_texts = self
    // rust: .sign_cache_enabled
    // rust: .swap(options.signs, Ordering::Relaxed)
    // rust: && !options.signs;
    // rust: if clear_sign_texts && let Ok(mut cache) = self.sign_texts.lock() {
    // rust: cache.signs.clear();
}
    // rust: let mut cache = if options.any_model_cache() || gpu_static {
    // rust: self.static_geometry.lock().ok()
    // rust: } else {
    // rust: None
}
    // rust: if let Some(cache) = &mut cache {
    // rust: if cache.options != Some(options) {
    // rust: cache.sections.clear();
    // rust: cache.section_geometry.clear();
    // rust: cache.dirty_sections.clear();
    // rust: cache.len = 0;
    // rust: cache.published = Arc::from([]);
    // rust: cache.options = Some(options);
    // rust: cache.published_dirty = true;
}
    // rust: cache.sweep(scene.game_time);
    // rust: if let (Some(revision), Some(membership_revision)) =
    // rust: (section_revision, membership_revision)
    // rust: && cache.reconciled_membership_revision != Some(membership_revision)
    // rust: {
    // rust: cache.reconcile_sections(revision);
    // rust: cache.reconciled_membership_revision = Some(membership_revision);
}
}
        // The renderer supplies block entities grouped by section. Keep that
        // section's small local cache list out of the map while walking its
        // blocks, then return it when the input advances to another section.
    // rust: let mut active_section = None;
    // rust: let mut active_section_revision = None;
    // rust: let mut active_section_has_geometry = false;
    // rust: let mut active_entries = Vec::new();
    // rust: let mut result = RenderCacheResult::default();
    // rust: let section_min_y = scene.world.layout().min_y();
    // rust: for block in blocks {
    // rust: let (pos, state) = *block;
    // rust: let start = out.len();
    // rust: before(pos, state, start);
    // rust: let section = static_section(pos, section_min_y);
    // rust: 'draw: {
    // rust: if let Some(cache) = &mut cache
    // rust: && active_section != Some(section)
    // rust: {
    // rust: if let Some(previous) = active_section {
    // rust: if active_entries.is_empty() {
    // rust: cache.sections.remove(&previous);
    // rust: if cache.section_geometry.remove(&previous).is_some() {
    // rust: cache.published_dirty = true;
}
    // rust: } else {
    // rust: cache
    // rust: .sections
    // rust: .insert(previous, std::mem::take(&mut active_entries));
}
}
    // rust: active_entries = cache.sections.remove(&section).unwrap_or_default();
    // rust: active_section = Some(section);
    // rust: active_section_revision =
    // rust: section_revision.and_then(|revision| revision(section));
    // rust: active_section_has_geometry = cache.section_geometry.contains_key(&section);
}
    // rust: let kind = self.kind(state);
    // rust: if matches!(kind, Kind::None) {
    // rust: break 'draw;
}
    // rust: if cache_only && !static_candidate(kind, options) {
    // rust: break 'draw;
}
    // rust: let center = DVec3::new(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: );
                // BlockEntityRenderer.getViewDistance: 256 for End gateways.
    // rust: let distance = if matches!(kind, Kind::EndGateway { .. }) {
    // rust: 256.0
    // rust: } else {
    // rust: VIEW_DISTANCE
}
    // rust: if center.distance_squared(scene.camera) > distance * distance {
    // rust: break 'draw;
}
    // rust: let local = static_local_index(pos, section_min_y);
    // rust: let current_section_revision = active_section_revision.unwrap_or_default();
    // rust: let chest_openness = (cache.is_some()
    // rust: && options.chests
    // rust: && matches!(kind, Kind::Chest { .. }))
    // rust: .then(|| {
    // rust: self.chest_openness(
    // rust: pos,
    // rust: kind,
    // rust: &|p| scene.world.block(p[0], p[1], p[2]).0,
    // rust: scene.lid,
    // rust: )
    // rust: });
    // rust: if cache_only && section_revision.is_some() && active_section_revision.is_none() {
    // rust: break 'draw;
}
    // rust: if cache.is_some()
    // rust: && section_revision.is_some()
    // rust: && active_section_has_geometry
    // rust: && let Ok(index) = active_entries.binary_search_by_key(&local, |(i, _)| *i)
    // rust: && self.cached_entry_is_current(
    // rust: scene,
    // rust: pos,
    // rust: state,
    // rust: kind,
    // rust: options,
    // rust: &active_entries[index].1,
    // rust: current_section_revision,
    // rust: chest_openness,
    // rust: )
    // rust: {
    // rust: let entry = &mut active_entries[index].1;
    // rust: entry.used = scene.game_time;
    // rust: if cache_only {
    // rust: break 'draw;
}
    // rust: result.visible_sections.push(section);
    // rust: if !gpu_static {
    // rust: result.stats.static_entities_drawn += 1;
    // rust: let origin =
    // rust: (DVec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]))
    // rust: - scene.camera)
    // rust: .as_vec3();
    // rust: out.extend(entry.vertices.iter().map(|vertex| Vertex {
    // rust: pos: (Vec3::from_array(vertex.pos) + origin).to_array(),
    // rust: ..*vertex
    // rust: }));
}
    // rust: if matches!(kind, Kind::Banner { .. })
    // rust: && self.is_dynamic_visible(scene, &shapes, pos, state, kind, None)
    // rust: {
    // rust: let packed = scene.world.light(pos[0], pos[1], pos[2]);
    // rust: let origin =
    // rust: (DVec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]))
    // rust: - scene.camera)
    // rust: .as_vec3();
    // rust: self.render_banner(
    // rust: &shapes,
    // rust: scene,
    // rust: pos,
    // rust: kind,
    // rust: Mat4::from_translation(origin),
    // rust: packed,
    // rust: lights,
    // rust: false,
    // rust: true,
    // rust: out,
    // rust: );
}
    // rust: break 'draw;
}
    // rust: if cache_only && chest_openness.is_some_and(|(open, _)| open != 0.0) {
    // rust: if let Some(cache) = &mut cache
    // rust: && let Ok(index) =
    // rust: active_entries.binary_search_by_key(&local, |(index, _)| *index)
    // rust: {
    // rust: active_entries.remove(index);
    // rust: cache.len -= 1;
    // rust: cache.mark_section_dirty(section);
}
    // rust: break 'draw;
}
    // rust: let origin = (DVec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]))
    // rust: - scene.camera)
    // rust: .as_vec3();
    // rust: let mut packed = scene.world.light(pos[0], pos[1], pos[2]);
    // rust: if matches!(kind, Kind::Sign { .. }) && scene.texts.is_none() {
    // rust: if !self.is_dynamic_visible(scene, &shapes, pos, state, kind, None) {
    // rust: break 'draw;
}
    // rust: if options.signs {
    // rust: self.sign_text(scene, pos, state, origin, packed, out);
    // rust: } else {
    // rust: self.render_one(
    // rust: scene,
    // rust: pos,
    // rust: kind,
    // rust: Mat4::from_translation(origin),
    // rust: packed,
    // rust: lights,
    // rust: false,
    // rust: true,
    // rust: out,
    // rust: );
}
    // rust: break 'draw;
}
    // rust: if let Some(cache) = &mut cache
    // rust: && let Some(key) = self.static_key(
    // rust: scene,
    // rust: pos,
    // rust: state,
    // rust: kind,
    // rust: options,
    // rust: &mut packed,
    // rust: chest_openness,
    // rust: )
    // rust: {
    // rust: let slot = active_entries.binary_search_by_key(&local, |(index, _)| *index);
    // rust: let entry = match slot {
    // rust: Ok(index) => {
    // rust: let snapshot_missing =
    // rust: cache.section_geometry.get(&section).is_none_or(|geometry| {
    // rust: geometry.vertices.is_empty()
    // rust: && !active_entries[index].1.vertices.is_empty()
    // rust: });
    // rust: let cached = &mut active_entries[index].1;
    // rust: let key_changed =
    // rust: cached.key != key || cached.atlas_revision != scene.atlas_revision;
    // rust: if key_changed {
    // rust: self.render_static_vertices(
    // rust: scene,
    // rust: pos,
    // rust: kind,
    // rust: packed,
    // rust: lights,
    // rust: &mut cached.vertices,
    // rust: );
    // rust: cached.key = key;
    // rust: cached.atlas_revision = scene.atlas_revision;
}
    // rust: cached.pot_sherds = static_pot_sherds(scene, pos, kind);
    // rust: if key_changed || snapshot_missing {
    // rust: cache.mark_section_dirty(section);
}
    // rust: cached.section_revision = current_section_revision;
    // rust: cached.used = scene.game_time;
    // rust: cached
}
    // rust: Err(_) if cache.len >= STATIC_GEOMETRY_MAX_ENTRIES => {
    // rust: if cache_only {
    // rust: break 'draw;
}
    // rust: let base = Mat4::from_translation(origin);
    // rust: self.render_one(
    // rust: scene, pos, kind, base, packed, lights, false, true, out,
    // rust: );
    // rust: break 'draw;
}
    // rust: Err(index) => {
    // rust: let mut vertices = Vec::new();
    // rust: self.render_static_vertices(
    // rust: scene,
    // rust: pos,
    // rust: kind,
    // rust: packed,
    // rust: lights,
    // rust: &mut vertices,
    // rust: );
    // rust: active_entries.insert(
    // rust: index,
    // rust: (
    // rust: local,
    // rust: StaticEntry {
    // rust: key,
    // rust: pot_sherds: static_pot_sherds(scene, pos, kind),
    // rust: section_revision: current_section_revision,
    // rust: atlas_revision: scene.atlas_revision,
    // rust: used: scene.game_time,
    // rust: vertices,
    // rust: },
    // rust: ),
    // rust: );
    // rust: cache.len += 1;
    // rust: cache.mark_section_dirty(section);
    // rust: &mut active_entries[index].1
}
}
    // rust: if cache_only {
    // rust: break 'draw;
}
    // rust: if gpu_static {
    // rust: result.visible_sections.push(section);
}
    // rust: if !gpu_static {
    // rust: result.stats.static_entities_drawn += 1;
    // rust: out.extend(entry.vertices.iter().map(|vertex| Vertex {
    // rust: pos: (Vec3::from_array(vertex.pos) + origin).to_array(),
    // rust: ..*vertex
    // rust: }));
}
    // rust: if matches!(kind, Kind::Banner { .. })
    // rust: && self.is_dynamic_visible(scene, &shapes, pos, state, kind, None)
    // rust: {
    // rust: self.render_banner(
    // rust: &shapes,
    // rust: scene,
    // rust: pos,
    // rust: kind,
    // rust: Mat4::from_translation(origin),
    // rust: packed,
    // rust: lights,
    // rust: false,
    // rust: true,
    // rust: out,
    // rust: );
}
    // rust: break 'draw;
}
    // rust: if let Some(cache) = &mut cache
    // rust: && let Ok(index) =
    // rust: active_entries.binary_search_by_key(&local, |(index, _)| *index)
    // rust: {
    // rust: active_entries.remove(index);
    // rust: cache.len -= 1;
    // rust: cache.mark_section_dirty(section);
}
    // rust: if cache_only {
    // rust: break 'draw;
}
    // rust: if !self.is_dynamic_visible(scene, &shapes, pos, state, kind, chest_openness) {
    // rust: break 'draw;
}
    // rust: let base = Mat4::from_translation(origin);
    // rust: self.render_one(scene, pos, kind, base, packed, lights, false, true, out);
}
    // rust: after(pos, state, start, out);
    // rust: if out.len() > start && !cache_only {
    // rust: result.stats.dynamic_entities_drawn += 1;
}
}
    // rust: if let (Some(cache), Some(section)) = (&mut cache, active_section) {
    // rust: if active_entries.is_empty() {
    // rust: cache.sections.remove(&section);
    // rust: if cache.section_geometry.remove(&section).is_some() {
    // rust: cache.published_dirty = true;
}
    // rust: } else {
    // rust: cache.sections.insert(section, active_entries);
}
}
    // rust: result
}
    // rust: fn render_static_vertices(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: pos: [i32; 3],
    // rust: kind: &Kind,
    // rust: packed: u8,
    // rust: lights: (Vec3, Vec3),
    // rust: vertices: &mut Vec<Vertex>,
    // rust: ) {
    // rust: vertices.clear();
    // rust: let shapes = self.shapes();
    // rust: if matches!(kind, Kind::Banner { .. }) {
    // rust: self.render_banner_pole(
    // rust: &shapes,
    // rust: scene,
    // rust: kind,
    // rust: Mat4::IDENTITY,
    // rust: packed,
    // rust: lights,
    // rust: vertices,
    // rust: );
    // rust: } else {
    // rust: self.render_one(
    // rust: scene,
    // rust: pos,
    // rust: kind,
    // rust: Mat4::IDENTITY,
    // rust: packed,
    // rust: lights,
    // rust: false,
    // rust: true,
    // rust: vertices,
    // rust: );
}
}
    /// The atlas coordinates and non-animated inputs that determine a static model.
    /// `packed` is raised to the brighter half for a closed double chest, just
    /// as `ChestRenderer` does before drawing either half.
    // rust: fn static_key(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: pos: [i32; 3],
    // rust: state: u32,
    // rust: kind: &Kind,
    // rust: options: CacheOptions,
    // rust: packed: &mut u8,
    // rust: chest_openness: Option<(f32, Option<[i32; 3]>)>,
    // rust: ) -> Option<StaticKey> {
    // rust: let mut sprite_rects = [None; 5];
    // rust: let mut sprite_count = 0;
    // rust: let mut pose = [0; 2];
    // rust: let mut has_fractional_alpha = false;
    // rust: let mut add_sprite = |texture: &str| {
    // rust: sprite_rects[usize::from(sprite_count)] = sprite_rect_key(scene, texture);
    // rust: has_fractional_alpha |= scene.translucent_sprites.contains(texture);
    // rust: sprite_count += 1;
}
    // rust: match kind {
    // rust: Kind::Chest {
    // rust: block,
    // rust: texture,
    // rust: part,
    // rust: ..
    // rust: } if options.chests => {
    // rust: let (open, other) = chest_openness.unwrap_or_else(|| {
    // rust: self.chest_openness(
    // rust: pos,
    // rust: kind,
    // rust: &|p| scene.world.block(p[0], p[1], p[2]).0,
    // rust: scene.lid,
    // rust: )
    // rust: });
    // rust: if open != 0.0 {
    // rust: return None;
}
    // rust: if let Some(other) = other {
    // rust: let light = scene.world.light(other[0], other[1], other[2]);
    // rust: *packed = (*packed >> 4).max(light >> 4) << 4 | (*packed & 15).max(light & 15);
}
    // rust: let texture = if matches!(block.as_str(), "chest" | "trapped_chest")
    // rust: && extended_christmas()
    // rust: {
    // rust: match part {
    // rust: ChestPart::Single => "entity/chest/christmas",
    // rust: ChestPart::Left => "entity/chest/christmas_left",
    // rust: ChestPart::Right => "entity/chest/christmas_right",
}
    // rust: } else {
    // rust: *texture
}
    // rust: add_sprite(texture);
}
    // rust: Kind::Shulker { texture, .. } if options.shulker_boxes => {
    // rust: let (progress, old) = (scene.anim)(pos).shulker;
    // rust: if progress != old {
    // rust: return None;
}
    // rust: pose[0] = progress.to_bits();
    // rust: add_sprite(texture);
}
    // rust: Kind::Bell if options.bells => {
    // rust: if (scene.anim)(pos).bell_shake.is_some() {
    // rust: return None;
}
    // rust: add_sprite("entity/bell/bell_body");
}
    // rust: Kind::Banner { .. } if options.banners => {
                // Only the stationary pole is cached; the flag below keeps its
                // normal frame-by-frame wave and pattern draws.
    // rust: add_sprite("entity/banner/banner_base");
}
    // rust: Kind::DecoratedPot { .. } if options.decorated_pots => {
    // rust: let anim = (scene.anim)(pos);
    // rust: if anim
    // rust: .wobble
    // rust: .is_some_and(|(_, progress)| (0.0..=1.0).contains(&progress))
    // rust: {
    // rust: return None;
}
    // rust: add_sprite("entity/decorated_pot/decorated_pot_base");
    // rust: for item in &anim.sherds {
    // rust: let texture = item
    // rust: .as_ref()
    // rust: .and_then(|item| self.pot_patterns.get(item))
    // rust: .map(String::as_str)
    // rust: .unwrap_or("entity/decorated_pot/decorated_pot_side");
    // rust: add_sprite(texture);
}
}
    // rust: Kind::CopperGolem { texture, .. } if options.copper_golem_statues => {
    // rust: add_sprite(texture);
}
    // rust: _ => return None,
}
        // Binary alpha is handled by fs_entity's discard. Fractional alpha
        // needs the ordinary blended entity pipeline, so leave that model
        // dynamic instead of paying for blending on every cached cutout.
    // rust: if has_fractional_alpha {
    // rust: return None;
}
    // rust: Some(StaticKey {
    // rust: state,
    // rust: light: *packed,
    // rust: nether: scene.nether,
    // rust: pose,
    // rust: sprite_rects,
    // rust: sprite_count,
    // rust: })
}
    /// A sign's text from the cache, laid out again when its data, light,
    /// state, outline or font changed.
    // rust: fn sign_text(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: pos: [i32; 3],
    // rust: state: u32,
    // rust: origin: Vec3,
    // rust: packed: u8,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some(data) = (scene.sign)(pos) else {
    // rust: return;
}
    // rust: let near = (data.front.glowing || data.back.glowing) && sign_text_near(pos, scene.camera);
    // rust: let Ok(mut cache) = self.sign_texts.lock() else {
    // rust: return;
}
    // rust: let now = scene.game_time;
    // rust: if (now - cache.swept).abs() >= SIGN_TEXT_KEEP {
    // rust: cache.swept = now;
    // rust: cache
    // rust: .signs
    // rust: .retain(|_, e| (now - SIGN_TEXT_KEEP..=now).contains(&e.used));
}
    // rust: let glyphs = scene.glyphs;
    // rust: let signs = &mut cache.signs;
    // rust: let entry = match signs.entry(pos) {
    // rust: std::collections::hash_map::Entry::Occupied(mut occupied) => {
    // rust: let entry = occupied.get_mut();
    // rust: if (entry.state, entry.packed, entry.near, entry.glyphs)
    // rust: != (state, packed, near, glyphs)
    // rust: || entry.data != *data
    // rust: {
    // rust: entry.vertices.clear();
    // rust: self.render_one(
    // rust: scene,
    // rust: pos,
    // rust: self.kind(state),
    // rust: Mat4::IDENTITY,
    // rust: packed,
    // rust: diffuse_lights(scene.nether),
    // rust: false,
    // rust: true,
    // rust: &mut entry.vertices,
    // rust: );
    // rust: entry.state = state;
    // rust: entry.data.clone_from(data);
    // rust: entry.packed = packed;
    // rust: entry.near = near;
    // rust: entry.glyphs = glyphs;
}
    // rust: occupied.into_mut()
}
    // rust: std::collections::hash_map::Entry::Vacant(vacant) => {
    // rust: let mut vertices = Vec::new();
    // rust: self.render_one(
    // rust: scene,
    // rust: pos,
    // rust: self.kind(state),
    // rust: Mat4::IDENTITY,
    // rust: packed,
    // rust: diffuse_lights(scene.nether),
    // rust: false,
    // rust: true,
    // rust: &mut vertices,
    // rust: );
    // rust: vacant.insert(SignTextEntry {
    // rust: state,
    // rust: data: data.clone(),
    // rust: packed,
    // rust: near,
    // rust: glyphs,
    // rust: used: now,
    // rust: vertices,
    // rust: })
}
}
    // rust: entry.used = now;
    // rust: out.extend(entry.vertices.iter().map(|v| Vertex {
    // rust: pos: (Vec3::from_array(v.pos) + origin).to_array(),
    // rust: ..*v
    // rust: }));
}
    /// One block entity at `pos` drawn under `base` with the given packed light
    /// (the parity fixture's entry point).
    // rust: pub fn render_block(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: pos: [i32; 3],
    // rust: state: u32,
    // rust: base: Mat4,
    // rust: packed: u8,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let kind = self.kind(state);
    // rust: let lights = diffuse_lights(scene.nether);
    // rust: self.render_one(scene, pos, kind, base, packed, lights, false, false, out);
}
    /// `TheEndGatewayBlockEntity.shouldRenderFace` for each face of the gateway
    /// at `pos`: the faces its portal is drawn on.
    // rust: pub fn gateway_faces(
    // rust: &self,
    // rust: world: &World,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: ) -> Vec<Direction> {
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .filter(|&d| {
    // rust: let [dx, dy, dz] = d.normal();
    // rust: let neighbor = world.block(pos[0] + dx, pos[1] + dy, pos[2] + dz);
    // rust: self.visibility.as_ref().is_none_or(|v| {
    // rust: v.lock()
    // rust: .map(|mut v| {
    // rust: v.should_render_face(state, neighbor, d, true)
    // rust: .unwrap_or(true)
    // rust: })
    // rust: .unwrap_or(true)
    // rust: })
    // rust: })
    // rust: .collect()
}
    /// Whether this block state has a block-entity renderer here.
pub fn renders(self: *Self, state: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !matches!(self.kind(state), Kind::None)
}
    /// `submitCrumblingOverlay` of ChestRenderer.submit, BannerRenderer.submit,
    /// SkullBlockRenderer.submitSkull, ShulkerBoxRenderer.submit,
    /// BellRenderer.submit, LecternRenderer.submit (the book),
    /// CopperGolemStatueBlockRenderer.submit, ConduitRenderer.submit (the shell
    /// or cage) and EnchantTableRenderer.submit (the book): the model drawn
    /// again under the destroy stage.
    // rust: pub fn render_breaking(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: pos: [i32; 3],
    // rust: state: u32,
    // rust: stage: [f32; 2],
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: if !matches!(
    // rust: self.kind(state),
    // rust: Kind::Banner { .. }
    // rust: | Kind::Chest { .. }
    // rust: | Kind::Skull { .. }
    // rust: | Kind::Shulker { .. }
    // rust: | Kind::Bell
    // rust: | Kind::Lectern { .. }
    // rust: | Kind::CopperGolem { .. }
    // rust: | Kind::Conduit
    // rust: | Kind::EnchantingTable
    // rust: ) {
    // rust: return;
}
    // rust: let origin = (DVec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]))
    // rust: - scene.camera)
    // rust: .as_vec3();
    // rust: let start = out.len();
    // rust: self.render_one(
    // rust: scene,
    // rust: pos,
    // rust: self.kind(state),
    // rust: Mat4::from_translation(origin),
    // rust: 0xff,
    // rust: diffuse_lights(scene.nether),
    // rust: true,
    // rust: false,
    // rust: out,
    // rust: );
    // rust: entity_geometry(&mut out[start..], origin, stage);
}
    /// `ChestRenderer.extractRenderState`'s openness for the chest of `state`
    /// at `pos`: `ChestBlock.combine` (`DoubleBlockCombiner.combineWithNeigbour`)
    /// pairs a double half with its neighbour only when that is the same
    /// block, the other half and faces the same way; `opennessCombiner` then
    /// takes the more open of both. Also returns the paired half's position.
    /// `lid` is `getOpenNess(partial)` at a position; non-chests give 0.
    // rust: pub fn chest_openness_of(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: state: u32,
    // rust: block_at: &dyn Fn([i32; 3]) -> u32,
    // rust: lid: &dyn Fn([i32; 3]) -> f32,
    // rust: ) -> (f32, Option<[i32; 3]>) {
    // rust: self.chest_openness(pos, self.kind(state), block_at, lid)
}
    // rust: fn chest_openness(
    // rust: &self,
    // rust: pos: [i32; 3],
    // rust: kind: &Kind,
    // rust: block_at: &dyn Fn([i32; 3]) -> u32,
    // rust: lid: &dyn Fn([i32; 3]) -> f32,
    // rust: ) -> (f32, Option<[i32; 3]>) {
    // rust: let Kind::Chest {
    // rust: block,
    // rust: part,
    // rust: y_rot,
    // rust: double_with,
    // rust: ..
    // rust: } = kind
    // rust: else {
    // rust: return (0.0, None);
}
    // rust: let open = lid(pos);
    // rust: let Some(d) = double_with else {
    // rust: return (open, None);
}
    // rust: let other = [pos[0] + d[0], pos[1] + d[1], pos[2] + d[2]];
    // rust: match self.kind(block_at(other)) {
    // rust: Kind::Chest {
    // rust: block: other_block,
    // rust: part: other_part,
    // rust: y_rot: other_y_rot,
    // rust: ..
    // rust: } if other_block == block
    // rust: && *other_part != ChestPart::Single
    // rust: && other_part != part
    // rust: && other_y_rot == y_rot =>
    // rust: {
    // rust: let other_open = lid(other);
                // The right half is the first.
    // rust: let open = if *part == ChestPart::Right {
    // rust: block_entity_anim::combined_openness(open, Some(other_open))
    // rust: } else {
    // rust: block_entity_anim::combined_openness(other_open, Some(open))
}
    // rust: (open, Some(other))
}
    // rust: _ => (open, None),
}
}
    /// One block entity of `state` drawn under `base` (minecart contents).
    // rust: pub fn render_state(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: state: u32,
    // rust: base: Mat4,
    // rust: packed: u8,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let kind = self.kind(state);
    // rust: if !matches!(kind, Kind::None) {
    // rust: let lights = diffuse_lights(scene.nether);
    // rust: self.render_one(
    // rust: scene,
    // rust: [i32::MAX; 3],
    // rust: kind,
    // rust: base,
    // rust: packed,
    // rust: lights,
    // rust: false,
    // rust: false,
    // rust: out,
    // rust: );
}
}
    // rust: fn render_one(
    // rust: &self,
    // rust: scene: &Scene,
    // rust: pos: [i32; 3],
    // rust: kind: &Kind,
    // rust: base: Mat4,
    // rust: packed: u8,
    // rust: lights: (Vec3, Vec3),
    // rust: crumbling: bool,
    // rust: world_chests: bool,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let shapes = self.shapes();
    // rust: let sprite = |name: &str| scene.sprites.get(name).copied();
    // rust: let paint = |name: &str, tint: u32, packed: u8| {
    // rust: let rect = if crumbling {
    // rust: Some(Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
    // rust: })
    // rust: } else {
    // rust: sprite(name)
}
    // rust: rect.map(|s| Paint {
    // rust: sprite: s,
    // rust: tint,
    // rust: light: vertex_light(packed),
    // rust: lights,
    // rust: glow: (!crumbling)
    // rust: .then(|| scene.emissive.overlay(name).and_then(sprite))
    // rust: .flatten(),
    // rust: })
}
    // rust: let none = |_: &str, _: &mut [f32; 9]| {};
    // rust: match kind {
    // rust: Kind::None => {}
    // rust: Kind::Sign {
    // rust: hanging,
    // rust: wall,
    // rust: angle,
    // rust: } => {
    // rust: let Some(data) = (scene.sign)(pos) else {
    // rust: return;
}
    // rust: let s = Vec3::new(1.0, -1.0, 1.0);
    // rust: for (front, text) in [(true, &data.front), (false, &data.back)] {
    // rust: if text.is_empty() {
    // rust: continue;
}
    // rust: let mut m = base;
    // rust: if *hanging {
                        // HangingSignRenderer.textTransformation.
    // rust: m *= Mat4::from_translation(Vec3::new(0.5, 0.9375, 0.5))
    // rust: * Mat4::from_rotation_y((-angle).to_radians())
    // rust: * Mat4::from_translation(Vec3::new(0.0, -0.3125, 0.0));
    // rust: if !front {
    // rust: m *= Mat4::from_rotation_y(PI);
}
    // rust: m *= Mat4::from_translation(Vec3::new(0.0, -0.32, 0.073))
    // rust: * Mat4::from_scale(s * 0.014_062_5);
    // rust: } else {
                        // StandingSignRenderer.textTransformation.
    // rust: m *= Mat4::from_translation(Vec3::splat(0.5))
    // rust: * Mat4::from_rotation_y((-angle).to_radians());
    // rust: if *wall {
    // rust: m *= Mat4::from_translation(Vec3::new(0.0, -0.3125, -0.4375));
}
    // rust: if !front {
    // rust: m *= Mat4::from_rotation_y(PI);
}
    // rust: m *= Mat4::from_translation(Vec3::new(0.0, 1.0 / 3.0, 0.046_666_667))
    // rust: * Mat4::from_scale(s * 0.010_416_667);
}
    // rust: let near = sign_text_near(pos, scene.camera);
    // rust: let calls = sign_text_calls(scene, data, text, m, packed, near);
    // rust: match scene.texts {
    // rust: Some(sink) => sink.borrow_mut().extend(calls),
    // rust: None => calls.iter().for_each(|c| draw_text(scene, c, out)),
}
}
}
    // rust: Kind::Chest {
    // rust: block,
    // rust: texture,
    // rust: part,
    // rust: y_rot,
    // rust: ..
    // rust: } => {
                // ChestRenderer.getChestMaterial: normal and trapped chests use the christmas
                // sprites on 24-26 December. Copper and ender chests keep theirs.
    // rust: let texture = if matches!(block.as_str(), "chest" | "trapped_chest")
    // rust: && extended_christmas()
    // rust: {
    // rust: match part {
    // rust: ChestPart::Single => "entity/chest/christmas",
    // rust: ChestPart::Left => "entity/chest/christmas_left",
    // rust: ChestPart::Right => "entity/chest/christmas_right",
}
    // rust: } else {
    // rust: *texture
}
                // Trapped and ender chests have models of their own when a `.jem` reshapes
                // them; copper chests have no CEM name and draw vanilla's chest.
    // rust: let shapes: &BlockEntityShapes =
    // rust: if matches!(block.as_str(), "chest" | "trapped_chest" | "ender_chest") {
    // rust: &shapes
    // rust: } else {
    // rust: &self.vanilla
}
    // rust: let (own, chest) = match (block.as_str(), part) {
    // rust: ("trapped_chest", ChestPart::Single) => ("trapped_chest", "chest"),
    // rust: ("trapped_chest", ChestPart::Left) => {
    // rust: ("trapped_chest_left", "double_chest_left")
}
    // rust: ("trapped_chest", ChestPart::Right) => {
    // rust: ("trapped_chest_right", "double_chest_right")
}
    // rust: ("ender_chest", _) => ("ender_chest", "chest"),
    // rust: (_, ChestPart::Single) => ("chest", "chest"),
    // rust: (_, ChestPart::Left) => ("double_chest_left", "double_chest_left"),
    // rust: (_, ChestPart::Right) => ("double_chest_right", "double_chest_right"),
}
    // rust: let key = if shapes.models.contains_key(own) {
    // rust: own
    // rust: } else {
    // rust: chest
}
    // rust: let texture = shapes.texture(key, texture, scene.sprites);
    // rust: let Some(model) = shapes.models.get(key) else {
    // rust: return;
}
    // rust: let (open, other) = self.chest_openness(
    // rust: pos,
    // rust: kind,
    // rust: &|p| scene.world.block(p[0], p[1], p[2]).0,
    // rust: scene.lid,
    // rust: );
                // BrightnessCombiner: the brighter of both halves, per channel.
    // rust: let mut packed = packed;
    // rust: if let Some(other) = other {
    // rust: let l = scene.world.light(other[0], other[1], other[2]);
    // rust: packed = (packed >> 4).max(l >> 4) << 4 | (packed & 15).max(l & 15);
}
    // rust: if world_chests && open == 0.0 {
    // rust: if let (Some(paint), Some(closed)) = (
    // rust: paint(texture, 0xFFFFFF, packed),
    // rust: shapes.closed_chests.get(key),
    // rust: ) {
    // rust: let vertices = &closed[usize::from(scene.nether)][*y_rot as usize / 90];
    // rust: let origin = base.w_axis.truncate();
    // rust: let passes = std::iter::once((paint.sprite, paint.light))
    // rust: .chain(paint.glow.map(|g| (g, FULL_BRIGHT)));
    // rust: for (r, light) in passes {
    // rust: out.extend(vertices.iter().map(|v| Vertex {
    // rust: pos: (Vec3::from_array(v.pos) + origin).to_array(),
    // rust: uv: [
    // rust: r.u0 + (r.u1 - r.u0) * v.uv[0],
    // rust: r.v0 + (r.v1 - r.v0) * v.uv[1],
    // rust: ],
    // rust: light,
    // rust: ..*v
    // rust: }));
}
}
    // rust: return;
}
    // rust: let m = base
    // rust: * around(
    // rust: Mat4::from_rotation_y((-y_rot).to_radians()),
    // rust: Vec3::new(0.5, 0.0, 0.5),
    // rust: );
    // rust: let lid = block_entity_anim::chest_lid_x_rot(open);
    // rust: let adjust = move |name: &str, p: &mut [f32; 9]| {
    // rust: if name == "lid" || name == "lock" {
    // rust: p[3] = lid;
}
}
    // rust: if let Some(paint) = paint(texture, 0xFFFFFF, packed) {
    // rust: draw_part(model, "root", m, &adjust, paint, out);
}
}
    // rust: Kind::Shulker { texture, facing } => {
    // rust: let (Some(model), Some(paint)) = (
    // rust: shapes.models.get("shulker_box"),
    // rust: paint(
    // rust: shapes.texture("shulker_box", texture, scene.sprites),
    // rust: 0xFFFFFF,
    // rust: packed,
    // rust: ),
    // rust: ) else {
    // rust: return;
}
    // rust: let m = base
    // rust: * Mat4::from_translation(Vec3::splat(0.5))
    // rust: * Mat4::from_scale(Vec3::splat(0.9995))
    // rust: * Mat4::from_quat(direction_rotation(facing))
    // rust: * Mat4::from_scale(Vec3::new(1.0, -1.0, -1.0))
    // rust: * Mat4::from_translation(Vec3::new(0.0, -1.0, 0.0));
                // ShulkerBoxModel.setupAnim(getProgress(partial)): the lid rises and turns.
    // rust: let (progress, old) = (scene.anim)(pos).shulker;
    // rust: let progress = old + scene.partial * (progress - old);
    // rust: let lid = move |name: &str, p: &mut [f32; 9]| {
    // rust: if name == "lid" {
    // rust: p[0] = 0.0;
    // rust: p[1] = 24.0 - progress * 0.5 * 16.0;
    // rust: p[2] = 0.0;
    // rust: p[4] = 270.0 * progress * (PI / 180.0);
}
}
    // rust: draw_part(model, "root", m, &lid, paint, out);
}
    // rust: Kind::Banner { .. } => {
    // rust: self.render_banner(
    // rust: &shapes, scene, pos, kind, base, packed, lights, crumbling, false, out,
    // rust: );
}
    // rust: Kind::Skull {
    // rust: kind,
    // rust: wall,
    // rust: segment,
    // rust: } => {
    // rust: let (model, texture) = match kind {
    // rust: SkullType::Skeleton => ("skeleton_skull", "entity/skeleton/skeleton"),
    // rust: SkullType::WitherSkeleton => {
    // rust: ("wither_skeleton_skull", "entity/skeleton/wither_skeleton")
}
    // rust: SkullType::Zombie => ("zombie_head", "entity/zombie/zombie"),
    // rust: SkullType::Creeper => ("creeper_head", "entity/creeper/creeper"),
    // rust: SkullType::Dragon => ("dragon_skull", "entity/enderdragon/dragon"),
    // rust: SkullType::Piglin => ("piglin_head", "entity/piglin/piglin"),
    // rust: SkullType::Player => ("player_head", "entity/player/slim/steve"),
}
                // SkullBlockRenderer.getRenderType: the profile's skin when it
                // resolves, `SKIN_BY_TYPE` (steve) otherwise.
    // rust: let skin = if *kind == SkullType::Player {
    // rust: (scene.skull)(pos)
    // rust: } else {
    // rust: None
}
    // rust: let has_profile = skin.is_some();
                // A `.jem` texture stands in for the default skin, not a profile's.
    // rust: let texture = skin
    // rust: .as_deref()
    // rust: .unwrap_or_else(|| shapes.texture(model, texture, scene.sprites));
    // rust: let (Some(model), Some(paint)) =
    // rust: (shapes.models.get(model), paint(texture, 0xFFFFFF, packed))
    // rust: else {
    // rust: return;
}
    // rust: let m = match wall {
    // rust: Some(facing) => {
    // rust: let s = step(facing);
    // rust: base * Mat4::from_translation(Vec3::new(
    // rust: 0.5 - s[0] as f32 * 0.25,
    // rust: 0.25,
    // rust: 0.5 - s[2] as f32 * 0.25,
    // rust: )) * Mat4::from_rotation_y((-y_rot(opposite(facing))).to_radians())
    // rust: * Mat4::from_scale(Vec3::new(-1.0, -1.0, 1.0))
}
    // rust: None => {
    // rust: base * Mat4::from_translation(Vec3::new(0.5, 0.0, 0.5))
    // rust: * Mat4::from_rotation_y((-(f32::from(*segment) * 22.5)).to_radians())
    // rust: * Mat4::from_scale(Vec3::new(-1.0, -1.0, 1.0))
}
}
                // SkullBlockEntity.getAnimation: the dragon jaw and piglin ears
                // (DragonHeadModel / PiglinHeadModel use double-precision Math).
    // rust: let (animating, count) = (scene.anim)(pos).skull;
    // rust: let t = count as f32 + if animating { scene.partial } else { 0.0 };
    // rust: let anim = move |name: &str, p: &mut [f32; 9]| match name {
    // rust: "jaw" => p[3] = (f64::from(t * PI * 0.2).sin() + 1.0) as f32 * 0.2,
    // rust: "left_ear" => {
    // rust: p[5] = -((f64::from(t * PI * 0.2 * 1.2).cos() + 2.5) as f32) * 0.2;
}
    // rust: "right_ear" => p[5] = (f64::from(t * PI * 0.2).cos() + 2.5) as f32 * 0.2,
    // rust: _ => {}
}
    // rust: let start = out.len();
    // rust: draw_part(model, "root", m, &anim, paint, out);
                // `SkullBlockRenderer.resolveSkullRenderType`: a head with a profile takes
                // the player skin's `entityTranslucent` render type.
    // rust: if has_profile {
    // rust: mark_oit(&mut out[start..]);
}
}
    // rust: Kind::Bell => {
    // rust: let (Some(model), Some(paint)) = (
    // rust: shapes.models.get("bell"),
    // rust: paint(
    // rust: shapes.texture("bell", "entity/bell/bell_body", scene.sprites),
    // rust: 0xFFFFFF,
    // rust: packed,
    // rust: ),
    // rust: ) else {
    // rust: return;
}
                // BellModel.setupAnim(State(ticks + partial, shakeDirection)).
    // rust: let a = (scene.anim)(pos);
    // rust: let ticks = a.bell_ticks as f32 + scene.partial;
    // rust: let (mut x_rot, mut z_rot) = (0.0, 0.0);
    // rust: if let Some(dir) = a.bell_shake {
    // rust: let base_rot = (ticks / PI).msin() / (4.0 + ticks / 3.0);
    // rust: match dir {
    // rust: "north" => x_rot = -base_rot,
    // rust: "south" => x_rot = base_rot,
    // rust: "east" => z_rot = -base_rot,
    // rust: "west" => z_rot = base_rot,
    // rust: _ => {}
}
}
    // rust: let shake = move |name: &str, p: &mut [f32; 9]| {
    // rust: if name == "bell_body" {
    // rust: p[3] = x_rot;
    // rust: p[5] = z_rot;
}
}
    // rust: draw_part(model, "root", base, &shake, paint, out);
}
    // rust: Kind::DecoratedPot { y_rot } => {
    // rust: let (Some(base_model), Some(sides)) = (
    // rust: shapes.models.get("decorated_pot_base"),
    // rust: shapes.models.get("decorated_pot_sides"),
    // rust: ) else {
    // rust: return;
}
    // rust: let a = (scene.anim)(pos);
    // rust: let mut m = base
    // rust: * around(
    // rust: Mat4::from_rotation_y((180.0 - y_rot).to_radians()),
    // rust: Vec3::splat(0.5),
    // rust: );
                // DecoratedPotRenderer.submit: the wobble tilts around the base centre.
    // rust: let pivot = Vec3::new(0.5, 0.0, 0.5);
    // rust: if let Some((positive, progress)) = a.wobble
    // rust: && (0.0..=1.0).contains(&progress)
    // rust: {
    // rust: if positive {
    // rust: let delta = progress * (PI * 2.0);
    // rust: let tilt_x = -1.5 * (delta.mcos() + 0.5) * (delta / 2.0).msin();
    // rust: m *= around(Mat4::from_rotation_x(tilt_x * 0.015_625), pivot);
    // rust: let tilt_z = delta.msin();
    // rust: m *= around(Mat4::from_rotation_z(tilt_z * 0.015_625), pivot);
    // rust: } else {
    // rust: let turn = (-progress * 3.0 * PI).msin() * 0.125;
    // rust: let decay = 1.0 - progress;
    // rust: m *= around(Mat4::from_rotation_y(turn * decay), pivot);
}
}
    // rust: let first = out.len();
    // rust: let pot_base = "entity/decorated_pot/decorated_pot_base";
    // rust: let pot_base = shapes.texture("decorated_pot_base", pot_base, scene.sprites);
    // rust: if let Some(paint) = paint(pot_base, 0xFFFFFF, packed) {
    // rust: draw_part(base_model, "root", m, &none, paint, out);
}
                // PotDecorations (back, left, right, front); items without a pattern use the blank
                // side (a `.jem`'s texture, if any).
    // rust: let blank = "entity/decorated_pot/decorated_pot_side";
    // rust: let blank = shapes.texture("decorated_pot_sides", blank, scene.sprites);
    // rust: for (side, item) in ["back", "left", "right", "front"].iter().zip(&a.sherds) {
    // rust: let texture = item
    // rust: .as_ref()
    // rust: .and_then(|i| self.pot_patterns.get(i))
    // rust: .map_or(blank, String::as_str);
    // rust: if let (Some(part), Some(paint)) =
    // rust: (sides.child(side), paint(texture, 0xFFFFFF, packed))
    // rust: {
    // rust: draw_part(part, side, m, &none, paint, out);
}
}
                // `DecoratedPotRenderer` submits every part with `entitySolid`, which culls
                // back faces: the flat `top` and `bottom` planes show one side each.
    // rust: for vertex in &mut out[first..] {
    // rust: vertex.normal = CULL_BACK;
}
}
    // rust: Kind::EndPortal => {
                // TheEndPortalRenderer.TRANSFORMATION: y from 6/16 to 12/16; only the
                // vertical faces (TheEndPortalBlockEntity.shouldRenderFace).
    // rust: let m = base
    // rust: * Mat4::from_translation(Vec3::new(0.0, 0.375, 0.0))
    // rust: * Mat4::from_scale(Vec3::new(1.0, 0.375, 1.0));
    // rust: portal_cube(m, &[Direction::Down, Direction::Up], END_PORTAL_LAYER, out);
}
    // rust: Kind::EndGateway { state } => {
    // rust: let anim = (scene.anim)(pos);
    // rust: let b = gateway_beam(anim.gateway, scene.partial, scene.max_y, scene.game_time);
    // rust: if b.height > 0
    // rust: && let Some(s) = sprite("entity/end_portal/end_gateway_beam")
    // rust: {
    // rust: beam(
    // rust: base,
    // rust: BeamShape {
    // rust: scale: b.scale,
    // rust: time: b.animation_time,
    // rust: start: -b.height,
    // rust: height: b.height * 2,
    // rust: color: b.color,
    // rust: solid_radius: 0.15,
    // rust: glow_radius: 0.175,
    // rust: },
    // rust: s,
    // rust: out,
    // rust: );
}
                // AbstractEndPortalRenderer.extractRenderState.
    // rust: let faces = self.gateway_faces(scene.world, BlockStateId(*state), pos);
    // rust: portal_cube(base, &faces, END_GATEWAY_LAYER, out);
}
    // rust: Kind::Conduit => {
                // HDR output: the conduit shines, not its crumbling overlay.
    // rust: let start = out.len();
    // rust: let shine = |out: &mut Vec<Vertex>| {
    // rust: if !crumbling {
    // rust: for v in &mut out[start..] {
    // rust: v.layer |= u32::from(crate::mesher::BRIGHT) << 16;
}
}
}
    // rust: let (ticks, active, hunting, raw_rotation) = (scene.anim)(pos).conduit;
                // ConduitRenderer.extractRenderState.
    // rust: let rotation = (raw_rotation + if active { scene.partial } else { 0.0 }) * -0.0375;
    // rust: let tex = |key: &str, name: &str| {
    // rust: paint(shapes.texture(key, name, scene.sprites), 0xFFFFFF, packed)
}
    // rust: if !active {
    // rust: let (Some(model), Some(paint)) = (
    // rust: shapes.models.get("conduit_shell"),
    // rust: tex("conduit_shell", "entity/conduit/base"),
    // rust: ) else {
    // rust: return;
}
    // rust: let m = base
    // rust: * Mat4::from_translation(Vec3::splat(0.5))
    // rust: * Mat4::from_rotation_y(rotation.to_radians());
    // rust: draw_part(model, "root", m, &none, paint, out);
    // rust: shine(out);
    // rust: return;
}
    // rust: let anim_time = ticks as f32 + scene.partial;
    // rust: let phase = ticks / 66 % 3;
    // rust: let degrees = rotation * (180.0 / PI);
    // rust: let hh = (anim_time * 0.1).msin() / 2.0 + 0.5;
    // rust: let hh = hh * hh + hh;
    // rust: let lift = Vec3::new(0.5, 0.3 + hh * 0.2, 0.5);
    // rust: if let (Some(model), Some(paint)) = (
    // rust: shapes.models.get("conduit_cage"),
    // rust: tex("conduit_cage", "entity/conduit/cage"),
    // rust: ) {
    // rust: let axis = Vec3::new(0.5, 1.0, 0.5).normalize();
    // rust: let m = base
    // rust: * Mat4::from_translation(lift)
    // rust: * Mat4::from_quat(Quat::from_axis_angle(axis, degrees * (PI / 180.0)));
    // rust: draw_part(model, "root", m, &none, paint, out);
}
                // The crumbling overlay covers the shell and the cage only.
    // rust: if crumbling {
    // rust: return;
}
    // rust: let wind = if phase == 1 {
    // rust: "entity/conduit/wind_vertical"
    // rust: } else {
    // rust: "entity/conduit/wind"
}
    // rust: if let (Some(model), Some(paint)) =
    // rust: (shapes.models.get("conduit_wind"), tex("conduit_wind", wind))
    // rust: {
    // rust: let turn = match phase {
    // rust: 1 => Mat4::from_rotation_x(PI / 2.0),
    // rust: 2 => Mat4::from_rotation_z(PI / 2.0),
    // rust: _ => Mat4::IDENTITY,
}
    // rust: let center = base * Mat4::from_translation(Vec3::splat(0.5));
    // rust: draw_part(model, "root", center * turn, &none, paint, out);
    // rust: let inner = center
    // rust: * Mat4::from_scale(Vec3::splat(0.875))
    // rust: * Mat4::from_quat(Quat::from_euler(glam::EulerRot::XYZ, PI, 0.0, PI));
    // rust: draw_part(model, "root", inner, &none, paint, out);
}
    // rust: let eye = if hunting {
    // rust: "entity/conduit/open_eye"
    // rust: } else {
    // rust: "entity/conduit/closed_eye"
}
    // rust: if let (Some(model), Some(paint)) =
    // rust: (shapes.models.get("conduit_eye"), tex("conduit_eye", eye))
    // rust: {
    // rust: let m = base
    // rust: * Mat4::from_translation(lift)
    // rust: * Mat4::from_scale(Vec3::splat(0.5))
    // rust: * Mat4::from_quat(scene.orientation)
    // rust: * Mat4::from_quat(Quat::from_rotation_z(PI) * Quat::from_rotation_y(PI))
    // rust: * Mat4::from_scale(Vec3::splat(1.333_333_4));
    // rust: draw_part(model, "root", m, &none, paint, out);
}
    // rust: shine(out);
}
    // rust: Kind::EnchantingTable => {
    // rust: let book = "entity/enchantment/enchanting_table_book";
    // rust: let (Some(model), Some(paint)) = (
    // rust: shapes.models.get("book"),
    // rust: paint(
    // rust: shapes.texture("book", book, scene.sprites),
    // rust: 0xFFFFFF,
    // rust: packed,
    // rust: ),
    // rust: ) else {
    // rust: return;
}
                // EnchantTableRenderer.extractRenderState and submit.
    // rust: let b = (scene.anim)(pos).book.render(scene.partial);
    // rust: let m = base
    // rust: * Mat4::from_translation(Vec3::new(0.5, 0.75, 0.5))
    // rust: * Mat4::from_translation(Vec3::new(
    // rust: 0.0,
    // rust: 0.1 + (b.time * 0.1).msin() * 0.01,
    // rust: 0.0,
    // rust: ))
    // rust: * Mat4::from_rotation_y(-b.y_rot)
    // rust: * Mat4::from_rotation_z(80f32.to_radians());
    // rust: let (openness, ff1, ff2) = (b.openness, b.page_flip1, b.page_flip2);
    // rust: draw_part(model, "root", m, &book_pose(openness, ff1, ff2), paint, out);
}
    // rust: Kind::Lectern { y_rot } => {
                // Its own `.jem`'s book, else the enchanting table's.
    // rust: let key = if shapes.models.contains_key("lectern_book") {
    // rust: "lectern_book"
    // rust: } else {
    // rust: "book"
}
    // rust: let book = "entity/enchantment/enchanting_table_book";
    // rust: let (Some(model), Some(paint)) = (
    // rust: shapes.models.get(key),
    // rust: paint(shapes.texture(key, book, scene.sprites), 0xFFFFFF, packed),
    // rust: ) else {
    // rust: return;
}
    // rust: let m = base
    // rust: * Mat4::from_translation(Vec3::new(0.5, 1.0625, 0.5))
    // rust: * Mat4::from_rotation_y((-y_rot).to_radians())
    // rust: * Mat4::from_rotation_z(67.5f32.to_radians())
    // rust: * Mat4::from_translation(Vec3::new(0.0, -0.125, 0.0));
                // LecternRenderer.BOOK_STATE = forAnimation(0, 0.1, 0.9, 1.2).
    // rust: draw_part(
    // rust: model,
    // rust: "root",
    // rust: m,
    // rust: &book_pose(1.25 * 1.2, 0.1, 0.9),
    // rust: paint,
    // rust: out,
    // rust: );
}
    // rust: Kind::CopperGolem {
    // rust: texture,
    // rust: pose,
    // rust: facing,
    // rust: } => {
    // rust: let key = match *pose {
    // rust: "running" => "copper_golem_running",
    // rust: "sitting" => "copper_golem_sitting",
    // rust: "star" => "copper_golem_star",
    // rust: _ => "copper_golem",
}
    // rust: let (Some(model), Some(paint)) =
    // rust: (shapes.models.get(key), paint(texture, 0xFFFFFF, packed))
    // rust: else {
    // rust: return;
}
    // rust: let m = base
    // rust: * Mat4::from_translation(Vec3::new(0.5, 0.0, 0.5))
    // rust: * Mat4::from_rotation_y((-y_rot(opposite(facing))).to_radians());
                // CopperGolemStatueModel.setupAnim: root.y = 0, root.zRot = PI.
    // rust: let statue = |name: &str, p: &mut [f32; 9]| {
    // rust: if name == "root" {
    // rust: p[1] = 0.0;
    // rust: p[5] = PI;
}
}
    // rust: draw_part(model, "root", m, &statue, paint, out);
}
}
}
    // rust: fn banner_parts<'a>(
    // rust: shapes: &'a BlockEntityShapes,
    // rust: kind: &Kind,
    // rust: base: Mat4,
    // rust: ) -> Option<(
    // rust: &'a ModelPart,
    // rust: &'a ModelPart,
    // rust: Mat4,
    // rust: &'static str,
    // rust: &'static str,
    // rust: )> {
    // rust: let Kind::Banner { wall, angle, .. } = kind else {
    // rust: return None;
}
    // rust: let (main_key, flag_key) = if *wall {
    // rust: ("wall_banner", "wall_banner_flag")
    // rust: } else {
    // rust: ("standing_banner", "standing_banner_flag")
}
    // rust: let (main, flag) = (shapes.models.get(main_key)?, shapes.models.get(flag_key)?);
    // rust: let transform = base
    // rust: * Mat4::from_translation(Vec3::new(0.5, 0.0, 0.5))
    // rust: * Mat4::from_rotation_y((-angle).to_radians())
    // rust: * Mat4::from_scale(Vec3::new(2.0 / 3.0, -2.0 / 3.0, -2.0 / 3.0));
    // rust: Some((main, flag, transform, main_key, flag_key))
}
    // rust: fn render_banner_pole(
    // rust: &self,
    // rust: shapes: &BlockEntityShapes,
    // rust: scene: &Scene,
    // rust: kind: &Kind,
    // rust: base: Mat4,
    // rust: packed: u8,
    // rust: lights: (Vec3, Vec3),
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some((main, _, transform, main_key, _)) = Self::banner_parts(shapes, kind, base) else {
    // rust: return;
}
    // rust: let texture = shapes.texture(main_key, "entity/banner/banner_base", scene.sprites);
    // rust: let Some(sprite) = scene.sprites.get(texture).copied() else {
    // rust: return;
}
    // rust: let paint = Paint {
    // rust: sprite,
    // rust: tint: 0xFFFFFF,
    // rust: light: vertex_light(packed),
    // rust: lights,
    // rust: glow: scene
    // rust: .emissive
    // rust: .overlay(texture)
    // rust: .and_then(|name| scene.sprites.get(name).copied()),
}
    // rust: let none = |_: &str, _: &mut [f32; 9]| {};
    // rust: draw_part(main, "root", transform, &none, paint, out);
}
    // rust: fn render_banner(
    // rust: &self,
    // rust: shapes: &BlockEntityShapes,
    // rust: scene: &Scene,
    // rust: pos: [i32; 3],
    // rust: kind: &Kind,
    // rust: base: Mat4,
    // rust: packed: u8,
    // rust: lights: (Vec3, Vec3),
    // rust: crumbling: bool,
    // rust: skip_pole: bool,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Kind::Banner { color, .. } = kind else {
    // rust: return;
}
    // rust: let Some((main, flag, transform, main_key, flag_key)) =
    // rust: Self::banner_parts(shapes, kind, base)
    // rust: else {
    // rust: return;
}
    // rust: let phase = ((i64::from(pos[0]) * 7
    // rust: + i64::from(pos[1]) * 9
    // rust: + i64::from(pos[2]) * 13
    // rust: + scene.game_time)
    // rust: .rem_euclid(100) as f32
    // rust: + scene.partial)
    // rust: / 100.0;
    // rust: let wave = move |name: &str, p: &mut [f32; 9]| {
    // rust: if name == "flag" {
    // rust: p[3] = (-0.0125 + 0.01 * (2.0 * PI * phase).mcos()) * PI;
}
}
    // rust: let paint = |texture: &str, tint: u32| {
    // rust: let sprite = if crumbling {
    // rust: Some(Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 16,
    // rust: h: 16,
    // rust: })
    // rust: } else {
    // rust: scene.sprites.get(texture).copied()
}
    // rust: sprite.map(|sprite| Paint {
    // rust: sprite,
    // rust: tint,
    // rust: light: vertex_light(packed),
    // rust: lights,
    // rust: glow: (!crumbling)
    // rust: .then(|| {
    // rust: scene
    // rust: .emissive
    // rust: .overlay(texture)
    // rust: .and_then(|name| scene.sprites.get(name).copied())
    // rust: })
    // rust: .flatten(),
    // rust: })
}
    // rust: let banner_base = "entity/banner/banner_base";
    // rust: let main_texture = shapes.texture(main_key, banner_base, scene.sprites);
    // rust: let flag_texture = shapes.texture(flag_key, banner_base, scene.sprites);
    // rust: if !skip_pole && let Some(paint) = paint(main_texture, 0xFFFFFF) {
    // rust: let none = |_: &str, _: &mut [f32; 9]| {};
    // rust: draw_part(main, "root", transform, &none, paint, out);
}
    // rust: if let Some(paint) = paint(flag_texture, 0xFFFFFF) {
    // rust: draw_part(flag, "root", transform, &wave, paint, out);
}
    // rust: if crumbling {
    // rust: return;
}
    // rust: if let Some(paint) = paint("entity/banner/base", *color) {
    // rust: draw_part(flag, "root", transform, &wave, paint, out);
}
    // rust: for (texture, tint) in (scene.banner)(pos).iter().take(16) {
    // rust: if let Some(paint) = paint(texture, *tint) {
    // rust: draw_part(flag, "root", transform, &wave, paint, out);
}
}
}
}

/// `BeaconRenderer.submit`: for each beam section (ARGB colour, height) the
/// rotating solid beam and its translucent glow, the last section 2048
/// blocks tall. `origin` is the beacon block's corner relative to the camera,
/// `time` the animation time (game time mod 40 plus partial tick) and `scale`
/// the radius scale.
    // rust: pub fn beacon_beam(
    // rust: origin: Vec3,
    // rust: sections: &[(u32, i32)],
    // rust: time: f32,
    // rust: scale: f32,
    // rust: s: Rect,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let base = Mat4::from_translation(origin);
    // rust: let mut start = 0i32;
    // rust: for (i, &(color, height)) in sections.iter().enumerate() {
    // rust: let height = if i == sections.len() - 1 {
    // rust: 2048
    // rust: } else {
    // rust: height
}
    // rust: let shape = BeamShape {
    // rust: scale: 1.0,
    // rust: time,
    // rust: start,
    // rust: height,
    // rust: color,
    // rust: solid_radius: 0.2 * scale,
    // rust: glow_radius: 0.25 * scale,
}
    // rust: beam(base, shape, s, out);
    // rust: start += height;
}
}
/// The arguments of `BeaconRenderer.submitBeaconBeam`.
pub const BeamShape = struct {
    /// Scales the v range (End gateways shrink and grow their beam with it).
    scale: f32,
    /// Animation time: game time mod 40 plus the partial tick.
    time: f32,
    start: i32,
    height: i32,
    /// RGB.
    color: u32,
    solid_radius: f32,
    glow_radius: f32,
};
/// `BeaconRenderer.submitBeaconBeam` under `base` (the block's corner): the
/// rotating solid beam and its translucent glow. The sprite's v range rides
/// in the light bytes (the entity shader wraps v for layer 6).
pub fn beam(base: Mat4, b: BeamShape, s: Rect, out: *mut std.ArrayList(Vertex)) void {
}
    // rust: let q = |v: f32| (v * 65535.0).round().clamp(0.0, 65535.0) as u32;
    // rust: let wrap = q(s.v0) | q(s.v1 - s.v0) << 16;
    // rust: let color = b.color;
    // rust: let end = b.start + b.height;
    // rust: let scroll = if b.height < 0 { b.time } else { -b.time };
    // rust: let v_off = frac(scroll * 0.2 - (scroll * 0.1).floor());
    // rust: let abgr =
    // rust: |a: u32| a << 24 | (color & 255) << 16 | (color >> 8 & 255) << 8 | (color >> 16 & 255);
    // Solid beam, rotated with time.
    // rust: let r = b.solid_radius;
    // rust: let rot = glam::Mat3::from_rotation_y((b.time * 2.25 - 45.0).to_radians());
    // rust: let corners = [
    // rust: rot * Vec3::new(0.0, 0.0, r),
    // rust: rot * Vec3::new(r, 0.0, 0.0),
    // rust: rot * Vec3::new(-r, 0.0, 0.0),
    // rust: rot * Vec3::new(0.0, 0.0, -r),
    // rust: ];
    // rust: let v2 = -1.0 + v_off;
    // rust: let v1 = b.height as f32 * b.scale * (0.5 / r) + v2;
    // rust: let part = BeamPart {
    // rust: base,
    // rust: start: b.start,
    // rust: end,
    // rust: s,
    // rust: wrap,
}
    // rust: part.emit(out, corners, [v1, v2], abgr(255));
    // Glow, translucent.
    // rust: let g = b.glow_radius;
    // rust: let corners = [
    // rust: Vec3::new(-g, 0.0, -g),
    // rust: Vec3::new(g, 0.0, -g),
    // rust: Vec3::new(-g, 0.0, g),
    // rust: Vec3::new(g, 0.0, g),
    // rust: ];
    // rust: let v1 = b.height as f32 * b.scale + v2;
    // rust: part.emit(out, corners, [v1, v2], abgr(32));
}
pub const BeamPart = struct {
    base: Mat4,
    start: i32,
    end: i32,
    s: Rect,
    wrap: u32,
};
    // rust: impl BeamPart {
    /// `BeaconRenderer.renderPart`: four quads between the corners (wn, en, ws, es).
    // rust: fn emit(
    // rust: &self,
    // rust: out: &mut Vec<Vertex>,
    // rust: [wn, en, ws, es]: [Vec3; 4],
    // rust: [v1, v2]: [f32; 2],
    // rust: color: u32,
    // rust: ) {
    // rust: let s = self.s;
    // rust: for (a, b) in [(wn, en), (es, ws), (en, es), (ws, wn)] {
    // rust: let at = |c: Vec3, y: i32| {
    // rust: self.base
    // rust: .transform_point3(Vec3::new(0.5, 0.0, 0.5) + c + Vec3::new(0.0, y as f32, 0.0))
}
    // rust: for (p, uv) in [
    // rust: (at(a, self.end), [s.u1, v1]),
    // rust: (at(a, self.start), [s.u1, v2]),
    // rust: (at(b, self.start), [s.u0, v2]),
    // rust: (at(b, self.end), [s.u0, v1]),
    // rust: ] {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: p.to_array(),
    // rust: uv,
    // rust: layer: 6,
    // rust: color,
    // rust: light: self.wrap,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}

/// `EndGatewayRenderState`'s beam fields (zero when there is no beam).
pub const GatewayBeam = struct {
    height: i32,
    scale: f32,
    color: u32,
    animation_time: f32,
};

/// `TheEndGatewayRenderer.extractRenderState` from the block entity's age and
/// teleport cooldown, at `partial`, for a level whose top is `max_y`.
    // rust: pub fn gateway_beam(
    // rust: (age, cooldown): (i64, i32),
    // rust: partial: f32,
    // rust: max_y: i32,
    // rust: game_time: i64,
    // rust: ) -> GatewayBeam {
    // rust: let spawning = age < 200;
    // rust: if !spawning && cooldown <= 0 {
    // rust: return GatewayBeam::default();
}
    // rust: let percent = if spawning {
    // rust: ((age as f32 + partial) / 200.0).clamp(0.0, 1.0)
    // rust: } else {
    // rust: 1.0 - ((cooldown as f32 - partial) / 40.0).clamp(0.0, 1.0)
}
    // rust: let distance = if spawning { f64::from(max_y) } else { 50.0 };
    // rust: let scale = trig::sin(f64::from(percent * PI));
    // rust: GatewayBeam {
    // rust: height: (f64::from(scale) * distance).floor() as i32,
    // rust: scale,
        // DyeColor.MAGENTA / PURPLE getTextureDiffuseColor.
    // rust: color: if spawning { 0xFFC7_4EBD } else { 0xFF89_32B8 },
    // rust: animation_time: game_time.rem_euclid(40) as f32 + partial,
}
}

/// Entity-shader layers for `rendertype_end_portal`: end portals draw 15
/// layers of `end_portal.png` over `end_sky.png`, End gateways 16.
pub const END_PORTAL_LAYER: u32 = 9;
pub const END_GATEWAY_LAYER: u32 = 10;
/// `AbstractEndPortalRenderer.FACES`: the unit cube's corners for each face
/// (`Direction` order) in `FaceInfo` vertex order.
    // rust: const PORTAL_FACES: [[[f32; 3]; 4]; 6] = [
    // rust: [[0.0, 0.0, 1.0], [0.0, 0.0, 0.0], [1.0, 0.0, 0.0], [1.0, 0.0, 1.0]],
    // rust: [[0.0, 1.0, 0.0], [0.0, 1.0, 1.0], [1.0, 1.0, 1.0], [1.0, 1.0, 0.0]],
    // rust: [[1.0, 1.0, 0.0], [1.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 1.0, 0.0]],
    // rust: [[0.0, 1.0, 1.0], [0.0, 0.0, 1.0], [1.0, 0.0, 1.0], [1.0, 1.0, 1.0]],
    // rust: [[0.0, 1.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 1.0], [0.0, 1.0, 1.0]],
    // rust: [[1.0, 1.0, 1.0], [1.0, 0.0, 1.0], [1.0, 0.0, 0.0], [1.0, 1.0, 0.0]],
    // rust: ];
/// `AbstractEndPortalRenderer.submitCube`: position-only quads (the portal
/// shader projects its textures from the screen; uv, colour and light are unused).
/// `rendertype_end_portal` culls back faces, as `entitySolid` does, so the cube's
/// two Y faces are one-sided: only the one facing the camera draws.
pub fn portal_cube(m: Mat4, faces: *[Direction], layer: u32, out: *mut std.ArrayList(Vertex)) void {
}
    // rust: for &d in faces {
    // rust: for c in PORTAL_FACES[d as usize] {
    // rust: out.push(Vertex {
    // rust: normal: CULL_BACK,
    // rust: pos: m.transform_point3(Vec3::from(c)).to_array(),
    // rust: uv: [0.0; 2],
    // rust: layer,
    // rust: color: 0,
    // rust: light: 0,
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::assets::Assets;
//     use horizon_world::nbt::Tag;
pub fn entity_block_particles_and_breaking_use_exported_models() R {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::{models::catalog::StateModels, sprites::Sprites};
//         use horizon_world::{DATA_VERSION, chunk::BlockState, nbt::Tag};
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES"),
    // rust: );
    // rust: let names = [
    // rust: "white_banner",
    // rust: "white_wall_banner",
    // rust: "chest",
    // rust: "trapped_chest",
    // rust: "ender_chest",
    // rust: "copper_chest",
    // rust: ];
    // rust: let mut facts: std::collections::BTreeMap<String, Value> =
    // rust: serde_json::from_slice(&std::fs::read(root.join("model-states.json"))?)?;
    // rust: let states = names.map(|name| {
    // rust: let name = format!("minecraft:{name}");
    // rust: let mut first = facts[&name]["states"][0].clone();
    // rust: if first.get("type").is_some() {
    // rust: first["type"] = serde_json::json!("single");
}
    // rust: facts.get_mut(&name).unwrap()["states"] = serde_json::json!([first.clone()]);
    // rust: BlockState {
    // rust: name,
    // rust: properties: serde_json::from_value(first).unwrap(),
}
    // rust: .to_nbt()
    // rust: });
    // rust: let registry = BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: ("states", Tag::List(states.into())),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound(names.iter().enumerate().map(|(id, name)| {
    // rust: (
    // rust: horizon_world::nbt::JavaString::from(format!("minecraft:{name}").as_str()),
    // rust: Tag::Int(id as i32),
    // rust: )
    // rust: })),
    // rust: ),
    // rust: ]))?;
    // rust: let mut sprites = Sprites::default();
    // rust: let catalog = StateModels::from_facts(&root, &registry, &names, &mut sprites, &facts)?;
    // rust: for (id, name) in names.iter().enumerate() {
    // rust: let models = catalog.collect(
    // rust: BlockStateId(id as u32),
    // rust: horizon_core::position::BlockPos::default(),
    // rust: )?;
    // rust: assert!(models.iter().all(|(_, model)| model.faces.is_empty()));
    // rust: let particle = match *name {
    // rust: "ender_chest" => "minecraft:block/obsidian",
    // rust: "copper_chest" => "minecraft:block/copper_block",
    // rust: _ => "minecraft:block/oak_planks",
}
    // rust: assert_eq!(models[0].1.particle, Some(sprites.layers[particle]));
}
    // rust: let all: Value = serde_json::from_slice(&std::fs::read(root.join("entity-models.json"))?)?;
    // rust: let renderer = BlockEntityRenderer::new(
    // rust: MODELS
    // rust: .iter()
    // rust: .filter_map(|(key, layer)| all.get(*layer).map(|v| (*key, ModelPart::parse(v))))
    // rust: .collect(),
    // rust: &registry,
    // rust: );
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let base_sprites = [
    // rust: "entity/banner/banner_base",
    // rust: "entity/chest/normal",
    // rust: "entity/chest/trapped",
    // rust: "entity/chest/ender",
    // rust: "entity/chest/copper",
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|name| {
    // rust: (
    // rust: name.to_owned(),
    // rust: Rect {
    // rust: u0: 0.25,
    // rust: v0: 0.125,
    // rust: u1: 0.375,
    // rust: v1: 0.25,
    // rust: w: 16,
    // rust: h: 16,
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let cache_open = std::cell::Cell::new(0.0);
    // rust: let cache_lid = |_| cache_open.get();
    // rust: let mut scene = Scene {
    // rust: camera: DVec3::ZERO,
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &|_| BlockAnim::default(),
    // rust: texts: None,
    // rust: partial: 0.5,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &base_sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
        // Compare the cached world path with the original model renderer,
        // including atlas replacement, current light and animated fallback.
    // rust: scene.lid = &cache_lid;
    // rust: for nether in [false, true] {
    // rust: scene.nether = nether;
    // rust: for part in [ChestPart::Single, ChestPart::Left, ChestPart::Right] {
    // rust: for y_rot in [0.0, 90.0, 180.0, 270.0] {
    // rust: let kind = Kind::Chest {
    // rust: block: "chest".into(),
    // rust: texture: "entity/chest/normal",
    // rust: part,
    // rust: y_rot,
    // rust: double_with: None,
}
    // rust: for (open, packed) in [(0.0, 0xF0), (0.0, 0x7F), (0.5, 0x7F)] {
    // rust: cache_open.set(open);
    // rust: let base = Mat4::from_translation(Vec3::new(3.25, -8.5, 12.75));
    // rust: let mut cached = Vec::new();
    // rust: let mut original = Vec::new();
    // rust: for (use_cache, out) in [(true, &mut cached), (false, &mut original)] {
    // rust: renderer.render_one(
    // rust: &scene,
    // rust: [0; 3],
    // rust: &kind,
    // rust: base,
    // rust: packed,
    // rust: diffuse_lights(nether),
    // rust: false,
    // rust: use_cache,
    // rust: out,
    // rust: );
}
    // rust: assert!(!cached.is_empty());
    // rust: assert_eq!(cached.len(), original.len());
    // rust: for (a, b) in cached.iter().zip(&original) {
    // rust: assert!(
    // rust: (Vec3::from_array(a.pos) - Vec3::from_array(b.pos)).length() < 3e-6
    // rust: );
    // rust: assert_eq!(a.uv, b.uv);
    // rust: assert_eq!(a.color, b.color);
    // rust: assert_eq!(a.light, b.light);
    // rust: assert_eq!(a.normal, b.normal);
    // rust: assert_eq!(a.layer, b.layer);
}
}
}
}
}
    // rust: scene.nether = false;
    // rust: scene.lid = &|_| 0.0;
    // rust: for state in 0..names.len() as u32 {
    // rust: let mut base = Vec::new();
    // rust: renderer.render_block(&scene, [0; 3], state, Mat4::IDENTITY, 0xff, &mut base);
    // rust: let mut cracks = Vec::new();
    // rust: renderer.render_breaking(&scene, [0; 3], state, [0.0; 2], &mut cracks);
    // rust: assert!(!cracks.is_empty());
    // rust: assert_eq!(
    // rust: base.iter().map(|v| v.pos).collect::<Vec<_>>(),
    // rust: cracks.iter().map(|v| v.pos).collect::<Vec<_>>()
    // rust: );
    // rust: assert!(cracks.iter().all(|v| v.layer == 11
    // rust: && v.color == u32::MAX
    // rust: && v.uv.iter().all(|u| u.is_finite())));
    // rust: scene.game_time = 20;
    // rust: if state >= 2 {
    // rust: scene.lid = &|_| 1.0;
}
    // rust: let mut animated = Vec::new();
    // rust: renderer.render_breaking(&scene, [0; 3], state, [0.0; 2], &mut animated);
    // rust: assert!(cracks.iter().zip(&animated).any(|(a, b)| a.pos != b.pos));
    // rust: scene.game_time = 0;
    // rust: scene.lid = &|_| 0.0;
}
    // rust: Ok(())
}

pub fn classifies_vanilla_block_names() void {
}
    // rust: let props = |pairs: &'static [(&'static str, &'static str)]| {
    // rust: move |k: &str| {
    // rust: pairs
    // rust: .iter()
    // rust: .find(|(a, _)| *a == k)
    // rust: .map(|(_, v)| (*v).to_owned())
}
}
    // rust: let k = classify(
    // rust: "minecraft:light_gray_shulker_box",
    // rust: &props(&[("facing", "up")]),
    // rust: );
    // rust: assert!(
    // rust: matches!(k, Kind::Shulker { ref texture, .. } if texture == "entity/shulker/shulker_light_gray")
    // rust: );
    // rust: let k = classify("minecraft:gray_wall_banner", &props(&[("facing", "west")]));
    // rust: assert!(matches!(k, Kind::Banner { color: 0x474F52, wall: true, angle } if angle == 90.0));
    // rust: let k = classify(
    // rust: "minecraft:wither_skeleton_wall_skull",
    // rust: &props(&[("facing", "north")]),
    // rust: );
    // rust: assert!(matches!(
    // rust: k,
    // rust: Kind::Skull {
    // rust: kind: SkullType::WitherSkeleton,
    // rust: wall: Some("north"),
    // rust: ..
}
    // rust: ));
    // rust: let k = classify("minecraft:piglin_head", &props(&[("rotation", "4")]));
    // rust: assert!(matches!(
    // rust: k,
    // rust: Kind::Skull {
    // rust: kind: SkullType::Piglin,
    // rust: wall: None,
    // rust: segment: 4
}
    // rust: ));
    // rust: let k = classify(
    // rust: "minecraft:chest",
    // rust: &props(&[("facing", "north"), ("type", "left")]),
    // rust: );
        // A north-facing left half connects to the east (clockwise).
    // rust: assert!(matches!(
    // rust: k,
    // rust: Kind::Chest {
    // rust: part: ChestPart::Left,
    // rust: double_with: Some([1, 0, 0]),
    // rust: texture: "entity/chest/normal_left",
    // rust: ..
}
    // rust: ));
    // rust: let k = classify(
    // rust: "minecraft:waxed_oxidized_copper_chest",
    // rust: &props(&[("facing", "south"), ("type", "single")]),
    // rust: );
    // rust: assert!(matches!(
    // rust: k,
    // rust: Kind::Chest {
    // rust: texture: "entity/chest/copper_oxidized",
    // rust: ..
}
    // rust: ));
    // rust: assert!(matches!(
    // rust: classify("minecraft:lectern", &props(&[("has_book", "false")])),
    // rust: Kind::None
    // rust: ));
    // rust: assert!(matches!(
    // rust: classify("minecraft:furnace", &props(&[])),
    // rust: Kind::None
    // rust: ));
}
pub fn mix_light_matches_shader() void {
}
    // rust: let lights = diffuse_lights(false);
        // Straight up: both lights contribute.
    // rust: let up = diffuse(Vec3::Y, lights);
    // rust: let expected = ((lights.0.y + lights.1.y) * 0.6 + 0.4).min(1.0);
    // rust: assert!((up - expected).abs() < 1e-6);
        // Straight down: ambient only.
    // rust: assert!((diffuse(-Vec3::Y, lights) - 0.4).abs() < 1e-6);
}
pub fn part_poses_compose_like_model_part() void {
}
    // rust: let part = ModelPart {
    // rust: pose: [16.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: vec![[
    // rust: [0.0, 0.0, 0.0, 0.0, 0.0],
    // rust: [16.0, 0.0, 0.0, 1.0, 0.0],
    // rust: [16.0, 0.0, 16.0, 1.0, 1.0],
    // rust: [0.0, 0.0, 16.0, 0.0, 1.0],
    // rust: ]],
    // rust: children: vec![],
}
    // rust: let mut out = Vec::new();
    // rust: let rect = Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 0.5,
    // rust: v1: 0.5,
    // rust: w: 1,
    // rust: h: 1,
}
    // rust: draw_part(
    // rust: &part,
    // rust: "root",
    // rust: Mat4::IDENTITY,
    // rust: &|_, _| {},
    // rust: Paint {
    // rust: sprite: rect,
    // rust: tint: 0xFFFFFF,
    // rust: light: 0,
    // rust: lights: diffuse_lights(false),
    // rust: glow: None,
    // rust: },
    // rust: &mut out,
    // rust: );
    // rust: assert_eq!(out.len(), 4);
    // rust: assert_eq!(out[1].pos, [2.0, 0.0, 0.0]);
    // rust: assert_eq!(out[2].uv, [0.5, 0.5]);
}

    /// An OptiFine emissive overlay draws each polygon again with its own sprite at full
    /// brightness, shaded alike.
pub fn a_glow_draws_the_part_again_at_full_brightness() void {
}
    // rust: let part = ModelPart {
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: vec![[
    // rust: [0.0, 0.0, 0.0, 0.0, 0.0],
    // rust: [16.0, 0.0, 0.0, 1.0, 0.0],
    // rust: [16.0, 0.0, 16.0, 1.0, 1.0],
    // rust: [0.0, 0.0, 16.0, 0.0, 1.0],
    // rust: ]],
    // rust: children: vec![],
}
    // rust: let rect = |u0, v0| Rect {
    // rust: u0,
    // rust: v0,
    // rust: u1: u0 + 0.5,
    // rust: v1: v0 + 0.5,
    // rust: w: 1,
    // rust: h: 1,
}
    // rust: let mut out = Vec::new();
    // rust: let light = vertex_light(0x52);
    // rust: draw_part(
    // rust: &part,
    // rust: "root",
    // rust: Mat4::IDENTITY,
    // rust: &|_, _| {},
    // rust: Paint {
    // rust: sprite: rect(0.0, 0.0),
    // rust: tint: 0xFFFFFF,
    // rust: light,
    // rust: lights: diffuse_lights(false),
    // rust: glow: Some(rect(0.5, 0.5)),
    // rust: },
    // rust: &mut out,
    // rust: );
    // rust: assert_eq!(out.len(), 8);
    // rust: let (base, glow) = out.split_at(4);
    // rust: assert!(base.iter().all(|v| v.light == light));
    // rust: assert!(glow.iter().all(|v| v.light == 240 | (240 << 8)));
    // rust: assert_eq!(glow[2].uv, [1.0, 1.0]);
    // rust: assert_eq!(base[2].uv, [0.5, 0.5]);
    // rust: for (b, g) in base.iter().zip(glow) {
    // rust: assert_eq!((b.pos, b.color), (g.pos, g.color));
}
}

    /// TextFeatureRenderer.renderText: an outlined call's text is drawn over
    /// its outline (Font.DisplayMode.POLYGON_OFFSET), never level with it,
    /// and plain text stays on the sign's plane.
pub fn outlined_sign_text_sits_in_front_of_its_outline() void {
}
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = HashMap::new();
    // rust: let glyph = |_: char| {
    // rust: let rect = Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 0.0625,
    // rust: v1: 0.0625,
    // rust: w: 8,
    // rust: h: 8,
}
    // rust: Glyph {
    // rust: rect: Some(rect),
    // rust: right: 8.0,
    // rust: bottom: 8.0,
    // rust: advance: 6.0,
    // rust: ..Glyph::default()
}
}
    // rust: let scene = Scene {
    // rust: camera: DVec3::ZERO,
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &|_| BlockAnim::default(),
    // rust: texts: None,
    // rust: partial: 0.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &glyph,
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let mut call = TextCall {
    // rust: matrix: Mat4::IDENTITY,
    // rust: x: 0.0,
    // rust: y: 0.0,
    // rust: text: "Hi".into(),
    // rust: color: 0xFFFF_FF00,
    // rust: outline: 0xFF33_3300,
    // rust: light: 240 | 240 << 8,
}
    // rust: let mut out = Vec::new();
    // rust: draw_text(&scene, &call, &mut out);
        // Eight outline copies, then the text, four corners a glyph.
    // rust: assert_eq!(out.len(), 9 * 2 * 4);
    // rust: let (outline, text) = out.split_at(8 * 2 * 4);
    // rust: let front = outline.iter().map(|v| v.pos[2]).fold(f32::MIN, f32::max);
    // rust: assert!(
    // rust: text.iter().all(|v| v.pos[2] > front),
    // rust: "text z {:?} not in front of the outline at {front}",
    // rust: text.iter().map(|v| v.pos[2]).collect::<Vec<_>>()
    // rust: );
    // rust: call.outline = 0;
    // rust: out.clear();
    // rust: draw_text(&scene, &call, &mut out);
    // rust: assert_eq!(out.len(), 2 * 4);
    // rust: assert!(out.iter().all(|v| v.pos[2] == 0.0));
}

    /// BakedSheetGlyph draws a glyph over its own box from the pen
    /// (x + left .. x + right, y + up .. y + down), not a fixed 8x8 cell. With
    /// Force Unicode Font a Latin letter is an 8x16 Unifont glyph at half
    /// scale: 4 units wide and 8 tall, advancing 5 (#8699).
pub fn sign_text_draws_each_glyph_over_its_own_box() void {
}
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = HashMap::new();
    // rust: let glyph = |_: char| Glyph {
    // rust: rect: Some(Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 0.0625,
    // rust: v1: 0.125,
    // rust: w: 8,
    // rust: h: 16,
    // rust: }),
    // rust: left: 0.0,
    // rust: top: 0.0,
    // rust: right: 4.0,
    // rust: bottom: 8.0,
    // rust: advance: 5.0,
    // rust: offset: 0.5,
}
    // rust: let scene = Scene {
    // rust: camera: DVec3::ZERO,
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &|_| BlockAnim::default(),
    // rust: texts: None,
    // rust: partial: 0.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &glyph,
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let call = TextCall {
    // rust: matrix: Mat4::IDENTITY,
    // rust: x: 10.0,
    // rust: y: 2.0,
    // rust: text: "ab".into(),
    // rust: color: 0xFF00_0000,
    // rust: outline: 0,
    // rust: light: 240 | 240 << 8,
}
    // rust: let mut out = Vec::new();
    // rust: draw_text(&scene, &call, &mut out);
    // rust: let boxes: Vec<_> = out
    // rust: .chunks(4)
    // rust: .map(|q| {
    // rust: let xs = q.iter().map(|v| v.pos[0]);
    // rust: let ys = q.iter().map(|v| v.pos[1]);
    // rust: [
    // rust: xs.clone().fold(f32::MAX, f32::min),
    // rust: xs.fold(f32::MIN, f32::max),
    // rust: ys.clone().fold(f32::MAX, f32::min),
    // rust: ys.fold(f32::MIN, f32::max),
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(boxes, [[10.0, 14.0, 2.0, 10.0], [15.0, 19.0, 2.0, 10.0]]);
}

    /// The front text calls of a sign whose every glyph advances 6.
pub fn front_calls(data: *SignData, near: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = HashMap::new();
    // rust: let glyph = |_: char| Glyph {
    // rust: advance: 6.0,
    // rust: ..Glyph::default()
}
    // rust: let scene = Scene {
    // rust: camera: DVec3::ZERO,
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &|_| BlockAnim::default(),
    // rust: texts: None,
    // rust: partial: 0.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &glyph,
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: sign_text_calls(&scene, data, &data.front, Mat4::IDENTITY, 0, near)
    // rust: .into_iter()
    // rust: .map(|c| (c.text, c.x, c.y, c.color, c.outline))
    // rust: .collect()
}
pub fn sign_with(lines: [Tag; 4]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut data = SignData::default();
    // rust: data.decode(&Tag::compound([(
    // rust: "front_text",
    // rust: Tag::compound([("messages", Tag::List(lines.to_vec()))]),
    // rust: )]));
    // rust: data
}
pub fn colored(text: []const u8, color: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([
    // rust: ("text", Tag::String(text.into())),
    // rust: ("color", Tag::String(color.into())),
    // rust: ])
}

    /// `Font.StringRenderOutput`: a glyph takes its style's colour and the
    /// sign's dark text colour only when the style has none (#9783). A line
    /// of two colours is two calls, the second where the first ends, the
    /// whole line centred.
pub fn sign_text_takes_each_lines_own_colors() void {
}
    // rust: let mut two = colored("ab", "red");
    // rust: let Tag::Compound(parts) = &mut two else {
    // rust: unreachable!()
}
    // rust: parts.insert("extra".into(), Tag::List(vec![colored("cd", "blue")]));
    // rust: let data = sign_with([
    // rust: Tag::String("plain".into()),
    // rust: colored("Online", "green"),
    // rust: two,
    // rust: Tag::String("".into()),
    // rust: ]);
        // Black dye: the dark text colour is black. Sign lines are 10 apart
        // from 20 above the middle.
    // rust: assert_eq!(
    // rust: front_calls(&data, false),
    // rust: [
    // rust: ("plain".to_owned(), -15.0, -20.0, 0xFF00_0000, 0),
    // rust: ("Online".to_owned(), -18.0, -10.0, 0xFF55_FF55, 0),
    // rust: ("ab".to_owned(), -12.0, 0.0, 0xFFFF_5555, 0),
    // rust: ("cd".to_owned(), 0.0, 0.0, 0xFF55_55FF, 0),
    // rust: (String::new(), 0.0, 10.0, 0xFF00_0000, 0),
    // rust: ]
    // rust: );
}

    /// A glowing sign's own colour still wins over its dye, and the outline
    /// stays the dye's dark colour. `§` codes in a line colour it too, and
    /// `§r` goes back to the sign's colour.
pub fn glowing_sign_text_keeps_its_outline_under_a_lines_own_colors() void {
}
    // rust: let mut data = sign_with([
    // rust: Tag::String("plain".into()),
    // rust: colored("Online", "green"),
    // rust: Tag::String("§cRed§rX".into()),
    // rust: Tag::String("".into()),
    // rust: ]);
    // rust: data.front.color = 14;
    // rust: data.front.glowing = true;
    // rust: let (red, outline) = (0xFFFF_0000, 0xFF66_0000);
    // rust: assert_eq!(
    // rust: front_calls(&data, true),
    // rust: [
    // rust: ("plain".to_owned(), -15.0, -20.0, red, outline),
    // rust: ("Online".to_owned(), -18.0, -10.0, 0xFF55_FF55, outline),
    // rust: ("Red".to_owned(), -12.0, 0.0, 0xFFFF_5555, outline),
    // rust: ("X".to_owned(), 6.0, 0.0, red, outline),
    // rust: (String::new(), 0.0, 10.0, red, outline),
    // rust: ]
    // rust: );
}

    /// The text that fits the sign is drawn, in the colour it had.
pub fn a_long_colored_line_is_cut_where_it_stops_fitting() void {
}
        // 90 wide: fifteen glyphs of 6.
    // rust: let data = sign_with([
    // rust: colored("abcdefghijklmnopqrst", "gold"),
    // rust: Tag::String("".into()),
    // rust: Tag::String("".into()),
    // rust: Tag::String("".into()),
    // rust: ]);
    // rust: assert_eq!(
    // rust: front_calls(&data, false)[0],
    // rust: ("abcdefghijklmno".to_owned(), -45.0, -20.0, 0xFFFF_AA00, 0)
    // rust: );
}

pub fn cached_sign_text_matches_and_follows_changes() void {
}
    // rust: let renderer = BlockEntityRenderer {
    // rust: vanilla: Default::default(),
    // rust: shapes: Default::default(),
    // rust: kinds: vec![
    // rust: Kind::Sign {
    // rust: hanging: false,
    // rust: wall: false,
    // rust: angle: 180.0,
    // rust: },
    // rust: Kind::Sign {
    // rust: hanging: true,
    // rust: wall: true,
    // rust: angle: 90.0,
    // rust: },
    // rust: ],
    // rust: pot_patterns: HashMap::new(),
    // rust: visibility: None,
    // rust: sign_texts: Mutex::default(),
    // rust: static_geometry: Mutex::default(),
    // rust: sign_cache_enabled: AtomicBool::new(false),
}
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let sprites = HashMap::new();
    // rust: let text = |line: &str, glowing| SignText {
    // rust: lines: [line.into(), "two".into(), String::new(), "four".into()],
    // rust: color: 3,
    // rust: glowing,
    // rust: ..Default::default()
}
    // rust: let first_text = SignData {
    // rust: front: text("one", false),
    // rust: ..Default::default()
}
    // rust: let changed = SignData {
    // rust: front: text("changed", false),
    // rust: ..Default::default()
}
    // rust: let glowing = SignData {
    // rust: back: text("glow", true),
    // rust: ..changed.clone()
}
    // rust: let wide = std::cell::Cell::new(6.0);
    // rust: let glyph = |c: char| {
    // rust: let u = f32::from(c as u8 % 16) / 16.0;
    // rust: let rect = Rect {
    // rust: u0: u,
    // rust: v0: 0.0,
    // rust: u1: u + 0.0625,
    // rust: v1: 0.0625,
    // rust: w: 8,
    // rust: h: 8,
}
    // rust: Glyph {
    // rust: rect: (c != ' ').then_some(rect),
    // rust: right: 8.0,
    // rust: bottom: 8.0,
    // rust: advance: wide.get(),
    // rust: ..Glyph::default()
}
}
    // rust: let (first_sign, changed_sign, glowing_sign) = (
    // rust: |_| Some(&first_text),
    // rust: |_| Some(&changed),
    // rust: |_| Some(&glowing),
    // rust: );
    // rust: let mut scene = Scene {
    // rust: camera: DVec3::new(3.25, 70.5, -4.75),
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &|_| BlockAnim::default(),
    // rust: texts: None,
    // rust: partial: 0.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &first_sign,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &glyph,
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let check = |scene: &Scene, pos: [i32; 3], state: u32| {
    // rust: let mut cached = Vec::new();
    // rust: renderer.render(scene, [(pos, state)].iter(), &mut cached);
    // rust: let corner = DVec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]));
    // rust: let mut original = Vec::new();
    // rust: renderer.render_one(
    // rust: scene,
    // rust: pos,
    // rust: renderer.kind(state),
    // rust: Mat4::from_translation((corner - scene.camera).as_vec3()),
    // rust: world.light(pos[0], pos[1], pos[2]),
    // rust: diffuse_lights(false),
    // rust: false,
    // rust: true,
    // rust: &mut original,
    // rust: );
    // rust: assert!(!cached.is_empty());
    // rust: assert_eq!(cached.len(), original.len());
    // rust: for (a, b) in cached.iter().zip(&original) {
    // rust: assert!((Vec3::from_array(a.pos) - Vec3::from_array(b.pos)).length() < 1e-5);
    // rust: assert_eq!((a.uv, a.color, a.light), (b.uv, b.color, b.light));
}
    // rust: cached.len()
}
    // rust: let (pos, other) = ([1, 70, 2], [-3, 64, 9]);
    // rust: let first = check(&scene, pos, 0);
        // The camera moves: the same text, moved.
    // rust: scene.camera.x += 0.5;
    // rust: check(&scene, pos, 0);
        // New text, glowing text near and far, another state, other glyphs.
    // rust: scene.sign = &changed_sign;
    // rust: assert_ne!(check(&scene, pos, 0), first);
    // rust: scene.sign = &glowing_sign;
    // rust: check(&scene, pos, 0);
    // rust: scene.camera.z -= 20.0;
    // rust: check(&scene, pos, 0);
    // rust: check(&scene, pos, 1);
    // rust: check(&scene, other, 1);
    // rust: wide.set(5.0);
    // rust: scene.glyphs = 1;
    // rust: check(&scene, pos, 1);
        // Signs out of view for a while are dropped.
    // rust: scene.game_time = 2 * SIGN_TEXT_KEEP;
    // rust: check(&scene, pos, 0);
    // rust: assert_eq!(renderer.sign_texts.lock().unwrap().signs.len(), 1);
}
pub fn first_line_wraps_on_bytes_without_splitting_a_char() void {
}
    // rust: let advance = |c: char| if c == ' ' { 4.0 } else { 6.0 };
    // rust: assert_eq!(first_line("ab cd ef", 13.0, &advance), "ab");
    // rust: assert_eq!(first_line("abcdef", 13.0, &advance), "ab");
    // rust: assert_eq!(first_line("\u{6771}", 3.0, &advance), "\u{6771}");
    // rust: assert_eq!(first_line("ab\ncd", 100.0, &advance), "ab");
}
    /// `rendertype_end_portal` culls back faces, and `AbstractEndPortalRenderer`
    /// submits the unit cube's two Y faces. Both are wound outward, so of each
    /// face only the side looking at the camera draws: the portal shows one
    /// surface from above and one from below, never both at once.
pub fn the_end_portal_cube_is_one_sided() void {
}
    // rust: let mut out = Vec::new();
    // rust: portal_cube(
    // rust: Mat4::IDENTITY,
    // rust: &[Direction::Down, Direction::Up],
    // rust: END_PORTAL_LAYER,
    // rust: &mut out,
    // rust: );
        // `TheEndPortalBlockEntity.shouldRenderFace` keeps the Y faces only.
    // rust: assert_eq!(out.len(), 8, "the cube submits both Y faces");
    // rust: assert!(
    // rust: out.iter().all(|v| v.normal == CULL_BACK),
    // rust: "rendertype_end_portal culls back faces"
    // rust: );
        // Each face is wound outward, so the shader's `!front` discard keeps the
        // camera-facing side of it and drops the other.
    // rust: let facing = |quad: &[Vertex]| {
    // rust: let p = |i: usize| Vec3::from(quad[i].pos);
    // rust: (p(1) - p(0)).cross(p(2) - p(0))
}
    // rust: assert!(facing(&out[..4]).y < 0.0, "the Down face looks down");
    // rust: assert!(facing(&out[4..]).y > 0.0, "the Up face looks up");
}

    /// `DecoratedPotRenderer` submits every part with `RenderTypes.entitySolid`,
    /// whose pipeline culls back faces. The pot's `top` and `bottom` are flat
    /// boxes, so without that cull both sides of each plane are drawn and they
    /// z-fight: the pot renders wrong.
pub fn the_decorated_pot_culls_its_back_faces() void {
}
    // rust: let root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-models.json").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let renderer = BlockEntityRenderer::load(&root, registry).unwrap();
    // rust: let state = registry.default_state("minecraft:decorated_pot").unwrap();
    // rust: let sprites: HashMap<String, Rect> = [
    // rust: "entity/decorated_pot/decorated_pot_base",
    // rust: "entity/decorated_pot/decorated_pot_side",
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|name| {
    // rust: (
    // rust: name.to_owned(),
    // rust: Rect {
    // rust: u0: 0.25,
    // rust: v0: 0.125,
    // rust: u1: 0.375,
    // rust: v1: 0.25,
    // rust: w: 16,
    // rust: h: 16,
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let scene = Scene {
    // rust: camera: DVec3::ZERO,
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &|_| BlockAnim::default(),
    // rust: texts: None,
    // rust: partial: 0.5,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
    // rust: let mut verts = Vec::new();
    // rust: renderer.render_block(&scene, [0; 3], state.0, Mat4::IDENTITY, 0xff, &mut verts);
        // Vanilla submits 28 quads for a plain pot, and the cull keeps them all.
    // rust: assert_eq!(
    // rust: verts.len() / 4,
    // rust: 28,
    // rust: "the pot submits all of vanilla's quads"
    // rust: );
    // rust: assert!(
    // rust: verts.iter().all(|v| v.normal == CULL_BACK),
    // rust: "entitySolid culls the pot's back faces"
    // rust: );
}

pub fn a_chest_jem_reshapes_the_closed_chest_and_paints_its_texture() void {
}
//         use crate::block_entity_cem::tests::{BOX, chest, pack};
    // rust: let vanilla = Arc::new(BlockEntityShapes::new(
    // rust: HashMap::from([("chest", chest())]),
    // rust: HashMap::new(),
    // rust: ));
    // rust: let renderer = BlockEntityRenderer {
    // rust: shapes: RwLock::new(vanilla.clone()),
    // rust: vanilla,
    // rust: kinds: Vec::new(),
    // rust: pot_patterns: HashMap::new(),
    // rust: visibility: None,
    // rust: sign_texts: Mutex::default(),
    // rust: static_geometry: Mutex::default(),
    // rust: sign_cache_enabled: AtomicBool::new(false),
}
        // No block entity's `.jem` (a mob's only): vanilla's shapes, not a copy.
    // rust: let empty = pack("render-none", &[("optifine/cem/zombie.jem", "{}".into())]);
    // rust: assert!(Arc::ptr_eq(&renderer.shapes_for(&empty), &renderer.vanilla));
    // rust: let root = pack(
    // rust: "render-chest",
    // rust: &[(
    // rust: "optifine/cem/chest.jem",
    // rust: format!(
    // rust: r#"{{"texture": "textures/entity/chest/fancy.png",
    // rust: "models": [{{"part": "lid", {BOX}}}]}}"#
    // rust: ),
    // rust: )],
    // rust: );
    // rust: renderer.set_shapes(renderer.shapes_for(&root));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let _ = std::fs::remove_dir_all(&empty);
    // rust: let rect = |u0: f32| Rect {
    // rust: u0,
    // rust: v0: 0.0,
    // rust: u1: u0 + 0.2,
    // rust: v1: 0.2,
    // rust: w: 16,
    // rust: h: 16,
}
    // rust: let sprites: HashMap<String, Rect> = [
    // rust: ("entity/chest/normal", rect(0.0)),
    // rust: ("entity/chest/ender", rect(0.2)),
    // rust: ("entity/chest/fancy", rect(0.4)),
    // rust: ("entity/chest/copper", rect(0.6)),
    // rust: ]
    // rust: .map(|(name, r)| (name.to_owned(), r))
    // rust: .into();
    // rust: let world = World::new(BlockStateId(0), 1);
    // rust: let scene = Scene {
    // rust: camera: DVec3::ZERO,
    // rust: orientation: Quat::IDENTITY,
    // rust: anim: &|_| BlockAnim::default(),
    // rust: texts: None,
    // rust: partial: 0.0,
    // rust: game_time: 0,
    // rust: max_y: 320,
    // rust: world: &world,
    // rust: sprites: &sprites,
    // rust: emissive: &Default::default(),
    // rust: translucent_sprites: &HashSet::new(),
    // rust: atlas_revision: 1,
    // rust: nether: false,
    // rust: lid: &|_| 0.0,
    // rust: sign: &|_| None,
    // rust: banner: &|_| Vec::new(),
    // rust: skull: &|_| None,
    // rust: glyph: &|_| Glyph::default(),
    // rust: glyphs: 0,
    // rust: dynamic_visible: None,
}
        // A closed single chest of `block` drawn by `renderer`: positions and UVs.
    // rust: let draw = |renderer: &BlockEntityRenderer, block: &str, texture: &'static str| {
    // rust: let kind = Kind::Chest {
    // rust: block: block.into(),
    // rust: texture,
    // rust: part: ChestPart::Single,
    // rust: y_rot: 0.0,
    // rust: double_with: None,
}
    // rust: let mut out = Vec::new();
    // rust: renderer.render_one(
    // rust: &scene,
    // rust: [0; 3],
    // rust: &kind,
    // rust: Mat4::IDENTITY,
    // rust: 0xF0,
    // rust: diffuse_lights(false),
    // rust: false,
    // rust: true,
    // rust: &mut out,
    // rust: );
    // rust: out.iter().map(|v| (v.pos, v.uv)).collect::<Vec<_>>()
}
        // The chest's three faces become the bottom's, the lock's and the custom lid's six, in
        // the `.jem`'s texture. Ender and copper chests have no file of their own: vanilla's
        // three faces in their own textures. (Trapped chests: `block_entity_cem`'s tests; their
        // texture turns festive in late December.)
    // rust: for (block, texture, u0, faces) in [
    // rust: ("chest", "entity/chest/normal", 0.4, 8),
    // rust: ("ender_chest", "entity/chest/ender", 0.2, 3),
    // rust: ("copper_chest", "entity/chest/copper", 0.6, 3),
    // rust: ] {
    // rust: let out = draw(&renderer, block, texture);
    // rust: assert_eq!(out.len(), faces * 4, "{block}");
    // rust: assert!(
    // rust: out.iter().all(|(_, uv)| (u0..=u0 + 0.2).contains(&uv[0])),
    // rust: "{block}"
    // rust: );
}
        // A copper chest draws exactly what it draws without any pack.
    // rust: let plain = BlockEntityRenderer {
    // rust: shapes: RwLock::new(renderer.vanilla.clone()),
    // rust: vanilla: renderer.vanilla.clone(),
    // rust: kinds: Vec::new(),
    // rust: pot_patterns: HashMap::new(),
    // rust: visibility: None,
    // rust: sign_texts: Mutex::default(),
    // rust: static_geometry: Mutex::default(),
    // rust: sign_cache_enabled: AtomicBool::new(false),
}
    // rust: assert_eq!(
    // rust: draw(&renderer, "copper_chest", "entity/chest/copper"),
    // rust: draw(&plain, "copper_chest", "entity/chest/copper")
    // rust: );
        // The atlas has no such texture: vanilla's.
    // rust: let shapes = renderer.shapes();
    // rust: assert_eq!(
    // rust: shapes.texture("chest", "entity/chest/normal", &HashMap::new()),
    // rust: "entity/chest/normal"
    // rust: );
}
}

    // rust: mod cache_behavior_tests;
