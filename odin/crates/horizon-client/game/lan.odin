//! Transpiled from Horizon Rust crate
package horizon_client_lan

import "core:fmt"
import "core:mem"
import "core:math"

// Hosting the open world on the local network ("Open to LAN"): starts the
// server threads and the play-state hub, feeds it the world's entities each
// tick and turns what the guests do into gameplay. A world that is not open
// costs one `Option` check per tick.
// use super::{Game, shield::OFFHAND_SLOT};
// use horizon_client::{
    // rust: Result,
    // rust: lan::{
    // rust: self, Lan, NetConfig,
    // rust: chunks::ChunkEncoder,
    // rust: data::{BIOME_REGISTRY, FrozenDamage, SyncData},
    // rust: entity::{EntityState, States},
    // rust: hub::{HostEvent, Hub, HubConfig, TickCtx},
    // rust: playerdata,
    // rust: },
    // rust: mobs::{Mob, Species, Who, leash::Holder},
    // rust: text::Text,
    // rust: world::World,
}
// use horizon_protocol::{
    // rust: entity_data::{Value, serializer},
    // rust: packets::play::{self, Clientbound as C},
}
// use horizon_world::block_collision::BlockCollisionRegistry;
// use std::{
    // rust: collections::HashMap,
    // rust: sync::{Arc, Mutex},
    // rust: time::Instant,
}

// What `sync_data` loaded: whether it was with data packs over the game's
// data, and the registries and tags.
    // rust: type Synced = (bool, std::result::Result<Arc<SyncData>, String>);

// Only damage is bound eagerly for gameplay. Full wire data remains lazy
// except when the entering world actually defines damage types.
SyncCache :: struct {
    data: Maybe(Synced),
    damage: Maybe(FrozenDamage),
    world_packs: bool,
}

    // rust: static SYNC: Mutex<SyncCache> = Mutex::new(SyncCache {
    // rust: data: None,
    // rust: damage: None,
    // rust: world_packs: false,
    // rust: });

// Load wire data once, retaining this session's frozen damage definitions.
    // rust: pub(super) fn sync_data(
    // rust: root: &std::path::Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: ) -> std::result::Result<Arc<SyncData>, String> {
    // rust: let mut sync = SYNC.lock().unwrap_or_else(|e| e.into_inner());
    // rust: cached_sync_data(&mut sync, root, overlay)
}

    // rust: fn cached_sync_data(
    // rust: sync: &mut SyncCache,
    // rust: root: &std::path::Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: ) -> std::result::Result<Arc<SyncData>, String> {
    // rust: let packs = !overlay.files.is_empty();
    // rust: let load = || {
    // rust: match &sync.damage {
    // rust: Some(damage) => SyncData::load_with_frozen_damage(root, overlay, damage),
    // rust: None => SyncData::load(root, overlay),
}
    // rust: .map(Arc::new)
}
    // A helper started before world entry must not fill a pack world's
    // still-lazy cache with its vanilla overlay.
    // rust: if sync.data.is_none() && sync.world_packs && !packs {
    // rust: return load();
}
    // rust: sync.data.get_or_insert_with(|| (packs, load())).1.clone()
}

// Reuse a no-pack preload; unrelated packs only invalidate it, as on main.
// Packs defining damage types seed the wire snapshot under the same lock
// that helpers use, before reloads or guests can observe a partial state.
    // rust: pub(super) fn open_world_sync_data(
    // rust: root: &std::path::Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: damage: &horizon_world::damage_source::Catalog,
    // rust: ) -> std::result::Result<(), String> {
    // rust: let mut sync = SYNC.lock().unwrap_or_else(|e| e.into_inner());
    // rust: initialize_world_sync_data(&mut sync, root, overlay, damage)
}

    // rust: fn initialize_world_sync_data(
    // rust: sync: &mut SyncCache,
    // rust: root: &std::path::Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: damage: &horizon_world::damage_source::Catalog,
    // rust: ) -> std::result::Result<(), String> {
    // rust: sync.world_packs = !overlay.files.is_empty();
    // rust: if sync.world_packs {
    // rust: sync.data = None;
}
    // rust: sync.damage = Some(FrozenDamage::new(damage, overlay));
    // rust: if overlay.kind("damage_type").next().is_some() {
    // rust: cached_sync_data(sync, root, overlay)?;
}
    // rust: Ok(())
}

// Let go of what `sync_data` loaded: a preload no world used
// (game/world_loading.rs), or the previous session when another world opens.
    // rust: pub(super) fn forget_sync_data() {
    // rust: *SYNC.lock().unwrap_or_else(|e| e.into_inner()) = SyncCache::default();
}

// Without a hub yet, retain this world's frozen registries through `/reload`
// too. World entry discards this snapshot before loading another world's.
    // rust: pub(super) fn reload_cached_sync_data(
    // rust: root: &std::path::Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: ) -> std::result::Result<(), String> {
    // rust: let kept = prepare_sync_reload(&mut SYNC.lock().unwrap_or_else(|e| e.into_inner()), overlay);
    // rust: if let Some(kept) = kept {
    // rust: reload_sync_data(root, overlay, &kept)?;
}
    // rust: Ok(())
}

// Keep lazy-cache admission aligned with the current packs even when no
// complete wire snapshot has been loaded yet. Damage definitions stay frozen.
    // rust: fn prepare_sync_reload(
    // rust: sync: &mut SyncCache,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: ) -> Option<Arc<SyncData>> {
    // rust: sync.world_packs = !overlay.files.is_empty();
    // rust: sync.data
    // rust: .as_ref()
    // rust: .and_then(|(_, result)| result.as_ref().ok())
    // rust: .cloned()
}

// `/reload` (MinecraftServer.reloadResources) under a running hub: the
// tags, recipes and advancements read again with the world's packs, the
// synchronized registries `kept` (the hub's) as they were, and that becomes
// what `sync_data` gives.
    // rust: pub(super) fn reload_sync_data(
    // rust: root: &std::path::Path,
    // rust: overlay: &horizon_world::loot::PackOverlay,
    // rust: kept: &SyncData,
    // rust: ) -> std::result::Result<Arc<SyncData>, String> {
    // Kept pack dialogs count as packs: a world opened without packs after
    // a `/reload` that dropped them must read its own registries again.
    // rust: let packs = !overlay.files.is_empty() || kept.has_pack_entries();
    // rust: let sync = SyncData::reload(root, overlay, kept).map(|mut sync| {
    // rust: sync.features.clone_from(&kept.features);
    // rust: Arc::new(sync)
    // rust: });
    // rust: SYNC.lock().unwrap_or_else(|e| e.into_inner()).data = Some((packs, sync.clone()));
    // rust: sync
}

    // rust: impl Game<'_> {
    // The commands' `minecraft:dialog` ids as the clients get them in the
    // configuration phase (`sync`, the world's packs' dialogs among them):
    // `/dialog show` parses an id against these and sends its index.
    // rust: pub(super) fn sync_dialog_ids(&mut self, sync: &SyncData) {
    // rust: let Some(names) = sync.dynamic.registries.get("minecraft:dialog") else {
    // rust: return;
}
    // rust: let ids = names.iter().map(|(name, _)| name.clone()).collect();
    // rust: self.ui
    // rust: .registries
    // rust: .by_registry
    // rust: .entry("minecraft:dialog".to_owned())
    // rust: .or_default()
    // rust: .ids = ids;
}
}

// The registries and tags a server sends without data packs over them, read
// on a helper thread while a server's world prepares: most worlds have no
// packs, so it is what `sync_data` would load once the world is open.
    // rust: pub(super) struct SyncPreload(std::thread::JoinHandle<std::result::Result<SyncData, String>>);

// Start reading the server's data beside the world's preparation; `None`
// when it is read already, or being read (`preload_world_data`).
    // rust: pub(super) fn preload_sync_data(root: &std::path::Path) -> Option<SyncPreload> {
    // rust: if !SYNC
    // rust: .try_lock()
    // rust: .is_ok_and(|sync| sync.data.is_none() && sync.damage.is_none())
    // rust: {
    // rust: return None;
}
    // rust: let root = root.to_owned();
    // rust: std::thread::Builder::new()
    // rust: .name("Server data preload".into())
    // rust: .spawn(move || SyncData::load(&root, &horizon_world::loot::PackOverlay::NONE))
    // rust: .map(SyncPreload)
    // rust: .ok()
}

    // rust: impl SyncPreload {
    // The world is open: without packs of its own (`overlay`), what was read
    // becomes `sync_data`'s; with them, `sync_data` loads them as before.
    // rust: pub(super) fn adopt(self, overlay: &horizon_world::loot::PackOverlay) {
    // rust: if !overlay.files.is_empty() {
    // rust: return;
}
    // rust: if let Ok(read) = self.0.join() {
    // rust: let mut sync = SYNC.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if !sync.world_packs && sync.data.is_none() {
    // rust: sync.data = Some((false, read.map(Arc::new)));
}
}
}
}

// The settings of the open world (WorldOptionsScreen's multiplayer section).
LanSettings :: struct {
    port: u16,
    guest_commands: bool,
    force_game_mode: bool,
}

    // rust: pub(super) struct LanHost {
    // rust: pub hub: Hub,
    // The mods heard that everyone still here leaves with the server.
    // rust: pub players_told_left: bool,
    // rust: pub settings: LanSettings,
    // rust: pub play: HashMap<u32, super::lan_actions::GuestPlay>,
    // Blocks broken this tick (their sound is a level event for the guests).
    // rust: pub broken: Vec<[f64; 3]>,
    // Hurt time, death and swing time (while swinging) of the mobs guests
    // see; the players' hurt time by entity id.
    // rust: mob_state: HashMap<super::Dim, HashMap<u32, (i32, bool, Option<i32>)>>,
    // Each placed guest's pose as the mods last heard it
    // (`native_entity_pose_change`), by connection.
    // rust: pub poses: HashMap<u32, horizon_client::pose::Pose>,
    // The guest each mob sees as its player, when not the host (game/lan_mobs.rs).
    // Looked up per mob each tick: a fast hasher (never iterated).
    // rust: pub mob_players: horizon_client::fast_hash::FxHashMap<u32, u32>,
    // An integrated server's owner (game/integrated.rs).
    // rust: pub owner: Option<Owner>,
    // The players' locator bars, one waypoint manager per level by
    // dimension id (game/lan_waypoints.rs), and the guests who are dead,
    // whose respawn replaces their waypoint.
    // rust: pub waypoints: std::collections::HashMap<String, lan::waypoints::Waypoints>,
    // rust: pub waypoint_dead: std::collections::HashSet<u128>,
    // The world border as the guests were last told of it (lan/border.rs).
    // rust: pub border_sent: Option<lan::border::Sent>,
    // Guests' commands waiting for the hub to be back in `self.lan`, where
    // a command can reach every player (game/lan_actions.rs).
    // rust: pub commands: Vec<super::lan_actions::GuestCommand>,
    // Mods' quiet commands waiting to run a few a tick (game/lan_quiet.rs).
    // rust: pub quiet: std::collections::VecDeque<super::lan_quiet::QuietBatch>,
    // Far terrain sampled for Horizon clients (game/lan_far.rs); None when
    // `horizon-lod-distance` is 0.
    // rust: pub far: Option<horizon_client::lod_net::Service>,
    // Native mods' commands and the level each needs, once asked
    // (game/native_server.rs).
    // rust: pub native_commands: Option<HashMap<String, u8>>,
    // The players a native mod leaves out of the sleep count when they
    // aren't in bed (`native_sleep_ignored`).
    // rust: pub sleep_ignored: std::collections::HashSet<u128>,
    // The entities the guests track, described again every tick
    // (`lan_entities`) over last tick's states.
    // rust: pub(super) states: lan::entity::States,
    // The entity id counter when this tick's states were taken for guests
    // (`lan_note_joined`), None when no guest tracked them.
    // rust: pub(super) states_next_entity: Option<u32>,
    // Last tick's states of the idle mobs and items (game/lan_idle.rs).
    // rust: pub(super) idle_states: super::lan_idle::IdleStates,
}

    // rust: impl Game<'_> {
    // `PlayerList.remove`: `player.awardStat(Stats.LEAVE_GAME)` before the
    // player is saved, heard by native mods first. Once per guest, however
    // often they are saved.
    // rust: pub(super) fn award_leave_game(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: player: u128,
    // rust: name: &str,
    // rust: ) {
    // rust: let Some(play) = host.play.get_mut(&conn) else {
    // rust: return;
}
    // rust: if std::mem::replace(&mut play.left_game, true) {
    // rust: return;
}
    // rust: let mut cancel = false;
    // rust: self.native_player_stat_award(
    // rust: player,
    // rust: name,
    // rust: "minecraft:custom",
    // rust: "minecraft:leave_game",
    // rust: 1,
    // rust: &mut cancel,
    // rust: );
    // rust: if !cancel && let Some(play) = host.play.get_mut(&conn) {
    // rust: play.stats.custom("leave_game", 1);
}
}

    // `PlayerList.removeAll`: every player who joined leaves with the world.
    // rust: pub(super) fn award_leave_game_to_all(&mut self, host: &mut LanHost) {
    // rust: let players: Vec<(u32, u128, String)> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.placed)
    // rust: .map(|g| (g.conn, g.uuid, g.name.clone()))
    // rust: .collect();
    // rust: for (conn, player, name) in players {
    // rust: self.award_leave_game(host, conn, player, &name);
}
}
}

// The player who owns an integrated server's world: a guest whose state is
// the world's own player (`players/data/<singleplayer_uuid>.dat`), as in
// single player.
    // rust: pub(super) struct Owner {
    // rust: pub uuid: u128,
    // The world's player as loaded, until the owner joins.
    // rust: pub saved: Option<Box<horizon_client::save::Level>>,
}

// A stable UUID for an entity that has none.
    // rust: pub(super) fn entity_uuid(id: u32) -> u128 {
    // rust: 0x4856_5a4e_0000_0000_0000_0000_0000_0000u128 | u128::from(id)
}

// The SynchedEntityData index of the baby flag: AgeableMob.DATA_BABY_ID and
// Zombie.DATA_BABY_ID (Zoglin's too) are the first entry after Mob's (16);
// Piglin's comes after AbstractPiglin's zombification flag (17). Every
// AgeableMob has one, the happy ghast and the nautilus included (#6133).
    // rust: pub(super) fn baby_index(species: Species) -> Option<u8> {
//     use Species as S;
    // rust: match species {
    // rust: S::Piglin => Some(17),
    // rust: s if horizon_client::mobs::finalize::ageable(s)
    // rust: || horizon_client::mobs::doors::is_zombie(s)
    // rust: || s == S::Zoglin =>
    // rust: {
    // rust: Some(16)
}
    // rust: _ => None,
}
}

// The variant and look entries of `mob_meta`'s mobs (registry holders, the
// fish's, the bee's, the copper golem's weathering...), in a match of their
// own: `mob_meta`'s arms hold these mobs' other entries.
    // rust: fn mob_variant_meta(
    // rust: m: &Mob,
    // rust: hub: &Hub,
    // rust: meta: &mut Vec<(u8, i32, Value)>,
    // rust: defaults: &mut Vec<(u8, i32, Value)>,
    // rust: ) {
    // rust: let (kind, e) = (m.kind.id.as_str(), &m.extra);
    // rust: let id = |registry: &str, name: &str| hub.registry_id(registry, &format!("minecraft:{name}"));
    // rust: match kind {
        // Axolotl.DATA_VARIANT (after AgeableMob's two).
    // rust: "minecraft:axolotl" => {
    // rust: if e.variant != 0 {
    // rust: meta.push((18, serializer::INT, Value::Int(i32::from(e.variant))));
}
}
        // Frog.DATA_VARIANT_ID, Pig's, Cow's, Chicken's and ZombieNautilus's
        // (after the entries of their parents): registry holders.
    // rust: "minecraft:frog"
    // rust: | "minecraft:pig"
    // rust: | "minecraft:cow"
    // rust: | "minecraft:chicken"
    // rust: | "minecraft:zombie_nautilus" => {
    // rust: let (index, serializer, registry) = match kind {
    // rust: "minecraft:frog" => (18, serializer::FROG_VARIANT, "minecraft:frog_variant"),
    // rust: "minecraft:pig" => (19, serializer::PIG_VARIANT, "minecraft:pig_variant"),
    // rust: "minecraft:cow" => (18, serializer::COW_VARIANT, "minecraft:cow_variant"),
    // rust: "minecraft:chicken" => {
    // rust: (18, serializer::CHICKEN_VARIANT, "minecraft:chicken_variant")
}
    // rust: _ => (
    // rust: 21,
    // rust: serializer::ZOMBIE_NAUTILUS_VARIANT,
    // rust: "minecraft:zombie_nautilus_variant",
    // rust: ),
}
            // Each registry's default (`define(DATA_VARIANT_ID, ... TEMPERATE)`)
            // stays out of the pairing data, as other default values do.
    // rust: let name = horizon_client::mobs::finalize::variant_name(m.species(), e.variant);
    // rust: let name = name.trim_start_matches("minecraft:");
    // rust: if let Some(v) = id(registry, name)
    // rust: && name != "temperate"
    // rust: {
    // rust: meta.push((index, serializer, Value::Id(v)));
}
    // rust: if let Some(v) = id(registry, "temperate") {
    // rust: defaults.push((index, serializer, Value::Id(v)));
}
}
        // Rabbit.DATA_TYPE_ID (after AgeableMob's two) and
        // Parrot.DATA_VARIANT_ID (after TamableAnimal's two and its flags and
        // owner). The fox's type goes with its flags (#2538).
    // rust: "minecraft:rabbit" | "minecraft:parrot" => {
    // rust: let index = if kind == "minecraft:parrot" { 20 } else { 18 };
    // rust: if e.variant != 0 {
    // rust: meta.push((index, serializer::INT, Value::Int(i32::from(e.variant))));
}
}
        // Bee.DATA_FLAGS_ID (rolling 2, stung 4, nectar 8) and
        // DATA_ANGER_END_TIME: the texture shows the nectar and the anger.
    // rust: "minecraft:bee" => {
    // rust: let bee = horizon_client::mobs::bee::get(m);
    // rust: let flags = bee.map_or(0, |b| b.flags);
    // rust: if flags != 0 {
    // rust: meta.push((18, serializer::BYTE, Value::Byte(flags as i8)));
}
    // rust: defaults.push((18, serializer::BYTE, Value::Byte(0)));
    // rust: let anger_end = bee.map_or(-1, |b| b.anger_end);
    // rust: if anger_end != -1 {
    // rust: meta.push((19, serializer::LONG, Value::Long(anger_end)));
}
    // rust: defaults.push((19, serializer::LONG, Value::Long(-1)));
}
        // AbstractFish.FROM_BUCKET takes 16: Salmon.DATA_TYPE (small 0,
        // medium 1, large 2; medium is the data's default, so always sent),
        // Pufferfish.PUFF_STATE and TropicalFish.DATA_ID_TYPE_VARIANT: the
        // pattern's packed id (size, then index << 8), base colour << 16 and
        // pattern colour << 24.
    // rust: "minecraft:salmon" => {
    // rust: meta.push((17, serializer::INT, Value::Int(i32::from(e.variant.min(2)))));
}
    // rust: "minecraft:pufferfish" => {
    // rust: if e.size > 0 {
    // rust: meta.push((17, serializer::INT, Value::Int(e.size)));
}
    // rust: defaults.push((17, serializer::INT, Value::Int(0)));
}
    // rust: "minecraft:tropical_fish" => {
    // rust: let pattern = e.variant.min(11);
    // rust: let packed = i32::from(pattern >= 6)
    // rust: | i32::from(pattern % 6) << 8
    // rust: | i32::from(e.variant2 & 15) << 16
    // rust: | i32::from(e.variant3 & 15) << 24;
    // rust: if packed != 0 {
    // rust: meta.push((17, serializer::INT, Value::Int(packed)));
}
}
        // Tadpole.AGE_LOCKED (after AbstractFish's FROM_BUCKET).
    // rust: "minecraft:tadpole" => {
    // rust: if e.age_locked {
    // rust: meta.push((17, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((17, serializer::BOOLEAN, Value::Bool(false)));
}
        // CopperGolem.DATA_WEATHER_STATE: unaffected 0 to oxidized 3, and it
        // goes back down when the golem is scraped.
    // rust: "minecraft:copper_golem" => {
    // rust: if e.variant != 0 {
    // rust: meta.push((
    // rust: 16,
    // rust: serializer::WEATHERING_COPPER_STATE,
    // rust: Value::Id(i32::from(e.variant.min(3))),
    // rust: ));
}
    // rust: defaults.push((16, serializer::WEATHERING_COPPER_STATE, Value::Id(0)));
}
        // Ghast.DATA_IS_CHARGING: the shooting texture.
    // rust: "minecraft:ghast" => {
    // rust: if e.flag {
    // rust: meta.push((16, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((16, serializer::BOOLEAN, Value::Bool(false)));
}
        // WitherBoss.DATA_ID_INV (after the three head targets): the
        // invulnerable ticks, the blinking texture and the growing scale.
    // rust: "minecraft:wither" => {
    // rust: if e.counter > 0 {
    // rust: meta.push((19, serializer::INT, Value::Int(e.counter)));
}
    // rust: defaults.push((19, serializer::INT, Value::Int(0)));
}
    // rust: _ => {}
}
}

// A mob's synched data as ServerEntity sends it (only the values that differ
// from the defaults the client constructs), with vanilla's entry indices:
// Entity 0..=7, LivingEntity 8..=14, Mob 15, then the subclasses.
// `defaults` gets the defaults of the entries that can go back to theirs.
    // rust: pub(super) fn mob_meta(
    // rust: m: &Mob,
    // rust: hub: &Hub,
    // rust: player_entity: Option<i32>,
    // rust: game_time: i64,
    // rust: meta: &mut Vec<(u8, i32, Value)>,
    // rust: defaults: &mut Vec<(u8, i32, Value)>,
    // rust: ) {
    // The entries are the class's: a content mod's living type has its
    // template's.
    // rust: let kind = m.kind.class_id();
    // Entity.DATA_SHARED_FLAGS_ID: on fire 0x01, sprinting 0x08 (a dashing
    // cat or ocelot), swimming 0x10 (a drowned under water,
    // `Drowned.setSwimming`), invisible 0x20 (the effect's flag) and glowing
    // 0x40 (LivingEntity.updateGlowingStatus).
    // rust: let shared = i8::from(m.is_on_fire())
    // rust: | i8::from(m.extra.sprinting) << 3
    // rust: | i8::from(m.species() == Species::Drowned && m.extra.flag) << 4
    // rust: | i8::from(m.invisible || horizon_client::mobs::trader::is_invisible(m)) << 5
    // rust: | i8::from(m.is_currently_glowing()) << 6;
    // rust: if shared != 0 {
    // rust: meta.push((0, serializer::BYTE, Value::Byte(shared)));
}
    // Entity.DATA_POSE: the pose the species keeps in its own fields (a
    // pose back at standing goes out by the entity's own default).
    // rust: let pose = horizon_client::mobs::sync::pose_id(m);
    // rust: if pose != 0 {
    // rust: meta.push((6, serializer::POSE, Value::Id(i32::from(pose))));
}
    // LivingEntity.DATA_SLEEPING_POS_ID: the bed a sleeping villager lies in.
    // rust: if let Some(bed) = horizon_client::mobs::villager::sleeping_pos(m) {
    // rust: meta.push((14, serializer::OPTIONAL_BLOCK_POS, Value::OptPos(Some(bed))));
}
    // rust: if let Some(name) = &m.custom_name {
    // rust: meta.push((
    // rust: 2,
    // rust: serializer::OPTIONAL_COMPONENT,
    // rust: Value::OptText(Some(horizon_protocol::text::literal(name))),
    // rust: ));
    // rust: if m.name_visible {
    // rust: meta.push((3, serializer::BOOLEAN, Value::Bool(true)));
}
}
    // LivingEntity.DATA_LIVING_ENTITY_FLAGS: using an item 1, in the off
    // hand 2 (a skeleton draws its bow, a witch raises her potion).
    // rust: let using = i8::from(m.extra.using_item > 0) | i8::from(m.extra.using_off_hand) << 1;
    // rust: if using != 0 {
    // rust: meta.push((8, serializer::BYTE, Value::Byte(using)));
}
    // rust: defaults.push((8, serializer::BYTE, Value::Byte(0)));
    // LivingEntity.DATA_HEALTH_ID: defined as 1, then set to the max health.
    // rust: let health = m.health.max(0.0);
    // rust: if health != 1.0 {
    // rust: meta.push((9, serializer::FLOAT, Value::Float(health)));
}
    // rust: defaults.push((9, serializer::FLOAT, Value::Float(1.0)));
    // LivingEntity.DATA_EFFECT_PARTICLES and DATA_EFFECT_AMBIENCE_ID: the
    // swirls of its effects (the ones a mob has are visible, not ambient).
    // rust: meta.extend(
    // rust: hub.effect_meta(
    // rust: (m.extra.effects.iter())
    // rust: .filter(|e| !m.extra.hidden_effects.contains(&e.0))
    // rust: .map(|e| (e.0, m.extra.ambient_effects.contains(&e.0))),
    // rust: ),
    // rust: );
    // rust: defaults.push((10, serializer::PARTICLES, Value::Particles(Vec::new())));
    // rust: defaults.push((11, serializer::BOOLEAN, Value::Bool(false)));
    // Mob.DATA_MOB_FLAGS_ID: no AI 1, left-handed 2, aggressive 4 (what
    // draws a vindicator's axe, a skeleton's drawn bow, a piglin's raised
    // weapon).
    // rust: let flags =
    // rust: i8::from(m.no_ai) | i8::from(m.extra.left_handed) << 1 | i8::from(m.ai.aggressive) << 2;
    // rust: if flags != 0 {
    // rust: meta.push((15, serializer::BYTE, Value::Byte(flags)));
}
    // rust: defaults.push((15, serializer::BYTE, Value::Byte(0)));
    // AgeableMob.DATA_BABY_ID (and Zombie's, Zoglin's, Piglin's).
    // rust: if let Some(index) = baby_index(m.species()) {
    // rust: if m.is_baby() {
    // rust: meta.push((index, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((index, serializer::BOOLEAN, Value::Bool(false)));
        // AgeableMob.AGE_LOCKED, the entry after it (not Zombie's or Piglin's).
    // rust: if index == 16 && horizon_client::mobs::finalize::ageable(m.species()) {
    // rust: if m.extra.age_locked {
    // rust: meta.push((17, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((17, serializer::BOOLEAN, Value::Bool(false)));
}
}
    // rust: let e = &m.extra;
    // rust: let id = |registry: &str, name: &str| hub.registry_id(registry, &format!("minecraft:{name}"));
    // Pig.DATA_BOOST_TIME and Strider.DATA_BOOST_TIME (18, the first entry
    // after AgeableMob's two). The total `boost()` stored in `counter2`.
    // The default 0 is not registered: vanilla never writes it back, and the
    // rider's client finishes the timer `onSynced` started.
    // rust: if matches!(kind, "minecraft:pig" | "minecraft:strider") && e.counter2 > 0 {
    // rust: meta.push((18, serializer::INT, Value::Int(e.counter2)));
}
    // rust: mob_variant_meta(m, hub, meta, defaults);
    // rust: mob_raider_meta(m, meta, defaults);
    // rust: match kind {
    // rust: "minecraft:guardian" | "minecraft:elder_guardian" => {
            // Guardian.DATA_ID_MOVING and DATA_ID_ATTACK_TARGET.
    // rust: if e.flag2 {
    // rust: meta.push((16, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: let target = if e.flag {
    // rust: m.ai.target.and_then(|who| match who {
    // rust: Who::Player => player_entity,
    // rust: Who::Mob(id) => Some(id as i32),
    // rust: })
    // rust: } else {
    // rust: None
}
    // rust: if let Some(target) = target {
    // rust: meta.push((17, serializer::INT, Value::Int(target)));
}
    // rust: defaults.push((16, serializer::BOOLEAN, Value::Bool(false)));
    // rust: defaults.push((17, serializer::INT, Value::Int(0)));
}
        // Bat.DATA_ID_FLAGS: resting in bit 0, flying by default.
    // rust: "minecraft:bat" => {
    // rust: if e.flag {
    // rust: meta.push((16, serializer::BYTE, Value::Byte(1)));
}
    // rust: defaults.push((16, serializer::BYTE, Value::Byte(0)));
}
        // SnowGolem.DATA_PUMPKIN_ID: 16 while the pumpkin is on (the default).
    // rust: "minecraft:snow_golem" => {
    // rust: if e.sheared {
    // rust: meta.push((16, serializer::BYTE, Value::Byte(0)));
}
    // rust: defaults.push((16, serializer::BYTE, Value::Byte(16)));
}
        // MushroomCow.DATA_TYPE (after AgeableMob's two): 0 red, 1 brown.
    // rust: "minecraft:mooshroom" => {
    // rust: if e.variant == 1 {
    // rust: meta.push((18, serializer::INT, Value::Int(1)));
}
    // rust: defaults.push((18, serializer::INT, Value::Int(0)));
}
        // AbstractPiglin.DATA_IMMUNE_TO_ZOMBIFICATION (16: with the dimension it
        // makes it shake) and Piglin.DATA_IS_DANCING (after the baby flag and
        // the crossbow charge).
    // rust: "minecraft:piglin" => {
    // rust: if e.flag2 {
    // rust: meta.push((16, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((16, serializer::BOOLEAN, Value::Bool(false)));
    // rust: if e.scratch[0] > 0 {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((19, serializer::BOOLEAN, Value::Bool(false)));
}
        // Sheep.DATA_WOOL_ID: the colour in the low nibble, 16 when sheared.
    // rust: "minecraft:sheep" => {
    // rust: let value = (e.color & 15) | if e.sheared { 16 } else { 0 };
    // rust: if value != 0 {
    // rust: meta.push((18, serializer::BYTE, Value::Byte(value as i8)));
}
    // rust: defaults.push((18, serializer::BYTE, Value::Byte(0)));
}
        // Fox.DATA_TYPE_ID and DATA_FLAGS_ID (after AgeableMob's two; sleeping 32, ...).
    // rust: "minecraft:fox" => {
    // rust: if e.variant != 0 {
    // rust: meta.push((18, serializer::INT, Value::Int(i32::from(e.variant))));
}
    // rust: defaults.push((18, serializer::INT, Value::Int(0)));
    // rust: let flags = (e.ints[0] & 0xff) as u8 as i8;
    // rust: if flags != 0 {
    // rust: meta.push((19, serializer::BYTE, Value::Byte(flags)));
}
    // rust: defaults.push((19, serializer::BYTE, Value::Byte(0)));
}
    // rust: "minecraft:parrot" => {
            // TamableAnimal.DATA_FLAGS_ID: sitting 1, tame 4.
    // rust: let flags = i8::from(e.sitting) | if e.tame { 4 } else { 0 };
    // rust: if flags != 0 {
    // rust: meta.push((18, serializer::BYTE, Value::Byte(flags)));
}
}
    // rust: "minecraft:cat" | "minecraft:wolf" => {
            // TamableAnimal.DATA_FLAGS_ID: sitting 1, tame 4.
    // rust: let flags = i8::from(e.sitting) | if e.tame { 4 } else { 0 };
    // rust: if flags != 0 {
    // rust: meta.push((18, serializer::BYTE, Value::Byte(flags)));
}
    // rust: let (index, registry, name) = if kind == "minecraft:cat" {
    // rust: let v = horizon_client::mobs::tame::CAT_VARIANTS[(e.variant as usize).min(10)];
    // rust: (20, "minecraft:cat_variant", v)
    // rust: } else {
    // rust: let v = horizon_client::mobs::tame::WOLF_VARIANTS[(e.variant as usize).min(8)].0;
    // rust: (23, "minecraft:wolf_variant", v)
}
    // rust: let serializer = if index == 20 {
    // rust: serializer::CAT_VARIANT
    // rust: } else {
    // rust: serializer::WOLF_VARIANT
}
    // rust: if let Some(v) = id(registry, name) {
    // rust: meta.push((index, serializer, Value::Id(v)));
}
            // Cat.IS_LYING and RELAX_STATE_ONE.
    // rust: if kind == "minecraft:cat" {
    // rust: for (index, on) in [(21, e.flag), (22, e.relax_one)] {
    // rust: if on {
    // rust: meta.push((index, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((index, serializer::BOOLEAN, Value::Bool(false)));
}
}
            // Wolf.DATA_COLLAR_COLOR and Cat's, red by default.
    // rust: let collar = if kind == "minecraft:cat" { 23 } else { 21 };
    // rust: let red = i32::from(horizon_client::mobs::tame::RED);
    // rust: if i32::from(e.color & 15) != red {
    // rust: meta.push((collar, serializer::INT, Value::Int(i32::from(e.color & 15))));
}
    // rust: defaults.push((collar, serializer::INT, Value::Int(red)));
            // Wolf.DATA_ANGER_END_TIME: the game time the anger ends, -1 when calm.
    // rust: if kind == "minecraft:wolf" {
                // Wolf.DATA_INTERESTED_ID: BegGoal's flag, the head tilt.
    // rust: if e.flag {
    // rust: meta.push((20, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((20, serializer::BOOLEAN, Value::Bool(false)));
    // rust: if e.anger > 0 {
    // rust: let end = game_time + i64::from(e.anger);
    // rust: meta.push((22, serializer::LONG, Value::Long(end)));
}
    // rust: defaults.push((22, serializer::LONG, Value::Long(-1)));
}
}
    // rust: "minecraft:horse"
    // rust: | "minecraft:donkey"
    // rust: | "minecraft:mule"
    // rust: | "minecraft:llama"
    // rust: | "minecraft:trader_llama"
    // rust: | "minecraft:skeleton_horse"
    // rust: | "minecraft:zombie_horse"
    // rust: | "minecraft:camel" => {
            // AbstractHorse.DATA_ID_FLAGS: tame 2, eating 16 (grazing), standing
            // 32 (rearing).
    // rust: let grazes = horizon_client::mobs::equine::grazes(m.species());
    // rust: let flags = if e.tame { 2 } else { 0 }
    // rust: | if grazes && e.flag { 16 } else { 0 }
    // rust: | if grazes && e.counter > 0 { 32 } else { 0 };
    // rust: if flags != 0 {
    // rust: meta.push((18, serializer::BYTE, Value::Byte(flags)));
}
    // rust: defaults.push((18, serializer::BYTE, Value::Byte(0)));
    // rust: if kind == "minecraft:horse" {
    // rust: let v = i32::from(e.variant) | i32::from(e.variant2) << 8;
    // rust: if v != 0 {
    // rust: meta.push((19, serializer::INT, Value::Int(v)));
}
    // rust: } else if kind.ends_with("llama") {
    // rust: if e.chested {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: meta.push((
    // rust: 20,
    // rust: serializer::INT,
    // rust: Value::Int(i32::from(e.variant2.max(1))),
    // rust: ));
    // rust: if e.variant != 0 {
    // rust: meta.push((21, serializer::INT, Value::Int(i32::from(e.variant))));
}
    // rust: } else if (kind == "minecraft:donkey" || kind == "minecraft:mule") && e.chested {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
}
        // HappyGhast.STAYS_STILL (after AgeableMob's two and IS_LEASH_HOLDER),
        // set while `serverStillTimeout > 0` (`syncStayStillFlag`).
    // rust: "minecraft:happy_ghast" => {
            // HappyGhast.IS_LEASH_HOLDER (`setLeashHolder` in `tick`).
    // rust: if horizon_client::mobs::happy_ghast::is_leash_holder(m) {
    // rust: meta.push((18, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((18, serializer::BOOLEAN, Value::Bool(false)));
    // rust: if horizon_client::mobs::happy_ghast::on_still_timeout(m) {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((19, serializer::BOOLEAN, Value::Bool(false)));
}
        // Villager.DATA_VILLAGER_DATA and ZombieVillager's (after Zombie's three).
    // rust: "minecraft:villager" | "minecraft:zombie_villager" => {
//             use horizon_client::mobs::render::{PROFESSIONS, VILLAGER_TYPES};
    // rust: if kind == "minecraft:villager" {
    // rust: unhappy_counter(m, meta, defaults);
    // rust: } else {
                // ZombieVillager.DATA_CONVERTING_ID: the cure's shaking.
    // rust: if horizon_client::mobs::zombie_villager::is_converting(m) {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((19, serializer::BOOLEAN, Value::Bool(false)));
}
    // rust: let villager_type = VILLAGER_TYPES[e.variant as usize % VILLAGER_TYPES.len()];
    // rust: let profession = PROFESSIONS[e.variant2 as usize % PROFESSIONS.len()];
    // rust: if let (Some(t), Some(p)) = (
    // rust: id("minecraft:villager_type", villager_type),
    // rust: id("minecraft:villager_profession", profession),
    // rust: ) {
    // rust: let index = if kind == "minecraft:villager" { 19 } else { 20 };
    // rust: let level = i32::from(e.variant3.max(1));
    // rust: meta.push((
    // rust: index,
    // rust: serializer::VILLAGER_DATA,
    // rust: Value::Ids(vec![t, p, level]),
    // rust: ));
}
}
        // Phantom.ID_SIZE (after Mob's flags).
    // rust: "minecraft:phantom" => {
    // rust: if e.size > 0 {
    // rust: meta.push((16, serializer::INT, Value::Int(e.size)));
}
    // rust: defaults.push((16, serializer::INT, Value::Int(0)));
}
        // AbstractCubeMob.ID_SIZE; SulfurCube also syncs FROM_BUCKET and
        // MAX_FUSE (clients tick the fuse for the swell / white flash).
    // rust: "minecraft:slime" | "minecraft:magma_cube" | "minecraft:sulfur_cube" => {
    // rust: if e.size > 1 {
    // rust: meta.push((18, serializer::INT, Value::Int(e.size)));
}
    // rust: defaults.push((18, serializer::INT, Value::Int(1)));
    // rust: if kind == "minecraft:sulfur_cube" {
    // rust: let from_bucket = e.scratch[3] != 0;
    // rust: if from_bucket {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((19, serializer::BOOLEAN, Value::Bool(false)));
                // SulfurCube.MAX_FUSE: set when primed; 0 means unprimed.
    // rust: let fuse = horizon_client::mobs::sulfur_cube::fuse(m);
    // rust: if fuse >= 0 {
    // rust: meta.push((20, serializer::INT, Value::Int(fuse)));
}
    // rust: defaults.push((20, serializer::INT, Value::Int(0)));
}
}
        // Creeper.DATA_SWELL_DIR, DATA_IS_POWERED and DATA_IS_IGNITED: the
        // guest swells the creeper from them. The direction always goes in,
        // as only changed entries are sent and it drops back to -1.
    // rust: "minecraft:creeper" => {
    // rust: meta.push((16, serializer::INT, Value::Int(e.counter)));
    // rust: if e.charged {
    // rust: meta.push((17, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: if e.flag {
    // rust: meta.push((18, serializer::BOOLEAN, Value::Bool(true)));
}
}
        // Pillager.IS_CHARGING_CROSSBOW: the charge pose and the held
        // item's loading animation.
    // rust: "minecraft:pillager" => {
    // rust: if e.flag {
    // rust: meta.push((17, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((17, serializer::BOOLEAN, Value::Bool(false)));
}
        // Panda: UNHAPPY_COUNTER, SNEEZE_COUNTER and EAT_COUNTER (after
        // AgeableMob's two), MAIN_GENE_ID, HIDDEN_GENE_ID and DATA_ID_FLAGS;
        // the client animates the states from them.
    // rust: "minecraft:panda" => {
    // rust: let (flags, counters) = horizon_client::mobs::panda::get(m)
    // rust: .map_or((0, [0; 3]), |s| (s.flags, [s.unhappy, s.sneeze, s.eat]));
    // rust: for (index, value) in (18..).zip(counters) {
    // rust: if value != 0 {
    // rust: meta.push((index, serializer::INT, Value::Int(value)));
}
    // rust: defaults.push((index, serializer::INT, Value::Int(0)));
}
    // rust: for (index, gene) in [(21, e.variant), (22, e.variant2)] {
    // rust: if gene != 0 {
    // rust: meta.push((index, serializer::BYTE, Value::Byte(gene as i8)));
}
    // rust: defaults.push((index, serializer::BYTE, Value::Byte(0)));
}
    // rust: if flags != 0 {
    // rust: meta.push((23, serializer::BYTE, Value::Byte(flags as i8)));
}
    // rust: defaults.push((23, serializer::BYTE, Value::Byte(0)));
}
        // PolarBear.DATA_STANDING_ID (after AgeableMob's two): the bear
        // rears up; the client animates it.
    // rust: "minecraft:polar_bear" => {
    // rust: if e.flag {
    // rust: meta.push((18, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((18, serializer::BOOLEAN, Value::Bool(false)));
}
        // SpellcasterIllager.DATA_SPELL_CASTING_ID: the casting pose.
    // rust: "minecraft:evoker" | "minecraft:illusioner" => {
    // rust: if e.variant2 != 0 {
    // rust: meta.push((17, serializer::BYTE, Value::Byte(e.variant2 as i8)));
}
    // rust: defaults.push((17, serializer::BYTE, Value::Byte(0)));
}
        // Warden.CLIENT_ANGER_LEVEL: the heartbeat's pace.
    // rust: "minecraft:warden" => {
    // rust: let anger = e.warden.as_ref().map_or(0, |w| w.client_anger);
    // rust: if anger != 0 {
    // rust: meta.push((16, serializer::INT, Value::Int(anger)));
}
    // rust: defaults.push((16, serializer::INT, Value::Int(0)));
}
        // Sniffer.DATA_STATE (after AgeableMob's two).
    // rust: "minecraft:sniffer" => {
    // rust: if e.variant != 0 {
    // rust: meta.push((
    // rust: 18,
    // rust: serializer::SNIFFER_STATE,
    // rust: Value::Id(i32::from(e.variant)),
    // rust: ));
}
    // rust: defaults.push((18, serializer::SNIFFER_STATE, Value::Id(0)));
}
        // Shulker.DATA_ATTACH_FACE_ID, DATA_PEEK_ID and DATA_COLOR_ID (16
        // for none).
    // rust: "minecraft:shulker" => {
    // rust: if e.variant3 != 0 {
    // rust: meta.push((16, serializer::DIRECTION, Value::Id(i32::from(e.variant3))));
}
    // rust: defaults.push((16, serializer::DIRECTION, Value::Id(0)));
    // rust: if e.counter != 0 {
    // rust: meta.push((17, serializer::BYTE, Value::Byte(e.counter as i8)));
}
    // rust: defaults.push((17, serializer::BYTE, Value::Byte(0)));
    // rust: if e.color != 16 {
    // rust: meta.push((18, serializer::BYTE, Value::Byte(e.color as i8)));
}
    // rust: defaults.push((18, serializer::BYTE, Value::Byte(16)));
}
        // Vex.DATA_FLAGS_ID: charging in bit 0 (the arms and the glowing
        // texture).
    // rust: "minecraft:vex" => {
    // rust: if e.flag {
    // rust: meta.push((16, serializer::BYTE, Value::Byte(1)));
}
    // rust: defaults.push((16, serializer::BYTE, Value::Byte(0)));
}
        // GlowSquid.DATA_DARK_TICKS_REMAINING (after AgeableMob's two): the
        // dimming a hit gave, counted down by the server and the client alike.
    // rust: "minecraft:glow_squid" => {
    // rust: let ticks = horizon_client::mobs::aquatic::dark_ticks(m);
    // rust: if ticks != 0 {
    // rust: meta.push((18, serializer::INT, Value::Int(ticks)));
}
    // rust: defaults.push((18, serializer::INT, Value::Int(0)));
}
        // Ocelot.DATA_TRUSTING (after AgeableMob's two).
    // rust: "minecraft:ocelot" => {
    // rust: if e.trusting {
    // rust: meta.push((18, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((18, serializer::BOOLEAN, Value::Bool(false)));
}
        // Mannequin.DATA_PROFILE, DATA_IMMOVABLE and DATA_DESCRIPTION (after Avatar's two):
        // `updateDescription` keeps the last as a component, or none when hidden.
    // rust: "minecraft:mannequin" => {
    // rust: if let Some(profile) = &m.profile {
    // rust: meta.push((
    // rust: 17,
    // rust: serializer::RESOLVABLE_PROFILE,
    // rust: Value::Profile(profile.clone()),
    // rust: ));
}
    // rust: if e.immovable {
    // rust: meta.push((18, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((18, serializer::BOOLEAN, Value::Bool(false)));
    // rust: let default = horizon_client::mobs::MannequinDescription::Default.component();
    // rust: let shown = e.description.component();
    // rust: if shown != default {
    // rust: meta.push((19, serializer::OPTIONAL_COMPONENT, Value::OptText(shown)));
}
    // rust: defaults.push((19, serializer::OPTIONAL_COMPONENT, Value::OptText(default)));
}
        // Creaking.CAN_MOVE, IS_ACTIVE and IS_TEARING_DOWN.
    // rust: "minecraft:creaking" => {
    // rust: if e.flag2 {
    // rust: meta.push((16, serializer::BOOLEAN, Value::Bool(false)));
}
    // rust: defaults.push((16, serializer::BOOLEAN, Value::Bool(true)));
    // rust: if e.flag {
    // rust: meta.push((17, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((17, serializer::BOOLEAN, Value::Bool(false)));
    // rust: if horizon_client::mobs::creaking::tearing_down(m) {
    // rust: meta.push((18, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((18, serializer::BOOLEAN, Value::Bool(false)));
}
        // Allay.DATA_DANCING and DATA_CAN_DUPLICATE (the held item is its
        // main hand equipment).
    // rust: "minecraft:allay" => {
    // rust: if e.flag {
    // rust: meta.push((16, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((16, serializer::BOOLEAN, Value::Bool(false)));
    // rust: if e.egg_time > 0 {
    // rust: meta.push((17, serializer::BOOLEAN, Value::Bool(false)));
}
    // rust: defaults.push((17, serializer::BOOLEAN, Value::Bool(true)));
}
        // Axolotl.DATA_PLAYING_DEAD (after DATA_VARIANT).
    // rust: "minecraft:axolotl" => {
    // rust: if horizon_client::mobs::axolotl::is_playing_dead(m) {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((19, serializer::BOOLEAN, Value::Bool(false)));
}
        // CopperGolem.COPPER_GOLEM_STATE (after DATA_WEATHER_STATE).
    // rust: "minecraft:copper_golem" => {
    // rust: if e.variant3 != 0 {
    // rust: meta.push((
    // rust: 17,
    // rust: serializer::COPPER_GOLEM_STATE,
    // rust: Value::Id(i32::from(e.variant3)),
    // rust: ));
}
    // rust: defaults.push((17, serializer::COPPER_GOLEM_STATE, Value::Id(0)));
}
        // Armadillo.ARMADILLO_STATE (after AgeableMob's two).
    // rust: "minecraft:armadillo" => {
    // rust: let state = horizon_client::mobs::armadillo::state(m);
    // rust: if state != 0 {
    // rust: meta.push((18, serializer::ARMADILLO_STATE, Value::Id(i32::from(state))));
}
    // rust: defaults.push((18, serializer::ARMADILLO_STATE, Value::Id(0)));
}
        // Frog.DATA_TONGUE_TARGET_ID (after the variant): the entity id plus
        // one, 0 for none.
    // rust: "minecraft:frog" => {
    // rust: if let Some(target) = e.frog.tongue_target {
    // rust: let id = i32::try_from(target).map_or(0, |t| t + 1);
    // rust: meta.push((19, serializer::OPTIONAL_UNSIGNED_INT, Value::Id(id)));
}
    // rust: defaults.push((19, serializer::OPTIONAL_UNSIGNED_INT, Value::Id(0)));
}
        // Goat.DATA_HAS_LEFT_HORN and DATA_HAS_RIGHT_HORN (after
        // DATA_IS_SCREAMING_GOAT): both true by default.
    // rust: "minecraft:goat" => {
    // rust: for (index, lost) in [(19, e.lost_horns[0]), (20, e.lost_horns[1])] {
    // rust: if lost {
    // rust: meta.push((index, serializer::BOOLEAN, Value::Bool(false)));
}
    // rust: defaults.push((index, serializer::BOOLEAN, Value::Bool(true)));
}
}
        // Enderman.DATA_CARRY_STATE and DATA_CREEPY (angry: the open mouth).
    // rust: "minecraft:enderman" => {
    // rust: if let Some(state) = e.carried {
    // rust: meta.push((
    // rust: 16,
    // rust: serializer::OPTIONAL_BLOCK_STATE,
    // rust: Value::Id(state.0 as i32),
    // rust: ));
}
    // rust: if e.flag {
    // rust: meta.push((17, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((17, serializer::BOOLEAN, Value::Bool(false)));
    // rust: defaults.push((16, serializer::OPTIONAL_BLOCK_STATE, Value::Id(0)));
}
        // Zombie.DATA_DROWNED_CONVERSION_ID (after DATA_BABY_ID and
        // DATA_SPECIAL_TYPE_ID): the shaking of the conversion under water.
    // rust: "minecraft:zombie" | "minecraft:husk" => {
    // rust: if e.counter2 > 0 {
    // rust: meta.push((18, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((18, serializer::BOOLEAN, Value::Bool(false)));
}
        // Skeleton.DATA_STRAY_CONVERSION_ID (the first entry after Mob's):
        // the shaking of the freezing conversion.
    // rust: "minecraft:skeleton" => {
    // rust: if e.counter2 > 0 {
    // rust: meta.push((16, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((16, serializer::BOOLEAN, Value::Bool(false)));
}
        // Bogged.DATA_SHEARED (the first entry after Mob's): the mushrooms
        // on its head are gone.
    // rust: "minecraft:bogged" => {
    // rust: if e.sheared {
    // rust: meta.push((16, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((16, serializer::BOOLEAN, Value::Bool(false)));
}
        // AbstractVillager.DATA_UNHAPPY_COUNTER (after AgeableMob's two).
    // rust: "minecraft:wandering_trader" => unhappy_counter(m, meta, defaults),
        // Hoglin.DATA_IMMUNE_TO_ZOMBIFICATION (after AgeableMob's two) and
        // AbstractPiglin's, the first entry of its subclasses (the piglin's is
        // in its own arm): with the dimension it makes them shake.
    // rust: "minecraft:hoglin" | "minecraft:piglin_brute" => {
    // rust: let index = if kind == "minecraft:hoglin" { 18 } else { 16 };
    // rust: if e.flag2 {
    // rust: meta.push((index, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((index, serializer::BOOLEAN, Value::Bool(false)));
}
        // Blaze.DATA_FLAGS_ID: charged 1, which makes it burn.
    // rust: "minecraft:blaze" => {
    // rust: if e.flag {
    // rust: meta.push((16, serializer::BYTE, Value::Byte(1)));
}
    // rust: defaults.push((16, serializer::BYTE, Value::Byte(0)));
}
        // Turtle.HAS_EGG and LAYING_EGG (after AgeableMob's two).
    // rust: "minecraft:turtle" => {
    // rust: if e.flag {
    // rust: meta.push((18, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: if e.flag2 {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((18, serializer::BOOLEAN, Value::Bool(false)));
    // rust: defaults.push((19, serializer::BOOLEAN, Value::Bool(false)));
}
        // WitherBoss.DATA_TARGET_B and DATA_TARGET_C (after DATA_TARGET_A, the
        // main target): the entities the side heads look at, by id.
    // rust: "minecraft:wither" => {
    // rust: for (k, index) in [(0, 17), (1, 18)] {
    // rust: let target = match e.ints[k] {
    // rust: 0 => None,
    // rust: -1 => player_entity,
    // rust: id => Some(id),
}
    // rust: if let Some(target) = target {
    // rust: meta.push((index, serializer::INT, Value::Int(target)));
}
    // rust: defaults.push((index, serializer::INT, Value::Int(0)));
}
}
    // rust: _ => {}
}
    // Camel.DASH and LAST_POSE_CHANGE_TICK (after AbstractHorse's flags).
    // rust: if horizon_client::mobs::camel::is_camel(m.species()) {
    // rust: if e.flag2 {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((19, serializer::BOOLEAN, Value::Bool(false)));
    // rust: let tick = horizon_client::mobs::camel::synced_pose_tick(m, game_time);
    // rust: if tick != 0 {
    // rust: meta.push((20, serializer::LONG, Value::Long(tick)));
}
    // rust: defaults.push((20, serializer::LONG, Value::Long(0)));
}
}

// AbstractVillager.DATA_UNHAPPY_COUNTER (after AgeableMob's two): the head
// shake of a villager saying no counts it down from 40.
    // rust: fn unhappy_counter(
    // rust: m: &Mob,
    // rust: meta: &mut Vec<(u8, i32, Value)>,
    // rust: defaults: &mut Vec<(u8, i32, Value)>,
    // rust: ) {
    // rust: if m.extra.ints[0] > 0 {
    // rust: meta.push((18, serializer::INT, Value::Int(m.extra.ints[0])));
}
    // rust: defaults.push((18, serializer::INT, Value::Int(0)));
}

// Raider.IS_CELEBRATING: also list false so tracking sends the end of a celebration.
    // rust: pub(super) fn mob_raider_meta(
    // rust: m: &Mob,
    // rust: meta: &mut Vec<(u8, i32, Value)>,
    // rust: defaults: &mut Vec<(u8, i32, Value)>,
    // rust: ) {
//     use horizon_client::mobs::raider;
    // rust: if raider::is_raider(m.species()) {
    // rust: if raider::state(m).is_some_and(|state| state.celebrating) {
    // rust: meta.push((16, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((16, serializer::BOOLEAN, Value::Bool(false)));
}
}

// What a client shakes a mob by: Entity.DATA_TICKS_FROZEN (7), whose full
// count is `isFullyFrozen`, and Strider.DATA_SUFFOCATING (19, after
// AgeableMob's two and DATA_BOOST_TIME).
    // rust: pub(super) fn mob_freeze_meta(
    // rust: m: &Mob,
    // rust: meta: &mut Vec<(u8, i32, Value)>,
    // rust: defaults: &mut Vec<(u8, i32, Value)>,
    // rust: ) {
    // `setTicksFrozen` can go negative (a mob warming up), and a client reads
    // the count as is, so anything but the default 0 goes out.
    // rust: if m.ticks_frozen != 0 {
    // rust: meta.push((7, serializer::INT, Value::Int(m.ticks_frozen)));
}
    // rust: defaults.push((7, serializer::INT, Value::Int(0)));
    // Every Entity tracks air, including changes back to its species' default.
    // rust: let max = m.max_air_supply();
    // rust: if m.air != max {
    // rust: meta.push((1, serializer::INT, Value::Int(m.air)));
}
    // rust: defaults.push((1, serializer::INT, Value::Int(max)));
    // rust: if m.kind.id == "minecraft:strider" {
    // rust: if m.extra.flag {
    // rust: meta.push((19, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: defaults.push((19, serializer::BOOLEAN, Value::Bool(false)));
}
}

// The equipment a mob shows (ClientboundSetEquipmentPacket slots: main hand,
// off hand, feet, legs, chest, head, body, saddle).
    // rust: fn mob_equipment(
    // rust: m: &Mob,
    // rust: hub: &mut Hub,
    // rust: out: &mut Vec<(u8, Option<horizon_protocol::item::Stack>)>,
    // rust: ) {
    // rust: for (slot, stack) in m.equipment_stacks().into_iter().enumerate() {
    // rust: if stack.is_some() {
    // rust: out.push((slot as u8, hub.stack(&stack)));
}
}
}

    // rust: pub const HELP: &[&str] = &[
    // rust: "lan open [PORT] [commands] [force]  open the world to the network (PORT 0 picks one)",
    // rust: "lan close                      stop hosting",
    // rust: "lan status                     the hosting state and the guests",
    // rust: ];

// With the game mode forced, the guests online take the default mode
// (setting a mode does nothing when it is already theirs). A world open to
// LAN is an integrated server, which leaves out the players who have game
// master permission; a dedicated server does not.
    // rust: fn enforce_guest_game_mode(
    // rust: host: &mut LanHost,
    // rust: world: &World,
    // rust: collision: &BlockCollisionRegistry<'_>,
    // rust: ) {
    // rust: if !host.hub.config.force_game_mode {
    // rust: return;
}
    // rust: let mode = host.hub.config.default_game_mode;
    // rust: let spares_operators = host.hub.config.integrated;
    // rust: let stale: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.game_mode != mode && !(spares_operators && g.permission >= 2))
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in stale {
    // rust: host.hub.set_game_mode(conn, mode, world, Some(collision));
}
}

    // rust: impl Game<'_> {
    // `horizon-ctl lan ...`.
    // rust: pub(super) fn lan_control(&mut self, words: &[&str]) -> Result<Option<serde_json::Value>> {
//         use serde_json::json;
    // rust: if words[0] != "lan" {
    // rust: return Ok(None);
}
    // rust: if let Some(server) = &self.integrated
    // rust: && words.get(1) == Some(&"status")
    // rust: {
            // The hub is the server thread's.
    // rust: let status = server
    // rust: .call(|g| g.lan_status())
    // rust: .ok_or(super::integrated::NO_ANSWER)?;
    // rust: return Ok(Some(status));
}
    // rust: match words.get(1).copied() {
    // rust: Some("open") => {
    // rust: if self.title.is_some() {
    // rust: return Err("open a world first".into());
}
    // rust: let port = words.get(2).map_or(Ok(0), |p| p.parse::<u16>())?;
    // rust: self.lan_open(LanSettings {
    // rust: port: if port == 0 {
    // rust: lan::available_port()
    // rust: } else {
    // rust: port
    // rust: },
    // rust: guest_commands: words.contains(&"commands"),
    // rust: force_game_mode: words.contains(&"force"),
    // rust: })?;
    // rust: Ok(Some(json!({ "ok": true, "port": self.lan_port() })))
}
    // rust: Some("close") => {
    // rust: self.lan_close(true);
    // rust: Ok(Some(json!({ "ok": true })))
}
    // rust: Some("status") => Ok(Some(self.lan_status())),
    // rust: _ => Err("lan open|close|status".into()),
}
}

    // `horizon-ctl lan status`.
lan_status :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
//         use serde_json::json;
    // rust: match &self.lan {
    // rust: Some(h) if !self.serving() || self.published_port().is_some() => json!({
    // rust: "open": true,
                // The owner's profile name.
    // rust: "host": self.options.player_name(),
    // rust: "port": h.settings.port,
                // The server's own world: its finished chunks and how many it
                // has generated or loaded so far.
    // rust: "world": {
    // rust: "chunks": self.world.chunks.len(),
    // rust: "generated": self.streaming.generated_total,
    // rust: },
    // rust: "guests": h.hub.guests.iter().map(|g| json!({
    // rust: "name": g.name,
    // rust: "position": g.position,
    // rust: "placed": g.placed,
    // rust: "loaded": g.loaded,
    // rust: "game_mode": g.game_mode,
                    // ItemCooldowns: the ticks the shield an axe disabled stays down.
    // rust: "shield_cooldown": h.play.get(&g.conn).map_or(0, |p| p.shield_cooldown),
                    // The item the server has this guest using: its slot and ticks.
    // rust: "using": h.play.get(&g.conn).and_then(|p| p.using())
    // rust: .map(|(slot, ticks)| json!({ "slot": slot, "ticks": ticks })),
    // rust: "sneaking": g.sneaking,
                    // The server's Elytra glide (shared flag 7).
    // rust: "fall_flying": g.fall_flying,
    // rust: "sleeping": g.bed,
    // rust: "health": g.health,
                    // The server's body: its air supply and golden hearts.
    // rust: "air": g.motion.as_ref().map(|m| m.air),
    // rust: "absorption": g.motion.as_ref().map(|m| m.health.absorption()),
                    // FoodData: food level, saturation and exhaustion.
    // rust: "food": [
    // rust: f64::from(g.food),
    // rust: f64::from(g.saturation),
    // rust: g.motion.as_ref().map_or(0.0, |m| f64::from(m.health.food.exhaustion)),
    // rust: ],
    // rust: "chunks": g.sent_chunks.len(),
    // rust: "tracked": g.tracker.len(),
    // rust: })).collect::<Vec<_>>(),
    // rust: }),
    // rust: _ => json!({ "open": false }),
}
}

    // rust: pub(super) fn lan_open(&mut self, settings: LanSettings) -> Result<()> {
    // rust: let port = if let Some(server) = &self.integrated {
            // ShareToLanScreen: IntegratedServer.publishServer.
    // rust: server
    // rust: .call(move |g| g.publish(settings))
    // rust: .ok_or(super::integrated::NO_ANSWER)??
    // rust: } else if self.serving() {
    // rust: return self.publish(settings).map(drop).map_err(Into::into);
    // rust: } else {
    // rust: return Err("no world of this game to open".into());
}
    // rust: self.system_message(Text::translate(
    // rust: "menu.multiplayerOptions.publish.started.lan",
    // rust: &[Text::literal(port.to_string())],
    // rust: ));
    // rust: Ok(())
}
    // Start the network side and the play-state hub: for the LAN (with the
    // host's own profile reserved) or for a dedicated server (no host).
    // rust: pub(super) fn lan_host(
    // rust: &mut self,
    // rust: settings: LanSettings,
    // rust: net: NetConfig,
    // rust: config: HubConfig,
    // rust: ) -> Result<()> {
    // rust: let mut sync = sync_data(&self.options.resources, &self.pack_files())?;
    // rust: let features = if self.level.enabled_features.is_empty() {
    // rust: vec!["minecraft:vanilla".to_owned()]
    // rust: } else {
    // rust: self.level.enabled_features.clone()
}
        // A world whose packs change biomes sends its own biome registry.
    // rust: let packed = self.world_biomes.clone().filter(|b| b.has_packs());
    // rust: if packed.is_some()
    // rust: || sync.features.iter().any(|f| !features.contains(f))
    // rust: || features.iter().any(|f| !sync.features.contains(f))
    // rust: {
            // The shared resource preload has vanilla flags and vanilla biomes.
            // Feature flags and biomes belong to this world, not to the cached
            // resources or the next world opened.
    // rust: let mut world_sync = SyncData::load_with_kept(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: packed.as_deref(),
    // rust: Some(sync.as_ref()),
    // rust: )?;
    // rust: world_sync.features = features;
    // rust: sync = Arc::new(world_sync);
}
    // rust: self.sync_dialog_ids(&sync);
        // The table the world plays with (`world_biomes!`): a world with
        // biome data packs sends their ids past the built-in list, as the
        // encoder's `SectionCoder` expects.
    // rust: let biome_names: Vec<String> = world_biomes!(self)
    // rust: .list
    // rust: .iter()
    // rust: .map(|b| b.name.clone())
    // rust: .collect();
    // rust: let registry: Vec<String> = sync
    // rust: .dynamic
    // rust: .registries
    // rust: .get(BIOME_REGISTRY)
    // rust: .map(|v| v.iter().map(|(n, _)| n.clone()).collect())
    // rust: .unwrap_or_default();
    // rust: let mut encoder = ChunkEncoder::with_signs(
    // rust: self.res.facts().states.iter().map(|s| {
    // rust: (
    // rust: s.name.clone(),
    // rust: s.fluid_level > 0 || s.waterlogged,
    // rust: s.sign_form(),
    // rust: )
    // rust: }),
    // rust: &sync.builtin,
    // rust: &biome_names,
    // rust: &registry,
    // rust: );
    // rust: encoder.tables = Some(
    // rust: self.save
    // rust: .tables
    // rust: .get_or_init(|| Arc::new(horizon_client::save::SaveTables::new(&self.pack.assets)))
    // rust: .clone(),
    // rust: );
    // rust: encoder.mod_update_tag = Some(|pos, entity| {
    // rust: let mut tag = None;
    // rust: Game::native_block_entity_update_tag(pos, entity, &mut tag);
    // rust: tag
    // rust: });
    // rust: let far = (net.lod_distance > 0)
    // rust: .then(|| horizon_client::lod_net::Service::new(net.lod_distance, biome_names.clone()));
    // rust: let lan = Lan::start_with(sync.clone(), net)?;
    // rust: let mut hub = Hub::new(lan, sync, encoder, config);
    // rust: hub.sync_attachments = !crate::mod_api::mods().is_empty();
    // rust: hub.flat_world = self.world_flat;
    // rust: hub.debug_world = self.world_debug;
    // rust: let port = hub.lan.port;
    // rust: self.world.block_log = Some(Vec::new());
    // rust: self.world.light_log = Some(Default::default());
    // rust: self.lan = Some(LanHost {
    // rust: players_told_left: false,
    // rust: hub,
    // rust: settings: LanSettings { port, ..settings },
    // rust: play: HashMap::new(),
    // rust: broken: Vec::new(),
    // rust: mob_state: HashMap::new(),
    // rust: poses: HashMap::new(),
    // rust: mob_players: Default::default(),
    // rust: owner: None,
    // rust: waypoints: Default::default(),
    // rust: waypoint_dead: Default::default(),
    // rust: border_sent: None,
    // rust: commands: Vec::new(),
    // rust: quiet: std::collections::VecDeque::new(),
    // rust: far,
    // rust: native_commands: None,
    // rust: sleep_ignored: Default::default(),
    // rust: states: Default::default(),
    // rust: states_next_entity: None,
    // rust: idle_states: Default::default(),
    // rust: });
    // rust: self.audio.capture = Some(Vec::new());
    // rust: Ok(())
}

    // IntegratedServer.unpublishServer: the guests are sent away.
    // rust: pub(super) fn lan_close(&mut self, announce: bool) {
    // rust: if self.integrated.is_some() || self.serving() {
    // rust: let closed = match &self.integrated {
    // rust: Some(server) => server.call(|g| g.unpublish()).unwrap_or(false),
    // rust: None => self.unpublish(),
}
    // rust: if closed {
    // rust: self.friends_lan_closed();
}
    // rust: if closed && announce && self.integrated.is_some() {
    // rust: self.system_message(Text::translate(
    // rust: "menu.multiplayerOptions.publish.stopped",
    // rust: &[],
    // rust: ));
}
    // rust: return;
}
    // rust: self.friends_lan_closed();
    // rust: self.native_players_leaving();
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: self.award_leave_game_to_all(&mut host);
    // rust: self.save_leaving_guests(&mut host);
    // rust: host.hub.disconnect_all();
        // Give the network threads a moment to flush the disconnect packets.
    // rust: std::thread::sleep(std::time::Duration::from_millis(100));
    // rust: self.world.block_log = None;
    // rust: self.world.light_log = None;
    // rust: self.audio.capture = None;
    // rust: self.lan_events.clear();
    // rust: self.lan_songs.clear();
    // rust: self.lan_critical_hits.clear();
    // rust: self.lan_cushion_breaks.clear();
    // rust: self.streaming.extra.clear();
    // rust: if announce {
    // rust: self.system_message(Text::translate(
    // rust: "menu.multiplayerOptions.publish.stopped",
    // rust: &[],
    // rust: ));
}
}

    // `PlayerList.removeAll`: every guest leaves in turn, the vehicle it
    // alone rides with it (`PlayerList.remove`), and is saved.
    // rust: pub(super) fn save_leaving_guests(&mut self, host: &mut LanHost) {
        // Every open menu closes first, in its guest's level
        // (`ServerPlayer.disconnect` -> `doCloseContainer`), so the cursor,
        // the trade and the inputs are back in the file that is saved.
    // rust: let back = self.dim;
    // rust: let open: Vec<(u32, super::Dim)> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.placed)
    // rust: .map(|g| (g.conn, super::Dim::from_id(&g.dimension)))
    // rust: .collect();
    // rust: for (conn, dim) in open {
    // rust: if self.enter_level(Some(host), dim).is_ok() {
    // rust: self.guest_close_all(host, conn);
}
}
    // rust: if let Err(e) = self.enter_level(Some(host), back) {
    // rust: log::error!("could not reopen {}: {e}", back.id());
}
    // rust: for i in 0..host.hub.guests.len() {
    // rust: let mut g = host.hub.guests.remove(i);
    // rust: self.take_parent_vehicle(host, &mut g);
    // rust: self.save_guest(host, &mut g);
    // rust: host.hub.guests.insert(i, g);
}
}
    // Save a guest when they leave or the world closes (after
    // `take_parent_vehicle`, `PlayerList.save`): an integrated server's owner
    // into the level (`/data`) and both its files (`playerdata::save_owner`),
    // anyone else into their own file.
    // rust: pub(super) fn save_guest(
    // rust: &mut self,
    // rust: host: &LanHost,
    // rust: guest: &mut horizon_client::lan::guest::Guest,
    // rust: ) {
    // rust: self.guest_attachments_into(guest);
        // A player a proxy moved to another server (`player-release moved`) is saved
        // there now, not here.
    // rust: if guest.placed && !guest.released {
    // rust: let _ = self.finish_player_autosaves(true);
    // rust: if host.owner.as_ref().is_some_and(|o| o.uuid == guest.uuid) {
    // rust: playerdata::save_owner(guest, &mut self.level, &self.world_root);
    // rust: } else {
    // rust: self.player_autosaves.save_after(guest, &self.world_root);
}
    // rust: let directory = playerdata::directory(&self.world_root);
    // rust: self.native_player_save_to_file(guest.uuid, &guest.name, &directory);
}
    // rust: self.save_guest_records(host, guest);
}
    // The vehicles the other players in level `dim` ride, all but the
    // guest `but` (`Entity.hasExactlyOnePlayerPassenger`); `host` adds the
    // host's own player, in the level in place.
    // rust: pub(super) fn ridden_by_others(
    // rust: &self,
    // rust: guests: &[horizon_client::lan::guest::Guest],
    // rust: dim: &str,
    // rust: but: Option<u128>,
    // rust: host: bool,
    // rust: ) -> Vec<u32> {
    // rust: let mut others: Vec<u32> = guests
    // rust: .iter()
    // rust: .filter(|g| g.placed && g.dimension == dim && Some(g.uuid) != but)
    // rust: .filter_map(|g| g.vehicle)
    // rust: .collect();
    // rust: if host && super::Dim::from_id(dim) == self.dim {
    // rust: others.extend(self.riding);
}
    // rust: others
}
    // `ServerPlayer.saveParentVehicle` of a player riding `vehicle` in level
    // `dim`, put in place for it if need be; with `remove`, the vehicle tree
    // leaves the world with the player (`PlayerList.remove`).
    // rust: fn parent_vehicle_in(
    // rust: &mut self,
    // rust: mut host: Option<&mut LanHost>,
    // rust: dim: &str,
    // rust: vehicle: Option<u32>,
    // rust: others: &[u32],
    // rust: remove: bool,
    // rust: ) -> Option<(horizon_world::nbt::Tag, [i32; 4])> {
    // rust: vehicle?;
    // rust: let back = self.dim;
    // rust: let theirs = super::Dim::from_id(dim);
    // rust: if theirs != back
    // rust: && let Err(e) = self.enter_level(host.as_deref_mut(), theirs)
    // rust: {
    // rust: log::error!("could not open {}: {e}", theirs.id());
    // rust: return None;
}
    // rust: let found = if self.dim == theirs {
    // rust: self.parent_vehicle_tag(vehicle, others)
    // rust: } else {
    // rust: None
}
    // rust: if remove && let Some((_, root, _)) = &found {
    // rust: self.remove_vehicle_tree(*root);
}
    // rust: if self.dim != back
    // rust: && let Err(e) = self.enter_level(host, back)
    // rust: {
    // rust: log::error!("could not reopen {}: {e}", back.id());
}
    // rust: found.map(|(tag, _, attach)| (tag, attach))
}
    // `PlayerList.remove` of a guest out of the hub: its file takes the
    // vehicle it alone rides (`saveParentVehicle`'s RootVehicle, kept in
    // `saved` as a file not yet ridden again), the vehicle tree leaves the
    // world, and the guest stops riding (`unRide`).
    // rust: pub(super) fn take_parent_vehicle(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: guest: &mut horizon_client::lan::guest::Guest,
    // rust: ) {
    // rust: let Some(vehicle) = guest.vehicle.take() else {
    // rust: return;
}
    // rust: if !guest.placed {
    // rust: return;
}
    // rust: let others = self.ridden_by_others(&host.hub.guests, &guest.dimension, None, true);
    // rust: let Some((tag, attach)) =
    // rust: self.parent_vehicle_in(Some(host), &guest.dimension, Some(vehicle), &others, true)
    // rust: else {
    // rust: return;
}
    // rust: let saved = guest
    // rust: .saved
    // rust: .get_or_insert_with(|| horizon_world::nbt::Tag::Compound(Default::default()));
    // rust: if let horizon_world::nbt::Tag::Compound(p) = saved {
    // rust: p.insert("RootVehicle".into(), tag);
}
    // rust: guest.saved_vehicle = Some(attach);
}
    // `ServerPlayer.loadAndSpawnParentVehicle`: a guest whose file names the
    // vehicle it rode rides it again, once the vehicle is in the world.
restore_guest_vehicles :: proc(self: ^Self, host: ^LanHost) {
}
    // rust: let waiting: Vec<(usize, [i32; 4])> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, g)| Some((i, g.saved_vehicle?)))
    // rust: .filter(|(i, _)| {
    // rust: let g = &host.hub.guests[*i];
    // rust: let chunk = (
    // rust: (g.position[0].floor() as i32).div_euclid(16),
    // rust: (g.position[2].floor() as i32).div_euclid(16),
    // rust: );
    // rust: g.placed
    // rust: && g.vehicle.is_none()
    // rust: && g.dimension == self.dim.id()
    // rust: && g.sent_chunks.contains(&chunk)
    // rust: })
    // rust: .collect();
    // rust: for (i, uuid) in waiting {
    // rust: let raw = host.hub.guests[i].saved.clone();
    // rust: let Some(id) = self.restore_saved_vehicle(uuid, raw.as_ref()) else {
    // rust: continue;
}
    // rust: host.hub.seat_order += 1;
    // rust: let order = host.hub.seat_order;
    // rust: let g = &mut host.hub.guests[i];
    // rust: if let Some(horizon_world::nbt::Tag::Compound(p)) = &mut g.saved {
    // rust: p.remove(&"RootVehicle".into());
}
    // rust: g.vehicle = Some(id);
    // rust: g.vehicle_order = order;
    // rust: g.saved_vehicle = None;
            // Pair the stationary restored entities before their passenger packet.
    // rust: g.moved = true;
}
}
    // The file name of a player's advancements and statistics: an
    // integrated server's owner keeps single player's.
records_uuid :: proc(self: ^Self, host: ^LanHost, uuid: u128) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if host.owner.as_ref().is_some_and(|o| o.uuid == uuid) {
    // rust: self.level.player_uuid
    // rust: } else {
    // rust: Some(playerdata::uuid_ints(uuid))
}
}
    // `PlayerAdvancements.save` and `ServerStatsCounter.save` of a network player.
    // rust: pub(super) fn save_guest_records(
    // rust: &self,
    // rust: host: &LanHost,
    // rust: guest: &horizon_client::lan::guest::Guest,
    // rust: ) {
    // rust: if !guest.placed || guest.released || self.adv.tree.list.is_empty() {
    // rust: return;
}
    // rust: let Some(uuid) = self.records_uuid(host, guest.uuid) else {
    // rust: return;
}
    // rust: let path = super::stats::player_json(&self.world_root, "advancements", uuid);
    // rust: let json = guest
    // rust: .advancements
    // rust: .to_json(&self.adv.tree, horizon_world::DATA_VERSION);
    // rust: if let Some(dir) = path.parent() {
    // rust: let _ = std::fs::create_dir_all(dir);
}
    // rust: if let Ok(text) = serde_json::to_string_pretty(&json) {
    // rust: let _ = std::fs::write(path, text);
}
    // rust: if let Some(play) = host.play.get(&guest.conn) {
    // rust: play.stats
    // rust: .write(&super::stats::player_json(&self.world_root, "stats", uuid));
}
}
    // The advancements and statistics files of a held arrival, before it is placed
    // (`player-confirm`): each through a new file, synced and renamed into place
    // (`save::write_durable`), so the reply's `ok` means both are on the disk whole.
    // rust: pub(super) fn write_arrival_records(
    // rust: &self,
    // rust: host: &LanHost,
    // rust: guest: &horizon_client::lan::guest::Guest,
    // rust: ) -> std::result::Result<(), String> {
    // rust: if self.adv.tree.list.is_empty() {
    // rust: return Ok(());
}
    // rust: let Some(uuid) = self.records_uuid(host, guest.uuid) else {
    // rust: return Ok(());
}
    // rust: let write = |dir: &str, json: &serde_json::Value| {
    // rust: let path = super::stats::player_json(&self.world_root, dir, uuid);
    // rust: let text = serde_json::to_string_pretty(json).map_err(|e| e.to_string())?;
    // rust: horizon_client::save::write_durable(&path, text.as_bytes())
    // rust: .map_err(|e| format!("{} is not saved: {e}", path.display()))
}
    // rust: write(
    // rust: "advancements",
    // rust: &guest
    // rust: .advancements
    // rust: .to_json(&self.adv.tree, horizon_world::DATA_VERSION),
    // rust: )?;
    // rust: if let Some(play) = host.play.get(&guest.conn) {
    // rust: write("stats", &play.stats.to_json())?;
}
    // rust: Ok(())
}
    // `PlayerAdvancements.load` and `ServerStatsCounter.parseLocal` of a
    // network player who joined; every statistic goes out on the first
    // request (`PlayerList.placeNewPlayer`'s `markAllDirty`).
load_guest_records :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: let Some(uuid) = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .and_then(|g| self.records_uuid(host, g.uuid))
    // rust: else {
    // rust: return;
}
    // rust: let tree = self.advancement_tree();
    // rust: let path = super::stats::player_json(&self.world_root, "advancements", uuid);
    // rust: let saved = std::fs::read_to_string(path)
    // rust: .ok()
    // rust: .and_then(|t| serde_json::from_str::<serde_json::Value>(&t).ok());
    // rust: if let Some(g) = host.hub.guest_mut(conn)
    // rust: && let Some(json) = saved
    // rust: {
    // rust: let mut progress = horizon_client::advancements::Progress::from_json(&json);
            // PlayerAdvancements.applyFrom: advancements this server lacks are dropped.
    // rust: progress
    // rust: .criteria
    // rust: .retain(|id, _| tree.by_id.contains_key(id));
    // rust: g.advancements = progress;
    // rust: g.advancements_loaded = true;
}
    // rust: let mut stats =
    // rust: super::stats::Stats::read(&super::stats::player_json(&self.world_root, "stats", uuid));
    // rust: stats.mark_all_dirty();
    // rust: host.play.entry(conn).or_default().stats = stats;
}
    // The integrated server's owner into the world's player, for `Level::write`.
    // Returns the owner's uuid and name when they were stored.
    // rust: pub(super) fn store_owner(&mut self) -> Option<(u128, String)> {
    // rust: let uuid = self.lan.as_ref().and_then(|h| h.owner.as_ref())?.uuid;
    // rust: let (riding, dim, others) = self.lan.as_ref().and_then(|h| {
    // rust: let g = h.hub.guests.iter().find(|g| g.uuid == uuid && g.placed)?;
    // rust: let others = self.ridden_by_others(&h.hub.guests, &g.dimension, Some(uuid), true);
    // rust: Some((g.vehicle, g.dimension.clone(), others))
    // rust: })?;
        // The vehicle the owner rides (`ServerPlayer.saveParentVehicle`).
    // rust: let vehicle = self
    // rust: .parent_vehicle_in(None, &dim, riding, &others, false)
    // rust: .map(|(tag, _)| tag);
    // rust: let host = self.lan.as_ref()?;
    // rust: let mut stored = None;
    // rust: if let Some(g) = host.hub.guests.iter().find(|g| g.uuid == uuid && g.placed) {
    // rust: playerdata::store(g, &mut self.level, vehicle);
    // rust: self.save_guest_records(host, g);
    // rust: stored = Some(g.name.clone());
    // rust: } else if let Some(saved) = host.owner.as_ref().and_then(|o| o.saved.as_ref()) {
    // rust: self.level.position = saved.position;
}
    // rust: stored.map(|name| (uuid, name))
}

    // The world's default game mode (`defaultgamemode`).
    // rust: pub(super) fn set_default_game_mode(&mut self, mode: i32) {
    // rust: self.level.game_mode = mode;
    // rust: self.level.creative = mode == 1;
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.hub.config.default_game_mode = mode;
            // `setWorldGameType` and `DefaultGameModeCommands.setMode`: a
            // world that forces its mode puts the guests online in it.
    // rust: enforce_guest_game_mode(host, &self.world, self.collision);
}
}

    // Apply the default mode to connected players when forcing it is enabled.
    // rust: pub(super) fn set_force_game_mode(&mut self, force: bool) {
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.settings.force_game_mode = force;
    // rust: host.hub.config.force_game_mode = force;
    // rust: enforce_guest_game_mode(host, &self.world, self.collision);
}
}

    // Update the live view distance used for player chunk tracking.
    // rust: pub(super) fn set_view_distance(&mut self, distance: i32) {
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.hub.set_view_distance(distance);
}
}

    // Update the live spawn-protection radius.
    // rust: pub(super) fn set_spawn_protection(&mut self, radius: i32) {
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.hub.spawn_protection = radius;
}
}

    // Update the live simulation distance sent to player clients.
    // rust: pub(super) fn set_simulation_distance(&mut self, distance: i32) {
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.hub.set_simulation_distance(distance);
}
}

    // Update the live entity tracking range percentage.
    // rust: pub(super) fn set_entity_broadcast_range_percentage(&mut self, percentage: i32) {
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.hub.entity_range_percent = percentage;
}
}

    // Update the live movement check's flight policy.
    // rust: pub(super) fn set_allow_flight(&mut self, allow: bool) {
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.hub.config.allow_flight = allow;
}
}

    // Update whether status responses include online player names.
    // rust: pub(super) fn set_hide_online_players(&mut self, hide: bool) {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub.lan.shared.set_hide_online_players(hide);
}
}

    // Update whether the server answers connection status requests.
    // rust: pub(super) fn set_status_replies(&mut self, enable: bool) {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub.lan.shared.set_enable_status(enable);
}
}

    // New command access and game mode forcing settings of the open world.
    // rust: pub(super) fn lan_apply_settings(&mut self, guest_commands: bool, force: bool) {
    // rust: if let Some(server) = &self.integrated {
    // rust: server.call(move |g| g.lan_apply_settings(guest_commands, force));
    // rust: return;
}
        // An integrated server gives guests commands only where the world
        // allows them (IntegratedServer.getCustomPermissionLevel).
    // rust: let effective = guest_commands && (!self.serving() || self.allow_commands());
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.settings.guest_commands = guest_commands;
    // rust: host.hub.config.guest_commands = effective;
}
    // rust: self.set_force_game_mode(force);
    // rust: self.resend_commands_filtered();
}

    // rust: pub(super) fn lan_port(&self) -> Option<u16> {
    // rust: if let Some(server) = &self.integrated {
    // rust: return server.published();
}
    // rust: if self.serving() {
    // rust: return self.published_port();
}
    // rust: self.lan.as_ref().map(|h| h.settings.port)
}

    // The entities guests track: mobs, items and the rest (game/lan_entities.rs).
    // `mob_players` is the guest each mob sees as its player (game/lan_mobs.rs).
    // Only the entities whose id is above `after` (0: all of them). With
    // `kept`, idle mobs and items no client can pair with are described bare
    // (game/lan_idle.rs).
    // rust: fn lan_entities(
    // rust: &mut self,
    // rust: mob_players: &horizon_client::fast_hash::FxHashMap<u32, u32>,
    // rust: hub: &mut Hub,
    // rust: out: &mut States,
    // rust: drain_minecart_steps: bool,
    // rust: after: u32,
    // rust: mut kept: Option<&mut super::lan_idle::IdlePass<'_>>,
    // rust: ) {
    // rust: out.clear();
    // rust: let mut speeds = super::lan_attributes::SpeedByType::default();
        // ChunkMap.tick sends the changes of an entity outside the
        // entity-ticking range only when it changed section or needs sync.
    // rust: let levels = self.tickets.levels();
    // rust: let idle_at = |p: horizon_core::geometry::Vec3| {
    // rust: !levels.in_entity_ticking_range((p.x.floor() as i32) >> 4, (p.z.floor() as i32) >> 4)
}
    // rust: for m in self.mobs.iter().filter(|m| !m.removed && m.id > after) {
            // The lead's holder: the player the mob sees, another mob or a
            // fence knot (game/lan_entities.rs).
    // rust: let player_entity = || {
    // rust: (mob_players.get(&m.id))
    // rust: .and_then(|conn| hub.guest(*conn))
    // rust: .map(|g| g.entity_id)
}
    // rust: let leash = m.extra.leash.and_then(|h| match h {
    // rust: Holder::Player => match m.extra.leash_player {
    // rust: Some(u) => hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| playerdata::uuid_ints(g.uuid) == u)
    // rust: .map(|g| g.entity_id),
    // rust: None => player_entity(),
    // rust: },
    // rust: Holder::Mob(id) | Holder::Boat(id) => Some(id as i32),
    // rust: Holder::Knot(p) => self.knot_ids.get(&p).map(|&id| id as i32),
    // rust: });
    // rust: let idle = idle_at(m.position);
    // rust: let place = super::lan_idle::Place {
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: rotation: (m.yaw, m.head_pitch, m.head_yaw),
    // rust: on_ground: m.on_ground,
    // rust: velocity: [m.velocity.x, m.velocity.y, m.velocity.z],
}
    // rust: let kind = m.kind.id.as_str();
    // rust: let bare = idle
    // rust: && (kept.as_deref_mut()).is_some_and(|k| k.bare(hub, m.id as i32, kind, &place))
    // rust: && !m.needs_sync;
    // rust: let e = out.add(m.id as i32, entity_uuid(m.id), kind);
    // rust: e.position = place.position;
    // rust: (e.yaw, e.pitch, e.head_yaw) = place.rotation;
    // rust: e.on_ground = place.on_ground;
    // rust: e.velocity = place.velocity;
    // rust: e.needs_sync = m.needs_sync;
    // rust: (e.idle, e.bare) = (idle, bare);
    // rust: e.leash = leash;
    // rust: if bare {
    // rust: continue;
}
    // rust: mob_meta(
    // rust: m,
    // rust: hub,
    // rust: player_entity(),
    // rust: self.world.game_time,
    // rust: &mut e.meta,
    // rust: &mut e.defaults,
    // rust: );
            // HappyGhast.aiStep: requiresPrecisePosition while on a still timeout.
    // rust: e.precise = m.species() == horizon_client::mobs::Species::HappyGhast
    // rust: && horizon_client::mobs::happy_ghast::on_still_timeout(m);
    // rust: mob_freeze_meta(m, &mut e.meta, &mut e.defaults);
    // rust: mob_equipment(m, hub, &mut e.equipment);
    // rust: self.mob_attributes(m, &mut speeds, &mut e.attributes);
}
    // rust: for d in self.dropped.iter().filter(|d| d.id > after) {
    // rust: let idle = idle_at(d.position);
    // rust: let place = super::lan_idle::Place {
    // rust: position: [d.position.x, d.position.y, d.position.z],
    // rust: rotation: (0.0, 0.0, 0.0),
    // rust: on_ground: d.on_ground,
    // rust: velocity: [d.velocity.x, d.velocity.y, d.velocity.z],
}
    // rust: let bare = idle
    // rust: && (kept.as_deref_mut())
    // rust: .is_some_and(|k| k.bare(hub, d.id as i32, "minecraft:item", &place))
    // rust: && !d.needs_sync;
    // rust: let e = out.add(d.id as i32, entity_uuid(d.id), "minecraft:item");
    // rust: e.position = place.position;
    // rust: e.on_ground = place.on_ground;
    // rust: e.velocity = place.velocity;
    // rust: (e.idle, e.bare) = (idle, bare);
    // rust: if bare {
    // rust: continue;
}
    // rust: let stack = hub.stack(&Some(d.stack.clone()));
            // `ServerEntity.getRequiresPrecisePosition` is false for an item:
            // `needs_sync` asks for its data again, not for an exact position.
            // The collision case is `full_precision_required` in the tracker.
    // rust: e.precise = false;
    // rust: e.needs_sync = d.needs_sync;
    // rust: e.vertical_collision = d.vertical_collision;
    // rust: e.horizontal_collision = d.horizontal_collision;
            // Entity.DATA_SHARED_FLAGS_ID: glowing 0x40 (the Glowing tag).
    // rust: if self.entity_glowing(d.id) {
    // rust: e.meta.push((0, serializer::BYTE, Value::Byte(0x40)));
}
    // rust: e.meta.push((8, serializer::ITEM_STACK, Value::Item(stack)));
}
    // rust: for o in self.orbs.iter().filter(|o| o.id > after) {
    // rust: let e = out.add(o.id as i32, entity_uuid(o.id), "minecraft:experience_orb");
    // rust: e.position = [o.position.x, o.position.y, o.position.z];
    // rust: e.idle = idle_at(o.position);
    // rust: e.on_ground = o.on_ground;
    // rust: e.velocity = [o.velocity.x, o.velocity.y, o.velocity.z];
            // ExperienceOrb.DATA_VALUE.
    // rust: e.meta
    // rust: .push((8, serializer::INT, Value::Int(o.value as i32)));
}
    // rust: self.lan_object_states(hub, out, drain_minecart_steps, after);
}

    // Apply gameplay events produced while the hub handles guest packets.
    //
    // Both the pre-block packet phase and the normal LAN tick receive the
    // same event stream. Keep their side effects in one place so joins,
    // departures, chat, and queued guest commands cannot drift apart. None when a native hook's
    // command closed the hub.
    // rust: fn lan_process_events(
    // rust: &mut self,
    // rust: mut host: LanHost,
    // rust: events: impl IntoIterator<Item = HostEvent>,
    // rust: entities: &[EntityState],
    // rust: spawn: [f64; 3],
    // rust: ) -> Option<LanHost> {
        // A slow tick's line says which event took it, and whose (`spans::note`): each event's
        // time is noted when the next one starts (an event's arm may `continue`), the last's
        // after the loop.
    // rust: let timed = horizon_client::spans::recording_here();
    // rust: let mut previous = None;
    // rust: for event in events {
    // rust: if timed {
    // rust: note_event(&host, previous.take());
    // rust: let detail = self.event_detail(&host, &event);
    // rust: previous = Some((Instant::now(), event_kind(&event), detail));
}
    // rust: match event {
    // rust: event @ (HostEvent::Chat { .. } | HostEvent::Warn(_) | HostEvent::Error(_)) => {
    // rust: self.lan_log_event(event);
}
    // rust: HostEvent::Ban { uuid, name, reason } => {
    // rust: self.anticheat_ban(&mut host.hub, uuid, &name, &reason);
}
    // rust: HostEvent::ChatFiltered {
    // rust: sender,
    // rust: name,
    // rust: place,
    // rust: text,
    // rust: count,
    // rust: action,
    // rust: } => self.chat_filtered(&mut host, sender, &name, place, &text, count, action),
    // rust: HostEvent::PlayerChat { sender, text } => {
    // rust: if let Some(g) = host.hub.guests.iter().find(|g| g.uuid == sender) {
    // rust: if self.options.dedicated.is_some() {
    // rust: super::dedicated::events::record(
    // rust: "chat",
    // rust: &g.name,
    // rust: sender,
    // rust: serde_json::json!({ "message": text }),
    // rust: );
}
    // rust: let conn = g.conn;
    // rust: self.detect_rate_spam(&mut host, conn, false);
}
}
    // rust: HostEvent::Joined(conn) => {
                    // The mods may refuse the login before the player is placed.
    // rust: if let Some((uuid, name)) =
    // rust: host.hub.guest(conn).map(|g| (g.uuid, g.name.clone()))
    // rust: {
    // rust: let mut cancel = false;
    // rust: let mut reason = None;
    // rust: self.native_player_login(uuid, &name, &mut cancel, &mut reason);
    // rust: if cancel {
    // rust: let reason = match reason {
    // rust: Some(text) => {
    // rust: horizon_client::lan::data::component_nbt(&text.component())
}
    // rust: None => horizon_protocol::text::translatable(
    // rust: "multiplayer.disconnect.generic",
    // rust: &[],
    // rust: ),
}
    // rust: host.hub.kick(conn, reason);
    // rust: continue;
}
}
    // rust: self.lan_guest_joined(&mut host, conn, entities, spawn);
    // rust: if self.options.dedicated.is_some()
    // rust: && let Some(g) = host.hub.guest(conn)
    // rust: {
                        // PlayerList.placeNewPlayer, then the broadcast join message.
    // rust: super::dedicated::player_joined(g.uuid, &g.name);
    // rust: super::dedicated::events::record(
    // rust: "join",
    // rust: &g.name,
    // rust: g.uuid,
    // rust: serde_json::json!({ "address": g.address.ip().to_string() }),
    // rust: );
    // rust: let [x, y, z] = g.position;
    // rust: super::dedicated::log(
    // rust: "INFO",
    // rust: &format!(
    // rust: "{}[/{}] logged in with entity id {} at ({}, {}, {})",
    // rust: g.name,
    // rust: g.address,
    // rust: g.entity_id,
    // rust: super::dedicated::java_double(x),
    // rust: super::dedicated::java_double(y),
    // rust: super::dedicated::java_double(z)
    // rust: ),
    // rust: );
                        // A held player is not announced: it is not in the world yet.
    // rust: if g.held {
    // rust: super::dedicated::log(
    // rust: "INFO",
    // rust: &horizon_client::lan::arrivals::held_line(&g.name),
    // rust: );
    // rust: } else {
    // rust: super::dedicated::log(
    // rust: "INFO",
    // rust: &format!("System chat: {} joined the game", g.name),
    // rust: );
}
    // rust: } else if self.player.is_some()
    // rust: && let Some(g) = host.hub.guest(conn)
    // rust: && g.placed
    // rust: {
                        // The host's chat hears of the newcomer as the guests do.
    // rust: let who = self.player_text(&g.name, g.uuid);
    // rust: self.system_message(
    // rust: Text::translate("multiplayer.player.joined", &[who])
    // rust: .with_color(horizon_client::text::YELLOW),
    // rust: );
}
    // rust: if let Some((uuid, name)) = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .filter(|g| g.placed)
    // rust: .map(|g| (g.uuid, g.name.clone()))
    // rust: {
    // rust: self.lan = Some(host);
    // rust: self.native_player_logged_in(uuid, &name);
                        // A hook's command can close the hub.
    // rust: host = self.lan.take()?;
}
}
    // rust: HostEvent::Left(mut guest) => {
                    // The menu they had open closes, in the level they were in
                    // (`ServerPlayer.disconnect` -> `doCloseContainer`).
    // rust: if guest.placed {
    // rust: let back = self.dim;
    // rust: let theirs = super::Dim::from_id(&guest.dimension);
    // rust: if self.enter_level(Some(&mut host), theirs).is_ok() {
    // rust: let conn = guest.conn;
    // rust: let at = host.hub.guests.len();
    // rust: host.hub.guests.push(*guest);
    // rust: self.guest_disconnected(&mut host, conn);
    // rust: *guest = host.hub.guests.remove(at);
}
    // rust: if let Err(e) = self.enter_level(Some(&mut host), back) {
    // rust: log::error!("could not reopen {}: {e}", back.id());
}
}
    // rust: self.lan_crafting_left(&mut host, &mut guest);
    // rust: if guest.placed {
    // rust: self.award_leave_game(&mut host, guest.conn, guest.uuid, &guest.name);
}
                    // PlayerList.remove: the vehicle it alone rides goes too.
    // rust: self.take_parent_vehicle(&mut host, &mut guest);
    // rust: self.save_guest(&host, &mut guest);
    // rust: self.guest_attachments.remove(&guest.uuid);
    // rust: host.play.remove(&guest.conn);
    // rust: self.guest_combat.remove(&guest.conn);
                    // A held player was recorded as joined at its login: it leaves too.
    // rust: if self.options.dedicated.is_some() && (guest.placed || guest.held) {
    // rust: super::dedicated::events::record(
    // rust: "leave",
    // rust: &guest.name,
    // rust: guest.uuid,
    // rust: serde_json::json!({ "reason": guest.left_reason }),
    // rust: );
    // rust: if guest.held && !guest.placed {
                            // Never announced, so no "left the game" either.
    // rust: super::dedicated::log(
    // rust: "INFO",
    // rust: &horizon_client::lan::arrivals::dropped_line(
    // rust: &guest.name,
    // rust: &guest.left_reason,
    // rust: ),
    // rust: );
    // rust: } else {
    // rust: super::dedicated::log(
    // rust: "INFO",
    // rust: &format!("{} lost connection: {}", guest.name, guest.left_reason),
    // rust: );
}
                        // A player moved to another server without `announce` was not
                        // announced as leaving, so the line is not logged either; a held
                        // player was never announced at all.
    // rust: if guest.placed && !guest.quiet_leave {
    // rust: super::dedicated::log(
    // rust: "INFO",
    // rust: &format!("System chat: {} left the game", guest.name),
    // rust: );
}
    // rust: } else if self.player.is_some() && guest.placed && !guest.quiet_leave {
                        // ServerGamePacketListenerImpl.removePlayerFromWorld.
    // rust: let who = self.player_text(&guest.name, guest.uuid);
    // rust: self.system_message(
    // rust: Text::translate("multiplayer.player.left", &[who])
    // rust: .with_color(horizon_client::text::YELLOW),
    // rust: );
}
    // rust: if guest.placed && !host.players_told_left {
    // rust: self.lan = Some(host);
    // rust: self.native_player_logged_out(guest.uuid, &guest.name);
    // rust: host = self.lan.take()?;
}
}
    // rust: HostEvent::Flight { conn, flying } => {
    // rust: self.lan_flight_toggled(&mut host, conn, flying);
}
    // rust: HostEvent::Sneak { conn, sneaking } => {
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: continue;
}
    // rust: if let Some(g) = host.hub.guest(conn) {
    // rust: let (uuid, name) = (g.uuid, g.name.clone());
    // rust: self.as_guest(&mut host, conn, |game| {
    // rust: game.native_player_toggle_sneak(uuid, &name, sneaking);
    // rust: });
}
}
    // rust: HostEvent::Kicked {
    // rust: conn,
    // rust: player,
    // rust: name,
    // rust: reason,
    // rust: } => {
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: continue;
}
                    // The same poll can have removed the guest (their `Left`): the mods hear the
                    // kick anyway, without the guest's state swapped in.
    // rust: if host.hub.guest(conn).is_some() {
    // rust: self.as_guest(&mut host, conn, |game| {
    // rust: game.native_player_kicked(player, &name, &reason);
    // rust: });
    // rust: } else {
    // rust: self.native_player_kicked(player, &name, &reason);
}
}
    // rust: HostEvent::Input { conn, flags } => {
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: continue;
}
    // rust: if let Some(g) = host.hub.guest(conn) {
    // rust: let (uuid, name) = (g.uuid, g.name.clone());
    // rust: self.as_guest(&mut host, conn, |game| {
    // rust: game.native_player_input(uuid, &name, flags);
    // rust: });
}
}
    // rust: HostEvent::MainHandChanged(conn, left) => {
    // rust: if let Some(g) = host.hub.guest(conn) {
    // rust: let (uuid, name) = (g.uuid, g.name.clone());
    // rust: self.native_player_change_main_hand(uuid, &name, left);
}
}
    // rust: HostEvent::LocaleChanged(conn, locale) => {
    // rust: if let Some(g) = host.hub.guest(conn) {
    // rust: let (uuid, name) = (g.uuid, g.name.clone());
    // rust: self.native_player_locale_change(uuid, &name, &locale);
}
}
    // rust: HostEvent::PlayerLoaded(conn) => {
    // rust: if let Some(g) = host.hub.guest(conn) {
    // rust: let (uuid, name) = (g.uuid, g.name.clone());
    // rust: self.native_player_client_loaded_world(uuid, &name);
}
}
    // rust: HostEvent::RecipeBookSettings {
    // rust: conn,
    // rust: book,
    // rust: open,
    // rust: filtering,
    // rust: } => {
    // rust: if let Some(g) = host.hub.guest(conn) {
    // rust: let (uuid, name) = (g.uuid, g.name.clone());
    // rust: self.native_player_recipe_book_settings_change(
    // rust: uuid, &name, book, open, filtering,
    // rust: );
}
}
    // rust: HostEvent::Packet(conn, packet) => {
    // rust: self.lan_guest_packet(&mut host, conn, *packet);
    // rust: if !host.commands.is_empty() {
    // rust: self.lan = Some(host);
    // rust: self.run_guest_commands();
    // rust: host = self.lan.take().expect("the hub is back after the commands");
}
}
}
}
    // rust: note_event(&host, previous);
    // rust: Some(host)
}

    // Handle this level's player packets before scheduled block ticks
    // (`ServerGamePacketListenerImpl` ahead of `ServerLevel`'s block phase).
    // A sand place in the same tick as another sand's fall schedule still
    // sees the support (#4510). `tick_lan` then syncs the level; a paused
    // tick that never calls this still drains inside `tick_lan`.
    // rust: pub(super) fn tick_lan_packets(&mut self) {
    // rust: if self.level_pass.packets_drained {
    // rust: return;
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: let holding = lan::Holding::start();
        // Last tick's tracked entities: enough for place collision and joins
        // before this tick moves anyone.
    // rust: let entities = std::mem::take(&mut host.states);
    // rust: let spawn = self.spawn.map_or([0.5, 80.0, 0.5], |s| [s.x, s.y, s.z]);
    // rust: let events = {
    // rust: let clock_rate = self.network_clock_rate();
    // rust: let mut ctx = TickCtx {
    // rust: world: &mut self.world,
    // rust: entities: entities.as_slice(),
    // rust: next_entity: &mut self.next_entity,
    // rust: spawn,
    // rust: difficulty: i32::from(self.ui.difficulty),
    // rust: difficulty_locked: self.level.difficulty_locked,
    // rust: clock_rate,
    // rust: tick_rate: self.clock.rate(),
    // rust: tick_frozen: self.clock.frozen(),
    // rust: tick_steps: self.clock.step_state(),
    // rust: collision: Some(self.collision),
    // rust: border: &self.border,
    // rust: streaming: Some(&self.streaming),
}
    // rust: host.hub.movement_checks = (
    // rust: self.ui.rules.bool("player_movement_check"),
    // rust: self.ui.rules.bool("elytra_movement_check"),
    // rust: );
    // rust: host.hub.mods_loaded = !horizon_client::mod_api::mods().is_empty();
    // rust: let pass = self.level_pass;
    // rust: let mut events = if pass.first {
    // rust: horizon_client::spans::time("lan_poll", || host.hub.poll(&mut ctx))
    // rust: } else {
    // rust: Vec::new()
}
    // rust: events.extend(horizon_client::spans::time("lan_drain", || {
    // rust: host.hub.drain_packets(&mut ctx)
    // rust: }));
    // rust: events
}
    // rust: let Some(back) = horizon_client::spans::time("lan_events", || {
    // rust: self.lan_process_events(host, events, entities.as_slice(), spawn)
    // rust: }) else {
    // rust: return;
}
    // rust: host = back;
    // rust: if !host.quiet.is_empty() {
    // rust: self.lan = Some(host);
    // rust: horizon_client::spans::time("lan_quiet_commands", || self.run_quiet_commands());
    // rust: host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after the quiet commands");
}
    // rust: if !host.hub.native_advancement_grants.is_empty() {
    // rust: self.lan = Some(host);
    // rust: horizon_client::spans::time("lan_advancement_grants", || {
    // rust: self.run_native_advancement_grants()
    // rust: });
    // rust: host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after the advancement grants");
}
    // rust: if !host.hub.native_menu_events.is_empty() {
    // rust: self.lan = Some(host);
    // rust: horizon_client::spans::time("lan_menu_events", || self.run_native_menu_events());
    // rust: host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after the menu events");
}
    // rust: host.states = entities;
    // rust: self.level_pass.packets_drained = true;
    // rust: drop(holding);
    // rust: self.lan = Some(host);
}

    // The entity id counter, once the entities Horizon keeps without one
    // have theirs, while guests track the level (None otherwise).
lan_ids_so_far :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.lan.as_ref().is_none_or(|h| h.hub.guests.is_empty()) {
    // rust: return None;
}
    // rust: self.lan_assign_ids();
    // rust: Some(self.next_entity as i32)
}

    // ServerLevel.tick's ChunkMap.tick point, after the block ticks and
    // before the entities': what joined the level up to here (a falling
    // block, a dispensed arrow, the last tick's late joins) is paired and
    // first updated in this tick's pass (`Entities::synced`).
    // `ServerChunkCache.tick`'s broadcast, where ServerLevel.tick runs it:
    // after the scheduled and random ticks, before the block events, so the
    // players get the blocks as they are then. The block log's length after
    // it: what the tick writes from there on goes out with the next tick's.
    // rust: pub(super) fn lan_broadcast_changes(&mut self) -> Option<usize> {
    // rust: if let Some(host) = self.lan.as_mut() {
    // rust: host.hub.broadcast_changes(&mut self.world);
}
    // rust: self.world.block_log.as_ref().map(Vec::len)
}

    // rust: pub(super) fn lan_mark_synced(&mut self) {
    // rust: if let Some(next) = self.lan_ids_so_far()
    // rust: && let Some(host) = self.lan.as_mut()
    // rust: {
    // rust: host.hub.synced = vec![(i32::MIN, next)];
}
}

    // The start of a phase vanilla runs before ChunkMap.tick and Horizon
    // among the entities' ticks (ServerChunkCache.tickChunks' spawning and
    // thunder, the raids): the counter to give `lan_synced_since`.
    // rust: pub(super) fn lan_synced_from(&mut self) -> Option<i32> {
    // rust: self.lan_ids_so_far()
}

    // The end of such a phase: what joined during it is first updated in
    // this tick's pass too.
    // rust: pub(super) fn lan_synced_since(&mut self, from: Option<i32>) {
    // rust: if let Some(from) = from
    // rust: && let Some(next) = self.lan_ids_so_far()
    // rust: && next > from
    // rust: && let Some(host) = self.lan.as_mut()
    // rust: {
    // rust: host.hub.synced.push((from, next));
}
}

    // The end of the level's tick: the entities added since its states were
    // taken for the guests (a falling block's drop, a spawner's mob, the
    // host's snowball) are paired without another tracking tick
    // (`Hub::note_joined`). Only they are
    // described (their ids are above the counter the states were taken at),
    // and nothing when the counter has not moved or no guest is in the level.
    // rust: pub(super) fn lan_note_joined(&mut self) {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: host = self.lan_flush_tracking(host);
    // rust: host.states_next_entity = None;
    // rust: self.flush_attachment_sync(&mut host);
    // rust: self.lan = Some(host);
}

    // Deliver start/stop callbacks before sounds and attachment snapshots.
    // A callback can spawn another entity, whose pairing is part of the same
    // operation, as a nested ChunkMap.addEntity would be in vanilla.
lan_flush_tracking :: proc(self: ^Self, mut host: LanHost) -> L {
    // Ported from Horizon
    return {}
}
    // rust: loop {
    // rust: self.lan_pair_joined(&mut host);
    // rust: host.hub.collect_tracking();
    // rust: if host.hub.native_tracking.is_empty() {
    // rust: return host;
}
    // rust: self.lan = Some(host);
    // rust: self.run_native_tracking();
    // rust: host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after the tracking events");
}
}

    // Pair late arrivals before a sound flush as well as at the end of the
    // tick. The counter prevents taking or draining an entity's state twice.
    // rust: pub(super) fn lan_pair_joined(&mut self, host: &mut LanHost) {
    // rust: if let Some(next) = host.states_next_entity
    // rust: && host.hub.guests.iter().any(|g| host.hub.here(g))
    // rust: {
    // rust: self.lan_assign_ids();
    // rust: if self.next_entity != next {
    // rust: let mut states = States::default();
    // rust: self.lan_entities(
    // rust: &host.mob_players,
    // rust: &mut host.hub,
    // rust: &mut states,
    // rust: false,
    // rust: next,
    // rust: None,
    // rust: );
    // rust: self.lan_hook_states(&host.play, &host.hub, &mut states);
    // rust: self.lan_entity_uuids(&mut states);
    // rust: host.hub.note_joined(states.as_slice());
}
    // rust: host.states_next_entity = Some(self.next_entity);
}
}

    // Run the hub for this tick and apply what the guests did. While the
    // single player game is `paused` only the connections run
    // (`IntegratedServer.tickPaused`): `ServerGamePacketListenerImpl.tick`
    // skips `tickPlayer`, so no player's air, hunger or damage moves on.
    // rust: pub(super) fn tick_lan(&mut self, paused: bool) {
        // A frozen level does not reach tick_lan_packets through tick_world.
        // Apply its packets before taking the snapshot too.
    // rust: if !paused {
    // rust: self.tick_lan_packets();
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: if self.level_pass.running.is_none() {
    // rust: self.level_pass.packets_drained = false;
}
    // rust: return;
}
        // What the tick sends a guest goes to its connection at the end.
    // rust: let holding = lan::Holding::start();
    // rust: self.register_native_commands(&mut host);
        // The host's own commands' (and command blocks') players moving
        // to another level, and their broadcastToAdmins lines.
    // rust: if !self.level_teleports.is_empty() {
    // rust: self.run_level_teleports(&mut host);
}
    // rust: if !self.admin_feedback.is_empty() {
    // rust: self.send_admin_feedback(&mut host, None);
}
        // An animal whose rider left the game (or the level) stops taking
        // its input.
    // rust: for m in &mut self.mobs {
    // rust: if m.rider.is_some()
    // rust: && self.riding != Some(m.id)
    // rust: && !host.hub.guests.iter().any(|g| g.vehicle == Some(m.id))
    // rust: {
    // rust: m.rider = None;
}
}
        // A guest whose file names the vehicle it rode rides it again.
    // rust: self.restore_guest_vehicles(&mut host);
        // Finish the players' mining, item use and pickups before describing
        // this tick to their clients. Otherwise a newly broken block and its
        // drops remain absent from the snapshot until the following tick.
    // rust: if !paused {
    // rust: horizon_client::spans::time("lan_guests", || self.tick_guests(&mut host));
            // The vehicles the guests just moved enter their portals now.
    // rust: let ridden: Vec<u32> = host.hub.guests.iter().filter_map(|g| g.vehicle).collect();
    // rust: self.find_ridden_vehicle_portals(&ridden);
}
        // A guest's mount fired its `started_riding` with that guest alone in
        // place (the hub held by its action): now every player on the vehicle
        // hears it (`Entity.startRiding`).
    // rust: if !self.started_riding.is_empty() {
    // rust: self.lan = Some(host);
    // rust: self.flush_started_riding();
    // rust: host = self.lan.take().expect("the hub is back after the triggers");
}
    // rust: {
    // rust: let has_guests = !host.hub.guests.is_empty();
    // rust: let mut states = std::mem::take(&mut host.states);
    // rust: if has_guests {
    // rust: self.lan_assign_ids();
    // rust: let guests: Vec<(u32, i32)> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter_map(|g| Some((g.vehicle?, g.entity_id)))
    // rust: .collect();
    // rust: self.lan_riding(&guests, &mut host.hub.riding);
                // Idle states are kept only when the players' moves are in:
                // the clients that could pair are known. The range scale is
                // the one the tracker gets below.
    // rust: let mut kept = if self.level_pass.packets_drained {
    // rust: let percent = if host.hub.config.integrated {
    // rust: (self.settings.entity_distance * 100.0).round() as i32
    // rust: } else {
    // rust: host.hub.entity_range_percent
}
    // rust: host.idle_states.pass(&host.hub, percent)
    // rust: } else {
    // rust: None
}
    // rust: horizon_client::spans::time("lan_entity_states", || {
    // rust: self.lan_entities(
    // rust: &host.mob_players,
    // rust: &mut host.hub,
    // rust: &mut states,
    // rust: true,
    // rust: 0,
    // rust: kept.as_mut(),
    // rust: );
    // rust: if let Some(kept) = kept {
    // rust: kept.finish();
}
    // rust: self.lan_hook_states(&host.play, &host.hub, &mut states);
    // rust: self.lan_entity_uuids(&mut states);
    // rust: });
    // rust: host.states_next_entity = Some(self.next_entity);
    // rust: } else {
    // rust: host.states_next_entity = None;
    // rust: states.clear();
                // Nobody can receive past movement. A returning viewer pairs
                // from the cart's current position/rotation, as AddEntity does.
    // rust: for cart in &mut self.carts {
    // rust: cart.lerp_steps.clear();
}
}
            // ServerEntity.sendChanges clears needsSync once it has looked.
    // rust: for m in &mut self.mobs {
    // rust: m.needs_sync = false;
}
    // rust: for p in &mut self.creatures.projectiles {
    // rust: p.needs_sync = false;
}
    // rust: for d in &mut self.dropped {
    // rust: d.needs_sync = false;
}
            // The step command reaches clients before the events its tick
            // generated, as ServerTickRateManager.updateStepTicks does.
    // rust: host.hub.sync_ticking(
    // rust: self.clock.rate(),
    // rust: self.clock.frozen(),
    // rust: self.clock.step_state(),
    // rust: );
            // `runBlockEvents`' broadcast precedes what the events change (held
            // for the next tick, `tick_world`), and follows the blocks changed
            // before them (`lan_broadcast_changes`): the guest re-runs a
            // piston's `triggerEvent` on the blocks as they were before the
            // move, a base the last tick restored included.
    // rust: for (pos, b0, b1, state) in std::mem::take(&mut self.lan_block_events) {
    // rust: host.hub.block_event(pos, b0, b1, state);
}
    // rust: let entities = states.as_slice();
    // rust: self.lan_prepare_captured_sounds(&mut host, entities);
            // An entity that left the level since the last tick (a snowball
            // that hit) is dropped by the tracker below: its event goes out
            // first, as `Level.broadcastEntityEvent` precedes the discard.
    // rust: let (gone, later): (Vec<_>, Vec<_>) = std::mem::take(&mut self.lan_entity_events)
    // rust: .into_iter()
    // rust: .partition(|(id, ..)| !entities.iter().any(|e| e.id == *id));
    // rust: self.lan_entity_events = later;
    // rust: for (id, event, at) in gone {
    // rust: host.hub.entity_event(id, event, at);
}
    // rust: host.hub.far_level(&self.save);
    // rust: let spawn = self.spawn.map_or([0.5, 80.0, 0.5], |s| [s.x, s.y, s.z]);
    // rust: let events = {
    // rust: let clock_rate = self.network_clock_rate();
    // rust: let mut ctx = TickCtx {
    // rust: world: &mut self.world,
    // rust: entities,
    // rust: next_entity: &mut self.next_entity,
    // rust: spawn,
    // rust: difficulty: i32::from(self.ui.difficulty),
    // rust: difficulty_locked: self.level.difficulty_locked,
    // rust: clock_rate,
    // rust: tick_rate: self.clock.rate(),
    // rust: tick_frozen: self.clock.frozen(),
    // rust: tick_steps: self.clock.step_state(),
    // rust: collision: Some(self.collision),
    // rust: border: &self.border,
    // rust: streaming: Some(&self.streaming),
}
    // rust: host.hub.movement_checks = (
    // rust: self.ui.rules.bool("player_movement_check"),
    // rust: self.ui.rules.bool("elytra_movement_check"),
    // rust: );
                // IntegratedServer.getScaledTrackingDistance: the Entity Distance
                // option scales what an integrated server or a LAN host tracks (a
                // dedicated one keeps its entity-broadcast-range-percentage).
    // rust: if host.hub.config.integrated {
    // rust: host.hub.entity_range_percent =
    // rust: (self.settings.entity_distance * 100.0).round() as i32;
}
    // rust: host.hub
    // rust: .set_immediate_respawn(self.ui.rules.bool("immediate_respawn"));
    // rust: host.hub
    // rust: .set_reduced_debug_info(self.ui.rules.bool("reduced_debug_info"));
    // rust: host.hub
    // rust: .set_limited_crafting(self.ui.rules.bool("limited_crafting"));
                // A server with several levels runs a pass for each
                // (`tick_server`): the network is read once, before the first.
                // Player packets may already have been drained before
                // scheduled block ticks (`tick_lan_packets`).
    // rust: host.hub.mods_loaded = !horizon_client::mod_api::mods().is_empty();
    // rust: let pass = self.level_pass;
    // rust: let mut events = if pass.first && !pass.packets_drained {
    // rust: host.hub.poll(&mut ctx)
    // rust: } else {
    // rust: Vec::new()
}
    // rust: if !pass.packets_drained {
    // rust: events.extend(host.hub.drain_packets(&mut ctx));
}
    // rust: events.extend(horizon_client::spans::time("lan_tick_level", || {
    // rust: host.hub.tick_level(&mut ctx)
    // rust: }));
    // rust: if pass.last {
    // rust: horizon_client::spans::time("lan_end_tick", || host.hub.end_tick());
}
    // rust: events
}
    // rust: self.wake_woken_guests(&mut host);
    // rust: let processed = horizon_client::spans::time("lan_process_events", || {
    // rust: self.lan_process_events(host, events, entities, spawn)
    // rust: });
    // rust: let Some(back) = processed else {
    // rust: return;
}
    // rust: host = back;
    // rust: host.states = states;
}
    // rust: if !host.quiet.is_empty() {
    // rust: self.lan = Some(host);
    // rust: self.run_quiet_commands();
    // rust: host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after the quiet commands");
}
    // rust: if self.native_net_waiting() {
    // rust: self.lan = Some(host);
    // rust: self.run_native_net();
    // rust: host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after the mod messages");
}
    // rust: if !host.hub.native_advancement_grants.is_empty() {
    // rust: self.lan = Some(host);
    // rust: self.run_native_advancement_grants();
    // rust: host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after the advancement grants");
}
    // rust: if !host.hub.native_menu_events.is_empty() {
    // rust: self.lan = Some(host);
    // rust: self.run_native_menu_events();
    // rust: host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after the menu events");
}
    // rust: host = self.lan_flush_tracking(host);
    // rust: self.lan = Some(host);
        // A blast from a guest's attack, and a mace's wind burst.
    // rust: self.flush_lan_explosions();
    // rust: let _ = self.flush_wind_bursts();
        // A sweep attack's reach to the other players from a guest's attack.
    // rust: self.flush_sweeps();
        // A reeled-in hook pulling a player.
    // rust: self.flush_hook_pulls();
        // Particles a guest's turn sent (sweep attack, damage indicator, a hook's splashes).
    // rust: self.flush_lan_particles();
    // rust: let mut host = self
    // rust: .lan
    // rust: .take()
    // rust: .expect("the hub is back after the guest flushes");
    // rust: host = self.lan_flush_tracking(host);
    // rust: self.lan_flush_effects(&mut host);
    // rust: self.lan_living_flags(&mut host);
    // rust: self.lan_stuck(&mut host, paused);
    // rust: self.tick_server_travel(&mut host);
    // rust: self.lan_swings(&mut host);
    // rust: self.lan_update_streaming(&host);
    // rust: self.lan_guest_poses(&mut host);
    // rust: self.lan_update_waypoints(&mut host);
    // rust: self.lan_sync_scoreboard(&mut host);
    // rust: self.lan_sync_border(&mut host);
    // rust: host.hub.anticheat_ping();
    // rust: drop(holding);
    // rust: self.flush_attachment_sync(&mut host);
    // rust: self.flush_native_net(&mut host);
    // rust: self.flush_far_terrain(&mut host);
    // rust: lan::flush_all(host.hub.guests.iter().map(|g| &g.sender));
    // rust: self.lan = Some(host);
    // rust: self.flush_native_sounds();
        // `tick_server` resets the pass after all dimensions; outside a pass
        // the packet gate is per-tick.
    // rust: if self.level_pass.running.is_none() {
    // rust: self.level_pass.packets_drained = false;
}
}

    // rust: fn lan_guest_joined(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: entities: &[EntityState],
    // rust: spawn: [f64; 3],
    // rust: ) {
    // rust: let default_mode = host.hub.config.default_game_mode;
    // rust: let force = host.hub.config.force_game_mode;
    // rust: let root = self.world_root.clone();
    // rust: let in_place = host.hub.config.dimension.clone();
    // rust: let owner = host.owner.as_mut();
    // rust: let Some(g) = host.hub.guest_mut(conn) else {
    // rust: return;
}
        // PlayerList.loadPlayerData: the owner gets the world's player file,
        // everyone else their own.
    // rust: let known = match owner.filter(|o| o.uuid == g.uuid) {
    // rust: Some(o) => playerdata::load_owner(g, &root, o.saved.take().as_deref()),
    // rust: None => playerdata::load(g, &root),
}
    // rust: self.guest_attachments
    // rust: .insert(g.uuid, std::mem::take(&mut g.attachments));
        // PlayerEvent.LoadFromFile: the player's data is read and applied,
        // the player not yet placed.
    // rust: self.native_player_load_from_file(g.uuid, &g.name, &playerdata::directory(&root));
        // PrepareSpawnTask: with no saved rotation the player faces the world
        // spawn's angle (`/setworldspawn ... <angle>`).
    // rust: playerdata::face_world_spawn(g, known, self.level.world_spawn_angle);
    // rust: if !known || force {
    // rust: g.game_mode = default_mode;
}
    // rust: if !known {
            // ServerPlayer.adjustSpawnLocation: a player new to the world
            // stands where PlayerSpawnFinder puts them, not all on one spot
            // (it reads the loaded level, which holds the spawn when it is
            // the overworld).
    // rust: let feet = if self.dim == super::Dim::Overworld {
    // rust: self.server_player_spawn(spawn)
    // rust: } else {
    // rust: spawn
}
    // rust: g.position = feet;
    // rust: g.previous_position = feet;
            // Ready.spawn snaps the newcomer to the respawn data's yaw and
            // pitch, which for a player without a bed or anchor is the world
            // spawn's angle (`setworldspawn <pos> <rotation>`).
    // rust: (g.yaw, g.pitch) = (
    // rust: self.level.world_spawn_angle[0],
    // rust: self.level.world_spawn_angle[1],
    // rust: );
    // rust: g.head_yaw = g.yaw;
    // rust: g.health = 20.0;
    // rust: g.food = 20;
    // rust: g.dimension = super::Dim::Overworld.id().to_owned();
}
        // A server places each player in their own level (`PlayerList.placeNewPlayer`).
    // rust: let back = self.dim;
    // rust: let level = super::Dim::from_id(&g.dimension);
    // rust: let elsewhere = level != back;
    // rust: if !elsewhere {
    // rust: g.dimension = in_place;
}
    // rust: self.load_guest_records(host, conn);
        // The mods say which commands the newcomer's tree keeps.
    // rust: self.native_filter_commands(host, Some(conn));
    // rust: let mut theirs = States::default();
    // rust: let entities = if elsewhere {
    // rust: if let Err(e) = self.enter_level(Some(host), level) {
    // rust: log::error!("could not open {}: {e}", level.id());
    // rust: return;
}
            // A dedicated server has no host player.
    // rust: self.lan_entities(
    // rust: &host.mob_players,
    // rust: &mut host.hub,
    // rust: &mut theirs,
    // rust: false,
    // rust: 0,
    // rust: None,
    // rust: );
    // rust: self.lan_hook_states(&host.play, &host.hub, &mut theirs);
    // rust: self.lan_entity_uuids(&mut theirs);
    // rust: theirs.as_slice()
    // rust: } else {
    // rust: entities
}
    // rust: let clock_rate = self.network_clock_rate();
    // rust: let mut ctx = TickCtx {
    // rust: world: &mut self.world,
    // rust: entities,
    // rust: next_entity: &mut self.next_entity,
    // rust: spawn,
    // rust: difficulty: i32::from(self.ui.difficulty),
    // rust: difficulty_locked: self.level.difficulty_locked,
    // rust: clock_rate,
    // rust: tick_rate: self.clock.rate(),
    // rust: tick_frozen: self.clock.frozen(),
    // rust: tick_steps: self.clock.step_state(),
    // rust: collision: Some(self.collision),
    // rust: border: &self.border,
    // rust: streaming: Some(&self.streaming),
}
    // rust: host.hub.place_new_player(conn, &mut ctx);
    // rust: if elsewhere && let Err(e) = self.enter_level(Some(host), back) {
    // rust: log::error!("could not reopen {}: {e}", back.id());
}
}

    // Level events the game queued, for the guests (`process_level_events`).
    // rust: pub(super) fn lan_record_events(&mut self, events: &[horizon_world::level::LevelEvent]) {
    // rust: if self.audio.capture.is_none() {
    // rust: return;
}
        // The acting guest's own break: `Block.playerWillDestroy` excludes the
        // player from the destroy events up to the broken block's. What a
        // break sets off after that (a torch popping off, a stalk falling) is
        // `destroyBlock` with no player, which the breaker hears and sees too.
    // rust: let mut own_break = self.lan_break_pos.is_some();
    // rust: for e in events {
    // rust: match e {
    // rust: horizon_world::level::LevelEvent::LevelEvent { id, pos, data } => {
    // rust: let own = *id == 2001 && own_break;
    // rust: if own && self.lan_break_pos == Some([pos.x, pos.y, pos.z]) {
    // rust: own_break = false;
}
                    // The acting guest does not predict these, and the vanilla
                    // call names no excluded player (`levelEvent(id, pos, data)`
                    // passes null): the composter fill (1500), the egg's
                    // teleport, bone meal's growth, anvil result sounds, a
                    // finished brushing or an eye inserted in a portal frame,
                    // a zombie's infection and a finished cure (1026, 1027),
                    // and the digger's own crack and hit sound (2019, 2020).
    // rust: let except = level_event_except(
    // rust: *id,
    // rust: self.lan_acting,
    // rust: *id == 2001 && self.lan_break_pos.is_some() && !own,
    // rust: );
    // rust: self.lan_events
    // rust: .push((*id, [pos.x, pos.y, pos.z], *data, except));
}
                // `ServerLevel.runBlockEvents` broadcasts a handled block
                // event (`ClientboundBlockEventPacket`): the guest re-runs
                // the block's `triggerEvent` — a piston's `moveBlocks` is
                // what animates the move there. `state` is the block the
                // event named, read before it ran (the packet's `block`).
    // rust: horizon_world::level::LevelEvent::BlockEntityEvent { pos, state, a, b } => {
    // rust: self.lan_block_events
    // rust: .push(([pos.x, pos.y, pos.z], *a, *b, state.0));
}
    // rust: _ => {}
}
}
}

    // `Level.blockEvent` for the guests (`ClientboundBlockEventPacket`).
    // rust: pub(super) fn lan_block_event(&mut self, pos: [i32; 3], b0: i32, b1: i32) {
    // rust: if self.audio.capture.is_some() {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]).0;
    // rust: self.lan_block_events.push((pos, b0, b1, state));
}
}
    // `Level.broadcastEntityEvent` for the guests.
    // rust: pub(super) fn lan_entity_event(&mut self, id: i32, event: i8, at: [f64; 3]) {
    // rust: if self.audio.capture.is_some() {
    // rust: self.lan_entity_events.push((id, event, at));
}
        // Event 16: zombie villagers play their cure sound on each client.
    // rust: if event == 16 && self.options.execution_role.is_client() {
    // rust: self.zombie_villager_cure_sound(id as u32);
}
        // Event 63: a sniffer's digging sound loop starts (ClientPacketListener.handleEntityEvent 63).
    // rust: if event == 63 && self.options.execution_role.is_client() {
    // rust: self.start_sniffer_digging_sound(id as u32);
}
        // Event 21: a window that simulates the world itself is its own
        // client, and hears the guardian's hum too.
    // rust: if event == 21 && self.options.execution_role.is_client() {
    // rust: self.start_guardian_sound(id as u32);
}
        // Events 53 and 54: honey crumbs while sliding, and the landing burst
        // (`HoneyBlock.showSlideParticles` / `showJumpParticles`), drawn by the
        // client that runs the world.
    // rust: if self.options.execution_role.is_client()
    // rust: && horizon_client::landing::honey_particle_count(event).is_some()
    // rust: {
    // rust: self.honey_entity_particles(at, event);
}
        // Event 2: a mob's spear hit felt; the same window hears its own mob's hit.
    // rust: if event == 2 && self.options.execution_role.is_client() {
    // rust: self.remote_kinetic_hit(id);
}
        // Fox.handleEntityEvent 45: the same window draws the eating crumbs.
    // rust: if event == 45 && self.options.execution_role.is_client() {
    // rust: self.fox_eat_particles(id as u32);
}
        // Entity event 35: a mob's death protection fired
        // (`LivingEntity.checkTotemDeathProtection`); the clients draw the
        // totem particles and play its sound.
    // rust: if event == 35 && self.options.execution_role.is_client() {
    // rust: self.remote_totem(id);
}
}
    // `LivingEntity.onEquippedItemBroken` for the acting player (the guest whose turn it
    // is, else the host): `level.broadcastEntityEvent` with `entityEventForEquipmentBreak`
    // of the slot, which each client answers with `breakItem` (the sound and the crumbs,
    // `remote_equipment_break`). Without a hub to tell, or in a window that runs the world
    // itself, the sound and the crumbs are played here.
    // rust: pub(super) fn player_equipment_broke(
    // rust: &mut self,
    // rust: slot: horizon_world::player_inventory::EquipmentSlot,
    // rust: stack: &horizon_client::items::ItemStack,
    // rust: ) {
//         use horizon_world::player_inventory::EquipmentSlot;
    // rust: let event = match slot {
    // rust: EquipmentSlot::MainHand => 47,
    // rust: EquipmentSlot::OffHand => 48,
    // rust: EquipmentSlot::Head => 49,
    // rust: EquipmentSlot::Chest => 50,
    // rust: EquipmentSlot::Legs => 51,
    // rust: EquipmentSlot::Feet => 52,
    // rust: EquipmentSlot::Body => 65,
    // rust: EquipmentSlot::Saddle => 68,
}
        // The mods hear a server player's break (a creative player's gear takes no wear).
    // rust: if !self.creative
    // rust: && let (Some(uuid), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_destroy_item(uuid, &name, &stack.item, equipment_slot_name(slot));
}
    // rust: let Some(at) = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z])
    // rust: else {
    // rust: return;
}
    // rust: let told = self.lan_acting.is_some();
    // rust: if told {
    // rust: self.guest_equipment_breaks.push((event, at));
}
    // rust: if told && !self.options.execution_role.is_client() {
    // rust: return;
}
        // LivingEntity.breakItem: the stack's break sound where it stands, then the crumbs.
    // rust: self.break_sound_at(stack, at);
    // rust: self.eat_particles(stack, 5);
}
    // `ServerPlayer.crit` (or `magicCrit` when `magic`): this window's
    // emitter, and an animation for the attacker's client and observers once
    // the hub is back in place.
    // rust: pub(super) fn critical_hit(
    // rust: &mut self,
    // rust: attacker: Option<u32>,
    // rust: id: i32,
    // rust: feet: [f64; 3],
    // rust: width: f64,
    // rust: height: f64,
    // rust: magic: bool,
    // rust: ) {
//         use horizon_client::particles::{ParticleOptions, ParticleType};
    // rust: let particle = if magic {
    // rust: ParticleType::EnchantedHit
    // rust: } else {
    // rust: ParticleType::Crit
}
    // rust: self.particles
    // rust: .tracking_emitter(ParticleOptions::simple(particle), feet, width, height);
    // rust: if self.audio.capture.is_some() {
    // rust: self.lan_critical_hits.push((attacker, id, magic));
}
}
    // Send the tick's level events, sounds and mob animations.
lan_flush_effects :: proc(self: ^Self, host: ^LanHost) {
}
    // rust: let critical_hits = std::mem::take(&mut self.lan_critical_hits);
    // rust: let kinetic_hits = std::mem::take(&mut self.lan_kinetic_hits);
    // rust: for (state, at) in std::mem::take(&mut self.lan_cushion_breaks) {
    // rust: if let Some(id) = host
    // rust: .hub
    // rust: .registry_id("minecraft:particle_type", "minecraft:block")
    // rust: {
    // rust: host.hub.broadcast_near(
    // rust: at,
    // rust: 32.0,
    // rust: &C::LevelParticles(play::LevelParticles {
    // rust: particle: horizon_protocol::entity_data::Particle {
    // rust: id,
    // rust: data: Some(horizon_protocol::entity_data::ParticleData::State(
    // rust: state.0 as i32,
    // rust: )),
    // rust: },
    // rust: override_limiter: false,
    // rust: always_show: false,
    // rust: pos: at,
    // rust: dist: [0.25, 0.0625, 0.25],
    // rust: max_speed: [0.05; 3],
    // rust: count: 10,
    // rust: randomization: 0,
    // rust: }),
    // rust: None,
    // rust: );
}
}
    // rust: for (kind, pos, data, acting) in std::mem::take(&mut self.lan_events) {
    // rust: if kind == 2001 {
    // rust: host.broken
    // rust: .push([f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])]);
}
    // rust: host.hub.level_event(kind, pos, data, acting);
}
        // Level events 1010 and 1011: the guests' parrots dance or stop.
    // rust: for (pos, song) in std::mem::take(&mut self.lan_songs) {
    // rust: match song {
    // rust: Some(name) => {
    // rust: let id = host.hub.registry_id("minecraft:jukebox_song", &name);
    // rust: host.hub.level_event(1010, pos, id.unwrap_or(0), None);
}
    // rust: None => host.hub.level_event(1011, pos, 0, None),
}
}
    // rust: for (pos, b0, b1, state) in std::mem::take(&mut self.lan_block_events) {
    // rust: host.hub.block_event(pos, b0, b1, state);
}
    // rust: for (id, event, at) in std::mem::take(&mut self.lan_entity_events) {
    // rust: host.hub.entity_event(id, event, at);
}
    // rust: for (kind, pos, data) in std::mem::take(&mut self.lan_global_events) {
    // rust: host.hub.global_level_event(kind, pos, data);
}
    // rust: self.lan_broadcast_effects(host);
    // rust: if host.hub.guests.is_empty() {
    // rust: host.mob_state.clear();
    // rust: return;
}
        // Hurt and death animations of mobs.
    // rust: let mut seen = HashMap::new();
    // rust: for m in &self.mobs {
    // rust: let dead = !m.alive();
    // rust: let old = host
    // rust: .mob_state
    // rust: .get(&self.dim)
    // rust: .and_then(|s| s.get(&m.id))
    // rust: .copied();
    // rust: let at = [m.position.x, m.position.y, m.position.z];
            // LivingEntity.hurtServer: a hurt that restarted the hurt time.
    // rust: if m.hurt_time > old.map_or(0, |o| o.0)
    // rust: && !dead
    // rust: && let Some((source, _)) = m.last_damage
    // rust: {
//                 use horizon_client::mobs::{DamageKind as K, Who};
    // rust: let kind = super::creatures::source_damage_type(source);
                // The player a mob sees is the guest acting.
    // rust: let cause = source.attacker.and_then(|who| match who {
    // rust: Who::Player => host
    // rust: .mob_players
    // rust: .get(&m.id)
    // rust: .and_then(|conn| host.hub.guest(*conn))
    // rust: .map(|g| g.entity_id),
    // rust: Who::Mob(id) => Some(id as i32),
    // rust: });
                // A projectile is the direct entity of its hit: not tracked here.
    // rust: let melee = matches!(
    // rust: source.kind,
    // rust: K::PlayerAttack
    // rust: | K::MaceSmash
    // rust: | K::Spear
    // rust: | K::MobAttack
    // rust: | K::Sting
    // rust: | K::SonicBoom
    // rust: );
    // rust: let direct = cause.filter(|_| melee);
    // rust: host.hub.damage_event(m.id as i32, kind, cause, direct, at);
}
    // rust: if dead && !old.is_some_and(|o| o.1) {
    // rust: host.hub.entity_event(m.id as i32, 3, at);
}
            // LivingEntity.swing on a server (a melee hit, a thrown potion):
            // ClientboundSwingAnimationPacket for the players around. A swing
            // started since the last flush, or restarted (its time went back).
    // rust: let swing = m.ai.swinging.then_some(m.ai.swing_time);
    // rust: if let Some(time) = swing
    // rust: && !dead
    // rust: && old.and_then(|o| o.2).is_none_or(|before| time < before)
    // rust: {
    // rust: host.hub.swing(m.id as i32, 0, at, None);
}
    // rust: seen.insert(m.id, (m.hurt_time, dead, swing));
}
    // rust: if let Some(d) = self.dragon.as_ref().filter(|d| d.id != 0) {
    // rust: let id = d.id;
    // rust: let dead = !d.alive();
    // rust: let old = host
    // rust: .mob_state
    // rust: .get(&self.dim)
    // rust: .and_then(|s| s.get(&id))
    // rust: .copied();
    // rust: let at = [d.position.x, d.position.y, d.position.z];
    // rust: if d.hurt_time > old.map_or(0, |o| o.0) && !dead {
    // rust: let (kind, cause, direct) =
    // rust: d.last_source.unwrap_or(("minecraft:generic", None, None));
    // rust: host.hub.damage_event(id as i32, kind, cause, direct, at);
}
    // rust: seen.insert(id, (d.hurt_time, dead, None));
}
    // rust: host.mob_state.insert(self.dim, seen);
        // Level.broadcastEntityEvent(player, 2) of a spear's stab.
    // rust: for attacker in kinetic_hits {
    // rust: let hit = attacker
    // rust: .and_then(|conn| host.hub.guest(conn))
    // rust: .map(|g| (g.entity_id, g.position));
    // rust: if let Some((id, at)) = hit {
    // rust: host.hub.entity_event(id, 2, at);
}
}
    // rust: for (attacker, target, magic) in critical_hits {
    // rust: let Some(attacker) =
    // rust: attacker.and_then(|conn| host.hub.guest(conn).map(|g| g.entity_id))
    // rust: else {
    // rust: continue;
}
    // rust: host.hub.critical_hit(attacker, target, magic);
}
}

    // Keep the chunks around every guest loaded.
lan_update_streaming :: proc(self: ^Self, host: ^LanHost) {
}
        // DistanceManager.PlayerTicketTracker: every chunk within the server's
        // view distance (Chebyshev) of a player holds a PLAYER_LOADING ticket
        // at the entity-ticking level (31), whatever the player asked for;
        // levels rise by one a chunk, so FULL (33) reaches two chunks past
        // it. An extra area finishes its chunks out to its radius + 1. That
        // covers what the player tracks (`ChunkTrackingView`, within its view
        // distance + 1) and those chunks' lit neighbours.
    // rust: let radius = host.hub.config.view_distance + 1;
    // rust: let rule = self.ui.rules.bool("spectators_generate_chunks");
        // The held players are sent the level, so their chunks are kept as the placed ones'.
    // rust: self.streaming.extra = host
    // rust: .hub
    // rust: .loading_chunks(|g| super::game_mode::loads_chunks(rule, g.spectator()))
    // rust: .into_iter()
    // rust: .map(|chunk| (chunk, radius))
    // rust: .chain(
    // rust: self.arrival_chunks(self.dim)
    // rust: .into_iter()
                    // An arrival keeps only its landing spot lit enough to
                    // resolve (the 3x3 `resolve_arrivals` checks), where it
                    // then ticks without a player.
    // rust: .map(|chunk| (chunk, 1)),
    // rust: )
            // A portal ticket keeps the area around the exit loaded and
            // ticking (its entity-ticking chunks and their neighbours).
    // rust: .chain(
    // rust: self.portal_ticket_chunks(self.dim)
    // rust: .into_iter()
    // rust: .map(|chunk| (chunk, 1)),
    // rust: )
    // rust: .collect();
}

    // The bed at `head` as a sleeping model lies in it (`ints[1]`,
    // `villager::sleep_pose`): its `facing`.
    // `Entity.setPose` for the server's players: the mods hear each placed
    // guest's change of pose. Nothing is kept while no mod is loaded.
lan_guest_poses :: proc(self: ^Self, host: ^LanHost) {
}
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: host.poses.clear();
    // rust: return;
}
    // rust: host.poses
    // rust: .retain(|conn, _| host.hub.guest(*conn).is_some_and(|g| g.placed));
    // rust: let mut changed = Vec::new();
    // rust: for g in host.hub.guests.iter().filter(|g| g.placed) {
    // rust: let to = g.pose();
    // rust: let from = host.poses.insert(g.conn, to).unwrap_or_default();
    // rust: if from != to {
    // rust: changed.push((g.uuid, g.name.clone(), from, to));
}
}
    // rust: for (uuid, name, from, to) in changed {
    // rust: self.native_entity_pose_change(uuid, &name, from.name(), to.name());
}
}

    // rust: pub(super) fn bed_facing(&self, head: [i32; 3]) -> i32 {
    // rust: let state = self.world.block(head[0], head[1], head[2]);
    // rust: let facing = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("facing"))
    // rust: .map(String::as_str);
    // rust: horizon_client::mobs::villager::bed_facing_code(facing)
}
}

    // rust: impl Game<'_> {
    // A hub's chat and log lines: a dedicated server logs them
    // (MinecraftServer.logChatMessage, `[Not Secure]` for unsigned or
    // expired messages); a LAN host shows the chat.
    // rust: pub(super) fn lan_log_event(&mut self, event: HostEvent) {
    // rust: let dedicated = self.options.dedicated.is_some();
    // rust: match event {
    // rust: HostEvent::Chat { line, secure } if dedicated => {
    // rust: let tag = if secure { "" } else { "[Not Secure] " };
    // rust: super::dedicated::log("INFO", &format!("{tag}{line}"));
}
            // Player chat (and `/say`'s or `/me`'s, which are chat messages
            // too): the host's Chat option decides, as `ChatListener` does
            // for the guests' packets. Command feedback is a system message
            // and takes the system-message permission instead.
    // rust: HostEvent::Chat { line, .. } => self.player_message(Text::literal(line)),
    // rust: HostEvent::Warn(line) if dedicated => super::dedicated::log("WARN", &line),
    // rust: HostEvent::Warn(line) => log::warn!("{line}"),
    // rust: HostEvent::Error(line) if dedicated => super::dedicated::log("ERROR", &line),
    // rust: HostEvent::Error(line) => log::error!("{line}"),
    // rust: _ => {}
}
}
}

// `LivingEntity.DATA_LIVING_ENTITY_FLAGS` for an item in use: 1, and 2 when
// it is the off hand's. A stop is 0 here; vanilla leaves bit 1 set, so its
// stop of an off-hand use is 2. Both mean "not using" (bit 0 is clear), and
// nothing reads bit 1 without bit 0.
    // rust: pub(super) fn living_flags(using: Option<(usize, u32)>) -> i8 {
    // rust: using.map_or(0, |(slot, _)| if slot == OFFHAND_SLOT { 3 } else { 1 })
}

// The name a mod hears for an equipment slot (the armor stand hook's names, plus
// the two slots a mount's gear uses).
equipment_slot_name :: proc(slot: horizon_world::player_inventory::EquipmentSlot) -> ^ {
    // Ported from Horizon
    return {}
}
//     use horizon_world::player_inventory::EquipmentSlot;
    // rust: match slot {
    // rust: EquipmentSlot::MainHand => "mainhand",
    // rust: EquipmentSlot::OffHand => "offhand",
    // rust: EquipmentSlot::Head => "head",
    // rust: EquipmentSlot::Chest => "chest",
    // rust: EquipmentSlot::Legs => "legs",
    // rust: EquipmentSlot::Feet => "feet",
    // rust: EquipmentSlot::Body => "body",
    // rust: EquipmentSlot::Saddle => "saddle",
}
}

// What a hub event is, whose connection, and the name of a player who left (no longer in the
// hub once it is handled): for a slow tick's notes.
    // rust: type EventKind = (&'static str, Option<u32>, Option<String>);

event_kind :: proc(event: ^HostEvent) -> E {
    // Ported from Horizon
    return {}
}
    // rust: match event {
    // rust: HostEvent::Joined(c) => ("join", Some(*c), None),
    // rust: HostEvent::Left(g) => ("leave", None, Some(g.name.clone())),
    // rust: HostEvent::Packet(c, p) => (p.name(), Some(*c), None),
    // rust: HostEvent::MainHandChanged(c, _) => ("main hand", Some(*c), None),
    // rust: HostEvent::LocaleChanged(c, _) => ("locale", Some(*c), None),
    // rust: HostEvent::PlayerLoaded(c) => ("loaded", Some(*c), None),
    // rust: HostEvent::RecipeBookSettings { conn, .. } => ("recipe book", Some(*conn), None),
    // rust: HostEvent::Sneak { conn, .. } => ("sneak", Some(*conn), None),
    // rust: HostEvent::Input { conn, .. } => ("input", Some(*conn), None),
    // rust: HostEvent::Kicked { name, .. } => ("kick", None, Some(name.clone())),
    // rust: HostEvent::Flight { conn, .. } => ("flight", Some(*conn), None),
    // rust: HostEvent::Chat { .. } => ("chat line", None, None),
    // rust: HostEvent::PlayerChat { .. } => ("chat", None, None),
    // rust: HostEvent::ChatFiltered { name, .. } => ("filtered chat", None, Some(name.clone())),
    // rust: HostEvent::Warn(_) => ("warning", None, None),
    // rust: HostEvent::Error(_) => ("error", None, None),
    // rust: HostEvent::Ban { name, .. } => ("ban", None, Some(name.clone())),
}
}

// Who `ServerLevel.levelEvent` leaves out of the broadcast.
//
// `LevelAccessor.levelEvent(int, BlockPos, int)` passes a null source, so the
// acting player is included. `ComposterBlock.useItemOn` (and the hopper input
// container) fill that way: event 1500, which the client turns into
// `handleFill` (the fill particles and `playLocalSound`). A call that names
// the player still excludes them. `collateral_break` is a later 2001 from
// `destroyBlock` with no player, after the breaker's own `playerWillDestroy`.
level_event_except :: proc(id: i32, acting: Maybe(u32), collateral_break: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if matches!(
    // rust: id,
    // rust: 2015 | 1500
    // rust: | 1501
    // rust: | 1503
    // rust: | 1505
    // rust: | 1026
    // rust: | 1027
    // rust: | 1029
    // rust: | 1030
    // rust: | 1045
    // rust: | 1052
    // rust: | 2019
    // rust: | 2020
    // rust: | 3000
    // rust: | 3008
    // rust: ) || collateral_break
    // rust: {
    // rust: None
    // rust: } else {
    // rust: acting
}
}

// Notes how long the event that started at `started` took (`spans::note`), with what it
// was about when [`Game::event_detail`] said.
note_event :: proc(host: ^LanHost, started: Option<(Instant) {
}
    // rust: let Some((started, (kind, conn, name), detail)) = started else {
    // rust: return;
}
    // rust: horizon_client::spans::note(started.elapsed().as_secs_f32() * 1000.0, || {
    // rust: let who = name
    // rust: .or_else(|| conn.and_then(|c| host.hub.guest(c)).map(|g| g.name.clone()))
    // rust: .or_else(|| conn.map(|c| format!("connection {c}")));
    // rust: let line = match who {
    // rust: Some(who) => format!("{kind} of {who}"),
    // rust: None => kind.to_owned(),
}
    // rust: match detail {
    // rust: Some(d) => format!("{line} ({d})"),
    // rust: None => line,
}
    // rust: });
}

// What a use packet was about, taken before it ran (the use may consume the item or change
// the block): the item in the hand it names and, on a block, that block, where, and the face.
UseDetail :: struct {
    item: Maybe(^str),
    block: Maybe((Arc<str),
}

    // rust: impl std::fmt::Display for UseDetail {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(self.item.as_deref().unwrap_or("empty hand"))?;
    // rust: if let Some((block, [x, y, z], face)) = &self.block {
    // rust: let face = ["down", "up", "north", "south", "west", "east"]
    // rust: .get(*face as usize)
    // rust: .copied()
    // rust: .unwrap_or("?");
    // rust: write!(f, " on {block} at {x} {y} {z} {face}")?;
}
    // rust: Ok(())
}
}

    // rust: impl Game<'_> {
    // For a slow tick's note (#8669): the item a `UseItemOn` or `UseItem` uses and the block
    // it aims at. None for other events.
event_detail :: proc(self: ^Self, host: ^LanHost, event: ^HostEvent) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let HostEvent::Packet(conn, packet) = event else {
    // rust: return None;
}
    // rust: let (hand, block) = match &**packet {
    // rust: play::Serverbound::UseItemOn(p) => (p.hand, Some((p.pos, p.face))),
    // rust: play::Serverbound::UseItem(p) => (p.hand, None),
    // rust: _ => return None,
}
    // rust: let guest = host.hub.guest(*conn)?;
    // rust: let held = if hand == 1 {
    // rust: guest.offhand.as_ref()
    // rust: } else {
    // rust: guest.inventory.get(guest.selected).and_then(Option::as_ref)
}
    // rust: Some(UseDetail {
    // rust: item: held.map(|s| Arc::clone(&s.item)),
    // rust: block: block.map(|(pos, face)| (self.block_name(pos), pos, face)),
    // rust: })
}
}

    // rust: mod tests {
//     use super::{OFFHAND_SLOT, equipment_slot_name, living_flags, mob_freeze_meta};
//     use horizon_client::mobs::Mob;
//     use horizon_protocol::entity_data::{Value, serializer};

datapack_damage_world_open_reuses_the_no_pack_preload :: proc() {
}
//         use super::{SyncCache, SyncData, cached_sync_data, initialize_world_sync_data};
//         use horizon_world::loot::PackOverlay;
//         use std::{path::Path, sync::Arc};
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let preloaded = Arc::new(SyncData::load(&root, &PackOverlay::NONE).unwrap());
    // rust: let mut cache = SyncCache {
    // rust: data: Some((false, Ok(preloaded.clone()))),
    // rust: ..Default::default()
}
    // rust: let damage =
    // rust: horizon_world::damage_source::Catalog::load(&root, &PackOverlay::NONE).unwrap();
        // A missing root makes an accidental second disk read fail, rather
        // than merely comparing equal snapshots loaded twice.
    // rust: let absent = root.join("no-such-resources");
    // rust: initialize_world_sync_data(&mut cache, &absent, &PackOverlay::NONE, &damage).unwrap();
    // rust: let opened = cached_sync_data(&mut cache, &absent, &PackOverlay::NONE).unwrap();
    // rust: assert!(Arc::ptr_eq(&preloaded, &opened));
    // rust: assert!(Arc::ptr_eq(
    // rust: &opened,
    // rust: &cached_sync_data(&mut cache, &absent, &PackOverlay::NONE).unwrap()
    // rust: ));
}

datapack_damage_world_open_replaces_preload_atomically :: proc() {
}
//         use super::{SyncCache, SyncData, cached_sync_data, initialize_world_sync_data};
//         use horizon_world::loot::PackOverlay;
//         use std::{
    // rust: path::Path,
    // rust: sync::{Arc, Barrier, Mutex},
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let preloaded = Arc::new(SyncData::load(&root, &PackOverlay::NONE).unwrap());
    // rust: let cache = Arc::new(Mutex::new(SyncCache {
    // rust: data: Some((false, Ok(preloaded.clone()))),
    // rust: ..Default::default()
    // rust: }));
    // rust: let barrier = Arc::new(Barrier::new(2));
    // rust: let worker = {
    // rust: let cache = cache.clone();
    // rust: let barrier = barrier.clone();
    // rust: let root = root.clone();
    // rust: std::thread::spawn(move || {
    // rust: barrier.wait();
    // rust: for _ in 0..32 {
    // rust: cached_sync_data(&mut cache.lock().unwrap(), &root, &PackOverlay::NONE)
    // rust: .unwrap();
}
    // rust: })
}
    // rust: let files = vec![(
    // rust: "damage_type/demo:world_heat".into(),
    // rust: vec![br#"{"message_id":"world_heat","scaling":"never","exhaustion":0.25}"#.to_vec()],
    // rust: )];
    // rust: barrier.wait();
    // rust: let overlay = PackOverlay { files: &files };
    // rust: let damage = horizon_world::damage_source::Catalog::load(&root, &overlay).unwrap();
    // rust: initialize_world_sync_data(&mut cache.lock().unwrap(), &root, &overlay, &damage).unwrap();
    // rust: let opened = cached_sync_data(&mut cache.lock().unwrap(), &root, &overlay).unwrap();
    // rust: worker.join().unwrap();
    // rust: assert!(!Arc::ptr_eq(&preloaded, &opened));
    // rust: let id = opened
    // rust: .id("minecraft:damage_type", "demo:world_heat")
    // rust: .unwrap();
    // rust: let later =
    // rust: cached_sync_data(&mut cache.lock().unwrap(), &root, &PackOverlay::NONE).unwrap();
    // rust: assert!(
    // rust: Arc::ptr_eq(&opened, &later),
    // rust: "a late helper or disabled pack cannot replace a frozen world"
    // rust: );
    // rust: let packet = later.registry_packets(true, &horizon_client::chunk::LevelShapes::VANILLA);
    // rust: let packet = packet
    // rust: .iter()
    // rust: .find(|p| p.registry == "minecraft:damage_type")
    // rust: .unwrap();
    // rust: assert_eq!(packet.entries[id as usize].id, "demo:world_heat");
    // rust: assert!(packet.entries[id as usize].data.is_some());
}

datapack_damage_unrelated_packs_do_not_load_sync_data_at_open :: proc() {
}
//         use super::{SyncCache, SyncData, initialize_world_sync_data};
//         use horizon_world::{damage_source::Catalog, loot::PackOverlay};
//         use std::{path::Path, sync::Arc};
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let damage = Catalog::load(&root, &PackOverlay::NONE).unwrap();
    // rust: let preloaded = Arc::new(SyncData::load(&root, &PackOverlay::NONE).unwrap());
        // A recipe-only pack and a damage-tag-only pack must retain main's
        // lazy wire-data path. An absent root proves no full load happens.
    // rust: for key in ["recipe/demo:test", "tags/minecraft:damage_type/is_fire"] {
    // rust: let files = vec![(key.into(), vec![br#"{"values":[]}"#.to_vec()])];
    // rust: let mut cache = SyncCache {
    // rust: data: Some((false, Ok(preloaded.clone()))),
    // rust: ..Default::default()
}
    // rust: initialize_world_sync_data(
    // rust: &mut cache,
    // rust: &root.join("absent"),
    // rust: &PackOverlay { files: &files },
    // rust: &damage,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(cache.data.is_none(), "{key} must not eagerly load SyncData");
    // rust: assert!(cache.damage.is_some());
}
    // rust: let mut empty = SyncCache::default();
    // rust: initialize_world_sync_data(
    // rust: &mut empty,
    // rust: &root.join("absent"),
    // rust: &PackOverlay::NONE,
    // rust: &damage,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(
    // rust: empty.data.is_none(),
    // rust: "no-pack worlds need no synchronous fallback load either"
    // rust: );
}

datapack_damage_lazy_wire_snapshot_survives_reload_before_first_hub :: proc() {
}
//         use super::{SyncCache, cached_sync_data, initialize_world_sync_data, prepare_sync_reload};
//         use horizon_world::{damage_source::Catalog, loot::PackOverlay};
//         use std::path::Path;
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let damage = Catalog::load(&root, &PackOverlay::NONE).unwrap();
    // rust: let initial = vec![(
    // rust: "dialog/demo:before".into(),
    // rust: vec![br#"{"type":"minecraft:notice"}"#.to_vec()],
    // rust: )];
    // rust: let mut cache = SyncCache::default();
    // rust: initialize_world_sync_data(&mut cache, &root, &PackOverlay { files: &initial }, &damage)
    // rust: .unwrap();
    // rust: assert!(cache.data.is_none());
        // A late vanilla helper cannot install its overlay over this world.
    // rust: cached_sync_data(&mut cache, &root, &PackOverlay::NONE).unwrap();
    // rust: assert!(cache.data.is_none());
    // rust: let changed = vec![
    // rust: (
    // rust: "damage_type/demo:too_late".into(),
    // rust: vec![br#"{"message_id":"too_late","scaling":"never","exhaustion":0.5}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "damage_type/minecraft:fall".into(),
    // rust: vec![br#"{"message_id":"changed","scaling":"never","exhaustion":0.9}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "dialog/demo:after".into(),
    // rust: vec![br#"{"type":"minecraft:notice"}"#.to_vec()],
    // rust: ),
    // rust: (
    // rust: "tags/demo:damage_type/reloaded".into(),
    // rust: vec![
    // rust: br#"{"values":["minecraft:fall",{"id":"demo:too_late","required":false}]}"#
    // rust: .to_vec(),
    // rust: ],
    // rust: ),
    // rust: ];
    // rust: let overlay = PackOverlay { files: &changed };
    // rust: assert!(prepare_sync_reload(&mut cache, &overlay).is_none());
    // rust: let health = damage.reload_tags(&root, &overlay).unwrap();
    // rust: let wire = cached_sync_data(&mut cache, &root, &overlay).unwrap();
    // rust: assert!(wire.id("minecraft:damage_type", "demo:too_late").is_none());
    // rust: assert!(health.id("demo:too_late").is_none());
    // rust: assert!(wire.id("minecraft:dialog", "demo:before").is_none());
    // rust: assert!(
    // rust: wire.id("minecraft:dialog", "demo:after").is_some(),
    // rust: "unrelated registries stay lazy"
    // rust: );
    // rust: let fall = wire.id("minecraft:damage_type", "minecraft:fall").unwrap();
    // rust: let packets = wire.registry_packets(false, &horizon_client::chunk::LevelShapes::VANILLA);
    // rust: let packet = packets
    // rust: .iter()
    // rust: .find(|p| p.registry == "minecraft:damage_type")
    // rust: .unwrap();
    // rust: let definition = health
    // rust: .definition(health.id("minecraft:fall").unwrap())
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: packet.entries[fall as usize].data.as_ref(),
    // rust: Some(&definition.to_nbt())
    // rust: );
    // rust: let tags = wire
    // rust: .tags
    // rust: .registries
    // rust: .iter()
    // rust: .find(|r| r.registry == "minecraft:damage_type")
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: tags.tags
    // rust: .iter()
    // rust: .find(|t| t.name == "demo:reloaded")
    // rust: .unwrap()
    // rust: .ids,
    // rust: vec![fall]
    // rust: );
    // rust: assert_eq!(
    // rust: health.tag_members("demo:reloaded").collect::<Vec<_>>(),
    // rust: vec!["minecraft:fall"]
    // rust: );
        // The next world's initial load can register the previously-late type.
    // rust: let next = Catalog::load(&root, &overlay).unwrap();
    // rust: let mut next_cache = SyncCache::default();
    // rust: initialize_world_sync_data(&mut next_cache, &root, &overlay, &next).unwrap();
    // rust: assert!(
    // rust: cached_sync_data(&mut next_cache, &root, &overlay)
    // rust: .unwrap()
    // rust: .id("minecraft:damage_type", "demo:too_late")
    // rust: .is_some()
    // rust: );
}

datapack_damage_lazy_wire_load_caches_after_all_packs_are_removed :: proc() {
}
//         use super::{SyncCache, cached_sync_data, initialize_world_sync_data, prepare_sync_reload};
//         use horizon_world::{damage_source::Catalog, loot::PackOverlay};
//         use std::{path::Path, sync::Arc};
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let damage = Catalog::load(&root, &PackOverlay::NONE).unwrap();
    // rust: let files = vec![(
    // rust: "recipe/demo:unrelated".into(),
    // rust: vec![br#"{"type":"minecraft:crafting_special_mapcloning"}"#.to_vec()],
    // rust: )];
    // rust: let mut cache = SyncCache::default();
    // rust: initialize_world_sync_data(&mut cache, &root, &PackOverlay { files: &files }, &damage)
    // rust: .unwrap();
    // rust: assert!(cache.data.is_none());
    // rust: assert!(prepare_sync_reload(&mut cache, &PackOverlay::NONE).is_none());
    // rust: let opened = cached_sync_data(&mut cache, &root, &PackOverlay::NONE).unwrap();
        // An accidental uncached load would fail on the next request rather
        // than merely reconstructing an equal registry from the same files.
    // rust: let reused = cached_sync_data(
    // rust: &mut cache,
    // rust: &root.join("no-such-resources"),
    // rust: &PackOverlay::NONE,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(Arc::ptr_eq(&opened, &reused));
}

mob_of :: proc(kind: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: let types = horizon_client::mobs::MobTypes::load(&root).ok()?;
    // rust: let t = std::sync::Arc::new(types.types.get(kind)?.clone());
    // rust: Some(Mob::new(
    // rust: 1,
    // rust: t,
    // rust: horizon_core::geometry::Vec3::new(0.0, 64.0, 0.0),
    // rust: 0.0,
    // rust: ))
}

freeze_meta :: proc(m: ^Mob) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (mut meta, mut defaults) = (Vec::new(), Vec::new());
    // rust: mob_freeze_meta(m, &mut meta, &mut defaults);
    // rust: (meta, defaults)
}

    // Entity.setTicksFrozen can go negative; index 7 must carry it. Index 1
    // (air supply) goes out for every mob, with the species' own default.
negative_frozen_ticks_and_axolotl_air_are_synced :: proc() {
}
    // rust: let Some(mut cow) = mob_of("minecraft:cow") else {
    // rust: return;
}
    // rust: cow.ticks_frozen = -3;
    // rust: let (meta, _) = freeze_meta(&cow);
    // rust: assert!(meta.contains(&(7, serializer::INT, Value::Int(-3))));
    // rust: cow.air = 100;
    // rust: assert!(
    // rust: freeze_meta(&cow)
    // rust: .0
    // rust: .contains(&(1, serializer::INT, Value::Int(100)))
    // rust: );

    // rust: let Some(mut axolotl) = mob_of("minecraft:axolotl") else {
    // rust: return;
}
    // rust: axolotl.air = 5000;
    // rust: let (meta, defaults) = freeze_meta(&axolotl);
    // rust: assert!(meta.contains(&(1, serializer::INT, Value::Int(5000))));
    // rust: assert!(defaults.contains(&(1, serializer::INT, Value::Int(6000))));
    // rust: axolotl.air = 6000;
    // rust: assert!(freeze_meta(&axolotl).0.iter().all(|e| e.0 != 1));
}

    // Raider.IS_CELEBRATING goes out through the tracker's own metadata
    // (`mob_meta`), not only through the helper: false is listed as a
    // default so the end of a celebration is sent, and true is sent while
    // the raider celebrates.
a_celebrating_raider_is_sent_by_mob_meta :: proc() {
}
    // rust: let Some(mut pillager) = mob_of("minecraft:pillager") else {
    // rust: return;
}
    // rust: let hub = meta_hub("RaiderMetaTest");
    // rust: let meta_of = |m: &Mob| {
    // rust: let (mut meta, mut defaults) = (Vec::new(), Vec::new());
    // rust: super::mob_meta(m, &hub, None, 0, &mut meta, &mut defaults);
    // rust: (meta, defaults)
}

    // rust: let (meta, defaults) = meta_of(&pillager);
    // rust: assert!(defaults.contains(&(16, serializer::BOOLEAN, Value::Bool(false))));
    // rust: assert!(meta.iter().all(|e| e.0 != 16), "{meta:?}");
    // rust: horizon_client::mobs::raider::state_mut(&mut pillager).celebrating = true;
    // rust: let (meta, _) = meta_of(&pillager);
    // rust: assert!(
    // rust: meta.contains(&(16, serializer::BOOLEAN, Value::Bool(true))),
    // rust: "{meta:?}"
    // rust: );
}

    // A content mod's living type sends the entity data of its template's
    // class (`Zombie.DATA_BABY_ID`, the villager's unhappy counter), entry
    // for entry what its template sends.
a_mod_living_type_sends_its_templates_entity_data :: proc() {
}
    // rust: let types = super::super::mods::living_mod_types();
    // rust: let hub = meta_hub("ModMobMetaTest");
    // rust: let meta_of = |id: &str| {
    // rust: let at = horizon_core::geometry::Vec3::new(0.5, 64.0, 0.5);
    // rust: let mut m = Mob::new(1, types[id].clone(), at, 0.0);
    // rust: m.extra.age = -24000;
            // The same health: the ghoul's own maximum is 40, the zombie's 20.
    // rust: m.health = 10.0;
    // rust: let (mut meta, mut defaults) = (Vec::new(), Vec::new());
    // rust: super::mob_meta(&m, &hub, None, 0, &mut meta, &mut defaults);
    // rust: (meta, defaults)
}
    // rust: for (template, id) in [
    // rust: ("minecraft:zombie", "ruby:ghoul"),
    // rust: ("minecraft:villager", "ruby:settler"),
    // rust: ("minecraft:wandering_trader", "ruby:merchant"),
    // rust: ] {
    // rust: assert_eq!(
    // rust: meta_of(id),
    // rust: meta_of(template),
    // rust: "{id} sends what {template} sends"
    // rust: );
}
}

    // A hub with no players and empty registries, for `mob_meta`.
meta_hub :: proc(name: string) -> h {
    // Ported from Horizon
    return {}
}
//         use horizon_client::lan::{Lan, NetConfig, chunks::ChunkEncoder, data, hub};
    // rust: let sync = std::sync::Arc::new(data::SyncData::empty());
    // rust: let config = NetConfig {
    // rust: announce: false,
    // rust: ..NetConfig::loopback(0, name.into(), 2)
}
    // rust: let lan = Lan::start_with(sync.clone(), config).unwrap();
    // rust: let encoder = ChunkEncoder::new(
    // rust: [] as [(std::sync::Arc<str>, bool); 0],
    // rust: &horizon_protocol::registry::Builtin::default(),
    // rust: &[],
    // rust: &[],
    // rust: );
    // rust: let hub_config = hub::HubConfig {
    // rust: default_game_mode: 0,
    // rust: guest_commands: false,
    // rust: force_game_mode: false,
    // rust: hardcore: false,
    // rust: view_distance: 10,
    // rust: simulation_distance: 10,
    // rust: dimension: "minecraft:overworld".into(),
    // rust: allow_flight: false,
    // rust: seed: 0,
    // rust: max_players: 20,
    // rust: integrated: false,
    // rust: levels: Default::default(),
}
    // rust: hub::Hub::new(lan, sync, encoder, hub_config)
}

    // `LivingEntity.startUsingItem` sets flag 1 for the use and flag 2 for
    // the off hand, so an off-hand use is 3, not 2. A reader takes bit 0 as
    // `isUsingItem` and bit 1 as `getUsedItemHand`.
an_off_hand_use_flags_both_the_use_and_the_hand :: proc() {
}
    // rust: assert_eq!(living_flags(None), 0);
    // rust: assert_eq!(living_flags(Some((0, 12))), 1);
    // rust: assert_eq!(living_flags(Some((OFFHAND_SLOT, 12))), 3);
}

    // `ComposterBlock.useItemOn` calls `levelEvent(1500, pos, data)`, the
    // null-source overload, so the player who filled it still receives
    // `handleFill`. `Block.playerWillDestroy`'s 2001 names that player.
the_composter_fill_reaches_the_player_who_filled_it :: proc() {
}
    // rust: let actor = Some(4);
    // rust: assert_eq!(super::level_event_except(1500, actor, false), None);
    // rust: assert_eq!(super::level_event_except(2001, actor, false), actor);
    // rust: assert_eq!(super::level_event_except(2001, actor, true), None);
}

    // The names a mod matches on for a broken item's slot (a contract).
a_broken_items_slot_is_named_for_mods :: proc() {
}
//         use horizon_world::player_inventory::EquipmentSlot::*;
    // rust: let named: Vec<_> = [MainHand, OffHand, Head, Chest, Legs, Feet, Body, Saddle]
    // rust: .map(equipment_slot_name)
    // rust: .to_vec();
    // rust: assert_eq!(
    // rust: named,
    // rust: [
    // rust: "mainhand", "offhand", "head", "chest", "legs", "feet", "body", "saddle"
    // rust: ]
    // rust: );
}
}
