//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_menu_extra
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Menu extra data: what a Horizon server tells a Horizon client about a
//! native mod's menu type its block opened, just before the
//! `ClientboundOpenScreenPacket` of the same window (docs/native-mods.md,
//! "Menu extra data"). NeoForge's counterpart is `openMenu` with an extra-data
//! writer, read by the menu type's `IContainerFactory`.
//!
//! A payload is the window id, the block's position, then the bytes the
//! block's mod wrote (empty when it wrote none). Clientbound only.
// use crate::{
    // rust: Error, Result,
    // rust: buf::{Reader, Writer},
}

/// The custom payload channel.
pub const CHANNEL: []const u8 = "horizon:menu_extra";
/// Bytes a mod may write at most.
pub const MAX_DATA: usize = 32_768;

/// A menu's extra data as it travels.
pub const Message = struct {
    /// The window id the `OpenScreen` that follows carries.
    window: i32,
    /// The block that opened the menu.
    pos: [i32,
    data: std.ArrayList(u8),
};

/// A message's payload; an error for data past [`MAX_DATA`].
pub fn encode(message: *Message) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if message.data.len() > MAX_DATA {
    // rust: return Err(Error::new("menu extra: data too big"));
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(message.window);
    // rust: message.pos.iter().for_each(|&axis| w.i32(axis));
    // rust: w.byte_array(&message.data);
    // rust: Ok(w.data)
}

/// A payload's message; an error for one that breaks a cap.
pub fn decode(data: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(data);
    // rust: let window = r.varint()?;
    // rust: let pos = [r.i32()?, r.i32()?, r.i32()?];
    // rust: let data = r.byte_array(MAX_DATA)?;
    // rust: if r.remaining() > 0 {
    // rust: return Err(Error::new("menu extra: trailing bytes"));
}
    // rust: Ok(Message { window, pos, data })
}

    // rust: mod tests {
//     use super::*;

pub fn a_message_round_trips() void {
}
    // rust: for data in [vec![], vec![0, 255, 7], vec![9; MAX_DATA]] {
    // rust: let m = Message {
    // rust: window: 100,
    // rust: pos: [-30_000_000, -64, 29_999_999],
    // rust: data,
}
    // rust: assert_eq!(decode(&encode(&m).unwrap()).unwrap(), m);
}
}

pub fn caps_are_enforced_both_ways() void {
}
    // rust: let big = Message {
    // rust: window: 1,
    // rust: pos: [0; 3],
    // rust: data: vec![0; MAX_DATA + 1],
}
    // rust: assert!(encode(&big).is_err());
        // Built by hand, as a server that skipped the check would.
    // rust: let mut w = Writer::new();
    // rust: w.varint(1);
    // rust: [0, 0, 0].iter().for_each(|&axis| w.i32(axis));
    // rust: w.byte_array(&vec![0; MAX_DATA + 1]);
    // rust: assert!(decode(&w.data).is_err());
    // rust: let mut ok = encode(&Message {
    // rust: window: 1,
    // rust: pos: [0; 3],
    // rust: data: vec![1],
    // rust: })
    // rust: .unwrap();
    // rust: ok.push(0);
    // rust: assert!(decode(&ok).is_err(), "trailing bytes");
    // rust: assert!(decode(&[]).is_err());
    // rust: assert!(decode(&[1, 0, 0]).is_err(), "a cut position");
}
}
