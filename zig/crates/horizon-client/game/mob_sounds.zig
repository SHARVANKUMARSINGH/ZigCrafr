//! Transpiled from Horizon Rust crate
//! Module: horizon-client_mob_sounds
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The looping sound instances of mobs: a bee's buzz
//! (`ClientPacketListener.postAddEntitySoundInstance`) and a guardian's
//! attack hum (entity event 21), and the riding sound of a happy ghast or nautilus. The
//! sound engine ticks them with what `start_mob_sounds` and
//! `start_riding_sound` read off the mobs.
// use super::Game;
// use horizon_client::{
    // rust: mobs::{Species, bee, guardian, sniffer},
    // rust: sound_engine::{MobSound, RiddenSound, SoundEngine, SoundInstance, Sounds},
}

    // rust: impl Game<'_> {
    /// `LocalPlayer.startRiding` on a happy ghast or an `AbstractNautilus`:
    /// its riding sound (a minecart's are `start_cart_sounds`'). Then what the
    /// instance reads about the mob the player rides.
    // rust: pub(super) fn start_riding_sound(&mut self) -> Option<RiddenSound> {
    // rust: let ridden = self
    // rust: .riding
    // rust: .and_then(|id| self.mobs.iter().find(|m| m.id == id && !m.removed))
    // rust: .map(|m| {
    // rust: let species = m.species();
    // rust: let sound = RiddenSound {
    // rust: id: m.id,
                    // Vec3.length.
    // rust: speed: m.velocity.length(),
    // rust: silent: m.silent,
                    // Entity.isUnderWater: wasEyeInWater && isInWater.
    // rust: underwater: m.was_eye_in_water && m.fluids.in_water,
}
    // rust: (species, sound)
    // rust: });
    // rust: let started = ridden
    // rust: .filter(|r| {
    // rust: matches!(
    // rust: r.0,
    // rust: Species::HappyGhast | Species::Nautilus | Species::ZombieNautilus
    // rust: )
    // rust: })
    // rust: .map(|r| r.1);
    // rust: if let Some(sound) = started
    // rust: && self.riding_sound != Some(sound.id)
    // rust: && !sound.silent
    // rust: {
    // rust: let nautilus = matches!(
    // rust: ridden.map(|r| r.0),
    // rust: Some(Species::Nautilus | Species::ZombieNautilus)
    // rust: );
    // rust: let instance = if nautilus {
    // rust: SoundInstance::riding_nautilus(&sound, SoundEngine::unseeded())
    // rust: } else {
    // rust: SoundInstance::riding_happy_ghast(&sound, SoundEngine::unseeded())
}
    // rust: self.audio.play_instance(instance, false);
}
    // rust: self.riding_sound = started.map(|g| g.id);
    // rust: ridden.map(|r| r.1)
}
    /// Start the buzz of each bee that has none (or whose anger changed, which
    /// swaps the flying loop for the aggressive one and back), forget the mobs
    /// that are gone, and read what the instances follow.
    // rust: pub(super) fn start_mob_sounds(&mut self) -> Vec<MobSound> {
    // rust: let game_time = self.world.game_time;
    // rust: let mobs: Vec<MobSound> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| {
    // rust: !m.removed
    // rust: && matches!(
    // rust: m.species(),
    // rust: Species::Bee
    // rust: | Species::Guardian
    // rust: | Species::ElderGuardian
    // rust: | Species::Sniffer
    // rust: )
    // rust: })
    // rust: .map(|m| MobSound {
    // rust: id: m.id,
    // rust: position: [m.position.x, m.position.y, m.position.z],
                // Vec3.horizontalDistance.
    // rust: speed: m.velocity.x.hypot(m.velocity.z),
    // rust: baby: m.is_baby(),
                // NeutralMob.isAngry: the anger end time is ahead.
    // rust: angry: m.species() == Species::Bee
    // rust: && bee::get(m).is_some_and(|b| b.anger_end > 0 && b.anger_end - game_time > 0),
    // rust: silent: m.silent,
    // rust: attack_scale: guardian::attack_scale(m),
                // SnifferSoundInstance.tick.
    // rust: sniffer_digging: m.species() == Species::Sniffer
    // rust: && m.ai.target.is_none()
    // rust: && sniffer::can_play_digging_sound(m),
    // rust: })
    // rust: .collect();
    // rust: self.guardian_sounds
    // rust: .retain(|id| mobs.iter().any(|m| m.id == *id));
    // rust: self.bee_sounds
    // rust: .retain(|id, _| mobs.iter().any(|m| m.id == *id));
    // rust: for sound in &mobs {
    // rust: let is_bee = self
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|m| m.id == sound.id && m.species() == Species::Bee);
    // rust: if is_bee && self.bee_sounds.get(&sound.id) != Some(&sound.angry) {
    // rust: self.bee_sounds.insert(sound.id, sound.angry);
    // rust: let instance = SoundInstance::bee(sound, sound.angry, SoundEngine::unseeded());
    // rust: self.audio.play_instance(instance, false);
}
}
    // rust: mobs
}

    /// `ClientPacketListener.handleEntityEvent` 21: a guardian's attack
    /// hum starts (one loop per guardian; the loops of its earlier beams are
    /// the same loop, as each one follows the guardian's charge).
    // rust: pub(super) fn start_guardian_sound(&mut self, id: u32) {
    // rust: let Some(m) = self.mobs.iter().find(|m| {
    // rust: m.id == id && matches!(m.species(), Species::Guardian | Species::ElderGuardian)
    // rust: }) else {
    // rust: return;
}
    // rust: if !self.guardian_sounds.insert(id) {
    // rust: return;
}
    // rust: let sound = MobSound {
    // rust: id,
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: speed: 0.0,
    // rust: baby: false,
    // rust: angry: false,
    // rust: silent: m.silent,
    // rust: attack_scale: guardian::attack_scale(m),
    // rust: sniffer_digging: false,
}
    // rust: let instance = SoundInstance::guardian_attack(&sound, SoundEngine::unseeded());
    // rust: self.audio.play_instance(instance, false);
}

    /// `ClientPacketListener.handleEntityEvent` 63: a sniffer's digging
    /// sound loop starts (`SnifferSoundInstance`).
    // rust: pub(super) fn start_sniffer_digging_sound(&mut self, id: u32) {
    // rust: let Some(m) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id && m.species() == Species::Sniffer)
    // rust: else {
    // rust: return;
}
    // rust: if m.silent {
    // rust: return;
}
    // rust: let instance = SoundInstance::sniffer(id, SoundEngine::unseeded());
    // rust: self.audio.play_instance(instance, false);
}
}
