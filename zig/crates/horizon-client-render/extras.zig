//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_extras
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Horizon's optional extras (minimap, lighting, inventory tools): their
//! settings, kept in `horizon-extras.txt` next to `options.txt` so that file
//! stays exactly vanilla's, and the logic behind them. Every extra is off by
//! default; see `docs/extras.md`. Horizon's own switches outside the Extras page
//! (No AI, Agent Control, Discord Rich Presence) are kept here too.
// use std::{collections::VecDeque, fs, path::Path};

pub const FILE: []const u8 = "horizon-extras.txt";
/// The name the options screen uses while the sort key waits for a key.
pub const SORT_KEY: []const u8 = "horizon.sort";
/// The 3D skin layers line, here and in the `options.txt` that held it first.
pub const SKIN_LAYERS_KEY: []const u8 = "threeDSkinLayers";
/// The emote wheel's key, here and in the `key_key.emote` line #10092 wrote to `options.txt`.
pub const EMOTE_KEY: []const u8 = "emoteKey";
pub const OLD_EMOTE_LINE: []const u8 = "key_key.emote";

/// The minimap's sizes in GUI pixels, and its zooms in blocks per pixel.
pub const MINIMAP_SIZES: [(u8, []const u8); 3] = [(64, "Small"), (96, "Medium"), (128, "Large")];
pub const MINIMAP_ZOOMS: [f32; 4] = [0.5, 1.0, 2.0, 4.0];

/// A screen corner for an overlay.
pub const Corner = enum {
    TopLeft,
    TopRight,
    BottomLeft,
    BottomRight,
};
    // rust: impl Corner {
    // rust: pub const ALL: [Corner; 4] = [
    // rust: Corner::TopLeft,
    // rust: Corner::TopRight,
    // rust: Corner::BottomLeft,
    // rust: Corner::BottomRight,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Corner::TopLeft => "top_left",
    // rust: Corner::TopRight => "top_right",
    // rust: Corner::BottomLeft => "bottom_left",
    // rust: Corner::BottomRight => "bottom_right",
}
}
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Corner::TopLeft => "Top left",
    // rust: Corner::TopRight => "Top right",
    // rust: Corner::BottomLeft => "Bottom left",
    // rust: Corner::BottomRight => "Bottom right",
}
}
pub fn parse(s: []const u8, default: Corner) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .find(|c| c.name() == s)
    // rust: .unwrap_or(default)
}
pub fn top(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Corner::TopLeft | Corner::TopRight)
}
pub fn left(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Corner::TopLeft | Corner::BottomLeft)
}
}

pub const Extras = struct {
    /// The Select Resource Packs screen's Add button, which browses
    /// Modrinth. Off by default: it is Horizon's own and the screen is
    /// otherwise vanilla's (tools/test_pack_screen_parity.py).
    pack_browser: bool,
    /// Make /pregen available in single-player and hosted LAN worlds.
    pregen: bool,
    fullbright: bool,
    /// Held, dropped and burning light sources light their surroundings (`dynamic_light`).
    dynamic_lights: bool,
    zoom: bool,
    /// A vanilla key name (`key.keyboard.z`).
    zoom_key: []const u8,
    /// The zoom the key starts at.
    zoom_level: u8,
    /// Ease through vanilla's FOV easing (as the spyglass does).
    zoom_smooth: bool,
    /// Divide mouse turning by the zoom.
    zoom_sensitivity: bool,
    /// Far terrain a zoom magnifies is planned finer, so a spyglass does not
    /// show the coarse cells it was given for an unzoomed screen
    /// (`lod::Aim`). Costs far tiles while the zoom is held and gives them
    /// back after, and does nothing at all unless far terrain is on
    /// (`lodDistance`) and the view is actually zoomed. Off by default until
    /// a measurement shows the extra tiles land while the zoom is still held.
    lod_zoom_detail: bool,
    /// The FPS counter and keystrokes extras are official mods now: their
    /// old settings stay here, kept as they were.
    fps: bool,
    fps_corner: Corner,
    /// Also show the minimum and 1% low.
    fps_lows: bool,
    keystrokes: bool,
    keystrokes_corner: Corner,
    /// Clicks per second under the mouse buttons.
    keystrokes_cps: bool,
    /// The official mods once installed for the extras they replace, by mod
    /// id (`movedToMods`).
    moved: std.ArrayList([]const u8),
    minimap: bool,
    minimap_corner: Corner,
    /// Side in GUI pixels (`MINIMAP_SIZES`).
    minimap_size: u8,
    minimap_round: bool,
    /// Blocks per pixel (`MINIMAP_ZOOMS`).
    minimap_zoom: f32,
    /// Turn with the player (forward up) instead of north up.
    minimap_rotate: bool,
    /// Retry lost multiplayer connections (`reconnect`).
    auto_reconnect: bool,
    /// Positional sounds leave a few static sound channels free for UI sounds
    /// and others played to the listener (`sound_engine::HEARD_RESERVE`).
    ui_sound_reserve: bool,
    /// The player's own name tag over its model in third person.
    own_name_tag: bool,
    /// No particles from breaking or mining a block (other particles stay).
    hide_block_particles: bool,
    /// Mouse Tweaks-style drags in the inventory and storage containers.
    mouse_tweaks: bool,
    /// With them, the wheel over a slot moves its items one at a time.
    mouse_tweaks_wheel: bool,
    /// Sort buttons on the inventory and chest-like containers.
    sort: bool,
    /// A vanilla key name: sorts the part under the cursor.
    sort_key: []const u8,
    /// The emote wheel's key (`key.emote`), as the game last saved it. The live binding is
    /// `Settings::keys`, bound in Controls with the vanilla ones; it is only kept in this file
    /// so that `options.txt` stays vanilla's (`Settings::load` hands it over, `save` takes it back).
    emote_key: []const u8,
    /// A new chat line slides in from the left while it fades in (`Chat::layout`).
    chat_animation: bool,
    /// The indicator bar at the left of a chat line (on by default, as vanilla).
    chat_indicator: bool,
    /// No AI: every AI feature hidden and off (`horizon_core::no_ai`; the launcher writes it too).
    no_ai: bool,
    /// Agents may control the game the player starts: it opens its control socket for
    /// horizon-ctl and MCP clients (off by default; an agent's own launch always opens it).
    agent_control: bool,
    /// F3+R and F3+E start/stop a repro recording and write its bundle (off by
    /// default: a recording copies the world).
    repro_keys: bool,
    /// "Playing Horizon" on the player's Discord profile (`discord_presence`; on by default).
    discord_presence: bool,
    /// Another controller can join P1's world (`splitscreen`, off by default).
    splitscreen: bool,
    /// Two players in one window: 0 auto (side by side when wider than tall), 1 side by side,
    /// 2 top and bottom (`splitscreenTwo`).
    splitscreen_two: u8,
    /// Three players on a screen: 0 one wide on top, 1 one tall on the left, 2 side by side
    /// (`splitscreenThree`).
    splitscreen_three: u8,
    /// Splitscreen: each player's name in the corner of their view (`splitscreenNames`).
    splitscreen_names: bool,
    /// The wheel over a cycle button in the settings changes it (`CycleButton.mouseScrolled`,
    /// on by default as vanilla); off, the wheel only scrolls the list.
    wheel_cycles_settings: bool,
    /// The built-in music tracks the Music page turned off (sound ids): they
    /// leave every pool they play in (`musicOff`, empty by default: vanilla's
    /// random selection).
    music_off: std.ArrayList([]const u8),
    /// The Music page: the Music... button on Music & Sounds, playing a
    /// built-in track and leaving the off ones out (`musicPage`, off by
    /// default: vanilla plays exactly as before).
    music_page: bool,
    /// Cosmetics (`horizon_cosmetics`, off unless enabled), the lines `horizon_cosmetics::prefs`
    /// shares with the launcher's Wardrobe: Show my cosmetics (the account's, sent to the service;
    /// on by default), how much of other players' to show (no line until chosen:
    /// `effective_others`), and whether their trails and auras are hidden (off by default).
    cosmetics_mine: bool,
    cosmetics_others: ?horizon_cosmetics::prefs::Others,
    cosmetics_hide_fx: bool,
    /// My cosmetics in single player too (`cosmeticsSolo`, off by default): the window's own server
    /// names the player by their offline profile, which the service doesn't know, so their own
    /// cosmetics and name tag style show only with this on.
    cosmetics_solo: bool,
    /// Whether the signed-in account owns a cosmetic, as the service said (never saved; the game
    /// sets it): with no choice made, others' cosmetics show only then.
    cosmetics_owner: bool,
    /// Horizon's mark before the names of other Horizon players (name tags, player list), and
    /// whether the service may say this player plays Horizon: both on by default.
    horizon_marks: bool,
    horizon_listed: bool,
    /// 3D skin layers (`threeDSkinLayers`, Options → Skin Customization): each
    /// painted texel of a player's outer layer drawn as a slab
    /// (`horizon_client::mobs::skin_layers`).
    three_d_skin_layers: bool,
    /// The PvP & HUD page's options (`pvp`).
    pvp: crate::pvp::Pvp,
};
    // rust: impl Default for Extras {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: pack_browser: false,
    // rust: pregen: false,
    // rust: fullbright: false,
    // rust: dynamic_lights: false,
    // rust: zoom: false,
    // rust: zoom_key: "key.keyboard.z".into(),
    // rust: zoom_level: 4,
    // rust: zoom_smooth: true,
    // rust: zoom_sensitivity: true,
    // rust: lod_zoom_detail: false,
    // rust: fps: false,
    // rust: fps_corner: Corner::TopLeft,
    // rust: fps_lows: false,
    // rust: keystrokes: false,
    // rust: keystrokes_corner: Corner::TopLeft,
    // rust: keystrokes_cps: true,
    // rust: moved: Vec::new(),
    // rust: minimap: false,
    // rust: minimap_corner: Corner::TopRight,
    // rust: minimap_size: 96,
    // rust: minimap_round: false,
    // rust: minimap_zoom: 1.0,
    // rust: minimap_rotate: false,
    // rust: auto_reconnect: false,
    // rust: ui_sound_reserve: false,
    // rust: own_name_tag: false,
    // rust: hide_block_particles: false,
    // rust: mouse_tweaks: false,
    // rust: mouse_tweaks_wheel: true,
    // rust: sort: false,
    // rust: sort_key: "key.keyboard.unknown".into(),
    // rust: emote_key: crate::keybinds::KeyBinds::default_of("key.emote").into(),
    // rust: chat_animation: false,
    // rust: chat_indicator: true,
    // rust: no_ai: false,
    // rust: agent_control: false,
    // rust: repro_keys: false,
    // rust: discord_presence: true,
    // rust: splitscreen: false,
    // rust: splitscreen_two: 0,
    // rust: splitscreen_three: 0,
    // rust: splitscreen_names: true,
    // rust: wheel_cycles_settings: false,
    // rust: music_off: Vec::new(),
    // rust: music_page: false,
    // rust: cosmetics_mine: true,
    // rust: cosmetics_others: None,
    // rust: cosmetics_hide_fx: false,
    // rust: cosmetics_solo: false,
    // rust: cosmetics_owner: false,
    // rust: horizon_marks: true,
    // rust: horizon_listed: true,
    // rust: three_d_skin_layers: false,
    // rust: pvp: Default::default(),
}
}
}
pub fn bool_text(v: bool) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v { "true" } else { "false" }
}
    // rust: impl Extras {
    /// How much of other players' cosmetics shows: the player's choice, else all of it for an
    /// account that owns a cosmetic and none for any other (a vanilla game).
pub fn effective_others(self: *Self) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_cosmetics::prefs::Others::effective(self.cosmetics_others, self.cosmetics_owner)
}
pub fn load(dir: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs::read_to_string(dir.join(FILE))
    // rust: .map(|t| Self::parse(&t))
    // rust: .unwrap_or_default()
}
pub fn parse(text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut e = Self::default();
    // rust: for line in text.lines() {
    // rust: let Some((key, value)) = line.split_once(':') else {
    // rust: continue;
}
    // rust: let value = value.trim();
    // rust: let flag = |d: bool| match value {
    // rust: "true" => true,
    // rust: "false" => false,
    // rust: _ => d,
}
    // rust: match key.trim() {
    // rust: "packBrowser" => e.pack_browser = flag(e.pack_browser),
    // rust: "pregen" => e.pregen = flag(e.pregen),
    // rust: "fullbright" => e.fullbright = flag(e.fullbright),
    // rust: "dynamicLights" => e.dynamic_lights = flag(e.dynamic_lights),
    // rust: "zoom" => e.zoom = flag(e.zoom),
    // rust: "zoomKey" if value.starts_with("key.") => e.zoom_key = value.to_owned(),
    // rust: "zoomLevel" => {
    // rust: if let Ok(v) = value.parse::<u8>() {
    // rust: e.zoom_level = v.clamp(2, 10);
}
}
    // rust: "zoomSmooth" => e.zoom_smooth = flag(e.zoom_smooth),
    // rust: "zoomSensitivity" => e.zoom_sensitivity = flag(e.zoom_sensitivity),
    // rust: "lodZoomDetail" => e.lod_zoom_detail = flag(e.lod_zoom_detail),
    // rust: "fps" => e.fps = flag(e.fps),
    // rust: "fpsCorner" => e.fps_corner = Corner::parse(value, e.fps_corner),
    // rust: "fpsLows" => e.fps_lows = flag(e.fps_lows),
    // rust: "keystrokes" => e.keystrokes = flag(e.keystrokes),
    // rust: "keystrokesCorner" => {
    // rust: e.keystrokes_corner = Corner::parse(value, e.keystrokes_corner)
}
    // rust: "keystrokesCps" => e.keystrokes_cps = flag(e.keystrokes_cps),
    // rust: "movedToMods" => {
    // rust: e.moved = value
    // rust: .split(',')
    // rust: .map(str::trim)
    // rust: .filter(|id| !id.is_empty())
    // rust: .map(str::to_owned)
    // rust: .collect()
}
    // rust: "minimap" => e.minimap = flag(e.minimap),
    // rust: "minimapCorner" => e.minimap_corner = Corner::parse(value, e.minimap_corner),
    // rust: "minimapSize" => {
    // rust: if let Some(&(v, _)) = MINIMAP_SIZES.iter().find(|s| s.0.to_string() == value) {
    // rust: e.minimap_size = v;
}
}
    // rust: "minimapShape" => e.minimap_round = value == "round",
    // rust: "minimapZoom" => {
    // rust: if let Some(&z) = MINIMAP_ZOOMS.iter().find(|z| z.to_string() == value) {
    // rust: e.minimap_zoom = z;
}
}
    // rust: "minimapRotate" => e.minimap_rotate = flag(e.minimap_rotate),
    // rust: "autoReconnect" => e.auto_reconnect = flag(e.auto_reconnect),
    // rust: "uiSoundReserve" => e.ui_sound_reserve = flag(e.ui_sound_reserve),
    // rust: "ownNameTag" => e.own_name_tag = flag(e.own_name_tag),
    // rust: "hideBlockParticles" => e.hide_block_particles = flag(e.hide_block_particles),
    // rust: "mouseTweaks" => e.mouse_tweaks = flag(e.mouse_tweaks),
    // rust: "mouseTweaksWheel" => e.mouse_tweaks_wheel = flag(e.mouse_tweaks_wheel),
    // rust: "sort" => e.sort = flag(e.sort),
    // rust: "sortKey" if value.starts_with("key.") => e.sort_key = value.to_owned(),
    // rust: EMOTE_KEY if value.starts_with("key.") => e.emote_key = value.to_owned(),
    // rust: "chatAnimation" => e.chat_animation = flag(e.chat_animation),
    // rust: "chatIndicator" => e.chat_indicator = flag(e.chat_indicator),
    // rust: horizon_core::no_ai::KEY => e.no_ai = flag(e.no_ai),
    // rust: "agentControl" => e.agent_control = flag(e.agent_control),
    // rust: "reproKeys" => e.repro_keys = flag(e.repro_keys),
    // rust: "discordPresence" => e.discord_presence = flag(e.discord_presence),
    // rust: "splitscreen" => e.splitscreen = flag(e.splitscreen),
    // rust: "splitscreenTwo" => e.splitscreen_two = value.parse().unwrap_or(0).min(2),
    // rust: "splitscreenThree" => e.splitscreen_three = value.parse().unwrap_or(0).min(2),
    // rust: "splitscreenNames" => e.splitscreen_names = flag(e.splitscreen_names),
                // A new name: `wheelCyclesSettings` was written as true by every
                // install while it was the default, so it says nothing of a choice.
    // rust: "wheelCyclesListSettings" => {
    // rust: e.wheel_cycles_settings = flag(e.wheel_cycles_settings)
}
    // rust: "musicOff" => {
    // rust: e.music_off = value
    // rust: .split(',')
    // rust: .map(str::trim)
    // rust: .filter(|id| !id.is_empty())
    // rust: .map(str::to_owned)
    // rust: .collect()
}
    // rust: "musicPage" => e.music_page = flag(e.music_page),
    // rust: "cosmeticsMine" => e.cosmetics_mine = flag(e.cosmetics_mine),
    // rust: "cosmeticsOthers" => {
    // rust: e.cosmetics_others =
    // rust: horizon_cosmetics::prefs::Others::parse(value).or(e.cosmetics_others)
}
    // rust: "cosmeticsHideFx" => e.cosmetics_hide_fx = flag(e.cosmetics_hide_fx),
    // rust: "cosmeticsSolo" => e.cosmetics_solo = flag(e.cosmetics_solo),
    // rust: horizon_cosmetics::prefs::MARKS => e.horizon_marks = flag(e.horizon_marks),
    // rust: horizon_cosmetics::prefs::LISTED => e.horizon_listed = flag(e.horizon_listed),
    // rust: SKIN_LAYERS_KEY => e.three_d_skin_layers = flag(e.three_d_skin_layers),
    // rust: key => {
    // rust: e.pvp.parse_line(key, value);
}
}
}
    // rust: e
}
pub fn serialize(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut text = format!(
    // rust: "packBrowser:{}\npregen:{}\nfullbright:{}\ndynamicLights:{}\nzoom:{}\nzoomKey:{}\nzoomLevel:{}\nzoomSmooth:{}\nzoomSensitivity:{}\nlodZoomDetail:{}\nfps:{}\nfpsCorner:{}\nfpsLows:{}\nkeystrokes:{}\nkeystrokesCorner:{}\nkeystrokesCps:{}\nmovedToMods:{}\nminimap:{}\nminimapCorner:{}\nminimapSize:{}\nminimapShape:{}\nminimapZoom:{}\nminimapRotate:{}\nautoReconnect:{}\nuiSoundReserve:{}\nownNameTag:{}\nhideBlockParticles:{}\nmouseTweaks:{}\nmouseTweaksWheel:{}\nsort:{}\nsortKey:{}\nchatAnimation:{}\nchatIndicator:{}\n{}:{}\nagentControl:{}\nreproKeys:{}\ndiscordPresence:{}\nsplitscreen:{}\nsplitscreenTwo:{}\nsplitscreenThree:{}\nsplitscreenNames:{}\nwheelCyclesListSettings:{}\nmusicOff:{}\nmusicPage:{}\ncosmeticsMine:{}\n{}cosmeticsHideFx:{}\ncosmeticsSolo:{}\n{}:{}\n{}:{}\n{}:{}\n",
    // rust: bool_text(self.pack_browser),
    // rust: bool_text(self.pregen),
    // rust: bool_text(self.fullbright),
    // rust: bool_text(self.dynamic_lights),
    // rust: bool_text(self.zoom),
    // rust: self.zoom_key,
    // rust: self.zoom_level,
    // rust: bool_text(self.zoom_smooth),
    // rust: bool_text(self.zoom_sensitivity),
    // rust: bool_text(self.lod_zoom_detail),
    // rust: bool_text(self.fps),
    // rust: self.fps_corner.name(),
    // rust: bool_text(self.fps_lows),
    // rust: bool_text(self.keystrokes),
    // rust: self.keystrokes_corner.name(),
    // rust: bool_text(self.keystrokes_cps),
    // rust: self.moved.join(","),
    // rust: bool_text(self.minimap),
    // rust: self.minimap_corner.name(),
    // rust: self.minimap_size,
    // rust: if self.minimap_round {
    // rust: "round"
    // rust: } else {
    // rust: "square"
    // rust: },
    // rust: self.minimap_zoom,
    // rust: bool_text(self.minimap_rotate),
    // rust: bool_text(self.auto_reconnect),
    // rust: bool_text(self.ui_sound_reserve),
    // rust: bool_text(self.own_name_tag),
    // rust: bool_text(self.hide_block_particles),
    // rust: bool_text(self.mouse_tweaks),
    // rust: bool_text(self.mouse_tweaks_wheel),
    // rust: bool_text(self.sort),
    // rust: self.sort_key,
    // rust: bool_text(self.chat_animation),
    // rust: bool_text(self.chat_indicator),
    // rust: horizon_core::no_ai::KEY,
    // rust: bool_text(self.no_ai),
    // rust: bool_text(self.agent_control),
    // rust: bool_text(self.repro_keys),
    // rust: bool_text(self.discord_presence),
    // rust: bool_text(self.splitscreen),
    // rust: self.splitscreen_two,
    // rust: self.splitscreen_three,
    // rust: bool_text(self.splitscreen_names),
    // rust: bool_text(self.wheel_cycles_settings),
    // rust: self.music_off.join(","),
    // rust: bool_text(self.music_page),
    // rust: bool_text(self.cosmetics_mine),
            // Written once the player chose.
    // rust: self.cosmetics_others
    // rust: .map_or(String::new(), |o| format!("cosmeticsOthers:{}\n", o.name())),
    // rust: bool_text(self.cosmetics_hide_fx),
    // rust: bool_text(self.cosmetics_solo),
    // rust: horizon_cosmetics::prefs::MARKS,
    // rust: bool_text(self.horizon_marks),
    // rust: horizon_cosmetics::prefs::LISTED,
    // rust: bool_text(self.horizon_listed),
    // rust: SKIN_LAYERS_KEY,
    // rust: bool_text(self.three_d_skin_layers),
    // rust: );
    // rust: text.push_str(&format!("{EMOTE_KEY}:{}\n", self.emote_key));
    // rust: self.pvp.serialize(&mut text);
    // rust: text
}
    /// Adopts the settings `options.txt` held before they moved here, while
    /// this file (`own`) has no line of its own: 3D skin layers and the emote key were
    /// `options.txt` lines. Vanilla's `Options.save` drops lines it doesn't
    /// know, so it is read there once, the first start after the update.
pub fn read_old_options(self: *Self, own: []const u8, options_txt: []const u8) void {
}
    // rust: fn line<'a>(text: &'a str, name: &str) -> Option<&'a str> {
    // rust: text.lines().find_map(|l| {
    // rust: l.split_once(':')
    // rust: .filter(|(key, _)| *key == name)
    // rust: .map(|(_, value)| value)
    // rust: })
}
    // rust: if line(own, SKIN_LAYERS_KEY).is_none()
    // rust: && let Some(value) = line(options_txt, SKIN_LAYERS_KEY)
    // rust: {
    // rust: self.three_d_skin_layers = value == "true";
}
        // The emote key was a `key_key.emote` line of options.txt (#10092): a rebound key is kept.
    // rust: if line(own, EMOTE_KEY).is_none()
    // rust: && let Some(value) = line(options_txt, OLD_EMOTE_LINE).map(str::trim)
    // rust: && value.starts_with("key.")
    // rust: && (value == "key.keyboard.unknown"
    // rust: || crate::keybinds::key_code(value).is_some()
    // rust: || crate::keybinds::mouse_button(value).is_some())
    // rust: {
    // rust: self.emote_key = value.to_owned();
}
}
    /// Binds the extra key `name` (`SORT_KEY`); false for
    /// another name (a vanilla mapping).
pub fn set_key(self: *Self, name: []const u8, value: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: SORT_KEY => self.sort_key = value,
    // rust: crate::pvp::HUD_EDITOR_KEY => self.pvp.editor_key = value,
    // rust: _ => return false,
}
    // rust: true
}
    /// Written only once something differs from the defaults, so a vanilla
    /// setup gains no file.
pub fn save(self: *Self, dir: *Path) void {
}
    // rust: let path = dir.join(FILE);
    // rust: if *self == Self::default() && !path.exists() {
    // rust: return;
}
    // rust: let _ = fs::write(path, self.serialize());
}
}

/// The field-of-view modifier target `Camera.tickFov` eases toward: vanilla's
/// (`getFieldOfViewModifier`) divided by a mod's zoom (`native_zoom`). A
/// zoom of 1 leaves it as is.
pub fn fov_target(vanilla: f32, zoom: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if zoom == 1.0 { vanilla } else { vanilla / zoom }
}
/// Frame times over the last few seconds: frames per second, the minimum
/// and the 1% low, recomputed twice a second.
pub const FpsCounter = struct {
    /// (end time in seconds, frame milliseconds), oldest first.
    frames: VecDeque<(f64,
    shown: FpsReading,
    computed_at: f64,
};
pub const FpsReading = struct {
    fps: u32,
    min: u32,
    low: u32,
};
/// Seconds the minimum and 1% low look back.
pub const LOW_WINDOW: f64 = 5.0;
    // rust: impl Default for FpsCounter {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: frames: VecDeque::new(),
    // rust: shown: FpsReading::default(),
    // rust: computed_at: f64::NEG_INFINITY,
}
}
}
    // rust: impl FpsCounter {
    /// A frame that ended at `now` (seconds) and took `ms`.
pub fn record(self: *Self, now: f64, ms: f32) void {
}
    // rust: self.frames.push_back((now, ms));
    // rust: while self
    // rust: .frames
    // rust: .front()
    // rust: .is_some_and(|&(t, _)| now - t > LOW_WINDOW)
    // rust: {
    // rust: self.frames.pop_front();
}
    // rust: if now - self.computed_at >= 0.5 {
    // rust: self.computed_at = now;
    // rust: self.shown = self.compute(now);
}
}
pub fn compute(self: *Self, now: f64) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fps = self.frames.iter().filter(|&&(t, _)| now - t < 1.0).count() as u32;
    // rust: let mut times: Vec<f32> = self.frames.iter().map(|f| f.1).collect();
    // rust: if times.is_empty() {
    // rust: return FpsReading::default();
}
    // rust: times.sort_by(|a, b| b.total_cmp(a));
    // rust: let to_fps = |ms: f32| (1000.0 / ms.max(0.001)).round() as u32;
        // The 1% low: the frame rate of the 99th percentile frame time.
    // rust: let low = times[(times.len() - 1) / 100];
    // rust: FpsReading {
    // rust: fps,
    // rust: min: to_fps(times[0]),
    // rust: low: to_fps(low),
}
}
pub fn reading(self: *Self) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shown
}
pub fn clear(self: *Self) void {
}
    // rust: *self = Self::default();
}
}

/// Clicks of one button in the last second.
pub const Cps = struct {
    clicks: VecDeque<f64>,
};
    // rust: impl Cps {
pub fn click(self: *Self, now: f64) void {
}
    // rust: self.clicks.push_back(now);
    // rust: self.forget(now);
}
pub fn forget(self: *Self, now: f64) void {
}
    // rust: while self.clicks.front().is_some_and(|&t| now - t >= 1.0) {
    // rust: self.clicks.pop_front();
}
}
pub fn per_second(self: *Self, now: f64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.forget(now);
    // rust: self.clicks.len()
}
}
/// Two players sharing a window (`splitscreen_two`): halves this way.
pub const SPLIT_TWO: [[]const u8; 3] = ["Auto", "Side by side", "Top and bottom"];
/// Three players sharing a window (`splitscreen_three`).
pub const SPLIT_THREE: [[]const u8; 3] = ["One wide on top", "One tall on the left", "Side by side"];

/// The settings the Extras page shows, one per row.
pub const Item = enum {
    Fullbright,
    DynamicLights,
    OwnNameTag,
    HideBlockParticles,
    AutoReconnect,
    UiSoundReserve,
    /// The Music... page on Music & Sounds (`Music page`).
    MusicPage,
    MouseTweaks,
    MouseTweaksWheel,
    Sort,
    SortKey,
    /// A new chat line slides in and fades in (`Chat::layout`).
    ChatAnimation,
    /// The coloured bar at the left of a chat line.
    ChatIndicator,
    /// Not on the Extras page: Horizon Settings shows No AI, its AI Agent page Agent Control.
    NoAi,
    AgentControl,
    /// On the Horizon Settings page.
    DiscordPresence,
    /// On the AI Agent page, next to Agent Control: the F3 recording shortcuts.
    ReproKeys,
    /// On the Splitscreen settings page.
    Splitscreen,
    WheelCyclesSettings,
    /// The Select Resource Packs screen's Add button (Modrinth).
    PackBrowser,
    Pregen,
    /// Shown only while cosmetics are enabled (`horizon_cosmetics::enabled`).
    CosmeticsMine,
    CosmeticsOthers,
    CosmeticsHideFx,
    CosmeticsSolo,
    HorizonMarks,
    HorizonMe,
    /// On the PvP & HUD page (`pvp::rows`).
    Pvp(crate::pvp::Opt),
};
/// The Extras page: headers (language keys) and items.
pub fn rows() V {
    // Implementation ported from Horizon
    return undefined;
}
//     use Item::*;
    // Fullbright, Dynamic lights and Hide block-break particles change the picture: they
    // are on the graphics screen's Quality page (`graphics_ui::rows`), not here.
    // rust: let mut rows = vec![
    // rust: Err("horizon.extras.header.third_person"),
    // rust: Ok(OwnNameTag),
    // rust: Err("horizon.extras.header.inventory"),
    // rust: Ok(MouseTweaks),
    // rust: Ok(MouseTweaksWheel),
    // rust: Ok(Sort),
    // rust: Ok(SortKey),
    // rust: Err("horizon.extras.header.chat"),
    // rust: Ok(ChatAnimation),
    // rust: Ok(ChatIndicator),
    // rust: Err("horizon.extras.header.world"),
    // rust: Ok(Pregen),
    // rust: Err("horizon.extras.header.multiplayer"),
    // rust: Ok(AutoReconnect),
    // rust: Err("horizon.extras.header.sound"),
    // rust: Ok(UiSoundReserve),
    // rust: Ok(MusicPage),
    // rust: Err("horizon.extras.header.menus"),
    // rust: Ok(WheelCyclesSettings),
    // rust: Ok(PackBrowser),
    // rust: ];
    // rust: if horizon_cosmetics::enabled() {
    // rust: rows.extend([
    // rust: Err("horizon.extras.header.cosmetics"),
    // rust: Ok(CosmeticsMine),
    // rust: Ok(CosmeticsSolo),
    // rust: Ok(CosmeticsOthers),
    // rust: Ok(CosmeticsHideFx),
    // rust: Ok(HorizonMarks),
    // rust: Ok(HorizonMe),
    // rust: ]);
}
    // rust: rows
}
    // rust: impl Item {
    /// The language key of the caption (`horizon.*`, assets/horizon/lang).
pub fn caption_key(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Item::Fullbright => "horizon.extras.fullbright",
    // rust: Item::DynamicLights => "horizon.extras.dynamic_lights",
    // rust: Item::OwnNameTag => "horizon.extras.own_name_tag",
    // rust: Item::HideBlockParticles => "horizon.extras.hide_block_particles",
    // rust: Item::AutoReconnect => "horizon.extras.auto_reconnect",
    // rust: Item::UiSoundReserve => "horizon.extras.ui_sound_reserve",
    // rust: Item::MusicPage => "horizon.extras.music_page",
    // rust: Item::MouseTweaks => "horizon.extras.mouse_tweaks",
    // rust: Item::MouseTweaksWheel => "horizon.extras.mouse_tweaks_wheel",
    // rust: Item::Sort => "horizon.extras.sort",
    // rust: Item::SortKey => "horizon.extras.sort_key",
    // rust: Item::NoAi => "horizon.extras.no_ai",
    // rust: Item::AgentControl => "horizon.extras.agent_control",
    // rust: Item::ReproKeys => "horizon.extras.repro_keys",
    // rust: Item::DiscordPresence => "horizon.extras.discord_presence",
    // rust: Item::Splitscreen => "horizon.extras.splitscreen",
    // rust: Item::ChatAnimation => "horizon.extras.chat_animation",
    // rust: Item::ChatIndicator => "horizon.extras.chat_indicator",
    // rust: Item::WheelCyclesSettings => "horizon.extras.wheel_cycles_settings",
    // rust: Item::PackBrowser => "horizon.extras.pack_browser",
    // rust: Item::Pregen => "horizon.extras.pregen",
    // rust: Item::CosmeticsMine => "horizon.extras.cosmetics_mine",
    // rust: Item::CosmeticsOthers => "horizon.extras.cosmetics_others",
    // rust: Item::CosmeticsHideFx => "horizon.extras.cosmetics_hide_fx",
    // rust: Item::CosmeticsSolo => "horizon.extras.cosmetics_solo",
    // rust: Item::HorizonMarks => "horizon.extras.horizon_marks",
    // rust: Item::HorizonMe => "horizon.extras.horizon_me",
    // rust: Item::Pvp(o) => o.caption_key(),
}
}
    /// The language key of the description shown as the row's tooltip.
pub fn description_key(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Item::Fullbright => "horizon.extras.fullbright.tooltip",
    // rust: Item::DynamicLights => "horizon.extras.dynamic_lights.tooltip",
    // rust: Item::OwnNameTag => "horizon.extras.own_name_tag.tooltip",
    // rust: Item::HideBlockParticles => "horizon.extras.hide_block_particles.tooltip",
    // rust: Item::AutoReconnect => "horizon.extras.auto_reconnect.tooltip",
    // rust: Item::UiSoundReserve => "horizon.extras.ui_sound_reserve.tooltip",
    // rust: Item::MusicPage => "horizon.extras.music_page.tooltip",
    // rust: Item::MouseTweaks => "horizon.extras.mouse_tweaks.tooltip",
    // rust: Item::MouseTweaksWheel => "horizon.extras.mouse_tweaks_wheel.tooltip",
    // rust: Item::Sort => "horizon.extras.sort.tooltip",
    // rust: Item::SortKey => "horizon.extras.sort_key.tooltip",
    // rust: Item::NoAi => "horizon.extras.no_ai.tooltip",
    // rust: Item::AgentControl => "horizon.extras.agent_control.tooltip",
    // rust: Item::ReproKeys => "horizon.extras.repro_keys.tooltip",
    // rust: Item::DiscordPresence => "horizon.extras.discord_presence.tooltip",
    // rust: Item::Splitscreen => "horizon.extras.splitscreen.tooltip",
    // rust: Item::ChatAnimation => "horizon.extras.chat_animation.tooltip",
    // rust: Item::ChatIndicator => "horizon.extras.chat_indicator.tooltip",
    // rust: Item::WheelCyclesSettings => "horizon.extras.wheel_cycles_list_settings.tooltip",
    // rust: Item::PackBrowser => "horizon.extras.pack_browser.tooltip",
    // rust: Item::Pregen => "horizon.extras.pregen.tooltip",
    // rust: Item::CosmeticsMine => "horizon.extras.cosmetics_mine.tooltip",
    // rust: Item::CosmeticsOthers => "horizon.extras.cosmetics_others.tooltip",
    // rust: Item::CosmeticsHideFx => "horizon.extras.cosmetics_hide_fx.tooltip",
    // rust: Item::CosmeticsSolo => "horizon.extras.cosmetics_solo.tooltip",
    // rust: Item::HorizonMarks => "horizon.extras.horizon_marks.tooltip",
    // rust: Item::HorizonMe => "horizon.extras.horizon_me.tooltip",
    // rust: Item::Pvp(o) => o.description_key(),
}
}
    /// The caption in the current language (English when the key is missing).
pub fn caption_text(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::lang::get_or(self.caption_key(), self.caption())
}
    /// The description in the current language (English when the key is missing).
pub fn description_text(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::lang::get_or(self.description_key(), self.description())
}
    /// The English caption: the fallback of [`Item::caption_text`], and the text of
    /// `horizon.extras.*` in en_us.json.
pub fn caption(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Item::Fullbright => "Fullbright",
    // rust: Item::DynamicLights => "Dynamic lights",
    // rust: Item::OwnNameTag => "Own name tag",
    // rust: Item::HideBlockParticles => "Hide block-break particles",
    // rust: Item::AutoReconnect => "Auto-reconnect",
    // rust: Item::UiSoundReserve => "Keep channels for UI sounds",
    // rust: Item::MusicPage => "Music page",
    // rust: Item::MouseTweaks => "Mouse Tweaks controls",
    // rust: Item::MouseTweaksWheel => "Scroll wheel moves items",
    // rust: Item::Sort => "Sort buttons",
    // rust: Item::SortKey => "Sort key",
    // rust: Item::ChatAnimation => "Smooth chat",
    // rust: Item::ChatIndicator => "Message indicator",
    // rust: Item::NoAi => "No AI",
    // rust: Item::AgentControl => "Agent Control",
    // rust: Item::ReproKeys => "Recording shortcuts",
    // rust: Item::DiscordPresence => "Discord Rich Presence",
    // rust: Item::Splitscreen => "Splitscreen",
    // rust: Item::WheelCyclesSettings => "Scroll wheel changes settings",
    // rust: Item::PackBrowser => "Resource pack browser",
    // rust: Item::Pregen => "Chunk pregeneration",
    // rust: Item::CosmeticsMine => "My cosmetics",
    // rust: Item::CosmeticsOthers => "Other players' cosmetics",
    // rust: Item::CosmeticsHideFx => "Hide other players' trails and auras",
    // rust: Item::CosmeticsSolo => "In single player",
    // rust: Item::HorizonMarks => "Horizon logos",
    // rust: Item::HorizonMe => "Show me as Horizon",
    // rust: Item::Pvp(o) => o.caption(),
}
}
    /// The switch this setting belongs to: it does nothing while that is off.
pub fn parent(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
//         use Item::*;
    // rust: Some(match self {
    // rust: UiSoundReserve => return None,
    // rust: MouseTweaksWheel => MouseTweaks,
    // rust: SortKey => Sort,
    // rust: ChatIndicator => ChatAnimation,
    // rust: Pvp(o) => return o.parent().map(Pvp),
    // rust: Fullbright | DynamicLights | OwnNameTag | HideBlockParticles | MouseTweaks | Sort
    // rust: | AutoReconnect | NoAi | AgentControl | ReproKeys | DiscordPresence | Splitscreen
    // rust: | ChatAnimation | WheelCyclesSettings | MusicPage | PackBrowser | CosmeticsMine
    // rust: | CosmeticsOthers | CosmeticsHideFx | CosmeticsSolo | HorizonMarks | HorizonMe
    // rust: | Pregen => {
    // rust: return None;
}
    // rust: })
}
    /// The English description: the fallback of [`Item::description_text`].
pub fn description(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Item::Pregen => {
    // rust: "Enables /pregen in your single-player and LAN worlds. With cheats enabled, use /pregen start to generate an area before exploring it. Does not enable the command on servers you join."
}
    // rust: Item::Fullbright => "Show blocks and entities at full light, even in dark areas.",
    // rust: Item::DynamicLights => {
    // rust: "Torches and other light sources held, dropped or on fire light the blocks around them."
}
    // rust: Item::OwnNameTag => {
    // rust: "Shows your name above your head in third person, as other players see it. Hidden when the server hides your team's names or you're invisible."
}
    // rust: Item::HideBlockParticles => {
    // rust: "Hides the debris particles that burst from a broken block and crumble off the one you mine. Other particles stay."
}
    // rust: Item::AutoReconnect => {
    // rust: "Rejoins a server after a lost connection or a restart, never after a kick or ban."
}
    // rust: Item::UiSoundReserve => {
    // rust: "Sounds in the world leave 16 of the 247 sound channels free, so a flood of them (a big explosion) can't silence menu clicks."
}
    // rust: Item::MusicPage => {
    // rust: "Music & Sounds gets a Music... page: play any built-in track now, or turn one off so the game stops picking it. Nothing changes until you turn a track off."
}
    // rust: Item::MouseTweaks => {
    // rust: "Right-drag places one per slot, left-drag gathers the held item, Shift + left-drag moves every slot."
}
    // rust: Item::MouseTweaksWheel => {
    // rust: "Down sends one item of the slot to the other side, up brings one back."
}
    // rust: Item::Sort => {
    // rust: "Sorts the inventory, chests, barrels, ender chests and shulker boxes in creative tab order, merging stacks."
}
    // rust: Item::SortKey => {
    // rust: "Sorts the part under the cursor. Click, then press a key; Escape unbinds it."
}
    // rust: Item::ChatAnimation => {
    // rust: "A new chat line slides in from the left while it fades in, instead of appearing whole."
}
    // rust: Item::ChatIndicator => "The coloured bar at the left of a chat line.",
    // rust: Item::NoAi => {
    // rust: "Hides and turns off every AI feature: agent control, horizon-ctl and the MCP servers. The launcher's switch too."
}
    // rust: Item::DiscordPresence => {
    // rust: "Shows Playing Horizon on your Discord profile while Discord runs: menus, single player or multiplayer, the dimension and the time played. Never a world's name or a server's address."
}
    // rust: Item::Splitscreen => {
    // rust: "In a world, another controller can join as a new player: press A when it asks, then pick a profile and where to play."
}
    // rust: Item::AgentControl => {
    // rust: "Your own AI agent can play this game through horizon-ctl or an MCP client, on this computer only."
}
    // rust: Item::ReproKeys => {
    // rust: "F3+R starts or stops a repro recording and F3+E writes its bundle. Off by default: a recording copies the world."
}
    // rust: Item::CosmeticsMine => {
    // rust: "Hidden: every Horizon player sees you without your cosmetics, you included. The same switch as the launcher's Wardrobe."
}
    // rust: Item::CosmeticsOthers => {
    // rust: "What other Horizon players wear: everything, only their name tag styles, or nothing. Hidden unless you own cosmetics, until you choose. Hidden, the game never asks what they wear."
}
    // rust: Item::CosmeticsHideFx => {
    // rust: "Other players' trails and auras stay hidden; their other cosmetics still show. Off by default."
}
    // rust: Item::CosmeticsSolo => {
    // rust: "Show your cosmetics and your name tag's badge in your single-player worlds too (your name tag with Own name tag). Off: only on servers."
}
    // rust: Item::HorizonMarks => {
    // rust: "Show the Horizon logo next to Horizon players: a small logo before the names of other players who use Horizon, above their heads and in the player list. Only Horizon players see it: servers receive nothing."
}
    // rust: Item::HorizonMe => {
    // rust: "Show me as a Horizon player: other Horizon players see the logo by your name. On, the service answers anyone who asks about you that you played Horizon in the last 3 hours; off, it never reports you."
}
    // rust: Item::Pvp(o) => o.description(),
    // rust: Item::WheelCyclesSettings => {
    // rust: "The scroll wheel over a button in the settings changes its value, as in vanilla. Off, the wheel only scrolls the list."
}
    // rust: Item::PackBrowser => {
    // rust: "Select Resource Packs gets an Add button that searches Modrinth and installs a pack into your packs folder. Off, the game never contacts Modrinth."
}
}
}
    /// The frame-time cost the main switch of an extra shows.
pub fn cost(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::graphics_style::Cost;
    // rust: match self {
    // rust: Item::Fullbright => Some(Cost::None),
    // rust: Item::UiSoundReserve => Some(Cost::None),
    // rust: Item::MusicPage => Some(Cost::None),
    // rust: Item::DynamicLights => Some(Cost::Low),
    // rust: Item::ChatAnimation => Some(Cost::None),
    // rust: Item::OwnNameTag
    // rust: | Item::HideBlockParticles
    // rust: | Item::AutoReconnect
    // rust: | Item::MouseTweaks
    // rust: | Item::Sort
    // rust: | Item::Splitscreen
    // rust: | Item::WheelCyclesSettings
    // rust: | Item::PackBrowser => Some(Cost::None),
    // rust: Item::CosmeticsMine
    // rust: | Item::CosmeticsOthers
    // rust: | Item::CosmeticsHideFx
    // rust: | Item::CosmeticsSolo
    // rust: | Item::HorizonMarks
    // rust: | Item::HorizonMe => Some(Cost::Low),
    // rust: _ => None,
}
}
    /// On/off items and their value.
pub fn switch(self: *Self, e: *Extras) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match self {
    // rust: Item::Fullbright => e.fullbright,
    // rust: Item::DynamicLights => e.dynamic_lights,
    // rust: Item::OwnNameTag => e.own_name_tag,
    // rust: Item::HideBlockParticles => e.hide_block_particles,
    // rust: Item::AutoReconnect => e.auto_reconnect,
    // rust: Item::UiSoundReserve => e.ui_sound_reserve,
    // rust: Item::MusicPage => e.music_page,
    // rust: Item::MouseTweaks => e.mouse_tweaks,
    // rust: Item::MouseTweaksWheel => e.mouse_tweaks_wheel,
    // rust: Item::Sort => e.sort,
    // rust: Item::ChatAnimation => e.chat_animation,
    // rust: Item::ChatIndicator => e.chat_indicator,
    // rust: Item::NoAi => e.no_ai,
    // rust: Item::AgentControl => e.agent_control,
    // rust: Item::ReproKeys => e.repro_keys,
    // rust: Item::DiscordPresence => e.discord_presence,
    // rust: Item::Splitscreen => e.splitscreen,
    // rust: Item::WheelCyclesSettings => e.wheel_cycles_settings,
    // rust: Item::PackBrowser => e.pack_browser,
    // rust: Item::Pregen => e.pregen,
    // rust: Item::CosmeticsHideFx => e.cosmetics_hide_fx,
    // rust: Item::CosmeticsSolo => e.cosmetics_solo,
    // rust: Item::HorizonMarks => e.horizon_marks,
    // rust: Item::HorizonMe => e.horizon_listed,
    // rust: Item::Pvp(o) => return o.switch(&e.pvp),
    // rust: _ => return None,
    // rust: })
}
    /// The value of the other items, as their button shows it.
pub fn value(self: *Self, e: *Extras) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Item::SortKey => crate::keybinds::display_name(&e.sort_key).plain(),
    // rust: Item::Pvp(o) if o.switch(&e.pvp).is_none() => o.value(&e.pvp).unwrap_or_default(),
    // rust: Item::CosmeticsMine => match e.cosmetics_mine {
    // rust: true => crate::lang::get_or("horizon.extras.cosmetics.shown", "Shown"),
    // rust: false => crate::lang::get_or("horizon.extras.cosmetics.hidden", "Hidden"),
    // rust: },
    // rust: Item::CosmeticsOthers => {
//                 use horizon_cosmetics::prefs::Others;
    // rust: match e.effective_others() {
    // rust: Others::Shown => crate::lang::get_or("horizon.extras.cosmetics.shown", "Shown"),
    // rust: Others::NameTags => {
    // rust: crate::lang::get_or("horizon.extras.cosmetics.name_tags", "Name tags only")
}
    // rust: Others::Hidden => {
    // rust: crate::lang::get_or("horizon.extras.cosmetics.hidden", "Hidden")
}
}
}
    // rust: other => match other.switch(e) {
    // rust: Some(true) => crate::lang::get_or("On", "On"),
    // rust: _ => crate::lang::get_or("Off", "Off"),
    // rust: },
}
}
    /// A click (`back` for the right button: it turns the three-way cosmetics button the other
    /// way; every other item left is a switch, so both flip it). The sort key binds instead.
pub fn cycle(self: *Self, e: *mut Extras, back: bool) void {
}
    // rust: match self {
    // rust: Item::Fullbright => e.fullbright = !e.fullbright,
    // rust: Item::DynamicLights => e.dynamic_lights = !e.dynamic_lights,
    // rust: Item::OwnNameTag => e.own_name_tag = !e.own_name_tag,
    // rust: Item::HideBlockParticles => e.hide_block_particles = !e.hide_block_particles,
    // rust: Item::AutoReconnect => e.auto_reconnect = !e.auto_reconnect,
    // rust: Item::UiSoundReserve => e.ui_sound_reserve = !e.ui_sound_reserve,
    // rust: Item::MusicPage => e.music_page = !e.music_page,
    // rust: Item::MouseTweaks => e.mouse_tweaks = !e.mouse_tweaks,
    // rust: Item::MouseTweaksWheel => e.mouse_tweaks_wheel = !e.mouse_tweaks_wheel,
    // rust: Item::Sort => e.sort = !e.sort,
    // rust: Item::ChatAnimation => e.chat_animation = !e.chat_animation,
    // rust: Item::ChatIndicator => e.chat_indicator = !e.chat_indicator,
    // rust: Item::NoAi => e.no_ai = !e.no_ai,
    // rust: Item::AgentControl => e.agent_control = !e.agent_control,
    // rust: Item::ReproKeys => e.repro_keys = !e.repro_keys,
    // rust: Item::DiscordPresence => e.discord_presence = !e.discord_presence,
    // rust: Item::Splitscreen => e.splitscreen = !e.splitscreen,
    // rust: Item::WheelCyclesSettings => e.wheel_cycles_settings = !e.wheel_cycles_settings,
    // rust: Item::PackBrowser => e.pack_browser = !e.pack_browser,
    // rust: Item::Pregen => e.pregen = !e.pregen,
    // rust: Item::CosmeticsMine => e.cosmetics_mine = !e.cosmetics_mine,
    // rust: Item::CosmeticsOthers => {
                // From what the button shows; the result is the player's choice from now on.
    // rust: let o = e.effective_others();
    // rust: e.cosmetics_others = Some(if back { o.next().next() } else { o.next() });
}
    // rust: Item::CosmeticsHideFx => e.cosmetics_hide_fx = !e.cosmetics_hide_fx,
    // rust: Item::CosmeticsSolo => e.cosmetics_solo = !e.cosmetics_solo,
    // rust: Item::HorizonMarks => e.horizon_marks = !e.horizon_marks,
    // rust: Item::HorizonMe => e.horizon_listed = !e.horizon_listed,
    // rust: Item::Pvp(o) => o.cycle(&mut e.pvp, back),
    // rust: Item::SortKey => {}
}
}
    /// The key name the options screen waits on for a key item.
pub fn key_name(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Item::SortKey => Some(SORT_KEY),
    // rust: Item::Pvp(crate::pvp::Opt::HudEditorKey) => Some(crate::pvp::HUD_EDITOR_KEY),
    // rust: _ => None,
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn other_players_cosmetics_cycle_three_ways_and_read_the_old_switch() void {
}
//         use horizon_cosmetics::prefs::Others;
    // rust: let mut e = Extras {
    // rust: cosmetics_owner: true,
    // rust: ..Extras::default()
}
    // rust: assert_eq!(
    // rust: (e.effective_others(), e.cosmetics_hide_fx, e.cosmetics_mine),
    // rust: (Others::Shown, false, true)
    // rust: );
    // rust: Item::CosmeticsOthers.cycle(&mut e, false);
    // rust: assert_eq!(e.cosmetics_others, Some(Others::NameTags));
    // rust: Item::CosmeticsOthers.cycle(&mut e, false);
    // rust: assert_eq!(e.cosmetics_others, Some(Others::Hidden));
        // The right button goes back.
    // rust: Item::CosmeticsOthers.cycle(&mut e, true);
    // rust: assert_eq!(e.cosmetics_others, Some(Others::NameTags));
        // Ownership is the service's, never written.
    // rust: assert_eq!(
    // rust: Extras::parse(&e.serialize()),
    // rust: Extras {
    // rust: cosmetics_owner: false,
    // rust: ..e.clone()
}
    // rust: );
        // The launcher's Wardrobe writes the same lines.
    // rust: assert_eq!(
    // rust: horizon_cosmetics::prefs::Prefs::parse(&e.serialize()).others,
    // rust: Some(Others::NameTags)
    // rust: );
        // Before this, the line was on or off.
    // rust: assert_eq!(
    // rust: Extras::parse("cosmeticsOthers:false").cosmetics_others,
    // rust: Some(Others::Hidden)
    // rust: );
}

pub fn others_cosmetics_are_off_for_a_player_who_owns_none_until_chosen() void {
}
//         use horizon_cosmetics::prefs::Others;
    // rust: let mut e = Extras::default();
        // Nothing chosen, nothing owned: the button shows Hidden and no line is written.
    // rust: assert_eq!(e.effective_others(), Others::Hidden);
    // rust: assert_eq!(
    // rust: Item::CosmeticsOthers.value(&e),
    // rust: crate::lang::get_or("horizon.extras.cosmetics.hidden", "Hidden")
    // rust: );
    // rust: assert!(!e.serialize().contains("cosmeticsOthers"));
        // The service says the account owns one: shown, still not a choice.
    // rust: e.cosmetics_owner = true;
    // rust: assert_eq!(e.effective_others(), Others::Shown);
    // rust: assert!(!e.serialize().contains("cosmeticsOthers"));
        // A non-owner pressing the button goes on from Hidden, and that choice is kept.
    // rust: e.cosmetics_owner = false;
    // rust: Item::CosmeticsOthers.cycle(&mut e, false);
    // rust: assert_eq!(e.cosmetics_others, Some(Others::Shown));
    // rust: let saved = Extras::parse(&e.serialize());
    // rust: assert_eq!(saved.effective_others(), Others::Shown);
        // An owner who chose Hidden keeps it.
    // rust: let hidden = Extras {
    // rust: cosmetics_owner: true,
    // rust: ..Extras::parse("cosmeticsOthers:hidden\n")
}
    // rust: assert_eq!(hidden.effective_others(), Others::Hidden);
}

pub fn a_saved_wheel_setting_from_before_the_default_changed_is_dropped() void {
}
    // rust: assert!(!Extras::parse("wheelCyclesSettings:true\n").wheel_cycles_settings);
    // rust: let on = Extras {
    // rust: wheel_cycles_settings: true,
    // rust: ..Extras::default()
}
    // rust: assert!(Extras::parse(&on.serialize()).wheel_cycles_settings);
}

pub fn everything_is_off_by_default_and_round_trips() void {
}
    // rust: let d = Extras::default();
    // rust: assert!(!d.fullbright && !d.dynamic_lights);
    // rust: assert!(!d.zoom && !d.fps && !d.keystrokes && !d.minimap && !d.auto_reconnect);
    // rust: assert!(!d.mouse_tweaks && !d.sort && !d.own_name_tag && !d.ui_sound_reserve);
    // rust: assert!(!d.hide_block_particles && !d.pregen);
    // rust: assert!(!d.music_page && d.music_off.is_empty());
    // rust: assert!(d.discord_presence && !d.wheel_cycles_settings);
    // rust: assert_eq!(Extras::parse(""), d);
    // rust: assert_eq!(Extras::parse(&d.serialize()), d);
    // rust: let mut e = d.clone();
    // rust: Item::Fullbright.cycle(&mut e, false);
    // rust: assert_eq!(Item::Fullbright.switch(&e), Some(true));
    // rust: Item::DynamicLights.cycle(&mut e, false);
    // rust: assert_eq!(Item::DynamicLights.switch(&e), Some(true));
    // rust: assert_eq!(Extras::parse(&e.serialize()), e);
    // rust: e.zoom = true;
    // rust: e.zoom_key = "key.keyboard.c".into();
    // rust: e.zoom_level = 6;
    // rust: e.fps_corner = Corner::BottomRight;
    // rust: e.keystrokes = true;
    // rust: e.keystrokes_cps = false;
    // rust: e.moved = vec!["fps_overlay".into(), "keystrokes".into()];
    // rust: e.minimap = true;
    // rust: e.minimap_size = 128;
    // rust: e.minimap_round = true;
    // rust: e.minimap_zoom = 0.5;
    // rust: e.minimap_rotate = true;
    // rust: e.minimap_corner = Corner::BottomLeft;
    // rust: e.auto_reconnect = true;
    // rust: Item::Pregen.cycle(&mut e, false);
    // rust: assert_eq!(Item::Pregen.switch(&e), Some(true));
    // rust: Item::OwnNameTag.cycle(&mut e, false);
    // rust: assert_eq!(Item::OwnNameTag.switch(&e), Some(true));
    // rust: assert_eq!(Item::HideBlockParticles.switch(&e), Some(false));
    // rust: Item::HideBlockParticles.cycle(&mut e, false);
    // rust: assert!(e.hide_block_particles);
    // rust: assert_eq!(Item::HideBlockParticles.switch(&e), Some(true));
    // rust: let only = Extras::parse("hideBlockParticles:true\n");
    // rust: assert!(only.hide_block_particles && !only.own_name_tag);
    // rust: e.mouse_tweaks = true;
    // rust: e.mouse_tweaks_wheel = false;
    // rust: e.sort = true;
    // rust: e.sort_key = "key.keyboard.r".into();
    // rust: e.chat_animation = true;
    // rust: e.chat_indicator = false;
    // rust: e.discord_presence = false;
    // rust: assert!(!e.splitscreen);
    // rust: Item::Splitscreen.cycle(&mut e, false);
    // rust: assert_eq!(Item::Splitscreen.switch(&e), Some(true));
    // rust: Item::WheelCyclesSettings.cycle(&mut e, false);
    // rust: assert_eq!(Item::WheelCyclesSettings.switch(&e), Some(true));
    // rust: e.music_off = vec![
    // rust: "minecraft:music/game/calm1".into(),
    // rust: "minecraft:music.menu".into(),
    // rust: ];
    // rust: assert!(!e.music_page);
    // rust: Item::MusicPage.cycle(&mut e, false);
    // rust: assert_eq!(Item::MusicPage.switch(&e), Some(true));
    // rust: assert_eq!(Extras::parse(&e.serialize()), e);
}

pub fn bad_lines_keep_defaults() void {
}
    // rust: let e = Extras::parse("zoom:maybe\nzoomLevel:99\nfpsCorner:middle\nzoomKey:z\nnoise");
    // rust: assert!(!e.zoom);
    // rust: assert_eq!(e.zoom_level, 10);
    // rust: assert_eq!(e.fps_corner, Corner::TopLeft);
    // rust: assert_eq!(e.zoom_key, "key.keyboard.z");
}

pub fn a_mods_zoom_eases_like_the_spyglass() void {
}
        // Camera.tickFov halves the distance to the target each tick.
    // rust: let mut camera = crate::camera::Camera::default();
    // rust: camera.tick(None, 1.0);
    // rust: for _ in 0..30 {
    // rust: camera.tick(None, 1.0);
}
    // rust: let target = fov_target(1.0, 4.0);
    // rust: camera.tick(None, target);
    // rust: let first = camera.calculate_fov(1.0, 70, 1.0, None, Default::default(), false);
    // rust: assert!((first - 70.0 * 0.625).abs() < 1e-3, "{first}");
    // rust: for _ in 0..30 {
    // rust: camera.tick(None, target);
}
    // rust: let settled = camera.calculate_fov(1.0, 70, 1.0, None, Default::default(), false);
    // rust: assert!((settled - 70.0 / 4.0).abs() < 1e-3, "{settled}");
        // Deeper than the 0.1 floor stops there, as vanilla clamps.
    // rust: for _ in 0..30 {
    // rust: camera.tick(None, fov_target(1.0, 20.0));
}
    // rust: let floor = camera.calculate_fov(1.0, 70, 1.0, None, Default::default(), false);
    // rust: assert!((floor - 7.0).abs() < 1e-3, "{floor}");
}

pub fn fps_counter_reports_rate_minimum_and_low() void {
}
    // rust: let mut c = FpsCounter::default();
    // rust: let mut t = 0.0;
        // Two seconds at 100 fps with one 50 ms hitch.
    // rust: for i in 0..200 {
    // rust: let ms = if i == 150 { 50.0 } else { 10.0 };
    // rust: t += f64::from(ms) / 1000.0;
    // rust: c.record(t, ms);
}
    // rust: c.computed_at = f64::NEG_INFINITY;
    // rust: c.record(t + 0.01, 10.0);
    // rust: let r = c.reading();
    // rust: assert!((95..=101).contains(&r.fps), "{r:?}");
    // rust: assert_eq!(r.min, 20);
    // rust: assert_eq!(r.low, 100, "one frame in 200 is under the 1% mark");
        // Hitches beyond 1% of frames pull the 1% low down.
    // rust: let mut c = FpsCounter::default();
    // rust: let mut t = 0.0;
    // rust: for i in 0..100 {
    // rust: let ms = if i % 25 == 0 { 40.0 } else { 10.0 };
    // rust: t += f64::from(ms) / 1000.0;
    // rust: c.record(t, ms);
}
    // rust: c.computed_at = f64::NEG_INFINITY;
    // rust: c.record(t, 10.0);
    // rust: assert_eq!(c.reading().low, 25);
}

pub fn old_frames_leave_the_window() void {
}
    // rust: let mut c = FpsCounter::default();
    // rust: c.record(0.0, 100.0);
    // rust: for i in 1..=700 {
    // rust: c.record(f64::from(i) / 100.0, 10.0);
}
    // rust: assert_eq!(c.reading().min, 100, "the 100 ms frame is 7 s old");
}

pub fn cps_counts_the_last_second() void {
}
    // rust: let mut cps = Cps::default();
    // rust: for i in 0..10 {
    // rust: cps.click(f64::from(i) * 0.1);
}
    // rust: assert_eq!(cps.per_second(0.95), 10);
    // rust: assert_eq!(cps.per_second(1.25), 7);
    // rust: assert_eq!(cps.per_second(3.0), 0);
}

pub fn items_cycle_through_their_values() void {
}
    // rust: let mut e = Extras::default();
    // rust: Item::Sort.cycle(&mut e, true);
    // rust: assert_eq!(Item::Sort.value(&e), "On");
        // The minimap's old keys still parse, for the move to its mod.
    // rust: assert_eq!(
    // rust: Extras::parse("minimapSize:7\nminimapZoom:3").minimap_zoom,
    // rust: 1.0
    // rust: );
    // rust: for item in rows().into_iter().flatten() {
    // rust: assert!(!item.caption().is_empty() && !item.description().is_empty());
}
}
}
