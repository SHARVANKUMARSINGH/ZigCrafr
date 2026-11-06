//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_quiet
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Quiet commands: a client mod's batch of commands that a Horizon server runs
//! as the player who sent them, at that player's own permission level, with
//! no feedback in the chat (docs/mods.md, `command.run-quiet`).
//!
//! The server announces it understands them with an empty [`CHANNEL`] payload
//! in the configuration phase (a vanilla client ignores it); a client that
//! hears it sends each batch as a serverbound [`CHANNEL`] payload, and falls
//! back to chat commands on any other server. A payload is the mod's id, then
//! the lines without their slash.
// use crate::{
    // rust: Error, Result,
    // rust: buf::{Reader, Writer},
}

/// The custom payload channel, both ways.
pub const CHANNEL: []const u8 = "horizon:quiet_commands";
/// Lines in one payload at most; a payload with more is refused whole.
pub const MAX_LINES: usize = 256;
/// Characters in a line at most (a chat command's limit).
pub const MAX_LINE: usize = 256;
/// Characters in a mod id at most.
pub const MAX_MOD_ID: usize = 64;
/// Bytes of a serverbound custom payload's data at most
/// (ServerboundCustomPayloadPacket.MAX_PAYLOAD_SIZE).
pub const MAX_PAYLOAD: usize = 32767;

/// A batch as the server reads it.
pub const Batch = struct {
    mod_id: []const u8,
    lines: std.ArrayList([]const u8),
};

/// `lines` as few payloads as fit [`MAX_PAYLOAD`] and [`MAX_LINES`], in
/// order. Lines longer than [`MAX_LINE`] are cut, as a chat command's are.
pub fn encode(mod_id: []const u8, lines: *[[]const u8]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mod_id: String = mod_id.chars().take(MAX_MOD_ID).collect();
    // rust: let mut payloads = Vec::new();
    // rust: let mut rest = lines
    // rust: .iter()
    // rust: .map(|l| -> String { l.chars().take(MAX_LINE).collect() });
    // rust: let mut next = rest.next();
    // rust: while next.is_some() {
    // rust: let mut batch = Vec::new();
        // The id, the count (a varint of at most 2 bytes for 256).
    // rust: let mut size = string_size(&mod_id) + 2;
    // rust: while let Some(line) = next.take() {
    // rust: let more = string_size(&line);
    // rust: if !batch.is_empty() && (batch.len() == MAX_LINES || size + more > MAX_PAYLOAD) {
    // rust: next = Some(line);
    // rust: break;
}
    // rust: size += more;
    // rust: batch.push(line);
    // rust: next = rest.next();
}
    // rust: let mut w = Writer::new();
    // rust: w.string(&mod_id);
    // rust: w.varint(batch.len() as i32);
    // rust: for line in &batch {
    // rust: w.string(line);
}
    // rust: payloads.push(w.data);
}
    // rust: payloads
}

pub fn string_size(s: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::buf::varint_size(s.len() as i32) + s.len()
}

/// A payload's batch; an error for one that breaks a cap.
pub fn decode(data: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if data.len() > MAX_PAYLOAD {
    // rust: return Err(Error::new("quiet commands: payload too big"));
}
    // rust: let mut r = Reader::new(data);
    // rust: let mod_id = r.string(MAX_MOD_ID)?;
    // rust: let count = r.varint()?;
    // rust: if !(0..=MAX_LINES as i32).contains(&count) {
    // rust: return Err(Error::new(format!("quiet commands: {count} lines")));
}
    // rust: let lines = (0..count)
    // rust: .map(|_| r.string(MAX_LINE))
    // rust: .collect::<Result<Vec<_>>>()?;
    // rust: if r.remaining() > 0 {
    // rust: return Err(Error::new("quiet commands: trailing bytes"));
}
    // rust: Ok(Batch { mod_id, lines })
}

    // rust: mod tests {
//     use super::*;

pub fn a_batch_round_trips() void {
}
    // rust: let lines = vec!["fill 0 0 0 1 1 1 stone".to_string(), "say hi".to_string()];
    // rust: let payloads = encode("orbital", &lines);
    // rust: assert_eq!(payloads.len(), 1);
    // rust: assert_eq!(
    // rust: decode(&payloads[0]).unwrap(),
    // rust: Batch {
    // rust: mod_id: "orbital".into(),
    // rust: lines
}
    // rust: );
}

pub fn big_batches_split_by_lines_and_bytes() void {
}
    // rust: let lines: Vec<String> = (0..600)
    // rust: .map(|i| format!("setblock {i} 0 0 stone"))
    // rust: .collect();
    // rust: let payloads = encode("m", &lines);
    // rust: let decoded: Vec<Batch> = payloads.iter().map(|p| decode(p).unwrap()).collect();
    // rust: assert_eq!(
    // rust: decoded.iter().map(|b| b.lines.len()).collect::<Vec<_>>(),
    // rust: [256, 256, 88]
    // rust: );
    // rust: assert_eq!(
    // rust: decoded
    // rust: .into_iter()
    // rust: .flat_map(|b| b.lines)
    // rust: .collect::<Vec<_>>(),
    // rust: lines
    // rust: );
    // rust: let long: Vec<String> = (0..256).map(|_| "x".repeat(300)).collect();
    // rust: for p in encode("m", &long) {
    // rust: assert!(p.len() <= MAX_PAYLOAD);
    // rust: assert!(
    // rust: decode(&p)
    // rust: .unwrap()
    // rust: .lines
    // rust: .iter()
    // rust: .all(|l| l.len() == MAX_LINE)
    // rust: );
}
}

pub fn payloads_over_the_caps_are_refused() void {
}
    // rust: let mut w = Writer::new();
    // rust: w.string("m");
    // rust: w.varint(MAX_LINES as i32 + 1);
    // rust: for _ in 0..=MAX_LINES {
    // rust: w.string("say");
}
    // rust: assert!(decode(&w.data).is_err());
    // rust: let mut w = Writer::new();
    // rust: w.string("m");
    // rust: w.varint(1);
    // rust: w.string(&"x".repeat(MAX_LINE + 1));
    // rust: assert!(decode(&w.data).is_err());
    // rust: let mut w = Writer::new();
    // rust: w.string("m");
    // rust: w.varint(-1);
    // rust: assert!(decode(&w.data).is_err());
    // rust: assert!(decode(&[0xFF]).is_err());
    // rust: let mut w = Writer::new();
    // rust: w.string("m");
    // rust: w.varint(0);
    // rust: w.u8(1);
    // rust: assert!(decode(&w.data).is_err());
}
}
