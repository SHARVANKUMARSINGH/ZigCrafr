//! Transpiled from Horizon Rust crate
package horizon_client_world_loading

import "core:fmt"
import "core:mem"
import "core:math"

// Prepare local worlds without blocking the window's event loop.
// use super::*;

    // rust: pub(super) struct WorldRequest {
    // rust: pub save_root: PathBuf,
    // rust: pub folder: String,
    // rust: pub name: Option<String>,
    // rust: pub seed: Option<i64>,
    // rust: pub creative: bool,
    // rust: pub create: Option<horizon_client::title::WorldOptions>,
}

    // rust: pub(super) struct PreparedWorld {
    // rust: pub save_root: PathBuf,
    // The levels' shapes, from the world's dimension types.
    // rust: pub shapes: horizon_client::chunk::LevelShapes,
    // rust: pub level: Level,
    // rust: pub world: World,
    // rust: pub streaming: Streaming,
    // rust: pub save: Arc<SaveDir>,
    // rust: pub session_lock: horizon_client::save::SessionLock,
    // rust: pub rand_sequences: horizon_client::random_sequences::RandomSequences,
    // rust: pub locator: Option<Arc<VanillaTerrain>>,
}

    // rust: impl WorldRequest {
    // rust: pub fn new(
    // rust: folder: &str,
    // rust: name: Option<&str>,
    // rust: seed: Option<i64>,
    // rust: creative: bool,
    // rust: create: Option<&horizon_client::title::WorldOptions>,
    // rust: ) -> Result<Self> {
    // rust: Ok(Self {
    // rust: save_root: std::env::current_dir()?.join("saves").join(folder),
    // rust: folder: folder.to_owned(),
    // rust: name: name.map(str::to_owned),
    // rust: seed,
    // rust: creative,
    // rust: create: create.cloned(),
    // rust: })
}

    // rust: pub fn prepare(
    // rust: self,
    // rust: res: &Resources,
    // rust: pack: &PackResources,
    // rust: options: &Options,
    // rust: settings: &Settings,
    // rust: upgrade: &horizon_world::datafix::progress::UpgradeProgress,
    // rust: ) -> Result<PreparedWorld> {
    // rust: let _prepare_step = startup::step("world.prepare");
        // Before any chunk is read: a loaded container with a loot table is rolled as its chunk
        // is decoded (`save::roll_loaded_loot`), and the spawn chunks are read while the world
        // opens. Every world opens here: on the server thread, on a dedicated server.
    // rust: let loot = || {
    // rust: horizon_client::structure_blocks::loot_data(
    // rust: &options.resources,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: );
}
        // Bone meal's and saplings' features, over the plain worldgen bundle.
    // rust: let live_features = || growth::install_live_features(res, pack, options);
    // rust: if res.threads() <= 1 {
    // rust: loot();
    // rust: let prepared = self.prepare_world(res, pack, options, settings, upgrade)?;
    // rust: live_features();
    // rust: return Ok(prepared);
}
        // Neither needs the world: they load beside it (the generator's decoration keeps one
        // core busy) and are done before it opens. A bundle both read loads once.
    // rust: std::thread::scope(|scope| {
    // rust: let loot = scope.spawn(loot);
    // rust: let live_features = scope.spawn(live_features);
    // rust: let prepared = self.prepare_world(res, pack, options, settings, upgrade);
    // rust: for helper in [loot, live_features] {
    // rust: helper
    // rust: .join()
    // rust: .unwrap_or_else(|panic| std::panic::resume_unwind(panic));
}
    // rust: prepared
    // rust: })
}

    // rust: fn prepare_world(
    // rust: self,
    // rust: res: &Resources,
    // rust: pack: &PackResources,
    // rust: options: &Options,
    // rust: settings: &Settings,
    // rust: upgrade: &horizon_world::datafix::progress::UpgradeProgress,
    // rust: ) -> Result<PreparedWorld> {
    // rust: let Self {
    // rust: save_root,
    // rust: folder,
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: create,
    // rust: } = self;
    // rust: let name = name.as_deref();
    // rust: let create = create.as_ref();
        // openWorldLoadLevelData: level data that does not read is RecoverWorldDataScreen's to
        // handle (the title screen shows it); a world opened another way must not become a
        // new one with a random seed under the same name.
        // The dedicated server's `Main` takes level.dat_old without asking
        // (`getUnfixedDataTagWithFallback`): there is no world list to recover from.
    // rust: if options.dedicated.is_some()
    // rust: && horizon_client::save::fall_back_to_level_dat_old(&save_root)
    // rust: {
    // rust: log::warn!(
    // rust: "Horizon: level.dat of \"{folder}\" did not read; level.dat_old took its place"
    // rust: );
}
    // rust: if let Some(issue) = horizon_client::save::level_data_needs_recovery(&save_root) {
    // rust: let why = match issue {
    // rust: horizon_client::save::DatIssue::Missing => "level.dat is missing".to_owned(),
    // rust: horizon_client::save::DatIssue::Unreadable(why) => why,
}
    // rust: return Err(format!(
    // rust: "Failed to load world \"{folder}\": its level data does not read ({why}). \
    // rust: Open it from the world list to try restoring level.dat_old."
    // rust: )
    // rust: .into());
}
        // LevelSummary.isCompatible, which the dedicated server's `Main` checks before it fixes
        // a world: a world from another series is refused, never upgraded in place.
    // rust: if let Some(version) = horizon_client::save::incompatible_version(&save_root) {
    // rust: let version = if version.is_empty() {
    // rust: "unknown".to_owned()
    // rust: } else {
    // rust: version
}
    // rust: return Err(format!(
    // rust: "Failed to load world \"{folder}\": it was last played in version {version}, \
    // rust: which cannot be opened in this version."
    // rust: )
    // rust: .into());
}
    // rust: horizon_client::save::upgrade_older_world_with(&save_root, upgrade)?;
    // rust: horizon_client::save::migrate_legacy(&save_root)?;
    // rust: let session_lock = horizon_client::save::SessionLock::acquire(&save_root)?;
        // RandomSequences: the world's data/minecraft/random_sequences.dat.
    // rust: let rand_sequences =
    // rust: horizon_client::save::read_dat(&save_root.join("data/minecraft/random_sequences.dat"))
    // rust: .and_then(|t| t.get("data").cloned())
    // rust: .map(|d| horizon_client::random_sequences::RandomSequences::from_nbt(&d))
    // rust: .unwrap_or_default();
    // rust: let existing = Level::read(&save_root);
    // rust: let created = existing.is_none();
    // rust: let level = existing.unwrap_or_else(|| Level {
    // rust: name: name.unwrap_or(&folder).to_owned(),
            // WorldOptions.randomSeed when no seed was given.
    // rust: seed: seed.unwrap_or_else(|| {
    // rust: let t = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos() as u64);
    // rust: (t ^ (t >> 29)).wrapping_mul(0x9E37_79B9_7F4A_7C15) as i64
    // rust: }),
    // rust: creative,
    // rust: day_time: 0,
    // rust: health: 20.0,
    // rust: food: 20,
    // rust: saturation: 5.0,
    // rust: ..Level::default()
    // rust: });
    // rust: let mut level = level;
        // CreateWorldScreen's choices, before streaming reads the generator.
    // rust: if created && let Some(o) = create {
    // rust: level.hardcore = o.hardcore;
    // rust: level.difficulty = horizon_client::title::DIFFICULTIES[o.difficulty()].into();
    // rust: level.allow_commands = Some(o.commands(creative));
    // rust: horizon_client::save::write_world_gen_settings_with(
    // rust: &save_root,
    // rust: level.seed,
    // rust: o.world_gen(),
    // rust: o.flat_settings(),
    // rust: o.single_biome(),
    // rust: )?;
            // The DataPackConfig the screen chose: the picked packs on,
            // everything else disabled — the feature packs left out, and the
            // world packs the Data Packs screen held back (`install` copies
            // every pack of the folder, selected or not).
    // rust: let packs = horizon_client::datapack::feature_packs(&options.resources);
    // rust: level.data_packs = Some({
    // rust: let mut disabled: Vec<String> = packs
    // rust: .iter()
    // rust: .map(|p| p.id.clone())
    // rust: .filter(|f| !o.data_packs.contains(f))
    // rust: .collect();
    // rust: if let Some(dir) = o.pack_dir.as_deref() {
    // rust: disabled.extend(
    // rust: horizon_client::packs::folder(
    // rust: std::path::Path::new(dir),
    // rust: horizon_core::version::DATA_PACK_FORMAT,
    // rust: )
    // rust: .into_iter()
    // rust: .map(|p| p.id)
    // rust: .filter(|id| !o.data_packs.contains(id)),
    // rust: );
}
    // rust: (o.data_packs.clone(), disabled)
    // rust: });
            // WorldDataConfiguration's `enabled_features`: the flags of the
            // picked feature packs over vanilla's (`FeatureFlags.REGISTRY`'s
            // codec writes the whole set, `minecraft:vanilla` included, and
            // omits the tag when it is the default).
    // rust: level.enabled_features = o.enabled_features(&options.resources);
            // CreateWorldScreen copies the edited rules with the final flags,
            // even when the player never opened the rules screen.
    // rust: level.game_rules = o
    // rust: .rules
    // rust: .copy_with_features(&level.enabled_features)
    // rust: .by_name();
}
        // Worlds made without the Create New World screen (--world, the
        // control socket) take its default: commands on for Creative only.
    // rust: if created {
    // rust: level.allow_commands.get_or_insert(creative);
}
    // rust: if let Some(d) = &options.dimension {
    // rust: level.dimension = d.clone();
    // rust: level.position = None;
}
    // rust: let dim = Dim::from_id(&level.dimension);
    // rust: let shapes = level_shapes(&save_root, res.biomes());
    // rust: let shape = shapes.get(dim.id());
    // rust: let streaming_step = startup::step("world.make_streaming");
    // rust: let (mut streaming, save, locator) = make_streaming(
    // rust: res,
    // rust: pack,
    // rust: options,
    // rust: settings,
    // rust: &save_root,
    // rust: dim,
    // rust: shape,
    // rust: level.seed,
    // rust: &level.enabled_features,
    // rust: )?;
    // rust: drop(streaming_step);
    // rust: streaming.radius = settings.render_distance;
    // rust: let mut world = World::new(res.facts().air, level.seed);
    // rust: world.attachments = save.load_attachments();
    // rust: world.shape = shape;
    // rust: world.fast_lava = dim == Dim::Nether;
    // rust: world.game_time = level.time;
    // rust: world.day_time = options.time.unwrap_or(level.day_time);
    // rust: world.weather = level.weather;
    // rust: if let Some(w) = options.weather.as_deref() {
            // /weather: clear, rain or thunder for a long duration.
    // rust: let (rain, thunder) = (w != "clear", w == "thunder");
    // rust: world.weather = horizon_client::world::Weather {
    // rust: clear_time: if w == "clear" { 6000 } else { 0 },
    // rust: rain_time: 6000,
    // rust: thunder_time: 6000,
    // rust: raining: rain,
    // rust: thundering: thunder,
    // rust: rain_level: if rain { (1.0, 1.0) } else { (0.0, 0.0) },
    // rust: thunder_level: if thunder { (1.0, 1.0) } else { (0.0, 0.0) },
}
}

        // Persist new metadata on the worker too, before publishing the world.
    // rust: if !save_root.join("level.dat").exists() {
    // rust: level.write(&save_root)?;
}
    // rust: Ok(PreparedWorld {
    // rust: save_root,
    // rust: shapes,
    // rust: level,
    // rust: world,
    // rust: streaming,
    // rust: save,
    // rust: session_lock,
    // rust: rand_sequences,
    // rust: locator,
    // rust: })
}
}

    // rust: pub(super) struct WorldLoader {
    // rust: handle: JoinHandle<std::result::Result<PreparedWorld, String>>,
}

    // rust: impl WorldLoader {
    // Prepare the world on its own thread. `upgrade` is what its upgrade has done
    // (`UpgradeProgress`), which the window's `FileFixerProgressScreen` shows while the
    // file fixers run, and where its Cancel stops them.
    // rust: pub fn start(
    // rust: request: WorldRequest,
    // rust: res: Arc<Resources>,
    // rust: pack: PackResources,
    // rust: options: Options,
    // rust: settings: Settings,
    // rust: upgrade: Arc<horizon_world::datafix::progress::UpgradeProgress>,
    // rust: ) -> Result<Self> {
    // rust: let handle = std::thread::Builder::new()
    // rust: .name("World initialization".into())
    // rust: .spawn(move || {
    // rust: request
    // rust: .prepare(&res, &pack, &options, &settings, &upgrade)
    // rust: .map_err(|e| e.to_string())
    // rust: })?;
    // rust: Ok(Self { handle })
}

finish :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.handle
    // rust: .join()
    // rust: .map_err(|_| "world initialization worker panicked")?
    // rust: .map_err(Into::into)
}
}

// How long the preloaded world data outlives the world screens: a player
// who goes back to the title or to Multiplayer and opens no world for this
// long gets the memory back.
PRELOAD_KEPT :: std::time::Duration::from_secs(60)

Preload :: enum {
    Idle,
    // Read, or being read, on the "World data preload" thread. `left`: when
    // the player last left the world screens.
    Started {,
    thread: std::thread::JoinHandle<()>,
    left: Option<std::time::Instant>,
    // rust: },
    // A world opened: the data is the world's now, and stays.
    Used,
}

PRELOAD :: std::sync::Mutex::new(Preload::Idle)

// Each frame of the title: read what every world opening loads and keeps
// for the rest of the process (the worldgen bundle, the loot tables and the
// registries the server sends) on a helper thread while the player is on the
// world screens (`on_world_screens`: Singleplayer, Create World and their
// dialogs), so it overlaps the time spent choosing a world. A world opened
// meanwhile waits for the part being read instead of reading it again. Not
// at the title screen itself: many players only go to Multiplayer, and
// small machines need the memory. Dropped after `PRELOAD_KEPT` away from
// the world screens without a world opening.
    // rust: pub(super) fn preload_world_data(
    // rust: on_world_screens: bool,
    // rust: resources: &std::path::Path,
    // rust: registry: &'static horizon_world::registry::BlockRegistry,
    // rust: ) {
    // rust: let mut preload = PRELOAD.lock().unwrap_or_else(|e| e.into_inner());
    // rust: match &mut *preload {
    // rust: Preload::Used => {}
    // rust: Preload::Idle if on_world_screens => {
    // rust: let resources = resources.to_owned();
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("World data preload".into())
    // rust: .spawn(move || {
    // rust: horizon_threads::behind_server();
    // rust: let sync = spawn_sync_preload(&resources, true);
                    // Errors are left for the world opening to report.
    // rust: if let Ok(data) = horizon_client::vanillagen::shared_data(
    // rust: &resources.join("worldgen"),
    // rust: registry,
    // rust: ) {
                        // The Overworld's feature decoration, which every
                        // seed shares: about 140 ms off opening the world.
    // rust: let _ = data.prepare_decoration("minecraft:normal", "minecraft:overworld");
}
                    // The loot data's item tables and the server's data both
                    // read the recipe folder: held here, it is read once.
    // rust: let _recipe_files =
    // rust: horizon_client::json_folder::read(&resources.join("data/minecraft/recipe"));
                    // The preload is the game's own data; the world's packs'
                    // tables are built when it opens (finish_open_world).
    // rust: let _ = horizon_client::structure_blocks::loot_data(
    // rust: &resources,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: );
    // rust: join_sync_preload(sync, &resources);
    // rust: });
    // rust: match spawned {
    // rust: Ok(thread) => *preload = Preload::Started { thread, left: None },
    // rust: Err(e) => log::warn!("Horizon: world data preload: {e}"),
}
}
    // rust: Preload::Idle => {}
    // rust: Preload::Started { left, .. } if on_world_screens => *left = None,
    // rust: Preload::Started { thread, left } => {
    // rust: let left = *left.get_or_insert_with(std::time::Instant::now);
    // rust: if left.elapsed() >= PRELOAD_KEPT && thread.is_finished() {
    // rust: horizon_client::vanillagen::forget_shared_data();
    // rust: horizon_client::structure_blocks::forget_loot_data();
    // rust: super::lan::forget_sync_data();
    // rust: horizon_threads::release_free_memory();
    // rust: *preload = Preload::Idle;
    // rust: log::info!("Horizon: preloaded world data dropped, no world opened");
}
}
}
}

// A launch that names a world (`--world`, `--quickPlaySingleplayer`): the
// same preload, started as soon as the block registry and the biomes are
// loaded, so it overlaps the rest of the startup instead of the world's
// opening. Read for the world's own data packs and preset, the bundle and
// decoration `make_streaming` asks for; a world they don't fit (one its
// upgrade rewrites) reads its own when it opens.
    // rust: pub(super) fn preload_launch_world(
    // rust: folder: &str,
    // rust: resources: &std::path::Path,
    // rust: registry: &'static horizon_world::registry::BlockRegistry,
    // rust: biomes: Arc<horizon_client::biome::Biomes>,
    // rust: ) {
    // rust: let mut preload = PRELOAD.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if !matches!(*preload, Preload::Idle) {
    // rust: return;
}
    // rust: let Ok(dir) = std::env::current_dir() else {
    // rust: return;
}
    // rust: let world_root = dir.join("saves").join(folder);
    // rust: let resources = resources.to_owned();
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("World data preload".into())
    // rust: .spawn(move || {
            // Not behind the server: the world's opening waits for it.
    // rust: let started = std::time::Instant::now();
    // rust: let sync = spawn_sync_preload(&resources, false);
            // Errors are left for the world opening to report. The world's
            // flags from its level.dat: the feature packs a flag forces on.
    // rust: let enabled_features = horizon_client::save::Level::read(&world_root)
    // rust: .map(|l| l.enabled_features)
    // rust: .unwrap_or_default();
    // rust: let (overrides, _) =
    // rust: worldgen_overrides_of(&world_root, &resources, &biomes, &enabled_features);
    // rust: if let Ok(data) = horizon_client::vanillagen::shared_data_with(
    // rust: &resources.join("worldgen"),
    // rust: &overrides,
    // rust: registry,
    // rust: ) {
    // rust: let preset = horizon_client::save::WorldGen::preset(&world_root);
    // rust: let _ = data.prepare_decoration(preset, "minecraft:overworld");
}
            // As in `preload_world_data`: the loot data and the server's
            // data share one read of the recipe folder.
    // rust: let _recipe_files =
    // rust: horizon_client::json_folder::read(&resources.join("data/minecraft/recipe"));
    // rust: let _ = horizon_client::structure_blocks::loot_data(
    // rust: &resources,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: );
    // rust: join_sync_preload(sync, &resources);
    // rust: log::info!(
    // rust: "Horizon: world data preloaded for the launch's world in {} ms",
    // rust: started.elapsed().as_millis()
    // rust: );
    // rust: });
    // rust: match spawned {
    // rust: Ok(thread) => *preload = Preload::Started { thread, left: None },
    // rust: Err(e) => log::warn!("Horizon: world data preload: {e}"),
}
}

// The registries, tags, recipes and advancements the server sends
// (`lan::sync_data`), read on a thread of their own beside the worldgen and
// loot reads: they share nothing, and read after them they came too late
// for the server thread, which then read them a second time.
    // rust: fn spawn_sync_preload(
    // rust: resources: &std::path::Path,
    // rust: behind_server: bool,
    // rust: ) -> Option<std::thread::JoinHandle<()>> {
    // rust: let resources = resources.to_owned();
    // rust: std::thread::Builder::new()
    // rust: .name("Sync data preload".into())
    // rust: .spawn(move || {
    // rust: if behind_server {
    // rust: horizon_threads::behind_server();
}
    // rust: let _ = super::lan::sync_data(&resources, &horizon_world::loot::PackOverlay::NONE);
    // rust: })
    // rust: .ok()
}

// Waits for [`spawn_sync_preload`]'s thread, so the preload is over when
// its own thread is; reads the data here if that thread did not start.
join_sync_preload :: proc(sync: Option<std::thread::JoinHandle<() {
}
    // rust: match sync {
    // rust: Some(thread) => {
    // rust: let _ = thread.join();
}
    // rust: None => {
    // rust: let _ = super::lan::sync_data(resources, &horizon_world::loot::PackOverlay::NONE);
}
}
}

// A world opens: what `preload_world_data` read is the world's from now on.
    // rust: pub(super) fn world_data_used() {
    // rust: *PRELOAD.lock().unwrap_or_else(|e| e.into_inner()) = Preload::Used;
}

// A server's world opens: the loot tables its first placed block or broken
// container needs (`loot_data`) are read on a helper thread while the
// connection is made, so the game thread never waits on them (~0.6 s on a
// phone). Kept from then on, as a local world keeps them.
    // rust: pub(super) fn preload_server_loot(resources: &std::path::Path) {
    // rust: world_data_used();
    // rust: if horizon_client::structure_blocks::loaded_loot_data().is_some() {
    // rust: return;
}
    // rust: let resources = resources.to_owned();
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Loot preload".into())
    // rust: .spawn(move || {
    // rust: horizon_threads::behind_server();
    // rust: let _ = horizon_client::structure_blocks::loot_data(
    // rust: &resources,
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: );
    // rust: });
    // rust: if let Err(e) = spawned {
    // rust: log::warn!("Horizon: loot preload: {e}");
}
}

// The game's biomes with the world's enabled packs over them, from the same
// pack list its worldgen is built from (`WorldgenOverrides` keeps only the
// biomes this table knows).
    // rust: pub(super) fn packed_biomes(
    // rust: world_root: &std::path::Path,
    // rust: resources: &std::path::Path,
    // rust: base: &Arc<horizon_client::biome::Biomes>,
    // rust: enabled_features: &[String],
    // rust: ) -> Arc<horizon_client::biome::Biomes> {
    // rust: let packs = horizon_client::datapack::discover_with_features(world_root, resources);
    // rust: let enabled = horizon_client::datapack::enabled_ids(world_root, &packs, enabled_features);
    // rust: let enabled: Vec<_> = enabled
    // rust: .iter()
    // rust: .filter_map(|id| packs.iter().find(|p| &p.id == id))
    // rust: .collect();
    // rust: let (overrides, _) = horizon_client::datapack::worldgen_overrides(&enabled, |_| true);
    // rust: let packed: Vec<(String, serde_json::Value)> = overrides
    // rust: .entries("biomes")
    // rust: .filter_map(|(id, json)| Some((id.to_owned(), serde_json::from_str(json).ok()?)))
    // rust: .collect();
    // rust: if packed.is_empty() {
    // rust: return base.clone();
}
    // rust: Arc::new(base.with_packs(packed.iter().map(|(i, v)| (i.as_str(), v))))
}
// The Create screen's chosen packs' worldgen entries over the game's own
// (`applyNewPackConfig` reloads the world with the new pack config): the
// packs the temp folder and the resources root hold, the selection the
// Create screen made.
    // rust: pub(super) fn creation_worldgen_overrides(
    // rust: pack_dir: Option<&std::path::Path>,
    // rust: resources: &std::path::Path,
    // rust: data_packs: &[String],
    // rust: biomes: &horizon_client::biome::Biomes,
    // rust: ) -> horizon_world::worldgen::overrides::WorldgenOverrides {
    // rust: let empty = std::path::PathBuf::new();
    // rust: let packs =
    // rust: horizon_client::datapack::discover_with_features(pack_dir.unwrap_or(&empty), resources);
    // rust: let enabled: Vec<_> = data_packs
    // rust: .iter()
    // rust: .filter_map(|id| packs.iter().find(|p| &p.id == id))
    // rust: .collect();
    // rust: let (overrides, _) =
    // rust: horizon_client::datapack::worldgen_overrides(&enabled, |b| biomes.contains(b));
    // rust: overrides
}
// The worldgen entries of the world's enabled data packs, logging what
// the generator leaves out of them.
    // rust: fn world_worldgen_overrides(
    // rust: world_root: &std::path::Path,
    // rust: resources: &std::path::Path,
    // rust: biomes: &horizon_client::biome::Biomes,
    // rust: enabled_features: &[String],
    // rust: ) -> horizon_world::worldgen::overrides::WorldgenOverrides {
    // rust: let (overrides, warnings) =
    // rust: worldgen_overrides_of(world_root, resources, biomes, enabled_features);
    // rust: for warning in warnings {
    // rust: log::warn!("Horizon: data pack worldgen: {warning}");
}
    // rust: overrides
}

// The worldgen entries of the world's enabled data packs, and what the
// generator leaves out of them.
    // rust: fn worldgen_overrides_of(
    // rust: world_root: &std::path::Path,
    // rust: resources: &std::path::Path,
    // rust: biomes: &horizon_client::biome::Biomes,
    // rust: enabled_features: &[String],
    // rust: ) -> (
    // rust: horizon_world::worldgen::overrides::WorldgenOverrides,
    // rust: Vec<String>,
    // rust: ) {
    // rust: let packs = horizon_client::datapack::discover_with_features(world_root, resources);
    // rust: let enabled = horizon_client::datapack::enabled_ids(world_root, &packs, enabled_features);
    // rust: let enabled: Vec<_> = enabled
    // rust: .iter()
    // rust: .filter_map(|id| packs.iter().find(|p| &p.id == id))
    // rust: .collect();
    // rust: horizon_client::datapack::worldgen_overrides(&enabled, |b| biomes.contains(b))
}

// The shapes of the world's levels: their dimension types, the world's
// enabled data packs' over vanilla's. A type the codec refuses keeps the
// vanilla shape, with a warning.
    // rust: pub(super) fn level_shapes(
    // rust: world_root: &std::path::Path,
    // rust: biomes: &horizon_client::biome::Biomes,
    // rust: ) -> horizon_client::chunk::LevelShapes {
//     use horizon_client::chunk::{LevelShape, LevelShapes};
    // rust: let packs = horizon_client::datapack::discover(world_root);
    // rust: let enabled_features = horizon_client::save::Level::read(world_root)
    // rust: .map(|l| l.enabled_features)
    // rust: .unwrap_or_default();
    // rust: let enabled = horizon_client::datapack::enabled_ids(world_root, &packs, &enabled_features);
    // rust: let enabled: Vec<_> = enabled
    // rust: .iter()
    // rust: .filter_map(|id| packs.iter().find(|p| &p.id == id))
    // rust: .collect();
    // rust: let mut shapes = LevelShapes::VANILLA;
    // rust: if enabled.is_empty() {
    // rust: return shapes;
}
    // What the packs leave out is logged when the generator reads them.
    // rust: let (overrides, _) =
    // rust: horizon_client::datapack::worldgen_overrides(&enabled, |b| biomes.contains(b));
    // rust: for level in [
    // rust: "minecraft:overworld",
    // rust: "minecraft:the_nether",
    // rust: "minecraft:the_end",
    // rust: ] {
    // rust: let shape = overrides.level_height(level).and_then(|h| {
    // rust: LevelShape::new(
    // rust: h.min_y,
    // rust: h.height,
    // rust: h.logical_height,
    // rust: h.has_skylight,
    // rust: h.has_ceiling,
    // rust: )
    // rust: .ok()
    // rust: });
    // rust: match shape {
    // rust: Some(shape) => *shapes.get_mut(level) = shape,
    // rust: None => log::warn!(
    // rust: "Horizon: data pack worldgen: the dimension type of {level} is not one the \
    // rust: game accepts; the level keeps the vanilla build height"
    // rust: ),
}
}
    // rust: shapes
}

    // rust: pub(super) fn make_streaming(
    // rust: res: &Resources,
    // rust: pack: &PackResources,
    // rust: options: &Options,
    // rust: settings: &Settings,
    // rust: world_root: &std::path::Path,
    // rust: dim: Dim,
    // rust: shape: horizon_client::chunk::LevelShape,
    // rust: seed: i64,
    // rust: enabled_features: &[String],
    // rust: ) -> Result<(Streaming, Arc<SaveDir>, Option<Arc<VanillaTerrain>>)> {
    // rust: let save = Arc::new(SaveDir::new(
    // rust: horizon_client::save::dimension_dir(world_root, dim.id()),
    // rust: shape,
    // rust: ));
    // rust: if dim == Dim::End {
        // Migrate before any chunk reader can cache the old block entities. A side file it
        // can't read stays where it is and costs only its old exits: the End still opens.
    // rust: if let Err(e) = save.migrate_end_gateway_exits() {
    // rust: log::warn!("Horizon: End gateway exits not migrated: {e}");
}
}
    // The world's packs over the game's biomes (`RegistryDataLoader`
    // layering): the generator names the ids and the client draws them.
    // rust: let biomes = packed_biomes(
    // rust: world_root,
    // rust: &options.resources,
    // rust: res.biomes(),
    // rust: enabled_features,
    // rust: );
    // rust: let mut locator = None;
    // rust: let flat = (dim == Dim::Overworld)
    // rust: .then(|| horizon_client::save::world_gen_settings(world_root))
    // rust: .flatten()
    // rust: .and_then(|s| {
    // rust: horizon_client::flatgen::FlatTerrain::from_settings(
    // rust: &s,
    // rust: pack.assets.registry,
    // rust: res.biomes(),
    // rust: shape,
    // rust: )
    // rust: });
    // `DebugLevelSource`: the overworld of the Debug preset.
    // rust: let debug = (dim == Dim::Overworld)
    // rust: .then(|| horizon_client::save::world_gen_settings(world_root))
    // rust: .flatten()
    // rust: .and_then(|s| {
    // rust: horizon_client::debugworld::DebugTerrain::from_settings(
    // rust: &s,
    // rust: pack.assets.registry,
    // rust: res.biomes(),
    // rust: shape,
    // rust: )
    // rust: });
    // PlaceCommand.placeJigsaw/placeStructure generate directly, independently
    // of WorldOptions.generateStructures. Keep their flat locator available
    // even when automatic structure starts are disabled.
    // rust: let automatic_structures =
    // rust: horizon_client::save::WorldGen::read(world_root).is_none_or(|w| w.structures);
    // rust: let flat_settings = (dim == Dim::Overworld)
    // rust: .then(|| horizon_client::save::world_gen_settings(world_root))
    // rust: .flatten()
    // rust: .and_then(|s| horizon_client::flatgen::FlatTerrain::pipeline_settings(&s));
    // `adjustGenerationSettings`: a superflat world with features or lakes is decorated
    // whether or not its structures generate.
    // rust: let flat_decorates = flat_settings
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.features || s.lakes);
    // A generator that cannot be built (a layer block the registry lacks, a level shorter
    // than the noise) leaves the world on its flat ground, as it was before.
    // rust: let flat_vanilla = flat_settings.and_then(|settings| {
    // rust: let overrides =
    // rust: world_worldgen_overrides(world_root, &options.resources, &biomes, enabled_features);
    // rust: match VanillaTerrain::for_flat(
    // rust: &options.resources.join("worldgen"),
    // rust: &overrides,
    // rust: pack.assets.registry,
    // rust: &biomes,
    // rust: seed,
    // rust: &settings,
    // rust: automatic_structures,
    // rust: ) {
    // rust: Ok(mut terrain) => {
    // rust: terrain.add_mod_signs(res.facts());
    // rust: Some(Arc::new(terrain))
}
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: the superflat structures and features are unavailable: {e}");
    // rust: None
}
}
    // rust: });
    // rust: let mut streaming = if let Some(inner) = debug {
    // rust: Streaming::new(
    // rust: Arc::new(Persistent {
    // rust: inner: Arc::new(inner),
    // rust: save: save.clone(),
    // rust: registry: pack.assets.clone(),
    // rust: biomes: biomes.clone(),
    // rust: }),
    // rust: pack.context_with(biomes.clone()),
    // rust: res.threads(),
    // rust: )
    // rust: } else if let Some(inner) = flat_vanilla
    // rust: .as_ref()
    // rust: .filter(|_| automatic_structures || flat_decorates)
    // rust: .cloned()
    // rust: {
    // rust: if automatic_structures {
    // rust: inner.search_rings_behind();
}
    // rust: inner.set_reference_file(world_root.join("data").join(format!(
    // rust: "horizon_structure_references_{}.json",
    // rust: dim.id().replace(':', "_")
    // rust: )));
    // rust: {
    // rust: let save = save.clone();
    // rust: inner.set_saved_references(Arc::new(move |name, x, z| {
    // rust: save.start_references(x, z, name)
    // rust: }));
}
    // rust: locator = Some(inner.clone());
    // rust: Streaming::new(
    // rust: Arc::new(Persistent {
    // rust: inner,
    // rust: save: save.clone(),
    // rust: registry: pack.assets.clone(),
    // rust: biomes: biomes.clone(),
    // rust: }),
    // rust: pack.context_with(biomes.clone()),
    // rust: res.threads(),
    // rust: )
    // rust: } else if let Some(inner) = flat {
        // A superflat world that neither decorates nor generates structures: its
        // layers alone. Only manual commands use the locator.
    // rust: locator = flat_vanilla;
    // rust: Streaming::new(
    // rust: Arc::new(Persistent {
    // rust: inner: Arc::new(inner),
    // rust: save: save.clone(),
    // rust: registry: pack.assets.clone(),
    // rust: biomes: biomes.clone(),
    // rust: }),
    // rust: pack.context_with(biomes.clone()),
    // rust: res.threads(),
    // rust: )
    // rust: } else if options.test_terrain && dim == Dim::Overworld {
    // rust: let inner = Arc::new(TestTerrain::new(pack.assets.registry, res.biomes())?);
    // rust: Streaming::new(
    // rust: Arc::new(Persistent {
    // rust: inner,
    // rust: save: save.clone(),
    // rust: registry: pack.assets.clone(),
    // rust: biomes: biomes.clone(),
    // rust: }),
    // rust: pack.context_with(biomes.clone()),
    // rust: res.threads(),
    // rust: )
    // rust: } else {
        // WorldOptions.generateStructures, from the world's settings.
    // rust: let structures =
    // rust: horizon_client::save::WorldGen::read(world_root).is_none_or(|w| w.structures);
    // rust: let preset = horizon_client::save::WorldGen::preset(world_root);
    // rust: let overrides =
    // rust: world_worldgen_overrides(world_root, &options.resources, &biomes, enabled_features);
    // rust: let saved_stem = horizon_client::save::world_gen_settings(world_root)
    // rust: .and_then(|s| s.get("dimensions")?.get(dim.id()).cloned())
    // rust: .map(|stem| horizon_client::scoreboard::tag_to_json(&stem));
    // rust: let mut inner = VanillaTerrain::for_world_with_settings(&options.resources.join("worldgen"), &overrides, pack.assets.registry, &biomes, seed, preset, dim.id(), structures, saved_stem.as_ref()).map_err(|e| {
    // rust: if overrides.is_empty() {
    // rust: format!("{e}\nPrepare the worldgen bundle with the launcher, or: horizon-prepare --prepare")
    // rust: } else {
    // rust: format!("{e}\nThe world's data packs change its world generation: one of them may not be made for this version")
}
    // rust: })?;
    // rust: inner.add_mod_signs(res.facts());
    // rust: let inner = Arc::new(inner);
    // rust: if dim == Dim::Overworld && structures {
    // rust: inner.search_rings_behind();
}
        // Chunks an older version saved: the new chunks around them blend in.
    // rust: if dim == Dim::Overworld {
    // rust: inner.set_old_world(Arc::new(horizon_client::old_world::SavedOldWorld::new(
    // rust: save.clone(),
    // rust: pack.assets.clone(),
    // rust: res.biomes().clone(),
    // rust: inner.generator_data().clone(),
    // rust: )));
}
    // rust: inner.set_reference_file(world_root.join("data").join(format!(
    // rust: "horizon_structure_references_{}.json",
    // rust: dim.id().replace(':', "_")
    // rust: )));
    // rust: {
    // rust: let save = save.clone();
    // rust: inner.set_saved_references(Arc::new(move |name, x, z| {
    // rust: save.start_references(x, z, name)
    // rust: }));
}
    // rust: locator = Some(inner.clone());
    // rust: Streaming::new(
    // rust: Arc::new(Persistent {
    // rust: inner,
    // rust: save: save.clone(),
    // rust: registry: pack.assets.clone(),
    // rust: biomes: biomes.clone(),
    // rust: }),
    // rust: pack.context_with(biomes.clone()),
    // rust: res.threads(),
    // rust: )
}
    // rust: streaming.forced = save.load_forced_chunks();
    // rust: streaming.radius = settings.render_distance;
    // rust: streaming.biome_blend = settings.biome_blend;
    // rust: streaming.smooth_lighting = settings.smooth_lighting;
    // rust: streaming.cutout_leaves = settings.cutout_leaves;
    // rust: streaming.leaf_culling = settings
    // rust: .horizon
    // rust: .leaf_culling_effective(&settings.resource_packs);
    // rust: streaming.biome_zoom = BiomeZoom::new(obfuscate_seed(seed));
    // rust: streaming.sky_light = dim != Dim::Nether;
    // rust: streaming.nether_shading = dim == Dim::Nether;
    // A server draws nothing: neither the integrated server nor the
    // dedicated one meshes sections.
    // rust: streaming.mesh = options.execution_role.is_client();
    // rust: Ok((streaming, save, locator))
}

    // rust: mod tests {
//     use super::*;

worker_panics_reach_the_client :: proc() {
}
    // rust: let loader = WorldLoader {
    // rust: handle: std::thread::spawn(|| panic!("broken world initialization")),
}
    // rust: assert_eq!(
    // rust: loader.finish().err().unwrap().to_string(),
    // rust: "world initialization worker panicked"
    // rust: );
}

prepared_world_can_cross_threads :: proc() {
}
    // rust: fn send<T: Send>() {}
    // rust: send::<PreparedWorld>();
}
}
