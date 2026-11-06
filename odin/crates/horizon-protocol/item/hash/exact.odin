//! Transpiled from Horizon Rust crate
package horizon_protocol_exact

import "core:fmt"
import "core:mem"
import "core:math"

// Exact component predicates nested in a partial predicate's NBT
// (`container`, `bundle_contents`: their item predicates' `components`).
//
// Vanilla's client decodes the predicate's NBT with its codec and hashes the
// result (`DataComponentExactPredicate.CODEC` is `DataComponentType.VALUE_MAP_CODEC`,
// a `Codec.dispatchedMap` of component type to that type's own codec). The
// tree is what the codecs encode, so it is walked as NBT; the one thing NBT
// does not say is which bytes are a `Codec.BOOL` (`NbtOps.createBoolean`
// writes a byte, `HashOps` hashes a boolean). Those are the fields the
// codecs of each component declare, listed by component below.
// use super::gameplay::PREDICATE_BOOLS;
// use super::*;
// use horizon_world::nbt::{Compound, Tag};

// What a component's codec holds that NBT cannot tell apart.
Shape :: struct {
    // Keys whose byte value is a `Codec.BOOL`.
    bools: [dynamic]^'static str,
    // Keys whose list holds `Codec.BOOL`s (`CustomModelData.flags`).
    bool_lists: ^'static [^'static str],
    // Whether the value holds item stacks, whose `components` are a patch.
    stacks: bool,
}
    // rust: impl Shape {
plain :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::of(&[])
}
of :: proc(bools: ^[^'static str]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: bools: bools.to_vec(),
    // rust: bool_lists: &[],
    // rust: stacks: false,
}
}
with :: proc(more: ^[^'static str]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.bools.extend_from_slice(more);
    // rust: self
}
stacks :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.stacks = true;
    // rust: self
}
}

// `MobEffectInstance.Details.MAP_CODEC`.
EFFECT :: ["ambient", "show_particles", "show_icon"]

// The shape of the persistent component `name` (without `minecraft:`), or
// `None` for one with no persistent codec: `DataComponentType.PERSISTENT_CODEC`
// refuses it, so no predicate holds it.
shape :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match name {
    // rust: "creative_slot_lock" | "map_post_processing" | "additional_trade_cost" => return None,
        // `ComponentSerialization.CODEC`, and records that hold text components.
    // rust: "custom_name"
    // rust: | "item_name"
    // rust: | "lore"
    // rust: | "attribute_modifiers"
    // rust: | "instrument"
    // rust: | "provides_trim_material"
    // rust: | "jukebox_playable"
    // rust: | "painting/variant" => Shape::of(&TEXT_BOOLS),
    // rust: "use_effects" => Shape::of(&["can_sprint", "interact_vibrations"]),
    // rust: "tooltip_display" => Shape::of(&["hide_tooltip"]),
    // rust: "food" => Shape::of(&["can_always_eat"]),
    // rust: "consumable" => {
    // rust: Shape::of(&["has_consume_particles", "directional_particles"]).with(&EFFECT)
}
    // rust: "death_protection" => Shape::of(&["directional_particles"]).with(&EFFECT),
    // rust: "tool" => Shape::of(&["can_destroy_blocks_in_creative", "correct_for_drops"]),
    // rust: "equippable" => Shape::of(&[
    // rust: "dispensable",
    // rust: "swappable",
    // rust: "damage_on_hurt",
    // rust: "equip_on_interact",
    // rust: "can_be_sheared",
    // rust: ]),
    // rust: "piercing_weapon" => Shape::of(&["deals_knockback", "dismounts"]),
    // rust: "lodestone_tracker" => Shape::of(&["tracked"]),
    // rust: "firework_explosion" | "fireworks" => Shape::of(&["has_trail", "has_twinkle"]),
    // rust: "potion_contents" => Shape::of(&EFFECT),
    // rust: "trim" => Shape::of(&["decal"]).with(&TEXT_BOOLS),
    // rust: "block_transformer" => Shape::of(&["update_from_neighbors", "consume_on_use"]),
    // rust: "written_book_content" => Shape::of(&["resolved"]).with(&TEXT_BOOLS),
    // rust: "sign_text_front" | "sign_text_back" => Shape::of(&["has_glowing_text"]).with(&TEXT_BOOLS),
    // rust: "custom_model_data" => Shape {
    // rust: bool_lists: &["flags"],
    // rust: ..Shape::plain()
    // rust: },
    // rust: "container"
    // rust: | "bundle_contents"
    // rust: | "charged_projectiles"
    // rust: | "use_remainder"
    // rust: | "sulfur_cube_content" => Shape::plain().stacks(),
        // The rest hold no boolean (`custom_data` and the entity and block entity
        // data are raw NBT, which is hashed as it is).
    // rust: _ => Shape::plain(),
    // rust: })
}

units :: proc(key: ^[u16]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: String::from_utf16_lossy(key)
}

// `DataComponentExactPredicate.CODEC` (or, for `stacks`, a
// `DataComponentPatch.CODEC`, whose `!name` entries remove a component) as a
// map of the component's name to its value.
components :: proc(map: ^Compound, names: ^dyn Names) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries = Vec::with_capacity(map.len());
    // rust: for (key, value) in map.iter() {
    // rust: let key = units(&key.0);
    // rust: let hashed = match key.strip_prefix('!') {
    // rust: Some(_) => HashOps::empty_map(),
    // rust: None => {
    // rust: let short = key.strip_prefix("minecraft:")?;
    // rust: match (short, value) {
                    // `enchantment_glint_override` is a bare `Codec.BOOL`.
    // rust: ("enchantment_glint_override", Tag::Byte(b)) => {
    // rust: HashOps::create_boolean(*b != 0)
}
    // rust: _ => walk(value, &shape(short)?, names)?,
}
}
}
    // rust: entries.push((string(&key), hashed));
}
    // rust: Some(HashOps::create_map(entries))
}

// A partial predicate's NBT: its booleans, and the `components` of the item
// predicates inside it.
    // rust: pub(super) fn predicate(tag: &Tag, names: &dyn Names) -> Option<HashCode> {
    // rust: walk(tag, &Shape::of(&PREDICATE_BOOLS).stacks(), names)
}

// `tag` as the hash of the value its codec encoded, by `shape`.
walk :: proc(tag: ^Tag, shape: ^Shape, names: ^dyn Names) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match tag {
    // rust: Tag::List(items) => HashOps::create_list(
    // rust: items
    // rust: .iter()
    // rust: .map(|t| walk(t, shape, names))
    // rust: .collect::<Option<Vec<_>>>()?,
    // rust: ),
    // rust: Tag::Compound(map) => {
    // rust: let mut entries = Vec::with_capacity(map.len());
    // rust: for (key, value) in map.iter() {
    // rust: let name = units(&key.0);
    // rust: let hashed = match value {
    // rust: Tag::Compound(inner) if shape.stacks && name == "components" => {
    // rust: components(inner, names)?
}
    // rust: Tag::Byte(b) if shape.bools.contains(&name.as_str()) => {
    // rust: HashOps::create_boolean(*b != 0)
}
    // rust: Tag::List(items) if shape.bool_lists.contains(&name.as_str()) => {
    // rust: HashOps::create_list(items.iter().map(|t| match t {
    // rust: Tag::Byte(b) => HashOps::create_boolean(*b != 0),
    // rust: other => HashOps::from_nbt(other, &[]),
    // rust: }))
}
    // rust: _ => walk(value, shape, names)?,
}
    // rust: entries.push((HashOps::create_string_units(&key.0), hashed));
}
    // rust: HashOps::create_map(entries)
}
    // rust: other => HashOps::from_nbt(other, &[]),
    // rust: })
}
