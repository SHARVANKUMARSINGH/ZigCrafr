//! Transpiled from Horizon Rust crate
package horizon_client_native_entity_refs

import "core:fmt"
import "core:mem"
import "core:math"

// Entity and level handles for native mods (docs/native-mods.md, "Entity
// and level handles", #7387): `native_entity(id)` turns an event's entity id
// into an `EntityRef`, and each `native_entity_*` helper reads the entity a
// handle names. On a server the entities are those of the level in place
// (the one a hook runs in) and the server's players, whatever their level.
// On a client (API @API:client_entity_refs@) they are the entities the
// server shows this window, read from what it synced: positions, rotations,
// types, UUIDs, custom names and equipment, never saved data or tags. With
// no world open, or for a handle of an earlier open (on a client, of an
// earlier client level), they return `None`.
// use super::{Dim, Game, commands::Target};
// use horizon_client::mod_api::{EntityRef, LevelRef};

    // rust: impl Game<'_> {
    // What a handle names now, or None for a stale or foreign one.
    // rust: pub(super) fn native_entity_target(&self, entity: EntityRef) -> Option<Target> {
    // rust: let id = i32::try_from(entity.id()).ok()?;
    // rust: if let Some(r) = &self.remote {
    // rust: if r.native_epoch() != Some(entity.epoch()) {
    // rust: return None;
}
            // This window's own player is the one in place.
    // rust: if id == r.entity_id {
    // rust: return self.player.as_ref().map(|_| Target::Player);
}
    // rust: } else if self.native_lifecycle.epoch() != Some(entity.epoch()) {
    // rust: return None;
}
    // rust: let player = self
    // rust: .lan
    // rust: .iter()
    // rust: .flat_map(|h| h.hub.guests.iter())
    // rust: .find(|g| g.placed && g.entity_id == id);
    // rust: if let Some(g) = player {
            // `as_guest` swaps the acting player's state into the game.
    // rust: let acting = self.lan_acting == Some(g.conn) && self.player.is_some();
    // rust: return Some(if acting {
    // rust: Target::Player
    // rust: } else {
    // rust: Target::Guest(g.conn)
    // rust: });
}
    // rust: match self.level_entity(id)? {
    // rust: Target::Mob(id) if !self.mobs.iter().any(|m| m.id == id && !m.removed) => None,
    // rust: t => Some(t),
}
}
    // An entity a client tracks that no entity list of the game holds (a
    // display, an interaction, a marker, a leash knot): its type and its
    // position as the server last sent it. None on a server.
native_client_tracked :: proc(self: ^Self, entity: EntityRef) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let r = self.remote.as_ref()?;
    // rust: if r.native_epoch() != Some(entity.epoch()) {
    // rust: return None;
}
    // rust: r.tracked_entity(i32::try_from(entity.id()).ok()?)
}
    // The entity `id` (the id events carry) as a handle for the `entity_*`
    // methods: None with no world open, or for no such entity in the level
    // in place or among the server's players. On a client (API
    // @API:client_entity_refs@), any entity the server shows this window,
    // this window's own player included. API 373.
    // rust: pub(super) fn native_entity(&self, id: u32) -> Option<EntityRef> {
    // rust: let epoch = match &self.remote {
    // rust: Some(r) => r.native_epoch()?,
    // rust: None => self.native_lifecycle.epoch()?,
}
    // rust: let entity = EntityRef::new(epoch, id);
    // rust: (self.native_entity_target(entity).is_some()
    // rust: || self.native_client_tracked(entity).is_some())
    // rust: .then_some(entity)
}
    // The level `dimension` (`minecraft:the_nether`) as a handle: None on a
    // client, with no world open, or for a dimension the server hasn't
    // loaded. API 373.
    // rust: pub(super) fn native_level(&self, dimension: &str) -> Option<LevelRef> {
    // rust: if self.remote.is_some() {
    // rust: return None;
}
    // rust: let epoch = self.native_lifecycle.epoch()?;
    // rust: let dim = std::iter::once(self.dim)
    // rust: .chain(self.levels.parked_dims())
    // rust: .find(|d| d.id() == dimension)?;
    // rust: Some(LevelRef::new(epoch, dim.id()))
}
    // The entity's position (`Entity.position`): its feet, the middle of
    // its box for a painting or an item frame. On a client, where the
    // window shows it (another entity eases toward the server's moves); an
    // entity tracked without a list of its own is where the server last put
    // it. API 373.
    // rust: pub(super) fn native_entity_position(&self, entity: EntityRef) -> Option<[f64; 3]> {
    // rust: match self.native_entity_target(entity) {
    // rust: Some(t) => self.target_position(t),
    // rust: None => self.native_client_tracked(entity).map(|(_, at)| at),
}
}
    // The block the entity's position is in (`Entity.blockPosition`). API
    // 373.
    // rust: pub(super) fn native_entity_block_position(&self, entity: EntityRef) -> Option<[i32; 3]> {
    // rust: self.native_entity_position(entity)
    // rust: .map(|p| p.map(|v| v.floor() as i32))
}
    // The entity's yaw and pitch in degrees (`Entity.getYRot`, `getXRot`); 0
    // for the kinds that don't turn. API 373.
    // rust: pub(super) fn native_entity_rotation(&self, entity: EntityRef) -> Option<[f32; 2]> {
    // rust: Some(self.target_rotation(self.native_entity_target(entity)?))
}
    // The entity's type (`Entity.getType`): `minecraft:zombie`. API
    // 373.
    // rust: pub(super) fn native_entity_kind(&self, entity: EntityRef) -> Option<String> {
    // rust: match self.native_entity_target(entity) {
    // rust: Some(t) => Some(self.target_type(t)),
    // rust: None => self
    // rust: .native_client_tracked(entity)
    // rust: .map(|(kind, _)| kind.to_owned()),
}
}
    // The entity's UUID (`Entity.getUUID`), the one it is saved with; an
    // entity that has none yet gets it now, as a new vanilla entity does.
    // On a client, the one the server added it with (a player's is its
    // profile's). API 373.
    // rust: pub(super) fn native_entity_uuid(&mut self, entity: EntityRef) -> Option<u128> {
    // rust: if let Some(r) = &self.remote {
    // rust: let id = i32::try_from(entity.id()).ok()?;
    // rust: if self.native_entity_target(entity).is_none()
    // rust: && self.native_client_tracked(entity).is_none()
    // rust: {
    // rust: return None;
}
    // rust: if let Some((uuid, _)) = r.level_player(id) {
    // rust: return Some(uuid);
}
    // rust: return self
    // rust: .persist
    // rust: .uuids
    // rust: .get(&entity.id())
    // rust: .copied()
    // rust: .map(uuid_from_words);
}
    // rust: let words = match self.native_entity_target(entity)? {
    // rust: Target::Player => return self.command_guest(self.lan_acting?).map(|g| g.uuid),
    // rust: Target::Guest(conn) => return self.command_guest(conn).map(|g| g.uuid),
    // rust: _ => self.uuid_for(entity.id()),
}
    // rust: Some(uuid_from_words(words))
}
    // The level the entity is in (`Entity.level`): on a client, the
    // client's level. API 373.
    // rust: pub(super) fn native_entity_level(&self, entity: EntityRef) -> Option<LevelRef> {
    // rust: let dim: Dim = match self.native_entity_target(entity) {
    // rust: Some(t) => self.target_level(t),
    // rust: None => self.native_client_tracked(entity).map(|_| self.dim)?,
}
    // rust: Some(LevelRef::new(entity.epoch(), dim.id()))
}
}

// A saved UUID's four ints (`UUIDUtil.uuidFromIntArray`) as one number.
uuid_from_words :: proc(words: [i32; 4]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: words
    // rust: .iter()
    // rust: .fold(0, |uuid, w| (uuid << 32) | u128::from(*w as u32))
}

    // rust: mod tests {
uuid_words_are_most_significant_first :: proc() {
}
    // rust: let words = [0x0102_0304, -1, 0, 0x7fff_ffff];
    // rust: assert_eq!(
    // rust: super::uuid_from_words(words),
    // rust: 0x0102_0304_ffff_ffff_0000_0000_7fff_ffff
    // rust: );
}
}

// A window joined to a server through memory, fed the server's packets as
// it would receive them: what its native mods read of the entities and the
// menu the server showed it.
    // rust: mod client_tests {
//     use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//     use horizon_client::mod_api::EquipmentSlot;
//     use horizon_protocol::entity_data::Value;
//     use horizon_protocol::item::{Component, Stack, component};
//     use horizon_protocol::packets::play::{self, Clientbound as C};
//     use horizon_world::nbt::Tag;

spawn :: proc(dimension: string) -> p {
    // Ported from Horizon
    return {}
}
    // rust: play::SpawnInfo {
    // rust: dimension_type: 0,
    // rust: dimension: dimension.into(),
    // rust: seed: 1,
    // rust: game_type: 0,
    // rust: previous_game_type: None,
    // rust: debug: false,
    // rust: flat: false,
    // rust: last_death: None,
    // rust: portal_cooldown: 0,
    // rust: sea_level: 63,
}
}

a_client_reads_the_entities_and_menu_the_server_shows_it :: proc() {
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
    // rust: let (pipe, _server) = horizon_protocol::connection::Pipe::pair();
    // rust: game.connect_local(pipe, "Steve").unwrap();
    // rust: let builtin = game.remote.as_ref().unwrap().builtin.clone();
    // rust: let id = |registry: &str, name: &str| builtin.get(registry).unwrap().id(name).unwrap();
    // rust: let item = |name: &str| id("minecraft:item", name);
    // rust: let add = |entity: i32, uuid: u128, kind: &str, position: [f64; 3]| {
    // rust: C::AddEntity(play::AddEntity {
    // rust: id: entity,
    // rust: uuid,
    // rust: kind: id("minecraft:entity_type", kind),
    // rust: position,
    // rust: velocity: [0.0; 3],
    // rust: pitch: 0,
    // rust: yaw: 64,
    // rust: head_yaw: 64,
    // rust: data: 0,
    // rust: })
}
        // No client level yet: no handle.
    // rust: assert_eq!(game.native_entity(20), None);
    // rust: game.handle_packet(C::Login(play::Login {
    // rust: player_id: 7,
    // rust: hardcore: false,
    // rust: levels: vec!["minecraft:overworld".into(), "minecraft:the_nether".into()],
    // rust: max_players: 20,
    // rust: chunk_radius: 8,
    // rust: simulation_distance: 8,
    // rust: reduced_debug_info: false,
    // rust: show_death_screen: true,
    // rust: limited_crafting: false,
    // rust: spawn: spawn("minecraft:overworld"),
    // rust: online_mode: false,
    // rust: enforces_secure_chat: false,
    // rust: }))
    // rust: .unwrap();

        // The window's own player, once the server's first teleport made it.
    // rust: game.handle_packet(C::PlayerPosition(play::PlayerPosition {
    // rust: teleport: 1,
    // rust: position: [0.5, 65.0, 0.5],
    // rust: delta: [0.0; 3],
    // rust: yaw: 45.0,
    // rust: pitch: 10.0,
    // rust: relatives: 0,
    // rust: }))
    // rust: .unwrap();
    // rust: let me = game.native_entity(7).expect("the own player");
    // rust: assert_eq!(
    // rust: game.native_entity_kind(me).as_deref(),
    // rust: Some("minecraft:player")
    // rust: );
    // rust: assert_eq!(game.native_entity_position(me), Some([0.5, 65.0, 0.5]));
    // rust: assert_eq!(game.native_entity_rotation(me), Some([45.0, 10.0]));
        // The profile the login named (the net thread's `Joined`).
    // rust: game.remote.as_mut().unwrap().profile_name = "Steve".into();
    // rust: assert_eq!(game.native_entity_name(me).as_deref(), Some("Steve"));

        // An armor stand with a custom name and a helmet.
    // rust: let uuid = 0x0011_2233_4455_6677_8899_aabb_ccdd_eeff;
    // rust: game.handle_packet(add(20, uuid, "minecraft:armor_stand", [1.5, 64.0, 2.5]))
    // rust: .unwrap();
    // rust: game.handle_packet(C::SetEntityData(play::SetEntityData {
    // rust: id: 20,
    // rust: values: vec![(2, 6, Value::OptText(Some(Tag::String("Greeter".into()))))],
    // rust: }))
    // rust: .unwrap();
    // rust: game.handle_packet(C::SetEquipment(play::SetEquipment {
    // rust: id: 20,
    // rust: slots: vec![(5, Some(Stack::new(item("minecraft:diamond_helmet"), 1)))],
    // rust: }))
    // rust: .unwrap();
    // rust: let stand = game.native_entity(20).expect("the stand is tracked");
    // rust: assert_eq!(
    // rust: game.native_entity_kind(stand).as_deref(),
    // rust: Some("minecraft:armor_stand")
    // rust: );
    // rust: assert_eq!(game.native_entity_position(stand), Some([1.5, 64.0, 2.5]));
    // rust: assert_eq!(game.native_entity_block_position(stand), Some([1, 64, 2]));
    // rust: assert_eq!(game.native_entity_rotation(stand), Some([90.0, 0.0]));
    // rust: assert_eq!(game.native_entity_uuid(stand), Some(uuid));
    // rust: assert_eq!(game.native_entity_name(stand).as_deref(), Some("Greeter"));
    // rust: let living = game.native_living(stand).expect("an armor stand is living");
    // rust: let head = game.native_living_equipment(living, EquipmentSlot::Head);
    // rust: assert_eq!(
    // rust: head.map(|s| s.item.to_string()).as_deref(),
    // rust: Some("minecraft:diamond_helmet")
    // rust: );
    // rust: assert_eq!(
    // rust: game.native_living_equipment(living, EquipmentSlot::Chest),
    // rust: None
    // rust: );
        // A client knows no saved data or tags, and changes nothing itself.
    // rust: assert_eq!(game.native_entity_nbt(stand), None);
    // rust: assert_eq!(game.native_entity_tags(stand), None);
    // rust: assert!(!game.native_entity_add_tag(stand, "seen"));
    // rust: assert!(!game.native_living_set_equipment(living, EquipmentSlot::Head, None));
    // rust: assert!(
    // rust: game.native_living_equipment(living, EquipmentSlot::Head)
    // rust: .is_some()
    // rust: );
    // rust: assert!(!game.native_entity_set_velocity(stand, [0.0, 1.0, 0.0]));

        // An entity the client keeps no list of its own for: its type and
        // where the server put it.
    // rust: game.handle_packet(add(21, 5, "minecraft:text_display", [4.0, 70.0, -3.0]))
    // rust: .unwrap();
    // rust: let display = game.native_entity(21).expect("the display is tracked");
    // rust: assert_eq!(
    // rust: game.native_entity_kind(display).as_deref(),
    // rust: Some("minecraft:text_display")
    // rust: );
    // rust: assert_eq!(
    // rust: game.native_entity_position(display),
    // rust: Some([4.0, 70.0, -3.0])
    // rust: );
    // rust: assert_eq!(game.native_entity_uuid(display), Some(5));
    // rust: assert_eq!(game.native_entity(99), None);

        // A chest the server opened, by its slot numbers: the chest's 9,
        // then the inventory's 27, then the hotbar's 9.
    // rust: assert_eq!(game.native_menu_stacks(), None);
    // rust: game.handle_packet(C::OpenScreen(play::OpenScreen {
    // rust: container: 3,
    // rust: menu: id("minecraft:menu", "minecraft:generic_9x1"),
    // rust: title: Tag::String("Loot".into()),
    // rust: }))
    // rust: .unwrap();
    // rust: let mut named = Stack::new(item("minecraft:diamond"), 2);
    // rust: named.added.push((
    // rust: component::CUSTOM_NAME,
    // rust: Component::Text(Tag::String("Gem".into())),
    // rust: ));
    // rust: let mut items = vec![None; 45];
    // rust: items[0] = Some(named);
    // rust: items[36] = Some(Stack::new(item("minecraft:stone"), 5));
    // rust: game.handle_packet(C::ContainerSetContent(play::ContainerSetContent {
    // rust: container: 3,
    // rust: state: 1,
    // rust: items,
    // rust: carried: None,
    // rust: }))
    // rust: .unwrap();
    // rust: let stacks = game.native_menu_stacks().expect("a server menu is open");
    // rust: assert_eq!(stacks.len(), 45);
    // rust: let gem = stacks[0].as_ref().expect("the chest's first slot");
    // rust: assert_eq!((&*gem.item, gem.count), ("minecraft:diamond", 2));
    // rust: assert_eq!(gem.custom_name().as_deref(), Some("Gem"));
    // rust: assert!(stacks[1].is_none());
    // rust: let stone = stacks[36].as_ref().expect("the hotbar's first slot");
    // rust: assert_eq!((&*stone.item, stone.count), ("minecraft:stone", 5));
        // The hotbar's first slot is the player's inventory slot 0.
    // rust: assert_eq!(game.inventory[0].as_ref().map(|s| s.count), Some(5));

        // A new client level: the handles of the old one read as None.
    // rust: game.handle_packet(C::Respawn(play::Respawn {
    // rust: spawn: spawn("minecraft:the_nether"),
    // rust: keep: 0,
    // rust: }))
    // rust: .unwrap();
    // rust: assert_eq!(game.native_entity_position(stand), None);
    // rust: assert_eq!(game.native_entity_kind(display), None);
}

    // #8589: the server sends entity event 42 (the raid sweat) for a villager;
    // the client must draw the particles, as it does for the events it let
    // through before. An event with no particle table row (2) draws nothing.
a_villager_raid_sweat_event_draws_particles :: proc() {
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
    // rust: let (pipe, _server) = horizon_protocol::connection::Pipe::pair();
    // rust: game.connect_local(pipe, "Steve").unwrap();
    // rust: let builtin = game.remote.as_ref().unwrap().builtin.clone();
    // rust: let kind = builtin
    // rust: .get("minecraft:entity_type")
    // rust: .unwrap()
    // rust: .id("minecraft:villager")
    // rust: .unwrap();
    // rust: game.handle_packet(C::Login(play::Login {
    // rust: player_id: 7,
    // rust: hardcore: false,
    // rust: levels: vec!["minecraft:overworld".into()],
    // rust: max_players: 20,
    // rust: chunk_radius: 8,
    // rust: simulation_distance: 8,
    // rust: reduced_debug_info: false,
    // rust: show_death_screen: true,
    // rust: limited_crafting: false,
    // rust: spawn: spawn("minecraft:overworld"),
    // rust: online_mode: false,
    // rust: enforces_secure_chat: false,
    // rust: }))
    // rust: .unwrap();
    // rust: game.handle_packet(C::PlayerPosition(play::PlayerPosition {
    // rust: teleport: 1,
    // rust: position: [0.5, 65.0, 0.5],
    // rust: delta: [0.0; 3],
    // rust: yaw: 45.0,
    // rust: pitch: 10.0,
    // rust: relatives: 0,
    // rust: }))
    // rust: .unwrap();
    // rust: game.handle_packet(C::AddEntity(play::AddEntity {
    // rust: id: 21,
    // rust: uuid: 0x0011_2233_4455_6677_8899_aabb_ccdd_eeff,
    // rust: kind,
            // Within 32 blocks of the camera, which starts at the origin: the
            // particle engine drops a particle farther away than that.
    // rust: position: [1.5, 1.0, 2.5],
    // rust: velocity: [0.0; 3],
    // rust: pitch: 0,
    // rust: yaw: 64,
    // rust: head_yaw: 64,
    // rust: data: 0,
    // rust: }))
    // rust: .unwrap();
        // `len` counts only particles already ticked in; `made` counts every
        // particle created, which is what the event handler does at once.
    // rust: let made = |g: &Game| g.particles.made().values().sum::<u64>();
    // rust: let before = made(&game);
    // rust: game.handle_packet(C::EntityEvent(play::EntityEvent { id: 21, event: 2 }))
    // rust: .unwrap();
    // rust: assert_eq!(made(&game), before, "event 2 has no particle row");
    // rust: game.handle_packet(C::EntityEvent(play::EntityEvent { id: 21, event: 42 }))
    // rust: .unwrap();
    // rust: assert!(made(&game) > before, "event 42 draws the sweat");
}
}
