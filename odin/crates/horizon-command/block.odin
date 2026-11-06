//! Transpiled from Horizon Rust crate
package horizon_command_block

import "core:fmt"
import "core:mem"
import "core:math"

// BlockStateParser: block states (`stone`, `oak_stairs[facing=up]{...}`)
// and block predicates (`#logs[axis=y]`), with vanilla's suggestions.
// use super::args::{BlockInput, Registries, read_identifier, suggest_resources};
// use super::{CmdResult, CommandError, Reader, SuggestionsBuilder};

Sugg :: enum {
    Nothing,
    Item,
    BlockIdOrTag,
    Tag,
    OpenVaguePropertiesOrNbt,
    OpenNbt,
    OpenPropertiesOrNbt,
    PropertyNameOrEnd,
    VaguePropertyNameOrEnd,
    PropertyName,
    VaguePropertyName,
    Equals,
    PropertyValues(String),
    NextPropertyOrEnd,
    VaguePropertyValue(String),
}

    // rust: type Props = Vec<(String, Vec<String>)>;

BlockParser :: struct {
    reader: ^'r mut Reader<'a>,
    reg: ^'r Registries,
    for_testing: bool,
    allow_nbt: bool,
    id: string,
    // The block's state definition (properties and values).
    definition: Maybe(^'r Props),
    properties: Vec<(string,
    vague: Vec<(string,
    tag: Maybe(string),
    nbt: Maybe(string),
    sugg: Sugg,
}

is_int_property :: proc(values: ^[string]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !values.is_empty() && values.iter().all(|v| v.parse::<i32>().is_ok())
}
// Property.getValue.
property_value :: proc(values: ^[string], raw: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if is_int_property(values) {
    // rust: let v: i32 = super::args::java_parse_int(raw)?;
    // rust: let s = v.to_string();
    // rust: return values.contains(&s).then_some(s);
}
    // rust: values.iter().any(|v| v == raw).then(|| raw.to_owned())
}
// addSuggestions: every value (integers as integer suggestions).
add_values :: proc(builder: ^SuggestionsBuilder, values: ^[string]) {
}
    // rust: let ints = is_int_property(values);
    // rust: for v in values {
    // rust: if ints {
    // rust: builder.suggest_int(v.parse().unwrap_or(0));
    // rust: } else {
    // rust: builder.suggest(v.clone());
}
}
}

    // rust: impl<'r, 'a> BlockParser<'r, 'a> {
    // rust: pub fn new(
    // rust: reader: &'r mut Reader<'a>,
    // rust: reg: &'r Registries,
    // rust: for_testing: bool,
    // rust: allow_nbt: bool,
    // rust: ) -> Self {
    // rust: Self {
    // rust: reader,
    // rust: reg,
    // rust: for_testing,
    // rust: allow_nbt,
    // rust: id: "minecraft:".into(),
    // rust: definition: None,
    // rust: properties: Vec::new(),
    // rust: vague: Vec::new(),
    // rust: tag: None,
    // rust: nbt: None,
    // rust: sugg: Sugg::Nothing,
}
}

tag_members :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match &self.tag {
    // rust: Some(t) => self
    // rust: .reg
    // rust: .block_tag_members
    // rust: .get(t)
    // rust: .map(Vec::as_slice)
    // rust: .unwrap_or(&[]),
    // rust: None => &[],
}
}
block_props :: proc(self: ^Self, id: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.reg.blocks.get(id).map(Vec::as_slice).unwrap_or(&[])
}

parse :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.sugg = if self.for_testing {
    // rust: Sugg::BlockIdOrTag
    // rust: } else {
    // rust: Sugg::Item
}
    // rust: if self.reader.can_read() && self.reader.peek() == '#' {
    // rust: self.read_tag()?;
    // rust: self.sugg = Sugg::OpenVaguePropertiesOrNbt;
    // rust: if self.reader.can_read() && self.reader.peek() == '[' {
    // rust: self.read_vague_properties()?;
    // rust: self.sugg = Sugg::OpenNbt;
}
    // rust: } else {
    // rust: self.read_block()?;
    // rust: self.sugg = Sugg::OpenPropertiesOrNbt;
    // rust: if self.reader.can_read() && self.reader.peek() == '[' {
    // rust: self.read_properties()?;
    // rust: self.sugg = Sugg::OpenNbt;
}
}
    // rust: if self.allow_nbt && self.reader.can_read() && self.reader.peek() == '{' {
    // rust: self.sugg = Sugg::Nothing;
    // rust: let start = self.reader.cursor;
    // rust: super::snbt::parse_compound_argument(self.reader)?;
    // rust: self.nbt = Some(self.reader.string[start..self.reader.cursor].to_owned());
}
    // rust: let (id, properties) = match &self.tag {
    // rust: Some(t) => (t.clone(), self.vague.clone()),
    // rust: None => (self.id.clone(), self.properties.clone()),
}
    // rust: Ok(BlockInput {
    // rust: id,
    // rust: properties,
    // rust: tag: self.tag.is_some(),
    // rust: nbt: self.nbt.clone(),
    // rust: })
}

read_block :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.reader.cursor;
    // rust: self.id = read_identifier(self.reader)?;
    // rust: match self.reg.blocks.get(&self.id) {
    // rust: Some(props) => {
    // rust: self.definition = Some(props);
    // rust: Ok(())
}
    // rust: None => {
    // rust: self.reader.cursor = start;
    // rust: Err(CommandError::tr_at(
    // rust: "argument.block.id.invalid",
    // rust: &[&self.id],
    // rust: self.reader,
    // rust: ))
}
}
}
read_tag :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: if !self.for_testing {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.block.tag.disallowed",
    // rust: &[],
    // rust: self.reader,
    // rust: ));
}
    // rust: let start = self.reader.cursor;
    // rust: self.reader.expect('#')?;
    // rust: self.sugg = Sugg::Tag;
    // rust: let id = read_identifier(self.reader)?;
    // rust: if !self.reg.tags("minecraft:block").contains(&id) {
    // rust: self.reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "arguments.block.tag.unknown",
    // rust: &[&id],
    // rust: self.reader,
    // rust: ));
}
    // rust: self.tag = Some(id);
    // rust: Ok(())
}
read_properties :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.reader.skip();
    // rust: self.sugg = Sugg::PropertyNameOrEnd;
    // rust: self.reader.skip_whitespace();
    // rust: let definition = self.definition.map(Vec::as_slice).unwrap_or(&[]);
    // rust: while self.reader.can_read() && self.reader.peek() != ']' {
    // rust: self.reader.skip_whitespace();
    // rust: let key_start = self.reader.cursor;
    // rust: let key = self.reader.read_string()?;
    // rust: let Some((_, values)) = definition.iter().find(|(n, _)| *n == key) else {
    // rust: self.reader.cursor = key_start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.block.property.unknown",
    // rust: &[&self.id, &key],
    // rust: self.reader,
    // rust: ));
}
    // rust: if self.properties.iter().any(|(n, _)| *n == key) {
    // rust: self.reader.cursor = key_start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.block.property.duplicate",
    // rust: &[&key, &self.id],
    // rust: self.reader,
    // rust: ));
}
    // rust: self.reader.skip_whitespace();
    // rust: self.sugg = Sugg::Equals;
    // rust: if !self.reader.can_read() || self.reader.peek() != '=' {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.block.property.novalue",
    // rust: &[&key, &self.id],
    // rust: self.reader,
    // rust: ));
}
    // rust: self.reader.skip();
    // rust: self.reader.skip_whitespace();
    // rust: self.sugg = Sugg::PropertyValues(key.clone());
    // rust: let start = self.reader.cursor;
    // rust: let raw = self.reader.read_string()?;
    // rust: match property_value(values, &raw) {
    // rust: Some(v) => self.properties.push((key, v)),
    // rust: None => {
    // rust: self.reader.cursor = start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.block.property.invalid",
    // rust: &[&self.id, &raw, &key],
    // rust: self.reader,
    // rust: ));
}
}
    // rust: self.sugg = Sugg::NextPropertyOrEnd;
    // rust: self.reader.skip_whitespace();
    // rust: if self.reader.can_read() {
    // rust: if self.reader.peek() != ',' {
    // rust: if self.reader.peek() != ']' {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.block.property.unclosed",
    // rust: &[],
    // rust: self.reader,
    // rust: ));
}
    // rust: break;
}
    // rust: self.reader.skip();
    // rust: self.sugg = Sugg::PropertyName;
}
}
    // rust: if self.reader.can_read() {
    // rust: self.reader.skip();
    // rust: Ok(())
    // rust: } else {
    // rust: Err(CommandError::tr_at(
    // rust: "argument.block.property.unclosed",
    // rust: &[],
    // rust: self.reader,
    // rust: ))
}
}
read_vague_properties :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.reader.skip();
    // rust: self.sugg = Sugg::VaguePropertyNameOrEnd;
    // rust: let mut value_start: Option<usize> = None;
    // rust: self.reader.skip_whitespace();
    // rust: while self.reader.can_read() && self.reader.peek() != ']' {
    // rust: self.reader.skip_whitespace();
    // rust: let key_start = self.reader.cursor;
    // rust: let key = self.reader.read_string()?;
    // rust: if self.vague.iter().any(|(n, _)| *n == key) {
    // rust: self.reader.cursor = key_start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.block.property.duplicate",
    // rust: &[&key, &self.id],
    // rust: self.reader,
    // rust: ));
}
    // rust: self.reader.skip_whitespace();
    // rust: if !self.reader.can_read() || self.reader.peek() != '=' {
    // rust: self.reader.cursor = key_start;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.block.property.novalue",
    // rust: &[&key, &self.id],
    // rust: self.reader,
    // rust: ));
}
    // rust: self.reader.skip();
    // rust: self.reader.skip_whitespace();
    // rust: self.sugg = Sugg::VaguePropertyValue(key.clone());
    // rust: value_start = Some(self.reader.cursor);
    // rust: let value = self.reader.read_string()?;
    // rust: self.vague.push((key, value));
    // rust: self.reader.skip_whitespace();
    // rust: if self.reader.can_read() {
    // rust: value_start = None;
    // rust: if self.reader.peek() != ',' {
    // rust: if self.reader.peek() != ']' {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.block.property.unclosed",
    // rust: &[],
    // rust: self.reader,
    // rust: ));
}
    // rust: break;
}
    // rust: self.reader.skip();
    // rust: self.sugg = Sugg::VaguePropertyName;
}
}
    // rust: if self.reader.can_read() {
    // rust: self.reader.skip();
    // rust: Ok(())
    // rust: } else {
    // rust: if let Some(v) = value_start {
    // rust: self.reader.cursor = v;
}
    // rust: Err(CommandError::tr_at(
    // rust: "argument.block.property.unclosed",
    // rust: &[],
    // rust: self.reader,
    // rust: ))
}
}

has_block_entity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.tag.is_none() {
    // rust: return self.reg.block_entities.contains(&self.id);
}
    // rust: self.tag_members()
    // rust: .iter()
    // rust: .any(|b| self.reg.block_entities.contains(b))
}

fill_suggestions :: proc(self: ^Self, builder: ^SuggestionsBuilder) {
}
    // rust: let mut b = builder.offset(self.reader.cursor);
    // rust: let empty = b.remaining().is_empty();
    // rust: let definition = self.definition.map(Vec::as_slice).unwrap_or(&[]);
    // rust: match &self.sugg {
    // rust: Sugg::Nothing => {}
    // rust: Sugg::Item => {
    // rust: let ids: Vec<&String> = self.reg.blocks.keys().collect();
    // rust: suggest_resources(&mut b, ids, "");
}
    // rust: Sugg::Tag => suggest_resources(&mut b, self.reg.tags("minecraft:block"), "#"),
    // rust: Sugg::BlockIdOrTag => {
    // rust: suggest_resources(&mut b, self.reg.tags("minecraft:block"), "#");
    // rust: let ids: Vec<&String> = self.reg.blocks.keys().collect();
    // rust: suggest_resources(&mut b, ids, "");
}
    // rust: Sugg::OpenVaguePropertiesOrNbt => {
    // rust: if empty && self.tag.is_some() {
    // rust: let members = self.tag_members();
    // rust: if members.iter().any(|m| !self.block_props(m).is_empty()) {
    // rust: b.suggest("[");
}
    // rust: if members.iter().any(|m| self.reg.block_entities.contains(m)) {
    // rust: b.suggest("{");
}
}
}
    // rust: Sugg::OpenNbt => {
    // rust: if empty && self.has_block_entity() {
    // rust: b.suggest("{");
}
}
    // rust: Sugg::OpenPropertiesOrNbt => {
    // rust: if empty {
    // rust: if !definition.is_empty() {
    // rust: b.suggest("[");
}
    // rust: if self.reg.block_entities.contains(&self.id) {
    // rust: b.suggest("{");
}
}
}
    // rust: Sugg::PropertyNameOrEnd | Sugg::PropertyName => {
    // rust: if matches!(self.sugg, Sugg::PropertyNameOrEnd) && empty {
    // rust: b.suggest("]");
}
    // rust: let prefix = b.remaining_lower();
    // rust: for (name, _) in definition {
    // rust: if !self.properties.iter().any(|(n, _)| n == name) && name.starts_with(&prefix)
    // rust: {
    // rust: b.suggest(format!("{name}="));
}
}
}
    // rust: Sugg::VaguePropertyNameOrEnd | Sugg::VaguePropertyName => {
    // rust: if matches!(self.sugg, Sugg::VaguePropertyNameOrEnd) && empty {
    // rust: b.suggest("]");
}
    // rust: let prefix = b.remaining_lower();
    // rust: for m in self.tag_members() {
    // rust: for (name, _) in self.block_props(m) {
    // rust: if !self.vague.iter().any(|(n, _)| n == name) && name.starts_with(&prefix) {
    // rust: b.suggest(format!("{name}="));
}
}
}
}
    // rust: Sugg::Equals => {
    // rust: if empty {
    // rust: b.suggest("=");
}
}
    // rust: Sugg::PropertyValues(key) => {
    // rust: if let Some((_, values)) = definition.iter().find(|(n, _)| n == key) {
    // rust: add_values(&mut b, values);
}
}
    // rust: Sugg::NextPropertyOrEnd => {
    // rust: if empty {
    // rust: b.suggest("]");
}
    // rust: if empty && self.properties.len() < definition.len() {
    // rust: b.suggest(",");
}
}
    // rust: Sugg::VaguePropertyValue(key) => {
    // rust: let mut more = false;
    // rust: for m in self.tag_members() {
    // rust: let props = self.block_props(m);
    // rust: if let Some((_, values)) = props.iter().find(|(n, _)| n == key) {
    // rust: add_values(&mut b, values);
}
    // rust: if !more {
    // rust: more = props
    // rust: .iter()
    // rust: .any(|(n, _)| !self.vague.iter().any(|(v, _)| v == n));
}
}
    // rust: if more {
    // rust: b.suggest(",");
}
    // rust: b.suggest("]");
}
}
    // rust: builder.add(b);
}
}

// BlockStateParser.parseForBlock / parseForTesting (the reader is rewound on errors).
parse :: proc(reader: ^Reader, reg: ^Registries, for_testing: bool) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let cursor = reader.cursor;
    // rust: let r = BlockParser::new(reader, reg, for_testing, true).parse();
    // rust: if r.is_err() {
    // rust: reader.cursor = cursor;
}
    // rust: r
}
// BlockStateParser.fillSuggestions.
suggest :: proc(builder: ^SuggestionsBuilder, reg: ^Registries, for_testing: bool) {
}
    // rust: let mut reader = Reader {
    // rust: string: builder.input,
    // rust: cursor: builder.start,
}
    // rust: let mut parser = BlockParser::new(&mut reader, reg, for_testing, true);
    // rust: let _ = parser.parse();
    // rust: parser.fill_suggestions(builder);
}
