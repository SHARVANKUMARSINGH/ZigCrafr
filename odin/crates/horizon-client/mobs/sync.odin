//! Transpiled from Horizon Rust crate
package horizon_client_sync

import "core:fmt"
import "core:mem"
import "core:math"

// A server's mobs as a client animates them. The server thread, a LAN host
// and a dedicated server run each mob's animation state (`ai::tick`); a
// client of a server only gets synched data and entity events, and runs the
// animation steps vanilla runs on the client (`Entity.onSyncedDataUpdated`,
// `handleEntityEvent` and the per tick animation states). The server's half
// is `game/lan.rs` (`mob_meta`, with `pose_id` here for index 6) and
// `MobEvent::EntityEvent`; the client's half is `game/remote_mob_data.rs`,
// `game/remote.rs` (`C::EntityEvent`) and `client_tick` here.
//
// To animate another species for a client:
// - send its synched data in `mob_meta` and read it in
//   `remote_mob_data::apply`;
// - send its poses in `pose_id` and read them in `set_pose`;
// - broadcast its entity events with `MobEvent::EntityEvent` and handle
//   them in `entity_event`;
// - run its client side animation in `client_tick`, sharing the function
//   with the server's `ai_step` where the server computes the same.
// use super::{
    // rust: Mob, MobEvent, Species, allay, armadillo, axolotl, breeze, camel, copper_golem, creaking,
    // rust: equine, frog, goat, golem, guardian, piglin, ravager, shulker, sniffer, tame, undead, villager,
    // rust: warden,
}

// `Pose.id` of the poses mobs take.
STANDING :: 0
SLEEPING :: 2
CROUCHING :: 5
LONG_JUMPING :: 6
CROAKING :: 8
USING_TONGUE :: 9
SITTING :: 10
ROARING :: 11
SNIFFING :: 12
EMERGING :: 13
DIGGING :: 14
SLIDING :: 15
SHOOTING :: 16
INHALING :: 17

// `Entity.DATA_POSE` (index 6) of a mob of a server: the pose its species
// keeps in its own fields.
pose_id :: proc(m: ^Mob) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match m.species() {
    // rust: Species::Warden => warden::pose_id(m),
    // rust: Species::Breeze => breeze::pose_id(m),
    // rust: Species::Camel | Species::CamelHusk if camel::sitting(m) => SITTING,
    // rust: Species::Frog | Species::Cat | Species::Ocelot | Species::Goat => m.extra.pose,
        // LivingEntity.startSleeping: the pose, with the bed in index 14.
    // rust: Species::Villager if villager::sleeping(m) => SLEEPING,
    // rust: _ => STANDING,
}
}

// `Entity.onSyncedDataUpdated(DATA_POSE)` on a client.
set_pose :: proc(m: ^Mob, id: u8) {
}
    // rust: let old = std::mem::replace(&mut m.extra.pose, id);
    // rust: match m.species() {
    // rust: Species::Frog if old != id => frog::pose_changed(m),
    // rust: Species::Warden => warden::set_pose_id(m, id),
    // rust: Species::Breeze => breeze::set_pose_id(m, id),
    // rust: _ => {}
}
}

// The per tick animation steps of a client's mobs (after `m.age` moved on),
// for the species whose server runs them in `ai_step`. `game_time` is the
// client level's.
client_tick :: proc(m: ^Mob, game_time: i64, events: ^[dynamic]MobEvent) {
}
    // rust: match m.species() {
        // The warden's digging particles are the client's own
        // (`Warden.clientDiggingParticles`), so the events have to leave here.
    // rust: Species::Warden => warden::client_tick(m, events),
    // rust: Species::Sniffer => sniffer::animate(m),
    // rust: Species::Breeze => breeze::ai_step(m),
    // rust: Species::Camel | Species::CamelHusk => camel::client_tick(m, game_time),
    // rust: Species::Shulker => shulker::client_tick(m),
    // rust: Species::Ravager => ravager::client_tick(m),
    // rust: Species::Hoglin | Species::Zoglin => piglin::client_tick(m),
    // rust: Species::IronGolem => golem::client_tick(m),
    // rust: Species::Creaking => creaking::animate(m),
    // rust: Species::Allay => {
    // rust: m.anim.vo = m.anim.v;
    // rust: allay::animate(m);
}
    // rust: Species::Axolotl => axolotl::tick_animation(m),
    // rust: Species::Guardian | Species::ElderGuardian => {
    // rust: m.anim.vo = m.anim.v;
    // rust: guardian::tail_and_spikes(m);
}
        // The head spin's sound is the server's.
    // rust: Species::CopperGolem if !m.no_ai => {
    // rust: copper_golem::animate(m);
}
    // rust: Species::Armadillo => armadillo::tick(m),
    // rust: Species::Frog => frog::tick(m),
    // rust: Species::Goat => goat::tick(m),
        // Sheep.aiStep on a client: the eating head's clock.
    // rust: Species::Sheep if m.extra.anim_ticks > 0 => m.extra.anim_ticks -= 1,
    // rust: s if equine::grazes(s) => equine::client_tick(m),
    // rust: Species::Drowned => undead::drowned_client_tick(m),
        // Wolf.tick (alive only): the begging head tilt follows the synched flag.
    // rust: Species::Wolf if m.alive() => tame::interest_tick(m),
    // rust: _ => {}
}
}

// `handleEntityEvent` of the mob types that start animations by an event
// (`ClientboundEntityEventPacket` for a mob of a client).
entity_event :: proc(m: ^Mob, event: u8) {
}
    // rust: if m.species() == Species::Armadillo {
    // rust: armadillo::entity_event(m, event);
}
    // rust: if m.species() == Species::Goat {
    // rust: goat::entity_event(m, event);
}
    // rust: let age = m.age as f32;
    // rust: match m.species() {
    // rust: Species::Warden => match event {
            // Attack: the roar ends, the swing starts.
    // rust: 4 => {
    // rust: m.anim.states[warden::ROAR].stop();
    // rust: m.anim.states[warden::ATTACK].start(age);
}
            // The tendrils twitch.
    // rust: 61 => m.anim.v[warden::TENDRIL] = 10.0,
            // The sonic boom.
    // rust: 62 => m.anim.states[warden::SONIC_BOOM].start(age),
    // rust: _ => {}
    // rust: },
    // rust: Species::Ravager => ravager::entity_event(m, event),
    // rust: Species::Hoglin | Species::Zoglin => piglin::client_event(m, event),
    // rust: Species::IronGolem => golem::client_event(m, event),
    // rust: Species::Creaking => creaking::entity_event(m, event),
    // rust: Species::Wolf => tame::entity_event(m, event),
        // Sheep.handleEntityEvent 10: the head goes down to eat grass.
    // rust: Species::Sheep if event == 10 => m.extra.anim_ticks = 40,
    // rust: _ => {}
}
}
