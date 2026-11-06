//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_mod_net
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Mod messages: bytes a native mod's server half and its client half send
//! each other, on one custom payload channel in the play state
//! (docs/native-mods.md, "Mod messages").
//!
//! The server announces it carries them with an empty [`CHANNEL`] payload in
//! the configuration phase (a vanilla client ignores it); a Horizon client
//! that hears it may send them, and the server sends only to clients that
//! identified as Horizon. A payload is the message's channel, then the bytes.
// use crate::{
    // rust: Error, Result,
    // rust: buf::{Reader, Writer},
}

/// The custom payload channel, both ways.
pub const CHANNEL: []const u8 = "horizon:mod_net";
/// Characters in each half of a message's channel at most.
pub const MAX_PART: usize = 64;
/// Bytes of a message's data at most: a serverbound payload may hold
/// `ServerboundCustomPayloadPacket.MAX_PAYLOAD_SIZE` (32767) in all.
pub const MAX_DATA: usize = 30_000;

/// A message as it travels.
pub const Message = struct {
    channel: []const u8,
    data: std.ArrayList(u8),
};

/// A message's channel: `mod_id:name`, the mod's id `[a-z0-9_]{1,64}` and a
/// name of its own `[a-z0-9_./-]{1,64}`. `minecraft` and `horizon` are the
/// game's.
pub fn channel_ok(channel: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((id, name)) = channel.split_once(':') else {
    // rust: return false;
}
    // rust: (1..=MAX_PART).contains(&id.len())
    // rust: && (1..=MAX_PART).contains(&name.len())
    // rust: && !matches!(id, "minecraft" | "horizon")
    // rust: && id
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_')
    // rust: && name.bytes().all(|b| {
    // rust: b.is_ascii_lowercase() || b.is_ascii_digit() || matches!(b, b'_' | b'.' | b'/' | b'-')
    // rust: })
}

/// A message's payload; an error for a channel or size outside the caps.
pub fn encode(message: *Message) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !channel_ok(&message.channel) {
    // rust: return Err(Error::new("mod net: bad channel"));
}
    // rust: if message.data.len() > MAX_DATA {
    // rust: return Err(Error::new("mod net: data too big"));
}
    // rust: let mut w = Writer::new();
    // rust: w.string(&message.channel);
    // rust: w.byte_array(&message.data);
    // rust: Ok(w.data)
}

/// A payload's message; an error for one that breaks a cap.
pub fn decode(data: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(data);
    // rust: let channel = r.string(MAX_PART * 2 + 1)?;
    // rust: let data = r.byte_array(MAX_DATA)?;
    // rust: if r.remaining() > 0 {
    // rust: return Err(Error::new("mod net: trailing bytes"));
}
    // rust: if !channel_ok(&channel) {
    // rust: return Err(Error::new("mod net: bad channel"));
}
    // rust: Ok(Message { channel, data })
}

    // rust: mod tests {
//     use super::*;

pub fn message(data: std.ArrayList(u8)) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Message {
    // rust: channel: "cells:cell/state".into(),
    // rust: data,
}
}

pub fn a_message_round_trips() void {
}
    // rust: for data in [vec![], vec![0, 255, 7], vec![9; MAX_DATA]] {
    // rust: let m = message(data);
    // rust: assert_eq!(decode(&encode(&m).unwrap()).unwrap(), m);
}
}

pub fn channels_name_a_mod_and_leave_the_games_alone() void {
}
    // rust: for good in ["cells:state", "my_mod:a/b.c-d", "m:n"] {
    // rust: assert!(channel_ok(good), "{good}");
}
    // rust: for bad in [
    // rust: "",
    // rust: "state",
    // rust: ":state",
    // rust: "cells:",
    // rust: "Cells:state",
    // rust: "cells:Has Spaces",
    // rust: "cells:a:b",
    // rust: "minecraft:brand",
    // rust: "horizon:mod_net",
    // rust: ] {
    // rust: assert!(!channel_ok(bad), "{bad}");
}
    // rust: assert!(channel_ok(&format!(
    // rust: "{}:{}",
    // rust: "x".repeat(MAX_PART),
    // rust: "n".repeat(MAX_PART)
    // rust: )));
    // rust: assert!(!channel_ok(&format!("{}:n", "x".repeat(MAX_PART + 1))));
    // rust: assert!(!channel_ok(&format!("x:{}", "n".repeat(MAX_PART + 1))));
}

pub fn caps_are_enforced_both_ways() void {
}
    // rust: assert!(encode(&message(vec![0; MAX_DATA + 1])).is_err());
    // rust: let mut bad = message(vec![]);
    // rust: bad.channel = "no_name".into();
    // rust: assert!(encode(&bad).is_err());
        // A payload built by hand with a channel outside the rules.
    // rust: let mut w = Writer::new();
    // rust: w.string("minecraft:brand");
    // rust: w.byte_array(&[]);
    // rust: assert!(decode(&w.data).is_err());
    // rust: let mut ok = encode(&message(vec![1])).unwrap();
    // rust: ok.push(0);
    // rust: assert!(decode(&ok).is_err(), "trailing bytes");
    // rust: assert!(decode(&[]).is_err());
    // rust: assert!(decode(&[200, 200, 200]).is_err());
}

pub fn a_biggest_message_fits_a_serverbound_payload() void {
}
    // rust: let m = Message {
    // rust: channel: format!("{}:{}", "x".repeat(MAX_PART), "n".repeat(MAX_PART)),
    // rust: data: vec![0; MAX_DATA],
}
    // rust: assert!(encode(&m).unwrap().len() <= 32767);
}
}
