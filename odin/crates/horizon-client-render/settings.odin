//! Transpiled from Horizon Rust crate
package horizon_client_render_settings

import "core:fmt"
import "core:mem"
import "core:math"

// Player settings persisted in `options.txt` with vanilla's keys and value
// encodings (Options.processOptions); lines Horizon does not know are kept.
// The option screens live in `options_ui`.
// use crate::keybinds::KeyBinds;
// use crate::options_file::{OptionsFile, V};
// use horizon_protocol::packets::configuration::ClientInformation;
// use std::{fs, path::Path};

    // rust: pub use horizon_client_core::sound_source::SOUND_SOURCES;

// Per-source volumes for the mixer (soundCategory_* except master).
SOURCE_VOLUMES :: std::sync::RwLock::new([1.0; 11])
set_source_volumes :: proc(volumes: [f32; 11]) {
}
    // rust: *SOURCE_VOLUMES.write().unwrap_or_else(|e| e.into_inner()) = volumes;
}
// The SoundSource an event plays on. Vanilla callers pick the source; this
// follows their conventions by event family.
sound_source :: proc(event: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let e = event.trim_start_matches("minecraft:");
    // rust: let index = |name: &str| SOUND_SOURCES.iter().position(|n| *n == name).unwrap_or(0);
    // rust: const HOSTILE: [&str; 34] = [
    // rust: "zombie",
    // rust: "skeleton",
    // rust: "creeper",
    // rust: "spider",
    // rust: "cave_spider",
    // rust: "enderman",
    // rust: "witch",
    // rust: "slime",
    // rust: "magma_cube",
    // rust: "blaze",
    // rust: "ghast",
    // rust: "drowned",
    // rust: "husk",
    // rust: "stray",
    // rust: "phantom",
    // rust: "pillager",
    // rust: "vindicator",
    // rust: "evoker",
    // rust: "illusioner",
    // rust: "ravager",
    // rust: "guardian",
    // rust: "elder_guardian",
    // rust: "silverfish",
    // rust: "zombified_piglin",
    // rust: "wither_skeleton",
    // rust: "bogged",
    // rust: "breeze",
    // rust: "endermite",
    // rust: "parched",
    // rust: "warden",
    // rust: "zombie_villager",
    // rust: "vex",
    // rust: "wither",
        // Monster's common hurt/death (e.g. Giant) and other shared sounds.
    // rust: "hostile",
    // rust: ];
    // rust: if e == "block.potent_sulfur.noxious_gas" {
        // PotentSulfurBlock.animateTick, its only caller, plays it as AMBIENT.
    // rust: index("ambient")
    // rust: } else if e.starts_with("music_disc.") {
    // rust: index("record")
    // rust: } else if e.starts_with("item.goat_horn.") {
        // InstrumentItem.play: SoundSource.RECORDS.
    // rust: index("record")
    // rust: } else if e.starts_with("music.") {
    // rust: index("music")
    // rust: } else if e.starts_with("weather.") || e.starts_with("entity.lightning_bolt") {
    // rust: index("weather")
    // rust: } else if e.starts_with("block.") {
    // rust: index("block")
    // rust: } else if e.starts_with("ambient.") {
    // rust: index("ambient")
    // rust: } else if e.starts_with("ui.") {
    // rust: index("ui")
    // rust: } else if e.starts_with("entity.player.")
    // rust: || e.starts_with("item.")
    // rust: || e.starts_with("entity.item.")
    // rust: || e.starts_with("entity.experience_orb")
    // rust: || e.starts_with("entity.arrow")
    // rust: {
    // rust: index("player")
    // rust: } else if let Some(rest) = e.strip_prefix("entity.") {
    // rust: let mob = rest.split('.').next().unwrap_or("");
    // rust: if HOSTILE.contains(&mob) {
    // rust: index("hostile")
    // rust: } else {
    // rust: index("neutral")
}
    // rust: } else {
    // rust: index("master")
}
}
// Volume multiplier of a sound source by index.
source_volume :: proc(i: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if i == 0 {
    // rust: 1.0
    // rust: } else {
    // rust: SOURCE_VOLUMES.read().unwrap_or_else(|e| e.into_inner())[i]
}
}

Settings :: struct {
    // Degrees, 30..=110 (options.txt stores (fov - 70) / 40).
    fov: f32,
    // Chunks, 2..=32.
    render_distance: i32,
    // Chunks, 5..=32.
    simulation_distance: i32,
    // 0..1, vanilla default 0.5.
    sensitivity: f32,
    // 0..1 (soundCategory_master).
    master_volume: f32,
    // Volumes of every other sound source, indexed like SOUND_SOURCES.
    volumes: [f32,
    // Empty for system default, or a specific audio device name.
    sound_device: string,
    // Requested scale (0 = auto); rendering caps it to the current framebuffer.
    gui_scale: u32,
    view_bobbing: bool,
    // Brightness 0..1 (gamma).
    gamma: f32,
    // 10..=260 (260 = unlimited).
    max_fps: u32,
    vsync: bool,
    fullscreen: bool,
    // Smooth lighting (ao).
    smooth_lighting: bool,
    // "false", "fast" or "true" (renderClouds).
    clouds: string,
    cloud_range: i32,
    // 0 all, 1 decreased, 2 minimal.
    particles: u8,
    entity_distance: f32,
    entity_shadows: bool,
    biome_blend: i32,
    // "fast", "fancy", "fabulous" or "custom".
    graphics_preset: string,
    mipmap_levels: i32,
    weather_radius: i32,
    chunk_fade: f32,
    vignette: bool,
    autosave_indicator: bool,
    cutout_leaves: bool,
    improved_transparency: bool,
    // 0 off, 1 crosshair, 2 hotbar.
    attack_indicator: u8,
    inactivity_fps_limit: string,
    prioritize_chunk_updates: u8,
    menu_blur: i32,
    invert_y: bool,
    mouse_wheel_sensitivity: f32,
    discrete_scroll: bool,
    toggle_crouch: bool,
    toggle_sprint: bool,
    auto_jump: bool,
    language: string,
    force_unicode: bool,
    japanese_glyphs: bool,
    chat_visibility: u8,
    chat_colors: bool,
    chat_links: bool,
    chat_links_prompt: bool,
    chat_opacity: f32,
    // Chat Delay in seconds (`chatDelay`): player chat shows this far apart.
    chat_delay: f64,
    text_background_opacity: f32,
    chat_scale: f32,
    chat_width: f32,
    chat_height_focused: f32,
    chat_height_unfocused: f32,
    chat_line_spacing: f32,
    auto_suggestions: bool,
    reduced_debug_info: bool,
    high_contrast: bool,
    // `showSubtitles`: the closed-caption overlay.
    show_subtitles: bool,
    // `notificationDisplayTime`: a multiplier for subtitle and toast times.
    notification_display_time: f32,
    main_hand_left: bool,
    // Enabled resource packs, bottom first (resourcePacks).
    resource_packs: [dynamic]string,
    keys: KeyBinds,
    // Every option in its stored form (the typed fields above mirror it).
    file: OptionsFile,
    invert_x: bool,
    // Allow widgets to replace the default mouse cursor icon.
    allow_cursor_changes: bool,
    toggle_attack: bool,
    toggle_use: bool,
    // Taps of the sprint key counted as double taps (sprintWindow).
    sprint_window: i32,
    // Show the operator items tab in a creative inventory.
    operator_items_tab: bool,
    // Allow platform quit shortcuts to close the game window.
    quit_shortcuts: bool,
    // On macOS, turn Control-click into a right click.
    ctrl_click_emulates_right_click: bool,
    // Horizon's own graphics settings (`horizon-graphics.txt`, not options.txt).
    horizon: crate::graphics::Graphics,
    // The graphics API the game started with: `Options.preferredGraphicsBackendFromStartup`.
    startup_api: crate::graphics::GraphicsApi,
    // `Monitor.videoModes` of the window's monitor, for the Video page (set by the game).
    video_modes: [dynamic]crate::window::VideoMode,
    // Controller settings (`horizon-controller.txt`, Horizon's own).
    controller: crate::gamepad::PadSettings,
    // Horizon's optional extras (`horizon-extras.txt`), all off by default.
    extras: crate::extras::Extras,
    // The Horizon mods turned on (`horizon-mods.txt`), all off by default.
    mods: crate::mod_list::ModList,
    // The packs in `shaderpacks/`, listed when the Shader Packs page opens; the pick is
    // `horizon.shader_pack`.
    shader_packs: [dynamic]crate::shader_pack_list::Entry,
    // The picked pack's options while its Shader Options page is open.
    shader_options: Maybe(crate::shader_options::ShaderOptions),
}
    // rust: impl Default for Settings {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: fov: 70.0,
    // rust: render_distance: 12,
    // rust: simulation_distance: 12,
    // rust: sensitivity: 0.5,
    // rust: master_volume: 1.0,
    // rust: volumes: [1.0; 11],
    // rust: sound_device: String::new(),
    // rust: gui_scale: 0,
    // rust: view_bobbing: true,
    // rust: gamma: 0.5,
            // Vanilla's default, as for an options.txt without the key: a
            // capped frame rate leaves the cores idle when VSync is off.
    // rust: max_fps: 120,
    // rust: vsync: true,
    // rust: fullscreen: false,
    // rust: smooth_lighting: true,
    // rust: clouds: "true".into(),
    // rust: cloud_range: 128,
    // rust: particles: 0,
    // rust: entity_distance: 1.0,
    // rust: entity_shadows: true,
    // rust: biome_blend: 2,
    // rust: graphics_preset: "fancy".into(),
    // rust: mipmap_levels: 4,
    // rust: weather_radius: 10,
    // rust: chunk_fade: 0.75,
    // rust: vignette: true,
    // rust: autosave_indicator: true,
    // rust: cutout_leaves: true,
    // rust: improved_transparency: false,
    // rust: attack_indicator: 1,
    // rust: inactivity_fps_limit: "afk".into(),
    // rust: prioritize_chunk_updates: 0,
    // rust: menu_blur: 5,
    // rust: invert_y: false,
    // rust: mouse_wheel_sensitivity: 1.0,
    // rust: discrete_scroll: false,
    // rust: allow_cursor_changes: true,
    // rust: toggle_crouch: false,
    // rust: toggle_sprint: false,
    // rust: auto_jump: false,
    // rust: language: "en_us".into(),
    // rust: force_unicode: false,
    // rust: japanese_glyphs: false,
    // rust: chat_visibility: 0,
    // rust: chat_colors: true,
    // rust: chat_links: true,
    // rust: chat_links_prompt: true,
    // rust: chat_opacity: 1.0,
    // rust: chat_delay: 0.0,
    // rust: text_background_opacity: 0.5,
    // rust: chat_scale: 1.0,
    // rust: chat_width: 1.0,
    // rust: chat_height_focused: 1.0,
    // rust: chat_height_unfocused: 70.0 / 160.0,
    // rust: chat_line_spacing: 0.0,
    // rust: auto_suggestions: true,
    // rust: reduced_debug_info: false,
    // rust: high_contrast: false,
    // rust: show_subtitles: false,
    // rust: notification_display_time: 1.0,
    // rust: main_hand_left: false,
    // rust: resource_packs: Vec::new(),
    // rust: keys: KeyBinds::default(),
    // rust: file: OptionsFile::default(),
    // rust: invert_x: false,
    // rust: toggle_attack: false,
    // rust: toggle_use: false,
    // rust: sprint_window: 7,
    // rust: operator_items_tab: false,
    // rust: quit_shortcuts: true,
    // rust: ctrl_click_emulates_right_click: false,
    // rust: horizon: Default::default(),
    // rust: startup_api: Default::default(),
    // rust: video_modes: Vec::new(),
    // rust: controller: Default::default(),
    // rust: extras: Default::default(),
    // rust: mods: Default::default(),
    // rust: shader_packs: Vec::new(),
    // rust: shader_options: None,
}
}
}
put_f :: proc(f: ^OptionsFile, key: string, v: f32) {
}
    // rust: if v != f.double(key) as f32 {
    // rust: f.set(key, V::Double(f64::from(v)));
}
}
put_i :: proc(f: ^OptionsFile, key: string, v: i32) {
}
    // rust: if v != f.int(key) {
    // rust: f.set(key, V::Int(v));
}
}
put_b :: proc(f: ^OptionsFile, key: string, v: bool) {
}
    // rust: if v != f.bool(key) {
    // rust: f.set(key, V::Bool(v));
}
}
put_name :: proc(f: ^OptionsFile, key: string, v: string) {
}
    // rust: if v != f.name(key) {
    // rust: f.set_name(key, v);
}
}
put_s :: proc(f: ^OptionsFile, key: string, v: string) {
}
    // rust: if v != f.string(key) {
    // rust: f.set(key, V::Str(v.to_owned()));
}
}
    // rust: impl Settings {
    // The index in `video_modes` of the preferred fullscreen mode, -1 (the desktop's own mode)
    // when none is set or the monitor lacks it: `Monitor.indexOfMode`.
video_mode_index :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.file
    // rust: .fullscreen_resolution
    // rust: .as_deref()
    // rust: .and_then(crate::window::VideoMode::read)
    // rust: .and_then(|mode| self.video_modes.iter().position(|m| *m == mode))
    // rust: .map_or(-1, |i| i as i32)
}
load :: proc(path: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let horizon = path
    // rust: .parent()
    // rust: .map(crate::graphics::Graphics::load)
    // rust: .unwrap_or_default();
    // rust: crate::mipmap::set_dither_cutouts(horizon.dither_cutout_mips);
    // rust: let controller = path
    // rust: .parent()
    // rust: .map(crate::gamepad::PadSettings::load)
    // rust: .unwrap_or_default();
    // rust: let extras_text = path
    // rust: .parent()
    // rust: .and_then(|dir| fs::read_to_string(dir.join(crate::extras::FILE)).ok())
    // rust: .unwrap_or_default();
    // rust: let mut extras = crate::extras::Extras::parse(&extras_text);
        // The enabled mods are the game folder's, shared by its players (`--player-dir`).
    // rust: let mods = path
    // rust: .parent()
    // rust: .map(|dir| crate::mod_list::ModList::load(&crate::logging::shared_dir(dir)))
    // rust: .unwrap_or_default();
    // rust: let mut settings = match fs::read(path) {
    // rust: Ok(bytes) => {
    // rust: let text = String::from_utf8_lossy(&bytes);
    // rust: extras.read_old_options(&extras_text, &text);
    // rust: Self {
    // rust: horizon,
    // rust: controller,
    // rust: extras,
    // rust: mods,
    // rust: ..Self::parse(&text)
}
}
    // rust: Err(_) => Self {
    // rust: horizon,
    // rust: controller,
    // rust: extras,
    // rust: mods,
    // rust: ..Self::default()
    // rust: },
}
        // Horizon's own key bindings live in horizon-extras.txt, not in options.txt.
    // rust: let emote = settings.extras.emote_key.clone();
    // rust: settings.keys.set("key.emote", &emote);
    // rust: settings.describe_for_crashes();
        // Options.load: the backend asked for at startup, what a restart is measured from.
    // rust: Self {
    // rust: startup_api: settings.horizon.api,
    // rust: ..settings
}
}
    // The render settings and resource packs a crash report lists.
describe_for_crashes :: proc(self: ^Self) {
}
    // rust: let on = |b: bool| if b { "on" } else { "off" };
    // rust: let scale = match self.gui_scale {
    // rust: 0 => "auto".to_owned(),
    // rust: n => n.to_string(),
}
    // rust: crate::crash::set_detail(
    // rust: "Render Settings",
    // rust: format!(
    // rust: "render distance {}, simulation distance {}, graphics {}, FOV {:.0}, max FPS {}, VSync {}, fullscreen {}, GUI scale {scale}, smooth lighting {}, clouds {}, biome blend {}, mipmap levels {}",
    // rust: self.render_distance,
    // rust: self.simulation_distance,
    // rust: self.graphics_preset,
    // rust: self.fov,
    // rust: if self.max_fps >= 260 {
    // rust: "unlimited".to_owned()
    // rust: } else {
    // rust: self.max_fps.to_string()
    // rust: },
    // rust: on(self.vsync),
    // rust: on(self.fullscreen),
    // rust: on(self.smooth_lighting),
    // rust: self.clouds,
    // rust: self.biome_blend,
    // rust: self.mipmap_levels,
    // rust: ),
    // rust: );
    // rust: crate::crash::set_detail(
    // rust: "Resource Packs",
    // rust: if self.resource_packs.is_empty() {
    // rust: "vanilla".to_owned()
    // rust: } else {
    // rust: self.resource_packs.join(", ")
    // rust: },
    // rust: );
}
parse :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_file(OptionsFile::parse(text))
}
    // Typed view of an options file.
from_file :: proc(f: OptionsFile) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut keys = KeyBinds::default();
    // rust: for (name, _, _) in crate::keybinds::MAPPINGS {
    // rust: keys.set(name, &f.key_binding(name));
}
    // rust: let mut volumes = [1.0; 11];
    // rust: for (i, source) in SOUND_SOURCES.iter().enumerate() {
    // rust: volumes[i] = f.double(&format!("soundCategory_{source}")) as f32;
}
    // rust: Self {
    // rust: fov: f.int("fov") as f32,
    // rust: render_distance: f.int("renderDistance"),
    // rust: simulation_distance: f.int("simulationDistance"),
    // rust: sensitivity: f.double("mouseSensitivity") as f32,
    // rust: master_volume: volumes[0],
    // rust: volumes,
    // rust: sound_device: f.string("soundDevice"),
    // rust: gui_scale: f.int("guiScale").max(0) as u32,
    // rust: view_bobbing: f.bool("bobView"),
    // rust: gamma: f.double("gamma") as f32,
    // rust: max_fps: f.int("maxFps") as u32,
    // rust: vsync: f.bool("enableVsync"),
    // rust: fullscreen: f.bool("fullscreen"),
    // rust: smooth_lighting: f.bool("ao"),
    // rust: clouds: f.name("renderClouds"),
    // rust: cloud_range: f.int("cloudRange"),
    // rust: particles: f.int("particles") as u8,
    // rust: entity_distance: f.double("entityDistanceScaling") as f32,
    // rust: entity_shadows: f.bool("entityShadows"),
    // rust: biome_blend: f.int("biomeBlendRadius"),
    // rust: graphics_preset: f.name("graphicsPreset"),
    // rust: mipmap_levels: f.int("mipmapLevels"),
    // rust: weather_radius: f.int("weatherRadius"),
    // rust: chunk_fade: f.double("chunkSectionFadeInTime") as f32,
    // rust: vignette: f.bool("vignette"),
    // rust: autosave_indicator: f.bool("showAutosaveIndicator"),
    // rust: cutout_leaves: f.bool("cutoutLeaves"),
    // rust: improved_transparency: f.bool("improvedTransparency"),
    // rust: attack_indicator: f.int("attackIndicator") as u8,
    // rust: inactivity_fps_limit: f.name("inactivityFpsLimit"),
    // rust: prioritize_chunk_updates: f.int("prioritizeChunkUpdates") as u8,
    // rust: menu_blur: f.int("menuBackgroundBlurriness"),
    // rust: invert_x: f.bool("invertXMouse"),
    // rust: invert_y: f.bool("invertYMouse"),
    // rust: mouse_wheel_sensitivity: f.double("mouseWheelSensitivity") as f32,
    // rust: discrete_scroll: f.bool("discrete_mouse_scroll"),
    // rust: allow_cursor_changes: f.bool("allowCursorChanges"),
    // rust: toggle_crouch: f.bool("toggleCrouch"),
    // rust: toggle_sprint: f.bool("toggleSprint"),
    // rust: toggle_attack: f.bool("toggleAttack"),
    // rust: toggle_use: f.bool("toggleUse"),
    // rust: sprint_window: f.int("sprintWindow"),
    // rust: operator_items_tab: f.bool("operatorItemsTab"),
    // rust: quit_shortcuts: f.bool("quitShortcuts"),
    // rust: ctrl_click_emulates_right_click: f.bool("ctrlClickEmulatesRightClick"),
    // rust: horizon: Default::default(),
    // rust: startup_api: Default::default(),
    // rust: video_modes: Vec::new(),
    // rust: controller: Default::default(),
    // rust: extras: Default::default(),
    // rust: mods: Default::default(),
    // rust: shader_packs: Vec::new(),
    // rust: shader_options: None,
    // rust: auto_jump: f.bool("autoJump"),
    // rust: language: f.string("lang"),
    // rust: force_unicode: f.bool("forceUnicodeFont"),
    // rust: japanese_glyphs: f.bool("japaneseGlyphVariants"),
    // rust: chat_visibility: f.int("chatVisibility") as u8,
    // rust: chat_colors: f.bool("chatColors"),
    // rust: chat_links: f.bool("chatLinks"),
    // rust: chat_links_prompt: f.bool("chatLinksPrompt"),
    // rust: chat_opacity: f.double("chatOpacity") as f32,
    // rust: chat_delay: f.double("chatDelay"),
    // rust: text_background_opacity: f.double("textBackgroundOpacity") as f32,
    // rust: chat_scale: f.double("chatScale") as f32,
    // rust: chat_width: f.double("chatWidth") as f32,
    // rust: chat_height_focused: f.double("chatHeightFocused") as f32,
    // rust: chat_height_unfocused: f.double("chatHeightUnfocused") as f32,
    // rust: chat_line_spacing: f.double("chatLineSpacing") as f32,
    // rust: auto_suggestions: f.bool("autoSuggestions"),
    // rust: reduced_debug_info: f.bool("reducedDebugInfo"),
    // rust: high_contrast: f.bool("highContrast"),
    // rust: show_subtitles: f.bool("showSubtitles"),
    // rust: notification_display_time: f.double("notificationDisplayTime") as f32,
    // rust: main_hand_left: f.name("mainHand") == "left",
    // rust: resource_packs: f.list("resourcePacks"),
    // rust: keys,
    // rust: file: f,
}
}
    // `Options.createInformation`: what the server learns about this player.
client_information :: proc(self: ^Self, view_distance: i8) -> C {
    // Ported from Horizon
    return {}
}
    // rust: ClientInformation {
    // rust: language: self.language.clone(),
    // rust: chat_visibility: self.chat_visibility as i32,
    // rust: chat_colors: self.chat_colors,
    // rust: model_customisation: self.file.model_customisation(),
    // rust: main_hand: i32::from(!self.main_hand_left),
    // rust: allows_listing: self.file.bool("allowServerListing"),
    // rust: particle_status: i32::from(self.particles),
    // rust: ..ClientInformation::new(view_distance)
}
}
    // The options file reflecting the typed fields; values the game did not
    // change keep their stored form.
to_file :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut f = self.file.clone();
    // rust: put_i(&mut f, "fov", self.fov as i32);
    // rust: put_i(&mut f, "renderDistance", self.render_distance);
    // rust: put_i(&mut f, "simulationDistance", self.simulation_distance);
    // rust: put_f(&mut f, "mouseSensitivity", self.sensitivity);
    // rust: for (i, source) in SOUND_SOURCES.iter().enumerate() {
    // rust: let v = if i == 0 {
    // rust: self.master_volume
    // rust: } else {
    // rust: self.volumes[i]
}
    // rust: put_f(&mut f, &format!("soundCategory_{source}"), v);
}
    // rust: put_s(&mut f, "soundDevice", &self.sound_device);
    // rust: put_i(&mut f, "guiScale", self.gui_scale as i32);
    // rust: put_b(&mut f, "bobView", self.view_bobbing);
    // rust: put_f(&mut f, "gamma", self.gamma);
    // rust: put_i(&mut f, "maxFps", self.max_fps as i32);
    // rust: put_b(&mut f, "enableVsync", self.vsync);
    // rust: put_b(&mut f, "fullscreen", self.fullscreen);
    // rust: put_b(&mut f, "ao", self.smooth_lighting);
    // rust: put_name(&mut f, "renderClouds", &self.clouds);
    // rust: put_i(&mut f, "cloudRange", self.cloud_range);
    // rust: put_i(&mut f, "particles", i32::from(self.particles));
    // rust: put_f(&mut f, "entityDistanceScaling", self.entity_distance);
    // rust: put_b(&mut f, "entityShadows", self.entity_shadows);
    // rust: put_i(&mut f, "biomeBlendRadius", self.biome_blend);
    // rust: put_name(&mut f, "graphicsPreset", &self.graphics_preset);
    // rust: put_i(&mut f, "mipmapLevels", self.mipmap_levels);
    // rust: put_i(&mut f, "weatherRadius", self.weather_radius);
    // rust: put_f(&mut f, "chunkSectionFadeInTime", self.chunk_fade);
    // rust: put_b(&mut f, "vignette", self.vignette);
    // rust: put_b(&mut f, "showAutosaveIndicator", self.autosave_indicator);
    // rust: put_b(&mut f, "cutoutLeaves", self.cutout_leaves);
    // rust: put_b(&mut f, "improvedTransparency", self.improved_transparency);
    // rust: put_i(&mut f, "attackIndicator", i32::from(self.attack_indicator));
    // rust: put_name(&mut f, "inactivityFpsLimit", &self.inactivity_fps_limit);
    // rust: put_i(
    // rust: &mut f,
    // rust: "prioritizeChunkUpdates",
    // rust: i32::from(self.prioritize_chunk_updates),
    // rust: );
    // rust: put_i(&mut f, "menuBackgroundBlurriness", self.menu_blur);
    // rust: put_b(&mut f, "invertXMouse", self.invert_x);
    // rust: put_b(&mut f, "invertYMouse", self.invert_y);
    // rust: put_f(
    // rust: &mut f,
    // rust: "mouseWheelSensitivity",
    // rust: self.mouse_wheel_sensitivity,
    // rust: );
    // rust: put_b(&mut f, "discrete_mouse_scroll", self.discrete_scroll);
    // rust: put_b(&mut f, "allowCursorChanges", self.allow_cursor_changes);
    // rust: put_b(&mut f, "toggleCrouch", self.toggle_crouch);
    // rust: put_b(&mut f, "toggleSprint", self.toggle_sprint);
    // rust: put_b(&mut f, "toggleAttack", self.toggle_attack);
    // rust: put_b(&mut f, "toggleUse", self.toggle_use);
    // rust: put_i(&mut f, "sprintWindow", self.sprint_window);
    // rust: put_b(&mut f, "operatorItemsTab", self.operator_items_tab);
    // rust: put_b(&mut f, "quitShortcuts", self.quit_shortcuts);
    // rust: put_b(
    // rust: &mut f,
    // rust: "ctrlClickEmulatesRightClick",
    // rust: self.ctrl_click_emulates_right_click,
    // rust: );
    // rust: put_b(&mut f, "autoJump", self.auto_jump);
    // rust: put_s(&mut f, "lang", &self.language);
    // rust: put_b(&mut f, "forceUnicodeFont", self.force_unicode);
    // rust: put_b(&mut f, "japaneseGlyphVariants", self.japanese_glyphs);
    // rust: put_i(&mut f, "chatVisibility", i32::from(self.chat_visibility));
    // rust: put_b(&mut f, "chatColors", self.chat_colors);
    // rust: put_b(&mut f, "chatLinks", self.chat_links);
    // rust: put_b(&mut f, "chatLinksPrompt", self.chat_links_prompt);
    // rust: put_f(&mut f, "chatOpacity", self.chat_opacity);
    // rust: if self.chat_delay != f.double("chatDelay") {
    // rust: f.set("chatDelay", V::Double(self.chat_delay));
}
    // rust: put_f(
    // rust: &mut f,
    // rust: "textBackgroundOpacity",
    // rust: self.text_background_opacity,
    // rust: );
    // rust: put_f(&mut f, "chatScale", self.chat_scale);
    // rust: put_f(&mut f, "chatWidth", self.chat_width);
    // rust: put_f(&mut f, "chatHeightFocused", self.chat_height_focused);
    // rust: put_f(&mut f, "chatHeightUnfocused", self.chat_height_unfocused);
    // rust: put_f(&mut f, "chatLineSpacing", self.chat_line_spacing);
    // rust: put_b(&mut f, "autoSuggestions", self.auto_suggestions);
    // rust: put_b(&mut f, "reducedDebugInfo", self.reduced_debug_info);
    // rust: put_b(&mut f, "highContrast", self.high_contrast);
    // rust: put_b(&mut f, "showSubtitles", self.show_subtitles);
    // rust: put_f(
    // rust: &mut f,
    // rust: "notificationDisplayTime",
    // rust: self.notification_display_time,
    // rust: );
    // rust: put_name(
    // rust: &mut f,
    // rust: "mainHand",
    // rust: if self.main_hand_left { "left" } else { "right" },
    // rust: );
    // rust: if self.resource_packs != f.list("resourcePacks") {
    // rust: f.set("resourcePacks", V::List(self.resource_packs.clone()));
}
    // rust: for (name, key) in self.keys.saved() {
    // rust: put_s(&mut f, &format!("key_{name}"), &key);
}
    // rust: f
}
    // These settings with one `options.txt` value changed (`horizon-ctl
    // options-set`, as `OptionsFile::set_text` reads it). Horizon's own
    // files (graphics, controller, extras, the mod list) aren't in
    // `options.txt`, so they stay as they are, as do the monitor's video modes.
with_option :: proc(self: ^Self, key: string, value: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut file = self.to_file();
    // rust: file.set_text(key, value)?;
    // rust: let mut next = Self {
    // rust: horizon: self.horizon.clone(),
    // rust: controller: self.controller.clone(),
    // rust: extras: self.extras.clone(),
    // rust: mods: self.mods.clone(),
    // rust: video_modes: self.video_modes.clone(),
    // rust: ..Self::from_file(file)
}
        // Horizon's own bindings aren't in options.txt.
    // rust: next.keys.set("key.emote", self.keys.get("key.emote"));
    // rust: Ok(next)
}
    // The `options.txt` text (Options.save).
serialize :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.to_file().serialize()
}
save :: proc(self: ^Self, path: ^Path) {
}
    // rust: self.describe_for_crashes();
    // rust: if let Err(e) = fs::write(path, self.serialize()) {
    // rust: log::warn!("Horizon: options.txt is not saved: {e}");
}
    // rust: if let Some(dir) = path.parent() {
    // rust: self.horizon.save(dir);
    // rust: self.controller.save(dir);
    // rust: let mut extras = self.extras.clone();
    // rust: extras.emote_key = self.keys.get("key.emote").to_owned();
    // rust: extras.save(dir);
    // rust: self.mods.save(&crate::logging::shared_dir(dir));
}
}
    // Volume of a sound source (master excluded).
volume :: proc(self: ^Self, source: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: SOUND_SOURCES
    // rust: .iter()
    // rust: .position(|n| *n == source)
    // rust: .map_or(1.0, |i| {
    // rust: if i == 0 {
    // rust: self.master_volume
    // rust: } else {
    // rust: self.volumes[i]
}
    // rust: })
}
    // `Options.getFinalSoundSourceVolume`: a source's volume times master's.
final_volume :: proc(self: ^Self, source: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if source == "master" {
    // rust: self.master_volume
    // rust: } else {
    // rust: self.volume(source) * self.master_volume
}
}
    // `Options.narrator`: the `narrator` id in options.txt.
narrator :: proc(self: ^Self) -> h {
    // Ported from Horizon
    return {}
}
    // rust: horizon_narrator::Status::by_id(self.file.int("narrator"))
}
set_narrator :: proc(self: ^Self, status: horizon_narrator::Status) {
}
    // rust: self.file
    // rust: .set("narrator", crate::options_file::V::Int(status.id()));
}
    // `Options.getBackgroundColor(float)`: the text backdrop colour, `default`
    // opacity unless `backgroundForChatOnly` is off.
text_background :: proc(self: ^Self, default: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: crate::hud_layout::background_color(
    // rust: self.file.bool("backgroundForChatOnly"),
    // rust: f64::from(self.text_background_opacity),
    // rust: default,
    // rust: )
}
chat_options :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
    // rust: crate::chat::ChatOptions {
    // rust: opacity: f64::from(self.chat_opacity),
    // rust: background_opacity: f64::from(self.text_background_opacity),
    // rust: scale: f64::from(self.chat_scale),
    // rust: width: f64::from(self.chat_width),
    // rust: height_focused: f64::from(self.chat_height_focused),
    // rust: height_unfocused: f64::from(self.chat_height_unfocused),
    // rust: line_spacing: f64::from(self.chat_line_spacing),
    // rust: colors: self.chat_colors,
}
}
}

// One option instance.
Opt :: enum {
    Fov,
    RenderDistance,
    SimulationDistance,
    Sensitivity,
    WheelSensitivity,
    DiscreteScroll,
    InvertX,
    InvertY,
    AllowCursorChanges,
    Volume(usize),
    SoundDevice,
    GuiScale,
    ViewBobbing,
    Gamma,
    MaxFps,
    Vsync,
    Fullscreen,
    SmoothLighting,
    Clouds,
    CloudRange,
    Particles,
    EntityDistance,
    EntityShadows,
    BiomeBlend,
    Preset,
    Mipmaps,
    WeatherRadius,
    ChunkFade,
    Vignette,
    Autosave,
    CutoutLeaves,
    ImprovedTransparency,
    AttackIndicator,
    InactivityFps,
    ChunkBuilder,
    MenuBlur,
    ToggleCrouch,
    ToggleSprint,
    ToggleAttack,
    ToggleUse,
    AutoJump,
    SprintWindow,
    QuitShortcuts,
    CtrlClickEmulatesRightClick,
    OperatorItemsTab,
    ChatVisibility,
    ChatColors,
    ChatLinks,
    ChatLinksPrompt,
    ChatOpacity,
    TextBackgroundOpacity,
    ChatScale,
    ChatWidth,
    ChatHeightFocused,
    ChatHeightUnfocused,
    ChatLineSpacing,
    AutoSuggestions,
    HideMatchedNames,
    ReducedDebugInfo,
    OnlySecureChat,
    SaveChatDrafts,
    HighContrast,
    ShowSubtitles,
    MusicFrequency,
    NotificationDisplayTime,
    Narrator,
    TextBackground,
    ChatDelay,
    DistortionEffects,
    FovEffects,
    DarknessPulsing,
    DamageTilt,
    GlintSpeed,
    GlintStrength,
    HideLightningFlashes,
    MonochromeLogo,
    PanoramaSpeed,
    HideSplashTexts,
    NarratorHotkey,
    RotateWithMinecarts,
    HighContrastBlockOutlines,
    ForceUnicode,
    JapaneseGlyphs,
    // Horizon's controller settings (`horizon-controller.txt`).
    PadEnabled,
    PadVibration,
    PadAdaptiveTriggers,
    PadLightbar,
    PadLookSensitivity,
    PadPointerSpeed,
    PadScrollSpeed,
    PadRepeatDelay,
    PadRepeatInterval,
    PadInvertX,
    PadInvertY,
    PadToggleSneak,
    PadMoveDeadzone,
    PadLookDeadzone,
    PadTriggerThreshold,
    PadGlyphs,
    PadKeyboard,
    // `options.modelPart.*`: one skin layer (index into `options_file::MODEL_PARTS`).
    ModelPart(usize),
    // 3D skin layers: the player's outer layer as extruded slabs.
    SkinLayers3d,
    MainHand,
    AllowServerListing,
    RealmsNotifications,
    InGameNotification,
    SharePresence,
    DirectionalAudio,
    MusicToast,
    // `Options.exclusiveFullscreen`.
    ExclusiveFullscreen,
    // VideoSettingsScreen's "Exclusive Fullscreen Mode": the monitor's mode to take.
    ExclusiveMode,
    // `Options.preferredGraphicsBackend`.
    GraphicsBackend,
    // `Options.textureFiltering`.
    TextureFiltering,
    // `Options.maxAnisotropyBit`.
    MaxAnisotropy,
}

    // rust: mod tests {
//     use super::*;
the_narrator_reads_its_status_and_the_voice_under_master :: proc() {
}
    // rust: let s = Settings::parse("narrator:2\nsoundCategory_master:0.5\nsoundCategory_voice:0.5\n");
    // rust: assert_eq!(s.narrator(), horizon_narrator::Status::Chat);
    // rust: assert_eq!(s.final_volume("voice"), 0.25);
    // rust: assert_eq!(s.final_volume("master"), 0.5);
    // rust: let mut s = s;
    // rust: s.set_narrator(horizon_narrator::Status::Off);
    // rust: assert_eq!(
    // rust: Settings::parse(&s.serialize()).narrator(),
    // rust: horizon_narrator::Status::Off
    // rust: );
}
    // `Monster.getSoundSource`: the verified families and inherited common sounds.
hostile_families_keep_their_sound_category :: proc() {
}
    // rust: for (event, source) in [
    // rust: ("entity.zombie.hurt", 5),
    // rust: ("entity.cow.hurt", 6),
    // rust: ("block.stone.break", 4),
    // rust: ("entity.player.hurt", 7),
    // rust: ("entity.arrow.hit", 7),
    // rust: ("music_disc.13", 2),
    // rust: ("item.goat_horn.sound.0", 2),
    // rust: ("weather.rain", 3),
    // rust: ("ambient.cave", 8),
    // rust: ] {
    // rust: assert_eq!(sound_source(event), source, "{event}");
}
        // Explicit sources still take precedence, including H331's arrow route.
    // rust: let mut audio = crate::audio::Audio::silent(Path::new("/nonexistent/h068-audio"));
    // rust: audio.capture = Some(Vec::new());
    // rust: audio.play_on(6, "minecraft:entity.arrow.hit", Some([1.0; 3]), 1.0, 1.0);
    // rust: audio.play_on(4, "minecraft:entity.warden.hurt", Some([1.0; 3]), 1.0, 1.0);
    // rust: assert_eq!(
    // rust: audio
    // rust: .capture
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|s| s.source)
    // rust: .collect::<Vec<_>>(),
    // rust: [6, 4]
    // rust: );
    // rust: for family in [
    // rust: "bogged",
    // rust: "breeze",
    // rust: "endermite",
    // rust: "parched",
    // rust: "warden",
    // rust: "zombie_villager",
    // rust: "vex",
    // rust: "wither",
    // rust: "hostile",
    // rust: ] {
    // rust: for suffix in ["hurt", "death"] {
    // rust: for prefix in ["", "minecraft:"] {
    // rust: let event = format!("{prefix}entity.{family}.{suffix}");
    // rust: assert_eq!(sound_source(&event), 5, "{event}");
}
}
}
}

three_d_skin_layers_move_from_options_txt_to_the_extras_file :: proc() {
}
        // #8091 wrote the switch into options.txt; a player who had it on keeps
        // it, and the next options.txt is vanilla's again.
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-skin-layers-{}-{:?}",
    // rust: std::process::id(),
    // rust: std::thread::current().id()
    // rust: ));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: fs::write(dir.join("options.txt"), "fov:0.5\nthreeDSkinLayers:true\n").unwrap();
    // rust: let s = Settings::load(&dir.join("options.txt"));
    // rust: assert!(s.extras.three_d_skin_layers);
    // rust: assert_eq!(s.fov, 90.0);
    // rust: assert!(!s.serialize().contains("threeDSkinLayers"));
    // rust: assert!(crate::extras::Extras::parse(&s.extras.serialize()).three_d_skin_layers);
        // Once horizon-extras.txt has its own line, a stale options.txt one is ignored.
    // rust: fs::write(dir.join(crate::extras::FILE), "threeDSkinLayers:false\n").unwrap();
    // rust: assert!(
    // rust: !Settings::load(&dir.join("options.txt"))
    // rust: .extras
    // rust: .three_d_skin_layers
    // rust: );
    // rust: let _ = fs::remove_dir_all(&dir);
}
scratch :: proc(name: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-{name}-{}-{:?}",
    // rust: std::process::id(),
    // rust: std::thread::current().id()
    // rust: ));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

options_txt_lists_only_vanillas_key_mappings :: proc() {
}
        // Options.keyMappings has the friends key, then social interactions; Horizon's emote key
        // (#10092 put it between them) is not in the file.
    // rust: let out = Settings::default().serialize();
    // rust: assert!(!out.contains("emote"), "{out}");
    // rust: assert!(out.contains(
    // rust: "\nkey_key.friends:key.keyboard.o\nkey_key.socialInteractions:key.keyboard.p\n"
    // rust: ));
    // rust: let mut s = Settings::default();
    // rust: s.keys.set("key.emote", "key.keyboard.g");
    // rust: assert!(!s.serialize().contains("emote"));
}

the_emote_key_is_kept_in_the_extras_file :: proc() {
}
    // rust: let dir = scratch("emote-key");
    // rust: let options = dir.join("options.txt");
        // Untouched: no extras file is made for it.
    // rust: Settings::default().save(&options);
    // rust: assert!(!dir.join(crate::extras::FILE).exists());
    // rust: assert_eq!(
    // rust: Settings::load(&options).keys.get("key.emote"),
    // rust: "key.keyboard.b"
    // rust: );
        // Rebound in Controls: saved to horizon-extras.txt, and options.txt stays vanilla's.
    // rust: let mut s = Settings::load(&options);
    // rust: s.keys.set("key.emote", "key.keyboard.g");
    // rust: s.save(&options);
    // rust: assert!(!fs::read_to_string(&options).unwrap().contains("emote"));
    // rust: let extras = fs::read_to_string(dir.join(crate::extras::FILE)).unwrap();
    // rust: assert!(
    // rust: extras.lines().any(|l| l == "emoteKey:key.keyboard.g"),
    // rust: "{extras}"
    // rust: );
    // rust: let back = Settings::load(&options);
    // rust: assert_eq!(back.keys.get("key.emote"), "key.keyboard.g");
        // horizon-ctl options-set rebuilds from options.txt text and keeps it.
    // rust: assert_eq!(
    // rust: back.with_option("fov", "90").unwrap().keys.get("key.emote"),
    // rust: "key.keyboard.g"
    // rust: );
        // Reset to B and back to the default: the file says so.
    // rust: let mut s = back;
    // rust: s.keys.set(
    // rust: "key.emote",
    // rust: crate::keybinds::KeyBinds::default_of("key.emote"),
    // rust: );
    // rust: s.save(&options);
    // rust: assert_eq!(
    // rust: Settings::load(&options).keys.get("key.emote"),
    // rust: "key.keyboard.b"
    // rust: );
    // rust: let _ = fs::remove_dir_all(&dir);
}

the_emote_key_moves_from_options_txt_to_the_extras_file :: proc() {
}
        // #10092 wrote `key_key.emote` into options.txt; a rebound key is kept, the next
        // options.txt is vanilla's again.
    // rust: let dir = scratch("emote-key-move");
    // rust: let options = dir.join("options.txt");
    // rust: fs::write(
    // rust: &options,
    // rust: "version:4000\nfov:0.5\nkey_key.emote:key.keyboard.h\nkey_key.jump:key.keyboard.j\n",
    // rust: )
    // rust: .unwrap();
    // rust: let s = Settings::load(&options);
    // rust: assert_eq!(s.keys.get("key.emote"), "key.keyboard.h");
    // rust: assert_eq!(s.keys.get("key.jump"), "key.keyboard.j");
    // rust: s.save(&options);
    // rust: assert!(!fs::read_to_string(&options).unwrap().contains("emote"));
    // rust: assert_eq!(
    // rust: Settings::load(&options).keys.get("key.emote"),
    // rust: "key.keyboard.h"
    // rust: );
        // Once horizon-extras.txt has its own line, a stale options.txt one is ignored.
    // rust: fs::write(dir.join(crate::extras::FILE), "emoteKey:key.keyboard.k\n").unwrap();
    // rust: fs::write(&options, "version:4000\nkey_key.emote:key.keyboard.h\n").unwrap();
    // rust: assert_eq!(
    // rust: Settings::load(&options).keys.get("key.emote"),
    // rust: "key.keyboard.k"
    // rust: );
        // A value that is no key is not adopted; an unbound emote key is.
    // rust: fs::remove_file(dir.join(crate::extras::FILE)).unwrap();
    // rust: fs::write(&options, "version:4000\nkey_key.emote:banana\n").unwrap();
    // rust: assert_eq!(
    // rust: Settings::load(&options).keys.get("key.emote"),
    // rust: "key.keyboard.b"
    // rust: );
    // rust: fs::write(
    // rust: &options,
    // rust: "version:4000\nkey_key.emote:key.keyboard.unknown\n",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: Settings::load(&options).keys.get("key.emote"),
    // rust: "key.keyboard.unknown"
    // rust: );
    // rust: let _ = fs::remove_dir_all(&dir);
}

an_option_set_keeps_horizon_files :: proc() {
}
    // rust: let mut s = Settings::parse("fov:70\n");
    // rust: s.mods.enabled.insert("zoom".into());
    // rust: s.extras.minimap = true;
    // rust: s.horizon.fog = !s.horizon.fog;
    // rust: s.controller.vibration = !s.controller.vibration;
    // rust: let set = s.with_option("fov", "90").unwrap();
    // rust: assert_eq!(set.fov, 90.0);
    // rust: assert_eq!(set.mods, s.mods);
    // rust: assert_eq!(set.extras, s.extras);
    // rust: assert_eq!(set.horizon, s.horizon);
    // rust: assert_eq!(set.controller, s.controller);
    // rust: assert!(s.with_option("fov", "200").is_err());
}
gui_scale_survives_temporary_small_framebuffer :: proc() {
}
    // rust: for requested in [0, 1, 2, 6] {
    // rust: let settings = Settings::parse(&format!("guiScale:{requested}\n"));
            // Hyprland's initial surface can be smaller than the fullscreen one.
    // rust: for (framebuffer, maximum) in [([715, 860], 2), ([3400, 1913], 7)] {
    // rust: let effective = crate::window::calculate_scale(
    // rust: framebuffer,
    // rust: settings.gui_scale as i32,
    // rust: settings.force_unicode,
    // rust: );
    // rust: assert_eq!(
    // rust: effective,
    // rust: if requested == 0 {
    // rust: maximum
    // rust: } else {
    // rust: (requested as i32).min(maximum)
}
    // rust: );
    // rust: let saved = Settings::parse(&settings.serialize());
    // rust: assert_eq!(saved.gui_scale, requested);
}
}
}

round_trips_vanilla_options_txt :: proc() {
}
    // rust: let text = "version:4000\nfov:0.5\nrenderDistance:16\nmaxFps:260\nrenderClouds:\"fast\"\nkey_key.jump:key.keyboard.j\nsoundCategory_music:0.25\nresourcePacks:[\"vanilla\",\"file/x.zip\"]\nlang:fr_fr\nsomeFutureOption:42\n";
    // rust: let s = Settings::parse(text);
    // rust: assert_eq!(s.fov, 90.0);
    // rust: assert_eq!(s.render_distance, 16);
    // rust: assert_eq!(s.max_fps, 260);
    // rust: assert_eq!(s.clouds, "fast");
    // rust: assert_eq!(s.keys.get("key.jump"), "key.keyboard.j");
    // rust: assert_eq!(s.volume("music"), 0.25);
    // rust: assert_eq!(s.resource_packs, ["vanilla", "file/x.zip"]);
    // rust: assert_eq!(s.language, "fr_fr");
    // rust: let out = s.serialize();
    // rust: assert!(out.starts_with("version:"));
    // rust: assert!(out.contains("\nkey_key.jump:key.keyboard.j\n"));
        // Options.save writes only the options it knows.
    // rust: assert!(!out.contains("someFutureOption"));
    // rust: assert!(out.contains("\nrenderClouds:\"fast\"\n"));
    // rust: let again = Settings::parse(&out);
    // rust: assert_eq!(again.fov, 90.0);
    // rust: assert_eq!(again.keys.get("key.jump"), "key.keyboard.j");
}
client_information_maps_the_stored_main_hand :: proc() {
}
        // The Skin Customization option is stored by name; ClientInformation
        // sends HumanoidArm (LEFT = 0, RIGHT = 1).
    // rust: for (stored, arm) in [("left", 0), ("right", 1)] {
    // rust: let s = Settings::parse(&format!("mainHand:{stored}\n"));
    // rust: assert_eq!(s.client_information(10).main_hand, arm);
    // rust: assert!(s.serialize().contains(&format!("mainHand:\"{stored}\"")));
}
    // rust: assert_eq!(Settings::default().client_information(10).main_hand, 1);
}
no_options_txt_paces_frames_like_an_empty_one :: proc() {
}
    // rust: let (fresh, empty) = (Settings::default(), Settings::parse(""));
    // rust: assert_eq!(fresh.max_fps, 120);
    // rust: assert_eq!(fresh.max_fps, empty.max_fps);
    // rust: assert_eq!(fresh.vsync, empty.vsync);
    // rust: assert_eq!(fresh.inactivity_fps_limit, empty.inactivity_fps_limit);
    // rust: assert_eq!(fresh.render_distance, empty.render_distance);
    // rust: assert_eq!(fresh.simulation_distance, empty.simulation_distance);
}
subtitle_options :: proc() {
}
    // rust: let s = Settings::parse("showSubtitles:true\nnotificationDisplayTime:2.5\n");
    // rust: assert!(s.show_subtitles);
    // rust: assert_eq!(s.notification_display_time, 2.5);
    // rust: let again = Settings::parse(&s.serialize());
    // rust: assert!(again.show_subtitles);
    // rust: assert_eq!(again.notification_display_time, 2.5);
    // rust: let d = Settings::parse("");
    // rust: assert!(!d.show_subtitles);
    // rust: assert_eq!(d.notification_display_time, 1.0);
        // Codec.doubleRange(0.5, 10.0) rejects other values; the default stays.
    // rust: assert_eq!(
    // rust: Settings::parse("notificationDisplayTime:50\n").notification_display_time,
    // rust: 1.0
    // rust: );
}
sound_device_option :: proc() {
}
    // rust: let s = Settings::parse("soundDevice:\"Headphones\"\n");
    // rust: assert_eq!(s.sound_device, "Headphones");
    // rust: let serialized = s.serialize();
    // rust: assert!(serialized.contains("soundDevice:\"Headphones\""));
    // rust: let again = Settings::parse(&serialized);
    // rust: assert_eq!(again.sound_device, "Headphones");
    // rust: let empty = Settings::parse("");
    // rust: assert_eq!(empty.sound_device, "");
}
}
