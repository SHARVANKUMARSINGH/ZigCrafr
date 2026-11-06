//! Transpiled from Horizon Rust crate
//! Module: horizon-client-input_modifiers
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! OS modifier reconciliation and modifiers synthesized by agent control.

// use crate::{
    // rust: keybinds::{KeyBinds, key_code},
    // rust: keymapping::{KeyAction, SNEAK, SPRINT, ToggleKeys},
}
// use std::collections::HashSet;
// use winit::keyboard::{KeyCode, ModifiersState};

    // rust: const MODIFIERS: [(ModifiersState, [KeyCode; 2]); 4] = [
    // rust: (
    // rust: ModifiersState::SHIFT,
    // rust: [KeyCode::ShiftLeft, KeyCode::ShiftRight],
    // rust: ),
    // rust: (
    // rust: ModifiersState::CONTROL,
    // rust: [KeyCode::ControlLeft, KeyCode::ControlRight],
    // rust: ),
    // rust: (ModifiersState::ALT, [KeyCode::AltLeft, KeyCode::AltRight]),
    // rust: (
    // rust: ModifiersState::SUPER,
    // rust: [KeyCode::SuperLeft, KeyCode::SuperRight],
    // rust: ),
    // rust: ];

/// A synthesized key updates the same modifier word as window events.
/// Releasing one side must preserve the other side's hold.
    // rust: pub fn set_key(
    // rust: modifiers: &mut ModifiersState,
    // rust: physical: &mut HashSet<KeyCode>,
    // rust: key: KeyCode,
    // rust: down: bool,
    // rust: ) {
    // rust: let Some((bit, pair)) = MODIFIERS.iter().find(|(_, pair)| pair.contains(&key)) else {
    // rust: return;
}
    // rust: if down {
    // rust: physical.insert(key);
    // rust: } else {
    // rust: physical.remove(&key);
}
    // rust: modifiers.set(*bit, pair.iter().any(|key| physical.contains(key)));
}

/// A modifier held for one synthesized click (the pad's Y, an agent's
/// shift-click): what [`restore`] puts back once the click is done.
pub const Held = struct {
    key: KeyCode,
    was_down: bool,
    bit: bool,
};

/// Holds `key` in both the physical keys and the modifier word, which is
/// what screens read (`InputWithModifiers.hasShiftDown`).
pub fn hold(modifiers: *mut ModifiersState, physical: *mut std.AutoHashMap(KeyCode, void), key: KeyCode) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bit = MODIFIERS
    // rust: .iter()
    // rust: .find(|(_, pair)| pair.contains(&key))
    // rust: .is_some_and(|(bit, _)| modifiers.contains(*bit));
    // rust: let held = Held {
    // rust: key,
    // rust: was_down: physical.contains(&key),
    // rust: bit,
}
    // rust: set_key(modifiers, physical, key, true);
    // rust: held
}

/// Undoes [`hold`]: a key or bit that was already down stays down.
pub fn restore(modifiers: *mut ModifiersState, physical: *mut std.AutoHashMap(KeyCode, void), held: Held) void {
}
    // rust: if !held.was_down {
    // rust: physical.remove(&held.key);
}
    // rust: if let Some((bit, _)) = MODIFIERS.iter().find(|(_, pair)| pair.contains(&held.key)) {
    // rust: modifiers.set(*bit, held.bit);
}
}

/// Recover missing modifier releases without releasing a rebound key or a pad.
/// ToggleKeyMapping itself preserves keyboard and controller toggles on release.
    // rust: pub fn reconcile(
    // rust: modifiers: ModifiersState,
    // rust: physical: &mut HashSet<KeyCode>,
    // rust: bindings: &KeyBinds,
    // rust: toggles: &mut ToggleKeys,
    // rust: options: [bool; 2],
    // rust: pad_held: [bool; 2],
    // rust: ) {
    // rust: for (bit, pair) in MODIFIERS {
    // rust: if modifiers.contains(bit) {
    // rust: continue;
}
    // rust: for key in pair {
    // rust: if !physical.remove(&key) {
    // rust: continue;
}
    // rust: for (slot, name) in [(SNEAK, "key.sneak"), (SPRINT, "key.sprint")] {
    // rust: if key_code(bindings.get(name)) == Some(key) && !pad_held[slot] {
    // rust: toggles.key(slot, KeyAction::Release, false, options[slot]);
}
}
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn modifier_taps_release_both_bits() void {
}
    // rust: let mut modifiers = ModifiersState::empty();
    // rust: let mut physical = HashSet::new();
    // rust: for (bit, pair) in MODIFIERS {
    // rust: for key in pair {
    // rust: set_key(&mut modifiers, &mut physical, key, true);
    // rust: assert!(modifiers.contains(bit));
    // rust: set_key(&mut modifiers, &mut physical, key, false);
    // rust: assert!(modifiers.is_empty());
    // rust: assert!(physical.is_empty());
}
}
}

pub fn releasing_one_side_keeps_the_other_modifier_held() void {
}
    // rust: let mut modifiers = ModifiersState::empty();
    // rust: let mut physical = HashSet::new();
    // rust: for (bit, [left, right]) in MODIFIERS {
    // rust: set_key(&mut modifiers, &mut physical, left, true);
    // rust: set_key(&mut modifiers, &mut physical, right, true);
    // rust: set_key(&mut modifiers, &mut physical, left, false);
    // rust: assert!(modifiers.contains(bit));
    // rust: set_key(&mut modifiers, &mut physical, right, false);
    // rust: assert!(modifiers.is_empty());
}
}

pub fn a_held_click_restores_the_previous_state() void {
}
    // rust: let mut modifiers = ModifiersState::empty();
    // rust: let mut physical = HashSet::new();
    // rust: let held = hold(&mut modifiers, &mut physical, KeyCode::ShiftLeft);
    // rust: assert!(modifiers.shift_key());
    // rust: restore(&mut modifiers, &mut physical, held);
    // rust: assert!(modifiers.is_empty());
    // rust: assert!(physical.is_empty());

        // Right Shift already held, or the OS word set with no physical key.
    // rust: for start in [HashSet::from([KeyCode::ShiftRight]), HashSet::new()] {
    // rust: let mut modifiers = ModifiersState::SHIFT;
    // rust: let mut physical = start.clone();
    // rust: let held = hold(&mut modifiers, &mut physical, KeyCode::ShiftLeft);
    // rust: restore(&mut modifiers, &mut physical, held);
    // rust: assert_eq!(modifiers, ModifiersState::SHIFT);
    // rust: assert_eq!(physical, start);
}
}

pub fn lost_releases_respect_rebindings_and_pad_holds() void {
}
    // rust: for slot in [SNEAK, SPRINT] {
    // rust: for rebound in [false, true] {
    // rust: for pad in [false, true] {
    // rust: for toggle in [false, true] {
    // rust: let mut bindings = KeyBinds::default();
    // rust: let (name, modifier) = if slot == SNEAK {
    // rust: ("key.sneak", KeyCode::ShiftLeft)
    // rust: } else {
    // rust: ("key.sprint", KeyCode::ControlLeft)
}
    // rust: if rebound {
    // rust: bindings.set(name, "key.keyboard.c");
}
    // rust: let mut physical = HashSet::from([modifier]);
    // rust: if rebound {
    // rust: physical.insert(KeyCode::KeyC);
}
    // rust: let mut toggles = ToggleKeys::default();
    // rust: toggles.key(slot, KeyAction::Press, false, toggle);
    // rust: let mut options = [false; 2];
    // rust: options[slot] = toggle;
    // rust: let mut pad_held = [false; 2];
    // rust: pad_held[slot] = pad;
    // rust: reconcile(
    // rust: ModifiersState::ALT,
    // rust: &mut physical,
    // rust: &bindings,
    // rust: &mut toggles,
    // rust: options,
    // rust: pad_held,
    // rust: );
    // rust: assert_eq!(toggles.is_down(slot), rebound || pad || toggle);
    // rust: assert!(!physical.contains(&modifier));
    // rust: assert_eq!(physical.contains(&KeyCode::KeyC), rebound);
}
}
}
}
}

pub fn unrelated_modifier_change_does_not_release_an_action() void {
}
    // rust: let mut toggles = ToggleKeys::default();
    // rust: toggles.key(SNEAK, KeyAction::Press, false, false);
    // rust: reconcile(
    // rust: ModifiersState::ALT,
    // rust: &mut HashSet::new(),
    // rust: &KeyBinds::default(),
    // rust: &mut toggles,
    // rust: [false; 2],
    // rust: [false; 2],
    // rust: );
    // rust: assert!(toggles.is_down(SNEAK));
}

pub fn lost_modifier_release_preserves_a_controller_toggle() void {
}
    // rust: let mut toggles = ToggleKeys::default();
    // rust: toggles.pad_toggle(SNEAK, false);
    // rust: reconcile(
    // rust: ModifiersState::empty(),
    // rust: &mut HashSet::from([KeyCode::ShiftLeft]),
    // rust: &KeyBinds::default(),
    // rust: &mut toggles,
    // rust: [false; 2],
    // rust: [false; 2],
    // rust: );
    // rust: assert!(toggles.is_down(SNEAK));
}
}
