//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_block_entity
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Block entity data: what a chunk stores for its block entities (`BlockEntity`
//! and its payloads). Plain data, as vanilla's block entities are world data;
//! their behaviour lives with the features that use them (`containers`,
//! `brewing`, `signs`, ...), which re-export these types under their old paths.
// use horizon_client_core::{text::Text, who::Who};
// use horizon_items::{banner_layer::BannerLayer, items::ItemStack};
// use horizon_world::{
    // rust: level::sculk::SculkSpreader,
    // rust: nbt::{Compound, Tag},
}
// use std::{
    // rust: collections::HashMap,
    // rust: sync::{
    // rust: Arc,
    // rust: atomic::{AtomicU64, Ordering},
    // rust: },
}

/// An entity's UUID as its four ints (`UUIDUtil.CODEC`).
    // rust: pub type Uuid = [i32; 4];

pub const FurnaceKind = enum {
    Furnace,
    BlastFurnace,
    Smoker,
};
pub const Furnace = struct {
    kind: FurnaceKind,
    /// input, fuel, result
    items: [?ItemStack,
    lit_remaining: i32,
    lit_total: i32,
    cooking_timer: i32,
    cooking_total: i32,
    speed: f32,
    /// `AbstractFurnaceBlockEntity.recipesUsed`: how many of each recipe this furnace has
    /// made since a player last took from its output. The experience is owed per recipe
    /// rather than per item, and a save keeps it as the `RecipesUsed` compound.
    recipes_used: HashMap<[]const u8,
};
pub const BlockEntity = enum {
    Chest(Vec<Option<ItemStack>>),
    Furnace(Furnace),
    Brewing(Box<BrewingStand>),
    /// Signs and hanging signs (`SignBlockEntity`).
    Sign(SignData),
    /// `JukeboxBlockEntity`: the record and its `JukeboxSongPlayer`.
    Jukebox(Jukebox),
    /// `BeaconBlockEntity`.
    Beacon(Box<Beacon>),
    /// `LecternBlockEntity`: the book and the open page.
    Lectern(Lectern),
    /// Sculk sensors, shriekers and catalysts (`crate::sculk`).
    Sculk(Box<SculkEntity>),
    /// `CreakingHeartBlockEntity`: its protector and the hurt emitter.
    CreakingHeart(Box<CreakingHeart>),
    /// `BannerBlockEntity`: the pattern layers.
    Banner(Banner),
    /// `CrafterBlockEntity`.
    Crafter(Crafter),
    /// `SpawnerBlockEntity` (`crate::mobs::spawner`).
    Spawner(Box<Spawner>),
    /// `TrialSpawnerBlockEntity` (`crate::mobs::trial_spawner`).
    TrialSpawner(Box<TrialSpawner>),
    /// `VaultBlockEntity` (`crate::vault`).
    Vault(Box<Vault>),
    /// `BeehiveBlockEntity` of beehives and bee nests (`crate::beehive`).
    Beehive(Box<Beehive>),
    /// `CommandBlockEntity` of the three command blocks (`crate::command_block`).
    CommandBlock(Box<CommandBlock>),
    /// `CampfireBlockEntity` of campfires and soul campfires.
    Campfire(Box<Campfire>),
    /// `SkullBlockEntity` of every skull and head block.
    Skull(Skull),
    /// `TheEndGatewayBlockEntity`: its age and configured destination.
    EndGateway(EndGateway),
    /// `DaylightDetectorBlockEntity`: no data, only the ticker
    /// (`DaylightDetectorBlock.tickEntity`).
    DaylightDetector,
    /// Suspicious sand and gravel: saved loot and the transient brushed face.
    Brushable(Box<Brushable>),
    /// A shelf holds three displayed item stacks.
    Shelf(Box<Shelf>),
    /// `ChiseledBookShelfBlockEntity`: a `Container` of six one-book slots.
    ChiseledBookshelf(Box<ChiseledBookshelf>),
    /// A block entity of a mod (`native_block_entity`), kept as its saved
    /// compound for the mod to read and change.
    Mod(Box<ModBlockEntity>),
    /// `PotentSulfurBlockEntity` (`game/potent_sulfur.rs`).
    PotentSulfur(PotentSulfur),
    /// `StructureBlockEntity` (`structure_block.rs`).
    StructureBlock(Box<crate::structure_block::StructureBlock>),
    /// `JigsawBlockEntity` (`jigsaw_block.rs`).
    JigsawBlock(Box<crate::jigsaw_block::JigsawBlock>),
    /// `TestBlockEntity` (`test_block.rs`).
    TestBlock(Box<crate::test_block::TestBlock>),
    /// `TestInstanceBlockEntity` (`test_instance_block.rs`).
    TestInstanceBlock(Box<crate::test_instance_block::TestInstanceBlock>),
};
/// A mod's block entity, read and changed through its fields
/// (`ModBlockEntityFields`) as a struct's: `entity.nbt`. Each change goes
/// through `DerefMut` and gives it a new `revision`, so a client tells
/// whether what it kept of it (`BlockEntityDraw::keep`) is still right
/// without comparing the whole entity, and no write can skip that.
pub const ModBlockEntity = struct {
    fields: ModBlockEntityFields,
    revision: ModRevision,
};
/// What a `ModBlockEntity` holds: its type id (`mymod:machine`), its saved
/// compound without `id`, `x`, `y`, `z` and `Items`, its item slots
/// (`Items`) when its block has a container (`ModContainer`), and the data
/// slots its menu shows (`ContainerData`: a furnace menu's flame and arrow),
/// which the mod sets and nothing saves.
pub const ModBlockEntityFields = struct {
    id: []const u8,
    nbt: Compound,
    items: std.ArrayList(?ItemStack),
    data: std.ArrayList(i32),
};
/// Which contents a `ModBlockEntity` has had: one per entity made (a clone
/// is another), counted on by each change. Equal revisions, equal contents.
/// Neither saved nor compared.
pub const ModRevision = struct {
    born: u64,
    changes: u64,
};
pub const MOD_BLOCK_ENTITIES_MADE: AtomicU64 = AtomicU64::new(0);
    // rust: impl ModBlockEntity {
pub fn new(fields: ModBlockEntityFields) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: fields,
    // rust: revision: ModRevision {
    // rust: born: MOD_BLOCK_ENTITIES_MADE.fetch_add(1, Ordering::Relaxed),
    // rust: changes: 0,
    // rust: },
}
}
pub fn revision(self: *Self) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.revision
}
    /// A client's copy loads the tag the server sent (`loadWithComponents`
    /// in `ClientPacketListener.handleBlockEntityData`): `tag`'s fields
    /// replace its own of the same names. One it already has as sent is
    /// left alone, so a tag sent again unchanged keeps its revision.
pub fn merge_update_tag(self: *Self, tag: *Compound) void {
}
    // rust: for (k, v) in tag {
    // rust: if self.nbt.get(k) != Some(v) {
    // rust: self.nbt.insert(k.clone(), v.clone());
}
}
}
}
    // rust: impl From<ModBlockEntityFields> for ModBlockEntity {
pub fn from(fields: ModBlockEntityFields) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(fields)
}
}
    // rust: impl Default for ModBlockEntity {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(ModBlockEntityFields::default())
}
}
    // rust: impl Clone for ModBlockEntity {
pub fn clone(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(self.fields.clone())
}
}
    // rust: impl PartialEq for ModBlockEntity {
pub fn eq(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fields == other.fields
}
}
    // rust: impl std::fmt::Debug for ModBlockEntity {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fields.fmt(f)
}
}
    // rust: impl std::ops::Deref for ModBlockEntity {
    // rust: type Target = ModBlockEntityFields;
pub fn deref(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.fields
}
}
    // rust: impl std::ops::DerefMut for ModBlockEntity {
pub fn deref_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.revision.changes += 1;
    // rust: &mut self.fields
}
}
/// The container of a mod block's block entity, as a `WorldlyContainer`
/// says it: its slot count, the slots each face reaches
/// (`getSlotsForFace`, by `Direction`: down, up, north, south, west, east),
/// and the slots hoppers may put into (`canPlaceItemThroughFace`) and take
/// from (`canTakeItemThroughFace`); and the vanilla menu that shows its
/// slots when the block is used, if any (`MOD_MENUS`).
pub const ModContainer = struct {
    slots: usize,
    faces: [std.ArrayList(usize),
    inputs: std.ArrayList(usize),
    outputs: std.ArrayList(usize),
    menu: ?[]const u8,
};
/// The fluid tanks of a mod block's block entity, in the container's shape:
/// each tank's capacity in millibuckets, the tanks each face reaches, and
/// the tanks a fill may reach and a drain may take. The tanks' contents are
/// not here: they live in the entity's saved compound, under `fluids`, so
/// they survive restarts and the block's own tick reads them.
pub const ModFluidTanks = struct {
    /// Each tank's capacity in millibuckets, in tank order.
    tanks: std.ArrayList(i32),
    faces: [std.ArrayList(usize),
    /// The tanks a fill may reach (`canPlaceItemThroughFace`).
    inputs: std.ArrayList(usize),
    /// The tanks a drain may take from (`canTakeItemThroughFace`).
    outputs: std.ArrayList(usize),
};
/// The energy buffer of a mod block's block entity (NeoForge's
/// `SimpleEnergyHandler`): its capacity, the most one insert and one extract
/// moves, and the faces a fill may come through and a drain may leave by.
/// The amount is not here: it lives in the entity's saved compound, under
/// `energy`, so it survives restarts and the block's own tick reads it.
pub const ModEnergyBuffer = struct {
    capacity: i32,
    /// The most one insert moves; 0 takes none.
    max_insert: i32,
    /// The most one extract moves; 0 gives none.
    max_extract: i32,
    /// The faces, by `Direction` number, a fill may come through.
    insert_faces: [bool,
    /// The faces a drain may leave by.
    extract_faces: [bool,
};
/// The vanilla menus a mod container can open, with the slot count each
/// shows: slot grids, and the furnaces' (input, fuel, result), whose four
/// data slots draw the flame (`data[0]` of `data[1]`) and the arrow
/// (`data[2]` of `data[3]`), as `AbstractFurnaceBlockEntity.dataAccess`.
    // rust: pub const MOD_MENUS: [(&str, usize); 11] = [
    // rust: ("minecraft:furnace", 3),
    // rust: ("minecraft:blast_furnace", 3),
    // rust: ("minecraft:smoker", 3),
    // rust: ("minecraft:hopper", 5),
    // rust: ("minecraft:generic_3x3", 9),
    // rust: ("minecraft:generic_9x1", 9),
    // rust: ("minecraft:generic_9x2", 18),
    // rust: ("minecraft:generic_9x3", 27),
    // rust: ("minecraft:generic_9x4", 36),
    // rust: ("minecraft:generic_9x5", 45),
    // rust: ("minecraft:generic_9x6", 54),
    // rust: ];
/// `PotentSulfurBlockEntity`: the seconds left to the geyser's next change of
/// state (`waitingCountdown`, saved as `countdown`) and the game time of its
/// last eruption block event, which the client's plume counts from.
pub const PotentSulfur = struct {
    waiting_countdown: i32,
    eruption_tick: i64,
};
    // rust: impl Default for PotentSulfur {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: waiting_countdown: -1,
    // rust: eruption_tick: -1,
}
}
}
/// `BrushableBlockEntity`: the loot table is resolved on the first brush.
pub const Brushable = struct {
    loot_table: ?horizon_world::nbt::Tag,
    loot_seed: ?horizon_world::nbt::Tag,
    item: ?ItemStack,
    /// Direction's legacy network id; not saved to disk by vanilla.
    hit_direction: ?i32,
};
/// `ShelfBlockEntity`'s displayed slots and alignment flag.
pub const Shelf = struct {
    items: [?ItemStack,
    align_to_bottom: bool,
};
/// `ChiseledBookShelfBlockEntity`: six slots and `lastInteractedSlot`.
pub const ChiseledBookshelf = struct {
    items: [?ItemStack,
    last_slot: i32,
};
    // rust: impl Default for ChiseledBookshelf {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: items: Default::default(),
    // rust: last_slot: -1,
}
}
}
/// `TheEndGatewayBlockEntity`.
pub const EndGateway = struct {
    age: i64,
    exit_portal: Option<[i32,
    exact_teleport: bool,
};
/// `CampfireBlockEntity`: four cooking slots, each with its
/// `cookingProgress` and `cookingTime` (the recipe's).
pub const Campfire = struct {
    items: [?ItemStack,
    progress: [i32,
    total: [i32,
};
/// `SkullBlockEntity`: the player profile the head shows (kept as loaded:
/// a compound, or a string when it names a player only), the note block
/// sound and `custom_name`.
pub const Skull = struct {
    profile: ?horizon_world::nbt::Tag,
    note_block_sound: ?[]const u8,
    custom_name: ?horizon_world::nbt::Tag,
    /// What `profile` draws, read from it once rather than every frame.
    skin: ?SkullSkin,
};
/// `SkullBlockRenderer.getPlayerSkin` of a head's profile: its skin's URL
/// with the `skins/<sha1>` sprite it downloads to, and the
/// `DefaultPlayerSkin` drawn until that sprite is there (steve for a
/// profile with no id).
pub const SkullSkin = struct {
    download: Option<([]const u8,
    /// `ResolvableProfile.nameOrId` when the profile is `Dynamic` (a name or
    /// an id only): the key `skins::Resolver` resolves it by.
    dynamic: ?NameOrId,
    /// `PlayerSkin.Patch.body`: the profile's `texture`, a resource pack
    /// texture drawn instead of any skin.
    texture: ?[]const u8,
    fallback: *'static str,
};
/// `Either<String, UUID>`: the key a `Dynamic` `ResolvableProfile` resolves
/// by (`ResolvableProfile.nameOrId`).
pub const NameOrId = enum {
    Name(String),
    Id(u128),
};
/// `CrafterBlockEntity`: nine slots that can be disabled, the powered flag
/// and the ticks left in the crafting animation.
pub const Crafter = struct {
    items: [?ItemStack,
    disabled: [bool,
    triggered: bool,
    crafting_ticks: i32,
    /// The block state's `triggered` when last ticked (not saved): the block
    /// entity flag follows it only when it changes (`CrafterBlock.neighborChanged`).
    state_triggered: ?bool,
};
pub const Banner = struct {
    layers: std.ArrayList(BannerLayer),
    name: ?[]const u8,
    /// Components not consumed by BannerBlockEntity's implicit fields.
    components: horizon_world::nbt::Compound,
};
/// `CreakingHeartBlockEntity` (the logic is in `game/creaking.rs`).
pub const CreakingHeart = struct {
    /// The protector: its entity id once resolved, and its UUID (the saved form).
    creaking: ?(Option<u32,
    ticks_existed: i64,
    ticker: i32,
    /// Ticks left of the hurt effect (`emitter`) and where it heads.
    emitter: i32,
    emitter_target: Option<[f64,
    output_signal: i32,
};
pub const Lectern = struct {
    book: ?ItemStack,
    page: i32,
};
pub const Beacon = struct {
    levels: i32,
    /// Effect ids (`minecraft:speed`).
    primary: ?[]const u8,
    secondary: ?[]const u8,
    /// Beam sections (RGB colour, height) and the ones being rebuilt.
    sections: Vec<(u32,
    checking: Vec<(u32,
    last_check_y: i32,
};
pub const Jukebox = struct {
    /// `JukeboxBlockEntity`'s one slot (`ContainerSingleItem`), so a hopper or
    /// a dropper reaches it as it reaches any container.
    items: [?ItemStack,
    /// `ticks_since_song_started`, while a song plays.
    ticks: i64,
    playing: bool,
};
    // rust: impl Jukebox {
    /// `JukeboxBlockEntity.getTheItem`: the disc it holds.
pub fn record(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items[0].as_ref()
}
}
/// `BrewingStandBlockEntity` state. Slots: 0-2 bottles, 3 ingredient, 4 fuel.
pub const BrewingStand = struct {
    items: [?ItemStack,
    brew_time: i32,
    total_brew_time: i32,
    fuel: i32,
    total_fuel: i32,
    speed: f32,
    ingredient: ?*str,
    last_bottles: Option<[bool,
};
/// One sign side (`SignText`).
pub const SignText = struct {
    lines: [[]const u8,
    /// `DyeColor` id.
    color: u8,
    glowing: bool,
    /// The `click_event` in each line's component style, as saved.
    click: [?Tag,
    /// Each line's saved component when it is more than plain text (a colour,
    /// siblings, a list), so its style survives loading, saving and the
    /// network. See `SignText::message` for a line edited since.
    saved: [?SavedLine,
};
/// A sign line's saved component and the text it showed when it was read.
pub const SavedLine = struct {
    text: []const u8,
    component: Tag,
};
/// `SignBlockEntity` / `HangingSignBlockEntity` data.
pub const SignData = struct {
    hanging: bool,
    front: SignText,
    back: SignText,
    waxed: bool,
    /// `allow_op_features`: the sign's click events may run commands.
    allow_op_features: bool,
};
/// `VibrationInfo`.
pub const Info = struct {
    event: *'static str,
    distance: f32,
    pos: [f64,
    source: ?Who,
    owner: ?Who,
};
/// `VibrationSelector`: the closest, then highest-frequency candidate of a tick.
pub const Selector = struct {
    current: Option<(Info,
};
/// `VibrationSystem.Data`.
pub const Data = struct {
    current: ?Info,
    travel: i32,
    selector: Selector,
};
/// Which sculk block entity this is.
pub const SculkKind = enum {
    Sensor,
    Calibrated,
    Shrieker,
    Catalyst,
};
/// `SculkSensorBlockEntity`, `CalibratedSculkSensorBlockEntity`,
/// `SculkShriekerBlockEntity` and `SculkCatalystBlockEntity`.
pub const SculkEntity = struct {
    kind: SculkKind,
    vibration: Data,
    /// `last_vibration_frequency` (sensors).
    last_frequency: i32,
    /// `warning_level` (shriekers).
    warning_level: i32,
    /// The catalyst's charge cursors.
    spreader: SculkSpreader,
};
/// `SpawnData.CustomSpawnRules`: the block and sky light the spawn block
/// must have (inclusive ranges within 0..=15).
pub const CustomSpawnRules = struct {
    block: (i32,
    sky: (i32,
};
/// `SpawnData`: the entity to spawn, optional light rules and an equipment
/// table (kept as loaded).
pub const SpawnData = struct {
    entity: Compound,
    custom_spawn_rules: ?CustomSpawnRules,
    equipment: ?Tag,
};
/// Which `SpawnData` is next: one of the potentials (the same object in
/// vanilla, so changing it changes the potential) or its own.
pub const Next = enum {
    Potential(usize),
    Own(SpawnData),
};
/// `BaseSpawner`.
pub const Spawner = struct {
    spawn_delay: i32,
    /// `SpawnPotentials`: data and weight.
    potentials: Vec<(SpawnData,
    next: ?Next,
    min_spawn_delay: i32,
    max_spawn_delay: i32,
    spawn_count: i32,
    max_nearby_entities: i32,
    required_player_range: i32,
    spawn_range: i32,
    /// The client copy's delay (`spawnDelay` on the client level), which
    /// speeds the spin up as the next spawn nears.
    client_delay: i32,
    spin: f64,
    o_spin: f64,
};
    // rust: impl Default for Spawner {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: spawn_delay: 20,
    // rust: potentials: Vec::new(),
    // rust: next: None,
    // rust: min_spawn_delay: 200,
    // rust: max_spawn_delay: 800,
    // rust: spawn_count: 4,
    // rust: max_nearby_entities: 6,
    // rust: required_player_range: 16,
    // rust: spawn_range: 4,
    // rust: client_delay: 20,
    // rust: spin: 0.0,
    // rust: o_spin: 0.0,
}
}
}
/// `TrialSpawnerConfig`.
pub const TrialConfig = struct {
    spawn_range: i32,
    total_mobs: f32,
    simultaneous_mobs: f32,
    total_mobs_added_per_player: f32,
    simultaneous_mobs_added_per_player: f32,
    ticks_between_spawn: i32,
    spawn_potentials: Vec<(SpawnData,
    loot_tables_to_eject: Vec<([]const u8,
    items_to_drop_when_ominous: []const u8,
};
    // rust: impl Default for TrialConfig {
    /// `TrialSpawnerConfig.Builder`'s defaults.
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: spawn_range: 4,
    // rust: total_mobs: 6.0,
    // rust: simultaneous_mobs: 2.0,
    // rust: total_mobs_added_per_player: 2.0,
    // rust: simultaneous_mobs_added_per_player: 1.0,
    // rust: ticks_between_spawn: 40,
    // rust: spawn_potentials: Vec::new(),
    // rust: loot_tables_to_eject: vec![
    // rust: ("minecraft:spawners/trial_chamber/consumables".into(), 1),
    // rust: ("minecraft:spawners/trial_chamber/key".into(), 1),
    // rust: ],
    // rust: items_to_drop_when_ominous:
    // rust: "minecraft:spawners/trial_chamber/items_to_drop_when_ominous".into(),
}
}
}
/// A `Holder<TrialSpawnerConfig>` as saved: a registry id
/// (`minecraft:trial_chamber/breeze/normal`) or an inline config.
pub const ConfigSlot = struct {
    /// The value as loaded, written back as is; None for the default.
    saved: ?Tag,
    config: TrialConfig,
};
/// `TrialSpawner` with its `TrialSpawnerStateData`.
pub const TrialSpawner = struct {
    normal: ConfigSlot,
    ominous: ConfigSlot,
    target_cooldown_length: i32,
    required_player_range: i32,
    detected_players: std.ArrayList(Uuid),
    current_mobs: std.ArrayList(Uuid),
    cooldown_ends_at: i64,
    next_mob_spawns_at: i64,
    total_mobs_spawned: i32,
    next_spawn_data: ?SpawnData,
    ejecting_loot_table: ?[]const u8,
    /// `isOminous`, set from the block on every server tick.
    is_ominous: bool,
    /// The server's display entity exists (`getOrCreateDisplayEntity`): it is
    /// made once per loaded block entity and kept.
    has_display: bool,
    spin: f64,
    o_spin: f64,
    /// `getDispensingItems`, kept once rolled (not saved): the ominous items
    /// and their weights (the rolled counts).
    dispensing: ?std.ArrayList(ItemStack),
};
    // rust: impl Default for TrialSpawner {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: normal: ConfigSlot::default(),
    // rust: ominous: ConfigSlot::default(),
    // rust: target_cooldown_length: 36000,
    // rust: required_player_range: 14,
    // rust: detected_players: Vec::new(),
    // rust: current_mobs: Vec::new(),
    // rust: cooldown_ends_at: 0,
    // rust: next_mob_spawns_at: 0,
    // rust: total_mobs_spawned: 0,
    // rust: next_spawn_data: None,
    // rust: ejecting_loot_table: None,
    // rust: is_ominous: false,
    // rust: has_display: false,
    // rust: spin: 0.0,
    // rust: o_spin: 0.0,
    // rust: dispensing: None,
}
}
}
/// `VaultConfig`.
pub const VaultConfig = struct {
    loot_table: []const u8,
    activation_range: f64,
    deactivation_range: f64,
    /// None when the config has no key (`ItemStack.EMPTY`): the vault never opens.
    key_item: ?ItemStack,
    override_loot_table_to_display: ?[]const u8,
};
/// `VaultBlockEntity`: its config, server data and shared data.
pub const Vault = struct {
    config: VaultConfig,
    /// `VaultServerData`, oldest rewarded player first.
    rewarded_players: std.ArrayList(Uuid),
    state_updating_resumes_at: i64,
    /// Popped from the end.
    items_to_eject: std.ArrayList(ItemStack),
    total_ejections_needed: i32,
    last_insert_fail_timestamp: i64,
    /// `VaultSharedData`.
    display_item: ?ItemStack,
    connected_players: std.ArrayList(Uuid),
    connected_particles_range: f64,
    /// The shared data changed since the last tick sent it.
    shared_dirty: bool,
    /// `VaultClientData`: the display item's spin and the previous tick's, in degrees.
    spin: f32,
    o_spin: f32,
};
/// `BeehiveBlockEntity`: the bees inside and the flower one of them knew.
pub const Beehive = struct {
    bees: std.ArrayList(Occupant),
    flower: Option<[i32,
};
/// `BeehiveBlockEntity.Occupant`: a bee's tag (with its `id`), its time in
/// the hive and the time it stays at least.
pub const Occupant = struct {
    entity_data: Tag,
    ticks_in_hive: i32,
    min_ticks_in_hive: i32,
};
pub const CommandBlock = struct {
    command: []const u8,
    success_count: i32,
    /// `CustomName` as saved (a text component).
    custom_name: ?Tag,
    track_output: bool,
    last_output: ?Text,
    update_last_execution: bool,
    /// The game time of the last run, -1 for none.
    last_execution: i64,
    powered: bool,
    auto: bool,
    condition_met: bool,
};

    // rust: mod tests {
//     use super::*;

pub fn a_mod_block_entitys_revision_moves_with_each_change_and_only_then() void {
}
    // rust: let mut machine = ModBlockEntity::new(ModBlockEntityFields {
    // rust: id: "mymod:machine".into(),
    // rust: data: vec![0],
    // rust: ..Default::default()
    // rust: });
    // rust: let made = machine.revision();
        // Reads leave it.
    // rust: assert_eq!(machine.data[0] + machine.nbt.len() as i32, 0);
    // rust: assert_eq!(machine.revision(), made);
        // Every way to change a field moves it.
    // rust: let mut seen = vec![made];
    // rust: let changes: [fn(&mut ModBlockEntity); 4] = [
    // rust: |m| m.data[0] = 1,
    // rust: |m| _ = m.nbt.insert("progress".into(), Tag::Int(3)),
    // rust: |m| m.items.push(None),
    // rust: |m| m.id.push('s'),
    // rust: ];
    // rust: for change in changes {
    // rust: change(&mut machine);
    // rust: assert!(!seen.contains(&machine.revision()));
    // rust: seen.push(machine.revision());
}
        // Another entity, or a clone, never shares one, even with equal
        // contents; equality is the contents' alone.
    // rust: let copy = machine.clone();
    // rust: assert_eq!(copy, machine);
    // rust: assert!(!seen.contains(&copy.revision()));
    // rust: let fresh = ModBlockEntity::default();
    // rust: assert_ne!(fresh.revision(), ModBlockEntity::default().revision());
}

pub fn an_update_tag_sent_again_unchanged_keeps_the_revision() void {
}
    // rust: let mut machine = ModBlockEntity::default();
    // rust: let tag = Compound::from([
    // rust: ("progress".into(), Tag::Int(3)),
    // rust: ("fuel".into(), Tag::Int(9)),
    // rust: ]);
    // rust: machine.merge_update_tag(&tag);
    // rust: let merged = machine.revision();
    // rust: machine.merge_update_tag(&tag);
    // rust: assert_eq!(machine.revision(), merged);
        // One field changed: replaced, the other kept, the revision moved.
    // rust: machine.merge_update_tag(&Compound::from([("progress".into(), Tag::Int(4))]));
    // rust: assert_ne!(machine.revision(), merged);
    // rust: assert_eq!(
    // rust: machine.nbt,
    // rust: Compound::from([
    // rust: ("progress".into(), Tag::Int(4)),
    // rust: ("fuel".into(), Tag::Int(9)),
    // rust: ])
    // rust: );
}
}
