//! Transpiled from Horizon Rust crate
package horizon_client_data

import "core:fmt"
import "core:mem"
import "core:math"

// `/data` (DataCommands), `/tag` (TagCommand) and `/summon` with NBT: entity,
// block entity and storage data accessors over the game state.
// use super::{Arg, Context, Game, R, Target, err};
// use horizon_client::{
    // rust: data_cmd::{self, Op, path_error},
    // rust: entity_nbt,
    // rust: nbt_path::NbtPath,
    // rust: save::{self, random_uuid},
    // rust: scoreboard_cmd::{Holder, Tracker, format_list},
    // rust: snbt,
    // rust: text::Text,
}
// use horizon_world::nbt::{Compound, JavaString, Tag, parse_snbt};

// A `DataAccessor`.
    // rust: pub(in crate::game) enum DataRef {
    // rust: Entity(Target),
    // rust: Block([i32; 3]),
    // rust: Storage(String),
}

empty :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::Compound(Compound::new())
}
set_key :: proc(tag: ^Tag, key: string, value: Tag) {
}
    // rust: if let Tag::Compound(c) = tag {
    // rust: c.insert(JavaString::from(key), value);
}
}
// `EntityType.loadEntityRecursive` snaps every entity of the stack,
// passengers included, to the position (`/summon`, `native_summon`).
    // rust: pub(in crate::game) fn place_summoned(tag: &mut Tag, pos: [f64; 3]) {
    // rust: let p = pos.map(|v| Tag::Double(v.to_bits()));
    // rust: set_key(tag, "Pos", Tag::List(p.to_vec()));
    // Entity.load: an absent Fire reads as 0 (until the entity moves).
    // rust: if tag.get("Fire").is_none() {
    // rust: set_key(tag, "Fire", Tag::Short(0));
}
    // rust: if tag.get("Rotation").is_none() {
    // rust: set_key(
    // rust: tag,
    // rust: "Rotation",
    // rust: Tag::List(vec![
    // rust: Tag::Float(0.0f32.to_bits()),
    // rust: Tag::Float(0.0f32.to_bits()),
    // rust: ]),
    // rust: );
}
    // rust: if let Tag::Compound(c) = tag
    // rust: && let Some(Tag::List(riders)) = c.get_mut(&"Passengers".into())
    // rust: {
    // rust: for r in riders {
    // rust: if matches!(r, Tag::Compound(_)) {
    // rust: place_summoned(r, pos);
}
}
}
}

    // rust: impl Game<'_> {
    // ---- entity data ---------------------------------------------------

    // `NbtPredicate.getEntityTagToCompare`: the entity as saved. An entity
    // in another level is read in the level that holds it.
    // rust: pub(in crate::game) fn entity_nbt(&mut self, t: Target) -> Option<Tag> {
    // rust: self.in_target_level(t, |g| g.entity_nbt_in_level(t))
    // rust: .flatten()
}
    // The acting player's own UUID: a guest's turn (the window's player on
    // the server thread) keeps the world owner's in `level`.
saved_player_uuid :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.lan_acting_uuid
    // rust: .map(horizon_client::lan::playerdata::uuid_ints)
    // rust: .or(self.level.player_uuid)
}
    // [`Self::entity_nbt`] of the player whose turn it is.
    // rust: pub(in crate::game) fn player_nbt(&mut self) -> Option<Tag> {
    // rust: self.player.as_ref()?;
    // rust: self.sync_level();
    // rust: let mut tag = self.level.player_tag();
    // rust: if let Some(u) = self.saved_player_uuid() {
    // rust: set_key(&mut tag, "UUID", Tag::IntArray(u.to_vec()));
}
        // NbtPredicate.getEntityTagToCompare: a player's held stack.
    // rust: let selected = self.level.selected_slot;
    // rust: let held = match tag.get("Inventory") {
    // rust: Some(Tag::List(items)) => items
    // rust: .iter()
    // rust: .find(|i| matches!(i.get("Slot"), Some(Tag::Byte(b)) if i32::from(*b) == selected))
    // rust: .cloned(),
    // rust: _ => None,
}
    // rust: if let Some(mut stack) = held {
    // rust: if let Tag::Compound(c) = &mut stack {
    // rust: c.remove(&"Slot".into());
}
    // rust: set_key(&mut tag, "SelectedItem", stack);
}
    // rust: Some(tag)
}
entity_nbt_in_level :: proc(self: ^Self, t: Target) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let player_uuid = self.saved_player_uuid();
    // rust: Some(match t {
    // rust: Target::Guest(_) => {
    // rust: return self
    // rust: .for_player(t, |g| g.entity_nbt(Target::Player))
    // rust: .flatten();
}
    // rust: Target::Player => return self.player_nbt(),
    // rust: Target::Mob(id) => {
                // `saveWithoutId` writes the entity as saved, riders under
                // `Passengers`: `/data get` reads the same tree persistence does (#1519).
    // rust: let i = self.mobs.iter().position(|m| m.id == id)?;
    // rust: self.mob_tree_nbt(i)
}
    // rust: Target::Item(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let e = self.dropped.iter().find(|e| e.id == id)?;
    // rust: entity_nbt::item_entity_to_nbt(e, uuid, self.persist.raw.get(&id))
}
    // rust: Target::Stand(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let a = self.armor_stands.iter().find(|a| a.id == id)?;
    // rust: entity_nbt::armor_stand_to_nbt(a, uuid, self.persist.raw.get(&id))
}
    // rust: Target::Frame(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let f = self.item_frames.iter().find(|f| f.id == id)?;
    // rust: entity_nbt::item_frame_to_nbt(f, uuid, self.persist.raw.get(&id))
}
    // rust: Target::Painting(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let p = self.paintings.iter().find(|p| p.id == id)?;
    // rust: entity_nbt::painting_to_nbt(p, uuid, self.persist.raw.get(&id))
}
    // rust: Target::Boat(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let b = self.boats.iter().find(|b| b.id == id)?;
    // rust: entity_nbt::boat_to_nbt(
    // rust: &b.entity_type(),
    // rust: b.position,
    // rust: b.velocity,
    // rust: [b.yaw, b.pitch],
    // rust: uuid,
    // rust: self.persist.raw.get(&id),
    // rust: b.chest.then_some(&b.items[..]),
    // rust: )
}
    // rust: Target::Cart(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let c = self.carts.iter().find(|c| c.id == id)?;
    // rust: c.to_nbt(uuid, self.persist.raw.get(&id))
}
    // rust: Target::Fangs(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let f = self.fangs.list.iter().find(|f| f.id == id)?;
    // rust: self.fangs_to_nbt(f, uuid)
}
    // rust: Target::Other(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let o = self.others.iter().find(|o| o.id == id)?.clone();
    // rust: self.other_to_nbt(&o, uuid)
}
    // rust: Target::Orb(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let tag = entity_nbt::orb_to_nbt(self.orbs.iter().find(|o| o.id == id)?, uuid);
    // rust: crate::game::persist::with_raw(tag, self.persist.raw.get(&id))
}
    // rust: Target::Projectile(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let p = self.creatures.projectiles.iter().find(|p| p.id == id)?;
    // rust: let owner = if p.owner == Some(horizon_client::mobs::Who::Player) {
    // rust: player_uuid
    // rust: } else {
    // rust: None
}
    // rust: let in_block = p
    // rust: .arrow
    // rust: .as_ref()
    // rust: .and_then(|a| a.last_state)
    // rust: .map(|s| self.state_to_nbt(s));
    // rust: let raw = self.persist.raw.get(&id);
    // rust: entity_nbt::arrow_to_nbt(p, uuid, owner, in_block, raw)
    // rust: .or_else(|| entity_nbt::fireball_to_nbt(p, uuid, owner, raw))
    // rust: .or_else(|| entity_nbt::throwable_to_nbt(p, uuid, owner, raw))
    // rust: .or_else(|| entity_nbt::spit_or_bullet_to_nbt(p, uuid, owner, raw))?
}
    // rust: Target::Crystal(id) => {
    // rust: let c = self.crystals.iter().find(|c| c.id == id)?;
    // rust: let raw = self.persist_anon("minecraft:end_crystal", c.position);
    // rust: let uuid = self.persist.uuids.get(&id).copied();
    // rust: let tag = c.to_nbt(uuid.unwrap_or_else(random_uuid), raw);
    // rust: crate::game::persist::with_raw(tag, self.persist.raw.get(&id))
}
    // rust: Target::Dragon(id) => {
    // rust: let d = self.dragon.as_ref().filter(|d| d.id == id)?;
    // rust: let raw = self.persist_anon("minecraft:ender_dragon", d.position);
    // rust: let uuid = self.persist.uuids.get(&id).copied();
    // rust: let tag = d.to_nbt(uuid.unwrap_or_else(random_uuid), raw);
    // rust: crate::game::persist::with_raw(tag, self.persist.raw.get(&id))
}
    // rust: Target::Tnt(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let t = self.tnts.iter().find(|t| t.id == id)?;
    // rust: entity_nbt::tnt_to_nbt(
    // rust: t.position,
    // rust: t.velocity,
    // rust: t.on_ground,
    // rust: t.fuse,
    // rust: t.power,
    // rust: t.block_state_nbt(self.pack.assets.registry),
    // rust: t.rotation,
    // rust: uuid,
    // rust: self.persist.raw.get(&id),
    // rust: )
}
    // rust: Target::Falling(id) => {
    // rust: let f = self.falling.iter().find(|f| f.id == id)?.clone();
    // rust: let (uuid, raw) = match &f.saved {
    // rust: Some(saved) => (saved.0, Some(&saved.1)),
    // rust: None => (self.uuid_for(id), None),
}
    // rust: let tag = entity_nbt::falling_block_to_nbt(
    // rust: self.state_to_nbt(f.state),
    // rust: f.position,
    // rust: f.velocity,
    // rust: f.age,
    // rust: f.drop_item,
    // rust: f.damage,
    // rust: f.fall_distance,
    // rust: f.rotation,
    // rust: uuid,
    // rust: );
    // rust: crate::game::persist::with_raw(tag, raw)
}
    // rust: Target::Rocket(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let r = self.rockets.iter().find(|r| r.id == id)?;
    // rust: r.to_nbt(uuid, player_uuid, self.persist.raw.get(&id))
}
    // rust: Target::Cloud(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let c = self.breath_clouds.iter().find(|c| c.id == id)?;
    // rust: let [x, y, z] = c.at;
                // Read the live cloud, including its current radius and age;
                // the raw compound alone does not contain generated clouds.
    // rust: let mut tag = self.other_to_nbt(
    // rust: &super::OtherEntity {
    // rust: id,
    // rust: kind: "minecraft:area_effect_cloud".into(),
    // rust: position: horizon_core::geometry::Vec3::new(x, y, z),
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: },
    // rust: uuid,
    // rust: );
    // rust: set_key(&mut tag, "Age", Tag::Int(c.age));
    // rust: set_key(&mut tag, "Duration", Tag::Int(c.duration));
    // rust: set_key(&mut tag, "Radius", Tag::Float(c.radius.to_bits()));
    // rust: let wait = c.potion.as_ref().map_or(20, |p| p.settings.wait_time);
    // rust: set_key(&mut tag, "WaitTime", Tag::Int(wait));
    // rust: if let Some(p) = &c.potion {
    // rust: set_key(
    // rust: &mut tag,
    // rust: "ReapplicationDelay",
    // rust: Tag::Int(p.settings.reapplication_delay),
    // rust: );
    // rust: set_key(
    // rust: &mut tag,
    // rust: "DurationOnUse",
    // rust: Tag::Int(p.settings.duration_on_use),
    // rust: );
    // rust: set_key(
    // rust: &mut tag,
    // rust: "RadiusOnUse",
    // rust: Tag::Float(p.settings.radius_on_use.to_bits()),
    // rust: );
    // rust: set_key(
    // rust: &mut tag,
    // rust: "RadiusPerTick",
    // rust: Tag::Float(p.radius_per_tick.to_bits()),
    // rust: );
    // rust: if p.settings.duration_scale != 1.0 {
    // rust: set_key(
    // rust: &mut tag,
    // rust: "potion_duration_scale",
    // rust: Tag::Float(p.settings.duration_scale.to_bits()),
    // rust: );
    // rust: } else if let Tag::Compound(c) = &mut tag {
    // rust: c.remove(&"potion_duration_scale".into());
}
}
    // rust: tag
}
    // rust: Target::Trident(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let t = self.tridents.iter().find(|t| t.id == id)?;
    // rust: t.to_nbt(uuid, self.persist.raw.get(&id))
}
    // rust: Target::Spawner(id) => {
    // rust: let s = self.ominous_spawners.iter().find(|s| s.id == id)?;
    // rust: let [x, y, z] = s.position;
    // rust: entity_nbt::ominous_item_spawner_to_nbt(
    // rust: &s.item,
    // rust: horizon_core::geometry::Vec3::new(x, y, z),
    // rust: s.spawn_item_after,
    // rust: s.uuid,
    // rust: s.raw.as_deref(),
    // rust: )
}
    // rust: })
}
    // `Entity.load` of new data (`EntityDataAccessor.setData`): the entity is
    // rebuilt from its compound, keeping its id and UUID. Also what
    // `TypedEntityData.loadInto` is: a spawn egg's data on the mob it spawned.
    // rust: pub(in crate::game) fn apply_entity_nbt(&mut self, t: Target, mut tag: Tag) -> R<()> {
    // rust: let stale = || err("commands.data.merge.failed", &[]);
    // rust: match t {
            // EntityDataAccessor.setData: players can't be modified, guests neither.
    // rust: Target::Player | Target::Guest(_) => {
    // rust: return Err(err("commands.data.entity.invalid", &[]));
}
    // rust: Target::Mob(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let kind = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| m.kind.id.clone());
    // rust: set_key(&mut tag, "UUID", Tag::IntArray(uuid.to_vec()));
    // rust: if let Some(k) = kind {
    // rust: set_key(&mut tag, "id", Tag::String(k.as_str().into()));
}
    // rust: let new = entity_nbt::mob_from_nbt(
    // rust: &tag,
    // rust: self.res.mob_types(),
    // rust: id,
    // rust: Some(self.pack.assets.registry),
    // rust: )
    // rust: .ok_or_else(stale)?;
    // rust: if let Some(slot) = self.mobs.iter_mut().find(|m| m.id == id) {
                    // LivingEntity.readAdditionalSaveData only replaces a decoded
                    // Brain. Keep the Allay's modeled LIKED_PLAYER when the
                    // required root memory map cannot load; valid empty maps clear it.
    // rust: let keep_liked_player = slot.species() == horizon_client::mobs::Species::Allay
    // rust: && !matches!(
    // rust: tag.get("Brain").and_then(|brain| brain.get("memories")),
    // rust: Some(Tag::Compound(_))
    // rust: );
                    // Runtime-only state (AI, animation) carries over.
    // rust: let old = std::mem::replace(slot, new);
    // rust: if keep_liked_player {
    // rust: slot.extra.tame = old.extra.tame;
    // rust: slot.extra.owner = old.extra.owner;
}
                    // Entity.load mutates the existing living entity; its damage
                    // cooldown and previous-hit amount are not read from saved NBT.
    // rust: slot.invulnerable = old.invulnerable;
    // rust: slot.last_hurt = old.last_hurt;
    // rust: slot.ai = old.ai;
                    // Mob.readAdditionalSaveData updates persistent home fields,
                    // while retaining the rest of the live AI/runtime state.
    // rust: entity_nbt::read_mob_home(slot, &tag);
    // rust: slot.extra.armor_attributes = old.extra.armor_attributes;
    // rust: slot.age = old.age;
    // rust: slot.previous = slot.position;
                    // Wolf.readAdditionalSaveData initializes persistent anger at
                    // the live level clock, just as load_mob does on admission.
    // rust: if slot.species() == horizon_client::mobs::Species::Wolf {
    // rust: slot.extra.anger = horizon_client::mobs::anger_left(
    // rust: slot.extra.anger_end,
    // rust: self.world.game_time,
    // rust: );
}
}
}
    // rust: Target::Item(id) => {
    // rust: let new = entity_nbt::item_entity_from_nbt(&tag, id, 0.0).ok_or_else(stale)?;
    // rust: if let Some(slot) = self.dropped.iter_mut().find(|e| e.id == id) {
    // rust: let bob = slot.bob_offset;
    // rust: *slot = new;
    // rust: slot.bob_offset = bob;
}
}
    // rust: Target::Fangs(id) => {
    // rust: let owner = self.loaded_fangs_owner(&tag);
    // rust: let at = entity_nbt::position(&tag).ok_or_else(stale)?;
    // rust: if let Some(f) = self.fangs.list.iter_mut().find(|f| f.id == id) {
    // rust: f.pos = [at.x, at.y, at.z];
    // rust: f.yaw = entity_nbt::rotation(&tag)[0];
    // rust: f.warmup = horizon_client::save::number(tag.get("Warmup")).unwrap_or(0) as i32;
    // rust: f.owner = owner;
}
}
    // rust: Target::Stand(id) => {
    // rust: let mut new = entity_nbt::armor_stand_from_nbt(&tag, id).ok_or_else(stale)?;
    // rust: if let Some(slot) = self.armor_stands.iter_mut().find(|a| a.id == id) {
                    // Entity.load keeps the existing entity's firstTick state.
    // rust: new.first_tick = slot.first_tick;
    // rust: *slot = new;
}
}
    // rust: Target::Frame(id) => {
    // rust: let mut new = entity_nbt::item_frame_from_nbt(&tag, id).ok_or_else(stale)?;
    // rust: if let Some(i) = self.item_frames.iter().position(|f| f.id == id) {
    // rust: let old = &self.item_frames[i];
                    // Entity.load cannot change the runtime type; saveWithoutId
                    // deliberately omitted the decoder's type discriminator.
    // rust: new.glow = old.glow;
                    // ItemFrame.readAdditionalSaveData: ItemStack.matches includes
                    // count, item and components, before adopting the new stack.
    // rust: if old.item.as_ref().is_some_and(|a| {
    // rust: new.item
    // rust: .as_ref()
    // rust: .is_none_or(|b| a.count != b.count || !a.same_item_same_components(b))
    // rust: }) {
    // rust: let old = old.clone();
    // rust: self.remove_framed_map(&old);
}
    // rust: self.item_frames[i] = new;
}
}
    // rust: Target::Boat(id) => {
                // AbstractBoat.readAdditionalSaveData over Entity.load: the
                // position, rotation, motion, NoGravity and a chest boat's items.
    // rust: let (position, velocity, yaw) =
    // rust: entity_nbt::boat_from_nbt(&tag).ok_or_else(stale)?;
    // rust: let uuid = self.uuid_for(id);
    // rust: let b = self
    // rust: .boats
    // rust: .iter_mut()
    // rust: .find(|b| b.id == id)
    // rust: .ok_or_else(stale)?;
    // rust: b.position = position;
    // rust: b.previous = position;
    // rust: b.velocity = velocity;
    // rust: b.yaw = yaw;
    // rust: b.previous_yaw = yaw;
    // rust: b.pitch = entity_nbt::rotation(&tag)[1];
    // rust: b.no_gravity = entity_nbt::flag(&tag, "NoGravity");
    // rust: if b.chest {
    // rust: b.items = save::decode_items(tag.get("Items"), crate::game::boats::CHEST_SLOTS);
}
    // rust: set_key(&mut tag, "UUID", Tag::IntArray(uuid.to_vec()));
}
    // rust: Target::Cart(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let i = self
    // rust: .carts
    // rust: .iter()
    // rust: .position(|c| c.id == id)
    // rust: .ok_or_else(stale)?;
    // rust: let mut cart = self.carts[i].clone();
    // rust: cart.load(&tag).ok_or_else(stale)?;
    // rust: crate::game::minecarts::forget_unreadable_display(&mut cart, |t| {
    // rust: self.state_from_nbt(t).is_some()
    // rust: });
    // rust: self.roll_cart_loot(&mut cart, &tag);
    // rust: self.carts[i] = cart;
    // rust: set_key(&mut tag, "UUID", Tag::IntArray(uuid.to_vec()));
}
    // rust: Target::Other(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let marker = self
    // rust: .others
    // rust: .iter_mut()
    // rust: .find(|o| {
    // rust: o.id == id && matches!(o.kind.as_str(), "minecraft:marker" | "marker")
    // rust: })
    // rust: .ok_or_else(stale)?;
    // rust: let position = entity_nbt::position(&tag).ok_or_else(stale)?;
    // rust: let [yaw, pitch] = entity_nbt::rotation(&tag);
    // rust: marker.position = position;
    // rust: marker.yaw = yaw;
    // rust: marker.pitch = pitch;
                // Keep the existing marker identity even when the input edits UUID or id.
    // rust: set_key(&mut tag, "UUID", Tag::IntArray(uuid.to_vec()));
    // rust: set_key(&mut tag, "id", Tag::String(marker.kind.as_str().into()));
}
    // rust: _ => return Err(stale()),
}
    // rust: if let Target::Mob(id)
    // rust: | Target::Item(id)
    // rust: | Target::Stand(id)
    // rust: | Target::Frame(id)
    // rust: | Target::Boat(id)
    // rust: | Target::Cart(id)
    // rust: | Target::Other(id)
    // rust: | Target::Fangs(id) = t
    // rust: {
    // rust: self.persist.raw.insert(id, tag);
}
    // rust: Ok(())
}
    // rust: pub(in crate::game) fn data_block_name(&self, p: [i32; 3]) -> String {
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .map_or_else(|| "minecraft:air".into(), |s| s.name.to_string())
}
raw_mut :: proc(self: ^Self, t: Target) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Target::Player => Some(self.level.player_extra.get_or_insert_with(empty)),
    // rust: Target::Guest(conn) => self
    // rust: .lan
    // rust: .as_mut()?
    // rust: .hub
    // rust: .guests
    // rust: .iter_mut()
    // rust: .find(|g| g.conn == conn)
    // rust: .map(|g| g.saved.get_or_insert_with(empty)),
    // rust: Target::Mob(id)
    // rust: | Target::Item(id)
    // rust: | Target::Stand(id)
    // rust: | Target::Frame(id)
    // rust: | Target::Painting(id)
    // rust: | Target::Boat(id)
    // rust: | Target::Cart(id)
            // `tags_of` reads a primed TNT's compound; without this arm
            // `/tag` wrote nothing and still reported success.
    // rust: | Target::Tnt(id)
    // rust: | Target::Orb(id)
    // rust: | Target::Projectile(id)
    // rust: | Target::Crystal(id)
    // rust: | Target::Dragon(id)
    // rust: | Target::Other(id)
    // rust: | Target::Fangs(id)
    // rust: | Target::Cloud(id) => Some(self.persist.raw.entry(id).or_insert_with(empty)),
            // `tags_of` reads these two from the same map and a falling
            // block from its saved compound; without these arms `/tag`
            // wrote nothing and still reported success.
    // rust: Target::Rocket(id) | Target::Trident(id) => {
    // rust: Some(self.persist.raw.entry(id).or_insert_with(empty))
}
    // rust: Target::Falling(id) => {
    // rust: let uuid = self.uuid_for(id);
    // rust: let f = self.falling.iter_mut().find(|f| f.id == id)?;
    // rust: Some(&mut f.saved.get_or_insert_with(|| Box::new((uuid, empty()))).1)
}
    // rust: _ => None,
}
}
    // Writes `t`'s `Tags`; false when its kind keeps no saved compound to
    // write them to.
    // rust: pub(in crate::game) fn set_entity_tags(&mut self, t: Target, tags: &[String]) -> bool {
    // rust: let Some(raw) = self.raw_mut(t) else {
    // rust: return false;
}
    // rust: let list = tags
    // rust: .iter()
    // rust: .map(|s| Tag::String(s.as_str().into()))
    // rust: .collect();
    // rust: set_key(raw, "Tags", Tag::List(list));
    // rust: true
}

    // `ComparatorBlockEntity.saveAdditional`: expose the circuit's live output,
    // rather than keeping a second copy in the ordinary block entity map.
comparator_data :: proc(self: ^Self, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.data_block_name(p) != "minecraft:comparator" {
    // rust: return None;
}
    // rust: let pos = horizon_core::position::BlockPos::new(p[0], p[1], p[2]);
    // rust: let output = self
    // rust: .block_ticks
    // rust: .comparator_outputs
    // rust: .get(&pos)
    // rust: .copied()
    // rust: .unwrap_or(0);
    // rust: Some(Tag::compound([
    // rust: ("id", Tag::String("minecraft:comparator".into())),
    // rust: ("x", Tag::Int(p[0])),
    // rust: ("y", Tag::Int(p[1])),
    // rust: ("z", Tag::Int(p[2])),
    // rust: ("components", empty()),
    // rust: ("OutputSignal", Tag::Int(output)),
    // rust: ]))
}

    // ---- accessors -----------------------------------------------------

    // The `role`th provider of the command (`entity`, `block` or `storage`).
    // rust: pub(in crate::game) fn data_ref(&mut self, ctx: &Context, role: usize) -> R<DataRef> {
    // rust: let prefix = if role == 0 { "target" } else { "source" };
    // rust: self.data_ref_named(ctx, role, prefix)
}
    // `PistonMovingBlockEntity.saveAdditional`, with full command metadata.
moving_piston_data :: proc(self: ^Self, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let pos = horizon_core::position::BlockPos::new(p[0], p[1], p[2]);
    // rust: let (_, piston) = self
    // rust: .block_ticks
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .find(|(at, _)| *at == pos)?;
    // rust: let mut tag = self.moving_piston_to_nbt(pos, piston);
        // BlockEntity.saveWithoutMetadata includes the component map.
    // rust: set_key(&mut tag, "components", empty());
    // rust: Some(tag)
}
    // rust: pub(in crate::game) fn data_ref_named(
    // rust: &mut self,
    // rust: ctx: &Context,
    // rust: role: usize,
    // rust: prefix: &str,
    // rust: ) -> R<DataRef> {
    // rust: let kind = ctx
    // rust: .literals
    // rust: .iter()
    // rust: .filter(|l| matches!(l.as_str(), "entity" | "block" | "storage"))
    // rust: .nth(role)
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: match kind.as_str() {
    // rust: "entity" => {
    // rust: let Some(Arg::Entity(sel)) = ctx.get(prefix).cloned() else {
    // rust: return Err(err("argument.entity.notfound.entity", &[]));
}
    // rust: let found = self.select(&sel);
    // rust: found
    // rust: .first()
    // rust: .map(|t| DataRef::Entity(*t))
    // rust: .ok_or_else(|| err("argument.entity.notfound.entity", &[]))
}
    // rust: "block" => {
    // rust: let p = self.block_pos_arg(ctx, &format!("{prefix}Pos"))?;
    // rust: if !self.world.block_entities.contains_key(&(p[0], p[1], p[2]))
    // rust: && self.comparator_data(p).is_none()
    // rust: && self.pot_data(p).is_none()
    // rust: && self.moving_piston_data(p).is_none()
    // rust: {
    // rust: return Err(err("commands.data.block.invalid", &[]));
}
    // rust: Ok(DataRef::Block(p))
}
    // rust: _ => match ctx.get(prefix) {
    // rust: Some(Arg::Resource(id)) => Ok(DataRef::Storage(id.clone())),
    // rust: _ => Err(err("command.failed", &[])),
    // rust: },
}
}
    // rust: pub(in crate::game) fn data_of(&mut self, r: &DataRef) -> R<Tag> {
    // rust: match r {
            // EntityDataAccessor.getData: Entity.saveWithoutId.
    // rust: DataRef::Entity(t) => {
    // rust: let mut tag = self
    // rust: .entity_nbt(*t)
    // rust: .ok_or_else(|| err("argument.entity.notfound.entity", &[]))?;
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: c.remove(&"id".into());
}
    // rust: Ok(tag)
}
    // rust: DataRef::Block(p) => self
    // rust: .block_entity_nbt(*p)
    // rust: .ok_or_else(|| err("commands.data.block.invalid", &[])),
    // rust: DataRef::Storage(id) => Ok(self.score.storage.get(id)),
}
}
    // `BlockEntity.saveWithFullMetadata` of the block entity at `p`: no
    // chunk-only keepPacked, and the lock and custom name the model does
    // not hold. `None` where there is no block entity.
    // rust: pub(in crate::game) fn block_entity_nbt(&self, p: [i32; 3]) -> Option<Tag> {
        // A live moving piston is the level's block entity there (#9617).
    // rust: if let Some(tag) = self.moving_piston_data(p) {
    // rust: return Some(tag);
}
    // rust: if let Some(tag) = self.comparator_data(p).or_else(|| self.pot_data(p)) {
    // rust: return Some(tag);
}
    // rust: let key = (p[0], p[1], p[2]);
    // rust: let name = self.data_block_name(p);
    // rust: let e = self.world.block_entities.get(&key)?;
    // rust: let mut tag = save::block_entity_data(key, e, &name, self.world.block_lock(key));
    // rust: if let (Some(custom), Tag::Compound(map)) = (self.world.block_names.get(&key), &mut tag) {
    // rust: map.entry("CustomName".into())
    // rust: .or_insert_with(|| Tag::String(custom.as_str().into()));
}
    // rust: self.restore_loot_table(key, &mut tag);
    // rust: Some(tag)
}
    // rust: pub(in crate::game) fn set_data_of(&mut self, r: &DataRef, tag: Tag) -> R<()> {
    // rust: match r {
    // rust: DataRef::Entity(t) => self.apply_entity_nbt(*t, tag),
    // rust: DataRef::Block(p) => {
                // This view is read-only: never decode a live piston into a
                // second, detached entry in world.block_entities.
    // rust: if self.moving_piston_data(*p).is_some() {
    // rust: return Err(err("commands.data.block.invalid", &[]));
}
    // rust: if self.set_pot_data(*p, &tag).is_some() {
    // rust: return Ok(());
}
    // rust: let key = (p[0], p[1], p[2]);
    // rust: if let Some(mut input) = self.comparator_data(*p) {
                    // ComparatorBlockEntity.loadAdditional reads getIntOr(0).
                    // Reuse the existing codec, with the block's own metadata.
    // rust: if let Some(value) = tag.get("OutputSignal") {
    // rust: set_key(&mut input, "OutputSignal", value.clone());
    // rust: } else if let Tag::Compound(map) = &mut input {
    // rust: map.remove(&"OutputSignal".into());
}
    // rust: let normalized = horizon_client::block_entity_nbt::canonical(&input)
    // rust: .ok_or_else(|| err("commands.data.block.invalid", &[]))?;
    // rust: if let Some(Tag::Int(output)) = normalized.get("OutputSignal") {
    // rust: self.block_ticks.comparator_outputs.insert(
    // rust: horizon_core::position::BlockPos::new(p[0], p[1], p[2]),
    // rust: *output,
    // rust: );
}
    // rust: self.mark_block_entity_updated(key);
    // rust: return Ok(());
}
    // rust: if let Some((_, mut new)) = save::decode_block_entity(&tag) {
    // rust: self.take_loot_table(key, &tag, &mut new);
    // rust: self.load_block_name(key, &new, &tag);
    // rust: self.world.block_entities.insert(key, new);
    // rust: self.world.set_block_lock(key, &tag);
    // rust: self.update_spawner_display(key);
                    // BlockDataAccessor.setData: setChanged and sendBlockUpdated(3),
                    // even when the block state itself stays the same.
    // rust: self.mark_block_entity_updated(key);
    // rust: let state = self.world.block(p[0], p[1], p[2]);
                    // Redraw what shows the block entity (signs, banners).
    // rust: let _ = self.world.set(p[0], p[1], p[2], state);
}
    // rust: Ok(())
}
    // rust: DataRef::Storage(id) => {
    // rust: self.score.storage.set(id, tag);
    // rust: Ok(())
}
}
}
data_name :: proc(self: ^Self, r: ^DataRef) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match r {
    // rust: DataRef::Entity(t) => self.target_name(*t),
    // rust: DataRef::Block(p) => Text::literal(format!("{}, {}, {}", p[0], p[1], p[2])),
    // rust: DataRef::Storage(id) => Text::literal(id.clone()),
}
}
modified_text :: proc(self: ^Self, r: ^DataRef) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match r {
    // rust: DataRef::Entity(_) => {
    // rust: Text::translate("commands.data.entity.modified", &[self.data_name(r)])
}
    // rust: DataRef::Block(p) => Text::translate(
    // rust: "commands.data.block.modified",
    // rust: &[
    // rust: Text::literal(p[0].to_string()),
    // rust: Text::literal(p[1].to_string()),
    // rust: Text::literal(p[2].to_string()),
    // rust: ],
    // rust: ),
    // rust: DataRef::Storage(id) => Text::translate(
    // rust: "commands.data.storage.modified",
    // rust: &[Text::literal(id.clone())],
    // rust: ),
}
}
query_text :: proc(self: ^Self, r: ^DataRef, data: ^Tag, path: Maybe(^NbtPath)) -> T {
    // Ported from Horizon
    return {}
}
        // Only the live piston writer supplies this provenance. The same
        // compound in storage, an entity, or another block keeps default order.
    // rust: let piston = if let DataRef::Block(p) = r
    // rust: && self.moving_piston_data(*p).is_some()
    // rust: {
    // rust: match path {
    // rust: None => Some(snbt::PistonPart::Entity),
    // rust: Some(p) if p.is_field_path(&[]) => Some(snbt::PistonPart::Entity),
    // rust: Some(p) if p.is_field_path(&["blockState"]) => Some(snbt::PistonPart::State),
    // rust: Some(p) if p.is_field_path(&["blockState", "properties"]) => {
    // rust: Some(snbt::PistonPart::Properties)
}
    // rust: _ => None,
}
    // rust: } else {
    // rust: None
}
    // rust: let pretty = piston.map_or_else(|| snbt::pretty(data), |p| snbt::pretty_piston(data, p));
    // rust: match r {
    // rust: DataRef::Entity(_) => {
    // rust: Text::translate("commands.data.entity.query", &[self.data_name(r), pretty])
}
    // rust: DataRef::Block(p) => Text::translate(
    // rust: "commands.data.block.query",
    // rust: &[
    // rust: Text::literal(p[0].to_string()),
    // rust: Text::literal(p[1].to_string()),
    // rust: Text::literal(p[2].to_string()),
    // rust: pretty,
    // rust: ],
    // rust: ),
    // rust: DataRef::Storage(id) => Text::translate(
    // rust: "commands.data.storage.query",
    // rust: &[Text::literal(id.clone()), pretty],
    // rust: ),
}
}
get_text :: proc(self: ^Self, r: ^DataRef, path: ^NbtPath, scale: f64, value: i32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let p = Text::literal(path.as_str());
    // rust: let (s, v) = (
    // rust: data_cmd::scale_text(scale),
    // rust: Text::literal(value.to_string()),
    // rust: );
    // rust: match r {
    // rust: DataRef::Entity(_) => {
    // rust: Text::translate("commands.data.entity.get", &[p, self.data_name(r), s, v])
}
    // rust: DataRef::Block(b) => Text::translate(
    // rust: "commands.data.block.get",
    // rust: &[
    // rust: p,
    // rust: Text::literal(b[0].to_string()),
    // rust: Text::literal(b[1].to_string()),
    // rust: Text::literal(b[2].to_string()),
    // rust: s,
    // rust: v,
    // rust: ],
    // rust: ),
    // rust: DataRef::Storage(id) => Text::translate(
    // rust: "commands.data.storage.get",
    // rust: &[p, Text::literal(id.clone()), s, v],
    // rust: ),
}
}

    // ---- /data -----------------------------------------------------------

path_arg :: proc(self: ^Self, ctx: ^Context, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Arg::Str(text)) = ctx.get(name) else {
    // rust: return Err(err("command.failed", &[]));
}
    // rust: NbtPath::parse(text).map_err(path_error)
}
    // rust: pub(super) fn cmd_data(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let target = self.data_ref(ctx, 0)?;
        // An entity in another level is read and written in the level that
        // holds it.
    // rust: if let DataRef::Entity(t) = &target {
    // rust: let t = *t;
    // rust: let target = target.clone();
    // rust: return match self.in_target_level(t, |g| g.cmd_data_in(id, ctx, target)) {
    // rust: Some(r) => r,
    // rust: None => Err(err("argument.entity.notfound.entity", &[])),
}
}
    // rust: self.cmd_data_in(id, ctx, target)
}
cmd_data_in :: proc(self: ^Self, id: string, ctx: ^Context, target: DataRef) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match id {
    // rust: "data.merge" => {
    // rust: let Some(Arg::Str(nbt)) = ctx.get("nbt") else {
    // rust: return Ok(0);
}
    // rust: let (nbt, _) = parse_snbt(nbt).map_err(|e| err("argument.nbt.invalid", &[&e]))?;
    // rust: let old = self.data_of(&target)?;
    // rust: if horizon_client::nbt_path::too_deep(&nbt, 0) {
    // rust: return Err(err("arguments.nbtpath.too_deep", &[]));
}
    // rust: let result = data_cmd::merged(&old, &nbt);
    // rust: if old == result {
    // rust: return Err(err("commands.data.merge.failed", &[]));
}
    // rust: self.set_data_of(&target, result)?;
    // rust: let message = self.modified_text(&target);
    // rust: self.feedback(message);
    // rust: Ok(1)
}
    // rust: "data.get" => {
    // rust: let data = self.data_of(&target)?;
    // rust: if ctx.get("path").is_none() {
    // rust: let message = self.query_text(&target, &data, None);
    // rust: self.system_feedback(message);
    // rust: return Ok(1);
}
    // rust: let path = self.path_arg(ctx, "path")?;
    // rust: let tag = data_cmd::single_tag(&path, &data)?;
    // rust: if let Some(Arg::Double(scale)) = ctx.get("scale") {
    // rust: let value = data_cmd::scaled_value(&tag, &path, *scale)?;
    // rust: let message = self.get_text(&target, &path, *scale, value);
    // rust: self.system_feedback(message);
    // rust: return Ok(value);
}
    // rust: let value = data_cmd::get_value(&tag, &path)?;
    // rust: let message = self.query_text(&target, &tag, Some(&path));
    // rust: self.system_feedback(message);
    // rust: Ok(value)
}
    // rust: "data.remove" => {
    // rust: let path = self.path_arg(ctx, "path")?;
    // rust: let mut data = self.data_of(&target)?;
    // rust: let count = path.remove(&mut data);
    // rust: if count == 0 {
    // rust: return Err(err("commands.data.merge.failed", &[]));
}
    // rust: self.set_data_of(&target, data)?;
    // rust: let message = self.modified_text(&target);
    // rust: self.feedback(message);
    // rust: Ok(count as i32)
}
    // rust: "data.modify" => self.cmd_data_modify(ctx, target),
    // rust: _ => Err(err("command.failed", &[])),
}
}
    // A message sent without the feedback gamerule check (`sendSuccess(.., false)`).
system_feedback :: proc(self: ^Self, message: Text) {
}
    // rust: self.feedback(message);
}
cmd_data_modify :: proc(self: ^Self, ctx: ^Context, target: DataRef) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let target_path = self.path_arg(ctx, "targetPath")?;
    // rust: let after_modify: Vec<&String> = ctx
    // rust: .literals
    // rust: .iter()
    // rust: .skip_while(|l| l.as_str() != "modify")
    // rust: .collect();
    // rust: let op = after_modify
    // rust: .iter()
    // rust: .find_map(|l| match l.as_str() {
    // rust: "prepend" => Some(Op::Prepend),
    // rust: "append" => Some(Op::Append),
    // rust: "set" => Some(Op::Set),
    // rust: "merge" => Some(Op::Merge),
    // rust: "insert" => Some(Op::Insert(match ctx.get("index") {
    // rust: Some(Arg::Int(i)) => *i,
    // rust: _ => 0,
    // rust: })),
    // rust: _ => None,
    // rust: })
    // rust: .unwrap_or(Op::Set);
    // rust: let sources: Vec<Tag> = if ctx.has("value") {
    // rust: let Some(Arg::Str(text)) = ctx.get("value") else {
    // rust: return Ok(0);
}
    // rust: vec![
    // rust: parse_snbt(text)
    // rust: .map_err(|e| err("argument.nbt.invalid", &[&e]))?
    // rust: .0,
    // rust: ]
    // rust: } else {
    // rust: let source = self.data_ref(ctx, 1)?;
    // rust: let data = self.data_of(&source)?;
    // rust: let tags = if ctx.get("sourcePath").is_some() {
    // rust: self.path_arg(ctx, "sourcePath")?
    // rust: .get(&data)
    // rust: .map_err(path_error)?
    // rust: } else {
    // rust: vec![data]
}
    // rust: if ctx.has("string") {
    // rust: let start = match ctx.get("start") {
    // rust: Some(Arg::Int(i)) => Some(*i),
    // rust: _ => None,
}
    // rust: let end = match ctx.get("end") {
    // rust: Some(Arg::Int(i)) => Some(*i),
    // rust: _ => None,
}
    // rust: let mut out = Vec::new();
    // rust: for t in &tags {
    // rust: let text = data_cmd::as_text(t)?;
    // rust: let text = match start {
    // rust: Some(s) => data_cmd::substring(&text, s, end)?,
    // rust: None => text,
}
    // rust: out.push(Tag::String(text.as_str().into()));
}
    // rust: out
    // rust: } else {
    // rust: tags
}
}
    // rust: let mut data = self.data_of(&target)?;
    // rust: let changed = data_cmd::modify(op, &mut data, &target_path, &sources)?;
    // rust: if changed == 0 {
    // rust: return Err(err("commands.data.merge.failed", &[]));
}
    // rust: self.set_data_of(&target, data)?;
    // rust: let message = self.modified_text(&target);
    // rust: self.feedback(message);
    // rust: Ok(changed as i32)
}

    // ---- /tag ------------------------------------------------------------

    // rust: pub(super) fn cmd_tag(&mut self, id: &str, ctx: &Context) -> R<i32> {
    // rust: let targets = self.entities(ctx, "targets", false)?;
    // rust: let name = match ctx.get("name") {
    // rust: Some(Arg::Str(n)) => n.clone(),
    // rust: _ => String::new(),
}
    // rust: let mut tracker = Tracker::default();
    // rust: let holder = |g: &Self, t: Target| Holder {
    // rust: name: String::new(),
    // rust: text: g.target_name(t),
    // rust: display: None,
}
    // rust: let mut all: Vec<String> = Vec::new();
    // rust: for &t in &targets {
    // rust: let mut tags = self.tags_of(t);
    // rust: let h = holder(self, t);
    // rust: match id {
    // rust: "tag.add" => {
    // rust: let added = tags.len() < 1024 && !tags.contains(&name);
    // rust: if added {
    // rust: tags.push(name.clone());
    // rust: self.set_entity_tags(t, &tags);
}
    // rust: tracker.track(&h, i32::from(added));
}
    // rust: "tag.remove" => {
    // rust: let before = tags.len();
    // rust: tags.retain(|x| x != &name);
    // rust: let removed = tags.len() != before;
    // rust: if removed {
    // rust: self.set_entity_tags(t, &tags);
}
    // rust: tracker.track(&h, i32::from(removed));
}
    // rust: _ => {
    // rust: tracker.track(&h, tags.len() as i32);
    // rust: for tag in tags {
    // rust: if !all.contains(&tag) {
    // rust: all.push(tag);
}
}
}
}
}
    // rust: let num = |n: usize| Text::literal(n.to_string());
    // rust: let n = name.clone();
    // rust: let (message, total) = match id {
    // rust: "tag.add" => tracker.message(
    // rust: false,
    // rust: Some(err("commands.tag.add.failed", &[])),
    // rust: |h, _| {
    // rust: Text::translate(
    // rust: "commands.tag.add.success.single",
    // rust: &[Text::literal(n.clone()), h.text.clone()],
    // rust: )
    // rust: },
    // rust: |c, _| {
    // rust: Text::translate(
    // rust: "commands.tag.add.success.multiple",
    // rust: &[Text::literal(n.clone()), num(c)],
    // rust: )
    // rust: },
    // rust: ),
    // rust: "tag.remove" => tracker.message(
    // rust: false,
    // rust: Some(err("commands.tag.remove.failed", &[])),
    // rust: |h, _| {
    // rust: Text::translate(
    // rust: "commands.tag.remove.success.single",
    // rust: &[Text::literal(n.clone()), h.text.clone()],
    // rust: )
    // rust: },
    // rust: |c, _| {
    // rust: Text::translate(
    // rust: "commands.tag.remove.success.multiple",
    // rust: &[Text::literal(n.clone()), num(c)],
    // rust: )
    // rust: },
    // rust: ),
    // rust: _ => {
    // rust: let count = all.len();
    // rust: let message = if all.is_empty() {
    // rust: tracker
    // rust: .message(
    // rust: false,
    // rust: None,
    // rust: |h, _| {
    // rust: Text::translate(
    // rust: "commands.tag.list.single.empty",
    // rust: std::slice::from_ref(&h.text),
    // rust: )
    // rust: },
    // rust: |c, _| Text::translate("commands.tag.list.multiple.empty", &[num(c)]),
    // rust: )?
    // rust: .0
    // rust: } else {
    // rust: let list = {
    // rust: let mut sorted = all.clone();
    // rust: sorted.sort();
    // rust: format_list(
    // rust: sorted
    // rust: .into_iter()
    // rust: .map(|s| Text::literal(s).with_color(horizon_client::text::GREEN))
    // rust: .collect(),
    // rust: )
}
    // rust: tracker
    // rust: .message(
    // rust: true,
    // rust: None,
    // rust: |h, _| {
    // rust: Text::translate(
    // rust: "commands.tag.list.single.success",
    // rust: &[h.text.clone(), num(count), list.clone()],
    // rust: )
    // rust: },
    // rust: |c, _| {
    // rust: Text::translate(
    // rust: "commands.tag.list.multiple.success",
    // rust: &[num(c), num(count), list.clone()],
    // rust: )
    // rust: },
    // rust: )?
    // rust: .0
}
    // rust: self.feedback(message);
    // rust: return Ok(count as i32);
}
    // rust: }?;
    // rust: self.feedback(message);
    // rust: Ok(total)
}

    // ---- /summon ---------------------------------------------------------

    // Spawn an entity from its compound (`EntityType.loadEntityRecursive`);
    // returns what was created.
    // rust: pub(in crate::game) fn spawn_entity_from_nbt(&mut self, tag: Tag) -> Option<Target> {
    // rust: let key = {
    // rust: let p = entity_nbt::position(&tag)?;
    // rust: ((p.x.floor() as i32) >> 4, (p.z.floor() as i32) >> 4)
}
        // Only this stack spawns now: the entities of chunks that finished
        // loading wait for the level's entity tick, as in vanilla
        // (PersistentEntitySectionManager.processPendingLoads), and must not
        // take the ids counted as this stack's.
    // rust: let mut waiting = std::mem::take(&mut self.world.loaded_entities);
    // rust: let before = self.next_entity;
    // rust: let mut tag = tag;
    // rust: crate::game::persist::mark_fresh(&mut tag);
    // rust: self.world.loaded_entities.push((key, vec![tag]));
    // rust: self.spawn_loaded_entities();
    // rust: waiting.append(&mut self.world.loaded_entities);
    // rust: self.world.loaded_entities = waiting;
    // rust: if self.next_entity == before {
    // rust: return None;
}
        // The root of the stack is the first entity spawned.
    // rust: let id = before + 1;
    // rust: if self.mobs.iter().any(|m| m.id == id) {
    // rust: Some(Target::Mob(id))
    // rust: } else if self.dropped.iter().any(|e| e.id == id) {
    // rust: Some(Target::Item(id))
    // rust: } else if self.armor_stands.iter().any(|a| a.id == id) {
    // rust: Some(Target::Stand(id))
    // rust: } else if self.item_frames.iter().any(|f| f.id == id) {
    // rust: Some(Target::Frame(id))
    // rust: } else if self.paintings.iter().any(|p| p.id == id) {
    // rust: Some(Target::Painting(id))
    // rust: } else if self.boats.iter().any(|b| b.id == id) {
    // rust: Some(Target::Boat(id))
    // rust: } else if self.carts.iter().any(|c| c.id == id) {
    // rust: Some(Target::Cart(id))
    // rust: } else if self.others.iter().any(|o| o.id == id) {
    // rust: Some(Target::Other(id))
    // rust: } else if self.tnts.iter().any(|t| t.id == id) {
    // rust: Some(Target::Tnt(id))
    // rust: } else if self.falling.iter().any(|f| f.id == id) {
    // rust: Some(Target::Falling(id))
    // rust: } else if self.rockets.iter().any(|r| r.id == id) {
    // rust: Some(Target::Rocket(id))
    // rust: } else if self.tridents.iter().any(|t| t.id == id) {
    // rust: Some(Target::Trident(id))
    // rust: } else if self.ominous_spawners.iter().any(|s| s.id == id) {
    // rust: Some(Target::Spawner(id))
    // rust: } else {
    // rust: None
}
}
    // The `summon <entity> <pos> <nbt>` form.
    // rust: pub(in crate::game) fn summon_with_nbt(
    // rust: &mut self,
    // rust: kind: &str,
    // rust: pos: [f64; 3],
    // rust: nbt: &str,
    // rust: ) -> R<Option<Target>> {
    // rust: let (mut tag, _) = parse_snbt(nbt).map_err(|e| err("argument.nbt.invalid", &[&e]))?;
    // rust: if !matches!(tag, Tag::Compound(_)) {
    // rust: return Err(err("argument.nbt.expected.compound", &[]));
}
    // rust: set_key(&mut tag, "id", Tag::String(kind.into()));
        // Turtle.readAdditionalSaveData chooses its home before SummonCommand's snapTo.
        // Preserve that load-stage default while the shared loader receives the final Pos.
    // rust: if kind == "minecraft:turtle"
    // rust: && !matches!(tag.get("home_pos"), Some(Tag::IntArray(home)) if home.len() == 3)
    // rust: {
    // rust: let home = entity_nbt::position(&tag).map_or([0; 3], |p| {
    // rust: [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32]
    // rust: });
    // rust: set_key(&mut tag, "home_pos", Tag::IntArray(home.to_vec()));
}
    // rust: place_summoned(&mut tag, pos);
    // rust: let from = self.mobs.len();
    // rust: let canceled = self.persist.joins_canceled;
    // rust: let target = self.spawn_entity_from_nbt(tag);
    // rust: self.native_mobs_joined(from, false);
        // A mod kept the entity out: tryAddFreshEntityWithPassengers is false.
    // rust: if self.persist.joins_canceled != canceled
    // rust: && target.is_none_or(|t| self.target_position(t).is_none())
    // rust: {
    // rust: return Err(err("commands.summon.failed.uuid", &[]));
}
    // rust: Ok(target)
}
}

    // rust: mod orb_uuid_tests {
//     use super::Target;
//     use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//     use horizon_world::nbt::Tag;

saved_orb_uuid_comes_from_registered_identity_without_or_despite_raw :: proc() {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.build_registries();
    // rust: let uuid = [0, 0, 0, 2];
    // rust: let tag = Tag::compound([
    // rust: ("UUID", Tag::IntArray(uuid.to_vec())),
    // rust: (
    // rust: "Pos",
    // rust: Tag::List(vec![
    // rust: Tag::Double(4.5_f64.to_bits()),
    // rust: Tag::Double(200.0_f64.to_bits()),
    // rust: Tag::Double(4.5_f64.to_bits()),
    // rust: ]),
    // rust: ),
    // rust: ("Value", Tag::Short(1)),
    // rust: ("Age", Tag::Short(0)),
    // rust: ("Health", Tag::Short(5)),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: ]);
    // rust: game.load_orb(tag, Some(uuid));
    // rust: assert_eq!(game.orbs.len(), 1);
    // rust: let id = game.orbs[0].id;
    // rust: assert_eq!(game.persist.uuids.get(&id), Some(&uuid));
    // rust: let time = game.world.game_time;
    // rust: for raw in [
    // rust: None,
    // rust: Some(Tag::compound([("UUID", Tag::IntArray(vec![9, 9, 9, 9]))])),
    // rust: ] {
    // rust: if let Some(raw) = &raw {
    // rust: game.persist.raw.insert(id, raw.clone());
    // rust: } else {
    // rust: game.persist.raw.remove(&id);
}
    // rust: for _ in 0..3 {
    // rust: let saved = game.entity_nbt_in_level(Target::Orb(id)).unwrap();
    // rust: assert_eq!(saved.get("UUID"), Some(&Tag::IntArray(uuid.to_vec())));
    // rust: assert_eq!(game.persist.uuids.get(&id), Some(&uuid));
    // rust: assert_eq!(game.persist.raw.get(&id), raw.as_ref());
    // rust: assert_eq!(game.world.game_time, time);
}
}
}
}

    // rust: mod wolf_live_anger_tests {
//     use super::Target;
//     use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//     use horizon_world::nbt::Tag;

live_wolf_anger_writes_use_the_level_clock_and_keep_bee_state :: proc() {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.build_registries();
    // rust: game.world.game_time = 12_345;
        // Bee's independently modeled end is the first control, before the Wolf regression.
    // rust: for (kind, health, number) in [("bee", 10.0_f32, 1), ("wolf", 8.0, 2)] {
    // rust: game.mobs.clear();
    // rust: let tag = Tag::Compound(
    // rust: [
    // rust: (
    // rust: "id".into(),
    // rust: Tag::String(format!("minecraft:{kind}").as_str().into()),
    // rust: ),
    // rust: ("UUID".into(), Tag::IntArray(vec![316, 1, 0, number])),
    // rust: (
    // rust: "Pos".into(),
    // rust: Tag::List(vec![
    // rust: Tag::Double(10.5_f64.to_bits()),
    // rust: Tag::Double(200.0_f64.to_bits()),
    // rust: Tag::Double(10.5_f64.to_bits()),
    // rust: ]),
    // rust: ),
    // rust: ("Health".into(), Tag::Float(health.to_bits())),
    // rust: ("NoAI".into(), Tag::Byte(1)),
    // rust: ("NoGravity".into(), Tag::Byte(1)),
    // rust: ("Silent".into(), Tag::Byte(1)),
    // rust: ("PersistenceRequired".into(), Tag::Byte(1)),
    // rust: ("anger_end_time".into(), Tag::Long(-1)),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: );
    // rust: let id = game.load_mob(tag, None).unwrap();
    // rust: let i = game.mobs.iter().position(|m| m.id == id).unwrap();
    // rust: game.mobs[i].invulnerable = 17;
    // rust: game.mobs[i].last_hurt = 2.0;
    // rust: game.mobs[i].age = 6;
    // rust: for end in [12_395, 12_395, 12_420, -1] {
    // rust: let mut tag = game.mob_tree_nbt(i);
    // rust: let Tag::Compound(fields) = &mut tag else {
    // rust: panic!("mob compound")
}
    // rust: fields.insert("anger_end_time".into(), Tag::Long(end));
    // rust: game.apply_entity_nbt(Target::Mob(id), tag).unwrap();
    // rust: let saved = game.mob_tree_nbt(i);
    // rust: assert_eq!(
    // rust: saved.get("anger_end_time"),
    // rust: Some(&Tag::Long(end)),
    // rust: "{kind} end={end}"
    // rust: );
    // rust: assert_eq!(game.world.game_time, 12_345);
    // rust: assert_eq!(game.persist.uuids.get(&id), Some(&[316, 1, 0, number]));
    // rust: assert_eq!(game.mobs[i].health, health);
    // rust: assert!(game.mobs[i].no_ai);
    // rust: assert_eq!(
    // rust: (
    // rust: game.mobs[i].invulnerable,
    // rust: game.mobs[i].last_hurt,
    // rust: game.mobs[i].age
    // rust: ),
    // rust: (17, 2.0, 6)
    // rust: );
}
}
}
}

    // rust: mod loot_table_tests {
//     use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//     use horizon_client::{
    // rust: chunk::Chunk,
    // rust: containers::BlockEntity,
    // rust: items::ItemStack,
    // rust: save::{self, ChunkExtras, RolledLoot},
}
//     use horizon_world::nbt::Tag;
//     use std::sync::Arc;

TABLE :: "minecraft:chests/simple_dungeon"

    // The chest as a chunk save writes it, and its slots when that save loads.
saved_and_reloaded :: proc(game: ^Game<'_>, pos: (i32) {
}
    // rust: let live = game.world.chunks.get(&(0, 0)).unwrap().clone();
    // rust: let chunk = game.with_entities([&live]).remove(0);
    // rust: let registry = game.pack.assets.registry;
    // rust: let encoded = save::encode(&chunk, registry, game.res.biomes());
    // rust: let Some(Tag::List(list)) = encoded.tag.get("block_entities") else {
    // rust: panic!("no block entities");
}
    // rust: let saved = list
    // rust: .iter()
    // rust: .find(|t| save::number(t.get("x")) == Some(i64::from(pos.0)))
    // rust: .unwrap()
    // rust: .clone();
    // rust: let reloaded = save::decode(&encoded, registry, game.res.biomes()).unwrap();
    // rust: let (_, BlockEntity::Chest(slots)) = reloaded
    // rust: .block_entities
    // rust: .iter()
    // rust: .find(|(p, _)| *p == pos)
    // rust: .unwrap()
    // rust: else {
    // rust: panic!("chest");
}
    // rust: (saved, slots.clone())
}

    // RandomizableContainer.tryLoadLootTable: a tag without a table loads an
    // empty chest that stays so, and one with a table keeps it.
data_commands_on_an_unopened_loaded_chest_survive_a_save_and_reload :: proc() {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.build_registries();
    // rust: game.set_allow_commands(true);

        // Two chests as a load leaves them: rolled, with the table in their source.
    // rust: let removed = (1, 64, 2);
    // rust: let merged = (2, 64, 2);
    // rust: let chest = game
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:chest")
    // rust: .unwrap();
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: let mut extras = ChunkExtras::default();
    // rust: for pos in [removed, merged] {
    // rust: let mut slots = vec![None; 27];
    // rust: slots[0] = Some(ItemStack::new("minecraft:gold_ingot", 2));
    // rust: chunk.set(pos.0, pos.1, pos.2, chest.0);
    // rust: extras.rolled_loot.push(RolledLoot {
    // rust: pos,
    // rust: table: TABLE.into(),
    // rust: seed: Some(42),
    // rust: items: save::encode_items(&slots),
    // rust: });
    // rust: extras.block_entity_sources.push((
    // rust: pos,
    // rust: Tag::compound([
    // rust: ("id", Tag::String("minecraft:chest".into())),
    // rust: ("x", Tag::Int(pos.0)),
    // rust: ("y", Tag::Int(pos.1)),
    // rust: ("z", Tag::Int(pos.2)),
    // rust: ("LootTable", Tag::String(TABLE.into())),
    // rust: ("LootTableSeed", Tag::Long(42)),
    // rust: ]),
    // rust: ));
    // rust: game.world
    // rust: .block_entities
    // rust: .insert(pos, BlockEntity::Chest(slots));
}
    // rust: chunk.saved = Some(Arc::new(extras));
    // rust: game.world.chunks.insert((0, 0), Arc::new(chunk));

    // rust: assert!(game.run_command("data remove block 1 64 2 LootTable"));
    // rust: let (saved, slots) = saved_and_reloaded(&game, removed);
    // rust: assert!(
    // rust: saved.get("LootTable").is_none(),
    // rust: "the emptied chest rolls again on load: {saved:?}"
    // rust: );
    // rust: assert!(saved.get("LootTableSeed").is_none());
    // rust: assert!(slots.iter().all(Option::is_none));

    // rust: assert!(game.run_command("data merge block 2 64 2 {LootTableSeed:7L}"));
    // rust: let (saved, _) = saved_and_reloaded(&game, merged);
    // rust: assert_eq!(save::text(saved.get("LootTable")).as_deref(), Some(TABLE));
    // rust: assert_eq!(save::number(saved.get("LootTableSeed")), Some(7));
    // rust: assert!(saved.get("Items").is_none());
}
}
