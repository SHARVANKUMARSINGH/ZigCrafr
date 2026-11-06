//! Transpiled from Horizon Rust crate
package horizon_protocol_skip

import "core:fmt"
import "core:mem"
import "core:math"

// Reading past the data components Horizon doesn't interpret: each
// function consumes exactly what its vanilla StreamCodec writes
// (DataComponents' `networkSynchronized` codecs; a component without one
// goes as its persistent Codec's NBT, `ByteBufCodecs.fromCodecWithRegistries`).
// Item data has no length prefix, so a component read short or long makes
// everything after it unreadable.
// use super::{Component, Nested, Template};
// use crate::{
    // rust: Error, Result,
    // rust: buf::{Codec, Reader},
}

    // rust: type Read = fn(&mut Reader) -> Result<()>;

// DataComponents' registry order (26.3) for the ids `Component::read`
// doesn't decode itself.
    // rust: pub(super) fn component(kind: i32, r: &mut Reader) -> Result<()> {
    // rust: match kind {
        // Unit.STREAM_CODEC: glider, waxed.
    // rust: 34 | 120 => Ok(()),
        // Components without a network codec go as their NBT: intangible_projectile,
        // map_decorations, debug_stick_state, recipes, lock, container_loot.
    // rust: 22 | 49 | 59 | 68 | 81 | 82 => nbt(r),
        // A VarInt (VAR_INT, an idMapper, a registry or holderRegistry id): damage_type,
        // enchantable, additional_trade_cost, block_transformer, villager_food, dye,
        // ominous_bottle_amplifier, base_color, the mob variants and colours, the pottery
        // pattern and cushion_color.
    // rust: 8 | 31 | 42 | 43 | 44 | 46 | 65 | 75 | 88..=108 | 110..=117 | 121 => varint(r),
        // FLOAT: minimum_attack_charge, potion_duration_scale.
    // rust: 7 | 54 => f32(r),
        // Identifier.STREAM_CODEC: tooltip_style, note_block_sound.
    // rust: 35 | 73 => ident(r),
        // UseEffects: canSprint, interactVibrations, speedMultiplier.
    // rust: 5 => {
    // rust: r.bool()?;
    // rust: r.bool()?;
    // rust: f32(r)
}
        // AdventureModePredicate: can_place_on, can_break.
    // rust: 14 | 15 => list(r, block_predicate),
    // rust: 16 => list(r, attribute_modifier),
        // FoodProperties.DIRECT_STREAM_CODEC: nutrition, saturation, canAlwaysEat.
    // rust: 23 => {
    // rust: varint(r)?;
    // rust: f32(r)?;
    // rust: boolean(r)
}
        // Consumable: consumeSeconds, animation, sound, hasConsumeParticles, onConsumeEffects.
    // rust: 24 => {
    // rust: f32(r)?;
    // rust: varint(r)?;
    // rust: sound(r)?;
    // rust: boolean(r)?;
    // rust: list(r, consume_effect)
}
        // UseRemainder, SulfurCubeContent: one template.
    // rust: 25 | 80 => template(r),
        // UseCooldown: seconds, cooldownGroup.
    // rust: 26 => {
    // rust: f32(r)?;
    // rust: optional(r, ident)
}
        // DamageResistant, Repairable, provides_banner_patterns: a holder set.
    // rust: 27 | 33 | 67 => holder_set(r),
    // rust: 28 => tool(r),
        // Weapon: itemDamagePerAttack, disableBlockingForSeconds.
    // rust: 29 => {
    // rust: varint(r)?;
    // rust: f32(r)
}
    // rust: 32 => equippable(r),
        // DeathProtection: deathEffects.
    // rust: 36 => list(r, consume_effect),
    // rust: 37 => blocks_attacks(r),
        // PiercingWeapon: dealsKnockback, dismounts, sound, hitSound.
    // rust: 38 => {
    // rust: boolean(r)?;
    // rust: boolean(r)?;
    // rust: optional(r, sound)?;
    // rust: optional(r, sound)
}
    // rust: 39 => kinetic_weapon(r),
        // SwingAnimation: type, duration.
    // rust: 40 | 41 => {
    // rust: varint(r)?;
    // rust: varint(r)
}
        // BundleContents: templates.
    // rust: 52 => list(r, template),
        // SuspiciousStewEffects: effect, duration.
    // rust: 55 => list(r, |r| {
    // rust: varint(r)?;
    // rust: varint(r)
    // rust: }),
        // ArmorTrim: material, then Holder<TrimPattern> (assetId, description, decal).
    // rust: 58 => {
    // rust: trim_material(r)?;
    // rust: holder(r, |r| {
    // rust: ident(r)?;
    // rust: nbt(r)?;
    // rust: boolean(r)
    // rust: })
}
        // TypedEntityData (entity_data, block_entity_data): the type id, then a compound.
    // rust: 60 | 62 => {
    // rust: varint(r)?;
    // rust: nbt(r)
}
        // CustomData: bucket_entity_data.
    // rust: 61 => nbt(r),
        // InstrumentComponent: Holder<Instrument> (soundEvent, useDuration, range,
        // durabilityDamage, description).
    // rust: 63 => holder(r, |r| {
    // rust: sound(r)?;
    // rust: f32(r)?;
    // rust: f32(r)?;
    // rust: varint(r)?;
    // rust: nbt(r)
    // rust: }),
    // rust: 64 => trim_material(r),
        // JukeboxPlayable: Holder<JukeboxSong> (soundEvent, description, lengthInSeconds,
        // comparatorOutput).
    // rust: 66 => holder(r, |r| {
    // rust: sound(r)?;
    // rust: nbt(r)?;
    // rust: f32(r)?;
    // rust: varint(r)
    // rust: }),
        // LodestoneTracker: target (GlobalPos: dimension, BlockPos), tracked.
    // rust: 69 => {
    // rust: optional(r, |r| {
    // rust: ident(r)?;
    // rust: r.i64().map(drop)
    // rust: })?;
    // rust: boolean(r)
}
    // rust: 70 => firework_explosion(r),
        // Fireworks: flightDuration, explosions.
    // rust: 71 => {
    // rust: varint(r)?;
    // rust: list(r, firework_explosion)
}
        // BannerPatternLayers: Holder<BannerPattern> (assetId, translationKey), colour.
    // rust: 74 => list(r, |r| {
    // rust: holder(r, |r| {
    // rust: ident(r)?;
    // rust: string(r)
    // rust: })?;
    // rust: varint(r)
    // rust: }),
        // PotDecorations: back, left, right, front.
    // rust: 76 => (0..4).try_for_each(|_| optional(r, template)),
        // ItemContainerContents: optional templates.
    // rust: 77 => list(r, |r| optional(r, template)),
        // BlockItemStateProperties: a string to string map.
    // rust: 78 => list(r, |r| {
    // rust: string(r)?;
    // rust: string(r)
    // rust: }),
        // Bees: Occupant (entity type and data, ticksInHive, minTicksInHive).
    // rust: 79 => list(r, |r| {
    // rust: varint(r)?;
    // rust: nbt(r)?;
    // rust: varint(r)?;
    // rust: varint(r)
    // rust: }),
    // rust: 83 => sound(r),
        // Compostable: layers.
    // rust: 84 => resolvable(r, i32),
        // CookingFuel (burnTime, speedMultiplier), BrewingFuel (uses, speedMultiplier).
    // rust: 85 | 86 => {
    // rust: resolvable(r, i32)?;
    // rust: resolvable(r, f32)
}
        // MobVisibility: targetingEntityTypes, visibility.
    // rust: 87 => {
    // rust: holder_set(r)?;
    // rust: f32(r)
}
        // Holder<PaintingVariant>: width, height, assetId, title, author.
    // rust: 109 => holder(r, |r| {
    // rust: varint(r)?;
    // rust: varint(r)?;
    // rust: ident(r)?;
    // rust: optional(r, nbt)?;
    // rust: optional(r, nbt)
    // rust: }),
        // SignText: four messages, four optional filtered ones, colour, hasGlowingText.
    // rust: 118 | 119 => {
    // rust: (0..4).try_for_each(|_| nbt(r))?;
    // rust: optional(r, |r| (0..4).try_for_each(|_| nbt(r)))?;
    // rust: varint(r)?;
    // rust: boolean(r)
}
    // rust: other => Err(Error::new(format!("unsupported item component {other}"))),
}
}

boolean :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.bool().map(drop)
}
varint :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.varint().map(drop)
}
f32 :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.f32().map(drop)
}
i32 :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.i32().map(drop)
}
// ByteBufCodecs.STRING_UTF8.
string :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.string(32767).map(drop)
}
// Identifier.STREAM_CODEC, ResourceKey.streamCodec.
ident :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: string(r)
}
// A text component or compound (fromCodecWithRegistries, COMPOUND_TAG).
nbt :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.nbt().map(drop)
}
template :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Template::read(r).map(drop)
}
// ByteBufCodecs.optional: a flag, then the value.
optional :: proc(r: ^Reader, value: Read) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if r.bool()? { value(r) } else { Ok(()) }
}
// ByteBufCodecs.list and map: a VarInt count, then the elements (a map's
// key and value each). Every element is at least a byte, so the count
// can't pass what is left.
list :: proc(r: ^Reader, element: Read) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = r.count(r.remaining())?;
    // rust: (0..n).try_for_each(|_| element(r))
}
// ByteBufCodecs.holder: 0 and the value itself, or the registry id plus one.
holder :: proc(r: ^Reader, direct: Read) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if r.varint()? == 0 { direct(r) } else { Ok(()) }
}
// ByteBufCodecs.holderSet: 0 and a tag id, or the size plus one and the ids.
holder_set :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match r.varint()? {
    // rust: 0 => ident(r),
    // rust: n => {
    // rust: let n = usize::try_from(n - 1).map_err(|_| Error::new("negative holder set size"))?;
    // rust: if n > r.remaining() {
    // rust: return Err(Error::new("holder set past the end"));
}
    // rust: (0..n).try_for_each(|_| varint(r))
}
}
}
// SoundEvent.STREAM_CODEC: a holder of a location and an optional fixed range.
sound :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: holder(r, |r| {
    // rust: ident(r)?;
    // rust: optional(r, f32)
    // rust: })
}
// ResolvableInt, ResolvableFloat: Either a constant (true) or a context provider's key.
resolvable :: proc(r: ^Reader, constant: Read) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if r.bool()? { constant(r) } else { ident(r) }
}
// TrimMaterial.STREAM_CODEC: a holder of a palette id and a description.
trim_material :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: holder(r, |r| {
    // rust: ident(r)?;
    // rust: nbt(r)
    // rust: })
}
// MobEffectInstance: the effect id, then its Details.
mob_effect :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: varint(r)?;
    // rust: effect_details(r)
}
// MobEffectInstance.Details: amplifier, duration, ambient, showParticles, showIcon, then the
// hidden effect's Details, recursively.
effect_details :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let _nested = Nested::enter()?;
    // rust: varint(r)?;
    // rust: varint(r)?;
    // rust: boolean(r)?;
    // rust: boolean(r)?;
    // rust: boolean(r)?;
    // rust: optional(r, effect_details)
}
// ConsumeEffect.STREAM_CODEC: the consume_effect_type id, then that type's fields.
consume_effect :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match r.varint()? {
        // apply_effects: effects, probability.
    // rust: 0 => {
    // rust: list(r, mob_effect)?;
    // rust: f32(r)
}
        // remove_effects: a mob effect holder set.
    // rust: 1 => holder_set(r),
        // clear_all_effects.
    // rust: 2 => Ok(()),
        // teleport_randomly: diameter, directionalParticles.
    // rust: 3 => {
    // rust: f32(r)?;
    // rust: boolean(r)
}
        // play_sound.
    // rust: 4 => sound(r),
    // rust: other => Err(Error::new(format!("unknown consume effect type {other}"))),
}
}
// BlockPredicate: blocks, properties, nbt, then DataComponentMatchers (exact, partial).
block_predicate :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: optional(r, holder_set)?;
    // StatePropertiesPredicate: PropertyMatchers, each a name and an
    // Either<ExactMatcher (value), RangedMatcher (min, max)>.
    // rust: optional(r, |r| {
    // rust: list(r, |r| {
    // rust: string(r)?;
    // rust: if r.bool()? {
    // rust: string(r)
    // rust: } else {
    // rust: optional(r, string)?;
    // rust: optional(r, string)
}
    // rust: })
    // rust: })?;
    // rust: optional(r, nbt)?;
    // DataComponentExactPredicate: TypedDataComponents, a component type id and its value.
    // rust: list(r, |r| {
    // rust: let kind = r.varint()?;
    // rust: Component::read(kind, r).map(drop)
    // rust: })?;
    // DataComponentPredicate.STREAM_CODEC: an Either of a predicate type id or a component
    // type id, then the predicate as NBT (fromCodecWithRegistries).
    // rust: list(r, |r| {
    // rust: boolean(r)?;
    // rust: varint(r)?;
    // rust: nbt(r)
    // rust: })
}
// ItemAttributeModifiers.Entry: attribute, modifier (id, amount, operation), slot, display.
attribute_modifier :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: varint(r)?;
    // rust: ident(r)?;
    // rust: r.f64()?;
    // rust: varint(r)?;
    // rust: varint(r)?;
    // Display.Type: default, hidden, or override and its text.
    // rust: match r.varint()? {
    // rust: 0 | 1 => Ok(()),
    // rust: 2 => nbt(r),
    // rust: other => Err(Error::new(format!(
    // rust: "unknown attribute modifier display {other}"
    // rust: ))),
}
}
// Tool: rules (blocks, speed, correctForDrops), defaultMiningSpeed, damagePerBlock,
// canDestroyBlocksInCreative.
tool :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: list(r, |r| {
    // rust: holder_set(r)?;
    // rust: optional(r, f32)?;
    // rust: optional(r, boolean)
    // rust: })?;
    // rust: f32(r)?;
    // rust: varint(r)?;
    // rust: boolean(r)
}
// Equippable: slot, equipSound, assetId, cameraOverlay, allowedEntities, dispensable,
// swappable, damageOnHurt, equipOnInteract, canBeSheared, shearingSound.
equippable :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: varint(r)?;
    // rust: sound(r)?;
    // rust: optional(r, ident)?;
    // rust: optional(r, ident)?;
    // rust: optional(r, holder_set)?;
    // rust: (0..5).try_for_each(|_| boolean(r))?;
    // rust: sound(r)
}
// BlocksAttacks: blockDelaySeconds, disableCooldownScale, damageReductions (angle, type,
// base, factor), itemDamage (threshold, base, factor), bypassedBy, blockSound, disableSound.
blocks_attacks :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: f32(r)?;
    // rust: f32(r)?;
    // rust: list(r, |r| {
    // rust: f32(r)?;
    // rust: optional(r, holder_set)?;
    // rust: f32(r)?;
    // rust: f32(r)
    // rust: })?;
    // rust: (0..3).try_for_each(|_| f32(r))?;
    // rust: optional(r, holder_set)?;
    // rust: optional(r, sound)?;
    // rust: optional(r, sound)
}
// KineticWeapon: contactCooldownTicks, delayTicks, the dismount, knockback and damage
// conditions (maxDurationTicks, minSpeed, minRelativeSpeed), forwardMovement,
// damageMultiplier, sound, hitSound.
kinetic_weapon :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: varint(r)?;
    // rust: varint(r)?;
    // rust: (0..3).try_for_each(|_| {
    // rust: optional(r, |r| {
    // rust: varint(r)?;
    // rust: f32(r)?;
    // rust: f32(r)
    // rust: })
    // rust: })?;
    // rust: f32(r)?;
    // rust: f32(r)?;
    // rust: optional(r, sound)?;
    // rust: optional(r, sound)
}
// PotionContents' customEffects and customName (`Component::read` reads
// the potion and colour before them).
    // rust: pub(super) fn potion_effects_and_name(r: &mut Reader) -> Result<()> {
    // rust: list(r, mob_effect)?;
    // rust: optional(r, string)
}
// FireworkExplosion: shape, colors, fadeColors, hasTrail, hasTwinkle.
firework_explosion :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: varint(r)?;
    // rust: list(r, i32)?;
    // rust: list(r, i32)?;
    // rust: boolean(r)?;
    // rust: boolean(r)
}
