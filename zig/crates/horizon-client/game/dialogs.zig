//! Transpiled from Horizon Rust crate
//! Module: horizon-client_dialogs
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A server's dialogs bound to the game (`ClientCommonPacketListenerImpl.
//! showDialog` and `clearDialog`, `DialogScreen`, its `WarningScreen` and the
//! `WaitingForResponseScreen`): the screen over whatever is open (the
//! connecting screen in configuration), its inputs, and the actions its
//! buttons send back.
// use super::Game;
// use super::remote_chat::Behind;
// use horizon_client::{
    // rust: Result,
    // rust: clipboard::EditShortcut,
    // rust: confirm_screen::Confirm,
    // rust: dialog::{AfterAction, Body, Click, Control, Dialog, InputValue, Kind},
    // rust: dialog_screen::{BOX, Layout, Part, WARNING_SPRITES, text_height, waiting_button},
    // rust: font::Font,
    // rust: hud::{HudBatch, rgba},
    // rust: multiline_edit::MultiLineEdit,
    // rust: text::{ClickEvent, Text},
    // rust: ui,
    // rust: widgets::{self, ScreenInfo},
}
// use horizon_world::nbt::Tag;
// use std::time::Instant;
// use winit::keyboard::KeyCode;

/// An open `DialogScreen`.
pub const Open = struct {
    dialog: Dialog,
    values: std.ArrayList(InputValue),
    /// The box of each text input.
    fields: std.ArrayList(?Field),
    focus: ?usize,
    scroll: ui::Scroll,
    /// The number range input whose slider is held.
    dragging: ?usize,
    /// The multiline input the pointer is selecting in.
    selecting: ?usize,
};

/// A dialog a clicked command closed, kept for its confirmation's no.
    // rust: pub(super) struct ClosedDialog(Box<Open>);

/// A text input's control: `EditBox`, or `MultiLineEditBox` for a multiline one.
pub const Field = enum {
    Line(ui::EditBox),
    Multi(Box<MultiLineEdit>),
};
    // rust: impl Field {
pub fn value(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Line(edit) => edit.value.clone(),
    // rust: Self::Multi(edit) => edit.value(),
}
}
pub fn insert_text(self: *Self, font: *Font, text: []const u8) void {
}
    // rust: match self {
    // rust: Self::Line(edit) => edit.insert_text(text),
    // rust: Self::Multi(edit) => edit.insert_text(font, text),
}
}
pub fn key(self: *Self, font: *Font, key: KeyCode, ctrl: bool, shift: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Line(edit) => edit.key(key, ctrl, shift),
    // rust: Self::Multi(edit) => edit.key(font, key, ctrl, shift),
}
}
    // rust: fn shortcut(
    // rust: &mut self,
    // rust: font: &Font,
    // rust: shortcut: EditShortcut,
    // rust: clipboard: &mut dyn horizon_client::clipboard::Clipboard,
    // rust: ) {
    // rust: match self {
    // rust: Self::Line(edit) => {
    // rust: edit.shortcut(shortcut, clipboard);
}
    // rust: Self::Multi(edit) => {
    // rust: edit.shortcut(font, shortcut, clipboard);
}
}
}
}

/// The dialog screens a server can open.
    // rust: pub(super) struct DialogState {
    // rust: open: Option<Open>,
    /// `WaitingForResponseScreen`, since when.
    // rust: waiting: Option<Instant>,
    /// `DialogScreen.WarningScreen`, over the dialog.
    // rust: warning: bool,
}

/// `CycleButton.cycleValue`: the next option (`delta` 1) or the one before
/// it, wrapping.
pub fn cycle(open: *mut Open, input: usize, delta: i32) void {
}
    // rust: let Control::SingleOption { options, .. } = &open.dialog.inputs[input].control else {
    // rust: return;
}
    // rust: if let Some(InputValue::Option(i)) = open.values.get_mut(input) {
    // rust: *i = (*i as i32 + delta).rem_euclid(options.len().max(1) as i32) as usize;
}
}

pub fn warning_texts() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = |key: &str| Text::translate(key, &[]);
    // rust: (
    // rust: t("menu.custom_screen_info.title"),
    // rust: t("menu.custom_screen_info.contents"),
    // rust: [t("menu.disconnect"), t("gui.back")],
    // rust: )
}

    // rust: impl Game<'_> {
    /// Whether a dialog screen takes the input.
    // rust: pub(super) fn dialog_open(&self) -> bool {
    // rust: let d = &self.dialogs;
    // rust: d.open.is_some() || d.waiting.is_some() || d.warning
}
    /// What tells one dialog screen from another for a controller's focus: a new dialog is a
    /// new screen, and so are the warning and waiting screens.
    // rust: pub(super) fn dialog_screen_key(&self) -> (bool, bool, Option<String>) {
    // rust: let d = &self.dialogs;
    // rust: (
    // rust: d.warning,
    // rust: d.waiting.is_some(),
    // rust: d.open.as_ref().map(|o| o.dialog.title.plain()),
    // rust: )
}
    /// The warning icon in the dialog's corner, while the dialog itself shows.
    // rust: pub(super) fn dialog_warning_icon(&self) -> Option<[f32; 4]> {
    // rust: let d = &self.dialogs;
    // rust: if d.warning || d.waiting.is_some() {
    // rust: return None;
}
    // rust: self.dialog_layout().map(|layout| layout.warning)
}
    /// The dialog itself shows, with a text input to start on.
    // rust: pub(super) fn dialog_starts_typing(&self) -> bool {
    // rust: !self.dialogs.warning && self.dialogs.waiting.is_none() && self.dialog_has_text_field()
}
    /// The dialog's focus is a text input of many lines, where Enter is a new line.
    // rust: pub(super) fn dialog_typing_lines(&self) -> bool {
    // rust: self.dialogs.open.as_ref().is_some_and(|o| {
    // rust: let field = o.focus.and_then(|f| o.fields.get(f));
    // rust: matches!(field, Some(Some(Field::Multi(_))))
    // rust: })
}
    /// Whether the dialog's focus is one of its text inputs, which takes the
    /// keys.
    // rust: pub(super) fn dialog_typing(&self) -> bool {
    // rust: let d = &self.dialogs;
    // rust: !d.warning
    // rust: && d.waiting.is_none()
    // rust: && d.open.as_ref().is_some_and(|o| {
    // rust: o.focus
    // rust: .and_then(|f| o.fields.get(f))
    // rust: .is_some_and(Option::is_some)
    // rust: })
}

    /// `showDialog`: the dialog replaces an open one (and a waiting screen);
    /// under the warning screen, it is what Back returns to.
    // rust: pub(super) fn show_dialog(&mut self, tag: &Tag) {
    // rust: let Some(mut dialog) = Dialog::parse(tag) else {
    // rust: log::warn!("Horizon: failed to show dialog for data {tag:?}");
    // rust: return;
}
    // rust: if let Kind::DialogList { dialogs, .. } = &dialog.kind {
    // rust: let entries = self.remote.as_ref().map(|r| {
    // rust: let list = r.registries.registries.get("minecraft:dialog");
    // rust: let by_id = |id: &str| {
    // rust: let name = if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: list?.iter().find(|(n, _)| *n == name)?.1.clone()
}
    // rust: let by_tag = |name: &str| {
    // rust: let name = if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
}
    // rust: let ids = r.registries.dialog_tags.get(&name).into_iter().flatten();
    // rust: ids.filter_map(|&i| list?.get(usize::try_from(i).ok()?)?.1.clone())
    // rust: .collect()
}
    // rust: Dialog::list_entries(dialogs, &by_tag, &by_id)
    // rust: });
    // rust: dialog.set_list(&entries.unwrap_or_default());
}
    // rust: self.open_dialog(dialog);
}

    /// The parsed dialog's screen, its inputs at their initial values.
pub fn open_dialog(self: *Self, dialog: Dialog) void {
}
    // rust: let values = dialog.inputs.iter().map(|i| i.control.initial()).collect();
    // rust: let font = &self.gui.atlas.font;
    // rust: let fields = dialog
    // rust: .inputs
    // rust: .iter()
    // rust: .map(|i| match &i.control {
    // rust: Control::Text {
    // rust: width,
    // rust: initial,
    // rust: max_length,
    // rust: multiline: Some((max_lines, _)),
    // rust: ..
    // rust: } => {
                    // TextInputHandler: the `MultiLineEditBox` with its limits.
    // rust: let height = text_height(Some((*max_lines, None)));
    // rust: let height = match &i.control {
    // rust: Control::Text {
    // rust: multiline: Some((_, Some(h))),
    // rust: ..
    // rust: } => *h as f32,
    // rust: _ => height,
}
    // rust: let mut edit = MultiLineEdit::new(font, 0.0, 0.0, *width as f32, height);
    // rust: edit.set_character_limit((*max_length).max(0) as usize);
    // rust: if let Some(lines) = max_lines {
    // rust: edit.set_line_limit((*lines).max(0) as usize);
}
    // rust: edit.set_value(font, initial);
    // rust: Some(Field::Multi(Box::new(edit)))
}
    // rust: Control::Text {
    // rust: width,
    // rust: initial,
    // rust: max_length,
    // rust: ..
    // rust: } => {
    // rust: let mut edit = ui::EditBox::new(0.0, 0.0, *width as f32, 20.0);
    // rust: edit.max_length = (*max_length).max(1) as usize;
    // rust: edit.set_value(initial);
    // rust: edit.focused = false;
    // rust: Some(Field::Line(edit))
}
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: self.dialogs.open = Some(Open {
    // rust: dialog,
    // rust: values,
    // rust: fields,
    // rust: focus: None,
    // rust: scroll: ui::Scroll::default(),
    // rust: dragging: None,
    // rust: selecting: None,
    // rust: });
    // rust: self.dialogs.waiting = None;
    // rust: self.keys.clear();
    // rust: self.physical_keys.clear();
    // rust: self.left = false;
    // rust: self.right = false;
    // rust: self.capture(false);
}

    /// `clearDialog`: the dialog closes (under the warning screen, Back then
    /// returns to what was open before it).
    // rust: pub(super) fn clear_dialog(&mut self) {
    // rust: if self.dialogs.open.take().is_some() && !self.dialog_open() {
    // rust: self.dialog_closed();
}
}

    /// Every dialog screen goes (a disconnect, or the level loading screen).
    // rust: pub(super) fn close_dialogs(&mut self) {
    // rust: self.dialogs = DialogState::default();
}

pub fn dialog_closed(self: *Self) void {
}
    // rust: if self.player.is_some() && self.screen == super::Screen::Playing && self.title.is_none() {
    // rust: self.capture(true);
}
}

    /// The input values as the controls hold them now.
pub fn dialog_values(open: *mut Open) void {
}
    // rust: for (value, field) in open.values.iter_mut().zip(&open.fields) {
    // rust: if let Some(f) = field {
    // rust: *value = InputValue::Text(f.value());
}
}
}

    /// The confirmation's no: the dialog again, with what was typed in it.
    // rust: pub(super) fn reopen_dialog(&mut self, dialog: ClosedDialog) {
    // rust: self.dialogs.open = Some(*dialog.0);
    // rust: self.dialogs.waiting = None;
}

    /// `DialogScreen.runAction`: the click event, then the screen the dialog's
    /// `after_action` leaves.
pub fn run_dialog_action(self: *Self, click: ?Click, after: AfterAction) R {
    // Implementation ported from Horizon
    return undefined;
}
        // defaultHandleClickEvent: an open_url never sets the screen itself, so
        // the dialog stays unless the confirmation takes over (Web Links off,
        // or Prompt on Links off, opens nothing or the browser behind it).
    // rust: if let Some(Click::OpenUrl(url)) = &click
    // rust: && !(self.settings.chat_links && self.settings.chat_links_prompt)
    // rust: {
    // rust: if self.settings.chat_links {
    // rust: super::packs::open_uri(url);
}
    // rust: return Ok(());
}
        // openSendConfirmationWindow's `currentScreen`: a command that asks
        // first still has this dialog to go back to.
    // rust: let closing = match (&click, &after) {
    // rust: (Some(Click::RunCommand(_)), AfterAction::Close | AfterAction::WaitForResponse) => {
    // rust: self.dialogs.open.take()
}
    // rust: _ => None,
}
    // rust: match after {
    // rust: AfterAction::None => {}
    // rust: AfterAction::Close => self.dialogs.open = None,
    // rust: AfterAction::WaitForResponse => {
    // rust: self.dialogs.open = None;
    // rust: self.dialogs.waiting = Some(Instant::now());
}
}
    // rust: match click {
    // rust: Some(Click::Custom { id, payload }) => {
    // rust: if let Some(r) = &self.remote {
    // rust: r.session.send_custom_click(&id, payload);
}
}
    // rust: Some(Click::RunCommand(command)) => {
                // In configuration there is nothing to run it (vanilla warns).
    // rust: if self.player.is_some() {
    // rust: self.send_unattended_command(&command);
    // rust: if let Some(open) = closing {
    // rust: self.command_prompt_returns_to(Behind::Dialog(ClosedDialog(Box::new(
    // rust: open,
    // rust: ))));
}
    // rust: } else {
    // rust: log::warn!(
    // rust: "Horizon: commands are not supported in configuration, trying to run '{command}'"
    // rust: );
}
}
    // rust: Some(Click::ShowDialog(dialog)) => self.show_dialog_ref(&dialog),
    // rust: Some(Click::CopyToClipboard(value)) => {
//                 use horizon_client::clipboard::Clipboard;
    // rust: self.clipboard.set(&value);
}
            // ConfirmLinkScreen over the screen the dialog leaves.
    // rust: Some(Click::OpenUrl(url)) => self.click_url(url),
            // defaultHandleClickEvent: `activeScreen.insertText(command, true)`.
            // Only the chat screen (opened under the dialog) takes text.
    // rust: Some(Click::SuggestCommand(command)) => {
    // rust: if !self.dialog_open() && self.ui.chat_screen.is_some() {
    // rust: let m = horizon_client::screen_draw::Measure(&self.gui.atlas.font);
    // rust: let c = horizon_client::chat::Commands {
    // rust: dispatcher: super::chat::chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: if let Some(screen) = self.ui.chat_screen.as_mut() {
    // rust: screen.suggest_command(&m, &c, &command);
}
}
}
    // rust: Some(other) => log::error!("Don't know how to handle {other:?}"),
    // rust: None => {}
}
    // rust: if !self.dialog_open() {
    // rust: self.dialog_closed();
}
    // rust: Ok(())
}

    /// A `show_dialog` click event's dialog: a registry id or the dialog itself.
    // rust: pub(super) fn show_dialog_ref(&mut self, dialog: &Tag) {
    // rust: match dialog {
    // rust: Tag::String(id) => {
    // rust: let id = id.to_string_lossy();
    // rust: let name = if id.contains(':') {
    // rust: id.clone()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: let found = self.remote.as_ref().and_then(|r| {
    // rust: let entries = r.registries.registries.get("minecraft:dialog")?;
    // rust: entries.iter().find(|(n, _)| *n == name)?.1.clone()
    // rust: });
    // rust: match found {
    // rust: Some(tag) => self.show_dialog(&tag),
    // rust: None => log::warn!("Horizon: unknown dialog {id}"),
}
}
    // rust: tag => self.show_dialog(tag),
}
}

    /// `ClientboundShowDialogPacket` in play: a registry entry or the dialog.
    // rust: pub(super) fn show_play_dialog(
    // rust: &mut self,
    // rust: dialog: &horizon_protocol::packets::play::DialogHolder,
    // rust: ) {
//         use horizon_protocol::packets::play::DialogHolder;
    // rust: match dialog {
    // rust: DialogHolder::Direct(tag) => self.show_dialog(tag),
    // rust: DialogHolder::Registry(id) => {
    // rust: let tag = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.registries.data("minecraft:dialog", *id).cloned());
    // rust: match tag {
    // rust: Some(tag) => self.show_dialog(&tag),
    // rust: None => log::warn!("Horizon: unknown dialog {id}"),
}
}
}
}

pub fn dialog_layout(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let open = self.dialogs.open.as_ref()?;
    // rust: Some(Layout::new(
    // rust: &open.dialog,
    // rust: &self.gui.atlas.font,
    // rust: self.gui_size(),
    // rust: ))
}

    // rust: pub(super) fn draw_dialog(&mut self, batch: &mut HudBatch) {
    // rust: if !self.dialog_open() {
    // rust: return;
}
    // rust: widgets::cover_frame();
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let cursor = self.cursor;
    // rust: let atlas = &self.gui.atlas;
    // rust: if self.player.is_none() {
            // In place of the connecting screen, on its background.
    // rust: batch.fill(atlas, 0.0, 0.0, w, h, rgba(20, 20, 20, 255));
}
    // rust: ui::menu_background(batch, atlas, 0.0, 0.0, w, h, self.player.is_some());
    // rust: if self.dialogs.warning {
    // rust: let (title, message, [disconnect, back]) = warning_texts();
            // DialogScreen.WarningScreen, a ConfirmScreen: its title and its
            // message.
    // rust: widgets::begin_screen(|| {
    // rust: ScreenInfo::new(
    // rust: "dialog/warning",
    // rust: widgets::join_for_narration(&[&title.plain(), &message.plain()]),
    // rust: )
    // rust: });
    // rust: let mut confirm = Confirm::new(&atlas.font, (w, h), &title, &message);
    // rust: confirm.declare_no();
    // rust: confirm.draw(batch, atlas, cursor, [&disconnect, &back]);
    // rust: return;
}
    // rust: if let Some(since) = self.dialogs.waiting {
            // HeaderAndFooterLayout(33, 0) centred: the title, the button 33 below.
    // rust: let ticks = (since.elapsed().as_millis() / 50) as u32;
    // rust: let (label, visible, active) = waiting_button(ticks);
    // rust: let title = Text::translate("gui.waitingForResponse.title", &[]);
    // rust: widgets::begin_screen(|| ScreenInfo::new("dialog/waiting", title.plain()));
            // WaitingForResponseScreen.tick: the close button turning active
            // after five seconds is narrated at once.
    // rust: if active && ticks < 102 {
    // rust: widgets::narrate_now();
}
    // rust: let top = ((h - 53.0) / 2.0).trunc();
    // rust: let tw = atlas.font.width_text(&title);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &title,
    // rust: ((w - tw) / 2.0).trunc(),
    // rust: top + 12.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: if visible {
    // rust: let (bx, by) = (((w - 200.0) / 2.0).trunc(), top + 33.0);
    // rust: let hover = ui::hovered(cursor, bx, by, 200.0, 20.0);
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: widgets::Action::Back,
    // rust: bx,
    // rust: by,
    // rust: 200.0,
    // rust: 20.0,
    // rust: &label,
    // rust: active,
    // rust: hover,
    // rust: );
}
    // rust: return;
}
    // rust: let Some(layout) = self.dialog_layout() else {
    // rust: return;
}
        // Out of `self` while it draws: an item body draws through `self`.
    // rust: let Some(mut open) = self.dialogs.open.take() else {
    // rust: return;
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let [ax, ay, aw, ah] = layout.area;
    // rust: open.scroll.clamp(ay, ay + ah, layout.content);
        // DialogScreen: titled by its dialog; a new dialog is a new screen.
    // rust: widgets::begin_screen(|| {
    // rust: let title = open.dialog.title.plain();
    // rust: ScreenInfo::new(format!("dialog:{title}"), title)
    // rust: });
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &open.dialog.title,
    // rust: layout.title.0,
    // rust: layout.title.1,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let [wx, wy, ww, wh] = layout.warning;
    // rust: let warn_hover = ui::hovered(cursor, wx, wy, ww, wh);
    // rust: horizon_client::widgets::record("warning", layout.warning, true);
        // The warning ImageButton: its narration message and tooltip, first
        // in tab order (group -10).
    // rust: widgets::narratable(|| {
    // rust: let t = |key: &str| Text::translate(key, &[]).plain();
    // rust: widgets::Narratable::button(
    // rust: t("menu.custom_screen_info.button_narration"),
    // rust: layout.warning,
    // rust: true,
    // rust: )
    // rust: .hovered(warn_hover)
    // rust: .hint(t("menu.custom_screen_info.tooltip"))
    // rust: .order(-10)
    // rust: });
    // rust: batch.sprite_scaled(
    // rust: atlas,
    // rust: WARNING_SPRITES[if warn_hover { 2 } else { 0 }],
    // rust: wx,
    // rust: wy,
    // rust: ww,
    // rust: wh,
    // rust: u32::MAX,
    // rust: );
    // rust: let buttons = open.dialog.buttons();
    // rust: let in_area = |y: f32| y >= ay && y < ay + ah;
    // rust: let mut tooltip = None;
    // rust: let mut item_tip = None;
    // rust: let mut start = None;
    // rust: let mut mark = None;
    // rust: for (part, clipped) in layout.placed(open.scroll.amount) {
    // rust: if clipped && start.is_none() {
    // rust: start = Some(batch.vertices.len());
    // rust: mark = Some(widgets::frame_mark());
    // rust: } else if !clipped && let Some(s) = start.take() {
    // rust: batch.clip_since(s, ax, ay, ax + aw, ay + ah);
    // rust: if let Some(mark) = mark.take() {
    // rust: widgets::clip_frame(mark, ay, ay + ah);
}
}
    // rust: match part {
    // rust: Part::Line(text, x, y) => {
    // rust: batch.text_styled(atlas, &text, x, y, u32::MAX, true);
                    // AbstractStringWidget: only the styled glyph under the
                    // pointer requests a hand, not the whole message widget.
    // rust: if (!clipped || in_area(cursor.1))
    // rust: && let Some(style) = horizon_client::dialog_screen::line_style_at(
    // rust: &atlas.font,
    // rust: &text,
    // rust: x,
    // rust: y,
    // rust: cursor,
    // rust: )
    // rust: {
    // rust: widgets::widget_cursor(style.click.is_some(), true);
    // rust: if let Some(hover) = style.hover {
    // rust: tooltip = Some(*hover);
}
}
}
    // rust: Part::Field { input, rect } => {
    // rust: let focused = open.focus == Some(input);
                    // The edit box is named after its input's label.
    // rust: let label = match &open.dialog.inputs[input].control {
    // rust: Control::Text { label, .. } if widgets::narrating() => label.plain(),
    // rust: _ => String::new(),
}
    // rust: match open.fields.get_mut(input) {
    // rust: Some(Some(Field::Line(edit))) => {
    // rust: [edit.x, edit.y, edit.width, edit.height] = rect;
    // rust: edit.focused = focused;
    // rust: if widgets::narrating() {
    // rust: edit.message = label;
}
    // rust: edit.draw(batch, atlas, None);
}
    // rust: Some(Some(Field::Multi(edit))) => {
    // rust: [edit.x, edit.y, edit.width, edit.height] = rect;
    // rust: edit.set_focused(focused);
    // rust: edit.draw(batch, atlas);
                            // MultiLineEditBox.updateWidgetNarration: as an EditBox.
    // rust: widgets::narratable(|| {
    // rust: widgets::Narratable::edit_box(label, edit.value(), rect)
    // rust: .focused(focused)
    // rust: });
}
    // rust: _ => {}
}
}
    // rust: Part::Check { input, rect } => {
    // rust: let [x, y, cw, ch] = rect;
    // rust: let hover = in_area(cursor.1) && ui::hovered(cursor, x, y, cw, ch);
    // rust: let on = open.values.get(input) == Some(&InputValue::Bool(true));
    // rust: let sprite = match (on, hover) {
    // rust: (true, true) => "gui/sprites/widget/checkbox_selected_highlighted",
    // rust: (true, false) => "gui/sprites/widget/checkbox_selected",
    // rust: (false, true) => "gui/sprites/widget/checkbox_highlighted",
    // rust: (false, false) => "gui/sprites/widget/checkbox",
}
    // rust: let Control::Boolean { label, .. } = &open.dialog.inputs[input].control else {
    // rust: continue;
}
    // rust: horizon_client::widgets::record(&label.plain(), rect, true);
    // rust: widgets::narratable(|| {
    // rust: widgets::Narratable::checkbox(label.plain(), on, rect, true).hovered(hover)
    // rust: });
    // rust: batch.sprite_scaled(atlas, sprite, x, y, BOX, BOX, u32::MAX);
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: label,
    // rust: x + BOX + 4.0,
    // rust: y + 4.0,
    // rust: rgba(224, 224, 224, 255),
    // rust: true,
    // rust: );
}
    // rust: Part::Cycle { input, rect } => {
    // rust: let [x, y, cw, ch] = rect;
    // rust: let hover = in_area(cursor.1) && ui::hovered(cursor, x, y, cw, ch);
    // rust: let Some(label) = open
    // rust: .values
    // rust: .get(input)
    // rust: .and_then(|v| open.dialog.inputs[input].control.message(v))
    // rust: else {
    // rust: continue;
}
    // rust: ui::button(batch, atlas, x, y, cw, ch, &label, true, hover);
                    // A CycleButton: the option a click moves to.
    // rust: widgets::last_narratable(|n| {
    // rust: let control = &open.dialog.inputs[input].control;
    // rust: let next = match (control, open.values.get(input)) {
    // rust: (
    // rust: Control::SingleOption { options, .. },
    // rust: Some(InputValue::Option(i)),
    // rust: ) if !options.is_empty() => {
    // rust: let (id, display, _) = &options[(i + 1) % options.len()];
    // rust: display.clone().unwrap_or_else(|| Text::literal(id)).plain()
}
    // rust: _ => String::new(),
}
    // rust: n.what = widgets::What::Cycle {
    // rust: message: label.plain(),
    // rust: next,
    // rust: active: true,
}
    // rust: });
}
    // rust: Part::Slider { input, rect } => {
    // rust: let [x, y, sw, sh] = rect;
    // rust: let hover = in_area(cursor.1) && ui::hovered(cursor, x, y, sw, sh);
    // rust: let Some((InputValue::Slider(position), Some(label))) = open
    // rust: .values
    // rust: .get(input)
    // rust: .map(|v| (v.clone(), open.dialog.inputs[input].control.message(v)))
    // rust: else {
    // rust: continue;
}
    // rust: let held = open.dragging == Some(input);
    // rust: ui::slider(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: y,
    // rust: sw,
    // rust: &label,
    // rust: position,
    // rust: hover || held,
    // rust: true,
    // rust: held,
    // rust: );
}
    // rust: Part::Item { body, rect } => {
    // rust: let [x, y, iw, ih] = rect;
    // rust: let Some(Body::Item {
    // rust: item,
    // rust: show_decorations,
    // rust: show_tooltip,
    // rust: ..
    // rust: }) = open.dialog.body.get(body)
    // rust: else {
    // rust: continue;
}
    // rust: let Some(stack) = horizon_items::item_nbt::item_from_nbt(item) else {
    // rust: continue;
}
                    // ItemDisplayWidget: the item at its corner, then its decorations.
    // rust: self.draw_item_model(batch, &stack, x, y);
    // rust: if *show_decorations {
    // rust: self.draw_item_decorations(batch, &stack, x, y, None);
}
    // rust: if *show_tooltip && in_area(cursor.1) && ui::hovered(cursor, x, y, iw, ih) {
    // rust: item_tip = Some(stack);
}
}
    // rust: Part::Button { index, rect } => {
    // rust: let [x, y, bw, bh] = rect;
    // rust: let hover =
    // rust: (!clipped || in_area(cursor.1)) && ui::hovered(cursor, x, y, bw, bh);
    // rust: let b = buttons[index];
    // rust: if open.dialog.escape_button() == Some(index) {
    // rust: let action = widgets::Action::Cancel;
    // rust: ui::action_button(
    // rust: batch, atlas, action, x, y, bw, bh, &b.label, true, hover,
    // rust: );
    // rust: } else {
    // rust: ui::button(batch, atlas, x, y, bw, bh, &b.label, true, hover);
}
    // rust: if let Some(t) = &b.tooltip {
    // rust: widgets::last_narratable(|n| n.hint = Some(t.plain()));
}
    // rust: if hover && let Some(t) = &b.tooltip {
    // rust: tooltip = Some(t.clone());
}
}
}
}
    // rust: if let Some(s) = start {
    // rust: batch.clip_since(s, ax, ay, ax + aw, ay + ah);
}
    // rust: if let Some(mark) = mark {
    // rust: widgets::clip_frame(mark, ay, ay + ah);
}
    // rust: if layout.content > ah {
            // A controller's focus step goes through the body's hidden parts before it leaves.
    // rust: widgets::scroll_area(layout.area, open.scroll.amount, layout.content - ah);
    // rust: ui::scrollbar(
    // rust: batch,
    // rust: atlas,
    // rust: ax + aw - 6.0,
    // rust: ay,
    // rust: ay + ah,
    // rust: layout.content,
    // rust: open.scroll.amount,
    // rust: );
}
    // rust: if warn_hover {
    // rust: tooltip = Some(Text::translate("menu.custom_screen_info.tooltip", &[]));
}
    // rust: if let Some(t) = tooltip {
    // rust: let lines: Vec<Text> = atlas
    // rust: .font
    // rust: .split_lines(&t, 170.0)
    // rust: .into_iter()
    // rust: .map(|l| l.0)
    // rust: .collect();
    // rust: ui::tooltip(batch, atlas, &lines, cursor);
}
    // rust: self.dialogs.open = Some(open);
    // rust: if let Some(stack) = item_tip {
    // rust: self.draw_stack_tooltip(batch, &stack, cursor.0, cursor.1);
}
}

    /// A left click on a dialog screen.
    // rust: pub(super) fn dialog_click(&mut self) -> Result<()> {
    // rust: let cursor = self.cursor;
    // rust: if self.dialogs.warning {
    // rust: let (title, message, _) = warning_texts();
    // rust: let answer = Confirm::new(&self.gui.atlas.font, self.gui_size(), &title, &message)
    // rust: .answer_at(cursor);
    // rust: match answer {
    // rust: Some(true) => {
    // rust: self.audio.play_button_click();
    // rust: let reason = Text::translate("menu.custom_screen_info.disconnect", &[]);
    // rust: return self.leave_server(Some(reason.plain()));
}
    // rust: Some(false) => {
    // rust: self.audio.play_button_click();
    // rust: self.dialogs.warning = false;
    // rust: if !self.dialog_open() {
    // rust: self.dialog_closed();
}
}
    // rust: None => {}
}
    // rust: return Ok(());
}
    // rust: if let Some(since) = self.dialogs.waiting {
    // rust: let (w, h) = self.gui_size();
    // rust: let active = waiting_button((since.elapsed().as_millis() / 50) as u32).2;
    // rust: let (bx, by) = (
    // rust: ((w - 200.0) / 2.0).trunc(),
    // rust: ((h - 53.0) / 2.0).trunc() + 33.0,
    // rust: );
    // rust: if active && ui::hovered(cursor, bx, by, 200.0, 20.0) {
    // rust: self.audio.play_button_click();
    // rust: self.dialogs.waiting = None;
    // rust: self.dialog_closed();
}
    // rust: return Ok(());
}
    // rust: let Some(layout) = self.dialog_layout() else {
    // rust: return Ok(());
}
    // rust: let [wx, wy, ww, wh] = layout.warning;
    // rust: if ui::hovered(cursor, wx, wy, ww, wh) {
    // rust: self.audio.play_button_click();
    // rust: self.dialogs.warning = true;
    // rust: return Ok(());
}
    // rust: let shift = self.modifiers.shift_key();
    // rust: let Some(open) = self.dialogs.open.as_mut() else {
    // rust: return Ok(());
}
    // rust: let [_, ay, _, ah] = layout.area;
    // rust: let mut action = None;
    // rust: let mut text_click: Option<ClickEvent> = None;
    // rust: open.focus = None;
    // rust: for (part, clipped) in layout.placed(open.scroll.amount) {
    // rust: if clipped && !(cursor.1 >= ay && cursor.1 < ay + ah) {
    // rust: continue;
}
    // rust: match part {
    // rust: Part::Field {
    // rust: input,
    // rust: rect: [x, y, w, h],
    // rust: } if ui::hovered(
    // rust: cursor,
    // rust: x,
    // rust: y,
                    // A multiline box answers over its scroll bar too.
    // rust: w + if matches!(open.fields.get(input), Some(Some(Field::Multi(_)))) {
    // rust: 6.0
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: h,
    // rust: ) =>
    // rust: {
    // rust: open.focus = Some(input);
    // rust: match open.fields.get_mut(input) {
    // rust: Some(Some(Field::Line(edit))) => {
    // rust: edit.focused = true;
    // rust: edit.click(&self.gui.atlas, cursor.0, false, false);
}
    // rust: Some(Some(Field::Multi(edit))) => {
    // rust: [edit.x, edit.y, edit.width, edit.height] = [x, y, w, h];
    // rust: edit.set_focused(true);
    // rust: edit.click(&self.gui.atlas.font, cursor, shift, false);
    // rust: open.selecting = Some(input);
}
    // rust: _ => {}
}
}
    // rust: Part::Check {
    // rust: input,
    // rust: rect: [x, y, w, h],
    // rust: } if ui::hovered(cursor, x, y, w, h) => {
    // rust: if let Some(InputValue::Bool(b)) = open.values.get_mut(input) {
    // rust: *b = !*b;
}
    // rust: action = Some(None);
}
    // rust: Part::Cycle {
    // rust: input,
    // rust: rect: [x, y, w, h],
    // rust: } if ui::hovered(cursor, x, y, w, h) => {
                    // CycleButton.onPress: Shift goes back.
    // rust: cycle(open, input, if shift { -1 } else { 1 });
    // rust: action = Some(None);
}
    // rust: Part::Slider {
    // rust: input,
    // rust: rect: [x, y, w, h],
    // rust: } if ui::hovered(cursor, x, y, w, h) => {
    // rust: open.focus = Some(input);
    // rust: open.dragging = Some(input);
    // rust: if let Some(v) = open.values.get_mut(input) {
    // rust: *v = InputValue::Slider(ui::slider_value(x, w, cursor.0));
}
}
    // rust: Part::Button {
    // rust: index,
    // rust: rect: [x, y, w, h],
    // rust: } if ui::hovered(cursor, x, y, w, h) => {
    // rust: action = Some(Some(index));
}
                // AbstractStringWidget.setComponentClickHandler: the click event
                // of the styled text under a centred message line.
    // rust: Part::Line(line, x, y) if text_click.is_none() => {
    // rust: text_click = horizon_client::dialog_screen::line_style_at(
    // rust: &self.gui.atlas.font,
    // rust: &line,
    // rust: x,
    // rust: y,
    // rust: cursor,
    // rust: )
    // rust: .and_then(|style| style.click);
}
    // rust: _ => {}
}
}
    // rust: let Some(action) = action else {
            // A text click runs its event (DialogScreen.runAction) with no button sound.
    // rust: let click = match text_click {
    // rust: Some(ClickEvent::OpenUrl(url)) => Click::OpenUrl(url),
    // rust: Some(ClickEvent::ChangePage(page)) => Click::ChangePage(page),
    // rust: Some(ClickEvent::SuggestCommand(command)) => Click::SuggestCommand(command),
    // rust: Some(ClickEvent::RunCommand(command)) => Click::RunCommand(command),
    // rust: Some(ClickEvent::CopyToClipboard(value)) => Click::CopyToClipboard(value),
    // rust: Some(ClickEvent::ShowDialog(dialog)) => Click::ShowDialog(dialog),
    // rust: Some(ClickEvent::Custom { id, payload }) => Click::Custom { id, payload },
    // rust: Some(ClickEvent::OpenFile(_)) | None => return Ok(()),
}
    // rust: let after = open.dialog.after_action;
    // rust: return self.run_dialog_action(Some(click), after);
}
    // rust: self.audio.play_button_click();
    // rust: let Some(index) = action else {
    // rust: return Ok(());
}
    // rust: let Some(open) = self.dialogs.open.as_mut() else {
    // rust: return Ok(());
}
    // rust: Self::dialog_values(open);
    // rust: let d = &open.dialog;
    // rust: let click = d.buttons()[index]
    // rust: .action
    // rust: .as_ref()
    // rust: .and_then(|a| a.click(&d.inputs, &open.values));
    // rust: let after = d.after_action;
    // rust: self.run_dialog_action(click, after)
}

    /// The mouse wheel over a dialog: a cycle button under it takes the
    /// step, else the body scrolls 10 a step.
    // rust: pub(super) fn dialog_scroll(&mut self, delta: f32) {
    // rust: let Some(layout) = self.dialog_layout() else {
    // rust: return;
}
    // rust: let cursor = self.cursor;
    // rust: let stick_scroll = self.pad_stick_scroll();
        // A focus step past the body's edge scrolls the body, not a box it's leaving.
    // rust: let step_scroll = self.pad_step_scroll();
    // rust: if let Some(open) = self.dialogs.open.as_mut() {
    // rust: let [_, ay, _, ah] = layout.area;
    // rust: if delta != 0.0 && cursor.1 >= ay && cursor.1 < ay + ah {
    // rust: let hovered_cycle =
    // rust: layout
    // rust: .placed(open.scroll.amount)
    // rust: .find_map(|(part, _)| match part {
    // rust: Part::Cycle {
    // rust: input,
    // rust: rect: [x, y, w, h],
    // rust: } if ui::hovered(cursor, x, y, w, h) => Some(input),
    // rust: _ => None,
    // rust: });
    // rust: if let Some(input) = hovered_cycle.filter(|_| !stick_scroll) {
                    // CycleButton.mouseScrolled: up goes back.
    // rust: cycle(open, input, if delta > 0.0 { -1 } else { 1 });
    // rust: return;
}
                // AbstractScrollArea.mouseScrolled: a multiline box takes the wheel.
    // rust: let text = layout
    // rust: .placed(open.scroll.amount)
    // rust: .find_map(|(part, _)| match part {
    // rust: Part::Field { input, rect } => match open.fields.get(input) {
    // rust: Some(Some(Field::Multi(_)))
    // rust: if ui::hovered(
    // rust: cursor,
    // rust: rect[0],
    // rust: rect[1],
    // rust: rect[2] + 6.0,
    // rust: rect[3],
    // rust: ) =>
    // rust: {
    // rust: Some(input)
}
    // rust: _ => None,
    // rust: },
    // rust: _ => None,
    // rust: });
    // rust: if let Some(Some(Field::Multi(edit))) = text
    // rust: .filter(|_| !step_scroll)
    // rust: .and_then(|i| open.fields.get_mut(i))
    // rust: {
    // rust: edit.wheel(delta);
    // rust: return;
}
}
    // rust: open.scroll.wheel(delta, 10.0, ay, ay + ah, layout.content);
}
}

    /// The pointer moved with a slider held (`AbstractSliderButton.onDrag`).
    // rust: pub(super) fn dialog_drag(&mut self) {
    // rust: let (cursor, shift) = (self.cursor, self.modifiers.shift_key());
    // rust: if let Some(open) = self.dialogs.open.as_mut()
    // rust: && let Some(Some(Field::Multi(edit))) =
    // rust: open.selecting.and_then(|i| open.fields.get_mut(i))
    // rust: {
            // MultiLineEditBox.onDrag.
    // rust: edit.drag(&self.gui.atlas.font, cursor, shift);
}
    // rust: let Some(input) = self.dialogs.open.as_ref().and_then(|o| o.dragging) else {
    // rust: return;
}
    // rust: let Some(layout) = self.dialog_layout() else {
    // rust: return;
}
    // rust: let x = self.cursor.0;
    // rust: let Some(open) = self.dialogs.open.as_mut() else {
    // rust: return;
}
    // rust: let slider = layout.body.iter().find_map(|p| match p {
    // rust: Part::Slider { input: i, rect } if *i == input => Some(*rect),
    // rust: _ => None,
    // rust: });
    // rust: if let (Some([sx, _, sw, _]), Some(value)) = (slider, open.values.get_mut(input)) {
    // rust: *value = InputValue::Slider(ui::slider_value(sx, sw, x));
}
}

    /// The left button released: a held slider lets go and clicks.
    // rust: pub(super) fn dialog_release(&mut self) {
    // rust: if let Some(open) = self.dialogs.open.as_mut() {
    // rust: if let Some(Some(Field::Multi(edit))) =
    // rust: open.selecting.take().and_then(|i| open.fields.get_mut(i))
    // rust: {
    // rust: edit.release();
}
    // rust: if open.dragging.take().is_some() {
    // rust: self.audio.play_button_click();
}
}
}

    /// A key pressed on a dialog screen: Escape closes what allows it, Tab
    /// moves between the text inputs, the rest goes to the focused one
    /// (`shortcut`: the press as an edit shortcut; `text`: what it types).
    // rust: pub(super) fn dialog_key(
    // rust: &mut self,
    // rust: key: KeyCode,
    // rust: shortcut: Option<EditShortcut>,
    // rust: text: Option<&str>,
    // rust: ) -> Result<()> {
    // rust: let escape = key == KeyCode::Escape;
    // rust: if self.dialogs.warning {
    // rust: if escape {
    // rust: self.dialogs.warning = false;
    // rust: if !self.dialog_open() {
    // rust: self.dialog_closed();
}
}
    // rust: return Ok(());
}
    // rust: if let Some(since) = self.dialogs.waiting {
            // shouldCloseOnEsc: once Back works.
    // rust: if escape && waiting_button((since.elapsed().as_millis() / 50) as u32).2 {
    // rust: self.dialogs.waiting = None;
    // rust: self.dialog_closed();
}
    // rust: return Ok(());
}
    // rust: let ctrl = self.modifiers.control_key() || self.modifiers.super_key();
    // rust: let shift = self.modifiers.shift_key();
    // rust: let Some(open) = self.dialogs.open.as_mut() else {
    // rust: return Ok(());
}
    // rust: if escape {
    // rust: if !open.dialog.can_close_with_escape {
    // rust: return Ok(());
}
            // onClose: the cancel action, and the screen closes.
    // rust: Self::dialog_values(open);
    // rust: let d = &open.dialog;
    // rust: let click = d.on_cancel().and_then(|a| a.click(&d.inputs, &open.values));
    // rust: return self.run_dialog_action(click, AfterAction::Close);
}
    // rust: if key == KeyCode::Tab {
    // rust: let texts: Vec<usize> = (0..open.fields.len())
    // rust: .filter(|&i| open.fields[i].is_some())
    // rust: .collect();
    // rust: if !texts.is_empty() {
    // rust: let at = open.focus.and_then(|f| texts.iter().position(|&i| i == f));
    // rust: let next = match at {
    // rust: None if shift => texts.len() - 1,
    // rust: None => 0,
    // rust: Some(p) if shift => (p + texts.len() - 1) % texts.len(),
    // rust: Some(p) => (p + 1) % texts.len(),
}
    // rust: open.focus = Some(texts[next]);
}
    // rust: return Ok(());
}
    // rust: if let Some(focus) = open.focus
    // rust: && let Some(input) = open.dialog.inputs.get(focus)
    // rust: && let Control::NumberRange {
    // rust: start,
    // rust: end,
    // rust: step,
    // rust: width,
    // rust: ..
    // rust: } = &input.control
    // rust: && let Some(InputValue::Slider(val)) = open.values.get_mut(focus)
    // rust: && matches!(key, KeyCode::ArrowLeft | KeyCode::ArrowRight)
    // rust: {
    // rust: let delta = if let Some(step) = step {
    // rust: let range = (end - start).abs();
    // rust: if range > 0.0 { *step / range } else { 0.01 }
    // rust: } else {
    // rust: 1.0 / (*width as f32 - 8.0).max(1.0)
}
    // rust: let step_sign = if key == KeyCode::ArrowRight {
    // rust: delta
    // rust: } else {
    // rust: -delta
}
    // rust: *val = (*val + step_sign).clamp(0.0, 1.0);
    // rust: return Ok(());
}
    // rust: let Some(Some(edit)) = open.focus.and_then(|f| open.fields.get_mut(f)) else {
    // rust: return Ok(());
}
    // rust: let font = &self.gui.atlas.font;
    // rust: if let Some(shortcut) = shortcut {
    // rust: edit.shortcut(font, shortcut, &mut self.clipboard);
    // rust: return Ok(());
}
    // rust: if edit.key(font, key, ctrl, shift) {
    // rust: return Ok(());
}
    // rust: let typed: String = text
    // rust: .unwrap_or_default()
    // rust: .chars()
    // rust: .filter(|c| !c.is_control())
    // rust: .collect();
    // rust: if !typed.is_empty() {
    // rust: edit.insert_text(font, &typed);
}
    // rust: Ok(())
}

    /// Whether the open dialog has a text input.
    // rust: pub(super) fn dialog_has_text_field(&self) -> bool {
    // rust: self.dialogs
    // rust: .open
    // rust: .as_ref()
    // rust: .is_some_and(|open| open.fields.iter().any(Option::is_some))
}

    /// `type TEXT` with a dialog open: into the focused text input, or the
    /// first one.
    // rust: pub(super) fn dialog_type(&mut self, text: &str) -> bool {
    // rust: let Some(open) = self.dialogs.open.as_mut() else {
    // rust: return false;
}
    // rust: let focus = open
    // rust: .focus
    // rust: .or_else(|| open.fields.iter().position(Option::is_some));
    // rust: let Some(Some(edit)) = focus.and_then(|f| open.fields.get_mut(f)) else {
    // rust: return false;
}
    // rust: open.focus = focus;
    // rust: edit.insert_text(&self.gui.atlas.font, text);
    // rust: true
}

    /// What `state` reports: the open dialog and its values, or the waiting
    /// and warning screens.
    // rust: pub(super) fn dialog_status(&self) -> serde_json::Value {
    // rust: let d = &self.dialogs;
    // rust: let screen = if d.warning {
    // rust: Some("warning")
    // rust: } else if d.waiting.is_some() {
    // rust: Some("waiting_for_response")
    // rust: } else {
    // rust: None
}
    // rust: let open = d.open.as_ref().map(|open| {
    // rust: let mut values = open.values.clone();
    // rust: for (value, field) in values.iter_mut().zip(&open.fields) {
    // rust: if let Some(f) = field {
    // rust: *value = InputValue::Text(f.value());
}
}
    // rust: open.dialog.json(&values)
    // rust: });
    // rust: serde_json::json!({ "open": open, "screen": screen })
}
}
