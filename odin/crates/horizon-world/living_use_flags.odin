//! Transpiled from Horizon Rust crate
package horizon_world_living_use_flags

import "core:fmt"
import "core:mem"
import "core:math"

// Pinned living-entity use flags backed by synchronized byte storage.
// use crate::{
    // rust: player_equipment::InteractionHand,
    // rust: synced_values::{DataError, Observer, SyncedValues},
}
FLAGS_ID :: 8
using_item :: proc(data: ^SyncedValues<u8>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(data.get(FLAGS_ID)? & 1 != 0)
}
used_hand :: proc(data: ^SyncedValues<u8>) -> R {
    // Ported from Horizon
    return {}
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
