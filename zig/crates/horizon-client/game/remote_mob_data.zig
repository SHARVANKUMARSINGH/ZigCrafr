//! Transpiled from Horizon Rust crate
//! Module: horizon-client_remote_mob_data
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A server's mobs as their synched data has them
//! (ClientPacketListener.handleSetEntityData, then each entity's
//! `onSyncedDataUpdated`): what a client draws from it rather than from its
//! own simulation, which a client of a server doesn't run.
// use super::Game;
// use horizon_client::mobs::render::{PROFESSIONS, VILLAGER_TYPES};
// use horizon_client::mobs::{
    // rust: Mob, Species, Who, armadillo, bat, bee, camel, creaking, drops, equine, finalize, illusioner,
    // rust: panda, phantom, raider, sniffer, sync, tame, zombie_villager,
}
// use horizon_client::particles::{ParticleOptions, ParticleType};
// use horizon_protocol::entity_data::{Particle, ParticleData, Value};
// use horizon_protocol::registry::{Builtin, Dynamic};
// use horizon_world::registry::BlockStateId;

/// The values `apply` takes from one SetEntityData packet, by vanilla's entry
/// indices (Entity 0..=7, LivingEntity 8..=14, Mob 15, then the subclasses).
/// `builtin` names the ids of built-in registries.
pub fn apply(m: *mut Mob, values: *[(u8) void {
}
    // rust: let species = m.species();
    // rust: let baby = super::lan::baby_index(species);
    // rust: if &*m.kind.id == "minecraft:player" {
    // rust: player_poses(m, values);
}
    // rust: for (index, _, value) in values {
    // rust: match (*index, value) {
            // Entity's signed air and frozen counters are synced as-is.
    // rust: (1, Value::Int(air)) => m.air = *air,
    // rust: (7, Value::Int(frozen)) => m.ticks_frozen = *frozen,
            // Entity.DATA_POSE: a player's or mannequin's box follows it.
    // rust: (6, Value::Id(pose))
    // rust: if matches!(&*m.kind.id, "minecraft:player" | "minecraft:mannequin") =>
    // rust: {
    // rust: m.extra.avatar_pose = horizon_client::pose::Pose::from_id(*pose);
}
            // Entity.DATA_SHARED_FLAGS_ID's FLAG_ONFIRE: Entity.isOnFire on a
            // client, which draws the flames. A client doesn't count the
            // fire down: the flag goes off when the server's fire is out.
    // rust: (0, Value::Byte(flags)) => {
    // rust: m.fire_ticks = i32::from(flags & 1);
                // Entity.isSprinting: a dashing cat's or ocelot's model.
    // rust: m.extra.sprinting = flags & 8 != 0;
                // Drowned.setSwimming: the shared flag of swimming.
    // rust: if species == Species::Drowned {
    // rust: m.extra.flag = flags & 16 != 0;
}
                // The shared flag of invisibility: Entity.isInvisible hides
                // the model (an illusioner shows its mirror images).
    // rust: let invisible = flags & 32 != 0;
    // rust: if species == Species::Illusioner {
    // rust: illusioner::set_invisible(m, invisible);
    // rust: } else if &*m.kind.id != "minecraft:player" {
    // rust: m.invisible = invisible;
}
}
            // Entity.DATA_SILENT: Entity.isSilent, which keeps the sounds
            // a client plays itself quiet (LivingEntity.breakItem's).
    // rust: (4, Value::Bool(silent)) => m.silent = *silent,
            // Entity.DATA_POSE: the pose the species animates by.
    // rust: (6, Value::Id(pose)) => sync::set_pose(m, (*pose).clamp(0, 17) as u8),
            // LivingEntity.DATA_LIVING_ENTITY_FLAGS: using an item 1, in the
            // off hand 2. Bit 0 starts and stops the use; the client ticks the
            // count itself (a bow's pull follows it). stopUsingItem clears
            // only bit 0, so a stopped off-hand use arrives as 2.
    // rust: (8, Value::Byte(flags)) => {
    // rust: m.extra.using_off_hand = flags & 2 != 0;
    // rust: if flags & 1 == 0 {
    // rust: m.extra.using_item = 0;
    // rust: } else if m.extra.using_item == 0 {
    // rust: m.extra.using_item = 1;
}
}
            // LivingEntity.DATA_HEALTH_ID: the boss bars and the death
            // animation follow it.
    // rust: (9, Value::Float(health)) => m.health = *health,
            // LivingEntity.DATA_EFFECT_PARTICLES and DATA_EFFECT_AMBIENCE_ID:
            // the swirls of its effects (`tickEffects` draws them).
    // rust: (10, Value::Particles(list)) => m.extra.effect_particles = swirls(list, builtin),
    // rust: (11, Value::Bool(ambient)) => m.extra.effect_ambient = *ambient,
            // Mob.DATA_MOB_FLAGS_ID: no AI 1, left-handed 2, aggressive 4.
            // Mob.isAggressive draws the illagers' and skeletons' attack
            // poses and the vindicator's axe.
    // rust: (15, Value::Byte(flags)) => {
    // rust: m.no_ai = flags & 1 != 0;
    // rust: m.extra.left_handed = flags & 2 != 0;
    // rust: m.ai.aggressive = flags & 4 != 0;
}
            // AgeableMob.isBaby: `canBeABaby` too, so a parrot or a slime
            // sent as one is still drawn grown.
    // rust: (i, Value::Bool(b)) if Some(i) == baby => {
    // rust: m.extra.age = if *b && drops::can_be_baby(species) {
    // rust: -1
    // rust: } else {
    // rust: 0
}
}
            // AgeableMob.AGE_LOCKED, the entry after DATA_BABY_ID (not
            // Zombie's or Piglin's).
    // rust: (17, Value::Bool(locked)) if baby == Some(16) && finalize::ageable(species) => {
    // rust: m.extra.age_locked = *locked
}
    // rust: _ => {}
}
    // rust: match (species, *index, value) {
    // rust: (Species::Guardian | Species::ElderGuardian, 16, Value::Bool(moving)) => {
    // rust: m.extra.flag2 = *moving;
}
    // rust: (Species::Guardian | Species::ElderGuardian, 17, Value::Int(target)) => {
                // Guardian.onSyncedDataUpdated resets the visual charge clock.
    // rust: m.extra.counter2 = 0;
    // rust: m.extra.flag = *target != 0;
    // rust: m.ai.target = (*target != 0).then_some(if *target == local_entity {
    // rust: Who::Player
    // rust: } else {
    // rust: Who::Mob(*target as u32)
    // rust: });
}
            // Panda: the counters, the two genes and DATA_ID_FLAGS (after
            // AgeableMob's two entries).
    // rust: (Species::Panda, 18, Value::Int(n)) => panda::set_unhappy(m, *n),
    // rust: (Species::Panda, 19, Value::Int(n)) => panda::set_sneeze(m, *n),
    // rust: (Species::Panda, 20, Value::Int(n)) => panda::set_eat(m, *n),
    // rust: (Species::Panda, 21, Value::Byte(gene)) => m.extra.variant = (*gene).clamp(0, 6) as u8,
    // rust: (Species::Panda, 22, Value::Byte(gene)) => m.extra.variant2 = (*gene).clamp(0, 6) as u8,
    // rust: (Species::Panda, 23, Value::Byte(flags)) => panda::set_flags(m, *flags as u8),
            // PolarBear.DATA_STANDING_ID: the client animates the rearing.
    // rust: (Species::PolarBear, 18, Value::Bool(standing)) => m.extra.flag = *standing,
            // Bat.DATA_ID_FLAGS: resting in bit 0.
    // rust: (Species::Bat, 16, Value::Byte(flags)) => bat::set_resting(m, flags & 1 != 0),
            // Fox.DATA_TYPE_ID and DATA_FLAGS_ID.
    // rust: (Species::Fox, 18, Value::Int(variant)) => {
    // rust: m.extra.variant = (*variant).clamp(0, 1) as u8
}
    // rust: (Species::Fox, 19, Value::Byte(flags)) => m.extra.ints[0] = i32::from(*flags as u8),
            // Sheep.DATA_WOOL_ID: the colour in the low nibble, 16 sheared.
    // rust: (Species::Sheep, 18, Value::Byte(wool)) => {
    // rust: m.extra.color = (*wool & 15) as u8;
    // rust: m.extra.sheared = wool & 16 != 0;
}
            // SnowGolem.DATA_PUMPKIN_ID: 16 while the pumpkin is on.
    // rust: (Species::SnowGolem, 16, Value::Byte(flags)) => m.extra.sheared = flags & 16 == 0,
            // Bogged.DATA_SHEARED: the mushrooms on its head are gone.
    // rust: (Species::Bogged, 16, Value::Bool(sheared)) => m.extra.sheared = *sheared,
            // Tadpole.AGE_LOCKED (after AbstractFish's FROM_BUCKET).
    // rust: (Species::Tadpole, 17, Value::Bool(locked)) => m.extra.age_locked = *locked,
            // MushroomCow.DATA_TYPE (after AgeableMob's DATA_BABY_ID and
            // AGE_LOCKED): 0 red, 1 brown.
    // rust: (Species::Mooshroom, 18, Value::Int(variant)) => {
    // rust: m.extra.variant = (*variant == 1) as u8
}
            // Pig.DATA_BOOST_TIME and Strider.DATA_BOOST_TIME (the first entry
            // after AgeableMob's two; the variant and DATA_SUFFOCATING are 19).
            // ItemBasedSteering.onSynced: boosting starts, boostTime is 0, and
            // the total is this int (140 to 980 from boost()).
    // rust: (Species::Pig | Species::Strider, 18, Value::Int(total)) => {
    // rust: m.extra.counter = 0;
    // rust: m.extra.counter2 = *total;
}
            // Piglin.DATA_IS_DANCING: the dance pose.
    // rust: (Species::Piglin, 19, Value::Bool(dancing)) => m.extra.scratch[0] = i32::from(*dancing),
            // TamableAnimal.DATA_FLAGS_ID: sitting 1, tame 4.
    // rust: (Species::Wolf | Species::Cat | Species::Parrot, 18, Value::Byte(flags)) => {
    // rust: m.extra.sitting = flags & 1 != 0;
    // rust: m.extra.tame = flags & 4 != 0;
}
            // Cat.IS_LYING and RELAX_STATE_ONE.
    // rust: (Species::Cat, 21, Value::Bool(lying)) => m.extra.flag = *lying,
    // rust: (Species::Cat, 22, Value::Bool(relaxing)) => m.extra.relax_one = *relaxing,
            // Ocelot.DATA_TRUSTING (after AgeableMob's two).
    // rust: (Species::Ocelot, 18, Value::Bool(trusting)) => m.extra.trusting = *trusting,
            // Wolf.DATA_INTERESTED_ID: begging, which tilts the head.
    // rust: (Species::Wolf, 20, Value::Bool(begging)) => m.extra.flag = *begging,
            // Wolf.DATA_COLLAR_COLOR and Cat's.
    // rust: (Species::Wolf, 21, Value::Int(c)) | (Species::Cat, 23, Value::Int(c)) => {
    // rust: m.extra.color = (*c & 15) as u8;
}
            // AbstractCubeMob.ID_SIZE: its size and box (refreshDimensions).
    // rust: (Species::Slime | Species::MagmaCube | Species::SulfurCube, 18, Value::Int(size)) => {
    // rust: m.extra.size = (*size).clamp(1, 127);
}
            // SulfurCube.MAX_FUSE: onSyncedDataUpdated copies it into the fuse
            // the client ticks for swell / white flash (#4548).
    // rust: (Species::SulfurCube, 20, Value::Int(fuse)) => {
    // rust: m.extra.counter2 = (*fuse).max(0) + 1;
}
    // rust: (Species::SulfurCube, 19, Value::Bool(from_bucket)) => {
    // rust: m.extra.scratch[3] = i32::from(*from_bucket);
}
            // Phantom.ID_SIZE: `updatePhantomSizeInfo` grows its box and bite,
            // and `PhantomRenderer.scale` its model.
    // rust: (Species::Phantom, 16, Value::Int(size)) => phantom::set_size(m, *size),
            // Enderman.DATA_CREEPY (after DATA_CARRY_STATE): the open mouth
            // and raised head of an angry enderman.
    // rust: (Species::Enderman, 17, Value::Bool(creepy)) => m.extra.flag = *creepy,
            // Warden.CLIENT_ANGER_LEVEL: the heartbeat's pace.
    // rust: (Species::Warden, 16, Value::Int(anger)) => {
    // rust: if let Some(st) = m.extra.warden.as_mut() {
    // rust: st.client_anger = *anger;
}
}
            // Sniffer.DATA_STATE (after AgeableMob's two): the animation
            // follows it in `sync::client_tick`.
    // rust: (Species::Sniffer, 18, Value::Id(state)) => {
    // rust: sniffer::set_state(m, (*state).clamp(0, 6) as u8);
}
            // Armadillo.ARMADILLO_STATE (after AgeableMob's two): the shell and
            // its animations follow it in `sync::client_tick`.
    // rust: (Species::Armadillo, 18, Value::Id(state)) => {
    // rust: armadillo::set_state(m, (*state).clamp(0, 3) as u8);
}
            // Goat.DATA_HAS_LEFT_HORN and DATA_HAS_RIGHT_HORN: the model hides
            // a horn the goat lost.
    // rust: (Species::Goat, 19, Value::Bool(has)) => m.extra.lost_horns[0] = !*has,
    // rust: (Species::Goat, 20, Value::Bool(has)) => m.extra.lost_horns[1] = !*has,
            // Shulker.DATA_ATTACH_FACE_ID, DATA_PEEK_ID and DATA_COLOR_ID.
    // rust: (Species::Shulker, 16, Value::Id(face)) => m.extra.variant3 = (*face).clamp(0, 5) as u8,
    // rust: (Species::Shulker, 17, Value::Byte(peek)) => m.extra.counter = i32::from(*peek),
    // rust: (Species::Shulker, 18, Value::Byte(color)) => m.extra.color = *color as u8,
            // Camel.DASH and LAST_POSE_CHANGE_TICK (after AbstractHorse's
            // flags).
    // rust: (Species::Camel | Species::CamelHusk, 19, Value::Bool(dashing)) => {
    // rust: camel::set_dashing(m, *dashing);
}
    // rust: (Species::Camel | Species::CamelHusk, 20, Value::Long(tick)) => {
    // rust: camel::set_synced_pose_tick(m, *tick);
}
            // Vex.DATA_FLAGS_ID: charging in bit 0.
    // rust: (Species::Vex, 16, Value::Byte(flags)) => m.extra.flag = flags & 1 != 0,
            // GlowSquid.DATA_DARK_TICKS_REMAINING (after AgeableMob's two).
    // rust: (Species::GlowSquid, 18, Value::Int(ticks)) => {
    // rust: horizon_client::mobs::aquatic::set_dark_ticks(m, *ticks);
}
            // Creaking.CAN_MOVE, IS_ACTIVE and IS_TEARING_DOWN.
    // rust: (Species::Creaking, 16, Value::Bool(can_move)) => m.extra.flag2 = !*can_move,
    // rust: (Species::Creaking, 17, Value::Bool(active)) => m.extra.flag = *active,
    // rust: (Species::Creaking, 18, Value::Bool(true)) => creaking::set_tearing_down(m),
            // Allay.DATA_DANCING and DATA_CAN_DUPLICATE (a cooldown running
            // is any non-zero `egg_time`).
    // rust: (Species::Allay, 16, Value::Bool(dancing)) => m.extra.flag = *dancing,
    // rust: (Species::Allay, 17, Value::Bool(can)) => m.extra.egg_time = i32::from(!*can),
            // Axolotl.DATA_PLAYING_DEAD (after DATA_VARIANT): the factors
            // ease in `sync::client_tick`.
    // rust: (Species::Axolotl, 19, Value::Bool(dead)) => m.extra.axolotl.playing_dead = *dead,
            // CopperGolem.COPPER_GOLEM_STATE (after DATA_WEATHER_STATE).
    // rust: (Species::CopperGolem, 17, Value::Id(state)) => {
    // rust: m.extra.variant3 = (*state).clamp(0, 4) as u8;
}
            // AbstractHorse's flags take 18. Horse.DATA_ID_TYPE_VARIANT: the
            // colour in the low byte, the markings in the next.
    // rust: (Species::Horse, 19, Value::Int(v)) => {
    // rust: m.extra.variant = (v & 0xFF).clamp(0, 6) as u8;
    // rust: m.extra.variant2 = ((v >> 8) & 0xFF).clamp(0, 4) as u8;
}
            // AbstractChestedHorse.DATA_ID_CHEST, then Llama.DATA_STRENGTH_ID
            // and DATA_VARIANT_ID.
    // rust: (
    // rust: Species::Donkey | Species::Mule | Species::Llama | Species::TraderLlama,
    // rust: 19,
    // rust: Value::Bool(chested),
    // rust: ) => m.extra.chested = *chested,
    // rust: (Species::Llama | Species::TraderLlama, 20, Value::Int(strength)) => {
    // rust: m.extra.variant2 = (*strength).clamp(1, 5) as u8;
}
    // rust: (Species::Llama | Species::TraderLlama, 21, Value::Int(variant)) => {
    // rust: m.extra.variant = (*variant).clamp(0, 3) as u8;
}
            // Axolotl.DATA_VARIANT (lucy 0 to blue 4) and Parrot.DATA_VARIANT_ID
            // (after TamableAnimal's flags and owner).
    // rust: (Species::Axolotl, 18, Value::Int(v)) => m.extra.variant = (*v).clamp(0, 4) as u8,
    // rust: (Species::Parrot, 20, Value::Int(v)) => m.extra.variant = (*v).clamp(0, 4) as u8,
            // Rabbit.DATA_TYPE_ID: the killer bunny's 99 has no model here.
    // rust: (Species::Rabbit, 18, Value::Int(t)) if (0..=5).contains(t) => {
    // rust: m.extra.variant = *t as u8;
}
            // Bee.DATA_FLAGS_ID and DATA_ANGER_END_TIME (after Animal's).
    // rust: (Species::Bee, 18, Value::Byte(flags)) => bee::set_synced(m, Some(*flags as u8), None),
    // rust: (Species::Bee, 19, Value::Long(end)) => bee::set_synced(m, None, Some(*end)),
            // AbstractFish.FROM_BUCKET takes 16: Salmon.DATA_TYPE (small 0
            // to large 2), Pufferfish.PUFF_STATE and
            // TropicalFish.DATA_ID_TYPE_VARIANT.
    // rust: (Species::Salmon, 17, Value::Int(v)) => m.extra.variant = (*v).clamp(0, 2) as u8,
    // rust: (Species::Pufferfish, 17, Value::Int(state)) => m.extra.size = (*state).clamp(0, 2),
    // rust: (Species::TropicalFish, 17, Value::Int(v)) => tropical_fish(m, *v),
            // Ghast.DATA_IS_CHARGING and WitherBoss.DATA_ID_INV.
    // rust: (Species::Ghast, 16, Value::Bool(charging)) => m.extra.flag = *charging,
    // rust: (Species::Wither, 19, Value::Int(ticks)) => m.extra.counter = (*ticks).max(0),
            // CopperGolem.DATA_WEATHER_STATE: the oxidation the texture shows.
    // rust: (Species::CopperGolem, 16, Value::Id(state)) => {
    // rust: m.extra.variant = (*state).clamp(0, 3) as u8;
}
            // AbstractHorse.DATA_ID_FLAGS: eating 16 and standing 32 (the
            // graze and the rear), which `sync::client_tick` animates.
    // rust: (s, 18, Value::Byte(flags)) if equine::grazes(s) => equine::set_flags(m, *flags as u8),
            // Enderman.DATA_CARRY_STATE (0 for none): the block it holds.
    // rust: (Species::Enderman, 16, Value::Id(state)) => {
    // rust: m.extra.carried = (*state > 0).then_some(BlockStateId(*state as u32));
}
            // Zombie.DATA_DROWNED_CONVERSION_ID (after DATA_BABY_ID and
            // DATA_SPECIAL_TYPE_ID): the conversion's shaking.
    // rust: (Species::Zombie | Species::Husk, 18, Value::Bool(converting)) => {
    // rust: m.extra.counter2 = i32::from(*converting);
}
            // Skeleton.DATA_STRAY_CONVERSION_ID (the first entry after Mob's):
            // the freezing conversion's shaking.
    // rust: (Species::Skeleton, 16, Value::Bool(converting)) => {
    // rust: m.extra.counter2 = i32::from(*converting);
}
            // ZombieVillager.DATA_CONVERTING_ID (before its villager data).
    // rust: (Species::ZombieVillager, 19, Value::Bool(converting)) => {
    // rust: zombie_villager::set_converting(m, *converting);
}
            // AbstractVillager.DATA_UNHAPPY_COUNTER (after AgeableMob's two):
            // the head shake of `no`, which the server counts down.
    // rust: (Species::Villager | Species::WanderingTrader, 18, Value::Int(ticks)) => {
    // rust: m.extra.ints[0] = *ticks;
}
            // Hoglin.DATA_IMMUNE_TO_ZOMBIFICATION (after AgeableMob's two) and
            // AbstractPiglin's: `sync`'s conversion shake reads it.
    // rust: (Species::Hoglin, 18, Value::Bool(immune))
    // rust: | (Species::Piglin | Species::PiglinBrute, 16, Value::Bool(immune)) => {
    // rust: m.extra.flag2 = *immune;
}
            // Blaze.DATA_FLAGS_ID: charged 1, which makes it burn.
    // rust: (Species::Blaze, 16, Value::Byte(flags)) => m.extra.flag = flags & 1 != 0,
            // Turtle.HAS_EGG and LAYING_EGG (after AgeableMob's two).
    // rust: (Species::Turtle, 18, Value::Bool(has_egg)) => m.extra.flag = *has_egg,
    // rust: (Species::Turtle, 19, Value::Bool(laying)) => m.extra.flag2 = *laying,
            // WitherBoss.DATA_TARGET_B and _C (after DATA_TARGET_A): the
            // entities the side heads turn toward in `wither::client_tick`.
    // rust: (Species::Wither, 17, Value::Int(id)) => m.extra.ints[0] = *id,
    // rust: (Species::Wither, 18, Value::Int(id)) => m.extra.ints[1] = *id,
            // Raider.IS_CELEBRATING: shared by all six raider types.
    // rust: (species, 16, Value::Bool(celebrating)) if raider::is_raider(species) => {
    // rust: raider::state_mut(m).celebrating = *celebrating;
}
            // Pillager.IS_CHARGING_CROSSBOW: the charge pose (Raider's
            // IS_CELEBRATING takes 16).
    // rust: (Species::Pillager, 17, Value::Bool(charging)) => m.extra.flag = *charging,
            // HappyGhast.STAYS_STILL (after AgeableMob's two and IS_LEASH_HOLDER):
            // `isOnStillTimeout` on a client, which keeps the ghast solid to
            // the player (`canBeCollidedWith`).
            // HappyGhast.IS_LEASH_HOLDER: RopesLayer draws the ropes while set.
    // rust: (Species::HappyGhast, 18, Value::Bool(holder)) => {
    // rust: m.extra.scratch[1] = i32::from(*holder)
}
    // rust: (Species::HappyGhast, 19, Value::Bool(still)) => m.extra.counter = i32::from(*still),
            // SpellcasterIllager.DATA_SPELL_CASTING_ID: the casting pose.
    // rust: (Species::Evoker | Species::Illusioner, 17, Value::Byte(spell)) => {
    // rust: m.extra.variant2 = (*spell).max(0) as u8;
}
            // Villager.DATA_VILLAGER_DATA and ZombieVillager's (after
            // Zombie's three): what VillagerProfessionLayer draws.
    // rust: (Species::Villager, 19, Value::Ids(data))
    // rust: | (Species::ZombieVillager, 20, Value::Ids(data)) => villager_data(m, data, builtin),
            // Mannequin.DATA_PROFILE (after Avatar's two): whose skin it
            // wears; update_remote_skins resolves it like a tab player's.
    // rust: (Species::Mannequin, 17, Value::Profile(profile)) => {
    // rust: m.profile = Some(profile.clone());
}
            // Mannequin.DATA_IMMOVABLE and DATA_DESCRIPTION (an empty one is hidden).
    // rust: (Species::Mannequin, 18, Value::Bool(immovable)) => m.extra.immovable = *immovable,
    // rust: (Species::Mannequin, 19, Value::OptText(description)) => {
    // rust: m.extra.description = horizon_client::mobs::MannequinDescription::from_component(
    // rust: description.as_ref(),
    // rust: );
}
    // rust: _ => {}
}
}
}

/// A tropical fish's packed variant: the pattern's id (the size, then the
/// index << 8), the base colour << 16 and the pattern colour << 24. Here the
/// pattern is 0 to 5 for the small ones and 6 to 11 for the large ones.
pub fn tropical_fish(m: *mut Mob, packed: i32) void {
}
    // rust: let (size, index) = (packed & 0xFF, (packed >> 8) & 0xFF);
    // TropicalFish.Pattern.byId: an unknown id is a kob.
    // rust: m.extra.variant = if size <= 1 && index < 6 {
    // rust: (size * 6 + index) as u8
    // rust: } else {
    // rust: 0
}
    // rust: m.extra.variant2 = ((packed >> 16) & 0xFF) as u8 & 15;
    // rust: m.extra.variant3 = ((packed >> 24) & 0xFF) as u8 & 15;
}

/// The values of one SetEntityData packet that name an entry of a
/// synchronized registry (the variants of the cat, wolf, frog, pig, cow,
/// chicken and zombie nautilus) or count game time (a wolf's anger).
/// `game_time` is the client level's.
    // rust: fn apply_registry_data(
    // rust: m: &mut Mob,
    // rust: values: &[(u8, i32, Value)],
    // rust: registries: &Dynamic,
    // rust: game_time: i64,
    // rust: ) {
    // rust: let species = m.species();
    // rust: for (index, _, value) in values {
    // rust: let registry = match (species, *index, value) {
    // rust: (Species::Cat, 20, Value::Id(_)) => "minecraft:cat_variant",
    // rust: (Species::Wolf, 23, Value::Id(_)) => "minecraft:wolf_variant",
    // rust: (Species::Frog, 18, Value::Id(_)) => "minecraft:frog_variant",
    // rust: (Species::Pig, 19, Value::Id(_)) => "minecraft:pig_variant",
    // rust: (Species::Cow, 18, Value::Id(_)) => "minecraft:cow_variant",
    // rust: (Species::Chicken, 18, Value::Id(_)) => "minecraft:chicken_variant",
    // rust: (Species::ZombieNautilus, 21, Value::Id(_)) => "minecraft:zombie_nautilus_variant",
            // Wolf.DATA_ANGER_END_TIME: the angry texture while it lies ahead.
    // rust: (Species::Wolf, 22, Value::Long(end)) => {
    // rust: m.extra.anger = (end - game_time).clamp(0, i64::from(i32::MAX)) as i32;
    // rust: continue;
}
    // rust: _ => continue,
}
    // rust: if let Value::Id(id) = value
    // rust: && let Some(name) = registries.name(registry, *id)
    // rust: {
    // rust: m.extra.variant = finalize::variant_index(species, name);
}
}
}

/// What another player's pose draws from: gliding (Entity.isFallFlying, flag
/// 0x80 of the shared flags), the pose (swimming), Riptide's spin
/// (LivingEntity.isAutoSpinAttack, flag 4) and a loaded crossbow in the
/// hand (the held stack comes with SetEquipment).
pub fn player_poses(m: *mut Mob, values: *[(u8) void {
}
    // rust: for (index, _, value) in values {
    // rust: match (*index, value) {
    // rust: (0, Value::Byte(flags)) => m.extra.fall_flying = flags & -128 != 0,
    // rust: (6, Value::Id(pose)) => m.extra.synced_pose = (*pose).clamp(0, 17) as u8,
    // rust: (8, Value::Byte(flags)) => m.extra.auto_spin_attack = flags & 4 != 0,
            // LivingEntity.DATA_ARROW_COUNT_ID and DATA_STINGER_COUNT_ID.
    // rust: (12, Value::Int(count)) => m.extra.arrow_count = *count,
    // rust: (13, Value::Int(count)) => m.extra.stinger_count = *count,
            // Player.DATA_SHOULDER_PARROT_LEFT and _RIGHT.
    // rust: (19, Value::Id(v)) => {
    // rust: m.extra.shoulder_parrots[0] = (*v > 0).then(|| (*v - 1).clamp(0, 4))
}
    // rust: (20, Value::Id(v)) => {
    // rust: m.extra.shoulder_parrots[1] = (*v > 0).then(|| (*v - 1).clamp(0, 4))
}
    // rust: _ => {}
}
}
}

/// The options of a synched particle list: an entity effect carries its ARGB
/// colour, the omens none.
pub fn swirls(list: *[Particle], builtin: *Builtin) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let channel = |argb: i32, shift: u32| ((argb >> shift) & 255) as f32 / 255.0;
    // rust: list.iter()
    // rust: .filter_map(|p| {
    // rust: let name = builtin.get("minecraft:particle_type")?.name(p.id)?;
    // rust: let ty = ParticleType::from_name(name)?;
    // rust: Some(match p.data {
    // rust: Some(ParticleData::Color(argb)) => ParticleOptions::colored(
    // rust: ty,
    // rust: [
    // rust: channel(argb, 16),
    // rust: channel(argb, 8),
    // rust: channel(argb, 0),
    // rust: channel(argb, 24),
    // rust: ],
    // rust: ),
    // rust: _ => ParticleOptions::simple(ty),
    // rust: })
    // rust: })
    // rust: .collect()
}

/// VillagerData as the network sends it: the type and the profession by
/// their built-in registry ids, then the level.
pub fn villager_data(m: *mut Mob, data: *[i32], builtin: *Builtin) void {
}
    // rust: let &[kind, profession, level] = data else {
    // rust: return;
}
    // rust: let index = |registry: &str, id: i32, names: &[&str]| {
    // rust: let name = builtin
    // rust: .get(registry)?
    // rust: .name(id)?
    // rust: .strip_prefix("minecraft:")?;
    // rust: names.iter().position(|n| *n == name).map(|i| i as u8)
}
    // rust: if let Some(t) = index("minecraft:villager_type", kind, &VILLAGER_TYPES) {
    // rust: m.extra.variant = t;
}
    // rust: if let Some(p) = index("minecraft:villager_profession", profession, &PROFESSIONS) {
    // rust: m.extra.variant2 = p;
}
    // rust: m.extra.variant3 = level.clamp(0, i32::from(u8::MAX)) as u8;
}

    // rust: impl Game<'_> {
    /// SetEntityData for a mob of the server's.
    // rust: pub(super) fn remote_mob_data(&mut self, id: i32, values: &[(u8, i32, Value)]) {
    // rust: let Some(r) = &self.remote else {
    // rust: return;
}
        // LivingEntity.onSyncedDataUpdated(SLEEPING_POS_ID): a villager lies
        // in its bed the way the bed faces, or gets up.
    // rust: let bed = values.iter().find_map(|v| match v {
    // rust: (14, _, Value::OptPos(bed)) => Some(bed.map_or(0, |b| self.bed_facing(b))),
    // rust: _ => None,
    // rust: });
    // rust: if let Some(m) = self.mob_index.get_mut(&mut self.mobs, id as u32) {
    // rust: apply(m, values, &r.builtin, r.entity_id);
    // rust: apply_registry_data(m, values, &r.registries, self.world.game_time);
    // rust: if let Some(code) = bed
    // rust: && m.species() == Species::Villager
    // rust: {
    // rust: m.extra.ints[1] = code;
}
}
}
}

/// A mob as a client constructs it before its data arrives: the synched
/// defaults the server leaves out (`getNonDefaultValues`) that differ from
/// what `Mob::new` gives, such as a wolf's and a cat's red collar.
    // rust: pub(super) fn client_defaults(m: &mut Mob) {
    // rust: m.air = m.max_air_supply();
    // rust: if matches!(m.species(), Species::Wolf | Species::Cat) {
    // rust: m.extra.color = tame::RED;
}
    // rust: if m.species() == Species::Bat {
        // Bat's constructor sets resting only on the server; the data default is 0.
    // rust: bat::set_resting(m, false);
}
    // A horse's jump strength until the server syncs its own: the type's.
    // rust: if equine::moved_by_rider(m.species()) {
    // rust: m.extra.vector[0] = m.kind.jump_strength;
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_protocol::entity_data::serializer as s;

pub fn fixture_mob(kind: []const u8) M {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_client::mobs::{Anim, Brain, Flags, MobType, Part};
//         use std::sync::Arc;
    // rust: let species = match kind {
    // rust: "minecraft:cow" => Species::Cow,
    // rust: "minecraft:axolotl" => Species::Axolotl,
    // rust: "minecraft:dolphin" => Species::Dolphin,
    // rust: "minecraft:cod" => Species::Cod,
    // rust: "minecraft:pillager" => Species::Pillager,
    // rust: "minecraft:vindicator" => Species::Vindicator,
    // rust: "minecraft:evoker" => Species::Evoker,
    // rust: "minecraft:illusioner" => Species::Illusioner,
    // rust: "minecraft:witch" => Species::Witch,
    // rust: "minecraft:ravager" => Species::Ravager,
    // rust: "minecraft:zombie" => Species::Zombie,
    // rust: _ => panic!("unknown fixture species"),
}
        // Metadata needs no AI or model. Avoid the resource loader, which also
        // initializes process-wide item tags used by unrelated mob tests.
    // rust: let kind = Arc::new(MobType {
    // rust: id: kind.into(),
    // rust: species,
    // rust: width: 0.6,
    // rust: height: 1.95,
    // rust: eye_height: 1.5,
    // rust: category: "monster".into(),
    // rust: max_health: 20.0,
    // rust: speed: 0.25,
    // rust: flying_speed: 0.0,
    // rust: attack_damage: 0.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 16.0,
    // rust: step_height: 0.6,
    // rust: armor: 0.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Arc::default(),
    // rust: item_stack_limits: Arc::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.5,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 120,
    // rust: flags: Flags::default(),
    // rust: model: Arc::new(Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0],
    // rust: polygons: Vec::new(),
    // rust: children: Vec::new(),
    // rust: }),
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Zombie,
    // rust: sounds: [""; 3],
    // rust: step_sound: None,
    // rust: food: Arc::default(),
    // rust: tempt: Arc::default(),
    // rust: });
    // rust: Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0)
}

pub fn air_and_frozen_metadata_reach_the_client() void {
}
    // rust: for kind in ["cow", "cod", "dolphin", "axolotl"] {
    // rust: let mut mob = fixture_mob(&format!("minecraft:{kind}"));
    // rust: super::client_defaults(&mut mob);
    // rust: let max = match kind {
    // rust: "axolotl" => 6000,
    // rust: "dolphin" => 4800,
    // rust: _ => 300,
}
    // rust: assert_eq!(mob.air, max, "initial air: {kind}");
    // rust: for (air, frozen) in [(100, -3), (-20, 140), (max, 0)] {
    // rust: super::apply(
    // rust: &mut mob,
    // rust: &[
    // rust: (1, s::INT, Value::Int(air)),
    // rust: (7, s::INT, Value::Int(frozen)),
    // rust: ],
    // rust: &Builtin::default(),
    // rust: 99,
    // rust: );
    // rust: assert_eq!((mob.air, mob.ticks_frozen), (air, frozen), "{kind}");
}
}
}

pub fn air_trace(kind: []const u8, sequence: *[(i32) void {
}
//         use horizon_client::lan::entity::{Entities, EntityState, Riding, Tracker, Viewer};
//         use horizon_protocol::{buf::Reader, packets::play::Clientbound};
    // rust: let name = format!("minecraft:{kind}");
    // rust: let mut server = fixture_mob(&name);
    // rust: let mut client = fixture_mob(&name);
    // rust: super::client_defaults(&mut client);
    // rust: let mut level = Entities::default();
    // rust: let mut tracker = Tracker::default();
    // rust: let chunks = [(0, 0)].into_iter().collect();
    // rust: let mut state = EntityState {
    // rust: id: 1,
    // rust: uuid: 1,
    // rust: kind: name,
    // rust: needs_sync: true,
    // rust: ..Default::default()
}
    // rust: let mut trace = Vec::new();
    // rust: for &(air, frozen) in sequence {
    // rust: server.air = air;
    // rust: server.ticks_frozen = frozen;
    // rust: state.meta.clear();
    // rust: state.defaults.clear();
    // rust: super::super::lan::mob_freeze_meta(&server, &mut state.meta, &mut state.defaults);
    // rust: let mut packets = Vec::new();
    // rust: level.tick(
    // rust: &[&state],
    // rust: &Riding::default(),
    // rust: &mut [Viewer {
    // rust: entity_id: 99,
    // rust: spectator: false,
    // rust: permission: 0,
    // rust: moved: true,
    // rust: position: [0.0; 3],
    // rust: view_distance: 10,
    // rust: chunks: &chunks,
    // rust: tracker: &mut tracker,
    // rust: out: &mut packets,
    // rust: gone: None,
    // rust: }],
    // rust: |_| Some(100),
    // rust: );
    // rust: let mut sent = Vec::new();
    // rust: for body in packets {
    // rust: let mut reader = Reader::new(&body);
    // rust: let id = reader.varint().unwrap();
    // rust: if let Ok(Clientbound::SetEntityData(data)) = Clientbound::decode(id, reader.rest())
    // rust: {
    // rust: for (index, serializer, value) in &data.values {
    // rust: if matches!(*index, 1 | 7) {
    // rust: assert_eq!(*serializer, s::INT);
    // rust: let Value::Int(value) = value else {
    // rust: panic!("integer metadata");
}
    // rust: sent.push((*index, *value));
}
}
    // rust: super::apply(&mut client, &data.values, &Builtin::default(), 99);
}
}
    // rust: sent.sort_unstable_by_key(|v| v.0);
    // rust: let sent = if sent.is_empty() {
    // rust: "-".into()
    // rust: } else {
    // rust: sent.iter()
    // rust: .map(|(index, value)| format!("{index}={value}"))
    // rust: .collect::<Vec<_>>()
    // rust: .join(",")
}
    // rust: trace.push(format!("{sent}:{},{}", client.air, client.ticks_frozen));
}
    // rust: trace
}

pub fn air_and_frozen_cross_the_tracker_and_wire() void {
}
    // rust: for (kind, max) in [
    // rust: ("cow", 300),
    // rust: ("cod", 300),
    // rust: ("dolphin", 4800),
    // rust: ("axolotl", 6000),
    // rust: ] {
    // rust: let sequence = [(max, 0), (100, -3), (100, -3), (max, 0), (max, 0)];
    // rust: assert_eq!(
    // rust: air_trace(kind, &sequence),
    // rust: vec![
    // rust: format!("-:{max},0"),
    // rust: "1=100,7=-3:100,-3".into(),
    // rust: "-:100,-3".into(),
    // rust: format!("1={max},7=0:{max},0"),
    // rust: format!("-:{max},0")
    // rust: ],
    // rust: "{kind}"
    // rust: );
    // rust: assert_eq!(
    // rust: air_trace(kind, &[(100, -3)]),
    // rust: vec!["1=100,7=-3:100,-3"],
    // rust: "joining while changed: {kind}"
    // rust: );
}
}

pub fn mob_air_parity_fixture() void {
}
//         use std::io::Write;
    // rust: let input =
    // rust: std::fs::read_to_string(std::env::var("HORIZON_MOB_AIR_INPUT").unwrap()).unwrap();
    // rust: let mut output =
    // rust: std::fs::File::create(std::env::var("HORIZON_MOB_AIR_OUTPUT").unwrap()).unwrap();
    // rust: for line in input.lines() {
    // rust: let mut fields = line.split_whitespace();
    // rust: let kind = fields.next().unwrap();
    // rust: let sequence: Vec<_> = fields
    // rust: .map(|pair| {
    // rust: let (air, frozen) = pair.split_once(',').unwrap();
    // rust: (air.parse().unwrap(), frozen.parse().unwrap())
    // rust: })
    // rust: .collect();
    // rust: writeln!(output, "{}", air_trace(kind, &sequence).join(" ")).unwrap();
}
}

pub fn raider_celebration_follows_metadata_and_clears() void {
}
//         use horizon_client::mobs::raider;
    // rust: for kind in [
    // rust: "pillager",
    // rust: "vindicator",
    // rust: "evoker",
    // rust: "illusioner",
    // rust: "witch",
    // rust: "ravager",
    // rust: ] {
    // rust: let mut m = fixture_mob(&format!("minecraft:{kind}"));
    // rust: for on in [true, false, true, false] {
    // rust: super::apply(
    // rust: &mut m,
    // rust: &[(16, s::BOOLEAN, Value::Bool(on))],
    // rust: &Builtin::default(),
    // rust: 99,
    // rust: );
    // rust: assert_eq!(
    // rust: raider::state(&m).is_some_and(|state| state.celebrating),
    // rust: on,
    // rust: "{kind}"
    // rust: );
}
}
    // rust: for kind in ["zombie", "cow"] {
    // rust: let mut m = fixture_mob(&format!("minecraft:{kind}"));
    // rust: super::apply(
    // rust: &mut m,
    // rust: &[(16, s::BOOLEAN, Value::Bool(true))],
    // rust: &Builtin::default(),
    // rust: 99,
    // rust: );
    // rust: assert!(raider::state(&m).is_none(), "{kind} is not a raider");
}
}

pub fn celebration_trace(kind: []const u8, sequence: *[bool]) V {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_client::{
    // rust: lan::entity::{Entities, EntityState, Riding, Tracker, Viewer},
    // rust: mobs::raider,
}
//         use horizon_protocol::{buf::Reader, packets::play::Clientbound};
    // rust: let name = format!("minecraft:{kind}");
    // rust: let mut server = fixture_mob(&name);
    // rust: let mut client = fixture_mob(&name);
    // rust: let mut level = Entities::default();
    // rust: let mut tracker = Tracker::default();
    // rust: let chunks = [(0, 0)].into_iter().collect();
    // rust: let mut state = EntityState {
    // rust: id: 1,
    // rust: uuid: 1,
    // rust: kind: name,
    // rust: needs_sync: true,
    // rust: ..Default::default()
}
    // rust: let mut trace = Vec::new();
    // rust: for &on in sequence {
    // rust: raider::state_mut(&mut server).celebrating = on;
    // rust: state.meta.clear();
    // rust: state.defaults.clear();
    // rust: super::super::lan::mob_raider_meta(&server, &mut state.meta, &mut state.defaults);
    // rust: let mut packets = Vec::new();
    // rust: level.tick(
    // rust: &[&state],
    // rust: &Riding::default(),
    // rust: &mut [Viewer {
    // rust: entity_id: 99,
    // rust: spectator: false,
    // rust: permission: 0,
    // rust: moved: true,
    // rust: position: [0.0; 3],
    // rust: view_distance: 10,
    // rust: chunks: &chunks,
    // rust: tracker: &mut tracker,
    // rust: out: &mut packets,
    // rust: gone: None,
    // rust: }],
    // rust: |_| Some(100),
    // rust: );
    // rust: let mut sent = Vec::new();
    // rust: for body in packets {
    // rust: let mut reader = Reader::new(&body);
    // rust: let id = reader.varint().unwrap();
    // rust: if let Ok(Clientbound::SetEntityData(data)) = Clientbound::decode(id, reader.rest())
    // rust: {
    // rust: for (index, serializer, value) in &data.values {
    // rust: if *index == 16 {
    // rust: assert_eq!(*serializer, s::BOOLEAN);
    // rust: let Value::Bool(on) = value else {
    // rust: panic!("boolean metadata");
}
    // rust: sent.push(*on);
}
}
    // rust: super::apply(&mut client, &data.values, &Builtin::default(), 99);
}
}
    // rust: trace.push((
    // rust: sent,
    // rust: raider::state(&client).is_some_and(|state| state.celebrating),
    // rust: ));
}
    // rust: trace
}

pub fn celebration_crosses_the_tracker_and_wire_without_sticking_or_repeating() void {
}
    // rust: let sequence = [false, true, true, false, false, true, false];
    // rust: let expected = vec![
    // rust: (vec![], false),
    // rust: (vec![true], true),
    // rust: (vec![], true),
    // rust: (vec![false], false),
    // rust: (vec![], false),
    // rust: (vec![true], true),
    // rust: (vec![false], false),
    // rust: ];
    // rust: for kind in [
    // rust: "pillager",
    // rust: "vindicator",
    // rust: "evoker",
    // rust: "illusioner",
    // rust: "witch",
    // rust: "ravager",
    // rust: ] {
    // rust: assert_eq!(celebration_trace(kind, &sequence), expected, "{kind}");
    // rust: assert_eq!(
    // rust: celebration_trace(kind, &[true]),
    // rust: vec![(vec![true], true)],
    // rust: "joining mid-celebration: {kind}"
    // rust: );
}
}

pub fn raider_celebration_parity_fixture() void {
}
//         use std::io::Write;
    // rust: let input =
    // rust: std::fs::read_to_string(std::env::var("HORIZON_RAIDER_SYNC_INPUT").unwrap()).unwrap();
    // rust: let mut output =
    // rust: std::fs::File::create(std::env::var("HORIZON_RAIDER_SYNC_OUTPUT").unwrap()).unwrap();
    // rust: for line in input.lines() {
    // rust: let mut fields = line.split_whitespace();
    // rust: let kind = fields.next().unwrap();
    // rust: let sequence: Vec<_> = fields
    // rust: .map(|value| match value {
    // rust: "0" => false,
    // rust: "1" => true,
    // rust: _ => panic!("invalid celebration flag"),
    // rust: })
    // rust: .collect();
    // rust: let trace = celebration_trace(kind, &sequence);
    // rust: let mut parts = Vec::new();
    // rust: for (sent, state) in trace {
    // rust: let sent = if sent.is_empty() {
    // rust: "-".into()
    // rust: } else {
    // rust: sent.into_iter()
    // rust: .map(|on| i32::from(on).to_string())
    // rust: .collect::<Vec<_>>()
    // rust: .join(",")
}
    // rust: parts.push(format!("{sent}:{}", i32::from(state)));
}
    // rust: writeln!(output, "{}", parts.join(" ")).unwrap();
}
}

    /// A mob of the prepared resources' type `kind`, as a client spawns it
    /// (None without the resources).
pub fn root() s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
}

    /// The prepared resources' built-in registries (empty without them).
pub fn builtin() B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Builtin::load(&root().join("registries.json")).unwrap_or_default()
}

pub fn apply(m: *mut Mob, values: *[(u8) void {
}
    // rust: super::apply(m, values, &builtin(), 99);
}

pub fn mob(kind: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let types = horizon_client::mobs::MobTypes::load(&root()).ok()?;
    // rust: let t = std::sync::Arc::new(types.types.get(kind)?.clone());
    // rust: let mut m = Mob::new(1, t, horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: client_defaults(&mut m);
    // rust: Some(m)
}

    /// #2920: a server's horse is moved by its rider's client, which jumps
    /// it by the type's jump strength (`createBaseHorseAttributes`,
    /// `createBaseChestedHorseAttributes`) until the server syncs its own.
pub fn a_servers_horse_jumps_its_types_strength() void {
}
    // rust: for (kind, strength) in [("horse", 0.7), ("donkey", 0.5), ("mule", 0.5)] {
    // rust: let Some(m) = mob(&format!("minecraft:{kind}")) else {
    // rust: return;
}
    // rust: assert!(
    // rust: (m.extra.vector[0] - strength).abs() < 1e-6,
    // rust: "{kind}: {}",
    // rust: m.extra.vector[0]
    // rust: );
}
}

pub fn guardian_charge_follows_target_updates_and_caps_at_its_duration() void {
}
//         use horizon_client::mobs::guardian::{beam, client_tick};
    // rust: for (kind, duration) in [("guardian", 80), ("elder_guardian", 60)] {
    // rust: let Some(mut m) = mob(&format!("minecraft:{kind}")) else {
    // rust: return;
}
    // rust: assert!(beam(&m, 0.0).is_none());
    // rust: apply(
    // rust: &mut m,
    // rust: &[
    // rust: (16, s::BOOLEAN, Value::Bool(true)),
    // rust: (17, s::INT, Value::Int(99)),
    // rust: ],
    // rust: );
    // rust: assert!(m.extra.flag2);
    // rust: assert_eq!(m.ai.target, Some(Who::Player));
    // rust: assert_eq!(beam(&m, 0.0), Some((0.0, 0.0)));
    // rust: for _ in 0..duration + 10 {
    // rust: client_tick(&mut m);
}
    // rust: assert_eq!(beam(&m, 0.0), Some((duration as f32, 1.0)));
            // Another player or a mob retains its network entity id.
    // rust: apply(&mut m, &[(17, s::INT, Value::Int(42))]);
    // rust: assert_eq!(m.ai.target, Some(Who::Mob(42)));
    // rust: assert_eq!(m.extra.counter2, 0);
    // rust: client_tick(&mut m);
    // rust: assert_eq!(m.extra.counter2, 1);
    // rust: apply(
    // rust: &mut m,
    // rust: &[
    // rust: (16, s::BOOLEAN, Value::Bool(false)),
    // rust: (17, s::INT, Value::Int(0)),
    // rust: ],
    // rust: );
    // rust: client_tick(&mut m);
    // rust: assert!(!m.extra.flag2);
    // rust: assert_eq!(m.ai.target, None);
    // rust: assert_eq!(m.extra.counter2, 0);
    // rust: assert!(beam(&m, 0.0).is_none());
}
}

pub fn a_mooshroom_takes_its_type_after_the_age_lock() void {
}
    // rust: let Some(mut m) = mob("minecraft:mooshroom") else {
    // rust: return;
}
        // AgeableMob.AGE_LOCKED (17) is not the colour.
    // rust: apply(&mut m, &[(17, s::BOOLEAN, Value::Bool(true))]);
    // rust: assert_eq!(m.extra.variant, 0);
        // MushroomCow.DATA_TYPE (18): what MushroomCow.thunderHit changes.
    // rust: apply(&mut m, &[(18, s::INT, Value::Int(1))]);
    // rust: assert_eq!(m.extra.variant, 1);
    // rust: apply(&mut m, &[(18, s::INT, Value::Int(0))]);
    // rust: assert_eq!(m.extra.variant, 0);
}

pub fn a_sheep_takes_its_wool_and_a_calf_its_size() void {
}
    // rust: let Some(mut m) = mob("minecraft:sheep") else {
    // rust: return;
}
    // rust: apply(&mut m, &[(18, s::BYTE, Value::Byte(14 | 16))]);
    // rust: assert_eq!((m.extra.color, m.extra.sheared), (14, true));
    // rust: apply(&mut m, &[(18, s::BYTE, Value::Byte(0))]);
    // rust: assert_eq!((m.extra.color, m.extra.sheared), (0, false));
    // rust: let mut calf = mob("minecraft:cow").unwrap();
    // rust: apply(&mut calf, &[(16, s::BOOLEAN, Value::Bool(true))]);
    // rust: assert!(calf.is_baby());
    // rust: apply(&mut calf, &[(16, s::BOOLEAN, Value::Bool(false))]);
    // rust: assert!(!calf.is_baby());
}

    /// #6133: a server's baby happy ghast (a hatched dried ghast) and baby
    /// nautilus come with AgeableMob.DATA_BABY_ID (16) like any other animal;
    /// a parrot never is one (`Parrot.canBeABaby`).
pub fn a_happy_ghast_and_a_nautilus_take_their_babyhood() void {
}
//         use horizon_client::mobs::MobTypes;
//         use std::{fs, sync::Arc};

    // rust: let root = std::env::temp_dir().join(format!("horizon-baby-flag-{}", std::process::id()));
    // rust: fs::create_dir_all(&root).unwrap();
    // rust: fs::write(
    // rust: root.join("entity-types.json"),
    // rust: r#"{"minecraft:happy_ghast": {}, "minecraft:nautilus": {}, "minecraft:parrot": {}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join("entity-models.json"),
    // rust: r#"{"minecraft:happy_ghast#main": {}, "minecraft:nautilus#main": {},
    // rust: "minecraft:parrot#main": {}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let mut types = MobTypes::load(&root).unwrap();
    // rust: fs::remove_dir_all(root).unwrap();
    // rust: for kind in ["minecraft:happy_ghast", "minecraft:nautilus"] {
    // rust: let t = Arc::new(types.types.remove(kind).unwrap());
    // rust: let mut m = Mob::new(1, t, horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: client_defaults(&mut m);
    // rust: assert!(!m.is_baby(), "{kind}");
    // rust: apply(&mut m, &[(16, s::BOOLEAN, Value::Bool(true))]);
    // rust: assert!(m.is_baby(), "{kind}");
    // rust: apply(&mut m, &[(16, s::BOOLEAN, Value::Bool(false))]);
    // rust: assert!(!m.is_baby(), "{kind}");
}
    // rust: let t = Arc::new(types.types.remove("minecraft:parrot").unwrap());
    // rust: let mut parrot = Mob::new(1, t, horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: client_defaults(&mut parrot);
    // rust: apply(&mut parrot, &[(16, s::BOOLEAN, Value::Bool(true))]);
    // rust: assert!(!parrot.is_baby());
}

pub fn cube_mobs_receive_size_from_metadata() void {
}
    // rust: for kind in ["slime", "magma_cube", "sulfur_cube"] {
    // rust: let Some(mut m) = mob(&format!("minecraft:{kind}")) else {
    // rust: return;
}
    // rust: assert_eq!(m.extra.size, 1);
    // rust: apply(&mut m, &[(18, s::INT, Value::Int(2))]);
    // rust: assert_eq!(m.extra.size, 2);
    // rust: if kind == "sulfur_cube" {
    // rust: assert!(!m.is_baby());
}
}
}

pub fn bat_flags_select_continuous_client_clocks_without_changing_motion() void {
}
//         use horizon_client::mobs::{MobTypes, anim, keyframes::Animation};
//         use horizon_core::geometry::Vec3;
//         use serde_json::json;
//         use std::{collections::HashMap, fs, sync::Arc};

        // Original minimal resources keep this regression runnable without vanilla data.
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-bat-animation-{}", std::process::id()));
    // rust: fs::create_dir(&root).unwrap();
    // rust: fs::write(root.join("entity-types.json"), r#"{"minecraft:bat": {}}"#).unwrap();
    // rust: fs::write(
    // rust: root.join("entity-models.json"),
    // rust: r#"{"minecraft:bat#main": {"children": {"right_wing": {}, "head": {}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let mut types = MobTypes::load(&root).unwrap();
    // rust: fs::remove_dir_all(root).unwrap();
    // rust: let position = Vec3::new(1.0, 2.25, 3.0);
    // rust: let velocity = Vec3::new(0.2, 0.3, 0.4);
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types.remove("minecraft:bat").unwrap()),
    // rust: position,
    // rust: 0.0,
    // rust: );
    // rust: assert!(bat::resting(&m));
    // rust: client_defaults(&mut m);
    // rust: assert!(!bat::resting(&m));
    // rust: m.velocity = velocity;
    // rust: m.age = 1;
    // rust: bat::setup_animation_states(&mut m);
    // rust: m.age = 4;
    // rust: apply(&mut m, &[(16, s::BYTE, Value::Byte(2))]);
    // rust: bat::setup_animation_states(&mut m);
    // rust: assert_eq!(m.anim.states[0].started, Some(1.0));

    // rust: let curve = Animation::parse(&json!({"length": 1, "looping": true,
    // rust: "bones": {"right_wing": [{"target": "rotation", "keyframes":
    // rust: [[0,[0,0,0],[0,0,0],"linear"],[1,[0,1,0],[0,1,0],"linear"]]}]}}));
    // rust: let animations = HashMap::from([("BatAnimation.BAT_FLYING".into(), curve)]);
    // rust: let wing = |partial| {
    // rust: let mut poses = anim::Poses::new(&m.kind.model);
    // rust: anim::setup(&m, &anim::state(&m, partial), &mut poses, &animations);
    // rust: poses.get("right_wing")[4]
}
    // rust: assert!(wing(0.5) > wing(0.0));

    // rust: m.age = 5;
    // rust: apply(&mut m, &[(16, s::BYTE, Value::Byte(3))]);
    // rust: bat::setup_animation_states(&mut m);
    // rust: assert!(bat::resting(&m));
    // rust: assert_eq!(m.anim.states[0].started, None);
    // rust: assert_eq!(m.anim.states[1].started, Some(5.0));
    // rust: m.age = 7;
    // rust: apply(&mut m, &[(16, s::BYTE, Value::Byte(0))]);
    // rust: bat::setup_animation_states(&mut m);
    // rust: assert_eq!(m.anim.states[0].started, Some(7.0));
    // rust: assert_eq!(m.anim.states[1].started, None);
    // rust: assert_eq!((m.position, m.velocity), (position, velocity));
}

pub fn a_wolf_takes_its_owner_flags_and_collar() void {
}
    // rust: let Some(mut m) = mob("minecraft:wolf") else {
    // rust: return;
}
    // rust: assert_eq!(m.extra.color, tame::RED);
    // rust: apply(
    // rust: &mut m,
    // rust: &[
    // rust: (18, s::BYTE, Value::Byte(4 | 1)),
    // rust: (21, s::INT, Value::Int(11)),
    // rust: ],
    // rust: );
    // rust: assert!(m.extra.tame && m.extra.sitting);
    // rust: assert_eq!(m.extra.color, 11);
}

    /// Wolf.DATA_INTERESTED_ID: the begging flag reaches the client, whose
    /// own `Wolf.tick` eases `interestedAngle` toward it (0.4 of the way a
    /// tick), and `getHeadRollAngle` tilts the head by it.
pub fn a_wolf_tilts_its_head_while_the_server_says_it_begs() void {
}
//         use horizon_client::mobs::sync::client_tick;
    // rust: let Some(mut m) = mob("minecraft:wolf") else {
    // rust: return;
}
    // rust: apply(&mut m, &[(20, s::BOOLEAN, Value::Bool(true))]);
    // rust: client_tick(&mut m, 0, &mut Vec::new());
    // rust: assert!((m.anim.v[tame::INTEREST] - 0.4).abs() < 1e-6);
    // rust: assert_eq!(m.anim.vo[tame::INTEREST], 0.0);
    // rust: client_tick(&mut m, 0, &mut Vec::new());
    // rust: assert!((m.anim.v[tame::INTEREST] - 0.64).abs() < 1e-6);
    // rust: assert!((m.anim.lerp(tame::INTEREST, 0.5) - 0.52).abs() < 1e-6);
    // rust: for _ in 0..30 {
    // rust: client_tick(&mut m, 0, &mut Vec::new());
}
    // rust: assert!(m.anim.v[tame::INTEREST] > 0.999);
    // rust: apply(&mut m, &[(20, s::BOOLEAN, Value::Bool(false))]);
    // rust: client_tick(&mut m, 0, &mut Vec::new());
    // rust: assert!(m.anim.v[tame::INTEREST] < 0.61);
    // rust: for _ in 0..30 {
    // rust: client_tick(&mut m, 0, &mut Vec::new());
}
    // rust: assert!(m.anim.v[tame::INTEREST] < 0.001);
}

pub fn fire_health_and_size_follow_the_server() void {
}
    // rust: let Some(mut m) = mob("minecraft:slime") else {
    // rust: return;
}
    // rust: apply(
    // rust: &mut m,
    // rust: &[
    // rust: (0, s::BYTE, Value::Byte(1)),
    // rust: (9, s::FLOAT, Value::Float(12.5)),
    // rust: (18, s::INT, Value::Int(4)),
    // rust: ],
    // rust: );
    // rust: assert_eq!((m.fire_ticks, m.health, m.extra.size), (1, 12.5, 4));
    // rust: apply(&mut m, &[(0, s::BYTE, Value::Byte(0))]);
    // rust: assert_eq!(m.fire_ticks, 0);
}

pub fn mob_flags_turn_aggression_on_and_off() void {
}
    // rust: let Some(mut m) = mob("minecraft:vindicator") else {
    // rust: return;
}
    // rust: apply(&mut m, &[(15, s::BYTE, Value::Byte(4 | 2))]);
    // rust: assert!(m.ai.aggressive && m.extra.left_handed && !m.no_ai);
    // rust: assert!(horizon_client::mobs::illager::shows_item(&m));
    // rust: apply(&mut m, &[(15, s::BYTE, Value::Byte(0))]);
    // rust: assert!(!m.ai.aggressive && !m.extra.left_handed);
    // rust: assert!(!horizon_client::mobs::illager::shows_item(&m));
}

pub fn a_villager_takes_its_type_profession_and_level() void {
}
    // rust: let Some(mut m) = mob("minecraft:villager") else {
    // rust: return;
}
    // rust: let registries = builtin();
    // rust: let id = |registry: &str, name: &str| registries.get(registry)?.id(name);
    // rust: let (Some(desert), Some(farmer), Some(librarian)) = (
    // rust: id("minecraft:villager_type", "minecraft:desert"),
    // rust: id("minecraft:villager_profession", "minecraft:farmer"),
    // rust: id("minecraft:villager_profession", "minecraft:librarian"),
    // rust: ) else {
    // rust: return;
}
    // rust: let name = |m: &Mob| {
    // rust: (
    // rust: VILLAGER_TYPES[m.extra.variant as usize],
    // rust: PROFESSIONS[m.extra.variant2 as usize],
    // rust: m.extra.variant3,
    // rust: )
}
    // rust: apply(
    // rust: &mut m,
    // rust: &[(19, s::VILLAGER_DATA, Value::Ids(vec![desert, farmer, 2]))],
    // rust: );
    // rust: assert_eq!(name(&m), ("desert", "farmer", 2));
        // A job taken later: only the profession and the level change.
    // rust: apply(
    // rust: &mut m,
    // rust: &[(19, s::VILLAGER_DATA, Value::Ids(vec![desert, librarian, 5]))],
    // rust: );
    // rust: assert_eq!(name(&m), ("desert", "librarian", 5));
        // A zombie villager's data comes after Zombie's three entries.
    // rust: let mut z = mob("minecraft:zombie_villager").unwrap();
    // rust: apply(
    // rust: &mut z,
    // rust: &[(20, s::VILLAGER_DATA, Value::Ids(vec![desert, farmer, 3]))],
    // rust: );
    // rust: assert_eq!(name(&z), ("desert", "farmer", 3));
}

pub fn the_mob_flags_drive_the_aggressive_poses() void {
}
    // rust: let Some(mut m) = mob("minecraft:skeleton") else {
    // rust: return;
}
    // rust: apply(&mut m, &[(15, s::BYTE, Value::Byte(2 | 4))]);
    // rust: assert!(m.ai.aggressive && m.extra.left_handed && !m.no_ai);
    // rust: apply(&mut m, &[(15, s::BYTE, Value::Byte(0))]);
    // rust: assert!(!m.ai.aggressive && !m.extra.left_handed);
}

pub fn the_living_flags_start_and_stop_a_mob_using_an_item() void {
}
    // rust: let Some(mut m) = mob("minecraft:skeleton") else {
    // rust: return;
}
    // rust: apply(&mut m, &[(8, s::BYTE, Value::Byte(1))]);
    // rust: assert_eq!(m.extra.using_item, 1);
    // rust: assert!(!m.extra.using_off_hand);
        // Using in the off hand: bit 0 for the use, bit 1 for the hand.
    // rust: apply(&mut m, &[(8, s::BYTE, Value::Byte(3))]);
    // rust: assert_eq!(m.extra.using_item, 1);
    // rust: assert!(m.extra.using_off_hand);
        // LivingEntity.stopUsingItem clears bit 0 only, so the stop of an
        // off-hand use arrives as 2.
    // rust: apply(&mut m, &[(8, s::BYTE, Value::Byte(2))]);
    // rust: assert_eq!(m.extra.using_item, 0);
    // rust: assert!(m.extra.using_off_hand);
    // rust: apply(&mut m, &[(8, s::BYTE, Value::Byte(0))]);
    // rust: assert_eq!(m.extra.using_item, 0);
}

    /// LivingEntity.DATA_ARROW_COUNT_ID and DATA_STINGER_COUNT_ID of another
    /// player, which ArrowLayer and BeeStingerLayer draw.
pub fn another_players_stuck_arrows_and_stingers_are_kept() void {
}
    // rust: let Some(mut m) = mob("minecraft:player") else {
    // rust: return;
}
    // rust: apply(&mut m, &[(12, s::INT, Value::Int(4))]);
    // rust: apply(&mut m, &[(13, s::INT, Value::Int(2))]);
    // rust: assert_eq!((m.extra.arrow_count, m.extra.stinger_count), (4, 2));
    // rust: apply(&mut m, &[(12, s::INT, Value::Int(0))]);
    // rust: assert_eq!((m.extra.arrow_count, m.extra.stinger_count), (0, 2));
}

pub fn a_pillager_charges_and_a_spellcaster_casts() void {
}
    // rust: let Some(mut p) = mob("minecraft:pillager") else {
    // rust: return;
}
    // rust: apply(&mut p, &[(17, s::BOOLEAN, Value::Bool(true))]);
    // rust: assert!(p.extra.flag);
    // rust: let mut e = mob("minecraft:evoker").unwrap();
    // rust: apply(&mut e, &[(17, s::BYTE, Value::Byte(2))]);
    // rust: assert_eq!(e.extra.variant2, 2);
}

pub fn a_mannequin_exists_and_takes_its_profile() void {
}
    // rust: let Some(mut m) = mob("minecraft:mannequin") else {
    // rust: return;
}
    // rust: assert_eq!(&*m.kind.id, "minecraft:mannequin");
    // rust: let profile = horizon_protocol::entity_data::Profile {
    // rust: name: Some("Gommunity".into()),
    // rust: uuid: Some(1),
    // rust: ..Default::default()
}
    // rust: apply(
    // rust: &mut m,
    // rust: &[(17, s::RESOLVABLE_PROFILE, Value::Profile(profile.clone()))],
    // rust: );
    // rust: assert_eq!(m.profile, Some(profile));
}

    /// `Ocelot.DATA_TRUSTING` (after AgeableMob's two).
pub fn an_ocelot_takes_its_trusting_flag() void {
}
    // rust: let Some(mut m) = mob("minecraft:ocelot") else {
    // rust: return;
}
    // rust: assert!(!m.extra.trusting);
    // rust: apply(&mut m, &[(18, s::BOOLEAN, Value::Bool(true))]);
    // rust: assert!(m.extra.trusting);
    // rust: apply(&mut m, &[(18, s::BOOLEAN, Value::Bool(false))]);
    // rust: assert!(!m.extra.trusting);
}

    /// `Mannequin.DATA_IMMOVABLE` and `DATA_DESCRIPTION`: the default component is the default
    /// description, an empty one hides it, any other is the server's own.
pub fn a_mannequin_takes_its_immovable_flag_and_description() void {
}
//         use horizon_client::mobs::MannequinDescription as D;
    // rust: let Some(mut m) = mob("minecraft:mannequin") else {
    // rust: return;
}
    // rust: assert_eq!(
    // rust: (m.extra.immovable, m.extra.description.clone()),
    // rust: (false, D::Default)
    // rust: );
    // rust: let own = horizon_protocol::text::literal("Guard");
    // rust: apply(
    // rust: &mut m,
    // rust: &[
    // rust: (18, s::BOOLEAN, Value::Bool(true)),
    // rust: (19, s::OPTIONAL_COMPONENT, Value::OptText(Some(own.clone()))),
    // rust: ],
    // rust: );
    // rust: assert_eq!(
    // rust: (m.extra.immovable, m.extra.description.clone()),
    // rust: (true, D::Custom(own))
    // rust: );
    // rust: apply(&mut m, &[(19, s::OPTIONAL_COMPONENT, Value::OptText(None))]);
    // rust: assert_eq!(m.extra.description, D::Hidden);
    // rust: let default = D::Default.component();
    // rust: apply(
    // rust: &mut m,
    // rust: &[(19, s::OPTIONAL_COMPONENT, Value::OptText(default))],
    // rust: );
    // rust: assert_eq!(m.extra.description, D::Default);
}

    /// `LivingEntity.getDimensions`: the pose's box times `minecraft:scale` —
    /// a lobby's giant fake player is clickable on its visible body, not only
    /// on the unscaled box at its feet.
pub fn a_scaled_fake_player_gets_a_scaled_box() void {
}
    // rust: for kind in ["minecraft:player", "minecraft:mannequin"] {
    // rust: let Some(mut m) = mob(kind) else {
    // rust: continue;
}
    // rust: let (w, h, e) = m.dims();
    // rust: assert!(
    // rust: (w - 0.6).abs() < 1e-6 && (h - 1.8).abs() < 1e-6 && (e - 1.62).abs() < 1e-5,
    // rust: "{kind}: {w}x{h}x{e}"
    // rust: );
    // rust: m.extra.model_scale = 4.0;
    // rust: let (w, h, e) = m.dims();
    // rust: assert!(
    // rust: (w - 2.4).abs() < 1e-6 && (h - 7.2).abs() < 1e-6 && (e - 6.48).abs() < 1e-5,
    // rust: "{kind} scaled: {w}x{h}x{e}"
    // rust: );
}
}

    /// #4548: SulfurCube.MAX_FUSE copies into the fuse the client ticks for swell.
pub fn sulfur_cube_max_fuse_sets_the_client_fuse() void {
}
    // rust: let Some(mut m) = mob("minecraft:sulfur_cube") else {
    // rust: return;
}
    // rust: assert_eq!(m.extra.counter2, 0);
    // rust: apply(&mut m, &[(20, s::INT, Value::Int(40))]);
    // rust: assert_eq!(horizon_client::mobs::sulfur_cube::fuse(&m), 40);
    // rust: assert!(horizon_client::mobs::sulfur_cube::primed(&m));
    // rust: apply(&mut m, &[(20, s::INT, Value::Int(0))]);
        // Last fuse tick: still primed at 0 until the server removes it.
    // rust: assert_eq!(horizon_client::mobs::sulfur_cube::fuse(&m), 0);
}

    /// `Pig.onSyncedDataUpdated` and `Strider.onSyncedDataUpdated`: a synced
    /// `DATA_BOOST_TIME` (index 18, after AgeableMob's two) calls
    /// `ItemBasedSteering.onSynced`. Boosting starts, `boostTime` is 0, and
    /// the total is the int (`boost()`'s minimum is 140). The next
    /// `tickBoost` then `boostFactor` is `1 + 1.15 * sin(boostTime / total * PI)`.
pub fn a_synced_boost_starts_the_client_timer() void {
}
//         use horizon_client::mobs::MobTypes;
//         use horizon_core::geometry::trig::Mth;
//         use std::{fs, sync::Arc};

    // rust: let root = std::env::temp_dir().join(format!("horizon-boost-sync-{}", std::process::id()));
    // rust: fs::create_dir_all(&root).unwrap();
    // rust: fs::write(
    // rust: root.join("entity-types.json"),
    // rust: r#"{"minecraft:pig": {}, "minecraft:strider": {}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: fs::write(
    // rust: root.join("entity-models.json"),
    // rust: r#"{"minecraft:pig#main": {}, "minecraft:strider#main": {}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let mut types = MobTypes::load(&root).unwrap();
    // rust: fs::remove_dir_all(root).unwrap();

        // ItemBasedSteering: nextInt(841) + 140, and 1.15 in boostFactor.
pub const TOTAL: i32 = 140;
pub const FACTOR: f32 = 1.15;
    // rust: for (kind, steer) in [
    // rust: ("minecraft:pig", 0.225_f64),
    // rust: ("minecraft:strider", 0.55_f64),
    // rust: ] {
    // rust: let t = Arc::new(types.types.remove(kind).unwrap());
    // rust: let mut m = Mob::new(1, t, horizon_core::geometry::Vec3::ZERO, 0.0);
    // rust: m.attrs.speed = 0.25;
    // rust: m.extra.saddled = true;
    // rust: m.extra.counter = 5;
    // rust: m.extra.counter2 = 3;
            // The next entry (pig variant, strider suffocating) is not the boost.
    // rust: apply(&mut m, &[(19, s::INT, Value::Int(TOTAL))]);
    // rust: assert_eq!((m.extra.counter, m.extra.counter2), (5, 3), "{kind}");
    // rust: apply(&mut m, &[(18, s::INT, Value::Int(TOTAL))]);
    // rust: assert_eq!(m.extra.counter, 0, "{kind}: onSynced sets boostTime to 0");
    // rust: assert_eq!(m.extra.counter2, TOTAL, "{kind}: the synced total");
    // rust: m.rider = Some(equine::Rider {
    // rust: steer: true,
    // rust: ..Default::default()
    // rust: });
    // rust: equine::ridden_step(&mut m);
            // tickBoost post-increments, then boostFactor reads boostTime 1.
    // rust: let boost = 1.0 + FACTOR * (1.0_f32 / TOTAL as f32 * std::f32::consts::PI).msin();
    // rust: let expected = (0.25_f64 * steer) as f32 * boost;
    // rust: assert_eq!(m.extra.counter, 1, "{kind}");
    // rust: assert!(
    // rust: (m.ai.speed - expected).abs() < 1.0e-5,
    // rust: "{kind}: {} != {expected}",
    // rust: m.ai.speed
    // rust: );
}
}
}
