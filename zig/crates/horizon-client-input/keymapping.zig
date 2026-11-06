//! Transpiled from Horizon Rust crate
//! Module: horizon-client-input_keymapping
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The down/click state of `KeyMapping` and `ToggleKeyMapping` (sneak,
//! sprint, attack and use can be toggled instead of held).

/// One mapping's runtime state. `toggle` is `Some(restore)` for a
/// `ToggleKeyMapping` (with its `shouldRestore` flag), `None` for a plain one.
pub const KeyState = struct {
    is_down: bool,
    click_count: i32,
    released_by_screen_when_down: bool,
    toggle: ?bool,
    keyboard: bool,
    /// Held down by a controller's toggle (Horizon's pad toggle-sneak, which
    /// vanilla has no option for): until it lets go, the mapping toggles as
    /// if its vanilla option were on, so a screen releases and restores it.
    pad_toggled: bool,
};

    // rust: impl KeyState {
pub fn plain() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: is_down: false,
    // rust: click_count: 0,
    // rust: released_by_screen_when_down: false,
    // rust: toggle: None,
    // rust: keyboard: true,
    // rust: pad_toggled: false,
}
}
    /// A `ToggleKeyMapping`; `keyboard` is whether the bound key is a keyboard key.
pub fn toggle(should_restore: bool, keyboard: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: toggle: Some(should_restore),
    // rust: keyboard,
    // rust: ..Self::plain()
}
}
    /// `KeyMapping.click`: one more pending click.
pub fn click(self: *Self) void {
}
    // rust: self.click_count += 1;
}
    /// `consumeClick`.
pub fn consume_click(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.click_count == 0 {
    // rust: false
    // rust: } else {
    // rust: self.click_count -= 1;
    // rust: true
}
}
    /// The mapping toggles: its option is on, or a pad toggled it down.
pub fn needs_toggle(self: *Self, option: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: option || self.pad_toggled
}
    /// `setDown`; `needs_toggle` is the mapping's option value.
pub fn set_down(self: *Self, down: bool, needs_toggle: bool) void {
}
    // rust: if self.toggle.is_some() && self.needs_toggle(needs_toggle) {
    // rust: if down {
    // rust: self.is_down = !self.is_down;
                // Toggled back up: the pad's toggle is over.
    // rust: self.pad_toggled &= self.is_down;
}
    // rust: } else {
    // rust: self.is_down = down;
}
}
    /// A controller's toggle button: flips the mapping like `setDown(true)`
    /// with its option on, whatever the option says.
pub fn pad_toggle(self: *Self) void {
}
    // rust: self.is_down = !self.is_down;
    // rust: self.pad_toggled = self.is_down;
}
    /// `shouldSetOnIngameFocus` for a keyboard-bound, bound key.
pub fn should_set_on_ingame_focus(self: *Self, needs_toggle: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.keyboard && (self.toggle.is_none() || !needs_toggle)
}
    /// `release` (a screen opened): drops pending clicks and the held state.
pub fn release(self: *Self, needs_toggle: bool) void {
}
    // rust: if self.toggle.is_some() {
            // ToggleKeyMapping.release does not clear pending clicks.
    // rust: if self.needs_toggle(needs_toggle) && self.is_down || self.released_by_screen_when_down
    // rust: {
    // rust: self.released_by_screen_when_down = true;
}
    // rust: self.reset();
    // rust: } else {
    // rust: self.click_count = 0;
    // rust: self.set_down(false, needs_toggle);
}
}
    /// `ToggleKeyMapping.reset`. A pad toggle stays on record, so the screen
    /// that released it restores it.
pub fn reset(self: *Self) void {
}
    // rust: self.is_down = false;
}
    /// Clicks not yet consumed.
pub fn pending_clicks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.click_count
}
    /// `shouldRestoreStateOnScreenClosed` (clears the remembered release).
pub fn should_restore_state_on_screen_closed(self: *Self, needs_toggle: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(restore) = self.toggle else {
    // rust: return false;
}
    // rust: let result = restore
    // rust: && self.needs_toggle(needs_toggle)
    // rust: && self.keyboard
    // rust: && self.released_by_screen_when_down;
    // rust: self.released_by_screen_when_down = false;
    // rust: result
}
}

/// A keyboard event (`KeyEvent.Action`): SDL reports a held key's repeats
/// as their own action.
pub const KeyAction = enum {
    Release,
    Press,
    Repeat,
};

/// Sneak.
pub const SNEAK: usize = 0;
/// Sprint.
pub const SPRINT: usize = 1;
/// Attack (mouse).
pub const ATTACK: usize = 2;

/// The `ToggleKeyMapping`s `Options` builds: sneak and sprint (keyboard,
/// restored after a screen), attack (mouse, restored) and use (mouse, not
/// restored), and the handlers that drive them. `needs_toggle` is each
/// mapping's toggle option, read at every event as vanilla does.
pub const ToggleKeys = struct {};
    // rust: impl Default for ToggleKeys {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self([
    // rust: KeyState::toggle(true, true),
    // rust: KeyState::toggle(true, true),
    // rust: KeyState::toggle(true, false),
    // rust: KeyState::toggle(false, false),
    // rust: ])
}
}
    // rust: impl ToggleKeys {
pub fn is_down(self: *Self, slot: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0[slot].is_down
}
    /// `KeyboardHandler.keyPress` for a key bound to `slot`: a release sets
    /// the mapping up (`KeyMapping.set(key, false)`); a press or a repeat
    /// with no screen open sets it down and clicks it.
pub fn key(self: *Self, slot: usize, action: KeyAction, screen_open: bool, needs_toggle: bool) void {
}
    // rust: match action {
    // rust: KeyAction::Release => self.0[slot].set_down(false, needs_toggle),
    // rust: KeyAction::Press | KeyAction::Repeat if !screen_open => {
    // rust: self.0[slot].set_down(true, needs_toggle);
    // rust: self.0[slot].click();
}
    // rust: _ => {}
}
}
    /// A controller's toggle button bound to `slot` (the pad's toggle-sneak):
    /// a press with no screen open flips the mapping and clicks it, as a
    /// key press does with the mapping's toggle option on.
pub fn pad_toggle(self: *Self, slot: usize, screen_open: bool) void {
}
    // rust: if !screen_open {
    // rust: self.0[slot].pad_toggle();
    // rust: self.0[slot].click();
}
}
    /// `MouseHandler.onButton` for a button bound to `slot`: only without a
    /// screen or overlay.
pub fn button(self: *Self, slot: usize, pressed: bool, screen_open: bool, needs_toggle: bool) void {
}
    // rust: if !screen_open {
    // rust: self.0[slot].set_down(pressed, needs_toggle);
    // rust: if pressed {
    // rust: self.0[slot].click();
}
}
}
    /// `Gui.setScreen` with a screen: `KeyMapping.releaseAll`.
pub fn screen_opened(self: *Self, needs_toggle: [bool; 4]) void {
}
    // rust: for (key, option) in self.0.iter_mut().zip(needs_toggle) {
    // rust: key.release(option);
}
}
    /// `Gui.setScreen(null)` in a level:
    /// `KeyMapping.restoreToggleStatesOnScreenClosed`.
pub fn screen_closed(self: *Self, needs_toggle: [bool; 4]) void {
}
    // rust: for (key, option) in self.0.iter_mut().zip(needs_toggle) {
    // rust: if key.should_restore_state_on_screen_closed(option) {
    // rust: key.set_down(true, option);
}
}
}
    /// `LocalPlayer.respawn`: `KeyMapping.resetToggleKeys`.
pub fn respawn(self: *Self) void {
}
    // rust: for key in &mut self.0 {
    // rust: key.reset();
            // As with the vanilla option, the death screen closing after
            // this still restores a toggle it released.
    // rust: key.pad_toggled &= key.released_by_screen_when_down;
}
}
}

    // rust: mod tests {
    /// `KeyMapping.resetToggleKeys` (a new `LocalPlayer`): a sneak and a sprint toggled on in one
    /// world are off in the next.
pub fn resetting_the_toggle_keys_puts_every_mapping_up() void {
}
    // rust: let mut keys = ToggleKeys::default();
    // rust: keys.key(0, KeyAction::Press, false, true);
    // rust: keys.key(1, KeyAction::Press, false, true);
    // rust: assert!(keys.is_down(0) && keys.is_down(1));
    // rust: for key in &mut keys.0 {
    // rust: key.reset();
}
    // rust: assert!(!keys.is_down(0) && !keys.is_down(1));
}

//     use super::*;
pub fn toggle_flips_on_press_and_ignores_release() void {
}
    // rust: let mut k = KeyState::toggle(true, true);
    // rust: k.set_down(true, true);
    // rust: assert!(k.is_down);
    // rust: k.set_down(false, true);
    // rust: assert!(k.is_down);
    // rust: k.set_down(true, true);
    // rust: assert!(!k.is_down);
}
pub fn screens_block_presses_but_not_releases() void {
}
    // rust: let mut keys = ToggleKeys::default();
    // rust: keys.key(SNEAK, KeyAction::Press, true, false);
    // rust: assert!(!keys.is_down(SNEAK));
    // rust: keys.key(SNEAK, KeyAction::Press, false, false);
    // rust: assert!(keys.is_down(SNEAK));
    // rust: keys.key(SNEAK, KeyAction::Release, true, false);
    // rust: assert!(!keys.is_down(SNEAK));
    // rust: keys.key(SPRINT, KeyAction::Press, false, true);
    // rust: keys.respawn();
    // rust: assert!(!keys.is_down(SPRINT));
}
    /// #3061: the pad's toggle-sneak (vanilla's toggle crouch off) comes
    /// back after a screen, as the vanilla option's toggle does; a
    /// keyboard shift-click in the inventory does not drop it.
pub fn pad_toggle_is_restored_after_a_screen() void {
}
    // rust: let off = [false; 4];
    // rust: let mut keys = ToggleKeys::default();
    // rust: keys.pad_toggle(SNEAK, false);
    // rust: assert!(keys.is_down(SNEAK));
    // rust: keys.screen_opened(off);
    // rust: assert!(!keys.is_down(SNEAK));
    // rust: keys.key(SNEAK, KeyAction::Press, true, false);
    // rust: keys.key(SNEAK, KeyAction::Release, true, false);
    // rust: keys.screen_closed(off);
    // rust: assert!(keys.is_down(SNEAK), "the pad's toggle is restored");
        // Toggled back up, it stays up through the next screen.
    // rust: keys.pad_toggle(SNEAK, false);
    // rust: assert!(!keys.is_down(SNEAK));
    // rust: keys.screen_opened(off);
    // rust: keys.screen_closed(off);
    // rust: assert!(!keys.is_down(SNEAK));
        // A held key is not restored, as before.
    // rust: keys.key(SNEAK, KeyAction::Press, false, false);
    // rust: keys.screen_opened(off);
    // rust: keys.key(SNEAK, KeyAction::Release, true, false);
    // rust: keys.screen_closed(off);
    // rust: assert!(!keys.is_down(SNEAK));
}
    /// After the pad's toggle is over (toggled up, or reset by a respawn
    /// with no screen to restore it), the shift key holds again.
pub fn pad_toggle_ends_with_its_release() void {
}
    // rust: let off = [false; 4];
    // rust: let mut keys = ToggleKeys::default();
    // rust: keys.pad_toggle(SNEAK, false);
    // rust: keys.respawn();
    // rust: assert!(!keys.is_down(SNEAK));
    // rust: keys.key(SNEAK, KeyAction::Press, false, false);
    // rust: keys.key(SNEAK, KeyAction::Release, false, false);
    // rust: assert!(!keys.is_down(SNEAK), "held, not toggled");
        // The death screen releases it and closes after the respawn: the
        // toggle comes back, as with the vanilla option.
    // rust: keys.pad_toggle(SNEAK, false);
    // rust: keys.screen_opened(off);
    // rust: keys.respawn();
    // rust: keys.screen_closed(off);
    // rust: assert!(keys.is_down(SNEAK));
        // A press with a screen open does nothing.
    // rust: keys.pad_toggle(SNEAK, true);
    // rust: assert!(keys.is_down(SNEAK));
}
pub fn screen_release_restores_toggled_state() void {
}
    // rust: let mut k = KeyState::toggle(true, true);
    // rust: k.set_down(true, true);
    // rust: k.release(true);
    // rust: assert!(!k.is_down);
    // rust: assert!(k.should_restore_state_on_screen_closed(true));
    // rust: assert!(!k.should_restore_state_on_screen_closed(true));
}
}
