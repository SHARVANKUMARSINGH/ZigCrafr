//! Transpiled from Horizon Rust crate
package horizon_client_render_chat

import "core:fmt"
import "core:mem"
import "core:math"

// Chat: the message list (ChatComponent: wrapping, 100-line history,
// 200-tick fade, scrolling, system message indicator) and the chat screen
// (ChatScreen + EditBox + CommandSuggestions: history navigation, argument
// colouring, usage hints, parse errors and tab completion).
// use crate::{
    // rust: command::{
    // rust: Dispatcher, ParseResults, Registries, Suggestion, SuggestionsBuilder, merge_suggestions,
    // rust: },
    // rust: hud::{HudAtlas, HudBatch},
    // rust: hud_layout::{self, GuiDraw, PoseOp},
    // rust: screen_draw::{self as d, Draw, Measure, TextField},
    // rust: text::{self, ClickEvent, Style, Text},
}

    // rust: mod tests;

// `CommandHistory.PERSISTED_COMMANDS_FILE_NAME` and its size cap.
COMMAND_HISTORY_FILE :: "command_history.txt"
MAX_PERSISTED_COMMAND_HISTORY :: 50
// GuiMessageTag.systemSinglePlayer's indicator colour.
SYSTEM_INDICATOR :: 0xD0D0D0
// `GuiMessageTag.CHAT_MODIFIED_INDICATOR_COLOR`.
MODIFIED_INDICATOR :: 0x60_6060
// A player message's signature (MessageSignature), which names it to a
// server's deletion.
    // rust: pub type Signature = horizon_protocol::secure_chat::Signature;
// How long a message shows before a deletion replaces it
// (`ChatComponent.deleteMessageOrDelay`: `addedTime + 60`).
DELETION_DELAY :: 60
// The smooth chat extra: the ticks a new line takes to slide in and fade in,
// and how far left of its place it starts (GUI pixels).
INTRO_TICKS :: 5.0
INTRO_WIDTH :: 12.0

// `ChatVisiblity`: the Chat option's three values.
ChatVisibility :: enum {
    Full,
    System,
    Hidden,
}
    // rust: impl ChatVisibility {
    // Options.chatVisibility's saved value (0 full, 1 system, 2 hidden).
from_option :: proc(value: u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match value {
    // rust: 0 => Self::Full,
    // rust: 1 => Self::System,
    // rust: _ => Self::Hidden,
}
}
}

// `ChatAbilities`: what the Chat option allows, as `Minecraft.computeChatAbilities`
// derives it from the visibility alone (`ChatRestriction`).
ChatAbilities :: struct {
    send_messages: bool,
    send_commands: bool,
    receive_player_messages: bool,
    receive_system_messages: bool,
}
    // rust: impl ChatAbilities {
    // `ChatRestriction.CHAT_AND_COMMANDS_DISABLED_BY_OPTIONS` (Hidden) takes
    // chat, commands, player messages and system messages;
    // `CHAT_DISABLED_BY_OPTIONS` (System) takes the chat and player messages.
new :: proc(visibility: ChatVisibility) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match visibility {
    // rust: ChatVisibility::Full => Self {
    // rust: send_messages: true,
    // rust: send_commands: true,
    // rust: receive_player_messages: true,
    // rust: receive_system_messages: true,
    // rust: },
    // rust: ChatVisibility::System => Self {
    // rust: send_messages: false,
    // rust: send_commands: true,
    // rust: receive_player_messages: false,
    // rust: receive_system_messages: true,
    // rust: },
    // rust: ChatVisibility::Hidden => Self {
    // rust: send_messages: false,
    // rust: send_commands: false,
    // rust: receive_player_messages: false,
    // rust: receive_system_messages: false,
    // rust: },
}
}
    // `visibleMessagesFilter`: the client's own lines always show.
shows :: proc(self: ^Self, source: ChatSource) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match source {
    // rust: ChatSource::Player => self.receive_player_messages,
    // rust: ChatSource::Server => self.receive_system_messages,
    // rust: ChatSource::Client => true,
}
}
    // `ChatAbilities.hasAnyRestrictions`: the Chat option takes something.
any_restriction :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: *self != Self::new(ChatVisibility::Full)
}
    // Whether the chat screen may send `input` (`hasAllowedInput`).
allows :: proc(self: ^Self, input: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if input.starts_with('/') {
    // rust: self.send_commands
    // rust: } else {
    // rust: self.send_messages
}
}
}

    // rust: impl Default for ChatAbilities {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(ChatVisibility::Full)
}
}

// Where a chat line came from (`GuiMessageSource`): the visibility filters
// player messages and the server's, while the client's own always show.
ChatSource :: enum {
    Player,
    Server,
    Client,
}

// The chat options (doubles, as vanilla keeps them).
ChatOptions :: struct {
    opacity: f64,
    background_opacity: f64,
    scale: f64,
    width: f64,
    height_focused: f64,
    height_unfocused: f64,
    line_spacing: f64,
    // Chat Colors (`chatColors`): legacy `§` codes format the text, or are
    // left out.
    colors: bool,
}
    // rust: impl Default for ChatOptions {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: colors: true,
    // rust: opacity: 1.0,
    // rust: background_opacity: 0.5,
    // rust: scale: 1.0,
    // rust: width: 1.0,
    // rust: height_focused: 1.0,
    // rust: height_unfocused: 70.0 / 160.0,
    // rust: line_spacing: 0.0,
}
}
}
    // rust: impl ChatOptions {
    // ChatComponent.getWidth/getHeight.
width_px :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (self.width * 280.0 + 40.0).floor() as i32
}
height_px :: proc(self: ^Self, focused: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: ((if focused {
    // rust: self.height_focused
    // rust: } else {
    // rust: self.height_unfocused
    // rust: }) * 160.0
    // rust: + 20.0)
    // rust: .floor() as i32
}
    // `getLineHeight`.
line_height :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (9.0 * (self.line_spacing + 1.0)) as i32
}
}
Message :: struct {
    added: u64,
    // Local hour and minute it came in (PvP & HUD's chat timestamps).
    time: (u8,
    // How many times in a row it came (PvP & HUD's compact chat), 1 for once.
    repeats: u32,
    // The lines it wrapped to the last time it was laid out (0 while hidden).
    wrapped: uint,
    content: Text,
    tag: Maybe(std::sync::^Tag),
    source: ChatSource,
    // `GuiMessage.signature`: a signed player message's, for deletion.
    signature: Maybe(^Signature),
}
// A wrapped line (`GuiMessage.Line`).
Line :: struct {
    added: u64,
    content: Text,
    tag: Maybe(std::sync::^Tag),
    // The whole message's text, for PvP & HUD's copy on click.
    message: std::sync::^str,
}

// PvP & HUD's chat options (`pvp::ChatQol`): each changes the lines, so a change rewraps them.
ChatQol :: struct {
    // Each message starts with the local time it came in.
    timestamps: bool,
    // A message equal to the one before it raises that one's count ("(x3)") instead of adding lines.
    compact: bool,
}
// Whether `next` repeats `last`: the same text, kind and tag, neither one signed (a server may
// delete a signed message by itself).
repeats :: proc(last: ^Message, next: ^Message) -> b {
    // Ported from Horizon
    return {}
}
    // rust: last.signature.is_none()
    // rust: && next.signature.is_none()
    // rust: && last.source == next.source
    // rust: && last.tag == next.tag
    // rust: && last.content == next.content
}
// The local hour and minute.
local_time :: proc() -> ( {
    // Ported from Horizon
    return {}
}
//     use chrono::Timelike;
    // rust: let now = chrono::Local::now();
    // rust: (now.hour() as u8, now.minute() as u8)
}

// `GuiMessageTag`: the bar at the left of a message's lines, the tooltip
// over it, and for a modified message the icon after each line.
Tag :: struct {
    color: u32,
    // `GuiMessageTag.Icon.CHAT_MODIFIED`.
    icon: bool,
    text: Text,
}
    // rust: impl Tag {
    // `GuiMessageTag.systemSinglePlayer`, in `color`.
system_single_player :: proc(color: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: color,
    // rust: icon: false,
    // rust: text: Text::translate("chat.tag.system_single_player", &[]),
}
}
    // `GuiMessageTag.chatNotSecure`.
not_secure :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: color: SYSTEM_INDICATOR,
    // rust: icon: false,
    // rust: text: Text::translate("chat.tag.not_secure", &[]),
}
}
    // `GuiMessageTag.chatError`: red (`CHAT_ERROR`, 16733525), the tooltip `chat.tag.error`.
chat_error :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: color: 0xFF_5555,
    // rust: icon: false,
    // rust: text: Text::translate("chat.tag.error", &[]),
}
}
    // `GuiMessageTag.chatModified`: the tooltip adds the original content in grey.
modified :: proc(original_content: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: color: MODIFIED_INDICATOR,
    // rust: icon: true,
    // rust: text: Text::empty()
    // rust: .append(Text::translate("chat.tag.modified", &[]))
    // rust: .append(Text::literal("\n"))
    // rust: .append(Text::literal(original_content).with_color(text::GRAY)),
}
}
}

// `ChatComponent.AlphaCalculator.timeBased`: opaque for 180 ticks, then
// fading out quadratically over 20.
time_alpha :: proc(ticks: f32, added: u64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut t = 1.0 - (ticks - added as f32) / 200.0;
    // rust: t = (t * 10.0).clamp(0.0, 1.0);
    // rust: t * t
}
Chat :: struct {
    messages: [dynamic]Message,
    // Wrapped lines, newest first.
    lines: [dynamic]Line,
    // Sent messages and commands (ChatComponent.recentChat).
    recent: [dynamic]string,
    // `CommandHistory`: the last commands, kept in `command_history.txt`
    // in the game folder once `load_history` has set it.
    commands: [dynamic]string,
    history_file: Maybe(std::path::PathBuf),
    scroll: uint,
    new_since_scroll: bool,
    options: ChatOptions,
    // The smooth chat extra: a new line slides in from the left while it
    // fades in, instead of appearing whole.
    smooth: bool,
    // The smooth chat extra: no indicator bar at the left of a line.
    hide_indicator: bool,
    // Messages printed to stdout as `[CHAT]` (vanilla logs them).
    log: bool,
    // Messages added since the start, for the control socket's events.
    received: u64,
    // The Chat option's `visibleMessageFilter` (`set_abilities`).
    abilities: ChatAbilities,
    // `ChatComponent.messageDeletionQueue`: deletions of messages still
    // too new to replace, with the tick from which they may be.
    deletions: [dynamic](Box<Signature,
    qol: ChatQol,
    // PvP & HUD's chat search is on: the screen shows its prompt.
    search_prompt: bool,
    // PvP & HUD's chat search: only messages holding this (lower case) show.
    search: Maybe(string),
    // The tests' clock in place of the local time.
    clock: Option<(u8,
}
    // rust: impl Chat {
lines_per_page :: proc(self: ^Self, focused: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (self.options.height_px(focused) / self.options.line_height().max(1)) as usize
}
    // The wrapping width, `Mth.floor(getWidth() / getScale())`.
max_width :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (f64::from(self.options.width_px()) / self.options.scale).floor() as i32
}
    // ChatComponent.addMessage: wrap, prepend and trim to 100 lines. A
    // message the Chat option hides is dropped, unlogged.
    // rust: pub fn add(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: content: Text,
    // rust: indicator: Option<u32>,
    // rust: source: ChatSource,
    // rust: ticks: u64,
    // rust: focused: bool,
    // rust: ) {
    // rust: let tag = indicator.map(|color| std::sync::Arc::new(Tag::system_single_player(color)));
    // rust: self.add_message(&atlas.font, content, tag, source, ticks, focused);
}
    // `add` of a player message with its signature, which a server's
    // deletion names it by (`GuiMessage.signature`).
    // rust: pub fn add_signed(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: content: Text,
    // rust: signature: Option<Signature>,
    // rust: tag: Option<Tag>,
    // rust: ticks: u64,
    // rust: focused: bool,
    // rust: ) {
    // rust: self.add_player_message(&atlas.font, content, signature, tag, ticks, focused);
}
    // rust: fn add_signed_message(
    // rust: &mut self,
    // rust: font: &crate::font::Font,
    // rust: content: Text,
    // rust: signature: Option<Signature>,
    // rust: ticks: u64,
    // rust: focused: bool,
    // rust: ) {
    // rust: self.add_player_message(font, content, signature, None, ticks, focused);
}
    // `ChatComponent.addPlayerMessage`: the tag the message's trust level made.
    // rust: fn add_player_message(
    // rust: &mut self,
    // rust: font: &crate::font::Font,
    // rust: content: Text,
    // rust: signature: Option<Signature>,
    // rust: tag: Option<Tag>,
    // rust: ticks: u64,
    // rust: focused: bool,
    // rust: ) {
    // rust: self.push_message(
    // rust: font,
    // rust: Message {
    // rust: added: ticks,
    // rust: time: (0, 0),
    // rust: repeats: 1,
    // rust: wrapped: 0,
    // rust: content,
    // rust: tag: tag.map(std::sync::Arc::new),
    // rust: source: ChatSource::Player,
    // rust: signature: signature.map(Box::new),
    // rust: },
    // rust: focused,
    // rust: );
}
    // rust: fn add_message(
    // rust: &mut self,
    // rust: font: &crate::font::Font,
    // rust: content: Text,
    // rust: tag: Option<std::sync::Arc<Tag>>,
    // rust: source: ChatSource,
    // rust: ticks: u64,
    // rust: focused: bool,
    // rust: ) {
    // rust: self.push_message(
    // rust: font,
    // rust: Message {
    // rust: added: ticks,
    // rust: time: (0, 0),
    // rust: repeats: 1,
    // rust: wrapped: 0,
    // rust: content,
    // rust: tag,
    // rust: source,
    // rust: signature: None,
    // rust: },
    // rust: focused,
    // rust: );
}
push_message :: proc(self: ^Self, font: ^crate::font::Font, mut message: Message, focused: bool) {
}
    // rust: if !self.abilities.shows(message.source) {
    // rust: return;
}
        // ChatComponent.logChatMessage: every message shown is in the log.
    // rust: let plain = message.content.plain();
    // rust: crate::logging::write_only(log::Level::Info, &format!("[CHAT] {plain}"));
    // rust: if self.log {
    // rust: println!("[CHAT] {plain}");
}
    // rust: message.time = self.now();
    // rust: self.received += 1;
    // rust: if self.qol.compact
    // rust: && let Some(last) = self.messages.first()
    // rust: && repeats(last, &message)
    // rust: {
            // The newest lines are that message's: they make way for its lines with the count.
    // rust: let mut last = self.messages.remove(0);
    // rust: let shown = last.wrapped.min(self.lines.len());
    // rust: self.lines.drain(..shown);
            // A reader scrolled up keeps their view: only lines the merge adds move it.
    // rust: let (scroll, new_since_scroll) = (self.scroll, self.new_since_scroll);
    // rust: last.repeats += 1;
    // rust: last.added = message.added;
    // rust: last.time = message.time;
    // rust: last.wrapped = self.add_lines(font, &last, focused);
    // rust: if scroll > 0 {
    // rust: self.scroll = scroll;
    // rust: self.new_since_scroll = new_since_scroll;
    // rust: self.scroll_by(last.wrapped as i32 - shown as i32, focused);
}
    // rust: self.messages.insert(0, last);
    // rust: return;
}
    // rust: message.wrapped = self.add_lines(font, &message, focused);
    // rust: self.messages.insert(0, message);
    // rust: self.messages.truncate(100);
}
now :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(time) = self.clock {
    // rust: return time;
}
    // rust: local_time()
}
    // The lines `message` wraps to (none when the chat search hides it), added newest first.
add_lines :: proc(self: ^Self, font: ^crate::font::Font, message: ^Message, focused: bool) -> u {
    // Ported from Horizon
    return {}
}
        // What the chat shows: legacy `§` codes format the text, they aren't part of it.
    // rust: let whole = message.content.strip_legacy().plain();
    // rust: if let Some(query) = &self.search
    // rust: && !whole.to_lowercase().contains(query.as_str())
    // rust: {
    // rust: return 0;
}
    // rust: let whole: std::sync::Arc<str> = whole.into();
    // rust: let mut count = 0;
        // GuiMessage.splitLines: room for the tag's icon (its width, 4 before and 2 after).
    // rust: let icon = if message.tag.as_ref().is_some_and(|tag| tag.icon) {
    // rust: 9 + 4 + 2
    // rust: } else {
    // rust: 0
}
    // rust: let width = self.max_width() - icon;
    // rust: let content = self.message_text(message);
    // rust: for line in font.wrap_components(&content, width) {
    // rust: count += 1;
    // rust: if focused && self.scroll > 0 {
    // rust: self.new_since_scroll = true;
    // rust: self.scroll_by(1, focused);
}
    // rust: self.lines.insert(
    // rust: 0,
    // rust: Line {
    // rust: added: message.added,
    // rust: content: line,
    // rust: tag: message.tag.clone(),
    // rust: message: whole.clone(),
    // rust: },
    // rust: );
}
    // rust: self.lines.truncate(100);
    // rust: count
}
    // What a message's lines wrap (ComponentRenderUtils.wrapComponents):
    // without Chat Colors its `§` codes are stripped (stripColor); with
    // them the font draws them as formatting.
displayed :: proc(self: ^Self, content: ^Text) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if self.options.colors {
    // rust: content.resolve_legacy()
    // rust: } else {
    // rust: content.strip_legacy()
}
}
    // A message's lines before wrapping: [`Chat::displayed`], with PvP & HUD's time before it
    // and count after it, in grey.
message_text :: proc(self: ^Self, message: ^Message) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let content = self.displayed(&message.content);
    // rust: if !self.qol.timestamps && message.repeats <= 1 {
    // rust: return content;
}
    // rust: let mut out = Text::empty();
    // rust: if self.qol.timestamps {
    // rust: let (h, m) = message.time;
    // rust: let time = Text::literal(format!("{h:02}:{m:02}"));
    // rust: out = out.append(
    // rust: Text::translate_with_fallback("horizon.chat.timestamp", "[%s] ", &[time])
    // rust: .with_color(text::GRAY),
    // rust: );
}
    // rust: out = out.append(content);
    // rust: if message.repeats > 1 {
    // rust: let count = Text::literal(message.repeats.to_string());
    // rust: out = out.append(
    // rust: Text::translate_with_fallback("horizon.chat.repeats", " (x%s)", &[count])
    // rust: .with_color(text::GRAY),
    // rust: );
}
    // rust: out
}
    // PvP & HUD's chat options; a change lays the lines out again.
set_qol :: proc(self: ^Self, atlas: ^HudAtlas, qol: ChatQol) {
}
    // rust: if self.qol != qol {
    // rust: self.qol = qol;
    // rust: self.rewrap(&atlas.font);
}
}
    // PvP & HUD's chat search: only the messages holding `query` (any case) show; `None` or
    // an empty query shows them all again.
set_search :: proc(self: ^Self, atlas: ^HudAtlas, query: Maybe(string)) {
}
    // rust: self.set_search_with(&atlas.font, query);
}
set_search_with :: proc(self: ^Self, font: ^crate::font::Font, query: Maybe(string)) {
}
        // Called each frame while searching: no work (nor allocation) for the same query.
    // rust: let blank = |q: &str| q.trim().is_empty();
    // rust: let same = match (&self.search, query) {
    // rust: (None, None) => true,
    // rust: (None, Some(q)) => blank(q),
    // rust: (Some(_), None) => false,
    // rust: (Some(current), Some(q)) => q.chars().flat_map(char::to_lowercase).eq(current.chars()),
}
    // rust: if same {
    // rust: return;
}
    // rust: let query = query
    // rust: .map(str::to_lowercase)
    // rust: .filter(|q| !q.trim().is_empty());
    // rust: if self.search != query {
    // rust: self.search = query;
    // rust: self.rewrap(font);
}
}
searching :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.search.is_some()
}
    // Re-wrap after a width or scale change (ChatComponent.rescaleChat),
    // keeping only the messages the Chat option shows.
rescale :: proc(self: ^Self, atlas: ^HudAtlas) {
}
    // rust: self.rewrap(&atlas.font);
}
rewrap :: proc(self: ^Self, font: ^crate::font::Font) {
}
    // rust: self.scroll = 0;
    // rust: self.new_since_scroll = false;
    // rust: self.lines.clear();
    // rust: let mut messages = std::mem::take(&mut self.messages);
    // rust: for m in messages.iter_mut().rev() {
    // rust: m.wrapped = if self.abilities.shows(m.source) {
    // rust: self.add_lines(font, m, false)
    // rust: } else {
    // rust: 0
}
}
    // rust: self.messages = messages;
}
    // `ChatComponent.setVisibleMessageFilter`: the Chat option changed;
    // the messages it now hides leave the chat, those it shows again return.
set_abilities :: proc(self: ^Self, font: ^crate::font::Font, abilities: ChatAbilities) {
}
    // rust: if self.abilities != abilities {
    // rust: self.abilities = abilities;
    // rust: self.rewrap(font);
}
}
    // Whether a message from `source` would show (`visibleMessagesFilter`).
shows :: proc(self: ^Self, source: ChatSource) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.abilities.shows(source)
}
clear :: proc(self: ^Self) {
}
    // rust: self.messages.clear();
    // rust: self.lines.clear();
    // rust: self.deletions.clear();
    // rust: self.scroll = 0;
}
    // `ChatComponent.deleteMessage`: the server deleted a message. One
    // shown for 60 ticks becomes the grey "deleted" marker now; a newer
    // one waits until then (`messageDeletionQueue`).
delete_message :: proc(self: ^Self, atlas: ^HudAtlas, signature: ^Signature, ticks: u64) {
}
    // rust: self.delete_message_with(&atlas.font, signature, ticks);
}
delete_message_with :: proc(self: ^Self, font: ^crate::font::Font, signature: ^Signature, ticks: u64) {
}
    // rust: if let Some(delayed) = self.delete_or_delay(font, signature, ticks) {
    // rust: self.deletions.push((Box::new(*signature), delayed));
}
}
    // `ChatComponent.tick` (`processMessageDeletionQueue`): the delayed
    // deletions whose message has shown long enough.
tick :: proc(self: ^Self, atlas: ^HudAtlas, ticks: u64) {
}
    // rust: self.process_deletions(&atlas.font, ticks);
}
process_deletions :: proc(self: ^Self, font: ^crate::font::Font, ticks: u64) {
}
    // rust: let mut deletions = std::mem::take(&mut self.deletions);
    // rust: deletions.retain(|(signature, after)| {
    // rust: ticks < *after || self.delete_or_delay(font, signature, ticks).is_some()
    // rust: });
    // rust: self.deletions = deletions;
}
    // `ChatComponent.deleteMessageOrDelay`: the newest message with this
    // signature, replaced by `createDeletedMarker` once 60 ticks have
    // passed since it was added; otherwise the tick to retry from.
    // rust: fn delete_or_delay(
    // rust: &mut self,
    // rust: font: &crate::font::Font,
    // rust: signature: &Signature,
    // rust: ticks: u64,
    // rust: ) -> Option<u64> {
    // rust: let message = self
    // rust: .messages
    // rust: .iter_mut()
    // rust: .find(|m| m.signature.as_deref() == Some(signature))?;
    // rust: let deletable = message.added + DELETION_DELAY;
    // rust: if ticks < deletable {
    // rust: return Some(deletable);
}
    // rust: *message = Message {
    // rust: added: message.added,
    // rust: time: message.time,
    // rust: repeats: 1,
    // rust: wrapped: 0,
    // rust: content: Self::deleted_marker(),
    // rust: tag: Some(std::sync::Arc::new(Tag::system_single_player(
    // rust: SYSTEM_INDICATOR,
    // rust: ))),
    // rust: source: ChatSource::Server,
    // rust: signature: None,
}
        // refreshTrimmedMessages.
    // rust: self.rewrap(font);
    // rust: None
}
    // `ChatComponent.DELETED_CHAT_MESSAGE`: grey, italic.
deleted_marker :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::translate("chat.deleted_marker", &[])
    // rust: .with_color(text::GRAY)
    // rust: .italic()
}
    // `new CommandHistory(gameFolder)`: the commands kept from earlier runs
    // start the chat's history (`ChatComponent`'s constructor).
load_history :: proc(self: ^Self, game_folder: ^std::path::Path) {
}
    // rust: let file = game_folder.join(COMMAND_HISTORY_FILE);
    // rust: if let Ok(text) = std::fs::read_to_string(&file) {
    // rust: self.commands = text.lines().map(str::to_owned).collect();
    // rust: self.recent.extend(self.commands.iter().cloned());
}
    // rust: self.history_file = Some(file);
}
    // `ChatComponent.addRecentChat`: a command also goes to the saved history.
add_recent :: proc(self: ^Self, message: string) {
}
    // rust: if self.recent.last().map(String::as_str) != Some(message) {
    // rust: if self.recent.len() >= 100 {
    // rust: self.recent.remove(0);
}
    // rust: self.recent.push(message.to_owned());
}
    // rust: if message.starts_with('/') && self.commands.last().map(String::as_str) != Some(message) {
    // rust: if self.commands.len() >= MAX_PERSISTED_COMMAND_HISTORY {
    // rust: self.commands.remove(0);
}
    // rust: self.commands.push(message.to_owned());
    // rust: if let Some(file) = &self.history_file {
    // rust: let mut text = self.commands.join("\n");
    // rust: text.push('\n');
    // rust: if let Err(e) = std::fs::write(file, text) {
    // rust: log::error!(
    // rust: "Failed to write {COMMAND_HISTORY_FILE}, command history will be missing: {e}"
    // rust: );
}
}
}
}
reset_scroll :: proc(self: ^Self) {
}
    // rust: self.scroll = 0;
    // rust: self.new_since_scroll = false;
}
scroll_by :: proc(self: ^Self, dir: i32, focused: bool) {
}
    // rust: let max = self
    // rust: .lines
    // rust: .len()
    // rust: .saturating_sub(self.lines_per_page(focused)) as i32;
    // rust: let pos = (self.scroll as i32 + dir).min(max);
    // rust: if pos <= 0 {
    // rust: self.scroll = 0;
    // rust: self.new_since_scroll = false;
    // rust: } else {
    // rust: self.scroll = pos as usize;
}
}
    // `ChatComponent.extractRenderState` (background mode unless `focused`)
    // on a screen `height` GUI pixels tall at `Hud.tickCount` `ticks`.
layout :: proc(self: ^Self, height: i32, ticks: f32, focused: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let total = self.lines.len();
    // rust: if total == 0 {
    // rust: return Vec::new();
}
    // rust: let o = &self.options;
    // rust: let scale = o.scale as f32;
    // rust: let max_width = hud_layout::ceil(o.width_px() as f32 / scale);
    // rust: let chat_bottom = hud_layout::floor((height - 40) as f32 / scale);
    // rust: let text_opacity = o.opacity as f32 * 0.9 + 0.1;
    // rust: let background_opacity = o.background_opacity as f32;
    // rust: let entry_height = o.line_height();
    // rust: let bottom_to_text =
    // rust: (8.0 * (o.line_spacing + 1.0) - 4.0 * o.line_spacing + 0.5).floor() as i32;
        // Vanilla's 200-tick fade reads the whole GUI ticks
        // (`Gui.getGuiTicks`); only the smooth chat extra eases it per frame.
    // rust: let fade_ticks = if self.smooth { ticks } else { ticks.floor() };
    // rust: let alpha_of = |line: &Line| {
    // rust: if focused {
    // rust: 1.0
    // rust: } else {
    // rust: time_alpha(fade_ticks, line.added)
}
}
        // The smooth chat extra: how far into its intro a line is, 0 at the
        // tick it was added and 1 once it has arrived, as (alpha, offset x).
    // rust: let intro_of = |line: &Line| {
    // rust: if focused || !self.smooth {
    // rust: return (1.0, 0.0);
}
    // rust: let t = ((ticks - line.added as f32) / INTRO_TICKS).clamp(0.0, 1.0);
    // rust: let eased = 1.0 - (1.0 - t) * (1.0 - t);
    // rust: (eased, (eased - 1.0) * INTRO_WIDTH)
}
    // rust: let visible = total
    // rust: .saturating_sub(self.scroll)
    // rust: .min(self.lines_per_page(focused));
    // rust: let lines: Vec<(usize, &Line, f32, f32)> = (0..visible)
    // rust: .rev()
    // rust: .map(|i| (i, &self.lines[i + self.scroll]))
    // rust: .map(|(i, line)| {
    // rust: let (eased, slide) = intro_of(line);
    // rust: (i, line, alpha_of(line) * eased, slide)
    // rust: })
    // rust: .filter(|(_, _, alpha, _)| *alpha > 1.0e-5)
    // rust: .collect();
    // rust: let mut out = vec![GuiDraw::Push(vec![
    // rust: PoseOp::Scale(scale, scale),
    // rust: PoseOp::Translate(4.0, 0.0),
    // rust: ])];
    // rust: for &(i, _, alpha, slide) in &lines {
    // rust: let bottom = chat_bottom - i as i32 * entry_height;
    // rust: if slide != 0.0 {
    // rust: out.push(GuiDraw::Push(vec![PoseOp::Translate(slide, 0.0)]));
}
    // rust: out.push(hud_layout::fill(
    // rust: -4,
    // rust: bottom - entry_height,
    // rust: max_width + 4 + 4,
    // rust: bottom,
    // rust: hud_layout::as8(alpha * background_opacity) << 24,
    // rust: ));
    // rust: if slide != 0.0 {
    // rust: out.push(GuiDraw::Pop);
}
}
    // rust: for &(i, line, alpha, slide) in &lines {
    // rust: let bottom = chat_bottom - i as i32 * entry_height;
    // rust: if slide != 0.0 {
    // rust: out.push(GuiDraw::Push(vec![PoseOp::Translate(slide, 0.0)]));
}
    // rust: let opacity = alpha * text_opacity;
    // rust: let color = hud_layout::white(opacity);
    // rust: if color >> 24 != 0 {
    // rust: out.push(GuiDraw::Text {
    // rust: text: line.content.clone(),
    // rust: x: 0,
    // rust: y: bottom - bottom_to_text,
    // rust: color,
    // rust: shadow: true,
    // rust: });
}
    // rust: if let Some(tag) = line.tag.as_ref().filter(|_| !self.hide_indicator) {
    // rust: let color = hud_layout::as8(opacity) << 24 | tag.color & 0xFF_FFFF;
    // rust: out.push(hud_layout::fill(
    // rust: -4,
    // rust: bottom - entry_height,
    // rust: -2,
    // rust: bottom,
    // rust: color,
    // rust: ));
}
    // rust: if slide != 0.0 {
    // rust: out.push(GuiDraw::Pop);
}
}
    // rust: if focused {
    // rust: let count = lines.len() as i32;
    // rust: let chat_height = count * entry_height;
    // rust: let virtual_height = total as i32 * entry_height;
    // rust: let y = self.scroll as i32 * chat_height / total as i32 - chat_bottom;
    // rust: let height = chat_height * chat_height / virtual_height;
    // rust: if virtual_height != chat_height {
    // rust: let alpha: u32 = if y > 0 { 170 } else { 96 };
    // rust: let color = if self.new_since_scroll {
    // rust: 0xCC3333
    // rust: } else {
    // rust: 0x3333AA
}
    // rust: let x = max_width + 4;
    // rust: out.push(hud_layout::fill(
    // rust: x,
    // rust: -y,
    // rust: x + 2,
    // rust: -y - height,
    // rust: alpha << 24 | color,
    // rust: ));
    // rust: out.push(hud_layout::fill(
    // rust: x + 2,
    // rust: -y,
    // rust: x + 1,
    // rust: -y - height,
    // rust: alpha << 24 | 0xCCCCCC,
    // rust: ));
}
}
    // rust: out.push(GuiDraw::Pop);
    // rust: out
}
    // Draws [`Chat::layout`] into the HUD batch, and with the chat screen
    // open the restricted prompt above the lines.
draw :: proc(self: ^Self, batch: ^HudBatch, atlas: ^HudAtlas, ticks: f32, focused: bool) {
}
    // rust: let draws = self.layout(batch.height as i32, ticks, focused);
    // rust: hud_layout::paint(batch, atlas, &draws);
    // rust: let restricted = focused && self.abilities.any_restriction();
    // rust: if restricted {
    // rust: let prompt = self.restricted_prompt(&atlas.font, batch.height as i32);
    // rust: hud_layout::paint(batch, atlas, &prompt);
}
    // rust: if focused && self.search_prompt {
    // rust: let row = if restricted { 2 } else { 1 };
    // rust: let prompt = self.search_prompt(&atlas.font, batch.height as i32, row);
    // rust: hud_layout::paint(batch, atlas, &prompt);
}
}
    // `ChatComponent.extractRenderState` for `FOREGROUND_RESTRICTED`: a
    // background row and the red, underlined "Chat is restricted" line in
    // the row above the messages, clipped to the chat's width.
restricted_prompt :: proc(self: ^Self, font: ^crate::font::Font, height: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let prompt = Text::translate("chat_screen.restricted", &[]).with_style(&Style {
    // rust: color: Some(text::RED),
    // rust: underlined: Some(true),
    // rust: ..Style::default()
    // rust: });
    // rust: self.prompt_above(font, height, prompt, 1)
}
    // PvP & HUD's chat search: a yellow "Search chat:" line above the lines while the box holds
    // the query.
search_prompt :: proc(self: ^Self, font: ^crate::font::Font, height: i32, row: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let label = Text::translate_with_fallback("horizon.chat.search", "Search chat:", &[]);
    // rust: self.prompt_above(font, height, label.with_color(text::YELLOW), row)
}
    // A line `row` lines above the shown ones, on the chat's background.
    // rust: fn prompt_above(
    // rust: &self,
    // rust: font: &crate::font::Font,
    // rust: height: i32,
    // rust: prompt: Text,
    // rust: row: i32,
    // rust: ) -> Vec<GuiDraw> {
    // rust: let o = &self.options;
    // rust: let scale = o.scale as f32;
    // rust: let max_width = hud_layout::ceil(o.width_px() as f32 / scale);
    // rust: let chat_bottom = hud_layout::floor((height - 40) as f32 / scale);
    // rust: let entry_height = o.line_height();
    // rust: let bottom_to_text =
    // rust: (8.0 * (o.line_spacing + 1.0) - 4.0 * o.line_spacing + 0.5).floor() as i32;
    // rust: let shown = self
    // rust: .lines
    // rust: .len()
    // rust: .saturating_sub(self.scroll)
    // rust: .min(self.lines_per_page(true));
    // rust: let top = chat_bottom - (shown as i32 + row) * entry_height;
    // rust: let mut prompt = prompt;
        // ComponentRenderUtils.clipText.
    // rust: let mut width = 0.0;
    // rust: let fits = prompt
    // rust: .chars()
    // rust: .take_while(|(c, style)| {
    // rust: width += font.advance(*c, style);
    // rust: width <= max_width as f32
    // rust: })
    // rust: .count();
    // rust: if fits < prompt.chars().count() {
    // rust: prompt = prompt.slice(0, fits);
}
    // rust: vec![
    // rust: GuiDraw::Push(vec![
    // rust: PoseOp::Scale(scale, scale),
    // rust: PoseOp::Translate(4.0, 0.0),
    // rust: ]),
    // rust: hud_layout::fill(
    // rust: -2,
    // rust: top,
    // rust: max_width + 4 + 4,
    // rust: top + entry_height,
    // rust: hud_layout::as8(o.background_opacity as f32) << 24,
    // rust: ),
    // rust: GuiDraw::Text {
    // rust: text: prompt,
    // rust: x: 0,
    // rust: y: top + entry_height - bottom_to_text - 1,
    // rust: color: hud_layout::white(o.opacity as f32 * 0.9 + 0.1),
    // rust: shadow: true,
    // rust: },
    // rust: GuiDraw::Pop,
    // rust: ]
}
    // The click action under a GUI-space cursor while chat is focused.
    // rust: pub fn click_at(
    // rust: &self,
    // rust: font: &crate::font::Font,
    // rust: height: i32,
    // rust: x: f64,
    // rust: y: f64,
    // rust: ) -> Option<ClickEvent> {
    // rust: self.style_at(font, height, x, y)?.click
}
    // The whole text of the message under a GUI-space cursor while chat is focused (PvP &
    // HUD's copy on click), without its time or count.
message_at :: proc(self: ^Self, height: i32, x: f64, y: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (line, x) = self.line_at(height, x, y)?;
    // rust: (x >= 0.0).then_some(&*line.message)
}
    // The hover text under a GUI-space cursor while chat is focused
    // (ChatScreen.render's `renderComponentHoverEffect`).
hover_at :: proc(self: ^Self, font: ^crate::font::Font, height: i32, x: f64, y: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.style_at(font, height, x, y)?.hover.map(|h| *h)
}
    // The wrapped line under a GUI-space cursor while chat is focused, and
    // the cursor's x within it (the text starts at 0).
line_at :: proc(self: ^Self, height: i32, x: f64, y: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let scale = self.options.scale as f32;
    // rust: let x = x / f64::from(scale) - 4.0;
    // rust: let bottom = hud_layout::floor((height - 40) as f32 / scale);
    // rust: let from_bottom = f64::from(bottom) - y / f64::from(scale);
    // rust: if x >= f64::from(self.max_width()) || from_bottom <= 0.0 {
    // rust: return None;
}
    // rust: let row = (from_bottom / f64::from(self.options.line_height())).ceil() as usize - 1;
    // rust: if row >= self.lines_per_page(true) {
    // rust: return None;
}
    // rust: Some((self.lines.get(self.scroll + row)?, x))
}
    // ChatComponent.getClickedComponentStyleAt.
    // rust: pub fn style_at(
    // rust: &self,
    // rust: font: &crate::font::Font,
    // rust: height: i32,
    // rust: x: f64,
    // rust: y: f64,
    // rust: ) -> Option<crate::text::Style> {
    // rust: let (line, mut x) = self.line_at(height, x, y)?;
    // rust: if x < 0.0 {
    // rust: return None;
}
    // rust: let content = line.content.resolve_legacy();
    // rust: for (c, style) in content.chars() {
    // rust: x -= f64::from(font.advance(c, style));
    // rust: if x < 0.0 {
    // rust: return Some(style.clone());
}
}
    // rust: None
}
    // `DrawingFocusedGraphicsAccess.handleTag` and `handleTagIcon` with the
    // cursor at GUI position `(x, y)` while chat is focused: the tooltip of
    // the tag under it (its bar, or its icon) and the icons to draw, those
    // under the cursor and those of the message the cursor is over.
    // rust: pub fn focused_tags(
    // rust: &self,
    // rust: font: &crate::font::Font,
    // rust: height: i32,
    // rust: x: f64,
    // rust: y: f64,
    // rust: ) -> (Option<Text>, Vec<GuiDraw>) {
    // rust: let o = &self.options;
    // rust: let scale = o.scale as f32;
    // rust: let chat_bottom = hud_layout::floor((height - 40) as f32 / scale);
    // rust: let entry_height = o.line_height();
    // rust: let bottom_to_text =
    // rust: (8.0 * (o.line_spacing + 1.0) - 4.0 * o.line_spacing + 0.5).floor() as i32;
    // rust: let (mouse_x, mouse_y) = (x / f64::from(scale) - 4.0, y / f64::from(scale));
    // rust: let inside = |left: i32, top: i32, right: i32, bottom: i32| {
    // rust: mouse_x >= f64::from(left)
    // rust: && mouse_x < f64::from(right)
    // rust: && mouse_y >= f64::from(top)
    // rust: && mouse_y < f64::from(bottom)
}
    // rust: let visible = self
    // rust: .lines
    // rust: .len()
    // rust: .saturating_sub(self.scroll)
    // rust: .min(self.lines_per_page(true));
    // rust: let mut tooltip = None;
    // rust: let mut icons = Vec::new();
    // rust: let mut hovered_message = false;
    // rust: for i in (0..visible).rev() {
    // rust: let index = i + self.scroll;
    // rust: let line = &self.lines[index];
    // rust: let bottom = chat_bottom - i as i32 * entry_height;
    // rust: let top = bottom - entry_height;
    // rust: let width = font.width_text(&line.content).ceil() as i32;
    // rust: hovered_message |= inside(0, top, width, bottom);
            // GuiMessage.Line.endOfEntry: the next newer line is another message's.
    // rust: let end_of_entry = index == 0
    // rust: || match (&line.tag, &self.lines[index - 1].tag) {
    // rust: (Some(a), Some(b)) => !std::sync::Arc::ptr_eq(a, b),
    // rust: (None, None) => false,
    // rust: _ => true,
}
    // rust: let force_icon = end_of_entry && hovered_message;
    // rust: if end_of_entry {
    // rust: hovered_message = false;
}
    // rust: let Some(tag) = &line.tag else { continue };
    // rust: if inside(-4, top, -2, bottom) {
    // rust: tooltip = Some(tag.text.clone());
}
    // rust: if tag.icon {
    // rust: let (left, text_bottom) = (width + 4, bottom - bottom_to_text + 9);
    // rust: let icon_top = text_bottom - 9 - 1;
    // rust: let over = inside(left, icon_top, left + 9, text_bottom);
    // rust: if over {
    // rust: tooltip = Some(tag.text.clone());
}
    // rust: if force_icon || over {
    // rust: icons.push(GuiDraw::Sprite {
    // rust: sprite: "icon/chat_modified".into(),
    // rust: x: left,
    // rust: y: icon_top,
    // rust: w: 9,
    // rust: h: 9,
    // rust: region: None,
    // rust: color: hud_layout::WHITE,
    // rust: blend: hud_layout::Blend::Textured,
    // rust: });
}
}
}
    // rust: if icons.is_empty() {
    // rust: return (tooltip, icons);
}
    // rust: let mut draws = vec![GuiDraw::Push(vec![
    // rust: PoseOp::Scale(scale, scale),
    // rust: PoseOp::Translate(4.0, 0.0),
    // rust: ])];
    // rust: draws.extend(icons);
    // rust: draws.push(GuiDraw::Pop);
    // rust: (tooltip, draws)
}
    // Plain text of the newest messages (for tests and the control socket).
recent_lines :: proc(self: ^Self, n: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.messages
    // rust: .iter()
    // rust: .take(n)
    // rust: .map(|m| m.content.plain())
    // rust: .collect()
}
    // The newest messages as components, styles included (control socket).
recent_components :: proc(self: ^Self, n: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.messages
    // rust: .iter()
    // rust: .take(n)
    // rust: .map(|m| m.content.component())
    // rust: .collect()
}
}

// `SuggestionsList.getNarrationMessage` for entry `index` of `count`.
suggestion_narration :: proc(index: uint, count: uint, text: string, tooltip: Maybe(string)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut args = vec![
    // rust: Text::literal((index + 1).to_string()),
    // rust: Text::literal(count.to_string()),
    // rust: Text::literal(text),
    // rust: ];
    // rust: match tooltip {
    // rust: Some(tooltip) => {
    // rust: args.push(Text::literal(tooltip));
    // rust: Text::translate("narration.suggestion.tooltip", &args)
}
    // rust: None => Text::translate("narration.suggestion", &args),
}
}

// `CommandSuggestions.SuggestionsList`.
SuggestionList :: struct {
    // `rect`: x, y, width, height.
    rect: [i32,
    original: string,
    list: [dynamic]Suggestion,
    offset: uint,
    current: uint,
    last_mouse: (i32,
    tab_cycles: bool,
    // `lastNarratedEntry`: the entry the narrator last said (-1: none yet).
    last_narrated: int,
}
    // rust: impl SuggestionList {
    // `getNarrationMessage`: "Selected suggestion 2 out of 5: …", with its
    // tooltip when it has one. It marks the entry said.
narration_message :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: self.last_narrated = self.current as isize;
    // rust: let s = &self.list[self.current];
    // rust: suggestion_narration(self.current, self.list.len(), &s.text, s.tooltip.as_deref())
}
contains :: proc(self: ^Self, x: i32, y: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let [rx, ry, w, h] = self.rect;
    // rust: x >= rx && x <= rx + w && y >= ry && y <= ry + h
}
}

// What a key did on the chat screen.
ChatAction :: enum {
    None,
    // Escape: the screen closes.
    Close,
    // Enter: the message is sent and the screen closes.
    Submit(String),
}

// The dispatcher and registries the suggestions come from.
Commands :: struct {
    dispatcher: ^'a Dispatcher,
    registries: ^'a Registries,
}

// `CommandSuggestions`' constructor arguments: how a screen's suggestions
// parse and where they are drawn.
SuggestLayout :: struct {
    // `commandsOnly`: the input is a command without a leading `/`.
    commands_only: bool,
    // `onlyShowIfCursorPastError`: completions from the command's start,
    // not only past the `/`.
    only_past_error: bool,
    // `suggestionLineLimit`.
    line_limit: uint,
    // `anchorToBottom`: the list and usage over a box at the bottom, else
    // under one at the top (y 72).
    anchor_to_bottom: bool,
    // `fillColor`: behind the list and the usage lines.
    fill: i32,
}
    // rust: impl SuggestLayout {
    // ChatScreen.init's `CommandSuggestions`.
    // rust: pub const CHAT: Self = Self {
    // rust: commands_only: false,
    // rust: only_past_error: false,
    // rust: line_limit: 10,
    // rust: anchor_to_bottom: true,
    // rust: fill: FILL,
}
    // AbstractCommandBlockEditScreen.init's `CommandSuggestions`.
    // rust: pub const COMMAND_BLOCK: Self = Self {
    // rust: commands_only: true,
    // rust: only_past_error: true,
    // rust: line_limit: 7,
    // rust: anchor_to_bottom: false,
    // rust: fill: i32::MIN,
}
}

// The open chat screen: vanilla's `ChatScreen` with its `EditBox` and
// `CommandSuggestions` (argument colouring, usage lines, parse errors,
// the suggestion list, Tab completion, history).
ChatScreen :: struct {
    input: TextField,
    width: i32,
    height: i32,
    history_buffer: string,
    history_pos: uint,
    parse: Maybe(ParseResults),
    // The completions at the cursor (`pendingSuggestions`): range start (bytes) and list.
    pending: Option<(uint,
    // Completions waiting for the server's (an `ask_server` node at the
    // cursor): `pendingSuggestions` is not done until they come.
    awaiting: Maybe(Awaiting),
    // The request to send (`ServerboundCommandSuggestionPacket`): id and
    // the command up to the cursor.
    request: Option<(i32,
    suggestions: Maybe(SuggestionList),
    usage: [dynamic]Text,
    usage_position: i32,
    usage_width: i32,
    allow_suggestions: bool,
    keep_suggestions: bool,
    auto_suggestions: bool,
    // `CommandSuggestions.setRestrictions`: what the Chat option allows.
    abilities: ChatAbilities,
    layout: SuggestLayout,
}
// Local completions waiting for the server's reply to request `id`.
Awaiting :: struct {
    id: i32,
    // The command up to the cursor, as sent.
    truncated: string,
    local: [dynamic]Suggestion,
}
// `ClientSuggestionProvider.pendingSuggestionsId`: one counter for the
// connection, so a reply to an older request never matches.
SUGGESTION_ID :: std::sync::atomic::AtomicI32::new(0)
// `CommandSuggestions`' fill colour.
FILL :: -805306368
byte_at :: proc(s: string, chars: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: s.char_indices().nth(chars).map_or(s.len(), |(i, _)| i)
}
chars_to :: proc(s: string, byte: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: s[..byte.min(s.len())].chars().count()
}
// `Mth.clamp(int)`: the minimum wins over a smaller maximum.
clamp :: proc(v: i32, lo: i32, hi: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if v < lo { lo } else { v.min(hi) }
}
// `CommandSuggestions.getLastWordIndex`: after the last whitespace run.
last_word_index :: proc(s: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = 0;
    // rust: let mut prev_space = false;
    // rust: for (i, c) in s.char_indices() {
    // rust: let space = matches!(c, ' ' | '\t' | '\n' | '\u{b}' | '\u{c}' | '\r');
    // rust: if prev_space && !space {
    // rust: out = i;
}
    // rust: prev_space = space;
}
    // rust: if prev_space { s.len() } else { out }
}
// `ChatScreen.normalizeChatMessage`: `String.trim`, then
// `StringUtils.normalizeSpace` (one space for every run of whitespace), then
// `StringUtil.trimChatMessage` (the first 256 UTF-16 code units, the length
// `ServerboundChatPacket`'s `stringUtf8(256)` decodes). The chat screen sends
// this, not what was typed: a line of spaces sends nothing, and a message the
// packet cannot hold is cut on the client, as vanilla's is, instead of by the
// server.
normalize_chat_message :: proc(message: string) -> S {
    // Ported from Horizon
    return {}
}
    // String.trim: the code points up to U+0020, which is not `str::trim`'s
    // Unicode whitespace (U+00A0 is not Java whitespace and stays).
    // rust: let trimmed = message.trim_matches(|c: char| c <= ' ');
    // rust: truncate_utf16(&normalize_space(trimmed), 256)
}
// `StringUtils.normalizeSpace`: one space for every run of
// `Character.isWhitespace`, and none at either end.
normalize_space :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(s.len());
    // rust: let mut space = false;
    // rust: for c in s.chars() {
    // rust: if crate::ui::java_whitespace(c) {
    // rust: space = !out.is_empty();
    // rust: } else {
    // rust: if space {
    // rust: out.push(' ');
    // rust: space = false;
}
    // rust: out.push(c);
}
}
    // rust: out
}
// `StringUtil.truncateStringIfNecessary(s, 256, false)`: Java counts UTF-16
// code units (`String.length`), so 129 emoji are cut to 128 of them, where
// `chars().take(256)` would keep all 129 (258 units) for the server to
// reject. A cut between the halves of a surrogate pair keeps the character
// below it: vanilla's `substring` leaves half a pair, which a Java `String`
// may hold and a Rust `String` may not.
truncate_utf16 :: proc(s: string, max_units: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut units = 0;
    // rust: for (byte, c) in s.char_indices() {
    // rust: units += c.len_utf16();
    // rust: if units > max_units {
    // rust: return s[..byte].to_owned();
}
}
    // rust: s.to_owned()
}
    // rust: impl ChatScreen {
    // `ChatScreen.init`: the input at the bottom, focused, holding `initial`.
    // rust: pub fn new(
    // rust: m: &Measure,
    // rust: c: &Commands,
    // rust: initial: &str,
    // rust: history_len: usize,
    // rust: width: i32,
    // rust: height: i32,
    // rust: abilities: ChatAbilities,
    // rust: ) -> Self {
    // rust: let mut input = TextField::new(4, height - 12, width - 4, 12);
    // rust: input.max_length = 256;
    // rust: input.bordered = false;
    // rust: input.focused = true;
    // rust: input.set_value(m, initial);
    // rust: let mut s = Self {
    // rust: input,
    // rust: width,
    // rust: height,
    // rust: history_buffer: String::new(),
    // rust: history_pos: history_len,
    // rust: parse: None,
    // rust: pending: None,
    // rust: awaiting: None,
    // rust: request: None,
    // rust: suggestions: None,
    // rust: usage: Vec::new(),
    // rust: usage_position: 0,
    // rust: usage_width: 0,
    // rust: allow_suggestions: false,
    // rust: keep_suggestions: false,
    // rust: auto_suggestions: true,
    // rust: abilities,
    // rust: layout: SuggestLayout::CHAT,
}
    // rust: s.update_command_info(m, c);
    // rust: s
}
    // `AbstractCommandBlockEditScreen.init`: the command box at the top,
    // focused, holding `command`, with suggestions from the start.
    // rust: pub fn command_block(
    // rust: m: &Measure,
    // rust: c: &Commands,
    // rust: command: &str,
    // rust: width: i32,
    // rust: height: i32,
    // rust: ) -> Self {
    // rust: let mut input = TextField::new(width / 2 - 150, 50, 300, 20);
    // rust: input.max_length = 32500;
    // rust: input.focused = true;
    // rust: input.set_value(m, command);
    // rust: let mut s = Self {
    // rust: input,
    // rust: width,
    // rust: height,
    // rust: history_buffer: String::new(),
    // rust: history_pos: 0,
    // rust: parse: None,
    // rust: pending: None,
    // rust: awaiting: None,
    // rust: request: None,
    // rust: suggestions: None,
    // rust: usage: Vec::new(),
    // rust: usage_position: 0,
    // rust: usage_width: 0,
    // rust: allow_suggestions: true,
    // rust: keep_suggestions: false,
    // rust: auto_suggestions: true,
    // rust: abilities: ChatAbilities::new(ChatVisibility::Full),
    // rust: layout: SuggestLayout::COMMAND_BLOCK,
}
    // rust: s.update_command_info(m, c);
    // rust: s
}
value :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.input.value
}
    // Replace the input for a suggest-command link and refresh completions.
suggest_command :: proc(self: ^Self, m: ^Measure, c: ^Commands, command: string) {
}
    // rust: self.input.set_value(m, command);
    // rust: self.edited(m, c);
}
    // `ChatScreen.resize`: a new screen with the current text.
resize :: proc(self: ^Self, m: ^Measure, c: ^Commands, width: i32, height: i32) {
}
    // rust: if (width, height) != (self.width, self.height) {
    // rust: let value = self.input.value.clone();
    // rust: let auto = self.auto_suggestions;
    // rust: let abilities = self.abilities;
    // rust: let message = std::mem::take(&mut self.input.message);
    // rust: *self = if self.layout == SuggestLayout::CHAT {
    // rust: Self::new(m, c, &value, self.history_pos, width, height, abilities)
    // rust: } else {
    // rust: Self::command_block(m, c, &value, width, height)
}
    // rust: self.auto_suggestions = auto;
    // rust: self.input.message = message;
}
}
    // `ChatScreen.onEdited`.
edited :: proc(self: ^Self, m: ^Measure, c: ^Commands) {
}
    // rust: self.allow_suggestions = true;
    // rust: self.update_command_info(m, c);
}
    // Ctrl+A/C/V/X in the input box.
    // rust: pub fn shortcut(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: c: &Commands,
    // rust: shortcut: crate::clipboard::EditShortcut,
    // rust: clipboard: &mut dyn crate::clipboard::Clipboard,
    // rust: ) {
    // rust: if self.input.shortcut(m, shortcut, clipboard) {
    // rust: self.edited(m, c);
}
}
    // Typed text (`charTyped` per character).
type_text :: proc(self: ^Self, m: ^Measure, c: ^Commands, text: string) {
}
    // rust: for ch in text.chars() {
    // rust: if ch >= ' '
    // rust: && ch != '\u{7f}'
    // rust: && ch != '§'
    // rust: && self.input.insert_text(m, &ch.to_string())
    // rust: {
    // rust: self.edited(m, c);
}
}
}
    // `CommandSuggestions.updateCommandInfo`.
update_command_info :: proc(self: ^Self, m: ^Measure, c: ^Commands) {
}
    // rust: let command = self.input.value.clone();
    // rust: if self.parse.as_ref().is_some_and(|p| p.input != command) {
    // rust: self.parse = None;
}
    // rust: if !self.keep_suggestions {
    // rust: self.input.suggestion = None;
    // rust: self.suggestions = None;
}
    // rust: self.usage.clear();
    // rust: let cursor = self.input.cursor;
    // rust: let cursor_b = byte_at(&command, cursor);
    // rust: let slash = command.starts_with('/');
    // rust: if self.layout.commands_only || slash {
    // rust: let start = usize::from(slash);
    // rust: if self.parse.is_none() {
    // rust: self.parse = Some(c.dispatcher.parse_at(&command, start, c.registries));
}
    // rust: let from = if self.layout.only_past_error {
    // rust: start
    // rust: } else {
    // rust: 1
}
    // rust: if cursor >= from && (self.suggestions.is_none() || !self.keep_suggestions) {
    // rust: let parse = self.parse.as_ref().expect("parsed above");
    // rust: let (range, list, ask) =
    // rust: c.dispatcher
    // rust: .client_suggestions_asking(parse, cursor_b, c.registries);
    // rust: if ask {
                    // ClientSuggestionProvider.customSuggestion: the
                    // suggestions are done when the server answers.
    // rust: let id = SUGGESTION_ID.fetch_add(1, std::sync::atomic::Ordering::Relaxed) + 1;
    // rust: let truncated = command[..cursor_b].to_owned();
    // rust: self.request = Some((id, truncated.clone()));
    // rust: self.awaiting = Some(Awaiting {
    // rust: id,
    // rust: truncated,
    // rust: local: list,
    // rust: });
    // rust: self.pending = None;
    // rust: } else {
    // rust: self.awaiting = None;
    // rust: self.pending = Some((range.0, list));
    // rust: self.update_usage_info(m, c);
}
}
    // rust: } else if !command.chars().all(char::is_whitespace) {
    // rust: let partial = &command[..cursor_b];
    // rust: let mut builder = SuggestionsBuilder::new(partial, last_word_index(partial));
            // ClientSuggestionProvider.getCustomTabSuggestions: the players
            // and the server's custom chat completions.
    // rust: builder.suggest_matching(c.registries.custom_tab_suggestions());
    // rust: let (range, list) = merge_suggestions(partial, builder.out);
    // rust: self.awaiting = None;
    // rust: self.pending = Some((range.0, list));
    // rust: self.usage_width = 0;
    // rust: self.usage_position = 0;
            // CommandSuggestions.updateCommandInfo: the Chat option may take
            // the messages.
    // rust: if !self.abilities.send_messages {
    // rust: let line =
    // rust: Text::translate("chat_screen.messages_not_allowed", &[]).with_color(text::RED);
    // rust: self.usage_width = m.width(&line);
    // rust: self.usage.push(line);
}
    // rust: } else {
    // rust: self.awaiting = None;
    // rust: self.pending = None;
}
}
    // The completion request to send to the server, if one is waiting.
take_request :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.request.take()
}
    // `ClientSuggestionProvider.completeCustomSuggestions`: the server's
    // completions for request `id`, with `range` in UTF-16 units of the
    // command sent. They join the local ones (`Suggestions.merge`) and the
    // pending suggestions are done.
    // rust: pub fn server_suggestions(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: c: &Commands,
    // rust: id: i32,
    // rust: range: (usize, usize),
    // rust: list: Vec<(String, Option<String>)>,
    // rust: ) {
    // rust: let Some(awaiting) = self.awaiting.take_if(|a| a.id == id) else {
    // rust: return;
}
    // rust: let input = &awaiting.truncated;
    // rust: let byte = |units: usize| {
    // rust: let mut n = 0;
    // rust: input
    // rust: .char_indices()
    // rust: .find(|(_, ch)| {
    // rust: let past = n >= units;
    // rust: n += ch.len_utf16();
    // rust: past
    // rust: })
    // rust: .map_or(input.len(), |(i, _)| i)
}
    // rust: let range = (byte(range.0), byte(range.0 + range.1));
    // rust: let mut all = awaiting.local;
    // rust: all.extend(list.into_iter().map(|(text, tooltip)| Suggestion {
    // rust: range,
    // rust: text,
    // rust: tooltip,
    // rust: int_value: None,
    // rust: }));
    // rust: let (range, list) = merge_suggestions(input, all);
    // rust: self.pending = Some((range.0, list));
    // rust: self.update_usage_info(m, c);
}
    // `CommandSuggestions.updateUsageInfo`.
update_usage_info :: proc(self: ^Self, m: ^Measure, c: ^Commands) {
}
    // rust: let Some(parse) = &self.parse else { return };
    // rust: let empty = self.pending.as_ref().is_none_or(|p| p.1.is_empty());
    // rust: let mut trailing = false;
    // rust: if self.input.cursor == self.input.value.chars().count() {
    // rust: if empty && !parse.errors.is_empty() {
    // rust: let mut literals = 0;
    // rust: for (_, e) in &parse.errors {
    // rust: if e.literal_incorrect {
    // rust: literals += 1;
    // rust: } else {
    // rust: self.usage.push(e.with_context());
}
}
    // rust: if literals > 0 {
    // rust: let reader = crate::command::Reader {
    // rust: string: &parse.input,
    // rust: cursor: parse.cursor,
}
    // rust: self.usage.push(
    // rust: crate::command::CommandError::tr_at(
    // rust: "command.unknown.argument",
    // rust: &[],
    // rust: &reader,
    // rust: )
    // rust: .with_context(),
    // rust: );
}
    // rust: } else if parse.can_read() {
    // rust: trailing = true;
}
}
    // rust: let cursor_b = byte_at(&self.input.value, self.input.cursor);
    // rust: let (node, start, _) = parse.context.suggestion_context(cursor_b);
    // rust: if self.usage.is_empty() {
    // rust: let entries: Vec<Text> = c
    // rust: .dispatcher
    // rust: .smart_usage(node, c.registries.permission)
    // rust: .into_iter()
    // rust: .filter(|(n, _)| {
    // rust: !matches!(
    // rust: c.dispatcher.nodes[*n].kind,
    // rust: crate::command::NodeKind::Literal(_)
    // rust: )
    // rust: })
    // rust: .map(|(_, u)| Text::colored(u, text::GRAY))
    // rust: .collect();
    // rust: if entries.is_empty()
    // rust: && trailing
    // rust: && let Some(e) = parse.error()
    // rust: {
    // rust: self.usage.push(e.with_context());
}
    // rust: self.usage.extend(entries);
}
        // CommandSuggestions.updateUsageInfo: the Chat option may take the
        // commands, under the usage. (Vanilla also counts a command with a
        // message argument, `/say hi`, as a message; Horizon's parse keeps no
        // argument kinds, so only a bare message does.)
    // rust: if !self.abilities.send_commands {
    // rust: self.usage.push(
    // rust: Text::translate("chat_screen.commands_not_allowed", &[]).with_color(text::RED),
    // rust: );
}
    // rust: self.usage_width = self.usage.iter().map(|u| m.width(u)).max().unwrap_or(0);
    // rust: self.usage_position = if self.usage.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: let start = chars_to(&self.input.value, start);
    // rust: clamp(
    // rust: self.input.screen_x(m, start),
    // rust: 0,
    // rust: self.input.screen_x(m, 0) + self.input.inner_width() - self.usage_width,
    // rust: )
}
    // rust: self.suggestions = None;
    // rust: if self.allow_suggestions && self.auto_suggestions {
    // rust: self.show_suggestions(m, false);
}
}
    // `CommandSuggestions.showSuggestions`: `immediate` (Tab asked for
    // them) has the narrator say the first one at once.
show_suggestions :: proc(self: ^Self, m: ^Measure, immediate: bool) {
}
    // rust: let Some((start, list)) = self.pending.clone() else {
    // rust: return;
}
    // rust: if list.is_empty() {
    // rust: return;
}
    // rust: let width = list.iter().map(|s| m.width_str(&s.text)).max().unwrap_or(0);
    // rust: let value = self.input.value.clone();
    // rust: let x = clamp(
    // rust: self.input.screen_x(m, chars_to(&value, start)),
    // rust: 0,
    // rust: self.input.screen_x(m, 0) + self.input.inner_width() - width,
    // rust: );
    // rust: let y = if self.layout.anchor_to_bottom {
    // rust: self.height - 12
    // rust: } else {
    // rust: 72
}
        // sortSuggestions: those starting with the word at the cursor first.
    // rust: let partial = &value[..byte_at(&value, self.input.cursor)];
    // rust: let word = partial[last_word_index(partial)..].to_lowercase();
    // rust: let (mut first, rest): (Vec<Suggestion>, Vec<Suggestion>) =
    // rust: list.into_iter().partition(|s| {
    // rust: s.text.starts_with(&word) || s.text.starts_with(&format!("minecraft:{word}"))
    // rust: });
    // rust: first.extend(rest);
        // SuggestionsList: beside a bordered box, or over an unbordered one.
    // rust: let n = first.len().min(self.layout.line_limit) as i32;
    // rust: let bordered = i32::from(self.input.bordered);
    // rust: let top = if self.layout.anchor_to_bottom {
    // rust: y - 3 - n * 12
    // rust: } else {
    // rust: y - bordered
}
    // rust: let mut l = SuggestionList {
    // rust: rect: [x - (1 - bordered), top, width + 1, n * 12],
    // rust: original: value,
    // rust: list: first,
    // rust: offset: 0,
    // rust: current: 0,
    // rust: last_mouse: (0, 0),
    // rust: tab_cycles: false,
    // rust: last_narrated: if immediate { -1 } else { 0 },
}
    // rust: self.select(&mut l, 0);
    // rust: self.suggestions = Some(l);
}
    // `SuggestionsList.select`: the grey completion after the text.
select :: proc(self: ^Self, l: ^SuggestionList, index: int) {
}
    // rust: let n = l.list.len() as isize;
    // rust: let mut i = index;
    // rust: if i < 0 {
    // rust: i += n;
}
    // rust: if i >= n {
    // rust: i -= n;
}
    // rust: l.current = i as usize;
    // rust: let applied = l.list[l.current].apply(&l.original);
    // rust: self.input.suggestion = applied
    // rust: .strip_prefix(self.input.value.as_str())
    // rust: .map(str::to_owned);
    // rust: if l.last_narrated != l.current as isize {
    // rust: horizon_narrator::say_system_now(&l.narration_message().plain());
}
}
cycle :: proc(self: ^Self, l: ^SuggestionList, dir: int) {
}
    // rust: self.select(l, l.current as isize + dir);
    // rust: let limit = self.layout.line_limit;
    // rust: let max = l.list.len().saturating_sub(limit);
    // rust: if l.current < l.offset {
    // rust: l.offset = l.current.min(max);
    // rust: } else if l.current >= l.offset + limit {
    // rust: l.offset = (l.current as isize + 1 - limit as isize).clamp(0, max as isize) as usize;
}
}
    // `SuggestionsList.useSuggestion`.
use_suggestion :: proc(self: ^Self, m: ^Measure, c: ^Commands, l: ^SuggestionList) {
}
    // rust: let s = l.list[l.current].clone();
    // rust: self.keep_suggestions = true;
    // rust: let value = s.apply(&l.original);
    // rust: self.suggestions = Some(l.clone());
    // rust: self.input.set_value(m, &value);
    // rust: self.edited(m, c);
    // rust: let end = chars_to(&l.original, s.range.0) + s.text.chars().count();
    // rust: self.input.set_cursor_and_highlight(m, end);
    // rust: self.select(l, l.current as isize);
    // rust: self.keep_suggestions = false;
    // rust: l.tab_cycles = true;
}
    // `ChatScreen.keyPressed`.
    // rust: pub fn key(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: c: &Commands,
    // rust: history: &[String],
    // rust: key: winit::keyboard::KeyCode,
    // rust: shift: bool,
    // rust: ctrl: bool,
    // rust: ) -> ChatAction {
//         use winit::keyboard::KeyCode as K;
    // rust: if self.suggestions_key(m, c, key, shift) {
    // rust: return ChatAction::None;
}
    // rust: match key {
    // rust: K::Escape => return ChatAction::Close,
    // rust: K::Enter | K::NumpadEnter => {
                // ChatScreen.keyPressed: without `hasAllowedInput` the input
                // stays, unsent, and the screen stays open.
    // rust: if !self.abilities.allows(&self.input.value) {
    // rust: return ChatAction::None;
}
    // rust: return ChatAction::Submit(self.normalized());
}
    // rust: K::ArrowUp => self.move_in_history(m, c, history, -1),
    // rust: K::ArrowDown => self.move_in_history(m, c, history, 1),
    // rust: _ => {
    // rust: self.field_key(m, c, key, shift, ctrl);
}
}
    // rust: ChatAction::None
}
    // The input box's own keys (`EditBox.keyPressed`), the suggestions
    // following an edit: whether the box took the key.
    // rust: pub fn field_key(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: c: &Commands,
    // rust: key: winit::keyboard::KeyCode,
    // rust: shift: bool,
    // rust: ctrl: bool,
    // rust: ) -> bool {
    // rust: match self.input.key(m, key, shift, ctrl) {
    // rust: Some(changed) => {
    // rust: if changed {
    // rust: self.edited(m, c);
}
    // rust: true
}
    // rust: None => false,
}
}
    // `CommandSuggestions.keyPressed`: the list's arrows, Tab and Escape,
    // and Tab to show it. True when the suggestions took the key.
    // rust: pub fn suggestions_key(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: c: &Commands,
    // rust: key: winit::keyboard::KeyCode,
    // rust: shift: bool,
    // rust: ) -> bool {
//         use winit::keyboard::KeyCode as K;
    // rust: if let Some(mut l) = self.suggestions.take() {
    // rust: let handled = match key {
    // rust: K::ArrowUp | K::ArrowDown => {
    // rust: self.cycle(&mut l, if key == K::ArrowUp { -1 } else { 1 });
    // rust: l.tab_cycles = false;
    // rust: true
}
    // rust: K::Tab => {
    // rust: if l.tab_cycles {
    // rust: self.cycle(&mut l, if shift { -1 } else { 1 });
}
    // rust: self.use_suggestion(m, c, &mut l);
    // rust: true
}
    // rust: K::Escape => {
    // rust: self.input.suggestion = None;
    // rust: return true;
}
    // rust: _ => false,
}
    // rust: self.suggestions = Some(l);
    // rust: handled
    // rust: } else if key == K::Tab {
    // rust: self.show_suggestions(m, true);
    // rust: true
    // rust: } else {
    // rust: false
}
}
    // `ChatScreen.moveInHistory`.
move_in_history :: proc(self: ^Self, m: ^Measure, c: ^Commands, history: ^[string], dir: int) {
}
    // rust: let max = history.len();
    // rust: let new = (self.history_pos as isize + dir).clamp(0, max as isize) as usize;
    // rust: if new == self.history_pos {
    // rust: return;
}
    // rust: if new == max {
    // rust: self.history_pos = max;
    // rust: let b = self.history_buffer.clone();
    // rust: self.input.set_value(m, &b);
    // rust: self.edited(m, c);
    // rust: } else {
    // rust: if self.history_pos == max {
    // rust: self.history_buffer = self.input.value.clone();
}
    // rust: self.input.set_value(m, &history[new]);
    // rust: self.edited(m, c);
    // rust: self.allow_suggestions = false;
    // rust: self.suggestions = None;
    // rust: self.history_pos = new;
}
}
    // A left click (`ChatScreen.mouseClicked`): a suggestion, else the input.
click :: proc(self: ^Self, m: ^Measure, c: ^Commands, x: f64, y: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(mut l) = self.suggestions.take() {
    // rust: let (xi, yi) = (x as i32, y as i32);
    // rust: if l.contains(xi, yi) {
    // rust: let line = (yi - l.rect[1]) / 12 + l.offset as i32;
    // rust: if line >= 0 && (line as usize) < l.list.len() {
    // rust: self.select(&mut l, line as isize);
    // rust: self.use_suggestion(m, c, &mut l);
}
    // rust: self.suggestions = Some(l);
    // rust: return true;
}
    // rust: self.suggestions = Some(l);
}
    // rust: if self.input.contains(x, y) {
    // rust: self.input.click(m, x, false);
    // rust: return true;
}
    // rust: false
}
    // The mouse wheel over the suggestion list (`SuggestionsList.mouseScrolled`).
scroll :: proc(self: ^Self, mouse: (i32) {
}
    // rust: let Some(l) = &mut self.suggestions else {
    // rust: return false;
}
    // rust: if !l.contains(mouse.0, mouse.1) {
    // rust: return false;
}
    // rust: let max = l.list.len().saturating_sub(self.layout.line_limit) as i32;
    // rust: l.offset = ((l.offset as f64 - amount.clamp(-1.0, 1.0)) as i32).clamp(0, max) as usize;
    // rust: true
}
    // `CommandSuggestions.formatText`: argument colours over the input.
format :: proc(self: ^Self, value: string, offset: uint) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let gray = Style::color(text::GRAY);
    // rust: let Some(parse) = &self.parse else {
    // rust: return Text::literal(value);
}
    // rust: let full = &self.input.value;
    // rust: let chars = |b: usize| chars_to(full, b) as isize;
    // rust: let len = value.chars().count() as isize;
    // rust: let piece = |from: isize, to: isize| -> String {
    // rust: value
    // rust: .chars()
    // rust: .skip(from as usize)
    // rust: .take((to - from).max(0) as usize)
    // rust: .collect()
}
    // rust: let mut out = Text::empty();
    // rust: let mut unformatted = 0isize;
    // rust: let styles = [
    // rust: text::AQUA,
    // rust: text::YELLOW,
    // rust: text::GREEN,
    // rust: text::LIGHT_PURPLE,
    // rust: text::GOLD,
    // rust: ];
    // rust: for (i, arg) in parse.context.last_child().args.iter().enumerate() {
    // rust: let start = (chars(arg.range.0) - offset as isize).max(0);
    // rust: if start >= len {
    // rust: break;
}
    // rust: let end = (chars(arg.range.1) - offset as isize).min(len);
    // rust: if end > 0 {
    // rust: out.push(Text::styled(piece(unformatted, start), gray.clone()));
    // rust: out.push(Text::styled(
    // rust: piece(start, end),
    // rust: Style::color(styles[i % styles.len()]),
    // rust: ));
    // rust: unformatted = end;
}
}
    // rust: if parse.can_read() {
    // rust: let start = (chars(parse.cursor) - offset as isize).max(0);
    // rust: if start < len {
    // rust: let remaining = (full.len() - parse.cursor.min(full.len())) as isize;
    // rust: let end = (start + full[parse.cursor.min(full.len())..].chars().count() as isize)
    // rust: .min(len);
    // rust: let _ = remaining;
    // rust: out.push(Text::styled(piece(unformatted, start), gray.clone()));
    // rust: out.push(Text::styled(piece(start, end), Style::color(text::RED)));
    // rust: unformatted = end;
}
}
    // rust: out.push(Text::styled(piece(unformatted, len), gray));
    // rust: out
}
    // `ChatScreen.extractRenderState` without the chat lines: the input's
    // background (`background`, `Options.getBackgroundColor`), the input,
    // then the suggestion list or the usage lines.
    // rust: pub fn draw(
    // rust: &mut self,
    // rust: m: &Measure,
    // rust: mouse: (i32, i32),
    // rust: blink_ms: u64,
    // rust: background: i32,
    // rust: ) -> Vec<Draw> {
    // rust: let (w, h) = (self.width, self.height);
    // rust: let mut out = Vec::new();
    // rust: if self.layout.anchor_to_bottom {
    // rust: d::fill(&mut out, 2, h - 14, w - 2, h - 2, background);
}
    // rust: let format = |s: &str, o: usize| self.format(s, o);
    // rust: self.input.draw(&mut out, m, blink_ms, Some(&format));
    // rust: if let Some(mut l) = self.suggestions.take() {
    // rust: self.draw_list(&mut out, m, &mut l, mouse);
    // rust: self.suggestions = Some(l);
    // rust: } else {
    // rust: for (i, line) in self.usage.iter().enumerate() {
    // rust: let y = if self.layout.anchor_to_bottom {
    // rust: h - 27 - 12 * i as i32
    // rust: } else {
    // rust: 72 + 12 * i as i32
}
    // rust: d::fill(
    // rust: &mut out,
    // rust: self.usage_position - 1,
    // rust: y,
    // rust: self.usage_position + self.usage_width + 1,
    // rust: y + 12,
    // rust: self.layout.fill,
    // rust: );
    // rust: d::text(&mut out, line.clone(), self.usage_position, y + 2, -1, true);
}
}
    // rust: out
}
    // rust: fn draw_list(
    // rust: &mut self,
    // rust: out: &mut Vec<Draw>,
    // rust: m: &Measure,
    // rust: l: &mut SuggestionList,
    // rust: mouse: (i32, i32),
    // rust: ) {
    // rust: let limit = l.list.len().min(self.layout.line_limit);
    // rust: let [rx, ry, rw, rh] = l.rect;
    // rust: let has_prev = l.offset > 0;
    // rust: let has_next = l.list.len() > l.offset + limit;
    // rust: let moved = l.last_mouse != mouse;
    // rust: if moved {
    // rust: l.last_mouse = mouse;
}
    // rust: if has_prev || has_next {
    // rust: d::fill(out, rx, ry - 1, rx + rw, ry, self.layout.fill);
    // rust: d::fill(out, rx, ry + rh, rx + rw, ry + rh + 1, self.layout.fill);
    // rust: if has_prev {
    // rust: for x in (0..rw).step_by(2) {
    // rust: d::fill(out, rx + x, ry - 1, rx + x + 1, ry, -1);
}
}
    // rust: if has_next {
    // rust: for x in (0..rw).step_by(2) {
    // rust: d::fill(out, rx + x, ry + rh, rx + x + 1, ry + rh + 1, -1);
}
}
}
    // rust: let mut hovered = false;
    // rust: for i in 0..limit {
    // rust: let y = ry + 12 * i as i32;
    // rust: d::fill(out, rx, y, rx + rw, y + 12, self.layout.fill);
    // rust: if mouse.0 > rx && mouse.0 < rx + rw && mouse.1 > y && mouse.1 < y + 12 {
    // rust: if moved {
    // rust: self.select(l, (i + l.offset) as isize);
}
    // rust: hovered = true;
}
    // rust: let s = &l.list[i + l.offset];
    // rust: let color = if i + l.offset == l.current {
    // rust: -256
    // rust: } else {
    // rust: -5592406
}
    // rust: d::text(
    // rust: out,
    // rust: Text::literal(s.text.clone()),
    // rust: rx + 1,
    // rust: ry + 2 + 12 * i as i32,
    // rust: color,
    // rust: true,
    // rust: );
}
    // rust: if hovered && let Some(tip) = &l.list[l.current].tooltip {
    // rust: out.push(Draw::Tooltip {
    // rust: lines: vec![Text::literal(tip.clone())],
    // rust: x: mouse.0,
    // rust: y: mouse.1,
    // rust: });
}
    // rust: let _ = m;
}
    // `ChatScreen.normalizeChatMessage`.
normalized :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let collapsed = self
    // rust: .input
    // rust: .value
    // rust: .split_whitespace()
    // rust: .collect::<Vec<_>>()
    // rust: .join(" ");
    // rust: collapsed.chars().take(256).collect()
}
suggestions_visible :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.suggestions.is_some()
}
    // `CommandSuggestions.getUsageNarration` while the list shows
    // (`isVisible`): whether Tab cycles it or fills the input in, and
    // whether Escape hides it (`allowHiding`, which only the chat's turns
    // off).
suggestions_usage :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let list = self.suggestions.as_ref()?;
    // rust: let hidable = self.layout != SuggestLayout::CHAT;
    // rust: Some(match (list.tab_cycles, hidable) {
    // rust: (true, true) => "narration.suggestion.usage.cycle.hidable",
    // rust: (true, false) => "narration.suggestion.usage.cycle.fixed",
    // rust: (false, true) => "narration.suggestion.usage.fill.hidable",
    // rust: (false, false) => "narration.suggestion.usage.fill.fixed",
    // rust: })
}
}
