//! Transpiled from Horizon Rust crate
package horizon_protocol_adapter

import "core:fmt"
import "core:mem"
import "core:math"

// Speaking to servers of an older release: the first layer of the native protocol adapter (roadmap
// `older-servers`). Horizon's packets are 26.3's; a server on another protocol numbers them differently.
// This maps packet ids per connection state, both ways; a [`Session`] follows one connection's states
// and renumbers what goes through it. [`ids`] renumbers the registry ids inside packets as the shared
// readers decode them, and `translate` rewrites the packets whose layout changed. An older version is
// translated a release at a time (26.1 to 26.2, then 26.2 to 26.3), with its ids mapped straight to the
// pinned ones. A Horizon server runs the ids the other way for a client of an older release
// ([`ClientSession`], roadmap `older-clients`), when its owner lets such clients join.
    // rust: pub mod client_session;
    // rust: pub mod ids;
    // rust: pub mod session;
    // rust: mod translate;
    // rust: pub mod v1_21_10;
    // rust: mod v1_21_10_ids;
    // rust: pub mod v1_21_11;
    // rust: mod v1_21_11_ids;
    // rust: pub mod v26_1_2;
    // rust: mod v26_1_2_ids;
    // rust: pub mod v26_2;
    // rust: mod v26_2_ids;

    // rust: pub use client_session::ClientSession;
    // rust: pub use session::Session;

// use crate::{
    // rust: Direction, Result, State,
    // rust: buf::{Reader, write_varint},
}

// The protocol a server speaks.
ServerVersion :: enum {
    // The pinned version ([`crate::PROTOCOL_VERSION`]): nothing to translate.
    Current,
    V26_2,
    // 26.1, 26.1.1 and 26.1.2: one protocol.
    V26_1,
    V1_21_11,
    // 1.21.9 and 1.21.10: one protocol.
    V1_21_10,
}

    // rust: impl ServerVersion {
    // Newest first.
    // rust: pub const ALL: [Self; 5] = [
    // rust: Self::Current,
    // rust: Self::V26_2,
    // rust: Self::V26_1,
    // rust: Self::V1_21_11,
    // rust: Self::V1_21_10,
    // rust: ];

    // Whether this is `other` or an older release: the translation steps from `other` up apply.
at_most :: proc(self: ^Self, other: Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let age = |v: Self| Self::ALL.iter().position(|&a| a == v).unwrap_or(0);
    // rust: age(self) >= age(other)
}

    // The protocol number its handshake states.
protocol :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Current => crate::PROTOCOL_VERSION,
    // rust: Self::V26_2 => v26_2::PROTOCOL,
    // rust: Self::V26_1 => v26_1_2::PROTOCOL,
    // rust: Self::V1_21_11 => v1_21_11::PROTOCOL,
    // rust: Self::V1_21_10 => v1_21_10::PROTOCOL,
}
}

    // The release name, as a server list shows it.
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Current => crate::GAME_VERSION,
    // rust: Self::V26_2 => v26_2::NAME,
    // rust: Self::V26_1 => "26.1",
    // rust: Self::V1_21_11 => v1_21_11::NAME,
    // rust: Self::V1_21_10 => "1.21.10",
}
}

    // The version a server's status reports by its protocol number.
from_protocol :: proc(protocol: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL.into_iter().find(|v| v.protocol() == protocol)
}

    // The pinned version's id for a packet this version's server sent as `id`. `None` when the pinned
    // version has no such packet.
clientbound_id :: proc(self: ^Self, state: State, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.map(state, Direction::Clientbound, id)
}

    // The id this version's server knows a packet Horizon sends as `id` by. `None` when that server has
    // no such packet, so it must not be sent.
serverbound_id :: proc(self: ^Self, state: State, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.map(state, Direction::Serverbound, id)
}

    // How this version numbers block states and registries, against the pinned one. `None` for the pinned
    // version itself.
ids :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
        // Before 26.3 a tag slot display was a bare tag id, and pot decorations were item ids.
    // rust: const BEFORE_26_3: ids::Quirks = ids::Quirks {
    // rust: tag_slot_display_is_id: true,
    // rust: pot_decorations_are_items: true,
    // rust: either_holder_song_and_tag_resistance: false,
    // rust: stacks_in_components: false,
}
        // Before 26.1 a jukebox song was an EitherHolder, damage resistance a tag, and the items components
        // hold ItemStacks.
    // rust: const BEFORE_26_1: ids::Quirks = ids::Quirks {
    // rust: either_holder_song_and_tag_resistance: true,
    // rust: stacks_in_components: true,
    // rust: ..BEFORE_26_3
}
    // rust: static V26_2: ids::Ids = ids::Ids {
    // rust: quirks: BEFORE_26_3,
    // rust: ..v26_2_ids::IDS
}
    // rust: static V26_1: ids::Ids = ids::Ids {
    // rust: quirks: BEFORE_26_3,
    // rust: ..v26_1_2_ids::IDS
}
    // rust: static V1_21_11: ids::Ids = ids::Ids {
    // rust: quirks: BEFORE_26_1,
            // 26.1 registered the cat, cow, pig and chicken sound variants among the others.
    // rust: entity_data_serializer: ids::Remap::Runs {
    // rust: up: &[
    // rust: (0, 0, 22),
    // rust: (22, 23, 1),
    // rust: (23, 25, 4),
    // rust: (27, 30, 1),
    // rust: (28, 32, 11),
    // rust: ],
    // rust: down: &[
    // rust: (0, 0, 22),
    // rust: (23, 22, 1),
    // rust: (25, 23, 4),
    // rust: (30, 27, 1),
    // rust: (32, 28, 11),
    // rust: ],
    // rust: },
    // rust: ..v1_21_11_ids::IDS
}
    // rust: static V1_21_10: ids::Ids = ids::Ids {
    // rust: quirks: BEFORE_26_1,
            // As 1.21.11's, without the zombie nautilus variant 1.21.11 added after the chicken's.
    // rust: entity_data_serializer: ids::Remap::Runs {
    // rust: up: &[
    // rust: (0, 0, 22),
    // rust: (22, 23, 1),
    // rust: (23, 25, 4),
    // rust: (27, 30, 1),
    // rust: (28, 33, 9),
    // rust: ],
    // rust: down: &[
    // rust: (0, 0, 22),
    // rust: (23, 22, 1),
    // rust: (25, 23, 4),
    // rust: (30, 27, 1),
    // rust: (33, 28, 9),
    // rust: ],
    // rust: },
    // rust: ..v1_21_10_ids::IDS
}
    // rust: match self {
    // rust: Self::Current => None,
    // rust: Self::V26_2 => Some(&V26_2),
    // rust: Self::V26_1 => Some(&V26_1),
    // rust: Self::V1_21_11 => Some(&V1_21_11),
    // rust: Self::V1_21_10 => Some(&V1_21_10),
}
}

    // The id a client of this version knows a packet a Horizon server sends as `id` by: the inverse of
    // [`Self::clientbound_id`]. `None` when that client has no such packet, so it must not be sent.
clientbound_id_down :: proc(self: ^Self, state: State, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.inverse(state, Direction::Clientbound, id)
}

    // The pinned version's id for a packet a client of this version sent as `id`: the inverse of
    // [`Self::serverbound_id`]. `None` when the pinned version has no such packet.
serverbound_id_up :: proc(self: ^Self, state: State, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.inverse(state, Direction::Serverbound, id)
}

inverse :: proc(self: ^Self, state: State, direction: Direction, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self == Self::Current {
    // rust: return Some(id);
}
    // rust: let at = self
    // rust: .table(state, direction)
    // rust: .iter()
    // rust: .position(|&m| m.map(i32::from) == Some(id))?;
    // rust: i32::try_from(at).ok()
}

map :: proc(self: ^Self, state: State, direction: Direction, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self == Self::Current {
    // rust: return Some(id);
}
    // rust: let mapped = *self
    // rust: .table(state, direction)
    // rust: .get(usize::try_from(id).ok()?)?;
    // rust: mapped.map(i32::from)
}

table :: proc(self: ^Self, state: State, direction: Direction) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match (self, direction) {
    // rust: (Self::Current, _) => &[],
    // rust: (Self::V26_2, Direction::Clientbound) => v26_2::clientbound(state),
    // rust: (Self::V26_2, Direction::Serverbound) => v26_2::serverbound(state),
    // rust: (Self::V26_1, Direction::Clientbound) => v26_1_2::clientbound(state),
    // rust: (Self::V26_1, Direction::Serverbound) => v26_1_2::serverbound(state),
    // rust: (Self::V1_21_11, Direction::Clientbound) => v1_21_11::clientbound(state),
    // rust: (Self::V1_21_11, Direction::Serverbound) => v1_21_11::serverbound(state),
    // rust: (Self::V1_21_10, Direction::Clientbound) => v1_21_10::clientbound(state),
    // rust: (Self::V1_21_10, Direction::Serverbound) => v1_21_10::serverbound(state),
}
}

    // A packet body (VarInt id + payload) Horizon sends, renumbered for this version's server. `None`
    // when that server has no such packet.
serverbound_body :: proc(self: ^Self, state: State, body: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Reader::new(body);
    // rust: let id = r.varint()?;
    // rust: let payload = r.rest();
    // rust: let Some(mapped) = self.serverbound_id(state, id) else {
    // rust: return Ok(None);
}
    // rust: if mapped == id {
    // rust: return Ok(Some(body.to_vec()));
}
    // rust: let mut out = Vec::with_capacity(body.len() + 1);
    // rust: write_varint(&mut out, mapped);
    // rust: out.extend_from_slice(payload);
    // rust: Ok(Some(out))
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::ids;

    // Expected ids below are read off the 26.2 and 26.3 packets reports by hand
    // (`version_port.py diff 26.2 26.3`), not from the generated tables.

a_26_2_server_is_known_by_its_protocol :: proc() {
}
    // rust: assert_eq!(
    // rust: ServerVersion::from_protocol(776),
    // rust: Some(ServerVersion::V26_2)
    // rust: );
    // rust: assert_eq!(
    // rust: ServerVersion::from_protocol(crate::PROTOCOL_VERSION),
    // rust: Some(ServerVersion::Current)
    // rust: );
    // rust: assert_eq!(
    // rust: ServerVersion::from_protocol(775),
    // rust: Some(ServerVersion::V26_1)
    // rust: );
    // rust: assert_eq!(
    // rust: ServerVersion::from_protocol(774),
    // rust: Some(ServerVersion::V1_21_11)
    // rust: );
    // rust: assert_eq!(
    // rust: ServerVersion::from_protocol(773),
    // rust: Some(ServerVersion::V1_21_10)
    // rust: );
    // rust: assert_eq!(ServerVersion::from_protocol(772), None);
    // rust: assert!(ServerVersion::V26_1.at_most(ServerVersion::V26_2));
    // rust: assert!(!ServerVersion::V26_2.at_most(ServerVersion::V26_1));
}

renumbered_clientbound_play_packets_reach_their_26_3_ids :: proc() {
}
    // rust: let v = ServerVersion::V26_2;
        // keep_alive 44 -> 45, login 49 -> 50, respawn 82 -> 84, clear_dialog 139 -> 142.
    // rust: assert_eq!(
    // rust: v.clientbound_id(State::Play, 44),
    // rust: Some(ids::play::clientbound::KEEP_ALIVE)
    // rust: );
    // rust: assert_eq!(
    // rust: v.clientbound_id(State::Play, 49),
    // rust: Some(ids::play::clientbound::LOGIN)
    // rust: );
    // rust: assert_eq!(
    // rust: v.clientbound_id(State::Play, 82),
    // rust: Some(ids::play::clientbound::RESPAWN)
    // rust: );
    // rust: assert_eq!(
    // rust: v.clientbound_id(State::Play, 139),
    // rust: Some(ids::play::clientbound::CLEAR_DIALOG)
    // rust: );
        // Unchanged before the first insertion (add_transient_block at 37).
    // rust: assert_eq!(v.clientbound_id(State::Play, 0), Some(0));
        // Past 26.2's 141 packets.
    // rust: assert_eq!(v.clientbound_id(State::Play, 141), None);
        // Configuration: store_cookie 10 -> 11 (post_effects took 10).
    // rust: assert_eq!(
    // rust: v.clientbound_id(State::Configuration, 10),
    // rust: Some(ids::configuration::clientbound::STORE_COOKIE)
    // rust: );
}

serverbound_packets_26_2_lacks_are_not_sent :: proc() {
}
    // rust: let v = ServerVersion::V26_2;
        // punch is new in 26.3; swing, which 26.2 has at 63, is gone.
    // rust: assert_eq!(
    // rust: v.serverbound_id(State::Play, ids::play::serverbound::PUNCH),
    // rust: None
    // rust: );
        // resource_pack 50 -> 49, spectator_action 63 -> 62, keep_alive unchanged.
    // rust: assert_eq!(
    // rust: v.serverbound_id(State::Play, ids::play::serverbound::RESOURCE_PACK),
    // rust: Some(49)
    // rust: );
    // rust: assert_eq!(
    // rust: v.serverbound_id(State::Play, ids::play::serverbound::SPECTATOR_ACTION),
    // rust: Some(62)
    // rust: );
    // rust: assert_eq!(
    // rust: v.serverbound_id(State::Play, ids::play::serverbound::KEEP_ALIVE),
    // rust: Some(ids::play::serverbound::KEEP_ALIVE)
    // rust: );
    // rust: assert_eq!(
    // rust: v.serverbound_id(State::Handshake, ids::handshake::serverbound::INTENTION),
    // rust: Some(0)
    // rust: );
}

serverbound_bodies_keep_their_payload_under_the_new_id :: proc() {
}
    // rust: let v = ServerVersion::V26_2;
    // rust: let mut body = Vec::new();
    // rust: write_varint(&mut body, ids::play::serverbound::RESOURCE_PACK);
    // rust: body.extend_from_slice(&[1, 2, 3]);
    // rust: assert_eq!(
    // rust: v.serverbound_body(State::Play, &body).unwrap(),
    // rust: Some(vec![49, 1, 2, 3])
    // rust: );
    // rust: let mut punch = Vec::new();
    // rust: write_varint(&mut punch, ids::play::serverbound::PUNCH);
    // rust: assert_eq!(v.serverbound_body(State::Play, &punch).unwrap(), None);
    // rust: assert_eq!(
    // rust: ServerVersion::Current
    // rust: .serverbound_body(State::Play, &body)
    // rust: .unwrap(),
    // rust: Some(body)
    // rust: );
}
}
