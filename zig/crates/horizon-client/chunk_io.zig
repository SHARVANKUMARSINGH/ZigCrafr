//! Transpiled from Horizon Rust crate
//! Module: horizon-client_chunk_io
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `IntegratedServer.reportChunkLoadFailure` / `reportChunkSaveFailure` /
//! `sendLowDiskSpaceWarning`: the region storage runs on the server thread and
//! its writer thread, and the toasts are the window's. Each failure is logged,
//! checked for low disk space (`MinecraftServer.warnOnLowDiskSpace`) and queued
//! here; the window drains the queue every frame (`Minecraft.execute`).
//! `SystemToast.addOrUpdate` makes a repeat reset the toast it already shows,
//! so only the newest chunk of each kind is kept.
// use crate::{lang, save, toasts::SystemToast};
// use std::{path::Path, sync::Mutex};

/// What the window has still to toast.
pub const Pending = struct {
    /// `SystemToast.onLowDiskSpace`.
    low_disk_space: bool,
    /// `SystemToast.onChunkLoadFailure`: the newest chunk.
    load_failure: Option<(i32,
    /// `SystemToast.onChunkSaveFailure`: the newest chunk.
    save_failure: Option<(i32,
};

    // rust: static PENDING: Mutex<Pending> = Mutex::new(Pending {
    // rust: low_disk_space: false,
    // rust: load_failure: None,
    // rust: save_failure: None,
    // rust: });

    // rust: impl Pending {
    /// `reportChunkLoadFailure` after `warnOnLowDiskSpace` found `low_disk_space`.
pub fn load_failed(self: *Self, x: i32, z: i32, low_disk_space: bool) void {
}
    // rust: self.low_disk_space |= low_disk_space;
    // rust: self.load_failure = Some((x, z));
}

    /// `reportChunkSaveFailure` after `warnOnLowDiskSpace` found `low_disk_space`.
pub fn save_failed(self: *Self, x: i32, z: i32, low_disk_space: bool) void {
}
    // rust: self.low_disk_space |= low_disk_space;
    // rust: self.save_failure = Some((x, z));
}
}

pub fn with(update: impl FnOnce(*mut Pending) void {
}
    // rust: let mut pending = PENDING.lock().unwrap_or_else(|e| e.into_inner());
    // rust: update(&mut pending);
}

/// `MinecraftServer.warnOnLowDiskSpace` for the world folder `dir`.
pub fn warn_on_low_disk_space(dir: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let low = save::low_disk_space(dir);
    // rust: if low {
        // `MinecraftServer.sendLowDiskSpaceWarning`.
    // rust: log::warn!("Low disk space! Might not be able to save the world.");
}
    // rust: low
}

/// `reportChunkLoadFailure` for the chunk at (`x`, `z`) of the dimension in `dir`.
pub fn report_load_failure(dir: *Path, x: i32, z: i32, error: *dyn std::fmt::Display) void {
}
    // rust: log::error!("Failed to load chunk {x},{z}: {error}");
    // rust: let low = warn_on_low_disk_space(dir);
    // rust: with(|p| p.load_failed(x, z, low));
}

/// `reportChunkSaveFailure`.
pub fn report_save_failure(dir: *Path, x: i32, z: i32, error: *dyn std::fmt::Display) void {
}
    // rust: log::error!("Failed to save chunk {x},{z}: {error}");
    // rust: let low = warn_on_low_disk_space(dir);
    // rust: with(|p| p.save_failed(x, z, low));
}

/// `Minecraft.sendLowDiskSpaceWarning`: a server's `ClientboundLowDiskSpaceWarningPacket`
/// (`ClientPacketListener.handleLowDiskSpaceWarning`) toasts like the local report.
pub fn report_low_disk_space() void {
}
    // rust: with(|p| p.low_disk_space = true);
}

/// The reports since the last call.
pub fn take() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut pending = PENDING.lock().unwrap_or_else(|e| e.into_inner());
    // rust: std::mem::take(&mut *pending)
}

/// `ChatFormatting.RED`.
pub fn red() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::hud::rgba(255, 85, 85, 255)
}

/// `SystemToast.onLowDiskSpace` (`SystemToastId.LOW_DISK_SPACE`: ten seconds).
pub fn low_disk_space_toast() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SystemToast::new(
    // rust: lang::tr("chunk.toast.lowDiskSpace", &[]),
    // rust: Some(lang::tr("chunk.toast.lowDiskSpace.description", &[])),
    // rust: )
    // rust: .with_display_time(SystemToast::LONG_DISPLAY_TIME)
}

pub fn chunk_toast(key: []const u8, x: i32, z: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // `Component.translationArg(ChunkPos)` is `ChunkPos.toString`.
    // rust: let pos = format!("[{x}, {z}]");
    // rust: SystemToast::new(
    // rust: lang::tr(key, &[&pos]),
    // rust: Some(lang::tr("chunk.toast.checkLog", &[])),
    // rust: )
    // rust: .with_title_color(red())
}

/// `SystemToast.onChunkLoadFailure`.
pub fn load_failure_toast(x: i32, z: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: chunk_toast("chunk.toast.loadFailure", x, z)
}

/// `SystemToast.onChunkSaveFailure`.
pub fn save_failure_toast(x: i32, z: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: chunk_toast("chunk.toast.saveFailure", x, z)
}

    // rust: mod tests {
//     use super::*;

    // These tests keep off `PENDING` where they can: the save tests run in
    // the same process and report their own chunk failures into it (#4854).
pub fn failures_keep_the_newest_chunk_of_each_kind() void {
}
    // rust: let mut pending = Pending::default();
    // rust: pending.load_failed(1, 2, false);
    // rust: pending.load_failed(3, 4, false);
    // rust: pending.save_failed(5, 6, false);
    // rust: assert_eq!(
    // rust: pending,
    // rust: Pending {
    // rust: low_disk_space: false,
    // rust: load_failure: Some((3, 4)),
    // rust: save_failure: Some((5, 6)),
}
    // rust: );
        // A later failure on a full disk raises the warning, and one with
        // space left does not lower it.
    // rust: pending.save_failed(7, 8, true);
    // rust: pending.load_failed(9, 10, false);
    // rust: assert_eq!(
    // rust: pending,
    // rust: Pending {
    // rust: low_disk_space: true,
    // rust: load_failure: Some((9, 10)),
    // rust: save_failure: Some((7, 8)),
}
    // rust: );
}

    /// The only test that drains `PENDING`; other tests only add to it, so
    /// the flag it raises is still there when it takes it.
pub fn a_servers_warning_packet_toasts_low_disk_space() void {
}
    // rust: report_low_disk_space();
    // rust: assert!(take().low_disk_space);
}

pub fn low_disk_space_toast_stays_ten_seconds() void {
}
    // rust: let toast = low_disk_space_toast();
    // rust: assert_eq!(toast.display_time(), 10000.0);
    // rust: assert_eq!(load_failure_toast(0, 0).display_time(), 5000.0);
}
}
