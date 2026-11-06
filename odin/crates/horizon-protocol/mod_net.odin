//! Transpiled from Horizon Rust crate
package horizon_protocol_mod_net

import "core:fmt"
import "core:mem"
import "core:math"

// Mod messages: bytes a native mod's server half and its client half send
// each other, on one custom payload channel in the play state
// (docs/native-mods.md, "Mod messages").
//
// The server announces it carries them with an empty [`CHANNEL`] payload in
// the configuration phase (a vanilla client ignores it); a Horizon client
// that hears it may send them, and the server sends only to clients that
// identified as Horizon. A payload is the message's channel, then the bytes.
// use crate::{
    // rust: Error, Result,
    // rust: buf::{Reader, Writer},
}

// The custom payload channel, both ways.
CHANNEL :: "horizon:mod_net"
// Characters in each half of a message's channel at most.
MAX_PART :: 64
// Bytes of a message's data at most: a serverbound payload may hold
// `ServerboundCustomPayloadPacket.MAX_PAYLOAD_SIZE` (32767) in all.
MAX_DATA :: 30_000

// A message as it travels.
Message :: struct {
    channel: string,
    data: [dynamic]u8,
}

// A message's channel: `mod_id:name`, the mod's id `[a-z0-9_]{1,64}` and a
// name of its own `[a-z0-9_./-]{1,64}`. `minecraft` and `horizon` are the
// game's.
channel_ok :: proc(channel: string) -> b {
    // Ported from Horizon
    return {}
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

// A message's payload; an error for a channel or size outside the caps.
encode :: proc(message: ^Message) -> R {
    // Ported from Horizon
    return {}
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

// A payload's message; an error for one that breaks a cap.
decode :: proc(data: []u8) -> R {
    // Ported from Horizon
    return {}
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

message :: proc(data: [dynamic]u8) -> M {
    // Ported from Horizon
    return {}
}
    // rust: Message {
    // rust: channel: "cells:cell/state".into(),
    // rust: data,
}
}

a_message_round_trips :: proc() {
}
    // rust: for data in [vec![], vec![0, 255, 7], vec![9; MAX_DATA]] {
    // rust: let m = message(data);
    // rust: assert_eq!(decode(&encode(&m).unwrap()).unwrap(), m);
}
}

channels_name_a_mod_and_leave_the_games_alone :: proc() {
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

caps_are_enforced_both_ways :: proc() {
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

a_biggest_message_fits_a_serverbound_payload :: proc() {
}
    // rust: let m = Message {
    // rust: channel: format!("{}:{}", "x".repeat(MAX_PART), "n".repeat(MAX_PART)),
    // rust: data: vec![0; MAX_DATA],
}
    // rust: assert!(encode(&m).unwrap().len() <= 32767);
}
}
