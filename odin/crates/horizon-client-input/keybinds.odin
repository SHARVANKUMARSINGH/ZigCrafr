//! Transpiled from Horizon Rust crate
package horizon_client_input_keybinds

import "core:fmt"
import "core:mem"
import "core:math"

// Key mappings (Options.keyMappings): vanilla names, categories and
// defaults, `key_<name>:key.keyboard.x` persistence, display names, and the
// translation of rebound physical keys back to the default keys the game
// logic listens for.
// use std::collections::BTreeMap;
// use winit::{event::MouseButton, keyboard::KeyCode};

// (name, default key, category) in Options.keyMappings order.
    // rust: pub const MAPPINGS: &[(&str, &str, &str)] = &[
    // rust: ("key.attack", "key.mouse.left", "gameplay"),
    // rust: ("key.use", "key.mouse.right", "gameplay"),
    // rust: ("key.forward", "key.keyboard.w", "movement"),
    // rust: ("key.left", "key.keyboard.a", "movement"),
    // rust: ("key.back", "key.keyboard.s", "movement"),
    // rust: ("key.right", "key.keyboard.d", "movement"),
    // rust: ("key.jump", "key.keyboard.space", "movement"),
    // rust: ("key.sneak", "key.keyboard.left.shift", "movement"),
    // rust: ("key.sprint", "key.keyboard.left.control", "movement"),
    // rust: ("key.drop", "key.keyboard.q", "inventory"),
    // rust: ("key.inventory", "key.keyboard.e", "inventory"),
    // rust: ("key.chat", "key.keyboard.t", "multiplayer"),
    // rust: ("key.playerlist", "key.keyboard.tab", "multiplayer"),
    // rust: ("key.pickItem", "key.mouse.middle", "gameplay"),
    // rust: ("key.command", "key.keyboard.slash", "multiplayer"),
    // rust: ("key.friends", "key.keyboard.o", "multiplayer"),
    // rust: ("key.socialInteractions", "key.keyboard.p", "multiplayer"),
    // rust: ("key.toggleGui", "key.keyboard.f1", "misc"),
    // rust: (
    // rust: "key.toggleSpectatorShaderEffects",
    // rust: "key.keyboard.f4",
    // rust: "misc",
    // rust: ),
    // rust: ("key.screenshot", "key.keyboard.f2", "misc"),
    // rust: ("key.togglePerspective", "key.keyboard.f5", "misc"),
    // rust: ("key.smoothCamera", "key.keyboard.unknown", "misc"),
    // rust: ("key.fullscreen", "key.keyboard.f11", "misc"),
    // rust: ("key.spectatorOutlines", "key.keyboard.unknown", "spectator"),
    // rust: ("key.spectatorHotbar", "key.mouse.middle", "spectator"),
    // rust: ("key.swapOffhand", "key.keyboard.f", "inventory"),
    // rust: ("key.saveToolbarActivator", "key.keyboard.c", "creative"),
    // rust: ("key.loadToolbarActivator", "key.keyboard.x", "creative"),
    // rust: ("key.advancements", "key.keyboard.l", "misc"),
    // rust: ("key.quickActions", "key.keyboard.g", "misc"),
    // rust: ("key.debug.overlay", "key.keyboard.f3", "debug"),
    // rust: ("key.debug.modifier", "key.keyboard.f3", "debug"),
    // rust: ("key.hotbar.1", "key.keyboard.1", "inventory"),
    // rust: ("key.hotbar.2", "key.keyboard.2", "inventory"),
    // rust: ("key.hotbar.3", "key.keyboard.3", "inventory"),
    // rust: ("key.hotbar.4", "key.keyboard.4", "inventory"),
    // rust: ("key.hotbar.5", "key.keyboard.5", "inventory"),
    // rust: ("key.hotbar.6", "key.keyboard.6", "inventory"),
    // rust: ("key.hotbar.7", "key.keyboard.7", "inventory"),
    // rust: ("key.hotbar.8", "key.keyboard.8", "inventory"),
    // rust: ("key.hotbar.9", "key.keyboard.9", "inventory"),
    // rust: ("key.debug.reloadChunk", "key.keyboard.a", "debug"),
    // rust: ("key.debug.showHitboxes", "key.keyboard.b", "debug"),
    // rust: ("key.debug.clearChat", "key.keyboard.d", "debug"),
    // rust: ("key.debug.crash", "key.keyboard.c", "debug"),
    // rust: ("key.debug.showChunkBorders", "key.keyboard.g", "debug"),
    // rust: ("key.debug.showAdvancedTooltips", "key.keyboard.h", "debug"),
    // rust: ("key.debug.copyRecreateCommand", "key.keyboard.i", "debug"),
    // rust: ("key.debug.spectate", "key.keyboard.n", "debug"),
    // rust: ("key.debug.switchGameMode", "key.keyboard.f4", "debug"),
    // rust: ("key.debug.debugOptions", "key.keyboard.f6", "debug"),
    // rust: ("key.debug.focusPause", "key.keyboard.p", "debug"),
    // rust: ("key.debug.dumpDynamicTextures", "key.keyboard.s", "debug"),
    // rust: ("key.debug.reloadResourcePacks", "key.keyboard.t", "debug"),
    // rust: ("key.debug.profiling", "key.keyboard.l", "debug"),
    // rust: ("key.debug.copyLocation", "key.keyboard.c", "debug"),
    // rust: ("key.debug.dumpVersion", "key.keyboard.v", "debug"),
    // rust: ("key.debug.profilingChart", "key.keyboard.1", "debug"),
    // rust: ("key.debug.fpsCharts", "key.keyboard.2", "debug"),
    // rust: ("key.debug.networkCharts", "key.keyboard.3", "debug"),
    // rust: ("key.debug.lightmapTexture", "key.keyboard.4", "debug"),
    // rust: ("key.debug.improvedTransparency", "key.keyboard.x", "debug"),
    // rust: ];
// Horizon's own key mappings: bound in Controls like the vanilla ones, but kept in
// `horizon-extras.txt` (`emoteKey`), never in `options.txt`, which stays exactly vanilla's
// (`MAPPINGS` is what the options parity harness compares with the pinned client).
    // rust: pub const HORIZON_MAPPINGS: &[(&str, &str, &str)] = &[
    // The emote wheel (docs/cosmetics.md), on a key vanilla leaves free.
    // rust: ("key.emote", "key.keyboard.b", "multiplayer"),
    // rust: ];
// Every mapping the game binds: vanilla's in `Options.keyMappings` order, then Horizon's.
all_mappings :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: MAPPINGS.iter().chain(HORIZON_MAPPINGS)
}
// Mappings Options builds as `ToggleKeyMapping` (hold or toggle by option).
is_toggle :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(name, "key.sneak" | "key.sprint" | "key.use" | "key.attack")
}
// KeyMapping.Category sort order.
    // rust: pub const CATEGORIES: [&str; 8] = [
    // rust: "movement",
    // rust: "misc",
    // rust: "multiplayer",
    // rust: "gameplay",
    // rust: "inventory",
    // rust: "creative",
    // rust: "spectator",
    // rust: "debug",
    // rust: ];

// InputConstants key names <-> winit physical keys.
    // rust: const KEYS: &[(&str, KeyCode)] = &[
    // rust: ("key.keyboard.a", KeyCode::KeyA),
    // rust: ("key.keyboard.b", KeyCode::KeyB),
    // rust: ("key.keyboard.c", KeyCode::KeyC),
    // rust: ("key.keyboard.d", KeyCode::KeyD),
    // rust: ("key.keyboard.e", KeyCode::KeyE),
    // rust: ("key.keyboard.f", KeyCode::KeyF),
    // rust: ("key.keyboard.g", KeyCode::KeyG),
    // rust: ("key.keyboard.h", KeyCode::KeyH),
    // rust: ("key.keyboard.i", KeyCode::KeyI),
    // rust: ("key.keyboard.j", KeyCode::KeyJ),
    // rust: ("key.keyboard.k", KeyCode::KeyK),
    // rust: ("key.keyboard.l", KeyCode::KeyL),
    // rust: ("key.keyboard.m", KeyCode::KeyM),
    // rust: ("key.keyboard.n", KeyCode::KeyN),
    // rust: ("key.keyboard.o", KeyCode::KeyO),
    // rust: ("key.keyboard.p", KeyCode::KeyP),
    // rust: ("key.keyboard.q", KeyCode::KeyQ),
    // rust: ("key.keyboard.r", KeyCode::KeyR),
    // rust: ("key.keyboard.s", KeyCode::KeyS),
    // rust: ("key.keyboard.t", KeyCode::KeyT),
    // rust: ("key.keyboard.u", KeyCode::KeyU),
    // rust: ("key.keyboard.v", KeyCode::KeyV),
    // rust: ("key.keyboard.w", KeyCode::KeyW),
    // rust: ("key.keyboard.x", KeyCode::KeyX),
    // rust: ("key.keyboard.y", KeyCode::KeyY),
    // rust: ("key.keyboard.z", KeyCode::KeyZ),
    // rust: ("key.keyboard.1", KeyCode::Digit1),
    // rust: ("key.keyboard.2", KeyCode::Digit2),
    // rust: ("key.keyboard.3", KeyCode::Digit3),
    // rust: ("key.keyboard.4", KeyCode::Digit4),
    // rust: ("key.keyboard.5", KeyCode::Digit5),
    // rust: ("key.keyboard.6", KeyCode::Digit6),
    // rust: ("key.keyboard.7", KeyCode::Digit7),
    // rust: ("key.keyboard.8", KeyCode::Digit8),
    // rust: ("key.keyboard.9", KeyCode::Digit9),
    // rust: ("key.keyboard.0", KeyCode::Digit0),
    // rust: ("key.keyboard.enter", KeyCode::Enter),
    // rust: ("key.keyboard.escape", KeyCode::Escape),
    // rust: ("key.keyboard.backspace", KeyCode::Backspace),
    // rust: ("key.keyboard.tab", KeyCode::Tab),
    // rust: ("key.keyboard.space", KeyCode::Space),
    // rust: ("key.keyboard.minus", KeyCode::Minus),
    // rust: ("key.keyboard.equal", KeyCode::Equal),
    // rust: ("key.keyboard.left.bracket", KeyCode::BracketLeft),
    // rust: ("key.keyboard.right.bracket", KeyCode::BracketRight),
    // rust: ("key.keyboard.backslash", KeyCode::Backslash),
    // rust: ("key.keyboard.semicolon", KeyCode::Semicolon),
    // rust: ("key.keyboard.apostrophe", KeyCode::Quote),
    // rust: ("key.keyboard.grave.accent", KeyCode::Backquote),
    // rust: ("key.keyboard.comma", KeyCode::Comma),
    // rust: ("key.keyboard.period", KeyCode::Period),
    // rust: ("key.keyboard.slash", KeyCode::Slash),
    // rust: ("key.keyboard.caps.lock", KeyCode::CapsLock),
    // rust: ("key.keyboard.world.1", KeyCode::IntlBackslash),
    // rust: ("key.keyboard.international1", KeyCode::IntlRo),
    // rust: ("key.keyboard.international3", KeyCode::IntlYen),
    // rust: ("key.keyboard.lang1", KeyCode::Lang1),
    // rust: ("key.keyboard.lang2", KeyCode::Lang2),
    // rust: ("key.keyboard.lang3", KeyCode::Lang3),
    // rust: ("key.keyboard.lang4", KeyCode::Lang4),
    // rust: ("key.keyboard.lang5", KeyCode::Lang5),
    // rust: ("key.keyboard.help", KeyCode::Help),
    // rust: ("key.keyboard.select", KeyCode::Select),
    // rust: ("key.keyboard.again", KeyCode::Again),
    // rust: ("key.keyboard.undo", KeyCode::Undo),
    // rust: ("key.keyboard.cut", KeyCode::Cut),
    // rust: ("key.keyboard.copy", KeyCode::Copy),
    // rust: ("key.keyboard.paste", KeyCode::Paste),
    // rust: ("key.keyboard.find", KeyCode::Find),
    // rust: ("key.keyboard.f1", KeyCode::F1),
    // rust: ("key.keyboard.f2", KeyCode::F2),
    // rust: ("key.keyboard.f3", KeyCode::F3),
    // rust: ("key.keyboard.f4", KeyCode::F4),
    // rust: ("key.keyboard.f5", KeyCode::F5),
    // rust: ("key.keyboard.f6", KeyCode::F6),
    // rust: ("key.keyboard.f7", KeyCode::F7),
    // rust: ("key.keyboard.f8", KeyCode::F8),
    // rust: ("key.keyboard.f9", KeyCode::F9),
    // rust: ("key.keyboard.f10", KeyCode::F10),
    // rust: ("key.keyboard.f11", KeyCode::F11),
    // rust: ("key.keyboard.f12", KeyCode::F12),
    // rust: ("key.keyboard.f13", KeyCode::F13),
    // rust: ("key.keyboard.f14", KeyCode::F14),
    // rust: ("key.keyboard.f15", KeyCode::F15),
    // rust: ("key.keyboard.f16", KeyCode::F16),
    // rust: ("key.keyboard.f17", KeyCode::F17),
    // rust: ("key.keyboard.f18", KeyCode::F18),
    // rust: ("key.keyboard.f19", KeyCode::F19),
    // rust: ("key.keyboard.f20", KeyCode::F20),
    // rust: ("key.keyboard.f21", KeyCode::F21),
    // rust: ("key.keyboard.f22", KeyCode::F22),
    // rust: ("key.keyboard.f23", KeyCode::F23),
    // rust: ("key.keyboard.f24", KeyCode::F24),
    // rust: ("key.keyboard.print.screen", KeyCode::PrintScreen),
    // rust: ("key.keyboard.scroll.lock", KeyCode::ScrollLock),
    // rust: ("key.keyboard.pause", KeyCode::Pause),
    // rust: ("key.keyboard.insert", KeyCode::Insert),
    // rust: ("key.keyboard.home", KeyCode::Home),
    // rust: ("key.keyboard.page.up", KeyCode::PageUp),
    // rust: ("key.keyboard.delete", KeyCode::Delete),
    // rust: ("key.keyboard.end", KeyCode::End),
    // rust: ("key.keyboard.page.down", KeyCode::PageDown),
    // rust: ("key.keyboard.right", KeyCode::ArrowRight),
    // rust: ("key.keyboard.left", KeyCode::ArrowLeft),
    // rust: ("key.keyboard.down", KeyCode::ArrowDown),
    // rust: ("key.keyboard.up", KeyCode::ArrowUp),
    // rust: ("key.keyboard.num.lock", KeyCode::NumLock),
    // rust: ("key.keyboard.keypad.divide", KeyCode::NumpadDivide),
    // rust: ("key.keyboard.keypad.multiply", KeyCode::NumpadMultiply),
    // rust: ("key.keyboard.keypad.subtract", KeyCode::NumpadSubtract),
    // rust: ("key.keyboard.keypad.add", KeyCode::NumpadAdd),
    // rust: ("key.keyboard.keypad.enter", KeyCode::NumpadEnter),
    // rust: ("key.keyboard.keypad.1", KeyCode::Numpad1),
    // rust: ("key.keyboard.keypad.2", KeyCode::Numpad2),
    // rust: ("key.keyboard.keypad.3", KeyCode::Numpad3),
    // rust: ("key.keyboard.keypad.4", KeyCode::Numpad4),
    // rust: ("key.keyboard.keypad.5", KeyCode::Numpad5),
    // rust: ("key.keyboard.keypad.6", KeyCode::Numpad6),
    // rust: ("key.keyboard.keypad.7", KeyCode::Numpad7),
    // rust: ("key.keyboard.keypad.8", KeyCode::Numpad8),
    // rust: ("key.keyboard.keypad.9", KeyCode::Numpad9),
    // rust: ("key.keyboard.keypad.0", KeyCode::Numpad0),
    // rust: ("key.keyboard.keypad.period", KeyCode::NumpadDecimal),
    // rust: ("key.keyboard.keypad.equal", KeyCode::NumpadEqual),
    // rust: ("key.keyboard.keypad.comma", KeyCode::NumpadComma),
    // rust: ("key.keyboard.keypad.backspace", KeyCode::NumpadBackspace),
    // rust: (
    // rust: "key.keyboard.keypad.left.parenthesis",
    // rust: KeyCode::NumpadParenLeft,
    // rust: ),
    // rust: (
    // rust: "key.keyboard.keypad.right.parenthesis",
    // rust: KeyCode::NumpadParenRight,
    // rust: ),
    // rust: ("key.keyboard.keypad.hash", KeyCode::NumpadHash),
    // rust: (
    // rust: "key.keyboard.keypad.memory.store",
    // rust: KeyCode::NumpadMemoryStore,
    // rust: ),
    // rust: (
    // rust: "key.keyboard.keypad.memory.recall",
    // rust: KeyCode::NumpadMemoryRecall,
    // rust: ),
    // rust: (
    // rust: "key.keyboard.keypad.memory.clear",
    // rust: KeyCode::NumpadMemoryClear,
    // rust: ),
    // rust: ("key.keyboard.keypad.memory.add", KeyCode::NumpadMemoryAdd),
    // rust: (
    // rust: "key.keyboard.keypad.memory.subtract",
    // rust: KeyCode::NumpadMemorySubtract,
    // rust: ),
    // rust: ("key.keyboard.keypad.clear", KeyCode::NumpadClear),
    // rust: ("key.keyboard.keypad.clear.entry", KeyCode::NumpadClearEntry),
    // rust: ("key.keyboard.menu", KeyCode::ContextMenu),
    // rust: ("key.keyboard.left.control", KeyCode::ControlLeft),
    // rust: ("key.keyboard.left.shift", KeyCode::ShiftLeft),
    // rust: ("key.keyboard.left.alt", KeyCode::AltLeft),
    // rust: ("key.keyboard.left.win", KeyCode::SuperLeft),
    // rust: ("key.keyboard.right.control", KeyCode::ControlRight),
    // rust: ("key.keyboard.right.shift", KeyCode::ShiftRight),
    // rust: ("key.keyboard.right.alt", KeyCode::AltRight),
    // rust: ("key.keyboard.right.win", KeyCode::SuperRight),
    // rust: ];
key_code :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: KEYS.iter().find(|(n, _)| *n == name).map(|(_, k)| *k)
}
key_name :: proc(code: KeyCode) -> O {
    // Ported from Horizon
    return {}
}
    // rust: KEYS.iter().find(|(_, k)| *k == code).map(|(n, _)| *n)
}
mouse_name :: proc(button: MouseButton) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match button {
    // rust: MouseButton::Left => "key.mouse.left".into(),
    // rust: MouseButton::Right => "key.mouse.right".into(),
    // rust: MouseButton::Middle => "key.mouse.middle".into(),
    // rust: MouseButton::Back => "key.mouse.4".into(),
    // rust: MouseButton::Forward => "key.mouse.5".into(),
    // rust: MouseButton::Other(n) => format!("key.mouse.{}", n + 1),
}
}
mouse_button :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match name {
    // rust: "key.mouse.left" => MouseButton::Left,
    // rust: "key.mouse.right" => MouseButton::Right,
    // rust: "key.mouse.middle" => MouseButton::Middle,
    // rust: "key.mouse.4" => MouseButton::Back,
    // rust: "key.mouse.5" => MouseButton::Forward,
    // rust: _ => return None,
    // rust: })
}
    // rust: pub use horizon_client_core::key_display::display_name;

// A key event: what the layout writes on its key, without modifiers, names
// that key from now on (`key_display::learn_layout`), so an AZERTY player's
// Q key shows A.
learn_layout :: proc(event: ^winit::event::KeyEvent) {
}
//     use winit::keyboard::{Key, PhysicalKey};
//     use winit::platform::modifier_supplement::KeyEventExtModifierSupplement;
    // rust: let PhysicalKey::Code(code) = event.physical_key else {
    // rust: return;
}
    // rust: let Some(name) = key_name(code) else {
    // rust: return;
}
    // rust: let learn = horizon_client_core::key_display::learn_layout;
    // rust: match event.key_without_modifiers() {
    // rust: Key::Character(text) => learn(name, &text),
    // rust: Key::Dead(Some(c)) => learn(name, c.encode_utf8(&mut [0; 4])),
    // rust: _ => {}
}
}

// Current bindings by mapping name.
KeyBinds :: struct {
    keys: BTreeMap<^'static str,
}
    // rust: impl Default for KeyBinds {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: keys: all_mappings()
    // rust: .map(|(n, d, _)| (*n, (*d).to_owned()))
    // rust: .collect(),
}
}
}
// Each default key once, in order: two mappings that share a default key
// (Pick Block and the spectator hotbar both on the middle button) are one
// press of it, not two.
    // rust: fn distinct<T: PartialEq>(keys: Vec<T>) -> Vec<T> {
    // rust: let mut out = Vec::with_capacity(keys.len());
    // rust: for k in keys {
    // rust: if !out.contains(&k) {
    // rust: out.push(k);
}
}
    // rust: out
}

    // rust: impl KeyBinds {
get :: proc(self: ^Self, name: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.keys
    // rust: .get(name)
    // rust: .map_or("key.keyboard.unknown", String::as_str)
}
default_of :: proc(name: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: all_mappings()
    // rust: .find(|m| m.0 == name)
    // rust: .map_or("key.keyboard.unknown", |m| m.1)
}
is_default :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.get(name) == Self::default_of(name)
}
set :: proc(self: ^Self, name: string, key: string) {
}
    // rust: if let Some((n, _, _)) = all_mappings().find(|m| m.0 == name) {
    // rust: self.keys.insert(n, key.to_owned());
}
}
    // The bindings `options.txt` holds: vanilla's mappings only.
saved :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: MAPPINGS
    // rust: .iter()
    // rust: .map(|(n, _, _)| (*n, self.get(n).to_owned()))
    // rust: .collect()
}
    // Horizon's own bindings, for `horizon-extras.txt`.
horizon_saved :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: HORIZON_MAPPINGS
    // rust: .iter()
    // rust: .map(|(n, _, _)| (*n, self.get(n).to_owned()))
    // rust: .collect()
}
reset_all :: proc(self: ^Self) {
}
    // rust: *self = Self::default();
}
    // Mappings sharing `name`'s key (KeyMapping.same), for conflict marks.
conflicts :: proc(self: ^Self, name: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let key = self.get(name);
    // rust: if key == "key.keyboard.unknown" {
    // rust: return Vec::new();
}
    // rust: all_mappings()
    // rust: .filter(|(n, _, _)| {
    // rust: *n != name && self.get(n) == key && (!self.is_default(n) || !self.is_default(name))
    // rust: })
    // rust: .map(|(n, _, _)| *n)
    // rust: .collect()
}
    // The mapping a physical input triggers (first in list order).
mapping_for :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.mappings_for(key).next()
}
    // Every mapping a physical input triggers, in list order: like
    // `KeyMapping.set`/`click`, one key drives all the mappings bound to it.
    // rust: pub fn mappings_for<'a>(&'a self, key: &'a str) -> impl Iterator<Item = &'static str> + 'a {
    // rust: all_mappings()
    // rust: .map(|m| m.0)
    // rust: .filter(move |n| self.get(n) == key)
}
    // The mappings bound to `key` that [`KeyBinds::translate_all`] follows:
    // all but the debug keys. Those act only with F3 held
    // (`KeyboardHandler.handleDebugKeys`, `debug_keys.rs` reads the physical
    // key and the binding itself); their defaults (A, S, D, T, L, 1 to 4...)
    // would otherwise turn the key back into its old gameplay meaning.
    // rust: fn translated_mappings<'a>(&'a self, key: &'a str) -> impl Iterator<Item = &'static str> + 'a {
    // rust: all_mappings()
    // rust: .filter(|m| m.2 != "debug")
    // rust: .map(|m| m.0)
    // rust: .filter(move |n| self.get(n) == key)
}
    // Whether a mapping (other than a debug key) whose default is `key` was
    // bound elsewhere.
default_moved :: proc(self: ^Self, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: all_mappings().any(|(n, d, c)| *d == key && *c != "debug" && !self.is_default(n))
}
    // Translate a physical key into the default key of the mapping it is
    // bound to, so game code written against vanilla defaults follows the
    // player's bindings. `None` means the key now does nothing; mouse
    // mappings bound to keys come back as `Err(button)`. The first of
    // [`KeyBinds::translate_all`].
translate :: proc(self: ^Self, key: KeyCode) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.translate_all(key).into_iter().next()
}
    // The default keys of every mapping `key` is bound to (empty when it
    // now does nothing), so a key bound to two mappings (forward and
    // sprint) drives both, as `KeyMapping.set` does.
translate_all :: proc(self: ^Self, key: KeyCode) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(name) = key_name(key) else {
    // rust: return vec![Ok(key)];
}
    // rust: let bound: Vec<_> = self
    // rust: .translated_mappings(name)
    // rust: .filter_map(|mapping| {
    // rust: let default = Self::default_of(mapping);
    // rust: match key_code(default) {
    // rust: Some(code) => Some(Ok(code)),
    // rust: None => mouse_button(default).map(Err),
}
    // rust: })
    // rust: .collect();
    // rust: if !bound.is_empty() {
    // rust: return distinct(bound);
}
        // An unbound key whose default meaning was moved elsewhere is inert.
    // rust: if self.default_moved(name) {
    // rust: return Vec::new();
}
    // rust: vec![Ok(key)]
}
    // `Minecraft.handleKeybinds`: key.pickItem and key.spectatorHotbar share the middle button by
    // default and are separate mappings, so a press of what `input` is bound to acts only as the
    // one this player can use: the spectator hotbar for a spectator, pick block otherwise. (Pick
    // block does nothing a spectator would see.)
middle_acts :: proc(self: ^Self, input: string, spectator: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mapping = if spectator {
    // rust: "key.spectatorHotbar"
    // rust: } else {
    // rust: "key.pickItem"
}
    // rust: self.get(mapping) == input
}
    // Translate a mouse button the same way (keys bound to mouse buttons).
translate_mouse :: proc(self: ^Self, button: MouseButton) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.translate_mouse_all(button).into_iter().next()
}
    // [`KeyBinds::translate_all`] for a mouse button.
translate_mouse_all :: proc(self: ^Self, button: MouseButton) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let name = mouse_name(button);
    // rust: let bound: Vec<_> = self
    // rust: .translated_mappings(&name)
    // rust: .filter_map(|mapping| {
    // rust: let default = Self::default_of(mapping);
    // rust: match mouse_button(default) {
    // rust: Some(b) => Some(Err(b)),
    // rust: None => key_code(default).map(Ok),
}
    // rust: })
    // rust: .collect();
    // rust: if !bound.is_empty() {
    // rust: return distinct(bound);
}
    // rust: if self.default_moved(&name) {
    // rust: return Vec::new();
}
    // rust: vec![Err(button)]
}
    // `AbstractContainerScreen.checkHotbarMouseClicked`: off hand, then hotbar.
container_mouse_key :: proc(self: ^Self, button: MouseButton, creative: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = mouse_name(button);
    // rust: if matches!(button, MouseButton::Left | MouseButton::Right)
    // rust: || (creative && self.get("key.pickItem") == name)
    // rust: {
    // rust: return None;
}
    // rust: std::iter::once("key.swapOffhand")
    // rust: .chain(
    // rust: MAPPINGS
    // rust: .iter()
    // rust: .map(|m| m.0)
    // rust: .filter(|n| n.starts_with("key.hotbar.")),
    // rust: )
    // rust: .find(|mapping| self.get(mapping) == name)
    // rust: .and_then(|mapping| key_code(Self::default_of(mapping)))
}
    // `AbstractContainerScreen.checkHotbarKeyPressed`: the off hand and the
    // hotbar slots, as the controls bind them now. Answers the key the menu
    // acts on (`KeyF` for the off hand, `DigitN` for a slot), so a rebound key
    // swaps instead of reaching the screen.
container_hotbar_key :: proc(self: ^Self, key: KeyCode) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = key_name(key)?;
    // rust: if self.get("key.swapOffhand") == name {
    // rust: return Some(KeyCode::KeyF);
}
    // rust: MAPPINGS
    // rust: .iter()
    // rust: .filter(|m| m.0.starts_with("key.hotbar."))
    // rust: .find(|m| self.get(m.0) == name)
    // rust: .and_then(|m| key_code(Self::default_of(m.0)))
}
}

    // rust: mod tests {
//     use super::*;

mappings_sharing_the_middle_button_act_as_themselves :: proc() {
}
    // rust: let middle = "key.mouse.middle";
    // rust: let z = "key.keyboard.z";
    // rust: let mut keys = KeyBinds::default();
    // rust: assert!(keys.middle_acts(middle, false) && keys.middle_acts(middle, true));
        // The spectator hotbar on Z: the middle button only picks, and Z never picks.
    // rust: keys.set("key.spectatorHotbar", z);
    // rust: assert!(keys.middle_acts(middle, false));
    // rust: assert!(!keys.middle_acts(middle, true));
    // rust: assert!(keys.middle_acts(z, true));
    // rust: assert!(!keys.middle_acts(z, false));
        // Pick block on Z instead: the other way round.
    // rust: keys.reset_all();
    // rust: keys.set("key.pickItem", z);
    // rust: assert!(keys.middle_acts(z, false));
    // rust: assert!(!keys.middle_acts(z, true));
    // rust: assert!(keys.middle_acts(middle, true));
    // rust: assert!(!keys.middle_acts(middle, false));
}
container_mouse_hotkeys_follow_slot_bindings_and_pick_item_priority :: proc() {
}
    // rust: for button in [MouseButton::Back, MouseButton::Forward, MouseButton::Middle] {
    // rust: for (mapping, default, _) in MAPPINGS.iter().filter(|m| m.0.starts_with("key.hotbar."))
    // rust: {
    // rust: let mut keys = KeyBinds::default();
    // rust: keys.set(mapping, &mouse_name(button));
    // rust: assert_eq!(keys.container_mouse_key(button, false), key_code(default));
    // rust: assert_eq!(
    // rust: keys.container_mouse_key(button, true),
    // rust: if button == MouseButton::Middle {
    // rust: None
    // rust: } else {
    // rust: key_code(default)
}
    // rust: );
}
}
    // rust: let mut keys = KeyBinds::default();
    // rust: keys.set("key.hotbar.1", "key.mouse.4");
    // rust: keys.set("key.swapOffhand", "key.mouse.4");
    // rust: assert_eq!(
    // rust: keys.container_mouse_key(MouseButton::Back, false),
    // rust: Some(KeyCode::KeyF)
    // rust: );
    // rust: keys.set("key.hotbar.2", "key.mouse.left");
    // rust: assert_eq!(keys.container_mouse_key(MouseButton::Left, false), None);
    // rust: assert_eq!(keys.container_mouse_key(MouseButton::Right, false), None);
    // rust: assert_eq!(keys.container_mouse_key(MouseButton::Forward, false), None);
}

container_hotkeys_follow_the_bound_keys :: proc() {
}
    // rust: let mut keys = KeyBinds::default();
    // rust: assert_eq!(
    // rust: keys.container_hotbar_key(KeyCode::KeyF),
    // rust: Some(KeyCode::KeyF)
    // rust: );
    // rust: assert_eq!(
    // rust: keys.container_hotbar_key(KeyCode::Digit3),
    // rust: Some(KeyCode::Digit3)
    // rust: );
    // rust: assert_eq!(keys.container_hotbar_key(KeyCode::Tab), None);
        // The report's key: bound to the off hand, the menu takes it first.
    // rust: keys.set("key.swapOffhand", "key.keyboard.tab");
    // rust: assert_eq!(keys.container_hotbar_key(KeyCode::Tab), Some(KeyCode::KeyF));
    // rust: assert_eq!(keys.container_hotbar_key(KeyCode::KeyF), None);
    // rust: keys.set("key.hotbar.3", "key.keyboard.t");
    // rust: assert_eq!(
    // rust: keys.container_hotbar_key(KeyCode::KeyT),
    // rust: Some(KeyCode::Digit3)
    // rust: );
}

rebinding_translates_to_defaults :: proc() {
}
    // rust: let mut k = KeyBinds::default();
    // rust: assert_eq!(k.translate(KeyCode::KeyW), Some(Ok(KeyCode::KeyW)));
        // Forward on the up arrow, inventory on W.
    // rust: k.set("key.forward", "key.keyboard.up");
    // rust: k.set("key.inventory", "key.keyboard.w");
    // rust: assert_eq!(k.translate(KeyCode::ArrowUp), Some(Ok(KeyCode::KeyW)));
    // rust: assert_eq!(k.translate(KeyCode::KeyW), Some(Ok(KeyCode::KeyE)));
        // E's default meaning moved and nothing else uses it.
    // rust: assert_eq!(k.translate(KeyCode::KeyE), None);
        // Attack on a key.
    // rust: k.set("key.attack", "key.keyboard.r");
    // rust: assert_eq!(k.translate(KeyCode::KeyR), Some(Err(MouseButton::Left)));
    // rust: assert_eq!(k.translate_mouse(MouseButton::Left), None);
    // rust: assert_eq!(k.translate(KeyCode::Escape), Some(Ok(KeyCode::Escape)));
    // rust: assert!(k.conflicts("key.forward").is_empty());
    // rust: k.set("key.jump", "key.keyboard.up");
    // rust: assert_eq!(k.conflicts("key.forward"), ["key.jump"]);
}
a_moved_key_keeps_no_default_action :: proc() {
}
        // #3158: the debug keys (F3+A, F3+1...) share these keys' defaults,
        // and must not hand them back their gameplay meaning.
    // rust: let mut k = KeyBinds::default();
    // rust: k.set("key.hotbar.1", "key.keyboard.q");
    // rust: assert_eq!(k.translate_all(KeyCode::Digit1), []);
    // rust: assert_eq!(
    // rust: k.translate_all(KeyCode::KeyQ),
    // rust: [Ok(KeyCode::KeyQ), Ok(KeyCode::Digit1)]
    // rust: );
    // rust: k.set("key.inventory", "key.keyboard.a");
    // rust: k.set("key.left", "key.keyboard.e");
    // rust: assert_eq!(k.translate_all(KeyCode::KeyA), [Ok(KeyCode::KeyE)]);
    // rust: assert_eq!(k.translate_all(KeyCode::KeyE), [Ok(KeyCode::KeyA)]);
    // rust: k.set("key.back", "key.keyboard.down");
    // rust: assert_eq!(k.translate_all(KeyCode::KeyS), []);
        // Keys left alone still act, and a moved debug key changes nothing.
    // rust: k.set("key.debug.fpsCharts", "key.keyboard.9");
    // rust: assert_eq!(k.translate_all(KeyCode::Digit2), [Ok(KeyCode::Digit2)]);
    // rust: assert_eq!(k.translate_all(KeyCode::Digit9), [Ok(KeyCode::Digit9)]);
    // rust: assert_eq!(k.translate_all(KeyCode::F3), [Ok(KeyCode::F3)]);
}
display_names :: proc() {
}
    // rust: assert_eq!(display_name("key.keyboard.w").plain(), "W");
    // rust: assert_eq!(display_name("key.keyboard.slash").plain(), "/");
}
}
