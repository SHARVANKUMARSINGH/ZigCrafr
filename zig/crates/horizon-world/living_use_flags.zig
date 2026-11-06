//! Transpiled from Horizon Rust crate
//! Module: horizon-world_living_use_flags
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Pinned living-entity use flags backed by synchronized byte storage.
// use crate::{
    // rust: player_equipment::InteractionHand,
    // rust: synced_values::{DataError, Observer, SyncedValues},
}
pub const FLAGS_ID: u8 = 8;
pub fn using_item(data: *SyncedValues<u8>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(data.get(FLAGS_ID)? & 1 != 0)
}
pub fn used_hand(data: *SyncedValues<u8>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(if data.get(FLAGS_ID)? & 2 != 0 {
    // rust: InteractionHand::Off
    // rust: } else {
    // rust: InteractionHand::Main
    // rust: })
}
    // rust: pub fn set_flag<O: Observer<u8>>(
    // rust: data: &mut SyncedValues<u8>,
    // rust: mask: i32,
    // rust: value: bool,
    // rust: observer: &mut O,
    // rust: ) -> Result<(), DataError<O::Error>> {
    // rust: let old = i32::from(data.get(FLAGS_ID).map_err(DataError::UnknownId)? as i8);
    // rust: let next = if value { old | mask } else { old & !mask };
    // rust: data.set(FLAGS_ID, next as u8, false, observer)
}
