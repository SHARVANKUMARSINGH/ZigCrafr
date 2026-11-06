//! Transpiled from Horizon Rust crate
//! Module: horizon-core_parity
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Line-based differential probe. Not a game client or server.
// use horizon_core::{
    // rust: position::{BlockPos, ChunkPos, SectionPos},
    // rust: random::{
    // rust: LegacyPositionalRandom, LegacyRandom, PositionalRandom, RandomSource,
    // rust: XoroshiroPositionalRandom, XoroshiroRandom, java_string_hash, position_seed,
    // rust: seed_from_hash_utf16,
    // rust: },
    // rust: storage::PackedStorage,
}
// use std::io::{self, BufRead, BufWriter, Write};

    // rust: fn random_probe<R: RandomSource>(out: &mut impl Write, mut rng: R, count: usize) -> io::Result<()> {
    // rust: let bounds = [1, 2, 3, 16, 31, 256, 65_537, 1_073_741_825, i32::MAX, 0, -1];
    // rust: for i in 0..count {
    // rust: let value = match i % 10 {
    // rust: 0 => rng.next_int().to_string(),
    // rust: 1 => rng.next_long().to_string(),
    // rust: 2 => match rng.next_int_bound(bounds[(i / 10) % bounds.len()]) {
    // rust: Ok(value) => value.to_string(),
    // rust: Err(_) => "error".to_owned(),
    // rust: },
    // rust: 3 => u8::from(rng.next_boolean()).to_string(),
    // rust: 4 => rng.next_float().to_bits().to_string(),
    // rust: 5 => rng.next_double().to_bits().to_string(),
    // rust: 6 => rng.fork().next_long().to_string(),
    // rust: 7 => {
    // rust: rng.consume_count((i % 7) as i32 - 2);
    // rust: rng.next_long().to_string()
}
    // rust: 8 => {
    // rust: if i % 101 == 8 {
    // rust: let seed = rng.next_long().wrapping_sub(i as i64);
    // rust: rng.set_seed(seed);
}
    // rust: rng.next_int_bound(1_073_741_825).unwrap().to_string()
}
    // rust: _ => rng.next_int().to_string(),
}
    // rust: writeln!(out, "rng {i} {value}")?;
}
    // rust: Ok(())
}

    // rust: fn read<T: std::str::FromStr>(args: &mut std::str::SplitWhitespace<'_>) -> Result<T, String> {
    // rust: args.next()
    // rust: .ok_or_else(|| "missing argument".to_owned())?
    // rust: .parse()
    // rust: .map_err(|_| "invalid argument".to_owned())
}
    // rust: fn helpers<R: RandomSource>(
    // rust: out: &mut impl Write,
    // rust: mut rng: R,
    // rust: bounds: [i32; 2],
    // rust: double: [f64; 2],
    // rust: float: [f32; 2],
    // rust: ) -> io::Result<()> {
    // rust: for i in 0..32 {
    // rust: let inclusive = rng
    // rust: .next_int_between_inclusive(bounds[0], bounds[1])
    // rust: .map_or_else(|_| "error".to_owned(), |v| v.to_string());
    // rust: let exclusive = rng
    // rust: .next_int_between(bounds[0], bounds[1])
    // rust: .map_or_else(|_| "error".to_owned(), |v| v.to_string());
    // rust: let d = rng.triangle(double[0], double[1]);
    // rust: let f = rng.triangle_float(float[0], float[1]);
    // rust: let d = if d.is_nan() {
    // rust: 0x7ff8_0000_0000_0000
    // rust: } else {
    // rust: d.to_bits()
}
    // rust: let f = if f.is_nan() { 0x7fc0_0000 } else { f.to_bits() };
    // rust: writeln!(
    // rust: out,
    // rust: "helpers {i} {inclusive} {exclusive} {d} {f} {}",
    // rust: rng.next_long()
    // rust: )?;
}
    // rust: random_probe(out, rng, 24)
}
pub fn utf16(token: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if token == "-" {
    // rust: return Ok(Vec::new());
}
    // rust: if token.len() % 4 != 0 {
    // rust: return Err("invalid UTF-16 hex".to_owned());
}
    // rust: token
    // rust: .as_bytes()
    // rust: .chunks_exact(4)
    // rust: .map(|part| {
    // rust: u16::from_str_radix(
    // rust: std::str::from_utf8(part).map_err(|_| "invalid UTF-16 hex")?,
    // rust: 16,
    // rust: )
    // rust: .map_err(|_| "invalid UTF-16 hex".to_owned())
    // rust: })
    // rust: .collect()
}
    // rust: fn factory_probe<P: PositionalRandom>(
    // rust: out: &mut impl Write,
    // rust: factory: P,
    // rust: position: BlockPos,
    // rust: seed: i64,
    // rust: name: &[u16],
    // rust: count: usize,
    // rust: ) -> io::Result<()> {
    // rust: for (label, rng) in [
    // rust: ("at", factory.at(position)),
    // rust: ("seed", factory.from_seed(seed)),
    // rust: ("hash", factory.from_hash_of_utf16(name)),
    // rust: ] {
    // rust: writeln!(out, "factory {label}")?;
    // rust: random_probe(out, rng, count)?;
}
    // rust: Ok(())
}

pub fn probe(line: []const u8, out: *mut impl Write) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut args = line.split_whitespace();
    // rust: match args.next().ok_or("missing operation")? {
    // rust: "helpers" => {
    // rust: let kind = args.next().ok_or("missing RNG kind")?;
    // rust: let seed: i64 = read(&mut args)?;
    // rust: let bounds = [read(&mut args)?, read(&mut args)?];
    // rust: let d = [
    // rust: f64::from_bits(u64::from_str_radix(
    // rust: args.next().ok_or("missing double")?,
    // rust: 16,
    // rust: )?),
    // rust: f64::from_bits(u64::from_str_radix(
    // rust: args.next().ok_or("missing double")?,
    // rust: 16,
    // rust: )?),
    // rust: ];
    // rust: let f = [
    // rust: f32::from_bits(u32::from_str_radix(
    // rust: args.next().ok_or("missing float")?,
    // rust: 16,
    // rust: )?),
    // rust: f32::from_bits(u32::from_str_radix(
    // rust: args.next().ok_or("missing float")?,
    // rust: 16,
    // rust: )?),
    // rust: ];
    // rust: match kind {
    // rust: "legacy" => helpers(out, LegacyRandom::new(seed), bounds, d, f)?,
    // rust: "xoroshiro" => helpers(out, XoroshiroRandom::new(seed), bounds, d, f)?,
    // rust: _ => return Err("unknown RNG kind".into()),
}
}
    // rust: "factory" => {
    // rust: let kind = args.next().ok_or("missing RNG kind")?;
    // rust: let mode: i32 = read(&mut args)?;
    // rust: let lo: i64 = read(&mut args)?;
    // rust: let hi: i64 = read(&mut args)?;
    // rust: let position = BlockPos::new(read(&mut args)?, read(&mut args)?, read(&mut args)?);
    // rust: let seed: i64 = read(&mut args)?;
    // rust: let name = utf16(args.next().ok_or("missing name")?)?;
    // rust: let count: usize = read(&mut args)?;
    // rust: let hash = seed_from_hash_utf16(&name);
    // rust: writeln!(
    // rust: out,
    // rust: "seeds {} {} {} {}",
    // rust: position_seed(position),
    // rust: java_string_hash(name.iter().copied()),
    // rust: hash[0] as i64,
    // rust: hash[1] as i64
    // rust: )?;
    // rust: if kind == "legacy" {
    // rust: let mut source = LegacyRandom::new(lo);
    // rust: let factory = if mode == 0 {
    // rust: LegacyPositionalRandom::new(lo)
    // rust: } else {
    // rust: source.fork_positional()
}
    // rust: factory_probe(out, factory, position, seed, &name, count)?;
    // rust: if mode != 0 {
    // rust: writeln!(out, "parent {}", source.next_long())?;
}
    // rust: } else {
    // rust: let mut source = XoroshiroRandom::new(lo);
    // rust: let factory = if mode == 0 {
    // rust: XoroshiroPositionalRandom::new(lo as u64, hi as u64)
    // rust: } else {
    // rust: source.fork_positional()
}
    // rust: factory_probe(out, factory, position, seed, &name, count)?;
    // rust: if mode != 0 {
    // rust: writeln!(out, "parent {}", source.next_long())?;
}
}
}
    // rust: "position" => {
    // rust: let p = BlockPos::new(read(&mut args)?, read(&mut args)?, read(&mut args)?);
    // rust: let offset = p.offset(read(&mut args)?, read(&mut args)?, read(&mut args)?);
    // rust: let packed = p.pack();
    // rust: let decoded = BlockPos::unpack(packed);
    // rust: let section = p.section();
    // rust: let sp = section.pack();
    // rust: let sd = SectionPos::unpack(sp);
    // rust: let chunk = p.chunk();
    // rust: let cp = chunk.pack();
    // rust: let cd = ChunkPos::unpack(cp);
    // rust: let region = chunk.region();
    // rust: let (rx, rz) = chunk.region_local();
    // rust: let relative = p.section_relative();
    // rust: let rebuilt = section.relative_to_block(relative);
    // rust: writeln!(
    // rust: out,
    // rust: "position {packed} {} {} {} {sp} {} {} {} {cp} {} {} {} {} {rx} {rz} {relative} {} {} {} {} {} {} {}",
    // rust: decoded.x,
    // rust: decoded.y,
    // rust: decoded.z,
    // rust: sd.x,
    // rust: sd.y,
    // rust: sd.z,
    // rust: cd.x,
    // rust: cd.z,
    // rust: region.x,
    // rust: region.z,
    // rust: p.section_index(),
    // rust: rebuilt.x,
    // rust: rebuilt.y,
    // rust: rebuilt.z,
    // rust: offset.x,
    // rust: offset.y,
    // rust: offset.z
    // rust: )?;
}
    // rust: "legacy" => random_probe(out, LegacyRandom::new(read(&mut args)?), read(&mut args)?)?,
    // rust: "xoroshiro" => random_probe(
    // rust: out,
    // rust: XoroshiroRandom::new(read(&mut args)?),
    // rust: read(&mut args)?,
    // rust: )?,
    // rust: "xoroshiro_state" => random_probe(
    // rust: out,
    // rust: XoroshiroRandom::from_state(
    // rust: read::<i64>(&mut args)? as u64,
    // rust: read::<i64>(&mut args)? as u64,
    // rust: ),
    // rust: read(&mut args)?,
    // rust: )?,
    // rust: "storage" => {
    // rust: let bits: u8 = read(&mut args)?;
    // rust: let len: usize = read(&mut args)?;
    // rust: let seed: i64 = read(&mut args)?;
    // rust: let mut storage = PackedStorage::new(bits, len)?;
    // rust: let mut rng = LegacyRandom::new(seed);
    // rust: let mask = ((1_u64 << bits) - 1).min(i32::MAX as u64);
    // rust: for i in 0..len * 3 {
    // rust: let index = rng.next_int_bound(len as i32)? as usize;
    // rust: let value = (rng.next_int() as u32 as u64 & mask) as u32;
    // rust: let old = storage.set(index, value)?;
    // rust: writeln!(out, "set {i} {index} {old} {}", storage.get(index)?)?;
}
    // rust: for (i, &word) in storage.words().iter().enumerate() {
    // rust: writeln!(out, "word {i} {}", word as i64)?;
}
    // rust: for (i, value) in storage.unpack().iter().enumerate() {
    // rust: writeln!(out, "value {i} {}", *value as i32)?;
}
    // rust: let mut imported =
    // rust: PackedStorage::from_words(bits, len, vec![u64::MAX; storage.words().len()])?;
    // rust: for i in 0..len {
    // rust: writeln!(out, "import {i} {}", imported.get(i)? as i32)?;
}
    // rust: if len > 0 {
    // rust: imported.set(len - 1, 0)?;
}
    // rust: for (i, &word) in imported.words().iter().enumerate() {
    // rust: writeln!(out, "import_word {i} {}", word as i64)?;
}
    // rust: for value in [0, 1, mask as u32] {
    // rust: imported.fill(value)?;
    // rust: for (i, &word) in imported.words().iter().enumerate() {
    // rust: writeln!(out, "fill {value} {i} {}", word as i64)?;
}
}
    // rust: let before = storage.clone();
    // rust: writeln!(
    // rust: out,
    // rust: "invalid_index {}",
    // rust: u8::from(storage.set(len, 0).is_err())
    // rust: )?;
    // rust: let invalid_value = if bits == 32 { u32::MAX } else { 1_u32 << bits };
            // An empty storage has no valid index at which to test value errors.
    // rust: if len > 0 {
    // rust: writeln!(
    // rust: out,
    // rust: "invalid_value {}",
    // rust: u8::from(storage.set(0, invalid_value).is_err())
    // rust: )?;
}
    // rust: writeln!(out, "unchanged {}", u8::from(storage == before))?;
}
    // rust: _ => return Err("unknown operation".into()),
}
    // rust: if args.next().is_some() {
    // rust: return Err("unexpected trailing argument".into());
}
    // rust: Ok(())
}

pub fn main() void {
}
    // rust: let mut out = BufWriter::new(io::stdout().lock());
    // rust: for (i, line) in io::stdin().lock().lines().enumerate() {
    // rust: let result = line
    // rust: .map_err(|e| e.to_string())
    // rust: .and_then(|line| probe(&line, &mut out).map_err(|e| e.to_string()));
    // rust: if let Err(error) = result {
    // rust: eprintln!("line {}: {error}", i + 1);
    // rust: std::process::exit(2);
}
}
    // rust: if let Err(error) = out.flush() {
    // rust: eprintln!("output failed: {error}");
    // rust: std::process::exit(2);
}
}
