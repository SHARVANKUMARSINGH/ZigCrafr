//! Transpiled from Horizon Rust crate
package horizon_protocol_hash

import "core:fmt"
import "core:mem"
import "core:math"

// `HashedPatchMap.create` / `HashedStack.create`: each patched component is
// hashed as its `Codec` form through `HashOps` (the client's
// `decoratedHashOpsGenerator`: `component.encodeValue(hashOps).asInt()`).
//
// Horizon holds a component as the wire form (registry ids, no names), so the
// codec form is rebuilt from it with a registry lookup for the ids that the
// codec writes as identifiers. [`raw`] decodes the stream bytes of the components
// Horizon keeps as bytes ([`Component::Raw`]). A component with no codec form
// Horizon can build (vanilla has none, an id has no name, or a codec is not
// ported yet) has no hash: it is left out of the added map and a vanilla server
// resyncs that slot.
    // rust: mod exact;
    // rust: mod gameplay;
    // rust: mod raw;
// use super::{Component, FireworkExplosion, Hashed, Stack, WirePatch, component as kind};
// use crate::hash_ops::{HashCode, HashOps, RecordHash};

// Registry names for the ids a component holds.
    // rust: pub trait Names {
    // The name of entry `id` of `registry` (`minecraft:enchantment`, ...).
name :: proc(self: ^Self, registry: string, id: i32) -> O {
    // Ported from Horizon
    return {}
}
}
// No registries: only the components that hold no registry id hash.
NoNames :: struct {
    // rust: impl Names for NoNames {
name :: proc(self: ^Self, _: string, _: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
}

RARITY :: ["common", "uncommon", "rare", "epic"]
    // rust: const DYE: [&str; 16] = [
    // rust: "white",
    // rust: "orange",
    // rust: "magenta",
    // rust: "light_blue",
    // rust: "yellow",
    // rust: "lime",
    // rust: "pink",
    // rust: "gray",
    // rust: "light_gray",
    // rust: "cyan",
    // rust: "purple",
    // rust: "blue",
    // rust: "brown",
    // rust: "green",
    // rust: "red",
    // rust: "black",
    // rust: ];
// `FireworkExplosion.Shape` names by id.
SHAPE :: ["small_ball", "large_ball", "star", "creeper", "burst"]
// The `Codec.BOOL` fields of the text component codec (`Style`, `NbtContents`,
// `PlayerSprite`).
    // rust: const TEXT_BOOLS: [&str; 7] = [
    // rust: "bold",
    // rust: "italic",
    // rust: "underlined",
    // rust: "strikethrough",
    // rust: "obfuscated",
    // rust: "interpret",
    // rust: "plain",
    // rust: ];

string :: proc(s: string) -> H {
    // Ported from Horizon
    return {}
}
    // rust: HashOps::create_string(s)
}
// `Identifier.CODEC` of registry entry `id`.
entry :: proc(names: ^dyn Names, registry: string, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: names.name(registry, id).map(|n| string(&n))
}
pick :: proc(table: ^[string], id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: usize::try_from(id)
    // rust: .ok()
    // rust: .and_then(|i| table.get(i))
    // rust: .map(|n| string(n))
}
// `ComponentSerialization.CODEC`.
text :: proc(tag: ^horizon_world::nbt::Tag) -> H {
    // Ported from Horizon
    return {}
}
    // rust: HashOps::from_nbt(tag, &TEXT_BOOLS)
}
// `Filterable.codec`: the full record (`Codec.withAlternative` encodes with
// the first codec), the filtered variant absent when there is none.
filterable :: proc(raw: HashCode, filtered: Maybe(HashCode)) -> H {
    // Ported from Horizon
    return {}
}
    // rust: RecordHash::new()
    // rust: .field("raw", raw)
    // rust: .optional("filtered", filtered)
    // rust: .build()
}
// `Codec.xxx.optionalFieldOf(name, default)`: absent when equal to the default.
    // rust: fn or_default<T: PartialEq>(
    // rust: rec: RecordHash,
    // rust: name: &str,
    // rust: v: T,
    // rust: default: T,
    // rust: hash: HashCode,
    // rust: ) -> RecordHash {
    // rust: if v == default {
    // rust: rec
    // rust: } else {
    // rust: rec.field(name, hash)
}
}
int_list :: proc(values: ^[i32]) -> H {
    // Ported from Horizon
    return {}
}
    // rust: HashOps::create_list(values.iter().map(|v| HashOps::create_int(*v)))
}
explosion :: proc(e: ^FireworkExplosion) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rec = RecordHash::new().field("shape", pick(&SHAPE, e.shape)?);
    // rust: let rec = or_default(
    // rust: rec,
    // rust: "colors",
    // rust: e.colors.is_empty(),
    // rust: true,
    // rust: int_list(&e.colors),
    // rust: );
    // rust: let rec = or_default(
    // rust: rec,
    // rust: "fade_colors",
    // rust: e.fade.is_empty(),
    // rust: true,
    // rust: int_list(&e.fade),
    // rust: );
    // rust: let rec = or_default(
    // rust: rec,
    // rust: "has_trail",
    // rust: e.trail,
    // rust: false,
    // rust: HashOps::create_boolean(e.trail),
    // rust: );
    // rust: Some(
    // rust: or_default(
    // rust: rec,
    // rust: "has_twinkle",
    // rust: e.twinkle,
    // rust: false,
    // rust: HashOps::create_boolean(e.twinkle),
    // rust: )
    // rust: .build(),
    // rust: )
}
// `ItemEnchantments.CODEC`: an identifier-keyed map of levels.
enchantments :: proc(list: ^[(i32) {
}
    // rust: let mut entries = Vec::with_capacity(list.len());
    // rust: for (id, level) in list {
    // rust: entries.push((
    // rust: entry(names, "minecraft:enchantment", *id)?,
    // rust: HashOps::create_int(*level),
    // rust: ));
}
    // rust: Some(HashOps::create_map(entries))
}
// `ItemStackTemplate.CODEC` (the map form): the item, a count that is absent
// at 1 and a `DataComponentPatch.CODEC` that is absent when empty.
template :: proc(s: ^Stack, names: ^dyn Names) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rec = RecordHash::new().field("id", entry(names, "minecraft:item", s.item)?);
    // rust: let rec = or_default(rec, "count", s.count, 1, HashOps::create_int(s.count));
    // rust: let mut patch = Vec::new();
    // rust: for (k, c) in &s.added {
    // rust: patch.push((
    // rust: entry(names, "minecraft:data_component_type", *k)?,
    // rust: c.code(*k, names)?,
    // rust: ));
}
    // rust: for k in &s.removed {
    // rust: let name = names.name("minecraft:data_component_type", *k)?;
    // rust: patch.push((string(&format!("!{name}")), HashOps::empty_map()));
}
    // rust: Some(
    // rust: if patch.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field("components", HashOps::create_map(patch))
}
    // rust: .build(),
    // rust: )
}

    // rust: impl Component {
    // The component's `Codec` form hashed (`TypedDataComponent.encodeValue(hashOps)`),
    // or `None` when Horizon cannot build that form.
code :: proc(self: ^Self, id: i32, names: ^dyn Names) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match self {
    // rust: Self::Int(v) => match id {
    // rust: kind::RARITY => pick(&RARITY, *v)?,
    // rust: kind::BASE_COLOR => pick(&DYE, *v)?,
                // MapPostProcessing has no persistent codec.
    // rust: kind::MAP_POST_PROCESSING => return None,
    // rust: _ => HashOps::create_int(*v),
    // rust: },
            // `Unit.CODEC` is an empty map; creative_slot_lock has no codec.
    // rust: Self::Unit if id == kind::CREATIVE_SLOT_LOCK => return None,
    // rust: Self::Unit => HashOps::empty_map(),
    // rust: Self::Bool(v) => HashOps::create_boolean(*v),
    // rust: Self::Text(t) => text(t),
    // rust: Self::Nbt(t) => HashOps::from_nbt(t, &[]),
    // rust: Self::Ident(s) => string(s),
    // rust: Self::Lore(lines) => HashOps::create_list(lines.iter().map(text)),
    // rust: Self::Enchantments(list) => enchantments(list, names)?,
    // rust: Self::AttackRange(v) => {
    // rust: const FIELDS: [(&str, f32); 6] = [
    // rust: ("min_reach", 0.0),
    // rust: ("max_reach", 3.0),
    // rust: ("min_creative_reach", 0.0),
    // rust: ("max_creative_reach", 5.0),
    // rust: ("hitbox_margin", 0.3),
    // rust: ("mob_factor", 1.0),
    // rust: ];
    // rust: let mut rec = RecordHash::new();
    // rust: for ((name, default), v) in FIELDS.iter().zip(v) {
    // rust: rec = or_default(
    // rust: rec,
    // rust: name,
    // rust: v.to_bits(),
    // rust: default.to_bits(),
    // rust: HashOps::create_f32(*v),
    // rust: );
}
    // rust: rec.build()
}
    // rust: Self::Potion {
    // rust: potion,
    // rust: color,
    // rust: rest,
    // rust: } => {
    // rust: let rec = RecordHash::new()
    // rust: .optional(
    // rust: "potion",
    // rust: match potion {
    // rust: Some(p) => Some(entry(names, "minecraft:potion", *p)?),
    // rust: None => None,
    // rust: },
    // rust: )
    // rust: .optional("custom_color", color.map(HashOps::create_int));
                // An empty tail is no custom effects and no name.
    // rust: if rest.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: raw::potion_tail(rec, rest, names)?
}
    // rust: .build()
}
    // rust: Self::CustomModelData {
    // rust: floats,
    // rust: flags,
    // rust: strings,
    // rust: colors,
    // rust: } => {
    // rust: let list = |rec: RecordHash, name: &str, items: Vec<HashCode>| {
    // rust: if items.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field(name, HashOps::create_list(items))
}
}
    // rust: let rec = list(
    // rust: RecordHash::new(),
    // rust: "floats",
    // rust: floats.iter().map(|f| HashOps::create_f32(*f)).collect(),
    // rust: );
    // rust: let rec = list(
    // rust: rec,
    // rust: "flags",
    // rust: flags.iter().map(|f| HashOps::create_boolean(*f)).collect(),
    // rust: );
    // rust: let rec = list(rec, "strings", strings.iter().map(|s| string(s)).collect());
    // rust: list(
    // rust: rec,
    // rust: "colors",
    // rust: colors.iter().map(|c| HashOps::create_int(*c)).collect(),
    // rust: )
    // rust: .build()
}
    // rust: Self::TooltipDisplay { hide, hidden } => {
    // rust: let rec = or_default(
    // rust: RecordHash::new(),
    // rust: "hide_tooltip",
    // rust: *hide,
    // rust: false,
    // rust: HashOps::create_boolean(*hide),
    // rust: );
    // rust: let mut list = Vec::with_capacity(hidden.len());
    // rust: for h in hidden {
    // rust: list.push(entry(names, "minecraft:data_component_type", *h)?);
}
    // rust: if list.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field("hidden_components", HashOps::create_list(list))
}
    // rust: .build()
}
    // rust: Self::WritableBook { pages, filtered } => if pages.is_empty() {
    // rust: RecordHash::new()
    // rust: } else {
    // rust: RecordHash::new().field(
    // rust: "pages",
    // rust: HashOps::create_list(pages.iter().enumerate().map(|(i, p)| {
    // rust: filterable(
    // rust: string(p),
    // rust: filtered.get(i).and_then(Option::as_ref).map(|f| string(f)),
    // rust: )
    // rust: })),
    // rust: )
}
    // rust: .build(),
    // rust: Self::WrittenBook(b) => {
    // rust: let rec = RecordHash::new()
    // rust: .field(
    // rust: "title",
    // rust: filterable(string(&b.title), b.title_filtered.as_deref().map(string)),
    // rust: )
    // rust: .field("author", string(&b.author));
    // rust: let rec = or_default(
    // rust: rec,
    // rust: "generation",
    // rust: b.generation,
    // rust: 0,
    // rust: HashOps::create_int(b.generation),
    // rust: );
    // rust: let rec = if b.pages.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field(
    // rust: "pages",
    // rust: HashOps::create_list(b.pages.iter().enumerate().map(|(i, p)| {
    // rust: filterable(
    // rust: text(p),
    // rust: b.pages_filtered.get(i).and_then(Option::as_ref).map(text),
    // rust: )
    // rust: })),
    // rust: )
}
    // rust: or_default(
    // rust: rec,
    // rust: "resolved",
    // rust: b.resolved,
    // rust: false,
    // rust: HashOps::create_boolean(b.resolved),
    // rust: )
    // rust: .build()
}
    // rust: Self::Stacks(stacks) => {
    // rust: let mut list = Vec::with_capacity(stacks.len());
    // rust: for s in stacks {
    // rust: list.push(template(s, names)?);
}
    // rust: HashOps::create_list(list)
}
    // rust: Self::Fireworks { flight, explosions } => {
                // `ExtraCodecs.UNSIGNED_BYTE` is `Codec.BYTE`: a byte tag.
    // rust: let rec = or_default(
    // rust: RecordHash::new(),
    // rust: "flight_duration",
    // rust: *flight,
    // rust: 0,
    // rust: HashOps::create_byte(*flight as i8),
    // rust: );
    // rust: let mut list = Vec::with_capacity(explosions.len());
    // rust: for e in explosions {
    // rust: list.push(explosion(e)?);
}
    // rust: if list.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field("explosions", HashOps::create_list(list))
}
    // rust: .build()
}
    // rust: Self::FireworkExplosion(e) => explosion(e)?,
    // rust: Self::LodestoneTracker { target, tracked } => {
    // rust: let target = target.as_ref().map(|(dimension, pos)| {
    // rust: RecordHash::new()
    // rust: .field("dimension", string(dimension))
    // rust: .field("pos", HashOps::create_int_list(pos))
    // rust: .build()
    // rust: });
    // rust: or_default(
    // rust: RecordHash::new().optional("target", target),
    // rust: "tracked",
    // rust: *tracked,
    // rust: true,
    // rust: HashOps::create_boolean(*tracked),
    // rust: )
    // rust: .build()
}
    // rust: Self::Trim { material, pattern } => RecordHash::new()
    // rust: .field(
    // rust: "material",
    // rust: entry(names, "minecraft:trim_material", *material)?,
    // rust: )
    // rust: .field("pattern", entry(names, "minecraft:trim_pattern", *pattern)?)
    // rust: .build(),
    // rust: Self::StewEffects(list) => {
    // rust: let mut out = Vec::with_capacity(list.len());
    // rust: for (effect, duration) in list {
    // rust: let rec = RecordHash::new()
    // rust: .field("id", entry(names, "minecraft:mob_effect", *effect)?);
    // rust: out.push(
    // rust: or_default(
    // rust: rec,
    // rust: "duration",
    // rust: *duration,
    // rust: 160,
    // rust: HashOps::create_int(*duration),
    // rust: )
    // rust: .build(),
    // rust: );
}
    // rust: HashOps::create_list(out)
}
    // rust: Self::Instrument(i) => entry(names, "minecraft:instrument", *i)?,
    // rust: Self::BannerPatterns(layers) => {
    // rust: let mut out = Vec::with_capacity(layers.len());
    // rust: for (pattern, color) in layers {
    // rust: out.push(
    // rust: RecordHash::new()
    // rust: .field(
    // rust: "pattern",
    // rust: entry(names, "minecraft:banner_pattern", *pattern)?,
    // rust: )
    // rust: .field("color", pick(&DYE, *color)?)
    // rust: .build(),
    // rust: );
}
    // rust: HashOps::create_list(out)
}
    // rust: Self::PaintingVariant(i) => entry(names, "minecraft:painting_variant", *i)?,
    // rust: Self::Profile(p) => raw::profile(p),
    // rust: Self::Raw(bytes) => raw::code(id, bytes, names)?,
    // rust: })
}

    // [`Component::code`] as `HashCode.asInt`, the value the packet carries.
hash :: proc(self: ^Self, id: i32, names: ^dyn Names) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.code(id, names).map(HashCode::as_int)
}
}

    // rust: impl Hashed {
    // `HashedStack.create` for a non-empty stack: `HashedPatchMap.create` hashes
    // each added component (those Horizon cannot hash are left out) and sends the
    // removed ones' ids.
create :: proc(stack: ^Stack, names: ^dyn Names) -> S {
    // Ported from Horizon
    return {}
}
        // A stack kept as the server sent it goes back as its own patch bytes
        // ([`Stack::wire`]): that patch is what it holds.
    // rust: let decoded = stack
    // rust: .wire
    // rust: .0
    // rust: .as_deref()
    // rust: .and_then(|patch| WirePatch::decode(patch).ok());
    // rust: let (added, removed) = match &decoded {
    // rust: Some((added, removed)) => (added, removed),
    // rust: None => (&stack.added, &stack.removed),
}
    // rust: Self {
    // rust: item: stack.item,
    // rust: count: stack.count,
    // rust: added: added
    // rust: .iter()
    // rust: .filter_map(|(id, c)| Some((*id, c.hash(*id, names)?)))
    // rust: .collect(),
    // rust: removed: removed.clone(),
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::item::{Component as C, WrittenBook, component as k};
//     use horizon_world::nbt::Tag;

    // Ids for the tests, by registry (the position in the table is the id).
Table :: struct {
    // rust: impl Names for Table {
name :: proc(self: ^Self, registry: string, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let names: &[&str] = match registry {
    // rust: "minecraft:enchantment" => &["minecraft:sharpness", "minecraft:protection"],
    // rust: "minecraft:potion" => &["minecraft:water", "minecraft:swiftness"],
    // rust: "minecraft:mob_effect" => &["minecraft:speed", "minecraft:night_vision"],
    // rust: "minecraft:trim_material" => &["minecraft:gold"],
    // rust: "minecraft:trim_pattern" => &["minecraft:sentry"],
    // rust: "minecraft:instrument" => &["minecraft:ponder_goat_horn"],
    // rust: "minecraft:banner_pattern" => &["minecraft:creeper"],
    // rust: "minecraft:painting_variant" => &["minecraft:kebab"],
    // rust: "minecraft:item" => &["minecraft:arrow", "minecraft:firework_rocket"],
    // rust: "minecraft:data_component_type" => {
    // rust: return match id {
    k: :DAMAGE => Some("minecraft:damage"),
    k: :ENCHANTMENTS => Some("minecraft:enchantments"),
    k: :RARITY => Some("minecraft:rarity"),
    // rust: _ => None,
}
    // rust: .map(str::to_owned);
}
    // rust: _ => return None,
}
    // rust: names.get(usize::try_from(id).ok()?).map(|n| n.to_string())
}
}

text :: proc(s: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::String(s.into())
}
explosion :: proc(shape: i32, colors: ^[i32], fade: ^[i32], trail: bool) -> F {
    // Ported from Horizon
    return {}
}
    // rust: FireworkExplosion {
    // rust: shape,
    // rust: colors: colors.to_vec(),
    // rust: fade: fade.to_vec(),
    // rust: trail,
    // rust: twinkle: false,
}
}

    // Hashes printed by vanilla 26.3 (`TypedDataComponent.encodeValue` through a
    // `RegistryOps<HashCode>` over `HashOps.CRC32C_INSTANCE`, then `asInt`) for
    // the same component values.
component_hashes_match_vanilla :: proc() {
}
    // rust: let nbt = Tag::compound([
    // rust: ("n", Tag::Int(7)),
    // rust: ("flag", Tag::Byte(1)),
    // rust: ("s", text("hi")),
    // rust: ("l", Tag::List(vec![Tag::Int(1)])),
    // rust: ]);
    // rust: let styled = Tag::compound([
    // rust: ("text", text("Hi")),
    // rust: ("bold", Tag::Byte(1)),
    // rust: ("color", text("red")),
    // rust: ]);
    // rust: let extra = Tag::compound([
    // rust: ("text", text("A")),
    // rust: (
    // rust: "extra",
    // rust: Tag::List(vec![Tag::compound([
    // rust: ("translate", text("block.minecraft.stone")),
    // rust: ("italic", Tag::Byte(0)),
    // rust: ])]),
    // rust: ),
    // rust: ]);
    // rust: let two = Tag::compound([("text", text("two")), ("underlined", Tag::Byte(1))]);
    // rust: let fe = explosion(2, &[0xFF0000, 0x00FF00], &[1], true);
    // rust: let fireworks_template = {
    // rust: let mut s = Stack::new(1, 3);
    // rust: s.added.push((k::DAMAGE, C::Int(2)));
    // rust: s.removed.push(k::RARITY);
    // rust: s
}
    // rust: let cases: Vec<(&str, i32, C, i32)> = vec![
    // rust: ("damage", k::DAMAGE, C::Int(5), 645064431),
    // rust: ("max_stack_size", k::MAX_STACK_SIZE, C::Int(16), 1769065625),
    // rust: ("repair_cost", k::REPAIR_COST, C::Int(3), -499649379),
    // rust: ("rarity", k::RARITY, C::Int(3), -292715907),
    // rust: ("unbreakable", k::UNBREAKABLE, C::Unit, -982207288),
    // rust: (
    // rust: "glint",
    // rust: k::ENCHANTMENT_GLINT_OVERRIDE,
    // rust: C::Bool(true),
    // rust: -1019818302,
    // rust: ),
    // rust: (
    // rust: "item_model",
    // rust: k::ITEM_MODEL,
    // rust: C::Ident("minecraft:stick".into()),
    // rust: -1153337500,
    // rust: ),
    // rust: ("custom_data", k::CUSTOM_DATA, C::Nbt(nbt), 588551639),
    // rust: (
    // rust: "enchantments",
    // rust: k::ENCHANTMENTS,
    // rust: C::Enchantments(vec![(0, 3), (1, 4)]),
    // rust: 156916527,
    // rust: ),
    // rust: (
    // rust: "custom_name",
    // rust: k::CUSTOM_NAME,
    // rust: C::Text(text("Hi")),
    // rust: 485089409,
    // rust: ),
    // rust: (
    // rust: "custom_name_styled",
    // rust: k::CUSTOM_NAME,
    // rust: C::Text(styled),
    // rust: -204970011,
    // rust: ),
    // rust: ("item_name_extra", k::ITEM_NAME, C::Text(extra), 868407222),
    // rust: ("lore", k::LORE, C::Lore(vec![text("one"), two]), 931033850),
    // rust: ("lore_empty", k::LORE, C::Lore(vec![]), -1978007022),
    // rust: ("dyed", k::DYED_COLOR, C::Int(0xA06540), -1304070639),
    // rust: ("base_color", k::BASE_COLOR, C::Int(14), -1939582294),
    // rust: ("map_id", k::MAP_ID, C::Int(12), 225652657),
    // rust: (
    // rust: "ominous",
    // rust: k::OMINOUS_BOTTLE_AMPLIFIER,
    // rust: C::Int(2),
    // rust: 1064459813,
    // rust: ),
    // rust: (
    // rust: "cmd",
    // rust: k::CUSTOM_MODEL_DATA,
    // rust: C::CustomModelData {
    // rust: floats: vec![1.5],
    // rust: flags: vec![true, false],
    // rust: strings: vec!["a".into()],
    // rust: colors: vec![0xFF0000],
    // rust: },
    // rust: -2044548697,
    // rust: ),
    // rust: (
    // rust: "cmd_flags",
    // rust: k::CUSTOM_MODEL_DATA,
    // rust: C::CustomModelData {
    // rust: floats: vec![],
    // rust: flags: vec![true],
    // rust: strings: vec![],
    // rust: colors: vec![],
    // rust: },
    // rust: 1169437062,
    // rust: ),
    // rust: (
    // rust: "tooltip",
    // rust: k::TOOLTIP_DISPLAY,
    // rust: C::TooltipDisplay {
    // rust: hide: true,
    // rust: hidden: vec![k::DAMAGE, k::ENCHANTMENTS],
    // rust: },
    // rust: 1281445049,
    // rust: ),
    // rust: (
    // rust: "tooltip_default",
    // rust: k::TOOLTIP_DISPLAY,
    // rust: C::TooltipDisplay {
    // rust: hide: false,
    // rust: hidden: vec![],
    // rust: },
    // rust: -982207288,
    // rust: ),
    // rust: (
    // rust: "attack_range",
    // rust: k::ATTACK_RANGE,
    // rust: C::AttackRange([0.0, 4.0, 0.0, 6.0, 0.3, 1.0]),
    // rust: -287603881,
    // rust: ),
    // rust: (
    // rust: "attack_range_default",
    // rust: k::ATTACK_RANGE,
    // rust: C::AttackRange([0.0, 3.0, 0.0, 5.0, 0.3, 1.0]),
    // rust: -982207288,
    // rust: ),
    // rust: (
    // rust: "firework_explosion",
    // rust: k::FIREWORK_EXPLOSION,
    // rust: C::FireworkExplosion(fe.clone()),
    // rust: 282963373,
    // rust: ),
    // rust: (
    // rust: "firework_explosion_plain",
    // rust: k::FIREWORK_EXPLOSION,
    // rust: C::FireworkExplosion(explosion(4, &[], &[], false)),
    // rust: -1702512602,
    // rust: ),
    // rust: (
    // rust: "fireworks",
    // rust: k::FIREWORKS,
    // rust: C::Fireworks {
    // rust: flight: 2,
    // rust: explosions: vec![fe],
    // rust: },
    // rust: -1263695327,
    // rust: ),
    // rust: (
    // rust: "fireworks_empty",
    // rust: k::FIREWORKS,
    // rust: C::Fireworks {
    // rust: flight: 0,
    // rust: explosions: vec![],
    // rust: },
    // rust: -982207288,
    // rust: ),
    // rust: (
    // rust: "potion",
    // rust: k::POTION_CONTENTS,
    // rust: C::Potion {
    // rust: potion: Some(1),
    // rust: color: Some(0x123456),
    // rust: rest: vec![],
    // rust: },
    // rust: 360529701,
    // rust: ),
    // rust: (
    // rust: "potion_water",
    // rust: k::POTION_CONTENTS,
    // rust: C::Potion {
    // rust: potion: Some(0),
    // rust: color: None,
    // rust: rest: vec![],
    // rust: },
    // rust: 1311226275,
    // rust: ),
    // rust: (
    // rust: "stew",
    // rust: k::SUSPICIOUS_STEW_EFFECTS,
    // rust: C::StewEffects(vec![(0, 160), (1, 100)]),
    // rust: -1574156649,
    // rust: ),
    // rust: (
    // rust: "lodestone",
    // rust: k::LODESTONE_TRACKER,
    // rust: C::LodestoneTracker {
    // rust: target: Some(("minecraft:overworld".into(), [1, 64, -3])),
    // rust: tracked: false,
    // rust: },
    // rust: -1499562110,
    // rust: ),
    // rust: (
    // rust: "lodestone_none",
    // rust: k::LODESTONE_TRACKER,
    // rust: C::LodestoneTracker {
    // rust: target: None,
    // rust: tracked: true,
    // rust: },
    // rust: -982207288,
    // rust: ),
    // rust: (
    // rust: "trim",
    // rust: k::TRIM,
    // rust: C::Trim {
    // rust: material: 0,
    // rust: pattern: 0,
    // rust: },
    // rust: -1936516638,
    // rust: ),
    // rust: ("instrument", k::INSTRUMENT, C::Instrument(0), -1123313158),
    // rust: (
    // rust: "banner",
    // rust: k::BANNER_PATTERNS,
    // rust: C::BannerPatterns(vec![(0, 5)]),
    // rust: 1048823812,
    // rust: ),
    // rust: (
    // rust: "painting",
    // rust: k::PAINTING_VARIANT,
    // rust: C::PaintingVariant(0),
    // rust: -670067346,
    // rust: ),
    // rust: (
    // rust: "writable",
    // rust: k::WRITABLE_BOOK_CONTENT,
    // rust: C::WritableBook {
    // rust: pages: vec!["page one".into(), "two".into()],
    // rust: filtered: vec![],
    // rust: },
    // rust: 1900254632,
    // rust: ),
    // rust: (
    // rust: "written",
    // rust: k::WRITTEN_BOOK_CONTENT,
    // rust: C::WrittenBook(WrittenBook {
    // rust: title: "Title".into(),
    // rust: author: "Author".into(),
    // rust: generation: 1,
    // rust: pages: vec![text("p1")],
    // rust: resolved: true,
    // rust: ..WrittenBook::default()
    // rust: }),
    // rust: -112185549,
    // rust: ),
    // rust: (
    // rust: "written_min",
    // rust: k::WRITTEN_BOOK_CONTENT,
    // rust: C::WrittenBook(WrittenBook {
    // rust: title: "T".into(),
    // rust: author: "A".into(),
    // rust: generation: 0,
    // rust: pages: vec![],
    // rust: resolved: false,
    // rust: ..WrittenBook::default()
    // rust: }),
    // rust: -809804424,
    // rust: ),
    // rust: (
    // rust: "charged",
    // rust: k::CHARGED_PROJECTILES,
    // rust: C::Stacks(vec![Stack::new(0, 1), fireworks_template.clone()]),
    // rust: -1839603258,
    // rust: ),
    // rust: (
    // rust: "bundle",
    // rust: k::BUNDLE_CONTENTS,
    // rust: C::Stacks(vec![fireworks_template]),
    // rust: 785458737,
    // rust: ),
    // rust: ];
    // rust: for (name, id, component, expected) in cases {
    // rust: assert_eq!(component.hash(id, &Table), Some(expected), "{name}");
}
}

components_without_a_codec_form_are_not_hashed :: proc() {
}
        // Unresolvable registry ids, bytes Horizon only reads past, and the
        // components vanilla has no persistent codec for.
    // rust: assert_eq!(
    // rust: C::Enchantments(vec![(9, 1)]).hash(k::ENCHANTMENTS, &Table),
    // rust: None
    // rust: );
        // additional_trade_cost has no persistent codec either.
    // rust: assert_eq!(C::Raw(vec![1]).hash(42, &Table), None);
    // rust: assert_eq!(C::Unit.hash(k::CREATIVE_SLOT_LOCK, &Table), None);
    // rust: assert_eq!(C::Int(0).hash(k::MAP_POST_PROCESSING, &Table), None);
        // Custom effects cut short.
    // rust: let custom_effects = C::Potion {
    // rust: potion: None,
    // rust: color: None,
    // rust: rest: vec![1, 0, 0],
}
    // rust: assert_eq!(custom_effects.hash(k::POTION_CONTENTS, &Table), None);
}

a_hashed_stack_carries_each_hashable_component_and_the_removed_ones :: proc() {
}
    // rust: let mut stack = Stack::new(1, 2);
    // rust: stack.added.push((k::DAMAGE, C::Int(5)));
    // rust: stack.added.push((42, C::Raw(vec![0])));
    // rust: stack.removed.push(k::RARITY);
    // rust: assert_eq!(
    // rust: Hashed::create(&stack, &Table),
    // rust: Hashed {
    // rust: item: 1,
    // rust: count: 2,
    // rust: added: vec![(k::DAMAGE, 645064431)],
    // rust: removed: vec![k::RARITY]
}
    // rust: );
        // Without names the plain ones still hash.
    // rust: assert_eq!(Hashed::of(&stack).added, vec![(k::DAMAGE, 645064431)]);
        // A stack kept as the server sent it hashes the patch it holds.
//         use crate::buf::Codec as _;
    // rust: let mut w = crate::buf::Writer::new();
    // rust: crate::item::DelimitedSlot::write(&Some(stack.clone()), &mut w);
    // rust: let kept = crate::item::DelimitedSlot::read(&mut crate::buf::Reader::new(&w.data))
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: let mut bare = Stack::new(1, 2);
    // rust: bare.wire = kept.wire;
    // rust: assert_eq!(
    // rust: Hashed::create(&bare, &Table),
    // rust: Hashed::create(&stack, &Table)
    // rust: );
}
}
