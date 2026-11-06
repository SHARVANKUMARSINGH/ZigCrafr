//! Transpiled from Horizon Rust crate
package horizon_client_gateway

import "core:fmt"
import "core:mem"
import "core:math"

// One-time migration of Horizon's old gateway side file into chunk NBT.
// use super::*;

LEGACY_FILE :: "horizon-end-gateways.json"

// The block actually at an old entry, rather than a stale block entity.
is_gateway :: proc(root: ^Tag, pos: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(y) = i8::try_from(pos.y >> 4) else {
    // rust: return Ok(false);
}
    // rust: let Some(Tag::List(sections)) = root.get("sections") else {
    // rust: return Err("gateway migration: missing chunk sections".into());
}
    // rust: let Some(section) = sections.iter().find(|s| s.get("Y") == Some(&Tag::Byte(y))) else {
    // rust: return Ok(false);
}
    // rust: let Some(states) = section.get("block_states") else {
    // rust: return Ok(false);
}
    // rust: let palette = horizon_world::chunk::PalettedContainer::from_nbt(states, 4096, 4)?;
    // rust: Ok(BlockState::from_nbt(palette.get(pos.section_index())?)?.name == "minecraft:end_gateway")
}

    // rust: impl SaveDir {
    // Horizon-only legacy migration, before this store's chunk loaders start.
    // Chunk NBT is authoritative; preserve its exit and all unrelated tags.
    // Retire the JSON only after the region writer confirms every update.
migrate_end_gateway_exits :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let path = self.root.join(LEGACY_FILE);
    // rust: let bytes = match fs::read(&path) {
    // rust: Ok(bytes) => bytes,
    // rust: Err(e) if e.kind() == std::io::ErrorKind::NotFound => return Ok(0),
    // rust: Err(e) => return Err(e.into()),
}
    // rust: let entries: Vec<([i32; 3], [i32; 3], bool)> = serde_json::from_slice(&bytes)?;
        // The old in-memory map kept the last entry for a position.
    // rust: let entries: BTreeMap<_, _> = entries.into_iter().map(|(p, e, x)| (p, (e, x))).collect();
    // rust: let mut chunks = BTreeMap::new();
    // rust: let mut changed = HashSet::new();
    // rust: let mut migrated = 0;
    // rust: for (p, (exit, exact)) in entries {
    // rust: let pos = BlockPos::new(p[0], p[1], p[2]);
    // rust: let key = (p[0] >> 4, p[2] >> 4);
    // rust: let root = match chunks.entry(key) {
    // rust: std::collections::btree_map::Entry::Occupied(e) => e.into_mut(),
    // rust: std::collections::btree_map::Entry::Vacant(e) => {
                    // Propagate damaged/unreadable regions; never discard their legacy exits.
    // rust: let Some(mut root) =
    // rust: read_region_record(&self.root, &self.regions, "region", key.0, key.1)?
    // rust: else {
    // rust: continue;
}
    // rust: self.upgrade_record(Folder::Region, &mut root)?;
    // rust: e.insert(root)
}
}
    // rust: if !is_gateway(&root.tag, pos)? {
    // rust: continue;
}
    // rust: let Tag::Compound(fields) = &mut root.tag else {
    // rust: return Err("invalid chunk compound".into());
}
    // rust: let Tag::List(entities) = fields
    // rust: .entry("block_entities".into())
    // rust: .or_insert_with(|| Tag::List(Vec::new()))
    // rust: else {
    // rust: return Err("invalid chunk block entities".into());
}
    // rust: let index = entities.iter().position(|e| {
    // rust: ["x", "y", "z"]
    // rust: .iter()
    // rust: .zip(p)
    // rust: .all(|(k, n)| number(e.get(k)) == Some(i64::from(n)))
    // rust: });
    // rust: let entity = match index {
    // rust: Some(i) => &mut entities[i],
    // rust: None => {
    // rust: entities.push(Tag::Compound(Compound::from_iter([
    // rust: ("id".into(), Tag::String("minecraft:end_gateway".into())),
    // rust: ("x".into(), Tag::Int(p[0])),
    // rust: ("y".into(), Tag::Int(p[1])),
    // rust: ("z".into(), Tag::Int(p[2])),
    // rust: ])));
    // rust: entities.last_mut().unwrap()
}
}
    // rust: if text(entity.get("id")).as_deref() != Some("minecraft:end_gateway") {
    // rust: return Err("gateway migration: mismatched block entity".into());
}
    // rust: if decode_end_gateway(entity).exit_portal.is_some() {
    // rust: continue;
}
    // rust: let exit = Tag::IntArray(exit.to_vec());
    // rust: if crate::block_entity_nbt::gateway_exit(&exit).is_none() {
    // rust: return Err("gateway migration: invalid legacy exit".into());
}
    // rust: let Tag::Compound(entity) = entity else {
    // rust: unreachable!()
}
    // rust: entity.insert("exit_portal".into(), exit);
    // rust: if exact {
    // rust: entity.insert("ExactTeleport".into(), Tag::Byte(1));
    // rust: } else {
    // rust: entity.remove(&"ExactTeleport".into());
}
    // rust: changed.insert(key);
    // rust: migrated += 1;
}
    // rust: let records = chunks
    // rust: .into_iter()
    // rust: .filter(|(k, _)| changed.contains(k))
    // rust: .map(|(k, root)| (k, Some(root)))
    // rust: .collect();
    // rust: self.write_records("region", records, true)?;
    // rust: fs::remove_file(path)?;
    // rust: Ok(migrated)
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::chunk::ChunkData;
NEXT :: AtomicU64::new(0)

fixture :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "gateway-migration-{}-{}",
    // rust: std::process::id(),
    // rust: NEXT.fetch_add(1, Ordering::Relaxed)
    // rust: ));
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: let save = SaveDir::new(dir.clone(), LevelShape::END);
    // rust: (dir, save)
}
root :: proc() -> N {
    // Ported from Horizon
    return {}
}
    // rust: NamedTag { name: "".into(), tag: horizon_world::nbt::parse_snbt(&format!(
    // rust: "{{DataVersion:{DATA_VERSION},xPos:0,zPos:0,Status:\"minecraft:full\",opaque:\"keep\",sections:[{{Y:4b,block_states:{{palette:[{{id:\"minecraft:end_gateway\"}}]}}}}],block_entities:[{{id:\"minecraft:end_gateway\",x:2,y:75,z:2,Age:321L,exit_portal:[I;9,80,9],ExactTeleport:0b,other:\"keep\"}}]}}"
    // rust: )).unwrap().0 }
}
write :: proc(save: ^SaveDir, root: NamedTag) {
}
    // rust: save.write_records("region", vec![((0, 0), Some(root))], true)
    // rust: .unwrap();
}
read :: proc(save: ^SaveDir) -> N {
    // Ported from Horizon
    return {}
}
    // rust: save.read_record("region", 0, 0).unwrap()
}
entity :: proc(root: ^NamedTag, x: i32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Tag::List(list)) = root.tag.get("block_entities") else {
    // rust: panic!("entities")
}
    // rust: list.iter()
    // rust: .find(|e| e.get("x") == Some(&Tag::Int(x)))
    // rust: .unwrap()
}

legacy_gateways_migrate_once_with_nbt_precedence_and_no_stale_resurrection :: proc() {
}
    // rust: let (dir, save) = fixture();
    // rust: write(&save, root());
    // rust: fs::write(
    // rust: dir.join(LEGACY_FILE),
    // rust: serde_json::to_vec(&vec![
    // rust: ([1, 75, 1], [100, 80, 100], true),
    // rust: ([2, 75, 2], [200, 80, 200], true),
    // rust: ([3, 50, 3], [300, 80, 300], false),
    // rust: ([1000, 75, 0], [400, 80, 400], false),
    // rust: ])
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(save.migrate_end_gateway_exits().unwrap(), 1);
    // rust: assert!(!dir.join(LEGACY_FILE).exists());
    // rust: let saved = read(&save);
    // rust: assert_eq!(
    // rust: decode_end_gateway(entity(&saved, 1)).exit_portal,
    // rust: Some([100, 80, 100])
    // rust: );
    // rust: assert!(decode_end_gateway(entity(&saved, 1)).exact_teleport);
    // rust: assert_eq!(
    // rust: decode_end_gateway(entity(&saved, 2)).exit_portal,
    // rust: Some([9, 80, 9])
    // rust: );
    // rust: assert!(!decode_end_gateway(entity(&saved, 2)).exact_teleport);
    // rust: assert_eq!(
    // rust: entity(&saved, 2).get("other"),
    // rust: Some(&Tag::String("keep".into()))
    // rust: );
    // rust: assert_eq!(saved.tag.get("opaque"), Some(&Tag::String("keep".into())));
    // rust: assert_eq!(save.migrate_end_gateway_exits().unwrap(), 0);
        // A stale entry for a removed gateway must not create a block entity.
    // rust: let mut removed = ChunkData::new(saved).unwrap();
    // rust: removed
    // rust: .set_block_data(
    // rust: BlockPos::new(1, 75, 1),
    // rust: BlockState {
    // rust: name: "minecraft:air".into(),
    // rust: properties: Default::default(),
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: let mut removed = removed.into_nbt();
    // rust: let Some(Tag::List(list)) = removed.tag.get_mut("block_entities") else {
    // rust: panic!("entities")
}
    // rust: list.retain(|e| e.get("x") != Some(&Tag::Int(1)));
    // rust: write(&save, removed);
    // rust: fs::write(dir.join(LEGACY_FILE), b"[[[1,75,1],[100,80,100],true]]").unwrap();
    // rust: assert_eq!(save.migrate_end_gateway_exits().unwrap(), 0);
    // rust: let Some(Tag::List(list)) = read(&save).tag.get("block_entities").cloned() else {
    // rust: panic!("entities")
}
    // rust: assert_eq!(list.len(), 1);
    // rust: drop(save);
    // rust: fs::remove_dir_all(dir).unwrap();
}

malformed_or_undurable_migrations_retain_the_legacy_file :: proc() {
}
    // rust: let (dir, save) = fixture();
    // rust: write(&save, root());
    // rust: let path = dir.join(LEGACY_FILE);
    // rust: fs::write(&path, b"malformed").unwrap();
    // rust: assert!(save.migrate_end_gateway_exits().is_err());
    // rust: assert_eq!(fs::read(&path).unwrap(), b"malformed");
    // rust: let bytes = b"[[[1,75,1],[100,80,100],false]]";
    // rust: fs::write(&path, bytes).unwrap();
    // rust: *save.outstanding.error.lock().unwrap() = Some("injected save failure".into());
    // rust: assert!(save.migrate_end_gateway_exits().is_err());
    // rust: assert_eq!(fs::read(&path).unwrap(), bytes);
    // rust: drop(save);
    // rust: fs::remove_dir_all(dir).unwrap();
}
}
