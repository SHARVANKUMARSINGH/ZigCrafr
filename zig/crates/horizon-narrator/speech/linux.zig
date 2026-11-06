//! Transpiled from Horizon Rust crate
//! Module: horizon-narrator_linux
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `NarratorLinux`: flite's `cmu_us_kal16` voice, from the system's
//! `libflite` and `libflite_cmu_us_kal16`, opened at run time as JNA does (a
//! system without flite has no narrator, the game still runs).
// use libloading::os::unix::{Library, RTLD_GLOBAL, RTLD_LAZY};

// use std::ffi::{CString, c_char, c_int, c_void};
// use std::sync::Arc;
// use std::sync::atomic::{AtomicI32, Ordering};
// use std::sync::mpsc::{self, Receiver, Sender};

// use super::linux_split::units;

/// `cst_voice`, `cst_utterance` and `cst_wave`, only ever handled by pointer.
    // rust: type Voice = c_void;
    // rust: type Utterance = c_void;
    // rust: type Wave = c_void;

    // rust: pub(super) struct Flite {
    /// The executor's queue: the pieces left to say, in order.
    // rust: pieces: Sender<Piece>,
    /// `executionBatch`: a piece is said only if no `clear` came after it was
    /// queued.
    // rust: batch: Arc<AtomicI32>,
}

/// One task of `say`: a piece of the message, the batch it belongs to and
/// the volume it is said at.
pub const Piece = struct {
    text: CString,
    batch: i32,
    volume: f32,
};

/// `FliteLibrary` and `FliteLibrary.CmuUsKal16`: flite's functions, kept with
/// the libraries that hold them.
pub const FliteLibrary = struct {
    _flite: Library,
    _cmu_us_kal16: Library,
    synth_text: unsafe extern "C" fn(*const c_char,
    utt_wave: unsafe extern "C" fn(*mut Utterance) -> *mut Wave,
    play_wave: unsafe extern "C" fn(*mut Wave) -> c_int,
    wave_rescale: unsafe extern "C" fn(*mut Wave,
    delete_utterance: unsafe extern "C" fn(*mut Utterance),
};

/// The registered `cmu_us_kal16` voice, handed to the player thread.
pub const VoicePtr = struct {};
// SAFETY: the voice is registered on the narrator thread, then only read by
// `flite_synth_text` on the player thread, which owns it from then on.
    // rust: unsafe impl Send for VoicePtr {}

    // rust: impl Flite {
    /// The constructor: loads flite, then the voice; `flite_init` must return
    /// 0 and `register_cmu_us_kal16(null)` a voice. The executor's thread
    /// ("Narrator #0", a daemon: the game never waits for it) speaks.
    // rust: pub(super) fn open() -> Result<Flite, String> {
        // SAFETY: each symbol is looked up as the type flite declares it with
        // (`flite.h`, `cst_wave.h`, `cst_utterance.h`, `audio.h`), and the
        // pointers are kept no longer than the libraries they point into.
    // rust: let (library, voice) = unsafe {
            // `FliteLibrary.loadNative`: the library and all its functions.
    // rust: let flite = load("flite")?;
    // rust: let init = function::<unsafe extern "C" fn() -> c_int>(&flite, b"flite_init\0")
    // rust: .map_err(failed("flite"))?;
    // rust: let synth_text = function(&flite, b"flite_synth_text\0").map_err(failed("flite"))?;
    // rust: let utt_wave = function(&flite, b"utt_wave\0").map_err(failed("flite"))?;
    // rust: let play_wave = function(&flite, b"play_wave\0").map_err(failed("flite"))?;
    // rust: let wave_rescale = function(&flite, b"cst_wave_rescale\0").map_err(failed("flite"))?;
    // rust: let delete_utterance =
    // rust: function(&flite, b"delete_utterance\0").map_err(failed("flite"))?;
            // `CmuUsKal16.loadNative`.
    // rust: let cmu_us_kal16 = load("flite_cmu_us_kal16")?;
    // rust: let register = function::<unsafe extern "C" fn(*const c_char) -> *mut Voice>(
    // rust: &cmu_us_kal16,
    // rust: b"register_cmu_us_kal16\0",
    // rust: )
    // rust: .map_err(failed("flite_cmu_us_kal16"))?;
    // rust: let library = FliteLibrary {
    // rust: _flite: flite,
    // rust: _cmu_us_kal16: cmu_us_kal16,
    // rust: synth_text,
    // rust: utt_wave,
    // rust: play_wave,
    // rust: wave_rescale,
    // rust: delete_utterance,
}
    // rust: let rc = init();
    // rust: if rc != 0 {
    // rust: return Err(format!("flite returned code {rc}"));
}
    // rust: let voice = register(std::ptr::null());
    // rust: if voice.is_null() {
    // rust: return Err("flite_cmu_us_kal16 failed to register".into());
}
    // rust: (library, VoicePtr(voice))
}
    // rust: let batch = Arc::new(AtomicI32::new(0));
    // rust: let (pieces, queue) = mpsc::channel();
    // rust: let current = Arc::clone(&batch);
    // rust: std::thread::Builder::new()
    // rust: .name("Narrator #0".into())
    // rust: .spawn(move || play(&library, &voice, &current, &queue))
    // rust: .map_err(|e| format!("Failed to start the narrator's player: {e}"))?;
    // rust: Ok(Flite { pieces, batch })
}
}

/// `NativeLibrary.getInstance(name)`: `lib<name>.so`, then the versioned
/// name the runtime packages ship (`libflite1` has no unversioned link),
/// opened with JNA's flags (`RTLD_LAZY | RTLD_GLOBAL`).
pub fn load(name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut error = None;
    // rust: for file in [format!("lib{name}.so"), format!("lib{name}.so.1")] {
        // SAFETY: flite's libraries run no initialisers that need more than
        // the C runtime.
    // rust: match unsafe { Library::open(Some(&file), RTLD_LAZY | RTLD_GLOBAL) } {
    // rust: Ok(library) => return Ok(library),
    // rust: Err(e) => error = Some(e),
}
}
    // rust: Err(format!(
    // rust: "Failed to load library {name}: {}",
    // rust: error.map_or_else(String::new, |e| e.to_string())
    // rust: ))
}

/// JNA's `Native.register` fails as the library does when a function is
/// missing.
pub fn failed(name: *'static str) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: move |e| format!("Failed to load library {name}: {e}")
}

/// A function of `library`, as a plain pointer.
///
/// # Safety
/// `T` must be the function's type, and the pointer must not outlive
/// `library`.
    // rust: unsafe fn function<T: Copy>(library: &Library, symbol: &[u8]) -> Result<T, libloading::Error> {
    // SAFETY: the caller's.
    // rust: unsafe { library.get::<T>(symbol).map(|f| *f) }
}

/// The executor: each piece still in the current batch is synthesised,
/// rescaled to `(int)(volume * 65536.0F)` unless the volume is 1, and played
/// to the end (`play_wave` blocks), so a `clear` lets the piece being said
/// finish and skips the rest.
pub fn play(library: *FliteLibrary, voice: *VoicePtr, batch: *AtomicI32, queue: *Receiver<Piece>) void {
}
    // rust: for piece in queue {
    // rust: if piece.batch < batch.load(Ordering::SeqCst) {
    // rust: continue;
}
        // SAFETY: the functions are flite's, alive with `library`; the text
        // is a C string that outlives the call; the wave belongs to the
        // utterance, which is deleted last. A null utterance or wave (flite
        // failed to synthesise) is not handed on.
    // rust: unsafe {
    // rust: let utterance = (library.synth_text)(piece.text.as_ptr(), voice.0);
    // rust: if utterance.is_null() {
    // rust: continue;
}
    // rust: let wave = (library.utt_wave)(utterance);
    // rust: if !wave.is_null() {
    // rust: if piece.volume != 1.0 {
    // rust: (library.wave_rescale)(wave, (piece.volume * 65536.0) as c_int);
}
    // rust: (library.play_wave)(wave);
}
    // rust: (library.delete_utterance)(utterance);
}
}
}

    // rust: impl super::Speech for Flite {
    /// Interrupting clears first; the message is split at punctuation and
    /// each piece queued in the batch current when `say` was called.
pub fn say(self: *Self, message: []const u8, interrupt: bool, volume: f32) void {
}
    // rust: if interrupt {
    // rust: self.clear();
}
    // rust: let batch = self.batch.load(Ordering::SeqCst);
    // rust: for unit in units(message) {
            // JNA hands flite the string up to its first NUL.
    // rust: let text = unit.split('\0').next().unwrap_or_default();
    // rust: let text = CString::new(text).expect("cut at the first NUL");
    // rust: let _ = self.pieces.send(Piece {
    // rust: text,
    // rust: batch,
    // rust: volume,
    // rust: });
}
}
    /// `executionBatch.incrementAndGet()`: the piece being said finishes, the
    /// queued ones are skipped.
pub fn clear(self: *Self) void {
}
    // rust: self.batch.fetch_add(1, Ordering::SeqCst);
}
}

    // rust: impl Drop for Flite {
    /// `destroy`: `executor.shutdownNow()` drops the queued pieces; the one
    /// being played finishes, then the player thread ends with the queue.
pub fn drop(self: *Self) void {
}
    // rust: self.batch.fetch_add(1, Ordering::SeqCst);
}
}
