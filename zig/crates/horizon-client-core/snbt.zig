//! Transpiled from Horizon Rust crate
//! Module: horizon-client-core_snbt
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Tag text output: `StringTagVisitor` (compact SNBT) and
//! `TextComponentTagVisitor` (the coloured form commands print), plus Java's
//! number formatting.
// use crate::text::{self, Style, Text};
// use horizon_world::nbt::Tag;
// use horizon_world::snbt_text::string_of;
    // rust: pub use horizon_world::snbt_text::{java_double, java_float, quote_and_escape, to_snbt};

// ---- the coloured form -----------------------------------------------------

/// Writer provenance for a live moving-piston command read, or its selected subtree.
pub const PistonPart = enum {
    Entity,
    State,
    Properties,
};

pub const Pretty = struct {
    indentation: []const u8,
    result: Text,
    indent_depth: usize,
    depth: usize,
    piston: ?PistonPart,
};
pub fn is_numeric(t: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: t,
    // rust: Tag::Byte(_) | Tag::Short(_) | Tag::Int(_) | Tag::Long(_) | Tag::Float(_) | Tag::Double(_)
    // rust: )
}
    // rust: impl Pretty {
pub fn lit(self: *Self, s: []const u8, color: ?u32) void {
}
    // rust: let t = match color {
    // rust: Some(c) => Text::styled(s, Style::color(c)),
    // rust: None => Text::literal(s),
}
    // rust: self.result.push(t);
}
pub fn number(self: *Self, s: []const u8, suffix: []const u8) void {
}
    // rust: self.lit(s, Some(text::GOLD));
    // rust: if !suffix.is_empty() {
    // rust: self.lit(suffix, Some(text::RED));
}
}
pub fn quoted(self: *Self, input: []const u8, color: u32) void {
}
    // rust: let q = quote_and_escape(input);
    // rust: let (open, inner) = (&q[..1], &q[1..q.len() - 1]);
    // rust: self.lit(open, None);
    // rust: self.lit(inner, Some(color));
    // rust: self.lit(open, None);
}
    // rust: fn array<T: std::fmt::Display>(&mut self, prefix: &str, items: &[T], suffix: &str) {
    // rust: self.lit("[", None);
    // rust: self.lit(prefix, Some(text::RED));
    // rust: self.lit(";", None);
    // rust: for (i, v) in items.iter().enumerate().take(128) {
    // rust: self.lit(" ", None);
    // rust: self.number(&v.to_string(), suffix);
    // rust: if i != items.len() - 1 {
    // rust: self.lit(",", None);
}
}
    // rust: if items.len() > 128 {
    // rust: self.lit("<...>", Some(text::GRAY));
}
    // rust: self.lit("]", None);
}
pub fn sub(self: *Self, tag: *Tag, indent: bool) void {
}
    // rust: self.sub_with(tag, indent, None);
}
pub fn sub_with(self: *Self, tag: *Tag, indent: bool, piston: ?PistonPart) void {
}
    // rust: let previous = std::mem::replace(&mut self.piston, piston);
    // rust: if indent {
    // rust: self.indent_depth += 1;
}
    // rust: self.depth += 1;
    // rust: self.visit(tag);
    // rust: if indent {
    // rust: self.indent_depth -= 1;
}
    // rust: self.depth -= 1;
    // rust: self.piston = previous;
}
pub fn visit(self: *Self, tag: *Tag) void {
}
    // rust: match tag {
    // rust: Tag::End => {}
    // rust: Tag::Byte(v) => self.number(&v.to_string(), "b"),
    // rust: Tag::Short(v) => self.number(&v.to_string(), "s"),
    // rust: Tag::Int(v) => self.number(&v.to_string(), ""),
    // rust: Tag::Long(v) => self.number(&v.to_string(), "L"),
    // rust: Tag::Float(v) => self.number(&java_float(f32::from_bits(*v)), "f"),
    // rust: Tag::Double(v) => self.number(&java_double(f64::from_bits(*v)), "d"),
    // rust: Tag::String(s) => self.quoted(&string_of(s), text::GREEN),
    // rust: Tag::ByteArray(a) => {
    // rust: let v: Vec<i8> = a.iter().map(|b| *b as i8).collect();
    // rust: self.array("B", &v, "b");
}
    // rust: Tag::IntArray(a) => self.array("I", a, ""),
    // rust: Tag::LongArray(a) => self.array("L", a, "L"),
    // rust: Tag::List(l) => self.list(l),
    // rust: Tag::Compound(c) => self.compound(c),
}
}
pub fn list(self: *Self, l: *[Tag]) void {
}
    // rust: if l.is_empty() {
    // rust: self.lit("[", None);
    // rust: self.lit("]", None);
    // rust: } else if self.depth >= 64 {
    // rust: self.lit("[", None);
    // rust: self.lit("<...>", Some(text::GRAY));
    // rust: self.lit("]", None);
    // rust: } else if l.len() >= 8 || l.iter().all(is_numeric) {
    // rust: self.lit("[", None);
    // rust: for (i, t) in l.iter().enumerate() {
    // rust: if i != 0 {
    // rust: self.lit(",", None);
    // rust: self.lit(" ", None);
}
    // rust: self.sub(t, false);
}
    // rust: self.lit("]", None);
    // rust: } else {
    // rust: self.lit("[", None);
    // rust: if !self.indentation.is_empty() {
    // rust: self.lit("\n", None);
}
    // rust: let entry = self.indentation.repeat(self.indent_depth + 1);
    // rust: let spacing = if self.indentation.is_empty() {
    // rust: " "
    // rust: } else {
    // rust: "\n"
}
    // rust: for (i, t) in l.iter().enumerate().take(128) {
    // rust: self.lit(&entry, None);
    // rust: self.sub(t, true);
    // rust: if i != l.len() - 1 {
    // rust: self.lit(",", None);
    // rust: self.lit(spacing, None);
}
}
    // rust: if l.len() > 128 {
    // rust: self.lit(&entry, None);
    // rust: self.lit("<...>", Some(text::GRAY));
}
    // rust: if !self.indentation.is_empty() {
    // rust: self.lit("\n", None);
    // rust: let close = self.indentation.repeat(self.indent_depth);
    // rust: self.lit(&close, None);
}
    // rust: self.lit("]", None);
}
}
pub fn compound(self: *Self, c: *horizon_world::nbt::Compound) void {
}
    // rust: if c.is_empty() {
    // rust: self.lit("{", None);
    // rust: self.lit("}", None);
    // rust: } else if self.depth >= 64 {
    // rust: self.lit("{", None);
    // rust: self.lit("<...>", Some(text::GRAY));
    // rust: self.lit("}", None);
    // rust: } else {
    // rust: self.lit("{", None);
    // rust: if !self.indentation.is_empty() {
    // rust: self.lit("\n", None);
}
    // rust: let entry = self.indentation.repeat(self.indent_depth + 1);
    // rust: let spacing = if self.indentation.is_empty() {
    // rust: " "
    // rust: } else {
    // rust: "\n"
}
    // rust: let n = c.len();
    // rust: let entries = match self.piston {
    // rust: Some(part) => piston_hash_order(c, part),
    // rust: None => java_hash_order(c),
}
    // rust: for (i, (k, v)) in entries.into_iter().enumerate() {
    // rust: self.lit(&entry, None);
    // rust: let key = string_of(k);
    // rust: if !key.is_empty()
    // rust: && key
    // rust: .chars()
    // rust: .all(|ch| ch.is_ascii_alphanumeric() || matches!(ch, '.' | '_' | '+' | '-'))
    // rust: {
    // rust: self.lit(&key, Some(text::AQUA));
    // rust: } else {
    // rust: self.quoted(&key, text::AQUA);
}
    // rust: self.lit(":", None);
    // rust: self.lit(" ", None);
    // rust: let child = match (self.piston, key.as_str()) {
    // rust: (Some(PistonPart::Entity), "blockState") => Some(PistonPart::State),
    // rust: (Some(PistonPart::State), "properties") => Some(PistonPart::Properties),
    // rust: _ => None,
}
    // rust: self.sub_with(v, true, child);
    // rust: if i + 1 < n {
    // rust: self.lit(",", None);
    // rust: self.lit(spacing, None);
}
}
    // rust: if !self.indentation.is_empty() {
    // rust: self.lit("\n", None);
    // rust: let close = self.indentation.repeat(self.indent_depth);
    // rust: self.lit(&close, None);
}
    // rust: self.lit("}", None);
}
}
}
pub fn hash_bucket(len: usize, key: *horizon_world::nbt::JavaString) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut capacity = 16usize;
    // rust: while len > capacity * 3 / 4 {
    // rust: capacity *= 2;
}
    // rust: let h = string_of(key)
    // rust: .encode_utf16()
    // rust: .fold(0u32, |h, ch| h.wrapping_mul(31).wrapping_add(u32::from(ch)));
    // rust: ((h ^ (h >> 16)) as usize) & (capacity - 1)
}
    // rust: fn piston_hash_order(
    // rust: c: &horizon_world::nbt::Compound,
    // rust: part: PistonPart,
    // rust: ) -> Vec<(&horizon_world::nbt::JavaString, &Tag)> {
    // rust: let mut entries: Vec<_> = c.iter().collect();
    // rust: match part {
    // rust: PistonPart::Entity => {
            // saveAdditional, then the base's components and saveMetadata.
    // rust: let fields = [
    // rust: "blockState",
    // rust: "facing",
    // rust: "progress",
    // rust: "extending",
    // rust: "source",
    // rust: "components",
    // rust: "id",
    // rust: "x",
    // rust: "y",
    // rust: "z",
    // rust: ];
    // rust: entries.sort_by_key(|(k, _)| {
    // rust: (
    // rust: hash_bucket(c.len(), k),
    // rust: fields
    // rust: .iter()
    // rust: .position(|s| *s == string_of(k))
    // rust: .unwrap_or(fields.len()),
    // rust: )
    // rust: });
}
    // rust: PistonPart::Properties => {
            // StateDefinition builds property codecs in sorted-name order.
            // DFU's nested map-pair encoder writes the second codec first.
    // rust: entries.sort_by_key(|(k, _)| (hash_bucket(c.len(), k), std::cmp::Reverse(*k)));
}
    // rust: PistonPart::State => return java_hash_order(c),
}
    // rust: entries
}
/// The iteration order of the `HashMap<String, Tag>` a `CompoundTag` holds,
/// for a map that grew to its size by insertion: buckets by
/// `HashMap.hash(String.hashCode())`, keys sharing a bucket in key order.
    // rust: pub fn java_hash_order(
    // rust: c: &horizon_world::nbt::Compound,
    // rust: ) -> Vec<(&horizon_world::nbt::JavaString, &Tag)> {
    // Keys sharing a bucket iterate in insertion order: the order vanilla's
    // savers write them, as far as it is known here.
    // rust: const WRITE_ORDER: &[&str] = &[
        // ItemStack.CODEC.
    // rust: "id",
    // rust: "count",
    // rust: "components",
        // Entity.saveWithoutId.
    // rust: "Pos",
    // rust: "Motion",
    // rust: "Rotation",
    // rust: "fall_distance",
    // rust: "Fire",
    // rust: "Air",
    // rust: "OnGround",
    // rust: "Invulnerable",
    // rust: "PortalCooldown",
    // rust: "UUID",
    // rust: "CustomName",
    // rust: "CustomNameVisible",
    // rust: "Silent",
    // rust: "NoGravity",
    // rust: "Glowing",
    // rust: "TicksFrozen",
    // rust: "HasVisualFire",
    // rust: "Tags",
    // rust: "data",
    // rust: "Passengers",
        // LivingEntity.addAdditionalSaveData.
    // rust: "Health",
    // rust: "HurtTime",
    // rust: "DeathTime",
    // rust: "AbsorptionAmount",
    // rust: "current_impulse_context_reset_grace_time",
    // rust: "current_explosion_impact_pos",
    // rust: "attributes",
    // rust: "active_effects",
    // rust: "FallFlying",
    // rust: "sleeping_pos",
    // rust: "Brain",
    // rust: "equipment",
        // ArmorStand.
    // rust: "Invisible",
    // rust: "Small",
    // rust: "ShowArms",
    // rust: "DisabledSlots",
    // rust: "NoBasePlate",
    // rust: "Marker",
    // rust: "Pose",
    // rust: ];
    // BlockEntity.saveMetadata writes the position after the entity's data.
pub const AFTER: *[[]const u8] = &["x", "y", "z"];
    // rust: let rank = |k: &horizon_world::nbt::JavaString| {
    // rust: let k = string_of(k);
    // rust: WRITE_ORDER
    // rust: .iter()
    // rust: .position(|w| *w == k)
    // rust: .or_else(|| {
    // rust: AFTER
    // rust: .iter()
    // rust: .position(|w| *w == k)
    // rust: .map(|i| WRITE_ORDER.len() + 1 + i)
    // rust: })
    // rust: .unwrap_or(WRITE_ORDER.len())
}
    // rust: let mut entries: Vec<_> = c.iter().collect();
    // rust: entries.sort_by_key(|(k, _)| (hash_bucket(c.len(), k), rank(k)));
    // rust: entries
}
/// `NbtUtils.toPrettyComponent`: the coloured, unindented form.
pub fn pretty(tag: *Tag) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: pretty_indented(tag, "")
}
pub fn pretty_indented(tag: *Tag, indentation: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = Pretty {
    // rust: indentation: indentation.to_owned(),
    // rust: result: Text::empty(),
    // rust: indent_depth: 0,
    // rust: depth: 0,
    // rust: piston: None,
}
    // rust: p.visit(tag);
    // rust: p.result
}
/// Command-only writer order; ordinary pretty printing keeps its existing policy.
pub fn pretty_piston(tag: *Tag, part: PistonPart) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = Pretty {
    // rust: indentation: String::new(),
    // rust: result: Text::empty(),
    // rust: indent_depth: 0,
    // rust: depth: 0,
    // rust: piston: Some(part),
}
    // rust: p.visit(tag);
    // rust: p.result
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::parse_snbt;

pub fn rt(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: to_snbt(&parse_snbt(s).unwrap().0)
}
pub fn live_piston_writer_order_does_not_change_default_pretty() void {
}
    // rust: let tag = parse_snbt(
    // rust: r#"{id:"minecraft:piston",blockState:{id:"minecraft:piston_head",properties:{facing:"east",short:"false",type:"normal"}},components:{},x:1,y:100,z:0,facing:5b,progress:0.0f,source:1b,extending:1b}"#,
    // rust: ).unwrap().0;
    // rust: let ordinary = r#"{blockState: {id: "minecraft:piston_head", properties: {facing: "east", short: "false", type: "normal"}}, components: {}, x: 1, facing: 5b, progress: 0.0f, y: 100, z: 0, id: "minecraft:piston", source: 1b, extending: 1b}"#;
    // rust: assert_eq!(pretty(&tag).plain(), ordinary);
    // rust: assert_eq!(
    // rust: pretty_piston(&tag, PistonPart::Entity).plain(),
    // rust: r#"{blockState: {id: "minecraft:piston_head", properties: {short: "false", facing: "east", type: "normal"}}, components: {}, x: 1, facing: 5b, progress: 0.0f, y: 100, z: 0, source: 1b, id: "minecraft:piston", extending: 1b}"#,
    // rust: );
    // rust: let state = tag.get("blockState").unwrap();
    // rust: assert_eq!(
    // rust: pretty_piston(state, PistonPart::State).plain(),
    // rust: r#"{id: "minecraft:piston_head", properties: {short: "false", facing: "east", type: "normal"}}"#,
    // rust: );
    // rust: let props = state.get("properties").unwrap();
    // rust: assert_eq!(
    // rust: pretty_piston(props, PistonPart::Properties).plain(),
    // rust: r#"{short: "false", facing: "east", type: "normal"}"#,
    // rust: );
    // rust: assert_eq!(
    // rust: pretty(props).plain(),
    // rust: r#"{facing: "east", short: "false", type: "normal"}"#
    // rust: );
    // rust: assert_eq!(pretty(&tag).plain(), ordinary);
}
pub fn compact_form_matches_vanilla() void {
}
    // rust: assert_eq!(
    // rust: rt("{b:1b,a:\"x\",c:[1,2],d:1.5f,e:2d,f:3L,g:4s}"),
    // rust: "{a:\"x\",b:1b,c:[1,2],d:1.5f,e:2.0d,f:3L,g:4s}"
    // rust: );
    // rust: assert_eq!(rt("{\"a b\":1}"), "{\"a b\":1}");
    // rust: assert_eq!(rt("{true:1}"), "{\"true\":1}");
    // rust: assert_eq!(rt("[B;1b,2b]"), "[B;1B,2B]");
    // rust: assert_eq!(rt("[I;1,2]"), "[I;1,2]");
    // rust: assert_eq!(rt("[L;1L]"), "[L;1L]");
    // rust: assert_eq!(quote_and_escape("say \"hi\""), "'say \"hi\"'");
    // rust: assert_eq!(quote_and_escape("it's \"x\""), "\"it's \\\"x\\\"\"");
    // rust: assert_eq!(quote_and_escape("a\nb\\"), "\"a\\nb\\\\\"");
}
pub fn java_number_text() void {
}
    // rust: assert_eq!(java_double(1.0), "1.0");
    // rust: assert_eq!(java_double(0.1), "0.1");
    // rust: assert_eq!(java_double(1.0e7), "1.0E7");
    // rust: assert_eq!(java_double(12345678.9), "1.23456789E7");
    // rust: assert_eq!(java_double(0.0001), "1.0E-4");
    // rust: assert_eq!(java_double(-3.5), "-3.5");
    // rust: assert_eq!(java_float(0.3), "0.3");
    // rust: assert_eq!(java_float(100.0), "100.0");
    // rust: assert_eq!(java_double(f64::NAN), "NaN");
}
pub fn pretty_form_is_coloured_without_changing_text() void {
}
    // rust: let tag = parse_snbt("{Pos:[1.5d,2.0d],id:\"minecraft:pig\",n:3b}")
    // rust: .unwrap()
    // rust: .0;
    // rust: let t = pretty(&tag);
    // rust: assert_eq!(
    // rust: t.plain(),
    // rust: "{Pos: [1.5d, 2.0d], id: \"minecraft:pig\", n: 3b}"
    // rust: );
        // keys aqua, strings green, numbers gold.
    // rust: let colors: Vec<_> = t.spans.iter().filter_map(|s| s.style.color).collect();
    // rust: assert!(colors.contains(&text::AQUA));
    // rust: assert!(colors.contains(&text::GREEN));
    // rust: assert!(colors.contains(&text::GOLD));
    // rust: let long = parse_snbt("{l:[{a:1},{b:2}]}").unwrap().0;
    // rust: assert_eq!(pretty(&long).plain(), "{l: [{a: 1}, {b: 2}]}");
}
}
