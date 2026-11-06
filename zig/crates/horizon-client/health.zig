//! Transpiled from Horizon Rust crate
//! Module: horizon-client_health
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Stored player health and empty-equipment server damage for the resident scene.
//! World/audio/network consumers are queued explicitly; full death and tick
//! lifecycles (drops, respawn, effects) remain separate work.
// use crate::{
    // rust: Result,
    // rust: motion::{MotionEvent, PlayerMotion},
}
// use horizon_world::{
    // rust: attributes::live::LiveAttributes,
    // rust: block_landing::LandingDamage,
    // rust: combat_rules::ArmorWorld,
    // rust: damage_immunity::{self, DamageRule, ImmunityTag, ImmunityWorld},
    // rust: damage_reduction::Bypass,
    // rust: damage_source::{Catalog, DamageSource, DamageTypeId, Scaling},
    // rust: food::{Difficulty, FoodData},
    // rust: living_damage::DamageStat,
    // rust: living_hurt::{HurtState, HurtTag, HurtWorld},
    // rust: player_health::{PlayerAttributeHealth, PlayerFloatIds},
    // rust: player_hurt::{CausingEntity, PlayerHurtWorld, ServerPlayerHurtWorld},
    // rust: server_player_combat::{CombatEnvironment, ServerPlayerCombat},
    // rust: server_player_damage::ServerDamageEnvironment,
    // rust: synced_floats::{FloatValue, Observer, SyncedFloats},
}
// use std::{cell::Cell, fs, io, path::Path, sync::OnceLock};
    // rust: pub(crate) type Attributes = LiveAttributes<Box<dyn horizon_world::attributes::live::Identities>>;
    // rust: pub(crate) type State = HurtState<DamageTypeId>;

    // rust: pub use crate::world::HealthRules;
/// A hit's `DamageSource` for [`HURT_SERVER`]: its type (`minecraft:fall`),
/// and the entity ids of `getEntity` (`causing`) and `getDirectEntity`
/// (`direct`), 0 for none or not known.
pub const HurtSource = struct {
    damage_type: *'a str,
    causing: i32,
    direct: i32,
};
/// What `LivingEntity.hurtServer` is about to hurt, for [`HURT_SERVER`], or
/// `LivingEntity.knockback` to push, for [`KNOCKBACK`]: the entity and the
/// hit's source.
pub const Hurting = enum {
    /// A player, by its entity id.
    Player(i32, HurtSource<'a>),
    /// A mob, and what hurts it.
    Mob(&'a crate::mobs::Mob, &'a crate::mobs::Damage),
    /// The ender dragon, by its entity id.
    Dragon(i32, HurtSource<'a>),
    /// An armor stand, by its entity id, for sweep knockback.
    ArmorStand(i32, HurtSource<'a>),
};
/// The game's native damage hook (`native_living_incoming_damage`), set once by the
/// game: `LivingEntity.hurtServer` once its guards passed. It may change the
/// amount; true cancels the hit.
pub const HURT_SERVER: OnceLock<fn(Hurting<'_>, *mut f32) -> bool> = OnceLock::new();
/// Whether [`HURT_SERVER`] canceled the hit (never while it is unset).
pub fn hurt_server_canceled(hurting: Hurting<'_>, amount: *mut f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HURT_SERVER.get().is_some_and(|hook| hook(hurting, amount))
}
/// A knockback's strength and direction, as `LivingEntity.knockback` has them
/// before knockback resistance is applied. The entity is pushed away from
/// the direction (`x`, `z`), which vanilla points at the source of the hit.
pub const Knock = struct {
    strength: f64,
    x: f64,
    z: f64,
};
/// The game's native knockback hook (`native_living_knockback`), set once by
/// the game: `LivingEntity.knockback`, at its start (`LivingKnockBackEvent`), on the raw strength
/// and before the knockback resistance and the motion change. It may change the [`Knock`]; true
/// cancels it.
pub const KNOCKBACK: OnceLock<fn(Hurting<'_>, *mut Knock) -> bool> = OnceLock::new();

    // rust: thread_local! {
pub const KNOCKBACK_ATTACKER: Cell<i32> = const { Cell::new(0) };
    // rust: static KNOCKBACK_HELD: std::cell::RefCell<[Option<crate::items::ItemStack>; 2]> =
    // rust: const { std::cell::RefCell::new([None, None]) };
}

/// The entity behind the synchronous attack, or 0 outside an attack scope.
pub fn knockback_attacker() i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: KNOCKBACK_ATTACKER.get()
}

/// What the attacker holds in the main and off hand, or none when it is not known (or no
/// native mod listens: the game only records it then).
pub fn knockback_held() [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: KNOCKBACK_HELD.with(|held| held.borrow().clone())
}

/// Restore the previous attacker on return or unwind, including nested guest actions.
pub fn knockback_from(entity: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: knockback_from_holding(entity, [None, None])
}

/// [`knockback_from`] that also records the attacker's held stacks (main hand, off hand).
    // rust: pub fn knockback_from_holding(
    // rust: entity: i32,
    // rust: held: [Option<crate::items::ItemStack>; 2],
    // rust: ) -> impl Drop {
pub const Restore = struct {};
    // rust: impl Drop for Restore {
pub fn drop(self: *Self) void {
}
    // rust: KNOCKBACK_ATTACKER.set(self.0);
    // rust: KNOCKBACK_HELD.with(|held| *held.borrow_mut() = std::mem::take(&mut self.1));
}
}
    // rust: let held = KNOCKBACK_HELD.with(|slot| std::mem::replace(&mut *slot.borrow_mut(), held));
    // rust: Restore(KNOCKBACK_ATTACKER.replace(entity), held)
}
/// Whether [`KNOCKBACK`] canceled the knockback (never while it is unset). A
/// value it leaves that is not a finite number is put back as it was.
pub fn knockback_canceled(pushed: Hurting<'_>, knock: *mut Knock) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(hook) = KNOCKBACK.get() else {
    // rust: return false;
}
    // rust: let before = *knock;
    // rust: let canceled = hook(pushed, knock);
    // rust: for (now, was) in [
    // rust: (&mut knock.strength, before.strength),
    // rust: (&mut knock.x, before.x),
    // rust: (&mut knock.z, before.z),
    // rust: ] {
    // rust: if !now.is_finite() {
    // rust: *now = was;
}
}
    // rust: canceled
}
pub const HealthResources = struct {
    damage: Catalog,
    ids: PlayerFloatIds,
};
    // rust: impl HealthResources {
pub fn load(root: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let read = |name: &str| -> Result<serde_json::Value> {
    // rust: Ok(serde_json::from_slice(&fs::read(root.join(name))?)?)
}
    // rust: let ids = read("player-float-ids.json")?;
    // rust: let id = |name: &str| -> Result<u8> {
    // rust: Ok(u8::try_from(
    // rust: ids[name].as_u64().ok_or("missing player float ID")?,
    // rust: )?)
}
    // rust: let damage = Catalog::load(root, &horizon_world::loot::PackOverlay::NONE)?;
    // rust: for name in ["minecraft:fall", "minecraft:stalagmite", "minecraft:starve"] {
    // rust: if damage.id(name).is_none() {
    // rust: return Err(format!("missing damage type {name}").into());
}
}
    // rust: Ok(Self {
    // rust: damage,
    // rust: ids: PlayerFloatIds {
    // rust: health: id("health")?,
    // rust: absorption: id("absorption")?,
    // rust: },
    // rust: })
}
    /// A world's frozen damage registry at open, or reloaded tags against
    /// that same registry. Player metadata IDs stay the prepared version's.
    // rust: pub fn with_packs(
    // rust: &self,
    // rust: root: &Path,
    // rust: overlay: &horizon_world::loot::PackOverlay<'_>,
    // rust: reload: bool,
    // rust: ) -> Result<Self> {
    // rust: Ok(Self {
    // rust: damage: if reload {
    // rust: self.damage.reload_tags(root, overlay)?
    // rust: } else {
    // rust: Catalog::load(root, overlay)?
    // rust: },
    // rust: ids: self.ids,
    // rust: })
}
pub fn landing_source(self: *Self, source: LandingDamage) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.damage
    // rust: .id(match source {
    // rust: LandingDamage::Fall => "minecraft:fall",
    // rust: LandingDamage::Stalagmite => "minecraft:stalagmite",
    // rust: })
    // rust: .expect("validated landing source")
}
}
/// `DamageEffects.sound()` by its serialized id: what `Player.getHurtSound`
/// plays for a damage type's `effects` (unknown ids fall back to `hurt`, the codec default).
pub fn hurt_sound(effects: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match effects {
    // rust: "drowning" => "minecraft:entity.player.hurt_drown",
    // rust: "burning" => "minecraft:entity.player.hurt_on_fire",
    // rust: "poking" => "minecraft:entity.player.hurt_sweet_berry_bush",
    // rust: "freezing" => "minecraft:entity.player.hurt_freeze",
        // HURT and THORNS (both SoundEvents.PLAYER_HURT).
    // rust: _ => "minecraft:entity.player.hurt",
}
}
pub const HealthEvent = enum {
    /// `FoodData.tick` calling `hurtServer` with starvation. Only a hit that
    /// lands is recorded (`RecordedDamage`).
    StarvationDamage(f32),
    /// `LivingEntity.aiStep` hurting a fully frozen entity.
    FreezeDamage(f32),
    /// `SweetBerryBushBlock.entityInside` pricking a moving entity.
    SweetBerryBushDamage(f32),
    /// `LivingEntity.baseTick` drowning an entity out of air.
    DrownDamage(f32),
    Updated {,
    id: u8,
    value: f32,
    dirty: bool,
    // rust: },
    Statistic {,
    name: &'static str,
    amount: i32,
    // rust: },
    RecordedDamage {,
    source: DamageTypeId,
    amount: f32,
    // rust: },
    Phase(&'static str),
    /// `Player.hurtArmor`: a hit that doesn't bypass armor wears the worn
    /// pieces (`LivingEntity.getDamageAfterArmorAbsorb`); the game applies it.
    ArmorHurt {,
    source: DamageTypeId,
    amount: f32,
    // rust: },
    /// `ServerLevel.broadcastDamageEvent`: the client's
    /// `LivingEntity.handleDamageEvent` plays the source's hurt sound.
    DamageBroadcast {,
    source: DamageTypeId,
    // rust: },
    Criterion {,
    original: f32,
    amount: f32,
    blocked: bool,
    // rust: },
};
    // rust: impl HealthEvent {
pub fn trace(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::StarvationDamage(amount) => format!("damage starve {:08x}", amount.to_bits()),
    // rust: Self::FreezeDamage(amount) => format!("damage freeze {:08x}", amount.to_bits()),
    // rust: Self::SweetBerryBushDamage(amount) => {
    // rust: format!("damage sweet_berry_bush {:08x}", amount.to_bits())
}
    // rust: Self::DrownDamage(amount) => format!("damage drown {:08x}", amount.to_bits()),
    // rust: Self::Updated { id, value, dirty } => {
    // rust: format!("updated {id} {:08x} {dirty}", value.to_bits())
}
    // rust: Self::Statistic { name, amount } => format!("health-stat {name} {amount}"),
    // rust: Self::RecordedDamage { amount, .. } => {
    // rust: format!("record-damage {:08x}", amount.to_bits())
}
    // rust: Self::Phase(name) => name.into(),
    // rust: Self::ArmorHurt { amount, .. } => format!("hurt-armor {:08x}", amount.to_bits()),
    // rust: Self::DamageBroadcast { .. } => "broadcast-damage".into(),
    // rust: Self::Criterion { .. } => "hurt-criterion".into(),
}
}
}
    // rust: pub(crate) struct Updates<'a>(pub(crate) &'a mut Vec<MotionEvent>);
    // rust: impl Observer for Updates<'_> {
    // rust: type Error = io::Error;
pub fn updated(self: *Self, data: *mut SyncedFloats, id: u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.push(MotionEvent::Health(HealthEvent::Updated {
    // rust: id,
    // rust: value: data.get(id).expect("existing updated field"),
    // rust: dirty: data.is_dirty(),
    // rust: }));
    // rust: Ok(())
}
}
pub const PlayerHealth = struct {
    data: SyncedFloats,
    ids: PlayerFloatIds,
    food: FoodData,
    hurt: State,
    /// Client hurt animation; fully blocked hits only refresh the server's hurt state.
    hurt_animation_time: i32,
    /// `Player.hurtDir` on a client: the yaw `ClientboundHurtAnimationPacket`
    /// gave, which `GameRenderer.bobHurt` tilts the camera around.
    hurt_dir: f32,
    /// `ServerPlayer.hurtDir` of a hit the player's client hasn't been told
    /// of yet (`indicateDamage`).
    indicated_dir: ?f32,
    dead: bool,
    sync_velocity: bool,
    game_time: i64,
    tick_count: i32,
    /// A death-protection item (totem) is in either hand.
    totem_ready: bool,
    /// The totem saved the player this tick; the game applies its effects.
    totem_used: bool,
};
    // rust: impl PlayerHealth {
pub fn new(resources: *HealthResources, attributes: *mut Attributes) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ids = resources.ids;
    // rust: let mut data = SyncedFloats::new(&[
    // rust: FloatValue {
    // rust: id: ids.health,
    // rust: value: 1.0,
    // rust: },
    // rust: FloatValue {
    // rust: id: ids.absorption,
    // rust: value: 0.0,
    // rust: },
    // rust: ])?;
    // rust: let mut ignored = Vec::new();
    // rust: let mut observer = Updates(&mut ignored);
    // rust: let maximum = attributes
    // rust: .key("minecraft:max_health")
    // rust: .ok_or("missing max health")?;
    // rust: let maximum = attributes
    // rust: .value(
    // rust: Some(maximum),
    // rust: horizon_world::attribute_map::ValueKind::Computed,
    // rust: )
    // rust: .map_err(|e| io::Error::other(format!("health attribute: {e:?}")))?
    // rust: as f32;
    // rust: PlayerAttributeHealth::new(attributes, &mut data, ids, false, &mut observer)?
    // rust: .set_health(maximum)?;
    // rust: Ok(Self {
    // rust: data,
    // rust: ids,
    // rust: food: FoodData::default(),
    // rust: hurt: HurtState {
    // rust: no_action_time: 0,
    // rust: cooldown: 0,
    // rust: last_hurt: 0.0,
    // rust: hurt_duration: 0,
    // rust: hurt_time: 0,
    // rust: last_source: None,
    // rust: last_stamp: 0,
    // rust: },
    // rust: hurt_animation_time: 0,
    // rust: hurt_dir: 0.0,
    // rust: indicated_dir: None,
    // rust: dead: false,
    // rust: sync_velocity: false,
    // rust: game_time: 0,
    // rust: tick_count: 0,
    // rust: totem_ready: false,
    // rust: totem_used: false,
    // rust: })
}
pub fn health(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
    // rust: .get(self.ids.health)
    // rust: .expect("validated health field")
}
pub fn absorption(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
    // rust: .get(self.ids.absorption)
    // rust: .expect("validated absorption field")
}
    /// The game time the damage clock has counted.
pub fn game_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game_time
}
pub fn dead_or_dying(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.health() <= 0.0 || self.dead
}
    /// The damage-clock phases of ServerPlayer.tick and LivingEntity.baseTick.
    /// The complete enclosing ticks, including death removal, are not yet bound.
pub fn advance_clock(self: *Self) void {
}
    // rust: self.game_time = self.game_time.wrapping_add(1);
    // rust: self.tick_count = self.tick_count.wrapping_add(1);
    // rust: if self.hurt.cooldown > 0 {
    // rust: self.hurt.cooldown -= 1;
}
    // rust: if self.hurt.hurt_time > 0 {
    // rust: self.hurt.hurt_time -= 1;
}
    // rust: if self.hurt_animation_time > 0 {
    // rust: self.hurt_animation_time -= 1;
}
}
    /// `LivingEntity.animateHurt` / `handleDamageEvent` on a client: the hurt
    /// tilt and red flash restart.
pub fn animate_hurt(self: *Self) void {
}
    // rust: self.hurt.hurt_duration = 10;
    // rust: self.hurt.hurt_time = 10;
    // rust: self.hurt_animation_time = 10;
}
    /// `LivingEntity.animateHurt(yaw)` on a player: the tilt restarts around
    /// `yaw` (`Player.animateHurt` keeps it as `hurtDir`).
pub fn animate_hurt_dir(self: *Self, yaw: f32) void {
}
    // rust: self.animate_hurt();
    // rust: self.hurt_dir = yaw;
}
    /// `ServerPlayer.indicateDamage`: the hit's direction relative to where
    /// the player looks, kept for the packet to its client.
pub fn indicate_damage(self: *Self, xd: f64, zd: f64, yaw: f32) void {
}
//         use horizon_core::geometry::trig::{RAD_TO_DEG, atan2};
    // rust: self.indicated_dir = Some((atan2(zd, xd) * f64::from(RAD_TO_DEG) - f64::from(yaw)) as f32);
}
    /// `LocalPlayer.hurtTo` with `flashOnSetHealth`: a drop below the current
    /// health starts the hurt animation; `damageCooldownTime` (20 on a drop,
    /// 10 on a gain) is what lets `Hud.extractPlayerHealth` blink the hearts.
pub fn flash_health_change(self: *Self, health: f32) void {
}
    // rust: let damage = self.health() - health;
    // rust: if damage <= 0.0 {
    // rust: if damage < 0.0 {
    // rust: self.hurt.cooldown = 10;
}
    // rust: } else {
    // rust: self.hurt.last_hurt = damage;
    // rust: self.hurt.cooldown = 20;
    // rust: self.animate_hurt();
}
}
}
    // rust: impl PlayerMotion {
    // rust: pub fn hurt(
    // rust: &mut self,
    // rust: resources: &HealthResources,
    // rust: rules: HealthRules,
    // rust: source: DamageTypeId,
    // rust: amount: f32,
    // rust: ) -> Result<bool> {
    // rust: Ok(self
    // rust: .hurt_blocking(resources, rules, source, amount, None)?
    // rust: .hurt)
}
    // rust: pub fn hurt_blocking(
    // rust: &mut self,
    // rust: resources: &HealthResources,
    // rust: rules: HealthRules,
    // rust: source: DamageTypeId,
    // rust: amount: f32,
    // rust: blocking: Option<Blocking>,
    // rust: ) -> Result<BlockOutcome> {
    // rust: self.hurt_caused_by(resources, rules, source, amount, blocking, false, 0)
}
    /// `hurt_blocking` from a source whose causing entity is a living
    /// non-player (`living_cause`), which the `when_caused_by_living_non_player`
    /// damage types scale with the difficulty. `causing` is that entity's id
    /// when it is known (0 otherwise), for the native damage hook.
    // rust: pub fn hurt_caused_by(
    // rust: &mut self,
    // rust: resources: &HealthResources,
    // rust: rules: HealthRules,
    // rust: source: DamageTypeId,
    // rust: amount: f32,
    // rust: blocking: Option<Blocking>,
    // rust: living_cause: bool,
    // rust: causing: i32,
    // rust: ) -> Result<BlockOutcome> {
    // rust: if self.client_side {
    // rust: return Ok(BlockOutcome::default());
}
    // rust: let source = resources
    // rust: .damage
    // rust: .source::<()>(source, None, None, None)
    // rust: .ok_or("unknown resident damage source")?;
    // rust: let before = self.health.health() + self.health.absorption();
    // rust: let fire_ticks = self.fire_ticks;
    // rust: let source_name = source.definition().name.clone();
    // rust: let totem_ready = self.health.totem_ready;
    // rust: let invulnerable = self.invulnerable;
    // rust: let h = &mut self.health;
    // rust: let mut environment = Environment {
    // rust: entity: self.entity_id,
    // rust: causing,
    // rust: invulnerable,
    // rust: client_loaded: self.client_loaded,
    // rust: rules,
    // rust: source,
    // rust: living_cause,
    // rust: events: &mut self.events,
    // rust: dead: &mut h.dead,
    // rust: sync_velocity: &mut h.sync_velocity,
    // rust: game_time: h.game_time,
    // rust: status: self.status.clone(),
    // rust: blocking,
    // rust: blocked: 0.0,
    // rust: fully_blocked: false,
    // rust: block_sound: false,
    // rust: knocked: false,
    // rust: totem: totem_ready,
    // rust: totem_fired: false,
    // rust: canceled: false,
}
    // rust: let hurt = ServerPlayerCombat::new(
    // rust: &mut self.attributes,
    // rust: &mut h.data,
    // rust: &mut h.food,
    // rust: h.ids,
    // rust: &mut environment,
    // rust: )?
    // rust: .hurt(&mut h.hurt, amount)?;
    // rust: let outcome = BlockOutcome {
    // rust: hurt,
    // rust: blocked: environment.blocked,
    // rust: fully_blocked: environment.fully_blocked,
    // rust: sound: environment.block_sound,
    // rust: knockback: environment.knocked,
    // rust: canceled: environment.canceled,
}
    // rust: if environment.totem_fired {
    // rust: h.totem_used = true;
    // rust: h.totem_ready = false;
}
    // rust: if outcome.hurt {
    // rust: h.hurt_animation_time = h.hurt.hurt_time;
}
        // `dealDefaultKnockback` ends in `indicateDamage` unless blocked: a
        // hit with no direction of its own (`xd` and `zd` zero) is sent as
        // the opposite of the player's yaw. A hit that has a direction
        // replaces this (`mob_hits_player`).
    // rust: if outcome.knockback && outcome.blocked <= 0.0 {
    // rust: h.indicate_damage(0.0, 0.0, self.yaw);
}
    // rust: let after = h.health() + h.absorption();
        // `LivingEntity.getDamageAfterArmorAbsorb` is the hit's only reader of
        // these two instances, and a source in `#minecraft:bypasses_armor`
        // makes it return before `getArmorValue` and
        // `getAttributeValue(ARMOR_TOUGHNESS)`. Native `getValue` is what
        // clears an instance's dirty flag, so the record takes the caches the
        // hit left instead of recomputing them: one that does meet the armour
        // has already recomputed both in `after_armor`, and one that bypassed
        // it leaves creation's zero cache untouched.
    // rust: let armor = self
    // rust: .attributes
    // rust: .cached_value_of("minecraft:armor")
    // rust: .unwrap_or(0.0) as f32;
    // rust: let toughness = self
    // rust: .attributes
    // rust: .cached_value_of("minecraft:armor_toughness")
    // rust: .unwrap_or(0.0) as f32;
    // rust: if self.hurt_log.len() >= HURT_LOG {
    // rust: self.hurt_log.remove(0);
}
    // rust: self.hurt_log.push(HurtRecord {
    // rust: game_time: h.game_time,
    // rust: source: source_name,
    // rust: amount,
    // rust: blocked: outcome.blocked,
    // rust: taken: before - after,
    // rust: hurt: outcome.hurt,
    // rust: armor,
    // rust: toughness,
    // rust: health: after,
    // rust: fire_ticks,
    // rust: knockback: None,
    // rust: });
    // rust: Ok(outcome)
}
pub fn set_health(self: *Self, value: f32, absorption: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = &mut self.health;
    // rust: let mut observer = Updates(&mut self.events);
    // rust: let mut binding = PlayerAttributeHealth::new(
    // rust: &mut self.attributes,
    // rust: &mut h.data,
    // rust: h.ids,
    // rust: h.dead,
    // rust: &mut observer,
    // rust: )?;
    // rust: if absorption {
    // rust: binding.set_absorption(value)?;
    // rust: } else {
    // rust: binding.set_health(value)?;
}
    // rust: Ok(())
}
}
    // rust: pub(crate) struct Environment<'a> {
    /// The player's entity id, and the causing entity's (0: none or not known).
    // rust: pub(crate) entity: i32,
    // rust: pub(crate) causing: i32,
    /// Abilities.invulnerable.
    // rust: pub(crate) invulnerable: bool,
    /// The player's client has loaded the world since its last respawn or
    /// level change (`ServerGamePacketListenerImpl.hasClientLoaded`).
    // rust: pub(crate) client_loaded: bool,
    // rust: pub(crate) rules: HealthRules,
    // rust: pub(crate) source: DamageSource<'a, ()>,
    /// The causing entity is a living non-player (a mob, or its projectile's owner).
    // rust: pub(crate) living_cause: bool,
    // rust: pub(crate) events: &'a mut Vec<MotionEvent>,
    // rust: pub(crate) dead: &'a mut bool,
    // rust: pub(crate) sync_velocity: &'a mut bool,
    // rust: pub(crate) game_time: i64,
    /// Resistance, fire resistance and armor protection (effects.rs).
    // rust: pub(crate) status: crate::effects::StatusFlags,
    /// The raised blocking item, if any, and what it blocked.
    // rust: pub(crate) blocking: Option<Blocking>,
    // rust: pub(crate) blocked: f32,
    /// What it blocked covers the whole hit, as difficulty scaled it.
    // rust: pub(crate) fully_blocked: bool,
    // rust: pub(crate) block_sound: bool,
    /// `dealDefaultKnockback` ran: a fresh hit, not fully blocked.
    // rust: pub(crate) knocked: bool,
    /// LivingEntity.checkTotemDeathProtection: a totem is held / was used.
    // rust: pub(crate) totem: bool,
    // rust: pub(crate) totem_fired: bool,
    /// A native mod canceled the hit (`living_incoming_damage`).
    // rust: pub(crate) canceled: bool,
}
/// `LivingEntity.applyItemBlocking` inputs for a raised `BlocksAttacks` item:
/// reductions whose damage-type sets are already matched against the source.
pub const Blocking = struct {
    rules: horizon_world::blocking_rules::BlockingRules<bool>,
    /// `bypassed_by` contains the source's damage type.
    bypassed: bool,
    /// The direct entity is an arrow with piercing.
    pierce: bool,
    /// Angle between the head's view and the source position (pi without one).
    angle: f64,
};
/// How many hurts `PlayerMotion::hurt_log` keeps.
pub const HURT_LOG: usize = 64;
/// One hurt as it was taken: what came in, what a raised blocking item
/// stopped, the armour it met and what health it left.
pub const HurtRecord = struct {
    game_time: i64,
    /// The damage type.
    source: []const u8,
    /// The damage before blocking, armour and effects.
    amount: f32,
    blocked: f32,
    /// Health and absorption lost.
    taken: f32,
    hurt: bool,
    /// `minecraft:armor` and `minecraft:armor_toughness` as the hit left their
    /// instances' caches. `getDamageAfterArmorAbsorb` reads them only for a
    /// source outside `#minecraft:bypasses_armor`, so a hit that bypassed the
    /// armour reports the cache that source never recomputed.
    armor: f32,
    toughness: f32,
    health: f32,
    /// The fire ticks before the hurt.
    fire_ticks: i32,
    /// The push the hurt gave, if the caller applied one.
    knockback: Option<[f64,
};
/// One melee attack on a mob: the damage after the attack strength, the
/// strength (`getAttackStrengthScale`), and the health it took.
pub const AttackRecord = struct {
    game_time: i64,
    target: []const u8,
    /// The mob's entity id, and whether the blow killed it.
    id: u32,
    killed: bool,
    amount: f32,
    scale: f32,
    crit: bool,
    landed: bool,
    dealt: f32,
};
/// The outcome of a hurt with a raised blocking item.
pub const BlockOutcome = struct {
    hurt: bool,
    blocked: f32,
    /// `applyItemBlocking`'s `damageBlocked >= damage`, against the damage
    /// `Player.hurtServer` scaled with the difficulty.
    fully_blocked: bool,
    /// `BlocksAttacks.onBlocked` ran (the block sound plays).
    sound: bool,
    /// The hit knocks the player back (`dealDefaultKnockback`): not one in
    /// the hurt cooldown, nor one the shield took whole.
    knockback: bool,
    /// A native mod canceled the hit: its attacker must not be credited.
    canceled: bool,
};
pub const MatchedSets = struct {};
    // rust: impl horizon_world::blocking_rules::TypeMatchWorld for MatchedSets {
    // rust: type Error = io::Error;
    // rust: type Set = bool;
pub fn source_in_set(self: *Self, set: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(set)
}
}
    // rust: impl Environment<'_> {
pub fn event(self: *Self, event: HealthEvent) void {
}
    // rust: self.events.push(MotionEvent::Health(event));
}
pub fn phase(self: *Self, name: *'static str) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.event(HealthEvent::Phase(name));
    // rust: Ok(())
}
pub fn stat(self: *Self, name: *'static str, amount: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.event(HealthEvent::Statistic { name, amount });
    // rust: Ok(())
}
}
    // rust: impl Observer for Environment<'_> {
    // rust: type Error = io::Error;
pub fn updated(self: *Self, data: *mut SyncedFloats, id: u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Updates(self.events).updated(data, id)
}
}
    // rust: impl ArmorWorld for Environment<'_> {
    // rust: type Error = io::Error;
    // rust: type Weapon = ();
    // rust: type ServerLevel = ();
pub fn weapon(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(None)
}
pub fn server_level(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Some(()))
}
pub fn modify_armor_effectiveness(self: *Self, _: () void {
}
    // rust: Ok(value)
}
}
    // rust: impl ServerDamageEnvironment<Attributes> for Environment<'_> {
    // rust: type Attacker = ();
pub fn invulnerable(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: damage_immunity::server_player_immunity(self)
}
pub fn bypasses(self: *Self, kind: Bypass) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.source.bypasses(kind))
}
pub fn hurt_armor(self: *Self, _: *mut Attributes, damage: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
        // The worn armor lives in the game, which wears it from this event.
    // rust: self.event(HealthEvent::ArmorHurt {
    // rust: source: self.source.type_id(),
    // rust: amount: damage,
    // rust: });
    // rust: Ok(())
}
pub fn has_resistance(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.status.resistance.is_some())
}
pub fn resistance_amplifier(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.status
    // rust: .resistance
    // rust: .ok_or_else(|| io::Error::other("no resistance effect"))
}
pub fn award_resisted(self: *Self, value: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stat("resisted", value)
}
pub fn attacker(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(None)
}
pub fn award_dealt_resisted(self: *Self, _: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(io::Error::other("no damage attacker"))
}
pub fn damage_protection(self: *Self, _: () void {
}
    // rust: Ok(self.status.protection(&self.source.definition().name))
}
pub fn award_self(self: *Self, stat: DamageStat, value: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stat(
    // rust: match stat {
    // rust: DamageStat::Absorbed => "absorbed",
    // rust: DamageStat::Taken => "taken",
    // rust: DamageStat::DealtAbsorbed => return Err(io::Error::other("attacker statistic")),
    // rust: },
    // rust: value,
    // rust: )
}
pub fn award_attacker(self: *Self, _: () void {
}
    // rust: Err(io::Error::other("no damage attacker"))
}
pub fn source_food_exhaustion(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.source.definition().exhaustion)
}
pub fn ability_invulnerable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.invulnerable
}
pub fn level_is_client(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn record_damage(self: *Self, amount: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.event(HealthEvent::RecordedDamage {
    // rust: source: self.source.type_id(),
    // rust: amount,
    // rust: });
    // rust: Ok(())
}
pub fn damage_event(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.phase("entity-damage")
}
}
    // rust: impl CombatEnvironment<Attributes> for Environment<'_> {
pub fn dead_flag(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self.dead
}
}
    // rust: impl ImmunityWorld for Environment<'_> {
    // rust: type Error = io::Error;
pub fn removed(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn permanently_invulnerable(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn temporarily_invulnerable(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn tag(self: *Self, tag: ImmunityTag) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.source.immunity_tag(tag))
}
pub fn creative_source(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn fire_immune(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn fall_immune(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn enchantment_immunity(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn damage_rule(self: *Self, rule: DamageRule) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(match rule {
    // rust: DamageRule::Drowning => self.rules.drowning_damage,
    // rust: DamageRule::Fall => self.rules.fall_damage,
    // rust: DamageRule::Fire => self.rules.fire_damage,
    // rust: DamageRule::Freeze => self.rules.freeze_damage,
    // rust: })
}
pub fn changing_dimension(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn ender_pearl(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.source.is_type("minecraft:ender_pearl"))
}
pub fn client_loaded(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.client_loaded)
}
}
    // rust: impl HurtWorld for Environment<'_> {
    // rust: type Error = io::Error;
    // rust: type Source = DamageTypeId;
    // rust: type UseItem = ();
    // rust: type Blocking = ();
    // rust: type Sound = ();
pub fn source(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.source.type_id()
}
pub fn is_server_player(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn invulnerable(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: damage_immunity::server_player_immunity(self)
}
pub fn dead_or_dying(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(io::Error::other("combat binding supplies health predicate"))
}
pub fn tag(self: *Self, _: *mut State, tag: HurtTag) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.source.hurt_tag(tag))
}
pub fn fire_resistance(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.status.fire_resistance)
}
pub fn hurt_start(self: *Self, _: *mut State, damage: *mut f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let source = HurtSource {
    // rust: damage_type: &self.source.definition().name,
    // rust: causing: self.causing,
    // rust: direct: 0,
}
    // rust: let canceled = hurt_server_canceled(Hurting::Player(self.entity, source), damage);
    // rust: self.canceled |= canceled;
    // rust: Ok(canceled)
}
pub fn sleeping(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn stop_sleeping(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn use_item(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn apply_blocking(self: *Self, _: *mut State, damage: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(b) = &self.blocking else {
    // rust: return Ok(0.0);
}
    // rust: if damage <= 0.0 || b.bypassed || b.pierce {
    // rust: return Ok(0.0);
}
    // rust: self.blocked = b.rules.resolve(&mut MatchedSets, damage, b.angle)?;
    // rust: self.fully_blocked = self.blocked >= damage;
    // rust: Ok(self.blocked)
}
pub fn freeze_hurts_extra(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn helmet_empty(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(true)
}
pub fn hurt_helmet(self: *Self, _: *mut State, _: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn actually_hurt(self: *Self, _: *mut State, _: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(io::Error::other("combat binding supplies inner damage"))
}
pub fn resolve_mob(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn resolve_player(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn blocking_component(self: *Self, _: () void {
}
    // rust: self.blocking.as_ref().map(|_| ())
}
pub fn on_blocked(self: *Self, _: *mut State, _: () void {
}
    // rust: self.block_sound = true;
    // rust: Ok(())
}
pub fn broadcast_damage(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.event(HealthEvent::DamageBroadcast {
    // rust: source: self.source.type_id(),
    // rust: });
    // rust: Ok(())
}
pub fn mark_hurt(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self.sync_velocity = true;
    // rust: Ok(())
}
    /// The caller applies it: these sources carry no entity or position.
pub fn knockback(self: *Self, _: *mut State, _: f32, _: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.knocked = true;
    // rust: Ok(())
}
pub fn death_protection(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.totem
    // rust: || self
    // rust: .source
    // rust: .immunity_tag(ImmunityTag::BypassesInvulnerability)
    // rust: {
    // rust: return Ok(false);
}
    // rust: self.totem_fired = true;
    // rust: Ok(true)
}
pub fn death_sound(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn make_sound(self: *Self, _: *mut State, _: () void {
}
    // rust: self.phase("death-sound")
}
pub fn secondary_sound(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.source.definition().effects == "thorns" {
    // rust: self.phase("thorns-sound")?;
}
    // rust: Ok(())
}
pub fn die(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self.dead = true;
    // rust: self.phase("death-request")
}
    /// `Player.playSound` leaves the player itself out: others hear this one.
pub fn hurt_sound(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.block_sound {
    // rust: let sound = hurt_sound(&self.source.definition().effects);
    // rust: self.events.push(MotionEvent::HurtSound(sound));
}
    // rust: self.phase("hurt-sound")
}
pub fn game_time(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.game_time)
}
pub fn effects_on_hurt(self: *Self, _: *mut State, _: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
    // rust: fn player_hurt_criterion(
    // rust: &mut self,
    // rust: _: &mut State,
    // rust: original: f32,
    // rust: amount: f32,
    // rust: blocked: bool,
    // rust: ) -> io::Result<()> {
    // rust: self.event(HealthEvent::Criterion {
    // rust: original,
    // rust: amount,
    // rust: blocked,
    // rust: });
    // rust: Ok(())
}
pub fn award_blocked(self: *Self, _: *mut State, amount: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stat("blocked", amount)
}
pub fn attacker_criterion(self: *Self, _: *mut State, _: f32, _: f32, _: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
}
    // rust: impl PlayerHurtWorld for Environment<'_> {
pub fn ability_invulnerable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.invulnerable
}
pub fn bypasses_invulnerability(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.source.in_tag("minecraft:bypasses_invulnerability"))
}
pub fn remove_shoulders(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn scales_with_difficulty(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
        // DamageSource.scalesWithDifficulty.
    // rust: Ok(match self.source.definition().scaling {
    // rust: Scaling::Never => false,
    // rust: Scaling::Always => true,
    // rust: Scaling::LivingNonPlayer => self.living_cause,
    // rust: })
}
pub fn difficulty(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.rules.difficulty)
}
}
    // rust: impl ServerPlayerHurtWorld for Environment<'_> {
    // rust: type Player = ();
    // rust: type Arrow = ();
pub fn causing_entity(self: *Self, _: *mut State) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(CausingEntity::Other)
}
pub fn arrow_player_owner(self: *Self, _: *mut State, _: () void {
}
    // rust: Ok(None)
}
pub fn can_harm_player(self: *Self, _: *mut State, _: () void {
}
    // rust: Ok(true)
}
}

    // rust: mod datapack_tests;

    // rust: mod tests {
pub fn knockback_attacker_scopes_restore_on_return_and_unwind() void {
}
    // rust: assert_eq!(super::knockback_attacker(), 0);
    // rust: {
    // rust: let _outer = super::knockback_from(7);
    // rust: let panic = std::panic::catch_unwind(|| {
    // rust: let _inner = super::knockback_from(9);
    // rust: assert_eq!(super::knockback_attacker(), 9);
    // rust: panic!("test unwind");
    // rust: });
    // rust: assert!(panic.is_err());
    // rust: assert_eq!(super::knockback_attacker(), 7);
    // rust: assert_eq!(
    // rust: std::thread::spawn(super::knockback_attacker)
    // rust: .join()
    // rust: .unwrap(),
    // rust: 0
    // rust: );
}
    // rust: assert_eq!(super::knockback_attacker(), 0);
}
pub fn a_hit_in_the_hurt_cooldown_knocks_nobody_back() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let mut player =
    // rust: crate::motion::PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .unwrap();
    // rust: let (health, rules) = (&resources.health, super::HealthRules::default());
    // rust: let id = health.damage.id("minecraft:mob_attack").unwrap();
    // rust: let mut hit = |amount| {
    // rust: player
    // rust: .hurt_blocking(health, rules, id, amount, None)
    // rust: .unwrap()
}
    // rust: let first = hit(1.0);
    // rust: assert!(first.hurt && first.knockback);
        // A stronger hit inside the cooldown hurts by the difference only
        // (LivingEntity.hurtServer), with no dealDefaultKnockback.
    // rust: let second = hit(2.0);
    // rust: assert!(second.hurt && !second.knockback);
        // A weaker one doesn't hurt at all.
    // rust: let third = hit(1.5);
    // rust: assert!(!third.hurt && !third.knockback);
}

    /// #2800: on Easy a mob's 4 is scaled to 3 before `applyItemBlocking`,
    /// so a shield that stops all 3 blocks fully (`damageBlocked >= damage`)
    /// and `blockedByItem` must not pull the player toward the mob.
pub fn a_shield_fully_blocks_a_hit_scaled_down_by_easy() void {
}
//         use horizon_world::blocking_rules::{BlockingRules, DamageReduction, ItemDamageFunction};
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let mut player =
    // rust: crate::motion::PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .unwrap();
    // rust: let health = &resources.health;
    // rust: let rules = super::HealthRules {
    // rust: difficulty: horizon_world::food::Difficulty::Easy,
    // rust: ..Default::default()
}
    // rust: let shield = super::Blocking {
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
    // rust: let id = health.damage.id("minecraft:mob_attack").unwrap();
    // rust: let o = player
    // rust: .hurt_caused_by(health, rules, id, 4.0, Some(shield), true, 0)
    // rust: .unwrap();
    // rust: assert_eq!(o.blocked, 3.0, "Easy scales 4 to 3 before the shield");
    // rust: assert!(o.fully_blocked && !o.knockback);
}

    /// #7309: on Hard a mob's 4 is scaled to 6 (`Player.hurtServer`), on
    /// Normal it stays 4, and a non-mob source is never scaled.
pub fn hard_scales_a_mob_hit_by_one_and_a_half() void {
}
//         use horizon_world::food::Difficulty;
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let health = &resources.health;
    // rust: let id = health.damage.id("minecraft:mob_attack").unwrap();
    // rust: let lost = |difficulty, living| {
    // rust: let mut player =
    // rust: crate::motion::PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .unwrap();
    // rust: let rules = super::HealthRules {
    // rust: difficulty,
    // rust: ..Default::default()
}
    // rust: let before = player.health.health();
    // rust: player
    // rust: .hurt_caused_by(health, rules, id, 4.0, None, living, 0)
    // rust: .unwrap();
    // rust: before - player.health.health()
}
    // rust: assert_eq!(lost(Difficulty::Hard, true), 6.0);
    // rust: assert_eq!(lost(Difficulty::Normal, true), 4.0);
    // rust: assert_eq!(lost(Difficulty::Easy, true), 3.0);
    // rust: assert_eq!(lost(Difficulty::Hard, false), 4.0);
}

    /// #2141: an arrow that takes the last of the player's health must kill
    /// them: `LivingEntity.hurt` leaves the health at zero and `Player.die`
    /// follows.
pub fn an_arrow_kills_a_player_at_one_health() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let mut player =
    // rust: crate::motion::PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .unwrap();
    // rust: player.set_health(1.0, false).unwrap();
    // rust: let (health, rules) = (&resources.health, super::HealthRules::default());
    // rust: let id = health.damage.id("minecraft:arrow").unwrap();
    // rust: let hurt = player.hurt(health, rules, id, 5.0).unwrap();
    // rust: assert!(hurt, "the arrow must hurt");
    // rust: assert_eq!(player.health.health(), 0.0, "the health must be spent");
    // rust: assert!(player.health.dead_or_dying(), "the player must be dead");
}

    /// What the hook of these tests saw: entity, damage type (a mob's kind)
    /// and causing entity, amount.
pub const SEEN: std::sync::Mutex<std.ArrayList((i32, []const u8, f32))> = std::sync::Mutex::new(Vec::new());
    /// Sets the native damage hook of these tests (global: it stays set for
    /// the process): for entities 9001 to 9004 and 9011 to 9013 it records the
    /// hit, cancels x1's, doubles x2's, makes 9003's -5 and 9004's NaN.
pub fn set_hook() f {
    // Implementation ported from Horizon
    return undefined;
}
//         use super::Hurting;
pub fn hook(hurting: Hurting<'_>, amount: *mut f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (entity, seen) = match hurting {
    // rust: Hurting::Player(e, s) | Hurting::Dragon(e, s) | Hurting::ArmorStand(e, s) => {
    // rust: (e, format!("{} {}", s.damage_type, s.causing))
}
    // rust: Hurting::Mob(mob, source) => (mob.id as i32, format!("{:?}", source.kind)),
}
    // rust: if !matches!(entity, 9001..=9004 | 9011..=9013) {
    // rust: return false;
}
    // rust: SEEN.lock().unwrap().push((entity, seen, *amount));
    // rust: match entity {
    // rust: 9002 | 9012 => *amount *= 2.0,
    // rust: 9003 => *amount = -5.0,
    // rust: 9004 => *amount = f32::NAN,
    // rust: _ => {}
}
    // rust: entity % 10 == 1
}
    // rust: let installed = *super::HURT_SERVER.get_or_init(|| hook);
    // rust: assert!(std::ptr::fn_addr_eq(
    // rust: installed,
    // rust: hook as fn(Hurting<'_>, &mut f32) -> bool
    // rust: ));
    // rust: |entity| {
    // rust: let seen = SEEN.lock().unwrap();
    // rust: let hits = seen.iter().filter(|s| s.0 == entity);
    // rust: hits.map(|s| (s.1.clone(), s.2)).collect()
}
}

pub fn the_native_damage_hook_changes_or_cancels_a_mobs_hit() void {
}
//         use crate::mobs::{Damage, DamageKind, Mob};
    // rust: let seen = set_hook();
    // rust: let mob = |id| {
    // rust: Mob::new(
    // rust: id,
    // rust: crate::mobs::sensor_scan_tests::kind(),
    // rust: Default::default(),
    // rust: 0.0,
    // rust: )
}
    // rust: let hit = Damage {
    // rust: kind: DamageKind::PlayerAttack,
    // rust: attacker: None,
    // rust: from: Some([3.0, 0.0, 0.0]),
    // rust: attacker_species: None,
}
        // Canceled: no damage, cooldown, sound or knockback.
    // rust: let mut kept = mob(9001);
    // rust: assert!(!kept.damage(2.0, hit));
    // rust: assert_eq!(
    // rust: (kept.health, kept.invulnerable, kept.hurt_time),
    // rust: (10.0, 0, 0)
    // rust: );
    // rust: assert!(kept.outbox.is_empty() && kept.velocity == Default::default());
    // rust: assert_eq!(seen(9001), [("PlayerAttack".to_owned(), 2.0)]);
    // rust: let mut doubled = mob(9002);
    // rust: assert!(doubled.damage(2.0, hit));
    // rust: assert_eq!(doubled.health, 6.0);
        // LivingEntity.hurtServer: a negative amount hurts by 0, a NaN by
        // Float.MAX_VALUE.
    // rust: let (mut negative, mut nan) = (mob(9003), mob(9004));
    // rust: assert!(negative.damage(2.0, hit) && nan.damage(2.0, hit));
    // rust: assert!(negative.health == 10.0 && nan.health <= 0.0);
}

    /// Needs the prepared data in `.local/horizon-client/26.3`; skipped
    /// without it.
pub fn the_native_damage_hook_changes_or_cancels_a_players_hit() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let seen = set_hook();
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let (health, rules) = (&resources.health, super::HealthRules::default());
    // rust: let id = health.damage.id("minecraft:arrow").unwrap();
    // rust: let player = |entity| {
    // rust: let mut p = crate::motion::PlayerMotion::new(&resources, Default::default()).unwrap();
    // rust: p.entity_id = entity;
    // rust: p
}
    // rust: let mut kept = player(9011);
    // rust: assert!(!kept.hurt(health, rules, id, 5.0).unwrap());
    // rust: assert_eq!((kept.health.health(), kept.health.hurt.cooldown), (20.0, 0));
    // rust: let mut doubled = player(9012);
    // rust: assert!(doubled.hurt(health, rules, id, 5.0).unwrap());
    // rust: assert_eq!(doubled.health.health(), 10.0);
        // The causing mob when it is known, else 0.
    // rust: let hurt = player(9013).hurt_caused_by(health, rules, id, 5.0, None, false, 44);
    // rust: assert!(hurt.unwrap().hurt);
    // rust: assert_eq!(seen(9011), [("minecraft:arrow 0".to_owned(), 5.0)]);
    // rust: assert_eq!(seen(9013), [("minecraft:arrow 44".to_owned(), 5.0)]);
}

    /// What the knockback hook of these tests saw: the entity, the hit that
    /// causes it (a mob's damage kind) and the push it was handed.
    // rust: static PUSHES: std::sync::Mutex<Vec<(i32, String, super::Knock)>> =
    // rust: std::sync::Mutex::new(Vec::new());
    /// Sets the native knockback hook of these tests (global: it stays set for
    /// the process), for mobs 9101 to 9106 only: it records the push, cancels
    /// 9101's, doubles 9102's strength and turns its direction around, leaves
    /// 9103 non-finite numbers, and gives 9105 (whose resistance leaves
    /// nothing) a strength of 0.4.
pub fn set_knockback_hook() f {
    // Implementation ported from Horizon
    return undefined;
}
//         use super::{Hurting, Knock};
pub fn hook(pushed: Hurting<'_>, knock: *mut Knock) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Hurting::Mob(mob, source) = pushed else {
    // rust: return false;
}
    // rust: let entity = mob.id as i32;
    // rust: if !(9101..=9106).contains(&entity) {
    // rust: return false;
}
    // rust: let hit = format!("{:?}", source.kind);
    // rust: PUSHES.lock().unwrap().push((entity, hit, *knock));
    // rust: match entity {
    // rust: 9101 => return true,
    // rust: 9102 => {
    // rust: knock.strength *= 2.0;
    // rust: knock.x = -knock.x;
}
    // rust: 9103 => {
    // rust: knock.strength = f64::NAN;
    // rust: knock.x = f64::INFINITY;
    // rust: knock.z = f64::NEG_INFINITY;
}
    // rust: 9105 => knock.strength = 0.4,
    // rust: _ => {}
}
    // rust: false
}
    // rust: let installed = *super::KNOCKBACK.get_or_init(|| hook);
    // rust: assert!(std::ptr::fn_addr_eq(
    // rust: installed,
    // rust: hook as fn(Hurting<'_>, &mut Knock) -> bool
    // rust: ));
    // rust: |entity| {
    // rust: let seen = PUSHES.lock().unwrap();
    // rust: let pushes = seen.iter().filter(|p| p.0 == entity);
    // rust: pushes.map(|p| (p.1.clone(), p.2)).collect()
}
}

    /// A zombie in full netherite (0.1 a piece) is pushed 60 % as far as one
    /// with no armour: `knockback` scales by the attribute's value with the
    /// gear's modifiers, which the game hands the mob as `gear_knockback_resistance`.
pub fn a_mobs_gear_resists_knockback() void {
}
//         use crate::mobs::{Damage, Mob};
    // rust: let hit = Damage::player([3.0, 0.0, 0.0]);
    // rust: let pushed = |gear: Option<f64>, own: f64| {
    // rust: let mut m = Mob::new(
    // rust: 9200,
    // rust: crate::mobs::sensor_scan_tests::kind(),
    // rust: Default::default(),
    // rust: 0.0,
    // rust: );
    // rust: m.on_ground = true;
    // rust: m.attrs.knockback_resistance = own;
    // rust: m.gear_knockback_resistance = gear;
    // rust: m.knockback(0.4, 3.0, 0.0, &hit);
    // rust: m.velocity.x
}
    // rust: assert_eq!(pushed(None, 0.0), -0.4);
    // rust: assert!((pushed(Some(0.4), 0.0) - -0.4 * 0.6).abs() < 1e-12);
        // The gear's value is the whole attribute: it replaces the mob's own.
    // rust: assert!((pushed(Some(0.4), 0.5) - -0.4 * 0.6).abs() < 1e-12);
}
    /// `LivingEntity.knockback`: the hook runs before knockback resistance
    /// takes its share and before motion changes; a mod's strength or
    /// direction is what pushes, a cancel pushes nothing, and with no mod in
    /// the way the push is vanilla's. Expected values are worked out by hand
    /// from vanilla's formula: the horizontal speed halves and the push is
    /// subtracted along the normalized direction; on the ground the vertical
    /// speed becomes `min(0.4, vy / 2 + strength)`.
pub fn the_native_knockback_hook_changes_or_cancels_a_mobs_push() void {
}
//         use super::Knock;
//         use crate::mobs::{Damage, Mob};
    // rust: let seen = set_knockback_hook();
    // rust: let mob = |id, resistance| {
    // rust: let mut m = Mob::new(
    // rust: id,
    // rust: crate::mobs::sensor_scan_tests::kind(),
    // rust: Default::default(),
    // rust: 0.0,
    // rust: );
    // rust: m.on_ground = true;
    // rust: m.attrs.knockback_resistance = resistance;
    // rust: m
}
    // rust: let velocity = |m: &Mob| (m.velocity.x, m.velocity.y, m.velocity.z);
    // rust: let hit = Damage::player([3.0, 0.0, 0.0]);
    // rust: let push = |id, resistance| {
    // rust: let mut m = mob(id, resistance);
    // rust: m.knockback(0.4, 3.0, 0.0, &hit);
    // rust: m
}
        // No mod in the way (the hook leaves 9100 alone): vanilla's push, away from x = 3.
    // rust: let plain = push(9100, 0.0);
    // rust: assert_eq!(velocity(&plain), (-0.4, 0.4, 0.0));
    // rust: assert!(plain.needs_sync);
        // Canceled: no motion, no resync. The hook saw the push the game made.
    // rust: let kept = push(9101, 0.0);
    // rust: assert_eq!(velocity(&kept), (0.0, 0.0, 0.0));
    // rust: assert!(!kept.needs_sync);
    // rust: let made = Knock {
    // rust: strength: 0.4,
    // rust: x: 3.0,
    // rust: z: 0.0,
}
    // rust: assert_eq!(seen(9101), [("PlayerAttack".to_owned(), made)]);
        // A stronger push the other way: twice the strength, x turned around.
    // rust: let turned = push(9102, 0.0);
    // rust: assert_eq!(velocity(&turned), (0.8, 0.4, 0.0));
    // rust: assert_eq!(velocity(&push(9102, 0.5)), (0.4, 0.4, 0.0));
        // Numbers that are not finite are put back as the game made them.
    // rust: assert_eq!(velocity(&push(9103, 0.0)), (-0.4, 0.4, 0.0));
        // Before the resistance (`LivingKnockBackEvent`): the hook is handed the raw 0.4, and
        // the push that follows is halved.
    // rust: let resisted = push(9104, 0.5);
    // rust: assert_eq!(velocity(&resisted), (-0.2, 0.2, 0.0));
    // rust: assert_eq!(seen(9104)[0].1.strength, 0.4);
        // A full resistance takes all of what the hook leaves: no push.
    // rust: let stopped = push(9105, 1.0);
    // rust: assert_eq!(seen(9105)[0].1.strength, 0.4);
    // rust: assert_eq!(velocity(&stopped), (0.0, 0.0, 0.0));
        // The game's own hit on a mob reaches the hook with its damage.
    // rust: let mut hurt = mob(9106, 0.0);
    // rust: assert!(hurt.damage(2.0, hit));
        // dealDefaultKnockback pushes with the float 0.4F.
    // rust: let strength = f64::from(0.4_f32);
    // rust: assert_eq!(velocity(&hurt), (-strength, 0.4, 0.0));
    // rust: let made = Knock { strength, ..made };
    // rust: assert_eq!(seen(9106), [("PlayerAttack".to_owned(), made)]);
}

    /// #4301: `ServerPlayer.isInvulnerableTo`'s `!connection.hasClientLoaded`
    /// term spares a respawned player the void until the client has loaded the
    /// world; once it has, the void hurts again.
pub fn the_void_spares_a_player_whose_client_has_not_loaded() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let mut player =
    // rust: crate::motion::PlayerMotion::new(&resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .unwrap();
    // rust: let (health, rules) = (&resources.health, super::HealthRules::default());
    // rust: let id = health.damage.id("minecraft:out_of_world").unwrap();
    // rust: player.client_loaded = false;
    // rust: assert!(
    // rust: !player.hurt(health, rules, id, 4.0).unwrap(),
    // rust: "an unloaded client must not take void damage"
    // rust: );
    // rust: assert_eq!(player.health.health(), 20.0);
    // rust: player.client_loaded = true;
    // rust: assert!(
    // rust: player.hurt(health, rules, id, 4.0).unwrap(),
    // rust: "a loaded client takes the void's 4.0"
    // rust: );
    // rust: assert_eq!(player.health.health(), 16.0);
}

pub fn hurt_sounds_follow_damage_effects() void {
}
        // DamageEffects: HURT, THORNS, DROWNING, BURNING, POKING, FREEZING.
    // rust: for (effects, sound) in [
    // rust: ("hurt", "minecraft:entity.player.hurt"),
    // rust: ("thorns", "minecraft:entity.player.hurt"),
    // rust: ("drowning", "minecraft:entity.player.hurt_drown"),
    // rust: ("burning", "minecraft:entity.player.hurt_on_fire"),
    // rust: ("poking", "minecraft:entity.player.hurt_sweet_berry_bush"),
    // rust: ("freezing", "minecraft:entity.player.hurt_freeze"),
    // rust: ] {
    // rust: assert_eq!(super::hurt_sound(effects), sound, "{effects}");
}
}

    /// `LivingEntity.getDamageAfterArmorAbsorb` returns before
    /// `getArmorValue` and `getAttributeValue(ARMOR_TOUGHNESS)` for a source in
    /// `#minecraft:bypasses_armor`, and native `AttributeInstance.getValue` is
    /// what clears an instance's dirty flag. A hit must therefore leave both
    /// instances dirty with creation's zero cache when it bypasses the armour,
    /// and recompute them when it does not.
pub fn a_bypassing_hit_leaves_the_armor_instances_dirty() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = crate::assets::Assets::load(&root).unwrap();
    // rust: let resources = crate::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let (health, rules) = (&resources.health, super::HealthRules::default());
        // `setBaseValue` is what a command or a spawn uses; a base other than
        // the attribute's default is what makes the fresh instance's cache
        // stale, and it is the value a recompute would produce.
    // rust: let armoured = |resources: &crate::motion::MotionResources| {
    // rust: let mut player =
    // rust: crate::motion::PlayerMotion::new(resources, horizon_core::geometry::Vec3::ZERO)
    // rust: .unwrap();
    // rust: let mut handles = Vec::new();
    // rust: for name in ["minecraft:armor", "minecraft:armor_toughness"] {
    // rust: let key = player.attributes.key(name).unwrap();
    // rust: let handle = player
    // rust: .attributes
    // rust: .get_instance(Some(key))
    // rust: .unwrap()
    // rust: .expect("the player supplier has this attribute");
    // rust: player
    // rust: .attributes
    // rust: .edit(&handle, |a, o| a.set_base_value(7.0, o))
    // rust: .unwrap();
    // rust: handles.push(handle);
}
    // rust: (player, handles)
}
    // rust: let states = |player: &crate::motion::PlayerMotion,
    // rust: handles: &[horizon_world::attributes::live::Handle]| {
    // rust: handles
    // rust: .iter()
    // rust: .map(|handle| {
    // rust: let a = player.attributes.instance(handle).unwrap();
    // rust: (a.base_value(), a.is_dirty(), a.cached_value())
    // rust: })
    // rust: .collect::<Vec<_>>()
}
        // `minecraft:fall` is in the tag: neither instance is read.
    // rust: let (mut bypassing, bypassing_handles) = armoured(&resources);
    // rust: let fall = health.damage.id("minecraft:fall").unwrap();
    // rust: assert!(bypassing.hurt(health, rules, fall, 5.0).unwrap());
    // rust: assert_eq!(
    // rust: states(&bypassing, &bypassing_handles),
    // rust: [(7.0, true, 0.0), (7.0, true, 0.0)],
    // rust: "a bypassing hit must leave both instances dirty and uncached"
    // rust: );
    // rust: let record = bypassing.hurt_log.last().unwrap();
    // rust: assert_eq!(
    // rust: (record.armor, record.toughness),
    // rust: (0.0, 0.0),
    // rust: "the hit reports the cache it left"
    // rust: );
        // `minecraft:mob_attack` is not: `getDamageAfterAbsorb` asks for both
        // values, so the hit recomputes them and the record reads them back.
    // rust: let (mut meeting, meeting_handles) = armoured(&resources);
    // rust: let attack = health.damage.id("minecraft:mob_attack").unwrap();
    // rust: assert!(meeting.hurt(health, rules, attack, 5.0).unwrap());
    // rust: assert_eq!(
    // rust: states(&meeting, &meeting_handles),
    // rust: [(7.0, false, 7.0), (7.0, false, 7.0)],
    // rust: "a hit the armour meets must recompute both instances"
    // rust: );
    // rust: let record = meeting.hurt_log.last().unwrap();
    // rust: assert_eq!((record.armor, record.toughness), (7.0, 7.0));
}
}
