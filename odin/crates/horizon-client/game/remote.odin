//! Transpiled from Horizon Rust crate
package horizon_client_remote

import "core:fmt"
import "core:mem"
import "core:math"

// Multiplayer: the game driven by a server connection instead of the local
// simulation. Mirrors vanilla's ClientPacketListener (chunks, entities,
// inventory, health, time, weather, chat, respawn and dimension changes),
// LocalPlayer.sendPosition (movement packets) and MultiPlayerGameMode
// (block breaking with sequence numbers, use-item, attacks, container
// clicks). The player still moves with the local physics, as the vanilla
// client predicts its own movement; the server stays authoritative for
// everything else.
// use super::remote_chunks::{ChunkDecoder, ChunkFormat, Next};
// use super::{Dim, Game, Mining, Screen};
// use horizon_client::actions::Action;
// use horizon_client::first_person::{Hand, SwingAnimation};
// use horizon_client::{
    // rust: Result,
    // rust: blocks::Fluid,
    // rust: chunk::Chunk,
    // rust: containers::{BlockEntity, Furnace, FurnaceKind},
    // rust: entities::{Experience, ExperienceOrb, ItemEntity},
    // rust: hud::HudBatch,
    // rust: items::ItemStack,
    // rust: lan::data::{BIOME_REGISTRY, client_biomes},
    // rust: menu::Input,
    // rust: mobs::{Mob, MobType, Who},
    // rust: motion::{MotionWorld, PlayerMotion},
    // rust: net::{Event, Session},
    // rust: save::SaveDir,
    // rust: screen_effects,
    // rust: sprint::Keys,
    // rust: streaming::{ChunkGenerator, Proto, Streaming},
    // rust: tab_list::SPECTATOR,
    // rust: world::World,
}
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use horizon_protocol::{
    // rust: entity_data::{ITEM_ENTITY_ITEM, Value},
    // rust: item::{Hashed, Stack},
    // rust: packets::{
    // rust: Empty,
    // rust: play::{self, Clientbound as C, Serverbound as S},
    // rust: },
    // rust: registry::{Builtin, DimensionType, Dynamic, SyncedNames, ceil_log2},
    // rust: rsa::RsaPublicKey,
    // rust: secure_chat::{self, Signature},
    // rust: text::{Language, plain},
}
// use horizon_world::{
    // rust: attachments::{Attachments, Holder},
    // rust: level::InteractionResult,
    // rust: nbt::Tag,
    // rust: registry::BlockStateId,
    // rust: stepped_interpolation::{Path, PosRot, Start, SteppedInterpolation},
}
// use std::{
    // rust: collections::{HashMap, VecDeque},
    // rust: sync::Arc,
    // rust: time::{Duration, Instant},
}
// use winit::{event::MouseButton, keyboard::KeyCode};

    // rust: type BuiltinCache = Vec<(std::path::PathBuf, Arc<Builtin>)>;
BUILTIN :: std::sync::Mutex::new(Vec::new())

// The prepared resources' `registries.json`, parsed once per root: the
// file never changes while the game runs, and parsing it took about 3 ms
// of the frame that joins a server (or opens a single-player world).
// `None` when it is missing or invalid (not cached: a fixed install can
// join again).
    // rust: pub(super) fn builtin_registries(root: &std::path::Path) -> Option<Arc<Builtin>> {
    // rust: let mut cache = BUILTIN.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some((_, builtin)) = cache.iter().find(|(cached, _)| cached == root) {
    // rust: return Some(builtin.clone());
}
    // rust: let builtin = Arc::new(Builtin::find(root).and_then(|p| Builtin::load(&p).ok())?);
    // rust: cache.push((root.to_owned(), builtin.clone()));
    // rust: Some(builtin)
}

// `ChatType`'s two decorations: how a message shows in the chat, and what
// the narrator says of it.
Decoration :: enum {
    Chat,
    Narration,
}

// `ChatTypeDecoration.decorate` of a chat type's `chat` or `narration`
// entry: its translation, with the sender, the target or the message as its
// parameters, in its style. A chat type the registry lacks decorates as
// `minecraft:chat` (`chat.type.text`, narrated `chat.type.text.narrate`).
    // rust: fn chat_type_decorate(
    // rust: chat_type: Option<&Tag>,
    // rust: decoration: Decoration,
    // rust: bound: &play::ChatTypeBound,
    // rust: content: &serde_json::Value,
    // rust: ) -> serde_json::Value {
//     use horizon_client::scoreboard::tag_to_json;
    // rust: let (field, default_key) = match decoration {
    // rust: Decoration::Chat => ("chat", "chat.type.text"),
    // rust: Decoration::Narration => ("narration", "chat.type.text.narrate"),
}
    // rust: let decoration = chat_type.and_then(|t| t.get(field));
    // rust: let key = match decoration.and_then(|d| d.get("translation_key")) {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: _ => default_key.into(),
}
    // rust: let parameter = |name: &str| match name {
    // rust: "sender" => tag_to_json(&bound.name),
    // rust: "target" => bound
    // rust: .target
    // rust: .as_ref()
    // rust: .map_or_else(|| serde_json::Value::from(""), tag_to_json),
    // rust: _ => content.clone(),
}
    // rust: let with: Vec<serde_json::Value> = match decoration.and_then(|d| d.get("parameters")) {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .map(|p| match p {
    // rust: Tag::String(s) => parameter(&s.to_string_lossy()),
    // rust: _ => serde_json::Value::from(""),
    // rust: })
    // rust: .collect(),
    // rust: _ => vec![parameter("sender"), parameter("content")],
}
    // rust: let mut component = match decoration.and_then(|d| d.get("style")) {
    // rust: Some(style @ Tag::Compound(_)) => tag_to_json(style),
    // rust: _ => serde_json::json!({}),
}
    // rust: component["translate"] = key.into();
    // rust: component["with"] = with.into();
    // rust: component
}

// A text component the server sent, for the HUD.
    // rust: pub(super) fn remote_text(tag: &Tag) -> horizon_client::text::Text {
//     use horizon_client::scoreboard::{comp_text, tag_to_json};
    // rust: comp_text(&tag_to_json(tag))
}

// `Player.getVoicePitch`: a constant 1.0
// (`javap -p -c -constants net.minecraft.world.entity.player.Player`:
// `0: fconst_1  1: freturn`), so a player's own hurt and death sounds are
// neither raised for a baby nor jittered - `LivingEntity.getVoicePitch`, which
// the mobs port, does both. It takes no random, so it draws nothing from the
// level random either.
    // rust: pub(super) fn player_voice_pitch() -> f32 {
    // rust: 1.0
}

// The hurt sound of a `ClientboundDamageEventPacket`'s damage type, by its
// synchronized registry id: `Player.getHurtSound` picks the type's effects.
    // rust: fn hurt_sound_for(
    // rust: registries: &Dynamic,
    // rust: damage: &horizon_world::damage_source::Catalog,
    // rust: source_type: i32,
    // rust: ) -> &'static str {
    // rust: if let Some(data) = registries.data("minecraft:damage_type", source_type) {
    // rust: let effects = data.get("effects").and_then(|t| match t {
    // rust: Tag::String(effects) => effects.to_string().ok(),
    // rust: _ => None,
    // rust: });
    // rust: return horizon_client::health::hurt_sound(effects.as_deref().unwrap_or("hurt"));
}
    // rust: registries
    // rust: .name("minecraft:damage_type", source_type)
    // rust: .and_then(|name| damage.id(name).and_then(|id| damage.definition(id)))
    // rust: .map_or(horizon_client::health::hurt_sound("hurt"), |d| {
    // rust: horizon_client::health::hurt_sound(&d.effects)
    // rust: })
}

// The live entity a bound sound names; absence means that object was removed.
    // rust: fn entity_sound_state(
    // rust: id: i32,
    // rust: player: Option<(i32, [f64; 3], bool)>,
    // rust: mob: Option<horizon_client::sound_engine::SoundEntityState>,
    // rust: tracked: &HashMap<i32, Tracked>,
    // rust: dragon: Option<(i32, [f64; 3])>,
    // rust: ) -> Option<horizon_client::sound_engine::SoundEntityState> {
//     use horizon_client::sound_engine::SoundEntityState;
    // rust: if let Some((player_id, position, silent)) = player
    // rust: && player_id == id
    // rust: {
    // rust: return Some(SoundEntityState {
    // rust: position,
    // rust: silent,
    // rust: removed: false,
    // rust: });
}
    // rust: let mut state = mob.or_else(|| {
    // rust: tracked.get(&id).map(|t| SoundEntityState {
    // rust: position: t.position,
    // rust: silent: t.silent,
    // rust: removed: false,
    // rust: })
    // rust: })?;
    // The dragon's Mob is metadata storage; only Dragon follows its movement.
    // rust: if let Some((dragon_id, position)) = dragon
    // rust: && dragon_id == id
    // rust: {
    // rust: state.position = position;
}
    // rust: Some(state)
}

// `ClientboundOpenScreenPacket.title` as a container screen draws it: the
// component's styles, and the `§` codes a literal holds (`StringDecomposer`).
menu_title :: proc(tag: ^Tag) -> h {
    // Ported from Horizon
    return {}
}
    // rust: remote_text(tag).resolve_legacy()
}

// A player message Chat Delay holds back, its signature and trust level,
// what the narrator says of it once it shows, and who sent it in which
// chat type, for mods told when it shows (`ClientChatReceivedEvent`).
QueuedChat :: struct {
    line: horizon_client::text::Text,
    signature: Maybe(Signature),
    trust: ChatTrust,
    narration: string,
    // The player's UUID, 0 for disguised chat (`Util.NIL_UUID`).
    sender: u128,
    // The chat type's network ID (`ChatType.Bound.chatType`).
    chat_type: i32,
}

// `ChatTrustLevel`; a modified message keeps the signed content it was
// changed from.
    // rust: pub(super) enum ChatTrust {
    // rust: Secure,
    // rust: Modified(String),
    // rust: NotSecure,
    // `GuiMessageTag.chatError`: the line `ChatListener.handleChatMessageError` adds.
    // rust: Error,
}
    // rust: impl ChatTrust {
    // `ChatTrustLevel.createTag`.
tag :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Secure => None,
    // rust: Self::Modified(original) => Some(horizon_client::chat::Tag::modified(original)),
    // rust: Self::NotSecure => Some(horizon_client::chat::Tag::not_secure()),
    // rust: Self::Error => Some(horizon_client::chat::Tag::chat_error()),
}
}
}

// Streaming needs a generator; a server world never generates.
NoTerrain :: struct {
    // rust: impl ChunkGenerator for NoTerrain {
    // rust: type Worker = ();
worker :: proc(self: ^Self) {
}
proto :: proc(self: ^Self, _: ^() {
}
    Box: :new(()),
}
finish :: proc(self: ^Self, _: Proto) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Chunk::empty(0, 0)
}
}

// A server entity the client tracks (position as last sent).
Tracked :: struct {
    kind: string,
    position: [f64,
    silent: bool,
    // `Entity.vehicle`: the entity it rides (`SetPassengers`), whatever
    // either one's type.
    vehicle: Maybe(u32),
}

// `Entity.startRiding` / `removePassenger` for a `SetPassengers` packet: the
// listed entities ride `vehicle`, the ones that rode it and are no longer
// listed got off. Every tracked entity counts, whatever its type, so a
// server's item display or marker on a player hides that player's name tag
// as vanilla's `isVehicle` does (#5666).
seat_passengers :: proc(entities: ^HashMap<i32, vehicle: u32, passengers: ^[i32]) {
}
    // rust: for (id, t) in entities.iter_mut() {
    // rust: if passengers.contains(id) {
    // rust: t.vehicle = Some(vehicle);
    // rust: } else if t.vehicle == Some(vehicle) {
    // rust: t.vehicle = None;
}
}
}
// Smooth an entity toward a new position over three ticks (InterpolationHandler).
// `LinearInterpolationHandler`'s target: a position and rotation (yRot,
// xRot) reached in `steps` ticks.
Lerp :: struct {
    target: [f64,
    rotation: Option<(f32,
    steps: u32,
}

// `NewMinecartBehavior.MinecartStep`, including the server's rail pitch.
CartStep :: struct {
    position: Vec3,
    movement: Vec3,
    yaw: f32,
    pitch: f32,
    weight: f32,
}

// The client's state of a minecart on `NewMinecartBehavior`: the steps the
// server sent (`lerpSteps`), the ones being played over 3 ticks
// (`currentLerpSteps`) and where the cart was when they began (`oldLerp`).
CartLerp :: struct {
    pending: [dynamic]CartStep,
    current: [dynamic]CartStep,
    total_weight: f64,
    delay: i32,
    old: CartStep,
}

    // rust: impl CartLerp {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: pending: Vec::new(),
    // rust: current: Vec::new(),
    // rust: total_weight: 0.0,
    // rust: delay: 0,
    // rust: old: CartStep {
    // rust: position: Vec3::ZERO,
    // rust: movement: Vec3::ZERO,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: weight: 0.0,
    // rust: },
}
}

    // `NewMinecartBehavior.getCartLerpPosition`, `getCartLerpMovements` and
    // `getCartLerpYRot` / `getCartLerpXRot` at `partial`: the step the weights
    // put this moment in, and how far along it from the one before.
at :: proc(self: ^Self, partial: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let alpha = ((3 - self.delay) as f32 + partial) / 3.0;
    // rust: let mut count_up = 0.0f32;
    // rust: let mut in_step = 1.0f32;
    // rust: let mut found = None;
    // rust: for (i, s) in self.current.iter().enumerate() {
    // rust: if s.weight <= 0.0 {
    // rust: continue;
}
    // rust: count_up += s.weight;
    // rust: if f64::from(count_up) >= self.total_weight * f64::from(alpha) {
    // rust: let before = count_up - s.weight;
    // rust: in_step = ((f64::from(alpha) * self.total_weight - f64::from(before))
    // rust: / f64::from(s.weight)) as f32;
    // rust: found = Some(i);
    // rust: break;
}
}
    // rust: let index = found.unwrap_or(self.current.len() - 1);
    // rust: let current = self.current[index];
    // rust: let previous = if index > 0 {
    // rust: self.current[index - 1]
    // rust: } else {
    // rust: self.old
}
    // rust: let t = f64::from(in_step);
    // rust: let lerp = |a: Vec3, b: Vec3| {
    // rust: Vec3::new(
    // rust: a.x + t * (b.x - a.x),
    // rust: a.y + t * (b.y - a.y),
    // rust: a.z + t * (b.z - a.z),
    // rust: )
}
    // rust: (
    // rust: lerp(previous.position, current.position),
    // rust: lerp(previous.movement, current.movement),
    // rust: previous.yaw + in_step * wrap_degrees(current.yaw - previous.yaw),
    // rust: previous.pitch + in_step * wrap_degrees(current.pitch - previous.pitch),
    // rust: )
}

    // `NewMinecartBehavior.lerpClientPositionAndRotation`: once the steps
    // being played are used up, the queued ones become the current ones;
    // the cart then sits where the steps put it at the end of this tick.
    // False when it has no steps to play.
tick :: proc(self: ^Self, c: ^super::minecarts::Minecart) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.delay -= 1;
    // rust: if self.delay <= 0 {
    // rust: self.old = CartStep {
    // rust: position: c.position,
    // rust: movement: c.velocity,
    // rust: yaw: c.yaw,
    // rust: pitch: c.pitch,
    // rust: weight: 0.0,
}
    // rust: self.current.clear();
    // rust: if !self.pending.is_empty() {
    // rust: self.current.append(&mut self.pending);
    // rust: self.total_weight = self.current.iter().map(|s| f64::from(s.weight)).sum();
    // rust: self.delay = if self.total_weight == 0.0 { 0 } else { 3 };
}
}
    // rust: if self.current.is_empty() {
    // rust: return false;
}
    // rust: let (position, movement, yaw, pitch) = self.at(1.0);
    // rust: c.position = position;
    // rust: c.velocity = movement;
    // rust: c.yaw = yaw;
    // rust: c.pitch = pitch;
    // rust: true
}
}

// `SteppedInterpolationHandler.doInterpolate`'s `setPos` and `setRot` on a
// mob: its yaw kept continuous (the same turn as vanilla's, without the
// wrap that would spin it in the frame between ticks), its pitch clamped.
place_interpolated :: proc(m: ^Mob, at: PosRot) {
}
    // rust: m.position = Vec3::new(at.position[0], at.position[1], at.position[2]);
    // rust: m.yaw += wrap_degrees(at.yaw - m.yaw);
    // rust: m.head_pitch = (at.pitch % 360.0).clamp(-90.0, 90.0);
}

// The packet a living entity's move came in.
MovePacket :: enum {
    // `handleMoveEntity`: always interpolated.
    Move,
    // `handleEntityPositionSync`.
    PositionSync,
    // `handleTeleportEntity` (`setValuesFromPositionPacket`).
    Teleport,
}

    // rust: impl MovePacket {
    // `tooBigToInterpolate`: a move to `to` of more than 64 blocks snaps.
    // A position sync measures it from where the entity is, a teleport from
    // where it is headed (`PositionMoveRotation.of`'s
    // `getClientPositionAndRotation`).
snaps :: proc(self: ^Self, handler: ^SteppedInterpolation, entity: PosRot, to: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let from = match self {
    // rust: MovePacket::Move => return false,
    // rust: MovePacket::PositionSync => entity.position,
    // rust: MovePacket::Teleport => handler.heading(entity).position,
}
    // rust: let d = [0, 1, 2].map(|i| to[i] - from[i]);
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] > 4096.0
}
}

// A move `packet` to `to` for a living entity at `entity`, through its
// handler (`interpolateTo`): where it is put at once, if anywhere. A move
// too big to interpolate is a `snapTo`; vanilla leaves the handler running
// and its next step shifts what is left by the jump
// (`adjustInterpolationTargetFromDeltas`), which this handler doesn't port,
// so the steps are dropped instead. That is the same for an entity that
// wasn't moving, as a teleported one usually isn't.
    // rust: fn stepped_move(
    // rust: handler: &mut SteppedInterpolation,
    // rust: packet: MovePacket,
    // rust: entity: PosRot,
    // rust: to: [f64; 3],
    // rust: path: Option<Path>,
    // rust: rotation: Option<(f32, f32)>,
    // rust: ) -> Option<PosRot> {
    // rust: if packet.snaps(handler, entity, to) {
    // rust: handler.cancel();
    // rust: let (yaw, pitch) = rotation.unwrap_or((entity.yaw, entity.pitch));
    // rust: return Some(PosRot {
    // rust: position: to,
    // rust: yaw,
    // rust: pitch,
    // rust: });
}
    // rust: match handler.interpolate_to(entity, path, rotation) {
    // rust: Start::Snap(at) => Some(at),
    // rust: Start::Interpolating | Start::Unchanged => None,
}
}

// What the network thread delivered, in order: an event, or a chunk packet
// handed to the decoder (with the format it decodes with), whose column
// comes back from `ChunkDecoder::next`.
Received :: enum {
    Event(Event),
    Chunk(Arc<ChunkFormat>),
}

// `Minecraft.services().profileKeySignatureValidator()`: the services' profile-key keys, which a
// player's chat key must be signed by. Asked for once per connection to a server, off the game
// thread.
    // rust: pub(super) enum ServicesKeys {
    // rust: Pending,
    // rust: Ready(Vec<RsaPublicKey>),
    // `canValidateProfileKeys()` is false: none could be had.
    // rust: Missing,
}
// The signed-in account's `/minecraft/profile` fetch after joining.
OwnProfile :: enum {
    Idle,
    Fetching(std::sync::mpsc::Receiver<Option<horizon_client::skins::Textures>>),
    Done(Option<horizon_client::skins::Textures>),
}

    // rust: pub(super) struct Remote {
    // rust: pub session: Session,
    // rust: pub brand: String,
    // This connection's configured feature flags, carried through reconfiguration.
    // rust: pub(super) features: Vec<String>,
    // The server announced it runs mods' quiet commands.
    // rust: pub quiet_commands: bool,
    // The server announced it carries mod messages.
    // rust: pub mod_net: bool,
    // The synced attachments the server sent, by holder.
    // rust: pub attachments: HashMap<Holder, Attachments>,
    // The server samples far terrain for us, this far at most (`lod_net`).
    // rust: pub far_terrain: Option<horizon_client::lod_net::Offer>,
    // rust: pub(super) builtin: Arc<Builtin>,
    // rust: lang: Arc<Language>,
    // rust: pub(super) registries: Arc<Dynamic>,
    // The game's enchantments and the server's that it lacks (a data
    // pack's), from their synced data; `None` when the server has none.
    // rust: pub(super) enchantments: Option<Arc<horizon_client::enchant::Enchantments>>,
    // rust: pub(super) joined: bool,
    // `ServerReconfigScreen` is up since this tick.
    // rust: pub(super) reconfiguring: Option<u64>,
    // `handleLogin` ran: vanilla's `Minecraft.player` exists from then on,
    // while here the player is made at the first teleport.
    // rust: pub(super) logged_in: bool,
    // rust: status: String,
    // rust: pub(super) entity_id: i32,
    // rust: local_entity_silent: bool,
    // `Minecraft.cameraEntity` when the server put the view on another
    // entity (ClientboundSetCameraPacket); None while it is the player.
    // rust: pub(super) camera: Option<i32>,
    // The item the player's use began with (`LivingEntity.useItem`).
    // rust: pub(super) use_item: Option<Arc<str>>,
    // rust: pub(super) dimension: DimensionType,
    // The level's key (`minecraft:overworld`): where its far terrain is kept.
    // rust: pub(super) level: String,
    // The level's hashed seed (login, respawn): the folder of its kept chunks
    // (`server_terrain::level_dir`).
    // rust: pub(super) hashed_seed: i64,
    // What chunk packets decode with (the dimension's height and sky, the
    // biome registry); replaced whenever one of them changes.
    // rust: pub(super) chunk_format: Arc<ChunkFormat>,
    // Decodes chunk packets as they arrive, off the frame.
    // rust: decoder: ChunkDecoder,
    // Options.serverRenderDistance: the server's view distance from the
    // login or the last chunk-cache-radius packet.
    // rust: pub(super) view_distance: i32,
    // `ClientLevel.serverSimulationDistance`: from the login or the last
    // simulation-distance packet.
    // rust: pub(super) simulation_distance: i32,
    // `BlockStatePredictionHandler.currentSequenceNr`: the level's, so a new level (a login,
    // another dimension) counts from 0 again.
    // rust: sequence: i32,
    // rust: position_sender: horizon_client::player_sync::PositionSender,
    // rust: last_input: u8,
    // rust: was_sprinting: bool,
    // The slot the server last heard (`MultiPlayerGameMode.carriedIndex`): a cell, so `send` can
    // send a new one first (`ensureHasSentCarriedItem`).
    // rust: carried: std::cell::Cell<Option<usize>>,
    // The last ClientboundPlayerAbilitiesPacket. Vanilla's LocalPlayer
    // holds its abilities from the login on; here the player is made at
    // the first teleport, which takes them then.
    // rust: abilities: Option<play::PlayerAbilities>,
    // rust: loaded_sent: bool,
    // The dimension of the client level the mods heard made
    // (`native_client_level_load`), to be told dropped once.
    // rust: heard_level: Option<String>,
    // The epoch native mods' entity handles carry on this client
    // (`native_entity_refs.rs`): a fresh one for each client level, so a
    // handle of the level before reads as None. None before the first.
    // rust: native_epoch: Option<horizon_client::mod_api::NativeWorldEpoch>,
    // `ClientPacketListener.levelLoadTracker`: the loading screen after a login
    // or respawn, until the player's section is shown.
    // rust: pub(super) level_load: horizon_client::level_loading::LevelLoadTracker,
    // The ClientInformation last sent (`Options.broadcastOptions` sends it
    // again when a view distance, Chat, skin or Main Hand option changes).
    // rust: sent_info: horizon_protocol::packets::configuration::ClientInformation,
    // BlockStatePredictionHandler: blocks changed ahead of the server (a predicted break),
    // with the sequence of the last action that changed them and the state the server
    // last said they have. Until the server acknowledges that sequence its block updates
    // only replace the remembered state; then the block takes it.
    // rust: predictions: HashMap<[i32; 3], (i32, i32)>,
    // Open container: (window id, menu name).
    // rust: pub(super) menu: Option<(i32, String)>,
    // The crafting result slot of the open menu as the server last set it
    // (`CraftingMenu.slotChangedCraftingGrid`): the client never computes it.
    // rust: pub(super) craft_result: Option<ItemStack>,
    // The open menu's title as the server named it, with its styles.
    // rust: pub(super) menu_title: Option<horizon_client::text::Text>,
    // rust: state_id: i32,
    // rust: use_target: Option<[i32; 3]>,
    // A mod menu's extra data, kept for the `OpenScreen` of its window that
    // follows (`horizon:menu_extra`).
    // rust: menu_extra: Option<horizon_protocol::menu_extra::Message>,
    // rust: entities: HashMap<i32, Tracked>,
    // rust: lerps: HashMap<i32, Lerp>,
    // The minecarts the server moves with `ClientboundMoveMinecartPacket`
    // (`NewMinecartBehavior`), which have no interpolation handler.
    // rust: cart_lerps: HashMap<i32, CartLerp>,
    // Living entities' `SteppedInterpolationHandler`s.
    // rust: stepped: HashMap<i32, SteppedInterpolation>,
    // `LivingEntity.lerpHeadTo`: the head yaw and the ticks left to reach it.
    // rust: head_lerps: HashMap<i32, (f32, u32)>,
    // The happy ghast the player just got off, until the server's teleport
    // puts the player on top of it (`place_ghast_under`).
    // rust: pub(super) ghast_dismount: Option<u32>,
    // Whether the player is the first passenger of its vehicle, the one
    // `getControllingPassenger` names.
    // rust: pub(super) first_passenger: bool,
    // The player's place in its vehicle's `getPassengers`.
    // rust: pub(super) passenger_index: usize,
    // Item entities waiting for their item data: where they are and their
    // motion.
    // rust: pending_items: HashMap<i32, ([f64; 3], Vec3)>,
    // rust: health: (f32, i32, f32),
    // `LocalPlayer.flashOnSetHealth`: set by the first health the server
    // sends; from then on a drop starts the hurt animation.
    // rust: flash_on_set_health: bool,
    // rust: game_mode: i32,
    // rust: pub chat: Vec<(String, Instant)>,
    // Lines received since joining, for the control socket's events.
    // rust: pub chat_received: u64,
    // `ChatListener.delayedMessageQueue`: player chat held back by Chat
    // Delay, with the signature a deletion names it by and what the
    // narrator says once it shows.
    // rust: chat_queue: VecDeque<QueuedChat>,
    // `ClientPacketListener.messageSignatureCache`: the signatures packed
    // ones index, as the server's copy for this connection holds them.
    // rust: pub(super) signatures: horizon_protocol::secure_chat::SignatureCache,
    // `ChatListener.previousMessageTime`: when a message last showed, if one has.
    // rust: chat_previous: Option<Instant>,
    // `ClientPacketListener.nextChatIndex`: the global index the next chat packet must carry.
    // rust: next_chat_index: i32,
    // `serverEnforcesSecureChat`, from the login packet.
    // rust: enforces_secure_chat: bool,
    // rust: services_keys: Arc<std::sync::Mutex<ServicesKeys>>,
    // The `RemoteChatSession.Data` each player's list entry last carried (INITIALIZE_CHAT).
    // rust: chat_sessions: HashMap<u128, Option<(u128, i64, Vec<u8>, Vec<u8>)>>,
    // `PlayerInfo.messageValidator` of the players whose chat has been read.
    // rust: chat_validators: HashMap<u128, secure_chat::MessageValidator>,
    // `ConnectScreen.lastNarration`: when "Joining the world" was last said.
    // rust: joining_narrated: Option<Instant>,
    // The tree the chat colours, completes and parses with: the server's
    // (ClientboundCommandsPacket) once it has sent one, else the game's own,
    // plus the commands native mods own (`chat::chat_tree_for`). Rebuilt where
    // that base changes, not at each keystroke.
    // rust: pub chat_tree: horizon_client::command::Dispatcher,
    // Whether a `ClientboundCommandsPacket` has supplied the server's tree.
    // The local fallback is for UI completion only; vanilla signs command
    // arguments against an empty tree until the server sends one.
    // rust: pub(super) chat_tree_received: bool,
    // The chat session, the last-seen window and the signature cache.
    // rust: pub(super) secure_chat: super::remote_chat::SecureChat,
    // `ClientSuggestionProvider.customCompletionSuggestions`: the extra chat
    // completions this server sent (ClientboundCustomChatCompletionsPacket).
    // rust: custom_completions: std::collections::BTreeSet<String>,
    // rust: players: HashMap<u128, String>,
    // `ClientPacketListener.playerInfoMap` as player-list entries, and
    // which of them are listed.
    // rust: tab_players: HashMap<u128, horizon_client::tab_list::TabPlayer>,
    // Each listed profile's unpacked `textures` property.
    // rust: skin_textures: HashMap<u128, horizon_client::skins::Textures>,
    // Active skin and cape from the services profile when the server sent none.
    // rust: own_profile: OwnProfile,
    // The skin texture each profile's players show, once its download is ready.
    // rust: skins: HashMap<u128, String>,
    // rust: listed: std::collections::HashSet<u128>,
    // `ClientboundLoginPacket.onlineMode`: the player list shows heads.
    // rust: pub(super) online_mode: bool,
    // Player entities in the level: entity id to profile UUID.
    // rust: level_players: HashMap<i32, u128>,
    // The profile name each player entity was created with (`RemotePlayer.getGameProfile`): it outlives the
    // player-list entry, which servers remove to hide their NPCs from the list.
    // rust: level_player_names: HashMap<i32, String>,
    // The `textures` each player entity found in the player list first
    // (`AbstractClientPlayer.getPlayerInfo` keeps that `PlayerInfo`): its skin
    // outlives the entry, which NPC plugins remove a moment after spawning.
    // rust: level_player_textures: HashMap<i32, horizon_client::skins::Textures>,
    // Entities with shared flag 6 (`Entity.isCurrentlyGlowing` on a client); mobs keep
    // theirs in `Mob::glowing`.
    // rust: glowing: std::collections::HashSet<i32>,
    // The player's own shared flag 5 (`Entity.isInvisible`) as the server
    // last set it.
    // rust: pub(super) own_invisible: bool,
    // The player's own shared flag 0 (`Entity.isOnFire`) as the server last
    // set it: its fire (blaze fireballs, fire aspect, lightning) never
    // reaches the window's own `fire_ticks` otherwise.
    // rust: own_on_fire: bool,
    // `LivingEntity.DATA_ARROW_COUNT_ID` and `DATA_STINGER_COUNT_ID` of the
    // own player, as the server synced them.
    // rust: pub(super) own_arrows: i32,
    // rust: pub(super) own_stingers: i32,
    // `Player.DATA_SHOULDER_PARROT_LEFT` and `_RIGHT` of the own player.
    // rust: pub(super) own_shoulders: [Option<i32>; 2],
    // The local player's profile UUID (always in the level).
    // rust: profile: u128,
    // The local player's profile name: its score holder and team member.
    // rust: pub(super) profile_name: String,
    // `MultiPlayerGameMode.destroyBlockPos`, `.destroyProgress` and the face last sent: the block
    // the break targets, which outlives the break itself.
    // rust: destroying: Option<([i32; 3], u8, f32)>,
    // `MultiPlayerGameMode.destroyingItem`: the held item key the break began with.
    // rust: destroying_item: String,
    // `MultiPlayerGameMode.isDestroying`: a break is running. `destroying` keeps the target after
    // one ends (`destroyBlockPos` is written only when a break starts), so a dig resumed on the
    // same block and item sends no new START and the server keeps its clock (#4124).
    // rust: is_destroying: bool,
    // rust: destroy_delay: u32,
    // rust: input: horizon_client::interaction_input::InteractionInput,
    // Keys whose presses send a packet (swap hands, drop, a mount's
    // inventory): like the click queue, they wait for the tick's
    // `handleKeybinds` phase rather than going out between window events.
    // rust: pub(super) pending_keys: Vec<KeyCode>,
    // Whether the main and off hand still wait for the server's answer to
    // a SWAP_ITEM_WITH_OFFHAND (`remote_hand_slot_set`).
    // rust: swap_answer: [bool; 2],
    // rust: stop_mining: bool,
    // rust: placing: Option<([i32; 3], u64)>,
    // `CommonPlayerSpawnInfo.isFlat`: the level is a superflat one.
    // rust: pub(super) flat: bool,
    // rust: death_message: Option<horizon_client::text::Text>,
    // `LocalPlayer.showDeathScreen`: off with `immediate_respawn`.
    // rust: show_death_screen: bool,
    // `Player.isReducedDebugInfo`: the server's `reduced_debug_info` rule.
    // rust: pub(super) reduced_debug_info: bool,
    // `LocalPlayer.doLimitedCrafting`: whether limited crafting is enabled.
    // rust: pub(super) do_limited_crafting: bool,
    // rust: player_type: Option<Arc<MobType>>,
    // Inventory, off hand and armour as last synchronised, for creative-mode
    // slot updates (`creative_sync_stacks`).
    // rust: synced: Vec<Option<ItemStack>>,
    // rust: decode_errors: u32,
    // rust: clock: Option<i32>,
    // `ClientClockManager.ClientClockInstance`'s rate and partial tick for
    // the level's clock (its total is `world.day_time`), and
    // `lastTickGameTime`.
    // rust: clock_rate: f32,
    // rust: clock_partial: f32,
    // rust: clock_game_time: i64,
    // `ClientChunkCache.Storage`'s view centre (ClientboundSetChunkCacheCenterPacket).
    // rust: chunk_center: (i32, i32),
    // Received events a frame left for the next one, in order, and when
    // the oldest of them first waited (`poll_remote`).
    // rust: backlog: VecDeque<Received>,
    // rust: backlog_since: Option<Instant>,
    // `ClientboundTransferPacket`'s target: when the connection ends the
    // game connects here, the stored cookies carried over (`TransferState`).
    // rust: transfer: Option<String>,
    // `ClientCommonPacketListenerImpl.serverLinks`: the links "Server
    // Links..." in the pause menu lists (only `http`/`https` URIs kept).
    // rust: pub(super) server_links: Vec<horizon_protocol::packets::configuration::ServerLink>,
    // `ClientPacketListener.getDebugQueryHandler`: the F3+I query waiting
    // for the server's data.
    // rust: pub(super) debug_query: super::debug_keys::DebugQuery,
}

// The time a frame spends on chunk packets before it leaves the rest of
// the received events for the next frame. A batch of 25 to 60 columns
// (0.1 ms each on an M4 Pro) all in one frame was a 3 to 8 ms frame every
// time the player crossed a chunk border at 32 chunks; they decode on the
// chunk decoder's thread now, and the frame only inserts them.
CHUNK_PACKETS_PER_FRAME :: Duration::from_millis(1)
// Events that have waited this long are all handled in the next frame,
// whatever inserting their columns costs, up to a column still decoding:
// the packets after a slow machine's chunks don't wait on its frames.
BACKLOG_LIMIT :: Duration::from_millis(50)
// The open menu name of a server's horse inventory, then its chest's
// columns (the packet names no `MenuType`).
MOUNT_MENU :: "horizon:mount"

face_direction :: proc(face: [i32; 3]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match face {
    // rust: [0, -1, 0] => 0,
    // rust: [0, 1, 0] => 1,
    // rust: [0, 0, -1] => 2,
    // rust: [0, 0, 1] => 3,
    // rust: [-1, 0, 0] => 4,
    // rust: [1, 0, 0] => 5,
    // rust: _ => 1,
}
}

// A protocol number format as the scoreboard's.
number_format :: proc(f: ^play::NumberFormat) -> h {
    // Ported from Horizon
    return {}
}
//     use horizon_client::scoreboard::{NumberFormat, tag_to_json};
    // rust: match f {
    // rust: play::NumberFormat::Blank => NumberFormat::Blank,
    // rust: play::NumberFormat::Styled(t) => NumberFormat::Styled(tag_to_json(t)),
    // rust: play::NumberFormat::Fixed(t) => NumberFormat::Fixed(tag_to_json(t)),
}
}

    // rust: impl Game<'_> {
    // A `Holder<SoundEvent>` off the wire: an inline event's location, or
    // the name of a registered one.
    // rust: pub(super) fn remote_sound_name(
    // rust: &self,
    // rust: sound: &(i32, Option<(String, Option<f32>)>),
    // rust: ) -> Option<String> {
    // rust: match &sound.1 {
    // rust: Some((location, _)) => Some(location.clone()),
    // rust: None => self.remote.as_ref().and_then(|r| {
    // rust: r.builtin
    // rust: .get("minecraft:sound_event")?
    // rust: .name(sound.0)
    // rust: .map(str::to_owned)
    // rust: }),
}
}
    // rust: pub(super) fn remote_sound_entity_state(
    // rust: &mut self,
    // rust: id: i32,
    // rust: ) -> Option<horizon_client::sound_engine::SoundEntityState> {
    // rust: let r = self.remote.as_ref()?;
    // rust: let player = self.player.as_ref().map(|p| {
    // rust: (
    // rust: r.entity_id,
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: r.local_entity_silent,
    // rust: )
    // rust: });
        // The local player is not in mobs, so avoid a guaranteed index miss.
    // rust: if player.is_some_and(|p| p.0 == id) {
    // rust: return entity_sound_state(id, player, None, &r.entities, None);
}
    // rust: let mob = self.mob_index.get(&self.mobs, id as u32).map(|m| {
    // rust: horizon_client::sound_engine::SoundEntityState {
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: silent: m.silent,
    // rust: removed: m.removed,
}
    // rust: });
    // rust: let dragon = self
    // rust: .dragon
    // rust: .as_ref()
    // rust: .map(|d| (d.id as i32, [d.position.x, d.position.y, d.position.z]));
    // rust: let mut state = entity_sound_state(id, player, mob, &r.entities, dragon)?;
        // Mob states already use the live position. In particular,
        // level_entity would find the dragon's stale Mob before its Dragon.
    // rust: if mob.is_some() || dragon.is_some_and(|d| d.0 == id) {
    // rust: return Some(state);
}
        // Vehicles, projectiles and other simulated objects may have moved
        // since the last tracking packet.
    // rust: if let Some(position) = self
    // rust: .level_entity(id)
    // rust: .and_then(|target| self.target_position(target))
    // rust: {
    // rust: state.position = position;
}
    // rust: Some(state)
}
    // The hurt sound the hurt player's own client plays from
    // `ClientboundDamageEventPacket` (`LivingEntity.handleDamageEvent`):
    // `Player.getHurtSound` is the damage type's effects, with the codec's
    // `hurt` default when the type is unknown.
    // rust: pub(super) fn remote_hurt_sound(&self, source_type: i32) -> &'static str {
    // rust: match self.remote.as_ref() {
    // rust: Some(r) => hurt_sound_for(&r.registries, &self.health_resources.damage, source_type),
    // rust: None => horizon_client::health::hurt_sound("hurt"),
}
}
    // Leave the title for a server (ConnectScreen): an empty world fed by the connection.
    // rust: pub(super) fn connect_server(&mut self, address: &str, name: &str) -> Result<()> {
    // rust: self.connect_server_with_cookies(address, name, None)
}
    // `connect_server` carrying a transfer's stored server cookies
    // (`TransferState`); None on an ordinary join.
    // rust: pub(super) fn connect_server_with_cookies(
    // rust: &mut self,
    // rust: address: &str,
    // rust: name: &str,
    // rust: cookies: Option<horizon_client::net::Cookies>,
    // rust: ) -> Result<()> {
    // rust: self.connect_server_with_options(address, name, cookies, false)
}
    // `ConnectScreen.startConnecting`: keep LAN discovery's server kind through loading.
    // rust: pub(super) fn connect_server_with_options(
    // rust: &mut self,
    // rust: address: &str,
    // rust: name: &str,
    // rust: cookies: Option<horizon_client::net::Cookies>,
    // rust: lan: bool,
    // rust: ) -> Result<()> {
    // rust: super::world_loading::preload_server_loot(&self.options.resources);
    // rust: if self.defer_world_entry(super::PendingWorldEntry::Server {
    // rust: address: address.to_owned(),
    // rust: name: name.to_owned(),
    // rust: cookies: cookies.clone(),
    // rust: lan,
    // rust: })? {
    // rust: return Ok(());
}
    // rust: self.join_world_rest()?;
    // rust: if let Err(error) = self.join_server(address, name, None, cookies, lan) {
    // rust: log::warn!("Horizon: could not join server: {error}");
    // rust: if self.title.is_none() {
    // rust: self.title = Some(
    // rust: horizon_client::title::Title::new(
    // rust: std::env::current_dir()?.join("saves"),
    // rust: &self.options.resources,
    // rust: )
    // rust: .with_user(|| self.options.player_name()),
    // rust: );
}
    // rust: let skip = self.settings.file.bool("skipMultiplayerWarning");
    // rust: if let Some(title) = &mut self.title {
    // rust: title.skip_multiplayer_warning = skip;
    // rust: title.failed(error);
}
    // rust: self.capture(false);
}
    // rust: Ok(())
}
    // Join single player's integrated server through memory.
    // rust: pub(super) fn connect_local(
    // rust: &mut self,
    // rust: pipe: horizon_protocol::connection::Pipe,
    // rust: name: &str,
    // rust: ) -> Result<()> {
    // rust: self.join_server("local", name, Some(pipe), None, false)
}
    // rust: fn join_server(
    // rust: &mut self,
    // rust: address: &str,
    // rust: name: &str,
    // rust: local: Option<horizon_protocol::connection::Pipe>,
    // rust: cookies: Option<horizon_client::net::Cookies>,
    // rust: lan: bool,
    // rust: ) -> Result<()> {
    // rust: self.reset_tutorial();
    // rust: self.perf.world_opening();
        // A server's own biomes come over the connection; the last local
        // world's packed table must not name its ids. The window's own
        // server thread keeps the one it just set.
    // rust: if local.is_none() {
    // rust: self.world_biomes = None;
    // rust: self.world_biomes_base = None;
}
    // rust: let root = self.options.resources.clone();
    // rust: let builtin = builtin_registries(&root).ok_or("Resources are incomplete: registries.json is missing or invalid. Click \"Prepare again\" in the launcher (or run horizon-prepare), then try again.")?;
    // rust: let lang = Arc::new(horizon_client::net::load_language(&root));
        // Options.createInformation: what the server learns about this player,
        // sent again when one of those options changes.
    // rust: let info = self
    // rust: .settings
    // rust: .client_information(client_view_distance(self.settings.render_distance));
    // rust: if local.is_none() && !self.options.split_guest {
    // rust: horizon_client::crash::set_detail(
    // rust: "Server",
    // rust: horizon_client::net::shown_address(address),
    // rust: );
}
        // A signed-in account always plays under its own name; a splitscreen player signs in
        // with its own account when it picked one.
    // rust: let auth = self.auth();
    // rust: let name = auth.as_ref().map_or(name, |a| a.name.as_str());
    // rust: let user = auth.as_ref().map_or_else(
    // rust: || {
    // rust: (
    // rust: name.to_owned(),
    // rust: horizon_protocol::crypto::offline_uuid(name),
    // rust: )
    // rust: },
    // rust: |a| (a.name.clone(), a.uuid),
    // rust: );
    // rust: self.server_packs_connect(local.is_none().then_some(address), user);
    // rust: let session = match local {
    // rust: Some(pipe) => {
    // rust: Session::connect_local(pipe, name, info.clone(), lang.clone(), root.clone())
}
    // rust: None => {
    // rust: self.extras_connecting(address, name, lan);
    // rust: match cookies {
    // rust: Some(cookies) => Session::connect_transferred(
    // rust: address,
    // rust: name,
    // rust: auth.clone(),
    // rust: info.clone(),
    // rust: lang.clone(),
    // rust: cookies,
    // rust: root.clone(),
    // rust: ),
    // rust: None => {
    // rust: let connect = if lan {
    // rust: Session::connect_lan
    // rust: } else {
    // rust: Session::connect
}
    // rust: connect(
    // rust: address,
    // rust: name,
    // rust: auth.clone(),
    // rust: info.clone(),
    // rust: lang.clone(),
    // rust: root.clone(),
    // rust: )
}
}
}
}
    // rust: let player_type = super::perspective::player_type(&root);
    // rust: let mut streaming = Streaming::new(
    // rust: Arc::new(NoTerrain),
    // rust: self.worker_context(),
    // rust: self.res.threads(),
    // rust: );
    // rust: streaming.remote = true;
    // rust: streaming.radius = self.settings.render_distance;
    // rust: self.streaming = streaming;
    // rust: self.world = World::new(self.res.facts().air, 0);
    // rust: self.save = Arc::new(SaveDir::new(
    // rust: std::env::temp_dir().join("horizon-remote-unused"),
    // rust: horizon_client::save::LevelShape::OVERWORLD,
    // rust: ));
    // rust: self.inventory = vec![None; 36];
    // rust: self.armor = [None, None, None, None];
    // rust: self.craft_grid = vec![None; 9];
    // rust: self.craft_size = 2;
    // rust: self.player = None;
    // rust: self.spawn = None;
    // rust: self.mobs.clear();
    // rust: self.clear_remote_objects();
    // rust: self.clear_remote_projectiles();
    // rust: self.creatures.projectiles.clear();
    // rust: self.dropped.clear();
    // rust: self.particles.clear();
    // rust: self.pickups.clear();
    // rust: self.falling.clear();
    // rust: self.mining = None;
    // rust: self.container = None;
    // rust: self.carried = None;
    // rust: self.using = None;
    // rust: self.end_mod_use();
    // rust: self.clicks.miss_time = 0;
        // A new LocalPlayer has no effects: the server sends what it has
        // (ClientboundUpdateMobEffectPacket on placement).
    // rust: self.potions = Default::default();
    // rust: self.set_mode_id(0);
    // rust: self.experience = Experience {
    // rust: level: 0,
    // rust: progress: 0.0,
    // rust: total: 0,
}
        // The connected client never opens a server world (single player also
        // joins here), so load the registries its argument parsers and local
        // suggestions need before receiving the server's command tree.
    // rust: self.ui.registries = Default::default();
    // rust: self.build_registries();
    // rust: self.ui.registries.permission = 0;
    // rust: self.ui.chat.clear();
    // rust: self.screen = Screen::Playing;
    // rust: self.title = None;
    // rust: self.dim = Dim::Overworld;
    // rust: self.clear_lod();
    // rust: self.pending_uploads.clear();
    // rust: if let Some(r) = self.renderer.as_mut() {
    // rust: r.clear_sections(self.world.layout());
}
    // rust: self.apply_settings();
    // rust: self.clear_waypoints();
    // rust: self.boss_overlay.reset();
        // The chat's tree until the server sends its own, or forever when it
        // sends none: the game's own, plus the commands native mods own.
    // rust: let chat_tree = self.chat_tree_for(None);
        // Minecraft.services() has the keys wherever the game is played, single player's own
        // server included: its guests' chat keys are checked against them.
    // rust: let services_keys = Arc::new(std::sync::Mutex::new(ServicesKeys::Pending));
    // rust: let slot = services_keys.clone();
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("Services keys".into())
    // rust: .spawn(move || {
//                 use horizon_server_files::profiles;
    // rust: let keys = profiles::fetch_profile_key_keys(&profiles::discovery_url());
    // rust: *slot.lock().unwrap_or_else(|e| e.into_inner()) = match keys {
    // rust: Ok(keys) if !keys.is_empty() => ServicesKeys::Ready(keys),
    // rust: Ok(_) => ServicesKeys::Missing,
    // rust: Err(why) => {
    // rust: log::error!("Horizon: {why}");
    // rust: ServicesKeys::Missing
}
}
    // rust: });
    // rust: self.remote = Some(Remote {
    // rust: session,
    // rust: brand: "unknown".into(),
    // rust: features: vec!["minecraft:vanilla".into()],
    // rust: quiet_commands: false,
    // rust: mod_net: false,
    // rust: attachments: HashMap::new(),
    // rust: far_terrain: None,
    // rust: builtin,
    // rust: status: lang
    // rust: .get("connect.connecting")
    // rust: .cloned()
    // rust: .unwrap_or_else(|| "Connecting to the server...".into()),
    // rust: lang,
    // rust: registries: Arc::new(Dynamic::default()),
    // rust: enchantments: None,
    // rust: joined: false,
    // rust: reconfiguring: None,
    // rust: logged_in: false,
    // rust: entity_id: 0,
    // rust: local_entity_silent: false,
    // rust: camera: None,
    // rust: use_item: None,
    // rust: dimension: DimensionType::vanilla("minecraft:overworld"),
    // rust: level: "minecraft:overworld".into(),
    // rust: hashed_seed: 0,
    // rust: chunk_format: Arc::new(ChunkFormat::new(
    // rust: &DimensionType::vanilla("minecraft:overworld"),
    // rust: Vec::new(),
    // rust: 7,
    // rust: )),
    // rust: decoder: ChunkDecoder::new(),
    // rust: view_distance: self.settings.render_distance,
    // rust: simulation_distance: self.settings.simulation_distance,
    // rust: sequence: 0,
    // rust: position_sender: Default::default(),
    // rust: last_input: 0,
    // rust: was_sprinting: false,
    // rust: carried: std::cell::Cell::new(None),
    // rust: abilities: None,
    // rust: loaded_sent: false,
    // rust: heard_level: None,
    // rust: native_epoch: None,
    // rust: level_load: horizon_client::level_loading::LevelLoadTracker::new(0),
    // rust: sent_info: info,
    // rust: predictions: HashMap::new(),
    // rust: menu: None,
    // rust: craft_result: None,
    // rust: menu_title: None,
    // rust: state_id: 0,
    // rust: use_target: None,
    // rust: menu_extra: None,
    // rust: entities: HashMap::new(),
    // rust: lerps: HashMap::new(),
    // rust: cart_lerps: HashMap::new(),
    // rust: stepped: HashMap::new(),
    // rust: head_lerps: HashMap::new(),
    // rust: ghast_dismount: None,
    // rust: first_passenger: false,
    // rust: passenger_index: 0,
    // rust: pending_items: HashMap::new(),
    // rust: health: (20.0, 20, 5.0),
    // rust: flash_on_set_health: false,
    // rust: game_mode: 0,
    // rust: chat: Vec::new(),
    // rust: chat_received: 0,
    // rust: chat_queue: VecDeque::new(),
    // rust: signatures: Default::default(),
    // rust: chat_previous: None,
    // rust: next_chat_index: 0,
    // rust: enforces_secure_chat: false,
    // rust: services_keys,
    // rust: chat_sessions: HashMap::new(),
    // rust: chat_validators: HashMap::new(),
    // rust: joining_narrated: None,
    // rust: chat_tree,
    // rust: chat_tree_received: false,
    // rust: secure_chat: Default::default(),
    // rust: custom_completions: Default::default(),
    // rust: players: HashMap::new(),
    // rust: tab_players: HashMap::new(),
    // rust: skin_textures: HashMap::new(),
    // rust: own_profile: OwnProfile::Idle,
    // rust: skins: HashMap::new(),
    // rust: listed: Default::default(),
    // rust: online_mode: false,
    // rust: level_players: HashMap::new(),
    // rust: level_player_names: HashMap::new(),
    // rust: level_player_textures: HashMap::new(),
    // rust: glowing: Default::default(),
    // rust: own_invisible: false,
    // rust: own_on_fire: false,
    // rust: own_arrows: 0,
    // rust: own_stingers: 0,
    // rust: own_shoulders: [None; 2],
    // rust: profile: 0,
    // rust: profile_name: String::new(),
    // rust: destroying: None,
    // rust: destroying_item: String::new(),
    // rust: is_destroying: false,
    // rust: destroy_delay: 0,
    // rust: input: Default::default(),
    // rust: pending_keys: Vec::new(),
    // rust: swap_answer: [false; 2],
    // rust: stop_mining: false,
    // rust: placing: None,
    // rust: flat: false,
    // rust: death_message: None,
    // rust: show_death_screen: true,
    // rust: reduced_debug_info: false,
    // rust: do_limited_crafting: false,
    // rust: player_type,
    // rust: synced: vec![None; CREATIVE_SYNCED],
    // rust: decode_errors: 0,
    // rust: clock: None,
    // rust: clock_rate: 1.0,
    // rust: clock_partial: 0.0,
    // rust: clock_game_time: 0,
    // rust: chunk_center: (0, 0),
    // rust: backlog: VecDeque::new(),
    // rust: backlog_since: None,
    // rust: server_links: Vec::new(),
    // rust: debug_query: Default::default(),
    // rust: transfer: None,
    // rust: });
        // The level's TickRateManager follows the server's ticking packets.
    // rust: self.clock = horizon_client::clock::FixedStep::client();
        // The player's advancements and statistics are the server's.
    // rust: self.adv = Default::default();
    // rust: self.stats = Default::default();
    // rust: Ok(())
}

    // Disconnect and return to the multiplayer screen (DisconnectedScreen).
    // rust: pub(super) fn leave_server(&mut self, reason: Option<String>) -> Result<()> {
    // rust: if reason.is_none() && self.integrated.as_ref().is_some_and(|s| !s.stopped()) {
    // rust: return self.begin_closing_save(false);
}
    // rust: self.finish_perf();
    // rust: if reason.is_none() {
            // Leaving on purpose: nothing for auto-reconnect to retry.
    // rust: self.extras_left();
}
    // rust: self.clear_waypoints();
    // rust: self.hud_disconnected();
        // Vanilla's Hud also ticks on the title and connect screens, so the
        // action bar has run out by the next world; Horizon's ticks in one.
    // rust: self.titles.overlay_time = 0;
        // GameRenderer.resetData and narrator.clear (Minecraft.disconnect).
    // rust: self.item_activation.reset();
        // Kept mod block entity geometry belongs to the world leaving.
    // rust: self.kept_block_entities.get_mut().clear();
    // rust: self.clear_narrator();
        // updateLevelInEngines(null): every sound stops and the music manager
        // lets go of its track. Leaving a server comes straight here, not
        // through finish_close_world, so the biome's ambient loop would
        // otherwise play on over the title screen until the next world.
    // rust: self.ambience.clear(&mut self.audio);
    // rust: self.music.stop_playing(None, &mut self.audio);
    // rust: self.audio.stop_all();
        // A world is leaving either way: its icon attempt goes with it.
    // rust: self.world_icon = None;
        // Minecraft.disconnect: the client level goes.
    // rust: if let Some(old) = self.remote.as_mut().and_then(|r| r.heard_level.take()) {
    // rust: self.native_client_level_unload(&old);
}
    // rust: if self.remote.is_some() {
    // rust: self.native_client_disconnecting();
}
    // rust: if let Some(mut r) = self.remote.take() {
    // rust: r.session.disconnect();
}
    // rust: super::lan::forget_sync_data();
    // rust: self.gui.atlas.object_skins.clear();
    // rust: self.server_packs_disconnect();
    // rust: self.code_of_conduct = None;
    // rust: self.reset_tutorial();
    // rust: self.close_dialogs();
        // Gui.setScreen -> KeyMapping.releaseAll: the title or disconnect
        // screen releases every held key. Its release goes to that screen,
        // so a key kept here would still be down in the next world (#3246).
    // rust: self.keys.clear();
    // rust: self.left = false;
    // rust: self.right = false;
        // The shared world is closing: its invite code ends with it.
    // rust: self.friends_lan_closed();
        // Single player's server thread saves the world before the title shows.
    // rust: let single_player = match self.integrated.take() {
    // rust: Some(server) => {
    // rust: server.stop()?;
    // rust: true
}
    // rust: None => false,
}
        // A splitscreen player leaving says nothing of where P1 plays.
    // rust: if !self.options.split_guest {
    // rust: horizon_client::crash::clear_detail("Server");
}
    // rust: self.clock = Default::default();
    // rust: self.adv = Default::default();
    // rust: self.stats = Default::default();
    // rust: self.score.board = Default::default();
    // rust: self.streaming = Streaming::new(Arc::new(NoTerrain), self.worker_context(), 1);
    // rust: self.streaming.paused = true;
    // rust: self.world = World::new(self.res.facts().air, 0);
    // rust: self.player = None;
        // The vehicle went with the level: an id kept here would seat the
        // next login on an entity that is not there.
    // rust: self.riding = None;
        // Out of the server's bed: InBedChatScreen goes with the level.
    // rust: self.sleeping = None;
    // rust: self.sleep_timer = 0;
    // rust: self.clear_entities();
    // rust: self.score.board = Default::default();
    // rust: self.tab_list = Default::default();
    // rust: self.border = Default::default();
    // rust: self.screen = Screen::Playing;
    // rust: self.container = None;
    // rust: self.clear_lod();
    // rust: self.pending_uploads.clear();
    // rust: if let Some(r) = self.renderer.as_mut() {
    // rust: r.clear_sections(self.world.layout());
}
    // rust: let saves = std::env::current_dir()?.join("saves");
    // rust: let mut title = horizon_client::title::Title::new(saves.clone(), &self.options.resources)
    // rust: .with_user(|| self.options.player_name());
    // rust: title.last_server = self.settings.file.string("lastServer");
    // rust: title.skip_multiplayer_warning = self.settings.file.bool("skipMultiplayerWarning");
    // rust: if single_player && reason.is_none() {
    // rust: self.title = Some(title);
    // rust: self.capture(false);
    // rust: return Ok(());
}
    // rust: title.mode = horizon_client::title::Mode::Multiplayer(match reason {
    // rust: Some(reason) => horizon_client::multiplayer::Screen::Disconnected {
    // rust: reason,
    // rust: retry: None,
    // rust: lines: std::cell::Cell::new(1),
    // rust: },
    // rust: None => horizon_client::multiplayer::Screen::list(&saves),
    // rust: });
    // rust: self.title = Some(title);
    // rust: self.capture(false);
    // rust: Ok(())
}
    // `Hud.onDisconnected`, from `Minecraft.disconnect` and `clearClientLevel`
    // (a proxy's reconfiguration too), but the chat: joining clears it and a
    // reconfiguration keeps it (`ChatComponent.storeState`).
hud_disconnected :: proc(self: ^Self) {
}
    // rust: self.tab_list.reset();
    // rust: self.boss_overlay.reset();
    // rust: self.adv.toasts.clear();
    // rust: self.debug_charts.reset();
    // rust: self.titles.clear();
    // rust: self.titles.reset_times();
}

    // rust: pub(super) fn send(&self, packet: S) {
    // rust: if let Some(r) = &self.remote {
            // MultiPlayerGameMode's attack, interact, useItem, useItemOn, releaseUsingItem, dropItem and
            // piercingAttack run ensureHasSentCarriedItem before their packet: a slot the number keys
            // chose this tick goes out first. A miss, a dig's start or a swap waits for the next tick.
    // rust: if let S::Attack(_) | S::Interact(_) | S::UseItem(_) | S::UseItemOn(_) = &packet {
    // rust: self.remote_send_carried();
    // rust: } else if let S::PlayerAction(a) = &packet
    // rust: && matches!(a.action, 4 | 5 | 6 | 8)
    // rust: {
    // rust: self.remote_send_carried();
}
    // rust: r.session.send(packet);
}
}
next_sequence :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let r = self.remote.as_mut().expect("remote");
    // rust: r.sequence += 1;
    // rust: r.sequence
}
item_name :: proc(self: ^Self, id: i32) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let r = self.remote.as_ref().expect("remote");
    // rust: Arc::from(
    // rust: r.builtin
    // rust: .get("minecraft:item")
    // rust: .and_then(|i| i.name(id))
    // rust: .unwrap_or("minecraft:air"),
    // rust: )
}
    // The server's network id of a mob effect (`brewing::EFFECTS` id).
    // rust: pub(super) fn remote_effect_network_id(&self, effect: &str) -> Option<i32> {
    // rust: let r = self.remote.as_ref()?;
    // rust: r.builtin
    // rust: .get("minecraft:mob_effect")?
    // rust: .id(&format!("minecraft:{effect}"))
}
    // A mob effect's network id as the effect (`brewing::EFFECTS` id).
    // rust: pub(super) fn remote_effect_id(&self, effect: i32) -> Option<&'static str> {
    // rust: let r = self.remote.as_ref()?;
    // rust: let name = r.builtin.get("minecraft:mob_effect")?.name(effect)?;
    // rust: horizon_client::brewing::effect(name).map(|d| d.id)
}
    // ClientPacketListener.handleUpdateMobEffect for the player itself
    // (`LivingEntity.forceAddEffect`): the effect replaces any of its kind.
    // Other entities' effects are not shown.
remote_effect :: proc(self: ^Self, p: ^play::UpdateMobEffect) {
}
    // rust: if self.remote.as_ref().is_none_or(|r| r.entity_id != p.id) {
    // rust: return;
}
    // rust: let Some(id) = self.remote_effect_id(p.effect) else {
    // rust: return;
}
    // rust: let mut e = horizon_client::effects::EffectInstance::new(id, p.duration, p.amplifier);
    // rust: e.ambient = p.flags & 1 != 0;
    // rust: e.visible = p.flags & 2 != 0;
    // rust: let list = &mut self.potions.effects.list;
    // rust: match list.iter_mut().find(|x| x.id == id) {
            // forceAddEffect's copyBlendState: an updated effect keeps its fade.
    // rust: Some(existing) => *existing = e,
    // rust: None => {
                // ClientboundUpdateMobEffectPacket.shouldBlend (flag 8).
    // rust: let blend = p.flags & 8 != 0;
    // rust: if id == "darkness" {
    // rust: self.sculk.darkness = super::sculk::darkness_blend_added(&e, blend);
    // rust: } else if id == "nausea" {
    // rust: let (o_nausea, nausea) = screen_effects::nausea_blend_added(&e, blend);
    // rust: self.screen_fx.o_nausea = o_nausea;
    // rust: self.screen_fx.nausea = nausea;
}
    // rust: list.push(e);
}
}
}
item_id :: proc(self: ^Self, name: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let r = self.remote.as_ref().expect("remote");
    // rust: r.builtin
    // rust: .get("minecraft:item")
    // rust: .and_then(|i| i.id(name))
    // rust: .unwrap_or(0)
}
    // A stack from the server, decoded as the saved and command item NBT
    // are, so tooltips and models see every field.
    // rust: pub(super) fn to_stack(&self, s: &Option<Stack>) -> Option<ItemStack> {
    // rust: let r = self.remote.as_ref()?;
    // rust: let stack = s.as_ref()?;
    // rust: if !horizon_protocol::item::custom::permitted(stack, r.registries.custom_components)
    // rust: .unwrap_or(false)
    // rust: {
    // rust: log::warn!("Dropping a stack with unnegotiated custom components");
    // rust: return None;
}
    // rust: Some(horizon_client::item_sync::from_network(
    // rust: stack,
    // rust: &r.builtin,
    // rust: &r.registries,
    // rust: ))
}
    // A stack to the server (`SetCreativeModeSlot`): the same component
    // patch a Horizon server sends its clients, with the registries' ids, so
    // the server's echo doesn't hand back a bare item.
to_network :: proc(self: ^Self, s: ^Maybe(ItemStack)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let r = self.remote.as_ref()?;
        // A stack as the server sent it, only its count changed: its own
        // components go back, as a vanilla client keeps them.
    // rust: if let Some((stack, patch)) = s.as_ref().and_then(|s| Some((s, s.wire_patch()?))) {
    // rust: let mut out = Stack::new(self.item_id(&stack.item), stack.count as i32);
    // rust: let safe = r.registries.custom_components
    // rust: || horizon_protocol::item::custom::entries().next().is_none()
    // rust: || horizon_protocol::item::WirePatch::decode(&patch)
    // rust: .and_then(|(added, removed)| {
    // rust: let decoded = Stack {
    // rust: added,
    // rust: removed,
    // rust: ..Stack::new(out.item, out.count)
}
    // rust: horizon_protocol::item::custom::permitted(&decoded, false)
    // rust: })
    // rust: .unwrap_or(false);
    // rust: if safe {
    // rust: out.wire = horizon_protocol::item::WirePatch(Some(patch));
    // rust: return Some(out);
}
    // rust: log::warn!("Cannot send cached custom components to this peer");
}
    // rust: horizon_client::lan::guest::stack_to_network(
    // rust: |name| self.item_id(name),
            // Built-in first, as a hub's `SyncData::id` does: potions are one.
    // rust: |registry, name| {
    // rust: r.builtin
    // rust: .get(registry)
    // rust: .and_then(|ids| ids.id(name))
    // rust: .or_else(|| r.registries.id(registry, name))
    // rust: .or_else(|| {
    // rust: (r.registries.custom_components
    // rust: && registry == "minecraft:data_component_type")
    // rust: .then(|| horizon_protocol::item::custom::id(name))
    // rust: .flatten()
    // rust: })
    // rust: },
    // rust: s,
    // rust: )
}
    // `HashedStack.create` with the connection's registries (the client's
    // `decoratedHashOpsGenerator`).
hashed_stack :: proc(self: ^Self, s: ^Maybe(ItemStack)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let r = self.remote.as_ref()?;
    // rust: let names = SyncedNames {
    // rust: builtin: &r.builtin,
    // rust: dynamic: &r.registries,
}
    // rust: self.to_network(s).map(|s| Hashed::create(&s, &names))
}
    // A line in the connection's chat, with its styles, click and hover
    // events (ChatComponent.addMessage). The lines the Chat option hides
    // are dropped there (its `visibleMessageFilter`).
    // rust: pub(super) fn chat_line(
    // rust: &mut self,
    // rust: content: horizon_client::text::Text,
    // rust: source: horizon_client::chat::ChatSource,
    // rust: ) -> bool {
    // rust: self.signed_chat_line(content, source, None, ChatTrust::Secure)
}
    // `chat_line` of a player message, keeping its signature for a
    // deletion (`GuiMessage.signature`).
    // rust: fn signed_chat_line(
    // rust: &mut self,
    // rust: content: horizon_client::text::Text,
    // rust: source: horizon_client::chat::ChatSource,
    // rust: signature: Option<Signature>,
    // rust: trust: ChatTrust,
    // rust: ) -> bool {
    // rust: if !self.ui.chat.shows(source) {
    // rust: return false;
}
    // rust: let text = content.plain();
    // rust: let focused = self.screen == Screen::Chat;
    // rust: if source == horizon_client::chat::ChatSource::Player {
    // rust: self.ui.chat.add_signed(
    // rust: &self.gui.atlas,
    // rust: content,
    // rust: signature,
    // rust: trust.tag(),
    // rust: self.visual_ticks(),
    // rust: focused,
    // rust: );
    // rust: } else {
            // addServerSystemMessage and addClientSystemMessage both carry
            // GuiMessageTag.systemSinglePlayer: the grey bar at the line's left.
    // rust: let indicator = Some(horizon_client::chat::SYSTEM_INDICATOR);
    // rust: self.ui.chat.add(
    // rust: &self.gui.atlas,
    // rust: content,
    // rust: indicator,
    // rust: source,
    // rust: self.visual_ticks(),
    // rust: focused,
    // rust: );
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.chat.push((text, Instant::now()));
    // rust: r.chat_received += 1;
    // rust: if r.chat.len() > 100 {
    // rust: r.chat.remove(0);
}
}
    // rust: true
}

    // `ChatListener.handleMessage` for player and disguised chat: held in the
    // queue while Chat Delay is set, shown at once otherwise. `narration` is
    // the chat type's narration of it (`decorateNarration`).
handle_player_chat :: proc(self: ^Self, chat: QueuedChat) {
}
    // rust: if self.chat_delay_ms() > 0 {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.chat_queue.push_back(chat);
}
    // rust: } else {
    // rust: self.accept_chat(chat);
}
}

    // `ChatListener.handleChatMessageError`: a message that fails validation shows as the red,
    // italic `chat.validation_error` in its chat type (queued under Chat Delay as any
    // message). Its signature counts as processed but not shown, for the acknowledgement the
    // client sends the server. Vanilla also
    // skips a blocked sender and one restricted to friends (not kept here either) and
    // narrates the line.
    // rust: fn handle_chat_message_error(
    // rust: &mut self,
    // rust: chat_type: &play::ChatTypeBound,
    // rust: signature: Option<&Signature>,
    // rust: ) {
    // rust: if let Some(signature) = signature {
    // rust: self.mark_message_processed(signature, false);
}
    // rust: let error = serde_json::json!({
    // rust: "translate": "chat.validation_error",
    // rust: "color": "red",
    // rust: "italic": true,
    // rust: });
    // rust: let line = self.decorate_chat(chat_type, &error, Decoration::Chat);
        // saySystemChatQueued(boundChatType.decorateNarration(CHAT_VALIDATION_ERROR)).
    // rust: let narration = self
    // rust: .decorate_chat(chat_type, &error, Decoration::Narration)
    // rust: .plain();
    // rust: self.handle_player_chat(QueuedChat {
    // rust: line,
    // rust: signature: None,
    // rust: trust: ChatTrust::Error,
    // rust: narration,
    // rust: sender: 0,
    // rust: chat_type: chat_type.chat_type,
    // rust: });
}

    // `ChatTrustLevel.evaluate` of a player message, with
    // `ChatListener.evaluateTrustLevel`: the player's own message on their
    // own server is secure. `decorated` is the line shown, `unsigned` the
    // server's replacement for the signed content.
    // rust: fn chat_trust(
    // rust: &self,
    // rust: sender: u128,
    // rust: signed: bool,
    // rust: timestamp: i64,
    // rust: content: &str,
    // rust: unsigned: Option<&Tag>,
    // rust: decorated: &horizon_client::text::Text,
    // rust: ) -> ChatTrust {
//         use horizon_client::scoreboard::{comp_text, tag_to_json};
    // rust: if self.integrated.is_some() && self.remote.as_ref().is_some_and(|r| r.profile == sender) {
    // rust: return ChatTrust::Secure;
}
        // PlayerChatMessage.hasExpiredClient: MESSAGE_EXPIRES_AFTER_CLIENT is
        // the server's five minutes and two more.
    // rust: let now = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64);
    // rust: let expired = now
    // rust: > timestamp.saturating_add(
    // rust: horizon_protocol::secure_chat::EXPIRES_AFTER_SERVER + 2 * 60 * 1000,
    // rust: );
    // rust: if !signed || expired {
    // rust: return ChatTrust::NotSecure;
}
        // ChatTrustLevel.isModified: the signed content is not in the line, or
        // the replacement uses a font other than the default.
    // rust: let font_changed = unsigned.is_some_and(|tag| {
    // rust: comp_text(&tag_to_json(tag)).spans.iter().any(|span| {
    // rust: span.style
    // rust: .font
    // rust: .as_deref()
    // rust: .is_some_and(|font| font != "minecraft:default")
    // rust: })
    // rust: });
    // rust: if !decorated.plain().contains(content) || font_changed {
    // rust: ChatTrust::Modified(content.to_owned())
    // rust: } else {
    // rust: ChatTrust::Secure
}
}

    // `ClientPacketListener.handleDeleteChat`: the packed signature names a
    // message; one still held back by Chat Delay never shows
    // (`ChatListener.removeFromDelayedMessageQueue`), a shown one is
    // replaced (`ChatComponent.deleteMessage`). A signature the cache
    // doesn't hold is an invalid packet.
handle_delete_chat :: proc(self: ^Self, packed: ^(i32) {
}
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return Ok(());
}
    // rust: let Some(signature) = r.signatures.unpack(packed) else {
    // rust: let reason =
    // rust: horizon_client::text::Text::translate("multiplayer.disconnect.invalid_packet", &[]);
    // rust: return self.leave_server(Some(reason.plain()));
}
    // rust: r.secure_chat.ignore_pending(&signature);
    // rust: let queued = r.chat_queue.len();
    // rust: r.chat_queue
    // rust: .retain(|chat| chat.signature.as_ref() != Some(&signature));
    // rust: if r.chat_queue.len() == queued {
    // rust: let ticks = self.visual_ticks();
    // rust: self.ui
    // rust: .chat
    // rust: .delete_message(&self.gui.atlas, &signature, ticks);
}
    // rust: Ok(())
}

    // A message's `accept`: shown, it is narrated (`narrateChatMessage`) and
    // starts the Chat Delay wait again.
accept_chat :: proc(self: ^Self, chat: QueuedChat) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let signature = chat.signature;
    // rust: let shown = self.player_chat_line(chat);
    // rust: if let Some(signature) = &signature {
    // rust: self.mark_message_processed(signature, shown);
}
    // rust: if shown && let Some(r) = self.remote.as_mut() {
    // rust: r.chat_previous = Some(Instant::now());
}
    // rust: shown
}

    // `showMessageToPlayer`: the line joins the chat if Only Show Secure
    // Chat, mods and the Chat option let it through, and the narrator says
    // it (`sayChatQueued`).
player_chat_line :: proc(self: ^Self, chat: QueuedChat) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let QueuedChat {
    // rust: mut line,
    // rust: signature,
    // rust: trust,
    // rust: narration,
    // rust: sender,
    // rust: chat_type,
    // rust: } = chat;
        // ChatListener.showMessageToPlayer: Only Show Secure Chat drops what is not secure.
    // rust: if matches!(trust, ChatTrust::NotSecure) && self.settings.file.bool("onlyShowSecureChat") {
    // rust: return false;
}
        // handleChatMessageError says its line as system chat, and mods are not told of it.
    // rust: let error = matches!(trust, ChatTrust::Error);
    // rust: if !error && !self.chat_received(false, false, sender, Some(chat_type), &mut line) {
    // rust: return false;
}
    // rust: let source = horizon_client::chat::ChatSource::Player;
    // rust: let shown = self.signed_chat_line(line, source, signature, trust);
    // rust: if shown && error {
    // rust: self.say_system_chat_queued(&horizon_client::text::Text::literal(&narration));
    // rust: } else if shown {
    // rust: self.say_chat_queued(&narration);
}
    // rust: shown
}

    // NeoForge's `ClientChatReceivedEvent` (`ClientHooks.onClientChat`,
    // `onClientPlayerChat` and `onClientSystemChat`): mods may replace
    // `line` or cancel it. False when cancelled.
    // rust: fn chat_received(
    // rust: &mut self,
    // rust: system: bool,
    // rust: overlay: bool,
    // rust: sender: u128,
    // rust: chat_type: Option<i32>,
    // rust: line: &mut horizon_client::text::Text,
    // rust: ) -> bool {
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: return true;
}
    // rust: let registries = self.remote.as_ref().map(|r| Arc::clone(&r.registries));
    // rust: let name = chat_type
    // rust: .zip(registries.as_deref())
    // rust: .and_then(|(id, registries)| registries.name("minecraft:chat_type", id));
    // rust: let mut cancel = false;
    // rust: self.native_client_chat_received(system, overlay, sender, name, line, &mut cancel);
    // rust: !cancel
}

    // `ChatListener.messageDelay`: Chat Delay in milliseconds, as Java
    // truncates it.
chat_delay_ms :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (self.settings.chat_delay * 1000.0) as i64
}

    // `ChatListener.tick`: while paused the wait does not run down; with no
    // Chat Delay the queue flushes; otherwise the next message the chat takes
    // shows once the delay has passed since the last shown one.
    // rust: pub(super) fn tick_chat_queue(&mut self) {
    // rust: let delay = self.chat_delay_ms();
        // Minecraft.isPaused: a single-player pausing screen, not every pause menu.
    // rust: if self.pause {
    // rust: if delay > 0
    // rust: && let Some(r) = self.remote.as_mut()
    // rust: {
    // rust: r.chat_previous = r.chat_previous.map(|t| t + Duration::from_millis(50));
}
    // rust: return;
}
    // rust: if delay == 0 {
    // rust: if self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| !r.chat_queue.is_empty())
    // rust: {
    // rust: self.flush_chat_queue();
}
    // rust: return;
}
    // rust: let ready = self.remote.as_ref().is_some_and(|r| {
    // rust: r.chat_previous
    // rust: .is_none_or(|t| t.elapsed() >= Duration::from_millis(delay as u64))
    // rust: });
    // rust: if !ready {
    // rust: return;
}
        // A message the Chat option hides is dropped and the next one is tried,
        // until one shows.
    // rust: while let Some(chat) = self.remote.as_mut().and_then(|r| r.chat_queue.pop_front()) {
    // rust: if self.accept_chat(chat) {
    // rust: break;
}
}
}

    // `ChatListener.flushQueue`: every held-back message shows now, and the
    // delay starts over.
flush_chat_queue :: proc(self: ^Self) {
}
    // rust: let Some(queue) = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .map(|r| std::mem::take(&mut r.chat_queue))
    // rust: else {
    // rust: return;
}
    // rust: for chat in queue {
    // rust: self.accept_chat(chat);
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.chat_previous = None;
}
}

    // The minecarts the server sent, for the control socket's `status`
    // (their velocity is not tracked here).
    // rust: pub(super) fn remote_carts(&self) -> Option<Vec<serde_json::Value>> {
    // rust: let r = self.remote.as_ref()?;
    // rust: let mut carts: Vec<&Tracked> = r
    // rust: .entities
    // rust: .values()
    // rust: .filter(|t| t.kind.ends_with("minecart"))
    // rust: .collect();
    // rust: carts.sort_by(|a, b| {
    // rust: a.position
    // rust: .partial_cmp(&b.position)
    // rust: .unwrap_or(std::cmp::Ordering::Equal)
    // rust: });
    // rust: Some(
    // rust: carts
    // rust: .into_iter()
    // rust: .map(|t| serde_json::json!({"kind": t.kind, "position": t.position, "velocity": [0.0, 0.0, 0.0]}))
    // rust: .collect(),
    // rust: )
}

    // This player's account: a splitscreen player's own, else the game's (P1's).
    // rust: pub(super) fn auth(&self) -> Option<std::sync::Arc<horizon_client::auth::AuthSession>> {
    // rust: match self.options.split_guest {
    // rust: true => self.split_auth.clone(),
    // rust: false => horizon_client::auth::current(),
}
}
    // Connected to a server in online mode (its Login): each player needs its own account.
    // rust: pub(super) fn online_server(&self) -> bool {
    // rust: self.remote.as_ref().is_some_and(|r| r.online_mode)
}

    // `ClientSuggestionProvider.customCompletionSuggestions` of the server
    // connection (none without one).
    // rust: pub(super) fn remote_custom_completions(&self) -> std::collections::BTreeSet<String> {
    // rust: self.remote
    // rust: .as_ref()
    // rust: .map(|r| r.custom_completions.clone())
    // rust: .unwrap_or_default()
}
    // The names in the server's player list, sorted.
    // rust: pub(super) fn remote_online_names(&self) -> Option<Vec<String>> {
    // rust: let r = self.remote.as_ref()?;
    // rust: let mut names: Vec<String> = r.players.values().cloned().collect();
    // rust: names.sort();
    // rust: Some(names)
}
    // The open menu's window id (0: the inventory).
    // rust: pub(super) fn remote_menu_id(&self) -> i32 {
    // rust: self.remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.menu.as_ref())
    // rust: .map_or(0, |m| m.0)
}
    // The server's last `n` chat lines, newest first.
    // rust: pub(super) fn remote_chat(&self, n: usize) -> Option<Vec<String>> {
    // rust: let r = self.remote.as_ref()?;
    // rust: Some(r.chat.iter().rev().take(n).map(|l| l.0.clone()).collect())
}

    // Received events left for the next frame (`poll_remote`): until they
    // are handled, the terrain the server sent is not all there.
    // rust: pub(super) fn remote_backlog(&self) -> usize {
    // rust: self.remote.as_ref().map_or(0, |r| r.backlog.len())
}
    // A headless command oracle has a real connection but no movement tick.
    // Acknowledge loaded terrain without predicting or sending movement.
    // rust: pub(super) fn poll_stationary_client(&mut self) -> Result<()> {
    // rust: self.poll_remote()?;
    // rust: let loaded = self.player.as_ref().is_some_and(|p| {
    // rust: self.streaming.is_lit(
    // rust: (p.position.x.floor() as i32) >> 4,
    // rust: (p.position.z.floor() as i32) >> 4,
    // rust: )
    // rust: });
    // rust: if loaded && self.remote.as_ref().is_some_and(|r| !r.loaded_sent) {
    // rust: self.send(S::PlayerLoaded(Empty));
    // rust: let r = self.remote.as_mut().unwrap();
    // rust: r.loaded_sent = true;
    // rust: r.level_load.finish();
}
    // rust: Ok(())
}

    // Process what the network thread received (once per frame, like the
    // client's packet processor), in order. Chunk packets get
    // `CHUNK_PACKETS_PER_FRAME`: once a frame has spent it, the events from
    // the next chunk packet on wait for the next frame, unless they have
    // already waited `BACKLOG_LIMIT`. A chunk packet still decoding holds
    // back what follows it.
    // rust: pub(super) fn poll_remote(&mut self) -> Result<()> {
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return Ok(());
}
    // rust: let mut events = std::mem::take(&mut r.backlog);
        // Chunk packets start decoding now; the frame that reaches one in
        // order inserts its column.
    // rust: for event in r.session.poll() {
    // rust: events.push_back(match event {
    // rust: Event::Packet(p) if matches!(*p, C::LevelChunkWithLight(_)) => {
    // rust: match r.decoder.submit(r.chunk_format.clone(), p) {
    // rust: None => Received::Chunk(r.chunk_format.clone()),
    // rust: Some(p) => Received::Event(Event::Packet(p)),
}
}
    // rust: event => Received::Event(event),
    // rust: });
}
    // rust: let overdue = r
    // rust: .backlog_since
    // rust: .is_some_and(|since| since.elapsed() >= BACKLOG_LIMIT);
    // rust: let mut chunks = Duration::ZERO;
        // A run of ForgetLevelChunk (thousands when the server's view moves far: a
        // teleport at 32 chunks) is forgotten at once, before whatever follows it.
    // rust: let mut forgotten = horizon_client::fast_hash::FxHashSet::default();
    // rust: while let Some(item) = events.pop_front() {
    // rust: if let Received::Event(Event::Packet(packet)) = &item
    // rust: && let C::ForgetLevelChunk(p) = &**packet
    // rust: {
    // rust: self.native_client_packet(packet);
    // rust: forgotten.insert((p.pos[0], p.pos[1]));
    // rust: continue;
}
    // rust: self.forget_remote_columns(&mut forgotten);
    // rust: let chunk = matches!(item, Received::Chunk(_));
    // rust: if chunk && !overdue && chunks >= CHUNK_PACKETS_PER_FRAME {
    // rust: events.push_front(item);
    // rust: break;
}
    // rust: let started = chunk.then(Instant::now);
    // rust: let event = match item {
    // rust: Received::Event(event) => event,
    // rust: Received::Chunk(format) => {
                    // A column still decoding waits for the next frame, with
                    // what came after it, overdue or not.
    // rust: let Some(next) = self.remote.as_ref().map(|r| r.decoder.next()) else {
    // rust: break;
}
    // rust: let (packet, column) = match next {
    // rust: Next::Ready(decoded) => decoded,
    // rust: Next::Decoding => {
    // rust: events.push_front(Received::Chunk(format));
    // rust: break;
}
    // rust: Next::Lost => {
    // rust: log::warn!("Horizon: the chunk decoder stopped; a column is missing");
    // rust: continue;
}
}
    // rust: self.native_client_packet(&packet);
    // rust: if let C::LevelChunkWithLight(p) = *packet {
    // rust: self.remote_chunk(&p, Some((&format, column)));
}
    // rust: chunks += started.map_or(Duration::ZERO, |t| t.elapsed());
    // rust: continue;
}
}
    // rust: match event {
    // rust: Event::Status(s) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.status = s;
}
}
    // rust: Event::Joined {
    // rust: registries,
    // rust: name,
    // rust: uuid,
    // rust: } => {
    // rust: self.set_registries(registries);
    // rust: self.extras_joined();
                    // handleLogin: the level loading screen replaces any dialog.
    // rust: self.close_dialogs();
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.joined = true;
                        // handleLogin: startWaitingForNewLevel with Reason.OTHER.
    // rust: r.profile = uuid;
    // rust: r.profile_name = name.clone();
                        // LevelLoadingScreen's line: no player name.
    // rust: r.status = horizon_client::lang::get_or(
    // rust: "multiplayer.downloadingTerrain",
    // rust: "Loading terrain...",
    // rust: );
}
}
    // rust: Event::Features(features) => {
    // rust: if let Some(remote) = &mut self.remote {
    // rust: remote.features = features;
}
}
    // rust: Event::Brand(brand) => {
    // rust: if let Some(remote) = &mut self.remote {
    // rust: remote.brand = brand;
}
}
    // rust: Event::QuietCommands => {
    // rust: if let Some(remote) = &mut self.remote {
    // rust: remote.quiet_commands = true;
}
}
    // rust: Event::ModNet => {
    // rust: if let Some(remote) = &mut self.remote {
    // rust: remote.mod_net = true;
}
}
    // rust: Event::FarTerrain(offer) => {
    // rust: if let Some(remote) = &mut self.remote {
    // rust: remote.far_terrain = Some(offer);
}
}
    // rust: Event::Reconfiguring => {
                    // handleConfigurationStart: the held-back chat shows, then
                    // clearClientLevel opens ServerReconfigScreen over no level.
    // rust: self.flush_chat_queue();
    // rust: self.send_chat_acknowledgement();
    // rust: self.close_dialogs();
                    // The server configuring us now (a proxy's next one)
                    // offers its own far terrain, or none.
    // rust: if let Some(remote) = &mut self.remote {
    // rust: remote.far_terrain = None;
}
    // rust: self.clear_lod();
    // rust: if let Some(remote) = &self.remote {
    // rust: remote.session.reset_far_terrain();
}
    // rust: self.player = None;
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(false);
                    // clearClientLevel drops the client level now, so its
                    // unload comes before the configuration screen, not
                    // after the next login's load.
    // rust: if let Some(old) = self.remote.as_mut().and_then(|r| r.heard_level.take()) {
    // rust: self.native_client_level_unload(&old);
}
    // rust: let ticks = self.ticks;
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.reconfiguring = Some(ticks);
    // rust: r.chat_tree_received = false;
}
}
    // rust: Event::Reconfigured(registries) => {
                    // handleConfigurationStart → clearClientLevel, and the next
                    // ClientPacketListener starts with no players or scoreboard,
                    // no waypoints (its own ClientWaypointManager: a proxy's next
                    // server never untracks the last one's), and its new
                    // ClientSuggestionProvider with no custom chat completions.
                    // clearClientLevel clears the narrator.
    // rust: self.clear_narrator();
    // rust: self.hud_disconnected();
    // rust: self.score.board = Default::default();
    // rust: self.clear_waypoints();
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.attachments.clear();
    // rust: r.players.clear();
    // rust: r.tab_players.clear();
    // rust: r.listed.clear();
    // rust: r.signatures = Default::default();
    // rust: r.custom_completions.clear();
}
    // rust: self.ui.registries.custom_completions.clear();
    // rust: self.set_registries(registries);
}
                // handleTransfer: "Cannot transfer to server from
                // singleplayer" (no ServerData), so the world just closes.
    // rust: Event::Transfer { host, port } => {
    // rust: if let Some(r) = self.remote.as_mut()
    // rust: && r.session.address != "local"
    // rust: {
    // rust: r.transfer = Some(format!("{host}:{port}"));
}
}
    // rust: Event::PackPush(p) => self.handle_pack_push(p),
    // rust: Event::PackPop(id) => self.handle_pack_pop(id),
    // rust: Event::ServerLinks(links) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.server_links = super::server_links::trusted(links);
}
}
    // rust: Event::ShowDialog(dialog) => self.show_dialog(&dialog),
    // rust: Event::ClearDialog => self.clear_dialog(),
    // rust: Event::CodeOfConduct(text) => self.handle_code_of_conduct(text),
    // rust: Event::DecodeError(e) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.decode_errors += 1;
    // rust: if r.decode_errors <= 20 {
    // rust: log::warn!("Horizon: skipped undecodable packet {e}");
}
}
}
    // rust: Event::Disconnected {
    // rust: reason,
    // rust: key,
    // rust: from_server,
    // rust: } => {
    // rust: log::info!("Horizon: disconnected: {reason}");
                    // ClientboundTransferPacket left a target: connect there
                    // instead of showing the disconnect, the stored cookies
                    // carried over (ClientCommonPacketListenerImpl.
                    // handleTransfer → ConnectScreen.startConnecting).
    // rust: let transfer = self.remote.as_mut().and_then(|r| {
    // rust: r.transfer.take().map(|address| {
    // rust: (address, r.session.name.clone(), r.session.cookies.clone())
    // rust: })
    // rust: });
    // rust: if let Some((address, name, cookies)) = transfer {
    // rust: self.leave_server(None)?;
    // rust: self.connect_server_with_cookies(&address, &name, Some(cookies))?;
    // rust: return Ok(());
}
    // rust: let retry = self.reconnect_after(&reason, key.as_deref(), from_server);
    // rust: self.leave_server(Some(reason))?;
    // rust: self.offer_reconnect(retry);
    // rust: return Ok(());
}
    // rust: Event::Packet(packet) => self.handle_packet(*packet)?,
}
    // rust: chunks += started.map_or(Duration::ZERO, |t| t.elapsed());
    // rust: if self.remote.is_none() {
    // rust: break;
}
}
    // rust: if self.remote.is_some() {
    // rust: self.forget_remote_columns(&mut forgotten);
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.backlog_since = if events.is_empty() {
    // rust: None
    // rust: } else {
    // rust: Some(r.backlog_since.unwrap_or_else(Instant::now))
}
    // rust: r.backlog = events;
}
    // rust: self.send_suggestion_request();
    // rust: Ok(())
}
    // ClientSuggestionProvider.customSuggestion: the chat's completion
    // request for an `ask_server` node goes to the server.
send_suggestion_request :: proc(self: ^Self) {
}
    // rust: if self.remote.is_none() {
    // rust: return;
}
    // rust: let Some((id, command)) = self
    // rust: .ui
    // rust: .chat_screen
    // rust: .as_mut()
    // rust: .and_then(|s| s.take_request())
    // rust: .or_else(|| self.command_block_suggestion_request())
    // rust: else {
    // rust: return;
}
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: w.varint(id);
    // rust: w.string(&command);
    // rust: self.send(S::Unknown(
    // rust: horizon_protocol::ids::play::serverbound::COMMAND_SUGGESTION,
    // rust: w.data,
    // rust: ));
}
    // ClientboundCommandSuggestionsPacket: id, range start and length, then
    // each suggestion's text and optional tooltip.
handle_command_suggestions :: proc(self: ^Self, data: []u8) {
}
    // rust: let lang = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .map(|r| r.lang.clone())
    // rust: .unwrap_or_default();
    // rust: let mut r = horizon_protocol::buf::Reader::new(data);
    // rust: let decoded = (|| {
    // rust: let id = r.varint()?;
    // rust: let start = r.varint()?;
    // rust: let length = r.varint()?;
    // rust: let n = r.count(usize::MAX)?;
    // rust: let mut list = Vec::with_capacity(n.min(1000));
    // rust: for _ in 0..n {
    // rust: let text = r.string(32767)?;
    // rust: let tooltip = if r.bool()? {
    // rust: Some(plain(&r.nbt()?, &lang))
    // rust: } else {
    // rust: None
}
    // rust: list.push((text, tooltip));
}
    // rust: horizon_protocol::Result::Ok((id, start, length, list))
    // rust: })();
    // rust: if let Ok((id, start, length, list)) = decoded {
    // rust: let range = (start.max(0) as usize, length.max(0) as usize);
    // rust: self.chat_server_suggestions(id, range, list.clone());
    // rust: self.command_block_server_suggestions(id, range, list);
}
}
set_registries :: proc(self: ^Self, registries: ^Dynamic) {
}
        // The server's biomes the game lacks (a world data pack's) join the
        // game's table, from the data it sent: colours, meshing and the
        // chunk format all go through that table. The window's own server
        // thread set the world's table already.
    // rust: if self.integrated.is_none() {
    // rust: let table = registries
    // rust: .registries
    // rust: .get(BIOME_REGISTRY)
    // rust: .and_then(|list| client_biomes(self.res.biomes(), list))
    // rust: .map(Arc::new);
    // rust: if table.is_some() || self.world_biomes.is_some() {
    // rust: self.world_biomes_base = table.clone();
    // rust: self.world_biomes = table;
    // rust: let context = self.worker_context();
    // rust: self.streaming.reload_resources(&mut self.world, context);
}
}
    // rust: let biomes: Vec<u16> = registries
    // rust: .registries
    // rust: .get(BIOME_REGISTRY)
    // rust: .map(|list| {
    // rust: list.iter()
    // rust: .map(|(name, _)| world_biomes!(self).id(name))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let entries: Vec<(&str, serde_json::Value)> = registries
    // rust: .registries
    // rust: .get("minecraft:enchantment")
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|(name, data)| {
    // rust: Some((
    // rust: name.as_str(),
    // rust: horizon_client::scoreboard::tag_to_json(data.as_ref()?),
    // rust: ))
    // rust: })
    // rust: .collect();
    // rust: let enchantments = self
    // rust: .stations()
    // rust: .enchantments
    // rust: .with_entries(entries.iter().map(|(n, v)| (*n, v)))
    // rust: .map(Arc::new);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.enchantments = enchantments;
    // rust: let bits = ceil_log2(biomes.len());
    // rust: let column = r.chunk_format.layout();
    // rust: r.chunk_format =
    // rust: Arc::new(ChunkFormat::new(&r.dimension, biomes, bits).in_column(column));
    // rust: r.registries = registries;
}
}
    // Switch to a (possibly new) dimension: a fresh client level.
    // rust: fn enter_remote_dimension(
    // rust: &mut self,
    // rust: spawn: &play::SpawnInfo,
    // rust: keep_world: bool,
    // rust: reason: horizon_client::level_loading::Reason,
    // rust: ) {
        // The replacement player starts with its inventory menu, even if the
        // server switched levels without closing the previous container.
    // rust: self.remote_close_local();
    // rust: self.screen = Screen::Playing;
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let dimension = r.registries.dimension(spawn.dimension_type);
        // The server's dimension type gives the level's shape, and its
        // chunks the shape's column.
    // rust: let shape = horizon_client::chunk::LevelShape::new(
    // rust: dimension.min_y,
    // rust: dimension.height,
    // rust: dimension.logical_height,
    // rust: dimension.has_skylight,
    // rust: dimension.has_ceiling,
    // rust: )
    // rust: .unwrap_or_else(|_| super::Dim::from_id(&dimension.name).shape());
        // handleRespawn keeps the ClientLevel only for the same level key:
        // two levels sharing a dimension type are still two levels.
    // rust: let same = keep_world && r.heard_level.as_deref() == Some(spawn.dimension.as_str());
    // rust: r.chunk_format = Arc::new(
    // rust: r.chunk_format
    // rust: .with_dimension(&dimension)
    // rust: .in_column(shape.column()),
    // rust: );
    // rust: r.dimension = dimension;
    // rust: r.level = spawn.dimension.clone();
    // rust: r.hashed_seed = spawn.seed;
    // rust: r.game_mode = spawn.game_type;
    // rust: r.flat = spawn.flat;
    // rust: r.loaded_sent = false;
        // A replacement LevelLoadingScreen starts its bar from nothing (the
        // first one carries on from the server's start).
    // rust: if self.player.is_some() {
    // rust: self.loading_progress = 0.0;
}
        // startWaitingForNewLevel: `LevelLoadTracker.startClientLoad` and the
        // `LevelLoadingScreen`.
    // rust: r.level_load.start_client_load(client_millis(), reason);
        // A replacement LocalPlayer has a fresh sendPosition baseline.
    // rust: r.position_sender = Default::default();
    // rust: r.predictions.clear();
    // rust: self.set_mode_id(spawn.game_type);
    // rust: self.dim = Dim::from_id(&spawn.dimension);
    // rust: self.audio.set_world(&spawn.dimension);
        // ClientPacketListener.handleLogin / handleRespawn: the server's
        // Player.getLastDeathLocation, for the recovery compass.
    // rust: self.level.last_death = spawn
    // rust: .last_death
    // rust: .as_ref()
    // rust: .map(|d| (d.dimension.clone(), d.pos));
    // rust: if !same {
            // A new ClientLevel: Minecraft.setLevel stops every sound.
    // rust: self.stop_sounds_for_new_level();
    // rust: let mut streaming = Streaming::new(
    // rust: Arc::new(NoTerrain),
    // rust: self.worker_context(),
    // rust: self.res.threads(),
    // rust: );
    // rust: streaming.remote = true;
    // rust: streaming.radius = self.streaming.radius;
    // rust: self.streaming = streaming;
    // rust: let (time, day, weather) = (
    // rust: self.world.game_time,
    // rust: self.world.day_time,
    // rust: self.world.weather,
    // rust: );
    // rust: let old = std::mem::take(&mut self.world.chunks);
    // rust: let count = old.len();
    // rust: horizon_client::chunk::free_columns(old, count);
    // rust: self.world = World::new(self.res.facts().air, spawn.seed);
    // rust: self.world.shape = shape;
    // rust: self.world.game_time = time;
    // rust: self.world.day_time = day;
    // rust: self.world.weather = weather;
    // rust: self.mobs.clear();
    // rust: self.clear_remote_objects();
    // rust: self.clear_remote_projectiles();
    // rust: self.dropped.clear();
    // rust: self.particles.clear();
    // rust: self.pickups.clear();
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.entities.clear();
    // rust: r.lerps.clear();
    // rust: r.cart_lerps.clear();
    // rust: r.stepped.clear();
    // rust: r.head_lerps.clear();
    // rust: r.pending_items.clear();
                // The entity ids are the old world's; the new dimension's
                // player entities re-map to their profiles on AddEntity.
    // rust: r.level_players.clear();
    // rust: r.level_player_names.clear();
    // rust: r.level_player_textures.clear();
                // A new ClientLevel: a new chunk storage, centred on 0, 0.
    // rust: r.chunk_center = (0, 0);
}
    // rust: self.clear_lod();
    // rust: self.pending_uploads.clear();
    // rust: if let Some(renderer) = self.renderer.as_mut() {
    // rust: renderer.clear_sections(self.world.layout());
}
            // The new ClientLevel is told before setLevel drops the old one.
    // rust: let old = self.remote.as_mut().and_then(|r| {
    // rust: r.native_epoch = Some(super::native_lifecycle::fresh_epoch());
    // rust: r.heard_level.replace(spawn.dimension.clone())
    // rust: });
    // rust: self.native_client_level_load(&spawn.dimension);
    // rust: if let Some(old) = old {
    // rust: self.native_client_level_unload(&old);
}
}
    // rust: let has_sky = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_none_or(|r| r.dimension.has_skylight);
    // rust: self.streaming.sky_light = has_sky;
    // rust: self.streaming.nether_shading = self.dim == Dim::Nether;
        // The seed in SpawnInfo is already the hashed one the client's BiomeManager holds.
    // rust: self.streaming.biome_zoom = horizon_core::biome::BiomeZoom::new(spawn.seed);
    // rust: self.player = None;
        // handleLogin / handleRespawn: LocalPlayer.setPortalCooldown, so a
        // player who arrives standing in a portal gets no overlay from it.
    // rust: self.portals.player.cooldown = spawn.portal_cooldown;
    // rust: self.apply_settings();
}

    // `ClientChunkCache.Storage.inRange`: within the storage around the
    // view centre, `calculateStorageRange` (the server's radius, at least
    // two, plus three) chunks each way.
    // rust: pub(super) fn remote_chunk_in_range(&self, x: i32, z: i32) -> bool {
    // rust: self.remote.as_ref().is_none_or(|r| {
    // rust: let range = r.view_distance.max(2) + 3;
    // rust: (x - r.chunk_center.0).abs() <= range && (z - r.chunk_center.1).abs() <= range
    // rust: })
}
    // The columns a moved or resized storage no longer holds.
drop_remote_chunks_out_of_range :: proc(self: ^Self) {
}
    // rust: let mut gone: horizon_client::fast_hash::FxHashSet<(i32, i32)> = self
    // rust: .world
    // rust: .chunks
    // rust: .keys()
    // rust: .copied()
    // rust: .filter(|&(x, z)| !self.remote_chunk_in_range(x, z))
    // rust: .collect();
    // rust: self.forget_remote_columns(&mut gone);
}
    // Forgets the `gone` columns (and empties the set): their chunks (freed on a thread
    // of their own when there are many), their sections in the renderer and their block
    // entities, each store once for all of them. Far terrain keeps them as they were last
    // (`server_terrain`).
    // rust: fn forget_remote_columns(
    // rust: &mut self,
    // rust: gone: &mut horizon_client::fast_hash::FxHashSet<(i32, i32)>,
    // rust: ) {
    // rust: if gone.is_empty() {
    // rust: return;
}
    // rust: let freed = self.streaming.forget_columns(&mut self.world, gone);
    // rust: if let Some(lod) = &mut self.lod {
    // rust: for chunk in &freed {
    // rust: lod.observe(chunk.clone(), self.res.facts());
}
}
    // rust: if let Some(renderer) = self.renderer.as_mut() {
    // rust: renderer.remove_columns(gone.iter().copied());
}
    // rust: horizon_client::chunk::free_columns(freed, gone.len());
    // rust: self.world
    // rust: .block_entities
    // rust: .retain(|k, _| !gone.contains(&(k.0 >> 4, k.2 >> 4)));
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.attachments.retain(|holder, _| match *holder {
    // rust: Holder::Chunk([x, z]) => !gone.contains(&(x, z)),
    // rust: Holder::BlockEntity([x, _, z]) => !gone.contains(&(x >> 4, z >> 4)),
    // rust: _ => true,
    // rust: });
}
    // rust: gone.clear();
}
    // `handleBlockEntityData`: the block entity at `pos`, when it is of the
    // packet's type, loads the tag (`loadWithComponents`); an empty tag
    // changes nothing.
    // rust: pub(super) fn remote_block_entity_data(&mut self, pos: [i32; 3], kind: i32, tag: &Tag) {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(name) = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.builtin.get("minecraft:block_entity_type")?.name(kind))
    // rust: else {
    // rust: return;
}
        // A decorated pot is no block entity here: its tag is kept with the chunk.
    // rust: if name == "minecraft:decorated_pot" {
    // rust: if let Tag::Compound(fields) = tag
    // rust: && !fields.is_empty()
    // rust: {
    // rust: let mut full = fields.clone();
    // rust: full.insert("id".into(), Tag::String(name.into()));
    // rust: for (k, v) in ["x", "y", "z"].into_iter().zip(pos) {
    // rust: full.insert(k.into(), Tag::Int(v));
}
    // rust: super::spill::put_saved_entity(&mut self.world, pos, Tag::Compound(full));
                // The section is drawn again with the pot's sherds.
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let _ = self.world.set(pos[0], pos[1], pos[2], state);
}
    // rust: return;
}
    // rust: let Tag::Compound(fields) = tag else {
    // rust: return;
}
        // A mod block entity's type is named after its block (`mod_content`):
        // its update tag merges into what the client keeps of it (`handleUpdateTag`).
        // Nothing is drawn from it yet, so its section stays as it is.
    // rust: let block = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if let Some(BlockEntity::Mod(m)) = self.world.block_entities.get_mut(&key) {
    // rust: if *self.res.facts().get(block).name == *name {
    // rust: m.merge_update_tag(fields);
}
    // rust: return;
}
    // rust: let Some(entity) = self.world.block_entities.get(&key) else {
    // rust: return;
}
    // rust: if entity.id() != name || fields.is_empty() {
    // rust: return;
}
    // rust: let mut full = fields.clone();
    // rust: full.insert("id".into(), Tag::String(name.into()));
    // rust: for (k, v) in ["x", "y", "z"].into_iter().zip(pos) {
    // rust: full.insert(k.into(), Tag::Int(v));
}
    // rust: if let Some((_, mut loaded)) =
    // rust: horizon_client::save::decode_block_entity(&Tag::Compound(full))
    // rust: {
    // rust: keep_client_state(self.world.block_entities.get(&key), &mut loaded);
    // rust: let command_block = matches!(loaded, BlockEntity::CommandBlock(_));
    // rust: self.world.block_entities.insert(key, loaded);
    // rust: self.update_spawner_display(key);
            // The section is drawn again with what the block entity shows.
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let _ = self.world.set(pos[0], pos[1], pos[2], state);
    // rust: if command_block {
    // rust: self.command_block_data_arrived(key);
}
}
}
    // `handleAnimate`: a player wakes up, or an entity gets the critical
    // hit (`CRIT`) or magic critical hit (`ENCHANTED_HIT`) emitter.
remote_animate :: proc(self: ^Self, id: i32, action: u8) {
}
//         use horizon_client::particles::{ParticleOptions, ParticleType};
    // rust: let me = self.remote.as_ref().is_some_and(|r| r.entity_id == id);
    // rust: let body = if me {
    // rust: self.player.as_ref().map(|p| {
    // rust: let d = p.dimensions;
    // rust: (
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: f64::from(d.width),
    // rust: f64::from(d.height),
    // rust: )
    // rust: })
    // rust: } else {
    // rust: self.mob_index.get(&self.mobs, id as u32).map(|m| {
    // rust: (
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: m.kind.width,
    // rust: m.kind.height,
    // rust: )
    // rust: })
}
    // rust: let Some((feet, width, height)) = body else {
    // rust: return;
}
    // rust: let particle = match action {
            // Player.stopSleepInBed.
    // rust: 0 => {
    // rust: if me {
    // rust: self.sleeping = None;
    // rust: self.sleep_timer = 100;
}
    // rust: return;
}
    // rust: 1 => ParticleType::Crit,
    // rust: 2 => ParticleType::EnchantedHit,
    // rust: _ => return,
}
    // rust: self.particles
    // rust: .tracking_emitter(ParticleOptions::simple(particle), feet, width, height);
}
    // `handleServerData`: the server list entry of the server joined keeps
    // the icon the server sends (`ServerList.saveSingleServer`). Single
    // player has no entry.
remote_server_data :: proc(self: ^Self, icon: Maybe([]u8)) {
}
    // rust: let (Some(r), Some(png)) = (self.remote.as_ref(), icon) else {
    // rust: return;
}
    // rust: if self.integrated.is_some() {
    // rust: return;
}
    // rust: if let Ok(dir) = std::env::current_dir() {
    // rust: horizon_client::multiplayer::save_server_icon(
    // rust: &dir.join("saves"),
    // rust: &r.session.address,
    // rust: png,
    // rust: );
}
}
    // Keep the renderable block entities (chests, furnaces) in step with blocks.
    // `previous`: the block's state before, when it changed. A column sent again has
    // none, and keeps its block entities' synced attachments: the server does not send
    // them again (`remote_chunk` drops those of block entities the column lost).
    // rust: pub(super) fn sync_block_entity(
    // rust: &mut self,
    // rust: pos: (i32, i32, i32),
    // rust: previous: Option<BlockStateId>,
    // rust: state: BlockStateId,
    // rust: ) {
    // rust: let name = self.res.facts().get(state).name.clone();
        // LevelChunk.setBlockState: another block's block entity goes, even
        // one of the same type (a mod's blocks may share one).
    // rust: let other_block = previous.is_some_and(|p| self.res.facts().get(p).name != name);
        // A mod block's is the mod's own (`native_block_entity`), as on the server.
    // rust: match self.new_block_entity(&name) {
    // rust: Some(entity) => {
    // rust: let same = self.world.block_entities.get(&pos).is_some_and(|e| {
    // rust: e.id() == entity.id() && !(other_block && matches!(e, BlockEntity::Mod(_)))
    // rust: });
    // rust: if !same {
    // rust: if previous.is_some() {
    // rust: self.forget_block_entity_attachments(pos);
}
    // rust: self.world.block_entities.insert(pos, entity);
}
}
    // rust: None => {
    // rust: if previous.is_some() {
    // rust: self.forget_block_entity_attachments(pos);
}
    // rust: self.world.block_entities.remove(&pos);
}
}
}
    // The server's synced attachments of a block entity that goes with it.
forget_block_entity_attachments :: proc(self: ^Self) {
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.attachments.remove(&Holder::BlockEntity([x, y, z]));
}
}
    // ClientLevel.setServerVerifiedBlockState: a block the client predicted keeps its
    // predicted state until the server acknowledges the action; the server's state is
    // remembered for then.
server_block :: proc(self: ^Self, pos: [i32; 3], state: i32) {
}
    // rust: if let Some((_, known)) = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .and_then(|r| r.predictions.get_mut(&pos))
    // rust: {
    // rust: *known = state;
    // rust: return;
}
    // rust: self.set_block(pos, state);
}
    // BlockStatePredictionHandler.endPredictionsUpTo (ClientboundBlockChangedAckPacket): the
    // actions up to `sequence` are settled, so the blocks they predicted take the state the
    // server gave them (a break the server refused comes back).
end_predictions :: proc(self: ^Self, sequence: i32) {
}
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let settled: Vec<_> = r
    // rust: .predictions
    // rust: .iter()
    // rust: .filter(|(_, (s, _))| *s <= sequence)
    // rust: .map(|(&pos, &(_, state))| (pos, state))
    // rust: .collect();
    // rust: for (pos, state) in settled {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.predictions.remove(&pos);
}
    // rust: if self.world.block(pos[0], pos[1], pos[2]).0 as i32 != state {
    // rust: self.set_block(pos, state);
}
}
}
set_block :: proc(self: ^Self, pos: [i32; 3], state: i32) {
}
        // A state we don't have (a server with mods we lack) reads as air, as in its chunks.
    // rust: let state = state.max(0) as u32;
    // rust: let known = horizon_client::chunk::known_block_state(state);
    // rust: let state = BlockStateId(if known { state } else { 0 });
    // rust: let previous = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if self.world.loaded(pos[0], pos[2])
    // rust: && self.world.set(pos[0], pos[1], pos[2], state).is_ok()
    // rust: {
    // rust: self.sync_block_entity((pos[0], pos[1], pos[2]), Some(previous), state);
            // LevelChunk.setBlockState removes the block entity of a block
            // that changes: the moving piston the client's moveBlocks made
            // stops when the server places what it moved (#3002).
    // rust: let facts = self.res.facts();
    // rust: let moving = |s: BlockStateId| &*facts.get(s).name == "minecraft:moving_piston";
    // rust: if moving(previous) && !moving(state) {
    // rust: let at = horizon_core::position::BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.block_ticks.moving_pistons.retain(|(p, _)| *p != at);
    // rust: self.sync_moving_pistons();
}
}
        // A block we just placed: play its place sound (the server skips the placer).
    // rust: if let Some((target, _)) = self.remote.as_ref().and_then(|r| r.placing)
    // rust: && target == pos
    // rust: && !self.res.facts().is_air(state)
    // rust: {
    // rust: let s = self.res.facts().get(state).sounds.clone();
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.audio
    // rust: .play(&s.place, Some(at), (s.volume + 1.0) / 2.0, s.pitch * 0.8);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.placing = None;
}
}
}
    // `Entity.isVehicle` on a client: the entities a tracked entity rides.
    // rust: pub(super) fn remote_vehicle_ids(&self) -> impl Iterator<Item = u32> + '_ {
    // rust: self.remote
    // rust: .iter()
    // rust: .flat_map(|r| r.entities.values().filter_map(|t| t.vehicle))
}
    // The `SetPassengers` bookkeeping of the tracked entities.
    // rust: pub(super) fn remote_seat_passengers(&mut self, vehicle: u32, passengers: &[i32]) {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: seat_passengers(&mut r.entities, vehicle, passengers);
}
}
    // `recreateFromPacket`: yRot and xRot from the packet, the body and head
    // both at its head yaw (LivingEntity).
spawn_entity :: proc(self: ^Self, id: i32, kind: string, position: [f64; 3], rotation: [f32; 3]) {
}
    // rust: let [yaw, pitch, head] = rotation;
    // rust: let at = Vec3::new(position[0], position[1], position[2]);
    // rust: let mob_type = if kind == "minecraft:player" {
    // rust: self.remote.as_ref().and_then(|r| r.player_type.clone())
    // rust: } else {
    // rust: self.res.mob_types().get(kind).cloned()
}
    // rust: if kind == "minecraft:ender_dragon" {
    // rust: self.spawn_remote_dragon(id, position, yaw);
}
    // rust: if kind == "minecraft:experience_orb" {
            // Its value (ExperienceOrb.DATA_VALUE) follows in SetEntityData.
    // rust: self.orbs.retain(|o| o.id != id as u32);
    // rust: self.orbs.push(ExperienceOrb {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: id: id as u32,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity: Vec3::ZERO,
    // rust: value: 1,
    // rust: age: 0,
    // rust: on_ground: false,
    // rust: count: 1,
    // rust: ticks: 0,
    // rust: health: 5,
    // rust: });
}
    // rust: if let Some(t) = mob_type {
    // rust: let mut mob = Mob::new(id as u32, t, at, head);
    // rust: super::remote_mob_data::client_defaults(&mut mob);
    // rust: (mob.yaw, mob.previous_yaw) = (yaw, yaw);
    // rust: (mob.head_pitch, mob.previous_head_pitch) = (pitch, pitch);
    // rust: mob.persistent = true;
    // rust: self.mobs.retain(|m| m.id != id as u32);
    // rust: self.mobs.push(mob);
}
    // rust: if let Some(r) = self.remote.as_mut() {
            // A new entity has a new interpolation handler (a mob's or an
            // armor stand's), even under an id the server used before.
    // rust: r.stepped.remove(&id);
    // rust: if kind == "minecraft:item" {
    // rust: r.pending_items.insert(id, (position, Vec3::ZERO));
}
    // rust: r.entities.insert(
    // rust: id,
    // rust: Tracked {
    // rust: kind: kind.to_owned(),
    // rust: position,
    // rust: silent: false,
    // rust: vehicle: None,
    // rust: },
    // rust: );
}
}
    // A move packet for entity `id`: to the end of `path` (None: a
    // rotation alone), turned to `rotation` if it has one. `packet` says
    // whether a living entity more than 64 blocks away is put there at once
    // (its `snaps`).
    // rust: fn move_entity(
    // rust: &mut self,
    // rust: id: i32,
    // rust: path: Option<Path>,
    // rust: rotation: Option<(f32, f32)>,
    // rust: on_ground: bool,
    // rust: packet: MovePacket,
    // rust: ) {
        // The dragon is drawn from its own state (game/dragon.rs), which
        // tick_remote_dragon eases to the server's moves through `lerps`. Its
        // copy in the mob list draws nothing: given the move, it kept the
        // dragon where it spawned (#2083).
    // rust: let dragon = self.dragon.as_ref().is_some_and(|d| d.id as i32 == id);
    // rust: let driven = self.driven_mount().is_some_and(|m| m.id as i32 == id);
    // rust: let mob = self
    // rust: .mob_index
    // rust: .get_mut(&mut self.mobs, id as u32)
    // rust: .filter(|_| !dragon);
    // rust: let tracked = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.entities.get(&id))
    // rust: .map(|t| t.position);
    // rust: let position = path
    // rust: .as_ref()
    // rust: .map(Path::end)
    // rust: .or(tracked)
    // rust: .or_else(|| {
    // rust: mob.as_ref()
    // rust: .map(|m| [m.position.x, m.position.y, m.position.z])
    // rust: })
    // rust: .unwrap_or([0.0; 3]);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: if let Some(t) = r.entities.get_mut(&id) {
    // rust: t.position = position;
}
    // rust: if driven {
                // handleMoveEntity, handleEntityPositionSync: the mount this
                // client moves (isLocalInstanceAuthoritative) keeps its own
                // position, and no steps pile up for after the ride.
    // rust: r.stepped.remove(&id);
    // rust: return;
}
    // rust: if let Some(m) = mob {
                // Shulker.createInterpolationHandler is NO_OP, so a move packet
                // is setPos at once. The 6-tick slide starts from the block
                // the shulker occupied before this packet.
    // rust: if m.species() == horizon_client::mobs::Species::Shulker {
    // rust: r.stepped.remove(&id);
    // rust: if path.is_some() {
    // rust: horizon_client::mobs::shulker::client_set_pos(
    // rust: m,
    // rust: position[0],
    // rust: position[1],
    // rust: position[2],
    // rust: );
}
    // rust: if let Some((yaw, pitch)) = rotation {
    // rust: m.yaw += wrap_degrees(yaw - m.yaw);
    // rust: m.head_pitch = (pitch % 360.0).clamp(-90.0, 90.0);
}
    // rust: m.on_ground = on_ground;
    // rust: return;
}
                // A living entity: LivingEntity.createInterpolationHandler's
                // SteppedInterpolationHandler, over its type's update interval.
    // rust: let entity = PosRot {
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: yaw: m.yaw,
    // rust: pitch: m.head_pitch,
}
    // rust: let handler = r.stepped.entry(id).or_insert_with(|| {
    // rust: let interval = horizon_client::lan::tracking::settings(&m.kind.id).1;
    // rust: SteppedInterpolation::new(interval as i32)
    // rust: });
    // rust: if let Some(at) = stepped_move(handler, packet, entity, position, path, rotation) {
                    // snapTo: setOldPosAndRot too.
    // rust: place_interpolated(m, at);
    // rust: m.previous = m.position;
    // rust: m.previous_yaw = m.yaw;
    // rust: m.previous_head_pitch = m.head_pitch;
}
    // rust: m.on_ground = on_ground;
    // rust: return;
}
            // An armor stand is a living entity too: the same handler, over
            // its type's update interval, stepped in `tick_remote_entities`.
    // rust: if let Some(a) = self.armor_stands.iter_mut().find(|a| a.id == id as u32) {
    // rust: let entity = PosRot {
    // rust: position: [a.position.x, a.position.y, a.position.z],
    // rust: yaw: a.yaw,
    // rust: pitch: 0.0,
}
    // rust: let handler = r.stepped.entry(id).or_insert_with(|| {
    // rust: let interval =
    // rust: horizon_client::lan::tracking::settings("minecraft:armor_stand").1;
    // rust: SteppedInterpolation::new(interval as i32)
    // rust: });
    // rust: if let Some(at) = stepped_move(handler, packet, entity, position, path, rotation) {
    // rust: a.snap(
    // rust: Vec3::new(at.position[0], at.position[1], at.position[2]),
    // rust: at.yaw,
    // rust: );
}
    // rust: a.on_ground = on_ground;
    // rust: return;
}
            // Interaction extends Entity and keeps its NO_OP interpolation
            // handler: the server's position replaces its own at once.
    // rust: if let Some(i) = self.interactions.get_mut(&id) {
    // rust: if path.is_some() {
    // rust: i.position = Vec3::new(position[0], position[1], position[2]);
}
    // rust: return;
}
            // Projectiles keep Entity's NO_OP InterpolationHandler too: the
            // server's position replaces theirs at once and their own tick
            // flies them on (`tick_remote_projectiles`). Eased towards it
            // instead, they only moved when an update came, every 10 to 20
            // ticks.
    // rust: if let Some(p) = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter_mut()
    // rust: .find(|p| p.id == id as u32)
    // rust: {
    // rust: if path.is_some() {
    // rust: p.position = Vec3::new(position[0], position[1], position[2]);
}
    // rust: if let Some((yaw, pitch)) = rotation {
    // rust: p.yaw = yaw;
    // rust: p.pitch = pitch;
}
    // rust: return;
}
    // rust: if path.is_some()
    // rust: && (self.potions.move_remote_thrown(
    // rust: id as u32,
    // rust: Vec3::new(position[0], position[1], position[2]),
    // rust: ) || self.end.move_remote_eye(id as u32, position))
    // rust: {
    // rust: return;
}
            // A fishing hook keeps a LinearInterpolationHandler: eased towards the
            // update over three ticks, on top of its own movement (`tick_remote_hooks`).
    // rust: if path.is_some() {
    // rust: if let Some(h) = self.hook.as_mut().filter(|h| h.id() == id as u32) {
    // rust: h.move_to(position, on_ground);
    // rust: return;
}
    // rust: if let Some(h) = self.remote_hooks.iter_mut().find(|h| h.id() == id as u32) {
    // rust: h.move_to(position, on_ground);
    // rust: return;
}
}
            // A thrown trident is an arrow: placed at once, flown on by its tick.
    // rust: if let Some(t) = self.tridents.iter_mut().find(|t| t.id == id as u32) {
    // rust: if path.is_some() {
    // rust: t.position = Vec3::new(position[0], position[1], position[2]);
}
    // rust: if let Some((yaw, pitch)) = rotation {
    // rust: t.yaw = yaw;
    // rust: t.pitch = pitch;
}
    // rust: return;
}
            // So does a firework rocket: its own tick flies it on.
    // rust: if path.is_some()
    // rust: && let Some(f) = self.rockets.iter_mut().find(|f| f.id == id as u32)
    // rust: {
    // rust: f.position = Vec3::new(position[0], position[1], position[2]);
    // rust: return;
}
            // A dragon fireball keeps Entity's NO_OP InterpolationHandler too:
            // the server's position replaces its own at once.
    // rust: if let Some(b) = self.dragon_fireballs.iter_mut().find(|b| b.id == id as u32) {
    // rust: if path.is_some() {
    // rust: b.position = Vec3::new(position[0], position[1], position[2]);
}
    // rust: return;
}
    // rust: if let Some(p) = r.pending_items.get_mut(&id) {
    // rust: p.0 = position;
}
            // ItemEntity, FallingBlockEntity and PrimedTnt keep Entity's
            // NO_OP InterpolationHandler: moveOrInterpolateTo puts them there
            // at once, and their own tick moves them on between the server's
            // updates (`tick_remote_entities`, `tick_remote_projectiles`).
    // rust: let at = Vec3::new(position[0], position[1], position[2]);
    // rust: if let Some(d) = self.dropped.iter_mut().find(|d| d.id == id as u32) {
    // rust: d.position = at;
    // rust: d.on_ground = on_ground;
    // rust: return;
}
    // rust: if let Some(f) = self.falling.iter_mut().find(|f| f.id == id as u32) {
    // rust: f.position = at;
    // rust: return;
}
    // rust: if let Some(t) = self.tnts.iter_mut().find(|t| t.id == id as u32) {
    // rust: t.position = at;
    // rust: t.on_ground = on_ground;
    // rust: return;
}
            // ExperienceOrb.createInterpolationHandler is a
            // LinearInterpolationHandler: the correction is spread over 3
            // ticks (`tick_remote_entities`), while `ExperienceOrb.tick` keeps
            // moving it.
    // rust: if let Some(o) = self.orbs.iter_mut().find(|o| o.id == id as u32) {
    // rust: o.on_ground = on_ground;
    // rust: r.lerps.insert(
    // rust: id,
    // rust: Lerp {
    // rust: target: position,
    // rust: rotation: None,
    // rust: steps: 3,
    // rust: },
    // rust: );
    // rust: return;
}
    // rust: if r.cart_lerps.contains_key(&id) {
                // A minecart on NewMinecartBehavior keeps Entity's NO_OP
                // InterpolationHandler: a teleport puts it there at once.
    // rust: if let Some(c) = self.carts.iter_mut().find(|c| c.id == id as u32) {
    // rust: if path.is_some() {
    // rust: c.position = at;
}
    // rust: if let Some((yaw, pitch)) = rotation {
    // rust: c.yaw = yaw;
    // rust: c.pitch = pitch;
}
}
    // rust: } else {
                // AbstractInterpolationHandler.interpolateTo: without a
                // rotation, the one it was heading for.
    // rust: let rotation = rotation.or_else(|| r.lerps.get(&id).and_then(|l| l.rotation));
    // rust: r.lerps.insert(
    // rust: id,
    // rust: Lerp {
    // rust: target: position,
    // rust: rotation,
    // rust: steps: 3,
    // rust: },
    // rust: );
}
}
    // rust: self.turn_remote_object(id, rotation.map(|(yaw, _)| yaw), on_ground);
    // rust: self.move_remote_text_display(id, position, rotation);
    // rust: self.turn_remote_projectile(id, rotation);
}
remove_entity :: proc(self: ^Self, id: i32) {
}
    // rust: self.audio.remove_sound_entity(id as u32);
        // Entity.setRemoved detaches every passenger, even when no empty
        // SetPassengers packet preceded the vehicle's removal. Otherwise
        // mobs and other players keep their passenger pose after it is gone.
    // rust: self.remote_set_passengers(id, &[]);
    // rust: self.mobs.retain(|m| m.id != id as u32);
    // rust: self.orbs.retain(|o| o.id != id as u32);
    // rust: self.dropped.retain(|d| d.id != id as u32);
        // Before the crystals go: the dragon's beam index follows them.
    // rust: self.remove_remote_dragon(id);
    // rust: self.remove_remote_object(id as u32);
    // rust: self.remove_remote_projectile(id as u32);
    // rust: self.persist.uuids.remove(&(id as u32));
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.glowing.remove(&id);
    // rust: r.entities.remove(&id);
    // rust: r.lerps.remove(&id);
    // rust: r.cart_lerps.remove(&id);
    // rust: r.stepped.remove(&id);
    // rust: r.head_lerps.remove(&id);
    // rust: r.pending_items.remove(&id);
}
}
    // Map a menu slot to Horizon's inventory screen slot ids.
    // rust: pub(super) fn menu_slot(menu: &str, slot: i32) -> Option<usize> {
    // rust: let s = usize::try_from(slot).ok()?;
        // A container of `n` slots, then the inventory and the hotbar.
    // rust: let slots = |n: usize| -> Option<usize> {
    // rust: match s {
    // rust: _ if s < n => Some(300 + s),
    // rust: _ if s < n + 27 => Some(9 + s - n),
    // rust: _ if s < n + 36 => Some(s - n - 27),
    // rust: _ => None,
}
}
    // rust: let rows = |n: usize| slots(n * 9);
    // rust: match menu {
    // rust: "inventory" => match s {
    // rust: 0 => Some(200),
    // rust: 1..=4 => Some(100 + s - 1),
    // rust: 5..=8 => Some(500 + s - 5),
    // rust: 9..=35 => Some(s),
    // rust: 36..=44 => Some(s - 36),
                // InventoryMenu.SHIELD_SLOT: the off hand.
    // rust: 45 => Some(504),
    // rust: _ => None,
    // rust: },
    // rust: "minecraft:crafting" => match s {
    // rust: 0 => Some(200),
    // rust: 1..=9 => Some(100 + s - 1),
    // rust: 10..=36 => Some(9 + s - 10),
    // rust: 37..=45 => Some(s - 37),
    // rust: _ => None,
    // rust: },
    // rust: "minecraft:merchant" => match s {
    // rust: 0 | 1 => Some(super::stations::INPUT + s),
    // rust: 2 => Some(super::stations::RESULT),
    // rust: 3..=29 => Some(9 + s - 3),
    // rust: 30..=38 => Some(s - 30),
    // rust: _ => None,
    // rust: },
    // rust: "minecraft:furnace" | "minecraft:blast_furnace" | "minecraft:smoker" => match s {
    // rust: 0..=2 => Some(300 + s),
    // rust: 3..=29 => Some(9 + s - 3),
    // rust: 30..=38 => Some(s - 30),
    // rust: _ => None,
    // rust: },
    // rust: "minecraft:generic_9x1" => rows(1),
    // rust: "minecraft:generic_9x2" => rows(2),
    // rust: "minecraft:generic_9x3" | "minecraft:shulker_box" => rows(3),
    // rust: "minecraft:generic_9x4" => rows(4),
    // rust: "minecraft:generic_9x5" => rows(5),
    // rust: "minecraft:generic_9x6" => rows(6),
            // HopperMenu; DispenserMenu (dispensers and droppers).
    // rust: "minecraft:hopper" => slots(5),
    // rust: "minecraft:generic_3x3" => slots(9),
    // rust: "minecraft:brewing_stand" => slots(5),
            // CrafterMenu: the grid, the inventory, then the result (the
            // client's own).
    // rust: "minecraft:crafter_3x3" => slots(9),
            // HorseInventoryMenu: the saddle, the body armour, the chest,
            // then the inventory.
    // rust: m if m.starts_with(MOUNT_MENU) => {
    // rust: let n = m[MOUNT_MENU.len()..].parse::<usize>().ok()? * 3;
    // rust: match s {
    // rust: 0 => Some(super::mount_menu::SADDLE),
    // rust: 1 => Some(super::mount_menu::ARMOR),
    // rust: _ if s < 2 + n => Some(super::mount_menu::CHEST + s - 2),
    // rust: _ if s < 2 + n + 27 => Some(9 + s - 2 - n),
    // rust: _ if s < 2 + n + 36 => Some(s - 2 - n - 27),
    // rust: _ => None,
}
}
            // A content mod's menu type: its container, then the inventory.
            // A workstation: its inputs, its result, then the inventory.
    // rust: m => {
    // rust: if let Some(t) = horizon_client::containers::mod_menu_type(m) {
    // rust: return slots(t.slots);
}
    // rust: let kind = Self::remote_station_kind(m)?;
    // rust: let inputs = kind.inputs();
    // rust: let own = inputs + usize::from(kind.has_result());
    // rust: match s {
    // rust: _ if s < inputs => Some(super::stations::INPUT + s),
    // rust: _ if s < own => Some(super::stations::RESULT),
    // rust: _ if s < own + 27 => Some(9 + s - own),
    // rust: _ if s < own + 36 => Some(s - own - 27),
    // rust: _ => None,
}
}
}
}
    // Find a game slot in the menu's complete, contiguous slot mapping.
    // rust: pub(super) fn menu_slot_index(menu: &str, internal: usize) -> Option<usize> {
    // rust: (0..)
    // rust: .map_while(|slot| Self::menu_slot(menu, slot))
    // rust: .position(|slot| slot == internal)
}
    // The workstation screen of a menu type a server opens.
    // rust: pub(super) fn remote_station_kind(menu: &str) -> Option<super::stations::Kind> {
//         use super::stations::Kind;
    // rust: Some(match menu {
    // rust: "minecraft:loom" => Kind::Loom,
    // rust: "minecraft:stonecutter" => Kind::Stonecutter,
    // rust: "minecraft:grindstone" => Kind::Grindstone,
    // rust: "minecraft:anvil" => Kind::Anvil,
    // rust: "minecraft:smithing" => Kind::Smithing,
    // rust: "minecraft:enchantment" => Kind::Enchanting,
    // rust: "minecraft:beacon" => Kind::Beacon,
    // rust: "minecraft:cartography_table" => Kind::Cartography,
    // rust: _ => return None,
    // rust: })
}
open_menu_name :: proc(self: ^Self, container: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self.remote.as_ref().and_then(|r| r.menu.as_ref()) {
    // rust: Some((id, name)) if *id == container && container != 0 => name.clone(),
    // rust: _ => "inventory".into(),
}
}
set_menu_slot :: proc(self: ^Self, container: i32, slot: i32, item: Maybe(ItemStack)) {
}
    // rust: let menu = self.open_menu_name(container);
    // rust: if menu == "minecraft:lectern" {
    // rust: if slot == 0 {
    // rust: self.remote_lectern_book(item);
}
    // rust: return;
}
    // rust: if container != 0 && menu == "inventory" {
    // rust: return;
}
    // rust: let Some(internal) = Self::menu_slot(&menu, slot) else {
    // rust: return;
}
    // rust: if internal == 200 {
            // ClientboundContainerSetSlotPacket for the open menu's slot 0: the
            // server's result of its own recipes (a world's data packs' too).
    // rust: if container == self.remote_menu().0
    // rust: && let Some(r) = self.remote.as_mut()
    // rust: {
    // rust: r.craft_result = item;
}
    // rust: return;
}
    // rust: let slot = self.slot_mut(internal);
    // rust: let changed = !super::hand::matches_for_swap(slot.as_ref(), item.as_ref());
    // rust: *slot = item;
    // rust: if internal < 36 {
    // rust: self.remote_hand_slot_set(internal, changed);
    // rust: } else if internal == 504 {
    // rust: self.remote_hand_slot_set(super::shield::OFFHAND_SLOT, changed);
}
    // rust: if internal >= super::stations::INPUT && self.station.is_some() {
    // rust: self.remote_station_slot_changed(internal);
}
}

    // `ClientPacketListener.handleUpdateAttributes` for a mob, each value from
    // `AttributeInstance.calculateValue`: its maximum health (the hearts drawn
    // over its mount), and its `minecraft:scale`, which sizes its box
    // (`LivingEntity.getDimensions`) and model (`LivingEntityRenderState.scale`)
    // as the local player's does: NPC plugins make their fake players bigger
    // with it, datapacks scale any mob.
remote_mob_attributes :: proc(self: ^Self, id: i32, values: ^[play::AttributeSnapshot]) {
}
    // rust: let catalog = &self.motion.attributes;
    // rust: let value = |name: &str| {
    // rust: let attribute = catalog.id(name)?;
    // rust: let s = values
    // rust: .iter()
    // rust: .find(|s| s.attribute == attribute.registry_id())?;
    // rust: Some(
    // rust: catalog
    // rust: .attribute(attribute)
    // rust: .definition
    // rust: .sanitize(snapshot_value(s)),
    // rust: )
}
    // rust: let (max_health, scale) = (value("minecraft:max_health"), value("minecraft:scale"));
    // rust: let (speed, jump) = (
    // rust: value("minecraft:movement_speed"),
    // rust: value("minecraft:jump_strength"),
    // rust: );
    // rust: let Some(m) = self.mob_index.get_mut(&mut self.mobs, id as u32) else {
    // rust: return;
}
        // A horse its rider's client moves goes at its own speed and jumps
        // its own height (`getSpeed`, `getCustomJump`).
    // rust: if horizon_client::mobs::equine::moved_by_rider(m.species()) {
    // rust: if let Some(speed) = speed {
    // rust: horizon_client::mobs::finalize::set_base(
    // rust: m,
    // rust: horizon_client::mobs::finalize::Attr::MovementSpeed,
    // rust: speed,
    // rust: );
}
    // rust: if let Some(jump) = jump {
    // rust: m.extra.vector[0] = jump;
}
}
    // rust: if let Some(max_health) = max_health {
    // rust: horizon_client::mobs::finalize::set_base(
    // rust: m,
    // rust: horizon_client::mobs::finalize::Attr::MaxHealth,
    // rust: max_health,
    // rust: );
}
    // rust: if let Some(scale) = scale {
    // rust: m.extra.model_scale = scale as f32;
}
}

    // rust: pub(super) fn handle_packet(&mut self, packet: C) -> Result<()> {
    // rust: self.native_client_packet(&packet);
    // rust: match packet {
            // ClientCommonPacketListenerImpl.handlePing runs on the game
            // thread, after all preceding packets (especially teleports).
    // rust: C::Ping(p) => self.send(S::Pong(p)),
            // A native mod's server half to its client half.
    // rust: C::CustomPayload(p) if p.channel == horizon_protocol::mod_net::CHANNEL => {
    // rust: self.remote_native_net(&p.data);
}
            // The synced attachments of a holder the server shows the window.
    // rust: C::CustomPayload(p) if p.channel == horizon_protocol::attachment_sync::CHANNEL => {
    // rust: self.remote_attachment_sync(&p.data);
}
            // A mod menu type's block and its mod's bytes, just before the
            // menu's `OpenScreen`.
    // rust: C::CustomPayload(p) if p.channel == horizon_protocol::menu_extra::CHANNEL => {
    // rust: match horizon_protocol::menu_extra::decode(&p.data) {
    // rust: Ok(extra) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.menu_extra = Some(extra);
}
}
    // rust: Err(e) => log::debug!("Horizon: a bad menu extra payload: {e}"),
}
}
            // The server's recipes its native mods asked to send.
    // rust: C::CustomPayload(p) if p.channel == horizon_client::lan::recipes::CONTENT_CHANNEL => {
    // rust: self.remote_recipe_content(&p.data);
}
            // PingDebugMonitor.onPongReceived.
    // rust: C::PongResponse(p) => {
    // rust: let delay = self.debug_millis() - p.time;
    // rust: self.debug_charts.ping.log(delay);
}
    // rust: C::Login(p) => {
    // rust: self.test_highlights.clear();
    // rust: self.forget_synced_recipes();
    // rust: self.level.hardcore = p.hardcore;
                // handleLogin: startWaitingForNewLevel with Reason.OTHER, which
                // replaces ServerReconfigScreen.
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.reconfiguring = None;
    // rust: r.attachments.clear();
}
                // handleLogin makes a new MultiPlayerGameMode (carried index 0) and a
                // new LocalPlayer (slot 0, no effects, riding nothing: the server
                // pairs a vehicle again with ClientboundSetPassengersPacket).
    // rust: self.selected = 0;
    // rust: self.potions.effects.clear();
    // rust: self.riding = None;
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.carried.set(Some(0));
                    // handleLogin makes a new ClientLevel: its predictions count from 0.
    // rust: r.sequence = 0;
    // rust: r.own_invisible = false;
    // rust: r.own_on_fire = false;
    // rust: r.online_mode = p.online_mode;
    // rust: r.enforces_secure_chat = p.enforces_secure_chat;
    // rust: r.entity_id = p.player_id;
    // rust: r.local_entity_silent = false;
                    // handleLogin: the new LocalPlayer is the camera.
    // rust: r.camera = None;
    // rust: r.logged_in = true;
    // rust: r.view_distance = p.chunk_radius;
    // rust: r.simulation_distance = p.simulation_distance;
    // rust: r.show_death_screen = p.show_death_screen;
    // rust: r.reduced_debug_info = p.reduced_debug_info;
    // rust: r.do_limited_crafting = p.limited_crafting;
}
    // rust: self.streaming.radius =
    // rust: self.settings.render_distance.min(p.chunk_radius + 1).max(2);
                // handleLogin: startWaitingForNewLevel(.., Reason.OTHER).
    // rust: self.enter_remote_dimension(
    // rust: &p.spawn,
    // rust: false,
    // rust: horizon_client::level_loading::Reason::Other,
    // rust: );
                // No ClientInformation here: the configuration phase sent it,
                // and ClientPacketListener.broadcastClientInformation sends it
                // again only when an option changes it.
    // rust: self.remote_chat_login();
}
    // rust: C::Respawn(p) => {
    // rust: if let Some(r) = self.remote.as_ref() {
    // rust: self.audio.remove_sound_entity(r.entity_id as u32);
}
                // A new player, without effects (the server sends them
                // again) and with no item in use.
    // rust: self.potions.effects.clear();
                // The server sends the level, chunks and entities again.
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.attachments
    // rust: .retain(|holder, _| matches!(holder, Holder::Player(_)));
}
    // rust: self.using = None;
    // rust: self.end_mod_use();
                // After a death (no KEEP_ENTITY_DATA) the new LocalPlayer
                // rides nothing: the server pairs a vehicle again with its
                // passengers. A dimension change keeps the vehicle it travels in.
    // rust: if p.keep & 2 == 0 {
    // rust: self.riding = None;
                    // KEEP_ENTITY_DATA copies the old player's synched data
                    // (its shared flags) to the new one; without it they reset.
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.own_invisible = false;
    // rust: r.own_on_fire = false;
    // rust: r.local_entity_silent = false;
}
}
    // rust: let dimension_changed = self.dim != Dim::from_id(&p.spawn.dimension);
    // rust: let died = self.screen == Screen::Dead
    // rust: || self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|m| m.health.health() <= 0.0);
    // rust: let reason = horizon_client::level_loading::reason_for_respawn(
    // rust: died,
    // rust: &p.spawn.dimension,
    // rust: self.dim.id(),
    // rust: );
    // rust: if dimension_changed {
    // rust: horizon_client::spans::startup::arm("dimension.change");
}
                // handleRespawn makes a new ClientLevel for another dimension
                // key (a proxy's server switch too): its predictions count from 0.
    // rust: if let Some(r) = self.remote.as_mut()
    // rust: && r.level != p.spawn.dimension
    // rust: {
    // rust: r.sequence = 0;
}
    // rust: self.enter_remote_dimension(&p.spawn, true, reason);
    // rust: if dimension_changed {
                    // LevelExtractor.setLevel: a new level drops the highlights.
    // rust: self.test_highlights.clear();
    // rust: let (music, _) = self.situational_music();
    // rust: self.music.stop_playing(music.as_ref(), &mut self.audio);
}
    // rust: self.screen = Screen::Playing;
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.death_message = None;
    // rust: r.health = (20.0, 20, 5.0);
                    // handleRespawn: the new LocalPlayer is the camera.
    // rust: r.camera = None;
}
    // rust: self.capture(true);
}
    // rust: C::PlayerPosition(p) => self.remote_teleport(&p)?,
    // rust: C::PlayerRotation(p) => {
    // rust: self.yaw = if p.relative_yaw {
    // rust: self.yaw + p.yaw
    // rust: } else {
    // rust: p.yaw
}
    // rust: self.pitch = (if p.relative_pitch {
    // rust: self.pitch + p.pitch
    // rust: } else {
    // rust: p.pitch
    // rust: })
    // rust: .clamp(-90.0, 90.0);
    // rust: self.snap_player_model_pitch();
}
    // rust: C::PlayerLookAt(p) => self.remote_look_at(&p),
            // ClientCommonPacketListenerImpl.handlePostEffects.
    // rust: C::PostEffects(p) => self.post_effects = p.effects,
    // rust: C::SetCamera(p) => self.remote_set_camera(p.camera_id),
    // rust: C::LevelChunkWithLight(p) => self.remote_chunk(&p, None),
    // rust: C::LightUpdate(p) => self.remote_light_update(&p),
    // rust: C::ChunksBiomes(p) => self.remote_chunks_biomes(&p),
            // `poll_remote` forgets a run of them at once.
    // rust: C::ForgetLevelChunk(p) => {
    // rust: self.forget_remote_columns(&mut [(p.pos[0], p.pos[1])].into_iter().collect());
}
    // rust: C::ChunkBatchFinished(_) => {
                // ChunkBatchSizeCalculator's ceiling; meshing runs on workers.
    // rust: self.send(S::ChunkBatchReceived(play::ChunkBatchReceived {
    // rust: chunks_per_tick: 64.0,
    // rust: }));
}
    // rust: C::BlockUpdate(p) => self.server_block(p.pos, p.state),
    // rust: C::AddTransientBlock(p) => self.add_transient_block(p.pos, p.state),
            // ClientPacketListener.handleBlockDestruction: another player's crack.
    // rust: C::BlockDestruction(p) => {
    // rust: self.destroy_block_progress(p.id, p.pos, i32::from(p.progress));
}
    // rust: C::SectionBlocksUpdate(p) => {
    // rust: let [sx, sy, sz] = p.section;
    // rust: for change in p.changes {
    // rust: let local = (change & 0xFFF) as i32;
    // rust: let pos = [
    // rust: sx * 16 + (local >> 8 & 15),
    // rust: sy * 16 + (local & 15),
    // rust: sz * 16 + (local >> 4 & 15),
    // rust: ];
    // rust: self.server_block(pos, (change >> 12) as i32);
}
}
    // rust: C::BlockChangedAck(p) => self.end_predictions(p.sequence),
            // Level.blockEvent on the client level: the block's triggerEvent
            // runs on the client's copy of whatever is at pos (a piston's
            // moveBlocks builds the moving block entities it animates, a note
            // block plays); what it doesn't handle reaches the client copy of
            // the block entity (chest lids, shulker boxes).
    // rust: C::BlockEvent(p) => {
    // rust: let pos = horizon_core::position::BlockPos::new(p.pos[0], p.pos[1], p.pos[2]);
    // rust: let triggered = self.with_level(|b, level, ticks| {
    // rust: b.client_block_event(level, ticks, pos, i32::from(p.b0), i32::from(p.b1))
    // rust: });
    // rust: self.sync_moving_pistons();
    // rust: self.process_level_events()?;
    // rust: if !triggered {
    // rust: let state = self.world.block(p.pos[0], p.pos[1], p.pos[2]);
    // rust: let block = &self.res.facts().get(state).name;
    // rust: let named = self.remote.as_ref().and_then(|r| {
    // rust: r.builtin
    // rust: .get("minecraft:block")?
    // rust: .name(p.block)
    // rust: .map(str::to_owned)
    // rust: });
    // rust: if named.as_deref() == Some(&**block) {
    // rust: self.block_entity_event(p.pos, i32::from(p.b0), i32::from(p.b1));
}
}
}
            // ClientLevel.levelEvent: LevelEventHandler, as this client's own
            // level plays them (particles and sounds: a spawner's burst, bone
            // meal, waxing, a block broken by someone else).
            // ClientPacketListener.handleLevelEvent: a global one is heard
            // from anywhere (ClientLevel.globalLevelEvent).
    // rust: C::LevelEvent(p) if p.global => self.global_level_event_sound(p.kind, p.pos),
    // rust: C::LevelEvent(p) => self.level_event_at(p.kind, p.pos, p.data),
    // rust: C::LevelParticles(p) => self.remote_level_particles(&p),
    // rust: C::Explode(p) => self.remote_explode(&p),
    // rust: C::Sound(p) => {
    // rust: if let Some(name) = self.remote_sound_name(&p.sound)
    // rust: && !self.settings.extras.pvp.combat.mutes_sound(&name)
    // rust: {
    // rust: let at = [
    // rust: f64::from(p.x) / 8.0,
    // rust: f64::from(p.y) / 8.0,
    // rust: f64::from(p.z) / 8.0,
    // rust: ];
                    // ClientPacketListener.handleSoundEvent plays with packet.getSource().
    // rust: match usize::try_from(p.source)
    // rust: .ok()
    // rust: .filter(|s| *s < horizon_client::settings::SOUND_SOURCES.len())
    // rust: {
    // rust: Some(source) => {
    // rust: self.audio
    // rust: .play_on(source, &name, Some(at), p.volume, p.pitch)
}
    // rust: None => self.audio.play(&name, Some(at), p.volume, p.pitch),
}
}
}
    // rust: C::SoundEntity(p) => {
    // rust: if let Some(name) = self.remote_sound_name(&p.sound)
    // rust: && !self.settings.extras.pvp.combat.mutes_sound(&name)
    // rust: && let Some(state) = self.remote_sound_entity_state(p.id)
    // rust: {
    // rust: let source = usize::try_from(p.source)
    // rust: .ok()
    // rust: .filter(|s| *s < horizon_client::settings::SOUND_SOURCES.len())
    // rust: .unwrap_or_else(|| horizon_client::settings::sound_source(&name));
    // rust: let entity = horizon_client::sound_engine::SoundEntity::new(
    // rust: p.id as u32,
    // rust: state.position,
    // rust: state.silent,
    // rust: );
    // rust: entity.update(state);
    // rust: self.audio
    // rust: .play_entity_seeded(&name, source, p.volume, p.pitch, p.seed, entity);
}
}
    // rust: C::StopSound(p) => self
    // rust: .audio
    // rust: .stop_sounds(p.sound.as_deref(), p.source.map(|s| s as usize)),
    // rust: C::AddEntity(p) => {
    // rust: self.audio.remove_sound_entity(p.id as u32);
    // rust: let kind = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| {
    // rust: r.builtin
    // rust: .get("minecraft:entity_type")?
    // rust: .name(p.kind)
    // rust: .map(str::to_owned)
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let rotation =
    // rust: [p.yaw, p.pitch, p.head_yaw].map(horizon_protocol::buf::unpack_degrees);
    // rust: if let Some(r) = self.remote.as_mut() {
                    // A new entity looks its PlayerInfo up afresh.
    // rust: r.level_player_textures.remove(&p.id);
    // rust: if kind == "minecraft:player" {
    // rust: r.level_players.insert(p.id, p.uuid);
                        // createEntityFromPacket: the player takes the profile of its list entry.
    // rust: match r.players.get(&p.uuid) {
    // rust: Some(name) => r.level_player_names.insert(p.id, name.clone()),
    // rust: None => r.level_player_names.remove(&p.id),
}
    // rust: } else {
    // rust: r.level_players.remove(&p.id);
    // rust: r.level_player_names.remove(&p.id);
}
}
                // Entity.getTeam: a mob is on a team by its UUID, a player by
                // its profile name (`Game::scoreboard_name`).
    // rust: self.persist.uuids.insert(
    // rust: p.id as u32,
    // rust: horizon_client::lan::playerdata::uuid_ints(p.uuid),
    // rust: );
    // rust: self.spawn_entity(p.id, &kind, p.position, rotation);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.cart_lerps.remove(&p.id);
    // rust: r.lerps.remove(&p.id);
}
    // rust: if !self.spawn_remote_object(
    // rust: p.id,
    // rust: &kind,
    // rust: p.position,
    // rust: (rotation[0], rotation[1]),
    // rust: p.data,
    // rust: ) {
    // rust: self.spawn_remote_projectile(
    // rust: p.id,
    // rust: &kind,
    // rust: p.position,
    // rust: (rotation[0], rotation[1]),
    // rust: p.velocity,
    // rust: p.data,
    // rust: );
}
                // Entity.recreateFromPacket: objects must exist before applying motion.
    // rust: self.remote_motion(p.id, p.velocity);
    // rust: if self.minecart_improvements()
    // rust: && self.carts.iter().any(|c| c.id == p.id as u32)
    // rust: && let Some(r) = self.remote.as_mut()
    // rust: {
    // rust: r.cart_lerps.insert(p.id, CartLerp::new());
}
    // rust: self.move_remote_text_display(p.id, p.position, Some((rotation[0], rotation[1])));
    // rust: self.move_remote_interaction(p.id, p.position);
}
    // rust: C::RemoveEntities(p) => {
    // rust: for id in p.ids {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: if let Some(uuid) = r.level_players.remove(&id) {
    // rust: r.attachments.remove(&Holder::Player(uuid));
}
    // rust: r.level_player_names.remove(&id);
    // rust: r.level_player_textures.remove(&id);
    // rust: r.attachments.remove(&Holder::Entity(id as u32));
}
    // rust: self.remove_entity(id);
}
}
    // rust: C::MoveEntityPos(play::MoveEntityPos(m))
    // rust: | C::MoveEntityPosRot(play::MoveEntityPosRot(m))
    // rust: | C::MoveEntityRot(play::MoveEntityRot(m)) => {
    // rust: let base = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.entities.get(&m.id))
    // rust: .map(|t| t.position);
    // rust: let Some(base) = base else { return Ok(()) };
                // VecDeltaCodec.decode: each step's position from the last.
    // rust: let path = m.delta.as_ref().map(|d| match d {
    // rust: play::VecDelta::Linear(_) => Path::Linear(d.end(base)),
    // rust: play::VecDelta::Stepped(steps) => {
    // rust: let mut at = base;
    // rust: Path::Stepped(
    // rust: steps
    // rust: .iter()
    // rust: .map(|(delta, ticks)| {
    // rust: at = play::VecDelta::apply(at, *delta);
    // rust: (at, *ticks)
    // rust: })
    // rust: .collect(),
    // rust: )
}
    // rust: });
    // rust: let rotation = m.rotation.map(|(y, x)| {
    // rust: (
    // rust: horizon_protocol::buf::unpack_degrees(y),
    // rust: horizon_protocol::buf::unpack_degrees(x),
    // rust: )
    // rust: });
    // rust: self.move_entity(m.id, path, rotation, m.on_ground, MovePacket::Move);
}
    // rust: C::EntityPositionSync(p) => {
    // rust: let path = match p.path {
    // rust: play::PositionPath::Linear(at) => Path::Linear(at),
    // rust: play::PositionPath::Stepped(steps) => Path::Stepped(steps),
}
    // rust: self.move_entity(
    // rust: p.id,
    // rust: Some(path),
    // rust: Some((p.yaw, p.pitch)),
    // rust: p.on_ground,
    // rust: MovePacket::PositionSync,
    // rust: )
}
    // rust: C::TeleportEntity(p) => {
    // rust: let base = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.entities.get(&p.id))
    // rust: .map_or([0.0; 3], |t| t.position);
    // rust: let rel = |bit: i32, i: usize| {
    // rust: if p.relatives & bit != 0 {
    // rust: base[i] + p.position[i]
    // rust: } else {
    // rust: p.position[i]
}
}
    // rust: let position = [
    // rust: rel(play::relative::X, 0),
    // rust: rel(play::relative::Y, 1),
    // rust: rel(play::relative::Z, 2),
    // rust: ];
                // setValuesFromPositionPacket: interpolated, unless too far.
    // rust: self.move_entity(
    // rust: p.id,
    // rust: Some(Path::Linear(position)),
    // rust: Some((p.yaw, p.pitch)),
    // rust: p.on_ground,
    // rust: MovePacket::Teleport,
    // rust: );
                // handleTeleportEntity: the mount this client moves is put
                // there at once.
    // rust: if self.driven_mount().is_some_and(|m| m.id as i32 == p.id) {
    // rust: self.remote_move_vehicle(position, p.yaw);
}
}
    // rust: C::SetPassengers(p) => self.remote_set_passengers(p.vehicle, &p.passengers),
            // ClientPacketListener.handleEntityLinkPacket: who holds a mob's
            // lead (this player, another player, a mob or a fence knot), for
            // the rope.
    // rust: C::SetEntityLink(p) => {
    // rust: let me = self.remote.as_ref().map(|r| r.entity_id);
//                 use horizon_client::mobs::leash::Holder;
    // rust: let holder = match p.dest {
    // rust: 0 => None,
    // rust: d if Some(d) == me => Some(Holder::Player),
    // rust: d => match self.remote_knots.get(&(d as u32)) {
    // rust: Some(&block) => Some(Holder::Knot(block)),
                        // Not a known knot yet: kept by id until the knot
                        // arrives (game/remote_objects.rs).
    // rust: None if self.boats.iter().any(|b| b.id == d as u32) => {
    // rust: Some(Holder::Boat(d as u32))
}
    // rust: None => Some(Holder::Mob(d as u32)),
    // rust: },
}
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.source as u32) {
    // rust: m.extra.leash = holder;
    // rust: } else if let Some(b) = self.boats.iter_mut().find(|b| b.id == p.source as u32) {
                    // A leashed boat or raft (AbstractBoat is Leashable).
    // rust: b.leash = holder;
}
}
    // rust: C::MoveVehicle(p) => self.remote_move_vehicle(p.position, p.yaw),
    // rust: C::MoveMinecartAlongTrack(p) => self.remote_move_minecart(p),
            // ClientPacketListener.handleRotateMob: lerpHeadTo(yHeadRot, 3).
    // rust: C::RotateHead(p) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: let yaw = horizon_protocol::buf::unpack_degrees(p.head_yaw);
    // rust: r.head_lerps.insert(p.id, (yaw, 3));
}
}
    // rust: C::SetEntityData(p) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: for (index, _, value) in &p.values {
    // rust: if let (4, Value::Bool(silent)) = (index, value) {
    // rust: if p.id == r.entity_id {
    // rust: r.local_entity_silent = *silent;
}
    // rust: if let Some(t) = r.entities.get_mut(&p.id) {
    // rust: t.silent = *silent;
}
}
}
}
                // Entity.DATA_SHARED_FLAGS_ID, DATA_CUSTOM_NAME and
                // DATA_CUSTOM_NAME_VISIBLE: server NPCs and holograms rely on
                // these instead of saved NBT.
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32) {
    // rust: for (index, _, value) in &p.values {
    // rust: match (index, value) {
    // rust: (0, Value::Byte(flags)) => {
    // rust: m.invisible = flags & 0x20 != 0;
    // rust: m.glowing = flags & 0x40 != 0;
}
    // rust: (2, Value::OptText(name)) => {
    // rust: let text = name.as_ref().map(horizon_client::entity_nbt::name_text);
    // rust: m.custom_name =
    // rust: text.as_ref().map(horizon_client::text::Text::plain);
    // rust: m.custom_name_text = text;
}
    // rust: (2, Value::Text(name)) => {
    // rust: let text = horizon_client::entity_nbt::name_text(name);
    // rust: m.custom_name = Some(text.plain());
    // rust: m.custom_name_text = Some(text);
}
    // rust: (3, Value::Bool(visible)) => m.name_visible = *visible,
    // rust: _ => {}
}
}
}
    // rust: if let Some((_, _, Value::Byte(flags))) = p.values.iter().find(|v| v.0 == 0)
    // rust: && let Some(r) = self.remote.as_mut()
    // rust: {
    // rust: if flags & 0x40 != 0 {
    // rust: r.glowing.insert(p.id);
    // rust: } else {
    // rust: r.glowing.remove(&p.id);
}
}
    // rust: self.remote_mob_data(p.id, &p.values);
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32)
    // rust: && m.species() == horizon_client::mobs::Species::Creeper
    // rust: {
    // rust: for (index, _, value) in &p.values {
    // rust: match (index, value) {
                            // Creeper.DATA_SWELL_DIR, DATA_IS_POWERED, DATA_IS_IGNITED.
    // rust: (16, Value::Int(dir)) => m.extra.counter = *dir,
    // rust: (17, Value::Bool(powered)) => m.extra.charged = *powered,
    // rust: (18, Value::Bool(ignited)) => m.extra.flag = *ignited,
    // rust: _ => {}
}
}
}
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32) {
    // rust: for (index, _, value) in &p.values {
    // rust: match (index, value) {
                            // Entity.DATA_TICKS_FROZEN: isFullyFrozen shakes it.
    // rust: (7, Value::Int(ticks)) => m.ticks_frozen = *ticks,
                            // Strider.DATA_SUFFOCATING (after AgeableMob's two
                            // and DATA_BOOST_TIME): a cold strider shakes.
    // rust: (19, Value::Bool(cold))
    // rust: if m.species() == horizon_client::mobs::Species::Strider =>
    // rust: {
    // rust: m.extra.flag = *cold;
}
    // rust: _ => {}
}
}
}
                // LivingEntity.DATA_LIVING_ENTITY_FLAGS: for another player
                // too, remote_mob_data's apply reads index 8 above.
    // rust: let mannequin = self
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|m| m.id == p.id as u32 && &*m.kind.id == "minecraft:mannequin");
    // rust: let other = mannequin
    // rust: || self.remote.as_ref().is_some_and(|r| {
    // rust: r.level_players.contains_key(&p.id) && r.entity_id != p.id
    // rust: });
                // LivingEntity.onSyncedDataUpdated(SLEEPING_POS_ID): another
                // player lies down in their bed (drawn lying in it), or gets up.
    // rust: if other {
    // rust: for (index, _, value) in &p.values {
    // rust: if let (14, Value::OptPos(bed)) = (index, value) {
    // rust: let code = bed.map_or(0, |b| self.bed_facing(b));
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32) {
    // rust: m.extra.ints[1] = code;
    // rust: if let Some(head) = *bed {
                                    // LivingEntity.onSyncedDataUpdated(SLEEPING_POS_ID): setPosToBed.
    // rust: let at = Vec3::new(
    // rust: f64::from(head[0]) + 0.5,
    // rust: f64::from(head[1]) + 0.5625 + 0.125,
    // rust: f64::from(head[2]) + 0.5,
    // rust: );
    // rust: m.position = at;
    // rust: m.previous = at;
    // rust: m.head_pitch = 0.0;
    // rust: m.previous_head_pitch = 0.0;
}
}
}
                        // Avatar.DATA_PLAYER_MAIN_HAND (HumanoidArm: 0 left, 1
                        // right): the arm a swing of the main hand moves.
    // rust: if let (15, Value::Id(arm)) = (index, value)
    // rust: && let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32)
    // rust: {
    // rust: m.extra.main_hand_left = *arm == 0;
}
                        // Avatar.DATA_PLAYER_MODE_CUSTOMISATION: the skin layers
                        // the player shows (PlayerModelPart bits).
    // rust: if let (16, Value::Byte(bits)) = (index, value)
    // rust: && let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32)
    // rust: {
    // rust: m.extra.hidden_model_parts = !(*bits as u8) & 0x7F;
}
}
}
                // LivingEntity.onSyncedDataUpdated(SLEEPING_POS_ID): this
                // player lies down in the bed, or gets up.
    // rust: if self.remote.as_ref().is_some_and(|r| r.entity_id == p.id) {
    // rust: for (index, _, value) in &p.values {
    // rust: match (index, value) {
    // rust: (14, Value::OptPos(bed)) => {
    // rust: if bed.is_some() && self.sleeping.is_none() {
    // rust: self.sleep_timer = 0;
}
    // rust: self.sleeping = *bed;
    // rust: if let Some(head) = *bed {
                                    // LivingEntity.onSyncedDataUpdated(SLEEPING_POS_ID): setPosToBed.
    // rust: let at = Vec3::new(
    // rust: f64::from(head[0]) + 0.5,
    // rust: f64::from(head[1]) + 0.5625 + 0.125,
    // rust: f64::from(head[2]) + 0.5,
    // rust: );
    // rust: if let Some(pl) = self.player.as_mut() {
    // rust: pl.position = at;
    // rust: pl.velocity = Vec3::ZERO;
    // rust: pl.pitch = 0.0;
}
    // rust: self.previous_position = at;
    // rust: self.pitch = 0.0;
    // rust: self.snap_player_model_pitch();
}
}
                            // Entity.DATA_SHARED_FLAGS_ID's sprinting bit: the
                            // server stops the sprint after a hit's extra
                            // knockback (the flag only, as assignValues sets
                            // it: the speed modifier and wasSprinting stay).
                            // Its invisible bit (Entity.isInvisible): the
                            // Invisibility effect's, or a plugin's that hides
                            // the real body under a pose (#3788).
    // rust: (0, Value::Byte(flags)) => {
    // rust: if let Some(pl) = self.player.as_mut() {
    // rust: pl.sprinting = flags & 0x08 != 0;
                                    // Entity.DATA_SHARED_FLAGS_ID's fall-flying
                                    // bit (0x80, `Entity.setSharedFlag(7, ...)`):
                                    // `LivingEntity.updateFallFlying` clears the
                                    // glide on the server only and `LocalPlayer`
                                    // never ends one itself, so this packet is
                                    // the glide's own end. Applied when it is
                                    // handled — the frame's poll, before its
                                    // ticks — as ClientPacketListener does, so a
                                    // clear that arrives mid-tick lets that tick
                                    // keep its glide travel (#7616).
    // rust: pl.fall_flying = flags & -128 != 0;
}
    // rust: let on_fire = flags & 0x01 != 0;
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.own_invisible = flags & 0x20 != 0;
    // rust: let was_on_fire =
    // rust: std::mem::replace(&mut r.own_on_fire, on_fire);
                                    // The server put the fire out: the
                                    // window's countdown ends with it.
    // rust: if was_on_fire
    // rust: && !on_fire
    // rust: && let Some(pl) = self.player.as_mut()
    // rust: {
    // rust: pl.fire_ticks = pl.fire_ticks.min(0);
}
}
}
                            // Entity.DATA_AIR_SUPPLY_ID and
                            // Player.DATA_PLAYER_ABSORPTION_ID: the bubbles
                            // and golden hearts the server's player has.
    // rust: (1, Value::Int(air)) => {
    // rust: if let Some(pl) = self.player.as_mut() {
    // rust: pl.air = *air;
}
}
                            // LivingEntity.DATA_ARROW_COUNT_ID and DATA_STINGER_COUNT_ID.
    // rust: (12, Value::Int(count)) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.own_arrows = *count;
}
}
    // rust: (13, Value::Int(count)) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.own_stingers = *count;
}
}
    // rust: (19 | 20, Value::Id(v)) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.own_shoulders[usize::from(*index == 20)] =
    // rust: (*v > 0).then(|| (*v - 1).clamp(0, 4));
}
}
    // rust: (17, Value::Float(amount)) => {
    // rust: if let Some(pl) = self.player.as_mut() {
    // rust: let _ = pl.internal_set_absorption(*amount);
}
}
                            // LivingEntity.DATA_LIVING_ENTITY_FLAGS: the server
                            // starts or stops this player's use, as an axe that
                            // disables the raised shield does (Player.disableShield's
                            // stopUsingItem). LocalPlayer.onSyncedDataUpdated.
    // rust: (8, Value::Byte(flags)) => {
    // rust: let selected = self.selected;
    // rust: let using = self.using;
    // rust: self.using = synced_local_use(using, *flags, selected, |slot| {
    // rust: self.stack_in(slot).is_some()
    // rust: });
                                // onSyncedDataUpdated's useItemRemaining: getUseDuration,
                                // without startUsingItem's event.
    // rust: if using.is_none()
    // rust: && let Some((slot, _)) = self.using
    // rust: && let Some(stack) = self.stack_in(slot).cloned()
    // rust: {
    // rust: self.use_duration = self.use_duration(&stack);
    // rust: self.use_ticks_set = false;
}
}
    // rust: _ => {}
}
}
}
                // Entity.DATA_SHARED_FLAGS_ID's crouching and sprinting bits:
                // another player's or a mannequin's crouch (their model and
                // Entity.isDiscrete's name tag), and the dust a runner raises.
    // rust: if (mannequin
    // rust: || self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.level_players.contains_key(&p.id)))
    // rust: && let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32)
    // rust: {
    // rust: for (index, _, value) in &p.values {
    // rust: if let (0, Value::Byte(flags)) = (index, value) {
    // rust: m.extra.crouching = flags & 2 != 0;
    // rust: m.extra.sprinting = flags & 8 != 0;
}
}
}
    // rust: for (index, _, value) in &p.values {
    // rust: if *index == ITEM_ENTITY_ITEM
    // rust: && let Value::Item(stack) = value
    // rust: {
    // rust: self.remote_item_data(p.id, stack);
}
                    // ExperienceOrb.DATA_VALUE (the icon's size).
    // rust: if *index == 8
    // rust: && let Value::Int(v) = value
    // rust: && let Some(o) = self.orbs.iter_mut().find(|o| o.id == p.id as u32)
    // rust: {
    // rust: o.value = (*v).max(0) as u32;
}
}
    // rust: self.remote_object_data(p.id, &p.values);
    // rust: self.remote_projectile_data(p.id, &p.values);
    // rust: self.remote_dragon_data(p.id, &p.values);
}
            // ClientPacketListener.handleSetEquipment: what a mob or another
            // player holds and wears (EquipmentSlot ordinals).
    // rust: C::SetEquipment(p) => {
    // rust: self.remote_object_equipment(p.id, &p.slots);
    // rust: let items: Vec<(u8, Option<Arc<str>>, Option<ItemStack>)> = p
    // rust: .slots
    // rust: .iter()
    // rust: .map(|(slot, stack)| {
    // rust: (
    // rust: *slot,
    // rust: stack.as_ref().map(|s| self.item_name(s.item)),
    // rust: self.to_stack(stack),
    // rust: )
    // rust: })
    // rust: .collect();
                // CrossbowItem.isCharged: the main hand's `charged_projectiles`
                // (AvatarRenderer.getArmPose holds a loaded crossbow up).
    // rust: let charged = p.slots.iter().find(|(slot, _)| *slot == 0).map(|(_, s)| {
    // rust: s.as_ref().is_some_and(|s| {
    // rust: matches!(
    // rust: s.component(horizon_protocol::item::component::CHARGED_PROJECTILES),
    // rust: Some(horizon_protocol::item::Component::Stacks(list))
    // rust: if !list.is_empty()
    // rust: )
    // rust: })
    // rust: });
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32) {
    // rust: if let Some(charged) = charged
    // rust: && &*m.kind.id == "minecraft:player"
    // rust: {
    // rust: m.extra.charged = charged;
}
    // rust: for (slot, item, stack) in items {
    // rust: let e = &mut m.extra;
    // rust: match slot {
    // rust: 0 => match stack {
                                // The components the server sent (a loaded
                                // crossbow's `charged_projectiles`, dyed
                                // leather, an enchanted book's id, ...) are
                                // what the item model draws.
    // rust: Some(stack) => e.set_main_hand_stack(Some(stack)),
    // rust: None => e.set_main_hand(item),
    // rust: },
    // rust: 1 => e.off_hand = item,
    // rust: 2 => {
    // rust: e.feet = item;
    // rust: e.armor[3] = stack;
}
    // rust: 3 => {
    // rust: e.legs = item;
    // rust: e.armor[2] = stack;
}
    // rust: 4 => {
    // rust: e.chest = item;
    // rust: e.armor[1] = stack;
}
    // rust: 5 => {
    // rust: e.head = item;
    // rust: e.armor[0] = stack;
}
    // rust: 6 => {
                                // A wolf's armor shows its cracks.
    // rust: e.body_damage = stack.as_ref().map_or(0, |s| s.damage as i32);
    // rust: e.body = item;
}
    // rust: 7 => m.set_saddle(stack),
    // rust: _ => {}
}
}
}
}
    // rust: C::TakeItemEntity(p) => {
                // ClientPacketListener.handleTakeItemEntity: the pickup sound at
                // the orb, item or arrow, whoever collects it (the server sends
                // none); an entity this client doesn't track sounds at this player.
    // rust: let orb_at = self
    // rust: .orbs
    // rust: .iter()
    // rust: .find(|o| o.id == p.item as u32)
    // rust: .map(|o| o.position);
    // rust: let orb = orb_at.is_some();
    // rust: let item = self.dropped.iter().find(|d| d.id == p.item as u32);
    // rust: let shot = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .find(|s| s.id == p.item as u32);
    // rust: let shot = shot.map(|s| s.position).or_else(|| {
    // rust: self.tridents
    // rust: .iter()
    // rust: .find(|t| t.id == p.item as u32)
    // rust: .map(|t| t.position)
    // rust: });
    // rust: let at = match (item, shot) {
    // rust: (Some(d), _) => Some([d.position.x, d.position.y, d.position.z]),
    // rust: (None, Some(s)) => Some([s.x, s.y, s.z]),
    // rust: (None, None)
    // rust: if self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.entity_id == p.player) =>
    // rust: {
    // rust: self.eye_position()
}
    // rust: (None, None) => None,
}
    // rust: if let Some(o) = orb_at {
    // rust: let pitch = (self.world.random.next_float() - self.world.random.next_float())
    // rust: * 0.35
    // rust: + 0.9;
    // rust: self.audio.play(
    // rust: "minecraft:entity.experience_orb.pickup",
    // rust: Some([o.x, o.y, o.z]),
    // rust: 0.1,
    // rust: pitch,
    // rust: );
    // rust: } else if let Some(at) = at {
    // rust: let pitch = ((self.world.random.next_float() - self.world.random.next_float())
    // rust: * 0.7
    // rust: + 1.0)
    // rust: * 2.0;
    // rust: self.audio
    // rust: .play("minecraft:entity.item.pickup", Some(at), 0.2, pitch);
}
                // ItemPickupParticle toward the collector (this player, another one or a mob).
    // rust: let collector = if self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.entity_id == p.player)
    // rust: {
    // rust: super::pickups::Collector::Player
    // rust: } else {
    // rust: super::pickups::Collector::Mob(p.player as u32)
}
    // rust: if let Some(item) = self.dropped.iter().find(|d| d.id == p.item as u32).cloned() {
    // rust: self.add_pickup(super::pickups::Taken::Item(Box::new(item)), collector);
    // rust: } else if let Some(orb) = self.orbs.iter().find(|o| o.id == p.item as u32).cloned()
    // rust: {
    // rust: self.add_pickup(super::pickups::Taken::Orb(Box::new(orb)), collector);
    // rust: } else if let Some(shot) = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .find(|s| s.id == p.item as u32)
    // rust: .cloned()
    // rust: {
                    // An arrow flies to its collector too, then goes.
    // rust: self.add_pickup(super::pickups::Taken::Arrow(Box::new(shot)), collector);
    // rust: } else if let Some(i) = self.tridents.iter().position(|t| t.id == p.item as u32) {
                    // So does a trident: a server's client keeps them apart.
    // rust: let trident = self.tridents.remove(i);
    // rust: self.add_pickup(super::pickups::Taken::Trident(Box::new(trident)), collector);
}
                // An orb stays: the server may still hold merged ones in it.
    // rust: if !orb {
    // rust: self.remove_entity(p.item);
}
}
            // ClientPacketListener.handleSetEntityMotion: knockback on this player.
    // rust: C::SetEntityMotion(p) if self.remote.as_ref().is_some_and(|r| r.entity_id == p.id) => {
    // rust: if let Some(pl) = self.player.as_mut() {
    // rust: pl.velocity = Vec3::new(p.velocity[0], p.velocity[1], p.velocity[2]);
}
}
            // The same packet for another entity: Entity.lerpMotion.
    // rust: C::SetEntityMotion(p) => self.remote_motion(p.id, p.velocity),
            // ClientPacketListener.handleProjectilePowerPacket: the power a
            // hurting projectile accelerates by, sent bundled with its motion.
    // rust: C::ProjectilePower(p) => {
    // rust: super::remote_projectiles::remote_projectile_power(
    // rust: &mut self.creatures.projectiles,
    // rust: p.id,
    // rust: p.power,
    // rust: );
}
            // ClientPacketListener.handleDamageEvent: LivingEntity.handleDamageEvent
            // jolts the walk animation and restarts the hurt flash, and the
            // hurt player's own client plays its hurt sound (`Player.getHurtSound`:
            // the damage type's effects) at `getSoundVolume` and
            // `Player.getVoicePitch`, which is 1.0 for every player. The
            // server's sound packet reaches every other player around, never
            // this one (#4149), and that copy is played at 1.0.
            // This player's own hurt tilt and flash come from the server too
            // (sent to the player itself): its own moves never hurt it.
    // rust: C::DamageEvent(p) => {
    // rust: let me = self.remote.as_ref().map(|r| r.entity_id);
    // rust: let own = me == Some(p.id);
    // rust: self.pvp_hurt(p.id, own, p.direct.map(|d| Some(d) == me));
    // rust: if own {
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|pl| [pl.position.x, pl.position.y, pl.position.z]);
    // rust: if let Some(pl) = self.player.as_mut() {
    // rust: pl.health.animate_hurt();
}
    // rust: if let Some(at) = at {
    // rust: let sound = self.remote_hurt_sound(p.source_type);
    // rust: let pitch = player_voice_pitch();
    // rust: self.audio.play_on(
    // rust: horizon_client::settings::sound_source(sound),
    // rust: sound,
    // rust: Some(at),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
}
    // rust: } else if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32) {
    // rust: m.limb_speed = 1.5;
    // rust: m.hurt_time = 10;
    // rust: } else {
    // rust: self.remote_dragon_hurt(p.id);
}
}
    // rust: C::HurtAnimation(p) => {
    // rust: if self.remote.as_ref().is_some_and(|r| r.entity_id == p.id) {
                    // Player.animateHurt: the tilt turns around the yaw.
    // rust: if let Some(pl) = self.player.as_mut() {
    // rust: pl.health.animate_hurt_dir(p.yaw);
}
    // rust: } else if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32) {
    // rust: m.hurt_time = 10;
    // rust: } else {
    // rust: self.remote_dragon_hurt(p.id);
}
}
    // rust: C::EntityEvent(p) => {
    // rust: if p.event == super::fireworks::FIREWORK_EXPLODE_EVENT {
    // rust: self.remote_firework_explosion(p.id);
}
    // rust: self.remote_fangs_event(p.id as u32, p.event);
    // rust: self.remote_boat_event(p.id, p.event);
                // MinecartTNT.handleEntityEvent 70: prime the fuse the window draws.
    // rust: self.remote_tnt_cart_event(p.id, p.event);
                // Arrow.handleEntityEvent 0: a tipped arrow's burst of particles.
    // rust: if p.event == 0 {
    // rust: self.remote_arrow_puff(p.id as u32);
}
                // LivingEntity.handleEntityEvent 2: a spear's hit felt.
    // rust: if p.event == 2 {
    // rust: self.remote_kinetic_hit(p.id);
}
                // LocalPlayer.setPermissions also refreshes an open World Options screen.
    // rust: if (24..=28).contains(&p.event)
    // rust: && self.remote.as_ref().is_some_and(|r| r.entity_id == p.id)
    // rust: {
    // rust: self.ui.registries.permission = (p.event - 24) as u8;
    // rust: self.remote_world_options_permission(p.event >= 26);
}
                // Player.handleEntityEvent 22 / 23: reduced debug info on / off.
    // rust: if (22..=23).contains(&p.event)
    // rust: && let Some(r) = self.remote.as_mut().filter(|r| r.entity_id == p.id)
    // rust: {
    // rust: r.reduced_debug_info = p.event == 22;
}
                // Ravager.handleEntityEvent 69: the roar's puff and push.
    // rust: if p.event == 69 {
    // rust: self.remote_ravager_roar(p.id);
}
                // ClientPacketListener.handleEntityEvent 63: a sniffer's digging sound.
    // rust: if p.event == 63 {
    // rust: self.start_sniffer_digging_sound(p.id as u32);
}
                // ClientPacketListener.handleEntityEvent 21: a guardian's hum.
    // rust: if p.event == 21 {
    // rust: self.start_guardian_sound(p.id as u32);
}
                // ZombieVillager.handleEntityEvent 16: the cure starts.
    // rust: if p.event == 16 {
    // rust: self.zombie_villager_cure_sound(p.id as u32);
}
                // Witch.handleEntityEvent 15: the magic puffs over its hat.
    // rust: if p.event == 15 {
    // rust: self.witch_magic_particles(p.id as u32);
}
                // Fox.handleEntityEvent 45: the crumbs of the food in its mouth.
    // rust: if p.event == 45 {
    // rust: self.fox_eat_particles(p.id as u32);
}
                // Rabbit.handleEntityEvent(1): the hop clocks, and
                // Entity.spawnSprintParticle (one block-dust crumb).
    // rust: if p.event == 1 {
    // rust: let hop = {
    // rust: let m = self.mob_index.get_mut(&mut self.mobs, p.id as u32);
    // rust: if let Some(m) = m
    // rust: && m.species() == horizon_client::mobs::Species::Rabbit
    // rust: {
    // rust: let sample =
    // rust: (m.position, m.velocity, f64::from(m.width()), m.supporting);
    // rust: horizon_client::mobs::rabbit::hop_event(m);
    // rust: Some(sample)
    // rust: } else {
    // rust: None
}
}
    // rust: if let Some((position, movement, width, support)) = hop {
    // rust: let id = p.id as u32;
    // rust: self.sprint_particle(position, movement, support, width, |game| {
                            // this.random: the rabbit's own, x then z.
    // rust: game.mob_index
    // rust: .get_mut(&mut game.mobs, id)
    // rust: .map(|m| (m.random.next_double(), m.random.next_double()))
    // rust: });
}
}
    // rust: if p.event == 19
    // rust: && let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32)
    // rust: {
    // rust: horizon_client::mobs::aquatic::squid_cycle_event(m);
}
                // LivingEntity.handleEntityEvent 55: another player swapped
                // its main and off hand (`swapHandItems`).
    // rust: if p.event == 55
    // rust: && let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32)
    // rust: {
    // rust: std::mem::swap(&mut m.extra.main_hand, &mut m.extra.off_hand);
}
                // LivingEntity.handleEntityEvent 47 to 52, 65 and 68: an
                // equipped item broke (onEquippedItemBroken).
    // rust: if let Some(slot) = horizon_client::mobs::item_break::equipment_break_slot(p.event)
    // rust: {
    // rust: self.remote_equipment_break(p.id, slot);
}
                // EntityEvent.DEATH: start the death animation.
    // rust: if p.event == 3
    // rust: && let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32)
    // rust: {
    // rust: m.health = 0.0;
}
                // LivingEntity.handleEntityEvent 3 on this player: its death
                // sound, which Player.playSound plays for this client alone
                // (the server's goes to everyone else).
    // rust: if p.event == 3
    // rust: && self.remote.as_ref().is_some_and(|r| r.entity_id == p.id)
    // rust: && let Some(pl) = self.player.as_ref()
    // rust: {
    // rust: let at = [pl.position.x, pl.position.y, pl.position.z];
    // rust: let sound = "minecraft:entity.player.death";
    // rust: let pitch = player_voice_pitch();
    // rust: self.audio.play_on(
    // rust: horizon_client::settings::sound_source(sound),
    // rust: sound,
    // rust: Some(at),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
}
                // The events that start a mob's animation (the warden's).
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32) {
    // rust: horizon_client::mobs::sync::entity_event(m, p.event as u8);
}
                // LivingEntity.handleEntityEvent 46: portal particles from the
                // old position to the new one (chorus fruit, an enderman).
    // rust: if p.event == 46 {
    // rust: self.entity_teleport_particles(p.id);
}
                // LivingEntity.handleEntityEvent 60: the poof as the dead body goes.
    // rust: if p.event == 60
    // rust: && let Some(m) = self.mob_index.get(&self.mobs, p.id as u32)
    // rust: {
    // rust: let (at, w, h) = (m.position, f64::from(m.width()), f64::from(m.height()));
    // rust: self.death_poof([at.x, at.y, at.z], w, h);
}
    // rust: if p.event == super::totem::TOTEM_EVENT {
    // rust: self.remote_totem(p.id);
}
                // Mob.handleEntityEvent 20: the spawn poof.
    // rust: if p.event == 20 && self.mobs.iter().any(|m| m.id == p.id as u32) {
    // rust: self.poof_particles(p.id as u32);
}
                // The particle bursts of Villager 12 to 14 and 42, TamableAnimal
                // and AbstractHorse 6 and 7, Animal and Allay 18, Ocelot 40 and
                // 41, Dolphin 38: the table in `entity_event_burst` is the one
                // list of them; any other event draws nothing here.
    // rust: self.entity_event_particles(p.id as u32, p.event);
                // Snowball and ThrownEgg.handleEntityEvent 3: the crumbs where
                // the projectile is (the server removes it right after).
    // rust: if p.event == 3 {
    // rust: let crumbs = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .find(|pr| pr.id == p.id as u32)
    // rust: .and_then(|pr| {
    // rust: let item = match pr.kind {
    // rust: horizon_client::projectiles::ProjectileKind::Snowball => {
    // rust: "minecraft:snowball"
}
    // rust: horizon_client::projectiles::ProjectileKind::Egg => "minecraft:egg",
    // rust: horizon_client::projectiles::ProjectileKind::Thrown(t) => t.item,
    // rust: _ => return None,
}
    // rust: Some(([pr.position.x, pr.position.y, pr.position.z], item))
    // rust: });
    // rust: if let Some((at, item)) = crumbs {
    // rust: self.item_burst(at, item);
}
}
    // rust: if p.event == super::combat::DROWN_EVENT {
    // rust: self.remote_drown(p.id);
}
                // Entity events 53 and 54: honey crumbs while sliding, and the
                // ten from a landing (`HoneyBlock.showSlideParticles` /
                // `showJumpParticles`).
    // rust: if horizon_client::landing::honey_particle_count(p.event).is_some() {
    // rust: let at = if self.remote.as_ref().is_some_and(|r| r.entity_id == p.id) {
    // rust: self.player
    // rust: .as_ref()
    // rust: .map(|q| [q.position.x, q.position.y, q.position.z])
    // rust: } else {
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == p.id as u32)
    // rust: .map(|m| [m.position.x, m.position.y, m.position.z])
}
    // rust: if let Some(at) = at {
    // rust: self.honey_entity_particles(at, p.event);
}
}
    // rust: if p.event == super::consume::USE_ITEM_COMPLETE_EVENT
    // rust: && self.remote.as_ref().is_some_and(|r| r.entity_id == p.id)
    // rust: {
    // rust: self.remote_complete_using();
}
}
    // rust: C::Animate(p) => self.remote_animate(p.id, p.action),
            // ClientPacketListener.handleSwingAnimation: the entity swings
            // (LivingEntity.swing, which a swing in its first half ignores).
    // rust: C::SwingAnimation(p) => {
    // rust: let hand = if p.hand == 1 { Hand::Off } else { Hand::Main };
    // rust: let animation = horizon_client::first_person::SwingAnimation {
    // rust: kind: p.kind.clamp(0, 255) as u8,
    // rust: duration: p.duration,
}
    // rust: if self.remote.as_ref().is_some_and(|r| r.entity_id == p.id) {
    // rust: self.swing_hand(hand, animation);
    // rust: } else if let Some(m) = self.mob_index.get_mut(&mut self.mobs, p.id as u32) {
    // rust: m.swing_hand_modified(hand == Hand::Off, animation);
}
}
            // The player's own instances: its maximum health (the hearts the
            // HUD draws and the health it may hold), reach, speed and so on.
            // Then the received health again, which the old maximum clamped.
    // rust: C::UpdateAttributes(p) if self.remote.as_ref().is_some_and(|r| r.entity_id == p.id) => {
    // rust: if let Some(pl) = self.player.as_mut() {
    // rust: horizon_client::lan::attributes::apply(&mut pl.attributes, &p.values);
}
    // rust: self.apply_remote_health();
}
    // rust: C::UpdateAttributes(p) => self.remote_mob_attributes(p.id, &p.values),
    // rust: C::UpdateMobEffect(p) => self.remote_effect(&p),
    // rust: C::RemoveMobEffect(p) => {
    // rust: if self.remote.as_ref().is_some_and(|r| r.entity_id == p.id)
    // rust: && let Some(id) = self.remote_effect_id(p.effect)
    // rust: {
    // rust: self.potions.effects.list.retain(|e| e.id != id);
}
}
    // rust: C::ChangeDifficulty(p) => {
    // rust: self.ui.difficulty = p.difficulty.clamp(0, 3) as u8;
    // rust: self.level.difficulty_locked = p.locked;
    // rust: self.remote_world_options_difficulty(self.ui.difficulty, p.locked);
}
    // rust: C::GameRuleValues(p) => self.remote_world_options_rules(p.entries),
            // ClientPacketListener.handleSetHealth: LocalPlayer.hurtTo.
    // rust: C::SetHealth(p) => {
    // rust: let flash = self.remote.as_mut().is_some_and(|r| {
    // rust: r.health = (p.health, p.food, p.saturation);
    // rust: std::mem::replace(&mut r.flash_on_set_health, true)
    // rust: });
    // rust: if flash && let Some(pl) = self.player.as_mut() {
    // rust: pl.health.flash_health_change(p.health);
}
    // rust: self.apply_remote_health();
                // The death screen opens (or the respawn is asked for) with the
                // death packet when the rule hides it.
    // rust: let shown = self.remote.as_ref().is_none_or(|r| r.show_death_screen);
    // rust: if p.health <= 0.0 && shown && self.screen != Screen::Dead && self.player.is_some()
    // rust: {
    // rust: self.close_dialogs();
    // rust: self.screen = Screen::Dead;
    // rust: self.ui.death_time = 0;
    // rust: self.ui.death_confirm = None;
    // rust: self.capture(false);
}
}
    // rust: C::PlayerCombatKill(p) => {
                // The component resolves in the client's current language, as
                // the chat line does, not in the language the session joined
                // with (`Remote.lang` is the vanilla server-language table).
    // rust: let message = remote_text(&p.message);
    // rust: let me = self.remote.as_ref().is_some_and(|r| r.entity_id == p.id);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.death_message = Some(message);
}
                // ClientPacketListener.handlePlayerCombatKill: the death
                // screen, whatever health was last sent, or `respawn()` at
                // once when it is hidden.
    // rust: if me && self.screen != Screen::Dead && self.player.is_some() {
    // rust: if self.remote.as_ref().is_none_or(|r| r.show_death_screen) {
    // rust: self.close_dialogs();
    // rust: self.screen = Screen::Dead;
    // rust: self.ui.death_time = 0;
    // rust: self.ui.death_confirm = None;
    // rust: self.capture(false);
    // rust: } else {
    // rust: self.respawn_player()?;
}
}
}
    // rust: C::TrackedWaypoint(p) => self.handle_waypoint(&p),
    // rust: C::SetExperience(p) => {
    // rust: self.experience = Experience {
    // rust: level: p.level,
    // rust: progress: p.progress,
    // rust: total: p.total,
}
}
            // ClientPacketListener.handleSetTime: the game time, then
            // ClientClockManager.handleUpdates: the clock catches up with the
            // game time and takes the server's state. Only this level's
            // default world clock is applied — a packet that only updates
            // another clock (the End's) must not overwrite day_time, or the
            // sky follows game_time and looks inverted vs the server's day.
    // rust: C::SetTime(p) => {
    // rust: self.world.game_time = p.game_time;
    // rust: self.remote_clock_tick();
    // rust: let clock = {
    // rust: let r = self.remote.as_ref();
    // rust: let names =
    // rust: r.and_then(|r| r.registries.registries.get("minecraft:world_clock"));
    // rust: let tracked = r.and_then(|r| r.clock);
    // rust: let wanted = r
    // rust: .and_then(|r| r.dimension.default_clock.clone())
    // rust: .or_else(|| r.map(|r| r.dimension.name.clone()))
    // rust: .unwrap_or_else(|| "minecraft:overworld".into());
    // rust: let name = |id: i32| {
    // rust: names
    // rust: .and_then(|n| n.get(id as usize))
    // rust: .map(|(n, _)| n.as_str())
}
    // rust: p.clocks
    // rust: .iter()
    // rust: .find(|c| name(c.clock) == Some(wanted.as_str()))
    // rust: .or_else(|| tracked.and_then(|id| p.clocks.iter().find(|c| c.clock == id)))
    // rust: .cloned()
}
    // rust: if let Some(c) = clock {
    // rust: self.world.day_time = c.total_ticks;
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.clock = Some(c.clock);
    // rust: r.clock_rate = c.rate;
    // rust: r.clock_partial = c.partial_tick;
}
}
}
    // rust: C::GameEvent(p) => match p.event {
                // NO_RESPAWN_BLOCK_AVAILABLE: ClientPacketListener.handleGameEvent
                // sends the player this system message.
    // rust: 0 => self.system_message(horizon_client::text::Text::translate(
    // rust: "block.minecraft.spawn.not_valid",
    // rust: &[],
    // rust: )),
                // LEVEL_CHUNKS_LOAD_START: the server has begun sending the level.
    // rust: 13 => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.level_load.loading_packets_received();
}
}
                // GUARDIAN_ELDER_EFFECT: the apparition, and the curse sound
                // unless the elder guardian is silent.
    // rust: 10 => {
    // rust: self.creatures.elder_apparition = super::mob_blocks::APPARITION_TICKS;
    // rust: if p.param == 1.0
    // rust: && let Some(at) = self.player.as_ref().map(|m| m.position)
    // rust: {
    // rust: self.audio.play(
    // rust: "minecraft:entity.elder_guardian.curse",
    // rust: Some([at.x, at.y, at.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
}
                // WIN_GAME: the poem and credits, then PERFORM_RESPAWN.
    // rust: 4 if self.screen != Screen::Win => {
    // rust: self.open_win_screen(true, super::win::Finish::RemoteRespawn);
}
    // rust: 1 => {
    // rust: self.world.weather.raining = true;
    // rust: self.world.weather.rain_level = (0.0, 0.0);
}
    // rust: 2 => {
    // rust: self.world.weather.raining = false;
    // rust: self.world.weather.rain_level = (1.0, 1.0);
}
    // rust: 3 => {
    // rust: let mode = p.param as i32;
    // rust: self.set_mode_id(mode);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.game_mode = mode;
}
}
                // IMMEDIATE_RESPAWN: LocalPlayer.setShowDeathScreen.
    // rust: 11 => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.show_death_screen = p.param == 0.0;
}
}
                // PLAY_ARROW_HIT_SOUND: ClientPacketListener.handleGameEvent
                // plays ARROW_HIT_PLAYER at player eye height.
    // rust: 6 => {
    // rust: if let Some(at) = self.eye_position() {
    // rust: self.audio
    // rust: .play("minecraft:entity.arrow.hit_player", Some(at), 0.18, 0.45);
}
}
                // RAIN_LEVEL_CHANGE: ClientPacketListener.handleGameEvent.
    // rust: 7 => {
    // rust: self.world.weather.rain_level = (p.param, p.param);
    // rust: self.world.weather.raining = p.param > 0.0;
}
                // THUNDER_LEVEL_CHANGE: ClientPacketListener.handleGameEvent.
    // rust: 8 => {
    // rust: self.world.weather.thunder_level = (p.param, p.param);
    // rust: self.world.weather.thundering = p.param > 0.0;
}
                // PUFFER_FISH_STING: ClientPacketListener.handleGameEvent
                // plays PUFFER_FISH_STING at player position.
    // rust: 9 => {
    // rust: if let Some(at) = self.player.as_ref().map(|m| m.position) {
    // rust: self.audio.play(
    // rust: "minecraft:entity.puffer_fish.sting",
    // rust: Some([at.x, at.y, at.z]),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
}
                // LIMITED_CRAFTING: LocalPlayer.setDoLimitedCrafting.
    // rust: 12 => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.do_limited_crafting = p.param == 1.0;
}
}
    // rust: _ => {}
    // rust: },
    // rust: C::PlayerAbilities(p) => {
    // rust: self.creative = p.flags & 8 != 0;
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.abilities = Some(p);
}
    // rust: self.apply_remote_abilities();
}
            // ClientPacketListener.handleSetHeldSlot: a hotbar slot only, and the
            // carried index stays, so the next tick answers with SetCarriedItem.
    // rust: C::SetHeldSlot(p) => {
    // rust: if (0..9).contains(&p.slot) {
    // rust: self.selected = p.slot as usize;
}
}
    // rust: C::ContainerSetContent(p) => {
    // rust: self.remote_menu_state(p.container, p.state);
    // rust: for (slot, item) in p.items.iter().enumerate() {
    // rust: let stack = self.to_stack(item);
    // rust: self.set_menu_slot(p.container, slot as i32, stack);
}
    // rust: self.carried = self.to_stack(&p.carried);
    // rust: self.remote_synced();
}
    // rust: C::ContainerSetSlot(p) => {
    // rust: self.remote_menu_state(p.container, p.state);
    // rust: let stack = self.to_stack(&p.item);
    // rust: self.tutorial_get_item(stack.as_ref());
                // ClientPacketListener.handleContainerSetSlot: a hotbar slot that
                // gains items squeezes for 5 ticks.
    // rust: if p.container == 0
    // rust: && (36..=45).contains(&p.slot)
    // rust: && let Some(new) = &stack
    // rust: {
    // rust: let (pop, old) = match p.slot {
    // rust: 45 => (9, self.offhand.as_ref()),
    // rust: s => (s as usize - 36, self.inventory[s as usize - 36].as_ref()),
}
    // rust: if old.is_none_or(|old| old.count < new.count) {
    // rust: self.hotbar_pop[pop] = 5;
}
}
    // rust: let before = self.creative_stacks();
    // rust: self.set_menu_slot(p.container, i32::from(p.slot), stack);
    // rust: self.remote_synced_since(&before);
}
    // rust: C::SetCursorItem(p) => {
    // rust: let stack = self.to_stack(&p.item);
    // rust: self.tutorial_get_item(stack.as_ref());
    // rust: self.carried = stack;
}
    // rust: C::SetPlayerInventory(p) => {
    // rust: let stack = self.to_stack(&p.item);
    // rust: self.tutorial_get_item(stack.as_ref());
    // rust: let before = self.creative_stacks();
    // rust: let held = match p.slot {
    // rust: 0..=35 => self.inventory[p.slot as usize].as_ref(),
    // rust: 40 => self.offhand.as_ref(),
    // rust: _ => None,
}
    // rust: let changed = !super::hand::matches_for_swap(held, stack.as_ref());
    // rust: if let Ok(slot) = usize::try_from(p.slot) {
    // rust: self.remote_hand_slot_set(slot, changed);
}
    // rust: match p.slot {
    // rust: 0..=35 => self.inventory[p.slot as usize] = stack,
    // rust: 36..=39 => self.armor[3 - (p.slot - 36) as usize] = stack,
                    // Inventory.SLOT_OFFHAND.
    // rust: 40 => self.offhand = stack,
    // rust: _ => {}
}
    // rust: self.remote_synced_since(&before);
}
    // rust: C::ContainerSetData(p) if self.open_menu_name(p.container) == "minecraft:lectern" => {
    // rust: self.remote_lectern_page(i32::from(p.value));
}
    // rust: C::ContainerSetData(p) if self.remote_station_open(p.container) => {
    // rust: self.remote_station_data(usize::try_from(p.id).unwrap_or(usize::MAX), p.value);
}
    // rust: C::ContainerSetData(p) if self.native_screen_data(p.container, p.id, p.value) => {}
    // rust: C::ContainerSetData(p) => {
    // rust: let v = i32::from(p.value);
    // rust: match self
    // rust: .container
    // rust: .and_then(|key| self.world.block_entities.get_mut(&key))
    // rust: {
    // rust: Some(BlockEntity::Furnace(f)) => match p.id {
    // rust: 0 => f.lit_remaining = v,
    // rust: 1 => f.lit_total = v,
    // rust: 2 => f.cooking_timer = v,
    // rust: 3 => f.cooking_total = v,
    // rust: _ => {}
    // rust: },
                    // CrafterBlockEntity.containerData.
    // rust: Some(BlockEntity::Crafter(c)) => match usize::try_from(p.id) {
    // rust: Ok(k @ 0..9) => c.disabled[k] = v == 1,
    // rust: Ok(9) => c.triggered = v == 1,
    // rust: _ => {}
    // rust: },
                    // BrewingStandBlockEntity.dataAccess.
    // rust: Some(BlockEntity::Brewing(b)) => match p.id {
    // rust: 0 => b.brew_time = v,
    // rust: 1 => b.fuel = v,
    // rust: 2 => b.total_brew_time = v,
    // rust: 3 => b.total_fuel = v,
    // rust: _ => {}
    // rust: },
    // rust: _ => {}
}
}
    // rust: C::OpenScreen(p) => self.remote_open_screen(p),
    // rust: C::MountScreenOpen(p) => self.remote_open_mount(p),
    // rust: C::RecipeBookAdd(p) => self.remote_recipe_book_add(p),
    // rust: C::RecipeBookRemove(p) => self.remote_recipe_book_remove(p),
    // rust: C::RecipeBookSettings(p) => self.remote_recipe_book_settings(p),
    // rust: C::PlaceGhostRecipe(p) => self.remote_ghost_recipe(p),
    // rust: C::MerchantOffers(p) => self.remote_merchant_offers(p),
    // rust: C::ContainerClose(_) => {
                // `LocalPlayer.clientSideCloseContainer` sets the screen to
                // null, including dialogs and WaitingForResponseScreen. This
                // differs from clearDialog, which restores the parent screen.
    // rust: let dialog = self.dialog_open();
    // rust: if dialog {
    // rust: self.close_dialogs();
    // rust: self.ui.chat_screen = None;
    // rust: self.book = None;
    // rust: self.sign_edit = None;
}
    // rust: if !self.remote_lectern_closed() && (self.screen == Screen::Inventory || dialog) {
    // rust: self.remote_close_local();
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
}
    // rust: C::TagQuery(p) => self.answer_tag_query(p.transaction, p.tag),
    // rust: C::Unknown(id, data)
    // rust: if id == horizon_protocol::ids::play::clientbound::COMMAND_SUGGESTIONS =>
    // rust: {
    // rust: self.handle_command_suggestions(&data);
}
    // rust: C::CustomChatCompletions(p) => {
                // ClientPacketListener.handleCustomChatCompletions.
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: horizon_client::command::modify_custom_completions(
    // rust: &mut r.custom_completions,
    // rust: horizon_client::command::CustomCompletionAction::from_id(p.action),
    // rust: &p.entries,
    // rust: );
    // rust: self.ui.registries.custom_completions = r.custom_completions.clone();
}
}
    // rust: C::Commands(p) => {
    // rust: let tree = horizon_client::command::network::from_packet(
    // rust: &p,
    // rust: horizon_client::command::vanilla::dispatcher(),
    // rust: );
                // The chat's tree follows the server's now; a mod's commands
                // go into it again (`chat_tree_for`).
    // rust: let chat_tree = self.chat_tree_for(Some(&tree));
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.chat_tree = chat_tree;
    // rust: r.chat_tree_received = true;
}
}
    // rust: C::Cooldown(p) => {
                // ClientPacketListener.handleItemCooldown: the server starts
                // (or confirms) a group's cooldown; 0 ends it.
    // rust: let group: Arc<str> = Arc::from(p.group.as_str());
    // rust: if p.duration == 0 {
    // rust: self.cooldowns.remove(&group);
    // rust: } else {
    // rust: self.cooldowns.add(group, p.duration);
}
}
            // ClientPacketListener.handleGameTestHighlightPos.
    // rust: C::GameTestHighlightPos(p) => self.highlight_test_pos(p.absolute, p.relative),
            // ClientPacketListener.handleTestInstanceBlockStatus.
    // rust: C::TestInstanceBlockStatus(p) => {
    // rust: self.block_editor_status(remote_text(&p.status), p.size);
}
    // rust: C::SystemChat(p) => {
                // The component as sent, translated in the client's own
                // language; mods may change or cancel it. ChatListener.handleOverlay
                // for the action bar.
    // rust: let mut text = remote_text(&p.content);
    // rust: if !self.chat_received(true, p.overlay, 0, None, &mut text) {
    // rust: return Ok(());
}
    // rust: if p.overlay {
    // rust: self.say_system_queued(&text);
    // rust: self.titles.set_overlay(text, false);
    // rust: } else if self.chat_line(text.clone(), horizon_client::chat::ChatSource::Server) {
                    // handleSystemMessage: said once the chat takes it.
    // rust: self.say_system_chat_queued(&text);
}
}
    // rust: C::PlayerChat(p) => {
//                 use horizon_client::scoreboard::tag_to_json;
                // SignedMessageBody.Packed.unpack: the last seen it names must
                // be in the cache; then the message joins it
                // (MessageSignatureCache.push).
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return Ok(());
}
                // handlePlayerChat: the global index counts every chat packet; one out of
                // order disconnects.
    // rust: let expected = r.next_chat_index;
    // rust: r.next_chat_index = r.next_chat_index.wrapping_add(1);
    // rust: if p.global_index != expected {
    // rust: log::error!(
    // rust: "Missing or out-of-order chat message from server, expected index {expected} but got {}",
    // rust: p.global_index
    // rust: );
    // rust: let reason = horizon_client::text::Text::translate(
    // rust: "multiplayer.disconnect.bad_chat_index",
    // rust: &[],
    // rust: );
    // rust: return self.leave_server(Some(reason.plain()));
}
    // rust: let last_seen: Option<Vec<Signature>> =
    // rust: p.last_seen.iter().map(|s| r.signatures.unpack(s)).collect();
    // rust: let Some(last_seen) = last_seen else {
    // rust: log::error!(
    // rust: "Message from player with ID {:032x} referenced unrecognized signature id",
    // rust: p.sender
    // rust: );
    // rust: let reason = horizon_client::text::Text::translate(
    // rust: "multiplayer.disconnect.invalid_packet",
    // rust: &[],
    // rust: );
    // rust: return self.leave_server(Some(reason.plain()));
}
    // rust: let signature = p
    // rust: .signature
    // rust: .as_deref()
    // rust: .and_then(horizon_protocol::secure_chat::signature);
    // rust: r.signatures.push(&last_seen, signature.as_ref());
                // The sender's PlayerInfo: none is an error line; else their
                // `SignedMessageValidator` decides (`updateAndValidate`), and a message it
                // takes without a signature of its own shows as unsigned.
    // rust: if !r.tab_players.contains_key(&p.sender) {
    // rust: log::error!(
    // rust: "Received player chat packet for unknown player with ID: {:032x}",
    // rust: p.sender
    // rust: );
    // rust: self.handle_chat_message_error(&p.chat_type, signature.as_ref());
    // rust: return Ok(());
}
    // rust: let now = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64);
    // rust: let incoming = secure_chat::Incoming {
    // rust: sender: p.sender,
    // rust: index: p.index,
    // rust: signature: signature.as_ref(),
    // rust: body: secure_chat::Body {
    // rust: content: &p.content,
    // rust: timestamp: p.timestamp,
    // rust: salt: p.salt,
    // rust: last_seen: &last_seen,
    // rust: },
    // rust: unsigned_content: p.unsigned_content.as_ref(),
    // rust: filter: &p.filter,
}
    // rust: let Some(validated) = r.validate_chat(&incoming, now) else {
    // rust: self.handle_chat_message_error(&p.chat_type, signature.as_ref());
    // rust: return Ok(());
}
    // rust: let signature = signature.filter(|_| validated == secure_chat::Validated::Signed);
                // ChatListener.handlePlayerChatMessage: Only Show Secure Chat
                // shows the signed content, never the server's replacement.
                // The narrator says the message's own decorated content
                // (`narrateChatMessage(boundChatType, message.decoratedContent())`).
    // rust: let decorated = p
    // rust: .unsigned_content
    // rust: .as_ref()
    // rust: .map_or_else(|| serde_json::Value::from(p.content.as_str()), tag_to_json);
    // rust: let content = if self.settings.file.bool("onlyShowSecureChat") {
    // rust: serde_json::Value::from(p.content.as_str())
    // rust: } else {
    // rust: decorated.clone()
}
    // rust: let narration = self
    // rust: .decorate_chat(&p.chat_type, &decorated, Decoration::Narration)
    // rust: .plain();
    // rust: let line = self.decorate_chat(&p.chat_type, &content, Decoration::Chat);
    // rust: let trust = self.chat_trust(
    // rust: p.sender,
    // rust: signature.is_some(),
    // rust: p.timestamp,
    // rust: &p.content,
    // rust: p.unsigned_content.as_ref(),
    // rust: &line,
    // rust: );
                // ChatListener.showMessageToPlayer: `Minecraft.isBlocked` hides the
                // message of a player hidden in the Social Interactions screen; it
                // counts as processed, not shown.
    // rust: if self.social_hides(p.sender) {
    // rust: if let Some(signature) = &signature {
    // rust: self.mark_message_processed(signature, false);
}
    // rust: return Ok(());
}
    // rust: self.handle_player_chat(QueuedChat {
    // rust: line,
    // rust: signature,
    // rust: trust,
    // rust: narration,
    // rust: sender: p.sender,
    // rust: chat_type: p.chat_type.chat_type,
    // rust: });
}
    // rust: C::DisguisedChat(p) => {
    // rust: let content = horizon_client::scoreboard::tag_to_json(&p.message);
    // rust: let narration = self
    // rust: .decorate_chat(&p.chat_type, &content, Decoration::Narration)
    // rust: .plain();
    // rust: let line = self.decorate_chat(&p.chat_type, &content, Decoration::Chat);
    // rust: self.handle_player_chat(QueuedChat {
    // rust: line,
    // rust: signature: None,
    // rust: trust: ChatTrust::Secure,
    // rust: narration,
    // rust: sender: 0,
    // rust: chat_type: p.chat_type.chat_type,
    // rust: });
}
    // rust: C::DeleteChat(p) => self.handle_delete_chat(&p.signature)?,
    // rust: C::PlayerInfoUpdate(p) => {
    // rust: if let Some(r) = self.remote.as_mut() {
                    // handlePlayerInfoUpdate: new entries first, then every
                    // action on every known entry.
                    // INITIALIZE_CHAT: the session (or none) each entry carries; the
                    // player's validator is made again when their chat is next read.
    // rust: if p.actions & 2 != 0 {
    // rust: for e in &p.entries {
    // rust: r.chat_sessions.insert(e.uuid, e.chat_session.clone());
    // rust: r.chat_validators.remove(&e.uuid);
}
}
    // rust: if p.actions & 1 != 0 {
    // rust: for e in &p.entries {
    // rust: if let Some(name) = &e.name {
    // rust: r.tab_players.entry(e.uuid).or_insert_with(|| {
    // rust: horizon_client::tab_list::TabPlayer::new(e.uuid, name.clone())
    // rust: });
    // rust: if let Some(t) = e.properties.iter().find(|p| p.name == "textures")
    // rust: {
                                    // Without the services' profile property keys a
                                    // signature can't be checked; a signed property
                                    // counts as genuine.
//                                     use horizon_client::skins::{self, Signature};
    // rust: let signature = if t.signature.is_some() {
    // rust: Signature::Signed
    // rust: } else {
    // rust: Signature::Unsigned
}
    // rust: let textures =
    // rust: skins::unpack(&t.value, signature, &skins::TEXTURE_URIS);
    // rust: r.skin_textures.entry(e.uuid).or_insert(textures);
}
}
}
}
    // rust: for e in p.entries {
    // rust: if let Some(t) = r.tab_players.get_mut(&e.uuid) {
    // rust: if let Some(mode) = e.game_mode {
    // rust: t.game_mode = mode;
}
    // rust: if let Some(latency) = e.latency {
    // rust: t.latency = latency;
}
    // rust: if let Some(name) = &e.display_name {
    // rust: t.display_name =
    // rust: name.as_ref().map(horizon_client::scoreboard::tag_to_json);
}
    // rust: if let Some(order) = e.list_order {
    // rust: t.list_order = order;
}
    // rust: if let Some(hat) = e.show_hat {
    // rust: t.show_hat = hat;
}
    // rust: match e.listed {
    // rust: Some(true) => {
    // rust: r.listed.insert(e.uuid);
}
    // rust: Some(false) => {
    // rust: r.listed.remove(&e.uuid);
}
    // rust: None => {}
}
}
    // rust: if let Some(name) = e.name {
    // rust: r.players.insert(e.uuid, name);
}
}
}
}
    // rust: C::PlayerInfoRemove(p) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: for u in p.uuids {
    // rust: r.players.remove(&u);
    // rust: r.tab_players.remove(&u);
    // rust: r.chat_sessions.remove(&u);
    // rust: r.chat_validators.remove(&u);
    // rust: r.skin_textures.remove(&u);
    // rust: r.listed.remove(&u);
    // rust: r.attachments.remove(&Holder::Player(u));
}
}
}
    // rust: C::TabList(p) => {
                // handleTabListCustomisation: empty text clears it.
    // rust: let text = |t: &Tag| {
    // rust: let json = horizon_client::scoreboard::tag_to_json(t);
    // rust: let text = horizon_client::scoreboard::comp_text(&json);
    // rust: text.spans
    // rust: .iter()
    // rust: .any(|span| !span.text.is_empty())
    // rust: .then_some(text)
}
    // rust: self.tab_list.header = text(&p.header);
    // rust: self.tab_list.footer = text(&p.footer);
}
    // rust: C::InitializeBorder(p) => {
    // rust: let b = &mut self.border;
    // rust: b.set_center([p.center_x, p.center_z]);
    // rust: if p.lerp_time > 0 {
    // rust: b.lerp_between(p.old_size, p.new_size, p.lerp_time);
    // rust: } else {
    // rust: b.set_size(p.new_size);
}
    // rust: b.set_absolute_max_size(p.absolute_max_size);
    // rust: b.warning_distance = p.warning_blocks;
    // rust: b.warning_time = p.warning_time;
}
    // rust: C::SetBorderCenter(p) => self.border.set_center([p.x, p.z]),
    // rust: C::SetBorderLerpSize(p) => {
    // rust: self.border
    // rust: .lerp_between(p.old_size, p.new_size, p.lerp_time)
}
    // rust: C::SetBorderSize(p) => self.border.set_size(p.size),
    // rust: C::SetBorderWarningDelay(p) => self.border.warning_time = p.delay,
    // rust: C::SetBorderWarningDistance(p) => self.border.warning_distance = p.blocks,
    // rust: C::SetObjective(p) => self.remote_objective(p),
    // rust: C::SetDisplayObjective(p) => {
                // DisplaySlot ids: list, sidebar, below_name, then the team sidebars.
    // rust: let slot = match p.slot {
    // rust: 0 => "list".to_owned(),
    // rust: 2 => "below_name".to_owned(),
    // rust: n @ 3..=18 => format!(
    // rust: "sidebar.team.{}",
    // rust: horizon_client::text::COLORS[(n - 3) as usize].1
    // rust: ),
    // rust: _ => "sidebar".to_owned(),
}
    // rust: let board = &mut self.score.board;
    // rust: let objective = board.objective(&p.objective).map(|o| o.name.clone());
    // rust: board.set_display_objective(&slot, objective.as_deref());
}
    // rust: C::SetScore(p) => {
    // rust: let board = &mut self.score.board;
    // rust: if board.objective(&p.objective).is_some() {
    // rust: let s = board.score_mut(&p.owner, &p.objective);
    // rust: s.value = p.score;
    // rust: s.display = p
    // rust: .display
    // rust: .as_ref()
    // rust: .map(horizon_client::scoreboard::tag_to_json);
    // rust: s.number_format = p.number_format.as_ref().map(number_format);
}
}
    // rust: C::ResetScore(p) => match &p.objective {
    // rust: Some(o) => self.score.board.reset_one(&p.owner, o),
    // rust: None => self.score.board.reset_all(&p.owner),
    // rust: },
    // rust: C::SetPlayerTeam(p) => self.remote_team(p),
    // rust: C::SetSimulationDistance(p) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.simulation_distance = p.distance;
}
}
    // rust: C::SetChunkCacheRadius(p) => {
    // rust: self.streaming.radius = self.settings.render_distance.min(p.distance + 1).max(2);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.view_distance = p.distance;
}
                // ClientChunkCache.updateViewRadius: a new storage of that size.
    // rust: self.drop_remote_chunks_out_of_range();
}
    // rust: C::SetChunkCacheCenter(p) => {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.chunk_center = (p.x, p.z);
}
    // rust: self.drop_remote_chunks_out_of_range();
}
    // rust: C::BlockEntityData(p) => self.remote_block_entity_data(p.pos, p.kind, &p.tag),
    // rust: C::OpenSignEditor(p) => self.remote_open_sign_editor(p),
    // rust: C::OpenBook(p) => self.remote_open_book(p.hand),
            // handleSetSpawn: ClientLevel.setRespawnData, which spawn compasses point at.
    // rust: C::SetDefaultSpawnPosition(p) => {
    // rust: let [x, y, z] = p.pos.pos;
    // rust: self.spawn = (p.pos.dimension == "minecraft:overworld")
    // rust: .then(|| Vec3::new(f64::from(x) + 0.5, f64::from(y), f64::from(z) + 0.5));
}
    // rust: C::ServerData(p) => self.remote_server_data(p.icon.as_deref()),
    // rust: C::MapItemData(p) => self.remote_map_item_data(&p),
            // handleTickingState / handleTickingStep: the level's TickRateManager.
    // rust: C::TickingState(p) => {
    // rust: self.clock.set_rate(p.rate);
    // rust: self.clock.set_frozen(p.frozen);
}
    // rust: C::TickingStep(p) => self.clock.set_frozen_ticks_to_run(p.steps),
    // rust: C::UpdateAdvancements(p) => {
    // rust: let icons = p
    // rust: .added
    // rust: .iter()
    // rust: .map(|a| {
    // rust: a.display
    // rust: .as_ref()
    // rust: .map_or_else(String::new, |d| self.item_name(d.icon.item).to_string())
    // rust: })
    // rust: .collect();
    // rust: self.remote_advancements(p, icons);
}
            // handleAwardStats: StatsCounter.setValue for each.
    // rust: C::AwardStats(p) => {
    // rust: let Some(r) = self.remote.as_ref() else {
    // rust: return Ok(());
}
    // rust: let mut known = Vec::new();
    // rust: for (ty, value, count) in p.stats {
    // rust: let Some(ty) = r
    // rust: .builtin
    // rust: .get("minecraft:stat_type")
    // rust: .and_then(|t| t.name(ty))
    // rust: else {
    // rust: continue;
}
    // rust: let values = match ty {
    // rust: "minecraft:mined" => "minecraft:block",
    // rust: "minecraft:killed" | "minecraft:killed_by" => "minecraft:entity_type",
    // rust: "minecraft:custom" => "minecraft:custom_stat",
    // rust: _ => "minecraft:item",
}
    // rust: if let Some(key) = r.builtin.get(values).and_then(|v| v.name(value)) {
    // rust: known.push((ty.to_owned(), key.to_owned(), count));
}
}
    // rust: for (ty, key, count) in known {
    // rust: self.stats.values.entry(ty).or_default().insert(key, count);
}
}
            // ClientPacketListener.setActionBarText, setTitleText,
            // setSubtitleText, setTitlesAnimation and handleTitlesClear.
    // rust: C::BossEvent(p) => self.apply_boss_event(&p),
    // rust: C::SetActionBarText(p) => self.titles.set_overlay(remote_text(&p.text), false),
    // rust: C::SetTitleText(p) => self.titles.set_title(remote_text(&p.text)),
    // rust: C::SetSubtitleText(p) => self.titles.set_subtitle(remote_text(&p.text)),
    // rust: C::SetTitlesAnimation(p) => self.titles.set_times(p.fade_in, p.stay, p.fade_out),
            // ClientCommonPacketListenerImpl.handleShowDialog / handleClearDialog.
    // rust: C::ShowDialog(p) => self.show_play_dialog(&p.dialog),
    // rust: C::ClearDialog(_) => self.clear_dialog(),
            // ClientPacketListener.handleLowDiskSpaceWarning.
    // rust: C::LowDiskSpaceWarning(_) => horizon_client::chunk_io::report_low_disk_space(),
    // rust: C::ClearTitles(p) => {
    // rust: self.titles.clear();
    // rust: if p.value {
    // rust: self.titles.reset_times();
}
}
    // rust: _ => {}
}
    // rust: Ok(())
}
    // `handleAddObjective`: add, remove or change an objective.
remote_objective :: proc(self: ^Self, p: play::SetObjective) {
}
//         use horizon_client::scoreboard::{RenderType, tag_to_json};
    // rust: let board = &mut self.score.board;
    // rust: match (p.method, p.display) {
    // rust: (1, _) => board.remove_objective(&p.name),
    // rust: (method, Some((name, render, format))) => {
    // rust: let render = if render == 1 {
    // rust: RenderType::Hearts
    // rust: } else {
    // rust: RenderType::Integer
}
    // rust: let format = format.as_ref().map(number_format);
    // rust: if method == 0 {
    // rust: board.add_objective(
    // rust: &p.name,
    // rust: "dummy",
    // rust: tag_to_json(&name),
    // rust: render,
    // rust: false,
    // rust: format,
    // rust: );
    // rust: } else if let Some(o) = board.objective_mut(&p.name) {
    // rust: o.display_name = tag_to_json(&name);
    // rust: o.render_type = render;
    // rust: o.number_format = format;
}
}
    // rust: _ => {}
}
}
    // `handleSetPlayerTeamPacket`.
remote_team :: proc(self: ^Self, p: play::SetPlayerTeam) {
}
//         use horizon_client::scoreboard::{CollisionRule, Visibility, tag_to_json};
    // rust: let board = &mut self.score.board;
    // rust: if p.method == 1 {
    // rust: board.remove_team(&p.name);
    // rust: return;
}
    // rust: if p.method == 0 {
    // rust: board.add_team(&p.name);
}
    // rust: if let Some(params) = &p.parameters
    // rust: && let Some(team) = board.team_mut(&p.name)
    // rust: {
    // rust: team.display_name = tag_to_json(&params.display_name);
    // rust: team.prefix = tag_to_json(&params.prefix);
    // rust: team.suffix = tag_to_json(&params.suffix);
    // rust: team.color = params
    // rust: .color
    // rust: .and_then(|c| horizon_client::text::COLORS.get(c as usize))
    // rust: .map(|c| c.1.to_owned());
    // rust: team.allow_friendly_fire = params.options & 1 != 0;
    // rust: team.see_friendly_invisibles = params.options & 2 != 0;
    // rust: team.nametag_visibility = Visibility::ALL
    // rust: .get(params.name_tag_visibility as usize)
    // rust: .copied()
    // rust: .unwrap_or(Visibility::Always);
    // rust: team.collision_rule = CollisionRule::ALL
    // rust: .get(params.collision_rule as usize)
    // rust: .copied()
    // rust: .unwrap_or(CollisionRule::Always);
}
    // rust: match p.method {
    // rust: 0 | 3 => {
    // rust: for player in &p.players {
    // rust: board.add_to_team(player, &p.name);
}
}
            // Scoreboard.removePlayerFromTeam: only out of this team (vanilla
            // throws for a player in another one).
    // rust: 4 => {
    // rust: for player in &p.players {
    // rust: if board.players_team(player).is_some_and(|t| t.name == p.name) {
    // rust: board.remove_from_team(player);
}
}
}
    // rust: _ => {}
}
}
    // The player list's view of the connection: the listed players (with
    // their downloaded skins once ready), online mode, and which players
    // are in the level with an upside-down name.
    // rust: pub(super) fn remote_tab_players(
    // rust: &mut self,
    // rust: ) -> Option<(Vec<horizon_client::tab_list::TabPlayer>, bool, Vec<u128>)> {
    // rust: self.update_remote_skins();
    // rust: let mut players: Vec<_> = {
    // rust: let r = self.remote.as_ref()?;
    // rust: r.listed
    // rust: .iter()
    // rust: .filter_map(|u| r.tab_players.get(u).cloned())
    // rust: .collect()
}
    // rust: for p in &mut players {
    // rust: p.skin = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.skins.get(&p.uuid).cloned())
    // rust: .unwrap_or_else(|| horizon_client::tab_list::default_skin(p.uuid).to_owned());
    // rust: self.gui
    // rust: .atlas
    // rust: .set_object_skin(format!("id:{:032x}", p.uuid), p.skin.clone());
    // rust: self.gui.atlas.set_object_skin(
    // rust: format!("name:{}", p.name.to_ascii_lowercase()),
    // rust: p.skin.clone(),
    // rust: );
}
    // rust: let r = self.remote.as_ref()?;
    // rust: let upside_down = players
    // rust: .iter()
    // rust: .filter(|p| {
    // rust: (p.name == "Dinnerbone" || p.name == "Grumm")
    // rust: && (p.uuid == r.profile || r.level_players.values().any(|u| *u == p.uuid))
    // rust: })
    // rust: .map(|p| p.uuid)
    // rust: .collect();
    // rust: Some((players, r.online_mode, upside_down))
}

    // Resolve inline `object:player` profiles through the same skin cache as
    // player heads on items. The next frame uses the uploaded atlas texture.
    // rust: pub(super) fn resolve_inline_profiles(&mut self, profiles: &[serde_json::Value]) {
//         use horizon_client::skins;
    // rust: for profile in profiles {
    // rust: let skin = skins::head_skin(
    // rust: profile,
    // rust: &mut self.skin_profiles.borrow_mut(),
    // rust: &mut self.skin_downloads.borrow_mut(),
    // rust: |location| self.gui.atlas.sprites.contains_key(location),
    // rust: );
    // rust: let id = skins::parse_profile(profile).id;
    // rust: let name = profile
    // rust: .as_str()
    // rust: .or_else(|| profile.get("name").and_then(serde_json::Value::as_str));
            // The player list's skin for the same profile is drawn too.
    // rust: let keys = [
    // rust: Some(format!("id:{id:032x}")),
    // rust: name.map(|n| format!("name:{}", n.to_ascii_lowercase())),
    // rust: ];
    // rust: for key in keys.iter().flatten() {
    // rust: if let Some(listed) = self.gui.atlas.object_skins.get(key)
    // rust: && listed.starts_with("skins/")
    // rust: {
    // rust: let listed = listed.clone();
    // rust: self.again_skin(&listed);
}
}
    // rust: self.gui
    // rust: .atlas
    // rust: .set_object_skin(format!("id:{id:032x}"), skin.clone());
    // rust: if let Some(name) = name {
    // rust: self.gui
    // rust: .atlas
    // rust: .set_object_skin(format!("name:{}", name.to_ascii_lowercase()), skin);
}
}
}
poll_own_profile :: proc(self: ^Self) {
}
    // rust: let auth = self.auth();
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: match &mut r.own_profile {
    // rust: OwnProfile::Idle => {
    // rust: let Some(auth) = auth else {
    // rust: r.own_profile = OwnProfile::Done(None);
    // rust: return;
}
    // rust: let (send, recv) = std::sync::mpsc::channel();
    // rust: std::thread::Builder::new()
    // rust: .name("Own profile".into())
    // rust: .spawn(move || {
    // rust: let _ = send.send(horizon_client::auth::own_textures(auth.as_ref()));
    // rust: })
    // rust: .ok();
    // rust: r.own_profile = OwnProfile::Fetching(recv);
}
    // rust: OwnProfile::Fetching(recv) => {
    // rust: if let Ok(own) = recv.try_recv() {
    // rust: r.own_profile = OwnProfile::Done(own);
}
}
    // rust: OwnProfile::Done(_) => {}
}
}
    // `PlayerInfo.getSkin` for every player entity, including NPCs that are
    // never in the tab list: resolve each profile's textures and give the
    // level's player models their skin.
    // The 3D skin layers model for a player (Options → Skin Customization,
    // `threeDSkinLayers`): `kind`'s outer layer with one slab per painted
    // texel, built once per (skin, slim) from the decoded image the skin
    // downloader still holds (`horizon_client::mobs::skin_layers`). `None`
    // while the option is off or the image is not in memory yet.
    // rust: fn skin_3d_model(
    // rust: &self,
    // rust: kind: &std::sync::Arc<horizon_client::mobs::MobType>,
    // rust: skin: &str,
    // rust: slim: bool,
    // rust: ) -> Option<std::sync::Arc<horizon_client::mobs::Part>> {
//         use horizon_client::mobs::skin_layers;
    // rust: if !self.settings.extras.three_d_skin_layers {
    // rust: return None;
}
    // rust: let key = (skin.to_owned(), slim);
    // rust: if let Some(model) = self.skin_3d.borrow_mut().get(&key) {
    // rust: return Some(model);
}
    // rust: let model_key = if slim { "player_slim#main" } else { "main" };
    // rust: let base = kind
    // rust: .layer(model_key)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| kind.model.clone());
    // rust: let image = self.skin_downloads.borrow().image(skin)?.to_vec();
    // rust: let model = std::sync::Arc::new(skin_layers::extrude(
    // rust: &base,
    // rust: &image,
    // rust: skin_layers::SIZE,
    // rust: skin_layers::DEPTH,
    // rust: )?);
    // rust: self.skin_3d.borrow_mut().insert(key, model.clone());
    // rust: Some(model)
}

    // rust: pub(super) fn update_remote_skins(&mut self) {
    // rust: let local = self.remote.as_ref().map(|r| r.profile);
    // rust: self.poll_own_profile();
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let local = local.unwrap_or(r.profile);
    // rust: let mut entries = skin_entries(
    // rust: &r.level_players,
    // rust: &r.skin_textures,
    // rust: &mut r.level_player_textures,
    // rust: );
    // rust: let own = match &r.own_profile {
    // rust: OwnProfile::Done(Some(t)) => Some(t.clone()),
    // rust: _ => None,
}
        // Minecraft.profileFuture: the signed-in account's active skin and cape
        // from `/minecraft/profile` when the server sent none (single player) or
        // only a skin without the equipped cape.
    // rust: if let Some(own) = own {
    // rust: if let Some((_, t)) = entries.iter_mut().find(|(u, _)| *u == local) {
    // rust: if t.skin.is_none() {
    // rust: t.skin = own.skin.clone();
    // rust: if own.skin.is_some() {
    // rust: t.slim = own.slim;
}
}
    // rust: if t.cape.is_none() {
    // rust: t.cape = own.cape.clone();
}
    // rust: } else if own.skin.is_some() || own.cape.is_some() {
    // rust: entries.retain(|(u, _)| *u != local);
    // rust: entries.push((local, own));
}
}
    // rust: let mut resolved: Vec<(u128, String)> = Vec::new();
        // PlayerSkin.model of each resolved skin: the textures' `slim`.
    // rust: let mut slim = std::collections::HashSet::new();
        // PlayerSkin.cape of each resolved skin.
    // rust: let mut capes: HashMap<u128, String> = HashMap::new();
    // rust: for (uuid, textures) in entries {
            // PlayerInfo.createSkinLookup: only the local player's own skin
            // may be unsigned.
    // rust: let skin = {
    // rust: let mut downloads = self.skin_downloads.borrow_mut();
    // rust: horizon_client::skins::lookup(&textures, uuid != local, |kind, url| {
    // rust: downloads.state(kind, url)
    // rust: })
}
    // rust: if let Some(skin) = skin {
    // rust: if textures.slim {
    // rust: slim.insert(uuid);
}
    // rust: if let Some(cape) = horizon_client::skins::cape(&textures) {
    // rust: capes.insert(uuid, cape);
}
    // rust: resolved.push((uuid, skin));
}
}
        // An offline name's skin from the launcher, where neither the server
        // nor an account gives the local player one.
    // rust: if !resolved.iter().any(|(u, _)| *u == local)
    // rust: && let Some((rgba, is_slim)) = horizon_client::skins::offline_skin()
    // rust: {
OFFLINE :: "horizon/offline_skin"
    // rust: if !self.skin_slots.contains(OFFLINE) || !self.gui.atlas.sprites.contains_key(OFFLINE) {
    // rust: self.store_skin(OFFLINE.into(), rgba.clone());
}
    // rust: if *is_slim {
    // rust: slim.insert(local);
}
    // rust: resolved.push((local, OFFLINE.into()));
}
        // An offline name's cape from the launcher, where the profile has none.
    // rust: if !capes.contains_key(&local)
    // rust: && let Some(rgba) = horizon_client::skins::offline_cape()
    // rust: {
OFFLINE :: "capes/offline"
    // rust: if !self.skin_slots.contains(OFFLINE) || !self.gui.atlas.sprites.contains_key(OFFLINE) {
    // rust: self.store_skin(OFFLINE.into(), rgba.to_vec());
}
    // rust: capes.insert(local, OFFLINE.into());
}
        // PlayerInfo.getSkin: the downloaded skin and its model, else the
        // profile's default skin (DefaultPlayerSkin.get), slim or wide.
    // rust: let skin_of = |skins: &HashMap<u128, String>, uuid: u128| match skins.get(&uuid) {
    // rust: Some(skin) => (skin.clone(), slim.contains(&uuid)),
    // rust: None => {
    // rust: let skin = horizon_client::tab_list::default_skin(uuid);
    // rust: (skin.to_owned(), skin.contains("/slim/"))
}
}
    // rust: let Some((level, skins, own)) = self.remote.as_mut().map(|r| {
    // rust: r.skins = resolved.into_iter().collect();
    // rust: (
    // rust: r.level_players
    // rust: .iter()
    // rust: .map(|(id, uuid)| (*id as u32, *uuid))
    // rust: .collect::<Vec<_>>(),
    // rust: r.skins.clone(),
    // rust: r.profile,
    // rust: )
    // rust: }) else {
    // rust: return;
}
        // Only the skins drawn hold atlas slots: the level's players, not
        // every entry of a busy server's player list.
    // rust: for (id, uuid) in level {
    // rust: let Some(i) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .position(|m| m.id == id && &*m.kind.id == "minecraft:player")
    // rust: else {
    // rust: continue;
}
    // rust: let (skin, is_slim) = self.drawn_skin(uuid, skin_of(&skins, uuid));
    // rust: let kind = self.mobs[i].kind.clone();
    // rust: let skin_3d = self.skin_3d_model(&kind, &skin, is_slim);
    // rust: let cape = capes.get(&uuid).filter(|c| self.again_skin(c)).cloned();
    // rust: let mob = &mut self.mobs[i];
    // rust: mob.skin = Some(skin);
    // rust: mob.slim = is_slim;
    // rust: mob.skin_3d = skin_3d;
    // rust: mob.cape = cape;
}
    // rust: if self.player_model.is_some() {
    // rust: let (skin, is_slim) = self.drawn_skin(own, skin_of(&skins, own));
            // Avatar.isModelPartShown(CAPE): the Skin Customization option.
    // rust: let cape = capes
    // rust: .get(&own)
    // rust: .filter(|_| self.settings.file.bool("modelPart_cape"))
    // rust: .filter(|c| self.again_skin(c))
    // rust: .cloned();
    // rust: let kind = self.player_model.as_ref().map(|m| m.kind.clone());
    // rust: let skin_3d = kind
    // rust: .as_ref()
    // rust: .and_then(|kind| self.skin_3d_model(kind, &skin, is_slim));
    // rust: if let Some(mob) = self.player_model.as_mut() {
    // rust: mob.skin = Some(skin);
    // rust: mob.slim = is_slim;
    // rust: mob.skin_3d = skin_3d;
    // rust: mob.cape = cape;
}
}
        // ClientMannequin.updateSkin (PlayerSkinRenderCache.lookup): a
        // mannequin's DATA_PROFILE `textures` property resolves like a
        // player's, never required to be signed.
    // rust: let mannequins: Vec<(u32, horizon_client::skins::Textures)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| &*m.kind.id == "minecraft:mannequin" && m.profile.is_some())
    // rust: .map(|m| {
    // rust: let profile = m.profile.as_ref();
    // rust: let t = profile.and_then(|p| p.properties.iter().find(|p| p.name == "textures"));
    // rust: let textures = if let Some(t) = t {
    // rust: let signature = if t.signature.is_some() {
    // rust: horizon_client::skins::Signature::Signed
    // rust: } else {
    // rust: horizon_client::skins::Signature::Unsigned
}
    // rust: horizon_client::skins::unpack(
    // rust: &t.value,
    // rust: signature,
    // rust: &horizon_client::skins::TEXTURE_URIS,
    // rust: )
    // rust: } else {
                    // `ResolvableProfile.resolveProfile`: no `textures` and
                    // only a name or an id resolves through the services.
    // rust: let key = profile.and_then(|p| match (&p.name, p.uuid) {
    // rust: (Some(name), None) => {
    // rust: Some(horizon_client::skins::NameOrId::Name(name.clone()))
}
    // rust: (None, Some(id)) => Some(horizon_client::skins::NameOrId::Id(id)),
    // rust: _ => None,
    // rust: });
    // rust: key.and_then(|key| match self.skin_profiles.borrow_mut().state(&key) {
    // rust: horizon_client::skins::Resolve::Done(Some(profile)) => {
    // rust: profile.textures().map(|(value, signature)| {
    // rust: horizon_client::skins::unpack(
    // rust: &value,
    // rust: signature,
    // rust: &horizon_client::skins::TEXTURE_URIS,
    // rust: )
    // rust: })
}
    // rust: _ => None,
    // rust: })
    // rust: .unwrap_or_default()
}
    // rust: (m.id, textures)
    // rust: })
    // rust: .collect();
    // rust: let mut resolved: Vec<(u32, Option<String>, bool)> = Vec::new();
    // rust: for (id, textures) in mannequins {
    // rust: let skin = {
    // rust: let mut downloads = self.skin_downloads.borrow_mut();
    // rust: horizon_client::skins::lookup(&textures, false, |kind, url| {
    // rust: downloads.state(kind, url)
    // rust: })
}
    // rust: let slim = skin.is_some() && textures.slim;
    // rust: resolved.push((id, skin, slim));
}
    // rust: for (id, skin, slim) in resolved {
    // rust: let skin = skin.filter(|s| !s.starts_with("skins/") || self.again_skin(s));
    // rust: if let Some(mob) = self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .find(|m| m.id == id && &*m.kind.id == "minecraft:mannequin")
    // rust: {
    // rust: mob.slim = slim && skin.is_some();
    // rust: mob.skin = skin;
}
}
}
    // Puts a downloaded skin in an atlas skin slot (`SkinSlots::place`),
    // unless every slot holds a skin drawn in the last frame.
    // rust: pub(super) fn store_skin(&mut self, location: String, rgba: Vec<u8>) {
        // 3D skin layers reads the pixels back when it builds the slabs.
    // rust: self.skin_downloads
    // rust: .borrow_mut()
    // rust: .remember_image(&location, &rgba);
    // rust: let Some((slot, evicted)) = self.skin_slots.place(location.clone()) else {
    // rust: return;
}
    // rust: if let Some(old) = evicted {
    // rust: self.gui.atlas.sprites.remove(&old);
}
    // rust: let Some(mut rect) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get(&format!("horizon/skin{slot}"))
    // rust: .copied()
    // rust: else {
    // rust: return;
}
    // rust: let (w, h) = (self.gui.atlas.width as f32, self.gui.atlas.height as f32);
    // rust: self.map_patches.push(horizon_client::font::Patch {
    // rust: x: (rect.u0 * w).round() as u32,
    // rust: y: (rect.v0 * h).round() as u32,
    // rust: width: 64,
    // rust: height: 64,
    // rust: rgba,
    // rust: });
        // A cape is a 64x32 texture in the top half of the slot (skins::process_cape).
    // rust: if location.starts_with("capes/") {
    // rust: rect.v1 = (rect.v0 + rect.v1) / 2.0;
}
    // rust: self.gui.atlas.sprites.insert(location, rect);
}
    // Whether a downloaded skin or cape is in the atlas to draw, marking it
    // drawn; if not (new, or its slot taken), its image is queued for upload
    // again and it is drawn from the next frame.
again_skin :: proc(self: ^Self, location: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut downloads = self.skin_downloads.borrow_mut();
        // A slot without its sprite (the atlas was rebuilt, or the upload
        // never happened) counts as missing, so the skin is stored again.
    // rust: if self.skin_slots.contains(location) && self.gui.atlas.sprites.contains_key(location) {
    // rust: downloads.drawn(location);
    // rust: true
    // rust: } else {
    // rust: downloads.again(location);
    // rust: false
}
}
    // A player's skin and model as drawn: the downloaded skin once it is in
    // the atlas, until then the profile's default (`DefaultPlayerSkin.get`),
    // as `PlayerInfo.getSkin` gives before the texture has loaded.
    // rust: pub(super) fn drawn_skin(
    // rust: &mut self,
    // rust: uuid: u128,
    // rust: (skin, slim): (String, bool),
    // rust: ) -> (String, bool) {
    // rust: if (skin.starts_with("skins/") || skin == "horizon/offline_skin") && !self.again_skin(&skin)
    // rust: {
    // rust: let skin = horizon_client::tab_list::default_skin(uuid);
    // rust: return (skin.to_owned(), skin.contains("/slim/"));
}
    // rust: (skin, slim)
}
    // `drawn_skin` for a face in the player list or spectator menu.
    // rust: pub(super) fn face_skin(&mut self, uuid: u128, skin: &str) -> String {
    // rust: self.drawn_skin(uuid, (skin.to_owned(), false)).0
}
    // ChatType.Bound.decorate (`Decoration::Chat`) and `decorateNarration`
    // (`Decoration::Narration`): the chat type's decoration from the
    // server's registry, applied to `content`.
    // rust: fn decorate_chat(
    // rust: &self,
    // rust: bound: &play::ChatTypeBound,
    // rust: content: &serde_json::Value,
    // rust: decoration: Decoration,
    // rust: ) -> horizon_client::text::Text {
//         use horizon_client::scoreboard::comp_text;
    // rust: let Some(r) = self.remote.as_ref() else {
    // rust: return comp_text(content);
}
    // rust: let chat_type = r.registries.data("minecraft:chat_type", bound.chat_type);
    // rust: comp_text(&chat_type_decorate(chat_type, decoration, bound, content))
}
remote_item_data :: proc(self: ^Self, id: i32, stack: ^Maybe(Stack)) {
}
    // rust: let Some(stack) = self.to_stack(stack) else {
    // rust: return;
}
    // rust: let position = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .and_then(|r| r.pending_items.remove(&id));
    // rust: if let Some(item) = self.dropped.iter_mut().find(|d| d.id == id as u32) {
    // rust: item.stack = stack;
    // rust: return;
}
    // rust: let Some((p, velocity)) = position else {
    // rust: return;
}
    // rust: let at = Vec3::new(p[0], p[1], p[2]);
        // ItemEntity's constructor draws bobOffs from the item's own random.
    // rust: let bob_offset = horizon_client::mobs::entity_random(id as u32, at).next_float()
    // rust: * std::f32::consts::PI
    // rust: * 2.0;
    // rust: self.dropped.push(ItemEntity {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: false,
    // rust: health: 5,
    // rust: fire_ticks: 0,
    // rust: thrower: None,
    // rust: target: None,
    // rust: id: id as u32,
    // rust: stack,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity,
    // rust: on_ground: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: age: 0,
    // rust: pickup_delay: 0,
    // rust: bob_offset,
    // rust: ticks: 0,
    // rust: needs_sync: false,
    // rust: stuck: Vec3::ZERO,
    // rust: was_touching_water: false,
    // rust: });
}
    // `Entity.lerpMotion` (and `recreateFromPacket`'s motion) for the
    // entities whose own tick moves them on a client: dropped items, experience
    // orbs, falling blocks and primed TNT.
remote_motion :: proc(self: ^Self, id: i32, velocity: [f64; 3]) {
}
    // rust: self.remote_dragon_motion(id, velocity);
    // rust: let v = Vec3::new(velocity[0], velocity[1], velocity[2]);
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, id as u32) {
            // Squid.aiStep derives its body pitch and roll from network motion.
    // rust: m.velocity = v;
    // rust: } else if let Some(d) = self.dropped.iter_mut().find(|d| d.id == id as u32) {
    // rust: d.velocity = v;
    // rust: } else if let Some(f) = self.falling.iter_mut().find(|f| f.id == id as u32) {
    // rust: f.velocity = v;
    // rust: } else if let Some(t) = self.tnts.iter_mut().find(|t| t.id == id as u32) {
    // rust: t.velocity = v;
    // rust: } else if let Some(o) = self.orbs.iter_mut().find(|o| o.id == id as u32) {
    // rust: o.velocity = v;
    // rust: } else if let Some(c) = self.carts.iter_mut().find(|c| c.id == id as u32) {
    // rust: c.velocity = v;
    // rust: } else if let Some(p) = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter_mut()
    // rust: .find(|p| p.id == id as u32)
    // rust: {
    // rust: p.velocity = v;
    // rust: } else if let Some(b) = self.dragon_fireballs.iter_mut().find(|b| b.id == id as u32) {
    // rust: b.velocity = v;
    // rust: } else if let Some(t) = self.tridents.iter_mut().find(|t| t.id == id as u32) {
    // rust: t.velocity = v;
    // rust: } else if let Some(r) = self.rockets.iter_mut().find(|r| r.id == id as u32) {
    // rust: r.velocity = v;
    // rust: } else if self.remote_hook_motion(id as u32, v) {
    // rust: } else if let Some(p) = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .and_then(|r| r.pending_items.get_mut(&id))
    // rust: {
    // rust: p.1 = v;
    // rust: } else if !self.potions.remote_thrown_motion(id as u32, v) {
    // rust: self.end.remote_eye_motion(id as u32, velocity);
}
}
apply_remote_health :: proc(self: ^Self) {
}
    // rust: let Some((health, food, saturation)) = self.remote.as_ref().map(|r| r.health) else {
    // rust: return;
}
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: if (p.health.health() - health).abs() > f32::EPSILON {
    // rust: let _ = p.set_health(health.max(0.0), false);
}
    // rust: p.health.food.food = food;
    // rust: p.health.food.saturation = saturation;
}
}
    // `ServerPlayer.dismountTo` lands a rider at the ghast's own (x, maxY, z)
    // (`HappyGhast.getDismountLocationForPassenger`). A vanilla client
    // simulates the ghast it rides, so its copy is where the server has it;
    // this window's copy trails the server's by the stepped interpolation and
    // would rise into the rider's feet, which lets the rider fall through.
    // Put the copy under the landing spot.
place_ghast_under :: proc(self: ^Self, id: u32, spot: Vec3) {
}
    // rust: let Some(m) = self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .find(|m| m.id == id && m.species() == horizon_client::mobs::Species::HappyGhast)
    // rust: else {
    // rust: return;
}
    // rust: let at = Vec3::new(spot.x, spot.y - f64::from(m.height()), spot.z);
        // Only a teleport that is that dismount: right above the ghast.
    // rust: if (at.x - m.position.x).powi(2) + (at.z - m.position.z).powi(2) > 25.0
    // rust: || (at.y - m.position.y).abs() > 5.0
    // rust: {
    // rust: return;
}
    // rust: m.position = at;
    // rust: m.previous = at;
    // rust: if let Some(handler) = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .and_then(|r| r.stepped.get_mut(&(id as i32)))
    // rust: {
    // rust: handler.cancel();
}
}
    // `ClientPacketListener.handleLookAt`: `Entity.lookAt` from this
    // player's feet or eyes, towards the packet's entity (its feet or eyes)
    // when this client tracks it, else towards the packet's point.
remote_look_at :: proc(self: ^Self, p: ^play::PlayerLookAt) {
}
        // `EntityAnchorArgument.Anchor`: 0 feet, 1 eyes.
EYES :: 1
    // rust: let Some(player) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let mut from = [player.position.x, player.position.y, player.position.z];
    // rust: if p.from == EYES {
    // rust: from[1] += f64::from(player.dimensions.eye_height);
}
    // rust: let to = p
    // rust: .entity
    // rust: .as_ref()
    // rust: .and_then(|e| {
    // rust: let m = self.mobs.iter().find(|m| m.id == e.id as u32)?;
    // rust: let y = if e.anchor == EYES {
    // rust: m.eye_y()
    // rust: } else {
    // rust: m.position.y
}
    // rust: Some([m.position.x, y, m.position.z])
    // rust: })
    // rust: .unwrap_or(p.target);
    // rust: (self.yaw, self.pitch) = look_at_rotation(from, to);
}
    // ClientPacketListener.handleMovePlayer.
remote_teleport :: proc(self: ^Self, p: ^play::PlayerPosition) -> R {
    // Ported from Horizon
    return {}
}
//         use play::relative as rel;
    // rust: let current = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|pl| pl.position)
    // rust: .unwrap_or(Vec3::ZERO);
    // rust: let velocity = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|pl| pl.velocity)
    // rust: .unwrap_or(Vec3::ZERO);
    // rust: let pick = |bit: i32, base: f64, v: f64| if p.relatives & bit != 0 { base + v } else { v };
    // rust: let position = Vec3::new(
    // rust: pick(rel::X, current.x, p.position[0]),
    // rust: pick(rel::Y, current.y, p.position[1]),
    // rust: pick(rel::Z, current.z, p.position[2]),
    // rust: );
    // rust: let yaw = if p.relatives & rel::Y_ROT != 0 {
    // rust: self.yaw + p.yaw
    // rust: } else {
    // rust: p.yaw
}
    // rust: let relative_pitch = p.relatives & rel::X_ROT != 0;
    // rust: let pitch = position_packet_pitch(self.pitch, p.pitch, relative_pitch);
    // rust: let delta = horizon_client::player_sync::teleport_velocity(
    // rust: velocity,
    // rust: (self.yaw, self.pitch),
    // rust: (yaw, pitch),
    // rust: p,
    // rust: );
    // rust: match self.player.as_mut() {
    // rust: Some(player) => {
    // rust: player.position = position;
    // rust: player.velocity = delta;
}
    // rust: None => {
    // rust: let mut player = PlayerMotion::new(self.motion, position)?;
                // Player.tick derives noPhysics from the current game mode.
    // rust: player.spectator = self.spectator();
    // rust: player.velocity = delta;
    // rust: self.player = Some(player);
    // rust: self.pad.player_replaced();
    // rust: self.sway = Default::default();
    // rust: self.eye = 1.62;
    // rust: self.previous_eye = 1.62;
    // rust: self.clock.reset();
    // rust: self.apply_remote_health();
    // rust: self.apply_remote_abilities();
}
}
    // rust: self.previous_position = position;
    // rust: self.yaw = yaw;
    // rust: self.pitch = pitch;
        // setValuesFromPositionPacket: setOldPosAndRot gives xRotO the same
        // change, so a relative pitch keeps the model's ease and an absolute
        // one snaps it.
    // rust: if let Some(m) = self.player_model.as_mut() {
    // rust: m.previous_head_pitch =
    // rust: position_packet_pitch(m.previous_head_pitch, p.pitch, relative_pitch);
    // rust: m.head_pitch = pitch;
}
    // rust: if let Some(id) = self.remote.as_mut().and_then(|r| r.ghast_dismount.take()) {
    // rust: self.place_ghast_under(id, position);
}
        // handleMovePlayer does not change LocalPlayer.sendPosition's baseline:
        // the next tick must still report the corrected state.
    // rust: self.send(S::AcceptTeleportation(play::AcceptTeleportation {
    // rust: id: p.teleport,
    // rust: x: position.x,
    // rust: y: position.y,
    // rust: z: position.z,
    // rust: yaw,
    // rust: pitch,
    // rust: }));
        // Then MultiPlayerGameMode.stopDestroyBlock: a dig the teleport (an
        // anticheat's setback, a /tp) interrupts is aborted on the wire, and the
        // attack strength starts again.
    // rust: self.stop_remote_mining();
    // rust: self.mining = None;
    // rust: Ok(())
}

    // `ClientPacketListener.tick`'s `LevelLoadTracker.tickClientLoad`: the
    // player's section is shown once its column is lit; when the level is
    // ready the loading screen closes and the server hears `PlayerLoaded`
    // (`notifyPlayerLoaded`).
tick_client_load :: proc(self: ^Self) {
}
    // rust: let Some(player) = self.player.as_ref() else {
    // rust: return;
}
    // rust: if !self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.level_load.is_active())
    // rust: {
    // rust: return;
}
        // `LevelRenderer`'s playerCompiledSectionCallback: the section holding
        // the camera is there (the column is lit, as meshing needs).
    // rust: let (cx, cz) = (
    // rust: (player.position.x.floor() as i32) >> 4,
    // rust: (player.position.z.floor() as i32) >> 4,
    // rust: );
    // rust: let section_ready = self.streaming.is_lit(cx, cz);
    // rust: let camera_y = (player.position.y + f64::from(self.eye)).floor() as i32;
    // rust: let shape = self.world.shape;
    // rust: let check = horizon_client::level_loading::PlayerCheck {
    // rust: outside_build_height: camera_y < shape.min_y || camera_y >= shape.min_y + shape.height,
    // rust: spectator: player.spectator,
    // rust: alive: player.health.health() > 0.0,
}
    // rust: let now = client_millis();
        // LevelLoadingScreen.tick.
    // rust: self.tick_load_progress();
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: if section_ready && r.level_load.wants_player_section() {
    // rust: r.level_load.player_section_ready();
}
    // rust: r.level_load.tick_client_load(now, check);
    // rust: if !r.level_load.is_level_ready(now) {
    // rust: return;
}
    // rust: r.level_load.finish();
    // rust: if !r.loaded_sent {
    // rust: r.loaded_sent = true;
    // rust: self.send(S::PlayerLoaded(Empty));
}
        // LevelLoadingScreen.onClose.
    // rust: self.say_system_now(&horizon_client::text::Text::translate(
    // rust: "narrator.ready_to_play",
    // rust: &[],
    // rust: ));
    // rust: self.capture_loaded_world();
}

    // One client tick while connected (Minecraft.tick with a ClientLevel).
    // rust: pub(super) fn tick_remote(&mut self) -> Result<()> {
    // rust: self.tick_remote_level()?;
        // The rockets boosting this player tick after it, also while it waits
        // for chunks.
    // rust: self.tick_own_rockets();
        // Client mods tick on any server, single player's own included.
    // rust: self.native_net.to_server = 0;
    // rust: self.native_tick();
    // rust: self.tell_native_now();
        // Far tiles the samplers asked for (`lod_net`).
    // rust: if let Some(r) = &self.remote {
    // rust: r.session.send_far_terrain();
}
    // rust: self.tick_chat_session();
        // Minecraft.tick sends this even when the player cannot tick yet,
        // including while waiting for chunks. Keep it outside early returns.
    // rust: if self.remote.as_ref().is_some_and(Remote::has_level) {
    // rust: self.send(S::ClientTickEnd(Empty));
}
    // rust: Ok(())
}

tick_remote_level :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.ticks += 1;
    // rust: self.repro_tick();
        // Hud.tick ends with ChatComponent.tick.
    // rust: let chat_ticks = self.visual_ticks();
    // rust: self.ui.chat.tick(&self.gui.atlas, chat_ticks);
    // rust: self.tick_sign_editor();
    // rust: self.track_experience_display();
    // rust: self.tick_enchanting_book();
        // Leaving a slot clears its bundle's selection here and on the server.
    // rust: self.tick_bundle_hover();
        // Options.broadcastOptions: a changed render distance or Chat option
        // is sent again.
    // rust: let info = self
    // rust: .settings
    // rust: .client_information(client_view_distance(self.settings.render_distance));
    // rust: if let Some(r) = self.remote.as_mut()
    // rust: && r.joined
    // rust: && r.sent_info != info
    // rust: {
    // rust: r.sent_info = info.clone();
    // rust: self.send(S::ClientInformation(info));
}
        // Minecraft.tick: TickRateManager.tick; ClientLevel.tickTime advances
        // the time only while the level runs normally.
    // rust: let running = self.clock.world_runs();
    // rust: self.boss_overlay.tick_darken(running);
        // Under `HORIZON_STILL` the frame's countdowns (this one, the hotbar's pop, the HUD's
        // below) wait for the world, as the border's size change does in any frozen level: a
        // frozen client keeps ticking, as many ticks as the run took.
    // rust: let hold = !running && self.clock.still();
    // rust: if !hold {
    // rust: self.tick_item_activation();
}
    // rust: if running {
    // rust: self.world.game_time += 1;
    // rust: self.remote_clock_tick();
}
        // Weather levels drift toward their targets between server updates.
    // rust: let w = &mut self.world.weather;
    // rust: w.rain_level.0 = w.rain_level.1;
    // rust: w.thunder_level.0 = w.thunder_level.1;
    // rust: if self.use_delay > 0 {
    // rust: self.use_delay -= 1;
}
        // Minecraft.handleKeybinds precedes entity ticking and sendChanges.
        // Window callbacks only queue clicks, so an interaction cannot leak
        // between CLIENT_TICK_END and a later pong.
    // rust: self.remote_handle_input();
        // Player.tick's ItemCooldowns.tick, in ClientLevel.tickEntities after
        // handleKeybinds: this path replaces `tick_world`'s for a server's
        // client (multiplayer and the default single player), so the entries
        // advance here or the slot stays shaded until the server says the
        // entry ended. `onCooldownEnded` is the plain ItemCooldowns' no-op on
        // a client. Ticking it after the keybinds keeps a held use from
        // trying again a tick before the server's entry ends.
    // rust: self.cooldowns.tick();
        // Inventory.tick's ItemStack.inventoryTick: the pop time runs down.
    // rust: if !hold {
    // rust: for pop in &mut self.hotbar_pop {
    // rust: *pop = pop.saturating_sub(1);
}
}
        // ClientLevel.tick: the border's size change, while the level runs.
    // rust: if running {
    // rust: self.border.tick();
}
    // rust: self.player_border();
    // rust: self.tick_remote_entities(running);
    // rust: self.tick_random_textures();
        // Breeze.tick's block dust: drawn by each client for the breezes it sees.
    // rust: if running {
    // rust: self.tick_breeze_effects();
}
    // rust: self.tick_remote_guardian_eyes(running);
        // Level.tickBlockEntities: a frozen level ticks no block entities.
        // A step advances the moving pistons created by the block event once,
        // rather than finishing them during the frozen ticks between steps.
    // rust: if running {
    // rust: self.tick_block_entity_anims();
    // rust: self.tick_remote_spawners();
    // rust: self.client_tick_beacons();
    // rust: self.tick_remote_potent_sulfur();
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.client_tick_block_entities(level, ticks);
    // rust: });
    // rust: let pushes = std::mem::take(&mut self.block_ticks.piston_pushes);
    // rust: self.push_piston_entities(pushes);
    // rust: self.sync_moving_pistons();
}
    // rust: self.tick_hand();
    // rust: if running {
    // rust: self.tick_particles();
}
    // rust: self.tick_frame_visuals(running);
        // Under `HORIZON_STILL` they wait for the world too: endermen's and blazes' particles
        // draw on the particles' random, and effects count down, on every tick a frozen
        // client runs, as many as the run took to get there.
    // rust: if !hold {
    // rust: self.tick_client_ambient();
    // rust: self.tick_client_effects();
}
        // Player.tick's sleep counter (the darkening and the wake-up fade).
    // rust: self.sleep_timer = super::tick_sleep_timer(self.sleep_timer, self.sleeping.is_some());
        // Gui.tick: the titles, the action bar and the held item's name.
    // rust: if !hold {
    // rust: self.tick_hud();
    // rust: } else {
            // Only its countdowns wait: lying down still opens the bed's chat, waking closes it.
    // rust: self.tick_in_bed_chat();
}
    // rust: self.tick_subtitles();
    // rust: self.tick_client_load();
    // rust: let entity_collisions = self.player_entity_collisions();
    // rust: let pushed = self.remote_pushes();
    // rust: let sprint_window = self.settings.sprint_window;
    // rust: let Some(player) = self.player.as_mut() else {
    // rust: return Ok(());
}
    // rust: let (cx, cz) = (
    // rust: (player.position.x.floor() as i32) >> 4,
    // rust: (player.position.z.floor() as i32) >> 4,
    // rust: );
    // rust: if !self.streaming.is_lit(cx, cz) {
            // LocalPlayer.tick can wait for chunks, but Minecraft.tick still
            // calls sendChanges: rotations and the 20-tick position reminder
            // must continue, as well as moves into the unloaded area.
    // rust: if let Some(r) = self.remote.as_ref()
    // rust: && r.loaded_sent
    // rust: {
    // rust: let input = r.last_input;
    // rust: self.remote_send_state(input);
}
    // rust: return Ok(());
}
    // rust: let stick = self.pad_move();
    // rust: if self.player.is_none() {
    // rust: return Ok(());
}
        // The LevelLoadingScreen takes the input until the level is ready.
    // rust: let loading = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.level_load.is_active());
    // rust: let playing = self.screen == Screen::Playing && !loading && !self.dialog_open();
    // rust: let held = |action| playing && self.keys.held(action);
    // rust: let mut keys = Keys {
    // rust: forward: held(Action::Forward),
    // rust: backward: held(Action::Back),
    // rust: left: held(Action::Left),
    // rust: right: held(Action::Right),
    // rust: jump: held(Action::Jump),
    // rust: shift: held(Action::Sneak),
    // rust: sprint: held(Action::Sprint),
    // rust: analog: None,
}
    // rust: .with_stick(stick.filter(|_| playing));
        // On a server (not this game's own server thread), the stick moves as the keys it sets do
        // (`KeyboardInput.tick`: 8 directions, full speed). The server only hears those keys
        // (`ServerboundPlayerInputPacket`), and an anticheat that predicts from them pulls back
        // a player moving at the stick's own angle and speed.
    // rust: if self.integrated.is_none() && self.server_address().is_some() {
    // rust: keys.analog = None;
}
    // rust: let [mut strafe, mut forward] = keys.direction();
    // rust: let original = [strafe, forward];
    // rust: self.native_movement_input(&mut forward, &mut strafe, &mut keys.jump, &mut keys.shift);
    // rust: if [strafe, forward] != original {
    // rust: if forward != original[1] {
    // rust: keys.forward = forward > 0.0;
    // rust: keys.backward = forward < 0.0;
}
    // rust: if strafe != original[0] {
    // rust: keys.left = strafe > 0.0;
    // rust: keys.right = strafe < 0.0;
}
    // rust: keys.analog = Some([strafe, forward]);
}
    // rust: let input = u8::from(keys.forward)
    // rust: | u8::from(keys.backward) << 1
    // rust: | u8::from(keys.left) << 2
    // rust: | u8::from(keys.right) << 3
    // rust: | u8::from(keys.jump) << 4
    // rust: | u8::from(keys.shift) << 5
    // rust: | u8::from(keys.sprint) << 6;
        // LocalPlayer.applyInput and aiStep: watching through another
        // entity, the player does not move itself; its keys still reach the
        // server, whose sneak check lets go of the camera.
    // rust: let keys = if self.controls_camera() {
    // rust: keys
    // rust: } else {
    // rust: Keys::default()
}
        // The held lead's end eases from the look at the start of the tick
        // (`yRotO`/`xRotO`), as the local tick does; `tick` returns before it
        // reaches its own write when this window is a server client.
    // rust: self.rope_rot_old = (self.yaw, self.pitch);
        // A passenger moves with its vehicle (Entity.rideTick), not by itself.
    // rust: let riding = self.screen != Screen::Dead && self.remote_ride(keys, sprint_window)?;
        // The server sends no passenger's position: they sit where their
        // vehicles are now.
    // rust: self.position_riders();
        // Entity.getFluidInteractionBox asks the vehicle: a boat afloat shelters
        // its passenger's eyes (AbstractBoat.modifyPassengerFluidInteractionBox).
    // rust: let boat = self
    // rust: .riding
    // rust: .and_then(|id| self.boats.iter().find(|b| b.id == id))
    // rust: .map(|b| horizon_client::motion::RiddenBoat {
    // rust: under_water: b.under_water(),
    // rust: max_y: b.bounds().max_position().y,
    // rust: });
    // rust: let Some(player) = self.player.as_mut() else {
    // rust: return Ok(());
}
    // rust: player.fluids.boat = boat;
    // rust: if !riding {
    // rust: self.previous_position = player.position;
}
    // rust: let before = (
    // rust: player.ground.on_ground,
    // rust: [player.velocity.x, player.velocity.y, player.velocity.z],
    // rust: [player.position.x, player.position.y, player.position.z],
    // rust: );
    // rust: let was_flying = player.flying;
    // rust: self.sync_player_body();
        // LivingEntity.tickDeath: the local player counts its deathTime once
        // per client tick while dead (the camera's death roll and zoom).
    // rust: if self.screen == Screen::Dead {
    // rust: self.ui.death_time = self.ui.death_time.saturating_add(1);
}
    // rust: let Some(player) = self.player.as_mut() else {
    // rust: return Ok(());
}
    // rust: let was_gliding = player.fall_flying;
    // rust: let dead = self.screen == Screen::Dead;
        // LivingEntity.isImmobile: a sleeper lies still in the bed.
    // rust: let sleeping = self.sleeping;
    // rust: if let Some(head) = sleeping {
    // rust: player.position = Vec3::new(
    // rust: f64::from(head[0]) + 0.5,
                // setPosToBed: the bed's top (getSleepHeight) and 0.125 above it.
    // rust: f64::from(head[1]) + 0.5625 + 0.125,
    // rust: f64::from(head[2]) + 0.5,
    // rust: );
    // rust: player.velocity = Vec3::ZERO;
    // rust: player.pitch = 0.0;
    // rust: } else if !dead && !riding {
    // rust: player.client_side = true;
    // rust: player.velocity = player.velocity.add_vector(pushed);
            // LivingEntity.checkAutoSpinAttack: a Riptide spin that touches a
            // mob ends and bounces back; the server deals the hit.
    // rust: player.spin_targets.clear();
    // rust: if player.auto_spin_attack_ticks > 0 {
    // rust: player.spin_targets.extend(
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| !m.removed)
    // rust: .map(|m| (m.id, m.bounds())),
    // rust: );
}
    // rust: MotionWorld {
    // rust: entities: &entity_collisions,
    // rust: player,
    // rust: scene: &mut self.world,
    // rust: assets: &self.pack.assets,
    // rust: collision_binding: self.collision,
    // rust: resources: self.motion,
    // rust: health: &self.health_resources,
}
    // rust: .controlled_simulation_tick_with_sprint_window(keys, sprint_window)?;
    // rust: } else {
            // LivingEntity.baseTick counts hurtTime down for a dead or riding
            // player too (controlled_simulation_tick does it otherwise): left
            // at 10, the hurt tilt restarted every frame and shook the camera.
    // rust: player.health.advance_clock();
    // rust: if riding && !dead {
    // rust: player.client_side = true;
    // rust: let mut passenger = MotionWorld {
    // rust: entities: &entity_collisions,
    // rust: player: &mut *player,
    // rust: scene: &mut self.world,
    // rust: assets: &self.pack.assets,
    // rust: collision_binding: self.collision,
    // rust: resources: self.motion,
    // rust: health: &self.health_resources,
}
    // rust: passenger.passenger_pose_tick()?;
                // LivingEntity.aiStep: a passenger freezes in powder snow too, and the
                // frostbite overlay shows it (#8156).
    // rust: passenger.passenger_block_effects_tick()?;
}
}
        // The server decides fire the window cannot predict (blaze fireballs,
        // fire aspect, lightning): Entity.isOnFire reads the synched flag, so
        // the predicted tick's countdown must not end it while it is set.
    // rust: player.fire_ticks = hold_server_fire(
    // rust: player.fire_ticks,
    // rust: self.remote.as_ref().is_some_and(|r| r.own_on_fire),
    // rust: );
        // LocalPlayer.onUpdateAbilities: flight turned on or off (a double
        // jump, a spectator, landing) is sent to the server.
    // rust: let flying = player.flying;
        // LocalPlayer.aiStep: a glide this client started is sent to the
        // server (ServerboundPlayerCommandPacket START_FALL_FLYING).
    // rust: let started_gliding = player.fall_flying && !was_gliding;
    // rust: let events = std::mem::take(&mut player.events);
    // rust: self.previous_eye = self.eye;
    // rust: self.eye += (player.dimensions.eye_height - self.eye) * 0.5;
    // rust: let feet = [player.position.x, player.position.y, player.position.z];
    // rust: for event in events {
    // rust: match event {
    // rust: horizon_client::motion::MotionEvent::Emission { state, muffled, .. } => {
    // rust: let sounds = self.res.facts().get(state).sounds.clone();
                    // Player.playStepSound: muffled under the swim sound in water.
    // rust: let (volume, pitch) = if muffled {
    // rust: (sounds.volume * 0.05, sounds.pitch * 0.8)
    // rust: } else {
    // rust: (sounds.volume * 0.15, sounds.pitch)
}
    // rust: self.audio.play(&sounds.step, Some(feet), volume, pitch);
}
    // rust: horizon_client::motion::MotionEvent::Swim { volume, pitch } => {
    // rust: self.audio
    // rust: .play("minecraft:entity.player.swim", Some(feet), volume, pitch);
}
                // Entity.doWaterSplashEffect on the client's own level: the
                // server's splash skips this player (Player.playSound), and
                // its particles are the client's own.
    // rust: horizon_client::motion::MotionEvent::Splash {
    // rust: high_speed,
    // rust: volume,
    // rust: pitch,
    // rust: } => {
    // rust: let name = if high_speed {
    // rust: "minecraft:entity.player.splash.high_speed"
    // rust: } else {
    // rust: "minecraft:entity.player.splash"
}
    // rust: self.audio.play(name, Some(feet), volume, pitch);
}
    // rust: horizon_client::motion::MotionEvent::SplashParticle {
    // rust: bubble,
    // rust: position,
    // rust: velocity,
    // rust: } => {
//                     use horizon_client::particles::{ParticleOptions, ParticleType};
    // rust: let kind = if bubble {
    // rust: ParticleType::Bubble
    // rust: } else {
    // rust: ParticleType::Splash
}
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(kind),
    // rust: [position.x, position.y, position.z],
    // rust: [velocity.x, velocity.y, velocity.z],
    // rust: );
}
    // rust: horizon_client::motion::MotionEvent::Chime { volume, pitch } => {
    // rust: self.audio.play(
    // rust: "minecraft:block.amethyst_block.chime",
    // rust: Some(feet),
    // rust: volume,
    // rust: pitch,
    // rust: );
}
                // NetherPortalBlock.entityInside on the client's own level:
                // the portal overlay and its trigger sound (the server moves
                // the player).
    // rust: horizon_client::motion::MotionEvent::InsidePortal { .. } => {
    // rust: self.client_inside_nether_portal();
}
                // HoneyBlock.maybeDoSlideEffects on the client's own level:
                // the slide sound, heard here (LocalPlayer.playSound); the
                // particles come from the server's event 53.
    // rust: horizon_client::motion::MotionEvent::HoneySlide { sound: true, .. } => {
    // rust: self.audio
    // rust: .play("minecraft:block.honey_block.slide", Some(feet), 1.0, 1.0);
}
                // LivingEntity.causeFallDamage and HoneyBlock.fallOn on the
                // client's own level: the fall and honey sounds are heard here
                // (LocalPlayer.playSound); the server's copy skips this player
                // (Player.playSound).
    // rust: horizon_client::motion::MotionEvent::Fall(
    // rust: horizon_client::landing::FallEvent::Sound {
    // rust: sound,
    // rust: volume,
    // rust: pitch,
    // rust: ..
    // rust: },
    // rust: ) => {
    // rust: if let Some(name) = sound
    // rust: .player_fall_sound()
    // rust: .or_else(|| sound.honey_landing_sound())
    // rust: {
    // rust: self.audio.play(name, Some(feet), volume, pitch);
}
}
    // rust: _ => {}
}
}
        // A stand riding the player follows this move (tickPassenger).
    // rust: self.seat_own_stands();
        // The server owns health and hunger.
    // rust: self.apply_remote_health();
    // rust: self.tick_avatar(before, false);
        // LivingEntity.tick: a sleeper's xRot is 0.
    // rust: if sleeping.is_some() {
    // rust: self.pitch = 0.0;
    // rust: self.snap_player_model_pitch();
}
        // The player's own model (third person, the inventory's preview).
    // rust: self.tick_player_model();
    // rust: self.tick_emotes();
    // rust: if !dead {
    // rust: self.remote_tick_using();
}
    // rust: if flying != was_flying {
    // rust: self.send(S::PlayerAbilities(play::PlayerAbilitiesRequest {
    // rust: flags: if flying { 2 } else { 0 },
    // rust: }));
}
    // rust: if started_gliding {
    // rust: let id = self.remote.as_ref().map_or(0, |r| r.entity_id);
    // rust: self.send(S::PlayerCommand(play::PlayerCommand {
    // rust: id,
    // rust: action: 6,
    // rust: data: 0,
    // rust: }));
}
        // LocalPlayer.sendChanges sends `input.keyPresses`, which an auto-jump's `makeJump` set to
        // jump for this tick: the server's prediction plays the jump from it. Sent as held, the jump
        // was the client's alone, and the server saw a jump its keys didn't allow.
    // rust: let auto_jumped = self.player.as_ref().is_some_and(|p| p.was_auto_jump);
    // rust: self.remote_send_state(input | u8::from(auto_jumped) << 4);
    // rust: Ok(())
}

    // ClientPacketListener.handlePlayerAbilities: the player flies, may fly
    // and is invulnerable as the server says (bits 2, 4 and 1).
apply_remote_abilities :: proc(self: ^Self) {
}
    // rust: let (Some(player), Some(a)) = (
    // rust: self.player.as_mut(),
    // rust: self.remote.as_ref().and_then(|r| r.abilities.as_ref()),
    // rust: ) else {
    // rust: return;
}
    // rust: player.invulnerable = a.flags & 1 != 0;
    // rust: player.flying = a.flags & 2 != 0;
    // rust: player.may_fly = a.flags & 4 != 0;
    // rust: player.flying_speed = a.flying_speed;
}
    // The local player's share of every touching entity's
    // `LivingEntity.pushEntities`, and of the boats' pushes: on a client
    // `EntitySelector.pushableBy` lets entities push only the local player,
    // so the server never sends these pushes. `doPush(player)` is
    // `player.push(entity)`.
remote_pushes :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (Some(p), Some(r)) = (self.player.as_ref(), self.remote.as_ref()) else {
    // rust: return Vec3::ZERO;
}
        // LivingEntity.isPushable: alive, no spectator, off ladders.
    // rust: let feet = [
    // rust: p.position.x.floor() as i32,
    // rust: p.position.y.floor() as i32,
    // rust: p.position.z.floor() as i32,
    // rust: ];
    // rust: if self.screen == Screen::Dead
    // rust: || p.spectator
    // rust: || self.block_in_tag("minecraft:climbable", &self.block_name(feet))
    // rust: {
    // rust: return Vec3::ZERO;
}
    // rust: let bounds = p.bounds();
    // rust: let teams = self.mob_teams();
        // `Entity.getTeam` is `Scoreboard.getPlayersTeam(getScoreboardName())`:
        // a player's score holder is its profile name, every other entity's
        // its UUID text. `mob_teams` keys by UUID and names the local player
        // `PLAYER_NAME`, which misses a server's teams for players.
    // rust: let board = &self.score.board;
    // rust: let player_team = board.players_team(&r.profile_name);
    // rust: let mut push = Vec3::ZERO;
    // rust: for m in &self.mobs {
    // rust: let listed = r
    // rust: .level_players
    // rust: .get(&(m.id as i32))
    // rust: .and_then(|uuid| r.tab_players.get(uuid));
    // rust: let spectator = listed.is_some_and(|t| t.game_mode == SPECTATOR);
    // rust: let mob_team = match listed {
    // rust: Some(t) => board.players_team(&t.name),
    // rust: None => teams.of(Who::Mob(m.id)),
}
            // Bats never push; a spectator has no physics; passengers of the
            // same vehicle never push each other.
    // rust: if !m.alive()
    // rust: || spectator
    // rust: || m.species() == horizon_client::mobs::Species::Bat
    // rust: || self
    // rust: .riding
    // rust: .is_some_and(|v| v == m.id || m.extra.mount == Some(v))
    // rust: || !m.bounds().intersects(bounds)
    // rust: || !horizon_client::scoreboard::pushable_by(mob_team, player_team, true)
    // rust: {
    // rust: continue;
}
            // Entity.push(Entity), `this` the player.
    // rust: let (mut xa, mut za) = (m.position.x - p.position.x, m.position.z - p.position.z);
    // rust: let mut dd = xa.abs().max(za.abs());
    // rust: if dd < f64::from(0.01_f32) {
    // rust: continue;
}
    // rust: dd = dd.sqrt();
    // rust: xa /= dd;
    // rust: za /= dd;
    // rust: let pow = (1.0 / dd).min(1.0);
    // rust: xa *= pow;
    // rust: za *= pow;
    // rust: xa *= f64::from(0.05_f32);
    // rust: za *= f64::from(0.05_f32);
    // rust: push = Vec3::new(push.x - xa, push.y, push.z - za);
}
        // AbstractBoat.push(player) from the boat's own tick (its box grown
        // by 0.2 sideways) and from the player's pushEntities (its box).
    // rust: let area = Vec3::new(f64::from(0.2_f32), f64::from(-0.01_f32), f64::from(0.2_f32));
    // rust: for b in self.boats.iter().filter(|b| self.riding != Some(b.id)) {
    // rust: let bb = b.bounds();
    // rust: let times = usize::from(
    // rust: bounds.intersects(bb.inflate(area))
    // rust: && horizon_client::scoreboard::pushable_by(None, player_team, true),
    // rust: ) + usize::from(
    // rust: bounds.intersects(bb)
    // rust: && horizon_client::scoreboard::pushable_by(player_team, None, true),
    // rust: );
    // rust: if times > 0
    // rust: && super::boat_passengers::boat_pushes(bb, bounds, false)
    // rust: && let Some(v) = super::boat_passengers::push_impulse(b.position, p.position)
    // rust: {
    // rust: push = push.add_vector(v.scale(times as f64));
}
}
    // rust: push
}
    // ClientLevel.tickEntities; a frozen level only ticks the players
    // (`TickRateManager.isEntityFrozen`).
    // `GuardianRenderer.getEntityToLookAt`: a guardian's eye follows its
    // synched attack target, else the camera.
tick_remote_guardian_eyes :: proc(self: ^Self, running: bool) {
}
//         use horizon_client::mobs::{Species, Who, guardian};
    // rust: if !running {
    // rust: return;
}
    // rust: let camera = self.player.as_ref().map(|p| {
    // rust: [
    // rust: p.position.x,
    // rust: p.position.y + f64::from(p.dimensions.eye_height),
    // rust: p.position.z,
    // rust: ]
    // rust: });
    // rust: let looks: Vec<_> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| {
    // rust: matches!(m.species(), Species::Guardian | Species::ElderGuardian) && m.alive()
    // rust: })
    // rust: .filter_map(|(i, m)| {
    // rust: let look = match m.ai.target.filter(|_| m.extra.flag) {
    // rust: Some(Who::Mob(id)) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|t| t.id == id)
    // rust: .map(|t| [t.position.x, t.eye_y(), t.position.z]),
    // rust: _ => camera,
}
    // rust: look.map(|look| (i, look))
    // rust: })
    // rust: .collect();
    // rust: for (i, look) in looks {
    // rust: guardian::look_at(&mut self.mobs[i], look);
}
}
tick_remote_entities :: proc(self: ^Self, running: bool) {
}
    // rust: if running {
    // rust: self.tick_text_displays();
    // rust: self.tick_remote_ominous_item_spawners();
}
        // EntityFluidInteraction.update for the entities this window only displays: the
        // server never sends the fluid contact, and the renderers read it (cod, salmon and
        // tropical fish lie on their side without `in_water`, #1591).
        // A frozen level ticks only the players, as below.
        // Entity.isInRain for the wolves, which dry off by their own `Wolf.tick`.
    // rust: let (fluids, rain, standings, thundering): (Vec<_>, Vec<_>, Vec<_>, bool) = {
    // rust: let w = self.mob_world_base(&[]);
    // rust: let players = self.remote.as_ref().map(|r| &r.level_players);
    // rust: let fluids = self
    // rust: .mobs
    // rust: .iter()
    // rust: .map(|m| {
    // rust: (running || players.is_some_and(|p| p.contains_key(&(m.id as i32))))
    // rust: .then(|| w.fluids(m.bounds(), m.eye_y()))
    // rust: })
    // rust: .collect();
    // rust: let rain = self
    // rust: .mobs
    // rust: .iter()
    // rust: .map(|m| {
    // rust: m.species() == horizon_client::mobs::Species::Wolf
    // rust: && horizon_client::mobs::tame::in_rain(m, &w)
    // rust: })
    // rust: .collect();
            // The block under each mob the packs' random-model rules read (a grazing
            // cow), one hair below the feet like `Entity.getBlockStateOn`; nothing
            // without rules.
    // rust: let standings = self
    // rust: .mobs
    // rust: .iter()
    // rust: .map(|m| {
    // rust: horizon_client::mobs::cem::tracks_standing(&m.kind.id).then(|| {
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: (m.position.y - 0.0001).floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: w.block_name(x, y, z).to_owned()
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: (fluids, rain, standings, w.thundering)
}
        // The window's own player already splashes from its motion tick.
    // rust: let own = self.remote.as_ref().map(|r| r.entity_id);
    // rust: let mut water_fx = Vec::new();
    // rust: for ((m, fluids), standing) in self.mobs.iter_mut().zip(fluids).zip(standings) {
    // rust: if let Some(fluids) = fluids {
    // rust: let was = m.fluids.in_water;
    // rust: let first = m.first_tick;
    // rust: m.fluids = fluids;
                // Entity.doWaterSplashEffect on the client copy. Particles
                // only: ClientLevel draws addParticle, and playSeededSound
                // drops Entity.playSound (the server broadcasts that).
    // rust: if m.fluids.in_water && !was && !first && Some(m.id as i32) != own {
    // rust: horizon_client::mobs::living::client_water_splash(m, &mut water_fx);
}
    // rust: m.first_tick = false;
}
    // rust: if let Some(name) = standing {
    // rust: m.standing_on = Some(name);
}
}
    // rust: let game_time = self.world.game_time;
        // `AbstractPiglin.isConverting`: the dimension is not piglin safe.
    // rust: let nether = self.dim == super::Dim::Nether;
        // What a wither's side heads can look at, by network entity id: the
        // mobs and the player (position and eye height).
    // rust: let wither_targets: Vec<(i32, [f64; 3], f64)> = if self
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|m| m.species() == horizon_client::mobs::Species::Wither)
    // rust: {
    // rust: let own = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .zip(self.eye_position())
    // rust: .map(|(r, eye)| (r.entity_id, eye, eye[1]));
    // rust: self.mobs
    // rust: .iter()
    // rust: .map(|m| {
    // rust: (
    // rust: m.id as i32,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: m.eye_y(),
    // rust: )
    // rust: })
    // rust: .chain(own)
    // rust: .collect()
    // rust: } else {
    // rust: Vec::new()
}
        // ExperienceOrb.followNearbyPlayer: the players an orb may go for,
        // their feet and the point `eyeHeight / 2` above them.
    // rust: let followed: Vec<([f64; 3], [f64; 3])> = {
    // rust: let own = self
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|p| !p.health.dead_or_dying() && !self.spectator())
    // rust: .map(|p| {
    // rust: let feet = [p.position.x, p.position.y, p.position.z];
    // rust: let eye = f64::from(p.dimensions.eye_height);
    // rust: (feet, [feet[0], feet[1] + eye / 2.0, feet[2]])
    // rust: });
    // rust: let others = self.remote.as_ref().into_iter().flat_map(|r| {
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(move |m| m.alive() && r.level_players.contains_key(&(m.id as i32)))
    // rust: .filter(move |m| {
    // rust: let listed = r.level_players.get(&(m.id as i32));
    // rust: !listed
    // rust: .and_then(|uuid| r.tab_players.get(uuid))
    // rust: .is_some_and(|t| t.game_mode == SPECTATOR)
    // rust: })
    // rust: .map(|m| {
    // rust: let feet = [m.position.x, m.position.y, m.position.z];
    // rust: (
    // rust: feet,
    // rust: [feet[0], feet[1] + (m.eye_y() - feet[1]) / 2.0, feet[2]],
    // rust: )
    // rust: })
    // rust: });
    // rust: own.into_iter().chain(others).collect()
}
        // The mount this client moves ticks in `remote_ride` instead, as its
        // authoritative side (LivingEntity.tick with travelRidden).
    // rust: let driven = self.driven_mount().map(|m| m.id);
        // Cat.handleLieDown: the sleeping players (another's, drawn lying in
        // a bed, and this client's own) a lying cat can lie on top of.
    // rust: let sleepers: Vec<horizon_core::geometry::Aabb> = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .map(|r| {
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: r.level_players.contains_key(&(m.id as i32)) && m.extra.ints[1] != 0
    // rust: })
    // rust: .map(|m| {
    // rust: let p = m.position;
    // rust: horizon_core::geometry::Aabb::new(
    // rust: horizon_core::geometry::Vec3::new(p.x - 0.1, p.y, p.z - 0.1),
    // rust: horizon_core::geometry::Vec3::new(p.x + 0.1, p.y + 0.2, p.z + 0.1),
    // rust: )
    // rust: })
    // rust: .chain(self.sleeping.map(|bed| {
    // rust: let p = horizon_core::geometry::Vec3::new(
    // rust: f64::from(bed[0]) + 0.5,
    // rust: f64::from(bed[1]) + 0.6875,
    // rust: f64::from(bed[2]) + 0.5,
    // rust: );
    // rust: horizon_core::geometry::Aabb::new(
    // rust: horizon_core::geometry::Vec3::new(p.x - 0.1, p.y, p.z - 0.1),
    // rust: horizon_core::geometry::Vec3::new(p.x + 0.1, p.y + 0.2, p.z + 0.1),
    // rust: )
    // rust: }))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let mut lerps = std::mem::take(&mut r.lerps);
    // rust: let mut cart_lerps = std::mem::take(&mut r.cart_lerps);
    // rust: let stepped = &mut r.stepped;
    // rust: let head_lerps = &mut r.head_lerps;
    // rust: let players = &r.level_players;
    // rust: let tab_players = &r.tab_players;
    // rust: let mut using = Vec::new();
    // rust: let mut mob_fx = water_fx;
    // rust: for (m, rain) in self.mobs.iter_mut().zip(rain) {
    // rust: let player = players.contains_key(&(m.id as i32));
    // rust: if player {
                // AvatarRenderer.extractRenderState: isSpectator, from the player list.
    // rust: m.extra.spectator = players
    // rust: .get(&(m.id as i32))
    // rust: .and_then(|uuid| tab_players.get(uuid))
    // rust: .is_some_and(|t| t.game_mode == SPECTATOR);
}
    // rust: if (!running && !player) || driven == Some(m.id) {
    // rust: continue;
}
    // rust: m.previous = m.position;
            // `Entity.deltaMovementOnPreviousTick`: the elytra's flight yaw
            // lerps from it, so another player's model does not snap when a
            // new tick's velocity arrives.
    // rust: m.extra.previous_velocity = m.velocity;
    // rust: m.previous_yaw = m.yaw;
    // rust: m.previous_body_yaw = m.body_yaw;
    // rust: m.previous_head_yaw = m.head_yaw;
    // rust: m.previous_head_pitch = m.head_pitch;
    // rust: m.previous_limb_speed = m.limb_speed;
    // rust: m.age += 1;
    // rust: if m.species() == horizon_client::mobs::Species::Rabbit {
    // rust: horizon_client::mobs::rabbit::base_tick(m);
}
    // rust: if matches!(
    // rust: m.species(),
    // rust: horizon_client::mobs::Species::Horse
    // rust: | horizon_client::mobs::Species::Donkey
    // rust: | horizon_client::mobs::Species::Mule
    // rust: | horizon_client::mobs::Species::SkeletonHorse
    // rust: | horizon_client::mobs::Species::ZombieHorse
    // rust: ) {
    // rust: horizon_client::mobs::equine::tail_tick(m);
}
    // rust: if m.species() == horizon_client::mobs::Species::Creeper {
    // rust: horizon_client::mobs::hostile::creeper_client_tick(m);
}
    // rust: if matches!(
    // rust: m.species(),
    // rust: horizon_client::mobs::Species::Guardian
    // rust: | horizon_client::mobs::Species::ElderGuardian
    // rust: ) {
    // rust: horizon_client::mobs::guardian::client_tick(m);
}
            // PolarBear.tick: the stand animation follows the synched flag.
    // rust: if m.species() == horizon_client::mobs::Species::PolarBear {
    // rust: horizon_client::mobs::polar_bear::client_tick(m);
}
            // The particles these mobs' own ticks draw on the client side.
    // rust: {
//                 use horizon_client::mobs::{
    // rust: Species as S, cube, illager, illusioner, nautilus, tame, wither,
}
    // rust: match m.species() {
    // rust: S::Wolf => tame::client_tick(m, rain, &mut mob_fx),
    // rust: S::Slime | S::MagmaCube | S::SulfurCube => cube::client_tick(m, &mut mob_fx),
    // rust: S::Nautilus | S::ZombieNautilus => nautilus::client_tick(m, &mut mob_fx),
    // rust: S::Illusioner => {
    // rust: illusioner::client_tick(m, &mut mob_fx);
    // rust: illager::cast_particles(m, &mut mob_fx);
}
    // rust: S::Evoker => illager::cast_particles(m, &mut mob_fx),
    // rust: S::Wither => {
    // rust: wither::client_smoke(m, &mut mob_fx);
                        // `getInvulnerableTicks() > 0`: the charge's cloud,
                        // after the heads' smoke as in `aiStep`.
    // rust: wither::charging_particles(m, &mut mob_fx);
}
    // rust: _ => {}
}
}
    // rust: if m.hurt_time > 0 {
    // rust: m.hurt_time -= 1;
}
    // rust: if !m.alive() {
    // rust: m.death_time += 1;
}
            // LivingEntity.updateSwingTime.
    // rust: m.anim.attack_anim_o = m.anim.attack_anim;
    // rust: horizon_client::mobs::ai::tick_swing(m);
            // Entity.tick: the SteppedInterpolationHandler's step.
    // rust: if let Some(at) = stepped
    // rust: .get_mut(&(m.id as i32))
    // rust: .and_then(|h| h.interpolate())
    // rust: {
    // rust: place_interpolated(m, at);
}
            // LivingEntity.aiStep: the head's own interpolation.
    // rust: if let Some((yaw, steps)) = head_lerps.get_mut(&(m.id as i32))
    // rust: && *steps > 0
    // rust: {
    // rust: m.head_yaw += wrap_degrees(*yaw - m.head_yaw) / *steps as f32;
    // rust: *steps -= 1;
}
            // Fox.tick: the head tilt and crouch follow the synched flags.
    // rust: if m.species() == horizon_client::mobs::Species::Fox {
    // rust: horizon_client::mobs::fox::client_tick(m);
}
            // Cat.tick: the lying and relaxing amounts follow the synched flags.
    // rust: if m.species() == horizon_client::mobs::Species::Cat {
    // rust: m.anim.vo = m.anim.v;
    // rust: horizon_client::mobs::tame::cat_amounts(m);
    // rust: horizon_client::mobs::tame::cat_lying_on_sleeper(m, &sleepers);
}
            // Chicken.aiStep: the wings follow the server's on-ground flag.
    // rust: if m.species() == horizon_client::mobs::Species::Chicken {
    // rust: horizon_client::mobs::farm::chicken_flap(m);
}
            // Parrot.calculateFlapping: the wings follow the server's
            // on-ground flag and the shoulder it sits on (the glide is the
            // server's).
    // rust: if m.species() == horizon_client::mobs::Species::Parrot {
    // rust: horizon_client::mobs::parrot::flap(m);
}
            // LivingEntity.updatingUsingItem: the ticks the item has been
            // used before this one. Another player's use particles; a mob's
            // drawn bow only needs the count (its pull follows it).
    // rust: if player {
                // AvatarRenderer.getArmPose: the used item's BLOCK animation
                // (an item with `blocks_attacks`) raises the arm.
    // rust: let used = if m.extra.using_off_hand {
    // rust: &m.extra.off_hand
    // rust: } else {
    // rust: &m.extra.main_hand
}
    // rust: m.extra.blocking = m.extra.using_item > 0
    // rust: && used
    // rust: .as_ref()
    // rust: .and_then(|i| world_items!(self).get(i))
    // rust: .is_some_and(|i| i.blocks_attacks.is_some());
}
    // rust: if m.extra.using_item > 0 {
    // rust: if player {
    // rust: let item = if m.extra.using_off_hand {
    // rust: m.extra.off_hand.clone()
    // rust: } else {
    // rust: m.extra.main_hand.clone()
}
    // rust: if let Some(item) = item {
    // rust: let eye = m.eye_height();
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: using.push((
    // rust: item,
    // rust: m.extra.using_item as u32 - 1,
    // rust: at,
    // rust: eye,
    // rust: m.head_pitch,
    // rust: m.yaw,
    // rust: ));
}
}
    // rust: m.extra.using_item += 1;
}
            // LivingEntity.tick's tickHeadTurn: a mob's BodyRotationControl,
            // a player's body following its walk and look.
    // rust: if player {
    // rust: remote_player_head_turn(m);
                // LivingEntity.tick: the glide count, wings and swim amount.
    // rust: m.tick_avatar_pose(m.fluids.in_water);
                // LivingEntity.tick: a sleeper's xRot is 0.
    // rust: if m.extra.ints[1] != 0 {
    // rust: m.head_pitch = 0.0;
    // rust: m.previous_head_pitch = 0.0;
}
    // rust: } else if m.alive() {
    // rust: m.body_rotation_tick();
}
            // Squid.aiStep follows LivingEntity's interpolation and head turn.
    // rust: horizon_client::mobs::aquatic::squid_client_step(m, &mut mob_fx);
            // WalkAnimationState.update from the horizontal distance moved.
    // rust: let (dx, dz) = (m.position.x - m.previous.x, m.position.z - m.previous.z);
    // rust: let (target, factor) = if horizon_client::mobs::camel::is_camel(m.species()) {
                // Camel.updateWalkAnimation.
    // rust: horizon_client::mobs::camel::walk_target(m, (dx * dx + dz * dz).sqrt() as f32)
    // rust: } else {
    // rust: ((((dx * dx + dz * dz).sqrt() * 4.0) as f32).min(1.0), 0.4)
}
    // rust: m.limb_speed += (target - m.limb_speed) * factor;
    // rust: m.limb_position += m.limb_speed;
    // rust: if m.species() == horizon_client::mobs::Species::Rabbit {
    // rust: horizon_client::mobs::rabbit::post_tick(m);
}
    // rust: if m.species() == horizon_client::mobs::Species::Bat {
    // rust: horizon_client::mobs::bat::setup_animation_states(m);
}
            // The animation states a server computes in its own `ai_step`,
            // and the particles vanilla draws on the client.
    // rust: horizon_client::mobs::sync::client_tick(m, game_time, &mut mob_fx);
    // rust: match m.species() {
                // WitherBoss.aiStep: the side heads turn toward their targets.
    // rust: horizon_client::mobs::Species::Wither => {
    // rust: horizon_client::mobs::wither::client_tick(m, |id| {
    // rust: wither_targets
    // rust: .iter()
    // rust: .find(|t| t.0 == id)
    // rust: .map(|t| (t.1, t.2))
    // rust: });
}
                // Hoglin and piglin `isConverting` outside the Nether.
    // rust: horizon_client::mobs::Species::Hoglin
    // rust: | horizon_client::mobs::Species::Piglin
    // rust: | horizon_client::mobs::Species::PiglinBrute => {
    // rust: horizon_client::mobs::piglin::client_converting(m, nether);
}
    // rust: horizon_client::mobs::Species::Panda => {
    // rust: horizon_client::mobs::panda::client_tick(m, thundering);
}
    // rust: _ => {}
}
}
        // ExperienceOrb.tick runs on a client too (all but the merges and the
        // push out of a block, which are the server's): gravity, buoyancy,
        // collisions and the pull of the nearest player between the server's
        // updates; the server removes it on pickup.
    // rust: let (world, facts, collision) = (&self.world, self.res.facts(), self.collision);
    // rust: let border = Some(self.border.geometry());
    // rust: let mut lava_random = None;
    // rust: let mut next_float = || {
    // rust: lava_random
    // rust: .get_or_insert_with(super::dispenser::entity_random)
    // rust: .next_float()
}
    // rust: if running {
    // rust: self.orbs.retain_mut(|o| {
    // rust: let distance = |feet: &[f64; 3]| -> f64 {
    // rust: (feet[0] - o.position.x).powi(2)
    // rust: + (feet[1] - o.position.y).powi(2)
    // rust: + (feet[2] - o.position.z).powi(2)
}
    // rust: let target = followed
    // rust: .iter()
    // rust: .filter(|(feet, _)| distance(feet) < 64.0)
    // rust: .min_by(|a, b| distance(&a.0).total_cmp(&distance(&b.0)))
    // rust: .map(|(_, target)| *target);
                // Entity.commonTick: setOldPosAndRot, then
                // LinearInterpolationHandler.doInterpolate moves 1/remaining of
                // the way to the server's position, so the frame draws the step
                // from the old position.
    // rust: let old = o.position;
    // rust: if let Some(l) = lerps.get_mut(&(o.id as i32)).filter(|l| l.steps > 0) {
    // rust: let alpha = 1.0 / f64::from(l.steps);
    // rust: o.position = Vec3::new(
    // rust: o.position.x + (l.target[0] - o.position.x) * alpha,
    // rust: o.position.y + (l.target[1] - o.position.y) * alpha,
    // rust: o.position.z + (l.target[2] - o.position.z) * alpha,
    // rust: );
    // rust: l.steps -= 1;
}
    // rust: let before = o.position;
    // rust: let kept = o.tick(
    // rust: world,
    // rust: facts,
    // rust: collision,
    // rust: target,
    // rust: false,
    // rust: &mut next_float,
    // rust: border,
    // rust: &self.res.motion().fluids,
    // rust: &mut |_, _| {},
    // rust: );
                // `tick` set `previous` to the stepped position: keep the
                // pre-step one, as `xo` is in vanilla.
    // rust: o.previous = old;
                // AbstractInterpolationHandler.applyPredictedMovement: the orb's
                // own move carries the target along (vanilla also checks the
                // moved target for collisions; that check is left out here).
    // rust: if let Some(l) = lerps.get_mut(&(o.id as i32)).filter(|l| l.steps > 0) {
    // rust: l.target[0] += o.position.x - before.x;
    // rust: l.target[1] += o.position.y - before.y;
    // rust: l.target[2] += o.position.z - before.z;
}
    // rust: kept
    // rust: });
}
        // ItemEntity.tick runs on a client too: gravity, collisions and
        // friction move the item between the server's updates (every 20
        // ticks), and only the server removes it.
    // rust: let (world, registry, facts, collision, border) = (
    // rust: &self.world,
    // rust: self.pack.assets.registry,
    // rust: self.res.facts(),
    // rust: self.collision,
    // rust: Some(self.border.geometry()),
    // rust: );
    // rust: let mut entered = Vec::new();
    // rust: for d in self.dropped.iter_mut().filter(|_| running) {
    // rust: super::entity::tick_item(
    // rust: d,
    // rust: world,
    // rust: registry,
    // rust: facts,
    // rust: collision,
    // rust: &self.res.motion().fluids,
    // rust: false,
                // The server decides what an item rests on; this copy only moves between updates.
    // rust: &[],
    // rust: border,
    // rust: Some(&self.res.motion().blocks),
    // rust: &mut |splash| entered.push(splash),
    // rust: );
}
    // rust: head_lerps.retain(|_, (_, steps)| *steps > 0);
        // Entity.doWaterSplashEffect on this window: Level.addParticle draws
        // the bubbles and splashes. ClientLevel.playSeededSound drops
        // Entity.playSound, so the sound stays the server's.
    // rust: for splash in entered {
    // rust: self.apply_item_splash(splash);
}
    // rust: let _ = self.handle_mob_events(mob_fx);
    // rust: for (item, ticks, at, eye, pitch, yaw) in using {
    // rust: self.remote_player_eating(&item, ticks, at, eye, pitch, yaw);
}
        // ClientLevel.tick: the sky flash fades in a frozen level too.
    // rust: self.flash = self.flash.saturating_sub(1);
    // rust: if running {
    // rust: self.guardian_bubbles();
            // The dragon: LivingEntity's interpolation, inside its aiStep.
    // rust: let dragon_lerp = self
    // rust: .dragon
    // rust: .as_ref()
    // rust: .and_then(|d| lerps.get_mut(&(d.id as i32)))
    // rust: .filter(|l| l.steps > 0)
    // rust: .map(|l| {
    // rust: let steps = l.steps;
    // rust: l.steps -= 1;
    // rust: (l.target, l.rotation.map(|r| r.0), steps)
    // rust: });
    // rust: self.tick_remote_dragon(dragon_lerp);
            // Armor stands: ClientLevel.tickNonPassenger's setOldPosAndRot,
            // then their SteppedInterpolationHandler's step, as the mobs'.
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: for a in &mut self.armor_stands {
    // rust: let step = r
    // rust: .stepped
    // rust: .get_mut(&(a.id as i32))
    // rust: .and_then(|h| h.interpolate());
    // rust: a.interpolate(step.map(|at| {
    // rust: let p = at.position;
    // rust: (Vec3::new(p[0], p[1], p[2]), at.yaw)
    // rust: }));
}
}
            // The yaw of a boat eases toward the server's over the same steps
            // as its position, read before `step` counts one off.
    // rust: let turns: HashMap<i32, (f32, u32)> = lerps
    // rust: .iter()
    // rust: .filter(|(_, l)| l.steps > 0)
    // rust: .filter_map(|(id, l)| l.rotation.map(|r| (*id, (r.0, l.steps))))
    // rust: .collect();
            // Boats, minecarts, projectiles and the rest ease toward the
            // server's position over three ticks (`lerps`).
    // rust: let mut step = |id: u32, at: Vec3| match lerps.get_mut(&(id as i32)) {
    // rust: Some(l) if l.steps > 0 => {
    // rust: let n = f64::from(l.steps);
    // rust: l.steps -= 1;
    // rust: Vec3::new(
    // rust: at.x + (l.target[0] - at.x) / n,
    // rust: at.y + (l.target[1] - at.y) / n,
    // rust: at.z + (l.target[2] - at.z) / n,
    // rust: )
}
    // rust: _ => at,
}
    // rust: self.tick_remote_objects(
    // rust: &mut step,
    // rust: |id, yaw| {
    // rust: turns.get(&(id as i32)).map_or(yaw, |&(target, steps)| {
    // rust: super::remote_objects::lerp_yaw_step(yaw, target, steps)
    // rust: })
    // rust: },
    // rust: |c| {
    // rust: cart_lerps
    // rust: .get_mut(&(c.id as i32))
    // rust: .is_some_and(|l| l.tick(c))
    // rust: },
    // rust: );
    // rust: self.tick_remote_projectiles(&mut step);
            // LightningBolt.tick on a client.
    // rust: self.tick_bolts();
}
    // rust: lerps.retain(|_, l| l.steps > 0);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: for (id, l) in lerps {
    // rust: r.lerps.entry(id).or_insert(l);
}
    // rust: for (id, l) in cart_lerps {
    // rust: r.cart_lerps.entry(id).or_insert(l);
}
}
}
    // `AbstractMinecartRenderer.newExtractState`: sample the same weighted
    // steps at the frame's partial tick, including corners within one tick.
    // rust: pub(super) fn remote_minecart_lerp(
    // rust: &self,
    // rust: id: u32,
    // rust: partial: f32,
    // rust: ) -> Option<([f64; 3], f32, f32)> {
    // rust: let lerp = self.remote.as_ref()?.cart_lerps.get(&(id as i32))?;
    // rust: if lerp.current.is_empty() {
    // rust: return None;
}
    // rust: let (p, _, yaw, pitch) = lerp.at(partial);
    // rust: Some(([p.x, p.y, p.z], yaw, pitch))
}

    // `ClientPacketListener.handleMinecartAlongTrack`: the steps join the ones
    // the minecart has queued, if it runs `NewMinecartBehavior`.
remote_move_minecart :: proc(self: ^Self, p: play::MoveMinecartAlongTrack) {
}
    // rust: if !self.minecart_improvements() || !self.carts.iter().any(|c| c.id == p.id as u32) {
    // rust: return;
}
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let at = |v: [f64; 3]| Vec3::new(v[0], v[1], v[2]);
    // rust: r.cart_lerps
    // rust: .entry(p.id)
    // rust: .or_insert_with(CartLerp::new)
    // rust: .pending
    // rust: .extend(p.steps.iter().map(|s| CartStep {
    // rust: position: at(s.position),
    // rust: movement: at(s.movement),
    // rust: yaw: horizon_protocol::buf::unpack_degrees(s.yaw),
    // rust: pitch: horizon_protocol::buf::unpack_degrees(s.pitch),
    // rust: weight: s.weight,
    // rust: }));
}
    // `Consumable.onConsumeTick` for another player using a consumable: the
    // crumbs at their mouth every 4 ticks once 21.875% of its use has passed
    // (`shouldEmitParticlesAndSounds`; the sounds come from the server).
    // rust: fn remote_player_eating(
    // rust: &mut self,
    // rust: item: &str,
    // rust: ticks: u32,
    // rust: at: [f64; 3],
    // rust: eye: f64,
    // rust: pitch: f32,
    // rust: yaw: f32,
    // rust: ) {
    // rust: let Some(consumable) = self
    // rust: .res
    // rust: .items()
    // rust: .get(item)
    // rust: .and_then(|i| i.consumable.as_ref())
    // rust: .filter(|c| c.particles)
    // rust: else {
    // rust: return;
}
    // rust: let duration = consumable.ticks().max(0) as u32;
    // rust: let remaining = duration - ticks.min(duration);
    // rust: if !consumable.should_emit(remaining as i32) {
    // rust: return;
}
    // rust: let options = self.item_particle(&ItemStack::new(item, 1));
    // rust: let mut spawned = Vec::new();
    // rust: horizon_client::particles::item_use_particles(
    // rust: &mut self.world.random,
    // rust: pitch,
    // rust: yaw,
    // rust: at,
    // rust: at[1] + eye,
    // rust: 5,
    // rust: |p, v| spawned.push((p, v)),
    // rust: );
    // rust: for (p, v) in spawned {
    // rust: self.particles.add(&options, p, v);
}
}
    // The end of the player's tick: `AbstractBoat.tick`'s paddles (the vehicle ticks before its
    // passenger's `sendChanges`), then `LocalPlayer.sendChanges`: the input, and a passenger's look,
    // vehicle and sprint, or `sendPosition`'s sprint and move. The held slot is not sent here:
    // `MultiPlayerGameMode.tick` sends it at the start of the next tick (`remote_handle_input`).
remote_send_state :: proc(self: ^Self, input: u8) {
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let (pos, on_ground, collision, sprinting) = (
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: p.ground.on_ground,
    // rust: p.collision.horizontal,
    // rust: p.sprinting,
    // rust: );
    // rust: let (yaw, pitch) = (self.yaw, self.pitch);
    // rust: let riding = self.riding.is_some();
    // rust: let controls_camera = self.controls_camera();
    // rust: let (paddles, vehicle): (Vec<S>, Vec<S>) = self
    // rust: .remote_vehicle_packets()
    // rust: .into_iter()
    // rust: .partition(|p| matches!(p, S::PaddleBoat(_)));
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let mut out = paddles;
    // rust: if input != r.last_input {
    // rust: r.last_input = input;
    // rust: out.push(S::PlayerInput(play::PlayerInput { flags: input }));
}
        // LocalPlayer.sendIsSprintingIfNeeded.
    // rust: let sprint = |r: &mut Remote, out: &mut Vec<S>| {
    // rust: if sprinting != r.was_sprinting {
    // rust: r.was_sprinting = sprinting;
    // rust: out.push(S::PlayerCommand(play::PlayerCommand {
    // rust: id: r.entity_id,
    // rust: action: if sprinting { 1 } else { 2 },
    // rust: data: 0,
    // rust: }));
}
}
    // rust: if riding {
            // LocalPlayer.sendChanges: a passenger sends its look, then the
            // vehicle it controls and, only then, its sprint.
    // rust: out.push(S::MovePlayerRot(play::MovePlayerRot {
    // rust: yaw,
    // rust: pitch,
    // rust: flags: u8::from(on_ground) | u8::from(collision) << 1,
    // rust: }));
    // rust: if !vehicle.is_empty() {
    // rust: out.extend(vehicle);
    // rust: sprint(r, &mut out);
}
    // rust: } else {
    // rust: sprint(r, &mut out);
}
    // rust: if !riding
    // rust: && controls_camera
            // LocalPlayer.sendPosition: no move while the view is another
            // entity's (the server keeps the player on it).
    // rust: && let Some(packet) =
    // rust: r.position_sender
    // rust: .update(pos, (yaw, pitch), on_ground, collision)
    // rust: {
    // rust: out.push(packet);
}
        // Creative inventory edits are sent slot by slot (SetCreativeModeSlot).
    // rust: let mut creative_slots = Vec::new();
    // rust: if self.creative {
            // A server's open menu takes clicks, which it applies itself: what
            // this client predicts for them isn't an edit to send (it would
            // overwrite the server's stacks whenever the prediction is wrong).
    // rust: let in_menu = r.menu.is_some();
    // rust: let stacks = creative_sync_stacks(&self.inventory, &self.offhand, &self.armor);
    // rust: for (i, stack) in stacks.into_iter().enumerate() {
    // rust: if stack != r.synced[i] {
    // rust: r.synced[i] = stack.clone();
    // rust: if !in_menu {
    // rust: creative_slots.push((creative_sync_slot(i), stack));
}
}
}
}
    // rust: for packet in out {
    // rust: self.send(packet);
}
    // rust: for (slot, stack) in creative_slots {
    // rust: let item = self.to_network(&stack);
    // rust: self.send(S::SetCreativeModeSlot(play::SetCreativeModeSlot {
    // rust: slot,
    // rust: item,
    // rust: }));
}
}
creative_stacks :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: creative_sync_stacks(&self.inventory, &self.offhand, &self.armor)
}
    // `CreativeInventoryListener.slotChanged`: `handleCreativeModeItemAdd` for every slot the
    // player's inventory menu changed. `CreativeModeInventoryScreen.slotClicked` ends in
    // `broadcastChanges`, so a click's slots go out with the click, right behind a thrown
    // stack, and not at the end of the tick: a slot update the server sends meanwhile (the
    // pickup of what a held Q threw) can then never land on a change still unsent and undo it.
    // rust: pub(super) fn send_creative_slots(&mut self) {
    // rust: if !self.creative {
    // rust: return;
}
    // rust: let stacks = self.creative_stacks();
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let mut changed = Vec::new();
    // rust: for (i, stack) in stacks.into_iter().enumerate() {
    // rust: if stack != r.synced[i] {
    // rust: r.synced[i] = stack.clone();
    // rust: changed.push((creative_sync_slot(i), stack));
}
}
    // rust: for (slot, stack) in changed {
    // rust: let item = self.to_network(&stack);
    // rust: self.send(S::SetCreativeModeSlot(play::SetCreativeModeSlot {
    // rust: slot,
    // rust: item,
    // rust: }));
}
}
    // Inventory as the server last described it.
remote_synced :: proc(self: ^Self) {
}
    // rust: let stacks = self.creative_stacks();
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.synced = stacks;
}
}
    // The slots a server packet changed since `before` are as the server has them; the
    // others keep what was last sent, so a creative click made since still goes out.
remote_synced_since :: proc(self: ^Self, before: ^[Maybe(ItemStack)]) {
}
    // rust: let now = self.creative_stacks();
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: mark_synced(&mut r.synced, before, now);
}
}

    // `MultiPlayerGameMode.stopDestroyBlock`: aborts the break and starts the attack strength
    // again, if one is running (`if (!isDestroying) return;`), and says whether it did. Only the
    // progress goes: `destroyBlockPos` and `destroyingItem` keep the target, so a dig resumed on
    // the same block sends no START and the server's clock runs on (#4124).
    // rust: pub(super) fn stop_remote_mining(&mut self) -> bool {
    // rust: let kept = self.remote.as_mut().and_then(|r| {
    // rust: if !std::mem::take(&mut r.is_destroying) {
    // rust: return None;
}
    // rust: let (pos, face, _) = r.destroying?;
    // rust: r.destroying = Some((pos, face, 0.0));
    // rust: r.destroying
    // rust: });
    // rust: let Some((pos, _, _)) = kept else {
    // rust: return false;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: self.tutorial_destroy(state, -1.0);
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 2,
    // rust: pos,
    // rust: direction: 0,
    // rust: sequence: 0,
    // rust: }));
    // rust: self.reset_attack_strength();
    // rust: true
}

    // MultiPlayerGameMode.startDestroyBlock / continueDestroyBlock.
remote_mining :: proc(self: ^Self, start: bool) {
}
    // rust: let debug_stick = self
    // rust: .held()
    // rust: .is_some_and(|stack| &*stack.item == "minecraft:debug_stick");
    // rust: if !self
    // rust: .res
    // rust: .items()
    // rust: .can_destroy_block(self.held(), self.creative)
    // rust: {
    // rust: self.stop_remote_mining();
    // rust: self.mining = None;
    // rust: return;
}
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: if !start && r.destroy_delay > 0 {
    // rust: r.destroy_delay -= 1;
    // rust: return;
}
    // rust: let Some(hit) = self.pick() else {
    // rust: self.mining = None;
    // rust: return;
}
    // rust: let face = face_direction(hit.face);
    // rust: let state = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: if self.res.facts().is_air(state) {
    // rust: return;
}
        // startDestroyBlock refuses a restricted break before predicting it.
    // rust: if self.remote_break_restricted() {
    // rust: self.mining = None;
    // rust: return;
}
    // rust: if self.creative {
    // rust: let seq = self.next_sequence();
            // DebugStickItem.canDestroyBlock never lets the client break the
            // block; the server only selects the property on this START.
    // rust: if !debug_stick {
    // rust: self.predict_break(hit.pos, state, seq);
}
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 0,
    // rust: pos: hit.pos,
    // rust: direction: face,
    // rust: sequence: seq,
    // rust: }));
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.destroy_delay = 5;
}
    // rust: return;
}
    // rust: let facts = self.res.facts().get(state).clone();
        // The server's own getDestroyProgress: under water, off the ground,
        // with haste, fatigue and efficiency, so the client stops digging
        // when the server is done too (#1254).
    // rust: let progress = if facts.hardness == 0.0 {
    // rust: 1.0
    // rust: } else {
    // rust: self.destroy_progress(hit.pos)
}
        // sameDestroyTarget: the same block and still the item the break began with.
    // rust: let held = self.main_hand_key();
    // rust: let same = self.remote.as_ref().is_some_and(|r| {
    // rust: r.destroying.is_some_and(|(p, _, _)| p == hit.pos) && r.destroying_item == held
    // rust: });
        // startDestroyBlock leaves only a break that is still running alone (`isDestroying &&
        // sameDestroyTarget`); a click on the block a stopped break still names starts it again,
        // so the server re-anchors its clock. A held button carries the same target on, and that
        // one keeps the clock (#4124).
    // rust: let running = self.remote.as_ref().is_some_and(|r| r.is_destroying);
    // rust: if start && same && running {
    // rust: return;
}
    // rust: if !same || start {
            // startDestroyBlock aborts only a break that is running; a target left by a stop that
            // ended one is just replaced by the START below.
    // rust: let aborted = self.remote.as_mut().and_then(|r| {
    // rust: if !std::mem::take(&mut r.is_destroying) {
    // rust: return None;
}
    // rust: r.destroying.take()
    // rust: });
    // rust: if let Some((old, _, _)) = aborted {
    // rust: let old_state = self.world.block(old[0], old[1], old[2]);
    // rust: self.tutorial_destroy(old_state, -1.0);
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 2,
    // rust: pos: old,
    // rust: direction: face,
    // rust: sequence: 0,
    // rust: }));
}
    // rust: let seq = self.next_sequence();
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 0,
    // rust: pos: hit.pos,
    // rust: direction: face,
    // rust: sequence: seq,
    // rust: }));
    // rust: self.tutorial_destroy(state, 0.0);
            // startDestroyBlock: BlockState.attack on the client, so a redstone
            // ore's dust (RedStoneOreBlock.attack) comes before the break.
    // rust: self.redstone_ore_particles(hit.pos);
    // rust: if progress >= 1.0 {
                // startDestroyBlock: instant survival breaks have no destroy delay.
    // rust: if !debug_stick {
    // rust: self.predict_break(hit.pos, state, seq);
}
    // rust: return;
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.destroying = Some((hit.pos, face, 0.0));
    // rust: r.destroying_item = held;
    // rust: r.is_destroying = true;
}
            // startDestroyBlock plays the first hit and crack itself; the
            // server's level events 2019 and 2020 do the rest.
    // rust: self.breaking_block_effects(hit.pos, hit.face, true);
    // rust: self.mining = Some(Mining {
    // rust: pos: hit.pos,
    // rust: progress: 0.0,
    // rust: ticks: 0,
    // rust: });
    // rust: return;
}
    // rust: let Some((pos, last_face, done)) = self.remote.as_ref().and_then(|r| r.destroying) else {
    // rust: return;
}
    // rust: let done = done + progress;
    // rust: self.tutorial_destroy(state, done.clamp(0.0, 1.0));
    // rust: let ticks = self.mining.as_ref().map_or(0, |m| m.ticks) + 1;
    // rust: if done >= 1.0 {
    // rust: let seq = self.next_sequence();
            // DebugStickItem.canDestroyBlock: the server selects the property
            // and sends the block update instead; never predict a break.
    // rust: if !debug_stick {
    // rust: self.predict_break(pos, state, seq);
}
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 3,
    // rust: pos,
    // rust: direction: face,
    // rust: sequence: seq,
    // rust: }));
    // rust: if let Some(r) = self.remote.as_mut() {
                // `destroyBlockPos` remains the last target after the break;
                // if that position is filled again before the next pick, a
                // held attack resumes it without sending a second START.
    // rust: r.destroying = Some((pos, face, 0.0));
    // rust: r.is_destroying = false;
    // rust: r.destroy_delay = 5;
}
    // rust: self.mining = None;
    // rust: } else {
    // rust: if last_face != face {
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 1,
    // rust: pos,
    // rust: direction: face,
    // rust: sequence: 0,
    // rust: }));
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.destroying = Some((pos, face, done));
}
    // rust: self.mining = Some(Mining {
    // rust: pos,
    // rust: progress: done,
    // rust: ticks,
    // rust: });
}
}
    // MultiPlayerGameMode.destroyBlock: the predicted break.
predict_break :: proc(self: ^Self, pos: [i32; 3], state: BlockStateId, sequence: i32) {
}
    // rust: self.tutorial_destroy(state, 1.0);
        // BlockStatePredictionHandler.retainKnownServerState.
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.predictions
    // rust: .entry(pos)
    // rust: .and_modify(|p| p.0 = sequence)
    // rust: .or_insert((sequence, state.0 as i32));
}
        // Block.playerWillDestroy's destroy event (particles and the break
        // sound), which BaseFireBlock skips: the server's extinguish sound
        // is all a player hears.
    // rust: let facts = self.res.facts().get(state);
    // rust: if !facts.has_class("BaseFireBlock") {
    // rust: let s = facts.sounds.clone();
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.audio.play(
    // rust: &s.break_sound,
    // rust: Some(at),
    // rust: (s.volume + 1.0) / 2.0,
    // rust: s.pitch * 0.8,
    // rust: );
    // rust: self.destroy_particles(pos, state);
}
        // The server's block update follows (waterlogged blocks leave water).
    // rust: let air = self.world.air;
    // rust: if self.world.set(pos[0], pos[1], pos[2], air).is_ok() {
    // rust: self.world.block_entities.remove(&(pos[0], pos[1], pos[2]));
}
    // rust: self.mining = None;
}
    // `Player.blockActionRestricted` as far as this client reads it: a
    // spectator never breaks, an adventure player only with a main-hand
    // item the server gave `can_break`. Whether its predicate matches the
    // block is left to the server, which sends the block back if not.
remote_break_restricted :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
//         use horizon_protocol::item::{WirePatch, component::CAN_BREAK};
    // rust: self.spectator()
    // rust: || (!self.may_build()
    // rust: && !self
    // rust: .held()
    // rust: .and_then(|s| s.wire_patch())
    // rust: .is_some_and(|p| WirePatch::adds(&p, CAN_BREAK)))
}
    // Minecraft.startUseItem: use one crosshair target, then the item itself.
remote_use :: proc(self: ^Self) {
}
        // Minecraft.startUseItem returns before resetting rightClickDelay
        // while a survival block break is active.
    // rust: if self.remote.as_ref().is_some_and(|r| r.is_destroying) {
    // rust: return;
}
    // rust: self.use_delay = 4;
        // Minecraft.startUseItem: nothing is used while the hands paddle a boat.
    // rust: if self.hands_busy() {
    // rust: return;
}
        // InputEvent.InteractionKeyMappingTriggered for the main hand: a cancel
        // ends the whole click, the off hand gets no turn.
    // rust: if let Some(swing) = self.native_interaction(1, Hand::Main) {
    // rust: if swing {
    // rust: self.swing_hand(Hand::Main, SwingAnimation::DEFAULT);
}
    // rust: return;
}
        // An item a mod claims: its use is the mod's, and the server never hears of it.
    // rust: if self.mod_use_start() {
    // rust: return;
}
        // Resolve the crosshair once. A passing entity interaction keeps
        // that target and may only fall back to using the item itself.
    // rust: let entity = self.remote_use_targets_entity();
    // rust: horizon_client::interaction_input::use_on_target(&mut RemoteUseWorld(self), entity);
}

    // `Minecraft.startUseItem`'s entity turn for `hand`: Interact goes to
    // the server, and whether the click ends there is what this client's
    // copy of the entity answers (`MultiPlayerGameMode.interact`).
remote_use_entity :: proc(self: ^Self, hand: Hand) -> b {
    // Ported from Horizon
    return {}
}
        // A menu this use opens (a chest minecart's) is no clicked block's.
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.use_target = None;
}
    // rust: let sneaking = self.keys.held(Action::Sneak);
        // A boat, minecart, item frame, armor stand or painting nearer than
        // any mob: the server uses it (AbstractBoat.interact boards it).
    // rust: if let Some(hit) = self.remote_object_hit(false)
    // rust: && self.mob_hit().is_none_or(|(_, d, _)| hit.distance < d)
    // rust: && self.before_block(hit.distance)
    // rust: {
            // Interaction.interact answers SUCCESS when it responds and
            // CONSUME otherwise: both end the click (nothing behind the box
            // is used), but only SUCCESS swings; the packet carries the hand.
    // rust: let response = self.interactions.get(&hit.id).map(|i| i.response);
            // Objects whose interact passes (paintings, empty or fixed item frames,
            // boats sneaked at or out of control, carts that pass) leave each hand's
            // turn to its item: a crossbow aimed at it shoots.
    // rust: let is_painting = self.paintings.iter().any(|p| p.id as i32 == hit.id);
    // rust: let held = self.with_hand(hand, |g| g.held().cloned());
    // rust: let frame_passes = self
    // rust: .item_frames
    // rust: .iter()
    // rust: .find(|f| f.id as i32 == hit.id)
    // rust: .is_some_and(|f| {
    // rust: item_frame_interact_passes(f.fixed, f.item.is_some(), held.is_some())
    // rust: });
    // rust: let boat_passes = self
    // rust: .boats
    // rust: .iter()
    // rust: .enumerate()
    // rust: .find(|(_, b)| b.id as i32 == hit.id)
    // rust: .is_some_and(|(i, b)| {
    // rust: boat_interact_passes(
    // rust: b.chest,
    // rust: sneaking,
    // rust: b.out_of_control >= 60.0,
    // rust: self.boat_has_room(i),
    // rust: )
    // rust: });
    // rust: let (cart_passes, is_rideable_cart) = self
    // rust: .carts
    // rust: .iter()
    // rust: .find(|c| c.id as i32 == hit.id)
    // rust: .map(|c| {
    // rust: let ridden = self.riding == Some(c.id)
    // rust: || self.mobs.iter().any(|m| m.extra.mount == Some(c.id));
    // rust: (
    // rust: c.kind
    // rust: .interact_passes(sneaking, ridden, self.can_use_game_master_blocks()),
    // rust: c.kind == super::minecarts::CartKind::Rideable,
    // rust: )
    // rust: })
    // rust: .unwrap_or((false, false));
    // rust: let passes = is_painting || frame_passes || boat_passes || cart_passes;
            // Otherwise the main hand's turn takes it; there is no off hand turn.
    // rust: if response.is_none() && hand == Hand::Off && !passes {
    // rust: return false;
}
    // rust: self.send(S::Interact(play::Interact {
    // rust: id: hit.id,
    // rust: hand: hand_id(hand),
    // rust: location: hit.location,
    // rust: secondary: sneaking,
    // rust: }));
    // rust: if passes {
    // rust: return false;
}
            // Minecart.interact resets the passenger's easing baseline on
            // a successful boarding click, not on SetPassengers (commands
            // can mount a player without this interaction).
    // rust: if let Some(c) = self
    // rust: .carts
    // rust: .iter_mut()
    // rust: .find(|c| c.id as i32 == hit.id && c.kind == super::minecarts::CartKind::Rideable)
    // rust: {
    // rust: c.player_rotation_offset = c.rotation_offset;
}
            // MinecartCommandBlock.interact on the client: the editor opens.
    // rust: if self.carts.iter().any(|c| {
    // rust: c.id as i32 == hit.id && c.kind == super::minecarts::CartKind::CommandBlock
    // rust: }) {
    // rust: self.open_cart_command_block(hit.id as u32);
}
            // Minecart.interact boards the cart and answers CONSUME on the client,
            // which ends the click without an arm swing. AbstractBoat.interact
            // answers SUCCESS there, which swings.
    // rust: if remote_object_swings(response, is_rideable_cart) {
    // rust: self.with_hand(hand, Game::swing_arm);
}
    // rust: return true;
}
    // rust: if let Some((i, distance, location)) = self.mob_hit()
    // rust: && self.before_block(distance)
    // rust: {
    // rust: let id = self.mobs[i].id as i32;
    // rust: self.send(S::Interact(play::Interact {
    // rust: id,
    // rust: hand: hand_id(hand),
    // rust: location,
    // rust: secondary: sneaking,
    // rust: }));
            // Player.interactOn: another player passes, and so does a mob
            // the held item means nothing to: the item is used instead.
    // rust: let player = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.level_players.contains_key(&id));
    // rust: if !player && self.remote_mob_takes(i, hand) {
    // rust: self.remote_feed_particles(i, hand);
                // As for the objects above, only SUCCESS swings the hand: a
                // CONSUME ends the click without one.
    // rust: if self.remote_mob_swings(i, hand) {
    // rust: self.with_hand(hand, Game::swing_arm);
}
    // rust: return true;
}
}
    // rust: false
}

    // `Minecraft.startUseItem`'s block turn for `hand`: a use that swung drops
    // the hand (`LocalPlayer.itemUsed`) when it spent the held item or the
    // player has infinite materials.
remote_use_block :: proc(self: ^Self, hand: Hand) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let before = self.with_hand(hand, |g| g.held().map(|s| s.count));
    // rust: let swings = self.swings_started;
    // rust: let done = self.remote_use_item_on(hand);
    // rust: if done
    // rust: && self.swings_started != swings
    // rust: && let Some(after) = self.with_hand(hand, |g| g.held().map(|s| s.count))
    // rust: && (Some(after) != before || self.creative)
    // rust: {
    // rust: self.heights.item_used(hand);
}
    // rust: done
}

    // MultiPlayerGameMode.useItemOn for `hand`: whether the click ends there
    // (the block reacts, or a block item is placed).
remote_use_item_on :: proc(self: ^Self, hand: Hand) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let held = self.with_hand(hand, |g| g.held().cloned());
    // rust: let held_block = held
    // rust: .as_ref()
    // rust: .and_then(|h| self.items().get(&h.item))
    // rust: .is_some_and(|i| i.block.is_some());
    // rust: let debug_stick = held
    // rust: .as_ref()
    // rust: .is_some_and(|stack| &*stack.item == "minecraft:debug_stick");
    // rust: if let Some(hit) = self.pick() {
            // ShelfBlock.useItemOn consumes a nonempty main-hand click client-side
            // without predicting the inventory swap or swinging.
    // rust: let shelf_reacts = hand == Hand::Main
    // rust: && held.is_some()
    // rust: && !(self.keys.held(Action::Sneak)
    // rust: && (self.stack_in(self.selected).is_some() || self.offhand.is_some()))
    // rust: && self.shelf_hit(&hit).is_some();
    // rust: let spectator = self.spectator();
    // rust: let (result, changes) = if hand == Hand::Main && !spectator {
    // rust: self.remote_block_reacts(&hit, held.as_ref())
    // rust: } else {
                // useItemOn runs for the off hand too (useWithoutItem doesn't):
                // RespawnAnchorBlock.useItemOn charges an anchor with its
                // glowstone, SUCCESS.
    // rust: let sneaking = self.keys.held(Action::Sneak);
    // rust: let hands_full = self.stack_in(self.selected).is_some() || self.offhand.is_some();
    // rust: let charges =
    // rust: !(sneaking && hands_full) && self.anchor_takes(hit.pos, held.as_ref());
    // rust: let result = if charges {
    // rust: InteractionResult::Success
    // rust: } else {
    // rust: InteractionResult::Pass
}
    // rust: (result, DryUse::default())
}
            // DebugStickItem.useOn once the block passed: SUCCESS on the client
            // too (the hand swings below); only the server changes the block.
    // rust: let (result, changes) = if debug_stick && !spectator && !result.consumes_action() {
    // rust: (InteractionResult::Success, DryUse::default())
    // rust: } else {
    // rust: (result, changes)
}
            // AbstractCauldronBlock.useItemOn, either hand: CauldronInteractions
            // answers on the client as on the server and only the server acts,
            // so a bucket the cauldron takes is not used again (UseItem).
    // rust: let result = if result.consumes_action() || spectator {
    // rust: result
    // rust: } else {
    // rust: match self.cauldron_outcome(hit.pos, held.as_ref()) {
    // rust: horizon_client::cauldron::Outcome::Success => InteractionResult::Success,
    // rust: horizon_client::cauldron::Outcome::Consume => InteractionResult::Consume,
    // rust: horizon_client::cauldron::Outcome::Pass => result,
}
}
    // rust: let reacts = result.consumes_action();
            // useItemOn on this client, unless a sneak with something in hand
            // skips it: RedStoneOreBlock's dust, and the wick smoke of a lit
            // candle an empty hand snuffs (CandleBlock.useItemOn) or a lit
            // candle cake (CandleCakeBlock.useItemOn).
    // rust: if hand == Hand::Main && !spectator {
    // rust: let sneaking = self.keys.held(Action::Sneak);
    // rust: let hands_full = self.stack_in(self.selected).is_some() || self.offhand.is_some();
    // rust: if !(sneaking && hands_full) {
    // rust: self.redstone_ore_particles(hit.pos);
    // rust: let state = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let name = self.block_name(hit.pos);
    // rust: let lit = self.pack.assets.registry.state(state).is_some_and(|s| {
    // rust: s.properties.get("lit").map(String::as_str) == Some("true")
    // rust: });
    // rust: let snuffs = if name.ends_with("candle_cake") {
    // rust: hit.point[1] - f64::from(hit.pos[1]) > 0.5
    // rust: } else {
    // rust: name.ends_with("candle") && self.may_build()
}
    // rust: if held.is_none() && lit && snuffs {
    // rust: self.candle_smoke(hit.pos, state);
}
}
}
            // ArmorStandItem.useOn runs in startPrediction before the packet
            // goes out (the server may spawn the stand at once).
    // rust: let stand_fits = held
    // rust: .as_ref()
    // rust: .is_some_and(|s| &*s.item == "minecraft:armor_stand")
    // rust: && held
    // rust: .as_ref()
    // rust: .is_some_and(|s| self.armor_stand_spawn(&hit, s).is_some());
    // rust: let seq = self.next_sequence();
    // rust: let cursor = [
    // rust: (hit.point[0] - f64::from(hit.pos[0])) as f32,
    // rust: (hit.point[1] - f64::from(hit.pos[1])) as f32,
    // rust: (hit.point[2] - f64::from(hit.pos[2])) as f32,
    // rust: ];
    // rust: self.send(S::UseItemOn(play::UseItemOn {
    // rust: hand: hand_id(hand),
    // rust: pos: hit.pos,
    // rust: face: i32::from(face_direction(hit.face)),
    // rust: cursor,
    // rust: inside: hit.face == [0; 3],
    // rust: world_border: false,
    // rust: sequence: seq,
    // rust: }));
            // MultiPlayerGameMode.performUseItemOn: a spectator's use predicts
            // nothing and ends the click (CONSUME, no swing); the server opens
            // the block's menu.
    // rust: if spectator {
    // rust: return true;
}
            // Only a predicted placement (predict_place) marks a cell whose
            // resend plays a place sound: an empty hand or a non-block item
            // places nothing (BlockItem.place is where the sound comes from).
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.use_target = Some(hit.pos);
}
    // rust: if shelf_reacts {
    // rust: return true;
}
    // rust: if reacts {
    // rust: self.predict_use(&changes, seq);
                // LeverBlock.useWithoutItem on the client: the predicted pull puffs.
    // rust: if &*self.block_name(hit.pos) == "minecraft:lever" {
    // rust: self.lever_puff(hit.pos);
}
    // rust: self.open_command_block_if_editable((hit.pos[0], hit.pos[1], hit.pos[2]));
    // rust: self.open_block_editor_if_editable((hit.pos[0], hit.pos[1], hit.pos[2]));
                // MultiPlayerGameMode.useItemOn: SUCCESS SwingSource.CLIENT
                // (a chest, barrel, furnace, …). CONSUME does not swing.
    // rust: if result.should_swing() {
    // rust: self.with_hand(hand, Game::swing_arm);
}
    // rust: } else if self.predict_campfire_douse(hit.pos, held.as_ref(), seq) {
                // CampfireBlock.useItemOn succeeded: this hand swings and the
                // click ends, so a shield in the other hand is not raised.
    // rust: self.with_hand(hand, Game::swing_arm);
    // rust: return true;
    // rust: } else if held.as_ref().is_some_and(|s| &*s.item == "minecraft:brush") {
                // BrushItem.useOn: brushing starts here (CONSUME, no swing); the
                // server brushes and the dust is this client's own.
    // rust: self.with_hand(hand, Game::start_using_item);
    // rust: return true;
    // rust: } else if held
    // rust: .as_ref()
    // rust: .is_some_and(|s| &*s.item == "minecraft:bone_meal")
    // rust: && self.remote_bone_meal_succeeds(&hit)
    // rust: {
                // BoneMealItem.useOn succeeded on this client's level (SUCCESS;
                // the server grows the plant): this hand swings and the click
                // ends, so the other hand (a torch) is never tried.
    // rust: self.with_hand(hand, Game::swing_arm);
    // rust: return true;
    // rust: } else if stand_fits {
                // ArmorStandItem.useOn on a client level: SUCCESS once the
                // stand fits, before the server spawns it. This hand swings
                // and the click ends.
    // rust: self.with_hand(hand, Game::swing_arm);
    // rust: return true;
    // rust: } else if let Some(stack) = held
    // rust: .as_ref()
    // rust: .filter(|s| s.item.ends_with("_spawn_egg"))
    // rust: .filter(|_| {
    // rust: self.may_build()
    // rust: || self.with_hand(hand, |g| g.can_place_on_in_adventure(hit.pos))
    // rust: })
    // rust: {
                // SpawnEggItem.useOn on a client level: FAIL for a mob that
                // cannot spawn (the click ends, no swing), else SUCCESS (swing).
                // Either way no UseItem follows, so the server does not spawn
                // a second mob from the fluid ray (ItemStack.useOn passes in
                // adventure mode off can_place_on, which the filter above keeps).
    // rust: if self.spawn_egg_allowed(&stack.item) {
    // rust: self.with_hand(hand, Game::swing_arm);
}
    // rust: return true;
    // rust: } else if let Some(stack) = held.as_ref()
    // rust: && (self.predict_item_on_block(stack, &hit, hand)
    // rust: || self.predict_map_on_banner(stack, &hit))
    // rust: {
                // Item.useOn succeeded here (InteractionResult.SUCCESS):
                // this hand swings and the click ends, so the other hand
                // (a shield, a torch) is never tried.
    // rust: self.with_hand(hand, Game::swing_arm);
    // rust: return true;
}
    // rust: if held_block {
    // rust: let consumable = held
    // rust: .as_ref()
    // rust: .and_then(|stack| self.items().get(&stack.item).cloned())
    // rust: .filter(|info| info.consumable.is_some());
                // ItemStack.useOn passes in adventure mode unless the item may
                // be placed on this block: useItem eats it (a block item without
                // a consumable keeps ending the click here).
    // rust: if !reacts
    // rust: && consumable.is_some()
    // rust: && !self.may_build()
    // rust: && !self.with_hand(hand, |g| g.can_place_on_in_adventure(hit.pos))
    // rust: {
    // rust: return false;
}
    // rust: let placed = if reacts {
    // rust: None
    // rust: } else {
    // rust: held.as_ref()
    // rust: .and_then(|stack| self.remote_can_place(&hit, stack))
}
                // BlockItem.useOn: a consumable that could not be placed is used
                // (Item.use), which the server does for this same packet. CONSUME
                // does not swing, and a full player's FAIL still ends the click.
                // Adventure's can_place_on leaves the placing to the server.
    // rust: if !reacts
    // rust: && placed.is_none()
    // rust: && self.may_build()
    // rust: && let Some(info) = &consumable
    // rust: {
    // rust: self.with_hand(hand, |g| g.start_eating(info));
}
    // rust: if let Some(placed) = &placed {
    // rust: self.predict_place(placed, seq);
    // rust: if let Some(stack) = &held {
    // rust: let pos = placed.0;
    // rust: self.apply_predicted_item([pos.x, pos.y, pos.z], stack);
}
    // rust: self.with_hand(hand, Game::consume_held);
    // rust: } else if let Some(r) = self.remote.as_mut() {
                    // BlockItem.place plays its sound only once the block is set: the
                    // server's resend of the target it refused is no placement.
    // rust: r.placing = None;
}
    // rust: if placed.is_some() {
    // rust: self.with_hand(hand, Game::swing_arm);
}
                // BlockItem.place returns FAIL when placement is rejected:
                // stop this click without trying the item or the other hand.
    // rust: return true;
}
    // rust: return reacts;
}
    // rust: false
}

    // `Item.useOn` on this client's level for the items whose effects are
    // the clicker's own (`Level.levelEvent(player, ...)` and
    // `playSound(player, ...)`: the server sends them to the others only):
    // honeycomb waxing copper, and an axe, hoe or shovel transforming a
    // block (stripping, scraping, removing wax, tilling, making a path).
    // A cushion succeeds where it may be placed and spawns on the server, a
    // firework rocket wherever it may be used, and the server launches it.
    // Whether the item's use succeeded, which ends the click.
predict_item_on_block :: proc(self: ^Self, stack: ^ItemStack, hit: ^super::Hit, hand: Hand) -> b {
    // Ported from Horizon
    return {}
}
        // FireworkRocketItem.useOn: SUCCESS on the client too, so neither
        // UseItem nor the off hand follows. It passes while gliding (the use
        // boosts instead), cooling down (MultiPlayerGameMode.performUseItemOn
        // skips useOn) and in adventure mode off its can_place_on
        // (ItemStack.useOn).
    // rust: if &*stack.item == "minecraft:firework_rocket" {
    // rust: let cooling = self.items().get(&stack.item).is_some_and(|info| {
    // rust: let group = horizon_client::cooldowns::group(stack, info.use_cooldown.as_ref());
    // rust: self.cooldowns.is_on_cooldown(&group)
    // rust: });
    // rust: let gliding = self.player.as_ref().is_some_and(|p| p.fall_flying);
    // rust: return !cooling
    // rust: && !gliding
    // rust: && (self.may_build()
    // rust: || self.with_hand(hand, |g| g.can_place_on_in_adventure(hit.pos)));
}
    // rust: let at = [
    // rust: f64::from(hit.pos[0]) + 0.5,
    // rust: f64::from(hit.pos[1]) + 0.5,
    // rust: f64::from(hit.pos[2]) + 0.5,
    // rust: ];
    // rust: if &*stack.item == "minecraft:honeycomb" {
            // HoneycombItem.useOn.
    // rust: let registry = self.pack.assets.registry;
    // rust: let clicked = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let waxes = registry
    // rust: .state(clicked)
    // rust: .and_then(|old| self.res.transformers().waxed(registry, old))
    // rust: .is_some();
    // rust: if waxes {
    // rust: self.level_event_at(3003, hit.pos, 0);
    // rust: self.audio
    // rust: .play("minecraft:item.honeycomb.wax_on", Some(at), 1.0, 1.0);
}
    // rust: waxes
    // rust: } else if let Some((_, sound, _, _, particle)) =
    // rust: self.block_transform(stack, hit.pos, hit.face)
    // rust: {
    // rust: self.transform_particle(&particle, hit.pos);
    // rust: self.audio.play(&sound, Some(at), 1.0, 1.0);
    // rust: true
    // rust: } else if self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.cushion_color.is_some())
    // rust: {
            // CushionItem.useOn on a client level: SUCCESS once
            // `canBePlacedAt` holds, before the server's own checks.
    // rust: self.cushion_spawn(hit).is_some()
    // rust: } else if &*stack.item == "minecraft:painting" {
            // HangingEntityItem.useOn on a client level: SUCCESS once
            // `Painting.create` finds a surviving variant, before the
            // server spawns it.
    // rust: self.painting_fits(hit, stack)
    // rust: } else {
    // rust: false
}
}

    // `MapItem.useOn` on this client: a map used on a banner is SUCCESS
    // whatever its data says (the server toggles the marker, or fails
    // quietly), so this hand swings and the click ends. `ItemStack.useOn`
    // passes in adventure mode.
predict_map_on_banner :: proc(self: ^Self, stack: ^ItemStack, hit: ^super::Hit) -> b {
    // Ported from Horizon
    return {}
}
    // rust: super::maps::map_id(stack).is_some()
    // rust: && self.may_build()
    // rust: && self.block_in_tag("minecraft:banners", &self.block_name(hit.pos))
}

    // `BoneMealItem.useOn` on this client's level (a copy: nothing grows
    // here): whether it succeeds.
remote_bone_meal_succeeds :: proc(self: ^Self, hit: ^super::Hit) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let pos = horizon_core::position::BlockPos::new(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let face = horizon_core::geometry::Direction::ALL[face_direction(hit.face) as usize];
    // rust: self.with_level(|b, level, _| {
    // rust: b.bone_meal_succeeds_on_client(&mut DryLevel::new(level), pos, face)
    // rust: })
}

    // MultiPlayerGameMode.useItemOn inside startPrediction: the blocks the
    // use changed on this client's level at once, each kept as predicted
    // under the use's sequence until the server acknowledges it (a use the
    // server refused goes back). Only the blocks a hand opens or flips: a
    // wooden or copper door, trapdoor or fence gate, a lever or a button;
    // whatever else the use changes waits for the server.
predict_use :: proc(self: ^Self) {
}
    // rust: let facts = self.res.facts();
    // rust: let predicted = |state: BlockStateId| hand_operated(&facts.get(state).name);
    // rust: if changes.is_empty()
    // rust: || !changes
    // rust: .iter()
    // rust: .all(|(p, s)| predicted(*s) && predicted(self.world.block(p.x, p.y, p.z)))
    // rust: {
    // rust: return;
}
    // rust: self.predict_blocks(changes, seq);
        // `level.playSound(player, ...)`: the clicker hears it from its own use; the
        // server sends it to the others only.
    // rust: for (pos, sound, volume, pitch) in sounds {
    // rust: let at = [
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 0.5,
    // rust: f64::from(pos.z) + 0.5,
    // rust: ];
    // rust: let name = if sound.contains(':') {
    // rust: sound.to_string()
    // rust: } else {
    // rust: format!("minecraft:{sound}")
}
    // rust: self.audio.play(&name, Some(at), *volume, *pitch);
}
}

    // Whether the block hit takes a main-hand right click with `held`
    // (`BlockState.useItemOn`, then `useWithoutItem`): a door, a button, a
    // container, and the blocks it changed. Vanilla's client runs it on its
    // own level first; this runs it on a copy, and `predict_use` keeps the
    // changes it predicts.
    // rust: fn remote_block_reacts(
    // rust: &mut self,
    // rust: hit: &super::Hit,
    // rust: held: Option<&ItemStack>,
    // rust: ) -> (InteractionResult, DryUse) {
        // Player.isSecondaryUseActive with something in either hand.
    // rust: let hands_full = self.stack_in(self.selected).is_some() || self.offhand.is_some();
    // rust: if self.keys.held(Action::Sneak) && hands_full {
    // rust: return (InteractionResult::Pass, DryUse::default());
}
        // AbstractCauldronBlock.useItemOn (CauldronInteractions): a bucket,
        // bottle or dye the cauldron takes fills or lowers it, and the click
        // ends there instead of falling through to Item.use (which would
        // empty a water bucket into the face of the cauldron).
    // rust: if let Some(reacts) = self.remote_cauldron_reacts(hit, held) {
    // rust: return reacts;
}
    // rust: if self.jukebox_takes(hit.pos, held) {
    // rust: return (InteractionResult::Success, DryUse::default());
}
        // RespawnAnchorBlock.useItemOn: PASS when the off hand's glowstone is to
        // charge the anchor, so useWithoutItem doesn't run and the off hand's turn
        // comes (glowstone in this hand charges it in `use_item_on`).
    // rust: if !self.anchor_takes(hit.pos, held) && self.anchor_takes(hit.pos, self.offhand.as_ref()) {
    // rust: return (InteractionResult::Pass, DryUse::default());
}
        // BeehiveBlock.useItemOn: shears or a glass bottle on a full hive
        // (honey level 5) is SUCCESS, so the click ends after UseItemOn and
        // no UseItem follows (the server does the harvest, see `use_beehive`).
    // rust: if held.is_some_and(|s| matches!(&*s.item, "minecraft:shears" | "minecraft:glass_bottle"))
    // rust: && self
    // rust: .hive_state(hit.pos)
    // rust: .is_some_and(|(honey, _)| honey == Some(5))
    // rust: {
    // rust: return (InteractionResult::Success, DryUse::default());
}
        // ComposterBlock.useItemOn: a compostable item on a composter below
        // level 8 is SUCCESS on the client too (only the server adds the
        // layer), so the other hand (a torch) is never tried.
    // rust: if self.composter_takes(hit.pos, held) {
    // rust: return (InteractionResult::Success, DryUse::default());
}
//         use horizon_core::geometry::Direction;
    // rust: let face = match hit.face {
    // rust: [0, 1, 0] => Direction::Up,
    // rust: [0, -1, 0] => Direction::Down,
    // rust: [0, 0, -1] => Direction::North,
    // rust: [0, 0, 1] => Direction::South,
    // rust: [-1, 0, 0] => Direction::West,
    // rust: _ => Direction::East,
}
    // rust: let player = self.use_context();
    // rust: self.with_level(|b, level, _| {
    // rust: let mut level = DryLevel::new(level);
    // rust: let result = b.use_item_on(
    // rust: &mut level,
    // rust: &mut horizon_world::level::Ticks::default(),
    // rust: horizon_core::position::BlockPos::new(hit.pos[0], hit.pos[1], hit.pos[2]),
    // rust: face,
    // rust: horizon_core::geometry::Vec3::new(hit.point[0], hit.point[1], hit.point[2]),
    // rust: player,
    // rust: held.map(|s| &*s.item),
    // rust: );
    // rust: (result, (level.changed.into_iter().collect(), level.sounds))
    // rust: })
}

    // `AbstractCauldronBlock.useItemOn` (`CauldronInteractions`) on this
    // client's level: the cauldron's new state and the sound it made, or
    // None when the item passes and `Item.use` still has its turn. The
    // interaction player is a copy: the hand and the inventory change only
    // when the server confirms them.
    // rust: fn remote_cauldron_reacts(
    // rust: &self,
    // rust: hit: &super::Hit,
    // rust: held: Option<&ItemStack>,
    // rust: ) -> Option<(InteractionResult, DryUse)> {
//         use horizon_client::cauldron::{self, Outcome};
DryHand :: struct {
    creative: bool,
    hand: Maybe(ItemStack),
    inventory: ^'a [Maybe(ItemStack)],
}
    // rust: impl cauldron::Player for DryHand<'_> {
creative :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.creative
}
hand :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.hand
}
add :: proc(self: ^Self, _: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
contains :: proc(self: ^Self, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inventory
    // rust: .iter()
    // rust: .flatten()
    // rust: .any(|have| have.same_item_same_components(stack))
}
drop_stack :: proc(self: ^Self, _: ItemStack) {
}
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let state = registry
    // rust: .state(self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]))
    // rust: .filter(|s| s.name.ends_with("cauldron"))?
    // rust: .clone();
    // rust: let held = held?;
    // rust: let above = self.world.block(hit.pos[0], hit.pos[1] + 1, hit.pos[2]);
    // rust: let under_water = registry
    // rust: .state(above)
    // rust: .is_some_and(|s| s.name == "minecraft:water");
    // rust: let removes_dye = cauldron::removes_dye(self.items(), &held.item);
    // rust: let mut hand = DryHand {
    // rust: creative: self.creative,
    // rust: hand: Some(held.clone()),
    // rust: inventory: &self.inventory,
}
    // rust: let result = cauldron::interact(&state, under_water, removes_dye, &mut hand);
    // rust: let reaction = match result.outcome {
    // rust: Outcome::Pass => return None,
    // rust: Outcome::Success => InteractionResult::Success,
    // rust: Outcome::Consume => InteractionResult::Consume,
}
    // rust: let pos = horizon_core::position::BlockPos::new(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let mut changes = Vec::new();
    // rust: if let Some(block) = result.block
    // rust: && let Ok(new) = registry.resolve(&block)
    // rust: {
    // rust: changes.push((pos, new));
}
    // rust: let sounds = match result.sound {
    // rust: Some(sound) => vec![(pos, std::sync::Arc::from(sound), 1.0, 1.0)],
    // rust: None => Vec::new(),
}
    // rust: Some((reaction, (changes, sounds)))
}

    // MultiPlayerGameMode.useItemOn inside startPrediction, for a block item:
    // the blocks `BlockItem.place` set at `pos` are placed on this client's
    // level at once, so the next click of a fast bridge aims at them rather
    // than past them (the server would refuse it). Its place sound is the
    // placer's own (`playSound(player, ...)`: the server sends it to the
    // others only).
predict_place :: proc(self: ^Self) {
}
    // rust: let ticks = self.ticks;
    // rust: if let Some(r) = self.remote.as_mut() {
            // set_block plays the place sound of the block at `placing`.
    // rust: r.placing = Some(([pos.x, pos.y, pos.z], ticks));
}
    // rust: self.predict_blocks(changes, seq);
}
    // The blocks a use changed, set on this client's level and kept as
    // predicted under the use's sequence until the server acknowledges it
    // (`BlockStatePredictionHandler.retainKnownServerState`): a use the
    // server refused goes back.
    // rust: pub(super) fn predict_blocks(&mut self, changes: &DryChanges, seq: i32) {
    // rust: for &(p, state) in changes {
    // rust: let pos = [p.x, p.y, p.z];
    // rust: let before = self.world.block(p.x, p.y, p.z);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.predictions
    // rust: .entry(pos)
    // rust: .and_modify(|e| e.0 = seq)
    // rust: .or_insert((seq, before.0 as i32));
}
    // rust: self.set_block(pos, state.0 as i32);
}
}

    // Run BlockItem.place on a disposable level: where it placed and the
    // blocks it set. The real level supplies collision shapes and
    // building-blocking entities; random draws, scheduled ticks and events
    // stay in the preview.
remote_can_place :: proc(self: ^Self, hit: ^super::Hit, stack: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.may_build() {
    // rust: return None;
}
    // rust: let ctx = horizon_world::level::PlaceContext {
    // rust: clicked_pos: horizon_core::position::BlockPos::new(hit.pos[0], hit.pos[1], hit.pos[2]),
    // rust: face: horizon_core::geometry::Direction::ALL[face_direction(hit.face) as usize],
    // rust: hit: Vec3::new(hit.point[0], hit.point[1], hit.point[2]),
    // rust: inside: hit.face == [0; 3],
    // rust: yaw: self.yaw,
    // rust: pitch: self.pitch,
    // rust: sneaking: self.keys.held(Action::Sneak),
    // rust: item: stack.item.to_string(),
    // rust: can_use_game_master_blocks: self.can_use_game_master_blocks(),
}
    // rust: self.with_level(|b, level, _| {
    // rust: let mut level = DryLevel::new(level);
    // rust: match b.place_block(
    // rust: &mut level,
    // rust: &mut horizon_world::level::Ticks::default(),
    // rust: &ctx,
    // rust: ) {
    // rust: horizon_world::level::PlaceOutcome::Placed { pos, .. } => {
    // rust: Some((pos, level.changed.into_iter().collect()))
}
    // rust: horizon_world::level::PlaceOutcome::Failed => None,
}
    // rust: })
}

    // `MultiPlayerGameMode.useItem`'s local `ItemStack.use` for a bucket:
    // `BucketItem.use` picks its own target and runs `pickupBlock` or
    // `emptyContents` on this client's level inside `startPrediction`, so
    // its success (which decides `itemUsed`) and the blocks it changes are
    // the client's own. A fill into a waterloggable block changes nothing
    // here: `SimpleWaterloggedBlock.placeLiquid` tests `isClientSide` and
    // leaves the block update to the server.
    // rust: fn remote_use_bucket(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: ) -> (bool, Option<DryChanges>, Vec<DrySound>) {
        // `BucketItem.use`: `level.mayInteract` and `mayUseItemAt`.
    // rust: if !self.may_build() {
    // rust: return (false, None, Vec::new());
}
    // rust: if &*stack.item == "minecraft:bucket" {
    // rust: let Some(hit) = self.bucket_hit() else {
    // rust: return (false, None, Vec::new());
}
    // rust: let pos = horizon_core::position::BlockPos::new(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let creative = self.creative;
    // rust: return self.with_level(|b, level, ticks| {
    // rust: let mut level = DryLevel::new(level);
    // rust: let picked = b.bucket_pickup(&mut level, ticks, pos, creative).is_some();
    // rust: (
    // rust: picked,
    // rust: Some(level.changed.into_iter().collect()),
    // rust: std::mem::take(&mut level.sounds),
    // rust: )
    // rust: });
}
    // rust: let Some((content, sound, _)) = horizon_client::items::bucket_contents(&stack.item) else {
    // rust: return (false, None, Vec::new());
}
    // rust: let Some(hit) = self.pick() else {
    // rust: return (false, None, Vec::new());
}
    // rust: let target = self.bucket_target(content, &hit);
    // rust: let pos = horizon_core::position::BlockPos::new(target[0], target[1], target[2]);
    // rust: let [x, y, z] = hit.beside();
    // rust: let beside = Some(horizon_core::position::BlockPos::new(x, y, z));
    // rust: let sneaking = self.keys.held(Action::Sneak);
    // rust: let creative = self.creative;
    // rust: self.with_level(|b, level, ticks| {
    // rust: let mut level = DryLevel::new(level);
    // rust: let emptied = b.bucket_empty(
    // rust: &mut level, ticks, pos, beside, content, sound, sneaking, creative,
    // rust: );
            // Water poured into a liquid container (where it went, which may
            // be the block beside a refusing one) fills it server-side only.
    // rust: let client_change = !(content.is_water()
    // rust: && emptied.is_some_and(|at| {
//                     use horizon_world::level::LevelAccess as _;
    // rust: b.is_liquid_container(level.block_state(at))
    // rust: }));
    // rust: (
    // rust: emptied.is_some(),
    // rust: client_change.then(|| level.changed.into_iter().collect()),
    // rust: std::mem::take(&mut level.sounds),
    // rust: )
    // rust: })
}

    // MultiPlayerGameMode.useItem for `hand`, if it holds something: whether
    // the click ends there, as far as this client can tell (`use_ends_click`).
remote_use_item :: proc(self: ^Self, hand: Hand) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(held) = self.with_hand(hand, |g| g.held().cloned()) else {
    // rust: return false;
}
        // A mod's claimed item is never used on the server; its own use
        // starts from the main hand only (`mod_use_start`).
    // rust: if self.native_input.claimant(&held.item).is_some() {
    // rust: return false;
}
    // rust: let seq = self.next_sequence();
    // rust: self.send(S::UseItem(play::UseItem {
    // rust: hand: hand_id(hand),
    // rust: sequence: seq,
    // rust: yaw: self.yaw,
    // rust: pitch: self.pitch,
    // rust: }));
    // rust: let Some(info) = self.items().get(&held.item).cloned() else {
    // rust: return false;
}
        // MultiPlayerGameMode.useItem's prediction: an item cooling down
        // passes (its packet still goes).
    // rust: let group = horizon_client::cooldowns::group(&held, info.use_cooldown.as_ref());
    // rust: if self.cooldowns.is_on_cooldown(&group) {
    // rust: return false;
}
        // a mod's item used over time starts here too, as the server starts it.
    // rust: if self.with_hand(hand, |g| g.start_mod_use(&held)) {
    // rust: return true;
}
        // Item.use: Equippable.swapWithEquipmentSlot runs on this client too, so
        // the armor slot and the hand change at once (the server confirms).
    // rust: if info.equip_slot.is_some() && self.with_hand(hand, |g| g.equip_from_hand(&held)) {
            // Equippable.swapWithEquipmentSlot's SUCCESS (SwingSource.CLIENT).
    // rust: self.with_hand(hand, Game::swing_arm);
    // rust: return true;
}
        // `ItemStack.use` runs on this client too: a bucket's own ray and its
        // pick/empty contents decide whether the click succeeds (a failed
        // fill or pickup leaves the hand alone), and the blocks it sets are
        // this use's prediction.
    // rust: if &*held.item == "minecraft:bucket"
    // rust: || horizon_client::items::bucket_contents(&held.item).is_some()
    // rust: {
    // rust: let (succeeded, changes, sounds) = self.with_hand(hand, |g| g.remote_use_bucket(&held));
    // rust: if let Some(changes) = changes {
    // rust: self.predict_blocks(&changes, seq);
}
            // `BucketItem.emptyContents` / evaporate: `playSound(player, …)` on
            // this client; the server leaves the actor out (#4684).
    // rust: for (pos, sound, volume, pitch) in sounds {
    // rust: let at = [
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 0.5,
    // rust: f64::from(pos.z) + 0.5,
    // rust: ];
    // rust: let name = if sound.contains(':') {
    // rust: sound.to_string()
    // rust: } else {
    // rust: format!("minecraft:{sound}")
}
    // rust: self.audio.play(&name, Some(at), volume, pitch);
}
            // BucketItem.use's SUCCESS (SwingSource.CLIENT) on this client.
    // rust: if succeeded {
    // rust: self.with_hand(hand, Game::swing_arm);
}
    // rust: return succeeded;
}
        // SpawnEggItem.use on the client succeeds after a SOURCE_ONLY block
        // hit; the server alone tests LiquidBlock and the placement permission.
    // rust: if held.item.ends_with("_spawn_egg") {
    // rust: let succeeded = self.spawn_egg_allowed(&held.item) && self.bucket_hit().is_some();
    // rust: if succeeded {
    // rust: self.with_hand(hand, Game::swing_arm);
}
    // rust: return succeeded;
}
        // Food starts being eaten (Consumable.startConsuming). A food that
        // can't be eaten (full and not always-edible) fails the use
        // (InteractionResult.FAIL): startUseItem tries the other hand, and
        // no cooldown or use animation starts.
    // rust: let eating = self.with_hand(hand, |g| g.start_eating(&info));
    // rust: if info.food.is_some() && !eating {
    // rust: return false;
}
        // A bucket, a glass bottle or a boat with nothing to fill, empty or
        // place PASSes or FAILs: startUseItem goes on to the off hand (a
        // Riptide trident there charges).
    // rust: if self.with_hand(hand, |g| g.use_finds_no_target(&held)) {
    // rust: return false;
}
        // It runs the use here too: ItemStack.use starts the `use_cooldown`
        // of an item with no use time, and the server's
        // ClientboundCooldownPacket confirms it; one held in use starts it at
        // finishUsingItem (remote_complete_using).
    // rust: if !info.consumable.as_ref().is_some_and(|c| c.ticks() > 0) {
    // rust: self.apply_use_cooldown(&held);
}
    // rust: if self.with_hand(hand, |g| g.remote_use_book(&held)) {
            // WritableBookItem.use's SUCCESS (SwingSource.CLIENT).
    // rust: self.with_hand(hand, Game::swing_arm);
    // rust: return true;
}
        // BowItem.use and CrossbowItem.use FAIL with nothing to shoot: no
        // itemUsed (the hand doesn't dip) and the other hand's turn comes.
    // rust: if !self.with_hand(hand, |g| g.remote_start_held_use(&held)) {
    // rust: return false;
}
    // rust: let gliding = self.player.as_ref().is_some_and(|p| p.fall_flying);
        // FireworkRocketItem.use while gliding: SUCCESS (SwingSource.PREDICTED),
        // so startUseItem swings this hand itself; a vanilla server swings it
        // for the other players only.
    // rust: if gliding && &*held.item == "minecraft:firework_rocket" {
    // rust: self.with_hand(hand, Game::swing_arm);
}
        // A stack's own `blocks_attacks` raises it as a shield's does.
    // rust: let blocks = self.blocks_attacks(&held).is_some();
    // rust: let ends = use_ends_click(&info, gliding) || blocks;
        // MultiPlayerGameMode.useItem: `ItemStack.use`'s SUCCESS swings
        // (SwingSource.CLIENT); CONSUME does not — a bow, crossbow, trident
        // or spear starting its charge, and `ItemUtils.startUsingInstantly`'s
        // food, drink, spyglass, shield and goat horn.
    // rust: if ends && !blocks && remote_use_swings(&held, info.consumable.is_some()) {
    // rust: self.with_hand(hand, Game::swing_arm);
}
    // rust: ends
}

    // Whether `held`'s `Item.use` needs a target this client sees none of
    // (not SUCCESS): BucketItem.use (a fluid source or powder snow to pick
    // up through `ClipContext.Fluid.SOURCE_ONLY`, a block to empty a full
    // one against, `mayUseItemAt`), BottleItem.use (water to fill from) and
    // BoatItem.use (a block or fluid surface with room for the boat).
use_finds_no_target :: proc(self: ^Self, held: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = &*held.item;
    // rust: let facts = |pos: [i32; 3]| {
    // rust: self.res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
}
    // rust: let source = |want: Option<Fluid>| {
    // rust: let fluid_hit = self.pick_fluid();
            // pick_fluid steps through waterlogged blocks, but their water is
            // a source the SOURCE_ONLY ray stops at (and a BucketPickup).
    // rust: if let Some(hit) = self.pick()
    // rust: && facts(hit.pos).waterlogged
    // rust: {
    // rust: let eye = self.aim().map_or(hit.point, |(eye, _)| eye);
    // rust: let d = |p: [f64; 3]| (0..3).map(|a| (p[a] - eye[a]).powi(2)).sum::<f64>();
    // rust: if fluid_hit
    // rust: .as_ref()
    // rust: .is_none_or(|fluid| d(fluid.point) >= d(hit.point))
    // rust: {
    // rust: return want.is_none_or(|want| want == Fluid::Water);
}
}
    // rust: fluid_hit.is_some_and(|hit| {
    // rust: let f = facts(hit.pos);
    // rust: let fluid = f.fluid != Fluid::None && f.fluid_level == 8 && !f.fluid_falling;
    // rust: match want {
    // rust: Some(want) => fluid && f.fluid == want,
    // rust: None => fluid || self.is_powder_snow(hit.pos),
}
    // rust: })
}
        // SolidBucketItem only has useOn: its use is Item.use's PASS.
    // rust: if id == "minecraft:powder_snow_bucket" {
    // rust: return true;
}
    // rust: if id == "minecraft:bucket" {
    // rust: return !self.may_build() || !source(None);
}
    // rust: if horizon_client::items::bucket_contents(id).is_some() {
    // rust: return !self.may_build() || self.pick().is_none();
}
    // rust: if id == "minecraft:glass_bottle" {
            // A dragon's breath cloud never counts here: its owner is not
            // synced, so this client's BottleItem.use finds none and PASSes;
            // the packet still goes and the server fills the bottle.
    // rust: return !source(Some(Fluid::Water));
}
    // rust: if super::boats::any_boat_wood(id).is_some() {
    // rust: return self.boat_to_place(held).is_none();
}
    // rust: false
}
    // `Item.use` runs on the client too (MultiPlayerGameMode.useItem): an
    // item held in use until the button lets go starts being used here, so
    // that letting go sends RELEASE_USE_ITEM (Minecraft.handleKeybinds) and
    // the server ends the use: a bow or a trident is let go, a crossbow's
    // charge ends, a shield is lowered, a spyglass stops scoping. Their
    // sounds, loaded arrows and thrown tridents come from the server.
    // False when the use FAILs here: a bow or an uncharged crossbow with
    // nothing to shoot.
remote_start_held_use :: proc(self: ^Self, held: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.using.is_some() {
    // rust: return true;
}
    // rust: let bundle = self.items().get(&held.item).is_some_and(|i| i.bundle);
    // rust: let start = match &*held.item {
            // BundleItem.use: always starts; the server drops the contents.
    // rust: _ if bundle => true,
            // BowItem.use: with an arrow, or in creative.
    // rust: "minecraft:bow" => self.get_projectile(held).is_some() || self.creative,
            // CrossbowItem.use: charging when not charged and with ammunition;
            // a charged one shoots on the server.
    // rust: "minecraft:crossbow" => {
    // rust: if held.data().is_some_and(|d| !d.charged.is_empty()) {
    // rust: return true;
}
    // rust: self.get_projectile(held).is_some()
}
            // TridentItem.use: not about to break, Riptide only in water or rain.
    // rust: "minecraft:trident" => {
                // FAIL: no dip, and the off hand gets its turn.
    // rust: return self.use_trident(held);
}
            // SpyglassItem.use (its sound is the server's).
    // rust: "minecraft:spyglass" => true,
            // InstrumentItem.use: the horn plays here too (`playSound(player, ...)`
            // skips the player's own client), the server's copy tells the others.
    // rust: "minecraft:goat_horn" => {
    // rust: self.remote_use_instrument(held);
    // rust: return true;
}
            // EnderEyeItem.use: startUsingItem unless an End portal frame is
            // aimed at, with or without a stronghold to throw the eye at.
    // rust: "minecraft:ender_eye" => !self.aims_at_end_portal_frame(),
            // Item.use: a kinetic weapon starts being used.
    // rust: id if horizon_client::spear::Kinetic::of(id).is_some() => true,
            // ShieldItem.use: anything that blocks attacks, off cooldown.
    // rust: _ => {
    // rust: self.raise_shield(self.held_slot());
    // rust: return true;
}
}
    // rust: if start {
    // rust: self.start_using_item();
}
    // rust: start || !matches!(&*held.item, "minecraft:bow" | "minecraft:crossbow")
}
    // `InstrumentItem.use` on this client: unless the horn is on cooldown,
    // it is held up, plays its sound at the player and starts its cooldown.
remote_use_instrument :: proc(self: ^Self, held: ^ItemStack) {
}
    // rust: let Some(instrument) = self.res.items().instrument(held) else {
    // rust: return;
}
    // rust: let group = horizon_client::cooldowns::group(held, None);
    // rust: if self.cooldowns.is_on_cooldown(&group) {
    // rust: return;
}
    // rust: self.start_using_item();
    // rust: self.play_player_bound_sound(&instrument.sound, 2, instrument.range / 16.0, 1.0, true);
    // rust: if instrument.use_duration > 0.0 {
    // rust: self.add_cooldown(group, instrument.use_ticks());
}
}
    // Whether `stack` stays in use until the button lets go (bows,
    // crossbows, tridents, spyglasses, shields, eyes of ender, whose
    // `getUseDuration` 0 never counts down to the end) or the server ends
    // it (a mod's item): its use only counts ticks here.
held_until_released :: proc(self: ^Self, stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.mod_use(stack) {
    // rust: return true;
}
    // rust: matches!(
    // rust: &*stack.item,
    // rust: "minecraft:bow"
    // rust: | "minecraft:crossbow"
    // rust: | "minecraft:trident"
    // rust: | "minecraft:spyglass"
    // rust: | "minecraft:ender_eye"
    // rust: ) || horizon_client::spear::Kinetic::of(&stack.item).is_some()
    // rust: || self.blocks_attacks(stack).is_some()
}

    // The rest of Minecraft.startUseItem once the main hand's target passed:
    // the main hand's item, then the off hand's turn (its block, its item).
    // The server does each packet's part with that packet's hand only.
remote_use_hands :: proc(self: ^Self) {
}
        // A successful Item.use always drops the hand (LocalPlayer.itemUsed).
    // rust: if self.remote_use_item(Hand::Main) {
    // rust: self.heights.item_used(Hand::Main);
    // rust: return;
}
        // The off hand's turn: the event again, then the entity or the block.
    // rust: if let Some(swing) = self.native_interaction(1, Hand::Off) {
    // rust: if swing {
    // rust: self.swing_hand(Hand::Off, SwingAnimation::DEFAULT);
}
    // rust: return;
}
    // rust: let off_target = if self.remote_use_targets_entity() {
    // rust: self.remote_use_entity(Hand::Off)
    // rust: } else {
    // rust: self.remote_use_block(Hand::Off)
}
    // rust: if off_target {
    // rust: return;
}
    // rust: if self.remote_use_item(Hand::Off) {
    // rust: self.heights.item_used(Hand::Off);
}
}
    // `LivingEntity.updatingUsingItem` on a server client: an item held in
    // use (`held_until_released`), and a consumable's eating animation and
    // its crumbs until the server's USE_ITEM_COMPLETE. The server sends the
    // stack, its hunger and the sounds.
remote_tick_using :: proc(self: ^Self) {
}
    // rust: let Some((slot, ticks)) = self.using else {
            // A mod's use the game reset (the server stopping the use...).
    // rust: self.end_mod_use();
    // rust: return;
}
    // rust: let stack = self.stack_in(slot).cloned();
        // The use stops when the hand no longer holds the item it began with
        // (ItemStack.isSameItem).
    // rust: let item = stack.as_ref().map(|s| Arc::clone(&s.item));
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: if ticks == 0 {
    // rust: r.use_item = item;
    // rust: } else if r.use_item != item {
    // rust: self.using = None;
    // rust: self.end_mod_use();
    // rust: return;
}
}
        // Another hotbar slot picked: LivingEntity.updatingUsingItem sees a
        // different stack in the hand. The off hand keeps its item.
    // rust: let in_hand = slot == self.selected || slot == super::shield::OFFHAND_SLOT;
        // A mod's item: held until the button lets go, counted for the mod.
    // rust: if self.mod_use_tick(slot, ticks, !self.right || !in_hand) {
    // rust: return;
}
        // updatingUsingItem runs here too: a use a mod's tick ran out stays
        // frozen until let go (RELEASE_USE_ITEM) or the server finishes it.
    // rust: if let Some(s) = stack.as_ref().filter(|_| in_hand)
    // rust: && !self.use_item_ticked(s, ticks)
    // rust: {
    // rust: return;
}
        // BrushItem.onUseTick: with no block aimed the use ends (the server
        // ends it too); a stroke shows its dust. Its sounds are the server's.
    // rust: if stack
    // rust: .as_ref()
    // rust: .is_some_and(|s| &*s.item == "minecraft:brush")
    // rust: {
    // rust: let elapsed = ticks + 1;
    // rust: let hit = self.pick().filter(|_| in_hand);
    // rust: if let Some(hit) = &hit
    // rust: && elapsed % 10 == 5
    // rust: {
    // rust: self.brush_dust(hit, slot == super::shield::OFFHAND_SLOT);
}
    // rust: if hit.is_none() && in_hand {
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 6,
    // rust: pos: [0; 3],
    // rust: direction: 0,
    // rust: sequence: 0,
    // rust: }));
}
    // rust: self.using = hit.and(Some((slot, elapsed))).filter(|_| elapsed < 200);
    // rust: return;
}
        // BundleItem.getUseDuration: 200 ticks, the server drops the contents.
    // rust: if stack
    // rust: .as_ref()
    // rust: .is_some_and(|s| self.items().get(&s.item).is_some_and(|i| i.bundle))
    // rust: {
    // rust: self.using = (in_hand && ticks + 1 < 200).then_some((slot, ticks + 1));
    // rust: return;
}
        // A drawn bow, a charging crossbow, a raised shield...: held until
        // the button lets go.
    // rust: if let Some(s) = stack.as_ref().filter(|s| self.held_until_released(s)) {
    // rust: if in_hand && (self.mod_use(s) || self.blocks_attacks(s).is_some()) {
    // rust: self.item_on_use_tick(s, ticks);
}
    // rust: self.using = in_hand.then_some((slot, ticks + 1));
    // rust: return;
}
        // A goat horn is held up for its instrument's use duration.
    // rust: if let Some(duration) = stack
    // rust: .as_ref()
    // rust: .and_then(|s| self.res.items().instrument(s))
    // rust: .map(|i| i.use_ticks().max(0) as u32)
    // rust: {
    // rust: self.using = (in_hand && ticks + 1 < duration).then_some((slot, ticks + 1));
    // rust: return;
}
    // rust: let consumable = stack
    // rust: .as_ref()
    // rust: .and_then(|s| self.items().get(&s.item))
    // rust: .and_then(|i| i.consumable.clone());
    // rust: let (Some(stack), Some(consumable)) = (stack, consumable) else {
    // rust: self.using = None;
    // rust: return;
}
        // Button release belongs to the next handleKeybinds phase, which
        // sends RELEASE_USE_ITEM. Do not silently clear a use begun by a
        // quick press/release between ticks.
    // rust: if !in_hand {
    // rust: self.using = None;
    // rust: return;
}
        // Consumable.startConsuming eats one with no use time at once, without
        // a use (nor a USE_ITEM_COMPLETE).
    // rust: if consumable.ticks() <= 0 {
    // rust: self.using = None;
    // rust: return;
}
        // Consumable.shouldEmitParticlesAndSounds, as in tick_used_item. The
        // countdown goes on past zero (LivingEntity.updateUsingItem completes
        // only on the server) until the server's USE_ITEM_COMPLETE.
        // getUseItemRemainingTicks: the duration this use started with.
    // rust: let remaining = self.use_duration - ticks as i32;
    // rust: if consumable.should_emit(remaining) {
            // `emit_consume` plays the eat sound and spawns the bites (when the
            // item has consume particles), as `tick_used_item` does on the
            // player's own server.
    // rust: self.emit_consume(&consumable, &stack, 5);
}
    // rust: self.item_on_use_tick(&stack, ticks);
    // rust: self.using = Some((slot, ticks + 1));
}
    // `Player.handleEntityEvent(9)`: `completeUsingItem` on the client. A consumable's last crumbs, and FoodProperties.onConsume,
    // which runs on the client too (Consumable.onConsume calls its
    // ConsumableListeners on both sides): the client's FoodData eats at once,
    // so a held right click finds `Player.canEat` false instead of starting
    // another bite before the server's ClientboundSetHealth arrives.
remote_complete_using :: proc(self: ^Self) {
}
    // rust: let Some((slot, _)) = self.using.take() else {
    // rust: return;
}
    // rust: let Some(stack) = self.stack_in(slot).cloned() else {
    // rust: return;
}
    // rust: let Some(info) = self.items().get(&stack.item).cloned() else {
    // rust: return;
}
        // Consumable.onConsume's emitParticlesAndSounds(16): the last crumbs
        // and bite, which the server plays for the others only.
    // rust: if let Some(consumable) = &info.consumable {
    // rust: self.emit_consume(consumable, &stack, 16);
}
    // rust: if let Some((nutrition, saturation)) = info.food
    // rust: && let Some(r) = self.remote.as_mut()
    // rust: {
            // FoodData.eat(nutrition, saturation), as finish_consuming does;
            // the next ClientboundSetHealth replaces it.
    // rust: let (_, food, sat) = &mut r.health;
    // rust: *food = (*food + nutrition as i32).clamp(0, 20);
    // rust: *sat = (*sat + saturation).clamp(0.0, *food as f32);
    // rust: self.apply_remote_health();
}
        // ItemStack.finishUsingItem's applyAfterUseComponentSideEffects.
    // rust: self.apply_use_cooldown(&stack);
}
    // MouseHandler updates KeyMapping; handleKeybinds sends packets on a tick.
    // rust: pub(super) fn remote_mouse(&mut self, button: MouseButton, pressed: bool) -> Result<()> {
//         use horizon_client::interaction_input::Button;
    // rust: let input = match button {
    // rust: MouseButton::Left => {
    // rust: self.toggles
    // rust: .button(2, pressed, false, self.settings.toggle_attack);
    // rust: self.left = self.toggles.is_down(2);
    // rust: Some(Button::Attack)
}
    // rust: MouseButton::Right => {
    // rust: self.toggles
    // rust: .button(3, pressed, false, self.settings.toggle_use);
    // rust: self.right = self.toggles.is_down(3);
    // rust: Some(Button::Use)
}
    // rust: MouseButton::Middle => Some(Button::Pick),
    // rust: _ => None,
}
    // rust: if pressed
    // rust: && let Some(button) = input
    // rust: && let Some(remote) = self.remote.as_mut()
    // rust: {
    // rust: remote.input.press(button);
}
    // rust: Ok(())
}

    // rust: pub(super) fn request_remote_mining_stop(&mut self) {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.stop_mining = true;
}
}

remote_handle_input :: proc(self: ^Self) {
}
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let mut input = std::mem::take(&mut r.input);
    // rust: let stop = std::mem::take(&mut r.stop_mining);
    // rust: let ready = r.loaded_sent
    // rust: && self.screen == Screen::Playing
    // rust: && self.sleeping.is_none()
    // rust: && !self.dialog_open();
        // MultiPlayerGameMode.tick, first in Minecraft.tick, screen or not: the slot
        // chosen since the last tick (the wheel, the last tick's number keys, the
        // server's SetHeldSlot) goes out before anything else of this tick.
    // rust: self.remote_send_carried();
    // rust: if stop || !ready {
    // rust: self.stop_remote_mining();
}
    // rust: if !ready {
            // A screen's opening released the keys (`KeyMapping.releaseAll`).
    // rust: self.hotbar_presses.clear();
    // rust: return;
}
    // rust: let (attack, use_item) = (self.left, self.right);
    // rust: input.tick(&mut RemoteInputWorld(self), attack, use_item);
    // rust: self.remote_queued_keys();
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.input = input;
}
}

    // `MultiPlayerGameMode.ensureHasSentCarriedItem`: the server hears of a
    // new selected slot before anything the slot acts with.
remote_send_carried :: proc(self: ^Self) {
}
    // rust: if let Some(r) = &self.remote
    // rust: && r.carried.get() != Some(self.selected)
    // rust: {
    // rust: r.carried.set(Some(self.selected));
    // rust: r.session.send(S::SetCarriedItem(play::SetCarriedItem {
    // rust: slot: self.selected as i16,
    // rust: }));
}
}

remote_queued_keys :: proc(self: ^Self) {
}
        // handleKeybinds' keybind polls: the queued presses act now, in tick
        // order, so no packet goes out between CLIENT_TICK_END and a pong.
    // rust: let pending = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .map(|r| std::mem::take(&mut r.pending_keys))
    // rust: .unwrap_or_default();
    // rust: for key in pending {
    // rust: match key {
    // rust: KeyCode::KeyF if !self.spectator() => self.remote_swap_hands(),
    // rust: KeyCode::KeyQ if !self.spectator() => {
                    // Minecraft.hasControlDown: the physical keys, so a toggled
                    // sprint on Left Control does not make Q drop the stack.
    // rust: let all = self.has_control_down() || std::mem::take(&mut self.pad.drop_stack);
    // rust: self.remote_drop(all);
}
    // rust: KeyCode::KeyE
    // rust: if !self.in_portal_transition()
    // rust: && (self.riding_mount_with_menu() || self.riding_chest_boat()) =>
    // rust: {
    // rust: let id = self.remote.as_ref().map_or(0, |r| r.entity_id);
    // rust: self.send(S::PlayerCommand(play::PlayerCommand {
    // rust: id,
    // rust: action: 5,
    // rust: data: 0,
    // rust: }));
}
    // rust: _ => {}
}
}
    // rust: if self.clicks.miss_time > 0 {
    // rust: self.clicks.miss_time -= 1;
}
}

remote_start_attack :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.clicks.miss_time > 0 {
    // rust: return false;
}
    // rust: if self.spectator() {
            // Minecraft.startAttack: a spectator's click on an entity asks
            // to watch through it (MultiPlayerGameMode.spectate); a click on
            // nothing still tells the server (spectatorNoAction).
    // rust: let target = self.spectator_click_target();
    // rust: self.send(S::SpectatorAction(play::SpectatorAction { target }));
    // rust: return true;
}
    // rust: let spear = self
    // rust: .held()
    // rust: .and_then(|s| horizon_client::spear::Kinetic::of(&s.item));
    // rust: if spear.is_some() && self.cannot_attack_with_item(self.hand_strength.ticker, 0) {
    // rust: return false;
}
        // InputEvent.InteractionKeyMappingTriggered, after the checks that stop
        // an attack: a cancel ends it there, swinging unless the mod said not to.
    // rust: if let Some(swing) = self.native_interaction(0, Hand::Main) {
    // rust: if swing {
    // rust: let animation = spear.map_or(SwingAnimation::DEFAULT, |k| k.attack_animation());
    // rust: self.swing_hand(Hand::Main, animation);
}
    // rust: return false;
}
        // A spear jabs (`MultiPlayerGameMode.piercingAttack`): the server
        // stabs, this client swings, plays the sound and starts its charge
        // again.
    // rust: if let Some(kinetic) = spear {
            // ServerboundPlayerActionPacket.Action.STAB.
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 8,
    // rust: pos: [0; 3],
    // rust: direction: 0,
    // rust: sequence: 0,
    // rust: }));
    // rust: self.hand_strength.reset_attack();
    // rust: self.swing_hand(Hand::Main, kinetic.attack_animation());
    // rust: self.play_at_feet(kinetic.attack_sound);
    // rust: return true;
}
    // rust: let mut instant = false;
        // A ghast's fireball or a wind charge nearer than any mob: the
        // server turns it (game/deflect.rs).
    // rust: if let Some((i, distance)) = self.redirectable_hit()
    // rust: && self.mob_hit().is_none_or(|(_, d, _)| distance <= d)
    // rust: && self.before_block(distance)
    // rust: && self.creatures.projectiles[i].id != 0
    // rust: {
    // rust: self.send(S::Attack(play::Attack {
    // rust: id: self.creatures.projectiles[i].id as i32,
    // rust: }));
    // rust: self.reset_attack_strength();
    // rust: } else if let Some(hit) = self.remote_object_hit(true)
    // rust: && self.mob_hit().is_none_or(|(_, d, _)| hit.distance < d)
    // rust: && self.before_block(hit.distance)
    // rust: {
            // VehicleEntity.hurtServer, ItemFrame and ArmorStand hurtServer,
            // a painting broken or an EndCrystal hurtServer: the server decides.
    // rust: self.send(S::Attack(play::Attack { id: hit.id }));
    // rust: self.reset_attack_strength();
    // rust: } else if let Some((i, distance, _)) = self.mob_hit()
    // rust: && self.before_block(distance)
    // rust: {
            // Minecraft.startAttack: an item's attack_range must hold the hit.
    // rust: if self.held_range_allows(distance) {
    // rust: self.send(S::Attack(play::Attack {
    // rust: id: self.mobs[i].id as i32,
    // rust: }));
    // rust: self.pvp_attacked(self.mobs[i].id as i32, distance);
    // rust: self.remote_player_attack(i);
    // rust: self.reset_attack_strength();
}
    // rust: } else if !self.entity_targeted()
    // rust: && let Some(hit) = self.pick()
    // rust: {
    // rust: self.remote_mining(true);
    // rust: instant = self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]));
    // rust: } else {
    // rust: if !self.creative {
    // rust: self.clicks.miss_time = 10;
}
    // rust: self.reset_attack_strength();
}
    // rust: self.swing_arm();
    // rust: self.send(S::Punch(Empty));
    // rust: instant
}

    // `MultiPlayerGameMode.attack` runs `Player.attack` on this client too.
    // For a mob `hurtOrSimulate` fails here (`Entity.hurtClient`), so the
    // hit has no attacker side; but `RemotePlayer.hurtClient` is true, so a
    // hit on another player with extra knockback runs the attacker's side of
    // `causeExtraKnockback`: the 0.6 horizontal speed cut and the sprint
    // stop. Without it the next move outruns the server's player.
remote_player_attack :: proc(self: ^Self, mob: uint) {
}
        // Java dispatches this through the target's RemotePlayer type. The
        // level_players map is profile bookkeeping and can lag the entity;
        // mobs must stay out because their hurtClient returns false.
    // rust: if self.mobs[mob].kind.id != "minecraft:player" {
    // rust: return;
}
        // `getAttackStrengthScale(0.5)`: here the ticker is `hand_strength`'s
        // (`attack_ticks` only counts in the local world), and the attack
        // speed is the player's synced attribute, which a server may change.
    // rust: let speed = self
    // rust: .own_attribute("minecraft:attack_speed")
    // rust: .unwrap_or_else(|| self.main_hand_attack_speed());
    // rust: let strength = self.hand_strength.scale(0.5, speed);
        // Player.attack's damage: a riptide spin's, or this client's own
        // ATTACK_DAMAGE, which the held item and effects don't change here.
    // rust: let spin = self.player.as_ref().map_or(0.0, |p| p.auto_spin_attack_dmg);
    // rust: let damage = if spin > 0.0 {
    // rust: spin
    // rust: } else {
    // rust: self.own_attribute("minecraft:attack_damage")
    // rust: .map_or(1.0, |v| v as f32)
}
    // rust: let knockback = self
    // rust: .own_attribute("minecraft:attack_knockback")
    // rust: .map_or(0.0, |v| v as f32);
    // rust: let sprinting = self.player.as_ref().is_some_and(|p| p.sprinting);
    // rust: if !horizon_client::attack_strength::attacker_slows_after_hit(
    // rust: damage, knockback, strength, sprinting,
    // rust: ) {
    // rust: return;
}
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: let slowdown = horizon_client::attack_strength::ATTACKER_SLOWDOWN;
    // rust: p.velocity = Vec3::new(
    // rust: p.velocity.x * slowdown,
    // rust: p.velocity.y,
    // rust: p.velocity.z * slowdown,
    // rust: );
}
    // rust: self.stop_sprint_after_extra_knockback();
}
    // The latency the server's player list gives this player
    // (`PlayerInfo.getLatency`). A new entry reads 0 until the server's first
    // latency update (every 600 ticks), so 0 shows nothing rather than `0 ms`.
    // rust: pub(super) fn own_latency(&self) -> Option<i32> {
    // rust: let r = self.remote.as_ref()?;
    // rust: let me = r.tab_players.get(&r.profile)?;
    // rust: (me.latency > 0).then_some(me.latency)
}

    // An attribute's value on this client's player, if its map has the attribute.
own_attribute :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let p = self.player.as_mut()?;
    // rust: let key = p.attributes.key(id)?;
    // rust: p.attributes.lookup(Some(&key))?;
    // rust: p.attributes
    // rust: .value(Some(key), horizon_world::attribute_map::ValueKind::Computed)
    // rust: .ok()
}

remote_continue_attack :: proc(self: ^Self, down: bool) {
}
    // rust: if !down {
    // rust: self.clicks.miss_time = 0;
}
        // A piercing weapon neither breaks blocks nor swings on its own.
    // rust: if self.clicks.miss_time > 0
    // rust: || self.using.is_some()
    // rust: || self
    // rust: .held()
    // rust: .is_some_and(|s| horizon_client::spear::Kinetic::of(&s.item).is_some())
    // rust: {
    // rust: return;
}
    // rust: let entity = self.entity_targeted();
    // rust: if down
    // rust: && !entity
    // rust: && let Some(hit) = self.pick()
    // rust: {
    // rust: let state = self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]);
    // rust: let air = self.res.facts().is_air(state);
            // InputEvent.InteractionKeyMappingTriggered, before the dig goes on:
            // a cancel digs nothing and swings unless the mod said not to.
    // rust: let canceled = if air {
    // rust: None
    // rust: } else {
    // rust: self.native_interaction(0, Hand::Main)
}
    // rust: if canceled.is_none() && !air {
                // MultiPlayerGameMode.continueDestroyBlock starts with ensureHasSentCarriedItem.
    // rust: self.remote_send_carried();
}
    // rust: if let Some(swing) = canceled {
    // rust: if swing {
    // rust: self.swing_arm();
    // rust: self.send(S::Punch(Empty));
}
    // rust: } else if self.remote_break_restricted() {
                // continueDestroyBlock returned false: no swing.
    // rust: } else if !air {
    // rust: self.remote_mining(false);
    // rust: self.swing_arm();
    // rust: self.send(S::Punch(Empty));
    // rust: } else {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.destroying = None;
    // rust: r.is_destroying = false;
}
    // rust: self.mining = None;
}
    // rust: } else {
            // `stopDestroyBlock` returns at once for a break that is not running: a pick that
            // missed once a break stopped ends nothing, so the dig's accumulated progress stays
            // and goes on growing on the jumps that follow (#4124).
    // rust: if self.stop_remote_mining() {
    // rust: self.mining = None;
}
}
}
    // Keys with a multiplayer meaning; returns true when consumed.
    // rust: pub(super) fn remote_key(&mut self, key: KeyCode) -> Result<bool> {
    // rust: if self.screen != Screen::Playing {
    // rust: if (key == KeyCode::KeyE || key == KeyCode::Escape) && self.screen == Screen::Inventory
    // rust: {
    // rust: self.remote_close_container();
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
    // rust: return Ok(true);
}
    // rust: return Ok(false);
}
    // rust: match key {
    // rust: KeyCode::KeyT | KeyCode::Slash | KeyCode::Enter => {
                // ChatScreen, over the server's command tree.
    // rust: self.open_chat_method(if key == KeyCode::Slash { "/" } else { "" });
                // `Minecraft.handleKeybinds` opens it in the call that then
                // releases an active use (Gui.handleKeybinds runs before the
                // isUsingItem branch).
    // rust: self.release_use_for_keybind_screen();
    // rust: Ok(true)
}
    // rust: KeyCode::KeyQ => {
    // rust: if self.spectator() {
    // rust: return Ok(true);
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.pending_keys.push(key);
}
    // rust: Ok(true)
}
            // Open the ridden vehicle's own screen (`HasCustomInventoryScreen`)
            // instead of the player's inventory: riding a horse, llama or
            // chest boat, the inventory key sends
            // ServerboundPlayerCommandPacket OPEN_INVENTORY.
    // rust: KeyCode::KeyE if self.riding_mount_with_menu() || self.riding_chest_boat() => {
    // rust: if self.in_portal_transition() {
    // rust: return Ok(true);
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.pending_keys.push(key);
}
    // rust: Ok(true)
}
    // rust: KeyCode::KeyE => {
    // rust: if self.in_portal_transition() {
    // rust: return Ok(true);
}
                // The inventory opens without telling the server.
    // rust: if self.tutorial.open_inventory() {
    // rust: self.persist_tutorial_step();
}
    // rust: self.recipe_ui.reset_screen();
    // rust: if self.creative {
    // rust: self.screen = Screen::Creative;
    // rust: self.refresh_creative_tabs();
    // rust: self.creative_screen.reopen();
    // rust: self.refresh_saved_hotbars();
    // rust: } else {
    // rust: self.screen = Screen::Inventory;
}
    // rust: self.craft_size = 2;
    // rust: self.capture(false);
                // `Minecraft.handleKeybinds` opens the inventory in the same
                // call that then releases an active use.
    // rust: self.release_use_for_keybind_screen();
    // rust: Ok(true)
}
    // rust: _ => Ok(false),
}
}
    // `Minecraft.handleKeybinds`: a key that opens a screen runs
    // `Gui.setScreen`, whose `KeyMapping.releaseAll` clears the use key, and
    // the same invocation then releases an active use
    // (`player.isUsingItem() && !keyUse.isDown()` → `releaseUsingItem`).
    // Only the screens opened from those keybinds do this (inventory, chat,
    // advancements); the pause menu, server containers, mount inventories and
    // dialogs release on the first tick after closing instead, as vanilla
    // does.
    // rust: pub(super) fn release_use_for_keybind_screen(&mut self) {
        // Only a server's client holds a use to release.
    // rust: if self.remote.is_none() {
    // rust: return;
}
        // `KeyMapping.releaseAll` clears key.use; without this the button still
        // reads held and a use would start again on the first tick back.
    // rust: self.right = false;
    // rust: horizon_client::interaction_input::release_on_screen_open(&mut RemoteInputWorld(self));
}
    // `MultiPlayerGameMode.releaseUsingItem`: sends `RELEASE_USE_ITEM` and
    // runs the client half of `Item.releaseUsing` (a Riptide launch moves the
    // player itself). Vanilla reaches it both when the use key is let go and,
    // in the same tick, when a keybind opens a screen.
release_remote_use :: proc(self: ^Self) {
}
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 6,
    // rust: pos: [0; 3],
    // rust: direction: 0,
    // rust: sequence: 0,
    // rust: }));
        // a mod's Stop may skip the item's release, and a mod's own release follows.
    // rust: let hand = self.used_hand();
    // rust: if let Some((slot, ticks)) = self.using.take()
    // rust: && let Some(hand) = hand
    // rust: && let Some(stack) = self.stack_in(slot).cloned()
    // rust: {
    // rust: self.with_hand(hand, |g| {
    // rust: if !g.use_item_stopped(&stack, ticks) {
    // rust: return;
}
    // rust: if &*stack.item == "minecraft:trident" {
    // rust: g.release_trident(g.ticks_held(&stack, ticks));
}
    // rust: g.mod_release_using(&stack, ticks);
    // rust: });
}
}
    // ClientPacketListener.sendChat / sendCommand, signed with a chat
    // session (game/remote_chat.rs). The Chat option's Hidden and System
    // levels keep chat out and Hidden keeps the commands out (ChatAbilities).
    // rust: pub(super) fn send_chat(&mut self, message: &str) {
    // rust: let message = message.trim();
    // rust: if message.is_empty() || !self.chat_abilities().allows(message) {
    // rust: return;
}
    // rust: if let Some(command) = message.strip_prefix('/') {
    // rust: if self.studio_command(command) {
    // rust: return;
}
    // rust: self.send_command(command);
    // rust: } else {
    // rust: self.send_signed_chat(message);
}
}
    // MultiPlayerGameMode.dropItem (key.drop): predict the removal, then send
    // the action; swing only if a nonempty stack was removed.
    // rust: pub(super) fn remote_drop(&mut self, all: bool) {
    // rust: let dropped =
    // rust: horizon_client::items::take_held_drop(&mut self.inventory[self.selected], all, false);
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: if all { 4 } else { 5 },
    // rust: pos: [0; 3],
    // rust: direction: 0,
    // rust: sequence: 0,
    // rust: }));
    // rust: if dropped.is_some() {
    // rust: self.swing_hand(Hand::Main, SwingAnimation::DEFAULT);
}
}
    // Minecraft.handleKeybinds, key.swapOffhand: the server swaps the hands
    // (ServerboundPlayerActionPacket SWAP_ITEM_WITH_OFFHAND at BlockPos.ZERO, facing down) and
    // sends both slots back; nothing is predicted.
    // rust: pub(super) fn remote_swap_hands(&mut self) {
    // rust: self.send(S::PlayerAction(play::PlayerAction {
    // rust: action: 7,
    // rust: pos: [0; 3],
    // rust: direction: 0,
    // rust: sequence: 0,
    // rust: }));
        // Equal stacks swap with no slot update to wait for.
    // rust: let (main, off) = (self.stack_in(self.selected), self.offhand.as_ref());
    // rust: let moves = !super::hand::matches_for_swap(main, off);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.swap_answer = [moves; 2];
}
}
    // The server set inventory `slot` (`shield::OFFHAND_SLOT` for the off
    // hand), `changed` from the stack this client held there. The stack
    // that answers a swap (`setItemInHand`) is another object, which the
    // hand shows after the swap animation (`hand_stack_replaced`); other
    // updates of a hand's slot count as the held stack changing in place,
    // as this client doesn't predict every use the way vanilla's does
    // (a thrown snowball's stack shrinks only when the server says so).
remote_hand_slot_set :: proc(self: ^Self, slot: uint, changed: bool) {
}
    // rust: let hand = if slot == super::shield::OFFHAND_SLOT {
    // rust: 1
    // rust: } else if slot == self.selected {
    // rust: 0
    // rust: } else {
    // rust: return;
}
    // rust: let answer = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .is_some_and(|r| std::mem::take(&mut r.swap_answer[hand]));
    // rust: if answer && changed {
    // rust: self.hand_stack_replaced(slot);
}
}
    // A container click: the server answers with the authoritative slots.
    // rust: pub(super) fn remote_click(&mut self, right: bool) {
    // rust: let Some(size) = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map(|r| [r.config.width, r.config.height])
    // rust: else {
    // rust: return;
}
    // rust: let batch = HudBatch::new(size);
    // rust: let Some(internal) = self.slot_at(&batch, self.cursor.0, self.cursor.1) else {
    // rust: return;
}
    // rust: let input = if self.has_shift_down() {
    // rust: Input::QuickMove
    // rust: } else {
    // rust: Input::Pickup
}
    // rust: if self.screen == Screen::Creative {
            // CreativeModeInventoryScreen.slotClicked: the Survival Inventory tab clicks the
            // player's own InventoryMenu, and its CreativeInventoryListener sends each slot that
            // changed (SetCreativeModeSlot). No ContainerClick: a server holding the carried
            // stack would give it back after the Destroy Item slot cleared it (#3307).
    // rust: self.menu_click(Some(internal), i32::from(right), input);
    // rust: return;
}
    // rust: self.remote_menu_ops(&[(Some(internal), i32::from(right), input)]);
}
    // `AbstractContainerMenu.setItem`/`initializeContents`: the state id a
    // click answers with is the open menu's, not another window's.
remote_menu_state :: proc(self: ^Self, container: i32, state: i32) {
}
    // rust: let open = self.remote_menu().0;
    // rust: if let Some(r) = self.remote.as_mut().filter(|_| container == open) {
    // rust: r.state_id = state;
}
}
    // The server's open menu: its window id and menu type (0, "inventory"
    // when none is open).
    // rust: pub(super) fn remote_menu(&self) -> (i32, String) {
    // rust: match self.remote.as_ref().and_then(|r| r.menu.clone()) {
    // rust: Some((id, name)) => (id, name),
    // rust: None => (0, "inventory".to_owned()),
}
}
    // `MultiPlayerGameMode.handleContainerInput` for each click of `ops` on
    // the server's open menu (a quick craft drag is several): the verified
    // menu engine predicts them on this client's copy, then each goes out as
    // a `ContainerClick` with the slots it changed and the carried stack
    // after it; the server corrects anything it sees differently. A menu the
    // engine doesn't model sends the clicks unpredicted. False when a click's
    // slot isn't one of the menu's.
    // rust: pub(super) fn remote_menu_ops(&mut self, ops: &[(Option<usize>, i32, Input)]) -> bool {
        // CrafterScreen.slotClicked: a slot toggle goes out before the click.
    // rust: if let [(Some(slot), button, input)] = ops {
    // rust: self.crafter_slot_clicked(*slot, *button, *input);
}
    // rust: let (container, menu) = self.remote_menu();
    // rust: let mut clicks = Vec::with_capacity(ops.len());
    // rust: for &(slot, button, input) in ops {
    // rust: let slot = match slot {
    // rust: None => -999,
    // rust: Some(internal) => match Self::menu_slot_index(&menu, internal) {
    // rust: Some(s) => s as i16,
    // rust: None => return false,
    // rust: },
}
    // rust: clicks.push((slot, button, input));
}
        // Unpredicted: nothing changed, the carried stack as it is.
    // rust: let mut sent: Vec<Predicted> = clicks
    // rust: .iter()
    // rust: .map(|&(slot, button, input)| (slot, button, input, Vec::new(), self.carried.clone()))
    // rust: .collect();
    // rust: let mut threw = false;
        // The engine's slot indices are the menu's own, as on the network.
    // rust: self.menu_session(|m, env, _| {
    // rust: let Some((predicted, dropped)) = predict_clicks(m, env, &clicks) else {
                // The server throws on it too: nothing is predicted.
    // rust: return Some(false);
}
    // rust: sent = predicted;
    // rust: threw = dropped;
    // rust: Some(true)
    // rust: });
    // rust: self.send_clicks(container, sent);
        // LivingEntity.drop(.., Prediction.PREDICTED): the client swings its own
        // main hand; the server shows the swing only to the other players.
    // rust: if threw {
    // rust: self.swing_hand(Hand::Main, SwingAnimation::DEFAULT);
}
    // rust: true
}
    // A Shift double click on a server (`AbstractContainerScreen.mouseReleased`):
    // a predicted QUICK_MOVE for every slot the engine moves, each sent.
    // rust: pub(super) fn remote_quick_move_all(&mut self, slot: usize, moved: &ItemStack) {
    // rust: let (container, _) = self.remote_menu();
    // rust: let mut sent: Vec<Predicted> = Vec::new();
    // rust: self.menu_session(|m, env, to_menu| {
    // rust: let clicked = to_menu(slot)?;
    // rust: let mut before = menu_items(m);
    // rust: let mut each = |m: &horizon_client::menu::Menu, t: usize| {
    // rust: let changed = changed_slots(&before, m);
    // rust: sent.push((t as i16, 0, Input::QuickMove, changed, m.carried.clone()));
    // rust: before = menu_items(m);
}
    // rust: Some(
    // rust: m.quick_move_all_each(env, clicked, moved, &mut each)
    // rust: .is_ok(),
    // rust: )
    // rust: });
    // rust: self.send_clicks(container, sent);
}
send_clicks :: proc(self: ^Self, container: i32, clicks: [dynamic]Predicted) {
}
        // A result the engine claims to have changed is the one the server
        // agrees to (`click_agreed`), so it sends none: keep it. A result the
        // engine doesn't claim (a recipe it doesn't know) the server sends.
    // rust: if matches!(
    // rust: self.remote_menu().1.as_str(),
    // rust: "inventory" | "minecraft:crafting"
    // rust: ) && let Some(r) = self.remote.as_mut()
    // rust: {
    // rust: for (.., changed, _) in &clicks {
    // rust: if let Some((_, result)) = changed.iter().find(|(slot, _)| *slot == 0) {
    // rust: r.craft_result = result.clone();
}
}
}
    // rust: let state = self.remote.as_ref().map_or(0, |r| r.state_id);
    // rust: let hashed = |g: &Self, s: &Option<ItemStack>| g.hashed_stack(s);
    // rust: for (slot, button, input, changed, carried) in clicks {
    // rust: let changed = changed.iter().map(|(i, s)| (*i, hashed(self, s))).collect();
    // rust: let carried = hashed(self, &carried);
    // rust: self.send(S::ContainerClick(play::ContainerClick {
    // rust: container,
    // rust: state,
    // rust: slot,
    // rust: button: button as i8,
    // rust: input: input_ordinal(input),
    // rust: changed,
    // rust: carried,
    // rust: }));
}
}
    // The server's open menu is the inventory or a chest-like container
    // (chests, barrels, ender chests: `generic_9xN`; shulker boxes).
    // rust: pub(super) fn remote_storage_open(&self) -> bool {
    // rust: match self.remote.as_ref().and_then(|r| r.menu.as_ref()) {
    // rust: None => true,
    // rust: Some((_, name)) => {
    // rust: name == "inventory"
    // rust: || name.starts_with("minecraft:generic_9x")
    // rust: || name == "minecraft:shulker_box"
}
}
}
    // A click outside a server's window (slot -999): predicted like
    // `MultiPlayerGameMode.handleContainerInput` (the carried stack after
    // `doClick`; the server drops the stack and swings the hand).
    // rust: pub(super) fn remote_throw(&mut self, right: bool, input: horizon_client::menu::Input) {
//         use horizon_client::menu::Input;
    // rust: let container = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.menu.as_ref())
    // rust: .map_or(0, |m| m.0);
    // rust: if input == Input::Pickup
    // rust: && let Some(c) = self.carried.as_mut()
    // rust: {
    // rust: if right && c.count > 1 {
    // rust: c.count -= 1;
    // rust: } else {
    // rust: self.carried = None;
}
    // rust: self.swing_arm();
}
    // rust: let carried = self.hashed_stack(&self.carried);
    // rust: let state = self.remote.as_ref().map_or(0, |r| r.state_id);
    // rust: self.send(S::ContainerClick(play::ContainerClick {
    // rust: container,
    // rust: state,
    // rust: slot: -999,
    // rust: button: i8::from(right),
    // rust: input: if input == Input::Throw { 4 } else { 0 },
    // rust: changed: Vec::new(),
    // rust: carried,
    // rust: }));
}
    // `CreativeModeInventoryScreen.slotClicked` outside the window: the server knows nothing of
    // a stack picked from the creative screen, so the carried stack (an item tab's right click:
    // one of it) is dropped through `handleCreativeModeItemDrop`, a SetCreativeModeSlot to slot
    // -1, and the hand swings as `Player.drop` predicts.
    // rust: pub(super) fn remote_creative_drop(&mut self, right: bool) {
    // rust: let one = right && !self.creative_inventory_open();
    // rust: let Some(carried) = self.carried.as_mut() else {
    // rust: return;
}
    // rust: let thrown = if one && carried.count > 1 {
    // rust: carried.count -= 1;
    // rust: ItemStack {
    // rust: count: 1,
    // rust: ..carried.clone()
}
    // rust: } else {
    // rust: self.carried.take().expect("carried")
}
    // rust: self.remote_creative_throw(thrown);
}
    // `MultiPlayerGameMode.handleCreativeModeItemDrop`: a stack thrown out of the creative
    // screen goes to the server as a SetCreativeModeSlot to slot -1, which drops it from the
    // player's hand; the client only swings (`Player.drop` on a client).
    // rust: pub(super) fn remote_creative_throw(&mut self, thrown: ItemStack) {
    // rust: if !self.creative {
    // rust: return;
}
    // rust: self.swing_arm();
    // rust: let item = self.to_network(&Some(thrown));
    // rust: self.send(S::SetCreativeModeSlot(play::SetCreativeModeSlot {
    // rust: slot: -1,
    // rust: item,
    // rust: }));
}
    // rust: pub(super) fn remote_close_container(&mut self) {
    // rust: let id = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.menu.as_ref().map(|m| m.0))
    // rust: .unwrap_or(0);
    // rust: self.send(S::ContainerClose(play::ContainerClose { container: id }));
    // rust: self.remote_close_local();
}
remote_close_local :: proc(self: ^Self) {
}
        // `Gui.setScreen` clears the focus of the screen it takes down: the
        // container's keyboard focus must not outlive it (a Tab bound to the
        // inventory moves the focus and closes the container in one press).
    // rust: self.pad_clear_focus();
    // rust: self.recipe_ui.reset_screen();
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.menu = None;
    // rust: r.menu_title = None;
    // rust: r.craft_result = None;
}
    // rust: self.mount_menu_reset();
        // The client's menu has no level access: what it holds is the server's.
    // rust: self.station = None;
        // AbstractContainerMenu.removed: the server gives the grid and the
        // carried stack back to the inventory and syncs it; the copies here
        // are stale the moment the window closes.
    // rust: self.craft_grid.fill(None);
    // rust: self.carried = None;
    // rust: self.craft_size = 2;
    // rust: if let Some(key) = self.container.take() {
            // Server containers stay renderable but lose their copied slots.
    // rust: if let Some(entity) = self.world.block_entities.get_mut(&key) {
    // rust: for s in entity.slots_mut() {
    // rust: *s = None;
}
}
}
}
    // A server's trading window (MerchantScreen over a ClientSideMerchant).
    // rust: fn remote_open_merchant(
    // rust: &mut self,
    // rust: container: i32,
    // rust: title: String,
    // rust: text: horizon_client::text::Text,
    // rust: ) {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.menu = Some((container, "minecraft:merchant".to_owned()));
    // rust: r.menu_title = Some(text);
}
    // rust: let session = horizon_client::merchant::Session::new(Vec::new(), true);
    // rust: self.open_remote_merchant(session, (!title.is_empty()).then_some(title));
}
    // ClientboundMerchantOffersPacket.
remote_merchant_offers :: proc(self: ^Self, p: play::MerchantOffers) {
}
    // rust: if self.open_menu_name(p.container) != "minecraft:merchant" {
    // rust: return;
}
    // rust: let cost = |g: &Self, c: &play::NetCost| {
    // rust: g.to_stack(&Some(c.clone().into()))
    // rust: .map(|stack| horizon_client::merchant::ItemCost { stack })
}
    // rust: let offers: Vec<_> = p
    // rust: .offers
    // rust: .iter()
    // rust: .filter_map(|o| {
    // rust: let mut offer = horizon_client::merchant::MerchantOffer {
    // rust: base_cost_a: cost(self, &o.cost_a)?,
    // rust: cost_b: match &o.cost_b {
    // rust: Some(b) => Some(cost(self, b)?),
    // rust: None => None,
    // rust: },
    // rust: result: self.to_stack(&Some(o.result.clone()))?,
    // rust: uses: o.uses,
    // rust: max_uses: o.max_uses,
    // rust: reward_exp: true,
    // rust: special_price_diff: o.special_price,
    // rust: demand: o.demand,
    // rust: price_multiplier: o.price_multiplier,
    // rust: xp: o.xp,
}
                // setToOutOfStock.
    // rust: if o.out_of_stock {
    // rust: offer.uses = offer.max_uses;
}
    // rust: Some(offer)
    // rust: })
    // rust: .collect();
    // rust: if let Some(m) = self.station.as_mut().and_then(|s| s.merchant.as_mut()) {
    // rust: m.session.offers = offers;
    // rust: m.session.level = p.level;
    // rust: m.session.xp = p.xp;
    // rust: m.session.villager = p.show_progress;
}
}
    // ClientboundOpenScreenPacket for the menus Horizon draws.
remote_open_screen :: proc(self: ^Self, p: play::OpenScreen) {
}
        // A new RecipeBookComponent owns fresh ghost slots and an overlay,
        // even when the server replaces a menu without a close packet.
    // rust: self.recipe_ui.reset_screen();
    // rust: let menu = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| {
    // rust: r.builtin
    // rust: .get("minecraft:menu")?
    // rust: .name(p.menu)
    // rust: .map(str::to_owned)
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let target = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .and_then(|r| r.use_target.take())
    // rust: .map(|t| (t[0], t[1], t[2]));
        // The server names a mod menu's block itself: it, not the last
        // clicked block, is the one the menu is of. Only for this window:
        // any other's is stale.
    // rust: let extra = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .and_then(|r| r.menu_extra.take())
    // rust: .filter(|e| e.window == p.container);
    // rust: let target = extra
    // rust: .as_ref()
    // rust: .map(|e| (e.pos[0], e.pos[1], e.pos[2]))
    // rust: .or(target);
    // rust: if menu == "minecraft:lectern" {
            // LecternScreen: the book and page come in the menu's content and data.
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.menu = Some((p.container, menu));
}
    // rust: self.remote_open_lectern(target.unwrap_or_default());
    // rust: return;
}
    // rust: if let Some(kind) = Self::remote_station_kind(&menu) {
    // rust: let title = menu_title(&p.title);
    // rust: let pos = target.map_or([0, 0, 0], |t| [t.0, t.1, t.2]);
    // rust: self.remote_open_station(p.container, menu, kind, title, pos);
    // rust: return;
}
    // rust: if menu == "minecraft:merchant" {
            // A trading window: its offers follow in a MerchantOffers packet.
    // rust: let title = plain(
    // rust: &p.title,
    // rust: &self
    // rust: .remote
    // rust: .as_ref()
    // rust: .map(|r| r.lang.clone())
    // rust: .unwrap_or_default(),
    // rust: );
    // rust: self.remote_open_merchant(p.container, title, menu_title(&p.title));
    // rust: return;
}
    // rust: let mod_type = horizon_client::containers::mod_menu_type(&menu);
    // rust: let entity = match menu.as_str() {
    // rust: "minecraft:crafting" => None,
    // rust: "minecraft:furnace" | "minecraft:blast_furnace" | "minecraft:smoker" => {
    // rust: let kind = match menu.as_str() {
    // rust: "minecraft:blast_furnace" => FurnaceKind::BlastFurnace,
    // rust: "minecraft:smoker" => FurnaceKind::Smoker,
    // rust: _ => FurnaceKind::Furnace,
}
    // rust: Some(BlockEntity::Furnace(Furnace {
    // rust: kind,
    // rust: items: [None, None, None],
    // rust: lit_remaining: 0,
    // rust: lit_total: 0,
    // rust: cooking_timer: 0,
    // rust: cooking_total: 0,
    // rust: speed: 1.0,
    // rust: recipes_used: std::collections::HashMap::new(),
    // rust: }))
}
            // HopperMenu, and DispenserMenu (MenuType.GENERIC_3x3: dispensers
            // and droppers).
    // rust: "minecraft:hopper" => Some(BlockEntity::Chest(vec![None; 5])),
            // BrewingStandMenu: its times come in ContainerSetData.
    // rust: "minecraft:brewing_stand" => Some(BlockEntity::Brewing(Box::new(
    // rust: horizon_client::brewing::BrewingStand::new(),
    // rust: ))),
    // rust: "minecraft:generic_3x3" => Some(BlockEntity::Chest(vec![None; 9])),
            // CrafterMenu: the disabled slots and triggered come in ContainerSetData.
    // rust: "minecraft:crafter_3x3" => Some(BlockEntity::Crafter(Default::default())),
    // rust: m if m.starts_with("minecraft:generic_9x") || m == "minecraft:shulker_box" => {
    // rust: let rows = m
    // rust: .strip_prefix("minecraft:generic_9x")
    // rust: .and_then(|r| r.parse::<usize>().ok())
    // rust: .unwrap_or(3);
    // rust: Some(BlockEntity::Chest(vec![None; rows * 9]))
}
            // A content mod's menu type: its container's slots, which its
            // mod's screen places.
    // rust: _ if mod_type.is_some() => Some(BlockEntity::Mod(Box::new(
    // rust: horizon_client::containers::ModBlockEntityFields {
    // rust: items: vec![None; mod_type.map_or(0, |t| t.slots)],
    // rust: ..Default::default()
}
    // rust: .into(),
    // rust: ))),
    // rust: _ => {
                // Unsupported menu: tell the server we closed it.
    // rust: self.send(S::ContainerClose(play::ContainerClose {
    // rust: container: p.container,
    // rust: }));
    // rust: self.chat_line(
    // rust: horizon_client::text::Text::literal(format!(
    // rust: "(Horizon cannot show {menu} screens yet)"
    // rust: )),
    // rust: horizon_client::chat::ChatSource::Client,
    // rust: );
    // rust: return;
}
}
    // rust: let title = menu_title(&p.title);
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.menu = Some((p.container, menu.clone()));
    // rust: r.menu_title = Some(title);
}
    // rust: self.craft_size = if menu == "minecraft:crafting" { 3 } else { 2 };
    // rust: self.container = None;
    // rust: if let Some(entity) = entity {
            // The clicked block shows the menu when it holds that container;
            // an ender chest's or a double chest's slots are no one block's,
            // so they go under a key no block has.
    // rust: let holds = |k: &(i32, i32, i32)| {
    // rust: let name = &self.res.facts().get(self.world.block(k.0, k.1, k.2)).name;
    // rust: BlockEntity::for_block(name).is_some_and(|e| {
    // rust: e.id() == entity.id() && e.slots().len() == entity.slots().len()
    // rust: })
}
    // rust: let key = target.filter(holds).unwrap_or((i32::MIN, 0, 0));
    // rust: self.world.block_entities.insert(key, entity);
    // rust: self.container = Some(key);
    // rust: self.open_native_screen(key, target, p.container, &menu, extra);
            // A mod menu type shows through its mod's screen only: without one
            // (`MenuScreens.create` finds no screen) the window closes again.
    // rust: if self.mod_screen.is_none() && mod_type.is_some() {
    // rust: self.world.block_entities.remove(&key);
    // rust: self.container = None;
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.menu = None;
    // rust: r.menu_title = None;
}
    // rust: self.send(S::ContainerClose(play::ContainerClose {
    // rust: container: p.container,
    // rust: }));
    // rust: return;
}
}
    // rust: self.screen = Screen::Inventory;
    // rust: self.capture(false);
}
    // `ClientPacketListener.handleMountScreenOpen`: a horse's or llama's
    // inventory; for another entity the window is closed again.
remote_open_mount :: proc(self: ^Self, p: play::MountScreenOpen) {
}
    // rust: let columns = usize::try_from(p.columns).unwrap_or(0).min(5);
    // rust: if !self.open_remote_mount_menu(p.entity as u32, columns) {
    // rust: self.send(S::ContainerClose(play::ContainerClose {
    // rust: container: p.container,
    // rust: }));
    // rust: return;
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.menu = Some((p.container, format!("{MOUNT_MENU}{columns}")));
    // rust: r.menu_title = None;
}
}
    // The type of the menu a server opened (`MenuType`'s id).
    // rust: pub(super) fn remote_menu_type(&self) -> Option<&str> {
    // rust: Some(self.remote.as_ref()?.menu.as_ref()?.1.as_str())
}
    // The title the server gave the menu it opened.
    // rust: pub(super) fn remote_menu_title(&self) -> Option<horizon_client::text::Text> {
    // rust: self.remote.as_ref()?.menu_title.clone()
}
    // A language change reaches the server-sent components too: their titles
    // are resolved when the packet arrives, with the session's language.
    // rust: pub(super) fn refresh_remote_language(&mut self) {
    // rust: if let Some(lang) = horizon_client::lang::current()
    // rust: && let Some(r) = self.remote.as_mut()
    // rust: {
    // rust: r.lang = Arc::new(lang.map().clone());
}
}
    // A server's chest-like menu (`MenuType.GENERIC_9xN`): its rows and title.
    // rust: pub(super) fn remote_chest_menu(&self) -> Option<(usize, horizon_client::text::Text)> {
    // rust: let r = self.remote.as_ref()?;
    // rust: let rows = r
    // rust: .menu
    // rust: .as_ref()?
    // rust: .1
    // rust: .strip_prefix("minecraft:generic_9x")?
    // rust: .parse()
    // rust: .ok()?;
    // rust: Some((
    // rust: rows,
    // rust: r.menu_title
    // rust: .clone()
    // rust: .unwrap_or_else(horizon_client::text::Text::empty),
    // rust: ))
}
    // ServerboundPlayerCommandPacket STOP_SLEEPING.
    // rust: pub(super) fn remote_stop_sleeping(&mut self) {
    // rust: let id = self.remote.as_ref().map_or(0, |r| r.entity_id);
    // rust: self.send(S::PlayerCommand(play::PlayerCommand {
    // rust: id,
    // rust: action: 0,
    // rust: data: 0,
    // rust: }));
}
    // rust: pub(super) fn remote_respawn(&mut self) {
    // rust: self.send(S::ClientCommand(play::ClientCommand { action: 0 }));
}

    // Connecting / loading screens; true when it covered the frame.
    // rust: pub(super) fn remote_overlay(&mut self, batch: &mut HudBatch) -> bool {
    // rust: let Some(r) = &self.remote else { return false };
    // rust: let loading = r.level_load.is_active();
    // rust: if self.player.is_some() && !loading {
    // rust: return false;
}
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: if let Some(since) = r.reconfiguring {
            // ServerReconfigScreen narrates its title.
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new(
    // rust: "reconfiguring",
    // rust: super::screen_info::tr("connect.reconfiguring", &[]),
    // rust: )
    // rust: });
    // rust: self.draw_reconfiguring(batch, since);
    // rust: return true;
}
    // rust: if r.joined || loading {
            // LevelLoadingScreen: the world's terrain comes in. A server's
            // chunk status view and progress are the integrated server's alone
            // (`LevelLoadTracker.statusView`, `hasProgress`), and so is what
            // the narrator says of it.
    // rust: let progress = self
    // rust: .integrated
    // rust: .as_ref()
    // rust: .map(|i| i.load_view())
    // rust: .filter(|v| v.has_progress())
    // rust: .map(|v| v.server_progress());
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: super::screen_info::level_loading(progress, &super::screen_info::tr)
    // rust: });
    // rust: self.draw_level_loading_background(batch, r.level_load.reason);
    // rust: let atlas = &self.gui.atlas;
    // rust: match self.integrated.as_ref().map(|i| i.load_view()) {
    // rust: Some(view) => {
    // rust: let status = |x: i32, z: i32| view.status(x, z);
    // rust: let progress = view.has_progress().then_some(self.loading_progress);
    // rust: horizon_client::level_loading::draw(batch, atlas, Some(&status), progress);
}
    // rust: None => horizon_client::level_loading::draw(batch, atlas, None, None),
}
    // rust: return true;
}
    // rust: let cancel = self.connect_cancel((w, h)).is_some();
        // ConnectScreen.extractRenderState: "Joining the world" every 2 s (a
        // server's: single player's isn't joined through ConnectScreen).
    // rust: if self.integrated.is_none()
    // rust: && let Some(r) = self.remote.as_mut()
    // rust: && r.joining_narrated
    // rust: .is_none_or(|t| t.elapsed() > Duration::from_millis(2000))
    // rust: {
    // rust: r.joining_narrated = Some(Instant::now());
    // rust: self.say_system_now(&horizon_client::text::Text::translate(
    // rust: "narrator.joining",
    // rust: &[],
    // rust: ));
}
    // rust: let Some(r) = &self.remote else { return false };
        // ConnectScreen: `GameNarrator.NO_TITLE`, then its Cancel; single
        // player's server is joined under its LevelLoadingScreen.
    // rust: let single_player = self.integrated.is_some();
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: if single_player {
    // rust: super::screen_info::level_loading(None, &super::screen_info::tr)
    // rust: } else {
    // rust: horizon_client::widgets::ScreenInfo::new("connect", "")
}
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let status = horizon_client::text::Text::literal(r.status.as_str());
    // rust: horizon_client::level_loading::draw_connecting(batch, atlas, &status, self.cursor, cancel);
    // rust: true
}
    // Connected or connecting with no player yet: `ConnectScreen`, then
    // `LevelLoadingScreen`, over the panorama with its blur.
    // rust: pub(super) fn remote_loading(&self) -> bool {
//         use horizon_client::level_loading::Reason;
    // rust: self.remote.as_ref().is_some_and(|r| {
    // rust: if r.level_load.is_active() {
                // The portal screens have no panorama, so no blur.
    // rust: r.level_load.reason == Reason::Other
    // rust: } else {
    // rust: self.player.is_none()
}
    // rust: })
}
    // `ServerReconfigScreen`: a vertical layout of cells padded by 10, the
    // title (9 high) over Disconnect (150 x 20), centred. The title's and the
    // button's top left corners.
reconfigure_layout :: proc(self: ^Self) {
}
    // rust: let title = horizon_client::text::Text::translate("connect.reconfiguring", &[]);
    // rust: let title_w = self.gui.atlas.font.width_text(&title).ceil() as i32;
    // rust: let width = (title_w + 20).max(170);
    // rust: let left = ((w as i32 - width) as f32 * 0.5) as i32;
    // rust: let top = ((h as i32 - 69) as f32 * 0.5) as i32;
    // rust: let across = |child: i32| (10.0 + ((width - child - 10) as f32 - 10.0) * 0.5) as i32;
    // rust: (
    // rust: ((left + across(title_w)) as f32, (top + 10) as f32),
    // rust: ((left + across(150)) as f32, (top + 39) as f32),
    // rust: )
}
    // `ServerReconfigScreen` over the panorama; Disconnect wakes up after
    // `DISCONNECT_TIME` (600 ticks).
draw_reconfiguring :: proc(self: ^Self, batch: ^HudBatch, since: u64) {
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: horizon_client::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let title = horizon_client::text::Text::translate("connect.reconfiguring", &[]);
    // rust: let ((tx, ty), (bx, by)) = self.reconfigure_layout((w, h));
    // rust: batch.text_styled(atlas, &title, tx, ty, u32::MAX, true);
        // CommonComponents.GUI_DISCONNECT
    // rust: let label = horizon_client::text::Text::translate("menu.disconnect", &[]);
    // rust: let active = self.ticks.saturating_sub(since) >= 600;
    // rust: let hover = horizon_client::ui::hovered(self.cursor, bx, by, 150.0, 20.0);
    // rust: horizon_client::ui::button(batch, atlas, bx, by, 150.0, 20.0, &label, active, hover);
}
    // `ConnectScreen`'s Cancel: a server's (single player's server isn't
    // joined through `ConnectScreen`), until the login is done.
connect_cancel :: proc(self: ^Self) {
}
    // rust: let r = self.remote.as_ref()?;
    // rust: (self.player.is_none() && !r.joined && self.integrated.is_none())
    // rust: .then(|| horizon_client::level_loading::connect_cancel(w, h))
}
    // A click on `ConnectScreen`: Cancel aborts the connection
    // (`connect.aborted`) and goes back. Escape does nothing there
    // (`shouldCloseOnEsc` is false).
    // rust: pub(super) fn connect_screen_click(&mut self) -> Result<()> {
        // ServerReconfigScreen's Disconnect, once it is active.
    // rust: if let Some(since) = self.remote.as_ref().and_then(|r| r.reconfiguring) {
    // rust: let (_, (x, y)) = self.reconfigure_layout(self.gui_size());
    // rust: if self.ticks.saturating_sub(since) >= 600
    // rust: && horizon_client::ui::hovered(self.cursor, x, y, 150.0, 20.0)
    // rust: {
    // rust: self.audio.play_button_click();
    // rust: self.leave_server(None)?;
}
    // rust: return Ok(());
}
    // rust: let Some((x, y)) = self.connect_cancel(self.gui_size()) else {
    // rust: return Ok(());
}
    // rust: if horizon_client::ui::hovered(self.cursor, x, y, 200.0, 20.0) {
    // rust: self.audio.play_button_click();
    // rust: self.leave_server(None)?;
}
    // rust: Ok(())
}
    // The server's death message; chat uses the shared ChatComponent.
    // rust: pub(super) fn remote_hud(&self, batch: &mut HudBatch) {
    // rust: let Some(r) = &self.remote else { return };
    // rust: let atlas = &self.gui.atlas;
    // rust: let w = batch.width;
    // rust: if self.screen == Screen::Dead
    // rust: && let Some(message) = &r.death_message
    // rust: {
            // DeathScreen draws the styled cause component.
    // rust: let tw = atlas.font.width_text(message);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: message,
    // rust: ((w - tw) / 2.0).floor(),
    // rust: 85.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
}
    // Shared flag 6 of an entity on a server's client (`None` without a server).
    // rust: pub(super) fn remote_glowing(&self, id: u32) -> Option<bool> {
    // rust: let r = self.remote.as_ref()?;
    // rust: Some(r.glowing.contains(&(id as i32)))
}
    // The profile name of another player the server sent, by entity id.
    // The UUID of another player's entity in the level.
    // rust: pub(super) fn remote_player_uuid(&self, id: u32) -> Option<u128> {
    // rust: let r = self.remote.as_ref()?;
    // rust: let uuid = *r.level_players.get(&(id as i32))?;
    // rust: (uuid != r.profile).then_some(uuid)
}
    // rust: pub(super) fn remote_player_name(&self, id: u32) -> Option<&str> {
    // rust: let r = self.remote.as_ref()?;
    // rust: let uuid = r.level_players.get(&(id as i32))?;
    // rust: if *uuid == r.profile {
    // rust: return None;
}
    // rust: r.level_player_name(id as i32, uuid)
}
    // Status for `horizon-ctl status`.
    // The other players' entities in the level and their names (their
    // profiles', which outlive the player list's entries).
    // rust: pub(super) fn remote_player_names(&self) -> Vec<(u32, String)> {
    // rust: let Some(r) = self.remote.as_ref() else {
    // rust: return Vec::new();
}
    // rust: r.level_players
    // rust: .iter()
    // rust: .filter(|(_, uuid)| **uuid != r.profile)
    // rust: .filter_map(|(id, uuid)| Some((*id as u32, r.level_player_name(*id, uuid)?.to_owned())))
    // rust: .collect()
}
    // `ClientClockManager.tick`: the clock moves on by the game time that
    // passed since its last tick, at its rate. A game time the server sets
    // forward (its sync every second) moves the clock with it.
remote_clock_tick :: proc(self: ^Self) {
}
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let delta = self.world.game_time - r.clock_game_time;
    // rust: r.clock_game_time = self.world.game_time;
    // rust: let partial = f64::from(r.clock_partial) + delta as f64 * f64::from(r.clock_rate);
    // rust: let full = partial.floor();
    // rust: r.clock_partial = (partial - full) as f32;
    // rust: self.world.day_time += full as i64;
}
    // rust: pub(super) fn remote_status(&self) -> Option<serde_json::Value> {
    // rust: let r = self.remote.as_ref()?;
    // rust: Some(serde_json::json!({
    // rust: "address": horizon_client::net::shown_address(&r.session.address),
    // rust: "name": r.session.name,
    // rust: "joined": r.joined,
            // ServerboundPlayerLoadedPacket sent: the level around the
            // player is ready, and the client ticks and sends its moves.
    // rust: "loaded": r.loaded_sent,
    // rust: "status": r.status,
    // rust: "entity_id": r.entity_id,
    // rust: "dimension": r.dimension.name,
    // rust: "game_mode": r.game_mode,
    // rust: "chunks": self.world.chunks.len(),
    // rust: "entities": r.entities.values().fold(std::collections::BTreeMap::<&str, u32>::new(), |mut m, t| {
    // rust: *m.entry(t.kind.as_str()).or_default() += 1;
    // rust: m
    // rust: }),
    // rust: "players": r.players.values().collect::<Vec<_>>(),
            // Where the other players' entities are (harnesses check movement).
            // What the other players hold and wear, as this client draws them.
    // rust: "player_equipment": self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| r.level_players.contains_key(&(m.id as i32)))
    // rust: .map(|m| {
    // rust: let e = &m.extra;
    // rust: let armor = [&e.head, &e.chest, &e.legs, &e.feet].map(|s| s.as_deref());
    // rust: serde_json::json!({
    // rust: "id": m.id,
    // rust: "swinging": m.ai.swinging,
    // rust: "using": m.extra.using_item,
    // rust: "armor": armor,
    // rust: "main_hand": e.main_hand.as_deref(),
    // rust: "off_hand": e.off_hand.as_deref(),
    // rust: })
    // rust: })
    // rust: .collect::<Vec<_>>(),
    // rust: "player_positions": r
    // rust: .entities
    // rust: .values()
    // rust: .filter(|t| t.kind == "minecraft:player")
    // rust: .map(|t| t.position)
    // rust: .collect::<Vec<_>>(),
            // The other players this client draws dead (lying down, after EntityEvent DEATH).
    // rust: "dead_players": self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| r.level_players.contains_key(&(m.id as i32)) && !m.alive())
    // rust: .map(|m| m.id)
    // rust: .collect::<Vec<_>>(),
            // The other players this client draws lying in a bed (SLEEPING_POS).
    // rust: "lying_players": self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| r.level_players.contains_key(&(m.id as i32)) && m.extra.ints[1] != 0)
    // rust: .map(|m| m.id)
    // rust: .collect::<Vec<_>>(),
            // The player's own model exists (third person and the inventory draw it).
    // rust: "player_model": self.player_model.is_some(),
            // The world view draws its body now (third person, or lying in a bed;
            // not while invisible).
    // rust: "own_body": self.player_model_shown() && self.own_body_visible(),
    // rust: "text_display_vertices": self.text_display_vertices,
    // rust: "text_displays": self.text_displays.len(),
    // rust: "health": r.health.0,
    // rust: "food": r.health.1,
    // rust: "decode_errors": r.decode_errors,
    // rust: "chat": r.chat.iter().rev().take(10).rev().map(|(t, _)| t.clone()).collect::<Vec<_>>(),
    // rust: }))
}
}

// `Entity.lookAt`'s rotation from `from` towards `to`, as (yaw, pitch).
look_at_rotation :: proc(from: [f64; 3], to: [f64; 3]) -> ( {
    // Ported from Horizon
    return {}
}
//     use horizon_core::geometry::trig::atan2;
    // rust: let (dx, dy, dz) = (to[0] - from[0], to[1] - from[1], to[2] - from[2]);
    // rust: let horizontal = (dx * dx + dz * dz).sqrt();
    // `* 180.0F / (float)Math.PI` on the double.
    // rust: let degrees = |r: f64| r * 180.0 / f64::from(std::f32::consts::PI);
    // rust: let pitch = wrap_degrees((-degrees(atan2(dy, horizontal))) as f32);
    // rust: let yaw = wrap_degrees(degrees(atan2(dz, dx)) as f32 - 90.0);
    // rust: (yaw, pitch)
}

// `PositionMoveRotation.calculateAbsolute`'s pitch: the packet's pitch,
// added to `source` when it is relative, clamped to +-90.
position_packet_pitch :: proc(source: f32, change: f32, relative: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let offset = if relative { source } else { 0.0 };
    // rust: (offset + change).clamp(-90.0, 90.0)
}

// `Mth.wrapDegrees`.
wrap_degrees :: proc(a: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let a = a % 360.0;
    // rust: if a >= 180.0 {
    // rust: a - 360.0
    // rust: } else if a < -180.0 {
    // rust: a + 360.0
    // rust: } else {
    // rust: a
}
}

// `LivingEntity.tick`'s body target and `tickHeadTurn` for another player:
// the body turns toward where it walks (backwards when walking back), or to
// the look while the arm swings, and stays within 50 degrees of the look.
remote_player_head_turn :: proc(m: ^Mob) {
}
    // rust: let (dx, dz) = (m.position.x - m.previous.x, m.position.z - m.previous.z);
    // rust: let mut target = m.body_yaw;
    // rust: if (dx * dx + dz * dz) as f32 > 0.002_500_000_2 {
    // rust: let walk = (dz.atan2(dx) as f32).to_degrees() - 90.0;
    // rust: let facing = (wrap_degrees(m.yaw) - walk).abs();
    // rust: target = if 95.0 < facing && facing < 265.0 {
    // rust: walk - 180.0
    // rust: } else {
    // rust: walk
}
}
    // rust: if m.anim.attack_anim > 0.0 {
    // rust: target = m.yaw;
}
    // rust: m.body_yaw += wrap_degrees(target - m.body_yaw) * 0.3;
    // rust: let head = wrap_degrees(m.yaw - m.body_yaw);
    // rust: if head.abs() > 50.0 {
    // rust: m.body_yaw += head - head.signum() * 50.0;
}
}

// A click sent to a server: its slot, button and input, the slots it
// changed and the carried stack after it.
    // rust: type Predicted = (
    // rust: i16,
    // rust: i32,
    // rust: Input,
    // rust: Vec<(i16, Option<ItemStack>)>,
    // rust: Option<ItemStack>,
    // rust: );

// How many stacks the creative screen keeps in step with the server (`Remote::synced`).
CREATIVE_SYNCED :: 41

// The player's stacks in `Remote::synced` order: the 36 inventory slots, the off hand, then
// the armour from the head down. `CreativeInventoryListener.slotChanged` sends every
// InventoryMenu slot the creative screen changes, the armour slots too.
    // rust: fn creative_sync_stacks(
    // rust: inventory: &[Option<ItemStack>],
    // rust: offhand: &Option<ItemStack>,
    // rust: armor: &[Option<ItemStack>; 4],
    // rust: ) -> Vec<Option<ItemStack>> {
    // rust: let mut stacks: Vec<Option<ItemStack>> = inventory.iter().take(36).cloned().collect();
    // rust: stacks.resize(36, None);
    // rust: stacks.push(offhand.clone());
    // rust: stacks.extend(armor.iter().cloned());
    // rust: stacks
}

// Entries of `creative_sync_stacks` that went from `before` to `now` are synced as `now`.
    // rust: fn mark_synced(
    // rust: synced: &mut [Option<ItemStack>],
    // rust: before: &[Option<ItemStack>],
    // rust: now: Vec<Option<ItemStack>>,
    // rust: ) {
    // rust: for (i, stack) in now.into_iter().enumerate() {
    // rust: if before.get(i) != Some(&stack)
    // rust: && let Some(s) = synced.get_mut(i)
    // rust: {
    // rust: *s = stack;
}
}
}

// InventoryMenu's slot for entry `i` of `creative_sync_stacks`: the hotbar is 36..=44, the
// main inventory 9..=35, the off hand 45 and the armour 5..=8 (head first).
creative_sync_slot :: proc(i: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (match i {
    // rust: 0..9 => 36 + i,
    // rust: 36 => 45,
    // rust: 37.. => 5 + (i - 37),
    // rust: _ => i,
    // rust: }) as i16
}

// `MultiPlayerGameMode.handleContainerInput` for each click on the engine's
// copy of the menu: the click with the slots it changed and the carried
// stack after it, and whether a click dropped a stack. Every drop of
// `AbstractContainerMenu.doClick` (a THROW, a click outside the window, a
// swap or a result move with no room left) is `Prediction.PREDICTED`.
// None when the engine refuses a click.
    // rust: fn predict_clicks(
    // rust: m: &mut horizon_client::menu::Menu,
    // rust: env: &horizon_client::menu::Env,
    // rust: clicks: &[(i16, i32, Input)],
    // rust: ) -> Option<(Vec<Predicted>, bool)> {
    // rust: let mut predicted = Vec::with_capacity(clicks.len());
    // rust: let mut dropped = false;
    // rust: for &(slot, button, input) in clicks {
    // rust: let before = menu_items(m);
    // rust: let thrown = m.dropped.len();
    // rust: m.click(env, i32::from(slot), button, input).ok()?;
    // rust: dropped |= m.dropped.len() > thrown;
    // rust: let changed = changed_slots(&before, m);
    // rust: predicted.push((slot, button, input, changed, m.carried.clone()));
}
    // rust: Some((predicted, dropped))
}

menu_items :: proc(m: ^horizon_client::menu::Menu) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..m.slot_count()).map(|i| m.slot(i).cloned()).collect()
}

// The slots whose stack is no longer `before`'s (`ItemStack.matches`).
// `MultiPlayerGameMode.handleContainerInput`'s changed slots, in the order the packet writes them.
    // rust: fn changed_slots(
    // rust: before: &[Option<ItemStack>],
    // rust: m: &horizon_client::menu::Menu,
    // rust: ) -> Vec<(i16, Option<ItemStack>)> {
    // rust: let changed: Vec<i16> = (0..m.slot_count())
    // rust: .filter(|&i| m.slot(i) != before.get(i).and_then(Option::as_ref))
    // rust: .map(|i| i as i16)
    // rust: .collect();
    // rust: open_hash_order(&changed)
    // rust: .into_iter()
    // rust: .map(|i| (i, m.slot(i as usize).cloned()))
    // rust: .collect()
}

// The order a new fastutil `Int2ObjectOpenHashMap` iterates `keys` put in this order: vanilla
// collects a click's changed slots in one and writes them as it iterates. The key 0 comes first,
// then the table from its last position down; a key sits at `HashCommon.mix(key) & mask` or the
// next free position. The table starts at 32 (16 expected, load factor 0.75) and doubles when an
// insert finds it holding 24 (`size++ >= maxFill`), re-inserting from its last position down.
open_hash_order :: proc(keys: ^[i16]) -> V {
    // Ported from Horizon
    return {}
}
mix :: proc(key: i16) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let h = i32::from(key).wrapping_mul(0x9E37_79B9_u32 as i32);
    // rust: (h ^ ((h as u32) >> 16) as i32) as u32 as usize
}
put :: proc(table: ^[Maybe(i16)], key: i16) {
}
    // rust: let mask = table.len() - 1;
    // rust: let mut pos = mix(key) & mask;
    // rust: while table[pos].is_some() {
    // rust: pos = (pos + 1) & mask;
}
    // rust: table[pos] = Some(key);
}
    // HashCommon.maxFill(n, 0.75): min(ceil(n * 0.75), n - 1).
    // rust: let max_fill = |n: usize| (n * 3).div_ceil(4).min(n - 1);
    // rust: let mut table = vec![None; 32];
    // rust: let (mut zero, mut size) = (false, 0);
    // rust: for &key in keys {
    // rust: if key == 0 {
    // rust: zero = true;
    // rust: } else {
    // rust: put(&mut table, key);
}
    // rust: size += 1;
        // `size++ >= maxFill`: the size before this key.
    // rust: if size > max_fill(table.len()) {
            // HashCommon.arraySize(size + 1, 0.75): the power of two holding size + 1 at that load.
    // rust: let n = ((size + 1) * 4).div_ceil(3).next_power_of_two();
    // rust: let mut grown = vec![None; n];
    // rust: for &key in table.iter().rev().flatten() {
    // rust: put(&mut grown, key);
}
    // rust: table = grown;
}
}
    // rust: let rest = table.iter().rev().flatten().copied();
    // rust: zero.then_some(0).into_iter().chain(rest).collect()
}

// ServerboundContainerClickPacket's `ContainerInput` ordinal.
    // rust: pub(super) fn input_ordinal(input: Input) -> i32 {
    // rust: match input {
    // rust: Input::Pickup => 0,
    // rust: Input::QuickMove => 1,
    // rust: Input::Swap => 2,
    // rust: Input::Clone => 3,
    // rust: Input::Throw => 4,
    // rust: Input::QuickCraft => 5,
    // rust: Input::PickupAll => 6,
}
}

// The client's world for a guess at what a click does: reads go to the
// world, writes stay here and are dropped.
DryLevel :: struct {
    base: ^'w dyn horizon_world::level::LevelAccess,
    changed: HashMap<horizon_core::position::BlockPos,
    random: horizon_core::random::LegacyRandom,
    // The sounds the use plays (a door's creak).
    sounds: [dynamic]DrySound,
}

    // rust: type DrySound = (
    // rust: horizon_core::position::BlockPos,
    // rust: std::sync::Arc<str>,
    // rust: f32,
    // rust: f32,
    // rust: );
// The blocks a use on the dry level set.
    // rust: type DryChanges = Vec<(horizon_core::position::BlockPos, BlockStateId)>;
// What a use on the dry level changed, and the sounds it played.
    // rust: type DryUse = (DryChanges, Vec<DrySound>);
// Where `BlockItem.place` on the dry level placed, and the blocks it set.
    // rust: type DryPlace = (horizon_core::position::BlockPos, DryChanges);

// The blocks a guest's hand flips that its use predicts (and hears at once): a wooden or
// copper door, trapdoor or fence gate, a lever, a button or a cauldron, whose fill level
// changes as the bucket, bottle or dye lands. An iron door or trapdoor has no hand use.
    // rust: pub(super) fn hand_operated(name: &str) -> bool {
    // rust: let name = name.trim_start_matches("minecraft:");
    // rust: ((name.ends_with("_door") || name.ends_with("_trapdoor")) && !name.starts_with("iron_"))
    // rust: || name.ends_with("_fence_gate")
    // rust: || name.ends_with("_button")
    // rust: || name == "lever"
    // rust: || name.ends_with("cauldron")
}

    // rust: impl<'w> DryLevel<'w> {
new :: proc(base: ^'w dyn horizon_world::level::LevelAccess) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: base,
    // rust: changed: HashMap::new(),
    // rust: random: horizon_core::random::LegacyRandom::new(0),
    // rust: sounds: Vec::new(),
}
}
}

    // rust: impl horizon_world::level::LevelAccess for DryLevel<'_> {
emit :: proc(self: ^Self, event: horizon_world::level::LevelEvent) {
}
    // rust: if let horizon_world::level::LevelEvent::Sound {
    // rust: pos,
    // rust: sound,
    // rust: volume,
    // rust: pitch,
    // rust: } = event
    // rust: {
    // rust: self.sounds.push((pos, sound, volume, pitch));
}
}
block_state :: proc(self: ^Self, pos: horizon_core::position::BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.changed
    // rust: .get(&pos)
    // rust: .copied()
    // rust: .unwrap_or_else(|| self.base.block_state(pos))
}
    // rust: fn set_raw(
    // rust: &mut self,
    // rust: pos: horizon_core::position::BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> Option<BlockStateId> {
    // rust: let previous = self.block_state(pos);
    // rust: self.changed.insert(pos, state);
    // rust: Some(previous)
}
is_loaded :: proc(self: ^Self, pos: horizon_core::position::BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.base.is_loaded(pos)
}
    // A block this guess changed has no block entity left, so it reads as a
    // missing one; every other position asks the level it stands in for.
shulker_is_closed :: proc(self: ^Self, pos: horizon_core::position::BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.changed.contains_key(&pos) {
    // rust: return None;
}
    // rust: self.base.shulker_is_closed(pos)
}
min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.base.min_y()
}
max_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.base.max_y()
}
block_light :: proc(self: ^Self, pos: horizon_core::position::BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.base.block_light(pos)
}
sky_light :: proc(self: ^Self, pos: horizon_core::position::BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.base.sky_light(pos)
}
sky_darken :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.base.sky_darken()
}
is_unobstructed :: proc(self: ^Self, pos: horizon_core::position::BlockPos, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.base.is_unobstructed(pos, state)
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.random
}
    // A mod's bone meal answer is read, never grown here: the preview asks
    // the level it stands in for, as `isValidBonemealTarget` is read on both
    // sides.
    // rust: fn is_valid_bonemeal_target(
    // rust: &self,
    // rust: pos: horizon_core::position::BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> Option<bool> {
    // rust: self.base.is_valid_bonemeal_target(pos, state)
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.base.game_time()
}
}

// `InteractionHand` on the wire.
hand_id :: proc(hand: Hand) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match hand {
    // rust: Hand::Main => 0,
    // rust: Hand::Off => 1,
}
}

// Whether `Item.use` of `info` ends `Minecraft.startUseItem`'s click, so the
// off hand gets no turn. `FireworkRocketItem.use` answers SUCCESS while the
// player glides (the rocket boosts them) and PASS otherwise.
use_ends_click :: proc(info: ^horizon_client::items::ItemInfo, fall_flying: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: item_has_use(info) || (fall_flying && &*info.id == "minecraft:firework_rocket")
}

// Whether `Item.use` of this item answers SUCCESS on this client, which
// swings (`MultiPlayerGameMode.useItem`'s `result.shouldSwing()`), rather
// than CONSUME, which only ends the click: a bow, crossbow, trident or
// spear starting its charge, `ItemUtils.startUsingInstantly`'s food, drink,
// spyglass, shield and goat horn, and the ender eye's SUCCESS_SERVER (the
// server's swing source, not this client's).
remote_use_swings :: proc(held: ^ItemStack, consumable: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = &*held.item;
    // rust: !matches!(
    // rust: id,
    // rust: "minecraft:bow"
    // rust: | "minecraft:crossbow"
    // rust: | "minecraft:trident"
    // rust: | "minecraft:spyglass"
    // rust: | "minecraft:goat_horn"
    // rust: | "minecraft:ender_eye"
    // rust: | "minecraft:brush"
    // rust: ) && !consumable
    // rust: && horizon_client::spear::Kinetic::of(id).is_none()
}

// Whether an object interaction on the client predicts a hand swing (`InteractionResult.SUCCESS`).
// Boarding a minecart answers CONSUME and does not swing.
remote_object_swings :: proc(response: Maybe(bool), is_boarding: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: response.unwrap_or(!is_boarding)
}

// Whether right-clicking an item frame passes (`InteractionResult.PASS`).
// A fixed frame or an empty frame when clicking with an empty hand passes.
item_frame_interact_passes :: proc(fixed: bool, frame_has_item: bool, hand_has_item: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: fixed || (!frame_has_item && !hand_has_item)
}

// Whether right-clicking a boat passes (`InteractionResult.PASS`) on a client.
// `AbstractBoat.interact` passes when sneaking or out of control (60 ticks), and
// answers SUCCESS otherwise without checking for room (only the server's
// `startRiding` does). `AbstractChestBoat.interact` opens the chest instead of
// passing, unless it is out of control, not sneaked at and has room.
boat_interact_passes :: proc(chest: bool, sneaking: bool, out_of_control: bool, has_room: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if chest {
    // rust: !sneaking && out_of_control && has_room
    // rust: } else {
    // rust: sneaking || out_of_control
}
}

// Whether `Item.use` usually acts on this item (eats, drinks, equips, raises,
// throws, shoots, fills or places), which ends `Minecraft.startUseItem` at
// its hand. Tools and materials pass, and the off hand gets its turn. The
// server decides; this is the client's guess of whether to go on. A carrot or warped fungus
// on a stick is not here: `FoodOnAStickItem.use` passes on a client, and only the server's
// answer to a boost that can run swings the hand.
item_has_use :: proc(info: ^horizon_client::items::ItemInfo) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = info.id.trim_start_matches("minecraft:");
    // rust: id.ends_with("_spear")
    // rust: || info.consumable.is_some()
    // rust: || info.equip_slot.is_some()
    // rust: || info.blocks_attacks.is_some()
    // rust: || horizon_client::items::bucket_contents(&info.id).is_some()
    // rust: || id.ends_with("_boat")
    // rust: || id.ends_with("_raft")
    // rust: || id.ends_with("_bundle")
    // rust: || matches!(
    // rust: id,
    // rust: "bow"
    // rust: | "crossbow"
    // rust: | "trident"
    // rust: | "spyglass"
    // rust: | "fishing_rod"
    // rust: | "snowball"
    // rust: | "egg"
    // rust: | "blue_egg"
    // rust: | "brown_egg"
    // rust: | "ender_pearl"
    // rust: | "ender_eye"
    // rust: | "wind_charge"
    // rust: | "splash_potion"
    // rust: | "lingering_potion"
    // rust: | "experience_bottle"
    // rust: | "bucket"
    // rust: | "glass_bottle"
    // rust: | "map"
    // rust: | "writable_book"
    // rust: | "written_book"
    // rust: | "goat_horn"
    // rust: | "bundle"
    // rust: | "brush"
    // rust: )
}

// The view distance a client asks for: its render distance, which Horizon
// lets go past vanilla's 32 (a vanilla server still caps it at its own).
client_view_distance :: proc(render_distance: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: render_distance.clamp(2, i32::from(i8::MAX)) as i8
}

// `ClientPacketListener.handleBlockEntityData` loads the tag into the existing
// block entity, so the state the client builds itself stays: copied from `old`
// into `new`, the block entity decoded from the tag.
keep_client_state :: proc(old: Maybe(^BlockEntity), new: ^BlockEntity) {
}
    // rust: match (old, new) {
        // The turn of a vault's item and a trial spawner's mob (VaultClientData).
    // rust: (Some(BlockEntity::Vault(old)), BlockEntity::Vault(new)) => {
    // rust: new.spin = old.spin;
    // rust: new.o_spin = old.o_spin;
}
    // rust: (Some(BlockEntity::TrialSpawner(old)), BlockEntity::TrialSpawner(new)) => {
    // rust: new.spin = old.spin;
    // rust: new.o_spin = old.o_spin;
}
        // A beacon's beam (`BeaconBlockEntity.loadAdditional` reads only the
        // powers): a fresh one draws nothing until the next tick walks it again.
    // rust: (Some(BlockEntity::Beacon(old)), BlockEntity::Beacon(new)) => {
    // rust: new.sections.clone_from(&old.sections);
    // rust: new.checking.clone_from(&old.checking);
    // rust: new.last_check_y = old.last_check_y;
}
    // rust: _ => {}
}
}

// `LocalPlayer.onSyncedDataUpdated(DATA_LIVING_ENTITY_FLAGS)`: the server's
// flags (1 using, 2 the off hand) start a use the client is not running
// (`startUsingItem`, which needs an item in that hand), and stop one it is
// (`stopUsingItem`). `using` is the slot in use and its ticks.
    // rust: fn synced_local_use(
    // rust: using: Option<(usize, u32)>,
    // rust: flags: i8,
    // rust: selected: usize,
    // rust: has_item: impl Fn(usize) -> bool,
    // rust: ) -> Option<(usize, u32)> {
    // rust: let server_using = flags & 1 != 0;
    // rust: match using {
    // rust: None if server_using => {
    // rust: let slot = if flags & 2 != 0 {
    // rust: super::shield::OFFHAND_SLOT
    // rust: } else {
    // rust: selected
}
    // rust: has_item(slot).then_some((slot, 0))
}
    // rust: Some(_) if !server_using => None,
    // rust: using => using,
}
}

// The game as the tick's input sees it, and whether the tick acts.
RemoteInputWorld :: struct {

RemoteUseWorld :: struct {

    // rust: impl horizon_client::interaction_input::TargetUseWorld for RemoteUseWorld<'_, '_> {
use_entity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.remote_use_entity(Hand::Main)
}
use_block :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.remote_use_block(Hand::Main)
}
use_item :: proc(self: ^Self) {
}
    // rust: self.0.remote_use_hands();
}
}

    // rust: impl horizon_client::interaction_input::InteractionWorld for RemoteInputWorld<'_, '_> {
pick_hit_result :: proc(self: ^Self) {
}
    // rust: self.0.pick_tick_targets();
}
release_hit_result :: proc(self: ^Self) {
}
    // rust: self.0.release_tick_targets();
}
using_item :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.using.is_some()
}
release_using :: proc(self: ^Self) {
}
    // rust: if let Some((slot, ticks)) = self.0.using
    // rust: && self.0.mod_use_tick(slot, ticks, true)
    // rust: {
    // rust: return;
}
    // rust: self.0.release_remote_use();
}
start_attack :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.remote_start_attack()
}
start_use :: proc(self: ^Self) {
}
    // rust: self.0.remote_use();
}
pick :: proc(self: ^Self) {
}
        // Minecraft.pickBlockOrEntity: an entity before the block is asked
        // for (`handlePickItemFromEntity`), else the block.
    // rust: if let Some(entity) = self.0.pick_entity_hit() {
    // rust: if let Some(id) = entity {
    // rust: if self.0.native_interaction(2, Hand::Main).is_some() {
    // rust: return;
}
    // rust: self.0.send(S::PickItemFromEntity(play::PickItemFromEntity {
    // rust: id,
    // rust: include_data: self.0.has_control_down(),
    // rust: }));
}
    // rust: } else if let Some(hit) = self.0.pick() {
    // rust: if self.0.native_interaction(2, Hand::Main).is_some() {
    // rust: return;
}
    // rust: self.0.send(S::PickItemFromBlock(play::PickItemFromBlock {
    // rust: pos: hit.pos,
    // rust: include_data: self.0.has_control_down(),
    // rust: }));
}
}
use_delay :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.use_delay
}
continue_attack :: proc(self: ^Self, down: bool) {
}
    // rust: self.0.remote_continue_attack(down);
}
}

    // rust: impl Remote {
    // `Minecraft.level != null`: from `handleLogin` until the next
    // `handleConfigurationStart` (`clearClientLevel`). Minecraft.tick sends
    // CLIENT_TICK_END only then, so a client waiting for the server's Login
    // (a busy server takes seconds to place a new player) sends nothing.
    // rust: pub(super) fn has_level(&self) -> bool {
    // rust: client_has_level(self.logged_in, self.reconfiguring)
}
    // The epoch of this client level's entity handles (`native_epoch`).
    // rust: pub(super) fn native_epoch(&self) -> Option<horizon_client::mod_api::NativeWorldEpoch> {
    // rust: self.native_epoch
}
    // An entity the server added to this client level: its type
    // (`minecraft:text_display`) and its position as last sent.
    // rust: pub(super) fn tracked_entity(&self, id: i32) -> Option<(&str, [f64; 3])> {
    // rust: self.entities
    // rust: .get(&id)
    // rust: .map(|t| (t.kind.as_str(), t.position))
}
    // The profile of the player entity `id`: this window's own player, or
    // another one by the UUID it was added with and its profile name.
    // rust: pub(super) fn level_player(&self, id: i32) -> Option<(u128, Option<&str>)> {
    // rust: if id == self.entity_id {
    // rust: return Some((self.profile, Some(self.profile_name.as_str())));
}
    // rust: let uuid = *self.level_players.get(&id)?;
    // rust: Some((uuid, self.level_player_names.get(&id).map(String::as_str)))
}
    // `PlayerInfo.getMessageValidator().updateAndValidate(message)` for `message.sender`.
    // rust: fn validate_chat(
    // rust: &mut self,
    // rust: message: &secure_chat::Incoming,
    // rust: now: i64,
    // rust: ) -> Option<secure_chat::Validated> {
    // rust: let sender = message.sender;
    // rust: if let Some(validator) = self.chat_validators.get_mut(&sender) {
    // rust: return validator.update_and_validate(message, now);
}
    // rust: let (mut validator, settled) = self.new_chat_validator(sender);
    // rust: let validated = validator.update_and_validate(message, now);
        // While the services' keys are still on their way the validator is a stopgap, not kept.
    // rust: if settled {
    // rust: self.chat_validators.insert(sender, validator);
}
    // rust: validated
}
    // `ClientPacketListener.initializeChatSession` for `sender`'s entry: a session the services'
    // keys vouch for makes a keyed validator, anything else the fallback of
    // `enforcesSecureChat()` (`canValidateProfileKeys() && serverEnforcesSecureChat`). `false`
    // while the keys are not known yet.
new_chat_validator :: proc(self: ^Self, sender: u128) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let keys = self.services_keys.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let (can_validate, settled) = match &*keys {
    // rust: ServicesKeys::Ready(_) => (true, true),
    // rust: ServicesKeys::Missing => (false, true),
    // rust: ServicesKeys::Pending => (false, false),
}
    // rust: let fallback =
    // rust: secure_chat::MessageValidator::fallback(can_validate && self.enforces_secure_chat);
    // rust: let (ServicesKeys::Ready(keys), Some(Some((id, expires_at, key, signature)))) =
    // rust: (&*keys, self.chat_sessions.get(&sender))
    // rust: else {
    // rust: if matches!(&*keys, ServicesKeys::Missing)
    // rust: && self.chat_sessions.get(&sender).is_some_and(Option::is_some)
    // rust: {
    // rust: log::warn!(
    // rust: "Ignoring chat session from {sender:032x} due to missing Services public key"
    // rust: );
}
    // rust: return (fallback, settled);
}
    // rust: let profile_key = secure_chat::ProfileKey {
    // rust: expires_at: *expires_at,
    // rust: key: key.clone(),
    // rust: signature: signature.clone(),
}
    // rust: match secure_chat::ChatSession::validate(*id, profile_key, keys, sender) {
    // rust: Ok(session) => (secure_chat::MessageValidator::keyed(session), true),
    // rust: Err(why) => {
    // rust: log::error!("Failed to validate profile key for player {sender:032x}: {why}");
    // rust: (fallback, true)
}
}
}
    // How far the server sends chunks: its view distance and the ring
    // around (`ChunkTrackingView`), at least two.
    // rust: pub(super) fn sent_radius(&self) -> i32 {
    // rust: self.view_distance.max(2) + 1
}
    // A player entity's profile name: the one it was created with, else its
    // player-list entry's (an entity the list named after it spawned).
level_player_name :: proc(self: ^Self, id: i32, uuid: ^u128) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.level_player_names
    // rust: .get(&id)
    // rust: .or_else(|| self.players.get(uuid))
    // rust: .map(String::as_str)
}
    // Players in the server's player list, this one included.
    // rust: pub(super) fn player_count(&self) -> usize {
    // rust: self.players.len()
}
    // The local player's profile UUID.
    // rust: pub(super) fn profile(&self) -> u128 {
    // rust: self.profile
}
    // The entity id of a player in the level, by profile UUID.
    // rust: pub(super) fn player_entity(&self, uuid: u128) -> Option<u32> {
    // rust: self.level_players
    // rust: .iter()
    // rust: .find(|(_, u)| **u == uuid)
    // rust: .map(|(id, _)| *id as u32)
}
    // The kind and last sent position of a tracked server entity.
    // rust: pub(super) fn tracked(&self, id: i32) -> Option<(&str, [f64; 3])> {
    // rust: self.entities.get(&id).map(|t| (&*t.kind, t.position))
}
}

// The textures to resolve skins from: every list entry's, and for a player
// entity whose entry is gone the profile it kept. `kept` first takes, for each
// player entity without one, its entry's textures (`AbstractClientPlayer.getPlayerInfo`
// looks the PlayerInfo up once and holds it, removed from the list or not).
    // rust: fn skin_entries(
    // rust: level_players: &HashMap<i32, u128>,
    // rust: listed: &HashMap<u128, horizon_client::skins::Textures>,
    // rust: kept: &mut HashMap<i32, horizon_client::skins::Textures>,
    // rust: ) -> Vec<(u128, horizon_client::skins::Textures)> {
    // rust: for (id, uuid) in level_players {
    // rust: if !kept.contains_key(id)
    // rust: && let Some(textures) = listed.get(uuid)
    // rust: {
    // rust: kept.insert(*id, textures.clone());
}
}
    // rust: let mut entries: Vec<_> = listed.iter().map(|(u, t)| (*u, t.clone())).collect();
    // rust: for (id, textures) in kept.iter() {
    // rust: if let Some(uuid) = level_players.get(id)
    // rust: && !listed.contains_key(uuid)
    // rust: && !entries.iter().any(|(u, _)| u == uuid)
    // rust: {
    // rust: entries.push((*uuid, textures.clone()));
}
}
    // rust: entries
}

// `AttributeInstance.calculateValue` before the attribute's range: the base,
// `ADD_VALUE`s, then `ADD_MULTIPLIED_BASE`s of that, then each
// `ADD_MULTIPLIED_TOTAL`.
snapshot_value :: proc(s: ^play::AttributeSnapshot) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let amounts = |op: i32| {
    // rust: s.modifiers
    // rust: .iter()
    // rust: .filter(move |m| m.operation == op)
    // rust: .map(|m| m.amount)
}
    // rust: let base = s.base + amounts(0).sum::<f64>();
    // rust: let mut value = base + amounts(1).map(|a| base * a).sum::<f64>();
    // rust: for amount in amounts(2) {
    // rust: value *= 1.0 + amount;
}
    // rust: value
}

// `Util.getMillis` for the level load tracker's timeouts.
client_millis :: proc() -> u {
    // Ported from Horizon
    return {}
}
ORIGIN :: std::sync::OnceLock::new()
    // rust: ORIGIN
    // rust: .get_or_init(std::time::Instant::now)
    // rust: .elapsed()
    // rust: .as_millis() as u64
}

// `Entity.isOnFire` for the window's player: while the server's flag is set
// the predicted tick's countdown never takes `fire_ticks` below 1.
hold_server_fire :: proc(fire_ticks: i32, server_on_fire: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if server_on_fire {
    // rust: fire_ticks.max(1)
    // rust: } else {
    // rust: fire_ticks
}
}

// [`Remote::has_level`]: logged in (a Login arrived) and no reconfiguration
// since (`reconfiguring` is set by StartConfiguration, cleared by the next
// Login).
client_has_level :: proc(logged_in: bool, reconfiguring: Maybe(u64)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: logged_in && reconfiguring.is_none()
}

    // rust: mod tests {
//     use super::{
    // rust: boat_interact_passes, client_has_level, hold_server_fire, item_frame_interact_passes,
    // rust: keep_client_state, open_hash_order, remote_object_swings, remote_use_swings,
    // rust: synced_local_use,
}

    // The vanilla 26.3 client's ServerboundContainerClickPacket for a shift-click from hotbar slot 37
    // into slot 10 listed 37 first (wire stream harness, `inventory`). The key 0 always leads.
changed_slots_go_out_in_the_order_vanilla_s_hash_map_iterates :: proc() {
}
    // rust: assert_eq!(open_hash_order(&[10, 37]), [37, 10]);
    // rust: assert_eq!(open_hash_order(&[0, 1, 2, 36, 44])[0], 0);
        // Past 24 keys the table grows; every key is still listed once.
    // rust: let all: Vec<i16> = (0..46).collect();
    // rust: let mut out = open_hash_order(&all);
    // rust: out.sort_unstable();
    // rust: assert_eq!(out, all);
}
//     use horizon_client::{
    // rust: containers::{Beacon, BlockEntity},
    // rust: items::ItemStack,
}
//     use horizon_world::nbt::Tag;

    // `ItemFrame.interact`, `AbstractBoat.interact`, and `Minecart.interact`:
    // interactions that pass leave the click to the held item without swinging;
    // vehicle boarding answers CONSUME and ends the click without a predicted swing (#9120).
object_interactions_pass_and_swing_vanilla :: proc() {
}
        // ItemFrame: fixed frame or empty frame + empty hand passes.
    // rust: assert!(item_frame_interact_passes(true, true, true));
    // rust: assert!(item_frame_interact_passes(true, false, false));
    // rust: assert!(item_frame_interact_passes(false, false, false));
        // ItemFrame: inserting or rotating item does not pass.
    // rust: assert!(!item_frame_interact_passes(false, true, false)); // rotates
    // rust: assert!(!item_frame_interact_passes(false, false, true)); // inserts
    // rust: assert!(!item_frame_interact_passes(false, true, true)); // rotates

        // Boat: sneaking or out of control passes.
    // rust: assert!(boat_interact_passes(false, true, false, true)); // sneaking
    // rust: assert!(boat_interact_passes(false, false, true, true)); // out of control
        // Boat: the client answers SUCCESS, room or not (startRiding is the server's).
    // rust: assert!(!boat_interact_passes(false, false, false, true));
    // rust: assert!(!boat_interact_passes(false, false, false, false));

        // Chest boat: sneaking opens the chest; boarding answers SUCCESS.
    // rust: assert!(!boat_interact_passes(true, true, false, true)); // opens chest
    // rust: assert!(!boat_interact_passes(true, false, false, false)); // boards (client)
        // Chest boat out of control: passes with room, else opens the chest.
    // rust: assert!(boat_interact_passes(true, false, true, true));
    // rust: assert!(!boat_interact_passes(true, false, true, false));

        // Swings: boarding a rideable cart answers CONSUME (no swing).
    // rust: assert!(!remote_object_swings(None, true));
        // Swings: other object interactions, a boat's boarding too, answer SUCCESS.
    // rust: assert!(remote_object_swings(None, false));
        // Interaction entities honor response.
    // rust: assert!(remote_object_swings(Some(true), false));
    // rust: assert!(!remote_object_swings(Some(false), false));
}

    // A mod's chat goes out only from a joined player, and only what the
    // Chat option allows.
mod_chat_needs_a_joined_player_and_what_the_chat_option_allows :: proc() {
}
//         use super::super::{
    // rust: Audio, Game, Options, Progress, Settings, execution_role::ExecutionRole, load_resources,
}
//         use horizon_protocol::connection::Pipe;

    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .expect("set HORIZON_TEST_RESOURCES to prepared resources"),
    // rust: );
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
    // rust: &mut |_, _| unreachable!("no menu handoff"),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = ExecutionRole::Client;
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

    // rust: assert!(game.native_send_chat("/warp spawn").is_err());
    // rust: let (client, _server) = Pipe::pair();
    // rust: game.connect_local(client, "ChatTest").unwrap();
    // rust: assert!(game.native_send_chat("/warp spawn").is_err());
    // rust: game.remote.as_mut().unwrap().joined = true;
    // rust: assert!(game.native_send_chat("  ").is_err());
        // Full, then Commands Only, then Hidden.
    // rust: game.settings.chat_visibility = 0;
    // rust: assert!(game.native_send_chat("hello").is_ok());
    // rust: assert!(game.native_send_chat("/warp spawn").is_ok());
    // rust: game.settings.chat_visibility = 1;
    // rust: assert!(game.native_send_chat("hello").is_err());
    // rust: assert!(game.native_send_chat("/warp spawn").is_ok());
    // rust: game.settings.chat_visibility = 2;
    // rust: assert!(game.native_send_chat("/warp spawn").is_err());
}

    // `MultiPlayerGameMode.useItem`'s `shouldSwing`: the SUCCESS answers
    // swing, CONSUME's do not (#6425).
a_thrown_item_swinging_on_a_server_and_a_charge_not :: proc() {
}
    // rust: let stack = |id: &str| ItemStack::new(id, 1);
        // SUCCESS: the throwables, a bucket, a boat, a bundle, a book, a map.
    // rust: for id in [
    // rust: "minecraft:ender_pearl",
    // rust: "minecraft:splash_potion",
    // rust: "minecraft:wind_charge",
    // rust: "minecraft:snowball",
    // rust: "minecraft:experience_bottle",
    // rust: "minecraft:bucket",
    // rust: "minecraft:oak_boat",
    // rust: "minecraft:bundle",
    // rust: "minecraft:writable_book",
    // rust: "minecraft:map",
    // rust: ] {
    // rust: assert!(remote_use_swings(&stack(id), false), "{id} swings");
}
        // CONSUME: the charges and startUsingInstantly's uses, a drinkable
        // potion among them (`consumable` set).
    // rust: for id in [
    // rust: "minecraft:bow",
    // rust: "minecraft:crossbow",
    // rust: "minecraft:trident",
    // rust: "minecraft:spyglass",
    // rust: "minecraft:goat_horn",
    // rust: "minecraft:ender_eye",
    // rust: ] {
    // rust: assert!(!remote_use_swings(&stack(id), false), "{id} does not swing");
}
        // The kinetic weapons charge like a trident.
    // rust: assert!(!remote_use_swings(&stack("minecraft:iron_spear"), false));
        // A consumable (food, a drink) starts its use without a swing.
    // rust: assert!(!remote_use_swings(&stack("minecraft:apple"), true));
}

    // Minecraft.tick: CLIENT_TICK_END only while a level exists. None before
    // the first Login (configuration has finished, the server has not placed
    // the player yet), and none from StartConfiguration until the next Login.
tick_ends_need_the_level_the_login_makes :: proc() {
}
    // rust: assert!(!client_has_level(false, None), "joined, waiting for Login");
    // rust: assert!(client_has_level(true, None), "after Login");
    // rust: assert!(!client_has_level(true, Some(40)), "reconfiguring");
}

    // The server's on-fire flag keeps the predicted countdown (which
    // `fluid_base_tick` runs down) from ending the fire; a clear flag leaves
    // the window's own contact fire alone.
the_servers_fire_flag_holds_the_burning_state_through_the_countdown :: proc() {
}
    // rust: let mut ticks = 1;
    // rust: for _ in 0..5 {
    // rust: ticks = hold_server_fire(ticks - 1, true);
    // rust: assert!(ticks > 0, "still burning");
}
    // rust: assert_eq!(hold_server_fire(300, true), 300, "a longer fire is not cut");
    // rust: assert_eq!(hold_server_fire(7, false), 7, "predicted lava fire stays");
    // rust: assert_eq!(hold_server_fire(0, false), 0);
}

a_beacon_update_tag_keeps_the_beam_the_client_walked :: proc() {
}
    // rust: let old = BlockEntity::Beacon(Box::new(Beacon {
    // rust: levels: 1,
    // rust: primary: Some("minecraft:speed".into()),
    // rust: sections: vec![(0xF9FFFE, 2)],
    // rust: checking: vec![(0xF9FFFE, 1)],
    // rust: last_check_y: 70,
    // rust: ..Default::default()
    // rust: }));
        // BeaconBlockEntity.getUpdateTag: saveCustomOnly.
    // rust: let tag = Tag::compound([
    // rust: ("id", Tag::String("minecraft:beacon".into())),
    // rust: ("x", Tag::Int(0)),
    // rust: ("y", Tag::Int(64)),
    // rust: ("z", Tag::Int(0)),
    // rust: ("primary_effect", Tag::String("minecraft:haste".into())),
    // rust: (
    // rust: "secondary_effect",
    // rust: Tag::String("minecraft:regeneration".into()),
    // rust: ),
    // rust: ("Levels", Tag::Int(4)),
    // rust: ]);
    // rust: let (_, mut new) = horizon_client::save::decode_block_entity(&tag).unwrap();
    // rust: keep_client_state(Some(&old), &mut new);
    // rust: let BlockEntity::Beacon(b) = new else {
    // rust: panic!("not a beacon");
}
    // rust: assert_eq!(b.sections, vec![(0xF9FFFE, 2)]);
    // rust: assert_eq!(b.checking, vec![(0xF9FFFE, 1)]);
    // rust: assert_eq!(b.last_check_y, 70);
        // The powers and the levels are the tag's.
    // rust: assert_eq!(b.primary.as_deref(), Some("minecraft:haste"));
    // rust: assert_eq!(b.secondary.as_deref(), Some("minecraft:regeneration"));
    // rust: assert_eq!(b.levels, 4);
}

the_server_stopping_the_use_lowers_the_shield :: proc() {
}
        // Player.disableShield's stopUsingItem: flags 0 or 2 while the
        // off-hand shield is raised (LocalPlayer.onSyncedDataUpdated →
        // stopUsingItem). stopUsingItem clears bit 0 and leaves bit 1, so a
        // main-hand stop is 0 and an off-hand stop is 2.
    // rust: let off = super::super::shield::OFFHAND_SLOT;
    // rust: assert_eq!(synced_local_use(Some((off, 12)), 0, 3, |_| true), None);
    // rust: assert_eq!(synced_local_use(Some((3, 5)), 0, 3, |_| true), None);
    // rust: assert_eq!(synced_local_use(Some((off, 12)), 2, 3, |_| true), None);
}

the_server_starting_a_use_starts_it_in_that_hand :: proc() {
}
    // rust: let off = super::super::shield::OFFHAND_SLOT;
    // rust: assert_eq!(synced_local_use(None, 1, 4, |_| true), Some((4, 0)));
    // rust: assert_eq!(synced_local_use(None, 3, 4, |_| true), Some((off, 0)));
        // LivingEntity.startUsingItem needs an item in the hand.
    // rust: assert_eq!(synced_local_use(None, 1, 4, |_| false), None);
}

    // tooBigToInterpolate: a position sync measures from where the entity
    // is, a teleport from where its interpolation is headed.
a_far_move_snaps_by_the_packets_own_measure :: proc() {
}
//         use super::{MovePacket, Path, PosRot, SteppedInterpolation};
    // rust: let at = |x: f64| PosRot {
    // rust: position: [x, 0.0, 0.0],
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
}
    // rust: let mut handler = SteppedInterpolation::new(3);
        // At x 0, headed for x 50.
    // rust: handler.interpolate_to(at(0.0), Some(Path::Linear([50.0, 0.0, 0.0])), None);
    // rust: let to = [100.0, 0.0, 0.0];
    // rust: assert!(MovePacket::PositionSync.snaps(&handler, at(0.0), to));
    // rust: assert!(!MovePacket::Teleport.snaps(&handler, at(0.0), to));
    // rust: assert!(!MovePacket::Move.snaps(&handler, at(0.0), to));
        // With nothing in flight, both measure from the entity.
    // rust: let idle = SteppedInterpolation::new(3);
    // rust: assert!(MovePacket::Teleport.snaps(&idle, at(0.0), to));
    // rust: assert!(!MovePacket::Teleport.snaps(&idle, at(0.0), [60.0, 0.0, 0.0]));
}

    // A far sync puts the entity there and drops the steps it was walking;
    // a rotation alone keeps the position it is headed for and turns there
    // over the update interval.
a_living_entitys_move_snaps_or_steps :: proc() {
}
//         use super::{MovePacket, Path, PosRot, SteppedInterpolation, stepped_move};
    // rust: let at = |x: f64, yaw: f32| PosRot {
    // rust: position: [x, 0.0, 0.0],
    // rust: yaw,
    // rust: pitch: 0.0,
}
    // rust: let mut handler = SteppedInterpolation::new(3);
        // Walking to x 5 when the far sync comes.
    // rust: handler.interpolate_to(at(0.0, 0.0), Some(Path::Linear([5.0, 0.0, 0.0])), None);
    // rust: assert!(handler.active());
    // rust: let far = [100.0, 0.0, 0.0];
    // rust: let snap = stepped_move(
    // rust: &mut handler,
    // rust: MovePacket::PositionSync,
    // rust: at(0.0, 0.0),
    // rust: far,
    // rust: Some(Path::Linear(far)),
    // rust: Some((90.0, 0.0)),
    // rust: );
    // rust: assert_eq!(snap, Some(at(100.0, 90.0)));
    // rust: assert!(!handler.active());
    // rust: assert_eq!(handler.interpolate(), None, "no step back toward x 5");
        // A rotation-only move packet.
    // rust: let turn = stepped_move(
    // rust: &mut handler,
    // rust: MovePacket::Move,
    // rust: at(100.0, 90.0),
    // rust: far,
    // rust: None,
    // rust: Some((180.0, 0.0)),
    // rust: );
    // rust: assert_eq!(turn, None);
    // rust: let steps: Vec<_> = std::iter::from_fn(|| handler.interpolate()).collect();
    // rust: assert_eq!(
    // rust: steps.iter().map(|s| s.yaw).collect::<Vec<_>>(),
    // rust: [120.0, 150.0, 180.0]
    // rust: );
    // rust: assert!(steps.iter().all(|s| s.position == far));
}

matching_flags_leave_a_running_use_alone :: proc() {
}
    // rust: assert_eq!(synced_local_use(Some((2, 7)), 1, 2, |_| true), Some((2, 7)));
    // rust: assert_eq!(synced_local_use(None, 0, 2, |_| true), None);
}

    // `ChatType.Bound.decorate` and `decorateNarration`: a private message
    // shows as "Steve whispers to you: hi" and is narrated "Steve says hi";
    // a chat type the registry lacks is `minecraft:chat`'s.
chat_is_narrated_with_its_chat_types_narration_decoration :: proc() {
}
//         use super::{Decoration, chat_type_decorate, play};
//         use horizon_world::nbt::{JavaString, Tag, parse_snbt};
//         use serde_json::json;
    // rust: let bound = play::ChatTypeBound {
    // rust: chat_type: 0,
    // rust: name: Tag::String(JavaString::from("Steve")),
    // rust: target: None,
}
    // rust: let content = json!("hi");
    // rust: let (incoming, _) = parse_snbt(
    // rust: r#"{chat:{translation_key:"commands.message.display.incoming",parameters:["sender","content"],style:{color:"gray",italic:1b}},narration:{translation_key:"chat.type.text.narrate",parameters:["sender","content"]}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let chat = chat_type_decorate(Some(&incoming), Decoration::Chat, &bound, &content);
    // rust: assert_eq!(chat["translate"], "commands.message.display.incoming");
    // rust: assert_eq!(chat["color"], "gray");
    // rust: assert_eq!(chat["with"], json!(["Steve", "hi"]));
    // rust: assert_eq!(
    // rust: chat_type_decorate(Some(&incoming), Decoration::Narration, &bound, &content),
    // rust: json!({"translate": "chat.type.text.narrate", "with": ["Steve", "hi"]})
    // rust: );
    // rust: assert_eq!(
    // rust: chat_type_decorate(None, Decoration::Narration, &bound, &content),
    // rust: json!({"translate": "chat.type.text.narrate", "with": ["Steve", "hi"]})
    // rust: );
    // rust: assert_eq!(
    // rust: chat_type_decorate(None, Decoration::Chat, &bound, &content)["translate"],
    // rust: "chat.type.text"
    // rust: );
}

    // A cauldron's fill level is a use this client predicts, and a guest's
    // host forwards its sound: every cauldron state counts, not only the
    // doors and levers.
every_cauldron_counts_as_hand_operated :: proc() {
}
    // rust: for name in [
    // rust: "minecraft:cauldron",
    // rust: "minecraft:water_cauldron",
    // rust: "minecraft:lava_cauldron",
    // rust: "minecraft:powder_snow_cauldron",
    // rust: ] {
    // rust: assert!(super::hand_operated(name), "{name}");
}
    // rust: assert!(!super::hand_operated("minecraft:water"));
}

    // An NPC plugin lists the NPC, spawns it, and takes the entry off the list:
    // the entity keeps the skin it found; a player spawned before its entry
    // arrives takes the entry once it comes.
a_player_entity_keeps_the_skin_its_entry_gave :: proc() {
}
//         use horizon_client::skins::Textures;
//         use std::collections::HashMap;
    // rust: let npc = Textures {
    // rust: skin: Some("http://textures.minecraft.net/texture/npc".into()),
    // rust: signed: true,
    // rust: ..Textures::default()
}
    // rust: let (mut listed, mut kept) = (HashMap::from([(7u128, npc.clone())]), HashMap::new());
    // rust: let mut players = HashMap::from([(2i32, 7u128), (3, 8)]);
    // rust: assert_eq!(
    // rust: super::skin_entries(&players, &listed, &mut kept),
    // rust: [(7, npc.clone())]
    // rust: );
    // rust: listed.remove(&7);
    // rust: assert_eq!(
    // rust: super::skin_entries(&players, &listed, &mut kept),
    // rust: [(7, npc.clone())]
    // rust: );
        // Player 8's entry comes after its entity.
    // rust: let late = Textures {
    // rust: skin: Some("http://textures.minecraft.net/texture/late".into()),
    // rust: ..npc.clone()
}
    // rust: listed.insert(8, late.clone());
    // rust: let mut entries = super::skin_entries(&players, &listed, &mut kept);
    // rust: entries.sort_by_key(|(u, _)| *u);
    // rust: assert_eq!(entries, [(7, npc), (8, late)]);
        // A removed entity forgets its profile with it.
    // rust: players.remove(&2);
    // rust: kept.remove(&2);
    // rust: listed.clear();
    // rust: assert_eq!(super::skin_entries(&players, &listed, &mut kept).len(), 1);
}

    // An NPC plugin's scale: a base the plugin sets, or a modifier on 1.
attribute_values_add_then_multiply_as_vanilla :: proc() {
}
//         use horizon_protocol::packets::play::{AttributeModifier, AttributeSnapshot};
    // rust: let modifier = |amount, operation| AttributeModifier {
    // rust: id: "minecraft:proof".into(),
    // rust: amount,
    // rust: operation,
}
    // rust: let snapshot = |base, modifiers| AttributeSnapshot {
    // rust: attribute: 0,
    // rust: base,
    // rust: modifiers,
}
    // rust: assert_eq!(super::snapshot_value(&snapshot(2.0, vec![])), 2.0);
    // rust: assert_eq!(
    // rust: super::snapshot_value(&snapshot(1.0, vec![modifier(1.0, 0)])),
    // rust: 2.0
    // rust: );
        // (1 + 1) * (1 + 0.5) from the base, then * (1 + 1) of the total.
    // rust: let all = vec![modifier(1.0, 0), modifier(0.5, 1), modifier(1.0, 2)];
    // rust: assert_eq!(super::snapshot_value(&snapshot(1.0, all)), 6.0);
}

//     use super::Game;

    // `Entity.lookAt`: yaw 0 faces +Z, -90 faces +X; pitch -90 looks up.
look_at_turns_towards_the_target :: proc() {
}
    // rust: let close = |(yaw, pitch): (f32, f32), want: (f32, f32)| {
    // rust: assert!(
    // rust: (yaw - want.0).abs() < 1e-3 && (pitch - want.1).abs() < 1e-3,
    // rust: "{yaw} {pitch}, want {want:?}"
    // rust: );
}
    // rust: let at = [10.0, 64.0, -5.0];
    // rust: let off = |d: [f64; 3]| [at[0] + d[0], at[1] + d[1], at[2] + d[2]];
    // rust: close(
    // rust: super::look_at_rotation(at, off([0.0, 0.0, 3.0])),
    // rust: (0.0, 0.0),
    // rust: );
    // rust: close(
    // rust: super::look_at_rotation(at, off([3.0, 0.0, 0.0])),
    // rust: (-90.0, 0.0),
    // rust: );
    // rust: close(
    // rust: super::look_at_rotation(at, off([-3.0, 0.0, 0.0])),
    // rust: (90.0, 0.0),
    // rust: );
    // rust: close(
    // rust: super::look_at_rotation(at, off([0.0, 0.0, -3.0])),
    // rust: (-180.0, 0.0),
    // rust: );
    // rust: close(
    // rust: super::look_at_rotation(at, off([0.0, 2.0, 2.0])),
    // rust: (0.0, -45.0),
    // rust: );
    // rust: close(
    // rust: super::look_at_rotation(at, off([0.0, -4.0, 4.0])),
    // rust: (0.0, 45.0),
    // rust: );
}

    // `handleMovePlayer` moves the player's pitch and the model's old pitch
    // (`xRotO`) alike: a relative change keeps the ease a tick began, each
    // end clamped on its own, and an absolute one snaps both (#3844).
a_position_packet_moves_both_pitch_ends :: proc() {
}
//         use super::position_packet_pitch as pitch;
        // The tick is laying the head down from 30 to 0; the packet turns 10.
    // rust: assert_eq!(
    // rust: (pitch(30.0, 10.0, true), pitch(0.0, 10.0, true)),
    // rust: (40.0, 10.0)
    // rust: );
        // Each end clamps on its own.
    // rust: assert_eq!(
    // rust: (pitch(80.0, 20.0, true), pitch(60.0, 20.0, true)),
    // rust: (90.0, 80.0)
    // rust: );
        // An absolute pitch ignores both ends.
    // rust: assert_eq!(
    // rust: (pitch(30.0, -45.0, false), pitch(0.0, -45.0, false)),
    // rust: (-45.0, -45.0)
    // rust: );
    // rust: assert_eq!(pitch(0.0, 120.0, false), 90.0);
}

    // The hurt sound of `ClientboundDamageEventPacket` follows its damage
    // type (`Player.getHurtSound`: the type's effects), with the codec's
    // `hurt` default for an unknown type (#4149).
the_hurt_sound_follows_the_damage_events_type :: proc() {
}
//         use super::hurt_sound_for;
//         use horizon_protocol::registry::Dynamic;
//         use horizon_world::damage_source::Catalog;
    // rust: let types = [
    // rust: ("minecraft:in_fire", "burning"),
    // rust: ("minecraft:drown", "drowning"),
    // rust: ("minecraft:sweet_berry_bush", "poking"),
    // rust: ("minecraft:freeze", "freezing"),
    // rust: ("minecraft:arrow", "hurt"),
    // rust: ];
        // The types the server synchronized, in registry order.
    // rust: let mut registries = Dynamic::default();
    // rust: registries.add(horizon_protocol::packets::configuration::RegistryData {
    // rust: registry: "minecraft:damage_type".into(),
    // rust: entries: types
    // rust: .iter()
    // rust: .map(
    // rust: |(id, _)| horizon_protocol::packets::configuration::RegistryEntry {
    // rust: id: (*id).into(),
    // rust: data: None,
    // rust: },
    // rust: )
    // rust: .collect(),
    // rust: });
        // The damage catalog: one entry per type above, each with its effects.
    // rust: let bits = |f: f32| format!("{:08x}", f.to_bits());
    // rust: let catalog = Catalog::from_json(
    // rust: &serde_json::json!({
    // rust: "data_version": i64::from(horizon_world::DATA_VERSION),
    // rust: "types": types.iter().map(|(id, effects)| serde_json::json!({
    // rust: "id": id,
    // rust: "message_id": id.trim_start_matches("minecraft:"),
    // rust: "exhaustion": bits(0.1),
    // rust: "scaling": "when_caused_by_living_non_player",
    // rust: "effects": effects,
    // rust: "death_message_type": "default",
    // rust: })).collect::<Vec<_>>(),
    // rust: }),
    // rust: &serde_json::json!({}),
    // rust: )
    // rust: .unwrap();
    // rust: for (id, (name, effects)) in types.iter().enumerate() {
    // rust: assert_eq!(
    // rust: hurt_sound_for(&registries, &catalog, id as i32),
    // rust: horizon_client::health::hurt_sound(effects),
    // rust: "{name}"
    // rust: );
}
        // An unknown id falls back to the codec's default effects.
    // rust: assert_eq!(
    // rust: hurt_sound_for(&registries, &catalog, types.len() as i32),
    // rust: "minecraft:entity.player.hurt"
    // rust: );
        // A server-defined damage type with inline NBT effects needs no entry in
        // the client's built-in catalog.
    // rust: let mut custom = horizon_world::nbt::Compound::new();
    // rust: custom.insert(
    // rust: "effects".into(),
    // rust: horizon_world::nbt::Tag::String("burning".into()),
    // rust: );
    // rust: registries.add(horizon_protocol::packets::configuration::RegistryData {
    // rust: registry: "minecraft:damage_type".into(),
    // rust: entries: vec![horizon_protocol::packets::configuration::RegistryEntry {
    // rust: id: "custom:lava_splash".into(),
    // rust: data: Some(horizon_world::nbt::Tag::Compound(custom)),
    // rust: }],
    // rust: });
    // rust: assert_eq!(
    // rust: hurt_sound_for(&registries, &catalog, 0),
    // rust: "minecraft:entity.player.hurt_on_fire"
    // rust: );
}
synchronized_damage_defaults_override_a_different_local_definition :: proc() {
}
    // rust: let local = horizon_world::damage_source::Catalog::from_json(&serde_json::json!({
    // rust: "data_version": horizon_world::DATA_VERSION,
    // rust: "types": [{"id":"demo:heat", "message_id":"heat", "exhaustion":"00000000", "scaling":"never", "effects":"burning", "death_message_type":"default"}]
    // rust: }), &serde_json::json!({})).unwrap();
    // rust: let mut registries = horizon_protocol::registry::Dynamic::default();
    // rust: registries.add(horizon_protocol::packets::configuration::RegistryData {
    // rust: registry: "minecraft:damage_type".into(),
    // rust: entries: vec![horizon_protocol::packets::configuration::RegistryEntry {
    // rust: id: "demo:heat".into(),
    // rust: data: Some(horizon_world::nbt::Tag::Compound(Default::default())),
    // rust: }],
    // rust: });
    // rust: assert_eq!(
    // rust: super::hurt_sound_for(&registries, &local, 0),
    // rust: "minecraft:entity.player.hurt"
    // rust: );
}
    // `ClientPacketListener.handleSetEntityPassengersPacket`: the vehicle
    // ejects its passengers, then each listed entity `startRiding`s it, so
    // `isVehicle` holds while the list is not empty, whatever the passenger's
    // type: a server's item display riding a player hides that player's name
    // tag like a text display does (#5666).
any_tracked_passenger_makes_its_vehicle_a_vehicle :: proc() {
}
//         use std::collections::{HashMap, HashSet};
    // rust: let tracked = |kind: &str| super::Tracked {
    // rust: kind: kind.to_owned(),
    // rust: position: [0.0, 64.0, 0.0],
    // rust: silent: false,
    // rust: vehicle: None,
}
    // rust: let mut entities = HashMap::from([
    // rust: (42, tracked("minecraft:player")),
    // rust: (43, tracked("minecraft:player")),
    // rust: (9, tracked("minecraft:item_display")),
    // rust: (10, tracked("minecraft:block_display")),
    // rust: ]);
    // rust: let vehicles = |e: &HashMap<i32, super::Tracked>| -> HashSet<u32> {
    // rust: e.values().filter_map(|t| t.vehicle).collect()
}
    // rust: super::seat_passengers(&mut entities, 42, &[9, 10]);
    // rust: assert_eq!(vehicles(&entities), HashSet::from([42]));
        // The list replaces the old one: 10 got off, 9 still rides.
    // rust: super::seat_passengers(&mut entities, 42, &[9]);
    // rust: assert_eq!(entities[&10].vehicle, None);
    // rust: assert_eq!(entities[&9].vehicle, Some(42));
        // startRiding leaves the old vehicle first.
    // rust: super::seat_passengers(&mut entities, 43, &[9]);
    // rust: assert_eq!(vehicles(&entities), HashSet::from([43]));
        // An empty list: nobody rides 43 any more.
    // rust: super::seat_passengers(&mut entities, 43, &[]);
    // rust: assert!(vehicles(&entities).is_empty());
}
    // `ClientboundSoundEntityPacket`: the sound is heard where the entity it
    // names is — the local player included, which is no tracked entity — and
    // an id this level doesn't have plays nothing at all.
a_sound_entity_is_heard_where_its_entity_is :: proc() {
}
//         use std::collections::HashMap;
    // rust: let mut tracked = HashMap::new();
    // rust: tracked.insert(
    // rust: 7,
    // rust: super::Tracked {
    // rust: kind: "minecraft:cow".to_owned(),
    // rust: position: [8.5, 64.0, -3.5],
    // rust: silent: false,
    // rust: vehicle: None,
    // rust: },
    // rust: );
    // rust: let player = Some((2, [0.5, 70.0, 0.5], false));
    // rust: assert_eq!(
    // rust: super::entity_sound_state(2, player, None, &tracked, None)
    // rust: .filter(|s| !s.silent)
    // rust: .map(|s| s.position),
    // rust: Some([0.5, 70.0, 0.5]),
    // rust: "the local player is named by Remote.entity_id"
    // rust: );
    // rust: assert_eq!(
    // rust: super::entity_sound_state(7, player, None, &tracked, None)
    // rust: .filter(|s| !s.silent)
    // rust: .map(|s| s.position),
    // rust: Some([8.5, 64.0, -3.5]),
    // rust: "another entity the server spawned"
    // rust: );
    // rust: assert_eq!(
    // rust: super::entity_sound_state(9, player, None, &tracked, None)
    // rust: .filter(|s| !s.silent)
    // rust: .map(|s| s.position),
    // rust: None,
    // rust: "getEntity is null: handleSoundEntityEvent returns"
    // rust: );
    // rust: assert_eq!(
    // rust: super::entity_sound_state(2, None, None, &tracked, None)
    // rust: .filter(|s| !s.silent)
    // rust: .map(|s| s.position),
    // rust: None,
    // rust: "a player with no position yet"
    // rust: );
}
a_sound_entity_retains_silence_for_players_and_non_mob_targets :: proc() {
}
//         use std::collections::HashMap;
    // rust: let mut tracked = HashMap::new();
    // rust: tracked.insert(
    // rust: 7,
    // rust: super::Tracked {
    // rust: kind: "minecraft:arrow".to_owned(),
    // rust: position: [8.5, 64.0, -3.5],
    // rust: silent: true,
    // rust: vehicle: None,
    // rust: },
    // rust: );
    // rust: let state = super::entity_sound_state(7, None, None, &tracked, None).unwrap();
    // rust: assert!(state.silent);
    // rust: assert!(!state.removed);
    // rust: assert_eq!(state.position, [8.5, 64.0, -3.5]);
    // rust: let player =
    // rust: super::entity_sound_state(2, Some((2, [1.0, 2.0, 3.0], true)), None, &tracked, None)
    // rust: .unwrap();
    // rust: assert!(player.silent);
    // rust: assert!(super::entity_sound_state(9, None, None, &tracked, None).is_none());
}
a_dragon_sound_uses_live_movement_without_losing_mob_metadata :: proc() {
}
//         use horizon_client::sound_engine::SoundEntityState;
    // rust: let stale = SoundEntityState {
    // rust: position: [0.0, 64.0, 0.0],
    // rust: silent: true,
    // rust: removed: false,
}
    // rust: let tracked = std::collections::HashMap::new();
    // rust: for position in [[24.0, 80.0, -16.0], [25.5, 81.0, -18.0]] {
    // rust: let state =
    // rust: super::entity_sound_state(7, None, Some(stale), &tracked, Some((7, position)))
    // rust: .unwrap();
    // rust: assert_eq!(state.position, position);
    // rust: assert!(state.silent);
    // rust: assert!(!state.removed);
}
    // rust: let unrelated =
    // rust: super::entity_sound_state(7, None, Some(stale), &tracked, Some((8, [99.0; 3])))
    // rust: .unwrap();
    // rust: assert_eq!(unrelated.position, stale.position);
    // rust: assert!(super::entity_sound_state(7, None, None, &tracked, Some((7, [99.0; 3]))).is_none());
}

    // Q over a slot of the inventory on a server (#3357): the predicted THROW
    // drops the stack, so the player's hand swings, as `LivingEntity.drop`
    // does for `Prediction.PREDICTED`; a plain pick up drops nothing.
a_predicted_throw_from_a_slot_swings_the_hand :: proc() {
}
//         use horizon_client::{
    // rust: banner::Banners,
    // rust: brewing::Brewing,
    // rust: crafting::Recipes,
    // rust: creative::Names,
    // rust: enchant::Enchantments,
    // rust: items::{ItemStack, Items},
    // rust: menu::{Env, Input, Kind, Menu},
    // rust: stations::StationRecipes,
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return;
}
    // rust: let none = &horizon_world::loot::PackOverlay::NONE;
    // rust: let items = Items::catalog(&root, none).unwrap();
    // rust: let recipes = Recipes::load(&root, &items, none).unwrap();
    // rust: let brewing = Brewing::load(&root, &items, none);
    // rust: let banners = Banners::load(&root);
    // rust: let station_recipes = StationRecipes::load(&root, &items, none);
    // rust: let enchantments = Enchantments::default();
    // rust: let names = Names::default();
    // rust: let env = Env {
    // rust: items: &items,
    // rust: recipes: &recipes,
    // rust: brewing: &brewing,
    // rust: banners: &banners,
    // rust: station_recipes: &station_recipes,
    // rust: enchantments: &enchantments,
    // rust: names: &names,
    // rust: trade: None,
    // rust: maps: None,
    // rust: limited_crafting: false,
    // rust: known_recipes: None,
}
    // rust: let mut menu = Menu::new(Kind::Inventory);
    // rust: let cobblestone = ItemStack {
    // rust: item: "minecraft:cobblestone".into(),
    // rust: count: 16,
    // rust: damage: 0,
    // rust: extra: None,
}
        // The first hotbar slot of InventoryMenu.
    // rust: menu.set_slot(&env, 36, Some(cobblestone));
    // rust: let (sent, threw) =
    // rust: super::predict_clicks(&mut menu, &env, &[(36, 0, Input::Throw)]).unwrap();
    // rust: assert!(threw, "Q over a slot drops one and swings");
    // rust: assert_eq!(menu.slot(36).map(|s| s.count), Some(15));
    // rust: assert_eq!(sent.len(), 1);
    // rust: let (_, threw) = super::predict_clicks(&mut menu, &env, &[(36, 0, Input::Pickup)]).unwrap();
    // rust: assert!(!threw, "picking the stack up drops nothing");
    // rust: let (_, threw) =
    // rust: super::predict_clicks(&mut menu, &env, &[(-999, 1, Input::Pickup)]).unwrap();
    // rust: assert!(threw, "one of the carried stack outside the window");
}

placement_preview_checks_obstruction_without_changing_the_level :: proc() {
}
//         use super::DryLevel;
//         use horizon_core::{position::BlockPos, random::LegacyRandom};
//         use horizon_world::{
    // rust: level::{
    // rust: Behaviours, LevelAccess, PlaceContext, PlaceOutcome, Ticks, data::load_registry,
    // rust: },
    // rust: registry::BlockStateId,
}

Level :: struct {
    air: BlockStateId,
    stone: BlockStateId,
    obstructed: bool,
    loaded: bool,
    ceiling: i32,
}
    // rust: impl LevelAccess for Level {
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: if pos == BlockPos::new(0, 0, 0) {
    // rust: self.stone
    // rust: } else {
    // rust: self.air
}
}
set_raw :: proc(self: ^Self, _: BlockPos, _: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: panic!("preview must not write to the live level");
}
is_loaded :: proc(self: ^Self, _: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.loaded
}
max_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.ceiling
}
is_unobstructed :: proc(self: ^Self, pos: BlockPos, _: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: assert_eq!(pos, BlockPos::new(0, 1, 0));
    // rust: !self.obstructed
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: panic!("preview must not advance the live level's random source");
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
}

        // As with the LAN tests, prepared game resources are optional locally.
    // rust: let resources = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !resources.join("block-behaviours.json").exists() {
    // rust: return;
}
    // rust: let registry = load_registry(&resources).unwrap();
    // rust: let behaviours = Behaviours::load(&registry, &resources).unwrap();
    // rust: let mut base = Level {
    // rust: air: registry.default_state("minecraft:air").unwrap(),
    // rust: stone: registry.default_state("minecraft:stone").unwrap(),
    // rust: obstructed: false,
    // rust: loaded: true,
    // rust: ceiling: 320,
}
    // rust: for item in [
    // rust: "minecraft:stone",
    // rust: "minecraft:oak_slab",
    // rust: "minecraft:oak_door",
            // GrowingPlantHeadBlock.getStateForPlacement draws a random age.
    // rust: "minecraft:twisting_vines",
    // rust: ] {
    // rust: let ctx = PlaceContext {
    // rust: clicked_pos: BlockPos::new(0, 0, 0),
    // rust: face: horizon_core::geometry::Direction::Up,
    // rust: hit: horizon_core::geometry::Vec3::new(0.5, 1.0, 0.5),
    // rust: inside: false,
    // rust: yaw: 0.0,
    // rust: pitch: 45.0,
    // rust: sneaking: false,
    // rust: item: item.into(),
    // rust: can_use_game_master_blocks: false,
}
    // rust: for (obstructed, loaded, ceiling) in [
    // rust: (false, true, 320),
    // rust: (true, true, 320),
    // rust: (false, false, 320),
    // rust: (false, true, 1),
    // rust: ] {
    // rust: base.obstructed = obstructed;
    // rust: base.loaded = loaded;
    // rust: base.ceiling = ceiling;
    // rust: let valid = !obstructed && loaded && ceiling > 1;
    // rust: let mut preview = DryLevel::new(&base);
    // rust: let outcome = behaviours.place_block(&mut preview, &mut Ticks::default(), &ctx);
    // rust: assert_eq!(
    // rust: matches!(outcome, PlaceOutcome::Placed { .. }),
    // rust: valid,
    // rust: "{item}, obstructed={obstructed}, loaded={loaded}, ceiling={ceiling}"
    // rust: );
    // rust: assert_eq!(preview.changed.is_empty(), !valid);
    // rust: assert_eq!(base.block_state(BlockPos::new(0, 1, 0)), base.air);
}
}
}

the_creative_sync_covers_inventory_menu_slots_5_to_45_once_each :: proc() {
}
        // CreativeInventoryListener sends every InventoryMenu slot but the crafting ones: the
        // armour (5..=8), the inventory (9..=44) and the off hand (45).
    // rust: let stack = |item: &str| Some(horizon_client::items::ItemStack::new(item, 1));
    // rust: let inventory: Vec<_> = (0..36)
    // rust: .map(|i| stack(&format!("minecraft:item_{i}")))
    // rust: .collect();
    // rust: let offhand = stack("minecraft:shield");
    // rust: let armor = [
    // rust: stack("minecraft:diamond_helmet"),
    // rust: stack("minecraft:diamond_chestplate"),
    // rust: stack("minecraft:diamond_leggings"),
    // rust: stack("minecraft:diamond_boots"),
    // rust: ];
    // rust: let stacks = super::creative_sync_stacks(&inventory, &offhand, &armor);
    // rust: assert_eq!(stacks.len(), super::CREATIVE_SYNCED);
    // rust: let mut slots: Vec<i16> = (0..stacks.len()).map(super::creative_sync_slot).collect();
        // Each entry goes to the menu slot that holds that stack.
    // rust: for (i, &slot) in slots.iter().enumerate() {
    // rust: let game_slot = Game::menu_slot("inventory", i32::from(slot)).unwrap();
    // rust: let expected = match game_slot {
    // rust: 0..36 => &inventory[game_slot],
    // rust: 504 => &offhand,
    // rust: 500..504 => &armor[game_slot - 500],
    // rust: _ => panic!("entry {i} went to game slot {game_slot}"),
}
    // rust: assert_eq!(&stacks[i], expected, "entry {i}, menu slot {slot}");
}
    // rust: slots.sort();
    // rust: assert_eq!(slots, (5..=45).collect::<Vec<i16>>());
}

a_server_slot_update_leaves_an_unsent_creative_click_to_be_sent :: proc() {
}
    // rust: let stack = |item: &str| Some(horizon_client::items::ItemStack::new(item, 1));
    // rust: let none = || vec![None; super::CREATIVE_SYNCED];
        // Synced: nothing. A click puts a helmet on (entry 37, not sent yet), then the server
        // sets hotbar slot 0 (a pickup): only that entry counts as synced.
    // rust: let mut synced = none();
    // rust: let mut before = none();
    // rust: before[37] = stack("minecraft:diamond_helmet");
    // rust: let mut now = before.clone();
    // rust: now[0] = stack("minecraft:stick");
    // rust: super::mark_synced(&mut synced, &before, now.clone());
    // rust: assert_eq!(synced[0], now[0]);
    // rust: assert_eq!(
    // rust: synced[37], None,
    // rust: "the helmet still differs, so the next tick sends it"
    // rust: );
}

every_inventory_menu_slot_is_a_game_slot_and_45_is_the_off_hand :: proc() {
}
        // InventoryMenu: result, 2x2 grid, armour, 27 + 9 inventory slots, then the off hand.
    // rust: assert_eq!(Game::menu_slot("inventory", 45), Some(504));
    // rust: let mut seen = std::collections::HashSet::new();
    // rust: for slot in 0..46 {
    // rust: let internal = Game::menu_slot("inventory", slot);
    // rust: assert!(internal.is_some_and(|i| seen.insert(i)), "slot {slot}");
}
    // rust: assert_eq!(Game::menu_slot("inventory", 46), None);
}

remote_clicks_find_slots_past_the_old_large_chest_cutoff :: proc() {
}
    // rust: for (menu, internal, index) in [
    // rust: ("minecraft:generic_9x6", 18, 63),
    // rust: ("minecraft:generic_9x6", 19, 64),
    // rust: ("minecraft:generic_9x6", 0, 81),
    // rust: ("minecraft:generic_9x6", 8, 89),
    // rust: ("minecraft:generic_9x6", 353, 53),
    // rust: ("minecraft:generic_9x5", 8, 80),
    // rust: ("minecraft:generic_9x4", 8, 71),
    // rust: ("minecraft:generic_9x3", 8, 62),
    // rust: ("inventory", 504, 45),
    // rust: ] {
    // rust: assert_eq!(
    // rust: Game::menu_slot_index(menu, internal),
    // rust: Some(index),
    // rust: "{menu}, game slot {internal}"
    // rust: );
}
    // rust: assert_eq!(Game::menu_slot_index("minecraft:generic_9x6", 354), None);
    // rust: assert_eq!(Game::menu_slot_index("minecraft:generic_9x6", 504), None);
    // rust: assert_eq!(Game::menu_slot_index("unknown", 0), None);
}

    // `FireworkRocketItem.use` is SUCCESS while gliding: the main hand's
    // rocket ends the click and the off hand's shield is not raised (#3424).
    // On foot it passes, so the off hand still gets its turn.
a_rocket_used_while_gliding_ends_the_click :: proc() {
}
    // rust: let root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: eprintln!("skipping: no prepared resources in {}", root.display());
    // rust: return;
}
    // rust: let registry = horizon_world::level::data::load_registry(&root).unwrap();
    // rust: let facts = horizon_client::blocks::BlockFacts::load(&root, &registry).unwrap();
    // rust: let items = horizon_client::items::Items::load(
    // rust: &root,
    // rust: &registry,
    // rust: &facts,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: )
    // rust: .unwrap();
    // rust: let rocket = items.get("minecraft:firework_rocket").unwrap();
    // rust: assert!(super::use_ends_click(rocket, true), "gliding");
    // rust: assert!(!super::use_ends_click(rocket, false), "on foot");
        // Other items answer the same whether or not the player glides.
    // rust: let shield = items.get("minecraft:shield").unwrap();
    // rust: let stick = items.get("minecraft:stick").unwrap();
    // rust: for gliding in [false, true] {
    // rust: assert!(super::use_ends_click(shield, gliding));
    // rust: assert!(!super::use_ends_click(stick, gliding));
            // FoodOnAStickItem.use passes on a client: no swing while the boost cools down.
    // rust: for rod in [
    // rust: "minecraft:carrot_on_a_stick",
    // rust: "minecraft:warped_fungus_on_a_stick",
    // rust: ] {
    // rust: let rod = items.get(rod).unwrap();
    // rust: assert!(!super::use_ends_click(rod, gliding), "{}", rod.id);
}
}
}

    // `ClientPacketListener.handleGameEvent`: verify that the game event packet
    // types for arrow hit, pufferfish sting and limited crafting match vanilla.
game_event_constants_and_types_match_vanilla :: proc() {
}
//         use horizon_protocol::packets::play::GameEvent;
        // Event types from ClientboundGameEventPacket:
        // 6 = PLAY_ARROW_HIT_SOUND, 7 = RAIN_LEVEL_CHANGE, 8 = THUNDER_LEVEL_CHANGE,
        // 9 = PUFFER_FISH_STING, 11 = IMMEDIATE_RESPAWN, 12 = LIMITED_CRAFTING.
    // rust: let arrow = GameEvent {
    // rust: event: 6,
    // rust: param: 0.0,
}
    // rust: let rain = GameEvent {
    // rust: event: 7,
    // rust: param: 0.5,
}
    // rust: let thunder = GameEvent {
    // rust: event: 8,
    // rust: param: 0.2,
}
    // rust: let puffer = GameEvent {
    // rust: event: 9,
    // rust: param: 0.0,
}
    // rust: let respawn = GameEvent {
    // rust: event: 11,
    // rust: param: 1.0,
}
    // rust: let crafting = GameEvent {
    // rust: event: 12,
    // rust: param: 1.0,
}

    // rust: assert_eq!(arrow.event, 6);
    // rust: assert_eq!(rain.event, 7);
    // rust: assert_eq!(thunder.event, 8);
    // rust: assert_eq!(puffer.event, 9);
    // rust: assert_eq!(respawn.event, 11);
    // rust: assert_eq!(crafting.event, 12);
    // rust: assert!(crafting.param == 1.0);
}
}
