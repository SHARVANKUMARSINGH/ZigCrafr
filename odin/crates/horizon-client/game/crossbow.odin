//! Transpiled from Horizon Rust crate
package horizon_client_crossbow

import "core:fmt"
import "core:mem"
import "core:math"

// Crossbows (`CrossbowItem`): charging with the start/middle/end sounds
// (Quick Charge), loading arrows or a held firework rocket into
// `charged_projectiles` (Multishot loads three), and shooting critical
// arrows at power 3.15, or rockets at 1.6 for three durability, with the
// fanned Multishot angles and their shot pitches. `Player.getProjectile`
// finds the ammo for bows and crossbows.
// use super::{Game, shield::OFFHAND_SLOT, view_vector};
// use horizon_client::{
    // rust: enchant::EffectContext,
    // rust: items::ItemStack,
    // rust: mobs::Who,
    // rust: projectiles::{Projectile, ProjectileKind},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};

CROSSBOW :: "minecraft:crossbow"
FIREWORK_ROCKET :: "minecraft:firework_rocket"
ARROW :: "minecraft:arrow"

// What `getProjectile` returned: the ammunition and, while it is still the
// stack found in the inventory, the slot it is taken from.
    // rust: pub(super) struct Ammo {
    // rust: pub(super) stack: ItemStack,
    // rust: pub(super) slot: Option<usize>,
}

// `ProjectileWeaponItem.ARROW_ONLY`, for the arrows Horizon shoots.
is_arrow :: proc(stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: &*stack.item,
    // rust: "minecraft:arrow" | "minecraft:spectral_arrow" | "minecraft:tipped_arrow"
    // rust: )
}

// `Player.getProjectile`: what `weapon` supports in the off hand, then in
// the main hand (`getHeldProjectile`; crossbows also take firework rockets
// there), else the first arrows in the inventory. The slot of the stack.
    // rust: fn projectile_slot(
    // rust: weapon: &str,
    // rust: hands: [(usize, Option<&ItemStack>); 2],
    // rust: inventory: &[Option<ItemStack>],
    // rust: ) -> Option<usize> {
    // rust: let held = |s: &ItemStack| is_arrow(s) || weapon == CROSSBOW && &*s.item == FIREWORK_ROCKET;
    // rust: hands
    // rust: .into_iter()
    // rust: .find_map(|(slot, s)| s.is_some_and(held).then_some(slot))
    // rust: .or_else(|| {
    // rust: inventory
    // rust: .iter()
    // rust: .position(|s| s.as_ref().is_some_and(is_arrow))
    // rust: })
}

// `CrossbowItem.onUseTick`'s loading sounds for a charge now at `charge`
// (of `getChargeDuration`) that has played `played` so far: the start and
// middle sounds each play once the charge reaches their point, and both
// count as unheard again while the charge is under the first one. A tick
// that jumped the charge past a point still plays that point's sound, as
// vanilla's two flags do. Returns the flags for the next tick and the
// sounds to play now.
    // rust: fn charge_sounds(
    // rust: charge: f32,
    // rust: played: [bool; 2],
    // rust: sounds: [&'static str; 3],
    // rust: ) -> ([bool; 2], Option<&'static str>, Option<&'static str>) {
    // rust: let mut played = if charge < 0.2 { [false; 2] } else { played };
    // rust: let mut play = [None; 2];
    // rust: for (i, point) in [0.2, 0.5].into_iter().enumerate() {
    // rust: if charge >= point && !played[i] && !sounds[i].is_empty() {
    // rust: played[i] = true;
    // rust: play[i] = Some(sounds[i]);
}
}
    // rust: (played, play[0], play[1])
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn charge_ticks(stack: &ItemStack) -> u32 {
        // crossbow_charge_time: 1.25 s, minus 0.25 s per Quick Charge level.
    // rust: let seconds = 1.25 - 0.25 * stack.enchantment_level("minecraft:quick_charge") as f32;
    // rust: (seconds.max(0.0) * 20.0).floor() as u32
}
charging_sounds :: proc(stack: ^ItemStack) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match stack.enchantment_level("minecraft:quick_charge") {
    // rust: 0 => [
    // rust: "minecraft:item.crossbow.loading_start",
    // rust: "minecraft:item.crossbow.loading_middle",
    // rust: "minecraft:item.crossbow.loading_end",
    // rust: ],
    // rust: 1 => [
    // rust: "minecraft:item.crossbow.quick_charge_1",
    // rust: "",
    // rust: "minecraft:item.crossbow.loading_end",
    // rust: ],
    // rust: 2 => [
    // rust: "minecraft:item.crossbow.quick_charge_2",
    // rust: "",
    // rust: "minecraft:item.crossbow.loading_end",
    // rust: ],
    // rust: _ => [
    // rust: "minecraft:item.crossbow.quick_charge_3",
    // rust: "",
    // rust: "minecraft:item.crossbow.loading_end",
    // rust: ],
}
}
    // `Player.getProjectile` for `weapon` (`projectile_slot`).
    // rust: pub(super) fn projectile_slot(&self, weapon: &str) -> Option<usize> {
    // rust: let hands = [OFFHAND_SLOT, self.selected].map(|slot| (slot, self.stack_in(slot)));
    // rust: projectile_slot(weapon, hands, &self.inventory)
}
    // `Player.getProjectile` for `weapon`, as `LivingGetProjectileEvent` leaves
    // it: a creative player without arrows has `hasInfiniteMaterials`' arrow.
    // rust: pub(super) fn get_projectile(&mut self, weapon: &ItemStack) -> Option<Ammo> {
    // rust: let slot = self.projectile_slot(&weapon.item);
    // rust: let vanilla = match slot {
    // rust: Some(i) => self.stack_in(i).cloned(),
    // rust: None => self.creative.then(|| ItemStack::new(ARROW, 1)),
}
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: return vanilla.map(|stack| Ammo { stack, slot });
}
    // rust: let mut projectile = vanilla.clone();
        // A client predicting its own use has the profile it logged in with.
    // rust: let player = match self
    // rust: .remote
    // rust: .as_ref()
    // rust: .filter(|_| self.lan_acting_uuid.is_none())
    // rust: {
    // rust: Some(r) => r.profile(),
    // rust: None => horizon_client::lan::playerdata::ints_uuid(self.acting_player_uuid()),
}
    // rust: let name = self.own_profile_name();
    // rust: self.native_living_get_projectile(
    // rust: Some(player),
    // rust: &name,
    // rust: None,
    // rust: "minecraft:player",
    // rust: weapon,
    // rust: &mut projectile,
    // rust: );
    // rust: let slot = slot.filter(|_| projectile == vanilla);
    // rust: projectile.map(|stack| Ammo { stack, slot })
}
    // `AbstractSkeleton.performRangedAttack`'s `getProjectile`: the arrow
    // `mob` shot becomes the replaced ammunition's (`ProjectileUtil.getMobArrow`).
    // rust: pub(super) fn mob_bow_ammo(&mut self, mob: u32, weapon: &ItemStack, arrow: &mut Projectile) {
    // rust: if horizon_client::mod_api::mods().is_empty() {
    // rust: return;
}
    // rust: let Some(shooter) = self.mobs.iter().find(|m| m.id == mob) else {
    // rust: return;
}
    // rust: let kind = shooter.kind.id.clone();
    // rust: let vanilla = Self::mob_vanilla_ammo(&shooter.extra, weapon);
    // rust: let mut projectile = Some(vanilla.clone());
    // rust: self.native_living_get_projectile(None, "", Some(mob), &kind, weapon, &mut projectile);
    // rust: let Some(ammo) = projectile.filter(|ammo| *ammo != vanilla && is_arrow(ammo)) else {
    // rust: return;
}
    // rust: Self::arrow_from_ammo(&ammo, arrow);
}
    // `Monster.getProjectile`: the projectile `weapon` supports in the off
    // hand, then the main hand (`getHeldProjectile`), else a new arrow.
mob_vanilla_ammo :: proc(extra: ^horizon_client::mobs::Extra, weapon: ^ItemStack) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let supported =
    // rust: |s: &ItemStack| is_arrow(s) || &*weapon.item == CROSSBOW && &*s.item == FIREWORK_ROCKET;
    // rust: extra
    // rust: .off_hand
    // rust: .as_deref()
    // rust: .map(|item| ItemStack::new(item, 1))
    // rust: .into_iter()
    // rust: .chain(extra.main_hand_stack().cloned())
    // rust: .find(supported)
    // rust: .unwrap_or_else(|| ItemStack::new(ARROW, 1))
}
    // `ProjectileUtil.getMobArrow`: `arrow` carries `ammo`'s item and effect.
    // rust: pub(super) fn arrow_from_ammo(ammo: &ItemStack, arrow: &mut Projectile) {
    // rust: if let ProjectileKind::Arrow { effect, .. } = &mut arrow.kind {
    // rust: if &*ammo.item == "minecraft:spectral_arrow" {
    // rust: *effect = Some(("minecraft:glowing", 200));
    // rust: } else if effect.is_none()
    // rust: && let Some(tipped) = super::dispenser::tipped_effect(ammo)
    // rust: {
                // Stray.getArrow and Bogged.getArrow add their effect to the tipped arrow.
    // rust: *effect = Some(tipped);
}
}
    // rust: if let Some(a) = arrow.arrow.as_mut() {
    // rust: a.set_item(&horizon_client::arrows::drawn_ammo(ammo, false));
}
}
    // `CrossbowItem.onUseTick`'s `getProjectile` for a mob that finished
    // charging `weapon` (pillagers and piglins: `Monster.getProjectile`). The
    // replaced ammunition is what the crossbow holds; none leaves it uncharged
    // and returns false (`tryLoadProjectiles`).
    // rust: pub(super) fn mob_crossbow_ammo(&mut self, mob: u32, weapon: &ItemStack) -> bool {
    // rust: let Some(shooter) = self.mobs.iter().find(|m| m.id == mob) else {
    // rust: return false;
}
    // rust: let kind = shooter.kind.id.clone();
    // rust: let mut projectile = Some(Self::mob_vanilla_ammo(&shooter.extra, weapon));
    // rust: self.native_living_get_projectile(None, "", Some(mob), &kind, weapon, &mut projectile);
        // A crossbow takes arrows and firework rockets only.
    // rust: let projectile = projectile.filter(|ammo| is_arrow(ammo) || &*ammo.item == FIREWORK_ROCKET);
    // rust: let Some(shooter) = self.mobs.iter_mut().find(|m| m.id == mob) else {
    // rust: return false;
}
    // rust: let Some(mut crossbow) = shooter.extra.main_hand_stack().cloned() else {
    // rust: return false;
}
    // rust: let loaded = projectile.is_some();
    // rust: crossbow.data_mut().charged = projectile
    // rust: .iter()
    // rust: .map(|ammo| horizon_client::arrows::drawn_ammo(ammo, false))
    // rust: .collect();
    // rust: crossbow.tidy();
    // rust: shooter.extra.set_main_hand_stack(Some(crossbow));
    // rust: loaded
}
    // `CrossbowItem.use`: shoot when charged, else start charging.
    // rust: pub(super) fn use_crossbow(&mut self, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != CROSSBOW {
    // rust: return false;
}
        // Use is not re-triggered while the crossbow is still held charging.
    // rust: if self.using.is_some() {
    // rust: return true;
}
    // rust: if stack.data().is_some_and(|d| !d.charged.is_empty()) {
    // rust: self.shoot_crossbow();
    // rust: } else if self.get_projectile(stack).is_some() {
    // rust: self.start_using_item();
}
    // rust: true
}
    // `CrossbowItem.onUseTick` for the charge in progress.
    // rust: pub(super) fn tick_crossbow(&mut self, slot: usize, ticks: u32, stack: &ItemStack) {
        // getUseDuration - the ticks left, as a mod's Start or Tick left them.
    // rust: let held = self.ticks_held(stack, ticks);
    // rust: self.using = Some((slot, ticks + 1));
    // rust: let charge = Self::charge_ticks(stack).max(1) as f32;
    // rust: let now = (held + 1) as f32 / charge;
    // rust: let sounds = Self::charging_sounds(stack);
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: let (played, start, middle) = charge_sounds(now, self.crossbow_sounds, sounds);
    // rust: self.crossbow_sounds = played;
    // rust: if let Some(sound) = start {
    // rust: self.audio.play(sound, at, 0.5, 1.0);
}
    // rust: if let Some(sound) = middle {
    // rust: self.audio.play(sound, at, 0.5, 1.0);
}
    // rust: let charged = stack.data().is_some_and(|d| !d.charged.is_empty());
    // rust: if now >= 1.0 && !charged {
            // tryLoadProjectiles / ProjectileWeaponItem.draw.
    // rust: let shots = if stack.enchantment_level("minecraft:multishot") > 0 {
    // rust: 3
    // rust: } else {
    // rust: 1
}
    // rust: let Some(ammo) = self.get_projectile(stack) else {
    // rust: return;
}
    // rust: if !self.creative
    // rust: && let Some(i) = ammo.slot
    // rust: {
    // rust: let cell = self.stack_in_mut(i);
    // rust: if let Some(s) = cell.as_mut() {
    // rust: s.count -= 1;
    // rust: if s.count == 0 {
    // rust: *cell = None;
}
}
}
    // rust: let ammo = ammo.stack;
            // useAmmo: the extra multishot arrows and creative's are intangible.
    // rust: let drawn = (0..shots)
    // rust: .map(|i| horizon_client::arrows::drawn_ammo(&ammo, self.creative || i > 0))
    // rust: .collect();
    // rust: if let Some(bow) = self.stack_in_mut(slot).as_mut() {
    // rust: bow.data_mut().charged = drawn;
}
    // rust: let pitch = 1.0 / (self.world.random.next_float() * 0.5 + 1.0) + 0.2;
    // rust: self.audio.play(sounds[2], at, 1.0, pitch);
}
}
    // `CrossbowItem.performShooting`.
shoot_crossbow :: proc(self: ^Self) {
}
    // rust: let Some(eye) = self.eye_position() else {
    // rust: return;
}
    // rust: let Some(bow) = self.held_mut().as_mut() else {
    // rust: return;
}
    // rust: let charged = std::mem::take(&mut bow.data_mut().charged);
    // rust: bow.tidy();
    // rust: let weapon = bow.clone();
        // AbstractArrow's constructor: `getPiercingCount` of the weapon.
    // rust: let pierce = self
    // rust: .res
    // rust: .stations()
    // rust: .enchantments
    // rust: .modify_value(
    // rust: Some(&weapon),
    // rust: "minecraft:projectile_piercing",
    // rust: &EffectContext::default(),
    // rust: &mut self.world.random,
    // rust: 0.0,
    // rust: )
    // rust: .clamp(0.0, 127.0) as u8;
    // rust: let count = charged.len();
        // getShootingPower: a rocket among them slows every shot.
    // rust: let power = if charged.iter().any(|s| &*s.item == FIREWORK_ROCKET) {
    // rust: 1.6
    // rust: } else {
    // rust: 3.15
}
        // ProjectileWeaponItem.shoot: angles fanned 10 degrees apart.
    // rust: let spread = if count > 1 { 10.0 } else { 0.0 };
    // rust: let view = glam::DVec3::from_array(view_vector(self.yaw, self.pitch));
    // rust: let up = glam::DVec3::from_array(view_vector(self.yaw, self.pitch - 90.0));
    // rust: for (index, ammo) in charged.iter().enumerate() {
    // rust: let angle = if count > 1 {
    // rust: -spread + 2.0 * spread * index as f64 / (count - 1) as f64
    // rust: } else {
    // rust: 0.0
}
    // rust: let angle = if count == 3 {
    // rust: [0.0, -spread, spread][index]
    // rust: } else {
    // rust: angle
}
    // rust: let dir =
    // rust: glam::DQuat::from_axis_angle(up.normalize_or_zero(), angle.to_radians()) * view;
            // createProjectile: a rocket shot at an angle from 0.15 under the
            // eyes, spread by its own random; three durability.
    // rust: let rocket = &*ammo.item == FIREWORK_ROCKET;
    // rust: if rocket {
    // rust: let at = Vec3::new(eye[0], eye[1] - f64::from(0.15f32), eye[2]);
    // rust: let mut shot = Projectile::new(ProjectileKind::Snowball, at, None);
    // rust: shot.shoot(
    // rust: &mut super::dispenser::entity_random(),
    // rust: dir.to_array(),
    // rust: power,
    // rust: 1.0,
    // rust: );
    // rust: self.launch_angled_rocket(at, shot.velocity, ammo, Some(Who::Player));
}
    // rust: if !rocket {
    // rust: let effect = super::dispenser::tipped_effect(ammo).or_else(|| {
    // rust: (&*ammo.item == "minecraft:spectral_arrow")
    // rust: .then_some(("minecraft:glowing", 200))
    // rust: });
    // rust: let kind = ProjectileKind::Arrow {
    // rust: base_damage: 2.0,
    // rust: critical: true,
    // rust: effect,
}
    // rust: let mut arrow = Projectile::new(
    // rust: kind,
    // rust: Vec3::new(eye[0], eye[1] - 0.1, eye[2]),
    // rust: Some(Who::Player),
    // rust: );
    // rust: if let Some(a) = arrow.arrow.as_mut() {
    // rust: a.set_item(ammo);
    // rust: a.set_owner(Some(Who::Player));
    // rust: a.fired_from_weapon = Some(weapon.clone());
    // rust: a.pierce = pierce;
}
                // Flame: the arrow is spawned burning (EnchantmentHelper.onProjectileSpawned).
    // rust: self.ignite_spawned_arrow(&weapon, &mut arrow);
    // rust: arrow.shoot(&mut self.world.random, dir.to_array(), power, 1.0);
    // rust: self.add_projectile(arrow);
    // rust: let (player, name, projectile) = (
    // rust: horizon_client::lan::playerdata::ints_uuid(self.acting_player_uuid()),
    // rust: self.acting_player_name().to_owned(),
    // rust: self.next_entity,
    // rust: );
    // rust: self.native_entity_shoot_bow(player, &name, projectile, power as f32);
}
    // rust: self.player_projectile_shot();
    // rust: let pitch = if index == 0 {
    // rust: 1.0
    // rust: } else {
    // rust: let high = index & 1 == 1;
    // rust: 1.0 / (self.world.random.next_float() * 0.5 + 1.8) + if high { 0.63 } else { 0.43 }
}
            // CrossbowItem.performShooting: at the shooter's getX/Y/Z (feet).
    // rust: let feet = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map_or(eye, |pl| [pl.position.x, pl.position.y, pl.position.z]);
    // rust: self.audio
    // rust: .play("minecraft:item.crossbow.shoot", Some(feet), 1.0, pitch);
    // rust: self.damage_held(if rocket { 3 } else { 1 });
}
        // CrossbowItem.performShooting: SHOT_CROSSBOW with the crossbow, which
        // is an empty stack (no match) when the shots broke it.
    // rust: if let Some(stack) = self.held().cloned() {
    // rust: self.trigger_item("minecraft:shot_crossbow", &stack);
    // rust: self.award_stat("used", &stack.item, 1);
}
}
}

    // rust: mod tests {
//     use super::*;

    // A game on the prepared resources with a creative player.
game_with_player :: proc(root: ^std::path::Path) -> ( {
    // Ported from Horizon
    return {}
}
//         use crate::game::{Audio, Options, Progress, Settings, load_resources};
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.to_path_buf(),
    // rust: None,
    // rust: root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.to_path_buf();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let res: &'static _ = Box::leak(Box::new(loaded.resources));
    // rust: let mut game = Game::new(
    // rust: res,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.creative = true;
    // rust: game.player = Some(
    // rust: horizon_client::motion::PlayerMotion::new(
    // rust: game.motion,
    // rust: horizon_core::geometry::Vec3::new(10.5, 64.0, -3.25),
    // rust: )
    // rust: .unwrap(),
    // rust: );
    // rust: let p = game.player.as_ref().expect("a player").position;
    // rust: game.audio.capture = Some(Vec::new());
    // rust: (game, [p.x, p.y, p.z])
}

    // `BowItem.releaseUsing` and `CrossbowItem.performShooting` play the shot
    // with no player at the shooter's `getX/Y/Z`, the feet. At the eye, a
    // source a few cm from the listener pans hard to one ear while strafing
    // (#8448).
bow_and_crossbow_shots_sound_at_the_feet_not_the_eye :: proc() {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let (mut game, feet) = game_with_player(&root);
    // rust: let eye = game.eye_position().unwrap();
    // rust: assert_ne!(eye, feet);

    // rust: let bow = ItemStack::new("minecraft:bow", 1);
    // rust: game.release_bow(&bow, 20);
    // rust: let shot = game.audio.capture.take().unwrap_or_default();
    // rust: let at: Vec<_> = shot
    // rust: .iter()
    // rust: .filter(|s| s.event == "minecraft:entity.arrow.shoot")
    // rust: .map(|s| s.position)
    // rust: .collect();
    // rust: assert_eq!(at, vec![feet]);

    // rust: game.audio.capture = Some(Vec::new());
    // rust: let mut crossbow = ItemStack::new("minecraft:crossbow", 1);
    // rust: crossbow.data_mut().charged = vec![ItemStack::new(ARROW, 1)];
    // rust: *game.held_mut() = Some(crossbow);
    // rust: game.shoot_crossbow();
    // rust: let shot = game.audio.capture.take().unwrap_or_default();
    // rust: let at: Vec<_> = shot
    // rust: .iter()
    // rust: .filter(|s| s.event == "minecraft:item.crossbow.shoot")
    // rust: .map(|s| s.position)
    // rust: .collect();
    // rust: assert_eq!(at, vec![feet]);
}

    // `AbstractArrow`'s constructor runs `EnchantmentHelper.onProjectileSpawned`
    // for the weapon the arrow is fired from, bow or crossbow, so a Flame
    // crossbow shoots burning arrows: Flame's 5 second ignite, 100 ticks, on
    // every arrow of a Multishot volley (#10482).
a_flame_crossbow_shoots_burning_arrows :: proc() {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let (mut game, _) = game_with_player(&root);
        // Shoots a crossbow with `enchantments` and one arrow loaded per shot,
        // and returns how long each new arrow burns for.
    // rust: let mut shoot = |enchantments: &[&str], shots: usize| -> Vec<i32> {
    // rust: let mut crossbow = ItemStack::new(CROSSBOW, 1);
    // rust: for id in enchantments {
    // rust: crossbow.enchant(id, 1);
}
    // rust: crossbow.data_mut().charged = vec![ItemStack::new(ARROW, 1); shots];
    // rust: *game.held_mut() = Some(crossbow);
    // rust: let before = game.creatures.projectiles.len();
    // rust: game.shoot_crossbow();
    // rust: game.creatures.projectiles[before..]
    // rust: .iter()
    // rust: .map(|p| p.arrow.as_ref().expect("an arrow").fire_ticks)
    // rust: .collect()
}
    // rust: assert_eq!(shoot(&[], 1), vec![0]);
    // rust: assert_eq!(shoot(&["minecraft:flame"], 1), vec![100]);
    // rust: assert_eq!(
    // rust: shoot(&["minecraft:flame", "minecraft:multishot"], 3),
    // rust: vec![100; 3]
    // rust: );
}

    // A charge that crosses a point between two ticks plays that point's
    // sound, and one a mod's tick jumps over (`native_living_entity_use_item_tick`
    // cutting the ticks left) still plays every point it passed, as
    // `CrossbowItem.onUseTick`'s two flags do.
a_jumped_charge_still_plays_the_loading_sounds_it_passed :: proc() {
}
    // rust: let sounds = [
    // rust: "minecraft:item.crossbow.loading_start",
    // rust: "minecraft:item.crossbow.loading_middle",
    // rust: "minecraft:item.crossbow.loading_end",
    // rust: ];
        // Each step: the charge and the sounds it plays, from the flags the
        // step before left.
    // rust: let mut played = [false; 2];
    // rust: let mut step = |charge: f32| {
    // rust: let (next, start, middle) = charge_sounds(charge, played, sounds);
    // rust: played = next;
    // rust: [start, middle]
}
    // rust: assert_eq!(step(0.1), [None, None]);
    // rust: assert_eq!(step(0.25), [Some(sounds[0]), None]);
    // rust: assert_eq!(step(0.25), [None, None]);
    // rust: assert_eq!(step(0.55), [None, Some(sounds[1])]);
    // rust: assert_eq!(step(1.0), [None, None]);
        // A charge below the first point is a new charge: both sound again.
    // rust: assert_eq!(step(0.1), [None, None]);
    // rust: assert_eq!(step(0.6), [Some(sounds[0]), Some(sounds[1])]);
        // One tick from the start past every point, as a mod's tick makes it.
    // rust: assert_eq!(step(0.1), [None, None]);
    // rust: assert_eq!(step(0.9), [Some(sounds[0]), Some(sounds[1])]);
        // Quick Charge 1 and up have no middle sound.
    // rust: let quick = [sounds[0], "", sounds[2]];
    // rust: assert_eq!(
    // rust: charge_sounds(0.9, [false; 2], quick),
    // rust: ([true, false], Some(sounds[0]), None)
    // rust: );
}

held_projectiles_come_before_the_inventory :: proc() {
}
    // rust: let stack = |item: &str| Some(ItemStack::new(item, 1));
    // rust: let (crossbow, rocket, arrow) = (
    // rust: stack(CROSSBOW),
    // rust: stack(FIREWORK_ROCKET),
    // rust: stack("minecraft:arrow"),
    // rust: );
    // rust: let mut inventory = vec![None; 36];
    // rust: inventory[5] = arrow.clone();
        // The weapon in hotbar slot 0, `off` in the off hand.
    // rust: let slot = |weapon, off: &Option<ItemStack>, inventory: &[Option<ItemStack>]| {
    // rust: let hands = [(OFFHAND_SLOT, off.as_ref()), (0, crossbow.as_ref())];
    // rust: projectile_slot(weapon, hands, inventory)
}
        // The off hand's rocket loads a crossbow; a bow only takes arrows.
    // rust: assert_eq!(slot(CROSSBOW, &rocket, &inventory), Some(OFFHAND_SLOT));
    // rust: assert_eq!(slot("minecraft:bow", &rocket, &inventory), Some(5));
    // rust: assert_eq!(
    // rust: slot("minecraft:bow", &arrow, &inventory),
    // rust: Some(OFFHAND_SLOT)
    // rust: );
    // rust: assert_eq!(slot(CROSSBOW, &None, &inventory), Some(5));
        // A rocket in the inventory is not ammo.
    // rust: inventory[5] = rocket.clone();
    // rust: assert_eq!(slot(CROSSBOW, &None, &inventory), None);
        // The main hand's rocket, with the crossbow in the off hand.
    // rust: let hands = [(OFFHAND_SLOT, crossbow.as_ref()), (3, rocket.as_ref())];
    // rust: assert_eq!(projectile_slot(CROSSBOW, hands, &inventory), Some(3));

        // Spectral and tipped arrows in off hand or inventory are recognized.
    // rust: let spectral = stack("minecraft:spectral_arrow");
    // rust: let tipped = stack("minecraft:tipped_arrow");
    // rust: inventory[7] = spectral.clone();
    // rust: assert_eq!(slot("minecraft:bow", &None, &inventory), Some(7));
    // rust: assert_eq!(
    // rust: slot("minecraft:bow", &tipped, &inventory),
    // rust: Some(OFFHAND_SLOT)
    // rust: );
    // rust: inventory[7] = None;
    // rust: assert_eq!(slot("minecraft:bow", &None, &inventory), None);
}
}
