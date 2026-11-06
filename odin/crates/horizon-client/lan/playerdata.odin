//! Transpiled from Horizon Rust crate
package horizon_client_playerdata

import "core:fmt"
import "core:mem"
import "core:math"

// Guests' saved state: `players/data/<uuid>.dat` in the vanilla player
// compound, through the same code that saves the host.
// use super::guest::{Guest, SavedBody};
// use crate::{
    // rust: items::ItemStack,
    // rust: save::{Level, put, read_dat, uuid_from_tag, write_dat},
}
// use horizon_protocol::crypto::uuid_string;
// use horizon_world::{
    // rust: attachments::{ATTACHMENTS_KEY, attachment_compound},
    // rust: nbt::Tag,
}
// use std::{
    // rust: path::{Path, PathBuf},
    // rust: sync::Arc,
}

// `PlayerDataStorage`'s player directory (`players/data`), created on first use
// as its constructor does with `mkdirs`.
directory :: proc(world: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let dir = directory_path(world);
    // rust: if let Err(e) = std::fs::create_dir_all(&dir) {
    // rust: log::warn!("Horizon: {} is not created: {e}", dir.display());
}
    // rust: dir
}

directory_path :: proc(world: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: world.join("players").join("data")
}

path :: proc(world: ^Path, uuid: u128) -> P {
    // Ported from Horizon
    return {}
}
    // rust: directory_path(world).join(format!("{}.dat", uuid_string(uuid)))
}

// `UUIDUtil.uuidToIntArray`.
uuid_ints :: proc(uuid: u128) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: (uuid >> 96) as i32,
    // rust: (uuid >> 64) as i32,
    // rust: (uuid >> 32) as i32,
    // rust: uuid as i32,
    // rust: ]
}
// `UUIDUtil.uuidFromIntArray`.
ints_uuid :: proc(ints: [i32; 4]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ints.iter()
    // rust: .fold(0, |acc, &i| acc << 32 | u128::from(i as u32))
}

// Whether a saved file exists for this player.
exists :: proc(world: ^Path, uuid: u128) -> b {
    // Ported from Horizon
    return {}
}
    // rust: path(world, uuid).is_file()
}

// `PlayerDataStorage.load`: a guest's saved state, if they have been here
// before. The player's file, else its `.dat_old` (what a save cut off
// between its two renames leaves, `write_dat`).
load :: proc(guest: ^Guest, world: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let file = path(world, guest.uuid);
    // rust: let Some(tag) = read_dat(&file).or_else(|| read_dat(&file.with_extension("dat_old"))) else {
    // rust: return false;
}
    // rust: let mut level = Level {
    // rust: health: 20.0,
    // rust: food: 20,
    // rust: saturation: 5.0,
    // rust: ..Level::default()
}
    // rust: level.read_player(&tag);
    // rust: level.player_extra = Some(tag);
    // rust: apply(guest, &level);
    // rust: true
}

// `PlayerList.loadPlayerData` for the world's single-player owner: the file
// level.dat names (`singleplayer_uuid`), as the world opening read it into
// `saved`, before the owner's own file. Builds that save the owner to the
// named file alone (0.2.93) leave the own file behind, stale (#5351). The
// own file is for a world whose named file is missing; then the player the
// world opening found instead (the newest player file, the legacy
// `Data.Player`, or nothing in a new world). Returns whether the player has
// been in this world before.
load_owner :: proc(guest: ^Guest, world: ^Path, saved: Maybe(^Level)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(level) = saved.filter(|l| l.singleplayer_file) {
    // rust: apply(guest, level);
    // rust: return level.position.is_some();
}
    // rust: if load(guest, world) {
    // rust: return true;
}
    // rust: saved.is_some_and(|level| {
    // rust: apply(guest, level);
    // rust: level.position.is_some()
    // rust: })
}

// Save the world's single-player owner: its state into `level` (`store`),
// then to the file level.dat names, which it loads ([`load_owner`]), and to
// its own file, so that the one it loads is never the older of the two.
save_owner :: proc(guest: ^Guest, level: ^Level, world: ^Path) {
}
    // `MinecraftServer.saveAllChunks`: `singleplayer_uuid` is the integrated server's own profile,
    // never another player's file the world happened to hold.
    // rust: level.player_uuid.get_or_insert(uuid_ints(guest.uuid));
    // rust: store(guest, level, None);
    // rust: if let Err(e) = level.write_player(world) {
    // rust: log::warn!("Horizon: the owner's playerdata is not saved: {e}");
}
    // rust: save(guest, world);
}

// A player new to the world faces the world spawn's angle (`PrepareSpawnTask`:
// the saved rotation, else `respawnData.yaw/pitch`).
face_world_spawn :: proc(guest: ^Guest, known: bool, pitch]: [f32; 2]) {
}
    // rust: if known {
    // rust: return;
}
    // rust: guest.yaw = yaw;
    // rust: guest.pitch = pitch;
    // rust: guest.head_yaw = yaw;
}

// Give a guest the player state read into `level`.
apply :: proc(guest: ^Guest, level: ^Level) {
}
    // rust: if let Some(p) = level.position {
    // rust: guest.position = p;
    // rust: guest.previous_position = p;
}
    // rust: guest.yaw = level.rotation[0];
    // rust: guest.pitch = level.rotation[1];
    // rust: guest.head_yaw = guest.yaw;
    // rust: guest.on_ground = level.on_ground;
    // rust: guest.health = level.health;
    // rust: guest.saved_absorption = Some(level.absorption);
    // rust: guest.food = level.food;
    // rust: guest.saturation = level.saturation;
    // rust: guest.xp_level = level.xp_level;
    // rust: guest.xp_progress = level.xp_progress;
    // rust: guest.xp_total = level.xp_total;
    // rust: guest.xp_seed = level.xp_seed;
    // rust: guest.effects = crate::effects::PlayerEffects::from_saved(&level.active_effects);
    // rust: guest.game_mode = level.mode();
    // rust: guest.previous_game_mode = level.previous_game_mode;
    // rust: guest.flying = level.flying;
    // rust: guest.flying_speed = level.fly_speed.filter(|s| s.is_finite()).unwrap_or(0.05);
    // rust: guest.selected = (level.selected_slot.max(0) as usize).min(8);
    // A point that is the world spawn is none of the player's own: it
    // respawns wherever the world spawn is then (`setworldspawn`).
    // rust: guest.spawn = level
    // rust: .spawn
    // rust: .filter(|s| Some(s.map(|v| v.floor() as i32)) != level.world_spawn)
    // rust: .map(|s| [s[0] + 0.5, s[1], s[2] + 0.5]);
    // rust: guest.respawn_elsewhere = level.respawn_elsewhere.clone();
    // rust: guest.saved = level.player_extra.clone();
    // rust: guest.attachments = match attachment_compound(
    // rust: guest
    // rust: .saved
    // rust: .as_ref()
    // rust: .and_then(|tag| tag.get(ATTACHMENTS_KEY)),
    // rust: ) {
    // rust: Ok(Some(data)) => horizon_world::attachments::Attachments::from_nbt(data.clone()),
    // rust: _ => Default::default(),
}
    // rust: guest.seen_credits = level.seen_credits;
    // rust: guest.post_effects.clone_from(&level.post_effects);
    // rust: guest.last_death = level.last_death.clone();
    // rust: let extra = level.player_extra.as_ref();
    // rust: let short = |key: &str, default: i64| {
    // rust: extra
    // rust: .and_then(|t| crate::save::number(t.get(key)))
    // rust: .unwrap_or(default) as i32
}
    // Entity.load: a component of Motion over 10 blocks a tick reads as 0.
    // rust: let motion = level.motion.map(|v| if v.abs() > 10.0 { 0.0 } else { v });
    // rust: guest.loaded_body = Some(SavedBody {
    // rust: fire_ticks: short("Fire", -20),
    // rust: air: short("Air", 300),
    // rust: fall_distance: level.fall_distance,
    // rust: velocity: motion,
    // rust: food_exhaustion: level.food_exhaustion,
    // rust: food_tick_timer: level.food_tick_timer,
    // rust: ticks_frozen: short("TicksFrozen", 0),
    // rust: });
    // rust: guest.saved_vehicle = level.root_vehicle;
    // rust: guest.recipe_book = level.recipe_book.clone();
    // rust: guest.dimension = match level.dimension.as_str() {
    // rust: d @ ("minecraft:the_nether" | "minecraft:the_end") => d.to_owned(),
    // rust: _ => "minecraft:overworld".to_owned(),
}
    // rust: if level.ender_items.len() == 27 {
    // rust: guest.ender_items = level.ender_items.clone();
}
    // rust: for (slot, item, count, damage) in &level.inventory {
    // rust: let mut stack = ItemStack {
    // rust: item: Arc::from(item.as_str()),
    // rust: count: *count,
    // rust: damage: *damage,
    // rust: extra: level.inventory_components.get(slot).cloned(),
}
    // rust: if stack.count == 0 {
    // rust: stack.count = 1;
}
    // rust: match *slot {
    // rust: 0..=35 => guest.inventory[usize::from(*slot)] = Some(stack),
    // rust: 100 => guest.armor[3] = Some(stack),
    // rust: 101 => guest.armor[2] = Some(stack),
    // rust: 102 => guest.armor[1] = Some(stack),
    // rust: 103 => guest.armor[0] = Some(stack),
    // rust: 150 => guest.offhand = Some(stack),
    // rust: _ => {}
}
}
}

// The shared player compound for logout and autosave snapshots, and for
// `player-export`'s record (`arrivals::export_record`).
player_tag :: proc(guest: ^Guest) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut level = Level {
    // rust: player_uuid: Some(uuid_ints(guest.uuid)),
    // rust: ..Level::default()
}
    // rust: store(guest, &mut level, None);
    // rust: level.player_tag()
}

// Save a leaving guest, including its saved vehicle tree.
save :: proc(guest: ^Guest, world: ^Path) {
}
    // rust: let file = path(world, guest.uuid);
    // rust: if let Err(e) = write_dat(&file, player_tag(guest)) {
    // rust: log::warn!("Horizon: {} is not saved: {e}", file.display());
}
}

// [`save`], synced to the disk and saying whether the file was written: a hand-over's commit
// point (`player-confirm`) answers only once it is.
save_now :: proc(guest: ^Guest, world: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let file = path(world, guest.uuid);
    // rust: crate::save::write_dat_durable(&file, player_tag(guest))
    // rust: .map_err(|e| format!("{} is not saved: {e}", file.display()))
}

// An immutable player snapshot. Compression and all filesystem work belong to
// the writer; native callbacks are delivered by the server after completion.
Snapshot :: struct {
    uuid: u128,
    name: string,
    file: PathBuf,
    tag: Tag,
}

SavedPlayer :: struct {
    uuid: u128,
    name: string,
}

write_snapshot :: proc(snapshot: Snapshot) -> R {
    // Ported from Horizon
    return {}
}
    // rust: write_dat(&snapshot.file, snapshot.tag)
    // rust: .map(|()| SavedPlayer {
    // rust: uuid: snapshot.uuid,
    // rust: name: snapshot.name,
    // rust: })
    // rust: .map_err(|e| format!("{} is not saved: {e}", snapshot.file.display()))
}

PlayerWriter :: struct {
    send: std::sync::mpsc::Sender<Snapshot>,
    done: std::sync::mpsc::Receiver<Result<SavedPlayer,
    thread: std::thread::JoinHandle<()>,
}

// One FIFO writer for a server's player autosaves. Synchronous logout writes
// must follow a barrier, so an older autosave can never replace them later.
Autosaves :: struct {
    writer: Maybe(PlayerWriter),
    pending: uint,
    error: Maybe(string),
    ready: [dynamic]SavedPlayer,
}

    // rust: impl Autosaves {
enqueue :: proc(self: ^Self, guest: ^Guest, world: ^Path) {
}
    // rust: let snapshot = Snapshot {
    // rust: uuid: guest.uuid,
    // rust: name: guest.name.clone(),
    // rust: file: path(world, guest.uuid),
    // rust: tag: player_tag(guest),
}
    // rust: if self.writer.is_none() {
    // rust: let (send, receive) = std::sync::mpsc::channel::<Snapshot>();
    // rust: let (complete, done) = std::sync::mpsc::channel();
    // rust: match std::thread::Builder::new()
    // rust: .name("horizon-player-writer".into())
    // rust: .spawn(move || {
    // rust: for snapshot in receive {
    // rust: let _ = complete.send(write_snapshot(snapshot));
}
    // rust: }) {
    // rust: Ok(thread) => self.writer = Some(PlayerWriter { send, done, thread }),
    // rust: Err(error) => {
    // rust: log::warn!("Horizon: cannot start player writer, saving inline: {error}")
}
}
}
    // rust: let snapshot = if let Some(writer) = &self.writer {
    // rust: match writer.send.send(snapshot) {
    // rust: Ok(()) => {
    // rust: self.pending += 1;
    // rust: return;
}
    // rust: Err(error) => {
    // rust: let completed = self.completed(true);
    // rust: self.ready.extend(completed);
    // rust: if let Some(writer) = self.writer.take() {
    // rust: drop(writer.send);
    // rust: let _ = writer.thread.join();
}
    // rust: error.0
}
}
    // rust: } else {
    // rust: snapshot
}
    // rust: match write_snapshot(snapshot) {
    // rust: Ok(player) => self.ready.push(player),
    // rust: Err(error) => {
    // rust: log::warn!("Horizon: {error}");
    // rust: self.error = Some(error);
}
}
}

    // Serialize a newer logout snapshot after every queued autosave.
save_after :: proc(self: ^Self, guest: ^Guest, world: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let saved = self.completed(true);
    // rust: save(guest, world);
    // rust: saved
}

    // Drain completions on the tick thread; `wait` is the durability barrier
    // for explicit saves, logout, and shutdown. Failures remain visible.
completed :: proc(self: ^Self, wait: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut saved = std::mem::take(&mut self.ready);
    // rust: while self.pending > 0 {
    // rust: let done = &self.writer.as_ref().unwrap().done;
    // rust: let result = if wait {
    // rust: done.recv()
    // rust: .map_err(|_| std::sync::mpsc::TryRecvError::Disconnected)
    // rust: } else {
    // rust: done.try_recv()
}
    // rust: match result {
    // rust: Ok(result) => {
    // rust: self.pending -= 1;
    // rust: match result {
    // rust: Ok(player) => saved.push(player),
    // rust: Err(error) => {
    // rust: log::warn!("Horizon: {error}");
    // rust: self.error = Some(error);
}
}
}
    // rust: Err(std::sync::mpsc::TryRecvError::Empty) => break,
    // rust: Err(std::sync::mpsc::TryRecvError::Disconnected) => {
    // rust: self.error = Some("the player writer stopped".into());
    // rust: log::warn!("Horizon: the player writer stopped");
    // rust: self.pending = 0;
    // rust: if let Some(writer) = self.writer.take() {
    // rust: drop(writer.send);
    // rust: let _ = writer.thread.join();
}
}
}
}
    // rust: saved
}

writes_finished :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
    // rust: match self.error.take() {
    // rust: Some(error) => Err(error.into()),
    // rust: None => Ok(self.pending == 0),
}
}
}

    // rust: impl Drop for Autosaves {
drop :: proc(self: ^Self) {
}
    // rust: if let Some(writer) = self.writer.take() {
    // rust: drop(writer.send);
    // rust: let _ = writer.thread.join();
}
}
}

// Put a guest's state in `level`'s player fields; `vehicle` is the
// RootVehicle compound of the ride (`ServerPlayer.saveParentVehicle`).
store :: proc(guest: ^Guest, level: ^Level, vehicle: Maybe(Tag)) {
}
    // rust: level.position = Some(guest.position);
    // rust: level.dimension = guest.dimension.clone();
    // rust: level.rotation = [guest.yaw, guest.pitch];
    // rust: level.health = guest.health;
    // rust: level.absorption = guest
    // rust: .motion
    // rust: .as_ref()
    // rust: .map_or(guest.saved_absorption.unwrap_or(0.0), |m| {
    // rust: m.health.absorption()
    // rust: });
    // rust: level.food = guest.food;
    // rust: level.saturation = guest.saturation;
    // rust: level.xp_level = guest.xp_level;
    // rust: level.xp_progress = guest.xp_progress;
    // rust: level.xp_total = guest.xp_total;
    // rust: level.xp_seed = guest.xp_seed;
    // rust: level.active_effects = guest.effects.saved();
    // rust: level.game_mode = guest.game_mode;
    // ServerPlayer.addAdditionalSaveData: previousPlayerGameType, when there
    // is one (storeNullable).
    // rust: level.previous_game_mode = guest.previous_game_mode;
    // rust: level.creative = guest.game_mode == 1;
    // rust: level.flying = guest.flying;
    // rust: level.fly_speed = Some(guest.flying_speed);
    // rust: level.selected_slot = guest.selected as i32;
    // rust: level.spawn = guest.spawn.map(|s| [s[0] - 0.5, s[1], s[2] - 0.5]);
    // rust: level.respawn_elsewhere = guest.respawn_elsewhere.clone();
    // rust: level.on_ground = guest.on_ground;
    // rust: level.seen_credits = guest.seen_credits;
    // rust: level.post_effects.clone_from(&guest.post_effects);
    // rust: level.last_death = guest.last_death.clone();
    // rust: level.player_extra = guest.saved.clone();
    // rust: let extra = level
    // rust: .player_extra
    // rust: .get_or_insert_with(|| Tag::Compound(Default::default()));
    // rust: if let Tag::Compound(map) = extra
    // rust: && attachment_compound(map.get(&ATTACHMENTS_KEY.into())).is_ok()
    // rust: {
    // rust: let data = guest.attachments.to_nbt();
    // rust: if data.is_empty() {
    // rust: map.remove(&ATTACHMENTS_KEY.into());
    // rust: } else {
    // rust: map.insert(ATTACHMENTS_KEY.into(), Tag::Compound(data));
}
}
    // The vehicle the player rides (`ServerPlayer.saveParentVehicle`), or
    // the one its file names that has not come back yet (kept in `saved`).
    // rust: level.root_vehicle = guest.saved_vehicle;
    // rust: if let Some(vehicle) = vehicle {
    // rust: level.root_vehicle = uuid_from_tag(vehicle.get("Attach"));
    // rust: let extra = level
    // rust: .player_extra
    // rust: .get_or_insert_with(|| Tag::Compound(Default::default()));
    // rust: put(extra, "RootVehicle", vehicle);
}
    // The live body's fire, air, fall distance and motion
    // (Entity.saveWithoutId), or what the file had while the player has no
    // body yet.
    // rust: let body = guest
    // rust: .motion
    // rust: .as_deref()
    // rust: .map(SavedBody::of)
    // rust: .or(guest.loaded_body);
    // rust: if let Some(body) = body {
    // rust: level.fall_distance = body.fall_distance;
    // rust: level.motion = body.velocity;
        // FoodData.addAdditionalSaveData: the exhaustion and the timer that
        // regenerates or starves the player go with the food level.
    // rust: level.food_exhaustion = body.food_exhaustion;
    // rust: level.food_tick_timer = body.food_tick_timer;
    // rust: let extra = level
    // rust: .player_extra
    // rust: .get_or_insert_with(|| horizon_world::nbt::Tag::Compound(Default::default()));
    // rust: if let horizon_world::nbt::Tag::Compound(map) = extra {
    // rust: let short = |v: i32| horizon_world::nbt::Tag::Short(v.clamp(-32768, 32767) as i16);
    // rust: map.insert("Fire".into(), short(body.fire_ticks));
    // rust: map.insert("Air".into(), short(body.air));
            // Entity.saveWithoutId writes TicksFrozen only above 0, so a
            // count from the file the player thawed since does not come back.
    // rust: if body.ticks_frozen > 0 {
    // rust: map.insert(
    // rust: "TicksFrozen".into(),
    // rust: horizon_world::nbt::Tag::Int(body.ticks_frozen),
    // rust: );
    // rust: } else {
    // rust: map.remove(&"TicksFrozen".into());
}
}
}
    // LivingEntity.addAdditionalSaveData: the live body's AttributeMap.pack,
    // or the list the file had while the player has no body yet.
    // A player between two bodies (a respawn, a change of level) saves what
    // the next one takes over.
    // rust: let attributes = guest
    // rust: .motion
    // rust: .as_deref()
    // rust: .map(crate::motion::PlayerMotion::saved_attributes)
    // rust: .or_else(|| guest.carried_attributes.clone());
    // rust: if let Some(attributes) = attributes {
    // rust: let extra = level
    // rust: .player_extra
    // rust: .get_or_insert_with(|| horizon_world::nbt::Tag::Compound(Default::default()));
    // rust: if let horizon_world::nbt::Tag::Compound(map) = extra {
    // rust: map.insert("attributes".into(), attributes);
}
}
    // rust: level.recipe_book = guest.recipe_book.clone();
    // rust: level.ender_items = guest.ender_items.clone();
    // rust: level.inventory.clear();
    // rust: level.inventory_components.clear();
    // rust: let mut put = |slot: u8, stack: &Option<ItemStack>| {
    // rust: if let Some(s) = stack {
    // rust: level
    // rust: .inventory
    // rust: .push((slot, s.item.to_string(), s.count, s.damage));
    // rust: if let Some(extra) = &s.extra {
    // rust: level.inventory_components.insert(slot, extra.clone());
}
}
}
    // rust: for (i, s) in guest.inventory.iter().enumerate() {
    // rust: put(i as u8, s);
}
    // rust: put(103, &guest.armor[0]);
    // rust: put(102, &guest.armor[1]);
    // rust: put(101, &guest.armor[2]);
    // rust: put(100, &guest.armor[3]);
    // rust: put(150, &guest.offhand);
}

    // rust: mod tests {
//     use super::*;
//     use crate::lan::{Joined, PlayerSender};
//     use horizon_protocol::packets::configuration::ClientInformation;
//     use std::sync::{Arc, atomic::AtomicI32, mpsc};

guest :: proc() -> G {
    // Ported from Horizon
    return {}
}
    // rust: let (tx, _rx) = mpsc::channel();
    // rust: Guest::new(
    // rust: Joined {
    // rust: conn: 2,
    // rust: uuid: 2,
    // rust: name: "Alex".into(),
    // rust: properties: Vec::new(),
    // rust: info: ClientInformation::new(8),
    // rust: brand: "test".into(),
    // rust: sender: PlayerSender::new(tx, Arc::default()),
    // rust: latency: Arc::new(AtomicI32::new(0)),
    // rust: address: "127.0.0.1:25565".parse().unwrap(),
    // rust: expected: false,
    // rust: },
    // rust: 2,
    // rust: [0.0, 64.0, 0.0],
    // rust: 8,
    // rust: )
}

a_new_player_faces_the_world_spawn_angle :: proc() {
}
    // rust: let mut g = guest();
    // rust: face_world_spawn(&mut g, false, [90.0, -15.0]);
    // rust: assert_eq!((g.yaw, g.pitch, g.head_yaw), (90.0, -15.0, 90.0));
}

a_saved_rotation_beats_the_world_spawn_angle :: proc() {
}
    // rust: let mut g = guest();
    // rust: let level = Level {
    // rust: rotation: [-135.0, 30.0],
    // rust: ..Level::default()
}
    // rust: apply(&mut g, &level);
    // rust: face_world_spawn(&mut g, true, [90.0, -15.0]);
    // rust: assert_eq!((g.yaw, g.pitch, g.head_yaw), (-135.0, 30.0, -135.0));
}

holding :: proc(uuid: u128, item: string, count: u32) -> G {
    // Ported from Horizon
    return {}
}
    // rust: let mut g = guest();
    // rust: g.uuid = uuid;
    // rust: g.position = [10.5, 70.0, -3.5];
    // rust: g.inventory[0] = Some(ItemStack {
    // rust: item: Arc::from(item),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
    // rust: });
    // rust: g
}

world :: proc(name: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-owner-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: dir
}

autosaves_keep_snapshots_and_order_before_logout :: proc() {
}
    // rust: let dir = world("async-batch");
    // rust: let mut saves = Autosaves::default();
    // rust: for uuid in 1..=150 {
    // rust: let mut g = holding(uuid, "minecraft:diamond", 5);
    // rust: saves.enqueue(&g, &dir);
            // Subsequent live changes cannot alter the queued snapshot.
    // rust: g.inventory[0] = None;
}
    // rust: let completed = saves.completed(true);
    // rust: assert!(saves.writes_finished().unwrap());
    // rust: assert!(completed.iter().map(|p| p.uuid).eq(1..=150));
    // rust: for uuid in 1..=150 {
    // rust: let mut loaded = guest();
    // rust: loaded.uuid = uuid;
    // rust: assert!(load(&mut loaded, &dir));
    // rust: assert_eq!(first_item(&loaded), Some(("minecraft:diamond", 5)));
}
    // rust: saves.enqueue(&holding(1, "minecraft:gold_ingot", 7), &dir);
    // rust: saves.enqueue(&holding(1, "minecraft:emerald", 9), &dir);
    // rust: assert_eq!(saves.completed(true).len(), 2);
    // rust: assert!(saves.writes_finished().unwrap());
    // rust: let mut loaded = guest();
    // rust: loaded.uuid = 1;
    // rust: assert!(load(&mut loaded, &dir));
    // rust: assert_eq!(first_item(&loaded), Some(("minecraft:emerald", 9)));
        // The barrier protects the synchronous, newer logout snapshot.
    // rust: for uuid in 1..=150 {
    // rust: saves.enqueue(&holding(uuid, "minecraft:diamond", 5), &dir);
}
    // rust: saves.save_after(&holding(1, "minecraft:iron_ingot", 11), &dir);
    // rust: drop(saves);
    // rust: assert!(load(&mut loaded, &dir));
    // rust: assert_eq!(first_item(&loaded), Some(("minecraft:iron_ingot", 11)));
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

autosave_failures_recover_and_drop_drains_writes :: proc() {
}
    // rust: let dir = world("async-error");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join("players"), b"not a directory").unwrap();
    // rust: let mut saves = Autosaves::default();
    // rust: saves.enqueue(&holding(1, "minecraft:diamond", 5), &dir);
    // rust: assert!(saves.completed(true).is_empty());
    // rust: assert!(saves.writes_finished().is_err());
    // rust: assert!(saves.completed(false).is_empty());
    // rust: assert!(saves.writes_finished().unwrap());
    // rust: drop(saves);
    // rust: std::fs::remove_file(dir.join("players")).unwrap();
    // rust: let mut saves = Autosaves::default();
    // rust: saves.enqueue(&holding(1, "minecraft:diamond", 5), &dir);
    // rust: for uuid in 2..=150 {
    // rust: saves.enqueue(&holding(uuid, "minecraft:diamond", 5), &dir);
}
    // rust: drop(saves);
    // rust: for uuid in 1..=150 {
    // rust: let mut g = guest();
    // rust: g.uuid = uuid;
    // rust: assert!(load(&mut g, &dir));
    // rust: assert_eq!(first_item(&g), Some(("minecraft:diamond", 5)));
}
    // rust: let mut loaded = guest();
    // rust: loaded.uuid = 1;
    // rust: assert!(load(&mut loaded, &dir));
    // rust: assert_eq!(first_item(&loaded), Some(("minecraft:diamond", 5)));
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

mixed_autosaves_keep_successes_and_match_logout_files :: proc() {
}
    // rust: let bad = world("mixed-bad");
    // rust: let good = world("mixed-good");
    // rust: let reference = world("mixed-reference");
    // rust: std::fs::create_dir_all(&bad).unwrap();
    // rust: std::fs::write(bad.join("players"), b"not a directory").unwrap();
    // rust: let mut saves = Autosaves::default();
    // rust: let g = holding(2, "minecraft:emerald", 9);
    // rust: saves.enqueue(&holding(1, "minecraft:diamond", 5), &bad);
    // rust: saves.enqueue(&g, &good);
    // rust: saves.enqueue(&holding(3, "minecraft:diamond", 5), &bad);
    // rust: let saved = saves.completed(true);
    // rust: assert_eq!(saved.iter().map(|p| p.uuid).collect::<Vec<_>>(), vec![2]);
    // rust: assert!(saves.writes_finished().is_err());
    // rust: assert!(saves.writes_finished().unwrap());
    // rust: save(&g, &reference);
    // rust: assert_eq!(
    // rust: read_dat(&path(&good, 2)).unwrap(),
    // rust: read_dat(&path(&reference, 2)).unwrap()
    // rust: );
    // rust: std::fs::remove_file(bad.join("players")).unwrap();
    // rust: saves.enqueue(&g, &bad);
    // rust: assert_eq!(saves.completed(true).len(), 1);
    // rust: assert!(saves.writes_finished().unwrap());
    // rust: for dir in [bad, good, reference] {
    // rust: std::fs::remove_dir_all(dir).unwrap();
}
}

a_disconnected_writer_is_restarted :: proc() {
}
    // rust: let dir = world("restart");
    // rust: let (send, receive) = std::sync::mpsc::channel();
    // rust: drop(receive);
    // rust: let (complete, done) = std::sync::mpsc::channel();
    // rust: drop(complete);
    // rust: let mut saves = Autosaves::default();
    // rust: saves.writer = Some(PlayerWriter {
    // rust: send,
    // rust: done,
    // rust: thread: std::thread::spawn(|| {}),
    // rust: });
    // rust: saves.pending = 1;
    // rust: saves.enqueue(&holding(1, "minecraft:diamond", 5), &dir);
    // rust: assert_eq!(saves.completed(true).len(), 1);
    // rust: assert!(saves.writes_finished().is_err());
    // rust: saves.enqueue(&holding(2, "minecraft:emerald", 9), &dir);
    // rust: assert!(saves.writer.is_some());
    // rust: assert_eq!(saves.completed(true).len(), 1);
    // rust: assert!(saves.writes_finished().unwrap());
    // rust: std::fs::remove_dir_all(dir).unwrap();
}

first_item :: proc(g: ^Guest) -> O {
    // Ported from Horizon
    return {}
}
    // rust: g.inventory[0].as_ref().map(|s| (&*s.item, s.count))
}

the_owner_loads_the_file_level_dat_names_over_an_older_own_file :: proc() {
}
        // #5351: a newer build saved the owner to both files, then 0.2.93 saved
        // it again to the file level.dat names alone. The owner's own file is
        // older; vanilla's loadPlayerData reads the named one for the owner.
    // rust: let owner = horizon_protocol::crypto::offline_uuid("Player46606");
    // rust: let dir = world("named");
    // rust: save(&holding(owner, "minecraft:diamond", 5), &dir);
    // rust: let mut level = Level::default();
    // rust: store(&holding(owner, "minecraft:gold_ingot", 7), &mut level, None);
    // rust: level.write(&dir).unwrap();
    // rust: let named = ints_uuid(level.player_uuid.unwrap());
    // rust: assert_ne!(
    // rust: named, owner,
    // rust: "level.dat names offline `Player`, not the owner"
    // rust: );
    // rust: let saved = Level::read(&dir).unwrap();
    // rust: let mut g = guest();
    // rust: g.uuid = owner;
    // rust: assert!(load_owner(&mut g, &dir, Some(&saved)));
    // rust: assert_eq!(first_item(&g), Some(("minecraft:gold_ingot", 7)));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

the_owner_loads_its_own_file_when_the_named_one_is_missing :: proc() {
}
    // rust: let owner = horizon_protocol::crypto::offline_uuid("Player46606");
    // rust: let dir = world("own");
    // rust: let mut level = Level::default();
    // rust: level.write_without_player(&dir).unwrap();
    // rust: save(&holding(owner, "minecraft:diamond", 5), &dir);
    // rust: let saved = Level::read(&dir).unwrap();
    // rust: let mut g = guest();
    // rust: g.uuid = owner;
    // rust: assert!(load_owner(&mut g, &dir, Some(&saved)));
    // rust: assert_eq!(first_item(&g), Some(("minecraft:diamond", 5)));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

player_attachments_survive_playerdata_and_respawn :: proc() {
}
//         use horizon_world::attachments::{AttachmentCodec, AttachmentError, AttachmentType};
    // rust: let keep = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "keep",
    // rust: default: || 0,
    // rust: codec: Some(AttachmentCodec {
    // rust: encode: |n: &i32| Ok([("count".into(), Tag::Int(*n))].into()),
    // rust: decode: |c| match c.get(&"count".into()) {
    // rust: Some(Tag::Int(n)) => Ok(*n),
    // rust: _ => Err(AttachmentError::Decode),
    // rust: },
    // rust: }),
    // rust: copy_on_death: true,
    // rust: sync: false,
}
    // rust: let dir = world("attachments");
    // rust: let mut original = guest();
    // rust: original.attachments.set(&keep, 31).unwrap();
    // rust: save(&original, &dir);
    // rust: let mut loaded = guest();
    // rust: loaded.uuid = original.uuid;
    // rust: assert!(load(&mut loaded, &dir));
    // rust: loaded.attachments = loaded.attachments.copy_on_death().unwrap();
    // rust: assert_eq!(loaded.attachments.get(&keep), Ok(31));
    // rust: let _ = std::fs::remove_dir_all(dir);
}

a_save_cut_off_between_its_renames_loads_the_dat_old :: proc() {
}
        // PlayerDataStorage.load: a file `write_dat` moved to `.dat_old` and
        // did not replace (the game stopped between the two renames) is read
        // instead, for the owner's named file and for anyone's own file.
    // rust: let owner = horizon_protocol::crypto::offline_uuid("Player46606");
    // rust: let dir = world("dat-old");
    // rust: let mut level = Level::default();
    // rust: for (item, count) in [("minecraft:diamond", 5), ("minecraft:gold_ingot", 7)] {
    // rust: store(&holding(owner, item, count), &mut level, None);
    // rust: level.write(&dir).unwrap();
    // rust: save(&holding(owner, item, count), &dir);
}
    // rust: let named = path(&dir, ints_uuid(level.player_uuid.unwrap()));
    // rust: for file in [&named, &path(&dir, owner)] {
    // rust: std::fs::remove_file(file).unwrap();
    // rust: assert!(file.with_extension("dat_old").is_file());
}
    // rust: let saved = Level::read(&dir).unwrap();
    // rust: assert!(saved.singleplayer_file, "the named file's .dat_old counts");
    // rust: let mut g = guest();
    // rust: g.uuid = owner;
    // rust: assert!(load_owner(&mut g, &dir, Some(&saved)));
    // rust: assert_eq!(first_item(&g), Some(("minecraft:diamond", 5)));
    // rust: let mut g = guest();
    // rust: g.uuid = owner;
    // rust: assert!(load(&mut g, &dir), "a guest's own file falls back too");
    // rust: assert_eq!(first_item(&g), Some(("minecraft:diamond", 5)));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

the_owner_leaving_saves_the_file_it_loads :: proc() {
}
        // The last autosave wrote both files with a diamond; the owner leaves
        // with gold and the game stops before the world's own save. The file
        // the owner loads holds the gold, as its own file does.
    // rust: let owner = horizon_protocol::crypto::offline_uuid("Player46606");
    // rust: let dir = world("leave");
    // rust: let mut level = Level::default();
    // rust: store(&holding(owner, "minecraft:diamond", 5), &mut level, None);
    // rust: level.write(&dir).unwrap();
    // rust: save(&holding(owner, "minecraft:diamond", 5), &dir);
    // rust: save_owner(&holding(owner, "minecraft:gold_ingot", 7), &mut level, &dir);
    // rust: let saved = Level::read(&dir).unwrap();
    // rust: let mut g = guest();
    // rust: g.uuid = owner;
    // rust: assert!(load_owner(&mut g, &dir, Some(&saved)));
    // rust: assert_eq!(first_item(&g), Some(("minecraft:gold_ingot", 7)));
    // rust: let mut g = guest();
    // rust: g.uuid = owner;
    // rust: assert!(load(&mut g, &dir));
    // rust: assert_eq!(first_item(&g), Some(("minecraft:gold_ingot", 7)));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

a_saved_burn_and_fall_come_back :: proc() {
}
        // A player saved burning in mid-fall (#1323, #1327): Entity.saveWithoutId's
        // Fire, Air and fall_distance, read back for the next body.
    // rust: let mut g = guest();
    // rust: g.loaded_body = Some(SavedBody {
    // rust: fire_ticks: 96,
    // rust: air: 250,
    // rust: fall_distance: 9.5,
    // rust: velocity: [0.0; 3],
    // rust: food_exhaustion: 0.0,
    // rust: food_tick_timer: 0,
    // rust: ticks_frozen: 0,
    // rust: });
    // rust: let mut level = Level::default();
    // rust: store(&g, &mut level, None);
    // rust: let tag = level.player_tag();
    // rust: let mut read = Level::default();
    // rust: read.read_player(&tag);
    // rust: read.player_extra = Some(tag);
    // rust: let mut back = guest();
    // rust: apply(&mut back, &read);
    // rust: assert_eq!(back.loaded_body, g.loaded_body);
}

    // Store, write, read and apply a guest's file, as a server does between a
    // leave and the next join.
round_trip :: proc(g: ^Guest) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut level = Level::default();
    // rust: store(g, &mut level, None);
    // rust: let tag = level.player_tag();
    // rust: let mut read = Level::default();
    // rust: read.read_player(&tag);
    // rust: read.player_extra = Some(tag.clone());
    // rust: let mut back = guest();
    // rust: apply(&mut back, &read);
    // rust: (tag, back)
}

a_saved_motion_comes_back :: proc() {
}
        // Entity.saveWithoutId writes Motion, the delta movement, as it is;
        // Entity.load reads each component back, as 0 when it is over 10.
    // rust: let mut g = guest();
    // rust: g.loaded_body = Some(SavedBody {
    // rust: fire_ticks: -20,
    // rust: air: 300,
    // rust: fall_distance: 0.0,
    // rust: velocity: [0.25, -0.0784, 12.5],
    // rust: food_exhaustion: 0.0,
    // rust: food_tick_timer: 0,
    // rust: ticks_frozen: 0,
    // rust: });
    // rust: let (tag, back) = round_trip(&g);
    // rust: let mut read = Level::default();
    // rust: read.read_player(&tag);
    // rust: assert_eq!(read.motion, [0.25, -0.0784, 12.5]);
    // rust: assert_eq!(
    // rust: back.loaded_body.expect("a body").velocity,
    // rust: [0.25, -0.0784, 0.0]
    // rust: );
}

a_saved_exhaustion_and_food_timer_come_back :: proc() {
}
        // FoodData.addAdditionalSaveData writes foodExhaustionLevel (a float)
        // and foodTickTimer (an int) with the food level and saturation.
    // rust: let mut g = guest();
    // rust: g.loaded_body = Some(SavedBody {
    // rust: fire_ticks: -20,
    // rust: air: 300,
    // rust: fall_distance: 0.0,
    // rust: velocity: [0.0; 3],
    // rust: food_exhaustion: 2.75,
    // rust: food_tick_timer: 37,
    // rust: ticks_frozen: 0,
    // rust: });
    // rust: let (tag, back) = round_trip(&g);
    // rust: assert_eq!(
    // rust: tag.get("foodExhaustionLevel"),
    // rust: Some(&Tag::Float(2.75f32.to_bits()))
    // rust: );
    // rust: assert_eq!(tag.get("foodTickTimer"), Some(&Tag::Int(37)));
    // rust: let body = back.loaded_body.expect("a body");
    // rust: assert_eq!((body.food_exhaustion, body.food_tick_timer), (2.75, 37));
}

the_previous_game_mode_is_kept_and_saved :: proc() {
}
        // ServerPlayerGameMode.changeGameModeForPlayer: the mode left becomes
        // the previous one, and the mode in use changes nothing.
        // ServerPlayer.addAdditionalSaveData writes previousPlayerGameType (an
        // int) only when there is one.
    // rust: let mut g = guest();
    // rust: assert_eq!(g.previous_game_mode, None);
    // rust: let (tag, _) = round_trip(&g);
    // rust: assert_eq!(tag.get("previousPlayerGameType"), None);
    // rust: g.change_game_mode(1);
    // rust: assert_eq!((g.game_mode, g.previous_game_mode), (1, Some(0)));
    // rust: g.change_game_mode(1);
    // rust: assert_eq!((g.game_mode, g.previous_game_mode), (1, Some(0)));
    // rust: g.change_game_mode(3);
    // rust: assert_eq!((g.game_mode, g.previous_game_mode), (3, Some(1)));
    // rust: let (tag, back) = round_trip(&g);
    // rust: assert_eq!(tag.get("previousPlayerGameType"), Some(&Tag::Int(1)));
    // rust: assert_eq!((back.game_mode, back.previous_game_mode), (3, Some(1)));
}

a_saved_freeze_comes_back_and_a_thaw_clears_it :: proc() {
}
        // Entity.saveWithoutId writes TicksFrozen (an int) only when it is
        // above 0; Entity.load reads it with 0 for a missing key.
    // rust: let frozen = |ticks| SavedBody {
    // rust: fire_ticks: -20,
    // rust: air: 300,
    // rust: fall_distance: 0.0,
    // rust: velocity: [0.0; 3],
    // rust: food_exhaustion: 0.0,
    // rust: food_tick_timer: 0,
    // rust: ticks_frozen: ticks,
}
    // rust: let mut g = guest();
    // rust: g.loaded_body = Some(frozen(120));
    // rust: let (tag, back) = round_trip(&g);
    // rust: assert_eq!(tag.get("TicksFrozen"), Some(&Tag::Int(120)));
    // rust: assert_eq!(back.loaded_body.expect("a body").ticks_frozen, 120);
        // Thawed since: the file the guest came from still says 120, and the
        // key goes.
    // rust: let mut g = back;
    // rust: g.loaded_body = Some(frozen(0));
    // rust: let (tag, back) = round_trip(&g);
    // rust: assert_eq!(tag.get("TicksFrozen"), None);
    // rust: assert_eq!(back.loaded_body.expect("a body").ticks_frozen, 0);
}

post_effects_are_saved_with_the_player :: proc() {
}
        // ServerPlayer.addAdditionalSaveData's `post_effects`, in order; none
        // is an empty list, and a cleared list does not come back from an
        // older file's copy.
    // rust: let mut g = guest();
    // rust: g.post_effects = vec!["minecraft:invert".into(), "pack:glow".into()];
    // rust: let mut level = Level::default();
    // rust: store(&g, &mut level, None);
    // rust: let tag = level.player_tag();
    // rust: let mut read = Level::default();
    // rust: read.read_player(&tag);
    // rust: read.player_extra = Some(tag);
    // rust: let mut back = guest();
    // rust: apply(&mut back, &read);
    // rust: assert_eq!(back.post_effects, g.post_effects);
        // The cleared list is written over the loaded file.
    // rust: g.post_effects.clear();
    // rust: store(&g, &mut read, None);
    // rust: let tag = read.player_tag();
    // rust: assert!(matches!(
    // rust: tag.get("post_effects"),
    // rust: Some(horizon_world::nbt::Tag::List(l)) if l.is_empty()
    // rust: ));
}

    // The resources the prepared game data holds, for a body to breathe with.
resources :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return None;
}
    // rust: let assets = crate::assets::Assets::load(&root).ok()?;
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).ok()?;
    // rust: Some((assets, resources))
}

    // A body at scale 0.1 with a permanent +0.4 on its step height, such as
    // a command or a datapack gives.
small_body :: proc(resources: ^crate::motion::MotionResources) -> c {
    // Ported from Horizon
    return {}
}
//         use horizon_world::attributes::{Modifier, Operation};
    // rust: let mut m = crate::motion::PlayerMotion::new(resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .expect("a body");
    // rust: let key = m.attributes.key("minecraft:scale").unwrap();
    // rust: let handle = m.attributes.get_instance(Some(key)).unwrap().unwrap();
    // rust: m.attributes
    // rust: .edit(&handle, |a, o| a.set_base_value(0.1, o))
    // rust: .unwrap();
    // rust: let key = m.attributes.key("minecraft:step_height").unwrap();
    // rust: let handle = m.attributes.get_instance(Some(key)).unwrap().unwrap();
    // rust: let step = Modifier::new("test:step", 0.4, Operation::AddValue).unwrap();
    // rust: m.attributes
    // rust: .edit(&handle, |a, o| a.add_permanent(step, o))
    // rust: .unwrap();
    // rust: m
}

a_new_body_takes_the_scale_of_the_old_one :: proc() {
}
        // #3684: ServerPlayer.restoreFrom copies the base values to the body
        // that follows a death (assignBaseValues) and, for the same player in
        // another level, the permanent modifiers too (assignPermanentModifiers).
        // The body Horizon made on a respawn or a level change started from
        // the defaults: a player at /attribute scale 0.1 was 1.0 again.
    // rust: let Some((_assets, resources)) = resources() else {
    // rust: eprintln!("skipped: prepared resources unavailable");
    // rust: return;
}
    // rust: let next = |g: &Guest| {
    // rust: let mut m =
    // rust: crate::motion::PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .expect("a body");
    // rust: m.apply_saved_attributes(g.carried_attributes.as_ref())
    // rust: .unwrap();
    // rust: m
}
    // rust: for (restore_all, step) in [(false, 0.6), (true, 1.0)] {
    // rust: let mut g = guest();
    // rust: g.motion = Some(Box::new(small_body(&resources)));
    // rust: g.new_body(restore_all);
    // rust: assert!(g.motion.is_none());
    // rust: let mut m = next(&g);
    // rust: assert_eq!(m.attribute("minecraft:scale").unwrap(), 0.1);
    // rust: assert!((m.attribute("minecraft:step_height").unwrap() - step).abs() < 1e-9);
            // The tick that follows rebuilds the box at that scale.
    // rust: m.refresh_attributes().unwrap();
    // rust: assert_eq!(m.dimensions.width, 0.6 * 0.1);
    // rust: assert_eq!(m.dimensions.height, 1.8 * 0.1);
}
        // No body before: nothing to hand over.
    // rust: let mut g = guest();
    // rust: g.new_body(true);
    // rust: assert!(g.carried_attributes.is_none());
}

a_player_between_two_bodies_saves_the_attributes_the_next_one_takes :: proc() {
}
        // #3684: logging out after a respawn, before the new body has ticked,
        // must not write the file's older list over the scale.
    // rust: let Some((_assets, resources)) = resources() else {
    // rust: eprintln!("skipped: prepared resources unavailable");
    // rust: return;
}
    // rust: let mut g = guest();
    // rust: g.motion = Some(Box::new(small_body(&resources)));
    // rust: g.new_body(false);
    // rust: let mut level = Level::default();
    // rust: store(&g, &mut level, None);
    // rust: let tag = level.player_tag();
    // rust: let mut read = Level::default();
    // rust: read.read_player(&tag);
    // rust: read.player_extra = Some(tag);
    // rust: let mut back =
    // rust: crate::motion::PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .expect("a body");
    // rust: back.apply_saved_attributes(read.player_extra.as_ref().and_then(|t| t.get("attributes")))
    // rust: .unwrap();
    // rust: assert_eq!(back.attribute("minecraft:scale").unwrap(), 0.1);
}

a_saved_air_comes_back :: proc() {
}
        // A player saved underwater (#1321): the file keeps the remaining air
        // (Entity.saveWithoutId's Air), and the body that comes back breathes
        // on it instead of starting with a full supply.
    // rust: let Some((_assets, resources)) = resources() else {
    // rust: eprintln!("skipped the air round trip: prepared resources unavailable");
    // rust: return;
}
    // rust: let mut g = guest();
    // rust: let mut motion =
    // rust: crate::motion::PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .expect("a body");
    // rust: motion.air = 99;
    // rust: g.motion = Some(Box::new(motion));
    // rust: let mut level = Level::default();
    // rust: store(&g, &mut level, None);
    // rust: let tag = level.player_tag();
    // rust: let mut read = Level::default();
    // rust: read.read_player(&tag);
    // rust: read.player_extra = Some(tag);
    // rust: let mut back = guest();
    // rust: apply(&mut back, &read);
    // rust: assert_eq!(back.loaded_body.expect("a body").air, 99);
}

a_saved_root_vehicle_comes_back :: proc() {
}
        // A player saved riding a horse (#1474): the file holds the vehicle
        // (ServerPlayer.saveParentVehicle's RootVehicle {Attach, Entity}),
        // and the next login spawns it and rides it again.
    // rust: let vehicle = [1, 2, 3, 4];
    // rust: let horse = Tag::compound([
    // rust: ("id", Tag::String("minecraft:horse".into())),
    // rust: ("UUID", Tag::IntArray(vehicle.to_vec())),
    // rust: ]);
    // rust: let root = Tag::compound([
    // rust: ("Attach", Tag::IntArray(vehicle.to_vec())),
    // rust: ("Entity", horse),
    // rust: ]);
    // rust: let g = guest();
    // rust: let mut level = Level::default();
    // rust: store(&g, &mut level, Some(root.clone()));
    // rust: let tag = level.player_tag();
    // rust: assert_eq!(tag.get("RootVehicle"), Some(&root));
    // rust: let mut read = Level::default();
    // rust: read.read_player(&tag);
    // rust: read.player_extra = Some(tag);
    // rust: let mut back = guest();
    // rust: apply(&mut back, &read);
    // rust: assert_eq!(back.saved_vehicle, Some(vehicle));
        // Saved again before the horse is back, the file keeps it whole.
    // rust: let mut again = Level::default();
    // rust: store(&back, &mut again, None);
    // rust: assert_eq!(again.player_tag().get("RootVehicle"), Some(&root));
}

abilities :: proc(g: ^Guest) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match g.abilities() {
    // rust: horizon_protocol::packets::play::Clientbound::PlayerAbilities(p) => {
    // rust: (p.flags, p.flying_speed)
}
    // rust: other => panic!("not the abilities: {other:?}"),
}
}

    // A flying speed a mod set goes out in every abilities packet (a game
    // mode change's, a respawn's), is saved as vanilla's `abilities.flySpeed`
    // and comes back when the player does; a file without one is vanilla's 0.05.
a_set_flying_speed_is_sent_kept_and_saved :: proc() {
}
    // rust: let dir = world("fly-speed");
    // rust: let mut g = guest();
    // rust: assert_eq!(abilities(&g).1, 0.05);
    // rust: g.flying_speed = 2.5;
    // rust: g.game_mode = 1;
    // rust: assert_eq!(abilities(&g), (1 | 4 | 8, 2.5));
    // rust: g.game_mode = 0;
    // rust: assert_eq!(abilities(&g), (0, 2.5));
    // rust: save(&g, &dir);
    // rust: let tag = read_dat(&path(&dir, g.uuid)).unwrap();
    // rust: let saved = tag.get("abilities").and_then(|a| a.get("flySpeed"));
    // rust: assert_eq!(saved, Some(&Tag::Float(2.5f32.to_bits())));
    // rust: let mut back = guest();
    // rust: assert!(load(&mut back, &dir));
    // rust: assert_eq!(back.flying_speed, 2.5);
        // A vanilla file's own speed is read, and one without is 0.05.
    // rust: let mut level = Level::default();
    // rust: level.read_player(&Tag::compound([(
    // rust: "abilities",
    // rust: Tag::compound([("flySpeed", Tag::Float(0.1f32.to_bits()))]),
    // rust: )]));
    // rust: let mut other = guest();
    // rust: apply(&mut other, &level);
    // rust: assert_eq!(other.flying_speed, 0.1);
    // rust: level.read_player(&Tag::compound([(
    // rust: "abilities",
    // rust: Tag::Compound(Default::default()),
    // rust: )]));
    // rust: apply(&mut other, &level);
    // rust: assert_eq!(other.flying_speed, 0.05);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

a_world_without_singleplayer_uuid_gives_the_owner_a_new_player_not_anothers :: proc() {
}
        // A world from a vanilla server: no `singleplayer_uuid`, and the players' files are other
        // people's. The owner has none: vanilla starts them new (PlayerList.loadPlayerData).
    // rust: let owner = horizon_protocol::crypto::offline_uuid("Owner");
    // rust: let friend = horizon_protocol::crypto::offline_uuid("Friend");
    // rust: let dir = world("server-world");
    // rust: save(&holding(friend, "minecraft:netherite_ingot", 9), &dir);
    // rust: let mut level = Level::default();
    // rust: level.write(&dir).unwrap();
    // rust: let _ = std::fs::remove_file(dir.join("level.dat_old"));
    // rust: let mut tag = read_dat(&dir.join("level.dat")).unwrap();
    // rust: if let Some(Tag::Compound(data)) = tag.get_mut("Data") {
    // rust: data.remove(&"singleplayer_uuid".into());
}
    // rust: write_dat(&dir.join("level.dat"), tag).unwrap();
    // rust: let read = Level::read(&dir).unwrap();
    // rust: let mut g = holding(owner, "minecraft:dirt", 1);
    // rust: g.inventory[0] = None;
    // rust: let known = load_owner(&mut g, &dir, Some(&read));
    // rust: assert!(!known, "the owner has not been here before");
    // rust: assert_eq!(first_item(&g), None, "no inventory of the friend's");
        // The owner's save names the owner, and leaves the friend's file alone.
    // rust: let before = std::fs::read(path(&dir, friend)).unwrap();
    // rust: let mut level = read;
    // rust: save_owner(&g, &mut level, &dir);
    // rust: assert_eq!(level.player_uuid, Some(uuid_ints(owner)));
    // rust: assert_eq!(std::fs::read(path(&dir, friend)).unwrap(), before);
    // rust: assert!(exists(&dir, owner));
}
}
