//! Transpiled from Horizon Rust crate
//! Module: horizon-command_selector
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! EntitySelectorParser and EntitySelectorOptions: `@e[...]` selectors,
//! player names and UUIDs, with the suggestion state vanilla keeps while
//! parsing (`fillSuggestions`).
// use super::args::{
    // rust: AdvCondition, GameMode, Registries, Selector, Sort, read_double_bounds, read_float_bounds,
    // rust: read_identifier, read_int_bounds, suggest_resources,
}
// use super::{CmdResult, CommandError, Reader, SuggestionsBuilder};

/// The option names in vanilla's registration order.
    // rust: const OPTIONS: [&str; 21] = [
    // rust: "name",
    // rust: "distance",
    // rust: "level",
    // rust: "x",
    // rust: "y",
    // rust: "z",
    // rust: "dx",
    // rust: "dy",
    // rust: "dz",
    // rust: "x_rotation",
    // rust: "y_rotation",
    // rust: "limit",
    // rust: "sort",
    // rust: "gamemode",
    // rust: "team",
    // rust: "type",
    // rust: "tag",
    // rust: "nbt",
    // rust: "scores",
    // rust: "advancements",
    // rust: "predicate",
    // rust: ];
    // rust: const SELECTOR_KINDS: [(&str, &str); 6] = [
    // rust: ("@p", "argument.entity.selector.nearestPlayer"),
    // rust: ("@a", "argument.entity.selector.allPlayers"),
    // rust: ("@r", "argument.entity.selector.randomPlayer"),
    // rust: ("@s", "argument.entity.selector.self"),
    // rust: ("@e", "argument.entity.selector.allEntities"),
    // rust: ("@n", "argument.entity.selector.nearestEntity"),
    // rust: ];

/// InvertableSetOptionState.
pub const InvertableSet = struct {
    /// 0 none, 1 single, 2 multiple.
    state: u8,
    tags: std.ArrayList([]const u8),
};
    // rust: impl InvertableSet {
pub fn can_parse_positive(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.state == 0
}
pub fn can_parse_negative(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.state != 1
}
pub fn can_parse_any_tag(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.can_parse_negative()
}
pub fn can_parse_tag(self: *Self, tag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.can_parse_any_tag() && !self.tags.iter().any(|t| t == tag)
}
pub fn can_parse_any(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.state != 1
}
pub fn can_parse_element(self: *Self, inverted: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if inverted {
    // rust: self.can_parse_negative()
    // rust: } else {
    // rust: self.can_parse_positive()
}
}
pub fn mark_element(self: *Self, inverted: bool) void {
}
    // rust: self.state = if inverted { 2 } else { 1 };
}
pub fn mark_tag(self: *Self, tag: []const u8) void {
}
    // rust: self.state = 2;
    // rust: self.tags.push(tag);
}
}

/// The suggestion function the parser last set.
pub const Sugg = enum {
    Nothing,
    NameOrSelector,
    Name,
    Selector,
    OpenOptions,
    OptionsKeyOrClose,
    OptionsKey,
    OptionsNextOrClose,
    Sort,
    GameMode,
    Type,
};

/// EntitySelectorParser over a reader.
pub const SelectorParser = struct {
    reader: *'r mut Reader<'a>,
    reg: *'r Registries,
    allow_selectors: bool,
    s: Selector,
    sugg: Sugg,
    start_position: usize,
    current_entity: bool,
    has_distance: bool,
    has_level: bool,
    has_rot_x: bool,
    has_rot_y: bool,
    name_option: InvertableSet,
    limited: bool,
    sorted: bool,
    gamemode_option: InvertableSet,
    team_option: InvertableSet,
    type_option: InvertableSet,
    scores_option: bool,
    advancements_option: bool,
};

/// UUID.fromString.
pub fn java_uuid(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if name.encode_utf16().count() > 36 {
    // rust: return None;
}
    // rust: let parts: Vec<&str> = name.split('-').collect();
    // rust: if parts.len() != 5 {
    // rust: return None;
}
    // rust: let mut v: [i64; 5] = [0; 5];
    // rust: for (i, p) in parts.iter().enumerate() {
        // Long.parseLong(s, 16): an optional sign then hex digits.
    // rust: let digits = p.strip_prefix(['+', '-']).unwrap_or(p);
    // rust: if digits.is_empty() || !digits.chars().all(|c| c.is_ascii_hexdigit()) {
    // rust: return None;
}
    // rust: v[i] = i64::from_str_radix(p, 16).ok()?;
}
    // rust: let msb = (((v[0] as u64) & 0xffff_ffff) << 32)
    // rust: | (((v[1] as u64) & 0xffff) << 16)
    // rust: | ((v[2] as u64) & 0xffff);
    // rust: let lsb = (((v[3] as u64) & 0xffff) << 48) | ((v[4] as u64) & 0xffff_ffff_ffff);
    // rust: Some((u128::from(msb) << 64) | u128::from(lsb))
}

    // rust: fn rollback(
    // rust: reader: &mut Reader,
    // rust: start: usize,
    // rust: key: &str,
    // rust: args: &[&dyn std::fmt::Display],
    // rust: ) -> CommandError {
    // rust: reader.cursor = start;
    // rust: CommandError::tr_at(key, args, reader)
}

    // rust: impl<'r, 'a> SelectorParser<'r, 'a> {
pub fn new(reader: *'r mut Reader<'a>, reg: *'r Registries, allow_selectors: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: reader,
    // rust: reg,
    // rust: allow_selectors,
    // rust: s: Selector::default(),
    // rust: sugg: Sugg::Nothing,
    // rust: start_position: 0,
    // rust: current_entity: false,
    // rust: has_distance: false,
    // rust: has_level: false,
    // rust: has_rot_x: false,
    // rust: has_rot_y: false,
    // rust: name_option: InvertableSet::default(),
    // rust: limited: false,
    // rust: sorted: false,
    // rust: gamemode_option: InvertableSet::default(),
    // rust: team_option: InvertableSet::default(),
    // rust: type_option: InvertableSet::default(),
    // rust: scores_option: false,
    // rust: advancements_option: false,
}
}

    /// EntitySelectorParser.parse.
pub fn parse(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.start_position = self.reader.cursor;
    // rust: self.sugg = Sugg::NameOrSelector;
    // rust: if self.reader.can_read() && self.reader.peek() == '@' {
    // rust: if !self.allow_selectors {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.entity.selector.not_allowed",
    // rust: &[],
    // rust: self.reader,
    // rust: ));
}
    // rust: self.reader.skip();
    // rust: self.parse_selector()?;
    // rust: } else {
    // rust: self.parse_name_or_uuid()?;
}
    // rust: Ok(self.s.clone())
}

pub fn parse_selector(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sugg = Sugg::Selector;
    // rust: if !self.reader.can_read() {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.entity.selector.missing",
    // rust: &[],
    // rust: self.reader,
    // rust: ));
}
    // rust: let start = self.reader.cursor;
    // rust: let kind = self.reader.read();
    // rust: let s = &mut self.s;
    // rust: s.kind = kind;
    // rust: match kind {
    // rust: 'a' => {
    // rust: s.limit = usize::MAX;
    // rust: s.include_entities = false;
    // rust: s.types.push(("minecraft:player".into(), false));
}
    // rust: 'e' => {
    // rust: s.limit = usize::MAX;
    // rust: s.include_entities = true;
}
    // rust: 'n' => {
    // rust: s.limit = 1;
    // rust: s.include_entities = true;
    // rust: s.sort = Sort::Nearest;
}
    // rust: 'p' => {
    // rust: s.limit = 1;
    // rust: s.include_entities = false;
    // rust: s.sort = Sort::Nearest;
    // rust: s.types.push(("minecraft:player".into(), false));
}
    // rust: 'r' => {
    // rust: s.limit = 1;
    // rust: s.include_entities = false;
    // rust: s.sort = Sort::Random;
    // rust: s.types.push(("minecraft:player".into(), false));
}
    // rust: 's' => {
    // rust: s.limit = 1;
    // rust: s.include_entities = true;
    // rust: self.current_entity = true;
}
    // rust: other => {
    // rust: self.reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.entity.selector.unknown",
    // rust: &[&format!("@{other}")],
    // rust: self.reader,
    // rust: ));
}
}
    // rust: self.sugg = Sugg::OpenOptions;
    // rust: if self.reader.can_read() && self.reader.peek() == '[' {
    // rust: self.reader.skip();
    // rust: self.sugg = Sugg::OptionsKeyOrClose;
    // rust: self.parse_options()?;
}
    // rust: Ok(())
}

pub fn parse_name_or_uuid(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.reader.can_read() {
    // rust: self.sugg = Sugg::Name;
}
    // rust: let start = self.reader.cursor;
    // rust: let name = self.reader.read_string()?;
        // A UUID selects by entityUUID alone: findEntities looks a
        // playerName up first, among the players only.
    // rust: if let Some(uuid) = java_uuid(&name) {
    // rust: self.s.uuid = Some(uuid);
    // rust: self.s.include_entities = true;
    // rust: } else {
    // rust: if name.is_empty() || name.encode_utf16().count() > 16 {
    // rust: self.reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.entity.invalid",
    // rust: &[],
    // rust: self.reader,
    // rust: ));
}
    // rust: self.s.include_entities = false;
    // rust: self.s.player_name = Some(name);
}
    // rust: self.s.kind = '\0';
    // rust: self.s.limit = 1;
    // rust: Ok(())
}

pub fn can_use(self: *Self, option: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match option {
    // rust: "name" => self.name_option.can_parse_any(),
    // rust: "distance" => !self.has_distance,
    // rust: "level" => !self.has_level,
    // rust: "x" => self.s.pos[0].is_none(),
    // rust: "y" => self.s.pos[1].is_none(),
    // rust: "z" => self.s.pos[2].is_none(),
    // rust: "dx" => self.s.delta[0].is_none(),
    // rust: "dy" => self.s.delta[1].is_none(),
    // rust: "dz" => self.s.delta[2].is_none(),
    // rust: "x_rotation" => !self.has_rot_x,
    // rust: "y_rotation" => !self.has_rot_y,
    // rust: "limit" => !self.current_entity && !self.limited,
    // rust: "sort" => !self.current_entity && !self.sorted,
    // rust: "gamemode" => self.gamemode_option.can_parse_any(),
    // rust: "team" => self.team_option.can_parse_any(),
    // rust: "type" => self.type_option.can_parse_any(),
    // rust: "scores" => !self.scores_option,
    // rust: "advancements" => !self.advancements_option,
    // rust: _ => true,
}
}

pub fn parse_options(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sugg = Sugg::OptionsKey;
    // rust: self.reader.skip_whitespace();
    // rust: while self.reader.can_read() && self.reader.peek() != ']' {
    // rust: self.reader.skip_whitespace();
    // rust: let start = self.reader.cursor;
    // rust: let key = self.reader.read_string()?;
    // rust: if !OPTIONS.contains(&key.as_str()) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.unknown",
    // rust: &[&key],
    // rust: ));
}
    // rust: if !self.can_use(&key) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.inapplicable",
    // rust: &[&key],
    // rust: ));
}
    // rust: self.reader.skip_whitespace();
    // rust: if !self.reader.can_read() || self.reader.peek() != '=' {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.valueless",
    // rust: &[&key],
    // rust: ));
}
    // rust: self.reader.skip();
    // rust: self.reader.skip_whitespace();
    // rust: self.sugg = Sugg::Nothing;
    // rust: self.handle(&key)?;
    // rust: self.reader.skip_whitespace();
    // rust: self.sugg = Sugg::OptionsNextOrClose;
    // rust: if self.reader.can_read() {
    // rust: if self.reader.peek() != ',' {
    // rust: if self.reader.peek() != ']' {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.entity.options.unterminated",
    // rust: &[],
    // rust: self.reader,
    // rust: ));
}
    // rust: break;
}
    // rust: self.reader.skip();
    // rust: self.sugg = Sugg::OptionsKey;
}
}
    // rust: if self.reader.can_read() {
    // rust: self.reader.skip();
    // rust: self.sugg = Sugg::Nothing;
    // rust: Ok(())
    // rust: } else {
    // rust: Err(CommandError::tr_at(
    // rust: "argument.entity.options.unterminated",
    // rust: &[],
    // rust: self.reader,
    // rust: ))
}
}

pub fn should_invert(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reader.skip_whitespace();
    // rust: if self.reader.can_read() && self.reader.peek() == '!' {
    // rust: self.reader.skip();
    // rust: self.reader.skip_whitespace();
    // rust: true
    // rust: } else {
    // rust: false
}
}
pub fn is_tag(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reader.skip_whitespace();
    // rust: if self.reader.can_read() && self.reader.peek() == '#' {
    // rust: self.reader.skip();
    // rust: self.reader.skip_whitespace();
    // rust: true
    // rust: } else {
    // rust: false
}
}

pub fn handle(self: *Self, key: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match key {
    // rust: "name" => {
    // rust: let start = self.reader.cursor;
    // rust: let inverted = self.should_invert();
    // rust: let name = self.reader.read_string()?;
    // rust: if !self.name_option.can_parse_element(inverted) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.inapplicable",
    // rust: &[&"name"],
    // rust: ));
}
    // rust: self.name_option.mark_element(inverted);
    // rust: self.s.names.push((name, inverted));
}
    // rust: "distance" => {
    // rust: let start = self.reader.cursor;
    // rust: let value = read_double_bounds(self.reader)?;
    // rust: if value.0.is_some_and(|v| v < 0.0) || value.1.is_some_and(|v| v < 0.0) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.distance.negative",
    // rust: &[],
    // rust: ));
}
    // rust: self.s.distance = Some(value);
    // rust: self.has_distance = true;
}
    // rust: "level" => {
    // rust: let start = self.reader.cursor;
    // rust: let value = read_int_bounds(self.reader)?;
    // rust: if value.0.is_some_and(|v| v < 0) || value.1.is_some_and(|v| v < 0) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.level.negative",
    // rust: &[],
    // rust: ));
}
    // rust: self.s.level = Some(value);
    // rust: self.has_level = true;
    // rust: self.s.include_entities = false;
}
    // rust: "x" | "y" | "z" => {
    // rust: let i = usize::from(key.as_bytes()[0] - b'x');
    // rust: self.s.pos[i] = Some(self.reader.read_double()?);
}
    // rust: "dx" | "dy" | "dz" => {
    // rust: let i = usize::from(key.as_bytes()[1] - b'x');
    // rust: self.s.delta[i] = Some(self.reader.read_double()?);
}
    // rust: "x_rotation" | "y_rotation" => {
    // rust: let (lo, hi) = read_float_bounds(self.reader)?;
    // rust: let range = (lo.map(f64::from), hi.map(f64::from));
    // rust: if key == "x_rotation" {
    // rust: self.s.x_rotation = Some(range);
    // rust: self.has_rot_x = true;
    // rust: } else {
    // rust: self.s.y_rotation = Some(range);
    // rust: self.has_rot_y = true;
}
}
    // rust: "limit" => {
    // rust: let start = self.reader.cursor;
    // rust: let count = self.reader.read_int()?;
    // rust: if count < 1 {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.limit.toosmall",
    // rust: &[],
    // rust: ));
}
    // rust: self.s.limit = count as usize;
    // rust: self.limited = true;
}
    // rust: "sort" => {
    // rust: let start = self.reader.cursor;
    // rust: let name = self.reader.read_unquoted_string();
    // rust: self.sugg = Sugg::Sort;
    // rust: self.s.sort = match name {
    // rust: "nearest" => Sort::Nearest,
    // rust: "furthest" => Sort::Furthest,
    // rust: "random" => Sort::Random,
    // rust: "arbitrary" => Sort::Arbitrary,
    // rust: _ => {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.sort.irreversible",
    // rust: &[&name],
    // rust: ));
}
}
    // rust: self.sorted = true;
}
    // rust: "gamemode" => {
    // rust: self.sugg = Sugg::GameMode;
    // rust: let start = self.reader.cursor;
    // rust: let inverted = self.should_invert();
    // rust: if !self.gamemode_option.can_parse_element(inverted) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.inapplicable",
    // rust: &[&"gamemode"],
    // rust: ));
}
    // rust: let name = self.reader.read_unquoted_string();
    // rust: if GameMode::from_name(name).is_none() {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.mode.invalid",
    // rust: &[&name],
    // rust: ));
}
    // rust: self.s.include_entities = false;
    // rust: self.s.gamemodes.push((name.to_owned(), inverted));
    // rust: self.gamemode_option.mark_element(inverted);
}
    // rust: "team" => {
    // rust: let start = self.reader.cursor;
    // rust: let inverted = self.should_invert();
    // rust: let name = self.reader.read_unquoted_string().to_owned();
    // rust: if !self.team_option.can_parse_element(inverted) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.inapplicable",
    // rust: &[&"team"],
    // rust: ));
}
    // rust: self.s.teams.push((name, inverted));
    // rust: self.team_option.mark_element(inverted);
}
    // rust: "type" => {
    // rust: self.sugg = Sugg::Type;
    // rust: let start = self.reader.cursor;
    // rust: let inverted = self.should_invert();
    // rust: if self.is_tag() {
    // rust: if !self.type_option.can_parse_any_tag() {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.inapplicable",
    // rust: &[&"type"],
    // rust: ));
}
    // rust: let id = read_identifier(self.reader)?;
    // rust: if !self.type_option.can_parse_tag(&id) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.inapplicable",
    // rust: &[&"type"],
    // rust: ));
}
    // rust: self.s.types.push((format!("#{id}"), inverted));
    // rust: self.type_option.mark_tag(id);
    // rust: } else {
    // rust: if !self.type_option.can_parse_element(inverted) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.inapplicable",
    // rust: &[&"type"],
    // rust: ));
}
    // rust: let id = read_identifier(self.reader)?;
    // rust: let types = self.reg.ids("minecraft:entity_type");
    // rust: if !types.is_empty() && !types.contains(&id) {
    // rust: return Err(rollback(
    // rust: self.reader,
    // rust: start,
    // rust: "argument.entity.options.type.invalid",
    // rust: &[&id],
    // rust: ));
}
    // rust: if id == "minecraft:player" && !inverted {
    // rust: self.s.include_entities = false;
}
    // rust: if !inverted {
                        // limitToType replaces the player type of @a/@p/@r.
    // rust: self.s.types.retain(|(t, n)| *n || t.starts_with('#'));
}
    // rust: self.s.types.push((id, inverted));
    // rust: self.type_option.mark_element(inverted);
}
}
    // rust: "tag" => {
    // rust: let inverted = self.should_invert();
    // rust: let tag = self.reader.read_unquoted_string().to_owned();
    // rust: self.s.tags.push((tag, inverted));
}
    // rust: "nbt" => {
    // rust: let inverted = self.should_invert();
    // rust: let start = self.reader.cursor;
    // rust: super::snbt::parse_compound_argument(self.reader)?;
    // rust: let text = self.reader.string[start..self.reader.cursor].to_owned();
    // rust: self.s.nbt.push((text, inverted));
}
    // rust: "scores" => {
    // rust: let r = &mut *self.reader;
    // rust: r.expect('{')?;
    // rust: r.skip_whitespace();
    // rust: let mut expected = Vec::new();
    // rust: while r.can_read() && r.peek() != '}' {
    // rust: r.skip_whitespace();
    // rust: let name = r.read_unquoted_string().to_owned();
    // rust: r.skip_whitespace();
    // rust: r.expect('=')?;
    // rust: r.skip_whitespace();
    // rust: let value = read_int_bounds(r)?;
    // rust: expected.push((name, value));
    // rust: r.skip_whitespace();
    // rust: if r.can_read() && r.peek() == ',' {
    // rust: r.skip();
}
}
    // rust: r.expect('}')?;
    // rust: self.s.scores.extend(expected);
    // rust: self.scores_option = true;
}
    // rust: "advancements" => {
    // rust: let r = &mut *self.reader;
    // rust: r.expect('{')?;
    // rust: r.skip_whitespace();
    // rust: let mut expected = Vec::new();
    // rust: while r.can_read() && r.peek() != '}' {
    // rust: r.skip_whitespace();
    // rust: let name = read_identifier(r)?;
    // rust: r.skip_whitespace();
    // rust: r.expect('=')?;
    // rust: r.skip_whitespace();
    // rust: if r.can_read() && r.peek() == '{' {
    // rust: let mut progress = Vec::new();
    // rust: r.skip_whitespace();
    // rust: r.expect('{')?;
    // rust: r.skip_whitespace();
    // rust: while r.can_read() && r.peek() != '}' {
    // rust: r.skip_whitespace();
    // rust: let criterion = r.read_unquoted_string().to_owned();
    // rust: r.skip_whitespace();
    // rust: r.expect('=')?;
    // rust: r.skip_whitespace();
    // rust: let value = r.read_boolean()?;
    // rust: progress.push((criterion, value));
    // rust: r.skip_whitespace();
    // rust: if r.can_read() && r.peek() == ',' {
    // rust: r.skip();
}
}
    // rust: r.skip_whitespace();
    // rust: r.expect('}')?;
    // rust: r.skip_whitespace();
    // rust: expected.push((name, AdvCondition::Criteria(progress)));
    // rust: } else {
    // rust: let value = r.read_boolean()?;
    // rust: expected.push((name, AdvCondition::Done(value)));
}
    // rust: r.skip_whitespace();
    // rust: if r.can_read() && r.peek() == ',' {
    // rust: r.skip();
}
}
    // rust: r.expect('}')?;
    // rust: if !expected.is_empty() {
    // rust: self.s.include_entities = false;
}
    // rust: self.s.advancements.extend(expected);
    // rust: self.advancements_option = true;
}
    // rust: "predicate" => {
    // rust: let inverted = self.should_invert();
    // rust: let id = read_identifier(self.reader)?;
    // rust: self.s.predicates.push((id, inverted));
}
    // rust: _ => {}
}
    // rust: Ok(())
}

pub fn fill_selectors(builder: *mut SuggestionsBuilder) void {
}
    // rust: for (s, tip) in SELECTOR_KINDS {
    // rust: builder.suggest_tooltip(s, horizon_client_core::lang::get(tip));
}
}

    /// EntitySelectorParser.fillSuggestions: `names` adds the name
    /// candidates (online players for most arguments).
    // rust: pub fn fill_suggestions(
    // rust: &self,
    // rust: builder: &mut SuggestionsBuilder,
    // rust: names: &dyn Fn(&mut SuggestionsBuilder),
    // rust: ) {
    // rust: let mut b = builder.offset(self.reader.cursor);
    // rust: match self.sugg {
    // rust: Sugg::Nothing => {}
    // rust: Sugg::NameOrSelector => {
    // rust: names(&mut b);
    // rust: if self.allow_selectors {
    // rust: Self::fill_selectors(&mut b);
}
}
    // rust: Sugg::Name => {
    // rust: let mut sub = b.offset(self.start_position);
    // rust: names(&mut sub);
    // rust: b.add(sub);
}
    // rust: Sugg::Selector => {
    // rust: let mut sub = b.offset(b.start - 1);
    // rust: Self::fill_selectors(&mut sub);
    // rust: b.add(sub);
}
    // rust: Sugg::OpenOptions => b.suggest("["),
    // rust: Sugg::OptionsKeyOrClose => {
    // rust: b.suggest("]");
    // rust: self.suggest_names(&mut b);
}
    // rust: Sugg::OptionsKey => self.suggest_names(&mut b),
    // rust: Sugg::OptionsNextOrClose => {
    // rust: b.suggest(",");
    // rust: b.suggest("]");
}
    // rust: Sugg::Sort => b.suggest_matching(["nearest", "furthest", "random", "arbitrary"]),
    // rust: Sugg::GameMode => {
    // rust: let state = &self.gamemode_option;
    // rust: let mut prefix = b.remaining_lower();
    // rust: let mut add_normal = state.can_parse_positive();
    // rust: let mut add_inverted = state.can_parse_negative();
    // rust: if !prefix.is_empty() {
    // rust: if prefix.starts_with('!') {
    // rust: add_normal = false;
    // rust: prefix.remove(0);
    // rust: } else {
    // rust: add_inverted = false;
}
}
    // rust: for mode in GameMode::ALL {
    // rust: if mode.name().starts_with(&prefix) {
    // rust: if add_inverted {
    // rust: b.suggest(format!("!{}", mode.name()));
}
    // rust: if add_normal {
    // rust: b.suggest(mode.name());
}
}
}
}
    // rust: Sugg::Type => {
    // rust: let state = &self.type_option;
    // rust: let types = self.reg.ids("minecraft:entity_type");
    // rust: if state.can_parse_negative() {
    // rust: suggest_resources(&mut b, types, "!");
}
    // rust: if state.can_parse_positive() {
    // rust: suggest_resources(&mut b, types, "");
}
    // rust: if state.can_parse_any_tag() {
    // rust: let tags: Vec<String> = self
    // rust: .reg
    // rust: .tags("minecraft:entity_type")
    // rust: .iter()
    // rust: .filter(|t| state.can_parse_tag(t))
    // rust: .cloned()
    // rust: .collect();
    // rust: if !tags.is_empty() {
    // rust: suggest_resources(&mut b, &tags, "#");
    // rust: suggest_resources(&mut b, &tags, "!#");
}
}
}
}
    // rust: builder.add(b);
}

pub fn suggest_names(self: *Self, b: *mut SuggestionsBuilder) void {
}
    // rust: let lower = b.remaining_lower();
    // rust: for o in OPTIONS {
    // rust: if self.can_use(o) && o.starts_with(&lower) {
    // rust: b.suggest_tooltip(
    // rust: format!("{o}="),
    // rust: horizon_client_core::lang::get(&format!(
    // rust: "argument.entity.options.{o}.description"
    // rust: )),
    // rust: );
}
}
}
}

/// Parse a selector from `reader` (EntitySelectorParser.parse).
pub fn parse(reader: *mut Reader, reg: *Registries, allow_selectors: bool) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SelectorParser::new(reader, reg, allow_selectors).parse()
}

/// Re-parse the text from `builder.start` and fill the selector suggestions.
    // rust: pub fn suggest(
    // rust: builder: &mut SuggestionsBuilder,
    // rust: reg: &Registries,
    // rust: names: &dyn Fn(&mut SuggestionsBuilder),
    // rust: ) {
    // rust: let mut reader = Reader {
    // rust: string: builder.input,
    // rust: cursor: builder.start,
}
    // rust: let mut parser = SelectorParser::new(&mut reader, reg, reg.permission >= 2);
    // rust: let _ = parser.parse();
    // rust: parser.fill_suggestions(builder, names);
}
