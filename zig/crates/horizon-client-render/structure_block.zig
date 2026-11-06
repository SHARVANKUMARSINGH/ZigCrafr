//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_structure_block
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `StructureBlockEntity`: the structure block's name, offset, size, mode and
//! options, with its save format (`saveAdditional` / `loadAdditional`), the
//! corner scan (`getEnclosingBoundingBox`) and the box the editor shows
//! (`getRenderableBox`).
// use horizon_client_core::nbt_value::{float, number, string, text};
// use horizon_world::{
    // rust: nbt::Tag,
    // rust: worldgen::structure::{Mirror, Rotation},
}

pub const MAX_OFFSET_PER_AXIS: i32 = 48;
pub const MAX_SIZE_PER_AXIS: i32 = 48;
/// `SCAN_CORNER_BLOCKS_RANGE`.
pub const SCAN_CORNER_BLOCKS_RANGE: i32 = 80;

/// `StructureMode`, in declaration order.
pub const StructureMode = enum {
    Save,
    Load,
    Corner,
    Data,
};

    // rust: impl StructureMode {
pub const ALL: [Self; 4] = [Self::Save, Self::Load, Self::Corner, Self::Data];
    /// `StructureMode.getSerializedName`: the block state's `mode` value.
pub fn serialized_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Save => "save",
    // rust: Self::Load => "load",
    // rust: Self::Corner => "corner",
    // rust: Self::Data => "data",
}
}
pub fn of_serialized_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|m| m.serialized_name() == name)
}
    /// `StructureMode.LEGACY_CODEC`: `Enum.name()`.
pub fn legacy_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Save => "SAVE",
    // rust: Self::Load => "LOAD",
    // rust: Self::Corner => "CORNER",
    // rust: Self::Data => "DATA",
}
}
pub fn from_legacy_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|m| m.legacy_name() == name)
}
pub fn ordinal(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self as i32
}
pub fn from_ordinal(ordinal: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: usize::try_from(ordinal)
    // rust: .ok()
    // rust: .and_then(|i| Self::ALL.get(i).copied())
}
    /// `StructureMode.getDisplayName`'s lang key.
pub fn info_key(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("structure_block.mode_info.{}", self.serialized_name())
}
    /// The mode button's label (`structure_block.mode.<name>`).
pub fn label_key(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("structure_block.mode.{}", self.serialized_name())
}
}

/// `StructureBlockEntity.UpdateType`, in declaration order.
pub const UpdateType = enum {
    UpdateData,
    SaveArea,
    LoadArea,
    ScanArea,
};

    // rust: impl UpdateType {
pub fn ordinal(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self as i32
}
pub fn from_ordinal(ordinal: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match ordinal {
    // rust: 0 => Self::UpdateData,
    // rust: 1 => Self::SaveArea,
    // rust: 2 => Self::LoadArea,
    // rust: 3 => Self::ScanArea,
    // rust: _ => return None,
    // rust: })
}
}

pub fn rotation_from_ordinal(ordinal: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: usize::try_from(ordinal)
    // rust: .ok()
    // rust: .and_then(|i| Rotation::ALL.get(i).copied())
}
pub fn rotation_ordinal(rotation: Rotation) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: rotation as i32
}
pub fn rotation_from_legacy_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Rotation::ALL.into_iter().find(|r| r.saved_name() == name)
}
pub fn mirror_from_ordinal(ordinal: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match ordinal {
    // rust: 0 => Mirror::None,
    // rust: 1 => Mirror::LeftRight,
    // rust: 2 => Mirror::FrontBack,
    // rust: _ => return None,
    // rust: })
}
pub fn mirror_ordinal(mirror: Mirror) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: mirror as i32
}
pub fn mirror_from_legacy_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [Mirror::None, Mirror::LeftRight, Mirror::FrontBack]
    // rust: .into_iter()
    // rust: .find(|m| m.saved_name() == name)
}

/// `BoundingBoxRenderable.Mode`.
pub const RenderMode = enum {
    None,
    Box,
    BoxAndInvisibleBlocks,
};

/// `BoundingBoxRenderable.RenderableBox`: an offset from the block and a
/// size, in blocks.
pub const RenderableBox = struct {
    offset: [i32,
    size: [i32,
};

    // rust: impl RenderableBox {
    /// `RenderableBox.fromCorners`.
pub fn from_corners(x0: i32, y0: i32, z0: i32, x1: i32, y1: i32, z1: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (min_x, min_y, min_z) = (x0.min(x1), y0.min(y1), z0.min(z1));
    // rust: Self {
    // rust: offset: [min_x, min_y, min_z],
    // rust: size: [x0.max(x1) - min_x, y0.max(y1) - min_y, z0.max(z1) - min_z],
}
}
}

pub const StructureBlock = struct {
    /// The structure's id; an unparsable or empty name is none.
    name: ?[]const u8,
    author: []const u8,
    metadata: []const u8,
    pos: [i32,
    size: [i32,
    mirror: Mirror,
    rotation: Rotation,
    mode: StructureMode,
    ignore_entities: bool,
    strict: bool,
    powered: bool,
    show_air: bool,
    show_bounding_box: bool,
    integrity: f32,
    seed: i64,
};

    // rust: impl StructureBlock {
    /// `new StructureBlockEntity(pos, state)`: the mode is the state's.
pub fn new(mode: StructureMode) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: name: None,
    // rust: author: String::new(),
    // rust: metadata: String::new(),
    // rust: pos: [0, 1, 0],
    // rust: size: [0; 3],
    // rust: mirror: Mirror::None,
    // rust: rotation: Rotation::None,
    // rust: mode,
    // rust: ignore_entities: true,
    // rust: strict: false,
    // rust: powered: false,
    // rust: show_air: false,
    // rust: show_bounding_box: true,
    // rust: integrity: 1.0,
    // rust: seed: 0,
}
}

    /// `StructureBlockEntity.getStructureName`.
pub fn structure_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.name.as_deref().unwrap_or("")
}

    /// `setStructureName(String)`: empty or unparsable is none (`Identifier.tryParse`).
pub fn set_structure_name(self: *Self, name: []const u8) void {
}
    // rust: self.name = if name.is_empty() {
    // rust: None
    // rust: } else {
    // rust: parse_identifier(name)
}
}

    /// `StructureBlockEntity.saveAdditional`.
pub fn save(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let byte = |b: bool| Tag::Byte(i8::from(b));
    // rust: vec![
    // rust: ("name", string(self.structure_name())),
    // rust: ("author", string(&self.author)),
    // rust: ("metadata", string(&self.metadata)),
    // rust: ("posX", Tag::Int(self.pos[0])),
    // rust: ("posY", Tag::Int(self.pos[1])),
    // rust: ("posZ", Tag::Int(self.pos[2])),
    // rust: ("sizeX", Tag::Int(self.size[0])),
    // rust: ("sizeY", Tag::Int(self.size[1])),
    // rust: ("sizeZ", Tag::Int(self.size[2])),
    // rust: ("rotation", string(self.rotation.saved_name())),
    // rust: ("mirror", string(self.mirror.saved_name())),
    // rust: ("mode", string(self.mode.legacy_name())),
    // rust: ("ignoreEntities", byte(self.ignore_entities)),
    // rust: ("strict", byte(self.strict)),
    // rust: ("powered", byte(self.powered)),
    // rust: ("showair", byte(self.show_air)),
    // rust: ("showboundingbox", byte(self.show_bounding_box)),
    // rust: ("integrity", Tag::Float(self.integrity.to_bits())),
    // rust: ("seed", Tag::Long(self.seed)),
    // rust: ]
}

    /// `StructureBlockEntity.loadAdditional`.
pub fn load(tag: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let int = |key: &str, default: i32, lo: i32, hi: i32| {
    // rust: (number(tag.get(key)).unwrap_or(i64::from(default)) as i32).clamp(lo, hi)
}
    // rust: let flag = |key: &str, default: bool| number(tag.get(key)).map_or(default, |v| v != 0);
    // rust: let o = MAX_OFFSET_PER_AXIS;
    // rust: let s = MAX_SIZE_PER_AXIS;
    // rust: let mut block = Self::new(
    // rust: text(tag.get("mode"))
    // rust: .and_then(|m| StructureMode::from_legacy_name(&m))
    // rust: .unwrap_or(StructureMode::Data),
    // rust: );
    // rust: block.set_structure_name(&text(tag.get("name")).unwrap_or_default());
    // rust: block.author = text(tag.get("author")).unwrap_or_default();
    // rust: block.metadata = text(tag.get("metadata")).unwrap_or_default();
    // rust: block.pos = [
    // rust: int("posX", 0, -o, o),
    // rust: int("posY", 1, -o, o),
    // rust: int("posZ", 0, -o, o),
    // rust: ];
    // rust: block.size = [
    // rust: int("sizeX", 0, 0, s),
    // rust: int("sizeY", 0, 0, s),
    // rust: int("sizeZ", 0, 0, s),
    // rust: ];
    // rust: block.rotation = text(tag.get("rotation"))
    // rust: .and_then(|r| rotation_from_legacy_name(&r))
    // rust: .unwrap_or(Rotation::None);
    // rust: block.mirror = text(tag.get("mirror"))
    // rust: .and_then(|m| mirror_from_legacy_name(&m))
    // rust: .unwrap_or(Mirror::None);
    // rust: block.ignore_entities = flag("ignoreEntities", true);
    // rust: block.strict = flag("strict", false);
    // rust: block.powered = flag("powered", false);
    // rust: block.show_air = flag("showair", false);
    // rust: block.show_bounding_box = flag("showboundingbox", true);
    // rust: block.integrity = float(tag.get("integrity")).map_or(1.0, |f| f as f32);
    // rust: block.seed = number(tag.get("seed")).unwrap_or(0);
    // rust: block
}

    /// `StructureBlockEntity.renderMode`.
pub fn render_mode(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.mode != StructureMode::Save && self.mode != StructureMode::Load {
    // rust: RenderMode::None
    // rust: } else if self.mode == StructureMode::Save && self.show_air {
    // rust: RenderMode::BoxAndInvisibleBlocks
    // rust: } else if self.mode != StructureMode::Save && !self.show_bounding_box {
    // rust: RenderMode::None
    // rust: } else {
    // rust: RenderMode::Box
}
}

    /// `StructureBlockEntity.getRenderableBox`.
pub fn renderable_box(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x_origin, y0, z_origin] = self.pos;
    // rust: let size = self.size;
    // rust: let y1 = y0 + size[1];
    // rust: let (x_diff, z_diff) = match self.mirror {
    // rust: Mirror::LeftRight => (size[0], -size[2]),
    // rust: Mirror::FrontBack => (-size[0], size[2]),
    // rust: Mirror::None => (size[0], size[2]),
}
    // rust: let (x0, z0, x1, z1);
    // rust: match self.rotation {
    // rust: Rotation::Clockwise90 => {
    // rust: x0 = if z_diff < 0 { x_origin } else { x_origin + 1 };
    // rust: z0 = if x_diff < 0 { z_origin + 1 } else { z_origin };
    // rust: x1 = x0 - z_diff;
    // rust: z1 = z0 + x_diff;
}
    // rust: Rotation::Clockwise180 => {
    // rust: x0 = if x_diff < 0 { x_origin } else { x_origin + 1 };
    // rust: z0 = if z_diff < 0 { z_origin } else { z_origin + 1 };
    // rust: x1 = x0 - x_diff;
    // rust: z1 = z0 - z_diff;
}
    // rust: Rotation::Counterclockwise90 => {
    // rust: x0 = if z_diff < 0 { x_origin + 1 } else { x_origin };
    // rust: z0 = if x_diff < 0 { z_origin } else { z_origin + 1 };
    // rust: x1 = x0 + z_diff;
    // rust: z1 = z0 - x_diff;
}
    // rust: Rotation::None => {
    // rust: x0 = if x_diff < 0 { x_origin + 1 } else { x_origin };
    // rust: z0 = if z_diff < 0 { z_origin + 1 } else { z_origin };
    // rust: x1 = x0 + x_diff;
    // rust: z1 = z0 + z_diff;
}
}
    // rust: RenderableBox::from_corners(x0, y0, z0, x1, y1, z1)
}

    /// `StructureBlockEntity.getEnclosingBoundingBox` over the corner blocks
    /// of this structure's name found in range (`corners`: every position of
    /// a corner-mode structure block with the same name), with `at` the block
    /// asking. Returns the inclusive min and max, none without a corner.
pub fn enclosing_box(corners: *[[i32; 3]], at: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut found: Option<([i32; 3], [i32; 3])> = None;
    // rust: for c in corners {
    // rust: found = Some(match found {
    // rust: None => (*c, *c),
    // rust: Some((min, max)) => (
    // rust: [min[0].min(c[0]), min[1].min(c[1]), min[2].min(c[2])],
    // rust: [max[0].max(c[0]), max[1].max(c[1]), max[2].max(c[2])],
    // rust: ),
    // rust: });
}
    // rust: let (min, max) = found?;
    // rust: if corners.len() == 1 {
    // rust: return Some((
    // rust: [min[0].min(at[0]), min[1].min(at[1]), min[2].min(at[2])],
    // rust: [max[0].max(at[0]), max[1].max(at[1]), max[2].max(at[2])],
    // rust: ));
}
    // rust: Some((min, max))
}

    /// `detectSize`'s result for the box: the offset and size the block takes
    /// when every side is wider than the corner blocks themselves.
pub fn detected(min: [i32; 3], max: [i32; 3], at: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let delta = [max[0] - min[0], max[1] - min[1], max[2] - min[2]];
    // rust: if delta.iter().all(|d| *d > 1) {
    // rust: Some((
    // rust: [min[0] - at[0] + 1, min[1] - at[1] + 1, min[2] - at[2] + 1],
    // rust: [delta[0] - 1, delta[1] - 1, delta[2] - 1],
    // rust: ))
    // rust: } else {
    // rust: None
}
}
}

/// `Identifier.tryParse`: `namespace:path` (the namespace defaults to
/// `minecraft`) with only legal characters, as its string form.
pub fn parse_identifier(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = text.split_once(':').unwrap_or(("minecraft", text));
    // rust: let namespace = if namespace.is_empty() {
    // rust: "minecraft"
    // rust: } else {
    // rust: namespace
}
    // rust: let namespace_ok = namespace
    // rust: .chars()
    // rust: .all(|c| matches!(c, '_' | '-' | '.' | '0'..='9' | 'a'..='z'));
    // rust: let path_ok = !path.is_empty()
    // rust: && path
    // rust: .chars()
    // rust: .all(|c| matches!(c, '_' | '-' | '.' | '/' | '0'..='9' | 'a'..='z'));
    // rust: (namespace_ok && path_ok).then(|| format!("{namespace}:{path}"))
}

    // rust: mod tests {
//     use super::*;

pub fn saves_and_loads_like_structure_block_entity() void {
}
    // rust: let mut block = StructureBlock::new(StructureMode::Save);
    // rust: block.set_structure_name("house");
    // rust: block.author = "levzzz".into();
    // rust: block.pos = [1, -2, 3];
    // rust: block.size = [4, 5, 6];
    // rust: block.rotation = Rotation::Clockwise90;
    // rust: block.mirror = Mirror::FrontBack;
    // rust: block.ignore_entities = false;
    // rust: block.strict = true;
    // rust: block.integrity = 0.25;
    // rust: block.seed = -9;
    // rust: let tag = Tag::compound(block.save());
    // rust: assert_eq!(text(tag.get("name")).as_deref(), Some("minecraft:house"));
    // rust: assert_eq!(text(tag.get("mode")).as_deref(), Some("SAVE"));
    // rust: assert_eq!(text(tag.get("rotation")).as_deref(), Some("CLOCKWISE_90"));
    // rust: assert_eq!(StructureBlock::load(&tag), block.clone());
}

pub fn load_clamps_and_defaults() void {
}
    // rust: let tag = Tag::compound(vec![
    // rust: ("posX", Tag::Int(99)),
    // rust: ("posY", Tag::Int(-99)),
    // rust: ("sizeX", Tag::Int(-4)),
    // rust: ("sizeY", Tag::Int(100)),
    // rust: ("name", string("Bad Name")),
    // rust: ]);
    // rust: let block = StructureBlock::load(&tag);
    // rust: assert_eq!(block.pos, [48, -48, 0]);
    // rust: assert_eq!(block.size, [0, 48, 0]);
    // rust: assert_eq!(block.name, None);
    // rust: assert_eq!(block.mode, StructureMode::Data);
    // rust: assert!(block.ignore_entities && block.show_bounding_box && !block.strict);
    // rust: assert_eq!(block.integrity, 1.0);
        // Pos defaults to (0, 1, 0).
    // rust: assert_eq!(
    // rust: StructureBlock::load(&Tag::compound(Vec::<(&str, Tag)>::new())).pos,
    // rust: [0, 1, 0]
    // rust: );
}

pub fn render_mode_and_box_follow_get_renderable_box() void {
}
    // rust: let mut block = StructureBlock::new(StructureMode::Save);
    // rust: block.pos = [0, 1, 0];
    // rust: block.size = [3, 2, 4];
    // rust: assert_eq!(block.render_mode(), RenderMode::Box);
    // rust: assert_eq!(
    // rust: block.renderable_box(),
    // rust: RenderableBox {
    // rust: offset: [0, 1, 0],
    // rust: size: [3, 2, 4]
}
    // rust: );
    // rust: block.rotation = Rotation::Clockwise90;
    // rust: assert_eq!(
    // rust: block.renderable_box(),
    // rust: RenderableBox {
    // rust: offset: [-3, 1, 0],
    // rust: size: [4, 2, 3]
}
    // rust: );
    // rust: block.rotation = Rotation::None;
    // rust: block.mirror = Mirror::LeftRight;
    // rust: assert_eq!(
    // rust: block.renderable_box(),
    // rust: RenderableBox {
    // rust: offset: [0, 1, -3],
    // rust: size: [3, 2, 4]
}
    // rust: );
    // rust: block.show_air = true;
    // rust: assert_eq!(block.render_mode(), RenderMode::BoxAndInvisibleBlocks);
    // rust: block.mode = StructureMode::Load;
    // rust: block.show_bounding_box = false;
    // rust: assert_eq!(block.render_mode(), RenderMode::None);
    // rust: block.mode = StructureMode::Corner;
    // rust: assert_eq!(block.render_mode(), RenderMode::None);
}

pub fn corner_scan_matches_detect_size() void {
}
        // Two corners: their box; one corner: the box with the asking block.
    // rust: let (min, max) = StructureBlock::enclosing_box(&[[0, 0, 0], [5, 4, 6]], [2, 0, 2]).unwrap();
    // rust: assert_eq!((min, max), ([0, 0, 0], [5, 4, 6]));
    // rust: assert_eq!(
    // rust: StructureBlock::detected(min, max, [2, 0, 2]),
    // rust: Some(([-1, 1, -1], [4, 3, 5]))
    // rust: );
    // rust: let one = StructureBlock::enclosing_box(&[[0, 0, 0]], [3, 3, 3]).unwrap();
    // rust: assert_eq!(one, ([0, 0, 0], [3, 3, 3]));
    // rust: assert_eq!(StructureBlock::enclosing_box(&[], [0, 0, 0]), None);
        // A box of one block thickness is no structure.
    // rust: assert_eq!(
    // rust: StructureBlock::detected([0, 0, 0], [1, 5, 5], [0, 0, 0]),
    // rust: None
    // rust: );
}

pub fn identifiers_parse_like_try_parse() void {
}
    // rust: assert_eq!(parse_identifier("a/b").as_deref(), Some("minecraft:a/b"));
    // rust: assert_eq!(parse_identifier("my:house").as_deref(), Some("my:house"));
    // rust: assert_eq!(parse_identifier("Bad"), None);
    // rust: assert_eq!(parse_identifier("ns:"), None);
}
}
