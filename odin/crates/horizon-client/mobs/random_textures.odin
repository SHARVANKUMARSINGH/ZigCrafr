//! Transpiled from Horizon Rust crate
package horizon_client_random_textures

import "core:fmt"
import "core:mem"
import "core:math"

// OptiFine random entity textures on mobs: which variant of each of its textures a mob wears
// (`horizon_optifine::random_textures` finds them in the packs).
//
// [`choose`] runs when the client first sees a mob, about once a second after that, and on the
// next tick when the mob draws a texture with rules it hasn't chosen for (a wolf just tamed;
// at most once between those checks), never per frame. The spawn-time facts (biome, height, blocks, moon, time, weather) are fixed
// when the mob is first seen; the others (name, profession, colour, baby, health, size) are
// read fresh each time. Drawing only looks the choice up ([`texture`]). It walks the textures
// drawing does ([`super::render::drawn_textures`]): a custom model's own texture and the
// warden's glowing layers included.
//
// Each texture with its own rules (or those of the name it extends) wears that rule file's
// pick. A texture without rules follows the body's variant, so a sheep wearing `sheep3` has
// `sheep_wool3` (ETF), or an even choice when the body has no variants; villagers' layers each
// choose their own, as ETF does.

// use super::render::{DYE_NAMES, PROFESSIONS};
// use super::{Mob, MobData, Species};
// use horizon_optifine::random::{self, Block, Facts, Weather};
// use horizon_optifine::random_textures::RandomTextures;
// use std::sync::atomic::{AtomicBool, Ordering};

// Where the mob was when the client first saw it.
Seen :: struct {
    // `minecraft:plains`; `None` in an unloaded chunk.
    biome: Maybe(string),
    y: i32,
    // The block it stood on and the block it stood in: ids and state properties.
    blocks: Vec<(string,
    moon_phase: i32,
    day_time: i32,
    weather: Weather,
}

// A mob's variants.
Choice :: struct {
    seen: Maybe(Seen),
    seed: i32,
    // The [`RandomTextures::generation`] the picks are from: another (a pack reload) makes
    // them stale.
    generation: u64,
    // The variant each rule file chose, by its index in [`RandomTextures::rules`].
    picks: Vec<(uint,
    // The body texture's variant.
    primary: Maybe(u32),
    // Ticks until the next check of the facts that change.
    countdown: u8,
    // Drawing found a texture with rules and no pick: choose on the next tick, unless a miss
    // was answered since the last regular check.
    missed: AtomicBool,
    // A miss was answered since the last regular check: one per check, so a texture that
    // drawing keeps missing (one `drawn_textures` doesn't list) can't make the mob choose
    // every tick.
    answered: bool,
}

    // rust: impl Clone for Choice {
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: seen: self.seen.clone(),
    // rust: seed: self.seed,
    // rust: generation: self.generation,
    // rust: picks: self.picks.clone(),
    // rust: primary: self.primary,
    // rust: countdown: self.countdown,
    // rust: missed: AtomicBool::new(self.missed.load(Ordering::Relaxed)),
    // rust: answered: self.answered,
}
}
}

// Ticks between checks of the facts that change.
RECHECK :: 20

    // rust: impl Choice {
    // Whether the mob's first sighting is recorded.
has_seen :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.seen.is_some()
}

    // Called once a tick: whether [`choose`] should run now. It does on first sight, after the
    // packs changed, every [`RECHECK`] ticks (the first spread by `stagger`, the entity id, so
    // a crowd seen at once doesn't check at once), and when drawing missed a pick, once
    // between those checks.
due :: proc(self: ^Self, textures: ^RandomTextures, stagger: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let fresh = !self.has_seen() || self.generation != textures.generation();
    // rust: if fresh || self.countdown == 0 {
    // rust: self.countdown = if fresh {
    // rust: (stagger % u32::from(RECHECK)) as u8
    // rust: } else {
    // rust: RECHECK - 1
}
    // rust: self.answered = false;
    // rust: self.missed.store(false, Ordering::Relaxed);
    // rust: return true;
}
    // rust: self.countdown -= 1;
    // rust: if self.missed.swap(false, Ordering::Relaxed) && !self.answered {
    // rust: self.answered = true;
    // rust: return true;
}
    // rust: false
}
}

// An entity's seed from the UUID ints the client keeps (`UUIDUtil.uuidToIntArray`, most
// significant first); its entity id when the UUID is unknown.
seed :: proc(m: ^Mob, uuid: Maybe([i32; 4])) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let long = |hi: i32, lo: i32| (i64::from(hi) << 32) | i64::from(lo as u32);
    // rust: uuid.map_or(m.id as i32, |u| {
    // rust: random::seed(long(u[0], u[1]), long(u[2], u[3]))
    // rust: })
}

// Chooses the variant of each texture `m` draws now (its custom models' from `data`).
// `seen` describes its surroundings the first time (when [`Choice::has_seen`] is false);
// later calls keep that.
    // rust: pub fn choose(
    // rust: m: &mut Mob,
    // rust: textures: &RandomTextures,
    // rust: data: &MobData,
    // rust: seen: Option<Seen>,
    // rust: seed: i32,
    // rust: ) {
    // rust: let names = super::render::drawn_textures(m, data);
    // rust: let mut choice = std::mem::take(&mut m.random_textures);
    // rust: if choice.seen.is_none() {
    // rust: choice.seen = seen;
}
    // rust: let Some(seen) = choice.seen.take() else {
    // rust: m.random_textures = choice;
    // rust: return;
}
    // rust: choice.seed = seed;
    // rust: choice.generation = textures.generation();
    // rust: choice.picks.clear();
    // rust: choice.primary = None;
    // rust: let states: Vec<Vec<(&str, &str)>> = seen
    // rust: .blocks
    // rust: .iter()
    // rust: .map(|(_, s)| s.iter().map(|(k, v)| (k.as_str(), v.as_str())).collect())
    // rust: .collect();
    // rust: let blocks: Vec<Block> = seen
    // rust: .blocks
    // rust: .iter()
    // rust: .zip(&states)
    // rust: .map(|((id, _), states)| Block { id, states })
    // rust: .collect();
    // rust: let profession =
    // rust: matches!(m.species(), Species::Villager | Species::ZombieVillager).then(|| {
    // rust: let name = PROFESSIONS[m.extra.variant2 as usize % PROFESSIONS.len()];
    // rust: (format!("minecraft:{name}"), i32::from(m.extra.variant3))
    // rust: });
    // rust: let facts = Facts {
    // rust: biome: seen.biome.as_deref(),
    // rust: y: Some(seen.y),
    // rust: blocks: &blocks,
    // rust: name: m.custom_name.as_deref(),
    // rust: profession: profession.as_ref().map(|(p, level)| (p.as_str(), *level)),
    // rust: color: color(m),
    // rust: baby: Some(m.is_baby()),
    // rust: health: Some((m.health, super::finalize::max_health(m))),
    // rust: moon_phase: Some(seen.moon_phase),
    // rust: day_time: Some(seen.day_time),
    // rust: weather: Some(seen.weather),
    // rust: size: size(m),
}
    // rust: for (i, name) in names.iter().enumerate() {
    // rust: let Some(entry) = textures.get(name) else {
    // rust: continue;
}
    // rust: let index = match entry.rules {
    // rust: Some(id) => match choice.picks.iter().find(|p| p.0 == id) {
    // rust: Some(&(_, index)) => index,
    // rust: None => {
                    // No rule matching is the texture itself, as is ETF's 0.
    // rust: let index = textures.rules(id).matching(&facts, seed).unwrap_or(0);
    // rust: choice.picks.push((id, index));
    // rust: index
}
    // rust: },
    // rust: None => entry.even(seed),
}
    // rust: if i == 0 {
    // rust: choice.primary = Some(index);
}
}
    // rust: choice.seen = Some(seen);
    // rust: m.random_textures = choice;
}

// The atlas name of the variant `m` wears for `texture`, or `None` for the texture itself.
    // rust: pub fn texture<'a>(m: &Mob, textures: &'a RandomTextures, texture: &str) -> Option<&'a str> {
    // rust: let entry = textures.get(texture)?;
    // rust: let choice = &m.random_textures;
    // rust: if !choice.has_seen() || choice.generation != textures.generation() {
    // rust: return None;
}
    // rust: let index = match entry.rules {
    // rust: Some(id) => match choice.picks.iter().find(|p| p.0 == id) {
    // rust: Some(&(_, index)) => index,
    // rust: None => {
    // rust: choice.missed.store(true, Ordering::Relaxed);
    // rust: return None;
}
    // rust: },
    // rust: None => match choice.primary {
    // rust: Some(primary)
    // rust: if !matches!(m.species(), Species::Villager | Species::ZombieVillager) =>
    // rust: {
    // rust: primary
}
    // rust: _ => entry.even(choice.seed),
    // rust: },
}
    // rust: entry.texture(index)
}

// `colors`: a sheep's wool, a wolf's or cat's collar, a llama's carpet, a shulker's shell.
color :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match m.species() {
    // rust: Species::Sheep | Species::Wolf | Species::Cat => {
    // rust: Some(DYE_NAMES[usize::from(m.extra.color & 15)])
}
    // rust: Species::Shulker => DYE_NAMES.get(usize::from(m.extra.color)).copied(),
    // rust: Species::Llama | Species::TraderLlama => super::llama::carpet(m),
    // rust: _ => None,
}
}

// `sizes`, as the docs number them: a slime's or magma cube's size less one (0 small, 1 medium,
// 3 big), a phantom's size.
size :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match m.species() {
    // rust: Species::Slime | Species::MagmaCube => Some((m.extra.size - 1).max(0)),
    // rust: Species::Phantom => Some(m.extra.size),
    // rust: _ => None,
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

mob :: proc(species: Species) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: Arc::make_mut(&mut kind).species = species;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // No custom models.
data :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: MobData {
    // rust: states: Vec::new(),
    // rust: placements: Default::default(),
    // rust: heightmaps: Default::default(),
    // rust: animations: Default::default(),
    // rust: villager_hats: Default::default(),
    // rust: cem: Default::default(),
    // rust: random_textures: Default::default(),
    // rust: emissive: Default::default(),
    // rust: blinks: Default::default(),
    // rust: biome_tags: Default::default(),
    // rust: entity_tags: Default::default(),
    // rust: pois: Default::default(),
    // rust: species_placements: Default::default(),
}
}

seen :: proc(biome: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Seen {
    // rust: biome: Some(biome.into()),
    // rust: y: 64,
    // rust: blocks: vec![(
    // rust: "minecraft:grass_block".into(),
    // rust: vec![("snowy".into(), "false".into())],
    // rust: )],
    // rust: moon_phase: 0,
    // rust: day_time: 1000,
    // rust: weather: Weather::Clear,
}
}

    // A temp pack of `files` (path under `optifine/random/entity`, or from the root when it
    // starts with `assets/`; contents), scanned.
pack :: proc(name: string, files: ^[(string) {
}
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-mob-random-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: for (path, text) in files {
    // rust: let path = if path.starts_with("assets/") {
    // rust: root.join(path)
    // rust: } else {
    // rust: root.join("assets/minecraft/optifine/random/entity")
    // rust: .join(path)
}
    // rust: std::fs::create_dir_all(path.parent().unwrap()).unwrap();
    // rust: std::fs::write(path, text).unwrap();
}
    // rust: let textures = RandomTextures::scan(&root);
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: textures
}

SHEEP :: "entity/sheep/sheep"
WOOL :: "entity/sheep/sheep_wool"
variant :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("minecraft:optifine/random/{name}")
}

a_rule_picks_the_body_and_its_layers_and_follows_the_colour :: proc() {
}
    // rust: let t = pack(
    // rust: "colour",
    // rust: &[
    // rust: (
    // rust: "sheep/sheep.properties",
    // rust: "textures.1=3\ncolors.1=red\ntextures.2=2",
    // rust: ),
    // rust: ("sheep/sheep2.png", ""),
    // rust: ("sheep/sheep3.png", ""),
    // rust: ("sheep/sheep_wool2.png", ""),
    // rust: ("sheep/sheep_wool3.png", ""),
    // rust: ],
    // rust: );
    // rust: let data = data();
    // rust: let mut m = mob(Species::Sheep);
    // rust: assert_eq!(texture(&m, &t, SHEEP), None, "not chosen yet");
        // Entity 1: chosen at first sight, then 1 tick later (the stagger), then every 20.
    // rust: assert!(m.random_textures.due(&t, m.id));
    // rust: m.extra.color = 14; // red
    // rust: choose(&mut m, &t, &data, Some(seen("minecraft:plains")), 0);
    // rust: let sheep3 = variant("entity/sheep/sheep3");
    // rust: assert_eq!(texture(&m, &t, SHEEP), Some(sheep3.as_str()));
    // rust: let wool3 = variant("entity/sheep/sheep_wool3");
    // rust: assert_eq!(texture(&m, &t, WOOL), Some(wool3.as_str()));
    // rust: let ticks: Vec<bool> = (0..23).map(|_| m.random_textures.due(&t, 1)).collect();
    // rust: let due: Vec<usize> = (0..23).filter(|&i| ticks[i]).collect();
    // rust: assert_eq!(due, [1, 21]);
    // rust: m.extra.color = 0;
    // rust: choose(&mut m, &t, &data, None, 0);
    // rust: let sheep2 = variant("entity/sheep/sheep2");
    // rust: assert_eq!(texture(&m, &t, SHEEP), Some(sheep2.as_str()));
        // Another scan (a pack reload): nothing until chosen again, at once, from the same
        // first sighting.
    // rust: let reloaded = pack(
    // rust: "colour-again",
    // rust: &[
    // rust: ("sheep/sheep.properties", "textures.1=2"),
    // rust: ("sheep/sheep2.png", ""),
    // rust: ],
    // rust: );
    // rust: assert_eq!(texture(&m, &reloaded, SHEEP), None);
    // rust: assert!(m.random_textures.due(&reloaded, m.id));
    // rust: choose(&mut m, &reloaded, &data, None, 0);
    // rust: assert_eq!(texture(&m, &reloaded, SHEEP), Some(sheep2.as_str()));
}

no_rule_matching_is_the_texture_itself :: proc() {
}
        // ETF: `sheep1.png` replaces variant 1, but a mob no rule matches (or a rule's 0)
        // wears vanilla's texture, and so does the wool that follows it.
    // rust: let t = pack(
    // rust: "zero",
    // rust: &[
    // rust: (
    // rust: "sheep/sheep.properties",
    // rust: "textures.1=2\nbiomes.1=desert\ntextures.2=0\nbiomes.2=forest",
    // rust: ),
    // rust: ("sheep/sheep1.png", ""),
    // rust: ("sheep/sheep2.png", ""),
    // rust: ("sheep/sheep_wool1.png", ""),
    // rust: ],
    // rust: );
    // rust: let data = data();
    // rust: for biome in ["minecraft:plains", "minecraft:forest"] {
    // rust: let mut m = mob(Species::Sheep);
    // rust: choose(&mut m, &t, &data, Some(seen(biome)), 0);
    // rust: assert_eq!(texture(&m, &t, SHEEP), None, "{biome}");
    // rust: assert_eq!(texture(&m, &t, WOOL), None, "{biome}");
}
}

the_first_sighting_is_kept :: proc() {
}
    // rust: let t = pack(
    // rust: "biome",
    // rust: &[
    // rust: ("sheep/sheep.properties", "textures.1=2\nbiomes.1=desert"),
    // rust: ("sheep/sheep2.png", ""),
    // rust: ],
    // rust: );
    // rust: let data = data();
    // rust: let mut m = mob(Species::Sheep);
    // rust: choose(&mut m, &t, &data, Some(seen("minecraft:desert")), 0);
    // rust: let sheep2 = variant("entity/sheep/sheep2");
    // rust: assert_eq!(texture(&m, &t, SHEEP), Some(sheep2.as_str()));
        // Walking into plains doesn't change it: biomes are read when first seen.
    // rust: choose(&mut m, &t, &data, Some(seen("minecraft:plains")), 0);
    // rust: assert_eq!(texture(&m, &t, SHEEP), Some(sheep2.as_str()));
        // Without a first sighting nothing is chosen.
    // rust: let mut unseen = mob(Species::Sheep);
    // rust: choose(&mut unseen, &t, &data, None, 0);
    // rust: assert_eq!(texture(&unseen, &t, SHEEP), None);
}

layers_without_rules_follow_the_body :: proc() {
}
        // No rules: an even choice of sheep 1-3 by seed, and the wool wears the same number.
    // rust: let t = pack(
    // rust: "even",
    // rust: &[
    // rust: ("sheep/sheep2.png", ""),
    // rust: ("sheep/sheep3.png", ""),
    // rust: ("sheep/sheep_wool2.png", ""),
    // rust: ],
    // rust: );
    // rust: let data = data();
    // rust: let mut m = mob(Species::Sheep);
    // rust: choose(&mut m, &t, &data, Some(seen("minecraft:plains")), 4);
        // 4 % 3 + 1 = 2.
    // rust: let wool2 = variant("entity/sheep/sheep_wool2");
    // rust: assert_eq!(texture(&m, &t, WOOL), Some(wool2.as_str()));
    // rust: choose(&mut m, &t, &data, None, 5);
        // 5 % 3 + 1 = 3: there is no sheep_wool3, so the wool is vanilla's.
    // rust: let sheep3 = variant("entity/sheep/sheep3");
    // rust: assert_eq!(texture(&m, &t, SHEEP), Some(sheep3.as_str()));
    // rust: assert_eq!(texture(&m, &t, WOOL), None);
}

a_layer_with_its_own_rules_and_a_warden_glow :: proc() {
}
        // The warden's pulsating spots, OptiFine's own example: a layer `render_visible` adds
        // with rules of its own (and a name ending in a digit).
    // rust: let t = pack(
    // rust: "warden",
    // rust: &[
    // rust: ("warden/warden_pulsating_spots_2.properties", "textures.1=2"),
    // rust: ("warden/warden_pulsating_spots_2.2.png", ""),
    // rust: ],
    // rust: );
    // rust: let mut m = mob(Species::Warden);
    // rust: choose(&mut m, &t, &data(), Some(seen("minecraft:deep_dark")), 0);
    // rust: let spots = variant("entity/warden/warden_pulsating_spots_2.2");
    // rust: assert_eq!(
    // rust: texture(&m, &t, "entity/warden/warden_pulsating_spots_2"),
    // rust: Some(spots.as_str())
    // rust: );
}

a_texture_drawn_without_a_pick_is_chosen_next_tick :: proc() {
}
    // rust: let t = pack(
    // rust: "missed",
    // rust: &[
    // rust: ("sheep/sheep.properties", "textures.1=2"),
    // rust: ("sheep/sheep2.png", ""),
    // rust: ("cow/cow.properties", "textures.1=2"),
    // rust: ("cow/cow2.png", ""),
    // rust: ],
    // rust: );
    // rust: let mut m = mob(Species::Sheep);
    // rust: choose(&mut m, &t, &data(), Some(seen("minecraft:plains")), 0);
    // rust: assert!(m.random_textures.due(&t, 1), "checked, then 19 quiet ticks");
    // rust: assert!(!m.random_textures.due(&t, 1));
        // The sheep never drew a cow texture: drawing one asks for a choice at once.
    // rust: assert_eq!(texture(&m, &t, "entity/cow/cow"), None);
    // rust: assert!(m.random_textures.due(&t, 1));
    // rust: assert!(!m.random_textures.due(&t, 1));
        // Still missing (never listed): no second choice until the regular check.
    // rust: assert_eq!(texture(&m, &t, "entity/cow/cow"), None);
    // rust: assert!(!m.random_textures.due(&t, 1));
        // 15 more quiet ticks, the regular check, then a miss is answered at once again.
    // rust: for _ in 0..15 {
    // rust: assert!(!m.random_textures.due(&t, 1));
}
    // rust: assert!(m.random_textures.due(&t, 1));
    // rust: assert_eq!(texture(&m, &t, "entity/cow/cow"), None);
    // rust: assert!(m.random_textures.due(&t, 1));
}

a_layer_without_rules_follows_the_bodys_pick_or_miss :: proc() {
}
        // The wool's variants are in ETF's folder, which holds no rules, so it follows the body
        // (whose rules are in OptiFine's): `sheep_wool1.png` doesn't stand in for a miss.
    // rust: let t = pack(
    // rust: "follow",
    // rust: &[
    // rust: ("sheep/sheep.properties", "textures.1=2\nbiomes.1=desert"),
    // rust: ("sheep/sheep2.png", ""),
    // rust: (
    // rust: "assets/minecraft/etf/random/entity/sheep/sheep_wool1.png",
    // rust: "",
    // rust: ),
    // rust: (
    // rust: "assets/minecraft/etf/random/entity/sheep/sheep_wool2.png",
    // rust: "",
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let mut plains = mob(Species::Sheep);
    // rust: choose(&mut plains, &t, &data(), Some(seen("minecraft:plains")), 0);
    // rust: assert_eq!(texture(&plains, &t, WOOL), None);
    // rust: let mut desert = mob(Species::Sheep);
    // rust: choose(&mut desert, &t, &data(), Some(seen("minecraft:desert")), 0);
    // rust: assert_eq!(
    // rust: texture(&desert, &t, WOOL),
    // rust: Some("minecraft:etf/random/entity/sheep/sheep_wool2")
    // rust: );
}

villager_layers_choose_for_themselves :: proc() {
}
    // rust: let t = pack(
    // rust: "villager",
    // rust: &[
    // rust: ("villager/villager2.png", ""),
    // rust: ("villager/type/plains2.png", ""),
    // rust: ("villager/type/plains3.png", ""),
    // rust: ],
    // rust: );
    // rust: let plains = "entity/villager/type/plains";
    // rust: let mut m = mob(Species::Villager);
        // Seed 2: the body 1 + 2 % 2 = 1 (itself), the plains layer its own 1 + 2 % 3 = 3.
    // rust: choose(&mut m, &t, &data(), Some(seen("minecraft:plains")), 2);
    // rust: assert_eq!(texture(&m, &t, "entity/villager/villager"), None);
    // rust: let plains3 = variant("entity/villager/type/plains3");
    // rust: assert_eq!(texture(&m, &t, plains), Some(plains3.as_str()));
        // Seed 3: the body's 2 would give plains2; the layer's own 1 + 3 % 3 = 1 is itself.
    // rust: choose(&mut m, &t, &data(), None, 3);
    // rust: let villager2 = variant("entity/villager/villager2");
    // rust: assert_eq!(
    // rust: texture(&m, &t, "entity/villager/villager"),
    // rust: Some(villager2.as_str())
    // rust: );
    // rust: assert_eq!(texture(&m, &t, plains), None);
}

the_facts_a_mob_gives :: proc() {
}
    // rust: let mut slime = mob(Species::Slime);
    // rust: slime.extra.size = 4;
    // rust: assert_eq!(size(&slime), Some(3), "big: the docs' 3");
    // rust: slime.extra.size = 1;
    // rust: assert_eq!(size(&slime), Some(0));
    // rust: let mut phantom = mob(Species::Phantom);
    // rust: phantom.extra.size = 5;
    // rust: assert_eq!(size(&phantom), Some(5));
    // rust: assert_eq!(size(&mob(Species::Sheep)), None);
    // rust: let mut shulker = mob(Species::Shulker);
    // rust: shulker.extra.color = 16;
    // rust: assert_eq!(color(&shulker), None, "16: no colour");
    // rust: shulker.extra.color = 3;
    // rust: assert_eq!(color(&shulker), Some("light_blue"));
        // A librarian of level 3 matches `professions.1=librarian:3`.
    // rust: let t = pack(
    // rust: "librarian",
    // rust: &[
    // rust: (
    // rust: "villager/villager.properties",
    // rust: "textures.1=2\nprofessions.1=librarian:3",
    // rust: ),
    // rust: ("villager/villager2.png", ""),
    // rust: ],
    // rust: );
    // rust: let mut m = mob(Species::Villager);
    // rust: m.extra.variant2 = PROFESSIONS.iter().position(|&p| p == "librarian").unwrap() as u8;
    // rust: m.extra.variant3 = 3;
    // rust: choose(&mut m, &t, &data(), Some(seen("minecraft:plains")), 0);
    // rust: let villager2 = variant("entity/villager/villager2");
    // rust: assert_eq!(
    // rust: texture(&m, &t, "entity/villager/villager"),
    // rust: Some(villager2.as_str())
    // rust: );
    // rust: m.extra.variant3 = 2;
    // rust: choose(&mut m, &t, &data(), None, 0);
    // rust: assert_eq!(texture(&m, &t, "entity/villager/villager"), None);
}

seeds_from_uuid_ints :: proc() {
}
    // rust: let m = mob(Species::Sheep);
        // new UUID(1, 2).hashCode() = 3.
    // rust: assert_eq!(seed(&m, Some([0, 1, 0, 2])), 3);
        // The low int is unsigned: UUID(0x00000000ffffffff, 0).hashCode() = 0 ^ 0xffffffff.
    // rust: assert_eq!(seed(&m, Some([0, -1, 0, 0])), -1);
    // rust: assert_eq!(seed(&m, None), 1, "the entity id");
}
}
