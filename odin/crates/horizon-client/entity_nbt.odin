//! Transpiled from Horizon Rust crate
package horizon_client_entity_nbt

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla 26.3 entity NBT (`Entity.saveWithoutId` and the subclasses'
// `addAdditionalSaveData`) for the entities Horizon simulates: mobs, item
// entities, experience orbs, arrows and falling blocks. Encoding starts from
// the compound the entity was loaded with, when there is one, so fields
// Horizon does not model (variants, attributes, equipment, custom names)
// survive a Horizon save.
// use crate::{
    // rust: arrows::Pickup,
    // rust: entities::{ArmorStand, Cushion, ExperienceOrb, ItemEntity, ItemFrame, Painting},
    // rust: mobs::{Mob, MobType, Who},
    // rust: projectiles::{Projectile, ProjectileKind},
    // rust: save::{
    // rust: doubles, float, floats, item_from_nbt, item_to_nbt, number, put, read_doubles, text,
    // rust: uuid_from_tag,
    // rust: },
}
// use horizon_core::geometry::Vec3;
// use horizon_world::{
    // rust: chunk::BlockState,
    // rust: nbt::{Compound, Tag},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use std::{collections::HashMap, sync::Arc};

// Saved data carried by `ConversionType.convertCommon` outside the modelled
// mob fields. The converted entity has its own identity and type-specific data;
// only its command tags are inherited from the old entity's raw compound.
conversion_tags :: proc(raw: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Tag::List(tags) = raw?.get("Tags")? else {
    // rust: return None;
}
    // rust: (!tags.is_empty()).then(|| Tag::compound([("Tags", Tag::List(tags.clone()))]))
}

string :: proc(s: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::String(s.into())
}
// Entity type ID (`id`).
kind :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client_core::identifier::normalize_id(&text(tag.get("id"))?)
}
position :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: read_doubles::<3>(tag.get("Pos")).map(|p| Vec3::new(p[0], p[1], p[2]))
}
uuid :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: uuid_from_tag(tag.get("UUID"))
}
motion :: proc(tag: ^Tag) -> V {
    // Ported from Horizon
    return {}
}
    // rust: read_doubles::<3>(tag.get("Motion")).map_or(Vec3::ZERO, |m| Vec3::new(m[0], m[1], m[2]))
}
rotation :: proc(tag: ^Tag) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: read_doubles::<2>(tag.get("Rotation")).map_or([0.0; 2], |r| [r[0] as f32, r[1] as f32])
}
flag :: proc(tag: ^Tag, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: number(tag.get(key)).unwrap_or(0) != 0
}
// `Entity.saveWithoutId` fields every entity has, over the loaded compound.
Base :: struct {
    id: ^'a str,
    uuid: [i32,
    position: Vec3,
    motion: Vec3,
    rotation: [f32,
    on_ground: bool,
    fall_distance: f64,
}
    // rust: impl Base<'_> {
tag :: proc(self: ^Self, raw: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = match raw {
    // rust: Some(t @ Tag::Compound(_)) => t.clone(),
    // rust: _ => Tag::Compound(Compound::new()),
}
    // rust: for (key, value) in [
    // rust: ("id", string(self.id)),
    // rust: ("UUID", Tag::IntArray(self.uuid.to_vec())),
    // rust: (
    // rust: "Pos",
    // rust: doubles(&[self.position.x, self.position.y, self.position.z]),
    // rust: ),
    // rust: (
    // rust: "Motion",
    // rust: doubles(&[self.motion.x, self.motion.y, self.motion.z]),
    // rust: ),
    // rust: ("Rotation", floats(&self.rotation)),
    // rust: ("OnGround", Tag::Byte(i8::from(self.on_ground))),
    // rust: ("fall_distance", Tag::Double(self.fall_distance.to_bits())),
    // rust: ] {
    // rust: put(&mut tag, key, value);
}
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: for (key, value) in [
                // Entity.remainingFireTicks starts at 0 (-1 was the old default).
    // rust: ("Fire", Tag::Short(0)),
    // rust: ("Air", Tag::Short(300)),
    // rust: ("Invulnerable", Tag::Byte(0)),
    // rust: ("PortalCooldown", Tag::Int(0)),
    // rust: ] {
    // rust: map.entry(key.into()).or_insert(value);
}
}
    // rust: tag
}
}

// The mobs that save `Age` and `AgeLocked`.
saves_age :: proc(s: crate::mobs::Species) -> b {
    // Ported from Horizon
    return {}
}
//     use crate::mobs::{Species, drops::can_be_baby, finalize::ageable};
    // rust: s == Species::Tadpole || (ageable(s) && can_be_baby(s))
}
// `LivingEntity` + `Mob` (+ `AgeableMob`, creeper and skeleton specifics).
// The mobs whose class extends vanilla's `Animal` (and so save `InLove`):
// not allays, villagers, golems, dolphins or fish.
is_animal :: proc(id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: id.strip_prefix("minecraft:").unwrap_or(id),
    // rust: "pig"
    // rust: | "cow"
    // rust: | "mooshroom"
    // rust: | "sheep"
    // rust: | "chicken"
    // rust: | "rabbit"
    // rust: | "horse"
    // rust: | "donkey"
    // rust: | "mule"
    // rust: | "zombie_horse"
    // rust: | "skeleton_horse"
    // rust: | "llama"
    // rust: | "trader_llama"
    // rust: | "goat"
    // rust: | "panda"
    // rust: | "polar_bear"
    // rust: | "fox"
    // rust: | "wolf"
    // rust: | "cat"
    // rust: | "ocelot"
    // rust: | "parrot"
    // rust: | "bee"
    // rust: | "turtle"
    // rust: | "armadillo"
    // rust: | "frog"
    // rust: | "axolotl"
    // rust: | "hoglin"
    // rust: | "strider"
    // rust: | "camel"
    // rust: | "camel_husk"
    // rust: | "sniffer"
    // rust: | "happy_ghast"
    // rust: | "nautilus"
    // rust: | "zombie_nautilus"
    // rust: )
}
// The `NeutralMob`s whose anger is `Extra::anger`: they write and read
// `anger_end_time` and `angry_at`. The bee keeps its own anger, and a
// piglin's is a brain memory, not `NeutralMob`'s.
persistent_anger :: proc(s: crate::mobs::Species) -> b {
    // Ported from Horizon
    return {}
}
//     use crate::mobs::Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Wolf | S::IronGolem | S::PolarBear | S::Enderman | S::ZombifiedPiglin
    // rust: )
}
// The single player's UUID (`offline_uuid("Player")`): the entity the
// neutral mobs are angry at.
player_uuid :: proc() -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let u = horizon_protocol::crypto::offline_uuid("Player");
    // rust: [
    // rust: (u >> 96) as u32 as i32,
    // rust: (u >> 64) as u32 as i32,
    // rust: (u >> 32) as u32 as i32,
    // rust: u as u32 as i32,
    // rust: ]
}
// `ResolvableProfile.CODEC`: the name, id and properties of a profile, then the
// skin's texture ids and model (`PlayerSkin.Patch`: "texture", "cape", "elytra", "model").
profile_nbt :: proc(p: ^horizon_protocol::entity_data::Profile) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries: Vec<(&'static str, Tag)> = Vec::new();
    // rust: if let Some(name) = &p.name {
    // rust: entries.push(("name", string(name)));
}
    // rust: if let Some(id) = p.uuid {
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
    // rust: if !p.properties.is_empty() {
    // rust: let properties = p
    // rust: .properties
    // rust: .iter()
    // rust: .map(|property| {
    // rust: let mut entries: Vec<(&'static str, Tag)> = vec![
    // rust: ("name", string(&property.name)),
    // rust: ("value", string(&property.value)),
    // rust: ];
    // rust: if let Some(signature) = &property.signature {
    // rust: entries.push(("signature", string(signature)));
}
    // rust: Tag::compound(entries)
    // rust: })
    // rust: .collect();
    // rust: entries.push(("properties", Tag::List(properties)));
}
    // rust: for (key, texture) in [
    // rust: ("texture", &p.body),
    // rust: ("cape", &p.cape),
    // rust: ("elytra", &p.elytra),
    // rust: ] {
    // rust: if let Some(texture) = texture {
    // rust: entries.push((key, string(texture)));
}
}
    // rust: if let Some(slim) = p.slim {
    // rust: entries.push(("model", string(if slim { "slim" } else { "wide" })));
}
    // rust: Tag::compound(entries)
}
// `ResolvableProfile.CODEC` read back: the compound `profile_nbt` writes, or a
// bare player name (`Codec.withAlternative(FULL_CODEC, PLAYER_NAME, ...)`).
profile_from_nbt :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Tag::String(name) = tag {
    // rust: return Some(horizon_protocol::entity_data::Profile {
    // rust: name: Some(name.to_string_lossy()),
    // rust: uuid: None,
    // rust: properties: Vec::new(),
    // rust: body: None,
    // rust: cape: None,
    // rust: elytra: None,
    // rust: slim: None,
    // rust: });
}
    // rust: let property = |name: String, value: &Tag, signature: Option<String>| match value {
    // rust: Tag::String(v) => Some(horizon_protocol::packets::login::Property {
    // rust: name,
    // rust: value: v.to_string_lossy(),
    // rust: signature,
    // rust: }),
    // rust: _ => None,
}
    // rust: let properties: Vec<horizon_protocol::packets::login::Property> = match tag.get("properties") {
        // `ExtraCodecs.PROPERTY_MAP`: a list of properties ...
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter_map(|p| {
    // rust: let name = match p.get("name")? {
    // rust: Tag::String(s) => s.to_string_lossy(),
    // rust: _ => return None,
}
    // rust: let signature = match p.get("signature") {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
    // rust: property(name, p.get("value")?, signature)
    // rust: })
    // rust: .collect(),
        // ... or a map from a name to its values.
    // rust: Some(Tag::Compound(map)) => map
    // rust: .iter()
    // rust: .flat_map(|(name, values)| match values {
    // rust: Tag::List(values) => values
    // rust: .iter()
    // rust: .filter_map(|v| property(name.to_string_lossy(), v, None))
    // rust: .collect::<Vec<_>>(),
    // rust: _ => Vec::new(),
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let text = |key: &str| match tag.get(key) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
    // rust: Some(horizon_protocol::entity_data::Profile {
    // rust: name: text("name"),
    // rust: uuid: uuid_from_tag(tag.get("id")).map(|a| {
    // rust: a.iter()
    // rust: .fold(0u128, |u, &x| (u << 32) | u128::from(x as u32))
    // rust: }),
    // rust: properties,
    // rust: body: text("texture"),
    // rust: cape: text("cape"),
    // rust: elytra: text("elytra"),
    // rust: slim: text("model").map(|model| model == "slim"),
    // rust: })
}
// `ConversionTracker.addAdditionalSaveData`: vanilla's conversion time, -1
// while the mob is not converting. `counter2` is that time plus one while it
// converts and 0 when it does not (see `mobs/undead.rs`).
conversion_time :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.counter2 > 0 {
    // rust: m.extra.counter2 - 1
    // rust: } else {
    // rust: -1
}
}
// `BlockState.CODEC`: the block's name when the state is that block's
// default, `{id, properties}` for any other state.
state_to_nbt :: proc(registry: ^BlockRegistry, state: BlockStateId) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match registry.state(state) {
    // rust: Some(s) if registry.default_state(&s.name) == Some(state) => string(&s.name),
    // rust: Some(s) => s.to_nbt(),
    // rust: None => string("minecraft:air"),
}
}
// `BlockState.CODEC` read back: a block name or `{id, properties}` (or the
// legacy `{Name, Properties}`). A name the registry knows only as a block
// reads as its default state, and one it does not know at all as `None`.
state_from_nbt :: proc(registry: ^BlockRegistry, tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let state = match tag.get("Name") {
    // rust: Some(Tag::String(name)) => BlockState {
    // rust: name: name.to_string_lossy(),
    // rust: properties: match tag.get("Properties") {
    // rust: Some(Tag::Compound(p)) => p
    // rust: .iter()
    // rust: .filter_map(|(k, v)| match v {
    // rust: Tag::String(v) => Some((k.to_string_lossy(), v.to_string_lossy())),
    // rust: _ => None,
    // rust: })
    // rust: .collect(),
    // rust: _ => Default::default(),
    // rust: },
    // rust: },
    // rust: _ => BlockState::from_nbt(tag).ok()?,
}
    // rust: registry
    // rust: .id(&state)
    // rust: .or_else(|| registry.default_state(&state.name))
}
// `BlockState.isAir`: air, cave air and void air.
is_air :: proc(registry: ^BlockRegistry, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: registry.state(state).is_some_and(|s| {
    // rust: matches!(
    // rust: s.name.as_str(),
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: )
    // rust: })
}
// The mob's entity compound. `registry` is what writes a field holding a block
// state (an enderman's `carriedBlockState`): without one, a caller that has no
// resources (unit tests, structure templates) keeps whatever the loaded
// compound had for it.
    // rust: pub fn mob_to_nbt(
    // rust: m: &Mob,
    // rust: uuid: [i32; 4],
    // rust: raw: Option<&Tag>,
    // rust: registry: Option<&BlockRegistry>,
    // rust: ) -> Tag {
//     use crate::mobs::Species as S;
    // rust: let base = Base {
    // rust: id: &m.kind.id,
    // rust: uuid,
    // rust: position: m.position,
    // rust: motion: m.velocity,
    // rust: rotation: [m.yaw, m.head_pitch],
    // rust: on_ground: m.on_ground,
    // rust: fall_distance: m.fall_distance,
}
    // rust: let mut tag = base.tag(raw);
    // rust: for (key, value) in [
    // rust: (
    // rust: "Fire",
    // rust: Tag::Short(m.fire_ticks.clamp(i32::from(i16::MIN), i32::from(i16::MAX)) as i16),
    // rust: ),
    // rust: ("Air", Tag::Short(m.air as i16)),
    // rust: ("Health", Tag::Float(m.health.max(0.0).to_bits())),
    // rust: ("AbsorptionAmount", Tag::Float(m.absorption.to_bits())),
    // rust: (
    // rust: "HurtTime",
    // rust: Tag::Short(m.hurt_time.clamp(0, i32::from(i16::MAX)) as i16),
    // rust: ),
    // rust: (
    // rust: "DeathTime",
    // rust: Tag::Short(m.death_time.clamp(0, i32::from(i16::MAX)) as i16),
    // rust: ),
        // Mob.addAdditionalSaveData writes the current virtual getter, not raw input.
    // rust: ("CanPickUpLoot", Tag::Byte(i8::from(m.can_pick_up_loot()))),
    // rust: ("PersistenceRequired", Tag::Byte(i8::from(m.persistent))),
    // rust: ] {
    // rust: put(&mut tag, key, value);
}
    // Mob.addAdditionalSaveData: hasHome means radius != -1, including -2.
    // Species writers below retain their own home_pos override.
    // rust: let Tag::Compound(map) = &mut tag else {
    // rust: unreachable!()
}
    // rust: if let Some((pos, radius)) = m.ai.home.filter(|(_, radius)| *radius != -1) {
    // rust: map.insert("home_radius".into(), Tag::Int(radius));
    // rust: map.insert("home_pos".into(), Tag::IntArray(pos.to_vec()));
    // rust: } else {
    // rust: map.remove(&"home_radius".into());
    // rust: map.remove(&"home_pos".into());
}
    // AbstractFish/Axolotl.addAdditionalSaveData always write the flag.
    // Tadpole.fromBucket is always true, and its setter ignores loaded input.
    // rust: let from_bucket = match m.species() {
    // rust: S::Tadpole => Some(true),
    // rust: S::Cod | S::Salmon | S::Pufferfish | S::TropicalFish | S::Axolotl => {
    // rust: Some(m.extra.from_bucket)
}
    // rust: _ => None,
}
    // rust: if let Some(value) = from_bucket {
    // rust: put(&mut tag, "FromBucket", Tag::Byte(i8::from(value)));
}
    // Mob.addAdditionalSaveData: the death loot table, and its seed when set.
    // rust: if let Some(table) = &m.extra.death_loot_table {
    // rust: put(&mut tag, "DeathLootTable", string(table));
}
    // rust: if m.extra.death_loot_seed != 0 {
    // rust: put(
    // rust: &mut tag,
    // rust: "DeathLootTableSeed",
    // rust: Tag::Long(m.extra.death_loot_seed),
    // rust: );
}
    // `NeutralMob.addPersistentAngerSaveData`: the anger ends at an
    // absolute game time, and the target is the entity the mob is angry at.
    // rust: if persistent_anger(m.species()) {
    // rust: put(
    // rust: &mut tag,
    // rust: "anger_end_time",
    // rust: Tag::Long(if m.extra.anger_end > 0 {
    // rust: m.extra.anger_end
    // rust: } else {
    // rust: -1
    // rust: }),
    // rust: );
    // rust: if m.extra.angry_at == Some(crate::mobs::Who::Player) {
    // rust: put(&mut tag, "angry_at", Tag::IntArray(player_uuid().to_vec()));
}
}
    // `Mannequin.addAdditionalSaveData`: the profile whose skin it wears, whether it
    // is `immovable`, and its description (the default is not written; none is `hide_description`).
    // rust: if m.species() == crate::mobs::Species::Mannequin {
    // rust: if let Some(profile) = &m.profile {
    // rust: put(&mut tag, "profile", profile_nbt(profile));
}
    // rust: put(
    // rust: &mut tag,
    // rust: "immovable",
    // rust: Tag::Byte(i8::from(m.extra.immovable)),
    // rust: );
    // rust: match &m.extra.description {
    // rust: crate::mobs::MannequinDescription::Default => {}
    // rust: crate::mobs::MannequinDescription::Hidden => {
    // rust: put(&mut tag, "hide_description", Tag::Byte(1));
}
    // rust: crate::mobs::MannequinDescription::Custom(component) => {
    // rust: put(&mut tag, "description", component.clone());
}
}
}
    // `Entity.saveWithoutId` writes the flag only when set.
    // rust: if m.name_visible {
    // rust: put(&mut tag, "CustomNameVisible", Tag::Byte(1));
    // rust: } else if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"CustomNameVisible".into());
}
    // A styled name from the save stays unless the name changed.
    // rust: if custom_name(&tag) != m.custom_name
    // rust: && let Some(name) = &m.custom_name
    // rust: {
    // rust: put(&mut tag, "CustomName", Tag::String(name.as_str().into()));
}
    // rust: let Tag::Compound(map) = &mut tag else {
    // rust: return tag;
}
    // rust: for (key, on) in [
    // rust: ("NoAI", m.no_ai),
    // rust: ("Silent", m.silent),
    // rust: ("NoGravity", m.no_gravity),
    // rust: ("Glowing", m.glowing),
    // rust: ] {
    // rust: if on {
    // rust: map.insert(key.into(), Tag::Byte(1));
    // rust: } else {
    // rust: map.remove(&horizon_world::nbt::JavaString::from(key));
}
}
    // LivingEntity.addAdditionalSaveData: `active_effects` only when there are
    // any (MobEffectInstance.CODEC; a mob's effects are never ambient, and one
    // given with `hideParticles` shows neither particles nor its icon).
    // rust: if m.extra.effects.is_empty() {
    // rust: map.remove(&horizon_world::nbt::JavaString::from("active_effects"));
    // rust: } else {
    // rust: let effects = m
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .map(|&(effect, duration, amplifier)| {
    // rust: let shown = !m.extra.hidden_effects.contains(&effect);
    // rust: let ambient = m.extra.ambient_effects.contains(&effect);
    // rust: let mut e = vec![("id", string(crate::brewing::namespaced(effect)))];
                // The codec leaves out an amplifier of 0 (its default).
    // rust: if amplifier != 0 {
    // rust: e.push(("amplifier", Tag::Byte(amplifier.clamp(0, 255) as u8 as i8)));
}
    // rust: e.push(("duration", Tag::Int(duration)));
    // rust: if ambient {
    // rust: e.push(("ambient", Tag::Byte(1)));
}
    // rust: if !shown {
    // rust: e.push(("show_particles", Tag::Byte(0)));
}
    // rust: e.push(("show_icon", Tag::Byte(i8::from(shown))));
    // rust: Tag::compound(e)
    // rust: });
    // rust: map.insert("active_effects".into(), Tag::List(effects.collect()));
}
    // rust: map.insert(
    // rust: "Invulnerable".into(),
    // rust: Tag::Byte(i8::from(m.invulnerable_flag)),
    // rust: );
    // rust: map.insert(
    // rust: "LeftHanded".into(),
    // rust: Tag::Byte(i8::from(m.extra.left_handed)),
    // rust: );
    // Keys of older formats that structure templates still carry.
    // rust: for key in [
    // rust: "HandItems",
    // rust: "ArmorItems",
    // rust: "HandDropChances",
    // rust: "ArmorDropChances",
    // rust: "Dimension",
    // rust: "HurtByTimestamp",
    // rust: "Leashed",
    // rust: ] {
    // rust: map.remove(&horizon_world::nbt::JavaString::from(key));
}
    // rust: if m.ticks_frozen > 0 {
    // rust: map.insert("TicksFrozen".into(), Tag::Int(m.ticks_frozen));
    // rust: } else {
    // rust: map.remove(&horizon_world::nbt::JavaString::from("TicksFrozen"));
}
    // rust: for (key, value) in [
    // rust: ("AbsorptionAmount", Tag::Float(0)),
    // rust: ("FallFlying", Tag::Byte(0)),
    // rust: ("current_impulse_context_reset_grace_time", Tag::Int(0)),
    // rust: (
    // rust: "Brain",
    // rust: Tag::compound([("memories", Tag::Compound(Compound::new()))]),
    // rust: ),
    // rust: ] {
    // rust: map.entry(key.into()).or_insert(value);
}
    // What the mob's class saves: a content mod's living type saves as its
    // template does (the `id` written above stays its own).
    // rust: let id = m.kind.class_id();
    // AgeableMob.addAdditionalSaveData, only if canBeABaby (not a frog or a
    // parrot); a tadpole saves its own age.
    // rust: let species = m.species();
    // rust: if saves_age(species) {
    // rust: map.insert("Age".into(), Tag::Int(m.extra.age));
    // rust: map.insert("AgeLocked".into(), Tag::Byte(i8::from(m.extra.age_locked)));
    // rust: if species != crate::mobs::Species::Tadpole {
    // rust: map.insert("ForcedAge".into(), Tag::Int(m.extra.forced_age));
}
    // rust: } else if matches!(
    // rust: species,
    // rust: crate::mobs::Species::Parrot
    // rust: | crate::mobs::Species::Slime
    // rust: | crate::mobs::Species::MagmaCube
    // rust: | crate::mobs::Species::ZombieNautilus
    // rust: ) {
        // AgeableMob.addAdditionalSaveData writes nothing when canBeABaby is
        // false: drop the ignored values a raw input compound carried.
    // rust: for key in ["Age", "ForcedAge", "AgeLocked"] {
    // rust: map.remove(&key.into());
}
}
    // Animal.addAdditionalSaveData: the love ticks left, whatever the save had.
    // rust: if is_animal(id) {
    // rust: map.insert("InLove".into(), Tag::Int(m.extra.in_love));
        // Animal.addAdditionalSaveData: the player who fed it.
    // rust: if let Some(cause) = m.extra.love_cause {
    // rust: map.insert("LoveCause".into(), Tag::IntArray(cause.to_vec()));
}
}
    // rust: let species = m.species();
    // `VariantUtils.writeVariant`: only the species that store the name. A
    // mooshroom saves `Type` (below), a fox `Type`, a horse and a llama a
    // packed `Variant` int, so those report the component but save no name.
    // rust: if crate::mobs::finalize::saves_variant_name(species)
    // rust: && let Some((_, variant)) =
    // rust: crate::mobs::finalize::species_variant_component(species, m.extra.variant)
    // rust: {
    // rust: map.insert("variant".into(), string(&variant));
}
    // rust: if species == crate::mobs::Species::Chicken {
    // rust: map.insert("EggLayTime".into(), Tag::Int(m.extra.egg_time));
}
    // rust: let sounds = crate::mobs::finalize::sound_variants(species);
    // rust: if !sounds.is_empty() {
    // rust: let sound = m.extra.sound_variant.and_then(|i| sounds.get(i as usize));
    // rust: let sound = sound.copied().unwrap_or("classic");
    // rust: map.insert(
    // rust: "sound_variant".into(),
    // rust: string(&format!("minecraft:{sound}")),
    // rust: );
}
    // rust: match id {
        // Fox.addAdditionalSaveData; Horizon models only the type, the
        // flags and no trusted players yet.
    // rust: "minecraft:fox" => {
    // rust: let kind = if m.extra.variant == 1 { "snow" } else { "red" };
    // rust: map.insert("Type".into(), string(kind));
            // The trusted UUIDs (`Fox.TRUSTED_LIST_CODEC`: a list of int arrays).
    // rust: map.insert(
    // rust: "Trusted".into(),
    // rust: Tag::List(
    // rust: crate::mobs::fox::trusted_entities(m)
    // rust: .map(|uuid| Tag::IntArray(uuid.to_vec()))
    // rust: .collect(),
    // rust: ),
    // rust: );
    // rust: for (key, bit) in [
    // rust: ("Sleeping", crate::mobs::fox::SLEEPING),
    // rust: ("Sitting", crate::mobs::fox::SITTING),
    // rust: ("Crouching", crate::mobs::fox::CROUCHING),
    // rust: ] {
    // rust: map.insert(
    // rust: key.into(),
    // rust: Tag::Byte(i8::from(crate::mobs::fox::flag(m, bit))),
    // rust: );
}
}
        // MushroomCow.addAdditionalSaveData: the Variant codec's name and the
        // stew effects, written only while it holds any (storeNullable).
    // rust: "minecraft:mooshroom" => {
    // rust: let kind = if m.extra.variant == 1 { "brown" } else { "red" };
    // rust: map.insert("Type".into(), string(kind));
    // rust: match &m.extra.stew_effects {
    // rust: Some(effects) => {
    // rust: let list = effects.iter().map(|(id, duration)| {
    // rust: let mut entry = vec![("id", string(id))];
                        // SuspiciousStewEffects.Entry leaves out the default.
    // rust: if *duration != 160 {
    // rust: entry.push(("duration", Tag::Int(*duration)));
}
    // rust: Tag::compound(entry)
    // rust: });
    // rust: map.insert("stew_effects".into(), Tag::List(list.collect()));
}
    // rust: None => {
    // rust: map.remove(&horizon_world::nbt::JavaString::from("stew_effects"));
}
}
}
        // Rabbit.addAdditionalSaveData (the legacy id; 99 is the killer bunny).
    // rust: "minecraft:rabbit" => {
    // rust: map.insert("RabbitType".into(), Tag::Int(i32::from(m.extra.variant)));
    // rust: map.insert(
    // rust: "MoreCarrotTicks".into(),
    // rust: Tag::Int(m.extra.more_carrot_ticks),
    // rust: );
}
    // rust: "minecraft:goat" => {
    // rust: map.insert(
    // rust: "IsScreamingGoat".into(),
    // rust: Tag::Byte(i8::from(m.extra.screaming)),
    // rust: );
    // rust: let [left, right] = m.extra.lost_horns;
    // rust: map.insert("HasLeftHorn".into(), Tag::Byte(i8::from(!left)));
    // rust: map.insert("HasRightHorn".into(), Tag::Byte(i8::from(!right)));
}
    // rust: "minecraft:creeper" => {
    // rust: map.insert("Fuse".into(), Tag::Short(m.max_swell as i16));
    // rust: map.entry("ExplosionRadius".into()).or_insert(Tag::Byte(3));
    // rust: map.insert("powered".into(), Tag::Byte(i8::from(m.extra.charged)));
    // rust: map.insert("ignited".into(), Tag::Byte(i8::from(m.extra.flag)));
}
        // `Ocelot.addAdditionalSaveData`.
    // rust: "minecraft:ocelot" => {
    // rust: map.insert("Trusting".into(), Tag::Byte(i8::from(m.extra.trusting)));
}
    // rust: "minecraft:cat" => {
    // rust: if let Some(owner) = m.extra.owner {
    // rust: map.insert("Owner".into(), Tag::IntArray(owner.to_vec()));
    // rust: } else {
    // rust: map.remove(&"Owner".into());
}
    // rust: map.insert("Sitting".into(), Tag::Byte(i8::from(m.extra.sitting)));
    // rust: map.insert("CollarColor".into(), Tag::Byte(m.extra.color as i8));
}
    // rust: "minecraft:wolf" => {
    // rust: if let Some(owner) = m.extra.owner {
    // rust: map.insert("Owner".into(), Tag::IntArray(owner.to_vec()));
    // rust: } else {
    // rust: map.remove(&"Owner".into());
}
    // rust: map.insert("Sitting".into(), Tag::Byte(i8::from(m.extra.sitting)));
    // rust: map.insert("CollarColor".into(), Tag::Byte(m.extra.color as i8));
}
    // rust: "minecraft:panda" => {
//             use crate::mobs::panda::GENES;
    // rust: for (key, gene) in [
    // rust: ("MainGene", m.extra.variant),
    // rust: ("HiddenGene", m.extra.variant2),
    // rust: ] {
    // rust: map.insert(
    // rust: key.into(),
    // rust: string(GENES[usize::from(gene).min(GENES.len() - 1)]),
    // rust: );
}
}
    // rust: "minecraft:piglin" | "minecraft:piglin_brute" | "minecraft:hoglin" => {
            // Only Piglin.addAdditionalSaveData writes CannotHunt.
    // rust: if id == "minecraft:piglin_brute" {
    // rust: map.remove(&"CannotHunt".into());
}
    // rust: map.insert(
    // rust: "IsImmuneToZombification".into(),
    // rust: Tag::Byte(i8::from(m.extra.flag2)),
    // rust: );
    // rust: map.insert("TimeInOverworld".into(), Tag::Int(m.extra.counter2));
    // rust: if id == "minecraft:hoglin" {
    // rust: map.insert(
    // rust: "CannotBeHunted".into(),
    // rust: Tag::Byte(m.extra.cannot_be_hunted as i8),
    // rust: );
}
    // rust: if id == "minecraft:piglin" {
    // rust: write_guarded_piglin_anger(m, map);
                // InventoryCarrier.writeInventoryToTag.
    // rust: map.insert(
    // rust: "Inventory".into(),
    // rust: Tag::List(
    // rust: m.extra
    // rust: .inventory
    // rust: .iter()
    // rust: .map(crate::save::item_to_nbt)
    // rust: .collect(),
    // rust: ),
    // rust: );
}
}
    // rust: "minecraft:horse"
    // rust: | "minecraft:donkey"
    // rust: | "minecraft:mule"
    // rust: | "minecraft:skeleton_horse"
    // rust: | "minecraft:zombie_horse"
    // rust: | "minecraft:llama"
    // rust: | "minecraft:trader_llama" => {
    // rust: map.insert("Tame".into(), Tag::Byte(i8::from(m.extra.tame)));
    // rust: map.insert("Temper".into(), Tag::Int(i32::from(m.extra.variant3)));
    // rust: map.insert("Bred".into(), Tag::Byte(i8::from(m.extra.bred)));
            // AbstractHorse.addAdditionalSaveData; Horizon does not model the
            // eating haystack yet.
    // rust: map.entry("EatingHaystack".into()).or_insert(Tag::Byte(0));
    // rust: if let Some(owner) = m.extra.owner {
    // rust: map.insert("Owner".into(), Tag::IntArray(owner.to_vec()));
}
    // rust: if id == "minecraft:horse" {
    // rust: let v = i32::from(m.extra.variant) | i32::from(m.extra.variant2) << 8;
    // rust: map.insert("Variant".into(), Tag::Int(v));
}
    // rust: let llama = crate::mobs::llama::is_llama(m.species());
    // rust: if llama {
    // rust: crate::mobs::llama::to_nbt(m, map);
}
            // Only llamas, donkeys and mules carry chests.
    // rust: if llama || matches!(id, "minecraft:donkey" | "minecraft:mule") {
    // rust: map.insert("ChestedHorse".into(), Tag::Byte(i8::from(m.extra.chested)));
}
    // rust: if m.extra.chested && !m.extra.items.is_empty() {
    // rust: map.insert("Items".into(), crate::save::encode_items(&m.extra.items));
    // rust: } else {
    // rust: map.remove(&"Items".into());
}
    // rust: let mut equipment = Vec::new();
    // rust: if let Some(saddle) = m.saddle_item() {
    // rust: equipment.push(("saddle", crate::save::item_to_nbt(&saddle)));
}
    // rust: if let Some(armor) = &m.extra.body {
    // rust: equipment.push((
    // rust: "body",
    // rust: Tag::compound([("id", string(armor)), ("count", Tag::Int(1))]),
    // rust: ));
}
            // A helmet given to the mount (say by `/item ... armor.head`)
            // keeps its own slot.
    // rust: if let Some(helmet) = &m.extra.head {
    // rust: equipment.push((
    // rust: "head",
    // rust: Tag::compound([("id", string(helmet)), ("count", Tag::Int(1))]),
    // rust: ));
}
    // rust: if equipment.is_empty() {
    // rust: map.remove(&"equipment".into());
    // rust: } else {
    // rust: map.insert("equipment".into(), Tag::compound(equipment));
}
    // rust: let modelled = [
    // rust: ("minecraft:max_health", f64::from(m.attrs.max_health)),
    // rust: ("minecraft:movement_speed", m.attrs.speed),
    // rust: ("minecraft:jump_strength", m.extra.vector[0]),
    // rust: ];
            // AttributeMap.pack writes the instances that exist: the ones the
            // entity was loaded with, or all three randomized by finalizeSpawn.
    // rust: let attributes = match map.get(&"attributes".into()) {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .map(|a| {
    // rust: let id = text(a.get("id"));
    // rust: let value = modelled.iter().find(|(m, _)| Some(*m) == id.as_deref());
    // rust: match (a, value) {
    // rust: (Tag::Compound(c), Some((_, v))) => {
    // rust: let mut c = c.clone();
    // rust: c.insert("base".into(), Tag::Double(v.to_bits()));
    // rust: Tag::Compound(c)
}
    // rust: _ => a.clone(),
}
    // rust: })
    // rust: .collect(),
    // rust: _ => modelled
    // rust: .iter()
    // rust: .map(|(id, v)| {
    // rust: Tag::compound([("id", string(id)), ("base", Tag::Double(v.to_bits()))])
    // rust: })
    // rust: .collect(),
}
    // rust: map.insert("attributes".into(), Tag::List(attributes));
}
    // rust: "minecraft:pig" | "minecraft:strider" => {
    // rust: let mut equipment = match map.get(&"equipment".into()) {
    // rust: Some(Tag::Compound(c)) => c.clone(),
    // rust: _ => Compound::new(),
}
    // rust: if let Some(saddle) = m.saddle_item() {
    // rust: equipment.insert("saddle".into(), crate::save::item_to_nbt(&saddle));
    // rust: } else {
    // rust: equipment.remove(&"saddle".into());
}
    // rust: map.insert("equipment".into(), Tag::Compound(equipment));
}
    // rust: "minecraft:bat" => {
    // rust: map.insert("BatFlags".into(), Tag::Byte(i8::from(m.extra.flag)));
}
    // rust: "minecraft:turtle" => {
    // rust: map.insert("has_egg".into(), Tag::Byte(i8::from(m.extra.flag)));
    // rust: if let Some(home) = m.extra.home {
    // rust: map.insert("home_pos".into(), Tag::IntArray(home.to_vec()));
}
}
    // rust: "minecraft:creaking" => {
            // home_pos: the heart it is bound to.
    // rust: if let Some(home) = m.extra.home {
    // rust: map.insert("home_pos".into(), Tag::IntArray(home.to_vec()));
    // rust: } else {
    // rust: map.remove(&"home_pos".into());
}
}
    // rust: "minecraft:zombie_villager" => {
    // rust: map.insert("VillagerData".into(), villager_data(m));
    // rust: map.insert("VillagerDataFinalized".into(), Tag::Byte(1));
    // rust: let xp = m.extra.trade.as_deref().map_or(0, |t| t.xp);
    // rust: map.insert("Xp".into(), Tag::Int(xp));
    // rust: put_offers(map, m);
    // rust: crate::mobs::zombie_villager::write_nbt(m, map);
}
    // rust: "minecraft:villager" => {
    // rust: map.insert("VillagerData".into(), villager_data(m));
            // A loaded villager with VillagerData is finalized.
    // rust: map.insert("VillagerDataFinalized".into(), Tag::Byte(1));
    // rust: let t = m.extra.trade.as_deref().cloned().unwrap_or_default();
    // rust: map.insert("Xp".into(), Tag::Int(t.xp));
    // rust: map.insert("LastRestock".into(), Tag::Long(t.last_restock));
    // rust: map.insert("RestocksToday".into(), Tag::Int(t.restocks_today));
    // rust: put_offers(map, m);
    // rust: put_memories(map, m);
    // rust: crate::mobs::villager::write_nbt(m, map);
}
        // Dolphin.addAdditionalSaveData: the fish it was fed, and how wet it is.
    // rust: "minecraft:dolphin" => {
    // rust: map.insert("GotFish".into(), Tag::Byte(i8::from(m.extra.flag)));
    // rust: map.insert("Moistness".into(), Tag::Int(m.extra.counter));
}
    // rust: "minecraft:wandering_trader" => {
    // rust: put_offers(map, m);
            // WanderingTrader.addAdditionalSaveData: the visit's countdown and
            // the place it is walking to, a BlockPos codec (an int array).
    // rust: map.insert("DespawnDelay".into(), Tag::Int(m.extra.ints[5]));
    // rust: if let Some(p) = m.extra.point {
                // The trader keeps its target as a position; the tag is a
                // BlockPos, so only the block it is in is saved.
    // rust: map.insert(
    // rust: "wander_target".into(),
    // rust: Tag::IntArray(vec![
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ]),
    // rust: );
}
}
    // rust: "minecraft:axolotl" => {
    // rust: write_axolotl_memories(m, map);
    // rust: map.insert(
    // rust: "Variant".into(),
    // rust: Tag::Int(i32::from(m.extra.variant.min(4))),
    // rust: );
}
    // rust: "minecraft:parrot" => {
    // rust: map.insert(
    // rust: "Variant".into(),
    // rust: Tag::Int(i32::from(m.extra.variant.min(4))),
    // rust: );
    // rust: if let Some(owner) = m.extra.owner {
    // rust: map.insert("Owner".into(), Tag::IntArray(owner.to_vec()));
    // rust: } else {
    // rust: map.remove(&"Owner".into());
}
    // rust: map.insert("Sitting".into(), Tag::Byte(i8::from(m.extra.sitting)));
}
    // rust: "minecraft:salmon" => {
    // rust: let size = SALMON_SIZES[usize::from(m.extra.variant).min(2)];
    // rust: map.insert("type".into(), string(size));
}
        // Pufferfish.addAdditionalSaveData: the puff state (0 small, 1 mid,
        // 2 full).
    // rust: "minecraft:pufferfish" => {
    // rust: map.insert("PuffState".into(), Tag::Int(m.extra.size));
}
        // TropicalFish.addAdditionalSaveData: the packed variant.
    // rust: "minecraft:tropical_fish" => {
    // rust: let pattern = m.extra.variant.min(11);
    // rust: let packed = i32::from(pattern >= 6)
    // rust: | i32::from(pattern % 6) << 8
    // rust: | i32::from(m.extra.variant2 & 15) << 16
    // rust: | i32::from(m.extra.variant3 & 15) << 24;
    // rust: map.insert("Variant".into(), Tag::Int(packed));
}
    // rust: "minecraft:allay" => {
            // InventoryCarrier: the fetched stack; the liked player memory.
    // rust: let inv = crate::mobs::allay::inventory(m)
    // rust: .map(item_to_nbt)
    // rust: .into_iter()
    // rust: .collect();
    // rust: map.insert("Inventory".into(), Tag::List(inv));
    // rust: if let Some(st) = &m.extra.allay {
    // rust: map.insert("listener".into(), st.vibration.to_nbt());
}
    // rust: map.insert(
    // rust: "DuplicationCooldown".into(),
    // rust: Tag::Long(i64::from(m.extra.egg_time)),
    // rust: );
    // rust: let mut memories: Vec<(&str, Tag)> = Vec::new();
    // rust: if m.extra.tame {
    // rust: memories.push((
    // rust: "minecraft:liked_player",
    // rust: Tag::compound([(
    // rust: "value",
    // rust: Tag::IntArray(m.extra.owner.unwrap_or([0, 0, 0, 1]).to_vec()),
    // rust: )]),
    // rust: ));
}
            // GlobalPos.CODEC, and the cooldown while it runs.
    // rust: if let Some(liked) = m.extra.allay.as_ref().and_then(|st| st.noteblock) {
    // rust: memories.push((
    // rust: "minecraft:liked_noteblock",
    // rust: Tag::compound([(
    // rust: "value",
    // rust: Tag::compound([
    // rust: ("dimension", string(liked.dimension)),
    // rust: ("pos", Tag::IntArray(liked.pos.to_vec())),
    // rust: ]),
    // rust: )]),
    // rust: ));
}
    // rust: if m.extra.ints[2] > 0 {
    // rust: memories.push((
    // rust: "minecraft:liked_noteblock_cooldown_ticks",
    // rust: Tag::compound([("value", Tag::Int(m.extra.ints[2]))]),
    // rust: ));
}
            // Always written, so a forgotten note block does not come back
            // from the compound the allay was loaded with.
    // rust: map.insert(
    // rust: "Brain".into(),
    // rust: Tag::compound([("memories", Tag::compound(memories))]),
    // rust: );
}
    // rust: "minecraft:camel" | "minecraft:camel_husk" => {
            // LastPoseTick: the pose change time, negative while sitting. The
            // game time is not known here; the world's save overwrites it
            // with the real one (`camel::synced_pose_tick`).
    // rust: map.insert(
    // rust: "LastPoseTick".into(),
    // rust: Tag::Long(crate::mobs::camel::synced_pose_tick(m, 0)),
    // rust: );
    // rust: if let Some(saddle) = m.saddle_item() {
    // rust: map.insert(
    // rust: "equipment".into(),
    // rust: Tag::compound([("saddle", crate::save::item_to_nbt(&saddle))]),
    // rust: );
    // rust: } else {
    // rust: map.remove(&"equipment".into());
}
}
    // rust: "minecraft:nautilus" | "minecraft:zombie_nautilus" => {
    // rust: crate::mobs::nautilus::to_nbt(m, map);
}
    // rust: "minecraft:sulfur_cube" => crate::mobs::sulfur_cube::to_nbt(m, map),
    // rust: "minecraft:bee" => crate::mobs::bee::to_nbt(m, map),
    // rust: "minecraft:sniffer" => crate::mobs::sniffer::to_nbt(m, map),
    // rust: "minecraft:wither" => {
    // rust: map.insert("Invul".into(), Tag::Int(m.extra.counter));
}
        // IronGolem.addAdditionalSaveData.
    // rust: "minecraft:iron_golem" => {
    // rust: map.insert(
    // rust: "PlayerCreated".into(),
    // rust: Tag::Byte(i8::from(m.extra.player_created)),
    // rust: );
}
    // rust: "minecraft:warden" => {
    // rust: if let Some(st) = &m.extra.warden {
    // rust: map.insert("listener".into(), st.vibration.to_nbt());
    // rust: map.insert("anger".into(), Tag::compound(Vec::<(&str, Tag)>::new()));
}
}
        // Armadillo.addAdditionalSaveData: the time left to the next scute.
    // rust: "minecraft:armadillo" => {
    // rust: map.insert("scute_time".into(), Tag::Int(m.extra.egg_time));
}
    // rust: "minecraft:ravager" => {
    // rust: map.insert("AttackTick".into(), Tag::Int(m.extra.counter));
    // rust: map.insert("StunTick".into(), Tag::Int(m.extra.counter2));
    // rust: map.insert("RoarTick".into(), Tag::Int(m.extra.anim_ticks));
}
    // rust: "minecraft:vex" => {
    // rust: if let Some(h) = m.extra.home {
    // rust: map.insert("bound_pos".into(), Tag::IntArray(h.to_vec()));
}
    // rust: if m.extra.egg_time > 0 {
    // rust: map.insert("life_ticks".into(), Tag::Int(m.extra.egg_time));
}
}
    // rust: "minecraft:endermite" => {
    // rust: map.insert("Lifetime".into(), Tag::Int(m.extra.counter));
}
        // Enderman.addAdditionalSaveData: the block it carries, saved only
        // while it carries one.
    // rust: "minecraft:enderman" => match (m.extra.carried, registry) {
    // rust: (Some(state), Some(registry)) => {
    // rust: map.insert("carriedBlockState".into(), state_to_nbt(registry, state));
}
            // Nothing carries a block state out without the registry, and a
            // caller without one keeps what the loaded compound had, so the
            // key is only dropped when a registry could have written it.
    // rust: (Some(_), None) | (None, None) => {}
    // rust: (None, Some(_)) => {
    // rust: map.remove(&"carriedBlockState".into());
}
    // rust: },
    // rust: "minecraft:shulker" => {
    // rust: map.insert("AttachFace".into(), Tag::Byte(m.extra.variant3 as i8));
    // rust: map.insert("Peek".into(), Tag::Byte(m.extra.counter as i8));
    // rust: map.insert("Color".into(), Tag::Byte(m.extra.color as i8));
}
        // GlowSquid.addAdditionalSaveData.
    // rust: "minecraft:glow_squid" => {
    // rust: map.insert(
    // rust: "DarkTicksRemaining".into(),
    // rust: Tag::Int(crate::mobs::aquatic::dark_ticks(m)),
    // rust: );
}
        // Phantom.addAdditionalSaveData.
    // rust: "minecraft:phantom" => {
    // rust: map.insert("size".into(), Tag::Int(m.extra.size));
}
    // rust: "minecraft:slime" | "minecraft:magma_cube" => {
    // rust: map.insert("Size".into(), Tag::Int(m.extra.size.max(1) - 1));
    // rust: map.insert("wasOnGround".into(), Tag::Byte(i8::from(m.extra.flag2)));
}
        // Skeletons are spawned holding a bow (finalizeSpawn); a mob loaded
        // from NBT keeps only its saved equipment.
    // rust: "minecraft:skeleton" | "minecraft:stray" | "minecraft:bogged"
    // rust: if raw.is_none() && m.extra.main_hand.as_deref() == Some("minecraft:bow") =>
    // rust: {
    // rust: map.entry("equipment".into()).or_insert_with(|| {
    // rust: Tag::compound([(
    // rust: "mainhand",
    // rust: Tag::compound([("id", string("minecraft:bow")), ("count", Tag::Int(1))]),
    // rust: )])
    // rust: });
}
        // Zombie and Skeleton.addAdditionalSaveData (a husk keeps Zombie's):
        // `ConversionTracker`'s conversion and affliction times, -1 when it is
        // not converting or not afflicted.
    // rust: "minecraft:zombie" | "minecraft:husk" => {
    // rust: for (key, value) in [
    // rust: ("DrownedConversionTime", conversion_time(m)),
    // rust: ("InWaterTime", m.extra.counter),
    // rust: ] {
    // rust: map.entry(key.into()).or_insert(Tag::Int(value));
}
}
    // rust: "minecraft:skeleton" => {
    // rust: for (key, value) in [
    // rust: ("StrayConversionTime", conversion_time(m)),
    // rust: ("FreezingTime", m.extra.counter),
    // rust: ] {
    // rust: map.entry(key.into()).or_insert(Tag::Int(value));
}
}
        // Drowned.convertsInWater is false, so its tracker never ticks: vanilla
        // saves -1 for both.
    // rust: "minecraft:drowned" => {
    // rust: for (key, value) in [
    // rust: ("DrownedConversionTime", Tag::Int(-1)),
    // rust: ("InWaterTime", Tag::Int(-1)),
    // rust: ] {
    // rust: map.entry(key.into()).or_insert(value);
}
}
        // Sheep.addAdditionalSaveData: its wool as it is now.
    // rust: "minecraft:sheep" => {
    // rust: map.insert("Color".into(), Tag::Byte((m.extra.color & 15) as i8));
    // rust: map.insert("Sheared".into(), Tag::Byte(i8::from(m.extra.sheared)));
}
        // CopperGolem.addAdditionalSaveData.
    // rust: "minecraft:copper_golem" => {
    // rust: map.insert(
    // rust: "next_weather_age".into(),
    // rust: Tag::Long(m.extra.vector[0] as i64),
    // rust: );
    // rust: map.insert(
    // rust: "weather_state".into(),
    // rust: string(crate::mobs::copper_golem::WEATHER[m.extra.variant.min(3) as usize]),
    // rust: );
}
        // Ghast.addAdditionalSaveData; Horizon's ghast fires power 1 whatever
        // is saved, so a loaded value is kept as is.
    // rust: "minecraft:ghast" => {
    // rust: map.entry("ExplosionPower".into()).or_insert(Tag::Byte(1));
}
    // rust: _ => {}
}
    // Zombie.addAdditionalSaveData: CanBreakDoors.
    // rust: if crate::mobs::doors::is_zombie(m.species()) {
    // rust: map.insert(
    // rust: "CanBreakDoors".into(),
    // rust: Tag::Byte(i8::from(m.extra.can_break_doors)),
    // rust: );
        // ConversionTracker.addAdditionalSaveData reads isAfflicted at save
        // time. Zombie supplies its cached isEyeInFluid(WATER), even with NoAI.
    // rust: if !m.fluids.eye_in_water {
    // rust: map.insert("InWaterTime".into(), Tag::Int(-1));
}
}
    // rust: if matches!(
    // rust: id,
    // rust: "minecraft:zombie"
    // rust: | "minecraft:husk"
    // rust: | "minecraft:drowned"
    // rust: | "minecraft:zombie_villager"
    // rust: | "minecraft:zombified_piglin"
    // rust: | "minecraft:piglin"
    // rust: | "minecraft:zoglin"
    // rust: ) {
    // rust: map.insert("IsBaby".into(), Tag::Byte(i8::from(m.is_baby())));
}
    // NeutralMob.addPersistentAngerSaveData; the bee saves its own.
    // rust: if matches!(
    // rust: id,
    // rust: "minecraft:iron_golem"
    // rust: | "minecraft:wolf"
    // rust: | "minecraft:polar_bear"
    // rust: | "minecraft:zombified_piglin"
    // rust: | "minecraft:enderman"
    // rust: ) {
    // rust: map.entry("anger_end_time".into()).or_insert(Tag::Long(-1));
}
    // rust: if let Some(a) = m.extra.attributes.as_deref() {
    // rust: put_attributes(map, m, a);
}
    // The attribute their load makes, which AttributeMap.pack then saves:
    // Zombie and Piglin.setBaby (even for an adult) the speed, Rabbit.setVariant
    // the attack damage.
//     use crate::mobs::finalize::Attr;
    // Every other living entity's first tick makes the movement_speed instance
    // (LivingEntity.removeFrost reads it through getAttribute).
    // rust: let made = if species == crate::mobs::Species::Rabbit {
    // rust: vec![Attr::MovementSpeed, Attr::AttackDamage]
    // rust: } else {
    // rust: vec![Attr::MovementSpeed]
}
    // rust: for attr in made {
    // rust: let base = crate::mobs::finalize::base_value(m, attr);
    // rust: let mut list = match map.get(&"attributes".into()) {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
    // rust: let attr_id = format!("minecraft:{}", attr.name());
    // rust: if !list
    // rust: .iter()
    // rust: .any(|t| text(t.get("id")).as_deref() == Some(attr_id.as_str()))
    // rust: {
    // rust: list.push(Tag::compound([
    // rust: ("id", string(&attr_id)),
    // rust: ("base", Tag::Double(base.to_bits())),
    // rust: ]));
    // rust: map.insert("attributes".into(), Tag::List(list));
}
}
    // Mob.addAdditionalSaveData: the chances that are not the default.
    // rust: if let Some(chances) = &m.extra.drop_chances {
    // rust: let set: Vec<(&str, Tag)> = crate::mobs::drops::SLOTS
    // rust: .iter()
    // rust: .zip(chances.iter())
    // rust: .filter(|(_, c)| **c != crate::mobs::drops::DEFAULT_DROP_CHANCE)
    // rust: .map(|(slot, c)| (*slot, Tag::Float(c.to_bits())))
    // rust: .collect();
    // rust: if set.is_empty() {
    // rust: map.remove(&"drop_chances".into());
    // rust: } else {
    // rust: map.insert("drop_chances".into(), Tag::compound(set));
}
}
    // rust: crate::mobs::raider::write_nbt(m, map);
    // rust: crate::mobs::riders::write_nbt(m, map);
    // LivingEntity equipment: what the mob holds now.
    // rust: if !crate::mobs::equine::is_equine(m.species()) {
    // rust: let mut equipment = match map.get(&"equipment".into()) {
    // rust: Some(Tag::Compound(c)) => c.clone(),
    // rust: _ => horizon_world::nbt::Compound::new(),
}
    // rust: for (index, (slot, item)) in [
    // rust: ("mainhand", &m.extra.main_hand),
    // rust: ("offhand", &m.extra.off_hand),
    // rust: ("head", &m.extra.head),
    // rust: ("chest", &m.extra.chest),
    // rust: ("legs", &m.extra.legs),
    // rust: ("feet", &m.extra.feet),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: if slot == "mainhand"
    // rust: && let Some(stack) = m.extra.main_hand_stack()
    // rust: {
    // rust: let mut stack = stack.clone();
    // rust: if let Some(g) = crate::mobs::gear::gear(m) {
    // rust: stack.data_mut().enchantments = g.slots[index].clone();
    // rust: stack.data_mut().trim = g.trims[index].clone();
}
    // rust: equipment.insert(slot.into(), crate::save::item_to_nbt(&stack));
    // rust: continue;
}
            // A worn piece or held item that kept its damage, name or
            // components is saved with them.
    // rust: if slot != "mainhand"
    // rust: && item.is_some()
    // rust: && let Some(stack) = crate::mobs::finalize::stored_stack(
    // rust: m,
    // rust: [
    // rust: crate::mobs::finalize::MAINHAND,
    // rust: crate::mobs::finalize::OFFHAND,
    // rust: crate::mobs::finalize::HEAD,
    // rust: crate::mobs::finalize::CHEST,
    // rust: crate::mobs::finalize::LEGS,
    // rust: crate::mobs::finalize::FEET,
    // rust: ][index],
    // rust: )
    // rust: {
    // rust: equipment.insert(slot.into(), crate::save::item_to_nbt(&stack));
    // rust: continue;
}
            // Enchanted or trimmed gear is saved with its components.
    // rust: if let (Some(id), Some(g)) = (item, crate::mobs::gear::gear(m))
    // rust: && (!g.slots[index].is_empty() || g.trims[index].is_some())
    // rust: {
    // rust: let mut stack = crate::items::ItemStack::new(id, 1);
    // rust: stack.data_mut().enchantments = g.slots[index].clone();
    // rust: stack.data_mut().trim = g.trims[index].clone();
    // rust: equipment.insert(slot.into(), crate::save::item_to_nbt(&stack));
    // rust: continue;
}
    // rust: match item {
    // rust: Some(id) => {
    // rust: let keep = slot != "mainhand"
    // rust: && matches!(
    // rust: equipment.get(&slot.into()).and_then(|e| e.get("id")),
    // rust: Some(Tag::String(s)) if s.to_string_lossy() == **id
    // rust: );
    // rust: if slot == "head"
    // rust: && &**id == crate::mobs::raider::BANNER
    // rust: && crate::mobs::raider::is_raider(m.species())
    // rust: {
                        // The captain's ominous banner keeps its patterns.
    // rust: let has_patterns = equipment
    // rust: .get(&slot.into())
    // rust: .and_then(|e| e.get("components"))
    // rust: .is_some();
    // rust: if !has_patterns {
    // rust: equipment.insert(
    // rust: slot.into(),
    // rust: crate::save::item_to_nbt(&crate::mobs::raider::ominous_banner()),
    // rust: );
}
    // rust: } else if !keep {
    // rust: equipment.insert(
    // rust: slot.into(),
    // rust: Tag::compound([
    // rust: ("id", Tag::String(id.as_ref().into())),
    // rust: ("count", Tag::Int(1)),
    // rust: ]),
    // rust: );
}
}
    // rust: None => {
    // rust: equipment.remove(&slot.into());
}
}
}
        // A happy ghast wears its harness in the body slot (and a nautilus
        // its armour, a sulfur cube its swallowed block, a wolf its armor,
        // with the durability it lost).
    // rust: if crate::mobs::species::body_slot(m.species())
    // rust: && let Some(id) = &m.extra.body
    // rust: {
    // rust: let mut stack = crate::items::ItemStack::new(id, 1);
    // rust: if m.species() == crate::mobs::Species::Wolf {
    // rust: stack.damage = m.extra.body_damage.max(0) as u32;
    // rust: stack.extra = m.extra.body_extra.clone();
}
    // rust: equipment.insert("body".into(), crate::save::item_to_nbt(&stack));
}
        // Vanilla saves `equipment` only when something is equipped.
    // rust: if equipment.is_empty() {
    // rust: map.remove(&"equipment".into());
    // rust: } else {
    // rust: map.insert("equipment".into(), Tag::Compound(equipment));
}
}
    // rust: tag
}
// `AttributeMap.pack` for the attributes with a base or permanent modifier
// finalizeSpawn set, over the saved list.
put_attributes :: proc(map: ^Compound, m: ^Mob, a: ^crate::mobs::finalize::Attributes) {
}
//     use crate::mobs::finalize::{self, Attr, Op};
    // rust: let mut list = match map.get(&"attributes".into()) {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
    // rust: for attr in Attr::ALL {
    // rust: let modifiers: Vec<Tag> = a
    // rust: .modifiers
    // rust: .iter()
    // rust: .filter(|x| x.attr == attr)
    // rust: .map(|x| {
    // rust: let op = match x.op {
    // rust: Op::AddValue => "add_value",
    // rust: Op::AddMultipliedBase => "add_multiplied_base",
    // rust: Op::AddMultipliedTotal => "add_multiplied_total",
}
    // rust: Tag::compound([
    // rust: ("id", string(&x.id)),
    // rust: ("amount", Tag::Double(x.amount.to_bits())),
    // rust: ("operation", string(op)),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: if modifiers.is_empty() && !a.bases.iter().any(|(b, _)| *b == attr) {
    // rust: continue;
}
    // rust: let id = format!("minecraft:{}", attr.name());
    // rust: let mut entry = vec![
    // rust: ("id", string(&id)),
    // rust: ("base", Tag::Double(finalize::base_value(m, attr).to_bits())),
    // rust: ];
    // rust: if !modifiers.is_empty() {
    // rust: entry.push(("modifiers", Tag::List(modifiers)));
}
    // rust: let entry = Tag::compound(entry);
    // rust: match list
    // rust: .iter_mut()
    // rust: .find(|t| text(t.get("id")).as_deref() == Some(id.as_str()))
    // rust: {
    // rust: Some(t) => *t = entry,
    // rust: None => list.push(entry),
}
}
    // rust: map.insert("attributes".into(), Tag::List(list));
}
// `Brain.Packed`: the memories finalizeSpawn set, over the saved ones.
put_brain :: proc(map: ^Compound, m: ^Mob, dimension: string) {
}
    // rust: if m.extra.memories.is_empty() {
    // rust: return;
}
    // rust: let mut memories = match map.get(&"Brain".into()).and_then(|b| b.get("memories")) {
    // rust: Some(Tag::Compound(c)) => c.clone(),
    // rust: _ => Compound::new(),
}
    // rust: for &(name, value, ttl) in &m.extra.memories {
    // rust: let value = match name {
    // rust: "hunted_recently" => Tag::Byte(value as i8),
            // `Unit` memories save an empty compound.
    // rust: "is_pregnant" => Tag::Compound(Compound::new()),
    // rust: "home" => match m.extra.home {
    // rust: Some(p) => Tag::compound([
    // rust: ("dimension", string(dimension)),
    // rust: ("pos", Tag::IntArray(p.to_vec())),
    // rust: ]),
    // rust: None => continue,
    // rust: },
    // rust: _ => Tag::Int(value as i32),
}
    // rust: let mut memory = vec![("value", value)];
    // rust: if ttl != i64::MAX {
    // rust: memory.push(("ttl", Tag::Long(ttl)));
}
    // rust: memories.insert(
    // rust: format!("minecraft:{name}").as_str().into(),
    // rust: Tag::compound(memory),
    // rust: );
}
    // rust: map.insert(
    // rust: "Brain".into(),
    // rust: Tag::compound([("memories", Tag::Compound(memories))]),
    // rust: );
}
// `CustomName`: a text component saved as a string or a `{text: ..}` compound.
custom_name :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag.get("CustomName")? {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: t @ Tag::Compound(_) => match t.get("text") {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
    // rust: },
    // rust: _ => None,
}
}
    // rust: pub use horizon_client_core::component::name_text;
// Mob.finalizeSpawn's follow range bonus in the saved attributes.
    // rust: pub(crate) fn spawn_bonus(tag: &Tag) -> Option<f64> {
    // rust: let Some(Tag::List(attrs)) = tag.get("attributes") else {
    // rust: return None;
}
    // rust: let range = attrs
    // rust: .iter()
    // rust: .find(|a| text(a.get("id")).as_deref() == Some("minecraft:follow_range"))?;
    // rust: let Some(Tag::List(modifiers)) = range.get("modifiers") else {
    // rust: return None;
}
    // rust: let bonus = modifiers
    // rust: .iter()
    // rust: .find(|x| text(x.get("id")).as_deref() == Some("minecraft:random_spawn_bonus"))?;
    // rust: float(bonus.get("amount"))
}
// `Mob.readAdditionalSaveData`: negative radii retain the live homePosition.
// Used after the command adapter restores runtime AI, as well as fresh load.
read_mob_home :: proc(m: ^Mob, tag: ^Tag) {
}
    // rust: let radius = match tag.get("home_radius") {
    // rust: Some(Tag::Float(v)) => Some(f32::from_bits(*v).floor() as i32),
    // rust: Some(Tag::Double(v)) => Some(f64::from_bits(*v).floor() as i32),
    // rust: other => number(other).map(|v| v as i32),
}
    // rust: .unwrap_or(-1);
    // rust: let pos = if radius >= 0 {
    // rust: home_block_pos(tag.get("home_pos")).unwrap_or([0; 3])
    // rust: } else {
    // rust: m.ai.home_position()
}
    // rust: m.ai.restore_home(pos, radius);
}
// `BlockPos.CODEC` through NbtOps.getIntStream: numeric collection entries
// use Java Number's int conversion (floating entries truncate, unlike getIntOr above).
home_block_pos :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag? {
    // rust: Tag::IntArray(v) => v.as_slice().try_into().ok(),
    // rust: Tag::ByteArray(v) if v.len() == 3 => Some([
    // rust: i32::from(v[0] as i8),
    // rust: i32::from(v[1] as i8),
    // rust: i32::from(v[2] as i8),
    // rust: ]),
    // rust: Tag::LongArray(v) if v.len() == 3 => Some([v[0] as i32, v[1] as i32, v[2] as i32]),
    // rust: Tag::List(v) if v.len() == 3 => {
    // rust: let int = |t: &Tag| match t {
    // rust: Tag::Float(v) => Some(f32::from_bits(*v) as i32),
    // rust: Tag::Double(v) => Some(f64::from_bits(*v) as i32),
    // rust: other => number(Some(other)).map(|v| v as i32),
}
    // rust: Some([int(&v[0])?, int(&v[1])?, int(&v[2])?])
}
    // rust: _ => None,
}
}
// The mob a saved compound describes. `registry` is what reads a field holding
// a block state (an enderman's `carriedBlockState`); without one, such a field
// is left out, as it was before it was modelled.
    // rust: pub fn mob_from_nbt(
    // rust: tag: &Tag,
    // rust: types: &HashMap<String, Arc<MobType>>,
    // rust: id: u32,
    // rust: registry: Option<&BlockRegistry>,
    // rust: ) -> Option<Mob> {
    // rust: let kind = types.get(&self::kind(tag)?)?.clone();
    // rust: let position = position(tag)?;
    // rust: let [yaw, pitch] = rotation(tag);
    // rust: let mut m = Mob::new(id, kind, position, yaw);
    // rust: m.velocity = motion(tag);
    // rust: m.head_pitch = pitch;
    // rust: read_mob_home(&mut m, tag);
    // rust: m.on_ground = flag(tag, "OnGround");
    // rust: m.fall_distance = float(tag.get("fall_distance")).unwrap_or(0.0);
    // LivingEntity.readAdditionalSaveData: the saved attribute bases, then
    // the health, the max health when there is none.
    // rust: if let Some(Tag::List(attrs)) = tag.get("attributes") {
    // rust: for a in attrs {
    // rust: let (Some(id), Some(Tag::Double(bits))) = (text(a.get("id")), a.get("base")) else {
    // rust: continue;
}
    // rust: let v = f64::from_bits(*bits);
            // A mount's rolled health and speed stay attribute bases, which
            // the server syncs (its hearts over the rider's hotbar).
    // rust: let equine = crate::mobs::equine::is_equine(m.species());
    // rust: match id.as_str() {
    // rust: "minecraft:max_health" if equine => crate::mobs::finalize::set_base(
    // rust: &mut m,
    // rust: crate::mobs::finalize::Attr::MaxHealth,
    // rust: v,
    // rust: ),
    // rust: "minecraft:movement_speed" if equine => crate::mobs::finalize::set_base(
    // rust: &mut m,
    // rust: crate::mobs::finalize::Attr::MovementSpeed,
    // rust: v,
    // rust: ),
                // A saved base other than the type's default is the
                // attribute's base, which `/attribute ... base get` reads.
    // rust: "minecraft:max_health"
    // rust: if crate::mobs::finalize::default_value(
    // rust: &m,
    // rust: crate::mobs::finalize::Attr::MaxHealth,
    // rust: ) != Some(v) =>
    // rust: {
    // rust: crate::mobs::finalize::set_base(
    // rust: &mut m,
    // rust: crate::mobs::finalize::Attr::MaxHealth,
    // rust: v,
    // rust: )
}
    // rust: "minecraft:max_health" => m.attrs.max_health = v as f32,
    // rust: "minecraft:movement_speed"
    // rust: if crate::mobs::finalize::default_value(
    // rust: &m,
    // rust: crate::mobs::finalize::Attr::MovementSpeed,
    // rust: ) != Some(v) =>
    // rust: {
    // rust: crate::mobs::finalize::set_base(
    // rust: &mut m,
    // rust: crate::mobs::finalize::Attr::MovementSpeed,
    // rust: v,
    // rust: )
}
    // rust: "minecraft:movement_speed" => m.attrs.speed = v,
    // rust: "minecraft:attack_damage"
    // rust: if crate::mobs::finalize::default_value(
    // rust: &m,
    // rust: crate::mobs::finalize::Attr::AttackDamage,
    // rust: ) != Some(v) =>
    // rust: {
    // rust: crate::mobs::finalize::set_base(
    // rust: &mut m,
    // rust: crate::mobs::finalize::Attr::AttackDamage,
    // rust: v,
    // rust: )
}
    // rust: "minecraft:attack_damage" => m.attrs.attack_damage = v as f32,
    // rust: "minecraft:attack_knockback" => m.attrs.attack_knockback = v,
    // rust: "minecraft:flying_speed"
    // rust: if crate::mobs::finalize::default_value(
    // rust: &m,
    // rust: crate::mobs::finalize::Attr::FlyingSpeed,
    // rust: ) != Some(v) =>
    // rust: {
    // rust: crate::mobs::finalize::set_base(
    // rust: &mut m,
    // rust: crate::mobs::finalize::Attr::FlyingSpeed,
    // rust: v,
    // rust: )
}
    // rust: _ => {}
}
}
}
    // rust: if let Some(bonus) = spawn_bonus(tag) {
//         use crate::mobs::finalize::{Attr, Op, add_modifier};
    // rust: let id = "minecraft:random_spawn_bonus";
    // rust: add_modifier(&mut m, Attr::FollowRange, id, bonus, Op::AddMultipliedBase);
}
    // rust: m.health = float(tag.get("Health")).map_or(m.attrs.max_health, |h| h as f32);
    // rust: m.absorption = float(tag.get("AbsorptionAmount"))
    // rust: .map_or(0.0, |h| h as f32)
    // rust: .max(0.0);
    // LivingEntity.setHealth clamps to the max health: a horse or llama is made
    // with the type's and saved before it drops to the one it rolled. (Only
    // the base is read here, so the clamp would cut a leader zombie's bonus.)
    // rust: if crate::mobs::equine::is_equine(m.species()) {
    // rust: m.health = m.health.min(m.attrs.max_health);
}
    // rust: m.hurt_time = number(tag.get("HurtTime")).unwrap_or(0) as i32;
    // What it holds (equipment.mainhand / offhand), when saved.
    // rust: if let Some(eq) = tag.get("equipment") {
    // rust: m.extra
    // rust: .set_main_hand_stack(eq.get("mainhand").and_then(crate::save::item_from_nbt));
    // rust: m.extra.off_hand = eq
    // rust: .get("offhand")
    // rust: .and_then(|i| text(i.get("id")))
    // rust: .map(Into::into);
    // rust: if !crate::mobs::equine::is_equine(m.species()) {
    // rust: let slot = |key| eq.get(key).and_then(|i| text(i.get("id"))).map(Into::into);
    // rust: m.extra.head = slot("head");
            // A happy ghast wears its harness in the body slot (and a
            // nautilus its armour, a sulfur cube its swallowed block).
    // rust: if crate::mobs::species::body_slot(m.species()) {
    // rust: m.extra.body = slot("body");
}
    // rust: m.extra.chest = slot("chest");
    // rust: m.extra.legs = slot("legs");
    // rust: m.extra.feet = slot("feet");
}
        // Their enchantments and trims.
    // rust: for (index, key) in crate::mobs::gear::KEYS.iter().enumerate() {
    // rust: if let Some(stack) = eq.get(key).and_then(crate::save::item_from_nbt) {
    // rust: crate::mobs::gear::set(&mut m, index, stack.enchantments().to_vec());
    // rust: let trim = stack.data().and_then(|d| d.trim.clone());
    // rust: crate::mobs::gear::set_trim(&mut m, index, trim);
                // The damage, name and components stay with the slot.
    // rust: if index != crate::mobs::gear::MAIN {
    // rust: crate::mobs::gear::set_stack(&mut m, index, stack);
}
}
}
    // rust: } else {
        // Registration hands out default weapons (finalizeSpawn does in
        // vanilla); a loaded mob holds only what its file lists.
    // rust: m.extra.set_main_hand(None);
}
    // rust: m.death_time = number(tag.get("DeathTime")).unwrap_or(0) as i32;
    // Mob.readAdditionalSaveData overrides what the constructor set (copper
    // golems and elder guardians start persistent).
    // rust: m.persistent = flag(tag, "PersistenceRequired");
    // rust: m.extra.death_loot_table = text(tag.get("DeathLootTable"))
    // rust: .and_then(|t| horizon_client_core::identifier::normalize_id(&t));
    // rust: m.extra.death_loot_seed = number(tag.get("DeathLootTableSeed")).unwrap_or(0);
    // `NeutralMob.readPersistentAngerSaveData`: the anger end time and the
    // target come back with the mob.
    // rust: if persistent_anger(m.species()) {
    // rust: m.extra.anger_end = number(tag.get("anger_end_time")).unwrap_or(-1);
    // rust: if tag
    // rust: .get("angry_at")
    // rust: .is_some_and(|t| uuid_from_tag(Some(t)) == Some(player_uuid()))
    // rust: {
    // rust: m.extra.angry_at = Some(crate::mobs::Who::Player);
}
}
    // `Mannequin.readAdditionalSaveData`: the profile comes back with the skin, then
    // validated pose, `immovable`, `hide_description` and `description` (`updateDescription`).
    // rust: if m.species() == crate::mobs::Species::Mannequin {
    // rust: m.profile = tag.get("profile").and_then(profile_from_nbt);
        // Mannequin.POSE_CODEC accepts only these Avatar poses; an invalid
        // or absent value defaults to standing before the live dimensions read it.
    // rust: m.extra.avatar_pose = match text(tag.get("pose")).as_deref() {
    // rust: Some("crouching") => crate::pose::Pose::Crouching,
    // rust: Some("swimming") => crate::pose::Pose::Swimming,
    // rust: Some("fall_flying") => crate::pose::Pose::FallFlying,
    // rust: Some("sleeping") => crate::pose::Pose::Sleeping,
    // rust: _ => crate::pose::Pose::Standing,
}
    // rust: m.extra.immovable = flag(tag, "immovable");
    // rust: m.extra.description = if flag(tag, "hide_description") {
    // rust: crate::mobs::MannequinDescription::Hidden
    // rust: } else {
    // rust: crate::mobs::MannequinDescription::from_component(Some(
    // rust: &tag.get("description")
    // rust: .cloned()
    // rust: .or_else(|| crate::mobs::MannequinDescription::Default.component())
    // rust: .unwrap_or(Tag::End),
    // rust: ))
}
}
    // rust: m.extra.pick_up_loot = flag(tag, "CanPickUpLoot");
    // rust: m.custom_name = custom_name(tag);
    // rust: m.custom_name_text = tag.get("CustomName").map(name_text);
    // rust: m.extra.left_handed = flag(tag, "LeftHanded");
    // rust: if let Some(Tag::Compound(c)) = tag.get("drop_chances") {
    // rust: let mut chances = [crate::mobs::drops::DEFAULT_DROP_CHANCE; 8];
    // rust: for (chance, slot) in chances.iter_mut().zip(crate::mobs::drops::SLOTS) {
    // rust: if let Some(Tag::Float(v)) = c.get(&slot.into()) {
    // rust: *chance = f32::from_bits(*v);
}
}
    // rust: m.extra.drop_chances = Some(Box::new(chances));
}
    // rust: if saves_age(m.species()) {
    // rust: m.extra.age = number(tag.get("Age")).unwrap_or(0) as i32;
    // rust: m.extra.forced_age = number(tag.get("ForcedAge")).unwrap_or(0) as i32;
    // rust: m.extra.age_locked = flag(tag, "AgeLocked");
}
    // rust: if is_animal(&m.kind.id) {
    // rust: m.extra.in_love = number(tag.get("InLove")).unwrap_or(0) as i32;
        // Animal.readAdditionalSaveData: the player who fed it into love.
    // rust: m.extra.love_cause = crate::save::uuid_from_tag(tag.get("LoveCause"));
}
    // rust: m.name_visible = flag(tag, "CustomNameVisible");
    // rust: m.no_ai = flag(tag, "NoAI");
    // rust: m.no_gravity = flag(tag, "NoGravity");
    // rust: m.glowing = flag(tag, "Glowing");
    // rust: m.ticks_frozen = number(tag.get("TicksFrozen")).unwrap_or(0) as i32;
    // LivingEntity.readAdditionalSaveData: the saved `active_effects`, the last
    // entry of an effect winning.
    // rust: if let Some(Tag::List(effects)) = tag.get("active_effects") {
    // rust: for e in effects {
    // rust: let Some(def) = text(e.get("id")).and_then(|id| crate::brewing::effect(&id)) else {
    // rust: continue;
}
    // rust: let effect = crate::brewing::namespaced(def.id);
    // rust: let duration = number(e.get("duration")).unwrap_or(0) as i32;
    // rust: let amplifier = number(e.get("amplifier")).unwrap_or(0) as i32;
    // rust: m.extra.effects.retain(|x| x.0 != effect);
    // rust: m.extra.effects.push((effect, duration, amplifier));
            // Details.CODEC: `show_particles` defaults to true.
    // rust: m.extra.hidden_effects.retain(|h| *h != effect);
    // rust: if number(e.get("show_particles")) == Some(0) {
    // rust: m.extra.hidden_effects.push(effect);
}
            // Details.CODEC: `ambient` defaults to false.
    // rust: m.extra.ambient_effects.retain(|h| *h != effect);
    // rust: if number(e.get("ambient")).is_some_and(|a| a != 0) {
    // rust: m.extra.ambient_effects.push(effect);
}
}
}
    // rust: m.silent = flag(tag, "Silent");
    // rust: m.invulnerable_flag = flag(tag, "Invulnerable");
    // rust: if m.species() == crate::mobs::Species::Bat {
        // Bat.readAdditionalSaveData: BatFlags bit 0, resting.
    // rust: m.extra.flag = number(tag.get("BatFlags")).unwrap_or(0) & 1 != 0;
}
    // rust: if m.species() == crate::mobs::Species::Creeper {
    // rust: m.extra.charged = flag(tag, "powered");
        // Creeper.readAdditionalSaveData: `ignited` lights the fuse.
    // rust: m.extra.flag = flag(tag, "ignited");
    // rust: m.max_swell = number(tag.get("Fuse")).unwrap_or(30) as i16 as i32;
}
    // rust: if matches!(
    // rust: m.species(),
    // rust: crate::mobs::Species::Piglin
    // rust: | crate::mobs::Species::PiglinBrute
    // rust: | crate::mobs::Species::Hoglin
    // rust: ) {
    // rust: m.extra.flag2 = flag(tag, "IsImmuneToZombification");
    // rust: m.extra.counter2 = number(tag.get("TimeInOverworld")).unwrap_or(0) as i32;
    // rust: if m.species() == crate::mobs::Species::Hoglin {
    // rust: m.extra.cannot_be_hunted = flag(tag, "CannotBeHunted");
}
    // rust: if m.species() == crate::mobs::Species::Piglin
    // rust: && let Some(Tag::List(items)) = tag.get("Inventory")
    // rust: {
            // InventoryCarrier.readInventoryFromTag (eight slots).
    // rust: m.extra.inventory = items
    // rust: .iter()
    // rust: .filter_map(crate::save::item_from_nbt)
    // rust: .take(8)
    // rust: .collect();
}
}
    // rust: if matches!(
    // rust: m.species(),
    // rust: crate::mobs::Species::Pig | crate::mobs::Species::Strider
    // rust: ) {
    // rust: let saddle = tag
    // rust: .get("equipment")
    // rust: .and_then(|e| e.get("saddle"))
    // rust: .and_then(crate::save::item_from_nbt);
    // rust: if saddle.is_some() || flag(tag, "Saddle") {
    // rust: m.set_saddle(Some(saddle.unwrap_or_else(|| {
    // rust: crate::items::ItemStack::new("minecraft:saddle", 1)
    // rust: })));
}
}
    // rust: if crate::mobs::equine::is_equine(m.species()) {
    // rust: m.extra.tame = flag(tag, "Tame");
    // rust: m.extra.variant3 = number(tag.get("Temper")).unwrap_or(0).clamp(0, 100) as u8;
    // rust: m.extra.bred = flag(tag, "Bred");
    // rust: m.extra.owner = crate::save::uuid_from_tag(tag.get("Owner"));
    // rust: let v = number(tag.get("Variant")).unwrap_or(0) as i32;
    // rust: m.extra.variant = (v & 0xFF).clamp(0, 6) as u8;
    // rust: m.extra.variant2 = ((v >> 8) & 0xFF).clamp(0, 4) as u8;
    // rust: if crate::mobs::llama::is_llama(m.species()) {
    // rust: crate::mobs::llama::from_nbt(&mut m, tag);
}
    // rust: m.extra.chested = flag(tag, "ChestedHorse");
    // rust: if m.extra.chested {
    // rust: m.extra.items = crate::save::decode_items(tag.get("Items"), 15);
}
    // rust: let eq = tag.get("equipment");
    // rust: m.set_saddle(
    // rust: eq.and_then(|e| e.get("saddle"))
    // rust: .and_then(crate::save::item_from_nbt),
    // rust: );
    // rust: m.extra.body = eq
    // rust: .and_then(|e| e.get("body"))
    // rust: .and_then(|b| text(b.get("id")))
    // rust: .map(Into::into);
    // rust: m.extra.head = eq
    // rust: .and_then(|e| e.get("head"))
    // rust: .and_then(|b| text(b.get("id")))
    // rust: .map(Into::into);
    // rust: if let Some(Tag::List(attrs)) = tag.get("attributes") {
    // rust: for a in attrs {
    // rust: let (Some(id), Some(Tag::Double(bits))) = (text(a.get("id")), a.get("base")) else {
    // rust: continue;
}
    // rust: if id == "minecraft:jump_strength" {
    // rust: m.extra.vector[0] = f64::from_bits(*bits);
}
}
}
    // rust: if m.extra.vector[0] <= 0.0 {
    // rust: m.extra.vector[0] = 0.7;
}
}
    // rust: if crate::mobs::finalize::saves_variant_name(m.species())
    // rust: && let Some(v) = text(tag.get("variant"))
    // rust: {
    // rust: m.extra.variant = crate::mobs::finalize::variant_index(m.species(), &v);
}
    // rust: if m.species() == crate::mobs::Species::Chicken
    // rust: && let Some(t) = number(tag.get("EggLayTime"))
    // rust: {
    // rust: m.extra.egg_time = t as i32;
}
    // rust: if let Some(v) = text(tag.get("sound_variant")) {
    // rust: let v = v.trim_start_matches("minecraft:");
    // rust: let sounds = crate::mobs::finalize::sound_variants(m.species());
    // rust: m.extra.sound_variant = sounds.iter().position(|n| *n == v).map(|i| i as u8);
}
    // rust: match m.species() {
    // rust: crate::mobs::Species::Fox => {
    // rust: m.extra.variant = u8::from(text(tag.get("Type")).as_deref() == Some("snow"));
            // Fox.readAdditionalSaveData: clearTrusted, then addTrustedEntity for
            // each of "Trusted".
    // rust: crate::mobs::fox::clear_trusted(&mut m);
    // rust: if let Some(Tag::List(trusted)) = tag.get("Trusted") {
    // rust: for uuid in trusted
    // rust: .iter()
    // rust: .filter_map(|t| crate::save::uuid_from_tag(Some(t)))
    // rust: {
    // rust: crate::mobs::fox::add_trusted_entity(&mut m, uuid);
}
}
            // Fox.readAdditionalSaveData: the sleeping, sitting and crouching flags.
    // rust: for (key, bit) in [
    // rust: ("Sleeping", crate::mobs::fox::SLEEPING),
    // rust: ("Sitting", crate::mobs::fox::SITTING),
    // rust: ("Crouching", crate::mobs::fox::CROUCHING),
    // rust: ] {
    // rust: if flag(tag, key) {
    // rust: m.extra.ints[0] |= bit;
}
}
}
        // MushroomCow.readAdditionalSaveData: a missing or unknown name is
        // Variant.DEFAULT, red; stew_effects decodes like the component's list.
    // rust: crate::mobs::Species::Mooshroom => {
    // rust: m.extra.variant = u8::from(text(tag.get("Type")).as_deref() == Some("brown"));
    // rust: if let Some(Tag::List(list)) = tag.get("stew_effects") {
    // rust: m.extra.stew_effects = list
    // rust: .iter()
    // rust: .map(|entry| {
    // rust: Some((
    // rust: Arc::from(text(entry.get("id"))?.as_str()),
    // rust: number(entry.get("duration")).unwrap_or(160) as i32,
    // rust: ))
    // rust: })
    // rust: .collect();
}
}
    // rust: crate::mobs::Species::Rabbit => {
            // Rabbit.Variant.byId: an unknown id is brown.
    // rust: m.extra.variant = match number(tag.get("RabbitType")).unwrap_or(0) {
    // rust: v @ (0..=5 | 99) => v as u8,
    // rust: _ => 0,
}
}
    // rust: crate::mobs::Species::Goat => {
    // rust: m.extra.screaming = flag(tag, "IsScreamingGoat");
    // rust: let horn = |key| number(tag.get(key)).is_some_and(|v| v == 0);
    // rust: m.extra.lost_horns = [horn("HasLeftHorn"), horn("HasRightHorn")];
}
    // rust: _ => {}
}
    // `Rabbit.readAdditionalSaveData`.
    // rust: if m.species() == crate::mobs::Species::Rabbit {
    // rust: m.extra.more_carrot_ticks = number(tag.get("MoreCarrotTicks")).unwrap_or(0) as i32;
}
    // `Ocelot.readAdditionalSaveData`.
    // rust: if m.species() == crate::mobs::Species::Ocelot {
    // rust: m.extra.trusting = flag(tag, "Trusting");
}
    // rust: if m.species() == crate::mobs::Species::Cat {
    // rust: m.extra.owner = crate::save::uuid_from_tag(tag.get("Owner"));
    // rust: m.extra.tame = m.extra.owner.is_some();
    // rust: m.extra.sitting = flag(tag, "Sitting");
    // rust: m.extra.color =
    // rust: number(tag.get("CollarColor")).map_or(crate::mobs::tame::RED, |c| (c as u8) & 15);
}
    // rust: if m.species() == crate::mobs::Species::Panda {
    // rust: let gene = |key| text(tag.get(key)).map_or(0, |n| crate::mobs::panda::gene_from_name(&n));
    // rust: m.extra.variant = gene("MainGene");
    // rust: m.extra.variant2 = gene("HiddenGene");
}
    // rust: if m.species() == crate::mobs::Species::Parrot {
    // rust: m.extra.owner = crate::save::uuid_from_tag(tag.get("Owner"));
    // rust: m.extra.tame = m.extra.owner.is_some();
    // rust: m.extra.sitting = flag(tag, "Sitting");
}
    // rust: if m.species() == crate::mobs::Species::Wolf {
    // rust: let health = m.health;
    // rust: m.extra.owner = crate::save::uuid_from_tag(tag.get("Owner"));
    // rust: let tame = m.extra.owner.is_some();
    // rust: crate::mobs::tame::set_tame(&mut m, tame);
    // rust: m.health = health;
    // rust: m.extra.sitting = flag(tag, "Sitting");
    // rust: let armor = tag
    // rust: .get("equipment")
    // rust: .and_then(|e| e.get("body"))
    // rust: .and_then(crate::save::item_from_nbt);
    // rust: m.extra.body_damage = armor.as_ref().map_or(0, |s| s.damage as i32);
    // rust: m.extra.body_extra = armor.and_then(|s| s.extra);
    // rust: m.extra.color =
    // rust: number(tag.get("CollarColor")).map_or(crate::mobs::tame::RED, |c| (c as u8) & 15);
}
    // rust: if matches!(
    // rust: m.species(),
    // rust: crate::mobs::Species::Villager | crate::mobs::Species::WanderingTrader
    // rust: ) {
    // rust: read_villager(&mut m, tag);
}
    // rust: if m.species() == crate::mobs::Species::ZombieVillager {
    // rust: read_villager(&mut m, tag);
    // rust: let xp = number(tag.get("Xp")).unwrap_or(0) as i32;
    // rust: if xp != 0 {
    // rust: m.extra.trade.get_or_insert_with(Default::default).xp = xp;
}
    // rust: crate::mobs::zombie_villager::read_nbt(&mut m, tag);
}
    // rust: if m.species() == crate::mobs::Species::Dolphin {
        // Dolphin.readAdditionalSaveData: a save that names neither field is an
        // unfed dolphin at full moistness.
    // rust: m.extra.flag = flag(tag, "GotFish");
    // rust: m.extra.counter = number(tag.get("Moistness")).unwrap_or(2400) as i32;
}
    // rust: if m.species() == crate::mobs::Species::Axolotl {
    // rust: restore_axolotl_memories(&mut m, tag);
}
    // rust: read_variant(&mut m, tag);
    // rust: m.fire_ticks = number(tag.get("Fire")).unwrap_or(0) as i32;
    // Entity.load: `input.getIntOr("Air", getMaxAirSupply())`, 4800 for a dolphin.
    // rust: m.air = number(tag.get("Air")).map_or(m.max_air_supply(), |air| air as i32);
    // rust: if m.species() == crate::mobs::Species::Allay {
    // rust: if let Some(Tag::List(inv)) = tag.get("Inventory") {
    // rust: for stack in inv.iter().filter_map(item_from_nbt) {
    // rust: let max = m.kind.inventory_stack_limit(&stack);
    // rust: if let Some(st) = m.extra.allay.as_mut() {
    // rust: st.add(stack, max);
}
}
}
    // rust: m.extra.egg_time = number(tag.get("DuplicationCooldown")).unwrap_or(0) as i32;
    // rust: if let (Some(st), Some(listener)) = (m.extra.allay.as_mut(), tag.get("listener")) {
    // rust: st.vibration = crate::sculk::Data::from_nbt(listener);
}
    // rust: let liked = tag
    // rust: .get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|b| b.get("minecraft:liked_player"));
    // rust: m.extra.tame = liked.is_some();
    // rust: m.extra.owner = liked
    // rust: .and_then(|l| l.get("value"))
    // rust: .and_then(|v| crate::save::uuid_from_tag(Some(v)));
    // rust: let memory = |key: &str| {
    // rust: tag.get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|b| b.get(key))
    // rust: .and_then(|l| l.get("value"))
}
    // rust: m.extra.ints[2] =
    // rust: number(memory("minecraft:liked_noteblock_cooldown_ticks")).unwrap_or(0) as i32;
    // rust: if let Some(st) = m.extra.allay.as_mut()
    // rust: && let Some(noteblock) = memory("minecraft:liked_noteblock")
    // rust: && let Some(Tag::IntArray(p)) = noteblock.get("pos")
    // rust: && p.len() == 3
    // rust: {
    // rust: st.noteblock = Some(crate::mobs::allay::GlobalPos {
    // rust: dimension: crate::mobs::allay::dimension_id(
    // rust: &text(noteblock.get("dimension")).unwrap_or_default(),
    // rust: ),
    // rust: pos: [p[0], p[1], p[2]],
    // rust: });
}
}
    // rust: if m.species() == crate::mobs::Species::Frog
    // rust: && tag
    // rust: .get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|b| b.get("minecraft:is_pregnant"))
    // rust: .is_some()
    // rust: {
    // rust: crate::mobs::frog::set_pregnant(&mut m, true);
}
    // rust: if crate::mobs::camel::is_camel(m.species()) {
        // The tick is a game time: `camel::finish_load` puts it on the mob's
        // clock once the world's time is known.
    // rust: let tick = match tag.get("LastPoseTick") {
    // rust: Some(Tag::Long(v)) => *v,
    // rust: _ => 0,
}
    // rust: crate::mobs::camel::stand_up_instantly(&mut m);
    // rust: m.extra.pose_change_tick = tick;
    // rust: m.extra.camel_sitting = tick < 0;
        // Camels are always tame (`Camel.register` in Horizon).
    // rust: m.extra.tame = true;
}
    // rust: if crate::mobs::nautilus::is_nautilus(m.species()) {
    // rust: crate::mobs::nautilus::from_nbt(&mut m, tag);
}
    // rust: if m.species() == crate::mobs::Species::SulfurCube {
    // rust: crate::mobs::sulfur_cube::from_nbt(&mut m, tag);
}
    // rust: if m.species() == crate::mobs::Species::Bee {
    // rust: crate::mobs::bee::from_nbt(&mut m, tag);
}
    // rust: if m.species() == crate::mobs::Species::Creaking
    // rust: && let Some(Tag::IntArray(home)) = tag.get("home_pos")
    // rust: && home.len() == 3
    // rust: {
    // rust: crate::mobs::creaking::set_transient(&mut m, [home[0], home[1], home[2]]);
}
    // rust: if m.species() == crate::mobs::Species::Turtle {
        // Turtle.readAdditionalSaveData: `home_pos` (else where it stands) and `has_egg`.
    // rust: m.extra.flag = flag(tag, "has_egg");
    // rust: m.extra.home = Some(match tag.get("home_pos") {
    // rust: Some(Tag::IntArray(home)) if home.len() == 3 => [home[0], home[1], home[2]],
    // rust: _ => [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ],
    // rust: });
}
    // rust: if m.species() == crate::mobs::Species::Wither {
    // rust: m.extra.counter = number(tag.get("Invul")).unwrap_or(0) as i32;
}
    // rust: if m.species() == crate::mobs::Species::Sniffer {
    // rust: crate::mobs::sniffer::from_nbt(&mut m, tag);
}
    // rust: if m.species() == crate::mobs::Species::CopperGolem {
        // CopperGolem.readAdditionalSaveData: -1 (unset) when missing.
    // rust: m.extra.vector[0] = match tag.get("next_weather_age") {
    // rust: Some(Tag::Long(v)) => *v as f64,
    // rust: _ => -1.0,
}
    // rust: let weather = match tag.get("weather_state") {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: _ => String::new(),
}
    // rust: m.extra.variant = crate::mobs::copper_golem::WEATHER
    // rust: .iter()
    // rust: .position(|w| *w == weather)
    // rust: .unwrap_or(0) as u8;
}
    // rust: m.extra.leash_pending = crate::mobs::leash::pending_from_nbt(tag.get("leash"));
    // rust: if m.species() == crate::mobs::Species::Warden {
        // The brain starts afresh: a minute before it digs back down.
    // rust: crate::mobs::warden::finalize(&mut m, false, &mut Vec::new());
    // rust: if let (Some(st), Some(listener)) = (m.extra.warden.as_mut(), tag.get("listener")) {
    // rust: st.vibration = crate::sculk::Data::from_nbt(listener);
}
}
    // Armadillo.readAdditionalSaveData: keeps the constructor's time when absent.
    // rust: if m.species() == crate::mobs::Species::Armadillo
    // rust: && let Some(t) = number(tag.get("scute_time"))
    // rust: {
    // rust: m.extra.egg_time = t as i32;
}
    // rust: if m.species() == crate::mobs::Species::Ravager {
    // rust: m.extra.counter = number(tag.get("AttackTick")).unwrap_or(0) as i32;
    // rust: m.extra.counter2 = number(tag.get("StunTick")).unwrap_or(0) as i32;
    // rust: m.extra.anim_ticks = number(tag.get("RoarTick")).unwrap_or(0) as i32;
}
    // rust: if m.species() == crate::mobs::Species::Endermite {
    // rust: m.extra.counter = number(tag.get("Lifetime")).unwrap_or(0) as i32;
}
    // rust: if m.species() == crate::mobs::Species::Vex {
    // rust: if let Some(Tag::IntArray(v)) = tag.get("bound_pos")
    // rust: && v.len() == 3
    // rust: {
    // rust: m.extra.home = Some([v[0], v[1], v[2]]);
}
    // rust: m.extra.egg_time = number(tag.get("life_ticks")).map_or(-1, |v| v as i32);
}
    // Sheep.readAdditionalSaveData: white and unsheared when absent.
    // rust: if m.species() == crate::mobs::Species::Sheep {
    // rust: m.extra.color = number(tag.get("Color")).map_or(0, |c| (c as u8) & 15);
    // rust: m.extra.sheared = flag(tag, "Sheared");
}
    // GlowSquid.readAdditionalSaveData: not dimmed when absent.
    // rust: if m.species() == crate::mobs::Species::GlowSquid {
    // rust: crate::mobs::aquatic::set_dark_ticks(
    // rust: &mut m,
    // rust: number(tag.get("DarkTicksRemaining")).unwrap_or(0) as i32,
    // rust: );
}
    // IronGolem.readAdditionalSaveData: not player created when absent.
    // rust: if m.species() == crate::mobs::Species::IronGolem {
    // rust: m.extra.player_created = flag(tag, "PlayerCreated");
}
    // Pufferfish.readAdditionalSaveData: `getIntOr("PuffState", 0)`, at most 2.
    // rust: if m.species() == crate::mobs::Species::Pufferfish {
    // rust: m.extra.size = number(tag.get("PuffState")).unwrap_or(0).min(2) as i32;
}
    // Enderman.readAdditionalSaveData: the block it carried; an air state
    // reads as no block at all.
    // rust: if m.species() == crate::mobs::Species::Enderman
    // rust: && let Some(registry) = registry
    // rust: {
    // rust: m.extra.carried = tag
    // rust: .get("carriedBlockState")
    // rust: .and_then(|t| state_from_nbt(registry, t))
    // rust: .filter(|&state| !is_air(registry, state));
}
    // rust: if m.species() == crate::mobs::Species::Shulker {
    // rust: m.extra.variant3 = number(tag.get("AttachFace")).unwrap_or(0).clamp(0, 5) as u8;
    // rust: m.extra.counter = number(tag.get("Peek")).unwrap_or(0).clamp(0, 100) as i32;
    // rust: m.extra.color = number(tag.get("Color")).map_or(16, |c| c.clamp(0, 16) as u8);
    // rust: m.anim.v[0] = m.extra.counter as f32 * 0.01;
    // rust: m.anim.vo[0] = m.anim.v[0];
        // Shulker.setPos: square on its block.
    // rust: m.position = horizon_core::geometry::Vec3::new(
    // rust: m.position.x.floor() + 0.5,
    // rust: (m.position.y + 0.5).floor(),
    // rust: m.position.z.floor() + 0.5,
    // rust: );
    // rust: m.previous = m.position;
}
    // rust: if matches!(
    // rust: m.species(),
    // rust: crate::mobs::Species::Slime | crate::mobs::Species::MagmaCube
    // rust: ) {
        // AbstractCubeMob.readAdditionalSaveData: the size's attributes, then
        // the saved health, the max health when there is none.
    // rust: crate::mobs::cube::set_size(&mut m, number(tag.get("Size")).unwrap_or(0) as i32 + 1);
    // rust: if let Some(h) = float(tag.get("Health")) {
    // rust: m.health = h as f32;
}
    // rust: m.extra.flag2 = flag(tag, "wasOnGround");
}
    // rust: if m.species() == crate::mobs::Species::Phantom {
        // Phantom.readAdditionalSaveData: setPhantomSize(size).
    // rust: crate::mobs::phantom::set_size(&mut m, number(tag.get("size")).unwrap_or(0) as i32);
}
    // Zombie, Piglin and Zoglin.readAdditionalSaveData: IsBaby (the baby
    // zombies of trial spawners).
    // rust: if !crate::mobs::finalize::ageable(m.species()) && flag(tag, "IsBaby") {
    // rust: crate::mobs::finalize::set_baby(&mut m, true);
}
    // Zombie.readAdditionalSaveData: setCanBreakDoors.
    // rust: if crate::mobs::doors::is_zombie(m.species()) {
    // rust: crate::mobs::doors::set_can_break_doors(&mut m, flag(tag, "CanBreakDoors"));
}
    // Zombie and Skeleton.readAdditionalSaveData: `ConversionTracker` reads its
    // affliction time (0 when absent) and starts a conversion from a saved time
    // other than -1, -1 stopping one (`setConverting(false)`).
    // rust: let tracker = match m.species() {
    // rust: crate::mobs::Species::Zombie | crate::mobs::Species::Husk => {
    // rust: Some(("InWaterTime", "DrownedConversionTime"))
}
    // rust: crate::mobs::Species::Skeleton => Some(("FreezingTime", "StrayConversionTime")),
    // rust: _ => None,
}
    // rust: if let Some((affliction, conversion)) = tracker {
    // rust: m.extra.counter = number(tag.get(affliction)).unwrap_or(0) as i32;
    // rust: let time = number(tag.get(conversion)).unwrap_or(-1) as i32;
        // Any other time starts a conversion (`startConversion`), a negative
        // one spent on the next tick.
    // rust: m.extra.counter2 = if time == -1 { 0 } else { time.max(0) + 1 };
}
    // rust: crate::mobs::raider::read_nbt(&mut m, tag);
    // rust: crate::mobs::riders::read_nbt(&mut m, tag);
    // A mob saved mid-death finishes dying; one saved dead is dropped.
    // rust: if m.health <= 0.0 && m.death_time == 0 {
    // rust: return None;
}
    // DeathTime only counts while dead.
    // rust: if m.health > 0.0 {
    // rust: m.death_time = 0;
}
    // rust: Some(m)
}

// `ItemEntity`: Health, Age, PickupDelay, Item, Thrower.
item_entity_to_nbt :: proc(e: ^ItemEntity, uuid: [i32; 4], raw: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let base = Base {
    // rust: id: "minecraft:item",
    // rust: uuid,
    // rust: position: e.position,
    // rust: motion: e.velocity,
    // rust: rotation: e.rotation,
    // rust: on_ground: e.on_ground,
    // rust: fall_distance: 0.0,
}
    // rust: let mut tag = base.tag(raw);
    // rust: for (key, value) in [
    // rust: ("Item", item_to_nbt(&e.stack)),
    // rust: ("Health", Tag::Short(e.health as i16)),
    // rust: ("Fire", Tag::Short(e.fire_ticks as i16)),
    // rust: (
    // rust: "Age",
    // rust: Tag::Short(e.age.clamp(i16::MIN as i32, i16::MAX as i32) as i16),
    // rust: ),
    // rust: (
    // rust: "PickupDelay",
    // rust: Tag::Short(
    // rust: e.pickup_delay
    // rust: .clamp(i64::from(i16::MIN), i64::from(i16::MAX)) as i16,
    // rust: ),
    // rust: ),
    // rust: ] {
    // rust: put(&mut tag, key, value);
}
    // rust: if let Some(thrower) = e.thrower {
    // rust: put(&mut tag, "Thrower", Tag::IntArray(thrower.to_vec()));
    // rust: } else if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"Thrower".into());
}
    // rust: if let Some(target) = e.target {
    // rust: put(&mut tag, "Owner", Tag::IntArray(target.to_vec()));
    // rust: } else if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"Owner".into());
}
    // rust: tag
}
// `PrimedTnt.readAdditionalSaveData`: `explosion_power`, 4 by default and
// clamped to 0..128.
tnt_power :: proc(tag: ^Tag) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match tag.get("explosion_power") {
    // rust: Some(Tag::Float(bits)) => f32::from_bits(*bits).clamp(0.0, 128.0),
    // rust: _ => 4.0,
}
}

// `PrimedTnt.addAdditionalSaveData`: its `fuse` and, when it is not the
// default, its `explosion_power`, and the encoded live block state.
    // rust: pub fn tnt_to_nbt(
    // rust: position: Vec3,
    // rust: motion: Vec3,
    // rust: on_ground: bool,
    // rust: fuse: i32,
    // rust: power: f32,
    // rust: block_state: Tag,
    // rust: rotation: [f32; 2],
    // rust: uuid: [i32; 4],
    // rust: raw: Option<&Tag>,
    // rust: ) -> Tag {
    // rust: let mut tag = Base {
    // rust: id: "minecraft:tnt",
    // rust: uuid,
    // rust: position,
    // rust: motion,
    // rust: rotation,
    // rust: on_ground,
    // rust: fall_distance: 0.0,
}
    // rust: .tag(raw);
    // rust: put(&mut tag, "fuse", Tag::Short(fuse as i16));
    // rust: if power != 4.0 {
    // rust: put(&mut tag, "explosion_power", Tag::Float(power.to_bits()));
}
    // rust: put(&mut tag, "block_state", block_state);
    // rust: tag
}
// `EvokerFangs.addAdditionalSaveData`: always save the live warmup counter.
// Known Owner UUIDs use `EntityReference.store` encoding; unresolved
// loaded Owner data remains in the raw compound.
    // rust: pub fn evoker_fangs_to_nbt(
    // rust: position: Vec3,
    // rust: yaw: f32,
    // rust: warmup: i32,
    // rust: owner: Option<[i32; 4]>,
    // rust: uuid: [i32; 4],
    // rust: raw: Option<&Tag>,
    // rust: ) -> Tag {
    // rust: let mut tag = Base {
    // rust: id: "minecraft:evoker_fangs",
    // rust: uuid,
    // rust: position,
    // rust: motion: raw.map(motion).unwrap_or(Vec3::ZERO),
    // rust: rotation: [yaw, raw.map(rotation).unwrap_or([0.0; 2])[1]],
    // rust: on_ground: raw.is_some_and(|t| flag(t, "OnGround")),
    // rust: fall_distance: 0.0,
}
    // rust: .tag(raw);
    // rust: put(&mut tag, "Warmup", Tag::Int(warmup));
    // rust: if let Some(owner) = owner {
    // rust: put(&mut tag, "Owner", Tag::IntArray(owner.to_vec()));
}
    // rust: tag
}

item_entity_from_nbt :: proc(tag: ^Tag, id: u32, bob_offset: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let stack = item_from_nbt(tag.get("Item")?)?;
    // rust: let position = position(tag)?;
    // rust: Some(ItemEntity {
    // rust: rotation: rotation(tag),
    // rust: join: Default::default(),
    // rust: no_gravity: flag(tag, "NoGravity"),
    // rust: health: number(tag.get("Health")).unwrap_or(5) as i32,
    // rust: fire_ticks: number(tag.get("Fire")).unwrap_or(0) as i32,
    // rust: id,
    // rust: stack,
    // rust: thrower: uuid_from_tag(tag.get("Thrower")),
    // rust: target: uuid_from_tag(tag.get("Owner")),
    // rust: position,
    // rust: previous: position,
    // rust: velocity: motion(tag),
    // rust: on_ground: flag(tag, "OnGround"),
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: number(tag.get("Age")).unwrap_or(0) as i32,
    // rust: pickup_delay: number(tag.get("PickupDelay")).unwrap_or(0),
    // rust: bob_offset,
    // rust: ticks: 0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
    // rust: })
}

// `OminousItemSpawner.addAdditionalSaveData`: its item (left out when
// empty) and `spawn_item_after_ticks`. Its tick count is the entity's
// `tickCount`, which isn't saved: a reloaded spawner counts from 0 again.
    // rust: pub fn ominous_item_spawner_to_nbt(
    // rust: item: &crate::items::ItemStack,
    // rust: position: Vec3,
    // rust: spawn_item_after: i64,
    // rust: uuid: [i32; 4],
    // rust: raw: Option<&Tag>,
    // rust: ) -> Tag {
    // rust: let base = Base {
    // rust: id: "minecraft:ominous_item_spawner",
    // rust: uuid,
    // rust: position,
    // rust: motion: Vec3::ZERO,
    // rust: rotation: [0.0, 0.0],
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: let mut tag = base.tag(raw);
    // `ItemStack.CODEC` can't encode `ItemStack.EMPTY`, so an empty item
    // writes no key.
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"item".into());
}
    // rust: if &*item.item != "minecraft:air" {
    // rust: put(&mut tag, "item", item_to_nbt(item));
}
    // rust: put(
    // rust: &mut tag,
    // rust: "spawn_item_after_ticks",
    // rust: Tag::Long(spawn_item_after),
    // rust: );
    // rust: tag
}
// `OminousItemSpawner.readAdditionalSaveData`: the item, where it floats
// and `spawn_item_after_ticks` (0 when absent). None without an item:
// such a spawner would spawn nothing.
ominous_item_spawner_from_nbt :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // `readAdditionalSaveData`: `ItemStack.EMPTY` when it has none.
    // rust: let item = tag
    // rust: .get("item")
    // rust: .and_then(item_from_nbt)
    // rust: .unwrap_or_else(|| crate::items::ItemStack::new("minecraft:air", 1));
    // rust: let after = number(tag.get("spawn_item_after_ticks")).unwrap_or(0);
    // rust: Some((item, position(tag)?, after))
}

// `ExperienceOrb`: Health, Age, Value, Count.
orb_to_nbt :: proc(o: ^ExperienceOrb, uuid: [i32; 4]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let base = Base {
    // rust: id: "minecraft:experience_orb",
    // rust: uuid,
    // rust: position: o.position,
    // rust: motion: o.velocity,
    // rust: rotation: o.rotation,
    // rust: on_ground: o.on_ground,
    // rust: fall_distance: 0.0,
}
    // rust: let mut tag = base.tag(None);
    // rust: for (key, value) in [
    // rust: ("Health", Tag::Short(o.health as i16)),
    // rust: ("Age", Tag::Short(o.age.min(i16::MAX as u32) as i16)),
    // rust: ("Value", Tag::Short(o.value.min(i16::MAX as u32) as i16)),
    // rust: ("Count", Tag::Int(o.count.min(i32::MAX as u32) as i32)),
    // rust: ] {
    // rust: put(&mut tag, key, value);
}
    // Entity.saveWithoutId writes NoGravity only when set.
    // rust: if o.no_gravity {
    // rust: put(&mut tag, "NoGravity", Tag::Byte(1));
}
    // rust: tag
}
// One orb with its merged `Count`.
orbs_from_nbt :: proc(tag: ^Tag) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(position) = position(tag) else {
    // rust: return Vec::new();
}
    // rust: let count = number(tag.get("Count")).unwrap_or(1).max(1) as u32;
    // rust: let orb = ExperienceOrb {
    // rust: rotation: rotation(tag),
    // rust: join: Default::default(),
    // rust: no_gravity: flag(tag, "NoGravity"),
    // rust: id: 0,
    // rust: position,
    // rust: previous: position,
    // rust: velocity: motion(tag),
    // rust: value: number(tag.get("Value")).unwrap_or(1).max(1) as u32,
    // rust: age: number(tag.get("Age")).unwrap_or(0).max(0) as u32,
    // rust: on_ground: flag(tag, "OnGround"),
    // rust: count,
    // rust: ticks: 0,
    // rust: health: number(tag.get("Health")).unwrap_or(5) as i32,
}
    // rust: vec![orb]
}

// `Projectile` + `AbstractArrow.addAdditionalSaveData` of a live arrow;
// `in_block` is its `inBlockState`, `raw` the compound it was loaded with.
    // rust: pub fn arrow_to_nbt(
    // rust: p: &Projectile,
    // rust: uuid: [i32; 4],
    // rust: owner: Option<[i32; 4]>,
    // rust: in_block: Option<Tag>,
    // rust: raw: Option<&Tag>,
    // rust: ) -> Option<Tag> {
    // rust: let a = p.arrow.as_deref()?;
    // rust: let ProjectileKind::Arrow {
    // rust: base_damage,
    // rust: critical,
    // rust: ..
    // rust: } = p.kind
    // rust: else {
    // rust: return None;
}
    // rust: let base = Base {
        // A spectral arrow is its own entity type.
    // rust: id: if a.spectral || &*a.pickup_item.item == "minecraft:spectral_arrow" {
    // rust: "minecraft:spectral_arrow"
    // rust: } else {
    // rust: "minecraft:arrow"
    // rust: },
    // rust: uuid,
    // rust: position: p.position,
    // rust: motion: p.velocity,
    // rust: rotation: [p.yaw, p.pitch],
    // rust: on_ground: false,
    // rust: fall_distance: a.fall_distance,
}
    // rust: let mut tag = base.tag(raw);
    // rust: for (key, value) in [
    // rust: ("Fire", Tag::Short(a.fire_ticks as i16)),
    // rust: ("life", Tag::Short(a.life as i16)),
    // rust: ("shake", Tag::Byte(a.shake as i8)),
    // rust: ("inGround", Tag::Byte(i8::from(a.in_ground))),
    // rust: ("pickup", Tag::Byte(a.pickup.byte())),
    // rust: ("damage", Tag::Double(base_damage.to_bits())),
    // rust: ("crit", Tag::Byte(i8::from(critical))),
    // rust: ("PierceLevel", Tag::Byte(a.pierce as i8)),
    // rust: ("HasBeenShot", Tag::Byte(i8::from(a.has_been_shot))),
    // rust: ("item", item_to_nbt(&a.pickup_item)),
    // rust: ] {
    // rust: put(&mut tag, key, value);
}
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.entry("SoundEvent".into())
    // rust: .or_insert_with(|| string("minecraft:entity.arrow.hit"));
        // Projectile: LeftOwner only when set; Owner as the UUID.
    // rust: map.remove(&"LeftOwner".into());
    // rust: map.remove(&"inBlockState".into());
    // rust: map.remove(&"weapon".into());
}
    // rust: if let Some(weapon) = &a.fired_from_weapon {
    // rust: put(&mut tag, "weapon", item_to_nbt(weapon));
}
    // rust: if p.left_owner {
    // rust: put(&mut tag, "LeftOwner", Tag::Byte(1));
}
    // rust: if let Some(state) = in_block {
    // rust: put(&mut tag, "inBlockState", state);
}
    // Entity.saveWithoutId writes NoGravity only when set.
    // rust: if p.no_gravity {
    // rust: put(&mut tag, "NoGravity", Tag::Byte(1));
}
    // rust: if let Some(owner) = owner {
    // rust: put(&mut tag, "Owner", Tag::IntArray(owner.to_vec()));
}
    // rust: Some(tag)
}
// A saved arrow as a live one (`readAdditionalSaveData`), with its
// `inBlockState` compound for the caller to resolve. `effect` is the tipped
// arrow's lasting effect from its item.
    // rust: pub fn arrow_from_nbt(
    // rust: tag: &Tag,
    // rust: player: Option<[i32; 4]>,
    // rust: effect: impl FnOnce(&crate::items::ItemStack) -> Option<(&'static str, i32)>,
    // rust: ) -> Option<(Projectile, Option<Tag>)> {
    // rust: let position = position(tag)?;
    // rust: let owner = uuid_from_tag(tag.get("Owner"));
    // rust: let from_player = player.is_some() && owner == player;
    // `getDefaultPickupItem`: a `SpectralArrow` is picked up as its own item.
    // rust: let spectral = kind(tag).as_deref() == Some("minecraft:spectral_arrow");
    // rust: let default_item = if spectral {
    // rust: "minecraft:spectral_arrow"
    // rust: } else {
    // rust: "minecraft:arrow"
}
    // rust: let item = tag
    // rust: .get("item")
    // rust: .and_then(item_from_nbt)
    // rust: .unwrap_or_else(|| crate::items::ItemStack::new(default_item, 1));
    // rust: let kind = ProjectileKind::Arrow {
    // rust: base_damage: float(tag.get("damage")).unwrap_or(2.0),
    // rust: critical: flag(tag, "crit"),
    // rust: effect: effect(&item),
}
    // rust: let mut p = Projectile::new(kind, position, from_player.then_some(Who::Player));
    // rust: p.velocity = motion(tag);
    // rust: [p.yaw, p.pitch] = rotation(tag);
    // rust: p.left_owner = flag(tag, "LeftOwner");
    // rust: p.owner_uuid = owner;
    // rust: p.no_gravity = flag(tag, "NoGravity");
    // rust: let a = p.arrow.as_mut()?;
    // rust: a.life = number(tag.get("life")).unwrap_or(0) as i16 as i32;
    // rust: a.shake = (number(tag.get("shake")).unwrap_or(0) as i8 as u8).into();
    // rust: a.in_ground = flag(tag, "inGround");
    // rust: a.pickup = Pickup::from_byte(number(tag.get("pickup")).unwrap_or(0));
    // rust: a.pierce = number(tag.get("PierceLevel")).unwrap_or(0) as u8;
    // rust: a.has_been_shot = flag(tag, "HasBeenShot");
    // rust: a.fire_ticks = number(tag.get("Fire")).unwrap_or(0) as i16 as i32;
    // rust: a.fall_distance = float(tag.get("fall_distance")).unwrap_or(0.0);
    // rust: a.spectral = spectral;
    // rust: a.pickup_item = item;
    // rust: a.fired_from_weapon = tag.get("weapon").and_then(item_from_nbt);
    // rust: p.stuck = a.in_ground;
    // rust: Some((p, tag.get("inBlockState").cloned()))
}

// `LargeFireball` and `SmallFireball`: `AbstractHurtingProjectile`'s
// `acceleration_power`, `Projectile`'s owner and flags, `ExplosionPower`.
    // rust: pub fn fireball_to_nbt(
    // rust: p: &Projectile,
    // rust: uuid: [i32; 4],
    // rust: owner: Option<[i32; 4]>,
    // rust: raw: Option<&Tag>,
    // rust: ) -> Option<Tag> {
    // rust: let power = match p.kind {
    // rust: ProjectileKind::LargeFireball { power } => Some(power),
    // rust: ProjectileKind::SmallFireball
    // rust: | ProjectileKind::WindCharge
    // rust: | ProjectileKind::BreezeWindCharge => None,
    // rust: _ => return None,
}
    // rust: let base = Base {
    // rust: id: p.kind.id(),
    // rust: uuid,
    // rust: position: p.position,
    // rust: motion: p.velocity,
    // rust: rotation: [p.yaw, p.pitch],
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: let mut tag = base.tag(raw);
    // rust: put(
    // rust: &mut tag,
    // rust: "acceleration_power",
    // rust: Tag::Double(p.acceleration.to_bits()),
    // rust: );
    // rust: put_projectile(&mut tag, p, owner);
    // AbstractHurtingProjectile.tick: shouldBurn is true for both fireballs, so
    // once ticked they igniteForSeconds(1) every tick.
    // rust: if p.age > 0 && !p.kind.ignores_blast() {
    // rust: let fire = number(tag.get("Fire")).unwrap_or(0).max(20);
    // rust: put(&mut tag, "Fire", Tag::Short(fire as i16));
}
    // rust: if let Some(power) = power {
    // rust: put(&mut tag, "ExplosionPower", Tag::Byte(power as i8));
}
    // Fireball.addAdditionalSaveData: the item `getItem` returns, a fire
    // charge unless `setItem` was given another (kept as a single one).
    // rust: if let Some(item) = &p.item {
    // rust: put(&mut tag, "Item", item_to_nbt(item));
}
    // rust: Some(tag)
}

// `Projectile.addAdditionalSaveData`: Owner, LeftOwner only when set, and
// the explicit HasBeenShot flag.
put_projectile :: proc(tag: ^Tag, p: ^Projectile, owner: Maybe([i32; 4])) {
}
    // rust: if let Tag::Compound(map) = tag {
    // rust: map.remove(&"LeftOwner".into());
}
    // rust: if p.left_owner {
    // rust: put(tag, "LeftOwner", Tag::Byte(1));
}
    // Entity.saveWithoutId writes NoGravity only when set.
    // rust: if p.no_gravity {
    // rust: put(tag, "NoGravity", Tag::Byte(1));
}
    // rust: put(tag, "HasBeenShot", Tag::Byte(i8::from(p.has_been_shot)));
    // rust: if let Some(owner) = owner {
    // rust: put(tag, "Owner", Tag::IntArray(owner.to_vec()));
}
}

// The thrown item projectiles Horizon saves: each entity type's id is also
// the item it saves when none was loaded (`getDefaultItem`).
    // rust: const THROWABLE_ITEMS: [&str; 6] = [
    // rust: "minecraft:snowball",
    // rust: "minecraft:egg",
    // rust: "minecraft:ender_pearl",
    // rust: "minecraft:splash_potion",
    // rust: "minecraft:lingering_potion",
    // rust: "minecraft:experience_bottle",
    // rust: ];
// The item a throwable flies as: its stack (a potion's), the mod type's
// item, or the item its entity type is named after.
throwable_item :: proc(kind: ^ProjectileKind) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: ProjectileKind::Thrown(t) => Some(t.item),
    // rust: ProjectileKind::Potion(stack, _) => Some(&stack.item),
    // rust: _ => THROWABLE_ITEMS.iter().find(|id| **id == kind.id()).copied(),
}
}

// The thrown kind an entity id names: vanilla's, or a content mod's type.
// A potion flies as the item its entity type names, which is the item a
// summoned one has when it names none (`getDefaultItem`).
throwable_kind :: proc(id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !THROWABLE_ITEMS.contains(&id) {
    // rust: return crate::projectiles::thrown_type(id).map(ProjectileKind::Thrown);
}
    // rust: match id {
    // rust: "minecraft:snowball" => Some(ProjectileKind::Snowball),
    // rust: "minecraft:egg" => Some(ProjectileKind::Egg),
    // rust: "minecraft:ender_pearl" => Some(ProjectileKind::EnderPearl),
        // The entity type is the id; the `Item` read later may be another potion.
    // rust: "minecraft:experience_bottle" => Some(ProjectileKind::ExperienceBottle),
    // rust: _ => Some(ProjectileKind::Potion(
    // rust: Box::new(crate::items::ItemStack::new(id, 1)),
    // rust: id == "minecraft:lingering_potion",
    // rust: )),
}
}

// Whether its chunk saves it: the kinds `arrow_to_nbt`, `fireball_to_nbt`
// and [`throwable_to_nbt`] write.
saved_with_chunk :: proc(p: ^Projectile) -> b {
    // Ported from Horizon
    return {}
}
    // No wildcard: a kind added to `ProjectileKind` must say here whether its
    // chunk saves it (`Entity.shouldBeSaved` is true for every projectile in
    // vanilla), and a `true` needs a writer in `entity_chunks`.
    // rust: match &p.kind {
    // rust: ProjectileKind::LargeFireball { .. }
    // rust: | ProjectileKind::SmallFireball
    // rust: | ProjectileKind::WindCharge
    // rust: | ProjectileKind::BreezeWindCharge
    // rust: | ProjectileKind::Snowball
    // rust: | ProjectileKind::Egg
    // rust: | ProjectileKind::EnderPearl
    // rust: | ProjectileKind::Potion(..)
    // rust: | ProjectileKind::ExperienceBottle
    // rust: | ProjectileKind::LlamaSpit
    // rust: | ProjectileKind::ShulkerBullet { target: None, .. }
    // rust: | ProjectileKind::Thrown(_) => true,
    // rust: ProjectileKind::Arrow { .. } => p.arrow.is_some(),
        // Not written yet: tridents save from their own list, and a bullet
        // with a target would lose it.
    // rust: ProjectileKind::Trident
    // rust: | ProjectileKind::ShulkerBullet {
    // rust: target: Some(_), ..
}
    // rust: | ProjectileKind::WitherSkull { .. } => false,
}
}

// `ThrowableItemProjectile.addAdditionalSaveData`: `Projectile`'s keys and
// the `Item` it flies as.
    // rust: pub fn throwable_to_nbt(
    // rust: p: &Projectile,
    // rust: uuid: [i32; 4],
    // rust: owner: Option<[i32; 4]>,
    // rust: raw: Option<&Tag>,
    // rust: ) -> Option<Tag> {
    // rust: let item = throwable_item(&p.kind)?;
    // rust: let base = Base {
    // rust: id: p.kind.id(),
    // rust: uuid,
    // rust: position: p.position,
    // rust: motion: p.velocity,
    // rust: rotation: [p.yaw, p.pitch],
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: let mut tag = base.tag(raw);
    // rust: put_projectile(&mut tag, p, owner);
    // Entity.saveWithoutId writes NoGravity only when set.
    // rust: if p.no_gravity {
    // rust: put(&mut tag, "NoGravity", Tag::Byte(1));
}
    // the loaded item stays (a blue egg's, a renamed one's, a potion's
    // effects); when there is none, `getItem`'s default is written.
    // rust: if tag.get("Item").is_none() {
    // rust: let stack = match &p.kind {
    // rust: ProjectileKind::Potion(stack, _) => (**stack).clone(),
    // rust: _ => crate::items::ItemStack::new(item, 1),
}
    // rust: put(&mut tag, "Item", item_to_nbt(&stack));
}
    // rust: Some(tag)
}

// `ThrowableItemProjectile.readAdditionalSaveData` for the kinds
// [`throwable_to_nbt`] writes; the owner is the player when it is theirs.
throwable_from_nbt :: proc(tag: ^Tag, player: Maybe([i32; 4])) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = throwable_kind(&kind(tag)?)?;
    // `readAdditionalSaveData` sets the `Item` it flies as, potion effects
    // and all; a tag without one keeps `getItem`'s default.
    // rust: if let ProjectileKind::Potion(stack, _) = &mut kind
    // rust: && let Some(item) = tag.get("Item").and_then(item_from_nbt)
    // rust: {
    // rust: **stack = item;
}
    // rust: let owner = owner_uuid(tag);
    // rust: let from_player = player.is_some() && owner == player;
    // rust: let mut p = Projectile::new(kind, position(tag)?, from_player.then_some(Who::Player));
    // rust: p.velocity = motion(tag);
    // rust: [p.yaw, p.pitch] = rotation(tag);
    // rust: p.left_owner = flag(tag, "LeftOwner");
    // rust: p.has_been_shot = flag(tag, "HasBeenShot");
    // rust: p.owner_uuid = owner;
    // rust: p.no_gravity = flag(tag, "NoGravity");
    // rust: Some(p)
}

// `LlamaSpit` and `ShulkerBullet` as `/summon` or a chunk loads them:
// `Projectile`'s `Owner`, `LeftOwner`, `NoGravity` and the motion. A bullet
// loaded without a `Target` has none, so it falls (`ShulkerBullet.tick`).
spit_or_bullet_from_nbt :: proc(tag: ^Tag, player: Maybe([i32; 4])) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let kind = match kind(tag)?.as_str() {
    // rust: "minecraft:llama_spit" => ProjectileKind::LlamaSpit,
    // rust: "minecraft:shulker_bullet" => ProjectileKind::ShulkerBullet {
    // rust: target: None,
    // rust: dir: None,
    // rust: steps: 0,
    // rust: delta: [0.0; 3],
    // rust: seed: 0,
    // rust: },
    // rust: _ => return None,
}
    // rust: let owner = owner_uuid(tag);
    // rust: let from_player = player.is_some() && owner == player;
    // rust: let mut p = Projectile::new(kind, position(tag)?, from_player.then_some(Who::Player));
    // rust: p.velocity = motion(tag);
    // rust: [p.yaw, p.pitch] = rotation(tag);
    // rust: p.left_owner = flag(tag, "LeftOwner");
    // rust: p.has_been_shot = flag(tag, "HasBeenShot");
    // rust: p.owner_uuid = owner;
    // rust: p.no_gravity = flag(tag, "NoGravity");
    // rust: Some(p)
}

// The save of [`spit_or_bullet_from_nbt`]'s kinds: `Projectile`'s keys.
    // rust: pub fn spit_or_bullet_to_nbt(
    // rust: p: &Projectile,
    // rust: uuid: [i32; 4],
    // rust: owner: Option<[i32; 4]>,
    // rust: raw: Option<&Tag>,
    // rust: ) -> Option<Tag> {
    // rust: if !matches!(
    // rust: p.kind,
    // rust: ProjectileKind::LlamaSpit | ProjectileKind::ShulkerBullet { target: None, .. }
    // rust: ) {
    // rust: return None;
}
    // rust: let base = Base {
    // rust: id: p.kind.id(),
    // rust: uuid,
    // rust: position: p.position,
    // rust: motion: p.velocity,
    // rust: rotation: [p.yaw, p.pitch],
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: let mut tag = base.tag(raw);
    // rust: put_projectile(&mut tag, p, owner);
    // rust: Some(tag)
}

// `Projectile`'s `Owner`.
owner_uuid :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: uuid_from_tag(tag.get("Owner"))
}

// `Fireball.readAdditionalSaveData` (and, around it, `Projectile`'s Owner and
// LeftOwner and `AbstractHurtingProjectile`'s acceleration power): a fireball
// also reads the item it is drawn as through `setItem`, whose default is the
// fire charge; a wind charge is no `Fireball` and has none.
fireball_from_nbt :: proc(tag: ^Tag, player: Maybe([i32; 4])) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let kind = match kind(tag)?.as_str() {
    // rust: "minecraft:fireball" => ProjectileKind::LargeFireball {
    // rust: power: number(tag.get("ExplosionPower")).unwrap_or(1) as i32,
    // rust: },
    // rust: "minecraft:small_fireball" => ProjectileKind::SmallFireball,
    // rust: "minecraft:wind_charge" => ProjectileKind::WindCharge,
    // rust: "minecraft:breeze_wind_charge" => ProjectileKind::BreezeWindCharge,
    // rust: _ => return None,
}
    // rust: let owner = uuid_from_tag(tag.get("Owner"));
    // rust: let from_player = player.is_some() && owner == player;
    // rust: let mut p = Projectile::new(kind, position(tag)?, from_player.then_some(Who::Player));
    // rust: p.velocity = motion(tag);
    // rust: [p.yaw, p.pitch] = rotation(tag);
    // rust: p.left_owner = flag(tag, "LeftOwner");
    // rust: p.has_been_shot = flag(tag, "HasBeenShot");
    // rust: p.owner_uuid = owner;
    // rust: p.no_gravity = flag(tag, "NoGravity");
    // rust: p.acceleration = float(tag.get("acceleration_power")).unwrap_or(0.1);
    // rust: if let Some(item) = tag.get("Item").and_then(item_from_nbt) {
    // rust: p.set_item(item);
}
    // rust: Some(p)
}

// `FireworkRocketEntity.readAdditionalSaveData`: Life, LifeTime (0 when
// absent: a bare `/summon` explodes at once), FireworksItem and
// ShotAtAngle, with `Projectile`'s Owner and LeftOwner.
RocketNbt :: struct {
    position: Vec3,
    motion: Vec3,
    life: i32,
    lifetime: i32,
    item: Maybe(crate::items::ItemStack),
    angled: bool,
    owner: Maybe(Who),
    left_owner: bool,
}
firework_rocket_from_nbt :: proc(tag: ^Tag, player: Maybe([i32; 4])) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let owner = uuid_from_tag(tag.get("Owner"));
    // rust: Some(RocketNbt {
    // rust: position: position(tag)?,
    // rust: motion: motion(tag),
    // rust: life: number(tag.get("Life")).unwrap_or(0) as i32,
    // rust: lifetime: number(tag.get("LifeTime")).unwrap_or(0) as i32,
    // rust: item: tag.get("FireworksItem").and_then(item_from_nbt),
    // rust: angled: flag(tag, "ShotAtAngle"),
    // rust: owner: (player.is_some() && owner == player).then_some(Who::Player),
    // rust: left_owner: flag(tag, "LeftOwner"),
    // rust: })
}

// What `FireworkRocketEntity.addAdditionalSaveData` writes, over `Projectile`'s
// Owner and LeftOwner.
RocketSave :: struct {
    rotation: [f32,
    position: Vec3,
    motion: Vec3,
    life: i32,
    lifetime: i32,
    item: ^'a crate::items::ItemStack,
    angled: bool,
    owner: Option<[i32,
    left_owner: bool,
}
firework_rocket_to_nbt :: proc(r: ^RocketSave, uuid: [i32; 4], raw: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = Base {
    // rust: id: "minecraft:firework_rocket",
    // rust: uuid,
    // rust: position: r.position,
    // rust: motion: r.motion,
    // rust: rotation: r.rotation,
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: .tag(raw);
    // rust: for (key, value) in [
    // rust: ("Life", Tag::Int(r.life)),
    // rust: ("LifeTime", Tag::Int(r.lifetime)),
    // rust: ("FireworksItem", item_to_nbt(r.item)),
    // rust: ("ShotAtAngle", Tag::Byte(i8::from(r.angled))),
    // rust: ("HasBeenShot", Tag::Byte(1)),
    // rust: ] {
    // rust: put(&mut tag, key, value);
}
    // rust: if r.left_owner {
    // rust: put(&mut tag, "LeftOwner", Tag::Byte(1));
}
    // rust: if let Some(owner) = r.owner {
    // rust: put(&mut tag, "Owner", Tag::IntArray(owner.to_vec()));
}
    // rust: tag
}

// A thrown trident as `AbstractArrow` + `ThrownTrident` save it.
TridentSave :: struct {
    position: Vec3,
    motion: Vec3,
    yaw: f32,
    pitch: f32,
    in_ground: bool,
    life: i32,
    shake: u32,
    dealt_damage: bool,
    creative_only: bool,
    no_gravity: bool,
    fire_ticks: i32,
    item: ^'a crate::items::ItemStack,
}
trident_to_nbt :: proc(t: ^TridentSave, uuid: [i32; 4], raw: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = Base {
    // rust: id: "minecraft:trident",
    // rust: uuid,
    // rust: position: t.position,
    // rust: motion: t.motion,
    // rust: rotation: [t.yaw, t.pitch],
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: .tag(raw);
    // Projectile.addAdditionalSaveData: LeftOwner once set. A trident keeps no
    // owner, and an ownerless projectile has left it on its first tick.
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.entry("LeftOwner".into()).or_insert(Tag::Byte(1));
}
    // rust: for (key, value) in [
    // rust: ("life", Tag::Short(t.life as i16)),
    // rust: ("shake", Tag::Byte(t.shake as i8)),
    // rust: ("inGround", Tag::Byte(i8::from(t.in_ground))),
        // AbstractArrow.Pickup: 0 disallowed, 1 allowed, 2 creative only.
    // rust: ("pickup", Tag::Byte(if t.creative_only { 2 } else { 1 })),
    // rust: ("damage", Tag::Double(2.0_f64.to_bits())),
    // rust: ("HasBeenShot", Tag::Byte(1)),
    // rust: ("crit", Tag::Byte(0)),
    // rust: ("PierceLevel", Tag::Byte(0)),
    // rust: ("SoundEvent", string("minecraft:item.trident.hit_ground")),
    // rust: ("item", item_to_nbt(t.item)),
    // rust: ("DealtDamage", Tag::Byte(i8::from(t.dealt_damage))),
    // rust: ("Fire", Tag::Short(t.fire_ticks as i16)),
    // rust: ] {
    // rust: put(&mut tag, key, value);
}
    // Entity.saveWithoutId writes NoGravity only when set.
    // rust: if t.no_gravity {
    // rust: put(&mut tag, "NoGravity", Tag::Byte(1));
    // rust: } else if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"NoGravity".into());
}
    // rust: tag
}
// (position, motion, yaw, pitch, in ground, life, shake, dealt damage,
// creative only, the trident item)
TridentNbt :: struct {
    position: Vec3,
    motion: Vec3,
    yaw: f32,
    pitch: f32,
    in_ground: bool,
    life: i32,
    shake: u32,
    dealt_damage: bool,
    creative_only: bool,
    no_gravity: bool,
    fire_ticks: i32,
    item: crate::items::ItemStack,
}
trident_from_nbt :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let [yaw, pitch] = rotation(tag);
    // rust: Some(TridentNbt {
    // rust: position: position(tag)?,
    // rust: motion: motion(tag),
    // rust: yaw,
    // rust: pitch,
    // rust: in_ground: flag(tag, "inGround"),
    // rust: life: number(tag.get("life")).unwrap_or(0) as i32,
    // rust: shake: number(tag.get("shake")).unwrap_or(0).max(0) as u32,
    // rust: dealt_damage: flag(tag, "DealtDamage"),
    // rust: creative_only: number(tag.get("pickup")) == Some(2),
    // rust: no_gravity: flag(tag, "NoGravity"),
    // rust: fire_ticks: number(tag.get("Fire")).unwrap_or(0) as i32,
    // rust: item: tag
    // rust: .get("item")
    // rust: .and_then(item_from_nbt)
    // rust: .unwrap_or_else(|| crate::items::ItemStack::new("minecraft:trident", 1)),
    // rust: })
}

// `FallingBlockEntity`: BlockState, Time, DropItem, HurtEntities.
    // rust: pub fn falling_block_to_nbt(
    // rust: state: Tag,
    // rust: position: Vec3,
    // rust: motion: Vec3,
    // rust: time: i32,
    // rust: drop_item: bool,
    // rust: damage: crate::falling_block::Damage,
    // rust: fall_distance: f64,
    // rust: rotation: [f32; 2],
    // rust: uuid: [i32; 4],
    // rust: ) -> Tag {
    // rust: let base = Base {
    // rust: id: "minecraft:falling_block",
    // rust: uuid,
    // rust: position,
    // rust: motion,
    // rust: rotation,
    // rust: on_ground: false,
    // rust: fall_distance,
}
    // rust: let mut tag = base.tag(None);
    // rust: for (key, value) in [
    // rust: ("BlockState", state),
    // rust: ("Time", Tag::Int(time)),
    // rust: ("DropItem", Tag::Byte(i8::from(drop_item))),
    // rust: ] {
    // rust: put(&mut tag, key, value);
}
    // rust: damage.save(&mut tag);
    // rust: tag
}
// (block state tag, position, motion, time, fall distance)
falling_block_from_nbt :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some((
    // rust: tag.get("BlockState")?.clone(),
    // rust: position(tag)?,
    // rust: motion(tag),
    // rust: number(tag.get("Time")).unwrap_or(0) as i32,
    // rust: float(tag.get("fall_distance")).unwrap_or(0.0),
    // rust: ))
}

// `NoGravity` and `DropItem` (true when absent) of a saved falling block.
falling_block_flags :: proc(tag: ^Tag) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: flag(tag, "NoGravity"),
    // rust: number(tag.get("DropItem")).is_none_or(|v| v != 0),
    // rust: )
}

// Painting.addAdditionalSaveData: `facing`, `variant` and `block_pos`.
painting_to_nbt :: proc(p: ^Painting, uuid: [i32; 4], raw: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let (lo, hi) = p.bounds();
    // rust: let base = Base {
    // rust: id: "minecraft:painting",
    // rust: uuid,
    // rust: position: Vec3::new(
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: ),
    // rust: motion: Vec3::ZERO,
    // rust: rotation: [f32::from(p.facing) * 90.0, 0.0],
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: let mut tag = base.tag(raw);
    // rust: put(&mut tag, "facing", Tag::Byte(p.facing as i8));
    // rust: put(&mut tag, "variant", string(&p.variant));
    // rust: put(&mut tag, "block_pos", Tag::IntArray(p.pos.to_vec()));
    // rust: tag
}
// `BlockAttachedEntity.readAdditionalSaveData`: `block_pos` when saved; a
// summoned one has none, and `setPos` puts its block at the block holding
// the summon position.
attached_block_pos :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag.get("block_pos") {
    // rust: Some(Tag::IntArray(v)) if v.len() == 3 => Some([v[0], v[1], v[2]]),
    // rust: _ => {
    // rust: let at = position(tag)?;
    // rust: Some([
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: ])
}
}
}
// The block position, facing and variant of a saved painting.
painting_from_nbt :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let pos = attached_block_pos(tag)?;
    // rust: let facing = (number(tag.get("facing")).unwrap_or(0) & 3) as u8;
    // rust: Some((pos, facing, text(tag.get("variant"))?))
}
// Cushion.addAdditionalSaveData: the block it sits on and its colour.
cushion_to_nbt :: proc(c: ^Cushion, uuid: [i32; 4], raw: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let base = Base {
    // rust: id: "minecraft:cushion",
    // rust: uuid,
    // rust: position: c.position,
    // rust: motion: Vec3::ZERO,
    // rust: rotation: [c.yaw, 0.0],
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: let mut tag = base.tag(raw);
    // rust: put(&mut tag, "block_pos", Tag::IntArray(c.pos.to_vec()));
    // rust: put(&mut tag, "color", string(c.color_name()));
    // rust: if let Some(name) = &c.custom_name {
    // rust: put(&mut tag, "CustomName", name.clone());
}
    // rust: tag
}
// The position, block position, yaw and colour of a saved cushion.
cushion_from_nbt :: proc(tag: ^Tag, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let position = position(tag)?;
    // rust: let pos = match tag.get("block_pos") {
    // rust: Some(Tag::IntArray(v)) if v.len() == 3 => [v[0], v[1], v[2]],
    // rust: _ => [
    // rust: position.x.floor() as i32,
    // rust: position.y.floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ],
}
    // rust: let yaw = match tag.get("Rotation") {
    // rust: Some(Tag::List(l)) => l
    // rust: .first()
    // rust: .and_then(|v| crate::save::float(Some(v)))
    // rust: .unwrap_or(0.0) as f32,
    // rust: _ => 0.0,
}
    // rust: let color =
    // rust: crate::entities::dye_index(&text(tag.get("color")).unwrap_or_else(|| "white".into()));
    // rust: Some(Cushion {
    // rust: id,
    // rust: position,
    // rust: pos,
    // rust: yaw,
    // rust: color,
    // rust: check_interval: 0,
    // rust: custom_name: tag.get("CustomName").cloned(),
    // rust: })
}

    // rust: mod cushion_tests {
//     use super::*;

cushion_save_preserves_color_anchor_rotation_and_unknown_data :: proc() {
}
    // rust: let cushion = Cushion {
    // rust: id: 7,
    // rust: position: Vec3::new(-1.5, 64.5, 3.5),
    // rust: pos: [-2, 64, 3],
    // rust: yaw: 270.0,
    // rust: color: 14,
    // rust: check_interval: 55,
    // rust: custom_name: None,
}
    // rust: let raw = Tag::compound([("CustomName", string("Seat"))]);
    // rust: let tag = cushion_to_nbt(&cushion, [1, 2, 3, 4], Some(&raw));
    // rust: assert_eq!(text(tag.get("CustomName")).as_deref(), Some("Seat"));
    // rust: let loaded = cushion_from_nbt(&tag, 8).unwrap();
    // rust: assert_eq!(loaded.id, 8);
    // rust: assert_eq!(loaded.position, cushion.position);
    // rust: assert_eq!(loaded.pos, cushion.pos);
    // rust: assert_eq!(loaded.yaw, cushion.yaw);
    // rust: assert_eq!(loaded.color_name(), "red");
    // rust: assert_eq!(loaded.check_interval, 0);
    // rust: assert_eq!(loaded.bounds(), cushion.bounds());
}
}
// ItemFrame.addAdditionalSaveData.
item_frame_to_nbt :: proc(f: ^ItemFrame, uuid: [i32; 4], raw: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let (lo, hi) = f.bounds();
    // rust: let base = Base {
    // rust: id: f.kind(),
    // rust: uuid,
    // rust: position: Vec3::new(
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: ),
    // rust: motion: Vec3::ZERO,
    // rust: rotation: [0.0, 0.0],
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: let mut tag = base.tag(raw);
    // `Entity.saveWithoutId`: `CustomName` before the frame's own fields.
    // rust: if let Some(name) = &f.custom_name {
    // rust: put(&mut tag, "CustomName", name.clone());
    // rust: } else if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"CustomName".into());
}
    // rust: put(&mut tag, "Facing", Tag::Byte(f.facing as i8));
    // rust: put(&mut tag, "block_pos", Tag::IntArray(f.pos.to_vec()));
    // rust: put(&mut tag, "ItemRotation", Tag::Byte(f.rotation as i8));
    // rust: put(
    // rust: &mut tag,
    // rust: "ItemDropChance",
    // rust: Tag::Float(f.drop_chance.to_bits()),
    // rust: );
    // rust: put(&mut tag, "Invisible", Tag::Byte(i8::from(f.invisible)));
    // rust: put(&mut tag, "Fixed", Tag::Byte(i8::from(f.fixed)));
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&horizon_world::nbt::JavaString::from("Item"));
}
    // rust: if let Some(item) = &f.item {
    // rust: put(&mut tag, "Item", item_to_nbt(item));
}
    // rust: tag
}
item_frame_from_nbt :: proc(tag: ^Tag, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let pos = attached_block_pos(tag)?;
    // rust: Some(ItemFrame {
    // rust: id,
    // rust: pos,
    // rust: facing: number(tag.get("Facing")).unwrap_or(2).clamp(0, 5) as u8,
    // rust: glow: kind(tag).as_deref() == Some("minecraft:glow_item_frame"),
    // rust: item: tag.get("Item").and_then(item_from_nbt),
    // rust: rotation: (number(tag.get("ItemRotation")).unwrap_or(0) & 7) as u8,
    // rust: drop_chance: float(tag.get("ItemDropChance")).map_or(1.0, |v| v as f32),
    // rust: fixed: flag(tag, "Fixed"),
    // rust: invisible: flag(tag, "Invisible"),
    // rust: check_interval: 0,
    // rust: custom_name: tag.get("CustomName").cloned(),
    // rust: })
}
// ArmorStand.addAdditionalSaveData with LivingEntity's `equipment`.
armor_stand_to_nbt :: proc(a: ^ArmorStand, uuid: [i32; 4], raw: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let base = Base {
    // rust: id: "minecraft:armor_stand",
    // rust: uuid,
    // rust: position: a.position,
    // rust: motion: a.velocity,
    // rust: rotation: [a.yaw, a.pitch],
    // rust: on_ground: a.on_ground,
    // rust: fall_distance: a.enchantment_fall_distance,
}
    // rust: let mut tag = base.tag(raw);
    // rust: let equipment: Vec<(&str, Tag)> = ArmorStand::SLOTS
    // rust: .iter()
    // rust: .zip(&a.equipment)
    // rust: .filter_map(|(slot, stack)| Some((*slot, item_to_nbt(stack.as_ref()?))))
    // rust: .collect();
    // `equipment` is saved only when something is worn, `Marker` only when set.
    // rust: if equipment.is_empty() {
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"equipment".into());
}
    // rust: } else {
    // rust: put(&mut tag, "equipment", Tag::compound(equipment));
}
    // rust: put(&mut tag, "DisabledSlots", Tag::Int(a.disabled_slots));
    // rust: for (key, value) in [
    // rust: ("Small", a.small),
    // rust: ("ShowArms", a.show_arms),
    // rust: ("NoBasePlate", a.no_base_plate),
    // rust: ("Invisible", a.invisible),
    // rust: ] {
    // rust: put(&mut tag, key, Tag::Byte(i8::from(value)));
}
    // rust: if a.marker {
    // rust: put(&mut tag, "Marker", Tag::Byte(1));
    // rust: } else if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"Marker".into());
}
    // Entity.saveWithoutId writes NoGravity only when set.
    // rust: if a.no_gravity {
    // rust: put(&mut tag, "NoGravity", Tag::Byte(1));
    // rust: } else if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"NoGravity".into());
}
    // rust: if a.name_visible {
    // rust: put(&mut tag, "CustomNameVisible", Tag::Byte(1));
    // rust: } else if let Tag::Compound(map) = &mut tag {
    // rust: map.remove(&"CustomNameVisible".into());
}
    // A name from the save keeps its own shape unless it changed.
    // rust: if let Some(name) = &a.custom_name
    // rust: && !tag.get("CustomName").is_some_and(|t| name_text(t) == *name)
    // rust: {
    // rust: put(
    // rust: &mut tag,
    // rust: "CustomName",
    // rust: crate::scoreboard::json_to_tag(&name.component()),
    // rust: );
}
    // rust: put(&mut tag, "Health", Tag::Float(a.health.to_bits()));
    // rust: put(&mut tag, "Fire", Tag::Short(a.fire_ticks as i16));
    // ArmorStand.addAdditionalSaveData: the `Pose` parts that are not default.
    // rust: let pose: Vec<(&str, Tag)> = ArmorStand::POSE_KEYS
    // rust: .into_iter()
    // rust: .zip(a.pose)
    // rust: .zip(ArmorStand::DEFAULT_POSE)
    // rust: .filter(|((_, rotation), default)| rotation != default)
    // rust: .map(|((key, rotation), _)| (key, floats(&rotation)))
    // rust: .collect();
    // rust: put(&mut tag, "Pose", Tag::compound(pose));
    // LivingEntity.addAdditionalSaveData and ArmorStand's own fields.
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: for (key, value) in [
    // rust: ("HurtTime", Tag::Short(0)),
    // rust: ("DeathTime", Tag::Short(0)),
    // rust: ("AbsorptionAmount", Tag::Float(0)),
    // rust: ("FallFlying", Tag::Byte(0)),
    // rust: ("current_impulse_context_reset_grace_time", Tag::Int(0)),
            // AttributeMap.pack: the movement_speed instance the stand's first
            // tick makes (removeFrost), at the registry default.
    // rust: (
    // rust: "attributes",
    // rust: Tag::List(if a.speed_instance {
    // rust: vec![Tag::compound([
    // rust: ("id", string(SPEED_ATTRIBUTE)),
    // rust: ("base", Tag::Double(0.7f64.to_bits())),
    // rust: ])]
    // rust: } else {
    // rust: Vec::new()
    // rust: }),
    // rust: ),
    // rust: (
    // rust: "Brain",
    // rust: Tag::compound([("memories", Tag::Compound(Compound::new()))]),
    // rust: ),
    // rust: ("DisabledSlots", Tag::Int(0)),
    // rust: ("Pose", Tag::Compound(Compound::new())),
    // rust: ] {
    // rust: map.entry(key.into()).or_insert(value);
}
}
    // rust: tag
}
// The attribute every living entity's first tick makes (`removeFrost`).
SPEED_ATTRIBUTE :: "minecraft:movement_speed"
armor_stand_from_nbt :: proc(tag: ^Tag, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = ArmorStand::new(id, position(tag)?, rotation(tag)[0]);
    // rust: a.enchantment_fall_distance = float(tag.get("fall_distance")).unwrap_or(0.0);
    // AttributeMap.load makes an instance for each saved attribute.
    // rust: a.speed_instance = matches!(tag.get("attributes"), Some(Tag::List(list))
    // rust: if list.iter().any(|attr| text(attr.get("id")).as_deref() == Some(SPEED_ATTRIBUTE)));
    // rust: a.velocity = motion(tag);
    // rust: a.health = float(tag.get("Health")).unwrap_or(20.0) as f32;
    // rust: a.fire_ticks = number(tag.get("Fire")).unwrap_or(0) as i32;
    // rust: a.custom_name = tag.get("CustomName").map(name_text);
    // rust: a.name_visible = flag(tag, "CustomNameVisible");
    // rust: if let Some(eq) = tag.get("equipment") {
    // rust: for (i, slot) in ArmorStand::SLOTS.iter().enumerate() {
    // rust: a.equipment[i] = eq.get(slot).and_then(item_from_nbt);
}
}
    // rust: a.small = flag(tag, "Small");
    // rust: a.show_arms = flag(tag, "ShowArms");
    // rust: a.disabled_slots = number(tag.get("DisabledSlots")).unwrap_or(0) as i32;
    // rust: a.no_base_plate = flag(tag, "NoBasePlate");
    // rust: a.invisible = flag(tag, "Invisible");
    // rust: a.marker = flag(tag, "Marker");
    // rust: a.no_gravity = flag(tag, "NoGravity");
    // rust: a.on_ground = flag(tag, "OnGround");
    // ArmorStand.readAdditionalSaveData: each part of `Pose` that is a list of
    // three numbers, the others staying at their defaults.
    // rust: if let Some(pose) = tag.get("Pose") {
    // rust: for (rotation, key) in a.pose.iter_mut().zip(ArmorStand::POSE_KEYS) {
    // rust: if let Some(Tag::List(values)) = pose.get(key)
    // rust: && values.len() == 3
    // rust: {
    // rust: for (r, v) in rotation.iter_mut().zip(values) {
    // rust: *r = float(Some(v)).unwrap_or(0.0) as f32;
}
}
}
}
    // rust: Some(a)
}
// A boat entity (`minecraft:<wood>_boat`, `minecraft:bamboo_chest_raft`...):
// chest boats keep their slots in `Items` (`ContainerHelper.saveAllItems`).
    // rust: pub fn boat_to_nbt(
    // rust: id: &str,
    // rust: position: Vec3,
    // rust: motion: Vec3,
    // rust: rotation: [f32; 2],
    // rust: uuid: [i32; 4],
    // rust: raw: Option<&Tag>,
    // rust: items: Option<&[Option<crate::items::ItemStack>]>,
    // rust: ) -> Tag {
    // rust: let mut tag = Base {
    // rust: id,
    // rust: uuid,
    // rust: position,
    // rust: motion,
    // rust: rotation,
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: .tag(raw);
    // rust: if let (Some(items), Tag::Compound(map)) = (items, &mut tag) {
    // rust: map.insert("Items".into(), crate::save::encode_items(items));
}
    // rust: tag
}
// A vehicle's base entity tag (boats and minecarts).
    // rust: pub fn vehicle_to_nbt(
    // rust: id: &str,
    // rust: position: Vec3,
    // rust: motion: Vec3,
    // rust: rotation: [f32; 2],
    // rust: uuid: [i32; 4],
    // rust: raw: Option<&Tag>,
    // rust: ) -> Tag {
    // rust: Base {
    // rust: id,
    // rust: uuid,
    // rust: position,
    // rust: motion,
    // rust: rotation,
    // rust: on_ground: false,
    // rust: fall_distance: 0.0,
}
    // rust: .tag(raw)
}
boat_from_nbt :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some((position(tag)?, motion(tag), rotation(tag)[0]))
}

// `VillagerData`: type, profession and level.
villager_data :: proc(m: ^Mob) -> T {
    // Ported from Horizon
    return {}
}
//     use crate::mobs::render::{PROFESSIONS, VILLAGER_TYPES};
    // rust: Tag::compound([
    // rust: (
    // rust: "type",
    // rust: string(&format!(
    // rust: "minecraft:{}",
    // rust: VILLAGER_TYPES[m.extra.variant as usize % VILLAGER_TYPES.len()]
    // rust: )),
    // rust: ),
    // rust: (
    // rust: "profession",
    // rust: string(&format!(
    // rust: "minecraft:{}",
    // rust: PROFESSIONS[m.extra.variant2 as usize % PROFESSIONS.len()]
    // rust: )),
    // rust: ),
    // rust: ("level", Tag::Int(i32::from(m.extra.variant3.max(1)))),
    // rust: ])
}
// `AbstractVillager` "Offers" (`MerchantOffers.CODEC`).
put_offers :: proc(map: ^Compound, m: ^Mob) {
}
    // rust: let Some(t) = m.extra.trade.as_ref().filter(|t| !t.unset) else {
    // rust: return;
}
    // rust: map.insert("Offers".into(), offers_to_nbt(&t.offers));
}
// `ItemCost.CODEC`: id, count (always written) and the exact components.
item_cost_to_nbt :: proc(stack: ^crate::items::ItemStack) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = item_to_nbt(stack);
    // rust: if let Tag::Compound(c) = &mut tag
    // rust: && !c.contains_key(&"count".into())
    // rust: {
    // rust: c.insert("count".into(), Tag::Int(stack.count as i32));
}
    // rust: tag
}
// `MerchantOffers.CODEC`: `{Recipes: [...]}`, each offer without the
// fields at their defaults.
offers_to_nbt :: proc(offers: ^[crate::merchant::MerchantOffer]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let recipes = offers
    // rust: .iter()
    // rust: .map(|o| {
    // rust: let mut entries = vec![
    // rust: ("buy", item_cost_to_nbt(&o.base_cost_a.stack)),
    // rust: ("sell", item_to_nbt(&o.result)),
    // rust: ];
            // `MerchantOffer.CODEC` omits fields at their defaults.
    // rust: if o.uses != 0 {
    // rust: entries.push(("uses", Tag::Int(o.uses)));
}
    // rust: if o.max_uses != 4 {
    // rust: entries.push(("maxUses", Tag::Int(o.max_uses)));
}
    // rust: if o.price_multiplier != 0.0 {
    // rust: entries.push(("priceMultiplier", Tag::Float(o.price_multiplier.to_bits())));
}
    // rust: if o.xp != 1 {
    // rust: entries.push(("xp", Tag::Int(o.xp)));
}
    // rust: if !o.reward_exp {
    // rust: entries.push(("rewardExp", Tag::Byte(0)));
}
    // rust: if o.special_price_diff != 0 {
    // rust: entries.push(("specialPrice", Tag::Int(o.special_price_diff)));
}
    // rust: if o.demand != 0 {
    // rust: entries.push(("demand", Tag::Int(o.demand)));
}
    // rust: if let Some(b) = &o.cost_b {
    // rust: entries.push(("buyB", item_cost_to_nbt(&b.stack)));
}
    // rust: Tag::compound(entries)
    // rust: })
    // rust: .collect::<Vec<_>>();
    // An empty list is the field's default: left out.
    // rust: if recipes.is_empty() {
    // rust: return Tag::Compound(Compound::new());
}
    // rust: Tag::compound([("Recipes", Tag::List(recipes))])
}
// The offers of a `MerchantOffers.CODEC` tag.
offers_from_nbt :: proc(tag: ^Tag) -> V {
    // Ported from Horizon
    return {}
}
//     use crate::merchant::{ItemCost, MerchantOffer};
    // rust: let Some(Tag::List(recipes)) = tag.get("Recipes") else {
    // rust: return Vec::new();
}
    // rust: recipes
    // rust: .iter()
    // rust: .filter_map(|r| {
    // rust: let cost = |key| {
    // rust: r.get(key)
    // rust: .and_then(item_from_nbt)
    // rust: .map(|stack| ItemCost { stack })
}
    // rust: Some(MerchantOffer {
    // rust: base_cost_a: cost("buy")?,
    // rust: cost_b: cost("buyB"),
    // rust: result: r.get("sell").and_then(item_from_nbt)?,
    // rust: uses: number(r.get("uses")).unwrap_or(0) as i32,
    // rust: max_uses: number(r.get("maxUses")).unwrap_or(4) as i32,
    // rust: reward_exp: number(r.get("rewardExp")).unwrap_or(1) != 0,
    // rust: special_price_diff: number(r.get("specialPrice")).unwrap_or(0) as i32,
    // rust: demand: number(r.get("demand")).unwrap_or(0) as i32,
    // rust: price_multiplier: float(r.get("priceMultiplier")).unwrap_or(0.0) as f32,
    // rust: xp: number(r.get("xp")).unwrap_or(1) as i32,
    // rust: })
    // rust: })
    // rust: .collect()
}
// The villager brain's `job_site`, `home` and `meeting_point` memories.
put_memories :: proc(map: ^Compound, m: ^Mob) {
}
    // rust: let mut memories: Vec<(&str, Tag)> = [
    // rust: ("minecraft:job_site", m.extra.home),
    // rust: ("minecraft:home", m.extra.bed),
    // rust: ("minecraft:meeting_point", m.extra.meeting),
    // rust: ]
    // rust: .into_iter()
    // rust: .filter_map(|(key, p)| {
    // rust: let pos = Tag::compound([
    // rust: ("dimension", string("minecraft:overworld")),
    // rust: ("pos", Tag::IntArray(p?.to_vec())),
    // rust: ]);
    // rust: Some((key, Tag::compound([("value", pos)])))
    // rust: })
    // rust: .collect();
    // rust: crate::mobs::villager::write_memories(m, &mut memories);
    // rust: map.insert(
    // rust: "Brain".into(),
    // rust: Tag::compound([("memories", Tag::compound(memories))]),
    // rust: );
}
read_villager :: proc(m: ^Mob, tag: ^Tag) {
}
//     use crate::{
    // rust: merchant::Trader,
    // rust: mobs::render::{PROFESSIONS, VILLAGER_TYPES},
}
    // rust: if let Some(data) = tag.get("VillagerData") {
    // rust: let name = |key| text(data.get(key)).map(|s| s.trim_start_matches("minecraft:").to_owned());
    // rust: if let Some(t) = name("type").and_then(|t| VILLAGER_TYPES.iter().position(|v| *v == t)) {
    // rust: m.extra.variant = t as u8;
}
    // rust: m.extra.variant2 = name("profession")
    // rust: .and_then(|p| PROFESSIONS.iter().position(|v| *v == p))
    // rust: .unwrap_or(0) as u8;
    // rust: m.extra.variant3 = number(data.get("level")).unwrap_or(1).clamp(1, 5) as u8;
}
    // rust: let memory = |key: &str| {
    // rust: tag.get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|b| b.get(key))
    // rust: .and_then(|j| j.get("value"))
    // rust: .and_then(|v| match v.get("pos") {
    // rust: Some(Tag::IntArray(a)) if a.len() == 3 => Some([a[0], a[1], a[2]]),
    // rust: _ => None,
    // rust: })
}
    // rust: m.extra.home = memory("minecraft:job_site");
    // rust: m.extra.bed = memory("minecraft:home");
    // rust: m.extra.meeting = memory("minecraft:meeting_point");
    // rust: if m.species() == crate::mobs::Species::Villager {
    // rust: crate::mobs::villager::read_nbt(m, tag);
}
    // rust: if m.species() == crate::mobs::Species::WanderingTrader {
        // WanderingTrader.readAdditionalSaveData: both default to idle.
    // rust: m.extra.ints[5] = number(tag.get("DespawnDelay")).unwrap_or(0) as i32;
    // rust: m.extra.point = match tag.get("wander_target") {
    // rust: Some(Tag::IntArray(a)) if a.len() == 3 => {
    // rust: Some([f64::from(a[0]), f64::from(a[1]), f64::from(a[2])])
}
    // rust: _ => None,
}
}
    // rust: let offers_tag = tag.get("Offers");
    // rust: let xp = number(tag.get("Xp")).unwrap_or(0) as i32;
    // rust: if offers_tag.is_none() && xp == 0 && tag.get("LastRestock").is_none() {
    // rust: return;
}
    // rust: let offers = offers_tag.map(offers_from_nbt).unwrap_or_default();
    // rust: m.extra.trade = Some(Box::new(Trader {
    // rust: unset: offers_tag.is_none(),
    // rust: xp: number(tag.get("Xp")).unwrap_or(0) as i32,
    // rust: offers,
    // rust: last_restock: number(tag.get("LastRestock")).unwrap_or(0),
    // rust: restocks_today: number(tag.get("RestocksToday")).unwrap_or(0) as i32,
    // rust: check_day: 0,
    // rust: }));
}

    // rust: mod tnt_power_tests {
//     use super::*;

    // `PrimedTnt.readAdditionalSaveData`: `explosion_power` defaults to 4 and
    // is clamped to 0..128 both ways, so a summoned `explosion_power:200` is
    // 128 and one that is absent is ordinary TNT.
explosion_power_is_read_clamped_and_defaulted :: proc() {
}
    // rust: let with = |power: Option<f32>| {
    // rust: let mut map = std::collections::BTreeMap::new();
    // rust: if let Some(p) = power {
    // rust: map.insert("explosion_power".into(), Tag::Float(p.to_bits()));
}
    // rust: Tag::Compound(map)
}
    // rust: assert_eq!(tnt_power(&with(None)), 4.0);
    // rust: assert_eq!(tnt_power(&with(Some(10.0))), 10.0);
    // rust: assert_eq!(tnt_power(&with(Some(200.0))), 128.0);
    // rust: assert_eq!(tnt_power(&with(Some(-3.0))), 0.0);
        // And it round-trips through the save, which writes it only when it is
        // not the default.
    // rust: let saved = tnt_to_nbt(
    // rust: Vec3::ZERO,
    // rust: Vec3::ZERO,
    // rust: false,
    // rust: 20,
    // rust: 10.0,
    // rust: string("minecraft:tnt"),
    // rust: [0.0, 0.0],
    // rust: [1, 2, 3, 4],
    // rust: None,
    // rust: );
    // rust: assert_eq!(tnt_power(&saved), 10.0);
    // rust: let plain = tnt_to_nbt(
    // rust: Vec3::ZERO,
    // rust: Vec3::ZERO,
    // rust: false,
    // rust: 20,
    // rust: 4.0,
    // rust: string("minecraft:tnt"),
    // rust: [0.0, 0.0],
    // rust: [1, 2, 3, 4],
    // rust: None,
    // rust: );
    // rust: assert!(plain.get("explosion_power").is_none());
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::items::ItemStack;

conversion_keeps_only_the_old_mobs_command_tags :: proc() {
}
    // rust: let tags = Tag::List(vec![
    // rust: Tag::String("subject".into()),
    // rust: Tag::String("quest".into()),
    // rust: ]);
    // rust: let raw = Tag::compound([
    // rust: ("id", Tag::String("minecraft:husk".into())),
    // rust: ("UUID", Tag::IntArray(vec![1, 2, 3, 4])),
    // rust: ("HuskConversionTime", Tag::Int(1)),
    // rust: ("Tags", tags.clone()),
    // rust: ]);
    // rust: let original = raw.clone();
    // rust: assert_eq!(
    // rust: conversion_tags(Some(&raw)),
    // rust: Some(Tag::compound([("Tags", tags)]))
    // rust: );
    // rust: assert_eq!(raw, original);
    // rust: assert_eq!(conversion_tags(None), None);
    // rust: assert_eq!(
    // rust: conversion_tags(Some(&Tag::compound([("Tags", Tag::List(Vec::new()))]))),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: conversion_tags(Some(&Tag::Compound(Default::default()))),
    // rust: None
    // rust: );
}

cubes_omit_supplied_age_and_pigs_keep_modeled_age :: proc() {
}
//         use crate::mobs::Species;
    // rust: for (species, id) in [
    // rust: (Species::Slime, "minecraft:slime"),
    // rust: (Species::MagmaCube, "minecraft:magma_cube"),
    // rust: (Species::Pig, "minecraft:pig"),
    // rust: ] {
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.species = species;
    // rust: ty.id = id.into();
    // rust: let mut mob = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: mob.extra.age = -37;
    // rust: let expected = (species == Species::Pig).then_some(Tag::Int(-37));
    // rust: for age in [None, Some(0), Some(-24000), Some(37)] {
    // rust: let mut raw = Tag::compound([("h228_control", Tag::Int(42))]);
    // rust: if let Some(age) = age
    // rust: && let Tag::Compound(map) = &mut raw
    // rust: {
    // rust: map.insert("Age".into(), Tag::Int(age));
}
    // rust: let saved = mob_to_nbt(&mob, [0; 4], Some(&raw), None);
    // rust: assert_eq!(saved.get("Age"), expected.as_ref(), "{species:?}, {age:?}");
    // rust: assert_eq!(saved.get("h228_control"), Some(&Tag::Int(42)));
}
    // rust: let saved = mob_to_nbt(&mob, [0; 4], None, None);
    // rust: assert_eq!(
    // rust: saved.get("Age"),
    // rust: expected.as_ref(),
    // rust: "{species:?}, no raw tag"
    // rust: );
}
}

zombie_nautilus_save_omits_ignored_age_fields :: proc() {
}
//         use crate::mobs::Species;
    // rust: for (id, species) in [
    // rust: ("minecraft:zombie_nautilus", Species::ZombieNautilus),
    // rust: ("minecraft:nautilus", Species::Nautilus),
    // rust: ] {
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let def = Arc::make_mut(&mut kind);
    // rust: def.id = id.into();
    // rust: def.species = species;
    // rust: let mut mob = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: mob.extra.age = -123;
    // rust: mob.extra.forced_age = 19;
    // rust: mob.extra.age_locked = true;
    // rust: let raw = Tag::compound([
    // rust: ("Age", Tag::Int(37)),
    // rust: ("ForcedAge", Tag::Int(99)),
    // rust: ("AgeLocked", Tag::Byte(0)),
    // rust: ("audit:unrelated", Tag::Int(7)),
    // rust: ]);
    // rust: for base in [None, Some(&raw)] {
    // rust: let saved = mob_to_nbt(&mob, [0; 4], base, None);
    // rust: for (key, expected) in [
    // rust: ("Age", Tag::Int(-123)),
    // rust: ("ForcedAge", Tag::Int(19)),
    // rust: ("AgeLocked", Tag::Byte(1)),
    // rust: ] {
    // rust: if species == Species::ZombieNautilus {
    // rust: assert!(saved.get(key).is_none(), "{id}: {key}");
    // rust: } else {
    // rust: assert_eq!(saved.get(key), Some(&expected), "{id}: {key}");
}
}
    // rust: if base.is_some() {
    // rust: assert_eq!(saved.get("audit:unrelated"), Some(&Tag::Int(7)));
}
}
}
}

    // A mount keeps its body armour and a helmet (say
    // `/item replace entity <horse> armor.head with minecraft:iron_helmet`)
    // in their own slots through a save: vanilla holds both (`equipment.body`
    // and `equipment.head`), one in each.
a_horses_save_keeps_a_helmet_and_its_body_armour_apart :: proc() {
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.id = "minecraft:horse".into();
    // rust: ty.species = crate::mobs::Species::Horse;
    // rust: let types = [("minecraft:horse".into(), kind)].into();
    // rust: let raw = Tag::compound([
    // rust: ("id", string("minecraft:horse")),
    // rust: ("Pos", doubles(&[4.5, 220.0, 4.5])),
    // rust: ("Tame", Tag::Byte(1)),
    // rust: (
    // rust: "equipment",
    // rust: Tag::compound([
    // rust: (
    // rust: "body",
    // rust: Tag::compound([
    // rust: ("id", string("minecraft:diamond_horse_armor")),
    // rust: ("count", Tag::Int(1)),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "head",
    // rust: Tag::compound([
    // rust: ("id", string("minecraft:iron_helmet")),
    // rust: ("count", Tag::Int(1)),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: let m = mob_from_nbt(&raw, &types, 1, None).unwrap();
    // rust: assert_eq!(
    // rust: m.extra.body.as_deref(),
    // rust: Some("minecraft:diamond_horse_armor")
    // rust: );
    // rust: assert_eq!(m.extra.head.as_deref(), Some("minecraft:iron_helmet"));
    // rust: let saved = mob_to_nbt(&m, [0; 4], Some(&raw), None);
    // rust: let eq = saved.get("equipment").unwrap();
    // rust: let id = |key: &str| {
    // rust: eq.get(key)
    // rust: .and_then(|i| text(i.get("id")))
    // rust: .unwrap_or_default()
}
    // rust: assert_eq!(id("body"), "minecraft:diamond_horse_armor");
    // rust: assert_eq!(id("head"), "minecraft:iron_helmet");
}

    // A wolf loads its armor (`equipment.body`) into the body slot with the
    // durability it lost, and a helmet next to it into the head slot.
a_wolfs_save_keeps_its_armour_and_a_helmet_apart :: proc() {
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.id = "minecraft:wolf".into();
    // rust: ty.species = crate::mobs::Species::Wolf;
    // rust: let types = [("minecraft:wolf".into(), kind)].into();
    // rust: let armor = Tag::compound([
    // rust: ("id", string("minecraft:wolf_armor")),
    // rust: ("count", Tag::Int(1)),
    // rust: (
    // rust: "components",
    // rust: Tag::compound([("minecraft:damage", Tag::Int(9))]),
    // rust: ),
    // rust: ]);
    // rust: let raw = Tag::compound([
    // rust: ("id", string("minecraft:wolf")),
    // rust: ("Pos", doubles(&[4.5, 220.0, 4.5])),
    // rust: ("Owner", Tag::IntArray([0; 4].to_vec())),
    // rust: (
    // rust: "equipment",
    // rust: Tag::compound([
    // rust: ("body", armor),
    // rust: (
    // rust: "head",
    // rust: Tag::compound([
    // rust: ("id", string("minecraft:iron_helmet")),
    // rust: ("count", Tag::Int(1)),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: let m = mob_from_nbt(&raw, &types, 1, None).unwrap();
    // rust: assert_eq!(m.extra.body.as_deref(), Some("minecraft:wolf_armor"));
    // rust: assert_eq!(m.extra.body_damage, 9);
    // rust: assert_eq!(m.extra.head.as_deref(), Some("minecraft:iron_helmet"));
}

fused_creeper :: proc(fuse: Maybe(i16)) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.id = "minecraft:creeper".into();
    // rust: ty.species = crate::mobs::Species::Creeper;
    // rust: let types = [("minecraft:creeper".into(), kind)].into();
    // rust: let mut tag = Tag::compound([
    // rust: ("id", string("minecraft:creeper")),
    // rust: ("Pos", doubles(&[4.5, 220.0, 4.5])),
    // rust: ("ignited", Tag::Byte(1)),
    // rust: ("NoAI", Tag::Byte(1)),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: ]);
    // rust: if let (Some(fuse), Tag::Compound(c)) = (fuse, &mut tag) {
    // rust: c.insert("Fuse".into(), Tag::Short(fuse));
}
    // rust: (mob_from_nbt(&tag, &types, 1, None).unwrap(), tag)
}

creeper_fuse_nbt_controls_explosion_tick_and_saves_runtime_value :: proc() {
}
    // rust: for (fuse, boundary) in [
    // rust: (Some(1), 1),
    // rust: (None, 30),
    // rust: (Some(40), 40),
    // rust: (Some(0), 1),
    // rust: (Some(-1), 1),
    // rust: ] {
    // rust: let (mut mob, raw) = fused_creeper(fuse);
    // rust: let mut events = Vec::new();
    // rust: for tick in 1..=boundary {
    // rust: crate::mobs::hostile::creeper_tick(&mut mob, &mut events);
    // rust: assert_eq!(mob.removed, tick == boundary, "Fuse={fuse:?}, tick={tick}");
}
    // rust: assert_eq!(
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, crate::mobs::MobEvent::Explode(..)))
    // rust: .count(),
    // rust: 1
    // rust: );
    // rust: mob.max_swell = 7;
    // rust: let saved = mob_to_nbt(&mob, [0; 4], Some(&raw), None);
    // rust: assert_eq!(saved.get("Fuse"), Some(&Tag::Short(7)));
}
}

creeper_fall_swell_uses_custom_fuse_without_a_zero_floor :: proc() {
}
    // rust: for (fuse, expected) in [(Some(1), -4), (None, 25), (Some(40), 35)] {
    // rust: let (mut mob, _) = fused_creeper(fuse);
    // rust: mob.cause_fall_damage_from(100.0, 0.0, &mut Vec::new());
    // rust: assert_eq!(mob.swell, expected, "Fuse={fuse:?}");
}
}

loaded_villager_command_names_follow_profession_and_custom_name :: proc() {
}
//         use crate::mobs::Species;
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let def = Arc::make_mut(&mut kind);
    // rust: def.id = "minecraft:villager".into();
    // rust: def.species = Species::Villager;
    // rust: let types = [("minecraft:villager".into(), kind)].into();
    // rust: for (profession, key) in [
    // rust: ("none", "entity.minecraft.villager.none"),
    // rust: ("nitwit", "entity.minecraft.villager.nitwit"),
    // rust: ("cleric", "entity.minecraft.villager.cleric"),
    // rust: ("farmer", "entity.minecraft.villager.farmer"),
    // rust: ("librarian", "entity.minecraft.villager.librarian"),
    // rust: ] {
    // rust: let data = Tag::compound([
    // rust: ("profession", string(&format!("minecraft:{profession}"))),
    // rust: ("type", string("minecraft:plains")),
    // rust: ("level", Tag::Int(1)),
    // rust: ]);
    // rust: let mut tag = Tag::compound([
    // rust: ("id", string("minecraft:villager")),
    // rust: ("Pos", doubles(&[4.5, 220.0, 4.5])),
    // rust: ("NoAI", Tag::Byte(1)),
    // rust: ("VillagerData", data.clone()),
    // rust: ]);
    // rust: let mob = mob_from_nbt(&tag, &types, 7, None).unwrap();
    // rust: assert_eq!(villager_data(&mob), data);
    // rust: assert_eq!(mob.command_name().translation_key(), Some(key));
    // rust: put(&mut tag, "CustomName", string("Ada"));
    // rust: let named = mob_from_nbt(&tag, &types, 8, None).unwrap();
    // rust: assert_eq!(
    // rust: named.command_name().component(),
    // rust: crate::text::Text::literal("Ada").component()
    // rust: );
}
}

other_mob_command_names_keep_their_type_and_custom_name :: proc() {
}
//         use crate::mobs::Species;
    // rust: for (id, species, key) in [
    // rust: (
    // rust: "minecraft:zombie_villager",
    // rust: Species::ZombieVillager,
    // rust: "entity.minecraft.zombie_villager",
    // rust: ),
    // rust: (
    // rust: "minecraft:wandering_trader",
    // rust: Species::WanderingTrader,
    // rust: "entity.minecraft.wandering_trader",
    // rust: ),
    // rust: ("audit:helper", Species::Pig, "entity.audit.helper"),
    // rust: ] {
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let def = Arc::make_mut(&mut kind);
    // rust: def.id = id.into();
    // rust: def.species = species;
    // rust: let mut mob = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: mob.extra.variant2 = 4;
    // rust: assert_eq!(mob.command_name().translation_key(), Some(key));
    // rust: mob.custom_name = Some("Ada".into());
    // rust: assert_eq!(mob.command_name().plain(), "Ada");
}
}

mob_loading_accepts_default_namespace_and_preserves_custom_namespaces :: proc() {
}
    // rust: let cow = crate::mobs::sensor_scan_tests::kind();
    // rust: let types = [
    // rust: ("minecraft:cow".into(), cow.clone()),
    // rust: ("test:cow".into(), cow),
    // rust: ]
    // rust: .into();
    // rust: let pos = || {
    // rust: Tag::List(
    // rust: [4.5_f64, 220.0, 6.5]
    // rust: .map(|v| Tag::Double(v.to_bits()))
    // rust: .to_vec(),
    // rust: )
}
    // rust: for id in ["cow", ":cow", "minecraft:cow", "test:cow"] {
    // rust: let tag = Tag::compound([("id", string(id)), ("Pos", pos()), ("NoAI", Tag::Byte(1))]);
    // rust: let mob = mob_from_nbt(&tag, &types, 7, None).expect(id);
    // rust: assert_eq!(mob.position, Vec3::new(4.5, 220.0, 6.5));
    // rust: assert!(mob.no_ai);
}
    // rust: let unknown = Tag::compound([("id", string("other:cow")), ("Pos", pos())]);
    // rust: assert!(mob_from_nbt(&unknown, &types, 8, None).is_none());
}

    // A saved rocket and trident come back with their own Life, LifeTime,
    // flags and position (the keys vanilla's addAdditionalSaveData writes).
rocket_and_trident_round_trip :: proc() {
}
    // rust: let item = ItemStack::new("minecraft:firework_rocket", 1);
    // rust: let tag = firework_rocket_to_nbt(
    // rust: &RocketSave {
    // rust: rotation: [0.0, 0.0],
    // rust: position: Vec3::new(1.5, 70.0, -3.25),
    // rust: motion: Vec3::new(0.0, 0.5, 0.0),
    // rust: life: 7,
    // rust: lifetime: 31,
    // rust: item: &item,
    // rust: angled: true,
    // rust: owner: None,
    // rust: left_owner: false,
    // rust: },
    // rust: [1, 2, 3, 4],
    // rust: None,
    // rust: );
    // rust: let r = firework_rocket_from_nbt(&tag, None).unwrap();
    // rust: assert_eq!((r.life, r.lifetime, r.angled), (7, 31, true));
    // rust: assert_eq!(r.position, Vec3::new(1.5, 70.0, -3.25));
    // rust: let trident = ItemStack::new("minecraft:trident", 1);
    // rust: let tag = trident_to_nbt(
    // rust: &TridentSave {
    // rust: position: Vec3::new(2.0, 64.0, 2.0),
    // rust: motion: Vec3::new(0.0, -0.25, 0.0),
    // rust: yaw: 10.0,
    // rust: pitch: 20.0,
    // rust: in_ground: true,
    // rust: life: 9,
    // rust: shake: 3,
    // rust: dealt_damage: true,
    // rust: creative_only: true,
    // rust: no_gravity: true,
    // rust: fire_ticks: 0,
    // rust: item: &trident,
    // rust: },
    // rust: [1, 2, 3, 4],
    // rust: None,
    // rust: );
    // rust: let t = trident_from_nbt(&tag).unwrap();
        // `Entity.saveWithoutId` writes NoGravity only when set.
    // rust: assert!(t.no_gravity);
    // rust: assert!(matches!(tag.get("NoGravity"), Some(Tag::Byte(1))));
    // rust: assert_eq!((t.in_ground, t.life, t.shake), (true, 9, 3));
    // rust: assert_eq!((t.dealt_damage, t.creative_only), (true, true));
    // rust: assert_eq!((t.yaw, t.pitch), (10.0, 20.0));
}

    // The item, the spawn delay and the fields Horizon doesn't model come
    // back; a compound without an item is no spawner.
ominous_item_spawner_round_trip :: proc() {
}
    // rust: let item = ItemStack {
    // rust: item: Arc::from("minecraft:ominous_trial_key"),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: let raw = Tag::compound([("CustomName", string("kept"))]);
    // rust: let at = Vec3::new(10.5, 64.25, -3.5);
    // rust: let tag = ominous_item_spawner_to_nbt(&item, at, 97, [1, 2, 3, 4], Some(&raw));
    // rust: assert_eq!(
    // rust: kind(&tag).as_deref(),
    // rust: Some("minecraft:ominous_item_spawner")
    // rust: );
    // rust: assert_eq!(uuid(&tag), Some([1, 2, 3, 4]));
    // rust: assert!(matches!(
    // rust: tag.get("spawn_item_after_ticks"),
    // rust: Some(Tag::Long(97))
    // rust: ));
    // rust: assert!(tag.get("CustomName").is_some());
    // rust: let (back, pos, after) = ominous_item_spawner_from_nbt(&tag).unwrap();
    // rust: assert_eq!(
    // rust: (back.item.as_ref(), back.count),
    // rust: ("minecraft:ominous_trial_key", 1)
    // rust: );
    // rust: assert_eq!((pos, after), (at, 97));
    // rust: assert!(ominous_item_spawner_from_nbt(&raw).is_none());
        // No item is `ItemStack.EMPTY`, which writes no key back.
    // rust: let empty = ominous_item_spawner_to_nbt(
    // rust: &crate::items::ItemStack::new("minecraft:air", 1),
    // rust: at,
    // rust: 0,
    // rust: [1, 2, 3, 4],
    // rust: Some(&tag),
    // rust: );
    // rust: assert!(empty.get("item").is_none());
    // rust: let (back, pos, after) = ominous_item_spawner_from_nbt(&empty).unwrap();
    // rust: assert_eq!((back.item.as_ref(), pos, after), ("minecraft:air", at, 0));
}

armor_stand_names_keep_their_formatting_across_a_save :: proc() {
}
    // rust: let tag = Tag::compound([
    // rust: (
    // rust: "Pos",
    // rust: Tag::List(vec![
    // rust: Tag::Double(0.0f64.to_bits()),
    // rust: Tag::Double(64.0f64.to_bits()),
    // rust: Tag::Double(0.0f64.to_bits()),
    // rust: ]),
    // rust: ),
    // rust: ("CustomName", string("§6Hello")),
    // rust: ("CustomNameVisible", Tag::Byte(1)),
    // rust: ]);
    // rust: let a = armor_stand_from_nbt(&tag, 7).unwrap();
    // rust: let name = a.custom_name.as_ref().unwrap();
    // rust: assert_eq!(name.plain(), "Hello");
    // rust: assert!(name.spans[0].style.color.is_some());
    // rust: assert!(a.name_visible);
    // rust: let saved = armor_stand_to_nbt(&a, [0; 4], Some(&tag));
    // rust: let restored = armor_stand_from_nbt(&saved, 7).unwrap();
    // rust: assert_eq!(restored.custom_name, a.custom_name);
    // rust: assert!(restored.name_visible);
}

armor_stand_keeps_no_gravity_through_a_save :: proc() {
}
    // rust: let tag = Tag::compound([
    // rust: ("id", string("minecraft:armor_stand")),
    // rust: (
    // rust: "Pos",
    // rust: Tag::List(vec![
    // rust: Tag::Double(0.0f64.to_bits()),
    // rust: Tag::Double(64.0f64.to_bits()),
    // rust: Tag::Double(0.0f64.to_bits()),
    // rust: ]),
    // rust: ),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: ]);
    // rust: let mut a = armor_stand_from_nbt(&tag, 7).unwrap();
    // rust: assert!(a.no_gravity, "summon NBT sets the flag");
    // rust: let saved = armor_stand_to_nbt(&a, [0; 4], Some(&tag));
    // rust: assert_eq!(saved.get("NoGravity"), Some(&Tag::Byte(1)));
    // rust: assert!(armor_stand_from_nbt(&saved, 7).unwrap().no_gravity);
        // `data merge entity @s {NoGravity:0b}` clears it again.
    // rust: a.no_gravity = false;
    // rust: let cleared = armor_stand_to_nbt(&a, [0; 4], Some(&saved));
    // rust: assert!(cleared.get("NoGravity").is_none());
    // rust: assert!(!armor_stand_from_nbt(&cleared, 7).unwrap().no_gravity);
}

falling_block_round_trip_keeps_impact_distance_and_settings :: proc() {
}
    // rust: let state = Tag::compound([("Name", string("minecraft:damaged_anvil"))]);
    // rust: let position = Vec3::new(3.5, 100.0, -7.5);
    // rust: let velocity = Vec3::new(0.0, -1.25, 0.0);
    // rust: let damage = crate::falling_block::Damage {
    // rust: cancel_drop: true,
    // rust: ..crate::falling_block::Damage::anvil()
}
    // rust: let tag = falling_block_to_nbt(
    // rust: state.clone(),
    // rust: position,
    // rust: velocity,
    // rust: 30,
    // rust: false,
    // rust: damage,
    // rust: 19.75,
    // rust: [0.0, 0.0],
    // rust: [1, 2, 3, 4],
    // rust: );
    // rust: let (loaded_state, pos, motion, age, distance) = falling_block_from_nbt(&tag).unwrap();
    // rust: assert_eq!(loaded_state, state);
    // rust: assert_eq!(
    // rust: (pos, motion, age, distance),
    // rust: (position, velocity, 30, 19.75)
    // rust: );
    // rust: assert_eq!(falling_block_flags(&tag), (false, false));
    // rust: assert_eq!(crate::falling_block::Damage::from_nbt(&tag, true), damage);
    // rust: assert_eq!(uuid(&tag), Some([1, 2, 3, 4]));
}

loaded_item_lifetime_counters_tick_with_signed_sentinels :: proc() {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let registry = assets.registry;
    // rust: let facts = crate::blocks::BlockFacts::load(&root, registry).unwrap();
    // rust: let collision = crate::collisions::load(&root, registry).unwrap();
    // rust: let fluids = crate::motion::FluidResources::new(&assets, &facts).unwrap();
    // rust: let mut world =
    // rust: crate::world::World::new(registry.default_state("minecraft:air").unwrap(), 0);
    // rust: world
    // rust: .chunks
    // rust: .insert((0, 0), Arc::new(crate::chunk::Chunk::empty(0, 0)));
    // rust: let tick = |item: &mut ItemEntity| {
    // rust: item.tick(
    // rust: &world,
    // rust: registry,
    // rust: &facts,
    // rust: &collision,
    // rust: false,
    // rust: &fluids,
    // rust: &[],
    // rust: None,
    // rust: None,
    // rust: )
}
    // rust: let fresh = Tag::compound([
    // rust: ("id", string("minecraft:item")),
    // rust: ("Pos", doubles(&[4.5, 210.0, 4.5])),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: (
    // rust: "Item",
    // rust: Tag::compound([("id", string("minecraft:stone")), ("count", Tag::Int(1))]),
    // rust: ),
    // rust: ]);
    // rust: for delay in [32767_i16, -1, 0, 1, 2] {
    // rust: for age in [-32768_i16, -1, 0, 5998, 5999, 6000, 32767] {
    // rust: let mut item = item_entity_from_nbt(&fresh, 1, 0.0).unwrap();
    // rust: for _ in 0..3 {
    // rust: assert!(tick(&mut item));
}
    // rust: assert_eq!(item.age, 3);
    // rust: let mut data = item_entity_to_nbt(&item, [0, 0, 0, 1], None);
    // rust: put(&mut data, "Age", Tag::Short(age));
    // rust: put(&mut data, "PickupDelay", Tag::Short(delay));
    // rust: let mut item = item_entity_from_nbt(&data, 1, 0.0).unwrap();
    // rust: let mut alive = true;
    // rust: for step in 0..=3 {
    // rust: if step > 0 && alive {
    // rust: alive = tick(&mut item);
}
    // rust: let expected_age = if age == i16::MIN {
    // rust: i32::from(age)
    // rust: } else {
    // rust: i32::from(age) + step
}
    // rust: let expected_alive = step == 0 || expected_age < 6000;
    // rust: assert_eq!(
    // rust: alive, expected_alive,
    // rust: "age={age}, delay={delay}, tick={step}"
    // rust: );
    // rust: if !alive {
    // rust: continue;
}
    // rust: let data = item_entity_to_nbt(&item, [0, 0, 0, 1], None);
    // rust: let expected_delay = if delay > 0 && delay != i16::MAX {
    // rust: (i32::from(delay) - step).max(0)
    // rust: } else {
    // rust: i32::from(delay)
}
    // rust: assert_eq!(
    // rust: number(data.get("Age")),
    // rust: Some(i64::from(expected_age)),
    // rust: "age={age}, tick={step}"
    // rust: );
    // rust: assert_eq!(
    // rust: number(data.get("PickupDelay")),
    // rust: Some(i64::from(expected_delay)),
    // rust: "age={age}, delay={delay}, tick={step}"
    // rust: );
}
}
}
    // rust: let mut legacy = item_entity_from_nbt(&fresh, 1, 0.0).unwrap();
    // rust: legacy.pickup_delay = i64::from(u32::MAX);
    // rust: assert!(tick(&mut legacy));
    // rust: assert_eq!(legacy.pickup_delay, i64::from(u32::MAX));
}

item_entities_round_trip :: proc() {
}
    // rust: let e = ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: health: 2,
    // rust: fire_ticks: 73,
    // rust: thrower: Some([5, 6, 7, 8]),
    // rust: target: None,
    // rust: id: 7,
    // rust: stack: ItemStack {
    // rust: item: Arc::from("minecraft:diamond_pickaxe"),
    // rust: count: 1,
    // rust: damage: 5,
    // rust: extra: None,
    // rust: },
    // rust: position: Vec3::new(100.5, 64.0, -31.5),
    // rust: previous: Vec3::ZERO,
    // rust: velocity: Vec3::new(0.0, -0.04, 0.0),
    // rust: on_ground: true,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 120,
    // rust: pickup_delay: 10,
    // rust: ticks: 0,
    // rust: bob_offset: 0.0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
}
    // rust: let tag = item_entity_to_nbt(&e, [1, 2, 3, 4], None);
    // rust: assert_eq!(kind(&tag).as_deref(), Some("minecraft:item"));
    // rust: assert_eq!(uuid(&tag), Some([1, 2, 3, 4]));
    // rust: let back = item_entity_from_nbt(&tag, 9, 0.0).unwrap();
    // rust: assert_eq!(back.stack.damage, 5);
    // rust: assert_eq!((back.health, back.fire_ticks), (2, 73));
    // rust: assert_eq!(
    // rust: (back.age, back.pickup_delay, back.on_ground),
    // rust: (120, 10, true)
    // rust: );
    // rust: assert_eq!(back.position.x, 100.5);
    // rust: assert_eq!(back.thrower, e.thrower);
    // rust: let mut cleared = back;
    // rust: cleared.thrower = None;
    // rust: let cleared = item_entity_to_nbt(&cleared, [1, 2, 3, 4], Some(&tag));
    // rust: assert!(cleared.get("Thrower").is_none());
}
animal_nbt_preserves_signed_integer_in_love_and_defaults_after_removal :: proc() {
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let def = Arc::make_mut(&mut kind);
    // rust: def.id = "minecraft:pig".into();
    // rust: def.species = crate::mobs::Species::Pig;
    // rust: let types = [("minecraft:pig".into(), kind)].into();
    // rust: for (input, expected) in [
    // rust: (Tag::Int(-32769), -32769),
    // rust: (Tag::Int(-32768), -32768),
    // rust: (Tag::Int(-129), -129),
    // rust: (Tag::Int(-128), -128),
    // rust: (Tag::Int(-1), -1),
    // rust: (Tag::Byte(-1), -1),
    // rust: (Tag::Byte(-128), -128),
    // rust: (Tag::Int(0), 0),
    // rust: (Tag::Int(1), 1),
    // rust: (Tag::Int(37), 37),
    // rust: ] {
    // rust: let raw = Tag::compound([
    // rust: ("id", string("minecraft:pig")),
    // rust: ("Pos", doubles(&[4.0, 200.0, 4.0])),
    // rust: ("NoAI", Tag::Byte(1)),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: ("InLove", input),
    // rust: ]);
    // rust: let mob = mob_from_nbt(&raw, &types, 1, None).unwrap();
    // rust: assert_eq!(mob.extra.in_love, expected);
            // Query snapshots and saves both write the live field as an int,
            // regardless of whether there is an old compound to preserve.
    // rust: for old in [None, Some(&raw)] {
    // rust: let mut saved = mob_to_nbt(&mob, [0, 0, 0, 1], old, None);
    // rust: assert_eq!(saved.get("InLove"), Some(&Tag::Int(expected)));
    // rust: if let Tag::Compound(map) = &mut saved {
    // rust: map.remove(&"InLove".into());
}
    // rust: let cleared = mob_from_nbt(&saved, &types, 2, None).unwrap();
    // rust: assert_eq!(cleared.extra.in_love, 0);
    // rust: let saved = mob_to_nbt(&cleared, [0, 0, 0, 1], Some(&saved), None);
    // rust: assert_eq!(saved.get("InLove"), Some(&Tag::Int(0)));
}
}
}

unknown_fields_survive :: proc() {
}
    // rust: let raw = Tag::compound([
    // rust: ("id", string("minecraft:item")),
    // rust: ("CustomName", string("x")),
    // rust: ("Pos", doubles(&[0.5, 64.0, 0.5])),
    // rust: (
    // rust: "Item",
    // rust: Tag::compound([("id", string("minecraft:stone")), ("count", Tag::Int(3))]),
    // rust: ),
    // rust: ]);
    // rust: let e = item_entity_from_nbt(&raw, 1, 0.0).unwrap();
    // rust: let tag = item_entity_to_nbt(&e, [0; 4], Some(&raw));
    // rust: assert_eq!(text(tag.get("CustomName")).as_deref(), Some("x"));
    // rust: assert_eq!(number(tag.get("Health")), Some(5));
}
saved_rotation_is_the_entitys_own :: proc() {
}
        // `/tp <entity> x y z 90 10` sets the entity's yaw and pitch; the save
        // (`/data get ... Rotation`) writes them, not [0, 0].
    // rust: let tnt = tnt_to_nbt(
    // rust: Vec3::ZERO,
    // rust: Vec3::ZERO,
    // rust: false,
    // rust: 20,
    // rust: 4.0,
    // rust: string("minecraft:tnt"),
    // rust: [90.0, 10.0],
    // rust: [1; 4],
    // rust: None,
    // rust: );
    // rust: assert_eq!(rotation(&tnt), [90.0, 10.0]);
    // rust: let mut stand = ArmorStand::new(1, Vec3::ZERO, 0.0);
    // rust: stand.yaw = 90.0;
    // rust: stand.pitch = 10.0;
    // rust: assert_eq!(
    // rust: rotation(&armor_stand_to_nbt(&stand, [1; 4], None)),
    // rust: [90.0, 10.0]
    // rust: );
    // rust: let cart = vehicle_to_nbt(
    // rust: "minecraft:minecart",
    // rust: Vec3::ZERO,
    // rust: Vec3::ZERO,
    // rust: [90.0, 10.0],
    // rust: [1; 4],
    // rust: None,
    // rust: );
    // rust: assert_eq!(rotation(&cart), [90.0, 10.0]);
}

entities_without_fire_save_zero_and_a_mob_saves_its_speed_instance :: proc() {
}
        // Entity.remainingFireTicks starts at 0; LivingEntity.removeFrost makes
        // the movement_speed instance AttributeMap.pack then saves.
    // rust: let orb = ExperienceOrb {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: position: Vec3::ZERO,
    // rust: previous: Vec3::ZERO,
    // rust: velocity: Vec3::ZERO,
    // rust: value: 1,
    // rust: age: 0,
    // rust: on_ground: false,
    // rust: count: 1,
    // rust: ticks: 0,
    // rust: health: 5,
}
    // rust: let tag = orb_to_nbt(&orb, [0; 4]);
    // rust: assert_eq!(tag.get("Fire"), Some(&Tag::Short(0)));
        // A stand summoned this tick has no instance yet; its first tick makes
        // it, and a save that lists it (`/data merge`, a reload) keeps it.
    // rust: let attributes =
    // rust: |stand: &ArmorStand| match armor_stand_to_nbt(stand, [0; 4], None).get("attributes") {
    // rust: Some(Tag::List(attrs)) => attrs
    // rust: .iter()
    // rust: .map(|a| (text(a.get("id")).unwrap(), a.get("base").cloned()))
    // rust: .collect::<Vec<_>>(),
    // rust: other => panic!("attributes: {other:?}"),
}
    // rust: let mut stand = ArmorStand::new(1, Vec3::ZERO, 0.0);
    // rust: assert_eq!(attributes(&stand), []);
    // rust: stand.speed_instance = true;
    // rust: let speed = vec![(
    // rust: "minecraft:movement_speed".to_owned(),
    // rust: Some(Tag::Double(0.7f64.to_bits())),
    // rust: )];
    // rust: assert_eq!(attributes(&stand), speed);
    // rust: let saved = armor_stand_to_nbt(&stand, [0; 4], None);
    // rust: assert_eq!(attributes(&armor_stand_from_nbt(&saved, 1).unwrap()), speed);
}
ghast_and_trident_save_their_always_present_keys :: proc() {
}
    // rust: let trident = ItemStack::new("minecraft:trident", 1);
    // rust: let tag = trident_to_nbt(
    // rust: &TridentSave {
    // rust: position: Vec3::ZERO,
    // rust: motion: Vec3::ZERO,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: in_ground: false,
    // rust: life: 0,
    // rust: shake: 0,
    // rust: dealt_damage: false,
    // rust: creative_only: false,
    // rust: no_gravity: false,
    // rust: fire_ticks: 0,
    // rust: item: &trident,
    // rust: },
    // rust: [0; 4],
    // rust: None,
    // rust: );
    // rust: assert_eq!(tag.get("LeftOwner"), Some(&Tag::Byte(1)));
}
orbs_keep_their_count :: proc() {
}
    // rust: let o = ExperienceOrb {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: 0,
    // rust: position: Vec3::new(1.0, 2.0, 3.0),
    // rust: previous: Vec3::ZERO,
    // rust: velocity: Vec3::ZERO,
    // rust: value: 7,
    // rust: age: 3,
    // rust: on_ground: false,
    // rust: count: 3,
    // rust: ticks: 0,
    // rust: health: 5,
}
    // rust: let tag = orb_to_nbt(&o, [0; 4]);
    // rust: let back = orbs_from_nbt(&tag);
    // rust: assert_eq!(back.len(), 1);
    // rust: assert_eq!(back[0].value, 7);
    // rust: assert_eq!(back[0].count, 3);
}
}

// `Brain.Packed`: the guarded-block live ANGRY_AT entry. The existing
// anger counter supplies its remaining long TTL, not an absolute timestamp.
write_guarded_piglin_anger :: proc(m: ^Mob, map: ^Compound) {
}
    // rust: let Some(actor) = m.extra.piglin.guarded_angry_at else {
    // rust: return;
}
    // rust: let brain = map
    // rust: .entry("Brain".into())
    // rust: .or_insert_with(|| Tag::Compound(Compound::new()));
    // rust: if !matches!(brain, Tag::Compound(_)) {
    // rust: *brain = Tag::Compound(Compound::new());
}
    // rust: let Tag::Compound(brain) = brain else { return };
    // rust: let memories = brain
    // rust: .entry("memories".into())
    // rust: .or_insert_with(|| Tag::Compound(Compound::new()));
    // rust: if !matches!(memories, Tag::Compound(_)) {
    // rust: *memories = Tag::Compound(Compound::new());
}
    // rust: let Tag::Compound(memories) = memories else {
    // rust: return;
}
    // rust: if let Some(uuid) = actor.filter(|_| m.extra.anger > 0) {
        // ExpirableValue.codec: the UUID value and optional remaining Long TTL.
    // rust: memories.insert(
    // rust: "minecraft:angry_at".into(),
    // rust: Tag::compound([
    // rust: ("value", Tag::IntArray(uuid.to_vec())),
    // rust: ("ttl", Tag::Long(i64::from(m.extra.anger))),
    // rust: ]),
    // rust: );
    // rust: } else {
    // rust: memories.remove(&"minecraft:angry_at".into());
}
}

write_axolotl_memories :: proc(m: ^Mob, map: ^Compound) {
}
    // rust: let brain = map
    // rust: .entry("Brain".into())
    // rust: .or_insert_with(|| Tag::Compound(Compound::new()));
    // rust: if !matches!(brain, Tag::Compound(_)) {
    // rust: *brain = Tag::Compound(Compound::new());
}
    // rust: let Tag::Compound(brain) = brain else { return };
    // rust: let memories = brain
    // rust: .entry("memories".into())
    // rust: .or_insert_with(|| Tag::Compound(Compound::new()));
    // rust: if !matches!(memories, Tag::Compound(_)) {
    // rust: *memories = Tag::Compound(Compound::new());
}
    // rust: let Tag::Compound(memories) = memories else {
    // rust: return;
}
    // rust: let mm = m.extra.animal_brain.as_deref().map(|b| &b.mem);
    // rust: let hunting = mm.and_then(|mem| {
    // rust: let slot = &mem.hunting_cooldown;
    // rust: slot.value().map(|value| {
    // rust: let mut entry = Tag::compound([("value", Tag::Byte(i8::from(value)))]);
    // rust: if slot.ttl() != i64::MAX {
    // rust: put(&mut entry, "ttl", Tag::Long(slot.ttl()));
}
    // rust: entry
    // rust: })
    // rust: });
    // ExpirableValue.codec: integer value and optional finite long TTL.
    // rust: let integer_memory = |slot: &crate::mobs::animal_brain::Slot<i32>| {
    // rust: slot.value().map(|v| {
    // rust: let mut entry = Tag::compound([("value", Tag::Int(v))]);
    // rust: if slot.ttl() != i64::MAX {
    // rust: put(&mut entry, "ttl", Tag::Long(slot.ttl()));
}
    // rust: entry
    // rust: })
}
    // rust: let play_dead = mm.and_then(|m| integer_memory(&m.play_dead_ticks));
    // rust: let temptation = mm.and_then(|m| integer_memory(&m.temptation_cooldown_ticks));
    // rust: for (key, value) in [
    // rust: ("minecraft:has_hunting_cooldown", hunting),
    // rust: ("minecraft:play_dead_ticks", play_dead),
    // rust: ("minecraft:temptation_cooldown_ticks", temptation),
    // rust: ] {
    // rust: if let Some(value) = value {
    // rust: memories.insert(key.into(), value);
    // rust: } else {
    // rust: memories.remove(&key.into());
}
}
}
// Saved variants and fish/axolotl bucket flags. Missing variants use a
// medium salmon or index 0; a missing bucket flag is false.
read_variant :: proc(m: ^Mob, tag: ^Tag) {
}
//     use crate::mobs::Species as S;
    // AbstractFish/Axolotl.readAdditionalSaveData: false when absent.
    // Tadpole.setFromBucket ignores the input.
    // rust: if matches!(
    // rust: m.species(),
    // rust: S::Cod | S::Salmon | S::Pufferfish | S::TropicalFish | S::Axolotl
    // rust: ) {
    // rust: m.extra.from_bucket = flag(tag, "FromBucket");
}
    // rust: let int = |key| number(tag.get(key)).unwrap_or(0) as i32;
    // rust: match m.species() {
    // rust: S::Axolotl | S::Parrot => m.extra.variant = int("Variant").clamp(0, 4) as u8,
        // Rabbit.Variant.LEGACY_CODEC: an unknown id is brown.
    // rust: S::Rabbit => {
    // rust: m.extra.variant = match int("RabbitType") {
    // rust: v @ (0..=5 | 99) => v as u8,
    // rust: _ => 0,
}
}
    // rust: S::Salmon => {
    // rust: m.extra.variant = text(tag.get("type"))
    // rust: .and_then(|t| SALMON_SIZES.iter().position(|v| *v == t))
    // rust: .unwrap_or(1) as u8;
}
    // rust: S::TropicalFish => {
    // rust: let packed = int("Variant");
    // rust: let (size, index) = (packed & 0xFF, (packed >> 8) & 0xFF);
            // TropicalFish.Pattern.byId: an unknown id is a kob.
    // rust: m.extra.variant = if size <= 1 && index < 6 {
    // rust: (size * 6 + index) as u8
    // rust: } else {
    // rust: 0
}
            // TropicalFish.getBaseColor/getPatternColor use DyeColor.byId:
            // read the full byte, then default invalid color ids to white.
    // rust: let color = |shift| match (packed >> shift) & 0xFF {
    // rust: value @ 0..=15 => value as u8,
    // rust: _ => 0,
}
    // rust: m.extra.variant2 = color(16);
    // rust: m.extra.variant3 = color(24);
}
    // rust: _ => {}
}
}
restore_axolotl_memories :: proc(m: ^Mob, tag: ^Tag) {
}
    // rust: let memories = tag.get("Brain").and_then(|b| b.get("memories"));
    // Initialize/clear the slot without applying the runtime setter's positive-TTL rule to saved data.
    // rust: crate::mobs::animal_brain::set_hunting_cooldown(m, 0);
    // rust: if let Some(b) = m.extra.animal_brain.as_mut() {
    // rust: if let Some(entry) = memories.and_then(|v| v.get("minecraft:has_hunting_cooldown"))
    // rust: && let Some(value) = float(entry.get("value"))
    // rust: {
            // NbtOps boolean numbers use doubleValue()!=0; ExpirableValue's optional TTL is lenient.
    // rust: let ttl = number(entry.get("ttl")).unwrap_or(i64::MAX);
    // rust: b.mem.hunting_cooldown.set_ttl(value != 0.0, ttl);
}
    // rust: for (key, slot) in [
    // rust: ("minecraft:play_dead_ticks", &mut b.mem.play_dead_ticks),
    // rust: (
    // rust: "minecraft:temptation_cooldown_ticks",
    // rust: &mut b.mem.temptation_cooldown_ticks,
    // rust: ),
    // rust: ] {
    // rust: if let Some(entry) = memories.and_then(|b| b.get(key))
    // rust: && let Some(value) = number(entry.get("value"))
    // rust: {
                // ExpirableValue.codec's lenient optional TTL defaults to permanent.
    // rust: slot.set_ttl(value as i32, number(entry.get("ttl")).unwrap_or(i64::MAX));
}
}
}
}
AXOLOTL_VARIANTS :: ["lucy", "wild", "gold", "cyan", "blue"]
// `Salmon.Variant` names, by id.
SALMON_SIZES :: ["small", "medium", "large"]
// `TropicalFish.Pattern` names in enum order: the six small patterns, then
// the six large ones (the order of `extra.variant`).
    // rust: const TROPICAL_PATTERNS: [&str; 12] = [
    // rust: "kob",
    // rust: "sunstreak",
    // rust: "snooper",
    // rust: "dasher",
    // rust: "brinely",
    // rust: "spotty",
    // rust: "flopper",
    // rust: "stripey",
    // rust: "glitter",
    // rust: "blockfish",
    // rust: "betty",
    // rust: "clayfish",
    // rust: ];
// `Bucketable.saveDefaultDataToBucketTag`, with the age an axolotl and a
// tadpole add (`saveToBucketTag`).
bucket_data :: proc(m: ^Mob) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut data = Tag::compound([("Health", Tag::Float(m.health.to_bits()))]);
    // rust: if matches!(
    // rust: m.species(),
    // rust: crate::mobs::Species::Axolotl | crate::mobs::Species::Tadpole
    // rust: ) {
    // rust: put(&mut data, "Age", Tag::Int(m.extra.age));
    // rust: put(
    // rust: &mut data,
    // rust: "AgeLocked",
    // rust: Tag::Byte(i8::from(m.extra.age_locked)),
    // rust: );
}
    // rust: for (key, on) in [
    // rust: ("NoAI", m.no_ai),
    // rust: ("Silent", m.silent),
    // rust: ("NoGravity", m.no_gravity),
    // rust: ("Glowing", m.glowing),
    // rust: ("Invulnerable", m.invulnerable_flag),
    // rust: ("PersistenceRequired", m.persistent),
    // rust: ] {
    // rust: if on {
    // rust: put(&mut data, key, Tag::Byte(1));
}
}
    // rust: if let Some(ttl) = crate::mobs::animal_brain::hunting_cooldown(m) {
    // rust: put(&mut data, "HuntingCooldown", Tag::Long(ttl));
}
    // rust: data
}
bucket_components :: proc(m: ^Mob) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let mut data = crate::item_data::StackData {
    // rust: custom_name: m
    // rust: .custom_name
    // rust: .as_ref()
    // rust: .map(|name| Tag::String(name.as_str().into())),
    // rust: ..Default::default()
}
    // rust: data.set_other("minecraft:bucket_entity_data", Some(bucket_data(m)));
    // rust: if m.species() == crate::mobs::Species::Axolotl {
    // rust: let variant = AXOLOTL_VARIANTS
    // rust: .get(usize::from(m.extra.variant))
    // rust: .unwrap_or(&"lucy");
    // rust: data.set_other("minecraft:axolotl/variant", Some(string(variant)));
}
    // Salmon.saveToBucketTag: the size.
    // rust: if m.species() == crate::mobs::Species::Salmon {
    // rust: let size = SALMON_SIZES
    // rust: .get(usize::from(m.extra.variant))
    // rust: .unwrap_or(&"medium");
    // rust: data.set_other("minecraft:salmon/size", Some(string(size)));
}
    // TropicalFish.saveToBucketTag: the pattern and both colours.
    // rust: if m.species() == crate::mobs::Species::TropicalFish {
    // rust: let dye = |i: u8| crate::mobs::render::DYE_NAMES[usize::from(i) & 15];
    // rust: let pattern = TROPICAL_PATTERNS
    // rust: .get(usize::from(m.extra.variant))
    // rust: .unwrap_or(&"kob");
    // rust: data.set_other("minecraft:tropical_fish/pattern", Some(string(pattern)));
    // rust: data.set_other(
    // rust: "minecraft:tropical_fish/base_color",
    // rust: Some(string(dye(m.extra.variant2))),
    // rust: );
    // rust: data.set_other(
    // rust: "minecraft:tropical_fish/pattern_color",
    // rust: Some(string(dye(m.extra.variant3))),
    // rust: );
}
    // rust: data
}
// `Entity.applyComponentsFromItemStack` → the spawned mob's
// `applyImplicitComponents`: a bucket's contents (`MobBucketItem.spawn`) and
// a spawn egg (`PostSpawnProcessor.apply`) both land here. Vanilla applies
// these after `finalizeSpawn`, so a component wins over the biome variant.
apply_item_components :: proc(m: ^Mob, stack: ^crate::items::ItemStack) {
}
    // rust: let Some(components) = stack.data() else {
    // rust: return;
}
    // rust: if let Some(name) = stack.custom_name() {
    // rust: m.custom_name = Some(name);
}
    // rust: if let Some(data) = components.other("minecraft:bucket_entity_data") {
    // rust: if let Some(v) = number(data.get("Age")) {
    // rust: m.extra.age = v as i32;
}
    // rust: if let Some(v) = number(data.get("AgeLocked")) {
    // rust: m.extra.age_locked = v != 0;
}
        // Keep old Horizon buckets readable; the modern component below takes precedence.
    // rust: if let Some(v) = number(data.get("Variant")) {
    // rust: m.extra.variant = v as u8;
}
    // rust: if let Some(v) = float(data.get("Health")) {
    // rust: m.health = v as f32;
}
    // rust: for (key, flag) in [
    // rust: ("NoAI", &mut m.no_ai),
    // rust: ("Silent", &mut m.silent),
    // rust: ("NoGravity", &mut m.no_gravity),
    // rust: ("Glowing", &mut m.glowing),
    // rust: ("Invulnerable", &mut m.invulnerable_flag),
    // rust: ] {
    // rust: if let Some(v) = number(data.get(key)) {
    // rust: *flag = v != 0;
}
}
    // rust: m.persistent |= flag(data, "PersistenceRequired");
    // rust: if m.species() == crate::mobs::Species::Axolotl {
    // rust: crate::mobs::animal_brain::set_hunting_cooldown(
    // rust: m,
    // rust: number(data.get("HuntingCooldown")).unwrap_or(0),
    // rust: );
}
}
    // rust: if m.species() == crate::mobs::Species::Axolotl
    // rust: && let Some(name) = text(components.other("minecraft:axolotl/variant"))
    // rust: && let Some(id) = AXOLOTL_VARIANTS
    // rust: .iter()
    // rust: .position(|&v| v == name.trim_start_matches("minecraft:"))
    // rust: {
    // rust: m.extra.variant = id as u8;
}
    // Salmon.applyImplicitComponents: the size.
    // rust: if m.species() == crate::mobs::Species::Salmon
    // rust: && let Some(name) = text(components.other("minecraft:salmon/size"))
    // rust: && let Some(id) = SALMON_SIZES
    // rust: .iter()
    // rust: .position(|&v| v == name.trim_start_matches("minecraft:"))
    // rust: {
    // rust: m.extra.variant = id as u8;
}
    // TropicalFish.applyImplicitComponent: the pattern and both colours.
    // rust: if m.species() == crate::mobs::Species::TropicalFish {
    // rust: let name = |key| text(components.other(key));
    // rust: let dye = |key| {
    // rust: name(key).and_then(|n| {
    // rust: crate::mobs::render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|&v| v == n.trim_start_matches("minecraft:"))
    // rust: })
}
    // rust: if let Some(id) = name("minecraft:tropical_fish/pattern").and_then(|n| {
    // rust: TROPICAL_PATTERNS
    // rust: .iter()
    // rust: .position(|&v| v == n.trim_start_matches("minecraft:"))
    // rust: }) {
    // rust: m.extra.variant = id as u8;
}
    // rust: if let Some(id) = dye("minecraft:tropical_fish/base_color") {
    // rust: m.extra.variant2 = id as u8;
}
    // rust: if let Some(id) = dye("minecraft:tropical_fish/pattern_color") {
    // rust: m.extra.variant3 = id as u8;
}
}
    // Chicken, Cow and Pig.applyImplicitComponents: their variant and sound
    // variant components, both registry names (`minecraft:warm`,
    // `minecraft:picky`).
    // rust: let species = m.species();
    // rust: let (variant, sound) = match species {
    // rust: crate::mobs::Species::Chicken => (
    // rust: Some("minecraft:chicken/variant"),
    // rust: Some("minecraft:chicken/sound_variant"),
    // rust: ),
    // rust: crate::mobs::Species::Cow => (
    // rust: Some("minecraft:cow/variant"),
    // rust: Some("minecraft:cow/sound_variant"),
    // rust: ),
    // rust: crate::mobs::Species::Pig => (
    // rust: Some("minecraft:pig/variant"),
    // rust: Some("minecraft:pig/sound_variant"),
    // rust: ),
        // ZombieNautilus.applyImplicitComponents: the variant only.
    // rust: crate::mobs::Species::ZombieNautilus => (Some("minecraft:zombie_nautilus/variant"), None),
        // Fox and Frog.applyImplicitComponent: `setVariant` from the component
        // alone, so a spawn egg carrying one hatches that variant.
    // rust: crate::mobs::Species::Fox => (Some("minecraft:fox/variant"), None),
    // rust: crate::mobs::Species::Frog => (Some("minecraft:frog/variant"), None),
        // Horse.applyImplicitComponent: `setVariant` sets the coat colour and
        // keeps the markings the spawn picked (`getTypeVariant() & -256`),
        // which Horizon keeps in `extra.variant2` and leaves alone here.
    // rust: crate::mobs::Species::Horse => (Some("minecraft:horse/variant"), None),
        // Llama.applyImplicitComponent, which a trader llama inherits.
    // rust: crate::mobs::Species::Llama | crate::mobs::Species::TraderLlama => {
    // rust: (Some("minecraft:llama/variant"), None)
}
    // rust: _ => (None, None),
}
    // rust: if let Some(name) = variant.and_then(|id| text(components.other(id))) {
    // rust: m.extra.variant = crate::mobs::finalize::variant_index(species, &name);
}
    // rust: if let Some(name) = sound.and_then(|id| text(components.other(id)))
    // rust: && let Some(i) = crate::mobs::finalize::sound_variants(species)
    // rust: .iter()
    // rust: .position(|v| *v == name.trim_start_matches("minecraft:"))
    // rust: {
    // rust: m.extra.sound_variant = Some(i as u8);
}
    // MushroomCow.applyImplicitComponents: `Variant.DEFAULT` is red, as the
    // save's `Type` reads it.
    // rust: if species == crate::mobs::Species::Mooshroom
    // rust: && let Some(name) = text(components.other("minecraft:mooshroom/variant"))
    // rust: {
    // rust: m.extra.variant = u8::from(name.trim_start_matches("minecraft:") == "brown");
}
    // Sheep.applyImplicitComponents: the wool colour, a DyeColor id.
    // rust: if species == crate::mobs::Species::Sheep
    // rust: && let Some(name) = text(components.other("minecraft:sheep/color"))
    // rust: && let Some(i) = crate::mobs::render::DYE_NAMES
    // rust: .iter()
    // rust: .position(|c| *c == name.trim_start_matches("minecraft:"))
    // rust: {
    // rust: m.extra.color = i as u8;
}
}

    // rust: mod axolotl_nbt_tests {
//     use super::*;
axolotl_boolean_memory_preserves_values_and_saved_lifetimes :: proc() {
}
    // rust: let key = "minecraft:has_hunting_cooldown";
    // rust: for (value, expected) in [
    // rust: (Some(Tag::Byte(0)), Some(false)),
    // rust: (Some(Tag::Byte(1)), Some(true)),
    // rust: (Some(Tag::Int(256)), Some(true)),
    // rust: (Some(Tag::Float(0.5f32.to_bits())), Some(true)),
    // rust: (Some(Tag::Double((-0.5f64).to_bits())), Some(true)),
    // rust: (Some(string("true")), None),
    // rust: (Some(Tag::Compound(Compound::new())), None),
    // rust: (None, None),
    // rust: ] {
    // rust: for ttl in [None, Some(3), Some(0), Some(-1), Some(i64::MAX)] {
    // rust: let mut entry = Tag::Compound(Compound::new());
    // rust: if let Some(value) = &value {
    // rust: put(&mut entry, "value", value.clone());
}
    // rust: if let Some(ttl) = ttl {
    // rust: put(&mut entry, "ttl", Tag::Long(ttl));
}
    // rust: let raw = Tag::compound([(
    // rust: "Brain",
    // rust: Tag::compound([("memories", Tag::compound([(key, entry)]))]),
    // rust: )]);
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.id = "minecraft:axolotl".into();
    // rust: ty.species = crate::mobs::Species::Axolotl;
    // rust: let mut mob = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: restore_axolotl_memories(&mut mob, &raw);
    // rust: let saved = mob_to_nbt(&mob, [0; 4], Some(&raw), None);
    // rust: let entry = saved
    // rust: .get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|m| m.get(key));
    // rust: match expected {
    // rust: Some(value) => {
    // rust: let entry = entry.expect("false and nonpositive lifetimes remain present");
    // rust: assert_eq!(entry.get("value"), Some(&Tag::Byte(i8::from(value))));
    // rust: let expected_ttl = ttl.filter(|v| *v != i64::MAX).map(Tag::Long);
    // rust: assert_eq!(entry.get("ttl"), expected_ttl.as_ref());
}
    // rust: None => assert!(entry.is_none(), "invalid/missing boolean must be dropped"),
}
}
}
}
aquatic_from_bucket_saves_defaults_and_tadpole_constant :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let types: HashMap<_, _> = crate::mobs::MobTypes::load(&root)
    // rust: .unwrap()
    // rust: .types
    // rust: .into_iter()
    // rust: .map(|(id, kind)| (id, Arc::new(kind)))
    // rust: .collect();
    // rust: for kind in [
    // rust: "cod",
    // rust: "salmon",
    // rust: "pufferfish",
    // rust: "tropical_fish",
    // rust: "axolotl",
    // rust: "tadpole",
    // rust: ] {
    // rust: for value in [None, Some(false), Some(true)] {
    // rust: let mut input = Tag::compound([
    // rust: ("id", string(&format!("minecraft:{kind}"))),
    // rust: ("Pos", doubles(&[10.5, 220.0, 10.5])),
    // rust: ]);
    // rust: if let (Some(value), Tag::Compound(map)) = (value, &mut input) {
    // rust: map.insert("FromBucket".into(), Tag::Byte(i8::from(value)));
}
    // rust: let m = mob_from_nbt(&input, &types, 1, None).unwrap();
    // rust: let expected = kind == "tadpole" || value.unwrap_or(false);
    // rust: for raw in [None, Some(&input)] {
    // rust: let saved = mob_to_nbt(&m, [1; 4], raw, None);
    // rust: assert_eq!(
    // rust: saved.get("FromBucket"),
    // rust: Some(&Tag::Byte(i8::from(expected))),
    // rust: "{kind}, input={value:?}, raw={}",
    // rust: raw.is_some()
    // rust: );
}
}
}
    // rust: let pig = Mob::new(1, types["minecraft:pig"].clone(), Vec3::ZERO, 0.0);
    // rust: assert!(
    // rust: mob_to_nbt(&pig, [1; 4], None, None)
    // rust: .get("FromBucket")
    // rust: .is_none()
    // rust: );
}

bucket_cooldown_and_brain_memories_survive_and_expired_cooldown_is_removed :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let kind = Arc::new(data.types.get("minecraft:axolotl").unwrap().clone());
    // rust: let mut m = Mob::new(1, kind.clone(), Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: crate::mobs::animal_brain::set_hunting_cooldown(&mut m, 123);
    // rust: m.extra.variant = 4;
    // rust: m.extra.age = -24000;
    // rust: m.extra.age_locked = true;
    // rust: m.no_ai = true;
    // rust: m.silent = true;
    // rust: m.no_gravity = true;
    // rust: m.glowing = true;
    // rust: m.invulnerable_flag = true;
    // rust: m.persistent = true;
    // rust: m.custom_name = Some("Bucket friend".into());
    // rust: m.health = 5.0;

    // rust: {
    // rust: let mm = &mut m.extra.animal_brain.as_mut().unwrap().mem;
    // rust: mm.play_dead_ticks.set(78);
    // rust: mm.temptation_cooldown_ticks.set(42);
}
    // rust: let raw = Tag::compound([(
    // rust: "Brain",
    // rust: Tag::compound([(
    // rust: "memories",
    // rust: Tag::compound([("test:unrelated", Tag::compound([("value", Tag::Int(9))]))]),
    // rust: )]),
    // rust: )]);
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], Some(&raw), None);
    // rust: let memories = tag.get("Brain").unwrap().get("memories").unwrap();
    // rust: assert!(memories.get("test:unrelated").is_some());
    // rust: assert_eq!(
    // rust: number(
    // rust: memories
    // rust: .get("minecraft:play_dead_ticks")
    // rust: .unwrap()
    // rust: .get("value")
    // rust: ),
    // rust: Some(78)
    // rust: );
    // rust: assert_eq!(
    // rust: number(
    // rust: memories
    // rust: .get("minecraft:temptation_cooldown_ticks")
    // rust: .unwrap()
    // rust: .get("value")
    // rust: ),
    // rust: Some(42)
    // rust: );
    // rust: let mut stack = crate::items::ItemStack::new("minecraft:axolotl_bucket", 1);
    // rust: stack.extra = Some(Box::new(bucket_components(&m)));
    // rust: assert_eq!(
    // rust: text(stack.data().unwrap().other("minecraft:axolotl/variant")),
    // rust: Some("blue".into())
    // rust: );
    // rust: assert!(bucket_data(&m).get("Variant").is_none());
    // rust: let stack = item_from_nbt(&item_to_nbt(&stack)).unwrap();
    // rust: let mut restored = Mob::new(2, kind, Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: apply_item_components(&mut restored, &stack);
    // rust: assert_eq!(
    // rust: crate::mobs::animal_brain::hunting_cooldown(&restored),
    // rust: Some(123)
    // rust: );
    // rust: assert_eq!(
    // rust: (
    // rust: restored.extra.variant,
    // rust: restored.extra.age,
    // rust: restored.extra.age_locked
    // rust: ),
    // rust: (4, -24000, true)
    // rust: );
    // rust: assert!(
    // rust: restored.no_ai
    // rust: && restored.silent
    // rust: && restored.no_gravity
    // rust: && restored.glowing
    // rust: && restored.invulnerable_flag
    // rust: && restored.persistent
    // rust: );
    // rust: assert_eq!(restored.custom_name.as_deref(), Some("Bucket friend"));
    // rust: assert_eq!(restored.health, 5.0);
    // rust: m.glowing = false;
    // rust: m.add_effect("glowing", 200, 0);
    // rust: assert!(m.has_effect("minecraft:glowing"));
    // rust: assert!(bucket_data(&m).get("Glowing").is_none());
    // rust: m.glowing = true;
    // rust: assert_eq!(number(bucket_data(&m).get("Glowing")), Some(1));
    // rust: for (persistent, expected) in [(None, false), (Some(0), false), (Some(1), true)] {
    // rust: let mut data = Tag::Compound(Compound::new());
    // rust: if let Some(value) = persistent {
    // rust: put(&mut data, "PersistenceRequired", Tag::Byte(value));
}
    // rust: let mut bucket = crate::items::ItemStack::new("minecraft:axolotl_bucket", 1);
    // rust: bucket
    // rust: .data_mut()
    // rust: .set_other("minecraft:bucket_entity_data", Some(data));
    // rust: restored.persistent = false;
    // rust: apply_item_components(&mut restored, &bucket);
    // rust: assert_eq!(restored.persistent, expected);
    // rust: restored.persistent = true;
    // rust: apply_item_components(&mut restored, &bucket);
    // rust: assert!(restored.persistent, "bucket data cannot clear persistence");
}
    // rust: restored.ticks_frozen = 140;
    // rust: restored.ignite_for_ticks(160);
    // rust: assert_eq!(restored.ticks_frozen, 0);
    // rust: restored.ticks_frozen = 140;
    // rust: restored.ignite_for_ticks(1);
    // rust: assert_eq!(
    // rust: restored.ticks_frozen, 0,
    // rust: "even an ignition that does not extend burning clears freeze"
    // rust: );
    // rust: for (id, name) in AXOLOTL_VARIANTS.iter().enumerate() {
    // rust: let mut vanilla = crate::items::ItemStack::new("minecraft:axolotl_bucket", 1);
    // rust: vanilla.extra = Some(Box::new(crate::item_data::StackData {
    // rust: other: vec![("minecraft:axolotl/variant".into(), string(name))],
    // rust: ..Default::default()
    // rust: }));
    // rust: apply_item_components(&mut restored, &vanilla);
    // rust: assert_eq!(
    // rust: usize::from(restored.extra.variant),
    // rust: id,
    // rust: "component-only vanilla buckets work"
    // rust: );
}
    // rust: let mut legacy = crate::items::ItemStack::new("minecraft:axolotl_bucket", 1);
    // rust: legacy.extra = Some(Box::new(crate::item_data::StackData {
    // rust: other: vec![(
    // rust: "minecraft:bucket_entity_data".into(),
    // rust: Tag::compound([("Variant", Tag::Int(3))]),
    // rust: )],
    // rust: ..Default::default()
    // rust: }));
    // rust: apply_item_components(&mut restored, &legacy);
    // rust: assert_eq!(restored.extra.variant, 3);
    // rust: legacy
    // rust: .data_mut()
    // rust: .set_other("minecraft:axolotl/variant", Some(string("gold")));
    // rust: apply_item_components(&mut restored, &legacy);
    // rust: assert_eq!(
    // rust: restored.extra.variant, 2,
    // rust: "component wins over old Horizon data"
    // rust: );

    // rust: crate::mobs::animal_brain::set_hunting_cooldown(&mut m, 0);
    // rust: assert!(bucket_data(&m).get("HuntingCooldown").is_none());
    // rust: let saved = mob_to_nbt(&m, [1, 2, 3, 4], Some(&tag), None);
    // rust: assert!(
    // rust: saved
    // rust: .get("Brain")
    // rust: .unwrap()
    // rust: .get("memories")
    // rust: .unwrap()
    // rust: .get("minecraft:has_hunting_cooldown")
    // rust: .is_none()
    // rust: );
    // rust: restore_axolotl_memories(&mut restored, &saved);
    // rust: let mm = &restored.extra.animal_brain.as_ref().unwrap().mem;
    // rust: assert_eq!(mm.play_dead_ticks.value(), Some(78));
    // rust: assert_eq!(mm.temptation_cooldown_ticks.value(), Some(42));
}
}

    // rust: mod sheep_nbt_tests {
//     use super::*;
a_sheep_keeps_its_dyed_and_sheared_wool :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(data.types["minecraft:sheep"].clone()),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
        // Summoned white, then dyed red and sheared: the save has it now.
    // rust: let raw = Tag::compound([("Color", Tag::Byte(0)), ("Sheared", Tag::Byte(0))]);
    // rust: (m.extra.color, m.extra.sheared) = (14, true);
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], Some(&raw), None);
    // rust: assert_eq!(
    // rust: (number(tag.get("Color")), number(tag.get("Sheared"))),
    // rust: (Some(14), Some(1))
    // rust: );
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!((back.extra.color, back.extra.sheared), (14, true));
}

    // `Hoglin.readAdditionalSaveData` and `addAdditionalSaveData`:
    // `CannotBeHunted` (a bastion's hoglins) stays with the hoglin and is always
    // written, and such a hoglin is no piglin's prey (`Hoglin.canBeHunted`).
a_hoglin_keeps_cannot_be_hunted_and_is_no_prey :: proc() {
}
//         use crate::mobs::Species;
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.species = Species::Hoglin;
    // rust: ty.id = "minecraft:hoglin".into();
    // rust: let types = HashMap::from([("minecraft:hoglin".to_owned(), kind)]);
    // rust: let hoglin = |cannot: Option<i8>| {
    // rust: let mut tag = Tag::compound([
    // rust: ("id", string("minecraft:hoglin")),
    // rust: ("Pos", doubles(&[0.0, 64.0, 0.0])),
    // rust: ]);
    // rust: if let (Some(b), Tag::Compound(map)) = (cannot, &mut tag) {
    // rust: map.insert("CannotBeHunted".into(), Tag::Byte(b));
}
    // rust: tag
}
    // rust: let raw = hoglin(Some(1));
    // rust: let protected = mob_from_nbt(&raw, &types, 1, None).unwrap();
    // rust: assert!(protected.extra.cannot_be_hunted);
    // rust: assert!(!protected.seen(None).huntable);
    // rust: let saved = mob_to_nbt(&protected, [0; 4], Some(&raw), None);
    // rust: assert_eq!(saved.get("CannotBeHunted"), Some(&Tag::Byte(1)));
    // rust: for raw in [hoglin(None), hoglin(Some(0))] {
    // rust: let prey = mob_from_nbt(&raw, &types, 2, None).unwrap();
    // rust: assert!(!prey.extra.cannot_be_hunted);
    // rust: assert!(prey.seen(None).huntable);
    // rust: let saved = mob_to_nbt(&prey, [0; 4], Some(&raw), None);
    // rust: assert_eq!(saved.get("CannotBeHunted"), Some(&Tag::Byte(0)));
}
}

    // `Mob.addAdditionalSaveData` and `readAdditionalSaveData`:
    // `DeathLootTable` and a set `DeathLootTableSeed` stay with the mob.
a_death_loot_table_round_trips :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let summoned = Tag::compound([
    // rust: ("id", string("minecraft:zombie")),
    // rust: ("Pos", doubles(&[0.0, 64.0, 0.0])),
    // rust: ("DeathLootTable", string("mymod:entities/boss")),
    // rust: ("DeathLootTableSeed", Tag::Long(42)),
    // rust: ]);
    // rust: let m = mob_from_nbt(&summoned, &types, 2, None).unwrap();
    // rust: assert_eq!(
    // rust: m.extra.death_loot_table.as_deref(),
    // rust: Some("mymod:entities/boss")
    // rust: );
    // rust: assert_eq!(m.extra.death_loot_seed, 42);
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(
    // rust: text(tag.get("DeathLootTable")).as_deref(),
    // rust: Some("mymod:entities/boss")
    // rust: );
    // rust: assert_eq!(number(tag.get("DeathLootTableSeed")), Some(42));
        // None set: neither is written.
    // rust: let plain = Tag::compound([
    // rust: ("id", string("minecraft:zombie")),
    // rust: ("Pos", doubles(&[0.0, 64.0, 0.0])),
    // rust: ]);
    // rust: let plain = mob_from_nbt(&plain, &types, 3, None).unwrap();
    // rust: let tag = mob_to_nbt(&plain, [1, 2, 3, 4], None, None);
    // rust: assert!(tag.get("DeathLootTable").is_none() && tag.get("DeathLootTableSeed").is_none());
}

    // `Rabbit.addAdditionalSaveData` and `readAdditionalSaveData`: `MoreCarrotTicks`.
a_rabbit_keeps_how_full_of_carrots_it_is :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(data.types["minecraft:rabbit"].clone()),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: m.extra.more_carrot_ticks = 33;
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(number(tag.get("MoreCarrotTicks")), Some(33));
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(back.extra.more_carrot_ticks, 33);
}

    // `Ocelot.addAdditionalSaveData` and `readAdditionalSaveData`: `Trusting`.
an_ocelot_keeps_its_trust :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(data.types["minecraft:ocelot"].clone()),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(number(tag.get("Trusting")), Some(0));
    // rust: m.extra.trusting = true;
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(number(tag.get("Trusting")), Some(1));
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert!(back.extra.trusting);
}

    // `Mannequin.addAdditionalSaveData` and `readAdditionalSaveData`: `immovable`, and the
    // description (the default is not written, `hide_description` hides it, a component stays).
a_mannequin_keeps_its_immovable_flag_and_description :: proc() {
}
//         use crate::mobs::MannequinDescription as D;
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(data.types["minecraft:mannequin"].clone()),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: let save = |m: &Mob| mob_to_nbt(m, [1, 2, 3, 4], None, None);
        // The default description is not written; it comes back.
    // rust: let tag = save(&m);
    // rust: assert!(tag.get("description").is_none() && tag.get("hide_description").is_none());
    // rust: assert_eq!(number(tag.get("immovable")), Some(0));
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(
    // rust: (back.extra.immovable, back.extra.description),
    // rust: (false, D::Default)
    // rust: );
        // Hidden, and immovable.
    // rust: m.extra.immovable = true;
    // rust: m.extra.description = D::Hidden;
    // rust: let tag = save(&m);
    // rust: assert_eq!(number(tag.get("hide_description")), Some(1));
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(
    // rust: (back.extra.immovable, back.extra.description),
    // rust: (true, D::Hidden)
    // rust: );
        // A component of the world's own.
    // rust: let own = Tag::compound([("text", string("Guard")), ("color", string("red"))]);
    // rust: m.extra.description = D::Custom(own.clone());
    // rust: let tag = save(&m);
    // rust: assert_eq!(tag.get("description"), Some(&own));
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(back.extra.description, D::Custom(own));
}

    // The only lib test that registers mod effects (once per process).
a_mob_keeps_a_mod_effect :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let types: HashMap<String, Arc<MobType>> = crate::mobs::MobTypes::load(&root)
    // rust: .unwrap()
    // rust: .types
    // rust: .into_iter()
    // rust: .map(|(k, v)| (k, Arc::new(v)))
    // rust: .collect();
    // rust: crate::brewing::register_mod_effects([(
    // rust: "testfx:glow".to_owned(),
    // rust: 1,
    // rust: crate::brewing::Category::Harmful,
    // rust: )]);
    // rust: let mut m = Mob::new(1, types["minecraft:pig"].clone(), Vec3::ZERO, 0.0);
    // rust: m.add_effect(crate::brewing::effect("testfx:glow").unwrap().id, 200, 2);
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: let Some(Tag::List(saved)) = tag.get("active_effects") else {
    // rust: panic!("no active_effects");
}
    // rust: assert_eq!(text(saved[0].get("id")).as_deref(), Some("testfx:glow"));
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(back.extra.effects, [("testfx:glow", 200, 2)]);
}

an_amplifier_of_zero_is_left_out_of_active_effects :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let types: HashMap<String, Arc<MobType>> = crate::mobs::MobTypes::load(&root)
    // rust: .unwrap()
    // rust: .types
    // rust: .into_iter()
    // rust: .map(|(k, v)| (k, Arc::new(v)))
    // rust: .collect();
    // rust: let mut m = Mob::new(1, types["minecraft:pig"].clone(), Vec3::ZERO, 0.0);
    // rust: let speed = crate::brewing::effect("minecraft:speed").unwrap().id;
    // rust: m.add_effect(speed, 200, 0);
    // rust: m.add_effect(
    // rust: crate::brewing::effect("minecraft:slowness").unwrap().id,
    // rust: 200,
    // rust: 2,
    // rust: );
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: let Some(Tag::List(saved)) = tag.get("active_effects") else {
    // rust: panic!("no active_effects");
}
    // rust: assert!(saved[0].get("amplifier").is_none());
    // rust: assert!(saved[1].get("amplifier").is_some());
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(back.extra.effects[0].2, 0);
    // rust: assert_eq!(back.extra.effects[1].2, 2);
}

farm_animals_keep_their_variant_and_sound_variant :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: types["minecraft:pig"].clone(),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(
    // rust: text(tag.get("variant")).as_deref(),
    // rust: Some("minecraft:temperate")
    // rust: );
    // rust: assert_eq!(
    // rust: text(tag.get("sound_variant")).as_deref(),
    // rust: Some("minecraft:classic")
    // rust: );
        // Spawned in a warm biome with the mini sounds.
    // rust: (m.extra.variant, m.extra.sound_variant) = (1, Some(2));
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(text(tag.get("variant")).as_deref(), Some("minecraft:warm"));
    // rust: assert_eq!(
    // rust: text(tag.get("sound_variant")).as_deref(),
    // rust: Some("minecraft:mini")
    // rust: );
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!((back.extra.variant, back.extra.sound_variant), (1, Some(2)));
    // rust: let mut hen = Mob::new(
    // rust: 3,
    // rust: types["minecraft:chicken"].clone(),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: (hen.extra.variant, hen.extra.egg_time) = (2, 7795);
    // rust: let tag = mob_to_nbt(&hen, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(text(tag.get("variant")).as_deref(), Some("minecraft:cold"));
    // rust: let back = mob_from_nbt(&tag, &types, 4, None).unwrap();
    // rust: assert_eq!((back.extra.variant, back.extra.egg_time), (2, 7795));
        // The sound variants are indices into the registries finalizeSpawn draws from.
//         use crate::mobs::{Species, finalize};
    // rust: let registries = finalize::SpawnRegistries::load(&root);
    // rust: for (species, registry) in [
    // rust: (Species::Pig, &registries.pig_sound),
    // rust: (Species::Cow, &registries.cow_sound),
    // rust: (Species::Chicken, &registries.chicken_sound),
    // rust: (Species::Cat, &registries.cat_sound),
    // rust: (Species::Wolf, &registries.wolf_sound),
    // rust: ] {
    // rust: assert_eq!(
    // rust: finalize::sound_variants(species),
    // rust: registry.names,
    // rust: "{species:?}"
    // rust: );
}
}

parrots_omit_raw_age_and_pigs_keep_modeled_age :: proc() {
}
//         use crate::mobs::Species;
    // rust: for species in [Species::Parrot, Species::Pig] {
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.species = species;
    // rust: ty.id = if species == Species::Parrot {
    // rust: "minecraft:parrot"
    // rust: } else {
    // rust: "minecraft:pig"
}
    // rust: .into();
    // rust: let mut mob = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: let expected = if species == Species::Pig {
    // rust: mob.extra.age = -37;
    // rust: Some(Tag::Int(-37))
    // rust: } else {
    // rust: None
}
    // rust: for raw in [
    // rust: None,
    // rust: Some(Tag::Compound(Default::default())),
    // rust: Some(Tag::compound([("Age", Tag::Int(0))])),
    // rust: Some(Tag::compound([("Age", Tag::Int(-100))])),
    // rust: Some(Tag::compound([("Age", Tag::Int(100))])),
    // rust: ] {
    // rust: let saved = mob_to_nbt(&mob, [0; 4], raw.as_ref(), None);
    // rust: assert_eq!(
    // rust: saved.get("Age"),
    // rust: expected.as_ref(),
    // rust: "{species:?}, raw={raw:?}"
    // rust: );
}
}
}

a_baby_villager_keeps_its_age :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let saved = Tag::compound([
    // rust: ("id", string("minecraft:villager")),
    // rust: ("Pos", doubles(&[0.5, 64.0, 0.5])),
    // rust: ("Age", Tag::Int(-21359)),
    // rust: ]);
    // rust: let m = mob_from_nbt(&saved, &types, 1, None).unwrap();
    // rust: assert_eq!(m.extra.age, -21359);
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(number(tag.get("Age")), Some(-21359));
    // rust: assert_eq!(number(tag.get("AgeLocked")), Some(0));
    // rust: assert_eq!(number(tag.get("VillagerDataFinalized")), Some(1));
}

    // `Dolphin.addAdditionalSaveData`: a fed dolphin stays fed and a wet one
    // stays wet across a reload; a save with neither field reads as an unfed
    // dolphin at full moistness.
a_dolphins_moistness_and_fish_survive_a_save :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
        // A fresh dolphin starts full, as `Dolphin`'s field does.
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: types["minecraft:dolphin"].clone(),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(m.extra.counter, 2400);
    // rust: m.extra.flag = true;
    // rust: m.extra.counter = 123;
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(number(tag.get("Moistness")), Some(123));
    // rust: assert_eq!(number(tag.get("GotFish")), Some(1));
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert!(back.extra.flag, "fed");
    // rust: assert_eq!(back.extra.counter, 123);
        // A save with neither field: unfed, full.
    // rust: let bare = Tag::compound([
    // rust: ("id", string("minecraft:dolphin")),
    // rust: ("Pos", doubles(&[0.5, 64.0, 0.5])),
    // rust: ]);
    // rust: let back = mob_from_nbt(&bare, &types, 3, None).unwrap();
    // rust: assert!(!back.extra.flag);
    // rust: assert_eq!(back.extra.counter, 2400);
}

    // `WanderingTrader.addAdditionalSaveData`: the visit's countdown and the
    // place it is walking to (a `BlockPos` codec, so an int array), which the
    // despawn and stroll goals read back after a reload.
a_wandering_traders_countdown_and_target_survive_a_save :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: types["minecraft:wandering_trader"].clone(),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: m.extra.ints[5] = 48000;
    // rust: m.extra.point = Some([12.0, 65.0, -30.0]);
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(number(tag.get("DespawnDelay")), Some(48000));
    // rust: let Some(Tag::IntArray(target)) = tag.get("wander_target") else {
    // rust: panic!("wander_target missing");
}
    // rust: assert_eq!(target, &vec![12, 65, -30]);
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(back.extra.ints[5], 48000);
    // rust: assert_eq!(back.extra.point, Some([12.0, 65.0, -30.0]));
        // A save with neither field: idle, and nothing to walk to.
    // rust: let bare = Tag::compound([
    // rust: ("id", string("minecraft:wandering_trader")),
    // rust: ("Pos", doubles(&[0.5, 64.0, 0.5])),
    // rust: ]);
    // rust: let back = mob_from_nbt(&bare, &types, 3, None).unwrap();
    // rust: assert_eq!((back.extra.ints[5], back.extra.point), (0, None));
}

mobs_keep_their_variant_puff_state_carried_block_and_conversion_times :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let registry = horizon_world::registry::BlockRegistry::from_facts_json(
    // rust: std::fs::File::open(root.join("facts.json")).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let new = |kind: &str| Mob::new(1, types[kind].clone(), Vec3::new(0.0, 4.0, 0.0), 0.0);
    // rust: let round_trip = |m: &Mob| {
    // rust: let tag = mob_to_nbt(m, [1, 2, 3, 4], None, Some(&registry));
    // rust: (mob_from_nbt(&tag, &types, 2, Some(&registry)).unwrap(), tag)
}
        // A save with nothing but where the mob stands.
    // rust: let empty =
    // rust: |kind: &str| Tag::compound([("id", string(kind)), ("Pos", doubles(&[0.5, 64.0, 0.5]))]);
    // rust: let mut fox = new("minecraft:fox");
    // rust: fox.extra.variant = 1;
    // rust: let (back, tag) = round_trip(&fox);
    // rust: assert_eq!(text(tag.get("Type")).as_deref(), Some("snow"));
    // rust: assert_eq!(number(tag.get("Sleeping")), Some(0));
    // rust: assert_eq!(back.extra.variant, 1);
        // MushroomCow: a brown mooshroom stays brown, and a save without (or
        // with an unknown) Type reads as red.
    // rust: let mut mooshroom = new("minecraft:mooshroom");
    // rust: mooshroom.extra.variant = 1;
    // rust: let (back, tag) = round_trip(&mooshroom);
    // rust: assert_eq!(text(tag.get("Type")).as_deref(), Some("brown"));
    // rust: assert_eq!(back.extra.variant, 1);
    // rust: mooshroom.extra.variant = 0;
    // rust: let (back, tag) = round_trip(&mooshroom);
    // rust: assert_eq!(text(tag.get("Type")).as_deref(), Some("red"));
    // rust: assert_eq!(back.extra.variant, 0);
        // Its stew effects round-trip as the component's bare {id, duration}
        // entries, and a cleared list is not written at all.
    // rust: mooshroom.extra.variant = 1;
    // rust: mooshroom.extra.stew_effects = Some(vec![(Arc::from("minecraft:night_vision"), 100)]);
    // rust: let (back, tag) = round_trip(&mooshroom);
    // rust: assert_eq!(back.extra.stew_effects, mooshroom.extra.stew_effects);
    // rust: let entry = match tag.get("stew_effects") {
    // rust: Some(Tag::List(list)) => list.first().expect("one effect"),
    // rust: other => panic!("stew_effects: {other:?}"),
}
    // rust: assert_eq!(
    // rust: (text(entry.get("id")), number(entry.get("duration"))),
    // rust: (Some("minecraft:night_vision".into()), Some(100))
    // rust: );
    // rust: mooshroom.extra.stew_effects = None;
    // rust: let (back, tag) = round_trip(&mooshroom);
    // rust: assert_eq!(back.extra.stew_effects, None);
    // rust: assert!(tag.get("stew_effects").is_none());
    // rust: let mut rabbit = new("minecraft:rabbit");
    // rust: rabbit.extra.variant = 4;
    // rust: let (back, tag) = round_trip(&rabbit);
    // rust: assert_eq!(number(tag.get("RabbitType")), Some(4));
    // rust: assert_eq!(back.extra.variant, 4);
    // rust: let mut goat = new("minecraft:goat");
    // rust: (goat.extra.screaming, goat.extra.lost_horns) = (true, [false, true]);
    // rust: let (back, tag) = round_trip(&goat);
    // rust: assert_eq!(number(tag.get("HasRightHorn")), Some(0));
    // rust: assert_eq!(
    // rust: (back.extra.screaming, back.extra.lost_horns),
    // rust: (true, [false, true])
    // rust: );
        // Pufferfish.addAdditionalSaveData: the puff state, 0 when the save
        // has none and at most 2 when it has more.
    // rust: let mut pufferfish = new("minecraft:pufferfish");
    // rust: pufferfish.extra.size = 2;
    // rust: let (back, tag) = round_trip(&pufferfish);
    // rust: assert_eq!(number(tag.get("PuffState")), Some(2));
    // rust: assert_eq!(back.extra.size, 2);
    // rust: assert_eq!(
    // rust: mob_from_nbt(&empty("minecraft:pufferfish"), &types, 3, Some(&registry))
    // rust: .unwrap()
    // rust: .extra
    // rust: .size,
    // rust: 0
    // rust: );
    // rust: let puffed = Tag::compound([
    // rust: ("id", string("minecraft:pufferfish")),
    // rust: ("Pos", doubles(&[0.5, 64.0, 0.5])),
    // rust: ("PuffState", Tag::Int(5)),
    // rust: ]);
    // rust: assert_eq!(
    // rust: mob_from_nbt(&puffed, &types, 3, Some(&registry))
    // rust: .unwrap()
    // rust: .extra
    // rust: .size,
    // rust: 2
    // rust: );
        // Enderman.addAdditionalSaveData: the block it carries, a block name
        // for the block's default state and `{id, properties}` otherwise.
    // rust: let mut enderman = new("minecraft:enderman");
    // rust: let grass = registry.default_state("minecraft:grass_block");
    // rust: enderman.extra.carried = grass;
    // rust: let (back, tag) = round_trip(&enderman);
    // rust: assert_eq!(
    // rust: text(tag.get("carriedBlockState")).as_deref(),
    // rust: Some("minecraft:grass_block")
    // rust: );
    // rust: assert_eq!(back.extra.carried, grass);
    // rust: let log = registry
    // rust: .id(&horizon_world::chunk::BlockState {
    // rust: name: "minecraft:oak_log".into(),
    // rust: properties: [("axis".to_owned(), "x".to_owned())].into(),
    // rust: })
    // rust: .unwrap();
    // rust: enderman.extra.carried = Some(log);
    // rust: let (back, tag) = round_trip(&enderman);
    // rust: assert!(matches!(
    // rust: tag.get("carriedBlockState"),
    // rust: Some(Tag::Compound(_))
    // rust: ));
    // rust: assert_eq!(back.extra.carried, Some(log));
        // Nothing carried: no key, and none read back; an air state reads as
        // no block at all.
    // rust: enderman.extra.carried = None;
    // rust: let (back, tag) = round_trip(&enderman);
    // rust: assert_eq!(tag.get("carriedBlockState"), None);
    // rust: assert_eq!(back.extra.carried, None);
    // rust: let air = Tag::compound([
    // rust: ("id", string("minecraft:enderman")),
    // rust: ("Pos", doubles(&[0.5, 64.0, 0.5])),
    // rust: ("carriedBlockState", string("minecraft:air")),
    // rust: ]);
    // rust: assert_eq!(
    // rust: mob_from_nbt(&air, &types, 3, Some(&registry))
    // rust: .unwrap()
    // rust: .extra
    // rust: .carried,
    // rust: None
    // rust: );
        // A goat saved without horn flags has both, as vanilla reads it.
    // rust: assert_eq!(
    // rust: mob_from_nbt(&empty("minecraft:goat"), &types, 3, None)
    // rust: .unwrap()
    // rust: .extra
    // rust: .lost_horns,
    // rust: [false; 2]
    // rust: );
        // Zombie and Skeleton.addAdditionalSaveData: the `ConversionTracker`
        // tags, -1 for a counter that is not running, and both come back into
        // the counters the tick uses.
    // rust: let mut zombie = new("minecraft:zombie");
        // Positive affliction counters represent a zombie with immersed eyes.
    // rust: zombie.fluids.eye_in_water = true;
    // rust: zombie.extra.counter = 300;
    // rust: let (back, tag) = round_trip(&zombie);
    // rust: assert_eq!(number(tag.get("InWaterTime")), Some(300));
    // rust: assert_eq!(number(tag.get("DrownedConversionTime")), Some(-1));
    // rust: assert_eq!((back.extra.counter, back.extra.counter2), (300, 0));
    // rust: (zombie.extra.counter, zombie.extra.counter2) = (600, 300);
    // rust: let (back, tag) = round_trip(&zombie);
    // rust: assert_eq!(number(tag.get("InWaterTime")), Some(600));
    // rust: assert_eq!(number(tag.get("DrownedConversionTime")), Some(299));
    // rust: assert_eq!((back.extra.counter, back.extra.counter2), (600, 300));
    // rust: let mut skeleton = new("minecraft:skeleton");
    // rust: skeleton.extra.counter = 70;
    // rust: let (back, tag) = round_trip(&skeleton);
    // rust: assert_eq!(number(tag.get("FreezingTime")), Some(70));
    // rust: assert_eq!(number(tag.get("StrayConversionTime")), Some(-1));
    // rust: assert_eq!((back.extra.counter, back.extra.counter2), (70, 0));
    // rust: (skeleton.extra.counter, skeleton.extra.counter2) = (140, 301);
    // rust: let (back, tag) = round_trip(&skeleton);
    // rust: assert_eq!(number(tag.get("FreezingTime")), Some(140));
    // rust: assert_eq!(number(tag.get("StrayConversionTime")), Some(300));
    // rust: assert_eq!((back.extra.counter, back.extra.counter2), (140, 301));
        // Not converting: -1 in both tags, and nothing starts on load.
    // rust: for (kind, affliction, conversion) in [
    // rust: ("minecraft:zombie", "InWaterTime", "DrownedConversionTime"),
    // rust: ("minecraft:skeleton", "FreezingTime", "StrayConversionTime"),
    // rust: ] {
    // rust: let mut m = new(kind);
    // rust: (m.extra.counter, m.extra.counter2) = (-1, 0);
    // rust: let (back, tag) = round_trip(&m);
    // rust: assert_eq!(number(tag.get(affliction)), Some(-1));
    // rust: assert_eq!(number(tag.get(conversion)), Some(-1));
    // rust: assert_eq!((back.extra.counter, back.extra.counter2), (-1, 0));
}
        // A saved conversion time starts one: `startConversion`.
    // rust: let saved = Tag::compound([
    // rust: ("id", string("minecraft:zombie")),
    // rust: ("Pos", doubles(&[0.5, 64.0, 0.5])),
    // rust: ("InWaterTime", Tag::Int(600)),
    // rust: ("DrownedConversionTime", Tag::Int(300)),
    // rust: ]);
    // rust: let back = mob_from_nbt(&saved, &types, 4, None).unwrap();
    // rust: assert_eq!((back.extra.counter, back.extra.counter2), (600, 301));
}
}

    // rust: mod item_component_tests {
//     use super::*;
a_spawn_egg_beats_the_biome_variant :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let spawn = |kind: &str, id: u32| {
    // rust: let mut m = Mob::new(
    // rust: id,
    // rust: Arc::new(data.types[kind].clone()),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
            // What `finalizeSpawn` leaves in a temperate biome.
    // rust: m.extra.variant = 0;
    // rust: m
}
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:chicken_spawn_egg", 1);
    // rust: egg.data_mut()
    // rust: .set_other("minecraft:chicken/variant", Some(string("minecraft:warm")));
    // rust: let mut hen = spawn("minecraft:chicken", 1);
    // rust: assert_eq!(hen.extra.variant, 0);
    // rust: apply_item_components(&mut hen, &egg);
    // rust: assert_eq!(hen.extra.variant, 1, "minecraft:warm, not the biome's");
        // MushroomCow.applyImplicitComponents: the egg's variant, and the
        // component the mob reports back.
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:mooshroom_spawn_egg", 1);
    // rust: egg.data_mut().set_other(
    // rust: "minecraft:mooshroom/variant",
    // rust: Some(string("minecraft:brown")),
    // rust: );
    // rust: let mut mooshroom = spawn("minecraft:mooshroom", 3);
    // rust: apply_item_components(&mut mooshroom, &egg);
    // rust: let (id, variant) = crate::mobs::finalize::variant_component(&mooshroom).unwrap();
    // rust: assert_eq!(
    // rust: (id, variant.as_str()),
    // rust: ("minecraft:mooshroom/variant", "minecraft:brown")
    // rust: );
        // Sheep.applyImplicitComponents: the egg's colour over the mob's.
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:sheep_spawn_egg", 1);
    // rust: egg.data_mut()
    // rust: .set_other("minecraft:sheep/color", Some(string("lime")));
    // rust: let mut sheep = spawn("minecraft:sheep", 2);
    // rust: apply_item_components(&mut sheep, &egg);
    // rust: assert_eq!(sheep.extra.color, 5, "lime, not the white it started as");
        // ZombieNautilus.applyImplicitComponents: the egg carries the coral
        // variant over the temperate one the biome picked.
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:zombie_nautilus_spawn_egg", 1);
    // rust: egg.data_mut().set_other(
    // rust: "minecraft:zombie_nautilus/variant",
    // rust: Some(string("minecraft:warm")),
    // rust: );
    // rust: let mut nautilus = spawn("minecraft:zombie_nautilus", 4);
    // rust: apply_item_components(&mut nautilus, &egg);
    // rust: assert_eq!(nautilus.extra.variant, 1, "minecraft:warm, not temperate");
}

    // `Fox.applyImplicitComponent` and `Frog.applyImplicitComponent`: the
    // variant component alone decides the mob, `setVariant` from the egg.
a_fox_or_frog_spawn_egg_picks_its_variant_component :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let spawn = |kind: &str, id: u32| {
    // rust: Mob::new(
    // rust: id,
    // rust: Arc::new(data.types[kind].clone()),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: )
}
        // A red fox, as a spawn in a forest leaves it.
    // rust: let mut fox = spawn("minecraft:fox", 1);
    // rust: assert_eq!(fox.extra.variant, 0);
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:fox_spawn_egg", 1);
    // rust: egg.data_mut()
    // rust: .set_other("minecraft:fox/variant", Some(string("minecraft:snow")));
    // rust: apply_item_components(&mut fox, &egg);
    // rust: assert_eq!(fox.extra.variant, 1, "Fox.Variant.SNOW, not red");
        // A temperate frog, as a swamp spawn leaves it.
    // rust: let mut frog = spawn("minecraft:frog", 2);
    // rust: assert_eq!(frog.extra.variant, 0);
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:frog_spawn_egg", 1);
    // rust: egg.data_mut()
    // rust: .set_other("minecraft:frog/variant", Some(string("minecraft:warm")));
    // rust: apply_item_components(&mut frog, &egg);
    // rust: assert_eq!(frog.extra.variant, 1, "minecraft:warm, not temperate");
        // An unknown name falls back to the codec's default, red.
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:fox_spawn_egg", 1);
    // rust: egg.data_mut()
    // rust: .set_other("minecraft:fox/variant", Some(string("minecraft:temperate")));
    // rust: apply_item_components(&mut fox, &egg);
    // rust: assert_eq!(fox.extra.variant, 0, "unknown names read as red");
}

    // `Horse.applyImplicitComponent` and `Llama.applyImplicitComponent`: the
    // `.../variant` component sets the coat colour. A horse's markings are
    // the other half of the packed variant its spawn picked and stay.
a_horse_or_llama_spawn_egg_picks_its_variant_component :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let spawn = |kind: &str, id: u32| {
    // rust: Mob::new(
    // rust: id,
    // rust: Arc::new(data.types[kind].clone()),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: )
}
        // A black horse (Horse.Variant.BLACK, 4) with a white field (markings
        // 2), as a spawn in a plains leaves it.
    // rust: let mut horse = spawn("minecraft:horse", 1);
    // rust: (horse.extra.variant, horse.extra.variant2) = (4, 2);
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:horse_spawn_egg", 1);
    // rust: egg.data_mut().set_other(
    // rust: "minecraft:horse/variant",
    // rust: Some(string("minecraft:dark_brown")),
    // rust: );
    // rust: apply_item_components(&mut horse, &egg);
    // rust: assert_eq!(horse.extra.variant, 6, "Horse.Variant.DARK_BROWN");
    // rust: assert_eq!(
    // rust: horse.extra.variant2, 2,
    // rust: "the markings the spawn picked stay"
    // rust: );
        // `Horse.get(DataComponents.HORSE_VARIANT)` reports it back.
    // rust: let (id, variant) = crate::mobs::finalize::variant_component(&horse).unwrap();
    // rust: assert_eq!(
    // rust: (id, variant.as_str()),
    // rust: ("minecraft:horse/variant", "minecraft:dark_brown")
    // rust: );
        // The save keeps the packed `Variant` int and gains no `variant` name,
        // which only `VariantUtils.writeVariant` species store.
    // rust: let tag = mob_to_nbt(&horse, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(tag.get("variant"), None);
    // rust: assert!(
    // rust: matches!(tag.get("Variant"), Some(Tag::Int(v)) if *v == 6 | 2 << 8),
    // rust: "colour 6 and markings 2 packed"
    // rust: );
        // A llama, as a spawn in a plains leaves it: creamy.
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:llama_spawn_egg", 1);
    // rust: egg.data_mut()
    // rust: .set_other("minecraft:llama/variant", Some(string("minecraft:gray")));
    // rust: let mut llama = spawn("minecraft:llama", 2);
    // rust: assert_eq!(llama.extra.variant, 0);
    // rust: apply_item_components(&mut llama, &egg);
    // rust: assert_eq!(llama.extra.variant, 3, "Llama.Variant.GRAY");
        // TraderLlama inherits the llama's arm.
    // rust: let mut trader = spawn("minecraft:trader_llama", 3);
    // rust: apply_item_components(&mut trader, &egg);
    // rust: assert_eq!(trader.extra.variant, 3, "the trader llama reads it too");
}

    // `EntityType.updateCustomEntityTag`: the egg's `entity_data` on the mob it
    // spawned, when the type is its own — the mob's compound, the data merged
    // over it and loaded back, as the spawn egg site does it.
a_spawn_eggs_entity_data_reaches_the_mob_it_spawned :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let egg = |entity_data: Option<Tag>| {
    // rust: let mut egg = crate::items::ItemStack::new("minecraft:zombie_spawn_egg", 1);
    // rust: if let Some(data) = entity_data {
    // rust: egg.data_mut()
    // rust: .set_other("minecraft:entity_data", Some(data));
}
    // rust: egg
}
    // rust: let spawn = |stack: &crate::items::ItemStack| {
    // rust: let mut m = Mob::new(
    // rust: 2,
    // rust: types["minecraft:zombie"].clone(),
    // rust: Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: apply_item_components(&mut m, stack);
    // rust: let Some(data) =
    // rust: crate::block_entity_item::spawn_egg_entity_data(stack, &m.kind.id, false)
    // rust: else {
    // rust: return m;
}
    // rust: let tag = crate::data_cmd::merged(&mob_to_nbt(&m, [1, 2, 3, 4], None, None), data);
    // rust: mob_from_nbt(&tag, &types, 2, None).unwrap()
}
        // `entity_data={NoAI:1b}`: no id, so the egg's own type holds the data.
    // rust: assert!(spawn(&egg(Some(Tag::compound([("NoAI", Tag::Byte(1))])))).no_ai);
        // `entity_data.id` names another type: the egg's own type, data skipped.
    // rust: let other = spawn(&egg(Some(Tag::compound([
    // rust: ("id", string("minecraft:pig")),
    // rust: ("NoAI", Tag::Byte(1)),
    // rust: ]))));
    // rust: assert_eq!(other.kind.id.as_str(), "minecraft:zombie");
    // rust: assert!(!other.no_ai);
        // A plain egg is unchanged.
    // rust: assert!(!spawn(&egg(None)).no_ai);
}
}

    // rust: mod fireball_nbt_tests {
//     use super::*;
a_fireball_round_trips_its_flight :: proc() {
}
    // rust: let raw = Tag::compound([
    // rust: ("id", Tag::String("minecraft:fireball".into())),
    // rust: ("Pos", doubles(&[1.0, 70.0, -2.5])),
    // rust: ("Motion", doubles(&[0.0, -0.5, 1.0])),
    // rust: ("ExplosionPower", Tag::Byte(4)),
    // rust: ("acceleration_power", Tag::Double(0.0f64.to_bits())),
    // rust: ]);
    // rust: let p = fireball_from_nbt(&raw, None).unwrap();
    // rust: assert_eq!(p.kind, ProjectileKind::LargeFireball { power: 4 });
    // rust: assert_eq!((p.velocity.z, p.acceleration), (1.0, 0.0));
    // rust: let back = fireball_to_nbt(&p, [1, 2, 3, 4], None, None).unwrap();
    // rust: assert_eq!(number(back.get("ExplosionPower")), Some(4));
    // rust: assert_eq!(float(back.get("acceleration_power")), Some(0.0));
        // Projectile.addAdditionalSaveData: no LeftOwner unless set, HasBeenShot always.
    // rust: assert!(back.get("LeftOwner").is_none());
    // rust: assert_eq!(number(back.get("HasBeenShot")), Some(0));
    // rust: assert_eq!(
    // rust: read_doubles::<3>(back.get("Motion")),
    // rust: Some([0.0, -0.5, 1.0])
    // rust: );
        // A default fireball keeps vanilla's power and acceleration.
    // rust: let plain = Tag::compound([
    // rust: ("id", Tag::String("minecraft:fireball".into())),
    // rust: ("Pos", doubles(&[0.0, 0.0, 0.0])),
    // rust: ]);
    // rust: let p = fireball_from_nbt(&plain, None).unwrap();
    // rust: assert_eq!(
    // rust: (p.kind, p.acceleration),
    // rust: (ProjectileKind::LargeFireball { power: 1 }, 0.1)
    // rust: );
        // `/summon` and a saved world give back both wind charges.
    // rust: for (id, kind) in [
    // rust: ("minecraft:wind_charge", ProjectileKind::WindCharge),
    // rust: (
    // rust: "minecraft:breeze_wind_charge",
    // rust: ProjectileKind::BreezeWindCharge,
    // rust: ),
    // rust: ] {
    // rust: let tag = Tag::compound([
    // rust: ("id", Tag::String(id.into())),
    // rust: ("Pos", doubles(&[0.0, 0.0, 0.0])),
    // rust: ]);
    // rust: assert_eq!(fireball_from_nbt(&tag, None).unwrap().kind, kind);
}
}

    // `Fireball.addAdditionalSaveData` / `readAdditionalSaveData`: both fireballs save
    // `Item`, a fire charge by default, and a loaded one stays, as one item.
a_fireball_saves_its_item :: proc() {
}
    // rust: let item_of = |tag: &Tag| {
    // rust: let item = tag.get("Item").and_then(item_from_nbt).unwrap();
    // rust: (item.item.to_string(), item.count)
}
    // rust: for id in ["minecraft:fireball", "minecraft:small_fireball"] {
    // rust: let plain = Tag::compound([
    // rust: ("id", Tag::String(id.into())),
    // rust: ("Pos", doubles(&[0.0, 0.0, 0.0])),
    // rust: ]);
    // rust: let p = fireball_from_nbt(&plain, None).unwrap();
    // rust: let back = fireball_to_nbt(&p, [1, 2, 3, 4], None, Some(&plain)).unwrap();
    // rust: assert_eq!(
    // rust: item_of(&back),
    // rust: ("minecraft:fire_charge".to_owned(), 1),
    // rust: "{id}"
    // rust: );
            // A loaded item stays, as a single one, on the entity itself.
    // rust: let mut loaded = plain.clone();
    // rust: put(
    // rust: &mut loaded,
    // rust: "Item",
    // rust: item_to_nbt(&crate::items::ItemStack::new("minecraft:diamond", 5)),
    // rust: );
    // rust: let p = fireball_from_nbt(&loaded, None).unwrap();
    // rust: let held = p.item.as_ref().unwrap();
    // rust: assert_eq!((&*held.item, held.count), ("minecraft:diamond", 1), "{id}");
            // `addAdditionalSaveData` writes `getItem()`: the item in the
            // compound it was loaded from does not replace the one it holds,
            // which is what `/data get` and the chunk save then report.
    // rust: let mut stale = plain.clone();
    // rust: put(
    // rust: &mut stale,
    // rust: "Item",
    // rust: item_to_nbt(&crate::items::ItemStack::new("minecraft:stone", 8)),
    // rust: );
    // rust: let back = fireball_to_nbt(&p, [1, 2, 3, 4], None, Some(&stale)).unwrap();
    // rust: assert_eq!(item_of(&back), ("minecraft:diamond".to_owned(), 1), "{id}");
            // An empty one falls back to the fire charge.
    // rust: let mut empty = plain.clone();
    // rust: put(
    // rust: &mut empty,
    // rust: "Item",
    // rust: item_to_nbt(&crate::items::ItemStack::new("minecraft:air", 1)),
    // rust: );
    // rust: let p = fireball_from_nbt(&empty, None).unwrap();
    // rust: let back = fireball_to_nbt(&p, [1, 2, 3, 4], None, Some(&empty)).unwrap();
    // rust: assert_eq!(
    // rust: item_of(&back),
    // rust: ("minecraft:fire_charge".to_owned(), 1),
    // rust: "{id}"
    // rust: );
}
        // The wind charges are not `Fireball`s: they save no item.
    // rust: let wind = Tag::compound([
    // rust: ("id", Tag::String("minecraft:wind_charge".into())),
    // rust: ("Pos", doubles(&[0.0, 0.0, 0.0])),
    // rust: ]);
    // rust: let p = fireball_from_nbt(&wind, None).unwrap();
    // rust: let back = fireball_to_nbt(&p, [1, 2, 3, 4], None, Some(&wind)).unwrap();
    // rust: assert!(back.get("Item").is_none());
}

a_summoned_potion_flies_as_the_item_its_compound_names :: proc() {
}
        // `ThrowableItemProjectile.getDefaultItem`: the item its entity type is
        // named after, so a bare summon is a splash potion with no effects and
        // the chunk saves it (ThrowableProjectile is not transient).
    // rust: for id in ["minecraft:splash_potion", "minecraft:lingering_potion"] {
    // rust: let bare = Tag::compound([
    // rust: ("id", Tag::String(id.into())),
    // rust: ("Pos", doubles(&[24.5, 216.0, 24.5])),
    // rust: ]);
    // rust: let p = throwable_from_nbt(&bare, None).unwrap();
    // rust: assert_eq!(p.kind.id(), id);
    // rust: assert_eq!(
    // rust: p.kind,
    // rust: ProjectileKind::Potion(
    // rust: Box::new(crate::items::ItemStack::new(id, 1)),
    // rust: id == "minecraft:lingering_potion"
    // rust: )
    // rust: );
    // rust: assert!(saved_with_chunk(&p));
    // rust: let tag = throwable_to_nbt(&p, [1; 4], None, None).unwrap();
    // rust: let item = tag.get("Item").and_then(item_from_nbt).unwrap();
    // rust: assert_eq!((&*item.item, item.count), (id, 1));
    // rust: assert_eq!(item.potion(), None);
}
        // `readAdditionalSaveData`: the `Item` it flies as, `potion_contents`
        // and all, so what it splashes is the potion's.
    // rust: let harming = Tag::compound([
    // rust: ("id", Tag::String("minecraft:splash_potion".into())),
    // rust: ("Pos", doubles(&[24.5, 216.0, 24.5])),
    // rust: (
    // rust: "Item",
    // rust: item_to_nbt(
    // rust: &crate::items::ItemStack::new("minecraft:splash_potion", 1)
    // rust: .with_potion("minecraft:harming"),
    // rust: ),
    // rust: ),
    // rust: ]);
    // rust: let p = throwable_from_nbt(&harming, None).unwrap();
    // rust: let ProjectileKind::Potion(stack, _) = &p.kind else {
    // rust: panic!("a potion");
}
    // rust: assert_eq!(stack.potion(), Some("minecraft:harming"));
        // The stack stays in the tag it was loaded from.
    // rust: let tag = throwable_to_nbt(&p, [1; 4], None, Some(&harming)).unwrap();
    // rust: let item = tag.get("Item").and_then(item_from_nbt).unwrap();
    // rust: assert_eq!(item.potion(), Some("minecraft:harming"));
        // A lingering potion is its own entity type.
    // rust: let lingering = Tag::compound([
    // rust: ("id", Tag::String("minecraft:lingering_potion".into())),
    // rust: ("Pos", doubles(&[0.0, 64.0, 0.0])),
    // rust: (
    // rust: "Item",
    // rust: item_to_nbt(
    // rust: &crate::items::ItemStack::new("minecraft:lingering_potion", 1)
    // rust: .with_potion("minecraft:poison"),
    // rust: ),
    // rust: ),
    // rust: ]);
    // rust: let p = throwable_from_nbt(&lingering, None).unwrap();
    // rust: assert_eq!(p.kind.id(), "minecraft:lingering_potion");
}

wind_charges_in_flight_are_saved_and_read_back :: proc() {
}
        // vanilla 26.3 saves them (`Entity.shouldBeSaved` is true; the round
        // trip of a vanilla world lost all four before this).
    // rust: for id in ["minecraft:wind_charge", "minecraft:breeze_wind_charge"] {
    // rust: let saved = Tag::compound([
    // rust: ("id", Tag::String(id.into())),
    // rust: ("Pos", doubles(&[4.5, 80.0, 10.5])),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: ("acceleration_power", Tag::Double(0.1_f64.to_bits())),
    // rust: ]);
    // rust: let p = fireball_from_nbt(&saved, None).unwrap();
    // rust: assert_eq!(p.kind.id(), id);
    // rust: assert!(saved_with_chunk(&p), "{id}");
    // rust: let tag = fireball_to_nbt(&p, [1; 4], None, Some(&saved)).unwrap();
    // rust: assert_eq!(kind(&tag).as_deref(), Some(id));
    // rust: assert_eq!(tag.get("NoGravity"), Some(&Tag::Byte(1)));
}
}

a_lingering_potion_keeps_its_type_whatever_item_it_flies_as :: proc() {
}
        // `/summon minecraft:lingering_potion ~ ~ ~ {Item:{id:"minecraft:splash_potion"}}`
        // is a `ThrownLingeringPotion` in vanilla and stays one when saved.
    // rust: let tag = Tag::compound([
    // rust: ("id", Tag::String("minecraft:lingering_potion".into())),
    // rust: ("Pos", doubles(&[24.5, 80.0, 8.5])),
    // rust: (
    // rust: "Item",
    // rust: item_to_nbt(&crate::items::ItemStack::new("minecraft:splash_potion", 1)),
    // rust: ),
    // rust: ]);
    // rust: let p = throwable_from_nbt(&tag, None).unwrap();
    // rust: assert_eq!(p.kind.id(), "minecraft:lingering_potion");
    // rust: let back = throwable_to_nbt(&p, [1; 4], None, Some(&tag)).unwrap();
    // rust: assert_eq!(kind(&back).as_deref(), Some("minecraft:lingering_potion"));
    // rust: let item = back.get("Item").and_then(item_from_nbt).unwrap();
    // rust: assert_eq!(&*item.item, "minecraft:splash_potion");
}

a_summoned_painting_or_frame_has_no_block_pos_and_sits_at_its_position :: proc() {
}
        // BlockAttachedEntity.setPos: the block holding the summon position.
    // rust: let painting = Tag::compound([
    // rust: ("id", Tag::String("minecraft:painting".into())),
    // rust: ("Pos", doubles(&[28.5, 80.0, 6.5])),
    // rust: ("variant", Tag::String("minecraft:kebab".into())),
    // rust: ("facing", Tag::Byte(3)),
    // rust: ]);
    // rust: assert_eq!(
    // rust: painting_from_nbt(&painting),
    // rust: Some(([28, 80, 6], 3, "minecraft:kebab".to_string()))
    // rust: );
    // rust: let frame = Tag::compound([
    // rust: ("id", Tag::String("minecraft:item_frame".into())),
    // rust: ("Pos", doubles(&[-0.5, 80.0, 6.5])),
    // rust: ("Facing", Tag::Byte(1)),
    // rust: ]);
    // rust: assert_eq!(item_frame_from_nbt(&frame, 1).unwrap().pos, [-1, 80, 6]);
}

a_named_frame_drops_with_its_custom_name :: proc() {
}
        // `ItemFrame.getFrameItemStackWithData`: the frame item, then
        // `DataComponents.CUSTOM_NAME` from `getCustomName`. Glow frames
        // share it through `GlowItemFrame.getFrameItemStack`.
    // rust: for id in ["minecraft:item_frame", "minecraft:glow_item_frame"] {
    // rust: let tag = Tag::compound([
    // rust: ("id", string(id)),
    // rust: ("Pos", doubles(&[0.5, 64.0, 0.5])),
    // rust: ("Facing", Tag::Byte(2)),
    // rust: ("CustomName", string("Gallery")),
    // rust: ]);
    // rust: let frame = item_frame_from_nbt(&tag, 1).unwrap();
    // rust: let stack = frame.item_stack_with_data();
    // rust: assert_eq!(&*stack.item, id);
    // rust: assert_eq!(stack.count, 1);
    // rust: assert_eq!(stack.custom_name().as_deref(), Some("Gallery"));
    // rust: let saved = item_frame_to_nbt(&frame, [1, 2, 3, 4], None);
    // rust: assert_eq!(text(saved.get("CustomName")).as_deref(), Some("Gallery"));
}
    // rust: let bare = Tag::compound([
    // rust: ("id", string("minecraft:item_frame")),
    // rust: ("Pos", doubles(&[0.5, 64.0, 0.5])),
    // rust: ("Facing", Tag::Byte(3)),
    // rust: ]);
    // rust: let frame = item_frame_from_nbt(&bare, 2).unwrap();
    // rust: assert!(frame.custom_name.is_none());
    // rust: assert!(frame.item_stack_with_data().custom_name().is_none());
    // rust: assert!(
    // rust: item_frame_to_nbt(&frame, [1, 2, 3, 4], Some(&bare))
    // rust: .get("CustomName")
    // rust: .is_none()
    // rust: );
}

projectile_shot_flag_round_trips_independently_of_age :: proc() {
}
    // rust: for id in [
    // rust: "minecraft:snowball",
    // rust: "minecraft:fireball",
    // rust: "minecraft:llama_spit",
    // rust: "minecraft:shulker_bullet",
    // rust: ] {
    // rust: for shot in [0, 1] {
    // rust: let raw = Tag::compound([
    // rust: ("id", Tag::String(id.into())),
    // rust: ("Pos", doubles(&[1.0, 70.0, 2.0])),
    // rust: ("HasBeenShot", Tag::Byte(shot)),
    // rust: ]);
    // rust: let mut p = throwable_from_nbt(&raw, None)
    // rust: .or_else(|| fireball_from_nbt(&raw, None))
    // rust: .or_else(|| spit_or_bullet_from_nbt(&raw, None))
    // rust: .unwrap();
    // rust: assert_eq!(p.has_been_shot, shot != 0);
    // rust: for age in [0, 12] {
    // rust: p.age = age;
    // rust: let tag = throwable_to_nbt(&p, [1, 2, 3, 4], None, Some(&raw))
    // rust: .or_else(|| fireball_to_nbt(&p, [1, 2, 3, 4], None, Some(&raw)))
    // rust: .or_else(|| spit_or_bullet_to_nbt(&p, [1, 2, 3, 4], None, Some(&raw)))
    // rust: .unwrap();
    // rust: assert_eq!(number(tag.get("HasBeenShot")), Some(i64::from(shot)));
}
}
}
}

thrown_item_projectiles_round_trip_their_flight_item_and_owner :: proc() {
}
    // rust: let player = Some([5, 6, 7, 8]);
    // rust: for (kind, id) in [
    // rust: (ProjectileKind::Snowball, "minecraft:snowball"),
    // rust: (ProjectileKind::Egg, "minecraft:egg"),
    // rust: (ProjectileKind::EnderPearl, "minecraft:ender_pearl"),
    // rust: ] {
    // rust: let mut p =
    // rust: Projectile::new(kind.clone(), Vec3::new(1.5, 70.0, -2.5), Some(Who::Player));
    // rust: (p.velocity, p.left_owner, p.age) = (Vec3::new(0.3, -0.1, 1.2), true, 4);
    // rust: p.has_been_shot = true;
    // rust: [p.yaw, p.pitch] = [30.0, -10.0];
    // rust: let tag = throwable_to_nbt(&p, [1, 2, 3, 4], player, None).unwrap();
    // rust: assert_eq!(super::kind(&tag).as_deref(), Some(id));
            // ThrowableItemProjectile: the item it flies as, by its default.
    // rust: let item = tag.get("Item").and_then(item_from_nbt).unwrap();
    // rust: assert_eq!((&*item.item, item.count), (id, 1));
    // rust: assert_eq!(number(tag.get("HasBeenShot")), Some(1));
    // rust: assert_eq!(uuid_from_tag(tag.get("Owner")), player);
    // rust: let back = throwable_from_nbt(&tag, player).unwrap();
    // rust: assert_eq!((back.kind, back.owner), (kind, Some(Who::Player)));
    // rust: assert_eq!((back.position, back.velocity), (p.position, p.velocity));
    // rust: assert_eq!(
    // rust: ([back.yaw, back.pitch], back.left_owner),
    // rust: ([30.0, -10.0], true)
    // rust: );
            // an owner who is not here keeps their UUID through a moved resave.
    // rust: let mut away = throwable_from_nbt(&tag, Some([9; 4])).unwrap();
    // rust: assert_eq!((away.owner, away.owner_uuid), (None, player));
    // rust: away.position.y += 3.0;
    // rust: let resaved = throwable_to_nbt(&away, [1; 4], away.owner_uuid, None).unwrap();
    // rust: assert_eq!(uuid_from_tag(resaved.get("Owner")), player);
}
        // the chunk saves arrows, fireballs, wind charges and these, and so takes them with it.
    // rust: let kinds = [
    // rust: (ProjectileKind::SmallFireball, true),
    // rust: (ProjectileKind::Snowball, true),
    // rust: (ProjectileKind::WindCharge, true),
    // rust: (ProjectileKind::BreezeWindCharge, true),
    // rust: (ProjectileKind::Trident, false),
    // rust: ];
    // rust: for (kind, saved) in kinds {
    // rust: let p = Projectile::new(kind, Vec3::ZERO, None);
    // rust: assert_eq!(saved_with_chunk(&p), saved, "{:?}", p.kind);
}
        // a loaded item stays, and a new projectile leaves LeftOwner out.
    // rust: let raw = Tag::compound([
    // rust: ("id", Tag::String("minecraft:egg".into())),
    // rust: ("Pos", doubles(&[0.0, 64.0, 0.0])),
    // rust: (
    // rust: "Item",
    // rust: item_to_nbt(&crate::items::ItemStack::new("minecraft:blue_egg", 1)),
    // rust: ),
    // rust: ]);
    // rust: let egg = throwable_from_nbt(&raw, None).unwrap();
    // rust: let tag = throwable_to_nbt(&egg, [1; 4], None, Some(&raw)).unwrap();
    // rust: let item = tag.get("Item").and_then(item_from_nbt).unwrap();
    // rust: assert_eq!(&*item.item, "minecraft:blue_egg");
    // rust: assert!(tag.get("LeftOwner").is_none() && tag.get("Owner").is_none());
    // rust: assert_eq!(number(tag.get("HasBeenShot")), Some(0));
    // rust: let wind = Projectile::new(ProjectileKind::WindCharge, Vec3::ZERO, None);
    // rust: assert!(throwable_to_nbt(&wind, [1; 4], None, None).is_none());
        // NoGravity is loaded and saved again (a summoned pearl that floats).
    // rust: let floating = Tag::compound([
    // rust: ("id", Tag::String("minecraft:ender_pearl".into())),
    // rust: ("Pos", doubles(&[0.0, 64.0, 0.0])),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: ]);
    // rust: let pearl = throwable_from_nbt(&floating, None).unwrap();
    // rust: assert!(pearl.no_gravity);
    // rust: let tag = throwable_to_nbt(&pearl, [1; 4], None, None).unwrap();
    // rust: assert_eq!(number(tag.get("NoGravity")), Some(1));
    // rust: assert!(
    // rust: throwable_to_nbt(&egg, [1; 4], None, None)
    // rust: .unwrap()
    // rust: .get("NoGravity")
    // rust: .is_none()
    // rust: );
}
}

    // rust: mod neutral_anger_tests {
//     use super::*;

    // #2784: a neutral mob's anger survives the save: the anger ends at an
    // absolute game time and the target comes back with it
    // (`NeutralMob.addPersistentAngerSaveData` / `readPersistentAngerSaveData`).
a_neutral_mobs_anger_survives_the_save :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<String, Arc<MobType>> = data
    // rust: .types
    // rust: .iter()
    // rust: .map(|(k, v)| (k.clone(), Arc::new(v.clone())))
    // rust: .collect();
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: types["minecraft:wolf"].clone(),
    // rust: Vec3::new(0.0, 64.0, 0.0),
    // rust: 0.0,
    // rust: );
    // rust: m.extra.anger = 400;
    // rust: m.extra.anger_end = 3000;
    // rust: m.extra.angry_at = Some(crate::mobs::Who::Player);
    // rust: let tag = mob_to_nbt(&m, [1, 2, 3, 4], None, None);
    // rust: assert_eq!(number(tag.get("anger_end_time")), Some(3000));
    // rust: assert!(tag.get("angry_at").is_some());
    // rust: let back = mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: assert_eq!(back.extra.anger_end, 3000);
    // rust: assert_eq!(back.extra.angry_at, Some(crate::mobs::Who::Player));
        // A mob that is no NeutralMob writes no anger.
    // rust: let pig = Mob::new(3, types["minecraft:pig"].clone(), Vec3::ZERO, 0.0);
    // rust: let tag = mob_to_nbt(&pig, [1, 2, 3, 5], None, None);
    // rust: assert!(tag.get("anger_end_time").is_none());
        // The anger that is left when the mob comes back.
    // rust: assert_eq!(crate::mobs::anger_left(3000, 1000), 2000);
    // rust: assert_eq!(crate::mobs::anger_left(3000, 4000), 0);
}
}

    // rust: mod held_item_name_tests {
//     use super::*;

a_worn_piece_keeps_its_damage_and_name_through_the_save :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<_, _> = data
    // rust: .types
    // rust: .into_iter()
    // rust: .map(|(id, kind)| (id, Arc::new(kind)))
    // rust: .collect();
    // rust: let mut mob = Mob::new(1, Arc::clone(&types["minecraft:zombie"]), Vec3::ZERO, 0.0);
    // rust: let mut helmet = crate::items::ItemStack::new("minecraft:iron_helmet", 1);
    // rust: helmet.damage = 40;
    // rust: helmet.data_mut().custom_name = Some(horizon_world::nbt::Tag::String("Hat".into()));
    // rust: crate::mobs::finalize::set_item_stack(&mut mob, crate::mobs::finalize::HEAD, helmet);
    // rust: let raw = mob_to_nbt(&mob, [1, 2, 3, 4], None, None);
    // rust: let loaded = mob_from_nbt(&raw, &types, 2, None).unwrap();
    // rust: let worn = crate::mobs::finalize::item_stack(&loaded, crate::mobs::finalize::HEAD).unwrap();
    // rust: assert_eq!(worn.damage, 40);
    // rust: assert_eq!(worn.custom_name().as_deref(), Some("Hat"));
        // Replacing the item forgets the old stack.
    // rust: let mut loaded = loaded;
    // rust: crate::mobs::finalize::set_item(
    // rust: &mut loaded,
    // rust: crate::mobs::finalize::HEAD,
    // rust: "minecraft:iron_helmet",
    // rust: );
    // rust: let fresh =
    // rust: crate::mobs::finalize::item_stack(&loaded, crate::mobs::finalize::HEAD).unwrap();
    // rust: assert_eq!(fresh.damage, 0);
    // rust: assert!(fresh.custom_name().is_none());
}

replacing_a_named_item_does_not_restore_its_old_name_on_save :: proc() {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let data = crate::mobs::MobTypes::load(&root).unwrap();
    // rust: let types: HashMap<_, _> = data
    // rust: .types
    // rust: .into_iter()
    // rust: .map(|(id, kind)| (id, Arc::new(kind)))
    // rust: .collect();
    // rust: let mut mob = Mob::new(1, Arc::clone(&types["minecraft:zombie"]), Vec3::ZERO, 0.0);
    // rust: let mut sword = crate::items::ItemStack::new("minecraft:diamond_sword", 1);
    // rust: sword.data_mut().custom_name = Some(horizon_world::nbt::Tag::String("Old Sword".into()));
    // rust: mob.extra.set_main_hand_stack(Some(sword));
    // rust: let raw = mob_to_nbt(&mob, [1, 2, 3, 4], None, None);
    // rust: let mut loaded = mob_from_nbt(&raw, &types, 2, None).unwrap();
    // rust: assert_eq!(
    // rust: loaded
    // rust: .extra
    // rust: .main_hand_stack()
    // rust: .unwrap()
    // rust: .custom_name()
    // rust: .as_deref(),
    // rust: Some("Old Sword")
    // rust: );
    // rust: loaded
    // rust: .extra
    // rust: .set_main_hand(Some("minecraft:diamond_sword".into()));
    // rust: let saved = mob_to_nbt(&loaded, [1, 2, 3, 4], Some(&raw), None);
    // rust: let restored = mob_from_nbt(&saved, &types, 3, None).unwrap();
    // rust: assert_eq!(
    // rust: restored.extra.main_hand.as_deref(),
    // rust: Some("minecraft:diamond_sword")
    // rust: );
    // rust: assert!(
    // rust: restored
    // rust: .extra
    // rust: .main_hand_stack()
    // rust: .unwrap()
    // rust: .custom_name()
    // rust: .is_none()
    // rust: );
}
}

    // rust: mod mod_thrown_nbt_tests {
//     use super::*;

a_mod_thrown_type_saves_its_id_and_item_and_loads_back :: proc() {
}
    // rust: crate::projectiles::register_test_types();
    // rust: let bolt = crate::projectiles::thrown_type("ruby:bolt").unwrap();
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::Thrown(bolt),
    // rust: Vec3::new(1.0, 80.0, 2.0),
    // rust: None,
    // rust: );
    // rust: p.velocity = Vec3::new(0.0, 0.5, 1.0);
    // rust: assert!(saved_with_chunk(&p));
    // rust: let tag = throwable_to_nbt(&p, [1; 4], None, None).unwrap();
    // rust: assert_eq!(super::kind(&tag).as_deref(), Some("ruby:bolt"));
    // rust: let item = tag.get("Item").and_then(item_from_nbt).unwrap();
    // rust: assert_eq!(&*item.item, "ruby:gem");
    // rust: let back = throwable_from_nbt(&tag, None).unwrap();
    // rust: assert_eq!((&back.kind, back.velocity), (&p.kind, p.velocity));
        // NoGravity comes back too, as for vanilla's (a summoned bolt that floats).
    // rust: p.no_gravity = true;
    // rust: let tag = throwable_to_nbt(&p, [1; 4], None, None).unwrap();
    // rust: assert!(throwable_from_nbt(&tag, None).unwrap().no_gravity);
        // a type no mod declares now is not a thrown kind.
    // rust: assert!(throwable_kind("gone:bolt").is_none());
}
summoned :: proc(id: string, extra: ^[(string) {
}
    // rust: let mut c = vec![
    // rust: ("id", Tag::String(id.into())),
    // rust: ("Pos", doubles(&[0.5, 110.0, 0.5])),
    // rust: ("Motion", doubles(&[0.0, 0.0, 0.0])),
    // rust: ];
    // rust: c.extend(extra.iter().cloned());
    // rust: Tag::compound(c)
}

    // Four summoned kinds had no loader and stayed inert (a spectral arrow,
    // a shulker bullet, a llama's spit and an experience bottle never fell).
summoned_projectiles_of_every_kind_load_and_honour_no_gravity :: proc() {
}
//         use crate::entity_rules::EntityRules;
    // rust: let flag = ("NoGravity", Tag::Byte(1));
    // rust: let arrow = arrow_from_nbt(&summoned("minecraft:spectral_arrow", &[]), None, |_| None)
    // rust: .unwrap()
    // rust: .0;
    // rust: assert!(arrow.is_spectral_arrow() && !arrow.no_gravity);
    // rust: let held = arrow_from_nbt(
    // rust: &summoned("minecraft:spectral_arrow", std::slice::from_ref(&flag)),
    // rust: None,
    // rust: |_| None,
    // rust: )
    // rust: .unwrap()
    // rust: .0;
    // rust: assert!(held.no_gravity);
        // ...and it is saved as the entity type it is.
    // rust: let saved = arrow_to_nbt(&arrow, [1; 4], None, None, None).unwrap();
    // rust: assert_eq!(kind(&saved).as_deref(), Some("minecraft:spectral_arrow"));
    // rust: let plain = arrow_from_nbt(&summoned("minecraft:arrow", &[]), None, |_| None)
    // rust: .unwrap()
    // rust: .0;
    // rust: let saved = arrow_to_nbt(&plain, [1; 4], None, None, None).unwrap();
    // rust: assert_eq!(kind(&saved).as_deref(), Some("minecraft:arrow"));

    // rust: for id in ["minecraft:llama_spit", "minecraft:shulker_bullet"] {
    // rust: let p = spit_or_bullet_from_nbt(&summoned(id, &[]), None).unwrap();
    // rust: assert_eq!(p.kind.id(), id);
    // rust: assert!(!p.no_gravity && p.position == Vec3::new(0.5, 110.0, 0.5));
    // rust: let held =
    // rust: spit_or_bullet_from_nbt(&summoned(id, std::slice::from_ref(&flag)), None).unwrap();
    // rust: assert!(held.no_gravity);
}
    // rust: assert!(spit_or_bullet_from_nbt(&summoned("minecraft:arrow", &[]), None).is_none());
        // a spit and a target-less bullet are saved and selectable (`/data`, `@e`).
    // rust: let spit = spit_or_bullet_from_nbt(&summoned("minecraft:llama_spit", &[]), None).unwrap();
    // rust: assert!(saved_with_chunk(&spit));
    // rust: let saved = spit_or_bullet_to_nbt(&spit, [1; 4], None, None).unwrap();
    // rust: assert_eq!(kind(&saved).as_deref(), Some("minecraft:llama_spit"));

        // A summoned experience bottle flies as the bottle item, with a bottle's gravity.
    // rust: let bottle =
    // rust: throwable_from_nbt(&summoned("minecraft:experience_bottle", &[]), None).unwrap();
    // rust: assert_eq!(bottle.kind.id(), "minecraft:experience_bottle");
    // rust: assert!(!bottle.no_gravity && (bottle.get_gravity() - 0.07).abs() < 1e-12);
    // rust: let held =
    // rust: throwable_from_nbt(&summoned("minecraft:experience_bottle", &[flag]), None).unwrap();
    // rust: assert!(held.no_gravity && held.get_gravity() == 0.0);
    // rust: let saved = throwable_to_nbt(&bottle, [1; 4], None, None).unwrap();
    // rust: assert_eq!(kind(&saved).as_deref(), Some("minecraft:experience_bottle"));
    // rust: let item = saved.get("Item").and_then(item_from_nbt).unwrap();
    // rust: assert_eq!(&*item.item, "minecraft:experience_bottle");
}

no_gravity_survives_save_and_load_for_orbs :: proc() {
}
        // Entity.saveWithoutId / load: NoGravity round-trips on a kind that
        // fall by their own tick (orb, item, arrow, fireball).
    // rust: let mut orb = orbs_from_nbt(&Tag::compound([
    // rust: ("Pos", doubles(&[0.0, 10.0, 0.0])),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: ]))
    // rust: .remove(0);
    // rust: assert!(orb.no_gravity);
    // rust: let back = orbs_from_nbt(&orb_to_nbt(&orb, [1; 4])).remove(0);
    // rust: assert!(back.no_gravity);
    // rust: orb.no_gravity = false;
    // rust: assert!(orb_to_nbt(&orb, [1; 4]).get("NoGravity").is_none());
}
}

    // rust: mod axolotl_memory_ttl_tests {
//     use super::*;

    // rust: fn memory<'a>(tag: &'a Tag, key: &str) -> Option<&'a Tag> {
    // rust: tag.get("Brain")?.get("memories")?.get(key)
}

integer_memory_saves_keep_finite_ttl_and_drop_it_after_a_permanent_write :: proc() {
}
    // rust: for key in [
    // rust: "minecraft:play_dead_ticks",
    // rust: "minecraft:temptation_cooldown_ticks",
    // rust: ] {
    // rust: for ttl in [None, Some(0), Some(1), Some(5), Some(-1), Some(i64::MAX)] {
    // rust: let mut entry = Tag::compound([("value", Tag::Int(100))]);
    // rust: if let Some(ttl) = ttl {
    // rust: put(&mut entry, "ttl", Tag::Long(ttl));
}
    // rust: let raw = Tag::compound([(
    // rust: "Brain",
    // rust: Tag::compound([("memories", Tag::compound([(key, entry)]))]),
    // rust: )]);
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.id = "minecraft:axolotl".into();
    // rust: ty.species = crate::mobs::Species::Axolotl;
    // rust: let mut mob = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: restore_axolotl_memories(&mut mob, &raw);
    // rust: let saved = mob_to_nbt(&mob, [0; 4], Some(&raw), None);
    // rust: let entry = memory(&saved, key).expect("loaded value must be present");
    // rust: assert_eq!(entry.get("value"), Some(&Tag::Int(100)));
    // rust: let expected = ttl.filter(|v| *v != i64::MAX).map(Tag::Long);
    // rust: assert_eq!(entry.get("ttl"), expected.as_ref(), "{key}: {ttl:?}");

                // CountDownCooldownTicks/ValidatePlayDead write ordinary permanent memories.
    // rust: let brain = mob.extra.animal_brain.as_mut().unwrap();
    // rust: if key == "minecraft:play_dead_ticks" {
    // rust: brain.mem.play_dead_ticks.set(99);
    // rust: } else {
    // rust: brain.mem.temptation_cooldown_ticks.set(99);
}
    // rust: let saved = mob_to_nbt(&mob, [0; 4], Some(&raw), None);
    // rust: let entry = memory(&saved, key).unwrap();
    // rust: assert_eq!(entry.get("value"), Some(&Tag::Int(99)));
    // rust: assert!(entry.get("ttl").is_none(), "stale raw TTL must not return");
}
}
}
}

    // rust: mod generic_home_nbt_tests {
//     use super::*;
//     use crate::mobs::Species;

mob :: proc(species: Species, id: string) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.species = species;
    // rust: ty.id = id.into();
    // rust: Mob::new(1, kind, Vec3::new(3.5, 201.0, 0.5), 0.0)
}
stale :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound([
    // rust: ("home_radius", Tag::Int(99)),
    // rust: ("home_pos", Tag::IntArray(vec![90, 91, 92])),
    // rust: ("audit:unrelated", Tag::Int(7)),
    // rust: ])
}

generic_home_output_uses_model_and_removes_stale_raw_fields :: proc() {
}
    // rust: let mut m = mob(Species::Pig, "minecraft:pig");
    // rust: let raw = stale();
    // rust: for raw in [None, Some(&raw)] {
    // rust: for radius in [0, 5, -2, -1] {
    // rust: m.ai.home = Some(([4, 5, 6], radius));
    // rust: let saved = mob_to_nbt(&m, [0; 4], raw, None);
    // rust: if radius == -1 {
    // rust: assert!(saved.get("home_radius").is_none());
    // rust: assert!(saved.get("home_pos").is_none());
    // rust: } else {
    // rust: assert_eq!(saved.get("home_radius"), Some(&Tag::Int(radius)));
    // rust: assert_eq!(saved.get("home_pos"), Some(&Tag::IntArray(vec![4, 5, 6])));
}
}
    // rust: m.ai.home = None;
    // rust: let saved = mob_to_nbt(&m, [0; 4], raw, None);
    // rust: assert!(saved.get("home_radius").is_none());
    // rust: assert!(saved.get("home_pos").is_none());
    // rust: if raw.is_some() {
    // rust: assert_eq!(saved.get("audit:unrelated"), Some(&Tag::Int(7)));
}
}
}

negative_home_updates_retain_position_without_replacing_runtime_ai :: proc() {
}
    // rust: let mut m = mob(Species::Pig, "minecraft:pig");
    // rust: m.ai.home = Some(([4, 5, 6], 5));
    // rust: m.ai.jump = true;
    // rust: m.ai.speed = 0.37;
    // rust: m.ai.no_action_time = 29;
    // rust: for radius in [-2, -1, -2] {
    // rust: read_mob_home(&mut m, &Tag::compound([("home_radius", Tag::Int(radius))]));
    // rust: assert_eq!(m.ai.home, (radius != -1).then_some(([4, 5, 6], radius)));
    // rust: assert_eq!(m.ai.home_position(), [4, 5, 6]);
    // rust: assert!(m.ai.jump);
    // rust: assert_eq!((m.ai.speed, m.ai.no_action_time), (0.37, 29));
}
        // Runtime setters still assign ai.home directly. clearHome must retain
        // that latest live position, rather than a previous load's position.
    // rust: m.ai.home = Some(([7, 8, 9], 5));
    // rust: m.ai.clear_home();
    // rust: assert!(m.ai.home.is_none());
    // rust: read_mob_home(&mut m, &Tag::compound([("home_radius", Tag::Int(-2))]));
    // rust: assert_eq!(m.ai.home, Some(([7, 8, 9], -2)));
}

fresh_home_loads_apply_radius_and_position_codec_defaults :: proc() {
}
    // rust: let m = mob(Species::Pig, "minecraft:pig");
    // rust: let types = [(m.kind.id.clone(), m.kind.clone())].into();
    // rust: for radius in [0, 5, -1, -2] {
    // rust: for pos in [
    // rust: None,
    // rust: Some(Tag::IntArray(vec![4, 5, 6])),
    // rust: Some(Tag::IntArray(vec![4, 5])),
    // rust: ] {
    // rust: let mut raw = Tag::compound([
    // rust: ("id", string("minecraft:pig")),
    // rust: ("Pos", doubles(&[3.5, 201.0, 0.5])),
    // rust: ("home_radius", Tag::Int(radius)),
    // rust: ]);
    // rust: if let Some(pos) = pos.clone() {
    // rust: put(&mut raw, "home_pos", pos);
}
    // rust: let loaded = mob_from_nbt(&raw, &types, 1, None).unwrap();
    // rust: let expected_pos = if radius >= 0 && pos == Some(Tag::IntArray(vec![4, 5, 6])) {
    // rust: [4, 5, 6]
    // rust: } else {
    // rust: [0; 3]
}
    // rust: assert_eq!(
    // rust: loaded.ai.home,
    // rust: (radius != -1).then_some((expected_pos, radius))
    // rust: );
}
}
    // rust: let mut loaded = m;
    // rust: read_mob_home(
    // rust: &mut loaded,
    // rust: &Tag::compound([
    // rust: ("home_radius", Tag::Float((-2.5_f32).to_bits())),
    // rust: ("home_pos", Tag::IntArray(vec![4, 5, 6])),
    // rust: ]),
    // rust: );
    // rust: assert_eq!(loaded.ai.home, Some(([0; 3], -3)));
    // rust: read_mob_home(
    // rust: &mut loaded,
    // rust: &Tag::compound([
    // rust: ("home_radius", Tag::Int(5)),
    // rust: ("home_pos", doubles(&[-2.5, 5.5, 6.5])),
    // rust: ]),
    // rust: );
    // rust: assert_eq!(loaded.ai.home, Some(([-2, 5, 6], 5)));
}

turtle_and_creaking_keep_their_own_home_position_writer :: proc() {
}
    // rust: let raw = stale();
    // rust: for (species, id) in [
    // rust: (Species::Turtle, "minecraft:turtle"),
    // rust: (Species::Creaking, "minecraft:creaking"),
    // rust: ] {
    // rust: let mut m = mob(species, id);
    // rust: m.extra.home = Some([4, 5, 6]);
    // rust: for raw in [None, Some(&raw)] {
    // rust: for home in [None, Some(([7, 8, 9], 5))] {
    // rust: m.ai.home = home;
    // rust: let saved = mob_to_nbt(&m, [0; 4], raw, None);
    // rust: assert_eq!(saved.get("home_pos"), Some(&Tag::IntArray(vec![4, 5, 6])));
    // rust: assert_eq!(
    // rust: saved.get("home_radius"),
    // rust: home.map(|(_, r)| Tag::Int(r)).as_ref()
    // rust: );
}
}
}
}
}

    // rust: mod piglin_live_anger_memory_tests {
//     use super::*;

mob :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.id = "minecraft:piglin".into();
    // rust: ty.species = crate::mobs::Species::Piglin;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}
raw :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound([(
    // rust: "Brain",
    // rust: Tag::compound([
    // rust: ("audit:root", Tag::Int(8)),
    // rust: (
    // rust: "memories",
    // rust: Tag::compound([
    // rust: ("audit:keep", Tag::compound([("value", Tag::Int(7))])),
    // rust: (
    // rust: "minecraft:angry_at",
    // rust: Tag::compound([
    // rust: ("value", Tag::IntArray(vec![90, 91, 92, 93])),
    // rust: ("ttl", Tag::Long(99)),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: )])
}
memory :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: tag.get("Brain")?.get("memories")?.get("minecraft:angry_at")
}
assert_unrelated :: proc(saved: ^Tag) {
}
    // rust: let brain = saved.get("Brain").unwrap();
    // rust: assert_eq!(brain.get("audit:root"), Some(&Tag::Int(8)));
    // rust: assert_eq!(
    // rust: brain.get("memories").unwrap().get("audit:keep"),
    // rust: Some(&Tag::compound([("value", Tag::Int(7))]))
    // rust: );
}

guarded_event_saves_actual_uuid_and_remaining_long_ttl :: proc() {
}
    // rust: let raw = raw();
    // rust: for actor in [[1, 2, 3, 4], [-5, 6, 7, 8]] {
    // rust: let mut m = mob();
    // rust: crate::mobs::piglin::set_guarded_anger_target(&mut m, Some(actor));
    // rust: assert_eq!(m.extra.anger, 600);
    // rust: assert_eq!(m.ai.target, Some(Who::Player));
    // rust: for remaining in [600, 520] {
    // rust: m.extra.anger = remaining;
    // rust: for base in [None, Some(&raw)] {
    // rust: let saved = mob_to_nbt(&m, [42, 43, 44, 45], base, None);
    // rust: assert_eq!(
    // rust: memory(&saved),
    // rust: Some(&Tag::compound([
    // rust: ("value", Tag::IntArray(actor.to_vec())),
    // rust: ("ttl", Tag::Long(i64::from(remaining))),
    // rust: ]))
    // rust: );
    // rust: if base.is_some() {
    // rust: assert_unrelated(&saved);
}
}
}
}
}

expired_owned_memory_cannot_resurrect_stale_raw_anger :: proc() {
}
    // rust: let mut m = mob();
    // rust: crate::mobs::piglin::set_guarded_anger_target(&mut m, Some([1, 2, 3, 4]));
    // rust: m.extra.anger = 0;
    // rust: m.ai.target = None;
    // rust: let saved = mob_to_nbt(&m, [42, 43, 44, 45], Some(&raw()), None);
    // rust: assert!(memory(&saved).is_none());
    // rust: assert_unrelated(&saved);
}

calm_loaded_and_missing_identity_states_are_distinct :: proc() {
}
    // rust: let mut m = mob();
    // rust: assert!(memory(&mob_to_nbt(&m, [42, 43, 44, 45], None, None)).is_none());
    // rust: let raw = raw();
        // Loaded Brain semantics stay outside this live event projection.
    // rust: let untouched = mob_to_nbt(&m, [42, 43, 44, 45], Some(&raw), None);
    // rust: assert_eq!(memory(&untouched), memory(&raw));
    // rust: crate::mobs::piglin::set_guarded_anger_target(&mut m, None);
    // rust: assert_eq!(m.extra.anger, 600);
    // rust: assert_eq!(m.ai.target, Some(Who::Player));
    // rust: let saved = mob_to_nbt(&m, [42, 43, 44, 45], Some(&raw), None);
    // rust: assert!(memory(&saved).is_none());
    // rust: assert_unrelated(&saved);
}
}

    // rust: mod pickup_loot_save_tests {
//     use super::*;
//     use crate::mobs::Species;

pickup_save_uses_live_state_instead_of_raw_and_preserves_overrides :: proc() {
}
    // rust: for (species, id) in [
    // rust: (Species::Pig, "minecraft:pig"),
    // rust: (Species::Allay, "minecraft:allay"),
    // rust: (Species::SulfurCube, "minecraft:sulfur_cube"),
    // rust: ] {
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let ty = Arc::make_mut(&mut kind);
    // rust: ty.id = id.into();
    // rust: ty.species = species;
    // rust: let types = HashMap::from([(id.to_string(), kind)]);
    // rust: for supplied in [None, Some(false), Some(true)] {
    // rust: let mut raw = Tag::compound([
    // rust: ("id", string(id)),
    // rust: ("Pos", doubles(&[4.5, 200.0, 4.5])),
    // rust: ("audit:unrelated", Tag::Int(7)),
    // rust: ]);
    // rust: if let Some(on) = supplied {
    // rust: put(&mut raw, "CanPickUpLoot", Tag::Byte(i8::from(on)));
}
    // rust: let mut mob = mob_from_nbt(&raw, &types, 1, None).unwrap();
    // rust: for live in [false, true] {
    // rust: mob.extra.pick_up_loot = live;
    // rust: mob.extra.main_hand = live.then(|| "minecraft:stone".into());
    // rust: mob.extra.body = live.then(|| "minecraft:stone".into());
    // rust: let expected = if species == Species::SulfurCube {
    // rust: !live
    // rust: } else {
    // rust: live
}
    // rust: for input in [None, Some(&raw)] {
    // rust: let saved = mob_to_nbt(&mob, [46, 0, 0, 1], input, None);
    // rust: assert_eq!(
    // rust: saved.get("CanPickUpLoot"),
    // rust: Some(&Tag::Byte(i8::from(expected))),
    // rust: "{id} supplied={supplied:?} live={live} raw={}",
    // rust: input.is_some()
    // rust: );
    // rust: if input.is_some() {
    // rust: assert_eq!(saved.get("audit:unrelated"), Some(&Tag::Int(7)));
}
}
}
}
}
}
}

    // rust: mod stand_fall_save_tests {
//     use super::*;

decoded_stand_fall_distance_survives_save_without_raw_or_with_stale_raw :: proc() {
}
    // rust: let stale = Tag::compound([("fall_distance", Tag::Double(99.0_f64.to_bits()))]);
    // rust: for no_gravity in [false, true] {
    // rust: for distance in [0.0_f64, 1.25, 17.5] {
    // rust: let input = Tag::compound([
    // rust: ("Pos", doubles(&[4.5, 205.0, 4.5])),
    // rust: ("NoGravity", Tag::Byte(i8::from(no_gravity))),
    // rust: ("fall_distance", Tag::Double(distance.to_bits())),
    // rust: ]);
    // rust: let stand = armor_stand_from_nbt(&input, 1).unwrap();
    // rust: for raw in [None, Some(&stale)] {
    // rust: let saved = armor_stand_to_nbt(&stand, [28, 0, 0, 1], raw);
    // rust: assert_eq!(
    // rust: saved.get("fall_distance"),
    // rust: Some(&Tag::Double(distance.to_bits())),
    // rust: "distance={distance} no_gravity={no_gravity} raw={}",
    // rust: raw.is_some()
    // rust: );
    // rust: assert_eq!(saved.get("Pos"), input.get("Pos"));
    // rust: assert_eq!(stand.no_gravity, no_gravity);
}
}
}
}
}
