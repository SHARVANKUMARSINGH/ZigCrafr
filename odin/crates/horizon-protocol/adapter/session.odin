//! Transpiled from Horizon Rust crate
package horizon_protocol_session

import "core:fmt"
import "core:mem"
import "core:math"

// One connection to a server of an older release: which state each direction is in, followed from the
// packets themselves, and every packet renumbered and translated on its way through.
//
// The states change where vanilla's `Connection` switches its codecs: the handshake's intent picks status
// or login for both directions, `login_finished` and `login_acknowledged` move each direction to
// configuration, `finish_configuration` to play, and `start_configuration` / `configuration_acknowledged`
// back to configuration.
// use std::{
    // rust: collections::{HashMap, VecDeque},
    // rust: sync::{
    // rust: Mutex,
    // rust: atomic::{AtomicU8, Ordering},
    // rust: },
}

// use super::{ServerVersion, translate};
// use crate::{
    // rust: Result, State,
    // rust: buf::{Reader, Writer},
    // rust: ids,
    // rust: packets::handshake,
}

to_u8 :: proc(state: State) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match state {
    // rust: State::Handshake => 0,
    // rust: State::Status => 1,
    // rust: State::Login => 2,
    // rust: State::Configuration => 3,
    // rust: State::Play => 4,
}
}
from_u8 :: proc(v: u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: 1 => State::Status,
    // rust: 2 => State::Login,
    // rust: 3 => State::Configuration,
    // rust: 4 => State::Play,
    // rust: _ => State::Handshake,
}
}

// Shared by a connection's reader and writer.
Session :: struct {
    version: ServerVersion,
    reading: AtomicU8,
    writing: AtomicU8,
    // Entity UUIDs by network id, for a server that is told which entity a spectator picked by its UUID.
    // rust: pub(super) uuids: Mutex<HashMap<i32, u128>>,
    // Entity types (pinned ids) by network id, for entity data laid out by type.
    // rust: pub(super) kinds: Mutex<HashMap<i32, i32>>,
    // Packets the translation made, for Horizon to read before the next one from the server
    // (pinned id, payload).
    // rust: pub(super) incoming: Mutex<VecDeque<(i32, Vec<u8>)>>,
    // Packet bodies to send right after the one being sent.
    // rust: pub(super) outgoing: Mutex<Vec<Vec<u8>>>,
}

    // rust: impl Session {
new :: proc(version: ServerVersion) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: version,
    // rust: reading: AtomicU8::new(0),
    // rust: writing: AtomicU8::new(0),
    // rust: uuids: Mutex::new(HashMap::new()),
    // rust: kinds: Mutex::new(HashMap::new()),
    // rust: incoming: Mutex::new(VecDeque::new()),
    // rust: outgoing: Mutex::new(Vec::new()),
}
}
reading :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: from_u8(self.reading.load(Ordering::Acquire))
}
writing :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: from_u8(self.writing.load(Ordering::Acquire))
}
set_reading :: proc(self: ^Self, state: State) {
}
    // rust: self.reading.store(to_u8(state), Ordering::Release);
}
set_writing :: proc(self: ^Self, state: State) {
}
    // rust: self.writing.store(to_u8(state), Ordering::Release);
}

    // A packet the server sent, as the pinned version numbers and lays it out. `None` drops it: Horizon
    // knows no such packet.
clientbound :: proc(self: ^Self, id: i32, payload: [dynamic]u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.reading();
    // rust: let Some(pinned) = self.version.clientbound_id(state, id) else {
    // rust: return Ok(None);
}
    // rust: match (state, pinned) {
    // rust: (State::Login, ids::login::clientbound::LOGIN_FINISHED) => {
    // rust: self.set_reading(State::Configuration)
}
    // rust: (State::Configuration, ids::configuration::clientbound::FINISH_CONFIGURATION) => {
    // rust: self.set_reading(State::Play)
}
    // rust: (State::Play, ids::play::clientbound::START_CONFIGURATION) => {
    // rust: self.set_reading(State::Configuration)
}
    // rust: _ => {}
}
        // A packet the translation can't read goes on as it came, as an unknown packet would: Horizon's
        // own reader then skips it or reports it, rather than the connection dropping here.
    // rust: match translate::clientbound(self, state, pinned, &payload) {
    // rust: Ok(Some((id, Some(translated)))) => Ok(Some((id, translated))),
    // rust: Ok(Some((id, None))) => Ok(Some((id, payload))),
    // rust: Ok(None) => Ok(None),
    // rust: Err(e) => {
    // rust: log::warn!(
    // rust: "Horizon: could not translate {} packet {pinned} ({state:?}): {e}",
    // rust: self.version.name()
    // rust: );
    // rust: Ok(Some((pinned, payload)))
}
}
}

    // A packet body (VarInt id + payload) Horizon sends, as this server numbers and lays it out. `None`:
    // the server has no such packet, so nothing is sent.
serverbound :: proc(self: ^Self, body: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.writing();
    // rust: let mut r = Reader::new(body);
    // rust: let id = r.varint()?;
    // rust: let payload = r.rest();
    // rust: match (state, id) {
    // rust: (State::Handshake, ids::handshake::serverbound::INTENTION) => {
    // rust: return self.intention(payload).map(Some);
}
    // rust: (State::Login, ids::login::serverbound::LOGIN_ACKNOWLEDGED) => {
    // rust: self.set_writing(State::Configuration)
}
    // rust: (State::Configuration, ids::configuration::serverbound::FINISH_CONFIGURATION) => {
    // rust: self.set_writing(State::Play)
}
    // rust: (State::Play, ids::play::serverbound::CONFIGURATION_ACKNOWLEDGED) => {
    // rust: self.set_writing(State::Configuration)
}
    // rust: _ => {}
}
    // rust: let Some((mapped, payload)) = translate::serverbound(self, state, id, payload)? else {
    // rust: return Ok(None);
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(mapped);
    // rust: w.bytes(&payload);
    // rust: Ok(Some(w.data))
}

    // A packet the translation made that Horizon reads next, already in the pinned version's numbering.
next_incoming :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.incoming.lock().unwrap().pop_front()
}
    // Bodies the translation added after the packet just sent, in the server's numbering.
take_outgoing :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: std::mem::take(&mut *self.outgoing.lock().unwrap())
}

    // The handshake states this server's protocol, and its intent moves both directions on.
intention :: proc(self: ^Self, payload: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Reader::new(payload);
    // rust: let _pinned = r.varint()?;
    // rust: let host = r.string(255)?;
    // rust: let port = r.u16()?;
    // rust: let intent = r.varint()?;
    // rust: let next = if intent == handshake::STATUS {
    // rust: State::Status
    // rust: } else {
    // rust: State::Login
}
    // rust: self.set_writing(next);
    // rust: self.set_reading(next);
    // rust: let mut w = Writer::new();
    // rust: w.varint(ids::handshake::serverbound::INTENTION);
    // rust: w.varint(self.version.protocol());
    // rust: w.string(&host);
    // rust: w.u16(port);
    // rust: w.varint(intent);
    // rust: Ok(w.data)
}
}

    // rust: mod tests {
//     use super::*;

body :: proc(id: i32, payload: []u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(id);
    // rust: w.bytes(payload);
    // rust: w.data
}

the_handshake_states_the_older_protocol_and_moves_both_directions :: proc() {
}
    // rust: let s = Session::new(ServerVersion::V26_2);
    // rust: let mut payload = Writer::new();
    // rust: payload.varint(crate::PROTOCOL_VERSION);
    // rust: payload.string("example.org");
    // rust: payload.u16(25565);
    // rust: payload.varint(handshake::LOGIN);
    // rust: let sent = s.serverbound(&body(0, &payload.data)).unwrap().unwrap();
    // rust: let mut r = Reader::new(&sent);
    // rust: assert_eq!(r.varint().unwrap(), 0);
    // rust: assert_eq!(r.varint().unwrap(), 776);
    // rust: assert_eq!(r.string(255).unwrap(), "example.org");
    // rust: assert_eq!((s.reading(), s.writing()), (State::Login, State::Login));
}

each_direction_follows_its_own_switches :: proc() {
}
    // rust: let s = Session::new(ServerVersion::V26_2);
    // rust: s.set_reading(State::Login);
    // rust: s.set_writing(State::Login);
        // login_finished arrives: the server already speaks configuration, Horizon still login.
    // rust: s.clientbound(ids::login::clientbound::LOGIN_FINISHED, Vec::new())
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: (s.reading(), s.writing()),
    // rust: (State::Configuration, State::Login)
    // rust: );
    // rust: s.serverbound(&body(ids::login::serverbound::LOGIN_ACKNOWLEDGED, &[]))
    // rust: .unwrap();
    // rust: assert_eq!(s.writing(), State::Configuration);
        // finish_configuration: 26.2 numbers it 3 as 26.3 does.
    // rust: s.clientbound(3, Vec::new()).unwrap();
    // rust: assert_eq!(s.reading(), State::Play);
    // rust: s.serverbound(&body(
    // rust: ids::configuration::serverbound::FINISH_CONFIGURATION,
    // rust: &[],
    // rust: ))
    // rust: .unwrap();
    // rust: assert_eq!(s.writing(), State::Play);
}

packets_are_renumbered_and_unknown_ones_dropped :: proc() {
}
    // rust: let s = Session::new(ServerVersion::V26_2);
    // rust: s.set_reading(State::Play);
    // rust: s.set_writing(State::Play);
        // 26.2's keep_alive is 44, 26.3's 45.
    // rust: let (id, payload) = s.clientbound(44, vec![0; 8]).unwrap().unwrap();
    // rust: assert_eq!((id, payload.len()), (ids::play::clientbound::KEEP_ALIVE, 8));
    // rust: assert_eq!(s.clientbound(141, Vec::new()).unwrap(), None);
        // resource_pack: Horizon's 50 is 26.2's 49.
    // rust: let sent = s
    // rust: .serverbound(&body(ids::play::serverbound::RESOURCE_PACK, &[7]))
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(sent, vec![49, 7]);
}
}
