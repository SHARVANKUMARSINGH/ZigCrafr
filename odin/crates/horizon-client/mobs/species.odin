//! Transpiled from Horizon Rust crate
package horizon_client_species

import "core:fmt"
import "core:mem"
import "core:math"

// Supported vanilla mob types: model layers, default textures, animation
// family, sounds, baby dimensions and the per-class constants
// (`getMaxHeadXRot`, `getAmbientSoundInterval`, `getWaterSlowDown`...).
// use super::{Brain, Flags, anim::Anim};

Species :: enum {
    Tadpole,
    ZombieHorse,
    SkeletonHorse,
    Giant,
    Pig,
    Cow,
    Mooshroom,
    Sheep,
    Chicken,
    Rabbit,
    Horse,
    Donkey,
    Mule,
    Llama,
    TraderLlama,
    Goat,
    Panda,
    PolarBear,
    Fox,
    Wolf,
    Cat,
    Ocelot,
    Parrot,
    Bee,
    Turtle,
    Armadillo,
    Frog,
    Axolotl,
    Squid,
    GlowSquid,
    Cod,
    Salmon,
    TropicalFish,
    Pufferfish,
    Dolphin,
    Bat,
    Villager,
    WanderingTrader,
    IronGolem,
    SnowGolem,
    CopperGolem,
    Zombie,
    Husk,
    Drowned,
    ZombieVillager,
    Skeleton,
    Stray,
    Bogged,
    Parched,
    WitherSkeleton,
    Creeper,
    Spider,
    CaveSpider,
    Enderman,
    Endermite,
    Silverfish,
    Slime,
    MagmaCube,
    Witch,
    Phantom,
    Pillager,
    Vindicator,
    Piglin,
    PiglinBrute,
    ZombifiedPiglin,
    Hoglin,
    Zoglin,
    Ghast,
    Blaze,
    Strider,
    Guardian,
    ElderGuardian,
    Shulker,
    Evoker,
    Illusioner,
    Vex,
    Ravager,
    Wither,
    Camel,
    Allay,
    Breeze,
    Sniffer,
    HappyGhast,
    Warden,
    Creaking,
    CamelHusk,
    Nautilus,
    ZombieNautilus,
    SulfurCube,
    Mannequin,
}
// Baby bounding boxes (each class's BABY_DIMENSIONS).
Baby :: enum {
    // Not an ageable mob.
    None,
    // EntityDimensions.scalable(w, h).withEyeHeight(e)
    Abs(f64, f64, f64),
    // The adult dimensions scaled, with an optional explicit eye height.
    Scale(f64, Option<f64>),
}
Def :: struct {
    species: Species,
    name: ^'static str,
    model: ^'static str,
    texture: ^'static str,
    anim: Anim,
    sounds: [^'static str,
    step_sound: Maybe(^'static str),
    baby: Baby,
}
    // rust: macro_rules! def {
    // rust: ($s:ident, $name:literal, $model:literal, $tex:literal, $anim:expr, [$a:literal, $h:literal, $d:literal], $step:expr, $baby:expr) => {
    // rust: Def {
    // rust: species: Species::$s,
    // rust: name: $name,
    // rust: model: $model,
    // rust: texture: $tex,
    // rust: anim: $anim,
    // rust: sounds: [$a, $h, $d],
    // rust: step_sound: $step,
    // rust: baby: $baby,
}
}
}
// use Anim as A;
    // rust: pub const ALL: &[Def] = &[
    // rust: def!(
    // rust: Pig,
    // rust: "pig",
    // rust: "pig#main",
    // rust: "entity/pig/pig_temperate",
    // rust: A::Quadruped,
    // rust: ["entity.pig.ambient", "entity.pig.hurt", "entity.pig.death"],
    // rust: Some("entity.pig.step"),
    // rust: Baby::Abs(0.45, 0.45, 0.40625)
    // rust: ),
    // rust: def!(
    // rust: Cow,
    // rust: "cow",
    // rust: "cow#main",
    // rust: "entity/cow/cow_temperate",
    // rust: A::Quadruped,
    // rust: ["entity.cow.ambient", "entity.cow.hurt", "entity.cow.death"],
    // rust: Some("entity.cow.step"),
    // rust: Baby::Abs(0.45, 0.7, 0.69)
    // rust: ),
    // rust: def!(
    // rust: Mooshroom,
    // rust: "mooshroom",
    // rust: "mooshroom#main",
    // rust: "entity/cow/mooshroom_red",
    // rust: A::Quadruped,
    // rust: ["entity.cow.ambient", "entity.cow.hurt", "entity.cow.death"],
    // rust: Some("entity.cow.step"),
    // rust: Baby::Abs(0.45, 0.7, 0.69)
    // rust: ),
    // rust: def!(
    // rust: Sheep,
    // rust: "sheep",
    // rust: "sheep#main",
    // rust: "entity/sheep/sheep",
    // rust: A::Sheep,
    // rust: [
    // rust: "entity.sheep.ambient",
    // rust: "entity.sheep.hurt",
    // rust: "entity.sheep.death"
    // rust: ],
    // rust: Some("entity.sheep.step"),
    // rust: Baby::Abs(0.45, 0.65, 0.65625)
    // rust: ),
    // rust: def!(
    // rust: Chicken,
    // rust: "chicken",
    // rust: "chicken#main",
    // rust: "entity/chicken/chicken_temperate",
    // rust: A::Chicken,
    // rust: [
    // rust: "entity.chicken.ambient",
    // rust: "entity.chicken.hurt",
    // rust: "entity.chicken.death"
    // rust: ],
    // rust: Some("entity.chicken.step"),
    // rust: Baby::Abs(0.3, 0.4, 0.28125)
    // rust: ),
    // rust: def!(
    // rust: Rabbit,
    // rust: "rabbit",
    // rust: "rabbit#main",
    // rust: "entity/rabbit/rabbit_brown",
    // rust: A::Rabbit,
    // rust: [
    // rust: "entity.rabbit.ambient",
    // rust: "entity.rabbit.hurt",
    // rust: "entity.rabbit.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Abs(0.24, 0.4, 0.39)
    // rust: ),
    // rust: def!(
    // rust: ZombieHorse,
    // rust: "zombie_horse",
    // rust: "zombie_horse#main",
    // rust: "entity/horse/horse_zombie",
    // rust: A::Horse,
    // rust: [
    // rust: "entity.zombie_horse.ambient",
    // rust: "entity.zombie_horse.hurt",
    // rust: "entity.zombie_horse.death"
    // rust: ],
    // rust: Some("entity.horse.step"),
    // rust: Baby::Scale(0.7, None)
    // rust: ),
    // rust: def!(
    // rust: SkeletonHorse,
    // rust: "skeleton_horse",
    // rust: "skeleton_horse#main",
    // rust: "entity/horse/horse_skeleton",
    // rust: A::Horse,
    // rust: [
    // rust: "entity.skeleton_horse.ambient",
    // rust: "entity.skeleton_horse.hurt",
    // rust: "entity.skeleton_horse.death"
    // rust: ],
    // rust: Some("entity.horse.step"),
    // rust: Baby::Scale(0.7, None)
    // rust: ),
    // rust: def!(
    // rust: Giant,
    // rust: "giant",
    // rust: "giant#main",
    // rust: "entity/zombie/zombie",
    // rust: A::Humanoid { zombie_arms: true },
    // rust: ["", "entity.generic.hurt", "entity.generic.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Horse,
    // rust: "horse",
    // rust: "horse#main",
    // rust: "entity/horse/horse_brown",
    // rust: A::Horse,
    // rust: [
    // rust: "entity.horse.ambient",
    // rust: "entity.horse.hurt",
    // rust: "entity.horse.death"
    // rust: ],
    // rust: Some("entity.horse.step"),
    // rust: Baby::Scale(0.7, None)
    // rust: ),
    // rust: def!(
    // rust: Donkey,
    // rust: "donkey",
    // rust: "donkey#main",
    // rust: "entity/horse/donkey",
    // rust: A::Horse,
    // rust: [
    // rust: "entity.donkey.ambient",
    // rust: "entity.donkey.hurt",
    // rust: "entity.donkey.death"
    // rust: ],
    // rust: Some("entity.horse.step"),
    // rust: Baby::Scale(0.5, None)
    // rust: ),
    // rust: def!(
    // rust: Mule,
    // rust: "mule",
    // rust: "mule#main",
    // rust: "entity/horse/mule",
    // rust: A::Horse,
    // rust: [
    // rust: "entity.mule.ambient",
    // rust: "entity.mule.hurt",
    // rust: "entity.mule.death"
    // rust: ],
    // rust: Some("entity.horse.step"),
    // rust: Baby::Scale(0.5, None)
    // rust: ),
    // rust: def!(
    // rust: Llama,
    // rust: "llama",
    // rust: "llama#main",
    // rust: "entity/llama/llama_creamy",
    // rust: A::Llama,
    // rust: [
    // rust: "entity.llama.ambient",
    // rust: "entity.llama.hurt",
    // rust: "entity.llama.death"
    // rust: ],
    // rust: Some("entity.llama.step"),
    // rust: Baby::Scale(0.5, None)
    // rust: ),
    // rust: def!(
    // rust: TraderLlama,
    // rust: "trader_llama",
    // rust: "trader_llama#main",
    // rust: "entity/llama/llama_creamy",
    // rust: A::Llama,
    // rust: [
    // rust: "entity.llama.ambient",
    // rust: "entity.llama.hurt",
    // rust: "entity.llama.death"
    // rust: ],
    // rust: Some("entity.llama.step"),
    // rust: Baby::Scale(0.5, None)
    // rust: ),
    // rust: def!(
    // rust: Goat,
    // rust: "goat",
    // rust: "goat#main",
    // rust: "entity/goat/goat",
    // rust: A::Goat,
    // rust: [
    // rust: "entity.goat.ambient",
    // rust: "entity.goat.hurt",
    // rust: "entity.goat.death"
    // rust: ],
    // rust: Some("entity.goat.step"),
    // rust: Baby::Abs(0.45, 0.65, 0.59375)
    // rust: ),
    // rust: def!(
    // rust: Panda,
    // rust: "panda",
    // rust: "panda#main",
    // rust: "entity/panda/panda",
    // rust: A::Panda,
    // rust: [
    // rust: "entity.panda.ambient",
    // rust: "entity.panda.hurt",
    // rust: "entity.panda.death"
    // rust: ],
    // rust: Some("entity.panda.step"),
    // rust: Baby::Scale(0.5, Some(0.28125))
    // rust: ),
    // rust: def!(
    // rust: PolarBear,
    // rust: "polar_bear",
    // rust: "polar_bear#main",
    // rust: "entity/bear/polarbear",
    // rust: A::PolarBear,
    // rust: [
    // rust: "entity.polar_bear.ambient",
    // rust: "entity.polar_bear.hurt",
    // rust: "entity.polar_bear.death"
    // rust: ],
    // rust: Some("entity.polar_bear.step"),
    // rust: Baby::Abs(0.7, 0.7, 0.34375)
    // rust: ),
    // rust: def!(
    // rust: Fox,
    // rust: "fox",
    // rust: "fox#main",
    // rust: "entity/fox/fox",
    // rust: A::Fox,
    // rust: ["entity.fox.ambient", "entity.fox.hurt", "entity.fox.death"],
    // rust: None,
    // rust: Baby::Scale(0.6, Some(0.34375))
    // rust: ),
    // rust: def!(
    // rust: Wolf,
    // rust: "wolf",
    // rust: "wolf#main",
    // rust: "entity/wolf/wolf",
    // rust: A::Wolf,
    // rust: [
    // rust: "entity.wolf.ambient",
    // rust: "entity.wolf.hurt",
    // rust: "entity.wolf.death"
    // rust: ],
    // rust: Some("entity.wolf.step"),
    // rust: Baby::Abs(0.3, 0.425, 0.34375)
    // rust: ),
    // rust: def!(
    // rust: Cat,
    // rust: "cat",
    // rust: "cat#main",
    // rust: "entity/cat/cat_tabby",
    // rust: A::Feline,
    // rust: ["entity.cat.ambient", "entity.cat.hurt", "entity.cat.death"],
    // rust: None,
    // rust: Baby::Abs(0.3, 0.35, 0.34375)
    // rust: ),
    // rust: def!(
    // rust: Ocelot,
    // rust: "ocelot",
    // rust: "ocelot#main",
    // rust: "entity/cat/ocelot",
    // rust: A::Feline,
    // rust: [
    // rust: "entity.ocelot.ambient",
    // rust: "entity.ocelot.hurt",
    // rust: "entity.ocelot.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Abs(0.3, 0.35, 0.34375)
    // rust: ),
    // rust: def!(
    // rust: Parrot,
    // rust: "parrot",
    // rust: "parrot#main",
    // rust: "entity/parrot/parrot_red_blue",
    // rust: A::Parrot,
    // rust: [
    // rust: "entity.parrot.ambient",
    // rust: "entity.parrot.hurt",
    // rust: "entity.parrot.death"
    // rust: ],
    // rust: Some("entity.parrot.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Bee,
    // rust: "bee",
    // rust: "bee#main",
    // rust: "entity/bee/bee",
    // rust: A::Bee,
    // rust: ["", "entity.bee.hurt", "entity.bee.death"],
    // rust: None,
    // rust: Baby::Scale(0.5, None)
    // rust: ),
    // rust: def!(
    // rust: Turtle,
    // rust: "turtle",
    // rust: "turtle#main",
    // rust: "entity/turtle/turtle",
    // rust: A::Turtle,
    // rust: [
    // rust: "entity.turtle.ambient_land",
    // rust: "entity.turtle.hurt",
    // rust: "entity.turtle.death"
    // rust: ],
    // rust: Some("entity.turtle.shamble"),
    // rust: Baby::Scale(0.3, None)
    // rust: ),
    // rust: def!(
    // rust: Armadillo,
    // rust: "armadillo",
    // rust: "armadillo#main",
    // rust: "entity/armadillo/armadillo",
    // rust: A::Armadillo,
    // rust: [
    // rust: "entity.armadillo.ambient",
    // rust: "entity.armadillo.hurt",
    // rust: "entity.armadillo.death"
    // rust: ],
    // rust: Some("entity.armadillo.step"),
    // rust: Baby::Scale(0.6, Some(0.21875))
    // rust: ),
    // rust: def!(
    // rust: Frog,
    // rust: "frog",
    // rust: "frog#main",
    // rust: "entity/frog/frog_temperate",
    // rust: A::Frog,
    // rust: [
    // rust: "entity.frog.ambient",
    // rust: "entity.frog.hurt",
    // rust: "entity.frog.death"
    // rust: ],
    // rust: Some("entity.frog.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Axolotl,
    // rust: "axolotl",
    // rust: "axolotl#main",
    // rust: "entity/axolotl/axolotl_lucy",
    // rust: A::Axolotl,
    // rust: [
    // rust: "entity.axolotl.idle_water",
    // rust: "entity.axolotl.hurt",
    // rust: "entity.axolotl.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Abs(0.375, 0.21, 0.09375)
    // rust: ),
    // rust: def!(
    // rust: Squid,
    // rust: "squid",
    // rust: "squid#main",
    // rust: "entity/squid/squid",
    // rust: A::Squid,
    // rust: [
    // rust: "entity.squid.ambient",
    // rust: "entity.squid.hurt",
    // rust: "entity.squid.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Abs(0.5, 0.5, 0.37)
    // rust: ),
    // rust: def!(
    // rust: GlowSquid,
    // rust: "glow_squid",
    // rust: "glow_squid#main",
    // rust: "entity/squid/glow_squid",
    // rust: A::Squid,
    // rust: [
    // rust: "entity.glow_squid.ambient",
    // rust: "entity.glow_squid.hurt",
    // rust: "entity.glow_squid.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Abs(0.5, 0.5, 0.37)
    // rust: ),
    // rust: def!(
    // rust: Tadpole,
    // rust: "tadpole",
    // rust: "tadpole#main",
    // rust: "entity/tadpole/tadpole",
    // rust: A::Fish,
    // rust: ["", "entity.tadpole.hurt", "entity.tadpole.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Cod,
    // rust: "cod",
    // rust: "cod#main",
    // rust: "entity/fish/cod",
    // rust: A::Fish,
    // rust: ["entity.cod.ambient", "entity.cod.hurt", "entity.cod.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Salmon,
    // rust: "salmon",
    // rust: "salmon#main",
    // rust: "entity/fish/salmon",
    // rust: A::Fish,
    // rust: [
    // rust: "entity.salmon.ambient",
    // rust: "entity.salmon.hurt",
    // rust: "entity.salmon.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: TropicalFish,
    // rust: "tropical_fish",
    // rust: "tropical_fish_small#main",
    // rust: "entity/fish/tropical_a",
    // rust: A::Fish,
    // rust: [
    // rust: "entity.tropical_fish.ambient",
    // rust: "entity.tropical_fish.hurt",
    // rust: "entity.tropical_fish.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Pufferfish,
    // rust: "pufferfish",
    // rust: "pufferfish_big#main",
    // rust: "entity/fish/pufferfish",
    // rust: A::Pufferfish,
    // rust: ["", "entity.puffer_fish.hurt", "entity.puffer_fish.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Dolphin,
    // rust: "dolphin",
    // rust: "dolphin#main",
    // rust: "entity/dolphin/dolphin",
    // rust: A::Dolphin,
    // rust: [
    // rust: "entity.dolphin.ambient_water",
    // rust: "entity.dolphin.hurt",
    // rust: "entity.dolphin.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Scale(0.65, Some(0.093_75))
    // rust: ),
    // rust: def!(
    // rust: Bat,
    // rust: "bat",
    // rust: "bat#main",
    // rust: "entity/bat/bat",
    // rust: A::Bat,
    // rust: ["entity.bat.ambient", "entity.bat.hurt", "entity.bat.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Villager,
    // rust: "villager",
    // rust: "villager#main",
    // rust: "entity/villager/villager",
    // rust: A::Villager,
    // rust: [
    // rust: "entity.villager.ambient",
    // rust: "entity.villager.hurt",
    // rust: "entity.villager.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Abs(0.49, 0.98, 0.63)
    // rust: ),
    // rust: def!(
    // rust: WanderingTrader,
    // rust: "wandering_trader",
    // rust: "wandering_trader#main",
    // rust: "entity/wandering_trader/wandering_trader",
    // rust: A::Villager,
    // rust: [
    // rust: "entity.wandering_trader.ambient",
    // rust: "entity.wandering_trader.hurt",
    // rust: "entity.wandering_trader.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: IronGolem,
    // rust: "iron_golem",
    // rust: "iron_golem#main",
    // rust: "entity/iron_golem/iron_golem",
    // rust: A::IronGolem,
    // rust: ["", "entity.iron_golem.hurt", "entity.iron_golem.death"],
    // rust: Some("entity.iron_golem.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: SnowGolem,
    // rust: "snow_golem",
    // rust: "snow_golem#main",
    // rust: "entity/snow_golem/snow_golem",
    // rust: A::SnowGolem,
    // rust: [
    // rust: "entity.snow_golem.ambient",
    // rust: "entity.snow_golem.hurt",
    // rust: "entity.snow_golem.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: CopperGolem,
    // rust: "copper_golem",
    // rust: "copper_golem#main",
    // rust: "entity/copper_golem/copper_golem",
    // rust: A::CopperGolem,
    // rust: ["", "entity.copper_golem.hurt", "entity.copper_golem.death"],
    // rust: Some("entity.copper_golem.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Zombie,
    // rust: "zombie",
    // rust: "zombie#main",
    // rust: "entity/zombie/zombie",
    // rust: A::Zombie,
    // rust: [
    // rust: "entity.zombie.ambient",
    // rust: "entity.zombie.hurt",
    // rust: "entity.zombie.death"
    // rust: ],
    // rust: Some("entity.zombie.step"),
    // rust: Baby::Abs(0.49, 0.98, 0.775)
    // rust: ),
    // rust: def!(
    // rust: Husk,
    // rust: "husk",
    // rust: "husk#main",
    // rust: "entity/zombie/husk",
    // rust: A::Zombie,
    // rust: [
    // rust: "entity.husk.ambient",
    // rust: "entity.husk.hurt",
    // rust: "entity.husk.death"
    // rust: ],
    // rust: Some("entity.husk.step"),
    // rust: Baby::Abs(0.49, 0.98, 0.825)
    // rust: ),
    // rust: def!(
    // rust: Drowned,
    // rust: "drowned",
    // rust: "drowned#main",
    // rust: "entity/zombie/drowned",
    // rust: A::Drowned,
    // rust: [
    // rust: "entity.drowned.ambient",
    // rust: "entity.drowned.hurt",
    // rust: "entity.drowned.death"
    // rust: ],
    // rust: Some("entity.drowned.step"),
    // rust: Baby::Abs(0.49, 0.98, 0.775)
    // rust: ),
    // rust: def!(
    // rust: ZombieVillager,
    // rust: "zombie_villager",
    // rust: "zombie_villager#main",
    // rust: "entity/zombie_villager/zombie_villager",
    // rust: A::ZombieVillager,
    // rust: [
    // rust: "entity.zombie_villager.ambient",
    // rust: "entity.zombie_villager.hurt",
    // rust: "entity.zombie_villager.death"
    // rust: ],
    // rust: Some("entity.zombie_villager.step"),
    // rust: Baby::Abs(0.49, 0.98, 0.67)
    // rust: ),
    // rust: def!(
    // rust: Skeleton,
    // rust: "skeleton",
    // rust: "skeleton#main",
    // rust: "entity/skeleton/skeleton",
    // rust: A::Skeleton,
    // rust: [
    // rust: "entity.skeleton.ambient",
    // rust: "entity.skeleton.hurt",
    // rust: "entity.skeleton.death"
    // rust: ],
    // rust: Some("entity.skeleton.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Stray,
    // rust: "stray",
    // rust: "stray#main",
    // rust: "entity/skeleton/stray",
    // rust: A::Skeleton,
    // rust: [
    // rust: "entity.stray.ambient",
    // rust: "entity.stray.hurt",
    // rust: "entity.stray.death"
    // rust: ],
    // rust: Some("entity.stray.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Parched,
    // rust: "parched",
    // rust: "parched#main",
    // rust: "entity/skeleton/parched",
    // rust: A::Skeleton,
    // rust: [
    // rust: "entity.parched.ambient",
    // rust: "entity.parched.hurt",
    // rust: "entity.parched.death"
    // rust: ],
    // rust: Some("entity.parched.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Bogged,
    // rust: "bogged",
    // rust: "bogged#main",
    // rust: "entity/skeleton/bogged",
    // rust: A::Skeleton,
    // rust: [
    // rust: "entity.bogged.ambient",
    // rust: "entity.bogged.hurt",
    // rust: "entity.bogged.death"
    // rust: ],
    // rust: Some("entity.bogged.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: WitherSkeleton,
    // rust: "wither_skeleton",
    // rust: "wither_skeleton#main",
    // rust: "entity/skeleton/wither_skeleton",
    // rust: A::Skeleton,
    // rust: [
    // rust: "entity.wither_skeleton.ambient",
    // rust: "entity.wither_skeleton.hurt",
    // rust: "entity.wither_skeleton.death"
    // rust: ],
    // rust: Some("entity.wither_skeleton.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Creeper,
    // rust: "creeper",
    // rust: "creeper#main",
    // rust: "entity/creeper/creeper",
    // rust: A::Creeper,
    // rust: ["", "entity.creeper.hurt", "entity.creeper.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Spider,
    // rust: "spider",
    // rust: "spider#main",
    // rust: "entity/spider/spider",
    // rust: A::Spider,
    // rust: [
    // rust: "entity.spider.ambient",
    // rust: "entity.spider.hurt",
    // rust: "entity.spider.death"
    // rust: ],
    // rust: Some("entity.spider.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: CaveSpider,
    // rust: "cave_spider",
    // rust: "cave_spider#main",
    // rust: "entity/spider/cave_spider",
    // rust: A::Spider,
    // rust: [
    // rust: "entity.spider.ambient",
    // rust: "entity.spider.hurt",
    // rust: "entity.spider.death"
    // rust: ],
    // rust: Some("entity.spider.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Enderman,
    // rust: "enderman",
    // rust: "enderman#main",
    // rust: "entity/enderman/enderman",
    // rust: A::Enderman,
    // rust: [
    // rust: "entity.enderman.ambient",
    // rust: "entity.enderman.hurt",
    // rust: "entity.enderman.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Endermite,
    // rust: "endermite",
    // rust: "endermite#main",
    // rust: "entity/endermite/endermite",
    // rust: A::Silverfish,
    // rust: [
    // rust: "entity.endermite.ambient",
    // rust: "entity.endermite.hurt",
    // rust: "entity.endermite.death"
    // rust: ],
    // rust: Some("entity.endermite.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Silverfish,
    // rust: "silverfish",
    // rust: "silverfish#main",
    // rust: "entity/silverfish/silverfish",
    // rust: A::Silverfish,
    // rust: [
    // rust: "entity.silverfish.ambient",
    // rust: "entity.silverfish.hurt",
    // rust: "entity.silverfish.death"
    // rust: ],
    // rust: Some("entity.silverfish.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Slime,
    // rust: "slime",
    // rust: "slime#main",
    // rust: "entity/slime/slime",
    // rust: A::Slime,
    // rust: ["", "entity.slime.hurt", "entity.slime.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: MagmaCube,
    // rust: "magma_cube",
    // rust: "magma_cube#main",
    // rust: "entity/slime/magmacube",
    // rust: A::MagmaCube,
    // rust: ["", "entity.magma_cube.hurt", "entity.magma_cube.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Witch,
    // rust: "witch",
    // rust: "witch#main",
    // rust: "entity/witch/witch",
    // rust: A::Witch,
    // rust: [
    // rust: "entity.witch.ambient",
    // rust: "entity.witch.hurt",
    // rust: "entity.witch.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Phantom,
    // rust: "phantom",
    // rust: "phantom#main",
    // rust: "entity/phantom/phantom",
    // rust: A::Phantom,
    // rust: [
    // rust: "entity.phantom.ambient",
    // rust: "entity.phantom.hurt",
    // rust: "entity.phantom.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Evoker,
    // rust: "evoker",
    // rust: "evoker#main",
    // rust: "entity/illager/evoker",
    // rust: A::Illager,
    // rust: [
    // rust: "entity.evoker.ambient",
    // rust: "entity.evoker.hurt",
    // rust: "entity.evoker.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Illusioner,
    // rust: "illusioner",
    // rust: "illusioner#main",
    // rust: "entity/illager/illusioner",
    // rust: A::Illager,
    // rust: [
    // rust: "entity.illusioner.ambient",
    // rust: "entity.illusioner.hurt",
    // rust: "entity.illusioner.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Allay,
    // rust: "allay",
    // rust: "allay#main",
    // rust: "entity/allay/allay",
    // rust: A::Allay,
    // rust: [
    // rust: "entity.allay.ambient_without_item",
    // rust: "entity.allay.hurt",
    // rust: "entity.allay.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Creaking,
    // rust: "creaking",
    // rust: "creaking#main",
    // rust: "entity/creaking/creaking",
    // rust: A::Creaking,
    // rust: [
    // rust: "entity.creaking.ambient",
    // rust: "entity.generic.hurt",
    // rust: "entity.creaking.death"
    // rust: ],
    // rust: Some("entity.creaking.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Camel,
    // rust: "camel",
    // rust: "camel#main",
    // rust: "entity/camel/camel",
    // rust: A::Camel,
    // rust: [
    // rust: "entity.camel.ambient",
    // rust: "entity.camel.hurt",
    // rust: "entity.camel.death"
    // rust: ],
    // rust: Some("entity.camel.step"),
    // rust: Baby::Abs(0.95, 1.4, 1.38)
    // rust: ),
    // rust: def!(
    // rust: HappyGhast,
    // rust: "happy_ghast",
    // rust: "happy_ghast#main",
    // rust: "entity/ghast/happy_ghast",
    // rust: A::HappyGhast,
    // rust: [
    // rust: "entity.happy_ghast.ambient",
    // rust: "entity.happy_ghast.hurt",
    // rust: "entity.happy_ghast.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Scale(0.2375, Some(0.46875))
    // rust: ),
    // rust: def!(
    // rust: Sniffer,
    // rust: "sniffer",
    // rust: "sniffer#main",
    // rust: "entity/sniffer/sniffer",
    // rust: A::Sniffer,
    // rust: [
    // rust: "entity.sniffer.idle",
    // rust: "entity.sniffer.hurt",
    // rust: "entity.sniffer.death"
    // rust: ],
    // rust: Some("entity.sniffer.step"),
    // rust: Baby::Scale(0.5, None)
    // rust: ),
    // rust: def!(
    // rust: Breeze,
    // rust: "breeze",
    // rust: "breeze#main",
    // rust: "entity/breeze/breeze",
    // rust: A::Breeze,
    // rust: [
    // rust: "entity.breeze.idle_ground",
    // rust: "entity.breeze.hurt",
    // rust: "entity.breeze.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Wither,
    // rust: "wither",
    // rust: "wither#main",
    // rust: "entity/wither/wither",
    // rust: A::Wither,
    // rust: [
    // rust: "entity.wither.ambient",
    // rust: "entity.wither.hurt",
    // rust: "entity.wither.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Ravager,
    // rust: "ravager",
    // rust: "ravager#main",
    // rust: "entity/illager/ravager",
    // rust: A::Ravager,
    // rust: [
    // rust: "entity.ravager.ambient",
    // rust: "entity.ravager.hurt",
    // rust: "entity.ravager.death"
    // rust: ],
    // rust: Some("entity.ravager.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Vex,
    // rust: "vex",
    // rust: "vex#main",
    // rust: "entity/illager/vex",
    // rust: A::Vex,
    // rust: ["entity.vex.ambient", "entity.vex.hurt", "entity.vex.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Shulker,
    // rust: "shulker",
    // rust: "shulker#main",
    // rust: "entity/shulker/shulker",
    // rust: A::Shulker,
    // rust: [
    // rust: "entity.shulker.ambient",
    // rust: "entity.shulker.hurt",
    // rust: "entity.shulker.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Guardian,
    // rust: "guardian",
    // rust: "guardian#main",
    // rust: "entity/guardian/guardian",
    // rust: A::Guardian,
    // rust: [
    // rust: "entity.guardian.ambient",
    // rust: "entity.guardian.hurt",
    // rust: "entity.guardian.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: ElderGuardian,
    // rust: "elder_guardian",
    // rust: "elder_guardian#main",
    // rust: "entity/guardian/guardian_elder",
    // rust: A::Guardian,
    // rust: [
    // rust: "entity.elder_guardian.ambient",
    // rust: "entity.elder_guardian.hurt",
    // rust: "entity.elder_guardian.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Pillager,
    // rust: "pillager",
    // rust: "pillager#main",
    // rust: "entity/illager/pillager",
    // rust: A::Illager,
    // rust: [
    // rust: "entity.pillager.ambient",
    // rust: "entity.pillager.hurt",
    // rust: "entity.pillager.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Vindicator,
    // rust: "vindicator",
    // rust: "vindicator#main",
    // rust: "entity/illager/vindicator",
    // rust: A::Illager,
    // rust: [
    // rust: "entity.vindicator.ambient",
    // rust: "entity.vindicator.hurt",
    // rust: "entity.vindicator.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Piglin,
    // rust: "piglin",
    // rust: "piglin#main",
    // rust: "entity/piglin/piglin",
    // rust: A::Piglin,
    // rust: [
    // rust: "entity.piglin.ambient",
    // rust: "entity.piglin.hurt",
    // rust: "entity.piglin.death"
    // rust: ],
    // rust: Some("entity.piglin.step"),
    // rust: Baby::Abs(0.49, 0.98, 0.78)
    // rust: ),
    // rust: def!(
    // rust: PiglinBrute,
    // rust: "piglin_brute",
    // rust: "piglin_brute#main",
    // rust: "entity/piglin/piglin_brute",
    // rust: A::Piglin,
    // rust: [
    // rust: "entity.piglin_brute.ambient",
    // rust: "entity.piglin_brute.hurt",
    // rust: "entity.piglin_brute.death"
    // rust: ],
    // rust: Some("entity.piglin_brute.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: ZombifiedPiglin,
    // rust: "zombified_piglin",
    // rust: "zombified_piglin#main",
    // rust: "entity/piglin/zombified_piglin",
    // rust: A::ZombifiedPiglin,
    // rust: [
    // rust: "entity.zombified_piglin.ambient",
    // rust: "entity.zombified_piglin.hurt",
    // rust: "entity.zombified_piglin.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Abs(0.49, 0.98, 0.78)
    // rust: ),
    // rust: def!(
    // rust: Hoglin,
    // rust: "hoglin",
    // rust: "hoglin#main",
    // rust: "entity/hoglin/hoglin",
    // rust: A::Hoglin,
    // rust: [
    // rust: "entity.hoglin.ambient",
    // rust: "entity.hoglin.hurt",
    // rust: "entity.hoglin.death"
    // rust: ],
    // rust: Some("entity.hoglin.step"),
    // rust: Baby::Abs(0.75, 0.85, 0.625)
    // rust: ),
    // rust: def!(
    // rust: Zoglin,
    // rust: "zoglin",
    // rust: "zoglin#main",
    // rust: "entity/hoglin/zoglin",
    // rust: A::Hoglin,
    // rust: [
    // rust: "entity.zoglin.ambient",
    // rust: "entity.zoglin.hurt",
    // rust: "entity.zoglin.death"
    // rust: ],
    // rust: Some("entity.zoglin.step"),
    // rust: Baby::Abs(0.75, 0.85, 0.625)
    // rust: ),
    // rust: def!(
    // rust: Ghast,
    // rust: "ghast",
    // rust: "ghast#main",
    // rust: "entity/ghast/ghast",
    // rust: A::Ghast,
    // rust: [
    // rust: "entity.ghast.ambient",
    // rust: "entity.ghast.hurt",
    // rust: "entity.ghast.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Blaze,
    // rust: "blaze",
    // rust: "blaze#main",
    // rust: "entity/blaze/blaze",
    // rust: A::Blaze,
    // rust: [
    // rust: "entity.blaze.ambient",
    // rust: "entity.blaze.hurt",
    // rust: "entity.blaze.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Strider,
    // rust: "strider",
    // rust: "strider#main",
    // rust: "entity/strider/strider",
    // rust: A::Strider,
    // rust: [
    // rust: "entity.strider.ambient",
    // rust: "entity.strider.hurt",
    // rust: "entity.strider.death"
    // rust: ],
    // rust: Some("entity.strider.step"),
    // rust: Baby::Abs(0.45, 0.85, 0.4375)
    // rust: ),
    // rust: def!(
    // rust: Warden,
    // rust: "warden",
    // rust: "warden#main",
    // rust: "entity/warden/warden",
    // rust: A::Warden,
    // rust: [
    // rust: "entity.warden.ambient",
    // rust: "entity.warden.hurt",
    // rust: "entity.warden.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // After the camel: the camel husk reuses `camel#main`.
    // rust: def!(
    // rust: CamelHusk,
    // rust: "camel_husk",
    // rust: "camel#main",
    // rust: "entity/camel/camel_husk",
    // rust: A::Camel,
    // rust: [
    // rust: "entity.camel_husk.ambient",
    // rust: "entity.camel_husk.hurt",
    // rust: "entity.camel_husk.death"
    // rust: ],
    // rust: Some("entity.camel_husk.step"),
    // rust: Baby::None
    // rust: ),
    // rust: def!(
    // rust: Nautilus,
    // rust: "nautilus",
    // rust: "nautilus#main",
    // rust: "entity/nautilus/nautilus",
    // rust: A::Nautilus,
    // rust: [
    // rust: "entity.nautilus.ambient",
    // rust: "entity.nautilus.hurt",
    // rust: "entity.nautilus.death"
    // rust: ],
    // rust: None,
    // rust: Baby::Scale(0.5, None)
    // rust: ),
    // rust: def!(
    // rust: ZombieNautilus,
    // rust: "zombie_nautilus",
    // rust: "zombie_nautilus#main",
    // rust: "entity/nautilus/zombie_nautilus",
    // rust: A::Nautilus,
    // rust: [
    // rust: "entity.zombie_nautilus.ambient",
    // rust: "entity.zombie_nautilus.hurt",
    // rust: "entity.zombie_nautilus.death"
    // rust: ],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // Babies are size 1 and adults size 2: the size scales the dimensions.
    // rust: def!(
    // rust: SulfurCube,
    // rust: "sulfur_cube",
    // rust: "sulfur_cube#main",
    // rust: "entity/sulfur_cube/sulfur_cube_outer",
    // rust: A::Slime,
    // rust: ["", "entity.sulfur_cube.hurt", "entity.sulfur_cube.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // Mannequin: the player model; the DATA_PROFILE ResolvableProfile picks
    // its skin, this texture only while that has none.
    // rust: def!(
    // rust: Mannequin,
    // rust: "mannequin",
    // rust: "player#main",
    // rust: "entity/player/wide/steve",
    // rust: A::Humanoid { zombie_arms: false },
    // rust: ["", "entity.generic.hurt", "entity.generic.death"],
    // rust: None,
    // rust: Baby::None
    // rust: ),
    // rust: ];
def :: proc(s: Species) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: ALL.iter().find(|d| d.species == s).unwrap_or(&ALL[0])
}
// The vanilla entity type of a species, `minecraft:` and its [`Def::name`].
vanilla_id :: proc(s: Species) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: static IDS: std::sync::LazyLock<Vec<String>> = std::sync::LazyLock::new(|| {
    // rust: ALL.iter()
    // rust: .map(|d| format!("minecraft:{}", d.name))
    // rust: .collect()
    // rust: });
    // rust: let index = ALL.iter().position(|d| d.species == s).unwrap_or(0);
    // rust: &IDS[index]
}
    // rust: impl Def {
    // Model layer families to load for this entity (adult, baby, variants).
layer_prefixes :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let base = self.model.split('#').next().unwrap_or(self.name);
    // rust: let mut v = vec![base];
    // rust: let extra: &[&str] = match self.species {
    // rust: Species::Pig => &["pig_baby", "cold_pig"],
    // rust: Species::Mannequin => &["player_slim"],
    // rust: Species::Cow => &[
    // rust: "cow_baby",
    // rust: "cold_cow",
    // rust: "cold_cow_baby",
    // rust: "warm_cow",
    // rust: "warm_cow_baby",
    // rust: ],
    // rust: Species::Mooshroom => &["mooshroom_baby"],
    // rust: Species::Sheep => &["sheep_baby"],
    // rust: Species::Chicken => &["chicken_baby", "cold_chicken"],
    // rust: Species::Rabbit => &["rabbit_baby"],
    // rust: Species::Horse => &["horse_baby", "horse_armor"],
    // rust: Species::Donkey => &["donkey_baby"],
    // rust: Species::Mule => &["mule_baby"],
    // rust: Species::Llama => &["llama_baby"],
    // rust: Species::TraderLlama => &["trader_llama_baby", "llama", "llama_baby"],
    // rust: Species::Goat => &["goat_baby"],
    // rust: Species::Panda => &["panda_baby"],
    // rust: Species::PolarBear => &["polar_bear_baby"],
    // rust: Species::Fox => &["fox_baby"],
    // rust: Species::Wolf => &["wolf_baby", "wolf_armor"],
    // rust: Species::Sniffer => &["sniffer_baby"],
    // rust: Species::HappyGhast => &[
    // rust: "happy_ghast_baby",
    // rust: "happy_ghast_harness",
    // rust: "happy_ghast_ropes",
    // rust: "happy_ghast_baby_harness",
    // rust: "happy_ghast_baby_ropes",
    // rust: ],
    // rust: Species::Cat => &["cat_baby"],
    // rust: Species::Ocelot => &["ocelot_baby"],
    // rust: Species::Bee => &["bee_baby"],
    // rust: Species::Turtle => &["turtle_baby"],
    // rust: Species::Armadillo => &["armadillo_baby"],
    // rust: Species::Axolotl => &["axolotl_baby"],
    // rust: Species::Squid => &["squid_baby"],
    // rust: Species::GlowSquid => &["glow_squid_baby"],
    // rust: Species::Salmon => &["salmon_small", "salmon_large"],
    // rust: Species::TropicalFish => &["tropical_fish_large"],
    // rust: Species::Pufferfish => &["pufferfish_small", "pufferfish_medium"],
    // rust: Species::Dolphin => &["dolphin_baby"],
    // rust: Species::Villager => &["villager_baby", "villager_no_hat", "villager_baby_no_hat"],
    // rust: Species::Zombie => &["zombie_baby"],
    // rust: Species::Husk => &["husk_baby"],
    // rust: Species::Drowned => &["drowned_baby"],
    // rust: Species::ZombieVillager => &[
    // rust: "zombie_villager_baby",
    // rust: "zombie_villager_no_hat",
    // rust: "zombie_villager_baby_no_hat",
    // rust: ],
    // rust: Species::Piglin => &["piglin_baby"],
    // rust: Species::ZombifiedPiglin => &["zombified_piglin_baby"],
    // rust: Species::Hoglin => &["hoglin_baby"],
    // rust: Species::Zoglin => &["zoglin_baby"],
    // rust: Species::Strider => &["strider_baby"],
    // rust: Species::Camel => &["camel_baby"],
    // rust: Species::CamelHusk => &["camel_husk"],
    // rust: Species::Nautilus => &["nautilus_baby", "nautilus_armor"],
    // rust: Species::ZombieNautilus => &["zombie_nautilus_coral", "nautilus_armor", "nautilus"],
    // rust: Species::SulfurCube => &["sulfur_cube_small"],
    // rust: Species::ZombieHorse => &["zombie_horse_baby", "undead_horse_armor"],
    // rust: Species::SkeletonHorse => &["skeleton_horse_baby", "undead_horse_armor"],
    // rust: _ => &[],
}
    // rust: v.extend_from_slice(extra);
    // rust: v
}
flags :: proc(self: ^Self, fire_immune: bool) -> F {
    // Ported from Horizon
    return {}
}
//         use Species as S;
    // rust: let s = self.species;
    // rust: let undead = matches!(
    // rust: s,
    // rust: S::Zombie
    // rust: | S::Husk
    // rust: | S::Drowned
    // rust: | S::ZombieVillager
    // rust: | S::Skeleton
    // rust: | S::Stray
    // rust: | S::Bogged
    // rust: | S::Parched
    // rust: | S::WitherSkeleton
    // rust: | S::ZombieHorse
    // rust: | S::SkeletonHorse
    // rust: | S::Phantom
    // rust: | S::ZombifiedPiglin
    // rust: | S::Zoglin
    // rust: | S::Wither
    // rust: | S::CamelHusk
    // rust: | S::ZombieNautilus
    // rust: );
    // rust: let aquatic = matches!(
    // rust: s,
    // rust: S::Squid
    // rust: | S::GlowSquid
    // rust: | S::Cod
    // rust: | S::Tadpole
    // rust: | S::Salmon
    // rust: | S::TropicalFish
    // rust: | S::Pufferfish
    // rust: | S::Dolphin
    // rust: );
    // rust: Flags {
    // rust: aquatic_swimmer: aquatic,
    // rust: fall_immune: matches!(
    // rust: s,
    // rust: S::Chicken
    // rust: | S::Bat
    // rust: | S::Parrot
    // rust: | S::Bee
    // rust: | S::Ghast
    // rust: | S::HappyGhast
    // rust: | S::Blaze
    // rust: | S::Phantom
    // rust: | S::IronGolem
    // rust: | S::Cat
    // rust: | S::Ocelot
    // rust: | S::Slime
    // rust: | S::MagmaCube
    // rust: | S::Wither
    // rust: | S::Allay
    // rust: | S::Breeze
    // rust: ),
    // rust: flying: matches!(s, S::Ghast | S::Phantom | S::HappyGhast),
    // rust: climber: matches!(s, S::Spider | S::CaveSpider),
    // rust: lava_walker: s == S::Strider,
    // rust: omnidirectional: matches!(s, S::Bee | S::Parrot),
    // rust: fire_immune: fire_immune
    // rust: || matches!(
    // rust: s,
    // rust: S::Ghast
    // rust: | S::Blaze
    // rust: | S::MagmaCube
    // rust: | S::Strider
    // rust: | S::WitherSkeleton
    // rust: | S::ZombifiedPiglin
    // rust: | S::Zoglin
    // rust: | S::Wither
    // rust: ),
            // The `burn_in_daylight` entity type tag.
    // rust: burns_in_day: matches!(
    // rust: s,
    // rust: S::Zombie
    // rust: | S::ZombieHorse
    // rust: | S::Drowned
    // rust: | S::ZombieVillager
    // rust: | S::Skeleton
    // rust: | S::Stray
    // rust: | S::Bogged
    // rust: | S::WitherSkeleton
    // rust: | S::Phantom
    // rust: | S::ZombieNautilus
    // rust: ),
    // rust: undead,
            // `#can_breathe_under_water`, and the iron golem, whose
            // `decreaseAirSupply` keeps its air. Not the dolphin: it holds its
            // breath (4800 ticks) and surfaces for air.
    // rust: breathes_water: (aquatic && s != S::Dolphin)
    // rust: || undead
    // rust: || matches!(
    // rust: s,
    // rust: S::Axolotl
    // rust: | S::Frog
    // rust: | S::Turtle
    // rust: | S::Guardian
    // rust: | S::ElderGuardian
    // rust: | S::IronGolem
    // rust: | S::CopperGolem
    // rust: | S::Nautilus
    // rust: ),
            // WaterAnimal.handleAirSupply: it dries out on land; Nautilus's
            // does the same. Dolphin.handleAirSupply is empty, so a dolphin
            // takes LivingEntity.baseTick's air like a land mob.
    // rust: needs_water: (aquatic && s != S::Dolphin) || s == S::Nautilus,
    // rust: water_sensitive: matches!(s, S::Enderman | S::Blaze | S::SnowGolem | S::Strider),
    // rust: animal: !matches!(s, S::Bat | S::SulfurCube | S::Mannequin)
    // rust: && !self.hostile_class()
    // rust: && !aquatic
    // rust: && !matches!(
    // rust: s,
    // rust: S::Villager | S::WanderingTrader | S::IronGolem | S::SnowGolem | S::CopperGolem
    // rust: ),
}
}
hostile_class :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
//         use Species as S;
    // rust: matches!(
    // rust: self.species,
    // rust: S::Zombie
    // rust: | S::Husk
    // rust: | S::Drowned
    // rust: | S::ZombieVillager
    // rust: | S::Skeleton
    // rust: | S::Stray
    // rust: | S::Bogged
    // rust: | S::Parched
    // rust: | S::WitherSkeleton
    // rust: | S::Creeper
    // rust: | S::Spider
    // rust: | S::CaveSpider
    // rust: | S::Enderman
    // rust: | S::Endermite
    // rust: | S::Silverfish
    // rust: | S::Slime
    // rust: | S::MagmaCube
    // rust: | S::Witch
    // rust: | S::Phantom
    // rust: | S::Pillager
    // rust: | S::Vindicator
    // rust: | S::Piglin
    // rust: | S::PiglinBrute
    // rust: | S::ZombifiedPiglin
    // rust: | S::Hoglin
    // rust: | S::Zoglin
    // rust: | S::Ghast
    // rust: | S::Blaze
    // rust: | S::Guardian
    // rust: | S::ElderGuardian
    // rust: | S::Shulker
    // rust: | S::Evoker
    // rust: | S::Illusioner
    // rust: | S::Vex
    // rust: | S::Ravager
    // rust: | S::Wither
    // rust: | S::Warden
    // rust: | S::Breeze
    // rust: | S::Creaking
    // rust: )
}
    // The item tag Animal.isFood tests.
food_tag :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
//         use Species as S;
    // rust: Some(match self.species {
    // rust: S::Pig => "pig_food",
    // rust: S::Cow | S::Mooshroom => "cow_food",
    // rust: S::Sheep => "sheep_food",
    // rust: S::Chicken => "chicken_food",
    // rust: S::Rabbit => "rabbit_food",
    // rust: S::Horse | S::Donkey | S::Mule => "horse_food",
    // rust: S::Llama | S::TraderLlama => "llama_food",
    // rust: S::Goat => "goat_food",
    // rust: S::Sniffer => "sniffer_food",
    // rust: S::HappyGhast => "happy_ghast_food",
    // rust: S::CamelHusk => "camel_husk_food",
    // rust: S::Nautilus | S::ZombieNautilus => "nautilus_food",
    // rust: S::SulfurCube => "sulfur_cube_food",
    // rust: S::Panda => "panda_food",
    // rust: S::Fox => "fox_food",
    // rust: S::Wolf => "wolf_food",
    // rust: S::Cat => "cat_food",
    // rust: S::Ocelot => "ocelot_food",
    // rust: S::Parrot => "parrot_food",
    // rust: S::Bee => "bee_food",
    // rust: S::Turtle => "turtle_food",
    // rust: S::Armadillo => "armadillo_food",
    // rust: S::Frog | S::Tadpole => "frog_food",
    // rust: S::Axolotl => "axolotl_food",
    // rust: S::Hoglin => "hoglin_food",
    // rust: S::Strider => "strider_food",
    // rust: S::Piglin => "piglin_food",
    // rust: _ => return None,
    // rust: })
}
tempt_tag :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match self.species {
    // rust: Species::Horse | Species::Donkey | Species::Mule => "horse_tempt_items",
    // rust: Species::Llama | Species::TraderLlama => "llama_tempt_items",
    // rust: Species::Strider => "strider_tempt_items",
            // An adult sulfur cube follows what it can swallow.
    // rust: Species::SulfurCube => "sulfur_cube_swallowable",
    // rust: _ => return None,
    // rust: })
}
water_slowdown :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.species {
    // rust: Species::PolarBear => 0.98,
            // SkeletonHorse.getWaterSlowDown.
    // rust: Species::SkeletonHorse => 0.96,
    // rust: _ => 0.8,
}
}
air_speed :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.species {
    // rust: Species::Phantom => 0.2,
    // rust: Species::HappyGhast => super::happy_ghast::AIR_SPEED,
    // rust: _ => 0.02,
}
}
baby_scale :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.baby {
    // rust: Baby::Scale(s, _) => s,
    // rust: _ => 0.5,
}
}
head_rot_speed :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.species {
    // rust: Species::Frog => 35.0,
    // rust: Species::Breeze => 25.0,
    // rust: _ => 10.0,
}
}
max_head_x_rot :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.species {
    // rust: Species::Dolphin | Species::Axolotl => 1.0,
    // rust: Species::Slime | Species::MagmaCube | Species::SulfurCube => 0.0,
    // rust: Species::Guardian | Species::ElderGuardian | Species::Shulker => 180.0,
    // rust: _ => 40.0,
}
}
max_head_y_rot :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.species {
    // rust: Species::Dolphin | Species::Axolotl => 1.0,
    // rust: Species::Frog => 5.0,
    // rust: Species::Breeze => 30.0,
    // rust: Species::Sniffer => 50.0,
    // rust: Species::Goat => 15.0,
    // rust: Species::Armadillo => 32.0,
    // rust: Species::Ravager => 45.0,
    // rust: Species::Camel | Species::CamelHusk => 30.0,
    // rust: Species::Shulker => 180.0,
    // rust: _ => 75.0,
}
}
ambient_interval :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
//         use Species as S;
    // rust: match self.species {
    // rust: S::Turtle => 200,
            // AbstractHorse.getAmbientSoundInterval, for every subclass.
    // rust: S::Horse
    // rust: | S::Donkey
    // rust: | S::Mule
    // rust: | S::ZombieHorse
    // rust: | S::SkeletonHorse
    // rust: | S::Llama
    // rust: | S::TraderLlama
    // rust: | S::Camel
    // rust: | S::CamelHusk => 400,
    // rust: S::Ocelot => 900,
            // Guardian.getAmbientSoundInterval (the elder too).
    // rust: S::Guardian | S::ElderGuardian => 160,
            // Hoglin extends Animal; Shulker extends AbstractGolem.
    // rust: S::Hoglin | S::Shulker => 120,
            // Allay is a PathfinderMob: the Mob default.
    // rust: S::Allay => 80,
    // rust: S::Squid
    // rust: | S::GlowSquid
    // rust: | S::Cod
    // rust: | S::Tadpole
    // rust: | S::Salmon
    // rust: | S::TropicalFish
    // rust: | S::Pufferfish
    // rust: | S::Dolphin
    // rust: | S::Axolotl
    // rust: | S::IronGolem
    // rust: | S::SnowGolem
    // rust: | S::CopperGolem => 120,
    // rust: _ if self.flags(false).animal => 120,
    // rust: _ => 80,
}
}
brain :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: match self.species {
    // rust: Species::Chicken => Brain::Chicken,
    // rust: Species::Zombie | Species::Husk | Species::Drowned | Species::ZombieVillager => {
    // rust: Brain::Zombie
}
    // rust: Species::Skeleton | Species::Stray | Species::Bogged | Species::Parched => {
    // rust: Brain::Skeleton
}
    // rust: Species::Spider | Species::CaveSpider => Brain::Spider,
    // rust: Species::Creeper => Brain::Creeper,
    // rust: _ => Brain::Passive,
}
}
}
// Mobs whose `body` equipment slot Horizon keeps in `Extra::head` (a
// happy ghast's harness, nautilus armour, a sulfur cube's swallowed block,
// a wolf's armor).
body_slot :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::HappyGhast
    // rust: | Species::Nautilus
    // rust: | Species::ZombieNautilus
    // rust: | Species::SulfurCube
    // rust: | Species::Wolf
    // rust: )
}
