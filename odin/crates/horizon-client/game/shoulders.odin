//! Transpiled from Horizon Rust crate
package horizon_client_shoulders

import "core:fmt"
import "core:mem"
import "core:math"

// Parrots on a player's shoulder: a tame parrot lands on its owner
// (`LandOnOwnersShoulderGoal`), is kept as the player's `ShoulderEntityLeft`
// or `ShoulderEntityRight`, and flies off again when the player is hurt,
// falls, swims, flies or sleeps (`ServerPlayer.handleShoulderEntities`).
// use super::Game;
// use horizon_client::mobs::Species;
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use horizon_world::nbt::Tag;

KEYS :: ["ShoulderEntityLeft", "ShoulderEntityRight"]

// A shoulder slot holds a parrot when its compound is not empty.
occupied :: proc(extra: ^Tag, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(extra.get(key), Some(Tag::Compound(c)) if !c.is_empty())
}

// `ServerPlayer.extractParrotVariant` for both slots: the variant of the
// parrot kept there (`Parrot.Variant.byId` clamps the saved `Variant`, 0
// when absent), `None` for an empty slot or another entity.
    // rust: pub(super) fn shoulder_variants(extra: Option<&Tag>) -> [Option<i32>; 2] {
    // rust: KEYS.map(|key| {
    // rust: let parrot = extra?.get(key)?;
    // rust: match parrot.get("id") {
    // rust: Some(Tag::String(id)) if id.to_string_lossy() == "minecraft:parrot" => {}
    // rust: _ => return None,
}
    // rust: Some(match parrot.get("Variant") {
    // rust: Some(Tag::Int(v)) => (*v).clamp(0, 4),
    // rust: _ => 0,
    // rust: })
    // rust: })
}

    // rust: impl Game<'_> {
    // `ServerPlayer.setEntityOnShoulder` for a parrot that touched its
    // owner: stored in the first free slot, the parrot gone from the world.
    // rust: pub(super) fn parrot_to_shoulder(&mut self, mob: u32) {
    // rust: let Some(i) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .position(|m| m.id == mob && m.alive() && !m.removed && m.species() == Species::Parrot)
    // rust: else {
    // rust: return;
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
        // The acting player must be the saved owner (`getOwner`).
    // rust: if !horizon_client::mobs::tame::owned_by(self.mobs[i].extra.owner, self.acting_uuid()) {
    // rust: return;
}
    // rust: if self.riding.is_some()
    // rust: || !p.ground.on_ground
    // rust: || p.fluids.was_touching_water
    // rust: || p.in_powder_snow
    // rust: || p.flying
    // rust: {
    // rust: return;
}
    // rust: let extra = self
    // rust: .level
    // rust: .player_extra
    // rust: .get_or_insert_with(|| Tag::Compound(Default::default()));
    // rust: let Some(key) = KEYS.into_iter().find(|k| !occupied(extra, k)) else {
    // rust: return;
}
    // rust: let tag = self.mob_tree_nbt(i);
    // rust: if let Some(Tag::Compound(map)) = self.level.player_extra.as_mut() {
    // rust: map.insert(key.into(), tag);
}
    // rust: let (uuid, now) = (self.acting_uuid(), self.world.game_time);
    // rust: self.creatures.shoulder_time.insert(uuid, now);
    // rust: self.mobs[i].removed = true;
}

    // `ServerPlayer.handleShoulderEntities`: the parrots leave the shoulder
    // of a player who falls, swims, flies, sleeps, is hurt, dying, a
    // spectator or spinning with a riptide.
    // rust: pub(super) fn handle_shoulder_entities(&mut self) {
    // rust: for key in KEYS {
    // rust: self.play_shoulder_entity_ambient_sound(key);
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let any = self
    // rust: .level
    // rust: .player_extra
    // rust: .as_ref()
    // rust: .is_some_and(|e| KEYS.iter().any(|k| occupied(e, k)));
    // rust: if any
    // rust: && (p.fall_distance > 0.5
    // rust: || p.fluids.was_touching_water
    // rust: || p.flying
    // rust: || p.spectator
    // rust: || p.in_powder_snow
    // rust: || p.auto_spin_attack_ticks > 0
    // rust: || p.health.hurt.hurt_time > 0
    // rust: || p.health.dead_or_dying()
    // rust: || self.sleeping.is_some())
    // rust: {
    // rust: self.remove_entities_on_shoulder();
}
}

    // `ServerPlayer.playShoulderEntityAmbientSound`: a parrot that is not
    // `Silent` chirps or imitates a mob within 20 blocks, one tick in 200
    // (drawn from the level's random; the player's own is not kept).
play_shoulder_entity_ambient_sound :: proc(self: ^Self, key: string) {
}
    // rust: let Some(Tag::Compound(tag)) = self.level.player_extra.as_ref().and_then(|e| e.get(key))
    // rust: else {
    // rust: return;
}
    // rust: let silent = matches!(tag.get(&"Silent".into()), Some(Tag::Byte(b)) if *b != 0);
    // rust: let parrot = matches!(
    // rust: tag.get(&"id".into()),
    // rust: Some(Tag::String(id)) if id.to_string_lossy() == "minecraft:parrot"
    // rust: );
    // rust: if tag.is_empty() || silent || self.world.random.next_int_bound(200).unwrap_or(1) != 0 {
    // rust: return;
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: if !parrot {
    // rust: return;
}
    // rust: let area = p.bounds().inflate(Vec3::new(20.0, 20.0, 20.0));
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: let alive = !p.health.dead_or_dying();
    // rust: let nearby: Vec<_> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive() && !m.removed && m.bounds().intersects(area))
    // rust: .map(|m| (m.species(), m.silent))
    // rust: .collect();
    // rust: let peaceful = self.ui.difficulty == 0;
    // rust: if let Some((sound, volume, pitch)) = horizon_client::mobs::parrot::shoulder_sound(
    // rust: &mut self.world.random,
    // rust: alive,
    // rust: false,
    // rust: peaceful,
    // rust: &nearby,
    // rust: ) {
    // rust: self.audio
    // rust: .play(&format!("minecraft:{sound}"), Some(at), volume, pitch);
}
}

    // `ServerPlayer.removeEntitiesOnShoulder` (not within a second of the
    // landing) and `respawnEntityOnShoulder`: the parrots come back at the
    // player, still owned by them.
remove_entities_on_shoulder :: proc(self: ^Self) {
}
    // rust: let (uuid, now) = (self.acting_uuid(), self.world.game_time);
    // rust: if self
    // rust: .creatures
    // rust: .shoulder_time
    // rust: .get(&uuid)
    // rust: .is_some_and(|t| t + 20 >= now)
    // rust: {
    // rust: return;
}
    // rust: let Some(p) = self.player.as_ref().map(|p| p.position) else {
    // rust: return;
}
    // rust: let Some(Tag::Compound(map)) = self.level.player_extra.as_mut() else {
    // rust: return;
}
    // rust: let tags: Vec<Tag> = KEYS
    // rust: .iter()
    // rust: .filter_map(|k| map.remove(&(*k).into()))
    // rust: .collect();
    // rust: let pos = [p.x, p.y + f64::from(0.7_f32), p.z];
    // rust: for mut tag in tags {
    // rust: let Tag::Compound(c) = &mut tag else {
    // rust: continue;
}
    // rust: if c.is_empty() {
    // rust: continue;
}
    // rust: c.insert(
    // rust: "Pos".into(),
    // rust: Tag::List(pos.iter().map(|v| Tag::Double(v.to_bits())).collect()),
    // rust: );
    // rust: c.insert("Owner".into(), Tag::IntArray(uuid.to_vec()));
    // rust: self.load_mob(tag, None);
}
}
}

    // rust: mod variant_tests {
//     use super::*;
shoulder_slots_hold_parrots_by_variant :: proc() {
}
    // rust: let parrot = |variant: Option<i32>, id: &str| {
    // rust: let mut entries = vec![("id", Tag::String(id.into()))];
    // rust: if let Some(v) = variant {
    // rust: entries.push(("Variant", Tag::Int(v)));
}
    // rust: Tag::compound(entries)
}
    // rust: let extra = Tag::compound([
    // rust: ("ShoulderEntityLeft", parrot(Some(9), "minecraft:parrot")),
    // rust: ("ShoulderEntityRight", parrot(None, "minecraft:parrot")),
    // rust: ]);
        // Variant.byId clamps; a parrot saved without one is the first.
    // rust: assert_eq!(shoulder_variants(Some(&extra)), [Some(4), Some(0)]);
    // rust: let other = Tag::compound([("ShoulderEntityRight", parrot(Some(1), "minecraft:cat"))]);
    // rust: assert_eq!(shoulder_variants(Some(&other)), [None, None]);
    // rust: assert_eq!(shoulder_variants(None), [None, None]);
}
}
