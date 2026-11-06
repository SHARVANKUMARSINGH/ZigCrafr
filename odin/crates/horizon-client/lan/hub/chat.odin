//! Transpiled from Horizon Rust crate
package horizon_client_chat

import "core:fmt"
import "core:mem"
import "core:math"

// Chat on the server side, as ServerGamePacketListenerImpl and PlayerList
// handle it: chat sessions validated against the services' keys, signed
// messages checked link by link, the acknowledged window, and messages
// relayed with each connection's numbering and signature cache.
// use super::{HostEvent, Hub};
// use horizon_client_core::text::Text;
// use horizon_protocol::{
    // rust: packets::play::{self, Clientbound as C},
    // rust: secure_chat::{self, Body, Chain, ChatSession, DecodeError, ProfileKey, Signature, Unpacked},
    // rust: text::{literal, translatable},
}
// use horizon_world::nbt::{JavaString, Tag};

// A player's chat message is about to be sent to everyone (after the secure-chat chain and the chat
// filter took it). A mod may cancel it, which drops it for everybody (the sender is not told, so push
// a line to `replies` to answer them), or only answer. It cannot change the text: a signed message
// would no longer verify. Once for each message a player sends, on a server. Commands are
// `native_player_command`. API 399.
    // rust: pub fn native_player_chat(
    // rust: player: u128,
    // rust: name: &str,
    // rust: message: &str,
    // rust: replies: &mut Vec<Text>,
    // rust: cancel: &mut bool,
    // rust: ) {
    // rust: crate::native_client_hooks::player_chat(player, name, message, replies, cancel);
}

// Now, in epoch milliseconds (Instant.now()).
now_millis :: proc() -> i {
    // Ported from Horizon
    return {}
}
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as i64)
}

// StringUtil.isAllowedChatCharacter.
allowed :: proc(c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: c != '\u{a7}' && c >= ' ' && c != '\u{7f}'
}

// A translatable message in red.
red :: proc(key: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut t = translatable(key, &[]);
    // rust: if let Tag::Compound(map) = &mut t {
    // rust: map.insert(
    // rust: JavaString::from("color"),
    // rust: Tag::String(JavaString::from("red")),
    // rust: );
}
    // rust: t
}

// PlayerChatMessage as the server relays it.
ChatMessage :: struct {
    sender: u128,
    // The link's index in the sender's chain (0 when unsigned).
    index: i32,
    signature: Maybe(Signature),
    content: string,
    // Epoch milliseconds.
    timestamp: i64,
    salt: i64,
    last_seen: [dynamic]Signature,
    // What clients show instead of the signed text (withUnsignedContent).
    unsigned_content: Maybe(Tag),
}

    // rust: impl ChatMessage {
    // The message a chain let through: a signed one keeps its body;
    // PlayerChatMessage.unsigned takes the time now, no salt, nothing seen.
new :: proc(sender: u128, unpacked: Unpacked, body: ^Body, now: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (index, signature, timestamp, salt, last_seen) = match unpacked {
    // rust: Unpacked::Unsigned => (0, None, now, 0, Vec::new()),
    // rust: Unpacked::Signed { index, signature } => (
    // rust: index,
    // rust: Some(signature),
    // rust: body.timestamp,
    // rust: body.salt,
    // rust: body.last_seen.to_vec(),
    // rust: ),
}
    // rust: Self {
    // rust: sender,
    // rust: index,
    // rust: signature,
    // rust: content: body.content.to_owned(),
    // rust: timestamp,
    // rust: salt,
    // rust: last_seen,
    // rust: unsigned_content: None,
}
}
    // hasExpiredServer.
expired :: proc(self: ^Self, now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: now > self.timestamp + secure_chat::EXPIRES_AFTER_SERVER
}
    // PlayerList.verifyChatTrusted: signed and not expired.
trusted :: proc(self: ^Self, now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.signature.is_some() && !self.expired(now)
}
}

    // rust: impl Hub {
    // MinecraftServer.enforceSecureProfile.
enforces_secure_chat :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.lan.shared.config.enforces_secure_chat()
}

    // Component.getString in the server's language, for the log.
    // rust: pub(crate) fn english(&self, tag: &Tag) -> String {
    // rust: match &self.lan.shared.config.log {
    // rust: Some(log) => horizon_protocol::text::plain(tag, &log.lang),
    // rust: None => horizon_protocol::text::plain(tag, &Default::default()),
}
}

    // tryHandleChat: an illegal character disconnects; with chat hidden a
    // message (not a command) is refused. Whether to go on.
try_handle_chat :: proc(self: ^Self, i: uint, message: string, command: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let conn = self.guests[i].conn;
    // rust: if !message.chars().all(allowed) {
    // rust: self.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.illegal_characters", &[]),
    // rust: );
    // rust: return false;
}
        // ChatVisiblity.HIDDEN.
    // rust: if !command && self.guests[i].info.chat_visibility == 2 {
    // rust: self.guests[i].send(&C::SystemChat(play::SystemChat {
    // rust: content: red("chat.disabled.options"),
    // rust: overlay: false,
    // rust: }));
    // rust: return false;
}
    // rust: true
}

    // unpackAndApplyLastSeen: the acknowledged messages, or a disconnect.
    // rust: pub fn apply_last_seen(
    // rust: &mut self,
    // rust: i: usize,
    // rust: update: &play::LastSeenUpdate,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) -> Option<Vec<Signature>> {
    // rust: let g = &mut self.guests[i];
    // rust: match g
    // rust: .last_seen
    // rust: .apply_update(update.offset, update.acknowledged, update.checksum)
    // rust: {
    // rust: Ok(seen) => Some(seen),
            // Vanilla logs the ValidationException's stack trace after the line.
    // rust: Err(_) => {
    // rust: events.push(HostEvent::Error(format!(
    // rust: "Failed to validate message acknowledgements from {}",
    // rust: g.name
    // rust: )));
    // rust: let conn = g.conn;
    // rust: self.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.chat_validation_failed", &[]),
    // rust: );
    // rust: None
}
}
}

    // handleChatAck.
    // rust: pub(super) fn chat_ack(&mut self, i: usize, offset: i32, events: &mut Vec<HostEvent>) {
    // rust: let g = &mut self.guests[i];
    // rust: if g.last_seen.apply_offset(offset).is_err() {
    // rust: events.push(HostEvent::Error(format!(
    // rust: "Failed to validate message acknowledgement offset from {}",
    // rust: g.name
    // rust: )));
    // rust: let conn = g.conn;
    // rust: self.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.chat_validation_failed", &[]),
    // rust: );
}
}

    // handleMessageDecodeFailure: logged, and the reason in red for the player.
decode_failure :: proc(self: ^Self, i: uint, e: DecodeError, events: ^[dynamic]HostEvent) {
}
    // rust: let reason = red(e.key());
    // rust: events.push(HostEvent::Warn(format!(
    // rust: "Failed to update secure chat state for {}: '{}'",
    // rust: self.guests[i].name,
    // rust: self.english(&reason)
    // rust: )));
    // rust: self.guests[i].send(&C::SystemChat(play::SystemChat {
    // rust: content: reason,
    // rust: overlay: false,
    // rust: }));
}

    // handleChat: the acknowledgements, then the message through the
    // sender's chain, then to everyone.
    // rust: pub(super) fn handle_chat(&mut self, i: usize, c: play::Chat, events: &mut Vec<HostEvent>) {
    // rust: let Some(last_seen) = self.apply_last_seen(i, &c.last_seen, events) else {
    // rust: return;
}
    // rust: if !self.try_handle_chat(i, &c.message, false) {
    // rust: return;
}
    // rust: let (enforce, now) = (self.enforces_secure_chat(), now_millis());
    // rust: let body = Body {
    // rust: content: &c.message,
    // rust: timestamp: c.timestamp,
    // rust: salt: c.salt,
    // rust: last_seen: &last_seen,
}
    // rust: let signature = c.signature.as_deref().and_then(secure_chat::signature);
    // rust: let g = &mut self.guests[i];
    // rust: let (uuid, name) = (g.uuid, g.name.clone());
    // rust: let message = match g
    // rust: .chain
    // rust: .unpack(uuid, signature.as_ref(), &body, enforce, now)
    // rust: {
    // rust: Ok(unpacked) => ChatMessage::new(uuid, unpacked, &body, now),
    // rust: Err(e) => return self.decode_failure(i, e, events),
}
    // rust: if message.signature.is_some() && message.expired(now) {
    // rust: events.push(HostEvent::Warn(format!(
    // rust: "Received expired chat: '{}'. Is the client/server system time unsynchronized?",
    // rust: message.content
    // rust: )));
}
        // The chat filter (docs/chat-filter.md): after the chain took the message, before anyone sees it.
    // rust: if !self.chat_allowed(
    // rust: i,
    // rust: &[&message.content],
    // rust: super::chat_filter::Place::Chat,
    // rust: events,
    // rust: ) {
    // rust: return;
}
        // The mods may refuse it (a muted player), before anyone sees it.
    // rust: if self.mods_loaded {
    // rust: let (mut cancel, mut replies) = (false, Vec::new());
    // rust: native_player_chat(uuid, &name, &message.content, &mut replies, &mut cancel);
    // rust: for line in replies {
    // rust: self.guests[i].send(&C::SystemChat(play::SystemChat {
    // rust: content: crate::lan::data::component_nbt(&line.component()),
    // rust: overlay: false,
    // rust: }));
}
    // rust: if cancel {
    // rust: return;
}
}
    // rust: let bound = play::ChatTypeBound {
    // rust: chat_type: self.chat_type,
    // rust: name: self.player_display_name(uuid, &name),
    // rust: target: None,
}
    // rust: let line = format!("<{name}> {}", message.content);
    // rust: self.broadcast_chat(&message, &bound, line, events);
    // rust: events.push(HostEvent::PlayerChat {
    // rust: sender: uuid,
    // rust: text: message.content,
    // rust: });
}

    // handleChatSessionUpdate: a new profile key, validated against the
    // services' keys, starts a new chain and is announced to everyone.
    // rust: pub(super) fn chat_session_update(
    // rust: &mut self,
    // rust: i: usize,
    // rust: p: play::ChatSessionUpdate,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) {
    // rust: let key = ProfileKey {
    // rust: expires_at: p.expires_at,
    // rust: key: p.key,
    // rust: signature: p.key_signature,
}
    // rust: let g = &self.guests[i];
    // rust: let (conn, uuid) = (g.conn, g.uuid);
    // rust: let old = g.chain.session().map(|s| s.profile_key.expires_at);
    // rust: if g.chain.session().is_some_and(|s| s.profile_key == key) {
    // rust: return;
}
    // rust: if old.is_some_and(|old| key.expires_at < old) {
    // rust: self.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.expired_public_key", &[]),
    // rust: );
    // rust: return;
}
    // rust: let secure = self.lan.shared.config.secure_chat.clone();
    // rust: let keys = secure.as_deref().map_or(&[][..], |s| s.keys());
    // rust: if keys.is_empty() {
    // rust: events.push(HostEvent::Warn(format!(
    // rust: "Ignoring chat session from {} due to missing Services public key",
    // rust: g.name
    // rust: )));
    // rust: return;
}
    // rust: match ChatSession::validate(p.session, key, keys, uuid) {
    // rust: Ok(session) => {
    // rust: let data = session.data();
    // rust: self.guests[i].chain = Chain::keyed(session);
                // resetPlayerChatState: INITIALIZE_CHAT to every player.
    // rust: self.broadcast(&C::PlayerInfoUpdate(play::PlayerInfoUpdate {
    // rust: actions: 2,
    // rust: entries: vec![play::PlayerInfo {
    // rust: uuid,
    // rust: chat_session: Some(data),
    // rust: ..Default::default()
    // rust: }],
    // rust: }));
}
    // rust: Err(reason) => {
    // rust: events.push(HostEvent::Error(
    // rust: "Failed to validate profile key".to_owned(),
    // rust: ));
    // rust: self.kick(conn, translatable(reason, &[]));
}
}
}

    // PlayerList.broadcastChatMessage: logged (`[Not Secure]` unless signed
    // and fresh), then sent to every player.
    // rust: pub fn broadcast_chat(
    // rust: &mut self,
    // rust: message: &ChatMessage,
    // rust: bound: &play::ChatTypeBound,
    // rust: line: String,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) {
    // rust: let secure = message.trusted(now_millis());
    // rust: events.push(HostEvent::Chat { line, secure });
    // rust: for k in 0..self.guests.len() {
    // rust: if self.guests[k].placed {
    // rust: self.send_chat(k, message, bound);
}
}
}

    // ServerPlayer.sendChatMessage (players who show chat) and
    // sendPlayerChatMessage: numbered for the connection, the last seen
    // packed against its cache; a signed message joins the cache and the
    // messages the player must acknowledge.
send_chat :: proc(self: ^Self, k: uint, message: ^ChatMessage, bound: ^play::ChatTypeBound) {
}
    // rust: let g = &mut self.guests[k];
    // rust: if g.info.chat_visibility != 0 {
    // rust: return;
}
    // rust: let last_seen = message
    // rust: .last_seen
    // rust: .iter()
    // rust: .map(|s| g.signatures.pack(s))
    // rust: .collect();
    // rust: g.send(&C::PlayerChat(play::PlayerChat {
    // rust: global_index: g.chat_index,
    // rust: sender: message.sender,
    // rust: index: message.index,
    // rust: signature: message.signature.map(|s| s.to_vec()),
    // rust: content: message.content.clone(),
    // rust: timestamp: message.timestamp,
    // rust: salt: message.salt,
    // rust: last_seen,
    // rust: unsigned_content: message.unsigned_content.clone(),
    // rust: filter: (0, Vec::new()),
    // rust: chat_type: bound.clone(),
    // rust: }));
    // rust: g.chat_index += 1;
    // rust: if let Some(signature) = &message.signature {
    // rust: g.signatures.push(&message.last_seen, Some(signature));
    // rust: g.last_seen.add_pending(signature);
    // rust: if g.last_seen.tracked_count() > 4096 {
    // rust: let conn = g.conn;
    // rust: self.kick(
    // rust: conn,
    // rust: translatable("multiplayer.disconnect.too_many_pending_chats", &[]),
    // rust: );
}
}
}

    // sendChatMessage of a system message: a disguised chat, to players
    // who show chat.
send_disguised :: proc(self: ^Self, k: uint, message: Tag, chat_type: play::ChatTypeBound) {
}
    // rust: let g = &self.guests[k];
    // rust: if g.info.chat_visibility == 0 {
    // rust: g.send(&C::DisguisedChat(play::DisguisedChat {
    // rust: message,
    // rust: chat_type,
    // rust: }));
}
}

    // collectSignedArguments, or collectUnsignedArguments when the client
    // signed none: each of the command's message arguments (`parsed`, by
    // name) through the sender's chain.
    // rust: pub fn signed_arguments(
    // rust: &mut self,
    // rust: i: usize,
    // rust: p: &play::ChatCommandSigned,
    // rust: parsed: &[(String, String)],
    // rust: last_seen: &[Signature],
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) -> Result<Vec<(String, ChatMessage)>, DecodeError> {
    // rust: let (enforce, now) = (self.enforces_secure_chat(), now_millis());
    // rust: let g = &mut self.guests[i];
    // rust: let uuid = g.uuid;
    // rust: let mut out = Vec::new();
    // rust: if p.arguments.is_empty() {
    // rust: for (name, value) in parsed {
                // SignedMessageBody.unsigned.
    // rust: let body = Body {
    // rust: content: value,
    // rust: timestamp: now,
    // rust: salt: 0,
    // rust: last_seen: &[],
}
    // rust: let unpacked = g.chain.unpack(uuid, None, &body, enforce, now)?;
    // rust: out.push((name.clone(), ChatMessage::new(uuid, unpacked, &body, now)));
}
    // rust: return Ok(out);
}
    // rust: let mismatch = |events: &mut Vec<HostEvent>| {
    // rust: let names = |l: &mut dyn Iterator<Item = &String>| {
    // rust: l.map(String::as_str).collect::<Vec<_>>().join(", ")
}
    // rust: events.push(HostEvent::Error(format!(
    // rust: "Signed command mismatch between server and client ('{}'): got [{}] from client, but expected [{}]",
    // rust: p.command,
    // rust: names(&mut p.arguments.iter().map(|a| &a.0)),
    // rust: names(&mut parsed.iter().map(|a| &a.0)),
    // rust: )));
    // rust: DecodeError::InvalidCommandSignature
}
    // rust: for (name, signature) in &p.arguments {
    // rust: let Some((_, value)) = parsed.iter().find(|(n, _)| n == name) else {
    // rust: g.chain.set_broken();
    // rust: return Err(mismatch(events));
}
    // rust: let body = Body {
    // rust: content: value,
    // rust: timestamp: p.timestamp,
    // rust: salt: p.salt,
    // rust: last_seen,
}
    // rust: let signature = secure_chat::signature(signature);
    // rust: let unpacked = g
    // rust: .chain
    // rust: .unpack(uuid, signature.as_ref(), &body, enforce, now)?;
    // rust: out.push((name.clone(), ChatMessage::new(uuid, unpacked, &body, now)));
}
    // rust: if parsed.iter().any(|(n, _)| !out.iter().any(|(o, _)| o == n)) {
    // rust: return Err(mismatch(events));
}
    // rust: Ok(out)
}

    // A message command's chat (SayCommand, EmoteCommands): to everyone,
    // bound to `chat_type` and the sender's name.
    // rust: pub fn broadcast_command_chat(
    // rust: &mut self,
    // rust: i: usize,
    // rust: chat_type: &str,
    // rust: message: Option<ChatMessage>,
    // rust: text: &str,
    // rust: events: &mut Vec<HostEvent>,
    // rust: ) {
    // rust: let (uuid, name) = (self.guests[i].uuid, self.guests[i].name.clone());
    // rust: let bound = play::ChatTypeBound {
    // rust: chat_type: self.chat_type_id(chat_type),
    // rust: name: self.player_display_name(uuid, &name),
    // rust: target: None,
}
    // rust: let line = match chat_type {
    // rust: "say_command" => format!("[{name}] {text}"),
    // rust: _ => format!("* {name} {text}"),
}
    // rust: match message {
    // rust: Some(message) => self.broadcast_chat(&message, &bound, line, events),
            // An unsigned command packet (no signing context):
            // PlayerChatMessage.system, a disguised chat.
    // rust: None => {
    // rust: events.push(HostEvent::Chat {
    // rust: line,
    // rust: secure: false,
    // rust: });
    // rust: for k in 0..self.guests.len() {
    // rust: if self.guests[k].placed {
    // rust: self.send_disguised(k, literal(text), bound.clone());
}
}
}
}
}

    // MsgCommand.sendMessage to each target: the outgoing line for the
    // sender, the incoming one for the target. Nothing is logged.
    // rust: pub fn whisper(
    // rust: &mut self,
    // rust: i: usize,
    // rust: targets: &[usize],
    // rust: message: Option<ChatMessage>,
    // rust: text: &str,
    // rust: ) {
    // rust: let (uuid, name) = (self.guests[i].uuid, self.guests[i].name.clone());
    // rust: let (outgoing, incoming) = (
    // rust: self.chat_type_id("msg_command_outgoing"),
    // rust: self.chat_type_id("msg_command_incoming"),
    // rust: );
    // rust: for &t in targets {
    // rust: let target = self.player_display_name(self.guests[t].uuid, &self.guests[t].name);
    // rust: let out = play::ChatTypeBound {
    // rust: chat_type: outgoing,
    // rust: name: self.player_display_name(uuid, &name),
    // rust: target: Some(target),
}
    // rust: let inc = play::ChatTypeBound {
    // rust: chat_type: incoming,
    // rust: name: self.player_display_name(uuid, &name),
    // rust: target: None,
}
    // rust: match &message {
    // rust: Some(m) => {
    // rust: self.send_chat(i, m, &out);
    // rust: self.send_chat(t, m, &inc);
}
    // rust: None => {
    // rust: self.send_disguised(i, literal(text), out);
    // rust: self.send_disguised(t, literal(text), inc);
}
}
}
}

    // A chat type's registry id.
chat_type_id :: proc(self: ^Self, name: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.sync
    // rust: .id("minecraft:chat_type", &format!("minecraft:{name}"))
    // rust: .unwrap_or(self.chat_type)
}
}
