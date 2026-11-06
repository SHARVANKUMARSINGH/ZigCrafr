//! Transpiled from Horizon Rust crate
package horizon_client_core_particle_type

import "core:fmt"
import "core:mem"
import "core:math"

// Particle types (`ParticleTypes`): the vanilla particle types with a client
// implementation, by registry name, and their per-type flags.

    // rust: macro_rules! particle_types {
    // rust: ($($variant:ident = $name:literal),* $(,)?) => {
        // Vanilla particle types with a client implementation here.
ParticleType :: enum {
    impl ParticleType {,
ALL :: &[$(ParticleType::$variant),*]
            // Registry path (`minecraft:<name>`), also the sprite-set file name.
    pub fn name(self) -> &'static str {,
    match self { $(ParticleType::$variant => $name),* },
}
from_name :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: match name { $($name => Some(ParticleType::$variant),)* _ => None }
}
}
}
}
    // rust: particle_types! {
    // rust: Block = "block",
    // rust: BlockCrumble = "block_crumble",
    // rust: Trail = "trail",
    // rust: DustPillar = "dust_pillar",
    // rust: FallingDust = "falling_dust",
    // rust: Smoke = "smoke",
    // rust: LargeSmoke = "large_smoke",
    // rust: WhiteSmoke = "white_smoke",
    // rust: Flame = "flame",
    // rust: SoulFireFlame = "soul_fire_flame",
    // rust: CopperFireFlame = "copper_fire_flame",
    // rust: SmallFlame = "small_flame",
    // rust: Lava = "lava",
    // rust: DrippingWater = "dripping_water",
    // rust: FallingWater = "falling_water",
    // rust: DrippingLava = "dripping_lava",
    // rust: FallingLava = "falling_lava",
    // rust: LandingLava = "landing_lava",
    // rust: DrippingHoney = "dripping_honey",
    // rust: FallingHoney = "falling_honey",
    // rust: LandingHoney = "landing_honey",
    // rust: FallingNectar = "falling_nectar",
    // rust: FallingSporeBlossom = "falling_spore_blossom",
    // rust: SporeBlossomAir = "spore_blossom_air",
    // rust: DrippingObsidianTear = "dripping_obsidian_tear",
    // rust: FallingObsidianTear = "falling_obsidian_tear",
    // rust: LandingObsidianTear = "landing_obsidian_tear",
    // rust: DrippingDripstoneWater = "dripping_dripstone_water",
    // rust: FallingDripstoneWater = "falling_dripstone_water",
    // rust: DrippingDripstoneLava = "dripping_dripstone_lava",
    // rust: FallingDripstoneLava = "falling_dripstone_lava",
    // rust: Splash = "splash",
    // rust: Rain = "rain",
    // rust: Bubble = "bubble",
    // rust: SulfurBubbles = "sulfur_bubbles",
    // rust: NoxiousGas = "noxious_gas",
    // rust: NoxiousGasCloud = "noxious_gas_cloud",
    // rust: Geyser = "geyser",
    // rust: GeyserBase = "geyser_base",
    // rust: GeyserPoof = "geyser_poof",
    // rust: GeyserPlume = "geyser_plume",
    // rust: BubblePop = "bubble_pop",
    // rust: BubbleColumnUp = "bubble_column_up",
    // rust: CurrentDown = "current_down",
    // rust: Underwater = "underwater",
    // rust: Portal = "portal",
    // rust: ReversePortal = "reverse_portal",
    // rust: Enchant = "enchant",
    // rust: Nautilus = "nautilus",
    // rust: VaultConnection = "vault_connection",
    // rust: Crit = "crit",
    // rust: EnchantedHit = "enchanted_hit",
    // rust: DamageIndicator = "damage_indicator",
    // rust: Heart = "heart",
    // rust: AngryVillager = "angry_villager",
    // rust: HappyVillager = "happy_villager",
    // rust: Composter = "composter",
    // rust: Mycelium = "mycelium",
    // rust: Dolphin = "dolphin",
    // rust: EggCrack = "egg_crack",
    // rust: Poof = "poof",
    // rust: Explosion = "explosion",
    // rust: ExplosionEmitter = "explosion_emitter",
    // rust: CampfireCosySmoke = "campfire_cosy_smoke",
    // rust: CampfireSignalSmoke = "campfire_signal_smoke",
    // rust: Note = "note",
    // rust: Dust = "dust",
    // rust: TotemOfUndying = "totem_of_undying",
    // rust: Firework = "firework",
    // rust: EndRod = "end_rod",
    // rust: Ash = "ash",
    // rust: WhiteAsh = "white_ash",
    // rust: CrimsonSpore = "crimson_spore",
    // rust: WarpedSpore = "warped_spore",
    // rust: CherryLeaves = "cherry_leaves",
    // rust: PaleOakLeaves = "pale_oak_leaves",
    // rust: TintedLeaves = "tinted_leaves",
    // rust: Effect = "effect",
    // rust: InstantEffect = "instant_effect",
    // rust: EntityEffect = "entity_effect",
    // rust: Witch = "witch",
    // rust: Infested = "infested",
    // rust: Cloud = "cloud",
    // rust: Sneeze = "sneeze",
    // rust: Snowflake = "snowflake",
    // rust: Soul = "soul",
    // rust: SculkSoul = "sculk_soul",
    // rust: DragonBreath = "dragon_breath",
    // rust: Gust = "gust",
    // rust: SmallGust = "small_gust",
    // rust: GustEmitterLarge = "gust_emitter_large",
    // rust: GustEmitterSmall = "gust_emitter_small",
    // rust: DustColorTransition = "dust_color_transition",
    // rust: SculkCharge = "sculk_charge",
    // rust: SculkChargePop = "sculk_charge_pop",
    // rust: Shriek = "shriek",
    // rust: SonicBoom = "sonic_boom",
    // rust: Vibration = "vibration",
    // rust: SweepAttack = "sweep_attack",
    // rust: Glow = "glow",
    // rust: WaxOn = "wax_on",
    // rust: WaxOff = "wax_off",
    // rust: ElectricSpark = "electric_spark",
    // rust: Scrape = "scrape",
    // rust: SquidInk = "squid_ink",
    // rust: GlowSquidInk = "glow_squid_ink",
    // rust: Item = "item",
    // rust: ItemSlime = "item_slime",
    // rust: ItemSnowball = "item_snowball",
    // rust: ItemCobweb = "item_cobweb",
    // rust: SulfurCubeGoo = "sulfur_cube_goo",
    // rust: Flash = "flash",
    // rust: Firefly = "firefly",
    // rust: TrialSpawnerDetection = "trial_spawner_detection",
    // rust: TrialSpawnerDetectionOminous = "trial_spawner_detection_ominous",
    // rust: TrialOmen = "trial_omen",
    // rust: RaidOmen = "raid_omen",
    // rust: OminousSpawning = "ominous_spawning",
    // rust: Spit = "spit",
    // rust: Fishing = "fishing",
    // rust: DustPlume = "dust_plume",
    // rust: RedPoplarLeaves = "red_poplar_leaves",
    // rust: OrangePoplarLeaves = "orange_poplar_leaves",
    // rust: YellowPoplarLeaves = "yellow_poplar_leaves",
    // rust: PauseMobGrowth = "pause_mob_growth",
    // rust: ResetMobGrowth = "reset_mob_growth",
    // rust: BlockMarker = "block_marker",
}
    // rust: impl ParticleType {
    // `ParticleType.getOverrideLimiter` (`ParticleTypes.register(name, true)`):
    // spawned regardless of distance.
override_limiter :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self,
    // rust: Self::BlockMarker
    // rust: | Self::Geyser
    // rust: | Self::GeyserBase
    // rust: | Self::GeyserPoof
    // rust: | Self::GeyserPlume
    // rust: | Self::DamageIndicator
    // rust: | Self::ExplosionEmitter
    // rust: | Self::Explosion
    // rust: | Self::Gust
    // rust: | Self::GustEmitterLarge
    // rust: | Self::GustEmitterSmall
    // rust: | Self::SonicBoom
    // rust: | Self::SculkCharge
    // rust: | Self::SculkChargePop
    // rust: | Self::Vibration
    // rust: | Self::Poof
    // rust: | Self::Spit
    // rust: | Self::SquidInk
    // rust: | Self::SweepAttack
    // rust: | Self::CampfireCosySmoke
    // rust: | Self::CampfireSignalSmoke
    // rust: | Self::GlowSquidInk
    // rust: | Self::Glow
    // rust: | Self::WaxOn
    // rust: | Self::WaxOff
    // rust: | Self::ElectricSpark
    // rust: | Self::Scrape
    // rust: | Self::TrialSpawnerDetection
    // rust: | Self::TrialSpawnerDetectionOminous
    // rust: | Self::VaultConnection
    // rust: | Self::OminousSpawning
    // rust: )
}
    // `SingleQuadParticle.Layer.translucent`: types whose vanilla particle class
    // hardcodes the translucent layer, drawn after translucent terrain.
    // `TerrainParticle`, `BreakingItemParticle` and `BlockMarker` resolve their
    // layer from the sprite instead (`Layer.bySprite`); see the `translucent`
    // sprite set on the engine.
translucent_layer :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
            // CampfireSmokeParticle.
    // rust: Self::CampfireCosySmoke | Self::CampfireSignalSmoke
            // PlayerCloudParticle.
    // rust: | Self::Cloud | Self::Sneeze
            // SpellParticle.
    // rust: | Self::Effect | Self::InstantEffect | Self::EntityEffect
    // rust: | Self::Witch | Self::Infested | Self::TrialOmen | Self::RaidOmen
            // NoxiousGasParticle.
    // rust: | Self::NoxiousGas
            // EmissiveRisingParticle.
    // rust: | Self::Soul | Self::SculkSoul
            // SculkChargeParticle, SculkChargePopParticle, ShriekParticle,
            // VibrationSignalParticle, FireflyParticle, OverlayParticle.
    // rust: | Self::SculkCharge | Self::SculkChargePop | Self::Shriek
    // rust: | Self::Vibration | Self::Firefly | Self::Flash
            // SimpleAnimatedParticle and its subclasses: EndRodParticle,
            // SparkParticle (firework), SquidInkParticle, TotemParticle.
    // rust: | Self::EndRod | Self::Firework | Self::SquidInk | Self::GlowSquidInk
    // rust: | Self::TotemOfUndying
            // FlyTowardsPositionParticle: its LifetimeAlpha(0, 0.6, 0.25, 1) is not opaque.
    // rust: | Self::VaultConnection => true,
    // rust: _ => false,
}
}
}
