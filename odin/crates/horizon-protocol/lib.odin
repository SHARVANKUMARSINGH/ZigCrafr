//! Transpiled from Horizon Rust crate
package horizon_protocol_lib

import "core:fmt"
import "core:mem"
import "core:math"

// The Minecraft Java Edition network protocol (of the version in `horizon_core::version`):
// primitive codecs, framing, compression, encryption, and typed packets for
// every connection state, shared by the Horizon client and (later) server.
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

// SharedConstants.getProtocolVersion().
PROTOCOL_VERSION :: horizon_core::version::PROTOCOL_VERSION
// The game version servers report in their status.
GAME_VERSION :: horizon_core::VANILLA_VERSION

// Connection protocol states (ConnectionProtocol).
State :: enum {
    Handshake,
    Status,
    Login,
    Configuration,
    Play,
}
// PacketFlow.
Direction :: enum {
    Clientbound,
    Serverbound,
}

// A malformed or unsupported packet.
Error :: struct {
    // rust: impl Error {
TIMED_OUT :: "Timed out"
END_OF_STREAM :: "Connection closed by the server"
new :: proc(message: impl Into<string>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(message.into())
}
    // The read timeout passed with nothing received (netty's
    // `ReadTimeoutException`, which `Connection.exceptionCaught` reports as
    // `disconnect.timeout`).
timed_out :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(Self::TIMED_OUT)
}
is_timed_out :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0 == Self::TIMED_OUT
}
    // The peer closed the stream (`Connection.channelInactive`).
end_of_stream :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(Self::END_OF_STREAM)
}
is_end_of_stream :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0 == Self::END_OF_STREAM
}
}
    // rust: impl std::fmt::Display for Error {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(&self.0)
}
}
    // rust: impl std::error::Error for Error {}
    // rust: impl From<std::io::Error> for Error {
from :: proc(e: std::io::Error) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(e.to_string())
}
}
    // rust: pub type Result<T> = std::result::Result<T, Error>;
