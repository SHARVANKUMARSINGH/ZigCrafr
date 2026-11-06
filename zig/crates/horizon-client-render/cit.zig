//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_cit
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! OptiFine's Custom Item Textures (and CIT Resewn's): the rules of the enabled packs'
//! `optifine/cit/**/*.properties`, read from the overlay resource root. The rules themselves are
//! `horizon_optifine::cit`'s.

    // rust: pub use horizon_optifine::cit::{Hand, Kind, Rule};

// use crate::cit_glint::{Global, StackGlint};
// use horizon_client_core::component::name_text;
// use horizon_client_core::scoreboard::comp_text;
// use horizon_items::item_data::{canon_tag, encode_components};
// use horizon_items::items::ItemStack;
// use horizon_optifine::cit::{ComponentTest, Source, ValueTest};
// use horizon_optifine::{Properties, properties_files_in};
// use horizon_world::nbt::{JavaString, Tag, parse_snbt};
// use std::borrow::Cow;
// use std::collections::HashMap;
// use std::fs;
// use std::hash::{DefaultHasher, Hash, Hasher};
// use std::path::Path;
// use std::sync::{Arc, Mutex};

/// Every rule under the root's `optifine/cit/`, `mcpatcher/cit/` and CIT Resewn's
/// `citresewn/cit/` folders, the one chosen first when several match first (`Rule::priority`).
/// The pack's global `cit.properties` is not a rule.
pub fn load_rules(root: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tops = ["optifine", "mcpatcher", "citresewn"];
    // rust: let mut rules: Vec<Rule> = properties_files_in(root, &tops, "cit")
    // rust: .into_iter()
    // rust: .filter(|path| !path.ends_with("/cit.properties"))
    // rust: .filter_map(|path| {
    // rust: let props = read_properties(&root.join(&path))?;
    // rust: let rule = Rule::parse(&path, &props, |p| root.join(p).is_file());
    // rust: if rule.is_none() {
    // rust: log::warn!("custom item textures: {path} is not a rule Horizon can read");
}
    // rust: rule
    // rust: })
    // rust: .collect();
    // rust: rules.sort_by(Rule::priority);
    // rust: rules
}

/// A `.properties` file as CIT Resewn reads them (`Properties::parse_equals_first`): UTF-8,
/// else Latin-1 as Java reads them, so a pack saved that way still loads. `None` when it can't
/// be read.
pub fn read_properties(path: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bytes = fs::read(path).ok()?;
    // rust: let text = String::from_utf8(bytes)
    // rust: .unwrap_or_else(|e| e.into_bytes().iter().map(|&b| char::from(b)).collect());
    // rust: Some(Properties::parse_equals_first(&text))
}

/// The rules with an index by item and a cache of what each stack matched.
pub const CitRules = struct {
    rules: std.ArrayList(Rule),
    /// The pack's `cit.properties`.
    global: Global,
    /// Per kind (`Kind as usize`), the rules naming each item, in priority order.
    by_item: [HashMap<[]const u8,
    /// Enchantment rules without `items`, in priority order.
    any_item: std.ArrayList(u32),
    /// Per rule, per component test: its literal read as SNBT and as a JSON text component.
    literals: std.ArrayList(Vec<Prepared)>,
    selected: Mutex<HashMap<u64,
    enchanted: Mutex<HashMap<u64,
    glints: Mutex<HashMap<u64,
};

pub const Prepared = struct {
    snbt: ?Tag,
    json: ?[]const u8,
};

/// Cache entries kept before the cache starts over.
pub const CACHE_LIMIT: usize = 4096;

    // rust: impl CitRules {
    /// The enabled packs' rules under the overlay resource root.
pub fn load(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: global: crate::cit_glint::load_global(root),
    // rust: ..Self::new(load_rules(root))
}
}

    /// `rules` in priority order, the winner first.
pub fn new(rules: std.ArrayList(Rule)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut by_item: [HashMap<String, Vec<u32>>; 4] = Default::default();
    // rust: let mut any_item = Vec::new();
    // rust: for (i, rule) in rules.iter().enumerate() {
    // rust: let i = i as u32;
    // rust: if rule.kind == Kind::Enchantment && rule.items.is_empty() {
    // rust: any_item.push(i);
}
    // rust: for item in &rule.items {
    // rust: let list = by_item[rule.kind as usize].entry(item.clone()).or_default();
    // rust: if list.last() != Some(&i) {
    // rust: list.push(i);
}
}
}
    // rust: let literals = rules
    // rust: .iter()
    // rust: .map(|r| r.components.iter().map(prepare).collect())
    // rust: .collect();
    // rust: Self {
    // rust: rules,
    // rust: by_item,
    // rust: any_item,
    // rust: literals,
    // rust: ..Default::default()
}
}

pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.rules.is_empty()
}

    /// Leave out the Enchantment rules `keep` refuses (those without a drawable texture): they
    /// match no stack, so vanilla's glint and the other rules of their layer stay.
pub fn keep_glints(self: *Self, keep: impl Fn(usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.any_item.retain(|&i| keep(i as usize));
    // rust: let named = &mut self.by_item[Kind::Enchantment as usize];
    // rust: for list in named.values_mut() {
    // rust: list.retain(|&i| keep(i as usize));
}
    // rust: named.retain(|_, list| !list.is_empty());
    // rust: lock(&self.enchanted).clear();
    // rust: lock(&self.glints).clear();
}

    /// The winning rule of `kind` (Item, Armor or Elytra) for this stack, as an index into `rules`.
    // rust: pub fn select(
    // rust: &self,
    // rust: kind: Kind,
    // rust: stack: &ItemStack,
    // rust: hand: Hand,
    // rust: max_damage: u32,
    // rust: ) -> Option<usize> {
    // rust: let candidates = self.by_item[kind as usize].get(&*stack.item)?;
    // rust: let comps = encode_components(stack);
    // rust: let key = cache_key((0, kind, hand), stack, max_damage, comps.as_ref());
    // rust: if let Some(hit) = lock(&self.selected).get(&key) {
    // rust: return hit.map(|i| i as usize);
}
    // rust: let found = candidates
    // rust: .iter()
    // rust: .copied()
    // rust: .find(|&i| self.matches(i, stack, hand, max_damage, comps.as_ref()));
    // rust: remember(&self.selected, key, found);
    // rust: found.map(|i| i as usize)
}

    /// Every matching Enchantment rule for the stack drawn in `hand` (`Hand::Main` for one in a
    /// GUI), in priority order.
pub fn enchantments(self: *Self, stack: *ItemStack, hand: Hand, max_damage: u32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let named = self.by_item[Kind::Enchantment as usize]
    // rust: .get(&*stack.item)
    // rust: .map_or(&[][..], Vec::as_slice);
    // rust: if named.is_empty() && self.any_item.is_empty() {
    // rust: return Vec::new();
}
    // rust: let comps = encode_components(stack);
    // rust: let key = cache_key(
    // rust: (1, Kind::Enchantment, hand),
    // rust: stack,
    // rust: max_damage,
    // rust: comps.as_ref(),
    // rust: );
    // rust: let hit = lock(&self.enchanted).get(&key).cloned();
    // rust: let found = hit.unwrap_or_else(|| {
    // rust: let mut all: Vec<u32> = named.iter().chain(&self.any_item).copied().collect();
    // rust: all.sort_unstable();
    // rust: all.retain(|&i| self.matches(i, stack, hand, max_damage, comps.as_ref()));
    // rust: remember(&self.enchanted, key, all.clone());
    // rust: all
    // rust: });
    // rust: found.into_iter().map(|i| i as usize).collect()
}

    /// The glint layers this stack draws in `hand` (`Hand::Main` in a GUI) and whether
    /// vanilla's still does (`StackGlint`), worked out once per stack and hand; `None` when the
    /// pack changes no glint. `foil` is whether the stack draws a glint at all
    /// (`ItemStack::has_foil`): one that doesn't gets no layers.
    // rust: pub fn glint(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: hand: Hand,
    // rust: max_damage: u32,
    // rust: foil: bool,
    // rust: ) -> Option<Arc<StackGlint>> {
    // rust: let no_rules =
    // rust: self.any_item.is_empty() && self.by_item[Kind::Enchantment as usize].is_empty();
        // Before the cache, which `foil` is not part of.
    // rust: if !foil || (no_rules && self.global.use_glint) {
    // rust: return None;
}
    // rust: let comps = encode_components(stack);
    // rust: let key = cache_key(
    // rust: (2, Kind::Enchantment, hand),
    // rust: stack,
    // rust: max_damage,
    // rust: comps.as_ref(),
    // rust: );
    // rust: if let Some(hit) = lock(&self.glints).get(&key) {
    // rust: return Some(hit.clone());
}
    // rust: let matched = self.enchantments(stack, hand, max_damage);
    // rust: let glint = Arc::new(StackGlint::new(
    // rust: &self.rules,
    // rust: &matched,
    // rust: stack.crafting_enchantments(),
    // rust: &self.global,
    // rust: ));
    // rust: remember(&self.glints, key, glint.clone());
    // rust: Some(glint)
}

    /// Whether rule `i` matches the stack drawn in `hand`.
    // rust: fn matches(
    // rust: &self,
    // rust: i: u32,
    // rust: stack: &ItemStack,
    // rust: hand: Hand,
    // rust: max_damage: u32,
    // rust: comps: Option<&Tag>,
    // rust: ) -> bool {
    // rust: let rule = &self.rules[i as usize];
    // rust: if rule.hand != Hand::Any && rule.hand != hand {
    // rust: return false;
}
    // rust: let count = i32::try_from(stack.count).unwrap_or(i32::MAX);
    // rust: if rule.stack_size.as_ref().is_some_and(|r| !r.contains(count)) {
    // rust: return false;
}
        // CIT Resewn: only damageable items have damage.
    // rust: let damage = if max_damage > 0 { stack.damage } else { 0 };
    // rust: if rule
    // rust: .damage
    // rust: .as_ref()
    // rust: .is_some_and(|d| !d.matches(damage, max_damage))
    // rust: {
    // rust: return false;
}
    // rust: let enchantments = stack.crafting_enchantments();
    // rust: let listed = |id: &str| rule.enchantments.iter().any(|e| e == id);
    // rust: if !rule.enchantments.is_empty() && !enchantments.iter().any(|(id, _)| listed(id)) {
    // rust: return false;
}
    // rust: if let Some(levels) = &rule.enchantment_levels {
    // rust: let level_in_range = enchantments.iter().any(|(id, level)| {
    // rust: (rule.enchantments.is_empty() || listed(id))
    // rust: && levels.contains(i32::try_from(*level).unwrap_or(i32::MAX))
    // rust: });
    // rust: if !level_in_range {
    // rust: return false;
}
}
    // rust: let literals = &self.literals[i as usize];
    // rust: rule.components
    // rust: .iter()
    // rust: .zip(literals)
    // rust: .all(|(test, lit)| component_test(test, lit, stack, comps) != test.negate)
}
}

    // rust: fn lock<T>(m: &Mutex<T>) -> std::sync::MutexGuard<'_, T> {
    // rust: m.lock().unwrap_or_else(|e| e.into_inner())
}

    // rust: fn remember<V>(cache: &Mutex<HashMap<u64, V>>, key: u64, value: V) {
    // rust: let mut cache = lock(cache);
    // rust: if cache.len() >= CACHE_LIMIT {
    // rust: cache.clear();
}
    // rust: cache.insert(key, value);
}

/// What a cached answer depends on; `query` tells `select`, `enchantments` and `glint` apart.
pub fn cache_key(query: (u8) void {
}
    // rust: let mut h = DefaultHasher::new();
    // rust: (query.0, query.1 as u8, query.2 as u8, &*stack.item).hash(&mut h);
    // rust: (stack.count, stack.damage, max, comps).hash(&mut h);
    // rust: h.finish()
}

pub fn prepare(test: *ComponentTest) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ValueTest::Literal(lit) = &test.value else {
    // rust: return Prepared::default();
}
    // rust: let text = lit.text.trim();
    // rust: let snbt = match parse_snbt(text) {
    // rust: Ok((tag, read)) if read == text.len() && text.starts_with(['{', '[']) => Some(tag),
    // rust: _ => None,
}
    // rust: let json = json_plain(text);
    // rust: Prepared { snbt, json }
}

/// The plain text of `s` read as a JSON text component.
pub fn json_plain(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !s.starts_with(['{', '[', '"']) {
    // rust: return None;
}
    // rust: let value: serde_json::Value = serde_json::from_str(s).ok()?;
    // rust: Some(comp_text(&value).plain())
}

/// Whether one test passes, before its `negate`.
    // rust: fn component_test(
    // rust: test: &ComponentTest,
    // rust: lit: &Prepared,
    // rust: stack: &ItemStack,
    // rust: comps: Option<&Tag>,
    // rust: ) -> bool {
    // rust: let legacy;
    // rust: let (root, text_depth) = match &test.source {
    // rust: Source::Component(id) => {
    // rust: let depth = match id.as_str() {
    // rust: "minecraft:custom_name" | "minecraft:item_name" => Some(0),
    // rust: "minecraft:lore" => Some(1),
    // rust: _ => None,
}
    // rust: (comps.and_then(|c| c.get(id)), depth)
}
    // rust: Source::LegacyEnchantments { stored } => {
    // rust: let levels = if *stored {
    // rust: stack.stored_enchantments()
    // rust: } else {
    // rust: stack.enchantments()
}
    // rust: legacy = Tag::List(
    // rust: levels
    // rust: .iter()
    // rust: .map(|(id, lvl)| {
    // rust: let lvl = i16::try_from(*lvl).unwrap_or(i16::MAX);
    // rust: Tag::compound([
    // rust: ("id", Tag::String((&**id).into())),
    // rust: ("lvl", Tag::Short(lvl)),
    // rust: ])
    // rust: })
    // rust: .collect(),
    // rust: );
    // rust: (Some(&legacy), None)
}
}
    // Fields the component leaves out when 0, which pre-1.20.5 items always wrote.
    // rust: let defaulted;
    // rust: let root = match (&test.source, root, test.path.first()) {
    // rust: (Source::Component(id), Some(Tag::Compound(map)), Some(field))
    // rust: if matches!(
    // rust: (id.as_str(), field.as_str()),
    // rust: ("minecraft:written_book_content", "generation")
    // rust: | ("minecraft:fireworks", "flight_duration")
    // rust: ) && !map.contains_key(&JavaString::from(field.as_str())) =>
    // rust: {
    // rust: let mut map = map.clone();
    // rust: map.insert(JavaString::from(field.as_str()), Tag::Int(0));
    // rust: defaulted = Tag::Compound(map);
    // rust: Some(&defaulted)
}
    // rust: (_, root, _) => root,
}
    // rust: let Some(root) = root else {
    // rust: return matches!(test.value, ValueTest::Exists(false));
}
    // rust: if let ValueTest::Exists(want) = test.value {
    // rust: return walk(root, &test.path, 0, &mut |_, _| true) == want;
}
    // rust: walk(root, &test.path, 0, &mut |tag, depth| {
    // rust: value_test(&test.value, lit, tag, text_depth == Some(depth))
    // rust: })
}

/// Visits what `path` reaches from `tag`, true once `visit` is.
    // rust: fn walk(
    // rust: tag: &Tag,
    // rust: path: &[String],
    // rust: depth: usize,
    // rust: visit: &mut dyn FnMut(&Tag, usize) -> bool,
    // rust: ) -> bool {
    // rust: let Some((seg, rest)) = path.split_first() else {
    // rust: return visit(tag, depth);
}
    // rust: let mut next = |t: &Tag| walk(t, rest, depth + 1, visit);
    // rust: let len = match tag {
    // rust: Tag::Compound(map) if seg == "*" => return map.values().any(&mut next),
    // rust: Tag::Compound(map) => return map.get(&JavaString::from(seg.as_str())).is_some_and(next),
    // rust: Tag::List(v) => v.len(),
    // rust: Tag::ByteArray(v) => v.len(),
    // rust: Tag::IntArray(v) => v.len(),
    // rust: Tag::LongArray(v) => v.len(),
    // rust: _ => return false,
}
    // rust: let element = |i: usize| match tag {
    // rust: Tag::List(v) => Cow::Borrowed(&v[i]),
    // rust: Tag::ByteArray(v) => Cow::Owned(Tag::Byte(v[i] as i8)),
    // rust: Tag::IntArray(v) => Cow::Owned(Tag::Int(v[i])),
    // rust: Tag::LongArray(v) => Cow::Owned(Tag::Long(v[i])),
    // rust: _ => Cow::Owned(Tag::End),
}
    // rust: if seg == "count" {
    // rust: return next(&Tag::Int(i32::try_from(len).unwrap_or(i32::MAX)));
}
    // rust: if seg == "*" {
    // rust: return (0..len).any(|i| next(&element(i)));
}
    // rust: seg.parse::<usize>()
    // rust: .ok()
    // rust: .filter(|&i| i < len)
    // rust: .is_some_and(|i| next(&element(i)))
}

pub fn int_value(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match *tag {
    // rust: Tag::Byte(v) => Some(v.into()),
    // rust: Tag::Short(v) => Some(v.into()),
    // rust: Tag::Int(v) => Some(v.into()),
    // rust: Tag::Long(v) => Some(v),
    // rust: _ => None,
}
}

/// A number as Java's `String.valueOf` writes it (`3`, `3.0`).
pub fn decimal(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = match *tag {
    // rust: Tag::Float(b) => f32::from_bits(b).to_string(),
    // rust: Tag::Double(b) => f64::from_bits(b).to_string(),
    // rust: _ => return int_value(tag).map(|v| v.to_string()),
}
    // rust: Some(if s.contains(['.', 'e', 'N', 'i']) {
    // rust: s
    // rust: } else {
    // rust: s + ".0"
    // rust: })
}

/// `text` against a string, its JSON text, or the plain text of a text component.
pub fn text_matches(tag: *Tag, is_text: bool, text: impl Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::String(s) => {
    // rust: let s = s.to_string_lossy();
    // rust: text(&s)
    // rust: || (is_text && text(&name_text(tag).plain()))
    // rust: || json_plain(&s).is_some_and(|p| text(&p))
}
    // rust: Tag::Compound(_) | Tag::List(_) => is_text && text(&name_text(tag).plain()),
    // rust: _ => false,
}
}

pub fn value_test(test: *ValueTest, lit: *Prepared, tag: *Tag, is_text: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match test {
    // rust: ValueTest::Exists(_) => true,
    // rust: ValueTest::Range(r) => {
    // rust: int_value(tag).is_some_and(|v| i32::try_from(v).is_ok_and(|v| r.contains(v)))
}
    // rust: ValueTest::Raw(name) => name.matches(&canon_tag(tag)),
    // rust: ValueTest::Text(name) => match decimal(tag) {
    // rust: Some(n) => name.matches(&n),
    // rust: None => text_matches(tag, is_text, |s| name.matches(s)),
    // rust: },
    // rust: ValueTest::Literal(l) => match tag {
    // rust: Tag::Float(b) => l.text.trim().parse::<f32>().ok() == Some(f32::from_bits(*b)),
    // rust: Tag::Double(b) => l.float == Some(f64::from_bits(*b)),
    // rust: Tag::Compound(_) | Tag::List(_)
    // rust: if lit.snbt.as_ref().is_some_and(|e| contains(e, tag)) =>
    // rust: {
    // rust: true
}
    // rust: _ => match int_value(tag) {
    // rust: Some(v) => l.int == Some(v),
    // rust: None => text_matches(tag, is_text, |s| {
    // rust: s == l.text || lit.json.as_deref() == Some(s)
    // rust: }),
    // rust: },
    // rust: },
}
}

/// `NbtUtils.compareNbt(expected, actual, true)`: every key and element of `expected` found in
/// `actual`.
pub fn contains(expected: *Tag, actual: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (expected, actual) {
    // rust: (Tag::Compound(e), Tag::Compound(a)) => e
    // rust: .iter()
    // rust: .all(|(k, v)| a.get(k).is_some_and(|a| contains(v, a))),
    // rust: (Tag::List(e), Tag::List(a)) if e.is_empty() => a.is_empty(),
    // rust: (Tag::List(e), Tag::List(a)) => e.iter().all(|e| a.iter().any(|a| contains(e, a))),
    // rust: _ => expected == actual,
}
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::Arc;

    /// Rules from (file stem, properties), sorted as `load_rules` sorts them.
pub fn rules(files: *[([]const u8) void {
}
    // rust: let mut rules: Vec<Rule> = files
    // rust: .iter()
    // rust: .map(|(stem, text)| {
    // rust: let path = format!("assets/minecraft/optifine/cit/{stem}.properties");
    // rust: let text = format!("texture=x\n{text}");
    // rust: Rule::parse(&path, &Properties::parse_equals_first(&text), |_| true).unwrap()
    // rust: })
    // rust: .collect();
    // rust: rules.sort_by(Rule::priority);
    // rust: CitRules::new(rules)
}

pub fn stem(cit: *CitRules, i: ?usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let path = &cit.rules[i?].path;
    // rust: path.rsplit('/').next()?.strip_suffix(".properties")
}

pub fn item(cit: *CitRules, stack: ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stem(cit, cit.select(Kind::Item, &stack, Hand::Main, 0))
}

pub fn new(id: []const u8) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack::new(&format!("minecraft:{id}"), 1)
}

pub fn string(s: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::String(s.into())
}

pub fn with(id: []const u8, component: []const u8, tag: Tag) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut stack = new(id);
    // rust: let component = format!("minecraft:{component}");
    // rust: stack.data_mut().other.push((component, tag));
    // rust: stack
}

pub fn enchanted(id: []const u8, levels: *[([]const u8) void {
}
    // rust: let mut stack = new(id);
    // rust: let levels = levels
    // rust: .iter()
    // rust: .map(|(e, l)| (Arc::from(format!("minecraft:{e}")), *l));
    // rust: stack.data_mut().enchantments = levels.collect();
    // rust: stack
}

pub fn heavier_rules_win_and_kinds_stay_apart() void {
}
    // rust: let cit = rules(&[
    // rust: ("plain", "items=stick"),
    // rust: ("heavy", "items=stick\nweight=2\nstackSize=2-"),
    // rust: ("offhand", "items=stick\nweight=5\nhand=off"),
    // rust: ("armor", "type=armor\nitems=stick"),
    // rust: ("wings", "type=elytra"),
    // rust: ]);
    // rust: assert_eq!(item(&cit, new("stick")), Some("plain"));
    // rust: assert_eq!(
    // rust: item(&cit, ItemStack::new("minecraft:stick", 3)),
    // rust: Some("heavy")
    // rust: );
    // rust: let pick = |kind, id, hand, max| stem(&cit, cit.select(kind, &new(id), hand, max));
    // rust: assert_eq!(pick(Kind::Item, "stick", Hand::Off, 0), Some("offhand"));
    // rust: assert_eq!(item(&cit, new("stone")), None);
    // rust: assert_eq!(item(&cit, new("elytra")), None);
    // rust: assert_eq!(pick(Kind::Elytra, "elytra", Hand::Main, 432), Some("wings"));
    // rust: assert_eq!(pick(Kind::Armor, "stick", Hand::Main, 0), Some("armor"));
}

pub fn names_match_by_their_plain_text() void {
}
    // rust: let cit = rules(&[
    // rust: ("glob", "items=stick\nnbt.display.Name=ipattern:*sword"),
    // rust: ("exact", "items=stone\ncomponents.custom_name=My Sword"),
    // rust: ("json", "items=dirt\nnbt.display.Name=[\"My \",\"Sword\"]"),
    // rust: ]);
    // rust: let named = |id: &str, name: Tag| {
    // rust: let mut stack = new(id);
    // rust: stack.data_mut().custom_name = Some(name);
    // rust: stack
}
    // rust: let styled = Tag::compound([("text", string("My Sword")), ("color", string("red"))]);
    // rust: assert_eq!(item(&cit, named("stick", styled.clone())), Some("glob"));
    // rust: assert_eq!(item(&cit, named("stick", string("Blade"))), None);
    // rust: assert_eq!(item(&cit, new("stick")), None);
    // rust: assert_eq!(item(&cit, named("stone", styled.clone())), Some("exact"));
    // rust: assert_eq!(item(&cit, named("dirt", styled)), Some("json"));
}

pub fn lore_lines_and_list_counts() void {
}
    // rust: let cit = rules(&[
    // rust: (
    // rust: "any_line",
    // rust: "items=stick\nnbt.display.Lore.*=ipattern:*legendary*",
    // rust: ),
    // rust: ("two_lines", "items=stone\ncomponents.lore.count=2"),
    // rust: ]);
    // rust: let bold = Tag::compound([("text", string("A LEGENDARY item")), ("bold", Tag::Byte(1))]);
    // rust: let lore = Tag::List(vec![string("Common"), bold]);
    // rust: assert_eq!(
    // rust: item(&cit, with("stick", "lore", lore.clone())),
    // rust: Some("any_line")
    // rust: );
    // rust: assert_eq!(item(&cit, with("stone", "lore", lore)), Some("two_lines"));
    // rust: let one = Tag::List(vec![string("A legendary item")]);
    // rust: assert_eq!(item(&cit, with("stone", "lore", one)), None);
}

pub fn custom_data_existence_and_negation() void {
}
    // rust: let cit = rules(&[
    // rust: (
    // rust: "aote",
    // rust: "items=stick\nweight=2\nnbt.ExtraAttributes.id=ASPECT_OF_THE_END",
    // rust: ),
    // rust: (
    // rust: "not_hyp",
    // rust: "items=stick\nweight=1\ncomponent.custom_data.ExtraAttributes.id=!HYP",
    // rust: ),
    // rust: ("unnamed", "items=stick\nnbt.display.Name=exists:false"),
    // rust: ]);
    // rust: let data = |id: &str| {
    // rust: let attributes =
    // rust: Tag::compound([("ExtraAttributes", Tag::compound([("id", string(id))]))]);
    // rust: with("stick", "custom_data", attributes)
}
    // rust: assert_eq!(item(&cit, data("ASPECT_OF_THE_END")), Some("aote"));
    // rust: assert_eq!(item(&cit, data("MIDAS")), Some("not_hyp"));
    // rust: assert_eq!(item(&cit, data("HYP")), Some("unnamed"));
    // rust: let mut named = data("HYP");
    // rust: named.data_mut().custom_name = Some(string("Hyperion"));
    // rust: assert_eq!(item(&cit, named), None);
}

pub fn legacy_enchantment_lists_and_model_data() void {
}
    // rust: let cit = rules(&[
    // rust: (
    // rust: "sharp",
    // rust: "items=stick\nnbt.Enchantments.*.id=minecraft:sharpness\nnbt.Enchantments.0.lvl=5",
    // rust: ),
    // rust: ("cmd", "items=stone\nnbt.CustomModelData=3"),
    // rust: (
    // rust: "cmd_snbt",
    // rust: "items=dirt\ncomponents.custom_model_data={floats:[3.0f]}",
    // rust: ),
    // rust: ]);
    // rust: assert_eq!(
    // rust: item(&cit, enchanted("stick", &[("sharpness", 5)])),
    // rust: Some("sharp")
    // rust: );
    // rust: assert_eq!(item(&cit, enchanted("stick", &[("sharpness", 4)])), None);
    // rust: let model = |id: &str, f: f32| {
    // rust: let floats = Tag::List(vec![Tag::Float(f.to_bits()), Tag::Float(7f32.to_bits())]);
    // rust: with(id, "custom_model_data", Tag::compound([("floats", floats)]))
}
    // rust: assert_eq!(item(&cit, model("stone", 3.0)), Some("cmd"));
    // rust: assert_eq!(item(&cit, model("stone", 3.5)), None);
    // rust: assert_eq!(item(&cit, model("dirt", 3.0)), Some("cmd_snbt"));
    // rust: assert_eq!(item(&cit, model("dirt", 2.0)), None);
}

pub fn fields_left_out_at_zero_read_as_zero() void {
}
    // rust: let cit = rules(&[("zero", "items=firework_rocket\nnbt.Fireworks.Flight=0")]);
    // rust: let mut rocket = new("firework_rocket");
    // rust: rocket.data_mut().fireworks = Some((0, Vec::new()));
    // rust: assert_eq!(item(&cit, rocket.clone()), Some("zero"));
    // rust: rocket.data_mut().fireworks = Some((2, Vec::new()));
    // rust: assert_eq!(item(&cit, rocket), None);
}

pub fn damage_counts_only_for_damageable_items() void {
}
    // rust: let cit = rules(&[
    // rust: ("worn", "items=diamond_sword\ndamage=50-100%"),
    // rust: ("new", "items=stick\ndamage=0"),
    // rust: ]);
    // rust: let damaged = |id: &str, damage: u32, max: u32| {
    // rust: let mut stack = new(id);
    // rust: stack.damage = damage;
    // rust: stem(&cit, cit.select(Kind::Item, &stack, Hand::Main, max))
}
        // Half of 1561 is 780.5.
    // rust: assert_eq!(damaged("diamond_sword", 780, 1561), None);
    // rust: assert_eq!(damaged("diamond_sword", 781, 1561), Some("worn"));
    // rust: assert_eq!(damaged("stick", 5, 0), Some("new"));
}

pub fn enchantment_levels_and_rules_for_any_item() void {
}
    // rust: let cit = rules(&[
    // rust: (
    // rust: "sharp3",
    // rust: "items=stick\nenchantments=sharpness\nenchantmentLevels=3-",
    // rust: ),
    // rust: ("any3", "items=stone\nenchantmentLevels=3-"),
    // rust: ("glint", "type=enchantment\nenchantments=sharpness"),
    // rust: (
    // rust: "sword_glint",
    // rust: "type=enchantment\nitems=diamond_sword\nweight=2",
    // rust: ),
    // rust: ]);
    // rust: let mixed = [("sharpness", 2), ("unbreaking", 3)];
    // rust: assert_eq!(item(&cit, enchanted("stick", &mixed)), None);
    // rust: assert_eq!(
    // rust: item(&cit, enchanted("stick", &[("sharpness", 4)])),
    // rust: Some("sharp3")
    // rust: );
    // rust: assert_eq!(item(&cit, enchanted("stone", &mixed)), Some("any3"));
    // rust: let glints = |stack: ItemStack| -> Vec<&str> {
    // rust: let found = cit.enchantments(&stack, Hand::Main, 0).into_iter();
    // rust: found.map(|i| stem(&cit, Some(i)).unwrap()).collect()
}
    // rust: let sharp = [("sharpness", 1)];
    // rust: assert_eq!(
    // rust: glints(enchanted("diamond_sword", &sharp)),
    // rust: ["sword_glint", "glint"]
    // rust: );
    // rust: assert_eq!(glints(enchanted("stick", &sharp)), ["glint"]);
    // rust: assert!(glints(new("stick")).is_empty());
        // Glints are never an item's texture.
    // rust: assert_eq!(item(&cit, enchanted("diamond_sword", &sharp)), None);
}

    /// `CitRules::glint` in the main hand, with the stack's own `has_foil` as callers pass it.
pub fn glint(cit: *CitRules, stack: *ItemStack, item_glint: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cit.glint(stack, Hand::Main, 0, stack.has_foil(item_glint))
}

    /// `stack` with its `enchantment_glint_override` set to `on`.
pub fn overridden(mut stack: ItemStack, on: bool) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let flag = (
    // rust: "minecraft:enchantment_glint_override".to_owned(),
    // rust: Tag::Byte(on.into()),
    // rust: );
    // rust: stack.data_mut().other.push(flag);
    // rust: stack
}

pub fn a_stack_glint_reads_the_book_and_the_pack_file() void {
}
    // rust: let mut cit = rules(&[
    // rust: ("sharp", "type=enchantment\nenchantments=sharpness"),
    // rust: (
    // rust: "keep",
    // rust: "type=enchantment\nlayer=1\nuseGlint=true\nenchantments=mending",
    // rust: ),
    // rust: ]);
        // An enchanted book's glint follows its stored enchantments.
    // rust: let mut book = new("enchanted_book");
    // rust: book.data_mut().stored_enchantments = vec![
    // rust: (Arc::from("minecraft:sharpness"), 3),
    // rust: (Arc::from("minecraft:mending"), 1),
    // rust: ];
    // rust: let book = glint(&cit, &book, true).unwrap();
    // rust: let weights: Vec<_> = book.layers.iter().map(|l| l.weight).collect();
    // rust: assert_eq!(weights, [0.75, 0.25]);
    // rust: assert!(book.vanilla);
    // rust: let plain = glint(&cit, &enchanted("stick", &[("sharpness", 1)]), false).unwrap();
    // rust: assert_eq!(plain.layers.len(), 1);
    // rust: assert!(!plain.vanilla);
        // No enchantment rules: nothing changes, unless the pack turns vanilla's glint off.
    // rust: let mut bare = rules(&[("stick", "items=stick")]);
    // rust: assert!(glint(&bare, &overridden(new("stick"), true), false).is_none());
    // rust: bare.global.use_glint = false;
    // rust: assert!(
    // rust: !glint(&bare, &overridden(new("stick"), true), false)
    // rust: .unwrap()
    // rust: .vanilla
    // rust: );
    // rust: cit.global.use_glint = false;
    // rust: assert!(
    // rust: glint(&cit, &overridden(new("stick"), true), false)
    // rust: .unwrap()
    // rust: .is_empty()
    // rust: );
}

pub fn only_a_stack_with_a_glint_gets_layers() void {
}
    // rust: let cit = rules(&[("any", "type=enchantment")]);
    // rust: assert!(glint(&cit, &new("stick"), false).is_none());
        // The override turns an enchanted stack's glint off, and an unenchanted one's on.
    // rust: let off = overridden(enchanted("stick", &[("sharpness", 1)]), false);
    // rust: assert!(glint(&cit, &off, false).is_none());
    // rust: let on = glint(&cit, &overridden(new("stick"), true), false).unwrap();
    // rust: let weights: Vec<_> = on.layers.iter().map(|l| l.weight).collect();
    // rust: assert_eq!(
    // rust: weights,
    // rust: [1.0],
    // rust: "nothing to share: the rule at full strength"
    // rust: );
        // The same stack, asked again without its glint, is not answered from the cache.
    // rust: assert!(
    // rust: cit.glint(&overridden(new("stick"), true), Hand::Main, 0, false)
    // rust: .is_none()
    // rust: );
}

pub fn a_rule_left_out_of_the_glints_matches_nothing() void {
}
    // rust: let mut cit = rules(&[
    // rust: ("broken", "type=enchantment\nitems=diamond_sword\nweight=1"),
    // rust: ("shown", "type=enchantment"),
    // rust: ]);
    // rust: let sword = enchanted("diamond_sword", &[("sharpness", 1)]);
    // rust: let layers = |cit: &CitRules| -> Vec<String> {
    // rust: let glint = glint(cit, &sword, false).unwrap();
    // rust: let stems = glint
    // rust: .layers
    // rust: .iter()
    // rust: .map(|l| stem(cit, Some(l.rule)).unwrap());
    // rust: stems.map(str::to_owned).collect()
}
        // The heavier rule wins the layer, until its texture is missing.
    // rust: assert_eq!(layers(&cit), ["broken"]);
    // rust: let broken = (0..cit.rules.len())
    // rust: .find(|&i| stem(&cit, Some(i)) == Some("broken"))
    // rust: .unwrap();
    // rust: cit.keep_glints(|i| i != broken);
    // rust: assert_eq!(layers(&cit), ["shown"]);
    // rust: assert_eq!(cit.enchantments(&sword, Hand::Main, 0).len(), 1);
        // None left: vanilla's glint stays.
    // rust: cit.keep_glints(|_| false);
    // rust: assert!(glint(&cit, &sword, false).is_none());
}

pub fn an_off_hand_layer_draws_only_in_the_off_hand() void {
}
    // rust: let cit = rules(&[
    // rust: ("left", "type=enchantment\nlayer=1\nhand=off"),
    // rust: ("both", "type=enchantment"),
    // rust: ]);
    // rust: let sword = enchanted("diamond_sword", &[("sharpness", 1)]);
    // rust: let layers = |hand| -> Vec<&str> {
    // rust: let glint = cit.glint(&sword, hand, 0, true).unwrap();
    // rust: glint
    // rust: .layers
    // rust: .iter()
    // rust: .map(|l| stem(&cit, Some(l.rule)).unwrap())
    // rust: .collect()
}
    // rust: assert_eq!(layers(Hand::Off), ["both", "left"]);
        // Asked in this order, a cache keyed without the hand would answer as for the off hand.
    // rust: assert_eq!(layers(Hand::Main), ["both"]);
}
}
