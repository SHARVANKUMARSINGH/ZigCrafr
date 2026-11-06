//! Transpiled from Horizon Rust crate
package horizon_client_shader_packs

import "core:fmt"
import "core:mem"
import "core:math"

// Shader packs: the one picked on Options > Horizon Settings > Shader Packs, or
// `HORIZON_SHADER_PACK=<name>` (development; it wins over the pick), runs `shaderpacks/<name>`
// (a folder or a zip beside `options.txt`) over the world; Horizon's own packs go to
// `game/native_shaders.rs`. The programs of the current dimension's folder are loaded when the
// dimension changes (spec 1.2).

// use horizon_client::camera::CameraFluid;
// use horizon_client::gfx::pack_uniforms::{PackInputs, PlayerStatus};
// use horizon_client::shader_options::ShaderOptions;
// use horizon_client::text::Text;
// use horizon_shaders::{BlockIds, Macros, Pack, Properties, dimension_folder_named, load_post};

// use super::{Dim, Game};
// use horizon_client::gfx::pack_draw::EntitySpan;
// use std::cell::RefCell;
// use std::collections::{BTreeMap, HashMap};

// The values the player chose for pack `name`'s options (`shaderpacks/<name>.txt`).
chosen_shader_options :: proc(name: string) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let file = Game::shader_packs_dir().join(horizon_shaders::chosen_file(name));
    // rust: std::fs::read_to_string(file)
    // rust: .map(|text| horizon_shaders::parse_chosen(&text))
    // rust: .unwrap_or_default()
}

// Pack `name`'s options, screens and names in `language`, with the values the player chose.
    // rust: pub(super) fn read_shader_options(
    // rust: name: &str,
    // rust: language: &str,
    // rust: macros: &Macros,
    // rust: ) -> Option<ShaderOptions> {
    // rust: let pack = match Pack::open(&Game::shader_packs_dir().join(name)) {
    // rust: Ok(pack) => pack,
    // rust: Err(e) => {
    // rust: log::warn!("shader pack {name}: {e}");
    // rust: return None;
}
}
    // rust: let options = horizon_shaders::options(&pack);
    // rust: let lang = horizon_shaders::Lang::load(&pack, language);
    // rust: let chosen = chosen_shader_options(name);
    // rust: let pack = pack.with_chosen(chosen.clone());
    // rust: let text = pack.read_text("shaders.properties").unwrap_or_default();
    // rust: let properties = Properties::parse(&text, &horizon_shaders::properties_macros(&pack, macros));
    // rust: let screens = horizon_shaders::Screens::parse(&properties, &options);
    // rust: Some(ShaderOptions::new(
    // rust: name.to_owned(),
    // rust: options,
    // rust: screens,
    // rust: lang,
    // rust: chosen,
    // rust: ))
}

// Saves the values chosen on the Shader Options page; none chosen removes the file.
    // rust: pub(super) fn write_shader_options(options: &ShaderOptions) {
    // rust: let file = Game::shader_packs_dir().join(horizon_shaders::chosen_file(&options.pack));
    // rust: let saved = if options.chosen.is_empty() {
    // rust: std::fs::remove_file(&file).or_else(|e| match e.kind() {
    // rust: std::io::ErrorKind::NotFound => Ok(()),
    // rust: _ => Err(e),
    // rust: })
    // rust: } else {
    // rust: std::fs::write(&file, horizon_shaders::chosen_text(&options.chosen))
}
    // rust: if let Err(e) = saved {
    // rust: log::warn!("shader pack {}: {}: {e}", options.pack, file.display());
}
}

// The pack that runs over the world ("": none): `HORIZON_SHADER_PACK`, else the pick
// (`active_pack`).
picked_pack :: proc(settings: ^horizon_client::settings::Settings) -> ^ {
    // Ported from Horizon
    return {}
}
DEV_PACK :: std::sync::OnceLock::new()
    // rust: let dev = DEV_PACK.get_or_init(|| std::env::var("HORIZON_SHADER_PACK").ok());
    // rust: active_pack(
    // rust: dev.as_deref().unwrap_or(&settings.horizon.shader_pack),
    // rust: &settings.mods,
    // rust: )
}

// Whether the pack picked (`picked_pack`) draws flat where the device can (`pack_draws_flat`):
// a renderer made now lays the sections out for it before the first world frame loads it
// (`Renderer::new`).
    // rust: pub(super) fn picked_pack_draws_flat(settings: &horizon_client::settings::Settings) -> bool {
    // rust: let picked = picked_pack(settings);
    // rust: !picked.is_empty() && pack_draws_flat(&Game::shader_packs_dir().join(picked))
}

// Whether the pack at `path` has passes that draw the terrain flat where the device can,
// reading translucent quads beside their section's solid ones: a `shaders/` pack, taken to
// draw terrain, or one of Horizon's own with a `[shadow]` pass.
pack_draws_flat :: proc(path: ^std::path::Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !horizon_shader_api::package::is_pack(path)
    // rust: || horizon_shader_api::Pack::read(path).is_ok_and(|p| p.manifest.shadow.is_some())
}

// A native mod can bundle a pack as `native-<mod-id>`; its Mods toggle controls it too.
    // rust: fn active_pack<'a>(picked: &'a str, mods: &horizon_client::mod_list::ModList) -> &'a str {
    // rust: if picked.strip_prefix("native-").is_some_and(|id| {
    // rust: mods.installed
    // rust: .iter()
    // rust: .any(|m| m.id == id && m.native.is_some() && mods.disabled.contains(id))
    // rust: }) {
    // rust: ""
    // rust: } else {
    // rust: picked
}
}

// A selected pack may read resource-pack material maps, whether native or GLSL.
    // rust: pub(super) fn picks_material_pack(settings: &horizon_client::settings::Settings) -> bool {
    // rust: let dev = std::env::var("HORIZON_SHADER_PACK").ok();
    // rust: let picked = active_pack(
    // rust: dev.as_deref().unwrap_or(&settings.horizon.shader_pack),
    // rust: &settings.mods,
    // rust: );
    // rust: !picked.is_empty()
}

// The ids a pack gives entities and block entities (4.1, 5.3), for the spans of the entity
// geometry.
    // rust: pub(super) struct PackIds {
    // rust: entities: HashMap<String, i32>,
    // rust: blocks: BlockIds,
    // `blockEntityId` by block state, filled as states are drawn.
    // rust: block_states: RefCell<HashMap<u32, i32>>,
    // The id of a name the file lacks: 65535, or 0 without the file.
    // rust: missing_entity: i32,
    // rust: missing_block: i32,
    // `item.properties` (4.1) and the id of a held item the file lacks, or of an empty hand:
    // −1, or 0 without the file (5.3).
    // rust: items: HashMap<String, i32>,
    // rust: missing_item: i32,
    // `currentRenderedItemId` of each block item (`StateFacts::item` of its block's default
    // state): that state's `block.properties` id, or 0.
    // rust: block_items: HashMap<String, i32>,
    // Whether the pack has `item.properties` (`currentRenderedItemId` of an item it lacks).
    // rust: item_file: bool,
    // `oldHandLight` (3.2): the first held item and light are those of the brighter hand.
    // rust: old_hand_light: bool,
    // `vignette`: `false` hides the game's vignette over the pack's image.
    // rust: vignette: bool,
    // `oldLighting`: `true` keeps the game's face shading in the block colours.
    // rust: old_lighting: bool,
    // `separateAo`: `true` passes AO factor in vertex alpha and keeps pure tint in RGB.
    // rust: pub(super) separate_ao: bool,
}

    // rust: impl Game<'_> {
    // Loads the pack for the current dimension when it changed, and returns this frame's
    // inputs to the pack's uniforms.
    // rust: pub(super) fn shader_pack_inputs(
    // rust: &mut self,
    // rust: camera: glam::DVec3,
    // rust: partial: f32,
    // rust: sky: &horizon_client::environment::Sky,
    // rust: ) -> PackInputs {
        // A `shaders/` pack lights the faces itself unless `oldLighting=true`: sections mesh
        // without the game's face shading (the pack loaded or dropped below shows next frame).
    // rust: let pack_lighting = self.pack_ids.as_ref().is_some_and(|ids| !ids.old_lighting);
    // rust: if self.streaming.shader_pack_lighting != pack_lighting {
    // rust: self.streaming.shader_pack_lighting = pack_lighting;
    // rust: self.all_sections_changed();
}
        // Any `shaders/` pack (its `oldLighting` too) draws fluid tops split as Iris does.
    // rust: let shader_pack = self.pack_ids.is_some();
    // rust: if self.streaming.shader_pack != shader_pack {
    // rust: self.streaming.shader_pack = shader_pack;
    // rust: self.all_sections_changed();
}
    // rust: let separate_ao = self.pack_ids.as_ref().is_some_and(|ids| ids.separate_ao);
    // rust: if self.streaming.separate_ao != separate_ao {
    // rust: self.streaming.separate_ao = separate_ao;
    // rust: self.all_sections_changed();
}
    // rust: let picked = picked_pack(&self.settings).to_owned();
    // rust: if self.native_shaders.picked != picked {
            // Another pack, or none: drop what ran.
    // rust: self.native_shaders = super::native_shaders::NativeShaders::picking(&picked);
    // rust: self.set_translucent_layers(Vec::new());
    // rust: self.pack_ids = None;
    // rust: if let Some(renderer) = &mut self.renderer {
    // rust: renderer.drop_shader_packs();
}
}
    // rust: if picked.is_empty() {
    // rust: return PackInputs::default();
}
    // rust: if !horizon_client::sprites::labpbr_maps() {
    // rust: horizon_client::sprites::set_labpbr_maps(true);
    // rust: self.reload_packs();
    // rust: return PackInputs::default();
}
    // rust: let name = picked;
    // rust: let dimension = match self.dim {
    // rust: Dim::Overworld => 0,
    // rust: Dim::Nether => -1,
    // rust: Dim::End => 1,
}
    // rust: let path = Self::shader_packs_dir().join(&name);
    // rust: if horizon_shader_api::package::is_pack(&path) {
            // One of Horizon's own packs (game/native_shaders.rs).
    // rust: self.tick_native_shader_pack(&path);
    // rust: } else if let Some(renderer) = &mut self.renderer
    // rust: && renderer.shader_pack_dimension() != Some(dimension)
    // rust: {
    // rust: let name = name.as_str();
    // rust: let started = std::time::Instant::now();
            // A pack is not the game's own code: one that makes the shader compiler (or our
            // translation of it) panic is turned off instead of crashing every world load (#3525).
    // rust: let loaded = horizon_client::crash::contain(|| {
    // rust: match Pack::open(&path).map(|p| p.with_chosen(chosen_shader_options(name))) {
    // rust: Ok(pack) => {
    // rust: let mut macros = Macros::standard();
    // rust: renderer.define_pack_macros(&mut macros);
                        // Its conditionals test the pack's options too.
    // rust: let (properties, notes) =
    // rust: horizon_shaders::read_properties(&pack, &mut macros);
    // rust: for note in notes {
    // rust: log::warn!("shader pack {name}: {note}");
}
    // rust: for note in &properties.notes {
    // rust: log::warn!(
    // rust: "shader pack {name}: shaders.properties:{}: {}",
    // rust: note.line,
    // rust: note.message
    // rust: );
}
    // rust: let separate_ao = properties
    // rust: .get("separateAo")
    // rust: .is_some_and(|v| v.trim() == "true");
    // rust: renderer.set_separate_ao(separate_ao);
                        // Lava's faces draw with the solid terrain's program.
    // rust: renderer.set_pack_lava_layers(
    // rust: ["lava_still", "lava_flow"]
    // rust: .iter()
    // rust: .filter_map(|f| {
    // rust: let name = format!("minecraft:block/{f}");
    // rust: self.pack.render.sprite_layers.get(&name).map(|&l| l as u16)
    // rust: })
    // rust: .collect(),
    // rust: );
    // rust: let folder = dimension_folder_named(&pack, self.dim.id(), dimension);
    // rust: let inputs = renderer.pack_inputs();
    // rust: let mut post = load_post(&pack, &folder, &properties, &macros, &inputs);
                        // Textures that name one of the game's: from the resource packs over
                        // the game's own resources.
    // rust: let resources = self.options.resources.clone();
    // rust: let read = |namespace: &str, path: &str| {
    // rust: std::fs::read(resources.join("assets").join(namespace).join(path)).ok()
}
    // rust: for note in horizon_shaders::resolve_resources(&mut post.textures, &read) {
    // rust: log::warn!("shader pack {name}: {note}");
}
    // rust: let biomes = world_biomes!(self);
    // rust: let names: Vec<&str> =
    // rust: biomes.list.iter().map(|b| b.name.as_str()).collect();
    // rust: post.custom.set_biomes(&names);
    // rust: let text = pack.read_text("block.properties").unwrap_or_default();
    // rust: let ids = BlockIds::parse(&Properties::parse(&text, &macros));
    // rust: for note in &ids.notes {
    // rust: log::warn!("shader pack {name}: block.properties: {note}");
}
    // rust: let text = pack.read_text("entity.properties");
    // rust: let entities = BlockIds::parse_kind(
    // rust: &Properties::parse(text.as_deref().unwrap_or_default(), &macros),
    // rust: "entity",
    // rust: );
    // rust: let text = pack.read_text("item.properties");
    // rust: let items = BlockIds::parse_kind(
    // rust: &Properties::parse(text.as_deref().unwrap_or_default(), &macros),
    // rust: "item",
    // rust: );
    // rust: let block_items =
    // rust: block_item_ids(self.res.facts(), self.pack.assets.registry, &ids);
    // rust: self.pack_ids = Some(PackIds {
    // rust: block_items,
    // rust: item_file: text.is_some(),
    // rust: items: items.plain(),
    // rust: missing_item: if text.is_some() { -1 } else { 0 },
                            // OQ-21: on unless the pack turns it off.
    // rust: old_hand_light: properties
    // rust: .get("oldHandLight")
    // rust: .is_none_or(|v| v.trim() != "false"),
                            // On unless the pack turns it off (`vignette=false`).
    // rust: vignette: properties
    // rust: .get("vignette")
    // rust: .is_none_or(|v| v.trim() != "false"),
                            // Off unless the pack turns it on (Iris shades no faces by default).
    // rust: old_lighting: properties
    // rust: .get("oldLighting")
    // rust: .is_some_and(|v| v.trim() == "true"),
    // rust: separate_ao,
    // rust: entities: entities.plain(),
    // rust: missing_entity: if text.is_some() { 65535 } else { 0 },
    // rust: missing_block: if ids.is_empty() { 0 } else { 65535 },
    // rust: blocks: ids.clone(),
    // rust: block_states: RefCell::default(),
    // rust: });
    // rust: let started_ids = std::time::Instant::now();
    // rust: let table = terrain_table(
    // rust: &block_id_table(&self.pack, &ids),
    // rust: &block_emission_table(&self.pack),
    // rust: );
    // rust: log::info!(
    // rust: "shader pack {name}: mc_Entity for {} of {} block sprites in {} ms",
    // rust: table.chunks(3).filter(|p| p[0] != -1).count(),
    // rust: table.len() / 3,
    // rust: started_ids.elapsed().as_millis()
    // rust: );
    // rust: let report = renderer
    // rust: .set_shader_pack(dimension, Some(post), &table)
    // rust: .map_err(|refused| {
    // rust: for note in refused.notes {
    // rust: log::warn!("shader pack {name}: {note}");
}
    // rust: refused.reason
    // rust: })?;
    // rust: if let Some((programs, notes)) = report {
    // rust: for note in notes {
    // rust: log::warn!("shader pack {name}: {note}");
}
    // rust: log::info!(
    // rust: "shader pack {name}: folder `{folder}`, {} programs ({}) in {} ms",
    // rust: programs.len(),
    // rust: programs.join(" "),
    // rust: started.elapsed().as_millis()
    // rust: );
}
}
    // rust: Err(e) => {
    // rust: self.pack_ids = None;
    // rust: log::warn!("shader pack {name}: {e}");
                        // Without a pack this can't fail.
    // rust: let _ = renderer.set_shader_pack(dimension, None, &[]);
}
}
    // rust: Ok(())
    // rust: });
            // A pack that can't run is turned off like one that panics.
    // rust: if let Err(error) = loaded.flatten() {
    // rust: self.shader_pack_failed(name, dimension, &error);
}
}
    // rust: let lerp = |(old, new): (f32, f32)| old + (new - old) * partial;
    // rust: let at = camera.floor().as_ivec3();
    // rust: let light = self.world.light(at.x, at.y, at.z);
    // rust: let biome = self
    // rust: .world
    // rust: .chunks
    // rust: .get(&(at.x >> 4, at.z >> 4))
    // rust: .map(|c| c.biome(at.x, at.y, at.z));
    // rust: let (held_items, held_light) = self.held_for_pack();
    // rust: let status = self.pack_player_status();
    // rust: let (end_flash, end_flash_direction) = self.end_flash_for_pack(partial);
    // rust: let info = biome.map(|b| world_biomes!(self).get(b));
    // rust: let dimension = self.remote.as_ref().map(|r| &r.dimension);
    // rust: PackInputs {
            // `Level.getDefaultClockTime`: 0 in a dimension type with no default clock (the
            // Nether's has none), as Iris 1.11.7 reads `worldTime` there (probe pack).
    // rust: day_time: if dimension.is_some_and(|d| d.default_clock.is_none()) {
    // rust: 0
    // rust: } else {
    // rust: self.world.day_time
    // rust: },
    // rust: rain: lerp(self.world.weather.rain_level),
    // rust: thunder: lerp(self.world.weather.thunder_level),
    // rust: eye_in: match self.camera_fluid(camera.to_array()) {
    // rust: CameraFluid::None => 0,
    // rust: CameraFluid::Water => 1,
    // rust: CameraFluid::Lava => 2,
    // rust: CameraFluid::PowderSnow => 3,
    // rust: },
    // rust: blindness: f32::from(u8::from(self.potions.effects.get("blindness").is_some())),
    // rust: eye_light: [i32::from(light & 15), i32::from(light >> 4)],
    // rust: hide_gui: self.ui.hide_gui,
    // rust: brightness: self.settings.gamma,
    // rust: biome: info.map_or(-1, |b| {
    // rust: let names = world_biomes!(self).list.iter().map(|b| b.name.as_str());
    // rust: horizon_shaders::biome_pack_id(&b.name, names)
    // rust: }),
    // rust: biome_known: biome.is_some(),
    // rust: biome_category: info.map_or(0, |b| horizon_shaders::biome_category(&b.name)),
    // rust: biome_precipitation: info.map_or(0, |b| {
    // rust: horizon_shaders::biome_precipitation(b.precipitation, b.temperature)
    // rust: }),
    // rust: temperature: info.map_or(0.0, |b| b.temperature),
    // rust: rainfall: info.map_or(0.0, |b| b.downfall),
    // rust: held_items,
    // rust: held_light,
    // rust: right_handed: !self.settings.main_hand_left,
    // rust: on_ground: self.player.as_ref().is_some_and(|p| p.ground.on_ground),
    // rust: min_y: self.world.shape.min_y,
    // rust: height: self.world.shape.height,
    // rust: logical_height: self.world.shape.logical_height,
    // rust: has_skylight: self.world.shape.sky_light,
    // rust: has_ceiling: self.world.shape.has_ceiling,
    // rust: elytra_flying: self.player.as_ref().is_some_and(|p| p.fall_flying),
    // rust: cloud_height: horizon_client::gfx::pack_uniforms::cloud_height(sky),
            // Vanilla's drift in float, times its 0.030000001F blocks a tick.
    // rust: cloud_time: horizon_client::clouds::drift(
    // rust: self.world.game_time,
    // rust: f64::from(partial),
    // rust: self.pack.clouds.0,
    // rust: ) as f32
    // rust: * 0.030_000_001,
    // rust: mod_params: self.native_shader_params_now(partial),
    // rust: status,
    // rust: end_flash,
    // rust: end_flash_direction,
    // rust: ambient_light: dimension.map_or(0.0, |d| d.ambient_light),
    // rust: mood: self.ambience.moodiness,
    // rust: still_ticks: self.clock.still().then(|| self.visual_ticks()),
}
}

    // The local player's state for Iris's status uniforms, read as the HUD reads it.
pack_player_status :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let spectator = self.spectator();
    // rust: let survival = !self.creative && !spectator;
    // rust: let invisible = self.own_invisible();
    // rust: let riding = self.riding.is_some();
    // rust: let Some(p) = &mut self.player else {
    // rust: return PlayerStatus::default();
}
    // rust: PlayerStatus {
    // rust: survival,
    // rust: health: p.health.health(),
    // rust: max_health: p.attribute("minecraft:max_health").unwrap_or(20.0) as f32,
    // rust: food: p.health.food.food as f32,
    // rust: air: p.air as f32,
    // rust: armor: p
    // rust: .attribute("minecraft:armor")
    // rust: .or_else(|_| p.attribute("armor"))
    // rust: .unwrap_or(0.0) as f32,
    // rust: spectator,
    // rust: riding,
    // rust: feet_in_water: p.fluids.was_touching_water,
    // rust: swimming: p.pose == horizon_client::pose::Pose::Swimming,
    // rust: burning: p.fire_ticks > 0 && !spectator,
    // rust: hurt: p.health.hurt_animation_time > 0,
    // rust: invisible,
    // rust: sneaking: p.pose == horizon_client::pose::Pose::Crouching,
    // rust: sprinting: p.sprinting,
}
}

    // The Shader Options page opened: the picked pack's options, screens and names.
    // rust: pub(super) fn open_shader_options(&mut self) {
    // rust: let mut macros = Macros::standard();
    // rust: if let Some(renderer) = &self.renderer {
    // rust: renderer.define_pack_macros(&mut macros);
}
    // rust: let name = &self.settings.horizon.shader_pack;
    // rust: self.settings.shader_options = read_shader_options(name, &self.settings.language, &macros);
}

    // The Shader Options page closed with changes: they are saved, and the pack loads again.
    // rust: pub(super) fn save_shader_options(&mut self) {
    // rust: let Some(options) = self.settings.shader_options.take() else {
    // rust: return;
}
    // rust: write_shader_options(&options);
    // rust: self.pack_ids = None;
    // rust: if let Some(renderer) = &mut self.renderer {
    // rust: renderer.drop_shader_packs();
}
}

    // Turns off the pack `name` after loading it panicked or failed: nothing runs in its place,
    // it is no longer the picked pack (so the next start does not load it again), and the chat
    // says so.
shader_pack_failed :: proc(self: ^Self, name: string, dimension: i32, error: string) {
}
    // rust: log::error!("shader pack {name}: turned off: {error}");
    // rust: self.pack_ids = None;
    // rust: if let Some(renderer) = &mut self.renderer {
            // Marks this dimension as loaded, without a pack, so it is not tried again (without
            // a pack this can't fail).
    // rust: let _ = renderer.set_shader_pack(dimension, None, &[]);
}
    // rust: if self.settings.horizon.shader_pack == name {
    // rust: self.settings.horizon.shader_pack.clear();
    // rust: self.settings.save(&Self::options_path());
}
    // rust: self.system_message(Text::colored(
    // rust: format!("Shader pack {name} could not be loaded and was turned off"),
    // rust: 0xFF5555,
    // rust: ));
}

    // Whether the game's vignette draws: the option, unless the loaded pack turns it off.
    // rust: pub(super) fn vignette_shown(&self) -> bool {
    // rust: self.settings.vignette && self.pack_ids.as_ref().is_none_or(|ids| ids.vignette)
}

    // `currentRenderedItemId` of a held `item`, [`rendered_item_id`]'s; 0 without a pack.
    // rust: pub(super) fn rendered_item_id(&self, item: &str) -> i32 {
    // rust: self.pack_ids.as_ref().map_or(0, |ids| {
    // rust: rendered_item_id(
    // rust: ids.block_items.get(item).copied(),
    // rust: ids.items.get(item).copied(),
    // rust: ids.item_file,
    // rust: )
    // rust: })
}

    // `heldItemId(2)` and `heldBlockLightValue(2)`: main hand, then off hand (5.2, 5.3).
held_for_pack :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if self.pack_ids.is_none() {
    // rust: return ([0; 2], [0; 2]);
}
    // rust: let lum = self.luminance();
    // rust: let Some(ids) = &self.pack_ids else {
    // rust: return ([0; 2], [0; 2]);
}
    // rust: let hands = [self.selected, super::shield::OFFHAND_SLOT].map(|slot| {
    // rust: let item = self.stack_in(slot).map(|s| &*s.item);
    // rust: let id = item.and_then(|i| ids.items.get(i).copied());
    // rust: (
    // rust: id.unwrap_or(ids.missing_item),
    // rust: item.map_or(0, |i| i32::from(lum.of(i))),
    // rust: )
    // rust: });
    // rust: let first = if ids.old_hand_light && hands[1].1 > hands[0].1 {
    // rust: hands[1]
    // rust: } else {
    // rust: hands[0]
}
    // rust: ([first.0, hands[1].0], [first.1, hands[1].1])
}
}

    // rust: impl Game<'_> {
    // Starts a span of the entity geometry at vertex `start` for entity type `name`
    // (`minecraft:zombie`; "" for one the pack cannot name). Nothing without a pack.
    // rust: pub(super) fn mark_entity(&self, start: usize, name: &str) {
    // rust: self.mark_entity_part(start, name, false);
}

    // Starts a span for entity geometry that blends (name tags, shadows).
    // rust: pub(super) fn mark_translucent_entity(&self, start: usize, name: &str) {
    // rust: self.mark_entity_part(start, name, true);
}

mark_entity_part :: proc(self: ^Self, start: uint, name: string, translucent: bool) {
}
    // rust: let id = match &self.pack_ids {
    // rust: Some(ids) => ids
    // rust: .entities
    // rust: .get(name)
    // rust: .copied()
    // rust: .unwrap_or(ids.missing_entity),
    // rust: None if native_spans() => name_id(name),
    // rust: None => return,
}
    // rust: self.push_span(start, "ENTITIES", id);
    // rust: if let Some(last) = self.entity_spans.borrow_mut().last_mut() {
    // rust: last.translucent = translucent;
    // rust: if let Some(gpu) = self.skin_frame.borrow_mut().spans.last_mut() {
    // rust: gpu.translucent = translucent;
}
}
}

    // Starts a span for the block entity of block state `state`.
    // rust: pub(super) fn mark_block_entity(&self, start: usize, state: u32) {
    // rust: let Some(ids) = &self.pack_ids else {
    // rust: if native_spans() {
    // rust: self.push_span(start, "BLOCK_ENTITIES", state as i32);
}
    // rust: return;
}
    // rust: let id = *ids
    // rust: .block_states
    // rust: .borrow_mut()
    // rust: .entry(state)
    // rust: .or_insert_with(|| {
    // rust: let registry = self.pack.assets.registry;
    // rust: registry
    // rust: .state(horizon_world::registry::BlockStateId(state))
    // rust: .and_then(|s| {
    // rust: ids.blocks
    // rust: .id(&s.name, |k| s.properties.get(k).map(String::as_str))
    // rust: })
    // rust: .unwrap_or(ids.missing_block)
    // rust: });
    // rust: self.push_span(start, "BLOCK_ENTITIES", id);
    // rust: let emission = self
    // rust: .res
    // rust: .facts()
    // rust: .get(horizon_world::registry::BlockStateId(state))
    // rust: .emission;
    // rust: if let Some(last) = self.entity_spans.borrow_mut().last_mut() {
    // rust: last.emissive = emission > 0;
    // rust: if let Some(gpu) = self.skin_frame.borrow_mut().spans.last_mut() {
    // rust: gpu.emissive = emission > 0;
}
}
}

    // Starts the span of the local player's model; `hidden` in first person, where only a
    // pack's shadow pass draws it.
    // rust: pub(super) fn mark_player(&self, start: usize, hidden: bool) {
    // rust: self.mark_entity(start, "minecraft:player");
    // rust: if (self.pack_ids.is_some() || native_spans())
    // rust: && let Some(last) = self.entity_spans.borrow_mut().last_mut()
    // rust: {
    // rust: last.player = true;
    // rust: last.hidden = hidden;
    // rust: if let Some(gpu) = self.skin_frame.borrow_mut().spans.last_mut() {
    // rust: gpu.player = true;
    // rust: gpu.hidden = hidden;
}
}
}

    // Marks vertices `start..end` (one entity) as hidden from the camera, for an entity
    // Horizon's culling would drop but a pack's shadow pass still draws (`EntitySpan::hide`).
    // rust: pub(super) fn hide_spans_from(&self, start: usize, end: usize) -> bool {
    // rust: EntitySpan::hide(&mut self.entity_spans.borrow_mut(), start, end)
}

    // Starts a span of geometry that is not an entity (`PARTICLES`, `DESTROY`...).
    // rust: pub(super) fn mark_stage(&self, start: usize, stage: &str) {
    // rust: if self.pack_ids.is_some() || native_spans() {
    // rust: self.push_span(start, stage, 0);
}
}

push_span :: proc(self: ^Self, start: uint, stage: string, id: i32) {
}
    // rust: let mut spans = self.entity_spans.borrow_mut();
    // rust: let span = EntitySpan {
    // rust: start: start as u32,
    // rust: stage: horizon_shaders::render_stage(stage),
    // rust: id,
    // rust: ..Default::default()
}
    // rust: if self.pack_ids.is_some() && self.skinning() {
    // rust: let mut skin = self.skin_frame.borrow_mut();
    // rust: let gpu = EntitySpan {
    // rust: start: skin.vertices,
    // rust: ..span
}
    // rust: match skin.spans.last_mut() {
    // rust: Some(last) if last.start == gpu.start => *last = gpu,
    // rust: _ => skin.spans.push(gpu),
}
}
        // A span that drew nothing gives way to the next.
    // rust: match spans.last_mut() {
    // rust: Some(last) if last.start == span.start => *last = span,
    // rust: _ => spans.push(span),
}
}
}

// `currentRenderedItemId` of an item (Iris 1.11.7, observed with probe packs): a block item
// (`block`: its block's `block.properties` id, 0 when the file lacks it) reads that, whatever
// `item.properties` says of it; any other item its `item.properties` id (`item`), and one the
// file lacks 65535, or 0 when the pack has no `item.properties` (`item_file`).
rendered_item_id :: proc(block: Maybe(i32), item: Maybe(i32), item_file: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: block.or(item).unwrap_or(if item_file { 65535 } else { 0 })
}

// The block items' `currentRenderedItemId`: for each block's default state, the item it gives
// (`StateFacts::item`) takes the state's id in `ids`, or 0. A block named as its item wins over
// another block giving that item.
    // rust: fn block_item_ids(
    // rust: facts: &horizon_client::blocks::BlockFacts,
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: ids: &BlockIds,
    // rust: ) -> HashMap<String, i32> {
    // rust: let mut out = HashMap::new();
    // rust: for (i, state) in facts.states.iter().enumerate() {
    // rust: let id = horizon_world::registry::BlockStateId(i as u32);
    // rust: if &*state.item == "minecraft:air" || registry.default_state(&state.name) != Some(id) {
    // rust: continue;
}
    // rust: let value = registry
    // rust: .state(id)
    // rust: .and_then(|s| ids.id(&s.name, |k| s.properties.get(k).map(String::as_str)))
    // rust: .unwrap_or(0);
    // rust: if state.item == state.name {
    // rust: out.insert(state.item.to_string(), value);
    // rust: } else {
    // rust: out.entry(state.item.to_string()).or_insert(value);
}
}
    // rust: out
}

// Spans for a native mod (`native_render::RenderNeeds::entity_spans`), without a pack.
native_spans :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client::gfx::native_render::render_needs().entity_spans
}

// A span's id for entity type `name` without a pack: stable, so a mod can match runs from one
// frame to the next.
name_id :: proc(name: string) -> i {
    // Ported from Horizon
    return {}
}
    // FNV-1a.
    // rust: let mut hash: u32 = 0x811c_9dc5;
    // rust: for byte in name.bytes() {
    // rust: hash = (hash ^ u32::from(byte)).wrapping_mul(0x0100_0193);
}
    // rust: hash as i32
}

// Votes from distinct blocks, so adding states cannot change a shared sprite's material.
BlockIdVotes :: struct {

    // rust: impl<'a> BlockIdVotes<'a> {
add :: proc(self: ^Self, layer: u32, id: i32, name: ^'a str, sprite: Maybe(string)) {
}
        // Containers share the still sprite. Its fluid owns it just as a block
        // named exactly like its sprite does; a lower container id must not win.
    // rust: let owner = sprite
    // rust: .and_then(|s| s.strip_prefix("block/"))
    // rust: .map(|s| match s {
    // rust: "lava_still" | "lava_flow" => "lava",
    // rust: "water_still" | "water_flow" => "water",
    // rust: _ => s,
    // rust: });
    // rust: let named = owner == Some(name.strip_prefix("minecraft:").unwrap_or(name));
    // rust: let v = self.0.entry((layer, id)).or_default();
    // rust: v.0 |= named;
    // rust: v.1.insert(name);
}

write :: proc(self: ^Self, table: ^[i32]) {
}
    // rust: let mut best = BTreeMap::new();
    // rust: for ((layer, id), (named, blocks)) in self.0 {
    // rust: let candidate = (named, blocks.len(), -id);
    // rust: let b = best.entry(layer).or_insert(candidate);
    // rust: if candidate > *b {
    // rust: *b = candidate;
}
}
    // rust: for (layer, (_, _, id)) in best {
    // rust: if let Some(slot) = table.get_mut(layer as usize * 2) {
    // rust: *slot = -id;
}
}
}
}

    // rust: mod block_id_tests {
//     use super::BlockIdVotes;

fluid_sprites_keep_their_fluid_material_when_a_container_uses_them :: proc() {
}
    // rust: let mut votes = BlockIdVotes::default();
        // Our runtime probe: cauldron 17, lava 29. The lower container id used to
        // win the still sprite's tie, while the flow sprite already read 29.
    // rust: for (layer, sprite) in [(0, "lava_still"), (1, "lava_flow")] {
    // rust: votes.add(
    // rust: layer,
    // rust: 29,
    // rust: "minecraft:lava",
    // rust: Some(&format!("block/{sprite}")),
    // rust: );
}
    // rust: votes.add(0, 17, "minecraft:lava_cauldron", Some("block/lava_still"));
        // Water's still sprite is also shared by containers and waterlogged models.
    // rust: votes.add(2, 31, "minecraft:water", Some("block/water_still"));
    // rust: votes.add(2, 17, "minecraft:water_cauldron", Some("block/water_still"));
    // rust: votes.add(
    // rust: 2,
    // rust: 17,
    // rust: "minecraft:other_container",
    // rust: Some("block/water_still"),
    // rust: );
    // rust: let mut table = [-1; 8];
    // rust: votes.write(&mut table);
    // rust: assert_eq!(table, [29, -1, 29, -1, 31, -1, -1, -1]);
}

shared_model_sprites_still_use_distinct_blocks_and_the_named_owner :: proc() {
}
    // rust: let mut votes = BlockIdVotes::default();
    // rust: for _ in 0..20 {
    // rust: votes.add(0, 3, "minecraft:many_states", Some("block/shared"));
}
    // rust: votes.add(0, 9, "minecraft:one", Some("block/shared"));
    // rust: votes.add(0, 9, "minecraft:two", Some("block/shared"));
    // rust: votes.add(1, 20, "minecraft:oak_leaves", Some("block/oak_leaves"));
    // rust: votes.add(1, 3, "minecraft:one", Some("block/oak_leaves"));
    // rust: votes.add(1, 3, "minecraft:two", Some("block/oak_leaves"));
    // rust: let mut table = [-1; 4];
    // rust: votes.write(&mut table);
    // rust: assert_eq!(table, [9, -1, 20, -1]);
}
}

// `mc_Entity` (x, y) of each block sprite layer, as (id, fluid) pairs: terrain vertices carry
// their sprite layer, not their block. A layer takes the id of the block named like its sprite
// (`block/oak_leaves` for `oak_leaves`, and still/flow sprites for their fluid), else the id
// most blocks drawing it share (ties: the lowest); -1 when no block drawing it has one.
// y is 1 for the fluid sprites, -1 otherwise.
    // rust: pub(super) fn block_id_table(pack: &super::PackResources, ids: &BlockIds) -> Vec<i32> {
    // rust: let layers = pack
    // rust: .render
    // rust: .sprite_layers
    // rust: .values()
    // rust: .max()
    // rust: .map_or(0, |l| l + 1) as usize;
    // rust: let mut table = vec![-1; layers * 2];
    // rust: if ids.is_empty() {
    // rust: return table;
}
    // rust: let registry = pack.assets.registry;
    // rust: let catalog = &pack.render.model_catalog;
    // rust: let sprite = |name: &str| pack.render.sprite_layers.get(name).copied();
    // (layer, id) -> (a block named like the sprite, the blocks).
    // rust: let mut votes = BlockIdVotes::default();
    // rust: for i in 0..registry.len() {
    // rust: let state_id = horizon_world::registry::BlockStateId(i as u32);
    // rust: let Some(state) = registry.state(state_id) else {
    // rust: continue;
}
    // rust: let Some(id) = ids.id(&state.name, |k| state.properties.get(k).map(String::as_str)) else {
    // rust: continue;
}
    // rust: let block = state.name.strip_prefix("minecraft:").unwrap_or(&state.name);
    // rust: let mut vote = |layer: u32| {
    // rust: votes.add(
    // rust: layer,
    // rust: id,
    // rust: &state.name,
    // rust: pack.layer_names.get(&layer).map(String::as_str),
    // rust: );
}
        // Fluids draw from their own sprites.
    // rust: let fluid = match block {
    // rust: "water" => ["water_still", "water_flow"],
    // rust: "lava" => ["lava_still", "lava_flow"],
    // rust: _ => ["", ""],
}
    // rust: for f in fluid.iter().filter(|f| !f.is_empty()) {
    // rust: if let Some(l) = sprite(&format!("minecraft:block/{f}")) {
    // rust: vote(l);
}
}
    // rust: let origin = horizon_core::position::BlockPos::new(0, 0, 0);
    // rust: for (_, model) in catalog.collect(state_id, origin).unwrap_or_default() {
    // rust: for face in &model.faces {
    // rust: vote(face.layer);
}
}
}
    // rust: votes.write(&mut table);
    // rust: for f in ["water_still", "water_flow", "lava_still", "lava_flow"] {
    // rust: if let Some(l) = sprite(&format!("minecraft:block/{f}"))
    // rust: && let Some(slot) = table.get_mut(l as usize * 2 + 1)
    // rust: {
    // rust: *slot = 1;
}
}
    // rust: table
}

// `at_midBlock.w` of each block sprite layer: the light the block drawing it gives (Iris's
// `BLOCK_EMISSION_ATTRIBUTE`; 0 to 15, as Iris 1.11.7 passes it). Terrain vertices carry their
// sprite layer, not their block, so as for `mc_Entity` a layer takes the light of the block
// named like its sprite, else the light most block states drawing it give (ties: the lowest).
    // rust: pub(super) fn block_emission_table(pack: &super::PackResources) -> Vec<i32> {
//     use std::collections::BTreeMap;
    // rust: let layers = pack
    // rust: .render
    // rust: .sprite_layers
    // rust: .values()
    // rust: .max()
    // rust: .map_or(0, |l| l + 1) as usize;
    // rust: let registry = pack.assets.registry;
    // rust: let catalog = &pack.render.model_catalog;
    // rust: let sprite = |name: &str| pack.render.sprite_layers.get(name).copied();
    // (layer, light) -> (a block named like the sprite draws it, how many states do).
    // rust: let mut votes: BTreeMap<(u32, u8), (bool, usize)> = BTreeMap::new();
    // rust: for i in 0..registry.len() {
    // rust: let state_id = horizon_world::registry::BlockStateId(i as u32);
    // rust: let Some(state) = registry.state(state_id) else {
    // rust: continue;
}
    // rust: let light = pack
    // rust: .context
    // rust: .tables
    // rust: .facts(state_id)
    // rust: .map_or(0, |f| f.emission);
    // rust: let block = state.name.strip_prefix("minecraft:").unwrap_or(&state.name);
    // rust: let mut vote = |layer: u32| {
    // rust: let named = pack
    // rust: .layer_names
    // rust: .get(&layer)
    // rust: .and_then(|n| n.strip_prefix("block/"))
    // rust: == Some(block);
    // rust: let v = votes.entry((layer, light)).or_default();
    // rust: v.0 |= named;
    // rust: v.1 += 1;
}
    // rust: let fluid = match block {
    // rust: "water" => ["water_still", "water_flow"],
    // rust: "lava" => ["lava_still", "lava_flow"],
    // rust: _ => ["", ""],
}
    // rust: for f in fluid.iter().filter(|f| !f.is_empty()) {
    // rust: if let Some(l) = sprite(&format!("minecraft:block/{f}")) {
    // rust: vote(l);
}
}
    // rust: let origin = horizon_core::position::BlockPos::new(0, 0, 0);
    // rust: for (_, model) in catalog.collect(state_id, origin).unwrap_or_default() {
    // rust: for face in &model.faces {
    // rust: vote(face.layer);
}
}
}
    // rust: layer_lights(&votes, layers)
}

// Each of `layers` sprite layers' light from `votes`, (layer, light) -> (a block named like the
// sprite draws it, how many states do): the named block's, else the most states', ties the
// lowest; 0 for a layer no block draws.
    // rust: fn layer_lights(
    // rust: votes: &std::collections::BTreeMap<(u32, u8), (bool, usize)>,
    // rust: layers: usize,
    // rust: ) -> Vec<i32> {
    // rust: let mut best: std::collections::BTreeMap<u32, (bool, usize, i32)> = Default::default();
    // rust: for (&(layer, light), &(named, states)) in votes {
    // rust: let candidate = (named, states, -i32::from(light));
    // rust: let b = best.entry(layer).or_insert(candidate);
    // rust: if candidate > *b {
    // rust: *b = candidate;
}
}
    // rust: let mut table = vec![0; layers];
    // rust: for (layer, (_, _, light)) in best {
    // rust: if let Some(slot) = table.get_mut(layer as usize) {
    // rust: *slot = -light;
}
}
    // rust: table
}

// The table a `shaders/` pack's terrain reads per sprite layer: `mc_Entity`'s (id, fluid) pair
// from `ids` (`block_id_table`), then `at_midBlock.w` from `emission`.
terrain_table :: proc(ids: ^[i32], emission: ^[i32]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: ids.chunks(2)
    // rust: .enumerate()
    // rust: .flat_map(|(layer, pair)| [pair[0], pair[1], emission.get(layer).copied().unwrap_or(0)])
    // rust: .collect()
}

    // rust: mod emission_tests {
//     use super::{layer_lights, terrain_table};

    // A sprite's light: the block named like it gives its own (a torch, 14, over a wall
    // torch's); a shared one takes what most states drawing it give (a furnace's side: as
    // many lit states, 13, as unlit, 0: the lowest), and a layer no block draws stays 0.
a_sprite_takes_the_light_of_its_block :: proc() {
}
    // rust: let votes = std::collections::BTreeMap::from([
    // rust: ((0, 14), (true, 1)),
    // rust: ((0, 0), (false, 5)),
    // rust: ((1, 13), (false, 4)),
    // rust: ((1, 0), (false, 4)),
    // rust: ((2, 15), (false, 4)),
    // rust: ((2, 0), (false, 5)),
    // rust: ((3, 7), (false, 2)),
    // rust: ]);
    // rust: assert_eq!(layer_lights(&votes, 5), [14, 0, 0, 7, 0]);
}

    // The table `shaders/` packs' terrain reads: three values a layer, `mc_Entity`'s pair
    // then the light.
the_terrain_table_holds_ids_then_light :: proc() {
}
    // rust: assert_eq!(
    // rust: terrain_table(&[10, -1, 20, 1], &[14, 0]),
    // rust: [10, -1, 14, 20, 1, 0]
    // rust: );
}
}

    // rust: mod rendered_item_tests {
//     use super::rendered_item_id;

    // Iris 1.11.7's values (probe packs of ours): a block item reads its block's id, and 0 when
    // `block.properties` lacks it even if `item.properties` names it (oak planks as item 15);
    // other items read their `item.properties` id, or 65535 when the file lacks them, and 0
    // when the pack has no such file.
a_held_item_reads_its_block_id_or_item_id :: proc() {
}
        // Stone: block 21 and item 12.
    // rust: assert_eq!(rendered_item_id(Some(21), Some(12), true), 21);
    // rust: assert_eq!(rendered_item_id(Some(0), Some(15), true), 0);
    // rust: assert_eq!(rendered_item_id(Some(0), None, true), 0);
    // rust: assert_eq!(rendered_item_id(Some(0), None, false), 0);
    // rust: assert_eq!(rendered_item_id(None, Some(11), true), 11);
    // rust: assert_eq!(rendered_item_id(None, None, true), 65535);
    // rust: assert_eq!(rendered_item_id(None, None, false), 0);
}
}

    // rust: mod native_pack_tests {
//     use super::{active_pack, pack_draws_flat};
//     use horizon_client::mod_list::{Installed, ModList, NativePage};

shaders_packs_and_packs_with_a_shadow_pass_draw_flat :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-flat-packs-{}", std::process::id()));
        // A folder without a manifest is a `shaders/` pack; with one, a pack of Horizon's own.
    // rust: let pack = |name: &str, manifest: Option<&str>| {
    // rust: let dir = root.join(name);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: if let Some(extra) = manifest {
    // rust: std::fs::write(dir.join("material.wgsl"), "").unwrap();
    // rust: let text = format!(
    // rust: "schema = 1\nid = \"{name}\"\nname = \"{name}\"\nversion = \"1\"\napi = \"{}\"\n\
    // rust: [material]\nfile = \"material.wgsl\"\n{extra}",
    // rust: horizon_shader_api::API
    // rust: );
    // rust: std::fs::write(dir.join(horizon_shader_api::MANIFEST), text).unwrap();
}
    // rust: dir
}
    // rust: assert!(pack_draws_flat(&pack("shaders_pack", None)));
    // rust: assert!(!pack_draws_flat(&pack("unshadowed", Some(""))));
    // rust: assert!(pack_draws_flat(&pack("shadowed", Some("[shadow]\n"))));
    // rust: std::fs::remove_dir_all(&root).ok();
}

native_shader_follows_its_mod_without_affecting_other_packs :: proc() {
}
    // rust: let mut mods = ModList::default();
    // rust: mods.installed.push(Installed {
    // rust: id: "horizon_better_visuals".into(),
    // rust: title: "Better Visuals".into(),
    // rust: description: String::new(),
    // rust: problem: None,
    // rust: dev: false,
    // rust: native: Some(NativePage::default()),
    // rust: });
    // rust: let owned = "native-horizon_better_visuals";
    // rust: assert_eq!(active_pack(owned, &mods), owned);
    // rust: mods.disabled.insert("horizon_better_visuals".into());
    // rust: assert_eq!(active_pack(owned, &mods), "");
    // rust: assert_eq!(active_pack("golden_hour", &mods), "golden_hour");
    // rust: mods.installed[0].native = None;
    // rust: assert_eq!(active_pack(owned, &mods), owned);
}
}
