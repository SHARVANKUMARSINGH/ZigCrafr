//! Transpiled from Horizon Rust crate
//! Module: horizon-command_item
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! ItemParser (item stacks with components, `stone[damage=5]`) and
//! ItemPredicateArgument (ComponentPredicateParser's packrat grammar:
//! `#logs[count~1..|!damage]`), with vanilla's errors and suggestions.
// use super::args::{
    // rust: ItemInput, Registries, is_id_char, parse_identifier, read_identifier, suggest_resources,
}
// use super::codec::{either, is_number, not_map, snbt};
// use super::packrat::{Grammar, Reason, State, Sugg, Term, Value, alt, ch, opt, seq};
// use super::{CmdResult, CommandError, Reader, SuggestionsBuilder};
// use horizon_world::nbt::Tag;
// use std::rc::Rc;

pub fn int_of(t: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match t {
    // rust: Tag::Byte(v) => i64::from(*v),
    // rust: Tag::Short(v) => i64::from(*v),
    // rust: Tag::Int(v) => i64::from(*v),
    // rust: Tag::Long(v) => *v as i32 as i64,
    // rust: Tag::Float(v) => f32::from_bits(*v) as i32 as i64,
    // rust: Tag::Double(v) => f64::from_bits(*v) as i32 as i64,
    // rust: _ => return None,
    // rust: })
}
/// The codecs of the item components commands commonly set.
pub fn decode_component(id: []const u8, t: *Tag) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "minecraft:damage" | "minecraft:repair_cost" => {
    // rust: let v = int_of(t).ok_or("Not a number")?;
    // rust: if v < 0 {
    // rust: return Err(format!("Value must be non-negative: {v}"));
}
    // rust: Ok(())
}
    // rust: "minecraft:max_damage" => {
    // rust: let v = int_of(t).ok_or("Not a number")?;
    // rust: if v <= 0 {
    // rust: return Err(format!("Value must be positive: {v}"));
}
    // rust: Ok(())
}
    // rust: "minecraft:max_stack_size" => {
    // rust: let v = int_of(t).ok_or("Not a number")?;
    // rust: if !(1..=99).contains(&v) {
    // rust: return Err(format!("Value must be within range [1;99]: {v}"));
}
    // rust: Ok(())
}
    // rust: "minecraft:rarity" => match t {
    // rust: Tag::String(s) => {
    // rust: let s = s.to_string_lossy();
    // rust: if ["common", "uncommon", "rare", "epic"].contains(&s.as_str()) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("Unknown element name:{s}"))
}
}
    // rust: _ => Err("Not a string".into()),
    // rust: },
    // rust: "minecraft:enchantments" | "minecraft:stored_enchantments" => match t {
    // rust: Tag::Compound(_) => Ok(()),
    // rust: _ => Err(not_map(t)),
    // rust: },
    // rust: "minecraft:custom_name" | "minecraft:item_name" => super::component::decode(t),
        // TypedEntityData.codec: the type is the compound's id.
    // rust: "minecraft:block_entity_data" => match t {
    // rust: Tag::Compound(c) => match c.get(&"id".into()) {
    // rust: None => Err(format!("Expected 'id' field in {}", snbt(t))),
    // rust: Some(Tag::String(id)) => {
    // rust: let id = id.to_string_lossy();
    // rust: let id = if id.contains(':') {
    // rust: id
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: let known = horizon_client_core::block_entity_nbt::TYPES
    // rust: .iter()
    // rust: .chain(&horizon_client_core::block_entity_nbt::NEWEST)
    // rust: .any(|k| *k == id);
    // rust: if known {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!(
    // rust: "Unknown registry key in ResourceKey[minecraft:root / minecraft:block_entity_type]: {id}"
    // rust: ))
}
}
    // rust: Some(_) => Ok(()),
    // rust: },
    // rust: _ => Ok(()),
    // rust: },
    // rust: _ => Ok(()),
}
}
/// MinMaxBounds.Ints.CODEC.
pub fn int_bounds(t: *Tag) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match t {
    // rust: Tag::Compound(_) => Ok(()),
    // rust: _ if is_number(t) => Ok(()),
    // rust: _ => Err(either(not_map(t), "Not a number".into())),
}
}
/// DataComponentPredicate type codecs.
pub fn decode_predicate(id: []const u8, t: *Tag) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "minecraft:count" => int_bounds(t),
    // rust: "minecraft:damage" => match t {
    // rust: Tag::Compound(_) => Ok(()),
    // rust: _ => Err(not_map(t)),
    // rust: },
    // rust: _ => Ok(()),
}
}

// ---- ItemParser -------------------------------------------------------

pub const ISugg = enum {
    Nothing,
    Item,
    StartComponents,
    ComponentAssignmentOrRemoval,
    Component,
    Assignment,
    NextOrEndComponents,
};

pub const ItemState = struct {
    reader: *'r mut Reader<'a>,
    reg: *'r Registries,
    sugg: ISugg,
};
    // rust: impl ItemState<'_, '_> {
pub fn parse(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sugg = ISugg::Item;
    // rust: let cursor = self.reader.cursor;
    // rust: let id = read_identifier(self.reader)?;
    // rust: if !self.reg.ids("minecraft:item").contains(&id) {
    // rust: self.reader.cursor = cursor;
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.item.id.invalid",
    // rust: &[&id],
    // rust: self.reader,
    // rust: ));
}
    // rust: self.sugg = ISugg::StartComponents;
    // rust: let mut components = None;
    // rust: if self.reader.can_read() && self.reader.peek() == '[' {
    // rust: self.sugg = ISugg::Nothing;
    // rust: let start = self.reader.cursor;
    // rust: self.read_components()?;
    // rust: components = Some(self.reader.string[start..self.reader.cursor].to_owned());
}
    // rust: Ok(ItemInput {
    // rust: id,
    // rust: tag: false,
    // rust: any: false,
    // rust: components,
    // rust: })
}
pub fn component_type(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.reader.can_read() {
    // rust: return Err(CommandError::tr_at(
    // rust: "arguments.item.component.expected",
    // rust: &[],
    // rust: self.reader,
    // rust: ));
}
    // rust: let cursor = self.reader.cursor;
    // rust: let id = read_identifier(self.reader)?;
    // rust: if self.reg.persistent_components.contains(&id) {
    // rust: return Ok(id);
}
    // rust: self.reader.cursor = cursor;
    // rust: Err(CommandError::tr_at(
    // rust: "arguments.item.component.unknown",
    // rust: &[&id],
    // rust: self.reader,
    // rust: ))
}
pub fn read_components(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reader.expect('[')?;
    // rust: self.sugg = ISugg::ComponentAssignmentOrRemoval;
    // rust: let mut visited: Vec<String> = Vec::new();
    // rust: while self.reader.can_read() && self.reader.peek() != ']' {
    // rust: self.reader.skip_whitespace();
    // rust: if self.reader.can_read() && self.reader.peek() == '!' {
    // rust: self.reader.skip();
    // rust: self.sugg = ISugg::Component;
    // rust: let ty = self.component_type()?;
    // rust: if visited.contains(&ty) {
    // rust: return Err(CommandError::tr(
    // rust: "arguments.item.component.repeated",
    // rust: &[&ty],
    // rust: ));
}
    // rust: visited.push(ty);
    // rust: self.sugg = ISugg::Nothing;
    // rust: self.reader.skip_whitespace();
    // rust: } else {
    // rust: let ty = self.component_type()?;
    // rust: if visited.contains(&ty) {
    // rust: return Err(CommandError::tr(
    // rust: "arguments.item.component.repeated",
    // rust: &[&ty],
    // rust: ));
}
    // rust: visited.push(ty.clone());
    // rust: self.sugg = ISugg::Assignment;
    // rust: self.reader.skip_whitespace();
    // rust: self.reader.expect('=')?;
    // rust: self.sugg = ISugg::Nothing;
    // rust: self.reader.skip_whitespace();
    // rust: let cursor = self.reader.cursor;
    // rust: let tag = super::snbt::parse_tag_argument(self.reader)?;
    // rust: if let Err(m) = decode_component(&ty, &tag) {
    // rust: self.reader.cursor = cursor;
    // rust: return Err(CommandError::tr_at(
    // rust: "arguments.item.component.malformed",
    // rust: &[&ty, &m],
    // rust: self.reader,
    // rust: ));
}
    // rust: self.reader.skip_whitespace();
}
    // rust: self.sugg = ISugg::NextOrEndComponents;
    // rust: if !self.reader.can_read() || self.reader.peek() != ',' {
    // rust: break;
}
    // rust: self.reader.skip();
    // rust: self.reader.skip_whitespace();
    // rust: self.sugg = ISugg::ComponentAssignmentOrRemoval;
    // rust: if !self.reader.can_read() {
    // rust: return Err(CommandError::tr_at(
    // rust: "arguments.item.component.expected",
    // rust: &[],
    // rust: self.reader,
    // rust: ));
}
}
    // rust: self.reader.expect(']')?;
    // rust: self.sugg = ISugg::Nothing;
    // rust: Ok(())
}
pub fn suggest_component(self: *Self, b: *mut SuggestionsBuilder, suffix: []const u8) void {
}
    // rust: let contents = b.remaining_lower();
    // rust: for id in &self.reg.persistent_components {
    // rust: let matched = if contents.contains(':') {
    // rust: super::args::matches_sub_str(&contents, id)
    // rust: } else {
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: super::args::matches_sub_str(&contents, ns)
    // rust: || super::args::matches_sub_str(&contents, path)
}
    // rust: if matched {
    // rust: b.suggest(format!("{id}{suffix}"));
}
}
}
pub fn fill(self: *Self, builder: *mut SuggestionsBuilder) void {
}
    // rust: let mut b = builder.offset(self.reader.cursor);
    // rust: let empty = b.remaining().is_empty();
    // rust: match self.sugg {
    // rust: ISugg::Nothing => {}
    // rust: ISugg::Item => suggest_resources(&mut b, self.reg.ids("minecraft:item"), ""),
    // rust: ISugg::StartComponents => {
    // rust: if empty {
    // rust: b.suggest("[");
}
}
    // rust: ISugg::ComponentAssignmentOrRemoval => {
    // rust: b.suggest("!");
    // rust: self.suggest_component(&mut b, "=");
}
    // rust: ISugg::Component => self.suggest_component(&mut b, ""),
    // rust: ISugg::Assignment => {
    // rust: if empty {
    // rust: b.suggest("=");
}
}
    // rust: ISugg::NextOrEndComponents => {
    // rust: if empty {
    // rust: b.suggest(",");
    // rust: b.suggest("]");
}
}
}
    // rust: builder.add(b);
}
}

/// ItemArgument.parse (ItemParser.parse; the reader is rewound on errors).
pub fn parse_stack(reader: *mut Reader, reg: *Registries) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cursor = reader.cursor;
    // rust: let r = ItemState {
    // rust: reader,
    // rust: reg,
    // rust: sugg: ISugg::Nothing,
}
    // rust: .parse();
    // rust: if r.is_err() {
    // rust: reader.cursor = cursor;
}
    // rust: r
}
/// ItemParser.fillSuggestions.
pub fn suggest_stack(builder: *mut SuggestionsBuilder, reg: *Registries) void {
}
    // rust: let mut reader = Reader {
    // rust: string: builder.input,
    // rust: cursor: builder.start,
}
    // rust: let mut state = ItemState {
    // rust: reader: &mut reader,
    // rust: reg,
    // rust: sugg: ISugg::Nothing,
}
    // rust: let _ = state.parse();
    // rust: state.fill(builder);
}

// ---- ItemPredicateArgument ------------------------------------------------

pub const TypeRes = enum {
    Item(String),
    Tag(String),
};
pub const IV = enum {
    Id(String),
    Type(Option<TypeRes>),
    Elem(TypeRes),
    Unit,
    Test,
    Comp(String),
    Pred(String),
    Tag(Tag),
    List(Vec<IV>),
};
    // rust: impl Value for IV {
pub fn list(items: std.ArrayList(Self)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: IV::List(items)
}
}

    // rust: fn reg<'a>(state: &State<'a, IV>) -> &'a Registries {
    // rust: state
    // rust: .ctx
    // rust: .and_then(|c| c.downcast_ref::<Registries>())
    // rust: .expect("item predicate grammar needs the registries")
}

/// IdentifierParseRule: skip whitespace, a non-empty identifier (no error).
pub fn id_rule(state: *mut State<IV>) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = state.reader();
    // rust: r.skip_whitespace();
    // rust: let start = r.cursor;
    // rust: while r.can_read() && is_id_char(r.peek()) {
    // rust: r.skip();
}
    // rust: let raw = &r.string[start..r.cursor];
    // rust: let id = if raw.is_empty() {
    // rust: None
    // rust: } else {
    // rust: parse_identifier(raw)
}
    // rust: match id {
    // rust: Some(id) => {
    // rust: state.set_reader(&r);
    // rust: Some(IV::Id(id))
}
    // rust: None => {
    // rust: r.cursor = start;
    // rust: state.set_reader(&r);
    // rust: None
}
}
}

/// ResourceLookupRule: an identifier validated by `validate`.
    // rust: fn lookup(
    // rust: state: &mut State<IV>,
    // rust: id_rule: usize,
    // rust: possible: Rc<Vec<String>>,
    // rust: validate: &dyn Fn(&str, &Reader) -> Result<IV, CommandError>,
    // rust: ) -> Option<IV> {
    // rust: let mut r = state.reader();
    // rust: r.skip_whitespace();
    // rust: state.set_reader(&r);
    // rust: let mark = state.cursor;
    // rust: match state.parse(id_rule) {
    // rust: Some(IV::Id(id)) => match validate(&id, &state.reader()) {
    // rust: Ok(v) => Some(v),
    // rust: Err(e) => {
    // rust: state.store(mark, Sugg::Resources(possible), Reason::Error(e));
    // rust: None
}
    // rust: },
    // rust: _ => {
    // rust: state.store(
    // rust: mark,
    // rust: Sugg::Resources(possible),
    // rust: Reason::Delayed("argument.id.invalid", Vec::new()),
    // rust: );
    // rust: None
}
}
}

pub fn predicate_grammar() G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut g: Grammar<IV> = Grammar::new();
    // rust: let id = g.put_custom("id", id_rule);
    // rust: let ty = g.named("type");
    // rust: let conditions = g.named("conditions");
    // rust: let ty2 = g.named("type");
    // rust: g.put_term(
    // rust: "top",
    // rust: alt(vec![
    // rust: seq(vec![ty, ch('['), Term::Cut, opt(conditions), ch(']')]),
    // rust: ty2,
    // rust: ]),
    // rust: |s| {
    // rust: let mut out = Vec::new();
    // rust: if let Some(t) = s.scope.get("type") {
    // rust: out.push(t);
}
    // rust: if let Some(IV::List(c)) = s.scope.get("conditions") {
    // rust: out.extend(c);
}
    // rust: Some(IV::List(out))
    // rust: },
    // rust: );
    // rust: let element = g.named("element_type");
    // rust: let tag = g.named("tag_type");
    // rust: let any = g.named("any_type");
    // rust: g.put_term(
    // rust: "type",
    // rust: alt(vec![element, seq(vec![ch('#'), Term::Cut, tag]), any]),
    // rust: |s| {
    // rust: Some(IV::Type(
    // rust: match s.scope.get_any(&["element_type", "tag_type"]) {
    // rust: Some(IV::Elem(t)) => Some(t),
    // rust: _ => None,
    // rust: },
    // rust: ))
    // rust: },
    // rust: );
    // rust: g.put_term("any_type", ch('*'), |_| Some(IV::Unit));
    // rust: g.put_custom("element_type", move |s| {
    // rust: let r = reg(s);
    // rust: let items = Rc::new(r.ids("minecraft:item").to_vec());
    // rust: lookup(s, id, items, &|id, reader| {
    // rust: if r.ids("minecraft:item").iter().any(|i| i == id) {
    // rust: Ok(IV::Elem(TypeRes::Item(id.to_owned())))
    // rust: } else {
    // rust: Err(CommandError::tr_at(
    // rust: "argument.item.id.invalid",
    // rust: &[&id],
    // rust: reader,
    // rust: ))
}
    // rust: })
    // rust: });
    // rust: g.put_custom("tag_type", move |s| {
    // rust: let r = reg(s);
    // rust: let tags = Rc::new(r.tags("minecraft:item").to_vec());
    // rust: lookup(s, id, tags, &|id, reader| {
    // rust: if r.tags("minecraft:item").iter().any(|i| i == id) {
    // rust: Ok(IV::Elem(TypeRes::Tag(id.to_owned())))
    // rust: } else {
    // rust: Err(CommandError::tr_at(
    // rust: "arguments.item.tag.unknown",
    // rust: &[&id],
    // rust: reader,
    // rust: ))
}
    // rust: })
    // rust: });
    // rust: let alternatives = g.named("alternatives");
    // rust: let rest = g.named("conditions");
    // rust: g.put_term(
    // rust: "conditions",
    // rust: seq(vec![alternatives, opt(seq(vec![ch(','), rest]))]),
    // rust: |s| {
    // rust: let mut out = vec![IV::Test];
    // rust: if let Some(IV::List(c)) = s.scope.get("conditions") {
    // rust: out.extend(c);
}
    // rust: Some(IV::List(out))
    // rust: },
    // rust: );
    // rust: let term = g.named("term");
    // rust: let rest = g.named("alternatives");
    // rust: g.put_term(
    // rust: "alternatives",
    // rust: seq(vec![term, opt(seq(vec![ch('|'), rest]))]),
    // rust: |s| {
    // rust: let mut out = vec![s.scope.get("term").unwrap_or(IV::Test)];
    // rust: if let Some(IV::List(c)) = s.scope.get("alternatives") {
    // rust: out.extend(c);
}
    // rust: Some(IV::List(out))
    // rust: },
    // rust: );
    // rust: let test = g.named("test");
    // rust: let negation = g.named("negation");
    // rust: g.put_term("term", alt(vec![test, seq(vec![ch('!'), negation])]), |s| {
    // rust: s.scope.get_any(&["test", "negation"])
    // rust: });
    // rust: let test = g.named("test");
    // rust: g.put_term("negation", test, |_| Some(IV::Test));
    // rust: let comp = g.named("component_type");
    // rust: let tag_a = g.named("tag");
    // rust: let pred = g.named("predicate_type");
    // rust: let tag_b = g.named("tag");
    // rust: let comp2 = g.named("component_type");
    // rust: g.put_term(
    // rust: "test",
    // rust: alt(vec![
    // rust: seq(vec![comp, ch('='), Term::Cut, tag_a]),
    // rust: seq(vec![pred, ch('~'), Term::Cut, tag_b]),
    // rust: comp2,
    // rust: ]),
    // rust: |s| {
    // rust: let value = match s.scope.get("tag") {
    // rust: Some(IV::Tag(t)) => Some(t),
    // rust: _ => None,
}
    // rust: let reader = s.reader();
    // rust: let result = if let Some(IV::Pred(p)) = s.scope.get("predicate_type") {
    // rust: decode_predicate(&p, value.as_ref().unwrap_or(&Tag::End)).map_err(|m| {
    // rust: CommandError::tr_at("arguments.item.predicate.malformed", &[&p, &m], &reader)
    // rust: })
    // rust: } else if let (Some(IV::Comp(c)), Some(v)) = (s.scope.get("component_type"), value) {
    // rust: decode_component(&c, &v).map_err(|m| {
    // rust: CommandError::tr_at("arguments.item.component.malformed", &[&c, &m], &reader)
    // rust: })
    // rust: } else {
    // rust: Ok(())
}
    // rust: match result {
    // rust: Ok(()) => Some(IV::Test),
    // rust: Err(e) => {
    // rust: s.store(s.cursor, Sugg::Empty, Reason::Error(e));
    // rust: None
}
}
    // rust: },
    // rust: );
    // rust: g.put_custom("component_type", move |s| {
    // rust: let r = reg(s);
    // rust: let mut list = vec!["minecraft:count".to_owned()];
    // rust: list.extend(r.persistent_components.iter().cloned());
    // rust: lookup(s, id, Rc::new(list), &|id, reader| {
    // rust: if id == "minecraft:count" {
    // rust: return Ok(IV::Comp(id.to_owned()));
}
    // rust: let known = r
    // rust: .ids("minecraft:data_component_type")
    // rust: .iter()
    // rust: .any(|c| c == id);
    // rust: if known && r.persistent_components.iter().any(|c| c == id) {
    // rust: Ok(IV::Comp(id.to_owned()))
    // rust: } else {
    // rust: Err(CommandError::tr_at(
    // rust: "arguments.item.component.unknown",
    // rust: &[&id],
    // rust: reader,
    // rust: ))
}
    // rust: })
    // rust: });
    // rust: g.put_custom("predicate_type", move |s| {
    // rust: let r = reg(s);
    // rust: let mut list = vec!["minecraft:count".to_owned()];
    // rust: list.extend(
    // rust: r.ids("minecraft:data_component_predicate_type")
    // rust: .iter()
    // rust: .cloned(),
    // rust: );
    // rust: lookup(s, id, Rc::new(list), &|id, reader| {
    // rust: if id == "minecraft:count"
    // rust: || r.ids("minecraft:data_component_predicate_type")
    // rust: .iter()
    // rust: .any(|c| c == id)
    // rust: {
    // rust: return Ok(IV::Pred(id.to_owned()));
}
    // rust: if r.ids("minecraft:data_component_type")
    // rust: .iter()
    // rust: .any(|c| c == id)
    // rust: {
                // A component existence predicate (decodes Unit).
    // rust: return Ok(IV::Pred(format!("exists:{id}")));
}
    // rust: Err(CommandError::tr_at(
    // rust: "arguments.item.predicate.unknown",
    // rust: &[&id],
    // rust: reader,
    // rust: ))
    // rust: })
    // rust: });
    // rust: g.put_custom("tag", |s| super::snbt::rule_in(s, IV::Tag));
    // rust: g.top = g.id("top");
    // rust: g
}

    // rust: thread_local! {
pub const PREDICATE: Grammar<IV> = predicate_grammar();
}
/// ItemPredicateArgument.parse.
pub fn parse_predicate(reader: *mut Reader, reg: *Registries) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = reader.cursor;
    // rust: let result = PREDICATE.with(|g| g.parse_for_commands_with(reader, Some(reg)))?;
    // rust: let IV::List(items) = result else {
    // rust: return Err(CommandError::tr_at("argument.id.invalid", &[], reader));
}
    // rust: let text = &reader.string[start..reader.cursor];
    // rust: let (id, tag, any) = match items.first() {
    // rust: Some(IV::Type(Some(TypeRes::Item(i)))) => (i.clone(), false, false),
    // rust: Some(IV::Type(Some(TypeRes::Tag(t)))) => (t.clone(), true, false),
    // rust: _ => ("*".to_owned(), false, true),
}
    // rust: let components = text.find('[').map(|i| text[i..].to_owned());
    // rust: Ok(ItemInput {
    // rust: id,
    // rust: tag,
    // rust: any,
    // rust: components,
    // rust: })
}
/// ItemPredicateArgument.listSuggestions.
pub fn suggest_predicate(builder: *mut SuggestionsBuilder, reg: *Registries) void {
}
    // rust: PREDICATE.with(|g| g.parse_for_suggestions_with(builder, Some(reg)));
}

    // rust: mod tests {
//     use super::decode_component;

pub fn check(snbt: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tag = horizon_world::nbt::parse_snbt(snbt).expect("snbt").0;
    // rust: decode_component("minecraft:block_entity_data", &tag)
}

pub fn block_entity_data_needs_a_known_type() void {
}
    // rust: assert_eq!(check("{id:\"chest\",Lock:1}"), Ok(()));
    // rust: assert_eq!(
    // rust: check("{Command:\"say\"}"),
    // rust: Err("Expected 'id' field in {Command:\"say\"}".into())
    // rust: );
    // rust: assert_eq!(
    // rust: check("{id:\"minecraft:stone\"}"),
    // rust: Err("Unknown registry key in ResourceKey[minecraft:root / minecraft:block_entity_type]: minecraft:stone".into())
    // rust: );
}
}
