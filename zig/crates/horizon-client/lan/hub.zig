//! Transpiled from Horizon Rust crate
//! Module: horizon-client_hub
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The play state of a hosted world (PlayerList, ServerGamePacketListenerImpl,
//! ChunkMap, PlayerChunkSender): admits the players the connection threads
//! hand over, sends them the level (chunks, time, weather, entities, player
//! list), keeps their views up to date as blocks and entities change, and
//! turns what they send into events for the gameplay code. It runs on the
//! game thread inside the tick, only when the world is open to the network.
// use super::{
    // rust: Lan, NetEvent,
    // rust: chunks::ChunkEncoder,
    // rust: data::SyncData,
    // rust: entity::{Entities, EntityState, Viewer},
    // rust: guest::{Guest, SentEffect, stack_to_network},
}
// use crate::{
    // rust: chunk::Chunk,
    // rust: collisions::SceneCollisions,
    // rust: effects::{EffectInstance, PlayerEffects},
    // rust: items::ItemStack,
    // rust: world::World,
}
// use horizon_core::{
    // rust: geometry::{Aabb, ShapeOp, Vec3, VoxelShape},
    // rust: random::LegacyRandom,
}
// use horizon_protocol::ids::play::clientbound as ids;
// use horizon_protocol::{
    // rust: entity_data::{Particle, ParticleData, Value, serializer},
    // rust: packets::play::{self, Clientbound as C, Serverbound as S},
    // rust: text::{literal, translatable},
}
// use horizon_world::{
    // rust: attachments::Holder,
    // rust: block_collision::BlockCollisionRegistry,
    // rust: block_collision_scan::BlockCollisionScan,
    // rust: collision_context::CollisionContext,
    // rust: nbt::{JavaString, Tag},
    // rust: world_movement::in_range_of_ground,
}
// use std::sync::{Arc, Mutex, atomic::Ordering};

/// GameEvent types (ClientboundGameEventPacket).
    // rust: pub mod chat;
    // rust: pub mod chat_filter;

    // rust: pub mod game_event {
pub const NO_RESPAWN_BLOCK_AVAILABLE: u8 = 0;
pub const START_RAINING: u8 = 1;
pub const STOP_RAINING: u8 = 2;
pub const CHANGE_GAME_MODE: u8 = 3;
pub const RAIN_LEVEL: u8 = 7;
pub const THUNDER_LEVEL: u8 = 8;
pub const GUARDIAN_ELDER_EFFECT: u8 = 10;
pub const IMMEDIATE_RESPAWN: u8 = 11;
pub const LIMITED_CRAFTING: u8 = 12;
pub const LEVEL_CHUNKS_LOAD_START: u8 = 13;
}

pub const HubConfig = struct {
    default_game_mode: i32,
    guest_commands: bool,
    force_game_mode: bool,
    hardcore: bool,
    view_distance: i32,
    simulation_distance: i32,
    dimension: []const u8,
    /// `MinecraftServer.allowFlight`: true except on a dedicated server whose
    /// `allow-flight` is off.
    allow_flight: bool,
    seed: i64,
    max_players: usize,
    /// An integrated server: the owner's level from `ops`, the others' from Allow Commands
    /// and the guests' command access, and the integrated-only commands. Otherwise a
    /// dedicated server: operators from `ops`, the dedicated-only commands.
    integrated: bool,
    /// The shapes of the world's levels (their dimension types).
    levels: crate::chunk::LevelShapes,
};

/// What the other players see of a player's body besides sneaking and
/// sprinting: the pose and the rest of `Entity.DATA_SHARED_FLAGS_ID`.
pub const BodyFlags = struct {
    /// `Entity.isFallFlying`: gliding with elytra.
    gliding: bool,
    /// `Entity.isSwimming` (the swimming flag).
    swimming: bool,
    /// The swimming pose of a player crawling under a block.
    crawling: bool,
    /// The crouching pose, held without sneaking under a low ceiling.
    crouching: bool,
    /// `LivingEntity.isAutoSpinAttack`: Riptide's spin.
    spin_attack: bool,
    /// `Entity.isOnFire`.
    on_fire: bool,
    /// `Entity.isInvisible`: the invisibility effect.
    invisible: bool,
    /// The glowing effect.
    glowing: bool,
};

/// Everything the hub needs from the game for one tick.
pub const TickCtx = struct {
    world: *'a mut World,
    entities: *'a [EntityState],
    next_entity: *'a mut u32,
    /// Where new players appear.
    spawn: [f64,
    difficulty: i32,
    difficulty_locked: bool,
    /// The overworld clock's speed (0 when the day does not advance).
    clock_rate: f32,
    /// TickRateManager: the tick rate and whether the game is frozen.
    tick_rate: f32,
    tick_frozen: bool,
    /// The last step command's broadcast and the remaining ticks for joins.
    tick_steps: crate::clock::StepState,
    /// Block collisions, for ServerGamePacketListenerImpl's moved-wrongly
    /// check (none: moves are not checked against blocks).
    collision: ?*'a BlockCollisionRegistry<'a>,
    /// The level's world border (PlayerList.sendLevelInfo sends it).
    border: *'a crate::worldborder::WorldBorder,
    /// The level's columns still being generated: a column is sent once
    /// each neighbour is loaded or a decorated proto chunk (#4294). None:
    /// every column there is is loaded.
    streaming: ?*'a crate::streaming::Streaming,
};

/// What the gameplay code has to do for a guest.
pub const HostEvent = enum {
    /// A guest entered the world; load their saved state.
    Joined(u32),
    /// A guest left (state to save, entities to drop).
    Left(Box<Guest>),
    Packet(u32, Box<S>),
    /// A guest changed the dominant hand in their client options.
    MainHandChanged(u32, bool),
    /// A guest changed their client language option.
    LocaleChanged(u32, String),
    /// A guest's client finished loading the level around them.
    PlayerLoaded(u32),
    /// A guest changed recipe book settings.
    RecipeBookSettings {,
    conn: u32,
    book: i32,
    open: bool,
    filtering: bool,
    // rust: },
    /// A guest changed sneaking in a player input packet, already applied.
    Sneak {,
    conn: u32,
    sneaking: bool,
    // rust: },
    /// A loaded guest sent their current player input flags.
    Input {,
    conn: u32,
    flags: i32,
    // rust: },
    /// A guest was kicked, with the reason rendered by the hub.
    Kicked {,
    conn: u32,
    player: u128,
    name: String,
    reason: String,
    // rust: },
    /// A guest's client started (`flying`) or stopped flying (their abilities packet), applied to
    /// the guest already: the game tells the mods, which may refuse it.
    Flight {,
    conn: u32,
    flying: bool,
    // rust: },
    /// A chat line to show on the host (already broadcast to the guests);
    /// a dedicated server logs it, `[Not Secure]` unless signed and fresh.
    Chat {,
    line: String,
    secure: bool,
    // rust: },
    /// A chat message a player sent (after it was broadcast), for server mods.
    PlayerChat {,
    sender: u128,
    text: String,
    // rust: },
    /// A player's text the chat filter refused (docs/chat-filter.md): relayed to nobody, for the
    /// game to log and to carry out `action`.
    ChatFiltered {,
    sender: u128,
    name: String,
    place: chat_filter::Place,
    text: String,
        /// The hit's number in the filter's window.
    count: u32,
    action: horizon_chat_filter::Action,
    // rust: },
    /// A server log warning (ServerGamePacketListenerImpl's LOGGER.warn).
    Warn(String),
    /// A server log error (LOGGER.error).
    Error(String),
    /// The anticheat bans this player (`banned-players.json`, then the ban's kick).
    Ban {,
    uuid: u128,
    name: String,
    reason: String,
    // rust: },
};

/// The criteria `CriteriaTriggers.TICK` granted one player.
pub const TickGrants = struct {
    player: u128,
    name: []const u8,
    grants: std.ArrayList(super::advancements::CriterionGrant),
};

/// What one player started and stopped tracking, in order, for the game to
/// tell the mods.
pub const TrackingBatch = struct {
    player: u128,
    name: []const u8,
    events: std.ArrayList(super::entity::TrackEvent),
};

/// A holder whose synced attachments one player is sent whole, because the
/// player started seeing it.
pub const AttachmentSnapshot = struct {
    player: u128,
    holder: Holder,
};

/// Queues `holders` as snapshots for `player`.
    // rust: fn queue_snapshots(
    // rust: snapshots: &mut Vec<AttachmentSnapshot>,
    // rust: player: u128,
    // rust: holders: impl IntoIterator<Item = Holder>,
    // rust: ) {
    // rust: snapshots.extend(
    // rust: holders
    // rust: .into_iter()
    // rust: .map(|holder| AttachmentSnapshot { player, holder }),
    // rust: );
}

/// Moves a guest's tracking events into `out`, one batch, and the entities it
/// started tracking into `snapshots`.
    // rust: fn take_tracking(
    // rust: g: &mut Guest,
    // rust: out: &mut Vec<TrackingBatch>,
    // rust: snapshots: &mut Vec<AttachmentSnapshot>,
    // rust: sync_attachments: bool,
    // rust: ) {
    // rust: let events = g.tracker.take_events();
    // rust: if !events.is_empty() {
    // rust: if sync_attachments {
    // rust: let started = events.iter().filter(|e| e.start);
    // rust: queue_snapshots(
    // rust: snapshots,
    // rust: g.uuid,
    // rust: started.map(|e| Holder::Entity(e.entity as u32)),
    // rust: );
}
    // rust: out.push(TrackingBatch {
    // rust: player: g.uuid,
    // rust: name: g.name.clone(),
    // rust: events,
    // rust: });
}
}

pub const Hub = struct {
    /// Clicks on and closings of native mods' menus, for the game.
    native_menu_events: std.ArrayList(super::menu::NativeMenuEvent),
    /// Kicks waiting for the game thread to notify native mods.
    pending_kicks: std.ArrayList(HostEvent),
    /// `[transfer]` on (a dedicated server's `--transfers`): the players a proxy
    /// said would arrive (`player-expect`). None while it is off.
    transfers: ?super::arrivals::Transfers,
    /// The entities players started and stopped tracking, collected by
    /// `collect_tracking`, for the game to tell the mods.
    native_tracking: std.ArrayList(TrackingBatch),
    /// The holders players started seeing, for the game to send their synced
    /// attachments (`flush_attachment_sync`).
    attachment_snapshots: std.ArrayList(AttachmentSnapshot),
    /// Whether native mods can produce synced attachments.
    sync_attachments: bool,
    /// Criteria `CriteriaTriggers.TICK` granted to players, for the game to
    /// tell the mods.
    native_advancement_grants: std.ArrayList(TickGrants),
    /// Whether any native mod is loaded: `Input` and `Sneak` events only exist for them, so
    /// the hub queues none otherwise. The game sets it before each poll.
    mods_loaded: bool,
    /// Players a native mod hid (`native_hide_player`), by UUID, on or off:
    /// only players of at least that permission level see them, in the
    /// player list, the world and their joining and leaving.
    hidden: crate::fast_hash::FxHashMap<u128,
    lan: Lan,
    config: HubConfig,
    encoder: ChunkEncoder,
    guests: std.ArrayList(Guest),
    // rust: pub(super) sync: Arc<SyncData>,
    ticks: u64,
    /// The next `Guest.vehicle_order`: a rider that boards later sits behind.
    seat_order: u64,
    /// `Level.soundSeedGenerator`: a fresh `nextLong` per `playSound`.
    // rust: pub(super) sound_seeds: Mutex<LegacyRandom>,
    // rust: pub(super) sound_order: Mutex<super::sound_order::SoundOrder>,
    /// The `player_movement_check` and `elytra_movement_check` game rules,
    /// set by the game before each tick.
    movement_checks: (bool,
    /// The anticheat, when `server.toml` turns it on (dedicated servers).
    anticheat: ?*super::anticheat::Anticheat,
    /// The chat filter, when `server.toml` turns it on (dedicated servers).
    chat_filter: ?*horizon_chat_filter::Guard,
    /// The far ring, when `server.toml`'s `max_view_distance` turns it on (dedicated servers).
    far: ?super::far::Far,
    /// The `immediate_respawn` game rule, as the players were last told.
    immediate_respawn: bool,
    /// The `reduced_debug_info` game rule, as the players were last told.
    reduced_debug_info: bool,
    /// The `limited_crafting` game rule, as the players were last told.
    limited_crafting: bool,
    /// An integrated server's owner (`MinecraftServer.isSingleplayerOwner`),
    /// whose moves are never checked.
    singleplayer_owner: ?u128,
    /// The world is superflat (`ServerLevel.isFlat`, a world-wide flag, sent as
    /// `CommonPlayerSpawnInfo.isFlat` in every dimension).
    flat_world: bool,
    /// The world is the Debug preset (`CommonPlayerSpawnInfo.isDebug`).
    debug_world: bool,
    /// Who rides what, set by the game before each tick.
    riding: super::entity::Riding,
    /// The scoreboard's teams, set by the game each tick, for players'
    /// display names.
    teams: std.ArrayList(crate::scoreboard::Team),
    /// Names a server mod shows for players in chat and the Tab list
    /// (`native_set_nickname`), by UUID. Their real name stays everywhere
    /// else: the log, commands, the hover of the shown name.
    nicknames: std::collections::HashMap<u128,
    last_clock: i64,
    last_rate: f32,
    ticking: (f32,
    /// The `tick_steps` count last broadcast.
    stepping: u32,
    weather: (bool,
    /// The clock and weather last sent in the levels not in place, by
    /// dimension (`set_dimension` swaps them with the fields above).
    level_sync: std::collections::HashMap<[]const u8,
    /// Operators and their permission levels (dedicated servers).
    ops: std::collections::HashMap<u128,
    /// `entity-broadcast-range-percentage` (dedicated servers).
    entity_range_percent: i32,
    /// `spawn-protection` (dedicated servers): the radius around the world
    /// spawn that only operators may change.
    spawn_protection: i32,
    /// `chat-spam-threshold-seconds` as a TickThrottler threshold (20 a second):
    /// over it, a guest who is not an operator is kicked. 0 never kicks.
    chat_spam_threshold: i32,
    /// `command-spam-threshold-seconds`, as `chat_spam_threshold`.
    command_spam_threshold: i32,
    /// `server.toml`'s `admin_feedback_to_ops` (dedicated servers): whether
    /// the other operators get a command's `[name: ...]` line (vanilla's
    /// broadcastToAdmins). False keeps it to the console's log.
    admin_feedback_to_ops: bool,
    chat_type: i32,
    dimension_type: i32,
    clock_ids: std.ArrayList(i32),
    item_ids: std::collections::HashMap<*str,
    entity_types: std::collections::HashMap<[]const u8,
    /// Each level's tracked entities, by dimension.
    entities: std::collections::HashMap<[]const u8,
    /// Each level's entities that joined it after its tracking pass, as they
    /// were then, and the server tick they were noted in (`note_joined`).
    joined: std::collections::HashMap<[]const u8,
    /// Each level's fresh entities that joined it during the tick before its
    /// tracking pass (arrows shot by players or dispensers): paired as they
    /// joined (IN_GROUND false), then updated in the next pass.
    fresh_joined: std::collections::HashMap<[]const u8,
    /// The ranges of entity ids taken this tick in the phases vanilla runs
    /// before the level's ChunkMap.tick (`Entities::synced`).
    synced: Vec<(i32,
    /// What one tick of entity tracking sends each guest, kept between ticks.
    entity_out: std.ArrayList(Vec<Vec<u8)>>,
    /// Each placed guest's entities gone this tick, where they were last sent (only while the
    /// prediction records).
    entity_gone: Vec<Vec<[f64,
    /// Server mods' commands, a root in the commands report's format, sent
    /// after vanilla's; the key the game last set them for.
    mod_commands: (serde_json::Value,
};

pub fn string(s: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::String(JavaString::from(s))
}

/// Player.getDisplayName for a player in no team: the name, suggesting
/// `/tell NAME `, showing the player on hover and inserting the name.
pub fn display_name(uuid: u128, name: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let words = [
    // rust: (uuid >> 96) as i32,
    // rust: (uuid >> 64) as i32,
    // rust: (uuid >> 32) as i32,
    // rust: uuid as i32,
    // rust: ];
    // rust: Tag::compound([
    // rust: ("text", string(name)),
    // rust: (
    // rust: "click_event",
    // rust: Tag::compound([
    // rust: ("action", string("suggest_command")),
    // rust: ("command", string(&format!("/tell {name} "))),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "hover_event",
    // rust: Tag::compound([
    // rust: ("action", string("show_entity")),
    // rust: ("id", string("minecraft:player")),
    // rust: ("uuid", Tag::IntArray(words.to_vec())),
    // rust: ("name", string(name)),
    // rust: ]),
    // rust: ),
    // rust: ("insertion", string(name)),
    // rust: ])
}

/// `LivingEntity.DATA_ARROW_COUNT_ID` (12) and `DATA_STINGER_COUNT_ID` (13):
/// the counts of what is stuck in a player, 0 by default.
pub fn stuck_meta(state: *mut EntityState) void {
}
    // rust: for (index, count) in [(12, arrows), (13, stingers)] {
    // rust: if count != 0 {
    // rust: state.meta.push((index, serializer::INT, Value::Int(count)));
}
    // rust: state.defaults.push((index, serializer::INT, Value::Int(0)));
}
}

pub fn frozen_meta(state: *mut EntityState, ticks: i32) void {
}
    // rust: if ticks != 0 {
    // rust: state.meta.push((7, serializer::INT, Value::Int(ticks)));
}
    // rust: state.defaults.push((7, serializer::INT, Value::Int(0)));
}

/// `Player.DATA_SHOULDER_PARROT_LEFT` (19) and `_RIGHT` (20), an
/// `OptionalInt`: 0 for none, else the parrot variant's id plus one.
pub fn shoulder_meta(state: *mut EntityState, shoulders: [?i32; 2]) void {
}
    // rust: for (index, variant) in [(19, shoulders[0]), (20, shoulders[1])] {
    // rust: if let Some(v) = variant {
    // rust: state
    // rust: .meta
    // rust: .push((index, serializer::OPTIONAL_UNSIGNED_INT, Value::Id(v + 1)));
}
    // rust: state
    // rust: .defaults
    // rust: .push((index, serializer::OPTIONAL_UNSIGNED_INT, Value::Id(0)));
}
}

/// The shoulder parrot slots that differ from what the player's client was
/// last sent, as entity data: 0 for none, else the variant's id plus one.
pub fn shoulder_changes(now: [?i32; 2], sent: [?i32; 2]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (19..)
    // rust: .zip(now.into_iter().zip(sent))
    // rust: .filter(|(_, (now, sent))| now != sent)
    // rust: .map(|(index, (now, _))| {
    // rust: let id = now.map_or(0, |v| v + 1);
    // rust: (index, serializer::OPTIONAL_UNSIGNED_INT, Value::Id(id))
    // rust: })
    // rust: .collect()
}

    // rust: impl Hub {
    /// Player.getDisplayName: the name formatted for the player's team
    /// (PlayerTeam.formatNameForTeam), suggesting `/tell NAME `, showing the
    /// player on hover and inserting the name.
    /// A nickname (`nicknames`) takes the name's place in the text; the
    /// hover, the suggested `/tell` and the insertion keep the real name.
pub fn player_display_name(self: *Self, uuid: u128, name: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shown = self.nicknames.get(&uuid).map_or(name, String::as_str);
    // rust: let team = self.teams.iter().find(|t| t.players.contains(name));
    // rust: if team.is_none() && shown == name {
    // rust: return display_name(uuid, name);
}
    // rust: let mut c = match team {
    // rust: Some(team) => team.formatted_name_comp(&crate::scoreboard::literal(shown)),
    // rust: None => serde_json::json!({ "text": shown }),
}
    // rust: c["click_event"] =
    // rust: serde_json::json!({"action": "suggest_command", "command": format!("/tell {name} ")});
    // rust: c["hover_event"] = serde_json::json!({"action": "show_entity", "id": "minecraft:player",
    // rust: "uuid": horizon_protocol::crypto::uuid_string(uuid), "name": name});
    // rust: c["insertion"] = name.into();
    // rust: crate::scoreboard::component_tag(&c)
}
}

/// A yellow translation of player names (`multiplayer.player.joined`).
pub fn yellow_names(key: []const u8, names: std.ArrayList(Tag)) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([
    // rust: ("translate", string(key)),
    // rust: ("with", Tag::List(names)),
    // rust: ("color", string("yellow")),
    // rust: ])
}

/// An entity type's registry id, remembered once looked up.
    // rust: fn entity_type(
    // rust: types: &mut std::collections::HashMap<String, i32>,
    // rust: sync: &SyncData,
    // rust: kind: &str,
    // rust: ) -> Option<i32> {
    // rust: if let Some(id) = types.get(kind) {
    // rust: return Some(*id);
}
    // rust: let id = sync.builtin.get("minecraft:entity_type")?.id(kind)?;
    // rust: types.insert(kind.to_owned(), id);
    // rust: Some(id)
}

/// ChunkTrackingView.contains: the chunks a player at (cx, cz) with view
/// distance `r` is sent (isWithinDistance with the neighbours' buffer).
pub fn tracked(cx: i32, cz: i32, r: i32, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dx = i64::from(((x - cx).abs() - 2).max(0));
    // rust: let dz = i64::from(((z - cz).abs() - 2).max(0));
    // rust: dx * dx + dz * dz < i64::from(r) * i64::from(r)
}

/// The view's queue around a new centre: the queued chunks still tracked, then
/// the tracked ones neither sent nor queued, closest first (a stable sort, so
/// equally close chunks keep their order).
    // rust: fn requeue(
    // rust: queue: &mut Vec<(i32, i32)>,
    // rust: sent: &crate::fast_hash::FxHashSet<(i32, i32)>,
    // rust: center: (i32, i32),
    // rust: r: i32,
    // rust: ) {
    // rust: requeue_ring(queue, sent, center, 0, r);
}

/// `requeue` for the chunks tracked at `r` and not at `inner` (0: none): the far ring's.
    // rust: fn requeue_ring(
    // rust: queue: &mut Vec<(i32, i32)>,
    // rust: sent: &crate::fast_hash::FxHashSet<(i32, i32)>,
    // rust: (cx, cz): (i32, i32),
    // rust: inner: i32,
    // rust: r: i32,
    // rust: ) {
    // rust: let tracked = |x, z| tracked(cx, cz, r, x, z) && !tracked(cx, cz, inner, x, z);
    // rust: queue.retain(|&(x, z)| tracked(x, z));
    // A walking player changes chunk every few ticks with hundreds of chunks
    // queued: a set, not a scan of the queue for each of the view's chunks.
    // rust: let mut queued: crate::fast_hash::FxHashSet<(i32, i32)> = queue.iter().copied().collect();
    // rust: for dz in -r - 2..=r + 2 {
    // rust: for dx in -r - 2..=r + 2 {
    // rust: let key = (cx + dx, cz + dz);
    // rust: if tracked(key.0, key.1) && !sent.contains(&key) && queued.insert(key) {
    // rust: queue.push(key);
}
}
}
    // rust: queue.sort_by_key(|&(x, z)| i64::from(x - cx).pow(2) + i64::from(z - cz).pow(2));
}

/// A player's next chunks (`Hub::next_batch`), with their places in its queues: the view's, then
/// the far ring's (none: the save has none to send).
pub const Batch = struct {
    near: Vec<(usize,
    far: Vec<(usize,
};

/// A far chunk to send: the level's own while it holds it, else what the save's readers made.
pub const Column = enum {
    Level(&'w Chunk),
    Saved(Arc<[u8]>),
};

/// A body in a batch: a column of `Columns`, or one read from the save.
pub const Body = enum {
    Level(usize),
    Saved(Arc<[u8]>),
};

/// The level's columns a tick's batches send, each once, with the number of batches taking it.
pub const Columns = struct {
    chunks: std.ArrayList(*'w Chunk),
    uses: std.ArrayList(usize),
    index: crate::fast_hash::FxHashMap<(i32,
};

    // rust: impl<'w> Columns<'w> {
pub fn add(self: *Self, chunk: *'w Chunk) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let j = *self.index.entry((chunk.x, chunk.z)).or_insert_with(|| {
    // rust: self.chunks.push(chunk);
    // rust: self.uses.push(0);
    // rust: self.chunks.len() - 1
    // rust: });
    // rust: self.uses[j] += 1;
    // rust: j
}
}

/// What a level's players were last told of its clock and weather.
pub const LevelSync = struct {
    last_clock: i64,
    last_rate: f32,
    weather: (bool,
};

    // rust: impl Default for LevelSync {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: last_clock: i64::MIN,
    // rust: last_rate: 0.0,
    // rust: weather: (false, 0.0, 0.0),
}
}
}

    // rust: impl Hub {
pub fn new(lan: Lan, sync: *SyncData, encoder: ChunkEncoder, config: HubConfig) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chat_type = sync
    // rust: .id("minecraft:chat_type", "minecraft:chat")
    // rust: .unwrap_or(0);
    // rust: let dimension_type = sync
    // rust: .id("minecraft:dimension_type", &config.dimension)
    // rust: .unwrap_or(0);
    // rust: let clock_ids = (0..sync.dynamic.len("minecraft:world_clock") as i32).collect();
    // rust: let mut encoder = encoder;
    // rust: encoder.set_dimension(config.levels.get(&config.dimension));
    // rust: Self {
    // rust: lan,
    // rust: config,
    // rust: encoder,
    // rust: guests: Vec::new(),
    // rust: sync,
    // rust: ticks: 0,
    // rust: seat_order: 0,
    // rust: sound_seeds: Mutex::new(LegacyRandom::new(crate::sound_engine::unique_seed())),
    // rust: sound_order: Mutex::default(),
    // rust: immediate_respawn: false,
    // rust: reduced_debug_info: false,
    // rust: limited_crafting: false,
    // rust: movement_checks: (true, true),
    // rust: anticheat: None,
    // rust: chat_filter: None,
    // rust: far: None,
    // rust: singleplayer_owner: None,
    // rust: flat_world: false,
    // rust: debug_world: false,
    // rust: riding: Default::default(),
    // rust: last_clock: i64::MIN,
    // rust: last_rate: 0.0,
    // rust: ticking: (20.0, false),
    // rust: stepping: 0,
    // rust: ops: Default::default(),
    // rust: entity_range_percent: 100,
    // rust: spawn_protection: 0,
    // rust: chat_spam_threshold: 0,
    // rust: command_spam_threshold: 0,
    // rust: admin_feedback_to_ops: true,
    // rust: weather: (false, 0.0, 0.0),
    // rust: level_sync: Default::default(),
    // rust: chat_type,
    // rust: dimension_type,
    // rust: clock_ids,
    // rust: item_ids: Default::default(),
    // rust: entity_types: Default::default(),
    // rust: entities: Default::default(),
    // rust: joined: Default::default(),
    // rust: fresh_joined: Default::default(),
    // rust: synced: Vec::new(),
    // rust: entity_out: Vec::new(),
    // rust: entity_gone: Vec::new(),
    // rust: mod_commands: (serde_json::Value::Null, None),
    // rust: native_menu_events: Vec::new(),
    // rust: pending_kicks: Vec::new(),
    // rust: transfers: None,
    // rust: native_tracking: Vec::new(),
    // rust: attachment_snapshots: Vec::new(),
    // rust: sync_attachments: false,
    // rust: native_advancement_grants: Vec::new(),
    // rust: mods_loaded: false,
    // rust: hidden: Default::default(),
    // rust: teams: Vec::new(),
    // rust: nicknames: std::collections::HashMap::new(),
}
}

pub fn guest(self: *Self, conn: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.guests.iter().find(|g| g.conn == conn)
}
pub fn guest_mut(self: *Self, conn: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.guests.iter_mut().find(|g| g.conn == conn)
}

    /// The network id of a name in a built-in or synchronized registry.
pub fn registry_id(self: *Self, registry: []const u8, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync.id(registry, name)
}

    /// The name of a network id in a built-in registry.
pub fn registry_name(self: *Self, registry: []const u8, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync.builtin.get(registry)?.name(id)
}

pub fn item_id(self: *Self, item: **str) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(id) = self.item_ids.get(item) {
    // rust: return *id;
}
    // rust: let id = self
    // rust: .sync
    // rust: .builtin
    // rust: .get("minecraft:item")
    // rust: .and_then(|i| i.id(item))
    // rust: .unwrap_or(0);
    // rust: self.item_ids.insert(item.clone(), id);
    // rust: id
}
pub fn stack(self: *Self, s: *?ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let item = s.as_ref()?.item.clone();
    // rust: let id = self.item_id(&item);
    // rust: let sync = self.sync.clone();
        // The stacks inside it (a bundle's contents, a crossbow's projectiles)
        // have ids of their own.
    // rust: let item_id = |name: &str| {
    // rust: if name == &*item {
    // rust: return id;
}
    // rust: sync.builtin
    // rust: .get("minecraft:item")
    // rust: .and_then(|i| i.id(name))
    // rust: .unwrap_or(0)
}
    // rust: stack_to_network(item_id, |registry, name| sync.id(registry, name), s)
}

    /// `PlayerList.broadcastAll`: send a packet to every placed player.
pub fn broadcast(self: *Self, packet: *C) void {
}
    // rust: if let C::RemoveEntities(p) = packet {
    // rust: for guest in self.guests.iter().filter(|g| g.placed) {
    // rust: self.send_ordered_removal(guest, &p.ids);
}
    // rust: return;
}
    // rust: let body = packet.encode();
    // rust: for g in self.guests.iter().filter(|g| g.placed) {
    // rust: g.sender.send(body.clone());
}
}
    /// [`Self::broadcast`] to the held players as well, which keep a picture of
    /// the players and the entities while they wait for their hand-over.
pub fn broadcast_watching(self: *Self, packet: *C) void {
}
    // rust: let body = packet.encode();
    // rust: for g in self.guests.iter().filter(|g| g.placed || g.held) {
    // rust: g.sender.send(body.clone());
}
}
    /// MinecraftServer.onGameRuleChanged: every player is told when
    /// `immediate_respawn` changes; a joining player's Login carries it.
pub fn set_immediate_respawn(self: *Self, on: bool) void {
}
    // rust: if self.immediate_respawn != on {
    // rust: self.immediate_respawn = on;
    // rust: self.broadcast(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::IMMEDIATE_RESPAWN,
    // rust: param: if on { 1.0 } else { 0.0 },
    // rust: }));
}
}
    /// MinecraftServer.onGameRuleChanged: every player gets entity event 22
    /// (reduced) or 23 (full) for themselves when `reduced_debug_info`
    /// changes; a joining player's Login carries it.
pub fn set_reduced_debug_info(self: *Self, on: bool) void {
}
    // rust: if self.reduced_debug_info != on {
    // rust: self.reduced_debug_info = on;
    // rust: for g in self.guests.iter().filter(|g| g.placed) {
    // rust: g.send(&C::EntityEvent(play::EntityEvent {
    // rust: id: g.entity_id,
    // rust: event: if on { 22 } else { 23 },
    // rust: }));
}
}
}
    /// `MinecraftServer.onGameRuleChanged`: every player is told when
    /// `limited_crafting` changes; a joining player's Login carries it.
pub fn set_limited_crafting(self: *Self, on: bool) void {
}
    // rust: if self.limited_crafting != on {
    // rust: self.limited_crafting = on;
    // rust: self.broadcast(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::LIMITED_CRAFTING,
    // rust: param: if on { 1.0 } else { 0.0 },
    // rust: }));
}
}
    /// PlayerList.setViewDistance: every player is told the new radius,
    /// and each one's chunks follow it, up to what they asked for
    /// (ChunkMap.getPlayerViewDistance).
pub fn set_view_distance(self: *Self, distance: i32) void {
}
    // rust: self.config.view_distance = distance;
    // rust: let distance = self.chunk_radius();
    // rust: self.broadcast(&C::SetChunkCacheRadius(play::Distance { distance }));
    // rust: for g in &mut self.guests {
            // Mth.clamp(requested, 2, serverViewDistance): Java's max then min order also
            // handles a management value below two without panicking when the bounds cross.
    // rust: g.view_distance = i32::from(g.info.view_distance)
    // rust: .max(2)
    // rust: .min(self.config.view_distance);
    // rust: g.center = None;
}
}
    /// The radius the players are told (Login, SetChunkCacheRadius): with the far ring on, its
    /// `max_view_distance`, so that a client keeps and draws what it is sent past the view.
pub fn chunk_radius(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let view = self.config.view_distance;
    // rust: self.far.as_ref().map_or(view, |far| far.max.max(view))
}
    /// How far a player is sent chunks: its view, and with the far ring on, as far as it asked for
    /// up to `max_view_distance`.
pub fn reach(self: *Self, g: *Guest) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.far.as_ref().map_or(g.view_distance, |far| {
    // rust: i32::from(g.info.view_distance)
    // rust: .min(far.max)
    // rust: .max(g.view_distance)
    // rust: })
}
    /// Where the far ring reads the level in place from: its saves, before each of its ticks.
pub fn far_level(self: *Self, save: **crate::save::SaveDir) void {
}
    // rust: if let Some(far) = self.far.as_mut() {
    // rust: far.set_level(&self.config.dimension, save, &self.encoder);
}
}
    /// PlayerList.setSimulationDistance.
pub fn set_simulation_distance(self: *Self, distance: i32) void {
}
    // rust: self.config.simulation_distance = distance;
    // rust: self.broadcast(&C::SetSimulationDistance(play::Distance { distance }));
}
    /// Whether a guest is placed in the level in place (`config.dimension`).
pub fn here(self: *Self, g: *Guest) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: g.placed && g.dimension == self.config.dimension
}
    /// How many passes the level in place's entity tracking has run (None
    /// before its first).
pub fn tracking_ticks(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entities
    // rust: .get(&self.config.dimension)
    // rust: .map(Entities::ticks)
}
    /// Whether a guest is sent the level in place: the players placed in it, and
    /// the held ones, which look at it without being part of it.
pub fn watches(self: *Self, g: *Guest) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (g.placed || g.held) && g.dimension == self.config.dimension
}
    /// The chunk under each player the level in place has to keep loaded: the players placed in
    /// it and the held ones, which are sent its chunks too ([`Self::watches`]), whose `loads`
    /// says so (a spectator may not load chunks). A server with only a held player must load
    /// and generate the world around it, or the player waits for ever for its world.
pub fn loading_chunks(self: *Self, loads: impl Fn(*Guest) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.guests
    // rust: .iter()
    // rust: .filter(|g| self.watches(g) && loads(g))
    // rust: .map(Guest::chunk)
    // rust: .collect()
}
    /// `PlayerList.broadcastAll(packet, dimension)`: the players in the
    /// level in place.
pub fn broadcast_level(self: *Self, packet: *C) void {
}
    // rust: let body = packet.encode();
    // rust: for g in self.guests.iter().filter(|g| self.watches(g)) {
    // rust: g.sender.send(body.clone());
}
}
    /// `DedicatedServer.sendLowDiskSpaceWarning`: the players with
    /// `PermissionLevel.ADMINS` (3) or more get `ClientboundLowDiskSpaceWarningPacket`.
pub fn send_low_disk_space_warning(self: *Self) void {
}
    // rust: let body = C::LowDiskSpaceWarning(horizon_protocol::packets::Empty).encode();
    // rust: for g in self.guests.iter().filter(|g| g.placed && g.permission >= 3) {
    // rust: g.sender.send(body.clone());
}
}
pub fn broadcast_except(self: *Self, conn: u32, packet: *C) void {
}
    // rust: let body = packet.encode();
    // rust: for g in self.guests.iter().filter(|g| g.placed && g.conn != conn) {
    // rust: g.sender.send(body.clone());
}
}
    /// PlayerList.broadcastSystemMessage.
pub fn system_message(self: *Self, content: Tag) void {
}
    // rust: self.broadcast(&C::SystemChat(play::SystemChat {
    // rust: content,
    // rust: overlay: false,
    // rust: }));
}
    /// A system message for the guests `hears` picks by name
    /// (`PlayerList.broadcastSystemToTeam` and its kin).
pub fn system_message_to(self: *Self, content: Tag, hears: impl Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let body = C::SystemChat(play::SystemChat {
    // rust: content,
    // rust: overlay: false,
    // rust: })
    // rust: .encode();
    // rust: for g in self.guests.iter().filter(|g| g.placed && hears(&g.name)) {
    // rust: g.sender.send(body.clone());
}
}
    /// `ServerPlayer.sendSystemMessage` to the guest with `uuid`, in any
    /// dimension.
pub fn system_message_to_player(self: *Self, uuid: u128, content: Tag) void {
}
    // rust: let body = C::SystemChat(play::SystemChat {
    // rust: content,
    // rust: overlay: false,
    // rust: })
    // rust: .encode();
    // rust: for g in self.guests.iter().filter(|g| g.placed && g.uuid == uuid) {
    // rust: g.sender.send(body.clone());
}
}
    /// `ServerPlayer.sendOverlayMessage` to every guest (the action bar).
pub fn overlay_message(self: *Self, content: Tag) void {
}
    // rust: self.broadcast(&C::SystemChat(play::SystemChat {
    // rust: content,
    // rust: overlay: true,
    // rust: }));
}
    /// A chat message from the host (a disguised chat: the host has no
    /// connection to sign with).
pub fn chat(self: *Self, sender: []const u8, text: []const u8) void {
}
    // rust: self.broadcast(&C::DisguisedChat(play::DisguisedChat {
    // rust: message: literal(text),
    // rust: chat_type: play::ChatTypeBound {
    // rust: chat_type: self.chat_type,
    // rust: name: literal(sender),
    // rust: target: None,
    // rust: },
    // rust: }));
}
    /// ListPlayersCommand's reply: the players in join order (the host of a
    /// LAN world first), as display names or names with ids, joined by
    /// gray commas (ComponentUtils.formatList).
pub fn list_reply(self: *Self, uuids: bool) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let players: Vec<(u128, &str)> = self
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.placed)
    // rust: .map(|g| (g.uuid, g.name.as_str()))
    // rust: .collect();
    // rust: let format = |(uuid, name): (u128, &str)| {
    // rust: if uuids {
    // rust: Tag::compound([
    // rust: ("translate", string("commands.list.nameAndId")),
    // rust: (
    // rust: "with",
    // rust: Tag::List(vec![
    // rust: string(name),
    // rust: string(&horizon_protocol::crypto::uuid_string(uuid)),
    // rust: ]),
    // rust: ),
    // rust: ])
    // rust: } else {
    // rust: display_name(uuid, name)
}
}
    // rust: let names = match players.len() {
    // rust: 0 => string(""),
    // rust: 1 => format(players[0]),
    // rust: _ => {
    // rust: let mut extra = Vec::new();
    // rust: for (k, p) in players.iter().enumerate() {
    // rust: if k > 0 {
    // rust: extra.push(Tag::compound([
    // rust: ("text", string(", ")),
    // rust: ("color", string("gray")),
    // rust: ]));
}
    // rust: extra.push(format(*p));
}
    // rust: Tag::compound([("text", string("")), ("extra", Tag::List(extra))])
}
}
    // rust: Tag::compound([
    // rust: ("translate", string("commands.list.players")),
    // rust: (
    // rust: "with",
    // rust: Tag::List(vec![
    // rust: Tag::Int(players.len() as i32),
    // rust: Tag::Int(self.lan.shared.max_players() as i32),
    // rust: names,
    // rust: ]),
    // rust: ),
    // rust: ])
}

    /// SayCommand from a source without a player: a disguised chat of type
    /// say_command named after the source.
pub fn say(self: *Self, source: []const u8, text: []const u8) void {
}
    // rust: let chat_type = self
    // rust: .sync
    // rust: .id("minecraft:chat_type", "minecraft:say_command")
    // rust: .unwrap_or(self.chat_type);
    // rust: self.broadcast(&C::DisguisedChat(play::DisguisedChat {
    // rust: message: literal(text),
    // rust: chat_type: play::ChatTypeBound {
    // rust: chat_type,
    // rust: name: literal(source),
    // rust: target: None,
    // rust: },
    // rust: }));
}
    /// Disconnect a guest with a reason (ServerGamePacketListenerImpl.disconnect).
pub fn kick(self: *Self, conn: u32, reason: Tag) void {
}
        // The log's "lost connection" line gives the reason, as vanilla's.
    // rust: let text = self.english(&reason);
    // rust: if let Some(g) = self.guest_mut(conn) {
    // rust: g.left_reason = text.clone();
    // rust: let (player, name) = (g.uuid, g.name.clone());
    // rust: g.sender.disconnect(reason);
    // rust: self.pending_kicks.push(HostEvent::Kicked {
    // rust: conn,
    // rust: player,
    // rust: name,
    // rust: reason: text,
    // rust: });
}
}

    /// `TransferCommand.transfer`: the guest's client is handed to another
    /// server (`ClientboundTransferPacket`, the play state's `Transfer`); the
    /// client closes the connection and logs in there. Nothing disconnects the
    /// player here: as in vanilla, the close comes from the client.
pub fn transfer(self: *Self, conn: u32, host: []const u8, port: i32) void {
}
    // rust: self.send_to(
    // rust: conn,
    // rust: &C::Transfer(horizon_protocol::packets::configuration::Transfer {
    // rust: host: host.to_owned(),
    // rust: port,
    // rust: }),
    // rust: );
}

    /// Disconnects the held player `uuid` and nothing else: no save (it was
    /// never placed), no word to anyone (no one was told of it). Returns whether
    /// there was one.
pub fn drop_held(self: *Self, uuid: u128) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(g) = self
    // rust: .guests
    // rust: .iter_mut()
    // rust: .find(|g| g.uuid == uuid && g.held && !g.placed)
    // rust: else {
    // rust: return false;
}
        // Neither a confirm nor an import may take it while its connection closes.
    // rust: g.imported = false;
    // rust: if g.left_reason.is_empty() {
    // rust: g.left_reason = "dropped before its hand-over".to_owned();
}
    // rust: g.sender
    // rust: .disconnect(translatable("multiplayer.disconnect.generic", &[]));
    // rust: true
}

    /// Lets go of what a proxy that stopped answering left behind: the players
    /// it said would come and did not, the held players whose hand-over never
    /// finished, and the freezes no hand-over ended. None may last for ever, and
    /// a held player goes without a word to anyone, since no one was told of it.
pub fn expire_arrivals(self: *Self, events: *mut std.ArrayList(HostEvent)) void {
}
        // Off: nothing to do (and no player can be frozen).
    // rust: let Some(transfers) = &self.transfers else {
    // rust: return;
}
    // rust: for uuid in transfers.table().expire(std::time::Instant::now()) {
    // rust: events.push(HostEvent::Warn(format!(
    // rust: "player {} was expected from another server and never came",
    // rust: horizon_protocol::crypto::uuid_string(uuid)
    // rust: )));
}
    // rust: let (max, max_hold) = (
    // rust: transfers.settings.max_freeze_ticks,
    // rust: transfers.settings.max_hold_ticks,
    // rust: );
        // Not one already kicked or dropped: its connection may take a while to close,
        // and it must not be kicked (and reported) again on every tick.
    // rust: let stale: Vec<u32> = self
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| {
    // rust: g.held
    // rust: && !g.placed
    // rust: && g.left_reason.is_empty()
    // rust: && super::arrivals::held_too_long(g.held_since, self.ticks, max_hold)
    // rust: })
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in stale {
    // rust: if let Some(g) = self.guest(conn) {
    // rust: events.push(HostEvent::Warn(format!(
    // rust: "{} was held for {max_hold} ticks and the hand-over never finished: dropped",
    // rust: g.name,
    // rust: )));
}
    // rust: self.kick(conn, translatable("disconnect.timeout", &[]));
}
    // rust: for g in &mut self.guests {
    // rust: let Some(h) = &g.handover else {
    // rust: continue;
}
            // A frozen player takes no damage, but the void and `/kill` still kill: its
            // record is then not what is left of it, and `player-release moved` must fail.
    // rust: if g.dead {
    // rust: g.handover = None;
    // rust: events.push(HostEvent::Warn(format!(
    // rust: "{} died while frozen for a hand-over: the hand-over is over",
    // rust: g.name,
    // rust: )));
    // rust: } else if super::arrivals::frozen_too_long(h.since, self.ticks, max) {
    // rust: g.handover = None;
    // rust: events.push(HostEvent::Warn(format!(
    // rust: "{} was frozen for a hand-over for {max} ticks and nothing finished it: let go",
    // rust: g.name,
    // rust: )));
}
}
}

    /// Whether a player of `permission` sees the player `uuid`: not one a
    /// native mod hid from players below a higher level.
pub fn sees(self: *Self, permission: u8, uuid: u128) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hidden
    // rust: .get(&uuid)
    // rust: .is_none_or(|&level| permission >= level)
}

    /// The player lists after `hidden` or a permission changed: each placed
    /// player loses the players hidden from it (ClientboundPlayerInfoRemove)
    /// and gets back those it sees again (an ADD_PLAYER entry). A change
    /// checks the client's entity pairs again, so the tracker follows too.
    /// Nothing runs while nobody is hidden.
pub fn sync_hidden(self: *Self) void {
}
    // rust: if self.hidden.is_empty() && self.guests.iter().all(|g| g.tab_hidden.is_empty()) {
    // rust: return;
}
    // rust: let candidates: Vec<usize> = (0..self.guests.len())
    // rust: .filter(|&j| {
    // rust: let u = self.guests[j].uuid;
    // rust: self.guests[j].placed
    // rust: && (self.hidden.contains_key(&u)
    // rust: || self.guests.iter().any(|g| g.tab_hidden.contains(&u)))
    // rust: })
    // rust: .collect();
    // rust: for i in 0..self.guests.len() {
    // rust: if !self.guests[i].placed {
    // rust: continue;
}
    // rust: for &j in &candidates {
    // rust: let (viewer, other) = (&self.guests[i], &self.guests[j]);
    // rust: if i == j {
    // rust: continue;
}
    // rust: let hide = !self.sees(viewer.permission, other.uuid);
    // rust: if hide == viewer.tab_hidden.contains(&other.uuid) {
    // rust: continue;
}
    // rust: let packet = if hide {
    // rust: C::PlayerInfoRemove(play::PlayerInfoRemove {
    // rust: uuids: vec![other.uuid],
    // rust: })
    // rust: } else {
    // rust: C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: Self::INFO_ACTIONS,
    // rust: entries: vec![self.player_info(
    // rust: other.uuid,
    // rust: &other.name,
    // rust: other.game_mode,
    // rust: other.latency.load(Ordering::Relaxed),
    // rust: )],
    // rust: })
}
    // rust: let uuid = other.uuid;
    // rust: let viewer = &mut self.guests[i];
    // rust: viewer.send(&packet);
    // rust: if hide {
    // rust: viewer.tab_hidden.insert(uuid);
    // rust: } else {
    // rust: viewer.tab_hidden.remove(&uuid);
}
    // rust: viewer.moved = true;
}
}
}

pub fn player_info(self: *Self, uuid: u128, name: []const u8, mode: i32, latency: i32) p {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let guest = self.guests.iter().find(|g| g.uuid == uuid);
    // rust: play::PlayerInfo {
    // rust: uuid,
    // rust: name: Some(name.to_owned()),
    // rust: properties: guest
    // rust: .map(|g| {
    // rust: listed_properties(
    // rust: &g.properties,
    // rust: self.singleplayer_owner == Some(g.uuid),
    // rust: self.lan.shared.config.owner_profile.as_deref(),
    // rust: )
    // rust: })
    // rust: .unwrap_or_default(),
    // rust: chat_session: guest.and_then(|g| g.chain.session()).map(|s| s.data()),
    // rust: game_mode: Some(mode),
    // rust: listed: Some(true),
    // rust: latency: Some(latency),
    // rust: display_name: Some(self.nicknames.get(&uuid).map(|n| literal(n))),
    // rust: list_order: Some(0),
    // rust: show_hat: Some(guest.is_none_or(|g| g.info.model_customisation & 0x40 != 0)),
}
}
    /// ClientboundPlayerInfoUpdatePacket.createPlayerInitializing: every action.
pub const INFO_ACTIONS: u8 = 0xFF;

    // ---- joining -------------------------------------------------------

    /// `CommonPlayerSpawnInfo`, with the player's `portalCooldown`.
pub fn spawn_info(self: *Self, i: usize, portal_cooldown: i32) p {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let g = &self.guests[i];
    // rust: play::SpawnInfo {
    // rust: dimension_type: self.dimension_type,
    // rust: dimension: self.config.dimension.clone(),
    // rust: seed: horizon_core::biome::obfuscate_seed(self.config.seed),
    // rust: game_type: g.game_mode,
    // rust: previous_game_type: None,
    // rust: debug: self.debug_world,
    // rust: flat: self.flat_world,
            // Player.getLastDeathLocation.
    // rust: last_death: g
    // rust: .last_death
    // rust: .as_ref()
    // rust: .map(|(dimension, pos)| play::GlobalPos {
    // rust: dimension: dimension.clone(),
    // rust: pos: *pos,
    // rust: }),
    // rust: portal_cooldown,
    // rust: sea_level: 63,
}
}

pub fn admit(self: *Self, j: super::Joined, ctx: *mut TickCtx) u {
    // Implementation ported from Horizon
    return undefined;
}
        // The game's ids are taken by incrementing first: the current value
        // is the last id in use (the host's own, right after opening to LAN).
    // rust: *ctx.next_entity += 1;
    // rust: let entity_id = *ctx.next_entity as i32;
    // rust: let conn = j.conn;
    // rust: let mut guest = Guest::new(j, entity_id, ctx.spawn, self.config.view_distance);
    // rust: guest.last_action_tick = self.ticks;
    // rust: guest.game_mode = self.config.default_game_mode;
    // rust: guest.permission = self.default_permission(guest.uuid);
    // rust: guest.joined_tick = self.ticks;
    // rust: guest.position = ctx.spawn;
    // rust: guest.previous_position = ctx.spawn;
    // rust: guest.dimension = self.config.dimension.clone();
    // rust: self.guests.push(guest);
    // rust: conn
}

    /// The permission level a player gets: an integrated server gives every
    /// guest the game masters' level when commands are allowed
    /// (IntegratedServer.setGuestCommandAccess); a dedicated server its
    /// operators' level (`ops`).
pub fn default_permission(self: *Self, uuid: u128) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.config.integrated {
            // IntegratedServer.getProfilePermissions / getCustomPermissionLevel.
    // rust: let guests = if self.config.guest_commands { 2 } else { 0 };
    // rust: self.ops.get(&uuid).copied().unwrap_or(guests)
    // rust: } else {
    // rust: self.ops.get(&uuid).copied().unwrap_or(0)
}
}

    /// The levels of a server, in MinecraftServer.levelKeys order.
pub fn level_keys() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ["overworld", "the_end", "the_nether"]
    // rust: .map(|l| format!("minecraft:{l}"))
    // rust: .to_vec()
}

    /// PlayerList.placeNewPlayer for a guest whose saved state is loaded.
pub fn place_new_player(self: *Self, conn: u32, ctx: *mut TickCtx) void {
}
    // rust: let Some(i) = self.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let (name, uuid, entity_id, mode) = {
    // rust: let g = &self.guests[i];
    // rust: (g.name.clone(), g.uuid, g.entity_id, g.game_mode)
}
        // A player whose login used up a proxy's expectation (`arrivals`, as the
        // login started) is held: it gets the whole join sequence, so it can build
        // its picture of the world, but no one else is told about it.
    // rust: if self.guests[i].expected {
    // rust: let g = &mut self.guests[i];
    // rust: g.held = true;
    // rust: g.held_since = self.ticks;
}
    // rust: let held = self.guests[i].held;
    // rust: let g = &self.guests[i];
    // rust: g.send(&C::Login(play::Login {
    // rust: player_id: entity_id,
    // rust: hardcore: self.config.hardcore,
    // rust: levels: Self::level_keys(),
    // rust: max_players: self.config.max_players as i32,
    // rust: chunk_radius: self.chunk_radius(),
    // rust: simulation_distance: self.config.simulation_distance,
    // rust: reduced_debug_info: self.reduced_debug_info,
    // rust: show_death_screen: !self.immediate_respawn,
    // rust: limited_crafting: self.limited_crafting,
    // rust: spawn: self.spawn_info(i, 0),
            // MinecraftServer.usesAuthentication, enforceSecureProfile.
    // rust: online_mode: self.lan.shared.config.online.is_some(),
    // rust: enforces_secure_chat: self.enforces_secure_chat(),
    // rust: }));
    // rust: g.send(&C::ChangeDifficulty(play::ChangeDifficulty {
    // rust: difficulty: ctx.difficulty,
    // rust: locked: ctx.difficulty_locked,
    // rust: }));
    // rust: g.send(&g.abilities());
    // rust: g.send(&C::SetHeldSlot(play::SetHeldSlot {
    // rust: slot: g.selected as i32,
    // rust: }));
        // PlayerList.placeNewPlayer: ClientboundUpdateRecipesPacket.
    // rust: g.send(&raw(ids::UPDATE_RECIPES, self.sync.recipes.clone()));
        // OnDatapackSyncEvent.sendRecipes: the recipes the native mods asked
        // for, to a Horizon client only.
    // rust: if g.brand == "horizon" {
    // rust: send_recipe_content(g);
}
        // PlayerList.sendPlayerPermissionLevel, then the recipe book.
    // rust: self.send_permission_level(i);
    // rust: self.send_initial_recipe_book(i);
        // PlayerList.placeNewPlayer broadcasts the join line before
        // players.add: the others read it, the newcomer doesn't (nor those
        // a native mod hides it from). A held player is not announced, and
        // not placed.
    // rust: if !held {
    // rust: let joined = C::SystemChat(play::SystemChat {
    // rust: content: yellow_names(
    // rust: "multiplayer.player.joined",
    // rust: vec![self.player_display_name(self.guests[i].uuid, &name)],
    // rust: ),
    // rust: overlay: false,
    // rust: })
    // rust: .encode();
    // rust: for g in self.guests.iter().filter(|g| g.placed && g.conn != conn) {
    // rust: if self.sees(g.permission, uuid) {
    // rust: g.sender.send(joined.clone());
}
}
    // rust: self.guests[i].placed = true;
}
    // rust: self.resend_teleport(i, None);
    // rust: let g = &self.guests[i];
    // rust: g.send(&C::ServerData(play::ServerData {
    // rust: motd: literal(&self.lan.shared.motd()),
    // rust: icon: self.lan.shared.config.favicon.clone(),
    // rust: }));
        // The player list: everyone already here, then the newcomer to all.
    // rust: let mut entries = Vec::new();
        // Players a native mod hid from the newcomer stay out of its list,
        // and a hidden newcomer out of theirs.
    // rust: let permission = self.guests[i].permission;
    // rust: let mut hidden = Vec::new();
    // rust: for o in self.guests.iter().filter(|o| o.conn != conn && o.placed) {
    // rust: if !self.sees(permission, o.uuid) {
    // rust: hidden.push(o.uuid);
    // rust: continue;
}
    // rust: entries.push(self.player_info(
    // rust: o.uuid,
    // rust: &o.name,
    // rust: o.game_mode,
    // rust: o.latency.load(Ordering::Relaxed),
    // rust: ));
}
    // rust: self.guests[i].tab_hidden.extend(hidden);
    // rust: self.guests[i].send(&C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: Self::INFO_ACTIONS,
    // rust: entries,
    // rust: }));
    // rust: let newcomer = C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: Self::INFO_ACTIONS,
    // rust: entries: vec![self.player_info(uuid, &name, mode, 0)],
    // rust: })
    // rust: .encode();
    // rust: if held {
            // Its own list has itself in it; the others' lists do not.
    // rust: self.guests[i].sender.send(newcomer);
    // rust: } else {
    // rust: let level = self.hidden.get(&uuid).copied();
            // A held player is shown the entities around it, so it must know the players
            // who join meanwhile, or its client drops their entity (`ClientPacketListener`
            // adds a player only with its list entry).
    // rust: for g in self.guests.iter_mut().filter(|g| g.placed || g.held) {
    // rust: if level.is_some_and(|l| g.permission < l) {
    // rust: g.tab_hidden.insert(uuid);
    // rust: } else {
    // rust: g.sender.send(newcomer.clone());
}
}
}
    // rust: self.send_level_info(i, ctx, true);
        // ServerLevel.addNewPlayer: the chunk tracking starts at the player.
    // rust: let g = &mut self.guests[i];
    // rust: let (cx, cz) = g.chunk();
    // rust: g.send(&C::SetChunkCacheCenter(play::SetChunkCacheCenter {
    // rust: x: cx,
    // rust: z: cz,
    // rust: }));
    // rust: g.center_sent = Some((cx, cz));
    // rust: g.placed_at = self.ticks;
    // rust: self.send_active_effects(i);
        // ServerPlayer.sendPostEffects and initInventoryMenu.
    // rust: self.send_post_effects(i);
    // rust: self.send_inventory(i);
}

    /// What an import changed, told to the held player's client the way a join tells it: game
    /// mode, abilities, held slot, a position to confirm, effects, inventory, and the player
    /// list as it is now (who came while it was held is in it).
    ///
    /// When the import moved the player to another chunk than the one its view was built around,
    /// the view is moved at once (the chunk centre is sent and the chunks out of reach are
    /// forgotten, as the next tick would do), and this returns true: the chunks around the new
    /// place are still to come, one batch at a time, and whoever reads them must wait for them.
pub fn send_arrival_state(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mode, conn) = {
    // rust: let g = &self.guests[i];
    // rust: (g.game_mode, g.conn)
}
        // The effects the login sent from this server's own file and the import took away:
        // `send_active_effects` only adds, and the client would go on predicting with them.
    // rust: let gone: Vec<&'static str> = {
    // rust: let g = &self.guests[i];
    // rust: g.sent_effects
    // rust: .iter()
    // rust: .filter(|s| !g.effects.list.iter().any(|e| e.id == s.id))
    // rust: .map(|s| s.id)
    // rust: .collect()
}
    // rust: for id in gone {
    // rust: if let Some(effect) = self
    // rust: .sync
    // rust: .id("minecraft:mob_effect", crate::brewing::namespaced(id))
    // rust: {
    // rust: let g = &self.guests[i];
    // rust: g.send(&C::RemoveMobEffect(play::RemoveMobEffect {
    // rust: id: g.entity_id,
    // rust: effect,
    // rust: }));
}
}
    // rust: let recentered = self.guests[i]
    // rust: .center
    // rust: .is_some_and(|c| c != self.guests[i].chunk());
    // rust: if recentered {
    // rust: self.update_view(i);
}
    // rust: let g = &self.guests[i];
    // rust: g.send(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::CHANGE_GAME_MODE,
    // rust: param: mode as f32,
    // rust: }));
    // rust: g.send(&g.abilities());
    // rust: g.send(&C::SetHeldSlot(play::SetHeldSlot {
    // rust: slot: g.selected as i32,
    // rust: }));
    // rust: self.resend_teleport(i, None);
    // rust: self.send_active_effects(i);
    // rust: self.send_inventory(i);
        // The login sent the book of this server's file; the import may have brought another
        // (`ServerRecipeBook.sendInitialRecipeBook` replaces what the client has).
    // rust: self.send_initial_recipe_book(i);
    // rust: let permission = self.guests[i].permission;
    // rust: let entries: Vec<_> = self
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|o| o.conn != conn && o.placed && self.sees(permission, o.uuid))
    // rust: .map(|o| {
    // rust: self.player_info(
    // rust: o.uuid,
    // rust: &o.name,
    // rust: o.game_mode,
    // rust: o.latency.load(Ordering::Relaxed),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: self.guests[i].send(&C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: Self::INFO_ACTIONS,
    // rust: entries,
    // rust: }));
    // rust: recentered
}

    /// Places the held player at `i`: it is simulated, shown to the others and takes part from
    /// the next tick, when its first tick does what a new player's does (health, experience,
    /// advancements). Everyone gets its player-list entry, since everyone will be sent its entity
    /// (a client adds a player's entity only with its list entry); `announce` is the join line.
pub fn place_arrival(self: *Self, i: usize, announce: bool) void {
}
    // rust: if !self.guests[i].held || self.guests[i].placed {
    // rust: return;
}
    // rust: let (name, uuid, mode, conn) = {
    // rust: let g = &self.guests[i];
    // rust: (g.name.clone(), g.uuid, g.game_mode, g.conn)
}
    // rust: if announce {
    // rust: let joined = C::SystemChat(play::SystemChat {
    // rust: content: yellow_names(
    // rust: "multiplayer.player.joined",
    // rust: vec![self.player_display_name(uuid, &name)],
    // rust: ),
    // rust: overlay: false,
    // rust: })
    // rust: .encode();
    // rust: for g in self.guests.iter().filter(|g| g.placed && g.conn != conn) {
    // rust: if self.sees(g.permission, uuid) {
    // rust: g.sender.send(joined.clone());
}
}
}
    // rust: let g = &mut self.guests[i];
    // rust: g.held = false;
    // rust: g.imported = false;
    // rust: g.placed = true;
    // rust: g.placed_at = self.ticks;
        // The player list entry of the newcomer, to everyone placed or held (itself included).
    // rust: let newcomer = C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: Self::INFO_ACTIONS,
    // rust: entries: vec![self.player_info(uuid, &name, mode, 0)],
    // rust: })
    // rust: .encode();
    // rust: let level = self.hidden.get(&uuid).copied();
    // rust: for g in self.guests.iter_mut().filter(|g| g.placed || g.held) {
    // rust: if level.is_some_and(|l| g.permission < l) {
    // rust: g.tab_hidden.insert(uuid);
    // rust: } else {
    // rust: g.sender.send(newcomer.clone());
}
}
}

    /// The guest index of the player `uuid` placed from the hand-over `id` (its import or
    /// confirmation committed): a retry of either, whose reply was lost, is answered the same.
pub fn placed_arrival(self: *Self, uuid: u128, id: u128) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.guests
    // rust: .iter()
    // rust: .position(|g| g.uuid == uuid && g.placed && g.arrival_handover == Some(id))
}

    /// The guest index of the held player `uuid` whose record of the hand-over `id` was
    /// imported, and that has not been dropped or kicked meanwhile.
pub fn imported_arrival(self: *Self, uuid: u128, id: u128) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(i) = self
    // rust: .guests
    // rust: .iter()
    // rust: .position(|g| g.uuid == uuid && g.held && !g.placed)
    // rust: else {
    // rust: return Err("no player with that unique id is held");
}
    // rust: let g = &self.guests[i];
    // rust: if !g.left_reason.is_empty() {
    // rust: Err("that player is leaving")
    // rust: } else if !g.imported {
    // rust: Err("that player is held but its record has not been imported")
    // rust: } else if g.arrival_handover != Some(id) {
    // rust: Err("that player's record is of another hand-over")
    // rust: } else {
    // rust: Ok(i)
}
}

    /// Places the held player `uuid` whose record was imported without placing it
    /// (`player-confirm`). Returns whether the others were told it came, as the import asked.
    ///
    /// What the client did since the import was not acted on, so it is put back where the
    /// server has it: the position to confirm again and the inventory.
pub fn confirm_arrival(self: *Self, uuid: u128, id: u128) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = self.imported_arrival(uuid, id)?;
    // rust: let announce = self.guests[i].arrival_announce;
    // rust: self.resend_teleport(i, None);
    // rust: self.send_inventory(i);
    // rust: self.place_arrival(i, announce);
    // rust: Ok(announce)
}

    /// `ServerPlayer.sendPostEffects`: the player's `/posteffect` chains.
pub fn send_post_effects(self: *Self, i: usize) void {
}
    // rust: let g = &mut self.guests[i];
    // rust: g.post_effects_dirty = false;
    // rust: let effects = g.post_effects.clone();
    // rust: g.send(&C::PostEffects(play::PostEffects { effects }));
}

    /// ClientboundUpdateMobEffectPacket for one of the guest's effects.
pub fn send_effect(self: *Self, i: usize, e: *EffectInstance, blend: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let effect = self
    // rust: .sync
    // rust: .id("minecraft:mob_effect", crate::brewing::namespaced(e.id))?;
    // rust: let flags = PlayerEffects::flags(e);
    // rust: let g = &self.guests[i];
    // rust: g.send(&C::UpdateMobEffect(play::UpdateMobEffect {
    // rust: id: g.entity_id,
    // rust: effect,
    // rust: amplifier: e.amplifier,
    // rust: duration: e.duration,
    // rust: flags: flags | if blend { 8 } else { 0 },
    // rust: }));
    // rust: Some(SentEffect {
    // rust: id: e.id,
    // rust: amplifier: e.amplifier,
    // rust: flags,
    // rust: duration: e.duration,
    // rust: tick_count: g.effects.tick_count,
    // rust: })
}

    /// PlayerList.sendActivePlayerEffects: every effect, unblended, when the
    /// player is placed (or respawns).
pub fn send_active_effects(self: *Self, i: usize) void {
}
    // rust: let effects = self.guests[i].effects.list.clone();
    // rust: let sent = effects
    // rust: .iter()
    // rust: .filter_map(|e| self.send_effect(i, e, false))
    // rust: .collect();
    // rust: self.guests[i].sent_effects = sent;
}

    /// ServerPlayer.onEffectAdded (blended), onEffectUpdated and
    /// onEffectsRemoved, from what changed since the client was told: an
    /// effect that only counted down is not sent again, except at every
    /// 600 ticks left (`LivingEntity.tickEffects`).
    /// `sync_effects` for every player at once: what a command changed
    /// leaves with its feedback (ServerPlayer.onEffectAdded sends at once),
    /// not after the tick's countdown.
pub fn sync_all_effects(self: *Self) void {
}
    // rust: for i in 0..self.guests.len() {
    // rust: if self.guests[i].placed {
    // rust: self.sync_effects(i);
}
}
}
pub fn sync_effects(self: *Self, i: usize) void {
}
    // rust: let g = &self.guests[i];
    // rust: if g.effects.list.is_empty() && g.sent_effects.is_empty() {
    // rust: return;
}
    // rust: let now = g.effects.tick_count;
    // rust: let mut sent = Vec::with_capacity(g.effects.list.len());
    // rust: let mut changes = Vec::new();
    // rust: for e in &g.effects.list {
    // rust: match g.sent_effects.iter().find(|s| s.id == e.id) {
    // rust: None => changes.push((e.clone(), true)),
    // rust: Some(s) => {
    // rust: let ticked = now.wrapping_sub(s.tick_count);
    // rust: let expected = if s.duration == -1 {
    // rust: -1
    // rust: } else {
    // rust: s.duration - ticked
}
    // rust: let refresh = ticked > 0 && e.duration > 0 && e.duration % 600 == 0;
    // rust: if s.amplifier != e.amplifier
    // rust: || s.flags != PlayerEffects::flags(e)
    // rust: || e.duration != expected
    // rust: || refresh
    // rust: {
    // rust: changes.push((e.clone(), false));
    // rust: } else {
    // rust: sent.push(s.clone());
}
}
}
}
    // rust: let removed: Vec<&'static str> = g
    // rust: .sent_effects
    // rust: .iter()
    // rust: .filter(|s| g.effects.get(s.id).is_none())
    // rust: .map(|s| s.id)
    // rust: .collect();
    // rust: for id in removed {
    // rust: let Some(effect) = self
    // rust: .sync
    // rust: .id("minecraft:mob_effect", crate::brewing::namespaced(id))
    // rust: else {
    // rust: continue;
}
    // rust: let g = &self.guests[i];
    // rust: g.send(&C::RemoveMobEffect(play::RemoveMobEffect {
    // rust: id: g.entity_id,
    // rust: effect,
    // rust: }));
}
    // rust: for (e, added) in changes {
    // rust: sent.extend(self.send_effect(i, &e, added));
}
    // rust: self.guests[i].sent_effects = sent;
}

    /// PlayerList.sendPlayerPermissionLevel: the op level as an entity event
    /// (24 + level), then the commands that level may use.
pub fn send_permission_level(self: *Self, i: usize) void {
}
    // rust: let g = &self.guests[i];
    // rust: g.send(&C::EntityEvent(play::EntityEvent {
    // rust: id: g.entity_id,
    // rust: event: 24 + g.permission.min(4) as i8,
    // rust: }));
    // rust: self.send_commands(i);
}

    /// The permissions changed: tell everyone their level and commands again.
pub fn resend_commands(self: *Self) void {
}
    // rust: self.refresh_permissions();
    // rust: for i in 0..self.guests.len() {
    // rust: if self.guests[i].placed {
    // rust: self.send_permission_level(i);
}
}
}

    /// Every guest's level from the operator list and the settings, the first
    /// half of [`Hub::resend_commands`].
pub fn refresh_permissions(self: *Self) void {
}
    // rust: for i in 0..self.guests.len() {
    // rust: self.guests[i].permission = self.default_permission(self.guests[i].uuid);
}
}

    /// The names of the root commands the tree `conn`'s player would get
    /// holds (before the mods take any out), in the tree's order.
pub fn command_names(self: *Self, conn: u32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(g) = self.guest(conn) else {
    // rust: return Vec::new();
}
    // rust: let packet = self.commands_packet(g.permission);
    // rust: packet
    // rust: .nodes
    // rust: .get(packet.root as usize)
    // rust: .map(|root| {
    // rust: root.children
    // rust: .iter()
    // rust: .filter_map(|&c| packet.nodes.get(c as usize))
    // rust: .map(|n| n.name.clone())
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default()
}

    /// Whether vanilla's command tree has a command of this name.
pub fn vanilla_command(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync.commands.as_ref().is_some_and(|t| t.has(name))
}

    /// The key [`Hub::set_mod_commands`] last had: the game compares it
    /// with its server mods' each tick.
pub fn mod_commands_key(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mod_commands.1
}
    /// Server mods' commands changed: every player gets their tree again.
pub fn set_mod_commands(self: *Self, key: u64, commands: serde_json::Value) void {
}
    // rust: let resend = self.mod_commands.0 != commands;
    // rust: self.mod_commands = (commands, Some(key));
    // rust: if resend {
    // rust: for i in 0..self.guests.len() {
    // rust: if self.guests[i].placed {
    // rust: self.send_commands(i);
}
}
}
}

    /// Commands.sendCommands: the command tree for this player.
pub fn send_commands(self: *Self, i: usize) void {
}
    // rust: let g = &self.guests[i];
    // rust: let mut packet = self.commands_packet(g.permission);
        // What the mods took out is not in the tree the client gets.
    // rust: if !g.hidden_commands.is_empty() {
    // rust: let hidden: Vec<i32> = packet
    // rust: .nodes
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, n)| n.kind == 1 && g.hidden_commands.contains(&n.name))
    // rust: .map(|(i, _)| i as i32)
    // rust: .collect();
    // rust: let root = packet.root as usize;
    // rust: if let Some(root) = packet.nodes.get_mut(root) {
    // rust: root.children.retain(|c| !hidden.contains(c));
}
}
    // rust: g.send(&C::Commands(packet));
}

    /// The command tree a player of this permission level gets.
pub fn commands_packet(self: *Self, permission: u8) p {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.sync.commands {
    // rust: Some(tree) => {
    // rust: let dedicated = !self.config.integrated;
    // rust: tree.packet_with_features(
    // rust: permission,
    // rust: dedicated,
    // rust: &self.sync.builtin,
    // rust: &self.mod_commands.0,
    // rust: &self.sync.features,
    // rust: )
}
    // rust: None => play::Commands {
    // rust: nodes: vec![play::CommandNode {
    // rust: kind: 0,
    // rust: executable: false,
    // rust: restricted: false,
    // rust: children: Vec::new(),
    // rust: redirect: None,
    // rust: name: String::new(),
    // rust: parser: None,
    // rust: suggestions: None,
    // rust: }],
    // rust: root: 0,
    // rust: },
}
}

    /// ServerGamePacketListenerImpl.teleport: move the client and wait for its confirmation.
pub fn teleport(self: *Self, i: usize, position: ?[f64; 3]) void {
}
        // ServerPlayer.teleportTo: resetFlyingTicks.
    // rust: self.guests[i].above_ground_ticks = 0;
    // rust: self.teleport_relative(i, position, 0);
}

    /// `ServerGamePacketListenerImpl.teleport` alone (a refused or too fast
    /// move, a teleport sent again): the flying ticks go on.
    // rust: pub(super) fn resend_teleport(&mut self, i: usize, position: Option<[f64; 3]>) {
    // rust: self.teleport_relative(i, position, 0);
}

    /// A teleport to `position` that keeps the player's motion and look
    /// (`Relative.DELTA` and `Relative.ROTATION`: an End gateway's).
pub fn teleport_keeping_motion(self: *Self, i: usize, position: [f64; 3]) void {
}
    // rust: self.guests[i].above_ground_ticks = 0;
//         use play::relative::{DELTA_X, DELTA_Y, DELTA_Z, ROTATE_DELTA, X_ROT, Y_ROT};
    // rust: let relatives = Y_ROT | X_ROT | DELTA_X | DELTA_Y | DELTA_Z | ROTATE_DELTA;
    // rust: self.teleport_relative(i, Some(position), relatives);
}

    /// A rider's own teleport when its vehicle is teleported
    /// (`Entity.teleportSameDimension`'s passenger transition): the position,
    /// the rotation the vehicle turned it by (absolute, as
    /// `ServerPlayer.teleport` sends it), and its motion kept
    /// (`Relative.DELTA`).
pub fn teleport_rider(self: *Self, i: usize, position: [f64; 3]) void {
}
    // rust: self.guests[i].above_ground_ticks = 0;
//         use play::relative::{DELTA_X, DELTA_Y, DELTA_Z};
    // rust: self.teleport_relative(i, Some(position), DELTA_X | DELTA_Y | DELTA_Z);
}

    /// ServerGamePacketListenerImpl.teleport with `relatives`: the rotation
    /// and motion they name are sent as zero changes.
pub fn teleport_relative(self: *Self, i: usize, position: ?[f64; 3], relatives: i32) void {
}
    // rust: let ticks = self.ticks;
    // rust: let g = &mut self.guests[i];
    // rust: g.teleport_tick = ticks;
    // rust: if let Some(p) = position {
    // rust: g.position = p;
    // rust: g.previous_position = p;
}
    // rust: g.teleport_counter = (g.teleport_counter + 1) & 0x7FFF_FFFF;
    // rust: let id = g.teleport_counter;
    // rust: g.awaiting_teleport = Some((id, g.position));
//         use play::relative::{DELTA_X, DELTA_Y, DELTA_Z};
    // rust: g.awaiting_keeps_motion = relatives & (DELTA_X | DELTA_Y | DELTA_Z) != 0;
    // rust: let turn = relatives & (play::relative::Y_ROT | play::relative::X_ROT) != 0;
    // rust: g.send(&C::PlayerPosition(play::PlayerPosition {
    // rust: teleport: id,
    // rust: position: g.position,
    // rust: delta: [0.0; 3],
    // rust: yaw: if turn { 0.0 } else { g.yaw },
    // rust: pitch: if turn { 0.0 } else { g.pitch },
    // rust: relatives,
    // rust: }));
}

    /// ClientboundSetDefaultSpawnPositionPacket for the level's respawn data
    /// (the world spawn, in the Overworld wherever the player is).
pub fn default_spawn(self: *Self, spawn: [f64; 3]) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: C::SetDefaultSpawnPosition(play::SetDefaultSpawnPosition {
    // rust: pos: play::GlobalPos {
    // rust: dimension: "minecraft:overworld".into(),
    // rust: pos: [
    // rust: spawn[0].floor() as i32,
    // rust: spawn[1].floor() as i32,
    // rust: spawn[2].floor() as i32,
    // rust: ],
    // rust: },
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: })
}

    /// PlayerList.sendLevelInfo; `load_start` false holds back
    /// LEVEL_CHUNKS_LOAD_START for a player who has no position yet
    /// ([`Self::land`] sends it).
pub fn send_level_info(self: *Self, i: usize, ctx: *TickCtx, load_start: bool) void {
}
    // rust: let spawn = ctx.spawn;
    // rust: let g = &self.guests[i];
    // rust: if self.sync_attachments {
    // rust: queue_snapshots(
    // rust: &mut self.attachment_snapshots,
    // rust: g.uuid,
    // rust: [Holder::Level, Holder::Player(g.uuid)],
    // rust: );
}
    // rust: g.send(&C::InitializeBorder(super::border::initialize(ctx.border)));
    // rust: g.send(&self.time_packet(ctx.world, ctx.clock_rate));
    // rust: g.send(&self.default_spawn(spawn));
    // rust: let w = &ctx.world.weather;
    // rust: if w.raining {
    // rust: g.send(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::START_RAINING,
    // rust: param: 0.0,
    // rust: }));
    // rust: g.send(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::RAIN_LEVEL,
    // rust: param: w.rain_level.1,
    // rust: }));
    // rust: g.send(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::THUNDER_LEVEL,
    // rust: param: w.thunder_level.1,
    // rust: }));
}
    // rust: if load_start {
    // rust: g.send(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::LEVEL_CHUNKS_LOAD_START,
    // rust: param: 0.0,
    // rust: }));
}
        // TickRateManager.updateJoiningPlayer.
    // rust: g.send(&ticking_state(ctx.tick_rate, ctx.tick_frozen));
    // rust: g.send(&C::TickingStep(play::TickingStep {
    // rust: steps: ctx.tick_steps.remaining,
    // rust: }));
}

    /// ServerClockManager.createFullSyncPacket: every clock. Horizon keeps the
    /// overworld clock (the day time); the End's clock runs with the game
    /// time. Clocks do not advance without the advance_time rule.
pub fn time_packet(self: *Self, world: *World, rate: f32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let overworld = self
    // rust: .sync
    // rust: .id("minecraft:world_clock", "minecraft:overworld")
    // rust: .unwrap_or(0);
    // rust: C::SetTime(play::SetTime {
    // rust: game_time: world.game_time,
    // rust: clocks: self
    // rust: .clock_ids
    // rust: .iter()
    // rust: .map(|&id| {
    // rust: if id == overworld {
    // rust: play::ClockState {
    // rust: clock: id,
    // rust: total_ticks: world.day_time,
    // rust: partial_tick: 0.0,
    // rust: rate,
}
    // rust: } else {
    // rust: play::ClockState {
    // rust: clock: id,
    // rust: total_ticks: world.game_time,
    // rust: partial_tick: 0.0,
    // rust: rate: if rate > 0.0 { 1.0 } else { 0.0 },
}
}
    // rust: })
    // rust: .collect(),
    // rust: })
}

    /// ServerPlayer.initInventoryMenu / sendAllDataToRemote for the inventory menu.
    /// ClientboundPlaceGhostRecipePacket: the recipe `id` faded into the
    /// guest's menu `container`, whose items were missing.
pub fn send_ghost_recipe(self: *Self, conn: u32, container: i32, id: []const u8) void {
}
    // rust: let Some(display) = self.sync.advancements.ghost_display(id, &self.sync) else {
    // rust: return;
}
    // rust: self.send_to(
    // rust: conn,
    // rust: &C::PlaceGhostRecipe(horizon_protocol::packets::recipes::PlaceGhostRecipe {
    // rust: container,
    // rust: display,
    // rust: }),
    // rust: );
}
pub fn send_inventory(self: *Self, i: usize) void {
}
    // rust: let items: Vec<Option<ItemStack>> = (0..46).map(|s| self.guests[i].menu_slot(s)).collect();
    // rust: let net: Vec<_> = items.iter().map(|s| self.stack(s)).collect();
    // rust: let carried = self.guests[i].carried.clone();
    // rust: let carried = self.stack(&carried);
    // rust: let g = &mut self.guests[i];
    // rust: g.menu_state = (g.menu_state + 1) & 0x7FFF;
    // rust: g.send(&C::ContainerSetContent(play::ContainerSetContent {
    // rust: container: 0,
    // rust: state: g.menu_state,
    // rust: items: net,
    // rust: carried,
    // rust: }));
    // rust: g.menu_sent = items;
    // rust: g.sent_selected = g.selected;
}

    // ---- per tick ------------------------------------------------------

    /// A whole tick with one level: the network, the level, then the
    /// players' latencies.
pub fn tick(self: *Self, ctx: *mut TickCtx) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut events = self.poll(ctx);
    // rust: events.extend(self.drain_packets(ctx));
    // rust: events.extend(self.tick_level(ctx));
    // rust: self.end_tick();
    // rust: events
}

    /// The network since the last tick, once per server tick before any
    /// level ticks: joins (into the level in place), leaves, and each guest's
    /// packets queued for its own level's pass.
pub fn poll(self: *Self, ctx: *mut TickCtx) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ticks += 1;
    // rust: self.anticheat_tick(ctx.tick_rate);
    // rust: let mut events = std::mem::take(&mut self.pending_kicks);
    // rust: self.expire_arrivals(&mut events);
    // rust: for event in self.lan.poll() {
    // rust: match event {
    // rust: NetEvent::Joined(j) => {
    // rust: let conn = self.admit(*j, ctx);
    // rust: events.push(HostEvent::Joined(conn));
}
    // rust: NetEvent::Left(conn, reason) => {
    // rust: if let Some(i) = self.guests.iter().position(|g| g.conn == conn) {
    // rust: let g = self.remove_guest(i, &reason);
    // rust: events.push(HostEvent::Left(Box::new(g)));
}
}
    // rust: NetEvent::Packet(conn, packet, bytes) => {
    // rust: let Some(g) = self.guest_mut(conn) else {
    // rust: continue;
}
                    // A kicked player's packets wait for nothing.
    // rust: if !g.left_reason.is_empty() {
    // rust: continue;
}
    // rust: g.inbox.push_back((*packet, bytes));
    // rust: g.inbox_bytes += bytes;
                    // A client sending faster than its budget is handled
                    // would grow the inbox until the server runs out of memory.
    // rust: if g.inbox.len() > INBOX_LIMIT || g.inbox_bytes > INBOX_BYTES {
    // rust: events.push(HostEvent::Warn(format!(
    // rust: "{} sent more packets than the server handles ({} waiting, {} kB)",
    // rust: g.name,
    // rust: g.inbox.len(),
    // rust: g.inbox_bytes >> 10
    // rust: )));
    // rust: g.inbox = Default::default();
    // rust: g.inbox_bytes = 0;
    // rust: self.kick(conn, translatable("disconnect.exceeded_packet_rate", &[]));
}
}
    // rust: NetEvent::Duplicate(uuid) => {
    // rust: let conns: Vec<u32> = self
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.uuid == uuid)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in conns {
    // rust: self.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.duplicate_login", &[]),
    // rust: );
}
}
}
}
        // keepConnectionAlive's timeout, checked once a second here. Kicked,
        // the client gets the reason; still here a second later (it reads
        // nothing, so its disconnect waits unwritten), its connection is closed.
    // rust: if self.ticks.is_multiple_of(20) {
    // rust: for g in &self.guests {
    // rust: if !g.left_reason.is_empty() && g.sender.timed_out() {
    // rust: g.sender.close();
}
}
    // rust: let silent: Vec<u32> = self
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.left_reason.is_empty() && g.sender.timed_out())
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in silent {
    // rust: self.kick(conn, translatable("disconnect.timeout", &[]));
}
}
    // rust: events
}

    /// Keeps, in a frozen player's inbox, the packets that answer the server
    /// (teleport, chunk batch, loaded, keep-alive, ping, tick end, client
    /// information) and drops the rest. A chat message or signed command is
    /// dropped too, but the messages it says the client has seen are taken
    /// first (`unpackAndApplyLastSeen`), and a chat acknowledgement is handled
    /// here, in the order they came: the client counts them as acknowledged,
    /// and its next message after the freeze would not validate otherwise.
    // rust: pub(crate) fn keep_acknowledgements(&mut self, i: usize, events: &mut Vec<HostEvent>) {
    // rust: let inbox = std::mem::take(&mut self.guests[i].inbox);
    // rust: let mut bytes = 0;
    // rust: for (packet, size) in inbox {
    // rust: match &packet {
    // rust: S::Chat(c) => {
    // rust: self.apply_last_seen(i, &c.last_seen, events);
}
    // rust: S::ChatCommandSigned(c) => {
    // rust: self.apply_last_seen(i, &c.last_seen, events);
}
    // rust: S::ChatAck(c) => self.chat_ack(i, c.offset, events),
    // rust: S::AcceptTeleportation(_)
    // rust: | S::PlayerLoaded(_)
    // rust: | S::ChunkBatchReceived(_)
    // rust: | S::ClientInformation(_)
    // rust: | S::ClientTickEnd(_)
    // rust: | S::KeepAlive(_)
    // rust: | S::Pong(_) => {
    // rust: bytes += size;
    // rust: self.guests[i].inbox.push_back((packet, size));
}
    // rust: _ => {}
}
}
    // rust: self.guests[i].inbox_bytes = bytes;
}

    /// Handle the players in this level's packets (`ServerGamePacketListenerImpl`
    /// for each), before the level's scheduled block ticks so a place landed in
    /// the same tick as a falling block's schedule still sees the support
    /// (#4510). `tick_level` then syncs what those packets (and the block ticks)
    /// changed.
pub fn drain_packets(self: *Self, ctx: *mut TickCtx) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut events = Vec::new();
    // rust: let timed = crate::spans::recording_here();
    // rust: for i in 0..self.guests.len() {
    // rust: if self.here(&self.guests[i]) {
    // rust: let frozen = self.guests[i].handover.is_some();
    // rust: if frozen {
                    // Frozen for a hand-over: it answers the server and nothing more.
    // rust: self.keep_acknowledgements(i, &mut events);
}
    // rust: let started = timed.then(std::time::Instant::now);
    // rust: let waiting = self.guests[i].inbox.len();
    // rust: self.process_inbox(i, ctx, &mut events);
                // Its moves are dropped, so whether the last one left it floating is
                // stale: a player frozen in a jump is not kicked for flying.
    // rust: if !frozen {
    // rust: self.tick_floating(i, &mut events);
}
                // A slow tick's line says whose packets took it (`spans::note`).
    // rust: if let Some(started) = started {
    // rust: let g = &self.guests[i];
    // rust: crate::spans::note(started.elapsed().as_secs_f32() * 1000.0, || {
    // rust: let handled = waiting.saturating_sub(g.inbox.len());
    // rust: format!("{}'s {handled} packets", g.name)
    // rust: });
}
    // rust: } else if self.guests[i].held && self.watches(&self.guests[i]) {
                // A held player only answers what the server asked of it: its
                // acknowledgements keep the chunks coming. Whatever else it sends
                // (moves, clicks, commands) is not for the world.
    // rust: self.keep_acknowledgements(i, &mut events);
    // rust: self.process_inbox(i, ctx, &mut events);
}
}
    // rust: events
}

    /// The level in place's part of the tick (`ServerLevel.tick`'s chunk
    /// map and the connections of the players in it): the chunks, block
    /// changes, containers and entities they see. Player packets are drained
    /// earlier (`drain_packets`) so scheduled ticks see what they placed.
pub fn tick_level(self: *Self, ctx: *mut TickCtx) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let events = Vec::new();
    // rust: if !self.guests.iter().any(|g| self.watches(g)) {
            // ServerTickRateManager broadcasts a change to the players there
            // are; one who joins later is sent the state as it is then
            // (`updateJoiningPlayer`).
    // rust: if !self.guests.iter().any(|g| g.placed) {
    // rust: self.ticking = (ctx.tick_rate, ctx.tick_frozen);
    // rust: self.stepping = ctx.tick_steps.revision;
}
    // rust: if !self
    // rust: .guests
    // rust: .iter()
    // rust: .any(|g| g.dimension == self.config.dimension)
    // rust: {
    // rust: let _ = ctx.world.block_log.take();
    // rust: let _ = ctx.world.light_log.take();
    // rust: if let Some(far) = self.far.as_mut() {
    // rust: far.forget_level();
}
    // rust: ctx.world.bulk_log.clear();
}
    // rust: return events;
}
    // rust: if ctx.world.block_log.is_none() {
    // rust: ctx.world.block_log = Some(Vec::new());
}
    // rust: if ctx.world.light_log.is_none() {
    // rust: ctx.world.light_log = Some(Default::default());
}
    // rust: crate::spans::time("lan_sync_world", || self.sync_world(ctx));
    // rust: crate::spans::time("lan_chunks", || self.update_chunks(ctx));
    // rust: crate::spans::time("lan_block_changes", || {
    // rust: self.broadcast_light_changes(ctx.world);
    // rust: self.broadcast_block_changes(ctx.world);
    // rust: });
        // ServerGamePacketListenerImpl.tick: the actions handled since the last tick are
        // acknowledged after the block changes they made were sent, so a client's predicted
        // blocks settle on the server's states.
    // rust: for g in self.guests.iter().filter(|g| self.here(g)) {
    // rust: let sequence = g.ack_up_to.replace(-1);
    // rust: if sequence >= 0 {
    // rust: g.send(&C::BlockChangedAck(play::BlockChangedAck { sequence }));
}
}
    // rust: crate::spans::time("lan_containers", || self.sync_containers(ctx.world));
    // rust: self.sync_hidden();
    // rust: crate::spans::time("lan_track_entities", || self.track_entities(ctx));
    // rust: crate::spans::time("lan_player_state", || {
    // rust: for i in 0..self.guests.len() {
    // rust: if self.here(&self.guests[i]) {
    // rust: self.sync_player_state(i);
    // rust: self.sync_effects(i);
}
}
    // rust: });
    // rust: events
}

    /// After every level: `PlayerList.tick`.
pub fn end_tick(self: *Self) void {
}
    // rust: let latencies: Vec<_> = self
    // rust: .guests
    // rust: .iter()
    // rust: .map(|g| (g.uuid, g.latency.load(Ordering::Relaxed)))
    // rust: .collect();
        // PlayerList.tick: UPDATE_LATENCY once `++sendAllPlayerInfoIn > 600`,
        // so on the 601st tick, then every 601.
    // rust: if self.ticks.is_multiple_of(601) && !latencies.is_empty() {
    // rust: let entries = latencies
    // rust: .iter()
    // rust: .map(|(uuid, latency)| play::PlayerInfo {
    // rust: uuid: *uuid,
    // rust: latency: Some(*latency),
    // rust: ..Default::default()
    // rust: })
    // rust: .collect();
    // rust: self.broadcast(&C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: 16,
    // rust: entries,
    // rust: }));
}
}

    /// The starts and stops of tracking the guests had since the last call
    /// are kept in `native_tracking`.
pub fn collect_tracking(self: *Self) void {
}
    // rust: for g in &mut self.guests {
    // rust: take_tracking(
    // rust: g,
    // rust: &mut self.native_tracking,
    // rust: &mut self.attachment_snapshots,
    // rust: self.sync_attachments,
    // rust: );
}
}

    // rust: pub(super) fn remove_guest(&mut self, i: usize, reason: &str) -> Guest {
    // rust: let mut g = self.guests.remove(i);
    // rust: if let Some(m) = g
    // rust: .menu
    // rust: .as_ref()
    // rust: .filter(|m| m.slots == super::menu::Slots::Native)
    // rust: {
    // rust: self.native_menu_events
    // rust: .push(super::menu::NativeMenuEvent::Closed {
    // rust: uuid: g.uuid,
    // rust: window: m.window,
    // rust: });
}
        // A held player a proxy dropped keeps, in the log, how its connection really ended
        // (an unreadable packet, a reset): the drop says only that it was dropped.
    // rust: if g.held
    // rust: && !g.placed
    // rust: && !reason.is_empty()
    // rust: && !g.left_reason.is_empty()
    // rust: && g.left_reason != reason
    // rust: {
    // rust: g.left_reason = format!("{} (the connection ended: {reason})", g.left_reason);
}
    // rust: if g.left_reason.is_empty() {
    // rust: g.left_reason = reason.to_owned();
}
    // rust: if std::env::var_os("HORIZON_NET_DEBUG").is_some() {
    // rust: log::info!("[lan] {} left: {reason}", g.name);
}
    // rust: if !g.placed {
    // rust: return g;
}
        // `PlayerList.remove`: the entities it tracked stop (`removePairing`).
    // rust: g.tracker.clear();
    // rust: take_tracking(
    // rust: &mut g,
    // rust: &mut self.native_tracking,
    // rust: &mut self.attachment_snapshots,
    // rust: self.sync_attachments,
    // rust: );
        // To the held players too: they were told of this one, and see its entity.
    // rust: self.broadcast_watching(&C::PlayerInfoRemove(play::PlayerInfoRemove {
    // rust: uuids: vec![g.uuid],
    // rust: }));
    // rust: self.broadcast_watching(&C::RemoveEntities(play::RemoveEntities {
    // rust: ids: vec![g.entity_id],
    // rust: }));
    // rust: let left = C::SystemChat(play::SystemChat {
    // rust: content: yellow_names(
    // rust: "multiplayer.player.left",
    // rust: vec![self.player_display_name(g.uuid, &g.name)],
    // rust: ),
    // rust: overlay: false,
    // rust: })
    // rust: .encode();
    // rust: for o in self.guests.iter_mut().filter(|o| o.placed) {
    // rust: if o.tab_hidden.remove(&g.uuid) {
    // rust: continue;
}
    // rust: if !g.quiet_leave {
    // rust: o.sender.send(left.clone());
}
}
    // rust: g
}

    /// Takes the frozen player `uuid` out of the world because a proxy moved it to another
    /// server, for the hand-over `id`: the others see it go (its entity and its player-list
    /// entry), but nothing is saved (the other server has the player now) and, unless
    /// `announce`, the "left the game" line is not sent. The game is told it left, marked
    /// released, so it saves nothing.
    ///
    /// Refused when the player is not in that hand-over: another one, or none because the
    /// freeze ran out (the player has played on since, and the record the other server has is
    /// older), or a player who died while frozen.
    // rust: pub fn release_moved(
    // rust: &mut self,
    // rust: uuid: u128,
    // rust: id: u128,
    // rust: announce: bool,
    // rust: ) -> Result<(), &'static str> {
    // rust: let i = self.handover_of(uuid, id)?;
    // rust: let g = &mut self.guests[i];
    // rust: g.quiet_leave = !announce;
    // rust: g.left_reason = "moved to another server".to_owned();
    // rust: g.sender
    // rust: .disconnect(translatable("multiplayer.disconnect.generic", &[]));
    // rust: let mut gone = self.remove_guest(i, "moved to another server");
    // rust: gone.released = true;
    // rust: gone.handover = None;
    // rust: self.pending_kicks.push(HostEvent::Left(Box::new(gone)));
    // rust: Ok(())
}

    /// The guest index of the player `uuid` while it is frozen for the hand-over `id`.
pub fn handover_of(self: *Self, uuid: u128, id: u128) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(i) = self.guests.iter().position(|g| g.uuid == uuid) else {
    // rust: return Err("that player is not connected to this server");
}
    // rust: let g = &self.guests[i];
    // rust: match &g.handover {
    // rust: _ if g.dead => Err("that player died during the hand-over"),
    // rust: None => Err("that player is not in a hand-over (or its freeze ran out)"),
    // rust: Some(h) if h.id != id => Err("that is not the player's current hand-over"),
    // rust: Some(_) => Ok(i),
}
}

    /// `ServerTickRateManager.updateStepTicks` / `updateStateToClients`:
    /// send clock changes before the block events caused by their ticks.
pub fn sync_ticking(self: *Self, rate: f32, frozen: bool, steps: crate::clock::StepState) void {
}
    // rust: if (rate, frozen) != self.ticking {
    // rust: self.ticking = (rate, frozen);
    // rust: self.broadcast(&ticking_state(rate, frozen));
}
        // ServerTickRateManager.updateStepTicks: a step started or stopped.
    // rust: if steps.revision != self.stepping {
    // rust: self.stepping = steps.revision;
    // rust: self.broadcast(&C::TickingStep(play::TickingStep {
    // rust: steps: steps.requested,
    // rust: }));
}
}

    /// Time and weather (ServerLevel.tickTime / advanceWeatherCycle broadcasts).
pub fn sync_world(self: *Self, ctx: *TickCtx) void {
}
    // rust: let world = &*ctx.world;
        // MinecraftServer.tickServer: the game time every 20 ticks
        // (forceGameTimeSynchronization, no clocks).
    // rust: if self.ticks.is_multiple_of(20) {
    // rust: self.broadcast_level(&C::SetTime(play::SetTime {
    // rust: game_time: world.game_time,
    // rust: clocks: Vec::new(),
    // rust: }));
}
        // ServerClockManager.modifyClock: a day that jumped (`time set`, `time
        // add`) or a new rate updates the overworld clock.
    // rust: let (day, rate) = (world.day_time, ctx.clock_rate);
    // rust: let step = i64::from(rate.ceil() as i32).max(1);
    // rust: if self.last_clock != i64::MIN
    // rust: && ((day - self.last_clock).abs() > step || rate != self.last_rate)
    // rust: {
    // rust: let overworld = self
    // rust: .sync
    // rust: .id("minecraft:world_clock", "minecraft:overworld")
    // rust: .unwrap_or(0);
    // rust: self.broadcast_level(&C::SetTime(play::SetTime {
    // rust: game_time: world.game_time,
    // rust: clocks: vec![play::ClockState {
    // rust: clock: overworld,
    // rust: total_ticks: day,
    // rust: partial_tick: 0.0,
    // rust: rate,
    // rust: }],
    // rust: }));
}
    // rust: self.last_clock = day;
    // rust: self.last_rate = rate;
    // rust: self.sync_ticking(ctx.tick_rate, ctx.tick_frozen, ctx.tick_steps);
    // rust: let w = &world.weather;
    // rust: let (raining, rain, thunder) = self.weather;
    // rust: if w.raining != raining {
    // rust: self.broadcast_level(&C::GameEvent(play::GameEvent {
    // rust: event: if w.raining {
    // rust: game_event::START_RAINING
    // rust: } else {
    // rust: game_event::STOP_RAINING
    // rust: },
    // rust: param: 0.0,
    // rust: }));
}
    // rust: if (w.rain_level.1 - rain).abs() > f32::EPSILON {
    // rust: self.broadcast_level(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::RAIN_LEVEL,
    // rust: param: w.rain_level.1,
    // rust: }));
}
    // rust: if (w.thunder_level.1 - thunder).abs() > f32::EPSILON {
    // rust: self.broadcast_level(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::THUNDER_LEVEL,
    // rust: param: w.thunder_level.1,
    // rust: }));
}
    // rust: self.weather = (w.raining, w.rain_level.1, w.thunder_level.1);
}

    // ---- chunks --------------------------------------------------------

    /// Every player's chunks here: their views, then the next batch of each
    /// (PlayerChunkSender.sendNextChunks). The batches are chosen first, the
    /// columns in them encoded once each, their new sections and their light
    /// on the warm-up threads too (`ChunkEncoder::warm`, `bodies_with`), then
    /// sent: nothing changes the level in between, and each player's packets
    /// keep their order. The far ring's chunks the level doesn't hold go as
    /// the save's readers made them.
pub fn update_chunks(self: *Self, ctx: *TickCtx) void {
}
    // rust: let world = &*ctx.world;
    // rust: if let Some(far) = self.far.as_mut() {
    // rust: far.poll();
}
    // rust: let mut batches = Vec::new();
    // rust: for i in 0..self.guests.len() {
    // rust: if self.watches(&self.guests[i]) {
    // rust: self.update_view(i);
    // rust: if let Some(batch) = self.next_batch(i, world, ctx.streaming) {
    // rust: batches.push((i, batch));
}
}
}
    // rust: if batches.is_empty() {
    // rust: return;
}
        // Each column once, however many players it goes to, with the
        // number of batches that take it.
    // rust: let mut columns = Columns::default();
    // rust: let batches: Vec<_> = batches
    // rust: .into_iter()
    // rust: .map(|(i, batch)| {
    // rust: let (taken, mut bodies): (Vec<_>, Vec<_>) = batch
    // rust: .near
    // rust: .into_iter()
    // rust: .map(|(idx, chunk)| (idx, Body::Level(columns.add(chunk))))
    // rust: .unzip();
    // rust: let mut far = Vec::new();
    // rust: for (idx, column) in batch.far {
    // rust: far.push((idx, column.is_some()));
    // rust: match column {
    // rust: Some(Column::Level(chunk)) => bodies.push(Body::Level(columns.add(chunk))),
    // rust: Some(Column::Saved(body)) => bodies.push(Body::Saved(body)),
    // rust: None => {}
}
}
    // rust: (i, taken, far, bodies)
    // rust: })
    // rust: .collect();
    // rust: self.encoder.warm(&columns.chunks);
    // rust: let mut encoded = self.encoder.bodies_with(&columns.chunks, world, &|x, z| {
    // rust: ctx.streaming.and_then(|s| s.proto_sections(x, z))
    // rust: });
    // rust: let uses = &mut columns.uses;
    // rust: let chunks = &columns.chunks;
    // rust: for (i, taken, far, batch) in batches {
    // rust: let g = &mut self.guests[i];
    // rust: let size = batch.len();
            // The single-player window shares the sections it is sent (handoff.rs).
    // rust: let memory = g.address == super::conn::MEMORY_ADDRESS;
    // rust: if size > 0 {
    // rust: g.batch_quota -= size as f32;
    // rust: g.send(&C::ChunkBatchStart(horizon_protocol::packets::Empty));
    // rust: g.sender.send_many(batch.into_iter().map(|body| match body {
    // rust: Body::Level(j) => {
    // rust: if memory {
    // rust: super::handoff::offer(chunks[j]);
}
    // rust: uses[j] -= 1;
    // rust: if uses[j] == 0 {
    // rust: std::mem::take(&mut encoded[j])
    // rust: } else {
    // rust: encoded[j].clone()
}
}
    // rust: Body::Saved(body) => body.to_vec(),
    // rust: }));
    // rust: g.send(&C::ChunkBatchFinished(play::ChunkBatchFinished {
    // rust: size: size as i32,
    // rust: }));
    // rust: g.unacknowledged += 1;
}
    // rust: let mut seen: Vec<_> = taken
    // rust: .into_iter()
    // rust: .rev()
    // rust: .map(|idx| g.chunk_queue.remove(idx))
    // rust: .collect();
    // rust: if self.sync_attachments {
    // rust: queue_snapshots(
    // rust: &mut self.attachment_snapshots,
    // rust: g.uuid,
    // rust: seen.iter().map(|&(x, z)| Holder::Chunk([x, z])),
    // rust: );
}
            // A far chunk the save doesn't have leaves the queue unsent.
    // rust: seen.extend(far.into_iter().rev().filter_map(|(idx, sent)| {
    // rust: let key = g.far_queue.remove(idx);
    // rust: if sent && self.sync_attachments && g.brand == "horizon" {
    // rust: g.far_sent_chunks.insert(key);
}
    // rust: sent.then_some(key)
    // rust: }));
    // rust: g.sent_chunks.extend(seen);
}
}

    /// ChunkMap.move's view change: the new centre, the chunks that left
    /// the view forgotten and the ones that entered it queued, closest first;
    /// past the view, the far ring's.
pub fn update_view(self: *Self, i: usize) void {
}
    // rust: let (cx, cz) = self.guests[i].chunk();
    // rust: let r = self.guests[i].view_distance;
    // rust: let reach = self.reach(&self.guests[i]);
    // rust: let g = &mut self.guests[i];
    // rust: if g.center == Some((cx, cz)) {
    // rust: return;
}
    // rust: g.center = Some((cx, cz));
    // rust: if g.center_sent.take() != Some((cx, cz)) {
    // rust: g.send(&C::SetChunkCacheCenter(play::SetChunkCacheCenter {
    // rust: x: cx,
    // rust: z: cz,
    // rust: }));
}
        // Chunks that left the view.
    // rust: let forget: Vec<_> = g
    // rust: .sent_chunks
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&(x, z)| !tracked(cx, cz, reach, x, z))
    // rust: .collect();
    // rust: for (x, z) in forget {
    // rust: g.sent_chunks.remove(&(x, z));
    // rust: g.far_sent_chunks.remove(&(x, z));
    // rust: g.send(&C::ForgetLevelChunk(play::ForgetLevelChunk { pos: [x, z] }));
}
        // Far columns have no attachment snapshots. Resend them as near chunks
        // after they enter the view, once the level has loaded them.
    // rust: g.far_sent_chunks.retain(|&(x, z)| {
    // rust: if tracked(cx, cz, r, x, z) {
    // rust: g.sent_chunks.remove(&(x, z));
    // rust: false
    // rust: } else {
    // rust: true
}
    // rust: });
    // rust: requeue(&mut g.chunk_queue, &g.sent_chunks, (cx, cz), r);
    // rust: if reach > r {
    // rust: requeue_ring(&mut g.far_queue, &g.sent_chunks, (cx, cz), r, reach);
    // rust: } else {
    // rust: g.far_queue.clear();
}
}

    /// PlayerChunkSender.sendNextChunks' choice: ready chunks, closest first,
    /// as many as the batch quota the client's acknowledgements pace allows,
    /// with their places in the queue. What the view leaves of the quota goes
    /// to the far ring, as far as its brake lets it reach.
    // rust: fn next_batch<'w>(
    // rust: &mut self,
    // rust: i: usize,
    // rust: world: &'w World,
    // rust: streaming: Option<&crate::streaming::Streaming>,
    // rust: ) -> Option<Batch<'w>> {
    // rust: let g = &mut self.guests[i];
    // rust: if self.ticks <= g.placed_at + 1 || g.unacknowledged >= g.max_unacknowledged {
    // rust: return None;
}
    // rust: g.batch_quota = (g.batch_quota + g.chunks_per_tick).min(g.chunks_per_tick.max(1.0));
    // rust: if g.batch_quota < 1.0 || (g.chunk_queue.is_empty() && g.far_queue.is_empty()) {
    // rust: return None;
}
    // rust: let budget = g.batch_quota.floor() as usize;
        // ChunkStatus.LIGHT needs its neighbours at INITIALIZE_LIGHT: a
        // column whose light layers would leave one out waits for it.
    // rust: let ready = |c: &Chunk| {
    // rust: c.lit
    // rust: && streaming.is_none_or(|streaming| {
    // rust: (-1..=1).all(|dz| {
    // rust: (-1..=1).all(|dx| {
    // rust: let (x, z) = (c.x + dx, c.z + dz);
    // rust: world.chunks.contains_key(&(x, z))
    // rust: || streaming.proto_sections(x, z).is_some()
    // rust: })
    // rust: })
    // rust: })
}
    // rust: let near: Vec<_> = g
    // rust: .chunk_queue
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(idx, key)| Some((idx, &**world.chunks.get(key)?)))
    // rust: .filter(|(_, c)| ready(c))
    // rust: .take(budget)
    // rust: .collect();
    // rust: let mut far = Vec::new();
    // rust: if let (Some(ring), Some((cx, cz))) = (self.far.as_mut(), g.center) {
    // rust: let mut left = budget - near.len();
    // rust: for (idx, &(x, z)) in g.far_queue.iter().enumerate().take(super::far::LOOKS) {
    // rust: if left == 0 {
    // rust: break;
}
    // rust: if !tracked(cx, cz, ring.limit(), x, z) {
    // rust: continue;
}
    // rust: let column = match world.chunks.get(&(x, z)) {
    // rust: Some(c) if ready(c) => Some(Column::Level(c)),
    // rust: Some(_) => continue,
    // rust: None => match ring.saved(x, z) {
    // rust: super::far::Saved::Body(body) => Some(Column::Saved(body)),
    // rust: super::far::Saved::Missing => None,
    // rust: super::far::Saved::Waiting => continue,
    // rust: },
}
    // rust: left -= usize::from(column.is_some());
    // rust: far.push((idx, column));
}
}
    // rust: (!near.is_empty() || !far.is_empty()).then_some(Batch { near, far })
}

    /// `ChunkMap.resendBiomesForChunks`: each player in the level is sent,
    /// in one packet, the biomes of those of `columns` it has been sent
    /// (`getPlayers(pos, false)`), in the order given.
pub fn resend_biomes(self: *Self, world: *World, columns: *[(i32) void {
}
    // rust: if let Some(far) = self.far.as_mut() {
    // rust: for &(x, z) in columns {
    // rust: far.changed(x, z);
}
}
    // rust: let data: Vec<_> = columns
    // rust: .iter()
    // rust: .filter_map(|key| Some((*key, self.encoder.biome_data(world.chunks.get(key)?))))
    // rust: .collect();
    // rust: for g in self.guests.iter().filter(|g| self.watches(g)) {
    // rust: let chunks: Vec<_> = data
    // rust: .iter()
    // rust: .filter(|(key, _)| g.sent_chunks.contains(key))
    // rust: .map(|(_, d)| d.clone())
    // rust: .collect();
    // rust: if !chunks.is_empty() {
    // rust: g.send(&C::ChunksBiomes(play::ChunksBiomes { chunks }));
}
}
}

    /// `ChunkHolder.broadcastChanges` where `ServerChunkCache.tick` runs it,
    /// before the block events: what changed since the last time (the last
    /// tick's block events, entities and block entities, this tick's
    /// scheduled and random ticks), as it is now.
pub fn broadcast_changes(self: *Self, world: *mut World) void {
}
    // rust: if self.guests.iter().any(|g| self.here(g)) {
    // rust: self.broadcast_light_changes(world);
    // rust: self.broadcast_block_changes(world);
}
}
    /// `ChunkHolder.broadcastChanges`' light part: the light sections that
    /// changed in a column go to the players for whom it is on the border of
    /// what they track (`ChunkMap.isChunkOnTrackedBorder`); the others light
    /// the blocks they are sent themselves.
pub fn broadcast_light_changes(self: *Self, world: *mut World) void {
}
    // rust: let Some(log) = world.light_log.as_mut() else {
    // rust: return;
}
    // rust: if log.is_empty() {
    // rust: return;
}
    // rust: let mut changes: Vec<_> = log.drain().collect();
        // One entry per column, so the order is the columns'.
    // rust: changes.sort_unstable_by_key(|&(column, _)| column);
    // rust: for ((x, z), sections) in changes {
    // rust: if let Some(far) = self.far.as_mut() {
    // rust: far.changed(x, z);
}
    // rust: let tracked = |g: &Guest, x: i32, z: i32| g.sent_chunks.contains(&(x, z));
    // rust: let viewers: Vec<usize> = (0..self.guests.len())
    // rust: .filter(|&i| {
    // rust: let g = &self.guests[i];
    // rust: self.watches(g)
    // rust: && tracked(g, x, z)
    // rust: && (-1..=1).any(|dz| (-1..=1).any(|dx| !tracked(g, x + dx, z + dz)))
    // rust: })
    // rust: .collect();
    // rust: if viewers.is_empty() {
    // rust: continue;
}
    // rust: let Some(chunk) = world.chunks.get(&(x, z)) else {
    // rust: continue;
}
    // rust: let body = self.encoder.light_update(chunk, sections);
    // rust: for &i in &viewers {
    // rust: self.guests[i].sender.send(body.clone());
}
}
}

pub fn broadcast_block_changes(self: *Self, world: *mut World) void {
}
        // Chunks changed in bulk (`World::edit_runs`) go whole to those who see them: one packet each, where a
        // change of each block would be thousands (the client lights and meshes them once, on its workers).
    // rust: let bulk: Vec<(i32, i32)> = if world.bulk_log.is_empty() {
    // rust: Vec::new()
    // rust: } else {
    // rust: let mut keys: Vec<_> = world.bulk_log.drain().collect();
    // rust: keys.sort_unstable();
    // rust: keys
}
    // rust: if !bulk.is_empty() {
            // The single-player window's far terrain draws a column it isn't sent as the window last saw it: it is
            // handed the column to summarize again (`handoff::changed`).
    // rust: let unsent = |g: &Guest, key: &(i32, i32)| {
    // rust: self.here(g)
    // rust: && g.address == super::conn::MEMORY_ADDRESS
    // rust: && !g.sent_chunks.contains(key)
}
    // rust: for key in &bulk {
    // rust: if let Some(chunk) = world.chunks.get(key)
    // rust: && self.guests.iter().any(|g| unsent(g, key))
    // rust: {
    // rust: super::handoff::changed(chunk);
}
}
    // rust: let recording = self.recording();
    // rust: let columns: Vec<&Chunk> = bulk
    // rust: .iter()
    // rust: .filter_map(|k| world.chunks.get(k).map(|c| &**c))
    // rust: .collect();
    // rust: self.encoder.warm(&columns);
    // rust: for chunk in columns {
    // rust: let key = (chunk.x, chunk.z);
    // rust: if let Some(far) = self.far.as_mut() {
    // rust: far.changed(key.0, key.1);
}
    // rust: let viewers: Vec<usize> = (0..self.guests.len())
    // rust: .filter(|&i| {
    // rust: self.watches(&self.guests[i]) && self.guests[i].sent_chunks.contains(&key)
    // rust: })
    // rust: .collect();
    // rust: if viewers.is_empty() {
    // rust: continue;
}
    // rust: let body = self.encoder.body_in(chunk, world);
    // rust: for &i in &viewers {
    // rust: self.guests[i].sender.send(body.clone());
}
    // rust: if recording {
                    // The prediction's replay excuses a client near the column: any of its blocks may have
                    // changed, so the one nearest the player stands for them.
    // rust: for &i in &viewers {
    // rust: let g = &mut self.guests[i];
    // rust: let Some(record) = g.anticheat.record.as_deref_mut() else {
    // rust: continue;
}
    // rust: let slack = super::prediction::slack(std::array::from_fn(|i| {
    // rust: g.position[i] - g.previous_position[i]
    // rust: }));
    // rust: let column =
    // rust: |c: f64, at: i32| (c.floor() as i32).clamp(at * 16, at * 16 + 15);
    // rust: let at = [
    // rust: column(g.position[0], key.0),
    // rust: g.position[1].floor() as i32,
    // rust: column(g.position[2], key.1),
    // rust: ];
    // rust: if super::prediction::near(g.position, at, slack) {
    // rust: record.changed_near(self.ticks, at);
}
}
}
}
}
    // rust: let Some(log) = world.block_log.as_mut() else {
    // rust: return;
}
    // rust: if !bulk.is_empty() {
            // (what changed in them one at a time went with them)
    // rust: log.retain(|p| bulk.binary_search(&(p.0 >> 4, p.2 >> 4)).is_err());
}
    // rust: if log.is_empty() {
    // rust: return;
}
    // rust: let mut changes = std::mem::take(log);
    // rust: changes.sort_unstable();
    // rust: changes.dedup();
        // The prediction's replay excuses a client that hadn't seen a change near it.
    // rust: let recording = self.recording();
        // Group by section.
    // rust: let mut sections: std::collections::BTreeMap<(i32, i32, i32), Vec<(i32, i32, i32)>> =
    // rust: Default::default();
    // rust: for p in changes {
    // rust: sections
    // rust: .entry((p.0 >> 4, p.1 >> 4, p.2 >> 4))
    // rust: .or_default()
    // rust: .push(p);
}
    // rust: for ((sx, sy, sz), positions) in sections {
    // rust: if let Some(far) = self.far.as_mut() {
    // rust: far.changed(sx, sz);
}
    // rust: let viewers: Vec<usize> = (0..self.guests.len())
    // rust: .filter(|&i| {
    // rust: self.watches(&self.guests[i]) && self.guests[i].sent_chunks.contains(&(sx, sz))
    // rust: })
    // rust: .collect();
    // rust: if viewers.is_empty() {
    // rust: continue;
}
    // rust: let packet = if positions.len() == 1 {
    // rust: let (x, y, z) = positions[0];
    // rust: C::BlockUpdate(play::BlockUpdate {
    // rust: pos: [x, y, z],
    // rust: state: world.block(x, y, z).0 as i32,
    // rust: })
    // rust: } else {
    // rust: C::SectionBlocksUpdate(play::SectionBlocksUpdate {
    // rust: section: [sx, sy, sz],
    // rust: changes: positions
    // rust: .iter()
    // rust: .map(|&(x, y, z)| {
    // rust: let state = i64::from(world.block(x, y, z).0);
    // rust: state << 12
    // rust: | i64::from(x & 15) << 8
    // rust: | i64::from(z & 15) << 4
    // rust: | i64::from(y & 15)
    // rust: })
    // rust: .collect(),
    // rust: })
}
    // rust: let body = packet.encode();
    // rust: for &i in &viewers {
    // rust: self.guests[i].sender.send(body.clone());
}
    // rust: if recording {
    // rust: for &i in &viewers {
    // rust: let g = &mut self.guests[i];
    // rust: let Some(record) = g.anticheat.record.as_deref_mut() else {
    // rust: continue;
}
    // rust: let slack = super::prediction::slack(std::array::from_fn(|i| {
    // rust: g.position[i] - g.previous_position[i]
    // rust: }));
    // rust: for &(x, y, z) in &positions {
    // rust: if super::prediction::near(g.position, [x, y, z], slack) {
    // rust: record.changed_near(self.ticks, [x, y, z]);
}
}
}
}
            // Block entities with data the client shows.
    // rust: for &(x, y, z) in &positions {
                // A decorated pot is no block entity: its tag is the chunk's saved one.
    // rust: let tag = match world.block_entities.get(&(x, y, z)) {
    // rust: Some(entity) => self.encoder.update_tag((x, y, z), entity),
    // rust: None => world
    // rust: .chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .and_then(|c| super::chunks::pot_tag(c, (x, y, z))),
}
    // rust: let Some(tag) = tag else {
    // rust: continue;
}
    // rust: let state = world.block(x, y, z).0;
    // rust: let Some(kind) = self.encoder.entity_type(state) else {
    // rust: continue;
}
    // rust: let body = C::BlockEntityData(play::BlockEntityData {
    // rust: pos: [x, y, z],
    // rust: kind,
    // rust: tag,
    // rust: })
    // rust: .encode();
    // rust: for &i in &viewers {
    // rust: self.guests[i].sender.send(body.clone());
}
}
}
}

    // ---- entities ------------------------------------------------------

    /// `LivingEntity.updateSynchronizedMobEffectParticles`: DATA_EFFECT_PARTICLES
    /// (10) and DATA_EFFECT_AMBIENCE_ID (11) for the visible `effects`, as
    /// (effect, ambient). The entries are left out when there is nothing to
    /// show, which is their default.
    // rust: pub fn effect_meta<'a>(
    // rust: &self,
    // rust: effects: impl IntoIterator<Item = (&'a str, bool)>,
    // rust: ) -> Vec<(u8, i32, Value)> {
    // rust: let mut particles = Vec::new();
    // rust: let mut all_ambient = true;
    // rust: for (effect, ambient) in effects {
    // rust: let effect = effect.trim_start_matches("minecraft:");
            // MobEffect.particleFactory: the omens have their own particles,
            // the others an entity effect in their colour (faint if ambient).
    // rust: let (name, data) = match effect {
    // rust: "trial_omen" | "raid_omen" => (effect, None),
    // rust: _ => {
    // rust: let Some(def) = crate::brewing::effect(effect) else {
    // rust: continue;
}
    // rust: let alpha = if ambient { 38 } else { 255 };
    // rust: let argb = (alpha << 24) | def.color as i32;
    // rust: ("entity_effect", Some(ParticleData::Color(argb)))
}
}
    // rust: let Some(id) =
    // rust: self.registry_id("minecraft:particle_type", &format!("minecraft:{name}"))
    // rust: else {
    // rust: continue;
}
    // rust: particles.push(Particle { id, data });
    // rust: all_ambient &= ambient;
}
    // rust: if particles.is_empty() {
    // rust: return Vec::new();
}
    // rust: let mut meta = vec![(10, serializer::PARTICLES, Value::Particles(particles))];
    // rust: if all_ambient {
    // rust: meta.push((11, serializer::BOOLEAN, Value::Bool(true)));
}
    // rust: meta
}

    // rust: fn player_state(
    // rust: &self,
    // rust: id: i32,
    // rust: uuid: u128,
    // rust: position: [f64; 3],
    // rust: rot: (f32, f32, f32),
    // rust: on_ground: bool,
    // rust: flags: (bool, bool, bool),
    // rust: body: BodyFlags,
    // rust: living_flags: i8,
    // rust: bed: Option<[i32; 3]>,
    // rust: skin: u8,
    // rust: health: f32,
    // rust: equipment: Vec<(u8, Option<horizon_protocol::item::Stack>)>,
    // rust: attributes: Vec<play::AttributeSnapshot>,
    // rust: effects: &[EffectInstance],
    // rust: ) -> EntityState {
    // rust: let (sneaking, sprinting, sleeping) = flags;
    // rust: let shared = shared_flags(sneaking, sprinting, &body);
        // Player.getDesiredPose (and updatePlayerPose's crawl): sleeping,
        // swimming, gliding, Riptide's spin, crouching.
    // rust: let pose = if sleeping {
    // rust: 2
    // rust: } else if body.swimming || body.crawling {
    // rust: 3
    // rust: } else if body.gliding {
    // rust: 1
    // rust: } else if body.spin_attack {
    // rust: 4
    // rust: } else if sneaking || body.crouching {
    // rust: 5
    // rust: } else {
    // rust: 0
}
    // rust: let mut meta = Vec::new();
    // rust: if shared != 0 {
    // rust: meta.push((0, serializer::BYTE, Value::Byte(shared)));
}
    // rust: if pose != 0 {
    // rust: meta.push((6, serializer::POSE, Value::Id(pose)));
}
        // Always there: the trackers send the entries that changed, and an
        // item no longer in use is a change back to 0.
    // rust: meta.push((8, serializer::BYTE, Value::Byte(living_flags)));
        // LivingEntity.SLEEPING_POS: the others draw the player lying in it,
        // a player paired later too.
    // rust: if let Some(bed) = bed.filter(|_| sleeping) {
    // rust: meta.push((14, serializer::OPTIONAL_BLOCK_POS, Value::OptPos(Some(bed))));
}
    // rust: if (health - 1.0).abs() > f32::EPSILON && health != 20.0 {
    // rust: meta.push((9, serializer::FLOAT, Value::Float(health)));
}
    // rust: if skin != 0 {
    // rust: meta.push((16, serializer::BYTE, Value::Byte(skin as i8)));
}
    // rust: meta.extend(
    // rust: self.effect_meta(
    // rust: effects
    // rust: .iter()
    // rust: .filter(|e| e.visible)
    // rust: .map(|e| (e.id, e.ambient)),
    // rust: ),
    // rust: );
    // rust: EntityState {
    // rust: id,
    // rust: uuid,
    // rust: kind: "minecraft:player".into(),
    // rust: position,
    // rust: yaw: rot.0,
    // rust: pitch: rot.1,
    // rust: head_yaw: rot.2,
    // rust: on_ground,
    // rust: velocity: [0.0; 3],
    // rust: data: 0,
    // rust: meta,
            // The effect swirls go back to none.
    // rust: defaults: vec![
    // rust: (10, serializer::PARTICLES, Value::Particles(Vec::new())),
    // rust: (11, serializer::BOOLEAN, Value::Bool(false)),
    // rust: ],
    // rust: equipment,
    // rust: attributes,
    // rust: precise: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: needs_sync: false,
    // rust: idle: false,
    // rust: bare: false,
    // rust: minecart_steps: None,
    // rust: leash: None,
    // rust: spectator: false,
    // rust: watching: false,
    // rust: hidden: None,
}
}

    // rust: fn equipment_of(
    // rust: &mut self,
    // rust: main: &Option<ItemStack>,
    // rust: off: &Option<ItemStack>,
    // rust: armor: [&Option<ItemStack>; 4],
    // rust: ) -> Vec<(u8, Option<horizon_protocol::item::Stack>)> {
        // Armor is stored head..feet; the wire slots are feet(2) legs(3) chest(4) head(5).
    // rust: let mut out = Vec::new();
    // rust: let slots = [
    // rust: (0u8, main),
    // rust: (1, off),
    // rust: (5, armor[0]),
    // rust: (4, armor[1]),
    // rust: (3, armor[2]),
    // rust: (2, armor[3]),
    // rust: ];
    // rust: for (slot, item) in slots {
    // rust: if item.is_some() {
    // rust: out.push((slot, self.stack(item)));
}
}
    // rust: out
}

    /// Whether an entity is tracked by the current dimension's level.
pub fn tracks(self: *Self, id: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entities
    // rust: .get(&self.config.dimension)
    // rust: .is_some_and(|l| l.tracks(id))
}

    /// Fresh entities that joined during the current tick before the tracking pass:
    /// paired from their state as they joined (ChunkMap.addEntity), before their first tick.
pub fn note_fresh_joined(self: *Self, entities: *[EntityState]) void {
}
    // rust: let joined: Vec<_> = entities
    // rust: .iter()
    // rust: .filter(|e| !self.tracks(e.id))
    // rust: .cloned()
    // rust: .collect();
    // rust: if joined.is_empty() {
    // rust: return;
}
    // rust: self.fresh_joined
    // rust: .entry(self.config.dimension.clone())
    // rust: .or_default()
    // rust: .extend(joined);
}

    /// `ChunkMap.addEntity` for late arrivals, before their sounds are sent.
    /// Pairing does not run another tracking pass or advance entity clocks.
pub fn note_joined(self: *Self, entities: *[EntityState]) void {
}
    // rust: if entities.is_empty() {
    // rust: return;
}
    // rust: let dimension = &self.config.dimension;
    // rust: let mut outs: Vec<Vec<Vec<u8>>> = self
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| self.here(g))
    // rust: .map(|_| Vec::new())
    // rust: .collect();
    // rust: let mut viewers: Vec<Viewer> = self
    // rust: .guests
    // rust: .iter_mut()
    // rust: .filter(|g| g.placed && g.dimension == *dimension)
    // rust: .zip(outs.iter_mut())
    // rust: .map(|(g, out)| Viewer {
    // rust: entity_id: g.entity_id,
    // rust: spectator: g.spectator(),
    // rust: permission: g.permission,
    // rust: moved: false,
    // rust: position: g.position,
    // rust: view_distance: g.view_distance,
    // rust: chunks: &g.sent_chunks,
    // rust: tracker: &mut g.tracker,
    // rust: out,
    // rust: gone: None,
    // rust: })
    // rust: .collect();
    // rust: let level = self.entities.entry(dimension.clone()).or_default();
    // rust: level.range_percent = Some(self.entity_range_percent);
    // rust: let (types, sync) = (&mut self.entity_types, &self.sync);
    // rust: level.pair_after_tick(entities, &self.riding, &mut viewers, |kind| {
    // rust: entity_type(types, sync, kind)
    // rust: });
    // rust: drop(viewers);
    // rust: for (g, out) in self.guests.iter().filter(|g| self.here(g)).zip(&mut outs) {
    // rust: g.sender.send_many(out.drain(..));
}
}

    /// All entities as one client sees them: the world's and the other players.
pub fn track_entities(self: *Self, ctx: *mut TickCtx) void {
}
    // rust: let mut all: Vec<EntityState> = Vec::with_capacity(ctx.entities.len() + self.guests.len());
    // rust: let placed: Vec<usize> = (0..self.guests.len())
    // rust: .filter(|&i| self.here(&self.guests[i]))
    // rust: .collect();
    // rust: let guest_states: Vec<_> = placed
    // rust: .into_iter()
    // rust: .map(|i| {
    // rust: let (main, off, armor) = {
    // rust: let g = &self.guests[i];
    // rust: (
    // rust: g.inventory.get(g.selected).cloned().flatten(),
    // rust: g.offhand.clone(),
    // rust: g.armor.clone(),
    // rust: )
}
    // rust: let equipment =
    // rust: self.equipment_of(&main, &off, [&armor[0], &armor[1], &armor[2], &armor[3]]);
    // rust: let g = &self.guests[i];
    // rust: let mut state = self.player_state(
    // rust: g.entity_id,
    // rust: g.uuid,
    // rust: g.position,
    // rust: (g.yaw, g.pitch, g.head_yaw),
    // rust: g.on_ground,
    // rust: (g.sneaking, g.sprinting, g.sleeping),
    // rust: guest_body(g),
    // rust: g.living_flags,
    // rust: g.bed,
    // rust: g.info.model_customisation,
    // rust: g.health,
    // rust: equipment,
    // rust: g.motion
    // rust: .as_ref()
    // rust: .map(|m| super::attributes::syncable(&m.attributes))
    // rust: .unwrap_or_default(),
    // rust: &g.effects.list,
    // rust: );
    // rust: state.spectator = g.spectator();
    // rust: state.watching = g.watching;
    // rust: state.hidden = self.hidden.get(&g.uuid).copied();
    // rust: stuck_meta(&mut state, g.stuck);
    // rust: frozen_meta(&mut state, g.motion.as_ref().map_or(0, |m| m.ticks_frozen));
    // rust: shoulder_meta(&mut state, g.shoulders);
    // rust: state
    // rust: })
    // rust: .collect();
    // rust: all.extend(guest_states);
    // rust: let mut entities: Vec<&EntityState> = all.iter().chain(ctx.entities).collect();
        // ChunkMap.tick: the level's entities, once for all its players.
    // rust: let mut level = self
    // rust: .entities
    // rust: .remove(&self.config.dimension)
    // rust: .unwrap_or_default();
    // rust: let mut joined = noted_last_tick(self.joined.remove(&self.config.dimension), self.ticks);
    // rust: if let Some(fresh) = self.fresh_joined.remove(&self.config.dimension) {
    // rust: joined.extend(fresh);
}
    // rust: let joined = level.joined_states(&entities, joined);
    // rust: Entities::starting_from(&mut entities, &joined);
    // rust: level.synced.clone_from(&self.synced);
    // rust: let mut outs = std::mem::take(&mut self.entity_out);
    // rust: let dimension = &self.config.dimension;
        // The viewers include the held players: they are shown the entities
        // around them, but are not among the entities shown (`track_entities`).
    // rust: let here = |g: &Guest| (g.placed || g.held) && g.dimension == *dimension;
    // rust: outs.resize_with(self.guests.iter().filter(|g| here(g)).count(), Vec::new);
        // The prediction's replay excuses a client that may still have an entity that left it.
    // rust: let recording = self.recording();
    // rust: let mut gone = std::mem::take(&mut self.entity_gone);
    // rust: gone.resize_with(outs.len(), Vec::new);
    // rust: let mut viewers: Vec<Viewer> = self
    // rust: .guests
    // rust: .iter_mut()
    // rust: .filter(|g| here(g))
    // rust: .zip(outs.iter_mut().zip(gone.iter_mut()))
    // rust: .map(|(g, (out, gone))| Viewer {
    // rust: entity_id: g.entity_id,
    // rust: spectator: g.spectator(),
    // rust: permission: g.permission,
    // rust: moved: std::mem::take(&mut g.moved),
    // rust: position: g.position,
    // rust: view_distance: g.view_distance,
    // rust: chunks: &g.sent_chunks,
    // rust: tracker: &mut g.tracker,
    // rust: out,
    // rust: gone: recording.then_some(gone),
    // rust: })
    // rust: .collect();
    // rust: level.range_percent = Some(self.entity_range_percent);
    // rust: let (types, sync) = (&mut self.entity_types, &self.sync);
    // rust: level.tick(&entities, &self.riding, &mut viewers, |kind| {
    // rust: entity_type(types, sync, kind)
    // rust: });
    // rust: drop(viewers);
    // rust: for (g, out) in self.guests.iter().filter(|g| here(g)).zip(outs.iter_mut()) {
    // rust: self.hold_sound_removals(g.conn, out);
    // rust: g.sender.send_many(out.drain(..));
}
    // rust: let ticks = self.ticks;
    // rust: for (g, gone) in self
    // rust: .guests
    // rust: .iter_mut()
    // rust: .filter(|g| here(g))
    // rust: .zip(gone.iter_mut())
    // rust: {
    // rust: let slack = super::prediction::slack(std::array::from_fn(|i| {
    // rust: g.position[i] - g.previous_position[i]
    // rust: }));
    // rust: for at in gone.drain(..) {
    // rust: let block = at.map(|v| v.floor() as i32);
    // rust: if let Some(record) = g.anticheat.record.as_deref_mut()
    // rust: && super::prediction::near(g.position, block, slack)
    // rust: {
    // rust: record.entity_gone(ticks);
}
}
}
    // rust: self.entity_gone = gone;
    // rust: self.entity_out = outs;
    // rust: self.entities.insert(self.config.dimension.clone(), level);
}

    /// ServerPlayer.stopSleepInBed: the wake-up animation goes to the player
    /// and those around, the pose is standing again and the sleep counter
    /// starts the wake-up fade (100).
pub fn wake(self: *Self, i: usize) void {
}
    // rust: let g = &mut self.guests[i];
    // rust: let head = g.bed.take();
    // rust: if head.is_none() && !g.sleeping {
    // rust: return;
}
    // rust: if let Some(head) = head {
    // rust: g.woke_from = Some(head);
}
    // rust: g.sleeping = false;
    // rust: g.sleep_timer = 100;
    // rust: if g.sent_bed.take().is_some() {
    // rust: g.send(&C::SetEntityData(play::SetEntityData {
    // rust: id: g.entity_id,
    // rust: values: vec![
    // rust: (6, serializer::POSE, Value::Id(0)),
    // rust: (14, serializer::OPTIONAL_BLOCK_POS, Value::OptPos(None)),
    // rust: ],
    // rust: }));
}
    // rust: let (id, at) = (g.entity_id, g.position);
        // ClientboundAnimatePacket.WAKE_UP.
    // rust: self.broadcast_near(
    // rust: at,
    // rust: 128.0,
    // rust: &C::Animate(play::Animate { id, action: 0 }),
    // rust: None,
    // rust: );
}

    // ---- per-player state ------------------------------------------------

    /// ServerPlayer.doTick: health, food, experience and the inventory menu.
pub fn sync_player_state(self: *Self, i: usize) void {
}
        // LivingEntity.startSleeping / stopSleeping: the pose and the bed go
        // to the player too (its client lies down in the bed from them).
    // rust: let g = &mut self.guests[i];
    // rust: if g.bed != g.sent_bed {
    // rust: g.sent_bed = g.bed;
    // rust: let pose = if g.bed.is_some() { 2 } else { 0 };
    // rust: g.send(&C::SetEntityData(play::SetEntityData {
    // rust: id: g.entity_id,
    // rust: values: vec![
    // rust: (6, serializer::POSE, Value::Id(pose)),
    // rust: (14, serializer::OPTIONAL_BLOCK_POS, Value::OptPos(g.bed)),
    // rust: ],
    // rust: }));
}
        // ServerEntity.sendDirtyEntityData on the player's first tick: the
        // health its creation set is still dirty, and goes to the player too.
    // rust: let first_tick = self.guests[i].sent_health.is_none();
    // rust: if first_tick {
    // rust: let g = &self.guests[i];
    // rust: g.send(&C::SetEntityData(play::SetEntityData {
    // rust: id: g.entity_id,
    // rust: values: vec![(9, serializer::FLOAT, Value::Float(g.health))],
    // rust: }));
            // ServerPlayer.tick's CriteriaTriggers.TICK, then flushDirty. A
            // player who has been here has had the tick's criteria already.
    // rust: if !g.advancements_loaded {
    // rust: let now = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64);
    // rust: let sync = self.sync.clone();
    // rust: let g = &mut self.guests[i];
    // rust: let first = sync.advancements.first_tick(
    // rust: &sync,
    // rust: now,
    // rust: &mut g.advancements,
    // rust: &mut g.recipe_book,
    // rust: );
    // rust: if let Some(add) = first.recipe_book_add {
    // rust: g.send(&raw(ids::RECIPE_BOOK_ADD, add));
}
    // rust: g.send(&raw(ids::UPDATE_ADVANCEMENTS, first.update_advancements));
    // rust: self.native_advancement_grants.push(TickGrants {
    // rust: player: g.uuid,
    // rust: name: g.name.clone(),
    // rust: grants: first.granted,
    // rust: });
    // rust: g.advancements_visible = sync.advancements.visibility(&g.advancements);
    // rust: g.advancements_changed.clear();
    // rust: } else {
    // rust: self.flush_advancements(i, true);
}
}
        // ServerEntity.sendDirtyEntityData: the player's changed attribute
        // instances go to the player too (its trackers get them from
        // track_entities). On the first tick vanilla's ran before
        // ServerPlayer.tick, whose updatePlayerAttributes (and doTick's
        // removeFrost) created the instances the guest's tick just made: they
        // go out on the next tick, after the first chunk batch (#5560). This
        // server's first batch waits for the player's chunks to be ready, so
        // they wait for it too: a slow load must not put them before it.
    // rust: let g = &mut self.guests[i];
    // rust: let after_first_batch = g.unacknowledged > 0 || g.max_unacknowledged > 1;
    // rust: if let Some(m) = g
    // rust: .motion
    // rust: .as_mut()
    // rust: .filter(|_| !first_tick && after_first_batch)
    // rust: {
    // rust: let values = super::attributes::take_dirty(&mut m.attributes);
    // rust: if !values.is_empty() {
    // rust: g.send(&C::UpdateAttributes(play::UpdateAttributes {
    // rust: id: g.entity_id,
    // rust: values,
    // rust: }));
}
}
        // ServerEntity.sendDirtyEntityData: the air supply and the absorption
        // amount the server's body changed go to the player, whose HUD draws
        // them (bubbles, golden hearts).
    // rust: let g = &mut self.guests[i];
    // rust: if let Some(m) = g.motion.as_ref() {
    // rust: let now = (m.air, m.health.absorption());
    // rust: let frozen = m.ticks_frozen;
    // rust: let mut values = Vec::new();
    // rust: if now.0 != g.sent_air.0 {
    // rust: values.push((1, serializer::INT, Value::Int(now.0)));
}
    // rust: if frozen != g.sent_frozen {
    // rust: values.push((7, serializer::INT, Value::Int(frozen)));
}
    // rust: if now.1.to_bits() != g.sent_air.1.to_bits() {
    // rust: values.push((17, serializer::FLOAT, Value::Float(now.1)));
}
    // rust: if !values.is_empty() {
    // rust: g.sent_air = now;
    // rust: g.sent_frozen = frozen;
    // rust: g.send(&C::SetEntityData(play::SetEntityData {
    // rust: id: g.entity_id,
    // rust: values,
    // rust: }));
}
}
        // ServerEntity.sendDirtyEntityData: the shared flags go to the player
        // too, so the sprint a hit stops (Player.causeExtraKnockback) stops
        // on its client.
    // rust: let g = &mut self.guests[i];
    // rust: let shared = shared_flags(g.sneaking, g.sprinting, &guest_body(g));
    // rust: if shared != g.sent_shared {
    // rust: g.sent_shared = shared;
    // rust: g.send(&C::SetEntityData(play::SetEntityData {
    // rust: id: g.entity_id,
    // rust: values: vec![(0, serializer::BYTE, Value::Byte(shared))],
    // rust: }));
}
        // ServerEntity.sendDirtyEntityData: the parrots on the player's
        // shoulders go to the player too, whose own model draws them.
    // rust: let g = &mut self.guests[i];
    // rust: if g.shoulders != g.sent_shoulders {
    // rust: let values = shoulder_changes(g.shoulders, g.sent_shoulders);
    // rust: g.sent_shoulders = g.shoulders;
    // rust: g.send(&C::SetEntityData(play::SetEntityData {
    // rust: id: g.entity_id,
    // rust: values,
    // rust: }));
}
        // Sent when the health or the food level changes, or the saturation
        // reaches or leaves zero; a dead player's health of 0 too.
    // rust: let g = &mut self.guests[i];
    // rust: let health = (g.health, g.food, g.saturation == 0.0);
    // rust: if g.sent_health != Some(health) {
    // rust: g.send(&C::SetHealth(play::SetHealth {
    // rust: health: g.health,
    // rust: food: g.food,
    // rust: saturation: g.saturation,
    // rust: }));
    // rust: g.sent_health = Some(health);
}
    // rust: let xp = {
    // rust: let g = &self.guests[i];
    // rust: (g.xp_progress, g.xp_level, g.xp_total)
}
    // rust: if self.guests[i].sent_xp != Some(xp) {
    // rust: let g = &mut self.guests[i];
    // rust: g.send(&C::SetExperience(play::SetExperience {
    // rust: progress: xp.0,
    // rust: level: xp.1,
    // rust: total: xp.2,
    // rust: }));
    // rust: g.sent_xp = Some(xp);
}
        // AbstractContainerMenu.broadcastChanges for the inventory menu.
    // rust: let mut changes = Vec::new();
    // rust: for slot in 0..46 {
    // rust: let now = self.guests[i].menu_slot(slot);
    // rust: if now != self.guests[i].menu_sent[slot] {
    // rust: changes.push((slot, now));
}
}
    // rust: for (slot, now) in changes {
    // rust: let net = self.stack(&now);
    // rust: let g = &mut self.guests[i];
    // rust: g.menu_state = (g.menu_state + 1) & 0x7FFF;
    // rust: g.send(&C::ContainerSetSlot(play::ContainerSetSlot {
    // rust: container: 0,
    // rust: state: g.menu_state,
    // rust: slot: slot as i16,
    // rust: item: net,
    // rust: }));
    // rust: g.menu_sent[slot] = now;
}
}

    /// `ServerRecipeBook.sendInitialRecipeBook`: each book's open and
    /// filtering flags, then every known recipe.
pub fn send_initial_recipe_book(self: *Self, i: usize) void {
}
    // rust: let g = &self.guests[i];
    // rust: let book = &g.recipe_book;
    // rust: let settings = (0..4)
    // rust: .flat_map(|b| [u8::from(book.open[b]), u8::from(book.filtering[b])])
    // rust: .collect();
    // rust: g.send(&raw(ids::RECIPE_BOOK_SETTINGS, settings));
    // rust: g.send(&raw(
    // rust: ids::RECIPE_BOOK_ADD,
    // rust: self.sync.advancements.initial_recipe_book(book, &self.sync),
    // rust: ));
}

    /// `PlayerList.reloadResources` (`/reload`): every player's advancements
    /// reload against the new data, then everyone gets the tags, and each
    /// player the recipes and their recipe book again.
pub fn reload_resources(self: *Self, sync: *SyncData) void {
}
    // rust: self.lan.shared.set_sync(sync.clone());
    // rust: self.sync = sync.clone();
    // rust: let now = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64);
    // rust: for g in &mut self.guests {
    // rust: let mut granted = Vec::new();
            // PlayerAdvancements.reload: isFirstPacket again, the progress
            // read against the new tree; a player whose advancements were
            // never loaded does that on their first tick.
    // rust: if !g.advancements_loaded {
    // rust: continue;
}
    // rust: g.advancements_visible.clear();
    // rust: g.advancements_changed.clear();
    // rust: if let Some(add) = sync.advancements.reload(
    // rust: &sync,
    // rust: now,
    // rust: &mut g.advancements,
    // rust: &mut g.recipe_book,
    // rust: &mut granted,
    // rust: ) {
    // rust: g.send(&raw(ids::RECIPE_BOOK_ADD, add));
}
    // rust: self.native_advancement_grants.push(TickGrants {
    // rust: player: g.uuid,
    // rust: name: g.name.clone(),
    // rust: grants: granted,
    // rust: });
}
        // broadcastAll(ClientboundUpdateTagsPacket).
    // rust: self.broadcast(&C::UpdateTags(sync.tags.clone()));
        // For each player: ClientboundUpdateRecipesPacket, then
        // sendInitialRecipeBook.
    // rust: for i in 0..self.guests.len() {
    // rust: if !self.guests[i].placed {
    // rust: continue;
}
    // rust: self.guests[i].send(&raw(ids::UPDATE_RECIPES, sync.recipes.clone()));
    // rust: if self.guests[i].brand == "horizon" {
    // rust: send_recipe_content(&self.guests[i]);
}
    // rust: self.send_initial_recipe_book(i);
}
}

    /// `PlayerAdvancements.flushDirty` and the recipes the player unlocked
    /// since (`ServerRecipeBook.addRecipes`), once the player's first tick
    /// has sent their advancements.
pub fn flush_progress(self: *Self, conn: u32) void {
}
    // rust: if let Some(i) = self.guests.iter().position(|g| g.conn == conn)
    // rust: && self.guests[i].sent_health.is_some()
    // rust: {
    // rust: self.flush_advancements(i, true);
            // ServerPlayer.doTick: sendPostEffects when postEffectsDirty.
    // rust: if self.guests[i].post_effects_dirty {
    // rust: self.send_post_effects(i);
}
}
}
pub fn flush_advancements(self: *Self, i: usize, show: bool) void {
}
    // rust: let sync = self.sync.clone();
    // rust: let g = &mut self.guests[i];
    // rust: let mut unlocked = std::mem::take(&mut g.recipes_unlocked);
        // A recipe given and taken before this flush must not reappear.
    // rust: unlocked.retain(|id| g.recipe_book.knows(id));
    // rust: if let Some(add) = sync.advancements.recipes_added(&unlocked, &sync) {
    // rust: g.send(&raw(ids::RECIPE_BOOK_ADD, add));
}
    // rust: let changed = std::mem::take(&mut g.advancements_changed);
    // rust: if let Some(update) = sync.advancements.update(
    // rust: &sync,
    // rust: &g.advancements,
    // rust: &mut g.advancements_visible,
    // rust: &changed,
    // rust: show,
    // rust: ) {
    // rust: g.send(&raw(ids::UPDATE_ADVANCEMENTS, update));
}
}

    /// ClientboundAwardStatsPacket (`ServerStatsCounter.sendStats`): each
    /// statistic as its type and value by network id (`Stat.STREAM_CODEC`),
    /// then its count. Statistics the registries don't know are left out.
pub fn send_stats(self: *Self, conn: u32, stats: *[([]const u8) void {
}
    // rust: let known: Vec<(i32, i32, i32)> = stats
    // rust: .iter()
    // rust: .filter_map(|(ty, key, count)| {
    // rust: let values = match ty.as_str() {
    // rust: "minecraft:mined" => "minecraft:block",
    // rust: "minecraft:killed" | "minecraft:killed_by" => "minecraft:entity_type",
    // rust: "minecraft:custom" => "minecraft:custom_stat",
    // rust: _ => "minecraft:item",
}
    // rust: Some((
    // rust: self.sync.id("minecraft:stat_type", ty)?,
    // rust: self.sync.id(values, key)?,
    // rust: *count,
    // rust: ))
    // rust: })
    // rust: .collect();
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: w.varint(known.len() as i32);
    // rust: for (ty, value, count) in known {
    // rust: w.varint(ty);
    // rust: w.varint(value);
    // rust: w.varint(count);
}
    // rust: self.send_to(conn, &raw(ids::AWARD_STATS, w.data));
}

    // ---- incoming ------------------------------------------------------

    /// The squared movement past 1.0E-5F (handlePlayerKnownMovement).
pub fn moved_far(self: *Self, i: usize, to: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let from = self.guests[i].position;
    // rust: let d: f64 = (0..3).map(|k| (to[k] - from[k]).powi(2)).sum();
    // rust: d > f64::from(1.0E-5_f32)
}

    /// A move still queued for guest `i`, which a packet the game handles
    /// after this pass must not overtake.
pub fn move_queued(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.guests[i].inbox.iter().any(|(p, _)| {
    // rust: matches!(
    // rust: p,
    // rust: S::MovePlayerPos(_)
    // rust: | S::MovePlayerPosRot(_)
    // rust: | S::MovePlayerRot(_)
    // rust: | S::MovePlayerStatus(_)
    // rust: )
    // rust: })
}

    /// handlePlayerCommand's START_SPRINTING and STOP_SPRINTING: `setSprinting`, whose movement
    /// speed modifier the attributes then sync to the client (which takes the modifiers as sent:
    /// one without it would slow a sprinting client to a walk).
pub fn set_sprinting(self: *Self, i: usize, sprinting: bool) void {
}
    // rust: let g = &mut self.guests[i];
    // rust: g.sprinting = sprinting;
    // rust: g.anticheat.sprinting = sprinting;
    // rust: if let Some(m) = g.motion.as_mut() {
    // rust: let _ = m.set_sprint_modifier(sprinting);
}
}

pub fn process_inbox(self: *Self, i: usize, ctx: *mut TickCtx, events: *mut std.ArrayList(HostEvent)) void {
}
        // ServerGamePacketListenerImpl.tickPlayer ran between the last
        // tick's packets and these: resetPosition, and the moves it counted.
    // rust: let g = &mut self.guests[i];
    // rust: g.first_good = g.position;
    // rust: g.known_moves = g.received_moves;
        // ServerPlayer.tick: tickClientLoadTimeout.
    // rust: g.load_timeout = g.load_timeout.saturating_sub(1);
    // rust: let mut budget = PACKETS_PER_TICK;
        // An action the game runs after this pass has a move queued behind it: the
        // move waits for the next tick, but the arm swing the client sent right after
        // the action is still handled with it, as vanilla handles both in this tick
        // (the swing starts the attack strength again, #7817).
    // rust: let mut held = false;
    // rust: while budget > 0 {
    // rust: if held && !matches!(self.guests[i].inbox.front(), Some((S::Punch(_), _))) {
    // rust: break;
}
    // rust: let Some((packet, bytes)) = self.guests[i].inbox.pop_front() else {
    // rust: break;
}
    // rust: self.guests[i].inbox_bytes -= bytes;
    // rust: budget -= 1;
    // rust: let conn = self.guests[i].conn;
            // ServerPlayer.resetLastActionTime: every handler of a player's
            // own action resets it, movement only when it moved
            // (handlePlayerKnownMovement), PlayerInput once loaded.
    // rust: let acted = match &packet {
    // rust: S::AcceptTeleportation(_)
    // rust: | S::PlayerAbilities(_)
    // rust: | S::MovePlayerStatus(_)
    // rust: | S::MovePlayerRot(_)
    // rust: | S::PlayerLoaded(_)
    // rust: | S::ChunkBatchReceived(_)
    // rust: | S::ClientInformation(_)
    // rust: | S::RecipeBookChangeSettings(_)
    // rust: | S::RecipeBookSeenRecipe(_)
    // rust: | S::ClientTickEnd(_)
    // rust: | S::KeepAlive(_)
    // rust: | S::Pong(_) => false,
    // rust: S::MovePlayerPos(p) => self.moved_far(i, [p.x, p.y, p.z]),
    // rust: S::MovePlayerPosRot(p) => self.moved_far(i, [p.x, p.y, p.z]),
    // rust: S::PlayerInput(_) => self.guests[i].client_loaded(),
    // rust: _ => true,
}
    // rust: if acted {
    // rust: self.guests[i].last_action_tick = self.ticks;
}
    // rust: match packet {
                // hasClientLoaded: these handlers ignore the player's actions until
                // the client says the level around it is loaded (or 60 ticks pass),
                // and while it is dead.
    // rust: S::PlayerAction(_)
    // rust: | S::UseItemOn(_)
    // rust: | S::UseItem(_)
    // rust: | S::Attack(_)
    // rust: | S::Interact(_)
    // rust: | S::SpectatorAction(_)
    // rust: | S::PlayerCommand(_)
    // rust: if !self.guests[i].client_loaded() => {}
                // handleAcceptTeleportPacket.
    // rust: S::AcceptTeleportation(p) => {
    // rust: let recording = self.recording();
    // rust: let g = &mut self.guests[i];
    // rust: if let Some((id, at)) = g.awaiting_teleport
    // rust: && id == p.id
    // rust: {
    // rust: if p.x.is_nan()
    // rust: || p.y.is_nan()
    // rust: || p.z.is_nan()
    // rust: || !p.yaw.is_finite()
    // rust: || !p.pitch.is_finite()
    // rust: {
    // rust: self.kick(conn, invalid_movement());
    // rust: continue;
}
    // rust: g.position = at;
    // rust: g.awaiting_teleport = None;
                        // The prediction's replay starts again where the client now is.
    // rust: if recording {
    // rust: let kept = g.awaiting_keeps_motion;
    // rust: g.anticheat
    // rust: .record
    // rust: .get_or_insert_default()
    // rust: .teleported(at, kept);
}
    // rust: let rot = (p.yaw, p.pitch);
    // rust: self.position_change(i, [p.x, p.y, p.z], rot, 0, ctx, events);
}
}
                // handlePlayerAbilities: the client flies only if it may.
    // rust: S::PlayerAbilities(p) => {
    // rust: let g = &mut self.guests[i];
    // rust: let flying = p.flags & 2 != 0 && (g.creative() || g.spectator());
                    // The change is the game's to announce (the mods may refuse it).
    // rust: if flying != g.flying {
    // rust: g.flying = flying;
    // rust: events.push(HostEvent::Flight { conn, flying });
}
}
    // rust: S::MovePlayerPos(p) => {
    // rust: self.move_player(i, Some([p.x, p.y, p.z]), None, p.flags, ctx, events);
}
    // rust: S::MovePlayerPosRot(p) => {
    // rust: let (pos, rot) = ([p.x, p.y, p.z], (p.yaw, p.pitch));
    // rust: self.move_player(i, Some(pos), Some(rot), p.flags, ctx, events);
}
    // rust: S::MovePlayerRot(p) => {
    // rust: self.move_player(i, None, Some((p.yaw, p.pitch)), p.flags, ctx, events);
}
    // rust: S::MovePlayerStatus(p) => {
    // rust: self.move_player(i, None, None, p.flags, ctx, events);
}
                // handleAcceptPlayerLoad: markClientLoaded.
    // rust: S::PlayerLoaded(_) => {
    // rust: let g = &mut self.guests[i];
    // rust: g.loaded = true;
    // rust: g.loading = false;
    // rust: g.load_timeout = 0;
    // rust: events.push(HostEvent::PlayerLoaded(conn));
}
                // PlayerChunkSender.onChunkBatchReceivedByClient.
    // rust: S::ChunkBatchReceived(p) => {
    // rust: let g = &mut self.guests[i];
    // rust: g.unacknowledged = g.unacknowledged.saturating_sub(1);
    // rust: g.chunks_per_tick = if p.chunks_per_tick.is_nan() {
    // rust: 0.01
    // rust: } else {
    // rust: p.chunks_per_tick.clamp(0.01, 64.0)
}
    // rust: if g.unacknowledged == 0 {
    // rust: g.batch_quota = 1.0;
}
    // rust: g.max_unacknowledged = 10;
}
    // rust: S::Pong(p) => self.anticheat_pong(i, p.id),
                // handleAttack is the game's too: a move queued behind an attack would move
                // the player (or land them on the ground, losing a falling attack's critical
                // hit) before the game checks their reach and state.
    // rust: S::Attack(p) => {
    // rust: if !self.anticheat_attack(i, p.id, events) {
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::Attack(p))));
    // rust: held = self.move_queued(i);
}
}
    // rust: S::Punch(p) => {
    // rust: self.anticheat_swing(i);
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::Punch(p))));
}
    // rust: S::ClientTickEnd(_) => {
                    // handleClientTickEnd: no move this tick, no known movement.
    // rust: let g = &mut self.guests[i];
    // rust: if !g.position_this_tick {
    // rust: g.known_movement = [0.0; 3];
}
    // rust: g.position_this_tick = false;
    // rust: self.anticheat_tick_end(i, events);
}
                // ServerGamePacketListenerImpl.handleRecipeBookSeenRecipePacket:
                // the display the player looked at stops being a new one, so
                // the next `RecipeBookAdd` it is sent does not animate.
    // rust: S::RecipeBookSeenRecipe(p) => {
    // rust: let seen = self
    // rust: .sync
    // rust: .advancements
    // rust: .recipe_of_display(p.recipe)
    // rust: .map(str::to_owned);
    // rust: if let Some(id) = seen {
    // rust: self.guests[i].recipe_book.remove_highlight(&id);
}
}
                // ServerGamePacketListenerImpl.handleSeenAdvancements: the tab the
                // player opened, kept when it names a root with a display
                // (`PlayerAdvancements.setSelectedTab` leaves the tab empty otherwise),
                // and answered with the tab it now keeps when that changed. An id the
                // server has no advancement for changes nothing.
    // rust: S::SeenAdvancements(p) => {
    // rust: if p.action == 0
    // rust: && let Some(id) = p.tab
    // rust: && let Some(keep) = self.sync.advancements.selectable(&id)
    // rust: {
    // rust: let tab = keep.then_some(id);
    // rust: let g = &mut self.guests[i];
    // rust: if g.selected_tab != tab {
    // rust: g.selected_tab = tab.clone();
    // rust: g.send(&C::SelectAdvancementsTab(play::SelectAdvancementsTab {
    // rust: tab,
    // rust: }));
}
}
}
                // ServerGamePacketListenerImpl.handleRecipeBookChangeSettingsPacket.
    // rust: S::RecipeBookChangeSettings(p) => {
    // rust: if let Some(book) = crate::recipe_book::BookType::ALL.get(p.book_type as usize)
    // rust: {
    // rust: let settings = &mut self.guests[i].recipe_book;
    // rust: let changed = settings.open[book.index()] != p.open
    // rust: || settings.filtering[book.index()] != p.filtering;
    // rust: settings.open[book.index()] = p.open;
    // rust: settings.filtering[book.index()] = p.filtering;
    // rust: if changed {
    // rust: events.push(HostEvent::RecipeBookSettings {
    // rust: conn,
    // rust: book: p.book_type,
    // rust: open: p.open,
    // rust: filtering: p.filtering,
    // rust: });
}
}
}
    // rust: S::ClientInformation(info) => {
    // rust: let g = &mut self.guests[i];
    // rust: let old_main_hand = g.info.main_hand;
    // rust: let old_language = g.info.language.clone();
                    // PlayerModelPart.HAT (bit 6): the tab list shows the hat layer.
    // rust: let was_hat = g.info.model_customisation & 0x40 != 0;
    // rust: g.view_distance = i32::from(info.view_distance)
    // rust: .max(2)
    // rust: .min(self.config.view_distance);
    // rust: g.info = info;
    // rust: if g.info.main_hand != old_main_hand {
    // rust: events.push(HostEvent::MainHandChanged(conn, g.info.main_hand == 0));
}
    // rust: if g.info.language != old_language {
    // rust: events.push(HostEvent::LocaleChanged(conn, g.info.language.clone()));
}
    // rust: g.center = None;
    // rust: let hat = g.info.model_customisation & 0x40 != 0;
    // rust: let uuid = g.uuid;
                    // ServerGamePacketListenerImpl.handleClientInformation: UPDATE_HAT to everyone.
    // rust: if hat != was_hat {
    // rust: self.broadcast(&C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: 128,
    // rust: entries: vec![play::PlayerInfo {
    // rust: uuid,
    // rust: show_hat: Some(hat),
    // rust: ..Default::default()
    // rust: }],
    // rust: }));
}
}
    // rust: S::PlayerInput(p) => {
    // rust: let g = &mut self.guests[i];
    // rust: g.input = p.flags;
    // rust: if g.client_loaded() {
                        // The events only tell the mods: nothing is queued with none loaded.
    // rust: let listening = self.mods_loaded;
    // rust: if listening {
    // rust: events.push(HostEvent::Input {
    // rust: conn,
    // rust: flags: i32::from(p.flags),
    // rust: });
}
    // rust: let sneaking = p.flags & 32 != 0;
    // rust: if g.sneaking != sneaking {
    // rust: g.sneaking = sneaking;
    // rust: if listening {
    // rust: events.push(HostEvent::Sneak { conn, sneaking });
}
}
}
                    // handlePlayerInput only records keys and updates crouching.
                    // Sprinting persists after the sprint key is released (or
                    // starts with a double tap); PlayerCommand changes it.
}
                // OPEN_INVENTORY (the ridden mount's inventory) and
                // START_FALL_FLYING (checked against the guest's chest slot
                // and effects) are the game's.
                // START_RIDING_JUMP and STOP_RIDING_JUMP: the vehicle's
                // PlayerRideableJumping (handleStartJump / handleStopJump).
    // rust: S::PlayerCommand(p) if matches!(p.action, 3 | 4) => {
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::PlayerCommand(p))));
}
    // rust: S::PlayerCommand(p) if matches!(p.action, 5 | 6) => {
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::PlayerCommand(p))));
}
    // rust: S::PlayerCommand(p) => match p.action {
    // rust: 1 | 2 => {
    // rust: let sprinting = p.action == 1;
    // rust: let changed = self.guests[i].sprinting != sprinting;
    // rust: self.set_sprinting(i, sprinting);
                        // The game tells the mods of a change.
    // rust: if changed {
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::PlayerCommand(p))));
}
}
                    // STOP_SLEEPING.
    // rust: 0 => self.wake(i),
    // rust: _ => {}
    // rust: },
    // rust: S::Chat(c) => self.handle_chat(i, c, events),
    // rust: S::ChatAck(p) => self.chat_ack(i, p.offset, events),
    // rust: S::ChatSessionUpdate(p) => self.chat_session_update(i, p, events),
                // handlePlayerAction (a dig starting, stopping or finishing) is the
                // game's, run after this pass. A move queued behind it is checked
                // against the block the player just broke and falls through, so it
                // would be sent back; it waits for the next tick, when the block is
                // gone, as vanilla handles the packets in order.
    // rust: S::PlayerAction(p) if p.action <= 3 => {
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::PlayerAction(p))));
    // rust: held = self.move_queued(i);
}
                // handleUseItem uses the player's position and known movement now:
                // a later move must not overtake a throw before the game runs it.
    // rust: S::UseItem(p) => {
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::UseItem(p))));
    // rust: held = self.move_queued(i);
}
                // handleUseItemOn is the game's too, and BlockItem.canPlace checks
                // the player's box where they clicked from (Level.isUnobstructed), as
                // their client's prediction did. After the move behind it, a player
                // jumping up a pillar was already clear of the cell their client had
                // refused: the block went down without the place sound that only the
                // placer's client plays (BlockItem.place's playSound(player, ...)).
    // rust: S::UseItemOn(p) => {
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::UseItemOn(p))));
    // rust: held = self.move_queued(i);
}
                // handleInteract is the game's too, like handleAttack above: a move queued
                // behind it waits for the next tick.
    // rust: S::Interact(p) => {
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::Interact(p))));
    // rust: held = self.move_queued(i);
}
                // ContainerInput's codec (ByIdMap, OutOfBoundsStrategy.ZERO) reads an
                // unknown click type as PICKUP.
    // rust: S::ContainerClick(mut p) => {
    // rust: if !(0..=6).contains(&p.input) {
    // rust: p.input = 0;
}
    // rust: events.push(HostEvent::Packet(conn, Box::new(S::ContainerClick(p))));
}
                // ServerboundSelectBundleItemPacket's constructor: no index below -1.
    // rust: S::SelectBundleItem(p) if p.index < -1 => {
    // rust: let reason = format!("Invalid selectedItemIndex: {}", p.index);
    // rust: self.kick(conn, literal(&reason));
}
    // rust: other => events.push(HostEvent::Packet(conn, Box::new(other))),
}
}
}

    /// ServerGamePacketListenerImpl.handleMovePlayer.
    // rust: fn move_player(
    // rust: &mut self,
    // rust: i: usize,
    // rust: pos: Option<[f64; 3]>,
    // rust: rot: Option<(f32, f32)>,
    // rust: flags: u8,
    // rust: ctx: &TickCtx,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) {
    // rust: let conn = self.guests[i].conn;
        // containsInvalidValues, on the packet's values (0 where it has none).
    // rust: let (yaw, pitch) = rot.unwrap_or_default();
    // rust: if pos.is_some_and(|p| p.iter().any(|v| v.is_nan()))
    // rust: || !yaw.is_finite()
    // rust: || !pitch.is_finite()
    // rust: {
    // rust: self.kick(conn, invalid_movement());
    // rust: return;
}
    // rust: if self.anticheat.is_some() {
    // rust: self.anticheat_moved(i, pos, rot, flags);
}
    // rust: let g = &mut self.guests[i];
    // rust: if pos.is_some() {
    // rust: if g.position_this_tick {
    // rust: self.kick(conn, invalid_movement());
    // rust: return;
}
    // rust: g.position_this_tick = true;
}
        // handleMovePlayer: nothing moves before the client has loaded.
    // rust: if g.landing || !g.client_loaded() {
    // rust: return;
}
        // updateAwaitingTeleport: moves wait for the client to accept the
        // teleport, which is sent again after 20 ticks without an answer.
    // rust: if let Some((_, at)) = g.awaiting_teleport {
    // rust: if self.ticks - g.teleport_tick > 20 {
    // rust: self.resend_teleport(i, Some(at));
}
    // rust: return;
}
    // rust: let to = pos.unwrap_or(g.position);
    // rust: let rot = rot.unwrap_or((g.yaw, g.pitch));
    // rust: self.position_change(i, to, rot, flags, ctx, events);
}

    /// ServerGamePacketListenerImpl.handlePlayerPositionChange.
    // rust: fn position_change(
    // rust: &mut self,
    // rust: i: usize,
    // rust: to: [f64; 3],
    // rust: (yaw, pitch): (f32, f32),
    // rust: flags: u8,
    // rust: ctx: &TickCtx,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) {
    // rust: let (frozen, (check, elytra_check)) = (self.ticking.1, self.movement_checks);
    // rust: let g = &mut self.guests[i];
    // rust: let owner = self.singleplayer_owner == Some(g.uuid);
    // rust: let to = [
    // rust: to[0].clamp(-3.0E7, 3.0E7),
    // rust: to[1].clamp(-2.0E7, 2.0E7),
    // rust: to[2].clamp(-3.0E7, 3.0E7),
    // rust: ];
    // rust: let (yaw, pitch) = (wrap_degrees(yaw), wrap_degrees(pitch));
        // A passenger only turns: its vehicle carries it (absSnapTo where it is).
    // rust: if g.vehicle.is_some() {
    // rust: (g.yaw, g.pitch) = (yaw, pitch);
    // rust: return;
}
    // rust: let d = [0, 1, 2].map(|k| to[k] - g.first_good[k]);
    // rust: let moved = d[0] * d[0] + d[1] * d[1] + d[2] * d[2];
    // rust: if g.sleeping {
    // rust: if moved > 1.0 {
    // rust: (g.yaw, g.pitch) = (yaw, pitch);
    // rust: self.resend_teleport(i, None);
}
    // rust: return;
}
        // TickRateManager.runsNormally: not frozen (a frozen game's steps
        // are not counted either; Horizon's hub does not see them).
    // rust: if !frozen {
    // rust: g.received_moves += 1;
    // rust: let mut packets = g.received_moves - g.known_moves;
    // rust: if packets > 5 {
    // rust: packets = 1;
}
            // shouldCheckPlayerMovement (never the single-player owner).
    // rust: if !owner && check && (!g.fall_flying || elytra_check) {
    // rust: let limit = if g.fall_flying { 300.0 } else { 100.0 };
                // `movedDist - expectedDist` (getDeltaMovement): the velocity
                // the server last simulated for the guest is expected
                // movement, not a violation — a landing glide keeps its speed.
    // rust: let expected = g.motion.as_ref().map_or(0.0, |m| {
    // rust: let v = m.velocity;
    // rust: v.x * v.x + v.y * v.y + v.z * v.z
    // rust: });
    // rust: if moved - expected > limit * f64::from(packets) {
    // rust: events.push(HostEvent::Warn(format!(
    // rust: "{} moved too quickly! {},{},{}",
    // rust: g.name,
    // rust: crate::java_text::double_to_string(d[0]),
    // rust: crate::java_text::double_to_string(d[1]),
    // rust: crate::java_text::double_to_string(d[2])
    // rust: )));
    // rust: self.resend_teleport(i, None);
    // rust: return;
}
}
}
    // rust: let start = g.position;
    // rust: let (wrongly, refused, stands) = self.collide(i, to, ctx);
    // rust: if wrongly {
    // rust: let line = format!("{} moved wrongly!", self.guests[i].name);
    // rust: events.push(HostEvent::Warn(line));
}
    // rust: if refused {
    // rust: let g = &mut self.guests[i];
    // rust: (g.yaw, g.pitch) = (yaw, pitch);
    // rust: self.resend_teleport(i, Some(start));
    // rust: return;
}
        // The anticheat's `ground`: a claim of the ground with nothing to
        // stand on is dropped (no-fall, walking on water).
    // rust: let (mut flags, mut corrected) = (flags, false);
    // rust: if flags & 1 != 0 && self.anticheat.is_some() {
    // rust: match self.anticheat_ground(i, to, stands, ctx, events) {
    // rust: Some(true) => {
    // rust: let g = &mut self.guests[i];
    // rust: (g.yaw, g.pitch) = (yaw, pitch);
    // rust: return;
}
    // rust: Some(false) => (flags, corrected) = (flags & !1, true),
    // rust: None => {}
}
}
        // clientIsFloating, from the move that is accepted: no upward-or-level
        // step onto something, nothing but air around the body, and nothing
        // that lets the player hover (the server's allow-flight, mayfly,
        // levitation, gliding, riptide). A move whose ground claim the anticheat dropped never counts:
        // a false claim ends in the anticheat's own kick, logged and told to the operators, or not at all.
    // rust: let floating = !corrected && ctx.collision.is_some() && {
    // rust: let g = &self.guests[i];
    // rust: to[1] - g.position[1] >= -0.03125
    // rust: && !stands
    // rust: && !g.spectator()
    // rust: && !self.config.allow_flight
    // rust: && !g.creative()
    // rust: && g.effects.get("levitation").is_none()
    // rust: && !g.fall_flying
    // rust: && !g
    // rust: .motion
    // rust: .as_ref()
    // rust: .is_some_and(|m| m.auto_spin_attack_ticks > 0)
    // rust: && self.no_blocks_around(i, to, ctx.world)
}
        // handlePlayerPositionChange: a client that says it is on the ground while the last move
        // the server resolved came down onto nothing is sent the blocks under it again, so a
        // client that missed a block change cannot stand on air for good.
    // rust: if flags & 1 != 0 && !self.guests[i].rests_on_ground {
    // rust: self.force_send_player_support_blocks(i, ctx);
}
    // rust: let g = &mut self.guests[i];
    // rust: g.client_is_floating = floating;
        // Entity.move's verticalCollisionBelow, which the check above reads of the last move.
    // rust: g.rests_on_ground = stands;
    // rust: g.previous_position = g.position;
    // rust: g.position = to;
        // ServerChunkCache.move: its pairs are checked again.
    // rust: g.moved = true;
    // rust: let moved = [0, 1, 2].map(|k| g.position[k] - g.previous_position[k]);
    // rust: if g.moves.is_empty() {
    // rust: g.moves_from_ground = g.on_ground;
}
    // rust: g.moves.push((moved, flags & 1 != 0));
    // rust: g.known_movement = moved;
    // rust: g.yaw = yaw;
    // rust: g.pitch = pitch.clamp(-90.0, 90.0);
    // rust: g.head_yaw = g.yaw;
    // rust: g.on_ground = flags & 1 != 0;
    // rust: g.ticks = g.ticks.max(1);
}

    /// `ServerGamePacketListenerImpl.noBlocksAround`: every block of the
    /// player's box grown by 0.0625 and stretched 0.55 down is air. Vanilla
    /// loads a chunk it reads; a chunk not loaded here yet (a player's first
    /// move after joining, before the spawn chunks are generated) is not
    /// known to be air, so it never makes the player float.
pub fn no_blocks_around(self: *Self, i: usize, at: [f64; 3], world: *World) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = self.guests[i].dimensions();
    // rust: let half = f64::from(d.width) / 2.0 + 0.0625;
    // rust: let lo = [at[0] - half, at[1] - 0.0625 - 0.55, at[2] - half];
    // rust: let hi = [
    // rust: at[0] + half,
    // rust: at[1] + f64::from(d.height) + 0.0625,
    // rust: at[2] + half,
    // rust: ];
    // rust: no_blocks_in(world, lo, hi)
}

    /// `ServerGamePacketListenerImpl.forceSendPlayerSupportBlocks`: the blocks just under the
    /// player's box, at the box's four corners a hundred-thousandth below its floor, each once.
    /// A client whose block below went missing without it noticing keeps standing on that block
    /// on the server, so the server tells it what is there (`ClientboundBlockUpdatePacket`, and
    /// the block entity's update tag where it has one, `BlockEntity.getUpdatePacket`). No more
    /// than once every 200 ticks of the connection, so a client that stands on air for good is
    /// not sent four packets four times a second.
pub fn force_send_player_support_blocks(self: *Self, i: usize, ctx: *TickCtx) void {
}
    // rust: let tick = self.ticks.saturating_sub(self.guests[i].joined_tick);
    // rust: if tick < self.guests[i].support_blocks_sent.saturating_add(200) {
    // rust: return;
}
    // rust: self.guests[i].support_blocks_sent = tick;
    // rust: let conn = self.guests[i].conn;
    // rust: let g = &self.guests[i];
    // rust: let d = g.dimensions();
    // rust: let half = f64::from(d.width) / 2.0;
    // rust: let at = g.position;
        // `box.minY - 9.999999747378752E-6`, which is (double) 1.0E-5f.
    // rust: let y = at[1] - f64::from(1.0E-5_f32);
    // rust: let cell = |v: f64| v.floor() as i32;
    // rust: let mut positions: Vec<[i32; 3]> = Vec::with_capacity(4);
    // rust: for (x, z) in [
    // rust: (at[0] - half, at[2] - half),
    // rust: (at[0] + half, at[2] - half),
    // rust: (at[0] - half, at[2] + half),
    // rust: (at[0] + half, at[2] + half),
    // rust: ] {
    // rust: let pos = [cell(x), cell(y), cell(z)];
    // rust: if !positions.contains(&pos) {
    // rust: positions.push(pos);
}
}
    // rust: for pos in positions {
    // rust: let state = ctx.world.block(pos[0], pos[1], pos[2]);
    // rust: self.send_to(
    // rust: conn,
    // rust: &C::BlockUpdate(play::BlockUpdate {
    // rust: pos,
    // rust: state: state.0 as i32,
    // rust: }),
    // rust: );
    // rust: let Some(entity) = ctx.world.block_entities.get(&(pos[0], pos[1], pos[2])) else {
    // rust: continue;
}
    // rust: let Some(tag) = self.encoder.update_tag((pos[0], pos[1], pos[2]), entity) else {
    // rust: continue;
}
    // rust: let Some(kind) = self.encoder.entity_type(state.0) else {
    // rust: continue;
}
    // rust: self.send_to(
    // rust: conn,
    // rust: &C::BlockEntityData(play::BlockEntityData { pos, kind, tag }),
    // rust: );
}
}

    /// `ServerGamePacketListenerImpl.tickPlayer`'s flying check: a player the
    /// last move left hovering for more than `getMaximumFlyingTicks` ticks is
    /// kicked.
pub fn tick_floating(self: *Self, i: usize, events: *mut std.ArrayList(HostEvent)) void {
}
    // rust: let g = &mut self.guests[i];
    // rust: if g.client_is_floating && !g.sleeping && g.vehicle.is_none() && !g.dead {
    // rust: g.above_ground_ticks += 1;
    // rust: if g.above_ground_ticks > maximum_flying_ticks(PLAYER_GRAVITY) {
    // rust: let line = format!("{} was kicked for floating too long!", g.name);
    // rust: let conn = g.conn;
    // rust: events.push(HostEvent::Warn(line));
    // rust: self.kick(conn, translatable("multiplayer.disconnect.flying", &[]));
}
    // rust: } else {
    // rust: g.client_is_floating = false;
    // rust: g.above_ground_ticks = 0;
}
        // The vehicle the player drives, by its own gravity: a boat may hover 160 ticks, a horse 80.
    // rust: let g = &mut self.guests[i];
    // rust: if g.vehicle_floating && g.vehicle.is_some() {
    // rust: g.above_ground_vehicle_ticks += 1;
    // rust: if g.above_ground_vehicle_ticks > maximum_flying_ticks(g.vehicle_gravity) {
    // rust: let line = format!("{} was kicked for floating a vehicle too long!", g.name);
    // rust: let conn = g.conn;
    // rust: events.push(HostEvent::Warn(line));
    // rust: self.kick(conn, translatable("multiplayer.disconnect.flying", &[]));
}
    // rust: } else {
    // rust: g.vehicle_floating = false;
    // rust: g.above_ground_vehicle_ticks = 0;
}
}

    /// The collision part of handlePlayerPositionChange: whether the move
    /// counts as moved wrongly (logged), and whether it is refused (the
    /// player is sent back where they were).
pub fn collide(self: *Self, i: usize, to: [f64; 3], ctx: *TickCtx) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let g = &self.guests[i];
        // noPhysics (spectators) and sleepers move freely.
    // rust: let Some(binding) = ctx.collision else {
    // rust: return (false, false, false);
}
    // rust: if g.spectator() || g.sleeping {
    // rust: return (false, false, false);
}
        // getBoundingBox: the box of the body's pose (swimming and crawling
        // are 0.6 tall), so a swimmer under a ceiling isn't sent back.
    // rust: let d = g.dimensions();
    // rust: let (half, height) = (f64::from(d.width) / 2.0, f64::from(d.height));
    // rust: let at = |p: [f64; 3]| {
    // rust: Aabb::new(
    // rust: Vec3::new(p[0] - half, p[1], p[2] - half),
    // rust: Vec3::new(p[0] + half, p[1] + height, p[2] + half),
    // rust: )
}
    // rust: let (old, new) = (at(g.position), at(to));
    // rust: let mut scene = SceneCollisions {
    // rust: world: ctx.world,
    // rust: binding,
    // rust: subject: None,
}
        // player.move, then how far from the target it ended (vanilla drops
        // the vertical part: `yDist > -0.5 || yDist < 0.5` always holds).
    // rust: let movement = Vec3::new(
    // rust: to[0] - g.position[0],
    // rust: to[1] - g.position[1],
    // rust: to[2] - g.position[2],
    // rust: );
    // rust: let done = scene
    // rust: .resolve_with_context(
    // rust: old,
    // rust: movement,
    // rust: 0.6,
    // rust: g.on_ground,
                // The mover's own sneaking, as CollisionContext.of(player):
                // a sneaking player descends through scaffolding.
    // rust: CollisionContext::position(g.position[1]).with_descending(g.sneaking),
    // rust: )
    // rust: .ok();
    // rust: let fail = !g.creative()
    // rust: && done.is_some_and(|done| {
    // rust: let (dx, dz) = (movement.x - done.x, movement.z - done.z);
    // rust: dx * dx + dz * dz > 0.0625
    // rust: });
        // Entity.move: verticalCollisionBelow, the player "stands on something".
    // rust: let stands = done.is_some_and(|done| movement.y < 0.0 && done.y != movement.y);
    // rust: if fail && scene.unobstructed(old).unwrap_or(true) {
    // rust: return (true, true, stands);
}
        // isEntityCollidingWithAnythingNew: a block the old box did not
        // already touch.
    // rust: let shrink = f64::from(1.0E-5_f32);
    // rust: let shrink = Vec3::new(shrink, shrink, shrink);
    // rust: let Ok(old_shape) = VoxelShape::from_box(old.deflate(shrink)) else {
    // rust: return (fail, false, stands);
}
    // rust: let context = CollisionContext::position(g.position[1]).with_descending(g.sneaking);
    // rust: let Ok(scan) =
    // rust: BlockCollisionScan::new(&mut scene, context, new.deflate(shrink), false, 1 << 20)
    // rust: else {
    // rust: return (fail, false, stands);
}
    // rust: for hit in scan {
    // rust: let Ok(hit) = hit else { break };
    // rust: if !hit
    // rust: .shape
    // rust: .join_is_not_empty(&old_shape, ShapeOp::AND)
    // rust: .unwrap_or(true)
    // rust: {
    // rust: return (fail, true, stands);
}
}
    // rust: (fail, false, stands)
}

    /// Acknowledge a block interaction (ClientboundBlockChangedAckPacket).
    /// ServerGamePacketListenerImpl.ackBlockChangesUpTo: sent with the next tick's block
    /// changes (`tick`).
pub fn ack(self: *Self, conn: u32, sequence: i32) void {
}
    // rust: if sequence >= 0
    // rust: && let Some(g) = self.guest(conn)
    // rust: {
    // rust: g.ack_up_to.set(g.ack_up_to.get().max(sequence));
}
}

    /// Set a guest's game mode and tell everyone (ServerPlayer.setGameMode).
    // rust: pub fn set_game_mode(
    // rust: &mut self,
    // rust: conn: u32,
    // rust: mode: i32,
    // rust: world: &World,
    // rust: collision: Option<&BlockCollisionRegistry<'_>>,
    // rust: ) {
    // rust: let Some(g) = self.guest_mut(conn) else {
    // rust: return;
}
    // rust: g.change_game_mode(mode);
        // GameType.updatePlayerAbilities: a spectator flies, survival and
        // adventure don't, creative keeps what it had.
    // rust: if g.spectator() {
    // rust: g.flying = true;
    // rust: } else if !g.creative() {
    // rust: g.flying = false;
}
        // ServerPlayerGameMode.changeGameModeForPlayer: a player left flying
        // by the change lands when the ground is within a block.
    // rust: if !g.spectator()
    // rust: && g.flying
    // rust: && let Some(binding) = collision
    // rust: {
    // rust: let mut scene = SceneCollisions {
    // rust: world,
    // rust: binding,
    // rust: subject: None,
}
    // rust: if in_range_of_ground(&mut scene, g.bounds()) {
    // rust: g.flying = false;
}
}
    // rust: let uuid = g.uuid;
    // rust: g.send(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::CHANGE_GAME_MODE,
    // rust: param: mode as f32,
    // rust: }));
    // rust: g.send(&g.abilities());
    // rust: self.broadcast(&C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: 4,
    // rust: entries: vec![play::PlayerInfo {
    // rust: uuid,
    // rust: game_mode: Some(mode),
    // rust: ..Default::default()
    // rust: }],
    // rust: }));
}

    /// A player's nickname changed (None: their name again): kept for chat,
    /// and the Tab list shows it (PlayerInfo UPDATE_DISPLAY_NAME for
    /// everyone).
pub fn set_nickname(self: *Self, uuid: u128, nickname: ?[]const u8) void {
}
    // rust: match nickname {
    // rust: Some(n) => self.nicknames.insert(uuid, n),
    // rust: None => self.nicknames.remove(&uuid),
}
    // rust: self.broadcast(&C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: 0x20,
    // rust: entries: vec![play::PlayerInfo {
    // rust: uuid,
    // rust: display_name: Some(self.nicknames.get(&uuid).map(|n| literal(n))),
    // rust: ..Default::default()
    // rust: }],
    // rust: }));
}

    /// Set a guest's flying speed and tell it (`Abilities.setFlyingSpeed`, then
    /// `onUpdateAbilities`). The abilities packets after carry it too, so a
    /// respawn or a game mode change keeps it.
pub fn set_flying_speed(self: *Self, conn: u32, speed: f32) void {
}
    // rust: let Some(g) = self.guest_mut(conn) else {
    // rust: return;
}
    // rust: g.flying_speed = speed;
        // The server's copy of the body, which the movement replay reads.
    // rust: if let Some(motion) = g.motion.as_mut() {
    // rust: motion.flying_speed = speed;
}
    // rust: g.send(&g.abilities());
}

pub fn disconnect_all(self: *Self) void {
}
    // rust: let reason = translatable("multiplayer.disconnect.server_shutdown", &[]);
    // rust: for g in &self.guests {
    // rust: g.sender.disconnect(reason.clone());
}
}
}

    // rust: impl Hub {
pub fn item_name(self: *Self, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync
    // rust: .builtin
    // rust: .get("minecraft:item")?
    // rust: .name(id)
    // rust: .map(std::sync::Arc::from)
}
pub fn enchantment_name(self: *Self, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync
    // rust: .dynamic
    // rust: .name("minecraft:enchantment", id)
    // rust: .map(str::to_owned)
}
    /// A stack a client sent (`SetCreativeModeSlot`), read with this
    /// server's registries.
pub fn stack_from_network(self: *Self, s: *horizon_protocol::item::Stack) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::item_sync::from_network(s, &self.sync.builtin, &self.sync.dynamic)
}

    /// ServerLevel.removePlayerImmediately, then addRespawnedPlayer: the other players
    /// lose the dead player's entity (ServerEntity.removePairing) and are sent the
    /// respawned one as a new entity at the next tick. Their clients would otherwise keep
    /// the dead body, lying down, wherever the player goes.
pub fn respawned(self: *Self, id: i32) void {
}
    // rust: for g in &mut self.guests {
    // rust: if g.entity_id != id && g.tracker.forget(id) {
    // rust: g.send(&C::RemoveEntities(play::RemoveEntities { ids: vec![id] }));
}
}
}

    /// A respawn point whose block is gone or blocked: the respawning player
    /// is sent NO_RESPAWN_BLOCK_AVAILABLE and says
    /// `block.minecraft.spawn.not_valid` in its chat.
pub fn missing_respawn_block(self: *Self, conn: u32) void {
}
    // rust: self.send_to(
    // rust: conn,
    // rust: &C::GameEvent(play::GameEvent {
    // rust: event: game_event::NO_RESPAWN_BLOCK_AVAILABLE,
    // rust: param: 0.0,
    // rust: }),
    // rust: );
}

    /// PlayerList.respawn: back to `at` with a fresh start. The vanilla client waits on its
    /// level loading screen from the Respawn packet until the level info's "level chunks load
    /// start" event and the chunk under the player, so the packets follow vanilla's order.
pub fn respawn(self: *Self, i: usize, at: [f64; 3], ctx: *TickCtx) void {
}
    // rust: let info = self.spawn_info(i, 0);
    // rust: self.close_container_for(i);
    // rust: let g = &mut self.guests[i];
        // PlayerList.respawn: into the level in place (the respawn level).
    // rust: g.dimension = self.config.dimension.clone();
        // restartClientLoadTimerAfterRespawn: the client loads a whole new level before it
        // reports it loaded.
    // rust: g.load_timeout = super::guest::CLIENT_LOADED_TIMEOUT;
    // rust: g.loading = true;
        // ServerLevel.removePlayerImmediately: the dead player's
        // Entity.setRemoved (KILLED) stops its riding; the new player rides
        // nothing.
    // rust: g.stop_riding();
        // ServerLevel.removePlayerImmediately: every entity paired with the dead player is
        // removed (ServerEntity.removePairing, one packet each). Its chunks are dropped
        // without ForgetLevelChunk (PlayerChunkSender.dropChunk skips dead players): the
        // client keeps them and they are all sent again.
    // rust: for id in g.tracker.ids() {
    // rust: g.send(&C::RemoveEntities(play::RemoveEntities { ids: vec![id] }));
}
    // rust: g.tracker.clear();
    // rust: g.sent_chunks.clear();
    // rust: g.far_sent_chunks.clear();
    // rust: g.chunk_queue.clear();
    // rust: g.far_queue.clear();
    // rust: let id = g.entity_id;
    // rust: self.respawned(id);
    // rust: let g = &mut self.guests[i];
        // ServerPlayer.restoreFrom: the game mode again (onUpdateAbilities).
    // rust: g.send(&g.abilities());
        // The new player faces the level's respawn direction (snapTo).
    // rust: g.yaw = 0.0;
    // rust: g.pitch = 0.0;
    // rust: g.position = at;
    // rust: g.previous_position = at;
    // rust: g.send(&C::Respawn(play::Respawn {
    // rust: spawn: info,
    // rust: keep: 0,
    // rust: }));
        // ClientPacketListener.handleRespawn without KEEP_ENTITY_DATA: the client's new player
        // starts with wasSprinting false. (A level change keeps it: the new player sprints on, or
        // says STOP.)
    // rust: g.anticheat.sprinting = false;
        // The respawned player is a new one, without effects; so is the
        // client's (ClientPacketListener.handleRespawn).
    // rust: g.effects = Default::default();
    // rust: g.sent_effects.clear();
    // rust: g.center = None;
    // rust: g.sent_chunks.clear();
    // rust: g.far_sent_chunks.clear();
    // rust: g.chunk_queue.clear();
    // rust: g.far_queue.clear();
    // rust: g.tracker.clear();
    // rust: self.resend_teleport(i, None);
    // rust: let spawn = self.default_spawn(ctx.spawn);
    // rust: let g = &mut self.guests[i];
    // rust: g.send(&spawn);
    // rust: g.send(&C::ChangeDifficulty(play::ChangeDifficulty {
    // rust: difficulty: ctx.difficulty,
    // rust: locked: ctx.difficulty_locked,
    // rust: }));
    // rust: let xp = (g.xp_progress, g.xp_level, g.xp_total);
    // rust: g.send(&C::SetExperience(play::SetExperience {
    // rust: progress: xp.0,
    // rust: level: xp.1,
    // rust: total: xp.2,
    // rust: }));
    // rust: g.sent_xp = Some(xp);
        // ServerPlayer.sendPostEffects.
    // rust: let list = g.post_effects.clone();
    // rust: g.post_effects_dirty = false;
    // rust: g.send(&C::PostEffects(play::PostEffects { effects: list }));
    // rust: self.send_level_info(i, ctx, true);
    // rust: self.send_permission_level(i);
        // ServerLevel.addRespawnedPlayer: the chunk tracking starts again at the player.
    // rust: let g = &mut self.guests[i];
    // rust: let (cx, cz) = g.chunk();
    // rust: g.send(&C::SetChunkCacheCenter(play::SetChunkCacheCenter {
    // rust: x: cx,
    // rust: z: cz,
    // rust: }));
    // rust: g.center = None;
    // rust: g.center_sent = Some((cx, cz));
        // ServerPlayer.initInventoryMenu.
    // rust: self.send_inventory(i);
}

    /// The level the players are in: the server holds one at a time, and the
    /// hub's packets name it.
pub fn set_dimension(self: *Self, dimension: []const u8) void {
}
    // rust: if self.config.dimension == dimension {
    // rust: return;
}
        // What this level's players were told stays with it.
    // rust: let leaving = LevelSync {
    // rust: last_clock: self.last_clock,
    // rust: last_rate: self.last_rate,
    // rust: weather: self.weather,
}
    // rust: let entering = self.level_sync.remove(dimension).unwrap_or_default();
    // rust: self.level_sync
    // rust: .insert(std::mem::take(&mut self.config.dimension), leaving);
    // rust: (self.last_clock, self.last_rate, self.weather) =
    // rust: (entering.last_clock, entering.last_rate, entering.weather);
    // rust: self.config.dimension = dimension.to_owned();
    // rust: self.dimension_type = self
    // rust: .sync
    // rust: .id("minecraft:dimension_type", dimension)
    // rust: .unwrap_or(0);
    // rust: self.encoder
    // rust: .set_dimension(self.config.levels.get(dimension));
}

    /// ServerPlayer.teleport(TeleportTransition) into the level the hub now
    /// names (`set_dimension`): ClientboundRespawnPacket keeping all data,
    /// then vanilla's packet order. Nothing tracked in the old level is
    /// removed one by one: the client drops its whole level.
    ///
    /// Through a `portal`, vanilla finds the exit (an End platform, a Nether
    /// portal, a spawn column) before the teleport; here it is found once
    /// the destination has loaded around `at`. Until [`Self::land`] the
    /// client gets no position, so it stays on its level loading screen
    /// instead of showing the player in the air at `at`.
    // rust: pub fn change_level(
    // rust: &mut self,
    // rust: i: usize,
    // rust: at: [f64; 3],
    // rust: yaw: f32,
    // rust: pitch: Option<f32>,
    // rust: portal: bool,
    // rust: portal_cooldown: i32,
    // rust: ctx: &TickCtx,
    // rust: ) {
    // rust: let info = self.spawn_info(i, portal_cooldown);
    // rust: self.close_container_for(i);
    // rust: let g = &mut self.guests[i];
    // rust: g.dimension = self.config.dimension.clone();
        // The load timer is not restarted: vanilla resets the client's loaded state on death and
        // respawn only, and covers a level change with its separate `isChangingDimension` term.
    // rust: g.tracker.clear();
    // rust: g.sent_chunks.clear();
    // rust: g.far_sent_chunks.clear();
    // rust: g.chunk_queue.clear();
    // rust: g.far_queue.clear();
    // rust: g.center = None;
    // rust: g.yaw = yaw;
    // rust: if let Some(pitch) = pitch {
    // rust: g.pitch = pitch;
}
    // rust: g.position = at;
    // rust: g.previous_position = at;
    // rust: g.send(&C::Respawn(play::Respawn {
    // rust: spawn: info,
            // ClientboundRespawnPacket.KEEP_ALL_DATA.
    // rust: keep: 3,
    // rust: }));
    // rust: g.send(&C::ChangeDifficulty(play::ChangeDifficulty {
    // rust: difficulty: ctx.difficulty,
    // rust: locked: ctx.difficulty_locked,
    // rust: }));
    // rust: self.send_permission_level(i);
    // rust: if portal {
            // A teleport still pending from the old level is void: its late
            // acceptance must not move the player back there.
    // rust: let g = &mut self.guests[i];
    // rust: g.landing = true;
    // rust: g.awaiting_teleport = None;
    // rust: } else {
    // rust: self.resend_teleport(i, None);
}
    // rust: let g = &mut self.guests[i];
    // rust: g.send(&g.abilities());
    // rust: self.send_level_info(i, ctx, !portal);
        // PlayerList.sendAllPlayerInfo: the inventory and the held slot.
    // rust: self.send_inventory(i);
    // rust: let g = &mut self.guests[i];
    // rust: g.send(&C::SetHeldSlot(play::SetHeldSlot {
    // rust: slot: g.selected as i32,
    // rust: }));
    // rust: self.send_active_effects(i);
    // rust: let g = &mut self.guests[i];
        // ServerPlayer.sendPostEffects.
    // rust: let list = g.post_effects.clone();
    // rust: g.post_effects_dirty = false;
    // rust: g.send(&C::PostEffects(play::PostEffects { effects: list }));
        // lastSentExp, lastSentHealth and lastSentFood; the client's new
        // player starts with the default air and no absorption.
    // rust: g.sent_health = None;
    // rust: g.sent_xp = None;
    // rust: g.sent_air = (300, 0.0);
    // rust: g.sent_frozen = 0;
    // rust: g.sent_shared = 0;
    // rust: g.sent_shoulders = [None; 2];
    // rust: let (cx, cz) = g.chunk();
    // rust: g.send(&C::SetChunkCacheCenter(play::SetChunkCacheCenter {
    // rust: x: cx,
    // rust: z: cz,
    // rust: }));
    // rust: g.center_sent = Some((cx, cz));
}

    /// The rest of a portal's [`Self::change_level`] once its exit is found:
    /// the position, LEVEL_CHUNKS_LOAD_START (the client's loading screen
    /// closes once its chunk is in) and TeleportTransition.PLAY_PORTAL_SOUND.
pub fn land(self: *Self, i: usize, at: [f64; 3]) void {
}
    // rust: self.guests[i].landing = false;
    // rust: self.teleport(i, Some(at));
    // rust: let g = &self.guests[i];
    // rust: g.send(&C::GameEvent(play::GameEvent {
    // rust: event: game_event::LEVEL_CHUNKS_LOAD_START,
    // rust: param: 0.0,
    // rust: }));
    // rust: g.send(&C::LevelEvent(play::LevelEvent {
    // rust: kind: 1032,
    // rust: pos: [0, 0, 0],
    // rust: data: 0,
    // rust: global: false,
    // rust: }));
}
}

/// A packet Horizon sends as raw bytes (no fields worth a type).
/// multiplayer.disconnect.invalid_player_movement.
/// Mth.wrapDegrees.
pub fn wrap_degrees(degrees: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut wrapped = degrees % 360.0;
    // rust: if wrapped >= 180.0 {
    // rust: wrapped -= 360.0;
}
    // rust: if wrapped < -180.0 {
    // rust: wrapped += 360.0;
}
    // rust: wrapped
}

/// The packets of one player handled in a tick; the rest wait for the next.
pub const PACKETS_PER_TICK: usize = 400;
/// The packets a player may have waiting (a second of its budget) before it is
/// disconnected, as vanilla's rate-limit does: no real client gets near it.
pub const INBOX_LIMIT: usize = 20 * PACKETS_PER_TICK;
/// The same in bytes on the wire: 8000 full books would hold gigabytes. A
/// real client's largest packets (a 100-page book) are a few hundred kB.
pub const INBOX_BYTES: usize = 16 << 20;

/// The `minecraft:gravity` attribute of a player.
pub const PLAYER_GRAVITY: f64 = 0.08;

/// `ServerGamePacketListenerImpl.getMaximumFlyingTicks`: 80 ticks, more where
/// gravity is weaker, none at all (never kicked) without gravity.
/// `ServerGamePacketListenerImpl.noBlocksAround` over a box: every block from `lo` to `hi` is air, in
/// loaded chunks (a chunk not loaded yet is not known to be air: nothing floats there).
pub fn no_blocks_in(world: *World, lo: [f64; 3], hi: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cell = |v: f64| v.floor() as i32;
    // rust: (cell(lo[0])..=cell(hi[0])).all(|x| {
    // rust: (cell(lo[2])..=cell(hi[2])).all(|z| {
    // rust: world.loaded(x, z)
    // rust: && (cell(lo[1])..=cell(hi[1])).all(|y| world.is_air(world.block(x, y, z)))
    // rust: })
    // rust: })
}

pub fn maximum_flying_ticks(gravity: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if gravity < f64::from(1.0E-5_f32) {
    // rust: return i32::MAX;
}
    // rust: let modifier = 0.08 / gravity;
    // Mth.ceil is (int) with a floor correction; a double past int range
    // saturates like the Java cast.
    // rust: (80.0 * modifier.max(1.0)).ceil() as i32
}

pub fn invalid_movement() T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: translatable("multiplayer.disconnect.invalid_player_movement", &[])
}

/// The recipe content the native mods asked for (`lan::recipes::content`),
/// to one Horizon client: none when no mod asked.
pub fn send_recipe_content(g: *Guest) void {
}
    // rust: for data in super::recipes::content().iter() {
    // rust: g.send(&C::CustomPayload(
    // rust: horizon_protocol::packets::configuration::CustomPayload {
    // rust: channel: super::recipes::CONTENT_CHANNEL.into(),
    // rust: data: data.clone(),
    // rust: },
    // rust: ));
}
}

pub fn raw(id: i32, payload: std.ArrayList(u8)) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: C::Unknown(id, payload)
}

/// The joined states `Hub::note_joined` kept, if it kept them in the last
/// server tick: a level nobody tracked since (its guests gone, or none in it)
/// would otherwise pair its entities from states long past.
pub fn noted_last_tick(noted: Option<(u64) void {
}
    // rust: match noted {
    // rust: Some((tick, joined)) if tick + 1 == ticks => joined,
    // rust: _ => Vec::new(),
}
}

/// ClientboundTickingStatePacket: the tick rate and whether the game is frozen.
pub fn ticking_state(rate: f32, frozen: bool) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: w.f32(rate);
    // rust: w.bool(frozen);
    // rust: raw(ids::TICKING_STATE, w.data)
}

/// What the others see of a guest's body, from its server-side state.
pub fn guest_body(g: *Guest) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let m = g.motion.as_deref();
    // rust: BodyFlags {
    // rust: gliding: g.fall_flying,
    // rust: swimming: m.is_some_and(|m| m.swimming),
    // rust: crawling: m.is_some_and(|m| m.pose == crate::pose::Pose::Swimming && !m.swimming),
    // rust: crouching: m.is_some_and(|m| m.pose == crate::pose::Pose::Crouching),
    // rust: spin_attack: m.is_some_and(|m| m.auto_spin_attack_ticks > 0),
    // rust: on_fire: m.is_some_and(|m| m.fire_ticks > 0),
        // ServerPlayer.updateInvisibilityStatus: a spectator is always invisible.
    // rust: invisible: g.effects.get("invisibility").is_some() || g.spectator(),
    // rust: glowing: g.effects.get("glowing").is_some(),
}
}

/// Entity.DATA_SHARED_FLAGS_ID of a player: on fire 0x01, crouching 0x02,
/// sprinting 0x08, swimming 0x10, invisible 0x20, glowing 0x40, gliding 0x80.
pub fn shared_flags(sneaking: bool, sprinting: bool, body: *BodyFlags) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut shared = 0i8;
    // rust: if body.on_fire {
    // rust: shared |= 0x01;
}
    // rust: if sneaking {
    // rust: shared |= 0x02;
}
    // rust: if sprinting {
    // rust: shared |= 0x08;
}
    // rust: if body.swimming {
    // rust: shared |= 0x10;
}
    // rust: if body.invisible {
    // rust: shared |= 0x20;
}
    // rust: if body.glowing {
    // rust: shared |= 0x40;
}
    // rust: if body.gliding {
    // rust: shared |= -128;
}
    // rust: shared
}

/// The profile properties the player list gives a player: those it logged
/// in with, or for the integrated server's owner (who logs in with none) the
/// signed-in account's, once fetched (`IntegratedServer.getSingleplayerProfile`).
    // rust: fn listed_properties(
    // rust: logged_in: &[horizon_protocol::packets::login::Property],
    // rust: owner: bool,
    // rust: profile: Option<&super::OwnerProfile>,
    // rust: ) -> Vec<horizon_protocol::packets::login::Property> {
    // rust: match profile {
    // rust: Some(profile) if owner && logged_in.is_empty() => profile.properties().to_vec(),
    // rust: _ => logged_in.to_vec(),
}
}

    // rust: mod tests {
    // rust: mod sound_tests;
//     use super::*;
//     use crate::fast_hash::FxHashSet;

    /// A hub with one placed guest, the speed effect registered, and what the
    /// guest is sent.
pub fn hub_with_a_guest() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut sync = SyncData::empty();
    // rust: sync.builtin.registries.insert(
    // rust: "minecraft:mob_effect".to_string(),
    // rust: horizon_protocol::registry::Ids::from_names(vec!["minecraft:speed".to_string()]),
    // rust: );
    // rust: hub_with_sync(sync)
}

    /// [`hub_with_a_guest`] over a sync the test built.
pub fn hub_with_sync(sync: SyncData) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let config = crate::lan::NetConfig {
    // rust: announce: false,
    // rust: ..crate::lan::NetConfig::loopback(0, "EffectSyncTest".into(), 2)
}
    // rust: let sync = std::sync::Arc::new(sync);
    // rust: let lan = Lan::start_with(sync.clone(), config).unwrap();
    // rust: let encoder = ChunkEncoder::new(
    // rust: [] as [(std::sync::Arc<str>, bool); 0],
    // rust: &horizon_protocol::registry::Builtin::default(),
    // rust: &[],
    // rust: &[],
    // rust: );
    // rust: let hub_config = HubConfig {
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
    // rust: let mut hub = Hub::new(lan, sync, encoder, hub_config);
    // rust: let (tx, rx) = std::sync::mpsc::channel();
    // rust: let mut bob = Guest::new(
    // rust: crate::lan::Joined {
    // rust: conn: 1,
    // rust: uuid: 1,
    // rust: name: "Bob".into(),
    // rust: properties: Vec::new(),
    // rust: info: horizon_protocol::packets::configuration::ClientInformation::new(8),
    // rust: brand: "vanilla".into(),
    // rust: sender: crate::lan::PlayerSender::new(tx, std::sync::Arc::default()),
    // rust: latency: std::sync::Arc::new(std::sync::atomic::AtomicI32::new(0)),
    // rust: address: "127.0.0.1:25565".parse().unwrap(),
    // rust: expected: false,
    // rust: },
    // rust: 1,
    // rust: [0.5, 64.0, 0.5],
    // rust: 8,
    // rust: );
    // rust: bob.placed = true;
    // rust: bob.dimension = "minecraft:overworld".into();
    // rust: hub.guests.push(bob);
    // rust: (hub, rx)
}

    /// `onGameRuleChanged`: a changed `reduced_debug_info` reaches each player
    /// as their own entity event 22 / 23, and an unchanged one sends nothing.
pub fn reduced_debug_info_changes_reach_players_as_entity_events() void {
}
    // rust: let (mut hub, rx) = hub_with_a_guest();
    // rust: let id = hub.guests[0].entity_id;
    // rust: let events = |rx: &std::sync::mpsc::Receiver<crate::lan::Out>| {
    // rust: let mut sent = Vec::new();
    // rust: while let Ok(crate::lan::Out::Packet(body)) = rx.try_recv() {
    // rust: let mut r = horizon_protocol::buf::Reader::new(&body);
    // rust: let pid = r.varint().unwrap();
    // rust: if let Ok(C::EntityEvent(p)) = C::decode(pid, r.rest()) {
    // rust: sent.push((p.id, p.event));
}
}
    // rust: sent
}
    // rust: hub.set_reduced_debug_info(false);
    // rust: assert!(events(&rx).is_empty());
    // rust: hub.set_reduced_debug_info(true);
    // rust: hub.set_reduced_debug_info(true);
    // rust: assert_eq!(events(&rx), vec![(id, 22)]);
    // rust: hub.set_reduced_debug_info(false);
    // rust: assert_eq!(events(&rx), vec![(id, 23)]);
}

    /// The blocks the guest was sent as `ClientboundBlockUpdatePacket`s, in order, with the
    /// state each one carries.
pub fn sent_block_updates(rx: *std::sync::mpsc::Receiver<crate::lan::Out>) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut sent = Vec::new();
    // rust: while let Ok(out) = rx.try_recv() {
    // rust: let crate::lan::Out::Packet(body) = out else {
    // rust: continue;
}
    // rust: let mut r = horizon_protocol::buf::Reader::new(&body);
    // rust: let id = r.varint().unwrap();
    // rust: if let Ok(C::BlockUpdate(p)) = C::decode(id, r.rest()) {
    // rust: sent.push((p.pos, p.state));
}
}
    // rust: sent
}

    /// A world whose blocks at y = 63 are `state` under the four chunks around the origin.
pub fn floor_at(state: u32) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut world = World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: for cz in -1..=0 {
    // rust: for cx in -1..=0 {
    // rust: let mut chunk = crate::chunk::Chunk::empty(cx, cz);
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: chunk.set(x, 63, z, state);
}
}
    // rust: chunk.lit = true;
    // rust: world.chunks.insert((cx, cz), std::sync::Arc::new(chunk));
}
}
    // rust: world
}

    /// One tick of the hub that handles a single packet from the guest.
pub fn tick_packet(hub: *mut Hub, world: *mut World, packet: S) void {
}
    // rust: hub.guests[0].inbox.push_back((packet, 0));
    // rust: let mut next_entity = 2;
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut ctx = TickCtx {
    // rust: world,
    // rust: entities: &[],
    // rust: next_entity: &mut next_entity,
    // rust: spawn: [0.5, 64.0, 0.5],
    // rust: difficulty: 2,
    // rust: difficulty_locked: false,
    // rust: clock_rate: 1.0,
    // rust: tick_rate: 20.0,
    // rust: tick_frozen: false,
    // rust: tick_steps: Default::default(),
    // rust: collision: None,
    // rust: border: &border,
    // rust: streaming: None,
}
    // rust: let _ = hub.drain_packets(&mut ctx);
}

    /// One tick of the hub that handles a single position move from the guest.
pub fn tick_guest_move(hub: *mut Hub, world: *mut World, to: [f64; 3], flags: u8) void {
}
        // One position move per client tick (receivedPositionThisTick).
    // rust: hub.guests[0].position_this_tick = false;
    // rust: tick_packet(
    // rust: hub,
    // rust: world,
    // rust: S::MovePlayerPos(play::MovePlayerPos {
    // rust: x: to[0],
    // rust: y: to[1],
    // rust: z: to[2],
    // rust: flags,
    // rust: }),
    // rust: );
}

    /// `ServerGamePacketListenerImpl.forceSendPlayerSupportBlocks`: a client that says it stands
    /// while the last move the server resolved came down onto nothing is sent the blocks under
    /// its box again (its four corners, each once), so a client that missed a block change cannot
    /// stay standing on air. At most once every 200 ticks of the connection.
pub fn a_guest_standing_on_nothing_is_sent_the_blocks_below_it() void {
}
        // Block state 1 is stone in the vanilla registry order.
pub const STONE: u32 = 1;
    // rust: let (mut hub, rx) = hub_with_a_guest();
    // rust: hub.guests[0].load_timeout = 0;
        // Across a block corner: the box's four corners are four different blocks.
    // rust: hub.guests[0].position = [0.0, 64.0, 0.0];
    // rust: let mut world = floor_at(STONE);
        // The connection's 200th tick is the first that may send: vanilla starts the count at 0.
    // rust: hub.ticks = 199;
    // rust: tick_guest_move(&mut hub, &mut world, [0.0, 64.0, 0.0], 1);
    // rust: assert!(
    // rust: sent_block_updates(&rx).is_empty(),
    // rust: "the first 200 ticks of a connection send nothing"
    // rust: );
    // rust: hub.ticks = 200;
    // rust: tick_guest_move(&mut hub, &mut world, [0.0, 64.0, 0.0], 1);
    // rust: assert_eq!(
    // rust: sent_block_updates(&rx),
    // rust: vec![
    // rust: ([-1, 63, -1], STONE as i32),
    // rust: ([0, 63, -1], STONE as i32),
    // rust: ([-1, 63, 0], STONE as i32),
    // rust: ([0, 63, 0], STONE as i32),
    // rust: ],
    // rust: "the four blocks under the box, each once, with the server's states"
    // rust: );
        // A tick later: the next 200 have to pass first.
    // rust: hub.ticks = 201;
    // rust: tick_guest_move(&mut hub, &mut world, [0.0, 64.0, 0.0], 1);
    // rust: assert!(
    // rust: sent_block_updates(&rx).is_empty(),
    // rust: "no more than once every 200 ticks"
    // rust: );
        // The last move the server resolved came down onto something: it stands on its own.
    // rust: hub.guests[0].rests_on_ground = true;
    // rust: hub.ticks = 500;
    // rust: tick_guest_move(&mut hub, &mut world, [0.0, 64.0, 0.0], 1);
    // rust: assert!(
    // rust: sent_block_updates(&rx).is_empty(),
    // rust: "a player the server saw land is not resent the blocks"
    // rust: );
        // A client that does not claim the ground is not helped either.
    // rust: hub.guests[0].rests_on_ground = false;
    // rust: hub.ticks = 800;
    // rust: tick_guest_move(&mut hub, &mut world, [0.0, 64.0, 0.0], 0);
    // rust: assert!(
    // rust: sent_block_updates(&rx).is_empty(),
    // rust: "only a claim of standing on the ground asks for the blocks below"
    // rust: );
        // A box over one block gets that block once (the corners are the same cell).
    // rust: hub.ticks = 1100;
    // rust: hub.guests[0].position = [0.5, 64.0, 0.5];
    // rust: tick_guest_move(&mut hub, &mut world, [0.5, 64.0, 0.5], 1);
    // rust: assert_eq!(
    // rust: sent_block_updates(&rx),
    // rust: vec![([0, 63, 0], STONE as i32)],
    // rust: "one block under a box that sits across a block"
    // rust: );
}

    /// The tabs the guest was sent in `ClientboundSelectAdvancementsTabPacket`s, in order.
pub fn sent_tabs(rx: *std::sync::mpsc::Receiver<crate::lan::Out>) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut sent = Vec::new();
    // rust: while let Ok(out) = rx.try_recv() {
    // rust: let crate::lan::Out::Packet(body) = out else {
    // rust: continue;
}
    // rust: let mut r = horizon_protocol::buf::Reader::new(&body);
    // rust: let id = r.varint().unwrap();
    // rust: if let Ok(C::SelectAdvancementsTab(p)) = C::decode(id, r.rest()) {
    // rust: sent.push(p.tab);
}
}
    // rust: sent
}

    /// A data folder holding two advancements: `minecraft:root`, a root with a display, and
    /// `minecraft:task`, which hangs off it.
pub fn advancement_data() s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-advancement-tab-{}-{:?}",
    // rust: std::process::id(),
    // rust: std::thread::current().id()
    // rust: ));
    // rust: let folder = root.join("data").join("minecraft").join("advancement");
    // rust: std::fs::create_dir_all(&folder).unwrap();
    // rust: let display = |icon: &str, title: &str| {
    // rust: format!(r#"{{"icon":{{"id":"{icon}"}},"title":"{title}","description":"{title}"}}"#)
}
    // rust: std::fs::write(
    // rust: folder.join("root.json"),
    // rust: format!(
    // rust: r#"{{"display":{},"criteria":{{}}}}"#,
    // rust: display("minecraft:stone", "Root")
    // rust: ),
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(
    // rust: folder.join("task.json"),
    // rust: format!(
    // rust: r#"{{"parent":"minecraft:root","display":{},"criteria":{{}}}}"#,
    // rust: display("minecraft:dirt", "Task")
    // rust: ),
    // rust: )
    // rust: .unwrap();
    // rust: root
}

    /// ServerGamePacketListenerImpl.handleSeenAdvancements with PlayerAdvancements.setSelectedTab:
    /// the tab a player opens is kept when it names a root with a display, and the player is told
    /// the tab the server keeps — none for anything else — whenever that changed. A closed screen
    /// says nothing about the tab.
pub fn an_advancement_tab_a_guest_opens_is_kept_and_answered() void {
}
    // rust: let data = advancement_data();
    // rust: let mut sync = SyncData::empty();
    // rust: sync.advancements = crate::lan::advancements::ServerAdvancements::load(
    // rust: &data,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: Default::default(),
    // rust: Default::default(),
    // rust: );
    // rust: assert_eq!(
    // rust: sync.advancements.selectable("minecraft:root"),
    // rust: Some(true),
    // rust: "the fixture's root is selectable"
    // rust: );
    // rust: let (mut hub, rx) = hub_with_sync(sync);
    // rust: hub.guests[0].load_timeout = 0;
    // rust: let mut world = World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let open = |tab: &str| {
    // rust: S::SeenAdvancements(play::SeenAdvancements {
    // rust: action: 0,
    // rust: tab: Some(tab.to_owned()),
    // rust: })
}
        // The root the client opens is the tab the server keeps now.
    // rust: tick_packet(&mut hub, &mut world, open("minecraft:root"));
    // rust: assert_eq!(sent_tabs(&rx), vec![Some("minecraft:root".to_owned())]);
    // rust: assert_eq!(
    // rust: hub.guests[0].selected_tab.as_deref(),
    // rust: Some("minecraft:root")
    // rust: );
        // Opening it again changes nothing, so nothing is sent.
    // rust: tick_packet(&mut hub, &mut world, open("minecraft:root"));
    // rust: assert!(
    // rust: sent_tabs(&rx).is_empty(),
    // rust: "an unchanged tab is not sent again"
    // rust: );
        // A tab that is not a root takes the selection away, and the client is told so.
    // rust: tick_packet(&mut hub, &mut world, open("minecraft:task"));
    // rust: assert_eq!(sent_tabs(&rx), vec![None]);
    // rust: assert_eq!(hub.guests[0].selected_tab, None);
        // The root again, then an id the server has no advancement for: vanilla's
        // `ServerAdvancementManager.get` is null, `setSelectedTab` is not called, and the
        // tab stays.
    // rust: tick_packet(&mut hub, &mut world, open("minecraft:root"));
    // rust: assert_eq!(sent_tabs(&rx), vec![Some("minecraft:root".to_owned())]);
    // rust: tick_packet(&mut hub, &mut world, open("minecraft:nowhere"));
    // rust: assert!(sent_tabs(&rx).is_empty(), "an unknown id changes nothing");
    // rust: assert_eq!(
    // rust: hub.guests[0].selected_tab.as_deref(),
    // rust: Some("minecraft:root")
    // rust: );
        // The closed screen keeps the tab the server has.
    // rust: tick_packet(
    // rust: &mut hub,
    // rust: &mut world,
    // rust: S::SeenAdvancements(play::SeenAdvancements {
    // rust: action: 1,
    // rust: tab: None,
    // rust: }),
    // rust: );
    // rust: assert!(sent_tabs(&rx).is_empty(), "a closed screen keeps the tab");
    // rust: assert_eq!(
    // rust: hub.guests[0].selected_tab.as_deref(),
    // rust: Some("minecraft:root")
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&data);
}

    /// `handlePlayerCommand` START_RIDING_JUMP (3) and STOP_RIDING_JUMP (4): the
    /// hub used to drop both, so a guest's released jump bar never reached the
    /// mount they ride, and neither did the horse's rear or its jump sound.
pub fn a_guests_riding_jump_reaches_the_game() void {
}
    // rust: let (mut hub, _rx) = hub_with_a_guest();
        // hasClientLoaded: the handlers ignore a player's actions until then.
    // rust: hub.guests[0].load_timeout = 0;
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let mut next_entity = 100;
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut ctx = TickCtx {
    // rust: world: &mut world,
    // rust: entities: &[],
    // rust: next_entity: &mut next_entity,
    // rust: spawn: [0.5, 64.0, 0.5],
    // rust: difficulty: 2,
    // rust: difficulty_locked: false,
    // rust: clock_rate: 1.0,
    // rust: tick_rate: 20.0,
    // rust: tick_frozen: false,
    // rust: tick_steps: Default::default(),
    // rust: collision: None,
    // rust: border: &border,
    // rust: streaming: None,
}
    // rust: for action in [3, 4] {
    // rust: hub.guests[0].inbox.push_back((
    // rust: S::PlayerCommand(play::PlayerCommand {
    // rust: id: 1,
    // rust: action,
    // rust: data: 75,
    // rust: }),
    // rust: 4,
    // rust: ));
    // rust: hub.guests[0].inbox_bytes += 4;
    // rust: let events = hub.tick(&mut ctx);
    // rust: let reached = events.iter().any(|event| {
    // rust: matches!(event, HostEvent::Packet(1, packet) if matches!(&**packet, S::PlayerCommand(c) if c.action == action && c.data == 75))
    // rust: });
    // rust: assert!(reached, "action {action} reached the game");
}
}

    /// The durations of the effect packets the guest was sent.
pub fn sent_durations(rx: *std::sync::mpsc::Receiver<crate::lan::Out>) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut durations = Vec::new();
    // rust: while let Ok(out) = rx.try_recv() {
    // rust: let crate::lan::Out::Packet(body) = out else {
    // rust: continue;
}
    // rust: let mut r = horizon_protocol::buf::Reader::new(&body);
    // rust: let id = r.varint().unwrap();
    // rust: if let Ok(C::UpdateMobEffect(p)) = C::decode(id, r.rest()) {
    // rust: durations.push(p.duration);
}
}
    // rust: durations
}

pub fn sent_frozen(rx: *std::sync::mpsc::Receiver<crate::lan::Out>) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut sent = Vec::new();
    // rust: while let Ok(out) = rx.try_recv() {
    // rust: let crate::lan::Out::Packet(body) = out else {
    // rust: continue;
}
    // rust: let mut r = horizon_protocol::buf::Reader::new(&body);
    // rust: let id = r.varint().unwrap();
    // rust: if let Ok(C::SetEntityData(p)) = C::decode(id, r.rest()) {
    // rust: for (index, _, value) in p.values {
    // rust: if let (7, Value::Int(ticks)) = (index, value) {
    // rust: sent.push(ticks);
}
}
}
}
    // rust: sent
}

pub fn a_guests_frozen_ticks_go_to_its_client() void {
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
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let mut body =
    // rust: crate::motion::PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .unwrap();
    // rust: body.ticks_frozen = 140;
    // rust: let (mut hub, rx) = hub_with_a_guest();
    // rust: hub.guests[0].motion = Some(Box::new(body));
    // rust: hub.sync_player_state(0);
    // rust: assert_eq!(sent_frozen(&rx), vec![140]);
    // rust: hub.sync_player_state(0);
    // rust: assert_eq!(sent_frozen(&rx), Vec::<i32>::new());
    // rust: hub.guests[0].motion.as_mut().unwrap().ticks_frozen = 0;
    // rust: hub.sync_player_state(0);
    // rust: assert_eq!(sent_frozen(&rx), vec![0]);
}

    /// The host and port of the transfer packets the guest was sent.
pub fn sent_transfers(rx: *std::sync::mpsc::Receiver<crate::lan::Out>) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut sent = Vec::new();
    // rust: while let Ok(out) = rx.try_recv() {
    // rust: let crate::lan::Out::Packet(body) = out else {
    // rust: continue;
}
    // rust: let mut r = horizon_protocol::buf::Reader::new(&body);
    // rust: let id = r.varint().unwrap();
    // rust: if let Ok(C::Transfer(p)) = C::decode(id, r.rest()) {
    // rust: sent.push((p.host, p.port));
}
}
    // rust: sent
}

    /// `TransferCommand.transfer`: the target's client is sent the play-state
    /// `ClientboundTransferPacket` with the hostname and the port, and nothing
    /// else disconnects it — the client closes and logs in there itself
    /// (`ClientPacketListener.handleTransfer`).
pub fn a_transferred_player_is_sent_the_host_and_the_port() void {
}
    // rust: let (hub, rx) = hub_with_a_guest();
    // rust: hub.transfer(1, "example.net", 25566);
    // rust: assert_eq!(sent_transfers(&rx), vec![("example.net".to_owned(), 25566)]);
        // A connection the hub does not know gets nothing.
    // rust: hub.transfer(9, "example.net", 25566);
    // rust: assert_eq!(
    // rust: sent_transfers(&rx),
    // rust: Vec::<(String, i32)>::new(),
    // rust: "an unknown connection is not a player of this server"
    // rust: );
}

    /// `/effect give Bob minecraft:speed 30 1` from a dedicated server's
    /// console (#7115). Vanilla runs the console after the players' tick
    /// (`DedicatedServer.tickConnection`) and `ServerPlayer.onEffectAdded`
    /// sends the effect at once: 30 s is 600 ticks, and the tick after, which
    /// counts it down to 599, sends nothing (`LivingEntity.tickEffects` only
    /// refreshes it at a multiple of 600 left). The console syncs right after
    /// its command (`console_command`) for the same packet.
pub fn an_effect_synced_after_its_command_is_sent_once_at_its_full_duration() void {
}
    // rust: let (mut hub, rx) = hub_with_a_guest();
    // rust: hub.guests[0]
    // rust: .effects
    // rust: .add(EffectInstance::new("speed", 30 * 20, 1));
        // The console's command, then its sync.
    // rust: hub.sync_all_effects();
        // The next tick: the guests' effects count down (`tick_guests`), then
        // the hub syncs them (`tick_level`).
    // rust: hub.guests[0].effects.tick();
    // rust: hub.sync_all_effects();
    // rust: hub.guests[0].effects.tick();
    // rust: hub.sync_all_effects();
    // rust: assert_eq!(sent_durations(&rx), vec![600]);
        // Without the sync after the command, the first sync comes after the
        // tick has counted it down: what #7115's transcript shows.
    // rust: let (mut late, rx) = hub_with_a_guest();
    // rust: late.guests[0]
    // rust: .effects
    // rust: .add(EffectInstance::new("speed", 30 * 20, 1));
    // rust: late.guests[0].effects.tick();
    // rust: late.sync_all_effects();
    // rust: assert_eq!(sent_durations(&rx), vec![599]);
}

    /// Minecraft.startAttack sends the attack, then the arm swing, and the next client tick
    /// a turn. Vanilla handles both in the tick they came in; the swing starts the attack
    /// strength again, so a swing left for the next tick took a tick off every hit's
    /// charge: a guest's fists, 5 ticks apart, no longer broke a minecart (#7817).
pub fn an_attacks_swing_goes_with_it_past_the_move_behind() void {
}
    // rust: let (mut hub, _rx) = hub_with_a_guest();
    // rust: hub.guests[0].load_timeout = 0;
    // rust: let inbox = &mut hub.guests[0].inbox;
    // rust: inbox.push_back((S::Attack(play::Attack { id: 7 }), 0));
    // rust: inbox.push_back((S::Punch(horizon_protocol::packets::Empty), 0));
    // rust: inbox.push_back((
    // rust: S::MovePlayerRot(play::MovePlayerRot {
    // rust: yaw: 90.0,
    // rust: pitch: 0.0,
    // rust: flags: 1,
    // rust: }),
    // rust: 0,
    // rust: ));
    // rust: let mut world = World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let mut next_entity = 2;
    // rust: let border = crate::worldborder::WorldBorder::default();
    // rust: let mut ctx = TickCtx {
    // rust: world: &mut world,
    // rust: entities: &[],
    // rust: next_entity: &mut next_entity,
    // rust: spawn: [0.5, 64.0, 0.5],
    // rust: difficulty: 2,
    // rust: difficulty_locked: false,
    // rust: clock_rate: 1.0,
    // rust: tick_rate: 20.0,
    // rust: tick_frozen: false,
    // rust: tick_steps: Default::default(),
    // rust: collision: None,
    // rust: border: &border,
    // rust: streaming: None,
}
    // rust: let events = hub.drain_packets(&mut ctx);
    // rust: let handled: Vec<&S> = events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: HostEvent::Packet(_, p) => Some(&**p),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert!(
    // rust: matches!(handled[..], [S::Attack(_), S::Punch(_)]),
    // rust: "the game was handed {handled:?}"
    // rust: );
    // rust: assert!(
    // rust: matches!(
    // rust: hub.guests[0].inbox.iter().collect::<Vec<_>>()[..],
    // rust: [(S::MovePlayerRot(_), _)]
    // rust: ),
    // rust: "the turn did not wait for the next tick"
    // rust: );
}

    /// The owner's own shoulder parrots are sent when a slot changes.
pub fn the_owner_is_sent_the_shoulder_slots_that_changed() void {
}
    // rust: assert!(shoulder_changes([None; 2], [None; 2]).is_empty());
    // rust: let landed = shoulder_changes([Some(1), None], [None; 2]);
    // rust: assert_eq!(landed.len(), 1);
    // rust: assert_eq!((landed[0].0, &landed[0].2), (19, &Value::Id(2)));
    // rust: let left = shoulder_changes([None; 2], [Some(1), Some(4)]);
    // rust: assert_eq!(left.len(), 2);
    // rust: assert_eq!((left[1].0, &left[1].2), (20, &Value::Id(0)));
}

    /// The counts of what is stuck in a player are sent when set, and a
    /// count back at zero is sent as the default.
pub fn stuck_counts_are_synched_as_entity_data() void {
}
    // rust: let mut state = EntityState::default();
    // rust: stuck_meta(&mut state, (3, 0));
    // rust: assert_eq!(state.meta, vec![(12, serializer::INT, Value::Int(3))]);
    // rust: assert_eq!(
    // rust: state.defaults,
    // rust: vec![
    // rust: (12, serializer::INT, Value::Int(0)),
    // rust: (13, serializer::INT, Value::Int(0))
    // rust: ]
    // rust: );
}

    /// Joined states are used in the server tick after the one that noted
    /// them, never later.
pub fn joined_states_last_only_into_the_next_tick() void {
}
    // rust: let joined = vec![EntityState {
    // rust: id: 7,
    // rust: ..EntityState::default()
    // rust: }];
    // rust: assert_eq!(noted_last_tick(Some((5, joined.clone())), 6), joined);
    // rust: assert!(noted_last_tick(Some((5, joined.clone())), 5).is_empty());
    // rust: assert!(noted_last_tick(Some((5, joined)), 9).is_empty());
    // rust: assert!(noted_last_tick(None, 6).is_empty());
}

    /// `getMaximumFlyingTicks`: 80 ticks at normal gravity, ceil(80 * 0.08 /
    /// gravity) where it is weaker, and never a kick without gravity.
pub fn maximum_flying_ticks_follow_gravity() void {
}
    // rust: assert_eq!(maximum_flying_ticks(0.08), 80);
    // rust: assert_eq!(maximum_flying_ticks(0.16), 80);
    // rust: assert_eq!(maximum_flying_ticks(0.04), 160);
    // rust: assert_eq!(maximum_flying_ticks(0.03), 214);
    // rust: assert_eq!(maximum_flying_ticks(0.0), i32::MAX);
    // rust: assert_eq!(maximum_flying_ticks(1.0E-6), i32::MAX);
}

pub fn textures(value: []const u8) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_protocol::packets::login::Property {
    // rust: name: "textures".into(),
    // rust: value: value.into(),
    // rust: signature: Some("c2lnbmVk".into()),
}
}

    /// The owner is listed with the account's skin once the fetch answered,
    /// with none before (no wait) or when it failed; other players keep the
    /// properties they logged in with, and none of the owner's.
pub fn the_owner_is_listed_with_the_accounts_skin_once_fetched() void {
}
    // rust: let (answer, fetched) = std::sync::mpsc::channel();
    // rust: let profile = super::super::OwnerProfile::new(move || fetched.recv().unwrap_or_default());
    // rust: let start = std::time::Instant::now();
    // rust: assert!(listed_properties(&[], true, Some(&profile)).is_empty());
    // rust: assert!(start.elapsed() < std::time::Duration::from_millis(500));
    // rust: answer.send(vec![textures("owner")]).unwrap();
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(5);
    // rust: while listed_properties(&[], true, Some(&profile)).is_empty() {
    // rust: assert!(
    // rust: std::time::Instant::now() < deadline,
    // rust: "the fetch never landed"
    // rust: );
    // rust: std::thread::yield_now();
}
    // rust: assert_eq!(
    // rust: listed_properties(&[], true, Some(&profile)),
    // rust: vec![textures("owner")]
    // rust: );
        // A guest: its own properties (online mode), or none (offline mode).
    // rust: assert_eq!(
    // rust: listed_properties(&[textures("guest")], false, Some(&profile)),
    // rust: vec![textures("guest")]
    // rust: );
    // rust: assert!(listed_properties(&[], false, Some(&profile)).is_empty());
        // No signed-in account (no fetch): as before.
    // rust: assert!(listed_properties(&[], true, None).is_empty());
    // rust: let failed = super::super::OwnerProfile::new(Vec::new);
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(5);
    // rust: while failed.properties.get().is_none() {
    // rust: let _ = failed.properties();
    // rust: assert!(std::time::Instant::now() < deadline);
    // rust: std::thread::yield_now();
}
    // rust: assert!(listed_properties(&[], true, Some(&failed)).is_empty());
}

    /// `requeue` as it was, scanning the queue for each chunk of the view.
    // rust: fn requeue_scan(
    // rust: queue: &mut Vec<(i32, i32)>,
    // rust: sent: &FxHashSet<(i32, i32)>,
    // rust: (cx, cz): (i32, i32),
    // rust: r: i32,
    // rust: ) {
    // rust: queue.retain(|&(x, z)| tracked(cx, cz, r, x, z));
    // rust: for dz in -r - 2..=r + 2 {
    // rust: for dx in -r - 2..=r + 2 {
    // rust: let key = (cx + dx, cz + dz);
    // rust: if tracked(cx, cz, r, key.0, key.1) && !sent.contains(&key) && !queue.contains(&key)
    // rust: {
    // rust: queue.push(key);
}
}
}
    // rust: queue.sort_by_key(|&(x, z)| i64::from(x - cx).pow(2) + i64::from(z - cz).pow(2));
}

    /// A player walking a loop, sending a few chunks a tick: the queue
    /// after every move is the one the scan built.
pub fn requeue_matches_the_scan() void {
}
    // rust: for r in [2, 5, 10, 12, 32] {
    // rust: let (mut a, mut b) = (Vec::new(), Vec::new());
    // rust: let mut sent = FxHashSet::default();
    // rust: for step in 0..60i32 {
    // rust: let center = ((step % 17) - 8, (step * 3 % 11) - 5);
    // rust: requeue(&mut a, &sent, center, r);
    // rust: requeue_scan(&mut b, &sent, center, r);
    // rust: assert_eq!(a, b, "radius {r}, step {step}");
    // rust: for key in a.drain(..a.len().min(7)) {
    // rust: sent.insert(key);
}
    // rust: b.drain(..b.len().min(7));
    // rust: sent.retain(|&(x, z)| tracked(center.0, center.1, r, x, z));
}
}
}

    /// The far ring's queue is what the view's leaves of the chunks tracked at the reach, closest
    /// first, with the sent ones out of both.
pub fn the_far_ring_queues_what_the_view_leaves() void {
}
    // rust: let mut sent = FxHashSet::default();
    // rust: let (mut near, mut far) = (Vec::new(), Vec::new());
    // rust: for step in 0..12 {
    // rust: let center = (step, -step / 2);
    // rust: requeue(&mut near, &sent, center, 10);
    // rust: requeue_ring(&mut far, &sent, center, 10, 24);
    // rust: let mut all = Vec::new();
    // rust: requeue(&mut all, &sent, center, 24);
    // rust: assert!(far.iter().all(|key| !near.contains(key)));
    // rust: let mut both = [near.clone(), far.clone()].concat();
    // rust: both.sort_unstable();
    // rust: all.sort_unstable();
    // rust: assert_eq!(both, all);
    // rust: let distance = |&(x, z): &(i32, i32)| {
    // rust: i64::from(x - center.0).pow(2) + i64::from(z - center.1).pow(2)
}
    // rust: assert!(far.windows(2).all(|w| distance(&w[0]) <= distance(&w[1])));
            // A few of each sent.
    // rust: for key in near
    // rust: .drain(..near.len().min(40))
    // rust: .chain(far.drain(..far.len().min(90)))
    // rust: {
    // rust: sent.insert(key);
}
}
        // Without a ring, nothing.
    // rust: requeue_ring(&mut far, &sent, (0, 0), 10, 10);
    // rust: assert!(far.is_empty());
}

    /// `MinecraftServer.onGameRuleChanged`: setting `limited_crafting` updates the hub's state
    /// and broadcasts `ClientboundGameEventPacket` (event 12) with 1.0 (on) or 0.0 (off) to guests.
pub fn set_limited_crafting_broadcasts_game_event() void {
}
    // rust: let (mut hub, rx) = hub_with_a_guest();
    // rust: assert!(!hub.limited_crafting);

        // Setting to true broadcasts game event 12 with param 1.0
    // rust: hub.set_limited_crafting(true);
    // rust: assert!(hub.limited_crafting);

    // rust: let out = rx.try_recv().expect("packet should be sent to guest");
    // rust: let body = match out {
    // rust: crate::lan::Out::Packet(b) => b,
    // rust: _ => panic!("expected Out::Packet"),
}
    // rust: let mut reader = horizon_protocol::buf::Reader::new(&body);
    // rust: let id = reader.varint().unwrap();
    // rust: let packet = play::Clientbound::decode(id, &body[reader.position()..]).unwrap();
    // rust: match packet {
    // rust: play::Clientbound::GameEvent(p) => {
    // rust: assert_eq!(p.event, game_event::LIMITED_CRAFTING);
    // rust: assert_eq!(p.param, 1.0);
}
    // rust: other => panic!("expected GameEvent, got {other:?}"),
}

        // Setting to the same state should not broadcast another packet
    // rust: hub.set_limited_crafting(true);
    // rust: assert!(rx.try_recv().is_err());

        // Setting to false broadcasts game event 12 with param 0.0
    // rust: hub.set_limited_crafting(false);
    // rust: assert!(!hub.limited_crafting);

    // rust: let out = rx.try_recv().expect("packet should be sent to guest");
    // rust: let body = match out {
    // rust: crate::lan::Out::Packet(b) => b,
    // rust: _ => panic!("expected Out::Packet"),
}
    // rust: let mut reader = horizon_protocol::buf::Reader::new(&body);
    // rust: let id = reader.varint().unwrap();
    // rust: let packet = play::Clientbound::decode(id, &body[reader.position()..]).unwrap();
    // rust: match packet {
    // rust: play::Clientbound::GameEvent(p) => {
    // rust: assert_eq!(p.event, game_event::LIMITED_CRAFTING);
    // rust: assert_eq!(p.param, 0.0);
}
    // rust: other => panic!("expected GameEvent, got {other:?}"),
}
}

    /// cargo test --release -p horizon-client --lib lan::hub::tests::requeue_cost -- --ignored --nocapture
pub fn requeue_cost() void {
}
    // rust: for r in [10, 16, 32] {
    // rust: for (name, f) in [
    // rust: ("scan", requeue_scan as fn(&mut _, &_, _, _)),
    // rust: ("set", requeue as fn(&mut _, &_, _, _)),
    // rust: ] {
    // rust: let sent = FxHashSet::default();
    // rust: let mut queue = Vec::new();
    // rust: let start = std::time::Instant::now();
    // rust: let moves = 200;
    // rust: for step in 0..moves {
                    // Nothing sent yet (an explorer waiting on generation).
    // rust: f(&mut queue, &sent, (step, 0), r);
}
    // rust: let per = start.elapsed().as_secs_f64() * 1e6 / f64::from(moves);
    // rust: println!(
    // rust: "view {r}: {name} {per:.1} us per chunk crossed, {} queued",
    // rust: queue.len()
    // rust: );
}
}
}
}
