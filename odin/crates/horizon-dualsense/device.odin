//! Transpiled from Horizon Rust crate
package horizon_dualsense_device

import "core:fmt"
import "core:mem"
import "core:math"

// The pad over hidapi, and the thread that writes to it: writes block (a Bluetooth report can
// take milliseconds), so the game only hands over what the pad should do.
// use crate::{DEFAULT_LIGHTBAR, Output, PLAYER_1, Vibration, is_dualsense};
// use crate::{TRIGGER_OFF, TriggerEffect};
// use hidapi::{BusType, HidApi, HidDevice, HidResult};
// use std::sync::Arc;
// use std::sync::atomic::AtomicBool;
// use std::sync::atomic::{AtomicU8, Ordering};
// use std::sync::mpsc::Sender;
// use std::sync::mpsc::{self, RecvTimeoutError};
// use std::thread::JoinHandle;
// use std::time::Duration;
// use std::time::Instant;

Transport :: enum {
    Usb,
    Bluetooth,
}

// An open DualSense.
DualSense :: struct {
    device: HidDevice,
    transport: Transport,
    vibration: Vibration,
    // The Bluetooth report's sequence number.
    seq: u8,
}

// Whether a pad on Bluetooth may be written to. Any output report, and even reading a feature
// report, switches it to its full input report (0x31) until it is turned off (SDL_hints.h,
// `SDL_HINT_JOYSTICK_ENHANCED_REPORTS`; SDL_hidapi_ps5.c). Linux's `hid-playstation` has
// already switched it and reads that report, but gilrs on macOS and Windows parses the simple
// report 0x01 and would stop seeing the pad: there it waits for `HORIZON_DUALSENSE_BT=1`.
bluetooth_allowed :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: cfg!(target_os = "linux") || std::env::var_os("HORIZON_DUALSENSE_BT").is_some_and(|v| v == "1")
}

    // rust: impl DualSense {
    // The first DualSense hidapi lists, USB before Bluetooth (as SDL); `None` when there is
    // none, an error when it can't be opened (Linux without access to its hidraw node).
open :: proc(api: ^HidApi) -> O {
    // Ported from Horizon
    return {}
}
SKIPPED :: AtomicBool::new(false)
    // rust: let bluetooth = |d: &&hidapi::DeviceInfo| matches!(d.bus_type(), BusType::Bluetooth);
    // rust: let pads = api
    // rust: .device_list()
    // rust: .filter(|d| is_dualsense(d.vendor_id(), d.product_id()));
    // rust: let (wireless, wired): (Vec<_>, Vec<_>) = pads.partition(bluetooth);
    // rust: let info = match wired.first() {
    // rust: Some(info) => info,
    // rust: None if bluetooth_allowed() => wireless.first()?,
    // rust: None => {
    // rust: if !wireless.is_empty() && !SKIPPED.swap(true, Ordering::Relaxed) {
    // rust: log::info!("Horizon: no DualSense output over Bluetooth on this system");
}
    // rust: return None;
}
}
    // rust: let transport = match info.bus_type() {
    // rust: BusType::Bluetooth => Transport::Bluetooth,
    // rust: _ => Transport::Usb,
}
    // rust: Some(info.open_device(api).map(|device| {
    // rust: let mut firmware = [0; 64];
    // rust: firmware[0] = 0x20;
    // rust: let version = match device.get_feature_report(&mut firmware) {
    // rust: Ok(n) if n >= 46 => Some(u16::from_le_bytes([firmware[44], firmware[45]])),
    // rust: _ => None,
}
    // rust: let vibration = Vibration::of(info.product_id(), version);
    // rust: DualSense {
    // rust: device,
    // rust: transport,
    // rust: vibration,
    // rust: seq: 0,
}
    // rust: }))
}

transport :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: self.transport
}

write :: proc(self: ^Self, out: ^Output) -> H {
    // Ported from Horizon
    return {}
}
    // rust: match self.transport {
    // rust: Transport::Usb => self.device.write(&out.usb(self.vibration))?,
    // rust: Transport::Bluetooth => {
    // rust: let report = out.bluetooth(self.vibration, self.seq);
    // rust: self.seq = (self.seq + 1) & 0x0f;
    // rust: self.device.write(&report)?
}
}
    // rust: Ok(())
}

    // An input report (USB 0x01, Bluetooth 0x31), waiting up to `millis` (-1: forever).
read :: proc(self: ^Self, buf: []u8, millis: i32) -> H {
    // Ported from Horizon
    return {}
}
    // rust: self.device.read_timeout(buf, millis)
}
}

// What the pad should show while nothing else is asked: the triggers' effects (left, right),
// the lightbar and the player LEDs (`None`: the pad's own).
State :: struct {
    triggers: [TriggerEffect,
    lightbar: Option<[u8,
    player_leds: Maybe(u8),
}

    // rust: impl Default for State {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: State {
    // rust: triggers: [TRIGGER_OFF; 2],
    // rust: lightbar: None,
    // rust: player_leds: None,
}
}
}

// A vibration: the motors' levels (left, right), each for a while, in order.
    // rust: pub type Rumble = Vec<([u8; 2], Duration)>;

// On iOS no thread reads the queue (the Link never opens); the variants stay so the
// Link's API is the same everywhere.
Message :: enum {
    State(State),
    Rumble(Rumble),
    Scan,
}

// The output thread. Dropping it frees the triggers and stops the motors before it ends; on
// iOS there is none (no hidapi backend) and the Link stays closed.
Link :: struct {
    tx: Maybe(Sender<Message)>,
    // 0: no pad open, else 1 + the transport.
    open: ^AtomicU8,
    thread: Maybe(JoinHandle<())>,
}

    // rust: impl Link {
    // Start the thread and look for a DualSense.
start :: proc() -> L {
    // Ported from Horizon
    return {}
}
    // rust: let (tx, rx) = mpsc::channel();
    // rust: let open = Arc::new(AtomicU8::new(0));
    // rust: let shown = open.clone();
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("dualsense".into())
    // rust: .spawn(move || Writer::new(shown).run(rx))
    // rust: .map_err(|e| log::warn!("Horizon: DualSense output: {e}"))
    // rust: .ok();
    // rust: Link {
    // rust: tx: Some(tx),
    // rust: open,
    // rust: thread,
}
}

    // No output on iOS: hidapi has no backend there. The Link never opens.
start :: proc() -> L {
    // Ported from Horizon
    return {}
}
    // rust: Link {
    // rust: tx: None,
    // rust: open: Arc::new(AtomicU8::new(0)),
    // rust: thread: None,
}
}

    // The pad's transport while one is open and taking reports.
open :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.open.load(Ordering::Relaxed) {
    // rust: 1 => Some(Transport::Usb),
    // rust: 2 => Some(Transport::Bluetooth),
    // rust: _ => None,
}
}

    // Look for the pad again (a controller connected).
scan :: proc(self: ^Self) {
}
    // rust: self.send(Message::Scan);
}

    // What the pad shows from now on; sent again whenever it reconnects.
set :: proc(self: ^Self, state: State) {
}
    // rust: self.send(Message::State(state));
}

    // Play a vibration, replacing the one playing.
rumble :: proc(self: ^Self, rumble: Rumble) {
}
    // rust: self.send(Message::Rumble(rumble));
}

send :: proc(self: ^Self, message: Message) {
}
    // rust: if let Some(tx) = &self.tx {
    // rust: let _ = tx.send(message);
}
}
}

    // rust: impl Drop for Link {
drop :: proc(self: ^Self) {
}
        // Closing the channel ends the thread, which releases the pad first.
    // rust: self.tx = None;
    // rust: if let Some(thread) = self.thread.take() {
    // rust: let _ = thread.join();
}
}
}

// Looks for the pad this many more times, a second apart, after a scan finds nothing (its
// hidraw node may appear after the controller does).
SCAN_TRIES :: 5

Writer :: struct {
    api: Maybe(HidApi),
    pad: Maybe(^dyn Handle),
    open: ^AtomicU8,
    state: State,
    // What the pad was last sent; `None` after (re)opening.
    sent: Option<(State,
    // Whether the lights may be set: over Bluetooth, not before the pad's connection
    // animation is over, or it paints over them.
    lights: Lights,
    rumble: Rumble,
    // When the vibration's current step ends.
    step_end: Maybe(Instant),
    scans_left: u32,
    next_scan: Instant,
}

Lights :: enum {
    // Over Bluetooth, until the pad's clock says its animation is over (or this long after
    // opening, when it sends no clock).
    Waiting(Instant),
    // They may be set, after the reset report that hands them to the host.
    Ready,
    Reset,
}

// The pad's sensor clock once its Bluetooth connection animation is over (SDL_hidapi_ps5.c's
// `HIDAPI_DriverPS5_CheckPendingLEDReset`).
ANIMATION_OVER :: 10_200_000

// The sensor clock of a Bluetooth input report 0x31: its state block starts at byte 2 and
// holds the clock at 27..31, little-endian (SDL's `PS5StatePacketCommon_t`, the kernel's
// `dualsense_input_report`).
bluetooth_clock :: proc(report: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match report {
    // rust: [0x31, _, state @ ..] if state.len() >= 31 => {
    // rust: Some(u32::from_le_bytes(state[27..31].try_into().ok()?))
}
    // rust: _ => None,
}
}

// What the writer needs from an open pad. It is a trait so the state machine can be tested
// without hardware: hidapi's Windows back end can crash inside `hid_write` once the device is
// gone, so every failure has to drop the handle.
    // rust: trait Handle: Send {
write :: proc(self: ^Self, out: ^Output) -> H {
    // Ported from Horizon
    return {}
}
read :: proc(self: ^Self, buf: []u8, millis: i32) -> H {
    // Ported from Horizon
    return {}
}
}

    // rust: impl Handle for DualSense {
write :: proc(self: ^Self, out: ^Output) -> H {
    // Ported from Horizon
    return {}
}
    // rust: DualSense::write(self, out)
}

read :: proc(self: ^Self, buf: []u8, millis: i32) -> H {
    // Ported from Horizon
    return {}
}
    // rust: DualSense::read(self, buf, millis)
}
}

    // rust: impl Writer {
new :: proc(open: ^AtomicU8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Writer {
    // rust: api: None,
    // rust: pad: None,
    // rust: open,
    // rust: state: State::default(),
    // rust: sent: None,
    // rust: lights: Lights::Ready,
    // rust: rumble: Vec::new(),
    // rust: step_end: None,
    // rust: scans_left: 1,
    // rust: next_scan: Instant::now(),
}
}

run :: proc(rx: mpsc::Receiver<Message>) {
}
    // rust: loop {
    // rust: let now = Instant::now();
    // rust: if self.pad.is_none() && self.scans_left > 0 && now >= self.next_scan {
    // rust: self.scan();
}
    // rust: let waiting = matches!(self.lights, Lights::Waiting(_)) && self.pad.is_some();
    // rust: let wake = [
    // rust: self.step_end,
    // rust: (self.pad.is_none() && self.scans_left > 0).then_some(self.next_scan),
    // rust: waiting.then(|| now + Duration::from_millis(250)),
    // rust: ]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .min();
    // rust: let message = match wake {
    // rust: Some(at) => rx.recv_timeout(at.saturating_duration_since(now)),
    // rust: None => rx.recv().map_err(|_| RecvTimeoutError::Disconnected),
}
    // rust: match message {
    // rust: Ok(Message::State(state)) => self.state = state,
    // rust: Ok(Message::Rumble(rumble)) => {
    // rust: self.rumble = rumble;
    // rust: self.rumble.reverse();
    // rust: self.step_end = None;
}
    // rust: Ok(Message::Scan) => {
                    // A pad that was unplugged while idle fails to read.
    // rust: if self.pad.is_some() {
    // rust: self.probe();
}
    // rust: if self.pad.is_none() {
    // rust: self.scans_left = SCAN_TRIES;
    // rust: self.next_scan = Instant::now();
}
    // rust: continue;
}
    // rust: Err(RecvTimeoutError::Timeout) => {}
    // rust: Err(RecvTimeoutError::Disconnected) => break,
}
    // rust: self.watch_animation();
    // rust: self.advance_rumble();
    // rust: self.flush();
}
    // rust: if self.pad.is_some() && self.probe() {
            // The lights go back to a host's defaults, if they were changed.
    // rust: let release = Output {
    // rust: lightbar: self.state.lightbar.map(|_| DEFAULT_LIGHTBAR),
    // rust: player_leds: self.state.player_leds.map(|_| PLAYER_1),
    // rust: ..Output::release()
}
    // rust: if let Some(pad) = self.pad.as_mut() {
    // rust: let _ = pad.write(&release);
}
}
}

scan :: proc(self: ^Self) {
}
    // rust: self.scans_left -= 1;
    // rust: self.next_scan = Instant::now() + Duration::from_secs(1);
    // rust: let api = match self.api.as_mut() {
    // rust: Some(api) => api.refresh_devices().map(|()| &*api),
    // rust: None => HidApi::new().map(|api| &*self.api.insert(api)),
}
    // rust: let found = match api {
    // rust: Ok(api) => DualSense::open(api),
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: DualSense output: {e}");
    // rust: None
}
}
    // rust: match found {
    // rust: Some(Ok(pad)) => {
    // rust: log::info!("DualSense output over {:?}", pad.transport());
    // rust: self.open
    // rust: .store(1 + pad.transport() as u8, Ordering::Relaxed);
    // rust: self.lights = match pad.transport() {
    // rust: Transport::Usb => Lights::Ready,
    // rust: Transport::Bluetooth => {
    // rust: Lights::Waiting(Instant::now() + Duration::from_secs(1))
}
}
    // rust: self.pad = Some(Box::new(pad));
    // rust: self.sent = None;
    // rust: self.scans_left = 0;
    // rust: self.flush();
}
    // rust: Some(Err(e)) => {
                // No access (Linux without a udev rule): vibration stays with gilrs.
    // rust: log::info!("Horizon: the DualSense can't be opened for output: {e}");
    // rust: self.scans_left = 0;
}
    // rust: None => {}
}
}

    // Over Bluetooth, read the pad's clock until its connection animation is over.
watch_animation :: proc(self: ^Self) {
}
    // rust: let (Lights::Waiting(deadline), Some(pad)) = (self.lights, self.pad.as_ref()) else {
    // rust: return;
}
    // rust: let mut buf = [0; 80];
    // rust: let mut clock = None;
    // rust: let mut failed = None;
    // rust: loop {
    // rust: match pad.read(&mut buf, 0) {
    // rust: Ok(0) => break,
    // rust: Ok(n) => clock = bluetooth_clock(&buf[..n]).or(clock),
    // rust: Err(e) => {
    // rust: failed = Some(e.to_string());
    // rust: break;
}
}
}
    // rust: if let Some(why) = failed {
    // rust: self.lost(&why);
    // rust: return;
}
    // rust: let over = match clock {
    // rust: Some(clock) => clock >= ANIMATION_OVER,
            // No full report to read the clock from: as SDL, take it as over.
    // rust: None => Instant::now() >= deadline,
}
    // rust: if over {
    // rust: self.lights = Lights::Ready;
}
}

    // Move to the vibration's next step once this one is over.
advance_rumble :: proc(self: ^Self) {
}
    // rust: let now = Instant::now();
    // rust: match self.step_end {
    // rust: Some(end) if end > now => return,
    // rust: Some(_) => {
    // rust: self.rumble.pop();
}
    // rust: None => {}
}
    // rust: self.step_end = self.rumble.last().map(|&(_, length)| now + length);
}

    // Send what changed; a failed write means the pad is gone.
flush :: proc(self: ^Self) {
}
    // rust: if self.pad.is_none() {
    // rust: return;
}
    // rust: let motors = self.rumble.last().map_or([0, 0], |(m, _)| *m);
    // rust: let mut state = self.state;
    // rust: if matches!(self.lights, Lights::Waiting(_)) {
    // rust: state.lightbar = None;
    // rust: state.player_leds = None;
}
    // rust: let sent = self.sent;
    // rust: if sent == Some((state, motors)) {
    // rust: return;
}
        // Every report carries the motors: one without them stops the rumble.
    // rust: let mut first = Output {
    // rust: rumble: motors,
    // rust: ..Output::default()
}
    // rust: if sent.is_none() {
    // rust: first.full_power = true;
}
    // rust: let lit = state.lightbar.is_some() || state.player_leds.is_some();
    // rust: if lit && self.lights == Lights::Ready {
    // rust: first.release_leds = true;
    // rust: self.lights = Lights::Reset;
}
        // The reset goes alone, before any colour (hid-playstation.c).
    // rust: if (first.full_power || first.release_leds) && !self.write(&first) {
    // rust: return;
}
    // rust: let mut out = Output {
    // rust: rumble: motors,
    // rust: ..Output::default()
}
    // rust: let old = sent.map(|(s, _)| s);
    // rust: if old.is_none_or(|s| s.triggers != state.triggers) {
    // rust: out.left_trigger = Some(state.triggers[0]);
    // rust: out.right_trigger = Some(state.triggers[1]);
}
    // rust: if old.is_none_or(|s| s.lightbar != state.lightbar) {
    // rust: out.lightbar = state.lightbar;
}
    // rust: if old.is_none_or(|s| s.player_leds != state.player_leds) {
    // rust: out.player_leds = state.player_leds;
}
    // rust: if self.write(&out) {
    // rust: self.sent = Some((state, motors));
}
}

    // Whether the pad still answers. hidapi's Windows back end can crash inside `hid_write`
    // once the device has gone (Bluetooth sleep, unplug), so a write reads first; a failed
    // read drops the handle and the thread looks for the pad again.
probe :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(pad) = self.pad.as_ref() else {
    // rust: return false;
}
    // rust: let mut buf = [0; 80];
    // rust: let failed = match pad.read(&mut buf, 0) {
    // rust: Ok(_) => None,
    // rust: Err(e) => Some(e.to_string()),
}
    // rust: match failed {
    // rust: Some(why) => {
    // rust: self.lost(&why);
    // rust: false
}
    // rust: None => true,
}
}

    // Write a report, dropping the pad on any hidapi error: a handle that failed is never
    // written through again.
write :: proc(self: ^Self, out: ^Output) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !self.probe() {
    // rust: return false;
}
    // rust: let result = match self.pad.as_mut() {
    // rust: Some(pad) => pad.write(out),
    // rust: None => return false,
}
    // rust: match result {
    // rust: Ok(()) => true,
    // rust: Err(e) => {
    // rust: self.lost(&e.to_string());
    // rust: false
}
}
}

    // Drop a handle that hidapi failed on, and look for the pad again: one that slept or was
    // unplugged may come back. Nothing is written through the old handle.
lost :: proc(self: ^Self, why: string) {
}
    // rust: log::info!("DualSense output closed: {why}");
    // rust: self.pad = None;
    // rust: self.sent = None;
    // rust: self.lights = Lights::Ready;
    // rust: self.open.store(0, Ordering::Relaxed);
    // rust: self.scans_left = SCAN_TRIES;
    // rust: self.next_scan = Instant::now();
}
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::atomic::AtomicUsize;

    // A pad whose reads and writes can fail, so the writer's state machine runs without
    // hardware (the crash itself is inside hidapi's C on Windows).
FakePad :: struct {
    writes: ^AtomicUsize,
    reads: ^AtomicUsize,
    read_fails: bool,
    write_fails: bool,
}

    // rust: impl Handle for FakePad {
write :: proc(self: ^Self, _out: ^Output) -> H {
    // Ported from Horizon
    return {}
}
    // rust: self.writes.fetch_add(1, Ordering::Relaxed);
    // rust: if self.write_fails {
    // rust: Err(hidapi::HidError::HidApiError {
    // rust: message: "gone".into(),
    // rust: })
    // rust: } else {
    // rust: Ok(())
}
}

read :: proc(self: ^Self, _buf: []u8, _millis: i32) -> H {
    // Ported from Horizon
    return {}
}
    // rust: self.reads.fetch_add(1, Ordering::Relaxed);
    // rust: if self.read_fails {
    // rust: Err(hidapi::HidError::HidApiError {
    // rust: message: "gone".into(),
    // rust: })
    // rust: } else {
    // rust: Ok(0)
}
}
}

    // rust: fn writer(
    // rust: open: &Arc<AtomicU8>,
    // rust: read_fails: bool,
    // rust: write_fails: bool,
    // rust: ) -> (Writer, Arc<AtomicUsize>, Arc<AtomicUsize>) {
    // rust: let writes = Arc::new(AtomicUsize::new(0));
    // rust: let reads = Arc::new(AtomicUsize::new(0));
    // rust: let mut writer = Writer::new(open.clone());
    // rust: writer.pad = Some(Box::new(FakePad {
    // rust: writes: writes.clone(),
    // rust: reads: reads.clone(),
    // rust: read_fails,
    // rust: write_fails,
    // rust: }));
    // rust: (writer, writes, reads)
}

a_failed_read_drops_the_pad_without_writing :: proc() {
}
    // rust: let open = Arc::new(AtomicU8::new(1));
    // rust: let (mut writer, writes, reads) = writer(&open, true, false);
    // rust: writer.flush();
    // rust: assert_eq!(reads.load(Ordering::Relaxed), 1);
    // rust: assert_eq!(writes.load(Ordering::Relaxed), 0);
    // rust: assert!(writer.pad.is_none());
    // rust: assert_eq!(open.load(Ordering::Relaxed), 0);
    // rust: assert_eq!(writer.scans_left, SCAN_TRIES);
}

a_failed_write_drops_the_pad_and_schedules_a_rescan :: proc() {
}
    // rust: let open = Arc::new(AtomicU8::new(1));
    // rust: let (mut writer, writes, _) = writer(&open, false, true);
    // rust: writer.flush();
    // rust: assert_eq!(writes.load(Ordering::Relaxed), 1);
    // rust: assert!(writer.pad.is_none());
    // rust: assert_eq!(open.load(Ordering::Relaxed), 0);
    // rust: assert!(writer.sent.is_none());
    // rust: assert_eq!(writer.scans_left, SCAN_TRIES);
        // The handle that failed is not written through again.
    // rust: writer.flush();
    // rust: assert_eq!(writes.load(Ordering::Relaxed), 1);
}

a_live_pad_stays_open :: proc() {
}
    // rust: let open = Arc::new(AtomicU8::new(1));
    // rust: let (mut writer, writes, _) = writer(&open, false, false);
    // rust: writer.flush();
    // rust: assert_eq!(writes.load(Ordering::Relaxed), 2);
    // rust: assert!(writer.pad.is_some());
    // rust: assert!(writer.sent.is_some());
    // rust: assert_eq!(open.load(Ordering::Relaxed), 1);
}

bluetooth_clock_offset :: proc() {
}
    // rust: let mut report = [0; 78];
    // rust: report[0] = 0x31;
    // rust: report[2 + 27..2 + 31].copy_from_slice(&ANIMATION_OVER.to_le_bytes());
    // rust: assert_eq!(bluetooth_clock(&report), Some(10_200_000));
        // The simple report, or a USB one, has no clock here.
    // rust: report[0] = 0x01;
    // rust: assert_eq!(bluetooth_clock(&report), None);
    // rust: assert_eq!(bluetooth_clock(&[0x31, 0, 0]), None);
}
}
