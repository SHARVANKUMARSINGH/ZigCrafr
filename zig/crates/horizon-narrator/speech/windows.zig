//! Transpiled from Horizon Rust crate
//! Module: horizon-narrator_windows
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `NarratorWindows`: SAPI's `SpVoice`, the voice and rate chosen in Windows'
//! speech settings.
// use windows::Win32::Media::Speech::{
    // rust: ISpVoice, SPF_ASYNC, SPF_IS_NOT_XML, SPF_PURGEBEFORESPEAK, SpVoice,
}
// use windows::Win32::System::Com::{
    // rust: CLSCTX_INPROC_HANDLER, CLSCTX_INPROC_SERVER, CLSCTX_LOCAL_SERVER, COINIT_MULTITHREADED,
    // rust: CoCreateInstance, CoInitializeEx, CoUninitialize,
}
// use windows::core::{HSTRING, w};

// use std::mem::ManuallyDrop;

    // rust: pub(super) struct Sapi {
    /// Released before `CoUninitialize` (`drop`).
    // rust: voice: ManuallyDrop<ISpVoice>,
}

    // rust: impl Sapi {
    /// `initSAPI`: `CoCreateInstance(SP_VOICE)` with the in-process and local
    /// server contexts (7). The speech thread is its own multithreaded
    /// apartment: no window messages reach it, and asynchronous speech needs
    /// none.
    // rust: pub(super) fn open() -> Result<Sapi, String> {
        // SAFETY: COM is initialised on this thread before any COM call, and
        // released in `drop` on the same thread.
    // rust: unsafe {
    // rust: CoInitializeEx(None, COINIT_MULTITHREADED)
    // rust: .ok()
    // rust: .map_err(|e| format!("CoInitializeEx returned {e}"))?;
    // rust: match CoCreateInstance(
    // rust: &SpVoice,
    // rust: None,
    // rust: CLSCTX_INPROC_SERVER | CLSCTX_INPROC_HANDLER | CLSCTX_LOCAL_SERVER,
    // rust: ) {
    // rust: Ok(voice) => Ok(Sapi {
    // rust: voice: ManuallyDrop::new(voice),
    // rust: }),
    // rust: Err(e) => {
    // rust: CoUninitialize();
    // rust: Err(format!("SP_VOICE returned code {e}"))
}
}
}
}
}

    // rust: impl super::Speech for Sapi {
    /// `Speak` asynchronously as plain text, purging what is queued when
    /// interrupting; the volume is set first, as `(short)(volume * 100.0F)`.
pub fn say(self: *Self, message: []const u8, interrupt: bool, volume: f32) void {
}
    // rust: let mut flags = (SPF_ASYNC.0 | SPF_IS_NOT_XML.0) as u32;
    // rust: if interrupt {
    // rust: flags |= SPF_PURGEBEFORESPEAK.0 as u32;
}
        // SAFETY: `voice` is a live SpVoice of this thread's apartment.
    // rust: unsafe {
    // rust: let _ = self.voice.SetVolume((volume * 100.0) as i16 as u16);
    // rust: if let Err(e) = self.voice.Speak(&HSTRING::from(message), flags, None) {
    // rust: log::warn!("Narrator: Speak failed: {e}");
}
}
}
    /// `Skip("Sentence", Integer.MAX_VALUE)`: skips what is left of the
    /// queue.
pub fn clear(self: *Self) void {
}
    // rust: let mut skipped = 0;
        // SAFETY: as in `say`; `skipped` outlives the call.
    // rust: unsafe {
    // rust: let _ = self.voice.Skip(w!("Sentence"), i32::MAX, &mut skipped);
}
}
}

    // rust: impl Drop for Sapi {
pub fn drop(self: *Self) void {
}
        // SAFETY: the voice is released before COM is, on its own thread.
    // rust: unsafe {
    // rust: ManuallyDrop::drop(&mut self.voice);
    // rust: CoUninitialize();
}
}
}
