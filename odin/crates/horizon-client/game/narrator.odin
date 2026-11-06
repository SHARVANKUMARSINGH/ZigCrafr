//! Transpiled from Horizon Rust crate
package horizon_client_narrator

import "core:fmt"
import "core:mem"
import "core:math"

// The narrator (`Minecraft.narrator`, horizon-narrator's `GameNarrator`):
// opened with the client, closed with it, and kept in step with the options
// it reads (`Options.narrator`, `getFinalSoundSourceVolume(VOICE)`); and its
// `NARRATOR_TOGGLE` toast.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: clipboard,
    // rust: hud::{HudAtlas, HudBatch},
    // rust: screen_narrator::{InputType, ScreenNarrator},
    // rust: settings::Settings,
    // rust: text::Text,
    // rust: toasts::SystemToast,
}
// use horizon_narrator::{Status, screen::Trigger};
// use winit::event::{ElementState, KeyEvent, MouseButton, WindowEvent};
// use winit::keyboard::{KeyCode, PhysicalKey};

// `Minecraft`'s constructor: `new GameNarrator`, then
// `narrator.checkStatus(options.narrator().get() != OFF)`.
    // rust: pub(super) fn start(settings: &Settings) {
    // rust: horizon_narrator::init();
    // rust: sync(settings);
    // rust: check_status(settings.narrator() != Status::Off);
}

// `GameNarrator.checkStatus`: the narrator is wanted but its speech didn't
// open. Vanilla asks in a message box whether to go on; Horizon has no
// native message box, so it logs vanilla's message and goes on, as the
// box's Continue does (the option then reads "Not Available").
check_status :: proc(required_active: bool) {
}
    // rust: if required_active && !horizon_narrator::is_active() {
    // rust: log::error!(
    // rust: "Failed to initialize text-to-speech library; continuing without the narrator. \
    // rust: If this problem persists, please report it at bugs.mojang.com"
    // rust: );
}
}

// The options the narrator reads, after they load or change: its status and
// the voice volume (master times voice).
    // rust: pub(super) fn sync(settings: &Settings) {
    // rust: horizon_narrator::set_status(settings.narrator());
    // rust: horizon_narrator::set_volume(settings.final_volume("voice"));
}

// `GameNarrator.updateNarratorStatus`, once the narrator option holds
// `status`: what was being said stops and "Narrator : <status>" is said,
// whatever the status (Off included). Then the `NARRATOR_TOGGLE` toast goes
// up, or the one still up takes the new text (`SystemToast.addOrUpdate`).
    // rust: pub(super) fn update_status(status: Status, toast: &mut Option<SystemToast>) {
    // rust: let announcement = Text::translate("options.narrator", &[])
    // rust: .append(Text::literal(" : "))
    // rust: .append(Text::translate(status.key(), &[]))
    // rust: .plain();
    // rust: horizon_narrator::update_status(status, &announcement);
    // rust: let (title, message) = horizon_narrator::toast(status, horizon_narrator::is_active());
    // rust: let tr = |key: &str| Text::translate(key, &[]).plain();
    // rust: let (title, message) = (tr(title), message.map(tr));
    // rust: match toast {
    // rust: Some(toast) => toast.reset(title, message),
    // rust: None => *toast = Some(SystemToast::new(title, message)),
}
}

// `ToastManager.update` and `extractRenderState` for the narrator toast: it
// takes the first slot `used` leaves free, slides, and is drawn there unless
// `hidden` (F1). The visibility it switched to, for its sound.
    // rust: pub(super) fn draw_toast(
    // rust: toast: &mut Option<SystemToast>,
    // rust: used: u32,
    // rust: multiplier: f64,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: hidden: bool,
    // rust: ) -> Option<bool> {
    // rust: let shown = toast.as_mut()?;
    // rust: if shown.slot.is_none() {
    // rust: shown.slot = Some((0..Game::TOAST_SLOTS).find(|s| used & (1 << s) == 0)?);
}
    // rust: let (sound, finished) = shown.update(multiplier);
    // rust: if finished {
    // rust: *toast = None;
    // rust: } else if let (false, Some(slot)) = (hidden, shown.slot) {
    // rust: shown.draw(atlas, batch, 32.0 * slot as f32);
}
    // rust: sound
}

// `KeyboardHandler.keyPress`'s narrator hotkey: a press or repeat of B
// (`shortcutKey() == 98`, the layout's letter) with the edit modifier
// (`hasControlDownWithQuirk`: Cmd on macOS, Ctrl elsewhere), unless the
// screen's focus is an edit box that takes the keys, while the narrator is
// there and the Narrator Hotkey option is on.
    // rust: pub(super) fn is_hotkey(
    // rust: pressed: bool,
    // rust: control_with_quirk: bool,
    // rust: letter: Option<char>,
    // rust: edit_box_focused: bool,
    // rust: active: bool,
    // rust: hotkey_option: bool,
    // rust: ) -> bool {
    // rust: pressed
    // rust: && !edit_box_focused
    // rust: && control_with_quirk
    // rust: && letter == Some('b')
    // rust: && active
    // rust: && hotkey_option
}

// What the open screen's narration hears of the window's input, before the
// screen takes it: `MouseHandler.onButton` (`setLastInputType(MOUSE)`,
// `afterMouseAction` on a press), `onScroll`, `handleAccumulatedMovement`
// (`afterMouseMove`), and `KeyboardHandler.keyPress` (Tab and the arrows
// set the input type; a press is `afterKeyboardAction`). The window's own
// shortcuts (fullscreen, screenshots, debug keys) never get here.
    // rust: pub(super) fn narrate_input(
    // rust: narration: &mut ScreenNarrator,
    // rust: event: &WindowEvent,
    // rust: cursor: (f32, f32),
    // rust: ) {
    // rust: match event {
    // rust: WindowEvent::KeyboardInput { event, .. } => {
    // rust: if let PhysicalKey::Code(key) = event.physical_key {
    // rust: narrate_key(narration, key, event.state == ElementState::Pressed);
    // rust: } else if event.state == ElementState::Pressed {
    // rust: narration.keyboard_action();
}
}
    // rust: WindowEvent::MouseInput { state, button, .. } => {
    // rust: narration.set_input(InputType::Mouse);
    // rust: if *state == ElementState::Pressed {
    // rust: narration.mouse_pressed(cursor, *button == MouseButton::Left);
}
}
    // rust: WindowEvent::MouseWheel { .. } => narration.mouse_action(),
    // rust: WindowEvent::CursorMoved { .. } => narration.mouse_moved(),
    // rust: _ => {}
}
}

// `KeyboardHandler.keyPress` for the narration: Tab and the arrows set the
// input type, a press is `afterKeyboardAction`. The window's keys and the
// control socket's `key` both come here.
    // rust: pub(super) fn narrate_key(narration: &mut ScreenNarrator, key: KeyCode, pressed: bool) {
    // rust: match key {
    // rust: KeyCode::Tab => narration.set_input(InputType::KeyboardTab),
    // rust: KeyCode::ArrowUp | KeyCode::ArrowDown | KeyCode::ArrowLeft | KeyCode::ArrowRight => {
    // rust: narration.set_input(InputType::KeyboardArrow)
}
    // rust: _ => {}
}
    // rust: if pressed {
    // rust: narration.keyboard_action();
}
}

// The hotkey's step: `options.narrator().set(byId(getId() + 1))`. Whether
// the narrator was off before (`wasDisabled`).
    // rust: pub(super) fn cycle_status(settings: &mut Settings) -> bool {
    // rust: let was = settings.narrator();
    // rust: settings.set_narrator(was.next());
    // rust: was == Status::Off
}

    // rust: impl Game<'_> {
    // Whether this `Game` is the window's: a server thread's `Game` shares
    // the process (and its narrator) but has no `Minecraft` to narrate for.
narrates :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.options.execution_role.is_client()
}
    // `GameNarrator.saySystemNow(message)`: cuts off what is being said.
    // rust: pub(super) fn say_system_now(&self, message: &Text) {
    // rust: if self.narrates() {
    // rust: horizon_narrator::say_system_now(&message.plain());
}
}
    // `GameNarrator.saySystemQueued(message)`.
    // rust: pub(super) fn say_system_queued(&self, message: &Text) {
    // rust: if self.narrates() {
    // rust: horizon_narrator::say_system_queued(&message.plain());
}
}
    // `GameNarrator.saySystemChatQueued(message)`.
    // rust: pub(super) fn say_system_chat_queued(&self, message: &Text) {
    // rust: if self.narrates() {
    // rust: horizon_narrator::say_system_chat_queued(&message.plain());
}
}
    // `GameNarrator.sayChatQueued(message)`, its text already made.
    // rust: pub(super) fn say_chat_queued(&self, message: &str) {
    // rust: if self.narrates() {
    // rust: horizon_narrator::say_chat_queued(message);
}
}
    // `GameNarrator.clear()`: what is being said and queued stops.
    // rust: pub(super) fn clear_narrator(&self) {
    // rust: if self.narrates() {
    // rust: horizon_narrator::clear();
}
}
    // The narrator option changed, on the options screen or by its hotkey.
    // rust: pub(super) fn narrator_status_changed(&mut self) {
    // rust: let new = self.narrator_toast.is_none();
    // rust: update_status(self.settings.narrator(), &mut self.narrator_toast);
    // rust: if new && !self.toast_allowed("system", "narrator_toggle") {
    // rust: self.narrator_toast = None;
}
}
    // The narrator hotkey on a key press or repeat, before the screen or
    // the game takes the key (it doesn't consume it): the next status,
    // announced with its toast, saved, then the screen hears of it.
    // rust: pub(super) fn narrator_hotkey(&mut self, event: &KeyEvent) {
    // rust: let letter = clipboard::shortcut_letter(&event.logical_key, event.physical_key);
    // rust: if letter != Some('b') {
    // rust: return;
}
    // rust: let hotkey = is_hotkey(
    // rust: event.state == ElementState::Pressed,
    // rust: self.has_control_down_with_quirk(),
    // rust: letter,
    // rust: self.edit_box_focused(),
    // rust: horizon_narrator::is_active(),
    // rust: self.settings.file.bool("narratorHotkey"),
    // rust: );
    // rust: if !hotkey {
    // rust: return;
}
    // rust: let was_disabled = cycle_status(&mut self.settings);
        // OptionInstance.set runs the option's onValueUpdate.
    // rust: self.narrator_status_changed();
    // rust: self.settings.save(&Self::options_path());
    // rust: self.on_narrator_status_changed(was_disabled, Trigger::Keyboard);
}
    // Where vanilla calls `screen.updateNarratorStatus(wasDisabled, trigger)`
    // on the open screen, if any: a screen's narration is scheduled 2 s
    // after the narrator came on (`NARRATE_DELAY_NARRATOR_ENABLED`) and its
    // narrator button shows the new value. Horizon's narrator buttons read
    // the option each frame.
    // rust: pub(super) fn on_narrator_status_changed(&mut self, was_disabled: bool, trigger: Trigger) {
    // rust: self.narration.status_changed(was_disabled, trigger);
}
    // The open screen's narration, once a turn after the frame's widgets
    // were read: `handleDelayedNarration` and a new screen's narration.
    // rust: pub(super) fn narrate_screen(&mut self) {
    // rust: if !self.narrates() {
    // rust: return;
}
    // rust: let pad_focus = self.pad_focus_rect();
    // rust: let gui = self.gui_size();
    // rust: self.narration.frame(gui, self.cursor, pad_focus);
}
    // `hasNoEditboxFocused`'s opposite: the open screen's focus is an
    // `EditBox` that `canConsumeInput`. The chat, command block, anvil
    // name, world options' port and rule boxes, a dialog's text input, a
    // focused options search and the title screens' fields count; a sign, a
    // book (no `EditBox`), the recipe book (its component has the focus) and
    // the creative search (focused as a widget, not as the screen's focus)
    // do not.
    // rust: pub(super) fn edit_box_focused(&mut self) -> bool {
    // rust: if self.dialog_open() {
    // rust: return self.dialog_typing();
}
    // rust: match self.screen {
    // rust: Screen::Chat if self.title.is_none() => true,
    // rust: Screen::Options => self.ui.options.typing(),
    // rust: Screen::WorldOptions => self.world_options_typing(),
    // rust: Screen::CommandBlock | Screen::Social => true,
    // rust: Screen::Inventory => self.station_typing() || self.mod_browser_typing(),
    // rust: _ => self
    // rust: .title
    // rust: .as_mut()
    // rust: .is_some_and(|t| t.has_caret_field() || t.focused_field().is_some()),
}
}
    // The narrator toast over whatever is on screen, the title's own toast
    // keeping the first slot.
    // rust: pub(super) fn draw_narrator_toast(&mut self, batch: &mut HudBatch) {
    // rust: let title = self.title.as_ref().is_some_and(|t| t.has_toast());
    // rust: let used = self.toast_slots_used() | u32::from(title);
    // rust: let multiplier = f64::from(self.settings.notification_display_time);
    // rust: let sound = draw_toast(
    // rust: &mut self.narrator_toast,
    // rust: used,
    // rust: multiplier,
    // rust: &self.gui.atlas,
    // rust: batch,
    // rust: self.ui.hide_gui,
    // rust: );
    // rust: if let Some(show) = sound {
    // rust: let event = if show { "ui.toast.in" } else { "ui.toast.out" };
    // rust: self.audio
    // rust: .play(&format!("minecraft:{event}"), None, 1.0, 1.0);
}
}
}

// `Minecraft.destroy`: `narrator.destroy()`.
    // rust: pub(super) fn stop() {
    // rust: horizon_narrator::destroy();
}

    // rust: mod tests {
//     use super::*;

the_hotkey_needs_the_modifier_b_no_edit_box_the_narrator_and_its_option :: proc() {
}
    // rust: assert!(is_hotkey(true, true, Some('b'), false, true, true));
    // rust: for (pressed, control, letter, edit_box, active, option) in [
    // rust: (false, true, Some('b'), false, true, true),
    // rust: (true, false, Some('b'), false, true, true),
    // rust: (true, true, Some('n'), false, true, true),
    // rust: (true, true, Some('b'), true, true, true),
    // rust: (true, true, Some('b'), false, false, true),
    // rust: (true, true, Some('b'), false, true, false),
    // rust: ] {
    // rust: assert!(!is_hotkey(
    // rust: pressed, control, letter, edit_box, active, option
    // rust: ));
}
}

the_hotkey_steps_through_the_statuses_and_wraps :: proc() {
}
    // rust: let mut s = Settings::default();
    // rust: assert!(cycle_status(&mut s), "Off was disabled");
    // rust: assert_eq!(s.narrator(), Status::All);
    // rust: assert!(!cycle_status(&mut s));
    // rust: assert!(!cycle_status(&mut s));
    // rust: assert_eq!(s.narrator(), Status::System);
    // rust: assert!(!cycle_status(&mut s));
    // rust: assert_eq!(s.narrator(), Status::Off);
}

    // `SystemToast.addOrUpdate`: one narrator toast, reset where it is.
a_second_change_updates_the_toast_still_up :: proc() {
}
    // rust: let mut toast = None;
    // rust: update_status(Status::All, &mut toast);
    // rust: toast.as_mut().expect("the first change shows a toast").slot = Some(2);
    // rust: update_status(Status::Off, &mut toast);
    // rust: assert_eq!(toast.expect("still the one toast").slot, Some(2));
}
}
