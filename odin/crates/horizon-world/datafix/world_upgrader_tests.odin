//! Transpiled from Horizon Rust crate
package horizon_world_world_upgrader_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use crate::nbt::NamedTag;

TempWorld :: struct {
    // rust: impl TempWorld {
new :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-wu-{name}-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    fs: :create_dir_all(^dir).unwrap(),
    // rust: Self(dir)
}
folder :: proc(self: ^Self, dimension: string, folder: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: dimension_path(&self.0, dimension).join(folder)
}
}
    // rust: impl Drop for TempWorld {
drop :: proc(self: ^Self) {
}
    // rust: let _ = fs::remove_dir_all(&self.0);
}
}

root :: proc(tag: Tag) -> N {
    // Ported from Horizon
    return {}
}
    // rust: NamedTag {
    // rust: name: "".into(),
    // rust: tag,
}
}

write_chunks :: proc(file: ^Path, chunks: ^[(ChunkPos) {
}
    // rust: fs::create_dir_all(file.parent().unwrap()).unwrap();
    // rust: let mut region = RegionFile::open_writable(file, true).unwrap();
    // rust: for (pos, tag) in chunks {
    // rust: let record =
    // rust: ChunkRecord::from_nbt(&root(tag.clone()), Compression::Zlib, 1, Limits::default())
    // rust: .unwrap();
    // rust: region.write(*pos, &record).unwrap();
}
}

read_chunk :: proc(file: ^Path, pos: ChunkPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut region = RegionFile::open(file).unwrap();
    // rust: region
    // rust: .read(pos)
    // rust: .unwrap()
    // rust: .map(|r| r.nbt(Limits::default()).unwrap().tag)
}

entity_chunk :: proc(version: i32, x: i32, z: i32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound([
    // rust: ("DataVersion", Tag::Int(version)),
    // rust: ("Position", Tag::IntArray(vec![x, z])),
    // rust: ("Entities", Tag::List(vec![])),
    // rust: ])
}

level :: proc(world: ^TempWorld) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let _ = world;
    // rust: vec![OVERWORLD.into(), NETHER.into()]
}

run :: proc(world: ^TempWorld, erase: bool, recreate: bool) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let progress = Arc::new(UpgradeProgress::new());
    // rust: work(&world.0, &level(world), &progress, erase, recreate);
    // rust: progress
}

version_of :: proc(file: ^Path, pos: ChunkPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: as_int(read_chunk(file, pos).unwrap().get("DataVersion"), -1)
}

old_chunks_are_converted_and_current_ones_skipped :: proc() {
}
    // rust: let world = TempWorld::new("convert");
    // rust: let file = world.folder(OVERWORLD, "entities").join("r.0.0.mca");
    // rust: write_chunks(
    // rust: &file,
    // rust: &[
    // rust: (ChunkPos::new(0, 0), entity_chunk(4000, 0, 0)),
    // rust: (ChunkPos::new(0, 1), entity_chunk(CURRENT, 0, 1)),
    // rust: ],
    // rust: );
    // rust: let progress = run(&world, false, false);
    // rust: assert!(progress.is_finished());
    // rust: assert_eq!(version_of(&file, ChunkPos::new(0, 0)), CURRENT);
    // rust: assert_eq!(version_of(&file, ChunkPos::new(0, 1)), CURRENT);
    // The last data type run is the blocks; entities counted 1 converted, 1 skipped.
    // rust: assert_eq!(progress.data_fix_type(), Some(UpgradeDataFixType::Chunk));
    // rust: assert_eq!(progress.total_chunks(), 0);
}

counts_of_one_data_type :: proc() {
}
    // rust: let world = TempWorld::new("counts");
    // rust: let file = world.folder(OVERWORLD, "entities").join("r.0.0.mca");
    // rust: write_chunks(
    // rust: &file,
    // rust: &[
    // rust: (ChunkPos::new(0, 0), entity_chunk(4000, 0, 0)),
    // rust: (ChunkPos::new(0, 1), entity_chunk(CURRENT, 0, 1)),
    // rust: ],
    // rust: );
    // rust: let progress = Arc::new(UpgradeProgress::new());
    // rust: upgrade_levels(
    // rust: &world.0,
    // rust: &level(&world),
    // rust: &progress,
    // rust: Builder::new(UpgradeDataFixType::EntityChunk, "entities", false),
    // rust: |_, _| {},
    // rust: );
    // rust: assert_eq!(progress.total_chunks(), 2);
    // rust: assert_eq!(progress.converted(), 1);
    // rust: assert_eq!(progress.skipped(), 1);
    // rust: assert_eq!(progress.status(), UpgradeStatus::Finished);
    // rust: assert_eq!(progress.total_progress(), 1.0);
    // rust: assert_eq!(progress.dimension_progress(OVERWORLD), 1.0);
    // rust: assert_eq!(progress.dimension_progress(NETHER), 0.0);
}

// `converted = converted && processOnePosition(..)`: after a chunk that was
// not converted, the rest of its file is left alone.
a_skipped_chunk_ends_the_files_pass :: proc() {
}
    // rust: let world = TempWorld::new("shortcircuit");
    // rust: let file = world.folder(OVERWORLD, "entities").join("r.0.0.mca");
    // rust: write_chunks(
    // rust: &file,
    // rust: &[
    // rust: (ChunkPos::new(0, 0), entity_chunk(CURRENT, 0, 0)),
    // rust: (ChunkPos::new(1, 0), entity_chunk(4000, 1, 0)),
    // rust: ],
    // rust: );
    // rust: let progress = Arc::new(UpgradeProgress::new());
    // rust: upgrade_levels(
    // rust: &world.0,
    // rust: &level(&world),
    // rust: &progress,
    // rust: Builder::new(UpgradeDataFixType::EntityChunk, "entities", false),
    // rust: |_, _| {},
    // rust: );
    // rust: assert_eq!(progress.total_chunks(), 2);
    // rust: assert_eq!(progress.converted(), 0);
    // rust: assert_eq!(progress.skipped(), 1);
    // rust: assert_eq!(version_of(&file, ChunkPos::new(1, 0)), 4000);
}

poi_chunks_without_a_version_start_at_1945 :: proc() {
}
    // rust: let world = TempWorld::new("poi");
    // rust: let file = world.folder(NETHER, "poi").join("r.-1.2.mca");
    // rust: let pos = ChunkPos::new(-32, 64);
    // rust: write_chunks(
    // rust: &file,
    // rust: &[(
    // rust: pos,
    // rust: Tag::compound([("Sections", Tag::Compound(Default::default()))]),
    // rust: )],
    // rust: );
    // rust: run(&world, false, false);
    // rust: assert_eq!(version_of(&file, pos), CURRENT);
}

erase_cache_drops_heightmaps_and_light :: proc() {
}
    // rust: let world = TempWorld::new("erase");
    // rust: let file = world.folder(OVERWORLD, "region").join("r.0.0.mca");
    // rust: let pos = ChunkPos::new(0, 0);
    // rust: let chunk = |version| {
    // rust: Tag::compound([
    // rust: ("DataVersion", Tag::Int(version)),
    // rust: ("xPos", Tag::Int(0)),
    // rust: ("zPos", Tag::Int(0)),
    // rust: ("Status", Tag::String("minecraft:full".into())),
    // rust: ("isLightOn", Tag::Byte(1)),
    // rust: ("Heightmaps", Tag::Compound(Default::default())),
    // rust: (
    // rust: "sections",
    // rust: Tag::List(vec![Tag::compound([
    // rust: ("Y", Tag::Byte(0)),
    // rust: ("SkyLight", Tag::ByteArray(vec![0; 2048])),
    // rust: ("BlockLight", Tag::ByteArray(vec![0; 2048])),
    // rust: ])]),
    // rust: ),
    // rust: ])
}
    // rust: write_chunks(&file, &[(pos, chunk(CURRENT))]);
    // Without the option a current chunk is left as it is.
    // rust: let progress = run(&world, false, false);
    // rust: assert!(read_chunk(&file, pos).unwrap().get("Heightmaps").is_some());
    // rust: assert_eq!(progress.status(), UpgradeStatus::Finished);

    // rust: run(&world, true, false);
    // rust: let after = read_chunk(&file, pos).unwrap();
    // rust: assert!(after.get("Heightmaps").is_none());
    // rust: assert!(after.get("isLightOn").is_none());
    // rust: let Some(Tag::List(sections)) = after.get("sections") else {
    // rust: panic!("sections");
}
    // rust: assert!(sections[0].get("SkyLight").is_none() && sections[0].get("BlockLight").is_none());
    // rust: assert!(sections[0].get("Y").is_some());
}

erase_cache_modifier_reports_changes_only_when_something_went :: proc() {
}
    // rust: let pos = ChunkPos::new(3, 4);
    // rust: let mut bare = Tag::compound([("xPos", Tag::Int(3)), ("zPos", Tag::Int(4))]);
    // rust: assert!(!verify_chunk_pos_and_erase_cache(pos, &mut bare));
    // rust: let mut lit = Tag::compound([("xPos", Tag::Int(3)), ("isLightOn", Tag::Byte(1))]);
    // rust: assert!(verify_chunk_pos_and_erase_cache(pos, &mut lit));
    // rust: assert!(!verify_chunk_pos(pos, &mut lit));
}

recreating_rewrites_every_file_and_removes_the_new_folder :: proc() {
}
    // rust: let world = TempWorld::new("recreate");
    // rust: let file = world.folder(OVERWORLD, "entities").join("r.0.0.mca");
    // rust: write_chunks(
    // rust: &file,
    // rust: &[
    // rust: (ChunkPos::new(0, 0), entity_chunk(CURRENT, 0, 0)),
    // rust: (ChunkPos::new(1, 0), entity_chunk(CURRENT, 1, 0)),
    // rust: ],
    // rust: );
    // rust: let before = fs::read(&file).unwrap();
    // rust: let progress = run(&world, false, true);
    // rust: assert!(progress.is_finished());
    // rust: assert!(!world.folder(OVERWORLD, "new_entities").exists());
    // rust: assert_eq!(version_of(&file, ChunkPos::new(1, 0)), CURRENT);
    // rust: assert_ne!(
    // rust: fs::read(&file).unwrap(),
    // rust: before,
    // rust: "the file was written anew"
    // rust: );
}

cancel_stops_before_the_next_file :: proc() {
}
    // rust: let world = TempWorld::new("cancel");
    // rust: let file = world.folder(OVERWORLD, "entities").join("r.0.0.mca");
    // rust: write_chunks(&file, &[(ChunkPos::new(0, 0), entity_chunk(4000, 0, 0))]);
    // rust: let progress = Arc::new(UpgradeProgress::new());
    // rust: let mut upgrader = RegionStorageUpgrader::init(
    // rust: Builder::new(UpgradeDataFixType::EntityChunk, "entities", false),
    // rust: progress.clone(),
    // rust: 0,
    // rust: OVERWORLD,
    // rust: &world.0,
    // rust: );
    // rust: progress.set_canceled();
    // rust: upgrader.upgrade();
    // rust: assert_eq!(progress.converted(), 0);
    // rust: assert_eq!(version_of(&file, ChunkPos::new(0, 0)), 4000);
}

the_worker_thread_finishes_and_a_cancel_joins_it :: proc() {
}
    // rust: let world = TempWorld::new("thread");
    // rust: let file = world.folder(OVERWORLD, "entities").join("r.0.0.mca");
    // rust: write_chunks(&file, &[(ChunkPos::new(0, 0), entity_chunk(4000, 0, 0))]);
    // rust: let mut upgrader = WorldUpgrader::new(&world.0, world_dimensions(&world.0), false, false);
    // rust: while !upgrader.is_finished() {
    // rust: std::thread::sleep(std::time::Duration::from_millis(5));
}
    // rust: upgrader.cancel();
    // rust: assert_eq!(version_of(&file, ChunkPos::new(0, 0)), CURRENT);
    // rust: assert_eq!(upgrader.levels(), [OVERWORLD, NETHER, END]);
}

status_keys_follow_vanilla :: proc() {
}
    // rust: let progress = UpgradeProgress::new();
    // rust: assert_eq!(status_key(&progress), "optimizeWorld.stage.counting");
    // rust: progress.reset(UpgradeDataFixType::PoiChunk);
    // rust: progress.set_status(UpgradeStatus::Upgrading);
    // rust: assert_eq!(status_key(&progress), "optimizeWorld.stage.upgrading.poi");
    // rust: progress.set_status(UpgradeStatus::Finished);
    // rust: assert_eq!(status_key(&progress), "optimizeWorld.stage.finished.poi");
    // rust: progress.set_status(UpgradeStatus::Failed);
    // rust: assert_eq!(status_key(&progress), "optimizeWorld.stage.failed");
}

region_names_and_dimension_folders :: proc() {
}
    // rust: assert_eq!(region_coordinates("r.-3.12.mca"), Some((-3, 12)));
    // rust: assert_eq!(region_coordinates("r.1.mca"), None);
    // rust: assert_eq!(region_coordinates("r.a.1.mca"), None);
    // rust: assert_eq!(region_coordinates("r.1.1.mcc"), None);
    // rust: let base = Path::new("w");
    // rust: assert_eq!(
    // rust: dimension_path(base, "mod:sky"),
    // rust: Path::new("w/dimensions/mod/sky")
    // rust: );
    // rust: let world = TempWorld::new("dims");
    // rust: fs::create_dir_all(world.0.join("dimensions/mod/sky")).unwrap();
    // rust: assert_eq!(
    // rust: world_dimensions(&world.0),
    // rust: [OVERWORLD, NETHER, END, "mod:sky"]
    // rust: );
}
