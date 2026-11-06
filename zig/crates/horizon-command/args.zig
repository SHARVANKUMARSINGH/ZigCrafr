//! Transpiled from Horizon Rust crate
//! Module: horizon-command_args
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Argument types (Brigadier's and Minecraft's `ArgumentType`s): parsing with
//! the vanilla error messages and completion suggestions.
// use super::{CmdResult, CommandError, Context, Reader, SuggestionsBuilder};

    // rust: pub use horizon_client_core::registries::{
    // rust: CustomCompletionAction, Registries, RegistryIds, modify_custom_completions,
}

pub const Resource = enum {
    EntityType,
    Effect,
    Enchantment,
    Structure,
    Biome,
    Clock,
    Timeline,
};
    // rust: impl Resource {
pub fn registry(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Resource::EntityType => "minecraft:entity_type",
    // rust: Resource::Effect => "minecraft:mob_effect",
    // rust: Resource::Enchantment => "minecraft:enchantment",
    // rust: Resource::Structure => "minecraft:worldgen/structure",
    // rust: Resource::Biome => "minecraft:worldgen/biome",
    // rust: Resource::Clock => "minecraft:world_clock",
    // rust: Resource::Timeline => "minecraft:timeline",
}
}
}

pub const ArgType = enum {
    Bool,
    Integer {,
    min: i32,
    max: i32,
    // rust: },
    Float {,
    min: f32,
    max: f32,
    // rust: },
    Double {,
    min: f64,
    max: f64,
    // rust: },
    Word,
    Str,
    Greedy,
    Entity {,
    single: bool,
    players: bool,
    // rust: },
    BlockPos,
    Vec3 {,
    center: bool,
    // rust: },
    Rotation,
    Angle,
    Item,
    ItemPredicate,
    BlockState,
    BlockPredicate,
    Resource(Resource),
    /// A plain identifier; suggestions come from the named list.
    Id(&'static str),
    /// ResourceArgument over a registry (the element must exist).
    Res(&'static str),
    /// ResourceKeyArgument (checked when the command runs).
    ResKey(&'static str),
    /// ResourceOrTagArgument (elements and tags must exist).
    ResOrTag(&'static str),
    /// ResourceOrTagKeyArgument.
    ResOrTagKey(&'static str),
    /// StringRepresentableArgument-like: one of the names, with the error key.
    StrEnum(&'static [&'static str], &'static str),
    /// HexColorArgument.
    HexColor,
    /// UuidArgument.
    Uuid,
    /// GameProfileArgument.
    GameProfile,
    Time {,
    min: i32,
    // rust: },
    GameMode,
    Message,
    Dimension,
    Anchor,
    /// SwizzleArgument: a set of `x`, `y` and `z` (kept as text).
    Swizzle,
    /// ComponentArgument: an SNBT/JSON text component (kept as JSON text).
    Component,
    /// StyleArgument: an SNBT style map.
    Style,
    /// CompoundTagArgument (kept as SNBT text).
    Nbt,
    /// ScoreHolderArgument.
    ScoreHolder {,
    multiple: bool,
    // rust: },
    /// ObjectiveArgument (checked when the command runs).
    Objective,
    /// TeamArgument (checked when the command runs).
    Team,
    /// ObjectiveCriteriaArgument.
    Criteria,
    /// ScoreboardSlotArgument.
    ScoreboardSlot,
    /// OperationArgument.
    Operation,
    /// TeamColorArgument.
    TeamColor,
    /// RangeArgument.Ints (`1`, `1..`, `..5`, `1..5`).
    IntRange,
    FloatRange,
    /// NbtPathArgument (kept as text).
    NbtPath,
    /// NbtTagArgument: any SNBT value (kept as text).
    NbtTag,
    /// Vec2Argument: `x z` with `~` relative parts.
    Vec2,
    /// ColumnPosArgument: block `x z`.
    ColumnPos,
    /// ParticleArgument: a particle id and its options (kept as text).
    Particle,
    /// One of a fixed set of words.
    Enum(&'static [&'static str]),
    /// A (possibly quoted) name suggested from a registry list.
    Name(&'static str),
    /// FunctionArgument: `ns:path`, or `#ns:path` for a function tag.
    Function,
    /// SlotsArgument: a slot name or a wildcard group (`container.*`).
    Slots,
    /// SlotArgument: one slot (`container.5`, `weapon.mainhand`).
    Slot,
    /// SlotSourceArgument: a slot range name, or a slot source id or inline value.
    SlotSource,
    /// ResourceOrIdArgument over a registry: an id or an inline SNBT value.
    ResourceOrId(&'static str),
    /// ResourceSelectorArgument: a `*`/`?` pattern over a registry's ids.
    ResourceSelector(&'static str),
};

/// FilenameUtils.wildcardMatch (case-sensitive) of `*` and `?` patterns.
pub fn wildcard_match(text: []const u8, pattern: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t: Vec<char> = text.chars().collect();
    // rust: let p: Vec<char> = pattern.chars().collect();
    // rust: let (mut ti, mut pi) = (0, 0);
    // rust: let (mut star, mut mark) = (None, 0);
    // rust: while ti < t.len() {
    // rust: if pi < p.len() && (p[pi] == '?' || p[pi] == t[ti]) {
    // rust: ti += 1;
    // rust: pi += 1;
    // rust: } else if pi < p.len() && p[pi] == '*' {
    // rust: star = Some(pi);
    // rust: mark = ti;
    // rust: pi += 1;
    // rust: } else if let Some(s) = star {
    // rust: pi = s + 1;
    // rust: mark += 1;
    // rust: ti = mark;
    // rust: } else {
    // rust: return false;
}
}
    // rust: while pi < p.len() && p[pi] == '*' {
    // rust: pi += 1;
}
    // rust: pi == p.len()
}
/// ResourceSelectorArgument: the registry ids a pattern selects.
    // rust: pub fn select_resources<'a>(ids: &'a [String], pattern: &str) -> Vec<&'a String> {
    // rust: let pattern = if pattern.contains(':') {
    // rust: pattern.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{pattern}")
}
    // rust: ids.iter()
    // rust: .filter(|id| wildcard_match(id, &pattern))
    // rust: .collect()
}

/// SlotRanges.SLOTS: every slot range name and its size, in vanilla order.
pub fn slot_ranges() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v: Vec<(String, usize)> = Vec::new();
    // rust: let range = |v: &mut Vec<(String, usize)>, prefix: &str, n: usize| {
    // rust: for i in 0..n {
    // rust: v.push((format!("{prefix}{i}"), 1));
}
    // rust: v.push((format!("{prefix}*"), n));
}
    // rust: v.push(("contents".into(), 1));
    // rust: range(&mut v, "container.", 54);
    // rust: range(&mut v, "hotbar.", 9);
    // rust: range(&mut v, "inventory.", 27);
    // rust: range(&mut v, "enderchest.", 27);
    // rust: range(&mut v, "mob.inventory.", 8);
    // rust: range(&mut v, "horse.", 15);
    // rust: for (name, n) in [
    // rust: ("weapon", 1),
    // rust: ("weapon.mainhand", 1),
    // rust: ("weapon.offhand", 1),
    // rust: ("weapon.*", 2),
    // rust: ("armor.head", 1),
    // rust: ("armor.chest", 1),
    // rust: ("armor.legs", 1),
    // rust: ("armor.feet", 1),
    // rust: ("armor.body", 1),
    // rust: ("armor.*", 5),
    // rust: ("saddle", 1),
    // rust: ("horse.chest", 1),
    // rust: ("player.cursor", 1),
    // rust: ] {
    // rust: v.push((name.to_owned(), n));
}
    // rust: range(&mut v, "player.crafting.", 4);
    // rust: v
}
/// Single-slot names (SlotRanges.singleSlotNames).
pub fn slot_names() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: slot_ranges()
    // rust: .into_iter()
    // rust: .filter(|(_, n)| *n == 1)
    // rust: .map(|(s, _)| s)
    // rust: .collect()
}
pub fn integer(min: i32) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ArgType::Integer { min, max: i32::MAX }
}

pub const Coord = struct {
    relative: bool,
    value: f64,
};
    // rust: impl Coord {
pub fn get(self: *Self, base: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.relative {
    // rust: base + self.value
    // rust: } else {
    // rust: self.value
}
}
}
pub const Coordinates = enum {
    World([Coord; 3]),
    Local([f64; 3]),
};
    // rust: impl Coordinates {
    /// WorldCoordinates/LocalCoordinates.getPosition from the source position
    /// (feet) and rotation (yaw, pitch in degrees).
pub fn position(self: *Self, pos: [f64; 3], rot: [f32; 2]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Coordinates::World(c) => [c[0].get(pos[0]), c[1].get(pos[1]), c[2].get(pos[2])],
    // rust: Coordinates::Local([left, up, forwards]) => {
    // rust: let d = std::f32::consts::PI / 180.0;
    // rust: let (yaw, pitch) = (rot[0], rot[1]);
    // rust: let cos_y = ((yaw + 90.0) * d).cos();
    // rust: let sin_y = ((yaw + 90.0) * d).sin();
    // rust: let cos_p = (-pitch * d).cos();
    // rust: let sin_p = (-pitch * d).sin();
    // rust: let cos_p2 = ((-pitch + 90.0) * d).cos();
    // rust: let sin_p2 = ((-pitch + 90.0) * d).sin();
    // rust: let f = [
    // rust: f64::from(cos_y * cos_p),
    // rust: f64::from(sin_p),
    // rust: f64::from(sin_y * cos_p),
    // rust: ];
    // rust: let u = [
    // rust: f64::from(cos_y * cos_p2),
    // rust: f64::from(sin_p2),
    // rust: f64::from(sin_y * cos_p2),
    // rust: ];
                // left = -(forward x up)
    // rust: let l = [
    // rust: -(f[1] * u[2] - f[2] * u[1]),
    // rust: -(f[2] * u[0] - f[0] * u[2]),
    // rust: -(f[0] * u[1] - f[1] * u[0]),
    // rust: ];
    // rust: [
    // rust: pos[0] + f[0] * forwards + u[0] * up + l[0] * left,
    // rust: pos[1] + f[1] * forwards + u[1] * up + l[1] * left,
    // rust: pos[2] + f[2] * forwards + u[2] * up + l[2] * left,
    // rust: ]
}
}
}
pub fn block(self: *Self, pos: [f64; 3], rot: [f32; 2]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = self.position(pos, rot);
    // rust: [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ]
}
    /// RotationArgument: (yaw, pitch) from the source rotation.
pub fn rotation(self: *Self, rot: [f32; 2]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Coordinates::World(c) => [
    // rust: c[0].get(f64::from(rot[0])) as f32,
    // rust: c[1].get(f64::from(rot[1])) as f32,
    // rust: ],
    // rust: Coordinates::Local(_) => rot,
}
}
}
pub const Sort = enum {
    Arbitrary,
    Nearest,
    Furthest,
    Random,
};
    // rust: pub type DoubleRange = (Option<f64>, Option<f64>);
    // rust: pub type IntRange = (Option<i32>, Option<i32>);
/// A parsed entity selector (EntitySelector) or player name.
pub const Selector = struct {
    player_name: ?[]const u8,
    /// The entity UUID when the argument was one.
    uuid: ?u128,
    /// 'p', 'a', 'r', 's', 'e', 'n'.
    kind: char,
    limit: usize,
    sort: Sort,
    include_entities: bool,
    types: Vec<([]const u8,
    names: Vec<([]const u8,
    tags: Vec<([]const u8,
    gamemodes: Vec<([]const u8,
    distance: ?DoubleRange,
    level: ?IntRange,
    x_rotation: ?DoubleRange,
    y_rotation: ?DoubleRange,
    pos: [?f64,
    delta: [?f64,
    /// `scores={objective=range,...}`.
    scores: Vec<([]const u8,
    /// `team=` (an empty name matches entities without a team).
    teams: Vec<([]const u8,
    /// `nbt=` compounds (SNBT text).
    nbt: Vec<([]const u8,
    /// `advancements={id=true|{criterion=true}}`.
    advancements: Vec<([]const u8,
    /// `predicate=` ids.
    predicates: Vec<([]const u8,
};
/// An `advancements=` entry: all done or not, or per-criterion states.
pub const AdvCondition = enum {
    Done(bool),
    Criteria(Vec<(String, bool)>),
};
/// A `ScoreHolderArgument` value.
pub const ScoreHolderArg = enum {
    Wildcard,
    Name(String),
    Selector(Selector),
};
    // rust: impl Selector {
pub fn is_self(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.kind == 's'
}
pub fn single(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.limit <= 1
}
    /// `EntitySelectorParser.setWorldLimited`: a selector with a spatial
    /// constraint (`distance` or a position) reaches the level the command
    /// runs in only; an unbounded one reaches every loaded level.
pub fn world_limited(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.distance.is_some()
    // rust: || self.pos.iter().any(Option::is_some)
    // rust: || self.delta.iter().any(Option::is_some)
}
}
pub const BlockInput = struct {
    id: []const u8,
    properties: Vec<([]const u8,
    /// `#tag` for block predicates.
    tag: bool,
    nbt: ?[]const u8,
};
pub const ItemInput = struct {
    id: []const u8,
    tag: bool,
    any: bool,
    components: ?[]const u8,
};
pub const GameMode = enum {
    Survival,
    Creative,
    Adventure,
    Spectator,
};
    // rust: impl GameMode {
    // rust: pub const ALL: [GameMode; 4] = [
    // rust: GameMode::Survival,
    // rust: GameMode::Creative,
    // rust: GameMode::Adventure,
    // rust: GameMode::Spectator,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: GameMode::Survival => "survival",
    // rust: GameMode::Creative => "creative",
    // rust: GameMode::Adventure => "adventure",
    // rust: GameMode::Spectator => "spectator",
}
}
pub fn from_name(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|m| m.name() == s)
}
}
pub const Arg = enum {
    Bool(bool),
    Int(i32),
    Float(f32),
    Double(f64),
    Str(String),
    Entity(Selector),
    Coords(Coordinates),
    Angle(Coord),
    Item(ItemInput),
    Block(BlockInput),
    Resource(String),
    GameMode(GameMode),
    /// `eyes` (true) or `feet`.
    Anchor(bool),
    ScoreHolder(ScoreHolderArg),
    IntRange(IntRange),
    DoubleRange(DoubleRange),
};

pub fn is_id_char(c: char) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: c.is_ascii_lowercase() || c.is_ascii_digit() || matches!(c, '_' | '-' | '.' | ':' | '/')
}
/// Identifier.read: the longest run of identifier characters, normalised to
/// the `minecraft` namespace (an empty path is valid).
pub fn read_id(reader: *mut Reader) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: read_identifier(reader)
}
/// Identifier.read.
pub fn read_identifier(reader: *mut Reader) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = reader.cursor;
    // rust: while reader.can_read() && is_id_char(reader.peek()) {
    // rust: reader.skip();
}
    // rust: let raw = &reader.string[start..reader.cursor];
    // rust: match parse_identifier(raw) {
    // rust: Some(id) => Ok(id),
    // rust: None => {
    // rust: reader.cursor = start;
    // rust: Err(CommandError::tr_at("argument.id.invalid", &[], reader))
}
}
}
    // rust: pub use horizon_client_core::identifier::parse_identifier;
pub fn normalize(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id.split_once(':') {
    // rust: Some(("", path)) => format!("minecraft:{path}"),
    // rust: Some(_) => id.to_owned(),
    // rust: None => format!("minecraft:{id}"),
}
}
/// SharedSuggestionProvider.matchesSubStr: `input` is a prefix of
/// `candidate` or of a part after a `.`, `_` or `/`.
pub fn matches_sub_str(input: []const u8, candidate: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut index = 0;
    // rust: loop {
    // rust: if candidate[index..].starts_with(input) {
    // rust: return true;
}
    // rust: match candidate[index..].find(['.', '_', '/']) {
    // rust: Some(i) => index += i + 1,
    // rust: None => return false,
}
}
}
/// SharedSuggestionProvider.filterResources (no prefix).
pub fn resource_matches(contents: []const u8, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if contents.contains(':') {
    // rust: matches_sub_str(contents, id)
    // rust: } else {
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: matches_sub_str(contents, ns) || matches_sub_str(contents, path)
}
}
/// SharedSuggestionProvider.suggestResource (with an optional prefix such as `#`).
    // rust: pub fn suggest_resources<'a>(
    // rust: builder: &mut SuggestionsBuilder,
    // rust: ids: impl IntoIterator<Item = &'a String>,
    // rust: prefix: &str,
    // rust: ) {
    // rust: let contents = builder.remaining_lower();
    // rust: if prefix.is_empty() {
    // rust: for id in ids {
    // rust: if resource_matches(&contents, id) {
    // rust: builder.suggest(id.clone());
}
}
    // rust: return;
}
    // rust: if contents.is_empty() {
    // rust: for id in ids {
    // rust: builder.suggest(format!("{prefix}{id}"));
}
    // rust: return;
}
    // rust: let common = contents
    // rust: .chars()
    // rust: .zip(prefix.chars())
    // rust: .take_while(|(a, b)| a == b)
    // rust: .map(|(a, _)| a.len_utf8())
    // rust: .sum::<usize>();
    // rust: if common == 0 {
    // rust: return;
}
    // rust: let stripped = &contents[common..];
    // rust: for id in ids {
    // rust: if resource_matches(stripped, id) {
    // rust: builder.suggest(format!("{prefix}{id}"));
}
}
}
/// MinMaxBounds.Bounds.fromReader: `a`, `a..`, `..b` or `a..b`, each part
/// converted by `convert` (errors rewound to the start).
    // rust: fn read_bounds<T: Copy>(
    // rust: reader: &mut Reader,
    // rust: convert: impl Fn(&str) -> Option<T>,
    // rust: invalid: &str,
    // rust: ) -> CmdResult<(Option<T>, Option<T>)> {
    // rust: if !reader.can_read() {
    // rust: return Err(CommandError::tr_at("argument.range.empty", &[], reader));
}
    // rust: let start = reader.cursor;
    // rust: let number = |reader: &mut Reader| -> CmdResult<Option<T>> {
    // rust: let s = reader.cursor;
    // rust: while reader.can_read() {
    // rust: let c = reader.peek();
    // rust: let allowed = c.is_ascii_digit()
    // rust: || c == '-'
    // rust: || (c == '.' && !(reader.can_read_n(2) && reader.peek_at(1) == '.'));
    // rust: if !allowed {
    // rust: break;
}
    // rust: reader.skip();
}
    // rust: let text = &reader.string[s..reader.cursor];
    // rust: if text.is_empty() {
    // rust: return Ok(None);
}
    // rust: match convert(text) {
    // rust: Some(v) => Ok(Some(v)),
    // rust: None => Err(CommandError::tr_at(invalid, &[&text], reader)),
}
}
    // rust: let result = (|| {
    // rust: let min = number(reader)?;
    // rust: let max = if reader.can_read_n(2) && reader.peek() == '.' && reader.peek_at(1) == '.' {
    // rust: reader.skip();
    // rust: reader.skip();
    // rust: number(reader)?
    // rust: } else {
    // rust: min
}
    // rust: if min.is_none() && max.is_none() {
    // rust: return Err(CommandError::tr_at("argument.range.empty", &[], reader));
}
    // rust: Ok((min, max))
    // rust: })();
    // rust: result.map_err(|mut e| {
    // rust: reader.cursor = start;
    // rust: e.cursor = start;
    // rust: e
    // rust: })
}
/// MinMaxBounds.Ints.fromReader.
pub fn read_int_bounds(reader: *mut Reader) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = reader.cursor;
    // rust: let b = read_bounds(reader, java_parse_int, "parsing.int.invalid")?;
    // rust: if let (Some(l), Some(h)) = b
    // rust: && l > h
    // rust: {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at("argument.range.swapped", &[], reader));
}
    // rust: Ok(b)
}
/// MinMaxBounds.Doubles.fromReader.
pub fn read_double_bounds(reader: *mut Reader) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = reader.cursor;
    // rust: let b = read_bounds(reader, java_parse_double, "parsing.double.invalid")?;
    // rust: if let (Some(l), Some(h)) = b
    // rust: && l > h
    // rust: {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at("argument.range.swapped", &[], reader));
}
    // rust: Ok(b)
}
/// MinMaxBounds.FloatDegrees.fromReader (no swap check).
pub fn read_float_bounds(reader: *mut Reader) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: read_bounds(
    // rust: reader,
    // rust: |s| java_parse_double(s).map(|v| v as f32),
    // rust: "parsing.float.invalid",
    // rust: )
}
/// Integer.parseInt over number characters.
pub fn java_parse_int(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let digits = s.strip_prefix(['-', '+']).unwrap_or(s);
    // rust: if digits.is_empty() || !digits.chars().all(|c| c.is_ascii_digit()) {
    // rust: return None;
}
    // rust: s.parse().ok()
}
/// Double.parseDouble over the characters StringReader reads as a number.
pub fn java_parse_double(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = s.trim_matches(|c: char| c <= ' ');
    // rust: let body = t.strip_prefix(['-', '+']).unwrap_or(t);
    // rust: if body.is_empty() || body == "." {
    // rust: return None;
}
    // rust: let body = body.strip_suffix(['d', 'D', 'f', 'F']).unwrap_or(body);
    // rust: if body == "NaN" || body == "Infinity" {
    // rust: return t.parse::<f64>().ok().or(Some(if t.starts_with('-') {
    // rust: f64::NEG_INFINITY
    // rust: } else if body == "NaN" {
    // rust: f64::NAN
    // rust: } else {
    // rust: f64::INFINITY
    // rust: }));
}
    // rust: let mut chars = body.chars().peekable();
    // rust: let mut digits = 0;
    // rust: while chars.peek().is_some_and(char::is_ascii_digit) {
    // rust: chars.next();
    // rust: digits += 1;
}
    // rust: if chars.peek() == Some(&'.') {
    // rust: chars.next();
    // rust: while chars.peek().is_some_and(char::is_ascii_digit) {
    // rust: chars.next();
    // rust: digits += 1;
}
}
    // rust: if digits == 0 {
    // rust: return None;
}
    // rust: if matches!(chars.peek(), Some('e' | 'E')) {
    // rust: chars.next();
    // rust: if matches!(chars.peek(), Some('+' | '-')) {
    // rust: chars.next();
}
    // rust: let mut exp = 0;
    // rust: while chars.peek().is_some_and(char::is_ascii_digit) {
    // rust: chars.next();
    // rust: exp += 1;
}
    // rust: if exp == 0 {
    // rust: return None;
}
}
    // rust: if chars.next().is_some() {
    // rust: return None;
}
    // rust: let clean: String = t
    // rust: .trim_end_matches(['d', 'D', 'f', 'F'])
    // rust: .trim_start_matches('+')
    // rust: .to_owned();
    // rust: clean.parse::<f64>().ok()
}
pub fn parse_coord_int(reader: *mut Reader) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if reader.can_read() && reader.peek() == '^' {
    // rust: return Err(CommandError::tr_at("argument.pos.mixed", &[], reader));
}
    // rust: if !reader.can_read() {
    // rust: return Err(CommandError::tr_at("argument.pos.missing.int", &[], reader));
}
    // rust: let relative = reader.peek() == '~';
    // rust: if relative {
    // rust: reader.skip();
}
    // rust: let value = if reader.can_read() && reader.peek() != ' ' {
    // rust: if relative {
    // rust: reader.read_double()?
    // rust: } else {
    // rust: f64::from(reader.read_int()?)
}
    // rust: } else {
    // rust: 0.0
}
    // rust: Ok(Coord { relative, value })
}
pub fn parse_coord_double(reader: *mut Reader, center: bool) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if reader.can_read() && reader.peek() == '^' {
    // rust: return Err(CommandError::tr_at("argument.pos.mixed", &[], reader));
}
    // rust: if !reader.can_read() {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.pos.missing.double",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: let relative = reader.peek() == '~';
    // rust: if relative {
    // rust: reader.skip();
}
    // rust: let start = reader.cursor;
    // rust: let mut value = if reader.can_read() && reader.peek() != ' ' {
    // rust: reader.read_double()?
    // rust: } else {
    // rust: 0.0
}
    // rust: let number = &reader.string[start..reader.cursor];
    // rust: if relative && number.is_empty() {
    // rust: return Ok(Coord {
    // rust: relative,
    // rust: value: 0.0,
    // rust: });
}
    // rust: if !number.contains('.') && !relative && center {
    // rust: value += 0.5;
}
    // rust: Ok(Coord { relative, value })
}
/// LocalCoordinates.parse / readDouble.
pub fn parse_local(reader: *mut Reader) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = reader.cursor;
    // rust: let mut v = [0.0; 3];
    // rust: for (i, slot) in v.iter_mut().enumerate() {
    // rust: if i > 0 {
    // rust: if !reader.can_read() || reader.peek() != ' ' {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.pos3d.incomplete",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: reader.skip();
}
    // rust: if !reader.can_read() {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.pos.missing.double",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: if reader.peek() != '^' {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at("argument.pos.mixed", &[], reader));
}
    // rust: reader.skip();
    // rust: *slot = if reader.can_read() && reader.peek() != ' ' {
    // rust: reader.read_double()?
    // rust: } else {
    // rust: 0.0
}
}
    // rust: Ok(Coordinates::Local(v))
}
pub fn parse_world(reader: *mut Reader, block: bool, center: bool) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = reader.cursor;
    // rust: let mut c = [Coord {
    // rust: relative: false,
    // rust: value: 0.0,
    // rust: }; 3];
    // rust: for (i, slot) in c.iter_mut().enumerate() {
    // rust: if i > 0 {
    // rust: if !reader.can_read() || reader.peek() != ' ' {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.pos3d.incomplete",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: reader.skip();
}
    // rust: *slot = if block {
    // rust: parse_coord_int(reader)?
    // rust: } else {
    // rust: parse_coord_double(reader, center && i != 1)?
}
}
    // rust: Ok(Coordinates::World(c))
}
/// String.split(" "): trailing empty strings are dropped.
pub fn java_split(s: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut parts: Vec<&str> = s.split(' ').collect();
    // rust: while parts.len() > 1 && parts.last() == Some(&"") {
    // rust: parts.pop();
}
    // rust: if parts == [""] && !s.is_empty() {
    // rust: parts.clear();
}
    // rust: parts
}
/// SharedSuggestionProvider.suggestCoordinates / suggest2DCoordinates: the
/// candidates `ty` parses completely. `relevant` arguments (block and column
/// positions) offer the targeted block (`getRelevantCoordinates`), the others
/// (`Vec3`, `Vec2`) the exact hit point (`getAbsoluteCoordinates`).
    // rust: fn suggest_coordinates(
    // rust: builder: &mut SuggestionsBuilder,
    // rust: reg: &Registries,
    // rust: ty: &ArgType,
    // rust: relevant: bool,
    // rust: ) {
    // rust: let remaining = builder.remaining().to_owned();
    // rust: let three = matches!(ty, ArgType::BlockPos | ArgType::Vec3 { .. });
    // rust: let coords: [String; 3] = if remaining.starts_with('^') {
    // rust: ["^".into(), "^".into(), "^".into()]
    // rust: } else if let (true, Some(t)) = (relevant, reg.target_block) {
    // rust: [t[0].to_string(), t[1].to_string(), t[2].to_string()]
    // rust: } else if let (false, Some(p)) = (relevant, &reg.target_point) {
    // rust: p.clone()
    // rust: } else {
    // rust: ["~".into(), "~".into(), "~".into()]
}
    // rust: let valid = |text: &str| {
    // rust: let mut r = Reader::new(text);
    // rust: ty.parse(&mut r, reg).is_ok()
}
    // rust: let mut result: Vec<String> = Vec::new();
    // rust: let [x, y, z] = &coords;
    // rust: if remaining.is_empty() {
    // rust: let full = if three {
    // rust: format!("{x} {y} {z}")
    // rust: } else {
    // rust: format!("{x} {z}")
}
    // rust: if valid(&full) {
    // rust: result.push(x.clone());
    // rust: if three {
    // rust: result.push(format!("{x} {y}"));
}
    // rust: result.push(full);
}
    // rust: } else {
    // rust: let fields = java_split(&remaining);
    // rust: match (fields.len(), three) {
    // rust: (1, true) => {
    // rust: let full = format!("{} {y} {z}", fields[0]);
    // rust: if valid(&full) {
    // rust: result.push(format!("{} {y}", fields[0]));
    // rust: result.push(full);
}
}
    // rust: (2, true) => {
    // rust: let full = format!("{} {} {z}", fields[0], fields[1]);
    // rust: if valid(&full) {
    // rust: result.push(full);
}
}
    // rust: (1, false) => {
    // rust: let full = format!("{} {z}", fields[0]);
    // rust: if valid(&full) {
    // rust: result.push(full);
}
}
    // rust: _ => {}
}
}
    // rust: builder.suggest_matching(result.iter().map(String::as_str));
}

pub const OPERATIONS: [[]const u8; 9] = ["=", "+=", "-=", "*=", "/=", "%=", "<", ">", "><"];
/// NbtPathArgument.parse (validation; the path is kept as text).
pub fn parse_nbt_path(reader: *mut Reader) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let invalid = |r: &Reader| CommandError::tr_at("arguments.nbtpath.node.invalid", &[], r);
    // rust: let object_node = |reader: &mut Reader, name: &str| -> CmdResult<()> {
    // rust: if name.is_empty() {
    // rust: return Err(invalid(reader));
}
    // rust: if reader.can_read() && reader.peek() == '{' {
    // rust: super::snbt::parse_compound_argument(reader)?;
}
    // rust: Ok(())
}
    // rust: let mut first = true;
    // rust: while reader.can_read() && reader.peek() != ' ' {
    // rust: match reader.peek() {
    // rust: '"' | '\'' => {
    // rust: let name = reader.read_string()?;
    // rust: object_node(reader, &name)?;
}
    // rust: '[' => {
    // rust: reader.skip();
    // rust: if !reader.can_read() {
                    // StringReader.peek past the end (StringIndexOutOfBoundsException).
    // rust: let len = reader.string.encode_utf16().count();
    // rust: let message = format!("Index {len} out of bounds for length {len}");
    // rust: return Err(CommandError::tr_at(
    // rust: "command.exception",
    // rust: &[&message],
    // rust: reader,
    // rust: ));
}
    // rust: match reader.peek() {
    // rust: '{' => {
    // rust: super::snbt::parse_compound_argument(reader)?;
    // rust: reader.expect(']')?;
}
    // rust: ']' => reader.skip(),
    // rust: _ => {
    // rust: reader.read_int()?;
    // rust: reader.expect(']')?;
}
}
}
    // rust: '{' => {
    // rust: if !first {
    // rust: return Err(invalid(reader));
}
    // rust: super::snbt::parse_compound_argument(reader)?;
}
    // rust: _ => {
    // rust: let s = reader.cursor;
    // rust: while reader.can_read()
    // rust: && !matches!(
    // rust: reader.peek(),
    // rust: ' ' | '"' | '\'' | '[' | ']' | '.' | '{' | '}'
    // rust: )
    // rust: {
    // rust: reader.skip();
}
    // rust: if reader.cursor == s {
    // rust: return Err(invalid(reader));
}
    // rust: let name = reader.string[s..reader.cursor].to_owned();
    // rust: object_node(reader, &name)?;
}
}
    // rust: first = false;
    // rust: if reader.can_read() {
    // rust: let next = reader.peek();
    // rust: if next != ' ' && next != '[' && next != '{' {
    // rust: reader.expect('.')?;
}
}
}
    // rust: Ok(())
}
/// The required fields of each particle type's options codec (declaration order).
pub fn particle_fields(id: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id.trim_start_matches("minecraft:") {
    // rust: "block" | "block_marker" | "falling_dust" | "dust_pillar" | "block_crumble" => {
    // rust: &["block_state"]
}
    // rust: "geyser" | "geyser_plume" => &["water_blocks"],
    // rust: "geyser_base" | "geyser_poof" => &["water_blocks", "burst_impulse_base"],
    // rust: "dust" => &["color", "scale"],
    // rust: "dust_color_transition" => &["from_color", "to_color", "scale"],
    // rust: "entity_effect" | "tinted_leaves" | "flash" => &["color"],
    // rust: "sculk_charge" => &["roll"],
    // rust: "item" => &["item"],
    // rust: "vibration" => &["destination", "arrival_in_ticks"],
    // rust: "trail" => &["target", "color", "duration"],
    // rust: "shriek" => &["delay"],
    // rust: _ => &[],
}
}
/// The particle type's codec over the options (MapCodec field errors, newest first).
pub fn particle_options(id: []const u8, t: *horizon_world::nbt::Tag) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use super::codec::{get, no_key, not_map, snbt};
    // rust: let horizon_world::nbt::Tag::Compound(map) = t else {
    // rust: return Err(not_map(t));
}
    // rust: let missing: Vec<String> = particle_fields(id)
    // rust: .iter()
    // rust: .rev()
    // rust: .filter(|f| get(map, f).is_none())
    // rust: .map(|f| no_key(f, t))
    // rust: .collect();
    // rust: if !missing.is_empty() {
    // rust: return Err(missing.join("; "));
}
    // rust: if particle_fields(id) == ["block_state"]
    // rust: && let Some(state) = get(map, "block_state")
    // rust: && !matches!(state, horizon_world::nbt::Tag::String(_))
    // rust: {
        // withAlternative(BlockState.CODEC, the block id codec).
    // rust: let first = match state {
    // rust: horizon_world::nbt::Tag::Compound(_) => {
    // rust: super::codec::either("Not a string".into(), no_key("id", state))
}
    // rust: _ => not_map(state),
}
    // rust: let _ = snbt;
    // rust: return Err(super::codec::either(first, "Not a string".into()));
}
    // rust: Ok(())
}
/// TimeArgument units.
pub fn time_unit(unit: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match unit {
    // rust: "" | "t" => Some(1),
    // rust: "s" => Some(20),
    // rust: "d" => Some(24000),
    // rust: _ => None,
}
}

    // rust: impl ArgType {
pub fn parse(self: *Self, reader: *mut Reader, reg: *Registries) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = reader.cursor;
    // rust: Ok(match self {
    // rust: ArgType::Bool => Arg::Bool(reader.read_boolean()?),
    // rust: ArgType::Integer { min, max } => {
    // rust: let v = reader.read_int()?;
    // rust: if v < *min {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.integer.low",
    // rust: &[min, &v],
    // rust: reader,
    // rust: ));
}
    // rust: if v > *max {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.integer.big",
    // rust: &[max, &v],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Int(v)
}
    // rust: ArgType::Float { min, max } => {
    // rust: let v = reader.read_float()?;
    // rust: if v < *min {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.float.low",
    // rust: &[
    // rust: &horizon_client_core::snbt::java_float(*min),
    // rust: &horizon_client_core::snbt::java_float(v),
    // rust: ],
    // rust: reader,
    // rust: ));
}
    // rust: if v > *max {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.float.big",
    // rust: &[
    // rust: &horizon_client_core::snbt::java_float(*max),
    // rust: &horizon_client_core::snbt::java_float(v),
    // rust: ],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Float(v)
}
    // rust: ArgType::Double { min, max } => {
    // rust: let v = reader.read_double()?;
    // rust: if v < *min {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.double.low",
    // rust: &[
    // rust: &horizon_client_core::snbt::java_double(*min),
    // rust: &horizon_client_core::snbt::java_double(v),
    // rust: ],
    // rust: reader,
    // rust: ));
}
    // rust: if v > *max {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.double.big",
    // rust: &[
    // rust: &horizon_client_core::snbt::java_double(*max),
    // rust: &horizon_client_core::snbt::java_double(v),
    // rust: ],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Double(v)
}
    // rust: ArgType::Word => Arg::Str(reader.read_unquoted_string().to_owned()),
    // rust: ArgType::Str => Arg::Str(reader.read_string()?),
    // rust: ArgType::Greedy => {
    // rust: let s = reader.remaining().to_owned();
    // rust: reader.cursor = reader.string.len();
    // rust: Arg::Str(s)
}
    // rust: ArgType::Message => {
                // MessageArgument.Message.parseText.
    // rust: let len = reader.remaining().encode_utf16().count();
    // rust: if len > 256 {
    // rust: return Err(CommandError::tr("argument.message.too_long", &[&len, &256]));
}
    // rust: let s = reader.remaining().to_owned();
    // rust: if reg.permission >= 2 {
    // rust: while reader.can_read() {
    // rust: if reader.peek() == '@' {
    // rust: let at = reader.cursor;
    // rust: if let Err(e) = super::selector::parse(reader, reg, true) {
    // rust: let key = e.key.as_str();
    // rust: if key != "argument.entity.selector.missing"
    // rust: && key != "argument.entity.selector.unknown"
    // rust: {
    // rust: return Err(e);
}
    // rust: reader.cursor = at + 1;
}
    // rust: } else {
    // rust: reader.skip();
}
}
}
    // rust: reader.cursor = reader.string.len();
    // rust: Arg::Str(s)
}
    // rust: ArgType::Entity { single, players } => {
    // rust: let s = super::selector::parse(reader, reg, reg.permission >= 2)?;
                // Vanilla rewinds to the very start of the input for these.
    // rust: if s.limit > 1 && *single {
    // rust: reader.cursor = 0;
    // rust: let key = if *players {
    // rust: "argument.player.toomany"
    // rust: } else {
    // rust: "argument.entity.toomany"
}
    // rust: return Err(CommandError::tr_at(key, &[], reader));
}
    // rust: if s.include_entities && *players && !s.is_self() {
    // rust: reader.cursor = 0;
    // rust: return Err(CommandError::tr_at("argument.player.entities", &[], reader));
}
    // rust: Arg::Entity(s)
}
    // rust: ArgType::BlockPos => {
    // rust: if reader.can_read() && reader.peek() == '^' {
    // rust: Arg::Coords(parse_local(reader)?)
    // rust: } else {
    // rust: Arg::Coords(parse_world(reader, true, false)?)
}
}
    // rust: ArgType::Vec3 { center } => {
    // rust: if reader.can_read() && reader.peek() == '^' {
    // rust: Arg::Coords(parse_local(reader)?)
    // rust: } else {
    // rust: Arg::Coords(parse_world(reader, false, *center)?)
}
}
    // rust: ArgType::Rotation => {
    // rust: if !reader.can_read() {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.rotation.incomplete",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: let yaw = parse_coord_double(reader, false)?;
    // rust: if !reader.can_read() || reader.peek() != ' ' {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.rotation.incomplete",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: reader.skip();
    // rust: let pitch = parse_coord_double(reader, false)?;
    // rust: Arg::Coords(Coordinates::World([
    // rust: yaw,
    // rust: pitch,
    // rust: Coord {
    // rust: relative: true,
    // rust: value: 0.0,
    // rust: },
    // rust: ]))
}
    // rust: ArgType::Angle => {
    // rust: if !reader.can_read() {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.angle.incomplete",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: let relative = reader.peek() == '~';
    // rust: if relative {
    // rust: reader.skip();
}
    // rust: let value = if reader.can_read() && reader.peek() != ' ' {
    // rust: f64::from(reader.read_float()?)
    // rust: } else {
    // rust: 0.0
}
    // rust: if value.is_nan() || value.is_infinite() {
    // rust: return Err(CommandError::tr_at("argument.angle.invalid", &[], reader));
}
    // rust: Arg::Angle(Coord { relative, value })
}
    // rust: ArgType::Item => Arg::Item(super::item::parse_stack(reader, reg)?),
    // rust: ArgType::ItemPredicate => Arg::Item(super::item::parse_predicate(reader, reg)?),
    // rust: ArgType::BlockState => Arg::Block(super::block::parse(reader, reg, false)?),
    // rust: ArgType::BlockPredicate => Arg::Block(super::block::parse(reader, reg, true)?),
    // rust: ArgType::Resource(kind) => {
                // ResourceArgument: the element must exist.
    // rust: let id = read_identifier(reader)?;
    // rust: let registry = kind.registry();
    // rust: if !reg.ids(registry).contains(&id) {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.resource.not_found",
    // rust: &[&id, &registry],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Resource(id)
}
    // rust: ArgType::Res(registry) => {
    // rust: let id = read_identifier(reader)?;
    // rust: if !reg.ids(registry).contains(&id) {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.resource.not_found",
    // rust: &[&id, registry],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Resource(id)
}
    // rust: ArgType::ResKey(_) => Arg::Resource(read_identifier(reader)?),
    // rust: ArgType::ResOrTag(registry) | ArgType::ResOrTagKey(registry) => {
    // rust: let key_only = matches!(self, ArgType::ResOrTagKey(_));
    // rust: if reader.can_read() && reader.peek() == '#' {
    // rust: let cursor = reader.cursor;
    // rust: reader.skip();
    // rust: let id = match read_identifier(reader) {
    // rust: Ok(id) => id,
    // rust: Err(e) => {
    // rust: reader.cursor = cursor;
    // rust: return Err(e);
}
}
    // rust: if !key_only && !reg.tags(registry).contains(&id) {
    // rust: let e = CommandError::tr_at(
    // rust: "argument.resource_tag.not_found",
    // rust: &[&id, registry],
    // rust: reader,
    // rust: );
    // rust: reader.cursor = cursor;
    // rust: return Err(e);
}
    // rust: Arg::Resource(format!("#{id}"))
    // rust: } else {
    // rust: let id = read_identifier(reader)?;
    // rust: if !key_only && !reg.ids(registry).contains(&id) {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.resource.not_found",
    // rust: &[&id, registry],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Resource(id)
}
}
    // rust: ArgType::StrEnum(values, key) => {
                // StringRepresentableArgument (the error follows the word).
    // rust: let name = reader.read_unquoted_string();
    // rust: if !values.contains(&name) {
    // rust: return Err(CommandError::tr_at(key, &[&name], reader));
}
    // rust: Arg::Str(name.to_owned())
}
    // rust: ArgType::ResourceSelector(registry) => {
    // rust: let start = reader.cursor;
    // rust: while reader.can_read() && {
    // rust: let c = reader.peek();
    // rust: is_id_char(c) || c == '*' || c == '?'
    // rust: } {
    // rust: reader.skip();
}
    // rust: let raw = reader.string[start..reader.cursor].to_owned();
    // rust: let pattern = if raw.contains(':') {
    // rust: raw
    // rust: } else {
    // rust: format!("minecraft:{raw}")
}
    // rust: if select_resources(reg.ids(registry), &pattern).is_empty() {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.resource_selector.not_found",
    // rust: &[&pattern, registry],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Str(pattern)
}
    // rust: ArgType::HexColor => {
    // rust: let text = reader.read_unquoted_string();
    // rust: if !matches!(text.len(), 3 | 6) {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.hexcolor.invalid",
    // rust: &[&text],
    // rust: reader,
    // rust: ));
}
                // Integer.parseInt(s, begin, end, 16) per channel: a bad digit
                // escapes Brigadier as a dispatcher parse exception.
    // rust: let width = text.len() / 3;
    // rust: for chunk in text.as_bytes().chunks(width) {
    // rust: let c = std::str::from_utf8(chunk).unwrap_or("");
    // rust: let signed = c.len() > 1 && (c.starts_with('+') || c.starts_with('-'));
    // rust: let digits = if signed { &c[1..] } else { c };
    // rust: if let Some(i) = digits.find(|ch: char| !ch.is_ascii_hexdigit()) {
    // rust: let index = i + usize::from(signed);
    // rust: let message = format!("Error at index {index} in: \"{c}\"");
    // rust: return Err(CommandError::tr_at(
    // rust: "command.exception",
    // rust: &[&message],
    // rust: reader,
    // rust: ));
}
}
    // rust: let v = i64::from_str_radix(text, 16).unwrap_or(0);
    // rust: let rgb = if text.len() == 3 {
    // rust: let d = |i: u32| ((v >> (8 - 4 * i)) & 15) * 17;
    // rust: (d(0) << 16) | (d(1) << 8) | d(2)
    // rust: } else {
    // rust: v
}
    // rust: Arg::Int(rgb as i32)
}
    // rust: ArgType::Uuid => {
                // UuidArgument: the longest run of [-A-Fa-f0-9] must be a UUID.
    // rust: let rest = reader.remaining();
    // rust: let run: usize = rest
    // rust: .chars()
    // rust: .take_while(|c| c.is_ascii_hexdigit() || *c == '-')
    // rust: .map(char::len_utf8)
    // rust: .sum();
    // rust: match (run > 0)
    // rust: .then(|| super::selector::java_uuid(&rest[..run]))
    // rust: .flatten()
    // rust: {
    // rust: Some(_) => {
    // rust: let text = rest[..run].to_owned();
    // rust: reader.cursor += run;
    // rust: Arg::Str(text)
}
    // rust: None => return Err(CommandError::tr_at("argument.uuid.invalid", &[], reader)),
}
}
    // rust: ArgType::GameProfile => {
    // rust: if reader.can_read() && reader.peek() == '@' {
    // rust: let s = super::selector::parse(reader, reg, reg.permission >= 2)?;
    // rust: if s.include_entities {
    // rust: return Err(CommandError::tr_at("argument.player.entities", &[], reader));
}
    // rust: Arg::Entity(s)
    // rust: } else {
    // rust: while reader.can_read() && reader.peek() != ' ' {
    // rust: reader.skip();
}
    // rust: Arg::Str(reader.string[start..reader.cursor].to_owned())
}
}
    // rust: ArgType::Id(_) => Arg::Resource(read_id(reader)?),
            // DimensionArgument: checked when the command runs.
    // rust: ArgType::Dimension => Arg::Resource(read_id(reader)?),
    // rust: ArgType::Time { min } => {
    // rust: let v = reader.read_float()?;
    // rust: let unit = reader.read_unquoted_string();
    // rust: let Some(m) = time_unit(unit) else {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.time.invalid_unit",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: let ticks = horizon_core::jmath::round_f32(v * m as f32);
    // rust: if ticks < *min {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.time.tick_count_too_low",
    // rust: &[min, &ticks],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Int(ticks)
}
    // rust: ArgType::GameMode => {
    // rust: let name = reader.read_unquoted_string();
    // rust: match GameMode::from_name(name) {
    // rust: Some(m) => Arg::GameMode(m),
    // rust: None => {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.gamemode.invalid",
    // rust: &[&name],
    // rust: reader,
    // rust: ));
}
}
}
    // rust: ArgType::Nbt => {
    // rust: super::snbt::parse_compound_argument(reader)?;
    // rust: Arg::Str(reader.string[start..reader.cursor].to_owned())
}
    // rust: ArgType::Component | ArgType::Style => {
                // ParserBasedArgument.withCodec: SNBT, then the codec (errors at the start).
    // rust: let tag = super::snbt::parse_tag_argument(reader)?;
    // rust: let (decoded, key) = if matches!(self, ArgType::Style) {
    // rust: (
    // rust: super::component::decode_style(&tag),
    // rust: "argument.style.invalid",
    // rust: )
    // rust: } else {
    // rust: (super::component::decode(&tag), "argument.component.invalid")
}
    // rust: if let Err(m) = decoded {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(key, &[&m], reader));
}
    // rust: let text = &reader.string[start..reader.cursor];
    // rust: match horizon_client_core::component::parse_snbt(text) {
    // rust: Ok((v, _)) => Arg::Str(v.to_string()),
    // rust: Err(_) => Arg::Str(text.to_owned()),
}
}
    // rust: ArgType::Swizzle => {
    // rust: let mut axes = String::new();
    // rust: while reader.can_read() && reader.peek() != ' ' {
    // rust: let c = reader.read();
    // rust: if !matches!(c, 'x' | 'y' | 'z') || axes.contains(c) {
    // rust: return Err(CommandError::tr_at(
    // rust: "arguments.swizzle.invalid",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: axes.push(c);
}
    // rust: Arg::Str(axes)
}
    // rust: ArgType::ScoreHolder { multiple } => {
    // rust: if reader.can_read() && reader.peek() == '@' {
    // rust: let sel = super::selector::parse(reader, reg, reg.permission >= 2)?;
    // rust: if !*multiple && sel.limit > 1 {
    // rust: return Err(CommandError::tr_at("argument.entity.toomany", &[], reader));
}
    // rust: Arg::ScoreHolder(ScoreHolderArg::Selector(sel))
    // rust: } else {
    // rust: while reader.can_read() && reader.peek() != ' ' {
    // rust: reader.skip();
}
    // rust: let text = &reader.string[start..reader.cursor];
    // rust: if text == "*" {
    // rust: Arg::ScoreHolder(ScoreHolderArg::Wildcard)
    // rust: } else {
    // rust: Arg::ScoreHolder(ScoreHolderArg::Name(text.to_owned()))
}
}
}
    // rust: ArgType::Objective | ArgType::Team => {
    // rust: Arg::Str(reader.read_unquoted_string().to_owned())
}
    // rust: ArgType::Criteria => {
    // rust: while reader.can_read() && reader.peek() != ' ' {
    // rust: reader.skip();
}
    // rust: let id = &reader.string[start..reader.cursor];
                // ObjectiveCriteria.byName: statistics resolve to their canonical name.
    // rust: match horizon_client_core::scoreboard::criteria_by_name(id, reg) {
    // rust: Ok(Some(canonical)) => Arg::Str(canonical),
    // rust: Ok(None) => {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.criteria.invalid",
    // rust: &[&id],
    // rust: reader,
    // rust: ));
}
    // rust: Err(_) => {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.criteria.invalid",
    // rust: &[&id],
    // rust: reader,
    // rust: ));
}
}
}
    // rust: ArgType::ScoreboardSlot => {
    // rust: let name = reader.read_unquoted_string();
    // rust: if !horizon_client_core::scoreboard::display_slot_valid(name) {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.scoreboardDisplaySlot.invalid",
    // rust: &[&name],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Str(name.to_owned())
}
    // rust: ArgType::Operation => {
    // rust: if !reader.can_read() {
    // rust: return Err(CommandError::tr_at(
    // rust: "arguments.operation.invalid",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: while reader.can_read() && reader.peek() != ' ' {
    // rust: reader.skip();
}
    // rust: let op = &reader.string[start..reader.cursor];
    // rust: if !OPERATIONS.contains(&op) {
    // rust: return Err(CommandError::tr("arguments.operation.invalid", &[]));
}
    // rust: Arg::Str(op.to_owned())
}
    // rust: ArgType::TeamColor => {
    // rust: let name = reader.read_unquoted_string();
    // rust: if horizon_client_core::scoreboard::team_color_rgb(name).is_none() {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.color.invalid",
    // rust: &[&name],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Str(name.to_owned())
}
    // rust: ArgType::IntRange => Arg::IntRange(read_int_bounds(reader)?),
    // rust: ArgType::FloatRange => Arg::DoubleRange(read_double_bounds(reader)?),
    // rust: ArgType::Name(_) => Arg::Str(reader.read_string()?),
    // rust: ArgType::Vec2 | ArgType::ColumnPos => {
    // rust: let block = matches!(self, ArgType::ColumnPos);
    // rust: let one = |reader: &mut Reader| {
    // rust: if block {
    // rust: parse_coord_int(reader)
    // rust: } else {
                        // Vec2Argument.vec2(): integers are centred on the block.
    // rust: parse_coord_double(reader, true)
}
}
    // rust: let x = one(reader)?;
    // rust: if !reader.can_read() || reader.peek() != ' ' {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.pos2d.incomplete",
    // rust: &[],
    // rust: reader,
    // rust: ));
}
    // rust: reader.skip();
    // rust: let z = one(reader)?;
    // rust: Arg::Coords(Coordinates::World([
    // rust: x,
    // rust: Coord {
    // rust: relative: true,
    // rust: value: 0.0,
    // rust: },
    // rust: z,
    // rust: ]))
}
    // rust: ArgType::Particle => {
                // ParticleArgument.readParticle: the type, then SNBT options
                // decoded by the type's codec (errors without context).
    // rust: let id = read_identifier(reader)?;
    // rust: let known = reg.ids("minecraft:particle_type");
    // rust: let exists = if known.is_empty() {
    // rust: horizon_client_core::particle_type::ParticleType::from_name(&id).is_some()
    // rust: } else {
    // rust: known.contains(&id)
}
    // rust: if !exists {
    // rust: return Err(CommandError::tr_at("particle.notFound", &[&id], reader));
}
    // rust: let options = if reader.can_read() && reader.peek() == '{' {
    // rust: super::snbt::parse_tag_argument(reader)?
    // rust: } else {
    // rust: horizon_world::nbt::Tag::Compound(Default::default())
}
    // rust: if let Err(m) = particle_options(&id, &options) {
    // rust: return Err(CommandError::tr("particle.invalidOptions", &[&m]));
}
    // rust: Arg::Str(reader.string[start..reader.cursor].to_owned())
}
    // rust: ArgType::Enum(words) => {
    // rust: let word = reader.read_unquoted_string();
    // rust: if !words.contains(&word) {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at("command.unknown.argument", &[], reader));
}
    // rust: Arg::Str(word.to_owned())
}
    // rust: ArgType::Function => {
    // rust: let tag = reader.can_read() && reader.peek() == '#';
    // rust: if tag {
    // rust: reader.skip();
}
    // rust: let id = read_id(reader)?;
    // rust: Arg::Resource(if tag { format!("#{id}") } else { id })
}
    // rust: ArgType::Slots | ArgType::Slot => {
                // SlotRanges.read (the error is reported after the name).
    // rust: while reader.can_read() && reader.peek() != ' ' {
    // rust: reader.skip();
}
    // rust: let word = &reader.string[start..reader.cursor];
    // rust: let Some((_, size)) = slot_ranges().into_iter().find(|(n, _)| n == word) else {
    // rust: return Err(CommandError::tr_at("slot.unknown", &[&word], reader));
}
    // rust: if matches!(self, ArgType::Slot) && size != 1 {
    // rust: return Err(CommandError::tr_at(
    // rust: "slot.only_single_allowed",
    // rust: &[&word],
    // rust: reader,
    // rust: ));
}
    // rust: Arg::Str(word.to_owned())
}
    // rust: ArgType::SlotSource => {
                // SlotSourceArgument: a slot range name, else a slot source id or inline value.
    // rust: while reader.can_read() && reader.peek() != ' ' {
    // rust: reader.skip();
}
    // rust: let word = &reader.string[start..reader.cursor];
    // rust: if slot_ranges().iter().any(|(n, _)| n == word) {
    // rust: Arg::Str(word.to_owned())
    // rust: } else {
    // rust: reader.cursor = start;
    // rust: super::codec::resource_or_id(reader, reg, "minecraft:slot_source")?;
    // rust: Arg::Str(reader.string[start..reader.cursor].to_owned())
}
}
    // rust: ArgType::ResourceOrId(registry) => {
    // rust: super::codec::resource_or_id(reader, reg, registry)?;
    // rust: Arg::Resource(reader.string[start..reader.cursor].to_owned())
}
    // rust: ArgType::NbtPath => {
    // rust: parse_nbt_path(reader)?;
    // rust: Arg::Str(reader.string[start..reader.cursor].to_owned())
}
    // rust: ArgType::NbtTag => {
    // rust: super::snbt::parse_tag_argument(reader)?;
    // rust: Arg::Str(reader.string[start..reader.cursor].to_owned())
}
    // rust: ArgType::Anchor => {
    // rust: let name = reader.read_unquoted_string();
    // rust: match name {
    // rust: "eyes" => Arg::Anchor(true),
    // rust: "feet" => Arg::Anchor(false),
    // rust: _ => {
    // rust: reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.anchor.invalid",
    // rust: &[&name],
    // rust: reader,
    // rust: ));
}
}
}
    // rust: })
}
    // rust: pub fn suggest(
    // rust: &self,
    // rust: builder: &mut SuggestionsBuilder,
    // rust: reg: &Registries,
    // rust: context: &Context,
    // rust: _name: &str,
    // rust: ) {
    // rust: let _ = context;
    // rust: match self {
    // rust: ArgType::Bool => builder.suggest_matching(["true", "false"]),
    // rust: ArgType::Entity { players, .. } => {
                // EntityArgument.listSuggestions: the online player names,
                // then (unless players only) getSelectedEntities.
    // rust: let mut names = reg.players.clone();
    // rust: if !players {
    // rust: names.extend(reg.selected_entities.iter().cloned());
}
    // rust: super::selector::suggest(builder, reg, &|b| {
    // rust: b.suggest_matching(names.iter().map(String::as_str))
    // rust: });
}
    // rust: ArgType::BlockPos => suggest_coordinates(builder, reg, self, true),
    // rust: ArgType::Vec3 { .. } => suggest_coordinates(builder, reg, self, false),
            // RotationArgument and AngleArgument have no suggestions.
    // rust: ArgType::Rotation | ArgType::Angle => {}
    // rust: ArgType::Item => super::item::suggest_stack(builder, reg),
    // rust: ArgType::ItemPredicate => super::item::suggest_predicate(builder, reg),
    // rust: ArgType::BlockState => super::block::suggest(builder, reg, false),
    // rust: ArgType::BlockPredicate => super::block::suggest(builder, reg, true),
    // rust: ArgType::Resource(kind) => suggest_resources(builder, reg.ids(kind.registry()), ""),
    // rust: ArgType::Res(registry) | ArgType::ResKey(registry) => {
                // RecipeCommand filters its keys to learnable recipes.
    // rust: if *registry == "minecraft:recipe" && !reg.learnable_recipes.is_empty() {
    // rust: suggest_resources(builder, &reg.learnable_recipes, "")
    // rust: } else {
    // rust: suggest_resources(builder, reg.ids(registry), "")
}
}
    // rust: ArgType::ResOrTag(registry) | ArgType::ResOrTagKey(registry) => {
    // rust: suggest_resources(builder, reg.tags(registry), "#");
    // rust: suggest_resources(builder, reg.ids(registry), "");
}
    // rust: ArgType::StrEnum(values, _) => builder.suggest_matching(values.iter().copied()),
    // rust: ArgType::HexColor => builder.suggest_matching(["F00", "FF0000"]),
    // rust: ArgType::ResourceSelector(registry) => {
    // rust: suggest_resources(builder, reg.ids(registry), "")
}
    // rust: ArgType::GameProfile => {
    // rust: let players = reg.players.clone();
    // rust: super::selector::suggest(builder, reg, &|b| {
    // rust: b.suggest_matching(players.iter().map(String::as_str))
    // rust: });
}
    // rust: ArgType::Id(list) => {
    // rust: let values = match *list {
    // rust: "storages" => reg.storages.clone(),
    // rust: "bossbars" => reg.bossbars.clone(),
    // rust: "schedules" => reg.schedules.clone(),
    // rust: "stopwatches" => reg.stopwatches.clone(),
    // rust: "recipes" => reg.recipes.clone(),
    // rust: "sounds" => reg.sounds.clone(),
    // rust: "damage_types" => reg.damage_types.clone(),
    // rust: "attributes" => reg.attributes.clone(),
    // rust: "loot_tables" => reg.loot_tables.clone(),
    // rust: "templates" => reg.templates.clone(),
    // rust: "random_sequences" => reg.random_sequences.clone(),
    // rust: "predicates" => reg.predicates.clone(),
    // rust: "item_modifiers" => reg.item_modifiers.clone(),
    // rust: "time_markers" => reg.time_markers.clone(),
    // rust: "advancements" => reg.advancements.clone(),
    // rust: _ => Vec::new(),
}
    // rust: suggest_resources(builder, &values, "");
}
    // rust: ArgType::Dimension => {
    // rust: let dims = reg.dimensions.clone();
    // rust: suggest_resources(builder, &dims, "");
}
    // rust: ArgType::Time { .. } => {
    // rust: let mut r = Reader::new(builder.remaining());
    // rust: if r.read_float().is_ok() {
    // rust: let mut b = builder.offset(builder.start + r.cursor);
    // rust: b.suggest_matching(["d", "s", "t", ""]);
    // rust: builder.out.extend(b.out);
}
}
    // rust: ArgType::GameMode => builder.suggest_matching(GameMode::ALL.map(GameMode::name)),
    // rust: ArgType::ScoreHolder { .. } => {
                // ScoreHolderArgument.SUGGEST_SCORE_HOLDERS.
    // rust: let players = reg.players.clone();
    // rust: super::selector::suggest(builder, reg, &|b| {
    // rust: b.suggest_matching(players.iter().map(String::as_str))
    // rust: });
}
    // rust: ArgType::Objective => {
    // rust: builder.suggest_matching(reg.objectives.iter().map(String::as_str))
}
    // rust: ArgType::Team => builder.suggest_matching(reg.teams.iter().map(String::as_str)),
    // rust: ArgType::Criteria => {
    // rust: let mut ids: Vec<String> = horizon_client_core::scoreboard::CUSTOM_CRITERIA
    // rust: .iter()
    // rust: .map(|s| (*s).to_owned())
    // rust: .collect();
    // rust: for c in horizon_client_core::scoreboard::team_colors() {
    // rust: ids.push(format!("teamkill.{c}"));
    // rust: ids.push(format!("killedByTeam.{c}"));
}
    // rust: let stat =
    // rust: |ty: &str, key: &str| horizon_client_core::scoreboard::stat_criteria(ty, key);
    // rust: ids.extend(reg.blocks.keys().map(|b| stat("mined", b)));
    // rust: for ty in ["crafted", "used", "broken", "picked_up", "dropped"] {
    // rust: ids.extend(reg.items.iter().map(|i| stat(ty, i)));
}
    // rust: for ty in ["killed", "killed_by"] {
    // rust: ids.extend(reg.entity_types.iter().map(|e| stat(ty, e)));
}
    // rust: ids.extend(
    // rust: horizon_client_core::scoreboard::CUSTOM_STATS
    // rust: .iter()
    // rust: .map(|c| stat("custom", &format!("minecraft:{c}"))),
    // rust: );
    // rust: builder.suggest_matching(ids.iter().map(String::as_str));
}
    // rust: ArgType::ScoreboardSlot => {
    // rust: let slots = horizon_client_core::scoreboard::display_slots();
    // rust: builder.suggest_matching(slots.iter().map(String::as_str));
}
    // rust: ArgType::Operation => builder.suggest_matching(OPERATIONS),
    // rust: ArgType::Enum(words) => builder.suggest_matching(words.iter().copied()),
    // rust: ArgType::Particle => {
    // rust: let known = reg.ids("minecraft:particle_type");
    // rust: if known.is_empty() {
    // rust: let names: Vec<String> = horizon_client_core::particle_type::ParticleType::ALL
    // rust: .iter()
    // rust: .map(|t| format!("minecraft:{}", t.name()))
    // rust: .collect();
    // rust: suggest_resources(builder, &names, "");
    // rust: } else {
    // rust: suggest_resources(builder, known, "");
}
}
    // rust: ArgType::Vec2 => suggest_coordinates(builder, reg, self, false),
    // rust: ArgType::ColumnPos => suggest_coordinates(builder, reg, self, true),
    // rust: ArgType::Name(list) => {
    // rust: let names = match *list {
    // rust: "datapacks_enabled" => reg.datapacks_enabled.clone(),
    // rust: _ => reg.datapacks_disabled.clone(),
}
    // rust: builder.suggest_matching(names.iter().map(String::as_str));
}
            // FunctionArgument has no suggestions of its own (nodes add SUGGEST_FUNCTION).
    // rust: ArgType::Function => {}
    // rust: ArgType::Slots | ArgType::Slot => {
    // rust: let names: Vec<String> = if matches!(self, ArgType::Slots) {
    // rust: slot_ranges().into_iter().map(|(n, _)| n).collect()
    // rust: } else {
    // rust: slot_names()
}
    // rust: builder.suggest_matching(names.iter().map(String::as_str));
}
    // rust: ArgType::SlotSource => {
    // rust: let mut sub = builder.offset(builder.start);
    // rust: let names: Vec<String> = slot_ranges().into_iter().map(|(n, _)| n).collect();
    // rust: sub.suggest_matching(names.iter().map(String::as_str));
    // rust: builder.add(sub);
    // rust: suggest_resources(builder, reg.ids("minecraft:slot_source"), "");
}
    // rust: ArgType::ResourceOrId(registry) => suggest_resources(builder, reg.ids(registry), ""),
    // rust: ArgType::TeamColor => {
    // rust: builder.suggest_matching(horizon_client_core::scoreboard::team_colors())
}
    // rust: ArgType::Anchor => builder.suggest_matching(["eyes", "feet"]),
    // rust: ArgType::Component | ArgType::Style | ArgType::NbtTag => super::snbt::suggest(builder),
    // rust: ArgType::Swizzle | ArgType::Message | ArgType::Nbt => {}
    // rust: _ => {}
}
}
}
