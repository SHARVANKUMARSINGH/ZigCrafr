//! Transpiled from Horizon Rust crate
//! Module: horizon-client_border
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The world border a server's players see: all of it when they enter a
//! level (`PlayerList.sendLevelInfo`), then each change as
//! `BorderChangeListener` broadcasts it: a new centre, a new size, a size
//! change in progress, a new warning time or distance.
// use crate::worldborder::WorldBorder;
// use horizon_protocol::packets::play::{self, Clientbound as C};

/// `ClientboundInitializeBorderPacket`.
pub fn initialize(b: *WorldBorder) p {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [center_x, center_z] = b.center();
    // rust: play::InitializeBorder {
    // rust: center_x,
    // rust: center_z,
    // rust: old_size: b.size(),
    // rust: new_size: b.target_size(),
    // rust: lerp_time: b.remaining_ticks(),
    // rust: absolute_max_size: b.absolute_max_size(),
    // rust: warning_blocks: b.warning_distance,
    // rust: warning_time: b.warning_time,
}
}

/// The border as the players were last told of it.
pub const Sent = struct {
    center: [f64,
    size: f64,
    target: f64,
    remaining: i64,
    warning_distance: i32,
    warning_time: i32,
};

    // rust: impl Sent {
pub fn of(b: *WorldBorder) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: center: b.center(),
    // rust: size: b.size(),
    // rust: target: b.target_size(),
    // rust: remaining: b.remaining_ticks(),
    // rust: warning_distance: b.warning_distance,
    // rust: warning_time: b.warning_time,
}
}

    /// The packets that tell the players what changed since `self`, other
    /// than a size change going on (which each client runs itself).
pub fn changes(self: *Self, b: *WorldBorder) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let now = Self::of(b);
    // rust: let mut out = Vec::new();
    // rust: if now.center != self.center {
    // rust: out.push(C::SetBorderCenter(play::SetBorderCenter {
    // rust: x: now.center[0],
    // rust: z: now.center[1],
    // rust: }));
}
        // A change going on counts down a tick at a time (or not at all
        // while the game is frozen), towards the same size.
    // rust: let going_on = self.remaining > 0
    // rust: && now.target == self.target
    // rust: && (now.remaining == self.remaining || now.remaining == self.remaining - 1);
    // rust: if now.remaining > 0 {
    // rust: if !going_on {
    // rust: out.push(C::SetBorderLerpSize(play::SetBorderLerpSize {
    // rust: old_size: now.size,
    // rust: new_size: now.target,
    // rust: lerp_time: now.remaining,
    // rust: }));
}
    // rust: } else if now.size != self.size && !(self.remaining > 0 && now.size == self.target) {
    // rust: out.push(C::SetBorderSize(play::SetBorderSize { size: now.size }));
}
    // rust: if now.warning_time != self.warning_time {
    // rust: out.push(C::SetBorderWarningDelay(play::SetBorderWarningDelay {
    // rust: delay: now.warning_time,
    // rust: }));
}
    // rust: if now.warning_distance != self.warning_distance {
    // rust: out.push(C::SetBorderWarningDistance(
    // rust: play::SetBorderWarningDistance {
    // rust: blocks: now.warning_distance,
    // rust: },
    // rust: ));
}
    // rust: out
}
}

    // rust: mod tests {
//     use super::*;

pub fn kinds(packets: *[C]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: packets
    // rust: .iter()
    // rust: .map(|p| match p {
    // rust: C::SetBorderCenter(_) => "center",
    // rust: C::SetBorderSize(_) => "size",
    // rust: C::SetBorderLerpSize(_) => "lerp",
    // rust: C::SetBorderWarningDelay(_) => "delay",
    // rust: C::SetBorderWarningDistance(_) => "distance",
    // rust: _ => "other",
    // rust: })
    // rust: .collect()
}

pub fn each_change_is_sent_once() void {
}
    // rust: let mut b = WorldBorder::default();
    // rust: let mut sent = Sent::of(&b);
    // rust: assert!(sent.changes(&b).is_empty());
    // rust: b.set_center([4.0, -2.0]);
    // rust: b.set_size(10.0);
    // rust: b.warning_time = 30;
    // rust: assert_eq!(kinds(&sent.changes(&b)), ["center", "size", "delay"]);
    // rust: sent = Sent::of(&b);
        // A change over 3 ticks: sent once, then each client runs it.
    // rust: b.lerp_to(20.0, 3);
    // rust: assert_eq!(kinds(&sent.changes(&b)), ["lerp"]);
    // rust: for _ in 0..4 {
    // rust: sent = Sent::of(&b);
    // rust: b.tick();
    // rust: assert!(sent.changes(&b).is_empty(), "{:?}", sent.changes(&b));
}
    // rust: assert_eq!(b.size(), 20.0);
    // rust: b.warning_distance = 1;
    // rust: assert_eq!(kinds(&Sent::of(&b).changes(&b)), [] as [&str; 0]);
    // rust: assert_eq!(kinds(&sent.changes(&b)), ["distance"]);
}
}
