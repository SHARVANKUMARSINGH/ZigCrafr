//! Transpiled from Horizon Rust crate
package horizon_narrator_lib

import "core:fmt"
import "core:mem"
import "core:math"

// The narrator: vanilla's text-to-speech (`GameNarrator` over
// `com.mojang.text2speech.Narrator` 1.19.12) and the screen narration state
// (`ScreenNarrationCollector` and `Screen`'s narration timing, [`screen`]).
//
// One narrator per process, as `Minecraft.narrator`: [`init`] opens the
// platform's speech on its own thread (SAPI on Windows, NSSpeechSynthesizer
// on macOS, flite on Linux, as text2speech does), and the free functions are
// `GameNarrator`'s methods. Speaking never blocks the caller: the speech
// thread takes the calls in order. Until [`init`] (the dedicated server,
// tests) the narrator is inactive, as text2speech's `Narrator.EMPTY`.
//
// The game keeps the narrator's [`Status`] and voice volume in step with its
// options ([`set_status`], [`set_volume`]); the narrator reads them where
// `GameNarrator` reads `options.narrator()` and
// `getFinalSoundSourceVolume(VOICE)`.

    // rust: pub mod screen;
    // rust: mod speech;

// use std::collections::VecDeque;
// use std::sync::{Mutex, MutexGuard};

// `NarratorStatus`, by its `options.txt` id.
Status :: enum {
    Off,
    All,
    Chat,
    System,
}

    // rust: impl Status {
ALL :: [Status::Off, Status::All, Status::Chat, Status::System]

    // `byId`: `ByIdMap.continuous` with `OutOfBoundsStrategy.WRAP`.
by_id :: proc(id: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::ALL[id.rem_euclid(4) as usize]
}
id :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self as i32
}
    // The status the narrator hotkey moves to (`byId(getId() + 1)`).
next :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::by_id(self.id() + 1)
}
    // The translation key of `getName`.
key :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Status::Off => "options.narrator.off",
    // rust: Status::All => "options.narrator.all",
    // rust: Status::Chat => "options.narrator.chat",
    // rust: Status::System => "options.narrator.system",
}
}
should_narrate_chat :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Status::All | Status::Chat)
}
should_narrate_system :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Status::All | Status::System)
}
should_narrate_system_or_chat :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Status::All | Status::System | Status::Chat)
}
}

// What `GameNarrator` hands its `Narrator`: the speech thread, or a test's
// recorder.
    // rust: pub trait Sink: Send {
say :: proc(self: ^Self, message: string, interrupt: bool, volume: f32) {
}
clear :: proc(self: ^Self) {
}
    // `Narrator.active`: false for `Narrator.EMPTY`, which a platform without
    // speech (or whose speech failed to open) gets.
active :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
}

// How many narrated messages [`recent`] keeps.
RECENT :: 32

// `GameNarrator`, with its options read from [`Status`] and the volume the
// game sets.
GameNarrator :: struct {
    sink: Maybe(^dyn Sink),
    status: Status,
    volume: f32,
    // The messages the narrator was asked to say, oldest first (vanilla only
    // logs them in its IDE): the control socket and tests read them.
    recent: VecDeque<string>,
}

    // rust: impl GameNarrator {
    // rust: pub const fn new() -> Self {
    // rust: Self {
    // rust: sink: None,
    // rust: status: Status::Off,
    // rust: volume: 1.0,
    // rust: recent: VecDeque::new(),
}
}
with_sink :: proc(sink: ^dyn Sink) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: sink: Some(sink),
    // rust: ..Self::new()
}
}
set_sink :: proc(self: ^Self, sink: ^dyn Sink) {
}
    // rust: self.sink = Some(sink);
}
set_status :: proc(self: ^Self, status: Status) {
}
    // rust: self.status = status;
}
status :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.status
}
    // `getFinalSoundSourceVolume(SoundSource.VOICE)`: master times voice.
set_volume :: proc(self: ^Self, volume: f32) {
}
    // rust: self.volume = volume;
}

say_chat_queued :: proc(self: ^Self, message: string) {
}
    // rust: if self.status.should_narrate_chat() {
    // rust: self.narrate_not_interrupting(message);
}
}
say_system_chat_queued :: proc(self: ^Self, message: string) {
}
    // rust: if self.status.should_narrate_system_or_chat() {
    // rust: self.narrate_not_interrupting(message);
}
}
say_system_queued :: proc(self: ^Self, message: string) {
}
    // rust: if self.status.should_narrate_system() {
    // rust: self.narrate_not_interrupting(message);
}
}
narrate_not_interrupting :: proc(self: ^Self, message: string) {
}
    // rust: if !message.is_empty() {
    // rust: self.log(message);
    // rust: self.narrate(message, false);
}
}
    // `saySystemNow`: what is said now cuts off whatever is being said.
say_system_now :: proc(self: ^Self, message: string) {
}
    // rust: if self.status.should_narrate_system() && !message.is_empty() {
    // rust: self.log(message);
    // rust: if self.is_active() {
    // rust: if let Some(sink) = &mut self.sink {
    // rust: sink.clear();
}
    // rust: self.narrate(message, true);
}
}
}
narrate :: proc(self: ^Self, message: string, interrupt: bool) {
}
    // rust: let volume = self.volume;
    // rust: if let Some(sink) = &mut self.sink {
    // rust: sink.say(message, interrupt, volume);
}
}
log :: proc(self: ^Self, message: string) {
}
    // rust: if self.recent.len() == RECENT {
    // rust: self.recent.pop_front();
}
    // rust: self.recent.push_back(message.to_owned());
}

    // `updateNarratorStatus`, once the option holds `status`: clears, then
    // says `announcement` (`options.narrator` + " : " + the status's name)
    // whatever the status, `Off` included. The toast that goes with it is
    // the caller's ([`toast`]).
update_status :: proc(self: ^Self, status: Status, announcement: string) {
}
    // rust: self.status = status;
    // rust: self.clear();
    // rust: self.log(announcement);
    // rust: self.narrate(announcement, true);
}

is_active :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sink.as_mut().is_some_and(|sink| sink.active())
}
clear :: proc(self: ^Self) {
}
    // rust: if self.status != Status::Off && self.is_active() {
    // rust: if let Some(sink) = &mut self.sink {
    // rust: sink.clear();
}
}
}
recent :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.recent.iter().cloned().collect()
}
}

    // rust: impl Default for GameNarrator {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new()
}
}

// The toast `updateNarratorStatus` shows (`SystemToastId.NARRATOR_TOGGLE`):
// translation keys of its title and of its message, if it has one.
toast :: proc(status: Status, active: bool) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if !active {
    // rust: (
    // rust: "narrator.toast.disabled",
    // rust: Some("options.narrator.notavailable"),
    // rust: )
    // rust: } else if status == Status::Off {
    // rust: ("narrator.toast.disabled", None)
    // rust: } else {
    // rust: ("narrator.toast.enabled", Some(status.key()))
}
}

NARRATOR :: Mutex::new(GameNarrator::new())

narrator :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: NARRATOR.lock().unwrap_or_else(|e| e.into_inner())
}

// `new GameNarrator`: opens the platform's speech on its own thread. With
// `HORIZON_NO_AUDIO` set the narrator is active but silent, so scripted runs
// still narrate into [`recent`]. Calling it again does nothing.
init :: proc() {
}
    // rust: let mut narrator = narrator();
    // rust: if narrator.sink.is_none() {
    // rust: narrator.sink = Some(Box::new(speech::Thread::spawn(
    // rust: std::env::var_os("HORIZON_NO_AUDIO").is_some(),
    // rust: )));
}
}

// `destroy`: stops speaking and closes the speech.
destroy :: proc() {
}
    // rust: if let Some(mut sink) = narrator().sink.take() {
    // rust: sink.clear();
}
}

set_status :: proc(status: Status) {
}
    // rust: narrator().set_status(status);
}
status :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: narrator().status()
}
set_volume :: proc(volume: f32) {
}
    // rust: narrator().set_volume(volume);
}
is_active :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: narrator().is_active()
}
say_chat_queued :: proc(message: string) {
}
    // rust: narrator().say_chat_queued(message);
}
say_system_chat_queued :: proc(message: string) {
}
    // rust: narrator().say_system_chat_queued(message);
}
say_system_queued :: proc(message: string) {
}
    // rust: narrator().say_system_queued(message);
}
say_system_now :: proc(message: string) {
}
    // rust: narrator().say_system_now(message);
}
update_status :: proc(status: Status, announcement: string) {
}
    // rust: narrator().update_status(status, announcement);
}
clear :: proc() {
}
    // rust: narrator().clear();
}
// The last messages the narrator was asked to say, oldest first.
recent :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: narrator().recent()
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::Arc;

Call :: enum {
    Say(String, bool, f32),
    Clear,
}

Recorder :: struct {
    calls: ^Mutex<[dynamic]Call>,
    inactive: bool,
}
    // rust: impl Recorder {
take :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: std::mem::take(&mut self.calls.lock().unwrap())
}
}
    // rust: impl Sink for Recorder {
say :: proc(self: ^Self, message: string, interrupt: bool, volume: f32) {
}
    // rust: self.calls
    // rust: .lock()
    // rust: .unwrap()
    // rust: .push(Call::Say(message.into(), interrupt, volume));
}
clear :: proc(self: ^Self) {
}
    // rust: self.calls.lock().unwrap().push(Call::Clear);
}
active :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.inactive
}
}

narrator :: proc(status: Status) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let recorder = Recorder::default();
    // rust: let mut n = GameNarrator::with_sink(Box::new(recorder.clone()));
    // rust: n.set_status(status);
    // rust: (n, recorder)
}

statuses_wrap_through_their_ids_as_the_hotkey_cycles_them :: proc() {
}
    // rust: assert_eq!(Status::by_id(0), Status::Off);
    // rust: assert_eq!(Status::by_id(3), Status::System);
    // rust: assert_eq!(Status::by_id(4), Status::Off);
    // rust: assert_eq!(Status::by_id(-1), Status::System);
    // rust: assert_eq!(Status::Off.next(), Status::All);
    // rust: assert_eq!(Status::System.next(), Status::Off);
}

each_status_narrates_its_own_kinds_of_message :: proc() {
}
    // rust: for (status, chat, system, either) in [
    // rust: (Status::Off, false, false, false),
    // rust: (Status::All, true, true, true),
    // rust: (Status::Chat, true, false, true),
    // rust: (Status::System, false, true, true),
    // rust: ] {
    // rust: assert_eq!(status.should_narrate_chat(), chat);
    // rust: assert_eq!(status.should_narrate_system(), system);
    // rust: assert_eq!(status.should_narrate_system_or_chat(), either);
}
}

queued_messages_wait_their_turn_and_empty_ones_are_skipped :: proc() {
}
    // rust: let (mut n, r) = narrator(Status::Chat);
    // rust: n.set_volume(0.5);
    // rust: n.say_chat_queued("<Steve> hi");
    // rust: n.say_system_queued("not in chat mode");
    // rust: n.say_system_chat_queued("Steve joined the game");
    // rust: n.say_chat_queued("");
    // rust: assert_eq!(
    // rust: r.take(),
    // rust: vec![
    // rust: Call::Say("<Steve> hi".into(), false, 0.5),
    // rust: Call::Say("Steve joined the game".into(), false, 0.5),
    // rust: ]
    // rust: );
    // rust: assert_eq!(n.recent(), ["<Steve> hi", "Steve joined the game"]);
}

saying_now_clears_and_interrupts_only_for_system_narration :: proc() {
}
    // rust: let (mut n, r) = narrator(Status::System);
    // rust: n.say_system_now("Options");
    // rust: assert_eq!(
    // rust: r.take(),
    // rust: vec![Call::Clear, Call::Say("Options".into(), true, 1.0)]
    // rust: );
    // rust: n.set_status(Status::Chat);
    // rust: n.say_system_now("Options");
    // rust: assert!(r.take().is_empty());
}

an_inactive_narrator_logs_but_says_nothing :: proc() {
}
    // rust: let recorder = Recorder {
    // rust: inactive: true,
    // rust: ..Default::default()
}
    // rust: let mut n = GameNarrator::with_sink(Box::new(recorder.clone()));
    // rust: n.set_status(Status::All);
    // rust: n.say_system_now("Options");
    // rust: n.clear();
    // rust: assert!(recorder.take().is_empty());
    // rust: assert_eq!(n.recent(), ["Options"]);
    // rust: assert!(!n.is_active());
    // rust: assert!(!GameNarrator::new().is_active());
}

a_status_change_is_announced_even_when_turning_it_off :: proc() {
}
    // rust: let (mut n, r) = narrator(Status::All);
    // rust: n.update_status(Status::Off, "Narrator : OFF");
        // clear() reads the new status: off, so nothing is cleared first.
    // rust: assert_eq!(
    // rust: r.take(),
    // rust: vec![Call::Say("Narrator : OFF".into(), true, 1.0)]
    // rust: );
    // rust: n.update_status(Status::All, "Narrator : Narrates All");
    // rust: assert_eq!(
    // rust: r.take(),
    // rust: vec![
    // rust: Call::Clear,
    // rust: Call::Say("Narrator : Narrates All".into(), true, 1.0)
    // rust: ]
    // rust: );
}

the_toggle_toast_names_the_status_or_why_there_is_none :: proc() {
}
    // rust: assert_eq!(
    // rust: toast(Status::All, false),
    // rust: (
    // rust: "narrator.toast.disabled",
    // rust: Some("options.narrator.notavailable")
    // rust: )
    // rust: );
    // rust: assert_eq!(toast(Status::Off, true), ("narrator.toast.disabled", None));
    // rust: assert_eq!(
    // rust: toast(Status::Chat, true),
    // rust: ("narrator.toast.enabled", Some("options.narrator.chat"))
    // rust: );
}
}
