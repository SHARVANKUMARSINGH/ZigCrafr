//! Transpiled from Horizon Rust crate
//! Module: horizon-client_llamas
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Llamas on the game side: `AbstractChestedHorse.mobInteract` and
//! `Llama.handleEating` (wheat and hay), chests, carpets, shearing a carpet
//! off and riding.
// use super::Game;
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::{equine, llama},
}
// use horizon_core::random::RandomSource;

    // rust: impl Game<'_> {
pub fn llama_sound(self: *Self, index: usize, sound: []const u8, volume: f32) void {
}
    // rust: let at = self.mobs[index].center();
    // rust: let pitch = (self.world.random.next_float() - self.world.random.next_float()) * 0.2 + 1.0;
    // rust: self.audio
    // rust: .play(&format!("minecraft:{sound}"), Some(at), volume, pitch);
}
    /// `Llama.handleEating`: wheat and hay bales heal, age up a baby, raise
    /// the temper and, from a hay bale, put a tame adult in love.
pub fn feed_llama(self: *Self, index: usize, item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (age_up, temper, heal) = match item {
    // rust: "minecraft:wheat" => (10, 3, 2.0),
    // rust: "minecraft:hay_block" => (90, 6, 10.0),
    // rust: _ => return false,
}
    // rust: let m = &mut self.mobs[index];
    // rust: let mut used = false;
    // rust: let mut loved = false;
    // rust: if item == "minecraft:hay_block" && m.extra.tame && m.extra.age == 0 && m.extra.in_love <= 0
    // rust: {
    // rust: m.extra.in_love = 600;
    // rust: m.extra.love_player = true;
    // rust: used = true;
    // rust: loved = true;
}
    // rust: if m.health < m.attrs.max_health {
    // rust: m.heal(heal);
    // rust: used = true;
}
    // rust: let mut happy = false;
    // rust: if m.is_baby() && !m.extra.age_locked {
    // rust: m.extra.age = (m.extra.age + age_up * 20).min(0);
    // rust: used = true;
    // rust: happy = true;
}
    // rust: if (used || !m.extra.tame) && i32::from(m.extra.variant3) < llama::MAX_TEMPER {
    // rust: m.extra.variant3 = (i32::from(m.extra.variant3) + temper).min(llama::MAX_TEMPER) as u8;
    // rust: used = true;
}
    // rust: if happy {
            // AbstractHorse.handleEating: one at rest about the body.
    // rust: let id = m.id;
    // rust: self.particles_around_mob(
    // rust: id,
    // rust: "happy_villager",
    // rust: horizon_client::particles::Burst::HORSE_EATING,
    // rust: );
}
    // rust: if !used {
    // rust: return false;
}
        // Animal.setInLove: entity event 18.
    // rust: if loved {
    // rust: let id = self.mobs[index].id;
    // rust: self.love_cause.insert(id, self.lan_acting);
    // rust: let kind = self.mobs[index].kind.id.clone();
    // rust: self.native_entity_enter_love_mode(id, &kind, self.lan_acting_uuid);
    // rust: self.mob_event_particles(id, 18);
}
    // rust: self.llama_sound(index, "entity.llama.eat", 1.0);
    // rust: self.consume_held();
    // rust: true
}
    /// `AbstractChestedHorse.mobInteract` and `AbstractHorse.mobInteract` for
    /// llamas and trader llamas. Returns whether the click was used.
    // rust: pub(super) fn interact_llama(&mut self, index: usize, item: &str) -> bool {
    // rust: let m = &self.mobs[index];
    // rust: if !m.alive() || Some(m.id) == self.riding {
    // rust: return false;
}
    // rust: let sneaking = self.keys.held(Action::Sneak);
    // rust: let (baby, tamed, vehicle) = (m.is_baby(), m.extra.tame, m.rider.is_some());
    // rust: let open_inventory = !baby && tamed && sneaking;
    // rust: if !vehicle && !open_inventory && !item.is_empty() {
    // rust: if self.mobs[index].kind.food.iter().any(|f| f == item) {
    // rust: return self.feed_llama(index, item);
}
    // rust: if !tamed {
    // rust: let mut events = Vec::new();
    // rust: equine::make_mad(&mut self.mobs[index], &mut events);
    // rust: let _ = self.handle_mob_events(events);
    // rust: return true;
}
    // rust: if !self.mobs[index].extra.chested && item == "minecraft:chest" {
    // rust: self.mobs[index].extra.chested = true;
    // rust: self.llama_sound(index, "entity.llama.chest", 1.0);
    // rust: self.consume_held();
    // rust: return true;
}
}
        // AbstractHorse.mobInteract.
    // rust: if vehicle || baby {
    // rust: return false;
}
    // rust: if tamed && sneaking {
            // AbstractHorse.openCustomInventoryScreen.
    // rust: self.open_mount_menu(index);
    // rust: return true;
}
    // rust: let m = &self.mobs[index];
    // rust: let carpet = |i: &str| i.ends_with("_carpet") && i.starts_with("minecraft:");
    // rust: if !item.is_empty() {
    // rust: if item == "minecraft:shears" && m.extra.body.as_deref().is_some_and(carpet) {
                // Equippable.canBeSheared: the carpet comes off.
    // rust: let at = m.center();
    // rust: let carpet = self.mobs[index].extra.body.take().unwrap_or_default();
    // rust: self.audio
    // rust: .play("minecraft:item.llama_carpet.unequip", Some(at), 1.0, 1.0);
    // rust: self.spawn_item(ItemStack::new(&carpet, 1), at, [0.0, 0.2, 0.0], 10);
    // rust: self.damage_held_tool();
    // rust: return true;
}
    // rust: if carpet(item) && m.extra.body.is_none() {
    // rust: self.mobs[index].extra.body = Some(item.into());
    // rust: self.llama_sound(index, "entity.llama.swag", 1.0);
    // rust: self.consume_held();
    // rust: return true;
}
}
        // TraderLlama.doPlayerRide: not while a wandering trader leads it.
    // rust: if self.is_led_by_trader(index) {
    // rust: return true;
}
        // doPlayerRide; mounting drops a lead.
    // rust: let id = self.mobs[index].id;
    // rust: if !self.may_board() || !self.native_may_board(id) {
    // rust: return true;
}
    // rust: self.break_leash(id, true, false);
    // rust: let m = &mut self.mobs[index];
    // rust: m.extra.flag = false;
    // rust: m.extra.counter = 0;
    // rust: self.yaw = m.yaw;
    // rust: self.mount.reset_jump();
    // rust: self.start_riding(id);
    // rust: true
}
pub fn is_led_by_trader(self: *Self, index: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let m = &self.mobs[index];
    // rust: m.species() == horizon_client::mobs::Species::TraderLlama
    // rust: && matches!(
    // rust: m.extra.leash,
    // rust: Some(horizon_client::mobs::leash::Holder::Mob(id))
    // rust: if self.mobs.iter().any(|o| o.id == id
    // rust: && o.species() == horizon_client::mobs::Species::WanderingTrader)
    // rust: )
}
}
