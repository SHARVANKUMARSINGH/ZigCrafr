//! Transpiled from Horizon Rust crate
package horizon_client_boss_overlay

import "core:fmt"
import "core:mem"
import "core:math"

// `BossHealthOverlay` and `LerpingBossEvent`: the boss bars a client is
// showing, in the order their add packets arrived.
// use crate::{
    // rust: hud_overlays::BossBar,
    // rust: scoreboard::{comp_text, tag_to_json},
    // rust: text::Text,
}
// use horizon_protocol::packets::play::{BossAction, BossEvent};

// `LerpingBossEvent.LERP_MILLISECONDS`.
LERP_MS :: 100

// `Util.getMillis`.
now_millis :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map(|d| d.as_millis())
    // rust: .unwrap_or(0)
}

// One `LerpingBossEvent`.
Event :: struct {
    id: u128,
    name: Text,
    // The progress the lerp started from (`progress`).
    progress: f32,
    // `targetPercent`.
    target: f32,
    // `setTime`.
    set_at: u128,
    color: u8,
    overlay: u8,
    darken: bool,
    music: bool,
    fog: bool,
}
    // rust: impl Event {
    // `LerpingBossEvent.getProgress`.
displayed :: proc(self: ^Self, now: u128) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let t = ((now.saturating_sub(self.set_at)) as f32 / LERP_MS as f32).clamp(0.0, 1.0);
    // rust: self.progress + (self.target - self.progress) * t
}
    // `LerpingBossEvent.setProgress`: the bar starts the next lerp from
    // whatever it is showing now.
set_progress :: proc(self: ^Self, progress: f32, now: u128) {
}
    // rust: self.progress = self.displayed(now);
    // rust: self.target = progress;
    // rust: self.set_at = now;
}
}

// `BossHealthOverlay`: the events, plus `GameRenderer`'s world darkening.
BossOverlay :: struct {
    events: [dynamic]Event,
    // `bossOverlayWorldDarkening` and the previous tick's value.
    darken: f32,
    darken_o: f32,
}
    // rust: impl BossOverlay {
reset :: proc(self: ^Self) {
}
    // rust: *self = Self::default();
}
    // `ClientboundBossEventPacket.dispatch` into `BossHealthOverlay`'s
    // handler. An id already shown keeps its place when added again.
apply :: proc(self: ^Self, packet: ^BossEvent, now: u128) {
}
        // An ordinal past the enum shows as its last value.
    // rust: let color = |c: i32| c.clamp(0, 6) as u8;
    // rust: let overlay = |o: i32| o.clamp(0, 4) as u8;
    // rust: let id = packet.id;
    // rust: if let BossAction::Add {
    // rust: name,
    // rust: progress,
    // rust: color: c,
    // rust: overlay: o,
    // rust: darken,
    // rust: music,
    // rust: fog,
    // rust: } = &packet.action
    // rust: {
    // rust: let event = Event {
    // rust: id,
    // rust: name: comp_text(&tag_to_json(name)),
    // rust: progress: *progress,
    // rust: target: *progress,
    // rust: set_at: now,
    // rust: color: color(*c),
    // rust: overlay: overlay(*o),
    // rust: darken: *darken,
    // rust: music: *music,
    // rust: fog: *fog,
}
    // rust: match self.events.iter_mut().find(|e| e.id == id) {
    // rust: Some(slot) => *slot = event,
    // rust: None => self.events.push(event),
}
    // rust: return;
}
    // rust: if let BossAction::Remove = packet.action {
    // rust: self.events.retain(|e| e.id != id);
    // rust: return;
}
    // rust: let Some(e) = self.events.iter_mut().find(|e| e.id == id) else {
    // rust: return;
}
    // rust: match &packet.action {
    // rust: BossAction::UpdateProgress { progress } => e.set_progress(*progress, now),
    // rust: BossAction::UpdateName { name } => e.name = comp_text(&tag_to_json(name)),
    // rust: BossAction::UpdateStyle {
    // rust: color: c,
    // rust: overlay: o,
    // rust: } => {
    // rust: e.color = color(*c);
    // rust: e.overlay = overlay(*o);
}
    // rust: BossAction::UpdateProperties { darken, music, fog } => {
    // rust: (e.darken, e.music, e.fog) = (*darken, *music, *fog);
}
    // rust: BossAction::Add { .. } | BossAction::Remove => {}
}
}
    // `GameRenderer.tick` while the level runs.
tick_darken :: proc(self: ^Self, running: bool) {
}
    // rust: if !running {
    // rust: return;
}
    // rust: self.darken_o = self.darken;
    // rust: if self.should_darken() {
    // rust: self.darken = (self.darken + 0.05).min(1.0);
    // rust: } else if self.darken > 0.0 {
    // rust: self.darken = (self.darken - 0.0125).max(0.0);
}
}
    // `GameRenderer.bossOverlayWorldDarkening`.
darken_amount :: proc(self: ^Self, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let t = partial.clamp(0.0, 1.0);
    // rust: self.darken_o + (self.darken - self.darken_o) * t
}
should_darken :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.events.iter().any(|e| e.darken)
}
should_play_music :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.events.iter().any(|e| e.music)
}
should_create_world_fog :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.events.iter().any(|e| e.fog)
}
    // The bars `extractRenderState` walks, with the lerped progress.
bars :: proc(self: ^Self, now: u128) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.events
    // rust: .iter()
    // rust: .map(|e| BossBar {
    // rust: name: e.name.clone(),
    // rust: progress: e.displayed(now),
    // rust: color: e.color as usize,
    // rust: overlay: e.overlay as usize,
    // rust: })
    // rust: .collect()
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::Tag;

add :: proc(id: u128, name: string, progress: f32, darken: bool, fog: bool) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BossEvent {
    // rust: id,
    // rust: action: BossAction::Add {
    // rust: name: Tag::String(name.into()),
    // rust: progress,
    // rust: color: 5,
    // rust: overlay: 0,
    // rust: darken,
    // rust: music: false,
    // rust: fog,
    // rust: },
}
}
progress :: proc(id: u128, progress: f32) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BossEvent {
    // rust: id,
    // rust: action: BossAction::UpdateProgress { progress },
}
}

progress_lerps_over_a_tenth_of_a_second :: proc() {
}
    // rust: let mut overlay = BossOverlay::default();
    // rust: overlay.apply(&add(1, "W", 0.0, true, false), 0);
    // rust: overlay.apply(&progress(1, 1.0), 0);
    // rust: assert!((overlay.bars(50)[0].progress - 0.5).abs() < 1.0e-5);
    // rust: assert!((overlay.bars(100)[0].progress - 1.0).abs() < 1.0e-5);
        // A new target starts from the value on screen.
    // rust: overlay.apply(&progress(1, 0.0), 50);
    // rust: assert!((overlay.bars(150)[0].progress - 0.0).abs() < 1.0e-5);
}

darken_ramps_and_fades :: proc() {
}
    // rust: let mut overlay = BossOverlay::default();
    // rust: overlay.apply(&add(1, "W", 1.0, true, false), 0);
    // rust: overlay.tick_darken(true);
    // rust: assert!((overlay.darken_amount(1.0) - 0.05).abs() < 1.0e-5);
    // rust: overlay.apply(
    // rust: &BossEvent {
    // rust: id: 1,
    // rust: action: BossAction::Remove,
    // rust: },
    // rust: 0,
    // rust: );
    // rust: overlay.tick_darken(true);
    // rust: assert!((overlay.darken - 0.0375).abs() < 1.0e-5);
    // rust: assert!(!overlay.should_play_music());
}

bars_keep_arrival_order :: proc() {
}
    // rust: let mut overlay = BossOverlay::default();
    // rust: overlay.apply(&add(2, "b", 1.0, false, true), 0);
    // rust: overlay.apply(&add(1, "a", 1.0, false, false), 0);
    // rust: overlay.apply(&add(2, "c", 0.5, false, true), 0);
        // An update for a bar this client never got is ignored.
    // rust: overlay.apply(&progress(9, 0.5), 0);
    // rust: let names: Vec<_> = overlay
    // rust: .bars(0)
    // rust: .into_iter()
    // rust: .map(|b| b.name.plain())
    // rust: .collect();
    // rust: assert_eq!(names, ["c", "a"]);
    // rust: assert!(overlay.should_create_world_fog());
    // rust: overlay.apply(
    // rust: &BossEvent {
    // rust: id: 2,
    // rust: action: BossAction::Remove,
    // rust: },
    // rust: 0,
    // rust: );
    // rust: assert!(!overlay.should_create_world_fog());
}
}
