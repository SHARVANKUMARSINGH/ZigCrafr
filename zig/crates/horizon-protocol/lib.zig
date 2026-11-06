//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The Minecraft Java Edition network protocol (of the version in `horizon_core::version`):
//! primitive codecs, framing, compression, encryption, and typed packets for
//! every connection state, shared by the Horizon client and (later) server.
// `deny`, not `forbid`: crypto/blocks.rs allows the ARMv8 AES intrinsics, nothing else.
    // rust: pub mod adapter;
    // rust: pub mod attachment_sync;
    // rust: pub mod buf;
    // rust: pub mod chunk;
    // rust: pub mod connection;
    // rust: pub mod crypto;
    // rust: pub mod entity_data;
    // rust: pub mod frame;
    // rust: pub mod hash_ops;
    // rust: pub mod ids;
    // rust: pub mod item;
    // rust: pub mod menu_extra;
    // rust: pub mod mod_list;
    // rust: pub mod mod_net;
    // rust: pub mod packets;
    // rust: pub mod quiet;
    // rust: pub mod registry;
    // rust: mod resolver;
    // rust: pub use resolver::server_redirect;
    // rust: pub mod rsa;
    // rust: pub mod secure_chat;
    // rust: pub mod servers;
    // rust: pub mod text;

/// SharedConstants.getProtocolVersion().
pub const PROTOCOL_VERSION: i32 = horizon_core::version::PROTOCOL_VERSION;
/// The game version servers report in their status.
pub const GAME_VERSION: []const u8 = horizon_core::VANILLA_VERSION;

/// Connection protocol states (ConnectionProtocol).
pub const State = enum {
    Handshake,
    Status,
    Login,
    Configuration,
    Play,
};
/// PacketFlow.
pub const Direction = enum {
    Clientbound,
    Serverbound,
};

/// A malformed or unsupported packet.
pub const Error = struct {};
    // rust: impl Error {
pub const TIMED_OUT: []const u8 = "Timed out";
pub const END_OF_STREAM: []const u8 = "Connection closed by the server";
pub fn new(message: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(message.into())
}
    /// The read timeout passed with nothing received (netty's
    /// `ReadTimeoutException`, which `Connection.exceptionCaught` reports as
    /// `disconnect.timeout`).
pub fn timed_out() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(Self::TIMED_OUT)
}
pub fn is_timed_out(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 == Self::TIMED_OUT
}
    /// The peer closed the stream (`Connection.channelInactive`).
pub fn end_of_stream() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(Self::END_OF_STREAM)
}
pub fn is_end_of_stream(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 == Self::END_OF_STREAM
}
}
    // rust: impl std::fmt::Display for Error {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str(&self.0)
}
}
    // rust: impl std::error::Error for Error {}
    // rust: impl From<std::io::Error> for Error {
pub fn from(e: std::io::Error) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(e.to_string())
}
}
    // rust: pub type Result<T> = std::result::Result<T, Error>;
