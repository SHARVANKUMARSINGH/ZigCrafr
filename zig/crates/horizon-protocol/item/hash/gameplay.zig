//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_gameplay
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The data components that tune an item's behaviour (`food`, `consumable`,
//! `tool`, `equippable`, `attribute_modifiers`, ...), from their stream form to
//! the codec form. See [`super::raw`] for the rest.
// use super::*;
// use crate::buf::Reader;
// use horizon_world::snbt_text::to_snbt;

    // rust: const USE_ANIMATION: [&str; 12] = [
    // rust: "none",
    // rust: "eat",
    // rust: "drink",
    // rust: "block",
    // rust: "bow",
    // rust: "trident",
    // rust: "crossbow",
    // rust: "spyglass",
    // rust: "toot_horn",
    // rust: "brush",
    // rust: "bundle",
    // rust: "spear",
    // rust: ];
pub const SWING: [[]const u8; 3] = ["none", "whack", "stab"];
/// `EquipmentSlot` by `id` (not declaration order).
    // rust: const SLOT: [&str; 8] = [
    // rust: "mainhand", "feet", "legs", "chest", "head", "offhand", "body", "saddle",
    // rust: ];
/// `EquipmentSlotGroup` by id.
    // rust: const SLOT_GROUP: [&str; 11] = [
    // rust: "any", "mainhand", "offhand", "hand", "feet", "legs", "chest", "head", "armor", "body",
    // rust: "saddle",
    // rust: ];
pub const OPERATION: [[]const u8; 3] = ["add_value", "add_multiplied_base", "add_multiplied_total"];

pub fn int(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.varint().ok()
}
pub fn float(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.f32().ok()
}
pub fn boolean(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.bool().ok()
}
pub fn ident(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(string(&r.string(32767).ok()?))
}
/// `Codec.xxx.optionalFieldOf(name, default)` for a float.
pub fn float_or(rec: RecordHash, name: []const u8, v: f32, default: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: or_default(
    // rust: rec,
    // rust: name,
    // rust: v.to_bits(),
    // rust: default.to_bits(),
    // rust: HashOps::create_f32(v),
    // rust: )
}
pub fn int_or(rec: RecordHash, name: []const u8, v: i32, default: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: or_default(rec, name, v, default, HashOps::create_int(v))
}
pub fn bool_or(rec: RecordHash, name: []const u8, v: bool, default: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: or_default(rec, name, v, default, HashOps::create_boolean(v))
}
    // rust: fn optional<T>(
    // rust: r: &mut Reader,
    // rust: element: impl FnOnce(&mut Reader) -> Option<T>,
    // rust: ) -> Option<Option<T>> {
    // rust: if boolean(r)? {
    // rust: Some(Some(element(r)?))
    // rust: } else {
    // rust: Some(None)
}
}
    // rust: fn list<T>(r: &mut Reader, mut element: impl FnMut(&mut Reader) -> Option<T>) -> Option<Vec<T>> {
    // rust: let n = r.count(r.remaining()).ok()?;
    // rust: let mut out = Vec::with_capacity(n);
    // rust: for _ in 0..n {
    // rust: out.push(element(r)?);
}
    // rust: Some(out)
}

/// A `SoundEvent` holder: the codec form and, for a reference, its name (what a
/// field default compares against).
    // rust: pub(super) struct Sound {
    // rust: pub(super) code: HashCode,
    // rust: name: Option<String>,
}
/// `SoundEvent.STREAM_CODEC`: 0 and the event itself (`DIRECT_CODEC`: `sound_id`
/// and an optional `range`), or the registry id plus one.
    // rust: pub(super) fn sound(r: &mut Reader, names: &dyn Names) -> Option<Sound> {
    // rust: match int(r)? {
    // rust: 0 => {
    // rust: let id = ident(r)?;
    // rust: let range = optional(r, float)?;
    // rust: Some(Sound {
    // rust: code: RecordHash::new()
    // rust: .field("sound_id", id)
    // rust: .optional("range", range.map(HashOps::create_f32))
    // rust: .build(),
    // rust: name: None,
    // rust: })
}
    // rust: id => {
    // rust: let name = names.name("minecraft:sound_event", id - 1)?;
    // rust: Some(Sound {
    // rust: code: string(&name),
    // rust: name: Some(name),
    // rust: })
}
}
}
/// `SoundEvent.CODEC.optionalFieldOf(name, default)`.
pub fn sound_or(rec: RecordHash, name: []const u8, s: Sound, default: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if s.name.as_deref() == Some(default) {
    // rust: rec
    // rust: } else {
    // rust: rec.field(name, s.code)
}
}
/// `ByteBufCodecs.holderSet`: 0 and a tag, or the size plus one and the ids.
/// `HolderSetCodec` writes `#tag`, a lone entry as itself, else a list.
pub fn holder_set(registry: []const u8, names: *dyn Names, r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match int(r)? {
    // rust: 0 => Some(string(&format!("#{}", r.string(32767).ok()?))),
    // rust: n => {
    // rust: let n = usize::try_from(n - 1)
    // rust: .ok()
    // rust: .filter(|n| *n <= r.remaining())?;
    // rust: let mut ids = Vec::with_capacity(n);
    // rust: for _ in 0..n {
    // rust: ids.push(entry(names, registry, int(r)?)?);
}
    // rust: Some(if let [only] = ids[..] {
    // rust: only
    // rust: } else {
    // rust: HashOps::create_list(ids)
    // rust: })
}
}
}
/// `ByteBufCodecs.holderRegistry`.
pub fn holder(registry: []const u8, names: *dyn Names, r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: entry(names, registry, int(r)?)
}

/// `ConsumeEffect.CODEC`: a `type` field and the type's fields.
pub fn consume_effect(r: *mut Reader, names: *dyn Names) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = int(r)?;
    // rust: let rec = RecordHash::new();
    // rust: Some(
    // rust: match kind {
    // rust: 0 => {
    // rust: let effects = list(r, |r| super::raw::mob_effect(r, names))?;
    // rust: let probability = float(r)?;
    // rust: float_or(
    // rust: rec.field("type", string("minecraft:apply_effects"))
    // rust: .field("effects", HashOps::create_list(effects)),
    // rust: "probability",
    // rust: probability,
    // rust: 1.0,
    // rust: )
}
    // rust: 1 => rec
    // rust: .field("type", string("minecraft:remove_effects"))
    // rust: .field("effects", holder_set("minecraft:mob_effect", names, r)?),
    // rust: 2 => rec.field("type", string("minecraft:clear_all_effects")),
    // rust: 3 => {
    // rust: let diameter = float(r)?;
    // rust: let particles = boolean(r)?;
    // rust: bool_or(
    // rust: float_or(
    // rust: rec.field("type", string("minecraft:teleport_randomly")),
    // rust: "diameter",
    // rust: diameter,
    // rust: 16.0,
    // rust: ),
    // rust: "directional_particles",
    // rust: particles,
    // rust: true,
    // rust: )
}
    // rust: 4 => rec
    // rust: .field("type", string("minecraft:play_sound"))
    // rust: .field("sound", sound(r, names)?.code),
    // rust: _ => return None,
}
    // rust: .build(),
    // rust: )
}

/// `SwingAnimation`: `DEFAULT` is whack for 6 ticks.
pub fn swing(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = int(r)?;
    // rust: let duration = int(r)?;
    // rust: let rec = or_default(RecordHash::new(), "type", kind, 1, pick(&SWING, kind)?);
    // rust: Some(int_or(rec, "duration", duration, 6).build())
}

/// `ResolvableInt` / `ResolvableFloat`: a constant, or a context provider's key.
pub fn resolvable(r: *mut Reader, constant: fn(*mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if boolean(r)? { constant(r) } else { ident(r) }
}
pub fn fixed_int(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(HashOps::create_int(r.i32().ok()?))
}
pub fn fixed_float(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(HashOps::create_f32(float(r)?))
}

/// `KineticWeapon.Condition`.
pub fn kinetic_condition(r: *mut Reader) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ticks = int(r)?;
    // rust: let speed = float(r)?;
    // rust: let relative = float(r)?;
    // rust: let rec = RecordHash::new().field("max_duration_ticks", HashOps::create_int(ticks));
    // rust: let rec = float_or(rec, "min_speed", speed, 0.0);
    // rust: Some(float_or(rec, "min_relative_speed", relative, 0.0).build())
}

/// The `Codec.BOOL` fields of the component predicates' codecs
/// (`FireworkPredicate`, `WrittenBookPredicate`, `MobEffectInstancePredicate`):
/// they travel as NBT bytes and hash as booleans. The text components inside a
/// written book's page predicates add [`TEXT_BOOLS`].
    // rust: pub(super) const PREDICATE_BOOLS: [&str; 12] = [
    // rust: "has_twinkle",
    // rust: "has_trail",
    // rust: "resolved",
    // rust: "ambient",
    // rust: "visible",
    // rust: "bold",
    // rust: "italic",
    // rust: "underlined",
    // rust: "strikethrough",
    // rust: "obfuscated",
    // rust: "interpret",
    // rust: "plain",
    // rust: ];
/// `DataComponentPredicate.STREAM_CODEC`: each entry is a type (a predicate
/// type, or a component type for `AnyValue`) and the predicate as the NBT its
/// `CODEC` encodes (`fromCodecWithRegistries`), hashed as the map
/// `DataComponentPredicate.CODEC` (`Codec.dispatchedMap`) writes.
pub fn partial_predicate(r: *mut Reader, names: *dyn Names) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = if boolean(r)? {
    // rust: "minecraft:data_component_predicate_type"
    // rust: } else {
    // rust: "minecraft:data_component_type"
}
    // rust: let key = entry(names, registry, int(r)?)?;
    // rust: let tag = r.nbt().ok()?;
    // The nested `components` of an item predicate (`container`,
    // `bundle_contents`) are component values as NBT: `exact` hashes them by
    // each component's codec.
    // rust: Some((key, super::exact::predicate(&tag, names)?))
}

/// `BlockPredicate.STREAM_CODEC` as `BlockPredicate.CODEC` writes it.
pub fn block_predicate(r: *mut Reader, names: *dyn Names) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let blocks = optional(r, |r| holder_set("minecraft:block", names, r))?;
    // StatePropertiesPredicate: a name and an exact value or a (min, max) range.
    // rust: let state = optional(r, |r| {
    // rust: let props = list(r, |r| {
    // rust: let name = string(&r.string(32767).ok()?);
    // rust: let matcher = if boolean(r)? {
    // rust: string(&r.string(32767).ok()?)
    // rust: } else {
    // rust: let min = optional(r, |r| Some(string(&r.string(32767).ok()?)))?;
    // rust: let max = optional(r, |r| Some(string(&r.string(32767).ok()?)))?;
    // rust: RecordHash::new()
    // rust: .optional("min", min)
    // rust: .optional("max", max)
    // rust: .build()
}
    // rust: Some((name, matcher))
    // rust: })?;
    // rust: Some(HashOps::create_map(props))
    // rust: })?;
    // NbtPredicate: `TagParser.LENIENT_CODEC` encodes with its flattened codec,
    // the tag's SNBT string.
    // rust: let nbt = optional(r, |r| match r.nbt().ok()? {
    // rust: tag @ horizon_world::nbt::Tag::Compound(_) => Some(string(&to_snbt(&tag))),
    // rust: _ => None,
    // rust: })?;
    // DataComponentExactPredicate: the expected components, by type name.
    // rust: let exact = list(r, |r| {
    // rust: let kind = int(r)?;
    // rust: let name = entry(names, "minecraft:data_component_type", kind)?;
    // rust: let value = Component::read(kind, r).ok()?.code(kind, names)?;
    // rust: Some((name, value))
    // rust: })?;
    // DataComponentPredicate: the partial matchers (at most 64).
    // rust: let partial = list(r, |r| partial_predicate(r, names))?;
    // rust: if partial.len() > 64 {
    // rust: return None;
}
    // rust: let rec = RecordHash::new()
    // rust: .optional("blocks", blocks)
    // rust: .optional("state", state)
    // rust: .optional("nbt", nbt);
    // rust: let rec = if exact.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field("components", HashOps::create_map(exact))
}
    // rust: Some(
    // rust: if partial.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field("predicates", HashOps::create_map(partial))
}
    // rust: .build(),
    // rust: )
}

/// The hash of component `kind` from its stream, or `None`.
    // rust: pub(super) fn code(kind: i32, r: &mut Reader, names: &dyn Names) -> Option<HashCode> {
    // rust: Some(match kind {
        // UseEffects: canSprint, interactVibrations, speedMultiplier.
    // rust: 5 => {
    // rust: let (sprint, vibrations, speed) = (boolean(r)?, boolean(r)?, float(r)?);
    // rust: let rec = bool_or(RecordHash::new(), "can_sprint", sprint, false);
    // rust: let rec = bool_or(rec, "interact_vibrations", vibrations, true);
    // rust: float_or(rec, "speed_multiplier", speed, 0.2).build()
}
        // ItemAttributeModifiers: attribute, modifier, slot, display.
    // rust: 16 => HashOps::create_list(list(r, |r| {
    // rust: let attribute = holder("minecraft:attribute", names, r)?;
    // rust: let id = ident(r)?;
    // rust: let amount = r.f64().ok()?;
    // rust: let operation = pick(&OPERATION, int(r)?)?;
    // rust: let slot = int(r)?;
    // rust: let rec = RecordHash::new()
    // rust: .field("type", attribute)
    // rust: .field("id", id)
    // rust: .field("amount", HashOps::create_double(amount.to_bits()))
    // rust: .field("operation", operation);
    // rust: let rec = or_default(rec, "slot", slot, 0, pick(&SLOT_GROUP, slot)?);
    // rust: Some(
    // rust: match int(r)? {
    // rust: 0 => rec,
    // rust: 1 => rec.field(
    // rust: "display",
    // rust: RecordHash::new().field("type", string("hidden")).build(),
    // rust: ),
    // rust: 2 => rec.field(
    // rust: "display",
    // rust: RecordHash::new()
    // rust: .field("type", string("override"))
    // rust: .field("value", text(&r.nbt().ok()?))
    // rust: .build(),
    // rust: ),
    // rust: _ => return None,
}
    // rust: .build(),
    // rust: )
    // rust: })?),
        // FoodProperties.DIRECT_CODEC: nutrition, saturation, canAlwaysEat.
    // rust: 23 => {
    // rust: let nutrition = int(r)?;
    // rust: let saturation = float(r)?;
    // rust: bool_or(
    // rust: RecordHash::new()
    // rust: .field("nutrition", HashOps::create_int(nutrition))
    // rust: .field("saturation", HashOps::create_f32(saturation)),
    // rust: "can_always_eat",
    // rust: boolean(r)?,
    // rust: false,
    // rust: )
    // rust: .build()
}
        // Consumable: consumeSeconds, animation, sound, hasConsumeParticles, effects.
    // rust: 24 => {
    // rust: let seconds = float(r)?;
    // rust: let animation = int(r)?;
    // rust: let snd = sound(r, names)?;
    // rust: let particles = boolean(r)?;
    // rust: let effects = list(r, |r| consume_effect(r, names))?;
    // rust: let rec = float_or(RecordHash::new(), "consume_seconds", seconds, 1.6);
    // rust: let rec = or_default(
    // rust: rec,
    // rust: "animation",
    // rust: animation,
    // rust: 1,
    // rust: pick(&USE_ANIMATION, animation)?,
    // rust: );
    // rust: let rec = sound_or(rec, "sound", snd, "minecraft:entity.generic.eat");
    // rust: let rec = bool_or(rec, "has_consume_particles", particles, true);
    // rust: if effects.is_empty() {
    // rust: rec
    // rust: } else {
    // rust: rec.field("on_consume_effects", HashOps::create_list(effects))
}
    // rust: .build()
}
        // UseCooldown: seconds, cooldownGroup.
    // rust: 26 => {
    // rust: let seconds = float(r)?;
    // rust: RecordHash::new()
    // rust: .field("seconds", HashOps::create_f32(seconds))
    // rust: .optional("cooldown_group", optional(r, ident)?)
    // rust: .build()
}
        // DamageResistant, Repairable: a holder set.
    // rust: 27 => RecordHash::new()
    // rust: .field("types", holder_set("minecraft:damage_type", names, r)?)
    // rust: .build(),
    // rust: 33 => RecordHash::new()
    // rust: .field("items", holder_set("minecraft:item", names, r)?)
    // rust: .build(),
        // Tool: rules, defaultMiningSpeed, damagePerBlock, canDestroyBlocksInCreative.
    // rust: 28 => {
    // rust: let rules = list(r, |r| {
    // rust: let blocks = holder_set("minecraft:block", names, r)?;
    // rust: let speed = optional(r, float)?;
    // rust: let drops = optional(r, boolean)?;
    // rust: Some(
    // rust: RecordHash::new()
    // rust: .field("blocks", blocks)
    // rust: .optional("speed", speed.map(HashOps::create_f32))
    // rust: .optional("correct_for_drops", drops.map(HashOps::create_boolean))
    // rust: .build(),
    // rust: )
    // rust: })?;
    // rust: let (mining, damage, creative) = (float(r)?, int(r)?, boolean(r)?);
    // rust: let rec = RecordHash::new().field("rules", HashOps::create_list(rules));
    // rust: let rec = float_or(rec, "default_mining_speed", mining, 1.0);
    // rust: let rec = int_or(rec, "damage_per_block", damage, 1);
    // rust: bool_or(rec, "can_destroy_blocks_in_creative", creative, true).build()
}
        // Weapon: itemDamagePerAttack, disableBlockingForSeconds.
    // rust: 29 => {
    // rust: let damage = int(r)?;
    // rust: let seconds = float(r)?;
    // rust: float_or(
    // rust: int_or(RecordHash::new(), "item_damage_per_attack", damage, 1),
    // rust: "disable_blocking_for_seconds",
    // rust: seconds,
    // rust: 0.0,
    // rust: )
    // rust: .build()
}
        // Equippable.
    // rust: 32 => {
    // rust: let slot = pick(&SLOT, int(r)?)?;
    // rust: let equip = sound(r, names)?;
    // rust: let asset = optional(r, ident)?;
    // rust: let overlay = optional(r, ident)?;
    // rust: let entities = optional(r, |r| holder_set("minecraft:entity_type", names, r))?;
    // rust: let flags = [
    // rust: boolean(r)?,
    // rust: boolean(r)?,
    // rust: boolean(r)?,
    // rust: boolean(r)?,
    // rust: boolean(r)?,
    // rust: ];
    // rust: let shearing = sound(r, names)?;
    // rust: let rec = RecordHash::new().field("slot", slot);
    // rust: let rec = sound_or(
    // rust: rec,
    // rust: "equip_sound",
    // rust: equip,
    // rust: "minecraft:item.armor.equip_generic",
    // rust: )
    // rust: .optional("asset_id", asset)
    // rust: .optional("camera_overlay", overlay)
    // rust: .optional("allowed_entities", entities);
    // rust: let rec = bool_or(rec, "dispensable", flags[0], true);
    // rust: let rec = bool_or(rec, "swappable", flags[1], true);
    // rust: let rec = bool_or(rec, "damage_on_hurt", flags[2], true);
    // rust: let rec = bool_or(rec, "equip_on_interact", flags[3], false);
    // rust: let rec = bool_or(rec, "can_be_sheared", flags[4], false);
    // rust: sound_or(
    // rust: rec,
    // rust: "shearing_sound",
    // rust: shearing,
    // rust: "minecraft:item.shears.snip",
    // rust: )
    // rust: .build()
}
        // DeathProtection: deathEffects.
    // rust: 36 => {
    // rust: let effects = list(r, |r| consume_effect(r, names))?;
    // rust: if effects.is_empty() {
    // rust: RecordHash::new()
    // rust: } else {
    // rust: RecordHash::new().field("death_effects", HashOps::create_list(effects))
}
    // rust: .build()
}
        // BlocksAttacks.
    // rust: 37 => {
    // rust: let delay = float(r)?;
    // rust: let scale = float(r)?;
    // rust: let reductions = list(r, |r| {
    // rust: let angle = float(r)?;
    // rust: let types = optional(r, |r| holder_set("minecraft:damage_type", names, r))?;
    // rust: let (base, factor) = (float(r)?, float(r)?);
    // rust: Some((angle, types, base, factor))
    // rust: })?;
    // rust: let item = [float(r)?, float(r)?, float(r)?];
    // rust: let bypassed = optional(r, |r| holder_set("minecraft:damage_type", names, r))?;
    // rust: let block = optional(r, |r| sound(r, names))?;
    // rust: let disabled = optional(r, |r| sound(r, names))?;
    // rust: let rec = float_or(RecordHash::new(), "block_delay_seconds", delay, 0.0);
    // rust: let rec = float_or(rec, "disable_cooldown_scale", scale, 1.0);
            // The default is one reduction: 90 degrees, any damage, base 0, factor 1.
    // rust: let is_default = matches!(
    // rust: &reductions[..],
    // rust: [(a, None, b, f)] if a.to_bits() == 90f32.to_bits() && *b == 0.0 && *f == 1.0
    // rust: );
    // rust: let rec = if is_default {
    // rust: rec
    // rust: } else {
    // rust: rec.field(
    // rust: "damage_reductions",
    // rust: HashOps::create_list(reductions.into_iter().map(
    // rust: |(angle, types, base, factor)| {
    // rust: float_or(RecordHash::new(), "horizontal_blocking_angle", angle, 90.0)
    // rust: .optional("type", types)
    // rust: .field("base", HashOps::create_f32(base))
    // rust: .field("factor", HashOps::create_f32(factor))
    // rust: .build()
    // rust: },
    // rust: )),
    // rust: )
}
    // rust: let rec = if item.map(f32::to_bits) == [1.0f32, 0.0, 1.0].map(f32::to_bits) {
    // rust: rec
    // rust: } else {
    // rust: rec.field(
    // rust: "item_damage",
    // rust: RecordHash::new()
    // rust: .field("threshold", HashOps::create_f32(item[0]))
    // rust: .field("base", HashOps::create_f32(item[1]))
    // rust: .field("factor", HashOps::create_f32(item[2]))
    // rust: .build(),
    // rust: )
}
    // rust: rec.optional("bypassed_by", bypassed)
    // rust: .optional("block_sound", block.map(|s| s.code))
    // rust: .optional("disabled_sound", disabled.map(|s| s.code))
    // rust: .build()
}
        // PiercingWeapon: dealsKnockback, dismounts, sound, hitSound.
    // rust: 38 => {
    // rust: let (knockback, dismounts) = (boolean(r)?, boolean(r)?);
    // rust: let snd = optional(r, |r| sound(r, names))?;
    // rust: let hit = optional(r, |r| sound(r, names))?;
    // rust: bool_or(
    // rust: bool_or(RecordHash::new(), "deals_knockback", knockback, true),
    // rust: "dismounts",
    // rust: dismounts,
    // rust: false,
    // rust: )
    // rust: .optional("sound", snd.map(|s| s.code))
    // rust: .optional("hit_sound", hit.map(|s| s.code))
    // rust: .build()
}
        // KineticWeapon.
    // rust: 39 => {
    // rust: let (cooldown, delay) = (int(r)?, int(r)?);
    // rust: let dismount = optional(r, kinetic_condition)?;
    // rust: let knockback = optional(r, kinetic_condition)?;
    // rust: let damage = optional(r, kinetic_condition)?;
    // rust: let (forward, multiplier) = (float(r)?, float(r)?);
    // rust: let snd = optional(r, |r| sound(r, names))?;
    // rust: let hit = optional(r, |r| sound(r, names))?;
    // rust: let rec = int_or(RecordHash::new(), "contact_cooldown_ticks", cooldown, 10);
    // rust: let rec = int_or(rec, "delay_ticks", delay, 0)
    // rust: .optional("dismount_conditions", dismount)
    // rust: .optional("knockback_conditions", knockback)
    // rust: .optional("damage_conditions", damage);
    // rust: let rec = float_or(rec, "forward_movement", forward, 0.0);
    // rust: float_or(rec, "damage_multiplier", multiplier, 1.0)
    // rust: .optional("sound", snd.map(|s| s.code))
    // rust: .optional("hit_sound", hit.map(|s| s.code))
    // rust: .build()
}
    // rust: 40 | 41 => swing(r)?,
        // `JukeboxSong.CODEC` is a `RegistryFixedCodec`: a direct song cannot be
        // encoded (vanilla's client would throw), so only a reference hashes.
    // rust: 66 => match int(r)? {
    // rust: 0 => return None,
    // rust: id => entry(names, "minecraft:jukebox_song", id - 1)?,
    // rust: },
    // rust: 67 => holder_set("minecraft:banner_pattern", names, r)?,
    // rust: 83 => sound(r, names)?.code,
    // rust: 84 => RecordHash::new()
    // rust: .field("layers", resolvable(r, fixed_int)?)
    // rust: .build(),
        // CookingFuel (burnTime, speedMultiplier), BrewingFuel (uses, speedMultiplier).
    // rust: 85 | 86 => {
    // rust: let first = resolvable(r, fixed_int)?;
    // rust: let speed = resolvable(r, fixed_float)?;
    // rust: RecordHash::new()
    // rust: .field(if kind == 85 { "burn_time" } else { "uses" }, first)
    // rust: .field("speed_multiplier", speed)
    // rust: .build()
}
        // MobVisibility: targetingEntityTypes, visibility.
    // rust: 87 => {
    // rust: let types = holder_set("minecraft:entity_type", names, r)?;
    // rust: RecordHash::new()
    // rust: .field("targeting_entity_types", types)
    // rust: .field("visibility", HashOps::create_f32(float(r)?))
    // rust: .build()
}
        // AdventureModePredicate (can_place_on, can_break): `compactListCodec`
        // writes one predicate as itself and `nonEmptyList` refuses none.
    // rust: 14 | 15 => {
    // rust: let mut predicates = list(r, |r| block_predicate(r, names))?;
    // rust: match predicates.len() {
    // rust: 0 => return None,
    // rust: 1 => predicates.remove(0),
    // rust: _ => HashOps::create_list(predicates),
}
}
        // UseRemainder: one template.
    // rust: 25 => super::raw::template_code(r, names)?,
    // rust: _ => return None,
    // rust: })
}
