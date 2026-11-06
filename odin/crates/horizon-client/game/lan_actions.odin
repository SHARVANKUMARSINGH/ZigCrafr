//! Transpiled from Horizon Rust crate
package horizon_client_lan_actions

import "core:fmt"
import "core:mem"
import "core:math"

// What guests do in a hosted world. The host's gameplay code is written for
// the one local player, so a guest's action runs through it with the guest's
// state swapped in for the duration of the call (position, inventory, game
// mode, experience, mining and item use): digging, placing, using items and
// blocks, attacking and the commands all behave exactly as they do for the
// host, and every world change they cause reaches all players through the
// block log, the level events and the entity tracker.
// use super::{
    // rust: Dim, Game, GuestUse, Hit, InteractTarget, Mining, Screen,
    // rust: building_players::{BuildingPlayer, BuildingPlayers},
    // rust: lan::LanHost,
    // rust: lan_crafting::MenuRemoval,
    // rust: respawn_anchor::RespawnConfig,
}
// use horizon_client::{
    // rust: command::vanilla,
    // rust: containers::BlockEntity,
    // rust: entities::Experience,
    // rust: first_person::{Hand, SwingAnimation},
    // rust: items::ItemStack,
    // rust: lan::{
    // rust: guest::SPECTATOR,
    // rust: hub::TickCtx,
    // rust: menu::{Rules, Slots},
    // rust: },
    // rust: motion::{MotionEvent, MotionWorld, PlayerMotion},
    // rust: pose::Dimensions,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::RandomSource,
}
// use horizon_protocol::{
    // rust: packets::play::{self, Clientbound as C, Serverbound as S},
    // rust: text::literal,
}
// use horizon_world::entity_move::EntityMoveWorld;
// use winit::keyboard::KeyCode;

// Per-guest state of the gameplay code that lives outside `Guest`.
    // rust: pub(super) struct GuestPlay {
    // The sign this guest may write on (`SignBlockEntity.playerWhoMayEdit`).
    // rust: pub(super) sign_editing: Option<[i32; 3]>,
    // rust: mining: Option<Mining>,
    // rust: destroy_delay: u32,
    // rust: using: Option<(usize, u32)>,
    // rust: use_duration: i32,
    // rust: use_ticks_set: bool,
    // rust: use_delay: u32,
    // The shield's ItemCooldowns entry: an axe disabled it for this many ticks.
    // rust: pub(super) shield_cooldown: u32,
    // `ServerGamePacketListenerImpl.dropSpamThrottler` (`TickThrottler(20, 1480)`): 20 for each
    // item a creative player drops from the creative screen, one less each tick.
    // rust: creative_drops: u32,
    // `ServerGamePacketListenerImpl.chatSpamThrottler`: 20 for each chat message, one less each tick.
    // rust: pub(super) chat_spam: u32,
    // `commandSpamThrottler`: 20 for each command, one less each tick.
    // rust: pub(super) command_spam: u32,
    // `ServerCommandSuggestionsProvider`: the latest suggestion request not answered yet (a
    // newer one replaces it, which then never gets an answer), and whether this tick's one
    // answer is still free.
    // rust: suggestion: Option<Vec<u8>>,
    // rust: suggestion_budget: bool,
    // The guest's `Player.getCooldowns()` (`Game::cooldowns` for its turn).
    // rust: pub(super) cooldowns: horizon_client::cooldowns::Cooldowns,
    // rust: attack_ticks: u32,
    // The main hand's item at the guest's last tick (`Game::attack_item`).
    // rust: attack_item: Option<std::sync::Arc<str>>,
    // rust: swing: horizon_client::first_person::SwingState,
    // The block being dug and the face the client aimed at.
    // rust: digging: Option<([i32; 3], [i32; 3])>,
    // The server tick the digging started (ServerPlayerGameMode.destroyProgressStart).
    // rust: dig_start: u64,
    // The block that clock is for (ServerPlayerGameMode.destroyPos). A START is the only writer
    // that names one (death, a new ServerPlayerGameMode, clears it), so an abort, or a STOP that
    // arrives out of reach, leaves it: the STOP of a dig resumed on the same block is still
    // measured from the first START's ticks (#4124).
    // rust: destroy_pos: Option<[i32; 3]>,
    // A block the client stopped digging before the server's time was up: it breaks once
    // its progress since `dig_start` is complete (ServerPlayerGameMode.hasDelayedDestroy).
    // rust: delayed: Option<([i32; 3], u64)>,
    // rust: last_progress: i32,
    // Swings the guest's actions started this tick, for the players around
    // (`LivingEntity.swing` sends ClientboundSwingAnimationPacket).
    // rust: swings: u32,
    // The guest's riding jump charge (`LocalPlayer.jumpRidingTicks`).
    // rust: mount: super::mounts::MountState,
    // The trading screen the guest has open.
    // rust: pub(super) merchant: Option<super::lan_trading::GuestMerchant>,
    // The inventory menu and the crafting table the guest crafts in.
    // rust: pub(super) crafting: super::lan_crafting::GuestCrafting,
    // The workstation menu the guest has open (game/lan_stations.rs).
    // rust: pub(super) station: Option<super::lan_stations::GuestStation>,
    // The mount inventory the guest has open (game/lan_mount_menu.rs).
    // rust: pub(super) mount_window: Option<super::lan_mount_menu::GuestMount>,
    // The lectern the guest reads (game/lan_stations.rs).
    // rust: pub(super) lectern: Option<super::lan_stations::GuestLectern>,
    // The menu the mods last heard this guest open (`tick_player_menus`).
    // rust: pub(super) menu_heard: Option<super::native_menus::HeardMenu>,
    // The equipment the mods last heard this guest wear (`native_players_equipment`), by
    // `EquipmentSlot`: main hand, off hand, feet, legs, chest, head.
    // rust: pub(super) equipment_heard: Option<Box<[Option<crate::items::ItemStack>; 6]>>,
    // What the guest's body was given for its effects and enchantments.
    // rust: potions: super::potions::BodyPotions,
    // `ServerPlayer.getStats` and the inventory `inventory_changed` last saw.
    // rust: pub(super) stats: super::stats::Stats,
    // `Stats.LEAVE_GAME` is counted: a guest is saved more than once on the
    // way out, the statistic is awarded once (`Game::award_leave_game`).
    // rust: pub(super) left_game: bool,
    // rust: last_inventory: u64,
    // `ServerPlayer.levitationStartPos` and `levitationStartTime`.
    // rust: levitation: Option<([f64; 3], u64)>,
    // The fall, lava ride, Nether trip and blast the guest's advancements track.
    // rust: marks: super::advancements::TravelMarks,
    // `Entity.portalProcess` and `portalCooldown` (game/server_travel.rs).
    // rust: pub(super) portal: horizon_client::nether_portal::PortalState,
    // `ServerPlayer.wonGame`: the End poem is showing, the player waits for
    // its client's PERFORM_RESPAWN (`respawn_requested`).
    // rust: pub(super) won_game: bool,
    // rust: pub(super) respawn_requested: bool,
    // `Player.takeXpDelay`: ticks until the next orb can be taken.
    // rust: xp_delay: u32,
    // This player entity's age and level-up sound cooldown.
    // rust: level_up_sound: horizon_client::entities::LevelUpSound,
    // What last killed the guest outright (`/kill`): the death message's key.
    // rust: death_cause: Option<String>,
    // The equipment modifiers on the guest's attributes (`apply_equipment`)
    // and the armour and main hand they were put on for: the hub's player
    // is a `ServerPlayer` too, whose worn armour counts
    // (`LivingEntity.collectEquipmentChanges`).
    // rust: modifiers: Vec<(String, String)>,
    // rust: equipped: Option<Vec<Option<ItemStack>>>,
    // The guest's cast fishing hook (`Player.fishing`).
    // rust: pub(super) hook: Option<super::fishing::Hook>,
    // rust: sculk: super::sculk::PlayerEvents,
    // What `ServerPlayer` last recorded for the guest's scoreboard criteria
    // (`lastRecordedHealthAndAbsorption` and the others).
    // rust: score_recorded: super::scoreboard::Recorded,
}

// A guest's command waiting for the hub (`LanHost::commands`).
    // rust: pub(super) struct GuestCommand {
    // rust: pub(super) conn: u32,
    // rust: pub(super) command: String,
    // rust: pub(super) permission: u8,
    // An integrated server's: no level teleports (yet).
    // rust: pub(super) integrated: bool,
    // A mod's quiet command (game/lan_quiet.rs): its output suppressed, as
    // `CommandSourceStack.withSuppressedOutput` does.
    // rust: pub(super) quiet: bool,
}

// The game's own state while a guest's is swapped in (`enter_guest`), and
// the guest's records that live outside `Guest`.
    // rust: pub(super) struct GuestSwap {
    // rust: conn: u32,
    // rust: i: usize,
    // rust: play: GuestPlay,
    // rust: player: Option<PlayerMotion>,
    // The guest's eye height and the game's.
    // rust: eye: (f32, f32),
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: selected: usize,
    // rust: mode: horizon_client::command::args::GameMode,
    // rust: creative: bool,
    // The host's cached interaction ranges, restored after the guest turn.
    // rust: entity_reach: f64,
    // rust: block_reach: f64,
    // The host's command permission, swapped for the guest's for its turn.
    // rust: permission: u8,
    // rust: xp: Experience,
    // rust: level_up_sound: horizon_client::entities::LevelUpSound,
    // rust: host_keys: horizon_client::held::HeldKeys,
    // rust: screen: Screen,
    // rust: host_sign: Option<super::sign_edit::SignEditor>,
    // rust: host_book: Option<super::books::BookScreen>,
    // rust: host_command_block: Option<super::command_blocks::CommandBlockScreen>,
    // rust: host_mount_menu: super::mount_menu::MountMenu,
    // rust: craft_size: usize,
    // rust: craft_table: Option<[i32; 3]>,
    // rust: craft_grid: Vec<Option<ItemStack>>,
    // rust: container: Option<(i32, i32, i32)>,
    // rust: mining: Option<Mining>,
    // rust: destroy_delay: u32,
    // rust: using: Option<(usize, u32)>,
    // rust: use_duration: i32,
    // rust: use_ticks_set: bool,
    // rust: use_delay: u32,
    // rust: pub(super) shield_cooldown: u32,
    // The guest's item cooldowns (`Game::cooldowns` for its turn).
    // rust: cooldowns: horizon_client::cooldowns::Cooldowns,
    // rust: attack_ticks: u32,
    // rust: attack_item: Option<std::sync::Arc<str>>,
    // rust: swing: horizon_client::first_person::SwingState,
    // rust: left: bool,
    // rust: right: bool,
    // rust: riding: Option<u32>,
    // rust: host_boarding: (i32, Option<u32>),
    // rust: host_station: Option<super::stations::Station>,
    // rust: sleeping: Option<[i32; 3]>,
    // rust: sleep_timer: u32,
    // rust: spawn: Option<Vec3>,
    // rust: respawn: (
    // rust: Option<super::respawn_anchor::RespawnConfig>,
    // rust: Option<[f64; 3]>,
    // rust: ),
    // rust: message: Option<(String, std::time::Instant)>,
    // rust: host_ender: Option<(i32, i32, i32)>,
    // rust: adv_loaded: bool,
    // rust: last_inventory: u64,
    // rust: levitation: Option<([f64; 3], u64)>,
    // rust: marks: super::advancements::TravelMarks,
    // rust: death_cause: Option<String>,
    // The guest's own damage record, in place while they act.
    // rust: combat: super::combat::CombatTracker,
    // The guest whose turn this one nests in, if any.
    // rust: acting: (
    // rust: Option<u32>,
    // rust: Option<String>,
    // rust: Option<u128>,
    // rust: Option<u8>,
    // rust: Option<u32>,
    // rust: ),
    // That turn's other-player building boxes.
    // rust: building_boxes: BuildingPlayers,
    // That turn's `known_movement`.
    // rust: known_movement: Vec3,
    // The packets queued for that guest.
    // rust: packets: Vec<play::Clientbound>,
    // The entity events queued for that guest.
    // rust: entity_events: Vec<i8>,
    // The equipment breaks queued for that guest.
    // rust: equipment_breaks: Vec<(i8, [f64; 3])>,
    // The host's count of swings started, kept while the guest acts.
    // rust: swings: u32,
    // How many projectiles there were: those added since are the guest's.
    // rust: projectiles: usize,
    // The host's equipment modifiers.
    // rust: modifiers: Vec<(String, String)>,
}

    // rust: impl GuestPlay {
    // The item in use: its slot and for how many ticks.
    // rust: pub(super) fn using(&self) -> Option<(usize, u32)> {
    // rust: self.using
}
    // The `ServerPlayerGameMode.destroyProgressStart` a STOP on `pos` is measured from: the clock
    // belongs to the block the START named (`destroyPos`), and only a START writes either, so a
    // dig resumed after a fall still runs on the first START's ticks (#4124).
dig_start_for :: proc(self: ^Self, pos: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (self.destroy_pos == Some(pos)).then_some(self.dig_start)
}
    // A dig that ends without a break, an abort or a STOP from out of reach: the guest holds
    // attack no more (`digging` is `as_guest`'s left button and `tick_mining`'s `forced_hit`),
    // while the clock `destroy_pos` names stays for the STOP that comes when the guest is back
    // in reach (#4124).
dig_ended :: proc(self: ^Self) {
}
    // rust: self.digging = None;
    // rust: self.mining = None;
}
}

ItemRules :: struct {
    // rust: impl Rules for ItemRules<'_> {
items :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.0
}
max_stack :: proc(self: ^Self, item: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.get(item).map_or(64, |i| i.max_stack)
}
armor_index :: proc(self: ^Self, item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.0.get(item)?.equip_slot.as_deref()? {
    // rust: "head" => Some(0),
    // rust: "chest" => Some(1),
    // rust: "legs" => Some(2),
    // rust: "feet" => Some(3),
    // rust: _ => None,
}
}
}

// `Player.isWithinEntityInteractionRange(entity, buffer)` for a guest: the
// eyes closer than the entity interaction range (3, 5 in creative) plus
// `buffer` to the entity's box.
    // rust: pub(super) fn guest_within_entity_range(
    // rust: g: &horizon_client::lan::guest::Guest,
    // rust: bounds: &horizon_core::geometry::Aabb,
    // rust: buffer: f64,
    // rust: ) -> bool {
    // rust: let eye = [g.position[0], g.position[1] + g.eye_height(), g.position[2]];
    // rust: let (lo, hi) = (bounds.min_position(), bounds.max_position());
    // rust: let d = [
    // rust: eye[0] - eye[0].clamp(lo.x, hi.x),
    // rust: eye[1] - eye[1].clamp(lo.y, hi.y),
    // rust: eye[2] - eye[2].clamp(lo.z, hi.z),
    // rust: ];
    // rust: let range = if g.creative() { 5.0 } else { 3.0 } + buffer;
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] < range * range
}
direction :: proc(face: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match face {
    // rust: 0 => [0, -1, 0],
    // rust: 1 => [0, 1, 0],
    // rust: 2 => [0, 0, -1],
    // rust: 3 => [0, 0, 1],
    // rust: 4 => [-1, 0, 0],
    // rust: _ => [1, 0, 0],
}
}

// The hub's current bodies, across dimensions. A borrowed ancestor's
// live body takes precedence over this saved state until its turn returns.
building_players :: proc(host: ^LanHost) -> V {
    // Ported from Horizon
    return {}
}
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .map(|g| BuildingPlayer {
    // rust: conn: Some(g.conn),
    // rust: dimension: Dim::from_id(&g.dimension),
    // rust: bounds: (g.placed && g.loaded && !g.dead && !g.spectator()).then(|| g.bounds()),
    // rust: borrowed: false,
    // rust: })
    // rust: .collect()
}

    // rust: impl Game<'_> {
    // Run `f` as the guest `conn`: the host's player state is swapped for theirs.
    // rust: pub(super) fn as_guest<R>(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: f: impl FnOnce(&mut Self) -> R,
    // rust: ) -> Option<R> {
    // rust: self.as_guest_with_host(host, conn, |g, _| f(g))
}

    // `as_guest`, passing the active `&LanHost` to `f`.
    // rust: pub(super) fn as_guest_with_host<R>(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: f: impl FnOnce(&mut Self, &LanHost) -> R,
    // rust: ) -> Option<R> {
    // rust: let swap = self.enter_guest(host, conn, self.dim)?;
    // rust: super::dedicated::crash_fixture("guest", || {
    // rust: host.hub.guests.iter().any(|g| g.conn == conn && g.placed)
    // rust: });
    // rust: let dimension =
    // rust: (self.serving.is_some() || self.options.dedicated.is_some()).then_some(self.dim.id());
    // rust: let result = horizon_client::block_contact::in_level(dimension, || f(self, host));
    // rust: self.leave_guest(host, swap);
    // rust: Some(result)
}

    // `as_guest`, with the system messages the guest's action earns (the
    // `player::sendSystemMessage` of a packet handler) sent to that guest.
    // rust: pub(super) fn as_guest_messaged<R>(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: f: impl FnOnce(&mut Self) -> R,
    // rust: ) -> Option<R> {
    // rust: let (result, lines) = self.as_guest(host, conn, |game| {
    // rust: let outer = game.chat_capture.replace(Vec::new());
    // rust: let result = f(game);
    // rust: let lines = std::mem::replace(&mut game.chat_capture, outer).unwrap_or_default();
    // rust: (result, lines)
    // rust: })?;
    // rust: for line in lines {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content: horizon_client::lan::data::component_nbt(&line.component()),
    // rust: overlay: false,
    // rust: }),
    // rust: );
}
    // rust: Some(result)
}

    // The first half of `as_guest`: the guest's state in place of the
    // game's, which the returned swap keeps until `leave_guest`. Between the
    // two the host may go back into `self.lan`, so that what the guest does
    // can reach the other players (their commands, `for_player`), and a
    // guest's turn can nest in another's: the acting guest and the packets
    // queued for them are kept and restored too. `outer_dimension` belongs
    // to the body still in self.player: callers that enter another level
    // first must pass the dimension they left, not the new self.dim.
    // rust: pub(super) fn enter_guest(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: outer_dimension: Dim,
    // rust: ) -> Option<GuestSwap> {
        // The guest whose turn it is is in place already (their record holds
        // the game's state until their turn ends).
    // rust: if self.lan_acting == Some(conn) {
    // rust: return None;
}
    // rust: let i = host.hub.guests.iter().position(|g| g.conn == conn)?;
        // EntityGetter.isUnobstructed must still see other players while
        // the hub is taken out of self.lan. The outer body is live here;
        // its saved hub position (if any) belongs to a different turn.
    // rust: let outer = BuildingPlayer {
    // rust: conn: self.lan_acting,
    // rust: dimension: outer_dimension,
    // rust: bounds: self
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|p| !self.spectator() && !p.health.dead_or_dying())
    // rust: .map(PlayerMotion::bounds),
    // rust: borrowed: true,
}
    // rust: let other_boxes =
    // rust: self.lan_building_boxes
    // rust: .for_turn(conn, Some(outer), building_players(host));
        // `ServerPlayer.permissions()`: the guest's own command level for its
        // turn, so game-master checks see it (not the host's).
    // rust: let permission = std::mem::replace(
    // rust: &mut self.ui.registries.permission,
    // rust: host.hub.guests[i].permission,
    // rust: );
    // rust: let fresh = host.hub.guests[i].motion.is_none();
    // rust: if fresh {
    // rust: let p = Vec3::new(
    // rust: host.hub.guests[i].position[0],
    // rust: host.hub.guests[i].position[1],
    // rust: host.hub.guests[i].position[2],
    // rust: );
    // rust: host.hub.guests[i].motion = PlayerMotion::new(self.motion, p).ok().map(Box::new);
            // The first body after joining burns, breathes and falls on as saved.
    // rust: let g = &mut host.hub.guests[i];
    // rust: if let Some(saved) = g.loaded_body.take()
    // rust: && let Some(m) = g.motion.as_mut()
    // rust: {
    // rust: saved.apply(m);
                // LivingEntity.readAdditionalSaveData: the saved attributes.
    // rust: let _ =
    // rust: m.apply_saved_attributes(g.saved.as_ref().and_then(|t| t.get("attributes")));
}
            // ServerPlayer.restoreFrom: a body that follows another takes its
            // attributes (a scale of 0.1 stays 0.1 after a respawn or a trip
            // to another level).
    // rust: let g = &mut host.hub.guests[i];
    // rust: if let Some(carried) = g.carried_attributes.take()
    // rust: && let Some(m) = g.motion.as_mut()
    // rust: {
    // rust: let _ = m.apply_saved_attributes(Some(&carried));
}
            // The saved golden hearts go on the first body of a player who
            // has been here before.
    // rust: let saved = host.hub.guests[i].saved_absorption.take();
    // rust: if let (Some(m), Some(amount)) = (host.hub.guests[i].motion.as_mut(), saved) {
    // rust: let _ = m.internal_set_absorption(amount);
}
    // rust: let kept = host.hub.guests[i].logs_kept.take();
    // rust: if let (Some(m), Some((hurts, attacks))) = (host.hub.guests[i].motion.as_mut(), kept) {
    // rust: m.hurt_log = hurts;
    // rust: m.attack_log = attacks;
}
}
    // rust: let mut play = host.play.remove(&conn).unwrap_or_default();
    // rust: if fresh {
            // A new body (joined, respawned, changed level): nothing on it yet,
            // its effects' modifiers and armor protection included.
    // rust: play.equipped = None;
    // rust: play.potions = Default::default();
    // rust: play.sculk = Default::default();
            // A new ServerPlayer has everything to record again.
    // rust: play.score_recorded = Default::default();
}
    // rust: let g = &mut host.hub.guests[i];
        // The guest's body.
    // rust: let Some(mut motion) = g.motion.take() else {
    // rust: self.ui.registries.permission = permission;
    // rust: host.play.insert(conn, play);
    // rust: return None;
}
    // rust: std::mem::swap(
    // rust: &mut self.player_attachments,
    // rust: self.guest_attachments.entry(g.uuid).or_default(),
    // rust: );
    // rust: self.sculk.swap_player(&mut play.sculk);
        // The guest's own CombatTracker: damage to them is not the host's.
        // A new body starts with no record of the last one.
    // rust: let guest_combat = if fresh {
    // rust: Default::default()
    // rust: } else {
    // rust: self.guest_combat.remove(&conn).unwrap_or_default()
}
    // rust: let host_combat = std::mem::replace(&mut self.combat, guest_combat);
    // rust: self.potions.swap_player(&mut g.effects, &mut play.potions);
    // rust: motion.position = Vec3::new(g.position[0], g.position[1], g.position[2]);
    // rust: motion.entity_id = g.entity_id;
    // rust: motion.ground.on_ground = g.on_ground;
    // rust: motion.yaw = g.yaw;
    // rust: motion.pitch = g.pitch;
    // rust: motion.sprinting = g.sprinting;
    // rust: motion.may_fly = g.creative() || g.game_mode == SPECTATOR;
    // rust: motion.flying = g.flying;
    // rust: motion.flying_speed = g.flying_speed;
        // FireworkRocketItem.use boosts only a gliding player.
    // rust: motion.fall_flying = g.fall_flying;
        // A player frozen for a hand-over takes no damage (`Abilities.invulnerable`, which the
        // void and `/kill` still pass), so its record stays true until the release.
    // rust: motion.invulnerable = motion.may_fly || g.handover.is_some();
        // `ServerPlayer.isInvulnerableTo`'s connection term, as of now.
    // rust: motion.client_loaded = g.client_loaded();
    // rust: let _ = motion.set_health(g.health, false);
    // rust: motion.health.food.food = g.food;
    // rust: motion.health.food.saturation = g.saturation;
    // rust: let mut player = Some(*motion);
    // rust: std::mem::swap(&mut self.player, &mut player);
    // rust: let eye = (g.eye_height() as f32, self.eye);
    // rust: self.eye = eye.0;
    // rust: let (yaw, pitch) = (self.yaw, self.pitch);
    // rust: self.yaw = g.yaw;
    // rust: self.pitch = g.pitch;
    // rust: std::mem::swap(&mut self.inventory, &mut g.inventory);
    // rust: std::mem::swap(&mut self.armor, &mut g.armor);
    // rust: std::mem::swap(&mut self.offhand, &mut g.offhand);
    // rust: std::mem::swap(&mut self.carried, &mut g.carried);
    // rust: let selected = std::mem::replace(&mut self.selected, g.selected);
    // rust: let (mode, creative) = (self.mode, self.creative);
    // rust: let (entity_reach, block_reach) = (self.entity_reach, self.block_reach);
    // rust: self.set_mode_raw(g.game_mode);
    // rust: let xp = std::mem::replace(
    // rust: &mut self.experience,
    // rust: Experience {
    // rust: level: g.xp_level,
    // rust: progress: g.xp_progress,
    // rust: total: g.xp_total,
    // rust: },
    // rust: );
    // rust: let level_up_sound = std::mem::replace(&mut self.level_up_sound, play.level_up_sound);
        // The host's held keys stay theirs: the guest holds only sneak, and a
        // screen the guest opens (`keys.clear()`) leaves the host walking.
    // rust: let host_keys = std::mem::take(&mut self.keys);
    // rust: if g.sneaking {
    // rust: self.keys.insert(KeyCode::ShiftLeft);
}
        // The window's screens are the host's: a sign, book, command block or
        // mount menu the guest's action opens is not drawn over the host's
        // world (#687). The guest's client opens its own.
    // rust: let screen = std::mem::replace(&mut self.screen, Screen::Playing);
    // rust: let host_sign = self.sign_edit.take();
    // rust: let host_book = self.book.take();
    // rust: let host_command_block = self.command_block_screen.take();
    // rust: let host_mount_menu = std::mem::take(&mut self.mount_menu);
        // The host's crafting grid stays theirs; a crafting table the guest
        // opens shows as the 3x3 size.
    // rust: let craft_size = std::mem::replace(&mut self.craft_size, 2);
    // rust: let craft_table = self.craft_table.take();
    // rust: let craft_grid = std::mem::replace(&mut self.craft_grid, vec![None; 9]);
    // rust: let container = self.container.take();
    // rust: let mining = std::mem::replace(&mut self.mining, play.mining.take());
    // rust: let destroy_delay = std::mem::replace(&mut self.destroy_delay, play.destroy_delay);
    // rust: let using = std::mem::replace(&mut self.using, play.using.take());
    // rust: let use_duration = std::mem::replace(&mut self.use_duration, play.use_duration);
    // rust: let use_ticks_set = std::mem::replace(&mut self.use_ticks_set, play.use_ticks_set);
    // rust: let use_delay = std::mem::replace(&mut self.use_delay, play.use_delay);
    // rust: let shield_cooldown = std::mem::replace(&mut self.shield_cooldown, play.shield_cooldown);
    // rust: let cooldowns = std::mem::replace(&mut self.cooldowns, std::mem::take(&mut play.cooldowns));
    // rust: let attack_ticks = std::mem::replace(&mut self.attack_ticks, play.attack_ticks);
    // rust: let attack_item = std::mem::replace(&mut self.attack_item, play.attack_item.take());
    // rust: let swing = std::mem::replace(&mut self.swing, play.swing);
    // rust: std::mem::swap(&mut self.mount, &mut play.mount);
    // rust: let (left, right) = (self.left, self.right);
    // rust: self.left = play.digging.is_some();
    // rust: self.right = play.using.is_some() || self.using.is_some();
        // The guest's vehicle (Entity.vehicle) for its turn.
    // rust: let riding = std::mem::replace(&mut self.riding, g.vehicle);
        // The guest's boarding cooldown for its turn; `guest_server_tick`
        // counts it down once per tick (Entity.baseTick), not per turn.
    // rust: let host_boarding = (self.boarding_cooldown, self.riding_at_tick);
    // rust: self.boarding_cooldown = g.boarding_cooldown;
    // rust: self.riding_at_tick = g.vehicle;
        // `Entity.isPassenger()` for that turn, from the same vehicle: the
        // guest's body keeps no swim (`Entity.updateSwimming` needs it false).
        // Taken from `g.vehicle` each turn, so boarding and getting out land.
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.is_passenger = g.vehicle.is_some();
}
        // Entity.collide: the guest's body collides with the level's world
        // border too, as it is this turn (it moves with /worldborder).
    // rust: self.player_border();
    // rust: let host_station = self.station.take();
        // The guest's bed, sleep counter and respawn point; the host's
        // respawn point, anchor and action bar stay theirs.
    // rust: let sleeping = std::mem::replace(&mut self.sleeping, g.bed);
    // rust: let sleep_timer = std::mem::replace(&mut self.sleep_timer, g.sleep_timer);
    // rust: let spawn = std::mem::replace(
    // rust: &mut self.spawn,
    // rust: g.spawn.map(|s| Vec3::new(s[0], s[1], s[2])),
    // rust: );
    // rust: let respawn = (self.respawn_config.take(), self.level.spawn);
    // rust: self.respawn_config = g.respawn_elsewhere.as_ref().map(RespawnConfig::from_saved);
    // rust: let message = self.message.take();
        // The guest's own ender inventory; one the host has open goes back
        // into the host's while the guest acts.
    // rust: let host_ender = self.ender_open;
    // rust: self.close_ender_chest();
    // rust: std::mem::swap(&mut self.ender_items, &mut g.ender_items);
        // The guest's advancements, recipe book and statistics.
    // rust: self.advancement_tree();
    // rust: std::mem::swap(&mut self.adv.progress, &mut g.advancements);
    // rust: std::mem::swap(&mut self.adv.changed, &mut g.advancements_changed);
    // rust: std::mem::swap(&mut self.adv.unlocked, &mut g.recipes_unlocked);
    // rust: std::mem::swap(&mut self.level.recipe_book, &mut g.recipe_book);
    // rust: std::mem::swap(&mut self.level.player_extra, &mut g.saved);
    // rust: std::mem::swap(&mut self.stats, &mut play.stats);
    // rust: std::mem::swap(&mut self.hook, &mut play.hook);
    // rust: let adv_loaded = std::mem::replace(&mut self.adv.loaded, true);
    // rust: let last_inventory = std::mem::replace(&mut self.adv.last_inventory, play.last_inventory);
    // rust: let levitation = std::mem::replace(&mut self.adv.levitation, play.levitation);
    // rust: let marks = std::mem::replace(&mut self.adv.marks, std::mem::take(&mut play.marks));
    // rust: let death_cause = std::mem::replace(&mut self.ui.death_cause, play.death_cause.take());
    // rust: let [x, y, z] = g.known_movement;
    // rust: let known_movement = std::mem::replace(&mut self.known_movement, Vec3::new(x, y, z));
    // rust: let acting = (
    // rust: self.lan_acting.replace(conn),
    // rust: self.lan_acting_name.replace(g.name.clone()),
    // rust: self.lan_acting_uuid.replace(g.uuid),
    // rust: self.lan_acting_permission.replace(g.permission),
    // rust: self.lan_acting_entity.replace(g.entity_id as u32),
    // rust: );
    // rust: let packets = std::mem::take(&mut self.guest_packets);
    // rust: let entity_events = std::mem::take(&mut self.guest_entity_events);
    // rust: let equipment_breaks = std::mem::take(&mut self.guest_equipment_breaks);
    // rust: let swings = self.swings_started;
    // rust: let projectiles = self.creatures.projectiles.len();
    // rust: let modifiers = std::mem::replace(
    // rust: &mut self.applied_modifiers,
    // rust: std::mem::take(&mut play.modifiers),
    // rust: );
        // Its worn armour on its attributes, when it changed.
    // rust: let mut equipped: Vec<Option<ItemStack>> = self.armor.to_vec();
    // rust: equipped.push(self.inventory.get(self.selected).cloned().flatten());
    // rust: if play.equipped.as_ref() != Some(&equipped) {
    // rust: self.apply_equipment();
    // rust: play.equipped = Some(equipped);
}
        // The player's effects are on the new body before anything it does
        // (the movement that brought it, a landing): vanilla keeps the same
        // entity through a level change, with its attributes and effects.
    // rust: if fresh {
    // rust: self.apply_effect_status();
}
    // rust: self.update_totem_ready();
    // rust: self.entity_reach = self.interaction_range("minecraft:entity_interaction_range", 3.0, 5.0);
    // rust: self.block_reach = self.interaction_range("minecraft:block_interaction_range", 4.5, 5.0);
    // rust: let building_boxes = std::mem::replace(&mut self.lan_building_boxes, other_boxes);
    // rust: Some(GuestSwap {
    // rust: conn,
    // rust: i,
    // rust: play,
    // rust: player,
    // rust: eye,
    // rust: yaw,
    // rust: pitch,
    // rust: selected,
    // rust: mode,
    // rust: creative,
    // rust: entity_reach,
    // rust: block_reach,
    // rust: permission,
    // rust: xp,
    // rust: level_up_sound,
    // rust: host_keys,
    // rust: screen,
    // rust: host_sign,
    // rust: host_book,
    // rust: host_command_block,
    // rust: host_mount_menu,
    // rust: craft_size,
    // rust: craft_table,
    // rust: craft_grid,
    // rust: container,
    // rust: mining,
    // rust: destroy_delay,
    // rust: using,
    // rust: use_duration,
    // rust: use_ticks_set,
    // rust: use_delay,
    // rust: shield_cooldown,
    // rust: cooldowns,
    // rust: attack_ticks,
    // rust: attack_item,
    // rust: swing,
    // rust: left,
    // rust: right,
    // rust: riding,
    // rust: host_boarding,
    // rust: host_station,
    // rust: sleeping,
    // rust: sleep_timer,
    // rust: spawn,
    // rust: respawn,
    // rust: message,
    // rust: host_ender,
    // rust: adv_loaded,
    // rust: last_inventory,
    // rust: levitation,
    // rust: marks,
    // rust: death_cause,
    // rust: acting,
    // rust: known_movement,
    // rust: packets,
    // rust: entity_events,
    // rust: equipment_breaks,
    // rust: swings,
    // rust: projectiles,
    // rust: modifiers,
    // rust: combat: host_combat,
    // rust: building_boxes,
    // rust: })
}

    // The second half of `as_guest`: the guest's state back into their
    // record, the game's back in place, and what the turn changed sent.
    // rust: pub(super) fn leave_guest(&mut self, host: &mut LanHost, swap: GuestSwap) {
    // rust: let turn_events = self
    // rust: .player
    // rust: .as_mut()
    // rust: .map(|p| std::mem::take(&mut p.events))
    // rust: .unwrap_or_default();
    // rust: if !turn_events.is_empty() {
    // rust: self.record_combat(&turn_events);
    // rust: self.wear_armor(&turn_events);
}
        // A totem that saved the guest this turn (its hurt set it off).
    // rust: let totem = self.apply_totem();
        // The mods hear the food level the turn changed (eating, hunger,
        // starving...), once for the change it made as a whole, with the
        // guest's state still swapped in; they may change or undo it before it
        // reaches the guest.
    // rust: if let Some(now) = self.player.as_ref().map(|p| p.health.food.food)
    // rust: && let Some(g) = host.hub.guests.get(swap.i)
    // rust: && g.food != now
    // rust: {
    // rust: let (uuid, name, from, saturation) = (g.uuid, g.name.clone(), g.food, g.saturation);
    // rust: let (mut to, mut cancel) = (now, false);
    // rust: self.native_food_level_changed(uuid, &name, from, &mut to, &mut cancel);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: if cancel {
    // rust: p.health.food.food = from;
    // rust: p.health.food.saturation = saturation;
    // rust: } else if to != now {
    // rust: p.health.food.food = to.clamp(0, 20);
    // rust: p.health.food.saturation =
    // rust: p.health.food.saturation.min(p.health.food.food as f32);
}
}
}
    // rust: let GuestSwap {
    // rust: conn,
    // rust: i,
    // rust: mut play,
    // rust: mut player,
    // rust: eye,
    // rust: yaw,
    // rust: pitch,
    // rust: selected,
    // rust: mode,
    // rust: creative,
    // rust: entity_reach,
    // rust: block_reach,
    // rust: permission,
    // rust: xp,
    // rust: level_up_sound,
    // rust: host_keys,
    // rust: screen,
    // rust: host_sign,
    // rust: host_book,
    // rust: host_command_block,
    // rust: host_mount_menu,
    // rust: craft_size,
    // rust: craft_table,
    // rust: craft_grid,
    // rust: container,
    // rust: mining,
    // rust: destroy_delay,
    // rust: using,
    // rust: use_duration,
    // rust: use_ticks_set,
    // rust: use_delay,
    // rust: shield_cooldown,
    // rust: cooldowns,
    // rust: attack_ticks,
    // rust: attack_item,
    // rust: swing,
    // rust: left,
    // rust: right,
    // rust: riding,
    // rust: host_boarding,
    // rust: host_station,
    // rust: sleeping,
    // rust: sleep_timer,
    // rust: spawn,
    // rust: respawn,
    // rust: message,
    // rust: host_ender,
    // rust: adv_loaded,
    // rust: last_inventory,
    // rust: levitation,
    // rust: marks,
    // rust: death_cause,
    // rust: combat,
    // rust: building_boxes,
    // rust: acting,
    // rust: known_movement,
    // rust: packets,
    // rust: entity_events,
    // rust: equipment_breaks,
    // rust: swings,
    // rust: projectiles,
    // rust: modifiers,
    // rust: } = swap;
        // `ServerPlayer.permissions()` back to the host's after the turn.
    // rust: self.ui.registries.permission = permission;
    // rust: self.sculk.swap_player(&mut play.sculk);
        // The guest's damage record back into their slot, the host's in place.
    // rust: let guest_combat = std::mem::replace(&mut self.combat, combat);
    // rust: self.guest_combat.insert(conn, guest_combat);
    // rust: play.modifiers = std::mem::replace(&mut self.applied_modifiers, modifiers);
        // What the guest shot is theirs (Projectile.setOwner).
    // rust: for p in self.creatures.projectiles.iter_mut().skip(projectiles) {
    // rust: if p.owner == Some(horizon_client::mobs::Who::Player) && p.guest.is_none() {
    // rust: p.guest = Some(conn);
}
}
    // rust: let guest = &host.hub.guests[i];
    // rust: let listening = !horizon_client::mod_api::mods().is_empty();
    // rust: for projectile in projectiles..self.creatures.projectiles.len() {
    // rust: if !listening {
    // rust: break;
}
    // rust: let item = match &self.creatures.projectiles[projectile].kind {
    // rust: horizon_client::projectiles::ProjectileKind::Snowball => {
    // rust: Some("minecraft:snowball".to_owned())
}
    // rust: horizon_client::projectiles::ProjectileKind::Egg => {
    // rust: Some("minecraft:egg".to_owned())
}
    // rust: horizon_client::projectiles::ProjectileKind::EnderPearl => {
    // rust: Some("minecraft:ender_pearl".to_owned())
}
    // rust: horizon_client::projectiles::ProjectileKind::Trident => {
    // rust: Some("minecraft:trident".to_owned())
}
    // rust: horizon_client::projectiles::ProjectileKind::Potion(stack, _) => {
    // rust: Some(stack.item.to_string())
}
    // rust: _ => None,
}
    // rust: if let Some(item) = item {
    // rust: self.native_player_launch_projectile(guest.uuid, &guest.name, &item);
}
}
        // The guest's swings are theirs: the host's own count stays the host's.
    // rust: play.swings += self.swings_started.wrapping_sub(swings);
    // rust: self.swings_started = swings;
    // rust: for packet in std::mem::replace(&mut self.guest_packets, packets) {
    // rust: host.hub.send_to(conn, &packet);
}
        // ServerPlayer.connection.send: the guest's own entity events.
    // rust: let entity_id = host.hub.guests[i].entity_id;
    // rust: for event in std::mem::replace(&mut self.guest_entity_events, entity_events) {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::EntityEvent(play::EntityEvent {
    // rust: id: entity_id,
    // rust: event,
    // rust: }),
    // rust: );
}
        // LivingEntity.onEquippedItemBroken: `broadcastEntityEvent`, the guest too.
    // rust: for (event, at) in std::mem::replace(&mut self.guest_equipment_breaks, equipment_breaks) {
    // rust: host.hub.entity_event(entity_id, event, at);
}
        // Player.playSound: everyone near but the guest, in the players' source.
    // rust: let players = horizon_client::settings::SOUND_SOURCES
    // rust: .iter()
    // rust: .position(|s| *s == "player")
    // rust: .unwrap_or(0) as i32;
    // rust: for (name, at, volume, pitch) in std::mem::take(&mut self.guest_player_sounds) {
    // rust: host.hub
    // rust: .sound(&name, at, volume, pitch, players, Some(conn));
}
        // ServerItemCooldowns.onCooldownStarted: the guest's own cooldown.
    // rust: for (group, duration) in std::mem::take(&mut self.guest_cooldowns) {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::Cooldown(play::Cooldown {
    // rust: group: group.to_string(),
    // rust: duration,
    // rust: }),
    // rust: );
}
    // rust: (
    // rust: self.lan_acting,
    // rust: self.lan_acting_name,
    // rust: self.lan_acting_uuid,
    // rust: self.lan_acting_permission,
    // rust: self.lan_acting_entity,
    // rust: ) = acting;
    // rust: self.known_movement = known_movement;
    // rust: self.lan_building_boxes = building_boxes;
    // rust: play.death_cause = std::mem::replace(&mut self.ui.death_cause, death_cause);
        // An ender chest the guest opened: the menu shows their inventory
        // itself (lan_open_container), not a stand-in block entity.
    // rust: self.close_ender_chest();

        // What the action opened: handed to the guest instead of the host.
    // rust: let opened = self.container.take();
    // rust: let guest_table = std::mem::replace(&mut self.craft_table, craft_table);
    // rust: let opened_table = (std::mem::replace(&mut self.craft_size, craft_size) == 3)
    // rust: .then_some(guest_table)
    // rust: .flatten();
    // rust: self.craft_grid = craft_grid;
    // rust: let opened_station = std::mem::replace(&mut self.station, host_station);
    // rust: let bed = std::mem::replace(&mut self.sleeping, sleeping);
    // rust: let guest_sleep_timer = std::mem::replace(&mut self.sleep_timer, sleep_timer);
    // rust: let guest_spawn = std::mem::replace(&mut self.spawn, spawn).map(|s| [s.x, s.y, s.z]);
    // rust: let guest_respawn = std::mem::replace(&mut self.respawn_config, respawn.0);
    // rust: self.level.spawn = respawn.1;
        // ServerPlayer.displayClientMessage(_, true): the guest's action bar.
    // rust: let guest_message = std::mem::replace(&mut self.message, message);
    // rust: let guest_vehicle = std::mem::replace(&mut self.riding, riding);
    // rust: self.left = left;
    // rust: self.right = right;
    // rust: play.mining = std::mem::replace(&mut self.mining, mining);
    // rust: play.destroy_delay = std::mem::replace(&mut self.destroy_delay, destroy_delay);
    // rust: play.using = std::mem::replace(&mut self.using, using);
    // rust: play.use_duration = std::mem::replace(&mut self.use_duration, use_duration);
    // rust: play.use_ticks_set = std::mem::replace(&mut self.use_ticks_set, use_ticks_set);
    // rust: play.use_delay = std::mem::replace(&mut self.use_delay, use_delay);
    // rust: play.shield_cooldown = std::mem::replace(&mut self.shield_cooldown, shield_cooldown);
    // rust: play.cooldowns = std::mem::replace(&mut self.cooldowns, cooldowns);
    // rust: play.attack_ticks = std::mem::replace(&mut self.attack_ticks, attack_ticks);
    // rust: play.attack_item = std::mem::replace(&mut self.attack_item, attack_item);
    // rust: play.swing = std::mem::replace(&mut self.swing, swing);
    // rust: std::mem::swap(&mut self.mount, &mut play.mount);
    // rust: self.container = container;
    // rust: self.screen = screen;
        // A sign the guest's placement opened (SignBlock.openTextEdit).
    // rust: let guest_sign = std::mem::replace(&mut self.sign_edit, host_sign);
        // A lectern the guest's use opened (LecternBlock.openScreen).
    // rust: let guest_lectern = match std::mem::replace(&mut self.book, host_book) {
    // rust: Some(super::books::BookScreen::View {
    // rust: lectern: Some(key), ..
    // rust: }) => Some(key),
    // rust: _ => None,
}
        // A command block the guest's use opened (Player.openCommandBlock).
    // rust: let guest_command_block =
    // rust: std::mem::replace(&mut self.command_block_screen, host_command_block).map(|s| s.pos());
        // A mount inventory the guest's action opened (shift + use, or the
        // inventory key while riding).
    // rust: let guest_mount = std::mem::replace(&mut self.mount_menu, host_mount_menu).opened_mob();
    // rust: self.keys = host_keys;
        // `Entity.addPassenger`: a rider that gets in now sits behind the
        // players already in the vehicle, which is what tells its
        // `getControllingPassenger` apart from this one's.
    // rust: let seat_order = (guest_vehicle.is_some() && host.hub.guests[i].vehicle != guest_vehicle)
    // rust: .then(|| {
    // rust: host.hub.seat_order += 1;
    // rust: host.hub.seat_order
    // rust: });
    // rust: let g = &mut host.hub.guests[i];
    // rust: std::mem::swap(
    // rust: &mut self.player_attachments,
    // rust: self.guest_attachments.entry(g.uuid).or_default(),
    // rust: );
    // rust: let left_vehicle = g.vehicle.filter(|_| guest_vehicle.is_none());
        // Entity.removePassenger: 60 ticks before it may board again.
    // rust: let guest_boarding =
    // rust: super::boarding::after_leaving(self.boarding_cooldown, g.vehicle, guest_vehicle);
    // rust: (self.boarding_cooldown, self.riding_at_tick) = host_boarding;
    // rust: g.boarding_cooldown = guest_boarding;
    // rust: if guest_vehicle.is_none() {
    // rust: g.vehicle_good = None;
}
    // rust: g.vehicle = guest_vehicle;
    // rust: if let Some(order) = seat_order {
    // rust: g.vehicle_order = order;
}
    // rust: let fell_asleep = bed.is_some() && g.bed.is_none();
    // rust: (g.bed, g.sleep_timer, g.spawn) = (bed, guest_sleep_timer, guest_spawn);
    // rust: g.respawn_elsewhere = guest_respawn.map(|c| c.saved());
    // rust: g.sleeping = g.bed.is_some();
    // rust: if fell_asleep {
    // rust: g.woke_from = None;
}
    // rust: if let Some((text, _)) = guest_message {
    // rust: g.send(&C::SystemChat(play::SystemChat {
    // rust: content: literal(&text),
    // rust: overlay: true,
    // rust: }));
}
    // rust: std::mem::swap(&mut self.ender_items, &mut g.ender_items);
    // rust: std::mem::swap(&mut self.adv.progress, &mut g.advancements);
    // rust: std::mem::swap(&mut self.adv.changed, &mut g.advancements_changed);
    // rust: std::mem::swap(&mut self.adv.unlocked, &mut g.recipes_unlocked);
    // rust: std::mem::swap(&mut self.level.recipe_book, &mut g.recipe_book);
    // rust: std::mem::swap(&mut self.level.player_extra, &mut g.saved);
    // rust: std::mem::swap(&mut self.stats, &mut play.stats);
    // rust: std::mem::swap(&mut self.hook, &mut play.hook);
    // rust: self.adv.loaded = adv_loaded;
    // rust: play.last_inventory = std::mem::replace(&mut self.adv.last_inventory, last_inventory);
    // rust: play.levitation = std::mem::replace(&mut self.adv.levitation, levitation);
    // rust: play.marks = std::mem::replace(&mut self.adv.marks, marks);
    // rust: let stat_events = std::mem::take(&mut play.stats.events);
    // rust: let name = g.name.clone();
    // rust: self.potions.swap_player(&mut g.effects, &mut play.potions);
    // rust: if let Some(key) = host_ender {
    // rust: self.world
    // rust: .block_entities
    // rust: .insert(key, BlockEntity::Chest(self.ender_items.clone()));
    // rust: self.ender_open = Some(key);
}
    // rust: play.level_up_sound = std::mem::replace(&mut self.level_up_sound, level_up_sound);
    // rust: let new_xp = std::mem::replace(&mut self.experience, xp);
    // rust: g.xp_level = new_xp.level;
    // rust: g.xp_progress = new_xp.progress;
    // rust: g.xp_total = new_xp.total;
    // rust: let new_mode = self.mode_id();
    // rust: self.mode = mode;
    // rust: self.creative = creative;
    // rust: self.entity_reach = entity_reach;
    // rust: self.block_reach = block_reach;
    // rust: g.selected = std::mem::replace(&mut self.selected, selected);
    // rust: std::mem::swap(&mut self.inventory, &mut g.inventory);
    // rust: std::mem::swap(&mut self.armor, &mut g.armor);
    // rust: std::mem::swap(&mut self.offhand, &mut g.offhand);
    // rust: std::mem::swap(&mut self.carried, &mut g.carried);
        // A teleport with a rotation (commands) turns the guest. `/rotate`
        // (ServerPlayer.forceSetRotation) sends the rotation alone, rider or not.
    // rust: let forced = std::mem::take(&mut self.rotation_forced);
    // rust: let turned = !forced && [self.yaw, self.pitch] != [g.yaw, g.pitch];
    // rust: [g.yaw, g.pitch] = [self.yaw, self.pitch];
    // rust: if forced {
    // rust: g.send(&C::PlayerRotation(play::PlayerRotation {
    // rust: yaw: g.yaw,
    // rust: relative_yaw: false,
    // rust: pitch: g.pitch,
    // rust: relative_pitch: false,
    // rust: }));
}
    // rust: self.yaw = yaw;
    // rust: self.pitch = pitch;
    // rust: self.eye = eye.1;
    // rust: std::mem::swap(&mut self.player, &mut player);
    // rust: if let Some(mut m) = player {
    // rust: g.health = m.health.health();
    // rust: g.food = m.health.food.food;
    // rust: g.saturation = m.health.food.saturation;
            // A teleport (commands, a pearl) moves the guest; a pearl's is
            // sent even to where they stand (ServerPlayer.teleport).
    // rust: let at = [m.position.x, m.position.y, m.position.z];
            // A hit with extra knockback stopped the guest's sprint
            // (Player.causeExtraKnockback's setSprinting(false)).
    // rust: if !m.sprinting {
    // rust: g.sprinting = false;
}
    // rust: m.sprinting = false;
            // ServerPlayer.indicateDamage: the hit's direction to the player.
    // rust: if let Some(yaw) = m.health.indicated_dir.take() {
    // rust: g.send(&C::HurtAnimation(play::HurtAnimation {
    // rust: id: g.entity_id,
    // rust: yaw,
    // rust: }));
}
    // rust: let teleported = std::mem::take(&mut m.teleported);
    // rust: let moved: f64 = (0..3).map(|k| (at[k] - g.position[k]).powi(2)).sum();
    // rust: g.motion = Some(Box::new(m));
            // The pearl and the bed took the rider out of its vehicle at their
            // source (`stop_riding`), so `left_vehicle` already says so.
            // ServerPlayer.dismountTo: the client hears it is out of the
            // vehicle before the teleport beside it. A rider sits where its
            // vehicle puts it (lan_vehicles.rs), with no teleport.
    // rust: if let Some(vehicle) = left_vehicle {
    // rust: g.send(&C::SetPassengers(play::SetPassengers {
    // rust: vehicle: vehicle as i32,
    // rust: passengers: Vec::new(),
    // rust: }));
}
    // rust: if g.vehicle.is_none() && (moved > 0.0001 || turned || teleported) {
    // rust: host.hub.teleport(i, Some(at));
    // rust: } else if teleported {
                // ServerPlayer.startRiding and an asPassenger transition also
                // teleport the rider. Retain its mount and publish its body.
    // rust: host.hub.teleport_rider(i, at);
}
}
    // rust: let g = &mut host.hub.guests[i];
    // rust: if let Some(head) = g.bed.filter(|_| fell_asleep) {
            // LivingEntity.startSleeping: in the bed, still.
    // rust: let at = [
    // rust: f64::from(head[0]) + 0.5,
                // setPosToBed: the bed's top (getSleepHeight) and 0.125 above it.
    // rust: f64::from(head[1]) + 0.5625 + 0.125,
    // rust: f64::from(head[2]) + 0.5,
    // rust: ];
    // rust: g.position = at;
    // rust: g.previous_position = at;
    // rust: if let Some(m) = g.motion.as_mut() {
    // rust: m.position = Vec3::new(at[0], at[1], at[2]);
    // rust: m.velocity = Vec3::ZERO;
}
}
    // rust: if new_mode != g.game_mode {
    // rust: let conn = g.conn;
    // rust: host.hub
    // rust: .set_game_mode(conn, new_mode, &self.world, Some(self.collision));
}
        // LivingEntity.checkTotemDeathProtection's entity event, to every
        // client around, the guest's own included; this window draws it too.
    // rust: if let Some(body) = totem {
    // rust: let id = host.hub.guests[i].entity_id;
    // rust: host.hub
    // rust: .entity_event(id, super::totem::TOTEM_EVENT, body.at);
    // rust: if self.player.is_some() {
    // rust: self.totem_event(body, false);
}
}
    // rust: host.play.insert(conn, play);
    // rust: for event in turn_events {
    // rust: match event {
    // rust: MotionEvent::Health(horizon_client::health::HealthEvent::DamageBroadcast {
    // rust: source,
    // rust: }) => self.guest_damage_broadcast(host, conn, source),
    // rust: MotionEvent::HurtSound(sound) => self.guest_hurt_sound(host, conn, sound),
    // rust: _ => {}
}
}
    // rust: self.stat_criteria_changed(&name, stat_events);
    // rust: if let Some(pos) = opened
    // rust: && !self.lan_open_container(host, conn, pos)
    // rust: && !host.hub.guests[i].spectator()
    // rust: {
            // Nothing the guest can use opened: its lid closes again.
    // rust: self.container_openers_changed(pos, false);
}
    // rust: if let Some(station) = opened_station {
    // rust: self.lan_station_opened(host, conn, station);
}
    // rust: if let Some(edit) = guest_sign {
    // rust: self.lan_open_sign_editor(host, conn, edit);
}
    // rust: if let Some(key) = guest_lectern {
    // rust: self.lan_open_lectern(host, conn, key);
}
    // rust: if let Some(pos) = guest_command_block {
    // rust: self.lan_open_command_block(host, conn, pos);
}
    // rust: if let Some(pos) = opened_table {
    // rust: self.lan_open_crafting(host, conn, pos);
}
    // rust: if let Some(mob) = guest_mount {
    // rust: self.lan_open_mount(host, conn, mob);
}
        // The turn's teleports are in the hub now: the mods hear them.
    // rust: self.flush_teleport_notes(host);
        // An inner turn may move, kill or change a player's mode. Once its
        // body is back in the hub, refresh the restored outer snapshot while
        // keeping ancestor bodies that are still held by their GuestSwaps.
    // rust: if let Some(actor) = self.lan_acting {
    // rust: self.lan_building_boxes =
    // rust: self.lan_building_boxes
    // rust: .for_turn(actor, None, building_players(host));
}
}

    // `ServerLevel.broadcastDamageEvent` for a guest that took an unblocked hit.
    // rust: fn guest_damage_broadcast(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: source: horizon_world::damage_source::DamageTypeId,
    // rust: ) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let (id, at) = (g.entity_id, g.position);
    // rust: let kind = self
    // rust: .health_resources
    // rust: .damage
    // rust: .definition(source)
    // rust: .map_or("minecraft:generic", |d| d.name.as_str());
    // rust: host.hub.damage_event(id, kind, None, None, at);
}

    // `LivingEntity.playHurtSound` for a guest: the server's `Entity.playSound`
    // reaches every player around but the hurt one, whose own client plays it
    // from `handleDamageEvent` (#4149).
guest_hurt_sound :: proc(self: ^Self, host: ^LanHost, conn: u32, sound: string) {
}
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let at = g.position;
    // rust: let source = horizon_client::settings::sound_source(sound) as i32;
    // rust: self.audio.play_unshared(sound, Some(at), 1.0, 1.0);
    // rust: host.hub.sound(sound, at, 1.0, 1.0, source, Some(conn));
}

    // `ServerLevel.players()` in turn: the host's own player, then each
    // guest in the level in place with their state swapped in (`as_guest`).
    // What reaches the players around a point (a beacon's powers, a splash
    // potion, a warden's darkness, an elder guardian's curse) lands on each
    // of them, not only on the host. A server has no player of its own.
    // Inside a guest's action (the hub taken) only that player is in place.
    // rust: pub(super) fn for_each_player(&mut self, mut f: impl FnMut(&mut Self)) {
    // rust: if self.player.is_some() {
    // rust: f(self);
}
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: let conns: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded && !g.dead)
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in conns {
    // rust: self.as_guest(&mut host, conn, &mut f);
}
    // rust: self.lan = Some(host);
}

    // The game mode fields without `set_mode`'s side effects on the host.
set_mode_raw :: proc(self: ^Self, id: i32) {
}
//         use horizon_client::command::args::GameMode;
    // rust: self.mode = match id {
    // rust: 1 => GameMode::Creative,
    // rust: 2 => GameMode::Adventure,
    // rust: 3 => GameMode::Spectator,
    // rust: _ => GameMode::Survival,
}
    // rust: self.creative = self.mode == GameMode::Creative;
}

    // Whether the mods let the guest open the menu `kind` (`native_container_opened`),
    // heard with the guest's state swapped in. Asked before the menu that
    // was open closes.
    // rust: pub(super) fn guest_may_open(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: kind: &str,
    // rust: pos: Option<[i32; 3]>,
    // rust: ) -> bool {
    // rust: let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone())) else {
    // rust: return true;
}
    // rust: let mut cancel = false;
    // rust: let mut hook =
    // rust: |game: &mut Self| game.native_container_opened(uuid, &name, kind, pos, &mut cancel);
        // The guest whose turn it is is in place already.
    // rust: if self.lan_acting == Some(conn) {
    // rust: hook(self);
    // rust: } else {
    // rust: self.as_guest(host, conn, hook);
}
    // rust: !cancel
}

    // Hand a container the guest opened over (ServerPlayer.openMenu);
    // false when it is not one a guest can open.
lan_open_container :: proc(self: ^Self, host: ^LanHost, conn: u32, pos: (i32) {
}
        // A chest minecart, hopper minecart or chest boat keeps its slots
        // under a placeholder key (`ContainerEntity`): the menu is the
        // vehicle's own, not a block's.
    // rust: if pos.1 == super::minecarts::CART_KEY_Y {
    // rust: return self.lan_open_vehicle_container(host, conn, pos);
}
    // rust: let name = &self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos.0, pos.1, pos.2))
    // rust: .name;
    // rust: let block = name.to_string();
    // rust: let (menu, slots) = if &**name == "minecraft:ender_chest" {
            // EnderChestBlock.useWithoutItem: the player's own inventory.
    // rust: ("minecraft:generic_9x3", Slots::Ender)
    // rust: } else if let Some(BlockEntity::Furnace(f)) = self.world.block_entities.get(&pos) {
            // AbstractFurnaceBlock.openContainer: FurnaceMenu, BlastFurnaceMenu, SmokerMenu.
    // rust: let menu = match f.kind.recipe_type() {
    // rust: "minecraft:blasting" => "minecraft:blast_furnace",
    // rust: "minecraft:smoking" => "minecraft:smoker",
    // rust: _ => "minecraft:furnace",
}
    // rust: (menu, Slots::Block(pos))
    // rust: } else if let Some(BlockEntity::Crafter(_)) = self.world.block_entities.get(&pos) {
            // CrafterBlock.useWithoutItem: CrafterMenu over the block entity.
    // rust: ("minecraft:crafter_3x3", Slots::Block(pos))
    // rust: } else if let Some(BlockEntity::Brewing(_)) = self.world.block_entities.get(&pos) {
            // BrewingStandBlock.useWithoutItem: BrewingStandMenu.
    // rust: ("minecraft:brewing_stand", Slots::Block(pos))
    // rust: } else if let Some((other, right)) = self.chest_partner(pos) {
            // ChestBlock.combine: the right half's slots come first.
    // rust: let halves = if right {
    // rust: Slots::Double(pos, other)
    // rust: } else {
    // rust: Slots::Double(other, pos)
}
    // rust: ("minecraft:generic_9x6", halves)
    // rust: } else if let Some(menu) = self.mod_menu_at(pos) {
    // rust: (menu, Slots::Block(pos))
    // rust: } else {
    // rust: let Some(BlockEntity::Chest(items)) = self.world.block_entities.get(&pos) else {
    // rust: return false;
}
    // rust: let menu = match items.len() {
    // rust: 27 => "minecraft:generic_9x3",
    // rust: 9 => "minecraft:generic_3x3",
    // rust: 5 => "minecraft:hopper",
    // rust: _ => return false,
}
    // rust: (menu, Slots::Block(pos))
}
        // The menu provider's getDisplayName: a container's custom name
        // (BaseContainerBlockEntity.getName) or its default name.
    // rust: let custom = |k: (i32, i32, i32)| self.world.block_names.get(&k).map(String::as_str);
    // rust: let title = match slots {
    // rust: Slots::Ender => horizon_protocol::text::translatable("container.enderchest", &[]),
    // rust: Slots::Double(first, second) => {
    // rust: horizon_client::containers::double_chest_name(custom(first), custom(second))
}
    // rust: Slots::Block(k) => {
                // A mod block's container is named after its block
                // (`Block.getDescriptionId`).
    // rust: let key = match horizon_client::containers::default_name_key(name) {
    // rust: Some(key) => key.to_owned(),
    // rust: None if self.mod_menu_at(k).is_some() => {
    // rust: format!("block.{}", name.replace(':', "."))
}
    // rust: None => return false,
}
    // rust: horizon_client::containers::display_name(custom(k), &key)
}
            // Opened by a mod (`native_open_menu`), never here.
    // rust: Slots::Native => return false,
}
    // rust: let Some(items) = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .and_then(|g| slots.read(&self.world, g))
    // rust: else {
    // rust: return false;
}
        // The block entity's createMenu: a shulker box opens a ShulkerBoxMenu
        // (not a 9x3 ChestMenu), whose slots refuse shulker boxes.
    // rust: let menu = match slots {
    // rust: Slots::Block(_) => horizon_client::containers::block_menu_type(name).unwrap_or(menu),
    // rust: _ => menu,
}
        // BaseContainerBlockEntity.createMenu (and a double chest's own menu
        // provider, which asks both halves) refuses a locked container with
        // `sendChestLockedNotifications`: the action bar names it and everyone
        // near hears the locked chest; no menu opens.
    // rust: let (spectator, hand) = host.hub.guest(conn).map_or((false, None), |g| {
    // rust: (
    // rust: g.spectator(),
    // rust: g.inventory.get(g.selected).cloned().flatten(),
    // rust: )
    // rust: });
    // rust: let halves = match &slots {
    // rust: Slots::Double(first, second) => [Some(*first), Some(*second)],
    // rust: Slots::Block(k) => [Some(*k), None],
    // rust: _ => [None, None],
}
    // rust: let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone())) else {
    // rust: return false;
}
    // rust: let mut locked = false;
    // rust: for key in halves.iter().flatten().copied() {
    // rust: let mut check = self.container_locked_for(key, spectator, hand.as_ref());
    // rust: self.native_block_lock_check(uuid, &name, [key.0, key.1, key.2], &mut check);
    // rust: locked |= check;
}
    // rust: if locked {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content: horizon_client::containers::locked_message(&title),
    // rust: overlay: true,
    // rust: }),
    // rust: );
            // `ChestBlock`: the double chest sounds between its halves, from
            // the first one's centre plus half a block toward the other.
    // rust: let at = match &slots {
    // rust: Slots::Double(first, second) => [
    // rust: f64::from(first.0) + 0.5 + f64::from((second.0 - first.0).signum()) / 2.0,
    // rust: f64::from(first.1) + 0.5,
    // rust: f64::from(first.2) + 0.5 + f64::from((second.2 - first.2).signum()) / 2.0,
    // rust: ],
    // rust: Slots::Block(k) => [
    // rust: f64::from(k.0) + 0.5,
    // rust: f64::from(k.1) + 0.5,
    // rust: f64::from(k.2) + 0.5,
    // rust: ],
    // rust: _ => [0.0; 3],
}
    // rust: let source = horizon_client::settings::sound_source("minecraft:block.chest.locked");
    // rust: host.hub.sound(
    // rust: "minecraft:block.chest.locked",
    // rust: at,
    // rust: 1.0,
    // rust: 1.0,
    // rust: source as i32,
    // rust: None,
    // rust: );
    // rust: return false;
}
        // A mod menu type only for a client that has it: as
        // `ServerPlayer.openMenu` with no menu, nothing opens.
    // rust: let brand = host.hub.guest(conn).map_or("", |g| g.brand.as_str());
    // rust: if !horizon_client::containers::menu_reaches(brand, menu) {
    // rust: return false;
}
        // The mods may stop the menu; the click is spent.
    // rust: if !self.guest_may_open(host, conn, menu, Some([pos.0, pos.1, pos.2])) {
    // rust: return true;
}
    // rust: let mut cancel = false;
    // rust: self.native_inventory_block_start(uuid, &name, [pos.0, pos.1, pos.2], &mut cancel);
    // rust: if cancel {
    // rust: return false;
}
        // ServerPlayer.openMenu closes the menu that was open.
    // rust: self.guest_close_all(host, conn);
    // rust: let hidden = self.native_hidden_slots(pos, items.len());
        // A mod menu type's block tells the client where it is, with what its
        // mod writes (`openMenu` with an extra-data writer); a stock menu
        // sends nothing more.
    // rust: let extra = match slots {
    // rust: Slots::Block(k) if self.mod_menu_at(k).is_some() => {
    // rust: let mut data = None;
    // rust: self.native_menu_extra_data(uuid, menu, &block, [k.0, k.1, k.2], &mut data);
    // rust: let mut data = data.unwrap_or_default();
    // rust: if data.len() > horizon_protocol::menu_extra::MAX_DATA {
    // rust: log::warn!(
    // rust: "Horizon: {block}'s menu extra data ({} bytes) is past {} bytes; sent without it",
    // rust: data.len(),
    // rust: horizon_protocol::menu_extra::MAX_DATA
    // rust: );
    // rust: data.clear();
}
    // rust: Some(data)
}
    // rust: _ => None,
}
    // rust: host.hub
    // rust: .open_container(conn, menu, title, pos, slots, items, extra);
    // rust: if !hidden.is_empty() {
    // rust: host.hub.hide_menu_slots(conn, hidden);
}
        // The opener count was already raised by the guest's use of the block
        // (`open_menu`, through `BlockEntity.triggerEvent`/`startOpen`); raising
        // it again here counted one player twice. Only the last closer would
        // then reach zero and `stopOpen`, so a shulker box stayed open forever
        // (#9500).
    // rust: true
}

    // `ContainerEntity.interactWithContainerVehicle` for a guest: the menu
    // the vehicle's own `MenuProvider.createMenu` builds - three rows of a
    // `ChestMenu` for a chest boat or a chest minecart, a `HopperMenu` for a
    // hopper minecart - titled with the vehicle's name.
    // rust: fn lan_open_vehicle_container(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: pos: (i32, i32, i32),
    // rust: ) -> bool {
    // rust: let entity_type = if let Some(cart) = self.carts.iter().find(|c| c.id as i32 == pos.2) {
    // rust: cart.kind.id().to_owned()
    // rust: } else if let Some(boat) = self.boats.iter().find(|b| b.id as i32 == pos.2) {
    // rust: if !boat.chest {
    // rust: return false;
}
    // rust: boat.entity_type()
    // rust: } else {
    // rust: return false;
}
        // `ContainerEntity.unpackChestVehicleLootTable`: a chest boat still
        // holding a loot table rolls it on the first open.
    // rust: if let Some(i) = self
    // rust: .boats
    // rust: .iter()
    // rust: .position(|b| b.id as i32 == pos.2 && b.chest)
    // rust: {
            // AbstractChestBoat.createMenu: a spectator opens no boat whose
            // loot table is still to roll, and the table stays.
    // rust: let spectator = host.hub.guest(conn).is_some_and(|g| g.spectator());
    // rust: if spectator && self.boat_loot_pending(self.boats[i].id) {
    // rust: return false;
}
    // rust: self.unpack_boat_loot(i);
}
        // `createMenu` (ChestMenu.threeRows or a HopperMenu), and
        // `MenuProvider.getDisplayName`, the vehicle's name key.
    // rust: let Some((menu, _)) = horizon_client::containers::vehicle_menu(&entity_type) else {
    // rust: return false;
}
    // rust: let title = horizon_protocol::text::translatable(
    // rust: &horizon_client::containers::vehicle_menu_name(&entity_type),
    // rust: &[],
    // rust: );
    // rust: let slots = Slots::Block(pos);
    // rust: let Some(items) = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .and_then(|g| slots.read(&self.world, g))
    // rust: else {
    // rust: return false;
}
        // The mods may stop the menu; the click is spent.
    // rust: if !self.guest_may_open(host, conn, menu, None) {
    // rust: return true;
}
        // ServerPlayer.openMenu closes the menu that was open.
    // rust: self.guest_close_all(host, conn);
    // rust: host.hub
    // rust: .open_container(conn, menu, title, pos, slots, items, None);
    // rust: true
}

    // `ContainerEntity.unpackChestVehicleLootTable` for a chest boat: the table
    // its raw NBT still holds rolls into the slots on the first open (an empty
    // boat, as a command leaves one), and `player_generates_container_loot`
    // fires for the player who opened it.
boat_loot_pending :: proc(self: ^Self, id: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self.persist.raw.get(&id),
    // rust: Some(horizon_world::nbt::Tag::Compound(map)) if map.contains_key(&"LootTable".into())
    // rust: )
}

unpack_boat_loot :: proc(self: ^Self, i: uint) {
}
//         use horizon_world::nbt::Tag;
    // rust: let id = self.boats[i].id;
    // rust: let (table, seed) = {
    // rust: let Some(Tag::Compound(map)) = self.persist.raw.get_mut(&id) else {
    // rust: return;
}
    // rust: let Some(table) = crate::save::text(map.get(&"LootTable".into()))
    // rust: .and_then(|id| horizon_client_core::identifier::normalize_id(&id))
    // rust: else {
    // rust: return;
}
    // rust: let seed = match map.get(&"LootTableSeed".into()) {
    // rust: Some(Tag::Long(seed)) => Some(*seed),
    // rust: _ => None,
}
            // The table is spent even when nothing can be rolled into it (the
            // loot data is not loaded): vanilla clears it before filling.
    // rust: map.remove(&"LootTable".into());
    // rust: map.remove(&"LootTableSeed".into());
    // rust: (table, seed)
}
        // `LootTable.fill` sets the slots it rolls and leaves the rest; a boat
        // that already holds something keeps it, so no table is applied over it.
    // rust: if self.boats[i].items.iter().any(Option::is_some) {
    // rust: return;
}
    // rust: let loot = crate::structure_blocks::loot_data(&self.options.resources, &self.pack_files());
    // rust: let b = &self.boats[i];
    // rust: let at = Vec3::new(b.position.x, b.position.y, b.position.z);
    // rust: let biome = self.biome_name_at(at).unwrap_or_default();
    // rust: let pos = (
    // rust: b.position.x.floor() as i32,
    // rust: b.position.y.floor() as i32,
    // rust: b.position.z.floor() as i32,
    // rust: );
    // rust: crate::structure_blocks::roll_container(
    // rust: &mut self.boats[i].items,
    // rust: loot.as_deref(),
    // rust: table.clone(),
    // rust: seed,
    // rust: pos,
    // rust: &biome,
    // rust: );
    // rust: self.trigger_loot_table(&table);
}

    // The guest's open container is closing (`AbstractContainerMenu.removed`):
    // it no longer counts among the openers of the lid, and the lid's close
    // sound is played for everyone around (`ChestBlockEntity.onClose`, a
    // `playSound` with no player), the guest included, once the last opener
    // has left.
    // rust: pub(super) fn guest_container_closed(&mut self, host: &mut LanHost, conn: u32) {
    // rust: if let Some(g) = host.hub.guest(conn)
    // rust: && let Some(pos) = g.menu.as_ref().and_then(|m| m.pos)
    // rust: && !g.spectator()
    // rust: && self.container_openers_changed(pos, false)
    // rust: {
    // rust: self.container_edge_sound(pos, false);
}
}

    // Closes whatever menu the guest has open, the way each `ContainerClose`
    // does (`ServerPlayer.doCloseContainer`, `AbstractContainerMenu.removed`):
    // the container's lid, a vehicle's stand-in (its items go back to the
    // vehicle), the trade (written back to the villager), the crafting table,
    // station and mount menus, and the cursor stack back to the inventory.
    // Nothing is sent to the client: this is for a guest who is leaving or
    // whose server is closing. The guest must be in `host.hub.guests` and the
    // level they are in must be the one in place.
    // rust: pub(super) fn guest_close_all(&mut self, host: &mut LanHost, conn: u32) {
    // rust: self.guest_remove_menus(host, conn, MenuRemoval::Live);
}

    // `AbstractContainerMenu.removed` after the player has disconnected.
    // Only HostEvent::Left selects this policy; ordinary closes and shutdown
    // keep their existing return-to-inventory behavior.
    // rust: pub(super) fn guest_disconnected(&mut self, host: &mut LanHost, conn: u32) {
    // rust: self.guest_remove_menus(host, conn, MenuRemoval::Disconnected);
}

    // `AbstractContainerMenu.removed`: close the guest's active menu using
    // its live or disconnected disposition for cursor and crafting inputs.
guest_remove_menus :: proc(self: ^Self, host: ^LanHost, conn: u32, removal: MenuRemoval) {
}
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: if removal == MenuRemoval::Disconnected {
    // rust: self.guest_drop_carried(host, gi);
}
    // rust: if let Some((window, slots)) = host.hub.guests[gi]
    // rust: .menu
    // rust: .as_ref()
    // rust: .map(|m| (m.window, m.slots))
    // rust: {
    // rust: self.guest_container_closed(host, conn);
    // rust: if let Slots::Block(key) = slots
    // rust: && key.1 == super::minecarts::CART_KEY_Y
    // rust: {
    // rust: self.close_guest_vehicle_menu(host, conn, key);
}
    // rust: host.hub.container_closed(conn, window);
}
    // rust: self.lan_merchant_closed(host, conn, None);
    // rust: self.lan_crafting_removed(host, conn, None, removal);
    // rust: if removal == MenuRemoval::Disconnected {
            // The inventory grid is separate from an open table. Empty both
            // before lan_crafting_left saves the guest; never drop result slots.
    // rust: self.lan_crafting_removed(host, conn, Some(0), removal);
}
    // rust: self.lan_station_closed(host, conn, None);
    // rust: self.lan_mount_closed(host, conn, None);
    // rust: if removal == MenuRemoval::Live {
    // rust: self.guest_carried_back(host, gi);
}
        // `PlayerContainerEvent.Close`, after the menu's `removed`.
    // rust: self.player_menu_closing(host, conn);
}

    // rust: pub(super) fn vehicle_has_other_viewers(
    // rust: container: Option<(i32, i32, i32)>,
    // rust: guests: &[horizon_client::lan::guest::Guest],
    // rust: closing_conn: Option<u32>,
    // rust: key: (i32, i32, i32),
    // rust: ) -> bool {
    // rust: container == Some(key)
    // rust: || guests.iter().any(|g| {
    // rust: Some(g.conn) != closing_conn
    // rust: && g.menu
    // rust: .as_ref()
    // rust: .is_some_and(|m| m.slots == Slots::Block(key))
    // rust: })
}

    // `ContainerEntity`'s `Container.stopOpen` when a vehicle menu closes
    // (`AbstractChestBoat.stopOpen` / `MinecartChest.stopOpen`): the menu's
    // slots go back to the vehicle, the shared placeholder leaves
    // `world.block_entities`, and CONTAINER_CLOSE fires at the vehicle with
    // the closing player as the source. A hopper minecart keeps
    // `Container.stopOpen`'s no-op. Called by the close packet and by the
    // `ServerPlayer.tick` reach/destroyed close.
close_guest_vehicle_menu :: proc(self: ^Self, host: ^LanHost, conn: u32, key: (i32) {
}
    // rust: self.store_cart_items(key);
    // rust: let other_viewers =
    // rust: Self::vehicle_has_other_viewers(self.container, &host.hub.guests, Some(conn), key);
    // rust: if !other_viewers {
    // rust: self.world.block_entities.remove(&key);
}
    // rust: let at = if let Some(b) = self.boats.iter().find(|b| b.id as i32 == key.2) {
    // rust: Some([b.position.x, b.position.y, b.position.z])
    // rust: } else if let Some(c) = self.carts.iter().find(|c| c.id as i32 == key.2) {
    // rust: (c.kind == super::minecarts::CartKind::Chest).then_some([
    // rust: c.position.x,
    // rust: c.position.y,
    // rust: c.position.z,
    // rust: ])
    // rust: } else {
    // rust: None
}
    // rust: if let Some(at) = at {
    // rust: let spect = host.hub.guest(conn).is_some_and(|g| g.spectator());
    // rust: let ctx = horizon_client::sculk::Context {
    // rust: source: Some(horizon_client::mobs::Who::Player),
    // rust: spectator: spect,
    // rust: targetable: !spect,
    // rust: living: true,
    // rust: player: true,
    // rust: ..Default::default()
}
    // rust: self.post_game_event("minecraft:container_close", at, ctx);
}
}

    // `ServerPlayer.tick`'s `stillValid`: a guest's block container closes
    // once the guest is out of reach of its block (a removed block closes it
    // in the hub's `sync_containers`).
lan_containers_tick :: proc(self: ^Self, host: ^LanHost) {
}
    // rust: let far: Vec<(u32, Option<(i32, i32, i32)>)> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g))
    // rust: .filter(|g| !self.container_menu_valid(g))
    // rust: .map(|g| {
    // rust: let vehicle = g.menu.as_ref().and_then(|m| match m.slots {
    // rust: Slots::Block(key) if key.1 == super::minecarts::CART_KEY_Y => Some(key),
    // rust: _ => None,
    // rust: });
    // rust: (g.conn, vehicle)
    // rust: })
    // rust: .collect();
    // rust: for (conn, vehicle) in far {
    // rust: self.guest_container_closed(host, conn);
    // rust: host.hub.close_container(conn);
    // rust: if let Some(key) = vehicle {
    // rust: self.close_guest_vehicle_menu(host, conn, key);
}
    // rust: if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) {
    // rust: self.guest_carried_back(host, gi);
}
}
}

    // `stillValid` of the guest's open container: its blocks are still there
    // and in reach, or its vehicle exists and is in reach. True with none open.
container_menu_valid :: proc(self: ^Self, g: ^horizon_client::lan::guest::Guest) -> b {
    // Ported from Horizon
    return {}
}
    // rust: g.menu.as_ref().is_none_or(|m| {
    // rust: !(m.slots.valid(&self.world) && !m.slots.still_valid(&self.world, g, m.pos))
    // rust: && !m.pos.is_some_and(|k| {
    // rust: k.1 == super::minecarts::CART_KEY_Y && !self.chest_vehicle_still_valid(k.2, g)
    // rust: })
    // rust: })
}

    // `AbstractContainerMenu.stillValid` of whatever menu the guest has open
    // (a container or vehicle, a trade, the crafting table, a station, a
    // lectern, a mount's inventory). True when none is open.
guest_menu_still_valid :: proc(self: ^Self, host: ^LanHost, conn: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return true;
}
    // rust: if !self.container_menu_valid(g) {
    // rust: return false;
}
    // rust: let Some(p) = host.play.get(&conn) else {
    // rust: return true;
}
    // rust: p.crafting
    // rust: .table
    // rust: .as_ref()
    // rust: .is_none_or(|t| self.lan_table_valid(g, t.3))
    // rust: && p.station
    // rust: .as_ref()
    // rust: .is_none_or(|s| self.lan_station_valid(g, s))
    // rust: && p.lectern
    // rust: .as_ref()
    // rust: .is_none_or(|l| self.lan_lectern_valid(g, l.key))
    // rust: && p.merchant
    // rust: .as_ref()
    // rust: .and_then(|m| m.merchant.mob)
    // rust: .is_none_or(|id| self.lan_merchant_valid(g, id))
    // rust: && p.mount_window
    // rust: .as_ref()
    // rust: .is_none_or(|m| self.lan_mount_valid(g, m.mob))
}

    // The check before a menu click: a menu that is no longer valid closes
    // (returning what it held, as `ContainerClose` does) and the client's
    // window with it, so the click lands on nothing
    // (`ServerGamePacketListenerImpl.handleContainerClick` and the others
    // ask `stillValid` first).
guest_validate_menu :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: if self.guest_menu_still_valid(host, conn) {
    // rust: return;
}
    // rust: let mut windows: Vec<i32> = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .and_then(|g| g.menu.as_ref().map(|m| m.window))
    // rust: .into_iter()
    // rust: .collect();
    // rust: if let Some(p) = host.play.get(&conn) {
    // rust: windows.extend(p.crafting.table.as_ref().map(|t| t.0));
    // rust: windows.extend(p.station.as_ref().map(|s| s.window));
    // rust: windows.extend(p.lectern.as_ref().map(|l| l.window));
    // rust: windows.extend(p.merchant.as_ref().map(|m| m.window));
    // rust: windows.extend(p.mount_window.as_ref().map(|m| m.window));
}
    // rust: self.guest_close_all(host, conn);
    // rust: for container in windows {
    // rust: host.hub
    // rust: .send_to(conn, &C::ContainerClose(play::ContainerClose { container }));
}
}

    // `ContainerEntity.isChestVehicleStillValid`: the chest minecart or chest
    // boat is still there and within the guest's entity interaction range
    // plus 4 of its box.
chest_vehicle_still_valid :: proc(self: ^Self, id: i32, g: ^horizon_client::lan::guest::Guest) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bounds = self
    // rust: .carts
    // rust: .iter()
    // rust: .find(|c| c.id as i32 == id)
    // rust: .map(|c| c.bounds())
    // rust: .or_else(|| {
    // rust: self.boats
    // rust: .iter()
    // rust: .find(|b| b.id as i32 == id)
    // rust: .map(|b| b.bounds())
    // rust: });
    // rust: bounds.is_some_and(|b| guest_within_entity_range(g, &b, 4.0))
}

    // DedicatedServer.isUnderSpawnProtection: no operators, an operator or a
    // radius of 0 or less is never under it; else a block within the radius
    // of the world spawn (square, in the Overworld) is.
under_spawn_protection :: proc(self: ^Self, host: ^LanHost, gi: uint, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let g = &host.hub.guests[gi];
    // rust: let radius = host.hub.spawn_protection;
    // rust: if self.options.dedicated.is_none() || radius <= 0 || g.dimension != "minecraft:overworld" {
    // rust: return false;
}
    // rust: let Some(spawn) = self.level.world_spawn else {
    // rust: return false;
}
    // rust: if host.hub.ops.is_empty() || host.hub.ops.contains_key(&g.uuid) {
    // rust: return false;
}
    // rust: let dx = pos[0].abs_diff(spawn[0]);
    // rust: let dz = pos[2].abs_diff(spawn[2]);
    // rust: dx.max(dz) <= radius as u32
}

    // ServerPlayer.sendSpawnProtectionMessage.
spawn_protection_message :: proc(self: ^Self, host: ^LanHost, conn: u32, pos: [i32; 3]) {
}
    // rust: let message = horizon_client::text::Text::translate(
    // rust: "build.spawn_protection",
    // rust: &[horizon_client::text::Text::literal(format!(
    // rust: "{}, {}, {}",
    // rust: pos[0], pos[1], pos[2]
    // rust: ))],
    // rust: )
    // rust: .with_color(horizon_client::text::RED);
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content: horizon_client::lan::data::component_nbt(&message.component()),
    // rust: overlay: true,
    // rust: }),
    // rust: );
}

    // `ServerGamePacketListenerImpl.wasBlockPlacementAttempt`: a block item,
    // or a bucket with something in it, that is not cooling down.
was_block_placement_attempt :: proc(self: ^Self, hand: Hand) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(stack) = self.with_hand(hand, |g| g.held().cloned()) else {
    // rust: return false;
}
    // rust: let Some(info) = self.items().get(&stack.item).cloned() else {
    // rust: return false;
}
    // rust: (info.block.is_some() || horizon_client::items::bucket_contents(&stack.item).is_some())
    // rust: && !self
    // rust: .cooldowns
    // rust: .is_on_cooldown(&horizon_client::cooldowns::group(
    // rust: &stack,
    // rust: info.use_cooldown.as_ref(),
    // rust: ))
}

    // `ServerPlayer.sendBuildLimitMessage`: the red overlay with the limit.
build_limit_message :: proc(self: ^Self, host: ^LanHost, conn: u32, too_high: bool, limit: i32) {
}
    // rust: let message = horizon_client::text::Text::translate(
    // rust: if too_high {
    // rust: "build.tooHigh"
    // rust: } else {
    // rust: "build.tooLow"
    // rust: },
    // rust: &[horizon_client::text::Text::literal(limit.to_string())],
    // rust: )
    // rust: .with_color(horizon_client::text::RED);
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content: horizon_client::lan::data::component_nbt(&message.component()),
    // rust: overlay: true,
    // rust: }),
    // rust: );
}

    // A guest's client started or stopped flying (the hub applied it): the
    // mods hear it with the guest's state swapped in, and when one cancels,
    // the guest keeps what they had and is sent their abilities again, as
    // vanilla answers what it refuses.
    // rust: pub(super) fn lan_flight_toggled(&mut self, host: &mut LanHost, conn: u32, flying: bool) {
    // rust: let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone())) else {
    // rust: return;
}
    // rust: let mut cancel = false;
        // With the guest's state swapped in, so that the helpers reach them.
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.native_player_toggle_flight(uuid, &name, flying, &mut cancel);
    // rust: });
    // rust: if !cancel {
    // rust: return;
}
    // rust: if let Some(g) = host.hub.guest_mut(conn) {
    // rust: g.flying = !flying;
    // rust: g.send(&C::PlayerAbilities(play::PlayerAbilities {
    // rust: flags: g.ability_flags(),
    // rust: flying_speed: 0.05,
    // rust: walking_speed: 0.1,
    // rust: }));
}
}

    // A packet from a guest that the hub does not handle itself.
    // rust: pub(super) fn lan_guest_packet(&mut self, host: &mut LanHost, conn: u32, packet: S) {
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
        // A dead player acts no more, but the death screen still respawns and chats: its
        // commands run as anyone's (ServerGamePacketListenerImpl.handleChatCommand doesn't
        // look at the player's health).
    // rust: if host.hub.guests[gi].dead
    // rust: && !matches!(
    // rust: packet,
    // rust: S::ClientCommand(_) | S::ChatCommand(_) | S::ChatCommandSigned(_)
    // rust: )
    // rust: {
    // rust: return;
}
    // rust: if matches!(
    // rust: packet,
    // rust: S::ContainerClick(_)
    // rust: | S::ContainerButtonClick(_)
    // rust: | S::ContainerSlotStateChanged(_)
    // rust: | S::RenameItem(_)
    // rust: | S::SetBeacon(_)
    // rust: | S::SelectTrade(_)
    // rust: | S::SelectBundleItem(_)
    // rust: | S::PlaceRecipe(_)
    // rust: ) {
    // rust: self.guest_validate_menu(host, conn);
}
    // rust: let spectator = host.hub.guests[gi].spectator();
    // rust: match packet {
    // rust: S::PlayerAction(a) => match a.action {
    // rust: 0 => {
    // rust: host.hub.ack(conn, a.sequence);
    // rust: if spectator {
    // rust: return;
}
    // rust: if !host.hub.guests[gi].may_reach_block(a.pos) {
    // rust: return;
}
                    // ServerPlayerGameMode.handleBlockBreakAction: no dig starts
                    // under spawn protection (the ack puts the block back).
    // rust: if self.under_spawn_protection(host, gi, a.pos) {
    // rust: self.spawn_protection_message(host, conn, a.pos);
    // rust: return;
}
                    // mayInteract: a block outside the world border can't be
                    // dug (the ack puts it back on the client).
    // rust: if !self
    // rust: .border
    // rust: .contains(f64::from(a.pos[0]), f64::from(a.pos[2]))
    // rust: {
    // rust: return;
}
    // rust: let face = direction(i32::from(a.direction));
                    // Native mods, once the dig may start: a canceled click
                    // attacks, digs and breaks nothing (the ack puts the
                    // block back on the client).
    // rust: let canceled = self.as_guest(host, conn, |g| {
    // rust: let state = g.world.block(a.pos[0], a.pos[1], a.pos[2]);
    // rust: let mut canceled = false;
    // rust: g.native_left_click_block(a.pos, face, state, &mut canceled);
    // rust: canceled
    // rust: });
    // rust: if canceled == Some(true) {
    // rust: return;
}
    // rust: let play = host.play.entry(conn).or_default();
    // rust: play.digging = Some((a.pos, face));
    // rust: play.dig_start = host.hub.ticks;
    // rust: play.last_progress = -1;
                    // The pause between two blocks is the client's (MultiPlayerGameMode's
                    // destroyDelay); the server digs from the START it receives.
    // rust: play.destroy_delay = 0;
                    // ServerPlayerGameMode.handleBlockBreakAction: a creative START
                    // destroys the block at once (destroyAndAck "creative destroy"),
                    // so a UseItemOn sent behind it in the same tick (both buttons
                    // at once, #3006) replaces the air it left. A survival START
                    // attacks the block at once, so a tap released in the same tick
                    // still plays a note. The dig is marked begun for tick_mining.
    // rust: let pos = a.pos;
    // rust: let destroyed = self.as_guest(host, conn, |g| {
    // rust: if g.creative {
    // rust: let _ = g.break_block(pos);
    // rust: return true;
}
    // rust: if !g.block_action_restricted(pos) {
    // rust: let _ = g.attack_block(pos);
    // rust: g.mining = Some(Mining {
    // rust: pos,
    // rust: progress: 0.0,
    // rust: ticks: 0,
    // rust: });
}
    // rust: false
    // rust: });
    // rust: if destroyed == Some(true)
    // rust: && let Some(play) = host.play.get_mut(&conn)
    // rust: {
    // rust: play.digging = None;
}
                    // ServerPlayerGameMode.handleBlockBreakAction writes `destroyPos`
                    // only for a dig that takes more than one hit: a creative START
                    // and an instant one leave no block behind for a later STOP.
    // rust: if destroyed != Some(true) {
    // rust: let one_hit = self
    // rust: .as_guest(host, conn, |g| g.destroy_progress(pos))
    // rust: .is_some_and(|p| p >= 1.0);
    // rust: if !one_hit && let Some(play) = host.play.get_mut(&conn) {
    // rust: play.destroy_pos = Some(pos);
}
}
}
    // rust: 1 => {}
    // rust: 3 => {
    // rust: host.hub.ack(conn, a.sequence);
    // rust: if !host.hub.guests[gi].may_reach_block(a.pos) {
                        // Too far (handleBlockBreakAction's "too far"): the ack has the client
                        // undo its prediction, and only the dig drops — `destroy_pos` and the
                        // ticks since its START stay, so a STOP for the same block after the
                        // guest comes back into reach counts them (#4124).
    // rust: host.play.entry(conn).or_default().dig_ended();
    // rust: return;
}
    // rust: self.guest_stop_digging(host, conn, a.pos);
}
    // rust: 2 => {
    // rust: host.hub.ack(conn, a.sequence);
                    // ServerPlayerGameMode.abortDestroyBlock clears the dig and the crack; the
                    // clock `destroy_pos` names is left to the next START (#4124).
    // rust: host.play.entry(conn).or_default().dig_ended();
    // rust: let state = self.world.block(a.pos[0], a.pos[1], a.pos[2]).0 as i32;
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::BlockUpdate(play::BlockUpdate { pos: a.pos, state }),
    // rust: );
    // rust: self.destroy_block_progress(host.hub.guests[gi].entity_id, a.pos, -1);
    // rust: host.hub.broadcast_near(
    // rust: [
    // rust: f64::from(a.pos[0]),
    // rust: f64::from(a.pos[1]),
    // rust: f64::from(a.pos[2]),
    // rust: ],
    // rust: 64.0,
    // rust: &C::BlockDestruction(play::BlockDestruction {
    // rust: id: host.hub.guests[gi].entity_id,
    // rust: pos: a.pos,
    // rust: progress: 255,
    // rust: }),
    // rust: Some(conn),
    // rust: );
    // rust: let guest = &host.hub.guests[gi];
    // rust: self.native_block_damage_abort(guest.uuid, &guest.name, a.pos);
}
    // rust: 4 | 5 => {
    // rust: if !spectator {
    // rust: self.as_guest(host, conn, |g| g.drop_held(a.action == 4));
}
}
                // RELEASE_USE_ITEM: ServerPlayer.releaseUsingItem, with the
                // hand of the item in use acting.
    // rust: 6 => {
    // rust: let listening = !horizon_client::mod_api::mods().is_empty();
    // rust: let (uuid, name) = if listening {
    // rust: let guest = &host.hub.guests[gi];
    // rust: (guest.uuid, guest.name.clone())
    // rust: } else {
    // rust: (0, String::new())
}
    // rust: self.as_guest(host, conn, |g| {
    // rust: let Some(hand) = g.used_hand() else {
    // rust: return;
}
    // rust: g.with_hand(hand, |g| {
    // rust: if let Some((slot, ticks)) = g.using.take()
    // rust: && let Some(stack) = g.stack_in(slot).cloned()
    // rust: {
    // rust: if listening
    // rust: && &*stack.item == "minecraft:bow"
    // rust: && let Some(arrow) = g
    // rust: .projectile_slot("minecraft:bow")
    // rust: .and_then(|slot| g.stack_in(slot).map(|s| s.item.clone()))
    // rust: {
    // rust: g.native_player_ready_arrow(uuid, &name, &arrow);
}
    // rust: g.release_used_item(&stack, ticks, false);
    // rust: if listening {
    // rust: g.native_player_stop_using_item(uuid, &name);
}
}
    // rust: });
    // rust: });
}
                // SWAP_ITEM_WITH_OFFHAND: the hands swap and the item in use stops
                // (ServerGamePacketListenerImpl.handlePlayerAction), not for spectators.
    // rust: 7 if !spectator => {
                    // The mods hear the swap first, and may stop it: the
                    // client, which swapped at once, gets its slots back.
    // rust: let (uuid, name) = {
    // rust: let g = &host.hub.guests[gi];
    // rust: (g.uuid, g.name.clone())
}
                    // With the player's state swapped in, so that the helpers
                    // reach them.
    // rust: let cancel = self
    // rust: .as_guest(host, conn, |g| {
    // rust: let mut cancel = false;
    // rust: g.native_player_swap_hands(uuid, &name, &mut cancel);
    // rust: cancel
    // rust: })
    // rust: .unwrap_or(false);
    // rust: if cancel {
    // rust: host.hub.send_inventory(gi);
    // rust: return;
}
    // rust: let g = &mut host.hub.guests[gi];
    // rust: let slot = g.selected;
    // rust: std::mem::swap(&mut g.inventory[slot], &mut g.offhand);
    // rust: let (offhand, main) = (g.offhand.clone(), g.inventory[slot].clone());
    // rust: if let Some(play) = host.play.get_mut(&conn) {
    // rust: play.using = None;
}
                    // setItemInHand: the off hand, then the main hand.
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.player_on_equip("offhand", main.as_ref(), offhand.as_ref());
    // rust: g.player_on_equip("mainhand", offhand.as_ref(), main.as_ref());
    // rust: });
    // rust: let guest = &host.hub.guests[gi];
    // rust: self.native_player_swap_with_equipment_slot(guest.uuid, &guest.name, "offhand");
}
                // STAB: `PiercingWeapon.attack` of a left click with a spear.
    // rust: 8 if !spectator => self.guest_jab(host, conn),
    // rust: _ => {}
    // rust: },
            // handleSetCarriedItem: a new slot stops a main-hand use.
    // rust: S::SetCarriedItem(p) => {
    // rust: if !(0..9).contains(&p.slot) {
    // rust: eprintln!(
    // rust: "{} tried to set an invalid carried item",
    // rust: host.hub.guests[gi].name
    // rust: );
    // rust: return;
}
    // rust: let (uuid, name, old_slot) = {
    // rust: let g = &host.hub.guests[gi];
    // rust: (g.uuid, g.name.clone(), g.selected)
}
    // rust: if old_slot != p.slot as usize {
    // rust: let mut cancel = false;
    // rust: self.native_player_item_held(
    // rust: uuid,
    // rust: &name,
    // rust: old_slot as i32,
    // rust: i32::from(p.slot),
    // rust: &mut cancel,
    // rust: );
    // rust: if cancel {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SetHeldSlot(play::SetHeldSlot {
    // rust: slot: old_slot as i32,
    // rust: }),
    // rust: );
    // rust: return;
}
}
    // rust: let g = &mut host.hub.guests[gi];
    // rust: let changed = g.selected != p.slot as usize;
    // rust: g.selected = p.slot as usize;
    // rust: if let Some(play) = host.play.get_mut(&conn)
    // rust: && changed
    // rust: && play
    // rust: .using
    // rust: .is_some_and(|(slot, _)| slot != super::shield::OFFHAND_SLOT)
    // rust: {
    // rust: play.using = None;
}
}
            // ServerGamePacketListenerImpl.handlePunch: the main hand swings
            // with the held item's attack animation (mining, attacking, a
            // click on nothing), seen by the players around, and the attack
            // strength starts again.
    // rust: S::Punch(_) => {
    // rust: let (player, name) = {
    // rust: let g = &host.hub.guests[gi];
    // rust: (g.uuid, g.name.clone())
}
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.swing_hand(Hand::Main, SwingAnimation::DEFAULT);
    // rust: g.reset_attack_strength();
    // rust: });
    // rust: self.native_player_attack_cooldown_reset(player, &name);
    // rust: self.native_player_arm_swing(player, &name, "mainhand");
}
    // rust: S::UseItemOn(p) => {
    // rust: host.hub.ack(conn, p.sequence);
                // handleUseItemOn: within reach, then the hit point within
                // a block of the block's centre (logged when it isn't).
    // rust: if !host.hub.guests[gi].may_reach_block(p.pos) {
    // rust: return;
}
    // rust: let inside = p
    // rust: .cursor
    // rust: .iter()
    // rust: .all(|&c| (f64::from(c) - 0.5).abs() < 1.0000001);
    // rust: if !inside {
    // rust: let d = horizon_client::java_text::double_to_string;
    // rust: let at = |k: usize| d(f64::from(p.pos[k]) + f64::from(p.cursor[k]));
    // rust: let line = format!(
    // rust: "Rejecting UseItemOnPacket from {}: Location ({}, {}, {}) too far away from hit block BlockPos{{x={}, y={}, z={}}}.",
    // rust: host.hub.guests[gi].name,
    // rust: at(0),
    // rust: at(1),
    // rust: at(2),
    // rust: p.pos[0],
    // rust: p.pos[1],
    // rust: p.pos[2]
    // rust: );
    // rust: self.lan_log_event(horizon_client::lan::hub::HostEvent::Warn(line));
    // rust: return;
}
    // rust: let face = direction(p.face);
    // rust: let hit = Hit {
    // rust: pos: p.pos,
    // rust: face,
    // rust: point: [
    // rust: f64::from(p.pos[0]) + f64::from(p.cursor[0]),
    // rust: f64::from(p.pos[1]) + f64::from(p.cursor[1]),
    // rust: f64::from(p.pos[2]) + f64::from(p.cursor[2]),
    // rust: ],
}
    // rust: let hand = if p.hand == 1 { Hand::Off } else { Hand::Main };
                // handleUseItemOn: above or below the world nothing is used and
                // the player is told the limit (the blocks are not resent);
                // under spawn protection nothing is used or placed; the player
                // is told and the blocks below go back. mayInteract: nothing is
                // used on a block outside the world border either.
    // rust: let min_y = self.world.shape.min_y;
    // rust: let max_y = self.world.shape.max_y() - 1;
    // rust: if p.pos[1] > max_y {
    // rust: self.build_limit_message(host, conn, true, max_y);
    // rust: return;
}
    // rust: if p.pos[1] < min_y {
    // rust: self.build_limit_message(host, conn, false, min_y);
    // rust: return;
}
    // rust: if self.under_spawn_protection(host, gi, p.pos) {
    // rust: self.spawn_protection_message(host, conn, p.pos);
    // rust: } else if self
    // rust: .border
    // rust: .contains(f64::from(p.pos[0]), f64::from(p.pos[2]))
    // rust: {
    // rust: let logged = self.world.block_log.as_ref().map_or(0, Vec::len);
    // rust: let heard = self.audio.capture.as_ref().map_or(0, Vec::len);
    // rust: let used = self.as_guest(host, conn, |g| {
    // rust: let attempt = g.was_block_placement_attempt(hand);
    // rust: g.forced_hit = Some(hit);
    // rust: g.guest_use = Some(GuestUse::OnBlock(hand));
    // rust: let swings = g.swings_started;
                        // InteractionResult.consumesAction: a FAIL (`use_failed`,
                        // as BlockItem.place's failed placement) does not count,
                        // even though the click ended on it.
    // rust: let consumed = matches!(g.use_item(), Ok(Some(_))) && !g.use_failed;
                        // handleUseItemOn: a consuming useItemOn triggers
                        // ANY_BLOCK_USE with the hand's stack as it now is.
    // rust: if consumed {
    // rust: let stack = g
    // rust: .with_hand(hand, |g| g.held().cloned())
    // rust: .unwrap_or_else(|| ItemStack::new("minecraft:air", 0));
    // rust: horizon_client::spans::time("use_advancements", || {
    // rust: g.trigger_any_block_use(p.pos, &stack);
    // rust: });
}
    // rust: g.forced_hit = None;
    // rust: g.guest_use = None;
    // rust: (g.swings_started != swings, consumed, attempt)
    // rust: });
    // rust: let swung = used.map(|u| u.0);
    // rust: self.lan_swing_back(host, conn, swung);
    // rust: self.guest_use_sounds(host, conn, logged, heard);
                    // A placement that did nothing at the top or bottom of the
                    // world says why. Vanilla asks twice for the top (once
                    // before the swing, once in the check that also has the
                    // bottom), so a player there is told twice.
    // rust: if let Some((_, false, true)) = used {
    // rust: if p.face == 1 && p.pos[1] >= max_y {
    // rust: self.build_limit_message(host, conn, true, max_y);
    // rust: self.build_limit_message(host, conn, true, max_y);
    // rust: } else if p.face == 0 && p.pos[1] <= min_y {
    // rust: self.build_limit_message(host, conn, false, min_y);
}
}
    // rust: } else {
    // rust: self.build_limit_message(host, conn, true, max_y);
}
                // The client predicted a result: correct it with what really is.
    // rust: for pos in [
    // rust: p.pos,
    // rust: [p.pos[0] + face[0], p.pos[1] + face[1], p.pos[2] + face[2]],
    // rust: ] {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]).0 as i32;
    // rust: host.hub
    // rust: .send_to(conn, &C::BlockUpdate(play::BlockUpdate { pos, state }));
}
}
    // rust: S::UseItem(p) => {
    // rust: host.hub.ack(conn, p.sequence);
    // rust: if spectator {
    // rust: return;
}
                // handleUseItem: the client's rotation (absSnapRotationTo, which
                // sends nothing back), then the item alone. What it looked at a
                // moment ago (a block, a mob) is UseItemOn's or Interact's.
    // rust: let hand = if p.hand == 1 { Hand::Off } else { Hand::Main };
    // rust: let g = &mut host.hub.guests[gi];
    // rust: (g.yaw, g.pitch) = (p.yaw, p.pitch);
                // SpawnEggItem.use calls ServerLevel.mayInteract at its own
                // fluid ray's position, unlike useOn's packet-supplied block.
    // rust: let held = if hand == Hand::Off {
    // rust: g.offhand.as_ref()
    // rust: } else {
    // rust: g.inventory.get(g.selected).and_then(Option::as_ref)
}
    // rust: if held.is_some_and(|s| s.item.ends_with("_spawn_egg")) {
    // rust: let hit = self
    // rust: .as_guest(host, conn, |g| {
    // rust: g.with_hand(hand, |g| g.spawn_egg_fluid_hit())
    // rust: })
    // rust: .flatten();
    // rust: if hit.is_some_and(|h| self.under_spawn_protection(host, gi, h.pos)) {
    // rust: return;
}
}
    // rust: let heard = self.audio.capture.as_ref().map_or(0, Vec::len);
    // rust: let used = self.as_guest(host, conn, |g| {
                    // A horn's sound, inline instruments included.
    // rust: let horn = g.with_hand(hand, |g| {
    // rust: let held = g.held()?;
    // rust: g.res.items().instrument(held).map(|i| i.sound)
    // rust: });
    // rust: g.guest_use = Some(GuestUse::Item(hand));
    // rust: let swings = g.swings_started;
    // rust: let _ = g.use_item();
    // rust: g.guest_use = None;
    // rust: (g.swings_started != swings, horn)
    // rust: });
    // rust: let (swung, horn) = match used {
    // rust: Some((swung, horn)) => (Some(swung), horn),
    // rust: None => (None, None),
}
    // rust: self.lan_swing_back(host, conn, swung);
    // rust: self.guest_instrument_sound(host, conn, heard, horn);
}
    // rust: S::Attack(p) => self.guest_attack(host, conn, p.id),
    // rust: S::Interact(p) => {
                // handleInteract: a target inside the world border, within the entity
                // interaction range plus 3 of its box, or nothing happens.
    // rust: if let Some(target) = self.guest_target_box(host, gi, p.id)
    // rust: && (!self.inside_border(&target)
    // rust: || self.as_guest(host, conn, |g| {
    // rust: g.within_entity_interaction_range(&target, 3.0)
    // rust: }) != Some(true))
    // rust: {
    // rust: return;
}
                // LeashFenceKnotEntity.interact: a knot has no entity here, only its fence.
    // rust: if let Some(knot) = self.knot_at_id(p.id) {
    // rust: let hand = if p.hand == 1 { Hand::Off } else { Hand::Main };
    // rust: let swung = self.as_guest(host, conn, |g| {
    // rust: let swings = g.swings_started;
    // rust: g.with_hand(hand, |g| g.use_knot(knot, true));
    // rust: g.swings_started != swings
    // rust: });
    // rust: self.lan_swing_back(host, conn, swung);
    // rust: return;
}
    // rust: let before = host.hub.guests[gi].vehicle;
    // rust: if self
    // rust: .look_at_entity(host, gi, p.id, Some(p.location))
    // rust: .is_some()
    // rust: {
                    // handleInteract: the entity and that hand only; a click the
                    // entity passes comes back as UseItem. The entity is the
                    // packet's own id, which the range check above passed.
    // rust: let hand = if p.hand == 1 { Hand::Off } else { Hand::Main };
    // rust: let target = InteractTarget {
    // rust: id: p.id,
    // rust: location: p.location,
}
    // rust: let swung = self.as_guest(host, conn, |g| {
    // rust: g.guest_use = Some(GuestUse::Entity(hand, target));
    // rust: let swings = g.swings_started;
    // rust: let _ = g.use_item();
    // rust: g.guest_use = None;
    // rust: g.swings_started != swings
    // rust: });
    // rust: self.lan_swing_back(host, conn, swung);
    // rust: self.guest_boarded(host, conn, before);
}
}
    // rust: S::MoveVehicle(p) => self.guest_move_vehicle(host, conn, &p),
    // rust: S::PaddleBoat(p) => self.guest_paddle_boat(host, conn, [p.left, p.right]),
            // handleSetCreativeModeSlot's drop: a slot below 0 is a stack thrown out of the
            // creative screen (`handleCreativeModeItemDrop`), dropped from the player's hand.
    // rust: S::SetCreativeModeSlot(p) if p.slot < 0 => {
    // rust: if !host.hub.guests[gi].creative() {
    // rust: return;
}
    // rust: let Some(stack) = self.item_from_network(host, &p.item) else {
    // rust: return;
}
    // rust: if !self.creative_stack_valid(host, gi, &stack) {
    // rust: return;
}
    // rust: if !self.guest_may_set_creative_slot(host, conn, i32::from(p.slot), Some(&stack)) {
    // rust: return;
}
    // rust: let play = host.play.entry(conn).or_default();
    // rust: if play.creative_drops >= 1480 {
    // rust: eprintln!(
    // rust: "Player {} was dropping items too fast in creative mode, ignoring.",
    // rust: host.hub.guests[gi].name
    // rust: );
    // rust: return;
}
    // rust: play.creative_drops += 20;
    // rust: self.as_guest(host, conn, |g| g.player_drop(stack));
}
    // rust: S::SetCreativeModeSlot(p) => {
                // Slot 0 is the crafting result: not a slot to set.
    // rust: let g = &mut host.hub.guests[gi];
    // rust: if !g.creative() || !(1..46).contains(&p.slot) {
    // rust: return;
}
    // rust: let item = self.item_from_network(host, &p.item);
    // rust: if item
    // rust: .as_ref()
    // rust: .is_some_and(|s| !self.creative_stack_valid(host, gi, s))
    // rust: {
    // rust: return;
}
    // rust: if !self.guest_may_set_creative_slot(host, conn, i32::from(p.slot), item.as_ref()) {
                    // The creative client already holds the stack it sent: treat that as
                    // what it was told, so the next broadcast sends the real slot back.
    // rust: host.hub.guests[gi].menu_sent[p.slot as usize] = item;
    // rust: return;
}
    // rust: let slot = p.slot as usize;
    // rust: let g = &mut host.hub.guests[gi];
    // rust: let old = g.menu_slot(slot);
    // rust: g.set_menu_slot(slot, item.clone());
                // InventoryMenu.setRemoteSlot: the client already has it, so broadcastChanges
                // sends nothing back that could undo a click made since.
    // rust: g.menu_sent[slot] = item.clone();
                // InventoryMenu's ArmorSlot and off-hand slot: setByPlayer.
    // rust: let equipment = match slot {
    // rust: 5..=8 => Some(["head", "chest", "legs", "feet"][slot - 5]),
    // rust: 45 => Some("offhand"),
    // rust: _ => None,
}
    // rust: if let Some(equipment) = equipment {
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.player_on_equip(equipment, old.as_ref(), item.as_ref());
    // rust: });
}
}
            // AbstractContainerMenu.quickMoveStack of a mod container: the mods first.
    // rust: S::ContainerClick(p) if self.lan_mod_quick_move(host, conn, &p) => {}
    // rust: S::ContainerClick(p) if self.lan_merchant_click(host, conn, &p) => {}
    // rust: S::ContainerClick(p) if self.lan_inventory_click(host, conn, &p) => {}
    // rust: S::ContainerClick(p) if self.lan_crafting_click(host, conn, &p) => {}
    // rust: S::ContainerClick(p) if self.lan_machine_click(host, conn, &p) => {}
    // rust: S::ContainerClick(p) if self.lan_station_click(host, conn, &p) => {}
    // rust: S::ContainerClick(p) if self.lan_lectern_click(host, conn, &p) => {}
    // rust: S::ContainerClick(p) if self.lan_mount_click(host, conn, &p) => {}
            // ServerboundPlayerCommandPacket OPEN_INVENTORY: the ridden
            // mount's inventory (`HasCustomInventoryScreen`).
    // rust: S::PlayerCommand(p) if p.action == 5 => {
    // rust: self.as_guest(host, conn, |g| {
                    // HasCustomInventoryScreen: a tamed mount's horse
                    // inventory, or a chest boat's chest.
    // rust: if !g.open_ridden_mount_menu() {
    // rust: g.open_ridden_chest_boat();
}
    // rust: });
}
    // rust: S::PlayerCommand(p) if p.action == 6 => self.lan_start_gliding(host, conn),
            // START_RIDING_JUMP: the mount's handleStartJump.
    // rust: S::PlayerCommand(p) if p.action == 3 => {
    // rust: self.lan_start_riding_jump(host, conn, p.data);
}
            // STOP_RIDING_JUMP: AbstractHorse and Camel handleStopJump do
            // nothing, and a nautilus' dash is not stopped this way.
    // rust: S::PlayerCommand(p) if p.action == 4 => {}
            // ServerboundResourcePackPacket in play: the server has nothing to
            // do with it (a declined required pack is handled on the connection).
    // rust: S::ResourcePack(r) => {
    // rust: let (uuid, name) = (host.hub.guests[gi].uuid, host.hub.guests[gi].name.clone());
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.native_resource_pack_status(uuid, &name, r.action);
    // rust: });
}
            // START_SPRINTING and STOP_SPRINTING: the hub has set the sprint
            // and sends the packet on when it changed it.
    // rust: S::PlayerCommand(p) if matches!(p.action, 1 | 2) => {
    // rust: let (uuid, name) = (host.hub.guests[gi].uuid, host.hub.guests[gi].name.clone());
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.native_player_sprint(uuid, &name, p.action == 1);
    // rust: });
}
    // rust: S::ContainerButtonClick(p) => {
    // rust: self.lan_station_button(host, conn, p.container, p.button);
}
    // rust: S::RenameItem(p) => self.lan_station_rename(host, conn, &p.name),
    // rust: S::SignUpdate(p) => self.lan_sign_update(host, conn, p),
    // rust: S::SetCommandBlock(p) => self.lan_set_command_block(host, conn, p),
    // rust: S::SetCommandMinecart(p) => self.lan_set_command_minecart(host, conn, p),
    // rust: S::SetStructureBlock(p) => self.lan_set_structure_block(host, conn, p),
    // rust: S::TestInstanceBlockAction(p) => self.lan_test_instance_action(host, conn, p),
    // rust: S::SetTestBlock(p) => self.lan_set_test_block(host, conn, p),
    // rust: S::SetJigsawBlock(p) => self.lan_set_jigsaw_block(host, conn, p),
    // rust: S::JigsawGenerate(p) => self.lan_jigsaw_generate(host, conn, p),
    // rust: S::EditBook(p) => self.lan_edit_book(host, conn, p),
    // rust: S::ContainerSlotStateChanged(p) => {
    // rust: self.lan_crafter_slot_state(host, conn, p.container, p.slot, p.enabled);
}
    // rust: S::SetBeacon(p) => self.lan_station_beacon(host, conn, p.primary, p.secondary),
    // rust: S::SelectTrade(p) => self.lan_select_trade(host, conn, p.item),
    // rust: S::ContainerClose(p) if self.lan_merchant_closed(host, conn, Some(p.container)) => {
    // rust: self.guest_carried_back(host, gi);
}
    // rust: S::ContainerClose(p)
    // rust: if self.lan_crafting_closed(host, conn, Some(p.container))
    // rust: || self.lan_station_closed(host, conn, Some(p.container))
    // rust: || self.lan_mount_closed(host, conn, Some(p.container)) =>
    // rust: {
    // rust: self.guest_carried_back(host, gi);
}
    // rust: S::SelectBundleItem(p) => {
                // ServerGamePacketListenerImpl.handleBundleItemSelectedPacket: the slot
                // is the open menu's (#4436).
    // rust: let own = Self::lan_crafting_table_own_slots(host, conn)
    // rust: .or_else(|| Self::lan_station_own_slots(host, conn));
    // rust: let slot = usize::try_from(p.slot)
    // rust: .ok()
    // rust: .and_then(|slot| bundle_inventory_slot(slot, own));
    // rust: if !spectator && let Some(slot) = slot {
    // rust: host.hub
    // rust: .select_bundle_item(conn, slot, p.index, &mut self.world);
    // rust: let guest = &host.hub.guests[gi];
    // rust: self.native_player_bundle_item_select(guest.uuid, &guest.name, p.slot, p.index);
}
}
    // rust: S::ContainerClick(p) => {
    // rust: let rules = ItemRules(world_items!(self));
    // rust: let slots = host.hub.guests[gi]
    // rust: .menu
    // rust: .as_ref()
    // rust: .filter(|m| m.window == p.container)
    // rust: .map(|m| m.slots);
    // rust: let before = slots.and_then(|s| s.read(&self.world, &host.hub.guests[gi]));
    // rust: let drops = host.hub.container_click(conn, &p, &mut self.world, &rules);
                // A click that changed the container's slots: BlockEntity.setChanged,
                // so comparators read it again (a double chest's other half follows).
    // rust: if let Some(Slots::Block(key) | Slots::Double(key, _)) = slots
    // rust: && slots.and_then(|s| s.read(&self.world, &host.hub.guests[gi])) != before
    // rust: {
    // rust: self.container_changed(key);
}
                // A vehicle's menu edits the vehicle's own items.
    // rust: if let Some(Slots::Block(key)) = slots {
    // rust: self.store_cart_items(key);
}
    // rust: self.drop_guest_items(host, gi, drops);
}
    // rust: S::ContainerClose(p) => {
                // A vehicle's menu closed: its slots go back to the vehicle
                // (`ContainerEntity`), and a chest boat's `stopOpen` fires
                // CONTAINER_CLOSE with the player as the source.
    // rust: let vehicle = host.hub.guests[gi]
    // rust: .menu
    // rust: .as_ref()
    // rust: .filter(|m| m.window == p.container)
    // rust: .and_then(|m| match m.slots {
    // rust: Slots::Block(key) if key.1 == super::minecarts::CART_KEY_Y => Some(key),
    // rust: _ => None,
    // rust: });
    // rust: if host.hub.guests[gi]
    // rust: .menu
    // rust: .as_ref()
    // rust: .is_some_and(|m| m.window == p.container)
    // rust: {
    // rust: self.guest_container_closed(host, conn);
}
    // rust: if let Some(key) = vehicle {
    // rust: self.close_guest_vehicle_menu(host, conn, key);
}
    // rust: host.hub.container_closed(conn, p.container);
    // rust: self.guest_carried_back(host, gi);
}
    // rust: S::ChatCommand(c) => self.guest_chat_command(host, conn, &c.command),
    // rust: S::CustomPayload(p) if p.channel == horizon_protocol::quiet::CHANNEL => {
    // rust: self.guest_quiet_commands(host, conn, &p.data)
}
    // rust: S::CustomPayload(p) if p.channel == horizon_protocol::mod_net::CHANNEL => {
    // rust: self.guest_native_net(host, conn, &p.data)
}
    // rust: S::CustomPayload(p) if p.channel == horizon_client::lod_net::CHANNEL => {
    // rust: self.guest_far_terrain(host, conn, &p.data)
}
    // rust: S::ChatCommandSigned(p) => self.guest_signed_command(host, conn, p),
    // rust: S::ChangeDifficulty(p) if host.hub.guests[gi].permission >= 2 => {
    // rust: if !self.level.difficulty_locked && (0..=3).contains(&p.difficulty) {
    // rust: self.ui.difficulty = if self.level.hardcore {
    // rust: 3
    // rust: } else {
    // rust: p.difficulty as u8
}
                    // The level data holds the world's difficulty: it
                    // survives the reopen, so it follows the change.
    // rust: self.level.set_difficulty(self.ui.difficulty);
    // rust: self.sync_rules();
    // rust: host.hub
    // rust: .broadcast(&C::ChangeDifficulty(play::ChangeDifficulty {
    // rust: difficulty: i32::from(self.ui.difficulty),
    // rust: locked: self.level.difficulty_locked,
    // rust: }));
}
}
    // rust: S::LockDifficulty(p) if host.hub.guests[gi].permission >= 2 => {
    // rust: self.level.difficulty_locked = p.locked;
    // rust: host.hub
    // rust: .broadcast(&C::ChangeDifficulty(play::ChangeDifficulty {
    // rust: difficulty: i32::from(self.ui.difficulty),
    // rust: locked: self.level.difficulty_locked,
    // rust: }));
}
    // rust: S::ClientCommand(p) if p.action == 2 && host.hub.guests[gi].permission >= 2 => {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::GameRuleValues(play::GameRuleValues {
    // rust: entries: self
    // rust: .ui
    // rust: .rules
    // rust: .available_rules()
    // rust: .map(|r| play::GameRuleEntry {
    // rust: name: format!("minecraft:{}", r.name),
    // rust: value: self.ui.rules.get(r.name).unwrap_or(r.default).to_string(),
    // rust: })
    // rust: .collect(),
    // rust: }),
    // rust: );
}
    // rust: S::SetGameRule(p) if host.hub.guests[gi].permission >= 2 => {
    // rust: for entry in p.entries {
    // rust: if self.ui.rules.set_string(&entry.name, &entry.value) {
    // rust: let guest = &host.hub.guests[gi];
    // rust: self.native_world_game_rule_change(
    // rust: guest.uuid,
    // rust: &guest.name,
    // rust: &entry.name,
    // rust: &entry.value,
    // rust: );
    // rust: let message = horizon_client::text::Text::tr(
    // rust: "commands.gamerule.set",
    // rust: &[&entry.name, &entry.value],
    // rust: );
    // rust: let content =
    // rust: horizon_client::lan::data::component_nbt(&message.component());
    // rust: for g in &host.hub.guests {
    // rust: if g.permission >= 2 {
    // rust: g.send(&C::SystemChat(play::SystemChat {
    // rust: content: content.clone(),
    // rust: overlay: false,
    // rust: }));
}
}
    // rust: if self.options.dedicated.is_none() && self.allow_commands() {
    // rust: self.system_message(message);
}
}
}
    // rust: self.sync_rules();
}
            // handleTeleportToEntityPacket: a spectator goes to the player,
            // in whichever level they are.
    // rust: S::TeleportToEntity(p) if spectator => self.guest_spectate_teleport(host, gi, p.uuid),
    // rust: S::SpectatorAction(p) => self.guest_spectator_action(host, gi, p.target),
    // rust: S::ChangeGameMode(p) if host.hub.guests[gi].permission >= 2 => {
    // rust: if let Some(mode) = usize::try_from(p.mode)
    // rust: .ok()
    // rust: .and_then(|index| horizon_client::command::args::GameMode::ALL.get(index))
    // rust: {
    // rust: let lines = self.as_guest(host, conn, |g| {
    // rust: g.chat_capture = Some(Vec::new());
    // rust: g.change_game_mode(*mode);
    // rust: g.chat_capture
    // rust: .take()
    // rust: .unwrap_or_default()
    // rust: .iter()
    // rust: .map(|t| horizon_client::lan::data::component_nbt(&t.component()))
    // rust: .collect::<Vec<_>>()
    // rust: });
    // rust: for content in lines.unwrap_or_default() {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content,
    // rust: overlay: false,
    // rust: }),
    // rust: );
}
    // rust: self.send_admin_feedback(host, Some(conn));
}
}
    // rust: S::ChangeGameMode(p) => {
    // rust: if let Some(mode) = usize::try_from(p.mode)
    // rust: .ok()
    // rust: .and_then(|index| horizon_client::command::args::GameMode::ALL.get(index))
    // rust: {
    // rust: let name = horizon_client::text::Text::translate(
    // rust: &format!("gameMode.{}", mode.name()),
    // rust: &[],
    // rust: );
    // rust: eprintln!(
    // rust: "Player {} tried to change game mode to {} without required permissions",
    // rust: host.hub.guests[gi].name,
    // rust: name.plain()
    // rust: );
}
}
            // handleEntityTagQuery: a game master's F3+I on an entity of their
            // level gets its Entity.saveWithoutId.
    // rust: S::EntityTagQuery(p) if host.hub.guests[gi].permission >= 2 => {
    // rust: if let Some(tag) = self.level_entity_tag(host, p.entity) {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::TagQuery(play::TagQuery {
    // rust: transaction: p.transaction,
    // rust: tag,
    // rust: }),
    // rust: );
}
}
            // handleBlockEntityTagQuery: BlockEntity.saveWithoutMetadata, or
            // null where there is no block entity.
    // rust: S::BlockEntityTagQuery(p) if host.hub.guests[gi].permission >= 2 => {
    // rust: let tag = self
    // rust: .block_entity_tag(p.pos)
    // rust: .unwrap_or(horizon_world::nbt::Tag::End);
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::TagQuery(play::TagQuery {
    // rust: transaction: p.transaction,
    // rust: tag,
    // rust: }),
    // rust: );
}
    // rust: S::Unknown(id, payload)
    // rust: if id == horizon_protocol::ids::play::serverbound::COMMAND_SUGGESTION =>
    // rust: {
                // ServerCommandSuggestionsProvider.request, then trySchedule.
    // rust: host.play.entry(conn).or_default().suggestion = Some(payload);
    // rust: self.guest_try_suggestions(host, conn);
}
    // rust: S::PlaceRecipe(p) => self.lan_place_recipe(host, conn, &p),
            // handleClientCommand: PERFORM_RESPAWN after the poem leaves the End
            // (the next server tick sends the player on).
    // rust: S::ClientCommand(c)
    // rust: if c.action == 0 && host.play.get(&conn).is_some_and(|p| p.won_game) =>
    // rust: {
    // rust: host.play.entry(conn).or_default().respawn_requested = true;
}
    // rust: S::ClientCommand(c) if c.action == 0 => self.guest_respawn(host, conn),
            // ServerStatsCounter.sendStats.
    // rust: S::ClientCommand(c) if c.action == 1 => {
    // rust: let stats = host
    // rust: .play
    // rust: .get_mut(&conn)
    // rust: .map(|p| p.stats.take_dirty())
    // rust: .unwrap_or_default();
    // rust: host.hub.send_stats(conn, &stats);
}
            // handlePickItemFromBlock: a block within the block reach plus 1, its
            // data only with infinite materials.
    // rust: S::PickItemFromBlock(p) => {
    // rust: self.guest_pick_item(host, conn, false, p.pos, 0, |g| {
                    // handlePickItemFromBlock: within reach and loaded.
    // rust: if !g.world.loaded(p.pos[0], p.pos[2]) {
    // rust: return None;
}
    // rust: let eye = g.eye_position()?;
    // rust: let d2: f64 = (0..3)
    // rust: .map(|a| {
    // rust: let lo = f64::from(p.pos[a]);
    // rust: (eye[a] - eye[a].clamp(lo, lo + 1.0)).powi(2)
    // rust: })
    // rust: .sum();
    // rust: let range = g.reach() + 1.0;
    // rust: if d2 >= range * range {
    // rust: return None;
}
    // rust: g.picked_stack(p.pos, g.creative && p.include_data)
    // rust: });
}
            // handlePickItemFromEntity.
    // rust: S::PickItemFromEntity(p) => {
    // rust: self.guest_pick_item(host, conn, true, [0; 3], p.id, |g| {
    // rust: g.within_entity_range(p.id)
    // rust: .then(|| g.entity_pick_result(p.id))
    // rust: .flatten()
    // rust: });
}
    // rust: _ => {}
}
}

    // `ServerLevel.getEntity(id)`'s `Entity.saveWithoutId`: the player or
    // other entity of the level in place with that network id.
level_entity_tag :: proc(self: ^Self, host: ^LanHost, id: i32) -> O {
    // Ported from Horizon
    return {}
}
//         use super::commands::Target;
    // rust: let player = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id == id && host.hub.here(g))
    // rust: .map(|g| g.conn);
    // rust: let mut tag = match player {
    // rust: Some(player) => self
    // rust: .as_guest(host, player, |g| g.entity_nbt(Target::Player))
    // rust: .flatten()?,
    // rust: None => {
    // rust: let target = self.level_entity(id)?;
    // rust: self.entity_nbt(target)?
}
}
    // rust: if let horizon_world::nbt::Tag::Compound(c) = &mut tag {
    // rust: c.remove(&"id".into());
}
    // rust: Some(tag)
}

    // `ServerGamePacketListenerImpl.tryPickItem` for the guest: a matching stack
    // is selected, else a creative player gets the item; the held slot is sent
    // back and the changed slots follow with the tick's inventory changes.
    // rust: fn guest_pick_item(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: from_entity: bool,
    // rust: pos: [i32; 3],
    // rust: entity_id: i32,
    // rust: stack: impl FnOnce(&mut Self) -> Option<ItemStack>,
    // rust: ) {
    // rust: let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone())) else {
    // rust: return;
}
    // rust: let picked = self.as_guest(host, conn, |g| {
    // rust: let stack = stack(g)?;
    // rust: let infinite = g.creative;
    // rust: let mut cancel = false;
    // rust: g.native_player_pick_item(uuid, &name, from_entity, pos, entity_id, &mut cancel);
    // rust: if cancel {
    // rust: return None;
}
    // rust: horizon_client::pick_item::pick(
    // rust: &mut g.inventory[..36],
    // rust: &mut g.selected,
    // rust: &stack,
    // rust: infinite,
    // rust: );
    // rust: Some(())
    // rust: });
    // rust: if picked.flatten().is_some()
    // rust: && let Some(g) = host.hub.guests.iter().find(|g| g.conn == conn)
    // rust: {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SetHeldSlot(play::SetHeldSlot {
    // rust: slot: g.selected as i32,
    // rust: }),
    // rust: );
}
}

    // Whether the mods let a creative player set `slot` to `stack`
    // (`native_creative_slot`), heard with the guest's state swapped in.
    // rust: fn guest_may_set_creative_slot(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: slot: i32,
    // rust: stack: Option<&ItemStack>,
    // rust: ) -> bool {
    // rust: let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone())) else {
    // rust: return true;
}
    // rust: let (item, count) = stack.map_or(("minecraft:air", 0), |s| (&*s.item, s.count as i32));
    // rust: let mut cancel = false;
    // rust: let mut hook = |game: &mut Self| {
    // rust: game.native_creative_slot(uuid, &name, slot, item, count, &mut cancel)
}
        // The guest whose turn it is is in place already.
    // rust: if self.lan_acting == Some(conn) {
    // rust: hook(self);
    // rust: } else {
    // rust: self.as_guest(host, conn, hook);
}
    // rust: !cancel
}

    // What ServerboundSetCreativeModeSlotPacket asks of a stack. Its codec
    // (`ItemStack.validatedStreamCodec`) encodes the stack with `ItemStack.CODEC`, whose count is
    // 1 to 99: more fails the packet and disconnects the player, as vanilla's decoder error does.
    // A native mod can raise an item's stack size past 99 (`item_defaults::MAX_STACK_SIZE`), so
    // the count is held to what the wire carries instead. handleSetCreativeModeSlot's `validData`
    // then ignores a stack beyond its own stack size.
creative_stack_valid :: proc(self: ^Self, host: ^LanHost, gi: uint, s: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let max = horizon_world::item_defaults::MAX_STACK_SIZE as u32;
    // rust: if s.count > max {
    // rust: let g = &host.hub.guests[gi];
    // rust: let conn = g.conn;
    // rust: let reason = format!("Invalid packet: count {} is not in 1..={max}", s.count);
    // rust: eprintln!("{} sent an invalid creative stack: {reason}", g.name);
    // rust: host.hub
    // rust: .kick(conn, horizon_protocol::text::literal(&reason));
    // rust: return false;
}
    // rust: s.count <= self.stack_max_size(s)
}

    // rust: fn item_from_network(
    // rust: &self,
    // rust: host: &LanHost,
    // rust: stack: &Option<horizon_protocol::item::Stack>,
    // rust: ) -> Option<ItemStack> {
    // rust: let s = stack.as_ref()?;
    // rust: let mut out = host.hub.stack_from_network(s);
    // rust: out.count = out.count.max(1);
    // rust: Some(out)
}

    // `LivingEntity.tickDeath`: 20 ticks after dying the player is removed,
    // and `Player.remove`'s `inventoryMenu.removed` drops what the cursor
    // held (`dropOrPlaceInInventory` for a removed player). Respawning
    // sooner removes it too.
    // `ServerGamePacketListenerImpl.handleTeleportToEntityPacket` for a
    // player: the host's own, or a guest in the world.
guest_spectate_teleport :: proc(self: ^Self, host: ^LanHost, gi: uint, uuid: u128) {
}
    // rust: let own = host.hub.guests[gi].conn;
    // rust: let target = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.placed && g.conn != own && g.uuid == uuid)
    // rust: .map(|g| (g.position, g.yaw, g.pitch, Dim::from_id(&g.dimension)));
    // rust: let Some((at, yaw, pitch, dim)) = target else {
    // rust: return;
}
    // rust: if Dim::from_id(&host.hub.guests[gi].dimension) != dim {
    // rust: self.level_teleports
    // rust: .push(super::server_travel::LevelTeleport {
    // rust: conn: own,
    // rust: dim,
    // rust: at,
    // rust: rotation: Some([yaw, pitch]),
    // rust: vehicle: None,
    // rust: });
    // rust: return;
}
    // rust: let g = &mut host.hub.guests[gi];
    // rust: (g.yaw, g.pitch) = (yaw, pitch);
        // A new body there: no fall distance or motion carried over, but the
        // player's attributes (ServerPlayer.teleport keeps the entity).
    // rust: g.new_body(true);
    // rust: host.hub.teleport(gi, Some(at));
}
guest_tick_death :: proc(self: ^Self, host: ^LanHost, gi: uint) {
}
    // rust: if host.hub.guests[gi].tick_death() {
    // rust: self.guest_drop_carried(host, gi);
}
}

guest_drop_carried :: proc(self: ^Self, host: ^LanHost, gi: uint) {
}
    // rust: if let Some(c) = host.hub.guests[gi].carried.take() {
    // rust: self.drop_guest_items(host, gi, vec![c]);
}
}

    // `AbstractContainerMenu.removed`: what a closing player held on the
    // cursor goes back into their inventory (`placeItemBackInInventory`,
    // dropped only if it doesn't fit), and their client's cursor empties
    // with the inventory it is sent.
    // rust: pub(super) fn guest_carried_back(&mut self, host: &mut LanHost, gi: usize) {
    // rust: if let Some(c) = host.hub.guests[gi].carried.take() {
    // rust: self.lan_place_back(host, gi, vec![c]);
    // rust: host.hub.send_inventory(gi);
}
}

    // rust: pub(super) fn drop_guest_items(&mut self, host: &LanHost, gi: usize, stacks: Vec<ItemStack>) {
    // rust: let g = &host.hub.guests[gi];
    // rust: let eye = [
    // rust: g.position[0],
    // rust: g.position[1] + g.eye_height() - f64::from(0.3f32),
    // rust: g.position[2],
    // rust: ];
    // rust: for stack in stacks {
    // rust: let r = &mut self.world.random;
    // rust: let v = horizon_client::entities::drop_motion(r, g.yaw, g.pitch, false);
    // rust: self.spawn_item(stack, eye, v, 40);
}
}

    // Whether a block outline occludes the straight line from `eye` to `point`.
block_between :: proc(self: ^Self, eye: [f64; 3], point: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let d = [point[0] - eye[0], point[1] - eye[1], point[2] - eye[2]];
    // rust: let dist = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    // rust: if dist < 1e-9 {
    // rust: return false;
}
    // rust: let dir = [d[0] / dist, d[1] / dist, d[2] / dist];
    // rust: self.clip_ray(eye, dir, dist).is_some_and(|h| {
    // rust: let hd = [
    // rust: h.point[0] - eye[0],
    // rust: h.point[1] - eye[1],
    // rust: h.point[2] - eye[2],
    // rust: ];
    // rust: let hit_dist = (hd[0] * hd[0] + hd[1] * hd[1] + hd[2] * hd[2]).sqrt();
    // rust: hit_dist < dist - 1e-6
    // rust: })
}

    // Aim the swapped-in player at an entity; returns where it aims and the
    // eye. A boat, minecart, armor stand, item frame or painting is aimed at
    // the point the client hit (the interact packet's location) when that
    // is on it, else at its centre.
    // rust: fn look_at_entity(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: gi: usize,
    // rust: id: i32,
    // rust: location: Option<[f64; 3]>,
    // rust: ) -> Option<([f64; 3], [f64; 3])> {
    // rust: let eye = {
    // rust: let g = &host.hub.guests[gi];
    // rust: [g.position[0], g.position[1] + g.eye_height(), g.position[2]]
}
    // rust: let object = || {
    // rust: let (lo, hi, origin) = self.object_target(id)?;
    // rust: let middle = [0, 1, 2].map(|k| (lo[k] + hi[k]) / 2.0);
    // rust: let Some(l) = location else {
                // A boat's mobs sit over its middle: aim low at its near
                // side, so the ray meets the boat before them (the server
                // attacks the entity it is sent).
    // rust: let carries = u32::try_from(id).is_ok_and(|v| {
    // rust: self.boats.iter().any(|b| b.id == v) && !self.boat_mobs(v).is_empty()
    // rust: });
    // rust: if carries {
    // rust: let near = |k: usize| eye[k].clamp(lo[k] + 0.01, hi[k] - 0.01);
    // rust: return Some([near(0), lo[1] + 0.05, near(2)]);
}
    // rust: return Some(middle);
}
    // rust: let point = [0, 1, 2].map(|k| origin[k] + l[k]);
            // A little inside the box, so the ray from the eye meets it.
    // rust: let inside = [0, 1, 2].map(|k| {
    // rust: let margin = ((hi[k] - lo[k]) / 2.0).min(0.01);
    // rust: point[k].clamp(lo[k] + margin, hi[k] - margin)
    // rust: });
    // rust: let on = (0..3).all(|k| (point[k] - inside[k]).abs() < 0.1);
    // rust: Some(if on { inside } else { middle })
}
    // rust: let mob_box = self.mobs.iter().find(|m| m.id as i32 == id).map(|m| {
    // rust: let b = m.bounds();
    // rust: let (mn, mx) = (b.min_position(), b.max_position());
    // rust: ([mn.x, mn.y, mn.z], [mx.x, mx.y, mx.z])
    // rust: });
    // rust: let centre = match mob_box {
    // rust: Some((lo, hi)) => visible_aim_point(eye, lo, hi, |p| self.block_between(eye, p)),
    // rust: None if self.object_target(id).is_some() => object()?,
            // A dragon part or an end crystal (game/dragon.rs).
    // rust: None => {
    // rust: let b = self.tracked_special_box(id)?;
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: [
    // rust: (lo.x + hi.x) / 2.0,
    // rust: (lo.y + hi.y) / 2.0,
    // rust: (lo.z + hi.z) / 2.0,
    // rust: ]
}
}
    // rust: let g = &mut host.hub.guests[gi];
    // rust: let d = [centre[0] - eye[0], centre[1] - eye[1], centre[2] - eye[2]];
    // rust: let horizontal = (d[0] * d[0] + d[2] * d[2]).sqrt();
    // rust: g.yaw = (-d[0].atan2(d[2])).to_degrees() as f32;
    // rust: g.pitch = (-d[1].atan2(horizontal)).to_degrees() as f32;
    // rust: Some((centre, eye))
}

    // `ServerGamePacketListenerImpl.handlePlayerAction` for STAB: the spear in
    // the guest's main hand jabs once its charge allows it (with five ticks
    // of tolerance). The guest's client is sent the dash Lunge gave them.
guest_jab :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let at = g.position;
    // rust: let sound = self
    // rust: .guest_hit_by(host, conn, |g| {
    // rust: if g.cannot_attack_with_item(g.attack_ticks as i32, 5) {
    // rust: None
    // rust: } else {
    // rust: g.jab()
}
    // rust: })
    // rust: .flatten();
        // PiercingWeapon.makeSound: `playSound(causer, ...)`, so the guest's
        // own client plays it.
    // rust: if let Some(name) = sound {
    // rust: let source = horizon_client::settings::sound_source(name) as i32;
    // rust: host.hub.sound(name, at, 1.0, 1.0, source, Some(conn));
}
}

    // `Level.getEntityOrPart(id).getBoundingBox()` for a guest's attack or
    // interaction: the host, another player, a mob, a vehicle or object, a
    // dragon part or crystal, a projectile. None for an id the level doesn't
    // have (the handlers then find nothing either).
    // `WorldBorder.isWithinBounds(target.blockPosition())` for an entity of this box:
    // the block its feet are in (the box's bottom centre).
inside_border :: proc(self: ^Self, target: ^Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let feet = target.bottom_center();
    // rust: self.border.contains(feet.x.floor(), feet.z.floor())
}

    // rust: pub(super) fn guest_target_box(&self, host: &LanHost, gi: usize, id: i32) -> Option<Aabb> {
    // rust: let conn = host.hub.guests[gi].conn;
    // rust: if let Some(g) = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id == id && g.conn != conn && host.hub.here(g))
    // rust: {
    // rust: return Some(g.bounds());
}
    // rust: if let Some(m) = self.mobs.iter().find(|m| m.id as i32 == id) {
    // rust: return Some(m.bounds());
}
    // rust: if let Some((lo, hi, _)) = self.object_target(id) {
    // rust: return Some(Aabb::new(
    // rust: Vec3::new(lo[0], lo[1], lo[2]),
    // rust: Vec3::new(hi[0], hi[1], hi[2]),
    // rust: ));
}
    // rust: if let Some(b) = self.tracked_special_box(id) {
    // rust: return Some(b);
}
    // rust: if let Some(knot) = self.knot_at_id(id) {
    // rust: let knot = horizon_client::mobs::leash::knot_state(knot);
    // rust: let p = knot.position;
    // rust: let half = knot.width / 2.0;
    // rust: return Some(Aabb::new(
    // rust: Vec3::new(p.x - half, p.y, p.z - half),
    // rust: Vec3::new(p.x + half, p.y + knot.height, p.z + half),
    // rust: ));
}
    // rust: self.creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .find(|p| p.id != 0 && p.id as i32 == id)
    // rust: .map(|p| p.bounds())
}

    // The fence of the knot whose entity id is `id` (`lan_assign_ids`).
knot_at_id :: proc(self: ^Self, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.knot_ids
    // rust: .iter()
    // rust: .find(|&(_, &knot)| knot as i32 == id)
    // rust: .map(|(&fence, _)| fence)
}

guest_attack :: proc(self: ^Self, host: ^LanHost, conn: u32, id: i32) {
}
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: if host.hub.guests[gi].spectator() {
    // rust: return;
}
        // handleAttack: a target inside the world border, then
        // `isWithinAttackRange(mainHandItem, box, 3.0)` before anything else, players,
        // mobs, objects and fireballs alike.
    // rust: if let Some(target) = self.guest_target_box(host, gi, id)
    // rust: && (!self.inside_border(&target)
    // rust: || self.as_guest(host, conn, |g| g.within_attack_range(&target)) != Some(true))
    // rust: {
    // rust: return;
}
        // Native mods, where Player.attack starts: a canceled blow does
        // nothing (game/native_hooks.rs).
    // rust: let aimed = if let Some(g) = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id == id && g.conn != conn && host.hub.here(g))
    // rust: {
    // rust: Some(("minecraft:player".to_owned(), g.position))
    // rust: } else {
    // rust: self.level_entity(id).map(|t| {
    // rust: (
    // rust: self.target_type(t),
    // rust: self.target_position(t).unwrap_or_default(),
    // rust: )
    // rust: })
}
    // rust: if let Some((kind, at)) = aimed
    // rust: && self.as_guest(host, conn, |g| {
    // rust: let mut canceled = false;
    // rust: g.native_attack_entity(id, &kind, at, &mut canceled);
    // rust: canceled
    // rust: }) == Some(true)
    // rust: {
    // rust: return;
}
    // rust: if let Some(victim) = Self::pvp_victim(host, conn, id) {
    // rust: if let Some(Some(strike)) = self.as_guest(host, conn, |g| g.pvp_strike())
    // rust: && self.pvp_land(host, victim, &strike)
    // rust: {
    // rust: let on_ground = Self::pvp_victim_on_ground(host, victim);
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.weapon_hit_player(on_ground);
    // rust: g.pvp_exhaustion();
    // rust: if strike.stops_sprint() {
    // rust: g.stop_sprint_after_extra_knockback();
}
    // rust: });
}
    // rust: return;
}
        // A ghast's fireball or a wind charge: turned along the guest's own
        // view (ServerGamePacketListenerImpl.handleInteract, then
        // Player.attack's AIM_DEFLECT).
    // rust: if let Some(i) = self
    // rust: .creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .position(|p| p.id != 0 && p.id as i32 == id && super::deflect::attackable(p))
    // rust: {
    // rust: self.as_guest_with_host(host, conn, |g, host| {
    // rust: if g.within_interaction_range(i) {
    // rust: if matches!(
    // rust: g.creatures.projectiles[i].kind,
    // rust: horizon_client::projectiles::ProjectileKind::ShulkerBullet { .. }
    // rust: ) {
    // rust: g.hit_shulker_bullet(Some(host), i);
    // rust: } else {
    // rust: g.deflect(i);
}
}
    // rust: });
    // rust: return;
}
    // rust: if let Some(index) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .position(|m| m.id as i32 == id && m.alive())
    // rust: .filter(|_| self.dragon.as_ref().is_none_or(|d| d.id as i32 != id))
    // rust: {
    // rust: if host.hub.guests[gi].vehicle == Some(self.mobs[index].id) {
    // rust: return;
}
            // A mace's smash sets the attacker's velocity and sends it at once, before the
            // Wind Burst's push (MaceItem.hurtEnemy, then the post-attack effects).
    // rust: let sent = self
    // rust: .as_guest(host, conn, |g| {
    // rust: let marked = g
    // rust: .player
    // rust: .as_mut()
    // rust: .is_some_and(|p| std::mem::take(&mut p.health.sync_velocity));
    // rust: g.attack_mob(index);
    // rust: g.swing_arm();
    // rust: let p = g.player.as_mut()?;
    // rust: let sent = std::mem::replace(&mut p.health.sync_velocity, marked);
    // rust: sent.then_some(p.velocity)
    // rust: })
    // rust: .flatten();
    // rust: self.send_guest_motion(host, conn, sent);
            // The mob now answers to this guest (game/lan_mobs.rs).
    // rust: if let Ok(id) = u32::try_from(id) {
    // rust: host.mob_players.insert(id, conn);
}
    // rust: return;
}
    // rust: let (old_yaw, old_pitch) = (host.hub.guests[gi].yaw, host.hub.guests[gi].pitch);
    // rust: let boat = self.boats.iter().position(|boat| boat.id as i32 == id);
        // A packet names its target already. Keep the attacker's actual yaw
        // for the boat's knockback instead of aiming a ray at its center.
    // rust: if boat.is_none() && self.look_at_entity(host, gi, id, None).is_none() {
    // rust: return;
}
        // A mace's smash sets the attacker's velocity and sends it at once, before the
        // Wind Burst's push (MaceItem.hurtEnemy, then the post-attack effects).
    // rust: let sent = self
    // rust: .as_guest(host, conn, |g| {
    // rust: let marked = g
    // rust: .player
    // rust: .as_mut()
    // rust: .is_some_and(|p| std::mem::take(&mut p.health.sync_velocity));
    // rust: if let Some(index) = boat {
    // rust: g.strike_boat(index);
    // rust: g.swing_arm();
    // rust: } else {
    // rust: g.attack();
}
    // rust: let p = g.player.as_mut()?;
    // rust: let sent = std::mem::replace(&mut p.health.sync_velocity, marked);
    // rust: sent.then_some(p.velocity)
    // rust: })
    // rust: .flatten();
    // rust: self.send_guest_motion(host, conn, sent);
        // The mob now answers to this guest (game/lan_mobs.rs).
    // rust: if let Ok(id) = u32::try_from(id) {
    // rust: host.mob_players.insert(id, conn);
}
    // rust: host.hub.guests[gi].yaw = old_yaw;
    // rust: host.hub.guests[gi].pitch = old_pitch;
}

    // Commands.performCommand for a guest with command access.
    // Commands.performCommand for a guest, with the message arguments it
    // signed (none after an unsigned command packet).
    // rust: pub(super) fn guest_command(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: command: &str,
    // rust: signed: Option<Vec<(String, horizon_client::lan::hub::chat::ChatMessage)>>,
    // rust: ) {
        // The mods hear every command first, and may stop it.
    // rust: let mut canceled = false;
    // rust: let mut replies = Vec::new();
    // rust: if let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone())) {
    // rust: self.native_player_command(
    // rust: uuid,
    // rust: &name,
    // rust: command.trim_start_matches('/'),
    // rust: &mut canceled,
    // rust: &mut replies,
    // rust: );
}
    // rust: for line in replies {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content: horizon_client::lan::data::component_nbt(&line.component()),
    // rust: overlay: false,
    // rust: }),
    // rust: );
}
    // rust: if canceled {
    // rust: return;
}
    // rust: if self.guest_message_command(host, conn, command, signed.as_ref()) {
    // rust: return;
}
        // ListPlayersCommand needs no permission and lists every player.
    // rust: let words: Vec<&str> = command.trim_start_matches('/').split(' ').collect();
    // rust: if words[0] == "list" && (words.len() == 1 || words[1..] == ["uuids"]) {
    // rust: let content = host.hub.list_reply(words.len() == 2);
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content,
    // rust: overlay: false,
    // rust: }),
    // rust: );
    // rust: return;
}
        // The chat filter's mute commands (game/chat_filter.rs), on servers that filter.
    // rust: if super::chat_filter::MUTE_COMMANDS.contains(&words[0]) && host.hub.chat_filter_on() {
    // rust: self.guest_mute_command(host, conn, &words);
    // rust: return;
}
        // Horizon's `/tempban` (game/tempban.rs), on dedicated servers.
    // rust: if super::tempban::TEMPBAN_COMMANDS.contains(&words[0]) && self.server_lists.is_some() {
    // rust: self.guest_tempban_command(host, conn, &words);
    // rust: return;
}
        // A native mod's command, for every player its level allows,
        // whether the world allows commands or not (game/native_server.rs).
    // rust: let integrated = host.hub.config.integrated;
    // rust: if let Some(level) = Self::native_command_level(host, command.trim_start_matches('/'))
    // rust: && let Some(permission) = host.hub.guest(conn).map(|g| g.permission)
    // rust: && permission >= level
    // rust: {
    // rust: host.commands.push(GuestCommand {
    // rust: conn,
    // rust: command: command.trim_start_matches('/').to_owned(),
    // rust: permission,
    // rust: integrated,
    // rust: quiet: false,
    // rust: });
    // rust: return;
}
        // An integrated server runs every player's commands at their own
        // permission level (`CommandSourceStack.permissions`); a LAN world
        // follows its Allow Commands, and a dedicated server leaves it to
        // the ops list (the guest's permission level).
    // rust: let allowed = self.options.dedicated.is_some() || self.allow_commands();
    // rust: if !integrated && (!host.settings.guest_commands || !allowed) {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content: horizon_protocol::text::translatable("command.unknown.command", &[]),
    // rust: overlay: false,
    // rust: }),
    // rust: );
    // rust: return;
}
        // The guest's own level (Commands.performCommand with the player's
        // source): an operator's on a dedicated server, never the host's.
    // rust: let Some(permission) = host.hub.guest(conn).map(|g| g.permission) else {
    // rust: return;
}
    // rust: host.commands.push(GuestCommand {
    // rust: conn,
    // rust: command: command.trim_start_matches('/').to_owned(),
    // rust: permission,
    // rust: integrated,
    // rust: quiet: false,
    // rust: });
}

    // The guests' queued commands, run with the hub in `self.lan` so that
    // they reach the other players too (`/give Bob`, `/tp Bob`, `/kick`).
    // rust: pub(super) fn run_guest_commands(&mut self) {
    // rust: loop {
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return;
}
    // rust: if host.commands.is_empty() {
    // rust: return;
}
    // rust: let c = host.commands.remove(0);
    // rust: self.run_guest_command(c);
}
}

    // One guest's command as that guest, its feedback sent to them; false
    // when it failed (or the guest is gone).
    // rust: pub(super) fn run_guest_command(&mut self, c: GuestCommand) -> bool {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return false;
}
    // rust: let Some(swap) = self.enter_guest(&mut host, c.conn, self.dim) else {
    // rust: self.lan = Some(host);
    // rust: return false;
}
    // rust: self.lan = Some(host);
    // rust: self.chat_capture = Some(Vec::new());
    // rust: let level = std::mem::replace(&mut self.ui.registries.permission, c.permission);
    // rust: let ok = if self.perform_native_command(c.conn, c.permission, &c.command) {
    // rust: true
    // rust: } else if c.quiet {
    // rust: self.run_command_quietly(&c.command)
    // rust: } else {
    // rust: self.run_command(&c.command)
}
    // rust: self.ui.registries.permission = level;
    // rust: let mut lines = self.chat_capture.take().unwrap_or_default();
    // rust: let mut host = self.lan.take().expect("a command puts the hub back");
    // rust: self.leave_guest(&mut host, swap);
    // rust: if std::mem::take(&mut self.save_after_guest_turn) {
    // rust: self.lan = Some(host);
    // rust: lines.push(self.save_all_reply());
    // rust: host = self.lan.take().expect("saving puts the hub back");
}
    // rust: host.hub.sync_all_effects();
    // rust: if !c.integrated {
            // A teleport into another level happens before its feedback is sent.
    // rust: self.run_level_teleports(&mut host);
}
        // What the command earned is announced before its feedback.
    // rust: self.announce_guest_advancements(&mut host);
    // rust: for line in lines {
    // rust: host.hub.send_to(
    // rust: c.conn,
    // rust: &C::SystemChat(play::SystemChat {
    // rust: content: horizon_client::lan::data::component_nbt(&line.component()),
    // rust: overlay: false,
    // rust: }),
    // rust: );
}
        // The other operators hear of it; never the player whose command it was.
    // rust: self.send_admin_feedback(&mut host, Some(c.conn));
    // rust: self.lan = Some(host);
    // rust: ok
}

    // The `broadcastToAdmins` lines a command queued (`source`: the guest
    // whose it was; none for the host's or the console's): every other
    // operator gets them, and the console logs them as the server's own
    // system messages (MinecraftServer.sendSystemMessage).
    // rust: pub(super) fn send_admin_feedback(&mut self, host: &mut LanHost, source: Option<u32>) {
        // server.toml's `admin_feedback_to_ops` off: the console's log only.
    // rust: let to_ops = host.hub.admin_feedback_to_ops;
    // rust: for (line, ops, console) in std::mem::take(&mut self.admin_feedback) {
    // rust: if ops && to_ops {
    // rust: let content = horizon_client::lan::data::component_nbt(&line.component());
    // rust: for g in host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| Some(g.conn) != source && g.permission > 0)
    // rust: {
    // rust: g.send(&C::SystemChat(play::SystemChat {
    // rust: content: content.clone(),
    // rust: overlay: false,
    // rust: }));
}
}
    // rust: if console {
    // rust: super::dedicated::log("INFO", &format!("System chat: {}", line.plain()));
}
}
}

    // ServerGamePacketListenerImpl.handleCustomCommandSuggestions: the
    // completions of the command typed so far (after an optional slash), for
    // the nodes the tree marks `ask_server`.
    // ServerCommandSuggestionsProvider.tryProcessRequest: answer the latest request if this
    // tick's answer is free. One client asking a hundred times a tick costs one parse.
guest_try_suggestions :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: let play = host.play.entry(conn).or_default();
    // rust: if !play.suggestion_budget {
    // rust: return;
}
    // rust: let Some(payload) = play.suggestion.take() else {
    // rust: return;
}
    // rust: play.suggestion_budget = false;
    // rust: self.guest_suggestions(host, conn, &payload);
}

guest_suggestions :: proc(self: ^Self, host: ^LanHost, conn: u32, payload: []u8) {
}
    // rust: let mut r = horizon_protocol::buf::Reader::new(payload);
    // rust: let (Ok(id), Ok(text)) = (r.varint(), r.string(32500)) else {
    // rust: return;
}
    // rust: let Some(permission) = host.hub.guest(conn).map(|g| g.permission) else {
    // rust: return;
}
    // rust: let Some((player_uuid, player_name)) =
    // rust: host.hub.guest(conn).map(|g| (g.uuid, g.name.clone()))
    // rust: else {
    // rust: return;
}
    // rust: let skip = usize::from(text.starts_with('/'));
    // rust: let command = &text[skip..];
    // rust: let d = vanilla::game_dispatcher_with_features(&self.level.enabled_features);
        // The completions come from the server's players and lists, not from the host's own registries: a
        // dedicated server has no local player (they would list "Player"), and a LAN world's guests are not in
        // the host's list.
    // rust: let mut players = if self.options.dedicated.is_some() {
    // rust: Vec::new()
    // rust: } else {
    // rust: self.ui.registries.players.clone()
}
    // rust: players.extend(host.hub.guests.iter().map(|g| g.name.clone()));
    // rust: let (ops, banned_players, banned_ips, whitelisted) = match &self.server_lists {
    // rust: Some(lists) => {
    // rust: let l = lists.lock().unwrap();
    // rust: (
    // rust: l.ops
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| e.user.name.clone())
    // rust: .collect(),
    // rust: l.bans
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| e.user.name.clone())
    // rust: .collect(),
    // rust: l.ip_bans.entries().iter().map(|e| e.user.clone()).collect(),
    // rust: l.white
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| e.user.name.clone())
    // rust: .collect(),
    // rust: )
}
    // rust: None => Default::default(),
}
    // rust: let reg = &mut self.ui.registries;
    // rust: let level = std::mem::replace(&mut reg.permission, permission);
    // rust: let own_players = std::mem::replace(&mut reg.players, players);
    // rust: let own_ops = std::mem::replace(&mut reg.ops, ops);
    // rust: let own_banned = std::mem::replace(&mut reg.banned_players, banned_players);
    // rust: let own_banned_ips = std::mem::replace(&mut reg.banned_ips, banned_ips);
    // rust: let own_whitelisted = std::mem::replace(&mut reg.whitelisted, whitelisted);
    // rust: let parse = d.parse(command, &self.ui.registries);
    // rust: let ((start, end), mut suggestions) =
    // rust: d.suggestions(&parse, command.len(), &self.ui.registries);
    // rust: self.native_tab_complete(
    // rust: player_uuid,
    // rust: &player_name,
    // rust: command,
    // rust: [start, end],
    // rust: &mut suggestions,
    // rust: );
    // rust: let reg = &mut self.ui.registries;
    // rust: reg.permission = level;
    // rust: reg.players = own_players;
    // rust: reg.ops = own_ops;
    // rust: reg.banned_players = own_banned;
    // rust: reg.banned_ips = own_banned_ips;
    // rust: reg.whitelisted = own_whitelisted;
        // ServerCommandSuggestionsProvider.limitSuggestionCount.
    // rust: suggestions.truncate(1000);
    // rust: let utf16 = |byte: usize| command[..byte.min(command.len())].encode_utf16().count() as i32;
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: w.varint(id);
    // rust: w.varint(utf16(start) + skip as i32);
    // rust: w.varint(utf16(end) - utf16(start));
    // rust: w.varint(suggestions.len() as i32);
    // rust: for s in &suggestions {
    // rust: w.string(&s.text);
    // rust: w.bool(s.tooltip.is_some());
    // rust: if let Some(tip) = &s.tooltip {
    // rust: w.nbt(&literal(tip));
}
}
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::Unknown(
    // rust: horizon_protocol::ids::play::clientbound::COMMAND_SUGGESTIONS,
    // rust: w.data,
    // rust: ),
    // rust: );
}

guest_respawn :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: let Some(i) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
        // The guest's own bed, else the world spawn: never the host's bed.
    // rust: let world = self
    // rust: .level
    // rust: .world_spawn
    // rust: .map(|[x, y, z]| [f64::from(x) + 0.5, f64::from(y), f64::from(z) + 0.5]);
    // rust: let spawn = host.hub.guests[i]
    // rust: .spawn
    // rust: .or(world)
    // rust: .or(self.spawn.map(|s| [s.x, s.y, s.z]))
    // rust: .unwrap_or([0.5, 80.0, 0.5]);
    // rust: if !host.hub.guests[i].dead {
    // rust: return;
}
        // PlayerList.respawn replaces the player, retaining only opted-in data.
    // rust: let uuid = host.hub.guests[i].uuid;
    // rust: if let Some(attachments) = self.guest_attachments.get_mut(&uuid)
    // rust: && let Ok(copy) = attachments.copy_on_death()
    // rust: {
    // rust: *attachments = copy;
}
        // PlayerList.respawn removes the dead player (Player.remove).
    // rust: self.guest_drop_carried(host, i);
        // AbstractContainerScreen.tick / ServerPlayer.closeContainer: the dead
        // player's open container goes with it, so a chest's lid (its opener
        // count) falls instead of staying up for a player who is gone.
    // rust: self.guest_container_closed(host, conn);
    // rust: host.hub.close_container(conn);
        // PlayerList.respawn builds a new `ServerPlayer`, whose `lastEquipmentItems` starts
        // empty: the mods hear each worn item again from empty (`native_players_equipment`).
    // rust: if let Some(play) = host.play.get_mut(&conn) {
    // rust: play.equipment_heard = None;
    // rust: play.level_up_sound = Default::default();
}
        // PlayerList.respawn: a server's player comes back in its respawn
        // point's level: the Overworld, where the world spawn and beds are,
        // or another one's anchor or forced point, which its block resolves
        // once the level has loaded around it.
    // rust: let server = self.options.dedicated.is_some();
    // rust: let own = host.hub.guests[i]
    // rust: .respawn_elsewhere
    // rust: .as_ref()
    // rust: .map(RespawnConfig::from_saved);
    // rust: let elsewhere = own.filter(|_| server);
        // In the window's world a guest has no level of its own to wait in:
        // its bed is resolved at once when its chunk is there, else it
        // comes back on the bed.
    // rust: let in_frame_bed = own.filter(|c| !server && c.dim == super::Dim::Overworld);
    // rust: let spawn = in_frame_bed.map_or(spawn, |c| {
    // rust: [
    // rust: f64::from(c.pos[0]) + 0.5,
    // rust: f64::from(c.pos[1]) + 0.6,
    // rust: f64::from(c.pos[2]) + 0.5,
    // rust: ]
    // rust: });
    // rust: let level = elsewhere.map_or(super::Dim::Overworld, |c| c.dim);
    // rust: let spawn = elsewhere.map_or(spawn, |c| {
    // rust: [
    // rust: f64::from(c.pos[0]) + 0.5,
    // rust: f64::from(c.pos[1]),
    // rust: f64::from(c.pos[2]) + 0.5,
    // rust: ]
    // rust: });
    // rust: let back = self.dim;
    // rust: let left = super::Dim::from_id(&host.hub.guests[i].dimension);
    // rust: let away = server && host.hub.guests[i].dimension != level.id();
    // rust: if server {
    // rust: self.server_trips.retain(|t| !t.is(conn));
}
    // rust: if away && let Err(e) = self.enter_level(Some(host), level) {
    // rust: log::error!("could not open {}: {e}", level.id());
    // rust: return;
}
    // rust: let g = &mut host.hub.guests[i];
        // restartClientLoadTimerAfterRespawn.
    // rust: g.dead = false;
    // rust: g.load_timeout = horizon_client::lan::guest::CLIENT_LOADED_TIMEOUT;
    // rust: g.loading = true;
    // rust: g.death_time = 0;
    // rust: g.food = 20;
    // rust: g.saturation = 5.0;
    // rust: g.sent_health = None;
        // ServerPlayer.restoreFrom(old, false): the base values come back,
        // and the new player has the max health they give.
    // rust: if let Some(m) = g.new_body(false) {
    // rust: let m = *m;
    // rust: g.logs_kept = Some((m.hurt_log, m.attack_log));
}
    // rust: g.health = g.respawn_health(self.motion);
    // rust: let mut xp = Experience {
    // rust: level: g.xp_level,
    // rust: progress: g.xp_progress,
    // rust: total: g.xp_total,
}
    // rust: xp.respawn(self.ui.rules.bool("keep_inventory") || g.game_mode == SPECTATOR);
    // rust: (g.xp_level, g.xp_progress, g.xp_total) = (xp.level, xp.progress, xp.total);
        // PlayerEvent.Clone, at the end of `restoreFrom`: the data is copied,
        // the new player not yet placed.
    // rust: let (cloned, name) = (g.uuid, g.name.clone());
    // rust: self.native_player_clone(cloned, &name, true);
    // rust: let clock_rate = self.network_clock_rate();
    // rust: let ctx = TickCtx {
    // rust: world: &mut self.world,
    // rust: entities: &[],
    // rust: next_entity: &mut self.next_entity,
    // rust: spawn,
    // rust: difficulty: i32::from(self.ui.difficulty),
    // rust: difficulty_locked: self.level.difficulty_locked,
    // rust: clock_rate,
    // rust: tick_rate: self.clock.rate(),
    // rust: tick_frozen: self.clock.frozen(),
    // rust: tick_steps: self.clock.step_state(),
    // rust: collision: Some(self.collision),
    // rust: border: &self.border,
    // rust: streaming: Some(&self.streaming),
}
    // rust: host.hub.respawn(i, spawn, &ctx);
        // ServerGamePacketListenerImpl.handleClientCommand: a hardcore world's
        // respawned player only watches.
    // rust: if self.level.hardcore {
    // rust: let (uuid, name, from) = {
    // rust: let g = &host.hub.guests[i];
    // rust: (g.uuid, g.name.clone(), g.game_mode)
}
    // rust: let mut cancel = false;
    // rust: if from != SPECTATOR {
    // rust: self.native_player_game_mode_changed(uuid, &name, from, SPECTATOR, &mut cancel);
}
    // rust: if !cancel {
    // rust: host.hub
    // rust: .set_game_mode(conn, SPECTATOR, &self.world, Some(self.collision));
}
}
    // rust: if let Some(config) = elsewhere {
    // rust: self.respawn_trip(conn, config);
    // rust: } else if in_frame_bed.is_none() && host.hub.guests[i].spawn.is_none() {
            // TeleportTransition.createDefault: no point of its own, so the
            // world spawn's free column once its chunks have loaded.
    // rust: self.world_spawn_trip(conn);
}
    // rust: if let Some(c) = in_frame_bed
    // rust: && self.dim == super::Dim::Overworld
    // rust: && self.world.loaded(c.pos[0], c.pos[2])
    // rust: {
    // rust: let found = self
    // rust: .as_guest(host, conn, |g| g.resolve_server_respawn(c))
    // rust: .flatten();
    // rust: let world = self
    // rust: .level
    // rust: .world_spawn
    // rust: .map_or([0.5, 80.0, 0.5], |[x, y, z]| {
    // rust: [f64::from(x) + 0.5, f64::from(y), f64::from(z) + 0.5]
    // rust: });
    // rust: let at = found.map_or(world, |(at, yaw)| {
    // rust: host.hub.guests[i].yaw = yaw;
    // rust: [at.x, at.y, at.z]
    // rust: });
    // rust: if found.is_none() {
                // TeleportTransition.missingRespawnBlock.
    // rust: host.hub.missing_respawn_block(conn);
    // rust: self.world_spawn_trip(conn);
}
    // rust: host.hub.teleport(i, Some(at));
}
        // PlayerRespawnEvent, at the end of PlayerList.respawn: the player is
        // placed, in their respawn level, with their state swapped in so the
        // helpers reach them (as for native_perform_command).
    // rust: let (respawned, name) = (host.hub.guests[i].uuid, host.hub.guests[i].name.clone());
    // rust: self.as_guest(host, conn, |g| g.native_player_respawned(respawned, &name));
        // The player left another level for the respawn point's: placed for
        // good they tell the mods now, else the trip that is still carrying
        // them (a bed or anchor in another level, the world spawn's free
        // column) does when it arrives (`arrive_server_trips`).
    // rust: if away {
    // rust: if let Some(trip) = self.server_trips.iter_mut().find(|t| t.is(conn)) {
    // rust: trip.left = Some(left);
    // rust: } else {
    // rust: self.tell_mods_changed_dimension(host, conn, Some(left), level);
}
}
    // rust: if away && let Err(e) = self.enter_level(Some(host), back) {
    // rust: log::error!("could not reopen {}: {e}", back.id());
}
}

    // Per tick, for every guest: dig, use items, pick up drops, die.
    // rust: pub(super) fn tick_guests(&mut self, host: &mut LanHost) {
    // rust: self.tick_guest_cameras(host);
    // rust: self.lan_merchant_tick(host);
    // rust: self.lan_stations_tick(host);
    // rust: self.lan_tables_tick(host);
    // rust: self.lan_containers_tick(host);
    // rust: self.tick_lan_mount_menus(host);
    // rust: self.tick_player_menus(host);
    // rust: self.native_players_equipment(host);
    // rust: self.announce_guest_advancements(host);
        // ServerLevel.tickNonPassenger calls Entity.commonTick for each player,
        // including spectators and players whose client has not loaded yet.
    // rust: for g in &host.hub.guests {
    // rust: if host.hub.here(g) && !self.on_server_trip(g.conn) {
    // rust: host.play.entry(g.conn).or_default().level_up_sound.tick();
}
}
    // rust: let conns: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g) && g.loaded)
    // rust: .map(|g| g.conn)
    // rust: .collect();
        // The players the guests' hooks can catch.
    // rust: if host.play.values().any(|p| p.hook.is_some()) {
    // rust: self.refresh_hook_targets(host);
}
    // rust: for conn in conns {
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: continue;
}
            // ServerGamePacketListenerImpl.tick: the chat and command throttlers
            // decay one a tick, dead or alive.
    // rust: let play = host.play.entry(conn).or_default();
    // rust: play.chat_spam = play.chat_spam.saturating_sub(1);
    // rust: play.command_spam = play.command_spam.saturating_sub(1);
            // commandSuggestionsProvider.tick: one answer a tick, to the latest request.
    // rust: play.suggestion_budget = true;
    // rust: self.guest_try_suggestions(host, conn);
    // rust: self.guest_sleep_tick(host, gi);
    // rust: if host.hub.guests[gi].dead {
    // rust: self.guest_tick_death(host, gi);
    // rust: continue;
}
    // rust: if self.on_server_trip(conn) {
                // LivingEntity.hurt kills at once (die), whether the level
                // has loaded around the player or not: its respawn request
                // is taken as soon as it comes.
    // rust: self.guest_die(host, gi, conn);
    // rust: continue;
}
    // rust: let play = host.play.entry(conn).or_default();
            // ServerGamePacketListenerImpl.tick's dropSpamThrottler.
    // rust: play.creative_drops = play.creative_drops.saturating_sub(1);
    // rust: let digging = play.digging;
    // rust: let using = play.using.is_some();
    // rust: let delayed = play.destroy_delay > 0 || play.use_delay > 0 || play.attack_ticks < 100;
    // rust: if digging.is_some() || using || delayed {
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.attack_ticks = g.attack_ticks.saturating_add(1);
    // rust: if let Some((pos, face)) = digging {
    // rust: g.forced_hit = Some(Hit {
    // rust: pos,
    // rust: face,
    // rust: point: [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ],
    // rust: });
}
    // rust: let _ = g.tick_mining();
    // rust: g.forced_hit = None;
    // rust: g.right = g.using.is_some();
    // rust: g.tick_using();
    // rust: if g.use_delay > 0 {
    // rust: g.use_delay -= 1;
}
    // rust: });
                // ServerPlayerGameMode.handleBlockBreakAction: creative and
                // instant survival STARTs finish without a STOP from the client.
                // tick_mining clears mining on completion; forget the START too,
                // so a flower or crop planted here later is not broken again.
    // rust: if digging.is_some()
    // rust: && let Some(play) = host.play.get_mut(&conn)
    // rust: && (host.hub.guests[gi].creative() || play.mining.is_none())
    // rust: {
    // rust: play.digging = None;
}
}
            // Player.tick's ItemCooldowns.tick, once a tick for each player
            // (the shield an axe disabled, a thrown pearl), after
            // LivingEntity.tick's use: an entry a finished use starts has 20
            // ticks left when the next tick's packets are handled, as the
            // guest's own client counts.
    // rust: let play = host.play.entry(conn).or_default();
    // rust: play.shield_cooldown = play.shield_cooldown.saturating_sub(1);
            // ServerItemCooldowns.onCooldownEnded: a finished entry is told to
            // the guest (a duration of 0 removes it).
    // rust: for group in play.cooldowns.tick() {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::Cooldown(play::Cooldown {
    // rust: group: group.to_string(),
    // rust: duration: 0,
    // rust: }),
    // rust: );
}
            // Player.tick: a different main-hand item resets the attack
            // strength, and detectEquipmentUpdates gives the guest its modifiers.
    // rust: let g = &host.hub.guests[gi];
    // rust: let held = g
    // rust: .inventory
    // rust: .get(g.selected)
    // rust: .cloned()
    // rust: .flatten()
    // rust: .map(|s| s.item);
    // rust: let play = host.play.entry(conn).or_default();
    // rust: if play.attack_item != held {
    // rust: play.attack_ticks = 0;
    // rust: play.attack_item = held;
}
    // rust: self.guest_delayed_destroy(host, conn);
    // rust: self.guest_server_tick(host, conn);
            // Player.tick's statistics and ServerPlayer.tick's triggers, then
            // PlayerAdvancements.flushDirty.
    // rust: let sleeping = host.hub.guests[gi].sleeping;
            // ServerPlayer.doTick's updateScoreForCriteria: the health, food,
            // armor, experience and level objectives follow the guest.
    // rust: let mut recorded =
    // rust: std::mem::take(&mut host.play.entry(conn).or_default().score_recorded);
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.tick_fishing();
    // rust: g.tick_maps();
    // rust: g.tick_lodestone_compasses();
    // rust: g.native_inventory_ticks();
    // rust: g.count_tick_stats(sleeping);
    // rust: g.tick_advancements();
    // rust: g.update_player_attributes();
    // rust: g.record_player_scores(&mut recorded);
                // Native mods, at the end of ServerPlayer.tick.
    // rust: g.native_player_tick();
    // rust: });
    // rust: host.play.entry(conn).or_default().score_recorded = recorded;
    // rust: self.lan_map_updates(host, conn);
    // rust: host.hub.flush_progress(conn);
    // rust: self.guest_dig_feedback(host, conn);
            // A player frozen for a hand-over picks nothing up: what it took would be
            // missing from its record, and lost when the release saves nothing.
    // rust: if host.hub.guests[gi].handover.is_none() {
    // rust: self.guest_pickups(host, gi);
    // rust: self.guest_arrows(host, gi);
    // rust: self.guest_orbs(host, gi);
}
    // rust: self.guest_die(host, gi, conn);
}
}

    // `ServerPlayer.die` for a guest whose health has run out: the death
    // message, the loot and experience, the death screen.
guest_die :: proc(self: ^Self, host: ^LanHost, gi: uint, conn: u32) {
}
    // rust: if host.hub.guests[gi].health <= 0.0
    // rust: && !host.hub.guests[gi].dead
    // rust: && !horizon_client::mod_api::mods().is_empty()
    // rust: {
            // LivingDeathEvent: a canceled death keeps the player at 1 health.
    // rust: let (damage_type, attacker) =
    // rust: match host.play.get(&conn).and_then(|p| p.death_cause.as_deref()) {
    // rust: Some("death.attack.genericKill") => ("minecraft:generic_kill", 0),
    // rust: _ => self
    // rust: .guest_combat
    // rust: .get(&conn)
    // rust: .and_then(|tracker| tracker.last_blow())
    // rust: .unwrap_or(("minecraft:generic", 0)),
}
    // rust: let (damage_type, entity) = (damage_type.to_owned(), host.hub.guests[gi].entity_id);
    // rust: let mut cancel = false;
    // rust: self.native_living_death(
    // rust: entity as u32,
    // rust: "minecraft:player",
    // rust: &damage_type,
    // rust: attacker,
    // rust: &mut cancel,
    // rust: );
    // rust: if cancel {
    // rust: host.hub.guests[gi].health = 1.0;
    // rust: return;
}
}
    // rust: if host.hub.guests[gi].health <= 0.0 && !host.hub.guests[gi].dead {
    // rust: self.guest_forget_digging(host, conn);
            // FishingHook.shouldStopFishing: its owner is dead.
    // rust: if let Some(play) = host.play.get_mut(&conn) {
    // rust: play.hook = None;
}
}
    // rust: let here = host.hub.here(&host.hub.guests[gi]);
    // rust: let g = &mut host.hub.guests[gi];
    // rust: if g.health <= 0.0 && !g.dead {
    // rust: g.dead = true;
    // rust: g.last_death = Some((g.dimension.clone(), g.position.map(|v| v.floor() as i32)));
    // rust: let (id, at) = (g.entity_id, g.position);
    // rust: let reward = Experience {
    // rust: level: g.xp_level,
    // rust: progress: g.xp_progress,
    // rust: total: g.xp_total,
}
    // rust: .death_reward(self.ui.rules.bool("keep_inventory") || g.game_mode == SPECTATOR);
    // rust: let (name, uuid) = (g.name.clone(), g.uuid);
            // ServerPlayer.die: dropAllDeathLoot unless a spectator, from the eyes less 0.3.
    // rust: let drops = (g.game_mode != SPECTATOR)
    // rust: .then(|| [at[0], at[1] + g.eye_height() - f64::from(0.3f32), at[2]]);
    // rust: let cause = host.play.get_mut(&conn).and_then(|p| p.death_cause.take());
    // rust: self.native_player_died(uuid, cause.as_deref());
            // ServerPlayer.die: the neutral mobs near a guest in this level
            // forget their anger at them.
    // rust: if here {
    // rust: self.tell_neutral_mobs_player_died(at, Some(conn), &host.mob_players);
}
            // The death's last blow, read before the death message empties the
            // combat record: ServerPlayer.die's triggers read it from a record
            // that CombatTracker.recheckStatus clears only at the end of die.
    // rust: let blow = self.guest_combat.get(&conn).and_then(|c| c.killing_blow());
            // ServerPlayer.die: with showDeathMessages, the message goes to
            // the dying player's death screen and to everyone the team lets
            // see it; without it, the death screen gets an empty one.
    // rust: let message = if self.ui.rules.bool("show_death_messages") {
    // rust: let me = self.player_text(&name, uuid);
    // rust: let text = match cause {
    // rust: Some(key) => horizon_client::text::Text::translate(&key, &[me]),
    // rust: None if at[1] < f64::from(self.world.bottom_y() - 64) => {
    // rust: horizon_client::text::Text::translate("death.attack.outOfWorld", &[me])
}
    // rust: None => self.guest_death_message(conn, me),
}
    // rust: let message = horizon_client::lan::data::component_nbt(&text.component());
    // rust: let board = &self.score.board;
    // rust: host.hub.system_message_to(message.clone(), |other| {
    // rust: horizon_client::scoreboard::death_message_reaches(board, &name, other)
    // rust: });
    // rust: if self.options.dedicated.is_some() {
    // rust: super::dedicated::events::record(
    // rust: "death",
    // rust: &name,
    // rust: uuid,
    // rust: serde_json::json!({ "message": text.plain() }),
    // rust: );
                    // Only a message for everyone is logged (`broadcastSystemMessage`).
    // rust: if board.players_team(&name).is_none_or(|t| {
    // rust: t.death_message_visibility == horizon_client::scoreboard::Visibility::Always
    // rust: }) {
    // rust: super::dedicated::log("INFO", &format!("System chat: {}", text.plain()));
}
    // rust: } else if self.player.is_some()
    // rust: && horizon_client::scoreboard::death_message_reaches(
    // rust: board,
    // rust: &name,
    // rust: super::chat::PLAYER_NAME,
    // rust: )
    // rust: {
    // rust: self.system_message(text);
}
    // rust: message
    // rust: } else {
    // rust: literal("")
}
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::PlayerCombatKill(play::PlayerCombatKill { id, message }),
    // rust: );
            // LivingEntity.die: the death animation, the dying player included.
    // rust: host.hub.entity_event(id, 3, at);
            // LivingEntity.die: the death is heard, and a sculk catalyst
            // nearby takes the experience (before the loot is dropped), as it
            // does for a mob.
    // rust: let mut catalyst_xp = 0;
    // rust: let consumed = self.catalyst_takes_experience(at, |_| {
    // rust: catalyst_xp = reward;
    // rust: catalyst_xp
    // rust: });
            // CatalystListener: with experience to take, the player who last
            // hurt them gets KILL_MOB_NEAR_SCULK_CATALYST.
    // rust: if consumed && catalyst_xp > 0 {
    // rust: self.guest_catalyst_trigger(host, gi, conn, at, blow.clone());
}
            // ServerPlayer.die: the drops, then the deathCount objectives, then
            // the killer's awardKillScore, then the `deaths` statistic and the
            // two timers it resets.
    // rust: self.as_guest(host, conn, |game| {
    // rust: if let Some(eyes) = drops {
    // rust: game.drop_inventory(eyes, (uuid, id));
}
    // rust: game.score_player_died();
    // rust: });
    // rust: self.guest_killed_player_trigger(host, conn, at, blow);
    // rust: self.as_guest(host, conn, |game| {
    // rust: game.award_custom_stat("deaths", 1);
    // rust: game.stats.reset_death_timers();
    // rust: });
            // The experience the catalyst took does not drop (`Player.
            // skipDropExperience`).
    // rust: if !consumed {
    // rust: self.spawn_orbs(at, reward);
}
}
}

    // `SculkCatalystBlockEntity.CatalystListener`'s trigger on a player's
    // death: for the player the dying guest's combat record credits
    // (`LivingEntity.getKillCredit`), with the death's `killing_blow`.
    // rust: fn guest_catalyst_trigger(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: gi: usize,
    // rust: conn: u32,
    // rust: at: [f64; 3],
    // rust: blow: Option<(String, Option<u32>)>,
    // rust: ) {
TRIGGER :: "minecraft:kill_mob_near_sculk_catalyst"
    // rust: let now = self.world.game_time;
    // rust: let combat = self.guest_combat.get(&conn);
    // rust: let who = combat.and_then(|c| c.kill_credit(now)).and_then(|id| {
    // rust: if self.lan_acting.is_none()
    // rust: && self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.entity_id as u32 == id)
    // rust: {
    // rust: Some(None)
    // rust: } else {
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id as u32 == id)
    // rust: .map(|g| Some(g.conn))
}
    // rust: });
    // rust: let Some(who) = who else { return };
    // rust: let blow = self
    // rust: .guest_killing_blow(host, blow, at, TRIGGER)
    // rust: .unwrap_or_else(|| {
    // rust: horizon_client::advancements::recorded_blow(
    // rust: "minecraft:player_attack".into(),
    // rust: None,
    // rust: at,
    // rust: )
    // rust: });
    // rust: let g = &host.hub.guests[gi];
    // rust: let view = horizon_client::advancements::EntityView {
    // rust: kind: "minecraft:player".into(),
    // rust: position: at,
    // rust: sneaking: g.sneaking,
    // rust: input_sneak: g.input & 32 != 0,
    // rust: gamemode: Some(
    // rust: match g.game_mode {
    // rust: 1 => "creative",
    // rust: 2 => "adventure",
    // rust: 3 => "spectator",
    // rust: _ => "survival",
}
    // rust: .into(),
    // rust: ),
    // rust: ..Default::default()
}
        // CatalystListener: trigger(player, killedEntity, damageSource).
    // rust: match who {
    // rust: None => self.trigger_killed_as(TRIGGER, &view, Some(&blow)),
    // rust: Some(kconn) => {
    // rust: self.as_guest(host, kconn, |g| {
    // rust: g.trigger_killed_as(TRIGGER, &view, Some(&blow));
    // rust: });
}
}
}

    // `ServerPlayer.die` → `Entity.awardKillScore` on the entity the dying
    // guest's combat record credits (`LivingEntity.getKillCredit`): the
    // guest's `entity_killed_player`, with that entity and the death's
    // `killing_blow`. Nothing credited, nothing fires.
    // rust: fn guest_killed_player_trigger(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: at: [f64; 3],
    // rust: blow: Option<(String, Option<u32>)>,
    // rust: ) {
TRIGGER :: "minecraft:entity_killed_player"
    // rust: let now = self.world.game_time;
    // rust: let Some(id) = self
    // rust: .guest_combat
    // rust: .get(&conn)
    // rust: .and_then(|c| c.kill_credit(now))
    // rust: else {
    // rust: return;
}
    // rust: let Some(killer) = self.guest_entity_view(host, id, TRIGGER) else {
    // rust: return;
}
    // rust: let blow = self.guest_killing_blow(host, blow, at, TRIGGER);
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.trigger_killed_as(TRIGGER, &killer, blow.as_ref());
    // rust: });
}

    // The dying guest's last blow (`LivingEntity.getLastDamageSource`), its
    // damage type and causing entity as the combat record held them, as a
    // damage source: the projectile as the direct entity.
    // rust: fn guest_killing_blow(
    // rust: &self,
    // rust: host: &LanHost,
    // rust: blow: Option<(String, Option<u32>)>,
    // rust: at: [f64; 3],
    // rust: trigger: &str,
    // rust: ) -> Option<horizon_client::advancements::DamageView> {
    // rust: let (damage, attacker) = blow?;
        // The damage's causing entity: the player in place, another guest, or
        // a mob (`DamageSource.getEntity`).
    // rust: let source = attacker.and_then(|id| self.guest_entity_view(host, id, trigger));
    // rust: Some(horizon_client::advancements::recorded_blow(
    // rust: damage, source, at,
    // rust: ))
}

    // The entity behind a combat record's id, as `trigger`'s predicates see
    // it: the player in place, a guest, or a mob.
    // rust: fn guest_entity_view(
    // rust: &self,
    // rust: host: &LanHost,
    // rust: id: u32,
    // rust: trigger: &str,
    // rust: ) -> Option<horizon_client::advancements::EntityView> {
    // rust: if self.lan_acting.is_none()
    // rust: && self
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.entity_id as u32 == id)
    // rust: {
            // `player_entity_for` takes `&mut self` (the compound for `nbt`);
            // this view of the killer has the player's records without it.
    // rust: return Some(self.player_entity_for_any(&[trigger]));
}
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id as u32 == id)
    // rust: .map(|g| horizon_client::advancements::EntityView {
    // rust: kind: "minecraft:player".into(),
    // rust: position: g.position,
    // rust: sneaking: g.sneaking,
    // rust: input_sneak: g.input & 32 != 0,
    // rust: ..Default::default()
    // rust: })
    // rust: .or_else(|| {
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| self.mob_entity(m))
    // rust: })
}

    // `ServerPlayer.die`'s message from a guest's own `CombatTracker`, which
    // sits in `guest_combat` between turns.
    // rust: fn guest_death_message(
    // rust: &mut self,
    // rust: conn: u32,
    // rust: me: horizon_client::text::Text,
    // rust: ) -> horizon_client::text::Text {
    // rust: let mut tracker = self.guest_combat.remove(&conn).unwrap_or_default();
    // rust: std::mem::swap(&mut self.combat, &mut tracker);
    // rust: let text = self.combat_death_message_for(me);
    // rust: std::mem::swap(&mut self.combat, &mut tracker);
    // rust: self.guest_combat.insert(conn, tracker);
    // rust: text
}

    // `LivingEntity.stopSleeping` and `ServerPlayer.stopSleepInBed` for a
    // guest who woke up from `head`: stand beside the bed facing it, and
    // teleport the client there.
wake_guest_from :: proc(self: ^Self, host: ^LanHost, gi: uint, head: [i32; 3]) {
}
    // rust: let yaw = host.hub.guests[gi].yaw;
    // rust: let (player, name) = {
    // rust: let g = &host.hub.guests[gi];
    // rust: (g.uuid, g.name.clone())
}
    // rust: self.native_player_bed_leave(player, &name, head);
    // rust: let Some((stand, yaw)) = self.bed_wake_pose(head, yaw) else {
    // rust: return;
}
    // rust: let at = [stand.x, stand.y, stand.z];
    // rust: let g = &mut host.hub.guests[gi];
    // rust: g.position = at;
    // rust: g.previous_position = at;
    // rust: g.yaw = yaw;
    // rust: g.pitch = 0.0;
    // rust: g.moves.clear();
    // rust: if let Some(m) = g.motion.as_mut() {
    // rust: m.position = stand;
    // rust: m.velocity = Vec3::ZERO;
    // rust: m.yaw = yaw;
    // rust: m.pitch = 0.0;
    // rust: let _ = m.set_sleeping(false);
}
    // rust: if !g.dead {
    // rust: host.hub.teleport(gi, Some(at));
}
}

    // rust: pub(super) fn wake_woken_guests(&mut self, host: &mut LanHost) {
    // rust: for gi in 0..host.hub.guests.len() {
    // rust: if host.hub.here(&host.hub.guests[gi])
    // rust: && let Some(head) = host.hub.guests[gi].woke_from.take()
    // rust: {
    // rust: self.wake_guest_from(host, gi, head);
}
}
}

    // rust: pub(super) fn wake_guest(&mut self, host: &mut LanHost, gi: usize) {
    // rust: host.hub.wake(gi);
    // rust: if host.hub.here(&host.hub.guests[gi])
    // rust: && let Some(head) = host.hub.guests[gi].woke_from.take()
    // rust: {
    // rust: self.wake_guest_from(host, gi, head);
}
}

    // `Player.tick`'s sleep counter, and `LivingEntity.tick`'s wake-up of a
    // sleeper who died or whose bed is gone.
guest_sleep_tick :: proc(self: ^Self, host: ^LanHost, gi: uint) {
}
    // rust: let g = &mut host.hub.guests[gi];
    // rust: let was_deep = g.sleep_timer >= 100;
    // rust: g.sleep_timer = super::tick_sleep_timer(g.sleep_timer, g.bed.is_some());
    // rust: let deep_sleep = !was_deep && g.sleep_timer >= 100 && g.bed.is_some();
    // rust: let identity = deep_sleep.then(|| (g.uuid, g.name.clone()));
    // rust: if let Some(head) = g.bed {
    // rust: let block = self.world.block(head[0], head[1], head[2]);
    // rust: let bed = self.res.facts().get(block).name.ends_with("_bed");
    // rust: if g.dead || g.health <= 0.0 || !bed {
    // rust: self.wake_guest(host, gi);
    // rust: } else {
                // LivingEntity.tick: a sleeper's xRot is 0.
    // rust: g.pitch = 0.0;
    // rust: if let Some(m) = g.motion.as_mut() {
    // rust: m.pitch = 0.0;
}
}
}
    // rust: if let Some((player, name)) = identity {
    // rust: self.native_player_deep_sleep(player, &name);
}
}

    // `SleepStatus.update`'s counts over the host's player and the guests:
    // the players not in spectator mode, how many are in bed, and how many
    // of those have slept 100 ticks.
sleep_counts :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (mut active, mut sleeping, mut deep) = (0i64, 0i64, 0i64);
    // rust: let mut count = |in_bed: bool, timer: u32| {
    // rust: active += 1;
    // rust: if in_bed {
    // rust: sleeping += 1;
    // rust: if timer >= 100 {
    // rust: deep += 1;
}
}
}
    // rust: if self.player.is_some() && !self.spectator() {
    // rust: count(self.sleeping.is_some(), self.sleep_timer);
}
    // rust: if let Some(host) = self.lan.as_ref() {
            // A native mod's ignored players count only once in bed.
    // rust: for g in host.hub.guests.iter().filter(|g| {
    // rust: g.placed
    // rust: && !g.spectator()
    // rust: && (g.bed.is_some() || !host.sleep_ignored.contains(&g.uuid))
    // rust: }) {
    // rust: count(g.bed.is_some(), g.sleep_timer);
}
}
    // rust: (active, sleeping, deep)
}

    // `SleepStatus.sleepersNeeded`.
sleepers_needed :: proc(self: ^Self, active: i64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let percent = i64::from(self.ui.rules.int("players_sleeping_percentage").max(0));
    // rust: ((active * percent + 99) / 100).max(1)
}

    // `SleepStatus.areEnoughSleeping` and `areEnoughDeepSleeping` over the
    // host's player and the guests: of the players not in spectator mode,
    // players_sleeping_percentage of them (at least one) are in bed, and as
    // many have slept 100 ticks.
    // rust: pub(super) fn enough_slept(&self) -> bool {
    // rust: let (active, sleeping, deep) = self.sleep_counts();
    // rust: let needed = self.sleepers_needed(active);
    // rust: sleeping >= needed && deep >= needed
}

    // `ServerLevel.updateSleepingPlayerList` and `announceSleepStatus`: when
    // the players or the sleepers change, a published or dedicated world
    // shows everyone "n/m players sleeping", or "Sleeping through this
    // night" once enough are in bed, on the action bar.
    // rust: pub(super) fn announce_sleep_status(&mut self) {
    // rust: let (active, sleeping, _) = self.sleep_counts();
    // rust: let (old_active, old_sleeping) = self.sleep_seen;
    // rust: self.sleep_seen = (active, sleeping);
    // rust: let changed = (old_sleeping > 0 || sleeping > 0)
    // rust: && (old_active != active || old_sleeping != sleeping);
    // rust: let published = self.lan.is_some() || self.options.dedicated.is_some();
    // rust: if !changed || !published {
    // rust: return;
}
        // ServerLevel.canSleepThroughNights.
    // rust: if self.ui.rules.int("players_sleeping_percentage") > 100 {
    // rust: return;
}
    // rust: let needed = self.sleepers_needed(active);
    // rust: let text = if sleeping >= needed {
    // rust: horizon_client::text::Text::translate("sleep.skipping_night", &[])
    // rust: } else {
    // rust: horizon_client::text::Text::translate(
    // rust: "sleep.players_sleeping",
    // rust: &[
    // rust: horizon_client::text::Text::literal(sleeping.to_string()),
    // rust: horizon_client::text::Text::literal(needed.to_string()),
    // rust: ],
    // rust: )
}
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub
    // rust: .overlay_message(horizon_client::lan::data::component_nbt(&text.component()));
}
    // rust: if self.options.dedicated.is_none() {
    // rust: self.titles.set_overlay(text, false);
}
}

    // `ServerLevel.wakeUpAllPlayers` for the guests.
    // rust: pub(super) fn wake_guests(&mut self) {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: for i in 0..host.hub.guests.len() {
    // rust: self.wake_guest(&mut host, i);
}
    // rust: self.lan = Some(host);
}

    // `PlayerList.broadcastSystemMessage` of the advancements guests made
    // (their own actions, commands and ticks).
    // rust: pub(super) fn announce_guest_advancements(&mut self, host: &mut LanHost) {
    // rust: for text in std::mem::take(&mut self.adv.announced) {
    // rust: host.hub
    // rust: .system_message(horizon_client::lan::data::component_nbt(&text.component()));
    // rust: if self.options.dedicated.is_none() {
    // rust: self.system_message(text);
}
}
}

    // `LivingEntity.checkAutoSpinAttack` for a server's copy of a Riptide
    // spinner (it runs before `aiStep`'s countdown clears the damage): the
    // first mob touching the player's box takes `Player.attack` with the
    // spin's damage and the spin ends. A `ServerPlayer` is client
    // authoritative, so its `aiStep` does not travel and both boxes vanilla
    // passes are the current one: no sweep over the tick's moves.
    // rust: pub(super) fn server_spin_attack(&mut self) {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: if p.auto_spin_attack_ticks <= 0 {
    // rust: return;
}
    // rust: let swept = p.bounds();
    // rust: let riding = self.riding;
    // rust: let Some(index) = first_spin_target(
    // rust: swept,
    // rust: riding,
    // rust: self.mobs.iter().map(|m| (m.id, m.removed, m.bounds())),
    // rust: ) else {
    // rust: return;
}
    // rust: self.attack_mob(index);
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: p.auto_spin_attack_ticks = 0;
    // rust: p.auto_spin_attack_dmg = 0.0;
    // rust: p.velocity = p.velocity.scale(-0.2);
}
}

    // The guest's body on the server each tick: ServerPlayer.tick's damage
    // clock and Entity.baseTick's fluid phase (burning), then for each move
    // the guest made ServerGamePacketListenerImpl.handleMovePlayer's jump
    // (`ServerPlayer.jumpFromGround`'s exhaustion),
    // ServerPlayer.doCheckFallDamage (the fall distance grows while they go
    // down and hurts them where they land, as the host's own landing does;
    // water resets it, lava halves it) and checkMovementStatistics (the
    // exhaustion of sprinting and swimming), then LivingEntity.baseTick's
    // hazards (drowning, lava, fire blocks, suffocation, the void), and
    // regeneration and the food tick (ServerPlayer.doTick). Their hurt
    // sounds are heard at the guest.
guest_server_tick :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
        // Entity.baseTick: the boarding cooldown counts down once a tick.
    // rust: if let Some(g) = host.hub.guest_mut(conn) {
    // rust: g.boarding_cooldown = super::boarding::tick_down(g.boarding_cooldown);
}
    // rust: self.guest_replay(host, conn);
    // rust: self.guest_vehicle_tick(host, conn);
        // The last move's fall stands in for the server's delta movement.
    // rust: let fell = host
    // rust: .hub
    // rust: .guest_mut(conn)
    // rust: .and_then(|g| g.moves.last().map(|m| m.0[1]))
    // rust: .unwrap_or(0.0);
    // rust: self.guest_glide_tick(host, conn, fell);
    // rust: let Some(g) = host.hub.guest_mut(conn) else {
    // rust: return;
}
    // rust: let moves = std::mem::take(&mut g.moves);
    // rust: let from_ground = if moves.is_empty() {
    // rust: g.on_ground
    // rust: } else {
    // rust: g.moves_from_ground
}
    // rust: if g.spectator() {
            // Spectators' effects still run (LivingEntity.baseTick).
    // rust: if !g.effects.list.is_empty() {
    // rust: self.as_guest(host, conn, |game| game.tick_mob_effects());
}
    // rust: self.as_guest(host, conn, |game| game.handle_shoulder_entities());
    // rust: return;
}
    // rust: let in_wall = !g.sleeping && self.in_wall(g.position, g.dimensions());
    // rust: let at = g.position;
    // rust: let (sneaking, sleeping) = (g.sneaking, g.sleeping);
    // rust: let riding = g.vehicle.is_some();
    // rust: if g.motion
    // rust: .as_ref()
    // rust: .is_some_and(|m| m.auto_spin_attack_ticks > 0)
    // rust: {
    // rust: self.as_guest(host, conn, |game| game.server_spin_attack());
}
    // rust: let mut soul = None;
    // rust: let mut jumps = 0;
    // rust: let events = self.as_guest(host, conn, |game| {
    // rust: let rules = game.world.health_rules;
    // rust: let freeze_immune = game.wears_freeze_immune();
    // rust: let burn_immune = game.wears_burn_from_stepping_immunity();
    // rust: let boat = game.riding_boat_fluid_box();
    // rust: let Some(player) = game.player.as_mut() else {
    // rust: return (Vec::new(), None);
}
    // rust: player.fluids.boat = boat;
    // rust: let mut w = MotionWorld {
    // rust: entities: &[],
    // rust: player,
    // rust: scene: &mut game.world,
    // rust: assets: &game.pack.assets,
    // rust: collision_binding: game.collision,
    // rust: resources: game.motion,
    // rust: health: &game.health_resources,
}
    // rust: w.player.health.advance_clock();
    // rust: let _ = w.fluid_base_tick();
    // rust: w.player.ground.on_ground = from_ground;
            // Player.aiStep: a flying player that isn't riding starts every tick
            // with no fall distance, so flying down in creative and switching to
            // survival lands without the flight's distance.
    // rust: if w.player.flying && !riding {
    // rust: w.player.fall_distance = 0.0;
}
    // rust: let travelled: Vec<[f64; 3]> = moves.iter().map(|m| m.0).collect();
            // The tick's whole movement, for the delta movement a glide's wall
            // hit reads (`handleMovePlayer` gives the server copy the client's
            // own movement).
    // rust: let tick_movement = travelled.iter().fold(Vec3::ZERO, |sum, d| {
    // rust: sum.add_vector(Vec3::new(d[0], d[1], d[2]))
    // rust: });
            // Entity.move's movementThisTick: each move, from where the
            // tick's first one started.
    // rust: let end = w.player.position;
    // rust: let start = travelled
    // rust: .iter()
    // rust: .fold(end, |p, d| p.subtract(Vec3::new(d[0], d[1], d[2])));
    // rust: w.player.history.clear();
    // rust: let mut from = start;
    // rust: for d in &travelled {
    // rust: let delta = Vec3::new(d[0], d[1], d[2]);
    // rust: let to = from.add_vector(delta);
    // rust: w.player
    // rust: .history
    // rust: .add(horizon_world::entity_move::MovementRecord {
    // rust: from,
    // rust: to,
    // rust: original: Some(delta),
    // rust: });
    // rust: from = to;
}
    // rust: for (moved, on_ground) in moves {
    // rust: let movement = Vec3::new(moved[0], moved[1], moved[2]);
    // rust: if w.player.ground.on_ground && !on_ground && moved[1] > 0.0 {
                    // ServerGamePacketListenerImpl.handlePlayerPositionChange:
                    // the server's copy jumps with the player, so the velocity
                    // it sends them keeps the jump.
    // rust: jumps += 1;
    // rust: let _ = w.jump_from_ground();
}
    // rust: let landed = (|| -> horizon_client::Result<()> {
    // rust: w.set_on_ground_with_movement(on_ground, false, movement)?;
    // rust: let pos = w.legacy_on_position()?;
    // rust: let state = w.block_state(pos)?;
    // rust: w.check_fall_damage(moved[1], on_ground, state, pos)?;
    // rust: w.check_movement_statistics(movement)
    // rust: })();
    // rust: if landed.is_err() {
    // rust: break;
}
}
            // A ServerPlayer travels on the server too
            // (MoveSimulationType.AUTHORITATIVE_SIDE_AND_SERVER), so every tick
            // on a ladder or vine LivingEntity.handleOnClimbable resets its fall
            // distance: climbing down doesn't hurt where it lands (#1255).
    // rust: if w.climbable().unwrap_or(false) {
    // rust: w.player.fall_distance = 0.0;
}
            // ServerGamePacketListenerImpl.handlePlayerPositionChange ends the
            // impulse context on LivingEntity.hasLandedInLiquid: a move into a
            // liquid that does not rise, or a wind charge that lands in water
            // would waive the fall after it.
    // rust: let liquid = w.player.fluids.was_touching_water || w.player.is_in_lava();
    // rust: let delta_y = w.player.velocity.y;
    // rust: w.player.impulse.landed_in_liquid(delta_y, liquid);
            // Entity.applyEffectsFromBlocks along those moves: magma, cactus,
            // lit campfires and grown sweet berry bushes hurt (#1305).
    // rust: w.player.shift_key_down = sneaking;
    // rust: let _ = w.player.set_sleeping(sleeping);
    // rust: w.player.freeze_immune = freeze_immune;
    // rust: w.player.burn_from_stepping_immune = burn_immune;
    // rust: let _ = w.server_block_damage(start);
    // rust: let _ = w.update_soul_speed_block();
    // rust: let _ = w.tick_environment_damage();
    // rust: let _ = w.apply_fire_contact();
    // rust: let _ = w.server_hazards_tick(in_wall);
            // LivingEntity.aiStep: a Riptide spin counts down on the server's
            // copy too, or it would stay in the spin pose (eye 0.4) for good.
            // LivingEntity.tick: a changed scale rebuilds the box. Player.tick
            // ends with updatePlayerPose — or, for a passenger, the rideTick
            // path that clears a swim (#4509 / #3308).
    // rust: let _ = if riding {
    // rust: w.passenger_pose_tick()
    // rust: } else {
    // rust: w.server_player_pose_tick()
}
    // rust: let mut events = std::mem::take(&mut w.player.events);
            // LayeredCauldronBlock.handleEntityOnFireInside along those moves.
    // rust: for event in &events {
    // rust: if let MotionEvent::CauldronExtinguish { pos } = event {
    // rust: game.cauldron_extinguish(*pos);
}
}
            // Entity.baseTick: rain puts out a burning player.
    // rust: game.rain_extinguish_player();
            // WitherRoseBlock.entityInside along those moves.
    // rust: for event in &events {
    // rust: if matches!(event, MotionEvent::InsideWitherRose) {
    // rust: game.wither_rose_contact();
}
}
            // ServerGamePacketListenerImpl.handleMovePlayer:
            // Player.checkMovementStatistics for each move.
    // rust: for d in travelled {
    // rust: game.movement_stats(Vec3::new(d[0], d[1], d[2]));
}
            // LivingEntity.baseTick: a new block position runs the worn
            // enchantments' location_changed effects (frost walker).
    // rust: game.location_changed_effects([start.x, start.y, start.z], from_ground);
            // LivingEntity.baseTick: outside the world border, then tickEffects.
    // rust: game.border_damage();
    // rust: game.tick_mob_effects();
            // Soul Speed's effects (LivingEntity.baseTick's location_changed
            // and tick effects); its particle goes to the players around.
    // rust: soul = game.tick_soul_speed();
    // rust: game.handle_shoulder_entities();
    // rust: let Some(player) = game.player.as_mut() else {
    // rust: return (Vec::new(), None);
}
    // rust: let _ = player.peaceful_regeneration(rules);
    // rust: let _ = player.food_tick(&game.health_resources, rules);
    // rust: events.append(&mut player.events);
    // rust: player.carry_client_movement(tick_movement);
    // rust: let _ = MotionWorld {
    // rust: entities: &[],
    // rust: player,
    // rust: scene: &mut game.world,
    // rust: assets: &game.pack.assets,
    // rust: collision_binding: game.collision,
    // rust: resources: game.motion,
    // rust: health: &game.health_resources,
}
    // rust: .server_travel();
            // Player.aiStep's entity contacts run with the player's body,
            // even when the level and its mobs are frozen. Flush their damage
            // events and marked velocity through the existing guest path.
    // rust: game.touch_pufferfish();
    // rust: let Some(player) = game.player.as_mut() else {
    // rust: return (events, None);
}
            // Landing damage from this travel reaches the tracker too.
    // rust: events.append(&mut player.events);
            // A hurt since the last tick marked the velocity (Entity.markHurt):
            // ServerEntity.sendChanges sends it as it is after this travel.
    // rust: let marked = std::mem::take(&mut player.health.sync_velocity);
    // rust: let velocity = marked.then_some(player.velocity);
            // Player.causeFallDamage: a fall of 2 blocks or more counts.
    // rust: for event in &events {
    // rust: if let MotionEvent::Fall(horizon_client::landing::FallEvent::Statistic(cm)) = event
    // rust: {
    // rust: game.award_custom_stat("fall_one_cm", *cm);
}
}
    // rust: game.record_combat(&events);
    // rust: game.wear_armor(&events);
    // rust: (events, velocity)
    // rust: });
    // rust: let Some((events, marked)) = events else {
    // rust: return;
}
    // rust: if jumps > 0
    // rust: && !horizon_client::mod_api::mods().is_empty()
    // rust: && let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone()))
    // rust: {
    // rust: self.as_guest(host, conn, |game| {
    // rust: for _ in 0..jumps {
    // rust: game.native_player_jump(uuid, &name);
}
    // rust: });
}
    // rust: if let Some((at, velocity)) = soul {
    // rust: super::lan_particles::send_soul_particle(host, at, velocity);
}
    // rust: self.as_guest(host, conn, |game| {
    // rust: game.sculk_step_on_player();
    // rust: game.tick_player_sculk_events();
            // Entity.restituteMovementAfterCollisions: GameEvent.BOUNCE.
    // rust: for event in &events {
    // rust: if matches!(event, MotionEvent::Bounce { .. }) {
    // rust: game.post_entity_event("minecraft:bounce", horizon_client::mobs::Who::Player);
}
}
    // rust: });
    // rust: for event in events {
    // rust: match event {
    // rust: MotionEvent::Health(horizon_client::health::HealthEvent::DamageBroadcast {
    // rust: source,
    // rust: }) => self.guest_damage_broadcast(host, conn, source),
                // LivingEntity.playHurtSound: the server's `Entity.playSound`
                // reaches every player around but the hurt one, whose own
                // client plays it from handleDamageEvent (#4149).
    // rust: MotionEvent::HurtSound(sound) => self.guest_hurt_sound(host, conn, sound),
                // LivingEntity.checkFallDamage: the crumbs reach every player.
    // rust: MotionEvent::Fall(horizon_client::landing::FallEvent::Particles {
    // rust: state,
    // rust: position,
    // rust: count,
    // rust: speed,
    // rust: }) => self.landing_dust(Some(host), state, position, count, speed),
                // A block's own sound names no player: the guest hears it too.
    // rust: MotionEvent::Fall(horizon_client::landing::FallEvent::Sound {
    // rust: sound,
    // rust: position: Some(pos),
    // rust: volume,
    // rust: pitch,
    // rust: }) if sound.block_sound().is_some() => {
    // rust: if let Some(name) = sound.block_sound() {
    // rust: let source = horizon_client::settings::sound_source(name) as i32;
    // rust: let at = [
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 0.5,
    // rust: f64::from(pos.z) + 0.5,
    // rust: ];
    // rust: self.audio.play_unshared(name, Some(at), volume, pitch);
    // rust: host.hub.sound(name, at, volume, pitch, source, None);
}
}
                // LivingEntity.causeFallDamage, and HoneyBlock.fallOn's
                // `entity.playSound`: Player.playSound skips the guest, whose
                // own client plays it; everyone else hears it.
    // rust: MotionEvent::Fall(horizon_client::landing::FallEvent::Sound {
    // rust: sound,
    // rust: volume,
    // rust: pitch,
    // rust: ..
    // rust: }) => {
    // rust: if let Some(name) = sound
    // rust: .player_fall_sound()
    // rust: .or_else(|| sound.honey_landing_sound())
    // rust: {
    // rust: let source = horizon_client::settings::sound_source(name) as i32;
    // rust: self.audio.play_unshared(name, Some(at), volume, pitch);
    // rust: host.hub.sound(name, at, volume, pitch, source, Some(conn));
}
}
                // HoneyBlock.fallOn: entity event 54, including the player who
                // landed (`broadcastEntityEvent` has no excluded player).
    // rust: MotionEvent::Fall(horizon_client::landing::FallEvent::Broadcast(event))
    // rust: if horizon_client::landing::honey_particle_count(event as i8).is_some() =>
    // rust: {
    // rust: if let Some(id) = host.hub.guest(conn).map(|g| g.entity_id) {
    // rust: host.hub.entity_event(id, event as i8, at);
}
}
    // rust: MotionEvent::Fall(event) => self.landing_block_updates(&event),
                // PowderSnowBlock.entityInside: every player around sees the
                // snowflake (`ServerLevel.sendParticles`).
    // rust: MotionEvent::Snowflake { position, velocity } => {
    // rust: super::lan_particles::send_snowflake_particle(
    // rust: host,
    // rust: [position.x, position.y, position.z],
    // rust: [velocity.x, velocity.y, velocity.z],
    // rust: );
}
                // LivingEntity.baseTick's entity event 67, to every client
                // around, the guest's own included; this window draws it too.
    // rust: MotionEvent::Drown => {
    // rust: if let Some(g) = host.hub.guest(conn) {
    // rust: host.hub
    // rust: .entity_event(g.entity_id, super::combat::DROWN_EVENT, at);
}
    // rust: self.drown_particles(at, [0.0; 3]);
}
                // HoneyBlock.maybeDoSlideEffects: the sound reaches the
                // others (Player.playSound excludes the player, whose client
                // plays it), the entity event 53 everyone around.
    // rust: MotionEvent::HoneySlide {
    // rust: pos,
    // rust: sound,
    // rust: particles,
    // rust: } => {
    // rust: if self.world.game_time % 20 == 0 {
    // rust: self.as_guest(host, conn, |game| {
    // rust: game.trigger_honey_slide([pos.x, pos.y, pos.z])
    // rust: });
}
    // rust: let Some((id, at)) = host.hub.guest(conn).map(|g| (g.entity_id, g.position))
    // rust: else {
    // rust: continue;
}
    // rust: if sound {
    // rust: let name = "minecraft:block.honey_block.slide";
    // rust: let source = horizon_client::settings::sound_source(name) as i32;
    // rust: self.audio.play_unshared(name, Some(at), 1.0, 1.0);
    // rust: host.hub.sound(name, at, 1.0, 1.0, source, Some(conn));
}
    // rust: if particles {
    // rust: self.honey_slide_particles(at);
    // rust: host.hub.entity_event(id, 53, at);
}
}
    // rust: _ => {}
}
}
    // rust: if let (Some(v), Some(g)) = (marked, host.hub.guest(conn)) {
    // rust: self.native_player_velocity(g.uuid, &g.name, [v.x, v.y, v.z]);
    // rust: g.send(&C::SetEntityMotion(play::SetEntityMotion {
    // rust: id: g.entity_id,
    // rust: velocity: [v.x, v.y, v.z],
    // rust: }));
}
}

    // ServerGamePacketListenerImpl.handlePlayerCommand START_RIDING_JUMP: the
    // vehicle the guest rides takes its own `handleStartJump` — a horse rears
    // and slides on the rider's keys, a camel dashes — and the sound vanilla's
    // server plays is broadcast to the players near the mount, the rider
    // included (their own client plays none).
lan_start_riding_jump :: proc(self: ^Self, host: ^LanHost, conn: u32, data: i32) {
}
    // rust: let Some(Some(index)) = self.as_guest(host, conn, |g| g.mount_index()) else {
    // rust: return;
}
    // rust: let m = &mut self.mobs[index];
    // rust: let Some((sound, volume)) = crate::game::mounts::start_riding_jump(m, data) else {
    // rust: return;
}
    // rust: let at = m.center();
        // LivingEntity.getSoundSource: a mob's sounds are in the neutral source.
    // rust: let neutral = horizon_client::settings::SOUND_SOURCES
    // rust: .iter()
    // rust: .position(|s| *s == "neutral")
    // rust: .unwrap_or(0) as i32;
    // rust: host.hub.sound(
    // rust: &format!("minecraft:{sound}"),
    // rust: at,
    // rust: volume,
    // rust: 1.0,
    // rust: neutral,
    // rust: None,
    // rust: );
}

    // ServerGamePacketListenerImpl.handlePlayerCommand START_FALL_FLYING:
    // `Player.tryToStartFallFlying`, or else `stopFallFlying` (a second
    // start while gliding ends the glide, as in vanilla).
lan_start_gliding :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: let Some(g) = host.hub.guest_mut(conn) else {
    // rust: return;
}
    // rust: let start = !g.fall_flying && self.guest_can_glide(host, conn) == Some(true);
    // rust: let in_liquid = self
    // rust: .as_guest(host, conn, |game| {
    // rust: game.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.fluids.was_touching_water || p.is_in_lava())
    // rust: })
    // rust: .unwrap_or(true);
    // rust: let mut changed = None;
    // rust: if let Some(g) = host.hub.guest_mut(conn) {
    // rust: let gliding = start && !in_liquid;
    // rust: if g.fall_flying != gliding {
    // rust: g.fall_flying = gliding;
    // rust: changed = Some((g.uuid, g.name.clone(), gliding));
}
}
    // rust: if let Some((uuid, name, gliding)) = changed {
    // rust: self.native_entity_toggle_glide(uuid, &name, gliding);
}
}

    // `Player.canGlide`: not flying, airborne, not riding, no levitation, and
    // a glider that its next point of wear won't break.
guest_can_glide :: proc(self: ^Self, host: ^LanHost, conn: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let g = host.hub.guest_mut(conn)?;
    // rust: if g.flying || g.on_ground || g.vehicle.is_some() {
    // rust: return Some(false);
}
    // rust: self.as_guest(host, conn, |game| {
    // rust: game.glider_worn() && game.potions.effects.get("levitation").is_none()
    // rust: })
}

    // `LivingEntity.updateFallFlying` on the server, once a tick for a
    // gliding guest: the glide ends once `canGlide` fails; otherwise every
    // 20th tick wears the glider by one, and every 10th is an
    // `elytra_glide` game event. Entity.checkFallDistanceAccumulation runs
    // first: a glide that isn't diving keeps the fall distance at 1.
guest_glide_tick :: proc(self: ^Self, host: ^LanHost, conn: u32, fell: f64) {
}
    // rust: let Some(g) = host.hub.guest_mut(conn) else {
    // rust: return;
}
    // rust: if !g.fall_flying {
    // rust: if let Some(m) = g.motion.as_mut() {
    // rust: m.fall_fly_ticks = 0;
}
    // rust: return;
}
    // rust: let creative = g.creative();
    // rust: if let Some(m) = g.motion.as_mut()
    // rust: && fell > -0.5
    // rust: && m.fall_distance > 1.0
    // rust: {
    // rust: m.fall_distance = 1.0;
}
    // rust: if self.guest_can_glide(host, conn) != Some(true) {
    // rust: if let Some(g) = host.hub.guest_mut(conn) {
    // rust: g.fall_flying = false;
}
    // rust: return;
}
    // rust: self.as_guest(host, conn, |game| {
    // rust: let Some(p) = game.player.as_mut() else {
    // rust: return;
}
            // updateFallFlying: last tick's count plus one; LivingEntity.tick
            // counts this tick after aiStep.
    // rust: let next = p.fall_fly_ticks + 1;
    // rust: p.fall_fly_ticks += 1;
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: if next % 10 != 0 {
    // rust: return;
}
    // rust: if (next / 10) % 2 == 0 && !creative {
    // rust: game.wear_glider(1);
}
    // rust: let ctx = game.player_context(None);
    // rust: game.post_game_event("minecraft:elytra_glide", at, ctx);
    // rust: });
}

    // `Entity.isInWall`: a suffocating block in the box at the eyes as wide
    // as 0.8 of the body (0.48 at scale 1, 0.048 at scale 0.1). Suffocating
    // is a full collision box that is also a full render cube
    // (`BlockBehaviour.isSuffocating`'s default; glass and the like opt
    // out), as the mobs' check has it.
in_wall :: proc(self: ^Self, at: [f64; 3], body: Dimensions) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let y = (at[1] + f64::from(body.eye_height)).floor() as i32;
    // rust: let [xs, zs] = eye_columns(at, body);
    // rust: xs.into_iter().any(|x| {
    // rust: zs.clone().any(|z| {
    // rust: let f = self.res.facts().get(self.world.block(x, y, z));
    // rust: f.full_collision && f.solid_render
    // rust: })
    // rust: })
}

    // ServerPlayerGameMode.handleBlockBreakAction, STOP_DESTROY_BLOCK: the client finished
    // digging `pos` (and predicted the break). The server breaks it if its own count of the
    // digging since the START that named `pos` is at least 70 % done; otherwise it keeps digging
    // alone and breaks it when done (`guest_delayed_destroy`), so the client's broken block is
    // never left standing on the server.
guest_stop_digging :: proc(self: ^Self, host: ^LanHost, conn: u32, pos: [i32; 3]) {
}
    // rust: let ticks = host.hub.ticks;
    // rust: let air = self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.world.block(pos[0], pos[1], pos[2]));
    // rust: let per_tick = self
    // rust: .as_guest(host, conn, |g| g.destroy_progress(pos))
    // rust: .unwrap_or(0.0);
    // rust: let decision = {
    // rust: let play = host.play.entry(conn).or_default();
    // rust: play.dig_ended();
    // rust: stop_dig(play, pos, air, ticks, per_tick)
}
    // rust: match decision {
    // rust: StopDig::Other => {}
            // Already broken (the guest's own tick dug it out): only the crack goes.
    // rust: StopDig::Gone => self.guest_crack_gone(host, conn, pos),
    // rust: StopDig::Break => self.guest_destroy(host, conn, pos),
    // rust: StopDig::Delay(start) => {
    // rust: let play = host.play.entry(conn).or_default();
    // rust: if play.delayed.is_none() {
    // rust: play.delayed = Some((pos, start));
}
}
}
}

    // ServerPlayerGameMode.tick's delayed destroy: the block breaks once its progress since
    // the digging started is complete, unless something else removed it first.
guest_delayed_destroy :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: let Some((pos, start)) = host.play.get(&conn).and_then(|p| p.delayed) else {
    // rust: return;
}
    // rust: let ticks = host.hub.ticks;
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let progress = if self.res.facts().is_air(state) {
    // rust: None
    // rust: } else {
    // rust: self.as_guest(host, conn, |g| g.destroy_progress(pos))
    // rust: .map(|p| p * (ticks - start + 1) as f32)
}
    // rust: match progress {
    // rust: Some(p) if p < 1.0 => {}
    // rust: done => {
    // rust: if let Some(play) = host.play.get_mut(&conn) {
    // rust: play.delayed = None;
}
    // rust: if done.is_some() {
    // rust: self.guest_destroy(host, conn, pos);
}
}
}
}

    // ServerPlayerGameMode.destroyBlock for a guest, its crack cleared for the others
    // (`destroyBlockProgress(id, pos, -1)`).
guest_destroy :: proc(self: ^Self, host: ^LanHost, conn: u32, pos: [i32; 3]) {
}
    // rust: self.as_guest(host, conn, |g| {
    // rust: let _ = g.break_block(pos);
    // rust: });
    // rust: self.guest_crack_gone(host, conn, pos);
}

    // The crack animation other players see.
guest_dig_feedback :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let play = host.play.entry(conn).or_default();
    // rust: let Some((pos, _)) = play.digging else {
    // rust: return;
}
        // ServerPlayerGameMode.tick: a block gone while it is dug (the guest's own tick broke
        // it, or something else did) clears the crack.
    // rust: if play.last_progress >= 0
    // rust: && self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.world.block(pos[0], pos[1], pos[2]))
    // rust: {
    // rust: play.last_progress = -1;
    // rust: self.guest_crack_gone(host, conn, pos);
    // rust: return;
}
    // rust: let progress = play
    // rust: .mining
    // rust: .as_ref()
    // rust: .map_or(-1, |m| (m.progress.clamp(0.0, 1.0) * 10.0) as i32 - 1);
    // rust: let swinging = play.swing.swinging();
    // rust: if progress != play.last_progress && progress >= 0 {
    // rust: play.last_progress = progress;
    // rust: let guest = &host.hub.guests[gi];
    // rust: self.native_block_break_progress_update(guest.uuid, &guest.name, pos, progress);
            // The host player sees it too (on the server thread its window is a guest).
    // rust: self.destroy_block_progress(host.hub.guests[gi].entity_id, pos, progress);
    // rust: host.hub.broadcast_near(
    // rust: [f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])],
    // rust: 64.0,
    // rust: &C::BlockDestruction(play::BlockDestruction {
    // rust: id: host.hub.guests[gi].entity_id,
    // rust: pos,
    // rust: progress: progress as u8,
    // rust: }),
    // rust: Some(conn),
    // rust: );
}
    // rust: let _ = swinging;
}

    // `level.destroyBlockProgress(id, pos, -1)` for a guest: its crack on `pos` is gone, for the
    // host and the other guests.
    // A player who dies digs and uses nothing any more: the block it was
    // breaking, or had left to break (`hasDelayedDestroy`), stays, and its
    // crack goes. Respawning gives it a new ServerPlayerGameMode (#1315).
guest_forget_digging :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: let Some(play) = host.play.get_mut(&conn) else {
    // rust: return;
}
    // rust: let cracked = play.digging.take().filter(|_| play.last_progress >= 0);
    // rust: play.mining = None;
    // rust: play.delayed = None;
        // Respawning gives it a new ServerPlayerGameMode: the clock goes with the body.
    // rust: play.destroy_pos = None;
    // rust: play.destroy_delay = 0;
    // rust: play.using = None;
    // rust: play.last_progress = -1;
    // rust: if let Some((pos, _)) = cracked {
    // rust: self.guest_crack_gone(host, conn, pos);
}
}
guest_crack_gone :: proc(self: ^Self, host: ^LanHost, conn: u32, pos: [i32; 3]) {
}
    // rust: let Some(id) = host.hub.guest(conn).map(|g| g.entity_id) else {
    // rust: return;
}
    // rust: self.destroy_block_progress(id, pos, -1);
    // rust: host.hub.broadcast_near(
    // rust: [f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])],
    // rust: 64.0,
    // rust: &C::BlockDestruction(play::BlockDestruction {
    // rust: id,
    // rust: pos,
    // rust: progress: 255,
    // rust: }),
    // rust: Some(conn),
    // rust: );
}

    // Dropped items touching a guest go into their inventory
    // (`ItemEntity.playerTouch`, then `ServerPlayer.onItemPickup`).
guest_pickups :: proc(self: ^Self, host: ^LanHost, gi: uint) {
}
    // rust: let (conn, mode, position, id, uuid) = {
    // rust: let g = &host.hub.guests[gi];
    // rust: (
    // rust: g.conn,
    // rust: g.game_mode,
    // rust: g.position,
    // rust: g.entity_id,
    // rust: horizon_client::lan::playerdata::uuid_ints(g.uuid),
    // rust: )
}
    // rust: if mode == SPECTATOR || self.dropped.is_empty() {
    // rust: return;
}
    // rust: let near: Vec<_> = self
    // rust: .dropped
    // rust: .iter()
    // rust: .filter(|d| {
    // rust: d.pickup_delay == 0
    // rust: && d.target.is_none_or(|t| t == uuid)
    // rust: && (d.position.x - position[0]).abs() < 1.5
    // rust: && (d.position.z - position[2]).abs() < 1.5
    // rust: && d.position.y > position[1] - 0.6
    // rust: && d.position.y < position[1] + 2.4
    // rust: })
    // rust: .map(|d| d.id)
    // rust: .collect();
    // rust: let mut taken = Vec::new();
    // rust: for item_id in near.into_iter().rev() {
    // rust: let Some(item) = self.dropped.iter().find(|d| d.id == item_id) else {
    // rust: continue;
}
    // rust: let stack = item.stack.clone();
    // rust: let refused =
    // rust: self.as_guest(host, conn, |g| g.native_pickup_refused(&stack)) == Some(true);
            // The hook can remove or change any item entity.
    // rust: let Some(i) = self.dropped.iter().position(|d| d.id == item_id) else {
    // rust: continue;
}
    // rust: if refused {
    // rust: self.dropped[i].pickup_delay = 10;
    // rust: continue;
}
    // rust: let stack = self.dropped[i].stack.clone();
    // rust: let before = stack.count;
    // rust: let thrower = self.dropped[i].thrower;
    // rust: let rest = self.as_guest(host, conn, |g| g.give(stack)).flatten();
    // rust: match rest {
    // rust: None => {
    // rust: let item = self.remove_dropped(i);
    // rust: if let Some(thrower) = thrower {
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.trigger_thrown_picked_up_by_player(&item.stack, thrower);
    // rust: });
}
    // rust: taken.push((item_id, before));
}
    // rust: Some(rest) if rest.count < before => {
    // rust: self.dropped[i].stack = rest;
    // rust: if let Some(thrower) = thrower {
    // rust: let left = self.dropped[i].stack.clone();
    // rust: self.as_guest(host, conn, |g| {
    // rust: g.trigger_thrown_picked_up_by_player(&left, thrower);
    // rust: });
}
    // rust: taken.push((item_id, before - self.dropped[i].stack.count));
}
    // rust: Some(_) => {}
}
}
        // Entity.take: the clients play the pickup sound themselves
        // (handleTakeItemEntity).
    // rust: for (item, count) in taken {
    // rust: host.hub.take_item(item as i32, id, count as i32, position);
}
}

    // `Player.aiStep` touching arrows in the guest's box grown by (1, 0.5, 1):
    // `AbstractArrow.playerTouch` for a guest, as `touch_arrows` does for the
    // host's player. The guest's own client plays the pickup sound
    // (`handleTakeItemEntity`).
guest_arrows :: proc(self: ^Self, host: ^LanHost, gi: uint) {
}
//         use horizon_client::arrows::Touch;
    // rust: let (conn, id, at, creative, unable, dims, player, name) = {
    // rust: let g = &host.hub.guests[gi];
    // rust: (
    // rust: g.conn,
    // rust: g.entity_id,
    // rust: g.position,
    // rust: g.creative(),
    // rust: g.spectator() || g.dead || g.health <= 0.0,
    // rust: g.dimensions(),
    // rust: g.uuid,
    // rust: g.name.clone(),
    // rust: )
}
    // rust: if unable || self.creatures.projectiles.is_empty() {
    // rust: return;
}
    // rust: let w = f64::from(dims.width) / 2.0;
    // rust: let reach = Aabb::new(
    // rust: Vec3::new(at[0] - w, at[1], at[2] - w),
    // rust: Vec3::new(at[0] + w, at[1] + f64::from(dims.height), at[2] + w),
    // rust: )
    // rust: .inflate(Vec3::new(1.0, 0.5, 1.0));
    // rust: let mut projectiles = std::mem::take(&mut self.creatures.projectiles);
    // rust: let mut picked = Vec::new();
    // rust: projectiles.retain(|shot| {
    // rust: let Some(a) = shot.arrow.as_ref().filter(|a| !a.removed) else {
    // rust: return true;
}
    // rust: let p = shot.position;
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(p.x - 0.25, p.y, p.z - 0.25),
    // rust: Vec3::new(p.x + 0.25, p.y + 0.5, p.z + 0.25),
    // rust: );
    // rust: if !bounds.intersects(reach) {
    // rust: return true;
}
    // rust: let taken = match a.player_touch(creative) {
    // rust: Touch::Ignore => false,
    // rust: Touch::Take => true,
                // Inventory.add: a creative player takes what does not fit.
    // rust: Touch::Give(stack) => {
    // rust: self.as_guest(host, conn, |g| g.give(stack))
    // rust: .flatten()
    // rust: .is_none()
    // rust: || creative
}
}
    // rust: if taken {
    // rust: picked.push(shot.clone());
}
    // rust: !taken
    // rust: });
    // rust: self.creatures.projectiles = projectiles;
    // rust: for shot in picked {
    // rust: if let Some(arrow) = shot.arrow.as_ref() {
    // rust: self.native_player_pickup_arrow(player, &name, shot.id, &arrow.pickup_item.item);
}
    // rust: host.hub.take_item(shot.id as i32, id, 1, at);
}
}

    // `Player.tick`'s takeXpDelay and `Player.aiStep`'s touch of the
    // experience orbs in the guest's box grown by 1, 0.5, 1: one of them at
    // random, at most every 2 ticks (`ExperienceOrb.playerTouch`), repairs
    // with Mending and gives the rest as points. Everyone near hears it.
guest_orbs :: proc(self: ^Self, host: ^LanHost, gi: uint) {
}
    // rust: let g = &host.hub.guests[gi];
    // rust: let height = f64::from(g.dimensions().height);
    // rust: let (conn, id, at, player, name) =
    // rust: (g.conn, g.entity_id, g.position, g.uuid, g.name.clone());
    // rust: let unable = g.spectator() || g.dead || g.health <= 0.0;
    // rust: let play = host.play.entry(conn).or_default();
    // rust: if play.xp_delay > 0 {
    // rust: play.xp_delay -= 1;
    // rust: self.native_player_exp_cooldown_change(player, &name, play.xp_delay);
}
    // rust: if unable || play.xp_delay > 0 {
    // rust: return;
}
    // rust: let (min, max) = (
    // rust: [at[0] - 1.3, at[1] - 0.5, at[2] - 1.3],
    // rust: [at[0] + 1.3, at[1] + height + 0.5, at[2] + 1.3],
    // rust: );
    // rust: let touching: Vec<usize> = self
    // rust: .orbs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, o)| {
    // rust: o.position.x + 0.25 > min[0]
    // rust: && o.position.x - 0.25 < max[0]
    // rust: && o.position.y + 0.5 > min[1]
    // rust: && o.position.y < max[1]
    // rust: && o.position.z + 0.25 > min[2]
    // rust: && o.position.z - 0.25 < max[2]
    // rust: })
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: if touching.is_empty() {
    // rust: return;
}
        // Util.getRandom(orbs, random).
    // rust: let pick = self
    // rust: .world
    // rust: .random
    // rust: .next_int_bound(touching.len() as i32)
    // rust: .unwrap_or(0) as usize;
        // A merged orb gives its value once per count and goes at zero.
    // rust: let index = touching[pick];
    // rust: let mut orb = self.orbs[index].clone();
    // rust: let mut canceled = false;
        // Swapping the guest in costs: only when a mod hears the pickup.
    // rust: let mut listened = false;
    // rust: if self.serving.is_some() || self.options.dedicated.is_some() {
    // rust: self.native_experience_orb_pickup_listened(&mut listened);
}
    // rust: if listened {
    // rust: let dimension = self.dim.id();
    // rust: let called = self.as_guest(host, conn, |game| {
    // rust: let player = game.native_acting_id();
    // rust: game.native_experience_orb_pickup(
    // rust: player,
    // rust: dimension,
    // rust: orb.id,
    // rust: &mut orb.value,
    // rust: &mut orb.count,
    // rust: &mut canceled,
    // rust: );
    // rust: });
    // rust: if called.is_none() || canceled {
    // rust: return;
}
    // rust: orb.value = orb.value.clamp(1, i32::MAX as u32);
    // rust: orb.count = orb.count.max(1);
    // rust: self.orbs[index].value = orb.value;
    // rust: self.orbs[index].count = orb.count;
}
    // rust: if orb.count <= 1 {
    // rust: self.remove_orb(index);
    // rust: } else {
    // rust: self.orbs[index].count -= 1;
}
    // rust: host.play.entry(conn).or_default().xp_delay = 2;
    // rust: self.native_player_exp_cooldown_change(player, &name, 2);
    // rust: host.hub.take_item(orb.id as i32, id, 1, at);
        // ClientPacketListener.handleTakeItemEntity's sound, at the orb.
    // rust: let pitch = (self.world.random.next_float() - self.world.random.next_float()) * 0.35 + 0.9;
    // rust: let p = orb.position;
    // rust: self.audio.play(
    // rust: "minecraft:entity.experience_orb.pickup",
    // rust: Some([p.x, p.y, p.z]),
    // rust: 0.1,
    // rust: pitch,
    // rust: );
    // rust: let value = orb.value;
    // rust: self.as_guest(host, conn, |game| {
    // rust: let rest = game.mending(value);
    // rust: if rest > 0 {
    // rust: let (Some(player), Some(name)) =
    // rust: (game.lan_acting_uuid, game.lan_acting_name.clone())
    // rust: else {
    // rust: return;
}
    // rust: let mut amount = rest.min(i32::MAX as u32) as i32;
    // rust: game.native_player_exp_change(player, &name, &mut amount);
    // rust: game.give_orb_points(amount.max(0) as u32);
}
    // rust: });
}

    // `level.playSound(player, ...)` of a guest's use it predicted (`remote::hand_operated`
    // blocks only, as the guest decides): the others hear it now, the guest already did.
guest_use_sounds :: proc(self: ^Self, host: ^LanHost, conn: u32, logged: uint, heard: uint) {
}
    // rust: let changed: Vec<(i32, i32, i32)> = self
    // rust: .world
    // rust: .block_log
    // rust: .as_ref()
    // rust: .map_or(&[][..], |log| log.get(logged..).unwrap_or(&[]))
    // rust: .to_vec();
    // rust: let facts = self.res.facts();
        // BlockItem.place: `playSound(player, ...)`, for the others only. The
        // placer's client plays it as its block appears.
    // rust: let placed: Vec<([f64; 3], String)> = changed
    // rust: .iter()
    // rust: .map(|&(x, y, z)| {
    // rust: let at = [f64::from(x) + 0.5, f64::from(y) + 0.5, f64::from(z) + 0.5];
    // rust: let name = &facts.get(self.world.block(x, y, z)).sounds.place;
    // rust: (at, name.trim_start_matches("minecraft:").to_owned())
    // rust: })
    // rust: .collect();
    // rust: if let Some(capture) = self.audio.capture.as_mut() {
    // rust: let mut i = heard.min(capture.len());
    // rust: while i < capture.len() {
    // rust: let (name, at) = (&capture[i].event, &capture[i].position);
    // rust: let place = placed
    // rust: .iter()
    // rust: .any(|(p, n)| p == at && name.trim_start_matches("minecraft:") == n.as_str());
    // rust: if place {
    // rust: let sound = capture.remove(i);
    // rust: host.hub.captured_sound(&sound, Some(conn));
    // rust: } else {
    // rust: i += 1;
}
}
}
    // rust: if changed.is_empty()
    // rust: || !changed.iter().all(|&(x, y, z)| {
    // rust: super::remote::hand_operated(&facts.get(self.world.block(x, y, z)).name)
    // rust: })
    // rust: {
    // rust: return;
}
    // rust: let Some(capture) = self.audio.capture.as_mut() else {
    // rust: return;
}
    // rust: let sounds: Vec<_> = capture.drain(heard.min(capture.len())..).collect();
    // rust: for sound in sounds {
    // rust: host.hub.captured_sound(&sound, Some(conn));
}
}

    // `InstrumentItem.play`'s `level.playSound(player, ...)`: the others hear
    // a guest's horn now, the guest's own client played it as it used it.
    // rust: fn guest_instrument_sound(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: heard: usize,
    // rust: horn: Option<String>,
    // rust: ) {
    // rust: let (Some(horn), Some(capture)) = (horn, self.audio.capture.as_mut()) else {
    // rust: return;
}
    // rust: let mut i = heard.min(capture.len());
    // rust: while i < capture.len() {
    // rust: if capture[i].event == horn {
    // rust: let sound = capture.remove(i);
    // rust: host.hub.captured_sound(&sound, Some(conn));
    // rust: } else {
    // rust: i += 1;
}
}
}

    // A level sound's old emitter must still be known at playback. Keep
    // sounds needing a new pairing queued, with their later removals held.
    // rust: pub(super) fn lan_prepare_captured_sounds(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: entities: &[horizon_client::lan::entity::EntityState],
    // rust: ) {
    // rust: let Some(sounds) = self.audio.capture.as_mut() else {
    // rust: return;
}
    // rust: let blocks: Vec<_> = host
    // rust: .broken
    // rust: .iter()
    // rust: .copied()
    // rust: .chain(
    // rust: self.lan_events
    // rust: .iter()
    // rust: .filter(|(kind, ..)| *kind == 2001)
    // rust: .map(|(_, pos, ..)| pos.map(f64::from)),
    // rust: )
    // rust: .collect();
    // rust: sounds.retain(|sound| !captured_block_break(sound, &blocks));
    // rust: host.hub.prepare_captured_sounds(sounds, entities);
}

    // Positional sounds and level events of the tick, for the guests.
    // rust: pub(super) fn lan_broadcast_effects(&mut self, host: &mut LanHost) {
    // rust: let sounds = self.audio.capture.take().unwrap_or_default();
    // rust: self.audio.capture = Some(Vec::new());
    // rust: let blocks: Vec<[f64; 3]> = std::mem::take(&mut host.broken);
    // rust: for sound in sounds {
            // Block breaks are heard through the level event.
    // rust: if captured_block_break(&sound, &blocks) {
    // rust: continue;
}
    // rust: host.hub.captured_sound(&sound, None);
}
    // rust: host.hub.finish_captured_sounds();
}

    // `LivingEntity.tick`'s arrows and bee stingers falling out of the
    // players' bodies, and their counts for the players around
    // (`DATA_ARROW_COUNT_ID`, `DATA_STINGER_COUNT_ID`).
    // rust: pub(super) fn lan_stuck(&mut self, host: &mut LanHost, paused: bool) {
    // rust: if !paused {
    // rust: self.combat.stuck.tick();
}
    // rust: for g in &mut host.hub.guests {
    // rust: g.shoulders = super::shoulders::shoulder_variants(g.saved.as_ref());
    // rust: g.stuck = match self.guest_combat.get_mut(&g.conn) {
    // rust: Some(combat) => {
    // rust: if !paused {
    // rust: combat.stuck.tick();
}
    // rust: (combat.stuck.arrows, combat.stuck.stingers)
}
    // rust: None => (0, 0),
}
}
}

    // The guests' items in use, for the players around (`LivingEntity.startUsingItem`
    // and `stopUsingItem` set DATA_LIVING_ENTITY_FLAGS).
    // rust: pub(super) fn lan_living_flags(&mut self, host: &mut LanHost) {
    // rust: for g in &mut host.hub.guests {
    // rust: let using = host.play.get(&g.conn).and_then(GuestPlay::using);
    // rust: g.living_flags = super::lan::living_flags(using);
}
}

    // A use the server ran swung the guest's hand: their own client is told
    // too (`swing(hand, true)` for a SwingSource.SERVER result). Horizon's
    // client does not run uses itself, so it does not predict the swing; a
    // client that did (a block placed) is still in the first half of its
    // swing and ignores it (`SwingState.startIfAble`).
lan_swing_back :: proc(self: ^Self, host: ^LanHost, conn: u32, swung: Maybe(bool)) {
}
    // rust: if swung != Some(true) {
    // rust: return;
}
    // rust: let (Some(g), Some(play)) = (host.hub.guest(conn), host.play.get(&conn)) else {
    // rust: return;
}
    // rust: if let Some(c) = play.swing.current {
    // rust: host.hub
    // rust: .send_to(conn, &swing_packet(g.entity_id, c.hand, c.animation));
}
}

    // The tick's arm swings for the players around (each guest's to everyone
    // else), and `LivingEntity.updateSwingTime` for the guests' bodies here.
    // rust: pub(super) fn lan_swings(&mut self, host: &mut LanHost) {
    // rust: let conns: Vec<u32> = host.play.keys().copied().collect();
    // rust: for conn in conns {
    // rust: let Some(g) = host.hub.guests.iter().find(|g| g.conn == conn) else {
    // rust: continue;
}
    // rust: let (id, at, here) = (g.entity_id, g.position, host.hub.here(g));
    // rust: let play = host.play.get_mut(&conn).expect("play");
    // rust: let swung = std::mem::take(&mut play.swings) > 0;
    // rust: if let (true, true, Some(c)) = (swung, here, play.swing.current) {
    // rust: let packet = swing_packet(id, c.hand, c.animation);
    // rust: host.hub.broadcast_near(at, 128.0, &packet, Some(conn));
}
    // rust: play.swing.tick();
}
}
}

captured_block_break :: proc(sound: ^horizon_client::audio::CapturedSound, blocks: ^[[f64; 3]]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: sound.entity.is_none()
    // rust: && blocks
    // rust: .iter()
    // rust: .any(|b| (0..3).all(|k| (b[k] + 0.5 - sound.position[k]).abs() < 1e-6))
}

// ClientboundSwingAnimationPacket: the hand and the animation (its type and
// base duration; each client applies the swinger's haste and fatigue).
swing_packet :: proc(id: i32, hand: Hand, animation: SwingAnimation) -> C {
    // Ported from Horizon
    return {}
}
    // rust: C::SwingAnimation(play::SwingAnimation {
    // rust: id,
    // rust: hand: i32::from(hand == Hand::Off),
    // rust: kind: i32::from(animation.kind),
    // rust: duration: animation.duration,
    // rust: })
}

// The block columns `Entity.isInWall` looks at: `AABB.ofSize` around the
// eyes, 0.8 of the body's width across (`BlockPos.betweenClosedStream`).
eye_columns :: proc(at: [f64; 3], body: Dimensions) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let half = f64::from(body.width * 0.8) / 2.0;
    // rust: let range = |v: f64| (v - half).floor() as i32..=(v + half).floor() as i32;
    // rust: [range(at[0]), range(at[2])]
}

// What `ServerPlayerGameMode.handleBlockBreakAction`'s STOP_DESTROY_BLOCK branch does with a
// guest's STOP.
StopDig :: enum {
    // A block the last START did not name: the STOP is not this dig's.
    Other,
    // Already broken, by the guest's own tick: only the crack goes.
    Gone,
    // The dig the START counts is at least 70 % done: the block breaks outright.
    Break,
    // Less than that: the server finishes it alone from that same START.
    Delay(u64),
}

// The STOP branch's decision: a STOP is measured from the START that named its block
// (`destroyPos`, which an abort or a STOP from out of reach leaves alone), whose ticks times
// `getDestroyProgress` decide between the break and the delayed dig (#4124).
stop_dig :: proc(play: ^GuestPlay, pos: [i32; 3], air: bool, ticks: u64, per_tick: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match play.dig_start_for(pos) {
    // rust: None => StopDig::Other,
    // rust: Some(_) if air => StopDig::Gone,
    // rust: Some(start) if per_tick * (ticks - start + 1) as f32 >= 0.7 => StopDig::Break,
    // rust: Some(start) => StopDig::Delay(start),
}
}

    // rust: mod tests {
//     use super::eye_columns;
//     use horizon_client::pose::Pose;

a_block_break_suppresses_its_positional_duplicate_but_not_an_entity_sound :: proc() {
}
    // rust: let mut sound = horizon_client::audio::CapturedSound {
    // rust: event: "minecraft:block.stone.break".into(),
    // rust: position: [1.5, 64.5, -2.5],
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: source: 4,
    // rust: entity: None,
    // rust: except_entity: None,
}
    // rust: let broken = [[1.0, 64.0, -3.0]];
    // rust: assert!(super::captured_block_break(&sound, &broken));
    // rust: sound.entity = Some(37);
    // rust: assert!(!super::captured_block_break(&sound, &broken));
    // rust: sound.entity = None;
    // rust: sound.position[0] += 0.25;
    // rust: assert!(!super::captured_block_break(&sound, &broken));
}

    // #4124: a STOP is measured from the START that named its block (`destroyPos`) — an abort, or
    // a STOP from out of reach, ends the dig the guest's button held but leaves that clock — and
    // breaks the block at 70 % of the dig, or the server finishes it alone from the same START.
    // A guest that reaches a block only at a jump's apex keeps its dig this way, and no other
    // block or new body inherits the clock.
a_stop_after_a_fall_is_measured_from_the_starts_clock :: proc() {
}
//         use super::{GuestPlay, Mining, StopDig, stop_dig};
    // rust: let pos = [12, 70, -5];
    // rust: let mut play = GuestPlay {
    // rust: digging: Some((pos, [0, 1, 0])),
    // rust: mining: Some(Mining {
    // rust: pos,
    // rust: progress: 0.5,
    // rust: ticks: 8,
    // rust: }),
    // rust: destroy_pos: Some(pos),
    // rust: dig_start: 1000,
    // rust: ..GuestPlay::default()
}
        // The landing: the dig the button held is gone, the clock the START set is not.
    // rust: play.dig_ended();
    // rust: assert!(play.digging.is_none() && play.mining.is_none());
        // 13 ticks of 0.05: 65 % of the dig, so the server finishes it from tick 1000 itself.
    // rust: assert_eq!(
    // rust: stop_dig(&play, pos, false, 1012, 0.05),
    // rust: StopDig::Delay(1000)
    // rust: );
        // 16 ticks: 80 %, the STOP breaks the block outright.
    // rust: assert_eq!(stop_dig(&play, pos, false, 1015, 0.05), StopDig::Break);
        // A block the START did not name never gets the clock, and a broken one only its crack.
    // rust: assert_eq!(
    // rust: stop_dig(&play, [12, 71, -5], false, 1015, 0.05),
    // rust: StopDig::Other
    // rust: );
    // rust: assert_eq!(stop_dig(&play, pos, true, 1015, 0.05), StopDig::Gone);
        // A respawn's new ServerPlayerGameMode starts from no clock at all.
    // rust: play.destroy_pos = None;
    // rust: assert_eq!(stop_dig(&play, pos, false, 1015, 0.05), StopDig::Other);
}

    // #3684: a player shrunk to `minecraft:scale` 0.1 who stands 0.05 from a
    // wall has eyes 0.048 wide, which don't reach into it: they don't
    // suffocate there, as a full-sized player 0.3 from the wall doesn't.
a_small_player_checks_only_the_blocks_at_their_small_eyes :: proc() {
}
    // rust: let at = [205.95, 100.0, 530.5];
    // rust: assert_eq!(
    // rust: eye_columns(at, Pose::Standing.dimensions(0.1)),
    // rust: [205..=205, 530..=530]
    // rust: );
    // rust: assert_eq!(
    // rust: eye_columns(at, Pose::Standing.dimensions(1.0)),
    // rust: [205..=206, 530..=530]
    // rust: );
    // rust: assert_eq!(
    // rust: eye_columns([205.7, 100.0, 530.5], Pose::Standing.dimensions(1.0)),
    // rust: [205..=205, 530..=530]
    // rust: );
}
}

// A `ServerboundSelectBundleItemPacket` slot as the hub's `select_bundle_item` reads it.
// With a crafting table or a station open (`own` slots of its own first), its
// inventory part is the inventory menu's main inventory and hotbar from slot 9, in
// the same order; its own slots hold no bundle the hub can reach.
bundle_inventory_slot :: proc(slot: uint, own: Maybe(uint)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match own {
    // rust: Some(own) => slot.checked_sub(own).filter(|s| *s < 36).map(|s| s + 9),
    // rust: None => Some(slot),
}
}

    // rust: mod bundle_slot_tests {
//     use super::bundle_inventory_slot;

    // A crafting table (10 slots of its own) and an enchanting table (2): the first
    // inventory slot and the last hotbar slot map to 9 and 44; their own slots to none.
station_menus_map_to_the_inventory_menu :: proc() {
}
    // rust: assert_eq!(bundle_inventory_slot(10, Some(10)), Some(9));
    // rust: assert_eq!(bundle_inventory_slot(45, Some(10)), Some(44));
    // rust: assert_eq!(bundle_inventory_slot(2, Some(2)), Some(9));
    // rust: assert_eq!(bundle_inventory_slot(5, Some(10)), None);
    // rust: assert_eq!(bundle_inventory_slot(46, Some(10)), None);
    // rust: assert_eq!(bundle_inventory_slot(45, None), Some(45));
}
}

// Where the server aims a guest's attack or interact on a mob. The packet names only the
// entity, so the server picked the mob's centre; a slab, trapdoor, stair or fence between the
// eyes and that centre then hid a mob the guest's own crosshair hit through the gap (#5772).
// This returns the centre when it is visible, else the visible point of the box nearest to it (the one nearer the eyes when two are equally near)
// (`occluded` tells whether a block outline hides a point from the eyes); the centre again
// when the whole box is hidden.
    // rust: fn visible_aim_point(
    // rust: eye: [f64; 3],
    // rust: lo: [f64; 3],
    // rust: hi: [f64; 3],
    // rust: occluded: impl Fn([f64; 3]) -> bool,
    // rust: ) -> [f64; 3] {
    // rust: let centre = [0, 1, 2].map(|k| (lo[k] + hi[k]) / 2.0);
    // rust: if !occluded(centre) {
    // rust: return centre;
}
    // rust: let margin = [0, 1, 2].map(|k| ((hi[k] - lo[k]) / 2.0).min(0.02));
    // rust: let across = |k: usize, steps: usize| {
    // rust: (0..=steps)
    // rust: .map(|i| {
    // rust: lo[k] + margin[k] + (hi[k] - lo[k] - 2.0 * margin[k]) * i as f64 / steps as f64
    // rust: })
    // rust: .collect::<Vec<f64>>()
}
    // rust: let (xs, ys, zs) = (across(0, 2), across(1, 4), across(2, 2));
    // rust: let mut candidates = Vec::with_capacity(xs.len() * ys.len() * zs.len());
    // rust: for &x in &xs {
    // rust: for &y in &ys {
    // rust: for &z in &zs {
    // rust: candidates.push([x, y, z]);
}
}
}
    // rust: let nearness = |p: &[f64; 3]| (0..3).map(|k| (p[k] - centre[k]).powi(2)).sum::<f64>();
    // rust: let from_eye = |p: &[f64; 3]| (0..3).map(|k| (p[k] - eye[k]).powi(2)).sum::<f64>();
    // rust: candidates.sort_by(|a, b| {
    // rust: nearness(a)
    // rust: .total_cmp(&nearness(b))
    // rust: .then(from_eye(a).total_cmp(&from_eye(b)))
    // rust: .then(a[1].total_cmp(&b[1]))
    // rust: .then(a[0].total_cmp(&b[0]))
    // rust: .then(a[2].total_cmp(&b[2]))
    // rust: });
    // rust: candidates
    // rust: .into_iter()
    // rust: .find(|p| !occluded(*p))
    // rust: .unwrap_or(centre)
}

    // rust: mod aim_point_tests {
//     use super::visible_aim_point;

EYE :: [-760.7, 70.27, -450.4]
    // A zombie one block behind a top slab: its centre is above the 0.5 gap under the slab.
LO :: [-763.0, 70.0, -450.9]
HI :: [-762.4, 71.95, -450.3]

    // A top slab filling x in [-762, -761] with its underside at y 70.5: a point is hidden when
    // the line from the eyes is above 70.5 anywhere inside that column.
behind_top_slab :: proc(p: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let y_at = |x: f64| EYE[1] + (p[1] - EYE[1]) * (x - EYE[0]) / (p[0] - EYE[0]);
    // rust: p[0] < -762.0 && (y_at(-761.0) > 70.5 || y_at(-762.0) > 70.5)
}

a_visible_centre_is_kept :: proc() {
}
    // rust: let centre = [
    // rust: (LO[0] + HI[0]) / 2.0,
    // rust: (LO[1] + HI[1]) / 2.0,
    // rust: (LO[2] + HI[2]) / 2.0,
    // rust: ];
    // rust: assert_eq!(visible_aim_point(EYE, LO, HI, |_| false), centre);
}

    // A bottom slab hides everything under y 70.9: the aim goes above it, through the gap over the slab.
a_mob_behind_a_bottom_slab_is_aimed_at_above_the_slab :: proc() {
}
    // rust: let centre = [
    // rust: (LO[0] + HI[0]) / 2.0,
    // rust: (LO[1] + HI[1]) / 2.0,
    // rust: (LO[2] + HI[2]) / 2.0,
    // rust: ];
    // rust: let p = visible_aim_point(EYE, LO, HI, |pt| pt[1] < 70.9);
    // rust: assert!(p[1] >= 70.9, "{p:?} is still under the slab");
    // rust: assert!(p[1] > centre[1] - 0.5, "{p:?} is far from the centre");
}

    // With only the centre hidden, two equally near candidates go to the one nearer the eyes.
an_equally_near_point_on_the_side_of_the_eyes_wins :: proc() {
}
    // rust: let eye = [5.0, 70.5, 0.0];
    // rust: let (lo, hi) = ([-0.3, 70.0, -0.3], [0.3, 71.9, 0.3]);
    // rust: let centre = [
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: ];
    // rust: let p = visible_aim_point(eye, lo, hi, |pt| pt == centre);
    // rust: assert!(p[0] > centre[0], "{p:?} is on the far side from the eyes");
}

a_mob_seen_only_through_a_gap_is_aimed_at_through_the_gap :: proc() {
}
    // rust: let centre = [
    // rust: (LO[0] + HI[0]) / 2.0,
    // rust: (LO[1] + HI[1]) / 2.0,
    // rust: (LO[2] + HI[2]) / 2.0,
    // rust: ];
    // rust: assert!(behind_top_slab(centre), "the slab hides the centre");
    // rust: let p = visible_aim_point(EYE, LO, HI, behind_top_slab);
    // rust: assert!(!behind_top_slab(p), "{p:?} is still hidden");
    // rust: for k in 0..3 {
    // rust: assert!(LO[k] <= p[k] && p[k] <= HI[k], "{p:?} is outside the mob");
}
    // rust: assert!(p[1] < centre[1], "{p:?} is not lower than the centre");
}

a_fully_hidden_mob_keeps_the_centre :: proc() {
}
    // rust: let centre = [
    // rust: (LO[0] + HI[0]) / 2.0,
    // rust: (LO[1] + HI[1]) / 2.0,
    // rust: (LO[2] + HI[2]) / 2.0,
    // rust: ];
    // rust: assert_eq!(visible_aim_point(EYE, LO, HI, |_| true), centre);
}

the_choice_is_deterministic :: proc() {
}
    // rust: assert_eq!(
    // rust: visible_aim_point(EYE, LO, HI, behind_top_slab),
    // rust: visible_aim_point(EYE, LO, HI, behind_top_slab)
    // rust: );
}
}

// The first target `(id, removed, bounds)` whose box meets the swept box,
// skipping removed ones and the vehicle the player rides.
    // rust: fn first_spin_target(
    // rust: swept: Aabb,
    // rust: riding: Option<u32>,
    // rust: mut targets: impl Iterator<Item = (u32, bool, Aabb)>,
    // rust: ) -> Option<usize> {
    // rust: targets.position(|(id, removed, b)| !removed && Some(id) != riding && b.intersects(swept))
}

    // rust: mod spin_target_tests {
//     use super::first_spin_target;
//     use horizon_core::geometry::{Aabb, Vec3};

cube :: proc(x: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Aabb::new(Vec3::new(x, 0.0, 0.0), Vec3::new(x + 1.0, 1.0, 1.0))
}

    // The spin hits the first mob in the swept box, not a removed one, the
    // vehicle, or one out of reach.
the_spin_picks_the_first_live_mob_in_the_sweep :: proc() {
}
    // rust: let swept = Aabb::new(Vec3::new(0.0, 0.0, 0.0), Vec3::new(3.0, 1.0, 1.0));
    // rust: let targets = [
    // rust: (1, false, cube(10.0)),
    // rust: (2, true, cube(1.0)),
    // rust: (3, false, cube(1.5)),
    // rust: (4, false, cube(2.0)),
    // rust: ];
    // rust: assert_eq!(
    // rust: first_spin_target(swept, None, targets.iter().copied()),
    // rust: Some(2)
    // rust: );
    // rust: assert_eq!(
    // rust: first_spin_target(swept, Some(3), targets.iter().copied()),
    // rust: Some(3)
    // rust: );
    // rust: assert_eq!(
    // rust: first_spin_target(swept, None, targets[..2].iter().copied()),
    // rust: None
    // rust: );
}
}
