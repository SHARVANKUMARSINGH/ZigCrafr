//! Transpiled from Horizon Rust crate
package horizon_protocol_mod

import "core:fmt"
import "core:mem"
import "core:math"

// Typed packets per connection state and direction. Every state has a
// `Clientbound` and a `Serverbound` enum whose `decode` checks that the
// whole body was consumed (vanilla rejects oversized packets the same way)
// and whose `encode` writes the id and payload. Packets Horizon does not
// model decode as `Unknown` and keep their raw payload.
    // rust: pub mod configuration;
    // rust: pub mod handshake;
    // rust: pub mod login;
    // rust: pub mod play;
    // rust: pub mod recipes;
    // rust: pub mod status;

// use crate::buf::{Codec, Reader, Writer};

// Generate a state's packet enum from (Variant(Type) = ID) entries.
    // rust: macro_rules! packet_enum {
    // rust: ($(#[$meta:meta])* $name:ident, $ids:path { $($variant:ident($ty:ty) = $id:ident),* $(,)? }) => {
    // rust: $(#[$meta])*
    // rust: pub enum $name {
    // rust: $($variant($ty),)*
            // A packet Horizon does not model: id and raw payload.
    // rust: Unknown(i32, Vec<u8>),
}
    // rust: impl $name {
id :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
//                 use $ids as ids;
    // rust: match self {
    // rust: $(Self::$variant(_) => ids::$id,)*
    // rust: Self::Unknown(id, _) => *id,
}
}
            // The packet's name in this enum (`MoveVehicle`), for logs.
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: $(Self::$variant(_) => stringify!($variant),)*
    // rust: Self::Unknown(..) => "Unknown",
}
}
            // Decode a packet body (after the id).
decode :: proc(id: i32, payload: []u8) -> $ {
    // Ported from Horizon
    return {}
}
//                 use $ids as ids;
    // rust: let mut r = $crate::buf::Reader::new(payload);
    // rust: let packet = match id {
    // rust: $(ids::$id => Self::$variant(<$ty as $crate::buf::Codec<$ty>>::read(&mut r)?),)*
    // rust: _ => return Ok(Self::Unknown(id, payload.to_vec())),
}
    // rust: if r.remaining() != 0 {
    // rust: return Err($crate::Error::new(format!(
    // rust: "packet {} ({}) was larger than expected: {} extra bytes",
    // rust: id,
    // rust: stringify!($name),
    // rust: r.remaining()
    // rust: )));
}
    // rust: Ok(packet)
}
            // The packet body: VarInt id then payload.
encode :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = $crate::buf::Writer::new();
    // rust: w.varint(self.id());
    // rust: match self {
    // rust: $(Self::$variant(p) => <$ty as $crate::buf::Codec<$ty>>::write(p, &mut w),)*
    // rust: Self::Unknown(_, payload) => w.bytes(payload),
}
    // rust: w.data
}
}
}
}

// A packet with no fields.
Empty :: struct {
    // rust: impl Codec<Empty> for Empty {
read :: proc(_: ^Reader) -> c {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Empty)
}
write :: proc(_: ^Empty, _: ^Writer) {
}
}

    // rust: pub(crate) fn round_trip<T: Clone + PartialEq + std::fmt::Debug>(
    // rust: packet: T,
    // rust: encode: impl Fn(&T) -> Vec<u8>,
    // rust: decode: impl Fn(i32, &[u8]) -> crate::Result<T>,
    // rust: ) {
    // rust: let body = encode(&packet);
    // rust: let mut r = Reader::new(&body);
    // rust: let id = r.varint().unwrap();
    // rust: let back = decode(id, r.rest()).unwrap();
    // rust: assert_eq!(back, packet);
}
