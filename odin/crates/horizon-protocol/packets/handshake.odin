//! Transpiled from Horizon Rust crate
package horizon_protocol_handshake

import "core:fmt"
import "core:mem"
import "core:math"

// Handshake state: ClientIntentionPacket.
// use crate::{
    // rust: buf::{StrN, UShort, VarInt},
    // rust: packet, packet_enum,
}

// ClientIntent ids.
STATUS :: 1
LOGIN :: 2
TRANSFER :: 3

    // rust: packet!(Intention {
    // rust: protocol: i32 => VarInt,
    // rust: host: String => StrN<255>,
    // rust: port: u16 => UShort,
    // rust: intent: i32 => VarInt,
    // rust: });

    // rust: packet_enum!(Serverbound, crate::ids::handshake::serverbound { Intention(Intention) = INTENTION });

    // rust: mod tests {
//     use super::*;

intention_bytes :: proc() {
}
    // rust: let p = Serverbound::Intention(Intention {
    // rust: protocol: 777,
    // rust: host: "localhost".into(),
    // rust: port: 25565,
    // rust: intent: LOGIN,
    // rust: });
    // rust: let body = p.encode();
    // rust: assert_eq!(body[0], 0);
    // rust: assert_eq!(&body[1..3], &[0x89, 0x06]);
    // rust: assert_eq!(&body[body.len() - 3..], &[0x63, 0xdd, 2]);
    // rust: crate::packets::round_trip(p, Serverbound::encode, Serverbound::decode);
}
}
