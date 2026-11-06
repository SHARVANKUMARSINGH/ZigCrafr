//! Transpiled from Horizon Rust crate
package horizon_client_lan_attributes

import "core:fmt"
import "core:mem"
import "core:math"

// The attribute instances a server syncs for the living entities it tracks
// (`ClientboundUpdateAttributesPacket`, lan/attributes.rs): the ones
// vanilla's `AttributeMap` would have created by then, since only those are
// sent, never the type's other defaults.
// use super::Game;
// use super::commands::Target;
// use horizon_client::{
    // rust: effects,
    // rust: lan::attributes::{add_modifier, generic_syncable, instance, operation_named},
    // rust: mobs::{
    // rust: Mob, Species,
    // rust: finalize::{self, Attr, Op},
    // rust: },
}
// use horizon_protocol::packets::play::{AttributeModifier, AttributeSnapshot};
// use std::sync::Arc;

// `EquipmentSlotGroup.test`: whether a modifier's slot group covers a slot.
// For one snapshot of the mobs, each type's movement speed: its synced
// instance (`synced_attribute`) and the type's default base, both looked up
// by name. The pointers are only compared while the snapshot holds the types.
    // rust: pub(super) struct SpeedByType(
    // rust: horizon_client::fast_hash::FxHashMap<
    // rust: *const horizon_client::mobs::MobType,
    // rust: (Option<i32>, Option<f64>),
    // rust: >,
    // rust: );

slot_in_group :: proc(group: string, slot: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: group == slot
    // rust: || group == "any"
    // rust: || (group == "hand" && matches!(slot, "mainhand" | "offhand"))
    // rust: || (group == "armor" && matches!(slot, "feet" | "legs" | "chest" | "head" | "body"))
}

    // rust: fn generic_attributes_into(
    // rust: map: &horizon_world::attributes::entity::EntityAttributes,
    // rust: out: &mut Vec<AttributeSnapshot>,
    // rust: ) {
    // rust: for s in generic_syncable(map) {
    // rust: let (attribute, base) = (s.attribute, s.base);
    // rust: *instance(out, attribute, base) = s;
}
}

    // rust: impl Game<'_> {
    // `getAttributeValue(KNOCKBACK_RESISTANCE)` of a mob: its own value plus
    // the modifiers of the items it wears or holds in matching slots.
    // rust: pub(super) fn mob_knockback_resistance(&self, m: &Mob) -> f64 {
    // rust: let e = &m.extra;
    // rust: let slots = [
    // rust: ("mainhand", &e.main_hand),
    // rust: ("offhand", &e.off_hand),
    // rust: ("feet", &e.feet),
    // rust: ("legs", &e.legs),
    // rust: ("chest", &e.chest),
    // rust: ("head", &e.head),
    // rust: ];
    // rust: let mut extra = Vec::new();
    // rust: for (slot, item) in slots {
    // rust: let Some(info) = item.as_ref().and_then(|i| self.items().get(i)) else {
    // rust: continue;
}
    // rust: for (attribute, _, amount, op, group) in &info.modifiers {
    // rust: if attribute == "minecraft:knockback_resistance" && slot_in_group(group, slot) {
    // rust: let op = match operation_named(op) {
    // rust: 1 => Op::AddMultipliedBase,
    // rust: 2 => Op::AddMultipliedTotal,
    // rust: _ => Op::AddValue,
}
    // rust: extra.push((*amount, op));
}
}
}
    // rust: finalize::value_with(m, Attr::KnockbackResistance, &extra)
}

    // Each mob's `gear_knockback_resistance`, for the pushes that read the
    // mob (`Mob::knockback`, Punch, the mace's smash): worked out for the
    // mobs that wear or hold something, since the mob does not know items.
    // rust: pub(super) fn refresh_gear_knockback_resistance(&mut self) {
    // rust: let values: Vec<Option<f64>> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .map(|m| {
    // rust: let e = &m.extra;
    // rust: [
    // rust: &e.main_hand,
    // rust: &e.off_hand,
    // rust: &e.feet,
    // rust: &e.legs,
    // rust: &e.chest,
    // rust: &e.head,
    // rust: ]
    // rust: .iter()
    // rust: .any(|s| s.is_some())
    // rust: .then(|| self.mob_knockback_resistance(m))
    // rust: })
    // rust: .collect();
    // rust: for (m, value) in self.mobs.iter_mut().zip(values) {
    // rust: m.gear_knockback_resistance = value;
}
}

    // The registry id of a client-syncable attribute the entity type has
    // (`AttributeMap.getInstance` is null for the others), by name.
synced_attribute :: proc(self: ^Self, entity: string, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let catalog = &self.motion.attributes;
    // rust: let id = catalog.id(name)?;
    // rust: (catalog.attribute(id).syncable && catalog.default_base(entity, id).is_some())
    // rust: .then(|| id.registry_id())
}

    // The type's base value of an attribute, as the instance starts.
attribute_default :: proc(self: ^Self, entity: string, name: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let catalog = &self.motion.attributes;
    // rust: catalog
    // rust: .id(name)
    // rust: .and_then(|id| catalog.default_base(entity, id))
    // rust: .unwrap_or(0.0)
}

    // `LivingEntity.collectEquipmentChanges`: each worn or held item's
    // attribute modifiers, slot by slot in `EquipmentSlot` order, create
    // their instances (an instance without a modifier keeps its base).
    // rust: fn equipment_attributes<'a>(
    // rust: &self,
    // rust: entity: &str,
    // rust: base: impl Fn(&str) -> Option<f64>,
    // rust: slots: impl IntoIterator<Item = (&'static str, Option<&'a Arc<str>>)>,
    // rust: out: &mut Vec<AttributeSnapshot>,
    // rust: ) {
    // rust: for (slot, item) in slots {
    // rust: let Some(info) = item.and_then(|i| self.items().get(i)) else {
    // rust: continue;
}
    // rust: for (attribute, id, amount, op, group) in &info.modifiers {
    // rust: if !slot_in_group(group, slot) {
    // rust: continue;
}
    // rust: let Some(a) = self.synced_attribute(entity, attribute) else {
    // rust: continue;
}
    // rust: let start =
    // rust: base(attribute).unwrap_or_else(|| self.attribute_default(entity, attribute));
    // rust: add_modifier(
    // rust: out,
    // rust: a,
    // rust: start,
    // rust: AttributeModifier {
    // rust: id: id.clone(),
    // rust: amount: *amount,
    // rust: operation: operation_named(op),
    // rust: },
    // rust: );
}
}
}

    // A mob's synced instances: movement speed (its first `aiStep` reads it,
    // `LivingEntity.removeFrost`), what finalizeSpawn set, the baby speed
    // modifier, its effects' modifiers, its equipment's, and what
    // `/attribute` changed.
    // rust: pub(super) fn mob_attributes(
    // rust: &self,
    // rust: m: &Mob,
    // rust: speeds: &mut SpeedByType,
    // rust: out: &mut Vec<AttributeSnapshot>,
    // rust: ) {
    // rust: let kind = m.kind.id.as_str();
        // Movement speed is synced for nearly every mob, and read up to three
        // times below: its instance and the type's default are looked up by
        // name once per type and snapshot, its base once per mob.
    // rust: let (synced, default) = *speeds.0.entry(Arc::as_ptr(&m.kind)).or_insert_with(|| {
    // rust: (
    // rust: self.synced_attribute(kind, Attr::MovementSpeed.id()),
    // rust: finalize::default_value(m, Attr::MovementSpeed),
    // rust: )
    // rust: });
    // rust: let speed = synced.map(|a| {
    // rust: (
    // rust: a,
    // rust: finalize::base_value_with(m, Attr::MovementSpeed, || default),
    // rust: )
    // rust: });
    // rust: if let Some((a, base)) = speed {
    // rust: instance(out, a, base);
}
    // rust: if let Some(s) = m.extra.attributes.as_deref() {
    // rust: for (attr, v) in &s.bases {
    // rust: if let Some(a) = self.synced_attribute(kind, attr.id()) {
    // rust: instance(out, a, *v).base = *v;
}
}
    // rust: for x in &s.modifiers {
    // rust: if let Some(a) = self.synced_attribute(kind, x.attr.id()) {
    // rust: add_modifier(
    // rust: out,
    // rust: a,
    // rust: finalize::base_value(m, x.attr),
    // rust: AttributeModifier {
    // rust: id: x.id.to_string(),
    // rust: amount: x.amount,
    // rust: operation: match x.op {
    // rust: Op::AddValue => 0,
    // rust: Op::AddMultipliedBase => 1,
    // rust: Op::AddMultipliedTotal => 2,
    // rust: },
    // rust: },
    // rust: );
}
}
}
        // AbstractHorse.randomizeAttributes rolls a horse's jump strength as
        // its base (kept in `vector[0]`), so the instance is synced: its
        // rider's client jumps it (`getCustomJump`).
    // rust: let rolled = matches!(
    // rust: m.species(),
    // rust: Species::Horse | Species::SkeletonHorse | Species::ZombieHorse
    // rust: );
    // rust: let jump_base = m
    // rust: .extra
    // rust: .attributes
    // rust: .as_deref()
    // rust: .is_some_and(|s| s.bases.iter().any(|(a, _)| *a == Attr::JumpStrength));
    // rust: if rolled
    // rust: && !jump_base
    // rust: && m.extra.vector[0] > 0.0
    // rust: && let Some(a) = self.synced_attribute(kind, Attr::JumpStrength.id())
    // rust: {
    // rust: instance(out, a, m.extra.vector[0]).base = m.extra.vector[0];
}
    // rust: if let (Some((a, base)), Some((amount, Op::AddMultipliedBase))) =
    // rust: (speed, finalize::transient(m, Attr::MovementSpeed))
    // rust: {
    // rust: add_modifier(
    // rust: out,
    // rust: a,
    // rust: base,
    // rust: AttributeModifier {
    // rust: id: "minecraft:baby".into(),
    // rust: amount,
    // rust: operation: 1,
    // rust: },
    // rust: );
}
        // LivingEntity.setSprinting: SPEED_MODIFIER_SPRINTING (a dashing cat or ocelot).
    // rust: if let (true, Some((a, base))) = (m.extra.sprinting, speed) {
    // rust: add_modifier(
    // rust: out,
    // rust: a,
    // rust: base,
    // rust: AttributeModifier {
    // rust: id: "minecraft:sprinting".into(),
    // rust: amount: f64::from(0.3f32),
    // rust: operation: 2,
    // rust: },
    // rust: );
}
    // rust: let base = |name: &str| {
    // rust: Attr::ALL
    // rust: .into_iter()
    // rust: .find(|a| name.strip_prefix("minecraft:") == Some(a.name()))
    // rust: .map(|a| finalize::base_value(m, a))
}
        // LivingEntity.onEffectAdded: MobEffect.addAttributeModifiers.
    // rust: for &(effect, _, amplifier) in &m.extra.effects {
    // rust: let Some((attribute, id, amount, op)) =
    // rust: effects::effect_modifier(effect.trim_start_matches("minecraft:"))
    // rust: else {
    // rust: continue;
}
    // rust: let Some(a) = self.synced_attribute(kind, attribute) else {
    // rust: continue;
}
    // rust: let start = base(attribute).unwrap_or_else(|| self.attribute_default(kind, attribute));
    // rust: add_modifier(
    // rust: out,
    // rust: a,
    // rust: start,
    // rust: AttributeModifier {
    // rust: id: id.to_owned(),
    // rust: amount: amount * f64::from(amplifier + 1),
    // rust: operation: operation_named(op),
    // rust: },
    // rust: );
}
    // rust: let e = &m.extra;
    // rust: self.equipment_attributes(
    // rust: kind,
    // rust: base,
    // rust: [
    // rust: ("mainhand", e.main_hand.as_ref()),
    // rust: ("offhand", e.off_hand.as_ref()),
    // rust: ("feet", e.feet.as_ref()),
    // rust: ("legs", e.legs.as_ref()),
    // rust: ("chest", e.chest.as_ref()),
    // rust: ("head", e.head.as_ref()),
    // rust: ],
    // rust: out,
    // rust: );
    // rust: self.generic_attributes_of(Target::Mob(m.id), out);
    // rust: if let Some(map) = m.extra.armor_attributes.as_deref() {
    // rust: generic_attributes_into(map, out);
}
}

    // An armor stand's synced instances: movement speed (its first
    // `aiStep`), its equipment's modifiers and what `/attribute` changed.
    // rust: pub(super) fn stand_attributes(
    // rust: &self,
    // rust: id: u32,
    // rust: equipment: &[Option<horizon_client::items::ItemStack>; 6],
    // rust: ) -> Vec<AttributeSnapshot> {
KIND :: "minecraft:armor_stand"
    // rust: let mut out = Vec::new();
    // rust: if let Some(a) = self.synced_attribute(KIND, "minecraft:movement_speed") {
    // rust: instance(
    // rust: &mut out,
    // rust: a,
    // rust: self.attribute_default(KIND, "minecraft:movement_speed"),
    // rust: );
}
    // rust: let slots = horizon_client::entities::ArmorStand::SLOTS
    // rust: .into_iter()
    // rust: .zip(equipment.iter().map(|s| s.as_ref().map(|s| &s.item)));
    // rust: self.equipment_attributes(KIND, |_| None, slots, &mut out);
    // rust: self.generic_attributes_of(Target::Stand(id), &mut out);
    // rust: out
}

    // The instances a server player's tick creates, and
    // `ServerPlayer.updatePlayerAttributes`: a creative player reaches 0.5
    // further to blocks and 2 to entities. Its client reads the reach from
    // these synced modifiers. (The crouching player's waypoint range is
    // server-side only: lan_waypoints.rs hides it.)
    // rust: pub(super) fn update_player_attributes(&mut self) {
    // rust: let creative = self.mode_id() == 1;
    // rust: let Some(p) = self.player.as_mut() else {
    // rust: return;
}
        // LivingEntity.aiStep's removeFrost reads the movement speed instance
        // every tick, which creates it (and its first sync).
    // rust: if let Some(key) = p.attributes.key("minecraft:movement_speed") {
    // rust: let _ = p.attributes.get_instance(Some(key));
}
    // rust: for (attribute, id, amount) in [
    // rust: (
    // rust: "minecraft:block_interaction_range",
    // rust: "minecraft:creative_mode_block_range",
    // rust: 0.5,
    // rust: ),
    // rust: (
    // rust: "minecraft:entity_interaction_range",
    // rust: "minecraft:creative_mode_entity_range",
    // rust: 2.0,
    // rust: ),
    // rust: ] {
    // rust: let Some(key) = p.attributes.key(attribute) else {
    // rust: continue;
}
            // getAttribute creates the instance, a creative player's or not.
    // rust: if !matches!(p.attributes.get_instance(Some(key.clone())), Ok(Some(_))) {
    // rust: continue;
}
            // addOrUpdateTransientModifier with the same modifier and
            // removeModifier of a missing one leave the instance clean.
    // rust: let has = p.attributes.has_modifier(Some(key), id).unwrap_or(false);
    // rust: if has != creative {
    // rust: let _ = p.set_modifier(attribute, id, amount, "add_value", creative);
}
}
}

    // The instances `/attribute` created in an entity's generic map
    // replace the ones derived from its state.
generic_attributes_of :: proc(self: ^Self, t: Target, out: ^[dynamic]AttributeSnapshot) {
}
    // rust: if let Some(map) = self.cmds.attributes.get(&t) {
    // rust: generic_attributes_into(map, out);
}
}
}

    // rust: mod tests {
//     use super::slot_in_group;

slot_groups_cover_their_slots :: proc() {
}
    // rust: assert!(slot_in_group("head", "head"));
    // rust: assert!(slot_in_group("armor", "chest"));
    // rust: assert!(!slot_in_group("armor", "mainhand"));
    // rust: assert!(slot_in_group("hand", "offhand"));
    // rust: assert!(slot_in_group("any", "feet"));
    // rust: assert!(!slot_in_group("mainhand", "offhand"));
}
}
