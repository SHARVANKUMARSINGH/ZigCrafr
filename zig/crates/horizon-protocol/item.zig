//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_item
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Item stacks on the wire (ItemStack.OPTIONAL_STREAM_CODEC): a count, the
//! item's registry id and a data component patch, plus the hashed form the
//! client sends back in container clicks (HashedStack).
// use crate::{
    // rust: Result,
    // rust: adapter::ids,
    // rust: buf::{Codec, Reader, Writer, pack_block_pos, unpack_block_pos},
}
// use horizon_world::nbt::Tag;
// use std::sync::Arc;

    // rust: pub mod custom;
    // rust: mod hash;
    // rust: mod skip;

    // rust: pub use hash::{Names, NoNames};

/// How deep values may sit inside one another while an item is decoded: stacks in a stack's components (a
/// bundle in a bundle, a use_remainder's use_remainder) and a mob effect's hidden effects. Those codecs
/// call each other with no limit of their own. In vanilla a payload nested past the stack ends in a
/// StackOverflowError, which the decoder turns into a disconnect; in Rust a stack overflow aborts the
/// process, so a single packet from a peer would end the game, or a whole server and all its players.
/// Real items stay far below it (a survival bundle holds bundles about 16 deep at most).
pub const MAX_NESTING: u32 = 64;

    // rust: thread_local! {
pub const NESTING: std::cell::Cell<u32> = const { std::cell::Cell::new(0) };
}

/// One level of [`MAX_NESTING`] while it lives. Counted per thread rather than in the [`Reader`], because a
/// delimited or rewritten component is read through a reader of its own.
pub const Nested = struct {};
    // rust: impl Nested {
pub fn enter() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NESTING.with(|n| {
    // rust: let depth = n.get();
    // rust: if depth >= MAX_NESTING {
    // rust: return Err(crate::Error::new("item data nested too deeply"));
}
    // rust: n.set(depth + 1);
    // rust: Ok(Nested)
    // rust: })
}
}
    // rust: impl Drop for Nested {
pub fn drop(self: *Self) void {
}
    // rust: NESTING.with(|n| n.set(n.get() - 1));
}
}

/// minecraft:data_component_type registry ids (26.3).
    // rust: pub mod component {
pub const CUSTOM_DATA: i32 = 0;
pub const MAX_STACK_SIZE: i32 = 1;
pub const MAX_DAMAGE: i32 = 2;
pub const DAMAGE: i32 = 3;
pub const UNBREAKABLE: i32 = 4;
pub const CUSTOM_NAME: i32 = 6;
pub const ITEM_NAME: i32 = 9;
pub const ITEM_MODEL: i32 = 10;
pub const LORE: i32 = 11;
pub const RARITY: i32 = 12;
pub const ENCHANTMENTS: i32 = 13;
    /// `AdventureModePredicate`: the blocks an adventure player may break.
pub const CAN_BREAK: i32 = 15;
pub const CUSTOM_MODEL_DATA: i32 = 17;
pub const TOOLTIP_DISPLAY: i32 = 18;
pub const REPAIR_COST: i32 = 19;
pub const CREATIVE_SLOT_LOCK: i32 = 20;
pub const ENCHANTMENT_GLINT_OVERRIDE: i32 = 21;
    /// `AttackRange`: six floats, in the record's field order.
pub const ATTACK_RANGE: i32 = 30;
pub const EQUIPPABLE: i32 = 32;
pub const GLIDER: i32 = 34;
pub const STORED_ENCHANTMENTS: i32 = 45;
pub const PROFILE: i32 = 72;
pub const BANNER_PATTERNS: i32 = 74;
pub const BASE_COLOR: i32 = 75;
pub const DYED_COLOR: i32 = 47;
pub const MAP_ID: i32 = 48;
pub const MAP_POST_PROCESSING: i32 = 50;
pub const CHARGED_PROJECTILES: i32 = 51;
pub const BUNDLE_CONTENTS: i32 = 52;
pub const POTION_CONTENTS: i32 = 53;
pub const SUSPICIOUS_STEW_EFFECTS: i32 = 55;
pub const WRITABLE_BOOK_CONTENT: i32 = 56;
pub const WRITTEN_BOOK_CONTENT: i32 = 57;
pub const TRIM: i32 = 58;
pub const INSTRUMENT: i32 = 63;
pub const LODESTONE_TRACKER: i32 = 69;
pub const FIREWORK_EXPLOSION: i32 = 70;
pub const FIREWORKS: i32 = 71;
pub const BLOCK_ENTITY_DATA: i32 = 62;
pub const OMINOUS_BOTTLE_AMPLIFIER: i32 = 65;
pub const USE_REMAINDER: i32 = 25;
pub const POT_DECORATIONS: i32 = 76;
pub const JUKEBOX_PLAYABLE: i32 = 66;
pub const DAMAGE_RESISTANT: i32 = 27;
pub const CONTAINER: i32 = 77;
pub const SULFUR_CUBE_CONTENT: i32 = 80;
pub const PAINTING_VARIANT: i32 = 109;
    /// `SignText.STREAM_CODEC`: a sign item's text, front and back.
pub const SIGN_TEXT_FRONT: i32 = 118;
pub const SIGN_TEXT_BACK: i32 = 119;
}

/// A written book's content (`WrittenBookContent.STREAM_CODEC`). The raw title
/// and pages are what a book shows; the filtered variants (`Filterable.filtered`,
/// which a server sends when chat filtering is on) are kept only so that the
/// component hashes as the server holds it.
pub const WrittenBook = struct {
    title: []const u8,
    title_filtered: ?[]const u8,
    author: []const u8,
    generation: i32,
    /// Each page's text component.
    pages: std.ArrayList(Tag),
    /// Each page's filtered variant: empty (none filtered) or one per page.
    pages_filtered: std.ArrayList(?Tag),
    resolved: bool,
};

/// The value of one patched data component. Components whose stream codec
/// Horizon does not implement make the whole stack (and packet) undecodable.
pub const Component = enum {
    Int(i32),
    Unit,
    Bool(bool),
    Text(Tag),
    Nbt(Tag),
    Ident(String),
    Lore(Vec<Tag>),
    Enchantments(Vec<(i32, i32)>),
    AttackRange([f32; 6]),
    /// `PotionContents`: the potion's `minecraft:potion` id and the custom
    /// colour; the custom effects and name stay their encoded bytes.
    Potion {,
    potion: Option<i32>,
    color: Option<i32>,
    rest: Vec<u8>,
    // rust: },
    Profile(Profile),
    CustomModelData {,
    floats: Vec<f32>,
    flags: Vec<bool>,
    strings: Vec<String>,
    colors: Vec<i32>,
    // rust: },
    TooltipDisplay {,
    hide: bool,
    hidden: Vec<i32>,
    // rust: },
    /// `WritableBookContent`: the pages (raw text) and their filtered variants
    /// (empty, or one per page).
    WritableBook {,
    pages: Vec<String>,
    filtered: Vec<Option<String>>,
    // rust: },
    WrittenBook(WrittenBook),
    /// `ChargedProjectiles`: a loaded crossbow's ammunition, as templates.
    Stacks(Vec<Stack>),
    /// `Fireworks`: flight duration and its explosions.
    Fireworks {,
    flight: i32,
    explosions: Vec<FireworkExplosion>,
    // rust: },
    /// `FireworkExplosion` (a firework star).
    FireworkExplosion(FireworkExplosion),
    /// `LodestoneTracker`: the target's dimension and block, and whether it
    /// follows the lodestone.
    LodestoneTracker {,
    target: Option<(String, [i32; 3])>,
    tracked: bool,
    // rust: },
    /// `ArmorTrim` naming its material and pattern by registry id (`trim_material`,
    /// `trim_pattern`); a trim with a direct holder stays [`Component::Raw`].
    Trim {,
    material: i32,
    pattern: i32,
    // rust: },
    /// `SuspiciousStewEffects`: each entry's `minecraft:mob_effect` id and
    /// duration in ticks.
    StewEffects(Vec<(i32, i32)>),
    /// `InstrumentComponent` naming its instrument by `minecraft:instrument`
    /// registry id; a direct instrument stays [`Component::Raw`].
    Instrument(i32),
    /// `BannerPatternLayers`: each layer's `banner_pattern` registry id and
    /// its dye id (`DyeColor.getId`). A layer with a direct pattern has no
    /// registry name: that value stays [`Component::Raw`].
    BannerPatterns(Vec<(i32, i32)>),
    /// `painting/variant` naming its `painting_variant` by registry id; a
    /// direct variant stays [`Component::Raw`].
    PaintingVariant(i32),
    /// A component Horizon reads past without interpreting it: its encoded
    /// bytes, written back as they came.
    Raw(Vec<u8>),
};

/// `FireworkExplosion.STREAM_CODEC`: shape id, colors, fade colors, trail
/// and twinkle (FireworkExplosion.Shape's BY_ID order).
pub const FireworkExplosion = struct {
    shape: i32,
    colors: std.ArrayList(i32),
    fade: std.ArrayList(i32),
    trail: bool,
    twinkle: bool,
};
    // rust: impl FireworkExplosion {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ints = |r: &mut Reader| -> Result<Vec<i32>> {
    // rust: let n = r.count(1024)?;
    // rust: (0..n).map(|_| r.i32()).collect()
}
    // rust: Ok(Self {
    // rust: shape: r.varint()?,
    // rust: colors: ints(r)?,
    // rust: fade: ints(r)?,
    // rust: trail: r.bool()?,
    // rust: twinkle: r.bool()?,
    // rust: })
}
pub fn write(self: *Self, w: *mut Writer) void {
}
    // rust: w.varint(self.shape);
    // rust: w.varint(self.colors.len() as i32);
    // rust: self.colors.iter().for_each(|c| w.i32(*c));
    // rust: w.varint(self.fade.len() as i32);
    // rust: self.fade.iter().for_each(|c| w.i32(*c));
    // rust: w.bool(self.trail);
    // rust: w.bool(self.twinkle);
}
}

/// `Filterable.streamCodec`: the raw value, then an optional filtered one.
    // rust: fn filterable<T>(
    // rust: r: &mut Reader,
    // rust: value: impl Fn(&mut Reader) -> Result<T>,
    // rust: ) -> Result<(T, Option<T>)> {
    // rust: let raw = value(r)?;
    // rust: let filtered = if r.bool()? { Some(value(r)?) } else { None };
    // rust: Ok((raw, filtered))
}
/// The filtered variants of a list of pages, or none when no page has one.
    // rust: fn filtered_variants<T>(pages: &mut Vec<(T, Option<T>)>) -> (Vec<T>, Vec<Option<T>>) {
    // rust: let any = pages.iter().any(|(_, f)| f.is_some());
    // rust: let (raw, filtered): (Vec<_>, Vec<_>) = pages.drain(..).unzip();
    // rust: (raw, if any { filtered } else { Vec::new() })
}

/// `ResolvableProfile`: an optional name and UUID and the profile's property
/// list, followed by `PlayerSkin.Patch`'s four optional textures.
pub const Profile = struct {
    name: ?[]const u8,
    id: ?u128,
    properties: Vec<([]const u8,
    skin: SkinPatch,
};
/// `PlayerSkin.Patch`: the optional body, cape and elytra texture ids and the
/// model type (`true` for slim).
pub const SkinPatch = struct {
    body: ?[]const u8,
    cape: ?[]const u8,
    elytra: ?[]const u8,
    slim: ?bool,
};
    // rust: impl SkinPatch {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let texture = |r: &mut Reader| -> Result<Option<String>> {
    // rust: if r.bool()? {
    // rust: Ok(Some(r.string(32767)?))
    // rust: } else {
    // rust: Ok(None)
}
}
    // rust: let (body, cape, elytra) = (texture(r)?, texture(r)?, texture(r)?);
    // rust: let slim = if r.bool()? { Some(r.bool()?) } else { None };
    // rust: Ok(Self {
    // rust: body,
    // rust: cape,
    // rust: elytra,
    // rust: slim,
    // rust: })
}
pub fn write(self: *Self, w: *mut Writer) void {
}
    // rust: for texture in [&self.body, &self.cape, &self.elytra] {
    // rust: w.bool(texture.is_some());
    // rust: if let Some(texture) = texture {
    // rust: w.string(texture);
}
}
    // rust: w.bool(self.slim.is_some());
    // rust: if let Some(slim) = self.slim {
    // rust: w.bool(slim);
}
}
}
    // rust: impl Component {
    // rust: pub(crate) fn read(kind: i32, r: &mut Reader) -> Result<Self> {
//         use component::*;
    // rust: Ok(match kind {
    // rust: MAX_STACK_SIZE
    // rust: | MAX_DAMAGE
    // rust: | DAMAGE
    // rust: | RARITY
    // rust: | REPAIR_COST
    // rust: | MAP_ID
    // rust: | MAP_POST_PROCESSING
    // rust: | OMINOUS_BOTTLE_AMPLIFIER => Self::Int(r.varint()?),
    // rust: WRITABLE_BOOK_CONTENT => {
    // rust: let n = r.count(100)?;
    // rust: let mut pages = (0..n)
    // rust: .map(|_| filterable(r, |r| r.string(1024)))
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: let (pages, filtered) = filtered_variants(&mut pages);
    // rust: Self::WritableBook { pages, filtered }
}
    // rust: WRITTEN_BOOK_CONTENT => {
    // rust: let (title, title_filtered) = filterable(r, |r| r.string(32))?;
    // rust: let author = r.string(32767)?;
    // rust: let generation = r.varint()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut pages = (0..n)
    // rust: .map(|_| filterable(r, |r| r.nbt()))
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: let (pages, pages_filtered) = filtered_variants(&mut pages);
    // rust: Self::WrittenBook(WrittenBook {
    // rust: title,
    // rust: title_filtered,
    // rust: author,
    // rust: generation,
    // rust: pages,
    // rust: pages_filtered,
    // rust: resolved: r.bool()?,
    // rust: })
}
    // rust: CHARGED_PROJECTILES | BUNDLE_CONTENTS => {
    // rust: let n = r.count(1024)?;
    // rust: Self::Stacks((0..n).map(|_| Template::read(r)).collect::<Result<_>>()?)
}
    // rust: DYED_COLOR => Self::Int(r.i32()?),
    // rust: UNBREAKABLE | CREATIVE_SLOT_LOCK => Self::Unit,
    // rust: ENCHANTMENT_GLINT_OVERRIDE => Self::Bool(r.bool()?),
    // rust: CUSTOM_NAME | ITEM_NAME => Self::Text(r.nbt()?),
    // rust: CUSTOM_DATA => Self::Nbt(r.nbt()?),
    // rust: ITEM_MODEL => Self::Ident(r.string(32767)?),
    // rust: LORE => {
    // rust: let n = r.count(256)?;
    // rust: Self::Lore((0..n).map(|_| r.nbt()).collect::<Result<_>>()?)
}
            // SuspiciousStewEffects.Entry.STREAM_CODEC: MobEffect.STREAM_CODEC
            // (the registry id), then the duration, both varints.
    // rust: SUSPICIOUS_STEW_EFFECTS => {
    // rust: let n = r.count(r.remaining())?;
    // rust: Self::StewEffects(
    // rust: (0..n)
    // rust: .map(|_| Ok((r.varint()?, r.varint()?)))
    // rust: .collect::<Result<_>>()?,
    // rust: )
}
    // rust: ENCHANTMENTS | STORED_ENCHANTMENTS => {
    // rust: let n = r.count(r.remaining())?;
    // rust: Self::Enchantments(
    // rust: (0..n)
    // rust: .map(|_| Ok((r.varint()?, r.varint()?)))
    // rust: .collect::<Result<_>>()?,
    // rust: )
}
    // rust: POTION_CONTENTS => {
    // rust: let potion = if r.bool()? { Some(r.varint()?) } else { None };
    // rust: let color = if r.bool()? { Some(r.i32()?) } else { None };
    // rust: let start = r.position();
    // rust: skip::potion_effects_and_name(r)?;
                // No custom effects and no name: an empty tail.
    // rust: let rest = match r.since(start) {
    // rust: [0, 0] => Vec::new(),
    // rust: bytes => bytes.to_vec(),
}
    // rust: Self::Potion {
    // rust: potion,
    // rust: color,
    // rust: rest,
}
}
    // rust: ATTACK_RANGE => {
    // rust: let mut values = [0.0f32; 6];
    // rust: for v in &mut values {
    // rust: *v = r.f32()?;
}
    // rust: Self::AttackRange(values)
}
    // rust: PROFILE => {
pub fn properties(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = r.count(1024)?;
    // rust: let mut out = Vec::with_capacity(n);
    // rust: for _ in 0..n {
    // rust: let name = r.string(32767)?;
    // rust: let value = r.string(32767)?;
    // rust: let signature = if r.bool()? {
    // rust: Some(r.string(32767)?)
    // rust: } else {
    // rust: None
}
    // rust: out.push((name, value, signature));
}
    // rust: Ok(out)
}
                // Either<GameProfile, Partial>: the partial form carries
                // optional fields, the resolved one a UUID, a name and the
                // properties.
    // rust: let (name, id, properties) = if r.u8()? == 0 {
    // rust: let name = if r.bool()? { Some(r.string(64)?) } else { None };
    // rust: let id = if r.bool()? { Some(r.uuid()?) } else { None };
    // rust: (name, id, properties(r)?)
    // rust: } else {
    // rust: let id = Some(r.uuid()?);
    // rust: let name = Some(r.string(64)?);
    // rust: (name, id, properties(r)?)
}
                // PlayerSkin.Patch: three texture ids and the model type.
    // rust: Self::Profile(Profile {
    // rust: name,
    // rust: id,
    // rust: properties,
    // rust: skin: SkinPatch::read(r)?,
    // rust: })
}
    // rust: CUSTOM_MODEL_DATA => {
    // rust: let n = r.count(r.remaining())?;
    // rust: let floats = (0..n).map(|_| r.f32()).collect::<Result<_>>()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: let flags = (0..n).map(|_| r.bool()).collect::<Result<_>>()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: let strings = (0..n).map(|_| r.string(32767)).collect::<Result<_>>()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: let colors = (0..n).map(|_| r.i32()).collect::<Result<_>>()?;
    // rust: Self::CustomModelData {
    // rust: floats,
    // rust: flags,
    // rust: strings,
    // rust: colors,
}
}
    // rust: TOOLTIP_DISPLAY => {
    // rust: let hide = r.bool()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut hidden = Vec::with_capacity(n.min(64));
    // rust: for _ in 0..n {
    // rust: let raw = r.varint()?;
                    // An older server's numbering, and components the pinned version lacks hide nothing.
    // rust: if ids::dropped_component(raw).is_none() {
    // rust: hidden.push(ids::component(raw));
}
}
    // rust: Self::TooltipDisplay { hide, hidden }
}
    // rust: FIREWORKS => {
    // rust: let flight = r.varint()?;
    // rust: let n = r.count(256)?;
    // rust: Self::Fireworks {
    // rust: flight,
    // rust: explosions: (0..n)
    // rust: .map(|_| FireworkExplosion::read(r))
    // rust: .collect::<Result<_>>()?,
}
}
    // rust: FIREWORK_EXPLOSION => Self::FireworkExplosion(FireworkExplosion::read(r)?),
    // rust: LODESTONE_TRACKER => {
    // rust: let target = if r.bool()? {
    // rust: Some((r.string(32767)?, unpack_block_pos(r.i64()?)))
    // rust: } else {
    // rust: None
}
    // rust: Self::LodestoneTracker {
    // rust: target,
    // rust: tracked: r.bool()?,
}
}
            // ArmorTrim.STREAM_CODEC: two holders, each a reference's id plus
            // one. A direct material or pattern has no registry name: read past.
    // rust: TRIM => {
    // rust: let start = r.position();
    // rust: skip::component(TRIM, r)?;
    // rust: let bytes = r.since(start);
    // rust: let mut ids = Reader::new(bytes);
    // rust: match (ids.varint(), ids.varint()) {
    // rust: (Ok(material @ 1..), Ok(pattern @ 1..)) if ids.remaining() == 0 => Self::Trim {
    // rust: material: material - 1,
    // rust: pattern: pattern - 1,
    // rust: },
    // rust: _ => Self::Raw(bytes.to_vec()),
}
}
            // InstrumentComponent.STREAM_CODEC: a holder, a reference's id plus one.
            // A direct instrument has no registry name: read past.
    // rust: INSTRUMENT => {
    // rust: let start = r.position();
    // rust: skip::component(INSTRUMENT, r)?;
    // rust: let bytes = r.since(start);
    // rust: let mut ids = Reader::new(bytes);
    // rust: match ids.varint() {
    // rust: Ok(id @ 1..) if ids.remaining() == 0 => Self::Instrument(id - 1),
    // rust: _ => Self::Raw(bytes.to_vec()),
}
}
            // Holder<PaintingVariant>: a reference's id plus one, or 0 and
            // the variant itself (no registry name: read past).
    // rust: PAINTING_VARIANT => {
    // rust: let start = r.position();
    // rust: skip::component(PAINTING_VARIANT, r)?;
    // rust: let bytes = r.since(start);
    // rust: let mut ids = Reader::new(bytes);
    // rust: match ids.varint() {
    // rust: Ok(id @ 1..) if ids.remaining() == 0 => Self::PaintingVariant(id - 1),
    // rust: _ => Self::Raw(bytes.to_vec()),
}
}
            // DyeColor.STREAM_CODEC: its id.
    // rust: BASE_COLOR => Self::Int(r.varint()?),
            // BannerPatternLayers.STREAM_CODEC: a list of a pattern holder (a
            // reference's id plus one, or 0 and the pattern itself) and a dye.
    // rust: BANNER_PATTERNS => {
    // rust: let start = r.position();
    // rust: skip::component(BANNER_PATTERNS, r)?;
    // rust: let bytes = r.since(start);
    // rust: match Self::banner_layers(bytes) {
    // rust: Some(layers) => Self::BannerPatterns(layers),
    // rust: None => Self::Raw(bytes.to_vec()),
}
}
    // rust: other if custom::contains(other) => Self::Nbt(r.nbt()?),
    // rust: other => {
    // rust: let start = r.position();
    // rust: skip::component(other, r)?;
    // rust: Self::Raw(r.since(start).to_vec())
}
    // rust: })
}
    /// The layers of encoded `BannerPatternLayers` whose patterns are all
    /// registry references (`None` when one is direct).
pub fn banner_layers(bytes: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(bytes);
    // rust: let n = r.count(r.remaining()).ok()?;
    // rust: let mut layers = Vec::with_capacity(n);
    // rust: for _ in 0..n {
    // rust: let pattern = r.varint().ok()?;
    // rust: let color = r.varint().ok()?;
    // rust: if pattern < 1 {
    // rust: return None;
}
    // rust: layers.push((pattern - 1, color));
}
    // rust: (r.remaining() == 0).then_some(layers)
}
    // rust: pub(crate) fn write(&self, kind: i32, w: &mut Writer) {
    // rust: match self {
    // rust: Self::Raw(bytes) => w.bytes(bytes),
    // rust: Self::BannerPatterns(layers) => {
    // rust: w.varint(layers.len() as i32);
    // rust: for (pattern, color) in layers {
    // rust: w.varint(pattern + 1);
    // rust: w.varint(*color);
}
}
    // rust: Self::Trim { material, pattern } => {
    // rust: w.varint(material + 1);
    // rust: w.varint(pattern + 1);
}
    // rust: Self::Instrument(id) => w.varint(id + 1),
    // rust: Self::PaintingVariant(id) => w.varint(id + 1),
    // rust: Self::Int(v) if kind == component::DYED_COLOR => w.i32(*v),
    // rust: Self::Int(v) => w.varint(*v),
    // rust: Self::Unit => {}
    // rust: Self::Bool(v) => w.bool(*v),
    // rust: Self::Text(t) | Self::Nbt(t) => w.nbt(t),
    // rust: Self::Ident(s) => w.string(s),
    // rust: Self::Lore(lines) => {
    // rust: w.varint(lines.len() as i32);
    // rust: lines.iter().for_each(|l| w.nbt(l));
}
    // rust: Self::Enchantments(list) | Self::StewEffects(list) => {
    // rust: w.varint(list.len() as i32);
    // rust: for (e, level) in list {
    // rust: w.varint(*e);
    // rust: w.varint(*level);
}
}
    // rust: Self::AttackRange(values) => values.iter().for_each(|v| w.f32(*v)),
    // rust: Self::Potion {
    // rust: potion,
    // rust: color,
    // rust: rest,
    // rust: } => {
    // rust: w.bool(potion.is_some());
    // rust: if let Some(id) = potion {
    // rust: w.varint(*id);
}
    // rust: w.bool(color.is_some());
    // rust: if let Some(color) = color {
    // rust: w.i32(*color);
}
                // An empty tail is no custom effects and no name.
    // rust: if rest.is_empty() {
    // rust: w.varint(0);
    // rust: w.bool(false);
    // rust: } else {
    // rust: w.bytes(rest);
}
}
    // rust: Self::Profile(p) => {
    // rust: w.u8(0);
    // rust: w.bool(p.name.is_some());
    // rust: if let Some(name) = &p.name {
    // rust: w.string(name);
}
    // rust: w.bool(p.id.is_some());
    // rust: if let Some(id) = p.id {
    // rust: w.uuid(id);
}
    // rust: w.varint(p.properties.len() as i32);
    // rust: for (name, value, signature) in &p.properties {
    // rust: w.string(name);
    // rust: w.string(value);
    // rust: w.bool(signature.is_some());
    // rust: if let Some(signature) = signature {
    // rust: w.string(signature);
}
}
    // rust: p.skin.write(w);
}
    // rust: Self::CustomModelData {
    // rust: floats,
    // rust: flags,
    // rust: strings,
    // rust: colors,
    // rust: } => {
    // rust: w.varint(floats.len() as i32);
    // rust: floats.iter().for_each(|f| w.f32(*f));
    // rust: w.varint(flags.len() as i32);
    // rust: flags.iter().for_each(|f| w.bool(*f));
    // rust: w.varint(strings.len() as i32);
    // rust: strings.iter().for_each(|s| w.string(s));
    // rust: w.varint(colors.len() as i32);
    // rust: colors.iter().for_each(|c| w.i32(*c));
}
    // rust: Self::TooltipDisplay { hide, hidden } => {
    // rust: w.bool(*hide);
    // rust: w.varint(hidden.len() as i32);
    // rust: hidden.iter().for_each(|h| w.varint(ids::component(*h)));
}
    // rust: Self::Stacks(stacks) => {
    // rust: w.varint(stacks.len() as i32);
    // rust: stacks.iter().for_each(|s| Template::write(s, w));
}
    // rust: Self::Fireworks { flight, explosions } => {
    // rust: w.varint(*flight);
    // rust: w.varint(explosions.len() as i32);
    // rust: explosions.iter().for_each(|e| e.write(w));
}
    // rust: Self::FireworkExplosion(e) => e.write(w),
    // rust: Self::LodestoneTracker { target, tracked } => {
    // rust: w.bool(target.is_some());
    // rust: if let Some((dimension, pos)) = target {
    // rust: w.string(dimension);
    // rust: w.i64(pack_block_pos(*pos));
}
    // rust: w.bool(*tracked);
}
    // rust: Self::WritableBook { pages, filtered } => {
    // rust: w.varint(pages.len() as i32);
    // rust: for (i, page) in pages.iter().enumerate() {
    // rust: w.string(page);
    // rust: match filtered.get(i).and_then(Option::as_ref) {
    // rust: Some(f) => {
    // rust: w.bool(true);
    // rust: w.string(f);
}
    // rust: None => w.bool(false),
}
}
}
    // rust: Self::WrittenBook(b) => {
    // rust: w.string(&b.title);
    // rust: match &b.title_filtered {
    // rust: Some(f) => {
    // rust: w.bool(true);
    // rust: w.string(f);
}
    // rust: None => w.bool(false),
}
    // rust: w.string(&b.author);
    // rust: w.varint(b.generation);
    // rust: w.varint(b.pages.len() as i32);
    // rust: for (i, page) in b.pages.iter().enumerate() {
    // rust: w.nbt(page);
    // rust: match b.pages_filtered.get(i).and_then(Option::as_ref) {
    // rust: Some(f) => {
    // rust: w.bool(true);
    // rust: w.nbt(f);
}
    // rust: None => w.bool(false),
}
}
    // rust: w.bool(b.resolved);
}
}
}
}

/// A component patch as `DelimitedSlot` writes it (both counts, then each
/// value behind its length), kept from a stack that was read so one nobody
/// edited goes back byte for byte. It is no part of a stack's equality.
pub const WirePatch = struct {};
    // rust: impl WirePatch {
    /// Whether a patch in this form sets component `kind`.
pub fn adds(patch: []const u8, kind: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(patch);
    // rust: let Ok(positive) = r.count(65536) else {
    // rust: return false;
}
    // rust: if r.count(65536).is_err() {
    // rust: return false;
}
    // rust: (0..positive).any(|_| {
    // rust: let Ok(k) = r.varint() else {
    // rust: return false;
}
    // rust: let Ok(len) = r.count(r.remaining()) else {
    // rust: return false;
}
    // rust: r.bytes(len).is_ok() && k == kind
    // rust: })
}
}
/// The `negative` removed component types of a patch: an older server's component the pinned version
/// lacks ([`ids::dropped_component`]) is left out.
pub fn read_removed(r: *mut Reader, negative: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut removed = Vec::with_capacity(negative.min(64));
    // rust: for _ in 0..negative {
    // rust: let raw = r.varint()?;
    // rust: if ids::dropped_component(raw).is_none() {
    // rust: removed.push(ids::component(raw));
}
}
    // rust: Ok(removed)
}

/// An added component `raw` (the sender's id) and its value from `r`: its pinned id, the value, and the
/// value's bytes in the pinned layout. An older server's component the pinned version lacks is read past
/// (`None`), and one whose layout changed since that server's version is read in its layout.
    // rust: fn read_added<'a>(
    // rust: raw: i32,
    // rust: r: &mut Reader<'a>,
    // rust: ) -> Result<Option<(i32, Component, std::borrow::Cow<'a, [u8]>)>> {
    // Every way a stack holds another passes through here.
    // rust: let _nested = Nested::enter()?;
    // rust: if let Some(name) = ids::dropped_component(raw) {
    // rust: skip_dropped(name, r)?;
    // rust: return Ok(None);
}
    // rust: let kind = ids::component(raw);
    // rust: match older_layout(kind, r)? {
    // rust: Older::Dropped => Ok(None),
    // rust: Older::Rewritten(bytes) => {
            // Already in the pinned numbering.
    // rust: let _pinned = ids::pinned();
    // rust: let component = Component::read(kind, &mut Reader::new(&bytes))?;
    // rust: Ok(Some((kind, component, bytes.into())))
}
    // rust: Older::Pinned => {
    // rust: let start = r.position();
    // rust: let component = Component::read(kind, r)?;
    // rust: Ok(Some((kind, component, r.since(start).into())))
}
}
}

/// How [`older_layout`] found a component of an older server.
pub const Older = enum {
    /// What is left of it reads as the pinned version's.
    Pinned,
    /// Read past: the pinned version can't hold it.
    Dropped,
    /// Read, and written again in the pinned layout.
    Rewritten(Vec<u8>),
};

/// `minecraft:brick` (26.3): an older pot's undecorated side.
pub const BRICK: i32 = 1142;

/// Reads the start of a component `kind` (a pinned id) whose layout changed since the version of the
/// server whose packet is read on this thread ([`ids::quirks`]).
pub fn older_layout(kind: i32, r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use component::*;
    // rust: let quirks = ids::quirks();
    // rust: Ok(match kind {
        // EitherHolder.streamCodec: ByteBufCodecs.either(the song's holder, its ResourceKey), a flag set
        // for the holder. A key names a song of the server's registry that the pinned holder can't point
        // to without its numbering.
    // rust: JUKEBOX_PLAYABLE if quirks.either_holder_song_and_tag_resistance => {
    // rust: if r.bool()? {
    // rust: Older::Pinned
    // rust: } else {
    // rust: r.string(32767)?;
    // rust: Older::Dropped
}
}
        // TagKey.streamCodec: the tag's id. A HolderSet names a tag behind a 0.
    // rust: DAMAGE_RESISTANT if quirks.either_holder_song_and_tag_resistance => {
    // rust: let tag = r.string(32767)?;
    // rust: let mut w = Writer::new();
    // rust: w.varint(0);
    // rust: w.string(&tag);
    // rust: Older::Rewritten(w.data)
}
        // ByteBufCodecs.registry(ITEM).apply(list(4)): back, left, right and front, a brick for none;
        // the pinned layout has four optional stack templates of one item and no components. The value
        // is kept as these bytes and sent on as they are, so its items take their pinned ids here.
    // rust: POT_DECORATIONS if quirks.pot_decorations_are_items => {
    // rust: let n = r.count(4)?;
    // rust: let items = (0..n)
    // rust: .map(|_| r.varint().map(ids::item))
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: let mut w = Writer::new();
    // rust: for side in 0..4 {
    // rust: match items.get(side).filter(|&&item| item != BRICK) {
    // rust: Some(&item) => {
    // rust: w.bool(true);
    // rust: w.varint(item);
    // rust: w.varint(1);
    // rust: w.varint(0);
    // rust: w.varint(0);
}
    // rust: None => w.bool(false),
}
}
    // rust: Older::Rewritten(w.data)
}
        // A value holding item stacks is kept as its bytes and sent on as they are: written again, its
        // items take their pinned ids and layout.
    // rust: USE_REMAINDER | SULFUR_CUBE_CONTENT if ids::reading_older() => {
    // rust: let stack = if quirks.stacks_in_components {
    // rust: Slot::read(r)?.ok_or_else(|| crate::Error::new("an empty use_remainder"))?
    // rust: } else {
    // rust: Template::read(r)?
}
    // rust: let mut w = Writer::new();
    // rust: let _pinned = ids::pinned();
    // rust: Template::write(&stack, &mut w);
    // rust: Older::Rewritten(w.data)
}
        // ItemContainerContents: up to 256 slots, each an optional template (ItemStack.OPTIONAL_STREAM_CODEC
        // before 26.1).
    // rust: CONTAINER if ids::reading_older() => {
    // rust: let n = r.count(256)?;
    // rust: let slots = (0..n)
    // rust: .map(|_| {
    // rust: if quirks.stacks_in_components {
    // rust: Slot::read(r)
    // rust: } else if r.bool()? {
    // rust: Template::read(r).map(Some)
    // rust: } else {
    // rust: Ok(None)
}
    // rust: })
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: let mut w = Writer::new();
    // rust: let _pinned = ids::pinned();
    // rust: w.varint(n as i32);
    // rust: for slot in &slots {
    // rust: w.bool(slot.is_some());
    // rust: if let Some(stack) = slot {
    // rust: Template::write(stack, &mut w);
}
}
    // rust: Older::Rewritten(w.data)
}
    // rust: _ => Older::Pinned,
    // rust: })
}

/// Reads past the value of `name`, a data component an older server sent that the pinned version lacks
/// ([`ids::dropped_component`]), as that server writes it.
pub fn skip_dropped(name: []const u8, r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
        // MapItemColor.STREAM_CODEC: ByteBufCodecs.INT.
    // rust: "minecraft:map_color" => r.i32().map(drop),
        // SwingAnimation.STREAM_CODEC: SwingAnimationType's id, then the duration, both VAR_INT.
    // rust: "minecraft:swing_animation" => {
    // rust: r.varint()?;
    // rust: r.varint().map(drop)
}
    // rust: _ => Err(crate::Error::new(format!(
    // rust: "{name}: a component the pinned version no longer has"
    // rust: ))),
}
}

    // rust: impl WirePatch {
    /// The components and removals a patch in this form holds, read as
    /// [`DelimitedSlot`] does.
pub fn decode(patch: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(patch);
    // rust: let positive = r.count(65536)?;
    // rust: let negative = r.count(65536)?;
    // rust: let mut added = Vec::with_capacity(positive.min(64));
    // rust: for _ in 0..positive {
    // rust: let raw = r.varint()?;
    // rust: let len = r.count(r.remaining())?;
    // rust: if let Some((kind, component, _)) = read_added(raw, &mut Reader::new(r.bytes(len)?))? {
    // rust: added.push((kind, component));
}
}
    // rust: Ok((added, read_removed(&mut r, negative)?))
}
}
    // rust: impl PartialEq for WirePatch {
pub fn eq(self: *Self, _: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
}

/// A non-empty item stack.
pub const Stack = struct {
    item: i32,
    count: i32,
    added: Vec<(i32,
    removed: std.ArrayList(i32),
    /// The patch as it was read; [`DelimitedSlot`] writes it in place of
    /// `added` and `removed` when set. Only for a stack nobody has edited.
    wire: WirePatch,
};
    // rust: impl Stack {
pub fn new(item: i32, count: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: item,
    // rust: count,
    // rust: added: Vec::new(),
    // rust: removed: Vec::new(),
    // rust: wire: WirePatch::default(),
}
}
pub fn component(self: *Self, kind: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.added.iter().find(|(k, _)| *k == kind).map(|(_, c)| c)
}
pub fn damage(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.component(component::DAMAGE) {
    // rust: Some(Component::Int(d)) => *d,
    // rust: _ => 0,
}
}
}
/// ItemStack.OPTIONAL_STREAM_CODEC: `None` is the empty stack (count 0).
pub const Slot = struct {};
    // rust: impl Codec<Option<Stack>> for Slot {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: read_stack(r, false)
}
pub fn write(v: *?Stack, w: *mut Writer) void {
}
    // rust: let Some(s) = v else {
    // rust: w.varint(0);
    // rust: return;
}
    // rust: w.varint(s.count);
    // rust: w.varint(ids::item(s.item));
    // rust: w.varint(s.added.len() as i32);
    // rust: w.varint(s.removed.len() as i32);
    // rust: for (kind, c) in &s.added {
    // rust: w.varint(ids::component(*kind));
    // rust: c.write(*kind, w);
}
    // rust: for kind in &s.removed {
    // rust: w.varint(ids::component(*kind));
}
}
}

/// A stack of either optional codec: with `delimited` each component value
/// has a length in front (DataComponentPatch.DELIMITED_STREAM_CODEC). The
/// patch is also kept, in the delimited form, for [`Stack::wire`].
pub fn read_stack(r: *mut Reader, delimited: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let count = r.varint()?;
    // rust: if count <= 0 {
    // rust: return Ok(None);
}
    // rust: let item = ids::item(r.varint()?);
    // rust: let positive = r.count(65536)?;
    // rust: let negative = r.count(65536)?;
    // rust: let mut added = Vec::with_capacity(positive.min(64));
    // rust: let mut values = Vec::with_capacity(positive.min(64));
    // rust: for _ in 0..positive {
    // rust: let raw = r.varint()?;
    // rust: let read = if delimited {
    // rust: let len = r.count(r.remaining())?;
    // rust: let mut component_reader = Reader::new(r.bytes(len)?);
    // rust: let read = read_added(raw, &mut component_reader)?;
    // rust: if read
    // rust: .as_ref()
    // rust: .is_some_and(|(kind, ..)| custom::contains(*kind))
    // rust: && component_reader.remaining() != 0
    // rust: {
    // rust: return Err(crate::Error::new("trailing custom component data"));
}
    // rust: read
    // rust: } else {
    // rust: read_added(raw, r)?
}
    // rust: if let Some((kind, component, value)) = read {
    // rust: values.push(value);
    // rust: added.push((kind, component));
}
}
    // rust: let removed = read_removed(r, negative)?;
    // rust: let mut patch = Writer::new();
    // rust: patch.varint(added.len() as i32);
    // rust: patch.varint(removed.len() as i32);
    // rust: for ((kind, _), value) in added.iter().zip(&values) {
    // rust: patch.varint(*kind);
    // rust: patch.byte_array(value);
}
    // rust: removed.iter().for_each(|kind| patch.varint(*kind));
    // rust: let wire = (!added.is_empty() || !removed.is_empty()).then(|| patch.data.into());
    // rust: Ok(Some(Stack {
    // rust: item,
    // rust: count,
    // rust: added,
    // rust: removed,
    // rust: wire: WirePatch(wire),
    // rust: }))
}

/// ItemStack.OPTIONAL_UNTRUSTED_STREAM_CODEC (`SetCreativeModeSlot`): as [`Slot`],
/// but every component value goes behind its byte length
/// (DataComponentPatch.DELIMITED_STREAM_CODEC), so a server skips what it can't read.
pub const DelimitedSlot = struct {};
    // rust: impl Codec<Option<Stack>> for DelimitedSlot {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: read_stack(r, true)
}
pub fn write(v: *?Stack, w: *mut Writer) void {
}
    // rust: let Some(s) = v else {
    // rust: w.varint(0);
    // rust: return;
}
    // rust: w.varint(s.count);
    // rust: w.varint(ids::item(s.item));
        // The patch as read holds the pinned version's component ids: written again from the values when
        // they are being renumbered.
    // rust: if let Some(patch) = &s.wire.0
    // rust: && ids::active().is_none()
    // rust: {
    // rust: w.bytes(patch);
    // rust: return;
}
    // rust: w.varint(s.added.len() as i32);
    // rust: w.varint(s.removed.len() as i32);
    // rust: for (kind, c) in &s.added {
    // rust: w.varint(ids::component(*kind));
    // rust: let mut value = Writer::new();
    // rust: c.write(*kind, &mut value);
    // rust: w.byte_array(&value.data);
}
    // rust: for kind in &s.removed {
    // rust: w.varint(ids::component(*kind));
}
}
}

/// ItemStackTemplate.STREAM_CODEC: the item, the count, then the patch.
pub const Template = struct {};
    // rust: impl Codec<Stack> for Template {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let item = ids::item(r.varint()?);
    // rust: let count = r.varint()?;
    // rust: let positive = r.count(65536)?;
    // rust: let negative = r.count(65536)?;
    // rust: let mut added = Vec::with_capacity(positive.min(64));
    // rust: for _ in 0..positive {
    // rust: let raw = r.varint()?;
    // rust: if let Some((kind, component, _)) = read_added(raw, r)? {
    // rust: added.push((kind, component));
}
}
    // rust: let removed = read_removed(r, negative)?;
    // rust: Ok(Stack {
    // rust: item,
    // rust: count,
    // rust: added,
    // rust: removed,
    // rust: wire: WirePatch::default(),
    // rust: })
}
pub fn write(s: *Stack, w: *mut Writer) void {
}
    // rust: w.varint(ids::item(s.item));
    // rust: w.varint(s.count);
    // rust: w.varint(s.added.len() as i32);
    // rust: w.varint(s.removed.len() as i32);
    // rust: for (kind, c) in &s.added {
    // rust: w.varint(ids::component(*kind));
    // rust: c.write(*kind, w);
}
    // rust: for kind in &s.removed {
    // rust: w.varint(ids::component(*kind));
}
}
}

/// HashedStack: what the client believes a slot holds. Component values are
/// sent as hashes ([`Hashed::create`]).
pub const Hashed = struct {
    item: i32,
    count: i32,
    added: Vec<(i32,
    removed: std.ArrayList(i32),
};
    // rust: impl Hashed {
    /// The stack hashed without registry names: only components that hold no
    /// registry id get a hash (see [`Hashed::create`]).
pub fn of(stack: *Stack) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::create(stack, &NoNames)
}
}
pub const HashedSlot = struct {};
    // rust: impl Codec<Option<Hashed>> for HashedSlot {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !r.bool()? {
    // rust: return Ok(None);
}
    // rust: let item = r.varint()?;
    // rust: let count = r.varint()?;
    // rust: let n = r.count(256)?;
    // rust: let added = (0..n)
    // rust: .map(|_| Ok((r.varint()?, r.i32()?)))
    // rust: .collect::<Result<_>>()?;
    // rust: let n = r.count(256)?;
    // rust: let removed = (0..n).map(|_| r.varint()).collect::<Result<_>>()?;
    // rust: Ok(Some(Hashed {
    // rust: item,
    // rust: count,
    // rust: added,
    // rust: removed,
    // rust: }))
}
pub fn write(v: *?Hashed, w: *mut Writer) void {
}
    // rust: w.bool(v.is_some());
    // rust: if let Some(h) = v {
    // rust: w.varint(ids::item(h.item));
    // rust: w.varint(h.count);
    // rust: w.varint(h.added.len() as i32);
    // rust: for (k, hash) in &h.added {
    // rust: w.varint(ids::component(*k));
    // rust: w.i32(*hash);
}
    // rust: w.varint(h.removed.len() as i32);
    // rust: for k in &h.removed {
    // rust: w.varint(ids::component(*k));
}
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::text::literal;

    // rust: fn round<T: PartialEq + std::fmt::Debug, C: Codec<T>>(v: T) {
    // rust: let mut w = Writer::new();
    // rust: C::write(&v, &mut w);
    // rust: let mut r = Reader::new(&w.data);
    // rust: assert_eq!(C::read(&mut r).unwrap(), v);
    // rust: assert_eq!(r.remaining(), 0);
}

    /// A stack holding bundles `depth` deep, each the only stack in the one around it.
pub fn nested_bundles(depth: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
        // count (or item) 1, item (or count) 1, one added component, none removed: bundle_contents, one stack.
    // rust: let level = [1, 1, 1, 0, component::BUNDLE_CONTENTS as u8, 1];
    // rust: let mut bytes = level.repeat(depth);
    // rust: bytes.extend([1, 1, 0, 0]);
    // rust: bytes
}

    /// Decodes `bytes` as a slot on a thread with the 2 MiB stack network threads get.
pub fn read_on_network_stack(bytes: std.ArrayList(u8)) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::thread::Builder::new()
    // rust: .stack_size(2 << 20)
    // rust: .spawn(move || Slot::read(&mut Reader::new(&bytes)))
    // rust: .unwrap()
    // rust: .join()
    // rust: .unwrap()
}

pub fn items_nested_without_end_are_refused_instead_of_overflowing_the_stack() void {
}
        // About 1.2 MB, under the 2 MiB frame cap: without a limit this aborts the process.
    // rust: assert!(read_on_network_stack(nested_bundles(200_000)).is_err());
        // A potion whose effect hides an effect that hides another, 200,000 times over.
    // rust: let mut potion = vec![1, 1, 1, 0, component::POTION_CONTENTS as u8, 0, 0, 1, 5];
    // rust: potion.extend([0, 1, 0, 0, 0, 1].repeat(200_000));
    // rust: potion.extend([0, 1, 0, 0, 0, 0, 0]);
    // rust: assert!(read_on_network_stack(potion).is_err());
}

pub fn deeply_nested_bundles_still_decode() void {
}
    // rust: let bytes = nested_bundles(MAX_NESTING as usize);
    // rust: let mut stack = read_on_network_stack(bytes.clone()).unwrap().unwrap();
    // rust: let mut depth = 0;
    // rust: while let Some(Component::Stacks(inner)) = stack.component(component::BUNDLE_CONTENTS) {
    // rust: stack = inner[0].clone();
    // rust: depth += 1;
}
    // rust: assert_eq!(depth, MAX_NESTING);
        // A refused stack leaves nothing counted behind on its thread.
    // rust: assert!(Slot::read(&mut Reader::new(&nested_bundles(MAX_NESTING as usize + 1))).is_err());
    // rust: assert!(Slot::read(&mut Reader::new(&bytes)).unwrap().is_some());
}

pub fn a_wire_patch_tells_what_it_adds() void {
}
        // Two added components (damage 3, then can_break's bytes as read)
        // and one removed.
    // rust: let mut w = Writer::new();
    // rust: w.varint(2);
    // rust: w.varint(1);
    // rust: w.varint(component::DAMAGE);
    // rust: w.byte_array(&[3]);
    // rust: w.varint(component::CAN_BREAK);
    // rust: w.byte_array(&[1, 0, 0, 0, 0, 0]);
    // rust: w.varint(component::ENCHANTMENTS);
    // rust: assert!(WirePatch::adds(&w.data, component::DAMAGE));
    // rust: assert!(WirePatch::adds(&w.data, component::CAN_BREAK));
    // rust: assert!(!WirePatch::adds(&w.data, component::ENCHANTMENTS));
    // rust: assert!(!WirePatch::adds(&[], component::CAN_BREAK));
}

pub fn potion_contents_round_trip() void {
}
    // rust: let mut arrow = Stack::new(7, 3);
    // rust: arrow.added.push((
    // rust: component::POTION_CONTENTS,
    // rust: Component::Potion {
    // rust: potion: Some(31),
    // rust: color: None,
    // rust: rest: Vec::new(),
    // rust: },
    // rust: ));
    // rust: round::<Option<Stack>, Slot>(Some(arrow));
        // A custom colour, one custom effect (speed II for 600 ticks, shown,
        // no hidden effect) and a custom name survive as they came.
    // rust: let mut w = Writer::new();
    // rust: w.bool(false);
    // rust: w.bool(true);
    // rust: w.i32(0x00FF_8800);
    // rust: w.varint(1);
    // rust: for v in [1, 1, 600] {
    // rust: w.varint(v);
}
    // rust: for b in [false, true, true, false] {
    // rust: w.bool(b);
}
    // rust: w.bool(true);
    // rust: w.string("Tea");
    // rust: let mut r = Reader::new(&w.data);
    // rust: let read = Component::read(component::POTION_CONTENTS, &mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0);
    // rust: let Component::Potion {
    // rust: potion,
    // rust: color,
    // rust: rest,
    // rust: } = &read
    // rust: else {
    // rust: panic!("{read:?}");
}
    // rust: assert_eq!((*potion, *color), (None, Some(0x00FF_8800)));
    // rust: assert!(!rest.is_empty());
    // rust: let mut again = Writer::new();
    // rust: read.write(component::POTION_CONTENTS, &mut again);
    // rust: assert_eq!(again.data, w.data);
}

pub fn stacks_round_trip() void {
}
    // rust: round::<Option<Stack>, Slot>(None);
    // rust: round::<Option<Stack>, Slot>(Some(Stack::new(42, 64)));
    // rust: let mut sword = Stack::new(900, 1);
    // rust: sword.added.push((component::DAMAGE, Component::Int(17)));
    // rust: sword.added.push((
    // rust: component::CUSTOM_NAME,
    // rust: Component::Text(literal("Excalibur")),
    // rust: ));
    // rust: sword.added.push((
    // rust: component::ENCHANTMENTS,
    // rust: Component::Enchantments(vec![(5, 3), (12, 1)]),
    // rust: ));
    // rust: sword
    // rust: .added
    // rust: .push((component::DYED_COLOR, Component::Int(-6265536)));
    // rust: sword.added.push((
    // rust: component::LORE,
    // rust: Component::Lore(vec![literal("a"), literal("b")]),
    // rust: ));
    // rust: sword.removed.push(component::REPAIR_COST);
    // rust: let mut book = Stack::new(1100, 1);
    // rust: book.added.push((
    // rust: component::WRITTEN_BOOK_CONTENT,
    // rust: Component::WrittenBook(WrittenBook {
    // rust: title: "Notes".into(),
    // rust: author: "Guest".into(),
    // rust: generation: 1,
    // rust: pages: vec![literal("one"), literal("two")],
    // rust: pages_filtered: vec![None, Some(literal("2"))],
    // rust: title_filtered: Some("N".into()),
    // rust: resolved: true,
    // rust: }),
    // rust: ));
    // rust: book.added
    // rust: .push((component::MAP_POST_PROCESSING, Component::Int(1)));
    // rust: round::<Option<Stack>, Slot>(Some(book));
        // OminousBottleAmplifier.STREAM_CODEC: a VarInt.
    // rust: let mut bottle = Stack::new(1200, 1);
    // rust: bottle
    // rust: .added
    // rust: .push((component::OMINOUS_BOTTLE_AMPLIFIER, Component::Int(3)));
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&Some(bottle.clone()), &mut w);
    // rust: assert_eq!(w.data, [1, 0xb0, 0x09, 1, 0, 65, 3]);
    // rust: round::<Option<Stack>, Slot>(Some(bottle));
    // rust: let mut quill = Stack::new(1099, 1);
    // rust: quill.added.push((
    // rust: component::WRITABLE_BOOK_CONTENT,
    // rust: Component::WritableBook {
    // rust: pages: vec!["a".into(), String::new()],
    // rust: filtered: vec![None, Some("b".into())],
    // rust: },
    // rust: ));
    // rust: round::<Option<Stack>, Slot>(Some(quill));
    // rust: assert_eq!(sword.damage(), 17);
    // rust: round::<Option<Stack>, Slot>(Some(sword.clone()));
    // rust: round::<Option<Hashed>, HashedSlot>(Some(Hashed::of(&sword)));
    // rust: round::<Option<Hashed>, HashedSlot>(None);
}

pub fn fireworks_components_round_trip() void {
}
    // rust: let mut rocket = Stack::new(42, 1);
    // rust: rocket.added.push((
    // rust: component::FIREWORKS,
    // rust: Component::Fireworks {
    // rust: flight: 3,
    // rust: explosions: vec![
    // rust: FireworkExplosion {
    // rust: shape: 4,
    // rust: colors: vec![0xff0000, 0x00ff00],
    // rust: fade: vec![0x0000ff],
    // rust: trail: true,
    // rust: twinkle: false,
    // rust: },
    // rust: FireworkExplosion {
    // rust: shape: 0,
    // rust: colors: vec![],
    // rust: fade: vec![],
    // rust: trail: false,
    // rust: twinkle: true,
    // rust: },
    // rust: ],
    // rust: },
    // rust: ));
    // rust: rocket.added.push((
    // rust: component::FIREWORK_EXPLOSION,
    // rust: Component::FireworkExplosion(FireworkExplosion {
    // rust: shape: 2,
    // rust: colors: vec![7],
    // rust: fade: vec![],
    // rust: trail: false,
    // rust: twinkle: false,
    // rust: }),
    // rust: ));
    // rust: round::<Option<Stack>, Slot>(Some(rocket));
}

pub fn charged_projectiles_are_item_stack_templates() void {
}
        // A crossbow (id 7) loaded with one arrow (id 9): ChargedProjectiles
        // is a list of ItemStackTemplate, the item before the count.
    // rust: let bytes = [1, 7, 1, 0, 51, 1, 9, 1, 0, 0];
    // rust: let stack = Slot::read(&mut Reader::new(&bytes)).unwrap().unwrap();
    // rust: assert_eq!(
    // rust: stack.component(component::CHARGED_PROJECTILES),
    // rust: Some(&Component::Stacks(vec![Stack::new(9, 1)]))
    // rust: );
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&Some(stack), &mut w);
    // rust: assert_eq!(w.data, bytes);
}

pub fn bundle_contents_are_item_stack_templates() void {
}
        // A bundle (id 7) holding 32 of item 9: BundleContents is a list of
        // ItemStackTemplate, as ChargedProjectiles is.
    // rust: let bytes = [1, 7, 1, 0, 52, 1, 9, 32, 0, 0];
    // rust: let stack = Slot::read(&mut Reader::new(&bytes)).unwrap().unwrap();
    // rust: assert_eq!(
    // rust: stack.component(component::BUNDLE_CONTENTS),
    // rust: Some(&Component::Stacks(vec![Stack::new(9, 32)]))
    // rust: );
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&Some(stack), &mut w);
    // rust: assert_eq!(w.data, bytes);
}

pub fn filtered_book_pages_are_read_and_kept() void {
}
        // A writable book with one page "hi" and its filtered "**".
    // rust: let bytes = [1, 7, 1, 0, 56, 1, 2, b'h', b'i', 1, 2, b'*', b'*'];
    // rust: let stack = Slot::read(&mut Reader::new(&bytes)).unwrap().unwrap();
    // rust: assert_eq!(
    // rust: stack.component(component::WRITABLE_BOOK_CONTENT),
    // rust: Some(&Component::WritableBook {
    // rust: pages: vec!["hi".into()],
    // rust: filtered: vec![Some("**".into())],
    // rust: })
    // rust: );
}

pub fn empty_stack_is_a_zero_count() void {
}
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&None, &mut w);
    // rust: assert_eq!(w.data, [0]);
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&Some(Stack::new(1, 2)), &mut w);
    // rust: assert_eq!(w.data, [2, 1, 0, 0]);
}

pub fn unknown_components_are_errors() void {
}
        // 122 is past DataComponents' last id (cushion_color, 121).
    // rust: let bytes = [1, 5, 1, 0, 122];
    // rust: assert!(Slot::read(&mut Reader::new(&bytes)).is_err());
}

pub fn attack_range_and_profiles_round_trip() void {
}
    // rust: let mut sword = Stack::new(900, 1);
    // rust: sword.added.push((
    // rust: component::ATTACK_RANGE,
    // rust: Component::AttackRange([0.0, 3.0, 0.0, 4.0, 0.1, 1.0]),
    // rust: ));
    // rust: sword.added.push((
    // rust: component::PROFILE,
    // rust: Component::Profile(Profile {
    // rust: name: Some("Player53470".into()),
    // rust: id: Some(0x7a5d_6a1a_30d7_4187_88c5_efe9_1201_8922),
    // rust: properties: vec![("textures".into(), "dGV4dHVyZXM=".into(), None)],
    // rust: skin: SkinPatch {
    // rust: body: Some("minecraft:entity/player/wide/steve".into()),
    // rust: cape: None,
    // rust: elytra: None,
    // rust: slim: Some(true),
    // rust: },
    // rust: }),
    // rust: ));
    // rust: round::<Option<Stack>, Slot>(Some(sword));
}

pub fn a_partial_profile_decodes_from_the_wire() void {
}
        // count 1, item 1, one added component of kind 72 (profile): a partial
        // profile with an empty name, a UUID, one unsigned texture property
        // and an empty skin patch.
    // rust: let uuid = [
    // rust: 0x7a, 0x5d, 0x6a, 0x1a, 0x30, 0xd7, 0x41, 0x87, 0x88, 0xc5, 0xef, 0xe9, 0x12, 0x01,
    // rust: 0x89, 0x22,
    // rust: ];
    // rust: let mut bytes = vec![1, 1, 1, 0, 72, 0, 1, 0, 1];
    // rust: bytes.extend_from_slice(&uuid);
    // rust: bytes.extend_from_slice(&[1, 8]);
    // rust: bytes.extend_from_slice(b"textures");
    // rust: bytes.extend_from_slice(&[1, b'x', 0, 0, 0, 0, 0]);
    // rust: let mut r = Reader::new(&bytes);
    // rust: let stack = Slot::read(&mut r).unwrap().unwrap();
    // rust: assert_eq!(r.remaining(), 0);
    // rust: let Some(Component::Profile(profile)) = stack.component(component::PROFILE) else {
    // rust: panic!("the profile component did not decode");
}
    // rust: assert_eq!(profile.name.as_deref(), Some(""));
    // rust: assert_eq!(profile.id, Some(0x7a5d_6a1a_30d7_4187_88c5_efe9_1201_8922));
    // rust: assert_eq!(
    // rust: profile.properties,
    // rust: [("textures".to_owned(), "x".to_owned(), None)]
    // rust: );
}

pub fn components_read_past_keep_their_bytes() void {
}
        // Vanilla 26.3's encoding (tools/test_item_wire_parity.py) of a chestplate's
        // armour trim (decoded: both holders are references), a banner's patterns
        // (one direct), a pot's sherds and a stew's effects: one server's
        // inventory, recipe book and advancements had them.
    // rust: for (hex, kind) in [
    // rust: ("01bd0801003a0502", 58),
    // rust: ("01890b01004a02200e000b6d696e6563726166743a7801790b", 74),
    // rust: ("01880301004c01f60801000001be0c0100000001d30c010000", 76),
    // rust: ("01a408010037020f6412a001", 55),
            // A goat horn's instrument by reference (InstrumentComponent's holder).
    // rust: ("01bd0801003f02", 63),
    // rust: ] {
    // rust: let bytes: Vec<u8> = (0..hex.len())
    // rust: .step_by(2)
    // rust: .map(|i| u8::from_str_radix(&hex[i..i + 2], 16).unwrap())
    // rust: .collect();
    // rust: let mut r = Reader::new(&bytes);
    // rust: let stack = Slot::read(&mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0, "component {kind}");
    // rust: let expected = |c: &Component| match kind {
    // rust: 58 => {
    // rust: *c == Component::Trim {
    // rust: material: 4,
    // rust: pattern: 1,
}
}
                // night_vision for 100 ticks, poison for the default 160.
    // rust: 55 => *c == Component::StewEffects(vec![(15, 100), (18, 160)]),
    // rust: 63 => *c == Component::Instrument(1),
    // rust: _ => matches!(c, Component::Raw(_)),
}
    // rust: assert!(
    // rust: stack
    // rust: .as_ref()
    // rust: .and_then(|s| s.component(kind))
    // rust: .is_some_and(expected)
    // rust: );
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&stack, &mut w);
    // rust: assert_eq!(w.data, bytes, "component {kind}");
}
}

pub fn painting_variants_decode_by_reference() void {
}
        // Holder<PaintingVariant>: a reference (its id plus one) is typed; a
        // direct variant (0, width, height, asset id, no title, no author)
        // is read past. Both encode back to the same bytes.
    // rust: let asset = b"minecraft:x";
    // rust: let mut direct = vec![1u8, 7, 1, 0, 109, 0, 2, 1, asset.len() as u8];
    // rust: direct.extend_from_slice(asset);
    // rust: direct.extend_from_slice(&[0, 0]);
    // rust: for (bytes, expected) in [
    // rust: (
    // rust: vec![1u8, 7, 1, 0, 109, 5],
    // rust: Some(Component::PaintingVariant(4)),
    // rust: ),
    // rust: (direct, None),
    // rust: ] {
    // rust: let mut r = Reader::new(&bytes);
    // rust: let stack = Slot::read(&mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0);
    // rust: let c = stack
    // rust: .as_ref()
    // rust: .and_then(|s| s.component(component::PAINTING_VARIANT))
    // rust: .unwrap();
    // rust: match &expected {
    // rust: Some(e) => assert_eq!(c, e),
    // rust: None => assert!(matches!(c, Component::Raw(_))),
}
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&stack, &mut w);
    // rust: assert_eq!(w.data, bytes);
}
}
}
