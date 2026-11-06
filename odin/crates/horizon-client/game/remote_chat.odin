//! Transpiled from Horizon Rust crate
package horizon_client_remote_chat

import "core:fmt"
import "core:mem"
import "core:math"

// Secure chat on a server's client (ClientPacketListener): the chat
// session made from the account's chat key pair (setKeyPair), signed chat
// and signed command arguments (sendChat, sendCommand), and the messages
// the client acknowledges as seen (LastSeenMessagesTracker,
// markMessageAsProcessed). Without a signed-in
// account, or on a server that plays the account under another profile
// (offline mode), there is no session and everything goes unsigned.
// use super::{Game, Screen, books::BookScreen, dialogs::ClosedDialog};
// use horizon_client::{
    // rust: auth::{self, ChatKeyPair},
    // rust: command::{Dispatcher, Registries},
    // rust: confirm_screen::Choice,
    // rust: hud::HudBatch,
    // rust: text::Text,
}
// use horizon_protocol::{
    // rust: packets::play::{self, Serverbound as S},
    // rust: secure_chat::{Body, Encoder, LastSeenTracker, Signature},
}
// use std::sync::Arc;
// use winit::keyboard::KeyCode;

// ClientPacketListener.sendChatAcknowledgement's threshold.
ACK_AFTER :: 64

// ClientPacketListener.CommandCheckResult.
CommandCheck :: enum {
    NoIssues,
    ParseErrors,
    SignatureRequired,
    PermissionsRequired,
}

// ClientPacketListener.verifyCommand over the tree the server sent.
verify_command :: proc(tree: ^Dispatcher, registries: ^Registries, command: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let parse = tree.parse(command, registries);
    // rust: if !parse.is_valid() {
    // rust: return CommandCheck::ParseErrors;
}
    // rust: if !parse.signable_arguments(tree).is_empty() {
    // rust: return CommandCheck::SignatureRequired;
}
    // rust: if !tree
    // rust: .without_restricted()
    // rust: .parse(command, registries)
    // rust: .is_valid()
    // rust: {
    // rust: return CommandCheck::PermissionsRequired;
}
    // rust: CommandCheck::NoIssues
}

// What the confirmation's first button does.
CommandAccept :: enum {
    // openCommandSendConfirmationWindow: the command goes as it is.
    Run,
    // openSignedCommandSendConfirmationWindow: into the chat box, for the
    // player to read and send.
    Suggest,
    // The same with a screen to come back to: on the clipboard.
    Copy,
}

// The screen a clicked command left, which answering no returns to
// (openSendConfirmationWindow's `currentScreen`).
    // rust: pub(super) enum Behind {
    // rust: Book(Box<BookScreen>),
    // rust: Dialog(ClosedDialog),
}

// The `ConfirmScreen` of ClientPacketListener.openSendConfirmationWindow.
    // rust: pub(super) struct CommandPrompt {
    // rust: command: String,
    // rust: message: &'static str,
    // rust: accept: CommandAccept,
    // A screen is open behind it: the second button says Back, not Cancel.
    // rust: over_screen: bool,
    // rust: behind: Option<Behind>,
    // The button Tab or an arrow key moved to.
    // rust: focus: Option<usize>,
}

// `FriendlyByteBuf.readUtf(256)` counts UTF-16 code units, not Unicode scalar
// values. Keep a whole scalar at the boundary so the wire string is valid.
truncate_utf16 :: proc(content: string, max_units: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut units = 0;
    // rust: content
    // rust: .chars()
    // rust: .take_while(|ch| {
    // rust: let next = units + ch.len_utf16();
    // rust: (next <= max_units).then(|| units = next).is_some()
    // rust: })
    // rust: .collect()
}

// A connection's secure chat state, new with every login packet.
    // rust: pub(super) struct SecureChat {
    // LocalChatSession: the key pair it signs with, and its chain.
    // rust: session: Option<(Arc<ChatKeyPair>, Encoder)>,
    // rust: tracker: LastSeenTracker,
}

    // rust: impl SecureChat {
    // rust: pub(super) fn signed(&self) -> bool {
    // rust: self.session.is_some()
}
    // handleDeleteChat: a deleted message that is still pending is not
    // acknowledged.
    // rust: pub(super) fn ignore_pending(&mut self, signature: &Signature) {
    // rust: self.tracker.ignore_pending(signature);
}
}

// Crypt.SaltSupplier.getLong: a SecureRandom long.
salt :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: i64::from_be_bytes(random())
}

// Bytes from the OS. A failure is logged, not hidden: what it leaves is not random.
    // rust: fn random<const N: usize>() -> [u8; N] {
    // rust: let mut bytes = [0u8; N];
    // rust: if let Err(e) = horizon_protocol::crypto::random_bytes(&mut bytes) {
    // rust: log::error!("Secure chat has no randomness: {e}");
}
    // rust: bytes
}

// Encoder.pack; a message that can't be signed goes without, and says so.
sign :: proc(keys: ^ChatKeyPair, encoder: ^Encoder, body: ^Body) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let signature = encoder.sign(&keys.private, body);
    // rust: if signature.is_none() {
    // rust: log::error!("Failed to sign a chat message");
}
    // rust: signature
}

// UUID.randomUUID: version 4, IETF variant.
random_uuid :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut bytes: [u8; 16] = random();
    // rust: bytes[6] = bytes[6] & 0x0f | 0x40;
    // rust: bytes[8] = bytes[8] & 0x3f | 0x80;
    // rust: u128::from_be_bytes(bytes)
}

    // rust: impl Game<'_> {
    // handleLogin: a new session state and signature cache, and prepareKeyPair.
    // rust: pub(super) fn remote_chat_login(&mut self) {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.secure_chat = SecureChat::default();
    // rust: r.signatures = Default::default();
}
        // Only when the server says it is in online mode (handleLogin).
    // rust: if self.remote.as_ref().is_some_and(|r| r.online_mode) {
    // rust: if let Some(account) = self.auth() {
    // rust: auth::prepare_chat_keys_for(account, true);
}
    // rust: self.update_chat_session();
}
}

    // ClientPacketListener.tick's key refresh (shouldRefreshKeyPair), then
    // setKeyPair with whatever key pair is ready.
    // rust: pub(super) fn tick_chat_session(&mut self) {
        // shouldRefreshKeyPair is asked only once there is a chat session; a
        // first key pair arrives through the join's prepareKeyPair.
    // rust: if self
    // rust: .remote
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.logged_in && r.online_mode)
    // rust: {
    // rust: if self.remote.as_ref().is_some_and(|r| r.secure_chat.signed())
    // rust: && let Some(account) = self.auth()
    // rust: {
    // rust: auth::prepare_chat_keys_for(account, false);
}
    // rust: self.update_chat_session();
}
}

    // setKeyPair: only for the signed-in account's own profile
    // (isLocalPlayer), and only when the key pair changed: a new session
    // (random id, chain from link 0) the server hears of at once.
update_chat_session :: proc(self: ^Self) {
}
    // rust: let Some(account) = self.auth() else {
    // rust: return;
}
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: if !r.logged_in || r.profile() != account.uuid {
    // rust: return;
}
    // rust: let Some(keys) = auth::chat_keys_for(account.uuid) else {
    // rust: return;
}
    // rust: if r.secure_chat
    // rust: .session
    // rust: .as_ref()
    // rust: .is_some_and(|(k, _)| Arc::ptr_eq(k, &keys))
    // rust: {
    // rust: return;
}
    // rust: let id = random_uuid();
    // rust: let packet = S::ChatSessionUpdate(play::ChatSessionUpdate {
    // rust: session: id,
    // rust: expires_at: keys.public.expires_at,
    // rust: key: keys.public.key.clone(),
    // rust: key_signature: keys.public.signature.clone(),
    // rust: });
    // rust: r.secure_chat.session = Some((keys, Encoder::new(account.uuid, id)));
    // rust: self.send(packet);
}

    // ClientPacketListener.sendChat: the last-seen update goes with every
    // message; the signature only with a chat session.
    // rust: pub(super) fn send_signed_chat(&mut self, content: &str) {
    // rust: let content = truncate_utf16(content, 256);
    // rust: let (timestamp, salt) = (auth::now_millis(), salt());
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let chat = &mut r.secure_chat;
    // rust: let seen = chat.tracker.update();
    // rust: let signature = chat.session.as_mut().and_then(|(keys, encoder)| {
    // rust: sign(
    // rust: keys,
    // rust: encoder,
    // rust: &Body {
    // rust: content: &content,
    // rust: timestamp,
    // rust: salt,
    // rust: last_seen: &seen.last_seen,
    // rust: },
    // rust: )
    // rust: });
    // rust: self.send(S::Chat(play::Chat {
    // rust: message: content,
    // rust: timestamp,
    // rust: salt,
    // rust: signature: signature.map(|s| s.to_vec()),
    // rust: last_seen: seen.update,
    // rust: }));
}

    // ClientPacketListener.sendCommand: a command with message arguments
    // (SignableCommand.of over the chat's tree, the server's once it sent one) has each of them signed,
    // all with the same time, salt and last seen (without a chat session the
    // signature list is empty, as in vanilla); any other command goes as the
    // unsigned packet.
    // rust: pub(super) fn send_command(&mut self, command: &str) {
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let arguments: Vec<(String, String)> = if r.chat_tree_received {
    // rust: r.chat_tree
    // rust: .parse(command, &self.ui.registries)
    // rust: .signable_arguments(&r.chat_tree)
    // rust: } else {
    // rust: Vec::new()
}
    // rust: if arguments.is_empty() {
    // rust: self.send(S::ChatCommand(play::ChatCommand {
    // rust: command: command.to_owned(),
    // rust: }));
    // rust: return;
}
    // rust: let (timestamp, salt) = (auth::now_millis(), salt());
    // rust: let chat = &mut r.secure_chat;
    // rust: let seen = chat.tracker.update();
    // rust: let mut signatures = Vec::new();
    // rust: if let Some((keys, encoder)) = chat.session.as_mut() {
    // rust: for (name, value) in arguments {
    // rust: let body = Body {
    // rust: content: &value,
    // rust: timestamp,
    // rust: salt,
    // rust: last_seen: &seen.last_seen,
}
    // rust: if let Some(signature) = sign(keys, encoder, &body) {
    // rust: signatures.push((name, signature.to_vec()));
}
}
}
    // rust: self.send(S::ChatCommandSigned(play::ChatCommandSigned {
    // rust: command: command.to_owned(),
    // rust: timestamp,
    // rust: salt,
    // rust: arguments: signatures,
    // rust: last_seen: seen.update,
    // rust: }));
}

    // ClientPacketListener.sendUnattendedCommand: a command the player
    // didn't type (a clicked chat line, a dialog's button, a mod's command)
    // goes unsigned when `verify_command` has no issue with it. Any other
    // asks first, and one with a message argument is never sent from here:
    // the player can only send it themselves, from the chat box. So neither
    // a server nor a mod can have the player sign a message they never saw.
    // rust: pub(super) fn send_unattended_command(&mut self, command: &str) {
    // rust: let command = command.trim();
    // rust: let command = command.strip_prefix('/').unwrap_or(command);
    // rust: if command.is_empty() || !self.chat_abilities().allows(&format!("/{command}")) {
    // rust: return;
}
    // rust: let Some(r) = self.remote.as_ref() else {
    // rust: return;
}
        // Vanilla's dispatcher is empty until the server sends its tree.
    // rust: let check = if r.chat_tree_received {
    // rust: verify_command(&r.chat_tree, &self.ui.registries, command)
    // rust: } else {
    // rust: CommandCheck::ParseErrors
}
        // screenAfterCommand: what stays once it has run, a dialog included.
    // rust: let over_screen = self.screen != Screen::Playing || self.dialog_open();
    // rust: let (message, accept) = match check {
    // rust: CommandCheck::NoIssues => {
    // rust: self.send(S::ChatCommand(play::ChatCommand {
    // rust: command: command.to_owned(),
    // rust: }));
    // rust: return;
}
    // rust: CommandCheck::ParseErrors => (
    // rust: "multiplayer.confirm_command.parse_errors",
    // rust: CommandAccept::Run,
    // rust: ),
    // rust: CommandCheck::PermissionsRequired => (
    // rust: "multiplayer.confirm_command.permissions_required",
    // rust: CommandAccept::Run,
    // rust: ),
    // rust: CommandCheck::SignatureRequired => (
    // rust: "multiplayer.confirm_command.signature_required",
    // rust: if over_screen {
    // rust: CommandAccept::Copy
    // rust: } else {
    // rust: CommandAccept::Suggest
    // rust: },
    // rust: ),
}
    // rust: self.command_prompt = Some(CommandPrompt {
    // rust: command: command.to_owned(),
    // rust: message,
    // rust: accept,
    // rust: over_screen,
    // rust: behind: None,
    // rust: focus: None,
    // rust: });
    // rust: self.capture(false);
}

    // The command just clicked left this screen: if it asks, no returns there.
    // rust: pub(super) fn command_prompt_returns_to(&mut self, behind: Behind) {
    // rust: if let Some(prompt) = self.command_prompt.as_mut() {
    // rust: prompt.behind = Some(behind);
    // rust: prompt.over_screen = true;
}
}

    // The translation key of the open confirmation's message.
    // rust: pub(super) fn command_prompt_message(&self) -> Option<&'static str> {
    // rust: self.command_prompt.as_ref().map(|p| p.message)
}

    // The confirmation's title, the command in yellow in its message, and
    // its two buttons.
command_prompt_layout :: proc(self: ^Self, prompt: ^CommandPrompt, size: (f32) {
}
    // rust: let command = Text::literal(&prompt.command).with_color(0xFF_FF55);
    // rust: let mut choice = Choice::new(
    // rust: &self.gui.atlas.font,
    // rust: size,
    // rust: &Text::translate("multiplayer.confirm_command.title", &[]),
    // rust: &Text::translate(prompt.message, &[command]),
    // rust: 2,
    // rust: 150.0,
    // rust: );
    // rust: choice.focus = prompt.focus;
    // rust: choice
}

    // rust: pub(super) fn draw_command_prompt(&self, batch: &mut HudBatch) {
    // rust: let Some(prompt) = &self.command_prompt else {
    // rust: return;
}
    // rust: horizon_client::widgets::cover_frame();
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: super::screen_info::confirm(
    // rust: "multiplayer/confirm_command",
    // rust: &super::screen_info::tr("multiplayer.confirm_command.title", &[]),
    // rust: &prompt.command,
    // rust: )
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: horizon_client::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let labels = [
    // rust: Text::translate(
    // rust: match prompt.accept {
    // rust: CommandAccept::Run => "multiplayer.confirm_command.run_command",
    // rust: CommandAccept::Suggest => "multiplayer.confirm_command.suggest_command",
    // rust: CommandAccept::Copy => "chat.copy",
    // rust: },
    // rust: &[],
    // rust: ),
    // rust: Text::translate(
    // rust: if prompt.over_screen {
    // rust: "gui.back"
    // rust: } else {
    // rust: "gui.cancel"
    // rust: },
    // rust: &[],
    // rust: ),
    // rust: ];
    // rust: let mut layout = self.command_prompt_layout(prompt, (w, h));
    // rust: layout.declare_no(1);
    // rust: layout.draw(batch, atlas, self.cursor, &labels);
}

    // The confirmation's answer; on no, what was behind it is back.
    // rust: pub(super) fn answer_command_prompt(&mut self, yes: bool) {
    // rust: let Some(prompt) = self.command_prompt.take() else {
    // rust: return;
}
    // rust: match (yes, prompt.accept, prompt.behind) {
    // rust: (true, CommandAccept::Run, _) => {
    // rust: if self.remote.is_some() {
    // rust: self.send(S::ChatCommand(play::ChatCommand {
    // rust: command: prompt.command,
    // rust: }));
}
}
            // Gui.openChatAndAddText.
    // rust: (true, CommandAccept::Suggest, _) => self.open_chat(&format!("/{}", prompt.command)),
    // rust: (true, CommandAccept::Copy, _) => {
//                 use horizon_client::clipboard::Clipboard;
    // rust: self.clipboard.set(&format!("/{}", prompt.command));
}
    // rust: (false, _, Some(Behind::Book(book))) => self.book = Some(*book),
    // rust: (false, _, Some(Behind::Dialog(dialog))) => self.reopen_dialog(dialog),
    // rust: (false, _, None) => {}
}
    // rust: if self.screen == Screen::Playing && !self.screen_over_playing() {
    // rust: self.capture(true);
}
}

    // ConfirmScreen.keyPressed, and what its buttons take from the keyboard
    // (Screen's focus navigation, AbstractButton's Enter and Space).
    // rust: pub(super) fn command_prompt_key(&mut self, key: KeyCode) {
    // rust: let (size, shift) = (self.gui_size(), self.has_shift_down());
    // rust: let Some(prompt) = &self.command_prompt else {
    // rust: return;
}
    // rust: let mut choice = self.command_prompt_layout(prompt, size);
    // rust: match key {
    // rust: KeyCode::Escape => return self.answer_command_prompt(false),
    // rust: KeyCode::Tab => choice.tab(shift),
    // rust: KeyCode::ArrowLeft | KeyCode::ArrowRight => choice.arrow(key == KeyCode::ArrowLeft),
    // rust: KeyCode::Enter | KeyCode::NumpadEnter | KeyCode::Space => {
    // rust: if let Some(button) = choice.pressed() {
    // rust: self.audio.play_button_click();
    // rust: self.answer_command_prompt(button == 0);
}
    // rust: return;
}
    // rust: _ => return,
}
    // rust: let focus = choice.focus;
    // rust: if let Some(prompt) = self.command_prompt.as_mut() {
    // rust: prompt.focus = focus;
}
}

    // rust: pub(super) fn command_prompt_click(&mut self) {
    // rust: let Some(prompt) = &self.command_prompt else {
    // rust: return;
}
    // rust: let pressed = self
    // rust: .command_prompt_layout(prompt, self.gui_size())
    // rust: .pressed_at(self.cursor);
    // rust: if let Some(button) = pressed {
    // rust: self.audio.play_button_click();
    // rust: self.answer_command_prompt(button == 0);
}
}

    // markMessageAsProcessed, when the chat takes a signed message (past
    // any Chat Delay): whether it was shown, and an acknowledgement once more
    // than 64 wait (sendChatAcknowledgement).
    // rust: pub(super) fn mark_message_processed(&mut self, signature: &Signature, shown: bool) {
    // rust: let Some(r) = self.remote.as_mut() else {
    // rust: return;
}
    // rust: let tracker = &mut r.secure_chat.tracker;
    // rust: if tracker.add_pending(signature, shown) && tracker.offset() > ACK_AFTER {
    // rust: let offset = tracker.take_offset();
    // rust: self.send(S::ChatAck(play::ChatAck { offset }));
}
}

    // `ClientPacketListener.sendChatAcknowledgement`, used after a
    // configuration transition flushes the delayed chat queue.
    // rust: pub(super) fn send_chat_acknowledgement(&mut self) {
    // rust: let offset = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .map(|r| r.secure_chat.tracker.take_offset())
    // rust: .unwrap_or(0);
    // rust: if offset > 0 {
    // rust: self.send(S::ChatAck(play::ChatAck { offset }));
}
}
}

    // rust: mod tests {
//     use super::truncate_utf16;

chat_limit_counts_utf16_units :: proc() {
}
    // rust: let emojis = "😀".repeat(256);
    // rust: assert_eq!(truncate_utf16(&emojis, 256).encode_utf16().count(), 256);
    // rust: assert_eq!(truncate_utf16(&emojis, 255).encode_utf16().count(), 254);
    // rust: let mixed = format!("{}😀tail", "a".repeat(255));
    // rust: assert_eq!(truncate_utf16(&mixed, 256), "a".repeat(255));
}
}
