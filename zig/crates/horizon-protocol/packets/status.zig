//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_status
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Status state: server list ping.
// use crate::{
    // rust: buf::{Long, Str},
    // rust: packet, packet_enum,
    // rust: packets::Empty,
}

    // rust: packet!(StatusResponse { json: String => Str });
    // rust: packet!(Ping { time: i64 => Long });

    // rust: packet_enum!(Clientbound, crate::ids::status::clientbound {
    // rust: StatusResponse(StatusResponse) = STATUS_RESPONSE,
    // rust: PongResponse(Ping) = PONG_RESPONSE,
    // rust: });
    // rust: packet_enum!(Serverbound, crate::ids::status::serverbound {
    // rust: StatusRequest(Empty) = STATUS_REQUEST,
    // rust: PingRequest(Ping) = PING_REQUEST,
    // rust: });

    // rust: mod tests {
//     use super::*;
//     use crate::packets::round_trip;

pub fn status_round_trips() void {
}
    // rust: round_trip(
    // rust: Clientbound::StatusResponse(StatusResponse {
    // rust: json: "{\"version\":{}}".into(),
    // rust: }),
    // rust: Clientbound::encode,
    // rust: Clientbound::decode,
    // rust: );
    // rust: round_trip(
    // rust: Clientbound::PongResponse(Ping { time: 123 }),
    // rust: Clientbound::encode,
    // rust: Clientbound::decode,
    // rust: );
    // rust: round_trip(
    // rust: Serverbound::StatusRequest(Empty),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
    // rust: round_trip(
    // rust: Serverbound::PingRequest(Ping { time: -5 }),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
}
}
