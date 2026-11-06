//! Transpiled from Horizon Rust crate
package horizon_client_render_options_ui

import "core:fmt"
import "core:mem"
import "core:math"

// The options screens: OptionsScreen, Video Settings, Music & Sounds,
// Controls, Key Binds, Mouse Settings, Chat Settings, Accessibility,
// Language and Resource Packs, laid out like vanilla's HeaderAndFooter /
// OptionsList screens and drawn with the shared widgets.
// use std::time::Instant;

    // rust: pub use crate::settings::Opt;

// use crate::{
    // rust: gamepad::{self, GlyphStyle},
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: keybinds::{self, CATEGORIES, KeyBinds, all_mappings},
    // rust: lang::{self, LanguageInfo},
    // rust: settings::{SOUND_SOURCES, Settings},
    // rust: text::{self, Style, Text},
    // rust: ui,
}

tr :: proc(key: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(key, &[])
}
generic :: proc(caption: string, value: Text) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate("options.generic_value", &[tr(caption), value])
}
percent :: proc(caption: string, value: f32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(
    // rust: "options.percent_value",
    // rust: &[
    // rust: tr(caption),
    // rust: Text::literal(((f64::from(value) * 100.0) as i32).to_string()),
    // rust: ],
    // rust: )
}
// `text` cut into lines of at most `width` characters, at spaces where it has them.
wrap :: proc(text: string, width: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut lines = Vec::new();
    // rust: let mut line = String::new();
    // rust: for word in text.split_whitespace() {
    // rust: let len = line.chars().count();
    // rust: if len > 0 && len + 1 + word.chars().count() > width {
    // rust: lines.push(std::mem::take(&mut line));
}
    // rust: if !line.is_empty() {
    // rust: line.push(' ');
}
    // rust: line.push_str(word);
    // rust: while line.chars().count() > width {
    // rust: let rest: String = line.chars().skip(width).collect();
    // rust: line = line.chars().take(width).collect();
    // rust: lines.push(std::mem::replace(&mut line, rest));
}
}
    // rust: if !line.is_empty() {
    // rust: lines.push(line);
}
    // rust: lines
}
on_off :: proc(v: bool) -> T {
    // Ported from Horizon
    return {}
}
    // rust: tr(if v { "options.on" } else { "options.off" })
}
// A music track's name as its row shows it: the file, without its folder
// (`minecraft:music/game/calm1` -> `calm1`; the group names the situation).
track_name :: proc(id: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: id.rsplit('/').next().unwrap_or(id)
}
chat_px :: proc(caption: string, px: f32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate(
    // rust: "options.pixel_value",
    // rust: &[tr(caption), Text::literal((px as i32).to_string())],
    // rust: )
}
    // rust: pub(crate) enum Kind {
    // Slider position 0..1.
    // rust: Slider(f32),
    // rust: Cycle,
}
// `PlayerModelPart` keys, in vanilla's bit order (`modelPart_*` in options.txt).
    // rust: const MODEL_PART_KEYS: [&str; 7] = [
    // rust: "modelPart_cape",
    // rust: "modelPart_jacket",
    // rust: "modelPart_left_sleeve",
    // rust: "modelPart_right_sleeve",
    // rust: "modelPart_left_pants_leg",
    // rust: "modelPart_right_pants_leg",
    // rust: "modelPart_hat",
    // rust: ];
// The Accessibility Settings page:
// `AccessibilityOptionsScreen.options`, with the Controls link inserted separately.
    // rust: pub(crate) const ACCESSIBILITY_OPTIONS: &[Opt] = &[
    // rust: Opt::Narrator,
    // rust: Opt::ShowSubtitles,
    // rust: Opt::HighContrast,
    // rust: Opt::MenuBlur,
    // rust: Opt::TextBackgroundOpacity,
    // rust: Opt::TextBackground,
    // rust: Opt::ChatOpacity,
    // rust: Opt::ChatLineSpacing,
    // rust: Opt::ChatDelay,
    // rust: Opt::NotificationDisplayTime,
    // rust: Opt::ViewBobbing,
    // rust: Opt::DistortionEffects,
    // rust: Opt::FovEffects,
    // rust: Opt::DarknessPulsing,
    // rust: Opt::DamageTilt,
    // rust: Opt::GlintSpeed,
    // rust: Opt::GlintStrength,
    // rust: Opt::HideLightningFlashes,
    // rust: Opt::MonochromeLogo,
    // rust: Opt::PanoramaSpeed,
    // rust: Opt::HideSplashTexts,
    // rust: Opt::NarratorHotkey,
    // rust: Opt::RotateWithMinecarts,
    // rust: Opt::HighContrastBlockOutlines,
    // rust: ];

// `ControlsScreen.options`: the controls added by Java Edition 26.3, in
// their vanilla order. The macOS-only Control-click switch is omitted on
// other platforms just as `InputQuirks.EMULATE_RIGHT_CLICK_WITH_CTRL_KEY`
// does in Java.
    // rust: pub(crate) fn vanilla_control_options() -> Vec<Opt> {
    // rust: let mut options = vec![
    // rust: Opt::ToggleCrouch,
    // rust: Opt::ToggleSprint,
    // rust: Opt::ToggleAttack,
    // rust: Opt::ToggleUse,
    // rust: Opt::AutoJump,
    // rust: Opt::SprintWindow,
    // rust: Opt::QuitShortcuts,
    // rust: ];
    // rust: if cfg!(target_os = "macos") {
    // rust: options.push(Opt::CtrlClickEmulatesRightClick);
}
    // rust: options.push(Opt::OperatorItemsTab);
    // rust: options
}

// `MouseSettingsScreen.options` in Java Edition 26.3, in vanilla order.
    // rust: pub(crate) const MOUSE_OPTIONS: &[Opt] = &[
    // rust: Opt::Sensitivity,
    // rust: Opt::WheelSensitivity,
    // rust: Opt::DiscreteScroll,
    // rust: Opt::InvertX,
    // rust: Opt::InvertY,
    // rust: Opt::AllowCursorChanges,
    // rust: ];

    // rust: impl Opt {
    // Keep controls visible while their underlying systems are still missing.
    // rust: pub(crate) fn available(self) -> bool {
    // rust: !matches!(
    // rust: self,
            // Stored, but there are no blocked players or signed chat yet.
    // rust: Opt::HideMatchedNames
    // rust: | Opt::OnlySecureChat
                // Saved, but no Horizon system reads them yet: no Realms, no
                // friends list, no directional audio.
    // rust: | Opt::RealmsNotifications
    // rust: | Opt::InGameNotification
    // rust: | Opt::SharePresence
    // rust: | Opt::DirectionalAudio
                // Saved, but nothing in rendering reads it yet.
    // rust: | Opt::ChunkBuilder
    // rust: )
}
file_key :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match self {
    // rust: Opt::Narrator => "narrator",
    // rust: Opt::TextBackground => "backgroundForChatOnly",
    // rust: Opt::ChatDelay => "chatDelay",
    // rust: Opt::HideMatchedNames => "hideMatchedNames",
    // rust: Opt::OnlySecureChat => "onlyShowSecureChat",
    // rust: Opt::SaveChatDrafts => "saveChatDrafts",
    // rust: Opt::DistortionEffects => "screenEffectScale",
    // rust: Opt::FovEffects => "fovEffectScale",
    // rust: Opt::DarknessPulsing => "darknessEffectScale",
    // rust: Opt::DamageTilt => "damageTiltStrength",
    // rust: Opt::GlintSpeed => "glintSpeed",
    // rust: Opt::GlintStrength => "glintStrength",
    // rust: Opt::HideLightningFlashes => "hideLightningFlashes",
    // rust: Opt::MonochromeLogo => "darkMojangStudiosBackground",
    // rust: Opt::PanoramaSpeed => "panoramaScrollSpeed",
    // rust: Opt::HideSplashTexts => "hideSplashTexts",
    // rust: Opt::NarratorHotkey => "narratorHotkey",
    // rust: Opt::RotateWithMinecarts => "rotateWithMinecart",
    // rust: Opt::HighContrastBlockOutlines => "highContrastBlockOutline",
    // rust: Opt::MusicFrequency => "musicFrequency",
    // rust: Opt::SoundDevice => "soundDevice",
    // rust: Opt::OperatorItemsTab => "operatorItemsTab",
    // rust: Opt::QuitShortcuts => "quitShortcuts",
    // rust: Opt::CtrlClickEmulatesRightClick => "ctrlClickEmulatesRightClick",
    // rust: Opt::ModelPart(i) => MODEL_PART_KEYS[i],
    // rust: Opt::AllowServerListing => "allowServerListing",
    // rust: Opt::RealmsNotifications => "realmsNotifications",
    // rust: Opt::InGameNotification => "inGameNotification",
    // rust: Opt::SharePresence => "sharePresence",
    // rust: Opt::DirectionalAudio => "directionalAudio",
    // rust: Opt::MusicToast => "musicToast",
    // rust: _ => return None,
    // rust: })
}

    // rust: pub(crate) fn caption(self) -> &'static str {
    // rust: match self {
    // rust: Opt::Fov => "options.fov",
    // rust: Opt::RenderDistance => "options.renderDistance",
    // rust: Opt::SimulationDistance => "options.simulationDistance",
    // rust: Opt::Sensitivity => "options.sensitivity",
    // rust: Opt::WheelSensitivity => "options.mouseWheelSensitivity",
    // rust: Opt::InvertX => "options.invertMouseX",
    // rust: Opt::InvertY => "options.invertMouseY",
    // rust: Opt::DiscreteScroll => "options.discrete_mouse_scroll",
    // rust: Opt::AllowCursorChanges => "options.allowCursorChanges",
    // rust: Opt::Volume(_) => "soundCategory.master",
    // rust: Opt::SoundDevice => "options.audioDevice",
    // rust: Opt::GuiScale => "options.guiScale",
    // rust: Opt::ViewBobbing => "options.viewBobbing",
    // rust: Opt::Gamma => "options.gamma",
    // rust: Opt::MaxFps => "options.framerateLimit",
    // rust: Opt::Vsync => "options.vsync",
    // rust: Opt::Fullscreen => "options.fullscreen",
    // rust: Opt::ExclusiveFullscreen => "options.exclusiveFullscreen",
    // rust: Opt::ExclusiveMode => "options.fullscreen.exclusive.mode",
    // rust: Opt::GraphicsBackend => "options.graphicsApi",
    // rust: Opt::TextureFiltering => "options.textureFiltering",
    // rust: Opt::MaxAnisotropy => "options.maxAnisotropy",
    // rust: Opt::SmoothLighting => "options.ao",
    // rust: Opt::Clouds => "options.renderClouds",
    // rust: Opt::CloudRange => "options.renderCloudsDistance",
    // rust: Opt::Particles => "options.particles",
    // rust: Opt::EntityDistance => "options.entityDistanceScaling",
    // rust: Opt::EntityShadows => "options.entityShadows",
    // rust: Opt::BiomeBlend => "options.biomeBlendRadius",
    // rust: Opt::Preset => "options.graphics.preset",
    // rust: Opt::Mipmaps => "options.mipmapLevels",
    // rust: Opt::WeatherRadius => "options.weatherRadius",
    // rust: Opt::ChunkFade => "options.chunkFade",
    // rust: Opt::Vignette => "options.vignette",
    // rust: Opt::Autosave => "options.autosaveIndicator",
    // rust: Opt::CutoutLeaves => "options.cutoutLeaves",
    // rust: Opt::ImprovedTransparency => "options.improvedTransparency",
    // rust: Opt::AttackIndicator => "options.attackIndicator",
    // rust: Opt::InactivityFps => "options.inactivityFpsLimit",
    // rust: Opt::ChunkBuilder => "options.prioritizeChunkUpdates",
    // rust: Opt::MenuBlur => "options.accessibility.menu_background_blurriness",
    // rust: Opt::ToggleCrouch => "key.sneak",
    // rust: Opt::ToggleSprint => "key.sprint",
    // rust: Opt::ToggleAttack => "key.attack",
    // rust: Opt::ToggleUse => "key.use",
    // rust: Opt::AutoJump => "options.autoJump",
    // rust: Opt::SprintWindow => "options.sprintWindow",
    // rust: Opt::QuitShortcuts => "options.quitShortcuts",
    // rust: Opt::CtrlClickEmulatesRightClick => "options.ctrlClickEmulatesRightClick",
    // rust: Opt::OperatorItemsTab => "options.operatorItemsTab",
    // rust: Opt::ChatVisibility => "options.chat.visibility",
    // rust: Opt::ChatColors => "options.chat.color",
    // rust: Opt::ChatLinks => "options.chat.links",
    // rust: Opt::ChatLinksPrompt => "options.chat.links.prompt",
    // rust: Opt::ChatOpacity => "options.chat.opacity",
    // rust: Opt::TextBackgroundOpacity => "options.accessibility.text_background_opacity",
    // rust: Opt::ChatScale => "options.chat.scale",
    // rust: Opt::ChatWidth => "options.chat.width",
    // rust: Opt::ChatHeightFocused => "options.chat.height.focused",
    // rust: Opt::ChatHeightUnfocused => "options.chat.height.unfocused",
    // rust: Opt::ChatLineSpacing => "options.chat.line_spacing",
    // rust: Opt::AutoSuggestions => "options.autoSuggestCommands",
    // rust: Opt::HideMatchedNames => "options.hideMatchedNames",
    // rust: Opt::OnlySecureChat => "options.onlyShowSecureChat",
    // rust: Opt::SaveChatDrafts => "options.chat.drafts",
    // rust: Opt::ReducedDebugInfo => "options.reducedDebugInfo",
    // rust: Opt::HighContrast => "options.accessibility.high_contrast",
    // rust: Opt::ShowSubtitles => "options.showSubtitles",
    // rust: Opt::MusicFrequency => "options.music_frequency",
    // rust: Opt::NotificationDisplayTime => "options.notifications.display_time",
    // rust: Opt::Narrator => "options.narrator",
    // rust: Opt::TextBackground => "options.accessibility.text_background",
    // rust: Opt::ChatDelay => "horizon.options.chat_delay",
    // rust: Opt::DistortionEffects => "options.screenEffectScale",
    // rust: Opt::FovEffects => "options.fovEffectScale",
    // rust: Opt::DarknessPulsing => "options.darknessEffectScale",
    // rust: Opt::DamageTilt => "options.damageTiltStrength",
    // rust: Opt::GlintSpeed => "options.glintSpeed",
    // rust: Opt::GlintStrength => "options.glintStrength",
    // rust: Opt::HideLightningFlashes => "options.hideLightningFlashes",
    // rust: Opt::MonochromeLogo => "options.darkMojangStudiosBackgroundColor",
    // rust: Opt::PanoramaSpeed => "options.accessibility.panorama_speed",
    // rust: Opt::HideSplashTexts => "options.hideSplashTexts",
    // rust: Opt::NarratorHotkey => "options.accessibility.narrator_hotkey",
    // rust: Opt::RotateWithMinecarts => "options.rotateWithMinecart",
    // rust: Opt::HighContrastBlockOutlines => "options.accessibility.high_contrast_block_outline",
    // rust: Opt::ForceUnicode => "options.forceUnicodeFont",
    // rust: Opt::JapaneseGlyphs => "options.japaneseGlyphVariants",
            // Horizon's own options: vanilla has no keys for them, so they read
            // the namespace the client bundles (assets/horizon/lang).
    // rust: Opt::PadEnabled => "horizon.options.controller",
    // rust: Opt::PadVibration => "horizon.options.vibration",
    // rust: Opt::PadAdaptiveTriggers => "horizon.options.adaptive_triggers",
    // rust: Opt::PadLightbar => "horizon.options.lightbar",
    // rust: Opt::PadLookSensitivity => "horizon.options.look_sensitivity",
    // rust: Opt::PadPointerSpeed => "horizon.options.pointer_speed",
    // rust: Opt::PadScrollSpeed => "horizon.options.scroll_speed",
    // rust: Opt::PadRepeatDelay => "horizon.options.repeat_delay",
    // rust: Opt::PadRepeatInterval => "horizon.options.repeat_interval",
    // rust: Opt::PadInvertX => "horizon.options.invert_x",
    // rust: Opt::PadInvertY => "horizon.options.invert_y",
    // rust: Opt::PadToggleSneak => "horizon.options.sneak_button",
    // rust: Opt::PadMoveDeadzone => "horizon.options.move_deadzone",
    // rust: Opt::PadLookDeadzone => "horizon.options.look_deadzone",
    // rust: Opt::PadTriggerThreshold => "horizon.options.trigger_threshold",
    // rust: Opt::PadGlyphs => "horizon.options.button_glyphs",
    // rust: Opt::PadKeyboard => "horizon.options.on_screen_keyboard",
    // rust: Opt::ModelPart(i) => [
    // rust: "options.modelPart.cape",
    // rust: "options.modelPart.jacket",
    // rust: "options.modelPart.left_sleeve",
    // rust: "options.modelPart.right_sleeve",
    // rust: "options.modelPart.left_pants_leg",
    // rust: "options.modelPart.right_pants_leg",
    // rust: "options.modelPart.hat",
    // rust: ][i],
    // rust: Opt::SkinLayers3d => "horizon.options.three_d_skin_layers",
    // rust: Opt::MainHand => "options.mainHand",
    // rust: Opt::AllowServerListing => "options.allowServerListing",
    // rust: Opt::RealmsNotifications => "options.realmsNotifications.button",
    // rust: Opt::InGameNotification => "options.inGameNotification",
    // rust: Opt::SharePresence => "options.sharePresence",
    // rust: Opt::DirectionalAudio => "options.directionalAudio",
    // rust: Opt::MusicToast => "options.musicToast",
}
}
    // rust: pub(crate) fn kind(self, s: &Settings) -> Kind {
    // rust: let unit = |v: f32, lo: f32, hi: f32| Kind::Slider(((v - lo) / (hi - lo)).clamp(0.0, 1.0));
    // rust: match self {
    // rust: Opt::FovEffects | Opt::DarknessPulsing => {
    // rust: Kind::Slider(s.file.double(self.file_key().unwrap()).sqrt() as f32)
}
    // rust: Opt::DistortionEffects
    // rust: | Opt::DamageTilt
    // rust: | Opt::GlintSpeed
    // rust: | Opt::GlintStrength
    // rust: | Opt::PanoramaSpeed => Kind::Slider(s.file.double(self.file_key().unwrap()) as f32),
    // rust: Opt::Fov => unit(s.fov, 30.0, 110.0),
    // rust: Opt::RenderDistance => unit(
    // rust: s.render_distance as f32,
    // rust: 2.0,
    // rust: crate::options_file::MAX_RENDER_DISTANCE as f32,
    // rust: ),
    // rust: Opt::SimulationDistance => unit(s.simulation_distance as f32, 5.0, 32.0),
    // rust: Opt::Sensitivity => Kind::Slider(s.sensitivity),
    // rust: Opt::WheelSensitivity => unit(s.mouse_wheel_sensitivity, 0.01, 10.0),
    // rust: Opt::Volume(i) => Kind::Slider(if i == 0 {
    // rust: s.master_volume
    // rust: } else {
    // rust: s.volumes[i]
    // rust: }),
    // rust: Opt::Gamma => Kind::Slider(s.gamma),
    // rust: Opt::MaxFps => unit(s.max_fps as f32, 10.0, 260.0),
    // rust: Opt::CloudRange => unit(s.cloud_range as f32, 2.0, 128.0),
    // rust: Opt::EntityDistance => unit(s.entity_distance, 0.5, 5.0),
    // rust: Opt::BiomeBlend => unit(s.biome_blend as f32, 0.0, 7.0),
    // rust: Opt::Preset => unit(preset_index(&s.graphics_preset) as f32, 0.0, 3.0),
    // rust: Opt::Mipmaps => unit(s.mipmap_levels as f32, 0.0, 4.0),
    // rust: Opt::MaxAnisotropy => unit(s.file.int("maxAnisotropyBit") as f32, 1.0, 3.0),
    // rust: Opt::ExclusiveMode => {
    // rust: let last = s.video_modes.len() as f32 - 1.0;
    // rust: if last < 0.0 {
    // rust: Kind::Slider(0.0)
    // rust: } else {
    // rust: unit(s.video_mode_index() as f32, -1.0, last)
}
}
    // rust: Opt::WeatherRadius => unit(s.weather_radius as f32, 3.0, 10.0),
    // rust: Opt::ChunkFade => unit(s.chunk_fade, 0.0, 2.0),
    // rust: Opt::MenuBlur => unit(s.menu_blur as f32, 0.0, 10.0),
    // rust: Opt::NotificationDisplayTime => unit(s.notification_display_time, 0.5, 10.0),
    // rust: Opt::ChatOpacity => Kind::Slider(s.chat_opacity),
    // rust: Opt::TextBackgroundOpacity => Kind::Slider(s.text_background_opacity),
    // rust: Opt::ChatScale => Kind::Slider(s.chat_scale),
    // rust: Opt::ChatWidth => Kind::Slider(s.chat_width),
    // rust: Opt::ChatHeightFocused => Kind::Slider(s.chat_height_focused),
    // rust: Opt::ChatHeightUnfocused => Kind::Slider(s.chat_height_unfocused),
    // rust: Opt::ChatLineSpacing => Kind::Slider(s.chat_line_spacing),
    // rust: Opt::PadLookSensitivity => Kind::Slider(s.controller.look_sensitivity),
    // rust: Opt::PadPointerSpeed => unit(s.controller.pointer_speed, 0.25, 3.0),
    // rust: Opt::PadScrollSpeed => unit(s.controller.scroll_speed, 1.0, 36.0),
    // rust: Opt::PadRepeatDelay => unit(s.controller.repeat_delay, 0.1, 1.0),
    // rust: Opt::PadRepeatInterval => unit(s.controller.repeat_interval, 0.03, 0.3),
    // rust: Opt::PadMoveDeadzone => unit(s.controller.move_deadzone, 0.0, 0.5),
    // rust: Opt::PadLookDeadzone => unit(s.controller.look_deadzone, 0.0, 0.5),
    // rust: Opt::PadTriggerThreshold => unit(s.controller.trigger_threshold, 0.1, 0.9),
    // rust: Opt::SprintWindow => unit(s.sprint_window as f32, 0.0, 10.0),
    // rust: _ => Kind::Cycle,
}
}
    // OptionInstance's static or value-dependent tooltip translation.
tooltip_key :: proc(self: ^Self, s: ^Settings) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let key = match self {
    // rust: Opt::InactivityFps => {
    // rust: if s.inactivity_fps_limit == "minimized" {
    // rust: "options.inactivityFpsLimit.minimized"
    // rust: } else {
    // rust: "options.inactivityFpsLimit.afk"
}
}
    // rust: Opt::ChunkBuilder => [
    // rust: "options.prioritizeChunkUpdates.none",
    // rust: "options.prioritizeChunkUpdates.byPlayer",
    // rust: "options.prioritizeChunkUpdates.nearby",
    // rust: ][usize::from(s.prioritize_chunk_updates.min(2))],
            // Options.exclusiveFullscreen: a tooltip per value.
    // rust: Opt::ExclusiveFullscreen => {
    // rust: if s.file.bool("exclusiveFullscreen") {
    // rust: "options.exclusiveFullscreen.on"
    // rust: } else {
    // rust: "options.exclusiveFullscreen.off"
}
}
    // rust: Opt::TextureFiltering => [
    // rust: "options.textureFiltering.none",
    // rust: "options.textureFiltering.rgss",
    // rust: "options.textureFiltering.anisotropic",
    // rust: ][s.file.int("textureFiltering").clamp(0, 2) as usize],
            // InputQuirks.REPLACE_CTRL_KEY_WITH_CMD_KEY: Cmd+B on macOS.
    // rust: Opt::NarratorHotkey if cfg!(target_os = "macos") => {
    // rust: "options.accessibility.narrator_hotkey.mac"
}
    // rust: _ => self.caption(),
}
    // rust: format!("{key}.tooltip")
}
    // A slider's position (0..1), or `None` for a cycle button.
slider_position :: proc(self: ^Self, s: ^Settings) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.kind(s) {
    // rust: Kind::Slider(v) => Some(v),
    // rust: Kind::Cycle => None,
}
}
    // The discrete step count for stepped sliders, or `None` if continuous.
slider_steps :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Opt::Fov => Some(80),
    // rust: Opt::RenderDistance => Some((crate::options_file::MAX_RENDER_DISTANCE - 2) as u32),
    // rust: Opt::SimulationDistance => Some(27),
    // rust: Opt::MaxFps => Some(25),
    // rust: Opt::CloudRange => Some(126),
    // rust: Opt::EntityDistance => Some(18),
    // rust: Opt::BiomeBlend => Some(7),
    // rust: Opt::Preset => Some(3),
    // rust: Opt::Mipmaps => Some(4),
    // rust: Opt::WeatherRadius => Some(7),
    // rust: Opt::ChunkFade => Some(40),
    // rust: Opt::MenuBlur => Some(10),
    // rust: Opt::NotificationDisplayTime => Some(95),
    // rust: Opt::PadMoveDeadzone | Opt::PadLookDeadzone => Some(50),
    // rust: Opt::PadTriggerThreshold => Some(80),
    // rust: Opt::SprintWindow => Some(10),
    // rust: _ => None,
}
}
    // Step a slider forward or backward, derived from its own slider definition and step count.
step_slider :: proc(self: ^Self, s: ^Settings, forward: bool, width: f32) {
}
    // rust: if !self.available() {
    // rust: return;
}
    // rust: let Some(pos) = self.slider_position(s) else {
    // rust: return;
}
    // rust: let next_pos = if let Some(steps) = self.slider_steps() {
    // rust: let steps = steps as f32;
    // rust: let current = (pos * steps).round();
    // rust: let next = if forward {
    // rust: current + 1.0
    // rust: } else {
    // rust: current - 1.0
}
    // rust: (next / steps).clamp(0.0, 1.0)
    // rust: } else {
    // rust: let delta = 1.0 / (width - 8.0).max(1.0);
    // rust: if forward {
    // rust: (pos + delta).min(1.0)
    // rust: } else {
    // rust: (pos - delta).max(0.0)
}
}
    // rust: self.set_slider(s, next_pos);
}
    // The widget message (OptionInstance.toString / CycleButton full name).
label :: proc(self: ^Self, s: ^Settings) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let c = self.caption();
    // rust: match self {
    // rust: Opt::ChatDelay => tr("options.chat.delay_none"),
    // rust: Opt::FovEffects
    // rust: | Opt::DarknessPulsing
    // rust: | Opt::DistortionEffects
    // rust: | Opt::DamageTilt
    // rust: | Opt::GlintSpeed
    // rust: | Opt::GlintStrength => {
    // rust: let value = s.file.double(self.file_key().unwrap()) as f32;
    // rust: if value == 0.0 {
    // rust: generic(c, tr("options.off"))
    // rust: } else {
    // rust: percent(c, value)
}
}
    // rust: Opt::PanoramaSpeed => percent(c, s.file.double("panoramaScrollSpeed") as f32),
    // rust: Opt::SprintWindow => {
    // rust: let value = if s.sprint_window == 0 {
    // rust: tr("options.off")
    // rust: } else {
    // rust: Text::tr("options.value", &[&s.sprint_window])
}
    // rust: generic(c, value)
}
    // rust: Opt::Fov => match s.fov as i32 {
    // rust: 70 => generic(c, tr("options.fov.min")),
    // rust: 110 => generic(c, tr("options.fov.max")),
    // rust: v => generic(c, Text::literal(v.to_string())),
    // rust: },
    // rust: Opt::RenderDistance => generic(c, Text::tr("options.chunks", &[&s.render_distance])),
    // rust: Opt::SimulationDistance => {
    // rust: generic(c, Text::tr("options.chunks", &[&s.simulation_distance]))
}
    // rust: Opt::Sensitivity => {
    // rust: if s.sensitivity == 0.0 {
    // rust: generic(c, tr("options.sensitivity.min"))
    // rust: } else if s.sensitivity == 1.0 {
    // rust: generic(c, tr("options.sensitivity.max"))
    // rust: } else {
    // rust: percent(c, 2.0 * s.sensitivity)
}
}
    // rust: Opt::WheelSensitivity => generic(
    // rust: c,
    // rust: Text::literal(format!("{:.2}", s.mouse_wheel_sensitivity)),
    // rust: ),
    // rust: Opt::Volume(i) => {
    // rust: let v = if i == 0 {
    // rust: s.master_volume
    // rust: } else {
    // rust: s.volumes[i]
}
    // rust: let caption = format!("soundCategory.{}", SOUND_SOURCES[i]);
    // rust: if v == 0.0 {
    // rust: generic(&caption, tr("options.off"))
    // rust: } else {
    // rust: percent(&caption, v)
}
}
    // rust: Opt::GuiScale => {
    // rust: let value = if s.gui_scale == 0 {
    // rust: tr("options.guiScale.auto")
    // rust: } else {
    // rust: Text::literal(s.gui_scale.to_string())
}
    // rust: generic(c, value)
}
    // rust: Opt::Gamma => match (f64::from(s.gamma) * 100.0) as i32 {
    // rust: 0 => generic(c, tr("options.gamma.min")),
    // rust: 50 => generic(c, tr("options.gamma.default")),
    // rust: 100 => generic(c, tr("options.gamma.max")),
    // rust: v => generic(c, Text::literal(v.to_string())),
    // rust: },
    // rust: Opt::MaxFps => {
    // rust: if s.max_fps >= 260 {
    // rust: generic(c, tr("options.framerateLimit.max"))
    // rust: } else {
    // rust: generic(c, Text::tr("options.framerate", &[&s.max_fps]))
}
}
    // rust: Opt::CloudRange => generic(c, Text::tr("options.chunks", &[&s.cloud_range])),
    // rust: Opt::EntityDistance => percent(c, s.entity_distance),
    // rust: Opt::BiomeBlend => generic(
    // rust: c,
    // rust: tr(&format!(
    // rust: "options.biomeBlendRadius.{}",
    // rust: s.biome_blend * 2 + 1
    // rust: )),
    // rust: ),
    // rust: Opt::Preset => generic(c, tr(&format!("options.graphics.{}", s.graphics_preset))),
    // rust: Opt::MaxAnisotropy => match s.file.int("maxAnisotropyBit") {
    // rust: 0 => generic(c, tr("options.off")),
    // rust: bit => generic(c, Text::tr("options.multiplier", &[&(1 << bit)])),
    // rust: },
    // rust: Opt::ExclusiveMode => match s.video_modes.get(s.video_mode_index().max(0) as usize) {
    // rust: None if s.video_modes.is_empty() => tr("options.fullscreen.unavailable"),
    // rust: Some(mode) if s.video_mode_index() >= 0 => generic(
    // rust: c,
    // rust: Text::tr(
    // rust: "options.fullscreen.entry",
    // rust: &[
    // rust: &mode.width,
    // rust: &mode.height,
    // rust: &mode.refresh_rate_label(),
    // rust: &mode.bits(),
    // rust: ],
    // rust: ),
    // rust: ),
    // rust: _ => generic(c, tr("options.fullscreen.current")),
    // rust: },
    // rust: Opt::Mipmaps => {
    // rust: if s.mipmap_levels == 0 {
    // rust: generic(c, tr("options.off"))
    // rust: } else {
    // rust: generic(c, Text::literal(s.mipmap_levels.to_string()))
}
}
    // rust: Opt::WeatherRadius => generic(c, Text::tr("options.blocks", &[&s.weather_radius])),
    // rust: Opt::ChunkFade => {
    // rust: if s.chunk_fade <= 0.0 {
    // rust: tr("options.chunkFade.none")
    // rust: } else {
    // rust: Text::tr(
    // rust: "options.chunkFade.seconds",
    // rust: &[&format!("{:.2}", s.chunk_fade)],
    // rust: )
}
}
    // rust: Opt::MenuBlur => {
    // rust: if s.menu_blur == 0 {
    // rust: generic(c, tr("options.off"))
    // rust: } else {
    // rust: generic(c, Text::literal(s.menu_blur.to_string()))
}
}
    // rust: Opt::ChatOpacity => percent(c, s.chat_opacity * 0.9 + 0.1),
    // rust: Opt::TextBackgroundOpacity => percent(c, s.text_background_opacity),
    // rust: Opt::ChatScale => {
    // rust: if s.chat_scale == 0.0 {
    // rust: generic(c, tr("options.off"))
    // rust: } else {
    // rust: percent(c, s.chat_scale)
}
}
    // rust: Opt::ChatWidth => chat_px(c, (s.chat_width * 280.0 + 40.0).floor()),
    // rust: Opt::ChatHeightFocused => chat_px(c, (s.chat_height_focused * 160.0 + 20.0).floor()),
    // rust: Opt::ChatHeightUnfocused => {
    // rust: chat_px(c, (s.chat_height_unfocused * 160.0 + 20.0).floor())
}
    // rust: Opt::ChatLineSpacing => percent(c, s.chat_line_spacing),
    // rust: Opt::NotificationDisplayTime => generic(
    // rust: c,
    // rust: Text::tr(
    // rust: "options.multiplier",
    // rust: &[&format!("{:.1}", s.notification_display_time)],
    // rust: ),
    // rust: ),
    // rust: Opt::PadLookSensitivity => percent(c, 2.0 * s.controller.look_sensitivity),
    // rust: Opt::PadPointerSpeed => percent(c, s.controller.pointer_speed),
    // rust: Opt::PadScrollSpeed => percent(c, s.controller.scroll_speed / 12.0),
    // rust: Opt::PadRepeatDelay | Opt::PadRepeatInterval => generic(
    // rust: c,
    // rust: Text::tr(
    // rust: "horizon.options.milliseconds",
    // rust: &[&format!(
    // rust: "{:.0}",
    // rust: 1000.0
    // rust: * if self == Opt::PadRepeatDelay {
    // rust: s.controller.repeat_delay
    // rust: } else {
    // rust: s.controller.repeat_interval
}
    // rust: )],
    // rust: ),
    // rust: ),
    // rust: Opt::PadMoveDeadzone | Opt::PadLookDeadzone | Opt::PadTriggerThreshold => {
    // rust: let v = match self {
    // rust: Opt::PadMoveDeadzone => s.controller.move_deadzone,
    // rust: Opt::PadLookDeadzone => s.controller.look_deadzone,
    // rust: _ => s.controller.trigger_threshold,
}
    // rust: Text::translate(
    // rust: "options.percent_value",
    // rust: &[
    // rust: tr(c),
    // rust: Text::literal(((v * 100.0).round() as i32).to_string()),
    // rust: ],
    // rust: )
}
    // rust: _ => generic(c, self.value_text(s)),
}
}
value_text :: proc(self: ^Self, s: ^Settings) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Opt::TextBackground => tr(if s.file.bool("backgroundForChatOnly") {
    // rust: "options.accessibility.text_background.chat"
    // rust: } else {
    // rust: "options.accessibility.text_background.everywhere"
    // rust: }),
            // Options.narrator's caption: the status while the narrator is
            // there, "Not Available" otherwise.
    // rust: Opt::Narrator => tr(if horizon_narrator::is_active() {
    // rust: s.narrator().key()
    // rust: } else {
    // rust: "options.narrator.notavailable"
    // rust: }),
    // rust: Opt::ChatDelay => tr("options.chat.delay_none"),
    // rust: Opt::HideLightningFlashes => on_off(s.file.bool("hideLightningFlashes")),
    // rust: Opt::MonochromeLogo => on_off(s.file.bool("darkMojangStudiosBackground")),
    // rust: Opt::HideSplashTexts => on_off(s.file.bool("hideSplashTexts")),
    // rust: Opt::HideMatchedNames
    // rust: | Opt::OnlySecureChat
    // rust: | Opt::SaveChatDrafts
    // rust: | Opt::ModelPart(_)
    // rust: | Opt::AllowServerListing
    // rust: | Opt::RealmsNotifications
    // rust: | Opt::InGameNotification
    // rust: | Opt::DirectionalAudio => on_off(s.file.bool(self.file_key().unwrap())),
    // rust: Opt::MainHand => tr(if s.main_hand_left {
    // rust: "options.mainHand.left"
    // rust: } else {
    // rust: "options.mainHand.right"
    // rust: }),
    // rust: Opt::SharePresence => tr([
    // rust: "options.sharePresence.none",
    // rust: "options.sharePresence.limited",
    // rust: "options.sharePresence.all",
    // rust: ][s.file.int("sharePresence").clamp(0, 2) as usize]),
    // rust: Opt::MusicToast => tr([
    // rust: "options.musicToast.never",
    // rust: "options.musicToast.pauseMenu",
    // rust: "options.musicToast.pauseMenuAndToast",
    // rust: ][s.file.int("musicToast").clamp(0, 2) as usize]),
    // rust: Opt::NarratorHotkey => on_off(s.file.bool("narratorHotkey")),
    // rust: Opt::RotateWithMinecarts => on_off(s.file.bool("rotateWithMinecart")),
    // rust: Opt::HighContrastBlockOutlines => on_off(s.file.bool("highContrastBlockOutline")),
    // rust: Opt::InvertX => on_off(s.invert_x),
    // rust: Opt::InvertY => on_off(s.invert_y),
    // rust: Opt::DiscreteScroll => on_off(s.discrete_scroll),
    // rust: Opt::AllowCursorChanges => on_off(s.allow_cursor_changes),
    // rust: Opt::ViewBobbing => on_off(s.view_bobbing),
    // rust: Opt::Vsync => on_off(s.vsync),
    // rust: Opt::Fullscreen => on_off(s.fullscreen),
    // rust: Opt::ExclusiveFullscreen => on_off(s.file.bool("exclusiveFullscreen")),
    // rust: Opt::TextureFiltering => tr([
    // rust: "options.textureFiltering.none",
    // rust: "options.textureFiltering.rgss",
    // rust: "options.textureFiltering.anisotropic",
    // rust: ][s.file.int("textureFiltering").clamp(0, 2) as usize]),
    // rust: Opt::GraphicsBackend => tr(match s.horizon.api {
    // rust: crate::graphics::GraphicsApi::OpenGl => "options.graphicsApi.opengl",
    // rust: crate::graphics::GraphicsApi::Vulkan => "options.graphicsApi.vulkan",
    // rust: _ => "options.graphicsApi.default",
    // rust: }),
    // rust: Opt::SmoothLighting => on_off(s.smooth_lighting),
    // rust: Opt::Clouds => tr(match s.clouds.as_str() {
    // rust: "false" => "options.off",
    // rust: "fast" => "options.clouds.fast",
    // rust: _ => "options.clouds.fancy",
    // rust: }),
    // rust: Opt::Particles => tr([
    // rust: "options.particles.all",
    // rust: "options.particles.decreased",
    // rust: "options.particles.minimal",
    // rust: ][usize::from(s.particles.min(2))]),
    // rust: Opt::EntityShadows => on_off(s.entity_shadows),
    // rust: Opt::Vignette => on_off(s.vignette),
    // rust: Opt::Autosave => on_off(s.autosave_indicator),
    // rust: Opt::CutoutLeaves => on_off(s.cutout_leaves),
    // rust: Opt::ImprovedTransparency => on_off(s.improved_transparency),
    // rust: Opt::AttackIndicator => tr([
    // rust: "options.off",
    // rust: "options.attack.crosshair",
    // rust: "options.attack.hotbar",
    // rust: ][usize::from(s.attack_indicator.min(2))]),
    // rust: Opt::InactivityFps => tr(if s.inactivity_fps_limit == "minimized" {
    // rust: "options.inactivityFpsLimit.minimized"
    // rust: } else {
    // rust: "options.inactivityFpsLimit.afk"
    // rust: }),
    // rust: Opt::ChunkBuilder => tr([
    // rust: "options.prioritizeChunkUpdates.none",
    // rust: "options.prioritizeChunkUpdates.byPlayer",
    // rust: "options.prioritizeChunkUpdates.nearby",
    // rust: ][usize::from(s.prioritize_chunk_updates.min(2))]),
    // rust: Opt::ToggleCrouch => tr(if s.toggle_crouch {
    // rust: "options.key.toggle"
    // rust: } else {
    // rust: "options.key.hold"
    // rust: }),
    // rust: Opt::ToggleSprint => tr(if s.toggle_sprint {
    // rust: "options.key.toggle"
    // rust: } else {
    // rust: "options.key.hold"
    // rust: }),
    // rust: Opt::SkinLayers3d => tr(if s.extras.three_d_skin_layers {
    // rust: "options.on"
    // rust: } else {
    // rust: "options.off"
    // rust: }),
    // rust: Opt::ToggleAttack => tr(if s.toggle_attack {
    // rust: "options.key.toggle"
    // rust: } else {
    // rust: "options.key.hold"
    // rust: }),
    // rust: Opt::ToggleUse => tr(if s.toggle_use {
    // rust: "options.key.toggle"
    // rust: } else {
    // rust: "options.key.hold"
    // rust: }),
    // rust: Opt::AutoJump => on_off(s.auto_jump),
    // rust: Opt::QuitShortcuts => on_off(s.quit_shortcuts),
    // rust: Opt::CtrlClickEmulatesRightClick => on_off(s.ctrl_click_emulates_right_click),
    // rust: Opt::OperatorItemsTab => on_off(s.operator_items_tab),
    // rust: Opt::ChatVisibility => tr([
    // rust: "options.chat.visibility.full",
    // rust: "options.chat.visibility.system",
    // rust: "options.chat.visibility.hidden",
    // rust: ][usize::from(s.chat_visibility.min(2))]),
    // rust: Opt::ChatColors => on_off(s.chat_colors),
    // rust: Opt::ChatLinks => on_off(s.chat_links),
    // rust: Opt::ChatLinksPrompt => on_off(s.chat_links_prompt),
    // rust: Opt::AutoSuggestions => on_off(s.auto_suggestions),
    // rust: Opt::ReducedDebugInfo => on_off(s.reduced_debug_info),
    // rust: Opt::HighContrast => on_off(s.high_contrast),
    // rust: Opt::ShowSubtitles => on_off(s.show_subtitles),
    // rust: Opt::SoundDevice => {
    // rust: if s.sound_device.is_empty() {
    // rust: tr("options.audioDevice.default")
    // rust: } else {
    // rust: Text::literal(&s.sound_device)
}
}
    // rust: Opt::MusicFrequency => tr([
    // rust: "options.music_frequency.default",
    // rust: "options.music_frequency.frequent",
    // rust: "options.music_frequency.constant",
    // rust: ][s.file.int("musicFrequency").clamp(0, 2) as usize]),
    // rust: Opt::ForceUnicode => on_off(s.force_unicode),
    // rust: Opt::JapaneseGlyphs => on_off(s.japanese_glyphs),
    // rust: Opt::PadEnabled => on_off(s.controller.enabled),
    // rust: Opt::PadVibration => on_off(s.controller.vibration),
    // rust: Opt::PadAdaptiveTriggers => on_off(s.controller.adaptive_triggers),
    // rust: Opt::PadInvertX => on_off(s.controller.invert_x),
    // rust: Opt::PadInvertY => on_off(s.controller.invert_y),
    // rust: Opt::PadToggleSneak => tr(if s.controller.toggle_sneak {
    // rust: "options.key.toggle"
    // rust: } else {
    // rust: "options.key.hold"
    // rust: }),
    // rust: Opt::PadLightbar => tr(match s.controller.lightbar {
    // rust: gamepad::Lightbar::Health => "horizon.options.lightbar.health",
    // rust: gamepad::Lightbar::Dimension => "horizon.options.lightbar.dimension",
    // rust: gamepad::Lightbar::Off => "options.off",
    // rust: }),
    // rust: Opt::PadGlyphs => tr(match s.controller.glyphs {
    // rust: GlyphStyle::Auto => "horizon.options.glyphs.auto",
    // rust: GlyphStyle::Xbox => "horizon.options.glyphs.xbox",
    // rust: GlyphStyle::PlayStation => "horizon.options.glyphs.playstation",
    // rust: GlyphStyle::Nintendo => "horizon.options.glyphs.nintendo",
    // rust: }),
    // rust: Opt::PadKeyboard => tr(match s.controller.keyboard {
    // rust: gamepad::TextKeyboard::Auto => "horizon.options.keyboard.auto",
    // rust: gamepad::TextKeyboard::Horizon => "horizon.options.keyboard.horizon",
    // rust: gamepad::TextKeyboard::Steam => "horizon.options.keyboard.steam",
    // rust: }),
    // rust: _ => Text::empty(),
}
}
    // Set a slider from its 0..1 position (OptionInstance value sets).
set_slider :: proc(self: ^Self, s: ^Settings, v: f32) {
}
    // rust: if !self.available() {
    // rust: return;
}
    // rust: let v = v.clamp(0.0, 1.0);
    // rust: let step = |lo: f32, hi: f32| (lo + v * (hi - lo)).round();
    // rust: match self {
    // rust: Opt::FovEffects | Opt::DarknessPulsing => s.file.set(
    // rust: self.file_key().unwrap(),
    // rust: crate::options_file::V::Double(f64::from(v).powi(2)),
    // rust: ),
    // rust: Opt::DistortionEffects
    // rust: | Opt::DamageTilt
    // rust: | Opt::PanoramaSpeed
    // rust: | Opt::GlintSpeed
    // rust: | Opt::GlintStrength => s.file.set(
    // rust: self.file_key().unwrap(),
    // rust: crate::options_file::V::Double(f64::from(v)),
    // rust: ),
    // rust: Opt::Fov => s.fov = step(30.0, 110.0),
    // rust: Opt::RenderDistance => {
    // rust: s.render_distance =
    // rust: step(2.0, crate::options_file::MAX_RENDER_DISTANCE as f32) as i32
}
    // rust: Opt::SimulationDistance => s.simulation_distance = step(5.0, 32.0) as i32,
    // rust: Opt::Sensitivity => s.sensitivity = v,
    // rust: Opt::WheelSensitivity => s.mouse_wheel_sensitivity = 0.01 + v * 9.99,
    // rust: Opt::Volume(0) => s.master_volume = v,
    // rust: Opt::Volume(i) => s.volumes[i] = v,
    // rust: Opt::Gamma => s.gamma = v,
    // rust: Opt::MaxFps => s.max_fps = (step(1.0, 26.0) as u32) * 10,
    // rust: Opt::CloudRange => s.cloud_range = step(2.0, 128.0) as i32,
    // rust: Opt::EntityDistance => s.entity_distance = step(2.0, 20.0) / 4.0,
    // rust: Opt::BiomeBlend => s.biome_blend = step(0.0, 7.0) as i32,
    // rust: Opt::Preset => s.graphics_preset = PRESETS[step(0.0, 3.0) as usize].into(),
    // rust: Opt::Mipmaps => s.mipmap_levels = step(0.0, 4.0) as i32,
    // rust: Opt::MaxAnisotropy => s.file.set(
    // rust: "maxAnisotropyBit",
    // rust: crate::options_file::V::Int(step(1.0, 3.0) as i32),
    // rust: ),
    // rust: Opt::ExclusiveMode => {
                // Window.setPreferredFullscreenVideoMode: -1 is the desktop's own mode.
    // rust: let Some(last) = s.video_modes.len().checked_sub(1) else {
    // rust: return;
}
    // rust: let index = step(-1.0, last as f32) as i32;
    // rust: s.file.fullscreen_resolution = usize::try_from(index)
    // rust: .ok()
    // rust: .map(|i| s.video_modes[i].write());
}
    // rust: Opt::WeatherRadius => s.weather_radius = step(3.0, 10.0) as i32,
    // rust: Opt::ChunkFade => s.chunk_fade = step(0.0, 40.0) / 20.0,
    // rust: Opt::MenuBlur => s.menu_blur = step(0.0, 10.0) as i32,
    // rust: Opt::NotificationDisplayTime => s.notification_display_time = step(5.0, 100.0) / 10.0,
    // rust: Opt::ChatOpacity => s.chat_opacity = v,
    // rust: Opt::TextBackgroundOpacity => s.text_background_opacity = v,
    // rust: Opt::ChatScale => s.chat_scale = v,
    // rust: Opt::ChatWidth => s.chat_width = v,
    // rust: Opt::ChatHeightFocused => s.chat_height_focused = v,
    // rust: Opt::ChatHeightUnfocused => s.chat_height_unfocused = v,
    // rust: Opt::ChatLineSpacing => s.chat_line_spacing = v,
    // rust: Opt::PadLookSensitivity => s.controller.look_sensitivity = v,
    // rust: Opt::PadPointerSpeed => s.controller.pointer_speed = step(25.0, 300.0) / 100.0,
    // rust: Opt::PadScrollSpeed => s.controller.scroll_speed = step(1.0, 36.0),
    // rust: Opt::PadRepeatDelay => s.controller.repeat_delay = step(100.0, 1000.0) / 1000.0,
    // rust: Opt::PadRepeatInterval => s.controller.repeat_interval = step(30.0, 300.0) / 1000.0,
    // rust: Opt::PadMoveDeadzone => s.controller.move_deadzone = step(0.0, 50.0) / 100.0,
    // rust: Opt::PadLookDeadzone => s.controller.look_deadzone = step(0.0, 50.0) / 100.0,
    // rust: Opt::PadTriggerThreshold => s.controller.trigger_threshold = step(10.0, 90.0) / 100.0,
    // rust: Opt::SprintWindow => s.sprint_window = step(0.0, 10.0) as i32,
    // rust: _ => {}
}
    // rust: if self.affects_preset() {
    // rust: s.graphics_preset = "custom".into();
}
}
affects_preset :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self,
    // rust: Opt::RenderDistance
    // rust: | Opt::SimulationDistance
    // rust: | Opt::SmoothLighting
    // rust: | Opt::Clouds
    // rust: | Opt::CloudRange
    // rust: | Opt::Particles
    // rust: | Opt::EntityDistance
    // rust: | Opt::EntityShadows
    // rust: | Opt::BiomeBlend
    // rust: | Opt::Mipmaps
    // rust: | Opt::WeatherRadius
    // rust: | Opt::CutoutLeaves
    // rust: | Opt::ImprovedTransparency
    // rust: | Opt::MenuBlur
    // rust: | Opt::ChunkBuilder
    // rust: | Opt::TextureFiltering
    // rust: | Opt::MaxAnisotropy
    // rust: )
}
    // Advance a cycle button (CycleButton.cycleValue).
cycle :: proc(self: ^Self, s: ^Settings, back: bool, framebuffer: [i32; 2]) {
}
    // rust: if !self.available() {
    // rust: return;
}
    // rust: let next = |n: u8, count: u8| {
    // rust: if back {
    // rust: (n + count - 1) % count
    // rust: } else {
    // rust: (n + 1) % count
}
}
    // rust: match self {
    // rust: Opt::GuiScale => {
    // rust: let max = crate::window::calculate_scale(framebuffer, 0, s.force_unicode) as u32;
    // rust: let value = s.gui_scale.min(max);
    // rust: s.gui_scale = if back {
    // rust: if value == 0 { max } else { value - 1 }
    // rust: } else if value == max {
    // rust: 0
    // rust: } else {
    // rust: value + 1
}
}
    // rust: Opt::TextBackground
    // rust: | Opt::HideLightningFlashes
    // rust: | Opt::HideSplashTexts
    // rust: | Opt::HighContrastBlockOutlines
    // rust: | Opt::MonochromeLogo
    // rust: | Opt::HideMatchedNames
    // rust: | Opt::OnlySecureChat
    // rust: | Opt::SaveChatDrafts
    // rust: | Opt::ModelPart(_)
    // rust: | Opt::AllowServerListing
    // rust: | Opt::RealmsNotifications
    // rust: | Opt::InGameNotification
    // rust: | Opt::DirectionalAudio
    // rust: | Opt::RotateWithMinecarts
    // rust: | Opt::NarratorHotkey => {
    // rust: let key = self.file_key().unwrap();
    // rust: s.file
    // rust: .set(key, crate::options_file::V::Bool(!s.file.bool(key)));
}
            // OptionInstance.Enum over NarratorStatus.values().
    // rust: Opt::Narrator => {
    // rust: let n = next(s.narrator().id() as u8, 4);
    // rust: s.set_narrator(horizon_narrator::Status::by_id(i32::from(n)));
}
    // rust: Opt::InvertX => s.invert_x = !s.invert_x,
    // rust: Opt::InvertY => s.invert_y = !s.invert_y,
    // rust: Opt::DiscreteScroll => s.discrete_scroll = !s.discrete_scroll,
    // rust: Opt::AllowCursorChanges => s.allow_cursor_changes = !s.allow_cursor_changes,
    // rust: Opt::ViewBobbing => s.view_bobbing = !s.view_bobbing,
    // rust: Opt::Vsync => s.vsync = !s.vsync,
    // rust: Opt::Fullscreen => s.fullscreen = !s.fullscreen,
    // rust: Opt::ExclusiveFullscreen => {
    // rust: let on = s.file.bool("exclusiveFullscreen");
    // rust: s.file
    // rust: .set("exclusiveFullscreen", crate::options_file::V::Bool(!on));
}
    // rust: Opt::TextureFiltering => {
    // rust: let n = next(s.file.int("textureFiltering").clamp(0, 2) as u8, 3);
    // rust: s.file.set(
    // rust: "textureFiltering",
    // rust: crate::options_file::V::Int(i32::from(n)),
    // rust: );
}
    // rust: Opt::GraphicsBackend => {
                // PreferredGraphicsApi: Default, OpenGL, Vulkan; a platform lacking one skips it.
//                 use crate::graphics::GraphicsApi::{Auto, OpenGl, Vulkan};
    // rust: let offered: Vec<_> = [Auto, OpenGl, Vulkan]
    // rust: .into_iter()
    // rust: .filter(|a| crate::graphics::GraphicsApi::choices().contains(a))
    // rust: .collect();
    // rust: let at = offered
    // rust: .iter()
    // rust: .position(|a| *a == s.horizon.api)
    // rust: .unwrap_or(0);
    // rust: let count = offered.len();
    // rust: let api = offered[if back {
    // rust: (at + count - 1) % count
    // rust: } else {
    // rust: (at + 1) % count
    // rust: }];
    // rust: s.horizon.api = api;
    // rust: s.file.set_name(
    // rust: "preferredGraphicsBackend",
    // rust: match api {
    // rust: OpenGl => "opengl",
    // rust: Vulkan => "vulkan",
    // rust: _ => "default",
    // rust: },
    // rust: );
}
    // rust: Opt::SmoothLighting => s.smooth_lighting = !s.smooth_lighting,
    // rust: Opt::Clouds => {
    // rust: let order = ["false", "fast", "true"];
    // rust: let i = order.iter().position(|c| *c == s.clouds).unwrap_or(2) as u8;
    // rust: s.clouds = order[usize::from(next(i, 3))].into();
}
    // rust: Opt::Particles => s.particles = next(s.particles, 3),
    // rust: Opt::EntityShadows => s.entity_shadows = !s.entity_shadows,
    // rust: Opt::Vignette => s.vignette = !s.vignette,
    // rust: Opt::Autosave => s.autosave_indicator = !s.autosave_indicator,
    // rust: Opt::CutoutLeaves => s.cutout_leaves = !s.cutout_leaves,
    // rust: Opt::ImprovedTransparency => s.improved_transparency = !s.improved_transparency,
    // rust: Opt::AttackIndicator => s.attack_indicator = next(s.attack_indicator, 3),
    // rust: Opt::InactivityFps => {
    // rust: s.inactivity_fps_limit = if s.inactivity_fps_limit == "afk" {
    // rust: "minimized".into()
    // rust: } else {
    // rust: "afk".into()
}
}
    // rust: Opt::ChunkBuilder => s.prioritize_chunk_updates = next(s.prioritize_chunk_updates, 3),
    // rust: Opt::ToggleCrouch => s.toggle_crouch = !s.toggle_crouch,
    // rust: Opt::ToggleSprint => s.toggle_sprint = !s.toggle_sprint,
    // rust: Opt::SkinLayers3d => s.extras.three_d_skin_layers = !s.extras.three_d_skin_layers,
    // rust: Opt::ToggleAttack => s.toggle_attack = !s.toggle_attack,
    // rust: Opt::ToggleUse => s.toggle_use = !s.toggle_use,
    // rust: Opt::AutoJump => s.auto_jump = !s.auto_jump,
    // rust: Opt::QuitShortcuts => s.quit_shortcuts = !s.quit_shortcuts,
    // rust: Opt::CtrlClickEmulatesRightClick => {
    // rust: s.ctrl_click_emulates_right_click = !s.ctrl_click_emulates_right_click
}
    // rust: Opt::OperatorItemsTab => s.operator_items_tab = !s.operator_items_tab,
    // rust: Opt::ChatVisibility => s.chat_visibility = next(s.chat_visibility, 3),
    // rust: Opt::ChatColors => s.chat_colors = !s.chat_colors,
    // rust: Opt::ChatLinks => s.chat_links = !s.chat_links,
    // rust: Opt::ChatLinksPrompt => s.chat_links_prompt = !s.chat_links_prompt,
    // rust: Opt::AutoSuggestions => s.auto_suggestions = !s.auto_suggestions,
    // rust: Opt::ReducedDebugInfo => s.reduced_debug_info = !s.reduced_debug_info,
    // rust: Opt::HighContrast => s.high_contrast = !s.high_contrast,
    // rust: Opt::ShowSubtitles => s.show_subtitles = !s.show_subtitles,
    // rust: Opt::SoundDevice => {
    // rust: let devices = crate::audio::output_devices();
    // rust: let mut all = vec![String::new()];
    // rust: for d in devices {
    // rust: if !all.contains(&d) {
    // rust: all.push(d);
}
}
    // rust: let current_idx = all.iter().position(|d| d == &s.sound_device).unwrap_or(0);
    // rust: let count = all.len();
    // rust: let next_idx = if back {
    // rust: (current_idx + count - 1) % count
    // rust: } else {
    // rust: (current_idx + 1) % count
}
    // rust: s.sound_device = all[next_idx].clone();
}
    // rust: Opt::MusicFrequency => {
    // rust: let n = next(s.file.int("musicFrequency").clamp(0, 2) as u8, 3);
    // rust: s.file
    // rust: .set("musicFrequency", crate::options_file::V::Int(i32::from(n)));
}
    // rust: Opt::MainHand => s.main_hand_left = !s.main_hand_left,
    // rust: Opt::SharePresence => {
    // rust: let n = next(s.file.int("sharePresence").clamp(0, 2) as u8, 3);
    // rust: s.file
    // rust: .set("sharePresence", crate::options_file::V::Int(i32::from(n)));
}
    // rust: Opt::MusicToast => {
    // rust: let n = next(s.file.int("musicToast").clamp(0, 2) as u8, 3);
    // rust: s.file
    // rust: .set("musicToast", crate::options_file::V::Int(i32::from(n)));
}
    // rust: Opt::ForceUnicode => s.force_unicode = !s.force_unicode,
    // rust: Opt::JapaneseGlyphs => s.japanese_glyphs = !s.japanese_glyphs,
    // rust: Opt::PadEnabled => s.controller.enabled = !s.controller.enabled,
    // rust: Opt::PadVibration => s.controller.vibration = !s.controller.vibration,
    // rust: Opt::PadAdaptiveTriggers => {
    // rust: s.controller.adaptive_triggers = !s.controller.adaptive_triggers
}
    // rust: Opt::PadInvertX => s.controller.invert_x = !s.controller.invert_x,
    // rust: Opt::PadInvertY => s.controller.invert_y = !s.controller.invert_y,
    // rust: Opt::PadToggleSneak => s.controller.toggle_sneak = !s.controller.toggle_sneak,
    // rust: Opt::PadLightbar => {
    // rust: let all = gamepad::Lightbar::ALL;
    // rust: let i = all
    // rust: .iter()
    // rust: .position(|l| *l == s.controller.lightbar)
    // rust: .unwrap_or(0) as u8;
    // rust: s.controller.lightbar = all[usize::from(next(i, 3))];
}
    // rust: Opt::PadGlyphs => {
    // rust: let i = GlyphStyle::ALL
    // rust: .iter()
    // rust: .position(|g| *g == s.controller.glyphs)
    // rust: .unwrap_or(0) as u8;
    // rust: s.controller.glyphs = GlyphStyle::ALL[usize::from(next(i, 4))];
}
    // rust: Opt::PadKeyboard => {
    // rust: let all = gamepad::TextKeyboard::ALL;
    // rust: let i = all
    // rust: .iter()
    // rust: .position(|k| *k == s.controller.keyboard)
    // rust: .unwrap_or(0) as u8;
    // rust: s.controller.keyboard = all[usize::from(next(i, 3))];
}
    // rust: _ => {}
}
    // rust: if self.affects_preset() {
    // rust: s.graphics_preset = "custom".into();
}
}
}
PRESETS :: ["fast", "fancy", "fabulous", "custom"]
preset_index :: proc(p: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: PRESETS.iter().position(|x| *x == p).unwrap_or(1)
}
// A slider moved to `v` (OptionInstance.set): the graphics preset applies
// its options when its value changes (`Options.applyGraphicsPreset`).
set_slider :: proc(opt: Opt, s: ^Settings, v: f32) {
}
    // rust: let preset = preset_index(&s.graphics_preset);
    // rust: opt.set_slider(s, v);
    // rust: if opt == Opt::Preset && preset_index(&s.graphics_preset) != preset {
    // rust: apply_preset(s);
}
}
// A slider pressed or dragged to `v`: apply it live, and tell the game when
// a category volume changed (`Options.createSoundSliderOptionInstance`'s
// callback, which `OptionInstance.set` runs only for a new value).
drag_slider :: proc(opt: Opt, s: ^Settings, v: f32, events: ^[dynamic]Event) {
}
    // rust: let volume = |s: &Settings| match opt {
    // rust: Opt::Volume(0) => Some(s.master_volume),
    // rust: Opt::Volume(i) => Some(s.volumes[i]),
    // rust: _ => None,
}
    // rust: let before = volume(s);
    // rust: set_slider(opt, s, v);
    // rust: events.push(Event::SliderDrag);
    // rust: if let (Opt::Volume(source), Some(after)) = (opt, volume(s))
    // rust: && before != Some(after)
    // rust: {
    // rust: events.push(Event::Volume(source, after));
}
}
// GraphicsPreset.apply: the options Fast, Fancy and Fabulous set.
apply_preset :: proc(s: ^Settings) {
}
    // rust: let fabulous = s.graphics_preset == "fabulous";
    // rust: match s.graphics_preset.as_str() {
    // rust: "fast" => {
    // rust: s.biome_blend = 1;
    // rust: s.render_distance = 8;
    // rust: s.prioritize_chunk_updates = 0;
    // rust: s.simulation_distance = 6;
    // rust: s.smooth_lighting = false;
    // rust: s.clouds = "fast".into();
    // rust: s.particles = 1;
    // rust: s.mipmap_levels = 2;
    // rust: s.entity_shadows = false;
    // rust: s.entity_distance = 0.75;
    // rust: s.menu_blur = 2;
    // rust: s.cloud_range = 32;
    // rust: s.cutout_leaves = false;
    // rust: s.improved_transparency = false;
    // rust: s.weather_radius = 5;
    // rust: set_filtering(s, 1, 0);
}
    // rust: "fancy" | "fabulous" => {
    // rust: s.biome_blend = 2;
    // rust: s.render_distance = if fabulous { 32 } else { 16 };
    // rust: s.prioritize_chunk_updates = 1;
    // rust: s.simulation_distance = 12;
    // rust: s.smooth_lighting = true;
    // rust: s.clouds = "true".into();
    // rust: s.particles = 0;
    // rust: s.mipmap_levels = 4;
    // rust: s.entity_shadows = true;
    // rust: s.entity_distance = if fabulous { 1.25 } else { 1.0 };
    // rust: s.menu_blur = 5;
    // rust: s.cloud_range = if fabulous { 128 } else { 64 };
    // rust: s.cutout_leaves = true;
    // rust: s.improved_transparency = fabulous;
    // rust: s.weather_radius = 10;
            // Fabulous takes anisotropic filtering (RGSS on a device with known issues, which
            // wgpu does not report).
    // rust: set_filtering(
    // rust: s,
    // rust: if fabulous { 2 } else { 1 },
    // rust: if fabulous { 2 } else { 1 },
    // rust: );
}
    // rust: _ => {}
}
}
// The preset's `maxAnisotropyBit` and `textureFiltering` (0 none, 1 RGSS, 2 anisotropic).
set_filtering :: proc(s: ^Settings, anisotropy_bit: i32, filtering: i32) {
}
//     use crate::options_file::V;
    // rust: s.file.set("maxAnisotropyBit", V::Int(anisotropy_bit));
    // rust: s.file.set("textureFiltering", V::Int(filtering));
}

// `Options.preferredGraphicsBackend`'s tooltip: the restart note once the choice differs from
// the startup one, the description, and Vulkan's warning.
graphics_api_tooltip :: proc(s: ^Settings) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let line = |key: &str| lang::get_or(key, key);
    // rust: let mut lines = Vec::new();
    // rust: if s.horizon.api != s.startup_api {
    // rust: lines.push(line("options.needsRestart"));
    // rust: lines.push(String::new());
}
    // rust: lines.push(line("options.graphicsApi.tooltip"));
    // rust: if s.horizon.api == crate::graphics::GraphicsApi::Vulkan {
    // rust: lines.push(String::new());
    // rust: lines.push(line("options.graphicsApi.tooltip.vulkan"));
}
    // rust: Text::literal(lines.join("\n"))
}

// `selected_key` while a native mod's key waits (`selected_native_key`).
NATIVE_KEY :: "horizon.nativeModKey"

Page :: enum {
    Main,
    Video,
    Sound,
    Controls,
    KeyBinds,
    Mouse,
    Chat,
    Accessibility,
    Language,
    Font,
    Packs,
    Mods,
    // Browse mods: the registry's content mods, searched (`mod_browser`).
    ModBrowser,
    // One registry project's page: `OptionsUi::mod_project`.
    ModProject,
    // A native mod's settings page: its index in `mods.installed`.
    NativeMod(usize),
    // Horizon's shader packs, either kind (`shader_pack_list`).
    ShaderPacks,
    // The options of `s.shader_packs[.0]`, a Horizon pack: its `[[pages]]` entry `.1`, the
    // first the one the button opens.
    NativePackOptions(usize, u8),
    // The picked `shaders/` pack's options (`shader_options`), one of its screens at a time.
    ShaderOptions,
    // Horizon's graphics settings (`graphics_ui`).
    Graphics,
    GraphicsAdvanced,
    GraphicsHdr,
    // HDR calibration, full screen (`calibration`).
    HdrCalibration,
    // Horizon's controller settings and button binds.
    Controller,
    PadBinds,
    Extras,
    // PvP & HUD (`pvp`): the extras a PvP player sets, on their own page.
    Pvp,
    // CreditsAndAttributionScreen.
    Credits,
    // Horizon Settings: every page Horizon adds, as a mod's settings
    // screen hangs off vanilla's Options.
    Horizon,
    // Replay Studio: saved recordings browser and 3D video editor launcher.
    Studio,
    // AI Agent: agent control on or off, whether an agent is connected, the connection details.
    Agent,
    // SkinCustomizationScreen: the skin layers and Main Hand.
    Skin,
    // OnlineOptionsScreen: server listing, Realms and friends notifications.
    Online,
    // Splitscreen: the profile another player joins as (`split_profiles`).
    SplitProfiles,
    // Splitscreen: the monitor map and draft window arrangement.
    SplitSetup,
    // The built-in music tracks, by situation: play one, turn any off
    // (vanilla's `minecraft:audio/background_music` pools).
    Music,
}
Act :: enum {
    None,
    Push(Page),
    Done,
    Cycle(Opt),
    Extra(crate::extras::Item),
    Key(&'static str),
    ResetKey(&'static str),
    ResetKeys,
    ToggleMod(usize),
    // PvP & HUD's PvP preset (`pvp::apply_preset`).
    PvpPreset,
    // PvP & HUD's Edit HUD button.
    HudEditor,
    // Pick `s.shader_packs[i]`, or turn it off when it is the pick.
    PickShaderPack(usize),
    OpenShaderPackFolder,
    // Open the picked pack's Shader Options page.
    ShaderOptions,
    // Open the options page of the Horizon pack `s.shader_packs[.0]`.
    NativePackOptions(usize),
    // Option `.1` of that pack: its next value.
    NativePackOption(usize, usize),
    // Every option of that pack back to its default.
    NativePackReset(usize),
    // Shader Options: the next value of an option, a screen of the pack, the next profile,
    // every option back to its default.
    ShaderOption(String),
    ShaderScreen(String),
    ShaderProfile,
    ShaderReset,
    // The installed native mod's settings page.
    ModSettings(usize),
    // A native mod's key (mod, key) waits for a key; a button of its page.
    NativeKey(usize, usize),
    NativeButton(usize, usize),
    OpenModFolder,
    // Browse mods: the page of listing `.0` of `mod_browser`.
    ModProject(usize),
    // The open project page's Install or Update.
    InstallMod,
    // The open project page's page on the website.
    OpenModPage,
    // Accessibility's "Accessibility Help" link
    // (`AccessibilityOptionsScreen.addFooter`'s openLinkButton).
    AccessibilityHelp,
    // Credits & Attribution's Credits button (WinScreen without the poem).
    Credits,
    CopyAgentDetails,
    // AI Agent: start or stop the repro recording.
    ToggleRecording,
    // AI Agent: write the repro bundle now.
    ExportRepro,
    // The Music page: play this track of this event now.
    PlayMusicTrack(String, String),
    // The Music page: turn this track off, or back on.
    MusicTrackOn(String, bool),
}
WKind :: enum {
    Button {,
    label: Text,
    active: bool,
    act: Act,
    // rust: },
    Slider {,
    label: Text,
    value: f32,
    opt: Opt,
    // rust: },
    // An option of a shader pack the pack shows as a slider: its value's place in its list.
    ShaderSlider {,
    label: Text,
    value: f32,
    name: String,
    // rust: },
    // A float or int option `.option` of the Horizon pack `s.shader_packs[.pack]`: where its
    // value sits between its minimum and maximum.
    PackSlider {,
    label: Text,
    value: f32,
    pack: usize,
    option: usize,
    // rust: },
    Text {,
    text: Text,
    color: u32,
    centered: bool,
    // rust: },
    LanguageRow {,
    label: Text,
    selected: bool,
    code: String,
    // rust: },
}
Widget :: struct {
    x: f32,
    y: f32,
    w: f32,
    h: f32,
    kind: WKind,
    // Scrolls with the list (clipped to the list area).
    list: bool,
    // The list row it sits in (`ContainerObjectSelectionList`'s entry).
    row: uint,
}

// The keyboard-focused UI target on an options page.
FocusId :: enum {
    Search,
    Slider(Opt),
    // A Horizon pack's option slider: (pack, option).
    PackSlider(usize, usize),
    Cycle(Opt),
    Act(Act),
    Lang(String),
    Index(usize),
}

focus_id :: proc(i: uint, wd: ^Widget) -> F {
    // Ported from Horizon
    return {}
}
    // rust: match &wd.kind {
    // rust: WKind::Slider { opt, .. } => FocusId::Slider(*opt),
    // rust: WKind::PackSlider { pack, option, .. } => FocusId::PackSlider(*pack, *option),
    // rust: WKind::Button {
    // rust: act: Act::Cycle(opt),
    // rust: ..
    // rust: } => FocusId::Cycle(*opt),
    // rust: WKind::Button { act, .. } if *act != Act::None => FocusId::Act(act.clone()),
    // rust: WKind::LanguageRow { code, .. } => FocusId::Lang(code.clone()),
    // rust: _ => FocusId::Index(i),
}
}

matches_focus :: proc(id: ^FocusId, i: uint, wd: ^Widget) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (id, &wd.kind) {
    // rust: (FocusId::Slider(a), WKind::Slider { opt, .. }) => a == opt,
    // rust: (FocusId::PackSlider(p, o), WKind::PackSlider { pack, option, .. }) => {
    // rust: (p, o) == (pack, option)
}
    // rust: (
    // rust: FocusId::Cycle(a),
    // rust: WKind::Button {
    // rust: act: Act::Cycle(opt),
    // rust: ..
    // rust: },
    // rust: ) => a == opt,
    // rust: (FocusId::Act(a), WKind::Button { act, .. }) => a == act,
    // rust: (FocusId::Lang(a), WKind::LanguageRow { code, .. }) => a == code,
    // rust: (FocusId::Index(idx), _) => *idx == i,
    // rust: _ => false,
}
}
// What the game must do after an interaction.
Event :: enum {
    // An accepted button press or the release of a slider.
    ButtonClick,
    // Horizon's own: download the Modrinth hit at this index of the pack
    // screen's browser. The game owns the packs folder, not this screen.
    DownloadPack(usize),
    // Close the options screens (back to the pause menu or title).
    Close,
    // Settings changed: apply and save them.
    Changed,
    // A slider is being dragged: apply settings live but defer saving.
    SliderDrag,
    // A category volume slider (`SoundSource` index) moved to a new value,
    // after its `SliderDrag` (the sound slider's `onValueUpdate`).
    Volume(usize, f32),
    // The language changed (reload translations).
    Language(String),
    // The pack selection changed (reload resources).
    Packs(Vec<String>),
    // Create World's Data Packs screen closed with a new selection.
    DataPacks(Vec<String>),
    OpenPackFolder,
    // Data Packs' Open Pack Folder: create the folder if needed and open it.
    OpenDataPackFolder(std::path::PathBuf),
    OpenModFolder,
    // Browse mods opened: read the registry's index into `mod_browser`.
    BrowseMods,
    // Install (or update) the registry's content mod with this id.
    InstallMod(String),
    // Open a registry project's page on the website.
    OpenModPage(String),
    // Accessibility's Help link: confirm and open
    // `CommonLinks.ACCESSIBILITY_HELP` over the options screen.
    AccessibilityHelp,
    // The Shader Packs page opened: list `shaderpacks/` into `shader_packs`.
    ListShaderPacks,
    // A shader pack was picked or turned off: save and apply it.
    ShaderPack,
    OpenShaderPackFolder,
    // The Shader Options page opened: read the picked pack's options into `shader_options`.
    OpenShaderOptions,
    // The Shader Options page closed with changes: save them and load the pack again.
    ShaderOptions,
    // The options of `shader_packs[.0]`, a Horizon pack, changed: save them (the pack reloads
    // with them).
    NativePackOptions(usize),
    // Native mod `.0`'s page opened: the game asks the mod for its labels
    // again (they were made with the list, maybe in another language).
    NativeSettings(usize),
    // Button `.1` of native mod `.0`'s page was pressed: the game tells the
    // mod and refreshes the page.
    NativeButton(usize, usize),
    // Roll the credits (`CreditsAndAttributionScreen.openCreditsScreen`).
    Credits,
    // PvP & HUD's Edit HUD: open the HUD editor over the game.
    HudEditor,
    // Copy how an agent connects (the AI Agent page).
    CopyAgentDetails,
    // The AI Agent page's recording button: start or stop.
    ToggleRecording,
    // The AI Agent page's export button.
    ExportRepro,
    // The narrator option changed (after its `Changed`): the option's
    // `onValueUpdate`, `GameNarrator.updateNarratorStatus`.
    Narrator,
    // The Music page opened: fill `music_groups` from the sound registry
    // (the game owns it).
    ListMusicTracks,
    // A Music page row: play this track of this event now.
    PlayMusicTrack(String, String),
    // Open the recordings folder in the system file browser.
    OpenStudioFolder,
}
// A row of the Music page: the track, and the pool it is played from.
MusicTrack :: struct {
    // The music event the track belongs to (`minecraft:music.game`).
    event: string,
    // The sound id (`minecraft:music/game/calm1`).
    id: string,
}
// One group of rows on the Music page: a situation, or a dimension's biomes.
MusicGroup :: struct {
    // The lang key of the heading the page shows (`horizon.pages.music.overworld`).
    label: string,
    // The rows, in `sounds.json` order.
    tracks: [dynamic]MusicTrack,
}
// `SliderableValueSet.applyValueImmediately`: these apply 600 ms after
// the last change (`OptionInstanceSliderButton.delayedApplyAt`).
delays_apply :: proc(opt: Opt) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: opt,
    // rust: Opt::RenderDistance | Opt::SimulationDistance | Opt::BiomeBlend | Opt::WheelSensitivity
    // rust: )
}
// Whether a slider still shows its own position: while held, or for a
// delayed one until its value applies (both then `resetValue`).
slider_unsnapped :: proc(opt: Opt, held: bool, moved: Instant) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if delays_apply(opt) {
    // rust: moved.elapsed().as_millis() < 600
    // rust: } else {
    // rust: held
}
}
OptionsUi :: struct {
    stack: [dynamic]Page,
    scroll: f32,
    // rust: pub(crate) dragging: Option<Opt>,
    // The shader pack option whose slider is held, and the handle's own position: it follows
    // the pointer while the option takes the nearest of its values.
    shader_dragging: Option<(string,
    // The same for a Horizon pack's option: (pack, option, the handle's position, whether its
    // value changed since the press). The pack saves its values, and reloads, on release.
    pack_dragging: Option<(uint,
    // Shift is held during the click (it resets a shader pack option to its default).
    shift: bool,
    // The pressed slider's own position (`AbstractSliderButton.value`) and
    // when it last moved: the handle follows the pointer while the option
    // keeps its stepped value, then snaps to it (`resetValue`).
    slider_value: Option<(Opt,
    // The pointer's last y while a scrollbar is held.
    // rust: pub(crate) scrollbar_drag_y: Option<f32>,
    // Key Binds: the mapping waiting for a key ([`NATIVE_KEY`]: a native
    // mod's, `selected_native_key`).
    selected_key: Maybe(^'static str),
    // The native mod's key waiting: (mod, key) in `mods.installed`.
    selected_native_key: Option<(uint,
    // Bindings: the action waiting for a pad button.
    selected_pad_action: Maybe(^'static str),
    // The glyphs the binds list shows (the setting, else the pad's family).
    pad_style: GlyphStyle,
    // The pad goes by its letters (`PadSettings::nintendo_letters`) and the glyphs are
    // Nintendo's: each part shows the letter of the button playing it.
    pad_by_letter: bool,
    // The pad's focus drives the page: its hidden pointer sits mid-widget, so a tooltip goes
    // under the widget instead of beside the pointer.
    pad_driving: bool,
    languages: [dynamic]LanguageInfo,
    language_choice: Maybe(string),
    language_search: ui::EditBox,
    // rust: pub(crate) settings_search: ui::EditBox,
    // Browse mods: the registry's projects, filled by the game.
    mod_browser: crate::mod_browser::ModBrowser,
    // The project whose page is open (`Page::ModProject`).
    mod_project: string,
    // The Mods page's line about switches that wait for a restart.
    mods_note: Maybe(string),
    // The content mods that switch with a world open: only assets and data,
    // in a world this game serves (docs/design/mod-hotload.md).
    mods_live: std::collections::BTreeSet<string>,
    // Horizon's `packBrowser` extra: the pack screen's Add button.
    pack_browser: bool,
    // Packs: the packs found and the selection the screen opens with.
    pack_infos: [dynamic]crate::pack_screen::PackInfo,
    pack_selection: [dynamic]string,
    // The open pack screen, made at its first frame.
    pack_screen: Maybe(crate::pack_screen::PackScreen),
    // The Packs page is Create World's Data Packs screen on this folder.
    data_pack_dir: Maybe(std::path::PathBuf),
    // The game's resources, for the built-in data pack's icon.
    data_pack_resources: std::path::PathBuf,
    // The folder's entries when its packs were listed, and when they were
    // last compared with it.
    data_pack_stamp: (Vec<(string,
    // A reload failure, dismissed before returning to the current page.
    resource_error: Maybe(string),
    // When the pack screen's search box took the focus (its cursor blink).
    pack_focus: Instant,
    // The selection carried over from a pack screen made again over a changed pack list
    // (`update_pack_infos`) differs from the settings'.
    pack_reselected: bool,
    in_world: bool,
    // AccessibilityOptionsScreen: the loaded world's experimental feature.
    minecart_improvements: bool,
    // Scroll the selected language into the middle on the next layout.
    center_language: bool,
    graphics: crate::graphics_ui::GraphicsUi,
    controller: crate::controller_ui::ControllerUi,
    split_profiles: crate::split_profiles::SplitProfiles,
    // HDR calibration while its page is open.
    calibration: Maybe(crate::hdr_calibration::Calibration),
    // Whether the window was fullscreen before calibration made it so (the game keeps it).
    calibration_fullscreen: Maybe(bool),
    split_setup: crate::split_ui::SplitUi,
    studio: crate::studio_ui::StudioUi,
    // The AI Agent page's status lines (set by the game while it shows).
    agent_status: [dynamic]string,
    // A repro recording is running: the AI Agent page's button says stop.
    agent_recording: bool,
    // The Music page's groups (set by the game when it opens the page).
    music_groups: [dynamic]MusicGroup,
    // Keyboard focus: the interactive target currently focused.
    focus: Maybe(FocusId),
    // The focus came from keyboard or pad navigation, so the mouse wheel steps it
    // from anywhere (`wheel`). A click focuses its widget too, for the highlight,
    // but vanilla's wheel ignores that: only the hovered widget then reacts.
    focus_from_keyboard: bool,
    // Whether a focused slider is in value-editing mode (`AbstractSliderButton.canChangeValue`).
    // rust: pub(crate) can_change_value: bool,
    // The current GUI size (w, h).
    size: (f32,
    // The current window framebuffer dimensions [w, h].
    framebuffer: [i32,
    // Splitscreen: another player's options. Language and resource packs are the whole
    // process's (every player's text and textures), so they're P1's to change.
    split_guest: bool,
    // The list's rows as last laid out: each row's top and bottom (GUI
    // pixels), for the narration's row under the mouse.
    row_bands: Vec<[f32,
    // The Extras or PvP & HUD items that take a whole row (`wide_extras`), measured
    // when the page is drawn.
    wide_extras: [dynamic]crate::extras::Item,
}
    // rust: impl Default for OptionsUi {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut search = ui::EditBox::new(0.0, 0.0, 200.0, 15.0);
    // rust: search.max_length = 32;
    // rust: let mut settings_search = ui::EditBox::new(0.0, 0.0, 200.0, 15.0);
    // rust: settings_search.focused = false;
    // rust: Self {
    // rust: stack: vec![Page::Main],
    // rust: scroll: 0.0,
    // rust: dragging: None,
    // rust: shader_dragging: None,
    // rust: pack_dragging: None,
    // rust: shift: false,
    // rust: slider_value: None,
    // rust: scrollbar_drag_y: None,
    // rust: selected_key: None,
    // rust: selected_native_key: None,
    // rust: selected_pad_action: None,
    // rust: pad_style: GlyphStyle::Xbox,
    // rust: pad_by_letter: false,
    // rust: pad_driving: false,
    // rust: languages: Vec::new(),
    // rust: language_choice: None,
    // rust: language_search: search,
    // rust: settings_search,
    // rust: mod_browser: Default::default(),
    // rust: mod_project: String::new(),
    // rust: mods_note: None,
    // rust: mods_live: Default::default(),
    // rust: pack_browser: false,
    // rust: pack_infos: Vec::new(),
    // rust: pack_selection: Vec::new(),
    // rust: pack_screen: None,
    // rust: data_pack_dir: None,
    // rust: data_pack_resources: Default::default(),
    // rust: data_pack_stamp: (Vec::new(), Instant::now()),
    // rust: resource_error: None,
    // rust: pack_focus: Instant::now(),
    // rust: pack_reselected: false,
    // rust: in_world: false,
    // rust: minecart_improvements: false,
    // rust: center_language: false,
    // rust: graphics: Default::default(),
    // rust: controller: Default::default(),
    // rust: split_profiles: Default::default(),
    // rust: calibration: None,
    // rust: calibration_fullscreen: None,
    // rust: split_setup: Default::default(),
    // rust: studio: Default::default(),
    // rust: agent_status: Vec::new(),
    // rust: agent_recording: false,
    // rust: music_groups: Vec::new(),
    // rust: focus: None,
    // rust: focus_from_keyboard: false,
    // rust: can_change_value: false,
    // rust: size: (427.0, 240.0),
    // rust: framebuffer: [1280, 720],
    // rust: split_guest: false,
    // rust: row_bands: Vec::new(),
    // rust: wide_extras: Vec::new(),
}
}
}
button :: proc(x: f32, y: f32, w: f32, label: Text, act: Act) -> W {
    // Ported from Horizon
    return {}
}
    // rust: Widget {
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h: 20.0,
    // rust: kind: WKind::Button {
    // rust: label,
    // rust: active: true,
    // rust: act,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
}
}
inactive :: proc(mut w: Widget) -> W {
    // Ported from Horizon
    return {}
}
    // rust: if let WKind::Button { active, .. } = &mut w.kind {
    // rust: *active = false;
}
    // rust: w
}
option_widget :: proc(s: ^Settings, opt: Opt, x: f32, y: f32, w: f32) -> W {
    // Ported from Horizon
    return {}
}
    // OptionsSubScreen.addContents: the narrator button is active only while
    // the narrator is (`narratorButton.active = narrator.isActive()`).
    // rust: if !opt.available() || opt == Opt::Narrator && !horizon_narrator::is_active() {
    // rust: return inactive(button(x, y, w, opt.label(s), Act::Cycle(opt)));
}
    // VideoSettingsScreen.tick: Max Anisotropy only works with Anisotropic filtering.
    // rust: if opt == Opt::MaxAnisotropy && s.file.int("textureFiltering") != 2 {
    // rust: return inactive(button(x, y, w, opt.label(s), Act::Cycle(opt)));
}
    // rust: match opt.kind(s) {
    // rust: Kind::Slider(v) => Widget {
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h: 20.0,
    // rust: kind: WKind::Slider {
    // rust: label: opt.label(s),
    // rust: value: v,
    // rust: opt,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: },
    // rust: Kind::Cycle => button(x, y, w, opt.label(s), Act::Cycle(opt)),
}
}
// The Extras or PvP & HUD page's rows: its items under their headers.
extras_rows :: proc(page: Page) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match page {
    // rust: Page::Pvp => crate::pvp::rows()
    // rust: .into_iter()
    // rust: .map(|r| r.map(crate::extras::Item::Pvp))
    // rust: .collect(),
    // rust: _ => crate::extras::rows(),
}
}
// The items of `page`'s rows whose label, with any of their first values, is wider than a
// half-width button holds (`width` measures text with the screen's font): those take the
// whole row, so no label slides past its edges, in any language.
wide_extras :: proc(s: ^Settings, page: Page, width: impl Fn(string) -> f {
    // Ported from Horizon
    return {}
}
    // A button's label keeps 2 px off each edge (`AbstractButton.renderString`'s margin),
    // past which it slides back and forth.
    // rust: let room = 150.0 - 4.0;
    // rust: extras_rows(page)
    // rust: .into_iter()
    // rust: .filter_map(Result::ok)
    // rust: .filter(|&item| {
    // rust: let mut e = s.extras.clone();
    // rust: (0..4).any(|_| {
    // rust: let label = Text::option_name_value(
    // rust: Text::literal(item.caption_text()),
    // rust: Text::literal(item.value(&e)),
    // rust: )
    // rust: .plain();
    // rust: item.cycle(&mut e, false);
    // rust: width(&label) > room
    // rust: })
    // rust: })
    // rust: .collect()
}
// What a button opening one of Horizon's pages says on hover.
horizon_page_tooltip :: proc(page: Page) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match page {
    // rust: Page::Horizon => "horizon.pages.settings.tooltip",
    // rust: Page::Studio => "horizon.pages.studio.tooltip",
    // rust: Page::Graphics => "horizon.pages.graphics.tooltip",
    // rust: Page::GraphicsAdvanced => "horizon.pages.graphics_advanced.tooltip",
    // rust: Page::Controller => "horizon.pages.controller.tooltip",
    // rust: Page::Extras => "horizon.pages.extras.tooltip",
    // rust: Page::Pvp => "horizon.pages.pvp.tooltip",
    // rust: Page::Agent => "horizon.pages.agent.tooltip",
    // rust: Page::SplitProfiles => "horizon.pages.split_profiles.tooltip",
    // rust: Page::ShaderPacks => "horizon.pages.shader_packs.tooltip",
    // rust: Page::Mods => "horizon.pages.mods.tooltip",
    // rust: Page::SplitSetup => "horizon.pages.split_setup.tooltip",
    // rust: Page::Music => "horizon.pages.music.tooltip",
    // rust: _ => return None,
    // rust: })
}
// The open screen of the picked pack: its title, then its items two to a row (one when the
// pack asks for a single column).
// A list's slot with nothing in it: text takes no clicks.
blank_slot :: proc(w: f32) -> W {
    // Ported from Horizon
    return {}
}
    // rust: Widget {
    // rust: x: 0.0,
    // rust: y: 0.0,
    // rust: w,
    // rust: h: 20.0,
    // rust: kind: WKind::Text {
    // rust: text: Text::literal(""),
    // rust: color: 0,
    // rust: centered: false,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
}
}
// Page `at` of the options of the Horizon pack `s.shader_packs[i]`: the pack's own layout,
// else every option two a row.
native_pack_option_rows :: proc(s: ^Settings, i: uint, at: u8) -> V {
    // Ported from Horizon
    return {}
}
//     use horizon_shader_api::PageItem;
    // rust: let Some(pack) = s.shader_packs.get(i) else {
    // rust: return Vec::new();
}
    // rust: let count = pack.options.len().min(pack.values.len());
    // rust: let (columns, items) = match pack.pages.get(usize::from(at)) {
    // rust: Some(page) => (usize::from(page.columns), page.items.clone()),
    // rust: None => (2, (0..count).map(PageItem::Option).collect()),
}
    // rust: let width = if columns == 1 { 310.0 } else { 150.0 };
    // rust: let widget = |item: &PageItem| match *item {
    // rust: PageItem::Option(o) if o < count => {
    // rust: let option = &pack.options[o];
    // rust: let value = crate::shader_pack_list::show_value(&option.kind, pack.values[o]);
    // rust: let label =
    // rust: Text::option_name_value(Text::literal(option.name.clone()), Text::literal(value));
    // rust: match pack.slider_position(o) {
    // rust: Some(value) => Widget {
    // rust: x: 0.0,
    // rust: y: 0.0,
    // rust: w: width,
    // rust: h: 20.0,
    // rust: kind: WKind::PackSlider {
    // rust: label,
    // rust: value,
    // rust: pack: i,
    // rust: option: o,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: },
    // rust: None => button(0.0, 0.0, width, label, Act::NativePackOption(i, o)),
}
}
    // rust: PageItem::Page(p) if p < pack.pages.len() => {
    // rust: let label = Text::literal(format!("{}...", pack.pages[p].name));
    // rust: let page = Page::NativePackOptions(i, p as u8);
    // rust: button(0.0, 0.0, width, label, Act::Push(page))
}
    // rust: _ => blank_slot(width),
}
    // rust: let mut rows = Vec::new();
    // rust: if at == 0 {
    // rust: rows.push(Row::Note(pack.title.clone()));
}
    // rust: rows.extend(
    // rust: items
    // rust: .chunks(columns)
    // rust: .map(|row| Row::Buttons(widget(&row[0]), row.get(1).map(widget))),
    // rust: );
    // rust: rows
}
shader_option_rows :: proc(s: ^Settings) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(options) = &s.shader_options else {
    // rust: return vec![Row::Header("horizon.shader_options.loading")];
}
    // rust: let columns = options
    // rust: .screens
    // rust: .screen(options.screen())
    // rust: .map_or(2, |(_, c)| c);
    // rust: let blank = || blank_slot(150.0);
    // rust: let width = if columns == 1 { 310.0 } else { 150.0 };
    // rust: let widget = |item: &horizon_shaders::ScreenItem| -> Option<Widget> {
//         use horizon_shaders::ScreenItem;
    // rust: Some(match item {
    // rust: ScreenItem::Empty if columns > 2 => return None,
    // rust: ScreenItem::Empty => blank(),
    // rust: ScreenItem::Profile => {
    // rust: button(0.0, 0.0, width, options.profile_label(), Act::ShaderProfile)
}
    // rust: ScreenItem::Screen(name) => button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: width,
    // rust: options.screen_label(name),
    // rust: Act::ShaderScreen(name.clone()),
    // rust: ),
    // rust: ScreenItem::Option(name) => match options.slider_position(name) {
    // rust: Some(value) => Widget {
    // rust: x: 0.0,
    // rust: y: 0.0,
    // rust: w: width,
    // rust: h: 20.0,
    // rust: kind: WKind::ShaderSlider {
    // rust: label: options.option_label(name),
    // rust: value,
    // rust: name: name.clone(),
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: },
    // rust: None => button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: width,
    // rust: options.option_label(name),
    // rust: Act::ShaderOption(name.clone()),
    // rust: ),
    // rust: },
    // rust: })
}
    // rust: let widgets: Vec<Widget> = options.items().iter().filter_map(widget).collect();
    // rust: let mut rows = vec![Row::Note(options.title().strip_legacy().plain())];
    // rust: if columns == 1 {
    // rust: rows.extend(widgets.into_iter().map(|w| Row::Buttons(w, None)));
    // rust: return rows;
}
    // rust: let mut widgets = widgets.into_iter();
    // rust: while let Some(a) = widgets.next() {
    // rust: rows.push(Row::Buttons(a, widgets.next()));
}
    // rust: rows
}
// Rows of an OptionsList: (big?, options) or a header.
Row :: enum {
    Big(Opt),
    Pair(Opt, Option<Opt>),
    Header(&'static str),
    // A heading the page makes at run time, by lang key (the Music page's groups).
    Heading(String),
    // A line of grey text (a path).
    Note(String),
    Buttons(Widget, Option<Widget>),
}
// A widget's tooltip (`setTooltip`), unwrapped: drawn while hovered, and
// its narration's hint.
tooltip_text :: proc(s: ^Settings, wd: ^Widget) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let pack_text = match &wd.kind {
    // rust: WKind::Button {
    // rust: act: Act::NativePackOption(pack, option),
    // rust: ..
}
    // rust: | WKind::PackSlider { pack, option, .. } => {
    // rust: Some(&s.shader_packs.get(*pack)?.options.get(*option)?.description)
}
    // rust: WKind::Button {
    // rust: act: Act::Push(Page::NativePackOptions(pack, at)),
    // rust: ..
    // rust: } => Some(
    // rust: &s.shader_packs
    // rust: .get(*pack)?
    // rust: .pages
    // rust: .get(usize::from(*at))?
    // rust: .description,
    // rust: ),
    // rust: _ => None,
}
    // rust: if let Some(text) = pack_text {
    // rust: return (!text.is_empty()).then(|| Text::literal(text));
}
    // rust: let WKind::Button { act, .. } = &wd.kind else {
    // rust: let WKind::Slider { opt, .. } = &wd.kind else {
    // rust: return None;
}
    // rust: let key = opt.tooltip_key(s);
    // rust: return lang::has(&key).then(|| tr(&key));
}
    // rust: let mut tip = None;
    // rust: if let Act::Extra(item) = act {
    // rust: tip = Some(Text::literal(item.description_text()));
}
    // rust: if let Act::Push(page) = act
    // rust: && let Some(text) = horizon_page_tooltip(*page)
    // rust: {
    // rust: tip = Some(tr(text));
}
    // rust: let key = match act {
    // rust: Act::Cycle(opt) => Some(opt.tooltip_key(s)),
    // rust: Act::Push(Page::Language) => Some("options.language.tooltip".into()),
    // rust: Act::Push(Page::Accessibility) => Some("options.accessibility.tooltip".into()),
    // rust: Act::PvpPreset => Some("horizon.pvp.preset.tooltip".into()),
    // rust: Act::HudEditor => Some("horizon.pvp.editor.tooltip".into()),
    // rust: _ => None,
}
    // rust: if let Some(key) = key.filter(|key| lang::has(key)) {
    // rust: tip = Some(tr(&key));
}
    // rust: if let Act::Cycle(Opt::GraphicsBackend) = act {
    // rust: tip = Some(graphics_api_tooltip(s));
}
    // rust: match act {
    // rust: Act::Cycle(opt) if !opt.available() => Some(tr("horizon.options.unavailable")),
    // rust: Act::ToggleMod(i) => match s.mods.installed.get(*i) {
    // rust: Some(installed) => {
    // rust: let description = installed
    // rust: .problem
    // rust: .as_deref()
    // rust: .unwrap_or(&installed.description);
    // rust: Some(Text::literal(format!("{}\n{description}", installed.title)))
}
    // rust: None => tip,
    // rust: },
    // rust: Act::Key(name) => {
    // rust: let conflicts = s.keys.conflicts(name);
    // rust: if conflicts.is_empty() {
    // rust: return tip;
}
    // rust: let names = conflicts
    // rust: .iter()
    // rust: .map(|c| lang::get(c))
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ");
    // rust: Some(Text::translate(
    // rust: "controls.keybinds.duplicateKeybinds",
    // rust: &[Text::literal(names)],
    // rust: ))
}
    // rust: _ => tip,
}
}
// The value part of an option's message (`CycleButton.createLabelForValue`):
// its `options.generic_value` message without the caption.
option_value :: proc(opt: Opt, s: ^Settings) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let full = opt.label(s).plain();
    // rust: let marker = "\u{1}";
    // rust: let template = generic(opt.caption(), Text::literal(marker)).plain();
    // rust: match template.split_once(marker) {
    // rust: Some((before, after))
    // rust: if full.len() >= before.len() + after.len()
    // rust: && full.starts_with(before)
    // rust: && full.ends_with(after) =>
    // rust: {
    // rust: full[before.len()..full.len() - after.len()].to_owned()
}
    // rust: _ => full,
}
}
// What widget `wd` narrates, over what `ui::button` or `ui::slider`
// recorded for it (`n`): a cycle button the value a click moves to (worked
// out only while it may be narrated: under the mouse or focused), a key
// bind's buttons `narrator.controls.*`, its tooltip as a hint; a list row's
// widget belongs to the list keyed `list`.
    // rust: fn narrate_widget(
    // rust: n: &mut crate::widgets::Narratable,
    // rust: s: &Settings,
    // rust: wd: &Widget,
    // rust: hover: bool,
    // rust: list: u64,
    // rust: framebuffer: [i32; 2],
    // rust: ) {
//     use crate::widgets::What;
    // rust: if let WKind::Button { label, active, act } = &wd.kind {
    // rust: let t = |key: &str, args: &[Text]| Text::translate(key, args).plain();
    // rust: let bind = |name: Text, bound: bool| {
    // rust: if bound {
    // rust: let button = Text::translate("gui.narrate.button", std::slice::from_ref(label));
    // rust: t("narrator.controls.bound", &[name, button])
    // rust: } else {
    // rust: t("narrator.controls.unbound", &[name])
}
}
    // rust: let active = *active;
    // rust: match act {
    // rust: Act::Cycle(opt) if active => {
    // rust: let next = if hover || crate::widgets::narration_focused(n.rect) {
    // rust: let mut next = s.clone();
    // rust: opt.cycle(&mut next, false, framebuffer);
    // rust: option_value(*opt, &next)
    // rust: } else {
    // rust: String::new()
}
    // rust: n.what = What::Cycle {
    // rust: message: label.plain(),
    // rust: next,
    // rust: active,
}
}
    // rust: Act::Key(name) => {
    // rust: let bound = s.keys.get(name) != "key.keyboard.unknown";
    // rust: n.what = What::Named {
    // rust: title: bind(tr(name), bound),
    // rust: active,
}
}
    // rust: Act::ResetKey(name) => {
    // rust: n.what = What::Named {
    // rust: title: t("narrator.controls.reset", &[tr(name)]),
    // rust: active,
}
}
    // rust: _ => {}
}
}
    // rust: n.hint = tooltip_text(s, wd).map(|tip| tip.plain());
    // rust: if wd.list {
        // Stable while the list scrolls: its row and column.
    // rust: n.key = crate::widgets::key_of(&(list, wd.row, wd.x.round() as i32));
    // rust: n.parent = Some((list, wd.row));
}
}
// A list's rows as they are laid out: the row of each widget pushed and
// each row's band, for the narration (`ContainerObjectSelectionList`'s
// entries and the one under the mouse).
ListRows :: struct {
    start: uint,
    top: f32,
    bands: Vec<[f32,
}
    // rust: impl ListRows {
    // A row starts at `y` with the next widget pushed.
begin :: proc(self: ^Self, out: ^[Widget], y: f32) {
}
    // rust: self.start = out.len();
    // rust: self.top = y;
}
    // The row ends at `y`: the widgets pushed since `begin` are in it.
end :: proc(self: ^Self, out: ^[Widget], y: f32) {
}
    // rust: let row = self.bands.len();
    // rust: out[self.start..].iter_mut().for_each(|w| w.row = row);
    // rust: self.bands.push([self.top, y]);
}
}
pairs :: proc(opts: ^[Opt]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: opts.chunks(2)
    // rust: .map(|c| Row::Pair(c[0], c.get(1).copied()))
    // rust: .collect()
}
    // rust: impl OptionsUi {
    // No widget keeps the highlight a click gave it; a focus the keyboard
    // moved stays.
clear_click_focus :: proc(self: ^Self) {
}
    // rust: if !self.focus_from_keyboard {
    // rust: self.focus = None;
}
}
    // A switch of `horizon-extras.txt` as the Extras page draws it: "Caption: On".
extra_button :: proc(self: ^Self, s: ^Settings, item: crate::extras::Item) -> W {
    // Ported from Horizon
    return {}
}
    // rust: let label = Text::option_name_value(
    // rust: Text::literal(item.caption_text()),
    // rust: Text::literal(item.value(&s.extras)),
    // rust: );
    // rust: button(0.0, 0.0, 150.0, label, Act::Extra(item))
}
settings_search_active :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.settings_search.focused
    // rust: && matches!(
    // rust: self.page(),
    // rust: Page::Video | Page::Controls | Page::KeyBinds | Page::ModBrowser
    // rust: )
}
    // Whether the resource pack screen is open (not Create World's data packs on the same
    // page).
resource_packs_open :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.page() == Page::Packs && self.data_pack_dir.is_none()
}
    // The packs in `resourcepacks/` changed while the pack screen is open
    // (`PackSelectionScreen`'s directory watcher): the screen is made again over
    // `infos`, keeping the selection made on it so far.
update_pack_infos :: proc(self: ^Self, infos: [dynamic]crate::pack_screen::PackInfo) {
}
    // rust: if let Some(p) = self.pack_screen.take()
    // rust: && p.changed
    // rust: {
    // rust: self.pack_selection = p.commit();
    // rust: self.pack_reselected = true;
}
    // rust: self.pack_infos = infos;
}
page :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: *self.stack.last().unwrap_or(&Page::Main)
}
    // Whether the screen's focus is a search box that takes the keys (an
    // `EditBox` that `canConsumeInput`): the language list's, the settings
    // search, or the pack screen's.
typing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.resource_error.is_none()
    // rust: && match self.page() {
    // rust: Page::Language => true,
    // rust: Page::Packs => self
    // rust: .pack_screen
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.search_focused()),
    // rust: Page::Graphics | Page::GraphicsAdvanced | Page::GraphicsHdr => {
    // rust: self.graphics.typing()
}
    // rust: Page::Controller | Page::PadBinds => self.controller.typing(),
    // rust: _ => self.settings_search_active(),
}
}
    // Jump straight to a page (control socket / tests).
show :: proc(self: ^Self, page: Page) {
}
    // rust: if page != Page::Main {
    // rust: self.push(page);
}
}
open :: proc(self: ^Self, in_world: bool) {
}
    // rust: self.open_at(in_world, Page::Main);
}
    // Create World's Data Packs (`openDataPackSelectionScreen`): the Packs
    // page on the new world's pack folder `dir`, `selected` chosen;
    // `resources` holds the built-in pack's icon.
    // rust: pub fn open_data_packs(
    // rust: &mut self,
    // rust: dir: std::path::PathBuf,
    // rust: selected: Vec<String>,
    // rust: resources: std::path::PathBuf,
    // rust: ) {
    // rust: self.open_at(false, Page::Packs);
    // rust: self.pack_infos = crate::datapack::screen_packs(&dir, &resources);
    // rust: self.data_pack_resources = resources;
    // rust: self.pack_selection = selected;
    // rust: self.data_pack_stamp = (crate::datapack::folder_stamp(&dir), Instant::now());
    // rust: self.data_pack_dir = Some(dir);
}
    // `PackSelectionScreen.tick`'s watcher: once a second, the Data Packs
    // folder's packs are listed again if it changed, the selection kept
    // (the search text and scroll start over).
watch_data_packs :: proc(self: ^Self, atlas: ^HudAtlas, size: (f32) {
}
    // rust: let Some(dir) = &self.data_pack_dir else {
    // rust: return;
}
    // rust: if self.data_pack_stamp.1.elapsed().as_secs() < 1 {
    // rust: return;
}
    // rust: let stamp = crate::datapack::folder_stamp(dir);
    // rust: let changed = stamp != self.data_pack_stamp.0;
    // rust: self.data_pack_stamp = (stamp, Instant::now());
    // rust: if !changed {
    // rust: return;
}
    // rust: self.pack_infos = crate::datapack::screen_packs(dir, &self.data_pack_resources);
    // rust: if let Some(p) = self.pack_screen.take() {
    // rust: self.pack_selection = p.commit();
    // rust: self.packs(atlas, size).changed = p.changed;
}
}
    // Steps a slider option forward or backward, derived from its own slider definition.
    // rust: pub fn step_slider_option(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: opt: Opt,
    // rust: forward: bool,
    // rust: width: f32,
    // rust: ) -> Vec<Event> {
    // rust: let volume = |s: &Settings| match opt {
    // rust: Opt::Volume(0) => Some(s.master_volume),
    // rust: Opt::Volume(i) => Some(s.volumes[i]),
    // rust: _ => None,
}
    // rust: let before_vol = volume(s);
    // rust: opt.step_slider(s, forward, width);
    // rust: self.slider_value = None;
    // rust: let mut events = vec![Event::Changed, Event::SliderDrag];
    // rust: if let (Opt::Volume(source), Some(after)) = (opt, volume(s))
    // rust: && before_vol != Some(after)
    // rust: {
    // rust: events.push(Event::Volume(source, after));
}
    // rust: events
}
    // Steps a Horizon pack's option slider one step forward or backward, and saves it.
step_pack_slider :: proc(s: ^Settings, pack: uint, option: uint, forward: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let stepped = s
    // rust: .shader_packs
    // rust: .get_mut(pack)
    // rust: .is_some_and(|entry| entry.nudge_option(option, !forward));
    // rust: if stepped {
    // rust: vec![Event::NativePackOptions(pack)]
    // rust: } else {
    // rust: Vec::new()
}
}
    // Open a page whose Done/Escape returns directly to the calling screen.
open_at :: proc(self: ^Self, in_world: bool, page: Page) {
}
    // rust: self.stack.clear();
    // rust: self.data_pack_dir = None;
    // rust: self.focus = None;
    // rust: self.focus_from_keyboard = false;
    // rust: self.can_change_value = false;
    // rust: self.push(page);
    // rust: self.in_world = in_world;
    // rust: self.selected_key = None;
}
push :: proc(self: ^Self, page: Page) {
}
    // rust: self.stack.push(page);
    // rust: self.scroll = 0.0;
    // rust: self.scrollbar_drag_y = None;
    // rust: self.focus = None;
    // rust: self.focus_from_keyboard = false;
    // rust: self.can_change_value = false;
    // rust: if matches!(
    // rust: page,
    // rust: Page::Video | Page::Controls | Page::KeyBinds | Page::ModBrowser
    // rust: ) {
    // rust: self.settings_search.set_value("");
    // rust: self.settings_search.focused = false;
}
    // rust: if page == Page::Language {
    // rust: self.language_choice = None;
    // rust: self.language_search.set_value("");
    // rust: self.center_language = true;
}
    // rust: if page == Page::Packs {
    // rust: self.pack_screen = None;
}
    // rust: if let Some(at) = Self::graphics_page(page) {
    // rust: self.graphics.open(at);
}
    // rust: if let Some(at) = Self::controller_page(page) {
    // rust: self.controller.open(at);
}
    // rust: if page == Page::SplitSetup {
    // rust: self.split_setup.reset();
}
    // rust: if page == Page::SplitProfiles {
    // rust: self.split_profiles.reset();
}
    // rust: if page == Page::Studio {
    // rust: self.studio.refresh();
}
}
    // What the graphics screen's actions do to these options.
    // rust: fn graphics_events(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: actions: Vec<crate::graphics_ui::Action>,
    // rust: ) -> Vec<Event> {
//         use crate::graphics_ui::Action;
    // rust: let mut events = Vec::new();
    // rust: for action in actions {
    // rust: match action {
    // rust: Action::ButtonClick => events.push(Event::ButtonClick),
    // rust: Action::Changed => events.push(Event::Changed),
    // rust: Action::SliderDrag => events.push(Event::SliderDrag),
    // rust: Action::BindKey(name) => self.selected_key = Some(name),
    // rust: Action::Calibrate => {
    // rust: self.calibration = Some(crate::hdr_calibration::Calibration::new(s));
    // rust: self.push(Page::HdrCalibration);
}
                // The Shaders page's Shader Packs...: the list of either kind, as the page
                // opens it from anywhere.
    // rust: Action::ShaderPacks => {
    // rust: events.push(Event::ListShaderPacks);
    // rust: self.push(Page::ShaderPacks);
}
    // rust: Action::Done => events.extend(self.back(s)),
}
}
    // rust: events
}
    // What the controller screen's actions do to these options.
    // rust: fn controller_events(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: actions: Vec<crate::controller_ui::Action>,
    // rust: ) -> Vec<Event> {
//         use crate::controller_ui::Action;
    // rust: let mut events = Vec::new();
    // rust: for action in actions {
    // rust: match action {
    // rust: Action::ButtonClick => events.push(Event::ButtonClick),
    // rust: Action::Changed => events.push(Event::Changed),
    // rust: Action::SliderDrag => events.push(Event::SliderDrag),
    // rust: Action::BindPad(action) => self.selected_pad_action = Some(action),
    // rust: Action::Done => events.extend(self.back(s)),
}
}
    // rust: events
}
    // Where the controller screen opens for `page`, if it is one of its pages.
controller_page :: proc(page: Page) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match page {
    // rust: Page::Controller => Some(crate::controller_ui::Page::General),
    // rust: Page::PadBinds => Some(crate::controller_ui::Page::Bindings),
    // rust: _ => None,
}
}
    // Whether a video settings screen is open, Horizon's or vanilla's: the fullscreen mode
    // waits for it to close, and Ctrl with the wheel steps the GUI scale.
video_open :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.page() == Page::Video || Self::graphics_page(self.page()).is_some()
}
    // Whether the controller screen is open: a controller button pressed now may bind.
controller_open :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Self::controller_page(self.page()).is_some()
}
    // Where the graphics screen opens for `page`, if it is one of its pages.
graphics_page :: proc(page: Page) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match page {
    // rust: Page::Graphics => Some(crate::graphics_ui::Page::General),
    // rust: Page::GraphicsAdvanced => Some(crate::graphics_ui::Page::Advanced),
    // rust: Page::GraphicsHdr => Some(crate::graphics_ui::Page::Hdr),
    // rust: _ => None,
}
}
    // The name of a Horizon pack's options page past its first, as the page's title.
pack_page_title :: proc(s: ^Settings, page: Page) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Page::NativePackOptions(pack, at @ 1..) = page else {
    // rust: return None;
}
    // rust: let page = s.shader_packs.get(pack)?.pages.get(usize::from(at))?;
    // rust: Some(Text::literal(&page.name))
}
title :: proc(page: Page) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match page {
    // rust: Page::Main => "options.title",
    // rust: Page::Video => "options.videoTitle",
    // rust: Page::Sound => "options.sounds.title",
    // rust: Page::Skin => "options.skinCustomisation.title",
    // rust: Page::Online => "options.online.title",
    // rust: Page::Controls => "controls.title",
    // rust: Page::KeyBinds => "controls.keybinds.title",
    // rust: Page::Mouse => "options.mouse_settings.title",
    // rust: Page::Chat => "options.chat.title",
    // rust: Page::Accessibility => "options.accessibility.title",
    // rust: Page::Language => "options.language.title",
    // rust: Page::Font => "options.font.title",
    // rust: Page::Packs => "resourcePack.title",
    // rust: Page::Mods => "horizon.pages.mods",
    // rust: Page::ModBrowser => "horizon.mods.browse.title",
    // rust: Page::ModProject => "horizon.mods.browse.project",
    // rust: Page::NativeMod(_) => "Mod Settings",
    // rust: Page::ShaderPacks => "horizon.pages.shader_packs",
    // rust: Page::ShaderOptions | Page::NativePackOptions(..) => "horizon.pages.shader_options",
    // rust: Page::Graphics | Page::GraphicsAdvanced | Page::GraphicsHdr | Page::HdrCalibration => {
    // rust: "options.videoTitle"
}
    // rust: Page::Controller | Page::PadBinds => "horizon.pages.controller",
    // rust: Page::Extras => "horizon.pages.extras",
    // rust: Page::Pvp => "horizon.pages.pvp",
    // rust: Page::Credits => "credits_and_attribution.screen.title",
    // rust: Page::Horizon => "horizon.pages.settings",
    // rust: Page::Studio => "horizon.pages.studio",
    // rust: Page::Agent => "horizon.pages.agent",
    // rust: Page::SplitProfiles => "horizon.pages.split_profiles",
    // rust: Page::SplitSetup => "horizon.pages.split_setup",
    // rust: Page::Music => "horizon.pages.music",
}
}
scrollbar_x :: proc(self: ^Self, width: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (width / 2.0).floor()
    // rust: + match self.page() {
    // rust: Page::KeyBinds => 178.0,
    // rust: Page::Language => 118.0,
    // rust: _ => 163.0,
}
}
filter_option_rows :: proc(self: ^Self, rows: [dynamic]Row) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let query = self.settings_search.value.to_lowercase();
    // rust: if query.is_empty() {
    // rust: return rows;
}
    // rust: let mut filtered = Vec::new();
    // rust: let mut pending_header = None;
    // rust: for row in rows {
    // rust: let matches = |opt: Opt| lang::get(opt.caption()).to_lowercase().contains(&query);
    // rust: let visible = match row {
    // rust: Row::Header(key) => {
    // rust: pending_header = Some(key);
    // rust: continue;
}
    // rust: Row::Big(opt) if matches(opt) => vec![Row::Big(opt)],
    // rust: Row::Pair(a, b) => pairs(
    // rust: &[Some(a), b]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|opt| matches(*opt))
    // rust: .collect::<Vec<_>>(),
    // rust: ),
                // Keep navigation available regardless of the query.
    // rust: Row::Buttons(a, b) => {
    // rust: filtered.push(Row::Buttons(a, b));
    // rust: continue;
}
    // rust: _ => Vec::new(),
}
    // rust: if !visible.is_empty() {
                // Emit a section heading only when its first matching option is found.
    // rust: if let Some(key) = pending_header.take() {
    // rust: filtered.push(Row::Header(key));
}
    // rust: filtered.extend(visible);
}
}
    // rust: filtered
}

    // Browse mods: what the registry offers this game, by the search box.
mod_browser_rows :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
//         use crate::mod_browser::Status;
    // rust: let b = &self.mod_browser;
    // rust: match &b.status {
    // rust: Status::Idle | Status::Loading => {
    // rust: return vec![Row::Note(lang::get("horizon.mods.browse.loading"))];
}
    // rust: Status::Failed(why) => {
    // rust: return vec![Row::Note(lang::tr("horizon.mods.browse.failed", &[why]))];
}
    // rust: Status::Ready => {}
}
    // rust: let found = b.found(&self.settings_search.value);
    // rust: if found.is_empty() {
    // rust: return vec![Row::Note(lang::get("horizon.mods.browse.none"))];
}
    // rust: let mut rows = Vec::new();
    // rust: for i in found {
    // rust: let l = &b.listings[i];
    // rust: let mut label = Text::literal(format!("{} {}", l.name, l.version));
    // rust: if l.has_update() {
    // rust: label = label.append(tr("horizon.mods.browse.has_update"));
    // rust: } else if l.installed.is_some() {
    // rust: label = label.append(tr("horizon.mods.browse.is_installed"));
}
    // rust: rows.push(Row::Buttons(
    // rust: button(0.0, 0.0, 310.0, label, Act::ModProject(i)),
    // rust: None,
    // rust: ));
    // rust: rows.extend(wrap(&l.summary, 64).into_iter().take(1).map(Row::Note));
}
    // rust: rows
}
    // A registry project's page: what it is, Install or Update, its switch
    // once installed, its description and changelog.
    // A content mod's set feeds the block-state tables the open world's
    // chunks were decoded with: changing it mid-world remaps their ids
    // (Forge/Fabric freeze the registry before a world opens). One with only
    // assets and data reloads live, and a native mod toggles live through
    // `native_on`, so they stay available.
mod_frozen :: proc(self: ^Self, installed: ^crate::mod_list::Installed) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.in_world && installed.native.is_none() && !self.mods_live.contains(&installed.id)
}
mod_project_rows :: proc(self: ^Self, s: ^Settings) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let b = &self.mod_browser;
    // rust: let Some(l) = b.listing(&self.mod_project) else {
    // rust: return vec![Row::Note(lang::get("horizon.mods.browse.none"))];
}
    // rust: let mut rows = vec![Row::Note(format!("{} {}", l.name, l.version))];
    // rust: let by = [
    // rust: lang::tr("horizon.mods.browse.by", &[&l.authors.join(", ")]),
    // rust: l.license.clone(),
    // rust: l.published.clone(),
    // rust: ];
    // rust: let by: Vec<&str> = by
    // rust: .iter()
    // rust: .map(String::as_str)
    // rust: .filter(|t| !t.is_empty())
    // rust: .collect();
    // rust: rows.push(Row::Note(by.join(" · ")));
    // rust: let labels: Vec<&str> = l
    // rust: .categories
    // rust: .iter()
    // rust: .chain(&l.tags)
    // rust: .map(String::as_str)
    // rust: .collect();
    // rust: if !labels.is_empty() {
    // rust: rows.push(Row::Note(labels.join(", ")));
}
    // rust: let installing = b.installing.as_deref() == Some(l.id.as_str());
    // rust: let install = match (&l.installed, installing) {
    // rust: (_, true) => inactive(button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("horizon.mods.browse.installing"),
    // rust: Act::None,
    // rust: )),
    // rust: (None, false) => button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("horizon.mods.browse.install"),
    // rust: Act::InstallMod,
    // rust: ),
    // rust: (Some(_), false) if l.has_update() => button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("horizon.mods.browse.update"),
    // rust: Act::InstallMod,
    // rust: ),
    // rust: (Some(_), false) => inactive(button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("horizon.mods.browse.installed"),
    // rust: Act::None,
    // rust: )),
}
    // rust: let page = button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("horizon.mods.browse.open_page"),
    // rust: Act::OpenModPage,
    // rust: );
    // rust: let row = s.mods.installed.iter().position(|m| m.id == l.id && !m.dev);
    // rust: match row.filter(|_| l.installed.is_some()) {
    // rust: Some(i) => {
    // rust: let label =
    // rust: Text::literal(format!("{}: ", lang::get("horizon.mods.browse.enabled")))
    // rust: .append(on_off(s.mods.is_on(i)));
    // rust: let toggle = button(0.0, 0.0, 150.0, label, Act::ToggleMod(i));
    // rust: let toggle = match self.mod_frozen(&s.mods.installed[i]) {
    // rust: true => inactive(toggle),
    // rust: false => toggle,
}
    // rust: rows.push(Row::Buttons(install, Some(toggle)));
    // rust: rows.push(Row::Buttons(page, None));
}
    // rust: None => rows.push(Row::Buttons(install, Some(page))),
}
    // rust: if let Some((message, _)) = &b.message {
    // rust: rows.extend(wrap(message, 64).into_iter().map(Row::Note));
}
    // rust: let description = crate::mod_browser::plain_lines(if l.description.is_empty() {
    // rust: &l.summary
    // rust: } else {
    // rust: &l.description
    // rust: });
    // rust: rows.extend(
    // rust: description
    // rust: .iter()
    // rust: .flat_map(|line| wrap(line, 64))
    // rust: .map(Row::Note),
    // rust: );
    // rust: let changelog = crate::mod_browser::plain_lines(&l.changelog);
    // rust: if !changelog.is_empty() {
    // rust: rows.push(Row::Heading("horizon.mods.browse.changelog".into()));
    // rust: rows.extend(
    // rust: changelog
    // rust: .iter()
    // rust: .flat_map(|line| wrap(line, 64))
    // rust: .map(Row::Note),
    // rust: );
}
    // rust: rows
}
    // A native mod's page: its name, its keys as Key Binds rows (the
    // player's choice, else the default), then its buttons.
native_rows :: proc(self: ^Self, s: ^Settings, i: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(m) = s.mods.installed.get(i) else {
    // rust: return Vec::new();
}
    // rust: let mut rows = vec![Row::Note(m.title.clone())];
    // rust: let Some(page) = &m.native else {
    // rust: return rows;
}
    // rust: let chosen = s.mods.keys.get(&m.id);
    // rust: for (k, [name, label, default]) in page.keys.iter().enumerate() {
    // rust: let key = chosen.and_then(|c| c.get(name)).unwrap_or(default);
    // rust: let mut message = keybinds::display_name(key);
    // rust: if self.selected_native_key == Some((i, k)) {
    // rust: message = Text::literal("> ")
    // rust: .append(message.with_color(text::WHITE))
    // rust: .append(" <")
    // rust: .with_color(text::YELLOW);
}
    // rust: let caption = button(0.0, 0.0, 150.0, Text::literal(label.clone()), Act::None);
    // rust: let change = button(0.0, 0.0, 150.0, message, Act::NativeKey(i, k));
    // rust: rows.push(Row::Buttons(inactive(caption), Some(change)));
}
    // rust: for (b, label) in page.buttons.iter().enumerate() {
    // rust: let widget = button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 310.0,
    // rust: Text::literal(label.clone()),
    // rust: Act::NativeButton(i, b),
    // rust: );
    // rust: rows.push(Row::Buttons(widget, None));
}
    // rust: rows
}

list_rows :: proc(self: ^Self, s: ^Settings) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match self.page() {
    // rust: Page::SplitSetup => Vec::new(),
    // rust: Page::Extras | Page::Pvp => {
                // Each section's switches two to a row, as vanilla's
                // OptionsList.addSmall lays out an options screen; one whose label would run
                // past half a row in this language (`wide_extras`) gets the whole row.
    // rust: let extra = |item: crate::extras::Item, width: f32| {
    // rust: let value = Text::option_name_value(
    // rust: Text::literal(item.caption_text()),
    // rust: Text::literal(item.value(&s.extras)),
    // rust: )
    // rust: .plain();
    // rust: let label = if item.key_name().is_some() && self.selected_key == item.key_name()
    // rust: {
    // rust: Text::literal(format!("> {value} <")).with_color(text::YELLOW)
    // rust: } else {
    // rust: Text::literal(value)
}
    // rust: let widget = button(0.0, 0.0, width, label, Act::Extra(item));
                    // A setting of a switch that is off does nothing: inactive,
                    // as vanilla greys out an option that can't apply.
    // rust: if item
    // rust: .parent()
    // rust: .is_some_and(|parent| parent.switch(&s.extras) == Some(false))
    // rust: {
    // rust: inactive(widget)
    // rust: } else {
    // rust: widget
}
}
                // PvP & HUD opens with its preset; Extras doesn't repeat it, nor the way there
                // (Horizon Settings has it).
    // rust: let preset = button(0.0, 0.0, 150.0, tr("horizon.pvp.preset"), Act::PvpPreset);
    // rust: let mut rows = Vec::new();
    // rust: if self.page() == Page::Pvp {
                    // The editor moves what the game shows: only from a world.
    // rust: let edit = button(0.0, 0.0, 150.0, tr("horizon.pvp.editor"), Act::HudEditor);
    // rust: let edit = if self.in_world { edit } else { inactive(edit) };
    // rust: rows.push(Row::Buttons(preset, Some(edit)));
}
    // rust: let mut section = Vec::new();
    // rust: let flush = |rows: &mut Vec<Row>, section: &mut Vec<crate::extras::Item>| {
    // rust: let mut half = None;
    // rust: for item in section.drain(..) {
    // rust: if self.wide_extras.contains(&item) {
    // rust: rows.extend(half.take().map(|h| Row::Buttons(extra(h, 150.0), None)));
    // rust: rows.push(Row::Buttons(extra(item, 310.0), None));
    // rust: } else if let Some(h) = half.take() {
    // rust: rows.push(Row::Buttons(extra(h, 150.0), Some(extra(item, 150.0))));
    // rust: } else {
    // rust: half = Some(item);
}
}
    // rust: rows.extend(half.map(|h| Row::Buttons(extra(h, 150.0), None)));
}
    // rust: for row in extras_rows(self.page()) {
    // rust: match row {
    // rust: Err(header) => {
    // rust: flush(&mut rows, &mut section);
    // rust: rows.push(Row::Header(header));
}
    // rust: Ok(item) => section.push(item),
}
}
    // rust: flush(&mut rows, &mut section);
    // rust: rows
}
    // rust: Page::Horizon => {
                // Two to a row, as vanilla's OptionsList.addSmall lays out
                // buttons; each opens one of Horizon's settings pages. Each page has
                // one way in: graphics and shader packs are Video Settings' (the graphics
                // screen), the controller is Controls', mods are the Options screen's.
    // rust: let open =
    // rust: |key: &str, page: Page| button(0.0, 0.0, 150.0, tr(key), Act::Push(page));
    // rust: vec![
    // rust: Row::Buttons(
    // rust: open("horizon.pages.open.extras", Page::Extras),
    // rust: Some(open("horizon.pages.open.pvp", Page::Pvp)),
    // rust: ),
    // rust: Row::Buttons(
    // rust: open(
    // rust: "horizon.pages.open.split_setup",
    // rust: if self.split_guest {
    // rust: Page::SplitProfiles
    // rust: } else {
    // rust: Page::SplitSetup
    // rust: },
    // rust: ),
    // rust: Some(open("horizon.pages.open.studio", Page::Studio)),
    // rust: ),
                    // No AI hides the AI Agent page and everything AI.
    // rust: Row::Buttons(
    // rust: self.extra_button(s, crate::extras::Item::DiscordPresence),
    // rust: Some(if s.extras.no_ai {
    // rust: self.extra_button(s, crate::extras::Item::NoAi)
    // rust: } else {
    // rust: open("horizon.pages.open.agent", Page::Agent)
    // rust: }),
    // rust: ),
    // rust: ]
    // rust: .into_iter()
    // rust: .chain(
    // rust: (!s.extras.no_ai).then(|| {
    // rust: Row::Buttons(self.extra_button(s, crate::extras::Item::NoAi), None)
    // rust: }),
    // rust: )
    // rust: .collect()
}
    // rust: Page::Agent => {
    // rust: let mut rows = vec![Row::Buttons(
    // rust: self.extra_button(s, crate::extras::Item::AgentControl),
    // rust: Some(button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("horizon.agent.copy_details"),
    // rust: Act::CopyAgentDetails,
    // rust: )),
    // rust: )];
    // rust: rows.push(Row::Buttons(
    // rust: button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr(if self.agent_recording {
    // rust: "horizon.agent.record_stop"
    // rust: } else {
    // rust: "horizon.agent.record_session"
    // rust: }),
    // rust: Act::ToggleRecording,
    // rust: ),
    // rust: Some(button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("horizon.agent.export_repro"),
    // rust: Act::ExportRepro,
    // rust: )),
    // rust: ));
    // rust: rows.push(Row::Buttons(
    // rust: self.extra_button(s, crate::extras::Item::ReproKeys),
    // rust: None,
    // rust: ));
    // rust: rows.extend(self.agent_status.iter().cloned().map(Row::Note));
    // rust: rows
}
    // rust: Page::Video => {
                // Vanilla's VideoSettingsScreen as vanilla lays it out. No menu opens it (Video
                // Settings... opens the graphics screen, which has all of it); it stays for
                // `horizon-ctl options video-vanilla` and the tests that pin vanilla's screen.
    // rust: let mut rows = vec![Row::Header("options.video.display.header")];
    // rust: rows.push(Row::Big(Opt::ExclusiveMode));
    // rust: rows.extend(pairs(&[
    // rust: Opt::MaxFps,
    // rust: Opt::Vsync,
    // rust: Opt::InactivityFps,
    // rust: Opt::GuiScale,
    // rust: Opt::Fullscreen,
    // rust: Opt::ExclusiveFullscreen,
    // rust: Opt::Gamma,
    // rust: Opt::GraphicsBackend,
    // rust: ]));
    // rust: rows.push(Row::Header("options.video.quality.header"));
    // rust: rows.push(Row::Big(Opt::Preset));
    // rust: rows.extend(pairs(&[
    // rust: Opt::BiomeBlend,
    // rust: Opt::RenderDistance,
    // rust: Opt::ChunkBuilder,
    // rust: Opt::SimulationDistance,
    // rust: Opt::SmoothLighting,
    // rust: Opt::Clouds,
    // rust: Opt::Particles,
    // rust: Opt::Mipmaps,
    // rust: Opt::EntityShadows,
    // rust: Opt::EntityDistance,
    // rust: Opt::MenuBlur,
    // rust: Opt::CloudRange,
    // rust: Opt::CutoutLeaves,
    // rust: Opt::ImprovedTransparency,
    // rust: Opt::TextureFiltering,
    // rust: Opt::MaxAnisotropy,
    // rust: Opt::WeatherRadius,
    // rust: ]));
    // rust: rows.push(Row::Header("options.video.preferences.header"));
    // rust: rows.extend(pairs(&[
    // rust: Opt::Autosave,
    // rust: Opt::Vignette,
    // rust: Opt::AttackIndicator,
    // rust: Opt::ChunkFade,
    // rust: ]));
    // rust: self.filter_option_rows(rows)
}
    // rust: Page::Sound => {
                // SoundOptionsScreen, without Audio Device: Horizon opens the
                // output device itself and cannot switch it.
    // rust: let mut rows = vec![Row::Big(Opt::Volume(0))];
    // rust: let others: Vec<Opt> = (1..SOUND_SOURCES.len()).map(Opt::Volume).collect();
    // rust: rows.extend(pairs(&others));
    // rust: rows.extend(pairs(&[Opt::ShowSubtitles, Opt::DirectionalAudio]));
    // rust: rows.extend(pairs(&[Opt::MusicFrequency, Opt::MusicToast]));
    // rust: rows.push(Row::Big(Opt::SoundDevice));
                // Horizon's music page (an extra): the built-in tracks, by
                // situation, once it is on in Horizon Extras.
    // rust: if s.extras.music_page {
    // rust: rows.push(Row::Buttons(
    // rust: button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 310.0,
    // rust: tr("horizon.pages.open.music"),
    // rust: Act::Push(Page::Music),
    // rust: ),
    // rust: None,
    // rust: ));
}
    // rust: rows
}
    // rust: Page::Music => {
    // rust: if self.music_groups.is_empty() {
    // rust: return vec![Row::Header("horizon.pages.music.empty")];
}
    // rust: let mut rows = Vec::new();
    // rust: for group in &self.music_groups {
    // rust: rows.push(Row::Heading(group.label.clone()));
    // rust: for track in &group.tracks {
                        // Left: the track, played now. Right: whether its pool
                        // still picks it (vanilla until one is turned off).
    // rust: let on = !s.extras.music_off.contains(&track.id);
    // rust: let play = button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: Text::literal(track_name(&track.id).to_owned()),
    // rust: Act::PlayMusicTrack(track.event.clone(), track.id.clone()),
    // rust: );
    // rust: let toggle = button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: on_off(on),
    // rust: Act::MusicTrackOn(track.id.clone(), on),
    // rust: );
    // rust: rows.push(Row::Buttons(play, Some(toggle)));
}
}
    // rust: rows
}
    // rust: Page::Skin => {
                // SkinCustomizationScreen: the seven layers, then Main Hand.
    // rust: let mut opts: Vec<Opt> = (0..MODEL_PART_KEYS.len()).map(Opt::ModelPart).collect();
                // Horizon's own: the outer layer as real pixels, not one box.
    // rust: opts.push(Opt::SkinLayers3d);
    // rust: opts.push(Opt::MainHand);
    // rust: pairs(&opts)
}
    // rust: Page::Online => {
                // OnlineOptionsScreen without the Xbox and friends-list parts.
    // rust: let mut rows = vec![Row::Header("options.online.friends.header")];
    // rust: rows.extend(pairs(&[Opt::InGameNotification, Opt::SharePresence]));
    // rust: rows.push(Row::Header("options.online.servers.header"));
    // rust: rows.push(Row::Big(Opt::AllowServerListing));
    // rust: rows.push(Row::Header("options.online.realms.header"));
    // rust: rows.push(Row::Big(Opt::RealmsNotifications));
    // rust: rows
}
    // rust: Page::Controls => {
    // rust: let mut rows = vec![Row::Buttons(
    // rust: button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("options.mouse_settings"),
    // rust: Act::Push(Page::Mouse),
    // rust: ),
    // rust: Some(button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("controls.keybinds"),
    // rust: Act::Push(Page::KeyBinds),
    // rust: )),
    // rust: )];
    // rust: let controls = vanilla_control_options();
    // rust: rows.extend(pairs(&controls));
                // Horizon's controller page, after vanilla's rows.
    // rust: rows.push(Row::Buttons(
    // rust: button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 310.0,
    // rust: tr("horizon.pages.open.controller"),
    // rust: Act::Push(Page::Controller),
    // rust: ),
    // rust: None,
    // rust: ));
    // rust: self.filter_option_rows(rows)
}
    // rust: Page::Mouse => pairs(MOUSE_OPTIONS),
    // rust: Page::Chat => pairs(&[
    // rust: Opt::ChatVisibility,
    // rust: Opt::ChatColors,
    // rust: Opt::ChatLinks,
    // rust: Opt::ChatLinksPrompt,
    // rust: Opt::ChatOpacity,
    // rust: Opt::TextBackgroundOpacity,
    // rust: Opt::ChatScale,
    // rust: Opt::ChatLineSpacing,
    // rust: Opt::ChatWidth,
    // rust: Opt::ChatHeightFocused,
    // rust: Opt::ChatHeightUnfocused,
    // rust: Opt::Narrator,
    // rust: Opt::AutoSuggestions,
    // rust: Opt::HideMatchedNames,
    // rust: Opt::ReducedDebugInfo,
    // rust: Opt::OnlySecureChat,
    // rust: Opt::SaveChatDrafts,
    // rust: ]),
    // rust: Page::Accessibility => {
    // rust: let mut rows = vec![Row::Buttons(
    // rust: option_widget(s, Opt::Narrator, 0.0, 0.0, 150.0),
    // rust: Some(button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("options.controls"),
    // rust: Act::Push(Page::Controls),
    // rust: )),
    // rust: )];
    // rust: rows.extend(pairs(&ACCESSIBILITY_OPTIONS[1..]));
    // rust: rows
}
    // rust: Page::Font => pairs(&[Opt::ForceUnicode, Opt::JapaneseGlyphs]),
    // rust: Page::Mods => {
    // rust: let browse = button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 310.0,
    // rust: tr("horizon.mods.browse"),
    // rust: Act::Push(Page::ModBrowser),
    // rust: );
    // rust: let mut rows = vec![Row::Buttons(browse, None)];
    // rust: if let Some(note) = &self.mods_note {
    // rust: rows.extend(wrap(note, 64).into_iter().map(Row::Note));
}
    // rust: if s.mods.installed.is_empty() {
    // rust: rows.push(Row::Header("horizon.mods.empty"));
    // rust: return rows;
}
    // rust: rows.extend(s.mods.installed.iter().enumerate().map(|(i, installed)| {
    // rust: let mut label = Text::option_name_value(
    // rust: Text::literal(installed.title.clone()),
    // rust: on_off(s.mods.is_on(i)),
    // rust: );
    // rust: if installed.problem.as_deref() == Some(crate::mod_list::NOT_BUILT) {
    // rust: label = label.append(tr("horizon.mods.not_built"));
    // rust: } else if installed.problem.is_some() {
    // rust: label = label.append(tr("horizon.mods.stopped"));
    // rust: } else if installed.dev {
    // rust: label = label.append(tr("horizon.mods.dev"));
}
    // rust: let frozen = self.mod_frozen(installed);
    // rust: if frozen {
    // rust: label = label.append(tr("horizon.mods.in_world"));
}
    // rust: let dead = installed.dev || installed.id.is_empty() || frozen;
                    // Only native mods with actual settings need a second button.
    // rust: if installed
    // rust: .native
    // rust: .as_ref()
    // rust: .is_some_and(|page| !page.keys.is_empty() || !page.buttons.is_empty())
    // rust: {
    // rust: let toggle = button(0.0, 0.0, 150.0, label, Act::ToggleMod(i));
    // rust: let settings = button(
    // rust: 0.0,
    // rust: 0.0,
    // rust: 150.0,
    // rust: tr("horizon.mods.settings"),
    // rust: Act::ModSettings(i),
    // rust: );
    // rust: Row::Buttons(if dead { inactive(toggle) } else { toggle }, Some(settings))
    // rust: } else {
    // rust: let widget = button(0.0, 0.0, 310.0, label, Act::ToggleMod(i));
    // rust: Row::Buttons(if dead { inactive(widget) } else { widget }, None)
}
    // rust: }));
    // rust: rows
}
    // rust: Page::ModBrowser => self.mod_browser_rows(),
    // rust: Page::ModProject => self.mod_project_rows(s),
    // rust: Page::NativeMod(i) => self.native_rows(s, i),
    // rust: Page::ShaderPacks => {
    // rust: if s.shader_packs.is_empty() {
    // rust: return vec![Row::Header("horizon.shader_packs.empty")];
}
    // rust: let picked = s
    // rust: .shader_packs
    // rust: .iter()
    // rust: .position(|p| p.file == s.horizon.shader_pack);
    // rust: let options = picked.and_then(|i| {
    // rust: let pack = &s.shader_packs[i];
    // rust: let act = match pack.kind {
    // rust: crate::shader_pack_list::Kind::Classic => Act::ShaderOptions,
    // rust: _ if pack.options.is_empty() => return None,
    // rust: crate::shader_pack_list::Kind::Horizon => Act::NativePackOptions(i),
}
    // rust: let label = tr("horizon.shader_options.open");
    // rust: Some(Row::Buttons(button(0.0, 0.0, 310.0, label, act), None))
    // rust: });
    // rust: options
    // rust: .into_iter()
    // rust: .chain(s.shader_packs.iter().enumerate().map(|(i, pack)| {
    // rust: let kind = match pack.kind {
    // rust: crate::shader_pack_list::Kind::Horizon => {
    // rust: lang::get("horizon.shader_packs.kind_horizon")
}
    // rust: crate::shader_pack_list::Kind::Classic => String::new(),
}
    // rust: let label = Text::option_name_value(
    // rust: Text::literal(format!("{}{kind}", pack.title)),
    // rust: on_off(s.horizon.shader_pack == pack.file),
    // rust: );
    // rust: Row::Buttons(button(0.0, 0.0, 310.0, label, Act::PickShaderPack(i)), None)
    // rust: }))
    // rust: .collect()
}
    // rust: Page::ShaderOptions => shader_option_rows(s),
    // rust: Page::NativePackOptions(i, at) => native_pack_option_rows(s, i, at),
    // rust: _ => {
    // rust: let _ = s;
    // rust: Vec::new()
}
}
}
    // A section heading of a list (`Row::Header`, `Row::Heading`), at `y`.
heading_row :: proc(self: ^Self, out: ^[dynamic]Widget, label: Text, y: ^f32, w: f32, top: f32) {
}
    // rust: let padding = if *y + self.scroll <= top + 2.0 {
    // rust: 0.0
    // rust: } else {
    // rust: 18.0
}
    // rust: let label = label.with_style(&Style {
    // rust: bold: Some(true),
    // rust: underlined: Some(true),
    // rust: ..Style::default()
    // rust: });
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: *y + 2.0 + padding + 4.0,
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: label,
    // rust: color: u32::MAX,
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: *y += padding + 18.0;
}
    // Build every widget of the current page.
layout :: proc(self: ^Self, s: ^Settings, w: f32, h: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut rows = ListRows::default();
    // rust: let page = self.page();
    // rust: let cx = (w / 2.0).floor();
    // rust: if matches!(
    // rust: page,
    // rust: Page::Video | Page::Controls | Page::KeyBinds | Page::ModBrowser
    // rust: ) {
    // rust: self.settings_search.x = cx - 100.0;
    // rust: self.settings_search.y = 17.0;
}
    // rust: let done = |y: f32| button(cx - 100.0, y, 200.0, tr("gui.done"), Act::Done);
        // (list top, list bottom, content height)
    // rust: let (mut top, mut bottom, mut content) = (33.0, h - 33.0, 0.0);
    // rust: match page {
    // rust: Page::Main => {
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: 12.0,
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: tr("options.title"),
    // rust: color: u32::MAX,
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: out.push(option_widget(s, Opt::Fov, cx - 154.0, 29.0, 150.0));
    // rust: out.push(button(
    // rust: cx + 4.0,
    // rust: 29.0,
    // rust: 150.0,
    // rust: tr("options.online"),
    // rust: Act::Push(Page::Online),
    // rust: ));
    // rust: let entries = [
    // rust: ("options.skinCustomisation", Some(Page::Skin)),
    // rust: ("options.sounds", Some(Page::Sound)),
                    // Video Settings... opens Horizon's graphics screen, which holds every
                    // video option, as Sodium's replaces vanilla's.
    // rust: ("options.video", Some(Page::Graphics)),
    // rust: ("options.controls", Some(Page::Controls)),
    // rust: (
    // rust: "options.language",
    // rust: (!self.split_guest).then_some(Page::Language),
    // rust: ),
    // rust: ("options.chat", Some(Page::Chat)),
    // rust: (
    // rust: "options.resourcepack",
    // rust: (!self.split_guest).then_some(Page::Packs),
    // rust: ),
    // rust: ("options.accessibility", Some(Page::Accessibility)),
                    // Vanilla's Telemetry Data and Credits slots: Horizon's
                    // settings and its mods, as a mod adds its button here.
                    // Credits & Attribution (WinScreen's credits) follows them.
    // rust: ("horizon.pages.open.horizon_settings", Some(Page::Horizon)),
    // rust: ("horizon.pages.open.mods", Some(Page::Mods)),
    // rust: ("options.credits_and_attribution", Some(Page::Credits)),
    // rust: ];
    // rust: let rows = entries.len().div_ceil(2) as f32;
    // rust: let gy = (61.0 + 30.0f32).min(h - 33.0 - rows * 24.0);
    // rust: for (i, (key, page)) in entries.iter().enumerate() {
    // rust: let x = cx - 158.0 + 4.0 + (i % 2) as f32 * 158.0;
    // rust: let y = gy + (i / 2) as f32 * 24.0;
    // rust: let b = button(x, y, 150.0, tr(key), page.map_or(Act::None, Act::Push));
    // rust: out.push(if page.is_some() { b } else { inactive(b) });
}
    // rust: out.push(done(h - 27.0));
    // rust: top = 0.0;
    // rust: bottom = 0.0;
}
    // rust: Page::Credits => {
                // CreditsAndAttributionScreen: the title header, three 210-wide
                // buttons 8 apart (HeaderAndFooterLayout: 30 below the header
                // unless the footer is closer), Done.
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: 12.0,
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: tr(Self::title(page)),
    // rust: color: u32::MAX,
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: let y = (33.0 + 30.0f32).min(h - 33.0 - 76.0);
    // rust: let x = cx - 105.0;
    // rust: out.push(button(
    // rust: x,
    // rust: y,
    // rust: 210.0,
    // rust: tr("credits_and_attribution.button.credits"),
    // rust: Act::Credits,
    // rust: ));
                // ConfirmLinkScreen to minecraft.net: Horizon opens no links.
    // rust: for (i, key) in [
    // rust: "credits_and_attribution.button.attribution",
    // rust: "credits_and_attribution.button.licenses",
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let y = y + 28.0 * (i + 1) as f32;
    // rust: out.push(inactive(button(x, y, 210.0, tr(key), Act::None)));
}
    // rust: out.push(done(h - 27.0));
    // rust: top = 0.0;
    // rust: bottom = 0.0;
}
    // rust: Page::KeyBinds => {
    // rust: top = 38.0;
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: 4.0,
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: tr(Self::title(page)),
    // rust: color: u32::MAX,
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: let mut mappings: Vec<(&str, &str)> =
    // rust: all_mappings().map(|(n, _, c)| (*n, *c)).collect();
    // rust: let query = self.settings_search.value.to_lowercase();
    // rust: mappings.retain(|(name, _)| {
    // rust: query.is_empty() || lang::get(name).to_lowercase().contains(&query)
    // rust: });
    // rust: mappings.sort_by(|a, b| {
    // rust: let ca = CATEGORIES.iter().position(|c| *c == a.1).unwrap_or(99);
    // rust: let cb = CATEGORIES.iter().position(|c| *c == b.1).unwrap_or(99);
    // rust: ca.cmp(&cb)
    // rust: .then_with(|| lang::get(a.0).cmp(&lang::get(b.0)))
    // rust: });
    // rust: let row_left = cx - 170.0;
    // rust: let scrollbar_x = row_left + 340.0 + 6.0 + 2.0;
                // VideoSettingsScreen.addTitle: a changed graphics API needs a restart.
    // rust: if page == Page::Video && s.horizon.api != s.startup_api {
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: 15.0,
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: tr("options.restartRequired"),
    // rust: color: rgba(223, 80, 80, 255),
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
}
    // rust: let list_start = out.len();
    // rust: let mut y = top + 2.0 - self.scroll;
    // rust: let mut last_category = "";
    // rust: for (name, category) in mappings {
    // rust: if category != last_category {
    // rust: last_category = category;
    // rust: rows.begin(&out, y);
    // rust: let label =
    // rust: Text::translate(&format!("key.category.minecraft.{category}"), &[])
    // rust: .with_style(&Style {
    // rust: bold: Some(true),
    // rust: underlined: Some(true),
    // rust: ..Style::default()
    // rust: });
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: y + 7.0,
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: label,
    // rust: color: u32::MAX,
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: y += 20.0;
    // rust: rows.end(&mut out, y);
}
    // rust: rows.begin(&out, y);
    // rust: out.push(Widget {
    // rust: x: row_left + 2.0,
    // rust: y: y + 6.0,
    // rust: w: 200.0,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: tr(name),
    // rust: color: u32::MAX,
    // rust: centered: false,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: let key = s.keys.get(name).to_owned();
    // rust: let mut message = keybinds::display_name(&key);
    // rust: let conflicts = s.keys.conflicts(name);
    // rust: if !conflicts.is_empty() {
    // rust: message = Text::literal("[ ")
    // rust: .append(message.with_color(text::WHITE))
    // rust: .append(" ]")
    // rust: .with_color(text::YELLOW);
}
    // rust: if self.selected_key == Some(name) {
    // rust: message = Text::literal("> ")
    // rust: .append(message.with_style(&Style {
    // rust: color: Some(text::WHITE),
    // rust: underlined: Some(true),
    // rust: ..Style::default()
    // rust: }))
    // rust: .append(" <")
    // rust: .with_color(text::YELLOW);
}
    // rust: let reset_x = scrollbar_x - 50.0 - 10.0;
    // rust: let change_x = reset_x - 5.0 - 75.0;
    // rust: let name_static = all_mappings().find(|m| m.0 == name).map_or("", |m| m.0);
    // rust: out.push(button(change_x, y, 75.0, message, Act::Key(name_static)));
    // rust: if !conflicts.is_empty() {
    // rust: out.push(Widget {
    // rust: x: change_x - 6.0,
    // rust: y: y + 1.0,
    // rust: w: 3.0,
    // rust: h: 18.0,
    // rust: kind: WKind::Text {
    // rust: text: Text::empty(),
    // rust: color: rgba(255, 255, 0, 255),
    // rust: centered: false,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
}
    // rust: let reset = button(
    // rust: reset_x,
    // rust: y,
    // rust: 50.0,
    // rust: tr("controls.reset"),
    // rust: Act::ResetKey(name_static),
    // rust: );
    // rust: out.push(if s.keys.is_default(name) {
    // rust: inactive(reset)
    // rust: } else {
    // rust: reset
    // rust: });
    // rust: y += 20.0;
    // rust: rows.end(&mut out, y);
}
    // rust: content = y + self.scroll - top + 2.0;
    // rust: out[list_start..].iter_mut().for_each(|w| w.list = true);
    // rust: out.push(button(
    // rust: cx - 154.0,
    // rust: h - 27.0,
    // rust: 150.0,
    // rust: tr("controls.resetAll"),
    // rust: Act::ResetKeys,
    // rust: ));
    // rust: out.push(button(cx + 4.0, h - 27.0, 150.0, tr("gui.done"), Act::Done));
}
    // rust: Page::Language => {
    // rust: top = 36.0;
    // rust: bottom = h - 53.0;
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: 4.0,
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: tr(Self::title(page)),
    // rust: color: u32::MAX,
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: self.language_search.x = cx - 100.0;
    // rust: self.language_search.y = 17.0;
    // rust: let query = self.language_search.value.to_lowercase();
    // rust: let current = self
    // rust: .language_choice
    // rust: .clone()
    // rust: .unwrap_or_else(|| s.language.clone());
    // rust: if std::mem::take(&mut self.center_language)
    // rust: && let Some(i) = self.languages.iter().position(|l| l.code == current)
    // rust: {
                    // AbstractSelectionList.centerScrollOn.
    // rust: self.scroll = (i as f32 * 18.0 + 9.0 - (bottom - top) / 2.0).max(0.0);
}
    // rust: let list_start = out.len();
    // rust: let mut y = top + 2.0 - self.scroll;
    // rust: for l in &self.languages {
    // rust: if !query.is_empty()
    // rust: && !l.label().to_lowercase().contains(&query)
    // rust: && !l.code.contains(&query)
    // rust: {
    // rust: continue;
}
    // rust: rows.begin(&out, y);
    // rust: out.push(Widget {
    // rust: x: cx - 110.0,
    // rust: y,
    // rust: w: 220.0,
    // rust: h: 18.0,
    // rust: kind: WKind::LanguageRow {
    // rust: label: Text::literal(l.label()),
    // rust: selected: l.code == current,
    // rust: code: l.code.clone(),
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: y += 18.0;
    // rust: rows.end(&mut out, y);
}
    // rust: content = y + self.scroll - top + 2.0;
    // rust: out[list_start..].iter_mut().for_each(|w| w.list = true);
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: h - 45.0,
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: tr("options.languageAccuracyWarning"),
    // rust: color: rgba(0xBA, 0xBA, 0xBA, 255),
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: out.push(button(
    // rust: cx - 154.0,
    // rust: h - 28.0,
    // rust: 150.0,
    // rust: tr("options.font"),
    // rust: Act::Push(Page::Font),
    // rust: ));
    // rust: out.push(button(cx + 4.0, h - 28.0, 150.0, tr("gui.done"), Act::Done));
}
            // Drawn by `pack_screen`.
    // rust: Page::Packs => {}
    // rust: _ => {
    // rust: if matches!(page, Page::Video | Page::Controls | Page::ModBrowser) {
    // rust: top = 38.0;
}
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: if matches!(page, Page::Video | Page::Controls | Page::ModBrowser) {
    // rust: 4.0
    // rust: } else {
    // rust: 12.0
    // rust: },
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: Self::pack_page_title(s, page)
    // rust: .unwrap_or_else(|| tr(Self::title(page))),
    // rust: color: u32::MAX,
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: let list_start = out.len();
    // rust: let mut y = top + 2.0 - self.scroll;
    // rust: for row in self.list_rows(s) {
    // rust: rows.begin(&out, y);
    // rust: match row {
    // rust: Row::Header(key) => {
    // rust: let label = tr(key);
    // rust: self.heading_row(&mut out, label, &mut y, w, top);
}
    // rust: Row::Heading(key) => {
    // rust: let label = tr(&key);
    // rust: self.heading_row(&mut out, label, &mut y, w, top);
}
    // rust: Row::Note(text) => {
    // rust: out.push(Widget {
    // rust: x: 0.0,
    // rust: y: y + 4.0,
    // rust: w,
    // rust: h: 9.0,
    // rust: kind: WKind::Text {
    // rust: text: Text::literal(text),
    // rust: color: 0xFFA0A0A0,
    // rust: centered: true,
    // rust: },
    // rust: list: false,
    // rust: row: 0,
    // rust: });
    // rust: y += 16.0;
}
    // rust: Row::Big(opt) => {
    // rust: out.push(option_widget(s, opt, cx - 155.0, y + 2.0, 310.0));
    // rust: y += 25.0;
}
    // rust: Row::Pair(a, b) => {
    // rust: out.push(option_widget(s, a, cx - 155.0, y + 2.0, 150.0));
    // rust: if let Some(b) = b {
    // rust: out.push(option_widget(s, b, cx + 5.0, y + 2.0, 150.0));
}
    // rust: y += 25.0;
}
    // rust: Row::Buttons(mut a, b) => {
    // rust: a.x = cx - 155.0;
    // rust: a.y = y + 2.0;
    // rust: out.push(a);
    // rust: if let Some(mut b) = b {
    // rust: b.x = cx + 5.0;
    // rust: b.y = y + 2.0;
    // rust: out.push(b);
}
    // rust: y += 25.0;
}
}
    // rust: rows.end(&mut out, y);
}
    // rust: content = y + self.scroll - top + 2.0;
    // rust: out[list_start..].iter_mut().for_each(|w| w.list = true);
    // rust: let folder = match page {
    // rust: Page::Accessibility => {
    // rust: Some(("options.accessibility.link", Act::AccessibilityHelp))
}
    // rust: Page::Mods => Some(("horizon.mods.open_folder", Act::OpenModFolder)),
    // rust: Page::ShaderPacks => Some(("pack.openFolder", Act::OpenShaderPackFolder)),
    // rust: Page::ShaderOptions => Some(("controls.reset", Act::ShaderReset)),
    // rust: Page::NativePackOptions(i, _) => {
    // rust: Some(("controls.reset", Act::NativePackReset(i)))
}
    // rust: _ => None,
}
    // rust: if let Some((label, act)) = folder {
    // rust: out.push(button(cx - 154.0, h - 27.0, 150.0, tr(label), act));
    // rust: out.push(button(cx + 4.0, h - 27.0, 150.0, tr("gui.done"), Act::Done));
    // rust: } else {
    // rust: out.push(done(h - 27.0));
}
}
}
        // Layout may change the offset (language centering), or the list may
        // shrink after a resize/search. Correct the rows in this same frame.
    // rust: let previous_scroll = self.scroll;
    // rust: self.clamp_scroll(top, bottom, content);
    // rust: for widget in &mut out {
    // rust: if widget.list {
    // rust: widget.y += previous_scroll - self.scroll;
}
    // rust: if let WKind::Button {
    // rust: act: Act::Cycle(Opt::RotateWithMinecarts),
    // rust: active,
    // rust: ..
    // rust: } = &mut widget.kind
    // rust: {
    // rust: *active = self.in_world && self.minecart_improvements;
}
}
    // rust: self.row_bands = rows
    // rust: .bands
    // rust: .into_iter()
    // rust: .map(|band| band.map(|y| y + previous_scroll - self.scroll))
    // rust: .collect();
    // rust: (out, top, bottom, content)
}
clamp_scroll :: proc(self: ^Self, top: f32, bottom: f32, content: f32) {
}
    // rust: let max = (content - (bottom - top)).max(0.0);
    // rust: self.scroll = self.scroll.clamp(0.0, max);
}
    // The page's list as the narrator reads it: Language's
    // `ObjectSelectionList` ("Selected: <language>"), or the
    // `ContainerObjectSelectionList` the rows' widgets belong to, with the row
    // under the mouse (`getEntryAtPosition`: within the row's width).
    // rust: fn narrate_list(
    // rust: &self,
    // rust: widgets: &[Widget],
    // rust: key: u64,
    // rust: (top, bottom): (f32, f32),
    // rust: w: f32,
    // rust: cursor: (f32, f32),
    // rust: ) {
//         use crate::widgets::{ListKind, Narratable, Row as Narrated};
    // rust: let rect = [0.0, top, w, bottom - top];
    // rust: let in_list = cursor.1 >= top && cursor.1 < bottom;
    // rust: if self.page() == Page::Language {
    // rust: crate::widgets::narratable(|| {
    // rust: let rows: Vec<(&Widget, &Text, bool)> = widgets
    // rust: .iter()
    // rust: .filter_map(|wd| match &wd.kind {
    // rust: WKind::LanguageRow {
    // rust: label, selected, ..
    // rust: } => Some((wd, label, *selected)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let narrated = |(wd, label, _): &(&Widget, &Text, bool)| {
    // rust: Narrated::new(
    // rust: wd.row,
    // rust: Text::translate("narrator.select", &[(*label).clone()]).plain(),
    // rust: )
}
    // rust: let hovered = rows
    // rust: .iter()
    // rust: .find(|(wd, ..)| in_list && ui::hovered(cursor, wd.x, wd.y, wd.w, wd.h));
    // rust: let selected = rows.iter().find(|(_, _, selected)| *selected);
    // rust: Narratable::list(
    // rust: ListKind::Object,
    // rust: rows.len(),
    // rust: hovered.map(narrated),
    // rust: selected.map(narrated),
    // rust: rect,
    // rust: )
    // rust: .key(key)
    // rust: });
    // rust: return;
}
        // OptionsList rows are 310 wide, KeyBindsList's 340.
    // rust: let half = if self.page() == Page::KeyBinds {
    // rust: 170.0
    // rust: } else {
    // rust: 155.0
}
    // rust: let hovered_row = (in_list && (cursor.0 - (w / 2.0).floor()).abs() < half)
    // rust: .then(|| {
    // rust: self.row_bands
    // rust: .iter()
    // rust: .position(|[a, b]| cursor.1 >= *a && cursor.1 < *b)
    // rust: })
    // rust: .flatten();
    // rust: crate::widgets::narratable(|| {
    // rust: Narratable::container_list(self.row_bands.len(), hovered_row, rect).key(key)
    // rust: });
}
    // rust: pub fn draw(
    // rust: &mut self,
    // rust: s: &Settings,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: ) {
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: if let Some(error) = &self.resource_error {
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, self.in_world);
    // rust: let title = tr("resourcePack.load_fail");
            // An alert: its title and its message.
    // rust: crate::widgets::begin_screen(|| {
    // rust: crate::widgets::ScreenInfo::new(
    // rust: "options/resource_error",
    // rust: crate::widgets::join_for_narration(&[&title.plain(), error]),
    // rust: )
    // rust: });
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ((w - atlas.font.width_text(&title)) / 2.0).floor(),
    // rust: 30.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let lines = atlas.font.split(&Text::literal(error), (w - 50.0).max(1.0));
    // rust: let limit = ((h - 110.0) / 9.0).max(1.0) as usize;
    // rust: for (i, line) in lines.iter().take(limit).enumerate() {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: line,
    // rust: ((w - atlas.font.width_text(line)) / 2.0).floor(),
    // rust: 60.0 + i as f32 * 9.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: crate::widgets::Action::Done,
    // rust: w / 2.0 - 100.0,
    // rust: h - 28.0,
    // rust: 200.0,
    // rust: 20.0,
    // rust: &tr("gui.done"),
    // rust: true,
    // rust: ui::hovered(cursor, w / 2.0 - 100.0, h - 28.0, 200.0, 20.0),
    // rust: );
    // rust: return;
}
        // The page is its own screen (OptionsScreen, VideoSettingsScreen...).
    // rust: let page = self.page();
    // rust: crate::widgets::begin_screen(|| {
    // rust: crate::widgets::ScreenInfo::new(
    // rust: format!("options/{page:?}"),
    // rust: tr(Self::title(page)).plain(),
    // rust: )
    // rust: });
    // rust: if self.page() == Page::HdrCalibration
    // rust: && let Some(c) = &self.calibration
    // rust: {
    // rust: c.draw(batch, atlas, cursor);
    // rust: return;
}
    // rust: if Self::graphics_page(self.page()).is_some() {
    // rust: self.graphics.binding = self.selected_key;
    // rust: self.graphics.draw(s, batch, atlas, cursor, self.in_world);
    // rust: return;
}
    // rust: if Self::controller_page(self.page()).is_some() {
    // rust: self.controller.binding = self.selected_pad_action;
    // rust: self.controller.draw(s, batch, atlas, cursor, self.in_world);
    // rust: return;
}
    // rust: if self.page() == Page::SplitSetup {
    // rust: self.split_setup.on = s.extras.splitscreen;
            // The controller picks a tile up between presses: the screen's size from the draw.
    // rust: self.split_setup.size = (batch.width, batch.height);
    // rust: self.split_setup.draw(batch, atlas, cursor, self.in_world);
    // rust: return;
}
    // rust: if self.page() == Page::SplitProfiles {
    // rust: self.split_profiles
    // rust: .draw(batch, atlas, cursor, self.in_world, self.pad_style);
    // rust: return;
}
    // rust: if self.page() == Page::Studio {
    // rust: self.studio.draw(batch, atlas, cursor, self.in_world);
    // rust: return;
}
    // rust: if self.page() == Page::Packs {
    // rust: self.watch_data_packs(atlas, (w, h));
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, self.in_world);
    // rust: let blink = self.pack_focus.elapsed().as_millis() as u64;
    // rust: let m = crate::screen_draw::Measure(&atlas.font);
    // rust: let mouse = (cursor.0.floor() as i32, cursor.1.floor() as i32);
    // rust: let packs = self.packs(atlas, (w, h));
    // rust: let mut draws = packs.draw(&m, mouse, blink, crate::hud_overlays::now_ms());
    // rust: packs.bind_icons(&mut draws, atlas, &mut batch.patches);
    // rust: crate::screen_draw::paint(batch, atlas, &draws);
    // rust: return;
}
    // rust: if matches!(self.page(), Page::Extras | Page::Pvp) {
    // rust: self.wide_extras = wide_extras(s, self.page(), |t| atlas.font.width(t));
}
    // rust: let (widgets, top, bottom, content) = self.layout(s, w, h);
    // rust: self.size = (w, h);
    // rust: let in_world = self.in_world;
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, in_world);
    // rust: let list = bottom > top;
    // rust: if list {
    // rust: ui::list_background(batch, atlas, top, bottom, in_world);
}
    // rust: let visible = |wd: &Widget| !wd.list || (wd.y < bottom && wd.y + wd.h > top);
        // The list's narration: the language list is an ObjectSelectionList,
        // the others ContainerObjectSelectionLists whose rows' widgets are
        // recorded as they are drawn.
    // rust: let list_key = crate::widgets::key_of(&format!("options/{page:?}/list"));
    // rust: let framebuffer = [(w * batch.scale) as i32, (h * batch.scale) as i32];
    // rust: if list {
    // rust: self.narrate_list(&widgets, list_key, (top, bottom), w, cursor);
}
    // rust: let mut tooltip = None;
        // The widget a keyboard-focused tooltip belongs to: `MenuTooltipPositioner`
        // keeps it against that widget, not at the pointer.
    // rust: let mut tooltip_rect: Option<[f32; 4]> = None;
    // rust: for (wd_idx, wd) in widgets.iter().enumerate() {
    // rust: if !visible(wd) {
    // rust: continue;
}
    // rust: let is_focused = self
    // rust: .focus
    // rust: .as_ref()
    // rust: .is_some_and(|fid| matches_focus(fid, wd_idx, wd));
    // rust: let start = batch.vertices.len();
    // rust: let pointer_over = ui::hovered(cursor, wd.x, wd.y, wd.w, wd.h)
    // rust: && (!wd.list || cursor.1 >= top && cursor.1 < bottom);
    // rust: let hover = pointer_over || is_focused;
            // The tooltip is the pointer's (`setTooltip`, drawn while hovered);
            // a keyboard-focused widget keeps it against the widget
            // (`MenuTooltipPositioner`). Focus a mouse click leaves behind
            // does not: the description goes when the mouse leaves, like
            // vanilla's.
    // rust: let tip_hover = pointer_over || (is_focused && self.focus_from_keyboard);
            // A pack's option: its label within the widget (the name shortened), and on hover
            // the whole label when it was, then what the pack says of it.
    // rust: let shader = s.shader_options.as_ref();
    // rust: let option = match &wd.kind {
    // rust: WKind::Button {
    // rust: act: Act::ShaderOption(name),
    // rust: ..
}
    // rust: | WKind::ShaderSlider { name, .. } => Some(name),
    // rust: _ => None,
}
    // rust: let fitted = shader.zip(option).map(|(o, name)| {
    // rust: o.option_label_within(name, wd.w - 8.0, |t| atlas.font.width_text(t))
    // rust: });
    // rust: if tip_hover && let Some(o) = shader {
    // rust: let comment = match (&wd.kind, option) {
    // rust: (_, Some(name)) => o.comment(&format!("option.{name}")),
    // rust: (
    // rust: WKind::Button {
    // rust: act: Act::ShaderScreen(screen),
    // rust: ..
    // rust: },
    // rust: _,
    // rust: ) => o.comment(&format!("screen.{screen}")),
    // rust: (
    // rust: WKind::Button {
    // rust: act: Act::ShaderProfile,
    // rust: ..
    // rust: },
    // rust: _,
    // rust: ) => o.comment("profile"),
    // rust: _ => None,
}
    // rust: let whole = option
    // rust: .filter(|_| fitted.as_ref().is_some_and(|f| f.1))
    // rust: .map(|name| o.option_label(name));
    // rust: let lines: Vec<Text> = whole
    // rust: .into_iter()
    // rust: .chain(comment)
    // rust: .flat_map(|t| atlas.font.split(&t, 200.0))
    // rust: .collect();
    // rust: if !lines.is_empty() {
    // rust: tooltip = Some(lines);
    // rust: tooltip_rect =
    // rust: (!pointer_over || self.pad_driving).then_some([wd.x, wd.y, wd.w, wd.h]);
}
}
    // rust: if tip_hover && let Some(tip) = tooltip_text(s, wd) {
    // rust: tooltip = Some(match &wd.kind {
                    // The duplicate keybinds tooltip keeps its own lines.
    // rust: WKind::Button {
    // rust: act: Act::Key(_), ..
    // rust: } => tip
    // rust: .plain()
    // rust: .split('\n')
    // rust: .map(|l| Text::literal(l.to_owned()))
    // rust: .collect::<Vec<_>>(),
    // rust: _ => atlas.font.split(&tip, 170.0),
    // rust: });
    // rust: tooltip_rect =
    // rust: (!pointer_over || self.pad_driving).then_some([wd.x, wd.y, wd.w, wd.h]);
}
    // rust: match &wd.kind {
    // rust: WKind::Button { label, active, act } => {
    // rust: let label = fitted.as_ref().map_or(label, |f| &f.0);
    // rust: if matches!(act, Act::Done) {
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: crate::widgets::Action::Done,
    // rust: wd.x,
    // rust: wd.y,
    // rust: wd.w,
    // rust: wd.h,
    // rust: label,
    // rust: *active,
    // rust: hover,
    // rust: );
    // rust: } else {
    // rust: ui::button(batch, atlas, wd.x, wd.y, wd.w, wd.h, label, *active, hover);
}
    // rust: crate::widgets::last_narratable(|n| {
    // rust: narrate_widget(n, s, wd, hover, list_key, framebuffer);
    // rust: });
}
    // rust: WKind::Slider { label, value, opt } => {
    // rust: let dragging = self.dragging == Some(*opt);
    // rust: let shown = self.slider_shown(*opt, *value);
    // rust: ui::slider_ext(
    // rust: batch,
    // rust: atlas,
    // rust: wd.x,
    // rust: wd.y,
    // rust: wd.w,
    // rust: label,
    // rust: shown,
    // rust: hover || dragging,
    // rust: is_focused,
    // rust: self.can_change_value && is_focused,
    // rust: true,
    // rust: dragging,
    // rust: );
    // rust: crate::widgets::last_narratable(|n| {
    // rust: narrate_widget(n, s, wd, hover, list_key, framebuffer);
    // rust: });
}
    // rust: WKind::ShaderSlider { label, value, name } => {
    // rust: let label = fitted.as_ref().map_or(label, |f| &f.0);
    // rust: let held = self.shader_dragging.as_ref().filter(|(n, _)| n == name);
    // rust: let dragging = held.is_some();
    // rust: ui::slider(
    // rust: batch,
    // rust: atlas,
    // rust: wd.x,
    // rust: wd.y,
    // rust: wd.w,
    // rust: label,
    // rust: held.map_or(*value, |h| h.1),
    // rust: hover || dragging,
    // rust: true,
    // rust: dragging,
    // rust: );
}
    // rust: WKind::PackSlider {
    // rust: label,
    // rust: value,
    // rust: pack,
    // rust: option,
    // rust: } => {
    // rust: let held = self
    // rust: .pack_dragging
    // rust: .filter(|&(p, o, ..)| (p, o) == (*pack, *option));
    // rust: let dragging = held.is_some();
    // rust: ui::slider_ext(
    // rust: batch,
    // rust: atlas,
    // rust: wd.x,
    // rust: wd.y,
    // rust: wd.w,
    // rust: label,
    // rust: held.map_or(*value, |h| h.2),
    // rust: hover || dragging,
    // rust: is_focused,
    // rust: self.can_change_value && is_focused,
    // rust: true,
    // rust: dragging,
    // rust: );
    // rust: crate::widgets::last_narratable(|n| {
    // rust: narrate_widget(n, s, wd, hover, list_key, framebuffer);
    // rust: });
}
    // rust: WKind::Text {
    // rust: text,
    // rust: color,
    // rust: centered,
    // rust: } => {
    // rust: if text.is_empty() {
    // rust: batch.fill(atlas, wd.x, wd.y, wd.w, wd.h, *color);
    // rust: } else if *centered {
    // rust: let tw = atlas.font.width_text(text);
                        // A list's header row (OptionsList.HeaderEntry,
                        // KeyBindsList.CategoryEntry): a FocusableTextWidget
                        // narrating its text, 4 pixels of padding round it.
    // rust: if wd.list && *color == u32::MAX {
    // rust: crate::widgets::narratable(|| {
    // rust: let x = wd.x + ((wd.w - tw) / 2.0).floor();
    // rust: crate::widgets::Narratable::text(
    // rust: text.plain(),
    // rust: [x - 4.0, wd.y - 4.0, tw + 8.0, 17.0],
    // rust: )
    // rust: .key(crate::widgets::key_of(&(list_key, wd.row)))
    // rust: .child_of(list_key, wd.row)
    // rust: });
}
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: text,
    // rust: wd.x + ((wd.w - tw) / 2.0).floor(),
    // rust: wd.y,
    // rust: *color,
    // rust: true,
    // rust: );
    // rust: } else {
    // rust: batch.text_styled(atlas, text, wd.x, wd.y, *color, true);
}
}
    // rust: WKind::LanguageRow {
    // rust: label, selected, ..
    // rust: } => {
    // rust: let rect = [wd.x, wd.y, wd.w, wd.h];
    // rust: crate::widgets::record_as(
    // rust: &label.plain(),
    // rust: rect,
    // rust: true,
    // rust: crate::widgets::Kind::Row,
    // rust: );
    // rust: crate::widgets::target_as(rect, crate::widgets::Kind::Row);
    // rust: if *selected || is_focused {
    // rust: batch.fill(atlas, wd.x, wd.y, wd.w, wd.h, u32::MAX);
    // rust: batch.fill(
    // rust: atlas,
    // rust: wd.x + 1.0,
    // rust: wd.y + 1.0,
    // rust: wd.w - 2.0,
    // rust: wd.h - 2.0,
    // rust: rgba(0, 0, 0, 255),
    // rust: );
}
    // rust: let tw = atlas.font.width_text(label);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: label,
    // rust: wd.x + ((wd.w - tw) / 2.0).floor(),
    // rust: wd.y + 2.0 + 7.0 - 4.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
}
    // rust: if wd.list && (wd.y < top || wd.y + wd.h > bottom) {
    // rust: batch.clip_since(start, 0.0, top, w, bottom);
}
}
    // rust: if list {
    // rust: ui::separators(batch, atlas, top, bottom, in_world);
    // rust: let sx = self.scrollbar_x(w);
    // rust: ui::scrollbar(batch, atlas, sx, top, bottom, content, self.scroll);
}
    // rust: if self.page() == Page::Language {
    // rust: let mut search = self.language_search.clone();
    // rust: if self.focus == Some(FocusId::Search) {
    // rust: search.focused = true;
}
    // rust: search.draw(batch, atlas, None);
            // LanguageSelectScreen's header search box (no message), added
            // before the list.
    // rust: crate::widgets::last_narratable(|n| n.order = -1);
    // rust: if search.value.is_empty() && !search.focused {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &tr("gui.language.search").with_color(text::GRAY).italic(),
    // rust: search.text_x(),
    // rust: search.text_y(),
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: self.language_search = search;
}
    // rust: if matches!(
    // rust: self.page(),
    // rust: Page::Video | Page::Controls | Page::KeyBinds | Page::ModBrowser
    // rust: ) {
    // rust: let mut search = self.settings_search.clone();
    // rust: if self.focus == Some(FocusId::Search) {
    // rust: search.focused = true;
}
    // rust: search.draw(batch, atlas, None);
    // rust: let hint = match self.page() {
    // rust: Page::ModBrowser => "horizon.mods.browse.search",
    // rust: _ => "horizon.options.search",
}
            // Horizon's search box sits in the header, before the list.
    // rust: crate::widgets::last_narratable(|n| {
    // rust: n.order = -1;
    // rust: if let crate::widgets::What::EditBox { message, .. } = &mut n.what {
    // rust: *message = tr(hint).plain();
}
    // rust: });
    // rust: if search.value.is_empty() && !search.focused {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &tr(hint).with_color(text::GRAY).italic(),
    // rust: search.text_x(),
    // rust: search.text_y(),
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: self.settings_search = search;
}
    // rust: if let Some(lines) = tooltip {
    // rust: match tooltip_rect {
    // rust: Some(rect) if self.pad_driving => ui::tooltip_under(batch, atlas, &lines, rect),
    // rust: Some(rect) => ui::tooltip_menu(batch, atlas, &lines, cursor, rect),
    // rust: None => ui::tooltip(batch, atlas, &lines, cursor),
}
}
}
    // Mouse press/drag. Returns events for the game.
    // rust: pub fn click(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: atlas: &HudAtlas,
    // rust: x: f32,
    // rust: y: f32,
    // rust: size: (f32, f32),
    // rust: framebuffer: [i32; 2],
    // rust: drag: bool,
    // rust: right: bool,
    // rust: ) -> Vec<Event> {
    // rust: if self.resource_error.is_some() {
    // rust: if !drag
    // rust: && !right
    // rust: && ui::hovered((x, y), size.0 / 2.0 - 100.0, size.1 - 28.0, 200.0, 20.0)
    // rust: {
    // rust: self.resource_error = None;
    // rust: return vec![Event::ButtonClick];
}
    // rust: return Vec::new();
}
    // rust: if self.page() == Page::SplitSetup {
//             use crate::split_ui::Click;
    // rust: if right {
    // rust: return Vec::new();
}
    // rust: self.split_setup.on = s.extras.splitscreen;
    // rust: return match self.split_setup.click((x, y), size, drag) {
    // rust: Click::Nothing => Vec::new(),
    // rust: Click::Pressed => vec![Event::ButtonClick],
    // rust: Click::Switch => {
    // rust: crate::extras::Item::Splitscreen.cycle(&mut s.extras, false);
    // rust: vec![Event::ButtonClick, Event::Changed]
}
    // rust: Click::Done => {
    // rust: let mut events = vec![Event::ButtonClick];
    // rust: events.extend(self.back(s));
    // rust: events
}
}
}
    // rust: if self.page() == Page::SplitProfiles {
//             use crate::split_profiles::Click;
    // rust: if right || drag {
    // rust: return Vec::new();
}
    // rust: return match self.split_profiles.click(atlas, (x, y), size) {
    // rust: Click::Nothing => Vec::new(),
    // rust: Click::Pressed => vec![Event::ButtonClick],
    // rust: Click::Done => {
    // rust: let mut events = vec![Event::ButtonClick];
    // rust: events.extend(self.back(s));
    // rust: events
}
}
}
    // rust: if self.page() == Page::Studio {
    // rust: if right || drag {
    // rust: return Vec::new();
}
//             use crate::studio_ui::StudioAction;
    // rust: return match self.studio.click((x, y), size) {
    // rust: StudioAction::None => Vec::new(),
    // rust: StudioAction::Refresh => vec![Event::ButtonClick],
    // rust: StudioAction::OpenFolder => vec![Event::ButtonClick, Event::OpenStudioFolder],
    // rust: StudioAction::Back => {
    // rust: let mut events = vec![Event::ButtonClick];
    // rust: events.extend(self.back(s));
    // rust: events
}
}
}
    // rust: if self.page() == Page::HdrCalibration
    // rust: && let Some(c) = &mut self.calibration
    // rust: {
    // rust: if right {
    // rust: return Vec::new();
}
    // rust: let outcome = c.click((x, y), size, drag);
    // rust: return self.calibration_outcome(s, outcome);
}
    // rust: if Self::graphics_page(self.page()).is_some() {
            // Waiting on a key: a mouse button binds, as on Key Binds.
    // rust: if self.selected_key.is_some() && !drag {
    // rust: let button = if right {
    // rust: winit::event::MouseButton::Right
    // rust: } else {
    // rust: winit::event::MouseButton::Left
}
    // rust: return self.bind_mouse(s, button);
}
    // rust: let actions =
    // rust: self.graphics
    // rust: .click(s, (x, y), size, framebuffer, drag, right, self.shift);
    // rust: return self.graphics_events(s, actions);
}
    // rust: if Self::controller_page(self.page()).is_some() {
            // Waiting on a button: a click cancels the wait.
    // rust: if !drag && self.selected_pad_action.take().is_some() {
    // rust: return Vec::new();
}
    // rust: let actions =
    // rust: self.controller
    // rust: .click(s, (x, y), size, framebuffer, drag, right, self.shift);
    // rust: return self.controller_events(s, actions);
}
    // rust: if self.page() == Page::Packs {
    // rust: let mut events = Vec::new();
    // rust: if drag {
    // rust: self.packs(atlas, size).drag(y as f64);
    // rust: return events;
}
    // rust: if right {
    // rust: return events;
}
    // rust: let m = crate::screen_draw::Measure(&atlas.font);
    // rust: let p = self.packs(atlas, size);
    // rust: if p.button_at(&m, x as f64, y as f64) {
    // rust: events.push(Event::ButtonClick);
}
    // rust: let before = p.search_focused();
    // rust: let action = p.click(&m, x as f64, y as f64);
    // rust: if !before && p.search_focused() {
    // rust: self.pack_focus = Instant::now();
}
    // rust: match action {
    // rust: crate::pack_screen::Action::OpenFolder => events.push(match &self.data_pack_dir {
    // rust: Some(dir) => Event::OpenDataPackFolder(dir.clone()),
    // rust: None => Event::OpenPackFolder,
    // rust: }),
    // rust: crate::pack_screen::Action::Done => events.extend(self.back(s)),
    // rust: crate::pack_screen::Action::BrowsePick(i) => {
    // rust: events.push(Event::DownloadPack(i));
}
    // rust: crate::pack_screen::Action::None => {}
}
    // rust: return events;
}
    // rust: let (widgets, top, bottom, content) = self.layout(s, size.0, size.1);
    // rust: self.size = size;
    // rust: self.framebuffer = framebuffer;
    // rust: let mut events = Vec::new();
    // rust: if !drag
    // rust: && matches!(
    // rust: self.page(),
    // rust: Page::Video | Page::Controls | Page::KeyBinds | Page::ModBrowser
    // rust: )
    // rust: {
    // rust: let search = &mut self.settings_search;
    // rust: search.focused = ui::hovered((x, y), search.x, search.y, search.width, search.height);
    // rust: if search.focused {
    // rust: self.focus = Some(FocusId::Search);
    // rust: self.focus_from_keyboard = false;
    // rust: self.can_change_value = false;
    // rust: search.click(atlas, x, false, false);
    // rust: self.scroll = 0.0;
    // rust: events.push(Event::ButtonClick);
    // rust: return events;
}
}
    // rust: if !drag && self.page() == Page::Language {
    // rust: let search = &mut self.language_search;
    // rust: search.focused = ui::hovered((x, y), search.x, search.y, search.width, search.height);
    // rust: if search.focused {
    // rust: self.focus = Some(FocusId::Search);
    // rust: self.focus_from_keyboard = false;
    // rust: self.can_change_value = false;
    // rust: search.click(atlas, x, false, false);
    // rust: self.scroll = 0.0;
    // rust: return events;
}
}
    // rust: if drag {
    // rust: if let Some(previous_y) = self.scrollbar_drag_y {
    // rust: if let Some((_, thumb)) = ui::scrollbar_thumb(top, bottom, content, self.scroll) {
    // rust: let max = content - (bottom - top);
    // rust: self.scroll = if y < top {
    // rust: 0.0
    // rust: } else if y > bottom {
    // rust: max
    // rust: } else {
    // rust: self.scroll + (y - previous_y) * max / (bottom - top - thumb)
}
    // rust: self.clamp_scroll(top, bottom, content);
    // rust: self.scrollbar_drag_y = Some(y);
    // rust: } else {
    // rust: self.scrollbar_drag_y = None;
}
    // rust: return events;
}
    // rust: if let Some((name, at)) = &mut self.shader_dragging
    // rust: && let Some(wd) = widgets
    // rust: .iter()
    // rust: .find(|wd| matches!(&wd.kind, WKind::ShaderSlider { name: n, .. } if n == name))
    // rust: && let Some(options) = &mut s.shader_options
    // rust: {
    // rust: *at = ui::slider_value(wd.x, wd.w, x);
    // rust: options.set_position(name, *at);
}
    // rust: if let Some((pack, option, at, changed)) = &mut self.pack_dragging
    // rust: && let Some(wd) = widgets.iter().find(|wd| {
    // rust: matches!(wd.kind, WKind::PackSlider { pack: p, option: o, .. }
    // rust: if (p, o) == (*pack, *option))
    // rust: })
    // rust: && let Some(entry) = s.shader_packs.get_mut(*pack)
    // rust: {
    // rust: *at = ui::slider_value(wd.x, wd.w, x);
    // rust: *changed |= entry.set_slider_position(*option, *at);
}
    // rust: if let Some(opt) = self.dragging
    // rust: && let Some(wd) = widgets
    // rust: .iter()
    // rust: .find(|wd| matches!(&wd.kind, WKind::Slider { opt: o, .. } if *o == opt))
    // rust: {
    // rust: let v = ui::slider_value(wd.x, wd.w, x);
    // rust: self.slider_value = Some((opt, v, Instant::now()));
    // rust: drag_slider(opt, s, v, &mut events);
}
    // rust: return events;
}
        // Key Binds: a mouse button pressed while waiting binds it.
    // rust: if self.selected_key.is_some() {
    // rust: let button = if right {
    // rust: winit::event::MouseButton::Right
    // rust: } else {
    // rust: winit::event::MouseButton::Left
}
    // rust: return self.bind_mouse(s, button);
}
        // AbstractWidget accepts only the primary button. Rebinding above
        // accepts other mouse buttons, but is not a widget activation. A pack's option steps
        // back with the other one.
    // rust: if right {
    // rust: let name = widgets.iter().find_map(|wd| match &wd.kind {
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::ShaderOption(name),
    // rust: ..
    // rust: } if ui::hovered((x, y), wd.x, wd.y, wd.w, wd.h)
    // rust: && !(wd.list && (y < top || y >= bottom)) =>
    // rust: {
    // rust: Some(name.clone())
}
    // rust: _ => None,
    // rust: });
    // rust: if let Some(name) = name
    // rust: && let Some(options) = &mut s.shader_options
    // rust: {
    // rust: options.cycle(&name, true);
    // rust: events.push(Event::ButtonClick);
}
    // rust: let native = widgets.iter().find_map(|wd| match wd.kind {
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::NativePackOption(pack, option),
    // rust: ..
    // rust: } if ui::hovered((x, y), wd.x, wd.y, wd.w, wd.h)
    // rust: && !(wd.list && (y < top || y >= bottom)) =>
    // rust: {
    // rust: Some((pack, option))
}
    // rust: _ => None,
    // rust: });
    // rust: if let Some((pack, option)) = native
    // rust: && let Some(entry) = s.shader_packs.get_mut(pack)
    // rust: && entry.step_option(option, true, false)
    // rust: {
    // rust: events.push(Event::ButtonClick);
    // rust: events.push(Event::NativePackOptions(pack));
}
    // rust: return events;
}
    // rust: if ui::scrollbar_thumb(top, bottom, content, self.scroll).is_some()
    // rust: && ui::hovered((x, y), self.scrollbar_x(size.0), top, 6.0, bottom - top)
    // rust: {
    // rust: self.scrollbar_drag_y = Some(y);
    // rust: return events;
}
    // rust: for (wd_idx, wd) in widgets.into_iter().enumerate() {
    // rust: if !ui::hovered((x, y), wd.x, wd.y, wd.w, wd.h) {
    // rust: continue;
}
    // rust: if wd.list && (y < top || y >= bottom) {
    // rust: continue;
}
            // A click focuses the widget for its highlight only: vanilla's wheel
            // steps a keyboard-focused widget from anywhere, not a clicked one.
    // rust: self.focus = Some(focus_id(wd_idx, &wd));
    // rust: self.focus_from_keyboard = false;
    // rust: match wd.kind {
    // rust: WKind::Button {
    // rust: active: true, act, ..
    // rust: } => {
    // rust: self.can_change_value = false;
    // rust: events.push(Event::ButtonClick);
    // rust: match act {
    // rust: Act::Push(p) => {
    // rust: if p == Page::ShaderPacks {
    // rust: events.push(Event::ListShaderPacks);
}
    // rust: if p == Page::Music {
    // rust: events.push(Event::ListMusicTracks);
}
    // rust: if p == Page::ModBrowser {
    // rust: events.push(Event::BrowseMods);
}
    // rust: self.push(p)
}
    // rust: Act::Done => events.extend(self.back(s)),
    // rust: Act::Cycle(opt) => {
    // rust: events.extend(self.cycle_option(s, opt, self.shift, framebuffer));
}
    // rust: Act::Extra(item) => {
    // rust: if let Some(name) = item.key_name() {
    // rust: self.selected_key = Some(name);
    // rust: } else {
    // rust: item.cycle(&mut s.extras, self.shift);
    // rust: events.push(Event::Changed);
}
}
    // rust: Act::PlayMusicTrack(event, track) => {
    // rust: events.push(Event::PlayMusicTrack(event, track));
}
    // rust: Act::MusicTrackOn(track, was_on) => {
    // rust: s.extras
    // rust: .music_off
    // rust: .retain(|off| off.as_str() != track.as_str());
    // rust: if was_on {
    // rust: s.extras.music_off.push(track);
}
    // rust: events.push(Event::Changed);
}
    // rust: Act::Key(name) => self.selected_key = Some(name),
    // rust: Act::ResetKey(name) => {
    // rust: s.keys.set(name, KeyBinds::default_of(name));
    // rust: events.push(Event::Changed);
}
    // rust: Act::ResetKeys => {
    // rust: s.keys.reset_all();
    // rust: events.push(Event::Changed);
}
    // rust: Act::ToggleMod(i) => {
    // rust: s.mods.toggle(i);
    // rust: events.push(Event::Changed);
}
    // rust: Act::ModSettings(i) => {
    // rust: events.push(Event::ButtonClick);
    // rust: self.push(Page::NativeMod(i));
    // rust: events.push(Event::NativeSettings(i));
}
    // rust: Act::NativeKey(i, k) => {
    // rust: self.selected_key = Some(NATIVE_KEY);
    // rust: self.selected_native_key = Some((i, k));
}
    // rust: Act::NativeButton(i, b) => events.push(Event::NativeButton(i, b)),
    // rust: Act::OpenModFolder => events.push(Event::OpenModFolder),
    // rust: Act::ModProject(i) => {
    // rust: if let Some(listing) = self.mod_browser.listings.get(i) {
    // rust: self.mod_project = listing.id.clone();
    // rust: self.push(Page::ModProject);
}
}
    // rust: Act::InstallMod => {
    // rust: self.mod_browser.message = None;
    // rust: events.push(Event::InstallMod(self.mod_project.clone()));
}
    // rust: Act::OpenModPage => {
    // rust: if let Some(l) = self.mod_browser.listing(&self.mod_project) {
    // rust: events.push(Event::OpenModPage(l.page.clone()));
}
}
    // rust: Act::PvpPreset => {
    // rust: crate::pvp::apply_preset(s);
    // rust: events.push(Event::Changed);
}
    // rust: Act::HudEditor => events.push(Event::HudEditor),
    // rust: Act::AccessibilityHelp => events.push(Event::AccessibilityHelp),
    // rust: Act::PickShaderPack(i) => {
    // rust: if let Some(pack) = s.shader_packs.get(i) {
    // rust: s.horizon.shader_pack = if s.horizon.shader_pack == pack.file {
    // rust: String::new()
    // rust: } else {
    // rust: pack.file.clone()
}
    // rust: events.push(Event::ShaderPack);
}
}
    // rust: Act::OpenShaderPackFolder => events.push(Event::OpenShaderPackFolder),
    // rust: Act::ShaderOptions => {
    // rust: s.shader_options = None;
    // rust: self.push(Page::ShaderOptions);
    // rust: events.push(Event::OpenShaderOptions);
}
    // rust: Act::ShaderOption(name) => {
    // rust: if let Some(options) = &mut s.shader_options {
    // rust: if self.shift {
    // rust: options.reset_option(&name);
    // rust: } else {
    // rust: options.cycle(&name, false);
}
}
}
    // rust: Act::ShaderScreen(screen) => {
    // rust: if let Some(options) = &mut s.shader_options {
    // rust: options.path.push(screen);
    // rust: self.scroll = 0.0;
}
}
    // rust: Act::ShaderProfile => {
    // rust: if let Some(options) = &mut s.shader_options {
    // rust: options.next_profile();
}
}
    // rust: Act::ShaderReset => {
    // rust: if let Some(options) = &mut s.shader_options {
    // rust: options.reset();
}
}
    // rust: Act::NativePackOptions(i) => {
    // rust: self.push(Page::NativePackOptions(i, 0));
}
    // rust: Act::NativePackOption(pack, option) => {
    // rust: if let Some(entry) = s.shader_packs.get_mut(pack)
    // rust: && entry.step_option(option, false, self.shift)
    // rust: {
    // rust: events.push(Event::NativePackOptions(pack));
}
}
    // rust: Act::NativePackReset(pack) => {
    // rust: if let Some(entry) = s.shader_packs.get_mut(pack) {
    // rust: entry.reset_options();
    // rust: events.push(Event::NativePackOptions(pack));
}
}
    // rust: Act::Credits => events.push(Event::Credits),
    // rust: Act::CopyAgentDetails => events.push(Event::CopyAgentDetails),
    // rust: Act::ToggleRecording => events.push(Event::ToggleRecording),
    // rust: Act::ExportRepro => events.push(Event::ExportRepro),
    // rust: Act::None => {}
}
}
    // rust: WKind::ShaderSlider { name, .. } => {
    // rust: let at = ui::slider_value(wd.x, wd.w, x);
    // rust: if let Some(options) = &mut s.shader_options {
    // rust: if self.shift {
                            // Sounds as a released slider does: no drag follows.
    // rust: options.reset_option(&name);
    // rust: events.extend([Event::ButtonClick, Event::Changed]);
    // rust: break;
}
    // rust: options.set_position(&name, at);
}
    // rust: self.shader_dragging = Some((name, at));
}
    // rust: WKind::PackSlider { pack, option, .. } => {
    // rust: self.can_change_value = true;
    // rust: let Some(entry) = s.shader_packs.get_mut(pack) else {
    // rust: break;
}
    // rust: if self.shift {
                        // Its default, as a shift-click on a pack's button does; no drag follows.
    // rust: entry.step_option(option, false, true);
    // rust: events.extend([Event::ButtonClick, Event::NativePackOptions(pack)]);
    // rust: break;
}
    // rust: let at = ui::slider_value(wd.x, wd.w, x);
    // rust: let changed = entry.set_slider_position(option, at);
    // rust: self.pack_dragging = Some((pack, option, at, changed));
}
    // rust: WKind::Slider { opt, .. } => {
    // rust: self.can_change_value = true;
    // rust: self.dragging = Some(opt);
    // rust: let v = ui::slider_value(wd.x, wd.w, x);
    // rust: self.slider_value = Some((opt, v, Instant::now()));
    // rust: drag_slider(opt, s, v, &mut events);
}
    // rust: WKind::LanguageRow { code, .. } => {
    // rust: self.can_change_value = false;
    // rust: if self.language_choice.as_deref() == Some(code.as_str()) {
    // rust: events.extend(self.back(s));
    // rust: } else {
    // rust: self.language_choice = Some(code);
}
}
    // rust: _ => {}
}
    // rust: break;
}
    // rust: events
}
    // Where a slider's handle sits: its own position while held (or until
    // a delayed one applies), else the option's stepped value.
slider_shown :: proc(self: ^Self, opt: Opt, value: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.slider_value {
    // rust: Some((o, v, at)) if o == opt && slider_unsnapped(o, self.dragging == Some(o), at) => v,
    // rust: _ => value,
}
}
release :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.scrollbar_drag_y = None;
    // rust: if let Some(p) = &mut self.pack_screen {
    // rust: p.release();
}
        // AbstractSliderButton suppresses the press sound and plays once on
        // release, even if the pointer has left the widget or its value stayed.
    // rust: let pack = self.pack_dragging.take();
    // rust: let slider =
    // rust: self.dragging.take().is_some() | self.shader_dragging.take().is_some() | pack.is_some();
    // rust: let graphics_slider = self.graphics.release() | self.controller.release();
    // rust: let calibration_slider = self.calibration.as_mut().is_some_and(|c| c.release());
    // rust: let split_drop = self.split_setup.release();
    // rust: if slider || graphics_slider || calibration_slider {
    // rust: let mut events = vec![Event::ButtonClick, Event::Changed];
            // A pack's option is saved, and the pack rebuilt, once per drag.
    // rust: if let Some((pack, _, _, true)) = pack {
    // rust: events.push(Event::NativePackOptions(pack));
}
    // rust: events
    // rust: } else if split_drop {
    // rust: vec![Event::ButtonClick]
    // rust: } else {
    // rust: Vec::new()
}
}
scroll :: proc(self: ^Self, s: ^Settings, size: (f32) {
}
    // rust: let (_, top, bottom, content) = self.layout(s, size.0, size.1);
    // rust: self.scroll -= amount * 18.0;
    // rust: self.clamp_scroll(top, bottom, content);
}
    // `CycleButton.cycleValue` on an option, then what the option changes:
    // the preset's values, High Contrast's built-in pack.
    // rust: fn cycle_option(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: opt: Opt,
    // rust: back: bool,
    // rust: framebuffer: [i32; 2],
    // rust: ) -> Vec<Event> {
    // rust: let mut events = Vec::new();
    // rust: opt.cycle(s, back, framebuffer);
    // rust: if opt == Opt::Preset {
    // rust: apply_preset(s);
}
    // rust: if opt == Opt::HighContrast {
            // Options.highContrast: the built-in pack follows the option.
    // rust: let on = s.resource_packs.iter().any(|id| id == "high_contrast");
    // rust: if on != s.high_contrast {
    // rust: s.resource_packs.retain(|id| id != "high_contrast");
    // rust: if s.high_contrast {
    // rust: s.resource_packs.push("high_contrast".into());
}
                // PackSelectionScreen reads the repository each time it
                // opens: the next one starts from this selection.
    // rust: self.pack_selection = s.resource_packs.clone();
    // rust: self.pack_screen = None;
    // rust: events.push(Event::Packs(s.resource_packs.clone()));
}
}
    // rust: events.push(Event::Changed);
    // rust: if opt == Opt::Narrator {
    // rust: events.push(Event::Narrator);
}
    // rust: events
}
    // The mouse wheel at the cursor. A vanilla list keeps the wheel for itself:
    // `AbstractContainerWidget` inherits `AbstractScrollArea.mouseScrolled`, which
    // scrolls and never reaches the list's rows. A cycle button outside a list is
    // the screen's own child, so it takes the step (`CycleButton.mouseScrolled`: up
    // goes back). `AbstractSliderButton` does not override it, so a slider outside
    // a list does nothing.
    //
    // **Horizon extra (diverges from Vanilla 26.3, off by default):** "Scroll wheel
    // changes settings" lets a hovered list row take the step too, and a slider or
    // cycle button focused by the keyboard (Tab, the arrows, a pad) step on the
    // wheel wherever the cursor is. Focus left by a click does not count
    // (`focus_from_keyboard`): honouring it toggled the clicked option on every
    // later wheel event, from anywhere on the screen, while the list never scrolled.
    // The graphics screen has its own wheel (`GraphicsUi::wheel`).
    // rust: pub fn wheel(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: size: (f32, f32),
    // rust: cursor: (f32, f32),
    // rust: framebuffer: [i32; 2],
    // rust: amount: f32,
    // rust: ) -> Vec<Event> {
    // rust: self.size = size;
    // rust: self.framebuffer = framebuffer;
    // rust: if Self::graphics_page(self.page()).is_some() {
    // rust: let actions = self.graphics.wheel(s, size, cursor, framebuffer, amount);
    // rust: return self.graphics_events(s, actions);
}
    // rust: if self.page() == Page::Studio {
    // rust: self.studio.wheel(amount);
    // rust: return Vec::new();
}
    // rust: if Self::controller_page(self.page()).is_some() {
    // rust: let actions = self.controller.wheel(s, size, cursor, framebuffer, amount);
    // rust: return self.controller_events(s, actions);
}
    // rust: let plain = self.resource_error.is_none()
    // rust: && !(self.pack_screen.is_some() && self.stack.last() == Some(&Page::Packs));
    // rust: if !plain {
    // rust: self.scroll_at(s, size, cursor, amount);
    // rust: return Vec::new();
}
    // rust: let extra = s.extras.wheel_cycles_settings;
        // The extra: a keyboard-focused slider or cycle button intercepts the
        // wheel before hover detection (see doc-comment above). A click focuses
        // its widget for the highlight too, and the wheel must not act on that:
        // it would toggle the clicked option from anywhere on the screen and the
        // list would never scroll.
    // rust: if extra && amount != 0.0 && self.focus_from_keyboard {
    // rust: let (widgets, _, _, _) = self.layout(s, size.0, size.1);
    // rust: match &self.focus {
    // rust: Some(FocusId::Slider(opt)) => {
    // rust: let opt = *opt;
    // rust: let width = widgets
    // rust: .iter()
    // rust: .find(|wd| matches!(&wd.kind, WKind::Slider { opt: o, .. } if *o == opt))
    // rust: .map_or(150.0, |wd| wd.w);
    // rust: return self.step_slider_option(s, opt, amount > 0.0, width);
}
    // rust: Some(FocusId::PackSlider(pack, option)) => {
    // rust: let (pack, option) = (*pack, *option);
    // rust: return Self::step_pack_slider(s, pack, option, amount > 0.0);
}
    // rust: Some(FocusId::Cycle(opt)) => {
    // rust: let opt = *opt;
    // rust: let mut events = vec![Event::ButtonClick];
    // rust: events.extend(self.cycle_option(s, opt, amount > 0.0, framebuffer));
    // rust: return events;
}
    // rust: _ => {}
}
}
HoveredControl :: enum {
    Cycle(Opt),
    Extra(crate::extras::Item),
}
    // rust: let (widgets, top, bottom, _) = self.layout(s, size.0, size.1);
        // A list's row takes the wheel only with the extra on.
    // rust: let takes_wheel = |wd: &Widget| {
    // rust: ui::hovered(cursor, wd.x, wd.y, wd.w, wd.h)
    // rust: && (!wd.list || (extra && cursor.1 >= top && cursor.1 < bottom))
}
    // rust: let hovered = widgets.iter().find_map(|wd| match &wd.kind {
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::Cycle(opt),
    // rust: ..
    // rust: } if takes_wheel(wd) => Some(HoveredControl::Cycle(*opt)),
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::Extra(item),
    // rust: ..
    // rust: } if takes_wheel(wd) => Some(HoveredControl::Extra(*item)),
    // rust: _ => None,
    // rust: });
    // rust: match hovered {
    // rust: Some(HoveredControl::Cycle(opt)) if amount != 0.0 => {
    // rust: self.cycle_option(s, opt, amount > 0.0, framebuffer)
}
    // rust: Some(HoveredControl::Extra(item)) if amount != 0.0 => {
    // rust: item.cycle(&mut s.extras, amount > 0.0);
    // rust: vec![Event::Changed]
}
    // rust: Some(_) => Vec::new(),
    // rust: None => {
    // rust: self.scroll_at(s, size, cursor, amount);
    // rust: Vec::new()
}
}
}
    // The mouse wheel at the cursor.
scroll_at :: proc(self: ^Self, s: ^Settings, size: (f32) {
}
    // rust: if self.resource_error.is_some() {
    // rust: return;
}
    // rust: if Self::graphics_page(self.page()).is_some() {
    // rust: self.graphics.scroll(s, size, amount);
    // rust: return;
}
    // rust: if Self::controller_page(self.page()).is_some() {
    // rust: self.controller.scroll(s, size, amount);
    // rust: return;
}
    // rust: match &mut self.pack_screen {
    // rust: Some(p) if self.stack.last() == Some(&Page::Packs) => {
    // rust: p.scroll(cursor.0 as f64, cursor.1 as f64, amount as f64)
}
    // rust: _ => self.scroll(s, size, amount),
}
}
    // `VideoSettingsScreen.mouseScrolled`: with Ctrl held the wheel steps the GUI scale
    // (auto counts as one past the maximum) and the list goes back to the top.
    // rust: pub fn video_wheel_gui_scale(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: framebuffer: [i32; 2],
    // rust: amount: f32,
    // rust: ) -> Vec<Event> {
    // rust: let max = i64::from(crate::window::calculate_scale(
    // rust: framebuffer,
    // rust: 0,
    // rust: s.force_unicode,
    // rust: ));
    // rust: let old = if s.gui_scale == 0 {
    // rust: max + 1
    // rust: } else {
    // rust: i64::from(s.gui_scale)
}
    // rust: let step = i64::from(amount > 0.0) - i64::from(amount < 0.0);
    // rust: let new = old + step;
    // rust: if new == 0 || new > max {
    // rust: return Vec::new();
}
    // rust: s.gui_scale = new as u32;
    // rust: self.scroll = 0.0;
    // rust: vec![Event::Changed]
}
    // The pack screen at this GUI size, made on first use.
packs :: proc(self: ^Self, atlas: ^HudAtlas, size: (f32) {
}
    // rust: let m = crate::screen_draw::Measure(&atlas.font);
    // rust: let (w, h) = (size.0 as i32, size.1 as i32);
    // rust: match &mut self.pack_screen {
    // rust: Some(p) => {
    // rust: if p.width != w || p.height != h {
    // rust: p.resize(&m, w, h);
}
}
    // rust: None => {
    // rust: self.pack_focus = Instant::now();
    // rust: let title = if self.data_pack_dir.is_some() {
    // rust: "dataPack.title"
    // rust: } else {
    // rust: "resourcePack.title"
}
    // rust: let mut screen = crate::pack_screen::PackScreen::new(
    // rust: &m,
    // rust: crate::text::Text::translate(title, &[]),
    // rust: w,
    // rust: h,
    // rust: self.in_world,
    // rust: self.pack_infos.clone(),
    // rust: &self.pack_selection,
    // rust: );
    // rust: screen.browsing_allowed = self.pack_browser;
    // rust: screen.changed = std::mem::take(&mut self.pack_reselected);
    // rust: self.pack_screen = Some(screen);
}
}
    // rust: self.pack_screen.as_mut().expect("made above")
}
    // Escape or Done: leave the current page, applying page results.
    // After an input on HDR calibration: Save keeps what it landed on, Cancel what was
    // set before; both go back to the graphics screen's HDR page.
    // rust: fn calibration_outcome(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: outcome: crate::hdr_calibration::Outcome,
    // rust: ) -> Vec<Event> {
//         use crate::hdr_calibration::Outcome;
    // rust: match outcome {
    // rust: Outcome::Nothing | Outcome::Changed => Vec::new(),
    // rust: Outcome::Click => vec![Event::ButtonClick],
    // rust: Outcome::Save | Outcome::Cancel => {
    // rust: if let Some(c) = self.calibration.take()
    // rust: && outcome == Outcome::Save
    // rust: {
    // rust: c.save(s);
}
    // rust: let mut events = vec![Event::ButtonClick];
    // rust: events.extend(self.back(s));
    // rust: events
}
}
}
    // HDR calibration's test picture, while its page is open: the step, its nits and
    // where the controls start (a share of the height `h`).
calibration_picture :: proc(self: ^Self, h: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.calibration
    // rust: .as_ref()
    // rust: .filter(|_| self.page() == Page::HdrCalibration)
    // rust: .map(|c| c.picture(h))
}
back :: proc(self: ^Self, s: ^Settings) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut events = Vec::new();
        // A pack's screen goes back to the one that opened it.
    // rust: if self.page() == Page::ShaderOptions
    // rust: && let Some(options) = &mut s.shader_options
    // rust: && options.path.pop().is_some()
    // rust: {
    // rust: self.scroll = 0.0;
    // rust: return events;
}
    // rust: let page = self.stack.pop().unwrap_or(Page::Main);
    // rust: self.scroll = 0.0;
    // rust: self.scrollbar_drag_y = None;
    // rust: self.dragging = None;
    // rust: self.slider_value = None;
    // rust: self.selected_key = None;
    // rust: self.selected_pad_action = None;
    // rust: self.focus = None;
    // rust: self.focus_from_keyboard = false;
    // rust: self.settings_search.focused = false;
    // rust: self.language_search.focused = false;
    // rust: self.can_change_value = false;
    // rust: match page {
    // rust: Page::ShaderOptions => {
    // rust: if s.shader_options.as_ref().is_some_and(|o| o.changed) {
    // rust: events.push(Event::ShaderOptions);
    // rust: } else {
    // rust: s.shader_options = None;
}
}
    // rust: Page::Language => {
    // rust: if let Some(code) = self.language_choice.take()
    // rust: && code != s.language
    // rust: {
    // rust: s.language = code.clone();
    // rust: events.push(Event::Language(code));
}
}
    // rust: Page::Packs => {
                // PackSelectionScreen.onClose: PackSelectionModel.commit.
    // rust: let data = self.data_pack_dir.take();
    // rust: if let Some(p) = self.pack_screen.take()
    // rust: && p.changed
    // rust: {
    // rust: let ids = p.commit();
    // rust: if data.is_some() {
    // rust: events.push(Event::DataPacks(ids));
    // rust: } else {
                        // `PackSelectionModel.commit` already drops `server/…`
                        // ids; keep the same filter if the screen is rebuilt.
    // rust: let ids = crate::packs::player_pack_ids(ids);
    // rust: s.resource_packs = ids.clone();
    // rust: self.pack_selection = ids.clone();
    // rust: events.push(Event::Packs(ids));
}
}
}
    // rust: _ => {}
}
    // rust: events.push(Event::Changed);
    // rust: if self.stack.is_empty() {
    // rust: events.push(Event::Close);
}
    // rust: events
}
    // Typed text (the language search box).
type_text :: proc(self: ^Self, atlas: ^HudAtlas, text: string) {
}
    // rust: if self.resource_error.is_some() {
    // rust: return;
}
    // rust: if self.page() == Page::Packs
    // rust: && let Some(p) = &mut self.pack_screen
    // rust: {
    // rust: p.type_text(&crate::screen_draw::Measure(&atlas.font), text);
    // rust: return;
}
    // rust: if self.page() == Page::Language {
    // rust: self.language_search.insert_text(text);
    // rust: self.scroll = 0.0;
    // rust: } else if self.page() == Page::SplitProfiles {
    // rust: self.split_profiles.type_text(text);
    // rust: } else if Self::graphics_page(self.page()).is_some() && self.graphics.typing() {
    // rust: self.graphics.type_text(text);
    // rust: } else if Self::controller_page(self.page()).is_some() && self.controller.typing() {
    // rust: self.controller.type_text(text);
    // rust: } else if self.settings_search_active() {
    // rust: self.settings_search.insert_text(text);
    // rust: self.scroll = 0.0;
}
}
    // Ctrl+A/C/V/X in the language or pack search box; false when neither
    // is shown with the focus.
    // rust: pub fn shortcut(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: shortcut: crate::clipboard::EditShortcut,
    // rust: clipboard: &mut dyn crate::clipboard::Clipboard,
    // rust: ) -> bool {
    // rust: if self.resource_error.is_some() || self.selected_key.is_some() {
    // rust: return false;
}
    // rust: if self.page() == Page::Packs
    // rust: && let Some(p) = &mut self.pack_screen
    // rust: {
    // rust: let m = crate::screen_draw::Measure(&atlas.font);
    // rust: return p.shortcut(&m, shortcut, clipboard);
}
    // rust: if self.page() == Page::Language {
    // rust: if self.language_search.shortcut(shortcut, clipboard) {
    // rust: self.scroll = 0.0;
}
    // rust: return true;
}
    // rust: if self.page() == Page::SplitProfiles {
    // rust: return self.split_profiles.shortcut(shortcut, clipboard);
}
    // rust: if Self::graphics_page(self.page()).is_some() {
    // rust: return self.graphics.shortcut(shortcut, clipboard);
}
    // rust: if Self::controller_page(self.page()).is_some() {
    // rust: return self.controller.shortcut(shortcut, clipboard);
}
    // rust: if self.settings_search_active() {
    // rust: if self.settings_search.shortcut(shortcut, clipboard) {
    // rust: self.scroll = 0.0;
}
    // rust: return true;
}
    // rust: false
}
bind_key :: proc(self: ^Self, s: ^Settings, value: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(name) = self.selected_key.take() else {
    // rust: return Vec::new();
}
    // rust: if name == NATIVE_KEY {
    // rust: let (i, k) = self.selected_native_key.take().unwrap_or_default();
    // rust: let Some(m) = s.mods.installed.get(i) else {
    // rust: return Vec::new();
}
    // rust: let Some([key, ..]) = m.native.as_ref().and_then(|p| p.keys.get(k)) else {
    // rust: return Vec::new();
}
    // rust: let keys = s.mods.keys.entry(m.id.clone()).or_default();
    // rust: keys.insert(key.clone(), value);
    // rust: return vec![Event::Changed];
}
    // rust: if !s.extras.set_key(name, value.clone()) && !s.horizon.set_key(name, value.clone()) {
    // rust: s.keys.set(name, &value);
}
    // rust: vec![Event::Changed]
}
    // Mouse bindings use the same settings and persistence as keyboard bindings.
    // rust: pub fn bind_mouse(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: button: winit::event::MouseButton,
    // rust: ) -> Vec<Event> {
    // rust: self.bind_key(s, keybinds::mouse_name(button))
}
    // Keys while the options are open. Returns events; `handled` false lets
    // Escape fall through.
    // rust: pub fn key(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: atlas: &HudAtlas,
    // rust: key: winit::keyboard::KeyCode,
    // rust: text: Option<&str>,
    // rust: ) -> Vec<Event> {
    // rust: self.key_modifiers(s, atlas, key, text, false)
}

    // Keys while the options are open, including Shift modifier state.
    // rust: pub fn key_modifiers(
    // rust: &mut self,
    // rust: s: &mut Settings,
    // rust: atlas: &HudAtlas,
    // rust: key: winit::keyboard::KeyCode,
    // rust: text: Option<&str>,
    // rust: shift: bool,
    // rust: ) -> Vec<Event> {
//         use winit::keyboard::KeyCode as K;
    // rust: if self.page() == Page::HdrCalibration
    // rust: && let Some(c) = &mut self.calibration
    // rust: {
    // rust: let outcome = c.key(key);
    // rust: return self.calibration_outcome(s, outcome);
}
    // rust: if self.resource_error.is_some() {
    // rust: if matches!(key, K::Escape | K::Enter | K::NumpadEnter) {
    // rust: self.resource_error = None;
}
    // rust: return Vec::new();
}
    // rust: if self.page() == Page::Packs
    // rust: && let Some(p) = &mut self.pack_screen
    // rust: {
    // rust: let m = crate::screen_draw::Measure(&atlas.font);
    // rust: match key {
                // ConfirmScreen.keyPressed: Escape answers no.
    // rust: K::Escape if p.confirming() => {
    // rust: p.cancel_confirm(&m);
    // rust: return Vec::new();
}
    // rust: K::Backspace => {
    // rust: p.erase(&m, 1);
    // rust: return Vec::new();
}
    // rust: _ => {}
}
}
    // rust: if let Some(action) = self.selected_pad_action.take() {
            // As on Key Binds, Escape unbinds; other keys cancel.
    // rust: if key == K::Escape {
    // rust: s.controller.bind(action, None);
}
    // rust: return vec![Event::Changed];
}
    // rust: if self.selected_key.is_some() {
            // KeyBindsScreen.keyPressed: Escape unbinds.
    // rust: let value = if key == K::Escape {
    // rust: "key.keyboard.unknown".to_owned()
    // rust: } else {
    // rust: keybinds::key_name(key)
    // rust: .unwrap_or("key.keyboard.unknown")
    // rust: .to_owned()
}
    // rust: return self.bind_key(s, value);
}
    // rust: if self.page() == Page::SplitProfiles && self.split_profiles.key(key, text) {
    // rust: return Vec::new();
}

    // rust: if Self::graphics_page(self.page()).is_some() {
    // rust: let size = (self.size.0.max(480.0), self.size.1.max(240.0));
    // rust: let fb = [self.framebuffer[0].max(480), self.framebuffer[1].max(240)];
    // rust: let (actions, handled) = self.graphics.key_modifiers(s, key, text, shift, size, fb);
    // rust: let mut events = self.graphics_events(s, actions);
    // rust: if key == K::Escape {
    // rust: events.extend(self.back(s));
    // rust: return events;
}
    // rust: if handled {
    // rust: return events;
}
    // rust: return events;
}
    // rust: if Self::controller_page(self.page()).is_some() {
    // rust: let size = (self.size.0.max(480.0), self.size.1.max(240.0));
    // rust: let fb = [self.framebuffer[0].max(480), self.framebuffer[1].max(240)];
    // rust: let (actions, _) = self.controller.key_modifiers(s, key, text, shift, size, fb);
    // rust: let mut events = self.controller_events(s, actions);
    // rust: if key == K::Escape {
    // rust: events.extend(self.back(s));
}
    // rust: return events;
}

    // rust: if key == K::Escape {
    // rust: return self.back(s);
}

        // Search field text entry when search box is focused
    // rust: if self.focus == Some(FocusId::Search) {
    // rust: if key != K::Tab && key != K::ArrowDown {
    // rust: let search = if self.page() == Page::Language {
    // rust: &mut self.language_search
    // rust: } else {
    // rust: &mut self.settings_search
}
    // rust: if !search.key(key, false, shift)
    // rust: && let Some(t) = text
    // rust: {
    // rust: let typed: String = t.chars().filter(|c| !c.is_control()).collect();
    // rust: if !typed.is_empty() {
    // rust: search.insert_text(&typed);
}
}
    // rust: self.scroll = 0.0;
    // rust: return Vec::new();
}
    // rust: } else if self.page() == Page::Language && self.focus.is_none() {
    // rust: if !self.language_search.key(key, false, shift)
    // rust: && let Some(t) = text
    // rust: {
    // rust: let typed: String = t.chars().filter(|c| !c.is_control()).collect();
    // rust: if !typed.is_empty() {
    // rust: self.language_search.insert_text(&typed);
}
}
    // rust: self.scroll = 0.0;
    // rust: } else if self.settings_search_active() && self.focus.is_none() {
    // rust: if !self.settings_search.key(key, false, shift)
    // rust: && let Some(t) = text
    // rust: {
    // rust: let typed: String = t.chars().filter(|c| !c.is_control()).collect();
    // rust: if !typed.is_empty() {
    // rust: self.settings_search.insert_text(&typed);
}
}
    // rust: self.scroll = 0.0;
}

        // Gather focusables on the current page
    // rust: let (widgets, top, bottom, content) = self.layout(s, self.size.0, self.size.1);
    // rust: let has_search = (self.page() == Page::Language) || self.settings_search_active();
    // rust: let mut focusables: Vec<(FocusId, [f32; 4], bool)> = Vec::new();
    // rust: if has_search {
    // rust: let search = if self.page() == Page::Language {
    // rust: &self.language_search
    // rust: } else {
    // rust: &self.settings_search
}
    // rust: focusables.push((
    // rust: FocusId::Search,
    // rust: [search.x, search.y, search.width, search.height],
    // rust: false,
    // rust: ));
}
    // rust: for (i, wd) in widgets.iter().enumerate() {
    // rust: match wd.kind {
    // rust: WKind::Button { active: true, .. }
    // rust: | WKind::Slider { .. }
    // rust: | WKind::PackSlider { .. }
    // rust: | WKind::LanguageRow { .. } => {
    // rust: focusables.push((focus_id(i, wd), [wd.x, wd.y, wd.w, wd.h], wd.list));
}
    // rust: _ => {}
}
}
    // rust: if focusables.is_empty() {
    // rust: return Vec::new();
}

        // 1. Tab / Shift+Tab navigation
    // rust: if key == K::Tab {
    // rust: let at = self
    // rust: .focus
    // rust: .as_ref()
    // rust: .and_then(|fid| focusables.iter().position(|(id, ..)| id == fid));
    // rust: let next_idx = match at {
    // rust: None => {
    // rust: if shift {
    // rust: focusables.len() - 1
    // rust: } else {
    // rust: 0
}
}
    // rust: Some(p) => {
    // rust: if shift {
    // rust: (p + focusables.len() - 1) % focusables.len()
    // rust: } else {
    // rust: (p + 1) % focusables.len()
}
}
}
    // rust: let (next_id, rect, in_list) = &focusables[next_idx];
    // rust: self.focus = Some(next_id.clone());
    // rust: self.focus_from_keyboard = true;
    // rust: self.can_change_value = matches!(next_id, FocusId::Slider(_) | FocusId::PackSlider(..));
    // rust: if *in_list {
    // rust: if rect[1] < top {
    // rust: self.scroll -= (top - rect[1]) + 4.0;
    // rust: } else if rect[1] + rect[3] > bottom {
    // rust: self.scroll += (rect[1] + rect[3] - bottom) + 4.0;
}
    // rust: self.clamp_scroll(top, bottom, content);
}
    // rust: return Vec::new();
}

        // 2. Left / Right Arrow keys
    // rust: if matches!(key, K::ArrowLeft | K::ArrowRight) {
    // rust: let forward = key == K::ArrowRight;
            // If focused on a slider and in can_change_value mode: adjust the slider value!
    // rust: if let Some(FocusId::Slider(opt)) = self.focus
    // rust: && self.can_change_value
    // rust: {
    // rust: let width = widgets
    // rust: .iter()
    // rust: .find(|wd| matches!(wd.kind, WKind::Slider { opt: o, .. } if o == opt))
    // rust: .map_or(150.0, |wd| wd.w);
    // rust: return self.step_slider_option(s, opt, forward, width);
}
    // rust: if let Some(FocusId::PackSlider(pack, option)) = self.focus
    // rust: && self.can_change_value
    // rust: {
    // rust: return Self::step_pack_slider(s, pack, option, forward);
}
            // Otherwise, navigate horizontally using 2D focus stepping
    // rust: if let Some(fid) = &self.focus {
    // rust: if let Some(cur_pos) = focusables.iter().position(|(id, ..)| id == fid) {
    // rust: let from = focusables[cur_pos].1;
    // rust: let rects: Vec<[f32; 4]> = focusables.iter().map(|f| f.1).collect();
    // rust: let dir = if forward {
    // rust: gamepad::Button::DPadRight
    // rust: } else {
    // rust: gamepad::Button::DPadLeft
}
    // rust: if let Some(next_idx) = gamepad::focus_step_rect(from, dir, &rects) {
    // rust: let (next_id, rect, in_list) = &focusables[next_idx];
    // rust: self.focus = Some(next_id.clone());
    // rust: self.focus_from_keyboard = true;
    // rust: self.can_change_value = false;
    // rust: if *in_list {
    // rust: if rect[1] < top {
    // rust: self.scroll -= (top - rect[1]) + 4.0;
    // rust: } else if rect[1] + rect[3] > bottom {
    // rust: self.scroll += (rect[1] + rect[3] - bottom) + 4.0;
}
    // rust: self.clamp_scroll(top, bottom, content);
}
}
}
    // rust: } else {
    // rust: self.focus = Some(focusables[0].0.clone());
    // rust: self.focus_from_keyboard = true;
    // rust: self.can_change_value = false;
}
    // rust: return Vec::new();
}

        // 3. Up / Down Arrow keys
    // rust: if matches!(key, K::ArrowUp | K::ArrowDown) {
    // rust: let down = key == K::ArrowDown;
    // rust: if let Some(fid) = &self.focus {
    // rust: if let Some(cur_pos) = focusables.iter().position(|(id, ..)| id == fid) {
    // rust: let from = focusables[cur_pos].1;
    // rust: let rects: Vec<[f32; 4]> = focusables.iter().map(|f| f.1).collect();
    // rust: let dir = if down {
    // rust: gamepad::Button::DPadDown
    // rust: } else {
    // rust: gamepad::Button::DPadUp
}
    // rust: let step = gamepad::focus_step_strict(from, dir, &rects)
    // rust: .or_else(|| gamepad::focus_step_vague(from, dir, &rects));
    // rust: if let Some(next_idx) = step {
    // rust: let (next_id, rect, in_list) = &focusables[next_idx];
    // rust: self.focus = Some(next_id.clone());
    // rust: self.focus_from_keyboard = true;
    // rust: self.can_change_value = false;
    // rust: if *in_list {
    // rust: if rect[1] < top {
    // rust: self.scroll -= (top - rect[1]) + 4.0;
    // rust: } else if rect[1] + rect[3] > bottom {
    // rust: self.scroll += (rect[1] + rect[3] - bottom) + 4.0;
}
    // rust: self.clamp_scroll(top, bottom, content);
}
    // rust: } else {
                        // Off the edge of visible rows: scroll the list
    // rust: self.scroll += if down { 18.0 } else { -18.0 };
    // rust: self.clamp_scroll(top, bottom, content);
}
}
    // rust: } else {
    // rust: self.focus = Some(focusables[0].0.clone());
    // rust: self.focus_from_keyboard = true;
    // rust: self.can_change_value = false;
}
    // rust: return Vec::new();
}

        // 4. Enter / Space selection keys
    // rust: if matches!(key, K::Enter | K::NumpadEnter | K::Space) {
    // rust: match &self.focus {
    // rust: Some(FocusId::Slider(_) | FocusId::PackSlider(..)) => {
    // rust: self.can_change_value = !self.can_change_value;
    // rust: return Vec::new();
}
    // rust: Some(FocusId::Cycle(opt)) => {
    // rust: let mut events = vec![Event::ButtonClick];
    // rust: events.extend(self.cycle_option(s, *opt, shift, self.framebuffer));
    // rust: return events;
}
    // rust: Some(FocusId::Act(act)) => {
    // rust: let mut events = vec![Event::ButtonClick];
    // rust: let act = act.clone();
    // rust: match act {
    // rust: Act::Push(p) => {
    // rust: self.focus = None;
    // rust: self.focus_from_keyboard = false;
    // rust: self.can_change_value = false;
    // rust: if p == Page::ShaderPacks {
    // rust: events.push(Event::ListShaderPacks);
}
    // rust: if p == Page::Music {
    // rust: events.push(Event::ListMusicTracks);
}
    // rust: if p == Page::ModBrowser {
    // rust: events.push(Event::BrowseMods);
}
    // rust: self.push(p);
}
    // rust: Act::Done => {
    // rust: self.focus = None;
    // rust: self.focus_from_keyboard = false;
    // rust: self.can_change_value = false;
    // rust: events.extend(self.back(s));
}
    // rust: Act::Cycle(opt) => {
    // rust: events.extend(self.cycle_option(s, opt, shift, self.framebuffer));
}
    // rust: Act::Extra(item) => {
    // rust: if let Some(name) = item.key_name() {
    // rust: self.selected_key = Some(name);
    // rust: } else {
    // rust: item.cycle(&mut s.extras, shift);
    // rust: events.push(Event::Changed);
}
}
    // rust: Act::PlayMusicTrack(event, track) => {
    // rust: events.push(Event::PlayMusicTrack(event, track));
}
    // rust: Act::MusicTrackOn(track, was_on) => {
    // rust: s.extras
    // rust: .music_off
    // rust: .retain(|off| off.as_str() != track.as_str());
    // rust: if was_on {
    // rust: s.extras.music_off.push(track);
}
    // rust: events.push(Event::Changed);
}
    // rust: Act::Key(name) => self.selected_key = Some(name),
    // rust: Act::ResetKey(name) => {
    // rust: s.keys.set(name, KeyBinds::default_of(name));
    // rust: events.push(Event::Changed);
}
    // rust: Act::ResetKeys => {
    // rust: s.keys.reset_all();
    // rust: events.push(Event::Changed);
}
    // rust: Act::ToggleMod(i) => {
    // rust: s.mods.toggle(i);
    // rust: events.push(Event::Changed);
}
    // rust: Act::ModSettings(i) => {
    // rust: self.focus = None;
    // rust: self.focus_from_keyboard = false;
    // rust: self.can_change_value = false;
    // rust: self.push(Page::NativeMod(i));
    // rust: events.push(Event::NativeSettings(i));
}
    // rust: Act::NativeKey(i, k) => {
    // rust: self.selected_key = Some(NATIVE_KEY);
    // rust: self.selected_native_key = Some((i, k));
}
    // rust: Act::NativeButton(i, b) => events.push(Event::NativeButton(i, b)),
    // rust: Act::OpenModFolder => events.push(Event::OpenModFolder),
    // rust: Act::ModProject(i) => {
    // rust: if let Some(listing) = self.mod_browser.listings.get(i) {
    // rust: self.mod_project = listing.id.clone();
    // rust: self.push(Page::ModProject);
}
}
    // rust: Act::InstallMod => {
    // rust: self.mod_browser.message = None;
    // rust: events.push(Event::InstallMod(self.mod_project.clone()));
}
    // rust: Act::OpenModPage => {
    // rust: if let Some(l) = self.mod_browser.listing(&self.mod_project) {
    // rust: events.push(Event::OpenModPage(l.page.clone()));
}
}
    // rust: Act::PvpPreset => {
    // rust: crate::pvp::apply_preset(s);
    // rust: events.push(Event::Changed);
}
    // rust: Act::HudEditor => events.push(Event::HudEditor),
    // rust: Act::AccessibilityHelp => events.push(Event::AccessibilityHelp),
    // rust: Act::PickShaderPack(i) => {
    // rust: if let Some(pack) = s.shader_packs.get(i) {
    // rust: s.horizon.shader_pack = if s.horizon.shader_pack == pack.file {
    // rust: String::new()
    // rust: } else {
    // rust: pack.file.clone()
}
    // rust: events.push(Event::ShaderPack);
}
}
    // rust: Act::OpenShaderPackFolder => events.push(Event::OpenShaderPackFolder),
                        // The shader options page's buttons, as a click does them.
    // rust: Act::ShaderOptions => {
    // rust: self.focus = None;
    // rust: self.focus_from_keyboard = false;
    // rust: self.can_change_value = false;
    // rust: s.shader_options = None;
    // rust: self.push(Page::ShaderOptions);
    // rust: events.push(Event::OpenShaderOptions);
}
    // rust: Act::ShaderOption(name) => {
    // rust: if let Some(options) = &mut s.shader_options {
    // rust: if shift {
    // rust: options.reset_option(&name);
    // rust: } else {
    // rust: options.cycle(&name, false);
}
}
}
    // rust: Act::ShaderScreen(screen) => {
    // rust: if let Some(options) = &mut s.shader_options {
    // rust: self.focus = None;
    // rust: self.focus_from_keyboard = false;
    // rust: options.path.push(screen);
    // rust: self.scroll = 0.0;
}
}
    // rust: Act::ShaderProfile => {
    // rust: if let Some(options) = &mut s.shader_options {
    // rust: options.next_profile();
}
}
    // rust: Act::ShaderReset => {
    // rust: if let Some(options) = &mut s.shader_options {
    // rust: options.reset();
}
}
    // rust: Act::NativePackOptions(i) => {
    // rust: self.push(Page::NativePackOptions(i, 0));
}
    // rust: Act::NativePackOption(pack, option) => {
    // rust: if let Some(entry) = s.shader_packs.get_mut(pack)
    // rust: && entry.step_option(option, false, shift)
    // rust: {
    // rust: events.push(Event::NativePackOptions(pack));
}
}
    // rust: Act::NativePackReset(pack) => {
    // rust: if let Some(entry) = s.shader_packs.get_mut(pack) {
    // rust: entry.reset_options();
    // rust: events.push(Event::NativePackOptions(pack));
}
}
    // rust: Act::Credits => events.push(Event::Credits),
    // rust: Act::CopyAgentDetails => events.push(Event::CopyAgentDetails),
    // rust: Act::ToggleRecording => events.push(Event::ToggleRecording),
    // rust: Act::ExportRepro => events.push(Event::ExportRepro),
    // rust: Act::None => {}
}
    // rust: return events;
}
    // rust: Some(FocusId::Lang(code)) => {
                    // `LanguageSelectionList.Entry.keyPressed`: the selection
                    // key (`isSelection`: Enter, Space, keypad Enter) selects
                    // the row and finishes the screen at once (`onDone`), so
                    // the language applies on that one press.
    // rust: let mut events = vec![Event::ButtonClick];
    // rust: self.language_choice = Some(code.clone());
    // rust: events.extend(self.back(s));
    // rust: return events;
}
    // rust: _ => {}
}
}
    // rust: Vec::new()
}
}

    // rust: mod tests {
//     use super::*;

    // The window allows the input method only while `typing` says a search
    // box has the focus (`Game::text_field_focused`), so a page without one
    // must not claim the keys: the movement and menu keys keep working there.
only_a_focused_search_box_takes_text :: proc() {
}
    // rust: let mut ui = OptionsUi::default();
    // rust: assert!(!ui.typing(), "the main page has no text box");
    // rust: ui.show(Page::Language);
    // rust: assert!(ui.typing(), "the language list's search takes the keys");
    // rust: ui.show(Page::Video);
    // rust: assert!(!ui.typing(), "the settings search is not focused");
    // rust: ui.settings_search.focused = true;
    // rust: assert!(ui.typing(), "the settings search, once focused, does");
    // rust: ui.settings_search.focused = false;
    // rust: ui.show(Page::Packs);
    // rust: assert!(!ui.typing(), "the pack screen's search is not open yet");
}

accessibility_sliders_and_toggles_survive_options_round_trip :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: for opt in [
    // rust: Opt::FovEffects,
    // rust: Opt::DarknessPulsing,
    // rust: Opt::DamageTilt,
    // rust: Opt::PanoramaSpeed,
    // rust: ] {
    // rust: for position in [0.0, 0.5, 1.0] {
    // rust: opt.set_slider(&mut s, position);
    // rust: let loaded = Settings::parse(&s.serialize());
    // rust: assert_eq!(opt.slider_position(&loaded), Some(position));
    // rust: let expected = if matches!(opt, Opt::FovEffects | Opt::DarknessPulsing) {
    // rust: f64::from(position).powi(2)
    // rust: } else {
    // rust: f64::from(position)
}
    // rust: assert_eq!(loaded.file.double(opt.file_key().unwrap()), expected);
}
}
    // rust: assert!(Opt::MonochromeLogo.available());
    // rust: for opt in [
    // rust: Opt::TextBackground,
    // rust: Opt::HideLightningFlashes,
    // rust: Opt::HideSplashTexts,
    // rust: Opt::MonochromeLogo,
    // rust: ] {
    // rust: let key = opt.file_key().unwrap();
    // rust: let before = s.file.bool(key);
    // rust: opt.cycle(&mut s, false, [854, 480]);
    // rust: assert_eq!(Settings::parse(&s.serialize()).file.bool(key), !before);
}
    // rust: Opt::TextBackground.cycle(&mut s, false, [854, 480]);
    // rust: let chat_only = s.text_background(0.0);
    // rust: Opt::TextBackground.cycle(&mut s, false, [854, 480]);
    // rust: assert_ne!(s.text_background(0.0), chat_only);
}

mouse_settings_match_java_26_3_option_order :: proc() {
}
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Mouse);
    // rust: let mut options = Vec::new();
    // rust: for row in ui.list_rows(&Settings::default()) {
    // rust: if let Row::Pair(a, b) = row {
    // rust: options.push(a);
    // rust: if let Some(b) = b {
    // rust: options.push(b);
}
}
}
    // rust: assert_eq!(
    // rust: options,
    // rust: vec![
    // rust: Opt::Sensitivity,
    // rust: Opt::WheelSensitivity,
    // rust: Opt::DiscreteScroll,
    // rust: Opt::InvertX,
    // rust: Opt::InvertY,
    // rust: Opt::AllowCursorChanges,
    // rust: ]
    // rust: );
}

mouse_settings_round_trip_with_java_defaults :: proc() {
}
    // rust: let mut settings = Settings::default();
    // rust: assert!(!settings.invert_x);
    // rust: assert!(settings.allow_cursor_changes);
    // rust: Opt::InvertX.cycle(&mut settings, false, [854, 480]);
    // rust: Opt::AllowCursorChanges.cycle(&mut settings, false, [854, 480]);
    // rust: let loaded = Settings::parse(&settings.serialize());
    // rust: assert!(loaded.invert_x);
    // rust: assert!(!loaded.allow_cursor_changes);
    // rust: assert!(!loaded.file.bool("allowCursorChanges"));
}

accessibility_has_all_options_and_disabled_placeholders :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Accessibility);
    // rust: let (widgets, _, _, _) = ui.layout(&s, 480.0, 1200.0);
    // rust: let options: Vec<_> = widgets
    // rust: .iter()
    // rust: .filter_map(|w| match w.kind {
    // rust: WKind::Button {
    // rust: act: Act::Cycle(opt),
    // rust: ..
}
    // rust: | WKind::Slider { opt, .. } => Some(opt),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(options, ACCESSIBILITY_OPTIONS);
    // rust: for &opt in ACCESSIBILITY_OPTIONS {
    // rust: let widget = widgets
    // rust: .iter()
    // rust: .find(|w| match w.kind {
    // rust: WKind::Button {
    // rust: act: Act::Cycle(o), ..
}
    // rust: | WKind::Slider { opt: o, .. } => o == opt,
    // rust: _ => false,
    // rust: })
    // rust: .expect("every accessibility option has a control");
    // rust: if !opt.available() {
    // rust: assert!(matches!(widget.kind, WKind::Button { active: false, .. }));
    // rust: let before = s.serialize();
    // rust: opt.cycle(&mut s, false, [854, 480]);
    // rust: opt.set_slider(&mut s, 0.0);
    // rust: assert_eq!(s.serialize(), before);
}
}
    // rust: assert!(widgets.iter().any(|w| matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::Push(Page::Controls),
    // rust: active: true,
    // rust: ..
}
    // rust: )));
        // `AccessibilityOptionsScreen.addFooter`: the "Accessibility Help"
        // link button sits beside Done.
    // rust: assert!(widgets.iter().any(|w| matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::AccessibilityHelp,
    // rust: active: true,
    // rust: ..
}
    // rust: )));
}

the_narrator_option_cycles_its_four_statuses_and_announces_them :: proc() {
}
//         use horizon_narrator::Status;
    // rust: let mut s = Settings::default();
    // rust: for want in [Status::All, Status::Chat, Status::System, Status::Off] {
    // rust: Opt::Narrator.cycle(&mut s, false, [854, 480]);
    // rust: assert_eq!(s.narrator(), want);
}
    // rust: Opt::Narrator.cycle(&mut s, true, [854, 480]);
    // rust: assert_eq!(s.narrator(), Status::System);
    // rust: let mut ui = OptionsUi::default();
    // rust: assert_eq!(
    // rust: ui.cycle_option(&mut s, Opt::Narrator, false, [854, 480]),
    // rust: [Event::Changed, Event::Narrator]
    // rust: );
    // rust: assert_eq!(
    // rust: ui.cycle_option(&mut s, Opt::NarratorHotkey, false, [854, 480]),
    // rust: [Event::Changed]
    // rust: );
    // rust: assert!(!s.file.bool("narratorHotkey"));
}

without_speech_the_narrator_button_is_inactive_and_not_available :: proc() {
}
        // Tests never open the narrator: text2speech's Narrator.EMPTY.
    // rust: let s = Settings::default();
    // rust: let widget = option_widget(&s, Opt::Narrator, 0.0, 0.0, 150.0);
    // rust: assert!(matches!(widget.kind, WKind::Button { active: false, .. }));
    // rust: assert_eq!(
    // rust: Opt::Narrator.value_text(&s).plain(),
    // rust: tr("options.narrator.notavailable").plain()
    // rust: );
    // rust: let hotkey = option_widget(&s, Opt::NarratorHotkey, 0.0, 0.0, 150.0);
    // rust: assert!(matches!(hotkey.kind, WKind::Button { active: true, .. }));
}

chat_settings_show_the_narrator_where_vanilla_does :: proc() {
}
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Chat);
    // rust: let options: Vec<Opt> = ui
    // rust: .list_rows(&Settings::default())
    // rust: .into_iter()
    // rust: .flat_map(|row| match row {
    // rust: Row::Big(opt) => vec![opt],
    // rust: Row::Pair(a, b) => std::iter::once(a).chain(b).collect(),
    // rust: _ => Vec::new(),
    // rust: })
    // rust: .collect();
    // rust: let at = options.iter().position(|o| *o == Opt::Narrator).unwrap();
    // rust: assert_eq!(options[at - 1], Opt::ChatHeightUnfocused);
    // rust: assert_eq!(options[at + 1], Opt::AutoSuggestions);
}

controls_match_java_26_3_option_order :: proc() {
}
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Controls);
    // rust: let options =
    // rust: ui.list_rows(&Settings::default())
    // rust: .into_iter()
    // rust: .fold(Vec::new(), |mut options, row| {
    // rust: match row {
    // rust: Row::Big(opt) => options.push(opt),
    // rust: Row::Pair(a, b) => {
    // rust: options.push(a);
    // rust: options.extend(b);
}
    // rust: _ => {}
}
    // rust: options
    // rust: });
    // rust: assert_eq!(options, vanilla_control_options());
}

sprint_window_and_new_control_switches_round_trip :: proc() {
}
    // rust: let mut settings = Settings::default();
    // rust: set_slider(Opt::SprintWindow, &mut settings, 0.5);
    // rust: settings.operator_items_tab = true;
    // rust: settings.quit_shortcuts = false;
    // rust: settings.ctrl_click_emulates_right_click = true;
    // rust: settings.toggle_attack = true;
    // rust: settings.toggle_use = true;
    // rust: let loaded = Settings::parse(&settings.serialize());
    // rust: assert_eq!(loaded.sprint_window, 5);
    // rust: assert!(loaded.operator_items_tab);
    // rust: assert!(!loaded.quit_shortcuts);
    // rust: assert!(loaded.ctrl_click_emulates_right_click);
    // rust: assert!(loaded.toggle_attack && loaded.toggle_use);
}

quit_shortcuts_option_can_be_switched :: proc() {
}
    // rust: assert!(Opt::QuitShortcuts.available());
    // rust: let s = Settings::default();
    // rust: assert_eq!(Opt::QuitShortcuts.caption(), "options.quitShortcuts");
    // rust: assert_eq!(
    // rust: Opt::QuitShortcuts.tooltip_key(&s),
    // rust: "options.quitShortcuts.tooltip"
    // rust: );
}

    // The gating is for genuinely unread keys only: every option a system
    // already consumes must stay clickable.
read_options_are_not_greyed_out :: proc() {
}
    // rust: for opt in [
    // rust: Opt::ChunkFade,
    // rust: Opt::ImprovedTransparency,
    // rust: Opt::ChatDelay,
    // rust: Opt::SaveChatDrafts,
    // rust: Opt::MusicToast,
    // rust: Opt::CtrlClickEmulatesRightClick,
    // rust: ] {
    // rust: assert!(opt.available(), "{opt:?} is read and must be clickable");
}
    // rust: for opt in [
    // rust: Opt::HideMatchedNames,
    // rust: Opt::OnlySecureChat,
    // rust: Opt::RealmsNotifications,
    // rust: Opt::InGameNotification,
    // rust: Opt::SharePresence,
    // rust: Opt::DirectionalAudio,
    // rust: Opt::ChunkBuilder,
    // rust: ] {
    // rust: assert!(!opt.available(), "{opt:?} still has no reader");
}
}

operator_items_tab_option_can_be_switched :: proc() {
}
        // The creative screen reads it (CreativeModeInventoryScreen.hasPermissions).
    // rust: assert!(Opt::OperatorItemsTab.available());
    // rust: let mut s = Settings::default();
    // rust: assert!(!s.operator_items_tab);
    // rust: Opt::OperatorItemsTab.cycle(&mut s, false, [854, 480]);
    // rust: assert!(s.operator_items_tab);
}

render_distance_slider_round_trips_through_extended_options_range :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: for (position, distance) in [(0.0, 2), (0.5, 65), (1.0, 128)] {
    // rust: set_slider(Opt::RenderDistance, &mut s, position);
    // rust: assert_eq!(s.render_distance, distance);
    // rust: let reloaded = Settings::parse(&s.serialize());
    // rust: assert_eq!(reloaded.render_distance, distance);
    // rust: assert_eq!(
    // rust: Opt::RenderDistance.slider_position(&reloaded),
    // rust: Some(position)
    // rust: );
}
    // rust: let mut file = crate::options_file::OptionsFile::default();
    // rust: file.set_text("renderDistance", "128").unwrap();
    // rust: assert!(file.set_text("renderDistance", "129").is_err());
    // rust: assert!(file.set_text("renderDistance", "1").is_err());
    // rust: assert_eq!(file.int("renderDistance"), 128);
}
atlas :: proc() -> H {
    // Ported from Horizon
    return {}
}
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap()
}

a_horizon_packs_options_step_both_ways_from_the_picked_packs_button :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let size = (960.0, 540.0);
    // rust: let mut s = Settings::default();
    // rust: s.horizon.shader_pack = "p".into();
    // rust: s.shader_packs = vec![crate::shader_pack_list::Entry {
    // rust: file: "p".into(),
    // rust: title: "P".into(),
    // rust: kind: crate::shader_pack_list::Kind::Horizon,
    // rust: options: vec![horizon_shader_api::PackOption {
    // rust: id: "a".into(),
    // rust: name: "A".into(),
    // rust: description: String::new(),
    // rust: kind: horizon_shader_api::OptionKind::Choice {
    // rust: values: vec!["x".into(), "y".into(), "z".into()],
    // rust: default: 1,
    // rust: },
    // rust: }],
    // rust: values: vec![1.0],
    // rust: pages: vec![
    // rust: horizon_shader_api::OptionPage {
    // rust: id: "main".into(),
    // rust: name: "P".into(),
    // rust: description: String::new(),
    // rust: columns: 2,
    // rust: items: vec![horizon_shader_api::PageItem::Page(1)],
    // rust: },
    // rust: horizon_shader_api::OptionPage {
    // rust: id: "more".into(),
    // rust: name: "More".into(),
    // rust: description: String::new(),
    // rust: columns: 1,
    // rust: items: vec![horizon_shader_api::PageItem::Option(0)],
    // rust: },
    // rust: ],
    // rust: }];
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::ShaderPacks);
    // rust: let find = |ui: &mut OptionsUi, s: &Settings, want: &Act| {
    // rust: let (widgets, ..) = ui.layout(s, size.0, size.1);
    // rust: let w = widgets
    // rust: .into_iter()
    // rust: .find(|w| matches!(&w.kind, WKind::Button { act, .. } if act == want))
    // rust: .expect("button");
    // rust: (w.x + w.w / 2.0, w.y + w.h / 2.0)
}
    // rust: let (x, y) = find(&mut ui, &s, &Act::NativePackOptions(0));
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: assert_eq!(ui.page(), Page::NativePackOptions(0, 0));
        // The option is on the pack's second page, behind a button on its first.
    // rust: let (x, y) = find(&mut ui, &s, &Act::Push(Page::NativePackOptions(0, 1)));
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: assert_eq!(ui.page(), Page::NativePackOptions(0, 1));
    // rust: let (x, y) = find(&mut ui, &s, &Act::NativePackOption(0, 0));
    // rust: let events = ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: assert!(events.contains(&Event::NativePackOptions(0)));
    // rust: assert_eq!(s.shader_packs[0].values, [2.0]);
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, true);
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, true);
    // rust: assert_eq!(s.shader_packs[0].values, [0.0]);
        // Shift-click: the option's default.
    // rust: ui.shift = true;
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: ui.shift = false;
    // rust: assert_eq!(s.shader_packs[0].values, [1.0]);
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: let (x, y) = find(&mut ui, &s, &Act::NativePackReset(0));
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: assert_eq!(s.shader_packs[0].values, [1.0]);
    // rust: ui.back(&mut s);
    // rust: assert_eq!(ui.page(), Page::NativePackOptions(0, 0));
}

a_horizon_packs_float_and_int_options_are_sliders_saved_on_release :: proc() {
}
//         use horizon_shader_api::{OptionKind, PackOption};
//         use winit::keyboard::KeyCode;
    // rust: let atlas = atlas();
    // rust: let size = (960.0, 540.0);
    // rust: let option = |id: &str, kind| PackOption {
    // rust: id: id.into(),
    // rust: name: id.into(),
    // rust: description: String::new(),
    // rust: kind,
}
    // rust: let pack = crate::shader_pack_list::Entry {
    // rust: file: "p".into(),
    // rust: title: "P".into(),
    // rust: kind: crate::shader_pack_list::Kind::Horizon,
    // rust: options: vec![
    // rust: option(
    // rust: "a",
    // rust: OptionKind::Float {
    // rust: default: 1.0,
    // rust: min: 0.0,
    // rust: max: 2.0,
    // rust: step: 0.5,
    // rust: },
    // rust: ),
    // rust: option(
    // rust: "b",
    // rust: OptionKind::Int {
    // rust: default: 2,
    // rust: min: 0,
    // rust: max: 4,
    // rust: },
    // rust: ),
    // rust: option("c", OptionKind::Bool { default: true }),
    // rust: ],
    // rust: values: vec![1.0, 2.0, 1.0],
    // rust: pages: Vec::new(),
}
    // rust: let mut s = Settings {
    // rust: shader_packs: vec![pack],
    // rust: ..Settings::default()
}
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::NativePackOptions(0, 0));
        // A slider's track, from its left end to its right: (x of 0, x of 1, y).
    // rust: let track = |ui: &mut OptionsUi, s: &Settings, want: usize| {
    // rust: let (widgets, ..) = ui.layout(s, size.0, size.1);
    // rust: widgets
    // rust: .into_iter()
    // rust: .find(|w| matches!(w.kind, WKind::PackSlider { option, .. } if option == want))
    // rust: .map(|w| (w.x + 4.0, w.x + w.w - 4.0, w.y + w.h / 2.0))
}
    // rust: assert!(track(&mut ui, &s, 2).is_none(), "a bool stays a button");
    // rust: let (left, right, y) = track(&mut ui, &s, 0).expect("the float's slider");
    // rust: let at = |f: f32| left + f * (right - left);
        // Pressed a fifth of the way: 0.4 of 2, the nearest step 0.5. Nothing is saved yet.
    // rust: let events = ui.click(&mut s, &atlas, at(0.2), y, size, [854, 480], false, false);
    // rust: assert!(!events.contains(&Event::NativePackOptions(0)));
    // rust: assert_eq!(s.shader_packs[0].values[0], 0.5);
        // Dragged past the right end: the maximum.
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: right + 30.0,
    // rust: y,
    // rust: size,
    // rust: [854, 480],
    // rust: true,
    // rust: false,
    // rust: );
    // rust: assert_eq!(s.shader_packs[0].values[0], 2.0);
        // Released: saved once, which reloads the pack.
    // rust: let events = ui.release();
    // rust: let saves = events.iter().filter(|e| **e == Event::NativePackOptions(0));
    // rust: assert_eq!(saves.count(), 1);
        // A press and release that leave the value as it was save nothing.
    // rust: ui.click(&mut s, &atlas, right, y, size, [854, 480], false, false);
    // rust: assert!(!ui.release().contains(&Event::NativePackOptions(0)));
        // Shift-click: the default at once.
    // rust: ui.shift = true;
    // rust: let events = ui.click(&mut s, &atlas, at(0.9), y, size, [854, 480], false, false);
    // rust: ui.shift = false;
    // rust: assert!(events.contains(&Event::NativePackOptions(0)));
    // rust: assert_eq!(s.shader_packs[0].values[0], 1.0);
    // rust: assert!(!ui.release().contains(&Event::NativePackOptions(0)));

        // The int takes whole numbers: 0.6 of 0..4 is 2.4, so 2, unchanged; 0.7 is 3.
    // rust: let (left, right, y) = track(&mut ui, &s, 1).expect("the int's slider");
    // rust: let at = |f: f32| left + f * (right - left);
    // rust: ui.click(&mut s, &atlas, at(0.6), y, size, [854, 480], false, false);
    // rust: assert_eq!(s.shader_packs[0].values[1], 2.0);
    // rust: assert!(!ui.release().contains(&Event::NativePackOptions(0)));
    // rust: ui.click(&mut s, &atlas, at(0.7), y, size, [854, 480], false, false);
    // rust: assert_eq!(s.shader_packs[0].values[1], 3.0);
    // rust: assert!(ui.release().contains(&Event::NativePackOptions(0)));

        // From the keyboard: the arrows step a focused slider, saving each step, up to its end.
    // rust: ui.focus = Some(FocusId::PackSlider(0, 1));
    // rust: ui.focus_from_keyboard = true;
    // rust: ui.can_change_value = true;
    // rust: let events = ui.key(&mut s, &atlas, KeyCode::ArrowRight, None);
    // rust: assert_eq!(events, [Event::NativePackOptions(0)]);
    // rust: assert_eq!(s.shader_packs[0].values[1], 4.0);
    // rust: assert!(ui.key(&mut s, &atlas, KeyCode::ArrowRight, None).is_empty());
    // rust: assert_eq!(s.shader_packs[0].values[1], 4.0);
    // rust: ui.key(&mut s, &atlas, KeyCode::ArrowLeft, None);
    // rust: assert_eq!(s.shader_packs[0].values[1], 3.0);
}

resource_reload_error_blocks_options_until_dismissed :: proc() {
}
//         use winit::keyboard::KeyCode;
    // rust: let atlas = atlas();
    // rust: let mut settings = Settings::default();
    // rust: let mut ui = OptionsUi {
    // rust: resource_error: Some("broken pack".into()),
    // rust: ..Default::default()
}
    // rust: let stack = ui.stack.clone();
    // rust: assert!(
    // rust: ui.click(
    // rust: &mut settings,
    // rust: &atlas,
    // rust: 10.0,
    // rust: 10.0,
    // rust: (480.0, 270.0),
    // rust: [960, 540],
    // rust: false,
    // rust: false
    // rust: )
    // rust: .is_empty()
    // rust: );
    // rust: assert!(ui.resource_error.is_some());
    // rust: assert!(
    // rust: ui.key(&mut settings, &atlas, KeyCode::KeyW, None)
    // rust: .is_empty()
    // rust: );
    // rust: assert!(ui.resource_error.is_some());
    // rust: ui.key(&mut settings, &atlas, KeyCode::Escape, None);
    // rust: assert!(ui.resource_error.is_none());
    // rust: assert_eq!(ui.stack, stack);
    // rust: ui.resource_error = Some("broken pack".into());
    // rust: assert_eq!(
    // rust: ui.click(
    // rust: &mut settings,
    // rust: &atlas,
    // rust: 240.0,
    // rust: 250.0,
    // rust: (480.0, 270.0),
    // rust: [960, 540],
    // rust: false,
    // rust: false
    // rust: ),
    // rust: vec![Event::ButtonClick]
    // rust: );
    // rust: assert!(ui.resource_error.is_none());
}

    // The Extras page joins caption and value with the language's `options.generic_value`
    // (26.3's templates), not an English ": " (#6072).
extras_captions_use_the_languages_separator :: proc() {
}
Vanilla :: struct {
    // rust: impl lang::ResourceSource for Vanilla {
read :: proc(self: ^Self, path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let generic = match path {
    // rust: "assets/minecraft/lang/fr_fr.json" => "%s : %s",
    // rust: "assets/minecraft/lang/zh_cn.json" => "%s：%s",
    // rust: _ => return None,
}
    // rust: serde_json::to_vec(&serde_json::json!({ "options.generic_value": generic })).ok()
}
}
    // rust: let s = Settings::default();
    // rust: let ui = OptionsUi::default();
    // rust: for (code, shown) in [("fr_fr", "Sans IA : Non"), ("zh_cn", "关闭 AI：关")] {
    // rust: let (label, _) = lang::scoped(lang::Language::load(&[&Vanilla], code), || {
    // rust: match ui.extra_button(&s, crate::extras::Item::NoAi).kind {
    // rust: WKind::Button { label, .. } => label.plain(),
    // rust: _ => String::new(),
}
    // rust: });
    // rust: assert_eq!(label, shown, "{code}");
}
}

    // The texts of an options page, as laid out in `code`'s language, and the keys it lacked.
page_texts :: proc(code: string, pages: ^[Page]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let s = Settings::default();
    // rust: lang::scoped(lang::Language::load(&[], code), || {
    // rust: let mut texts = Vec::new();
    // rust: for page in pages {
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(*page);
    // rust: for w in ui.layout(&s, 480.0, 4000.0).0 {
    // rust: match w.kind {
    // rust: WKind::Button { label: t, .. }
    // rust: | WKind::Slider { label: t, .. }
    // rust: | WKind::Text { text: t, .. } => texts.push(t.plain()),
    // rust: _ => {}
}
}
    // rust: if ui.controller_open() {
    // rust: texts.extend(ui.controller.row_names(&s));
}
}
    // rust: texts
    // rust: })
}

    // Horizon's own options pages said "Splitscreen...", "Hide block-break particles" and
    // "Hotbar: Previous Slot" in every language (#1927).
horizon_option_pages_follow_the_language :: proc() {
}
    // rust: let (texts, missed) = page_texts("de_de", &[Page::Horizon, Page::Extras, Page::PadBinds]);
    // rust: for want in [
    // rust: "Splitscreen …",
    // rust: "Weicher Chat: Aus",
    // rust: "Nachrichtenmarkierung: An",
    // rust: "Kanäle für UI-Töne: Aus",
    // rust: "Schnellzugriffsleiste: Vorheriger Platz",
    // rust: "Schnellzugriffsleiste: Nächster Platz",
    // rust: ] {
    // rust: assert!(texts.iter().any(|t| t == want), "{want:?} not in {texts:?}");
}
        // Every key these pages ask for is in the table; vanilla's own keys (`options.*`,
        // `key.*`: dotted ids without spaces) come from the prepared resources, which this
        // language does not have.
    // rust: let missed: Vec<_> = missed
    // rust: .into_iter()
    // rust: .filter(|k| k.starts_with("horizon.") || k.contains(' ') || !k.contains('.'))
    // rust: .collect();
    // rust: assert_eq!(missed, Vec::<String>::new());
    // rust: let (texts, _) = page_texts("pl_pl", &[Page::Extras, Page::PadBinds]);
    // rust: for want in [
    // rust: "Płynny czat: Wył.",
    // rust: "Pasek szybkiego wyboru: poprzednie pole",
    // rust: ] {
    // rust: assert!(texts.iter().any(|t| t == want), "{want:?} not in {texts:?}");
}
}

classic_mods_page_toggles_mods_and_keeps_dev_and_invalid_entries_inactive :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: let size = (480.0, 240.0);
    // rust: assert!(ui.layout(&s, size.0, size.1).0.iter().any(|w| {
    // rust: matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::Push(Page::Mods),
    // rust: ..
}
    // rust: )
    // rust: }));
    // rust: ui.show(Page::Mods);
    // rust: let empty = ui.layout(&s, size.0, size.1).0;
    // rust: assert!(empty.iter().any(|w| {
    // rust: matches!(&w.kind, WKind::Text { text, .. } if text.plain() == "horizon.mods.empty")
    // rust: }));
        // The empty page points at the bundled key; the English line behind it
        // is what a player reads, so both halves are checked here.
    // rust: let en = crate::lang::Language::load(&[], "en_us");
    // rust: assert!(
    // rust: en.get("horizon.mods.empty")
    // rust: .is_some_and(|line| line.contains(".hmod"))
    // rust: );
    // rust: let open_folder = empty
    // rust: .iter()
    // rust: .find(|w| {
    // rust: matches!(
    // rust: &w.kind,
    // rust: WKind::Button {
    // rust: act: Act::OpenModFolder,
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .expect("Mods page has an Open Mod Folder button");
    // rust: assert_eq!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: open_folder.x + 1.0,
    // rust: open_folder.y + 1.0,
    // rust: size,
    // rust: [480, 240],
    // rust: false,
    // rust: false,
    // rust: ),
    // rust: vec![Event::ButtonClick, Event::OpenModFolder]
    // rust: );
    // rust: for (id, dev) in [("normal", false), ("dev", true), ("", false)] {
    // rust: s.mods.installed.push(crate::mod_list::Installed {
    // rust: id: id.into(),
    // rust: title: id.into(),
    // rust: description: "May show HUD panels.".into(),
    // rust: problem: id.is_empty().then(|| "Invalid package".into()),
    // rust: dev,
    // rust: native: None,
    // rust: });
}
    // rust: let (widgets, ..) = ui.layout(&s, size.0, size.1);
    // rust: let rows: Vec<_> = widgets
    // rust: .iter()
    // rust: .filter(|w| {
    // rust: matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::ToggleMod(_),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(rows.len(), 3);
    // rust: for (i, row) in rows.iter().enumerate() {
    // rust: let events = ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: row.x + 1.0,
    // rust: row.y + 1.0,
    // rust: size,
    // rust: [480, 240],
    // rust: false,
    // rust: false,
    // rust: );
    // rust: if i == 0 {
    // rust: assert!(events.contains(&Event::Changed));
    // rust: assert!(events.contains(&Event::ButtonClick));
    // rust: } else {
    // rust: assert!(events.is_empty());
}
}
    // rust: assert!(s.mods.is_on(0));
    // rust: assert!(s.mods.is_on(1));
    // rust: assert!(!s.mods.is_on(2));
    // rust: assert_eq!(s.mods.serialize(), "mod.normal:true\n");
    // rust: let row = rows[0];
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: row.x + 1.0,
    // rust: row.y + 1.0,
    // rust: size,
    // rust: [480, 240],
    // rust: false,
    // rust: false,
    // rust: );
    // rust: assert!(!s.mods.is_on(0));
    // rust: assert!(!ui.back(&mut s).contains(&Event::Close));
    // rust: assert_eq!(ui.page(), Page::Main);
}

opening_a_native_mods_page_asks_the_game_for_its_labels_again :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: let size = (480.0, 240.0);
    // rust: s.mods.installed.push(crate::mod_list::Installed {
    // rust: id: "native".into(),
    // rust: title: "Native 1.0".into(),
    // rust: description: String::new(),
    // rust: problem: None,
    // rust: dev: false,
    // rust: native: Some(crate::mod_list::NativePage {
    // rust: buttons: vec!["Setting".into()],
    // rust: ..Default::default()
    // rust: }),
    // rust: });
    // rust: ui.show(Page::Mods);
    // rust: let (widgets, ..) = ui.layout(&s, size.0, size.1);
    // rust: let settings = widgets
    // rust: .iter()
    // rust: .find(|w| {
    // rust: matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::ModSettings(0),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .expect("a native mod's row has a Settings button");
    // rust: let events = ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: settings.x + 1.0,
    // rust: settings.y + 1.0,
    // rust: size,
    // rust: [480, 240],
    // rust: false,
    // rust: false,
    // rust: );
        // Its labels were made with the list, maybe in another language.
    // rust: assert_eq!(events.last(), Some(&Event::NativeSettings(0)));
    // rust: assert_eq!(ui.page(), Page::NativeMod(0));
}

native_mod_without_settings_has_only_a_full_width_toggle :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: s.mods.installed.push(crate::mod_list::Installed {
    // rust: id: "no_settings".into(),
    // rust: title: "Native 1.0".into(),
    // rust: description: String::new(),
    // rust: problem: None,
    // rust: dev: false,
    // rust: native: Some(crate::mod_list::NativePage::default()),
    // rust: });
    // rust: ui.show(Page::Mods);
    // rust: let (widgets, ..) = ui.layout(&s, 480.0, 240.0);
    // rust: assert!(!widgets.iter().any(|w| matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::ModSettings(_),
    // rust: ..
}
    // rust: )));
    // rust: let toggle = widgets
    // rust: .iter()
    // rust: .find(|w| {
    // rust: matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::ToggleMod(0),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(toggle.w, 310.0);
    // rust: let events = ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: toggle.x + 1.0,
    // rust: toggle.y + 1.0,
    // rust: (480.0, 240.0),
    // rust: [480, 240],
    // rust: false,
    // rust: false,
    // rust: );
    // rust: assert!(events.contains(&Event::Changed));
    // rust: assert!(!s.mods.is_on(0));
    // rust: assert!(s.mods.disabled.contains("no_settings"));
}

a_native_mods_key_shows_and_keeps_the_key_pressed :: proc() {
}
        // #3539: Zoom's key set to R showed another key.
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: let size = (480.0, 240.0);
    // rust: s.mods.installed.push(crate::mod_list::Installed {
    // rust: id: "zoom".into(),
    // rust: title: "Zoom 2.0.0".into(),
    // rust: description: String::new(),
    // rust: problem: None,
    // rust: dev: false,
    // rust: native: Some(crate::mod_list::NativePage {
    // rust: keys: vec![["zoom".into(), "Zoom key".into(), "key.keyboard.z".into()]],
    // rust: buttons: Vec::new(),
    // rust: }),
    // rust: });
    // rust: ui.show(Page::NativeMod(0));
    // rust: let key_label = |ui: &mut OptionsUi, s: &Settings| {
    // rust: let (widgets, ..) = ui.layout(s, size.0, size.1);
    // rust: widgets.into_iter().find_map(|w| match w.kind {
    // rust: WKind::Button {
    // rust: label,
    // rust: act: Act::NativeKey(0, 0),
    // rust: ..
    // rust: } => Some((label.plain(), w.x, w.y)),
    // rust: _ => None,
    // rust: })
}
    // rust: let (label, x, y) = key_label(&mut ui, &s).expect("the key's row");
    // rust: assert_eq!(label, "Z");
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: x + 1.0,
    // rust: y + 1.0,
    // rust: size,
    // rust: [480, 240],
    // rust: false,
    // rust: false,
    // rust: );
    // rust: assert_eq!(
    // rust: ui.key(&mut s, &atlas, winit::keyboard::KeyCode::KeyR, Some("r")),
    // rust: vec![Event::Changed]
    // rust: );
    // rust: assert_eq!(key_label(&mut ui, &s).unwrap().0, "R");
    // rust: let saved = crate::mod_list::ModList::parse(&s.mods.serialize());
    // rust: assert_eq!(saved.keys_of("zoom"), vec![("zoom", "key.keyboard.r")]);
}

mode :: proc(width: i32, rate: f32) -> c {
    // Ported from Horizon
    return {}
}
    // rust: crate::window::VideoMode {
    // rust: width,
    // rust: height: width * 9 / 16,
    // rust: red_bits: 8,
    // rust: green_bits: 8,
    // rust: blue_bits: 8,
    // rust: refresh_rate: rate,
}
}

video_page_lists_vanilla_display_and_quality_options_in_order :: proc() {
}
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Video);
    // rust: let rows = ui.list_rows(&Settings::default());
    // rust: let opts: Vec<Opt> = rows
    // rust: .iter()
    // rust: .flat_map(|r| match r {
    // rust: Row::Big(o) => vec![*o],
    // rust: Row::Pair(a, b) => std::iter::once(*a).chain(*b).collect(),
    // rust: _ => Vec::new(),
    // rust: })
    // rust: .collect();
        // VideoSettingsScreen.addOptions: the exclusive mode row, displayOptions, the preset,
        // qualityOptions, then the preferences.
    // rust: assert_eq!(
    // rust: opts[..9],
    // rust: [
    // rust: Opt::ExclusiveMode,
    // rust: Opt::MaxFps,
    // rust: Opt::Vsync,
    // rust: Opt::InactivityFps,
    // rust: Opt::GuiScale,
    // rust: Opt::Fullscreen,
    // rust: Opt::ExclusiveFullscreen,
    // rust: Opt::Gamma,
    // rust: Opt::GraphicsBackend,
    // rust: ]
    // rust: );
    // rust: let at = |o| opts.iter().position(|x| *x == o).unwrap();
    // rust: assert_eq!(at(Opt::ImprovedTransparency) + 1, at(Opt::TextureFiltering));
    // rust: assert_eq!(at(Opt::TextureFiltering) + 1, at(Opt::MaxAnisotropy));
    // rust: assert_eq!(at(Opt::MaxAnisotropy) + 1, at(Opt::WeatherRadius));
}

exclusive_fullscreen_mode_picks_a_monitor_mode_or_the_current_one :: proc() {
}
    // rust: let mut s = Settings::default();
        // No monitor mode: the slider changes nothing.
    // rust: Opt::ExclusiveMode.set_slider(&mut s, 1.0);
    // rust: assert_eq!(s.file.fullscreen_resolution, None);
    // rust: s.video_modes = vec![mode(1280, 60.0), mode(1920, 144.0), mode(2560, 59.94)];
    // rust: assert_eq!(s.video_mode_index(), -1);
        // IntRange(-1, 2): the slider's thirds are -1, 0, 1, 2.
    // rust: Opt::ExclusiveMode.set_slider(&mut s, 2.0 / 3.0);
    // rust: assert_eq!(s.video_mode_index(), 1);
    // rust: assert_eq!(Opt::ExclusiveMode.slider_position(&s), Some(2.0 / 3.0));
    // rust: Opt::ExclusiveMode.set_slider(&mut s, 1.0);
    // rust: assert_eq!(s.video_mode_index(), 2);
    // rust: Opt::ExclusiveMode.set_slider(&mut s, 0.0);
    // rust: assert_eq!(s.file.fullscreen_resolution, None);
}

a_clicked_extras_tooltip_leaves_with_the_pointer :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Extras);
    // rust: let (widgets, _, _, _) = ui.layout(&s, 480.0, 480.0);
    // rust: let extra = widgets
    // rust: .iter()
    // rust: .find(|w| {
    // rust: matches!(
    // rust: &w.kind,
    // rust: WKind::Button {
    // rust: act: Act::Extra(item),
    // rust: ..
    // rust: } if !matches!(item, crate::extras::Item::SortKey)
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: extra.x + 1.0,
    // rust: extra.y + 1.0,
    // rust: (480.0, 480.0),
    // rust: [960, 540],
    // rust: false,
    // rust: false,
    // rust: );
        // The pointer is still on the clicked widget: it carries the
        // description (`setTooltip`, drawn while hovered).
    // rust: let mut on = HudBatch::new([480, 480]);
    // rust: ui.draw(
    // rust: &s,
    // rust: &mut on,
    // rust: &atlas,
    // rust: (extra.x + extra.w / 2.0, extra.y + extra.h / 2.0),
    // rust: );
        // The pointer moved off: the description goes with it. A mouse
        // focus a click left behind (the look-up keeps the click's widget,
        // `focus_from_keyboard` false) does not keep the tooltip against
        // the widget, like vanilla's `MenuTooltipPositioner` does for a
        // keyboard focus.
    // rust: let mut off = HudBatch::new([480, 480]);
    // rust: ui.draw(
    // rust: &s,
    // rust: &mut off,
    // rust: &atlas,
    // rust: (extra.x + extra.w + 40.0, extra.y + extra.h + 40.0),
    // rust: );
    // rust: assert!(
    // rust: off.vertices.len() < on.vertices.len(),
    // rust: "a click left {} tooltip vertices behind when the pointer left ({} vs {})",
    // rust: on.vertices.len() - off.vertices.len(),
    // rust: on.vertices.len(),
    // rust: off.vertices.len(),
    // rust: );
}

exclusive_fullscreen_and_its_tooltips_follow_the_option :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: assert!(!s.file.bool("exclusiveFullscreen"));
    // rust: assert_eq!(
    // rust: Opt::ExclusiveFullscreen.tooltip_key(&s),
    // rust: "options.exclusiveFullscreen.off.tooltip"
    // rust: );
    // rust: Opt::ExclusiveFullscreen.cycle(&mut s, false, [854, 480]);
    // rust: assert!(s.file.bool("exclusiveFullscreen"));
    // rust: assert_eq!(
    // rust: Opt::ExclusiveFullscreen.tooltip_key(&s),
    // rust: "options.exclusiveFullscreen.on.tooltip"
    // rust: );
        // The mode row's own tooltip says it only matters with Exclusive Fullscreen.
    // rust: assert_eq!(
    // rust: Opt::ExclusiveMode.tooltip_key(&s),
    // rust: "options.fullscreen.exclusive.mode.tooltip"
    // rust: );
}

the_graphics_api_option_cycles_default_opengl_vulkan_and_asks_for_a_restart :: proc() {
}
//         use crate::graphics::GraphicsApi;
    // rust: let mut s = Settings::default();
    // rust: s.startup_api = s.horizon.api;
    // rust: let offered = GraphicsApi::choices();
    // rust: let mut seen = vec![s.horizon.api];
    // rust: for _ in 1..offered.len() {
    // rust: Opt::GraphicsBackend.cycle(&mut s, false, [854, 480]);
    // rust: seen.push(s.horizon.api);
}
        // Dx12 is Horizon's own Graphics page's; this option has the three of vanilla.
    // rust: assert!(!seen.contains(&GraphicsApi::Dx12));
    // rust: assert_eq!(seen[0], GraphicsApi::Auto);
    // rust: if offered.len() == 3 {
    // rust: assert_eq!(seen[1..], [GraphicsApi::OpenGl, GraphicsApi::Vulkan]);
    // rust: assert_eq!(s.file.name("preferredGraphicsBackend"), "vulkan");
    // rust: Opt::GraphicsBackend.cycle(&mut s, false, [854, 480]);
    // rust: assert_eq!(s.horizon.api, GraphicsApi::Auto);
    // rust: assert_eq!(s.file.name("preferredGraphicsBackend"), "default");
}
}

texture_filtering_rows_exist_and_the_presets_set_them :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: for (preset, bit, filtering) in [("fast", 1, 0), ("fancy", 1, 1), ("fabulous", 2, 2)] {
    // rust: s.graphics_preset = preset.into();
    // rust: apply_preset(&mut s);
    // rust: assert_eq!(s.file.int("maxAnisotropyBit"), bit, "{preset}");
    // rust: assert_eq!(s.file.int("textureFiltering"), filtering, "{preset}");
}
    // rust: assert!(Opt::TextureFiltering.available());
    // rust: assert!(Opt::MaxAnisotropy.available());
        // The anisotropy slider only works with Anisotropic filtering (VideoSettingsScreen.tick).
    // rust: let grey = |s: &Settings| {
    // rust: matches!(
    // rust: option_widget(s, Opt::MaxAnisotropy, 0.0, 0.0, 150.0).kind,
    // rust: WKind::Button { active: false, .. }
    // rust: )
}
    // rust: s.file
    // rust: .set("textureFiltering", crate::options_file::V::Int(1));
    // rust: assert!(grey(&s));
    // rust: s.file
    // rust: .set("textureFiltering", crate::options_file::V::Int(2));
    // rust: assert!(!grey(&s));
}

the_new_video_options_read_as_vanilla_words_them :: proc() {
}
//         use crate::graphics::GraphicsApi;
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES"),
    // rust: );
    // rust: lang::set(lang::Language::load(&[&root], "en_us"));
    // rust: let mut s = Settings::default();
    // rust: assert_eq!(Opt::ExclusiveMode.label(&s).plain(), "Setting unavailable");
    // rust: s.video_modes = vec![mode(1280, 60.0), mode(1920, 144.0), mode(2560, 59.94)];
    // rust: assert_eq!(
    // rust: Opt::ExclusiveMode.label(&s).plain(),
    // rust: "Exclusive Fullscreen Mode: Current"
    // rust: );
    // rust: Opt::ExclusiveMode.set_slider(&mut s, 2.0 / 3.0);
    // rust: assert_eq!(
    // rust: Opt::ExclusiveMode.label(&s).plain(),
    // rust: "Exclusive Fullscreen Mode: 1920x1080@144 (24bit)"
    // rust: );
    // rust: Opt::ExclusiveMode.set_slider(&mut s, 1.0);
    // rust: assert_eq!(
    // rust: Opt::ExclusiveMode.label(&s).plain(),
    // rust: "Exclusive Fullscreen Mode: 2560x1440@59.94 (24bit)"
    // rust: );
    // rust: s.horizon.api = GraphicsApi::Vulkan;
    // rust: assert_eq!(
    // rust: Opt::GraphicsBackend.label(&s).plain(),
    // rust: "Graphics API: Prefer Vulkan (Experimental)"
    // rust: );
    // rust: assert!(
    // rust: graphics_api_tooltip(&s)
    // rust: .plain()
    // rust: .starts_with("Requires a game restart to take effect.\n\n")
    // rust: );
    // rust: s.startup_api = GraphicsApi::Vulkan;
    // rust: assert!(
    // rust: graphics_api_tooltip(&s)
    // rust: .plain()
    // rust: .starts_with("Which graphics API")
    // rust: );
    // rust: s.file
    // rust: .set("maxAnisotropyBit", crate::options_file::V::Int(2));
    // rust: s.file
    // rust: .set("textureFiltering", crate::options_file::V::Int(2));
    // rust: assert_eq!(
    // rust: Opt::MaxAnisotropy.label(&s).plain(),
    // rust: "Anisotropic Filtering: 4x"
    // rust: );
    // rust: assert_eq!(
    // rust: Opt::TextureFiltering.label(&s).plain(),
    // rust: "Texture Filtering: Anisotropic"
    // rust: );
}

option_tooltip_keys_follow_value_dependent_descriptions :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: assert_eq!(
    // rust: Opt::InactivityFps.tooltip_key(&s),
    // rust: "options.inactivityFpsLimit.afk.tooltip"
    // rust: );
    // rust: s.inactivity_fps_limit = "minimized".into();
    // rust: assert_eq!(
    // rust: Opt::InactivityFps.tooltip_key(&s),
    // rust: "options.inactivityFpsLimit.minimized.tooltip"
    // rust: );
    // rust: for (value, name) in ["none", "byPlayer", "nearby"].iter().enumerate() {
    // rust: s.prioritize_chunk_updates = value as u8;
    // rust: assert_eq!(
    // rust: Opt::ChunkBuilder.tooltip_key(&s),
    // rust: format!("options.prioritizeChunkUpdates.{name}.tooltip")
    // rust: );
}
    // rust: assert_eq!(
    // rust: Opt::MenuBlur.tooltip_key(&s),
    // rust: "options.accessibility.menu_background_blurriness.tooltip"
    // rust: );
}

classic_hover_draws_the_selected_options_wrapped_tooltip :: proc() {
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES"),
    // rust: );
    // rust: lang::set(lang::Language::load(&[&root], "en_us"));
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Video);
    // rust: for mode in ["afk", "minimized"] {
    // rust: s.inactivity_fps_limit = mode.into();
    // rust: let (widgets, _, _, _) = ui.layout(&s, 480.0, 480.0);
    // rust: let option = widgets
    // rust: .iter()
    // rust: .find(|w| {
    // rust: matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::Cycle(Opt::InactivityFps),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: let cursor = (option.x + 1.0, option.y + 1.0);
    // rust: let mut actual = HudBatch::new([480, 480]);
    // rust: ui.draw(&s, &mut actual, &atlas, cursor);
    // rust: let key = format!("options.inactivityFpsLimit.{mode}.tooltip");
    // rust: assert!(lang::has(&key));
    // rust: let mut expected = HudBatch::new([480, 480]);
    // rust: ui::tooltip(
    // rust: &mut expected,
    // rust: &atlas,
    // rust: &atlas.font.split(&tr(&key), 170.0),
    // rust: cursor,
    // rust: );
    // rust: assert!(!expected.vertices.is_empty());
    // rust: let tail = &actual.vertices[actual.vertices.len() - expected.vertices.len()..];
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(tail),
    // rust: bytemuck::cast_slice::<_, u8>(&expected.vertices)
    // rust: );
}
}

classic_video_search_keeps_only_headings_with_matching_options :: proc() {
}
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Video);
    // rust: let settings = Settings::default();
    // rust: let headers = |rows: Vec<Row>| {
    // rust: rows.into_iter()
    // rust: .filter_map(|row| match row {
    // rust: Row::Header(key) => Some(key),
    // rust: _ => None,
    // rust: })
    // rust: .collect::<Vec<_>>()
}
    // rust: let all_headers = vec![
    // rust: "options.video.display.header",
    // rust: "options.video.quality.header",
    // rust: "options.video.preferences.header",
    // rust: ];
    // rust: assert_eq!(headers(ui.list_rows(&settings)), all_headers);
    // rust: for (opt, header) in [
    // rust: (Opt::Fullscreen, all_headers[0]),
    // rust: (Opt::RenderDistance, all_headers[1]),
    // rust: (Opt::Preset, all_headers[1]),
    // rust: (Opt::Autosave, all_headers[2]),
    // rust: ] {
    // rust: ui.settings_search
    // rust: .set_value(&lang::get(opt.caption()).to_uppercase());
    // rust: let rows = ui.list_rows(&settings);
    // rust: assert_eq!(headers(ui.list_rows(&settings)), vec![header]);
    // rust: assert!(rows.iter().any(|row| match row {
    // rust: Row::Big(found) => *found == opt,
    // rust: Row::Pair(a, b) => *a == opt || *b == Some(opt),
    // rust: _ => false,
    // rust: }));
}
    // rust: ui.settings_search.set_value("no matching video setting");
    // rust: let rows = ui.list_rows(&settings);
    // rust: assert!(headers(ui.list_rows(&settings)).is_empty());
    // rust: assert!(rows.is_empty(), "{}", rows.len());
    // rust: ui.settings_search.set_value("");
    // rust: assert_eq!(headers(ui.list_rows(&settings)), all_headers);
}

classic_search_emits_each_matching_heading_once_in_section_order :: proc() {
}
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.settings_search
    // rust: .set_value(&lang::get(Opt::Fullscreen.caption()));
    // rust: let rows = ui.filter_option_rows(vec![
    // rust: Row::Header("empty"),
    // rust: Row::Header("display"),
    // rust: Row::Pair(Opt::Fullscreen, Some(Opt::Fullscreen)),
    // rust: Row::Big(Opt::Fullscreen),
    // rust: Row::Header("quality"),
    // rust: Row::Big(Opt::Fullscreen),
    // rust: Row::Header("trailing empty"),
    // rust: ]);
    // rust: assert!(matches!(
    // rust: rows.as_slice(),
    // rust: [
    // rust: Row::Header("display"),
    // rust: Row::Pair(Opt::Fullscreen, Some(Opt::Fullscreen)),
    // rust: Row::Big(Opt::Fullscreen),
    // rust: Row::Header("quality"),
    // rust: Row::Big(Opt::Fullscreen),
    // rust: ]
    // rust: ));
}

classic_video_gui_scale_cycles_on_press_without_dragging :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Video);
    // rust: let size = (480.0, 480.0);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let button = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::Cycle(Opt::GuiScale),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .expect("GUI Scale must be a cycle button in classic Video Settings");
    // rust: let (x, y) = (button.x + 1.0, button.y + 1.0);
    // rust: assert!(Opt::GuiScale.slider_position(&s).is_none());
    // rust: assert!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, true)
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(s.gui_scale, 0);
    // rust: for expected in [1, 2, 0] {
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert_eq!(s.gui_scale, expected);
    // rust: assert!(
    // rust: ui.click(&mut s, &atlas, x + 100.0, y, size, [854, 480], true, false)
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(s.gui_scale, expected);
    // rust: assert!(ui.release().is_empty());
}
}

extras_from_horizon_settings_edit_shared_settings_and_return :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: let size = (480.0, 480.0);
    // rust: let click = |ui: &mut OptionsUi, s: &mut Settings, act: Act| {
    // rust: let (widgets, _, _, _) = ui.layout(s, size.0, size.1);
    // rust: let widget = widgets
    // rust: .iter()
    // rust: .find(
    // rust: |w| matches!(&w.kind, WKind::Button { act: a, active: true, .. } if *a == act),
    // rust: )
    // rust: .unwrap();
    // rust: ui.click(
    // rust: s,
    // rust: &atlas,
    // rust: widget.x + 1.0,
    // rust: widget.y + 1.0,
    // rust: size,
    // rust: [960, 960],
    // rust: false,
    // rust: false,
    // rust: )
}
    // rust: for page in [Page::Horizon, Page::Extras] {
    // rust: assert_eq!(
    // rust: click(&mut ui, &mut s, Act::Push(page)),
    // rust: vec![Event::ButtonClick]
    // rust: );
    // rust: assert_eq!(ui.page(), page);
}
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: assert_eq!(
    // rust: widgets
    // rust: .iter()
    // rust: .filter(|w| matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::Extra(_),
    // rust: ..
}
    // rust: ))
    // rust: .count(),
    // rust: crate::extras::rows().iter().filter(|r| r.is_ok()).count()
    // rust: );
    // rust: assert_eq!(
    // rust: click(&mut ui, &mut s, Act::Extra(crate::extras::Item::Sort)),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert!(s.extras.sort);
    // rust: assert_eq!(
    // rust: click(&mut ui, &mut s, Act::Extra(crate::extras::Item::Pregen)),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert!(s.extras.pregen);
    // rust: assert_eq!(
    // rust: click(&mut ui, &mut s, Act::Extra(crate::extras::Item::SortKey)),
    // rust: vec![Event::ButtonClick]
    // rust: );
    // rust: assert_eq!(ui.selected_key, Some(crate::extras::SORT_KEY));
    // rust: assert_eq!(
    // rust: ui.key(&mut s, &atlas, winit::keyboard::KeyCode::KeyC, None),
    // rust: vec![Event::Changed]
    // rust: );
    // rust: assert_eq!(s.extras.sort_key, "key.keyboard.c");
    // rust: assert_eq!(
    // rust: crate::extras::Extras::parse(&s.extras.serialize()),
    // rust: s.extras
    // rust: );
        // In a window too short for the page, the wheel scrolls to its end.
    // rust: let short = (480.0, 180.0);
    // rust: ui.scroll(&s, short, -1000.0);
    // rust: let (_, top, bottom, content) = ui.layout(&s, short.0, short.1);
    // rust: assert!(content > bottom - top);
    // rust: assert_eq!(ui.scroll, content - (bottom - top));
    // rust: assert_eq!(
    // rust: ui.key(&mut s, &atlas, winit::keyboard::KeyCode::Escape, None),
    // rust: vec![Event::Changed]
    // rust: );
    // rust: assert_eq!(ui.page(), Page::Horizon);
}

classic_graphics_presets_set_the_distances :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Video);
    // rust: let size = (480.0, 480.0);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let preset = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Slider {
    // rust: opt: Opt::Preset,
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .expect("the Graphics preset slider is in classic Video Settings");
        // Dragging the slider across its range (GraphicsPreset.apply on each change).
    // rust: let y = preset.y + 1.0;
    // rust: let mut seen = Vec::new();
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: preset.x + 1.0,
    // rust: y,
    // rust: size,
    // rust: [854, 480],
    // rust: false,
    // rust: false,
    // rust: );
    // rust: for step in 0..=20 {
    // rust: let x = preset.x + preset.w * step as f32 / 20.0;
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], true, false);
    // rust: seen.push((
    // rust: s.graphics_preset.clone(),
    // rust: s.render_distance,
    // rust: s.simulation_distance,
    // rust: s.cloud_range,
    // rust: ));
}
    // rust: ui.release();
    // rust: for expected in [
    // rust: ("fast", 8, 6, 32),
    // rust: ("fancy", 16, 12, 64),
    // rust: ("fabulous", 32, 12, 128),
    // rust: ] {
    // rust: assert!(
    // rust: seen.iter()
    // rust: .any(|(p, r, d, c)| (p.as_str(), *r, *d, *c) == expected),
    // rust: "{expected:?} in {seen:?}"
    // rust: );
}
}

gui_scale_cycle_handles_reverse_and_out_of_range_saved_values :: proc() {
}
    // rust: for (framebuffer, force_unicode, max) in [
    // rust: ([854, 480], false, 2),
    // rust: ([1920, 1080], false, 4),
    // rust: ([1280, 720], true, 4),
    // rust: ([3840, 2160], false, 9),
    // rust: ([320, 240], false, 1),
    // rust: ] {
    // rust: let mut s = Settings {
    // rust: force_unicode,
    // rust: ..Settings::default()
}
    // rust: for expected in (0..=max).rev() {
    // rust: Opt::GuiScale.cycle(&mut s, true, framebuffer);
    // rust: assert_eq!(s.gui_scale, expected);
}
    // rust: for expected in (1..=max).chain([0]) {
    // rust: Opt::GuiScale.cycle(&mut s, false, framebuffer);
    // rust: assert_eq!(s.gui_scale, expected);
}
    // rust: s.gui_scale = u32::MAX;
    // rust: Opt::GuiScale.cycle(&mut s, false, framebuffer);
    // rust: assert_eq!(s.gui_scale, 0);
    // rust: s.gui_scale = u32::MAX;
    // rust: Opt::GuiScale.cycle(&mut s, true, framebuffer);
    // rust: assert_eq!(s.gui_scale, max - 1);
}
    // rust: let mut s = Settings {
    // rust: gui_scale: 4,
    // rust: ..Settings::default()
}
        // A resized window supplies a new maximum on the next interaction.
    // rust: Opt::GuiScale.cycle(&mut s, true, [854, 480]);
    // rust: assert_eq!(s.gui_scale, 1);
}

classic_buttons_sound_but_disabled_and_nonprimary_clicks_are_silent :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Mouse);
    // rust: let size = (480.0, 320.0);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let button = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::Cycle(_),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: let (x, y) = (button.x + 1.0, button.y + 1.0);
    // rust: assert!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, true)
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert!(ui.release().is_empty());
    // rust: assert!(
    // rust: ui.click(&mut s, &atlas, 0.0, 0.0, size, [854, 480], false, false)
    // rust: .is_empty()
    // rust: );
    // rust: ui.show(Page::KeyBinds);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let disabled = widgets
    // rust: .iter()
    // rust: .find(|wd| matches!(wd.kind, WKind::Button { active: false, .. }))
    // rust: .unwrap();
    // rust: assert!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: disabled.x + 1.0,
    // rust: disabled.y + 1.0,
    // rust: size,
    // rust: [854, 480],
    // rust: false,
    // rust: false
    // rust: )
    // rust: .is_empty()
    // rust: );
}

classic_sliders_sound_once_on_release_including_unchanged_values :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let size = (480.0, 320.0);
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Sound);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let slider = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Slider {
    // rust: opt: Opt::Volume(0),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: let (x, y) = (slider.x + slider.w - 1.0, slider.y + 1.0);
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::SliderDrag]
    // rust: );
    // rust: assert_eq!(s.master_volume, 1.0);
    // rust: assert_eq!(ui.release(), vec![Event::ButtonClick, Event::Changed]);
    // rust: assert!(ui.release().is_empty());
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::SliderDrag]
    // rust: );
    // rust: for cx in [-100.0, 250.0, 1000.0] {
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, cx, -100.0, size, [854, 480], true, false),
    // rust: vec![Event::SliderDrag, Event::Volume(0, s.master_volume)]
    // rust: );
}
    // rust: assert_eq!(ui.release(), vec![Event::ButtonClick, Event::Changed]);
    // rust: assert!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], true, false)
    // rust: .is_empty()
    // rust: );
}

a_moved_volume_slider_reports_its_category_and_value :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let size = (480.0, 320.0);
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Sound);
    // rust: let hostile = SOUND_SOURCES.iter().position(|n| *n == "hostile").unwrap();
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let slider = widgets
    // rust: .iter()
    // rust: .find(|wd| matches!(wd.kind, WKind::Slider { opt: Opt::Volume(i), .. } if i == hostile))
    // rust: .unwrap();
    // rust: let y = slider.y + 1.0;
    // rust: let x = slider.x + 4.0 + (slider.w - 8.0) * 0.5;
    // rust: let events = ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: let volume = s.volumes[hostile];
    // rust: assert!((volume - 0.5).abs() < 1e-3, "{volume}");
    // rust: assert_eq!(
    // rust: events,
    // rust: vec![Event::SliderDrag, Event::Volume(hostile, volume)]
    // rust: );
        // OptionInstance.set: an unchanged value runs no callback.
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, -50.0, size, [854, 480], true, false),
    // rust: vec![Event::SliderDrag]
    // rust: );
}

classic_sliders_follow_the_pointer_and_snap_on_release :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let size = (480.0, 320.0);
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Sound);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let slider = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Slider {
    // rust: opt: Opt::Volume(0),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: let (x, y) = (slider.x + 4.0 + (slider.w - 8.0) * 0.3, slider.y + 1.0);
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: let raw = ui::slider_value(slider.x, slider.w, x);
        // Held: the handle stays under the pointer whatever the stepped value.
    // rust: assert_eq!(ui.slider_shown(Opt::Volume(0), 0.25), raw);
    // rust: assert_eq!(ui.slider_shown(Opt::Volume(1), 0.25), 0.25);
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: x + 10.0,
    // rust: -50.0,
    // rust: size,
    // rust: [854, 480],
    // rust: true,
    // rust: false,
    // rust: );
    // rust: let raw = ui::slider_value(slider.x, slider.w, x + 10.0);
    // rust: assert_eq!(ui.slider_shown(Opt::Volume(0), 0.25), raw);
    // rust: ui.release();
    // rust: assert_eq!(ui.slider_shown(Opt::Volume(0), 0.25), 0.25);
        // Render distance applies late (applyValueImmediately = false) and
        // keeps its position until then, even once released.
    // rust: ui.slider_value = Some((Opt::RenderDistance, 0.51, Instant::now()));
    // rust: assert_eq!(ui.slider_shown(Opt::RenderDistance, 0.5), 0.51);
    // rust: ui.slider_value = Some((
    // rust: Opt::RenderDistance,
    // rust: 0.51,
    // rust: Instant::now() - std::time::Duration::from_millis(600),
    // rust: ));
    // rust: assert_eq!(ui.slider_shown(Opt::RenderDistance, 0.5), 0.5);
}

classic_language_rows_and_text_fields_are_silent :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi {
    // rust: languages: languages(),
    // rust: ..Default::default()
}
    // rust: ui.show(Page::Language);
    // rust: let size = (480.0, 320.0);
    // rust: let (widgets, top, bottom, _) = ui.layout(&s, size.0, size.1);
    // rust: let row = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(wd.kind, WKind::LanguageRow { .. }) && wd.y >= top && wd.y + wd.h <= bottom
    // rust: })
    // rust: .unwrap();
    // rust: assert!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: row.x + 1.0,
    // rust: row.y + 1.0,
    // rust: size,
    // rust: [854, 480],
    // rust: false,
    // rust: false
    // rust: )
    // rust: .is_empty()
    // rust: );
    // rust: assert!(ui.release().is_empty());
    // rust: let search = ui.language_search.clone();
    // rust: assert!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: search.x + 1.0,
    // rust: search.y + 1.0,
    // rust: size,
    // rust: [854, 480],
    // rust: false,
    // rust: false
    // rust: )
    // rust: .is_empty()
    // rust: );
}

    // `LanguageSelectionList.Entry.keyPressed`: the selection key picks the
    // row's language and finishes the screen in one press (`onDone`), so the
    // page is gone after Enter and the language is already applied.
the_selection_key_picks_a_language_and_finishes_the_page :: proc() {
}
//         use winit::keyboard::KeyCode;
    // rust: let atlas = atlas();
    // rust: let rows = languages();
    // rust: let code = {
    // rust: let s = Settings::default();
    // rust: let mut ui = OptionsUi {
    // rust: languages: rows.clone(),
    // rust: ..Default::default()
}
    // rust: ui.size = (480.0, 320.0);
    // rust: ui.show(Page::Language);
    // rust: let (widgets, ..) = ui.layout(&s, 480.0, 320.0);
    // rust: widgets
    // rust: .iter()
    // rust: .find_map(|wd| match &wd.kind {
    // rust: WKind::LanguageRow { code, .. } => Some(code.clone()),
    // rust: _ => None,
    // rust: })
    // rust: .expect("a language row")
}
    // rust: for key in [KeyCode::Enter, KeyCode::NumpadEnter, KeyCode::Space] {
    // rust: let mut s = Settings::default();
    // rust: assert_ne!(s.language, code, "the row starts unchosen");
    // rust: let mut ui = OptionsUi {
    // rust: languages: rows.clone(),
    // rust: ..Default::default()
}
    // rust: ui.size = (480.0, 320.0);
    // rust: ui.show(Page::Language);
    // rust: ui.focus = Some(FocusId::Lang(code.clone()));
    // rust: ui.focus_from_keyboard = true;
    // rust: let events = ui.key(&mut s, &atlas, key, None);
    // rust: assert_eq!(s.language, code, "{key:?} applies the row's language");
    // rust: assert!(events.contains(&Event::Language(code.clone())), "{key:?}");
    // rust: assert_eq!(ui.page(), Page::Main, "{key:?} finishes the language page");
}
}

language_search_hint_does_not_overlap_the_focused_caret :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let settings = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Language);
    // rust: let draw_hint = |ui: &mut OptionsUi| {
    // rust: let mut batch = HudBatch::new([960, 640]);
    // rust: ui.draw(&settings, &mut batch, &atlas, (-1.0, -1.0));
    // rust: let search = &ui.language_search;
    // rust: batch.vertices.iter().any(|v| {
    // rust: v.color == rgba(170, 170, 170, 255)
    // rust: && v.pos[0] >= search.text_x()
    // rust: && v.pos[0] < search.x + search.width
    // rust: && v.pos[1] >= search.text_y()
    // rust: && v.pos[1] < search.y + search.height
    // rust: })
}
    // rust: ui.language_search.focused = false;
    // rust: assert!(draw_hint(&mut ui));
    // rust: ui.language_search.focused = true;
    // rust: assert!(!draw_hint(&mut ui));
    // rust: ui.language_search.focused = false;
    // rust: ui.language_search.set_value("english");
    // rust: assert!(!draw_hint(&mut ui));
    // rust: ui.language_search.set_value("");
    // rust: assert!(draw_hint(&mut ui));
}

languages :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..30)
    // rust: .map(|i| LanguageInfo {
    // rust: code: format!("language_{i}"),
    // rust: name: format!("Language {i}"),
    // rust: region: String::new(),
    // rust: bidirectional: false,
    // rust: })
    // rust: .collect()
}

classic_scroll_stops_at_both_limits_before_layout :: proc() {
}
    // rust: let s = Settings::default();
    // rust: let size = (480.0, 120.0);
    // rust: for page in [Page::KeyBinds, Page::Chat, Page::Sound, Page::Language] {
    // rust: let mut ui = OptionsUi {
    // rust: languages: languages(),
    // rust: ..Default::default()
}
    // rust: ui.show(page);
    // rust: let (_, top, bottom, content) = ui.layout(&s, size.0, size.1);
    // rust: let max = content - (bottom - top);
    // rust: assert!(max > 4.5, "{page:?}");
    // rust: for _ in 0..3 {
    // rust: ui.scroll_at(&s, size, (240.0, 60.0), 1000.0);
    // rust: assert_eq!(ui.scroll, 0.0, "{page:?}");
}
    // rust: for _ in 0..3 {
    // rust: ui.scroll_at(&s, size, (240.0, 60.0), -1000.0);
    // rust: assert_eq!(ui.scroll, max, "{page:?}");
}
    // rust: ui.scroll_at(&s, size, (240.0, 60.0), 0.25);
    // rust: assert_eq!(ui.scroll, max - 4.5, "{page:?}");
    // rust: ui.scroll_at(&s, size, (240.0, 60.0), 1000.0);
    // rust: ui.scroll_at(&s, size, (240.0, 60.0), -0.25);
    // rust: assert_eq!(ui.scroll, 4.5, "{page:?}");
}
}

partially_visible_keybind_rows_are_clipped_and_clickable :: proc() {
}
    // rust: let mut atlas = atlas();
    // rust: let button = crate::hud::Rect {
    // rust: u0: 0.25,
    // rust: v0: 0.25,
    // rust: u1: 0.5,
    // rust: v1: 0.5,
    // rust: w: 20,
    // rust: h: 20,
}
    // rust: for name in ["button", "button_disabled", "button_highlighted"] {
    // rust: atlas
    // rust: .sprites
    // rust: .insert(format!("gui/sprites/widget/{name}"), button);
}
    // rust: for above in [true, false] {
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::KeyBinds);
    // rust: let mut batch = HudBatch::new([480, 240]);
    // rust: let size = (batch.width, batch.height);
    // rust: let (widgets, top, bottom, _) = ui.layout(&s, size.0, size.1);
    // rust: let row = widgets
    // rust: .iter()
    // rust: .filter(|w| {
    // rust: matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::Key(_),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .nth(10)
    // rust: .unwrap();
    // rust: let WKind::Button {
    // rust: act: Act::Key(key), ..
    // rust: } = row.kind
    // rust: else {
    // rust: unreachable!()
}
    // rust: let row_y = if above { top - 5.0 } else { bottom - 16.0 };
    // rust: ui.scroll = row.y - row_y;
    // rust: let (x, width, height) = (row.x, row.w, row.h);
    // rust: ui.draw(&s, &mut batch, &atlas, (-1.0, -1.0));
    // rust: let vertices: Vec<_> = batch
    // rust: .vertices
    // rust: .iter()
    // rust: .filter(|v| {
    // rust: (0.25..=0.5).contains(&v.uv[0])
    // rust: && (0.25..=0.5).contains(&v.uv[1])
    // rust: && v.pos[0] >= x
    // rust: && v.pos[0] <= x + width
    // rust: && v.pos[1] >= row_y
    // rust: && v.pos[1] <= row_y + height
    // rust: })
    // rust: .collect();
    // rust: assert!(!vertices.is_empty());
    // rust: let lo = vertices
    // rust: .iter()
    // rust: .map(|v| v.pos[1])
    // rust: .fold(f32::INFINITY, f32::min);
    // rust: let hi = vertices
    // rust: .iter()
    // rust: .map(|v| v.pos[1])
    // rust: .fold(f32::NEG_INFINITY, f32::max);
    // rust: assert_eq!(lo, row_y.max(top));
    // rust: assert_eq!(hi, (row_y + height).min(bottom));
    // rust: let hidden_y = if above {
    // rust: row_y + 1.0
    // rust: } else {
    // rust: row_y + height - 1.0
}
    // rust: assert!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: x + 1.0,
    // rust: hidden_y,
    // rust: size,
    // rust: [480, 240],
    // rust: false,
    // rust: false
    // rust: )
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(ui.selected_key, None);
    // rust: assert_eq!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: x + 1.0,
    // rust: (lo + hi) / 2.0,
    // rust: size,
    // rust: [480, 240],
    // rust: false,
    // rust: false
    // rust: ),
    // rust: vec![Event::ButtonClick]
    // rust: );
    // rust: assert_eq!(ui.selected_key, Some(key));
}
}

classic_scrollbar_drag_is_bounded_silent_and_stops_on_release :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let size = (480.0, 160.0);
    // rust: for page in [Page::KeyBinds, Page::Language, Page::Chat] {
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi {
    // rust: languages: languages(),
    // rust: ..Default::default()
}
    // rust: ui.show(page);
    // rust: let (_, top, bottom, content) = ui.layout(&s, size.0, size.1);
    // rust: let max = content - (bottom - top);
    // rust: assert!(max > 0.0, "{page:?}");
    // rust: let x = ui.scrollbar_x(size.0) + 2.0;
    // rust: let (_, thumb) = ui::scrollbar_thumb(top, bottom, content, ui.scroll).unwrap();
    // rust: let y = top + thumb / 2.0;
    // rust: assert!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [960, 480], false, true)
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(ui.scrollbar_drag_y, None);
    // rust: assert!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [960, 480], false, false)
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(ui.scrollbar_drag_y, Some(y));
    // rust: let delta = 5.0;
    // rust: assert!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: x - 100.0,
    // rust: y + delta,
    // rust: size,
    // rust: [960, 480],
    // rust: true,
    // rust: false
    // rust: )
    // rust: .is_empty()
    // rust: );
    // rust: assert!((ui.scroll - delta * max / (bottom - top - thumb)).abs() < 0.001);
    // rust: for (y, expected) in [(bottom + 100.0, max), (top - 100.0, 0.0)] {
    // rust: assert!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [960, 480], true, false)
    // rust: .is_empty()
    // rust: );
    // rust: assert!((ui.scroll - expected).abs() < 0.001, "{page:?}");
}
    // rust: assert!(ui.release().is_empty());
    // rust: assert_eq!(ui.scrollbar_drag_y, None);
    // rust: assert!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: x,
    // rust: bottom + 100.0,
    // rust: size,
    // rust: [960, 480],
    // rust: true,
    // rust: false
    // rust: )
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(ui.scroll, 0.0);
    // rust: assert_eq!(s.keys, Settings::default().keys);
    // rust: ui.click(&mut s, &atlas, x, top + 1.0, size, [960, 480], false, false);
    // rust: assert!(ui.scrollbar_drag_y.is_some());
    // rust: ui.show(Page::Mouse);
    // rust: assert_eq!(ui.scrollbar_drag_y, None);
}
}

extras_and_vanilla_bindings_accept_mouse_buttons :: proc() {
}
//         use crate::extras::{Extras, SORT_KEY};
//         use winit::event::MouseButton;
    // rust: for button in [
    // rust: MouseButton::Left,
    // rust: MouseButton::Right,
    // rust: MouseButton::Middle,
    // rust: MouseButton::Back,
    // rust: MouseButton::Forward,
    // rust: ] {
    // rust: for name in [SORT_KEY, crate::graphics::HDR_KEY, "key.jump"] {
    // rust: let mut ui = OptionsUi::default();
    // rust: let mut s = Settings::default();
    // rust: ui.selected_key = Some(name);
    // rust: assert_eq!(ui.bind_mouse(&mut s, button), vec![Event::Changed]);
    // rust: assert_eq!(ui.selected_key, None);
    // rust: let value = keybinds::mouse_name(button);
    // rust: match name {
    // rust: SORT_KEY => assert_eq!(s.extras.sort_key, value),
    // rust: crate::graphics::HDR_KEY => assert_eq!(s.horizon.hdr_key, value),
    // rust: _ => assert_eq!(s.keys.get(name), value),
}
    // rust: assert_eq!(Extras::parse(&s.extras.serialize()), s.extras);
    // rust: if name != "key.jump" {
    // rust: assert_eq!(s.keys, Settings::default().keys);
}
    // rust: assert!(ui.bind_mouse(&mut s, button).is_empty());
}
}
}

horizon_extra_mouse_binding_consumes_the_click :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Extras);
    // rust: for (right, expected) in [(false, "key.mouse.left"), (true, "key.mouse.right")] {
    // rust: ui.selected_key = Some(crate::extras::SORT_KEY);
    // rust: assert_eq!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: 2.0,
    // rust: 2.0,
    // rust: (480.0, 240.0),
    // rust: [960, 480],
    // rust: false,
    // rust: right
    // rust: ),
    // rust: vec![Event::Changed]
    // rust: );
    // rust: assert_eq!(s.extras.sort_key, expected);
    // rust: assert_eq!(ui.selected_key, None);
    // rust: assert_eq!(ui.page(), Page::Extras);
}
}

key_rebinding_takes_precedence_over_scrollbar_dragging :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::KeyBinds);
    // rust: ui.selected_key = Some("key.jump");
    // rust: let x = ui.scrollbar_x(480.0) + 2.0;
    // rust: assert_eq!(
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: x,
    // rust: 50.0,
    // rust: (480.0, 240.0),
    // rust: [960, 480],
    // rust: false,
    // rust: false
    // rust: ),
    // rust: vec![Event::Changed]
    // rust: );
    // rust: assert_eq!(s.keys.get("key.jump"), "key.mouse.left");
    // rust: assert_eq!(ui.scrollbar_drag_y, None);
    // rust: assert!(ui.release().is_empty());
}

classic_pages_without_overflow_do_not_scroll :: proc() {
}
    // rust: let s = Settings::default();
    // rust: for page in [Page::Main, Page::Font, Page::Mouse] {
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(page);
    // rust: for amount in [-1000.0, 1000.0, -0.25] {
    // rust: ui.scroll(&s, (480.0, 720.0), amount);
    // rust: assert_eq!(ui.scroll, 0.0, "{page:?}");
}
}
}

classic_resize_positions_rows_at_the_clamped_offset :: proc() {
}
    // rust: let s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::KeyBinds);
    // rust: ui.scroll(&s, (480.0, 120.0), -1000.0);
    // rust: assert!(ui.scroll > 0.0);
    // rust: let (widgets, _, _, _) = ui.layout(&s, 480.0, 4000.0);
    // rust: assert_eq!(ui.scroll, 0.0);
    // rust: let (expected, _, _, _) = ui.layout(&s, 480.0, 4000.0);
    // rust: assert_eq!(
    // rust: widgets.iter().map(|w| w.y).collect::<Vec<_>>(),
    // rust: expected.iter().map(|w| w.y).collect::<Vec<_>>()
    // rust: );
}

language_centering_and_filtering_use_bounded_row_positions :: proc() {
}
    // rust: let s = Settings {
    // rust: language: "language_29".into(),
    // rust: ..Default::default()
}
    // rust: let mut ui = OptionsUi {
    // rust: languages: languages(),
    // rust: ..Default::default()
}
    // rust: ui.show(Page::Language);
    // rust: let (widgets, top, bottom, content) = ui.layout(&s, 480.0, 240.0);
    // rust: assert_eq!(ui.scroll, content - (bottom - top));
    // rust: let (expected, _, _, _) = ui.layout(&s, 480.0, 240.0);
    // rust: assert_eq!(
    // rust: widgets.iter().map(|w| w.y).collect::<Vec<_>>(),
    // rust: expected.iter().map(|w| w.y).collect::<Vec<_>>()
    // rust: );
    // rust: ui.language_search.set_value("language_29");
    // rust: let (widgets, top, _, _) = ui.layout(&s, 480.0, 240.0);
    // rust: assert_eq!(ui.scroll, 0.0);
    // rust: assert_eq!(widgets.iter().find(|w| w.list).unwrap().y, top + 2.0);
}

title_shortcuts_initialize_pages_and_return_directly_to_the_title :: proc() {
}
    // rust: let mut ui = OptionsUi::default();
    // rust: let mut s = Settings::default();
    // rust: for page in [Page::Accessibility, Page::Language] {
    // rust: ui.language_choice = Some("de_de".into());
    // rust: ui.language_search.set_value("old query");
    // rust: ui.open_at(false, page);
    // rust: assert_eq!(ui.page(), page);
    // rust: assert!(!ui.in_world);
    // rust: if page == Page::Language {
    // rust: assert_eq!(ui.language_choice, None);
    // rust: assert!(ui.language_search.value.is_empty());
    // rust: assert!(ui.center_language);
}
    // rust: assert!(ui.back(&mut s).contains(&Event::Close));
    // rust: assert_eq!(s.language, "en_us");
    // rust: ui.open(false);
    // rust: ui.show(page);
    // rust: assert!(!ui.back(&mut s).contains(&Event::Close));
    // rust: assert_eq!(ui.page(), Page::Main);
}
    // rust: ui.open_at(false, Page::Language);
    // rust: ui.language_choice = Some("de_de".into());
    // rust: let events = ui.back(&mut s);
    // rust: assert!(events.contains(&Event::Language("de_de".into())));
    // rust: assert!(events.contains(&Event::Close));
    // rust: assert_eq!(s.language, "de_de");
}

    // A content mod's set builds the block-state tables an open world's
    // chunks were decoded with, so its toggle freezes in-world; a native
    // mod gates live through `native_on` and one of assets and data reloads
    // live, so they stay available.
in_a_world_only_live_mod_toggles_stay_active :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let installed =
    // rust: |id: &str, native: Option<crate::mod_list::NativePage>| crate::mod_list::Installed {
    // rust: id: id.into(),
    // rust: title: id.into(),
    // rust: description: String::new(),
    // rust: problem: None,
    // rust: dev: false,
    // rust: native,
}
    // rust: s.mods.installed = vec![
    // rust: installed("content", None),
    // rust: installed("native", Some(crate::mod_list::NativePage::default())),
    // rust: ];
    // rust: let mut ui = OptionsUi::default();
    // rust: let toggles = |ui: &mut OptionsUi, s: &Settings| {
    // rust: let (widgets, ..) = ui.layout(s, 427.0, 240.0);
    // rust: widgets
    // rust: .iter()
    // rust: .filter_map(|w| match w.kind {
    // rust: WKind::Button {
    // rust: act: Act::ToggleMod(i),
    // rust: active,
    // rust: ..
    // rust: } => Some((i, active)),
    // rust: _ => None,
    // rust: })
    // rust: .collect::<Vec<_>>()
}
    // rust: ui.open_at(false, Page::Mods);
    // rust: assert_eq!(toggles(&mut ui, &s), [(0, true), (1, true)]);
    // rust: ui.open_at(true, Page::Mods);
    // rust: assert_eq!(toggles(&mut ui, &s), [(0, false), (1, true)]);
        // A content mod of assets and data only reloads live in a world this
        // game serves (`mods_live`, filled by the game).
    // rust: s.mods.installed.push(installed("data_only", None));
    // rust: ui.mods_live.insert("data_only".into());
    // rust: assert_eq!(toggles(&mut ui, &s), [(0, false), (1, true), (2, true)]);
}

    // An Extras or PvP & HUD label wider than half a row takes the whole row, so every label
    // fits its button: "Keep channels for UI sounds: Off" did not.
extras_labels_fit_their_buttons :: proc() {
}
        // Vanilla's font: 6 px a glyph, a few narrower ones.
    // rust: let width = |t: &str| {
    // rust: t.chars()
    // rust: .map(|c| match c {
    // rust: 'i' | '\'' | ':' | '.' | ',' | '!' => 2.0,
    // rust: 'l' => 3.0,
    // rust: ' ' | 't' | 'I' => 4.0,
    // rust: 'f' | 'k' => 5.0,
    // rust: _ => 6.0,
    // rust: })
    // rust: .sum::<f32>()
}
    // rust: let s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: for page in [Page::Extras, Page::Pvp] {
    // rust: ui.stack = vec![Page::Main, page];
    // rust: ui.wide_extras = wide_extras(&s, page, width);
    // rust: let rows = ui.list_rows(&s);
    // rust: let buttons: Vec<&Widget> = rows
    // rust: .iter()
    // rust: .flat_map(|r| match r {
    // rust: Row::Buttons(a, b) => std::iter::once(a).chain(b.as_ref()).collect(),
    // rust: _ => Vec::new(),
    // rust: })
    // rust: .collect();
    // rust: for b in &buttons {
    // rust: let WKind::Button { label, .. } = &b.kind else {
    // rust: continue;
}
    // rust: let label = label.plain();
    // rust: assert!(width(&label) <= b.w - 4.0, "{page:?}: {label} on {}", b.w);
}
            // Short ones keep vanilla's two to a row.
    // rust: assert!(buttons.iter().any(|b| b.w == 150.0), "{page:?}");
}
    // rust: ui.stack = vec![Page::Main, Page::Extras];
    // rust: ui.wide_extras = wide_extras(&s, Page::Extras, width);
    // rust: for item in [
    // rust: crate::extras::Item::UiSoundReserve,
    // rust: crate::extras::Item::WheelCyclesSettings,
    // rust: ] {
    // rust: assert!(ui.wide_extras.contains(&item), "{item:?}");
}
    // rust: assert!(!ui.wide_extras.contains(&crate::extras::Item::AutoReconnect));
}

    // Every setting a player reaches, from the Options screen through every button that opens
    // a page, is in one place, and every page has one way in. Vanilla's own repeats stay as
    // vanilla has them; the graphics screen stands for Video Settings, so the vanilla video
    // options it shows count as Video Settings' (Menu Background Blur is in both of
    // vanilla's). Vanilla's Video Settings rows are all on the graphics screen.
every_setting_and_page_is_reached_from_one_place :: proc() {
}
//         use std::collections::{BTreeMap, BTreeSet};
    // rust: let mut s = Settings::default();
        // The Music page shows once its extra is on.
    // rust: s.extras.music_page = true;
    // rust: let mut ui = OptionsUi::default();
    // rust: let mut places: BTreeMap<String, BTreeSet<String>> = BTreeMap::new();
    // rust: let mut ways_in: BTreeMap<String, BTreeSet<String>> = BTreeMap::new();
    // rust: let mut put = |id: String, page: &str| {
    // rust: places.entry(id).or_default().insert(page.to_owned());
}
        // The graphics screen, drawn by `graphics_ui`.
    // rust: let mut graphics_rows = BTreeSet::new();
    // rust: for (page, groups) in crate::graphics_ui::rows() {
    // rust: for row in groups.into_iter().flat_map(|(_, rows)| rows) {
//                 use crate::graphics_ui::{H, Item};
    // rust: let id = match row.item {
                    // Vanilla's Graphics API button sets the same setting.
    // rust: Item::Horizon(H::GraphicsApi) => "graphics-api".to_owned(),
    // rust: Item::Horizon(H::ShaderPacks) => {
    // rust: ways_in
    // rust: .entry(format!("{:?}", Page::ShaderPacks))
    // rust: .or_default()
    // rust: .insert(format!("Graphics/{page:?}"));
    // rust: continue;
}
    // rust: Item::Vanilla(o) => format!("{o:?}"),
    // rust: Item::Horizon(h) => format!("graphics:{h:?}"),
    // rust: Item::Extra(e) => format!("extra:{e:?}"),
}
    // rust: graphics_rows.insert(id.clone());
    // rust: put(id, "Graphics");
}
}
        // Every page from the Options screen, through its buttons.
    // rust: let mut seen = BTreeSet::new();
    // rust: let mut todo = vec![Page::Main];
    // rust: while let Some(page) = todo.pop() {
    // rust: if !seen.insert(format!("{page:?}")) {
    // rust: continue;
}
    // rust: ui.stack = vec![page];
    // rust: let (widgets, _, _, _) = ui.layout(&s, 427.0, 4000.0);
    // rust: let name = format!("{page:?}");
    // rust: for w in &widgets {
    // rust: let id = match &w.kind {
    // rust: WKind::Slider { opt, .. } => format!("{opt:?}"),
    // rust: WKind::Button { act, .. } => match act {
    // rust: Act::Cycle(Opt::GraphicsBackend) => "graphics-api".to_owned(),
    // rust: Act::Cycle(opt) => format!("{opt:?}"),
    // rust: Act::Extra(e) => format!("extra:{e:?}"),
    // rust: Act::PvpPreset => "pvp-preset".to_owned(),
    // rust: Act::Push(to) => {
    // rust: ways_in
    // rust: .entry(format!("{to:?}"))
    // rust: .or_default()
    // rust: .insert(name.clone());
                            // The graphics screen's pages are one screen, listed above.
    // rust: if OptionsUi::graphics_page(*to).is_none() {
    // rust: todo.push(*to);
}
    // rust: continue;
}
    // rust: _ => continue,
    // rust: },
    // rust: _ => continue,
}
    // rust: put(id, &name);
}
}
        // Vanilla's own: the same option on two of its screens.
    // rust: let vanilla_repeats: BTreeMap<&str, &[&str]> = [
    // rust: ("MenuBlur", &["Accessibility", "Graphics"][..]),
    // rust: ("ShowSubtitles", &["Accessibility", "Sound"][..]),
    // rust: ("Narrator", &["Accessibility", "Chat"][..]),
    // rust: ("ChatOpacity", &["Accessibility", "Chat"][..]),
    // rust: ("TextBackgroundOpacity", &["Accessibility", "Chat"][..]),
    // rust: ("ChatLineSpacing", &["Accessibility", "Chat"][..]),
    // rust: ]
    // rust: .into();
    // rust: for (id, pages) in &places {
    // rust: let pages: Vec<&str> = pages.iter().map(String::as_str).collect();
    // rust: match vanilla_repeats.get(id.as_str()) {
    // rust: Some(expected) => assert_eq!(&pages, expected, "{id}"),
    // rust: None => assert_eq!(pages.len(), 1, "{id} is on {pages:?}"),
}
}
        // AccessibilityOptionsScreen links Controls, as vanilla's does.
    // rust: for (page, from) in &ways_in {
    // rust: let from: Vec<&str> = from.iter().map(String::as_str).collect();
    // rust: match page.as_str() {
    // rust: "Controls" => assert_eq!(from, ["Accessibility", "Main"]),
    // rust: _ => assert_eq!(from.len(), 1, "{page} opens from {from:?}"),
}
}
    // rust: assert_eq!(
    // rust: ways_in.get("ShaderPacks").map(|f| f.len()),
    // rust: Some(1),
    // rust: "{ways_in:?}"
    // rust: );
    // rust: assert!(
    // rust: !seen.contains("Video"),
    // rust: "vanilla's own layout has no way in"
    // rust: );
        // Every row of vanilla's Video Settings is on the graphics screen.
    // rust: ui.stack = vec![Page::Video];
    // rust: for row in ui.list_rows(&s) {
    // rust: let opts = match row {
    // rust: Row::Big(o) => vec![o],
    // rust: Row::Pair(a, b) => std::iter::once(a).chain(b).collect(),
    // rust: _ => Vec::new(),
}
    // rust: for o in opts {
    // rust: let id = match o {
    // rust: Opt::GraphicsBackend => "graphics-api".to_owned(),
    // rust: o => format!("{o:?}"),
}
                // macOS has one graphics API: the graphics screen leaves the row out.
    // rust: if id == "graphics-api" && cfg!(target_os = "macos") {
    // rust: continue;
}
    // rust: assert!(
    // rust: graphics_rows.contains(&id),
    // rust: "{id} is not on the graphics screen"
    // rust: );
}
}
}

    // Shader packs, both kinds, are on the graphics screen's Shaders page: its Shader
    // Packs... opens the pack list, listed afresh, and Done comes back to that page.
the_graphics_shaders_page_opens_the_shader_pack_list :: proc() {
}
//         use crate::graphics_ui::{H, Item, Target};
//         use winit::keyboard::KeyCode;
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi {
    // rust: size: (427.0, 240.0),
    // rust: ..Default::default()
}
    // rust: ui.show(Page::Graphics);
    // rust: ui.graphics.open(crate::graphics_ui::Page::Shaders);
    // rust: let packs = Target::Item(Item::Horizon(H::ShaderPacks));
    // rust: assert!(
    // rust: (0..40).any(|_| {
    // rust: ui.key(&mut s, &atlas, KeyCode::Tab, None);
    // rust: ui.graphics.focus == Some(packs)
    // rust: }),
    // rust: "{:?}",
    // rust: ui.graphics.focus
    // rust: );
    // rust: let events = ui.key(&mut s, &atlas, KeyCode::Enter, None);
    // rust: assert_eq!(ui.page(), Page::ShaderPacks);
    // rust: assert!(events.contains(&Event::ListShaderPacks), "{events:?}");
    // rust: ui.back(&mut s);
    // rust: assert_eq!(ui.page(), Page::Graphics);
    // rust: assert_eq!(ui.graphics.page(), crate::graphics_ui::Page::Shaders);
}

horizon_settings_hang_off_options_and_reach_every_horizon_page :: proc() {
}
    // rust: let s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: let pushes = |ui: &mut OptionsUi| -> Vec<Page> {
    // rust: let (widgets, _, _, _) = ui.layout(&s, 427.0, 240.0);
    // rust: widgets
    // rust: .iter()
    // rust: .filter_map(|w| match &w.kind {
    // rust: WKind::Button {
    // rust: act: Act::Push(page),
    // rust: active: true,
    // rust: ..
    // rust: } => Some(*page),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}
        // Vanilla's Options buttons, Horizon's two in the Telemetry and Credits slots, then
        // Credits & Attribution (WinScreen's credits).
    // rust: let main = pushes(&mut ui);
    // rust: assert_eq!(
    // rust: &main[main.len() - 3..],
    // rust: [Page::Horizon, Page::Mods, Page::Credits]
    // rust: );
        // Video Settings... is the graphics screen, as Sodium's.
    // rust: assert!(main.contains(&Page::Graphics) && !main.contains(&Page::Video));
    // rust: ui.push(Page::Horizon);
    // rust: assert_eq!(
    // rust: pushes(&mut ui),
    // rust: [
    // rust: Page::Extras,
    // rust: Page::Pvp,
    // rust: Page::SplitSetup,
    // rust: Page::Studio,
    // rust: Page::Agent,
    // rust: ]
    // rust: );
        // No AI hides the AI Agent page.
    // rust: let mut no_ai = Settings::default();
    // rust: no_ai.extras.no_ai = true;
    // rust: let (widgets, _, _, _) = ui.layout(&no_ai, 427.0, 240.0);
    // rust: assert!(!widgets.iter().any(|w| matches!(
    // rust: &w.kind,
    // rust: WKind::Button {
    // rust: act: Act::Push(Page::Agent),
    // rust: ..
}
    // rust: )));
        // The AI Agent page: the switch, Copy and the status the game sets.
    // rust: ui.push(Page::Agent);
    // rust: ui.agent_status = vec!["Waiting for an agent.".into()];
    // rust: let (widgets, _, _, _) = ui.layout(&s, 427.0, 240.0);
    // rust: let acts: Vec<&Act> = widgets
    // rust: .iter()
    // rust: .filter_map(|w| match &w.kind {
    // rust: WKind::Button { act, .. } => Some(act),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert!(acts.contains(&&Act::Extra(crate::extras::Item::AgentControl)));
    // rust: assert!(acts.contains(&&Act::CopyAgentDetails));
    // rust: ui.stack = vec![Page::Main, Page::Controls];
    // rust: assert!(pushes(&mut ui).contains(&Page::Controller));
}

sound_device_button_in_sound_page_and_cycles :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Sound);
    // rust: let rows = ui.list_rows(&s);
    // rust: assert!(
    // rust: rows.iter().any(|r| matches!(r, Row::Big(Opt::SoundDevice))),
    // rust: "Sound page should contain Row::Big(Opt::SoundDevice)"
    // rust: );
    // rust: assert_eq!(s.sound_device, "");
    // rust: let devices = crate::audio::output_devices();
    // rust: let count = 1 + devices.len();
        // Cycling forward 'count' times wraps around back to the initial selection ("")
    // rust: for _ in 0..count {
    // rust: Opt::SoundDevice.cycle(&mut s, false, [854, 480]);
}
    // rust: assert_eq!(s.sound_device, "");
        // Cycling backward 'count' times also wraps around back to ""
    // rust: for _ in 0..count {
    // rust: Opt::SoundDevice.cycle(&mut s, true, [854, 480]);
}
    // rust: assert_eq!(s.sound_device, "");
}

slider_keyboard_navigation_and_selection_toggle_parity :: proc() {
}
//         use winit::keyboard::KeyCode;
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Main);
    // rust: s.fov = 70.0;

        // 1. Tab focuses the first interactive widget: FOV slider
    // rust: ui.key(&mut s, &atlas, KeyCode::Tab, None);
    // rust: assert_eq!(ui.focus, Some(FocusId::Slider(Opt::Fov)));
    // rust: assert!(
    // rust: ui.can_change_value,
    // rust: "Tab onto slider enables can_change_value (Vanilla behavior)"
    // rust: );

        // 2. Right Arrow steps FOV up to 71
    // rust: let events = ui.key(&mut s, &atlas, KeyCode::ArrowRight, None);
    // rust: assert_eq!(s.fov, 71.0);
    // rust: assert!(events.contains(&Event::Changed));

        // 3. Left Arrow steps FOV down back to 70, then 69
    // rust: ui.key(&mut s, &atlas, KeyCode::ArrowLeft, None);
    // rust: assert_eq!(s.fov, 70.0);
    // rust: ui.key(&mut s, &atlas, KeyCode::ArrowLeft, None);
    // rust: assert_eq!(s.fov, 69.0);

        // 4. Space / Enter toggles can_change_value to false
    // rust: ui.key(&mut s, &atlas, KeyCode::Space, None);
    // rust: assert!(
    // rust: !ui.can_change_value,
    // rust: "Space toggles can_change_value to false"
    // rust: );

        // 5. With can_change_value false, Left/Right arrow keys navigate focus instead of changing value!
    // rust: ui.key(&mut s, &atlas, KeyCode::ArrowRight, None);
    // rust: assert_eq!(
    // rust: s.fov, 69.0,
    // rust: "FOV must not change when can_change_value is false"
    // rust: );
    // rust: assert_ne!(
    // rust: ui.focus,
    // rust: Some(FocusId::Slider(Opt::Fov)),
    // rust: "Focus moved to next widget horizontally"
    // rust: );

        // 6. Navigate back to FOV slider with Left Arrow
    // rust: ui.key(&mut s, &atlas, KeyCode::ArrowLeft, None);
    // rust: assert_eq!(ui.focus, Some(FocusId::Slider(Opt::Fov)));
    // rust: assert!(
    // rust: !ui.can_change_value,
    // rust: "Arrow navigation onto slider keeps can_change_value false"
    // rust: );

        // 7. Space toggles can_change_value back to true
    // rust: ui.key(&mut s, &atlas, KeyCode::Enter, None);
    // rust: assert!(ui.can_change_value);
    // rust: ui.key(&mut s, &atlas, KeyCode::ArrowRight, None);
    // rust: assert_eq!(s.fov, 70.0);

        // 8. Escape closes the options page immediately, even while a slider
        // is focused for value changes.
    // rust: let events = ui.key(&mut s, &atlas, KeyCode::Escape, None);
    // rust: assert!(!ui.can_change_value);
    // rust: assert_eq!(
    // rust: ui.page(),
    // rust: Page::Main,
    // rust: "Escape must close the options page from value edit"
    // rust: );
    // rust: assert!(events.contains(&Event::Close));
}

escape_closes_options_with_search_focused :: proc() {
}
//         use winit::keyboard::KeyCode;
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Video);
    // rust: ui.focus = Some(FocusId::Search);
    // rust: ui.settings_search.focused = true;

    // rust: let events = ui.key(&mut s, &atlas, KeyCode::Escape, None);
    // rust: assert!(events.contains(&Event::Changed));
    // rust: assert_eq!(ui.page(), Page::Main);
    // rust: assert_eq!(ui.focus, None);
    // rust: assert!(!ui.settings_search.focused);
}

slider_mouse_wheel_scrolls_list_parity :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Main);
    // rust: s.fov = 70.0;
    // rust: let size: (f32, f32) = (427.0, 240.0);
    // rust: let cx = (size.0 / 2.0_f32).floor();

        // Cursor over FOV slider (cx - 154.0, 29.0, 150.0, 20.0)
    // rust: let cursor = (cx - 100.0, 35.0);
        // In vanilla parity, mouse wheel over a slider does not change the slider value.
    // rust: ui.wheel(&mut s, size, cursor, [854, 480], 1.0);
    // rust: assert_eq!(s.fov, 70.0);

        // Sound page: Master Volume slider
    // rust: ui.show(Page::Sound);
    // rust: s.master_volume = 0.5;
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let master = widgets
    // rust: .iter()
    // rust: .find(|w| {
    // rust: matches!(
    // rust: w.kind,
    // rust: WKind::Slider {
    // rust: opt: Opt::Volume(0),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: let cursor = (master.x + 10.0, master.y + 10.0);
    // rust: let events = ui.wheel(&mut s, size, cursor, [854, 480], 1.0);
    // rust: assert_eq!(s.master_volume, 0.5);
    // rust: assert!(!events.iter().any(|e| matches!(e, Event::Volume(0, _))));
}

the_graphics_screens_wheel_scrolls_even_over_a_slider_being_changed :: proc() {
}
//         use crate::graphics_ui::{H, Item, Target};
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Graphics);
    // rust: let size = (640.0, 360.0);
    // rust: s.horizon.chunk_updates = 16;
    // rust: ui.graphics.focus = Some(Target::Item(Item::Horizon(H::ChunkUpdates)));
    // rust: ui.graphics.can_change_value = true;
    // rust: let before = ui.graphics.scroll_amount();
    // rust: ui.wheel(&mut s, size, (320.0, 150.0), [1920, 1080], -1.0);
    // rust: assert_eq!(s.horizon.chunk_updates, 16);
    // rust: assert!(ui.graphics.scroll_amount() > before);
}

horizon_pages_slider_and_wheel_parity :: proc() {
}
//         use winit::keyboard::KeyCode as K;
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();

        // 1. Extras page: with the wheel extra on, the wheel on the Sort switch cycles it
    // rust: s.extras.wheel_cycles_settings = true;
    // rust: ui.show(Page::Extras);
    // rust: let size = (480.0, 600.0);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let sort_wd = widgets
    // rust: .iter()
    // rust: .find(|w| {
    // rust: matches!(
    // rust: w.kind,
    // rust: WKind::Button {
    // rust: act: Act::Extra(crate::extras::Item::Sort),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: let cursor = (sort_wd.x + 5.0, sort_wd.y + 5.0);
    // rust: assert!(!s.extras.sort);
    // rust: ui.wheel(&mut s, size, cursor, [854, 480], 1.0);
    // rust: assert!(s.extras.sort);
    // rust: ui.wheel(&mut s, size, cursor, [854, 480], 1.0);
    // rust: assert!(!s.extras.sort);

        // 2. Horizon Graphics page through OptionsUi:
        // Tab onto ChunkUpdates slider, ArrowRight adjusts value, Space toggles can_change_value
    // rust: ui.show(Page::Graphics);
    // rust: ui.graphics.open(crate::graphics_ui::Page::Performance);
    // rust: s.horizon.chunk_updates = 10;
    // rust: ui.size = size;
    // rust: ui.framebuffer = [854, 480];

        // Tab into controls
    // rust: for _ in 0..80 {
    // rust: ui.key(&mut s, &atlas, K::Tab, None);
    // rust: if ui.graphics.focus
    // rust: == Some(crate::graphics_ui::Target::Item(
    // rust: crate::graphics_ui::Item::Horizon(crate::graphics_ui::H::ChunkUpdates),
    // rust: ))
    // rust: {
    // rust: break;
}
}
    // rust: assert_eq!(
    // rust: ui.graphics.focus,
    // rust: Some(crate::graphics_ui::Target::Item(
    // rust: crate::graphics_ui::Item::Horizon(crate::graphics_ui::H::ChunkUpdates)
    // rust: ))
    // rust: );
    // rust: assert!(ui.graphics.can_change_value);

        // Right arrow steps ChunkUpdates to 11
    // rust: let events = ui.key(&mut s, &atlas, K::ArrowRight, None);
    // rust: assert_eq!(s.horizon.chunk_updates, 11);
    // rust: assert!(events.contains(&Event::SliderDrag));

        // Space toggles can_change_value to false
    // rust: ui.key(&mut s, &atlas, K::Space, None);
    // rust: assert!(!ui.graphics.can_change_value);

        // ArrowRight does not change ChunkUpdates when can_change_value is false
    // rust: ui.key(&mut s, &atlas, K::ArrowRight, None);
    // rust: assert_eq!(s.horizon.chunk_updates, 11);
}

    // Vanilla's wheel scrolls the list (`AbstractScrollArea.mouseScrolled`); with the
    // extra on, a widget focused by the keyboard takes the step from anywhere on the
    // screen. A click focuses its widget for the highlight, and honouring that focus made a
    // clicked option toggle on every later wheel event while the list never scrolled.
a_clicked_option_lets_the_wheel_scroll_the_list :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Video);
    // rust: let framebuffer = [854, 480];
    // rust: let click_size = (427.0, 400.0);
    // rust: let (widgets, click_top, click_bottom, _) = ui.layout(&s, click_size.0, click_size.1);

        // A click leaves the widget focused for its highlight, not for the wheel.
    // rust: let wd = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Button {
    // rust: act: Act::Cycle(_),
    // rust: ..
}
    // rust: ) && (!wd.list || (wd.y >= click_top && wd.y + wd.h <= click_bottom))
    // rust: })
    // rust: .expect("a visible cycle button");
    // rust: ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: wd.x + 5.0,
    // rust: wd.y + 5.0,
    // rust: click_size,
    // rust: framebuffer,
    // rust: false,
    // rust: false,
    // rust: );
    // rust: assert!(
    // rust: matches!(ui.focus, Some(FocusId::Cycle(_))),
    // rust: "the click focuses the cycle button it hit"
    // rust: );
    // rust: assert!(
    // rust: !ui.focus_from_keyboard,
    // rust: "a click does not leave keyboard focus"
    // rust: );

        // The wheel over the list's empty margin scrolls it at a size where the
        // page overflows, and the clicked cycle option stays put: no ButtonClick,
        // no Changed.
    // rust: let size = (427.0, 240.0);
    // rust: let (_, top, bottom, content) = ui.layout(&s, size.0, size.1);
    // rust: assert!(
    // rust: content > bottom - top,
    // rust: "the video page scrolls at this size"
    // rust: );
    // rust: let before = s.view_bobbing;
    // rust: let start = ui.scroll;
    // rust: let cursor = (2.0, (top + bottom) / 2.0);
    // rust: let events = ui.wheel(&mut s, size, cursor, framebuffer, -1.0);
    // rust: assert_eq!(s.view_bobbing, before, "the clicked option does not toggle");
    // rust: assert!(!events.contains(&Event::ButtonClick), "no click reaches it");
    // rust: assert!(!events.contains(&Event::Changed));
    // rust: assert!(ui.scroll > start, "the list scrolls down instead");

        // With the extra on, keyboard focus keeps the documented divergence: the
        // wheel steps it wherever the cursor is, even off the widget.
    // rust: s.extras.wheel_cycles_settings = true;
    // rust: ui.focus = Some(FocusId::Cycle(Opt::ViewBobbing));
    // rust: ui.focus_from_keyboard = true;
    // rust: let events = ui.wheel(&mut s, size, cursor, framebuffer, -1.0);
    // rust: assert_ne!(s.view_bobbing, before, "a keyboard-focused option cycles");
    // rust: assert!(events.contains(&Event::ButtonClick));
    // rust: assert!(events.contains(&Event::Changed));
}

the_wheel_scrolls_a_list_past_its_cycle_buttons_with_the_extra_off :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Video);
    // rust: let framebuffer = [854, 480];
    // rust: let size = (427.0, 240.0);
    // rust: let (widgets, top, bottom, content) = ui.layout(&s, size.0, size.1);
    // rust: assert!(
    // rust: content > bottom - top,
    // rust: "the video page scrolls at this size"
    // rust: );
    // rust: let (opt, over, list) = widgets
    // rust: .iter()
    // rust: .find_map(|wd| match wd.kind {
    // rust: WKind::Button {
    // rust: act: Act::Cycle(opt),
    // rust: ..
    // rust: } if wd.y >= top && wd.y + wd.h <= bottom => {
    // rust: Some((opt, (wd.x + 5.0, wd.y + 5.0), wd.list))
}
    // rust: _ => None,
    // rust: })
    // rust: .expect("a visible cycle button");

    // rust: assert!(list, "{opt:?} is a row of the video list");
        // The default, as in vanilla (#9633).
    // rust: assert!(!s.extras.wheel_cycles_settings);
    // rust: let before = format!("{s:?}");
    // rust: let start = ui.scroll;
    // rust: let events = ui.wheel(&mut s, size, over, framebuffer, -1.0);
    // rust: assert_eq!(format!("{s:?}"), before, "the hovered option stays put");
    // rust: assert!(!events.contains(&Event::Changed));
    // rust: assert!(
    // rust: ui.scroll > start,
    // rust: "the list scrolls under the cursor instead"
    // rust: );
        // Keyboard focus doesn't take the wheel either.
    // rust: ui.focus = Some(FocusId::Cycle(opt));
    // rust: ui.focus_from_keyboard = true;
    // rust: ui.wheel(&mut s, size, over, framebuffer, -1.0);
    // rust: assert_eq!(format!("{s:?}"), before);

        // On, the row under the cursor takes the step.
    // rust: s.extras.wheel_cycles_settings = true;
    // rust: let before = format!("{s:?}");
    // rust: let events = ui.wheel(&mut s, size, over, framebuffer, -1.0);
    // rust: assert_ne!(format!("{s:?}"), before, "{opt:?} cycles");
    // rust: assert!(events.contains(&Event::Changed));
}

options_step_slider_matches_set_slider_for_all_stepped_options :: proc() {
}
    // rust: let stepped_opts = [
    // rust: Opt::Fov,
    // rust: Opt::RenderDistance,
    // rust: Opt::SimulationDistance,
    // rust: Opt::MaxFps,
    // rust: Opt::CloudRange,
    // rust: Opt::EntityDistance,
    // rust: Opt::BiomeBlend,
    // rust: Opt::Preset,
    // rust: Opt::Mipmaps,
    // rust: Opt::WeatherRadius,
    // rust: Opt::ChunkFade,
    // rust: Opt::MenuBlur,
    // rust: Opt::NotificationDisplayTime,
    // rust: Opt::PadMoveDeadzone,
    // rust: Opt::PadLookDeadzone,
    // rust: Opt::PadTriggerThreshold,
    // rust: Opt::SprintWindow,
    // rust: ];
    // rust: for opt in stepped_opts {
    // rust: let steps = opt.slider_steps().expect("slider steps");
    // rust: for i in 0..steps {
    // rust: let pos = i as f32 / steps as f32;
    // rust: let mut s1 = Settings::default();
    // rust: let mut s2 = Settings::default();
    // rust: opt.set_slider(&mut s1, pos);

    // rust: opt.step_slider(&mut s1, true, 200.0);
    // rust: let next_pos = (i + 1) as f32 / steps as f32;
    // rust: opt.set_slider(&mut s2, next_pos);
    // rust: assert_eq!(
    // rust: opt.slider_position(&s1),
    // rust: opt.slider_position(&s2),
    // rust: "{opt:?} forward from {i}"
    // rust: );
}
    // rust: for i in 1..=steps {
    // rust: let pos = i as f32 / steps as f32;
    // rust: let mut s1 = Settings::default();
    // rust: let mut s2 = Settings::default();
    // rust: opt.set_slider(&mut s1, pos);

    // rust: opt.step_slider(&mut s1, false, 200.0);
    // rust: let prev_pos = (i - 1) as f32 / steps as f32;
    // rust: opt.set_slider(&mut s2, prev_pos);
    // rust: assert_eq!(
    // rust: opt.slider_position(&s1),
    // rust: opt.slider_position(&s2),
    // rust: "{opt:?} backward from {i}"
    // rust: );
}
}
}

options_keyboard_space_enter_emits_button_click_for_cycle_and_default_buttons :: proc() {
}
//         use winit::keyboard::KeyCode;
    // rust: let mut ui = OptionsUi::default();
    // rust: let mut s = Settings::default();
    // rust: let atlas = atlas();

        // 1. Focus a cycle button (e.g. Opt::ViewBobbing)
    // rust: ui.focus = Some(FocusId::Cycle(Opt::ViewBobbing));
    // rust: let events = ui.key(&mut s, &atlas, KeyCode::Space, None);
    // rust: assert!(
    // rust: events.contains(&Event::ButtonClick),
    // rust: "Space on FocusId::Cycle must emit Event::ButtonClick"
    // rust: );
    // rust: assert!(events.contains(&Event::Changed));

    // rust: let events = ui.key(&mut s, &atlas, KeyCode::Enter, None);
    // rust: assert!(
    // rust: events.contains(&Event::ButtonClick),
    // rust: "Enter on FocusId::Cycle must emit Event::ButtonClick"
    // rust: );
    // rust: assert!(events.contains(&Event::Changed));

        // 2. Focus a default/action button (e.g. Act::Done)
    // rust: ui.focus = Some(FocusId::Act(Act::Done));
    // rust: let events = ui.key(&mut s, &atlas, KeyCode::Space, None);
    // rust: assert!(
    // rust: events.contains(&Event::ButtonClick),
    // rust: "Space on FocusId::Act must emit Event::ButtonClick"
    // rust: );

    // rust: ui.focus = Some(FocusId::Act(Act::Done));
    // rust: let events = ui.key(&mut s, &atlas, KeyCode::Enter, None);
    // rust: assert!(
    // rust: events.contains(&Event::ButtonClick),
    // rust: "Enter on FocusId::Act must emit Event::ButtonClick"
    // rust: );
}

the_music_page_button_follows_the_extra :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let size = (960.0, 540.0);
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Sound);
    // rust: let open = |ui: &mut OptionsUi, s: &Settings| {
    // rust: let (widgets, ..) = ui.layout(s, size.0, size.1);
    // rust: widgets.into_iter().find(
    // rust: |w| matches!(&w.kind, WKind::Button { act, .. } if *act == Act::Push(Page::Music)),
    // rust: )
}
        // The extra is off by default: Music & Sounds is vanilla's page.
    // rust: assert!(open(&mut ui, &s).is_none());
    // rust: s.extras.music_page = true;
    // rust: assert!(open(&mut ui, &s).is_some(), "Music... once the extra is on");
        // It is the last row: scroll the list to its end before clicking it.
    // rust: ui.scroll(&s, size, -1000.0);
    // rust: let (widgets, ..) = ui.layout(&s, size.0, size.1);
    // rust: let open_button = widgets
    // rust: .into_iter()
    // rust: .find(
    // rust: |w| matches!(&w.kind, WKind::Button { act, .. } if *act == Act::Push(Page::Music)),
    // rust: )
    // rust: .expect("Music... on the Music & Sounds page");
    // rust: let events = ui.click(
    // rust: &mut s,
    // rust: &atlas,
    // rust: open_button.x + open_button.w / 2.0,
    // rust: open_button.y + open_button.h / 2.0,
    // rust: size,
    // rust: [854, 480],
    // rust: false,
    // rust: false,
    // rust: );
    // rust: assert_eq!(ui.page(), Page::Music);
    // rust: assert!(events.contains(&Event::ListMusicTracks));
}

the_music_page_plays_a_track_now_and_turns_tracks_off :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let size = (960.0, 540.0);
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi {
    // rust: music_groups: vec![MusicGroup {
    // rust: label: "horizon.pages.music.overworld".into(),
    // rust: tracks: vec![
    // rust: MusicTrack {
    // rust: event: "minecraft:music.game".into(),
    // rust: id: "minecraft:music/game/calm1".into(),
    // rust: },
    // rust: MusicTrack {
    // rust: event: "minecraft:music.overworld.forest".into(),
    // rust: id: "minecraft:music/game/bromeliad".into(),
    // rust: },
    // rust: ],
    // rust: }],
    // rust: ..OptionsUi::default()
}
    // rust: ui.show(Page::Music);
    // rust: let at = |ui: &mut OptionsUi, s: &Settings, want: &Act| {
    // rust: let (widgets, ..) = ui.layout(s, size.0, size.1);
    // rust: let w = widgets
    // rust: .into_iter()
    // rust: .find(|w| matches!(&w.kind, WKind::Button { act, .. } if act == want))
    // rust: .expect("button");
    // rust: (w.x + w.w / 2.0, w.y + w.h / 2.0)
}
        // The left of a row plays that track now, from its own pool (a biome
        // pool's track plays from that pool).
    // rust: let calm1 = "minecraft:music/game/calm1";
    // rust: let (x, y) = at(
    // rust: &mut ui,
    // rust: &s,
    // rust: &Act::PlayMusicTrack("minecraft:music.game".into(), calm1.into()),
    // rust: );
    // rust: let events = ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: assert!(events.contains(&Event::PlayMusicTrack(
    // rust: "minecraft:music.game".into(),
    // rust: calm1.into()
    // rust: )));
    // rust: let bromeliad = "minecraft:music/game/bromeliad";
    // rust: let (x, y) = at(
    // rust: &mut ui,
    // rust: &s,
    // rust: &Act::PlayMusicTrack("minecraft:music.overworld.forest".into(), bromeliad.into()),
    // rust: );
    // rust: let events = ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: assert!(events.contains(&Event::PlayMusicTrack(
    // rust: "minecraft:music.overworld.forest".into(),
    // rust: bromeliad.into()
    // rust: )));
        // The right of a row turns it off, and the game saves that on `Changed`.
    // rust: let (x, y) = at(&mut ui, &s, &Act::MusicTrackOn(calm1.into(), true));
    // rust: let events = ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: assert!(events.contains(&Event::Changed));
    // rust: assert_eq!(s.extras.music_off, [calm1.to_owned()]);
        // And back on.
    // rust: let (x, y) = at(&mut ui, &s, &Act::MusicTrackOn(calm1.into(), false));
    // rust: let events = ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false);
    // rust: assert!(events.contains(&Event::Changed));
    // rust: assert!(s.extras.music_off.is_empty());
}

options_cycle_button_cycles_forward_and_shift_click_cycles_backward_with_wrapping :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let mut s = Settings::default();
    // rust: let mut ui = OptionsUi::default();
    // rust: ui.show(Page::Chat);
    // rust: let size = (480.0, 480.0);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let button = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::Cycle(Opt::ChatVisibility),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .expect("ChatVisibility must be a cycle button");
    // rust: let (x, y) = (button.x + 1.0, button.y + 1.0);

        // Initial chat_visibility is 0
    // rust: assert_eq!(s.chat_visibility, 0);

        // 1. Feature without shift (normal click): cycles forward (+1)
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert_eq!(s.chat_visibility, 1);

    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert_eq!(s.chat_visibility, 2);

        // 3. Wrap-around forward (at max value, normal click wraps to min / 0)
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert_eq!(s.chat_visibility, 0);

        // 4. Wrap-around backward (at min / 0, shift-click wraps to max)
    // rust: ui.shift = true;
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert_eq!(s.chat_visibility, 2);

        // 2. Feature with shift: cycles backward (-1)
    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert_eq!(s.chat_visibility, 1);

    // rust: assert_eq!(
    // rust: ui.click(&mut s, &atlas, x, y, size, [854, 480], false, false),
    // rust: vec![Event::ButtonClick, Event::Changed]
    // rust: );
    // rust: assert_eq!(s.chat_visibility, 0);
    // rust: ui.shift = false;

        // Also test Opt::Particles on Page::Video
    // rust: ui.show(Page::Video);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let button = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::Cycle(Opt::Particles),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .expect("Particles must be a cycle button");
    // rust: let (px, py) = (button.x + 1.0, button.y + 1.0);

        // Initial particles is 0
    // rust: assert_eq!(s.particles, 0);

        // Forward
    // rust: ui.click(&mut s, &atlas, px, py, size, [854, 480], false, false);
    // rust: assert_eq!(s.particles, 1);
    // rust: ui.click(&mut s, &atlas, px, py, size, [854, 480], false, false);
    // rust: assert_eq!(s.particles, 2);
        // Wrap forward
    // rust: ui.click(&mut s, &atlas, px, py, size, [854, 480], false, false);
    // rust: assert_eq!(s.particles, 0);

        // Wrap backward with shift
    // rust: ui.shift = true;
    // rust: ui.click(&mut s, &atlas, px, py, size, [854, 480], false, false);
    // rust: assert_eq!(s.particles, 2);
        // Backward with shift
    // rust: ui.click(&mut s, &atlas, px, py, size, [854, 480], false, false);
    // rust: assert_eq!(s.particles, 1);
    // rust: ui.click(&mut s, &atlas, px, py, size, [854, 480], false, false);
    // rust: assert_eq!(s.particles, 0);
    // rust: ui.shift = false;

        // Also verify Act::Extra on Page::Extras
    // rust: ui.show(Page::Extras);
    // rust: let (widgets, top, _, _) = ui.layout(&s, size.0, size.1);
    // rust: if let Some(extra_btn) = widgets.iter().find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Button {
    // rust: active: true,
    // rust: act: Act::Extra(crate::extras::Item::CosmeticsOthers),
    // rust: ..
}
    // rust: )
    // rust: }) {
            // Extras has enough rows to scroll: click the cycle button inside
            // the list's viewport, as a player would after scrolling to it.
    // rust: ui.scroll = (extra_btn.y - top).max(0.0);
    // rust: let (widgets, _, _, _) = ui.layout(&s, size.0, size.1);
    // rust: let extra_btn = widgets
    // rust: .iter()
    // rust: .find(|wd| {
    // rust: matches!(
    // rust: wd.kind,
    // rust: WKind::Button {
    // rust: act: Act::Extra(crate::extras::Item::CosmeticsOthers),
    // rust: ..
}
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: let (ex, ey) = (extra_btn.x + 1.0, extra_btn.y + 1.0);
//             use horizon_cosmetics::prefs::Others;
            // Not chosen, nothing owned: shows Hidden.
    // rust: assert_eq!(s.extras.cosmetics_others, None);
    // rust: assert_eq!(s.extras.effective_others(), Others::Hidden);

            // Forward (wraps to Shown), now a choice
    // rust: ui.click(&mut s, &atlas, ex, ey, size, [854, 480], false, false);
    // rust: assert_eq!(s.extras.cosmetics_others, Some(Others::Shown));

            // Backward with shift
    // rust: ui.shift = true;
    // rust: ui.click(&mut s, &atlas, ex, ey, size, [854, 480], false, false);
    // rust: assert_eq!(s.extras.cosmetics_others, Some(Others::Hidden));

            // Backward again
    // rust: ui.click(&mut s, &atlas, ex, ey, size, [854, 480], false, false);
    // rust: assert_eq!(s.extras.cosmetics_others, Some(Others::NameTags));
    // rust: ui.shift = false;
}
}
}
