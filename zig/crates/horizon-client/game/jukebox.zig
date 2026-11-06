//! Transpiled from Horizon Rust crate
//! Module: horizon-client_jukebox
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Jukeboxes (`JukeboxBlock`, `JukeboxBlockEntity`, `JukeboxSongPlayer`):
//! inserting a `jukebox_playable` disc, ejecting it, the song with its
//! "Now Playing" overlay, note particles every second, the redstone
//! signal while playing, the comparator output, and saving.
// use super::Game;
// use horizon_client::{
    // rust: block_entity_item,
    // rust: containers::{BlockEntity, Jukebox},
    // rust: first_person::Hand,
    // rust: items::ItemStack,
    // rust: mobs::Species,
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: text::Text,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::level::flags as level_flags;

    // rust: impl Game<'_> {
pub fn jukebox(self: *Self, pos: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.world.block_entities.get(&(pos[0], pos[1], pos[2])) {
    // rust: Some(BlockEntity::Jukebox(j)) => Some(j),
    // rust: _ => None,
}
}
pub fn set_has_record(self: *Self, pos: [i32; 3], has: bool) void {
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let registry = self.pack.assets.registry;
    // rust: let Some(mut s) = registry.state(state).cloned() else {
    // rust: return;
}
    // rust: s.properties.insert(
    // rust: "has_record".into(),
    // rust: if has { "true" } else { "false" }.into(),
    // rust: );
    // rust: if let Some(new) = registry.id(&s) {
    // rust: let p = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(level, ticks, p, new, level_flags::UPDATE_CLIENTS)
    // rust: });
}
}
    /// `JukeboxBlock.setPlacedBy`: a jukebox placed from an item whose
    /// `block_entity_data` carries a `RecordItem` keeps that record, so
    /// `has_record` turns on: the model draws the disc and `useWithoutItem`
    /// pops it out. Vanilla reads the item's data, after
    /// `updateCustomBlockEntityTag` has filled the block entity.
    // rust: pub(super) fn jukebox_placed(&mut self, pos: [i32; 3], stack: &ItemStack) {
    // rust: if block_entity_item::carries_record(stack) {
    // rust: self.set_has_record(pos, true);
}
}
    /// `onSongChanged`: neighbours (the signal) and comparators.
pub fn jukebox_changed(self: *Self, pos: [i32; 3]) void {
}
    // rust: let p = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| {
    // rust: let block = b.block(state);
    // rust: b.update_neighbors_at(level, ticks, p, block);
    // rust: });
    // rust: self.container_changed((pos[0], pos[1], pos[2]));
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
}
    /// `JukeboxBlockEntity.setTheItem` from a container (a hopper or a dropper
    /// feeding the slot): a disc that lands in a jukebox that is not playing
    /// starts its song, as the player's own use does, with the block state,
    /// the song's level event and the neighbour and comparator updates.
    // rust: pub(super) fn jukebox_inserted(&mut self, pos: [i32; 3]) {
    // rust: let Some(song) = self
    // rust: .jukebox(pos)
    // rust: .filter(|j| !j.playing)
    // rust: .and_then(|j| j.record())
    // rust: .and_then(|record| self.res.items().get(&record.item))
    // rust: .and_then(|info| info.jukebox_song.clone())
    // rust: else {
    // rust: return;
}
    // rust: if let Some(BlockEntity::Jukebox(j)) =
    // rust: self.world.block_entities.get_mut(&(pos[0], pos[1], pos[2]))
    // rust: {
    // rust: j.playing = true;
    // rust: j.ticks = 0;
}
    // rust: self.set_has_record(pos, true);
    // rust: self.start_song(pos, &song);
    // rust: self.jukebox_changed(pos);
}
    /// `JukeboxBlockEntity.setTheItem(EMPTY)` from a container (a hopper
    /// below taking the disc): the song stops, the block loses its record,
    /// and the neighbours and comparators hear it.
    // rust: pub(super) fn jukebox_taken(&mut self, pos: [i32; 3]) {
    // rust: if let Some(BlockEntity::Jukebox(j)) =
    // rust: self.world.block_entities.get_mut(&(pos[0], pos[1], pos[2]))
    // rust: {
    // rust: if j.record().is_some() {
    // rust: return;
}
    // rust: j.playing = false;
    // rust: j.ticks = 0;
}
    // rust: self.stop_song(pos);
    // rust: self.set_has_record(pos, false);
    // rust: self.jukebox_changed(pos);
}
    // rust: pub(super) fn jukebox_set_item(&mut self, pos: [i32; 3], stack: Option<ItemStack>) {
    // rust: let song = stack
    // rust: .as_ref()
    // rust: .and_then(|s| self.res.items().get(&s.item))
    // rust: .and_then(|info| info.jukebox_song.clone());
    // rust: let has_record = stack.is_some();
    // rust: let Some(BlockEntity::Jukebox(j)) =
    // rust: self.world.block_entities.get_mut(&(pos[0], pos[1], pos[2]))
    // rust: else {
    // rust: return;
}
    // rust: let was_playing = j.playing;
    // rust: j.items[0] = stack;
    // rust: j.playing = song.is_some();
    // rust: j.ticks = 0;
    // rust: self.set_has_record(pos, has_record);
    // rust: match song {
    // rust: Some(song) => self.start_song(pos, &song),
    // rust: None if was_playing => self.stop_song(pos),
    // rust: None => {}
}
    // rust: self.jukebox_changed(pos);
}
    /// `JukeboxBlock.useItemOn` / `useWithoutItem` on the jukebox at `pos`.
    // rust: pub(super) fn use_jukebox(&mut self, pos: [i32; 3], held: Option<&ItemStack>) -> bool {
    // rust: if &*self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .name
    // rust: != "minecraft:jukebox"
    // rust: {
    // rust: return false;
}
    // rust: if self.jukebox(pos).is_some_and(|j| j.record().is_some()) {
            // TRY_WITH_EMPTY_HAND: only the main hand goes on to useWithoutItem.
    // rust: if self.hand != Hand::Main {
    // rust: return false;
}
    // rust: self.eject_record(pos);
            // ServerPlayerGameMode.useItemOn: useWithoutItem consumed the click.
    // rust: self.trigger_default_block_use(pos);
    // rust: return true;
}
    // rust: let Some(stack) = held else { return false };
    // rust: let Some(song) = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.jukebox_song.clone())
    // rust: else {
    // rust: return false;
}
        // JukeboxPlayable.tryInsertIntoJukebox
    // rust: let record = ItemStack {
    // rust: count: 1,
    // rust: ..stack.clone()
}
    // rust: if !self.creative {
    // rust: self.consume_held();
}
    // rust: self.award_custom_stat("play_record", 1);
    // rust: self.world.block_entities.insert(
    // rust: (pos[0], pos[1], pos[2]),
    // rust: BlockEntity::Jukebox(Jukebox {
    // rust: items: [Some(record)],
    // rust: ticks: 0,
    // rust: playing: true,
    // rust: }),
    // rust: );
    // rust: self.set_has_record(pos, true);
    // rust: self.start_song(pos, &song);
    // rust: self.jukebox_changed(pos);
        // ServerPlayerGameMode.useItemOn: the action was consumed.
    // rust: self.trigger_block("minecraft:item_used_on_block", pos, stack);
    // rust: true
}
    /// `JukeboxBlock.useItemOn` on this client's level for the main hand:
    /// whether the jukebox at `pos` takes the click (`has_record` pops the
    /// disc out, or a `jukebox_playable` item goes in). The server does the
    /// rest, see `use_jukebox`.
    // rust: pub(super) fn jukebox_takes(&self, pos: [i32; 3], held: Option<&ItemStack>) -> bool {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if &*self.res.facts().get(state).name != "minecraft:jukebox" {
    // rust: return false;
}
    // rust: let has_record = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("has_record"))
    // rust: .is_some_and(|v| v == "true");
    // rust: has_record
    // rust: || held.is_some_and(|stack| {
    // rust: self.res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.jukebox_song.is_some())
    // rust: })
}
    /// Level event 1010: the song from the jukebox, and the "Now Playing" overlay.
pub fn start_song(self: *Self, pos: [i32; 3], song: []const u8) void {
}
    // rust: self.stop_sound(pos);
    // rust: let Some(s) = self.items().songs.get(song).cloned() else {
    // rust: return;
}
        // LevelRenderer.playJukeboxSong: SimpleSoundInstance.forJukeboxSong.
    // rust: let id = self.audio.play_jukebox_song(&s.sound, pos);
    // rust: self.jukebox_sounds.insert((pos[0], pos[1], pos[2]), id);
    // rust: let description =
    // rust: horizon_client::component::to_text(&s.description, &mut |k| Text::literal(k));
        // Hud.setNowPlaying: the overlay, said at once.
    // rust: let message = Text::translate("record.nowPlaying", &[description]);
    // rust: self.say_system_now(&message);
    // rust: self.titles.set_overlay(message, true);
    // rust: self.update_song_volumes();
    // rust: self.notify_record_playing(pos, true);
    // rust: if self.audio.capture.is_some() {
    // rust: self.lan_songs.push((pos, Some(song.to_owned())));
}
}
    /// `LevelEventHandler` 1010 on a client of a server: `playJukeboxSong`
    /// for the song the event's data names in the server's `jukebox_song`
    /// registry (`Registry.get(int).ifPresent`: an unknown id does nothing).
    /// The server's jukebox plays it; this client only hears it.
    // rust: pub(super) fn jukebox_song_event(&mut self, pos: [i32; 3], data: i32) {
    // rust: if let Some(song) = jukebox_song_name(self.remote.as_ref().map(|r| &*r.registries), data) {
    // rust: self.start_song(pos, &song);
}
}
    /// `LevelEventHandler` 1011: `stopJukeboxSongAndNotifyNearby`.
    // rust: pub(super) fn jukebox_stop_event(&mut self, pos: [i32; 3]) {
    // rust: self.stop_sound(pos);
    // rust: self.notify_record_playing(pos, false);
}
pub fn stop_sound(self: *Self, pos: [i32; 3]) void {
}
    // rust: if let Some(id) = self.jukebox_sounds.remove(&(pos[0], pos[1], pos[2])) {
    // rust: self.audio.stop_and_release(id);
}
}
    /// Level event 1011: the song ends, here and for the guests.
pub fn stop_song(self: *Self, pos: [i32; 3]) void {
}
    // rust: self.stop_sound(pos);
    // rust: self.notify_record_playing(pos, false);
    // rust: if self.audio.capture.is_some() {
    // rust: self.lan_songs.push((pos, None));
}
}
    /// `LevelEventHandler.notifyNearbyEntities` (level events 1010 and 1011):
    /// parrots within three blocks of the jukebox start or stop dancing.
    // rust: pub(super) fn notify_record_playing(&mut self, pos: [i32; 3], playing: bool) {
    // rust: let min = Vec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]));
    // rust: let area = Aabb::new(min, min.add_vector(Vec3::new(1.0, 1.0, 1.0)))
    // rust: .inflate(Vec3::new(3.0, 3.0, 3.0));
    // rust: for m in self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .filter(|m| m.species() == Species::Parrot && m.bounds().intersects(area))
    // rust: {
    // rust: m.extra.party_jukebox = playing.then_some(pos);
}
}
    /// `popOutTheItem`: the disc above the jukebox, and the song stops.
pub fn eject_record(self: *Self, pos: [i32; 3]) void {
}
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let record = match self.world.block_entities.get_mut(&key) {
    // rust: Some(BlockEntity::Jukebox(j)) => {
    // rust: j.playing = false;
    // rust: j.ticks = 0;
    // rust: j.items[0].take()
}
    // rust: _ => None,
}
    // rust: self.stop_song(pos);
    // rust: if let Some(record) = record {
            // atLowerCornerWithOffset(pos, 0.5, 1.01, 0.5).offsetRandomXZ(random, 0.7);
            // `new ItemEntity` moves it with its own random.
    // rust: let at = horizon_world::level::removal::jukebox_pop_position(
    // rust: &mut self.world.random,
    // rust: horizon_core::position::BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: );
    // rust: self.spawn_item(record, at, super::dispenser::new_item_motion(), 10);
}
    // rust: self.set_has_record(pos, false);
    // rust: self.jukebox_changed(pos);
}
    /// A broken jukebox stops its song (its disc drops with the contents).
    // rust: pub(super) fn jukebox_removed(&mut self, pos: [i32; 3]) {
    // rust: self.stop_song(pos);
}
    /// `JukeboxSongPlayer.tick` of the jukebox at `key`, while it plays.
    // rust: pub(super) fn tick_jukebox(&mut self, key: (i32, i32, i32)) {
    // rust: let playing = match self.world.block_entities.get(&key) {
    // rust: Some(BlockEntity::Jukebox(j)) if j.playing => j.record().and_then(|r| {
    // rust: let song = self.items().get(&r.item)?.jukebox_song.clone()?;
    // rust: Some((song, j.ticks))
    // rust: }),
    // rust: _ => None,
}
    // rust: let Some((song, ticks)) = playing else {
    // rust: return;
}
    // rust: let pos = [key.0, key.1, key.2];
    // rust: let Some(s) = self.items().songs.get(&song).cloned() else {
    // rust: return;
}
    // rust: if s.finished(ticks) {
    // rust: if let Some(BlockEntity::Jukebox(j)) = self.world.block_entities.get_mut(&key) {
    // rust: j.playing = false;
    // rust: j.ticks = 0;
}
    // rust: self.stop_song(pos);
    // rust: self.jukebox_changed(pos);
    // rust: return;
}
    // rust: if !self.jukebox_sounds.contains_key(&key) && ticks == 0 {
    // rust: self.start_song(pos, &song);
}
    // rust: if ticks % 20 == 0 {
    // rust: let color = f64::from(self.world.random.next_int_bound(4).unwrap_or(0)) / 24.0;
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 1.2,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::Note),
    // rust: at,
    // rust: [color, 0.0, 0.0],
    // rust: );
}
    // rust: if let Some(BlockEntity::Jukebox(j)) = self.world.block_entities.get_mut(&key) {
    // rust: j.ticks += 1;
}
}
    /// Let go of songs that ended or whose jukebox stopped.
    // rust: pub(super) fn update_song_volumes(&mut self) {
    // rust: let sounds: Vec<_> = self
    // rust: .jukebox_sounds
    // rust: .iter()
    // rust: .map(|(k, id)| (*k, *id))
    // rust: .collect();
    // rust: for (k, id) in sounds {
            // A server's client has no playing jukebox of its own: its songs
            // stop with level event 1011, or when they end.
    // rust: let playing = matches!(self.world.block_entities.get(&k), Some(BlockEntity::Jukebox(j)) if j.playing);
    // rust: if !keeps_song(
    // rust: self.audio.engine.is_active(id),
    // rust: self.remote.is_some(),
    // rust: playing,
    // rust: ) {
    // rust: self.audio.stop_and_release(id);
    // rust: self.jukebox_sounds.remove(&k);
}
}
}
}
/// The song a level event 1010's data names: its id in the `jukebox_song`
/// registry the server sent (`Registry.get(int)`). Only a server's client
/// has one; a level that plays its own jukeboxes starts their songs itself.
    // rust: fn jukebox_song_name(
    // rust: registries: Option<&horizon_protocol::registry::Dynamic>,
    // rust: id: i32,
    // rust: ) -> Option<String> {
    // rust: registries?
    // rust: .name("minecraft:jukebox_song", id)
    // rust: .map(str::to_owned)
}
/// Whether a jukebox song keeps playing: until it ends, and, in a level that
/// plays its own jukeboxes, while that jukebox plays. A server's client
/// stops it at level event 1011 (`LevelRenderer.playingJukeboxSongs`).
pub fn keeps_song(active: bool, server_client: bool, jukebox_playing: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: active && (server_client || jukebox_playing)
}
/// The jukebox's redstone signal (15 while a song plays) and comparator output.
    // rust: pub(super) fn jukebox_signals(
    // rust: world: &horizon_client::world::World,
    // rust: items: &horizon_client::items::Items,
    // rust: pos: BlockPos,
    // rust: ) -> Option<(i32, i32)> {
    // rust: match world.block_entities.get(&(pos.x, pos.y, pos.z)) {
    // rust: Some(BlockEntity::Jukebox(j)) => {
    // rust: let comparator = j
    // rust: .record()
    // rust: .and_then(|r| items.get(&r.item)?.jukebox_song.as_ref())
    // rust: .and_then(|s| items.songs.get(s))
    // rust: .map_or(0, |s| s.comparator);
    // rust: Some((if j.playing { 15 } else { 0 }, comparator))
}
    // rust: _ => None,
}
}

    // rust: mod tests {
//     use super::{jukebox_song_name, keeps_song};
//     use horizon_protocol::registry::Dynamic;

    /// On a server's client the song comes from level event 1010, whose data
    /// is the song's id in the server's `jukebox_song` registry (#3173), and
    /// it plays on although this client's jukebox isn't playing.
pub fn a_server_clients_jukebox_song_comes_from_level_event_1010() void {
}
    // rust: let mut registries = Dynamic::default();
    // rust: registries.registries.insert(
    // rust: "minecraft:jukebox_song".into(),
    // rust: ["minecraft:11", "minecraft:13", "minecraft:cat"]
    // rust: .map(|n| (n.to_owned(), None))
    // rust: .to_vec(),
    // rust: );
    // rust: assert_eq!(
    // rust: jukebox_song_name(Some(&registries), 2).as_deref(),
    // rust: Some("minecraft:cat")
    // rust: );
    // rust: assert_eq!(jukebox_song_name(Some(&registries), 3), None);
    // rust: assert_eq!(jukebox_song_name(Some(&registries), -1), None);
    // rust: assert_eq!(jukebox_song_name(None, 2), None);
        // A server's client: on until the song ends (or level event 1011).
    // rust: assert!(keeps_song(true, true, false));
    // rust: assert!(!keeps_song(false, true, false));
        // A level that plays its own jukebox: also until the jukebox stops.
    // rust: assert!(keeps_song(true, false, true));
    // rust: assert!(!keeps_song(true, false, false));
}
}
