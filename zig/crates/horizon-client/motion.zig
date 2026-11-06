//! Transpiled from Horizon Rust crate
//! Module: horizon-client_motion
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Stored movement state for the resident scene. This binds the validated air,
//! jump, collision, support, restitution and stored health bindings, and
//! powder snow's block-inside effects and freezing. Entity lifecycle, other
//! block-inside effects and audiovisual event consumers remain separate work.
// use crate::{Result, assets::Assets, collisions::SceneCollisions, world::World};
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Direction, Vec3, VoxelShape, traverse_blocks, trig},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_world::{
    // rust: attribute_map::ValueKind,
    // rust: attributes::{Modifier, Operation, entity::Catalog, live::LiveAttributes},
    // rust: block_collision::BlockCollisionRegistry,
    // rust: block_landing::BlockLandingRegistry,
    // rust: climbing::{self, ClimbingRegistry, ClimbingWorld},
    // rust: collision_context::{CollisionContext, CollisionEntity, CollisionItem},
    // rust: edge_backoff::{self, EdgeBackoffInput, EdgeBackoffWorld},
    // rust: entity_move::{self, CollisionFlags, EntityMoveWorld, MovementHistory, MoverType},
    // rust: entity_obstruction::EntityIdentity,
    // rust: ground_support::{GroundState, find_supporting_block},
    // rust: living_air::{self, LivingAirWorld},
    // rust: living_fall::ImpulseContext,
    // rust: living_motion::{self, LivingMotionWorld},
    // rust: movement_emission::{
    // rust: self as emission, MovementDistances, MovementEmission, MovementEmissionWorld, MovementEvent,
    // rust: },
    // rust: movement_properties::{
    // rust: BoundMovementProperties, MovementBlockProvider, MovementProperties, MovementTags,
    // rust: RegistryMovementWorld,
    // rust: },
    // rust: movement_restitution::{self, RestitutionInput, RestitutionWorld},
    // rust: movement_statistics::{self, MovementStat, MovementStatisticsWorld},
    // rust: movement_support::{self, MovementLocation},
    // rust: registry::{BlockStateId, BlockTableFile},
    // rust: world_movement::{self, MovementRequest},
    // rust: worldgen::tags::TagDefinitions,
}
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: io,
    // rust: path::Path,
    // rust: sync::Arc,
}

/// A living entity jumped (`LivingEvent.LivingJumpEvent`). 359.
pub fn native_living_jump(entity: u32, kind: []const u8) void {
}
    // rust: crate::native_client_hooks::living_jump(entity, kind);
}

    // rust: pub(crate) mod environment;
    // rust: mod fluids;
    // rust: pub use fluids::{
    // rust: BubbleColumn, FluidResources, FluidTags, LAVA, PlayerFluids, RiddenBoat, WATER,
    // rust: bubble_column_at, bubble_column_push, bubble_column_push_over, bubble_column_surfaces,
}

pub const MotionResources = struct {
    attributes: *Catalog,
    blocks: BoundMovementProperties,
    climbable: BTreeSet<[]const u8>,
    /// The bound BlockTags.CAUSES_SUFFOCATION predicate input.
    causes_suffocation: BTreeSet<[]const u8>,
    /// `BlockTags.SOUL_SPEED_BLOCKS`: what Soul Speed's effects look for.
    soul_speed_blocks: BTreeSet<[]const u8>,
    /// `LivingEntity.onClimbable` tags plus open trapdoors above a ladder.
    climbing: ClimbingRegistry<'static>,
    fall_reset: BTreeSet<[]const u8>,
    /// `BlockTags.INSIDE_STEP_SOUND_BLOCKS`.
    inside_step_sound: BTreeSet<[]const u8>,
    /// `BlockTags.COMBINATION_STEP_SOUND_BLOCKS`.
    combination_step_sound: BTreeSet<[]const u8>,
    /// `BlockTags.CRYSTAL_SOUND_BLOCKS`: blocks that chime under footsteps.
    crystal_sound: BTreeSet<[]const u8>,
    landing: BlockLandingRegistry,
    health: crate::health::HealthResources,
    fluids: FluidResources,
};
    // rust: impl MotionResources {
    /// [`Self::load_with_facts`] with the block facts decoded here.
pub fn load(root: *Path, assets: *Assets) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::load_with_facts(
    // rust: root,
    // rust: assets,
    // rust: &crate::blocks::BlockFacts::load(root, assets.registry)?,
    // rust: )
}
    /// The motion tables, with the block facts the game already decoded
    /// (decoding `gameplay-facts.json` again costs a second or more and, with
    /// a big modpack, hundreds of megabytes while it runs).
    // rust: pub fn load_with_facts(
    // rust: root: &Path,
    // rust: assets: &Assets,
    // rust: facts: &crate::blocks::BlockFacts,
    // rust: ) -> Result<Self> {
    // rust: let attributes = Arc::new(Catalog::from_json(&horizon_world::json_file::read(
    // rust: &root.join("attributes.json"),
    // rust: )?)?);
    // rust: let file = BlockTableFile::open(&root.join("movement-properties.nbt"), assets.registry)?;
    // rust: let properties = MovementProperties::from_table(file.table("movement")?)?;
    // rust: let bundle: BTreeMap<String, String> =
    // rust: horizon_world::json_file::read(&root.join("block-tags.json"))?;
    // rust: let mut definitions = TagDefinitions::default();
    // rust: for (name, text) in bundle {
    // rust: definitions.apply_json(&name, "vanilla", &text)?;
}
    // rust: let built = definitions
    // rust: .build(|name, _| assets.registry.default_state(name).map(|_| name.to_owned()))?;
    // rust: if !built.missing.is_empty() {
    // rust: return Err("unresolved motion block tags".into());
}
    // rust: let tag = |name: &str| -> Result<BTreeSet<String>> {
    // rust: Ok(built
    // rust: .tags
    // rust: .get(name)
    // rust: .ok_or_else(|| format!("missing motion tag {name}"))?
    // rust: .iter()
    // rust: .cloned()
    // rust: .collect())
}
    // rust: let climbing = ClimbingRegistry::new(
    // rust: assets.registry,
    // rust: &tag("minecraft:trapdoors")?,
    // rust: &tag("minecraft:climbable")?,
    // rust: &tag("minecraft:can_glide_through")?,
    // rust: )?;
    // rust: Ok(Self {
    // rust: landing: crate::landing::load(root, &properties)?,
    // rust: health: crate::health::HealthResources::load(root)?,
    // rust: fluids: FluidResources::new(assets, facts)?,
    // rust: attributes,
    // rust: blocks: properties.bind(&MovementTags {
    // rust: fences: tag("minecraft:fences")?,
    // rust: walls: tag("minecraft:walls")?,
    // rust: suppresses_bounce: tag("minecraft:suppresses_bounce")?,
    // rust: })?,
    // rust: climbable: tag("minecraft:climbable")?,
    // rust: causes_suffocation: tag("minecraft:causes_suffocation")?,
    // rust: soul_speed_blocks: tag("minecraft:soul_speed_blocks")?,
    // rust: climbing,
    // rust: fall_reset: tag("minecraft:fall_damage_resetting")?,
    // rust: inside_step_sound: tag("minecraft:inside_step_sound_blocks")?,
    // rust: combination_step_sound: tag("minecraft:combination_step_sound_blocks")?,
    // rust: crystal_sound: tag("minecraft:crystal_sound_blocks")?,
    // rust: })
}
}

/// What the `location_changed` enchantment effects (Soul Speed) need to know
/// between ticks.
pub const LocationEffects = struct {
    /// `MovementAffectedByPredicate`: the block under the player
    /// (`getBlockPosBelowThatAffectsMyMovement`) is in `#minecraft:soul_speed_blocks`.
    on_soul_speed_block: bool,
    /// `LivingEntity.lastPos`: the block the player was in last tick.
    block: ?BlockPos,
    /// A landing ran `onChangedBlock` (`LivingEntity.checkFallDamage`).
    landed: bool,
    /// The Soul Speed level of the boots seen last tick (0: none).
    boots_level: u32,
    /// The Soul Speed level whose attribute modifiers are on the player (0: none).
    applied_level: u32,
};

/// Ordered requests and phase records for world/audio/network consumers. Landing
/// hurt dispatch updates stored health synchronously before these are drained.
pub const MotionEvent = enum {
    Waypoint {,
    receiver: bool,
    enabled: bool,
    // rust: },
    Health(crate::health::HealthEvent),
    /// `LivingEntity.handleDamageEvent`: the hurt sound the player hears.
    HurtSound(&'static str),
    Fall(crate::landing::FallEvent),
    Recorded {,
    mover: MoverType,
    movement: Vec3,
    // rust: },
    Landing {,
    dy: f64,
    grounded: bool,
    state: BlockStateId,
    position: BlockPos,
    // rust: },
    /// `Entity.walkingStepSound` on this block: `Player.playStepSound`
    /// mutes it (`playMuffledStepSound`) under a swim sound in water or
    /// under a combination block's own step.
    Emission {,
    position: BlockPos,
    state: BlockStateId,
    muffled: bool,
    // rust: },
    /// `Entity.playAmethystStepSound`: `block.amethyst_block.chime`.
    Chime {,
    volume: f32,
    pitch: f32,
    // rust: },
    /// `Entity.waterSwimSound`: `entity.player.swim`.
    Swim {,
    volume: f32,
    pitch: f32,
    // rust: },
    Bounce {,
    position: BlockPos,
    state: BlockStateId,
    fall_distance: f64,
    // rust: },
    /// `PowderSnowBlock.entityInside`'s server particle: one snowflake at
    /// `position` with `velocity` (`RandomizationType.ALTERNATIVE`).
    Snowflake {,
    position: Vec3,
    velocity: Vec3,
    // rust: },
    /// `ServerPlayer.onInsideBlock`: the enter_block criterion trigger.
    EnterBlock {,
    state: BlockStateId,
    // rust: },
    /// `NetherPortalBlock.entityInside`: the player's box swept through a
    /// nether portal block.
    InsidePortal {,
    pos: BlockPos,
    // rust: },
    /// `LayeredCauldronBlock.handleEntityOnFireInside`: a burning player in
    /// a water or powder snow cauldron; the server lowers its fill level.
    CauldronExtinguish {,
    pos: BlockPos,
    // rust: },
    /// `WitherRoseBlock.entityInside`: the player's box swept through a
    /// wither rose; the server adds its Wither unless peaceful.
    InsideWitherRose,
    /// `ServerPlayer.checkFallDamage` after a mace smash: block particles
    /// from the landing block, more the further the fall.
    SmashLanding {,
    state: BlockStateId,
    position: BlockPos,
    fall_distance: f64,
    // rust: },
    /// `Entity.doWaterSplashEffect`: the player's splash (or high-speed
    /// splash) sound at its position...
    Splash {,
    high_speed: bool,
    volume: f32,
    pitch: f32,
    // rust: },
    /// ...its BUBBLE (else SPLASH) particles...
    SplashParticle {,
    bubble: bool,
    position: Vec3,
    velocity: Vec3,
    // rust: },
    /// ...and the SPLASH game event.
    SplashEvent,
    /// `Entity.sendBubbleColumnParticles`: a SPLASH (or BUBBLE) particle
    /// over the top of a bubble column the player rides.
    BubbleColumnParticle {,
    bubble: bool,
    position: Vec3,
    // rust: },
    /// `HoneyBlock.maybeDoSlideEffects` for a player sliding down the side of
    /// the honey block at `pos`: its slide sound, and the server's entity
    /// event 53 (the five block particles at the player).
    HoneySlide {,
    pos: BlockPos,
    sound: bool,
    particles: bool,
    // rust: },
    /// Entity event 67 (`LivingEntity.makeDrownParticles`): eight bubbles
    /// around a drowning player.
    Drown,
};
pub const PlayerMotion = struct {
    swimming: bool,
    /// `Entity.isPassenger()`: this body rides a vehicle. `Entity.updateSwimming`
    /// needs it false, so the server's copy of a guest who boards a boat while
    /// swimming is not left in the swimming box in the seat (#4427).
    is_passenger: bool,
    fire_ticks: i32,
    air: i32,
    respiration: i32,

    position: Vec3,
    velocity: Vec3,
    ground: GroundState,
    collision: CollisionFlags,
    history: MovementHistory,
    fall_distance: f64,
    /// The block fallOn currently running, consumed by its damage call.
    // rust: pub(crate) block_landing: Option<(BlockStateId, BlockPos, f64)>,
    stuck_multiplier: Vec3,
    /// `Entity.pistonDeltas` and `pistonDeltasGameTime`: how far a moving
    /// block has pushed this entity this tick (0.51 at most on any axis).
    piston: horizon_world::piston_movement::PistonMovement,
    yaw: f32,
    head_yaw: f32,
    jumping: bool,
    no_jump_delay: i32,
    jump_trigger_time: i32,
    /// Abilities.mayfly / flying (creative flight).
    may_fly: bool,
    /// `Player.isMobilityRestricted`: blindness, which keeps a sprint from
    /// starting and stops one (`LocalPlayer.isSprintingPossible`).
    mobility_restricted: bool,
    /// Abilities.invulnerable (creative): only damage bypassing invulnerability hurts.
    invulnerable: bool,
    /// Spectator mode: no physics, always flying (`Player.tick`).
    spectator: bool,
    flying: bool,
    /// Client-side `Abilities.flyingSpeed`, adjusted by the spectator scroll wheel.
    flying_speed: f32,
    /// The jump key last tick (LocalPlayer.aiStep's wasJumping).
    was_jumping: bool,
    /// `LocalPlayer.autoJumpEnabled` (the Auto-Jump option) and
    /// `autoJumpTime`; `was_auto_jump` is this tick's `wasAutoJump`.
    auto_jump_enabled: bool,
    auto_jump_time: i32,
    was_auto_jump: bool,
    /// `input.getMoveVector()` this tick (before `modifyInput`).
    move_vector: [f32,
    /// `LocalPlayer.xxa` / `zza`: the move vector after `modifyInput`.
    applied_input: [f32,
    /// A usable glider (elytra) is worn; the game sets it each tick.
    glider: bool,
    /// The view pitch (xRot), for gliding.
    pitch: f32,
    /// Gliding (shared flag 7) and LivingEntity.fallFlyTicks.
    fall_flying: bool,
    /// Asleep in a bed (`LivingEntity.isSleeping`): the sleeping pose.
    sleeping: bool,
    fall_fly_ticks: i32,
    /// The server saw the glide end last tick (`updateFallFlying`'s `canGlide`
    /// failed): the cleared flag reaches the client at its next tick.
    glide_ending: bool,
    /// The server owns the glide flag (`Player.setSharedFlag(7, ...)` comes
    /// only from its `DATA_SHARED_FLAGS_ID`): the client of a server never
    /// ends a glide itself, as `LocalPlayer` does not —
    /// `LivingEntity.updateFallFlying` clears the flag on the server only, and
    /// the client applies the synced data when `SetEntityData` is handled.
    server_owns_glide: bool,
    /// Glider durability to take this tick (updateFallFlying).
    glider_wear: u32,
    /// Soul Speed's `location_changed` bookkeeping.
    location_effects: LocationEffects,
    /// `LivingEntity.autoSpinAttackTicks` and `autoSpinAttackDmg`: Riptide's
    /// spin. The damage stays until the game has dealt the hit.
    auto_spin_attack_ticks: i32,
    auto_spin_attack_dmg: f32,
    /// The living entities the game put near a spinning player (id, box).
    spin_targets: Vec<(u32,
    /// The entity the spin touched this tick (`doAutoAttackOnTouch`).
    spin_hit: ?u32,
    sprinting: bool,
    sprint_input: crate::sprint::SprintState,
    shift_key_down: bool,
    local_crouching: bool,
    pose: crate::pose::Pose,
    dimensions: crate::pose::Dimensions,
    /// The `minecraft:scale` the dimensions were last built with
    /// (`Entity.refreshDimensions`), for the poses the body takes before it
    /// next refreshes.
    scale: f32,
    speed: f32,
    /// `LocalPlayer.itemUseSpeedMultiplier` while using an item (not riding).
    item_use_speed: ?f32,
    /// `LocalPlayer.isSlowDueToUsingItem`: an item in use whose `use_effects`
    /// do not allow sprinting.
    item_use_slows_sprint: bool,
    /// `LocalPlayer.moveTowardsClosestSpace`'s new x and z speeds this tick,
    /// worked out by the caller (which knows the blocks); applied before the
    /// move.
    nudge: [?f64,
    last_climbable: ?BlockPos,
    /// Result of the latest `LivingEntity.onClimbable` query.
    on_climbable: bool,
    /// `Entity.moveDist`, `flyDist` and `nextStep`: footsteps come once per
    /// metre walked, not once per move.
    steps: MovementDistances,
    /// `Entity.crystalSoundIntensity` and `lastCrystalSoundPlayTick`: the
    /// amethyst chime grows with steps taken close together.
    crystal_sound_intensity: f32,
    last_crystal_sound_play_tick: i32,
    needs_sync: bool,
    sync_position: bool,
    /// Moved by an ender pearl (`ServerPlayer.teleport`): a server sends the
    /// position packet even when the player lands where they stood. The
    /// server takes it at the end of a guest's turn.
    teleported: bool,
    events: std.ArrayList(MotionEvent),
    attributes: LiveAttributes<*dyn horizon_world::attributes::live::Identities>,
    impulse: ImpulseContext,
    /// `ServerPlayer.spawnExtraParticlesOnFall`: a mace smash on a grounded
    /// target makes the next landing throw up the block below.
    spawn_extra_particles_on_fall: bool,
    health: crate::health::PlayerHealth,
    /// Status effects and armor protection seen by movement and damage.
    status: crate::effects::StatusFlags,
    /// Water and lava around the player (`Entity.fluidInteraction`).
    fluids: PlayerFluids,
    /// `Entity.isInPowderSnow` / `wasInPowderSnow`.
    in_powder_snow: bool,
    was_in_powder_snow: bool,
    /// `Entity.DATA_TICKS_FROZEN`.
    ticks_frozen: i32,
    /// Leather boots on the feet (`PowderSnowBlock.canEntityWalkOnPowderSnow`).
    leather_boots: bool,
    /// An armor piece in `#freeze_immune_wearables` (`LivingEntity.canFreeze`).
    freeze_immune: bool,
    /// A worn enchantment's `damage_immunity` to `#burn_from_stepping` (frost walker).
    burn_from_stepping_immune: bool,
    /// `Entity.oldPosition`: where this tick started.
    old_position: Vec3,
    /// The server's copy of a player another client moves (a LAN guest), while
    /// it travels on the server: `isLocalInstanceAuthoritative` is false, so
    /// its moves check no fall damage.
    server_copy: bool,
    /// A speculative anticheat replay, whose native callbacks must not escape.
    // rust: pub(crate) replaying: bool,
    /// The span of `events` a wall hit on the server's copy pushed (sound and
    /// damage): `server_travel` keeps them while it drops the simulated moves.
    wall_hit_events: ?std::ops::Range<usize>,
    /// A client's copy of its own player (`Level.isClientSide`): only the
    /// server hurts it (`Entity.hurt` does nothing on a client) and ticks its
    /// food (`ServerPlayer.tick`). Its hurt animation comes from the server.
    client_side: bool,
    /// The player's entity id (a guest's, set as its turn starts).
    entity_id: i32,
    /// The player's client has loaded the world since its last respawn or
    /// level change (`ServerGamePacketListenerImpl.hasClientLoaded`); a guest's
    /// turn takes it from its connection.
    client_loaded: bool,
    /// `Entity.applyEffectsFromBlocks` runs after travel (always in the game;
    /// differential fixtures turn it off where their reference does).
    block_effects: bool,
    /// The powder snow blocks this tick's movement went into: the game
    /// destroys them if the player is burning, then puts the fire out.
    powder_snow_entered: std.ArrayList(BlockPos),
    /// The last hurts taken (`hurt_blocking`), newest last, for tests and
    /// the control socket's `hurtlog`.
    hurt_log: std.ArrayList(crate::health::HurtRecord),
    /// The last melee attacks made on mobs, newest last.
    attack_log: std.ArrayList(crate::health::AttackRecord),
    /// The level's world border, whose walls stop the player's movement
    /// from inside (the game keeps it current; None: no border).
    border: ?horizon_core::geometry::border::BorderGeometry,
};
pub fn attribute_error(error: impl std::fmt::Debug) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: io::Error::other(format!("movement attribute: {error:?}"))
}
    // rust: impl PlayerMotion {
    /// `ServerGamePacketListenerImpl.handleMovePlayer`: the movement the client
    /// sent is the server copy's own delta movement. A glide's wall hit reads it
    /// as the speed the glide had (`LivingEntity.handleFallFlyingCollisions`'s
    /// moveHorLength); a copy whose travels start from its own last velocity
    /// otherwise keeps a few hundredths there, and no hit reaches the damage.
pub fn carry_client_movement(self: *Self, movement: Vec3) void {
}
    // rust: if self.fall_flying {
    // rust: self.velocity = movement;
}
}
    /// `Player.isSweepAttack`, using the resident player's known horizontal velocity.
pub fn is_sweep_attack(self: *Self, strength: f32, critical: bool, sword: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let movement = self.velocity;
    // rust: let limit = f64::from(self.speed) * 2.5;
    // rust: strength > 0.9
    // rust: && !critical
    // rust: && !self.sprinting
    // rust: && self.ground.on_ground
    // rust: && movement.x * movement.x + movement.z * movement.z < limit * limit
    // rust: && sword
}
    /// Restore login state once; a later respawn starts with fresh health and food.
    // rust: pub fn load_saved_state_once(
    // rust: &mut self,
    // rust: pending: &mut bool,
    // rust: level: &crate::save::Level,
    // rust: ) -> Result<()> {
    // rust: if std::mem::take(pending) {
    // rust: let extra = level.player_extra.as_ref();
    // rust: self.fire_ticks = extra
    // rust: .and_then(|t| crate::save::number(t.get("Fire")))
    // rust: .unwrap_or(-20) as i32;
    // rust: self.air = extra
    // rust: .and_then(|t| crate::save::number(t.get("Air")))
    // rust: .unwrap_or(300) as i32;
    // rust: self.fall_distance = level.fall_distance;
            // LivingEntity.readAdditionalSaveData applies the saved attributes
            // before it reads the health (a raised max_health keeps its hearts).
    // rust: self.apply_saved_attributes(extra.and_then(|t| t.get("attributes")))?;
    // rust: self.set_health(level.health, false)?;
            // LivingEntity.readAdditionalSaveData: internalSetAbsorptionAmount.
    // rust: self.internal_set_absorption(level.absorption)?;
    // rust: self.health.food.food = level.food;
    // rust: self.health.food.saturation = level.saturation;
    // rust: self.flying = level.flying;
}
    // rust: Ok(())
}
pub fn set_remaining_fire_ticks(self: *Self, ticks: i32) void {
}
    // rust: self.fire_ticks = if self.invulnerable {
    // rust: ticks.min(1)
    // rust: } else {
    // rust: ticks
}
}
pub fn ignite_for_ticks(self: *Self, ticks: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let scaled = (f64::from(ticks) * self.attribute("minecraft:burning_time")?).ceil() as i32;
    // rust: self.set_remaining_fire_ticks(self.fire_ticks.max(scaled));
    // rust: self.ticks_frozen = 0;
    // rust: Ok(())
}

pub fn new(resources: *MotionResources, position: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
        // Process-owned identities determine native collection callback order.
        // Differential fixtures can replay a reference process's identities.
    // rust: let hashes: Vec<_> = resources
    // rust: .attributes
    // rust: .attributes()
    // rust: .enumerate()
    // rust: .map(|(i, _)| i as i32)
    // rust: .collect();
    // rust: let mut identity = 0i32;
    // rust: let next: Box<dyn horizon_world::attributes::live::Identities> = Box::new(move || {
    // rust: identity = identity.wrapping_add(1);
    // rust: identity
    // rust: });
    // rust: Self::with_attribute_identities(resources, position, &hashes, next)
}
    /// Explicit identity allocation for deterministic reference replay.
    // rust: pub fn with_attribute_identities(
    // rust: resources: &MotionResources,
    // rust: position: Vec3,
    // rust: hashes: &[i32],
    // rust: next: Box<dyn horizon_world::attributes::live::Identities>,
    // rust: ) -> Result<Self> {
    // rust: let mut attributes = LiveAttributes::new(
    // rust: resources.attributes.clone(),
    // rust: "minecraft:player",
    // rust: hashes,
    // rust: next,
    // rust: )
    // rust: .map_err(attribute_error)?;
    // rust: Ok(Self {
    // rust: health: crate::health::PlayerHealth::new(&resources.health, &mut attributes)?,
    // rust: status: crate::effects::StatusFlags::default(),
    // rust: impulse: ImpulseContext::default(),
    // rust: spawn_extra_particles_on_fall: false,
    // rust: position,
    // rust: velocity: Vec3::ZERO,
    // rust: ground: GroundState::default(),
    // rust: collision: CollisionFlags::default(),
    // rust: history: MovementHistory::default(),
    // rust: fall_distance: 0.0,
    // rust: block_landing: None,
    // rust: stuck_multiplier: Vec3::ZERO,
    // rust: piston: Default::default(),
    // rust: yaw: 0.0,
    // rust: head_yaw: 0.0,
    // rust: jumping: false,
    // rust: no_jump_delay: 0,
    // rust: jump_trigger_time: 0,
    // rust: may_fly: false,
    // rust: mobility_restricted: false,
    // rust: invulnerable: false,
    // rust: spectator: false,
    // rust: flying: false,
    // rust: flying_speed: 0.05,
    // rust: was_jumping: false,
    // rust: auto_jump_enabled: false,
    // rust: auto_jump_time: 0,
    // rust: was_auto_jump: false,
    // rust: move_vector: [0.0, 0.0],
    // rust: applied_input: [0.0, 0.0],
    // rust: glider: false,
    // rust: pitch: 0.0,
    // rust: fall_flying: false,
    // rust: sleeping: false,
    // rust: fall_fly_ticks: 0,
    // rust: glide_ending: false,
    // rust: server_owns_glide: false,
    // rust: glider_wear: 0,
    // rust: location_effects: LocationEffects::default(),
    // rust: auto_spin_attack_ticks: 0,
    // rust: auto_spin_attack_dmg: 0.0,
    // rust: spin_targets: Vec::new(),
    // rust: spin_hit: None,
    // rust: sprinting: false,
    // rust: sprint_input: crate::sprint::SprintState::default(),
    // rust: shift_key_down: false,
    // rust: local_crouching: false,
    // rust: pose: crate::pose::Pose::Standing,
    // rust: dimensions: crate::pose::Pose::Standing.dimensions(1.0),
    // rust: scale: 1.0,
    // rust: swimming: false,
    // rust: is_passenger: false,
    // rust: fire_ticks: -20,
    // rust: air: 300,
    // rust: respiration: 0,
    // rust: speed: 0.0,
    // rust: item_use_speed: None,
    // rust: item_use_slows_sprint: false,
    // rust: nudge: [None; 2],
    // rust: last_climbable: None,
    // rust: on_climbable: false,
    // rust: steps: MovementDistances {
    // rust: next_step: 1.0,
    // rust: ..MovementDistances::default()
    // rust: },
    // rust: crystal_sound_intensity: 0.0,
    // rust: last_crystal_sound_play_tick: 0,
    // rust: needs_sync: false,
    // rust: sync_position: false,
    // rust: teleported: false,
    // rust: events: Vec::new(),
    // rust: attributes,
    // rust: fluids: PlayerFluids::default(),
    // rust: in_powder_snow: false,
    // rust: was_in_powder_snow: false,
    // rust: ticks_frozen: 0,
    // rust: leather_boots: false,
    // rust: freeze_immune: false,
    // rust: burn_from_stepping_immune: false,
    // rust: old_position: position,
    // rust: server_copy: false,
    // rust: replaying: false,
    // rust: wall_hit_events: None,
    // rust: client_side: false,
    // rust: entity_id: 0,
    // rust: client_loaded: true,
    // rust: block_effects: true,
    // rust: powder_snow_entered: Vec::new(),
    // rust: hurt_log: Vec::new(),
    // rust: attack_log: Vec::new(),
    // rust: border: None,
    // rust: })
}
    /// LivingEntity.aiStep: speeds too small to matter stop.
pub fn drop_tiny_velocity(self: *Self) void {
}
    // rust: let v = &mut self.velocity;
    // rust: if v.x * v.x + v.z * v.z < 9.0e-6 {
    // rust: (v.x, v.z) = (0.0, 0.0);
}
    // rust: if v.y.abs() < 0.003 {
    // rust: v.y = 0.0;
}
}
    /// `Entity.getTicksRequiredToFreeze`.
pub const TICKS_REQUIRED_TO_FREEZE: i32 = 140;
    /// `Entity.getPercentFrozen`.
pub fn percent_frozen(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ticks_frozen.min(Self::TICKS_REQUIRED_TO_FREEZE) as f32
    // rust: / Self::TICKS_REQUIRED_TO_FREEZE as f32
}
    /// `Entity.isFullyFrozen`.
pub fn is_fully_frozen(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ticks_frozen >= Self::TICKS_REQUIRED_TO_FREEZE
}
    /// `LivingEntity.canFreeze`: not a spectator, no freeze-immune armor.
pub fn can_freeze(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.spectator && !self.freeze_immune
}
    /// What powder snow's contextual collision asks of the player.
pub fn powder_snow_subject(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::collisions::PowderSnowSubject {
    // rust: fall_distance: self.fall_distance,
    // rust: falling_block: false,
    // rust: leather_boots: self.leather_boots,
    // rust: walkable_type: false,
    // rust: lava_walker: false,
}
}
    /// `LivingEntity.tryAddFrost`: the frozen slowdown, on anything but air.
pub fn try_add_frost(self: *Self, on_air: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if on_air || self.ticks_frozen <= 0 {
    // rust: return Ok(());
}
    // rust: let Some(key) = self.attributes.key("minecraft:movement_speed") else {
    // rust: return Ok(());
}
    // rust: let Some(handle) = self
    // rust: .attributes
    // rust: .get_instance(Some(key))
    // rust: .map_err(attribute_error)?
    // rust: else {
    // rust: return Ok(());
}
    // rust: let slow = -0.05f32 * self.percent_frozen();
    // rust: let modifier = Modifier::new(
    // rust: "minecraft:powder_snow",
    // rust: f64::from(slow),
    // rust: Operation::AddValue,
    // rust: )?;
    // rust: self.attributes
    // rust: .edit(&handle, |value, observer| {
    // rust: value.add_transient(modifier, observer)
    // rust: })
    // rust: .map_err(attribute_error)?;
    // rust: Ok(())
}
pub fn bounds(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.dimensions.bounds(self.position)
}
pub fn attribute(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = self
    // rust: .attributes
    // rust: .key(name)
    // rust: .ok_or_else(|| format!("missing movement attribute {name}"))?;
    // rust: Ok(self
    // rust: .attributes
    // rust: .value(Some(key), ValueKind::Computed)
    // rust: .map_err(attribute_error)?)
}
    /// Add (or remove) a transient attribute modifier, e.g. from equipment
    /// (`LivingEntity.collectEquipmentChanges` applying item modifiers).
    // rust: pub fn set_modifier(
    // rust: &mut self,
    // rust: attribute: &str,
    // rust: id: &str,
    // rust: amount: f64,
    // rust: operation: &str,
    // rust: present: bool,
    // rust: ) -> Result<()> {
    // rust: self.set_modifier_unclamped(attribute, id, amount, operation, present)?;
    // rust: if attribute == "minecraft:max_health" {
    // rust: self.clamp_health_to_max()?;
}
    // rust: Ok(())
}
    /// `set_modifier` without the max_health clamp, for a remove-all/re-add
    /// batch that ends with one `clamp_health_to_max` (vanilla only removes
    /// the modifiers that really went away, so the hearts must survive it).
    // rust: pub fn set_modifier_unclamped(
    // rust: &mut self,
    // rust: attribute: &str,
    // rust: id: &str,
    // rust: amount: f64,
    // rust: operation: &str,
    // rust: present: bool,
    // rust: ) -> Result<()> {
    // rust: let Some(key) = self.attributes.key(attribute) else {
    // rust: return Ok(());
}
    // rust: let Some(handle) = self
    // rust: .attributes
    // rust: .get_instance(Some(key))
    // rust: .map_err(attribute_error)?
    // rust: else {
    // rust: return Ok(());
}
    // rust: let operation = match operation {
    // rust: "add_multiplied_base" => Operation::AddMultipliedBase,
    // rust: "add_multiplied_total" => Operation::AddMultipliedTotal,
    // rust: _ => Operation::AddValue,
}
    // rust: let modifier = Modifier::new(id, amount, operation)?;
    // rust: self.attributes
    // rust: .edit(&handle, |value, observer| {
    // rust: value.remove(modifier.id(), observer)?;
    // rust: if present {
    // rust: value.add_transient(modifier, observer)?;
}
    // rust: Ok(())
    // rust: })
    // rust: .map_err(attribute_error)?;
    // rust: Ok(())
}
    /// `LivingEntity.onAttributeUpdated` for `max_health`: a health above the
    /// new maximum drops to it (#8573: health_boost ending at 24/24 leaves 20).
pub fn clamp_health_to_max(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let max = self.attribute("minecraft:max_health")? as f32;
    // rust: let health = self.health.health();
    // rust: if health > max {
    // rust: self.set_health(max, false)?;
}
    // rust: Ok(())
}
    /// `AttributeMap.pack` in `AttributeInstance.Packed.LIST_CODEC`'s form: the
    /// player's `attributes` list (LivingEntity.addAdditionalSaveData), each
    /// instance's id, base and permanent modifiers.
pub fn saved_attributes(self: *Self) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.packed_attributes(true)
}
    /// `ServerPlayer.restoreFrom`: the attributes a player's new body takes
    /// over from the old one. A body that comes back from a death takes the
    /// base values only (`assignBaseValues`); the same player in another
    /// level (`ServerPlayer.teleport`) is the same entity, with its permanent
    /// modifiers too (`restoreAll`, `assignPermanentModifiers`). A scale of
    /// 0.1 is still 0.1 after a respawn or a trip through a portal (#3684).
pub fn carried_attributes(self: *Self, restore_all: bool) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.packed_attributes(restore_all)
}
pub fn packed_attributes(self: *Self, modifiers: bool) h {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_client_core::nbt_value::string;
//         use horizon_world::nbt::Tag;
    // rust: let list = self
    // rust: .attributes
    // rust: .instances()
    // rust: .map(|(_, key, instance)| {
    // rust: let packed = instance.pack();
    // rust: let mut entry = vec![
    // rust: ("id", string(key.name())),
    // rust: ("base", Tag::Double(packed.base.to_bits())),
    // rust: ];
                // `modifiers` is an optional field whose default is the empty list.
    // rust: if modifiers && !packed.modifiers.is_empty() {
    // rust: let modifiers = packed
    // rust: .modifiers
    // rust: .iter()
    // rust: .map(|m| {
    // rust: let operation = match m.operation() {
    // rust: Operation::AddValue => "add_value",
    // rust: Operation::AddMultipliedBase => "add_multiplied_base",
    // rust: Operation::AddMultipliedTotal => "add_multiplied_total",
}
    // rust: Tag::compound([
    // rust: ("id", string(m.id())),
    // rust: ("amount", Tag::Double(m.amount().to_bits())),
    // rust: ("operation", string(operation)),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: entry.push(("modifiers", Tag::List(modifiers)));
}
    // rust: Tag::compound(entry)
    // rust: })
    // rust: .collect();
    // rust: Tag::List(list)
}
    /// `AttributeMap.apply` of a saved `attributes` list
    /// (LivingEntity.readAdditionalSaveData): each known attribute takes its
    /// saved base and permanent modifiers; unknown ones are skipped.
    // rust: pub fn apply_saved_attributes(
    // rust: &mut self,
    // rust: saved: Option<&horizon_world::nbt::Tag>,
    // rust: ) -> Result<()> {
//         use horizon_client_core::nbt_value::{float, text};
//         use horizon_world::{attributes::Packed, nbt::Tag};
    // rust: let Some(Tag::List(list)) = saved else {
    // rust: return Ok(());
}
    // rust: for entry in list {
    // rust: let Some(key) = text(entry.get("id")).and_then(|id| self.attributes.key(&id)) else {
    // rust: continue;
}
    // rust: let modifiers = match entry.get("modifiers") {
    // rust: Some(Tag::List(l)) => l
    // rust: .iter()
    // rust: .filter_map(|m| {
    // rust: let operation = match text(m.get("operation"))?.as_str() {
    // rust: "add_value" => Operation::AddValue,
    // rust: "add_multiplied_base" => Operation::AddMultipliedBase,
    // rust: "add_multiplied_total" => Operation::AddMultipliedTotal,
    // rust: _ => return None,
}
    // rust: Modifier::new(&text(m.get("id"))?, float(m.get("amount"))?, operation).ok()
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let packed = Packed {
    // rust: base: float(entry.get("base")).unwrap_or(0.0),
    // rust: modifiers,
}
    // rust: let Some(handle) = self
    // rust: .attributes
    // rust: .get_instance(Some(key))
    // rust: .map_err(attribute_error)?
    // rust: else {
    // rust: continue;
}
    // rust: self.attributes
    // rust: .edit(&handle, |value, observer| value.apply(&packed, observer))
    // rust: .map_err(attribute_error)?;
}
    // rust: Ok(())
}
pub fn set_sprinting(self: *Self, sprinting: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sprinting = sprinting;
    // rust: self.set_sprint_modifier(sprinting)
}
    /// The movement speed's `minecraft:sprinting` modifier alone, the flag left as it is:
    /// `ClientPacketListener.handleUpdateAttributes` takes the server's modifiers as sent, so a
    /// client can sprint without it.
pub fn set_sprint_modifier(self: *Self, sprinting: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = self
    // rust: .attributes
    // rust: .key("minecraft:movement_speed")
    // rust: .ok_or("missing movement speed")?;
    // rust: let handle = self
    // rust: .attributes
    // rust: .get_instance(Some(key))
    // rust: .map_err(attribute_error)?
    // rust: .ok_or("player has no movement speed")?;
    // rust: let modifier = Modifier::new(
    // rust: "minecraft:sprinting",
    // rust: f64::from(0.3_f32),
    // rust: Operation::AddMultipliedTotal,
    // rust: )?;
    // rust: self.attributes
    // rust: .edit(&handle, |value, observer| {
    // rust: value.remove(modifier.id(), observer)?;
    // rust: if sprinting {
    // rust: value.add_transient(modifier, observer)?;
}
    // rust: Ok(())
    // rust: })
    // rust: .map_err(attribute_error)?;
    // rust: Ok(())
}
    /// Whether the movement speed has the `minecraft:sprinting` modifier.
pub fn has_sprint_modifier(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(key) = self.attributes.key("minecraft:movement_speed") else {
    // rust: return false;
}
    // rust: self.attributes
    // rust: .lookup(Some(&key))
    // rust: .and_then(|h| self.attributes.instance(&h).ok())
    // rust: .is_some_and(|i| {
    // rust: i.modifiers()
    // rust: .iter()
    // rust: .any(|m| m.id() == "minecraft:sprinting")
    // rust: })
}
    /// Local input sprint phase (`LocalPlayer.aiStep`'s sprint decisions).
    /// Vehicle bindings remain separate; hunger, flight, water, collision, the
    /// item in use and blindness use this actor's actual state.
pub fn sprint_input_tick(self: *Self, keys: crate::sprint::Keys) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sprint_input_tick_with_window(keys, 7)
}
    /// The same phase with Java's `Options.sprintWindow` value.
    // rust: pub fn sprint_input_tick_with_window(
    // rust: &mut self,
    // rust: keys: crate::sprint::Keys,
    // rust: sprint_window: i32,
    // rust: ) -> Result<()> {
    // rust: let conditions = self.sprint_conditions();
    // rust: self.run_sprint_tick(keys, conditions, sprint_window)
}
    /// The same phase for a passenger: `LocalPlayer.isSprintingPossible` asks the
    /// vehicle's `canSprint` and this client's authority there, not food.
    // rust: pub fn sprint_input_tick_riding(
    // rust: &mut self,
    // rust: keys: crate::sprint::Keys,
    // rust: sprint_window: i32,
    // rust: vehicle_can_sprint: bool,
    // rust: vehicle_local: bool,
    // rust: ) -> Result<()> {
    // rust: let conditions = crate::sprint::Conditions {
    // rust: passenger: true,
    // rust: vehicle_can_sprint,
    // rust: vehicle_local,
    // rust: ..self.sprint_conditions()
}
    // rust: self.run_sprint_tick(keys, conditions, sprint_window)
}
pub fn sprint_conditions(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::sprint::Conditions {
    // rust: sprinting: self.sprinting,
    // rust: mobility_restricted: self.mobility_restricted,
    // rust: enough_food: self.health.food.has_enough_food(),
    // rust: may_fly: self.may_fly,
    // rust: flying: self.flying,
            // Entity.isInShallowWater.
    // rust: shallow_water: self.fluids.was_touching_water && !self.is_under_water(),
    // rust: fall_flying: self.fall_flying,
    // rust: on_ground: self.ground.on_ground,
    // rust: horizontal_collision: self.collision.horizontal,
    // rust: minor_horizontal_collision: self.collision.minor,
    // rust: slow_item: self.item_use_slows_sprint,
    // rust: moving_slowly: self.moving_slowly(),
    // rust: in_water: self.fluids.was_touching_water,
    // rust: under_water: self.is_under_water(),
    // rust: swimming: self.swimming,
    // rust: ..Default::default()
}
}
    // rust: fn run_sprint_tick(
    // rust: &mut self,
    // rust: keys: crate::sprint::Keys,
    // rust: conditions: crate::sprint::Conditions,
    // rust: sprint_window: i32,
    // rust: ) -> Result<()> {
        // The sprint setter edits attributes and flags, independent of local
        // keyboard history. Retain the input prefix even if that setter fails.
    // rust: let mut state = self.sprint_input;
    // rust: let result = state.tick(keys, conditions, sprint_window.clamp(0, 10), |value| {
    // rust: self.set_sprinting(value)
    // rust: });
    // rust: self.sprint_input = state;
    // rust: result
}
pub fn remove_frost(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = self
    // rust: .attributes
    // rust: .key("minecraft:movement_speed")
    // rust: .ok_or("missing movement speed")?;
        // Native removeFrost obtains the instance even when no modifier exists.
        // Pure value lookup would miss lazy creation and its pending updates.
    // rust: if let Some(handle) = self
    // rust: .attributes
    // rust: .get_instance(Some(key))
    // rust: .map_err(attribute_error)?
    // rust: {
    // rust: self.attributes
    // rust: .edit(&handle, |value, observer| {
    // rust: value.remove("minecraft:powder_snow", observer)
    // rust: })
    // rust: .map_err(attribute_error)?;
}
    // rust: Ok(())
}
}

pub const MotionWorld = struct {
    /// Entity boxes selected by the host for this player's collision queries.
    entities: *'w [Aabb],
    player: *'p mut PlayerMotion,
    scene: *'w mut World,
    assets: *'r Assets,
    collision_binding: *'w BlockCollisionRegistry<'r>,
    resources: *'w MotionResources,
    /// This world's frozen damage definitions and current tags.
    health: *'w crate::health::HealthResources,
};
pub const TickInput = enum {
    Living([f32; 3]),
    PreparedLocal { direction: [f32; 2], jumping: bool },
};
    // rust: impl MotionWorld<'_, '_, '_> {
pub fn context(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CollisionContext::for_entity(
    // rust: CollisionEntity {
    // rust: identity: EntityIdentity(0),
    // rust: y: self.player.position.y,
    // rust: descending: self.player.shift_key_down,
    // rust: main_hand: Some(CollisionItem::EMPTY),
    // rust: },
    // rust: false,
    // rust: )
}
pub fn collisions(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SceneCollisions {
    // rust: world: self.scene,
    // rust: binding: self.collision_binding,
    // rust: subject: Some(self.player.powder_snow_subject()),
}
}
    // rust: fn movement_collisions(
    // rust: &self,
    // rust: ) -> crate::collisions::EntityCollisions<'_, SceneCollisions<'_, '_>> {
    // rust: let at = [self.player.position.x, self.player.position.z];
    // rust: crate::collisions::EntityCollisions {
    // rust: blocks: self.collisions(),
    // rust: entities: self.entities,
    // rust: border: self.player.border.as_ref().map(|b| (b, at)),
}
}
    /// `Level.noCollision(player, bounds)`: blocks and the host's entity boxes.
pub fn no_player_collision(self: *Self, bounds: Aabb) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let context = self.context();
    // rust: Ok(world_movement::no_world_collision(
    // rust: &mut self.movement_collisions(),
    // rust: world_movement::CollisionCheckRequest {
    // rust: entity: EntityIdentity(0),
    // rust: context,
    // rust: bounds,
    // rust: candidate_budget: 1_000_000,
    // rust: },
    // rust: )?)
}
pub fn block(self: *Self, p: BlockPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.scene.block(p.x, p.y, p.z)
}
pub fn support(self: *Self, offset: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = self.player.position;
    // rust: let support = self.player.ground.supporting_block;
    // rust: Ok(movement_support::support_position(
    // rust: &mut RegistryMovementWorld {
    // rust: properties: &self.resources.blocks,
    // rust: world: self,
    // rust: },
    // rust: position,
    // rust: support,
    // rust: offset,
    // rust: )?)
}
pub fn location(self: *Self) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MovementLocation {
    // rust: position: self.player.position,
    // rust: block_position: BlockPos::containing(self.player.position),
    // rust: supporting_block: self.player.ground.supporting_block,
}
}
    /// `Player.onClimbable` (never while flying) over `LivingEntity.onClimbable`
    /// at the player's feet: the climbable tag or an open trapdoor above a
    /// matching ladder. It remembers the block.
pub fn climbable(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.player.flying {
    // rust: self.player.on_climbable = false;
    // rust: return Ok(false);
}
    // rust: let resources = self.resources;
    // rust: let found: Result<bool> =
    // rust: climbing::on_climbable(self, &resources.climbing).map_err(|e| e.to_string().into());
    // rust: let climbable = found?;
    // rust: self.player.on_climbable = climbable;
    // rust: Ok(climbable)
}
pub fn travel_in_air(self: *Self, input: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_air::travel_in_air(self, input)
}
    /// Dry, standing movement phases of LivingEntity.aiStep, including powder
    /// snow's block-inside effects and server freezing (thawing, the frost
    /// modifier, freeze damage). Equipment, interpolation, effects and other
    /// world/entity effects remain unbound. Inputs are the native
    /// float xxa/yya/zza fields, before LivingEntity.applyInput damping.
pub fn movement_tick(self: *Self, input: [f32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.dry_tick(TickInput::Living(input))
}
    /// Dry Player.aiStep movement with a prepared local input vector. The
    /// caller applies LocalPlayer input preparation once. Empty inventory,
    /// equipment and nearby-entity sets are the current scene domain.
pub fn player_movement_tick(self: *Self, direction: [f32; 2], jumping: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fluid_base_tick()?;
    // rust: self.player_movement_tick_with_fluids(direction, jumping)
}
    // rust: fn player_movement_tick_with_fluids(
    // rust: &mut self,
    // rust: direction: [f32; 2],
    // rust: jumping: bool,
    // rust: ) -> Result<()> {
        // Entity.baseTick
    // rust: self.player.was_in_powder_snow = self.player.in_powder_snow;
    // rust: self.player.in_powder_snow = false;
    // rust: self.player.old_position = self.player.position;
    // rust: if self.player.jump_trigger_time > 0 {
    // rust: self.player.jump_trigger_time -= 1;
}
    // rust: self.player.peaceful_regeneration(self.scene.health_rules)?;
        // LocalPlayer.aiStep: double-tap jump toggles creative flight.
    // rust: let was_jumping = std::mem::replace(&mut self.player.was_jumping, jumping);
    // rust: let flying_before = self.player.flying;
    // rust: if self.player.spectator {
    // rust: self.player.flying = true;
    // rust: self.player.ground.on_ground = false;
    // rust: } else if self.player.may_fly && !was_jumping && jumping && !self.player.was_auto_jump {
            // `LocalPlayer.aiStep`: mayfly gates the flight toggle, not the
            // flying state independently supplied by the server's abilities.
    // rust: if self.player.jump_trigger_time == 0 {
    // rust: self.player.jump_trigger_time = 7;
    // rust: } else if !self.player.swimming {
    // rust: self.player.flying = !self.player.flying;
    // rust: if self.player.flying && self.player.ground.on_ground {
    // rust: self.jump_from_ground()?;
}
    // rust: self.player.jump_trigger_time = 0;
}
}
    // rust: let toggled = flying_before != self.player.flying;
        // The server clears the glide flag from the position the client sent
        // last tick, and the client applies it a tick later, before aiStep: a
        // landing glide lasts one more tick on the ground, with no ground
        // friction, so a jump then keeps the speed (the elytra hop).
        // A client of a server takes the flag from the server itself: vanilla's
        // LocalPlayer never ends a glide of its own, and keeping the local
        // prediction there would clear the flag before the server's
        // SetEntityData does (#7616).
    // rust: let ending = std::mem::take(&mut self.player.glide_ending);
    // rust: if ending && !self.player.server_owns_glide {
    // rust: self.player.fall_flying = false;
}
        // Player.tryToStartFallFlying (canGlide: airborne, not flying, a glider;
        // never from inside a liquid).
    // rust: let can_glide = self.player.glider
    // rust: && !self.player.ground.on_ground
    // rust: && !self.player.flying
    // rust: && self.player.status.levitation.is_none()
    // rust: && !self.player.fluids.was_touching_water
    // rust: && !self.player.is_in_lava();
        // LocalPlayer.aiStep: `!onClimbable()` before tryToStartFallFlying.
    // rust: if jumping
    // rust: && !toggled
    // rust: && !was_jumping
    // rust: && !self.climbable()?
    // rust: && !self.player.fall_flying
    // rust: && can_glide
    // rust: {
    // rust: self.player.fall_flying = true;
}
        // LivingEntity.updateFallFlying (fallFlyTicks is counted after the move).
    // rust: if self.player.fall_flying {
            // Entity.checkFallDistanceAccumulation: a glide that isn't diving
            // (falling slower than 0.5 a tick) keeps the fall distance at 1, so
            // landing from it hurts no more than a one-block drop.
    // rust: if self.player.velocity.y > -0.5 && self.player.fall_distance > 1.0 {
    // rust: self.player.fall_distance = 1.0;
}
            // canGlide alone: water and lava don't end a glide, levitation does.
    // rust: let still = self.player.glider
    // rust: && !self.player.ground.on_ground
    // rust: && !self.player.flying
    // rust: && self.player.status.levitation.is_none();
    // rust: if !still {
                // The server clears the flag; a client of one waits for its
                // synced data (the SetEntityData handler sets fall_flying).
    // rust: if !self.player.server_owns_glide {
    // rust: self.player.glide_ending = true;
}
    // rust: } else if (self.player.fall_fly_ticks + 1) % 10 == 0
    // rust: && ((self.player.fall_fly_ticks + 1) / 10) % 2 == 0
    // rust: {
    // rust: self.player.glider_wear += 1;
}
}
        // LocalPlayer.goDownInWater, before LivingEntity.aiStep's velocity cleanup.
    // rust: if self.player.fluids.was_touching_water
    // rust: && self.player.shift_key_down
    // rust: && !self.player.flying
    // rust: {
    // rust: self.player.velocity.y += f64::from(-0.04f32);
}
    // rust: if self.player.flying {
            // Vertical flight: jump up, shift down, three times the flying speed.
    // rust: let ya = i32::from(jumping) - i32::from(self.player.shift_key_down);
    // rust: if ya != 0 {
    // rust: self.player.velocity.y += f64::from(ya as f32 * self.player.flying_speed * 3.0);
}
}
        // LocalPlayer.aiStep: a player inside a block is nudged out of it.
    // rust: let [x, z] = std::mem::take(&mut self.player.nudge);
    // rust: if let Some(x) = x {
    // rust: self.player.velocity.x = x;
}
    // rust: if let Some(z) = z {
    // rust: self.player.velocity.z = z;
}
    // rust: self.dry_tick(TickInput::PreparedLocal {
    // rust: direction,
    // rust: jumping: jumping && !self.player.flying,
    // rust: })?;
        // LivingEntity.tick counts fallFlyTicks after aiStep.
    // rust: if self.player.fall_flying {
    // rust: self.player.fall_fly_ticks += 1;
    // rust: } else {
    // rust: self.player.fall_fly_ticks = 0;
}
    // rust: if self.player.spectator {
    // rust: self.player.ground.on_ground = false;
}
    // rust: if self.player.flying {
    // rust: self.player.fall_distance = 0.0;
    // rust: if self.player.ground.on_ground && !self.player.spectator {
    // rust: self.player.flying = false;
}
}
    // rust: self.player.head_yaw = self.player.yaw;
        // Player.aiStep refreshes speed after movement, not before travel.
    // rust: self.player.speed = self.player.attribute("minecraft:movement_speed")? as f32;
    // rust: Ok(())
}
    /// Resident simulation phases in native order. Enclosing entity/world tick
    /// services are still incomplete; this composes clocks, movement and hunger.
pub fn simulation_tick(self: *Self, direction: [f32; 2], jumping: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.health.advance_clock();
    // rust: self.fluid_base_tick()?;
    // rust: self.simulation_tick_with_fluids(direction, jumping)
}
pub fn simulation_tick_with_fluids(self: *Self, direction: [f32; 2], jumping: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tick_environment_damage()?;
    // rust: let previous = self.player.position;
    // rust: self.player_movement_tick_with_fluids(direction, jumping)?;
    // rust: self.apply_fire_contact()?;
    // rust: self.player.refresh_attributes()?;
    // rust: self.update_player_pose()?;
        // The resident scene accepts the resolved local movement directly.
        // Vanilla dispatches this separately from travel, on packet acceptance.
    // rust: self.check_movement_statistics(previous.vector_to(self.player.position))?;
    // rust: self.player.food_tick(self.health, self.scene.health_rules)
}
pub fn controlled_simulation_tick(self: *Self, keys: crate::sprint::Keys) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.controlled_simulation_tick_with_sprint_window(keys, 7)
}
    /// Local simulation with the configured double-tap sprint window.
    // rust: pub fn controlled_simulation_tick_with_sprint_window(
    // rust: &mut self,
    // rust: keys: crate::sprint::Keys,
    // rust: sprint_window: i32,
    // rust: ) -> Result<()> {
    // rust: self.local_tick(keys, |player, keys| {
    // rust: player.sprint_input_tick_with_window(keys, sprint_window)
    // rust: })
}
    /// A client's tick played again by the server's movement prediction: the
    /// client's own keys, and the sprinting it said it had (its
    /// ServerboundPlayerCommandPacket comes before the tick's move).
pub fn replayed_tick(self: *Self, keys: crate::sprint::Keys, sprinting: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.replaying = true;
    // rust: let result = self.local_tick(keys, |player, _| {
    // rust: if player.sprinting == sprinting {
    // rust: Ok(())
    // rust: } else {
    // rust: player.set_sprinting(sprinting)
}
    // rust: });
    // rust: self.player.replaying = false;
    // rust: result
}
    /// `LocalPlayer.aiStep` and the travel it ends with; `sprint` is the
    /// sprint phase.
    // rust: fn local_tick(
    // rust: &mut self,
    // rust: keys: crate::sprint::Keys,
    // rust: sprint: impl FnOnce(&mut PlayerMotion, crate::sprint::Keys) -> Result<()>,
    // rust: ) -> Result<()> {
        // The base tick (fluids, swimming) precedes LocalPlayer.aiStep.
    // rust: self.player.health.advance_clock();
    // rust: self.fluid_base_tick()?;
    // rust: self.update_local_crouching()?;
    // rust: let mut keys = keys;
        // LocalPlayer.aiStep: a pending auto-jump presses jump for this tick
        // (input.makeJump) and keeps the jump from toggling flight.
    // rust: self.player.was_auto_jump = self.player.auto_jump_time > 0;
    // rust: if self.player.was_auto_jump {
    // rust: self.player.auto_jump_time -= 1;
    // rust: keys.jump = true;
}
    // rust: sprint(self.player, keys)?;
    // rust: self.player.shift_key_down = keys.shift;
    // rust: let direction = keys.direction();
    // rust: self.player.move_vector = direction;
    // rust: let sneak = if direction[0] * direction[0] + direction[1] * direction[1] != 0.0
    // rust: && self.player.moving_slowly()
    // rust: {
    // rust: Some(self.player.attribute("minecraft:sneaking_speed")? as f32)
    // rust: } else {
    // rust: None
}
    // rust: let modified = crate::input::modify_input(direction, self.player.item_use_speed, sneak);
    // rust: self.player.applied_input = modified;
    // rust: self.simulation_tick_with_fluids(modified, keys.jump)
}
pub fn check_movement_statistics(self: *Self, delta: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: movement_statistics::check(self, delta)
}
pub fn dry_tick(self: *Self, input: TickInput) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.player.no_jump_delay > 0 {
    // rust: self.player.no_jump_delay -= 1;
}
    // rust: self.player.drop_tiny_velocity();
    // rust: let mut input = match input {
    // rust: TickInput::Living(v) => Vec3::new(
    // rust: f64::from(v[0] * 0.98),
    // rust: f64::from(v[1]),
    // rust: f64::from(v[2] * 0.98),
    // rust: ),
    // rust: TickInput::PreparedLocal { direction, jumping } => {
    // rust: self.player.jumping = jumping;
    // rust: Vec3::new(f64::from(direction[0]), 0.0, f64::from(direction[1]))
}
}
    // rust: if self.player.health.dead_or_dying() {
    // rust: self.player.jumping = false;
    // rust: input.x = 0.0;
    // rust: input.z = 0.0;
}
    // rust: self.jump_phase()?;
    // rust: let before_travel = self.player.bounds();
    // rust: self.player_travel(input)?;
    // rust: if self.player.block_effects {
    // rust: self.apply_effects_from_blocks()?;
}
        // LivingEntity.aiStep "freezing" (server).
    // rust: if !self.player.in_powder_snow || !self.player.can_freeze() {
    // rust: self.player.ticks_frozen = (self.player.ticks_frozen - 2).max(0);
}
    // rust: self.player.remove_frost()?;
    // rust: let on = self.support(movement_support::LEGACY_SUPPORT_OFFSET)?;
    // rust: let on_air = self.assets.registry.state(self.block(on)).is_none_or(|s| {
    // rust: matches!(
    // rust: s.name.as_str(),
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: )
    // rust: });
    // rust: self.player.try_add_frost(on_air)?;
    // rust: self.update_soul_speed_block()?;
    // rust: if self.player.health.tick_count % 40 == 0
    // rust: && self.player.is_fully_frozen()
    // rust: && self.player.can_freeze()
    // rust: {
    // rust: self.freeze_damage()?;
}
    // rust: if self.player.auto_spin_attack_ticks > 0 {
    // rust: self.player.auto_spin_attack_ticks -= 1;
    // rust: self.check_auto_spin_attack(before_travel);
}
    // rust: Ok(())
}
    /// Refresh whether the player stands on a soul speed block, for the
    /// `location_changed` enchantment effects (a server's player too, whose
    /// client does the walking).
pub fn update_soul_speed_block(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.location_effects.on_soul_speed_block = self.on_soul_speed_block()?;
    // rust: Ok(())
}
    /// `MovementAffectedByPredicate` for `#minecraft:soul_speed_blocks`.
pub fn on_soul_speed_block(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let on = self.support(movement_support::MOVEMENT_SUPPORT_OFFSET)?;
    // rust: Ok(self
    // rust: .assets
    // rust: .registry
    // rust: .state(self.block(on))
    // rust: .is_some_and(|s| self.resources.soul_speed_blocks.contains(&s.name)))
}
    /// Player.travel: swim steering, then LivingEntity.travel (fluids first,
    /// then gliding, then air), keeping 0.6 of the vertical speed while flying.
pub fn player_travel(self: *Self, input: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.player.swimming {
    // rust: let look_y =
    // rust: horizon_world::view_direction::view_vector(self.player.pitch, self.player.yaw).y;
    // rust: let near_surface = BlockPos::containing(Vec3::new(
    // rust: self.player.position.x,
    // rust: self.player.position.y + 1.0 - 0.1,
    // rust: self.player.position.z,
    // rust: ));
    // rust: if look_y <= 0.0
    // rust: || self.player.jumping
    // rust: || self.fluid_at(near_surface).kind() != horizon_world::fluid::FluidKind::Empty
    // rust: {
    // rust: let blend = if look_y < -0.2 { 0.085 } else { 0.06 };
    // rust: self.player.velocity.y += (look_y - self.player.velocity.y) * blend;
}
}
    // rust: let flying_y = self.player.flying.then_some(self.player.velocity.y);
    // rust: if !self.player.flying
    // rust: && (self.player.fluids.was_touching_water || self.player.is_in_lava())
    // rust: {
    // rust: horizon_world::living_fluid::travel_in_fluid(self, input)?;
    // rust: } else if self.player.fall_flying {
            // LivingEntity.travelFallFlying: on a climbable the glide ends and
            // the player moves like in the air.
    // rust: if self.climbable()? {
    // rust: self.travel_in_air(input)?;
    // rust: self.player.fall_flying = false;
    // rust: } else {
    // rust: self.travel_fall_flying()?;
}
    // rust: } else {
    // rust: self.travel_in_air(input)?;
}
    // rust: if let Some(y) = flying_y {
    // rust: self.player.velocity.y = y * 0.6;
}
    // rust: Ok(())
}
    /// ServerPlayer's own travel: the server simulates a player too
    /// (`MoveSimulationType.AUTHORITATIVE_SIDE_AND_SERVER`), with no input
    /// (it never sets xxa/zza). Only the delta movement it leaves stays: it
    /// is what a hurt sends the player (`ServerEntity.sendChanges`), and
    /// what the next knockback starts from; the client's next move places
    /// the player.
pub fn server_travel(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = &mut *self.player;
    // rust: let (position, ground, collision) = (p.position, p.ground, p.collision);
    // rust: let (history, fall_distance, steps) = (p.history.clone(), p.fall_distance, p.steps);
    // rust: let events = p.events.len();
    // rust: p.drop_tiny_velocity();
    // rust: p.server_copy = true;
    // rust: let travelled = self.player_travel(Vec3::ZERO);
    // rust: let p = &mut *self.player;
    // rust: p.server_copy = false;
    // rust: (p.position, p.ground, p.collision) = (position, ground, collision);
    // rust: (p.history, p.fall_distance, p.steps) = (history, fall_distance, steps);
        // The wall hit is the server's own: its sound and damage events stay.
    // rust: let kept: Vec<_> = p
    // rust: .wall_hit_events
    // rust: .take()
    // rust: .map(|span| p.events.drain(span).collect())
    // rust: .unwrap_or_default();
    // rust: p.events.truncate(events);
    // rust: p.events.extend(kept);
    // rust: travelled
}
    /// `LivingEntity.checkAutoSpinAttack`: the first living entity in the
    /// box swept this tick takes the hit and ends the spin, bouncing the
    /// player back at a fifth of its speed; a wall ends it too.
pub fn check_auto_spin_attack(self: *Self, before: Aabb) void {
}
    // rust: let swept = before.union_bounds(self.player.bounds());
    // rust: let p = &mut self.player;
    // rust: if let Some(&(id, _)) = p.spin_targets.iter().find(|(_, b)| b.intersects(swept)) {
    // rust: p.spin_hit = Some(id);
    // rust: p.auto_spin_attack_ticks = 0;
    // rust: p.velocity = p.velocity.scale(-0.2);
    // rust: } else if p.collision.horizontal {
    // rust: p.auto_spin_attack_ticks = 0;
}
}
    /// `hurtServer(damageSources().freeze(), 1)` for a fully frozen player.
pub fn freeze_damage(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = self
    // rust: .health
    // rust: .damage
    // rust: .id("minecraft:freeze")
    // rust: .ok_or("missing freeze damage type")?;
    // rust: self.player.events.push(MotionEvent::Health(
    // rust: crate::health::HealthEvent::FreezeDamage(1.0),
    // rust: ));
    // rust: let rules = self.scene.health_rules;
    // rust: self.player.hurt(self.health, rules, id, 1.0)?;
    // rust: Ok(())
}
    /// `Entity.applyEffectsFromBlocks` for the blocks Horizon's player reacts
    /// to inside its movement path: powder snow (`PowderSnowBlock.entityInside`
    /// and the FREEZE / EXTINGUISH effects), cobwebs, sweet berry bushes,
    /// cactus and lit campfires, and the magma and slime blocks it stands on
    /// (`stepOn`). Pressure plates, tripwires and rails are the world tick's
    /// scan.
pub fn apply_effects_from_blocks(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.effects_from_blocks(false)
}
    /// What `applyEffectsFromBlocks` does to a server's player along the
    /// moves its client sent since `from` (in its history): the damage of
    /// magma, cactus, lit campfires and grown sweet berry bushes, and powder
    /// snow's FREEZE, then `LivingEntity.aiStep`'s freezing and its damage.
    /// Its client moves it, so the slowing and the rest are the client's.
pub fn server_block_damage(self: *Self, from: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.old_position = from;
        // Entity.baseTick
    // rust: self.player.was_in_powder_snow = self.player.in_powder_snow;
    // rust: self.player.in_powder_snow = false;
    // rust: self.effects_from_blocks(true)?;
        // LivingEntity.aiStep "freezing" (server).
    // rust: if !self.player.in_powder_snow || !self.player.can_freeze() {
    // rust: self.player.ticks_frozen = (self.player.ticks_frozen - 2).max(0);
}
    // rust: if self.player.health.tick_count % 40 == 0
    // rust: && self.player.is_fully_frozen()
    // rust: && self.player.can_freeze()
    // rust: {
    // rust: self.freeze_damage()?;
}
    // rust: Ok(())
}
pub fn effects_from_blocks(self: *Self, damage_only: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_world::entity_move::MovementRecord;
    // rust: let mut movements: Vec<MovementRecord> =
    // rust: self.player.history.records().iter().copied().collect();
    // rust: self.player.history.clear();
    // rust: let position = self.player.position;
    // rust: match movements.last() {
    // rust: None => movements.push(MovementRecord {
    // rust: from: self.player.old_position,
    // rust: to: position,
    // rust: original: None,
    // rust: }),
    // rust: Some(last) if last.to.distance_squared(position) > f64::from(9.999_999_4e-11_f32) => {
    // rust: movements.push(MovementRecord {
    // rust: from: last.to,
    // rust: to: position,
    // rust: original: None,
    // rust: })
}
    // rust: _ => {}
}
        // isAffectedByBlocks: no physics for spectators.
    // rust: if self.player.spectator {
    // rust: return Ok(());
}
        // Block.stepOn for the block under an entity on the ground:
        // MagmaBlock's hot floor hurts unless it steps carefully (sneaks).
    // rust: if self.player.ground.on_ground {
    // rust: let on = self.legacy_on_position()?;
    // rust: let under = self.assets.registry.state(self.block(on));
    // rust: if let Some(block) = under {
    // rust: crate::block_contact::emit(crate::block_contact::Event::StepOn(
    // rust: crate::block_contact::Contact {
    // rust: entity: self.player.entity_id,
    // rust: kind: "minecraft:player",
    // rust: block: &block.name,
    // rust: state: self.block(on),
    // rust: position: on,
    // rust: },
    // rust: ));
}
    // rust: let magma = under.is_some_and(|s| s.name == "minecraft:magma_block");
    // rust: let slime = under.is_some_and(|s| s.name == "minecraft:slime_block");
    // rust: if magma && !self.player.shift_key_down {
    // rust: self.environment_hurt("minecraft:hot_floor", 1.0)?;
}
            // TurtleEggBlock.stepOn: a step that is not careful may break an egg.
    // rust: if !self.player.shift_key_down {
    // rust: let state = self.block(on);
    // rust: self.resources
    // rust: .landing
    // rust: .step_on(
    // rust: self,
    // rust: state,
    // rust: on,
    // rust: horizon_world::block_landing::LandingEntityKind::Player,
    // rust: )
    // rust: .map_err(|e| e.to_string())?;
}
            // SlimeBlock.stepOn: a slow walk on slime drags the horizontal
            // speed (the client moves its own player, so not the server's copy).
    // rust: if slime && !damage_only && !self.player.shift_key_down {
    // rust: let abs_delta_y = self.player.velocity.y.abs();
    // rust: if abs_delta_y < 0.1 {
    // rust: let scale = 0.4 + abs_delta_y * 0.2;
    // rust: self.player.velocity.x *= scale;
    // rust: self.player.velocity.z *= scale;
}
}
}
    // rust: let mut visited = crate::fast_hash::FxHashSet::default();
    // rust: let mut entered = Vec::new();
    // rust: for movement in &movements {
    // rust: let mut from = movement.from;
    // rust: let delta = movement.to.subtract(movement.from);
    // rust: let mut budget = 16;
    // rust: match movement.original {
    // rust: Some(original) if delta.length_squared() > 0.0 => {
    // rust: for axis in Axis::step_order(original) {
    // rust: let step = delta.component(axis);
    // rust: if step != 0.0 {
    // rust: let to = from.relative(
    // rust: match axis {
    // rust: Axis::X => Direction::East,
    // rust: Axis::Y => Direction::Up,
    // rust: Axis::Z => Direction::South,
    // rust: },
    // rust: step,
    // rust: );
    // rust: budget -= self.check_inside_blocks(
    // rust: from,
    // rust: to,
    // rust: &mut visited,
    // rust: &mut entered,
    // rust: budget,
    // rust: damage_only,
    // rust: )?;
    // rust: from = to;
}
}
}
    // rust: _ => {
    // rust: budget -= self.check_inside_blocks(
    // rust: movement.from,
    // rust: movement.to,
    // rust: &mut visited,
    // rust: &mut entered,
    // rust: 16,
    // rust: damage_only,
    // rust: )?;
}
}
    // rust: if budget <= 0 {
    // rust: self.check_inside_blocks(
    // rust: movement.to,
    // rust: movement.to,
    // rust: &mut visited,
    // rust: &mut entered,
    // rust: 1,
    // rust: damage_only,
    // rust: )?;
}
}
        // InsideBlockEffectApplier.StepBasedCollector: the blocks entered
        // at one step (a sweep iteration differing from the last) form a
        // group whose EXTINGUISH callbacks (the game destroys those blocks if
        // the player burns), FREEZE and EXTINGUISH apply once, in order.
    // rust: let mut last_step = -1;
    // rust: let mut groups = 0;
    // rust: for (index, &(step, p)) in entered.iter().enumerate() {
    // rust: if index == 0 || step != last_step {
    // rust: groups += 1;
    // rust: last_step = step;
}
    // rust: if groups == 1 && !damage_only {
                // A later group finds the fire already out.
    // rust: self.player.powder_snow_entered.push(p);
}
}
    // rust: for _ in 0..groups {
    // rust: if self.player.health.dead_or_dying() {
    // rust: break;
}
    // rust: self.player.in_powder_snow = true;
    // rust: if self.player.can_freeze() {
    // rust: self.player.ticks_frozen =
    // rust: (self.player.ticks_frozen + 1).min(PlayerMotion::TICKS_REQUIRED_TO_FREEZE);
}
}
    // rust: Ok(())
}
    /// The block effects and the frost of a window's own player while a vehicle carries it. Its
    /// client does not travel (`passenger_pose_tick` is all it runs), but `LivingEntity.aiStep`
    /// still applies the effects of the blocks a passenger is in (`applyEffectsFromBlocks`: powder
    /// snow's FREEZE adds a tick of frost) and thaws it when it is out of powder snow. The
    /// frostbite overlay reads these ticks. The server's copy does this in `server_block_damage`.
pub fn passenger_block_effects_tick(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
        // Entity.baseTick
    // rust: self.player.was_in_powder_snow = self.player.in_powder_snow;
    // rust: self.player.in_powder_snow = false;
    // rust: if self.player.block_effects {
    // rust: self.apply_effects_from_blocks()?;
}
        // LivingEntity.aiStep "freezing" (server), as the client predicts it on foot.
    // rust: if !self.player.in_powder_snow || !self.player.can_freeze() {
    // rust: self.player.ticks_frozen = (self.player.ticks_frozen - 2).max(0);
}
        // The vehicle moves the passenger between ticks: the next sweep starts here.
    // rust: self.player.old_position = self.player.position;
    // rust: Ok(())
}
    /// `Entity.checkInsideBlocks(from, to, ...)`: the blocks the box at `to`
    /// sweeps through from `from`; returns the iterations used plus one.
    // rust: fn check_inside_blocks(
    // rust: &mut self,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: visited: &mut crate::fast_hash::FxHashSet<i64>,
    // rust: entered: &mut Vec<(i32, BlockPos)>,
    // rust: max_iterations: i32,
    // rust: damage_only: bool,
    // rust: ) -> Result<i32> {
    // rust: let deflated = self.player.dimensions.bounds(to).deflate(Vec3::new(
    // rust: f64::from(1.0e-5_f32),
    // rust: f64::from(1.0e-5_f32),
    // rust: f64::from(1.0e-5_f32),
    // rust: ));
        // Mth.square(0.9999900000002526): a long move counts every block it
        // crosses as precise.
    // rust: let far = 0.999_990_000_000_252_6_f64;
    // rust: let moved_far = from.distance_squared(to) > far * far;
    // rust: let mut hits = Vec::new();
    // rust: let mut iterations = 0;
    // rust: let alive = !self.player.health.dead_or_dying();
        // Nothing below changes a block, so each is read once, as the sweep
        // visits it, and air (`state.isAir()`, the most of a path) is
        // passed over there instead of being kept for the loop.
    // rust: let (scene, registry) = (&*self.scene, self.assets.registry);
    // rust: horizon_core::geometry::sweep_intersected_blocks(
    // rust: from,
    // rust: to,
    // rust: deflated,
    // rust: 1_000_000,
    // rust: |p, iteration| {
    // rust: if !alive || iteration >= max_iterations {
    // rust: return false;
}
    // rust: iterations = iteration;
    // rust: let state = scene.block(p.x, p.y, p.z);
    // rust: let air = registry.state(state).is_none_or(|d| {
    // rust: matches!(
    // rust: d.name.as_str(),
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: )
    // rust: });
    // rust: if !air {
    // rust: hits.push((iteration, p, state));
}
    // rust: true
    // rust: },
    // rust: )
    // rust: .map_err(|e| format!("block sweep: {e:?}"))?;
    // rust: for (step, p, state) in hits {
    // rust: let Some(definition) = self.assets.registry.state(state) else {
    // rust: continue;
}
    // rust: let name = definition.name.as_str();
    // rust: let powder_snow = name == "minecraft:powder_snow";
            // A filled cauldron's content top in blocks: the lava's 15/16
            // (LavaCauldronBlock.FILLED_SHAPE), or a layered cauldron's
            // getPixelContentHeight, 6 + 3 per level (FILLED_SHAPES).
    // rust: let content_top = match name {
    // rust: "minecraft:lava_cauldron" => Some(15.0 / 16.0),
    // rust: "minecraft:water_cauldron" | "minecraft:powder_snow_cauldron" => {
    // rust: let level = self
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("level"))
    // rust: .and_then(|l| l.parse::<u8>().ok())
    // rust: .unwrap_or(1);
    // rust: Some((6.0 + 3.0 * f64::from(level)) / 16.0)
}
    // rust: _ => None,
}
            // getEntityInsideCollisionShape is the whole block but for powder
            // snow (its collision shape, the whole block when it is empty),
            // filled cauldrons, end portals and tripwires; Horizon doesn't
            // follow the player into those last two.
    // rust: if matches!(name, "minecraft:end_portal" | "minecraft:tripwire") {
    // rust: continue;
}
    // rust: let inside = !(powder_snow || content_top.is_some()) || {
    // rust: let context = self.context();
    // rust: let binding = self.collision_binding;
    // rust: let shape = binding.collision_shape_with_context(
    // rust: &mut self.collisions(),
    // rust: state,
    // rust: p,
    // rust: &context,
    // rust: )?;
    // rust: powder_snow && (shape.is_empty() || shape.boxes() == VoxelShape::block().boxes())
    // rust: || {
    // rust: let offset = Vec3::new(f64::from(p.x), f64::from(p.y), f64::from(p.z));
    // rust: let mut boxes: Vec<_> = shape.moved(offset).boxes().to_vec();
    // rust: if let Some(top) = content_top {
                            // The cauldron's shape or its content,
                            // Block.column(12, 4, top).
    // rust: boxes.push(Aabb::new(
    // rust: Vec3::new(2.0 / 16.0, 4.0 / 16.0, 2.0 / 16.0).add_vector(offset),
    // rust: Vec3::new(14.0 / 16.0, top, 14.0 / 16.0).add_vector(offset),
    // rust: ));
}
    // rust: self.player
    // rust: .dimensions
    // rust: .bounds(from)
    // rust: .collided_along_vector(to.subtract(from), &boxes)
}
}
    // rust: if inside && visited.insert(p.pack()) {
    // rust: crate::block_contact::emit(crate::block_contact::Event::Inside(
    // rust: crate::block_contact::Contact {
    // rust: entity: self.player.entity_id,
    // rust: kind: "minecraft:player",
    // rust: block: name,
    // rust: state,
    // rust: position: p,
    // rust: },
    // rust: ));
                // CactusBlock, CampfireBlock and the cauldrons' entityInside
                // (`entity.hurt`, the fire and the fill level), and
                // WitherRoseBlock's server-side effect.
    // rust: match name {
    // rust: "minecraft:cactus" => self.environment_hurt("minecraft:cactus", 1.0)?,
    // rust: "minecraft:lava_cauldron" => self.lava_cauldron_inside()?,
    // rust: "minecraft:water_cauldron" | "minecraft:powder_snow_cauldron" => {
    // rust: self.layered_cauldron_inside(p);
}
    // rust: "minecraft:wither_rose" => {
    // rust: self.player.events.push(MotionEvent::InsideWitherRose);
}
    // rust: "minecraft:campfire" | "minecraft:soul_campfire" => {
    // rust: let lit = self
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("lit"))
    // rust: .is_some_and(|v| v == "true");
    // rust: let damage = if name == "minecraft:campfire" {
    // rust: 1.0
    // rust: } else {
    // rust: 2.0
}
    // rust: if lit {
    // rust: self.environment_hurt("minecraft:campfire", damage)?;
}
}
    // rust: "minecraft:sweet_berry_bush" if damage_only => {
    // rust: self.sweet_berry_bush_damage(state)?;
}
                    // HoneyBlock.entityInside: a server's player slides too, so
                    // its fall distance resets (its client moves it).
    // rust: "minecraft:honey_block" => self.honey_block_inside(p)?,
                    // PowderSnowBlock.entityInside's FREEZE and its server
                    // snowflake (`ServerLevel.sendParticles`). The slowing is
                    // the client's (`makeStuckInBlock`).
    // rust: "minecraft:powder_snow" if damage_only => {
    // rust: self.powder_snow_snowflake(p);
    // rust: entered.push((step, p));
}
    // rust: _ => {}
}
    // rust: if damage_only {
    // rust: continue;
}
    // rust: match name {
    // rust: "minecraft:powder_snow" => {
    // rust: self.powder_snow_inside(p)?;
    // rust: entered.push((step, p));
}
    // rust: "minecraft:cobweb" => self.web_inside(),
    // rust: "minecraft:sweet_berry_bush" => self.sweet_berry_bush_inside(state)?,
    // rust: "minecraft:bubble_column" => {
    // rust: let precise = moved_far || deflated.intersects(Aabb::block(p));
    // rust: self.bubble_column_inside(state, p, precise)?
}
    // rust: "minecraft:nether_portal" => self
    // rust: .player
    // rust: .events
    // rust: .push(MotionEvent::InsidePortal { pos: p }),
    // rust: _ => {}
}
                // ServerPlayer.onInsideBlock
    // rust: self.player.events.push(MotionEvent::EnterBlock { state });
}
}
    // rust: Ok(iterations + 1)
}
    /// `HoneyBlock.entityInside`: a falling player touching a side of the block
    /// slides down it (`isSlidingDown`, `doSlideMovement`, `maybeDoSlideEffects`).
pub fn honey_block_inside(self: *Self, pos: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let old_delta_y = |dy: f64| dy / f64::from(0.98_f32) + 0.08;
    // rust: let new_delta_y = |dy: f64| (dy - 0.08) * f64::from(0.98_f32);
    // rust: let position = self.player.position;
    // rust: let velocity = self.player.velocity;
    // rust: if self.player.ground.on_ground
    // rust: || position.y > f64::from(pos.y) + 0.9375 - 1.0e-7
    // rust: || old_delta_y(velocity.y) >= -0.08
    // rust: {
    // rust: return Ok(());
}
    // rust: let dx = (f64::from(pos.x) + 0.5 - position.x).abs();
    // rust: let dz = (f64::from(pos.z) + 0.5 - position.z).abs();
    // rust: let overlap = 0.4375 + f64::from(self.player.dimensions.width / 2.0);
    // rust: if !(dx + 1.0e-7 > overlap || dz + 1.0e-7 > overlap) {
    // rust: return Ok(());
}
        // doSlideMovement
    // rust: let old = old_delta_y(velocity.y);
    // rust: if old < -0.13 {
    // rust: let factor = -0.05 / old;
    // rust: self.player.velocity =
    // rust: Vec3::new(velocity.x * factor, new_delta_y(-0.05), velocity.z * factor);
    // rust: } else {
    // rust: self.player.velocity = Vec3::new(velocity.x, new_delta_y(-0.05), velocity.z);
}
    // rust: self.player.fall_distance = 0.0;
        // maybeDoSlideEffects: the sound, then the server's event 53.
    // rust: let random = &mut self.scene.random;
    // rust: let sound = random.next_int_bound(5).map_err(|e| format!("{e:?}"))? == 0;
        // Only the server broadcasts event 53 (`!level.isClientSide()`).
    // rust: let particles = !self.player.client_side
    // rust: && random.next_int_bound(5).map_err(|e| format!("{e:?}"))? == 0;
        // The server also checks the slide criterion every 20 game ticks,
        // including ticks without a sound or a particle event.
    // rust: let criterion = !self.player.client_side && self.scene.game_time % 20 == 0;
    // rust: if sound || particles || criterion {
    // rust: self.player.events.push(MotionEvent::HoneySlide {
    // rust: pos,
    // rust: sound,
    // rust: particles,
    // rust: });
}
    // rust: Ok(())
}
    /// `Player.makeStuckInBlock`: the next move is scaled by `multiplier`
    /// (and the fall forgotten) unless flying; the impulse context resets
    /// either way.
pub fn make_stuck_in_block(self: *Self, multiplier: Vec3) void {
}
    // rust: if !self.player.flying {
    // rust: self.player.fall_distance = 0.0;
    // rust: self.player.stuck_multiplier = multiplier;
}
    // rust: self.player.impulse.try_reset();
}
    /// `LavaCauldronBlock.entityInside`: CLEAR_FREEZE, LAVA_IGNITE
    /// (`Entity.lavaIgnite`, 15 seconds) and then `Entity.lavaHurt` (lava,
    /// 4), as ordinary lava does to the player.
pub fn lava_cauldron_inside(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.ticks_frozen = 0;
    // rust: self.player.ignite_for_ticks(300)?;
    // rust: self.environment_hurt("minecraft:lava", 4.0)
}
    /// `LayeredCauldronBlock.entityInside`: on a server, a burning player
    /// asks for the cauldron's `handleEntityOnFireInside` (runBefore
    /// EXTINGUISH, so while still burning), then EXTINGUISH
    /// (`Entity.clearFire`) puts the fire out.
pub fn layered_cauldron_inside(self: *Self, pos: BlockPos) void {
}
    // rust: if self.player.fire_ticks > 0 && !self.player.spectator {
    // rust: self.player
    // rust: .events
    // rust: .push(MotionEvent::CauldronExtinguish { pos });
}
    // rust: self.player.fire_ticks = self.player.fire_ticks.min(0);
}
    /// `WebBlock.entityInside`: stuck at a quarter of the speed, half with
    /// the Weaving effect.
pub fn web_inside(self: *Self) void {
}
    // rust: let multiplier = if self.player.status.weaving {
    // rust: Vec3::new(0.5, 0.25, 0.5)
    // rust: } else {
    // rust: Vec3::new(0.25, f64::from(0.05_f32), 0.25)
}
    // rust: self.make_stuck_in_block(multiplier);
}
    /// `SweetBerryBushBlock.entityInside` for the player: slowed, and pricked
    /// (`sweetBerryBush` damage, 1) by a grown bush while its known movement
    /// is at least 0.003 on X or Z.
pub fn sweet_berry_bush_inside(self: *Self, state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.make_stuck_in_block(Vec3::new(f64::from(0.8_f32), 0.75, f64::from(0.8_f32)));
    // rust: self.sweet_berry_bush_damage(state)
}
    /// The server's half of `SweetBerryBushBlock.entityInside`: the prick.
pub fn sweet_berry_bush_damage(self: *Self, state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let age = self
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("age"))
    // rust: .map_or("0", |a| a.as_str());
    // rust: if age == "0" {
    // rust: return Ok(());
}
        // Player.isClientAuthoritative: ServerPlayer.getKnownMovement, this
        // tick's movement.
    // rust: let known = self.player.position.subtract(self.player.old_position);
    // rust: if known.x * known.x + known.z * known.z > 0.0
    // rust: && (known.x.abs() >= f64::from(0.003_f32) || known.z.abs() >= f64::from(0.003_f32))
    // rust: {
    // rust: let id = self
    // rust: .health
    // rust: .damage
    // rust: .id("minecraft:sweet_berry_bush")
    // rust: .ok_or("missing sweet_berry_bush damage type")?;
    // rust: self.player.events.push(MotionEvent::Health(
    // rust: crate::health::HealthEvent::SweetBerryBushDamage(1.0),
    // rust: ));
    // rust: let rules = self.scene.health_rules;
    // rust: self.player.hurt(self.health, rules, id, 1.0)?;
}
    // rust: Ok(())
}
    /// `PowderSnowBlock.entityInside` for the player: stuck while the block
    /// at its feet is powder snow, with a snowflake now and then (server).
pub fn powder_snow_inside(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let feet = BlockPos::containing(self.player.position);
    // rust: let in_block = self
    // rust: .assets
    // rust: .registry
    // rust: .state(self.block(feet))
    // rust: .is_some_and(|s| s.name == "minecraft:powder_snow");
    // rust: if !in_block {
    // rust: return Ok(());
}
    // rust: self.make_stuck_in_block(Vec3::new(f64::from(0.9_f32), 1.5, f64::from(0.9_f32)));
        // `ServerLevel.sendParticles` is server-only (`!level.isClientSide()`).
    // rust: if !self.player.client_side {
    // rust: self.powder_snow_snowflake(p);
}
    // rust: Ok(())
}
    /// `PowderSnowBlock.entityInside`'s server particle: one snowflake at
    /// the top of `p` when the player moved horizontally this tick.
pub fn powder_snow_snowflake(self: *Self, p: BlockPos) void {
}
    // rust: let feet = BlockPos::containing(self.player.position);
    // rust: if !self
    // rust: .assets
    // rust: .registry
    // rust: .state(self.block(feet))
    // rust: .is_some_and(|s| s.name == "minecraft:powder_snow")
    // rust: {
    // rust: return;
}
        // ServerPlayer.getKnownMovement: this tick's movement.
    // rust: let known = self.player.position.subtract(self.player.old_position);
    // rust: let random = &mut self.scene.random;
    // rust: if (known.x != 0.0 || known.z != 0.0) && random.next_boolean() {
            // Mth.randomBetween(random, -1, 1) * (1 / 12)
    // rust: let xa = (random.next_float() * 2.0 - 1.0) * 0.083_333_336_f32;
    // rust: let za = (random.next_float() * 2.0 - 1.0) * 0.083_333_336_f32;
    // rust: self.player.events.push(MotionEvent::Snowflake {
    // rust: position: Vec3::new(
    // rust: self.player.position.x,
    // rust: f64::from(p.y + 1),
    // rust: self.player.position.z,
    // rust: ),
    // rust: velocity: Vec3::new(f64::from(xa), f64::from(0.05_f32), f64::from(za)),
    // rust: });
}
}
pub fn jump_from_ground(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_motion::jump_from_ground(self)?;
    // rust: if !self.player.replaying {
    // rust: native_living_jump(self.player.entity_id as u32, "minecraft:player");
}
    // rust: self.player
    // rust: .events
    // rust: .push(MotionEvent::Health(crate::health::HealthEvent::Statistic {
    // rust: name: "jump",
    // rust: amount: 1,
    // rust: }));
    // rust: self.player
    // rust: .cause_food_exhaustion(if self.player.sprinting { 0.2 } else { 0.05 });
    // rust: Ok(())
}
    /// LivingEntity.travelFallFlying with updateFallFlyingMovement.
pub fn travel_fall_flying(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = self.player.velocity;
        // getLookAngle and the lean use Mth's sine table and float degrees,
        // the lift Math.cos of the widened lean.
    // rust: let look = horizon_world::view_direction::view_vector(self.player.pitch, self.player.yaw);
    // rust: let lean = self.player.pitch * trig::DEG_TO_RAD;
    // rust: let look_h = (look.x * look.x + look.z * look.z).sqrt();
    // rust: let move_h = (v.x * v.x + v.z * v.z).sqrt();
    // rust: let gravity = living_motion::effective_gravity(self)?;
    // rust: let lift = horizon_core::jmath::cos(f64::from(lean)).powi(2);
    // rust: let mut m = Vec3::new(v.x, v.y + gravity * (-1.0 + lift * 0.75), v.z);
    // rust: if m.y < 0.0 && look_h > 0.0 {
    // rust: let convert = m.y * -0.1 * lift;
    // rust: m = Vec3::new(
    // rust: m.x + look.x * convert / look_h,
    // rust: m.y + convert,
    // rust: m.z + look.z * convert / look_h,
    // rust: );
}
    // rust: if lean < 0.0 && look_h > 0.0 {
    // rust: let convert = move_h * f64::from(-trig::sin(f64::from(lean))) * 0.04;
    // rust: m = Vec3::new(
    // rust: m.x - look.x * convert / look_h,
    // rust: m.y + convert * 3.2,
    // rust: m.z - look.z * convert / look_h,
    // rust: );
}
    // rust: if look_h > 0.0 {
    // rust: m = Vec3::new(
    // rust: m.x + (look.x / look_h * move_h - m.x) * 0.1,
    // rust: m.y,
    // rust: m.z + (look.z / look_h * move_h - m.z) * 0.1,
    // rust: );
}
        // multiply(0.99F, 0.98F, 0.99F): the float factors widened.
    // rust: self.player.velocity = Vec3::new(
    // rust: m.x * f64::from(0.99_f32),
    // rust: m.y * f64::from(0.98_f32),
    // rust: m.z * f64::from(0.99_f32),
    // rust: );
    // rust: let movement = self.player.velocity;
    // rust: let before = self.player.position;
    // rust: self.move_self(movement)?;
        // LivingEntity.handleFallFlyingCollisions: the fall-damage sound plays
        // on both sides (a glider's own travel is client-side, and the sound
        // must reach its own ears, #8906), only the server hurts, and it
        // compares the delta before the move with the one after it, which
        // `Entity.move` leaves as the movement it resolved. `move_entity` does
        // not write that back, so the distance actually travelled stands in.
    // rust: if self.player.collision.horizontal {
    // rust: let travelled = self.player.position.subtract(before);
    // rust: let new_h = (travelled.x * travelled.x + travelled.z * travelled.z).sqrt();
    // rust: let dmg = fly_into_wall_damage(move_h, new_h);
    // rust: if dmg > 0.0 {
    // rust: let first = self.player.events.len();
                // getFallDamageSound((int) dmg)
    // rust: let sound = if dmg as i32 > 4 {
    // rust: crate::landing::SceneSound::BigFall
    // rust: } else {
    // rust: crate::landing::SceneSound::SmallFall
}
    // rust: self.player
    // rust: .events
    // rust: .push(MotionEvent::Fall(crate::landing::FallEvent::Sound {
    // rust: sound,
    // rust: position: None,
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: }));
                // Only the server hurts:
    // rust: if !self.player.client_side {
    // rust: let id = self
    // rust: .health
    // rust: .damage
    // rust: .id("minecraft:fly_into_wall")
    // rust: .ok_or("missing fly_into_wall damage type")?;
    // rust: let rules = self.scene.health_rules;
    // rust: self.player.hurt(self.health, rules, id, dmg)?;
    // rust: if self.player.server_copy {
    // rust: self.player.wall_hit_events = Some(first..self.player.events.len());
}
}
}
}
    // rust: Ok(())
}
    /// `Entity.move(MoverType.SHULKER_BOX, movement)`: a shulker box lid pushed
    /// the player. An ordinary move — the collision scan steps and reads the
    /// ground flag — whose end writes the ground state
    /// (`Entity.setOnGroundWithMovement`): a lid lifting the body off the
    /// ground leaves it airborne, and the next tick's gravity lands it on the
    /// lid again instead of the client holding it on a stale ground.
pub fn shulker_box_push(self: *Self, movement: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: entity_move::move_entity(self, MoverType::ShulkerBox, movement)
}
    /// `LocalPlayer.move`: the move, then `updateAutoJump` with the float
    /// horizontal displacement.
pub fn move_self(self: *Self, movement: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let before = self.player.position;
    // rust: entity_move::move_entity(self, MoverType::SelfMovement, movement)?;
    // rust: let dx = (self.player.position.x - before.x) as f32;
    // rust: let dz = (self.player.position.z - before.z) as f32;
    // rust: self.update_auto_jump(dx, dz)
}
    /// `LocalPlayer.updateAutoJump` behind `canAutoJump`.
pub fn update_auto_jump(self: *Self, xa: f32, za: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = &*self.player;
        // canAutoJump; MotionWorld drives an unmounted player (not a passenger).
    // rust: let ready = crate::auto_jump::can_auto_jump(
    // rust: p.auto_jump_enabled,
    // rust: p.auto_jump_time,
    // rust: p.ground.on_ground,
    // rust: p.shift_key_down,
    // rust: false,
    // rust: p.move_vector,
    // rust: 1.0,
    // rust: );
    // rust: if !ready || f64::from(self.block_jump_factor()?) < 1.0 {
    // rust: return Ok(());
}
        // Player.getSpeed: the movement speed attribute as it is now.
    // rust: let speed = self.player.attribute("minecraft:movement_speed")? as f32;
    // rust: let p = &*self.player;
    // rust: let jumper = crate::auto_jump::AutoJumper {
    // rust: position: p.position,
    // rust: max_y: p.bounds().max_position().y,
    // rust: x_rot: p.pitch,
    // rust: y_rot: p.yaw,
    // rust: speed,
    // rust: move_vector: p.move_vector,
    // rust: width: p.dimensions.width,
    // rust: height: p.dimensions.height,
    // rust: jump_boost: p.status.jump_boost,
}
    // rust: if crate::auto_jump::update_auto_jump(self, &jumper, xa, za)? {
    // rust: self.player.auto_jump_time = 1;
}
    // rust: Ok(())
}
}
    // rust: impl ClimbingWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = std::convert::Infallible;
pub fn is_spectator(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.spectator)
}
pub fn block_position(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(BlockPos::containing(self.player.position))
}
pub fn in_block_state(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.block(BlockPos::containing(self.player.position)))
}
pub fn is_fall_flying(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.fall_flying)
}
    // rust: fn block_state(
    // rust: &mut self,
    // rust: position: BlockPos,
    // rust: ) -> std::result::Result<BlockStateId, Self::Error> {
    // rust: Ok(self.block(position))
}
pub fn set_last_climbable_position(self: *Self, position: BlockPos) void {
}
    // rust: self.player.last_climbable = Some(position);
}
}
    // rust: impl crate::auto_jump::AutoJumpWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
pub fn collision_shape(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let context = self.context();
    // rust: let state = self.block(p);
    // rust: let binding = self.collision_binding;
    // rust: Ok(binding.collision_shape_with_context(&mut self.collisions(), state, p, &context)?)
}
pub fn collision_boxes(self: *Self, bounds: Aabb) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let context = self.context();
    // rust: let mut scene = self.collisions();
    // rust: let mut boxes = Vec::new();
    // rust: for hit in horizon_world::block_collision_scan::BlockCollisionScan::new(
    // rust: &mut scene, context, bounds, false, 1_000_000,
    // rust: )? {
    // rust: boxes.extend_from_slice(hit?.shape.boxes());
}
    // rust: Ok(boxes)
}
}
// Current resident movement domain: dry, standing, no vehicles or gliding.
// The shared kernel also handles swimming/crouching/flight when those states
// are supplied by their eventual runtime bindings.
    // rust: impl MovementStatisticsWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
pub fn passenger(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn swimming(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.swimming)
}
pub fn eyes_in_water(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.is_eye_in_fluid(WATER))
}
pub fn in_water(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.fluids.was_touching_water)
}
pub fn on_climbable(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.climbable()
}
pub fn on_ground(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.ground.on_ground)
}
pub fn sprinting(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.sprinting)
}
pub fn crouching(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.pose == crate::pose::Pose::Crouching)
}
pub fn fall_flying(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn award(self: *Self, stat: MovementStat, amount: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player
    // rust: .events
    // rust: .push(MotionEvent::Health(crate::health::HealthEvent::Statistic {
    // rust: name: stat.name(),
    // rust: amount,
    // rust: }));
    // rust: Ok(())
}
pub fn exhaust(self: *Self, amount: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.cause_food_exhaustion(amount);
    // rust: Ok(())
}
}
    // rust: impl MovementBlockProvider for MotionWorld<'_, '_, '_> {
    // rust: type Error = io::Error;
pub fn movement_block_state(self: *Self, p: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.block(p))
}
}
    // rust: impl EdgeBackoffWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
pub fn max_up_step(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.attribute("minecraft:step_height")? as f32)
}
pub fn staying_on_ground_surface(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.shift_key_down)
}
pub fn on_ground(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.ground.on_ground)
}
pub fn no_collision(self: *Self, bounds: Aabb) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.no_player_collision(bounds)
}
}
    // rust: impl EntityMoveWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
pub fn no_physics(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.spectator
}
pub fn position(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.position
}
pub fn set_position(self: *Self, p: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.position = p;
    // rust: Ok(())
}
pub fn record_movement(self: *Self, mover: MoverType, movement: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player
    // rust: .events
    // rust: .push(MotionEvent::Recorded { mover, movement });
    // rust: Ok(())
}
pub fn collision_flags(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.collision
}
pub fn set_collision_flags(self: *Self, value: CollisionFlags) void {
}
    // rust: self.player.collision = value;
}
    /// `Entity.limitPistonMovement`: the per-tick 0.51-block budget shared by
    /// every move on an axis. A failed game-time read leaves the accumulator
    /// as it was, as native does.
pub fn limit_piston_movement(self: *Self, movement: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let time = self.scene.game_time;
    // rust: self.player
    // rust: .piston
    // rust: .limit(movement, || Ok::<i64, Box<dyn std::error::Error>>(time))
}
pub fn stuck_multiplier(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.stuck_multiplier
}
pub fn set_stuck_multiplier(self: *Self, value: Vec3) void {
}
    // rust: self.player.stuck_multiplier = value;
}
pub fn velocity(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.velocity)
}
pub fn set_velocity(self: *Self, value: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.velocity = value;
    // rust: Ok(())
}
pub fn back_off_edge(self: *Self, movement: Vec3, mover: MoverType) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let input = EdgeBackoffInput {
    // rust: movement,
    // rust: bounds: self.player.bounds(),
            // Player.maybeBackOffFromEdge: not while flying.
    // rust: flying: self.player.flying,
    // rust: self_or_player: matches!(mover, MoverType::SelfMovement | MoverType::Player),
    // rust: fall_distance: self.player.fall_distance,
    // rust: query_budget: 1_000_000,
}
    // rust: edge_backoff::back_off_from_edge(self, input)
    // rust: .map_err(|e| io::Error::other(e.to_string()).into())
}
pub fn collide(self: *Self, movement: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let max_step = self.player.attribute("minecraft:step_height")? as f32;
    // rust: Ok(world_movement::resolve_world_movement(
    // rust: &mut self.movement_collisions(),
    // rust: MovementRequest {
    // rust: entity: EntityIdentity(0),
    // rust: context: self.context(),
    // rust: bounds: self.player.bounds(),
    // rust: movement,
    // rust: max_step,
    // rust: on_ground: self.player.ground.on_ground,
    // rust: candidate_budget: 1_000_000,
    // rust: },
    // rust: )?)
}
pub fn fall_distance(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.fall_distance
}
pub fn fall_reset_clip(self: *Self, from: Vec3, to: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
        // ClipContext.Block.FALLDAMAGE_RESETTING: tagged reset blocks are a full
        // block, not their collider; ClipContext.Fluid.WATER: the water's shape.
        // Both shapes are queried for every visited block (the water's first
        // query fixes its cached shape), either one hitting ends the ray.
    // rust: let hit = traverse_blocks(from, to, 1_000_000, |p| {
    // rust: let water = match self.water_clip(from, to, p) {
    // rust: Ok(hit) => hit,
    // rust: Err(e) => return Some(Err(e)),
}
    // rust: let name = &self.assets.registry.state(self.block(p)).unwrap().name;
    // rust: let reset = self.resources.fall_reset.contains(name)
    // rust: && VoxelShape::block().clip(from, to, p).is_some();
    // rust: (water || reset).then_some(Ok(()))
    // rust: })?;
    // rust: hit.transpose().map(|h| h.is_some())
}
pub fn reset_fall_distance(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.fall_distance = 0.0;
    // rust: Ok(())
}
pub fn movement_history(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.player.history
}
pub fn locally_authoritative(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(!self.player.server_copy)
}
    // rust: fn set_on_ground_with_movement(
    // rust: &mut self,
    // rust: below: bool,
    // rust: horizontal: bool,
    // rust: movement: Vec3,
    // rust: ) -> Result<()> {
    // rust: let position = self.player.position;
    // rust: let bounds = self.player.bounds();
    // rust: let context = self.context();
    // rust: let mut collisions = SceneCollisions {
    // rust: world: self.scene,
    // rust: binding: self.collision_binding,
    // rust: subject: Some(self.player.powder_snow_subject()),
}
    // rust: self.player.ground.set_with_movement(
    // rust: below,
    // rust: horizontal,
    // rust: bounds,
    // rust: Some(movement),
    // rust: |bounds| find_supporting_block(&mut collisions, context, position, bounds, 1_000_000),
    // rust: )?;
    // rust: Ok(())
}
    /// `LocalPlayer.isHorizontalCollisionMinor`: the move that hit a wall was
    /// within 8 degrees of the direction the input asked for.
pub fn minor_horizontal_collision(self: *Self, movement: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(horizontal_collision_minor(
    // rust: self.player.yaw,
    // rust: self.player.applied_input,
    // rust: movement,
    // rust: ))
}
pub fn legacy_on_position(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.support(movement_support::LEGACY_SUPPORT_OFFSET)
}
pub fn block_state(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.block(p))
}
pub fn on_ground(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.ground.on_ground)
}
    // rust: fn check_fall_damage(
    // rust: &mut self,
    // rust: dy: f64,
    // rust: grounded: bool,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: ) -> Result<()> {
        // LivingEntity.aiStep: Slow Falling and Levitation reset the fall
        // distance every tick, so landing under either does not hurt.
    // rust: if self.player.status.slow_falling || self.player.status.levitation.is_some() {
    // rust: self.player.fall_distance = 0.0;
}
        // LivingEntity.checkFallDamage: a landing runs onChangedBlock.
    // rust: if grounded && self.player.fall_distance > 0.0 {
    // rust: self.player.location_effects.landed = true;
}
    // rust: if self.player.spawn_extra_particles_on_fall && grounded && self.player.fall_distance > 0.0
    // rust: {
    // rust: self.player.events.push(MotionEvent::SmashLanding {
    // rust: state,
    // rust: position,
    // rust: fall_distance: self.player.fall_distance,
    // rust: });
    // rust: self.player.spawn_extra_particles_on_fall = false;
}
    // rust: self.player.events.push(MotionEvent::Landing {
    // rust: dy,
    // rust: grounded,
    // rust: state,
    // rust: position,
    // rust: });
    // rust: horizon_world::living_landing::check_living_fall_damage(self, dy, grounded, state, position)
}
pub fn removed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn can_simulate(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(true)
}
pub fn restitute(self: *Self, state: BlockStateId, x: bool, z: bool, resolved: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let input = RestitutionInput {
    // rust: block: state,
    // rust: collided_x: x,
    // rust: collided_z: z,
    // rust: vertical_collision: self.player.collision.vertical,
    // rust: collision_below: self.player.collision.below,
    // rust: living: true,
    // rust: resolved_movement: resolved,
    // rust: fall_distance: self.player.fall_distance,
}
    // rust: movement_restitution::restitute_movement(self, input)
}
pub fn client_side(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn movement_emission(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: <Self as MovementEmissionWorld>::movement_emission(self)
}
pub fn passenger(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
    /// `Entity.applyMovementEmissionAndPlaySound`: a footstep (`Emission`)
    /// only once the walked distance passes `nextStep`. Emitting on every
    /// move played a step sound each tick, even standing still on the
    /// ground (gravity moves the player every tick), as an endless loop.
    // rust: fn apply_movement_emission(
    // rust: &mut self,
    // rust: kind: MovementEmission,
    // rust: movement: Vec3,
    // rust: position: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> Result<()> {
    // rust: emission::apply_movement_emission(self, kind, movement, position, state)
}
pub fn block_speed_factor(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let efficiency = self.player.attribute("minecraft:movement_efficiency")? as f32;
    // rust: let location = self.location();
    // rust: let block = movement_support::block_speed_factor(
    // rust: &mut RegistryMovementWorld {
    // rust: properties: &self.resources.blocks,
    // rust: world: self,
    // rust: },
    // rust: location,
    // rust: )?;
    // rust: Ok(block + efficiency * (1.0 - block))
}
}
// The player's footsteps and swim sounds. Flapping and the step game event
// are not bound here (the sculk listeners track the player's steps themselves).
    // rust: impl MovementEmissionWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
    // rust: type State = BlockStateId;
pub fn distances(self: *Self) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.steps
}
pub fn set_movement_distance(self: *Self, value: f32) void {
}
    // rust: self.player.steps.movement = value;
}
pub fn set_flight_distance(self: *Self, value: f32) void {
}
    // rust: self.player.steps.flight = value;
}
pub fn set_next_step(self: *Self, value: f32) void {
}
    // rust: self.player.steps.next_step = value;
}
pub fn on_position(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.support(movement_support::ON_SUPPORT_OFFSET)
}
pub fn block_state(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.block(p))
}
pub fn is_air(self: *Self, s: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = &self
    // rust: .assets
    // rust: .registry
    // rust: .state(s)
    // rust: .ok_or("missing scene state")?
    // rust: .name;
    // rust: Ok(matches!(
    // rust: name.as_str(),
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: ))
}
pub fn climbable_tag(self: *Self, s: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = &self
    // rust: .assets
    // rust: .registry
    // rust: .state(s)
    // rust: .ok_or("missing scene state")?
    // rust: .name;
    // rust: Ok(self.resources.climbable.contains(name))
}
pub fn is_powder_snow(self: *Self, s: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = &self
    // rust: .assets
    // rust: .registry
    // rust: .state(s)
    // rust: .ok_or("missing scene state")?
    // rust: .name;
    // rust: Ok(name == "minecraft:powder_snow")
}
pub fn on_ground(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.ground.on_ground)
}
pub fn crouching(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.pose == crate::pose::Pose::Crouching)
}
pub fn on_rails(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn swimming(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.swimming)
}
pub fn in_water(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.fluids.was_touching_water)
}
    /// `Player.playStepSound`: in water a swim sound, then the step muffled;
    /// on land the step of an inside-sound block above the floor, or of a
    /// combination block above it with the floor's step muffled.
pub fn walking_step_sound(self: *Self, position: BlockPos, state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let muffled = self.player.fluids.was_touching_water;
    // rust: let mut stepped = false;
    // rust: if muffled {
    // rust: self.water_swim_sound()?;
    // rust: } else {
            // Entity.getPrimaryStepSoundBlockPos.
    // rust: let above = BlockPos {
    // rust: y: position.y + 1,
    // rust: ..position
}
    // rust: let above_state = self.block(above);
    // rust: let name = &self
    // rust: .assets
    // rust: .registry
    // rust: .state(above_state)
    // rust: .ok_or("missing scene state")?
    // rust: .name;
    // rust: let combination = self.resources.combination_step_sound.contains(name);
    // rust: if combination || self.resources.inside_step_sound.contains(name) {
    // rust: self.player.events.push(MotionEvent::Emission {
    // rust: position: above,
    // rust: state: above_state,
    // rust: muffled: false,
    // rust: });
    // rust: if combination {
                    // Entity.playCombinationStepSounds.
    // rust: self.player.events.push(MotionEvent::Emission {
    // rust: position,
    // rust: state,
    // rust: muffled: true,
    // rust: });
}
    // rust: stepped = true;
}
}
    // rust: if !stepped {
    // rust: self.player.events.push(MotionEvent::Emission {
    // rust: position,
    // rust: state,
    // rust: muffled,
    // rust: });
}
        // Entity.walkingStepSound: the amethyst chime after the step, by the
        // floor's state even when the step sound was the block above's.
    // rust: let name = &self
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .ok_or("missing scene state")?
    // rust: .name;
    // rust: let tick = self.player.health.tick_count;
    // rust: if self.resources.crystal_sound.contains(name)
    // rust: && tick >= self.player.last_crystal_sound_play_tick + 20
    // rust: {
            // Entity.playAmethystStepSound (the level random stands in for
            // the entity's).
    // rust: let elapsed = f64::from(tick - self.player.last_crystal_sound_play_tick);
    // rust: let decayed = self.player.crystal_sound_intensity * 0.997_f64.powf(elapsed) as f32;
    // rust: let intensity = 1.0_f32.min(decayed + 0.07);
    // rust: self.player.crystal_sound_intensity = intensity;
    // rust: let pitch = 0.5 + intensity * self.scene.random.next_float() * 1.2;
    // rust: let volume = 0.1 + intensity * 1.2;
    // rust: self.player
    // rust: .events
    // rust: .push(MotionEvent::Chime { volume, pitch });
    // rust: self.player.last_crystal_sound_play_tick = tick;
}
    // rust: Ok(())
}
pub fn step_event(self: *Self, _: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn next_step(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.steps.next_step())
}
    /// `Entity.waterSwimSound` and `playSwimSound` (the level random stands
    /// in for the entity's, as for the splash).
pub fn water_swim_sound(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = self.player.velocity;
    // rust: let volume = 1.0_f32.min(
    // rust: (v.x * v.x * f64::from(0.2_f32) + v.y * v.y + v.z * v.z * f64::from(0.2_f32)).sqrt()
    // rust: as f32
    // rust: * 0.35,
    // rust: );
    // rust: let random = &mut self.scene.random;
    // rust: let pitch = 1.0 + (random.next_float() - random.next_float()) * 0.4;
    // rust: self.player.events.push(MotionEvent::Swim { volume, pitch });
    // rust: Ok(())
}
pub fn entity_event(self: *Self, _: MovementEvent) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn flapping(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn on_flap(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
    /// `Player.getMovementEmission`: nothing while flying or sneaking on
    /// the ground.
pub fn movement_emission(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let discreet = self.player.ground.on_ground && self.player.shift_key_down;
    // rust: Ok(if self.player.flying || discreet {
    // rust: MovementEmission::None
    // rust: } else {
    // rust: MovementEmission::All
    // rust: })
}
}
    // rust: impl RestitutionWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
pub fn suppressing_bounce(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.shift_key_down)
}
pub fn entity_bounciness(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.attribute("minecraft:bounciness")
}
pub fn velocity(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.velocity)
}
pub fn effective_gravity(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_motion::effective_gravity(self)
}
pub fn block_suppresses_bounce(self: *Self, state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.resources.blocks.get(state)?.suppresses_bounce)
}
pub fn block_bounce_restitution(self: *Self, state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .resources
    // rust: .blocks
    // rust: .get(state)?
    // rust: .coefficients
    // rust: .bounce_restitution)
}
pub fn air_drag(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_motion::air_drag(self)
}
pub fn movement_support_position(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.support(movement_support::MOVEMENT_SUPPORT_OFFSET)
}
    // rust: fn bounce_on(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: fall_distance: f64,
    // rust: ) -> Result<()> {
    // rust: self.player.events.push(MotionEvent::Bounce {
    // rust: state,
    // rust: position,
    // rust: fall_distance,
    // rust: });
    // rust: self.resources
    // rust: .landing
    // rust: .bounce_on(
    // rust: self,
    // rust: state,
    // rust: position,
    // rust: horizon_world::block_landing::LandingEntityKind::Player,
    // rust: )
    // rust: .map_err(|e| e.to_string().into())
}
pub fn bounce_event(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn mark_position_for_sync(self: *Self) void {
}
    // rust: self.player.sync_position = true;
}
pub fn set_velocity(self: *Self, value: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.velocity = value;
    // rust: Ok(())
}
}
    // rust: impl LivingAirWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
pub fn movement_support_position(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.support(movement_support::MOVEMENT_SUPPORT_OFFSET)
}
pub fn on_ground(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.ground.on_ground)
}
pub fn block_friction(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .resources
    // rust: .blocks
    // rust: .get(self.block(p))?
    // rust: .coefficients
    // rust: .friction)
}
pub fn friction_modifier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.attribute("minecraft:friction_modifier")
}
pub fn speed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.attribute("minecraft:movement_speed")? as f32)
}
pub fn flying_speed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.player.flying {
            // Player.getFlyingSpeed: abilities speed, doubled when sprinting.
    // rust: return Ok(self.player.flying_speed * if self.player.sprinting { 2.0 } else { 1.0 });
}
    // rust: Ok(if self.player.sprinting {
    // rust: 0.025999999
    // rust: } else {
    // rust: 0.02
    // rust: })
}
pub fn yaw(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.yaw)
}
pub fn velocity(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.velocity
}
pub fn set_velocity(self: *Self, v: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.velocity = v;
    // rust: Ok(())
}
pub fn on_climbable(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.climbable()
}
pub fn reset_fall_distance(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.fall_distance = 0.0;
    // rust: Ok(())
}
pub fn in_scaffolding(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .assets
    // rust: .registry
    // rust: .state(self.block(BlockPos::containing(self.player.position)))
    // rust: .unwrap()
    // rust: .name
    // rust: == "minecraft:scaffolding")
}
pub fn suppressing_ladder_slide(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.shift_key_down)
}
pub fn is_player_class(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn move_self(self: *Self, v: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MotionWorld::move_self(self, v)
}
pub fn horizontal_collision(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.collision.horizontal
}
pub fn jumping(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.jumping
}
pub fn was_in_powder_snow(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.was_in_powder_snow
}
pub fn can_walk_powder_snow(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.leather_boots)
}
pub fn levitation_amplifier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.status.levitation)
}
pub fn is_client_side(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.client_side)
}
pub fn has_chunk_at(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.chunks.contains_key(&(p.x >> 4, p.z >> 4)))
}
pub fn effective_gravity(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_motion::effective_gravity(self)
}
pub fn y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.position.y
}
pub fn minimum_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.scene.shape.min_y)
}
pub fn discard_friction(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn air_drag_modifier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.attribute("minecraft:air_drag_modifier")
}
pub fn omnidirectional_air_mover(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
}
    // rust: impl LivingMotionWorld for MotionWorld<'_, '_, '_> {
    // rust: type Error = Box<dyn std::error::Error>;
pub fn velocity(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.velocity
}
pub fn set_velocity(self: *Self, v: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.velocity = v;
    // rust: Ok(())
}
pub fn jump_strength(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.attribute("minecraft:jump_strength")
}
pub fn block_jump_factor(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let location = self.location();
    // rust: Ok(movement_support::block_jump_factor(
    // rust: &mut RegistryMovementWorld {
    // rust: properties: &self.resources.blocks,
    // rust: world: self,
    // rust: },
    // rust: location,
    // rust: )?)
}
pub fn has_jump_boost(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.status.jump_boost.is_some())
}
pub fn jump_boost_amplifier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player
    // rust: .status
    // rust: .jump_boost
    // rust: .ok_or_else(|| "absent jump boost".into())
}
pub fn sprinting(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.sprinting)
}
pub fn yaw(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.yaw)
}
pub fn mark_needs_sync(self: *Self) void {
}
    // rust: self.player.needs_sync = true;
}
pub fn no_gravity(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn gravity_attribute(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.attribute("minecraft:gravity")
}
pub fn has_slow_falling(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.status.slow_falling)
}
pub fn controlling_passenger_is_player(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn speed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.player.attribute("minecraft:movement_speed")? as f32)
}
pub fn omnidirectional_air_mover(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn air_drag_modifier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.attribute("minecraft:air_drag_modifier")
}
}

/// `LocalPlayer.isHorizontalCollisionMinor` for the input `[xxa, zza]`.
pub fn horizontal_collision_minor(yaw: f32, input: [f32; 2], movement: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rad = yaw * (std::f32::consts::PI / 180.0);
    // rust: let sin = f64::from(horizon_core::geometry::trig::sin(f64::from(rad)));
    // rust: let cos = f64::from(horizon_core::geometry::trig::cos(f64::from(rad)));
    // rust: let (xxa, zza) = (f64::from(input[0]), f64::from(input[1]));
    // rust: let global_x = xxa * cos - zza * sin;
    // rust: let global_z = zza * cos + xxa * sin;
    // rust: let a_len = global_x * global_x + global_z * global_z;
    // rust: let m_len = movement.x * movement.x + movement.z * movement.z;
    // rust: if a_len < f64::from(1.0e-5_f32) || m_len < f64::from(1.0e-5_f32) {
    // rust: return false;
}
    // rust: let dot = global_x * movement.x + global_z * movement.z;
    // rust: horizon_core::jmath::acos(dot / (a_len * m_len).sqrt()) < f64::from(0.13962634_f32)
}

/// `LivingEntity.handleFallFlyingCollisions`: a glide a block stopped takes
/// `(before - after) * 10 - 3`, and nothing when that is not positive.
pub fn fly_into_wall_damage(before: f64, after: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((before - after) * 10.0 - 3.0) as f32
}

/// `Entity.getBlockSpeedFactor` for a kind that keeps no motion world of its
/// own (mobs, boats): the factor of the block at `position`, else of the one
/// below it, through the same port the player's move uses.
    // rust: pub fn block_speed_factor_at(
    // rust: world: &World,
    // rust: properties: &BoundMovementProperties,
    // rust: position: Vec3,
    // rust: supporting_block: Option<BlockPos>,
    // rust: ) -> f32 {
pub const Blocks = struct {};
    // rust: impl MovementBlockProvider for Blocks<'_> {
    // rust: type Error = ();
pub fn movement_block_state(self: *Self, p: BlockPos) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.0.block(p.x, p.y, p.z))
}
}
    // rust: let location = movement_support::MovementLocation {
    // rust: position,
    // rust: block_position: BlockPos::new(
    // rust: position.x.floor() as i32,
    // rust: position.y.floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ),
    // rust: supporting_block,
}
    // rust: let mut view = Blocks(world);
    // rust: movement_support::block_speed_factor(
    // rust: &mut RegistryMovementWorld {
    // rust: properties,
    // rust: world: &mut view,
    // rust: },
    // rust: location,
    // rust: )
    // rust: .unwrap_or(1.0)
}

    // rust: mod tests {
    /// The glide's collision damage: a third of a block a tick lost is 0.0 and
    /// does nothing, more than that hurts, and a move a block stopped loses
    /// everything it had.
pub fn a_glide_hurts_by_what_a_collision_took_off_its_speed() void {
}
    // rust: assert_eq!(fly_into_wall_damage(0.5, 0.5), -3.0);
    // rust: assert_eq!(fly_into_wall_damage(0.3, 0.0), 0.0);
    // rust: assert!((fly_into_wall_damage(0.5, 0.1) - 1.0).abs() < 1e-5);
    // rust: assert!((fly_into_wall_damage(1.2, 0.0) - 9.0).abs() < 1e-5);
}

//     use super::*;

    /// `LocalPlayer.isHorizontalCollisionMinor`: sliding along a wall at a
    /// small angle to the input is minor; a sideways slide is not.
pub fn horizontal_collision_minor_by_angle() void {
}
        // Yaw 0 looks along +z; forward input.
    // rust: let fwd = [0.0, 1.0];
    // rust: assert!(horizontal_collision_minor(
    // rust: 0.0,
    // rust: fwd,
    // rust: Vec3::new(0.02, 0.0, 0.2)
    // rust: ));
    // rust: assert!(!horizontal_collision_minor(
    // rust: 0.0,
    // rust: fwd,
    // rust: Vec3::new(0.2, 0.0, 0.05)
    // rust: ));
    // rust: assert!(!horizontal_collision_minor(
    // rust: 0.0,
    // rust: fwd,
    // rust: Vec3::new(0.0, 0.0, 0.0)
    // rust: ));
    // rust: assert!(!horizontal_collision_minor(
    // rust: 0.0,
    // rust: [0.0, 0.0],
    // rust: Vec3::new(0.0, 0.0, 0.2)
    // rust: ));
}

pub fn a_glide_that_just_ended_moves_slowly_until_the_pose_changes() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("skipped glide exit regression: prepared resources unavailable");
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut p = PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: p.set_pose(crate::pose::Pose::FallFlying).unwrap();
        // Gliding: LivingEntity.isVisuallySwimming is false.
    // rust: p.fall_flying = true;
    // rust: assert!(!p.moving_slowly());
        // The glide ended, the pose not yet: visually crawling.
    // rust: p.fall_flying = false;
    // rust: assert!(p.moving_slowly());
        // Not in water (Entity.isVisuallyCrawling).
    // rust: p.fluids.was_touching_water = true;
    // rust: assert!(!p.moving_slowly());
    // rust: p.fluids.was_touching_water = false;
    // rust: p.set_pose(crate::pose::Pose::Standing).unwrap();
    // rust: assert!(!p.moving_slowly());
}

pub fn sword_sweep_requires_charge_ground_and_slow_horizontal_movement() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("skipped sword sweep regression: prepared resources unavailable");
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut p = PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: p.ground.on_ground = true;
    // rust: p.speed = 0.1;
    // rust: assert!(p.is_sweep_attack(1.0, false, true));
    // rust: assert!(!p.is_sweep_attack(0.9, false, true));
    // rust: assert!(!p.is_sweep_attack(1.0, true, true));
    // rust: assert!(!p.is_sweep_attack(1.0, false, false));
    // rust: p.sprinting = true;
    // rust: assert!(!p.is_sweep_attack(1.0, false, true));
    // rust: p.sprinting = false;
    // rust: p.ground.on_ground = false;
    // rust: assert!(!p.is_sweep_attack(1.0, false, true));
    // rust: p.ground.on_ground = true;
    // rust: p.velocity = Vec3::new(0.2, 10.0, 0.0);
    // rust: assert!(p.is_sweep_attack(1.0, false, true));
    // rust: p.velocity.z = 0.2;
    // rust: assert!(!p.is_sweep_attack(1.0, false, true));
    // rust: p.velocity = Vec3::new(f64::from(p.speed) * 2.5, 0.0, 0.0);
    // rust: assert!(!p.is_sweep_attack(1.0, false, true));
}

pub fn max_health_modifier_changes_clamp_health() void {
}
        // #8573: LivingEntity.onAttributeUpdated clamps health to max_health
        // for every modifier change, with no explicit clamp call.
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("skipped health clamp: prepared resources unavailable");
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut p = PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: let boost = "minecraft:effect.health_boost";
        // Health boost I: +4 max health, and the hearts are filled.
    // rust: p.set_modifier("minecraft:max_health", boost, 4.0, "add_value", true)
    // rust: .unwrap();
    // rust: p.set_health(24.0, false).unwrap();
        // An unrelated attribute change leaves the boosted hearts alone.
    // rust: p.set_modifier("minecraft:armor", "minecraft:x", 2.0, "add_value", true)
    // rust: .unwrap();
    // rust: assert_eq!(p.health.health(), 24.0);
    // rust: p.set_modifier("minecraft:max_health", boost, 0.0, "add_value", false)
    // rust: .unwrap();
    // rust: assert_eq!(p.attribute("minecraft:max_health").unwrap(), 20.0);
    // rust: assert_eq!(p.health.health(), 20.0);
        // Below the maximum a lost modifier never raises or lowers health.
    // rust: p.set_modifier(
    // rust: "minecraft:max_health",
    // rust: "minecraft:gear",
    // rust: 6.0,
    // rust: "add_value",
    // rust: true,
    // rust: )
    // rust: .unwrap();
    // rust: p.set_health(7.0, false).unwrap();
    // rust: p.set_modifier(
    // rust: "minecraft:max_health",
    // rust: "minecraft:gear",
    // rust: 0.0,
    // rust: "add_value",
    // rust: false,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(p.health.health(), 7.0);
        // An equipment-style multiplier is covered the same way.
    // rust: p.set_modifier(
    // rust: "minecraft:max_health",
    // rust: "minecraft:gear",
    // rust: 0.5,
    // rust: "add_multiplied_base",
    // rust: true,
    // rust: )
    // rust: .unwrap();
    // rust: p.set_health(30.0, false).unwrap();
    // rust: p.set_modifier(
    // rust: "minecraft:max_health",
    // rust: "minecraft:gear",
    // rust: 0.0,
    // rust: "add_multiplied_base",
    // rust: false,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(p.health.health(), 20.0);
        // A remove-all/re-add batch keeps boosted hearts (unrelated effect).
    // rust: p.set_modifier("minecraft:max_health", boost, 4.0, "add_value", true)
    // rust: .unwrap();
    // rust: p.set_health(24.0, false).unwrap();
    // rust: p.set_modifier_unclamped("minecraft:max_health", boost, 0.0, "add_value", false)
    // rust: .unwrap();
    // rust: p.set_modifier_unclamped("minecraft:max_health", boost, 4.0, "add_value", true)
    // rust: .unwrap();
    // rust: p.clamp_health_to_max().unwrap();
    // rust: assert_eq!(p.health.health(), 24.0);
}

pub fn attribute_bases_survive_a_save_and_reload() void {
}
        // #4425: LivingEntity.addAdditionalSaveData writes AttributeMap.pack
        // and readAdditionalSaveData applies it (before the health).
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("skipped attribute save: prepared resources unavailable");
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut p = PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: let set_base = |p: &mut PlayerMotion, name: &str, v: f64| {
    // rust: let key = p.attributes.key(name).unwrap();
    // rust: let h = p.attributes.get_instance(Some(key)).unwrap().unwrap();
    // rust: p.attributes
    // rust: .edit(&h, |a, o| a.set_base_value(v, o))
    // rust: .unwrap();
}
    // rust: set_base(&mut p, "minecraft:scale", 2.0);
    // rust: set_base(&mut p, "minecraft:max_health", 30.0);
    // rust: let key = p.attributes.key("minecraft:max_health").unwrap();
    // rust: let h = p.attributes.get_instance(Some(key)).unwrap().unwrap();
    // rust: let bonus = Modifier::new("test:bonus", 0.5, Operation::AddMultipliedBase).unwrap();
    // rust: p.attributes
    // rust: .edit(&h, |a, o| a.add_permanent(bonus, o))
    // rust: .unwrap();
    // rust: let mut level = crate::save::Level {
    // rust: health: 40.0,
    // rust: food: 20,
    // rust: saturation: 5.0,
    // rust: player_extra: Some(horizon_world::nbt::Tag::compound([(
    // rust: "attributes",
    // rust: p.saved_attributes(),
    // rust: )])),
    // rust: ..Default::default()
}
        // Through the player compound as the file holds it.
    // rust: let tag = level.player_tag();
    // rust: level = crate::save::Level::default();
    // rust: level.read_player(&tag);
    // rust: level.player_extra = Some(tag);
    // rust: let mut back = PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: let mut pending = true;
    // rust: back.load_saved_state_once(&mut pending, &level).unwrap();
    // rust: let base = |p: &mut PlayerMotion, name: &str| {
    // rust: let key = p.attributes.key(name).unwrap();
    // rust: p.attributes.value(Some(key), ValueKind::Base).unwrap()
}
    // rust: assert_eq!(base(&mut back, "minecraft:scale"), 2.0);
    // rust: assert_eq!(base(&mut back, "minecraft:max_health"), 30.0);
    // rust: assert_eq!(back.attribute("minecraft:max_health").unwrap(), 45.0);
    // rust: assert_eq!(back.health.health(), 40.0);
}

pub fn player_stands_walks_sneaks_and_jumps_on_ghast() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
    // rust: let entities = [Aabb::new(
    // rust: Vec3::new(10.0, 80.0, 10.0),
    // rust: Vec3::new(14.0, 84.0, 14.0),
    // rust: )];
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(12.0, 84.0, 12.0)).unwrap();
    // rust: let mut tick = |player: &mut PlayerMotion, keys| {
    // rust: MotionWorld {
    // rust: entities: &entities,
    // rust: player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(keys)
    // rust: .unwrap()
}
    // rust: for _ in 0..20 {
    // rust: tick(&mut player, Default::default());
}
    // rust: assert_eq!(player.position.y, 84.0);
    // rust: assert!(player.ground.on_ground);
    // rust: let forward = crate::sprint::Keys {
    // rust: forward: true,
    // rust: ..Default::default()
}
    // rust: for _ in 0..5 {
    // rust: tick(&mut player, forward);
}
    // rust: assert!(player.position.z > 12.0);
    // rust: assert_eq!(player.position.y, 84.0);
    // rust: tick(
    // rust: &mut player,
    // rust: crate::sprint::Keys {
    // rust: jump: true,
    // rust: ..Default::default()
    // rust: },
    // rust: );
    // rust: assert!(player.position.y > 84.0);
    // rust: for _ in 0..30 {
    // rust: tick(&mut player, Default::default());
}
    // rust: assert_eq!(player.position.y, 84.0);
    // rust: for _ in 0..80 {
    // rust: tick(
    // rust: &mut player,
    // rust: crate::sprint::Keys {
    // rust: shift: true,
    // rust: ..forward
    // rust: },
    // rust: );
}
    // rust: assert_eq!(player.position.y, 84.0);
    // rust: assert!(player.position.z < 14.3);
    // rust: for _ in 0..30 {
    // rust: tick(&mut player, forward);
}
    // rust: assert!(player.position.y < 84.0);
}

    /// `MovingPistonBlock.getCollisionShape`: a block halfway through a push
    /// up is solid at its moving position, so a player lands on it.
pub fn a_player_lands_on_a_block_a_piston_is_moving() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
    // rust: let registry = assets.registry;
    // rust: let moving = registry.default_state("minecraft:moving_piston").unwrap();
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: scene.set(20, 4, 20, moving).unwrap();
    // rust: scene.moving_pistons.push((
    // rust: [20, 4, 20],
    // rust: horizon_world::piston_shape::MovingPistonState {
    // rust: moved_state: stone,
    // rust: direction: horizon_core::geometry::Direction::Up,
    // rust: extending: true,
    // rust: source: false,
    // rust: progress: 0.5,
    // rust: previous_progress: 0.0,
    // rust: },
    // rust: ));
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 6.0, 20.5)).unwrap();
    // rust: for _ in 0..30 {
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(Default::default())
    // rust: .unwrap();
}
    // rust: assert!(player.ground.on_ground);
    // rust: assert_eq!(player.position.y, 4.5);
        // Once the block entity is gone, the moving_piston block has no shape.
    // rust: scene.moving_pistons.clear();
    // rust: for _ in 0..10 {
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(Default::default())
    // rust: .unwrap();
}
    // rust: assert_eq!(player.position.y, 4.0);
}

pub fn a_lava_cauldron_burns_the_player_inside_it() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
    // rust: let cauldron = assets
    // rust: .registry
    // rust: .default_state("minecraft:lava_cauldron")
    // rust: .unwrap();
    // rust: scene.set(20, 4, 20, cauldron).unwrap();
    // rust: let mut tick = |player: &mut PlayerMotion| {
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(Default::default())
    // rust: .unwrap();
}
        // Standing on the cauldron's floor, in its lava.
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.25, 20.5)).unwrap();
    // rust: player.ticks_frozen = 40;
    // rust: tick(&mut player);
    // rust: assert!(player.health.health() < 20.0, "the lava must hurt");
    // rust: assert!(player.fire_ticks > 0, "the lava must ignite");
    // rust: assert_eq!(player.ticks_frozen, 0);
        // Beside it, nothing.
    // rust: let mut away = PlayerMotion::new(&resources, Vec3::new(22.5, 4.0, 20.5)).unwrap();
    // rust: tick(&mut away);
    // rust: assert_eq!(away.health.health(), 20.0);
    // rust: assert!(away.fire_ticks <= 0);
}

pub fn a_water_cauldron_puts_out_a_burning_player() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
    // rust: let water = assets
    // rust: .registry
    // rust: .resolve(&horizon_world::chunk::BlockState {
    // rust: name: "minecraft:water_cauldron".into(),
    // rust: properties: [("level".to_owned(), "3".to_owned())].into(),
    // rust: })
    // rust: .unwrap();
    // rust: scene.set(20, 4, 20, water).unwrap();
    // rust: let mut tick = |player: &mut PlayerMotion| {
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(Default::default())
    // rust: .unwrap();
}
    // rust: let asks = |player: &PlayerMotion| {
    // rust: player
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MotionEvent::CauldronExtinguish { .. }))
    // rust: .count()
}
        // Burning, on the cauldron's floor in its water: put out, and the
        // server is asked to lower the water.
    // rust: let mut burning = PlayerMotion::new(&resources, Vec3::new(20.5, 4.25, 20.5)).unwrap();
    // rust: burning.fire_ticks = 100;
    // rust: tick(&mut burning);
    // rust: assert!(burning.fire_ticks <= 0, "the water must put the fire out");
    // rust: assert_eq!(asks(&burning), 1);
        // Not burning: nothing to lower.
    // rust: let mut dry = PlayerMotion::new(&resources, Vec3::new(20.5, 4.25, 20.5)).unwrap();
    // rust: tick(&mut dry);
    // rust: assert_eq!(asks(&dry), 0);
}

pub fn standing_in_a_wither_rose_asks_for_its_effect() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
    // rust: let rose = assets
    // rust: .registry
    // rust: .default_state("minecraft:wither_rose")
    // rust: .unwrap();
    // rust: scene.set(20, 4, 20, rose).unwrap();
    // rust: let roses = |player: &PlayerMotion| {
    // rust: player
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MotionEvent::InsideWitherRose))
    // rust: .count()
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(Default::default())
    // rust: .unwrap();
    // rust: assert_eq!(roses(&player), 1);
        // A server's player: its client moved it, the server applies the effect.
    // rust: player.events.clear();
    // rust: let from = player.position;
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .server_block_damage(from)
    // rust: .unwrap();
    // rust: assert_eq!(roses(&player), 1);
        // Two blocks away, nothing.
    // rust: let mut away = PlayerMotion::new(&resources, Vec3::new(22.5, 4.0, 20.5)).unwrap();
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut away,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(Default::default())
    // rust: .unwrap();
    // rust: assert_eq!(roses(&away), 0);
}

    /// #8156: a window's own player carried by a boat does not travel, but it still freezes
    /// in powder snow and thaws out of it (`LivingEntity.aiStep`), or the frostbite overlay,
    /// which reads `ticks_frozen`, never shows.
pub fn a_passenger_in_powder_snow_freezes_and_thaws() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
    // rust: let snow = assets
    // rust: .registry
    // rust: .default_state("minecraft:powder_snow")
    // rust: .unwrap();
    // rust: scene.set(20, 4, 20, snow).unwrap();
    // rust: let in_snow = Vec3::new(20.5, 4.0, 20.5);
    // rust: let clear = Vec3::new(30.5, 4.0, 30.5);
    // rust: let mut player = PlayerMotion::new(&resources, in_snow).unwrap();
    // rust: player.client_side = true;
    // rust: let tick = |player: &mut PlayerMotion, scene: &mut World| {
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player,
    // rust: scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .passenger_block_effects_tick()
    // rust: .unwrap();
}
        // One tick of frost for each tick in powder snow, up to the 140 that freeze fully.
    // rust: for expected in 1..=5 {
    // rust: tick(&mut player, &mut scene);
    // rust: assert!(player.in_powder_snow);
    // rust: assert_eq!(player.ticks_frozen, expected);
}
    // rust: for _ in 0..200 {
    // rust: tick(&mut player, &mut scene);
}
    // rust: assert_eq!(player.ticks_frozen, PlayerMotion::TICKS_REQUIRED_TO_FREEZE);
    // rust: assert!(player.is_fully_frozen());
        // Carried out of it: two ticks of frost thaw each tick.
    // rust: player.position = clear;
    // rust: player.old_position = clear;
    // rust: player.ticks_frozen = 5;
    // rust: for expected in [3, 1, 0, 0] {
    // rust: tick(&mut player, &mut scene);
    // rust: assert!(!player.in_powder_snow);
    // rust: assert_eq!(player.ticks_frozen, expected);
}
        // What cannot freeze (a freeze-immune player) takes no frost in it.
    // rust: player.position = in_snow;
    // rust: player.old_position = in_snow;
    // rust: player.freeze_immune = true;
    // rust: tick(&mut player, &mut scene);
    // rust: assert_eq!(player.ticks_frozen, 0);
        // Block effects off (a mod's switch): nothing is sampled, the frost thaws.
    // rust: player.freeze_immune = false;
    // rust: player.block_effects = false;
    // rust: player.ticks_frozen = 10;
    // rust: tick(&mut player, &mut scene);
    // rust: assert!(!player.in_powder_snow);
    // rust: assert_eq!(player.ticks_frozen, 8);
}

pub fn walking_through_powder_snow_asks_for_a_snowflake() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
    // rust: let snow = assets
    // rust: .registry
    // rust: .default_state("minecraft:powder_snow")
    // rust: .unwrap();
    // rust: scene.set(20, 4, 20, snow).unwrap();
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: let from = at.subtract(Vec3::new(0.2, 0.0, 0.0));
    // rust: let snowflakes = |player: &PlayerMotion| {
    // rust: player
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MotionEvent::Snowflake { .. }))
    // rust: .count()
}
    // rust: let mut player = PlayerMotion::new(&resources, at).unwrap();
    // rust: let mut found = 0;
    // rust: for seed in 0..64 {
    // rust: scene.random = horizon_core::random::LegacyRandom::new(seed);
    // rust: player.events.clear();
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .server_block_damage(from)
    // rust: .unwrap();
    // rust: found = snowflakes(&player);
    // rust: if found > 0 {
    // rust: break;
}
}
    // rust: assert!(
    // rust: found > 0,
    // rust: "a server's player walking through powder snow must send a snowflake"
    // rust: );
    // rust: if let MotionEvent::Snowflake { position, velocity } = &player
    // rust: .events
    // rust: .iter()
    // rust: .find(|e| matches!(e, MotionEvent::Snowflake { .. }))
    // rust: .unwrap()
    // rust: {
    // rust: assert_eq!(position.y, 5.0);
    // rust: assert_eq!(velocity.y, f64::from(0.05_f32));
}
    // rust: player.events.clear();
    // rust: scene.random = horizon_core::random::LegacyRandom::new(1);
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .server_block_damage(at)
    // rust: .unwrap();
    // rust: assert_eq!(snowflakes(&player), 0);
    // rust: player.client_side = true;
    // rust: player.events.clear();
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(Default::default())
    // rust: .unwrap();
    // rust: assert_eq!(snowflakes(&player), 0);
}

pub fn server_travel_moves_only_the_velocity() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
    // rust: let at = Vec3::new(20.5, 4.0, 20.5);
    // rust: let mut player = PlayerMotion::new(&resources, at).unwrap();
    // rust: let mut travel = |player: &mut PlayerMotion| {
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .server_travel()
    // rust: .unwrap()
}
        // A knockback on the ground (vanilla's server sends 0.21840 0.27516
        // after a zombie's hit): ground friction, then gravity and drag.
    // rust: player.ground.on_ground = true;
    // rust: player.velocity = Vec3::new(-0.4, 0.3608, 0.0);
    // rust: travel(&mut player);
    // rust: assert!(
    // rust: (player.velocity.x + 0.2184).abs() < 1e-6,
    // rust: "{:?}",
    // rust: player.velocity
    // rust: );
    // rust: assert!(
    // rust: (player.velocity.y - 0.275184).abs() < 1e-6,
    // rust: "{:?}",
    // rust: player.velocity
    // rust: );
    // rust: assert_eq!(player.position, at);
    // rust: assert!(player.ground.on_ground);
        // Falling onto the ground hurts no one on the server's copy, and leaves
        // the fall to the client's moves.
    // rust: let health = player.health.health();
    // rust: player.position = Vec3::new(20.5, 4.5, 20.5);
    // rust: player.ground.on_ground = false;
    // rust: player.fall_distance = 10.0;
    // rust: player.velocity = Vec3::new(0.0, -1.0, 0.0);
    // rust: travel(&mut player);
    // rust: assert_eq!(player.velocity.y, -0.0784000015258789);
    // rust: assert_eq!(player.health.health(), health);
    // rust: assert_eq!(player.fall_distance, 10.0);
    // rust: assert!(player.events.is_empty());
}

    /// `LivingEntity.handleFallFlyingCollisions`: a glide that meets a wall loses
    /// the horizontal speed it had, and the server's copy hurts by that loss,
    /// `(moveHorLength - newMoveHorLength) * 10 - 3`, as `minecraft:fly_into_wall`.
    /// The speed it starts the tick with is the client's own movement
    /// (`handleMovePlayer` gives the server copy its delta movement), so the
    /// loss is the speed the glide actually flew at.
pub fn a_glide_into_a_wall_hurts_by_the_speed_it_lost() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
        // A wall in the way of a glide along +x, at feet height.
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: for y in 4..=5 {
    // rust: for z in 19..=21 {
    // rust: scene.set(23, y, z, stone).unwrap();
}
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(22.0, 4.0, 20.5)).unwrap();
    // rust: player.fall_flying = true;
        // Looking along +x (the `getLookAngle` of a flat -90 yaw) keeps the
        // glide on its course through `updateFallFlyingMovement`'s pull.
    // rust: player.yaw = -90.0;
    // rust: player.pitch = 0.0;
    // rust: player.carry_client_movement(Vec3::new(1.2, 0.0, 0.0));
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .server_travel()
    // rust: .unwrap();
    // rust: assert!(
    // rust: player
    // rust: .hurt_log
    // rust: .last()
    // rust: .is_some_and(|hurt| hurt.source == "minecraft:fly_into_wall"),
    // rust: "{:?}",
    // rust: player.hurt_log
    // rust: );
    // rust: assert!(player.health.health() < 20.0, "{}", player.health.health());
}

    /// A client's own glide into a wall plays its fall sound but never hurts
    /// it (`handleFallFlyingCollisions`' playSound runs on both sides, the
    /// hurt is the server's alone), so the glider hears it.
pub fn a_clients_own_glide_into_a_wall_plays_the_fall_sound_and_does_not_hurt_it() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 1).unwrap();
        // A wall in the way of a glide along +x, at feet height.
    // rust: let stone = assets.registry.default_state("minecraft:stone").unwrap();
    // rust: for y in 4..=5 {
    // rust: for z in 19..=21 {
    // rust: scene.set(23, y, z, stone).unwrap();
}
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(22.0, 4.0, 20.5)).unwrap();
    // rust: player.client_side = true;
    // rust: player.fall_flying = true;
        // Looking along +x keeps the glide on its course into the wall.
    // rust: player.yaw = -90.0;
    // rust: player.pitch = 0.0;
    // rust: player.carry_client_movement(Vec3::new(1.2, 0.0, 0.0));
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.travel_fall_flying().unwrap();
    // rust: assert!(
    // rust: w.player.events.iter().any(|e| matches!(
    // rust: e,
    // rust: MotionEvent::Fall(crate::landing::FallEvent::Sound {
    // rust: sound: crate::landing::SceneSound::SmallFall,
    // rust: ..
    // rust: })
    // rust: )),
    // rust: "{:?}",
    // rust: w.player.events
    // rust: );
    // rust: assert!(
    // rust: !w.player
    // rust: .hurt_log
    // rust: .last()
    // rust: .is_some_and(|hurt| hurt.source == "minecraft:fly_into_wall"),
    // rust: "a client's own glide does not hurt it: {:?}",
    // rust: w.player.hurt_log
    // rust: );
    // rust: assert_eq!(w.player.health.health(), 20.0);
}

pub fn spectator_scroll_speed_controls_horizontal_and_vertical_flight() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let run = |steps| {
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let start = Vec3::new(20.5, 12.0, 20.5);
    // rust: let mut player = PlayerMotion::new(&resources, start).unwrap();
    // rust: player.spectator = true;
    // rust: player.flying_speed = crate::mouse::spectator_flying_speed(player.flying_speed, steps);
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(crate::sprint::Keys {
    // rust: forward: true,
    // rust: jump: true,
    // rust: ..Default::default()
    // rust: })
    // rust: .unwrap();
    // rust: player.position.subtract(start)
}
    // rust: let stopped = run(-100);
    // rust: assert_eq!(stopped, Vec3::ZERO);
    // rust: let normal = run(0);
    // rust: let fast = run(10);
    // rust: assert!(normal.y > 0.0 && normal.z > 0.0);
    // rust: assert!((fast.y - normal.y * 2.0).abs() < 1e-6);
    // rust: assert!((fast.z - normal.z * 2.0).abs() < 1e-6);
}

pub fn resident_spectator_flight_ignores_solid_and_climbable_blocks() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let run = |name: &str, spectator: bool| {
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let state = assets.registry.default_state(name).unwrap();
    // rust: for x in 19..=23 {
    // rust: for y in 10..=17 {
    // rust: for z in 19..=23 {
    // rust: scene.set(x, y, z, state).unwrap();
}
}
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 12.0, 20.5)).unwrap();
    // rust: player.spectator = spectator;
    // rust: player.flying = spectator;
    // rust: player.velocity = Vec3::new(0.4, 0.1, 0.4);
    // rust: let keys = crate::sprint::Keys {
    // rust: forward: true,
    // rust: jump: true,
    // rust: ..Default::default()
}
    // rust: let mut trajectory = Vec::new();
    // rust: for _ in 0..4 {
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(keys)
    // rust: .unwrap();
    // rust: trajectory.push((player.position, player.velocity));
}
    // rust: trajectory
}
    // rust: let air = run("minecraft:air", true);
    // rust: for name in [
    // rust: "minecraft:stone",
    // rust: "minecraft:ladder",
    // rust: "minecraft:vine",
    // rust: "minecraft:scaffolding",
    // rust: ] {
    // rust: assert_eq!(run(name, true), air, "spectator flight in {name}");
}
    // rust: let air = run("minecraft:air", false);
    // rust: let ladder = run("minecraft:ladder", false);
    // rust: assert!(air.last().unwrap().1.y < 0.0);
    // rust: assert!(ladder.last().unwrap().1.y > 0.0);
}

pub fn creative_and_spectator_preserve_hunger_when_switching_from_survival() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("skipped hunger regression: prepared resources unavailable");
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
        // Both abilities are set by creative/spectator mode changes for the
        // resident player and for LAN/dedicated guests.
    // rust: for spectator in [false, true] {
    // rust: for food in [0, 1, 20] {
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: player.health.food.food = food;
    // rust: player.health.food.saturation = 0.0;
    // rust: player.health.food.exhaustion = 0.0;
    // rust: player.health.food.timer = 79;
    // rust: player.invulnerable = true;
    // rust: player.spectator = spectator;
    // rust: for _ in 0..160 {
    // rust: player.cause_food_exhaustion(0.2);
    // rust: player
    // rust: .food_tick(&resources.health, Default::default())
    // rust: .unwrap();
}
    // rust: assert_eq!(player.health.food.food, food);
    // rust: assert_eq!(player.health.food.saturation, 0.0);
    // rust: assert_eq!(player.health.food.exhaustion, 0.0);
    // rust: assert_eq!(player.health.health(), 20.0);
    // rust: assert!(!player.health.dead_or_dying());
    // rust: assert!(player.events.is_empty());

                // Pending exhaustion from survival is still processed, but an
                // empty food bar cannot hurt the now-invulnerable player.
    // rust: player.health.food.exhaustion = 5.0;
    // rust: player.health.food.timer = 79;
    // rust: player
    // rust: .food_tick(&resources.health, Default::default())
    // rust: .unwrap();
    // rust: assert_eq!(player.health.food.food, (food - 1).max(0));
    // rust: assert_eq!(player.health.food.exhaustion, 1.0);
    // rust: assert_eq!(player.health.health(), 20.0);
    // rust: assert!(player.events.is_empty());

                // Returning to survival resumes exhaustion and starvation.
    // rust: player.health.food.food = food;
    // rust: player.health.food.exhaustion = 0.0;
    // rust: player.invulnerable = false;
    // rust: player.spectator = false;
    // rust: player.cause_food_exhaustion(0.2);
    // rust: assert_eq!(player.health.food.exhaustion, 0.2);
    // rust: player.health.food.exhaustion = 5.0;
    // rust: player.health.food.timer = 79;
    // rust: player
    // rust: .food_tick(&resources.health, Default::default())
    // rust: .unwrap();
    // rust: assert_eq!(player.health.food.food, (food - 1).max(0));
    // rust: assert_eq!(player.health.health(), if food <= 1 { 19.0 } else { 20.0 });
}
}
}

pub fn player_fire_damage_queues_hurt_sound_only_for_fresh_hits() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("skipped damage regression: prepared resources unavailable");
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: for name in ["on_fire", "in_fire", "lava"] {
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let source = resources
    // rust: .health
    // rust: .damage
    // rust: .id(&format!("minecraft:{name}"))
    // rust: .unwrap();
    // rust: assert!(
    // rust: player
    // rust: .hurt(&resources.health, Default::default(), source, 1.0)
    // rust: .unwrap()
    // rust: );
    // rust: assert_eq!(
    // rust: player
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(
    // rust: e,
    // rust: MotionEvent::HurtSound("minecraft:entity.player.hurt_on_fire")
    // rust: ))
    // rust: .count(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(player.health.hurt_animation_time, 10);
    // rust: player.health.advance_clock();
    // rust: player.events.clear();
    // rust: assert!(
    // rust: !player
    // rust: .hurt(&resources.health, Default::default(), source, 1.0)
    // rust: .unwrap()
    // rust: );
    // rust: assert!(
    // rust: !player
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MotionEvent::HurtSound(_)))
    // rust: );
    // rust: assert_eq!(
    // rust: player.health.hurt_animation_time, 9,
    // rust: "cooldown hit must not restart animation"
    // rust: );
    // rust: for _ in 0..20 {
    // rust: player.health.advance_clock();
}
    // rust: assert_eq!(player.health.hurt_animation_time, 0);
    // rust: player.invulnerable = true;
    // rust: player.events.clear();
    // rust: assert!(
    // rust: !player
    // rust: .hurt(&resources.health, Default::default(), source, 1.0)
    // rust: .unwrap()
    // rust: );
    // rust: assert!(
    // rust: !player
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MotionEvent::HurtSound(_)))
    // rust: );
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let source = resources.health.damage.id("minecraft:mob_attack").unwrap();
    // rust: assert!(
    // rust: player
    // rust: .hurt_blocking(&resources.health, Default::default(), source, 2.0, None)
    // rust: .unwrap()
    // rust: .hurt
    // rust: );
    // rust: assert_eq!(
    // rust: player
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MotionEvent::HurtSound("minecraft:entity.player.hurt")))
    // rust: .count(),
    // rust: 1
    // rust: );
        // A fatal hit plays the death sound rather than a hurt sound (#4570).
    // rust: let mut dying = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: assert!(
    // rust: dying
    // rust: .hurt(&resources.health, Default::default(), source, 100.0)
    // rust: .unwrap()
    // rust: );
    // rust: assert!(dying.health.dead_or_dying());
    // rust: assert!(
    // rust: !dying
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MotionEvent::HurtSound(_)))
    // rust: );
        // A shield that takes the whole arrow: onBlocked's sound, no damage
        // event, so the player hears no hurt sound.
//         use horizon_world::blocking_rules::{BlockingRules, DamageReduction, ItemDamageFunction};
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let source = resources.health.damage.id("minecraft:arrow").unwrap();
    // rust: let shield = crate::health::Blocking {
    // rust: rules: BlockingRules {
    // rust: delay_seconds: 0.25,
    // rust: disable_scale: 1.0,
    // rust: reductions: vec![DamageReduction {
    // rust: horizontal_angle: 90.0,
    // rust: types: None,
    // rust: base: 0.0,
    // rust: factor: 1.0,
    // rust: }],
    // rust: item_damage: ItemDamageFunction {
    // rust: threshold: 3.0,
    // rust: base: 1.0,
    // rust: factor: 1.0,
    // rust: },
    // rust: },
    // rust: bypassed: false,
    // rust: pierce: false,
    // rust: angle: 0.0,
}
    // rust: let outcome = player
    // rust: .hurt_blocking(
    // rust: &resources.health,
    // rust: Default::default(),
    // rust: source,
    // rust: 4.0,
    // rust: Some(shield.clone()),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(!outcome.hurt && outcome.sound && outcome.blocked == 4.0);
    // rust: assert_eq!(
    // rust: player.health.hurt.hurt_time, 10,
    // rust: "preserve server damage bookkeeping"
    // rust: );
    // rust: assert_eq!(
    // rust: player.health.hurt_animation_time, 0,
    // rust: "a fully blocked arrow must not animate hurt"
    // rust: );
    // rust: assert!(
    // rust: !player
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MotionEvent::HurtSound(_)))
    // rust: );
        // An unblocked hit after the shield block must still animate normally.
    // rust: for _ in 0..20 {
    // rust: player.health.advance_clock();
}
    // rust: assert!(
    // rust: player
    // rust: .hurt(&resources.health, Default::default(), source, 4.0)
    // rust: .unwrap()
    // rust: );
    // rust: assert_eq!(player.health.hurt_animation_time, 10);
    // rust: player.health.advance_clock();
    // rust: assert!(
    // rust: !player
    // rust: .hurt_blocking(
    // rust: &resources.health,
    // rust: Default::default(),
    // rust: source,
    // rust: 4.0,
    // rust: Some(shield)
    // rust: )
    // rust: .unwrap()
    // rust: .hurt
    // rust: );
    // rust: assert_eq!(
    // rust: player.health.hurt_animation_time, 9,
    // rust: "blocking must not erase or restart an existing animation"
    // rust: );
    // rust: let mut starving = PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: starving.health.food.food = 0;
    // rust: starving.health.food.timer = 79;
    // rust: starving
    // rust: .food_tick(&resources.health, Default::default())
    // rust: .unwrap();
    // rust: assert_eq!(starving.health.health(), 19.0);
    // rust: assert_eq!(
    // rust: starving.health.hurt_animation_time, 10,
    // rust: "starvation must still animate hurt"
    // rust: );
}

pub fn a_glide_tick_matches_vanilla_to_the_bit() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
        // LivingEntity.updateFallFlyingMovement run on the 26.3 JVM from
        // (0.4, -0.3, 1.1): a climb (Mth.sin in the pull-up) and a dive.
    // rust: let cases = [
    // rust: (
    // rust: -25.3,
    // rust: 37.7,
    // rust: [
    // rust: 0x3fd2_0750_bb9c_308e,
    // rust: 0xbfce_177a_a476_8fa8,
    // rust: 0x3ff1_3a5d_8654_8dc8,
    // rust: ],
    // rust: ),
    // rust: (
    // rust: 12.9,
    // rust: -118.62,
    // rust: [
    // rust: 0x3fde_db16_996e_3d53,
    // rust: 0xbfd2_5548_1a43_d31f,
    // rust: 0x3fed_2aff_c5b0_6151,
    // rust: ],
    // rust: ),
    // rust: ];
    // rust: for (pitch, yaw, want) in cases {
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 40.0, 20.5)).unwrap();
    // rust: player.glider = true;
    // rust: player.fall_flying = true;
    // rust: player.pitch = pitch;
    // rust: player.yaw = yaw;
    // rust: player.velocity = Vec3::new(0.4, -0.3, 1.1);
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.travel_fall_flying().unwrap();
    // rust: let v = w.player.velocity;
    // rust: assert_eq!(
    // rust: [v.x.to_bits(), v.y.to_bits(), v.z.to_bits()],
    // rust: want,
    // rust: "{pitch} {yaw}: {v:?}"
    // rust: );
}
}

pub fn a_glide_that_is_not_diving_keeps_the_fall_distance_at_one() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
        // Entity.checkFallDistanceAccumulation: capped above -0.5 a tick, not below.
    // rust: for (dy, capped) in [(-0.3, true), (-0.49, true), (-0.8, false)] {
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 20.0, 20.5)).unwrap();
    // rust: player.glider = true;
    // rust: player.fall_flying = true;
    // rust: player.velocity = Vec3::new(0.0, dy, 0.6);
    // rust: player.fall_distance = 30.0;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.player_movement_tick([0.0, 0.0], false).unwrap();
    // rust: assert!(w.player.fall_flying);
    // rust: if capped {
    // rust: assert!(
    // rust: w.player.fall_distance < 2.0,
    // rust: "{dy}: {}",
    // rust: w.player.fall_distance
    // rust: );
    // rust: } else {
    // rust: assert!(
    // rust: w.player.fall_distance > 30.0,
    // rust: "{dy}: {}",
    // rust: w.player.fall_distance
    // rust: );
}
}
}
    /// Footsteps on the prepared vanilla resources, when they are present:
    /// none while standing (gravity still moves the player every tick), one
    /// per `nextStep` metre while walking.
pub fn resident_water_landing_cancels_a_preset_fall() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: for wet in [false, true] {
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: if wet {
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: for x in 19..=21 {
    // rust: for z in 19..=21 {
    // rust: scene.set(x, 3, z, water).unwrap();
}
}
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 20.0, 20.5)).unwrap();
    // rust: player.fall_distance = 30.0;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.move_self(Vec3::new(0.0, -30.0, 0.0)).unwrap();
    // rust: assert!(w.player.ground.on_ground);
    // rust: assert_eq!(w.player.fluids.was_touching_water, wet);
    // rust: if wet {
    // rust: assert_eq!(w.player.health.health(), 20.0);
    // rust: assert_eq!(w.player.fall_distance, 0.0);
    // rust: } else {
    // rust: assert!(w.player.health.health() < 20.0);
}
}
}
    /// `Player.doWaterSplashEffect`: a spectator entering water makes no splash
    /// sound, particles or game event; everyone else does.
pub fn a_spectator_entering_water_makes_no_splash() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: for spectator in [false, true] {
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 20.0, 20.5)).unwrap();
    // rust: player.spectator = spectator;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: horizon_world::entity_fluid_tick::EntityFluidTickWorld::water_splash(&mut w).unwrap();
    // rust: assert_eq!(w.player.events.is_empty(), spectator);
}
}
    /// A client's own fall (multiplayer, a LAN guest, single player on its
    /// server thread) plays its landing but never hurts it: only the server
    /// does (`Entity.hurt` on a client), so a server that cancels fall damage
    /// leaves the screen still.
pub fn a_clients_own_fall_does_not_hurt_it() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: for client_side in [false, true] {
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 20.0, 20.5)).unwrap();
    // rust: player.client_side = client_side;
    // rust: player.fall_distance = 30.0;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.move_self(Vec3::new(0.0, -30.0, 0.0)).unwrap();
    // rust: assert!(w.player.ground.on_ground);
    // rust: assert_eq!(w.player.fall_distance, 0.0);
            // LivingEntity.causeFallDamage's sounds play on both sides.
    // rust: assert!(w.player.events.iter().any(|e| matches!(
    // rust: e,
    // rust: MotionEvent::Fall(crate::landing::FallEvent::Sound {
    // rust: sound: crate::landing::SceneSound::BigFall,
    // rust: ..
    // rust: })
    // rust: )));
    // rust: let hurt = w.player.health.health() < 20.0;
    // rust: assert_eq!(hurt, !client_side);
    // rust: assert_eq!(w.player.health.hurt_animation_time > 0, !client_side);
            // The server's health then starts the client's hurt animation.
    // rust: if client_side {
    // rust: w.player.health.flash_health_change(20.0);
    // rust: assert_eq!(w.player.health.hurt_animation_time, 0);
    // rust: assert_eq!(w.player.health.hurt.cooldown, 0);
    // rust: w.player.health.flash_health_change(12.0);
    // rust: assert_eq!(w.player.health.hurt_animation_time, 10);
                // LocalPlayer.hurtTo's damageCooldownTime: the HUD's hearts blink.
    // rust: assert_eq!(w.player.health.hurt.cooldown, 20);
    // rust: w.player.health.flash_health_change(25.0);
    // rust: assert_eq!(w.player.health.hurt.cooldown, 10);
}
}
}
pub fn slow_falling_clears_the_fall_distance_so_landing_does_not_hurt() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: for slow_falling in [false, true] {
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 9.0, 20.5)).unwrap();
    // rust: player.fall_distance = 30.0;
    // rust: player.status.slow_falling = slow_falling;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: for _ in 0..200 {
    // rust: if w.player.ground.on_ground {
    // rust: break;
}
    // rust: w.player_movement_tick([0.0, 0.0], false).unwrap();
}
    // rust: assert!(w.player.ground.on_ground);
    // rust: if slow_falling {
    // rust: assert_eq!(w.player.health.health(), 20.0);
    // rust: assert_eq!(w.player.fall_distance, 0.0);
    // rust: } else {
    // rust: assert!(w.player.health.health() < 20.0);
}
}
}
pub fn a_server_copy_of_a_riptide_spin_counts_down_and_stands_again() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 10.0, 20.5)).unwrap();
    // rust: player.auto_spin_attack_ticks = 2;
    // rust: player.auto_spin_attack_dmg = 8.0;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.update_player_pose().unwrap();
    // rust: assert_eq!(w.player.pose, crate::pose::Pose::SpinAttack);
    // rust: w.player.count_down_server_spin();
    // rust: w.update_player_pose().unwrap();
    // rust: assert_eq!(w.player.pose, crate::pose::Pose::SpinAttack);
    // rust: assert_eq!(w.player.auto_spin_attack_dmg, 8.0);
    // rust: w.player.count_down_server_spin();
    // rust: assert_eq!(w.player.auto_spin_attack_ticks, 0);
    // rust: assert_eq!(w.player.auto_spin_attack_dmg, 0.0);
    // rust: w.update_player_pose().unwrap();
    // rust: assert_eq!(w.player.pose, crate::pose::Pose::Standing);
    // rust: assert_eq!(w.player.dimensions.eye_height, 1.62);
        // Nothing to count once the spin is over.
    // rust: w.player.count_down_server_spin();
    // rust: assert_eq!(w.player.auto_spin_attack_ticks, 0);
}
    /// #3684: `/attribute @s minecraft:scale base set 0.1` on the server's
    /// copy of a player. `LivingEntity.tick`'s `refreshDirtyAttributes` runs
    /// `onAttributeUpdated(SCALE)`, which calls `refreshDimensions`: the next
    /// tick the server checks the player's moves with a 0.06 × 0.18 box, not
    /// the 0.6 × 1.8 one that sent a small player back from every wall.
pub fn a_server_copy_takes_its_new_scale_box_the_next_tick() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 10.0, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.server_player_pose_tick().unwrap();
    // rust: assert_eq!(w.player.dimensions.width, 0.6);
    // rust: assert_eq!(w.player.dimensions.height, 1.8);
        // AttributeCommand's base set, as the server runs it.
    // rust: let key = w.player.attributes.key("minecraft:scale").unwrap();
    // rust: let handle = w
    // rust: .player
    // rust: .attributes
    // rust: .get_instance(Some(key))
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: w.player
    // rust: .attributes
    // rust: .edit(&handle, |value, observer| {
    // rust: value.set_base_value(0.1, observer)
    // rust: })
    // rust: .unwrap();
    // rust: w.server_player_pose_tick().unwrap();
    // rust: assert_eq!(w.player.pose, crate::pose::Pose::Standing);
    // rust: assert_eq!(w.player.dimensions.width, 0.6 * 0.1);
    // rust: assert_eq!(w.player.dimensions.height, 1.8 * 0.1);
    // rust: assert_eq!(w.player.dimensions.eye_height, 1.62 * 0.1);
}
    /// #3308: a swimmer who boards a boat stops swimming
    /// (`Entity.updateSwimming` needs `!isPassenger()`) and `updatePlayerPose`
    /// sits them up, eye at 1.62 instead of the swim's 0.4.
pub fn a_passenger_stops_swimming_and_stands() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 10.0, 20.5)).unwrap();
    // rust: player.sprinting = true;
    // rust: player.swimming = true;
    // rust: player.set_pose(crate::pose::Pose::Swimming).unwrap();
    // rust: assert_eq!(player.dimensions.eye_height, 0.4);
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.passenger_pose_tick().unwrap();
    // rust: assert!(!w.player.swimming);
    // rust: assert_eq!(w.player.pose, crate::pose::Pose::Standing);
    // rust: assert_eq!(w.player.dimensions.eye_height, 1.62);
}
    /// #4509: a cushion seat clips the feet into the floor, so `can_fit_pose`
    /// rejects standing and would leave a swim pose; sit up anyway.
pub fn a_swimming_passenger_sits_up_even_when_standing_does_not_fit() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
        // Feet inside the floor block, as on a cushion seat (y - 0.35): away
        // from the pyramid the scene's floor tops out at y = 4.
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 3.65, 20.5)).unwrap();
    // rust: player.swimming = true;
    // rust: player.set_pose(crate::pose::Pose::Swimming).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: assert!(!w.can_fit_pose(crate::pose::Pose::Standing).unwrap());
    // rust: w.passenger_pose_tick().unwrap();
    // rust: assert!(!w.player.swimming);
    // rust: assert_eq!(w.player.pose, crate::pose::Pose::Standing);
}
    /// The movement prediction plays a tick again on a copy: what the copy
    /// does (sprinting edits the speed attribute) stays in the copy.
pub fn a_copied_player_moves_on_its_own() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 10.0, 20.5)).unwrap();
    // rust: let walking = player.attribute("minecraft:movement_speed").unwrap();
    // rust: let mut copy = player.clone();
    // rust: copy.set_sprinting(true).unwrap();
    // rust: copy.velocity = Vec3::new(0.2, 0.0, 0.0);
    // rust: let sprinting = copy.attribute("minecraft:movement_speed").unwrap();
    // rust: assert!(
    // rust: (sprinting - walking * 1.3).abs() < 1e-6,
    // rust: "{walking} {sprinting}"
    // rust: );
    // rust: assert_eq!(
    // rust: player.attribute("minecraft:movement_speed").unwrap(),
    // rust: walking
    // rust: );
    // rust: assert!(!player.sprinting);
    // rust: assert_eq!(player.velocity, Vec3::ZERO);
        // The copy's attributes keep working after the original changes too.
    // rust: player.set_sprinting(true).unwrap();
    // rust: copy.set_sprinting(false).unwrap();
    // rust: assert_eq!(copy.attribute("minecraft:movement_speed").unwrap(), walking);
}
    /// #4427: `!isPassenger()` where the swim flag is made, not only where the
    /// pose is chosen. The server's copy of a guest who boards a boat while
    /// swimming kept `SWIMMING` through `Entity.baseTick`, so it sat in the seat
    /// in the 0.6 box with its eye 0.4 above it, at the waterline, where the
    /// boat drowned and suffocated a player whose own screen showed them
    /// sitting up. Getting out starts the swim again, so it cannot stick off.
pub fn a_riding_guest_keeps_no_swim_in_the_fluid_phase() void {
}
        // The boxes the flag picks, before the prepared resources below: the
        // swim's eye is the one at the waterline. Nothing here needs assets.
    // rust: assert_eq!(crate::pose::Pose::Swimming.dimensions(1.0).eye_height, 0.4);
    // rust: assert_eq!(crate::pose::Pose::Standing.dimensions(1.0).eye_height, 1.62);
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: for y in 4..=6 {
    // rust: scene.set(20, y, 20, water).unwrap();
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
        // `fluid_base_tick` samples `was_eye_in_water` before it updates the
        // fluids (`motion/fluids.rs:222`), so a fresh body needs one tick
        // before `is_under_water` can answer: the first call records the eye,
        // the second acts on it. Without that warm-up this test panicked as
        // soon as `.local/` existed, so it never ran for the author or CI.
    // rust: w.player.sprinting = true;
    // rust: w.fluid_base_tick().unwrap();
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(w.player.is_under_water());
    // rust: assert!(w.player.swimming);
        // In the boat: `Entity.updateSwimming` keeps no swim for a passenger.
        // This is the assertion that fails on main, where the term is missing.
    // rust: w.player.is_passenger = true;
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(!w.player.swimming);
        // Out of the boat the swim starts again.
    // rust: w.player.is_passenger = false;
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(w.player.swimming);
}
pub fn a_riptide_spin_lies_flat_and_ends_on_the_first_entity_it_touches() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let ahead = Aabb::new(Vec3::new(20.2, 9.0, 21.5), Vec3::new(20.8, 11.0, 22.1));
    // rust: for target in [None, Some(ahead)] {
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 10.0, 20.5)).unwrap();
    // rust: player.auto_spin_attack_ticks = 20;
    // rust: player.auto_spin_attack_dmg = 8.0;
    // rust: player.velocity = Vec3::new(0.0, 0.0, 1.0);
    // rust: player.spin_targets = target.map(|b| (7, b)).into_iter().collect();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.simulation_tick([0.0, 0.0], false).unwrap();
    // rust: if target.is_some() {
                // Touched: the hit, no more spin, bounced back at a fifth.
    // rust: assert_eq!(w.player.spin_hit, Some(7));
    // rust: assert_eq!(w.player.auto_spin_attack_ticks, 0);
    // rust: assert!(w.player.velocity.z < 0.0, "{:?}", w.player.velocity);
    // rust: assert_eq!(w.player.pose, crate::pose::Pose::Standing);
    // rust: } else {
    // rust: assert_eq!(w.player.spin_hit, None);
    // rust: assert_eq!(w.player.auto_spin_attack_ticks, 19);
    // rust: assert_eq!(w.player.pose, crate::pose::Pose::SpinAttack);
    // rust: assert_eq!(w.player.dimensions.height, 0.6);
}
}
}
pub fn a_landing_glide_lasts_a_tick_so_a_jump_keeps_its_speed() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.2, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.move_self(Vec3::new(0.0, -1.0, 0.0)).unwrap();
    // rust: assert!(w.player.ground.on_ground);
    // rust: w.player.set_sprinting(true).unwrap();
    // rust: w.player.glider = true;
    // rust: w.player.fall_flying = true;
    // rust: w.player.velocity = Vec3::new(0.0, 0.0, 1.5);
        // The landed glide's extra tick: the jump's sprint boost, no ground friction.
    // rust: w.player_movement_tick([0.0, 1.0], true).unwrap();
    // rust: assert!(w.player.fall_flying);
    // rust: assert!(w.player.velocity.y > 0.3, "jumped: {:?}", w.player.velocity);
    // rust: assert!(
    // rust: w.player.velocity.z > 1.5,
    // rust: "kept its speed: {:?}",
    // rust: w.player.velocity
    // rust: );
        // Then the predicted clear (an integrated server has no SetEntityData
        // round trip: the client plays it a tick later).
    // rust: w.player_movement_tick([0.0, 1.0], true).unwrap();
    // rust: assert!(!w.player.fall_flying);
}

    /// #7616: on someone else's server the glide flag is `DATA_SHARED_FLAGS_ID`'s.
    /// `LivingEntity.updateFallFlying` clears it on the server only and
    /// `LocalPlayer` never ends a glide itself, so a client that predicts the
    /// clear clears it before the server's `SetEntityData` and the movement of
    /// the tick after the landing is air travel where vanilla still glides.
pub fn a_server_client_glides_until_the_servers_flag_clears() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.2, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.move_self(Vec3::new(0.0, -1.0, 0.0)).unwrap();
    // rust: assert!(w.player.ground.on_ground);
    // rust: w.player.set_sprinting(true).unwrap();
    // rust: w.player.glider = true;
    // rust: w.player.fall_flying = true;
    // rust: w.player.server_owns_glide = true;
    // rust: w.player.velocity = Vec3::new(0.0, 0.0, 1.5);
        // The landing tick's jump, gliding: vy = (0.42 - 0.08 * 0.25) * 0.98.
    // rust: w.player_movement_tick([0.0, 1.0], true).unwrap();
    // rust: assert!(w.player.fall_flying);
    // rust: assert!(
    // rust: (w.player.velocity.y - 0.392).abs() < 1e-6,
    // rust: "jump: {:?}",
    // rust: w.player.velocity
    // rust: );
        // The tick after it: the local `canGlide` failed on the landing tick,
        // but no `SetEntityData` has arrived, so the glide goes on — vanilla's
        // `LocalPlayer` glides here too. Its travel is the glide's
        // (0.392 - 0.02) * 0.98, not the air's (0.392 - 0.08) * 0.98.
    // rust: w.player_movement_tick([0.0, 1.0], true).unwrap();
    // rust: assert!(w.player.fall_flying, "only the server's flag ends a glide");
    // rust: assert!(
    // rust: (w.player.velocity.y - 0.36456).abs() < 1e-5,
    // rust: "glide travel: {:?}",
    // rust: w.player.velocity
    // rust: );
        // The server's cleared flag (0x80 gone), handled between ticks.
    // rust: w.player.fall_flying = false;
    // rust: w.player_movement_tick([0.0, 1.0], true).unwrap();
    // rust: assert!(!w.player.fall_flying);
    // rust: assert!(
    // rust: (w.player.velocity.y - 0.2788688).abs() < 1e-5,
    // rust: "air travel: {:?}",
    // rust: w.player.velocity
    // rust: );
}

pub fn resident_water_and_lava_are_not_treated_as_air() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("skipping resident water/lava test: prepared resources unavailable");
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: for x in 19..=21 {
    // rust: for y in 3..=7 {
    // rust: for z in 19..=21 {
    // rust: scene.set(x, y, z, water).unwrap();
}
}
}
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.controlled_simulation_tick(Default::default()).unwrap();
    // rust: assert!(
    // rust: MovementStatisticsWorld::in_water(&mut w).unwrap(),
    // rust: "resident water must reach the player movement adapter"
    // rust: );
    // rust: assert!(MovementStatisticsWorld::eyes_in_water(&mut w).unwrap());
    // rust: assert!(
    // rust: !w.player.fluids.was_eye_in_water,
    // rust: "the first controlled tick must run only one fluid base phase"
    // rust: );
    // rust: assert!(
    // rust: (w.player.velocity.y + 0.005).abs() < 1e-5,
    // rust: "water drag/gravity must replace air travel: {:?}",
    // rust: w.player.velocity
    // rust: );
    // rust: let lava = assets.registry.default_state("minecraft:lava").unwrap();
    // rust: for x in 19..=21 {
    // rust: for y in 3..=7 {
    // rust: for z in 19..=21 {
    // rust: w.scene.set(x, y, z, lava).unwrap();
}
}
}
    // rust: w.controlled_simulation_tick(Default::default()).unwrap();
    // rust: assert!(
    // rust: w.player.health.health() < 20.0,
    // rust: "lava must damage a survival player"
    // rust: );
        // Water extinguishes, swimming is a real pose, and deep water consumes air.
    // rust: for x in 19..=21 {
    // rust: for y in 3..=7 {
    // rust: for z in 19..=21 {
    // rust: w.scene.set(x, y, z, water).unwrap();
}
}
}
    // rust: w.player.fire_ticks = 160;
    // rust: w.controlled_simulation_tick(Default::default()).unwrap();
    // rust: assert!(w.player.fire_ticks <= 0);
    // rust: w.player.air = -19;
    // rust: w.player.health.hurt.cooldown = 0;
    // rust: let hp = w.player.health.health();
    // rust: w.controlled_simulation_tick(Default::default()).unwrap();
    // rust: assert_eq!(w.player.air, 0);
    // rust: assert!(w.player.health.health() < hp, "drowning must hurt");
    // rust: w.player.invulnerable = true;
    // rust: let hp = w.player.health.health();
    // rust: w.player.air = -19;
    // rust: w.controlled_simulation_tick(Default::default()).unwrap();
    // rust: assert_eq!(w.player.health.health(), hp);
    // rust: w.player.invulnerable = false;
    // rust: w.player.air = 300;
    // rust: w.controlled_simulation_tick(crate::sprint::Keys {
    // rust: forward: true,
    // rust: sprint: true,
    // rust: ..Default::default()
    // rust: })
    // rust: .unwrap();
    // rust: assert!(w.player.sprinting);
    // rust: assert!(
    // rust: !w.player.swimming,
    // rust: "sprint input follows the swimming phase"
    // rust: );
    // rust: w.controlled_simulation_tick(crate::sprint::Keys {
    // rust: forward: true,
    // rust: sprint: true,
    // rust: ..Default::default()
    // rust: })
    // rust: .unwrap();
    // rust: assert!(w.player.swimming);
    // rust: assert_eq!(w.player.pose, crate::pose::Pose::Swimming);
        // Direct fire contact ignites; resistance prevents damage but does not hide flames.
    // rust: let fire = assets.registry.default_state("minecraft:fire").unwrap();
    // rust: for x in 19..=21 {
    // rust: for y in 3..=7 {
    // rust: for z in 19..=21 {
    // rust: w.scene.set(x, y, z, fire).unwrap();
}
}
}
    // rust: w.player.position = Vec3::new(20.5, 4.0, 20.5);
    // rust: w.player.velocity = Vec3::ZERO;
    // rust: w.player.fire_ticks = -20;
    // rust: w.player.health.hurt.cooldown = 0;
    // rust: w.player.ticks_frozen = 140;
    // rust: let hp = w.player.health.health();
    // rust: w.controlled_simulation_tick(Default::default()).unwrap();
    // rust: assert!(
    // rust: w.player.fire_ticks < 0,
    // rust: "direct fire hurts during the immunity delay"
    // rust: );
    // rust: assert_eq!(
    // rust: w.player.ticks_frozen, 0,
    // rust: "fire contact clears freeze during the delay"
    // rust: );
    // rust: assert!(w.player.health.health() < hp);
    // rust: w.player.status.fire_resistance = true;
    // rust: w.player.health.hurt.cooldown = 0;
    // rust: let hp = w.player.health.health();
    // rust: w.controlled_simulation_tick(Default::default()).unwrap();
    // rust: assert_eq!(w.player.health.health(), hp);
    // rust: w.player.invulnerable = true;
    // rust: w.player.fire_ticks = -20;
    // rust: w.player.ticks_frozen = 140;
    // rust: w.controlled_simulation_tick(Default::default()).unwrap();
    // rust: assert_eq!(w.player.ticks_frozen, 0);
    // rust: assert_eq!(
    // rust: w.player.fire_ticks, -19,
    // rust: "creative preserves the fire-contact delay"
    // rust: );
    // rust: for _ in 0..18 {
    // rust: w.apply_fire_contact().unwrap();
}
    // rust: assert_eq!(w.player.fire_ticks, -1);
    // rust: w.apply_fire_contact().unwrap();
    // rust: assert_eq!(
    // rust: w.player.fire_ticks, 1,
    // rust: "creative clamps only after ignition"
    // rust: );
    // rust: w.player.ticks_frozen = 140;
    // rust: w.player.ignite_for_ticks(160).unwrap();
    // rust: assert_eq!(w.player.ticks_frozen, 0);
    // rust: assert_eq!(w.player.fire_ticks, 1);
    // rust: w.player.invulnerable = false;
        // Sprint swimming must keep full input, not the dry crawl/sneak multiplier.
    // rust: for x in 19..=21 {
    // rust: for y in 2..=7 {
    // rust: for z in 19..=30 {
    // rust: w.scene.set(x, y, z, water).unwrap();
}
}
}
    // rust: w.player.position = Vec3::new(20.5, 4.0, 20.5);
    // rust: w.player.velocity = Vec3::ZERO;
    // rust: w.player.local_crouching = false;
    // rust: w.player.swimming = true;
    // rust: w.player.sprinting = true;
    // rust: w.player.set_pose(crate::pose::Pose::Swimming).unwrap();
    // rust: for _ in 0..30 {
    // rust: w.controlled_simulation_tick(crate::sprint::Keys {
    // rust: forward: true,
    // rust: sprint: true,
    // rust: ..Default::default()
    // rust: })
    // rust: .unwrap();
}
    // rust: assert!(
    // rust: w.player.velocity.z > 0.165,
    // rust: "native sprint swim speed must not receive crawl slowdown: {:?}",
    // rust: w.player.velocity
    // rust: );
    // rust: assert!(!w.player.moving_slowly());
    // rust: w.player.position = Vec3::new(20.5, 4.0, 20.5);
    // rust: w.player.velocity = Vec3::ZERO;
    // rust: w.player.pitch = 45.0;
    // rust: w.controlled_simulation_tick(crate::sprint::Keys {
    // rust: forward: true,
    // rust: sprint: true,
    // rust: ..Default::default()
    // rust: })
    // rust: .unwrap();
    // rust: assert!(
    // rust: w.player.velocity.y < -0.04,
    // rust: "look down must steer a swimming player downward"
    // rust: );
    // rust: w.player.position = Vec3::new(20.5, 4.0, 20.5);
    // rust: w.player.velocity = Vec3::ZERO;
    // rust: w.player.pitch = -45.0;
    // rust: w.controlled_simulation_tick(crate::sprint::Keys {
    // rust: forward: true,
    // rust: sprint: true,
    // rust: ..Default::default()
    // rust: })
    // rust: .unwrap();
    // rust: assert!(
    // rust: w.player.velocity.y > 0.02,
    // rust: "look up must steer a submerged swimmer upward"
    // rust: );
    // rust: let extra = horizon_world::nbt::Tag::compound([
    // rust: ("Fire", horizon_world::nbt::Tag::Short(160)),
    // rust: ("Air", horizon_world::nbt::Tag::Short(8)),
    // rust: ]);
    // rust: let mut level = crate::save::Level {
    // rust: health: 13.0,
    // rust: food: 11,
    // rust: saturation: 2.25,
    // rust: player_extra: Some(extra),
    // rust: flying: true,
    // rust: ..Default::default()
}
    // rust: let mut pending = true;
    // rust: w.player
    // rust: .load_saved_state_once(&mut pending, &level)
    // rust: .unwrap();
    // rust: assert_eq!((w.player.fire_ticks, w.player.air), (160, 8));
    // rust: assert!(w.player.flying);
    // rust: assert_eq!(
    // rust: (
    // rust: w.player.health.health(),
    // rust: w.player.health.food.food,
    // rust: w.player.health.food.saturation
    // rust: ),
    // rust: (13.0, 11, 2.25)
    // rust: );
    // rust: let mut respawn = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: respawn.load_saved_state_once(&mut pending, &level).unwrap();
    // rust: assert_eq!((respawn.fire_ticks, respawn.air), (-20, 300));
    // rust: assert!(!respawn.flying);
    // rust: assert_eq!(
    // rust: (respawn.health.health(), respawn.health.food.food),
    // rust: (20.0, 20)
    // rust: );
        // Reopening another world restores its state, including a saved death.
    // rust: pending = true;
    // rust: level.health = 0.0;
    // rust: w.player
    // rust: .load_saved_state_once(&mut pending, &level)
    // rust: .unwrap();
    // rust: assert!(w.player.health.dead_or_dying());
    // rust: assert!(!pending);
    // rust: w.player.fluids.was_touching_water = false;
    // rust: assert!(
    // rust: w.player.moving_slowly(),
    // rust: "dry crawling must still slow input"
    // rust: );
}

pub fn resident_swimming_uses_previous_eyes_and_requires_water_at_the_feet() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: for y in 4..=6 {
    // rust: scene.set(20, y, 20, water).unwrap();
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.player.local_crouching = true;
    // rust: let sprint = crate::sprint::Keys {
    // rust: forward: true,
    // rust: sprint: true,
    // rust: ..Default::default()
}
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(w.player.is_eye_in_fluid(WATER));
    // rust: assert!(!w.player.is_under_water());
    // rust: w.player.sprint_input_tick(sprint).unwrap();
    // rust: assert!(
    // rust: !w.player.sprinting,
    // rust: "new eye immersion cannot bypass crouching"
    // rust: );
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(w.player.is_under_water());
    // rust: w.player.sprint_input_tick(sprint).unwrap();
    // rust: assert!(w.player.sprinting);
    // rust: assert!(!w.player.swimming, "sprint starts after the base tick");
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(w.player.swimming);
    // rust: let air = assets.registry.default_state("minecraft:air").unwrap();
    // rust: w.scene.set(20, 4, 20, air).unwrap();
    // rust: w.player.swimming = false;
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(w.player.is_under_water());
    // rust: assert!(
    // rust: !w.player.swimming,
    // rust: "starting a swim requires water in the feet cell"
    // rust: );
    // rust: w.player.swimming = true;
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(
    // rust: w.player.swimming,
    // rust: "an existing swim only requires touching water"
    // rust: );
    // rust: w.player.flying = true;
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(!w.player.swimming);
    // rust: w.player.flying = false;
    // rust: w.player.spectator = true;
    // rust: w.scene.set(20, 4, 20, water).unwrap();
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(
    // rust: w.player.swimming,
    // rust: "spectator flight is applied later in aiStep"
    // rust: );
}

pub fn resident_fire_precedes_first_tick_lava_and_water_extinguishing() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: for name in ["minecraft:lava", "minecraft:water"] {
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let fluid = assets.registry.default_state(name).unwrap();
    // rust: scene.set(20, 4, 20, fluid).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: player.fire_ticks = 160;
    // rust: player.fall_distance = 8.0;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert_eq!(
    // rust: w.player.health.health(),
    // rust: 19.0,
    // rust: "base on-fire damage: {name}"
    // rust: );
    // rust: if name == "minecraft:lava" {
    // rust: assert_eq!(w.player.fire_ticks, 159);
    // rust: assert_eq!(w.player.fall_distance, 8.0, "first tick excludes lava");
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert_eq!(
    // rust: w.player.fall_distance, 4.0,
    // rust: "later ticks halve exactly once"
    // rust: );
    // rust: } else {
    // rust: assert_eq!(w.player.fire_ticks, 0, "water extinguishes after the hurt");
    // rust: assert_eq!(w.player.fall_distance, 0.0);
    // rust: w.player.fire_ticks = -7;
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert_eq!(
    // rust: w.player.fire_ticks, -7,
    // rust: "clearing fire retains negative delay"
    // rust: );
}
}
}

pub fn resident_bubble_columns_and_nautilus_preserve_their_air_rules() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: scene.set(20, 4, 20, water).unwrap();
    // rust: scene.set(20, 5, 20, water).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: for (extra_effect, expected_air) in [
    // rust: (None, -19),
    // rust: (Some("water_breathing"), -15),
    // rust: (Some("conduit_power"), -15),
    // rust: ] {
    // rust: let mut effects = crate::effects::PlayerEffects::default();
    // rust: effects.add(crate::effects::EffectInstance::new(
    // rust: "breath_of_the_nautilus",
    // rust: 200,
    // rust: 0,
    // rust: ));
    // rust: if let Some(id) = extra_effect {
    // rust: effects.add(crate::effects::EffectInstance::new(id, 200, 0));
}
    // rust: w.player.status = effects.status();
    // rust: assert!(w.player.status.breath_of_the_nautilus);
    // rust: w.player.air = -19;
    // rust: w.fluid_base_tick().unwrap();
    // rust: w.tick_environment_damage().unwrap();
    // rust: assert_eq!(w.player.air, expected_air);
    // rust: assert_eq!(w.player.health.health(), 20.0);
}
    // rust: w.player.status.water_breathing = false;
    // rust: for (name, nautilus) in [
    // rust: ("minecraft:bubble_column", false),
    // rust: ("minecraft:bubble_column", true),
    // rust: ("minecraft:air", true),
    // rust: ] {
    // rust: w.scene
    // rust: .set(20, 5, 20, assets.registry.default_state(name).unwrap())
    // rust: .unwrap();
    // rust: w.player.status.breath_of_the_nautilus = nautilus;
    // rust: w.player.air = -19;
    // rust: w.fluid_base_tick().unwrap();
    // rust: w.tick_environment_damage().unwrap();
    // rust: assert_eq!(w.player.air, -15, "{name}, nautilus={nautilus}");
    // rust: assert_eq!(w.player.health.health(), 20.0);
}
    // rust: w.scene.set(20, 5, 20, water).unwrap();
    // rust: w.player.status.breath_of_the_nautilus = false;
    // rust: w.player.air = -19;
    // rust: w.fluid_base_tick().unwrap();
    // rust: w.tick_environment_damage().unwrap();
    // rust: assert_eq!(w.player.air, 0);
    // rust: assert_eq!(w.player.health.health(), 18.0);
}

pub fn resident_mixed_fluids_use_lava_height_for_ground_jumps() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: for (water_level, lava_level, ground_jump) in [(0, 6, true), (6, 0, false)] {
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: for (name, level, x) in [
    // rust: ("minecraft:water", water_level, 20),
    // rust: ("minecraft:lava", lava_level, 21),
    // rust: ] {
    // rust: let mut state = assets
    // rust: .registry
    // rust: .state(assets.registry.default_state(name).unwrap())
    // rust: .unwrap()
    // rust: .clone();
    // rust: state.properties.insert("level".into(), level.to_string());
    // rust: scene
    // rust: .set(x, 4, 20, assets.registry.id(&state).unwrap())
    // rust: .unwrap();
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(21.0, 4.0, 20.5)).unwrap();
    // rust: player.ground.on_ground = true;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.fluid_base_tick().unwrap();
    // rust: assert!(w.player.fluids.was_touching_water && w.player.is_in_lava());
    // rust: assert_eq!(w.player.fluid_height(LAVA) <= 0.4, ground_jump);
    // rust: assert_eq!(w.player.fluid_height(WATER) > 0.4, ground_jump);
    // rust: w.dry_tick(TickInput::PreparedLocal {
    // rust: direction: [0.0; 2],
    // rust: jumping: true,
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(w.player.no_jump_delay == 10, ground_jump);
}
}

pub fn footsteps_follow_the_walked_distance_not_the_tick() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let mut steps = |player: &mut PlayerMotion, keys: crate::sprint::Keys, ticks: usize| {
    // rust: let mut count = 0;
    // rust: for _ in 0..ticks {
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut *player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(keys)
    // rust: .unwrap();
    // rust: count += std::mem::take(&mut player.events)
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MotionEvent::Emission { .. }))
    // rust: .count();
}
    // rust: count
}
        // Settle onto the floor, then stand still.
    // rust: steps(&mut player, Default::default(), 20);
    // rust: assert!(player.ground.on_ground);
    // rust: assert_eq!(steps(&mut player, Default::default(), 100), 0);
    // rust: let start = player.position;
    // rust: let forward = crate::sprint::Keys {
    // rust: forward: true,
    // rust: ..Default::default()
}
    // rust: let walked = steps(&mut player, forward, 100);
    // rust: let metres = player.position.subtract(start).length() * 0.6;
    // rust: assert!(metres > 5.0, "walked {metres}");
    // rust: assert!(
    // rust: (walked as f64 - metres).abs() <= 1.5,
    // rust: "{walked} steps over {metres} step-metres"
    // rust: );
}
    /// Vanilla sprint is a state, not a held key: `LocalPlayer.aiStep` starts
    /// it with the sprint key and stops it only on a vanilla stop condition.
    /// Releasing the key while swimming keeps the sprint and its swim speed.
pub fn a_sprint_survives_the_sprint_key_coming_up_while_swimming() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let water = assets.registry.default_state("minecraft:water").unwrap();
    // rust: let forward = crate::sprint::Keys {
    // rust: forward: true,
    // rust: ..Default::default()
}
    // rust: let sprinting = crate::sprint::Keys {
    // rust: sprint: true,
    // rust: ..forward
}
        // The same swim with the sprint key held, and with the key released
        // once the sprint has started: the speed must not change.
    // rust: let mut swims = Vec::new();
    // rust: for release in [false, true] {
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: for x in 19..=21 {
    // rust: for y in 4..=8 {
    // rust: for z in 19..=31 {
    // rust: scene.set(x, y, z, water).unwrap();
}
}
}
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: let mut speed = Vec::new();
    // rust: for tick in 0..12 {
                // The key comes up on the fourth tick, after the sprint has
                // started and the player swims.
    // rust: let keys = if release && tick >= 4 {
    // rust: forward
    // rust: } else {
    // rust: sprinting
}
    // rust: w.controlled_simulation_tick(keys).unwrap();
    // rust: speed.push(w.player.velocity.z);
}
    // rust: assert!(
    // rust: w.player.sprinting,
    // rust: "the sprint state survives the sprint key in water"
    // rust: );
    // rust: assert!(w.player.swimming, "a sprinting player in water swims");
    // rust: swims.push(speed);
}
    // rust: assert_eq!(
    // rust: swims[0], swims[1],
    // rust: "the swim speed must not drop when the sprint key comes up"
    // rust: );
}

    /// Vanilla: `LivingEntity.jumpFromGround` adds its 0.2 forward impulse
    /// while the sprint state holds, so a jump taken after the sprint key
    /// comes up is still a sprint jump.
pub fn a_sprint_jump_keeps_its_impulse_when_the_sprint_key_comes_up() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: let forward = crate::sprint::Keys {
    // rust: forward: true,
    // rust: ..Default::default()
}
    // rust: let sprinting = crate::sprint::Keys {
    // rust: sprint: true,
    // rust: ..forward
}
    // rust: for _ in 0..20 {
    // rust: w.controlled_simulation_tick(sprinting).unwrap();
}
    // rust: assert!(w.player.ground.on_ground, "the player settles on the floor");
    // rust: assert!(w.player.sprinting, "the sprint key starts the sprint");
    // rust: let running = w.player.velocity.z;
        // The sprint key comes up and the player jumps.
    // rust: w.controlled_simulation_tick(crate::sprint::Keys {
    // rust: jump: true,
    // rust: ..forward
    // rust: })
    // rust: .unwrap();
    // rust: assert!(
    // rust: w.player.sprinting,
    // rust: "the sprint state survives the sprint key in the air"
    // rust: );
    // rust: assert!(
    // rust: w.player.velocity.z > running + 0.05,
    // rust: "the sprint jump keeps its forward impulse: {:?} vs {running}",
    // rust: w.player.velocity
    // rust: );
}

    /// Vanilla `LocalPlayer.aiStep`: an item in use whose `use_effects` do not
    /// allow sprinting (a raised shield) keeps the sprint key, and a
    /// double-tap of forward, from starting a sprint; an item that allows it
    /// (a spear) does not.
pub fn an_item_in_use_stops_a_sprint_from_starting_unless_it_allows_sprinting() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: let forward = crate::sprint::Keys {
    // rust: forward: true,
    // rust: ..Default::default()
}
    // rust: let sprint_key = crate::sprint::Keys {
    // rust: sprint: true,
    // rust: ..forward
}
    // rust: w.player.item_use_speed = Some(0.2);
    // rust: w.player.item_use_slows_sprint = true;
    // rust: for _ in 0..10 {
    // rust: w.controlled_simulation_tick(sprint_key).unwrap();
}
    // rust: assert!(!w.player.sprinting, "a raised shield stops the sprint key");
        // Forward, off, forward again: the double-tap would sprint.
    // rust: for keys in [forward, Default::default(), forward, forward] {
    // rust: w.controlled_simulation_tick(keys).unwrap();
}
    // rust: assert!(!w.player.sprinting, "a raised shield stops a double-tap");
        // A spear's use_effects allow sprinting.
    // rust: w.player.item_use_speed = Some(1.0);
    // rust: w.player.item_use_slows_sprint = false;
    // rust: w.controlled_simulation_tick(sprint_key).unwrap();
    // rust: assert!(w.player.sprinting, "an item that can_sprint lets it start");
}

    /// Vanilla `LocalPlayer.isSprintingPossible`: blindness
    /// (`Player.isMobilityRestricted`) keeps the sprint key from starting a
    /// sprint and stops a running one (`shouldStopRunSprinting`).
pub fn blindness_stops_a_sprint_and_keeps_one_from_starting() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 4.0, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: let sprint_key = crate::sprint::Keys {
    // rust: forward: true,
    // rust: sprint: true,
    // rust: ..Default::default()
}
    // rust: w.controlled_simulation_tick(sprint_key).unwrap();
    // rust: assert!(w.player.sprinting);
    // rust: w.player.mobility_restricted = true;
    // rust: w.controlled_simulation_tick(sprint_key).unwrap();
    // rust: assert!(!w.player.sprinting, "blindness stops a running sprint");
    // rust: for _ in 0..10 {
    // rust: w.controlled_simulation_tick(sprint_key).unwrap();
}
    // rust: assert!(
    // rust: !w.player.sprinting,
    // rust: "blindness keeps the sprint key from starting one"
    // rust: );
    // rust: w.player.mobility_restricted = false;
    // rust: w.controlled_simulation_tick(sprint_key).unwrap();
    // rust: assert!(w.player.sprinting);
}

pub fn server_forced_flight_survives_without_permission_to_toggle_it() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: eprintln!("skipped forced flight: prepared resources unavailable");
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let start = Vec3::new(20.5, 20.0, 20.5);
    // rust: let mut player = PlayerMotion::new(&resources, start).unwrap();
    // rust: player.may_fly = false;
    // rust: player.flying = true;
    // rust: player.flying_speed = 0.0;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
        // Idle, movement in all directions, and repeated jump presses must
        // neither cancel server-forced flight nor move a zero-speed flyer.
    // rust: for tick in 0..60 {
    // rust: w.controlled_simulation_tick(crate::sprint::Keys {
    // rust: forward: tick % 4 == 0,
    // rust: backward: tick % 4 == 1,
    // rust: left: tick % 4 == 2,
    // rust: right: tick % 4 == 3,
    // rust: jump: tick % 2 == 0,
    // rust: shift: tick % 3 == 0,
    // rust: ..Default::default()
    // rust: })
    // rust: .unwrap();
    // rust: assert!(w.player.flying, "server-forced flight ended on tick {tick}");
    // rust: assert_eq!(w.player.position, start);
    // rust: assert_eq!(w.player.velocity, Vec3::ZERO);
}
        // A later abilities update from the server can still end flight.
    // rust: w.player.flying = false;
    // rust: for _ in 0..3 {
    // rust: w.controlled_simulation_tick(crate::sprint::Keys::default())
    // rust: .unwrap();
}
    // rust: assert!(!w.player.flying);
    // rust: assert!(w.player.position.y < start.y);
}

    /// Vanilla `Player.getFlyingSpeed`: a flying player moves at the ability
    /// speed, doubled while the sprint state holds. The sprint key starts the
    /// state; releasing it does not change the speed.
pub fn the_flight_speed_follows_the_sprint_state_not_the_sprint_key() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 3).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 10.0, 20.5)).unwrap();
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: w.player.may_fly = true;
    // rust: w.player.flying = true;
    // rust: let forward = crate::sprint::Keys {
    // rust: forward: true,
    // rust: ..Default::default()
}
    // rust: let sprinting = crate::sprint::Keys {
    // rust: sprint: true,
    // rust: ..forward
}
    // rust: assert_eq!(
    // rust: w.flying_speed().unwrap(),
    // rust: 0.05,
    // rust: "a flying player without a sprint moves at the ability speed"
    // rust: );
        // The sprint key starts the sprint, and the state doubles the speed.
    // rust: w.controlled_simulation_tick(sprinting).unwrap();
    // rust: assert!(w.player.sprinting, "the sprint key starts the sprint");
    // rust: assert_eq!(
    // rust: w.flying_speed().unwrap(),
    // rust: 0.1,
    // rust: "a sprinting player flies at twice the ability speed"
    // rust: );
        // Releasing the sprint key keeps the state, so the speed stays.
    // rust: w.controlled_simulation_tick(forward).unwrap();
    // rust: assert!(
    // rust: w.player.sprinting,
    // rust: "the sprint state survives the sprint key in the air"
    // rust: );
    // rust: assert_eq!(
    // rust: w.flying_speed().unwrap(),
    // rust: 0.1,
    // rust: "the flight speed follows the sprint state, not the sprint key"
    // rust: );
}
    /// #9858: `LivingEntity.tick` counts `fallFlyTicks` after `aiStep`, so
    /// `updateFallFlying` sees last tick's count plus one: the glider wears
    /// on the 20th glide tick, not the 19th.
pub fn a_glider_wears_on_the_twentieth_glide_tick() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
    // rust: let mut player = PlayerMotion::new(&resources, Vec3::new(20.5, 100.0, 20.5)).unwrap();
    // rust: player.glider = true;
    // rust: player.fall_flying = true;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: for tick in 1..=19 {
    // rust: w.player_movement_tick([0.0, 0.0], false).unwrap();
    // rust: assert!(w.player.fall_flying, "still gliding on tick {tick}");
    // rust: assert_eq!(w.player.glider_wear, 0, "no wear by tick {tick}");
}
    // rust: w.player_movement_tick([0.0, 0.0], false).unwrap();
    // rust: assert_eq!(
    // rust: w.player.glider_wear, 1,
    // rust: "the 20th glide tick wears the glider"
    // rust: );
    // rust: assert_eq!(w.player.fall_fly_ticks, 20);
}
    /// #9817: `LivingEntity.travelInAir`: a client (`level.isClientSide()`) whose
    /// chunk below is not loaded skips gravity and falls at 0.1 a tick
    /// (above `getMinY`), before the 0.98 vertical drag.
pub fn a_client_over_an_unloaded_chunk_falls_at_a_tenth() void {
}
    // rust: let root = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let binding = crate::collisions::load(&root, assets.registry).unwrap();
    // rust: let resources = MotionResources::load(&root, &assets).unwrap();
    // rust: for (client_side, want) in [
    // rust: (true, -0.1 * f64::from(0.98_f32)),
    // rust: (false, -0.0784000015258789),
    // rust: ] {
    // rust: let mut scene = World::test_scene(&assets, &render, 2).unwrap();
            // Far outside the test scene's chunks.
    // rust: let at = Vec3::new(10_000.5, 20.0, 10_000.5);
    // rust: assert!(!scene.chunks.contains_key(&(10_000 >> 4, 10_000 >> 4)));
    // rust: let mut player = PlayerMotion::new(&resources, at).unwrap();
    // rust: player.client_side = client_side;
    // rust: MotionWorld {
    // rust: entities: &[],
    // rust: player: &mut player,
    // rust: scene: &mut scene,
    // rust: assets: &assets,
    // rust: collision_binding: &binding,
    // rust: resources: &resources,
    // rust: health: &resources.health,
}
    // rust: .controlled_simulation_tick(Default::default())
    // rust: .unwrap();
    // rust: assert_eq!(player.velocity.y, want, "client_side={client_side}");
}
}
}
