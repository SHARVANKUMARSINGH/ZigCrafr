//! Transpiled from Horizon Rust crate
//! Module: horizon-client_loot_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;

pub fn fixture() ( {
    // Implementation ported from Horizon
    return undefined;
}
pub const NEXT: AtomicU64 = AtomicU64::new(0);
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-opened-loot-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: fs::create_dir(&root).unwrap();
    // rust: let maps = root.join("assets/minecraft/textures/colormap");
    // rust: fs::create_dir_all(&maps).unwrap();
    // Original one-pixel fixtures: chunk persistence only needs biome names.
    // rust: for name in ["grass", "foliage", "dry_foliage"] {
    // rust: let file = fs::File::create(maps.join(format!("{name}.png"))).unwrap();
    // rust: let mut encoder = png::Encoder::new(file, 1, 1);
    // rust: encoder.set_color(png::ColorType::Rgb);
    // rust: encoder
    // rust: .write_header()
    // rust: .unwrap()
    // rust: .write_image_data(&[0, 0, 0])
    // rust: .unwrap();
}
    // rust: let folder = root.join("data/minecraft/worldgen/biome");
    // rust: fs::create_dir_all(&folder).unwrap();
    // rust: fs::write(folder.join("plains.json"), "{}").unwrap();
    // rust: let biomes = Biomes::load(&root).unwrap();
    // rust: fs::remove_dir_all(&root).unwrap();
    // rust: let registry = BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![
    // rust: Tag::compound([("id", string("minecraft:air"))]),
    // rust: Tag::compound([("id", string("minecraft:chest"))]),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound([
    // rust: ("minecraft:air", Tag::Int(0)),
    // rust: ("minecraft:chest", Tag::Int(1)),
    // rust: ]),
    // rust: ),
    // rust: ]))
    // rust: .unwrap();
    // rust: (registry, biomes)
}

    // rust: fn reload_loot_case(
    // rust: registry: &BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: table: &str,
    // rust: seed: i64,
    // rust: mode: u8,
    // rust: ) -> Chunk {
    // rust: let pos = (1, 64, 2);
    // rust: let mut slots = vec![None; 27];
    // rust: slots[0] = Some(crate::items::ItemStack::new("minecraft:gold_ingot", 2));
    // rust: let source = Tag::compound([
    // rust: ("id", string("minecraft:chest")),
    // rust: ("x", Tag::Int(pos.0)),
    // rust: ("y", Tag::Int(pos.1)),
    // rust: ("z", Tag::Int(pos.2)),
    // rust: ("LootTable", string(table)),
    // rust: ("LootTableSeed", Tag::Long(seed)),
    // rust: ("CustomName", string("{\"text\":\"Keep me\"}")),
    // rust: ]);
    // rust: let mut extras = ChunkExtras {
    // rust: block_entity_sources: vec![(pos, source)],
    // rust: rolled_loot: vec![RolledLoot {
    // rust: pos,
    // rust: table: table.into(),
    // rust: seed: Some(seed),
    // rust: items: encode_items(&slots),
    // rust: }],
    // rust: ..Default::default()
}
    // Exactly the production transition used when the player opens the chest.
    // rust: if mode != 0 {
    // rust: consume_container_loot(&mut extras, pos);
    // rust: slots.fill(None);
    // rust: if mode == 2 {
    // rust: slots[0] = Some(crate::items::ItemStack::new("minecraft:gold_ingot", 1));
}
}
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(pos.0, pos.1, pos.2, 1);
    // rust: chunk
    // rust: .block_entities
    // rust: .push((pos, crate::containers::BlockEntity::Chest(slots)));
    // rust: chunk.saved = Some(Arc::new(extras));
    // rust: let encoded = encode(&chunk, registry, biomes);
    // rust: let bytes = nbt::write_named(&encoded, Limits::default()).unwrap();
    // rust: let (encoded, used) = nbt::read_named(&bytes, Limits::default()).unwrap();
    // rust: assert_eq!(used, bytes.len());
    // rust: decode(&encoded, registry, biomes).unwrap()
}

pub fn emptied_opened_loot_stays_empty_after_chunk_save_and_reload() void {
}
    // rust: let (registry, biomes) = fixture();
    // rust: let loaded = reload_loot_case(&registry, &biomes, "minecraft:chests/ruined_portal", 42, 1);
    // rust: let source = &loaded.saved.as_ref().unwrap().block_entity_sources[0].1;
    // rust: assert!(
    // rust: source.get("LootTable").is_none(),
    // rust: "opened chest keeps a rerollable loot table: {source:?}"
    // rust: );
    // rust: assert!(source.get("LootTableSeed").is_none());
    // rust: assert_eq!(
    // rust: text(source.get("CustomName")).as_deref(),
    // rust: Some("{\"text\":\"Keep me\"}")
    // rust: );
    // rust: let crate::containers::BlockEntity::Chest(slots) = &loaded.block_entities[0].1 else {
    // rust: panic!("chest");
}
    // rust: assert!(slots.iter().all(Option::is_none));
}

pub fn consuming_one_table_preserves_unopened_neighbors_and_other_fields() void {
}
    // rust: let pos = (1, 64, 2);
    // rust: let other = (2, 64, 2);
    // rust: let tag = Tag::compound([
    // rust: ("LootTable", string("minecraft:chests/ruined_portal")),
    // rust: ("LootTableSeed", Tag::Long(42)),
    // rust: ("CustomName", string("keep")),
    // rust: ]);
    // rust: let rolled = |pos| RolledLoot {
    // rust: pos,
    // rust: table: "minecraft:chests/ruined_portal".into(),
    // rust: seed: Some(42),
    // rust: items: Tag::List(vec![]),
}
    // rust: let mut extras = ChunkExtras {
    // rust: block_entity_sources: vec![(pos, tag.clone()), (other, tag.clone())],
    // rust: rolled_loot: vec![rolled(pos), rolled(other)],
    // rust: ..Default::default()
}
    // rust: consume_container_loot(&mut extras, pos);
    // rust: assert_eq!(extras.rolled_loot, vec![rolled(other)]);
    // rust: assert_eq!(extras.block_entity_sources[1].1, tag);
    // rust: assert_eq!(
    // rust: extras.block_entity_sources[0].1.get("CustomName"),
    // rust: Some(&string("keep"))
    // rust: );
    // rust: let saved = extras.block_entity_sources.clone();
    // rust: consume_container_loot(&mut extras, pos);
    // rust: assert_eq!(extras.block_entity_sources, saved);
    // No rolled marker means an unopened source is not consumed by accident.
    // rust: extras.rolled_loot.clear();
    // rust: consume_container_loot(&mut extras, other);
    // rust: assert_eq!(extras.block_entity_sources[1].1, tag);
}

pub fn opened_loot_parity_fixture() void {
}
//     use std::io::Write;
    // rust: let (registry, biomes) = fixture();
    // rust: let input = fs::read_to_string(std::env::var("HORIZON_OPENED_LOOT_INPUT").unwrap()).unwrap();
    // rust: let mut output =
    // rust: fs::File::create(std::env::var("HORIZON_OPENED_LOOT_OUTPUT").unwrap()).unwrap();
    // rust: for line in input.lines() {
    // rust: let fields: Vec<_> = line.split_whitespace().collect();
    // rust: let mode = fields[2].parse().unwrap();
    // rust: let chunk = reload_loot_case(
    // rust: &registry,
    // rust: &biomes,
    // rust: fields[0],
    // rust: fields[1].parse().unwrap(),
    // rust: mode,
    // rust: );
    // rust: let source = &chunk.saved.as_ref().unwrap().block_entity_sources[0].1;
    // rust: let crate::containers::BlockEntity::Chest(slots) = &chunk.block_entities[0].1 else {
    // rust: panic!("chest");
}
    // rust: let count = if mode == 0 {
    // rust: "unopened".into()
    // rust: } else {
    // rust: slots
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(|s| s.count)
    // rust: .sum::<u32>()
    // rust: .to_string()
}
    // rust: writeln!(
    // rust: output,
    // rust: "{} {} {count}",
    // rust: u8::from(source.get("LootTable").is_some()),
    // rust: u8::from(source.get("LootTableSeed").is_some())
    // rust: )
    // rust: .unwrap();
}
}
