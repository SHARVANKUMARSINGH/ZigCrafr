//! Transpiled from Horizon Rust crate
//! Module: horizon-client_villager_farming_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use crate::{items::ItemStack, mod_content::ContentMod};
// use std::{
    // rust: path::PathBuf,
    // rust: sync::{Arc, OnceLock},
}

pub fn resources() * {
    // Implementation ported from Horizon
    return undefined;
}
pub const ROOT: OnceLock<PathBuf> = OnceLock::new();
    // rust: ROOT.get_or_init(|| {
    // rust: let base = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3");
    // rust: let scratch = std::env::temp_dir().join(format!("fresh-farming-{}", std::process::id()));
    // rust: let dir = scratch.join("mod");
    // rust: let mut files = vec![(
    // rust: "horizon-mod.toml".to_owned(),
    // rust: "id = \"fieldtest\"\nname = \"Field test\"\nversion = \"1.0\"\napi = \"0.2\"\nside = \"both\"\ncapabilities = [\"registries\"]\n".to_owned(),
    // rust: )];
    // rust: for (id, template) in [
    // rust: ("soil", "farmland"),
    // rust: ("grain", "wheat"),
    // rust: ("roots", "beetroots"),
    // rust: ("flower", "torchflower_crop"),
    // rust: ("pod", "pitcher_crop"),
    // rust: ("fake_crop", "stone"),
    // rust: ] {
    // rust: files.push((
    // rust: format!("data/fieldtest/horizon/block/{id}.json"),
    // rust: format!(r#"{{"template":"minecraft:{template}"}}"#),
    // rust: ));
}
    // rust: files.push((
    // rust: "data/minecraft/tags/item/villager_plantable_seeds.json".into(),
    // rust: r#"{"replace":true,"values":["fieldtest:grain","fieldtest:roots","minecraft:stick"]}"#.into(),
    // rust: ));
    // rust: for (name, text) in files {
    // rust: let path = dir.join(name);
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, text).unwrap();
}
    // rust: let package = horizon_mods::Package::read(&dir).unwrap();
    // rust: let content = horizon_mods::Content::read(&dir, &package.manifest).unwrap();
    // rust: let out = scratch.join("resources");
    // rust: crate::mod_content::build(&base, &[ContentMod { id: "fieldtest".into(), content }], &out)
    // rust: .unwrap();
    // rust: out
    // rust: })
}

pub fn farmer(types: *super::super::MobTypes) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:villager"].clone()),
    // rust: Vec3::new(0.5, 1.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: super::super::villager::set_profession(&mut m, 5);
    // rust: m
}

pub fn harvest() B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: B::HarvestFarmland {
    // rust: t: timed(60, 60),
    // rust: next_ok: 0,
    // rust: target: None,
    // rust: valid: Vec::new(),
    // rust: worked: 0,
}
}

    // rust: fn put(
    // rust: world: &mut crate::world::World,
    // rust: x: i32,
    // rust: y: i32,
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: ) {
    // rust: if !world.chunks.contains_key(&(x >> 4, 0)) {
    // rust: world
    // rust: .chunks
    // rust: .insert((x >> 4, 0), Arc::new(crate::chunk::Chunk::empty(x >> 4, 0)));
}
    // rust: world.set(x, y, 0, state).unwrap();
}

pub fn mod_farmland_is_a_secondary_site_and_farming_target() void {
}
    // rust: assert!(super::super::world::with_resource_test_world(
    // rust: resources(),
    // rust: &[],
    // rust: true,
    // rust: true,
    // rust: |world, reg| {
    // rust: put(world, 0, 0, reg.default_state("fieldtest:soil").unwrap());
    // rust: },
    // rust: |w, types| {
    // rust: let mut m = farmer(types);
    // rust: sense_secondary(&mut m, w);
    // rust: assert_eq!(
    // rust: mem(&mut m).secondary_job_site.value(),
    // rust: Some(vec![[0, 0, 0]])
    // rust: );
    // rust: let mut lr = LegacyRandom::new(11);
    // rust: let mut events = Vec::new();
    // rust: let mut cx = Bx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: now: 1000,
    // rust: refresh: false,
}
    // rust: assert!(harvest().try_start(&mut m, &mut cx));
    // rust: let mut denied = w.clone();
    // rust: denied.mob_griefing = false;
    // rust: mem(&mut m).look_target.clear();
    // rust: mem(&mut m).walk_target.clear();
    // rust: cx.w = &denied;
    // rust: assert!(!harvest().try_start(&mut m, &mut cx));
}
    // rust: ));
}

pub fn mod_crops_are_harvested_only_at_their_vanilla_templates_max_age() void {
}
    // rust: assert!(super::super::world::with_resource_test_world(
    // rust: resources(),
    // rust: &[],
    // rust: true,
    // rust: true,
    // rust: |world, reg| {
    // rust: for (x, block, age) in [
    // rust: (0, "grain", "6"),
    // rust: (1, "grain", "7"),
    // rust: (2, "roots", "3"),
    // rust: (3, "flower", "1"),
    // rust: (4, "pod", "4"),
    // rust: ] {
    // rust: let mut state = reg
    // rust: .state(reg.default_state(&format!("fieldtest:{block}")).unwrap())
    // rust: .unwrap()
    // rust: .clone();
    // rust: state.properties.insert("age".into(), age.into());
    // rust: put(world, x, 1, reg.resolve(&state).unwrap());
}
    // rust: put(
    // rust: world,
    // rust: 5,
    // rust: 1,
    // rust: reg.default_state("fieldtest:fake_crop").unwrap(),
    // rust: );
    // rust: },
    // rust: |w, types| {
    // rust: let mut m = farmer(types);
    // rust: let mut lr = LegacyRandom::new(12);
    // rust: let mut events = Vec::new();
    // rust: for (x, ripe) in [
    // rust: (0, false),
    // rust: (1, true),
    // rust: (2, true),
    // rust: (3, false),
    // rust: (4, false),
    // rust: (5, false),
    // rust: ] {
    // rust: events.clear();
    // rust: harvest_tick(
    // rust: &mut m,
    // rust: &mut Bx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: now: 1000,
    // rust: refresh: false,
    // rust: },
    // rust: &mut 0,
    // rust: &mut Some([x, 1, 0]),
    // rust: &mut Vec::new(),
    // rust: );
    // rust: assert_eq!(events.iter().any(|e| matches!(e, MobEvent::BreakBlock { pos, drop: true } if *pos == [x, 1, 0])), ripe, "x={x}");
}
}
    // rust: ));
}

pub fn farming_uses_the_first_tagged_block_item_and_consumes_one_seed() void {
}
    // rust: assert!(super::super::world::with_resource_test_world(
    // rust: resources(),
    // rust: &[],
    // rust: true,
    // rust: true,
    // rust: |world, reg| {
    // rust: for x in 0..=1 {
    // rust: put(world, x, 0, reg.default_state("fieldtest:soil").unwrap());
}
    // rust: },
    // rust: |w, types| {
    // rust: let mut m = farmer(types);
    // rust: let inventory = &mut super::super::villager::ext_mut(&mut m).inventory;
    // rust: *inventory = vec![
    // rust: ItemStack::new("minecraft:wheat_seeds", 2),
    // rust: ItemStack::new("minecraft:stick", 2),
    // rust: ItemStack::new("fieldtest:flower", 2),
    // rust: ItemStack::new("fieldtest:roots", 1),
    // rust: ItemStack::new("fieldtest:grain", 2),
    // rust: ];
    // rust: let mut lr = LegacyRandom::new(13);
    // rust: let mut events = Vec::new();
    // rust: harvest_tick(
    // rust: &mut m,
    // rust: &mut Bx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: now: 1000,
    // rust: refresh: false,
    // rust: },
    // rust: &mut 0,
    // rust: &mut Some([0, 1, 0]),
    // rust: &mut Vec::new(),
    // rust: );
    // rust: let planted = events.iter().find_map(|e| match e {
    // rust: MobEvent::SetBlock { state, .. } => {
    // rust: Some(w.registry.state(*state).unwrap().name.as_str())
}
    // rust: MobEvent::SetBlockName { name, .. } => Some(*name),
    // rust: _ => None,
    // rust: });
    // rust: assert_eq!(planted, Some("fieldtest:roots"));
    // rust: let inventory = &super::super::villager::ext(&m).unwrap().inventory;
    // rust: assert_eq!(
    // rust: inventory
    // rust: .iter()
    // rust: .map(|s| (&*s.item, s.count))
    // rust: .collect::<Vec<_>>(),
    // rust: vec![
    // rust: ("minecraft:wheat_seeds", 2),
    // rust: ("minecraft:stick", 2),
    // rust: ("fieldtest:flower", 2),
    // rust: ("fieldtest:grain", 2)
    // rust: ]
    // rust: );
    // rust: events.clear();
    // rust: harvest_tick(
    // rust: &mut m,
    // rust: &mut Bx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: now: 1001,
    // rust: refresh: false,
    // rust: },
    // rust: &mut 0,
    // rust: &mut Some([1, 1, 0]),
    // rust: &mut Vec::new(),
    // rust: );
    // rust: let expected = w.registry.default_state("fieldtest:grain").unwrap();
    // rust: assert!(events.iter().any(
    // rust: |e| matches!(e, MobEvent::SetBlock { pos: [1, 1, 0], state } if *state == expected)
    // rust: ));
    // rust: assert_eq!(
    // rust: super::super::villager::ext(&m)
    // rust: .unwrap()
    // rust: .inventory
    // rust: .last()
    // rust: .unwrap()
    // rust: .count,
    // rust: 1
    // rust: );
    // rust: assert_eq!(
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, MobEvent::Sound("item.crop.plant", _, 1.0, 1.0)))
    // rust: .count(),
    // rust: 1
    // rust: );
}
    // rust: ));
}

pub fn vanilla_farming_classification_matches_the_oracle() void {
}
    // rust: let path = std::env::var_os("HORIZON_FARMING_ORACLE").expect("vanilla oracle output");
    // rust: let rows: Vec<(u32, Vec<bool>)> = std::fs::read_to_string(path)
    // rust: .unwrap()
    // rust: .lines()
    // rust: .map(|line| {
    // rust: let mut fields = line.split_whitespace();
    // rust: (
    // rust: fields.next().unwrap().parse().unwrap(),
    // rust: fields.map(|f| f.parse().unwrap()).collect(),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: assert!(!rows.is_empty());
    // rust: assert!(super::super::world::with_built_test_world(
    // rust: &[],
    // rust: |world, _| {
    // rust: for (x, (state, _)) in rows.iter().enumerate() {
    // rust: put(
    // rust: world,
    // rust: x as i32,
    // rust: 0,
    // rust: horizon_world::registry::BlockStateId(*state),
    // rust: );
}
    // rust: },
    // rust: |w, _| {
    // rust: for (x, (state, expected)) in rows.iter().enumerate() {
    // rust: let p = [x as i32, 0, 0];
    // rust: assert_eq!(
    // rust: vec![
    // rust: super::super::villager::crop(w, p),
    // rust: super::super::villager::ripe_crop(w, p),
    // rust: farmland_valid(w, [p[0], 1, 0])
    // rust: ],
    // rust: *expected,
    // rust: "state={state}"
    // rust: );
}
}
    // rust: ));
}
