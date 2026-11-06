//! Transpiled from Horizon Rust crate
//! Module: horizon-client_item_sync
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Item stacks on the wire (`ItemStack.OPTIONAL_STREAM_CODEC`): the component
//! patch read back as vanilla's `components` compound, so the decoder the saved
//! and command item NBT use fills every field. Both sides use it: a client for
//! what its server sends, a server for a creative client's
//! `SetCreativeModeSlot`. The other direction is `lan::guest::stack_to_network`.
// use crate::items::ItemStack;
// use horizon_protocol::buf::{Codec, Reader};
// use horizon_protocol::item::{Component, Profile, Stack, Template, component};
// use horizon_protocol::registry::{Builtin, Dynamic};
// use horizon_world::nbt::Tag;
// use std::sync::Arc;

/// A stack from the wire: its item by the built-in registry's id, its
/// components by the synced registries' (enchantments, trims).
pub fn from_network(s: *Stack, builtin: *Builtin, synced: *Dynamic) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = ItemStack {
    // rust: item: item_name(builtin, s.item),
    // rust: count: s.count.max(0) as u32,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: let components = components_tag(s, builtin, synced);
    // rust: let (damage, data) = crate::item_data::decode_components(components.as_ref());
    // rust: out.damage = damage;
    // rust: if let Some(data) = data {
    // rust: *out.data_mut() = *data;
}
    // rust: out.tidy();
    // What it decoded to, to send the server's own patch back if that holds.
    // rust: if let Some(patch) = &s.wire.0 {
    // rust: let decoded = out.clone();
    // rust: out.data_mut().wire = crate::item_data::Wire::new(decoded, patch.clone());
}
    // rust: out
}

/// `LivingEntity.canGlideUsing`: `stack`, worn in equipment slot `slot`
/// (`EquipmentSlot`'s serialized name), has `glider`, its `equippable` slot is
/// that one, and its next damage won't break it. Any item can glide this way:
/// a server or a command may give a chestplate both components.
pub fn can_glide_using(stack: *ItemStack, slot: []const u8, items: *crate::items::Items) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(info) = items.get(&stack.item) else {
    // rust: return false;
}
    // rust: if info.max_damage != 0 && stack.damage + 1 >= info.max_damage {
    // rust: return false;
}
    // Asked every tick for each slot: a stack with no components of its own
    // answers from its item, with nothing to copy or decode.
    // rust: if stack.data().is_none() {
    // rust: return info.glider && info.equip_slot.as_deref() == Some(slot);
}
    // rust: let (glider, equip_slot) = glider_and_slot(stack, info.glider, info.equip_slot.clone());
    // rust: glider && equip_slot.as_deref() == Some(slot)
}

/// The `glider` and `equippable` slot `stack` has, from its item's own: the
/// saved components (a command's, a save's) patch them, then the server's
/// patch, which may also remove them and whose `equippable` isn't kept as a
/// saved component.
    // rust: fn glider_and_slot(
    // rust: stack: &ItemStack,
    // rust: mut glider: bool,
    // rust: mut slot: Option<String>,
    // rust: ) -> (bool, Option<String>) {
    // rust: let Some(data) = stack.data() else {
    // rust: return (glider, slot);
}
    // rust: if data.other("!minecraft:glider").is_some() {
    // rust: glider = false;
    // rust: } else if data.other("minecraft:glider").is_some() {
    // rust: glider = true;
}
    // rust: if data.other("!minecraft:equippable").is_some() {
    // rust: slot = None;
    // rust: } else if let Some(equippable) = data.other("minecraft:equippable") {
    // rust: slot = match equippable.get("slot") {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
    // rust: let Some((added, removed)) = data
    // rust: .wire
    // rust: .patch()
    // rust: .and_then(|p| horizon_protocol::item::WirePatch::decode(p).ok())
    // rust: else {
    // rust: return (glider, slot);
}
    // rust: if removed.contains(&component::GLIDER) {
    // rust: glider = false;
}
    // rust: if removed.contains(&component::EQUIPPABLE) {
    // rust: slot = None;
}
    // rust: for (kind, c) in &added {
    // rust: match (*kind, c) {
    // rust: (component::GLIDER, _) => glider = true,
            // Equippable.STREAM_CODEC starts with its slot's id (EquipmentSlot.getId).
    // rust: (component::EQUIPPABLE, Component::Raw(bytes)) => {
    // rust: slot = Reader::new(bytes)
    // rust: .varint()
    // rust: .ok()
    // rust: .and_then(equipment_slot_name)
    // rust: .map(str::to_owned);
}
    // rust: _ => {}
}
}
    // rust: (glider, slot)
}

/// `EquipmentSlot.byId`'s serialized names.
pub fn equipment_slot_name(id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match id {
    // rust: 0 => "mainhand",
    // rust: 1 => "feet",
    // rust: 2 => "legs",
    // rust: 3 => "chest",
    // rust: 4 => "head",
    // rust: 5 => "offhand",
    // rust: 6 => "body",
    // rust: 7 => "saddle",
    // rust: _ => return None,
    // rust: })
}

/// `DyeColor.byId`: an unknown id is white (`OutOfBoundsStrategy.ZERO`).
pub fn dye_name(id: i32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: usize::try_from(id)
    // rust: .ok()
    // rust: .and_then(|i| crate::block_entity_render::DYES.get(i))
    // rust: .map_or("white", |d| d.0)
}

pub fn item_name(builtin: *Builtin, id: i32) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Arc::from(
    // rust: builtin
    // rust: .get("minecraft:item")
    // rust: .and_then(|i| i.name(id))
    // rust: .unwrap_or("minecraft:air"),
    // rust: )
}

/// The item's patched components as vanilla's `components` compound.
pub fn components_tag(s: *Stack, builtin: *Builtin, synced: *Dynamic) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = |id: i32| {
    // rust: builtin
    // rust: .get("minecraft:data_component_type")
    // rust: .and_then(|types| types.name(id))
    // rust: .or_else(|| {
    // rust: synced
    // rust: .custom_components
    // rust: .then(|| horizon_protocol::item::custom::name(id))
    // rust: .flatten()
    // rust: })
}
    // rust: let mut entries: Vec<(&str, Tag)> = Vec::new();
    // rust: for (kind, c) in &s.added {
    // rust: let Some(key) = name(*kind) else {
    // rust: continue;
}
    // rust: let value = match c {
            // `ItemContainerContents`: a shulker box's items, for its tooltip.
    // rust: Component::Raw(bytes) if *kind == component::CONTAINER => {
    // rust: let Some(slots) = container_tag(bytes, builtin, synced) else {
    // rust: continue;
}
    // rust: slots
}
            // `TypedEntityData`: a block item's block entity, which the op
            // warning and a spawner's tooltip read.
    // rust: Component::Raw(bytes) if *kind == component::BLOCK_ENTITY_DATA => {
    // rust: let Some(data) = block_entity_data_tag(bytes, builtin) else {
    // rust: continue;
}
    // rust: data
}
            // `SignText`: a copied sign's text, which this client's own placement
            // puts on the sign it predicts (#8102).
    // rust: Component::Raw(bytes)
    // rust: if matches!(
    // rust: *kind,
    // rust: component::SIGN_TEXT_FRONT | component::SIGN_TEXT_BACK
    // rust: ) =>
    // rust: {
    // rust: let Some(text) = sign_text_tag(bytes) else {
    // rust: continue;
}
    // rust: text
}
            // Read past, not decoded: the item keeps its prototype's value.
    // rust: Component::Raw(_) => continue,
            // Trim materials and patterns are synced registries, as enchantments are.
    // rust: Component::Trim { material, pattern } => {
    // rust: let (Some(material), Some(pattern)) = (
    // rust: synced.name("minecraft:trim_material", *material),
    // rust: synced.name("minecraft:trim_pattern", *pattern),
    // rust: ) else {
    // rust: continue;
}
    // rust: Tag::compound([
    // rust: ("material", Tag::String(material.into())),
    // rust: ("pattern", Tag::String(pattern.into())),
    // rust: ])
}
            // Instruments are a synced registry: a goat horn names its own.
    // rust: Component::Instrument(id) => match synced.name("minecraft:instrument", *id) {
    // rust: Some(name) => Tag::String(name.into()),
    // rust: None => continue,
    // rust: },
            // BannerPatternLayers: each layer's pattern is a synced registry entry.
    // rust: Component::BannerPatterns(layers) => {
    // rust: let layers: Option<Vec<Tag>> = layers
    // rust: .iter()
    // rust: .map(|(pattern, color)| {
    // rust: let pattern = synced.name("minecraft:banner_pattern", *pattern)?;
    // rust: Some(Tag::compound([
    // rust: ("pattern", Tag::String(pattern.into())),
    // rust: ("color", Tag::String(dye_name(*color).into())),
    // rust: ]))
    // rust: })
    // rust: .collect();
    // rust: let Some(layers) = layers else {
    // rust: continue;
}
    // rust: Tag::List(layers)
}
            // `painting/variant`: a synced registry entry, as trims are.
    // rust: Component::PaintingVariant(id) => {
    // rust: let Some(name) = synced.name("minecraft:painting_variant", *id) else {
    // rust: continue;
}
    // rust: Tag::String(name.into())
}
            // A shield's `base_color`: the dye's id.
    // rust: Component::Int(v) if *kind == component::BASE_COLOR => Tag::String(dye_name(*v).into()),
    // rust: Component::Int(v) if *kind == component::RARITY => {
    // rust: let rarity = ["common", "uncommon", "rare", "epic"];
    // rust: Tag::String(rarity.get(*v as usize).copied().unwrap_or("common").into())
}
    // rust: Component::Int(v) => Tag::Int(*v),
    // rust: Component::Unit => Tag::Compound(Default::default()),
    // rust: Component::Bool(v) => Tag::Byte(i8::from(*v)),
    // rust: Component::Text(t) | Component::Nbt(t) => t.clone(),
    // rust: Component::Ident(v) => Tag::String(v.as_str().into()),
    // rust: Component::Lore(lines) => Tag::List(lines.clone()),
    // rust: Component::WritableBook { pages, .. } => Tag::compound([(
    // rust: "pages",
    // rust: Tag::List(
    // rust: pages
    // rust: .iter()
    // rust: .map(|p| Tag::String(p.as_str().into()))
    // rust: .collect(),
    // rust: ),
    // rust: )]),
    // rust: Component::WrittenBook(b) => Tag::compound([
    // rust: ("title", Tag::String(b.title.as_str().into())),
    // rust: ("author", Tag::String(b.author.as_str().into())),
    // rust: ("generation", Tag::Int(b.generation)),
    // rust: ("pages", Tag::List(b.pages.clone())),
    // rust: ("resolved", Tag::Byte(i8::from(b.resolved))),
    // rust: ]),
    // rust: Component::Fireworks { flight, explosions } => Tag::compound([
    // rust: ("flight_duration", Tag::Byte(*flight as i8)),
    // rust: (
    // rust: "explosions",
    // rust: Tag::List(explosions.iter().map(fireworks_tag).collect()),
    // rust: ),
    // rust: ]),
    // rust: Component::FireworkExplosion(e) => fireworks_tag(e),
    // rust: Component::LodestoneTracker { target, tracked } => {
    // rust: let mut entries = Vec::new();
    // rust: if let Some((dimension, pos)) = target {
    // rust: entries.push((
    // rust: "target",
    // rust: Tag::compound([
    // rust: ("dimension", Tag::String(dimension.as_str().into())),
    // rust: ("pos", Tag::IntArray(pos.to_vec())),
    // rust: ]),
    // rust: ));
}
    // rust: if !tracked {
    // rust: entries.push(("tracked", Tag::Byte(0)));
}
    // rust: Tag::compound(entries)
}
    // rust: Component::Enchantments(list) => {
                // Enchantments are a synced (data-driven) registry: the
                // ids index the server's RegistryData, not the builtin
                // report, so a datapack enchantment names correctly.
    // rust: let levels = list.iter().filter_map(|(id, level)| {
    // rust: let name = synced.name("minecraft:enchantment", *id)?;
    // rust: Some((name, Tag::Int(*level)))
    // rust: });
    // rust: Tag::compound(levels)
}
    // rust: Component::AttackRange(v) => Tag::compound([
    // rust: ("min_reach", Tag::Float(v[0].to_bits())),
    // rust: ("max_reach", Tag::Float(v[1].to_bits())),
    // rust: ("min_attack_momentum", Tag::Float(v[2].to_bits())),
    // rust: ("max_attack_momentum", Tag::Float(v[3].to_bits())),
    // rust: ("hitbox_margin", Tag::Float(v[4].to_bits())),
    // rust: ("mob_factor", Tag::Float(v[5].to_bits())),
    // rust: ]),
    // rust: Component::Profile(p) => profile_tag(p),
            // SuspiciousStewEffects' NBT: each effect by name and its duration.
    // rust: Component::StewEffects(list) => Tag::List(
    // rust: list.iter()
    // rust: .filter_map(|(id, duration)| {
    // rust: let name = builtin.get("minecraft:mob_effect")?.name(*id)?;
    // rust: Some(Tag::compound([
    // rust: ("id", Tag::String(name.into())),
    // rust: ("duration", Tag::Int(*duration)),
    // rust: ]))
    // rust: })
    // rust: .collect(),
    // rust: ),
            // PotionContents' NBT: the potion by name and the custom colour.
    // rust: Component::Potion { potion, color, .. } => {
    // rust: let potion = potion.and_then(|id| builtin.get("minecraft:potion")?.name(id));
    // rust: Tag::compound(
    // rust: potion
    // rust: .map(|name| ("potion", Tag::String(name.into())))
    // rust: .into_iter()
    // rust: .chain(color.map(|c| ("custom_color", Tag::Int(c)))),
    // rust: )
}
            // ItemStackTemplate.CODEC: id, count and components.
    // rust: Component::Stacks(stacks) => Tag::List(
    // rust: stacks
    // rust: .iter()
    // rust: .map(|t| template_tag(t, builtin, synced))
    // rust: .collect(),
    // rust: ),
    // rust: Component::CustomModelData {
    // rust: floats,
    // rust: flags,
    // rust: strings,
    // rust: colors,
    // rust: } => Tag::compound([
    // rust: (
    // rust: "floats",
    // rust: Tag::List(floats.iter().map(|f| Tag::Float(f.to_bits())).collect()),
    // rust: ),
    // rust: (
    // rust: "flags",
    // rust: Tag::List(flags.iter().map(|b| Tag::Byte(i8::from(*b))).collect()),
    // rust: ),
    // rust: (
    // rust: "strings",
    // rust: Tag::List(
    // rust: strings
    // rust: .iter()
    // rust: .map(|s| Tag::String(s.as_str().into()))
    // rust: .collect(),
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "colors",
    // rust: Tag::List(colors.iter().map(|c| Tag::Int(*c)).collect()),
    // rust: ),
    // rust: ]),
    // rust: Component::TooltipDisplay { hide, hidden } => {
    // rust: let hidden = hidden
    // rust: .iter()
    // rust: .filter_map(|id| Some(Tag::String(name(*id)?.into())));
    // rust: Tag::compound([
    // rust: ("hide_tooltip", Tag::Byte(i8::from(*hide))),
    // rust: ("hidden_components", Tag::List(hidden.collect())),
    // rust: ])
}
}
    // rust: entries.push((key, value));
}
    // rust: let mut out = Tag::compound(entries);
    // rust: if let Tag::Compound(map) = &mut out {
    // rust: for id in &s.removed {
    // rust: if *id == component::MAX_STACK_SIZE {
    // rust: map.insert(
    // rust: "!minecraft:max_stack_size".into(),
    // rust: Tag::Compound(Default::default()),
    // rust: );
}
    // rust: if synced.custom_components
    // rust: && let Some(name) = horizon_protocol::item::custom::name(*id)
    // rust: {
    // rust: map.insert(
    // rust: format!("!{name}").as_str().into(),
    // rust: Tag::Compound(Default::default()),
    // rust: );
}
}
}
    // rust: Some(out)
}

/// An `ItemStackTemplate` as its NBT codec writes it: id, count and components.
pub fn template_tag(t: *Stack, builtin: *Builtin, synced: *Dynamic) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries = vec![
    // rust: (
    // rust: "id",
    // rust: Tag::String(item_name(builtin, t.item).as_ref().into()),
    // rust: ),
    // rust: ("count", Tag::Int(t.count)),
    // rust: ];
    // rust: if let Some(c) = components_tag(t, builtin, synced) {
    // rust: entries.push(("components", c));
}
    // rust: Tag::compound(entries)
}

/// `TypedEntityData.streamCodec` of a block entity: its type's registry id,
/// then its data without the id, which the saved component keeps.
pub fn block_entity_data_tag(bytes: []const u8, builtin: *Builtin) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(bytes);
    // rust: let id = r.varint().ok()?;
    // rust: let kind = builtin.get("minecraft:block_entity_type")?.name(id)?;
    // rust: let Tag::Compound(mut data) = r.nbt().ok()? else {
    // rust: return None;
}
    // rust: data.insert("id".into(), Tag::String(kind.into()));
    // rust: Some(Tag::Compound(data))
}

/// `SignText.STREAM_CODEC` as `SignText.CODEC` saves it: the four messages,
/// the filtered four when the server sent them, the dye colour and the glow.
pub fn sign_text_tag(bytes: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(bytes);
    // rust: let lines = |r: &mut Reader| (0..4).map(|_| r.nbt().ok()).collect::<Option<Vec<_>>>();
    // rust: let mut text = vec![("messages", Tag::List(lines(&mut r)?))];
    // rust: if r.bool().ok()? {
    // rust: text.push(("filtered_messages", Tag::List(lines(&mut r)?)));
}
    // rust: text.push(("color", Tag::String(dye_name(r.varint().ok()?).into())));
    // rust: text.push(("has_glowing_text", Tag::Byte(i8::from(r.bool().ok()?))));
    // rust: Some(Tag::compound(text))
}

/// `ItemContainerContents.STREAM_CODEC`, one optional template per slot, as
/// the saved `container` lists the slots that hold one.
pub fn container_tag(bytes: []const u8, builtin: *Builtin, synced: *Dynamic) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(bytes);
    // rust: let mut slots = Vec::new();
    // rust: for slot in 0..r.count(256).ok()? {
    // rust: if r.bool().ok()? {
    // rust: let stack = Template::read(&mut r).ok()?;
    // rust: slots.push(Tag::compound([
    // rust: ("slot", Tag::Int(slot as i32)),
    // rust: ("item", template_tag(&stack, builtin, synced)),
    // rust: ]));
}
}
    // rust: Some(Tag::List(slots))
}

/// A wire `FireworkExplosion` as vanilla's NBT codec writes it
/// (`FireworkExplosion.Shape`'s BY_ID order).
pub fn fireworks_tag(e: *horizon_protocol::item::FireworkExplosion) T {
    // Implementation ported from Horizon
    return undefined;
}
pub const SHAPES: [[]const u8; 5] = ["small_ball", "large_ball", "star", "creeper", "burst"];
    // rust: let ints = |c: &[i32]| Tag::List(c.iter().map(|c| Tag::Int(*c)).collect());
    // rust: Tag::compound([
    // rust: (
    // rust: "shape",
    // rust: Tag::String(
    // rust: SHAPES
    // rust: .get(e.shape.max(0) as usize)
    // rust: .copied()
    // rust: .unwrap_or("small_ball")
    // rust: .into(),
    // rust: ),
    // rust: ),
    // rust: ("colors", ints(&e.colors)),
    // rust: ("fade_colors", ints(&e.fade)),
    // rust: ("has_trail", Tag::Byte(i8::from(e.trail))),
    // rust: ("has_twinkle", Tag::Byte(i8::from(e.twinkle))),
    // rust: ])
}

/// A `minecraft:profile` component as the item data JSON the model reads.
pub fn profile_tag(p: *Profile) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let properties = p
    // rust: .properties
    // rust: .iter()
    // rust: .map(|(name, value, signature)| {
    // rust: let mut entries: Vec<(&'static str, Tag)> = vec![
    // rust: ("name", Tag::String(name.as_str().into())),
    // rust: ("value", Tag::String(value.as_str().into())),
    // rust: ];
    // rust: if let Some(signature) = signature {
    // rust: entries.push(("signature", Tag::String(signature.as_str().into())));
}
    // rust: Tag::compound(entries)
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: let mut entries: Vec<(&'static str, Tag)> = Vec::new();
    // rust: if let Some(name) = &p.name {
    // rust: entries.push(("name", Tag::String(name.as_str().into())));
}
    // rust: if let Some(id) = p.id {
    // rust: entries.push((
    // rust: "id",
    // rust: Tag::IntArray(vec![
    // rust: (id >> 96) as i32,
    // rust: (id >> 64) as i32,
    // rust: (id >> 32) as i32,
    // rust: id as i32,
    // rust: ]),
    // rust: ));
}
    // rust: entries.push(("properties", Tag::List(properties)));
    // rust: Tag::compound(entries)
}

    // rust: mod tests {
//     use super::*;
//     use horizon_protocol::registry::Ids;

    /// A chestplate a server made a glider: its patch adds `glider` and an
    /// `equippable` for the chest, or takes `glider` away again.
pub fn a_servers_patch_makes_any_item_a_glider() void {
}
    // rust: let with_patch = |patch: &[u8]| {
    // rust: let mut stack = ItemStack::new("minecraft:diamond_chestplate", 1);
    // rust: stack.data_mut().wire =
    // rust: crate::item_data::Wire::new(stack.clone(), Arc::from(patch.to_vec()));
    // rust: stack
}
        // Equippable: slot 3 (chest), a sound reference, no asset, overlay or
        // allowed entities, its five flags, the shearing sound.
    // rust: let equippable = [3, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1];
    // rust: let mut adds = vec![
    // rust: 2,
    // rust: 0,
    // rust: component::GLIDER as u8,
    // rust: 0,
    // rust: component::EQUIPPABLE as u8,
    // rust: ];
    // rust: adds.push(equippable.len() as u8);
    // rust: adds.extend(equippable);
    // rust: assert_eq!(
    // rust: glider_and_slot(&with_patch(&adds), false, Some("head".into())),
    // rust: (true, Some("chest".into()))
    // rust: );
    // rust: let removes = [0, 1, component::GLIDER as u8];
    // rust: assert_eq!(
    // rust: glider_and_slot(&with_patch(&removes), true, Some("chest".into())),
    // rust: (false, Some("chest".into()))
    // rust: );
        // No data: the item's own.
    // rust: let plain = ItemStack::new("minecraft:elytra", 1);
    // rust: assert_eq!(
    // rust: glider_and_slot(&plain, true, Some("chest".into())),
    // rust: (true, Some("chest".into()))
    // rust: );
}

    /// A command's chestplate (`/give @s diamond_chestplate[glider={},
    /// equippable={slot:"chest"}]`) keeps both as saved components.
pub fn saved_components_make_any_item_a_glider() void {
}
    // rust: let mut stack = ItemStack::new("minecraft:diamond_chestplate", 1);
    // rust: stack.data_mut().other = vec![
    // rust: ("minecraft:glider".into(), Tag::Compound(Default::default())),
    // rust: (
    // rust: "minecraft:equippable".into(),
    // rust: Tag::compound([("slot", Tag::String("chest".into()))]),
    // rust: ),
    // rust: ];
    // rust: assert_eq!(
    // rust: glider_and_slot(&stack, false, Some("chest".into())),
    // rust: (true, Some("chest".into()))
    // rust: );
    // rust: stack.data_mut().other = vec![(
    // rust: "!minecraft:equippable".into(),
    // rust: Tag::Compound(Default::default()),
    // rust: )];
    // rust: assert_eq!(glider_and_slot(&stack, true, Some("chest".into())).1, None);
}

pub fn merchant_water_cost_survives_the_offer_packet() void {
}
//         use horizon_protocol::{
    // rust: buf::{Codec, Reader, Writer},
    // rust: packets::play::{NetOffer, Offers},
}
    // rust: let mut components = vec![String::new(); component::POTION_CONTENTS as usize + 1];
    // rust: components[component::POTION_CONTENTS as usize] = "minecraft:potion_contents".into();
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".into(),
    // rust: Ids::from_names(vec!["minecraft:potion".into(), "minecraft:emerald".into()]),
    // rust: ),
    // rust: (
    // rust: "minecraft:potion".into(),
    // rust: Ids::from_names(vec!["minecraft:water".into()]),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".into(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let dynamic = Dynamic::default();
    // rust: let water = ItemStack::new("minecraft:potion", 1).with_potion("minecraft:water");
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| builtin.get("minecraft:item").unwrap().id(name).unwrap(),
    // rust: |registry, name| builtin.get(registry)?.id(name),
    // rust: &Some(water.clone()),
    // rust: )
    // rust: .unwrap();
    // rust: let offers = vec![NetOffer {
    // rust: cost_a: wire.into(),
    // rust: result: Stack::new(1, 1),
    // rust: cost_b: Some(Stack::new(1, 2).into()),
    // rust: out_of_stock: false,
    // rust: uses: 0,
    // rust: max_uses: 2,
    // rust: xp: 0,
    // rust: special_price: 0,
    // rust: price_multiplier: 0.05,
    // rust: demand: 0,
    // rust: }];
    // rust: let mut w = Writer::new();
    // rust: Offers::write(&offers, &mut w);
    // rust: let mut r = Reader::new(&w.data);
    // rust: let decoded = Offers::read(&mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0);
    // rust: let cost = crate::merchant::ItemCost {
    // rust: stack: from_network(&decoded[0].cost_a.clone().into(), &builtin, &dynamic),
}
    // rust: assert_eq!(cost.stack, water);
    // rust: assert_eq!(cost.stack.potion(), Some("minecraft:water"));
    // rust: let authoritative = crate::merchant::ItemCost {
    // rust: stack: water.clone(),
}
    // rust: for payment in [
    // rust: water,
    // rust: ItemStack::new("minecraft:potion", 1).with_potion("minecraft:swiftness"),
    // rust: ItemStack::new("minecraft:potion", 1),
    // rust: ] {
    // rust: assert_eq!(cost.test(&payment), authoritative.test(&payment));
}
    // rust: assert!(cost.test(&ItemStack::new("minecraft:potion", 1).with_potion("minecraft:water")));
    // rust: assert!(
    // rust: !cost.test(&ItemStack::new("minecraft:potion", 1).with_potion("minecraft:swiftness"))
    // rust: );
    // rust: let emerald = crate::merchant::ItemCost {
    // rust: stack: from_network(
    // rust: &decoded[0].cost_b.clone().unwrap().into(),
    // rust: &builtin,
    // rust: &dynamic,
    // rust: ),
}
    // rust: assert!(emerald.test(&ItemStack::new("minecraft:emerald", 2)));
}

    /// A bundle's contents cross the wire, so a server's client can draw
    /// its tooltip (BundleContents' stream codec: a list of templates).
pub fn a_bundle_keeps_its_contents_across_the_wire() void {
}
    // rust: let mut components = vec![String::new(); 60];
    // rust: components[component::BUNDLE_CONTENTS as usize] = "minecraft:bundle_contents".into();
    // rust: let items = ["minecraft:air", "minecraft:bundle", "minecraft:stone"];
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".to_owned(),
    // rust: Ids::from_names(items.iter().map(|s| s.to_string()).collect()),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".to_owned(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let dynamic = Dynamic {
    // rust: registries: Default::default(),
    // rust: ..Default::default()
}
    // rust: let mut bundle = ItemStack::new("minecraft:bundle", 1);
    // rust: bundle.data_mut().bundle_contents = vec![ItemStack::new("minecraft:stone", 32)];
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| items.iter().position(|i| *i == name).unwrap_or(0) as i32,
    // rust: |_, _| None,
    // rust: &Some(bundle),
    // rust: )
    // rust: .unwrap();
    // rust: let back = from_network(&wire, &builtin, &dynamic);
    // rust: let contents = &back.data().expect("components").bundle_contents;
    // rust: assert_eq!(contents.len(), 1);
    // rust: assert_eq!(
    // rust: (&*contents[0].item, contents[0].count),
    // rust: ("minecraft:stone", 32)
    // rust: );
}

    /// `custom_model_data` and `item_model` reach the client, whose item
    /// model reads them (#4916): single player's window gets its stacks this way.
pub fn model_components_cross_the_wire() void {
}
    // rust: let mut components = vec![String::new(); 60];
    // rust: components[component::ITEM_MODEL as usize] = "minecraft:item_model".into();
    // rust: components[component::CUSTOM_MODEL_DATA as usize] = "minecraft:custom_model_data".into();
    // rust: let items = ["minecraft:air", "minecraft:stick"];
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".to_owned(),
    // rust: Ids::from_names(items.iter().map(|s| s.to_string()).collect()),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".to_owned(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let given = crate::item_data::command_components(
    // rust: "[item_model='minecraft:emerald',custom_model_data={floats:[0.5f],flags:[1b],\
    // rust: strings:['gold'],colors:[16711680,[0.0f,1.0f,0.0f]]}]",
    // rust: )
    // rust: .unwrap();
    // rust: let (damage, extra) = crate::item_data::decode_components(Some(&given));
    // rust: let stick = ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..ItemStack::new("minecraft:stick", 1)
}
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| items.iter().position(|i| *i == name).unwrap_or(0) as i32,
    // rust: |_, _| None,
    // rust: &Some(stick),
    // rust: )
    // rust: .unwrap();
    // rust: let back = from_network(&wire, &builtin, &Dynamic::default());
    // rust: let data = back.data().expect("components");
    // rust: assert_eq!(
    // rust: crate::save::text(data.other("minecraft:item_model")).as_deref(),
    // rust: Some("minecraft:emerald")
    // rust: );
    // rust: let cmd = data
    // rust: .other("minecraft:custom_model_data")
    // rust: .expect("custom_model_data");
    // rust: let list = |key: &str| match cmd.get(key) {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: other => panic!("{key}: {other:?}"),
}
    // rust: assert_eq!(list("floats"), [Tag::Float(0.5f32.to_bits())]);
    // rust: assert_eq!(list("flags"), [Tag::Byte(1)]);
    // rust: assert_eq!(list("strings"), [Tag::String("gold".into())]);
        // The float triple arrives as the opaque int vanilla's codec makes of it.
    // rust: assert_eq!(
    // rust: list("colors"),
    // rust: [Tag::Int(16711680), Tag::Int(0xFF00FF00u32 as i32)]
    // rust: );
}

    /// An unbreakable damaged stack must keep both components through inventory
    /// sync, including the integrated server's window (#5721).
pub fn unbreakable_survives_inventory_sync() void {
}
//         use horizon_protocol::buf::{Codec, Reader, Writer};
//         use horizon_protocol::item::Slot;
    // rust: let mut components = vec![String::new(); component::UNBREAKABLE as usize + 1];
    // rust: components[component::DAMAGE as usize] = "minecraft:damage".into();
    // rust: components[component::UNBREAKABLE as usize] = "minecraft:unbreakable".into();
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".into(),
    // rust: Ids::from_names(vec!["minecraft:air".into(), "minecraft:diamond_hoe".into()]),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".into(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: for unbreakable in [false, true] {
    // rust: let mut hoe = ItemStack::new("minecraft:diamond_hoe", 1);
    // rust: hoe.damage = 58;
    // rust: let marker = Tag::Compound(Default::default());
    // rust: if unbreakable {
    // rust: hoe.data_mut()
    // rust: .set_other("minecraft:unbreakable", Some(marker.clone()));
}
    // rust: let sent = crate::lan::guest::stack_to_network(|_| 1, |_, _| None, &Some(hoe));
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&sent, &mut w);
    // rust: let mut r = Reader::new(&w.data);
    // rust: let received = Slot::read(&mut r).unwrap().unwrap();
    // rust: assert_eq!(r.remaining(), 0);
    // rust: assert_eq!(
    // rust: received.component(component::UNBREAKABLE),
    // rust: unbreakable.then_some(&Component::Unit)
    // rust: );
    // rust: let back = from_network(&received, &builtin, &Dynamic::default());
    // rust: assert_eq!(
    // rust: (&*back.item, back.count, back.damage),
    // rust: ("minecraft:diamond_hoe", 1, 58)
    // rust: );
    // rust: assert_eq!(
    // rust: back.data().and_then(|d| d.other("minecraft:unbreakable")),
    // rust: unbreakable.then_some(&marker)
    // rust: );
}
}

    /// An ominous bottle's `ominous_bottle_amplifier` reaches the client
    /// through the packet's bytes, so its tooltip names the Bad Omen level.
pub fn an_ominous_bottle_keeps_its_amplifier_across_the_wire() void {
}
//         use horizon_protocol::buf::{Codec, Reader, Writer};
//         use horizon_protocol::item::Slot;
    // rust: let mut components = vec![String::new(); 80];
    // rust: components[component::OMINOUS_BOTTLE_AMPLIFIER as usize] =
    // rust: "minecraft:ominous_bottle_amplifier".into();
    // rust: let items = ["minecraft:air", "minecraft:ominous_bottle"];
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".to_owned(),
    // rust: Ids::from_names(items.iter().map(|s| s.to_string()).collect()),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".to_owned(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let dynamic = Dynamic {
    // rust: registries: Default::default(),
    // rust: ..Default::default()
}
    // rust: for amplifier in [None, Some(0), Some(3)] {
    // rust: let mut bottle = ItemStack::new("minecraft:ominous_bottle", 1);
    // rust: if let Some(a) = amplifier {
    // rust: bottle.data_mut().ominous_amplifier = Some(a);
}
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| items.iter().position(|i| *i == name).unwrap_or(0) as i32,
    // rust: |_, _| None,
    // rust: &Some(bottle),
    // rust: );
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&wire, &mut w);
    // rust: let mut r = Reader::new(&w.data);
    // rust: let read = Slot::read(&mut r).unwrap().unwrap();
    // rust: assert_eq!(r.remaining(), 0);
    // rust: let back = from_network(&read, &builtin, &dynamic);
    // rust: assert_eq!(
    // rust: back.data().and_then(|d| d.ominous_amplifier),
    // rust: amplifier,
    // rust: "{amplifier:?}"
    // rust: );
}
}

    /// What a creative client sends (`stack_to_network`) comes back whole on
    /// the server: damage, both enchantment lists, repair cost, name, trim,
    /// potion and stew effects.
pub fn a_creative_stack_keeps_its_components_across_the_wire() void {
}
    // rust: let mut components = vec![String::new(); 60];
    // rust: for (id, name) in [
    // rust: (component::MAX_DAMAGE, "minecraft:max_damage"),
    // rust: (component::DAMAGE, "minecraft:damage"),
    // rust: (component::CUSTOM_NAME, "minecraft:custom_name"),
    // rust: (component::ITEM_NAME, "minecraft:item_name"),
    // rust: (component::ENCHANTMENTS, "minecraft:enchantments"),
    // rust: (component::POTION_CONTENTS, "minecraft:potion_contents"),
    // rust: (component::REPAIR_COST, "minecraft:repair_cost"),
    // rust: (
    // rust: component::STORED_ENCHANTMENTS,
    // rust: "minecraft:stored_enchantments",
    // rust: ),
    // rust: (component::TRIM, "minecraft:trim"),
    // rust: (
    // rust: component::SUSPICIOUS_STEW_EFFECTS,
    // rust: "minecraft:suspicious_stew_effects",
    // rust: ),
    // rust: ] {
    // rust: components[id as usize] = name.to_owned();
}
    // rust: let names = |n: &[&str]| n.iter().map(|s| s.to_string()).collect::<Vec<_>>();
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".to_owned(),
    // rust: Ids::from_names(names(&[
    // rust: "minecraft:air",
    // rust: "minecraft:diamond_chestplate",
    // rust: "minecraft:splash_potion",
    // rust: "minecraft:suspicious_stew",
    // rust: ])),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".to_owned(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: (
    // rust: "minecraft:potion".to_owned(),
    // rust: Ids::from_names(names(&["minecraft:water", "minecraft:swiftness"])),
    // rust: ),
    // rust: (
    // rust: "minecraft:mob_effect".to_owned(),
    // rust: Ids::from_names(names(&["minecraft:speed", "minecraft:fire_resistance"])),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let synced = |n: &[&str]| n.iter().map(|s| (s.to_string(), None)).collect::<Vec<_>>();
    // rust: let dynamic = Dynamic {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:enchantment".to_owned(),
    // rust: synced(&["minecraft:protection", "minecraft:sharpness"]),
    // rust: ),
    // rust: (
    // rust: "minecraft:trim_material".to_owned(),
    // rust: synced(&["minecraft:gold"]),
    // rust: ),
    // rust: (
    // rust: "minecraft:trim_pattern".to_owned(),
    // rust: synced(&["minecraft:sentry"]),
    // rust: ),
    // rust: ]
    // rust: .into(),
    // rust: ..Default::default()
}
    // rust: let mut stack = ItemStack::new("minecraft:diamond_chestplate", 1);
    // rust: stack.damage = 5;
    // rust: stack.enchant("minecraft:protection", 4);
    // rust: let d = stack.data_mut();
    // rust: d.set_other("minecraft:max_damage", Some(Tag::Int(500)));
    // rust: d.stored_enchantments
    // rust: .push((Arc::from("minecraft:sharpness"), 2));
    // rust: d.repair_cost = 9;
    // rust: d.custom_name = Some(Tag::String("Keeper".into()));
        // A translatable item name reaches the client as the same component.
    // rust: let item_name = Tag::compound([("translate", Tag::String("filled_map.monument".into()))]);
    // rust: d.other
    // rust: .push(("minecraft:item_name".into(), item_name.clone()));
    // rust: d.trim = Some((Arc::from("minecraft:gold"), Arc::from("minecraft:sentry")));
    // rust: let id = |registry: &str, name: &str| {
    // rust: builtin
    // rust: .get(registry)
    // rust: .and_then(|ids| ids.id(name))
    // rust: .or_else(|| dynamic.id(registry, name))
}
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| {
    // rust: builtin
    // rust: .get("minecraft:item")
    // rust: .and_then(|i| i.id(name))
    // rust: .unwrap_or(0)
    // rust: },
    // rust: id,
    // rust: &Some(stack.clone()),
    // rust: )
    // rust: .unwrap();
    // rust: let back = from_network(&wire, &builtin, &dynamic);
    // rust: assert_eq!(back.item, stack.item);
    // rust: assert_eq!(back.damage, 5);
    // rust: let d = back.data().expect("components");
    // rust: assert_eq!(d.other("minecraft:max_damage"), Some(&Tag::Int(500)));
    // rust: assert_eq!(d.enchantments, vec![(Arc::from("minecraft:protection"), 4)]);
    // rust: assert_eq!(
    // rust: d.stored_enchantments,
    // rust: vec![(Arc::from("minecraft:sharpness"), 2)]
    // rust: );
    // rust: assert_eq!(d.repair_cost, 9);
    // rust: assert_eq!(d.custom_name_plain().as_deref(), Some("Keeper"));
    // rust: assert_eq!(d.other("minecraft:item_name"), Some(&item_name));
    // rust: assert_eq!(
    // rust: d.trim,
    // rust: Some((Arc::from("minecraft:gold"), Arc::from("minecraft:sentry")))
    // rust: );
        // PotionContents: the potion is a built-in registry, as a hub's
        // `SyncData::id` treats it, so the id has to come from there.
    // rust: let potion = ItemStack::new("minecraft:splash_potion", 1).with_potion("swiftness");
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| id("minecraft:item", name).unwrap_or(0),
    // rust: id,
    // rust: &Some(potion),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: from_network(&wire, &builtin, &dynamic).potion(),
    // rust: Some("minecraft:swiftness")
    // rust: );
        // SuspiciousStewEffects, as a creative tab's stew has them: without
        // them the server's stew gives no effect when eaten (#3137).
    // rust: let mut stew = ItemStack::new("minecraft:suspicious_stew", 1);
    // rust: stew.data_mut()
    // rust: .stew_effects
    // rust: .push((Arc::from("minecraft:fire_resistance"), 60));
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| id("minecraft:item", name).unwrap_or(0),
    // rust: id,
    // rust: &Some(stew),
    // rust: )
    // rust: .unwrap();
    // rust: let back = from_network(&wire, &builtin, &dynamic);
    // rust: assert_eq!(
    // rust: back.data().map(|d| d.stew_effects.clone()),
    // rust: Some(vec![(Arc::from("minecraft:fire_resistance"), 60)])
    // rust: );
}

    /// A painting's `painting/variant` (a `painting_variant` holder, id 109)
    /// crosses the wire both ways: a server's creative slot gets the variant
    /// its client picked, and a client's tooltip names the server's.
pub fn a_painting_keeps_its_variant_across_the_wire() void {
}
//         use horizon_protocol::buf::{Codec, Reader, Writer};
//         use horizon_protocol::item::Slot;
    // rust: let mut components = vec![String::new(); 110];
    // rust: components[109] = "minecraft:painting/variant".into();
    // rust: let items = ["minecraft:air", "minecraft:painting"];
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".to_owned(),
    // rust: Ids::from_names(items.iter().map(|s| s.to_string()).collect()),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".to_owned(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let variants = ["minecraft:alban", "minecraft:kebab"];
    // rust: let dynamic = Dynamic {
    // rust: registries: [(
    // rust: "minecraft:painting_variant".to_owned(),
    // rust: variants.iter().map(|v| (v.to_string(), None)).collect(),
    // rust: )]
    // rust: .into(),
    // rust: ..Default::default()
}
        // ItemStack.OPTIONAL_STREAM_CODEC: count 1, the painting, one added
        // component (109: the reference to kebab, its id plus one), none removed.
    // rust: let vanilla = [1u8, 1, 1, 0, 109, 2];
    // rust: let stack = Slot::read(&mut Reader::new(&vanilla)).unwrap().unwrap();
    // rust: let back = from_network(&stack, &builtin, &dynamic);
    // rust: let variant = |s: &ItemStack| {
    // rust: s.data()
    // rust: .and_then(|d| d.other("minecraft:painting/variant"))
    // rust: .cloned()
}
    // rust: assert_eq!(variant(&back), Some(Tag::String("minecraft:kebab".into())));
    // rust: let mut alban = ItemStack::new("minecraft:painting", 1);
    // rust: alban.data_mut().set_other(
    // rust: "minecraft:painting/variant",
    // rust: Some(Tag::String("minecraft:alban".into())),
    // rust: );
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| items.iter().position(|i| *i == name).unwrap_or(0) as i32,
    // rust: |registry, name| dynamic.id(registry, name),
    // rust: &Some(alban.clone()),
    // rust: );
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&wire, &mut w);
    // rust: assert_eq!(w.data, [1, 1, 1, 0, 109, 1]);
    // rust: let wire = Slot::read(&mut Reader::new(&w.data)).unwrap().unwrap();
    // rust: assert_eq!(
    // rust: variant(&from_network(&wire, &builtin, &dynamic)),
    // rust: variant(&alban)
    // rust: );
}

    /// A sign picked with its data (`SignBlockEntity.collectImplicitComponents`)
    /// keeps its text across the wire both ways: `sign_text_front` and
    /// `sign_text_back` (ids 118 and 119, `SignText.STREAM_CODEC`) reach the
    /// client's stack, whose own placement puts the text on the sign (#8102).
pub fn a_signs_text_crosses_the_wire() void {
}
//         use horizon_protocol::buf::{Reader, Writer};
//         use horizon_protocol::item::Slot;
    // rust: let mut components = vec![String::new(); 120];
    // rust: components[118] = "minecraft:sign_text_front".into();
    // rust: components[119] = "minecraft:sign_text_back".into();
    // rust: let items = ["minecraft:air", "minecraft:oak_sign"];
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".to_owned(),
    // rust: Ids::from_names(items.iter().map(|s| s.to_string()).collect()),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".to_owned(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let dynamic = Dynamic::default();
    // rust: let line = |s: &str| Tag::String(s.into());
    // rust: let text = |lines: [&str; 4], color: &str, glowing: i8| {
    // rust: Tag::compound([
    // rust: ("messages", Tag::List(lines.map(line).to_vec())),
    // rust: ("color", Tag::String(color.into())),
    // rust: ("has_glowing_text", Tag::Byte(glowing)),
    // rust: ])
}
    // rust: let front = text(["Line one", "Line two", "", "Line four"], "black", 0);
    // rust: let back = text(["", "back", "", ""], "red", 1);
    // rust: let mut sign = ItemStack::new("minecraft:oak_sign", 1);
    // rust: sign.data_mut()
    // rust: .set_other("minecraft:sign_text_front", Some(front.clone()));
    // rust: sign.data_mut()
    // rust: .set_other("minecraft:sign_text_back", Some(back.clone()));
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| items.iter().position(|i| *i == name).unwrap_or(0) as i32,
    // rust: |_, _| None,
    // rust: &Some(sign),
    // rust: );
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&wire, &mut w);
    // rust: let wire = Slot::read(&mut Reader::new(&w.data)).unwrap().unwrap();
    // rust: let client = from_network(&wire, &builtin, &dynamic);
    // rust: let data = client.data().expect("the sign's components");
    // rust: assert_eq!(data.other("minecraft:sign_text_front"), Some(&front));
    // rust: assert_eq!(data.other("minecraft:sign_text_back"), Some(&back));
}

    /// `minecraft:custom_data` and `minecraft:custom_model_data` are part of
    /// vanilla's DataComponentPatch, so they must cross integrated-server/LAN
    /// inventory sync like any other component (item models read them back:
    /// `item_model.rs`'s `custom_data_at`).
pub fn custom_data_and_custom_model_data_survive_lan_sync() void {
}
//         use horizon_protocol::buf::{Reader, Writer};
//         use horizon_protocol::item::Slot;
    // rust: let mut components = vec![String::new(); component::CUSTOM_MODEL_DATA as usize + 1];
    // rust: components[component::CUSTOM_DATA as usize] = "minecraft:custom_data".into();
    // rust: components[component::CUSTOM_MODEL_DATA as usize] = "minecraft:custom_model_data".into();
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".into(),
    // rust: Ids::from_names(vec!["minecraft:air".into(), "minecraft:stick".into()]),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".into(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let dynamic = Dynamic::default();
    // rust: let mut item = ItemStack::new("minecraft:stick", 1);
    // rust: item.data_mut().set_other(
    // rust: "minecraft:custom_data",
    // rust: Some(Tag::compound([(
    // rust: "mymod_material",
    // rust: Tag::String("ruby".into()),
    // rust: )])),
    // rust: );
    // rust: item.data_mut().set_other(
    // rust: "minecraft:custom_model_data",
    // rust: Some(Tag::compound([
    // rust: ("colors", Tag::List(vec![Tag::Int(0x00a0_a0a0)])),
    // rust: ("flags", Tag::List(vec![Tag::Byte(1)])),
    // rust: ("floats", Tag::List(vec![Tag::Float(1.0f32.to_bits())])),
    // rust: ("strings", Tag::List(vec![Tag::String("mymod:ruby".into())])),
    // rust: ])),
    // rust: );
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| builtin.get("minecraft:item").unwrap().id(name).unwrap(),
    // rust: |_, _| None,
    // rust: &Some(item.clone()),
    // rust: );
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&wire, &mut w);
    // rust: let received = Slot::read(&mut Reader::new(&w.data)).unwrap().unwrap();
    // rust: let back = from_network(&received, &builtin, &dynamic);
    // rust: let other = |s: &ItemStack, id: &str| s.data().and_then(|d| d.other(id)).cloned();
    // rust: assert_eq!(
    // rust: other(&back, "minecraft:custom_data"),
    // rust: other(&item, "minecraft:custom_data")
    // rust: );
    // rust: assert_eq!(
    // rust: other(&back, "minecraft:custom_model_data"),
    // rust: other(&item, "minecraft:custom_model_data")
    // rust: );
}

pub fn rarity_survives_lan_sync_and_enchantment_upgrade() void {
}
//         use horizon_protocol::buf::{Reader, Writer};
//         use horizon_protocol::item::Slot;
//         use horizon_protocol::registry::Ids;
    // rust: let mut components = vec![String::new(); component::RARITY as usize + 1];
    // rust: components[component::RARITY as usize] = "minecraft:rarity".into();
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".into(),
    // rust: Ids::from_names(vec!["minecraft:air".into(), "minecraft:stick".into()]),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".into(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let dynamic = Dynamic::default();
    // rust: let mut item = ItemStack::new("minecraft:stick", 1);
    // rust: item.data_mut()
    // rust: .set_other("minecraft:rarity", Some(Tag::String("epic".into())));
    // rust: item.enchant("minecraft:aqua_affinity", 1);

    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| builtin.get("minecraft:item").unwrap().id(name).unwrap(),
    // rust: |_, _| None,
    // rust: &Some(item.clone()),
    // rust: );
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&wire, &mut w);
    // rust: let received = Slot::read(&mut Reader::new(&w.data)).unwrap().unwrap();
    // rust: assert_eq!(
    // rust: received.component(component::RARITY),
    // rust: Some(&Component::Int(3))
    // rust: );

    // rust: let back = from_network(&received, &builtin, &dynamic);
    // rust: assert_eq!(
    // rust: back.data().and_then(|d| d.other("minecraft:rarity")),
    // rust: Some(&Tag::String("epic".into()))
    // rust: );
    // rust: assert_eq!(crate::item_tooltip::rarity(&back, "common"), "epic");
}

    /// A cobblestone stack of 20 whose own limit is 16, plus a custom-data
    /// marker, comes back with the same count, limit and marker. Removing the
    /// component is a `!minecraft:max_stack_size` patch.
pub fn a_stack_keeps_its_max_stack_size_across_the_wire() void {
}
//         use horizon_protocol::buf::{Reader, Writer};
//         use horizon_protocol::item::Slot;
    // rust: let mut components = vec![String::new(); 2];
    // rust: components[component::CUSTOM_DATA as usize] = "minecraft:custom_data".into();
    // rust: components[component::MAX_STACK_SIZE as usize] = "minecraft:max_stack_size".into();
    // rust: let builtin = Builtin {
    // rust: registries: [
    // rust: (
    // rust: "minecraft:item".into(),
    // rust: Ids::from_names(vec!["minecraft:air".into(), "minecraft:cobblestone".into()]),
    // rust: ),
    // rust: (
    // rust: "minecraft:data_component_type".into(),
    // rust: Ids::from_names(components),
    // rust: ),
    // rust: ]
    // rust: .into(),
}
    // rust: let dynamic = Dynamic::default();
    // rust: let marker = Tag::compound([("marker", Tag::Byte(1))]);
    // rust: let mut item = ItemStack::new("minecraft:cobblestone", 20);
    // rust: item.data_mut()
    // rust: .set_other("minecraft:max_stack_size", Some(Tag::Int(16)));
    // rust: item.data_mut()
    // rust: .set_other("minecraft:custom_data", Some(marker.clone()));
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| builtin.get("minecraft:item").unwrap().id(name).unwrap(),
    // rust: |_, _| None,
    // rust: &Some(item),
    // rust: )
    // rust: .unwrap();
    // rust: let mut w = Writer::new();
    // rust: Slot::write(&Some(wire), &mut w);
    // rust: let received = Slot::read(&mut Reader::new(&w.data)).unwrap().unwrap();
    // rust: assert_eq!(received.count, 20);
    // rust: assert_eq!(
    // rust: received.component(component::MAX_STACK_SIZE),
    // rust: Some(&Component::Int(16))
    // rust: );
    // rust: let back = from_network(&received, &builtin, &dynamic);
    // rust: assert_eq!(back.count, 20);
    // rust: assert_eq!(
    // rust: back.data()
    // rust: .and_then(|d| d.other("minecraft:max_stack_size")),
    // rust: Some(&Tag::Int(16))
    // rust: );
    // rust: assert_eq!(
    // rust: back.data().and_then(|d| d.other("minecraft:custom_data")),
    // rust: Some(&marker)
    // rust: );

    // rust: let mut cleared = ItemStack::new("minecraft:cobblestone", 1);
    // rust: cleared.data_mut().set_other(
    // rust: "!minecraft:max_stack_size",
    // rust: Some(Tag::Compound(Default::default())),
    // rust: );
    // rust: let wire = crate::lan::guest::stack_to_network(
    // rust: |name| builtin.get("minecraft:item").unwrap().id(name).unwrap(),
    // rust: |_, _| None,
    // rust: &Some(cleared),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(wire.removed.contains(&component::MAX_STACK_SIZE));
    // rust: let back = from_network(&wire, &builtin, &dynamic);
    // rust: assert!(
    // rust: back.data()
    // rust: .is_some_and(|d| d.other("!minecraft:max_stack_size").is_some())
    // rust: );
}
}
