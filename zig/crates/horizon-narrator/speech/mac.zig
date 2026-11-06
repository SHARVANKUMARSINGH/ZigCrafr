//! Transpiled from Horizon Rust crate
//! Module: horizon-narrator_mac
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `NarratorMac`: AppKit's `NSSpeechSynthesizer`, the voice and rate chosen in
//! the system's spoken content settings, with a queue of its own.
//!
//! Vanilla is the synthesizer's delegate: `speechSynthesizer:didFinishSpeaking:`
//! starts the next queued message. AppKit delivers that callback through the
//! run loop of the thread that speaks (the game's main thread in vanilla); the
//! speech thread only turns its run loop over in `idle`, so `idle` also asks the synthesizer every 50 ms whether
//! it still speaks and runs `didFinishSpeaking` once it no longer does.
//! `stopSpeaking` ends the speech too, and vanilla's delegate then fires as
//! well (later, from the run loop), so after an interrupt or a `clear` the
//! next queued message starts at the next `idle`, in the queue's order: an
//! interrupting message is queued behind the ones already waiting while the
//! cut-off speech has not been reported finished.
//!
//! `crashed` is not ported: vanilla stops narrating for good when a message to
//! the synthesizer throws through its Java bridge. These messages raise no
//! Objective-C exception; one would end the game, as objc2 catches them only
//! with its C exception helper.

// use objc2::rc::{Retained, autoreleasepool};
// use objc2::{AnyThread, msg_send};
// use objc2_app_kit::NSSpeechSynthesizer;
// use objc2_foundation::{NSDate, NSDefaultRunLoopMode, NSRunLoop, NSString};

// use std::collections::VecDeque;

    // rust: pub(super) struct Synthesizer {
    // rust: synth: Retained<NSSpeechSynthesizer>,
    /// `queue`: the messages waiting for the one being said.
    // rust: queue: VecDeque<String>,
    /// `speaking`: a message was started and its `didFinishSpeaking` has not
    /// run yet.
    // rust: speaking: bool,
}

    // rust: impl Synthesizer {
    /// `NSSpeechSynthesizer alloc` then `init`: the default voice.
    // rust: pub(super) fn open() -> Result<Synthesizer, String> {
        // SAFETY: `init` takes no arguments and returns the initialised
        // synthesizer, or nil when it could not be created.
    // rust: let synth: Option<Retained<NSSpeechSynthesizer>> =
    // rust: unsafe { msg_send![NSSpeechSynthesizer::alloc(), init] };
    // rust: let synth = synth.ok_or("Failed to create `NSSpeechSynthesizer`")?;
    // rust: Ok(Synthesizer {
    // rust: synth,
    // rust: queue: VecDeque::new(),
    // rust: speaking: false,
    // rust: })
}

    /// `startSpeakingString:`, whose answer vanilla ignores.
pub fn start_speaking(self: *Self, message: []const u8) void {
}
    // rust: self.synth.startSpeakingString(&NSString::from_str(message));
}

    /// `speechSynthesizer:didFinishSpeaking:`: the next queued message, or
    /// nothing left to say.
pub fn did_finish_speaking(self: *Self) void {
}
    // rust: match self.queue.pop_front() {
    // rust: Some(next) => self.start_speaking(&next),
    // rust: None => self.speaking = false,
}
}
}

    // rust: impl super::Speech for Synthesizer {
    /// The volume is set first; interrupting stops what is being said but
    /// keeps the queue; the message waits its turn while one is being said.
pub fn say(self: *Self, message: []const u8, interrupt: bool, volume: f32) void {
}
    // rust: autoreleasepool(|_| {
    // rust: self.synth.setVolume(volume);
    // rust: if interrupt {
    // rust: self.synth.stopSpeaking();
}
    // rust: if self.speaking {
    // rust: self.queue.push_back(message.to_owned());
    // rust: } else {
    // rust: self.speaking = true;
    // rust: self.start_speaking(message);
}
    // rust: });
}
    /// Empties the queue and stops what is being said.
pub fn clear(self: *Self) void {
}
    // rust: autoreleasepool(|_| {
    // rust: self.queue.clear();
    // rust: self.synth.stopSpeaking();
    // rust: });
}
    /// The delegate's callback, polled: the speech that was started ended.
pub fn idle(self: *Self) void {
}
    // rust: autoreleasepool(|_| {
            // Lets AppKit deliver what the synthesizer posts to this thread's
            // run loop (vanilla's runs on the game's main thread), without
            // waiting.
            // SAFETY: the current thread's run loop, run in the default mode
            // until a date already past: it handles what is ready and returns.
    // rust: unsafe {
    // rust: NSRunLoop::currentRunLoop()
    // rust: .runMode_beforeDate(NSDefaultRunLoopMode, &NSDate::distantPast());
}
    // rust: if self.speaking && !self.synth.isSpeaking() {
    // rust: self.did_finish_speaking();
}
    // rust: });
}
}
