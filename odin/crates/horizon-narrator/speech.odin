//! Transpiled from Horizon Rust crate
package horizon_narrator_speech

import "core:fmt"
import "core:mem"
import "core:math"

// `com.mojang.text2speech.Narrator`: the platform's speech, opened and driven
// on a thread of its own so the game never waits on it.
// use std::sync::mpsc::{self, Receiver, Sender};

    // rust: mod linux;
    // rust: mod linux_split;
    // rust: mod mac;
    // rust: mod windows;

// A platform's speech (`NarratorWindows`, `NarratorMac`, `NarratorLinux`),
// used only on the thread that opened it.
    // rust: pub trait Speech {
    // `say`: `interrupt` drops what is queued and cuts off what is being said.
say :: proc(self: ^Self, message: string, interrupt: bool, volume: f32) {
}
    // `clear`: drops what is queued and stops speaking.
clear :: proc(self: ^Self) {
}
    // Called every 50 ms on the speech thread, for speech that keeps its own
    // queue.
idle :: proc(self: ^Self) {
}
}

// `Narrator.getNarrator`: the platform's speech, or why there is none
// (`Narrator.EMPTY`).
open :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: return windows::Sapi::open().map(|s| Box::new(s) as Box<dyn Speech>);
    // rust: return mac::Synthesizer::open().map(|s| Box::new(s) as Box<dyn Speech>);
    // rust: return linux::Flite::open().map(|s| Box::new(s) as Box<dyn Speech>);
    // rust: Err(format!("Unsupported platform {}", std::env::consts::OS))
}

// Speech that is there but makes no sound (`HORIZON_NO_AUDIO`).
Silent :: struct {
    // rust: impl Speech for Silent {
say :: proc(self: ^Self, _: string, _: bool, _: f32) {
}
clear :: proc(self: ^Self) {
}
}

Command :: enum {
    Say(String, bool, f32),
    Clear,
}

// The game's handle on the speech thread.
    // rust: pub(crate) struct Thread {
    // rust: commands: Sender<Command>,
    // Whether the speech opened, until [`super::Sink::active`] first asks.
    // rust: opened: Option<Receiver<bool>>,
    // rust: active: bool,
}

    // rust: impl Thread {
    // rust: pub(crate) fn spawn(silent: bool) -> Thread {
    // rust: let (commands, receive) = mpsc::channel();
    // rust: let (opened, ready) = mpsc::channel();
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Narrator".into())
    // rust: .spawn(move || run(silent, &opened, &receive));
    // rust: if let Err(e) = spawned {
    // rust: log::error!("Error while loading the narrator: {e}");
}
    // rust: Thread {
    // rust: commands,
    // rust: opened: Some(ready),
    // rust: active: false,
}
}
}

run :: proc(silent: bool, opened: ^Sender<bool>, commands: ^Receiver<Command>) {
}
    // rust: let mut speech: Box<dyn Speech> = if silent {
    // rust: Box::new(Silent)
    // rust: } else {
    // rust: match open() {
    // rust: Ok(speech) => speech,
    // rust: Err(e) => {
    // rust: log::error!("Error while loading the narrator: {e}");
    // rust: let _ = opened.send(false);
    // rust: return;
}
}
}
    // rust: let _ = opened.send(true);
IDLE :: std::time::Duration::from_millis(50)
    // rust: let mut last_idle = std::time::Instant::now();
    // rust: loop {
    // rust: match commands.recv_timeout(IDLE.saturating_sub(last_idle.elapsed())) {
    // rust: Ok(Command::Say(message, interrupt, volume)) => speech.say(&message, interrupt, volume),
    // rust: Ok(Command::Clear) => speech.clear(),
    // rust: Err(mpsc::RecvTimeoutError::Timeout) => {}
            // `destroy`: the game dropped its handle.
    // rust: Err(mpsc::RecvTimeoutError::Disconnected) => {
    // rust: speech.clear();
    // rust: return;
}
}
        // Every 50 ms, however many commands arrive in between.
    // rust: if last_idle.elapsed() >= IDLE {
    // rust: last_idle = std::time::Instant::now();
    // rust: speech.idle();
}
}
}

    // rust: impl super::Sink for Thread {
say :: proc(self: ^Self, message: string, interrupt: bool, volume: f32) {
}
    // rust: let _ = self
    // rust: .commands
    // rust: .send(Command::Say(message.to_owned(), interrupt, volume));
}
clear :: proc(self: ^Self) {
}
    // rust: let _ = self.commands.send(Command::Clear);
}
    // Waits for the speech to open the first time it is asked (vanilla opens
    // it in `Minecraft`'s constructor, before anything asks).
active :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(opened) = self.opened.take() {
    // rust: self.active = opened.recv().unwrap_or(false);
}
    // rust: self.active
}
}
