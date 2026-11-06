//! Transpiled from Horizon Rust crate
package horizon_protocol_secure_chat

import "core:fmt"
import "core:mem"
import "core:math"

// Secure chat as vanilla 26.3's server keeps it: a player's profile key,
// validated against the services' keys (ProfilePublicKey,
// RemoteChatSession), the message chain each player signs
// (SignedMessageChain), what a signature covers (PlayerChatMessage,
// SignedMessageLink, SignedMessageBody), the window of messages a client
// acknowledges (LastSeenMessagesValidator) and the cache a connection packs
// signatures against (MessageSignatureCache).
// use crate::{
    // rust: packets::play::LastSeenUpdate,
    // rust: rsa::{RsaPrivateKey, RsaPublicKey, SignatureHash},
}
// use std::collections::{HashSet, VecDeque};

// MessageSignature.BYTES.
SIGNATURE_BYTES :: 256
// A message signature (MessageSignature).
    // rust: pub type Signature = [u8; SIGNATURE_BYTES];
// LastSeenMessages.LAST_SEEN_MESSAGES_MAX_LENGTH: the window a client acknowledges.
LAST_SEEN :: 20
// PlayerChatMessage.MESSAGE_EXPIRES_AFTER_SERVER, in milliseconds.
EXPIRES_AFTER_SERVER :: 5 * 60 * 1000

// A signature from its packet bytes (always 256 on the wire).
signature :: proc(bytes: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: bytes.try_into().ok()
}

// ProfilePublicKey.Data: the player's chat key (X.509 DER), when it
// expires (epoch milliseconds), and the services' signature over both.
ProfileKey :: struct {
    expires_at: i64,
    key: [dynamic]u8,
    signature: [dynamic]u8,
}

    // rust: impl ProfileKey {
    // Data.signedPayload: the profile id, the expiry and the key.
signed_payload :: proc(self: ^Self, profile: u128) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::with_capacity(24 + self.key.len());
    // rust: out.extend_from_slice(&profile.to_be_bytes());
    // rust: out.extend_from_slice(&self.expires_at.to_be_bytes());
    // rust: out.extend_from_slice(&self.key);
    // rust: out
}
    // Data.validateSignature with the services' profile-key keys
    // (SignatureValidator.from(keySet, PROFILE_KEY): any of them, SHA1withRSA).
signed_by :: proc(self: ^Self, services: ^[RsaPublicKey], profile: u128) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let payload = self.signed_payload(profile);
    // rust: services
    // rust: .iter()
    // rust: .any(|k| k.verify(SignatureHash::Sha1, &payload, &self.signature))
}
    // Data.hasExpired.
has_expired :: proc(self: ^Self, now: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.expires_at < now
}
    // ProfilePublicKey.Data.hasExpired(Duration): the expiry plus a grace period, in milliseconds.
has_expired_with :: proc(self: ^Self, now: i64, grace: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.expires_at.saturating_add(grace) < now
}
}

// ProfilePublicKey.EXPIRY_GRACE_PERIOD (8 hours), in milliseconds: how long past its expiry a
// player's key still validates the chat a client reads.
EXPIRY_GRACE_PERIOD :: 8 * 60 * 60 * 1000

// A validated RemoteChatSession: its id and the player's profile key.
ChatSession :: struct {
    id: u128,
    profile_key: ProfileKey,
    key: RsaPublicKey,
}

    // rust: impl ChatSession {
    // RemoteChatSession.Data.validate (ProfilePublicKey.createValidated);
    // the error is the disconnect message's translation key.
    // rust: pub fn validate(
    // rust: id: u128,
    // rust: profile_key: ProfileKey,
    // rust: services: &[RsaPublicKey],
    // rust: profile: u128,
    // rust: ) -> Result<Self, &'static str> {
INVALID :: "multiplayer.disconnect.invalid_public_key_signature"
    // rust: let key = RsaPublicKey::from_der(&profile_key.key).map_err(|_| INVALID)?;
    // rust: if !profile_key.signed_by(services, profile) {
    // rust: return Err(INVALID);
}
    // rust: Ok(Self {
    // rust: id,
    // rust: profile_key,
    // rust: key,
    // rust: })
}
    // RemoteChatSession.Data, as ClientboundPlayerInfoUpdatePacket's
    // INITIALIZE_CHAT carries it.
data :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let k = &self.profile_key;
    // rust: (self.id, k.expires_at, k.key.clone(), k.signature.clone())
}
}

// SignedMessageBody: what a player signed besides the chain link.
Body :: struct {
    content: ^'a str,
    // Epoch milliseconds.
    timestamp: i64,
    salt: i64,
    last_seen: ^'a [Signature],
}

// PlayerChatMessage.updateSignature: the version, the link (sender,
// session, index) and the body (salt, time in seconds, content, last seen).
signed_payload :: proc(sender: u128, session: u128, index: i32, body: ^Body) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let content = body.content.as_bytes();
    // rust: let mut out = Vec::with_capacity(64 + content.len() + body.last_seen.len() * SIGNATURE_BYTES);
    // rust: out.extend_from_slice(&1i32.to_be_bytes());
    // rust: out.extend_from_slice(&sender.to_be_bytes());
    // rust: out.extend_from_slice(&session.to_be_bytes());
    // rust: out.extend_from_slice(&index.to_be_bytes());
    // rust: out.extend_from_slice(&body.salt.to_be_bytes());
    // rust: out.extend_from_slice(&body.timestamp.div_euclid(1000).to_be_bytes());
    // rust: out.extend_from_slice(&(content.len() as i32).to_be_bytes());
    // rust: out.extend_from_slice(content);
    // rust: out.extend_from_slice(&(body.last_seen.len() as i32).to_be_bytes());
    // rust: for s in body.last_seen {
    // rust: out.extend_from_slice(s);
}
    // rust: out
}

// SignedMessageChain.DecodeException's messages, and the signed command
// mismatch (ServerGamePacketListenerImpl.INVALID_COMMAND_SIGNATURE).
DecodeError :: enum {
    MissingProfileKey,
    ChainBroken,
    ExpiredProfileKey,
    InvalidSignature,
    OutOfOrderChat,
    InvalidCommandSignature,
}

    // rust: impl DecodeError {
key :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::MissingProfileKey => "chat.disabled.missingProfileKey",
    // rust: Self::ChainBroken => "chat.disabled.chain_broken",
    // rust: Self::ExpiredProfileKey => "chat.disabled.expiredProfileKey",
    // rust: Self::InvalidSignature => "chat.disabled.invalid_signature",
    // rust: Self::OutOfOrderChat => "chat.disabled.out_of_order_chat",
    // rust: Self::InvalidCommandSignature => "chat.disabled.invalid_command_signature",
}
}
}

// A message the chain let through: unsigned (PlayerChatMessage.unsigned)
// or signed at a link of the sender's chain.
Unpacked :: enum {
    Unsigned,
    Signed { index: i32, signature: Signature },
}

// A player's SignedMessageChain.Decoder: unsigned until the player sends a
// chat session, then keyed to it.
Chain :: struct {
    session: Maybe(ChatSession),
    // The next link's index; None once the chain is broken.
    next: Maybe(i32),
    // The last message's time (lastTimeStamp, from Instant.EPOCH).
    last_timestamp: i64,
}

    // rust: impl Chain {
    // RemoteChatSession.createMessageDecoder: a new chain from link 0.
keyed :: proc(session: ChatSession) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: session: Some(session),
    // rust: next: Some(0),
    // rust: last_timestamp: 0,
}
}
session :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.session.as_ref()
}
    // Decoder.unpack for `sender`'s message. Without a session the message
    // is unsigned unless the server enforces secure chat; with one it must
    // be the next link, in order, signed by the player's key.
    // rust: pub fn unpack(
    // rust: &mut self,
    // rust: sender: u128,
    // rust: signature: Option<&Signature>,
    // rust: body: &Body,
    // rust: enforce: bool,
    // rust: now: i64,
    // rust: ) -> Result<Unpacked, DecodeError> {
    // rust: let Some(session) = &self.session else {
    // rust: return if enforce {
    // rust: Err(DecodeError::MissingProfileKey)
    // rust: } else {
    // rust: Ok(Unpacked::Unsigned)
}
}
    // rust: let signature = signature.ok_or(DecodeError::MissingProfileKey)?;
    // rust: if session.profile_key.has_expired(now) {
    // rust: return Err(DecodeError::ExpiredProfileKey);
}
    // rust: let index = self.next.ok_or(DecodeError::ChainBroken)?;
    // rust: if body.timestamp < self.last_timestamp {
    // rust: self.next = None;
    // rust: return Err(DecodeError::OutOfOrderChat);
}
    // rust: self.last_timestamp = body.timestamp;
    // rust: let payload = signed_payload(sender, session.id, index, body);
    // rust: if !session
    // rust: .key
    // rust: .verify(SignatureHash::Sha256, &payload, signature)
    // rust: {
    // rust: self.next = None;
    // rust: return Err(DecodeError::InvalidSignature);
}
    // rust: self.next = index.checked_add(1);
    // rust: Ok(Unpacked::Signed {
    // rust: index,
    // rust: signature: *signature,
    // rust: })
}
    // Decoder.setChainBroken (nothing for the unsigned decoder).
set_broken :: proc(self: ^Self) {
}
    // rust: if self.session.is_some() {
    // rust: self.next = None;
}
}
}

// A chat packet's message as `PlayerChatMessage` carries it for a validator: its link (the
// sender's index in their session) and signature, and what the signature covers.
Incoming :: struct {
    sender: u128,
    index: i32,
    signature: Maybe(^'a Signature),
    body: Body<'a>,
    // The server's replacement for the content, and the filter mask: part of the record
    // `PlayerChatMessage.equals` compares.
    unsigned_content: Maybe(^'a horizon_world::nbt::Tag),
    filter: ^'a (i32,
}

// The record `PlayerChatMessage.equals` compares, kept for the last accepted message.
Accepted :: struct {
    sender: u128,
    session: u128,
    index: i32,
    signature: Signature,
    content: string,
    timestamp: i64,
    salt: i64,
    last_seen: [dynamic]Signature,
    unsigned_content: Maybe(horizon_world::nbt::Tag),
    filter: (i32,
}

// What a validator made of a message.
Validated :: enum {
    // `PlayerChatMessage.removeSignature`: shown as an unsigned message.
    Unsigned,
    // Signed by the sender's key, in order.
    Signed,
}

// `PlayerInfo.messageValidator`: how a client checks one player's chat
// (`SignedMessageValidator`).
MessageValidator :: enum {
    // `ACCEPT_UNSIGNED`: any message, its signature dropped.
    AcceptUnsigned,
    // `REJECT_ALL`: a player with no chat session on a server that enforces secure chat.
    RejectAll,
    // `KeyBased`: the player's session key, and the last message of the chain.
    KeyBased {,
    session: Box<ChatSession>,
        // The last accepted message.
    last: Option<Accepted>,
    chain_valid: bool,
    // rust: },
}

    // rust: impl MessageValidator {
    // `PlayerInfo.fallbackMessageValidator`.
fallback :: proc(enforces_secure_chat: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if enforces_secure_chat {
    // rust: Self::RejectAll
    // rust: } else {
    // rust: Self::AcceptUnsigned
}
}
    // `RemoteChatSession.createMessageValidator`.
keyed :: proc(session: ChatSession) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::KeyBased {
    // rust: session: Box::new(session),
    // rust: last: None,
    // rust: chain_valid: true,
}
}
    // `SignedMessageValidator.updateAndValidate` at `now` (epoch milliseconds): `None` is a
    // message that fails validation (`ChatListener.handleChatMessageError`), after which a
    // keyed chain accepts nothing more.
update_and_validate :: proc(self: ^Self, message: ^Incoming, now: i64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::AcceptUnsigned => Some(Validated::Unsigned),
    // rust: Self::RejectAll => None,
    // rust: Self::KeyBased {
    // rust: session,
    // rust: last,
    // rust: chain_valid,
    // rust: } => {
    // rust: *chain_valid = *chain_valid && Self::validate(session, last, message, now);
    // rust: if !*chain_valid {
    // rust: return None;
}
    // rust: *last = message.signature.map(|s| Accepted {
    // rust: sender: message.sender,
    // rust: session: session.id,
    // rust: index: message.index,
    // rust: signature: *s,
    // rust: content: message.body.content.to_owned(),
    // rust: timestamp: message.body.timestamp,
    // rust: salt: message.body.salt,
    // rust: last_seen: message.body.last_seen.to_vec(),
    // rust: unsigned_content: message.unsigned_content.cloned(),
    // rust: filter: message.filter.clone(),
    // rust: });
    // rust: Some(Validated::Signed)
}
}
}
    // `KeyBased.validate`: the key not expired (with the grace period), the signature over the
    // message, and the chain.
    // rust: fn validate(
    // rust: session: &ChatSession,
    // rust: last: &Option<Accepted>,
    // rust: message: &Incoming,
    // rust: now: i64,
    // rust: ) -> bool {
    // rust: if session
    // rust: .profile_key
    // rust: .has_expired_with(now, EXPIRY_GRACE_PERIOD)
    // rust: {
    // rust: return false;
}
        // PlayerChatMessage.verify: unsigned has no signature to verify.
    // rust: let Some(signature) = message.signature else {
    // rust: return false;
}
    // rust: let payload = signed_payload(message.sender, session.id, message.index, &message.body);
    // rust: if !session
    // rust: .key
    // rust: .verify(SignatureHash::Sha256, &payload, signature)
    // rust: {
    // rust: return false;
}
    // rust: Self::validate_chain(session, last, message, signature)
}
    // `KeyBased.validateChain`: the same message again (`message.equals(lastMessage)`), or a
    // descendant of the last one (`SignedMessageLink.isDescendantOf`: a greater index in the
    // same session, from the same sender).
    // rust: fn validate_chain(
    // rust: session: &ChatSession,
    // rust: last: &Option<Accepted>,
    // rust: message: &Incoming,
    // rust: signature: &Signature,
    // rust: ) -> bool {
    // rust: let Some(last) = last else {
    // rust: return true;
}
    // rust: let same = last.sender == message.sender
    // rust: && last.session == session.id
    // rust: && last.index == message.index
    // rust: && &last.signature == signature
    // rust: && last.content == message.body.content
    // rust: && last.timestamp == message.body.timestamp
    // rust: && last.salt == message.body.salt
    // rust: && last.last_seen == message.body.last_seen
    // rust: && last.unsigned_content.as_ref() == message.unsigned_content
    // rust: && &last.filter == message.filter;
    // rust: same || (message.index > last.index
    // rust: && message.sender == last.sender
    // rust: && session.id == last.session)
}
}

// Arrays.hashCode(byte[]).
java_hash :: proc(bytes: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: bytes.iter().fold(1i32, |h, &b| {
    // rust: h.wrapping_mul(31).wrapping_add(i32::from(b as i8))
    // rust: })
}

// LastSeenMessages.computeChecksum: never 0, which means "not checked".
checksum :: proc(entries: ^[Signature]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let c = entries
    // rust: .iter()
    // rust: .fold(1i32, |c, e| c.wrapping_mul(31).wrapping_add(java_hash(e)));
    // rust: match c as i8 {
    // rust: 0 => 1,
    // rust: b => b,
}
}

// LastSeenMessagesValidator: the messages sent to a player that its next
// acknowledgement may name, each pending until it does.
LastSeenValidator :: struct {
    tracked: VecDeque<Option<(Signature,
    last_pending: Maybe(Signature),
}

    // rust: impl Default for LastSeenValidator {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: tracked: std::iter::repeat_n(None, LAST_SEEN).collect(),
    // rust: last_pending: None,
}
}
}

    // rust: impl LastSeenValidator {
add_pending :: proc(self: ^Self, signature: ^Signature) {
}
    // rust: if self.last_pending.as_ref() != Some(signature) {
    // rust: self.tracked.push_back(Some((*signature, true)));
    // rust: self.last_pending = Some(*signature);
}
}
tracked_count :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.tracked.len()
}
    // applyOffset: drop the `offset` oldest messages.
apply_offset :: proc(self: ^Self, offset: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let max = self.tracked.len() as i64 - LAST_SEEN as i64;
    // rust: if offset >= 0 && i64::from(offset) <= max {
    // rust: self.tracked.drain(..offset as usize);
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!(
    // rust: "Advanced last seen window by {offset} messages, but expected at most {max}"
    // rust: ))
}
}
    // applyUpdate: the offset, then the acknowledged messages of the
    // window (a 20-bit set, little-endian bytes), checked against the
    // client's checksum unless it sent 0.
    // rust: pub fn apply_update(
    // rust: &mut self,
    // rust: offset: i32,
    // rust: acknowledged: [u8; 3],
    // rust: checksum: i8,
    // rust: ) -> Result<Vec<Signature>, String> {
    // rust: self.apply_offset(offset)?;
    // rust: let bit = |i: usize| acknowledged[i / 8] >> (i % 8) & 1 != 0;
    // rust: let length = (0..24).rev().find(|&i| bit(i)).map_or(0, |i| i + 1);
    // rust: if length > LAST_SEEN {
    // rust: return Err(format!(
    // rust: "Last seen update contained {length} messages, but maximum window size is {LAST_SEEN}"
    // rust: ));
}
    // rust: let mut seen = Vec::with_capacity(LAST_SEEN);
    // rust: for i in 0..LAST_SEEN {
    // rust: let entry = self.tracked[i];
    // rust: if bit(i) {
    // rust: let Some((s, _)) = entry else {
    // rust: return Err(format!(
    // rust: "Last seen update acknowledged unknown or previously ignored message at index {i}"
    // rust: ));
}
    // rust: self.tracked[i] = Some((s, false));
    // rust: seen.push(s);
    // rust: } else {
    // rust: if let Some((_, false)) = entry {
    // rust: return Err(format!(
    // rust: "Last seen update ignored previously acknowledged message at index {i}"
    // rust: ));
}
    // rust: self.tracked[i] = None;
}
}
    // rust: if checksum != 0 && checksum != self::checksum(&seen) {
    // rust: return Err(
    // rust: "Checksum mismatch on last seen update: the client and server must have desynced"
    // rust: .to_owned(),
    // rust: );
}
    // rust: Ok(seen)
}
}

// MessageSignatureCache: the 128 signatures a connection's client also
// holds, so a packed signature can name one by index.
SignatureCache :: struct {
    entries: [dynamic]Maybe(Signature),
}

    // rust: impl Default for SignatureCache {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: entries: vec![None; 128],
}
}
}

    // rust: impl SignatureCache {
    // MessageSignature.pack: the cache index, or the full signature.
pack :: proc(self: ^Self, signature: ^Signature) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self
    // rust: .entries
    // rust: .iter()
    // rust: .position(|e| e.as_ref() == Some(signature))
    // rust: {
    // rust: Some(i) => (i as i32, None),
    // rust: None => (-1, Some(signature.to_vec())),
}
}
    // `MessageSignature.Packed.unpack`: a full signature as it is, an
    // index as the cache holds it; `None` for an empty or unknown slot.
unpack :: proc(self: ^Self, packed: ^(i32) {
}
    // rust: match packed {
    // rust: (_, Some(full)) => signature(full),
    // rust: (id, None) => usize::try_from(*id)
    // rust: .ok()
    // rust: .and_then(|i| self.entries.get(i).copied().flatten()),
}
}
    // push(body, signature): the message's last seen and its signature go
    // to the front, most recent first; what they displace moves back.
push :: proc(self: ^Self, last_seen: ^[Signature], signature: Maybe(^Signature)) {
}
    // rust: let mut queue: VecDeque<Signature> = last_seen.iter().chain(signature).copied().collect();
    // rust: let new: HashSet<Signature> = queue.iter().copied().collect();
    // rust: for slot in &mut self.entries {
    // rust: let Some(next) = queue.pop_back() else { break };
    // rust: if let Some(old) = slot.replace(next)
    // rust: && !new.contains(&old)
    // rust: {
    // rust: queue.push_front(old);
}
}
}
}

// The local player's SignedMessageChain.Encoder (LocalChatSession.
// createMessageEncoder): each message signed with the chat key at the next
// link of the chain, from link 0 of a new session.
Encoder :: struct {
    sender: u128,
    session: u128,
    // The next link's index; None once the chain has run out.
    next: Maybe(i32),
}

    // rust: impl Encoder {
new :: proc(sender: u128, session: u128) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: sender,
    // rust: session,
    // rust: next: Some(0),
}
}
session :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.session
}
    // Encoder.pack: SHA256withRSA over PlayerChatMessage.updateSignature
    // at the next link, which then advances. None (the message goes
    // unsigned) once the chain has run out or the key can't sign a
    // MessageSignature-sized signature.
sign :: proc(self: ^Self, key: ^RsaPrivateKey, body: ^Body) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let index = self.next?;
    // rust: let payload = signed_payload(self.sender, self.session, index, body);
    // rust: let signature = signature(&key.sign(SignatureHash::Sha256, &payload).ok()?)?;
    // rust: self.next = index.checked_add(1);
    // rust: Some(signature)
}
}

// LastSeenMessagesTracker.Update: the signatures a message signs as seen,
// and the acknowledgement its packet carries.
SeenUpdate :: struct {
    last_seen: [dynamic]Signature,
    update: LastSeenUpdate,
}

// LastSeenMessagesTracker: the client's ring of the last 20 signed
// messages it processed (None for one it hid), and how many arrived since
// the last acknowledgement.
LastSeenTracker :: struct {
    // LastSeenTrackedEntry: the signature and whether it is still pending.
    tracked: Vec<Option<(Signature,
    tail: uint,
    offset: i32,
    last_tracked: Maybe(Signature),
}

    // rust: impl Default for LastSeenTracker {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: tracked: vec![None; LAST_SEEN],
    // rust: tail: 0,
    // rust: offset: 0,
    // rust: last_tracked: None,
}
}
}

    // rust: impl LastSeenTracker {
    // addPending: false for a repeat of the last message.
add_pending :: proc(self: ^Self, signature: ^Signature, shown: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.last_tracked.as_ref() == Some(signature) {
    // rust: return false;
}
    // rust: self.last_tracked = Some(*signature);
    // rust: self.tracked[self.tail] = shown.then_some((*signature, true));
    // rust: self.tail = (self.tail + 1) % LAST_SEEN;
    // rust: self.offset += 1;
    // rust: true
}
    // ignorePending: a deleted message that is still pending is dropped.
ignore_pending :: proc(self: ^Self, signature: ^Signature) {
}
    // rust: if let Some(entry) = self
    // rust: .tracked
    // rust: .iter_mut()
    // rust: .find(|e| matches!(e, Some((s, true)) if s == signature))
    // rust: {
    // rust: *entry = None;
}
}
    // Messages added since the last acknowledgement.
offset :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.offset
}
    // getAndClearOffset.
take_offset :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: std::mem::take(&mut self.offset)
}
    // generateAndApplyUpdate: the window from oldest to newest, each entry
    // acknowledged, with the offset since the last update and the checksum.
update :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let offset = self.take_offset();
    // rust: let mut acknowledged = [0u8; 3];
    // rust: let mut last_seen = Vec::with_capacity(LAST_SEEN);
    // rust: for i in 0..LAST_SEEN {
    // rust: let index = (self.tail + i) % LAST_SEEN;
    // rust: if let Some((signature, pending)) = &mut self.tracked[index] {
    // rust: acknowledged[i / 8] |= 1 << (i % 8);
    // rust: last_seen.push(*signature);
    // rust: *pending = false;
}
}
    // rust: let checksum = checksum(&last_seen);
    // rust: SeenUpdate {
    // rust: last_seen,
    // rust: update: LastSeenUpdate {
    // rust: offset,
    // rust: acknowledged,
    // rust: checksum,
    // rust: },
}
}
}

    // rust: mod tests {
//     use super::*;

sig :: proc(b: u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: [b; SIGNATURE_BYTES]
}

payload_layout_matches_update_signature :: proc() {
}
    // rust: let body = Body {
    // rust: content: "hé",
    // rust: timestamp: 1_700_000_123_456,
    // rust: salt: -2,
    // rust: last_seen: &[sig(7)],
}
    // rust: let p = signed_payload(1, 2, 3, &body);
    // rust: assert_eq!(&p[..4], &[0, 0, 0, 1]);
    // rust: assert_eq!(&p[4..20], &1u128.to_be_bytes());
    // rust: assert_eq!(&p[20..36], &2u128.to_be_bytes());
    // rust: assert_eq!(&p[36..40], &3i32.to_be_bytes());
    // rust: assert_eq!(&p[40..48], &(-2i64).to_be_bytes());
    // rust: assert_eq!(&p[48..56], &1_700_000_123i64.to_be_bytes());
    // rust: assert_eq!(&p[56..60], &3i32.to_be_bytes());
    // rust: assert_eq!(&p[60..63], "hé".as_bytes());
    // rust: assert_eq!(&p[63..67], &1i32.to_be_bytes());
    // rust: assert_eq!(p.len(), 67 + 256);
        // Instant.getEpochSecond floors.
    // rust: let before = Body {
    // rust: timestamp: -1,
    // rust: ..body
}
    // rust: assert_eq!(
    // rust: &signed_payload(1, 2, 3, &before)[48..56],
    // rust: &(-1i64).to_be_bytes()
    // rust: );
}

unsigned_chain_follows_enforcement :: proc() {
}
    // rust: let mut chain = Chain::default();
    // rust: let body = Body {
    // rust: content: "hi",
    // rust: timestamp: 5,
    // rust: salt: 0,
    // rust: last_seen: &[],
}
    // rust: assert_eq!(
    // rust: chain.unpack(1, None, &body, false, 0),
    // rust: Ok(Unpacked::Unsigned)
    // rust: );
    // rust: assert_eq!(
    // rust: chain.unpack(1, Some(&sig(1)), &body, false, 0),
    // rust: Ok(Unpacked::Unsigned)
    // rust: );
    // rust: assert_eq!(
    // rust: chain.unpack(1, None, &body, true, 0),
    // rust: Err(DecodeError::MissingProfileKey)
    // rust: );
}

checksums_follow_java_hash_codes :: proc() {
}
        // Arrays.hashCode(new byte[]{-1}) = 31 + (-1) = 30.
    // rust: assert_eq!(java_hash(&[0xff]), 30);
    // rust: assert_eq!(checksum(&[]), 1);
    // rust: let one = [sig(0)];
    // rust: let expected = 31i32.wrapping_add(java_hash(&sig(0))) as i8;
    // rust: assert_eq!(checksum(&one), if expected == 0 { 1 } else { expected });
}

last_seen_window :: proc() {
}
    // rust: let mut v = LastSeenValidator::default();
    // rust: assert_eq!(v.tracked_count(), 20);
    // rust: v.add_pending(&sig(1));
    // rust: v.add_pending(&sig(1));
    // rust: v.add_pending(&sig(2));
    // rust: assert_eq!(v.tracked_count(), 22);
    // rust: assert!(v.apply_offset(3).is_err());
        // Slide by two: the two messages are the window's last entries.
    // rust: let mut ack = [0u8; 3];
    // rust: ack[18 / 8] |= 1 << (18 % 8);
    // rust: ack[19 / 8] |= 1 << (19 % 8);
    // rust: let seen = v.apply_update(2, ack, checksum(&[sig(1), sig(2)])).unwrap();
    // rust: assert_eq!(seen, vec![sig(1), sig(2)]);
        // Once acknowledged, a message can't be ignored.
    // rust: assert!(v.apply_update(0, [0; 3], 0).is_err());
    // rust: let mut v = LastSeenValidator::default();
    // rust: v.add_pending(&sig(1));
    // rust: assert!(v.apply_update(1, [0, 0, 0x10], 0).is_err(), "bit 20");
    // rust: let mut v = LastSeenValidator::default();
    // rust: assert!(v.apply_update(0, [1, 0, 0], 0).is_err(), "unknown");
    // rust: let mut v = LastSeenValidator::default();
    // rust: v.add_pending(&sig(1));
    // rust: let mut ack = [0u8; 3];
    // rust: ack[2] |= 1 << 3;
    // rust: assert!(v.apply_update(1, ack, 99).is_err(), "checksum");
}

packed_signatures_resolve_against_the_cache :: proc() {
}
    // rust: let mut c = SignatureCache::default();
    // rust: assert_eq!(c.unpack(&(-1, Some(sig(4).to_vec()))), Some(sig(4)));
    // rust: assert_eq!(c.unpack(&(0, None)), None, "an empty slot");
    // rust: c.push(&[sig(1)], Some(&sig(2)));
    // rust: assert_eq!(c.unpack(&(0, None)), Some(sig(2)));
    // rust: assert_eq!(c.unpack(&(1, None)), Some(sig(1)));
    // rust: assert_eq!(c.unpack(&(2, None)), None);
    // rust: assert_eq!(c.unpack(&(128, None)), None, "past the cache");
        // What the server packs, the client unpacks to the same signature.
    // rust: assert_eq!(c.unpack(&c.pack(&sig(1))), Some(sig(1)));
}

cache_moves_recent_signatures_first :: proc() {
}
    // rust: let mut c = SignatureCache::default();
    // rust: assert_eq!(c.pack(&sig(1)), (-1, Some(sig(1).to_vec())));
    // rust: c.push(&[], Some(&sig(1)));
    // rust: assert_eq!(c.pack(&sig(1)), (0, None));
    // rust: c.push(&[sig(1)], Some(&sig(2)));
    // rust: assert_eq!(c.pack(&sig(2)), (0, None));
    // rust: assert_eq!(c.pack(&sig(1)), (1, None));
    // rust: c.push(&[], Some(&sig(3)));
    // rust: assert_eq!(
    // rust: [c.pack(&sig(3)).0, c.pack(&sig(2)).0, c.pack(&sig(1)).0],
    // rust: [0, 1, 2]
    // rust: );
}

//     use crate::rsa::tests::{CHAT_KEY_PKCS8, TEST_D, TEST_SPKI};

    // The services' key (the 1024-bit test key) signing a player's chat
    // key as the certificates endpoint's publicKeySignatureV2 does.
services :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = RsaPublicKey::from_der(&crate::rsa::tests::hex(TEST_SPKI))
    // rust: .unwrap()
    // rust: .modulus;
    // rust: let body = [
    // rust: crate::rsa::der_integer(&[0]),
    // rust: crate::rsa::der_integer(&n),
    // rust: crate::rsa::der_integer(&[1, 0, 1]),
    // rust: crate::rsa::der_integer(&crate::rsa::tests::hex(TEST_D)),
    // rust: ]
    // rust: .concat();
    // rust: RsaPrivateKey::from_der(&crate::rsa::der_element(0x30, &body)).unwrap()
}

session :: proc(player: ^RsaPrivateKey, profile: u128, id: u128) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let services = services();
    // rust: let mut key = ProfileKey {
    // rust: expires_at: 2_000_000_000_000,
    // rust: key: player.public_der(),
    // rust: signature: Vec::new(),
}
    // rust: key.signature = services
    // rust: .sign(SignatureHash::Sha1, &key.signed_payload(profile))
    // rust: .unwrap();
    // rust: ChatSession::validate(id, key, std::slice::from_ref(&services.public), profile).unwrap()
}

    // What the encoder signs, the server's decoder (Chain) accepts, link by
    // link, and refuses once a message is tampered with.
encoder_signs_what_the_chain_accepts :: proc() {
}
    // rust: let player = RsaPrivateKey::from_der(&crate::rsa::tests::hex(CHAT_KEY_PKCS8)).unwrap();
    // rust: let (profile, id) = (0x1234u128, 0x9876u128);
    // rust: let mut chain = Chain::keyed(session(&player, profile, id));
    // rust: let mut encoder = Encoder::new(profile, id);
    // rust: assert_eq!(encoder.session(), id);
    // rust: let seen = [sig(4)];
    // rust: for (i, text) in ["hello", "/msg-like text", "é"].iter().enumerate() {
    // rust: let body = Body {
    // rust: content: text,
    // rust: timestamp: 1_700_000_000_000 + i as i64,
    // rust: salt: 7 * i as i64,
    // rust: last_seen: &seen,
}
    // rust: let signature = encoder.sign(&player, &body).unwrap();
    // rust: assert_eq!(
    // rust: chain.unpack(profile, Some(&signature), &body, true, 0),
    // rust: Ok(Unpacked::Signed {
    // rust: index: i as i32,
    // rust: signature
    // rust: })
    // rust: );
}
    // rust: let body = Body {
    // rust: content: "original",
    // rust: timestamp: 1_700_000_001_000,
    // rust: salt: 1,
    // rust: last_seen: &[],
}
    // rust: let signature = encoder.sign(&player, &body).unwrap();
    // rust: let forged = Body {
    // rust: content: "forged",
    // rust: ..body
}
    // rust: assert_eq!(
    // rust: chain.unpack(profile, Some(&signature), &forged, true, 0),
    // rust: Err(DecodeError::InvalidSignature)
    // rust: );
        // Another sender's chain doesn't take the player's signatures.
    // rust: let mut other = Chain::keyed(session(&player, profile, id));
    // rust: let mut encoder = Encoder::new(profile + 1, id);
    // rust: let signature = encoder.sign(&player, &body).unwrap();
    // rust: assert_eq!(
    // rust: other.unpack(profile, Some(&signature), &body, true, 0),
    // rust: Err(DecodeError::InvalidSignature)
    // rust: );
        // A 1024-bit key can't make a MessageSignature: unsigned, not wrong.
    // rust: let small = services();
    // rust: assert_eq!(Encoder::new(profile, id).sign(&small, &body), None);
}

    // The client's tracker and the server's validator agree on every
    // update: the window, the offset and the checksum.
tracker_updates_satisfy_the_validator :: proc() {
}
    // rust: let mut tracker = LastSeenTracker::default();
    // rust: let mut validator = LastSeenValidator::default();
    // rust: let first = tracker.update();
    // rust: assert_eq!(first.last_seen, Vec::<Signature>::new());
    // rust: assert_eq!(first.update.offset, 0);
    // rust: assert_eq!(first.update.checksum, checksum(&[]));
    // rust: for round in 0..4u8 {
    // rust: for n in 0..(round * 9 + 1) {
    // rust: let s = sig(round * 40 + n + 1);
    // rust: validator.add_pending(&s);
    // rust: assert!(tracker.add_pending(&s, true));
    // rust: assert!(!tracker.add_pending(&s, true), "a repeat");
}
    // rust: let u = tracker.update();
    // rust: assert!(u.last_seen.len() <= LAST_SEEN);
    // rust: let seen = validator
    // rust: .apply_update(u.update.offset, u.update.acknowledged, u.update.checksum)
    // rust: .unwrap();
    // rust: assert_eq!(seen, u.last_seen);
    // rust: assert_eq!(tracker.offset(), 0);
}
        // The last 20, oldest first.
    // rust: let u = tracker.update();
    // rust: assert_eq!(u.last_seen.len(), LAST_SEEN);
    // rust: assert_eq!(u.last_seen.last(), Some(&sig(3 * 40 + 28)));
    // rust: assert_eq!(u.update.acknowledged, [0xff, 0xff, 0x0f]);
}

    // A hidden message and a deleted pending one leave a hole the
    // validator expects; a deleted message already acknowledged stays.
tracker_holes :: proc() {
}
    // rust: let mut tracker = LastSeenTracker::default();
    // rust: let mut validator = LastSeenValidator::default();
    // rust: for s in [sig(1), sig(2), sig(3)] {
    // rust: validator.add_pending(&s);
}
    // rust: tracker.add_pending(&sig(1), true);
    // rust: tracker.add_pending(&sig(2), false);
    // rust: tracker.add_pending(&sig(3), true);
    // rust: tracker.ignore_pending(&sig(3));
    // rust: assert_eq!(tracker.offset(), 3);
    // rust: let u = tracker.update();
    // rust: assert_eq!(u.last_seen, vec![sig(1)]);
    // rust: let seen = validator
    // rust: .apply_update(u.update.offset, u.update.acknowledged, u.update.checksum)
    // rust: .unwrap();
    // rust: assert_eq!(seen, vec![sig(1)]);
    // rust: tracker.ignore_pending(&sig(1));
    // rust: assert_eq!(tracker.update().last_seen, vec![sig(1)]);
    // rust: assert_eq!(tracker.take_offset(), 0);
}

    // A session with a 2048-bit test key, sender 1 and session 2; the signatures are
    // SHA256withRSA over `signed_payload`, made outside Rust with the key's private half.
test_session :: proc(expires_at: i64) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let spki = "30820122300d06092a864886f70d01010105000382010f003082010a0282010100dbe0bf1391ce3498fd40343c9f6d569c76f39c0cd6fca817a5d8102aed03ed5dbf4daedc097e786a85d21fa7aea19c23266a1b560916dd027700eae45cf54f072db2f0869c19ae26aa09d5fdf96bed9d9044c4e50b4dad1ee97d552e6d4c8d599771245f9afc5b34a470705baac58a0ba2d889ad89bf7f3d9a57cfb75b3938e7388b574176bd8b43a72806df5aec4a5471acb48a9d31d34de7468f0cca70c7598734693541936f098fc04290576deaa00929e56958d5d21bdb8db4df561960ca7402501a26471f327026d078ea6b8f8cea96f0d077c175d1bf9da6fe89908551ceed1737d9bfe6c633842b4a666450edb7ab279f506695f8d87df6ee13024fab0203010001";
    // rust: let der = hex(spki);
    // rust: ChatSession {
    // rust: id: 2,
    // rust: key: RsaPublicKey::from_der(&der).unwrap(),
    // rust: profile_key: ProfileKey {
    // rust: expires_at,
    // rust: key: der,
    // rust: signature: Vec::new(),
    // rust: },
}
}
hex :: proc(text: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..text.len())
    // rust: .step_by(2)
    // rust: .map(|i| u8::from_str_radix(&text[i..i + 2], 16).unwrap())
    // rust: .collect()
}
signature_of :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: hex(text).try_into().unwrap()
}
NOW :: 1_700_000_100_000
SIG_0 :: "620c7c55ef0184ebed11c2d0c6c8df7e6b75cd7a1f7f9e81b782cca33be8c23935a7a5bb2e01c924f205c1e0ab19357fc454c95b04b81bd636e588be227848ced911506554296e4a0219c7fa2d5852dd8b80d6aaa3a8b50d3ddb0afd14d5921148fdc0b866976ebeaeb97b075ba34882c3926cd50dabe4dba3c781ae0665044745db33df7228c37abab74049862235e021c227435de470ec1aa9023daddf5129afb7039ea482a97a0fdc8c817e9731143042e05da28be4a4362905c981c55256ceab07976a8f3590c1e7bd0bc17d2ce73a64cbe9be23ab3f9688eec4c8b90298dd087632d6c66e59f7acbda485dad2825a5f8e1f30d76ef9abc47af0a8d7b346"
SIG_1 :: "9ca9c9f0ba97e0a5cc56a63025c8d5935bddde07fd065a567bdaa5157b9bc2b435128913284c80e3d22aaa4c757e0c6be026868dbe84e8a377cd188e95f826ced5fbb8cb433d29a764cfeaf8b45eb50ebaeb7ce846dd35aa3f02de974f250fc2a98519e3a8d213f1c4387e677cde131cc3b8434625b1f364fd9269a4eeb89cddb85191e159a5cea41b839298360366a715f77746503c4e1c6109cb23d152637110324f0094b9b533c90db15cc1908b8f4b6b86b94d3c76cd3e35e384c1583d22c05dda56b7c76a9b427fcdd5d1061a58494e480499562710ad2bc711c4f1f3c9321dd20ed291cbbe4f9a96f757b6ec65a544d0bbb21d9f16944539306e00b348"
SIG_OLD :: "7acb0ede0ef535ae69c0f52abb73a91e133905c4d590d68dbb392a1c2205611868a55626e574b63af318ada5d9ad5cd7102968bf8c6b0bea98a1dc78929463ece8c035f1e2ab271aeb156a9a1711d6214b04e15186b2a8dca8f2476a5a4199716d2186acff705f45939f605e224d8274cc0d5d8f7986bb15dd38e530b4abdd7582b7e062c8cfc31e6f7c87ac1a2cd6fe84ab9e9b7a73972586f8834043c25eec1a1c8865f47183f7aeb808989d62850df3cca5e0aba3285cdfd507eb55aebc716a05297e84a6d26d8c7844a7e27e1b5d5c34a5c79ccaf1f6a0fb04bc1ddd1411a93819d9b1cb869ea24968ef15c09dc7229dcd867cb1d187352583c1707f40ec"

    // rust: fn incoming<'a>(
    // rust: signature: Option<&'a Signature>,
    // rust: index: i32,
    // rust: salt: i64,
    // rust: timestamp: i64,
    // rust: content: &'a str,
    // rust: filter: &'a (i32, Vec<i64>),
    // rust: ) -> Incoming<'a> {
    // rust: Incoming {
    // rust: sender: 1,
    // rust: index,
    // rust: signature,
    // rust: body: Body {
    // rust: content,
    // rust: timestamp,
    // rust: salt,
    // rust: last_seen: &[],
    // rust: },
    // rust: unsigned_content: None,
    // rust: filter,
}
}

    // `SignedMessageValidator.KeyBased`: a chain of signed messages in order passes, the same
    // message again passes, and a message out of order, with a bad signature, unsigned or from
    // an expired key ends the chain.
a_keyed_validator_follows_the_chain :: proc() {
}
    // rust: let filter = (0, Vec::new());
    // rust: let (s0, s1, old) = (
    // rust: signature_of(SIG_0),
    // rust: signature_of(SIG_1),
    // rust: signature_of(SIG_OLD),
    // rust: );
    // rust: let m0 = incoming(Some(&s0), 0, 7, 1_700_000_000_000, "hello", &filter);
    // rust: let m1 = incoming(Some(&s1), 1, 8, 1_700_000_001_000, "world", &filter);
    // rust: let mut v = MessageValidator::keyed(test_session(NOW));
    // rust: assert_eq!(v.update_and_validate(&m0, NOW), Some(Validated::Signed));
    // rust: assert_eq!(v.update_and_validate(&m1, NOW), Some(Validated::Signed));
        // The same message again is the last one: accepted.
    // rust: assert_eq!(v.update_and_validate(&m1, NOW), Some(Validated::Signed));
        // A valid signature at index 0 after index 1: not a descendant, and the chain is over.
    // rust: let again = incoming(Some(&old), 0, 9, 1_700_000_002_000, "again", &filter);
    // rust: assert_eq!(v.update_and_validate(&again, NOW), None);
    // rust: let mut v2 = MessageValidator::keyed(test_session(NOW));
    // rust: assert_eq!(v2.update_and_validate(&m0, NOW), Some(Validated::Signed));
    // rust: assert_eq!(v2.update_and_validate(&m1, NOW), Some(Validated::Signed));
    // rust: assert_eq!(v2.update_and_validate(&again, NOW), None);
    // rust: assert_eq!(
    // rust: v2.update_and_validate(&m1, NOW),
    // rust: None,
    // rust: "a broken chain accepts nothing more"
    // rust: );
}

a_keyed_validator_rejects_a_bad_signature_a_missing_one_and_an_expired_key :: proc() {
}
    // rust: let filter = (0, Vec::new());
    // rust: let s0 = signature_of(SIG_0);
        // The signature of "hello" is not the one of "hellO".
    // rust: let tampered = incoming(Some(&s0), 0, 7, 1_700_000_000_000, "hellO", &filter);
    // rust: let mut v = MessageValidator::keyed(test_session(NOW));
    // rust: assert_eq!(v.update_and_validate(&tampered, NOW), None);
    // rust: let unsigned = incoming(None, 0, 7, 1_700_000_000_000, "hello", &filter);
    // rust: let mut v = MessageValidator::keyed(test_session(NOW));
    // rust: assert_eq!(v.update_and_validate(&unsigned, NOW), None);
        // Past the key's expiry and the eight hours of grace.
    // rust: let good = incoming(Some(&s0), 0, 7, 1_700_000_000_000, "hello", &filter);
    // rust: let mut v = MessageValidator::keyed(test_session(NOW));
    // rust: assert_eq!(
    // rust: v.update_and_validate(&good, NOW + EXPIRY_GRACE_PERIOD),
    // rust: Some(Validated::Signed),
    // rust: "the grace period still validates"
    // rust: );
    // rust: let mut v = MessageValidator::keyed(test_session(NOW));
    // rust: assert_eq!(
    // rust: v.update_and_validate(&good, NOW + EXPIRY_GRACE_PERIOD + 1),
    // rust: None
    // rust: );
}

    // `PlayerInfo.fallbackMessageValidator`: with no chat session a message is shown unsigned,
    // or refused when the server enforces secure chat.
the_fallback_validator_accepts_unsigned_or_rejects_all :: proc() {
}
    // rust: let filter = (0, Vec::new());
    // rust: let s0 = signature_of(SIG_0);
    // rust: let m0 = incoming(Some(&s0), 0, 7, 1_700_000_000_000, "hello", &filter);
    // rust: assert_eq!(
    // rust: MessageValidator::fallback(false).update_and_validate(&m0, NOW),
    // rust: Some(Validated::Unsigned)
    // rust: );
    // rust: assert_eq!(
    // rust: MessageValidator::fallback(true).update_and_validate(&m0, NOW),
    // rust: None
    // rust: );
}
}
