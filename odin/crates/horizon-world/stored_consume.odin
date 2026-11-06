//! Transpiled from Horizon Rust crate
package horizon_world_stored_consume

import "core:fmt"
import "core:mem"
import "core:math"

// Consume effects bound to an entity's shared active-effect storage.
// use crate::{
    // rust: active_effects::{ActiveEffects, EffectHooks},
    // rust: consume_effect::EffectWorld,
    // rust: java_hash_map::JavaKey,
    // rust: status_effect::EffectInstance,
}
// use horizon_core::{position::BlockPos, random::RandomSource};

// Actor and level services used alongside concrete status storage. Callbacks
// receive the live storage so reentrant mutations remain visible to the next
// operation. Random handles identify streams independently of actor changes.
    // rust: pub trait ConsumeHooks<H: JavaKey + Clone, S, Set>: EffectHooks<H> {
    // rust: type Random: Copy;
    // rust: type Rng: RandomSource;
    // rust: type SoundCategory;
get_random :: proc(self: ^Self, storage: ^ActiveEffects<H>) -> R {
    // Ported from Horizon
    return {}
}
random_source :: proc(self: ^Self, random: Self::Random) -> ^ {
    // Ported from Horizon
    return {}
}
effect_set :: proc(self: ^Self, set: ^Set) -> V {
    // Ported from Horizon
    return {}
}
block_position :: proc(self: ^Self, storage: ^ActiveEffects<H>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn sound_category(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: ) -> Result<Self::SoundCategory, Self::Error>;
    // The native call excludes no entity and uses unit volume and pitch.
    // rust: fn play_sound(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: level: Self::Level,
    // rust: position: BlockPos,
    // rust: sound: S,
    // rust: category: Self::SoundCategory,
    // rust: ) -> Result<(), Self::Error>;
}

StoredConsume :: struct {
    effects: ^'a mut ActiveEffects<H>,
    world: ^'a mut W,
}
    // rust: impl<H: JavaKey + Clone, S, Set, W: ConsumeHooks<H, S, Set>> EffectWorld<H, S, Set>
    // rust: for StoredConsume<'_, H, W>
    // rust: {
    // rust: type Error = W::Error;
    // rust: type Level = W::Level;
    // rust: type Random = W::Random;
    // rust: type Source = W::Rng;
    // rust: type SoundCategory = W::SoundCategory;

get_random :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world.get_random(self.effects)
}
random_source :: proc(self: ^Self, random: Self::Random) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.world.random_source(random)
}
add_effect :: proc(self: ^Self, effect: EffectInstance<H>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.effects.add(effect, None, self.world)
}
effect_set :: proc(self: ^Self, set: ^Set) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.world.effect_set(set)
}
remove_effect :: proc(self: ^Self, effect: H) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.effects.remove(&effect, self.world)
}
remove_all_effects :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.effects.remove_all(self.world)
}
block_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world.block_position(self.effects)
}
sound_category :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world.sound_category(self.effects)
}
    // rust: fn play_sound(
    // rust: &mut self,
    // rust: level: Self::Level,
    // rust: position: BlockPos,
    // rust: sound: S,
    // rust: category: Self::SoundCategory,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.world
    // rust: .play_sound(self.effects, level, position, sound, category)
}
}
