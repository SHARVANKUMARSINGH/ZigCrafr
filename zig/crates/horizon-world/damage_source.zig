//! Transpiled from Horizon Rust crate
//! Module: horizon-world_damage_source
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Version-checked damage definitions/tags and ordinary source identity queries.
//! Catalogs are immutable snapshots; runtime registry reload and wire IDs remain
//! separate from these local definition indices.
// use crate::{
    // rust: DATA_VERSION,
    // rust: compression::invalid,
    // rust: worldgen::tags::{TagDefinitions, identifier},
}
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: io,
}
    // rust: mod resources;
    // rust: pub use resources::{resource_files, resource_tags};
pub const DamageTypeId = struct {};
pub const Scaling = enum {
    Never,
    LivingNonPlayer,
    Always,
};
    // rust: impl Scaling {
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Never => "never",
    // rust: Self::LivingNonPlayer => "when_caused_by_living_non_player",
    // rust: Self::Always => "always",
}
}
}
pub const Definition = struct {
    name: []const u8,
    message_id: []const u8,
    exhaustion: f32,
    scaling: Scaling,
    effects: []const u8,
    death_message_type: []const u8,
};
pub const Catalog = struct {
    definitions: std.ArrayList(Definition),
    ids: BTreeMap<[]const u8,
    tags: BTreeMap<[]const u8,
};
pub fn string(v: *Value) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.as_str()
    // rust: .ok_or_else(|| invalid("expected damage catalog string"))
}
    // rust: impl Catalog {
    /// Imports native decoded definitions and resolves raw tag resources with
    /// the shared tag implementation. No data-pack or network IDs are invented.
pub fn from_json(v: *Value, resources: *Value) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v["data_version"].as_i64() != Some(i64::from(DATA_VERSION)) {
    // rust: return Err(invalid("damage catalog data version mismatch"));
}
    // rust: let mut definitions = Vec::new();
    // rust: let mut ids = BTreeMap::new();
    // rust: for d in v["types"]
    // rust: .as_array()
    // rust: .ok_or_else(|| invalid("missing damage definitions"))?
    // rust: {
    // rust: let name = string(&d["id"])?;
    // rust: if identifier(name).map_err(|e| invalid(e.to_string()))? != name
    // rust: || ids
    // rust: .insert(name.into(), DamageTypeId(definitions.len()))
    // rust: .is_some()
    // rust: {
    // rust: return Err(invalid("noncanonical or duplicate damage type"));
}
    // rust: let bits = string(&d["exhaustion"])?;
    // rust: if bits.len() != 8 {
    // rust: return Err(invalid("expected damage exhaustion float bits"));
}
    // rust: let exhaustion =
    // rust: f32::from_bits(u32::from_str_radix(bits, 16).map_err(|e| invalid(e.to_string()))?);
    // rust: let scaling = match string(&d["scaling"])? {
    // rust: "never" => Scaling::Never,
    // rust: "when_caused_by_living_non_player" => Scaling::LivingNonPlayer,
    // rust: "always" => Scaling::Always,
    // rust: _ => return Err(invalid("unknown damage scaling")),
}
    // rust: let effects = string(&d["effects"])?;
    // rust: if ![
    // rust: "hurt", "thorns", "drowning", "burning", "poking", "freezing",
    // rust: ]
    // rust: .contains(&effects)
    // rust: {
    // rust: return Err(invalid("unknown damage effects"));
}
    // rust: let death = string(&d["death_message_type"])?;
    // rust: if !["default", "fall_variants", "intentional_game_design"].contains(&death) {
    // rust: return Err(invalid("unknown death message type"));
}
    // rust: definitions.push(Definition {
    // rust: name: name.into(),
    // rust: message_id: string(&d["message_id"])?.into(),
    // rust: exhaustion,
    // rust: scaling,
    // rust: effects: effects.into(),
    // rust: death_message_type: death.into(),
    // rust: });
}
    // rust: let mut tags = TagDefinitions::default();
    // rust: for (id, json) in resources
    // rust: .as_object()
    // rust: .ok_or_else(|| invalid("expected damage tag resources"))?
    // rust: {
    // rust: tags.apply_json(id, "vanilla", string(json)?)
    // rust: .map_err(|e| invalid(e.to_string()))?;
}
    // rust: let tags = tags
    // rust: .build(|id, _| ids.get(id).copied())
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: if !tags.missing.is_empty() {
    // rust: return Err(invalid("unresolved required damage tag references"));
}
    // rust: Ok(Self {
    // rust: definitions,
    // rust: ids,
    // rust: tags: tags
    // rust: .tags
    // rust: .into_iter()
    // rust: .map(|(id, v)| (id, v.into_iter().collect()))
    // rust: .collect(),
    // rust: })
}
pub fn id(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ids.get(name).copied()
}
pub fn definition(self: *Self, id: DamageTypeId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.definitions.get(id.0)
}
pub fn entries(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.definitions
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, d)| (DamageTypeId(i), d))
}
pub fn tags(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tags.keys().map(String::as_str)
}
pub fn in_tag(self: *Self, id: DamageTypeId, tag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tags.get(tag).is_some_and(|v| v.contains(&id))
}
    // rust: pub fn source<E: Copy + Eq>(
    // rust: &self,
    // rust: id: DamageTypeId,
    // rust: direct: Option<E>,
    // rust: causing: Option<E>,
    // rust: position: Option<[f64; 3]>,
    // rust: ) -> Option<DamageSource<'_, E>> {
    // rust: self.definition(id)?;
    // rust: Some(DamageSource {
    // rust: catalog: self,
    // rust: id,
    // rust: direct,
    // rust: causing,
    // rust: position,
    // rust: })
}
}
pub const EntityKind = enum {
    Other,
    Living,
    Player,
};
    // rust: pub trait SourceWorld {
    // rust: type Error;
    // rust: type Entity: Copy + Eq;
    // rust: type Weapon;
pub fn kind(self: *Self, entity: Self::Entity) E;
pub fn weapon(self: *Self, entity: Self::Entity) R;
pub fn position(self: *Self, entity: Self::Entity) R;
    /// Virtual getEntity dispatch is used by the creative-source predicate;
    /// difficulty scaling deliberately reads the stored causing entity instead.
    // rust: fn causing_entity(
    // rust: &mut self,
    // rust: stored: Option<Self::Entity>,
    // rust: ) -> Result<Option<Self::Entity>, Self::Error>;
pub fn instabuild(self: *Self, player: Self::Entity) R;
}
pub const DamageSource = struct {
    catalog: *'a Catalog,
    id: DamageTypeId,
    direct: ?E,
    causing: ?E,
    position: Option<[f64,
};
    // rust: impl<E: Copy + Eq> DamageSource<'_, E> {
pub fn definition(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.catalog.definitions[self.id.0]
}
pub fn type_id(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.id
}
pub fn is_type(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.definition().name == name
}
pub fn in_tag(self: *Self, tag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.catalog.in_tag(self.id, tag)
}
pub fn bypasses(self: *Self, kind: crate::damage_reduction::Bypass) b {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::damage_reduction::Bypass;
    // rust: self.in_tag(match kind {
    // rust: Bypass::Armor => "minecraft:bypasses_armor",
    // rust: Bypass::Effects => "minecraft:bypasses_effects",
    // rust: Bypass::Resistance => "minecraft:bypasses_resistance",
    // rust: Bypass::Enchantments => "minecraft:bypasses_enchantments",
    // rust: })
}
pub fn hurt_tag(self: *Self, tag: crate::living_hurt::HurtTag) b {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::living_hurt::HurtTag;
    // rust: self.in_tag(match tag {
    // rust: HurtTag::Fire => "minecraft:is_fire",
    // rust: HurtTag::Freezing => "minecraft:is_freezing",
    // rust: HurtTag::DamagesHelmet => "minecraft:damages_helmet",
    // rust: HurtTag::BypassesCooldown => "minecraft:bypasses_cooldown",
    // rust: HurtTag::NoImpact => "minecraft:no_impact",
    // rust: HurtTag::NoKnockback => "minecraft:no_knockback",
    // rust: })
}
pub fn immunity_tag(self: *Self, tag: crate::damage_immunity::ImmunityTag) b {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::damage_immunity::ImmunityTag;
    // rust: self.in_tag(match tag {
    // rust: ImmunityTag::BypassesInvulnerability => "minecraft:bypasses_invulnerability",
    // rust: ImmunityTag::Fire => "minecraft:is_fire",
    // rust: ImmunityTag::Fall => "minecraft:is_fall",
    // rust: ImmunityTag::Drowning => "minecraft:is_drowning",
    // rust: ImmunityTag::Freezing => "minecraft:is_freezing",
    // rust: })
}
pub fn direct_entity(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.direct
}
pub fn causing_entity(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.causing
}
pub fn is_direct(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.direct == self.causing
}
pub fn position_raw(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.position
}
pub fn food_exhaustion(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.definition().exhaustion
}
    // rust: pub fn scales_with_difficulty<W: SourceWorld<Entity = E>>(&self, w: &W) -> bool {
    // rust: match self.definition().scaling {
    // rust: Scaling::Never => false,
    // rust: Scaling::Always => true,
    // rust: Scaling::LivingNonPlayer => self
    // rust: .causing
    // rust: .is_some_and(|e| w.kind(e) == EntityKind::Living),
}
}
    // rust: pub fn weapon<W: SourceWorld<Entity = E>>(
    // rust: &self,
    // rust: w: &mut W,
    // rust: ) -> Result<Option<W::Weapon>, W::Error> {
    // rust: match self.direct {
    // rust: Some(e) => w.weapon(e),
    // rust: None => Ok(None),
}
}
    // rust: pub fn position<W: SourceWorld<Entity = E>>(
    // rust: &self,
    // rust: w: &mut W,
    // rust: ) -> Result<Option<[f64; 3]>, W::Error> {
    // rust: if let Some(p) = self.position {
    // rust: return Ok(Some(p));
}
    // rust: match self.direct {
    // rust: Some(e) => w.position(e).map(Some),
    // rust: None => Ok(None),
}
}
    // rust: pub fn creative_player<W: SourceWorld<Entity = E>>(&self, w: &mut W) -> Result<bool, W::Error> {
    // rust: match w.causing_entity(self.causing)? {
    // rust: Some(e) if w.kind(e) == EntityKind::Player => w.instabuild(e),
    // rust: _ => Ok(false),
}
}
}
