//! Transpiled from Horizon Rust crate
//! Module: horizon-client_debug_keys
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The debug keys (26.3 `KeyboardHandler`): `key.debug.modifier` (F3) held
//! with another key runs a debug action (`handleDebugKeys`), released alone
//! it toggles the debug overlay (`key.debug.overlay`, F3 too by default);
//! with Escape it pauses without the menu; held with `key.debug.crash` (C)
//! for ten seconds it crashes the game (`tick`).
// use crate::keybinds::KeyBinds;

/// A debug mapping's action, as `handleDebugKeys` tests them.
pub const DebugAction = enum {
    ReloadChunks,
    ShowHitboxes,
    ClearChat,
    ShowChunkBorders,
    AdvancedTooltips,
    CopyRecreateCommand,
    Spectate,
    SwitchGameMode,
    DebugOptions,
    FocusPause,
    DumpDynamicTextures,
    ReloadResourcePacks,
    Profiling,
    CopyLocation,
    DumpVersion,
    ProfilingChart,
    FpsCharts,
    NetworkCharts,
    LightmapTexture,
    ImprovedTransparency,
    /// F3+R: start a repro recording, or stop it and write its bundle.
    RecordSession,
    /// F3+E: write the bundle now.
    ExportRepro,
};

/// The mappings `handleDebugKeys` tests, in its order.
    // rust: pub const ACTIONS: [(&str, DebugAction); 20] = [
    // rust: ("key.debug.reloadChunk", DebugAction::ReloadChunks),
    // rust: ("key.debug.showHitboxes", DebugAction::ShowHitboxes),
    // rust: ("key.debug.clearChat", DebugAction::ClearChat),
    // rust: ("key.debug.showChunkBorders", DebugAction::ShowChunkBorders),
    // rust: (
    // rust: "key.debug.showAdvancedTooltips",
    // rust: DebugAction::AdvancedTooltips,
    // rust: ),
    // rust: (
    // rust: "key.debug.copyRecreateCommand",
    // rust: DebugAction::CopyRecreateCommand,
    // rust: ),
    // rust: ("key.debug.spectate", DebugAction::Spectate),
    // rust: ("key.debug.switchGameMode", DebugAction::SwitchGameMode),
    // rust: ("key.debug.debugOptions", DebugAction::DebugOptions),
    // rust: ("key.debug.focusPause", DebugAction::FocusPause),
    // rust: (
    // rust: "key.debug.dumpDynamicTextures",
    // rust: DebugAction::DumpDynamicTextures,
    // rust: ),
    // rust: (
    // rust: "key.debug.reloadResourcePacks",
    // rust: DebugAction::ReloadResourcePacks,
    // rust: ),
    // rust: ("key.debug.profiling", DebugAction::Profiling),
    // rust: ("key.debug.copyLocation", DebugAction::CopyLocation),
    // rust: ("key.debug.dumpVersion", DebugAction::DumpVersion),
    // rust: ("key.debug.profilingChart", DebugAction::ProfilingChart),
    // rust: ("key.debug.fpsCharts", DebugAction::FpsCharts),
    // rust: ("key.debug.networkCharts", DebugAction::NetworkCharts),
    // rust: ("key.debug.lightmapTexture", DebugAction::LightmapTexture),
    // rust: (
    // rust: "key.debug.improvedTransparency",
    // rust: DebugAction::ImprovedTransparency,
    // rust: ),
    // rust: ];

/// Horizon's own debug keys: fixed, so they never enter the options table that
/// vanilla parity compares (`MAPPINGS`). Off until the AI Agent page enables
/// them; `Game` decides that in `debug_action`.
    // rust: const HORIZON_ACTIONS: [(&str, DebugAction); 2] = [
    // rust: ("key.keyboard.r", DebugAction::RecordSession),
    // rust: ("key.keyboard.e", DebugAction::ExportRepro),
    // rust: ];

/// GLFW's key actions.
pub const KeyAction = enum {
    Release,
    Press,
    Repeat,
};

/// The screen open when a key reaches the game (after the screen itself
/// passed on it).
pub const OpenScreen = enum {
    None,
    /// `PauseScreen` without its menu (F3+Escape).
    PauseWithoutMenu,
    GameModeSwitcher,
    Other,
};

/// What the game does for `KeyboardHandler.keyPress`.
    // rust: pub trait DebugHost {
pub fn screen(self: *Self) O;
    /// `DebugScreenEntries.toggleDebugOverlay`.
pub fn toggle_overlay(self: *Self) void;
    /// `Minecraft.pauseGame(suppressPauseMenu)`.
pub fn pause_game(self: *Self, without_menu: bool) void;
    /// One matching mapping of `handleDebugKeys`; whether its condition held
    /// (vanilla's `debugAction = true`). `shift`: `event.hasShiftDown()`.
pub fn debug_action(self: *Self, action: DebugAction, shift: bool) b;
}

/// What `KeyboardHandler.tick` reports while the debug crash keys are held.
pub const CrashNotice = enum {
    /// `debug.crash.message`, a second after the keys went down.
    Message,
    /// `debug.crash.warning` with the seconds left.
    Warning(i32),
    /// "Manually triggered debug crash".
    Crash,
};

/// `KeyboardHandler`'s state, with the down state of `keyDebugModifier`.
pub const DebugKeys = struct {
    used_debug_key_as_modifier: bool,
    /// `debugCrashKeyTime`: when the crash keys went down (milliseconds),
    /// 0 never, -1 released.
    crash_key_time: i64,
    crash_key_reported_time: i64,
    crash_key_reported_count: i64,
    /// `keyDebugModifier.isDown()`.
    modifier_down: bool,
};

    // rust: impl DebugKeys {
    /// `keyPress` once the open screen (if any) did not take the key. `key`
    /// is the physical key's name (`key.keyboard.f3`); `crash_key_down`
    /// whether the crash mapping's key is held (`InputConstants.isKeyDown`).
    /// Returns whether the key goes on to the game's key mappings
    /// (`KeyMapping.set(key, true)` and `click`): only without a screen and
    /// when it ran no debug action.
    // rust: pub fn key_press(
    // rust: &mut self,
    // rust: host: &mut impl DebugHost,
    // rust: binds: &KeyBinds,
    // rust: key: &str,
    // rust: action: KeyAction,
    // rust: shift: bool,
    // rust: crash_key_down: bool,
    // rust: now: i64,
    // rust: ) -> bool {
    // rust: let modifier = binds.get("key.debug.modifier");
    // rust: let overlay = binds.get("key.debug.overlay");
    // rust: let same = modifier == overlay;
    // rust: let modifier_down = self.modifier_down;
    // rust: let crash = binds.get("key.debug.crash") != "key.keyboard.unknown" && crash_key_down;
    // rust: if self.crash_key_time > 0 {
    // rust: if !crash || !modifier_down {
    // rust: self.crash_key_time = -1;
}
    // rust: } else if crash && modifier_down {
    // rust: self.used_debug_key_as_modifier = same;
    // rust: self.crash_key_time = now;
    // rust: self.crash_key_reported_time = now;
    // rust: self.crash_key_reported_count = 0;
}
    // rust: let screen = host.screen();
    // rust: let handles_game = screen == OpenScreen::None;
    // rust: let handles_global = handles_game
    // rust: || matches!(
    // rust: screen,
    // rust: OpenScreen::PauseWithoutMenu | OpenScreen::GameModeSwitcher
    // rust: );
    // rust: if same && key == modifier && action == KeyAction::Release {
    // rust: if self.used_debug_key_as_modifier {
    // rust: self.used_debug_key_as_modifier = false;
    // rust: } else {
    // rust: host.toggle_overlay();
}
    // rust: } else if !same && key == overlay && action == KeyAction::Press {
    // rust: host.toggle_overlay();
}
    // rust: if action == KeyAction::Release {
            // KeyMapping.set(key, false).
    // rust: if key == modifier {
    // rust: self.modifier_down = false;
}
    // rust: return false;
}
    // rust: let mut did = false;
    // rust: if handles_global && key == "key.keyboard.escape" {
    // rust: host.pause_game(modifier_down);
    // rust: did = modifier_down;
    // rust: } else if modifier_down {
    // rust: did = self.handle_debug_keys(host, binds, key, shift, now);
}
    // rust: if same {
    // rust: self.used_debug_key_as_modifier |= did;
}
        // KeyMapping.set(key, !did) for the game, setDown(!did) behind a screen.
    // rust: if key == modifier {
    // rust: self.modifier_down = !did;
}
    // rust: handles_game && !did
}
    /// `handleDebugKeys`: every debug mapping on this key, in order.
    // rust: fn handle_debug_keys(
    // rust: &mut self,
    // rust: host: &mut impl DebugHost,
    // rust: binds: &KeyBinds,
    // rust: key: &str,
    // rust: shift: bool,
    // rust: now: i64,
    // rust: ) -> bool {
        // Once the crash keys have been down a tenth of a second.
    // rust: if self.crash_key_time > 0 && self.crash_key_time < now - 100 {
    // rust: return true;
}
    // rust: let mut did = false;
    // rust: for (name, action) in ACTIONS {
    // rust: if binds.get(name) == key {
    // rust: did |= host.debug_action(action, shift);
}
}
    // rust: for (name, action) in HORIZON_ACTIONS {
    // rust: if key == name {
    // rust: did |= host.debug_action(action, shift);
}
}
    // rust: did
}
    /// `KeyboardHandler.tick`.
pub fn tick(self: *Self, now: i64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.crash_key_time <= 0 {
    // rust: return None;
}
    // rust: let remaining = 10000 - (now - self.crash_key_time);
    // rust: let reported = now - self.crash_key_reported_time;
    // rust: if remaining < 0 {
    // rust: return Some(CrashNotice::Crash);
}
    // rust: if reported >= 1000 {
    // rust: let notice = if self.crash_key_reported_count == 0 {
    // rust: CrashNotice::Message
    // rust: } else {
                // Mth.ceil(remainingTime / 1000.0F).
    // rust: CrashNotice::Warning((remaining as f32 / 1000.0).ceil() as i32)
}
    // rust: self.crash_key_reported_time = now;
    // rust: self.crash_key_reported_count += 1;
    // rust: return Some(notice);
}
    // rust: None
}
}

    // rust: mod tests {
//     use super::*;

pub const Host = struct {
    screen: ?OpenScreen,
    overlay: u32,
    paused: std.ArrayList(bool),
    actions: Vec<(DebugAction,
        /// Actions whose condition fails (no player, reduced debug info...).
    refused: std.ArrayList(DebugAction),
};
    // rust: impl DebugHost for Host {
pub fn screen(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.screen.unwrap_or(OpenScreen::None)
}
pub fn toggle_overlay(self: *Self) void {
}
    // rust: self.overlay += 1;
}
pub fn pause_game(self: *Self, without_menu: bool) void {
}
    // rust: self.paused.push(without_menu);
}
pub fn debug_action(self: *Self, action: DebugAction, shift: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.actions.push((action, shift));
    // rust: !self.refused.contains(&action)
}
}
pub const F3: []const u8 = "key.keyboard.f3";

pub fn press(k: *mut DebugKeys, h: *mut Host, b: *KeyBinds, key: []const u8, now: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: k.key_press(h, b, key, KeyAction::Press, false, false, now)
}
pub fn release(k: *mut DebugKeys, h: *mut Host, b: *KeyBinds, key: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: k.key_press(h, b, key, KeyAction::Release, false, false, 0)
}

pub fn f3_alone_toggles_the_overlay_on_release() void {
}
    // rust: let (mut k, mut h, b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
        // The F3 press goes to the game's mappings (key.debug.* are down now).
    // rust: assert!(press(&mut k, &mut h, &b, F3, 0));
    // rust: assert!(k.modifier_down);
    // rust: assert_eq!(h.overlay, 0);
    // rust: assert!(!release(&mut k, &mut h, &b, F3));
    // rust: assert_eq!(h.overlay, 1);
    // rust: assert!(!k.modifier_down);
}

pub fn a_combination_runs_its_action_and_keeps_the_overlay() void {
}
    // rust: let (mut k, mut h, b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
    // rust: press(&mut k, &mut h, &b, F3, 0);
        // F3+G: the action, and G does not reach the game.
    // rust: assert!(!press(&mut k, &mut h, &b, "key.keyboard.g", 10));
    // rust: assert_eq!(h.actions, [(DebugAction::ShowChunkBorders, false)]);
    // rust: release(&mut k, &mut h, &b, "key.keyboard.g");
    // rust: release(&mut k, &mut h, &b, F3);
    // rust: assert_eq!(h.overlay, 0);
        // The next F3 alone toggles again.
    // rust: press(&mut k, &mut h, &b, F3, 20);
    // rust: release(&mut k, &mut h, &b, F3);
    // rust: assert_eq!(h.overlay, 1);
}

pub fn c_copies_the_location_and_both_c_mappings_share_the_key() void {
}
    // rust: let (mut k, mut h, b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
    // rust: press(&mut k, &mut h, &b, F3, 0);
    // rust: k.key_press(
    // rust: &mut h,
    // rust: &b,
    // rust: "key.keyboard.c",
    // rust: KeyAction::Press,
    // rust: true,
    // rust: true,
    // rust: 5,
    // rust: );
    // rust: assert_eq!(h.actions, [(DebugAction::CopyLocation, true)]);
        // The crash keys are down: from a tenth of a second on, debug keys
        // are swallowed.
    // rust: assert_eq!(k.crash_key_time, 5);
    // rust: k.key_press(
    // rust: &mut h,
    // rust: &b,
    // rust: "key.keyboard.c",
    // rust: KeyAction::Repeat,
    // rust: false,
    // rust: true,
    // rust: 50,
    // rust: );
    // rust: assert_eq!(h.actions.len(), 2);
    // rust: assert!(!k.key_press(
    // rust: &mut h,
    // rust: &b,
    // rust: "key.keyboard.c",
    // rust: KeyAction::Repeat,
    // rust: false,
    // rust: true,
    // rust: 200
    // rust: ));
    // rust: assert_eq!(h.actions.len(), 2);
}

pub fn held_crash_keys_warn_every_second_then_crash() void {
}
    // rust: let (mut k, mut h, b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
    // rust: press(&mut k, &mut h, &b, F3, 0);
    // rust: k.key_press(
    // rust: &mut h,
    // rust: &b,
    // rust: "key.keyboard.c",
    // rust: KeyAction::Press,
    // rust: false,
    // rust: true,
    // rust: 1000,
    // rust: );
    // rust: assert_eq!(k.tick(1500), None);
    // rust: assert_eq!(k.tick(2000), Some(CrashNotice::Message));
    // rust: assert_eq!(k.tick(2999), None);
    // rust: assert_eq!(k.tick(3000), Some(CrashNotice::Warning(8)));
    // rust: assert_eq!(k.tick(4100), Some(CrashNotice::Warning(7)));
    // rust: assert_eq!(k.tick(11_000), Some(CrashNotice::Warning(0)));
    // rust: assert_eq!(k.tick(11_001), Some(CrashNotice::Crash));
        // Releasing either key stops it on the next key event.
    // rust: let mut k2 = DebugKeys::default();
    // rust: press(&mut k2, &mut h, &b, F3, 0);
    // rust: k2.key_press(
    // rust: &mut h,
    // rust: &b,
    // rust: "key.keyboard.c",
    // rust: KeyAction::Press,
    // rust: false,
    // rust: true,
    // rust: 1000,
    // rust: );
    // rust: k2.key_press(
    // rust: &mut h,
    // rust: &b,
    // rust: "key.keyboard.c",
    // rust: KeyAction::Release,
    // rust: false,
    // rust: false,
    // rust: 1200,
    // rust: );
    // rust: assert_eq!(k2.crash_key_time, -1);
    // rust: assert_eq!(k2.tick(20_000), None);
        // The crash used F3 as a modifier: its release does not toggle the overlay.
    // rust: release(&mut k2, &mut h, &b, F3);
    // rust: assert_eq!(h.overlay, 0);
}

pub fn refused_actions_do_not_count() void {
}
    // rust: let (mut k, mut h, b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
    // rust: h.refused.push(DebugAction::ShowHitboxes);
    // rust: press(&mut k, &mut h, &b, F3, 0);
        // F3+B without a player (or with reduced debug info): B reaches the
        // game and F3's release still toggles the overlay.
    // rust: assert!(press(&mut k, &mut h, &b, "key.keyboard.b", 1));
    // rust: release(&mut k, &mut h, &b, F3);
    // rust: assert_eq!(h.overlay, 1);
}

pub fn escape_pauses_with_or_without_the_menu() void {
}
    // rust: let (mut k, mut h, b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
    // rust: assert!(press(&mut k, &mut h, &b, "key.keyboard.escape", 0));
    // rust: press(&mut k, &mut h, &b, F3, 1);
    // rust: assert!(!press(&mut k, &mut h, &b, "key.keyboard.escape", 2));
    // rust: assert_eq!(h.paused, [false, true]);
    // rust: release(&mut k, &mut h, &b, F3);
    // rust: assert_eq!(h.overlay, 0);
        // Behind another screen, Escape is the screen's.
    // rust: h.screen = Some(OpenScreen::Other);
    // rust: press(&mut k, &mut h, &b, "key.keyboard.escape", 3);
    // rust: assert_eq!(h.paused.len(), 2);
}

pub fn behind_a_screen_combinations_work_but_keys_stay_with_the_screen() void {
}
    // rust: let (mut k, mut h, b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
    // rust: h.screen = Some(OpenScreen::Other);
    // rust: assert!(!press(&mut k, &mut h, &b, F3, 0));
    // rust: assert!(k.modifier_down);
    // rust: assert!(!press(&mut k, &mut h, &b, "key.keyboard.h", 1));
    // rust: assert_eq!(h.actions, [(DebugAction::AdvancedTooltips, false)]);
    // rust: release(&mut k, &mut h, &b, F3);
    // rust: assert_eq!(h.overlay, 0);
}

pub fn switcher_modifier_release_does_not_toggle_the_debug_overlay() void {
}
    // rust: let (mut k, mut h, mut b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
        // Screen release handling must also work with rebound debug keys.
    // rust: b.set("key.debug.modifier", "key.keyboard.f7");
    // rust: b.set("key.debug.overlay", "key.keyboard.f7");
    // rust: b.set("key.debug.switchGameMode", "key.keyboard.f8");
    // rust: press(&mut k, &mut h, &b, "key.keyboard.f7", 0);
    // rust: assert!(!press(&mut k, &mut h, &b, "key.keyboard.f8", 1));
    // rust: assert_eq!(h.actions, [(DebugAction::SwitchGameMode, false)]);
    // rust: h.screen = Some(OpenScreen::GameModeSwitcher);
    // rust: release(&mut k, &mut h, &b, "key.keyboard.f8");
    // rust: release(&mut k, &mut h, &b, "key.keyboard.f7");
    // rust: assert!(!k.modifier_down);
    // rust: assert_eq!(h.overlay, 0);
}

pub fn a_separate_overlay_key_toggles_on_press() void {
}
    // rust: let (mut k, mut h, mut b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
    // rust: b.set("key.debug.overlay", "key.keyboard.f7");
    // rust: press(&mut k, &mut h, &b, "key.keyboard.f7", 0);
    // rust: assert_eq!(h.overlay, 1);
    // rust: press(&mut k, &mut h, &b, F3, 1);
    // rust: release(&mut k, &mut h, &b, F3);
    // rust: assert_eq!(h.overlay, 1);
}

pub fn rebound_mappings_follow_their_keys() void {
}
    // rust: let (mut k, mut h, mut b) = (DebugKeys::default(), Host::default(), KeyBinds::default());
    // rust: b.set("key.debug.showChunkBorders", "key.keyboard.k");
    // rust: press(&mut k, &mut h, &b, F3, 0);
    // rust: assert!(press(&mut k, &mut h, &b, "key.keyboard.g", 1));
    // rust: press(&mut k, &mut h, &b, "key.keyboard.k", 2);
    // rust: assert_eq!(h.actions, [(DebugAction::ShowChunkBorders, false)]);
}
}
