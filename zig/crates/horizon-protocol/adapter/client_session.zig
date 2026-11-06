//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_client_session
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! One connection from a client of an older release to a Horizon server: [`super::Session`] run the other
//! way (roadmap `older-clients`). What the client sends is renumbered to the pinned ids before the server
//! reads it; what the server sends is renumbered to the client's.
//!
//! This layer maps packet ids only: the registry ids inside packets, and the packets whose layout changed
//! between the client's release and the pinned one, are later steps.
//!
//! The states change where vanilla's server-side `Connection` switches its codecs, after the handshake the
//! server read itself: `login_acknowledged` and `login_finished` move each direction to configuration,
//! `finish_configuration` to play, and `configuration_acknowledged` / `start_configuration` back.
// use std::sync::atomic::{AtomicU8, Ordering};

// use super::ServerVersion;
// use crate::{
    // rust: Result, State,
    // rust: buf::{Reader, Writer},
    // rust: ids as packet_ids,
}

pub fn to_u8(state: State) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match state {
    // rust: State::Handshake => 0,
    // rust: State::Status => 1,
    // rust: State::Login => 2,
    // rust: State::Configuration => 3,
    // rust: State::Play => 4,
}
}
pub fn from_u8(v: u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: 1 => State::Status,
    // rust: 2 => State::Login,
    // rust: 3 => State::Configuration,
    // rust: 4 => State::Play,
    // rust: _ => State::Handshake,
}
}

/// Shared by a connection's reader and writer.
pub const ClientSession = struct {
    version: ServerVersion,
    /// What the client sends.
    reading: AtomicU8,
    /// What the server sends.
    writing: AtomicU8,
};

    // rust: impl ClientSession {
    /// A client whose login handshake stated `version`'s protocol: both directions are in login.
pub fn new(version: ServerVersion) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: version,
    // rust: reading: AtomicU8::new(to_u8(State::Login)),
    // rust: writing: AtomicU8::new(to_u8(State::Login)),
}
}
pub fn reading(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: from_u8(self.reading.load(Ordering::Acquire))
}
pub fn writing(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: from_u8(self.writing.load(Ordering::Acquire))
}

    /// A packet the client sent, with the id the pinned version knows it by. `None` drops it: the pinned
    /// version has no such packet (26.2's `swing`).
pub fn serverbound(self: *Self, id: i32, payload: std.ArrayList(u8)) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.reading();
    // rust: let Some(pinned) = self.version.serverbound_id_up(state, id) else {
    // rust: return Ok(None);
}
//         use packet_ids::{configuration::serverbound as cfg, login::serverbound as login};
    // rust: let next = match (state, pinned) {
    // rust: (State::Login, login::LOGIN_ACKNOWLEDGED) => State::Configuration,
    // rust: (State::Configuration, cfg::FINISH_CONFIGURATION) => State::Play,
    // rust: (State::Play, packet_ids::play::serverbound::CONFIGURATION_ACKNOWLEDGED) => {
    // rust: State::Configuration
}
    // rust: _ => state,
}
    // rust: self.reading.store(to_u8(next), Ordering::Release);
    // rust: Ok(Some((pinned, payload)))
}

    /// A packet body (VarInt id + payload) the server sends, as the client numbers it. `None`: the client
    /// has no such packet, so nothing is sent.
pub fn clientbound(self: *Self, body: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.writing();
    // rust: let mut r = Reader::new(body);
    // rust: let id = r.varint()?;
    // rust: let payload = r.rest();
//         use packet_ids::{configuration::clientbound as cfg, login::clientbound as login};
    // rust: let next = match (state, id) {
    // rust: (State::Login, login::LOGIN_FINISHED) => State::Configuration,
    // rust: (State::Configuration, cfg::FINISH_CONFIGURATION) => State::Play,
    // rust: (State::Play, packet_ids::play::clientbound::START_CONFIGURATION) => {
    // rust: State::Configuration
}
    // rust: _ => state,
}
    // rust: self.writing.store(to_u8(next), Ordering::Release);
    // rust: let Some(mapped) = self.version.clientbound_id_down(state, id) else {
    // rust: return Ok(None);
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(mapped);
    // rust: w.bytes(payload);
    // rust: Ok(Some(w.data))
}
}

    // rust: mod tests {
//     use super::*;

pub fn body(id: i32, payload: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(id);
    // rust: w.bytes(payload);
    // rust: w.data
}

pub fn in_play() C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = ClientSession::new(ServerVersion::V26_2);
    // rust: s.reading.store(to_u8(State::Play), Ordering::Release);
    // rust: s.writing.store(to_u8(State::Play), Ordering::Release);
    // rust: s
}

    // Expected ids are read off the 26.2 and 26.3 packets reports by hand, not from the generated tables.

pub fn each_direction_follows_its_own_switches() void {
}
    // rust: let s = ClientSession::new(ServerVersion::V26_2);
    // rust: assert_eq!((s.reading(), s.writing()), (State::Login, State::Login));
        // The server finishes the login: it speaks configuration, the client still login.
    // rust: s.clientbound(&body(packet_ids::login::clientbound::LOGIN_FINISHED, &[]))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: (s.reading(), s.writing()),
    // rust: (State::Login, State::Configuration)
    // rust: );
    // rust: s.serverbound(
    // rust: packet_ids::login::serverbound::LOGIN_ACKNOWLEDGED,
    // rust: Vec::new(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(s.reading(), State::Configuration);
        // finish_configuration is 3 both ways in 26.2 as in 26.3.
    // rust: s.clientbound(&body(3, &[])).unwrap();
    // rust: s.serverbound(3, Vec::new()).unwrap();
    // rust: assert_eq!((s.reading(), s.writing()), (State::Play, State::Play));
}

pub fn packets_are_renumbered_both_ways_and_unknown_ones_dropped() void {
}
    // rust: let s = in_play();
        // keep_alive: 26.3's clientbound 45 is 26.2's 44; serverbound 28 in both.
    // rust: let sent = s
    // rust: .clientbound(&body(packet_ids::play::clientbound::KEEP_ALIVE, &[0; 8]))
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(sent[0], 44);
    // rust: assert_eq!(
    // rust: s.serverbound(28, vec![0; 8]).unwrap(),
    // rust: Some((packet_ids::play::serverbound::KEEP_ALIVE, vec![0; 8]))
    // rust: );
        // add_transient_block (37) is new in 26.3: not sent.
    // rust: let transient = packet_ids::play::clientbound::ADD_TRANSIENT_BLOCK;
    // rust: assert_eq!(s.clientbound(&body(transient, &[0; 9])).unwrap(), None);
        // 26.2's resource_pack (49) is 26.3's 50; its swing (63) has no pinned packet.
    // rust: assert_eq!(
    // rust: s.serverbound(49, vec![7]).unwrap(),
    // rust: Some((packet_ids::play::serverbound::RESOURCE_PACK, vec![7]))
    // rust: );
    // rust: assert_eq!(s.serverbound(63, vec![0]).unwrap(), None);
}
}
