//! Transpiled from Horizon Rust crate
//! Module: horizon-client-input_actions
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Every input the game names: vanilla's key mappings (`Options.keyMappings`) and Horizon's
//! pad-only actions. Held state is asked by [`Action`] ([`crate::held::HeldKeys::held`]), not by a
//! key: code that wants a mapping says which one, and every device that can hold it counts.
// use winit::keyboard::KeyCode;

    // rust: macro_rules! actions {
    // rust: ($($variant:ident, $name:literal, $key:expr;)*) => {
        /// A key mapping, or a pad-only action.
pub const Action = enum {
    // rust: $($variant,)*
};
    // rust: impl Action {
            /// In `Options.keyMappings` order, then Horizon's own mappings, the pad-only actions last.
pub const ALL: *[Action] = &[$(Action::$variant,)*];
            /// The saved name: vanilla's for a mapping, `pad.*` for Horizon's own.
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: $(Action::$variant => $name,)*
}
}
            /// The default key the game's held state keeps this action under. `None` for what
            /// isn't held as a key there: a mouse mapping, one with no default, a pad-only action,
            /// and the debug keys, which act on the physical key (`debug_keys.rs`) and whose
            /// defaults are other mappings' keys.
pub fn key(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: $(Action::$variant => $key,)*
}
}
}
}
}

    // rust: actions! {
    // rust: Attack, "key.attack", None;
    // rust: Use, "key.use", None;
    // rust: Forward, "key.forward", Some(KeyCode::KeyW);
    // rust: Left, "key.left", Some(KeyCode::KeyA);
    // rust: Back, "key.back", Some(KeyCode::KeyS);
    // rust: Right, "key.right", Some(KeyCode::KeyD);
    // rust: Jump, "key.jump", Some(KeyCode::Space);
    // rust: Sneak, "key.sneak", Some(KeyCode::ShiftLeft);
    // rust: Sprint, "key.sprint", Some(KeyCode::ControlLeft);
    // rust: Drop, "key.drop", Some(KeyCode::KeyQ);
    // rust: Inventory, "key.inventory", Some(KeyCode::KeyE);
    // rust: Chat, "key.chat", Some(KeyCode::KeyT);
    // rust: Playerlist, "key.playerlist", Some(KeyCode::Tab);
    // rust: PickItem, "key.pickItem", None;
    // rust: Command, "key.command", Some(KeyCode::Slash);
    // rust: Friends, "key.friends", Some(KeyCode::KeyO);
    // rust: SocialInteractions, "key.socialInteractions", Some(KeyCode::KeyP);
    // rust: ToggleGui, "key.toggleGui", Some(KeyCode::F1);
    // rust: ToggleSpectatorShaderEffects, "key.toggleSpectatorShaderEffects", Some(KeyCode::F4);
    // rust: Screenshot, "key.screenshot", Some(KeyCode::F2);
    // rust: TogglePerspective, "key.togglePerspective", Some(KeyCode::F5);
    // rust: SmoothCamera, "key.smoothCamera", None;
    // rust: Fullscreen, "key.fullscreen", Some(KeyCode::F11);
    // rust: SpectatorOutlines, "key.spectatorOutlines", None;
    // rust: SpectatorHotbar, "key.spectatorHotbar", None;
    // rust: SwapOffhand, "key.swapOffhand", Some(KeyCode::KeyF);
    // rust: SaveToolbarActivator, "key.saveToolbarActivator", Some(KeyCode::KeyC);
    // rust: LoadToolbarActivator, "key.loadToolbarActivator", Some(KeyCode::KeyX);
    // rust: Advancements, "key.advancements", Some(KeyCode::KeyL);
    // rust: QuickActions, "key.quickActions", Some(KeyCode::KeyG);
    // rust: DebugOverlay, "key.debug.overlay", None;
    // rust: DebugModifier, "key.debug.modifier", None;
    // rust: Hotbar1, "key.hotbar.1", Some(KeyCode::Digit1);
    // rust: Hotbar2, "key.hotbar.2", Some(KeyCode::Digit2);
    // rust: Hotbar3, "key.hotbar.3", Some(KeyCode::Digit3);
    // rust: Hotbar4, "key.hotbar.4", Some(KeyCode::Digit4);
    // rust: Hotbar5, "key.hotbar.5", Some(KeyCode::Digit5);
    // rust: Hotbar6, "key.hotbar.6", Some(KeyCode::Digit6);
    // rust: Hotbar7, "key.hotbar.7", Some(KeyCode::Digit7);
    // rust: Hotbar8, "key.hotbar.8", Some(KeyCode::Digit8);
    // rust: Hotbar9, "key.hotbar.9", Some(KeyCode::Digit9);
    // rust: DebugReloadChunk, "key.debug.reloadChunk", None;
    // rust: DebugShowHitboxes, "key.debug.showHitboxes", None;
    // rust: DebugClearChat, "key.debug.clearChat", None;
    // rust: DebugCrash, "key.debug.crash", None;
    // rust: DebugShowChunkBorders, "key.debug.showChunkBorders", None;
    // rust: DebugShowAdvancedTooltips, "key.debug.showAdvancedTooltips", None;
    // rust: DebugCopyRecreateCommand, "key.debug.copyRecreateCommand", None;
    // rust: DebugSpectate, "key.debug.spectate", None;
    // rust: DebugSwitchGameMode, "key.debug.switchGameMode", None;
    // rust: DebugDebugOptions, "key.debug.debugOptions", None;
    // rust: DebugFocusPause, "key.debug.focusPause", None;
    // rust: DebugDumpDynamicTextures, "key.debug.dumpDynamicTextures", None;
    // rust: DebugReloadResourcePacks, "key.debug.reloadResourcePacks", None;
    // rust: DebugProfiling, "key.debug.profiling", None;
    // rust: DebugCopyLocation, "key.debug.copyLocation", None;
    // rust: DebugDumpVersion, "key.debug.dumpVersion", None;
    // rust: DebugProfilingChart, "key.debug.profilingChart", None;
    // rust: DebugFpsCharts, "key.debug.fpsCharts", None;
    // rust: DebugNetworkCharts, "key.debug.networkCharts", None;
    // rust: DebugLightmapTexture, "key.debug.lightmapTexture", None;
    // rust: DebugImprovedTransparency, "key.debug.improvedTransparency", None;
    // rust: Emote, "key.emote", Some(KeyCode::KeyB);
    // rust: HotbarPrevious, "pad.hotbarPrevious", None;
    // rust: HotbarNext, "pad.hotbarNext", None;
}

    // rust: impl Action {
pub fn parse(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.iter().copied().find(|a| a.name() == name)
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::keybinds::{self, HORIZON_MAPPINGS, KeyBinds, MAPPINGS, all_mappings};

pub fn every_mapping_is_an_action_in_order() void {
}
    // rust: let names: Vec<&str> = Action::ALL.iter().map(|a| a.name()).collect();
    // rust: let mappings: Vec<&str> = MAPPINGS.iter().map(|m| m.0).collect();
    // rust: assert_eq!(names[..mappings.len()], mappings[..]);
    // rust: let horizon: Vec<&str> = HORIZON_MAPPINGS.iter().map(|m| m.0).collect();
    // rust: let end = mappings.len() + horizon.len();
    // rust: assert_eq!(names[mappings.len()..end], horizon[..]);
    // rust: for action in &names[end..] {
    // rust: assert!(action.starts_with("pad."), "{action}");
}
}

pub fn an_actions_key_is_its_mappings_default_key() void {
}
    // rust: for (name, _, category) in all_mappings() {
    // rust: let action = Action::parse(name).unwrap();
    // rust: let want = if *category == "debug" {
    // rust: None
    // rust: } else {
    // rust: keybinds::key_code(KeyBinds::default_of(name))
}
    // rust: assert_eq!(action.key(), want, "{name}");
}
}

pub fn every_bindable_action_is_an_action() void {
}
    // rust: for (name, _) in crate::gamepad::ACTIONS {
    // rust: assert!(Action::parse(name).is_some(), "{name}");
}
}
}
