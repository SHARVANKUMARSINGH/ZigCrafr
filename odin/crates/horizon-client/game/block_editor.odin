//! Transpiled from Horizon Rust crate
package horizon_client_block_editor

import "core:fmt"
import "core:mem"
import "core:math"

// The edit screens of the game master blocks (`StructureBlockEditScreen`,
// `JigsawBlockEditScreen`, `TestBlockEditScreen`,
// `TestInstanceBlockEditScreen`): one screen that runs an [`Editor`], which
// lays out its widgets, takes their presses and builds the packet for the
// server. The screens change the client's copy of the block entity as they
// are used, as vanilla's do, so the box preview follows them.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: hud::{HudBatch, rgba},
    // rust: text::Text,
    // rust: ui::{self, EditBox},
}
// use horizon_protocol::packets::play::Serverbound as S;
// use winit::{
    // rust: event::{ElementState, KeyEvent},
    // rust: keyboard::{KeyCode, PhysicalKey},
}

    // rust: pub(super) type Pos = (i32, i32, i32);

// `Screen.extractRenderState`'s grey for the labels: `-6250336`.
    // rust: pub(super) const LABEL: u32 = 0xFFA0_A0A0;

// The job of an edit screen's footer button `id`, given the ids of its Done and Cancel.
    // rust: pub(super) fn footer_action(
    // rust: id: u8,
    // rust: done: u8,
    // rust: cancel: u8,
    // rust: ) -> Option<horizon_client::widgets::Action> {
//     use horizon_client::widgets::Action;
    // rust: match id {
    // rust: _ if id == done => Some(Action::Done),
    // rust: _ if id == cancel => Some(Action::Cancel),
    // rust: _ => None,
}
}

// A widget of an edit screen at GUI pixels.
    // rust: pub(super) enum Item {
    // rust: Label {
    // rust: text: Text,
    // rust: x: f32,
    // rust: y: f32,
        // Right-aligned at `x` (the labels beside the right-hand buttons).
    // rust: right: bool,
    // rust: },
    // rust: Title {
    // rust: text: Text,
    // rust: y: f32,
    // rust: },
    // rust: Edit {
    // rust: index: usize,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: },
    // rust: Button {
    // rust: id: u8,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: label: Text,
    // rust: active: bool,
        // Its job on the screen, for the controller.
    // rust: action: Option<horizon_client::widgets::Action>,
    // rust: },
    // A multi-line message (`FittingMultiLineTextWidget`), wrapped to `w`
    // and cut to what fits `h`.
    // rust: Info {
    // rust: text: Text,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: },
    // An `AbstractSliderButton`: `value` is 0..1.
    // rust: Slider {
    // rust: id: u8,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: label: Text,
    // rust: value: f32,
    // rust: },
}

// What a press on a button does to the screen.
    // rust: pub(super) enum Outcome {
    // rust: Stay,
    // Send the packet and close.
    // rust: Send(S),
    // Send the packets in order and close.
    // rust: SendAll(Vec<S>),
    // Close, after the editor reverted what it changed.
    // rust: Cancel,
}

// One edit screen's widgets and rules.
    // rust: pub(super) trait Editor {
    // The text boxes, in tab order.
edits :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // The widgets for the block entity as it is now, in a `w`×`h` screen.
items :: proc(self: ^Self, entity: ^BlockEntity, w: f32, h: f32) -> V {
    // Ported from Horizon
    return {}
}
    // A button pressed (`shift` held), possibly changing the entity.
    // rust: fn press(
    // rust: &mut self,
    // rust: entity: &mut BlockEntity,
    // rust: pos: Pos,
    // rust: id: u8,
    // rust: shift: bool,
    // rust: alt: bool,
    // rust: ) -> Outcome;
    // The screen opened: packets it sends first (`init`).
opened :: proc(self: ^Self, _entity: ^BlockEntity, _pos: Pos) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec::new()
}
    // The text of box `edit` changed (`EditBox.setResponder`): packets to send.
edited :: proc(self: ^Self, _edit: uint, _pos: Pos) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec::new()
}
    // A status from the server (`ClientboundTestInstanceBlockStatus`).
status :: proc(self: ^Self, _entity: ^BlockEntity, _status: Text, _size: Maybe([i32; 3])) {
}
    // A slider moved to `value` (0..1).
slide :: proc(self: ^Self, _id: u8, _value: f32) {
}
    // Done: the packet that carries the screen's values.
done :: proc(self: ^Self, entity: ^BlockEntity, pos: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // Cancel: put the block entity back.
cancel :: proc(self: ^Self, entity: ^BlockEntity) {
}
    // Whether the box takes the typed character (`EditBox.charTyped`).
accepts :: proc(self: ^Self, _edit: uint, _current: string, _cursor: uint, _c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // Whether Enter is Done (a screen with its own `keyPressed`).
enter_confirms :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // The box that has the focus when the screen opens.
initial_focus :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
}

// The open edit screen.
    // rust: pub(super) struct BlockEditScreen {
    // rust: pub(super) pos: Pos,
    // rust: pub(super) editor: Box<dyn Editor>,
    // The text box with the focus, and which of them show.
    // rust: focus: Option<usize>,
    // The text of each box when the screen last looked, to see what changed.
    // rust: values: Vec<String>,
    // The slider being dragged: its id and the x and width it is drawn at.
    // rust: dragging: Option<(u8, f32, f32)>,
}

    // rust: impl BlockEditScreen {
    // rust: pub(super) fn new(pos: Pos, editor: Box<dyn Editor>) -> Self {
    // rust: let focus = Some(editor.initial_focus());
    // rust: Self {
    // rust: pos,
    // rust: editor,
    // rust: focus,
    // rust: values: Vec::new(),
    // rust: dragging: None,
}
}
    // Whether one of the block's text boxes has the keyboard's focus: the
    // window asks the OS for an input method only then.
    // rust: pub(super) fn text_focused(&self) -> bool {
    // rust: self.focus.is_some()
}
}

    // rust: impl Game<'_> {
    // `LocalPlayer.open*Block`: the edit screen for the block entity at
    // `pos`.
    // rust: pub(super) fn open_block_editor(&mut self, pos: Pos, editor: Box<dyn Editor>) {
    // rust: let mut screen = BlockEditScreen::new(pos, editor);
    // rust: let opening = self
    // rust: .world
    // rust: .block_entities
    // rust: .get(&pos)
    // rust: .map(|entity| screen.editor.opened(entity, pos))
    // rust: .unwrap_or_default();
    // rust: screen.values = screen
    // rust: .editor
    // rust: .edits()
    // rust: .iter()
    // rust: .map(|e| e.value.clone())
    // rust: .collect();
    // rust: self.block_editor = Some(screen);
    // rust: self.screen = Screen::BlockEditor;
    // rust: self.capture(false);
    // rust: for packet in opening {
    // rust: self.send(packet);
}
}

    // A use of a game master block on a server's client, which opens the
    // screen itself (`BlockEntity.usedBy`) while the server only answers the
    // click. The block at `pos`, when the player may use it.
    // rust: pub(super) fn open_block_editor_if_editable(&mut self, pos: Pos) {
    // rust: if !self.can_use_game_master_blocks() {
    // rust: return;
}
    // rust: match self.world.block_entities.get(&pos) {
    // rust: Some(BlockEntity::StructureBlock(_)) => self.open_structure_block(pos),
    // rust: Some(BlockEntity::JigsawBlock(_)) => self.open_jigsaw_block(pos),
    // rust: Some(BlockEntity::TestBlock(_)) => self.open_test_block(pos),
    // rust: Some(BlockEntity::TestInstanceBlock(_)) => self.open_test_instance_block(pos),
    // rust: _ => {}
}
}

    // rust: pub(super) fn close_block_editor(&mut self) {
    // rust: self.block_editor = None;
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}

    // Run `f` on the open screen with its block entity; the screen closes
    // when the block is gone (`BlockEntity` removed).
    // rust: fn with_block_editor<R>(
    // rust: &mut self,
    // rust: f: impl FnOnce(&mut BlockEditScreen, &mut BlockEntity) -> R,
    // rust: ) -> Option<R> {
    // rust: let mut screen = self.block_editor.take()?;
    // rust: let result = self
    // rust: .world
    // rust: .block_entities
    // rust: .get_mut(&screen.pos)
    // rust: .map(|entity| f(&mut screen, entity));
    // rust: if result.is_some() {
    // rust: self.block_editor = Some(screen);
    // rust: } else {
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
    // rust: result
}

block_editor_outcome :: proc(self: ^Self, outcome: Outcome) {
}
    // rust: match outcome {
    // rust: Outcome::Stay => {}
    // rust: Outcome::Send(packet) => {
    // rust: self.send(packet);
    // rust: self.close_block_editor();
}
    // rust: Outcome::SendAll(packets) => {
    // rust: for packet in packets {
    // rust: self.send(packet);
}
    // rust: self.close_block_editor();
}
    // rust: Outcome::Cancel => self.close_block_editor(),
}
}

    // rust: pub(super) fn draw_block_editor(&mut self, batch: &mut HudBatch) {
    // rust: let cursor = self.cursor;
    // rust: let Some(items) = self.with_block_editor(|s, e| {
    // rust: let items = s.editor.items(e, batch.width, batch.height);
    // rust: for (i, edit) in s.editor.edits().iter_mut().enumerate() {
    // rust: edit.focused = s.focus == Some(i);
}
    // rust: items
    // rust: }) else {
    // rust: return;
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: batch.fill_gradient(
    // rust: atlas,
    // rust: (0.0, 0.0, w, h),
    // rust: rgba(0x10, 0x10, 0x10, 0xC0),
    // rust: rgba(0x10, 0x10, 0x10, 0xD0),
    // rust: );
    // rust: let Some(mut screen) = self.block_editor.take() else {
    // rust: return;
}
        // Buttons first, then the labels and boxes, as `Screen` renders its
        // widgets before the screen draws its own.
    // rust: for item in &items {
    // rust: if let Item::Button {
    // rust: x,
    // rust: y,
    // rust: w: bw,
    // rust: label,
    // rust: active,
    // rust: action,
    // rust: ..
    // rust: } = item
    // rust: {
    // rust: let hover = ui::hovered(cursor, *x, *y, *bw, 20.0);
    // rust: if let Some(action) = *action {
    // rust: horizon_client::widgets::declare_action(action, [*x, *y, *bw, 20.0], *active);
}
    // rust: ui::button(batch, atlas, *x, *y, *bw, 20.0, label, *active, hover);
}
}
    // rust: for item in &items {
    // rust: match item {
    // rust: Item::Title { text, y } => {
    // rust: let tw = atlas.font.width_text(text);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: text,
    // rust: (w / 2.0 - tw / 2.0).floor(),
    // rust: *y,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: Item::Label { text, x, y, right } => {
    // rust: let x = if *right {
    // rust: x - atlas.font.width_text(text)
    // rust: } else {
    // rust: *x
}
    // rust: batch.text_styled(atlas, text, x, *y, LABEL, true);
}
    // rust: Item::Edit { index, x, y, w: ew } => {
    // rust: if let Some(edit) = screen.editor.edits().get_mut(*index) {
    // rust: (edit.x, edit.y, edit.width, edit.height) = (*x, *y, *ew, 20.0);
    // rust: edit.draw(batch, atlas, None);
}
}
    // rust: Item::Button { .. } => {}
    // rust: Item::Info {
    // rust: text,
    // rust: x,
    // rust: y,
    // rust: w: iw,
    // rust: h: ih,
    // rust: } => {
    // rust: let lines = atlas.font.wrap_components(text, *iw as i32);
    // rust: for (i, line) in lines.iter().take((*ih / 9.0) as usize).enumerate() {
    // rust: batch.text_styled(atlas, line, *x, *y + i as f32 * 9.0, u32::MAX, true);
}
}
    // rust: Item::Slider {
    // rust: id,
    // rust: x,
    // rust: y,
    // rust: w: sw,
    // rust: label,
    // rust: value,
    // rust: } => {
    // rust: let hover = ui::hovered(cursor, *x, *y, *sw, 20.0);
    // rust: let dragging = screen.dragging.is_some_and(|(d, _, _)| d == *id);
    // rust: ui::slider(
    // rust: batch, atlas, *x, *y, *sw, label, *value, hover, true, dragging,
    // rust: );
}
}
}
    // rust: self.block_editor = Some(screen);
}

    // rust: pub(super) fn block_editor_click(&mut self) {
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1, 1], |r| [r.config.width, r.config.height]);
    // rust: let b = HudBatch::new(size);
    // rust: let cursor = self.cursor;
    // rust: let shift = self.has_shift_down();
    // rust: let alt = self.keys.raw(&KeyCode::AltLeft);
    // rust: let atlas_click = |game: &Game<'_>, edit: &mut EditBox| {
    // rust: edit.click(&game.gui.atlas, cursor.0, false, false);
}
    // rust: let Some(items) = self.with_block_editor(|s, e| s.editor.items(e, b.width, b.height))
    // rust: else {
    // rust: return;
}
        // The widgets in the order they were added: the last on top.
    // rust: for item in items.iter().rev() {
    // rust: match item {
    // rust: Item::Button {
    // rust: id,
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: active,
    // rust: ..
    // rust: } if *active && ui::hovered(cursor, *x, *y, *w, 20.0) => {
    // rust: self.audio.play_button_click();
    // rust: let id = *id;
    // rust: if let Some(outcome) = self.with_block_editor(|s, e| {
    // rust: let pos = s.pos;
    // rust: s.editor.press(e, pos, id, shift, alt)
    // rust: }) {
    // rust: self.block_editor_outcome(outcome);
}
    // rust: return;
}
    // rust: Item::Slider { id, x, y, w, .. } if ui::hovered(cursor, *x, *y, *w, 20.0) => {
    // rust: let (id, x, w) = (*id, *x, *w);
    // rust: let value = ui::slider_value(x, w, cursor.0);
    // rust: if let Some(mut screen) = self.block_editor.take() {
    // rust: screen.dragging = Some((id, x, w));
    // rust: screen.editor.slide(id, value);
    // rust: self.block_editor = Some(screen);
}
    // rust: return;
}
    // rust: Item::Edit { index, x, y, w } if ui::hovered(cursor, *x, *y, *w, 20.0) => {
    // rust: let index = *index;
    // rust: if let Some(mut screen) = self.block_editor.take() {
    // rust: screen.focus = Some(index);
    // rust: if let Some(edit) = screen.editor.edits().get_mut(index) {
    // rust: (edit.x, edit.width) = (*x, *w);
    // rust: atlas_click(self, edit);
}
    // rust: self.block_editor = Some(screen);
}
    // rust: return;
}
    // rust: _ => {}
}
}
}

    // The cursor moved with a slider held (`AbstractSliderButton.onDrag`).
    // rust: pub(super) fn block_editor_drag(&mut self) {
    // rust: let x = self.cursor.0;
    // rust: if let Some(screen) = self.block_editor.as_mut()
    // rust: && let Some((id, sx, sw)) = screen.dragging
    // rust: {
    // rust: screen.editor.slide(id, ui::slider_value(sx, sw, x));
}
}

    // The left button released: a held slider lets go.
    // rust: pub(super) fn block_editor_release(&mut self) {
    // rust: if let Some(screen) = self.block_editor.as_mut() {
    // rust: screen.dragging = None;
}
}

    // rust: pub(super) fn block_editor_key(&mut self, event: &KeyEvent) {
    // rust: if event.state != ElementState::Pressed {
    // rust: return;
}
    // rust: let PhysicalKey::Code(key) = event.physical_key else {
    // rust: return;
}
    // rust: let shortcut = self.edit_shortcut(event);
    // rust: self.block_editor_key_code(key, shortcut, event.text.as_deref());
}

    // A key pressed on an edit screen: Enter is Done, Escape cancels, Tab
    // moves between the boxes, the rest edits the focused one.
    // rust: pub(super) fn block_editor_key_code(
    // rust: &mut self,
    // rust: key: KeyCode,
    // rust: shortcut: Option<horizon_client::clipboard::EditShortcut>,
    // rust: text: Option<&str>,
    // rust: ) {
    // rust: let ctrl = self.has_control_down_with_quirk();
    // rust: let shift = self.has_shift_down();
    // rust: let types_text = self.types_text();
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1, 1], |r| [r.config.width, r.config.height]);
    // rust: let b = HudBatch::new(size);
    // rust: match key {
    // rust: KeyCode::Escape => {
    // rust: let outcome = self
    // rust: .with_block_editor(|s, e| {
    // rust: s.editor.cancel(e);
    // rust: Outcome::Cancel
    // rust: })
    // rust: .unwrap_or(Outcome::Cancel);
    // rust: self.block_editor_outcome(outcome);
}
    // rust: KeyCode::Enter | KeyCode::NumpadEnter => {
    // rust: let confirms = self
    // rust: .block_editor
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.editor.enter_confirms());
    // rust: if !confirms {
    // rust: return;
}
    // rust: if let Some(outcome) = self.with_block_editor(|s, e| {
    // rust: let pos = s.pos;
    // rust: s.editor.done(e, pos)
    // rust: }) {
    // rust: self.block_editor_outcome(outcome);
}
}
    // rust: KeyCode::Tab => {
    // rust: self.with_block_editor(|s, e| {
                    // The boxes on screen, in the order they were added.
    // rust: let shown: Vec<usize> = s
    // rust: .editor
    // rust: .items(e, b.width, b.height)
    // rust: .iter()
    // rust: .filter_map(|i| match i {
    // rust: Item::Edit { index, .. } => Some(*index),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: if shown.is_empty() {
    // rust: return;
}
    // rust: let at = s.focus.and_then(|f| shown.iter().position(|&i| i == f));
    // rust: let next = match at {
    // rust: None => 0,
    // rust: Some(p) if shift => (p + shown.len() - 1) % shown.len(),
    // rust: Some(p) => (p + 1) % shown.len(),
}
    // rust: s.focus = Some(shown[next]);
    // rust: });
}
    // rust: _ => {
    // rust: let Some(mut screen) = self.block_editor.take() else {
    // rust: return;
}
    // rust: if let Some(focus) = screen.focus
    // rust: && let Some(edit) = screen.editor.edits().get_mut(focus)
    // rust: {
    // rust: if let Some(shortcut) = shortcut {
    // rust: edit.shortcut(shortcut, &mut self.clipboard);
    // rust: } else if !edit.key(key, ctrl, shift) && types_text {
    // rust: for c in text.unwrap_or("").chars() {
    // rust: self.block_editor_type_into(&mut screen, focus, c);
}
}
}
    // rust: self.block_editor = Some(screen);
    // rust: self.block_editor_after_input();
}
}
}

    // What typing changed: the boxes whose text differs from before tell
    // the editor, which may have packets to send.
block_editor_after_input :: proc(self: ^Self) {
}
    // rust: let Some(mut screen) = self.block_editor.take() else {
    // rust: return;
}
    // rust: let pos = screen.pos;
    // rust: let now: Vec<String> = screen
    // rust: .editor
    // rust: .edits()
    // rust: .iter()
    // rust: .map(|e| e.value.clone())
    // rust: .collect();
    // rust: let mut packets = Vec::new();
    // rust: for (i, value) in now.iter().enumerate() {
    // rust: if screen.values.get(i) != Some(value) {
    // rust: packets.extend(screen.editor.edited(i, pos));
}
}
    // rust: screen.values = now;
    // rust: self.block_editor = Some(screen);
    // rust: for packet in packets {
    // rust: self.send(packet);
}
}

    // A status for the open screen.
    // rust: pub(super) fn block_editor_status(&mut self, status: Text, size: Option<[i32; 3]>) {
    // rust: let Some(mut screen) = self.block_editor.take() else {
    // rust: return;
}
    // rust: if let Some(entity) = self.world.block_entities.get(&screen.pos) {
    // rust: screen.editor.status(entity, status, size);
}
    // rust: screen.values = screen
    // rust: .editor
    // rust: .edits()
    // rust: .iter()
    // rust: .map(|e| e.value.clone())
    // rust: .collect();
    // rust: self.block_editor = Some(screen);
}

block_editor_type_into :: proc(self: ^Self, screen: ^BlockEditScreen, focus: uint, c: char) {
}
    // rust: if c.is_control() {
    // rust: return;
}
    // rust: let Some(edit) = screen.editor.edits().get(focus) else {
    // rust: return;
}
    // rust: let (value, cursor) = (edit.value.clone(), edit.cursor);
    // rust: if !screen.editor.accepts(focus, &value, cursor, c) {
    // rust: return;
}
    // rust: if let Some(edit) = screen.editor.edits().get_mut(focus) {
    // rust: edit.insert_text(&c.to_string());
}
}

    // Characters typed (`type TEXT` from the agent control): into the box
    // with the focus.
    // rust: pub(super) fn block_editor_type(&mut self, typed: &str) {
    // rust: let Some(mut screen) = self.block_editor.take() else {
    // rust: return;
}
    // rust: if let Some(focus) = screen.focus {
    // rust: for c in typed.chars() {
    // rust: self.block_editor_type_into(&mut screen, focus, c);
}
}
    // rust: self.block_editor = Some(screen);
    // rust: self.block_editor_after_input();
}
}

// `Screen.isValidCharacterForName`: the characters an identifier takes,
// with one `:` before any `/`, and `/` only after it.
    // rust: pub(super) fn valid_character_for_name(current: &str, c: char, cursor: usize) -> bool {
    // rust: let colon = current.chars().position(|x| x == ':');
    // rust: let slash = current.chars().position(|x| x == '/');
    // rust: match c {
    // rust: ':' => slash.is_none_or(|s| cursor <= s) && colon.is_none(),
    // rust: '/' => colon.map_or(-1, |c| c as i64) < cursor as i64,
    // rust: '_' | '-' | '.' | 'a'..='z' | '0'..='9' => true,
    // rust: _ => false,
}
}

// `CycleButton.cycleValue`: the value `delta` steps on in `values`, wrapping;
// a current value that is not in the list steps from -1.
    // rust: pub(super) fn cycle<T: Copy + PartialEq>(values: &[T], current: T, delta: i32) -> T {
    // rust: let at = values
    // rust: .iter()
    // rust: .position(|v| *v == current)
    // rust: .map_or(-1, |i| i as i32);
    // rust: let len = values.len() as i32;
    // rust: values[(at + delta).rem_euclid(len) as usize]
}

// `CommonComponents.OPTION_ON` / `OPTION_OFF`.
    // rust: pub(super) fn on_off(on: bool) -> Text {
    // rust: Text::translate(if on { "options.on" } else { "options.off" }, &[])
}

    // rust: mod tests {
//     use super::*;

name_characters_follow_screen_is_valid_character_for_name :: proc() {
}
    // rust: assert!(valid_character_for_name("", 'a', 0));
    // rust: assert!(valid_character_for_name("a", '_', 1));
    // rust: assert!(!valid_character_for_name("a", 'A', 1));
    // rust: assert!(!valid_character_for_name("a", ' ', 1));
        // One colon, not after a slash.
    // rust: assert!(valid_character_for_name("ns", ':', 2));
    // rust: assert!(!valid_character_for_name("ns:x", ':', 4));
    // rust: assert!(!valid_character_for_name("a/b", ':', 3));
    // rust: assert!(valid_character_for_name("a/b", ':', 1));
        // A slash only after the colon.
    // rust: assert!(valid_character_for_name("ns:a", '/', 4));
    // rust: assert!(!valid_character_for_name("ns:a", '/', 1));
    // rust: assert!(valid_character_for_name("a", '/', 1));
}

cycling_wraps_and_steps_from_minus_one_off_the_list :: proc() {
}
    // rust: assert_eq!(cycle(&[1, 2, 3], 3, 1), 1);
    // rust: assert_eq!(cycle(&[1, 2, 3], 1, -1), 3);
    // rust: assert_eq!(cycle(&[1, 2, 3], 9, 1), 1);
    // rust: assert_eq!(cycle(&[1, 2, 3], 9, -1), 2);
}
}
