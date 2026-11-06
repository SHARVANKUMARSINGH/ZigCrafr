//! Transpiled from Horizon Rust crate
package horizon_client_guest

import "core:fmt"
import "core:mem"
import "core:math"

// A remote player: connection, position, chunk and entity views, and the
// player state (inventory, health, game mode) that the host's gameplay code
// operates on when it acts for them.
// use super::{Joined, PlayerSender, entity::Tracker};
// use crate::{
    // rust: items::ItemStack,
    // rust: motion::PlayerMotion,
    // rust: pose::{Dimensions, Pose},
}
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_protocol::{
    // rust: attachment_sync,
    // rust: item::Stack,
    // rust: packets::{
    // rust: configuration::{ClientInformation, CustomPayload},
    // rust: play,
    // rust: },
}
// use std::{
    // rust: collections::VecDeque,
    // rust: sync::{Arc, atomic::AtomicI32},
}

// GameType ids.
SURVIVAL :: 0
CREATIVE :: 1
SPECTATOR :: 3

// The body state a player's file keeps that lives on `PlayerMotion`.
SavedBody :: struct {
    fire_ticks: i32,
    air: i32,
    fall_distance: f64,
    // `Motion`: the delta movement, blocks a tick.
    velocity: [f64,
    // `foodExhaustionLevel` and `foodTickTimer` (FoodData); the food level
    // and saturation live on the guest.
    food_exhaustion: f32,
    food_tick_timer: i32,
    // `TicksFrozen`: the time spent in powder snow.
    ticks_frozen: i32,
}

    // rust: impl SavedBody {
    // The body state of `motion`, to save.
of :: proc(motion: ^PlayerMotion) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let v = motion.velocity;
    // rust: Self {
    // rust: fire_ticks: motion.fire_ticks,
    // rust: air: motion.air,
    // rust: fall_distance: motion.fall_distance,
    // rust: velocity: [v.x, v.y, v.z],
    // rust: food_exhaustion: motion.health.food.exhaustion,
    // rust: food_tick_timer: motion.health.food.timer,
    // rust: ticks_frozen: motion.ticks_frozen,
}
}
    // Put it on a new body.
apply :: proc(self: ^Self, motion: ^PlayerMotion) {
}
    // rust: motion.fire_ticks = self.fire_ticks;
    // rust: motion.air = self.air;
    // rust: motion.fall_distance = self.fall_distance;
    // rust: let [x, y, z] = self.velocity;
    // rust: motion.velocity = Vec3::new(x, y, z);
    // rust: motion.health.food.exhaustion = self.food_exhaustion;
    // rust: motion.health.food.timer = self.food_tick_timer;
    // rust: motion.ticks_frozen = self.ticks_frozen;
}
}

// An effect as last sent in ClientboundUpdateMobEffectPacket.
SentEffect :: struct {
    id: ^'static str,
    amplifier: i32,
    flags: i8,
    duration: i32,
    tick_count: i32,
}

// ServerGamePacketListenerImpl.CLIENT_LOADED_TIMEOUT_TIME.
CLIENT_LOADED_TIMEOUT :: 60

Guest :: struct {
    conn: u32,
    // The client's address (IP bans, `list`).
    address: std::net::SocketAddr,
    // The hub tick of the player's last action (ServerPlayer.lastActionTime),
    // for player-idle-timeout.
    last_action_tick: u64,
    // The next ClientboundPlayerChatPacket.globalIndex for this connection.
    chat_index: i32,
    // Secure chat (ServerGamePacketListenerImpl): the player's message
    // chain, keyed once it sends a chat session; the messages its
    // acknowledgements cover; the signatures its client caches.
    chain: horizon_protocol::secure_chat::Chain,
    last_seen: horizon_protocol::secure_chat::LastSeenValidator,
    signatures: horizon_protocol::secure_chat::SignatureCache,
    // The hub tick the player was placed on: chunks go out from the tick
    // after next, behind the first doTick's packets, as vanilla's do.
    placed_at: u64,
    // The chunk cache centre placeNewPlayer already sent.
    center_sent: Option<(i32,
    // Why the connection closed (the console's "lost connection").
    left_reason: string,
    uuid: u128,
    name: string,
    // The profile's properties, for the player list (skins).
    properties: [dynamic]horizon_protocol::packets::login::Property,
    entity_id: i32,
    sender: PlayerSender,
    latency: ^AtomicI32,
    info: ClientInformation,
    brand: string,
    // The chunk radius this client is sent.
    view_distance: i32,
    position: [f64,
    previous_position: [f64,
    yaw: f32,
    pitch: f32,
    head_yaw: f32,
    on_ground: bool,
    game_mode: i32,
    // `previousPlayerGameType`: the mode left last, which the game mode
    // switcher goes back to; none until the mode first changes.
    previous_game_mode: Maybe(i32),
    // The permission level (0 none, 2 game masters, 4 owners).
    permission: u8,
    sneaking: bool,
    // The last `ServerboundPlayerInputPacket` flags (forward 1, backward 2,
    // left 4, right 8, jump 16, shift 32, sprint 64).
    input: u8,
    // The boat or minecart the player rides (`Entity.getVehicle`).
    vehicle: Maybe(u32),
    // `Entity.boardingCooldown`: ticks before it may board a vehicle again.
    boarding_cooldown: i32,
    // When the player last got into its vehicle, from `Hub.seat_order`:
    // `Entity.addPassenger` seats a rider behind the players already in the
    // vehicle, so the smallest order on a boat is its controlling rider
    // (`getControllingPassenger`).
    vehicle_order: u64,
    // `ServerGamePacketListenerImpl.lastGoodX/Y/Z` of the vehicle it controls.
    vehicle_good: Option<[f64,
    sprinting: bool,
    fall_flying: bool,
    flying: bool,
    sleeping: bool,
    // `LivingEntity.DATA_LIVING_ENTITY_FLAGS`: 1 while using an item, 2 if
    // it is in the off hand.
    living_flags: i8,
    // `LivingEntity.DATA_ARROW_COUNT_ID` and `DATA_STINGER_COUNT_ID`.
    stuck: (i32,
    // `Player.DATA_SHOULDER_PARROT_LEFT` and `_RIGHT`: the parrots' variants.
    shoulders: [Maybe(i32),
    // The bed (its head) the player sleeps in (`LivingEntity.getSleepingPos`),
    // `Player.sleepCounter`, and the bed last told to the player itself.
    bed: Option<[i32,
    woke_from: Option<[i32,
    sleep_timer: u32,
    sent_bed: Option<[i32,
    // Where the player respawns (a bed's spot; `ServerPlayer.respawnConfig`),
    // None for the world spawn.
    spawn: Option<[f64,
    // A respawn point outside the Overworld (a respawn anchor, or one
    // `spawnpoint` set there): its dimension, block, yaw and whether it is
    // forced, as the player's save keeps it (`respawn`).
    respawn_elsewhere: Option<(string,
    // Pending ClientboundPlayerPositionPacket id; movement is ignored until
    // the client accepts it (ServerGamePacketListenerImpl.awaitingPositionFromClient).
    awaiting_teleport: Option<(i32,
    // The teleport awaited keeps the player's motion (`Hub::teleport_keeping_motion`).
    awaiting_keeps_motion: bool,
    // Through a portal, until `LanHub::land` gives the client its position:
    // the moves it sent from the old level are ignored, as they would be
    // while it had a teleport to accept.
    landing: bool,
    teleport_counter: i32,
    // `ServerPlayer.getCamera() != this`.
    watching: bool,
    // The hub tick the pending teleport was (re)sent on (awaitingTeleportTime).
    teleport_tick: u64,
    // Where the player was when this tick's packets began (firstGoodX/Y/Z),
    // for the moved-too-quickly check.
    first_good: [f64,
    // Position moves received in all and by the start of this tick
    // (receivedMovePacketCount, knownMovePacketCount).
    received_moves: i32,
    known_moves: i32,
    // The last accepted move left the player hovering over air
    // (`clientIsFloating`), and the ticks it has (`aboveGroundTickCount`).
    client_is_floating: bool,
    above_ground_ticks: i32,
    // The same for the vehicle the player drives (`clientVehicleIsFloating`,
    // `aboveGroundVehicleTickCount`), with that vehicle's gravity
    // (`getMaximumFlyingTicks(lastVehicle)`) and whether its last accepted
    // move came down onto something (`verticalCollisionBelow`).
    vehicle_floating: bool,
    above_ground_vehicle_ticks: i32,
    vehicle_gravity: f64,
    vehicle_rests: bool,
    // `Entity.verticalCollisionBelow` of the player's own body: its last
    // accepted move came down onto something.
    rests_on_ground: bool,
    // `ServerGamePacketListenerImpl.lastSupportedBlocksSend`: the connection
    // tick the blocks under the player were last force-sent.
    support_blocks_sent: u64,
    // A position move arrived since the client's last ClientTickEnd
    // (receivedPositionThisTick): a second one is a protocol error.
    position_this_tick: bool,
    // Violation levels and the checks' state (the anticheat, when on).
    anticheat: horizon_anticheat::Player,
    // The movement prediction's replay of the client's own moves (only while it runs).
    replay: Maybe(^super::prediction::Replay),
    // What the server sent this tick that changes how the client moves (only while it records).
    changes: std::sync::Mutex<[dynamic]horizon_anticheat::prediction::Change>,
    // It accepted a move since the last entity range checks
    // (ServerChunkCache.move), which then check all of its pairs again.
    moved: bool,
    // The players a native mod hid from it (`Hub::hidden`) that its player
    // list no longer has.
    tab_hidden: crate::fast_hash::FxHashSet<u128>,
    // The client finished loading terrain (ServerboundPlayerLoadedPacket).
    loaded: bool,
    // Since it joined or respawned, the client hasn't said it loaded the level
    // (ServerboundPlayerLoadedPacket): it may still be on its loading screen, where it doesn't
    // move, even once the server stops waiting for it (`load_timeout`).
    loading: bool,
    // Ticks left before the server stops waiting for that packet
    // (ServerGamePacketListenerImpl.clientLoadedTimeoutTimer): 60 at join and
    // after a respawn, 0 once it comes.
    load_timeout: u8,
    // Chunks.
    center: Option<(i32,
    sent_chunks: crate::fast_hash::FxHashSet<(i32,
    // Sent as far-ring columns and needing a near snapshot on promotion.
    far_sent_chunks: crate::fast_hash::FxHashSet<(i32,
    chunk_queue: Vec<(i32,
    // The far ring's chunks still to send, past the view distance (`lan::far`), closest first.
    far_queue: Vec<(i32,
    // PlayerChunkSender: batches sent but not yet acknowledged, how many
    // may be (1 until the client's first acknowledgement, then 10), the
    // rate the client asks for and the chunks the next batch may hold.
    unacknowledged: u32,
    max_unacknowledged: u32,
    chunks_per_tick: f32,
    batch_quota: f32,
    // Entities.
    tracker: Tracker,
    // Player state the gameplay code reads and writes.
    motion: Maybe(^PlayerMotion),
    // What the player's file says of the body (`Entity.load`: the fire
    // and air ticks and the fall distance), for the first body it gets.
    loaded_body: Maybe(SavedBody),
    // The attribute list the player's last body hands to its next one
    // (`ServerPlayer.restoreFrom`, `PlayerMotion::carried_attributes`),
    // until that body exists: the scale a player has set stays through a
    // respawn and a change of level (#3684).
    carried_attributes: Maybe(horizon_world::nbt::Tag),
    // The vehicle the player's file names (`ServerPlayer.saveParentVehicle`'s
    // "RootVehicle"), for the ride to come back on the next login.
    saved_vehicle: Option<[i32,
    // The hurt and attack logs of the body it had before it respawned,
    // until the new body takes them over (the control socket's `hurtlog`
    // reads across a death).
    logs_kept: Option<(,
    // rust: Vec<crate::health::HurtRecord>,
    // rust: Vec<crate::health::AttackRecord>,
    // rust: )>,
    // The 36 inventory slots (hotbar first), armor (head..feet) and off hand.
    inventory: [dynamic]Maybe(ItemStack),
    armor: [Maybe(ItemStack),
    offhand: Maybe(ItemStack),
    selected: uint,
    carried: Maybe(ItemStack),
    // The inventory menu's crafting grid (2x2) and its result
    // (`InventoryMenu.craftSlots`, `resultSlots`), which the game computes.
    craft_grid: [Maybe(ItemStack),
    craft_result: Maybe(ItemStack),
    // The ender chest inventory (`PlayerEnderChestContainer`, 27 slots).
    ender_items: [dynamic]Maybe(ItemStack),
    // What a native mod's menu shows (`Slots::Native`), while one is open.
    native_menu: [dynamic]Maybe(ItemStack),
    health: f32,
    // The saved `AbsorptionAmount`, until the player's first body on the
    // server takes it (the body holds the live amount).
    saved_absorption: Maybe(f32),
    food: i32,
    saturation: f32,
    xp_level: i32,
    xp_progress: f32,
    xp_total: i32,
    // `Player.enchantmentSeed` (the enchanting table's offers).
    xp_seed: i32,
    // Active status effects (`LivingEntity.activeEffects`).
    effects: crate::effects::PlayerEffects,
    // What the client was told of each effect: id, amplifier, flags, and
    // the duration and `effects.tick_count` at the time, so a duration that
    // only counted down is not sent again (`ServerPlayer.onEffectUpdated`).
    sent_effects: [dynamic]SentEffect,
    // What the client believes the inventory menu holds (for change detection).
    menu_sent: [dynamic]Maybe(ItemStack),
    menu_state: i32,
    // `lastSentHealth`, `lastSentFood` and `lastFoodSaturationZero`.
    sent_health: Option<(f32,
    sent_xp: Option<(f32,
    // The air supply and absorption the player's client was last sent
    // (Entity.DATA_AIR_SUPPLY_ID, Player.DATA_PLAYER_ABSORPTION_ID); their
    // defaults until either changes.
    sent_air: (i32,
    sent_frozen: i32,
    // The shared flags (Entity.DATA_SHARED_FLAGS_ID) the player's client was
    // last sent about itself.
    sent_shared: i8,
    // The shoulder parrots (Player.DATA_SHOULDER_PARROT_LEFT and _RIGHT) the
    // player's client was last sent about itself.
    sent_shoulders: [Maybe(i32),
    // Where the player last died (Player.lastDeathLocation), sent with the respawn.
    last_death: Option<(string,
    // The last action sequence to acknowledge at the next tick (-1: none).
    ack_up_to: std::cell::Cell<i32>,
    sent_selected: uint,
    // Packets waiting for the player's next turn, and their bytes on the wire.
    inbox: VecDeque<(play::Serverbound,
    inbox_bytes: uint,
    joined_tick: u64,
    ticks: u64,
    // The moves accepted since the game last looked (movement, on ground),
    // for ServerPlayer.doCheckFallDamage.
    moves: Vec<([f64,
    // Whether the guest was on the ground before the first of `moves`.
    moves_from_ground: bool,
    // `ServerPlayer.lastKnownClientMovement`: the last move accepted from
    // their client, zero after a client tick without one.
    known_movement: [f64,
    dead: bool,
    // `LivingEntity.deathTime`: ticks since the guest died.
    death_time: u32,
    // The join packets were sent (PlayerList.placeNewPlayer ran).
    placed: bool,
    // The hand-over a proxy started by exporting it with `freeze`
    // (`arrivals::Handover`): while it lasts, what it sends other than its
    // acknowledgements is not acted on, and every export answers with the
    // same record. It ends after `[transfer]`'s `max_freeze_seconds`.
    handover: Maybe(super::arrivals::Handover),
    // Its login started while a proxy said it would arrive from another
    // server, and used that expectation up (`player-expect`).
    expected: bool,
    // A player arriving from another server (`arrivals`): connected and
    // receiving the world, but not placed, so no one else sees, hears or
    // hurts it until the hand-over finishes.
    held: bool,
    // The hub tick at which it was held, to drop it if its hand-over never comes.
    held_since: u64,
    // A held player whose record has been applied but that is not yet let into the world
    // (`player-import` with `"place": false`): `player-confirm` places it, `player-drop` removes it.
    imported: bool,
    // Whether the others are told when it is placed, as the import asked.
    arrival_announce: bool,
    // The hand-over its record came with (`player-import`): `player-confirm` and
    // `player-drop` name it, and another hand-over's record is not taken.
    arrival_handover: Maybe(u128),
    // The import of that hand-over moved the view to another chunk (`recentered` in its reply),
    // kept so a retried import or a confirm after it answers the same.
    arrival_recentered: bool,
    // Leaving for another server (`player-release moved`) without the "left the
    // game" line.
    quiet_leave: bool,
    // Taken out of the world because a proxy moved it to another server: the game
    // saves neither its player file nor its records, since the other server has the
    // player now.
    released: bool,
    // Root command names the mods took out of this player's command tree
    // (`native_player_commands_sent`); their tree is sent without them.
    hidden_commands: [dynamic]string,
    // `Abilities.flyingSpeed`: vanilla's 0.05, unless a server mod set
    // another (`native_set_flying_speed`). Saved with the player.
    flying_speed: f32,
    // The level the player is in (`ServerPlayer.level().dimension()`): the
    // hub's level passes only reach the players in theirs.
    dimension: string,
    // The open block container, if any.
    menu: Maybe(super::menu::Menu),
    next_window: i32,
    // An unfinished drag in the inventory menu.
    drag: Option<(u8,
    // The compound this player was loaded from, for fields Horizon does not model.
    saved: Maybe(horizon_world::nbt::Tag),
    // Server-owned attachment data for this player.
    attachments: horizon_world::attachments::Attachments,
    // `ServerPlayer.seenCredits`: the end poem has been shown.
    seen_credits: bool,
    // `ServerPlayer.postEffects` and `postEffectsDirty`.
    post_effects: [dynamic]string,
    post_effects_dirty: bool,
    // `ServerPlayer.recipeBook`.
    recipe_book: crate::recipe_book::Settings,
    // `PlayerAdvancements.lastSelectedTab`: the advancement tab the player
    // last opened, as its id, when the server kept it (a root with a display).
    selected_tab: Maybe(string),
    // `PlayerAdvancements`: the criteria obtained, whether they came from
    // the player's file, the advancements the client was last told it may
    // see (empty before the first packet), and those whose progress
    // changed since (`progressChanged`).
    advancements: crate::advancements::Progress,
    advancements_loaded: bool,
    advancements_visible: [dynamic]bool,
    advancements_changed: std::collections::BTreeSet<uint>,
    // The server's scoreboard as this player's client has it (lan/scoreboard.rs).
    scoreboard: super::scoreboard::View,
    // Recipes unlocked since the client was last told
    // (`ServerRecipeBook.addRecipes` sends them).
    recipes_unlocked: [dynamic]string,
}

    // rust: impl Guest {
new :: proc(j: Joined, entity_id: i32, position: [f64; 3], view_distance: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: conn: j.conn,
    // rust: address: j.address,
    // rust: last_action_tick: 0,
    // rust: chat_index: 0,
    // rust: chain: Default::default(),
    // rust: last_seen: Default::default(),
    // rust: signatures: Default::default(),
    // rust: placed_at: 0,
    // rust: center_sent: None,
    // rust: left_reason: String::new(),
    // rust: uuid: j.uuid,
    // rust: name: j.name,
    // rust: properties: j.properties,
    // rust: entity_id,
    // rust: sender: j.sender,
    // rust: latency: j.latency,
    // rust: view_distance: i32::from(j.info.view_distance).max(2).min(view_distance),
    // rust: info: j.info,
    // rust: brand: j.brand,
    // rust: position,
    // rust: previous_position: position,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: head_yaw: 0.0,
    // rust: on_ground: false,
    // rust: game_mode: SURVIVAL,
    // rust: previous_game_mode: None,
    // rust: permission: 0,
    // rust: sneaking: false,
    // rust: input: 0,
    // rust: vehicle: None,
    // rust: boarding_cooldown: 0,
    // rust: vehicle_order: 0,
    // rust: vehicle_good: None,
    // rust: sprinting: false,
    // rust: fall_flying: false,
    // rust: flying: false,
    // rust: sleeping: false,
    // rust: living_flags: 0,
    // rust: stuck: (0, 0),
    // rust: shoulders: [None; 2],
    // rust: bed: None,
    // rust: woke_from: None,
    // rust: sleep_timer: 0,
    // rust: sent_bed: None,
    // rust: spawn: None,
    // rust: respawn_elsewhere: None,
    // rust: awaiting_teleport: None,
    // rust: awaiting_keeps_motion: false,
    // rust: landing: false,
    // rust: teleport_counter: 0,
    // rust: watching: false,
    // rust: teleport_tick: 0,
    // rust: first_good: position,
    // rust: received_moves: 0,
    // rust: known_moves: 0,
    // rust: client_is_floating: false,
    // rust: above_ground_ticks: 0,
    // rust: vehicle_floating: false,
    // rust: above_ground_vehicle_ticks: 0,
    // rust: vehicle_gravity: 0.0,
    // rust: vehicle_rests: false,
    // rust: rests_on_ground: false,
    // rust: support_blocks_sent: 0,
    // rust: position_this_tick: false,
    // rust: anticheat: Default::default(),
    // rust: replay: None,
    // rust: changes: Default::default(),
    // rust: moved: false,
    // rust: tab_hidden: Default::default(),
    // rust: loaded: false,
    // rust: loading: true,
    // rust: load_timeout: CLIENT_LOADED_TIMEOUT,
    // rust: center: None,
    // rust: sent_chunks: Default::default(),
    // rust: far_sent_chunks: Default::default(),
    // rust: chunk_queue: Vec::new(),
    // rust: far_queue: Vec::new(),
    // rust: unacknowledged: 0,
    // rust: max_unacknowledged: 1,
    // rust: chunks_per_tick: 9.0,
    // rust: batch_quota: 0.0,
    // rust: tracker: Tracker::default(),
    // rust: motion: None,
    // rust: loaded_body: None,
    // rust: carried_attributes: None,
    // rust: saved_vehicle: None,
    // rust: logs_kept: None,
    // rust: inventory: vec![None; 36],
    // rust: armor: [None, None, None, None],
    // rust: offhand: None,
    // rust: selected: 0,
    // rust: carried: None,
    // rust: craft_grid: Default::default(),
    // rust: craft_result: None,
    // rust: ender_items: vec![None; 27],
    // rust: native_menu: Vec::new(),
    // rust: health: 20.0,
    // rust: saved_absorption: None,
    // rust: food: 20,
    // rust: saturation: 5.0,
    // rust: xp_level: 0,
    // rust: xp_progress: 0.0,
    // rust: xp_total: 0,
    // rust: xp_seed: 0,
    // rust: effects: Default::default(),
    // rust: sent_effects: Vec::new(),
    // rust: menu_sent: vec![None; 46],
    // rust: menu_state: 0,
    // rust: sent_health: None,
    // rust: sent_xp: None,
    // rust: sent_air: (300, 0.0),
    // rust: sent_frozen: 0,
    // rust: sent_shared: 0,
    // rust: sent_shoulders: [None; 2],
    // rust: last_death: None,
    // rust: ack_up_to: std::cell::Cell::new(-1),
    // rust: sent_selected: 0,
    // rust: inbox: VecDeque::new(),
    // rust: inbox_bytes: 0,
    // rust: joined_tick: 0,
    // rust: ticks: 0,
    // rust: moves: Vec::new(),
    // rust: moves_from_ground: false,
    // rust: known_movement: [0.0; 3],
    // rust: dead: false,
    // rust: death_time: 0,
    // rust: placed: false,
    // rust: handover: None,
    // rust: expected: j.expected,
    // rust: held: false,
    // rust: held_since: 0,
    // rust: imported: false,
    // rust: arrival_announce: true,
    // rust: arrival_handover: None,
    // rust: arrival_recentered: false,
    // rust: quiet_leave: false,
    // rust: released: false,
    // rust: hidden_commands: Vec::new(),
    // rust: flying_speed: 0.05,
    // rust: dimension: "minecraft:overworld".into(),
    // rust: menu: None,
    // rust: next_window: 0,
    // rust: drag: None,
    // rust: saved: None,
    // rust: attachments: Default::default(),
    // rust: seen_credits: false,
    // rust: post_effects: Vec::new(),
    // rust: post_effects_dirty: true,
    // rust: recipe_book: Default::default(),
    // rust: selected_tab: None,
    // rust: advancements: Default::default(),
    // rust: advancements_loaded: false,
    // rust: advancements_visible: Vec::new(),
    // rust: advancements_changed: Default::default(),
    // rust: scoreboard: Default::default(),
    // rust: recipes_unlocked: Vec::new(),
}
}
    // `ServerPlayer.onUpdateAbilities`: the guest's abilities, flying speed included.
abilities :: proc(self: ^Self) -> p {
    // Ported from Horizon
    return {}
}
    // rust: play::Clientbound::PlayerAbilities(play::PlayerAbilities {
    // rust: flags: self.ability_flags(),
    // rust: flying_speed: self.flying_speed,
    // rust: walking_speed: 0.1,
    // rust: })
}
send :: proc(self: ^Self, packet: ^play::Clientbound) {
}
    // rust: if self.anticheat.record.is_some() {
    // rust: self.note_change(packet);
}
    // rust: self.sender.send(packet.encode());
}
    // Whether the guest is placed and on a Horizon client (the only one that
    // reads synced attachments).
reads_attachment_sync :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.placed && self.brand == "horizon"
}
    // A holder's synced attachments, if the guest reads them; a message too big
    // for one payload is not sent.
send_attachment_sync :: proc(self: ^Self, message: ^attachment_sync::Message) {
}
    // rust: if !self.reads_attachment_sync() {
    // rust: return;
}
    // rust: match attachment_sync::encode(message) {
    // rust: Ok(data) => self.send(&play::Clientbound::CustomPayload(CustomPayload {
    // rust: channel: attachment_sync::CHANNEL.into(),
    // rust: data,
    // rust: })),
    // rust: Err(e) => log::debug!("Horizon: attachment sync not sent: {e}"),
}
}
    // What `packet` changes about how the client moves, for the prediction's replay: kept until
    // the tick's ping places it (`Hub::anticheat_ping`).
note_change :: proc(self: ^Self, packet: ^play::Clientbound) {
}
//         use horizon_anticheat::prediction::Change;
//         use play::Clientbound as C;
    // rust: let own = |id: i32| id == self.entity_id;
    // rust: let change = match packet {
    // rust: C::SetEntityMotion(p) if own(p.id) => {
    // rust: Change::Velocity(horizon_protocol::buf::LpVec3::quantize(p.velocity))
}
    // rust: C::Explode(p) => match p.knockback {
    // rust: Some(k) => Change::Knockback(k),
    // rust: None => return,
    // rust: },
    // rust: C::UpdateAttributes(p) if own(p.id) => {
    // rust: let speed = self.motion.as_ref().and_then(|m| {
    // rust: m.attributes
    // rust: .key("minecraft:movement_speed")
    // rust: .map(|k| k.attribute().registry_id())
    // rust: });
    // rust: let sprint = p
    // rust: .values
    // rust: .iter()
    // rust: .find(|a| Some(a.attribute) == speed)
    // rust: .map(|a| a.modifiers.iter().any(|m| m.id == "minecraft:sprinting"));
    // rust: Change::Attributes { sprint }
}
            // Entity.DATA_SHARED_FLAGS_ID: its sprinting bit (0x08).
    // rust: C::SetEntityData(p) if own(p.id) => match p.values.iter().find(|v| v.0 == 0) {
    // rust: Some(&(_, _, horizon_protocol::entity_data::Value::Byte(flags))) => {
    // rust: Change::Sprinting(flags & 0x08 != 0)
}
    // rust: _ => return,
    // rust: },
    // rust: C::UpdateMobEffect(p) if own(p.id) => Change::Effects,
    // rust: C::RemoveMobEffect(p) if own(p.id) => Change::Effects,
    // rust: C::PlayerAbilities(_) => Change::Abilities,
            // The chest slot (InventoryMenu's slot 6): a glider.
    // rust: C::ContainerSetSlot(p) if p.container == 0 && p.slot == 6 => Change::Abilities,
    // rust: C::ContainerSetContent(p) if p.container == 0 => Change::Abilities,
    // rust: _ => return,
}
    // rust: self.changes
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
    // rust: .push(change);
}
    // `Entity.stopRiding`: out of the vehicle it rode.
stop_riding :: proc(self: ^Self) {
}
    // rust: (self.vehicle, self.vehicle_good) = (None, None);
}
    // `LivingEntity.tickDeath` for a dead player: true once its body is
    // removed, 20 ticks after it died (`remove(KILLED)`, whose
    // `Entity.setRemoved` stops its riding). The body sits in its vehicle
    // until then.
tick_death :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.death_time += 1;
    // rust: let removed = self.death_time >= 20;
    // rust: if removed {
    // rust: self.stop_riding();
}
    // rust: removed
}
send_all :: proc(self: ^Self, packets: ^[play::Clientbound]) {
}
    // rust: for p in packets {
    // rust: self.send(p);
}
}
chunk :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: (self.position[0].floor() as i32) >> 4,
    // rust: (self.position[2].floor() as i32) >> 4,
    // rust: )
}
creative :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.game_mode == CREATIVE
}
    // ServerGamePacketListenerImpl.hasClientLoaded: not dead (waitingForRespawn) and
    // loaded, or waited for long enough. Until then the player's actions are ignored.
client_loaded :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.dead && self.load_timeout == 0
}
    // `ServerPlayerGameMode.changeGameModeForPlayer`: the mode left becomes
    // the previous one; the mode already in use changes nothing.
change_game_mode :: proc(self: ^Self, mode: i32) {
}
    // rust: if mode != self.game_mode {
    // rust: self.previous_game_mode = Some(self.game_mode);
    // rust: self.game_mode = mode;
}
}
spectator :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.game_mode == SPECTATOR
}
    // PlayerAbilities flags (invulnerable, flying, may fly, instabuild).
ability_flags :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut f = 0;
    // rust: if self.creative() || self.spectator() {
    // rust: f |= 1;
}
    // rust: if self.flying || self.spectator() {
    // rust: f |= 2;
}
    // rust: if self.creative() || self.spectator() {
    // rust: f |= 4;
}
    // rust: if self.creative() {
    // rust: f |= 8;
}
    // rust: f
}
    // `Player.getDesiredPose`: sleeping, gliding, then the body's own pose
    // (swimming, crawling, crouching) once its server tick has run.
pose :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if self.sleeping {
    // rust: Pose::Sleeping
    // rust: } else if self.fall_flying {
    // rust: Pose::FallFlying
    // rust: } else if let Some(m) = &self.motion {
    // rust: m.pose
    // rust: } else if self.sneaking && !self.flying {
    // rust: Pose::Crouching
    // rust: } else {
    // rust: Pose::Standing
}
}
    // `Avatar.POSES` for the guest's pose, with its scale attribute: also for
    // a pose the client has announced (gliding) before the body's own tick
    // has taken it.
dimensions :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let pose = self.pose();
    // rust: match &self.motion {
    // rust: Some(m) if m.pose == pose => m.dimensions,
    // rust: Some(m) => pose.dimensions(m.scale),
    // rust: None => pose.dimensions(1.0),
}
}
    // The player's body is replaced (`ServerPlayer.restoreFrom`): the next
    // one starts from the old one's attributes, all of them when it is the
    // same player in another level (`restore_all`), only their base values
    // after a death. The old body, for what else it hands over.
new_body :: proc(self: ^Self, restore_all: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let m = self.motion.take()?;
    // rust: self.carried_attributes = Some(m.carried_attributes(restore_all));
    // rust: Some(m)
}
    // `ServerPlayer.restoreFrom(old, false)`'s `setHealth(getMaxHealth())`:
    // the health a player comes back from a death with, the max health of
    // the base values their next body takes over, before its equipment
    // modifies it (40 after `/attribute @s minecraft:max_health base set
    // 40`, not 20).
respawn_health :: proc(self: ^Self, resources: ^crate::motion::MotionResources) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(mut body) = PlayerMotion::new(resources, Vec3::ZERO) else {
    // rust: return 20.0;
}
    // rust: let _ = body.apply_saved_attributes(self.carried_attributes.as_ref());
    // rust: body.attribute("minecraft:max_health")
    // rust: .map_or(20.0, |max| max as f32)
}
    // `Entity.getBoundingBox`.
bounds :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = self.position;
    // rust: let d = self.dimensions();
    // rust: let half = f64::from(d.width) / 2.0;
    // rust: Aabb::new(
    // rust: Vec3::new(x - half, y, z - half),
    // rust: Vec3::new(x + half, y + f64::from(d.height), z + half),
    // rust: )
}
eye_height :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(self.dimensions().eye_height)
}
    // `Player.isWithinBlockInteractionRange(pos, buffer)` for the guest:
    // its block interaction range is 4.5, 5 in creative.
within_block_range :: proc(self: ^Self, pos: [i32; 3], buffer: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let eye = [
    // rust: self.position[0],
    // rust: self.position[1] + self.eye_height(),
    // rust: self.position[2],
    // rust: ];
    // rust: let range = if self.creative() { 5.0 } else { 4.5 };
    // rust: within_block_range(eye, range + buffer, pos)
}
    // `Player.isWithinBlockInteractionRange(pos, 1.0)`, which the server
    // checks a block action against (ServerPlayerGameMode.handleBlockBreakAction,
    // ServerGamePacketListenerImpl.handleUseItemOn): from the eyes of the
    // guest's body in its pose (crouching, swimming, gliding), with its
    // `block_interaction_range` (4.5, 5 in creative, more with `/attribute`).
may_reach_block :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let eye = self
    // rust: .motion
    // rust: .as_ref()
    // rust: .map_or_else(|| self.eye_height(), |m| f64::from(m.dimensions.eye_height));
    // rust: let otherwise = if self.creative() { 5.0 } else { 4.5 };
    // rust: let range = self
    // rust: .motion
    // rust: .as_mut()
    // rust: .and_then(|m| m.attribute("minecraft:block_interaction_range").ok())
    // rust: .unwrap_or(otherwise);
    // rust: within_block_range(
    // rust: [self.position[0], self.position[1] + eye, self.position[2]],
    // rust: range + 1.0,
    // rust: pos,
    // rust: )
}
    // The inventory menu's 46 slots (ServerPlayer.inventoryMenu): 0 crafting
    // result, 1..=4 crafting grid, 5..=8 armor, 9..=35 main, 36..=44 hotbar,
    // 45 off hand.
menu_slot :: proc(self: ^Self, slot: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match slot {
    // rust: 0 => self.craft_result.clone(),
    // rust: 1..=4 => self.craft_grid[slot - 1].clone(),
    // rust: 5..=8 => self.armor[slot - 5].clone(),
    // rust: 9..=35 => self.inventory.get(slot).cloned().flatten(),
    // rust: 36..=44 => self.inventory.get(slot - 36).cloned().flatten(),
    // rust: 45 => self.offhand.clone(),
    // rust: _ => None,
}
}
    // The open menu's packets told the client every inventory slot: the
    // inventory menu's own sync has nothing to add. Sent again, it could land
    // on clicks the client has predicted since.
inventory_told :: proc(self: ^Self) {
}
    // rust: for slot in 9..45 {
    // rust: self.menu_sent[slot] = self.menu_slot(slot);
}
}
set_menu_slot :: proc(self: ^Self, slot: uint, item: Maybe(ItemStack)) {
}
    // rust: match slot {
    // rust: 0 => self.craft_result = item,
    // rust: 1..=4 => self.craft_grid[slot - 1] = item,
    // rust: 5..=8 => self.armor[slot - 5] = item,
    // rust: 9..=35 => self.inventory[slot] = item,
    // rust: 36..=44 => self.inventory[slot - 36] = item,
    // rust: 45 => self.offhand = item,
    // rust: _ => {}
}
}
}

// `FireworkExplosion.STREAM_CODEC`'s fields (`Shape` by its BY_ID order).
    // rust: fn network_explosion(
    // rust: e: &crate::particles::FireworkExplosion,
    // rust: ) -> horizon_protocol::item::FireworkExplosion {
    // rust: horizon_protocol::item::FireworkExplosion {
    // rust: shape: e.shape as i32,
    // rust: colors: e.colors.iter().map(|c| *c as i32).collect(),
    // rust: fade: e.fade.iter().map(|c| *c as i32).collect(),
    // rust: trail: e.trail,
    // rust: twinkle: e.twinkle,
}
}

// A rocket's `minecraft:fireworks` and a star's `minecraft:firework_explosion`.
    // rust: pub fn firework_components(
    // rust: d: &crate::item_data::StackData,
    // rust: ) -> Vec<(i32, horizon_protocol::item::Component)> {
//     use horizon_protocol::item::{Component, component};
    // rust: let mut out = Vec::new();
    // rust: if let Some((flight, explosions)) = &d.fireworks {
    // rust: out.push((
    // rust: component::FIREWORKS,
    // rust: Component::Fireworks {
    // rust: flight: i32::from(*flight),
    // rust: explosions: explosions.iter().map(network_explosion).collect(),
    // rust: },
    // rust: ));
}
    // rust: if let Some(e) = &d.firework_explosion {
    // rust: out.push((
    // rust: component::FIREWORK_EXPLOSION,
    // rust: Component::FireworkExplosion(network_explosion(e)),
    // rust: ));
}
    // rust: out
}

// `DyeColor.getId` of a dye's name.
dye_id :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: crate::block_entity_render::DYES
    // rust: .iter()
    // rust: .position(|d| d.0 == name)
    // rust: .map(|i| i as i32)
}

// `SignText.STREAM_CODEC` of a saved `SignText.CODEC` value: the four
// messages, the four filtered ones when it has them, the dye's id (black when
// absent) and the glow.
sign_text_bytes :: proc(text: ^horizon_world::nbt::Tag) -> O {
    // Ported from Horizon
    return {}
}
//     use horizon_world::nbt::Tag;
    // rust: let lines = |key: &str| match text.get(key) {
    // rust: Some(Tag::List(lines)) if lines.len() == 4 => Some(lines),
    // rust: _ => None,
}
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: lines("messages")?.iter().for_each(|line| w.nbt(line));
    // rust: let filtered = lines("filtered_messages");
    // rust: w.bool(filtered.is_some());
    // rust: filtered.into_iter().flatten().for_each(|line| w.nbt(line));
    // rust: let color = match text.get("color") {
    // rust: Some(Tag::String(color)) => color.to_string_lossy(),
    // rust: _ => "black".into(),
}
    // rust: w.varint(dye_id(&color)?);
    // rust: w.bool(matches!(text.get("has_glowing_text"), Some(Tag::Byte(b)) if *b != 0));
    // rust: Some(w.data)
}

// The off hand slot is conventionally 40 in saves and 45 in the menu.
// `synced_id` names an entry of a synced registry (enchantments, trim
// materials and patterns) by its id on this connection.
    // rust: pub fn stack_to_network(
    // rust: item_id: impl Fn(&str) -> i32,
    // rust: synced_id: impl Fn(&str, &str) -> Option<i32>,
    // rust: s: &Option<ItemStack>,
    // rust: ) -> Option<Stack> {
    // rust: network_stack(&item_id, &synced_id, s)
}
    // rust: fn network_stack(
    // rust: item_id: &dyn Fn(&str) -> i32,
    // rust: synced_id: &dyn Fn(&str, &str) -> Option<i32>,
    // rust: s: &Option<ItemStack>,
    // rust: ) -> Option<Stack> {
    // rust: let enchantment_id = |name: &str| synced_id("minecraft:enchantment", name);
    // rust: let s = s.as_ref()?;
    // rust: let mut stack = Stack::new(item_id(&s.item), s.count as i32);
    // rust: if s.damage > 0 {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::DAMAGE,
    // rust: horizon_protocol::item::Component::Int(s.damage as i32),
    // rust: ));
}
    // rust: let enchantments: Vec<(i32, i32)> = s
    // rust: .enchantments()
    // rust: .iter()
    // rust: .filter_map(|(e, level)| Some((enchantment_id(e)?, *level as i32)))
    // rust: .collect();
    // rust: if !enchantments.is_empty() {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::ENCHANTMENTS,
    // rust: horizon_protocol::item::Component::Enchantments(enchantments),
    // rust: ));
}
    // rust: let stored: Vec<(i32, i32)> = s
    // rust: .stored_enchantments()
    // rust: .iter()
    // rust: .filter_map(|(e, level)| Some((enchantment_id(e)?, *level as i32)))
    // rust: .collect();
    // rust: if !stored.is_empty() {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::STORED_ENCHANTMENTS,
    // rust: horizon_protocol::item::Component::Enchantments(stored),
    // rust: ));
}
    // rust: if let Some(d) = s.data() {
        // TridentItem.use runs on both peers: each must see the stack's own durability limit.
    // rust: if let Some(horizon_world::nbt::Tag::Int(max)) = d.other("minecraft:max_damage") {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::MAX_DAMAGE,
    // rust: horizon_protocol::item::Component::Int(*max),
    // rust: ));
}
        // Unbreakable is a unit component; clients need its presence for the
        // durability bar, tooltip and item model, including in single player.
    // rust: if d.other("minecraft:unbreakable").is_some() {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::UNBREAKABLE,
    // rust: horizon_protocol::item::Component::Unit,
    // rust: ));
}
    // rust: for (name, value) in &d.other {
    // rust: let (removed, kind) = match name.strip_prefix('!') {
    // rust: Some(kind) => (true, kind),
    // rust: None => (false, name.as_str()),
}
    // rust: if horizon_protocol::item::custom::id(kind).is_some() {
    // rust: if let Some(id) = synced_id("minecraft:data_component_type", kind) {
    // rust: if removed {
    // rust: stack.removed.push(id);
    // rust: } else {
    // rust: stack
    // rust: .added
    // rust: .push((id, horizon_protocol::item::Component::Nbt(value.clone())));
}
    // rust: } else {
    // rust: log::warn!("Cannot send custom component {kind} to this peer");
}
}
}
    // rust: if let Some(rgb) = d.dyed_color {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::DYED_COLOR,
    // rust: horizon_protocol::item::Component::Int(rgb),
    // rust: ));
}
        // ArmorTrim: both holders as references into the synced registries.
    // rust: if let Some((material, pattern)) = &d.trim {
    // rust: let id = |registry: &str, name: &str| {
    // rust: if name.contains(':') {
    // rust: synced_id(registry, name)
    // rust: } else {
    // rust: synced_id(registry, &format!("minecraft:{name}"))
}
}
    // rust: if let (Some(material), Some(pattern)) = (
    // rust: id("minecraft:trim_material", material),
    // rust: id("minecraft:trim_pattern", pattern),
    // rust: ) {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::TRIM,
    // rust: horizon_protocol::item::Component::Trim { material, pattern },
    // rust: ));
}
}
        // BannerPatternLayers: each pattern a reference into the synced registry;
        // a layer that has none leaves the stack without the component.
    // rust: let layers: Option<Vec<(i32, i32)>> = d
    // rust: .banner_patterns
    // rust: .iter()
    // rust: .map(|layer| {
    // rust: let name = if layer.pattern.contains(':') {
    // rust: layer.pattern.to_string()
    // rust: } else {
    // rust: format!("minecraft:{}", layer.pattern)
}
    // rust: Some((
    // rust: synced_id("minecraft:banner_pattern", &name)?,
    // rust: dye_id(&layer.color)?,
    // rust: ))
    // rust: })
    // rust: .collect();
    // rust: if let Some(layers) = layers.filter(|layers| !layers.is_empty()) {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::BANNER_PATTERNS,
    // rust: horizon_protocol::item::Component::BannerPatterns(layers),
    // rust: ));
}
        // `painting/variant`: a reference into the synced registry.
    // rust: if let Some(id) = crate::save::text(d.other("minecraft:painting/variant")).and_then(|v| {
    // rust: synced_id(
    // rust: "minecraft:painting_variant",
    // rust: &horizon_world::datafix::dynamic::namespaced(&v),
    // rust: )
    // rust: }) {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::PAINTING_VARIANT,
    // rust: horizon_protocol::item::Component::PaintingVariant(id),
    // rust: ));
}
        // `sign_text_front` and `sign_text_back`: a copied sign's text, which the
        // client's own placement puts on the sign it predicts (#8102).
    // rust: for (name, kind) in [
    // rust: (
    // rust: "minecraft:sign_text_front",
    // rust: horizon_protocol::item::component::SIGN_TEXT_FRONT,
    // rust: ),
    // rust: (
    // rust: "minecraft:sign_text_back",
    // rust: horizon_protocol::item::component::SIGN_TEXT_BACK,
    // rust: ),
    // rust: ] {
    // rust: if let Some(bytes) = d.other(name).and_then(sign_text_bytes) {
    // rust: stack
    // rust: .added
    // rust: .push((kind, horizon_protocol::item::Component::Raw(bytes)));
}
}
        // A shield's `base_color`.
    // rust: if let Some(id) = d.base_color.as_deref().and_then(dye_id) {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::BASE_COLOR,
    // rust: horizon_protocol::item::Component::Int(id),
    // rust: ));
}
    // rust: if let Some(id) = d.map_id {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::MAP_ID,
    // rust: horizon_protocol::item::Component::Int(id),
    // rust: ));
}
    // rust: if d.repair_cost > 0 {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::REPAIR_COST,
    // rust: horizon_protocol::item::Component::Int(d.repair_cost as i32),
    // rust: ));
}
    // rust: if let Some(mode) = d.map_post_processing {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::MAP_POST_PROCESSING,
    // rust: horizon_protocol::item::Component::Int(i32::from(mode)),
    // rust: ));
}
    // rust: if let Some(amplifier) = d.ominous_amplifier {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::OMINOUS_BOTTLE_AMPLIFIER,
    // rust: horizon_protocol::item::Component::Int(i32::from(amplifier)),
    // rust: ));
}
    // rust: stack.added.extend(firework_components(d));
        // A goat horn's instrument, by its `minecraft:instrument` id.
    // rust: if let Some(id) = d
    // rust: .other("minecraft:instrument")
    // rust: .and_then(|t| crate::save::text(Some(t)))
    // rust: .and_then(|name| {
    // rust: synced_id(
    // rust: "minecraft:instrument",
    // rust: &horizon_world::datafix::dynamic::namespaced(&name),
    // rust: )
    // rust: })
    // rust: {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::INSTRUMENT,
    // rust: horizon_protocol::item::Component::Instrument(id),
    // rust: ));
}
        // The compass's lodestone target.
    // rust: if let Some(t) = d.other("minecraft:lodestone_tracker") {
    // rust: let target = t.get("target").and_then(|g| {
    // rust: let Some(horizon_world::nbt::Tag::IntArray(pos)) = g.get("pos") else {
    // rust: return None;
}
    // rust: let dimension = crate::save::text(g.get("dimension"))?;
    // rust: Some((dimension, [*pos.first()?, *pos.get(1)?, *pos.get(2)?]))
    // rust: });
    // rust: let tracked = crate::save::number(t.get("tracked")).is_none_or(|v| v != 0);
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::LODESTONE_TRACKER,
    // rust: horizon_protocol::item::Component::LodestoneTracker { target, tracked },
    // rust: ));
}
        // PotionContents: the potion by its `minecraft:potion` id.
    // rust: if let Some(id) = (d.potion.as_deref()).and_then(|potion| {
    // rust: synced_id(
    // rust: "minecraft:potion",
    // rust: &horizon_world::datafix::dynamic::namespaced(potion),
    // rust: )
    // rust: }) {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::POTION_CONTENTS,
    // rust: horizon_protocol::item::Component::Potion {
    // rust: potion: Some(id),
    // rust: color: None,
    // rust: rest: Vec::new(),
    // rust: },
    // rust: ));
}
        // SuspiciousStewEffects: each effect by its `minecraft:mob_effect` id.
    // rust: if !d.stew_effects.is_empty() {
    // rust: let effects = d
    // rust: .stew_effects
    // rust: .iter()
    // rust: .filter_map(|(effect, duration)| {
    // rust: let name = horizon_world::datafix::dynamic::namespaced(effect);
    // rust: Some((synced_id("minecraft:mob_effect", &name)?, *duration))
    // rust: })
    // rust: .collect();
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::SUSPICIOUS_STEW_EFFECTS,
    // rust: horizon_protocol::item::Component::StewEffects(effects),
    // rust: ));
}
        // A loaded crossbow's ammunition.
    // rust: if !d.charged.is_empty() {
    // rust: let charged = d
    // rust: .charged
    // rust: .iter()
    // rust: .filter_map(|c| network_stack(item_id, synced_id, &Some(c.clone())))
    // rust: .collect();
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::CHARGED_PROJECTILES,
    // rust: horizon_protocol::item::Component::Stacks(charged),
    // rust: ));
}
        // `ItemContainerContents`: a shulker box's items, for its tooltip
        // (ClientContainerTooltip). The wire form is the slot count, then one
        // optional template per slot, so the guest's stack lists the same items
        // the host's holds.
    // rust: if !d.container.is_empty() {
    // rust: let slots: Vec<(i32, Stack)> = d
    // rust: .container
    // rust: .iter()
    // rust: .filter_map(|(slot, s)| {
    // rust: Some((
    // rust: i32::from(*slot),
    // rust: network_stack(item_id, synced_id, &Some(s.clone()))?,
    // rust: ))
    // rust: })
    // rust: .collect();
            // The saved list names only the filled slots; the codec counts them
            // all, from the first to the last that holds one.
    // rust: let size = slots.iter().map(|(slot, _)| slot + 1).max().unwrap_or(0);
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: w.varint(size);
    // rust: for slot in 0..size {
    // rust: let stack = slots.iter().find(|(at, _)| *at == slot).map(|(_, s)| s);
    // rust: w.bool(stack.is_some());
    // rust: if let Some(stack) = stack {
    // rust: <horizon_protocol::item::Template as horizon_protocol::buf::Codec<Stack>>::write(
    // rust: stack,
    // rust: &mut w,
    // rust: );
}
}
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::CONTAINER,
    // rust: horizon_protocol::item::Component::Raw(w.data),
    // rust: ));
}
        // What a bundle holds, for its tooltip (ClientBundleTooltip).
    // rust: if !d.bundle_contents.is_empty() {
    // rust: let contents = d
    // rust: .bundle_contents
    // rust: .iter()
    // rust: .filter_map(|c| network_stack(item_id, synced_id, &Some(c.clone())))
    // rust: .collect();
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::BUNDLE_CONTENTS,
    // rust: horizon_protocol::item::Component::Stacks(contents),
    // rust: ));
}
        // The books a lectern shows and a guest reads.
    // rust: if !d.writable_pages.is_empty() {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::WRITABLE_BOOK_CONTENT,
    // rust: horizon_protocol::item::Component::WritableBook {
    // rust: pages: d.writable_pages.clone(),
    // rust: filtered: Vec::new(),
    // rust: },
    // rust: ));
}
    // rust: if let Some(w) = &d.written {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::WRITTEN_BOOK_CONTENT,
    // rust: horizon_protocol::item::Component::WrittenBook(
    // rust: horizon_protocol::item::WrittenBook {
    // rust: title: w.title.clone(),
    // rust: author: w.author.clone(),
    // rust: generation: i32::from(w.generation),
    // rust: pages: if w.page_tags.len() == w.pages.len() {
    // rust: w.page_tags.clone()
    // rust: } else {
    // rust: w.pages
    // rust: .iter()
    // rust: .map(|p| horizon_protocol::text::literal(p))
    // rust: .collect()
    // rust: },
    // rust: resolved: true,
    // rust: ..Default::default()
    // rust: },
    // rust: ),
    // rust: ));
}
}
    // Keep the component's styles across integrated-server and LAN inventory sync.
    // rust: if let Some(name) = s.data().and_then(|d| d.other("minecraft:custom_name")) {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::CUSTOM_NAME,
    // rust: horizon_protocol::item::Component::Text(name.clone()),
    // rust: ));
}
    // Lore lines as loaded or as a server mod wrote them (a list of text
    // components), so a server menu's items can say more than their name.
    // rust: if let Some(lore_tag) = s.data().and_then(|d| d.other("minecraft:lore")) {
    // rust: let lines = match lore_tag {
    // rust: horizon_world::nbt::Tag::List(lines) => Some(lines.clone()),
            // A string is one literal line, as ComponentSerialization decodes a string tag.
    // rust: horizon_world::nbt::Tag::Compound(_) | horizon_world::nbt::Tag::String(_) => {
    // rust: Some(vec![lore_tag.clone()])
}
    // rust: _ => None,
}
    // rust: if let Some(lines) = lines {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::LORE,
    // rust: horizon_protocol::item::Component::Lore(lines),
    // rust: ));
}
}
    // rust: if s.data()
    // rust: .is_some_and(|d| d.other("!minecraft:lore").is_some())
    // rust: {
    // rust: stack.removed.push(horizon_protocol::item::component::LORE);
}
    // The stack's custom rarity ("common", "uncommon", "rare", "epic" or 0..=3).
    // rust: if let Some(r) = s.data().and_then(|d| d.other("minecraft:rarity")) {
    // rust: let index = match r {
    // rust: horizon_world::nbt::Tag::String(s) => match &*s.to_string_lossy() {
    // rust: "common" => Some(0),
    // rust: "uncommon" => Some(1),
    // rust: "rare" => Some(2),
    // rust: "epic" => Some(3),
    // rust: _ => None,
    // rust: },
    // rust: horizon_world::nbt::Tag::Byte(b) if (0..=3).contains(b) => Some(*b as i32),
    // rust: horizon_world::nbt::Tag::Short(s) if (0..=3).contains(s) => Some(*s as i32),
    // rust: horizon_world::nbt::Tag::Int(i) if (0..=3).contains(i) => Some(*i),
    // rust: _ => None,
}
    // rust: if let Some(index) = index {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::RARITY,
    // rust: horizon_protocol::item::Component::Int(index),
    // rust: ));
}
}
    // rust: if s.data()
    // rust: .is_some_and(|d| d.other("!minecraft:rarity").is_some())
    // rust: {
    // rust: stack
    // rust: .removed
    // rust: .push(horizon_protocol::item::component::RARITY);
}
    // `DataComponents.MAX_STACK_SIZE`: an int in 1..=99 on this stack, not the
    // item's default. A removed component falls back to that default.
    // rust: if s.data()
    // rust: .is_some_and(|d| d.other("!minecraft:max_stack_size").is_some())
    // rust: {
    // rust: stack
    // rust: .removed
    // rust: .push(horizon_protocol::item::component::MAX_STACK_SIZE);
    // rust: } else if let Some(horizon_world::nbt::Tag::Int(n)) =
    // rust: s.data().and_then(|d| d.other("minecraft:max_stack_size"))
    // rust: && (1..=99).contains(n)
    // rust: {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::MAX_STACK_SIZE,
    // rust: horizon_protocol::item::Component::Int(*n),
    // rust: ));
}
    // The component as loaded, so a translatable name stays one.
    // rust: if let Some(name) = s.data().and_then(|d| d.other("minecraft:item_name")) {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::ITEM_NAME,
    // rust: horizon_protocol::item::Component::Text(name.clone()),
    // rust: ));
}
    // The model a pack or mod picks for this stack, which the client's item model reads.
    // rust: if let Some(model) = s
    // rust: .data()
    // rust: .and_then(|d| crate::save::text(d.other("minecraft:item_model")))
    // rust: {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::ITEM_MODEL,
    // rust: horizon_protocol::item::Component::Ident(model),
    // rust: ));
}
    // Arbitrary NBT other mods and item models read back client-side
    // (`item_model.rs`'s `custom_data_at`), as vanilla's DataComponentPatch does.
    // rust: if let Some(tag @ horizon_world::nbt::Tag::Compound(_)) =
    // rust: s.data().and_then(|d| d.other("minecraft:custom_data"))
    // rust: {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::CUSTOM_DATA,
    // rust: horizon_protocol::item::Component::Nbt(tag.clone()),
    // rust: ));
}
    // rust: if let Some(t) = s
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:custom_model_data"))
    // rust: {
    // rust: stack.added.push((
    // rust: horizon_protocol::item::component::CUSTOM_MODEL_DATA,
    // rust: custom_model_data(t),
    // rust: ));
}
    // rust: Some(stack)
}

// `CustomModelData.CODEC` read from its saved form, for its stream codec.
custom_model_data :: proc(t: ^horizon_world::nbt::Tag) -> h {
    // Ported from Horizon
    return {}
}
//     use horizon_world::nbt::Tag;
    // NbtOps writes a list of ints or bytes as an int or byte array.
    // rust: let entries = |key: &str| -> Vec<Tag> {
    // rust: match t.get(key) {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: Some(Tag::IntArray(a)) => a.iter().map(|v| Tag::Int(*v)).collect(),
    // rust: Some(Tag::ByteArray(a)) => a.iter().map(|v| Tag::Byte(*v as i8)).collect(),
    // rust: _ => Vec::new(),
}
}
    // `ARGB.as8BitChannel`.
    // rust: let channel = |v: f64| ((v as f32) * 255.0).floor() as i32 & 255;
    // rust: horizon_protocol::item::Component::CustomModelData {
    // rust: floats: entries("floats")
    // rust: .iter()
    // rust: .filter_map(|v| crate::save::float(Some(v)))
    // rust: .map(|v| v as f32)
    // rust: .collect(),
    // rust: flags: entries("flags")
    // rust: .iter()
    // rust: .filter_map(|v| crate::save::number(Some(v)))
    // rust: .map(|v| v != 0)
    // rust: .collect(),
    // rust: strings: entries("strings")
    // rust: .iter()
    // rust: .filter_map(|v| crate::save::text(Some(v)))
    // rust: .collect(),
        // `ExtraCodecs.RGB_COLOR_CODEC`: an int, or an opaque colour from three floats.
    // rust: colors: entries("colors")
    // rust: .iter()
    // rust: .filter_map(|v| match v {
    // rust: Tag::List(rgb) if rgb.len() == 3 => {
    // rust: let c = |i: usize| crate::save::float(rgb.get(i)).map(channel);
    // rust: Some(0xFF << 24 | c(0)? << 16 | c(1)? << 8 | c(2)?)
}
    // rust: v => crate::save::number(Some(v)).map(|v| v as i32),
    // rust: })
    // rust: .collect(),
}
}

// `Player.isWithinBlockInteractionRange`: `eye` closer than `range` to the
// box of the block at `pos` (`AABB.distanceToSqr`).
within_block_range :: proc(eye: [f64; 3], range: f64, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0..3)
    // rust: .map(|k| {
    // rust: let lo = f64::from(pos[k]);
    // rust: (lo - eye[k]).max(eye[k] - lo - 1.0).max(0.0).powi(2)
    // rust: })
    // rust: .sum::<f64>()
    // rust: < range * range
}

    // rust: mod tests {
//     use super::*;
//     use horizon_protocol::buf::{Codec, Reader, Writer};
//     use horizon_protocol::item::{Component, component};
//     use horizon_world::nbt::Tag;

lore_lines_reach_the_client :: proc() {
}
    // rust: let lines = vec![
    // rust: Tag::compound([("text", Tag::String("Buy 400".into()))]),
    // rust: Tag::compound([
    // rust: ("text", Tag::String("▲ 2.0%".into())),
    // rust: ("color", Tag::String("green".into())),
    // rust: ]),
    // rust: ];
    // rust: let mut item = ItemStack::new("minecraft:diamond", 1);
    // rust: item.data_mut()
    // rust: .other
    // rust: .push(("minecraft:lore".into(), Tag::List(lines.clone())));
    // rust: let sent = stack_to_network(|_| 7, |_, _| None, &Some(item));
    // rust: let mut writer = Writer::new();
    // rust: horizon_protocol::item::Slot::write(&sent, &mut writer);
    // rust: let mut reader = Reader::new(&writer.data);
    // rust: let received = horizon_protocol::item::Slot::read(&mut reader)
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: received.component(component::LORE),
    // rust: Some(&Component::Lore(lines))
    // rust: );
}

rarity_reaches_the_client :: proc() {
}
    // rust: let mut item = ItemStack::new("minecraft:stick", 1);
    // rust: item.data_mut()
    // rust: .set_other("minecraft:rarity", Some(Tag::String("epic".into())));
    // rust: let sent = stack_to_network(|_| 7, |_, _| None, &Some(item));
    // rust: let mut writer = Writer::new();
    // rust: horizon_protocol::item::Slot::write(&sent, &mut writer);
    // rust: let mut reader = Reader::new(&writer.data);
    // rust: let received = horizon_protocol::item::Slot::read(&mut reader)
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: received.component(component::RARITY),
    // rust: Some(&Component::Int(3))
    // rust: );
}

styled_custom_name_survives_inventory_sync :: proc() {
}
    // rust: let name = Tag::compound([
    // rust: ("text", Tag::String("Red".into())),
    // rust: ("color", Tag::String("#ff0000".into())),
    // rust: ("italic", Tag::Byte(0)),
    // rust: ]);
    // rust: let mut item = ItemStack::new("minecraft:stick", 1);
    // rust: item.data_mut().custom_name = Some(name.clone());
    // rust: let sent = stack_to_network(|_| 7, |_, _| None, &Some(item));
    // rust: let mut writer = Writer::new();
    // rust: horizon_protocol::item::Slot::write(&sent, &mut writer);
    // rust: let mut reader = Reader::new(&writer.data);
    // rust: let received = horizon_protocol::item::Slot::read(&mut reader)
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(reader.remaining(), 0);
    // rust: assert_eq!(
    // rust: received.component(component::CUSTOM_NAME),
    // rust: Some(&Component::Text(name))
    // rust: );
}

potions_go_as_potion_registry_ids :: proc() {
}
    // rust: let synced_id = |registry: &str, name: &str| match (registry, name) {
    // rust: ("minecraft:potion", "minecraft:swiftness") => Some(14),
    // rust: _ => None,
}
    // rust: let potion = ItemStack::new("minecraft:splash_potion", 1).with_potion("swiftness");
    // rust: let stack = stack_to_network(|_| 7, synced_id, &Some(potion)).unwrap();
    // rust: assert_eq!(
    // rust: stack.component(component::POTION_CONTENTS),
    // rust: Some(&Component::Potion {
    // rust: potion: Some(14),
    // rust: color: None,
    // rust: rest: Vec::new(),
    // rust: })
    // rust: );
}

trims_go_as_synced_registry_references :: proc() {
}
    // rust: let mut chestplate = ItemStack::new("minecraft:diamond_chestplate", 1);
    // rust: chestplate.data_mut().trim = Some(("minecraft:gold".into(), "coast".into()));
    // rust: let synced_id = |registry: &str, name: &str| match (registry, name) {
    // rust: ("minecraft:trim_material", "minecraft:gold") => Some(4),
    // rust: ("minecraft:trim_pattern", "minecraft:coast") => Some(1),
    // rust: _ => None,
}
    // rust: let stack = stack_to_network(|_| 7, synced_id, &Some(chestplate.clone())).unwrap();
    // rust: assert_eq!(
    // rust: stack.component(component::TRIM),
    // rust: Some(&Component::Trim {
    // rust: material: 4,
    // rust: pattern: 1
    // rust: })
    // rust: );
        // A name the connection's registry lacks sends no trim.
    // rust: chestplate.data_mut().trim = Some(("minecraft:x".into(), "coast".into()));
    // rust: let stack = stack_to_network(|_| 7, synced_id, &Some(chestplate)).unwrap();
    // rust: assert_eq!(stack.component(component::TRIM), None);
}

goat_horns_send_their_instrument_by_registry_id :: proc() {
}
    // rust: let mut horn = ItemStack::new("minecraft:goat_horn", 1);
    // rust: horn.data_mut().other.push((
    // rust: "minecraft:instrument".into(),
    // rust: horizon_world::nbt::Tag::String("minecraft:sing_goat_horn".into()),
    // rust: ));
    // rust: let synced_id = |registry: &str, name: &str| match (registry, name) {
    // rust: ("minecraft:instrument", "minecraft:sing_goat_horn") => Some(1),
    // rust: _ => None,
}
    // rust: let stack = stack_to_network(|_| 7, synced_id, &Some(horn)).unwrap();
    // rust: assert_eq!(
    // rust: stack.component(component::INSTRUMENT),
    // rust: Some(&Component::Instrument(1))
    // rust: );
}

guest_at :: proc(position: [f64; 3]) -> G {
    // Ported from Horizon
    return {}
}
    // rust: let (tx, _rx) = std::sync::mpsc::channel();
    // rust: Guest::new(
    // rust: Joined {
    // rust: conn: 0,
    // rust: uuid: 0,
    // rust: name: "guest".into(),
    // rust: properties: Vec::new(),
    // rust: info: ClientInformation::new(8),
    // rust: brand: String::new(),
    // rust: sender: PlayerSender::new(tx, Arc::new(std::sync::atomic::AtomicUsize::new(0))),
    // rust: latency: Arc::new(AtomicI32::new(0)),
    // rust: address: "127.0.0.1:1".parse().unwrap(),
    // rust: expected: false,
    // rust: },
    // rust: 1,
    // rust: position,
    // rust: 10,
    // rust: )
}

the_client_has_loaded_once_it_says_so_or_after_60_ticks_and_not_while_dead :: proc() {
}
    // rust: let mut g = guest_at([0.0; 3]);
    // rust: assert!(!g.client_loaded());
    // rust: g.load_timeout -= 59;
    // rust: assert!(!g.client_loaded());
    // rust: g.load_timeout -= 1;
    // rust: assert!(g.client_loaded());
    // rust: g.dead = true;
    // rust: assert!(!g.client_loaded());
}

a_dead_player_leaves_its_vehicle_when_its_body_is_removed :: proc() {
}
    // rust: let mut g = guest_at([0.5, -120.0, 0.5]);
    // rust: g.vehicle = Some(7);
    // rust: g.vehicle_good = Some([0.5, -120.0, 0.5]);
    // rust: g.dead = true;
        // LivingEntity.tickDeath: the body sits in the boat for 19 ticks...
    // rust: for tick in 1..20 {
    // rust: assert!(!g.tick_death(), "tick {tick}");
    // rust: assert_eq!(g.vehicle, Some(7), "tick {tick}");
}
        // ...then remove(KILLED)'s setRemoved stops its riding, so the
        // respawned player is not put back into the boat.
    // rust: assert!(g.tick_death());
    // rust: assert_eq!((g.vehicle, g.vehicle_good), (None, None));
}

a_block_action_must_be_within_reach :: proc() {
}
    // rust: let mut g = guest_at([0.5, 64.0, 0.5]);
        // Survival (4.5 + 1 from the eyes): five blocks off horizontally,
        // not one further.
    // rust: assert!(g.may_reach_block([5, 64, 0]));
    // rust: assert!(!g.may_reach_block([6, 64, 0]));
        // Creative's 5.0 reaches one block further.
    // rust: g.game_mode = CREATIVE;
    // rust: assert!(g.may_reach_block([6, 64, 0]));
    // rust: assert!(!g.may_reach_block([7, 64, 0]));
        // With no body yet the sneak flag gives the eye height: a block at
        // the edge above is gone once crouched.
    // rust: g.game_mode = SURVIVAL;
    // rust: assert!(g.may_reach_block([0, 71, 0]));
    // rust: g.sneaking = true;
    // rust: assert!(!g.may_reach_block([0, 71, 0]));
}

    // A shulker box's `minecraft:container` crosses to a guest, so its
    // tooltip can list the items it holds (#2979).
shulker_contents_survive_inventory_sync :: proc() {
}
    // rust: let name = Tag::compound([("text", Tag::String("Gold bit".into()))]);
    // rust: let mut inner = ItemStack::new("minecraft:diamond", 2);
    // rust: inner.data_mut().custom_name = Some(name);
    // rust: let mut boxed = ItemStack::new("minecraft:shulker_box", 1);
    // rust: boxed.data_mut().container = vec![(0, inner)];
    // rust: let id = |name: &str| if name.ends_with(":diamond") { 22 } else { 7 };

    // rust: let sent = stack_to_network(id, |_, _| None, &Some(boxed));
    // rust: let mut writer = Writer::new();
    // rust: horizon_protocol::item::Slot::write(&sent, &mut writer);
    // rust: let mut reader = Reader::new(&writer.data);
    // rust: let received = horizon_protocol::item::Slot::read(&mut reader)
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(reader.remaining(), 0);

    // rust: let Some(Component::Raw(bytes)) = received.component(component::CONTAINER) else {
    // rust: panic!("the stack carried no container component");
}
        // ItemContainerContents.STREAM_CODEC: the slot count, then one
        // optional template per slot.
    // rust: let mut r = Reader::new(bytes);
    // rust: assert_eq!(r.count(256).unwrap(), 1);
    // rust: assert!(r.bool().unwrap());
    // rust: let template = horizon_protocol::item::Template::read(&mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0);
    // rust: assert_eq!((template.item, template.count), (22, 2));
    // rust: assert!(matches!(
    // rust: template.component(component::CUSTOM_NAME),
    // rust: Some(Component::Text(_))
    // rust: ));
}

    // The prepared game data a body needs, or `None` without it.
resources :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("skipped: prepared resources unavailable");
    // rust: return None;
}
    // rust: let assets = crate::assets::Assets::load(&root).ok()?;
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).ok()?;
    // rust: Some((assets, resources))
}

    // `/attribute @s <attribute> base set`, as `AttributeCommand` runs it,
    // and the next tick's `refreshDirtyAttributes` (the box of a new scale).
set_base :: proc(m: ^PlayerMotion, attribute: string, value: f64) {
}
    // rust: let key = m.attributes.key(attribute).unwrap();
    // rust: let handle = m.attributes.get_instance(Some(key)).unwrap().unwrap();
    // rust: m.attributes
    // rust: .edit(&handle, |attribute, observer| {
    // rust: attribute.set_base_value(value, observer)
    // rust: })
    // rust: .unwrap();
    // rust: m.refresh_attributes().unwrap();
}

assert_dims :: proc(got: Dimensions, want: (f32) {
}
    // rust: let close = |a: f32, b: f32| (a - b).abs() <= 1e-5 * b.abs().max(1.0);
    // rust: assert!(
    // rust: close(got.width, want.0) && close(got.height, want.1) && close(got.eye_height, want.2),
    // rust: "{what}: {got:?}, want {want:?}"
    // rust: );
}

    // `ServerPlayer.restoreFrom(old, false)` takes the base values
    // (`assignBaseValues`), then `setHealth(getMaxHealth())`: a player whose
    // max health base was set comes back with that much, not 20, and a
    // permanent modifier (`/attribute ... modifier add`) does not count, as
    // it stays with the dead body. The attribute's range is 1..1024.
a_respawned_player_has_the_max_health_of_their_base_values :: proc() {
}
//         use horizon_world::attributes::{Modifier, Operation};
    // rust: let Some((_assets, resources)) = resources() else {
    // rust: return;
}
    // rust: for (base, bonus, want) in [
    // rust: (40.0, 0.0, 40.0),
    // rust: (10.0, 0.0, 10.0),
    // rust: (20.0, 20.0, 20.0),
    // rust: (0.0, 0.0, 1.0),
    // rust: (2048.0, 0.0, 1024.0),
    // rust: ] {
    // rust: let mut g = guest_at([0.5, 64.0, 0.5]);
    // rust: let mut m = PlayerMotion::new(&resources, Vec3::new(0.5, 64.0, 0.5)).unwrap();
    // rust: set_base(&mut m, "minecraft:max_health", base);
    // rust: let key = m.attributes.key("minecraft:max_health").unwrap();
    // rust: let handle = m.attributes.get_instance(Some(key)).unwrap().unwrap();
    // rust: let bonus = Modifier::new("test:bonus", bonus, Operation::AddValue).unwrap();
    // rust: m.attributes
    // rust: .edit(&handle, |a, o| a.add_permanent(bonus, o))
    // rust: .unwrap();
    // rust: g.motion = Some(Box::new(m));
    // rust: assert!(g.new_body(false).is_some());
    // rust: assert_eq!(g.respawn_health(&resources), want, "base {base}");
}
        // No body to take anything from: the default.
    // rust: let g = guest_at([0.5, 64.0, 0.5]);
    // rust: assert_eq!(g.respawn_health(&resources), 20.0);
}

    // #3684: a glide the client announced (`START_FALL_FLYING`) is the
    // player's pose before its body's own tick has taken it: the box in
    // between is the gliding one at the player's scale, not at scale 1 (a
    // 0.6 box on a player 0.1 or 2 times as big sent them back from a wall).
a_glide_announced_before_the_body_ticks_has_the_scaled_box :: proc() {
}
    // rust: let Some((_assets, resources)) = resources() else {
    // rust: return;
}
    // rust: for (scale, side) in [(0.1_f64, 0.06_f32), (2.0, 1.2)] {
    // rust: let mut g = guest_at([0.5, 64.0, 0.5]);
    // rust: let mut m = PlayerMotion::new(&resources, Vec3::new(0.5, 64.0, 0.5)).unwrap();
    // rust: set_base(&mut m, "minecraft:scale", scale);
    // rust: m.set_pose(Pose::Standing).unwrap();
    // rust: g.motion = Some(Box::new(m));
    // rust: g.fall_flying = true;
    // rust: assert_eq!(g.pose(), Pose::FallFlying);
    // rust: assert_ne!(g.motion.as_ref().unwrap().pose, Pose::FallFlying);
    // rust: let d = g.dimensions();
    // rust: assert_dims(
    // rust: d,
    // rust: (side, side, side * (0.4 / 0.6)),
    // rust: &format!("scale {scale}"),
    // rust: );
}
}
}
