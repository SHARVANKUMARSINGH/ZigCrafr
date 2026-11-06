//! Transpiled from Horizon Rust crate
//! Module: horizon-client_maps
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Maps (`EmptyMapItem`, `MapItem`, `MapItemSavedData`, `MapRenderer`):
//! creating a map centred on the player's grid cell, revealing it while held
//! (`MapItem.update`: dominant map colour per pixel, height and water-depth
//! shading, the dithered edge), the player marker, `data/minecraft/maps/<id>.dat` and
//! `maps/last_id.dat`, the 128x128 texture in an atlas slot, the two-handed
//! first-person view and maps in item frames.
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: blocks::{Fluid, MAP_COLORS},
    // rust: hud::{HudBatch, MAP_SLOTS, Rect, map_slot_sprite},
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
}
// use horizon_world::nbt::Tag;
// use std::collections::HashMap;

/// What a decoration is filed under in `MapItemSavedData.decorations` (a
/// `LinkedHashMap<String, MapDecoration>`): a player's marker by their
/// connection, the banner at a position (`MapBanner.getId`), a framed map's
/// frame by its entity (`getFrameKey`).
    // rust: pub(super) enum Key {
    // rust: Player(u32),
    /// An item's `minecraft:map_decorations` (an explorer map's target), or a
    /// decoration a server sent (`addClientSideDecorations`).
    // rust: Item,
    // rust: Banner([i32; 3]),
    // rust: Frame(i32),
}
/// A decoration (`MapDecoration`): sprite, map position (-128..127, half
/// pixels), rotation (0..15) and name, filed under its key.
    // rust: pub(super) struct Decoration {
    // rust: pub sprite: &'static str,
    // rust: pub x: i8,
    // rust: pub y: i8,
    // rust: pub rot: u8,
    // rust: pub name: Option<String>,
    // rust: pub key: Key,
}
/// A map as a native mod sees it when `native_map_decorations` is asked.
// Native mods read it; nothing in Horizon does.
pub const NativeMapInfo = struct {
    /// The map's id (`map_<id>`).
    id: i32,
    /// The map's centre block `[x, z]`.
    center: [i32,
    /// `MapItemSavedData.scale`: a map pixel is `1 << scale` blocks.
    scale: u8,
    /// The dimension the map shows (`minecraft:overworld`).
    dimension: *'a str,
    locked: bool,
    /// Whether it is drawn in an item frame, not held or on the cartography screen.
    in_frame: bool,
};
/// An icon a native mod puts on a map: the same place and pose as vanilla's
/// decorations (`MapDecoration`).
pub const NativeMapDecoration = struct {
    /// An atlas sprite: vanilla's `map/decorations/<name>`, or a content
    /// mod's texture. An unknown sprite is left out.
    sprite: []const u8,
    /// The position on the map in half map pixels, -128 (left, top) to 127.
    /// For the world position `(wx, wz)`: `(wx - center_x) / (1 << scale) * 2`,
    /// and the same for z, floored and clamped.
    x: i8,
    y: i8,
    /// 0 to 15, in 22.5 degree steps clockwise (only the low four bits count).
    rot: u8,
    /// Whether it shows in an item frame and on the cartography screen
    /// (`MapDecorationType.showOnItemFrame`); a held map shows all.
    shown_on_frame: bool,
};

/// `MapBanner`: a banner a map marks, as `banners` saves it.
    // rust: pub(super) struct MapBanner {
    // rust: pub pos: [i32; 3],
    /// `DyeColor.getName` of the banner's base colour.
    // rust: pub color: String,
    // rust: pub name: Option<String>,
}
    // rust: impl MapBanner {
    /// `MapBanner.getDecoration`: the marker of the banner's colour.
pub fn sprite(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: decoration_sprite(&format!("banner_{}", self.color)).unwrap_or(BANNER_WHITE)
}
    /// `MapBanner.CODEC`.
pub fn to_nbt(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries = vec![
    // rust: ("pos", Tag::IntArray(self.pos.to_vec())),
    // rust: ("color", Tag::String(self.color.as_str().into())),
    // rust: ];
    // rust: if let Some(name) = &self.name {
    // rust: entries.push(("name", Tag::String(name.as_str().into())));
}
    // rust: Tag::compound(entries)
}
pub fn from_nbt(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
        // DyeColor.CODEC is read leniently: white when missing or unknown.
    // rust: let color = horizon_client::save::text(tag.get("color"))
    // rust: .filter(|c| decoration_sprite(&format!("banner_{c}")).is_some())
    // rust: .unwrap_or_else(|| "white".to_owned());
    // rust: Some(Self {
    // rust: pos: block_pos(tag.get("pos"))?,
    // rust: color,
    // rust: name: horizon_client::save::text(tag.get("name")),
    // rust: })
}
}
/// `MapFrame`: an item frame a map hangs in, as `frames` saves it.
    // rust: pub(super) struct MapFrame {
    // rust: pub pos: [i32; 3],
    /// The frame's `Direction.get2DDataValue` times 90.
    // rust: pub rotation: i32,
    // rust: pub entity_id: i32,
}
    // rust: impl MapFrame {
    /// `MapFrame.CODEC`.
pub fn to_nbt(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([
    // rust: ("pos", Tag::IntArray(self.pos.to_vec())),
    // rust: ("rotation", Tag::Int(self.rotation)),
    // rust: ("entity_id", Tag::Int(self.entity_id)),
    // rust: ])
}
pub fn from_nbt(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let int = |k: &str| horizon_client::save::number(tag.get(k)).map(|v| v as i32);
    // rust: Some(Self {
    // rust: pos: block_pos(tag.get("pos"))?,
    // rust: rotation: int("rotation")?,
    // rust: entity_id: int("entity_id")?,
    // rust: })
}
}
/// `BlockPos.CODEC`: three ints, as an int array or a list.
pub fn block_pos(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag? {
    // rust: Tag::IntArray(v) if v.len() == 3 => Some([v[0], v[1], v[2]]),
    // rust: Tag::List(l) if l.len() == 3 => {
    // rust: let int = |t: &Tag| match t {
    // rust: Tag::Int(v) => Some(*v),
    // rust: _ => None,
}
    // rust: Some([int(&l[0])?, int(&l[1])?, int(&l[2])?])
}
    // rust: _ => None,
}
}
/// The item frame a map hangs in, as `tickCarriedBy` reads it
/// (`placedInFrame`): the block it is in, its `Direction.get3DDataValue`
/// (down 0, up 1, north 2, south 3, west 4, east 5) and its entity id.
pub const Framed = struct {
    pos: [i32,
    facing: u8,
    id: i32,
};
/// `Direction.get2DDataValue` of a 3D data value: south 0, west 1, north 2,
/// east 3, and -1 for up and down.
pub fn direction_2d(facing: u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match facing {
    // rust: 3 => 0,
    // rust: 4 => 1,
    // rust: 2 => 2,
    // rust: 5 => 3,
    // rust: _ => -1,
}
}
/// The host among a map's holders (the guests are their connections).
pub const HOST: u32 = u32::MAX;
/// `MapDecorationTypes` the markers use: the player's arrow, the arrows that
/// replace it past the map's edge, the item frame's, the white banner's (the
/// fallback colour).
pub const PLAYER: []const u8 = "map/decorations/player";
pub const FRAME: []const u8 = "map/decorations/frame";
pub const BANNER_WHITE: []const u8 = "map/decorations/white_banner";
pub const PLAYER_OFF_MAP: []const u8 = "map/decorations/player_off_map";
pub const PLAYER_OFF_LIMITS: []const u8 = "map/decorations/player_off_limits";
/// A player carrying a map, or seeing it framed
/// (`MapItemSavedData.HoldingPlayer`): the column sweep's step, and what
/// changed since the last `ClientboundMapItemDataPacket` it was sent.
pub const Holder = struct {
    who: u32,
    /// The last tick it carried the map, and saw it framed.
    carried: i64,
    framed: i64,
    step: i32,
    /// The changed pixels' box (min x, min y, max x, max y).
    dirty: Option<[i32,
    decorations: bool,
    tick: u32,
    /// Wore map invisibility gear on its last tick
    /// (`MapItemSavedData.hasMapInvisibilityItemEquipped`).
    invisible: bool,
};
    // rust: impl Holder {
pub fn new(who: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: who,
    // rust: carried: 0,
    // rust: framed: 0,
    // rust: step: 0,
    // rust: dirty: Some([0, 0, 127, 127]),
    // rust: decorations: true,
    // rust: tick: 0,
    // rust: invisible: false,
}
}
    /// Still carrying the map, or seeing it framed (frames tick every 10).
pub fn holds(self: *Self, now: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.carried + 1 >= now || self.framed + 10 >= now
}
}
    // rust: pub(super) struct MapData {
    // rust: pub center: [i32; 2],
    // rust: pub scale: u8,
    // rust: pub dimension: String,
    // rust: pub locked: bool,
    // rust: pub tracking: bool,
    // rust: pub unlimited: bool,
    // rust: pub colors: Vec<u8>,
    // rust: pub decorations: Vec<Decoration>,
    /// `bannerMarkers` and `frameMarkers` (`banners`, `frames` when saved).
    // rust: pub banners: Vec<MapBanner>,
    // rust: frames: Vec<MapFrame>,
    // rust: holders: Vec<Holder>,
    /// Changed since the last save / texture upload.
    // rust: dirty: bool,
    // rust: texture_dirty: bool,
}
    // rust: impl MapData {
    /// `MapItemSavedData.createFresh`: centred on the scale's grid cell.
    // rust: pub(super) fn fresh(x: f64, z: f64, scale: u8, dimension: &str) -> Self {
    // rust: let size = 128 * (1 << scale);
    // rust: let cell = |v: f64| (v.floor() as i32 + 64).div_euclid(size) * size + size / 2 - 64;
    // rust: Self {
    // rust: center: [cell(x), cell(z)],
    // rust: scale,
    // rust: dimension: dimension.to_owned(),
    // rust: locked: false,
    // rust: tracking: true,
    // rust: unlimited: false,
    // rust: colors: vec![0; 128 * 128],
    // rust: decorations: Vec::new(),
    // rust: banners: Vec::new(),
    // rust: frames: Vec::new(),
    // rust: holders: Vec::new(),
    // rust: dirty: true,
    // rust: texture_dirty: true,
}
}
pub fn update_color(self: *Self, x: i32, y: i32, color: u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = (x + y * 128) as usize;
    // rust: if self.colors[i] == color {
    // rust: return false;
}
    // rust: self.colors[i] = color;
    // rust: self.dirty = true;
    // rust: self.texture_dirty = true;
        // setColorsDirty: every holder's next packet carries it.
    // rust: for h in &mut self.holders {
    // rust: h.dirty = Some(match h.dirty {
    // rust: Some([x0, y0, x1, y1]) => [x0.min(x), y0.min(y), x1.max(x), y1.max(y)],
    // rust: None => [x, y, x, y],
    // rust: });
}
    // rust: true
}
    /// `tickCarriedBy`'s holder for `who`, added when new.
pub fn holder(self: *Self, who: u32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = match self.holders.iter().position(|h| h.who == who) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: self.holders.push(Holder::new(who));
    // rust: self.holders.len() - 1
}
}
    // rust: &mut self.holders[i]
}
    /// The holders that no longer carry the map nor see it framed go, and
    /// their markers with them (`tickCarriedBy`'s removeDecoration).
pub fn drop_holders(self: *Self, now: i64) void {
}
    // rust: self.holders.retain(|h| h.holds(now));
    // rust: let holders = &self.holders;
    // rust: let before = self.decorations.len();
    // rust: self.decorations.retain(|d| match d.key {
    // rust: Key::Player(w) => holders.iter().any(|h| h.who == w),
    // rust: _ => true,
    // rust: });
    // rust: if self.decorations.len() != before {
    // rust: self.decorations_changed();
}
}
    /// setDecorationsDirty.
pub fn decorations_changed(self: *Self) void {
}
    // rust: for h in &mut self.holders {
    // rust: h.decorations = true;
}
}
    /// `MapItemSavedData.removeDecoration`: whatever `key` names goes, and
    /// every holder is told the decorations changed, found or not.
pub fn remove_decoration(self: *Self, key: Key) void {
}
    // rust: self.decorations.retain(|d| d.key != key);
    // rust: self.decorations_changed();
}
    /// `MapItemSavedData.addDecoration` with `calculateDecorationLocationAndType`
    /// and `calculateRotation`: `sprite` at the world position `x_pos`,
    /// `z_pos` under `key`, in place when the key has a decoration so that the
    /// order (the drawing order) stays. A position off the map leaves it out
    /// (a player's turns into an off-map arrow, then nothing past 320 without
    /// unlimited tracking) and removes what the key had. `game_time` is the
    /// level's: without a level the Nether's spinning rotation is not used.
    // rust: fn add_decoration(
    // rust: &mut self,
    // rust: sprite: &'static str,
    // rust: game_time: Option<i64>,
    // rust: key: Key,
    // rust: x_pos: f64,
    // rust: z_pos: f64,
    // rust: y_rot: f64,
    // rust: name: Option<String>,
    // rust: ) {
    // rust: let scaling = (1 << self.scale) as f32;
    // rust: let dx = (x_pos - f64::from(self.center[0])) as f32 / scaling;
    // rust: let dz = (z_pos - f64::from(self.center[1])) as f32 / scaling;
    // rust: let inside = (-63.0..=63.0).contains(&dx) && (-63.0..=63.0).contains(&dz);
    // rust: let shown = if sprite != PLAYER {
    // rust: (inside || self.unlimited).then_some(sprite)
    // rust: } else if inside {
    // rust: Some(sprite)
    // rust: } else if dx.abs() < 320.0 && dz.abs() < 320.0 {
    // rust: Some(PLAYER_OFF_MAP)
    // rust: } else {
    // rust: self.unlimited.then_some(PLAYER_OFF_LIMITS)
}
    // rust: let Some(sprite) = shown else {
    // rust: self.remove_decoration(key);
    // rust: return;
}
    // rust: let spinning = self.dimension == "minecraft:the_nether" && game_time.is_some();
    // rust: let decoration = Decoration {
    // rust: sprite,
    // rust: x: clamp_map_coordinate(dx),
    // rust: y: clamp_map_coordinate(dz),
    // rust: rot: decoration_rotation(spinning, game_time.unwrap_or(0), y_rot),
    // rust: name,
    // rust: key,
}
    // rust: match self.decorations.iter().position(|d| d.key == key) {
    // rust: Some(i) if self.decorations[i] == decoration => {}
    // rust: Some(i) => {
    // rust: self.decorations[i] = decoration;
    // rust: self.decorations_changed();
}
    // rust: None => {
    // rust: self.decorations.push(decoration);
    // rust: self.decorations_changed();
}
}
}
    /// `MapItemSavedData.tickCarriedBy`'s check on every holder but `who`, the
    /// player ticking: one wearing map invisibility gear has no marker.
pub fn hide_invisible(self: *Self, who: u32) void {
}
    // rust: let hidden: Vec<u32> = self
    // rust: .holders
    // rust: .iter()
    // rust: .filter(|h| h.who != who && h.invisible)
    // rust: .map(|h| h.who)
    // rust: .collect();
    // rust: for w in hidden {
    // rust: self.remove_decoration(Key::Player(w));
}
}
    /// `MapItemSavedData.tickCarriedBy` with `placedInFrame`, for `who`, a
    /// player in the level of `frame`, the item frame holding the map.
    /// `carries` is whether their inventory holds the map (`mapMatcher`),
    /// `invisible` whether they wear map invisibility gear. Without a carried
    /// copy the player has no marker; the frame gets its own, which replaces
    /// the marker of another frame entity remembered at the same block.
pub fn tick_framed(self: *Self, who: u32, now: i64, carries: bool, invisible: bool, frame: Framed) void {
}
    // rust: let h = self.holder(who);
    // rust: h.framed = now;
    // rust: h.invisible = invisible;
    // rust: if !carries {
    // rust: self.remove_decoration(Key::Player(who));
}
    // rust: self.hide_invisible(who);
    // rust: if !self.tracking {
    // rust: return;
}
    // rust: let pos = frame.pos;
    // rust: if let Some(old) = self.frames.iter().find(|f| f.pos == pos).copied()
    // rust: && old.entity_id != frame.id
    // rust: {
    // rust: self.remove_decoration(Key::Frame(old.entity_id));
}
    // rust: let rotation = direction_2d(frame.facing) * 90;
    // rust: let (x, z) = (f64::from(pos[0]), f64::from(pos[2]));
    // rust: let key = Key::Frame(frame.id);
    // rust: self.add_decoration(FRAME, Some(now), key, x, z, f64::from(rotation), None);
    // rust: let marker = MapFrame {
    // rust: pos,
    // rust: rotation,
    // rust: entity_id: frame.id,
}
    // rust: match self.frames.iter().position(|f| f.pos == pos) {
    // rust: Some(i) if self.frames[i] == marker => {}
    // rust: Some(i) => {
    // rust: self.frames[i] = marker;
    // rust: self.dirty = true;
}
    // rust: None => {
    // rust: self.frames.push(marker);
    // rust: self.dirty = true;
}
}
}
    /// `MapItemSavedData.removedFromFrame`: the frame entity's marker goes,
    /// and the frame remembered at its block.
pub fn removed_from_frame(self: *Self, pos: [i32; 3], entity_id: i32) void {
}
    // rust: self.remove_decoration(Key::Frame(entity_id));
    // rust: self.frames.retain(|f| f.pos != pos);
    // rust: self.dirty = true;
}
    /// `MapItemSavedData.isTrackedCountOverLimit`: more than `limit`
    /// decorations count (`MapDecorationType.trackCount`).
pub fn tracked_over_limit(self: *Self, limit: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.decorations
    // rust: .iter()
    // rust: .filter(|d| tracks_count(d.sprite))
    // rust: .count()
    // rust: > limit
}
    /// `MapItemSavedData.toggleBanner`: a banner inside the map that has no
    /// marker gets one (unless the map tracks too many), one whose marker is
    /// there as it stands loses it, and a changed banner's marker is renewed.
    /// `current` is the banner at `pos` (`MapBanner.fromWorld`); true when
    /// the markers changed.
pub fn toggle_banner(self: *Self, pos: [i32; 3], current: ?MapBanner, game_time: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x_pos, z_pos) = (f64::from(pos[0]) + 0.5, f64::from(pos[2]) + 0.5);
    // rust: let scale = f64::from(1 << self.scale);
    // rust: let xd = (x_pos - f64::from(self.center[0])) / scale;
    // rust: let yd = (z_pos - f64::from(self.center[1])) / scale;
    // rust: if !(xd >= -63.0 && yd >= -63.0 && xd <= 63.0 && yd <= 63.0) {
    // rust: return false;
}
    // rust: let Some(banner) = current else {
    // rust: return false;
}
    // rust: if let Some(i) = self.banners.iter().position(|b| *b == banner) {
    // rust: self.banners.remove(i);
    // rust: self.remove_decoration(Key::Banner(pos));
    // rust: self.dirty = true;
    // rust: return true;
}
    // rust: if self.tracked_over_limit(256) {
    // rust: return false;
}
    // rust: self.banners.retain(|b| b.pos != pos);
    // rust: self.banners.push(banner.clone());
    // rust: let sprite = banner.sprite();
    // rust: self.add_decoration(
    // rust: sprite,
    // rust: Some(game_time),
    // rust: Key::Banner(pos),
    // rust: x_pos,
    // rust: z_pos,
    // rust: 180.0,
    // rust: banner.name,
    // rust: );
    // rust: self.dirty = true;
    // rust: true
}
    /// `MapItemSavedData.checkBanners`: a banner marker in the column `x`,
    /// `z` whose banner is gone or changed (`current` reads
    /// `MapBanner.fromWorld` at a position) is dropped with its decoration.
pub fn check_banners(self: *Self, x: i32, z: i32, current: impl Fn([i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stale: Vec<MapBanner> = self
    // rust: .banners
    // rust: .iter()
    // rust: .filter(|b| b.pos[0] == x && b.pos[2] == z && current(b.pos).as_ref() != Some(*b))
    // rust: .cloned()
    // rust: .collect();
    // rust: for banner in stale {
    // rust: self.banners.retain(|b| *b != banner);
    // rust: self.remove_decoration(Key::Banner(banner.pos));
    // rust: self.dirty = true;
}
}
    /// `HoldingPlayer.nextUpdatePacket` for `who`: the changed pixels, and
    /// the decorations (at most every 5th call while they changed).
    // rust: fn update_packet(
    // rust: &mut self,
    // rust: id: i32,
    // rust: who: u32,
    // rust: kind: impl Fn(&str) -> Option<i32>,
    // rust: ) -> Option<horizon_protocol::packets::play::MapItemData> {
//         use horizon_protocol::packets::play::{MapDecoration, MapItemData, MapPatch};
    // rust: let h = self.holders.iter_mut().find(|h| h.who == who)?;
    // rust: let patch = h.dirty.take().map(|[x0, y0, x1, y1]| {
    // rust: let (width, height) = (x1 + 1 - x0, y1 + 1 - y0);
    // rust: let mut colors = Vec::with_capacity((width * height) as usize);
    // rust: for y in 0..height {
    // rust: for x in 0..width {
    // rust: colors.push(self.colors[(x0 + x + (y0 + y) * 128) as usize]);
}
}
    // rust: MapPatch {
    // rust: start_x: x0,
    // rust: start_y: y0,
    // rust: width,
    // rust: height,
    // rust: colors,
}
    // rust: });
    // rust: let decorations = if h.decorations && {
    // rust: let due = h.tick % 5 == 0;
    // rust: h.tick += 1;
    // rust: due
    // rust: } {
    // rust: h.decorations = false;
    // rust: Some(
    // rust: self.decorations
    // rust: .iter()
    // rust: .filter_map(|d| {
    // rust: Some(MapDecoration {
    // rust: kind: kind(decoration_type(d.sprite)?)?,
    // rust: x: d.x,
    // rust: y: d.y,
    // rust: rot: d.rot as i8,
    // rust: name: d.name.as_ref().map(|n| Tag::String(n.as_str().into())),
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: } else {
    // rust: None
}
    // rust: (patch.is_some() || decorations.is_some()).then_some(MapItemData {
    // rust: map_id: id,
    // rust: scale: self.scale as i8,
    // rust: locked: self.locked,
    // rust: decorations,
    // rust: patch,
    // rust: })
}
    /// `MapItemSavedData.<clinit>`: the CODEC save arm omits optional defaults.
    // rust: pub(super) fn to_nbt(&self) -> Tag {
    // rust: let mut data = vec![
    // rust: ("dimension", Tag::String(self.dimension.as_str().into())),
    // rust: ("xCenter", Tag::Int(self.center[0])),
    // rust: ("zCenter", Tag::Int(self.center[1])),
    // rust: ("colors", Tag::ByteArray(self.colors.clone())),
    // rust: ];
    // rust: if self.scale != 0 {
    // rust: data.push(("scale", Tag::Byte(self.scale as i8)));
}
    // rust: for (key, value, default) in [
    // rust: ("locked", self.locked, false),
    // rust: ("trackingPosition", self.tracking, true),
    // rust: ("unlimitedTracking", self.unlimited, false),
    // rust: ] {
    // rust: if value != default {
    // rust: data.push((key, Tag::Byte(i8::from(value))));
}
}
    // rust: if !self.banners.is_empty() {
    // rust: data.push((
    // rust: "banners",
    // rust: Tag::List(self.banners.iter().map(MapBanner::to_nbt).collect()),
    // rust: ));
}
    // rust: if !self.frames.is_empty() {
    // rust: data.push((
    // rust: "frames",
    // rust: Tag::List(self.frames.iter().copied().map(MapFrame::to_nbt).collect()),
    // rust: ));
}
    // rust: Tag::compound([
    // rust: ("data", Tag::compound(data)),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ])
}
pub fn from_nbt(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = tag.get("data")?;
    // rust: let int = |k: &str| match d.get(k) {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: Some(Tag::Byte(v)) => Some(i32::from(*v)),
    // rust: _ => None,
}
    // rust: let dimension = match d.get("dimension") {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: _ => "minecraft:overworld".to_owned(),
}
    // rust: let mut colors = match d.get("colors") {
    // rust: Some(Tag::ByteArray(c)) => c.clone(),
    // rust: _ => Vec::new(),
}
    // rust: colors.resize(128 * 128, 0);
    // rust: let list = |k: &str| match d.get(k) {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
    // rust: let mut map = Self {
    // rust: center: [int("xCenter")?, int("zCenter")?],
    // rust: scale: int("scale").unwrap_or(0).clamp(0, 4) as u8,
    // rust: dimension,
    // rust: locked: int("locked").unwrap_or(0) != 0,
    // rust: tracking: int("trackingPosition").unwrap_or(1) != 0,
    // rust: unlimited: int("unlimitedTracking").unwrap_or(0) != 0,
    // rust: colors,
    // rust: decorations: Vec::new(),
    // rust: banners: list("banners")
    // rust: .iter()
    // rust: .filter_map(MapBanner::from_nbt)
    // rust: .collect(),
    // rust: frames: list("frames")
    // rust: .iter()
    // rust: .filter_map(MapFrame::from_nbt)
    // rust: .collect(),
    // rust: holders: Vec::new(),
    // rust: dirty: false,
    // rust: texture_dirty: true,
}
        // The constructor adds each marker without a level: no Nether spin.
    // rust: for b in map.banners.clone() {
    // rust: let (x, z) = (f64::from(b.pos[0]), f64::from(b.pos[2]));
    // rust: map.add_decoration(b.sprite(), None, Key::Banner(b.pos), x, z, 180.0, b.name);
}
    // rust: for f in map.frames.clone() {
    // rust: let (x, z) = (f64::from(f.pos[0]), f64::from(f.pos[2]));
    // rust: let rotation = f64::from(f.rotation);
    // rust: map.add_decoration(FRAME, None, Key::Frame(f.entity_id), x, z, rotation, None);
}
    // rust: Some(map)
}
}
    // rust: pub(super) struct Maps {
    // rust: pub data: HashMap<i32, MapData>,
    /// The highest map id handed out (`maps/last_id.dat`), loaded on first use.
    // rust: last_id: Option<i32>,
    /// The atlas slots holding map textures.
    // rust: pub slots: super::atlas_slots::AtlasSlots<i32>,
    // rust: missing: std::collections::HashSet<i32>,
}
    // rust: impl Default for Maps {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: data: HashMap::new(),
    // rust: last_id: None,
    // rust: slots: super::atlas_slots::AtlasSlots::new(MAP_SLOTS),
    // rust: missing: Default::default(),
}
}
}
/// `MapColor.getColorFromPackedId` as RGBA bytes (NONE is transparent).
pub fn packed_rgba(packed: u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = usize::from(packed >> 2);
    // rust: if id == 0 || id >= MAP_COLORS.len() {
    // rust: return [0; 4];
}
    // rust: let modifier = [180u32, 220, 255, 135][usize::from(packed & 3)];
    // rust: let col = MAP_COLORS[id];
    // rust: let ch = |s: u32| ((col >> s & 255) * modifier / 255) as u8;
    // rust: [ch(16), ch(8), ch(0), 255]
}
/// `get(DataComponents.MAP_ID)`: the map id any stack carries. Filled maps
/// (explorer maps included) carry one; a command can give it to any item.
    // rust: pub(super) fn map_id(stack: &ItemStack) -> Option<i32> {
    // rust: stack.data().and_then(|d| d.map_id)
}
/// `MapDecorationTypes` Horizon draws: (type, sprite).
    // rust: const DECORATION_TYPES: [(&str, &str); 40] = [
    // rust: ("player", "map/decorations/player"),
    // rust: ("frame", "map/decorations/frame"),
    // rust: ("red_marker", "map/decorations/red_marker"),
    // rust: ("blue_marker", "map/decorations/blue_marker"),
    // rust: ("target_x", "map/decorations/target_x"),
    // rust: ("target_point", "map/decorations/target_point"),
    // rust: ("player_off_map", "map/decorations/player_off_map"),
    // rust: ("player_off_limits", "map/decorations/player_off_limits"),
    // rust: ("mansion", "map/decorations/woodland_mansion"),
    // rust: ("monument", "map/decorations/ocean_monument"),
    // rust: ("banner_white", "map/decorations/white_banner"),
    // rust: ("banner_orange", "map/decorations/orange_banner"),
    // rust: ("banner_magenta", "map/decorations/magenta_banner"),
    // rust: ("banner_light_blue", "map/decorations/light_blue_banner"),
    // rust: ("banner_yellow", "map/decorations/yellow_banner"),
    // rust: ("banner_lime", "map/decorations/lime_banner"),
    // rust: ("banner_pink", "map/decorations/pink_banner"),
    // rust: ("banner_gray", "map/decorations/gray_banner"),
    // rust: ("banner_light_gray", "map/decorations/light_gray_banner"),
    // rust: ("banner_cyan", "map/decorations/cyan_banner"),
    // rust: ("banner_purple", "map/decorations/purple_banner"),
    // rust: ("banner_blue", "map/decorations/blue_banner"),
    // rust: ("banner_brown", "map/decorations/brown_banner"),
    // rust: ("banner_green", "map/decorations/green_banner"),
    // rust: ("banner_red", "map/decorations/red_banner"),
    // rust: ("banner_black", "map/decorations/black_banner"),
    // rust: ("red_x", "map/decorations/red_x"),
    // rust: ("village_desert", "map/decorations/desert_village"),
    // rust: ("village_plains", "map/decorations/plains_village"),
    // rust: ("village_savanna", "map/decorations/savanna_village"),
    // rust: ("village_snowy", "map/decorations/snowy_village"),
    // rust: ("village_taiga", "map/decorations/taiga_village"),
    // rust: ("jungle_temple", "map/decorations/jungle_temple"),
    // rust: ("swamp_hut", "map/decorations/swamp_hut"),
    // rust: ("trial_chambers", "map/decorations/trial_chambers"),
    // rust: ("abandoned_camp", "map/decorations/abandoned_camp"),
    // rust: ("ancient_city", "map/decorations/ancient_city"),
    // rust: ("desert_pyramid", "map/decorations/desert_pyramid"),
    // rust: ("mineshaft", "map/decorations/mineshaft"),
    // rust: ("ocean_ruin_warm", "map/decorations/warm_ocean_ruins"),
    // rust: ];
/// `MapDecorationType.showOnItemFrame` is false for the player arrows and the two markers.
/// `MapRenderer.render`'s pose for decoration `d` in map pixels (0..128,
/// y down) at depth `z`: its quad is (-1, -1) to (1, 1) under it.
    // rust: pub(super) fn decoration_pose(d: &Decoration, z: f32) -> glam::Mat4 {
    // rust: decoration_pose_at(d.x, d.y, d.rot, z)
}
/// [`decoration_pose`] for a decoration at `x`, `y` (half map pixels) turned `rot`.
    // rust: pub(super) fn decoration_pose_at(x: i8, y: i8, rot: u8, z: f32) -> glam::Mat4 {
    // rust: glam::Mat4::from_translation(glam::Vec3::new(
    // rust: f32::from(x) / 2.0 + 64.0,
    // rust: f32::from(y) / 2.0 + 64.0,
    // rust: z,
    // rust: )) * glam::Mat4::from_rotation_z((f32::from(rot) * 360.0 / 16.0).to_radians())
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(4.0))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(-0.125, 0.125, 0.0))
}
    // rust: pub(super) fn shown_on_frame(sprite: &str) -> bool {
    // rust: !matches!(
    // rust: decoration_type(sprite),
    // rust: Some("player" | "red_marker" | "blue_marker" | "player_off_map" | "player_off_limits")
    // rust: )
}
/// `MapDecorationType.trackCount`: the players' arrows, the markers, the
/// frames and the banners count toward a map's limit, the structures do not.
pub fn tracks_count(sprite: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: decoration_type(sprite).is_some_and(|t| {
    // rust: t.starts_with("banner_")
    // rust: || matches!(
    // rust: t,
    // rust: "player"
    // rust: | "frame"
    // rust: | "red_marker"
    // rust: | "blue_marker"
    // rust: | "player_off_map"
    // rust: | "player_off_limits"
    // rust: )
    // rust: })
}
/// The sprite of a decoration type that a `minecraft:map_decorations`
/// entry or a server's packet names.
pub fn decoration_sprite(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = id.strip_prefix("minecraft:").unwrap_or(id);
    // rust: DECORATION_TYPES
    // rust: .iter()
    // rust: .find(|(n, _)| *n == name)
    // rust: .map(|(_, sprite)| *sprite)
}
/// The type a decoration's sprite stands for, as its registry names it.
pub fn decoration_type(sprite: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: DECORATION_TYPES
    // rust: .iter()
    // rust: .find(|(_, s)| *s == sprite)
    // rust: .map(|(name, _)| *name)
}
/// `minecraft:map_decorations` of a map item: (sprite, x, z, rotation), in
/// the component's order.
pub fn static_decorations(stack: *ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::Compound(entries)) = stack.data().and_then(|d| {
    // rust: d.other
    // rust: .iter()
    // rust: .find(|(k, _)| k == "minecraft:map_decorations")
    // rust: .map(|(_, t)| t)
    // rust: }) else {
    // rust: return Vec::new();
}
    // rust: let number = |t: Option<&Tag>| match t {
    // rust: Some(Tag::Double(b)) => Some(f64::from_bits(*b)),
    // rust: Some(Tag::Float(b)) => Some(f64::from(f32::from_bits(*b))),
    // rust: Some(Tag::Int(v)) => Some(f64::from(*v)),
    // rust: _ => None,
}
    // rust: entries
    // rust: .values()
    // rust: .filter_map(|e| {
    // rust: let sprite = match e.get("type") {
    // rust: Some(Tag::String(s)) => decoration_sprite(&s.to_string_lossy())?,
    // rust: _ => return None,
}
    // rust: Some((
    // rust: sprite,
    // rust: number(e.get("x"))?,
    // rust: number(e.get("z"))?,
    // rust: number(e.get("rotation")).unwrap_or(0.0) as f32,
    // rust: ))
    // rust: })
    // rust: .collect()
}
/// `MapItemSavedData.addTargetDecoration`: the `"+"` entry of
/// `minecraft:map_decorations`, rotation 180.
pub fn target_decoration(decoration: []const u8, at: [i32; 3]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([(
    // rust: "+",
    // rust: Tag::compound([
    // rust: ("type", Tag::String(decoration.into())),
    // rust: ("x", Tag::Double(f64::from(at[0]).to_bits())),
    // rust: ("z", Tag::Double(f64::from(at[2]).to_bits())),
    // rust: ("rotation", Tag::Float(180.0f32.to_bits())),
    // rust: ]),
    // rust: )])
}
/// `MapItemSavedData.clampMapCoordinate`.
pub fn clamp_map_coordinate(d: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if d <= -63.0 {
    // rust: -128
    // rust: } else if d >= 63.0 {
    // rust: 127
    // rust: } else {
    // rust: (d * 2.0 + 0.5) as i8
}
}
/// `MapItemSavedData.calculateRotation`: spinning in the Nether.
pub fn decoration_rotation(nether: bool, game_time: i64, y_rot: f64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if nether {
    // rust: let s = (game_time / 10) as i32;
    // rust: (s.wrapping_mul(s)
    // rust: .wrapping_mul(34_187_121)
    // rust: .wrapping_add(s.wrapping_mul(121))
    // rust: >> 15
    // rust: & 15) as u8
    // rust: } else {
    // rust: let adjusted = if y_rot < 0.0 {
    // rust: y_rot - 8.0
    // rust: } else {
    // rust: y_rot + 8.0
}
    // rust: ((adjusted * 16.0 / 360.0) as i32 & 15) as u8
}
}
    // rust: impl Game<'_> {
pub fn dimension_id(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.dim {
    // rust: super::Dim::Nether => "minecraft:the_nether",
    // rust: super::Dim::End => "minecraft:the_end",
    // rust: _ => "minecraft:overworld",
}
}
pub fn map_path(self: *Self, name: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_root.join("data/minecraft/maps").join(name)
}
    /// The map's data, loaded from `data/minecraft/maps/<id>.dat` on first use.
    // rust: pub(super) fn map(&mut self, id: i32) -> Option<&mut MapData> {
    // rust: if !self.maps.data.contains_key(&id) && !self.maps.missing.contains(&id) {
    // rust: let loaded = horizon_client::save::read_dat(&self.map_path(&format!("{id}.dat")))
    // rust: .and_then(|t| MapData::from_nbt(&t));
    // rust: match loaded {
    // rust: Some(m) => {
    // rust: self.maps.data.insert(id, m);
}
    // rust: None => {
    // rust: self.maps.missing.insert(id);
}
}
}
    // rust: self.maps.data.get_mut(&id)
}
    /// `ClientboundMapItemDataPacket.handle`: the server's colours and
    /// decorations for a map (one carried or framed on a server).
    // rust: pub(super) fn remote_map_item_data(
    // rust: &mut self,
    // rust: p: &horizon_protocol::packets::play::MapItemData,
    // rust: ) {
    // rust: let decorations = p.decorations.as_ref().map(|list| {
    // rust: let types = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.builtin.get("minecraft:map_decoration_type"));
    // rust: list.iter()
    // rust: .filter_map(|d| {
    // rust: Some(Decoration {
    // rust: sprite: decoration_sprite(types?.name(d.kind)?)?,
    // rust: x: d.x,
    // rust: y: d.y,
    // rust: rot: (d.rot & 15) as u8,
    // rust: name: d
    // rust: .name
    // rust: .as_ref()
    // rust: .map(|t| horizon_client::entity_nbt::name_text(t).plain()),
    // rust: key: Key::Item,
    // rust: })
    // rust: })
    // rust: .collect()
    // rust: });
    // rust: let dimension = self.dimension_id();
    // rust: let map = self
    // rust: .maps
    // rust: .data
    // rust: .entry(p.map_id)
    // rust: .or_insert_with(|| MapData::fresh(0.0, 0.0, p.scale.max(0) as u8, dimension));
    // rust: map.locked = p.locked;
    // rust: if let Some(decorations) = decorations {
    // rust: map.decorations = decorations;
}
    // rust: let Some(patch) = &p.patch else {
    // rust: map.dirty = false;
    // rust: return;
}
    // rust: for x in 0..patch.width {
    // rust: for y in 0..patch.height {
    // rust: let Some(&color) = patch.colors.get((x + y * patch.width) as usize) else {
    // rust: continue;
}
    // rust: let (px, py) = (patch.start_x + x, patch.start_y + y);
    // rust: if (0..128).contains(&px) && (0..128).contains(&py) {
    // rust: map.update_color(px, py, color);
}
}
}
        // The server owns a remote map: only the texture has to change.
    // rust: map.dirty = false;
}
pub fn next_map_id(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let last = *self.maps.last_id.get_or_insert_with(|| {
    // rust: horizon_client::save::read_dat(&self.world_root.join("data/minecraft/maps/last_id.dat"))
    // rust: .and_then(|t| match t.get("data")?.get("map")? {
    // rust: Tag::Int(v) => Some(*v),
    // rust: _ => None,
    // rust: })
    // rust: .unwrap_or(-1)
    // rust: });
    // rust: self.maps.last_id = Some(last + 1);
    // rust: last + 1
}
    /// The id the next new map gets, without taking it.
    // rust: pub(super) fn peek_map_id(&mut self) -> i32 {
    // rust: let id = self.next_map_id();
    // rust: self.maps.last_id = Some(id - 1);
    // rust: id
}
    /// Maps made by exploration map trades: (id, target, zoom, decoration).
    // rust: pub(super) fn register_exploration_maps(&mut self, made: Vec<(i32, [i32; 3], u8, String)>) {
    // rust: let dimension = self.dimension_id().to_owned();
    // rust: for (id, at, zoom, _) in made {
            // MapItem.applyNewSavedData: tracking, unlimited tracking.
    // rust: let mut data = MapData::fresh(f64::from(at[0]), f64::from(at[2]), zoom, &dimension);
    // rust: data.unlimited = true;
    // rust: self.maps.data.insert(id, data);
    // rust: let last = self.maps.last_id.unwrap_or(-1).max(id);
    // rust: self.maps.last_id = Some(last);
    // rust: self.render_biome_preview(id);
}
}
    /// `ExplorationMapFunction.run` for an item a generated chest still holds
    /// unsearched (`structure_blocks::take_pending_map`): the nearest
    /// structure of the tag around `origin`, a new map centred on it with its
    /// biome preview and target decoration. False when nothing is found: the
    /// loot table's `filtered` map_id check would have discarded the item.
    // rust: pub(super) fn resolve_pending_map(&mut self, item: &mut ItemStack, origin: [f64; 3]) -> bool {
    // rust: let Some(map) = horizon_client::structure_blocks::take_pending_map(item) else {
    // rust: return true;
}
    // rust: let names = self.structure_tag(&map.destination);
    // rust: let from = origin.map(|v| v.floor() as i32);
    // rust: let found = self
    // rust: .end
    // rust: .locator()
    // rust: .filter(|_| !names.is_empty())
    // rust: .and_then(|t| {
    // rust: t.locate_for_map(&names, from, map.search_radius, map.skip_existing_chunks)
    // rust: });
    // rust: let Some((_, at)) = found else {
    // rust: return false;
}
    // rust: let mut data = MapData::fresh(
    // rust: f64::from(at[0]),
    // rust: f64::from(at[2]),
    // rust: map.zoom,
    // rust: self.dimension_id(),
    // rust: );
    // rust: data.unlimited = true;
    // rust: let id = self.new_map_id(data);
    // rust: self.render_biome_preview(id);
    // rust: let d = item.data_mut();
    // rust: d.map_id = Some(id);
    // rust: d.other.retain(|(k, _)| k != "minecraft:map_decorations");
    // rust: d.other.push((
    // rust: "minecraft:map_decorations".into(),
    // rust: target_decoration(&map.decoration, at),
    // rust: ));
    // rust: true
}
    /// The unsearched exploration maps of a container being opened
    /// (`RandomizableContainer.unpackLootTable` runs the function then).
    // rust: pub(super) fn resolve_container_maps(&mut self, key: (i32, i32, i32), origin: [f64; 3]) {
//         use horizon_client::containers::BlockEntity;
    // rust: let Some(BlockEntity::Chest(slots)) = self.world.block_entities.get(&key) else {
    // rust: return;
}
    // rust: let pending: Vec<usize> = slots
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, s)| {
    // rust: s.as_ref()
    // rust: .is_some_and(horizon_client::structure_blocks::has_pending_map)
    // rust: })
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: for i in pending {
    // rust: let Some(BlockEntity::Chest(slots)) = self.world.block_entities.get_mut(&key) else {
    // rust: return;
}
    // rust: let Some(mut item) = slots[i].take() else {
    // rust: continue;
}
    // rust: let keep = self.resolve_pending_map(&mut item, origin);
    // rust: if let Some(BlockEntity::Chest(slots)) = self.world.block_entities.get_mut(&key) {
    // rust: slots[i] = keep.then_some(item);
}
}
}
    /// `MapItem.renderBiomePreviewMap`: the map's biomes at sea level, water
    /// outlines (`#water_on_map_outlines`) drawn in orange and brown.
    // rust: pub(super) fn render_biome_preview(&mut self, id: i32) {
    // rust: let Some(terrain) = self.end.locator() else {
    // rust: return;
}
    // rust: let dim = self.dimension_id();
    // rust: let zoom = self.streaming.biome_zoom;
    // rust: let watery_biomes: std::collections::HashSet<String> = self
    // rust: .tag_entries("worldgen/biome", "minecraft:water_on_map_outlines")
    // rust: .into_iter()
    // rust: .collect();
    // rust: let Some(m) = self.maps.data.get(&id) else {
    // rust: return;
}
    // rust: if m.dimension != dim {
    // rust: return;
}
    // rust: let scale = 1i32 << m.scale;
    // rust: let start_x = m.center[0] / scale - 64;
    // rust: let start_z = m.center[1] / scale - 64;
    // rust: let sea_level = 63;
    // rust: let quarts: Vec<[i32; 3]> = (0..128)
    // rust: .flat_map(|row| {
    // rust: (0..128).map(move |column| {
    // rust: zoom.quart_at_block(horizon_core::position::BlockPos::new(
    // rust: (start_x + column) * scale,
    // rust: sea_level,
    // rust: (start_z + row) * scale,
    // rust: ))
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let watery: Vec<bool> = terrain
    // rust: .noise_biomes(&quarts)
    // rust: .into_iter()
    // rust: .map(|b| b.is_some_and(|b| watery_biomes.contains(&b)))
    // rust: .collect();
    // rust: let is_watery = |x: i32, z: i32| watery[(z * 128 + x) as usize];
        // MapColor ids and MapColor.Brightness ids.
pub const ORANGE: u8 = 15;
pub const BROWN: u8 = 26;
pub const LOW: u8 = 0;
pub const NORMAL: u8 = 1;
pub const HIGH: u8 = 2;
pub const LOWEST: u8 = 3;
    // rust: let Some(m) = self.maps.data.get_mut(&id) else {
    // rust: return;
}
    // rust: for mx in 1..127 {
    // rust: for mz in 1..127 {
    // rust: let mut water_count = 0;
    // rust: for dx in -1..2 {
    // rust: for dz in -1..2 {
    // rust: if (dx != 0 || dz != 0) && is_watery(mx + dx, mz + dz) {
    // rust: water_count += 1;
}
}
}
    // rust: let mut brightness = LOWEST;
    // rust: let mut color = 0;
    // rust: if is_watery(mx, mz) {
    // rust: color = ORANGE;
    // rust: if water_count > 7 && mz % 2 == 0 {
    // rust: let sin = horizon_core::geometry::trig::sin(f64::from(mz as f32 + 0.0));
    // rust: match (mx + (sin * 7.0) as i32) / 8 % 5 {
    // rust: 0 | 4 => brightness = LOW,
    // rust: 1 | 3 => brightness = NORMAL,
    // rust: 2 => brightness = HIGH,
    // rust: _ => {}
}
    // rust: } else if water_count > 7 {
    // rust: color = 0;
    // rust: } else if water_count > 5 {
    // rust: brightness = NORMAL;
    // rust: } else if water_count > 1 {
    // rust: brightness = LOW;
}
    // rust: } else if water_count > 0 {
    // rust: color = BROWN;
    // rust: brightness = if water_count > 3 { NORMAL } else { LOWEST };
}
    // rust: if color != 0 {
    // rust: m.update_color(mx, mz, color << 2 | brightness);
}
}
}
}
    /// Registers `data` under a free map id.
    // rust: pub(super) fn new_map_id(&mut self, data: MapData) -> i32 {
    // rust: let id = self.next_map_id();
    // rust: self.maps.data.insert(id, data);
    // rust: id
}
    /// `EmptyMapItem.use`: a new map centred around the player.
    // rust: pub(super) fn use_empty_map(&mut self, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:map" {
    // rust: return false;
}
    // rust: let Some(p) = self.player.as_ref().map(|p| p.position) else {
    // rust: return false;
}
    // rust: let id = self.next_map_id();
    // rust: let data = MapData::fresh(p.x, p.z, 0, self.dimension_id());
    // rust: self.maps.data.insert(id, data);
    // rust: let mut filled = ItemStack::new("minecraft:filled_map", 1);
    // rust: filled.data_mut().map_id = Some(id);
    // rust: if self.creative {
    // rust: self.give_or_drop_stack(filled);
    // rust: } else if stack.count == 1 {
    // rust: *self.held_mut() = Some(filled);
    // rust: } else {
    // rust: self.consume_held();
    // rust: self.give_or_drop_stack(filled);
}
        // EmptyMapItem.use: consumed, then counted.
    // rust: self.award_stat("used", "minecraft:map", 1);
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: self.native_player_map_filled(player, &name, id);
}
    // rust: self.play_player_bound_sound(
    // rust: "minecraft:ui.cartography_table.take_result",
    // rust: 7,
    // rust: 1.0,
    // rust: 1.0,
    // rust: false,
    // rust: );
    // rust: self.swing_arm();
    // rust: true
}
    /// `ItemFrame.removeFramedMap`: the map `frame` holds forgets the frame.
    // rust: pub(super) fn remove_framed_map(&mut self, frame: &horizon_client::entities::ItemFrame) {
    // rust: let Some(id) = frame.item.as_ref().and_then(map_id) else {
    // rust: return;
}
    // rust: if let Some(m) = self.map(id) {
    // rust: m.removed_from_frame(frame.pos, frame.id as i32);
}
}
    /// `MapItem.useOn`: a map used on a banner toggles that banner's marker
    /// on the map; when the map's data says no (`toggleBanner` fails) the use
    /// ends without a swing, and nothing else is done with the map either way.
    // rust: pub(super) fn use_map_on_banner(&mut self, hit: &super::Hit, stack: &ItemStack) -> bool {
    // rust: let Some(id) = map_id(stack) else {
    // rust: return false;
}
    // rust: if !self.may_build() && !self.can_place_on_in_adventure(hit.pos) {
    // rust: return false;
}
    // rust: let [x, y, z] = hit.pos;
    // rust: let block = self.res.facts().get(self.world.block(x, y, z)).name.clone();
    // rust: if !self.block_in_tag("minecraft:banners", &block) {
    // rust: return false;
}
    // rust: let current = self.map_banner_at(hit.pos);
    // rust: let game_time = self.world.game_time;
    // rust: let failed = self
    // rust: .map(id)
    // rust: .is_some_and(|m| !m.toggle_banner(hit.pos, current, game_time));
    // rust: if failed {
    // rust: return true;
}
    // rust: self.trigger_block("minecraft:item_used_on_block", hit.pos, stack);
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
    // rust: true
}
    /// `CompassItem.useOn`: a compass used on a lodestone locks onto it (a
    /// single one in survival changes in place, else one is split off).
    // rust: pub(super) fn use_lodestone_compass(&mut self, hit: &super::Hit, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:compass" {
    // rust: return false;
}
    // rust: let [x, y, z] = hit.pos;
    // rust: if self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(x, y, z))
    // rust: .name
    // rust: .as_ref()
    // rust: != "minecraft:lodestone"
    // rust: {
    // rust: return false;
}
    // rust: let at = [x, y, z].map(|v| f64::from(v) + 0.5);
    // rust: self.trigger_block("minecraft:item_used_on_block", hit.pos, stack);
    // rust: self.audio
    // rust: .play("minecraft:item.lodestone_compass.lock", Some(at), 1.0, 1.0);
    // rust: let target = Tag::compound([(
    // rust: "target",
    // rust: Tag::compound([
    // rust: ("dimension", Tag::String(self.dimension_id().into())),
    // rust: ("pos", Tag::IntArray(vec![x, y, z])),
    // rust: ]),
    // rust: )]);
    // rust: if !self.creative && stack.count == 1 {
    // rust: if let Some(held) = self.held_mut() {
    // rust: held.data_mut()
    // rust: .set_other("minecraft:lodestone_tracker", Some(target));
}
    // rust: } else {
    // rust: let mut locked = stack.clone();
    // rust: locked.count = 1;
    // rust: locked
    // rust: .data_mut()
    // rust: .set_other("minecraft:lodestone_tracker", Some(target));
    // rust: self.consume_held();
    // rust: self.give_or_drop_stack(locked);
}
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
    // rust: true
}
    /// `CompassItem.inventoryTick` / `LodestoneTracker.tick`: a compass whose
    /// lodestone is gone loses its target. A target in an unloaded chunk waits.
    // rust: pub(super) fn tick_lodestone_compasses(&mut self) {
    // rust: let dim = self.dimension_id();
    // rust: let gone = |game: &Self, stack: &ItemStack| -> bool {
    // rust: let Some(tracker) = stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:lodestone_tracker"))
    // rust: else {
    // rust: return false;
}
    // rust: let (Some(target), true) = (
    // rust: tracker.get("target"),
    // rust: horizon_client::save::number(tracker.get("tracked")).is_none_or(|v| v != 0),
    // rust: ) else {
    // rust: return false;
}
    // rust: let Some(Tag::IntArray(pos)) = target.get("pos") else {
    // rust: return false;
}
    // rust: let [x, y, z] = [pos[0], pos[1], pos[2]];
    // rust: horizon_client::save::text(target.get("dimension")).as_deref() == Some(dim)
    // rust: && game.world.chunks.contains_key(&(x >> 4, z >> 4))
    // rust: && game
    // rust: .res
    // rust: .facts()
    // rust: .get(game.world.block(x, y, z))
    // rust: .name
    // rust: .as_ref()
    // rust: != "minecraft:lodestone"
}
    // rust: for slot in (0..self.inventory.len()).chain([super::shield::OFFHAND_SLOT]) {
    // rust: if self.stack_in(slot).is_some_and(|s| gone(self, s))
    // rust: && let Some(s) = self.stack_in_mut(slot)
    // rust: {
    // rust: s.data_mut().set_other(
    // rust: "minecraft:lodestone_tracker",
    // rust: Some(Tag::Compound(Default::default())),
    // rust: );
}
}
}
pub fn give_or_drop_stack(self: *Self, stack: ItemStack) void {
}
    // rust: if let Some(rest) = self.give(stack)
    // rust: && let Some(eye) = self.eye_position()
    // rust: {
    // rust: self.spawn_item(rest, [eye[0], eye[1] - 0.3, eye[2]], [0.0, 0.1, 0.0], 40);
}
}
    /// `MapItemSavedData.hasMapInvisibilityItemEquipped`: a piece of
    /// `#map_invisibility_equipment` (a carved pumpkin) in an armor slot; the
    /// hands do not count.
pub fn map_invisibility_worn(self: *Self, worn: *[?ItemStack]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tag = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .get("minecraft:map_invisibility_equipment");
    // rust: worn.iter()
    // rust: .flatten()
    // rust: .any(|s| tag.is_some_and(|t| t.contains(&*s.item)))
}
    /// Held maps update; every carried map tracks the player marker.
    // rust: pub(super) fn tick_maps(&mut self) {
    // rust: let Some(p) = self.player.as_ref().map(|p| p.position) else {
    // rust: return;
}
        // A generated exploration map that reached the inventory unsearched
        // (moved out of its chest by a hopper): searched from here.
    // rust: for i in 0..self.inventory.len() {
    // rust: if self.inventory[i]
    // rust: .as_ref()
    // rust: .is_some_and(horizon_client::structure_blocks::has_pending_map)
    // rust: && let Some(mut item) = self.inventory[i].take()
    // rust: {
    // rust: let keep = self.resolve_pending_map(&mut item, [p.x, p.y, p.z]);
    // rust: self.inventory[i] = keep.then_some(item);
}
}
    // rust: let held: Vec<i32> = [Some(self.selected), Some(super::shield::OFFHAND_SLOT)]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|i| self.stack_in(i).and_then(map_id))
    // rust: .collect();
    // rust: let carried: Vec<(i32, Vec<(&'static str, f64, f64, f32)>)> = self
    // rust: .inventory
    // rust: .iter()
    // rust: .chain(std::iter::once(&self.offhand))
    // rust: .flatten()
    // rust: .filter_map(|s| Some((map_id(s)?, static_decorations(s))))
    // rust: .collect();
    // rust: let (yaw, dim) = (self.yaw, self.dimension_id());
    // rust: let (nether, game_time) = (self.dim == super::Dim::Nether, self.world.game_time);
    // rust: let invisible = self.map_invisibility_worn(&self.armor);
        // The guest whose turn it is, else the host.
    // rust: let me = self.lan_acting.unwrap_or(HOST);
    // rust: for (id, targets) in carried {
    // rust: let Some(m) = self.map(id) else { continue };
    // rust: let h = m.holder(me);
    // rust: h.carried = game_time;
    // rust: h.invisible = invisible;
    // rust: m.drop_holders(game_time);
            // tickCarriedBy: the player marker while tracking in this dimension.
    // rust: if m.tracking && m.dimension == dim {
    // rust: m.add_decoration(
    // rust: PLAYER,
    // rust: Some(game_time),
    // rust: Key::Player(me),
    // rust: p.x,
    // rust: p.z,
    // rust: f64::from(yaw),
    // rust: None,
    // rust: );
    // rust: } else if m.decorations.iter().any(|d| d.key == Key::Player(me)) {
    // rust: m.remove_decoration(Key::Player(me));
}
    // rust: m.hide_invisible(me);
            // The item's MAP_DECORATIONS (an explorer map's target), added
            // after the players as addDecoration would.
    // rust: let s = (1 << m.scale) as f32;
    // rust: let mut items: Vec<Decoration> = Vec::new();
    // rust: for (sprite, x, z, rotation) in targets {
    // rust: let dx = (x - f64::from(m.center[0])) as f32 / s;
    // rust: let dz = (z - f64::from(m.center[1])) as f32 / s;
    // rust: let inside = (-63.0..=63.0).contains(&dx) && (-63.0..=63.0).contains(&dz);
    // rust: if !inside && !m.unlimited {
    // rust: continue;
}
    // rust: let d = Decoration {
    // rust: sprite,
    // rust: x: clamp_map_coordinate(dx),
    // rust: y: clamp_map_coordinate(dz),
    // rust: rot: decoration_rotation(nether, game_time, f64::from(rotation)),
    // rust: name: None,
    // rust: key: Key::Item,
}
    // rust: if !items.contains(&d) {
    // rust: items.push(d);
}
}
    // rust: if !m
    // rust: .decorations
    // rust: .iter()
    // rust: .filter(|d| d.key == Key::Item)
    // rust: .eq(items.iter())
    // rust: {
    // rust: m.decorations.retain(|d| d.key != Key::Item);
    // rust: m.decorations.extend(items);
    // rust: m.decorations_changed();
}
}
    // rust: for id in held {
    // rust: self.update_map(id);
}
}
    /// The maps the player carries, for `status`: how many of their pixels
    /// are drawn, and their decorations.
    // rust: pub(super) fn maps_status(&self) -> Vec<serde_json::Value> {
    // rust: self.inventory
    // rust: .iter()
    // rust: .chain(std::iter::once(&self.offhand))
    // rust: .flatten()
    // rust: .filter_map(map_id)
    // rust: .filter_map(|id| {
    // rust: let m = self.maps.data.get(&id)?;
    // rust: Some(serde_json::json!({
    // rust: "id": id,
    // rust: "pixels": m.colors.iter().filter(|&&c| c != 0).count(),
    // rust: "decorations": m.decorations.iter().map(|d| d.sprite).collect::<Vec<_>>(),
    // rust: }))
    // rust: })
    // rust: .collect()
}
    /// `ServerPlayer.synchronizeSpecialItemUpdates` for each map the guest
    /// carries, and every 10 ticks (`ServerEntity.sendChanges`) for each map
    /// framed in the level: a `ClientboundMapItemDataPacket` when something
    /// changed since the guest's last one.
    // rust: pub(super) fn lan_map_updates(&mut self, host: &LanHost, conn: u32) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let mut ids: Vec<i32> = g
    // rust: .inventory
    // rust: .iter()
    // rust: .chain(std::iter::once(&g.offhand))
    // rust: .flatten()
    // rust: .filter_map(map_id)
    // rust: .collect();
    // rust: let now = self.world.game_time;
    // rust: if now % 10 == 0 && host.hub.here(g) {
    // rust: let framed: Vec<(i32, std::sync::Arc<str>, Framed)> = self
    // rust: .item_frames
    // rust: .iter()
                // ServerEntity.sendChanges: only a framed MapItem (a filled
                // map), not any stack that carries a map id.
    // rust: .filter_map(|f| {
    // rust: let item = f.item.as_ref()?;
    // rust: if &*item.item != "minecraft:filled_map" {
    // rust: return None;
}
    // rust: let frame = Framed {
    // rust: pos: f.pos,
    // rust: facing: f.facing,
    // rust: id: f.id as i32,
}
    // rust: Some((map_id(item)?, item.item.clone(), frame))
    // rust: })
    // rust: .collect();
    // rust: let invisible = self.map_invisibility_worn(&g.armor);
    // rust: for (id, item, frame) in framed {
                // tickCarriedBy's mapMatcher: the same item with the same map id.
    // rust: let carries = g
    // rust: .inventory
    // rust: .iter()
    // rust: .chain(std::iter::once(&g.offhand))
    // rust: .flatten()
    // rust: .any(|s| s.item == item && map_id(s) == Some(id));
    // rust: if let Some(m) = self.map(id) {
    // rust: m.tick_framed(conn, now, carries, invisible, frame);
    // rust: ids.push(id);
}
}
}
    // rust: ids.sort_unstable();
    // rust: ids.dedup();
    // rust: let kind = |name: &str| {
    // rust: host.hub.registry_id(
    // rust: "minecraft:map_decoration_type",
    // rust: &format!("minecraft:{name}"),
    // rust: )
}
    // rust: for id in ids {
    // rust: if let Some(p) = self
    // rust: .maps
    // rust: .data
    // rust: .get_mut(&id)
    // rust: .and_then(|m| m.update_packet(id, conn, kind))
    // rust: {
    // rust: g.send(&horizon_protocol::packets::play::Clientbound::MapItemData(
    // rust: p,
    // rust: ));
}
}
}
    /// `MapItemSavedData.checkBanners` on map `id` for the column `x`, `z`
    /// that `MapItem.update` is reading.
pub fn check_banners(self: *Self, id: i32, x: i32, z: i32) void {
}
    // rust: let (world, res) = (&self.world, &self.res);
    // rust: let Some(m) = self.maps.data.get_mut(&id) else {
    // rust: return;
}
    // rust: if m.banners.is_empty() {
    // rust: return;
}
    // rust: m.check_banners(x, z, |pos| {
    // rust: let state = world.block(pos[0], pos[1], pos[2]);
    // rust: super::banners::map_banner(
    // rust: pos,
    // rust: world.block_entities.get(&(pos[0], pos[1], pos[2])),
    // rust: &res.facts().get(state).name,
    // rust: )
    // rust: });
}
    /// `MapItem.update` for the player holding map `id`.
pub fn update_map(self: *Self, id: i32) void {
}
    // rust: let dim = self.dimension_id();
    // rust: let Some(p) = self.player.as_ref().map(|p| p.position) else {
    // rust: return;
}
    // rust: let has_ceiling = self.world.shape.has_ceiling;
    // rust: let Some(m) = self.maps.data.get_mut(&id) else {
    // rust: return;
}
    // rust: if m.locked || m.dimension != dim {
    // rust: return;
}
    // rust: let scale = 1i32 << m.scale;
    // rust: let [cx, cz] = m.center;
    // rust: let px = (p.x - f64::from(cx)).floor() as i32 / scale + 64;
    // rust: let pz = (p.z - f64::from(cz)).floor() as i32 / scale + 64;
    // rust: let mut radius = 128 / scale;
    // rust: if has_ceiling {
    // rust: radius /= 2;
}
    // rust: let h = m.holder(self.lan_acting.unwrap_or(HOST));
    // rust: h.step += 1;
    // rust: let step = h.step;
    // rust: let mut changes: Vec<(i32, i32, u8)> = Vec::new();
    // rust: let mut consecutive = false;
    // rust: for img_x in px - radius + 1..px + radius {
    // rust: if (img_x & 15) != (step & 15) && !consecutive {
    // rust: continue;
}
    // rust: consecutive = false;
    // rust: let mut previous_height = 0.0f64;
    // rust: for img_y in pz - radius - 1..pz + radius {
    // rust: if !(0..128).contains(&img_x) || !(-1..128).contains(&img_y) {
    // rust: continue;
}
    // rust: let d2 = (img_x - px).pow(2) + (img_y - pz).pow(2);
    // rust: let dither_black = d2 > (radius - 2) * (radius - 2);
    // rust: let min_x = (cx / scale + img_x - 64) * scale;
    // rust: let min_z = (cz / scale + img_y - 64) * scale;
    // rust: if !self.world.chunks.contains_key(&(min_x >> 4, min_z >> 4)) {
    // rust: continue;
}
    // rust: let mut counts: Vec<(u8, u32)> = Vec::new();
    // rust: let mut add = |c: u8, n: u32| match counts.iter_mut().find(|e| e.0 == c) {
    // rust: Some(e) => e.1 += n,
    // rust: None => counts.push((c, n)),
}
    // rust: let mut water_depth = 0i32;
    // rust: let mut height = 0.0f64;
    // rust: if has_ceiling {
    // rust: let mut noise = min_x.wrapping_add(min_z.wrapping_mul(231_871));
    // rust: noise = noise
    // rust: .wrapping_mul(noise)
    // rust: .wrapping_mul(31_287_121)
    // rust: .wrapping_add(noise.wrapping_mul(11));
                    // Dirt (10) or stone (11) noise under a ceiling.
    // rust: if noise >> 20 & 1 == 0 {
    // rust: add(10, 10);
    // rust: } else {
    // rust: add(11, 100);
}
    // rust: height = 100.0;
    // rust: } else {
    // rust: for dx in 0..scale {
    // rust: for dz in 0..scale {
    // rust: let (x, z) = (min_x + dx, min_z + dz);
    // rust: let mut y = self.world_surface(x, z);
    // rust: let min_y = self.world.bottom_y();
    // rust: let mut color;
    // rust: if y <= min_y {
    // rust: color = 11;
    // rust: } else {
    // rust: loop {
    // rust: y -= 1;
    // rust: color =
    // rust: self.res.facts().get(self.world.block(x, y, z)).map_color;
    // rust: if color != 0 || y <= min_y {
    // rust: break;
}
}
    // rust: let f = self.res.facts().get(self.world.block(x, y, z));
    // rust: if y > min_y && f.fluid != Fluid::None {
    // rust: let mut solid = y - 1;
    // rust: loop {
    // rust: let below =
    // rust: self.res.facts().get(self.world.block(x, solid, z));
    // rust: solid -= 1;
    // rust: water_depth += 1;
    // rust: if solid <= min_y || below.fluid == Fluid::None {
    // rust: break;
}
}
                                    // getCorrectStateForFluidBlock: the fluid unless sturdy on top.
    // rust: if f.sturdy_full >> 1 & 1 == 0 {
    // rust: color = if f.fluid == Fluid::Lava { 4 } else { 12 };
}
}
}
    // rust: self.check_banners(id, x, z);
    // rust: height += f64::from(y) / f64::from(scale * scale);
    // rust: add(color, 1);
}
}
}
    // rust: water_depth /= scale * scale;
                // Multisets.copyHighestCountFirst: the most common, first seen on ties.
    // rust: let best = counts
    // rust: .iter()
    // rust: .fold(None::<(u8, u32)>, |acc, &(c, n)| match acc {
    // rust: Some((_, bn)) if bn >= n => acc,
    // rust: _ => Some((c, n)),
    // rust: })
    // rust: .map_or(0, |e| e.0);
    // rust: let parity = f64::from((img_x + img_y) & 1);
    // rust: let brightness = if best == 12 {
    // rust: let diff = f64::from(water_depth) * 0.1 + parity * 0.2;
    // rust: if diff < 0.5 {
    // rust: 2
    // rust: } else if diff > 0.9 {
    // rust: 0
    // rust: } else {
    // rust: 1
}
    // rust: } else {
    // rust: let diff = (height - previous_height) * 4.0 / f64::from(scale + 4)
    // rust: + (parity - 0.5) * 0.4;
    // rust: if diff > 0.6 {
    // rust: 2
    // rust: } else if diff < -0.6 {
    // rust: 0
    // rust: } else {
    // rust: 1
}
}
    // rust: previous_height = height;
    // rust: if img_y >= 0 && d2 < radius * radius && (!dither_black || (img_x + img_y) & 1 != 0)
    // rust: {
    // rust: changes.push((img_x, img_y, best << 2 | brightness));
}
}
    // rust: if let Some(m) = self.maps.data.get_mut(&id) {
    // rust: for (x, y, c) in changes.drain(..) {
    // rust: consecutive |= m.update_color(x, y, c);
}
}
}
}
    /// Writes changed maps and the id counter (`MapItemSavedData`, `MapIndex`).
    // rust: pub(super) fn save_maps(&mut self) {
    // rust: for (id, m) in &mut self.maps.data {
    // rust: if m.dirty {
    // rust: let path = self
    // rust: .world_root
    // rust: .join("data/minecraft/maps")
    // rust: .join(format!("{id}.dat"));
    // rust: if horizon_client::save::write_dat(&path, m.to_nbt()).is_ok() {
    // rust: m.dirty = false;
}
}
}
    // rust: if let Some(last) = self.maps.last_id {
    // rust: let tag = Tag::compound([
    // rust: ("data", Tag::compound([("map", Tag::Int(last))])),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]);
    // rust: if let Err(e) = horizon_client::save::write_dat(
    // rust: &self.world_root.join("data/minecraft/maps/last_id.dat"),
    // rust: tag,
    // rust: ) {
    // rust: log::warn!("Horizon: the next map id is not saved: {e}");
}
}
}
    /// The atlas slot showing map `id`, its texture uploaded when it changed.
    // rust: pub(super) fn map_texture(&mut self, id: i32) -> Option<Rect> {
    // rust: self.map(id)?;
    // rust: let slot = match self.maps.slots.show(&id) {
    // rust: Some(slot) => slot,
    // rust: None => {
    // rust: let (slot, _) = self.maps.slots.claim(id);
    // rust: if let Some(m) = self.maps.data.get_mut(&id) {
    // rust: m.texture_dirty = true;
}
    // rust: slot
}
}
    // rust: let rect = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get(map_slot_sprite(slot)?)
    // rust: .copied()?;
    // rust: let m = self.maps.data.get_mut(&id)?;
    // rust: if m.texture_dirty {
    // rust: m.texture_dirty = false;
    // rust: let rgba: Vec<u8> = m.colors.iter().flat_map(|&c| packed_rgba(c)).collect();
    // rust: let (w, h) = (self.gui.atlas.width as f32, self.gui.atlas.height as f32);
    // rust: self.map_patches.push(horizon_client::font::Patch {
    // rust: x: (rect.u0 * w).round() as u32,
    // rust: y: (rect.v0 * h).round() as u32,
    // rust: width: 128,
    // rust: height: 128,
    // rust: rgba,
    // rust: });
}
    // rust: Some(rect)
}
    /// `MapRenderer.render`: the map texture and its decorations under `m`
    /// (map pixels 0..128, y down), drawn at depth offsets toward the viewer.
    /// `show_only_frame` (a map in an item frame) leaves out the decorations that
    /// do not show on frames.
    // rust: pub(super) fn map_vertices(
    // rust: &mut self,
    // rust: id: i32,
    // rust: show_only_frame: bool,
    // rust: m: glam::Mat4,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some(rect) = self.map_texture(id) else {
    // rust: return;
}
    // rust: let quad = |corners: [[f32; 3]; 4], uv: [[f32; 2]; 4], out: &mut Vec<Vertex>| {
    // rust: for (c, uv) in corners.into_iter().zip(uv) {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: m.transform_point3(glam::Vec3::from_array(c)).to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
    // rust: let z = -0.01;
    // rust: quad(
    // rust: [
    // rust: [0.0, 128.0, z],
    // rust: [128.0, 128.0, z],
    // rust: [128.0, 0.0, z],
    // rust: [0.0, 0.0, z],
    // rust: ],
    // rust: [
    // rust: [rect.u0, rect.v1],
    // rust: [rect.u1, rect.v1],
    // rust: [rect.u1, rect.v0],
    // rust: [rect.u0, rect.v0],
    // rust: ],
    // rust: out,
    // rust: );
    // rust: let decorations = self.maps.data.get(&id).map_or(&[][..], |m| &m.decorations);
    // rust: let mut count = 0;
    // rust: for d in decorations {
    // rust: if show_only_frame && !shown_on_frame(d.sprite) {
    // rust: continue;
}
    // rust: let Some(s) = self.gui.atlas.sprites.get(d.sprite).copied() else {
    // rust: continue;
}
    // rust: let dm = decoration_pose(d, -0.02 - count as f32 * 0.001);
    // rust: let p = |x: f32, y: f32| dm.transform_point3(glam::Vec3::new(x, y, 0.0)).to_array();
    // rust: let mut q = |corners: [[f32; 3]; 4], uv: [[f32; 2]; 4]| {
    // rust: for (c, uv) in corners.into_iter().zip(uv) {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: m.transform_point3(glam::Vec3::from_array(c)).to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
    // rust: q(
    // rust: [p(-1.0, 1.0), p(1.0, 1.0), p(1.0, -1.0), p(-1.0, -1.0)],
    // rust: [[s.u0, s.v0], [s.u1, s.v0], [s.u1, s.v1], [s.u0, s.v1]],
    // rust: );
    // rust: if let Some(name) = &d.name {
    // rust: let text = horizon_client::text::Text::literal(name);
    // rust: let f = self.gui.atlas.font.width_text(&text);
    // rust: if f > 0.0 {
    // rust: let f1 = (25.0 / f).clamp(0.0, 6.0 / 9.0);
    // rust: let mut text_batch = HudBatch::new([1, 1]);
    // rust: let behind =
    // rust: text_batch.name_tag(&self.gui.atlas, &text, 0.0, 0xFFFF_FFFF, 0x8000_0000);
    // rust: self.map_patches.append(&mut text_batch.patches);
    // rust: let tm = glam::Mat4::from_translation(glam::Vec3::new(
    // rust: f32::from(d.x) / 2.0 + 64.0,
    // rust: f32::from(d.y) / 2.0 + 64.0 + 4.0,
                        // MapRenderer translates by -0.025, then flips Z and
                        // translates by 0.1 in text space: -0.025 - 0.1.
    // rust: -0.125,
    // rust: )) * glam::Mat4::from_scale(glam::Vec3::new(f1, f1, 1.0));
    // rust: for (i, quad) in text_batch.vertices.as_chunks::<6>().0.iter().enumerate() {
    // rust: let z_shift = if i * 6 < behind { 0.0005 } else { -0.0005 };
    // rust: for v in [quad[5], quad[2], quad[1], quad[0]] {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: m
    // rust: .transform_point3(tm.transform_point3(glam::Vec3::new(
    // rust: v.pos[0], v.pos[1], z_shift,
    // rust: )))
    // rust: .to_array(),
    // rust: uv: v.uv,
    // rust: layer: 0,
    // rust: color: v.color,
    // rust: light,
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}
    // rust: count += 1;
}
        // A native mod's own icons, over the vanilla ones.
    // rust: for d in self.mod_map_decorations(id, show_only_frame) {
    // rust: let Some(s) = self.gui.atlas.sprites.get(d.sprite.as_str()).copied() else {
    // rust: continue;
}
    // rust: let dm = decoration_pose_at(d.x, d.y, d.rot, -0.02 - count as f32 * 0.001);
    // rust: let p = |x: f32, y: f32| dm.transform_point3(glam::Vec3::new(x, y, 0.0)).to_array();
    // rust: let corners = [p(-1.0, 1.0), p(1.0, 1.0), p(1.0, -1.0), p(-1.0, -1.0)];
    // rust: let uvs = [[s.u0, s.v0], [s.u1, s.v0], [s.u1, s.v1], [s.u0, s.v1]];
    // rust: for (c, uv) in corners.into_iter().zip(uvs) {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: m.transform_point3(glam::Vec3::from_array(c)).to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light,
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
    // rust: count += 1;
}
}
    /// The icons `native_map_decorations` adds to map `id`, as it is drawn
    /// (`frame`: in an item frame or on a screen, which show only what
    /// `shown_on_frame` allows).
    // rust: pub(super) fn mod_map_decorations(&self, id: i32, frame: bool) -> Vec<NativeMapDecoration> {
    // rust: let Some(map) = self.maps.data.get(&id) else {
    // rust: return Vec::new();
}
    // rust: let info = NativeMapInfo {
    // rust: id,
    // rust: center: map.center,
    // rust: scale: map.scale,
    // rust: dimension: &map.dimension,
    // rust: locked: map.locked,
    // rust: in_frame: frame,
}
    // rust: let mut decorations = Vec::new();
    // rust: self.native_map_decorations(&info, &mut decorations);
    // rust: decorations
    // rust: .into_iter()
    // rust: .filter(|d| !frame || d.shown_on_frame)
    // rust: .map(|d| NativeMapDecoration {
    // rust: rot: d.rot & 15,
    // rust: ..d
    // rust: })
    // rust: .collect()
}
    /// `renderTwoHandedMap`: map `id` held in both hands, in view space (the
    /// arms under it: `first_person::map_arm_poses`).
    // rust: pub(super) fn two_handed_map_geometry(
    // rust: &mut self,
    // rust: to_world: glam::Mat4,
    // rust: attack: f32,
    // rust: inverse_height: f32,
    // rust: id: i32,
    // rust: light: u32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
//         use horizon_core::geometry::trig::Mth;
    // rust: let deg = |d: f32| d.to_radians();
    // rust: let base = to_world
    // rust: * horizon_client::first_person::two_handed_map_base(self.pitch, inverse_height, attack);
    // rust: let swing = (attack.sqrt() * std::f32::consts::PI).msin();
    // rust: let m = base
    // rust: * glam::Mat4::from_rotation_x(deg(swing * 20.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(2.0));
    // rust: self.held_map(m, id, light, out);
}
    /// `renderMap`: map `id` at pose `m`, its background (with a 7-pixel
    /// border) then the map.
    // rust: pub(super) fn held_map(&mut self, m: glam::Mat4, id: i32, light: u32, out: &mut Vec<Vertex>) {
    // rust: let deg = |d: f32| d.to_radians();
    // rust: let m = m
    // rust: * glam::Mat4::from_rotation_y(deg(180.0))
    // rust: * glam::Mat4::from_rotation_z(deg(180.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(0.38))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(-0.5, -0.5, 0.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(0.0078125));
    // rust: let has_data = self.map(id).is_some();
    // rust: let background = if has_data {
    // rust: "map/map_background_checkerboard"
    // rust: } else {
    // rust: "map/map_background"
}
    // rust: if let Some(r) = self.gui.atlas.sprites.get(background).copied() {
    // rust: for (c, uv) in [
    // rust: ([-7.0, 135.0, 0.0], [r.u0, r.v1]),
    // rust: ([135.0, 135.0, 0.0], [r.u1, r.v1]),
    // rust: ([135.0, -7.0, 0.0], [r.u1, r.v0]),
    // rust: ([-7.0, -7.0, 0.0], [r.u0, r.v0]),
    // rust: ] {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: m.transform_point3(glam::Vec3::from_array(c)).to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
    // rust: if has_data {
    // rust: self.map_vertices(id, false, m, light, out);
}
}
}

    // rust: mod live_frame_tests;
    // rust: mod save_tests;

    // rust: mod tests {
//     use super::*;

pub fn a_mod_icon_sits_where_a_vanilla_decoration_would() void {
}
        // Half pixels from the map's centre: x 20 is 10 map pixels right of it.
    // rust: let vanilla = Decoration {
    // rust: sprite: "map/decorations/frame",
    // rust: x: 20,
    // rust: y: -30,
    // rust: rot: 4,
    // rust: name: None,
    // rust: key: Key::Item,
}
    // rust: assert_eq!(
    // rust: decoration_pose(&vanilla, -0.02),
    // rust: decoration_pose_at(20, -30, 4, -0.02)
    // rust: );
    // rust: let at = decoration_pose_at(20, -30, 0, 0.0).transform_point3(glam::Vec3::ZERO);
    // rust: assert!(
    // rust: (at.x - 74.0).abs() < 0.6 && (at.y - 49.0).abs() < 0.6,
    // rust: "{at:?}"
    // rust: );
}

pub fn every_target_decoration_type_has_its_sprite() void {
}
        // MapDecorationTypes: (name, asset).
    // rust: for (name, asset) in [
    // rust: ("mansion", "woodland_mansion"),
    // rust: ("monument", "ocean_monument"),
    // rust: ("red_x", "red_x"),
    // rust: ("village_desert", "desert_village"),
    // rust: ("village_plains", "plains_village"),
    // rust: ("village_savanna", "savanna_village"),
    // rust: ("village_snowy", "snowy_village"),
    // rust: ("village_taiga", "taiga_village"),
    // rust: ("jungle_temple", "jungle_temple"),
    // rust: ("swamp_hut", "swamp_hut"),
    // rust: ("trial_chambers", "trial_chambers"),
    // rust: ("abandoned_camp", "abandoned_camp"),
    // rust: ("ancient_city", "ancient_city"),
    // rust: ("desert_pyramid", "desert_pyramid"),
    // rust: ("mineshaft", "mineshaft"),
    // rust: ("ocean_ruin_warm", "warm_ocean_ruins"),
    // rust: ] {
    // rust: assert_eq!(
    // rust: decoration_sprite(&format!("minecraft:{name}")),
    // rust: Some(format!("map/decorations/{asset}").as_str()),
    // rust: "{name}"
    // rust: );
}
    // rust: assert_eq!(decoration_sprite("minecraft:nothing"), None);
}

pub fn target_decorations_read_back_with_vanilla_rotation() void {
}
    // rust: let mut stack = ItemStack::new("minecraft:buried_treasure_map", 1);
    // rust: stack.data_mut().map_id = Some(3);
    // rust: stack.data_mut().other.push((
    // rust: "minecraft:map_decorations".into(),
    // rust: target_decoration("minecraft:red_x", [120, 40, -300]),
    // rust: ));
    // rust: assert_eq!(map_id(&stack), Some(3));
    // rust: let found = static_decorations(&stack);
    // rust: assert_eq!(found, vec![("map/decorations/red_x", 120.0, -300.0, 180.0)]);
        // calculateRotation(180): (byte) (188 * 16 / 360) = 8.
    // rust: assert_eq!(decoration_rotation(false, 0, 180.0), 8);
    // rust: assert_eq!(decoration_rotation(false, 0, -90.0), 12);
    // rust: assert_eq!(clamp_map_coordinate(-70.0), -128);
    // rust: assert_eq!(clamp_map_coordinate(10.25), 21);
}

    /// `ItemStack.useOn` / `MapItem.useOn`: in adventure mode, a map whose
    /// `can_place_on` component includes the banner block toggles that banner's
    /// marker, while one without does not.
pub fn map_on_banner_in_adventure_mode_honours_can_place_on() void {
}
//         use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//         use horizon_client::{chunk::Chunk, command::args::GameMode};
//         use std::sync::Arc;

    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES") else {
    // rust: return;
}
    // rust: let root = std::path::PathBuf::from(root);
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();

    // rust: let pos = [0, 64, 0];
    // rust: game.world
    // rust: .chunks
    // rust: .insert((0, 0), Arc::new(Chunk::empty(0, 0)));
    // rust: let banner_state = game
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:red_banner")
    // rust: .unwrap();
    // rust: game.world
    // rust: .set(pos[0], pos[1], pos[2], banner_state)
    // rust: .unwrap();
    // rust: game.world.block_entities.insert(
    // rust: (pos[0], pos[1], pos[2]),
    // rust: horizon_client::containers::BlockEntity::Banner(horizon_client::containers::Banner {
    // rust: layers: Vec::new(),
    // rust: name: None,
    // rust: components: Default::default(),
    // rust: }),
    // rust: );

    // rust: let map_id = 42;
    // rust: game.maps
    // rust: .data
    // rust: .insert(map_id, MapData::fresh(0.0, 0.0, 0, "minecraft:overworld"));
    // rust: game.set_mode(GameMode::Adventure);
    // rust: let hit = super::super::Hit {
    // rust: pos,
    // rust: face: [0, 1, 0],
    // rust: point: [
    // rust: pos[0] as f64 + 0.5,
    // rust: pos[1] as f64 + 0.5,
    // rust: pos[2] as f64 + 0.5,
    // rust: ],
}
    // rust: let mut stack = ItemStack::new("minecraft:filled_map", 1);
    // rust: stack.data_mut().map_id = Some(map_id);

        // Without can_place_on, use_map_on_banner fails in adventure mode.
    // rust: *game.held_mut() = Some(stack.clone());
    // rust: assert!(!game.use_map_on_banner(&hit, &stack));
    // rust: assert!(game.map(map_id).unwrap().banners.is_empty());

        // With can_place_on listing the banner block, the marker toggles.
    // rust: stack.data_mut().other.push((
    // rust: "minecraft:can_place_on".into(),
    // rust: Tag::compound([(
    // rust: "blocks",
    // rust: Tag::List(vec![Tag::String("minecraft:red_banner".into())]),
    // rust: )]),
    // rust: ));
    // rust: *game.held_mut() = Some(stack.clone());
    // rust: assert!(game.use_map_on_banner(&hit, &stack));
    // rust: assert_eq!(game.map(map_id).unwrap().banners.len(), 1);
    // rust: assert_eq!(game.map(map_id).unwrap().banners[0].pos, pos);
    // rust: assert_eq!(game.map(map_id).unwrap().banners[0].color, "red");

        // Second use toggles the marker off.
    // rust: assert!(game.use_map_on_banner(&hit, &stack));
    // rust: assert!(game.map(map_id).unwrap().banners.is_empty());
}
}
