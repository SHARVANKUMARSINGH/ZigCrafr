//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_machines
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What a mod's machine does to the world as a player's hand would, with no
//! player: break a block with a tool and keep what drops (a drill, a saw, a
//! harvester), show its crack while it works, and use an item as a player
//! would (a deployer) (docs/native-mods.md, "Machines").
// use super::{Game, GuestUse, Hit, InteractTarget, Screen};
// use horizon_client::{
    // rust: command::args::GameMode,
    // rust: containers::BlockEntity,
    // rust: first_person::Hand,
    // rust: items::ItemStack,
    // rust: mod_api::{NativeFakeUse, NativeUseTarget},
}
// use horizon_core::{geometry::Vec3, position::BlockPos};
// use winit::keyboard::KeyCode;

/// `Player.getStandingEyeHeight`: a fake player's eyes above its feet.
pub const FAKE_EYE: f32 = 1.62;

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// Breaks the block at `pos` as a machine does, with no player: vanilla's
    /// `Level.destroyBlock(pos, true)` with the loot rolled for `tool`
    /// (`Block.dropResources(state, level, pos, blockEntity, null, tool)`):
    /// the break particles and sound, the block's drops with what its block
    /// entity copies into them (a shulker box's contents), experience for an
    /// ore unless `tool` has silk touch (`EnchantmentHelper.processBlockExperience`),
    /// then the block's fluid in its place. Blocks that pop off because of
    /// the break drop as with no tool, and pop whatever `collect` says. `tool` picks
    /// the drops as a player's held item does (silk touch, fortune, shears);
    /// `None` is an empty hand. The mods' say on drops (`native_loot_drops`)
    /// applies. With `collect`, the drops are returned and nothing is popped
    /// (a harvester storing them); without, they pop as item entities and the
    /// list is empty. Nothing drops where `doTileDrops` is off. None, with
    /// nothing broken, for air, an unloaded block and off a server.
    /// API @API:machine_breaking@.
    // rust: pub(super) fn native_machine_destroy_block(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: tool: Option<&ItemStack>,
    // rust: collect: bool,
    // rust: ) -> Option<Vec<ItemStack>> {
    // rust: if !self.native_authoritative() || !self.world.loaded(pos[0], pos[2]) {
    // rust: return None;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if self.res.behaviours().is_air(state) {
    // rust: return None;
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let tool_kept = tool.cloned();
    // rust: let mut drops = self.with_level(|b, level, ticks| {
    // rust: level.drop_tool = Some(((pos[0], pos[1], pos[2]), tool_kept));
    // rust: level.drop_into = Some(Vec::new());
    // rust: b.destroy_block(level, ticks, at, true);
    // rust: level.drop_tool = None;
    // rust: level.drop_into.take().unwrap_or_default()
    // rust: });
    // rust: let _ = self.process_level_events();
    // rust: self.native_block_drops(pos, state, None, tool, None, &mut drops);
    // rust: if collect {
    // rust: return Some(drops);
}
    // rust: for stack in drops {
    // rust: self.pop_resource(pos, stack);
}
    // rust: Some(Vec::new())
}

    /// `ServerLevel.destroyBlockProgress`: shows breaker `breaker`'s crack on
    /// the block at `pos` at stage `progress` (0 to 9) to the players within 64
    /// blocks, as a zombie breaking a door shows its; any other stage takes the
    /// crack away. A machine passes an id of its own that no entity has (a
    /// negative one), the same each time, so a new stage replaces its old one;
    /// a crack not renewed for 400 ticks fades. Off a server nothing happens.
    /// API @API:machine_breaking@.
    // rust: pub(super) fn native_set_break_progress(&mut self, breaker: i32, pos: [i32; 3], progress: i32) {
    // rust: if !self.native_authoritative() {
    // rust: return;
}
    // rust: self.server_destroy_block_progress(breaker, pos, progress);
}

    /// Uses `stack` as a player standing with its eyes at `eye`, looking
    /// `yaw` and `pitch` degrees (as `Entity.getYRot` and `getXRot`), would:
    /// NeoForge's `FakePlayer` doing what a deployer does. On a block
    /// (`NativeUseTarget::Block`) it is `ServerPlayerGameMode.useItemOn`:
    /// the block reacts first (a lever flips, a cauldron fills), else the
    /// item is used on it (a block placed, bone meal spread, a bucket
    /// filled); in the air (`Item`) `useItem` (a bucket picks up the fluid it
    /// looks at); on an entity (`Entity`) `Player.interactOn` (a sheep
    /// sheared, a cow milked). With `sneaking` it is a secondary use, as a
    /// player holding sneak's. The fake player is in survival, holds `stack`
    /// in its main hand and nothing else, and has no connection: what it
    /// opens closes again through the real close paths before this returns
    /// (a lid opens and shuts, a trader is free again), and its stats and
    /// advancements count for no one. The click still counts as used, as a
    /// player's would. The answer is what it holds and carries afterwards.
    /// None, with nothing used, off a server and while a player's action is
    /// being run (from inside a player's hook: run it from a block entity's
    /// tick).
    /// API @API:fake_player@.
    // rust: pub(super) fn native_use_as_player(
    // rust: &mut self,
    // rust: stack: ItemStack,
    // rust: eye: [f64; 3],
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: target: NativeUseTarget,
    // rust: sneaking: bool,
    // rust: ) -> Option<NativeFakeUse> {
    // rust: if !self.native_authoritative()
    // rust: || self.remote.is_some()
    // rust: || self.player.is_some()
    // rust: || self.lan_acting.is_some()
    // rust: || !eye.iter().all(|v| v.is_finite())
    // rust: || !(yaw.is_finite() && pitch.is_finite())
    // rust: {
    // rust: return None;
}
    // rust: let feet = Vec3::new(eye[0], eye[1] - f64::from(FAKE_EYE), eye[2]);
    // rust: let body = horizon_client::motion::PlayerMotion::new(self.motion, feet).ok()?;
    // rust: let slots = self.inventory.len().max(36);
    // rust: let mut inventory = vec![None; slots];
    // rust: inventory[0] = (stack.count > 0).then_some(stack);
    // rust: let keys = if sneaking {
    // rust: [KeyCode::ShiftLeft].into_iter().collect()
    // rust: } else {
    // rust: Default::default()
}
    // rust: let (forced_hit, guest_use) = match target {
    // rust: NativeUseTarget::Block { pos, face, point } => (
    // rust: Some(Hit {
    // rust: pos,
    // rust: face: face.normal(),
    // rust: point,
    // rust: }),
    // rust: GuestUse::OnBlock(Hand::Main),
    // rust: ),
    // rust: NativeUseTarget::Item => (None, GuestUse::Item(Hand::Main)),
    // rust: NativeUseTarget::Entity { id, location } => (
    // rust: None,
    // rust: GuestUse::Entity(Hand::Main, InteractTarget { id, location }),
    // rust: ),
}
        // The server's own player state, empty while nobody acts, kept to put
        // back: the fake player leaves nothing of itself behind.
    // rust: let player = self.player.replace(body);
    // rust: let eye_height = std::mem::replace(&mut self.eye, FAKE_EYE);
    // rust: let look = (
    // rust: std::mem::replace(&mut self.yaw, yaw),
    // rust: std::mem::replace(&mut self.pitch, pitch),
    // rust: );
    // rust: let inventory = std::mem::replace(&mut self.inventory, inventory);
    // rust: let selected = std::mem::replace(&mut self.selected, 0);
    // rust: let armor = std::mem::take(&mut self.armor);
    // rust: let offhand = self.offhand.take();
    // rust: let carried = self.carried.take();
    // rust: let keys = std::mem::replace(&mut self.keys, keys);
    // rust: let screen = std::mem::replace(&mut self.screen, Screen::Playing);
    // rust: let container = self.container.take();
    // rust: let sign_edit = self.sign_edit.take();
    // rust: let book = self.book.take();
    // rust: let command_block = self.command_block_screen.take();
    // rust: let mount_menu = std::mem::take(&mut self.mount_menu);
    // rust: let craft_size = std::mem::replace(&mut self.craft_size, 2);
    // rust: let craft_grid = std::mem::replace(&mut self.craft_grid, vec![None; 9]);
    // rust: let mode = std::mem::replace(&mut self.mode, GameMode::Survival);
    // rust: let creative = std::mem::replace(&mut self.creative, false);
    // rust: let mining = self.mining.take();
    // rust: let using = self.using.take();
    // rust: let use_delay = std::mem::replace(&mut self.use_delay, 0);
    // rust: let cooldowns = std::mem::take(&mut self.cooldowns);
    // rust: let riding = self.riding.take();
    // rust: let sleeping = self.sleeping.take();
    // rust: let reach = (self.block_reach, self.entity_reach);
    // rust: let hit = std::mem::replace(&mut self.forced_hit, forced_hit);
    // rust: let tick_hit = self.tick_hit.take();
    // rust: let used_as = self.guest_use.replace(guest_use);
    // rust: let failed = std::mem::replace(&mut self.use_failed, false);
    // rust: let station = self.station.take();
    // rust: let craft_table = self.craft_table.take();
    // rust: let experience = std::mem::take(&mut self.experience);
    // rust: let hook = self.hook.take();
    // rust: let respawn = (
    // rust: self.respawn_config.take(),
    // rust: self.spawn.take(),
    // rust: self.level.spawn,
    // rust: );
        // An ender inventory left open goes back while the fake player acts,
        // and its stand-in returns afterwards, as a guest's turn does.
    // rust: let ender_open = self.ender_open;
    // rust: self.close_ender_chest();
    // rust: self.block_reach = self.interaction_range("minecraft:block_interaction_range", 4.5, 5.0);
    // rust: self.entity_reach = self.interaction_range("minecraft:entity_interaction_range", 3.0, 5.0);

    // rust: let consumed = matches!(self.use_item(), Ok(Some(_))) && !self.use_failed;
        // The close side of what the use opened, with the fake inventory still
        // in place: what a menu holds comes back to the fake player.
    // rust: self.close_container();
    // rust: self.close_book();

    // rust: let mut left = std::mem::replace(&mut self.inventory, inventory);
    // rust: let held = left
    // rust: .get_mut(0)
    // rust: .and_then(Option::take)
    // rust: .filter(|s| s.count > 0);
    // rust: let other = left
    // rust: .into_iter()
    // rust: .chain([self.offhand.take(), self.carried.take()])
    // rust: .chain(std::mem::take(&mut self.armor))
    // rust: .flatten()
    // rust: .filter(|s| s.count > 0)
    // rust: .collect();
    // rust: self.player = player;
    // rust: self.eye = eye_height;
    // rust: (self.yaw, self.pitch) = look;
    // rust: self.selected = selected;
    // rust: self.armor = armor;
    // rust: self.offhand = offhand;
    // rust: self.carried = carried;
    // rust: self.keys = keys;
    // rust: self.screen = screen;
    // rust: self.container = container;
    // rust: self.sign_edit = sign_edit;
    // rust: self.book = book;
    // rust: self.command_block_screen = command_block;
    // rust: self.mount_menu = mount_menu;
    // rust: self.craft_size = craft_size;
    // rust: self.craft_grid = craft_grid;
    // rust: self.mode = mode;
    // rust: self.creative = creative;
    // rust: self.mining = mining;
    // rust: self.using = using;
    // rust: self.use_delay = use_delay;
    // rust: self.cooldowns = cooldowns;
    // rust: self.riding = riding;
    // rust: self.sleeping = sleeping;
    // rust: (self.block_reach, self.entity_reach) = reach;
    // rust: self.forced_hit = hit;
    // rust: self.tick_hit = tick_hit;
    // rust: self.guest_use = used_as;
    // rust: self.use_failed = failed;
    // rust: self.station = station;
    // rust: self.craft_table = craft_table;
    // rust: self.experience = experience;
        // A hook this use cast has not ticked and no client has seen it.
    // rust: self.hook = hook;
    // rust: (self.respawn_config, self.spawn, self.level.spawn) = respawn;
    // rust: if let Some(key) = ender_open {
    // rust: self.world
    // rust: .block_entities
    // rust: .insert(key, BlockEntity::Chest(self.ender_items.clone()));
    // rust: self.ender_open = Some(key);
}
    // rust: Some(NativeFakeUse {
    // rust: consumed,
    // rust: held,
    // rust: other,
    // rust: })
}
}

    // rust: mod tests {
//     use super::super::{
    // rust: Audio, Options, Progress, Settings,
    // rust: boats::Boat,
    // rust: load_resources,
    // rust: minecarts::{CART_KEY_Y, CartKind, Minecart},
    // rust: respawn_anchor::RespawnConfig,
    // rust: stations::{Kind, Station},
}
//     use super::*;
//     use horizon_client::chunk::Chunk;
//     use horizon_core::geometry::Direction;
//     use std::sync::Arc;

    /// A server's game on the prepared resources: nobody is playing, and the
    /// chunk at the origin is loaded.
pub fn server_game() G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .expect("set HORIZON_TEST_RESOURCES to prepared resources"),
    // rust: );
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let res: &'static _ = Box::leak(Box::new(loaded.resources));
    // rust: let mut game = Game::new(
    // rust: res,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.options.dedicated = Some(Vec::new());
    // rust: game.world
    // rust: .chunks
    // rust: .insert((0, 0), Arc::new(Chunk::empty(0, 0)));
    // rust: game
}

pub fn fake_use(game: *mut Game<'_>, target: NativeUseTarget, sneaking: bool) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: game.native_use_as_player(
    // rust: ItemStack::new("minecraft:stick", 1),
    // rust: [8.5, 66.0, 8.5],
    // rust: 0.0,
    // rust: 0.0,
    // rust: target,
    // rust: sneaking,
    // rust: )
    // rust: .expect("a server with nobody acting")
}
pub fn on_entity(id: u32) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NativeUseTarget::Entity {
    // rust: id: id as i32,
    // rust: location: [0.0; 3],
}
}
    /// Clicks the top of the block at `pos`.
pub fn click(game: *mut Game<'_>, pos: [i32; 3]) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let point = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 1.0,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: let target = NativeUseTarget::Block {
    // rust: pos,
    // rust: face: Direction::Up,
    // rust: point,
}
    // rust: fake_use(game, target, false)
}
    /// Puts `block` at `pos` and clicks it.
pub fn click_new(game: *mut Game<'_>, block: []const u8, pos: [i32; 3]) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = game
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state(block)
    // rust: .expect("a vanilla block");
    // rust: game.world.set(pos[0], pos[1], pos[2], state).unwrap();
    // rust: click(game, pos)
}

pub fn a_trader_a_fake_player_used_trades_with_the_next_one() void {
}
    // rust: let mut game = server_game();
    // rust: let id = game
    // rust: .spawn_mob("minecraft:wandering_trader", [8.5, 65.0, 8.5], true)
    // rust: .expect("a wandering trader");
    // rust: assert!(fake_use(&mut game, on_entity(id), false).consumed);
    // rust: let trader = game.mobs.iter().find(|m| m.id == id).unwrap();
        // With no offers the menu never opens, and this test would say nothing.
    // rust: let offers = trader.extra.trade.as_ref().map_or(0, |t| t.offers.len());
    // rust: assert!(offers > 0, "a wandering trader has offers");
    // rust: assert!(!trader.extra.flag2, "the trader is not left trading");
    // rust: assert!(game.station.is_none(), "the session is not left open");
    // rust: assert!(
    // rust: fake_use(&mut game, on_entity(id), false).consumed,
    // rust: "the next use opens it again",
    // rust: );
}

    /// A chest minecart, a hopper minecart and a chest boat: the items stay on
    /// the vehicle, and the menu's stand-in is out of the level, where a
    /// hopper transfer would edit it instead of the vehicle.
pub fn a_vehicles_chest_a_fake_player_used_keeps_its_items_and_no_stand_in() void {
}
    // rust: let mut game = server_game();
    // rust: let at = Vec3::new(8.5, 65.0, 8.5);
    // rust: let diamonds = Some(ItemStack::new("minecraft:diamond", 5));
    // rust: let mut vehicles = Vec::new();
    // rust: for kind in [CartKind::Chest, CartKind::Hopper] {
    // rust: game.next_entity += 1;
    // rust: let mut cart = Minecart::new(game.next_entity, kind, at);
    // rust: cart.items[3] = diamonds.clone();
    // rust: vehicles.push((game.next_entity, false));
    // rust: game.carts.push(cart);
}
    // rust: game.next_entity += 1;
    // rust: let mut boat = Boat::new(game.next_entity, "oak".into(), at, 0.0).with_chest();
    // rust: boat.items[3] = diamonds.clone();
        // ChestBoat.interact opens the chest for a sneaking player.
    // rust: vehicles.push((game.next_entity, true));
    // rust: game.boats.push(boat);

    // rust: for (id, sneaking) in vehicles {
            // Twice: the second use is the next one finding it as it was.
    // rust: for _ in 0..2 {
    // rust: assert!(fake_use(&mut game, on_entity(id), sneaking).consumed);
    // rust: let key = (i32::MAX - 15, CART_KEY_Y, id as i32);
    // rust: assert!(
    // rust: game.world.block_entities.get(&key).is_none(),
    // rust: "vehicle {id} left a stand-in",
    // rust: );
    // rust: assert!(game.container.is_none());
    // rust: let items = game
    // rust: .carts
    // rust: .iter()
    // rust: .find(|c| c.id == id)
    // rust: .map(|c| &c.items)
    // rust: .or_else(|| game.boats.iter().find(|b| b.id == id).map(|b| &b.items))
    // rust: .unwrap();
    // rust: assert_eq!(items[3], diamonds, "vehicle {id} lost its items");
}
}
}

pub fn a_shulker_box_and_an_ender_chest_a_fake_player_used_are_left_shut() void {
}
    // rust: let mut game = server_game();
    // rust: let shulker = [8, 64, 8];
    // rust: let count = |game: &Game<'_>| game.be_anims.shulkers.get(&shulker).map(|s| s.open_count);
    // rust: assert!(click_new(&mut game, "minecraft:shulker_box", shulker).consumed);
    // rust: assert_eq!(count(&game), Some(0), "the use opened it, and it shut");
    // rust: assert!(game.container.is_none());
    // rust: assert!(click(&mut game, shulker).consumed, "the next use opens it");
    // rust: assert_eq!(count(&game), Some(0), "the count doesn't climb");

    // rust: let ender = [10, 64, 8];
    // rust: let key = (ender[0], ender[1], ender[2]);
    // rust: assert!(click_new(&mut game, "minecraft:ender_chest", ender).consumed);
    // rust: assert!(game.ender_open.is_none());
    // rust: assert!(
    // rust: game.world.block_entities.get(&key).is_none(),
    // rust: "a stand-in chest stayed",
    // rust: );
    // rust: assert!(!game.lid_openers.contains_key(&key), "its lid stayed open");
}

    /// Each field holds a value the use can't have written, so a swap that
    /// forgets one fails whether the use changed it or not.
pub fn the_servers_own_player_state_comes_back_after_a_fake_use() void {
}
    // rust: let mut game = server_game();
    // rust: let config = RespawnConfig {
    // rust: dim: game.dim,
    // rust: pos: [1, 2, 3],
    // rust: yaw: 0.0,
    // rust: forced: false,
}
    // rust: let spawn = Vec3::new(1.0, 2.0, 3.0);
    // rust: game.station = Some(Station::new_kind(Kind::Anvil, [4, 5, 6]));
    // rust: game.craft_table = Some([7, 8, 9]);
    // rust: game.experience.level = 7;
    // rust: game.respawn_config = Some(config);
    // rust: game.spawn = Some(spawn);
    // rust: let stand_in = (12, 64, 8);
    // rust: game.open_ender_chest(stand_in);
    // rust: game.container = None;

    // rust: assert!(click_new(&mut game, "minecraft:crafting_table", [8, 64, 8]).consumed);
    // rust: assert_eq!(
    // rust: game.station.as_ref().map(|s| (s.kind, s.pos)),
    // rust: Some((Kind::Anvil, [4, 5, 6])),
    // rust: );
    // rust: assert_eq!(game.craft_table, Some([7, 8, 9]));
    // rust: assert_eq!(game.experience.level, 7);
    // rust: assert_eq!(game.respawn_config, Some(config));
    // rust: assert_eq!(game.spawn, Some(spawn));
    // rust: assert_eq!(game.ender_open, Some(stand_in));
    // rust: assert!(game.world.block_entities.get(&stand_in).is_some());

    // rust: let rod = game
    // rust: .native_use_as_player(
    // rust: ItemStack::new("minecraft:fishing_rod", 1),
    // rust: [8.5, 66.0, 8.5],
    // rust: 0.0,
    // rust: 0.0,
    // rust: NativeUseTarget::Item,
    // rust: false,
    // rust: )
    // rust: .expect("a server with nobody acting");
    // rust: assert!(rod.consumed, "the rod casts");
    // rust: assert!(game.hook.is_none(), "no hook is left for nobody to reel in");
}
}
