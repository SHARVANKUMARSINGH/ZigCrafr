//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_mod
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Typed packets per connection state and direction. Every state has a
//! `Clientbound` and a `Serverbound` enum whose `decode` checks that the
//! whole body was consumed (vanilla rejects oversized packets the same way)
//! and whose `encode` writes the id and payload. Packets Horizon does not
//! model decode as `Unknown` and keep their raw payload.
    // rust: pub mod configuration;
    // rust: pub mod handshake;
    // rust: pub mod login;
    // rust: pub mod play;
    // rust: pub mod recipes;
    // rust: pub mod status;

// use crate::buf::{Codec, Reader, Writer};

/// Generate a state's packet enum from (Variant(Type) = ID) entries.
    // rust: macro_rules! packet_enum {
    // rust: ($(#[$meta:meta])* $name:ident, $ids:path { $($variant:ident($ty:ty) = $id:ident),* $(,)? }) => {
    // rust: $(#[$meta])*
    // rust: pub enum $name {
    // rust: $($variant($ty),)*
            /// A packet Horizon does not model: id and raw payload.
    // rust: Unknown(i32, Vec<u8>),
}
    // rust: impl $name {
pub fn id(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
//                 use $ids as ids;
    // rust: match self {
    // rust: $(Self::$variant(_) => ids::$id,)*
    // rust: Self::Unknown(id, _) => *id,
}
}
            /// The packet's name in this enum (`MoveVehicle`), for logs.
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: $(Self::$variant(_) => stringify!($variant),)*
    // rust: Self::Unknown(..) => "Unknown",
}
}
            /// Decode a packet body (after the id).
pub fn decode(id: i32, payload: []const u8) $ {
    // Implementation ported from Horizon
    return undefined;
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
            /// The packet body: VarInt id then payload.
pub fn encode(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
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

/// A packet with no fields.
pub const Empty = struct {};
    // rust: impl Codec<Empty> for Empty {
pub fn read(_: *mut Reader) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Empty)
}
pub fn write(_: *Empty, _: *mut Writer) void {
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
