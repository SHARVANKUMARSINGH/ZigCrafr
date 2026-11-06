//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_sound_preview
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `SoundPreviewHandler`: the sound a category volume slider plays while it
//! moves on the title screen's options (`Options.createSoundSliderOptionInstance`
//! calls `preview` when there is no level).
// use crate::settings::SOUND_SOURCES;
// use crate::sound_engine::{InstanceId, SoundEngine, SoundInstance, Sounds};

/// The sound `SoundPreviewHandler.preview` plays for a `SoundSource` index,
/// or `None` (`SoundEvents.EMPTY`) for master, music and voice.
pub fn preview_event(source: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match *SOUND_SOURCES.get(source)? {
    // rust: "record" => "minecraft:block.note_block.guitar",
    // rust: "weather" => "minecraft:entity.lightning_bolt.thunder",
    // rust: "block" => "minecraft:block.grass.place",
    // rust: "hostile" => "minecraft:entity.zombie.ambient",
        // SoundEvents.COW_SOUNDS.get(CowSoundVariants.SoundSet.CLASSIC).ambientSound()
    // rust: "neutral" => "minecraft:entity.cow.ambient",
    // rust: "player" => "minecraft:entity.generic.eat",
    // rust: "ambient" => "minecraft:ambient.cave",
    // rust: "ui" => "minecraft:ui.button.click",
    // rust: _ => return None,
    // rust: })
}

/// `SoundPreviewHandler`'s `activePreview` and `previousCategory`.
pub const SoundPreview = struct {
    active: ?InstanceId,
    previous: ?usize,
};

    // rust: impl SoundPreview {
    /// `SoundPreviewHandler.preview(soundManager, category, volume)`: stop the
    /// preview of another category, then, unless the last preview still
    /// plays, play this category's sound (`SimpleSoundInstance.forUI` at
    /// pitch 1 and the slider's volume).
pub fn preview(self: *Self, sounds: *mut impl Sounds, source: usize, volume: f32) void {
}
    // rust: self.stop_other_category_preview(sounds, source);
    // rust: if !self.can_play_sound(sounds) {
    // rust: return;
}
    // rust: let Some(event) = preview_event(source) else {
    // rust: return;
}
    // rust: if let Some(old) = self.active.take() {
    // rust: sounds.release(old);
}
    // rust: let instance = SoundInstance::for_ui(event, 1.0, volume, SoundEngine::unseeded());
    // rust: self.active = Some(sounds.play_instance(instance, true).0);
}

    /// The preview playing now, if any.
pub fn active(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.active
}

    /// `stopOtherCategoryPreview`.
pub fn stop_other_category_preview(self: *Self, sounds: *mut impl Sounds, source: usize) void {
}
    // rust: if self.previous != Some(source) {
    // rust: self.previous = Some(source);
    // rust: if let Some(active) = self.active {
    // rust: sounds.stop_instance(active);
}
}
}

    /// `canPlaySound`: no preview yet, or the last one has finished.
pub fn can_play_sound(self: *Self, sounds: *mut impl Sounds) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.active.is_none_or(|active| !sounds.is_active(active))
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::sound_engine::{Bound, TickContext, UI, test_backend::Null};
//     use crate::sound_events::SoundRegistry;

pub fn engine() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut registry = SoundRegistry::default();
    // rust: registry.add_file(
    // rust: "minecraft",
    // rust: br#"{"entity.zombie.ambient": {"sounds": ["mob/zombie/say1"]},
    // rust: "entity.cow.ambient": {"sounds": ["mob/cow/say1"]},
    // rust: "ui.button.click": {"sounds": ["random/click"]}}"#,
    // rust: &|_, _| true,
    // rust: );
    // rust: SoundEngine::new(registry)
}

pub fn source(name: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SOUND_SOURCES.iter().position(|s| *s == name).unwrap()
}

pub fn each_category_previews_its_vanilla_sound() void {
}
    // rust: let expected = [
    // rust: ("master", None),
    // rust: ("music", None),
    // rust: ("record", Some("minecraft:block.note_block.guitar")),
    // rust: ("weather", Some("minecraft:entity.lightning_bolt.thunder")),
    // rust: ("block", Some("minecraft:block.grass.place")),
    // rust: ("hostile", Some("minecraft:entity.zombie.ambient")),
    // rust: ("neutral", Some("minecraft:entity.cow.ambient")),
    // rust: ("player", Some("minecraft:entity.generic.eat")),
    // rust: ("ambient", Some("minecraft:ambient.cave")),
    // rust: ("voice", None),
    // rust: ("ui", Some("minecraft:ui.button.click")),
    // rust: ];
    // rust: for (name, event) in expected {
    // rust: assert_eq!(preview_event(source(name)), event, "{name}");
}
}

    // rust: fn slide(
    // rust: preview: &mut SoundPreview,
    // rust: engine: &mut SoundEngine,
    // rust: backend: &mut Null,
    // rust: name: &str,
    // rust: volume: f32,
    // rust: ) {
    // rust: preview.preview(&mut Bound { engine, backend }, source(name), volume);
}

    /// Ticks enough for the engine to drop finished or stopped channels.
pub fn settle(engine: *mut SoundEngine, backend: *mut Null) void {
}
    // rust: for _ in 0..40 {
    // rust: engine.tick(false, &TickContext::default(), backend);
}
}

pub fn a_moving_slider_plays_one_preview_at_a_time_and_switching_stops_it() void {
}
    // rust: let (mut engine, mut backend) = (engine(), Null::default());
    // rust: let mut preview = SoundPreview::default();
    // rust: slide(&mut preview, &mut engine, &mut backend, "hostile", 0.4);
    // rust: let first = preview
    // rust: .active()
    // rust: .expect("the hostile slider plays a preview");
    // rust: let instance = engine.instance(first).unwrap();
    // rust: assert_eq!(instance.identifier, "minecraft:entity.zombie.ambient");
    // rust: assert_eq!(instance.source, UI);
    // rust: assert_eq!((instance.volume, instance.pitch), (0.4, 1.0));
    // rust: assert!(instance.relative);
    // rust: assert!(engine.is_active(first));
        // canPlaySound: still playing, so dragging further does not restart it.
    // rust: slide(&mut preview, &mut engine, &mut backend, "hostile", 0.6);
    // rust: assert_eq!(preview.active(), Some(first));
    // rust: assert_eq!(engine.active_instances(), vec![first]);
        // Once it has finished, the next move plays it again.
    // rust: for stopped in backend.stopped.values_mut() {
    // rust: *stopped = true;
}
    // rust: settle(&mut engine, &mut backend);
    // rust: assert!(!engine.is_active(first));
    // rust: slide(&mut preview, &mut engine, &mut backend, "hostile", 0.6);
    // rust: let second = preview.active().unwrap();
    // rust: assert_ne!(second, first);
    // rust: assert!(engine.is_active(second));
        // Another category stops the playing preview (SoundManager.stop); the
        // engine lets its channel go on the next ticks, then that category's
        // own sound plays.
    // rust: slide(&mut preview, &mut engine, &mut backend, "neutral", 1.0);
    // rust: assert!(backend.stopped.values().all(|stopped| *stopped));
    // rust: settle(&mut engine, &mut backend);
    // rust: assert!(engine.active_instances().is_empty());
    // rust: slide(&mut preview, &mut engine, &mut backend, "neutral", 1.0);
    // rust: let third = preview.active().unwrap();
    // rust: assert_eq!(
    // rust: engine.instance(third).unwrap().identifier,
    // rust: "minecraft:entity.cow.ambient"
    // rust: );
        // Master has no sound but still stops the other category's preview.
    // rust: slide(&mut preview, &mut engine, &mut backend, "master", 1.0);
    // rust: settle(&mut engine, &mut backend);
    // rust: assert!(engine.active_instances().is_empty());
    // rust: slide(&mut preview, &mut engine, &mut backend, "master", 1.0);
    // rust: assert!(engine.active_instances().is_empty());
}
}
