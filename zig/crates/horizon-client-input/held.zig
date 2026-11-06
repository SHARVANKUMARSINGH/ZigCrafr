//! Transpiled from Horizon Rust crate
//! Module: horizon-client-input_held
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The keys a player's mappings hold, as their vanilla default keys, and which
//! devices hold each one. A key stays held while any device holds it, so one
//! device letting go (splitscreen moving the keyboard to another player, say)
//! can't release what another still presses.

// use crate::actions::Action;
// use std::collections::HashMap;
// use winit::keyboard::KeyCode;

/// Where a press came from.
pub const Source = enum {
    /// The keyboard and mouse.
    Keyboard,
    Pad,
    /// `horizon-ctl`'s `key` and `mouse` and the agent commands that walk and click.
    Agent,
};

    // rust: impl Source {
pub fn bit(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Source::Keyboard => 1,
    // rust: Source::Pad => 2,
    // rust: Source::Agent => 4,
}
}
}

pub const HeldKeys = struct {
    held: HashMap<KeyCode,
};

    // rust: impl HeldKeys {
    /// Whether anything holds this mapping: every device, whatever the mapping is bound to.
pub fn held(self: *Self, action: Action) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: action.key().is_some_and(|key| self.raw(&key))
}
    /// Whether a key that is no mapping's default is held (Right Shift, the arrows, Alt, the system
    /// key), or the key a caller already holds as a key: most code wants [`HeldKeys::held`].
pub fn raw(self: *Self, key: *KeyCode) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held.contains_key(key)
}
    /// The old way of asking, by a mapping's default key; clippy refuses it (`clippy.toml`). It
    /// stays so that a change written against it says what to use instead.
pub fn contains(self: *Self, key: *KeyCode) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.raw(key)
}
    /// `source` holds `key`. True when nothing held it before.
pub fn press(self: *Self, key: KeyCode, source: Source) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sources = self.held.entry(key).or_insert(0);
    // rust: let new = *sources == 0;
    // rust: *sources |= source.bit();
    // rust: new
}
    /// `source` lets go of `key`. True when nothing holds it any more.
pub fn release(self: *Self, key: *KeyCode, source: Source) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(sources) = self.held.get_mut(key) else {
    // rust: return true;
}
    // rust: *sources &= !source.bit();
    // rust: if *sources == 0 {
    // rust: self.held.remove(key);
    // rust: true
    // rust: } else {
    // rust: false
}
}
pub fn held_by(self: *Self, key: *KeyCode, source: Source) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held
    // rust: .get(key)
    // rust: .is_some_and(|sources| sources & source.bit() != 0)
}
    /// `source` lets go of everything: the keys nothing holds any more.
pub fn release_source(self: *Self, source: Source) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let keys: Vec<KeyCode> = self
    // rust: .held
    // rust: .iter()
    // rust: .filter(|(_, sources)| *sources & source.bit() != 0)
    // rust: .map(|(key, _)| *key)
    // rust: .collect();
    // rust: keys.into_iter()
    // rust: .filter(|key| self.release(key, source))
    // rust: .collect()
}
    /// Held, by the keyboard unless a device already holds it: for callers
    /// that don't say where the press came from.
pub fn insert(self: *Self, key: KeyCode) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.raw(&key) {
    // rust: return false;
}
    // rust: self.press(key, Source::Keyboard)
}
    /// Let go of `key` whoever holds it.
pub fn remove(self: *Self, key: *KeyCode) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held.remove(key).is_some()
}
pub fn clear(self: *Self) void {
}
    // rust: self.held.clear();
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held.is_empty()
}
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held.len()
}
pub fn iter(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held.keys()
}
}

    // rust: impl IntoIterator for HeldKeys {
    // rust: type Item = KeyCode;
    // rust: type IntoIter = std::collections::hash_map::IntoKeys<KeyCode, u8>;
pub fn into_iter(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held.into_keys()
}
}

    // rust: impl<'a> IntoIterator for &'a HeldKeys {
    // rust: type Item = &'a KeyCode;
    // rust: type IntoIter = std::collections::hash_map::Keys<'a, KeyCode, u8>;
pub fn into_iter(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held.keys()
}
}

    // rust: impl FromIterator<KeyCode> for HeldKeys {
    // rust: fn from_iter<I: IntoIterator<Item = KeyCode>>(keys: I) -> Self {
    // rust: let mut held = HeldKeys::default();
    // rust: for key in keys {
    // rust: held.insert(key);
}
    // rust: held
}
}

    // rust: mod tests {
//     use super::*;

pub fn a_key_stays_held_while_any_device_holds_it() void {
}
    // rust: let mut keys = HeldKeys::default();
    // rust: assert!(keys.press(KeyCode::Space, Source::Pad));
    // rust: assert!(!keys.press(KeyCode::Space, Source::Keyboard));
    // rust: assert!(keys.press(KeyCode::KeyW, Source::Keyboard));
    // rust: assert_eq!(keys.release_source(Source::Keyboard), vec![KeyCode::KeyW]);
    // rust: assert!(keys.held(Action::Jump) && !keys.held(Action::Forward));
    // rust: assert!(keys.held_by(&KeyCode::Space, Source::Pad));
    // rust: assert!(!keys.held_by(&KeyCode::Space, Source::Keyboard));
    // rust: assert!(keys.release(&KeyCode::Space, Source::Pad));
    // rust: assert!(keys.is_empty());
}

pub fn a_script_holds_a_key_by_itself() void {
}
    // rust: let mut keys = HeldKeys::default();
    // rust: keys.press(KeyCode::KeyW, Source::Agent);
    // rust: keys.press(KeyCode::KeyW, Source::Keyboard);
    // rust: assert!(!keys.release(&KeyCode::KeyW, Source::Keyboard));
    // rust: assert!(keys.held(Action::Forward));
    // rust: assert!(keys.release_source(Source::Pad).is_empty());
    // rust: assert_eq!(keys.release_source(Source::Agent), vec![KeyCode::KeyW]);
    // rust: assert!(!keys.held(Action::Forward));
}

pub fn untagged_inserts_and_removes_act_as_before() void {
}
    // rust: let mut keys = HeldKeys::default();
    // rust: keys.press(KeyCode::ShiftLeft, Source::Pad);
    // rust: assert!(!keys.insert(KeyCode::ShiftLeft), "already held");
    // rust: assert!(!keys.held_by(&KeyCode::ShiftLeft, Source::Keyboard));
    // rust: assert!(
    // rust: keys.remove(&KeyCode::ShiftLeft),
    // rust: "remove lets go for everyone"
    // rust: );
    // rust: assert!(!keys.held(Action::Sneak));
    // rust: assert!(keys.release(&KeyCode::KeyA, Source::Keyboard), "never held");
}
}
