//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_raw
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The components Horizon keeps as their stream bytes ([`Component::Raw`]),
//! decoded into the `Codec` form that vanilla's `HashOps` sees. Each function
//! reads exactly what the component's `STREAM_CODEC` writes (the readers in
//! `item/skip.rs` step over the same bytes) and builds what its `CODEC`
//! encodes: a component without a `networkSynchronized` stream codec goes as
//! its codec's NBT, so that NBT converts to hashes as it is (`NbtOps.convertTo`).
// use super::*;
// use crate::buf::{Codec, Reader};
// use crate::item::{Profile, Template};
// use horizon_world::nbt::Tag;

/// `DyeColor` names by id.
pub fn dye(id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: pick(&DYE, id)
}
/// The `StringRepresentable` names of an enum whose stream codec is an `idMapper`
/// of the ids `0..`.
pub fn named(table: *[[]const u8], r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: pick(table, r.varint().ok()?)
}
/// `ByteBufCodecs.holderRegistry`: the registry id itself; the codec writes the
/// entry's identifier.
pub fn registry_entry(registry: []const u8, names: *dyn Names, r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: entry(names, registry, r.varint().ok()?)
}
pub fn float(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(HashOps::create_f32(r.f32().ok()?))
}
pub fn int(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(HashOps::create_int(r.varint().ok()?))
}
/// A one-field record `{name: VAR_INT}`.
pub fn int_record(name: []const u8, r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(RecordHash::new().field(name, int(r)?).build())
}

pub const FOX: [[]const u8; 2] = ["red", "snow"];
pub const SALMON: [[]const u8; 3] = ["small", "medium", "large"];
pub const PARROT: [[]const u8; 5] = ["red_blue", "blue", "green", "yellow_blue", "gray"];
pub const MOOSHROOM: [[]const u8; 2] = ["red", "brown"];
    // rust: const HORSE: [&str; 7] = [
    // rust: "white",
    // rust: "creamy",
    // rust: "chestnut",
    // rust: "brown",
    // rust: "black",
    // rust: "gray",
    // rust: "dark_brown",
    // rust: ];
pub const LLAMA: [[]const u8; 4] = ["creamy", "white", "brown", "gray"];
pub const AXOLOTL: [[]const u8; 5] = ["lucy", "wild", "gold", "cyan", "blue"];
pub const RABBIT: [[]const u8; 6] = ["brown", "white", "black", "white_splotched", "gold", "salt"];
/// `TropicalFish.Pattern` by packed id (`base | index << 8`).
    // rust: const TROPICAL: [(i32, &str); 12] = [
    // rust: (0, "kob"),
    // rust: (256, "sunstreak"),
    // rust: (512, "snooper"),
    // rust: (768, "dasher"),
    // rust: (1024, "brinely"),
    // rust: (1280, "spotty"),
    // rust: (1, "flopper"),
    // rust: (257, "stripey"),
    // rust: (513, "glitter"),
    // rust: (769, "blockfish"),
    // rust: (1025, "betty"),
    // rust: (1281, "clayfish"),
    // rust: ];

/// `TypedEntityData.codec`: the NBT with the type's identifier as `id`.
pub fn typed_data(registry: []const u8, names: *dyn Names, r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = registry_entry(registry, names, r)?;
    // rust: let Tag::Compound(mut tag) = r.nbt().ok()? else {
    // rust: return None;
}
    // `stripId` leaves the data without its own id; the codec writes the type's.
    // rust: tag.remove(&"id".into());
    // rust: Some(typed_with_id(id, &tag))
}
pub fn typed_with_id(id: HashCode, tag: *horizon_world::nbt::Compound) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries: Vec<(HashCode, HashCode)> = tag
    // rust: .iter()
    // rust: .map(|(k, v)| {
    // rust: (
    // rust: HashOps::create_string_units(&k.0),
    // rust: HashOps::from_nbt(v, &[]),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: entries.push((string("id"), id));
    // rust: HashOps::create_map(entries)
}
/// A list written as a count and its elements, hashed as a list.
    // rust: fn list(
    // rust: r: &mut Reader,
    // rust: mut element: impl FnMut(&mut Reader) -> Option<HashCode>,
    // rust: ) -> Option<HashCode> {
    // rust: let n = r.count(r.remaining()).ok()?;
    // rust: let mut out = Vec::with_capacity(n);
    // rust: for _ in 0..n {
    // rust: out.push(element(r)?);
}
    // rust: Some(HashOps::create_list(out))
}
    // rust: fn optional(
    // rust: r: &mut Reader,
    // rust: element: impl FnOnce(&mut Reader) -> Option<HashCode>,
    // rust: ) -> Option<Option<HashCode>> {
    // rust: if r.bool().ok()? {
    // rust: Some(Some(element(r)?))
    // rust: } else {
    // rust: Some(None)
}
}
    // rust: pub(super) fn template_code(r: &mut Reader, names: &dyn Names) -> Option<HashCode> {
    // rust: let stack = <Template as Codec<Stack>>::read(r).ok()?;
    // rust: template(&stack, names)
}
/// `ByteBufCodecs.fixedSizeList(4)` of text components.
pub fn four_texts(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tags: Vec<Tag> = (0..4).map(|_| r.nbt().ok()).collect::<Option<_>>()?;
    // rust: let code = HashOps::create_list(tags.iter().map(text));
    // rust: Some((tags, code))
}

/// `MobEffectInstance.Details.MAP_CODEC` (the fields of a record, flattened into
/// `rec`) from `STREAM_CODEC`: amplifier, duration, ambient, show_particles,
/// show_icon, then the hidden effect's details.
pub fn effect_details(rec: RecordHash, r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let amplifier = r.varint().ok()?;
    // rust: let duration = r.varint().ok()?;
    // rust: let ambient = r.bool().ok()?;
    // rust: let particles = r.bool().ok()?;
    // rust: let icon = r.bool().ok()?;
    // `ExtraCodecs.UNSIGNED_BYTE` is a byte tag.
    // rust: let rec = or_default(
    // rust: rec,
    // rust: "amplifier",
    // rust: amplifier,
    // rust: 0,
    // rust: HashOps::create_byte(amplifier as i8),
    // rust: );
    // rust: let rec = or_default(rec, "duration", duration, 0, HashOps::create_int(duration));
    // rust: let rec = or_default(
    // rust: rec,
    // rust: "ambient",
    // rust: ambient,
    // rust: false,
    // rust: HashOps::create_boolean(ambient),
    // rust: );
    // rust: let rec = or_default(
    // rust: rec,
    // rust: "show_particles",
    // rust: particles,
    // rust: true,
    // rust: HashOps::create_boolean(particles),
    // rust: );
    // `show_icon` is always written.
    // rust: let rec = rec.field("show_icon", HashOps::create_boolean(icon));
    // rust: Some(if r.bool().ok()? {
    // rust: let hidden = effect_details(RecordHash::new(), r)?.build();
    // rust: rec.field("hidden_effect", hidden)
    // rust: } else {
    // rust: rec
    // rust: })
}
/// `MobEffectInstance.CODEC`: the effect's identifier and its details.
    // rust: pub(super) fn mob_effect(r: &mut Reader, names: &dyn Names) -> Option<HashCode> {
    // rust: let rec = RecordHash::new().field("id", registry_entry("minecraft:mob_effect", names, r)?);
    // rust: Some(effect_details(rec, r)?.build())
}

/// `PotionContents` after its potion and colour: the custom effects and name
/// (`custom_effects` is absent when empty).
    // rust: pub(super) fn potion_tail(rec: RecordHash, rest: &[u8], names: &dyn Names) -> Option<RecordHash> {
    // rust: let mut r = Reader::new(rest);
    // rust: let n = r.count(r.remaining()).ok()?;
    // rust: let mut effects = Vec::with_capacity(n);
    // rust: for _ in 0..n {
    // rust: effects.push(mob_effect(&mut r, names)?);
}
    // rust: let name = if r.bool().ok()? {
    // rust: Some(string(&r.string(32767).ok()?))
    // rust: } else {
    // rust: None
}
    // rust: (r.remaining() == 0).then_some(())?;
    // rust: let rec = if effects.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field("custom_effects", HashOps::create_list(effects))
}
    // rust: Some(rec.optional("custom_name", name))
}

/// `ResolvableProfile.CODEC` (`FULL_CODEC`): the game profile's or the partial's
/// fields, then the skin patch's. Both forms write `id`, `name` and a
/// `properties` list that is absent when empty.
    // rust: pub(super) fn profile(p: &Profile) -> HashCode {
    // rust: let rec = RecordHash::new()
    // rust: .optional("name", p.name.as_deref().map(string))
    // rust: .optional(
    // rust: "id",
            // `UUIDUtil.CODEC`: an int array.
    // rust: p.id.map(|id| {
    // rust: HashOps::create_int_list(&[
    // rust: (id >> 96) as i32,
    // rust: (id >> 64) as i32,
    // rust: (id >> 32) as i32,
    // rust: id as i32,
    // rust: ])
    // rust: }),
    // rust: );
    // rust: let rec = if p.properties.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field(
    // rust: "properties",
    // rust: HashOps::create_list(p.properties.iter().map(|(name, value, signature)| {
    // rust: RecordHash::new()
    // rust: .field("name", string(name))
    // rust: .field("value", string(value))
    // rust: .optional("signature", signature.as_deref().map(string))
    // rust: .build()
    // rust: })),
    // rust: )
}
    // rust: rec.optional("texture", p.skin.body.as_deref().map(string))
    // rust: .optional("cape", p.skin.cape.as_deref().map(string))
    // rust: .optional("elytra", p.skin.elytra.as_deref().map(string))
    // rust: .optional(
    // rust: "model",
    // rust: p.skin
    // rust: .slim
    // rust: .map(|slim| string(if slim { "slim" } else { "wide" })),
    // rust: )
    // rust: .build()
}

/// `ByteBufCodecs.holder(key, direct)` as `RegistryCodecs.holder(key, directCodec)`
/// writes it: a reference by identifier, a direct value as its record.
    // rust: fn holder_or(
    // rust: registry: &str,
    // rust: names: &dyn Names,
    // rust: r: &mut Reader,
    // rust: direct: impl FnOnce(&mut Reader) -> Option<HashCode>,
    // rust: ) -> Option<HashCode> {
    // rust: match r.varint().ok()? {
    // rust: 0 => direct(r),
    // rust: id => entry(names, registry, id - 1),
}
}
/// `TrimMaterial.DIRECT_CODEC`.
    // rust: pub(super) fn trim_material(r: &mut Reader) -> Option<HashCode> {
    // rust: let palette = string(&r.string(32767).ok()?);
    // rust: let description = text(&r.nbt().ok()?);
    // rust: Some(
    // rust: RecordHash::new()
    // rust: .field("palette_id", palette)
    // rust: .field("description", description)
    // rust: .build(),
    // rust: )
}
/// `TrimPattern.DIRECT_CODEC` (`decal` is always written).
pub fn trim_pattern(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let asset = string(&r.string(32767).ok()?);
    // rust: let description = text(&r.nbt().ok()?);
    // rust: let decal = r.bool().ok()?;
    // rust: Some(
    // rust: RecordHash::new()
    // rust: .field("asset_id", asset)
    // rust: .field("description", description)
    // rust: .field("decal", HashOps::create_boolean(decal))
    // rust: .build(),
    // rust: )
}
/// `Instrument.DIRECT_CODEC`.
pub fn instrument(r: *mut Reader, names: *dyn Names) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sound = super::gameplay::sound(r, names)?.code;
    // rust: let (duration, range) = (r.f32().ok()?, r.f32().ok()?);
    // rust: let damage = r.varint().ok()?;
    // rust: let description = text(&r.nbt().ok()?);
    // rust: let rec = RecordHash::new()
    // rust: .field("sound_event", sound)
    // rust: .field("use_duration", HashOps::create_f32(duration))
    // rust: .field("range", HashOps::create_f32(range));
    // rust: Some(
    // rust: or_default(
    // rust: rec,
    // rust: "durability_damage",
    // rust: damage,
    // rust: 0,
    // rust: HashOps::create_int(damage),
    // rust: )
    // rust: .field("description", description)
    // rust: .build(),
    // rust: )
}
/// `BannerPattern.DIRECT_CODEC`.
pub fn banner_pattern(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let asset = string(&r.string(32767).ok()?);
    // rust: let key = string(&r.string(32767).ok()?);
    // rust: Some(
    // rust: RecordHash::new()
    // rust: .field("asset_id", asset)
    // rust: .field("translation_key", key)
    // rust: .build(),
    // rust: )
}

/// The hash of component `kind` from its stream bytes, or `None` when Horizon
/// has no codec form for it (no persistent codec in vanilla, a direct holder, an
/// id with no name, a component still to be ported).
    // rust: pub(super) fn code(kind: i32, bytes: &[u8], names: &dyn Names) -> Option<HashCode> {
    // rust: let mut r = Reader::new(bytes);
    // rust: let r = &mut r;
    // rust: let code = match kind {
        // `Unit.CODEC`: an empty map.
    // rust: 34 | 120 => HashOps::empty_map(),
        // Persistent codecs only: the stream form is the codec's NBT.
        // intangible_projectile, map_decorations, debug_stick_state, recipes,
        // lock (an `ItemPredicate`) and container_loot.
    // rust: 22 | 49 | 59 | 68 | 81 | 82 => HashOps::from_nbt(&r.nbt().ok()?, &[]),
        // `Codec.FLOAT`: minimum_attack_charge, potion_duration_scale.
    // rust: 7 | 54 => float(r)?,
        // `Identifier.CODEC`: tooltip_style, note_block_sound.
    // rust: 35 | 73 => string(&r.string(32767).ok()?),
        // `Enchantable`, `VillagerFood`.
    // rust: 31 => int_record("value", r)?,
    // rust: 44 => int_record("nutrition", r)?,
        // `DyeColor.CODEC`: dye, wolf/collar, tropical_fish/base_color and
        // pattern_color, cat/collar, sheep/color, shulker/color, cushion/color.
    // rust: 46 | 91 | 96 | 97 | 114 | 115 | 116 | 121 => dye(r.varint().ok()?)?,
    // rust: 8 => registry_entry("minecraft:damage_type", names, r)?,
    // rust: 43 => registry_entry("minecraft:block_transformer", names, r)?,
    // rust: 88 => registry_entry("minecraft:villager_type", names, r)?,
    // rust: 89 => registry_entry("minecraft:wolf_variant", names, r)?,
    // rust: 90 => registry_entry("minecraft:wolf_sound_variant", names, r)?,
    // rust: 100 => registry_entry("minecraft:pig_variant", names, r)?,
    // rust: 101 => registry_entry("minecraft:pig_sound_variant", names, r)?,
    // rust: 102 => registry_entry("minecraft:cow_variant", names, r)?,
    // rust: 103 => registry_entry("minecraft:cow_sound_variant", names, r)?,
    // rust: 104 => registry_entry("minecraft:chicken_variant", names, r)?,
    // rust: 105 => registry_entry("minecraft:chicken_sound_variant", names, r)?,
    // rust: 106 => registry_entry("minecraft:zombie_nautilus_variant", names, r)?,
    // rust: 107 => registry_entry("minecraft:frog_variant", names, r)?,
    // rust: 112 => registry_entry("minecraft:cat_variant", names, r)?,
    // rust: 113 => registry_entry("minecraft:cat_sound_variant", names, r)?,
    // rust: 117 => registry_entry("minecraft:decorated_pot_pattern", names, r)?,
        // The mob variants that are enums.
    // rust: 92 => named(&FOX, r)?,
    // rust: 93 => named(&SALMON, r)?,
    // rust: 94 => named(&PARROT, r)?,
    // rust: 95 => {
    // rust: let id = r.varint().ok()?;
    // rust: string(TROPICAL.iter().find(|(packed, _)| *packed == id)?.1)
}
    // rust: 98 => named(&MOOSHROOM, r)?,
    // rust: 99 => match r.varint().ok()? {
    // rust: 99 => string("evil"),
    // rust: id => pick(&RABBIT, id)?,
    // rust: },
    // rust: 108 => named(&HORSE, r)?,
    // rust: 110 => named(&LLAMA, r)?,
    // rust: 111 => named(&AXOLOTL, r)?,
        // `TypedEntityData` (entity_data, block_entity_data) and `CustomData`.
    // rust: 60 => typed_data("minecraft:entity_type", names, r)?,
    // rust: 62 => typed_data("minecraft:block_entity_type", names, r)?,
    // rust: 61 => HashOps::from_nbt(&r.nbt().ok()?, &[]),
        // `BlockItemStateProperties`: a string map.
    // rust: 78 => {
    // rust: let n = r.count(r.remaining()).ok()?;
    // rust: let mut entries = Vec::with_capacity(n);
    // rust: for _ in 0..n {
    // rust: let k = string(&r.string(32767).ok()?);
    // rust: entries.push((k, string(&r.string(32767).ok()?)));
}
    // rust: HashOps::create_map(entries)
}
        // `ArmorTrim`, `InstrumentComponent`, `provides_trim_material` and
        // `BannerPatternLayers` holders (a reference stays typed in Horizon but
        // a direct one comes here).
    // rust: 58 => {
    // rust: let material = holder_or("minecraft:trim_material", names, r, trim_material)?;
    // rust: let pattern = holder_or("minecraft:trim_pattern", names, r, trim_pattern)?;
    // rust: RecordHash::new()
    // rust: .field("material", material)
    // rust: .field("pattern", pattern)
    // rust: .build()
}
    // rust: 63 => holder_or("minecraft:instrument", names, r, |r| instrument(r, names))?,
    // rust: 64 => holder_or("minecraft:trim_material", names, r, trim_material)?,
    // rust: 74 => list(r, |r| {
    // rust: let pattern = holder_or("minecraft:banner_pattern", names, r, banner_pattern)?;
    // rust: let color = dye(r.varint().ok()?)?;
    // rust: Some(
    // rust: RecordHash::new()
    // rust: .field("pattern", pattern)
    // rust: .field("color", color)
    // rust: .build(),
    // rust: )
    // rust: })?,
        // `SulfurCubeContent`: one template.
    // rust: 80 => template_code(r, names)?,
        // `PotDecorations`: back, left, right, front.
    // rust: 76 => {
    // rust: let mut rec = RecordHash::new();
    // rust: for side in ["back", "left", "right", "front"] {
    // rust: rec = rec.optional(side, optional(r, |r| template_code(r, names))?);
}
    // rust: rec.build()
}
        // `ItemContainerContents`: the occupied slots as `{slot, item}`.
    // rust: 77 => {
    // rust: let n = r.count(256).ok()?;
    // rust: let mut slots = Vec::new();
    // rust: for slot in 0..n {
    // rust: if let Some(item) = optional(r, |r| template_code(r, names))? {
    // rust: slots.push(
    // rust: RecordHash::new()
    // rust: .field("slot", HashOps::create_int(slot as i32))
    // rust: .field("item", item)
    // rust: .build(),
    // rust: );
}
}
    // rust: HashOps::create_list(slots)
}
        // `Bees`: occupants.
    // rust: 79 => list(r, |r| {
    // rust: let data = typed_data("minecraft:entity_type", names, r)?;
    // rust: let ticks = r.varint().ok()?;
    // rust: let min = r.varint().ok()?;
    // rust: Some(
    // rust: RecordHash::new()
    // rust: .field("entity_data", data)
    // rust: .field("ticks_in_hive", HashOps::create_int(ticks))
    // rust: .field("min_ticks_in_hive", HashOps::create_int(min))
    // rust: .build(),
    // rust: )
    // rust: })?,
        // `SignText`: messages, the filtered ones when they differ, colour, glow.
    // rust: 118 | 119 => {
    // rust: let (messages, code) = four_texts(r)?;
            // `filteredMessagesForSerialization`: absent when equal to the messages.
    // rust: let filtered = if r.bool().ok()? {
    // rust: let (tags, code) = four_texts(r)?;
    // rust: (tags != messages).then_some(code)
    // rust: } else {
    // rust: None
}
    // rust: let color = dye(r.varint().ok()?)?;
    // rust: let glow = r.bool().ok()?;
    // rust: RecordHash::new()
    // rust: .field("messages", code)
    // rust: .optional("filtered_messages", filtered)
    // rust: .field("color", color)
    // rust: .field("has_glowing_text", HashOps::create_boolean(glow))
    // rust: .build()
}
    // rust: _ => super::gameplay::code(kind, r, names)?,
}
    // rust: (r.remaining() == 0).then_some(code)
}

    // rust: mod tests {
//     use super::*;
//     use crate::item::Component;

    /// The ids vanilla 26.3 gave the names the cases use.
pub const Pinned = struct {};
    // rust: impl Names for Pinned {
pub fn name(self: *Self, registry: []const u8, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = match (registry, id) {
    // rust: ("minecraft:item", 1) => "minecraft:stone",
    // rust: ("minecraft:item", 1009) => "minecraft:arrow",
    // rust: ("minecraft:item", 1060) => "minecraft:stick",
    // rust: ("minecraft:item", 1142) => "minecraft:brick",
    // rust: ("minecraft:mob_effect", 0) => "minecraft:speed",
    // rust: ("minecraft:mob_effect", 1) => "minecraft:slowness",
    // rust: ("minecraft:potion", 13) => "minecraft:swiftness",
    // rust: ("minecraft:entity_type", 11) => "minecraft:bee",
    // rust: ("minecraft:entity_type", 30) => "minecraft:cow",
    // rust: ("minecraft:block_entity_type", 1) => "minecraft:chest",
    // rust: ("minecraft:data_component_type", 1) => "minecraft:max_stack_size",
    // rust: ("minecraft:data_component_type", 2) => "minecraft:max_damage",
    // rust: ("minecraft:data_component_type", 3) => "minecraft:damage",
    // rust: ("minecraft:data_component_type", 12) => "minecraft:rarity",
    // rust: ("minecraft:villager_type", 0) => "minecraft:desert",
    // rust: ("minecraft:data_component_predicate_type", 0) => "minecraft:damage",
    // rust: ("minecraft:data_component_predicate_type", 1) => "minecraft:enchantments",
    // rust: ("minecraft:data_component_predicate_type", 2) => "minecraft:stored_enchantments",
    // rust: ("minecraft:data_component_predicate_type", 3) => "minecraft:potion_contents",
    // rust: ("minecraft:data_component_predicate_type", 4) => "minecraft:custom_data",
    // rust: ("minecraft:data_component_predicate_type", 5) => "minecraft:container",
    // rust: ("minecraft:data_component_predicate_type", 6) => "minecraft:bundle_contents",
    // rust: ("minecraft:data_component_predicate_type", 7) => "minecraft:firework_explosion",
    // rust: ("minecraft:data_component_predicate_type", 8) => "minecraft:fireworks",
    // rust: ("minecraft:data_component_predicate_type", 9) => "minecraft:writable_book_content",
    // rust: ("minecraft:data_component_predicate_type", 10) => "minecraft:written_book_content",
    // rust: ("minecraft:data_component_predicate_type", 11) => "minecraft:attribute_modifiers",
    // rust: ("minecraft:data_component_predicate_type", 12) => "minecraft:trim",
    // rust: ("minecraft:data_component_predicate_type", 13) => "minecraft:jukebox_playable",
    // rust: ("minecraft:data_component_predicate_type", 14) => "minecraft:villager/variant",
    // rust: ("minecraft:attribute", 1) => "minecraft:armor",
    // rust: ("minecraft:attribute", 3) => "minecraft:attack_damage",
    // rust: ("minecraft:attribute", 23) => "minecraft:max_health",
    // rust: ("minecraft:sound_event", 50) => "minecraft:block.anvil.land",
    // rust: ("minecraft:sound_event", 70) => "minecraft:item.armor.equip_generic",
    // rust: ("minecraft:sound_event", 71) => "minecraft:item.armor.equip_gold",
    // rust: ("minecraft:sound_event", 702) => "minecraft:entity.generic.eat",
    // rust: ("minecraft:sound_event", 1314) => "minecraft:entity.player.burp",
    // rust: ("minecraft:sound_event", 1447) => "minecraft:item.shears.snip",
    // rust: ("minecraft:sound_event", 1459) => "minecraft:item.shield.block",
    // rust: ("minecraft:mob_effect", 18) => "minecraft:poison",
    // rust: ("minecraft:block", 1) => "minecraft:stone",
    // rust: ("minecraft:block", 9) => "minecraft:dirt",
    // rust: ("minecraft:item", 1006) => "minecraft:bowl",
    // rust: ("minecraft:item", 1018) => "minecraft:iron_ingot",
    // rust: ("minecraft:entity_type", 32) => "minecraft:creeper",
    // rust: ("minecraft:entity_type", 101) => "minecraft:pig",
    // rust: ("minecraft:entity_type", 154) => "minecraft:zombie",
    // rust: _ => return None,
}
    // rust: Some(name.to_owned())
}
}

pub fn unhex(s: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..s.len() / 2)
    // rust: .map(|i| u8::from_str_radix(&s[i * 2..i * 2 + 2], 16).unwrap())
    // rust: .collect()
}

    /// The stream bytes and hashes vanilla 26.3 printed for components built from
    /// their codecs (`STREAM_CODEC.encode`, then `TypedDataComponent.encodeValue`
    /// through `HashOps.CRC32C_INSTANCE`).
pub fn components_read_past_hash_as_vanilla_does() void {
}
    // rust: let cases: [(&str, i32, &str, i32); 48] = [
    // rust: (
    // rust: "potion_contents",
    // rust: 53,
    // rust: "010d01000000ff020001c8010001000001000000010100010178",
    // rust: 568571899,
    // rust: ),
    // rust: ("potion_contents", 53, "0000010000000100000000", -1716828889),
    // rust: ("potion_contents", 53, "00000001026e6d", -1256264264),
    // rust: (
    // rust: "profile",
    // rust: 72,
    // rust: "010000000100000002000000030000000405537465766501087465787475726573036162630103736967010d6d696e6563726166743a666f6f010e6d696e6563726166743a63617065000101",
    // rust: 1753620268,
    // rust: ),
    // rust: ("profile", 72, "0001054e6f746368000000000000", -1744970702),
    // rust: (
    // rust: "profile",
    // rust: 72,
    // rust: "000001fffffffb000000060000000700000008000000000100",
    // rust: -196647545,
    // rust: ),
    // rust: (
    // rust: "profile",
    // rust: 72,
    // rust: "010000000100000001000000010000000101610108746578747572657301760000000000",
    // rust: -1883525005,
    // rust: ),
    // rust: (
    // rust: "entity_data",
    // rust: 60,
    // rust: "1e0a0100044e6f4149010300034167650000000500",
    // rust: 1343601188,
    // rust: ),
    // rust: (
    // rust: "block_entity_data",
    // rust: 62,
    // rust: "010a0800044c6f636b00017800",
    // rust: -1404731534,
    // rust: ),
    // rust: (
    // rust: "bucket_entity_data",
    // rust: 61,
    // rust: "0a0500064865616c7468404000000100044e6f41490100",
    // rust: 2142887662,
    // rust: ),
    // rust: (
    // rust: "container",
    // rust: 77,
    // rust: "0601a4080300000000000001f1070101000304",
    // rust: 92591498,
    // rust: ),
    // rust: ("container", 77, "00", -1978007022),
    // rust: (
    // rust: "pot_decorations",
    // rust: 76,
    // rust: "01f60801000000000101020000",
    // rust: 1078935147,
    // rust: ),
    // rust: (
    // rust: "block_state",
    // rust: 78,
    // rust: "02036c6974047472756506666163696e67056e6f727468",
    // rust: 1069123732,
    // rust: ),
    // rust: ("bees", 79, "010b0a030003416765000000030003d804", -122152224),
    // rust: ("sulfur_cube_content", 80, "01040000", 231192959),
    // rust: (
    // rust: "sign_text_front",
    // rust: 118,
    // rust: "08000161080000080000080000000e01",
    // rust: -837409994,
    // rust: ),
    // rust: (
    // rust: "sign_text_back",
    // rust: 119,
    // rust: "0800016108000008000008000001080001620800000800000800000f00",
    // rust: 450855835,
    // rust: ),
    // rust: (
    // rust: "lock",
    // rust: 81,
    // rust: "0a0800056974656d73000f6d696e6563726166743a737469636b00",
    // rust: 791108361,
    // rust: ),
    // rust: (
    // rust: "container_loot",
    // rust: 82,
    // rust: "0a04000473656564000000000000000508000a6c6f6f745f7461626c65001f6d696e6563726166743a6368657374732f73696d706c655f64756e67656f6e00",
    // rust: 33155076,
    // rust: ),
    // rust: (
    // rust: "container_loot",
    // rust: 82,
    // rust: "0a08000a6c6f6f745f7461626c65001f6d696e6563726166743a6368657374732f73696d706c655f64756e67656f6e00",
    // rust: -2040272502,
    // rust: ),
    // rust: (
    // rust: "map_decorations",
    // rust: 49,
    // rust: "0a0a000161050008726f746174696f6e40400000060001783ff00000000000000600017a40000000000000000800047479706500106d696e6563726166743a706c617965720000",
    // rust: 1757442925,
    // rust: ),
    // rust: (
    // rust: "debug_stick_state",
    // rust: 59,
    // rust: "0a0800146d696e6563726166743a6f616b5f7374616972730006666163696e6700",
    // rust: -1281127558,
    // rust: ),
    // rust: (
    // rust: "recipes",
    // rust: 68,
    // rust: "090800000001000f6d696e6563726166743a737469636b",
    // rust: -533729841,
    // rust: ),
    // rust: ("intangible_projectile", 22, "0a00", -982207288),
    // rust: ("minimum_attack_charge", 7, "3f000000", -1631070359),
    // rust: ("potion_duration_scale", 54, "40000000", -1320370368),
    // rust: (
    // rust: "tooltip_style",
    // rust: 35,
    // rust: "0f6d696e6563726166743a66616e6379",
    // rust: -1403952026,
    // rust: ),
    // rust: (
    // rust: "note_block_sound",
    // rust: 73,
    // rust: "106d696e6563726166743a637573746f6d",
    // rust: 1404676026,
    // rust: ),
    // rust: ("enchantable", 31, "05", -1577171417),
    // rust: ("villager_food", 44, "03", 18785838),
    // rust: ("glider", 34, "", -982207288),
    // rust: ("waxed", 120, "", -982207288),
    // rust: ("dye", 46, "0e", -1939582294),
    // rust: ("wolf/collar", 91, "0b", 199633461),
    // rust: ("sheep/color", 115, "05", -1201809287),
    // rust: ("cushion/color", 121, "0f", 1821130656),
    // rust: ("villager/variant", 88, "00", 1867638223),
    // rust: ("fox/variant", 92, "01", -1511535024),
    // rust: ("salmon/size", 93, "02", -886537313),
    // rust: ("parrot/variant", 94, "04", -727074367),
    // rust: ("tropical_fish/pattern", 95, "8108", 312926869),
    // rust: ("mooshroom/variant", 98, "01", -541737949),
    // rust: ("rabbit/variant", 99, "63", 1619861300),
    // rust: ("rabbit/variant", 99, "05", 359467842),
    // rust: ("horse/variant", 108, "06", -337512376),
    // rust: ("llama/variant", 110, "03", -727074367),
    // rust: ("axolotl/variant", 111, "04", 199633461),
    // rust: ];
    // rust: for (name, kind, hex, expected) in cases {
    // rust: let bytes = unhex(hex);
    // rust: let mut r = Reader::new(&bytes);
    // rust: let c = Component::read(kind, &mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0, "{name}");
    // rust: assert_eq!(c.hash(kind, &Pinned), Some(expected), "{name} {hex}");
}
}

    /// The same for the components that tune an item's behaviour.
pub fn gameplay_components_hash_as_vanilla_does() void {
}
    // rust: let cases: [(&str, i32, &str, i32); 52] = [
    // rust: (
    // rust: "trim",
    // rust: 58,
    // rust: "000b6d696e6563726166743a700800034d6174000b6d696e6563726166743a610a080005636f6c6f7200037265640800047465787400035061740001",
    // rust: 58182709,
    // rust: ),
    // rust: (
    // rust: "instrument",
    // rust: 63,
    // rust: "00000d6d696e6563726166743a666f6f004000000042c8000000080004486f726e",
    // rust: -2003793539,
    // rust: ),
    // rust: (
    // rust: "instrument",
    // rust: 63,
    // rust: "00bf054000000042c80000030a080004746578740004486f726e010004626f6c640100",
    // rust: -1995771085,
    // rust: ),
    // rust: (
    // rust: "provides_trim_material",
    // rust: 64,
    // rust: "000b6d696e6563726166743a7108000164",
    // rust: 167259767,
    // rust: ),
    // rust: (
    // rust: "banner_patterns",
    // rust: 74,
    // rust: "02000b6d696e6563726166743a62016b0e000b6d696e6563726166743a63016c0b",
    // rust: -178464072,
    // rust: ),
    // rust: ("can_break", 15, "0101020100000000", -1161294463),
    // rust: (
    // rust: "can_place_on",
    // rust: 14,
    // rust: "02010301090103036c6974000101300006666163696e6701056e6f727468036167650001013101013300000001020900000000",
    // rust: -279938577,
    // rust: ),
    // rust: ("can_break", 15, "010000000203030c0200", 1412654667),
    // rust: ("can_break", 15, "010000000000", -982207288),
    // rust: ("can_break", 15, "01000100000000", 281125914),
    // rust: ("use_effects", 5, "01013f000000", -1226654547),
    // rust: ("use_effects", 5, "00013e4ccccd", -982207288),
    // rust: (
    // rust: "attribute_modifiers",
    // rust: 16,
    // rust: "03030e6d696e6563726166743a746573744014000000000000000100170b6d696e6563726166743a78c004000000000000010001010b6d696e6563726166743a793ff00000000000000208020800024869",
    // rust: 694631198,
    // rust: ),
    // rust: ("food", 23, "044020000001", 1478675052),
    // rust: ("food", 23, "010000000000", -72303299),
    // rust: ("consumable", 24, "3fcccccd01bf050100", -982207288),
    // rust: (
    // rust: "consumable",
    // rust: 24,
    // rust: "4040000002a30a00050001000064000101003f0000000102120203410000000104000d6d696e6563726166743a666f6f0140800000",
    // rust: -1668265051,
    // rust: ),
    // rust: (
    // rust: "consumable",
    // rust: 24,
    // rust: "3fcccccd01000d6d696e6563726166743a626172000100",
    // rust: 1520278491,
    // rust: ),
    // rust: ("use_remainder", 25, "ee07010000", -1449413585),
    // rust: (
    // rust: "use_cooldown",
    // rust: 26,
    // rust: "40000000010d6d696e6563726166743a677270",
    // rust: -783582811,
    // rust: ),
    // rust: ("use_cooldown", 26, "3f00000000", -818046427),
    // rust: (
    // rust: "tool",
    // rust: 28,
    // rust: "020301090141000000010102010000400000000200",
    // rust: -1435046669,
    // rust: ),
    // rust: ("tool", 28, "003f8000000101", 937295970),
    // rust: ("weapon", 29, "023fc00000", 896609515),
    // rust: ("weapon", 29, "0100000000", -982207288),
    // rust: (
    // rust: "equippable",
    // rust: 32,
    // rust: "0448010e6d696e6563726166743a676f6c64011a6d696e6563726166743a6d6973632f70756d706b696e626c757201029a010001010001a80b",
    // rust: -1318691560,
    // rust: ),
    // rust: ("equippable", 32, "00470000000101010000a80b", -352294351),
    // rust: (
    // rust: "equippable",
    // rust: 32,
    // rust: "0547000001031e650100000100a80b",
    // rust: 696858640,
    // rust: ),
    // rust: ("equippable", 32, "0747000000010101000033", -1214114539),
    // rust: ("equippable", 32, "06470000000101010000a80b", 1294431019),
    // rust: ("repairable", 33, "02fa07", -646002763),
    // rust: ("repairable", 33, "03fa07ee07", 1894900226),
    // rust: ("death_protection", 36, "0102", 1103435691),
    // rust: ("death_protection", 36, "00", -982207288),
    // rust: (
    // rust: "blocks_attacks",
    // rust: 37,
    // rust: "3f0000003f8000000142340000003f8000003f000000404000003f8000003e4ccccd0001b40b00",
    // rust: -1535582378,
    // rust: ),
    // rust: (
    // rust: "blocks_attacks",
    // rust: 37,
    // rust: "000000003f8000000142b4000000000000003f8000003f800000000000003f800000000000",
    // rust: -982207288,
    // rust: ),
    // rust: (
    // rust: "blocks_attacks",
    // rust: 37,
    // rust: "000000003f8000000142b4000000000000003f8000003f800000000000003f800000000000",
    // rust: -982207288,
    // rust: ),
    // rust: (
    // rust: "blocks_attacks",
    // rust: 37,
    // rust: "000000003f800000003f800000000000003f800000000000",
    // rust: 354948751,
    // rust: ),
    // rust: ("piercing_weapon", 38, "010101bf0500", 1744160152),
    // rust: ("piercing_weapon", 38, "01000000", -982207288),
    // rust: (
    // rust: "kinetic_weapon",
    // rust: 39,
    // rust: "050001143f8000000000000000003f0000003f80000001bf0500",
    // rust: 775699335,
    // rust: ),
    // rust: (
    // rust: "kinetic_weapon",
    // rust: 39,
    // rust: "0a00000000000000003f8000000000",
    // rust: -982207288,
    // rust: ),
    // rust: ("attack_animation", 40, "020a", -2140542379),
    // rust: ("interact_animation", 41, "0106", -982207288),
    // rust: ("interact_animation", 41, "0006", -178357229),
    // rust: ("break_sound", 83, "bf05", 1901640159),
    // rust: ("break_sound", 83, "000b6d696e6563726166743a7100", 924623336),
    // rust: ("compostable", 84, "0100000003", -1585875247),
    // rust: (
    // rust: "compostable",
    // rust: 84,
    // rust: "000e6d696e6563726166743a736f6d65",
    // rust: 190800813,
    // rust: ),
    // rust: ("cooking_fuel", 85, "01000000c8013fc00000", -1393125704),
    // rust: ("brewing_fuel", 86, "01000000050140000000", -1389039553),
    // rust: ("mob_visibility", 87, "02203f000000", 1234665895),
    // rust: ];
    // rust: for (name, kind, hex, expected) in cases {
    // rust: let bytes = unhex(hex);
    // rust: let mut r = Reader::new(&bytes);
    // rust: let c = Component::read(kind, &mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0, "{name}");
    // rust: assert_eq!(c.hash(kind, &Pinned), Some(expected), "{name} {hex}");
}
}

pub fn what_vanilla_cannot_hash_or_horizon_cannot_name_stays_out() void {
}
        // additional_trade_cost has no persistent codec (vanilla's client would throw).
    // rust: assert_eq!(Component::Raw(vec![3]).hash(42, &Pinned), None);
        // A registry id with no name.
    // rust: assert_eq!(Component::Raw(vec![9]).hash(88, &Pinned), None);
        // Bytes left over after the value.
    // rust: assert_eq!(Component::Raw(vec![0, 0]).hash(34, &Pinned), None);
}

    /// Block predicates with an `nbt` or partial component predicates, and books
    /// with filtered text: stream bytes and hashes vanilla 26.3 printed (the same
    /// driver as above, SNBT through the component's codec). The `container` and
    /// `bundle_contents` predicates whose nested item predicate holds exact `components` are
    /// hashed too, when every byte in them is a named `Codec.BOOL`.
pub fn predicates_and_filtered_books_hash_as_vanilla_does() void {
}
    // rust: let cases: [(&str, i32, &str, Option<i32>); 24] = [
    // rust: (
    // rust: "stone_nbt",
    // rust: 14,
    // rust: "0101020100010a010001610108000162000178000000",
    // rust: Some(-359417396),
    // rust: ),
    // rust: (
    // rust: "nbt_all_types",
    // rust: 14,
    // rust: "010000010a08000361206200027122020001730007060001654202a05f20000000050001783fc000000600017940000000000000000b0001690000000200000001000000020900054974656d730a000000010800026964000e6d696e6563726166743a64697274010005436f756e7401000700017a0000000201020400016c00000000000000050c00014c0000000100000000000000030500016e00000000000000",
    // rust: Some(18640168),
    // rust: ),
    // rust: (
    // rust: "damage_partial",
    // rust: 14,
    // rust: "010102010000000101000a0a000664616d6167650300036d696e000000010300036d6178000000050000",
    // rust: Some(-752850259),
    // rust: ),
    // rust: (
    // rust: "custom_data",
    // rust: 14,
    // rust: "010000000001010408000d7b613a312c623a5b312c325d7d",
    // rust: Some(-1320400474),
    // rust: ),
    // rust: (
    // rust: "twinkle",
    // rust: 14,
    // rust: "01000000000101070a080005736861706500047374617201000b6861735f7477696e6b6c650100",
    // rust: Some(-1476889576),
    // rust: ),
    // rust: (
    // rust: "trail_false",
    // rust: 14,
    // rust: "01000000000101070a0100096861735f747261696c0000",
    // rust: Some(-1034820270),
    // rust: ),
    // rust: ("any_value", 14, "01000000000100020a00", Some(-1904716790)),
    // rust: (
    // rust: "villager",
    // rust: 14,
    // rust: "010000000001010e0800106d696e6563726166743a646573657274",
    // rust: Some(1625640440),
    // rust: ),
    // rust: (
    // rust: "potion_effects",
    // rust: 14,
    // rust: "01000000000101030a0a000765666665637473090008636f6e7461696e730a000000010a000f6d696e6563726166743a73706565640a00086475726174696f6e0300036d6178000000640001000776697369626c6500030009616d706c696669657200000001010007616d6269656e740100000000",
    // rust: Some(150754403),
    // rust: ),
    // rust: (
    // rust: "container",
    // rust: 14,
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a0005636f756e740300036d696e00000002000800056974656d73000f6d696e6563726166743a73746f6e650003000473697a65000000030000",
    // rust: Some(-820017514),
    // rust: ),
    // rust: (
    // rust: "fireworks",
    // rust: 14,
    // rust: "01000000000101080a0a000a6578706c6f73696f6e7303000473697a65000000010003000f666c696768745f6475726174696f6e0000000200",
    // rust: Some(-551561987),
    // rust: ),
    // rust: (
    // rust: "attribute_modifiers",
    // rust: 14,
    // rust: "010000000001010b0a0a00096d6f64696669657273090008636f6e7461696e730a000000010a0006616d6f756e740600036d696e3ff800000000000000080009617474726962757465000f6d696e6563726166743a61726d6f72080004736c6f740004686561640800096f7065726174696f6e00096164645f76616c7565000000",
    // rust: Some(-233125185),
    // rust: ),
    // rust: (
    // rust: "bundle_stored",
    // rust: 14,
    // rust: "01000000000201060a0a00056974656d73090008636f6e7461696e730a000000010800056974656d73000f6d696e6563726166743a73746f6e650000000102090a000000010300066c6576656c730000000300",
    // rust: Some(1901599730),
    // rust: ),
    // rust: (
    // rust: "writable_book",
    // rust: 14,
    // rust: "01000000000101090a0a00057061676573090008636f6e7461696e7308000000010001780000",
    // rust: Some(-883070685),
    // rust: ),
    // rust: (
    // rust: "written_book",
    // rust: 14,
    // rust: "010000000001010a0a03000a67656e65726174696f6e000000020a00057061676573090008636f6e7461696e730a000000010800047465787400026869010004626f6c64010000080006617574686f720001410100087265736f6c7665640000",
    // rust: Some(1470044104),
    // rust: ),
    // rust: (
    // rust: "all_fields",
    // rust: 14,
    // rust: "010000010a0300016100000001000101050301000a03000a6475726162696c697479000000030001040800027b7d00020a00",
    // rust: Some(808431166),
    // rust: ),
    // rust: (
    // rust: "container_components",
    // rust: 14,
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730100246d696e6563726166743a656e6368616e746d656e745f676c696e745f6f7665727269646501000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: Some(-1100559882),
    // rust: ),
    // rust: (
    // rust: "container_components_false",
    // rust: 14,
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730100246d696e6563726166743a656e6368616e746d656e745f676c696e745f6f7665727269646500000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: Some(-566759991),
    // rust: ),
    // rust: (
    // rust: "bundle_components_damage_and_name",
    // rust: 14,
    // rust: "01000000000101060a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730300106d696e6563726166743a64616d616765000000050a00156d696e6563726166743a637573746f6d5f6e616d650800047465787400026869010004626f6c640100000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: Some(-473617213),
    // rust: ),
    // rust: (
    // rust: "container_components_food",
    // rust: 14,
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a000e6d696e6563726166743a666f6f6405000a73617475726174696f6e400000000300096e7574726974696f6e0000000401000e63616e5f616c776179735f6561740100000800056974656d73000f6d696e6563726166743a6170706c65000a000473697a650300036d696e00000001000000",
    // rust: Some(1890827479),
    // rust: ),
    // rust: (
    // rust: "can_break_two",
    // rust: 15,
    // rust: "0201020100010a000000000000000100020a00",
    // rust: Some(2146318348),
    // rust: ),
    // rust: (
    // rust: "written_filtered",
    // rust: 57,
    // rust: "01540101460161010208000170010a08000474657874000171010004626f6c640100080005706c61696e0001",
    // rust: Some(1884774986),
    // rust: ),
    // rust: (
    // rust: "written_plain",
    // rust: 57,
    // rust: "01540001610001080001700000",
    // rust: Some(100213250),
    // rust: ),
    // rust: (
    // rust: "writable_filtered",
    // rust: 56,
    // rust: "03036f6e6501022a2a0374776f000133010133",
    // rust: Some(1192237218),
    // rust: ),
    // rust: ];
    // rust: for (name, kind, hex, expected) in cases {
    // rust: let bytes = unhex(hex);
    // rust: let mut r = Reader::new(&bytes);
    // rust: let c = Component::read(kind, &mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0, "{name}");
    // rust: assert_eq!(c.hash(kind, &Pinned), expected, "{name} {hex}");
}
}

    /// Item predicates inside a `container` or `bundle_contents` predicate with
    /// exact `components`: each component's value is NBT whose booleans (found
    /// by that component's codec) hash as booleans. Stream bytes and hashes
    /// vanilla 26.3 printed (a throwaway driver on the real jars: SNBT through
    /// `can_place_on`'s codec, `STREAM_CODEC.encode`, `encodeValue` through
    /// `HashOps.CRC32C_INSTANCE`).
pub fn exact_components_in_predicates_hash_as_vanilla_does() void {
}
    // rust: let cases: [(&str, &str, i32); 21] = [
    // rust: (
    // rust: "glint_true",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730100246d696e6563726166743a656e6368616e746d656e745f676c696e745f6f7665727269646501000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -1100559882,
    // rust: ),
    // rust: (
    // rust: "glint_false",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730100246d696e6563726166743a656e6368616e746d656e745f676c696e745f6f7665727269646500000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -566759991,
    // rust: ),
    // rust: (
    // rust: "custom_data_raw",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a00156d696e6563726166743a637573746f6d5f6461746101000161010a000a636f6d706f6e656e74730100017801000900016c01000000010100000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: 1397969118,
    // rust: ),
    // rust: (
    // rust: "food",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a000e6d696e6563726166743a666f6f6405000a73617475726174696f6e3f8000000300096e7574726974696f6e0000000201000e63616e5f616c776179735f6561740100000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: 371373365,
    // rust: ),
    // rust: (
    // rust: "equippable",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a00146d696e6563726166743a65717569707061626c6501000b64697370656e7361626c6500080004736c6f74000468656164010009737761707061626c650001000e63616e5f62655f736865617265640100000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: 560962810,
    // rust: ),
    // rust: (
    // rust: "model_data",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a001b6d696e6563726166743a637573746f6d5f6d6f64656c5f64617461090006666c6f61747305000000013f800000090007737472696e67730800000001000161090005666c61677301000000020100090006636f6c6f727303000000010000000500000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -378751391,
    // rust: ),
    // rust: (
    // rust: "tooltip",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a00196d696e6563726166743a746f6f6c7469705f646973706c617901000c686964655f746f6f6c7469700109001168696464656e5f636f6d706f6e656e7473080000000100166d696e6563726166743a656e6368616e746d656e747300000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: 226858365,
    // rust: ),
    // rust: (
    // rust: "consumable",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a00146d696e6563726166743a636f6e73756d61626c650900126f6e5f636f6e73756d655f656666656374730a00000002090007656666656374730a000000010300086475726174696f6e0000001401000973686f775f69636f6e00010007616d6269656e74010800026964000f6d696e6563726166743a7370656564000800047479706500176d696e6563726166743a6170706c795f6566666563747300010015646972656374696f6e616c5f7061727469636c6573000500086469616d657465724100000008000474797065001b6d696e6563726166743a74656c65706f72745f72616e646f6d6c79000100156861735f636f6e73756d655f7061727469636c65730000000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: 2077954757,
    // rust: ),
    // rust: (
    // rust: "potion",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a00196d696e6563726166743a706f74696f6e5f636f6e74656e747309000e637573746f6d5f656666656374730a0000000101000973686f775f69636f6e00010007616d6269656e74010800026964000f6d696e6563726166743a737065656401000e73686f775f7061727469636c6573000000000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: 1557644663,
    // rust: ),
    // rust: (
    // rust: "names",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e747309000e6d696e6563726166743a6c6f72650a00000002080004746578740001610100066974616c696301000800000005706c61696e000a00156d696e6563726166743a637573746f6d5f6e616d650800047465787400026869010004626f6c640100000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -1338505994,
    // rust: ),
    // rust: (
    // rust: "book",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a001e6d696e6563726166743a7772697474656e5f626f6f6b5f636f6e74656e7403000a67656e65726174696f6e0000000109000570616765730a0000000108000866696c74657265640001780a000372617708000474657874000170010004626f6c64010000080006617574686f720001410a00057469746c65080003726177000154000100087265736f6c7665640100000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -875258993,
    // rust: ),
    // rust: (
    // rust: "fireworks",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a00136d696e6563726166743a66697265776f726b7309000a6578706c6f73696f6e730a000000010100096861735f747261696c010800057368617065000473746172090006636f6c6f72730300000001000000010001000f666c696768745f6475726174696f6e0200000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: 863655503,
    // rust: ),
    // rust: (
    // rust: "lodestone",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a001b6d696e6563726166743a6c6f646573746f6e655f747261636b6572010007747261636b65640000000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -536467480,
    // rust: ),
    // rust: (
    // rust: "piercing",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a00196d696e6563726166743a7069657263696e675f776561706f6e01000f6465616c735f6b6e6f636b6261636b000100096469736d6f756e74730100000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -335896069,
    // rust: ),
    // rust: (
    // rust: "tool",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a000e6d696e6563726166743a746f6f6c01001e63616e5f64657374726f795f626c6f636b735f696e5f63726561746976650009000572756c65730a00000001080006626c6f636b73000f6d696e6563726166743a73746f6e65010011636f72726563745f666f725f64726f7073010500057370656564400000000000000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: 889667295,
    // rust: ),
    // rust: (
    // rust: "modifiers",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e747309001d6d696e6563726166743a6174747269627574655f6d6f646966696572730a00000001060006616d6f756e743ff00000000000000a0007646973706c61790800047479706500086f766572726964650a000576616c756508000474657874000178010004626f6c640100000800026964000b6d696e6563726166743a6108000474797065000f6d696e6563726166743a61726d6f720800096f7065726174696f6e00096164645f76616c756500000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -1960494218,
    // rust: ),
    // rust: (
    // rust: "nested_container",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730900136d696e6563726166743a636f6e7461696e65720a000000010a00046974656d0a000a636f6d706f6e656e74730a001b6d696e6563726166743a637573746f6d5f6d6f64656c5f64617461090005666c616773010000000101000100246d696e6563726166743a656e6368616e746d656e745f676c696e745f6f76657272696465010a0011216d696e6563726166743a64616d6167650000030005636f756e74000000020800026964000f6d696e6563726166743a73746f6e6500030004736c6f740000000000000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -1517206508,
    // rust: ),
    // rust: (
    // rust: "nested_bundle",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730900196d696e6563726166743a62756e646c655f636f6e74656e74730a000000020a000a636f6d706f6e656e74730a00156d696e6563726166743a637573746f6d5f64617461010001620100000800026964000e6d696e6563726166743a64697274000800026964000f6d696e6563726166743a73746f6e6500000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -1880632630,
    // rust: ),
    // rust: (
    // rust: "two",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730a000e6d696e6563726166743a666f6f6405000a73617475726174696f6e000000000300096e7574726974696f6e00000001000100246d696e6563726166743a656e6368616e746d656e745f676c696e745f6f76657272696465010300146d696e6563726166743a6d61785f64616d61676500000005000800056974656d73000f6d696e6563726166743a73746f6e65000000",
    // rust: -414677810,
    // rust: ),
    // rust: (
    // rust: "nested_predicates",
    // rust: "01000000000101050a0a00056974656d73090008636f6e7461696e730a000000010a000a636f6d706f6e656e74730100246d696e6563726166743a656e6368616e746d656e745f676c696e745f6f7665727269646501000a000a707265646963617465730a001c6d696e6563726166743a66697265776f726b5f6578706c6f73696f6e0100096861735f747261696c0100000003000473697a65000000030000",
    // rust: -374469656,
    // rust: ),
    // rust: (
    // rust: "bundle_pred",
    // rust: "01000000000101060a0a00056974656d73090005636f756e740a000000010a0004746573740a000a636f6d706f6e656e74730a000e6d696e6563726166743a666f6f6405000a73617475726174696f6e3f8000000300096e7574726974696f6e0000000301000e63616e5f616c776179735f6561740100000800056974656d73000e6d696e6563726166743a64697274000a0005636f756e740300036d696e0000000100000000",
    // rust: -166266908,
    // rust: ),
    // rust: ];
    // rust: for (name, hex, expected) in cases {
    // rust: let bytes = unhex(hex);
    // rust: let mut r = Reader::new(&bytes);
    // rust: let c = Component::read(14, &mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0, "{name}");
    // rust: assert_eq!(c.hash(14, &Pinned), Some(expected), "{name}");
}
}
}
