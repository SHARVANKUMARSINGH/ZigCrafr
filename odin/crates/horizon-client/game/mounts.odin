//! Transpiled from Horizon Rust crate
package horizon_client_mounts

import "core:fmt"
import "core:mem"
import "core:math"

// Riding horses, donkeys and mules: feeding (`handleEating`), saddles,
// armour and chests, mounting, the rider's control and jump bar
// (`LocalPlayer.aiStep`'s riding jump), positioning, dismounting, and the
// mount's health and jump bar on the HUD.
// use super::Game;
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: blocks::Fluid,
    // rust: hud::HudBatch,
    // rust: items::ItemStack,
    // rust: mobs::{MobEvent, Species, Who, equine},
    // rust: motion::{MotionWorld, PlayerMotion},
    // rust: pose::{Dimensions, Pose},
    // rust: sprint::Keys,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, VoxelShape, trig},
    // rust: random::RandomSource,
}

// `ItemStack.hurtAndConvertOnBreak`: the stack after `wear` more damage, or -
// when that wear breaks it - the copy it leaves behind
// (`transmuteCopyIgnoreEmpty`: the components carry over, and a damageable
// copy starts whole). None while it still holds, so the caller adds the wear.
stick_on_break :: proc(stack: ^ItemStack, wear: u32, max: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if max == 0 || stack.damage + wear < max {
    // rust: return None;
}
    // rust: let mut rod = stack.transmute("minecraft:fishing_rod", 1);
    // rust: rod.damage = 0;
    // rust: Some(rod)
}

    // rust: pub(super) fn steering_item(species: Species, main: Option<&str>, offhand: Option<&str>) -> bool {
    // rust: let item = match species {
    // rust: Species::Pig => "minecraft:carrot_on_a_stick",
    // rust: Species::Strider => "minecraft:warped_fungus_on_a_stick",
    // rust: _ => return false,
}
    // rust: main == Some(item) || offhand == Some(item)
}

// `passengerAttachments` minus the player's 0.6 vehicle attachment.
seat :: proc(s: Species) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let attach = match s {
    // rust: Species::Pig => 0.86875,
    // rust: Species::Strider => 1.7,
    // rust: Species::Horse => 1.44375,
    // rust: Species::Llama | Species::TraderLlama => 1.37,
    // rust: Species::Donkey => 1.1125,
    // rust: Species::Mule => 1.2125,
    // rust: Species::Nautilus | Species::ZombieNautilus => 1.1375,
    // rust: _ => 1.31875,
}
    // rust: attach - 0.6
}
    // rust: pub(super) struct MountState {
    // `jumpRidingTicks`: -10 cooling down after a jump, >= 0 charging.
    // rust: pub(super) jump_ticks: i32,
    // `jumpRidingScale` (0..1).
    // rust: pub(super) jump_scale: f32,
    // rust: was_jumping: bool,
}
    // rust: impl MountState {
    // rust: pub(super) fn reset_jump(&mut self) {
    // rust: self.jump_ticks = 0;
    // rust: self.jump_scale = 0.0;
}
}
// `AbstractHorse.isFood` and `handleEating`: what a mount eats, and what that
// mouthful does — `(heal, age up seconds, temper, falls in love)`. The temper
// is the `u8` the mob stores it in.
//
// `AbstractHorse.isFood` is the `#minecraft:horse_food` tag, `ZombieHorse`
// overrides it with `#minecraft:zombie_horse_food` (a red mushroom and
// nothing else), and the horse food tag carries no red mushrooms; a skeleton
// horse inherits the horse food tag but only a tamed one gets that far
// (`SkeletonHorse.mobInteract` passes for an untamed one).
eating :: proc(species: Species, item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let camel = species == Species::Camel;
    // CamelHusk.isFood: rabbit's feet (and it never falls in love).
    // rust: if species == Species::CamelHusk && item != "minecraft:rabbit_foot" {
    // rust: return None;
}
    // rust: if species != Species::CamelHusk && camel != (item == "minecraft:cactus") {
    // rust: return None;
}
    // rust: let food = match species {
    // rust: Species::ZombieHorse => item == "minecraft:red_mushroom",
    // rust: Species::Horse | Species::Donkey | Species::Mule | Species::SkeletonHorse => {
    // rust: item != "minecraft:red_mushroom"
}
        // Camels and llamas answer their own tags above or in the table.
    // rust: _ => true,
}
    // rust: if !food {
    // rust: return None;
}
    // rust: Some(match item {
    // rust: "minecraft:rabbit_foot" if species == Species::CamelHusk => (2.0, 10, 0, false),
        // Camel.handleEating.
    // rust: "minecraft:cactus" => (2.0, 10, 0, true),
    // rust: "minecraft:wheat" => (2.0, 20, 3, false),
    // rust: "minecraft:sugar" => (1.0, 30, 3, false),
    // rust: "minecraft:hay_block" => (20.0, 180, 0, false),
    // rust: "minecraft:apple" => (3.0, 60, 3, false),
    // rust: "minecraft:red_mushroom" => (3.0, 0, 3, false),
    // rust: "minecraft:carrot" => (3.0, 60, 3, false),
    // rust: "minecraft:golden_carrot" => (4.0, 60, 5, true),
    // rust: "minecraft:golden_apple" | "minecraft:enchanted_golden_apple" => (10.0, 240, 10, true),
    // rust: _ => return None,
    // rust: })
}
// `EntityTypeTags.DISMOUNTS_UNDERWATER` (`Entity.dismountsUnderwater`): the mounts that throw their
// riders off when the rider's eyes are in water.
    // rust: pub(super) fn dismounts_underwater(species: Species) -> bool {
    // rust: matches!(
    // rust: species,
    // rust: Species::Camel
    // rust: | Species::Chicken
    // rust: | Species::Donkey
    // rust: | Species::HappyGhast
    // rust: | Species::Horse
    // rust: | Species::Llama
    // rust: | Species::Mule
    // rust: | Species::Pig
    // rust: | Species::Ravager
    // rust: | Species::Spider
    // rust: | Species::Strider
    // rust: | Species::TraderLlama
    // rust: | Species::ZombieHorse
    // rust: )
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn mount_index(&self) -> Option<usize> {
    // rust: let id = self.riding?;
    // rust: self.mobs.iter().position(|m| m.id == id)
}
    // `Entity.interact` / `Mob.canShearEquipment` / `Mob.shearItem`:
    // the pig's ordinary saddle comes off before Pig.mobInteract can ride it.
    // An occupied pig consumes no equipment interaction and cannot be mounted.
    // rust: pub(super) fn shear_pig_saddle(&mut self, index: usize, item: &str) -> Option<bool> {
    // rust: let m = &self.mobs[index];
    // rust: if item != "minecraft:shears" || m.species() != Species::Pig || m.is_baby() || !m.alive() {
    // rust: return None;
}
    // rust: let id = m.id;
    // rust: if self.riding == Some(id)
    // rust: || self.ridden_by_guest(id)
    // rust: || equine::is_vehicle(m)
    // rust: || self
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|r| r.alive() && !r.removed && r.extra.mount == Some(id))
    // rust: {
    // rust: return Some(false);
}
    // rust: if self.keys.held(Action::Sneak) {
    // rust: return None;
}
    // rust: let saddle = m.saddle_item()?;
    // rust: if &*saddle.item != "minecraft:saddle" {
    // rust: return None;
}
    // rust: let at = m.position;
    // rust: let offset = horizon_client::mobs::riders::passenger_attachment(m)[1];
    // rust: self.damage_held_tool();
    // rust: self.mobs[index].set_saddle(None);
    // rust: let context = self.who_context(Some(Who::Player), None);
    // rust: self.post_game_event("minecraft:shear", [at.x, at.y, at.z], context);
    // rust: self.spawn_at_location(at, offset, saddle.clone());
    // rust: let target = self.mob_entity(&self.mobs[index]);
    // rust: self.trigger_item_entity("minecraft:player_sheared_equipment", &saddle, &target);
    // rust: Some(true)
}
    // `Pig` / `Strider.mobInteract`: saddle an adult, or ride a saddled one.
interact_steerable :: proc(self: ^Self, index: uint, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let held = self.inventory[self.selected].clone();
    // rust: let m = &mut self.mobs[index];
    // rust: if m.is_baby() || !m.alive() || Some(m.id) == self.riding {
    // rust: return false;
}
    // rust: let at = m.center();
    // rust: if item == "minecraft:saddle" && !m.extra.saddled {
    // rust: m.set_saddle(held);
    // rust: let sound = if m.species() == Species::Strider {
    // rust: "minecraft:entity.strider.saddle"
    // rust: } else {
    // rust: "minecraft:entity.pig.saddle"
}
    // rust: self.audio.play(sound, Some(at), 0.5, 1.0);
    // rust: self.consume_held();
    // rust: self.world
    // rust: .modified
    // rust: .insert((at[0].floor() as i32 >> 4, at[2].floor() as i32 >> 4));
    // rust: return true;
}
        // Pig.mobInteract: held food goes to Animal.mobInteract, not a ride.
    // rust: let food = m.kind.food.iter().any(|f| f.as_str() == item);
    // rust: if !m.extra.saddled || food || self.keys.held(Action::Sneak) {
    // rust: return false;
}
    // rust: let id = m.id;
    // rust: if !self.may_board() || !self.native_may_board(id) {
    // rust: return true;
}
    // rust: self.start_riding(id);
    // rust: true
}
    // `FoodOnAStickItem.use` while riding: boost the mount, wear the stick.
    // rust: pub(super) fn use_steering_stick(&mut self, item: &str) -> bool {
    // rust: let (species, wear) = match item {
    // rust: "minecraft:carrot_on_a_stick" => (Species::Pig, 7),
    // rust: "minecraft:warped_fungus_on_a_stick" => (Species::Strider, 1),
    // rust: _ => return false,
}
    // rust: let Some(i) = self.mount_index() else {
    // rust: return false;
}
    // rust: if self.mobs[i].species() != species || !equine::boost(&mut self.mobs[i]) {
    // rust: return false;
}
    // rust: if !self.creative
    // rust: && let Some(stack) = self.inventory[self.selected].clone()
    // rust: {
            // `ItemStack.hurtAndBreak`: Unbreaking has its say first, and the
            // durability trigger only hears the wear it leaves.
    // rust: let wear = self.wear(&stack, wear);
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(25, |i| i.max_damage);
    // rust: match stick_on_break(&stack, wear, max) {
    // rust: Some(rod) => {
                    // `hurtAndConvertOnBreak`: the stick breaks (the broken
                    // statistic and `onEquippedItemBroken`), then what is
                    // left is the rod, not a fresh plain one.
    // rust: self.award_stat("broken", &stack.item, 1);
    // rust: self.player_equipment_broke(
    // rust: horizon_world::player_inventory::EquipmentSlot::MainHand,
    // rust: &stack,
    // rust: );
    // rust: self.inventory[self.selected] = Some(rod);
}
    // rust: None => {
    // rust: if let Some(stack) = self.inventory[self.selected].as_mut() {
    // rust: stack.damage += wear;
}
}
}
}
    // rust: self.swing_arm();
    // rust: true
}
    // `AbstractHorse.mobInteract`. Returns whether the click was used.
    // rust: pub(super) fn interact_mount(&mut self, index: usize, item: &str) -> bool {
    // rust: let held = self.held().cloned();
    // rust: let m = &self.mobs[index];
    // rust: let species = m.species();
        // A server player rides it already (`isVehicle`: no seat, no feeding).
    // rust: if self.ridden_by_guest(m.id) {
    // rust: return false;
}
    // rust: if matches!(species, Species::Pig | Species::Strider) {
    // rust: return self.interact_steerable(index, item);
}
    // rust: if horizon_client::mobs::llama::is_llama(species) {
    // rust: return self.interact_llama(index, item);
}
    // rust: if species == Species::HappyGhast {
    // rust: return self.interact_happy_ghast(index, item);
}
    // rust: if horizon_client::mobs::nautilus::is_nautilus(species) {
    // rust: return self.interact_nautilus(index, item);
}
    // rust: if !equine::is_equine(species) || !m.alive() || Some(m.id) == self.riding {
    // rust: return false;
}
        // AbstractHorse.mobInteract: a horse a mob rides (`isVehicle`) has no
        // seat, inventory or feeding to give. Camels seat two and check their
        // passengers themselves.
    // rust: let id = m.id;
    // rust: if !matches!(species, Species::Camel | Species::CamelHusk)
    // rust: && self
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|p| p.extra.mount == Some(id) && !p.removed && p.alive())
    // rust: {
    // rust: return false;
}
        // SkeletonHorse.mobInteract: nothing for an untamed one.
    // rust: if species == Species::SkeletonHorse && !m.extra.tame {
    // rust: return false;
}
    // rust: let sneaking =
    // rust: self.keys.held(Action::Sneak) || self.keys.raw(&winit::keyboard::KeyCode::ShiftRight);
        // Horse / ZombieHorse.mobInteract: food is fed, and anything else in
        // hand makes an untamed one mad instead of seating the player.
    // rust: let dandelion = [self.held(), self.offhand.as_ref()]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .any(|s| &*s.item == "minecraft:golden_dandelion");
    // rust: let mut events = Vec::new();
    // rust: match equine::held_item(
    // rust: &mut self.mobs[index],
    // rust: item,
    // rust: sneaking,
    // rust: dandelion,
    // rust: &mut events,
    // rust: ) {
    // rust: Some(equine::HeldItem::Feed) => return self.feed_mount(index, item),
    // rust: Some(equine::HeldItem::Refused) => {
    // rust: let _ = self.handle_mob_events(events);
    // rust: return true;
}
    // rust: None => {}
}
    // rust: let m = &self.mobs[index];
        // AbstractHorse.mobInteract: shift + use opens a tamed adult's inventory.
    // rust: if !m.is_baby() && m.extra.tame && sneaking {
    // rust: self.open_mount_menu(index);
    // rust: return true;
}
    // rust: if self.feed_mount(index, item) {
    // rust: return true;
}
    // rust: let m = &mut self.mobs[index];
    // rust: if m.is_baby() {
    // rust: return false;
}
    // rust: let at = m.center();
    // rust: let tamed = m.extra.tame;
    // rust: let sound = if item == "minecraft:saddle" && tamed && !m.extra.saddled {
    // rust: m.set_saddle(held);
            // Camel.getSaddleSound (the equip sound of a camel's saddle).
    // rust: Some(match species {
    // rust: Species::Camel => "minecraft:entity.camel.saddle",
    // rust: Species::CamelHusk => "minecraft:entity.camel_husk.saddle",
    // rust: _ => "minecraft:entity.horse.saddle",
    // rust: })
    // rust: } else if item.ends_with("_horse_armor")
    // rust: && species == Species::Horse
    // rust: && tamed
    // rust: && m.extra.body.is_none()
    // rust: {
    // rust: m.extra.body = Some(item.into());
    // rust: Some("minecraft:entity.horse.armor")
    // rust: } else if item == "minecraft:chest"
    // rust: && matches!(species, Species::Donkey | Species::Mule)
    // rust: && tamed
    // rust: && !m.extra.chested
    // rust: {
    // rust: m.extra.chested = true;
    // rust: Some("minecraft:entity.donkey.chest")
    // rust: } else {
    // rust: None
}
    // rust: if let Some(sound) = sound {
    // rust: let pitch =
    // rust: (self.world.random.next_float() - self.world.random.next_float()) * 0.2 + 1.0;
    // rust: self.audio.play(sound, Some(at), 0.5, pitch);
    // rust: self.consume_held();
    // rust: self.world
    // rust: .modified
    // rust: .insert((at[0].floor() as i32 >> 4, at[2].floor() as i32 >> 4));
    // rust: return true;
}
        // doPlayerRide
    // rust: let id = self.mobs[index].id;
    // rust: if !self.may_board() || !self.native_may_board(id) {
    // rust: return true;
}
    // rust: let m = &mut self.mobs[index];
    // rust: m.extra.flag = false;
    // rust: m.extra.counter = 0;
    // rust: self.yaw = m.yaw;
    // rust: self.mount.jump_ticks = 0;
    // rust: self.mount.jump_scale = 0.0;
    // rust: self.start_riding(id);
    // rust: true
}
    // `AbstractHorse.handleEating`.
feed_mount :: proc(self: ^Self, index: uint, item: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((heal, age_up, temper, love)) = eating(self.mobs[index].species(), item) else {
    // rust: return false;
}
    // rust: let m = &mut self.mobs[index];
    // rust: let mut used = false;
    // rust: let mut loved = false;
    // rust: if love && m.extra.tame && m.extra.age == 0 && m.extra.in_love <= 0 {
    // rust: m.extra.in_love = 600;
    // rust: m.extra.love_player = true;
    // rust: used = true;
    // rust: loved = true;
}
    // rust: if m.health < m.attrs.max_health && heal > 0.0 {
    // rust: m.heal(heal);
    // rust: used = true;
}
    // rust: if m.is_baby() && age_up > 0 && !m.extra.age_locked {
    // rust: m.extra.age = (m.extra.age + age_up * 20).min(0);
    // rust: used = true;
}
    // rust: if temper > 0 && (used || !m.extra.tame) && m.extra.variant3 < 100 {
    // rust: m.extra.variant3 = (m.extra.variant3 + temper).min(100);
    // rust: used = true;
}
    // rust: if !used {
    // rust: return false;
}
        // eating(): the mouth opens and the horse eats.
    // rust: m.anim.v[2] = 1.0;
    // rust: let at = m.center();
    // rust: let id = m.id;
    // rust: let sound = match m.species() {
    // rust: Species::Camel => "minecraft:entity.camel.eat",
    // rust: Species::CamelHusk => "minecraft:entity.camel_husk.eat",
    // rust: Species::Donkey => "minecraft:entity.donkey.eat",
    // rust: Species::Mule => "minecraft:entity.mule.eat",
    // rust: Species::Horse if m.is_baby() => "minecraft:entity.baby_horse.eat",
            // ZombieHorse.getEatingSound.
    // rust: Species::ZombieHorse => "minecraft:entity.zombie_horse.eat",
    // rust: _ => "minecraft:entity.horse.eat",
}
    // rust: let pitch = (self.world.random.next_float() - self.world.random.next_float()) * 0.2 + 1.0;
    // rust: self.audio.play(sound, Some(at), 1.0, pitch);
        // Animal.setInLove: entity event 18.
    // rust: if loved {
    // rust: self.love_cause.insert(id, self.lan_acting);
    // rust: let kind = self.mobs[index].kind.id.clone();
    // rust: self.native_entity_enter_love_mode(id, &kind, self.lan_acting_uuid);
    // rust: self.mob_event_particles(id, 18);
}
    // rust: self.consume_held();
    // rust: true
}
    // `LocalPlayer.aiStep`'s riding jump: the bar charges while jump is
    // held; on release, the jump's strength (0 when there is none).
    // rust: pub(super) fn charge_mount_jump(&mut self, i: usize, keys: Keys) -> f32 {
    // rust: let saddled = self.mobs[i].extra.saddled && Self::jumps(self.mobs[i].species());
    // rust: let mut jump = 0.0;
    // rust: if saddled {
    // rust: let st = &mut self.mount;
    // rust: if st.jump_ticks < 0 {
    // rust: st.jump_ticks += 1;
    // rust: if st.jump_ticks == 0 {
    // rust: st.jump_scale = 0.0;
}
}
    // rust: if st.was_jumping && !keys.jump {
    // rust: st.jump_ticks = -10;
    // rust: let amount = (st.jump_scale * 100.0).floor() as i32;
                // PlayerRideableJumping.getPlayerJumpPendingScale, the scale a
                // guest's START_RIDING_JUMP carries as `data`.
    // rust: jump = equine::jump_pending_scale(amount);
    // rust: } else if !st.was_jumping && keys.jump {
    // rust: st.jump_ticks = 0;
    // rust: st.jump_scale = 0.0;
    // rust: } else if st.was_jumping {
    // rust: st.jump_ticks += 1;
    // rust: st.jump_scale = if st.jump_ticks < 10 {
    // rust: st.jump_ticks as f32 * 0.1
    // rust: } else {
    // rust: 0.8 + 2.0 / (st.jump_ticks - 9) as f32 * 0.1
}
}
    // rust: st.was_jumping = keys.jump;
}
    // rust: jump
}
    // Whether the rider's eyes are in water (`Entity.updateFluidOnEyes` then `isEyeInFluid(WATER)`),
    // and not in a bubble column, as `LivingEntity.baseTick` asks before it lets a rider stay.
rider_eyes_in_water :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some([x, y, z]) = self.eye_position() else {
    // rust: return false;
}
    // rust: let (bx, by, bz) = (x.floor() as i32, y.floor() as i32, z.floor() as i32);
    // rust: if &*self.res.facts().get(self.world.block(bx, by, bz)).name == "minecraft:bubble_column" {
    // rust: return false;
}
    // rust: self.fluid_height_of(bx, by, bz, Some(Fluid::Water))
    // rust: .is_some_and(|(height, _)| f64::from(by) + f64::from(height) > y)
}
    // The rider's input for this tick; returns false when not on a mount.
    // rust: pub(super) fn tick_mount_riding(&mut self, keys: Keys) -> bool {
    // rust: let Some(i) = self.mount_index() else {
    // rust: return false;
}
    // rust: if keys.shift || !self.mobs[i].alive() {
    // rust: self.dismount_mount();
    // rust: return true;
}
        // `LivingEntity.baseTick`: a rider whose eyes are in water gets off a mount of the
        // `dismounts_underwater` tag (a server's player too: `leave_guest` tells their client).
    // rust: if dismounts_underwater(self.mobs[i].species()) && self.rider_eyes_in_water() {
    // rust: self.dismount_mount();
    // rust: return true;
}
    // rust: let strafe = f32::from(u8::from(keys.left)) - f32::from(u8::from(keys.right));
    // rust: let forward = f32::from(u8::from(keys.forward)) - f32::from(u8::from(keys.backward));
        // LocalPlayer.aiStep: the riding jump charges while space is held.
    // rust: let steer = steering_item(
    // rust: self.mobs[i].species(),
    // rust: self.held().map(|s| s.item.as_ref()),
    // rust: self.offhand.as_ref().map(|s| s.item.as_ref()),
    // rust: );
    // rust: let jump = self.charge_mount_jump(i, keys);
    // rust: let m = &mut self.mobs[i];
    // rust: if jump > 0.0 {
            // AbstractHorse.onPlayerJump: slide on the keys and rear (horses,
            // donkeys and mules).
    // rust: if equine::is_equine(m.species()) {
    // rust: equine::on_player_jump(m);
}
            // The nautilus plays its dash sound itself.
    // rust: if equine::is_equine(m.species()) {
                // playJumpSound, which the server broadcasts for a guest.
    // rust: let sound = format!("minecraft:{}", equine::jump_sound(m));
    // rust: let at = m.center();
    // rust: self.audio.play(&sound, Some(at), 0.4, 1.0);
}
}
    // rust: let m = &mut self.mobs[i];
    // rust: let pending = m.rider.map_or(0.0, |r| r.jump);
    // rust: m.rider = Some(equine::Rider {
    // rust: strafe,
    // rust: forward,
    // rust: yaw: self.yaw,
    // rust: pitch: self.pitch,
    // rust: jump: if jump > 0.0 { jump } else { pending },
    // rust: steer,
    // rust: sprint: keys.sprint || self.keys.held(Action::Sprint),
    // rust: jumping: keys.jump,
            // A server's player (a LAN guest, single player's window) drives
            // a horse from its own client (`handleMoveVehicle`).
    // rust: client: self.lan_acting.is_some(),
    // rust: });
    // rust: true
}
    // `LivingEntity.baseTick` for the mobs that ride a mount of the `dismounts_underwater` tag (a baby
    // zombie on a chicken): with their eyes in water they get off it.
    // rust: pub(super) fn dismount_underwater_mob_riders(&mut self) {
    // rust: let swimmers: Vec<u32> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive() && m.fluids.eye_in_water)
    // rust: .filter_map(|m| {
    // rust: let mount = m.extra.mount?;
    // rust: let under = self.mobs.iter().find(|v| v.id == mount)?;
    // rust: dismounts_underwater(under.species()).then_some(m.id)
    // rust: })
    // rust: .collect();
    // rust: for rider in swimmers {
    // rust: self.dismount_mob(rider);
}
}
    // `positionRider`: the player sits on the mount after it moves.
    // rust: pub(super) fn position_rider(&mut self) {
    // rust: let Some(i) = self.mount_index() else {
    // rust: return;
}
    // rust: let m = &self.mobs[i];
    // rust: let mut at = Vec3::new(m.position.x, m.position.y + seat(m.species()), m.position.z);
    // rust: if horizon_client::mobs::camel::is_camel(m.species()) {
            // Camel.getPassengerAttachmentPoint: the driver half a block
            // forward, at the body anchor (lower while sitting), turned with
            // the camel.
    // rust: let a = horizon_client::mobs::camel::passenger_attachment(m);
    // rust: let turned = Vec3::new(a[0], a[1], a[2])
    // rust: .rotate_y(-m.yaw * (std::f64::consts::PI / 180.0) as f32);
    // rust: at = Vec3::new(
    // rust: m.position.x + turned.x,
    // rust: m.position.y + turned.y - 0.6,
    // rust: m.position.z + turned.z,
    // rust: );
}
    // rust: if m.species() == Species::HappyGhast {
            // The attachment of the player's seat on the harnessed back.
    // rust: let seat = self.remote.as_ref().map_or(0, |r| r.passenger_index);
    // rust: let a = horizon_client::mobs::riders::happy_ghast_attachment(seat);
    // rust: let turned = Vec3::new(a[0], a[1], a[2])
    // rust: .rotate_y(-m.yaw * (std::f64::consts::PI / 180.0) as f32);
    // rust: at = Vec3::new(
    // rust: m.position.x + turned.x,
    // rust: m.position.y + turned.y - 0.6,
    // rust: m.position.z + turned.z,
    // rust: );
}
    // rust: if horizon_client::mobs::llama::is_llama(m.species()) {
            // The passenger attachment (0, 1.37, -0.3), half of it for a baby.
    // rust: let (y, z) = if m.is_baby() {
    // rust: (0.81, -0.15)
    // rust: } else {
    // rust: (1.37, -0.3)
}
    // rust: let yaw = f64::from(m.yaw.to_radians());
    // rust: at = Vec3::new(
    // rust: m.position.x - z * yaw.sin(),
    // rust: m.position.y + y - 0.6,
    // rust: m.position.z + z * yaw.cos(),
    // rust: );
}
        // AbstractHorse.getPassengerAttachmentPoint: the rider slides back and
        // up while the horse rears.
    // rust: let rear = equine::rear_offset(m);
    // rust: let rear = Vec3::new(rear[0], rear[1], rear[2])
    // rust: .rotate_y(-m.yaw * (std::f64::consts::PI / 180.0) as f32);
    // rust: at = Vec3::new(at.x + rear.x, at.y + rear.y, at.z + rear.z);
        // The tick a rider takes its seat is a teleport (`Entity.moveTo`), which
        // sets the old position too: the camera must not sweep from where the
        // player stood to the seat. The ticks after it move with the mount and
        // are interpolated as usual.
    // rust: let first = self.posed_rider != self.riding;
    // rust: self.posed_rider = self.riding;
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: self.previous_position = if first { at } else { p.position };
    // rust: p.position = at;
    // rust: p.velocity = Vec3::ZERO;
    // rust: p.fall_distance = 0.0;
}
}
    // `removePassenger` + `getDismountLocationForPassenger`: beside the mount.
    // rust: pub(super) fn dismount_mount(&mut self) {
    // rust: let Some(id) = self.riding else {
    // rust: return;
}
    // rust: if !self.native_may_leave(id) {
    // rust: return;
}
    // rust: self.riding = None;
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: m.rider = None;
    // rust: if m.species() == Species::HappyGhast {
    // rust: let id = m.id;
    // rust: self.dismount_happy_ghast(id);
    // rust: return;
}
    // rust: let mount = Mount {
    // rust: species: m.species(),
    // rust: position: m.position,
    // rust: bounds: m.bounds(),
    // rust: width: m.width(),
    // rust: height: m.height(),
    // rust: yaw: m.yaw,
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let rider = Rider {
    // rust: yaw: self.yaw,
    // rust: width: p.dimensions.width,
    // rust: poses: rider_poses(p),
}
    // rust: let (spot, pose) = dismount_location(&mount, &rider, &GameDismountWorld(self));
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.position = spot;
    // rust: p.velocity = Vec3::ZERO;
            // LivingEntity.setPose: the dismount pose that fit.
    // rust: if let Some(pose) = pose
    // rust: && let Err(e) = p.set_pose(pose)
    // rust: {
    // rust: log::warn!("dismount pose: {e}");
}
}
}
    // `AbstractHorse.tameWithName`: the acting player owns `mob`, then gets
    // the `tame_animal` trigger.
tame_mount :: proc(self: ^Self, mob: u32) {
}
    // rust: let owner = self.acting_player_uuid();
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: m.extra.owner = Some(owner);
    // rust: m.persistent = true;
            // AbstractHorse.tameWithName: entity event 7, spawnTamingParticles(true).
    // rust: self.mob_event_particles(mob, 7);
}
    // rust: if let Some(view) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == mob)
    // rust: .map(|m| self.mob_entity(m))
    // rust: {
    // rust: self.trigger_entity("minecraft:tame_animal", "entity", &view);
}
    // rust: if let Some(kind) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == mob)
    // rust: .map(|m| m.kind.id.clone())
    // rust: {
    // rust: let owner = horizon_client::lan::playerdata::ints_uuid(owner);
    // rust: self.native_entity_tame(mob, &kind, Some(owner));
}
}
    // rust: pub(super) fn mount_event(&mut self, e: &MobEvent) {
    // rust: match *e {
    // rust: MobEvent::Tamed { mob } => {
                // tameWithName(player): the rider, a server's player in its turn.
    // rust: let rider = self.lan.as_ref().and_then(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.vehicle == Some(mob))
    // rust: .map(|g| g.conn)
    // rust: });
    // rust: if let Some(conn) = rider
    // rust: && let Some(mut host) = self.lan.take()
    // rust: {
    // rust: self.as_guest(&mut host, conn, |g| g.tame_mount(mob));
    // rust: self.lan = Some(host);
    // rust: } else {
    // rust: self.tame_mount(mob);
}
}
    // rust: MobEvent::Buck { mob } => {
    // rust: if self.riding == Some(mob) {
    // rust: self.dismount_mount();
    // rust: } else {
                    // ejectPassengers: a server's player gets off too
                    // (leave_guest tells their client).
    // rust: let rider = self.lan.as_ref().and_then(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.vehicle == Some(mob))
    // rust: .map(|g| g.conn)
    // rust: });
    // rust: if let Some(conn) = rider
    // rust: && let Some(mut host) = self.lan.take()
    // rust: {
    // rust: self.as_guest(&mut host, conn, |g| g.dismount_mount());
    // rust: self.lan = Some(host);
}
}
                // RunAroundLikeCrazyGoal.tick: entity event 6, smoke.
    // rust: self.mob_event_particles(mob, 6);
}
            // `LivingEntity.stabAttack`: `target.stopRiding()`.
    // rust: MobEvent::StabDismount { target } => match target {
    // rust: Who::Player => self.stop_riding(),
    // rust: Who::Mob(id) => self.dismount_mob(id),
    // rust: },
    // rust: _ => {}
}
}
    // `Entity.propagateFallToPassengers`: whoever rides the mob `mob` takes
    // `causeFallDamage` of its fall, as the mount's own damage does. The local
    // player, the server players and the mob on its back each get it, with
    // their own safe distance and armour.
    // rust: pub(super) fn fall_to_passengers(&mut self, mob: u32, distance: f64, modifier: f32) {
    // rust: if self.riding == Some(mob) {
    // rust: self.rider_fall_damage(distance, modifier);
}
    // rust: let guests: Vec<u32> = self.lan.as_ref().map_or_else(Vec::new, |h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| g.vehicle == Some(mob) && Some(g.conn) != self.lan_acting)
    // rust: .map(|g| g.conn)
    // rust: .collect()
    // rust: });
    // rust: if !guests.is_empty()
    // rust: && let Some(mut host) = self.lan.take()
    // rust: {
    // rust: for conn in guests {
    // rust: self.guest_hit_by(&mut host, conn, |g| g.rider_fall_damage(distance, modifier));
}
    // rust: self.lan = Some(host);
}
    // rust: let riders: Vec<u32> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.extra.mount == Some(mob))
    // rust: .map(|m| m.id)
    // rust: .collect();
    // rust: for rider in riders {
    // rust: if let Some(r) = self.mobs.iter_mut().find(|m| m.id == rider) {
    // rust: let mut events = Vec::new();
    // rust: r.cause_fall_damage_from(distance, modifier, &mut events);
    // rust: let _ = self.handle_mob_events(events);
}
}
}
    // The player this game runs (the local one, or the server player it acts
    // as) takes the fall of the mount under it. `cause_mount_fall` runs the
    // landing code's own fall damage for the player: creative flight is
    // exempt, and the statistic, the sounds and the damage records wait in the
    // player's events for its next tick, as a landing of its own leaves them.
rider_fall_damage :: proc(self: ^Self, distance: f64, modifier: f32) {
}
    // rust: let Some(player) = self.player.as_mut() else {
    // rust: return;
}
    // rust: let _ = MotionWorld {
    // rust: entities: &[],
    // rust: player,
    // rust: scene: &mut self.world,
    // rust: assets: &self.pack.assets,
    // rust: collision_binding: self.collision,
    // rust: resources: self.motion,
    // rust: health: &self.health_resources,
}
    // rust: .cause_mount_fall(distance, modifier);
}
    // `PlayerRideableJumping`: horses, camels and nautili (the dash).
jumps :: proc(species: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: equine::is_equine(species) || horizon_client::mobs::nautilus::is_nautilus(species)
}
    // `Player.jumpableVehicle`: a saddled mount that jumps (not a pig or a
    // strider, which a saddle only steers).
    // rust: pub(super) fn jumpable_mount(&self) -> bool {
    // rust: self.mount_index()
    // rust: .is_some_and(|i| self.mobs[i].extra.saddled && Self::jumps(self.mobs[i].species()))
}
    // `willPrioritizeJumpInfo`: charging a jump or recharging.
    // rust: pub(super) fn mount_jumping(&self) -> bool {
    // rust: self.mount.jump_scale > 0.0 || self.mount.jump_ticks < 0
}
    // `Hud.extractVehicleHealth` (a native mod's `minecraft:vehicle_health`
    // layer, only while riding a mount). Returns the mount's heart count
    // (`getVehicleMaxHearts`).
    // rust: pub(super) fn draw_mount_hud(&mut self, batch: &mut HudBatch, w: i32, h: i32) -> i32 {
    // rust: let Some(i) = self.mount_index() else {
    // rust: return 0;
}
    // rust: let m = &self.mobs[i];
    // rust: let hearts = horizon_client::hud_layout::vehicle_max_hearts(m.attrs.max_health);
    // rust: let draws = horizon_client::hud_layout::vehicle_health(w, h, hearts, m.health);
    // rust: self.gui_layer("minecraft:vehicle_health", batch, |g, batch| {
    // rust: horizon_client::hud_layout::paint(batch, &g.gui.atlas, &draws);
    // rust: });
    // rust: hearts
}
    // The jump bar when it is the contextual bar.
    // rust: pub(super) fn draw_jump_bar(&self, batch: &mut HudBatch, w: i32, h: i32) {
    // rust: let Some(i) = self.mount_index() else {
    // rust: return;
}
    // rust: let m = &self.mobs[i];
        // JumpableVehicleBar: `getJumpCooldown`, which only the camel's and
        // the nautilus' dash have; a horse always shows the progress.
    // rust: let cooldown = i32::from(
    // rust: self.mount.jump_ticks < 0
    // rust: && (matches!(m.species(), Species::Camel | Species::CamelHusk)
    // rust: || horizon_client::mobs::nautilus::is_nautilus(m.species())),
    // rust: );
    // rust: let draws = horizon_client::hud_overlays::jump_bar(w, h, cooldown, self.mount.jump_scale);
    // rust: horizon_client::hud_layout::paint(batch, &self.gui.atlas, &draws);
}
}

// The mount a rider gets off: its kind, where it stands, its box,
// `getBbWidth`, `getBbHeight` and body yaw.
Mount :: struct {
    species: Species,
    position: Vec3,
    bounds: Aabb,
    width: f32,
    height: f32,
    yaw: f32,
}
// The rider getting off: `getYRot`, `getBbWidth`, and
// `getLocalBoundsForPose` for each of `Player.getDismountPoses`.
Rider :: struct {
    yaw: f32,
    width: f32,
    poses: Vec<(Pose,
}
// `Player.getDismountPoses`: standing, crouching, then crawling.
DISMOUNT_POSES :: [Pose::Standing, Pose::Crouching, Pose::Swimming]
// The rider's box in each dismount pose, at their `minecraft:scale`.
rider_poses :: proc(p: ^PlayerMotion) -> V {
    // Ported from Horizon
    return {}
}
    // EntityDimensions.scale: every player pose scales alike, so the
    // standing width gives the scale without a mutable attribute lookup.
    // rust: let scale = p.dimensions.width / Pose::Standing.dimensions(1.0).width;
    // rust: DISMOUNT_POSES
    // rust: .iter()
    // rust: .map(|&pose| (pose, pose.dimensions(scale)))
    // rust: .collect()
}
// The level queries a dismount makes.
    // rust: trait DismountWorld {
    // A full collision block (the generic rule's test).
full_collision :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // `getFluidState(pos).is(FluidTags.LAVA)`.
lava :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // `BlockGetter.getBlockFloorHeight(pos)`.
floor_height :: proc(self: ^Self, p: [i32; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // `DismountHelper.canDismountTo(level, passenger, box)`.
can_dismount_to :: proc(self: ^Self, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
}
GameDismountWorld :: struct {
    // rust: impl DismountWorld for GameDismountWorld<'_, '_> {
full_collision :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let g = self.0;
    // rust: g.res
    // rust: .facts()
    // rust: .get(g.world.block(p[0], p[1], p[2]))
    // rust: .full_collision
}
lava :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let g = self.0;
    // rust: g.res.facts().get(g.world.block(p[0], p[1], p[2])).fluid == Fluid::Lava
}
floor_height :: proc(self: ^Self, p: [i32; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let shape = self.0.block_collision_shape(p);
    // rust: let below = std::cell::OnceCell::<VoxelShape>::new();
    // rust: horizon_core::geometry::block_floor_height(&shape, || {
    // rust: below.get_or_init(|| self.0.block_collision_shape([p[0], p[1] - 1, p[2]]))
    // rust: })
}
can_dismount_to :: proc(self: ^Self, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_dismount_to(bounds)
}
}
// `getDismountLocationForPassenger`, and the pose the rider takes there.
    // rust: fn dismount_location(
    // rust: mount: &Mount,
    // rust: rider: &Rider,
    // rust: world: &impl DismountWorld,
    // rust: ) -> (Vec3, Option<Pose>) {
    // rust: if mount.species == Species::Strider {
    // rust: return strider_dismount_location(mount, rider, world);
}
    // Beside the mount, else on top of it.
    // rust: let yaw = mount.yaw.to_radians();
    // rust: let side = Vec3::new(f64::from(yaw.cos()), 0.0, f64::from(yaw.sin()));
    // rust: let w = f64::from(mount.width) / 2.0 + 0.4;
    // rust: let base = mount.position;
    // rust: let candidates = [
    // rust: Vec3::new(base.x - side.x * w, base.y, base.z - side.z * w),
    // rust: Vec3::new(base.x + side.x * w, base.y, base.z + side.z * w),
    // rust: Vec3::new(base.x, base.y + f64::from(mount.height), base.z),
    // rust: ];
    // rust: let spot = candidates
    // rust: .into_iter()
    // rust: .find(|c| {
    // rust: let f = |dy: i32| {
    // rust: world.full_collision([
    // rust: c.x.floor() as i32,
    // rust: c.y.floor() as i32 + dy,
    // rust: c.z.floor() as i32,
    // rust: ])
}
    // rust: !f(0) && !f(1)
    // rust: })
    // rust: .unwrap_or(candidates[2]);
    // rust: (spot, None)
}
// `Entity.getCollisionHorizontalEscapeVector`: out of the vehicle's box
// along `yaw`, to the edge of the square it spans.
escape_vector :: proc(vehicle_width: f64, passenger_width: f64, yaw: f32) -> V {
    // Ported from Horizon
    return {}
}
    // 1.0E-5F: a float literal widened to double.
    // rust: let distance = (vehicle_width + passenger_width + f64::from(1.0e-5_f32)) / 2.0;
    // rust: let radians = f64::from(yaw * 0.017_453_292);
    // rust: let (sin, cos) = (-trig::sin(radians), trig::cos(radians));
    // rust: let max = f64::from(sin.abs().max(cos.abs()));
    // rust: Vec3::new(
    // rust: f64::from(sin) * distance / max,
    // rust: 0.0,
    // rust: f64::from(cos) * distance / max,
    // rust: )
}
// `Strider.getDismountLocationForPassenger`: the columns along the rider's
// facing and 22.5 and 45 degrees either side of it, each from the top of
// the strider's box down to half a block below its feet. The first block
// with no lava, a valid floor (`DismountHelper.isBlockFloorValid`) and room
// for one of the rider's dismount poses (`canDismountTo`) wins, with that
// pose; without one, on top of the strider with the pose unchanged.
    // rust: fn strider_dismount_location(
    // rust: strider: &Mount,
    // rust: rider: &Rider,
    // rust: world: &impl DismountWorld,
    // rust: ) -> (Vec3, Option<Pose>) {
    // rust: let (vehicle, passenger) = (f64::from(strider.width), f64::from(rider.width));
    // rust: let top = strider.bounds.max_position().y;
    // rust: let bottom = strider.bounds.min_position().y - 0.5;
    // A LinkedHashSet: each block once, in the order first reached.
    // rust: let mut blocks: Vec<[i32; 3]> = Vec::new();
    // rust: for turn in [0.0, -22.5, 22.5, -45.0, 45.0] {
    // rust: let offset = escape_vector(vehicle, passenger, rider.yaw + turn);
    // rust: let (x, z) = (
    // rust: (strider.position.x + offset.x).floor() as i32,
    // rust: (strider.position.z + offset.z).floor() as i32,
    // rust: );
    // rust: let mut y = top;
    // rust: let mut block_y = top.floor() as i32;
    // rust: while y > bottom {
    // rust: if !blocks.contains(&[x, block_y, z]) {
    // rust: blocks.push([x, block_y, z]);
}
    // rust: block_y -= 1;
    // rust: y -= 1.0;
}
}
    // rust: for p in blocks {
    // rust: if world.lava(p) {
    // rust: continue;
}
        // DismountHelper.isBlockFloorValid.
    // rust: let floor = world.floor_height(p);
    // rust: if floor.is_infinite() || floor >= 1.0 {
    // rust: continue;
}
        // Vec3.upFromBottomCenterOf.
    // rust: let at = Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + floor,
    // rust: f64::from(p[2]) + 0.5,
    // rust: );
    // rust: for (pose, dimensions) in &rider.poses {
    // rust: if world.can_dismount_to(dimensions.bounds(at)) {
    // rust: return (at, Some(*pose));
}
}
}
    // rust: (Vec3::new(strider.position.x, top, strider.position.z), None)
}

// `ServerGamePacketListenerImpl.handlePlayerCommand` START_RIDING_JUMP on the
// vehicle `m` (`PlayerRideableJumping`): `canJump()`, a scale above zero and
// then the vehicle's own `handleStartJump`. Returns the sound the server has
// to play, with its volume — `AbstractHorse.playJumpSound` at 0.4, `Camel`'s
// dash at 1.0 — or None when the mount takes no such jump or plays its own
// dash sound (the nautilus does).
//
// Nothing here moves the mount on its own: what a horse, camel or nautilus
// does with the jump is its `handleStartJump`, and the travel that follows
// (a dash, a rear) is the mount's own tick.
    // rust: pub(super) fn start_riding_jump(
    // rust: m: &mut horizon_client::mobs::Mob,
    // rust: data: i32,
    // rust: ) -> Option<(&'static str, f32)> {
    // PlayerRideableJumping.canJump: AbstractHorse.isSaddled, and a camel that
    // is not refusing to move keeps its own gate.
    // rust: if data <= 0 || !m.extra.saddled {
    // rust: return None;
}
    // rust: if crate::mobs::camel::is_camel(m.species()) {
    // rust: if crate::mobs::camel::refuse_to_move(m) {
    // rust: return None;
}
        // Camel.handleStartJump: the dash sound, the entity action and DASH.
    // rust: crate::mobs::camel::set_dashing(m, true);
    // rust: Some((crate::mobs::camel::voice(m, 3), 1.0))
    // rust: } else if crate::mobs::nautilus::is_nautilus(m.species()) {
        // AbstractNautilus.handleStartJump: DASH, and the dash sound it makes
        // itself when the dash runs. The momentum is `onPlayerJump`'s pending
        // scale, which the nautilus spends on its next travel; a guest's ride
        // tick fills `Rider::jump` from the keys the host hears, so the scale
        // its own bar charged comes from this packet.
    // rust: crate::mobs::nautilus::on_player_jump(m, data);
    // rust: None
    // rust: } else if equine::is_equine(m.species()) {
        // AbstractHorse.handleStartJump, which is onPlayerJump for the slide
        // and the rear, then playJumpSound.
    // rust: equine::on_player_jump(m);
    // rust: Some((equine::jump_sound(m), 0.4))
    // rust: } else {
    // rust: None
}
}

    // rust: mod tests {
//     use super::*;
//     use std::collections::HashMap;

    // `ZombieHorse.isFood` is `#minecraft:zombie_horse_food`, which holds only
    // the red mushroom, and `AbstractHorse.isFood` is `#minecraft:horse_food`,
    // which holds none (#8593). A skeleton horse inherits the horse food tag.
only_a_zombie_horse_eats_a_red_mushroom :: proc() {
}
    // rust: assert_eq!(
    // rust: eating(Species::ZombieHorse, "minecraft:red_mushroom"),
    // rust: Some((3.0, 0, 3, false)),
    // rust: "a zombie horse takes the red mushroom"
    // rust: );
    // rust: for item in ["minecraft:wheat", "minecraft:apple", "minecraft:hay_block"] {
    // rust: assert_eq!(eating(Species::ZombieHorse, item), None, "{item}");
}
    // rust: for species in [
    // rust: Species::Horse,
    // rust: Species::Donkey,
    // rust: Species::Mule,
    // rust: Species::SkeletonHorse,
    // rust: ] {
    // rust: assert_eq!(
    // rust: eating(species, "minecraft:red_mushroom"),
    // rust: None,
    // rust: "{species:?}: horse food has no red mushrooms"
    // rust: );
    // rust: assert_eq!(
    // rust: eating(species, "minecraft:wheat"),
    // rust: Some((2.0, 20, 3, false)),
    // rust: "{species:?}: wheat is horse food"
    // rust: );
}
    // rust: assert_eq!(
    // rust: eating(Species::Camel, "minecraft:cactus"),
    // rust: Some((2.0, 10, 0, true))
    // rust: );
    // rust: assert_eq!(
    // rust: eating(Species::CamelHusk, "minecraft:rabbit_foot"),
    // rust: Some((2.0, 10, 0, false))
    // rust: );
}

the_mounts_that_throw_a_swimmer_off_are_the_dismounts_underwater_tag :: proc() {
}
        // data/minecraft/tags/entity_type/dismounts_underwater.json of 26.3.
    // rust: for species in [
    // rust: Species::Camel,
    // rust: Species::Chicken,
    // rust: Species::Donkey,
    // rust: Species::HappyGhast,
    // rust: Species::Horse,
    // rust: Species::Llama,
    // rust: Species::Mule,
    // rust: Species::Pig,
    // rust: Species::Ravager,
    // rust: Species::Spider,
    // rust: Species::Strider,
    // rust: Species::TraderLlama,
    // rust: Species::ZombieHorse,
    // rust: ] {
    // rust: assert!(dismounts_underwater(species), "{species:?}");
}
        // Not in the tag: a skeleton horse swims with its rider, a camel husk is not the camel.
    // rust: for species in [Species::SkeletonHorse, Species::CamelHusk, Species::Cow] {
    // rust: assert!(!dismounts_underwater(species), "{species:?}");
}
}

    // A mob of the prepared resources' type `kind` (None without them).
mob :: proc(kind: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: let types = horizon_client::mobs::MobTypes::load(&root).ok()?;
    // rust: let t = std::sync::Arc::new(types.types.get(kind)?.clone());
    // rust: Some(horizon_client::mobs::Mob::new(
    // rust: 7,
    // rust: t,
    // rust: horizon_core::geometry::Vec3::new(1.5, 64.0, -2.5),
    // rust: 0.0,
    // rust: ))
}

    // `ItemStack.hurtAndConvertOnBreak`: the seven points a pig's boost
    // wears break a carrot on a stick at 25, and what it leaves is a fishing
    // rod that kept the stick's components - not a fresh plain rod.
a_steering_stick_that_breaks_leaves_a_fishing_rod :: proc() {
}
    // rust: let mut stick = ItemStack::new("minecraft:carrot_on_a_stick", 1);
    // rust: stick.data_mut().custom_name = Some(horizon_world::nbt::Tag::String("Old Nag".into()));
        // One point short of the break: the caller wears it and it holds.
    // rust: stick.damage = 17;
    // rust: assert!(stick_on_break(&stick, 7, 25).is_none());
        // 18 + 7 is the break: the rod it leaves is whole and keeps the name.
    // rust: stick.damage = 18;
    // rust: let rod = stick_on_break(&stick, 7, 25).expect("the wear breaks it");
    // rust: assert_eq!(&*rod.item, "minecraft:fishing_rod");
    // rust: assert_eq!(rod.count, 1);
    // rust: assert_eq!(rod.damage, 0, "the rod starts whole");
    // rust: assert_eq!(
    // rust: rod.custom_name().as_deref(),
    // rust: Some("Old Nag"),
    // rust: "the components carry over"
    // rust: );
        // Wear Unbreaking took away breaks nothing, and a stack with no
        // durability at all never breaks.
    // rust: assert!(stick_on_break(&stick, 0, 25).is_none());
    // rust: assert!(stick_on_break(&stick, 25, 0).is_none());
}

    // `handlePlayerCommand` START_RIDING_JUMP reaches the ridden vehicle's
    // `handleStartJump`: a saddled horse rears, slides on the rider's keys and
    // its jump sound is played at 0.4; a donkey and a mule have their own
    // sound; a camel dashes with its dash sound at 1.0. An unsaddled mount
    // (`canJump` false) or a scale of zero takes nothing.
a_released_jump_bar_starts_the_mounts_own_jump :: proc() {
}
    // rust: let Some(mut horse) = mob("minecraft:horse") else {
    // rust: return;
}
        // Unsaddled: AbstractHorse.canJump is isSaddled.
    // rust: assert_eq!(start_riding_jump(&mut horse, 100), None);
    // rust: assert_eq!(horse.extra.counter, 0, "no rear without a jump");
    // rust: assert!(!horse.extra.stand_sliding);
    // rust: horse.set_saddle(Some(horizon_client::items::ItemStack::new(
    // rust: "minecraft:saddle",
    // rust: 1,
    // rust: )));
        // A scale of zero is not a jump (`data > 0`).
    // rust: assert_eq!(start_riding_jump(&mut horse, 0), None);
    // rust: assert_eq!(horse.extra.counter, 0);
    // rust: assert_eq!(
    // rust: start_riding_jump(&mut horse, 100),
    // rust: Some(("entity.horse.jump", 0.4))
    // rust: );
    // rust: assert_eq!(
    // rust: horse.extra.counter, 20,
    // rust: "standIfPossible rears for 20 ticks"
    // rust: );
    // rust: assert!(horse.extra.stand_sliding, "onPlayerJump slides on the keys");
    // rust: for (kind, sound) in [
    // rust: ("minecraft:donkey", "entity.donkey.jump"),
    // rust: ("minecraft:mule", "entity.mule.jump"),
    // rust: ] {
    // rust: let Some(mut m) = mob(kind) else {
    // rust: continue;
}
    // rust: m.set_saddle(Some(horizon_client::items::ItemStack::new(
    // rust: "minecraft:saddle",
    // rust: 1,
    // rust: )));
    // rust: assert_eq!(start_riding_jump(&mut m, 55), Some((sound, 0.4)), "{kind}");
}
        // A skeleton horse in water splashes instead.
    // rust: let Some(mut skeleton) = mob("minecraft:skeleton_horse") else {
    // rust: return;
}
    // rust: skeleton.set_saddle(Some(horizon_client::items::ItemStack::new(
    // rust: "minecraft:saddle",
    // rust: 1,
    // rust: )));
    // rust: skeleton.fluids.in_water = true;
    // rust: assert_eq!(
    // rust: start_riding_jump(&mut skeleton, 100),
    // rust: Some(("entity.skeleton_horse.jump_water", 0.4))
    // rust: );
}

    // `Camel.handleStartJump`: the dash sound, then DASH, which starts the
    // cooldown; a sitting camel refuses to move and cannot jump
    // (`Camel.canJump`).
a_released_jump_bar_starts_a_camels_dash :: proc() {
}
    // rust: let Some(mut camel) = mob("minecraft:camel") else {
    // rust: return;
}
    // rust: assert_eq!(start_riding_jump(&mut camel, 100), None, "no saddle");
    // rust: camel.set_saddle(Some(horizon_client::items::ItemStack::new(
    // rust: "minecraft:saddle",
    // rust: 1,
    // rust: )));
    // rust: assert_eq!(
    // rust: start_riding_jump(&mut camel, 100),
    // rust: Some(("entity.camel.dash", 1.0))
    // rust: );
    // rust: assert!(camel.extra.flag2, "Camel.setDashing(true)");
    // rust: assert_eq!(
    // rust: camel.extra.anim_ticks, 0,
    // rust: "an age-0 camel starts no cooldown"
    // rust: );
        // Sitting out the ride: refuseToMove keeps the dash from starting.
    // rust: camel.extra.camel_sitting = true;
    // rust: camel.extra.flag2 = false;
    // rust: assert_eq!(start_riding_jump(&mut camel, 100), None);
    // rust: assert!(!camel.extra.flag2);
}

    // `AbstractNautilus.onPlayerJump` through `handlePlayerCommand`
    // START_RIDING_JUMP: the scale the rider's own bar charged reaches the
    // mount, and its next travel dashes with it. A nautilus in its dash
    // cooldown takes no jump (the pending scale is left alone), and there is
    // no sound for the server to play: the nautilus plays its dash sound
    // itself when the dash runs.
a_guests_released_jump_bar_arms_the_nautilus_dash :: proc() {
}
    // rust: let Some(mut m) = mob("minecraft:nautilus") else {
    // rust: return;
}
    // rust: m.set_saddle(Some(horizon_client::items::ItemStack::new(
    // rust: "minecraft:saddle",
    // rust: 1,
    // rust: )));
        // The guest's ride tick fills the rider; the packet arrives after it.
    // rust: m.rider = Some(equine::Rider::default());
    // rust: assert_eq!(start_riding_jump(&mut m, 75), None);
    // rust: let jump = m.rider.expect("the rider stays on").jump;
        // 0.4 + 0.4 * 75 / 90: a three-quarter bar.
    // rust: assert!((jump - 0.733_333_3).abs() < 1.0e-6, "{jump}");
        // A full bar is a scale of 1.
    // rust: assert_eq!(start_riding_jump(&mut m, 100), None);
    // rust: assert_eq!(m.rider.expect("the rider stays on").jump, 1.0);
        // The dash clock: a dash still cooling down refuses the jump, so the
        // scale already on the rider stays.
    // rust: m.extra.anim_ticks = 40;
    // rust: assert_eq!(start_riding_jump(&mut m, 30), None);
    // rust: assert_eq!(m.rider.expect("the rider stays on").jump, 1.0);
        // An unsaddled nautilus cannot jump at all (`AbstractNautilus.canJump`).
    // rust: m.extra.saddled = false;
    // rust: m.extra.anim_ticks = 0;
    // rust: assert_eq!(start_riding_jump(&mut m, 100), None);
    // rust: assert_eq!(m.rider.expect("the rider stays on").jump, 1.0);
        // The scale is spent by the mount's next travel: `executeRidersJump`
        // pushes along the rider's look, starts the 40-tick dash clock, raises
        // DASH and queues the dash sound.
    // rust: m.extra.saddled = true;
    // rust: equine::ridden_step(&mut m);
    // rust: assert_eq!(m.rider.expect("the rider stays on").jump, 0.0);
    // rust: assert_eq!(m.extra.anim_ticks, 40, "the dash clock");
    // rust: assert!(m.extra.flag2, "DASH");
    // rust: assert_eq!(m.extra.scratch[1], 1, "the dash sound plays next tick");
    // rust: assert!(
    // rust: m.velocity.z > 0.0 && m.velocity.x.abs() < 1.0e-9,
    // rust: "the dash goes along the rider's look (+z): {:?}",
    // rust: m.velocity
    // rust: );
}

steering_accepts_the_correct_item_in_either_hand :: proc() {
}
    // rust: let carrot = "minecraft:carrot_on_a_stick";
    // rust: let fungus = "minecraft:warped_fungus_on_a_stick";
    // rust: assert!(steering_item(Species::Pig, Some(carrot), None));
    // rust: assert!(steering_item(Species::Pig, None, Some(carrot)));
    // rust: assert!(steering_item(Species::Strider, None, Some(fungus)));
    // rust: assert!(!steering_item(Species::Pig, Some(fungus), None));
    // rust: assert!(!steering_item(Species::Horse, Some(carrot), Some(fungus)));
}

    // A lava sea up to y 30 with full blocks placed in it; air above.
Sea :: struct {
    blocks: HashMap<[i32,
}
    // rust: impl Sea {
with :: proc(blocks: ^[[i32; 3]]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: blocks: blocks.iter().map(|&b| (b, ())).collect(),
}
}
solid :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks.contains_key(&p)
}
}
    // rust: impl DismountWorld for Sea {
full_collision :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.solid(p)
}
lava :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: p[1] <= 30 && !self.solid(p)
}
floor_height :: proc(self: ^Self, p: [i32; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.solid(p) {
    // rust: 1.0
    // rust: } else if self.solid([p[0], p[1] - 1, p[2]]) {
    // rust: 0.0
    // rust: } else {
    // rust: f64::NEG_INFINITY
}
}
can_dismount_to :: proc(self: ^Self, bounds: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (lo, hi) = (bounds.min_position(), bounds.max_position());
    // rust: let cells = |a: f64, b: f64| a.floor() as i32..=(b - 1.0e-7).floor() as i32;
    // rust: !cells(lo.x, hi.x).any(|x| {
    // rust: cells(lo.y, hi.y).any(|y| cells(lo.z, hi.z).any(|z| self.solid([x, y, z])))
    // rust: })
}
}
    // The top of a lava source at y 30 (`FlowingFluid.getOwnHeight`, 8/9).
SURFACE :: 30.0 + 8.0 / 9.0
    // A strider (0.9 by 1.7) standing on the lava at x, z, facing south.
strider_at :: proc(x: f64, z: f64) -> M {
    // Ported from Horizon
    return {}
}
    // rust: Mount {
    // rust: species: Species::Strider,
    // rust: position: Vec3::new(x, SURFACE, z),
    // rust: bounds: Aabb::new(
    // rust: Vec3::new(x - 0.45, SURFACE, z - 0.45),
    // rust: Vec3::new(x + 0.45, SURFACE + 1.7, z + 0.45),
    // rust: ),
    // rust: width: 0.9,
    // rust: height: 1.7,
    // rust: yaw: 0.0,
}
}
rider :: proc(yaw: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Rider {
    // rust: yaw,
    // rust: width: 0.6,
    // rust: poses: DISMOUNT_POSES
    // rust: .iter()
    // rust: .map(|&pose| (pose, pose.dimensions(1.0)))
    // rust: .collect(),
}
}
block_of :: proc(at: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: ]
}

a_strider_in_open_lava_puts_its_rider_on_its_back :: proc() {
}
        // #3513: getting off in a lava sea used to put the player beside the
        // strider, in the lava; with no floor in reach vanilla puts the rider
        // on top of the strider instead.
    // rust: let sea = Sea::with(&[]);
    // rust: let (at, pose) = dismount_location(&strider_at(0.5, 0.5), &rider(0.0), &sea);
    // rust: assert!(!sea.lava(block_of(at)), "dismounted into lava at {at:?}");
    // rust: assert_eq!(at, Vec3::new(0.5, SURFACE + 1.7, 0.5));
    // rust: assert_eq!(pose, None);
}

a_strider_by_the_shore_puts_its_rider_on_the_shore :: proc() {
}
        // Netherrack 45 degrees to the right of a rider facing south (+z);
        // the straight-ahead and 22.5 degree columns are lava.
    // rust: let sea = Sea::with(&[[-1, 30, 1]]);
    // rust: let (at, pose) = dismount_location(&strider_at(0.5, 0.5), &rider(0.0), &sea);
    // rust: assert_eq!(at, Vec3::new(-0.5, 31.0, 1.5));
    // rust: assert_eq!(pose, Some(Pose::Standing));
}

a_low_ceiling_on_the_shore_makes_the_rider_crawl_off :: proc() {
}
    // rust: let sea = Sea::with(&[[0, 30, 1], [0, 32, 1]]);
    // rust: let (at, pose) = dismount_location(&strider_at(0.5, 0.5), &rider(0.0), &sea);
    // rust: assert_eq!(at, Vec3::new(0.5, 31.0, 1.5));
    // rust: assert_eq!(pose, Some(Pose::Swimming));
}

the_escape_vector_reaches_the_edge_of_the_square :: proc() {
}
    // rust: let edge = (0.9 + 0.6 + f64::from(1.0e-5_f32)) / 2.0;
    // rust: let v = escape_vector(0.9, 0.6, 0.0);
    // rust: assert!((v.z - edge).abs() < 1.0e-6 && v.x.abs() < 1.0e-6);
        // Facing west of south: the corner of the square.
    // rust: let v = escape_vector(0.9, 0.6, 45.0);
    // rust: assert!((v.x + edge).abs() < 1.0e-3 && (v.z - edge).abs() < 1.0e-3);
}
}
