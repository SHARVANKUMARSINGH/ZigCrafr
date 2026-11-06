//! Transpiled from Horizon Rust crate
package horizon_world_item_use

import "core:fmt"
import "core:mem"
import "core:math"

// Living blocking-item eligibility retains the component's delay, but rereads
// use-item storage and remaining ticks around the virtual item-duration query.
    // rust: pub trait ItemUseWorld {
    // rust: type Error;
    // rust: type Item: Clone;
    // rust: type ItemType: Copy;
using_item :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
use_item :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
blocking_delay :: proc(self: ^Self, item: Self::Item) -> O {
    // Ported from Horizon
    return {}
}
item_type :: proc(self: ^Self, item: Self::Item) -> S {
    // Ported from Horizon
    return {}
}
    // rust: fn use_duration(
    // rust: &mut self,
    // rust: item_type: Self::ItemType,
    // rust: item: Self::Item,
    // rust: ) -> Result<i32, Self::Error>;
remaining_ticks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
remaining_ticks_virtual :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
query_blocking_item :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: blocking_item(self)
}
query_ticks_using_item :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: ticks_using_item(self)
}
}
    // rust: pub fn blocking_item<W: ItemUseWorld>(w: &mut W) -> Result<Option<W::Item>, W::Error> {
    // rust: if !w.using_item()? {
    // rust: return Ok(None);
}
    // rust: let Some(delay) = w.blocking_delay(w.use_item()) else {
    // rust: return Ok(None);
}
    // rust: let item_type = w.item_type(w.use_item());
    // rust: let item = w.use_item();
    // rust: let duration = w.use_duration(item_type, item)?;
    // rust: let elapsed = duration.wrapping_sub(w.remaining_ticks());
    // rust: Ok((elapsed >= delay).then(|| w.use_item()))
}

    // rust: pub fn is_blocking<W: ItemUseWorld>(w: &mut W) -> Result<bool, W::Error> {
    // rust: Ok(w.query_blocking_item()?.is_some())
}
    // rust: pub fn ticks_using_item<W: ItemUseWorld>(w: &mut W) -> Result<i32, W::Error> {
    // rust: if !w.using_item()? {
    // rust: return Ok(0);
}
    // rust: let item = w.use_item();
    // rust: let item_type = w.item_type(item.clone());
    // rust: let duration = w.use_duration(item_type, item)?;
    // rust: Ok(duration.wrapping_sub(w.remaining_ticks_virtual()?))
}
    // rust: pub fn ticks_using_item_partial<W: ItemUseWorld>(w: &mut W, partial: f32) -> Result<f32, W::Error> {
    // rust: if !w.using_item()? {
    // rust: return Ok(0.0);
}
    // rust: Ok(w.query_ticks_using_item()? as f32 + partial)
}
