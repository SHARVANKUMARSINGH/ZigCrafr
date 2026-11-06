//! Transpiled from Horizon Rust crate
package horizon_client_mod_api

import "core:fmt"
import "core:mem"
import "core:math"

// Trait mods implement `Hooks` and link into the game executable.
// The executable passes the ordered `Mods` to `entry::main_with`.
// Trait mods are process-wide, like mixin module statics.
// Hooks use `&self + Send + Sync` for shared and reentrant calls; see `docs/native-mods.md`.
// Cargo generates the trait and dispatch from the catalog and source signatures into OUT_DIR.
// use std::sync::{
    // rust: Arc, OnceLock,
    // rust: atomic::{AtomicBool, Ordering},
}

    // rust: pub use crate::biome::{BiomeColors, SpawnEntry};
    // rust: pub use crate::block_sprites::{BlockSprites, FaceSprite, SpriteRef};
    // rust: pub use crate::camera::{CameraEntity, FovPlayer};
    // rust: pub use crate::command::Suggestion;
    // rust: pub use crate::containers::{ModBlockEntity, ModContainer, ModEnergyBuffer, ModFluidTanks};
    // rust: pub use crate::crafting::{CustomRecipe, Ingredient};
    // rust: pub use crate::extras::Corner;
    // rust: pub use crate::extras_hud::Corners;
    // rust: pub use crate::first_person::Hand;
    // rust: pub use crate::fog::{FogData, FogType};
    // rust: pub use crate::game::NativeFluidTank;
    // rust: pub use crate::game::native_block_entity_draw::{BlockEntityDraw, CubeFace};
    // rust: pub use crate::game::native_client_services::{
    // rust: NativeClientEntity, NativeClientHead, NativeClientProfile, NativeClientState,
}
    // rust: pub use crate::game::{
    // rust: ItemEnergyBuffer, NativeBlockEdit, NativeBlockReadError, NativeBlockRun, NativeClock,
    // rust: NativeColumnBlocks, NativeComponentError, NativeConfig, NativeConfigFile, NativeConfigKind,
    // rust: NativeCriterion, NativeDataMapType, NativeExperienceOrb, NativeFalling, NativeHeightmap,
    // rust: NativeHeldItem, NativeHit, NativeItemEntity, NativeMapDecoration, NativeMapInfo,
    // rust: NativeMobRender, NativeModEvent, NativePlayer, NativePlayerRender, NativeReloadListener,
    // rust: NativeShake, NativeStructureBlock, NativeStructureTemplate, NativeWorldDraw,
}
    // rust: pub use crate::gfx::native_render::{
    // rust: BlockSpriteArrays, RenderHooks, RenderNeeds, RenderNeedsEvent, WorldDrawn, WorldDrawnEvent,
    // rust: wgpu,
}
    // rust: pub use crate::hud::HudBatch;
    // rust: pub use crate::hud_layout::{GuiDraw, HealthHud, HealthInputs};
    // rust: pub use crate::items::ItemStack;
    // rust: pub use crate::merchant::MerchantOffer;
    // rust: pub use crate::mesher::TintSource;
    // rust: pub use crate::mobs::goals::{Cx, Goal, GoalSelector};
    // rust: pub use crate::mobs::model_layers::{
    // rust: CubeDefinition, CubeDeformation, CubeListBuilder, LayerDefinition, MeshDefinition, ModelPart,
    // rust: ModelPolygon, ModelVertex, PartId, PartPose,
}
    // rust: pub use crate::mobs::{Mob, MobWorld};
    // rust: pub use crate::music::{Music, MusicLayer};
    // rust: pub use crate::particles::{ParticleOptions, ParticleType};
    // rust: pub use crate::recipe_book::RecipeBookCategory;
    // rust: pub use crate::text::Text;
    // rust: pub use crate::world_primitives::{PrimitiveShape, WorldPrimitive, WorldPrimitives};
    // rust: pub use horizon_assets::item_model::{DisplayContext, StackView};
    // rust: pub use horizon_core::{
    // rust: geometry::Direction,
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
}
// The server's play packets `client_packet` hands over, decoded.
    // rust: pub use horizon_protocol::packets::play::Clientbound as ClientboundPlayPacket;
// The play packets a client sends, as `native_send_packet` takes them.
    // rust: pub use horizon_protocol::packets::play::Serverbound as ServerboundPlayPacket;
    // rust: pub use horizon_world::consumable::UseAnimation;
    // rust: pub use horizon_world::player_inventory::EquipmentSlot;
    // rust: pub use horizon_world::{
    // rust: attachments::{
    // rust: AttachmentCodec, AttachmentError, AttachmentHost, AttachmentType, Attachments, Holder,
    // rust: },
    // rust: fluid::FluidState,
    // rust: level::{BlockId, Dimension as LevelDimension, PlacementContext},
    // rust: loot::{LootStack, NativeLootContext},
    // rust: nbt::{Compound, Tag},
    // rust: registry::BlockStateId,
    // rust: worldgen::structure::{Mirror, Rotation},
}
    // rust: pub use serde_json;
// use serde_json::{Map, Value};
// use std::time::Duration;
// The window events `input_key` hands over (`winit::event::KeyEvent`) and their key types.
    // rust: pub use winit;

// Camera values from the most recently extracted world frame.
NativeCamera :: struct {
    position: [f64,
    eye_height: f32,
    partial_tick: f32,
    yaw: f32,
    pitch: f32,
    fov_degrees: f32,
    near: f32,
    far: f32,
    // Camera-relative view matrix in column-major order.
    view: [f32,
    // Reversed-Z projection matrix in column-major order.
    projection: [f32,
    dimension: string,
}

// A dispenser hook's answer: the slot's remainder (None empties it) and the
// level event to play, `CLICK` (1000), `FAIL` (1001) or 0 for none.
    // rust: pub type NativeDispensed = (Option<ItemStack>, i32);

// What a mod's fake player uses its item on (`Host::use_as_player`), as a
// player's click would.
NativeUseTarget :: enum {
    // `ServerPlayerGameMode.useItemOn`: the block at `pos`, clicked on its
    // `face` at `point` (world coordinates on that face).
    Block {,
    pos: [i32; 3],
    face: Direction,
    point: [f64; 3],
    // rust: },
    // `ServerPlayerGameMode.useItem`: the item alone, in the air.
    Item,
    // `Player.interactOn`: the entity with this id, clicked at `location`
    // (from the entity's position), as an interact packet names one.
    Entity { id: i32, location: [f64; 3] },
}

// What a mod's fake player did (`Host::use_as_player`).
NativeFakeUse :: struct {
    // Whether the use did something (`InteractionResult.consumesAction`).
    consumed: bool,
    // What its hand holds afterwards: what is left of the stack, or what the
    // item became (a filled bucket).
    held: Maybe(ItemStack),
    // What else ended up in its inventory (a bowl of stew from a stack of
    // bowls, a bottle), for the mod to keep or drop.
    other: [dynamic]ItemStack,
}

// Context for a player tuning a note block.
NativeNoteBlockChange :: struct {
    dimension: LevelDimension,
    pos: BlockPos,
    instrument: ^'a str,
    // The note before tuning, in the range 0 through 24.
    old_note: i32,
}

// What dropped the items heard by the `loot_drops` hook.
NativeLootDrops :: struct {
    // The block's or mob's own loot table (`minecraft:blocks/stone`, `minecraft:entities/zombie`);
    // empty when none rolled: the block or mob has none, the `mob_drops` rule is off, a baby
    // animal. A mob's drops may hold more: a charged creeper's head, a fox's mouth item.
    table: ^'a str,
    // The level they drop in (`minecraft:overworld`).
    dimension: ^'a str,
    // `LootContextParams.ORIGIN`: a broken block's centre, a mob's position.
    origin: [f64,
    // The block broken: its position and state.
    block: Option<([i32,
    // The mob that died, or the entity a player's use dropped them from (the
    // sheep sheared, the item frame broken): its entity ID and type
    // (`minecraft:zombie`).
    entity: Option<(u32,
    // The player who broke the block or killed the mob, when known. A mob
    // names one only while it remembers the player's hit (100 ticks), so one
    // that dies to lava long after names none.
    player: Maybe(u128),
    // What broke the block (`LootContextParams.TOOL`).
    tool: Maybe(^'a ItemStack),
    // The radius of the explosion that broke the block.
    explosion: Maybe(f32),
    // A player's use dropped them rather than a break or a death: shears on a
    // sheep, a mooshroom, a snow golem or a bogged, a brush on an armadillo or
    // a suspicious block, shears carving a pumpkin, picking sweet berries or
    // cave vines, a hit taking an item frame or its item, or untying a lead
    // or cutting it with shears. `player` names them; `block` or `entity` says
    // what dropped them. API 100. A mob that a player killed while
    // leashed drops its lead on its next tick as a call of its own (`entity`
    // the mob, `player` its killer, `table` empty, `used` false). API
    // 102. A dying player's inventory is a call of its own too, after
    // vanishing curse items are gone and before they are thrown (`entity`
    // the player's id and `minecraft:player`, `player` them, `table` empty,
    // `origin` where the items leave, `used` false); `drops` empty means
    // the mod took the whole inventory. Not heard with keepInventory. API
    // 405.
    used: bool,
}

// The open screen, for the screen hooks (`native_screen_render_post`, the
// mouse ones `native_screen_mouse_button_pressed_pre`, `..._released_pre` and
// `native_screen_mouse_scrolled_pre`, and the key ones
// `native_screen_key_pressed_pre` and `native_screen_char_typed_pre`): what
// it is, its menu and title, where its container panel is, how many slots its
// menu has, and where the mouse and the frame's partial tick are.
NativeScreenView :: struct {
    // One id per `Screen` (`Screen::id`): `inventory`, `creative`, `paused`,
    // `stats`, `options`, `win`… Stable across releases, so a mod can match
    // on it. Every container, station and mod window draws on the inventory
    // screen and so reports `inventory`: tell them apart by `menu` and
    // `title` (both None on a window the client opened itself) and by
    // `slots`. The title's own screens report theirs (API 326): `title`,
    // `world_select`, `world_create`, `world_create_flat`, `world_edit`,
    // `multiplayer`, `add_server`, `direct_connect`…, with no menu, no title
    // and no slots.
    id: ^'static str,
    // The type id of the menu the server opened for this screen
    // (`minecraft:generic_9x3`, `minecraft:furnace`, a mod's own id; a mount's
    // inventory is `horizon:mount<n>`). None on a screen without one (the
    // client's own inventory, creative, the pause menu, stats…) and for a
    // menu type the client does not know.
    menu: Maybe(^'a str),
    // The title the server gave the open menu, if it has one: the component
    // itself, not a copy (`.plain()` it to draw, `chars()` for the styles).
    // None when the server gave none, on a screen the client opened, and
    // while playing.
    title: Maybe(^'a Text),
    // The screen's container panel in GUI pixels, `[x, y, width, height]`;
    // the whole window for a screen with none. The panel is where the game
    // draws the window: 176 wide for most, wider for the merchant and the
    // beacon, a mod screen's own size for a mod's.
    rect: [f32,
    // The slots the open menu has, as `Game::slots` counts them: the player
    // inventory's 36, then the container's, the station's, the mod screen's
    // or the crafting grid's (a screen with no menu of its own still counts
    // the inventory menu's). Counted, not listed.
    slots: uint,
    // The pointer in GUI pixels (`Screen.mouseX`, `mouseY`, from the
    // window's top left), as `native_cursor` gives it: for hover highlights.
    mouse: [f32,
    // This frame's partial tick (`getGameTimeDeltaPartialTick(false)`, 0 to
    // 1): what the screen draws animation against.
    partial_tick: f32,
}

// A depth-tested outline of the client's block selection shape.
NativeBlockRim :: struct {
    pos: [i32,
    argb: u32,
    width: f32,
}

// A camera-local visual light, with no gameplay light or shadow writes.
NativeColoredLight :: struct {
    at: [f64,
    rgb: u32,
    radius: f32,
    intensity: f32,
}

// The minimap a native mod shows (`native_minimap`), drawn by Horizon's
// minimap: its corner, its side in GUI pixels, blocks per map pixel,
// turning with the player or north up, round or square.
NativeMinimap :: struct {
    corner: Corner,
    size: f32,
    blocks_per_pixel: f32,
    rotate: bool,
    round: bool,
}

// One block of a scene a mod draws in a screen (`Host::draw_scene`): its
// place in the scene, its state, and the block entity drawn with it, if any
// (a mod's, through `native_block_entity_submit` as in the world).
NativeSceneBlock :: struct {
    pos: [i32,
    state: BlockStateId,
    entity: Maybe(^'a ModBlockEntity),
}

// How a scene in a screen is seen (`Host::draw_scene`): the point at the
// middle of the screen's box, in blocks; the turn about the scene's vertical
// axis and the tilt of its top towards the viewer, in degrees; and how many
// GUI pixels a block is across.
NativeSceneView :: struct {
    center: [f32,
    yaw: f32,
    pitch: f32,
    scale: f32,
}

// A mod block's screen over its menu (`native_screen`): its size, where
// each of the container's slots is (`Slot.x`, `Slot.y`; none hides the
// slot, and so do slots past the list; the server's menu does not have a
// hidden slot either, so clicks and shift-clicks skip it), and the player inventory's first
// row (vanilla's is 84; the hotbar is 58 below it) and left column, from
// its top left.
NativeScreen :: struct {
    // Vanilla's container screens are 176 wide.
    width: f32,
    height: f32,
    slots: Vec<Option<[f32,
    inventory_y: f32,
    // The inventory's left column (vanilla's is 8).
    inventory_x: f32,
    // The mod draws the title and the "Inventory" label itself
    // (`native_screen_draw`); Horizon leaves them out.
    own_labels: bool,
    // The mod draws its own background (`native_screen_draw`), so Horizon
    // leaves out the plain panel and the slot frames.
    own_background: bool,
}

// A native mod as Options > Mods lists it (`native_mods`).
NativeMod :: struct {
    // Its id: its settings folder and its keys' lines.
    id: string,
    // `Name 1.0`.
    title: string,
    description: string,
    // Its keys: name, label and default key (`key.keyboard.z`). The page
    // lists them first; `native_mod_key` reads the player's choice.
    keys: Vec<[string,
}

// An item the panel shows (`native_panel_items`): its id
// (`minecraft:diamond`), a count (1 draws none) and its components beyond
// the item's own, in vanilla's item syntax, or "".
NativeStack :: struct {
    item: string,
    count: u32,
    components: string,
}

// What the player did on a native mod's panel (`native_panel_event`).
NativePanelEvent :: enum {
    // A click on an item of the panel, by its index in
    // `native_panel_items`' list.
    Clicked { index: u32, right: bool },
    // The search box's text, each time the player changes it.
    Search(String),
    // A key (`key.keyboard.r`; compare it with `native_mod_key`) went down
    // while the pointer was on an item: a slot of the screen's, or the
    // panel's.
    Key { key: String, stack: NativeStack },
    // A click on a slot of a recipe the panel shows: the recipe's index in
    // `native_panel_recipes`' list and the slot's in it (the results come
    // after the slots), and the stack it showed then.
    SlotClicked {,
    recipe: u32,
    slot: u32,
    stack: NativeStack,
    right: bool,
    // rust: },
    // The action button of the recipe at this index.
    Action(u32),
    // The player turned the recipes' page: the index of the first recipe
    // now shown.
    Page(u32),
    // The recipe page's back button.
    Back,
    // The player picked the tab at this index.
    Tab(u32),
}

// The zoom a native mod asks for (`native_zoom`): the factor (1 is none), eased through the
// field of view like the spyglass when `smooth`, and the scale of mouse turning.
NativeZoom :: struct {
    factor: f32,
    smooth: bool,
    turn: f32,
}

// A player on the server, as a server hook sees them.
NativeServerPlayer :: struct {
    uuid: u128,
    name: string,
    // The operator level, 0 to 4 (`ops.json`; single player's owner with
    // cheats on is 4).
    permission: u8,
    // `minecraft:overworld`, `minecraft:the_nether`, `minecraft:the_end`.
    dimension: string,
    position: [f64,
    // 0 survival, 1 creative, 2 adventure, 3 spectator.
    game_mode: i32,
    // Health points, 20 at full; 0 once dead. API 21.
    health: f32,
    // Where they look, in degrees (`yRot`, `xRot`), as their last move told
    // the server. API 49.
    yaw: f32,
    pitch: f32,
    // The network entity id the player has this session, the one hooks that only know entity ids
    // (`living_incoming_damage`, `living_knockback`) give for the player; 0 when not known.
    // API 398.
    entity_id: i32,
    // The IP address the player connects from (behind a Velocity proxy: the address the proxy forwards);
    // empty when not known. API 407.
    address: string,
}

// A command a native mod adds, as one usage: words, then arguments
// `<name:kind>`, optional ones last in brackets `[name:kind]`:
// `pay <player:player> <amount:integer>`, `balance [player:player]`,
// `eco give <player:player> <amount:integer>`. Kinds: `word`, `text` (the
// rest of the line, last), `integer`, `number`, `boolean`, `player`,
// `item`, `block_pos`. Usages of one command share their words; the
// server merges them into one tree.
NativeCommand :: struct {
    usage: string,
    // The operator level a player needs to see and run it (0: everyone).
    level: u8,
}

    // rust: impl NativeCommand {
    // A usage every player may run.
new :: proc(usage: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: usage: usage.to_owned(),
    // rust: level: 0,
}
}
    // The same, for operators of `level` and above.
op :: proc(usage: string, level: u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: usage: usage.to_owned(),
    // rust: level: level.min(4),
}
}
}

// Which `Game` observes the phase; a mirror `Game` never fires.
NativeAuthority :: enum {
    LocalAuthoritative,
    IntegratedServer,
    DedicatedServer,
    RemoteClient,
}

// One open attempt of one world; it rejects a previous open's commands.
NativeWorldEpoch :: struct {

    // rust: impl NativeWorldEpoch {
    // Create an epoch for the game.
new :: proc(n: u64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(n)
}
    // Read the epoch number.
get :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0
}
}

// An entity of the open world, for the `Host` methods that read or change one
// (`entity.position(host)`). It holds the world's epoch and the entity's id: ids
// are shared by every level and never reused while the world is open, and an
// entity that changes dimension gets a new one, as in vanilla. A handle from an
// earlier open, of an entity that is gone, or used on a client reads as `None`
// and changes nothing. `Host::entity` makes one from an event's entity id.
EntityRef :: struct {
    epoch: NativeWorldEpoch,
    id: u32,
}

    // rust: impl EntityRef {
    // Create a handle for the game.
new :: proc(epoch: NativeWorldEpoch, id: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { epoch, id }
}
    // The entity's id (the network id events carry).
id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}
    // The open of the world the handle belongs to.
epoch :: proc(self: ^Self) -> N {
    // Ported from Horizon
    return {}
}
    // rust: self.epoch
}
}

// A living entity of the open world: a mob, a player, an armor stand or the
// dragon (vanilla's `LivingEntity`). `host.living(entity)` makes one from an
// [`EntityRef`] of such an entity, and [`LivingRef::entity`] goes back, so the
// entity's methods work on it too. Stale handles read as `None`, as an
// `EntityRef`'s do.
LivingRef :: struct {

    // rust: impl LivingRef {
    // Create a handle for the game.
new :: proc(entity: EntityRef) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(entity)
}
    // The same entity as an [`EntityRef`].
entity :: proc(self: ^Self) -> E {
    // Ported from Horizon
    return {}
}
    // rust: self.0
}
    // The entity's id (the network id events carry).
id :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.id()
}
}

    // rust: impl From<LivingRef> for EntityRef {
from :: proc(living: LivingRef) -> S {
    // Ported from Horizon
    return {}
}
    // rust: living.0
}
}

// A level of the open world, by its dimension (`minecraft:the_nether`).
// `Host::level` makes one, and `entity.level(host)` gives an entity's.
LevelRef :: struct {
    epoch: NativeWorldEpoch,
    dimension: ^'static str,
}

    // rust: impl LevelRef {
    // Create a handle for the game.
new :: proc(epoch: NativeWorldEpoch, dimension: ^'static str) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { epoch, dimension }
}
    // The level's dimension (`minecraft:overworld`).
dimension :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.dimension
}
    // The open of the world the handle belongs to.
epoch :: proc(self: ^Self) -> N {
    // Ported from Horizon
    return {}
}
    // rust: self.epoch
}
}

// Non-paused authoritative server ticks since open (not game or frame time).
NativeTickId :: struct {

    // rust: impl NativeTickId {
    // Create a tick ID for the game.
new :: proc(n: u64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(n)
}
    // Read the tick number.
get :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0
}
}

// The world phases (`native_world_lifecycle`'s `phase`).
// The phase names are the hook log's stable vocabulary (the Debug text
// the mixins write); keep them despite the shared prefix.
WorldPhase :: enum {
    WorldOpenReady,
    // The open failed; `error_text` is the engine's own error text.
    WorldOpenFailed,
    WorldCloseFinal,
    // The server loop or final save failed; `error_text` carries the error.
    WorldCloseFailed,
}

// The tick phases carry whether the world runs, including frozen steps.
ServerTickPhase :: enum {
    ServerTickStart { world_running: bool },
    ServerTickEnd { world_running: bool },
}

// Context for every world lifecycle phase.
// `authority` is the server role. LocalAuthoritative and RemoteClient never
// fire today. `epoch` identifies the open attempt, including failed opens;
// the same epoch identifies its ready, final-close, or failed-close event.
// `tick` counts non-paused server ticks since the world opened.
NativeLifecycleContext :: struct {
    authority: NativeAuthority,
    epoch: NativeWorldEpoch,
    tick: NativeTickId,
}

// The ordered list of mods shared by the client and server.
    // rust: pub type Mods = Arc<[Box<dyn Hooks>]>;

    // rust: pub(crate) static MODS: OnceLock<Mods> = OnceLock::new();

// The process-wide list in dispatch order, or an empty list before installation.
mods :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: MODS.get().map_or(&[], |mods| mods.as_ref())
}

// The bundles' `[mod] id`s, one a [`mods`] entry in the same order.
MOD_IDS :: OnceLock::new()

// Names the entries of [`mods`] by their bundles' `[mod] id`s, so a panic in a hook names its mod.
// The launcher's generated executable calls it before `entry::main_with`.
name_mods :: proc(ids: ^'static [^'static str]) {
}
    // rust: if MOD_IDS.set(ids).is_err() {
    // rust: log::warn!("Trait mods already named; ignoring the second list");
    // rust: return;
}
    // rust: let _ = OFF.set(ids.iter().map(|_| AtomicBool::new(false)).collect());
}

// One flag per entry of [`mods`]: the player turned that mod off on the
// Mods page of the options. Its hooks are skipped from the next dispatch on (its `RenderHooks`,
// installed apart at start, keep drawing until a restart); it stays loaded,
// and what it keeps stays, so turning it on again resumes it at once
// (docs/design/mod-hotload.md). Registration hooks run at start, before the
// game reads the player's choice, so every mod's content stays registered.
OFF :: OnceLock::new()

// Turns the trait mod named `id` ([`name_mods`]) on or off for the
// following dispatches. False when no mod has that id: a mixin-only mod,
// whose code checks `native_on` itself.
set_mod_on :: proc(id: string, on: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (Some(ids), Some(flags)) = (MOD_IDS.get(), OFF.get()) else {
    // rust: return false;
}
    // rust: let mut found = false;
    // rust: for (flag, _) in flags.iter().zip(ids.iter()).filter(|(_, m)| **m == id) {
    // rust: flag.store(!on, Ordering::Relaxed);
    // rust: found = true;
}
    // rust: found
}

// The ids [`name_mods`] gave the entries of [`mods`].
mod_ids :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: MOD_IDS.get().copied().unwrap_or(&[])
}

// Whether entry `index` of [`mods`] is turned off.
is_off :: proc(index: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: OFF.get()
    // rust: .and_then(|flags| flags.get(index))
    // rust: .is_some_and(|flag| flag.load(Ordering::Relaxed))
}

// `mods` in order, each marked as running `hook` until the next one is (or the loop ends), so a
// panic in it names the mod. The generated dispatch loops over it.
// A part of [`mods`] (one mod, dispatched on its own) keeps its entries' places in it.
    // rust: fn entered<'a>(mods: &'a [Box<dyn Hooks>], hook: &'static str) -> Entered<'a> {
    // rust: Entered {
    // rust: first: place_in(self::mods(), mods),
    // rust: mods: mods.iter().enumerate(),
    // rust: hook,
    // rust: guard: None,
}
}

// Where `part` starts in `all`, None when it is not a part of it (a test's
// own list).
    // rust: fn place_in<T>(all: &[T], part: &[T]) -> Option<usize> {
    // rust: let range = all.as_ptr_range();
    // rust: range
    // rust: .contains(&part.as_ptr())
    // rust: .then(|| (part.as_ptr().addr() - range.start.addr()) / size_of::<T>().max(1))
}

Entered :: struct {
    // Where `mods` starts in [`mods`]; None for a list of its own.
    first: Maybe(uint),
    mods: std::iter::Enumerate<std::slice::Iter<'a,
    hook: ^'static str,
    guard: Maybe(crate::crash::NativeModGuard),
}

    // rust: impl<'a> Iterator for Entered<'a> {
    // rust: type Item = &'a Box<dyn Hooks>;

next :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
        // The last mod's mark goes first, so the next one's puts back what was there before.
    // rust: drop(self.guard.take());
    // rust: let (index, hooks) = loop {
    // rust: let (index, hooks) = self.mods.next()?;
    // rust: match self.first {
    // rust: Some(first) if is_off(first + index) => continue,
    // rust: Some(first) => break (first + index, hooks),
    // rust: None => break (index, hooks),
}
}
    // rust: self.guard = Some(crate::crash::enter_native_mod(
    // rust: crate::crash::NativeModCall {
    // rust: id: MOD_IDS.get().and_then(|ids| ids.get(index)).copied(),
    // rust: index,
    // rust: hook: self.hook,
    // rust: },
    // rust: ));
    // rust: Some(hooks)
}
}

// Whether a mod claims a cancellable hook.
Flow :: enum {
    // Later mods and the game continue.
    Continue,
    // Set the hook flag and skip later mods.
    Cancel,
}

    // rust: mod generated_host {
    // rust: include!(concat!(env!("OUT_DIR"), "/mod_api_generated_host.rs"));
}
    // rust: pub use generated_host::Host;

// Result of accessing or decoding an attachment.
    // rust: pub type AttachmentResult<T> = std::result::Result<T, AttachmentError>;

    // rust: impl AttachmentHost for dyn Host + '_ {
attachments :: proc(self: ^Self, holder: Holder) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Host::attachments(self, holder)
}
}

// Read-only level services, like vanilla's `LevelReader`.
    // rust: pub trait LevelHost {
    // Read a block through `LevelAccess::block_state`.
block_state :: proc(self: ^Self, pos: [i32; 3]) -> B {
    // Ported from Horizon
    return {}
}
    // `Level.isClientSide`, through `LevelAccess::is_client_side`.
is_client_side :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // `BlockState.setValue`, through `native_state_with_property`; None if invalid.
    // rust: fn state_with_property(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: key: &str,
    // rust: value: &str,
    // rust: ) -> Option<BlockStateId>;
}

// Access vanilla's `Level.random`, so draws come in vanilla's order.
    // rust: pub trait LevelRandomHost: LevelHost {
    // Access a holder's server-owned attachment map.
attachments :: proc(self: ^Self, holder: Holder) -> R {
    // Ported from Horizon
    return {}
}
    // The level's random stream through `native_level_random`, or None on a non-authoritative level.
random :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
}

// A `LevelReader` with vanilla's `ScheduledTickAccess`. Shape updates cannot write blocks.
    // rust: pub trait LevelTicksHost: LevelHost {
    // Schedule a block tick through `native_schedule_block_tick`.
schedule_block_tick :: proc(self: ^Self, pos: [i32; 3], block: string, delay: i32) -> b {
    // Ported from Horizon
    return {}
}
    // Schedule a fluid tick through `native_schedule_fluid_tick`.
schedule_fluid_tick :: proc(self: ^Self, pos: [i32; 3], fluid: string, delay: i32) -> b {
    // Ported from Horizon
    return {}
}
}

// Mutable level services, like vanilla's `ServerLevel`. Whole-block writes wait for block entity support.
    // rust: pub trait LevelWriteHost: LevelTicksHost + LevelRandomHost {
    // Change a block property through `native_set_block_property`.
set_block_property :: proc(self: ^Self, pos: [i32; 3], key: string, value: string, flags: i32) -> b {
    // Ported from Horizon
    return {}
}
    // Play a sound for nearby players through `native_play_sound`.
    // rust: fn play_sound(
    // rust: &mut self,
    // rust: sound: &str,
    // rust: at: [f64; 3],
    // rust: source: usize,
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: ) -> bool;
    // `ServerLevel.sendParticles` through `native_send_particles`.
    // rust: fn send_particles(
    // rust: &mut self,
    // rust: options: &ParticleOptions,
    // rust: state: Option<BlockStateId>,
    // rust: at: [f64; 3],
    // rust: spread: [f64; 3],
    // rust: speed: f64,
    // rust: count: i32,
    // rust: ) -> bool;
}

    // rust: macro_rules! level_attachment_host {
    // rust: ($($host:ident),+) => { $(
    // rust: impl AttachmentHost for dyn $host + '_ {
attachments :: proc(self: ^Self, holder: Holder) -> R {
    // Ported from Horizon
    return {}
}
    // rust: LevelRandomHost::attachments(self, holder)
}
}
    // rust: )+ };
}
    // rust: level_attachment_host!(LevelRandomHost, LevelWriteHost);

    // rust: mod generated {
    // rust: include!(concat!(env!("OUT_DIR"), "/mod_api_generated.rs"));
}
    // rust: pub use generated::Hooks;
    // rust: pub use generated::*;

    // rust: mod tests {
//     use super::*;
//     use std::sync::Mutex;

Quiet :: struct {
    // rust: impl Hooks for Quiet {}

    // A mod turned off is skipped in the game's list from the next dispatch, and resumes when
    // turned on; a test's own list is never switched.
a_mod_turned_off_is_skipped_until_turned_on :: proc() {
}
    // rust: name_mods(&["quiet", "broken"]);
    // rust: let _ = MODS.set(Arc::from(vec![
    Box: :new(Quiet) as ^dyn Hooks,
    Box: :new(Quiet),
    // rust: ]));
    // rust: let ids = mod_ids().to_vec();
    // rust: let called = || entered(mods(), "test").count();
    // rust: assert_eq!(called(), 2);
    // rust: assert!(set_mod_on(ids[1], false));
    // rust: assert_eq!(called(), 1);
        // Dispatched alone, it is still off.
    // rust: assert_eq!(entered(&mods()[1..], "test").count(), 0);
    // rust: let own: Vec<Box<dyn Hooks>> = vec![Box::new(Quiet), Box::new(Quiet)];
    // rust: assert_eq!(entered(&own, "test").count(), 2);
    // rust: assert!(set_mod_on(ids[1], true));
    // rust: assert_eq!(called(), 2);
    // rust: assert!(!set_mod_on("not_a_mod", false));
}

one_mod_dispatched_alone_keeps_its_place :: proc() {
}
    // rust: let all = [10, 11, 12, 13];
    // rust: assert_eq!(place_in(&all, &all[2..=2]), Some(2));
    // rust: assert_eq!(place_in(&all, &all), Some(0));
    // rust: assert_eq!(place_in(&all, &[12]), None);
}

Broken :: struct {
    // rust: impl Hooks for Broken {
component_types :: proc(self: ^Self, _event: ^ComponentTypesEvent<'_>) {
}
    // rust: panic!("a broken mod");
}
}

    // A double with the three `Host` methods the probe calls.
Reader :: struct {
    block: ^'static str,
    lines: [dynamic]Text,
}

    // rust: impl Host for Reader {
block :: proc(self: ^Self, _pos: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.block.to_string()
}
acting_player :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(NativeServerPlayer {
    // rust: uuid: 7,
    // rust: name: "Probe".to_string(),
    // rust: permission: 0,
    // rust: dimension: "minecraft:overworld".to_string(),
    // rust: position: [0.0; 3],
    // rust: game_mode: 0,
    // rust: health: 20.0,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: entity_id: 0,
    // rust: address: String::new(),
    // rust: })
}
action_bar :: proc(self: ^Self, _uuid: u128, line: Text) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.lines.push(line);
    // rust: true
}
}

    // Claims a use on stone, after telling the player what the block is.
Probe :: struct {

    // rust: impl Hooks for Probe {
use_item_on :: proc(self: ^Self, host: ^dyn Host, event: ^UseItemOnEvent<'_>) -> F {
    // Ported from Horizon
    return {}
}
    // rust: let block = host.block(event.pos);
    // rust: let player = host.acting_player().expect("a player acts");
    // rust: host.action_bar(player.uuid, Text::literal(block.clone()));
    // rust: if block == "minecraft:stone" {
    Flow: :Cancel,
    // rust: } else {
    Flow: :Continue,
}
}
}

    // Asks the host to tell a player without anyone having implemented it.
Chatty :: struct {

    // rust: impl Hooks for Chatty {
use_item_on :: proc(self: ^Self, host: ^dyn Host, _event: ^UseItemOnEvent<'_>) -> F {
    // Ported from Horizon
    return {}
}
    // rust: host.tell(7, Text::literal("hello"));
    Flow: :Continue,
}
}

stick :: proc() -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemStack {
    // rust: item: Arc::from("minecraft:stick"),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
}

a_panic_in_a_hook_names_the_mod_and_the_hook :: proc() {
}
    // rust: name_mods(&["quiet", "broken"]);
    // rust: let mods: Vec<Box<dyn Hooks>> = vec![Box::new(Quiet), Box::new(Broken)];
    // rust: let caught = Arc::new(Mutex::new(Vec::new()));
    // rust: let sink = caught.clone();
    // rust: let previous = std::panic::take_hook();
    // rust: std::panic::set_hook(Box::new(move |info| {
    // rust: let error = crate::crash::panic_report(info, "client").error;
    // rust: if error.contains("a broken mod") {
    // rust: sink.lock().unwrap().push(error);
}
    // rust: }));
    // rust: let unwound = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
    // rust: dispatch_component_types(&mods, &mut Vec::new())
    // rust: }));
        // Once the dispatch has unwound, the thread is in no mod.
    // rust: let _ = std::panic::catch_unwind(|| panic!("a broken mod's caller"));
    // rust: std::panic::set_hook(previous);
        // The game stops as before: the panic goes on to the dispatch's caller.
    // rust: assert!(unwound.is_err());
    // rust: let errors = caught.lock().unwrap();
    // rust: assert_eq!(errors.len(), 2);
    // rust: assert!(
    // rust: errors[0].ends_with("\nin native mod broken, hook component_types"),
    // rust: "{}",
    // rust: errors[0]
    // rust: );
    // rust: assert!(!errors[1].contains("in native mod"), "{}", errors[1]);
}

a_test_host_implements_only_what_its_hook_calls :: proc() {
}
    // rust: let mods = [Box::new(Probe) as Box<dyn Hooks>];
    // rust: let stack = stick();
    // rust: for (block, expected) in [("minecraft:stone", true), ("minecraft:dirt", false)] {
    // rust: let mut host = Reader {
    // rust: block,
    // rust: lines: Vec::new(),
}
    // rust: let mut claimed = false;
    // rust: dispatch_use_item_on(&mut host, &mods, &stack, [1, 2, 3], [0, 1, 0], &mut claimed);
    // rust: assert_eq!(claimed, expected, "{block}");
    // rust: let told: Vec<String> = host.lines.iter().map(Text::plain).collect();
    // rust: assert_eq!(told, [block], "{block}");
}
}

Backstab :: struct {

    // rust: impl Hooks for Backstab {
    // rust: fn living_incoming_damage_v2(
    // rust: &self,
    host: ^dyn Host,
    event: ^LivingIncomingDamageV2Event<'_>,
    // rust: ) -> Flow {
    // rust: assert_eq!(event.causing, 7);
    // rust: assert_eq!(event.kind, "minecraft:zombie");
    // rust: assert_eq!(event.damage_type, "minecraft:player_attack");
    // rust: if event.entity == 0 {
    // rust: return Flow::Cancel;
}
    // rust: let from = event.source_position.unwrap();
    // rust: let behind = (0..3)
    // rust: .map(|axis| (from[axis] - event.victim_position[axis]) * event.victim_view[axis])
    // rust: .sum::<f64>()
    // rust: < 0.0;
    // rust: if behind {
    // rust: let weapon = event.weapon.unwrap();
    // rust: let level = weapon.enchantment_level("probe:backstab");
    // rust: assert_eq!(weapon.enchantments().len(), 1);
    // rust: event.amount *= level as f32;
    // rust: let player = host.acting_player().unwrap();
    // rust: host.action_bar(player.uuid, Text::literal("backstab"));
}
    // rust: Flow::Continue
}
}

damage_v2_exposes_weapon_geometry_and_host_without_changing_v1 :: proc() {
}
    // rust: let mods = [Box::new(Backstab) as Box<dyn Hooks>];
    // rust: let mut weapon = stick();
    // rust: weapon.enchant("probe:backstab", 3);
    // rust: for (entity, source_z, expected, canceled_expected) in [
    // rust: (1, -1.0, 12.0, false),
    // rust: (1, 1.0, 4.0, false),
    // rust: (0, -1.0, 4.0, true),
    // rust: ] {
    // rust: let mut host = Reader {
    // rust: block: "minecraft:air",
    // rust: lines: Vec::new(),
}
    // rust: let mut amount = 4.0;
    // rust: let mut canceled = false;
    // rust: dispatch_living_incoming_damage_v2(
    // rust: &mut host,
    // rust: &mods,
    // rust: entity,
    // rust: "minecraft:zombie",
    // rust: "minecraft:player_attack",
    // rust: 7,
    // rust: Some([0.0, 0.0, source_z]),
    // rust: [0.0; 3],
    // rust: [0.0, 0.0, 1.0],
    // rust: Some(&weapon),
    // rust: &mut amount,
    // rust: &mut canceled,
    // rust: );
    // rust: assert_eq!((amount, canceled), (expected, canceled_expected));
    // rust: assert_eq!(host.lines.len(), usize::from(expected == 12.0));
}
    // rust: let mut amount = 4.0;
    // rust: let mut canceled = false;
    // rust: dispatch_living_incoming_damage(
    // rust: &mods,
    // rust: 1,
    // rust: "minecraft:zombie",
    // rust: "minecraft:player_attack",
    // rust: 7,
    // rust: 7,
    // rust: &mut amount,
    // rust: &mut canceled,
    // rust: );
    // rust: assert_eq!((amount, canceled), (4.0, false));
}

an_unexpected_host_call_names_the_method :: proc() {
}
    // rust: let mods = [Box::new(Chatty) as Box<dyn Hooks>];
    // rust: let mut host = Reader {
    // rust: block: "minecraft:stone",
    // rust: lines: Vec::new(),
}
    // rust: let mut claimed = false;
    // rust: dispatch_use_item_on(&mut host, &mods, &stick(), [0; 3], [0, 1, 0], &mut claimed);
}
}
