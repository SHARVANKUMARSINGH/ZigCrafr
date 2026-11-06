//! Transpiled from Horizon Rust crate
package horizon_world_main

import "core:fmt"
import "core:mem"
import "core:math"

// use horizon_core::position::BlockPos;
// use horizon_world::{
    // rust: chunk::{BlockState, ChunkData},
    // rust: compression::Compression,
    // rust: nbt::{self, Limits},
    // rust: region::{ChunkRecord, RegionFile, RegionWriter},
}
// use std::{
    // rust: collections::BTreeMap,
    // rust: error::Error,
    // rust: fs::{File, OpenOptions},
    // rust: io::{Read, Write},
    // rust: path::Path,
}

codec :: proc(name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "gzip" | "1" => Ok(Compression::Gzip),
    // rust: "zlib" | "2" => Ok(Compression::Zlib),
    // rust: "none" | "3" => Ok(Compression::None),
    // rust: "lz4" | "4" => Ok(Compression::Lz4),
    // rust: _ => Err(format!("unknown codec {name}; choose gzip, zlib, none or lz4").into()),
}
}

read_bounded :: proc(path: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let max = Limits::default().max_bytes;
    // rust: let mut bytes = Vec::new();
    // rust: File::open(path)?
    // rust: .take((max + 1) as u64)
    // rust: .read_to_end(&mut bytes)?;
    // rust: if bytes.len() > max {
    // rust: return Err("input exceeds 64 MiB limit".into());
}
    // rust: Ok(bytes)
}

write_new :: proc(path: string, bytes: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut file = OpenOptions::new().write(true).create_new(true).open(path)?;
    // rust: if let Err(error) = file.write_all(bytes).and_then(|_| file.sync_all()) {
    // rust: drop(file);
    // rust: let _ = std::fs::remove_file(path);
    // rust: return Err(error.into());
}
    // rust: Ok(())
}

run :: proc(args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(command) = args.first().map(String::as_str) else {
    // rust: return Err("use --help for commands".into());
}
    // rust: match command {
    // rust: "--help" | "-h" if args.len() == 1 => println!(
    // rust: "Horizon world data tools — Java Edition {}\n\
    // rust: inspect <region.mca>\n\
    // rust: copy-region <source.mca> <new-directory/r.x.z.mca> [gzip|zlib|none|lz4]\n\
    // rust: get-block <region.mca> <x> <y> <z>\n\
    // rust: edit-block-data <source.mca> <new-directory/r.x.z.mca> <x> <y> <z> <name> [property=value ...]\n\
    // rust: nbt-copy <input> <new-output> <input-codec> <output-codec>\n\
    // rust: nbt-network-copy <input> <new-output> <input-codec> <output-codec>\n\
    // rust: Existing output files are refused. edit-block-data changes saved block data only;\n\
    // rust: it does not run lighting, heightmaps, ticks or neighbor updates.",
    // rust: horizon_core::VANILLA_VERSION
    // rust: ),
    // rust: "nbt-copy" | "nbt-network-copy" if args.len() == 5 => {
    // rust: let bytes =
    // rust: codec(&args[3])?.decode(&read_bounded(&args[1])?, Limits::default().max_bytes)?;
    // rust: let encoded = if command == "nbt-copy" {
    // rust: let (root, used) = nbt::read_named(&bytes, Limits::default())?;
    // rust: if used != bytes.len() {
    // rust: return Err("trailing bytes after NBT root".into());
}
    // rust: nbt::write_named(&root, Limits::default())?
    // rust: } else {
    // rust: let (root, used) = nbt::read_network(&bytes, Limits::default())?;
    // rust: if used != bytes.len() {
    // rust: return Err("trailing bytes after NBT root".into());
}
    // rust: nbt::write_network(&root, Limits::default())?
}
    // rust: write_new(&args[2], &codec(&args[4])?.encode(&encoded)?)?;
    // rust: println!("Wrote {}", args[2]);
}
    // rust: "inspect" if args.len() == 2 => {
    // rust: let mut region = RegionFile::open(&args[1])?;
    // rust: let chunks: Vec<_> = region.chunks().collect();
    // rust: println!(
    // rust: "Horizon region {},{}: {} chunks",
    // rust: region.position().x,
    // rust: region.position().z,
    // rust: chunks.len()
    // rust: );
    // rust: for (pos, timestamp) in chunks {
    // rust: let record = region.read(pos)?.unwrap();
    // rust: let root = record.nbt(Limits::default())?;
    // rust: println!(
    // rust: "chunk {},{} timestamp={} codec={:?} compressed={} root_type={}",
    // rust: pos.x,
    // rust: pos.z,
    // rust: timestamp,
    // rust: record.compression,
    // rust: record.compressed.len(),
    // rust: root.tag.id()
    // rust: );
}
}
    // rust: "copy-region" if args.len() == 3 || args.len() == 4 => {
    // rust: let mut region = RegionFile::open(&args[1])?;
    // rust: if args.len() == 3 {
    // rust: region.export(&args[2], &[])?;
    // rust: } else {
    // rust: let compression = codec(&args[3])?;
    // rust: if horizon_world::region::position_from_path(Path::new(&args[2]))?
    // rust: != region.position()
    // rust: {
    // rust: return Err("export region coordinates differ".into());
}
    // rust: let mut writer = RegionWriter::create(&args[2])?;
    // rust: let positions: Vec<_> = region.chunks().map(|(p, _)| p).collect();
    // rust: for pos in positions {
    // rust: let old = region.read(pos)?.unwrap();
    // rust: let record = ChunkRecord::from_nbt(
    // rust: &old.nbt(Limits::default())?,
    // rust: compression,
    // rust: old.timestamp,
    // rust: Limits::default(),
    // rust: )?;
    // rust: writer.write(pos, &record)?;
}
    // rust: writer.finish()?;
}
    // rust: println!("Wrote {}", args[2]);
}
    // rust: "get-block" if args.len() == 5 => {
    // rust: let block = BlockPos::new(args[2].parse()?, args[3].parse()?, args[4].parse()?);
    // rust: let record = RegionFile::open(&args[1])?
    // rust: .read(block.chunk())?
    // rust: .ok_or("chunk is absent")?;
    // rust: let chunk = ChunkData::new(record.nbt(Limits::default())?)?;
    // rust: let state = chunk
    // rust: .block(block)?
    // rust: .ok_or("section has no block-state data")?;
    // rust: print!("{}", state.name);
    // rust: for (name, value) in state.properties {
    // rust: print!(" {name}={value}");
}
    // rust: println!();
}
    // rust: "edit-block-data" if args.len() >= 7 => {
    // rust: let block = BlockPos::new(args[3].parse()?, args[4].parse()?, args[5].parse()?);
    // rust: let mut properties = BTreeMap::new();
    // rust: for arg in &args[7..] {
    // rust: let (key, value) = arg.split_once('=').ok_or("expected property=value")?;
    // rust: if key.is_empty()
    // rust: || value.is_empty()
    // rust: || properties
    // rust: .insert(key.to_owned(), value.to_owned())
    // rust: .is_some()
    // rust: {
    // rust: return Err("invalid or duplicate block property".into());
}
}
    // rust: let mut region = RegionFile::open(&args[1])?;
    // rust: let old = region.read(block.chunk())?.ok_or("chunk is absent")?;
    // rust: let mut chunk = ChunkData::new(old.nbt(Limits::default())?)?;
    // rust: chunk.set_block_data(
    // rust: block,
    // rust: BlockState {
    // rust: name: args[6].clone(),
    // rust: properties: properties.into(),
    // rust: },
    // rust: )?;
    // rust: let timestamp = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)?
    // rust: .as_secs() as u32;
    // rust: let next = ChunkRecord::from_nbt(
    // rust: &chunk.into_nbt(),
    // rust: old.compression,
    // rust: timestamp,
    // rust: Limits::default(),
    // rust: )?;
    // rust: region.export(&args[2], &[(block.chunk(), Some(next))])?;
    // rust: println!(
    // rust: "Wrote saved block data to {}; simulation-derived data has not been updated.",
    // rust: args[2]
    // rust: );
}
    // rust: _ => return Err("invalid command or arguments; use --help".into()),
}
    // rust: Ok(())
}

main :: proc() {
}
    // rust: if let Err(error) = run(&std::env::args().skip(1).collect::<Vec<_>>()) {
    // rust: eprintln!("Horizon: {error}");
    // rust: std::process::exit(2);
}
}
