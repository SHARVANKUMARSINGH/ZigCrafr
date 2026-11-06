//! Transpiled from Horizon Rust crate
//! Module: horizon-client_enderman_placement_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Exercise the actual registered leave-block goal and Game event handler.
// use super::{Audio, Game, Options, Progress, Settings, load_resources};
// use horizon_client::{
    // rust: chunk::Chunk,
    // rust: mobs::{Mob, MobEvent, goals::Cx},
}
// use horizon_core::{geometry::Vec3, position::ChunkPos, random::LegacyRandom};
// use std::sync::Arc;

pub fn leave_block_goal_uses_real_neighbor_shapes_and_keeps_air_placement() void {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
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
    // rust: options.execution_role = super::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.world
    // rust: .chunks
    // rust: .insert((0, 0), Arc::new(Chunk::empty(0, 0)));
    // rust: game.block_ticks
    // rust: .add_empty_chunk(ChunkPos::new(0, 0))
    // rust: .unwrap();
    // rust: let registry = game.pack.assets.registry;
    // rust: let air = registry.default_state("minecraft:air").unwrap();
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let kind = game
    // rust: .res
    // rust: .mob_types()
    // rust: .get("minecraft:enderman")
    // rust: .unwrap()
    // rust: .clone();
    // rust: for (name, expected_name) in [("poppy", "air"), ("note_block", "note_block")] {
    // rust: for x in 0..8 {
    // rust: for z in 0..8 {
    // rust: for y in 3..7 {
    // rust: game.world
    // rust: .set(x, y, z, if y == 3 { stone } else { air })
    // rust: .unwrap();
}
}
}
    // rust: game.mobs.clear();
    // rust: let carried = registry
    // rust: .default_state(&format!("minecraft:{name}"))
    // rust: .unwrap();
    // rust: let mut mob = Mob::new(325, kind.clone(), Vec3::new(3.5, 4.0, 3.5), 0.0);
    // rust: mob.random = LegacyRandom::new(325);
    // rust: mob.extra.carried = Some(carried);
    // rust: game.mobs.push(mob);
    // rust: for _ in 0..48_000 {
    // rust: let mut mob = game.mobs.pop().unwrap();
    // rust: let mut goals = std::mem::take(&mut mob.ai.goals);
    // rust: let snapshot = [super::creatures::seen(&mob, None)];
    // rust: let mut events = Vec::<MobEvent>::new();
    // rust: let mut lr = game.world.random.clone();
    // rust: {
    // rust: let world = game.mob_world_base(&snapshot);
    // rust: goals.tick(
    // rust: &mut mob,
    // rust: &mut Cx {
    // rust: w: &world,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: },
    // rust: );
}
    // rust: game.world.random = lr;
    // rust: mob.ai.goals = goals;
    // rust: game.mobs.push(mob);
    // rust: game.handle_mob_events(events).unwrap();
    // rust: if game.mobs[0].extra.carried.is_none() {
    // rust: break;
}
}
    // rust: assert_eq!(
    // rust: game.mobs[0].extra.carried, None,
    // rust: "eligible {name} must empty its hand"
    // rust: );
    // rust: let mut states = Vec::new();
    // rust: for x in 0..8 {
    // rust: for z in 0..8 {
    // rust: for y in 4..7 {
    // rust: let state = game.world.block(x, y, z);
    // rust: if state != air {
    // rust: states.push(registry.state(state).unwrap());
}
}
}
}
    // rust: if expected_name == "air" {
    // rust: assert!(
    // rust: states.is_empty(),
    // rust: "poppy normalizes to AIR before placement, not a dropped unsupported flower"
    // rust: );
    // rust: } else {
    // rust: assert_eq!(states.len(), 1);
    // rust: assert_eq!(states[0].name, "minecraft:note_block");
    // rust: assert_eq!(
    // rust: states[0].properties.get("instrument").map(String::as_str),
    // rust: Some("basedrum")
    // rust: );
}
}
    // A waterlogged candidate schedules the real level's fluid tick even
    // when a preceding world write makes the placement ineligible.
    // rust: let fence = registry.default_state("minecraft:oak_fence").unwrap();
    // rust: let mut descriptor = registry.state(fence).unwrap().clone();
    // rust: descriptor
    // rust: .properties
    // rust: .insert("waterlogged".into(), "true".into());
    // rust: let fence = registry.resolve(&descriptor).unwrap();
    // rust: let mut mob = Mob::new(326, kind, Vec3::new(3.5, 4.0, 3.5), 0.0);
    // rust: mob.random = LegacyRandom::new(325);
    // rust: mob.extra.carried = Some(fence);
    // rust: game.mobs.clear();
    // rust: game.mobs.push(mob);
    // rust: let mut attempt = None;
    // rust: for _ in 0..48_000 {
    // rust: let mut mob = game.mobs.pop().unwrap();
    // rust: let mut goals = std::mem::take(&mut mob.ai.goals);
    // rust: let snapshot = [super::creatures::seen(&mob, None)];
    // rust: let mut events = Vec::new();
    // rust: let mut lr = game.world.random.clone();
    // rust: goals.tick(
    // rust: &mut mob,
    // rust: &mut Cx {
    // rust: w: &game.mob_world_base(&snapshot),
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: },
    // rust: );
    // rust: game.world.random = lr;
    // rust: mob.ai.goals = goals;
    // rust: game.mobs.push(mob);
    // rust: if let Some(event) = events
    // rust: .into_iter()
    // rust: .find(|e| matches!(e, MobEvent::EndermanPlaceBlock { .. }))
    // rust: {
    // rust: attempt = Some(event);
    // rust: break;
}
}
    // rust: let attempt = attempt.expect("the registered leave goal emits an attempt");
    // rust: let MobEvent::EndermanPlaceBlock { pos, mob, .. } = &attempt else {
    // rust: unreachable!()
}
    // rust: assert_eq!(*mob, 326);
    // rust: game.world.set(pos[0], pos[1], pos[2], stone).unwrap();
    // rust: let before = game.block_ticks.fluids.count();
    // A stale carried-state identity cannot mutate the world or clear a new hand.
    // rust: game.mobs[0].extra.carried = Some(stone);
    // rust: game.handle_mob_events(vec![attempt.clone()]).unwrap();
    // rust: assert_eq!(game.block_ticks.fluids.count(), before);
    // rust: assert_eq!(game.mobs[0].extra.carried, Some(stone));
    // rust: game.mobs[0].extra.carried = Some(fence);
    // rust: game.handle_mob_events(vec![attempt.clone()]).unwrap();
    // rust: assert!(game.block_ticks.fluids.count() > before);
    // rust: assert_eq!(game.world.block(pos[0], pos[1], pos[2]), stone);
    // rust: assert_eq!(game.mobs[0].extra.carried, Some(fence));
}
