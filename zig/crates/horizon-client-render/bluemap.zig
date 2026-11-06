//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_bluemap
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Far terrain from a server's BlueMap: the
//! lowres tiles of the server's web map, fetched over HTTP around the player,
//! fill the far terrain where no real chunk was ever seen
//! (`server_terrain`'s store always comes first). Off unless the
//! player names the server's map (`Settings`), or lets Horizon look for it
//! (`bluemap_detect`).
//!
//! A lowres tile (`LowresTile`) is a PNG of `(size + 1)` × `2 (size + 1)`
//! pixels: the top half each column's colour, the bottom half its height
//! (green and blue, a signed 16-bit number) and block light (red). Level 1
//! has a pixel a block; each next level averages `lodFactor` × `lodFactor`
//! pixels into one (`LowresLayer.saveTile`).
//!
//! The tile layout and paths follow BlueMap's own (MIT, Copyright (c) Blue
//! (Lukas Rieger) and contributors; THIRD_PARTY_NOTICES.md): `LowresLayer`,
//! `MapSettingsSerializer` and the web app's `pathFromCoords`, at `96ae320d1d39`.
// use crate::{
    // rust: biome::Biomes,
    // rust: chunk::MIN_Y,
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: lod::{Column, Span},
}
// use horizon_world::registry::{BlockRegistry, BlockStateId};
// use std::{
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Condvar, Mutex, OnceLock, Weak},
    // rust: time::{Duration, Instant, SystemTime},
}

/// Downloaded tiles kept on disk per server, at most.
pub const DISK_CAP: u64 = 256 << 20;
/// A cached tile older than this is fetched again (and drawn meanwhile).
pub const MAX_AGE: Duration = Duration::from_secs(3 * 24 * 3600);
/// One request at a time, this far apart at least.
pub const REQUEST_GAP: Duration = Duration::from_millis(100);
/// After a failed request the server is left alone this long, doubling.
pub const BACKOFF: Duration = Duration::from_secs(15);
pub const MAX_BACKOFF: Duration = Duration::from_secs(600);
/// Decoded tiles kept in memory, at most this many bytes of pixels (a
/// 500-block tile is about 2 MiB) and this many tiles.
pub const MAX_TILE_BYTES: usize = 192 << 20;
pub const MAX_TILES: usize = 2048;
pub const MAX_CHUNKS: usize = 4096;
pub const MAX_QUEUE: usize = 4096;
/// Arrived data is handed to far terrain at most this often (`take_changed`),
/// so a burst of tiles is sampled again once.
pub const CHANGE_GAP: Duration = Duration::from_millis(250);
/// How far a column reaches under its lowest neighbour's top: its sides meet
/// theirs, and the edge of the map's data shows no wall down to the void.
pub const SKIRT: i32 = 8;

/// Where the player names the servers' maps (`Settings::servers`), beside
/// `horizon-graphics.txt`: kept out of the graphics settings, which shared
/// instances and modpacks carry, as a map the client asks for tiles around
/// the player (where they stand, which server) is the player's to name, not
/// a pack's.
pub const SERVERS_FILE: []const u8 = "horizon-bluemap.txt";
/// The player's BlueMap settings: `blueMapRadius:<chunks>` (or `<blocks>b`)
/// and `blueMapAutoDetect:true` in `horizon-graphics.txt`, and
/// `blueMap:<server address> <map URL> [<level>=<map id> ...]` per server in
/// `SERVERS_FILE`.
pub const Settings = struct {
    /// How far around the player tiles are downloaded, in chunks; 0 uses
    /// `DEFAULT_RADIUS`.
    radius: u32,
    /// Look for the map of a server no `blueMap:` line names.
    auto_detect: bool,
    servers: std.ArrayList(Server),
};
pub const DEFAULT_RADIUS: u32 = 64;
pub const Server = struct {
    address: []const u8,
    url: []const u8,
    /// `(level, map id)`: which of the server's maps draws which level;
    /// unnamed levels are guessed from the map ids (`pick_map`).
    maps: Vec<([]const u8,
};
    // rust: impl Settings {
    /// `blueMapRadius:`'s value: chunks, or blocks with a `b` (`2048b`).
pub fn parse_radius(value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = value.trim().to_ascii_lowercase();
    // rust: let blocks = value
    // rust: .strip_suffix("blocks")
    // rust: .or_else(|| value.strip_suffix('b'));
    // rust: let chunks = match blocks {
    // rust: Some(blocks) => blocks.trim().parse::<u32>().ok()?.div_ceil(16),
    // rust: None => value
    // rust: .strip_suffix("chunks")
    // rust: .unwrap_or(&value)
    // rust: .trim()
    // rust: .parse()
    // rust: .ok()?,
}
    // rust: Some(chunks.min(4096))
}
    /// A `blueMap:` line's value.
pub fn parse_server(value: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut words = value.split_whitespace();
    // rust: let address = words.next()?.to_owned();
    // rust: let url = words.next()?.to_owned();
    // rust: let maps = words
    // rust: .filter_map(|w| w.split_once('='))
    // rust: .map(|(level, map)| (level_key(level), map.to_owned()))
    // rust: .collect();
    // rust: Some(Server { address, url, maps })
}
    /// The `blueMap:` lines of `SERVERS_FILE`.
pub fn parse_servers(text: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
        // Notepad's "UTF-8 with BOM" would hide the first line.
    // rust: text.trim_start_matches('\u{feff}')
    // rust: .lines()
    // rust: .filter_map(|line| line.split_once(':'))
    // rust: .filter(|(key, _)| key.trim() == "blueMap")
    // rust: .filter_map(|(_, value)| Self::parse_server(value))
    // rust: .collect()
}
    /// What goes in `horizon-graphics.txt` (the servers don't).
pub fn serialize(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: "blueMapRadius:{}\nblueMapAutoDetect:{}\n",
    // rust: self.radius, self.auto_detect
    // rust: )
}
    /// The settings of the server at `address`, as typed to join it.
pub fn server(self: *Self, address: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let folder = crate::server_terrain::server_folder(address);
    // rust: self.servers
    // rust: .iter()
    // rust: .find(|s| crate::server_terrain::server_folder(&s.address) == folder)
}
pub fn radius_blocks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.radius_chunks() as i32 * 16
}
pub fn radius_chunks(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.radius == 0 {
    // rust: DEFAULT_RADIUS
    // rust: } else {
    // rust: self.radius
}
}
}

/// `nether` → `minecraft:the_nether`, `overworld` → `minecraft:overworld`.
pub fn level_key(level: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match level {
    // rust: "nether" => "minecraft:the_nether".into(),
    // rust: "end" => "minecraft:the_end".into(),
    // rust: _ if level.contains(':') => level.into(),
    // rust: _ => format!("minecraft:{level}"),
}
}

/// The map drawing `level` among the server's map ids: the player's choice,
/// else the first id naming the level's dimension (`world_nether`,
/// `end`...), the overworld's being the first that names neither.
pub fn pick_map(maps: *[[]const u8], level: []const u8, chosen: *[([]const u8) void {
}
    // rust: if let Some((_, map)) = chosen.iter().find(|(l, _)| *l == level) {
    // rust: return Some(map.clone());
}
    // rust: let named = |m: &&String, word: &str| m.to_ascii_lowercase().contains(word);
    // rust: match level {
    // rust: "minecraft:the_nether" => maps.iter().find(|m| named(m, "nether")),
    // rust: "minecraft:the_end" => maps.iter().find(|m| named(m, "end")),
    // rust: "minecraft:overworld" => maps
    // rust: .iter()
    // rust: .find(|m| !named(m, "nether") && !named(m, "end")),
    // rust: _ => None,
}
    // rust: .cloned()
}

/// The web app's `settings.json`: the map ids and where their data lies.
pub const Root = struct {
    maps: std.ArrayList([]const u8),
    data_root: []const u8,
};
    // rust: impl Root {
pub fn parse(json: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v: serde_json::Value = serde_json::from_slice(json).ok()?;
    // rust: let maps = v
    // rust: .get("maps")?
    // rust: .as_array()?
    // rust: .iter()
    // rust: .filter_map(|m| m.as_str().map(str::to_owned))
    // rust: .collect();
    // rust: let data_root = v
    // rust: .get("mapDataRoot")
    // rust: .and_then(|r| r.as_str())
    // rust: .unwrap_or("maps")
    // rust: .trim_matches('/')
    // rust: .to_owned();
    // rust: Some(Self { maps, data_root })
}
}

/// A map's `settings.json`, its lowres part (`MapSettingsSerializer`).
pub const Lowres = struct {
    tile: [i32,
    factor: i32,
    levels: u8,
};
    // rust: impl Lowres {
pub fn parse(json: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v: serde_json::Value = serde_json::from_slice(json).ok()?;
    // rust: let lowres = v.get("lowres")?;
    // rust: let size = lowres.get("tileSize").and_then(|s| s.as_array());
    // rust: let axis = |i: usize| {
    // rust: size.and_then(|s| s.get(i)?.as_i64()).map_or(Some(32), |n| {
    // rust: i32::try_from(n).ok().filter(|n| (1..=1024).contains(n))
    // rust: })
}
    // rust: let factor = lowres
    // rust: .get("lodFactor")
    // rust: .and_then(|f| f.as_i64())
    // rust: .unwrap_or(5);
    // rust: let levels = lowres.get("lodCount").and_then(|c| c.as_i64()).unwrap_or(3);
    // rust: let lowres = Self {
    // rust: tile: [axis(0)?, axis(1)?],
    // rust: factor: i32::try_from(factor)
    // rust: .ok()
    // rust: .filter(|f| (2..=64).contains(f))?,
    // rust: levels: u8::try_from(levels).ok().filter(|c| (1..=8).contains(c))?,
}
        // A tile packs `factor` of the level below on each axis: smaller ones
        // have no pixel for each, and the coarsest must span the world, no
        // more (block coordinates stay far from overflowing).
    // rust: let coarsest = lowres.factor.checked_pow(u32::from(lowres.levels) - 1)?;
    // rust: lowres
    // rust: .tile
    // rust: .iter()
    // rust: .all(|&size| {
    // rust: size >= lowres.factor && size.checked_mul(coarsest).is_some_and(|b| b <= 1 << 26)
    // rust: })
    // rust: .then_some(lowres)
}
    /// How many decoded tiles fit `MAX_TILE_BYTES`.
pub fn tiles_in_memory(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pixels = (self.tile[0] as usize + 1) * (self.tile[1] as usize + 1);
    // rust: (MAX_TILE_BYTES / (pixels * std::mem::size_of::<Pixel>())).max(16)
}
    /// Blocks a pixel of `level` (1 = finest) spans, about.
pub fn scale(self: *Self, level: u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.factor.saturating_pow(u32::from(level) - 1)
}
    /// The coarsest level whose pixels are no wider than `width` blocks.
pub fn level_for(self: *Self, width: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (1..=self.levels)
    // rust: .rev()
    // rust: .find(|&l| self.scale(l) <= width)
    // rust: .unwrap_or(1)
}
    /// The far-terrain cell widths drawn from `level`'s pixels, `(min, max)`:
    /// up to a chunk from level 1 (`BlueMap::chunk`), wider from `level_for`.
pub fn widths(self: *Self, level: u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let next = if level >= self.levels {
    // rust: i32::MAX
    // rust: } else {
    // rust: self.scale(level + 1) - 1
}
    // rust: if level <= 1 {
    // rust: (1, next.max(16))
    // rust: } else {
    // rust: (self.scale(level).max(17), next)
}
}
    /// The tile of `level` holding block coordinate `block` on one axis, and
    /// its pixel. Each level packs `factor` tiles of the one below into one,
    /// `size / factor` pixels a tile (`LowresLayer.saveTile`): a pixel past
    /// those (`size % factor` of them) is drawn with the last.
pub fn locate(self: *Self, axis: usize, level: u8, block: i32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = self.tile[axis];
    // rust: let groups = (size / self.factor).max(1);
    // rust: let (mut tile, mut pixel) = (block.div_euclid(size), block.rem_euclid(size));
    // rust: for _ in 1..level {
    // rust: let group = (pixel / self.factor).min(groups - 1);
    // rust: pixel = tile.rem_euclid(self.factor) * groups + group;
    // rust: tile = tile.div_euclid(self.factor);
}
    // rust: (tile, pixel as usize)
}
    /// The blocks of one axis a tile of `level` covers, `[min, max)`.
pub fn span(self: *Self, axis: usize, level: u8, tile: i32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let blocks = self.tile[axis].saturating_mul(self.scale(level));
    // rust: (
    // rust: tile.saturating_mul(blocks),
    // rust: (tile + 1).saturating_mul(blocks),
    // rust: )
}
}

/// `pathFromCoords`: `(12, -3)` → `x1/2/z-3`.
pub fn tile_path(x: i32, z: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let digits = |n: i32| {
    // rust: let mut out = String::new();
    // rust: if n < 0 {
    // rust: out.push('-');
}
    // rust: for c in n.unsigned_abs().to_string().chars() {
    // rust: out.push(c);
    // rust: out.push('/');
}
    // rust: out
}
    // rust: let mut path = format!("x{}z{}", digits(x), digits(z));
    // rust: path.pop();
    // rust: path
}

/// One column of a lowres tile.
pub const Pixel = struct {
    /// ARGB, straight alpha; 0 alpha: nothing was rendered there.
    color: u32,
    /// The highest block BlueMap drew.
    height: i16,
    block_light: u8,
};
pub const Tile = struct {
    width: usize,
    pixels: std.ArrayList(Pixel),
};
    // rust: impl Tile {
pub fn pixel(self: *Self, x: usize, z: usize) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pixels[z * self.width + x]
}
}

/// A lowres tile's PNG (gzipped too, as a misconfigured web server may send
/// it), `None` if it isn't one of `lowres`'s size.
pub fn decode_tile(bytes: []const u8, lowres: *Lowres) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let unzipped;
    // rust: let bytes = if bytes.starts_with(&[0x1f, 0x8b]) {
    // rust: unzipped = horizon_world::compression::Compression::Gzip
    // rust: .decode(bytes, 8 << 20)
    // rust: .ok()?;
    // rust: &unzipped[..]
    // rust: } else {
    // rust: bytes
}
    // rust: let mut decoder = png::Decoder::new(std::io::Cursor::new(bytes));
    // rust: decoder.set_transformations(png::Transformations::EXPAND | png::Transformations::STRIP_16);
    // rust: let mut reader = decoder.read_info().ok()?;
    // rust: let (width, height) = (lowres.tile[0] as usize + 1, lowres.tile[1] as usize + 1);
    // rust: let info = reader.info();
    // rust: if info.width as usize != width || info.height as usize != height * 2 {
    // rust: return None;
}
    // rust: let mut buf = vec![0; reader.output_buffer_size()?];
    // rust: let frame = reader.next_frame(&mut buf).ok()?;
    // rust: let channels = frame.color_type.samples();
    // rust: let rgba = |i: usize| -> [u8; 4] {
    // rust: let p = &buf[i * channels..(i + 1) * channels];
    // rust: match channels {
    // rust: 4 => [p[0], p[1], p[2], p[3]],
    // rust: 3 => [p[0], p[1], p[2], 255],
    // rust: 2 => [p[0], p[0], p[0], p[1]],
    // rust: _ => [p[0], p[0], p[0], 255],
}
}
    // rust: let pixels = (0..width * height)
    // rust: .map(|i| {
    // rust: let [r, g, b, a] = rgba(i);
    // rust: let [light, hi, lo, _] = rgba(i + width * height);
    // rust: Pixel {
    // rust: color: u32::from_be_bytes([a, r, g, b]),
                // No world reaches past ±2048 blocks (`DimensionType`).
    // rust: height: i16::from_be_bytes([hi, lo]).clamp(-2048, 2047),
    // rust: block_light: light,
}
    // rust: })
    // rust: .collect();
    // rust: Some(Tile { width, pixels })
}

/// What a lookup found: data, data on its way, or nothing to wait for.
pub const Found = enum {
    Ready(T),
    Waiting,
    Absent,
};

/// Block states a map colour is drawn with: the nearest of a few natural
/// blocks' colours as BlueMap renders them (their texture's mean, tinted with
/// each biome's grass, foliage and water colours).
pub const Palette = struct {
    candidates: std.ArrayList(Candidate),
    under: BlockStateId,
    deep: BlockStateId,
    matches: Mutex<FxHashMap<u32,
};
pub const Candidate = struct {
    rgb: [f32,
    top: BlockStateId,
    /// The few blocks under the top one (dirt under grass).
    under: ?BlockStateId,
    biome: u16,
    water: bool,
};
/// A biome's tints, for `Palette::new`.
pub const Tints = struct {
    id: u16,
    grass: u32,
    foliage: u32,
    water: u32,
};
/// Natural and common building blocks, with BlueMap's colour of each, about.
    // rust: const BLOCKS: &[(&str, u32)] = &[
    // rust: ("stone", 0x7E7E7E),
    // rust: ("deepslate", 0x505053),
    // rust: ("dirt", 0x866043),
    // rust: ("podzol", 0x5C3F18),
    // rust: ("mycelium", 0x6F6369),
    // rust: ("sand", 0xDBCFA3),
    // rust: ("red_sand", 0xBE6621),
    // rust: ("gravel", 0x847F7F),
    // rust: ("clay", 0xA0A6B3),
    // rust: ("snow_block", 0xF5FAFA),
    // rust: ("ice", 0x91B7FD),
    // rust: ("terracotta", 0x985E44),
    // rust: ("orange_terracotta", 0xA25426),
    // rust: ("yellow_terracotta", 0xBA8523),
    // rust: ("white_terracotta", 0xD2B2A1),
    // rust: ("brown_terracotta", 0x4D3324),
    // rust: ("red_terracotta", 0x8F3D2F),
    // rust: ("light_gray_terracotta", 0x876B62),
    // rust: ("moss_block", 0x596E2D),
    // rust: ("mud", 0x3C3A3D),
    // rust: ("netherrack", 0x622626),
    // rust: ("crimson_nylium", 0x831F1F),
    // rust: ("warped_nylium", 0x2B7265),
    // rust: ("soul_sand", 0x513E33),
    // rust: ("basalt", 0x505155),
    // rust: ("blackstone", 0x2A2328),
    // rust: ("magma_block", 0x8E3F1F),
    // rust: ("lava", 0xCF5B13),
    // rust: ("end_stone", 0xDBDEA1),
    // rust: ("obsidian", 0x0F0A18),
    // rust: ("oak_planks", 0xA2834F),
    // rust: ("spruce_planks", 0x735531),
    // rust: ("dark_oak_planks", 0x432B14),
    // rust: ("bricks", 0x976253),
    // rust: ("smooth_stone", 0x9F9F9F),
    // rust: ("quartz_block", 0xEBE5DE),
    // rust: ("white_concrete", 0xCFD5D6),
    // rust: ("light_gray_concrete", 0x7D7D73),
    // rust: ("gray_concrete", 0x373A3E),
    // rust: ("black_concrete", 0x080A0F),
    // rust: ("red_concrete", 0x8E2121),
    // rust: ("blue_concrete", 0x2D2F8F),
    // rust: ("spruce_leaves", 0x304C30),
    // rust: ("birch_leaves", 0x40532A),
    // rust: ];
/// The mean grey of grass_block_top, the leaves and water_still, which the
/// biome colours tint.
pub const GRASS_GREY: f32 = 0.6;
pub const LEAVES_GREY: f32 = 0.5;
pub const WATER_GREY: f32 = 0.7;

pub fn rgb(color: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [16, 8, 0].map(|s| ((color >> s) & 255) as f32)
}
    // rust: impl Palette {
    // rust: pub fn new(
    // rust: state: impl Fn(&str) -> Option<BlockStateId>,
    // rust: biomes: &[Tints],
    // rust: plains: u16,
    // rust: ) -> Self {
    // rust: let block = |name: &str| state(&format!("minecraft:{name}"));
    // rust: let mut candidates = Vec::new();
    // rust: let dirt = block("dirt");
    // rust: for &(name, color) in BLOCKS {
    // rust: if let Some(top) = block(name) {
    // rust: let under = matches!(name, "podzol" | "mycelium" | "snow_block").then_some(dirt);
    // rust: candidates.push(Candidate {
    // rust: rgb: rgb(color),
    // rust: top,
    // rust: under: under.flatten(),
    // rust: biome: plains,
    // rust: water: false,
    // rust: });
}
}
    // rust: let tinted = |tint: u32, grey: f32| rgb(tint).map(|c| c * grey);
    // rust: let mut seen = FxHashSet::default();
    // rust: for b in biomes {
    // rust: for (state, color, under, water) in [
    // rust: (
    // rust: block("grass_block"),
    // rust: tinted(b.grass, GRASS_GREY),
    // rust: dirt,
    // rust: false,
    // rust: ),
    // rust: (
    // rust: block("oak_leaves"),
    // rust: tinted(b.foliage, LEAVES_GREY),
    // rust: None,
    // rust: false,
    // rust: ),
    // rust: (block("water"), tinted(b.water, WATER_GREY), None, true),
    // rust: ] {
    // rust: let key = (color.map(|c| c as u32), water, under.is_some());
    // rust: if let Some(top) = state
    // rust: && seen.insert(key)
    // rust: {
    // rust: candidates.push(Candidate {
    // rust: rgb: color,
    // rust: top,
    // rust: under,
    // rust: biome: b.id,
    // rust: water,
    // rust: });
}
}
}
    // rust: Self {
    // rust: candidates,
    // rust: under: block("sand").unwrap_or(BlockStateId(0)),
    // rust: deep: block("stone").unwrap_or(BlockStateId(0)),
    // rust: matches: Mutex::default(),
}
}
pub fn from_game(registry: *BlockRegistry, biomes: *Biomes) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tints: Vec<_> = biomes
    // rust: .list
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(id, b)| Tints {
    // rust: id: id as u16,
    // rust: grass: b.grass,
    // rust: foliage: b.foliage,
    // rust: water: b.water,
    // rust: })
    // rust: .collect();
    // rust: Self::new(
    // rust: |name| registry.default_state(name),
    // rust: &tints,
    // rust: biomes.id("minecraft:plains"),
    // rust: )
}
    /// `matches`: `self.matches`, locked once by the caller for many pixels.
pub fn nearest(self: *Self, matches: *mut FxHashMap<u32, color: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = color & 0xFF_FFFF;
    // rust: if matches.len() > 1 << 16 {
    // rust: matches.clear();
}
    // rust: let index = *matches.entry(key).or_insert_with(|| {
    // rust: let want = rgb(key);
    // rust: let distance = |c: &Candidate| {
                // Weighted towards green, as the eye is (a "redmean"-ish norm).
    // rust: let d = [0, 1, 2].map(|i| c.rgb[i] - want[i]);
    // rust: 2.0 * d[0] * d[0] + 4.0 * d[1] * d[1] + 3.0 * d[2] * d[2]
}
    // rust: (0..self.candidates.len())
    // rust: .min_by(|&a, &b| {
    // rust: distance(&self.candidates[a]).total_cmp(&distance(&self.candidates[b]))
    // rust: })
    // rust: .unwrap_or(usize::MAX)
    // rust: });
    // rust: self.candidates.get(index).copied()
}
    /// A pixel as a far-terrain column: its top block at its height, a few
    /// blocks under it, then stone; water over sand. `low`: the lowest top
    /// of it and its neighbours; the stone ends `SKIRT` under it, not at the
    /// bottom of the world (a wall where the map's data ends).
pub fn column(self: *Self, pixel: Pixel, low: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.column_in(&mut self.matches.lock().unwrap(), pixel, low)
}
    /// Columns of many pixels, `(pixel, low)` each, matched under one lock.
    // rust: fn columns<const N: usize>(&self, pixels: [Option<(Pixel, i32)>; N]) -> [Column; N] {
    // rust: let mut matches = self.matches.lock().unwrap();
    // rust: pixels.map(|p| {
    // rust: p.map_or_else(Column::default, |(p, low)| {
    // rust: self.column_in(&mut matches, p, low)
    // rust: })
    // rust: })
}
pub fn column_in(self: *Self, matches: *mut FxHashMap<u32, pixel: Pixel, low: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if pixel.color >> 24 == 0 {
    // rust: return Column::default();
}
    // rust: let Some(c) = self.nearest(matches, pixel.color) else {
    // rust: return Column::default();
}
    // rust: let top = i32::from(pixel.height) + 1;
    // rust: let bottom = low.min(top) - SKIRT;
    // rust: let light = 240 | u16::from(pixel.block_light.min(15)) << 12;
    // rust: let mut column = Column::default();
    // rust: let mut push = |min: i32, max: i32, state: BlockStateId| {
    // rust: let (min, max) = (min.max(MIN_Y), max.max(MIN_Y));
    // rust: if min < max {
    // rust: column.push(Span {
    // rust: min: min as i16,
    // rust: max: max as i16,
    // rust: state,
    // rust: biome: c.biome,
    // rust: light,
    // rust: });
}
}
    // rust: if c.water {
    // rust: let floor = top - 3;
    // rust: push(bottom.min(floor - 4), floor - 3, self.deep);
    // rust: push(floor - 3, floor, self.under);
    // rust: push(floor, top, c.top);
    // rust: column.surface = Some(crate::lod::Surface {
    // rust: height: floor,
    // rust: state: self.under,
    // rust: water: Some((top, c.top)),
    // rust: biome: c.biome,
    // rust: });
    // rust: } else {
    // rust: let under = c.under.unwrap_or(c.top);
    // rust: push(bottom.min(top - 5), top - 4, self.deep);
    // rust: push(top - 4, top - 1, under);
    // rust: push(top - 1, top, c.top);
    // rust: column.surface = Some(crate::lod::Surface {
    // rust: height: top,
    // rust: state: c.top,
    // rust: water: None,
    // rust: biome: c.biome,
    // rust: });
}
    // rust: column
}
}

    // rust: type Key = (u8, i32, i32);
    // rust: type Columns = Arc<[Column; 256]>;
/// The level's map: its id, its folder on the server and its lowres layout.
pub const MapInfo = struct {
    id: []const u8,
    root: []const u8,
    lowres: Lowres,
};
    // rust: impl Slot {
pub fn found(self: *Self) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Slot::Ready(tile) => Found::Ready(tile.clone()),
    // rust: Slot::Missing | Slot::Unreached => Found::Absent,
    // rust: Slot::Waiting => Found::Waiting,
}
}
}
pub const Slot = enum {
    Ready(Arc<Tile>),
    Missing,
    Waiting,
    /// Not cached, and out of reach or the server down when looked up:
    /// wanted when that changes (`State::reach`); level 1's are stood in
    /// for by the coarser levels meanwhile (`BlueMap::chunk`).
    Unreached,
};
/// What the map knows of the server, and what it wants from it.
pub const State = struct {
    map: ?*MapInfo,
    tiles: FxHashMap<Key,
    chunks: FxHashMap<(i32,
    queue: FxHashSet<Key>,
    center: Option<[i32,
    /// Where `center` was when the tiles come into reach were last wanted.
    anchor: Option<[i32,
    /// The server failed the last request: nothing waits for it until then.
    offline_until: ?Instant,
    /// What arrived (`take_changed`).
    changed: std.ArrayList(Change),
    /// When `take_changed` last handed something over.
    taken_at: ?Instant,
    /// Bumped when a tile arrives or the map changes: a chunk built from
    /// what was there before isn't kept (`BlueMap::chunk`).
    generation: u64,
};
/// Data arrived for the blocks `area` `[x0, z0, x1, z1)`, drawn in far-terrain
/// cells `widths` `(min, max)` blocks wide.
pub const Change = struct {
    area: [i32,
    widths: (i32,
};
pub const Inner = struct {
    /// The map's web address; unset while it is looked for at `probes`.
    base: OnceLock<[]const u8>,
    probes: std.ArrayList([]const u8),
    level: []const u8,
    chosen: Vec<([]const u8,
    dir: PathBuf,
    radius: i32,
    palette: Palette,
    state: Mutex<State>,
    wake: Condvar,
};
/// One level's BlueMap: tiles are read from the disk cache on the far-terrain
/// threads and downloaded on a worker of its own.
pub const BlueMap = struct {
    inner: *Inner,
};

/// `https://map.example.net/#world:0:64:0...` → `https://map.example.net`.
pub fn base_url(url: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let url = url.trim();
    // rust: let url = url.split(['#', '?']).next().unwrap_or(url);
    // rust: let url = url.strip_suffix("index.html").unwrap_or(url);
    // rust: url.trim_end_matches('/').to_owned()
}

    // rust: impl BlueMap {
    /// The map of `level` at `url`, its tiles cached in `dir`; nothing is
    /// downloaded until `start`.
    // rust: pub fn new(
    // rust: url: &str,
    // rust: level: &str,
    // rust: chosen: Vec<(String, String)>,
    // rust: dir: PathBuf,
    // rust: radius_blocks: i32,
    // rust: palette: Palette,
    // rust: ) -> Self {
    // rust: let base = OnceLock::from(base_url(url));
    // rust: Self::build(base, Vec::new(), level, chosen, dir, radius_blocks, palette)
}
    /// The map of `level`, looked for at `probes` (`bluemap_detect`) first:
    /// lookups find nothing new until it is found.
    // rust: pub fn detect(
    // rust: probes: Vec<String>,
    // rust: level: &str,
    // rust: dir: PathBuf,
    // rust: radius_blocks: i32,
    // rust: palette: Palette,
    // rust: ) -> Self {
    // rust: let probes = probes.iter().map(|p| base_url(p)).collect();
    // rust: let base = OnceLock::new();
    // rust: Self::build(base, probes, level, Vec::new(), dir, radius_blocks, palette)
}
    /// The map from where `source` says.
    // rust: pub fn from_source(
    // rust: source: crate::bluemap_detect::Source,
    // rust: level: &str,
    // rust: dir: PathBuf,
    // rust: radius_blocks: i32,
    // rust: palette: Palette,
    // rust: ) -> Self {
//         use crate::bluemap_detect::Source;
    // rust: match source {
    // rust: Source::Url { url, maps } => Self::new(&url, level, maps, dir, radius_blocks, palette),
    // rust: Source::Detect(probes) => Self::detect(probes, level, dir, radius_blocks, palette),
}
}
    // rust: fn build(
    // rust: base: OnceLock<String>,
    // rust: probes: Vec<String>,
    // rust: level: &str,
    // rust: chosen: Vec<(String, String)>,
    // rust: dir: PathBuf,
    // rust: radius_blocks: i32,
    // rust: palette: Palette,
    // rust: ) -> Self {
    // rust: let inner = Arc::new(Inner {
    // rust: base,
    // rust: probes,
    // rust: level: level.into(),
    // rust: chosen,
    // rust: dir,
    // rust: radius: radius_blocks,
    // rust: palette,
    // rust: state: Mutex::default(),
    // rust: wake: Condvar::new(),
    // rust: });
    // rust: let map = inner.map_info(|_, name| std::fs::read(inner.dir.join(name)).ok());
    // rust: inner.state.lock().unwrap().map = map.map(Arc::new);
    // rust: Self { inner }
}
    /// Downloads what lookups want, on a thread that ends with the map.
pub fn start(self: *Self) void {
}
    // rust: let inner = Arc::downgrade(&self.inner);
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("BlueMap".into())
    // rust: .spawn(move || fetch(inner));
    // rust: if let Err(e) = spawned {
    // rust: log::warn!("Horizon: BlueMap worker: {e}");
}
}
    /// The player's block position: tiles are downloaded around it. Called
    /// every frame: it only wants the tiles come into reach, once the player
    /// has moved a step, and changes no far terrain (their data will).
pub fn set_center(self: *Self, x: i32, z: i32) void {
}
    // rust: let mut state = self.inner.state.lock().unwrap();
    // rust: state.center = Some([x, z]);
    // rust: let step = (self.inner.radius / 4).max(64);
    // rust: let moved = state
    // rust: .anchor
    // rust: .is_none_or(|[ax, az]| (x - ax).abs() >= step || (z - az).abs() >= step);
    // rust: if moved {
    // rust: state.anchor = Some([x, z]);
    // rust: state.reach(self.inner.radius, &self.inner.wake);
}
}
    /// What arrived since the last call, at most every `CHANGE_GAP`: far
    /// terrain samples it again.
pub fn take_changed(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut state = self.inner.state.lock().unwrap();
    // rust: if state.changed.is_empty() || state.taken_at.is_some_and(|t| t.elapsed() < CHANGE_GAP) {
    // rust: return Vec::new();
}
    // rust: state.taken_at = Some(Instant::now());
    // rust: std::mem::take(&mut state.changed)
}
    /// A chunk's columns from the finest level, the coarser levels standing
    /// in where its tile is out of reach (`coarser_column`).
pub fn chunk(self: *Self, cx: i32, cz: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (map, generation) = {
    // rust: let state = self.inner.state.lock().unwrap();
    // rust: if let Some(columns) = state.chunks.get(&(cx, cz)) {
    // rust: return Found::Ready(columns.clone());
}
    // rust: let Some(map) = state.map.clone() else {
    // rust: return Found::Absent;
}
    // rust: (map, state.generation)
}
        // The chunk's pixels and a ring around (their tops bound its depth).
    // rust: let mut last = None;
    // rust: let mut ring = [None; 18 * 18];
        // Columns whose finest tile is out of reach (not one the server has
        // none of): the coarser levels, which reach farther, stand in.
    // rust: let mut unreached = [false; 256];
    // rust: for (i, slot) in ring.iter_mut().enumerate() {
    // rust: let (dx, dz) = ((i % 18) as i32 - 1, (i / 18) as i32 - 1);
    // rust: let inside = (0..16).contains(&dx) && (0..16).contains(&dz);
    // rust: let (x, z) = (cx * 16 + dx, cz * 16 + dz);
    // rust: match self.inner.pixel(&map, &mut last, 1, x, z) {
    // rust: Found::Ready(pixel) => *slot = Some(pixel).filter(|p| p.color >> 24 != 0),
                // A neighbour on its way only bounds the depth when here.
    // rust: Found::Waiting if inside => return Found::Waiting,
    // rust: Found::Absent if inside => {
    // rust: unreached[(dz * 16 + dx) as usize] = self.inner.unreached(&map, 1, x, z)
}
    // rust: _ => {}
}
}
    // rust: if !unreached.contains(&true)
    // rust: && !ring.iter().enumerate().any(|(i, p)| {
    // rust: p.is_some() && (1..17).contains(&(i % 18)) && (1..17).contains(&(i / 18))
    // rust: })
    // rust: {
    // rust: return Found::Absent;
}
    // rust: let top = |i: usize| ring[i].map(|p| i32::from(p.height) + 1);
    // rust: let pixels: [_; 256] = std::array::from_fn(|i| {
    // rust: let at = (i / 16 + 1) * 18 + i % 16 + 1;
    // rust: let pixel = ring[at]?;
    // rust: let low = [at - 1, at + 1, at - 18, at + 18]
    // rust: .into_iter()
    // rust: .filter_map(top)
    // rust: .fold(i32::from(pixel.height) + 1, i32::min);
    // rust: Some((pixel, low))
    // rust: });
    // rust: let mut columns = self.inner.palette.columns(pixels);
    // rust: let mut found = pixels.iter().any(Option::is_some);
    // rust: for (i, column) in columns.iter_mut().enumerate() {
    // rust: if unreached[i] {
    // rust: let (x, z) = (cx * 16 + (i % 16) as i32, cz * 16 + (i / 16) as i32);
    // rust: match self.coarser_column(x, z) {
    // rust: Found::Ready(coarse) => {
    // rust: *column = coarse;
    // rust: found = true;
}
    // rust: Found::Waiting => return Found::Waiting,
    // rust: Found::Absent => {}
}
}
}
    // rust: if !found {
    // rust: return Found::Absent;
}
    // rust: let columns = Arc::new(columns);
    // rust: let mut state = self.inner.state.lock().unwrap();
        // Built from tiles since replaced: drawn this once, not kept.
    // rust: if state.generation != generation {
    // rust: return Found::Ready(columns);
}
    // rust: if state.chunks.len() >= MAX_CHUNKS {
    // rust: state.chunks.clear();
}
    // rust: state.chunks.insert((cx, cz), columns.clone());
    // rust: Found::Ready(columns)
}
    /// The column of a far-terrain cell `width` blocks wide, from the
    /// coarsest level fine enough for it.
pub fn reduced_column(self: *Self, x: i32, z: i32, width: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(map) = self.inner.state.lock().unwrap().map.clone() else {
    // rust: return Found::Absent;
}
    // rust: let level = map.lowres.level_for(width);
    // rust: self.column_at(&map, level, x + width / 2, z + width / 2, width)
}
    /// Block (x, z)'s column from the finest of the coarser levels (2 and
    /// up) that has it: drawn while level 1 is on its way or out of reach
    /// (`chunk`, and the sampler's `coarser`).
pub fn coarser_column(self: *Self, x: i32, z: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(map) = self.inner.state.lock().unwrap().map.clone() else {
    // rust: return Found::Absent;
}
    // rust: let mut found = Found::Absent;
    // rust: for level in 2..=map.lowres.levels {
    // rust: match self.column_at(&map, level, x, z, map.lowres.scale(level)) {
    // rust: Found::Ready(column) => return Found::Ready(column),
    // rust: Found::Waiting => found = Found::Waiting,
    // rust: Found::Absent => {}
}
}
    // rust: found
}
    /// The column of `level`'s pixel at block (x, z), its depth bound by the
    /// pixels `width` blocks each way.
pub fn column_at(self: *Self, map: *MapInfo, level: u8, x: i32, z: i32, width: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut last = None;
    // rust: let pixel = match self.inner.pixel(map, &mut last, level, x, z) {
    // rust: Found::Ready(pixel) => pixel,
    // rust: Found::Waiting => return Found::Waiting,
    // rust: Found::Absent => return Found::Absent,
}
        // The neighbouring cells' middles bound its depth.
    // rust: let low = [(-width, 0), (width, 0), (0, -width), (0, width)]
    // rust: .into_iter()
    // rust: .filter_map(
    // rust: |(dx, dz)| match self.inner.pixel(map, &mut last, level, x + dx, z + dz) {
    // rust: Found::Ready(p) if p.color >> 24 != 0 => Some(i32::from(p.height) + 1),
    // rust: _ => None,
    // rust: },
    // rust: )
    // rust: .fold(i32::from(pixel.height) + 1, i32::min);
    // rust: Found::Ready(self.inner.palette.column(pixel, low))
}
}

/// The tile a lookup used last (a chunk's 256 columns mostly share one).
    // rust: type Last = Option<(Key, Option<Arc<Tile>>)>;

    // rust: impl State {
pub fn announce(self: *Self, change: Change) void {
}
    // rust: if self.changed.len() >= 256 {
    // rust: let all = self.changed.drain(..).fold(change, |a, b| Change {
    // rust: area: [
    // rust: a.area[0].min(b.area[0]),
    // rust: a.area[1].min(b.area[1]),
    // rust: a.area[2].max(b.area[2]),
    // rust: a.area[3].max(b.area[3]),
    // rust: ],
    // rust: widths: (a.widths.0.min(b.widths.0), a.widths.1.max(b.widths.1)),
    // rust: });
    // rust: self.changed.push(all);
    // rust: } else {
    // rust: self.changed.push(change);
}
}
    /// Past the world border (30 million blocks), with room to spare.
pub const WORLD: i32 = 1 << 26;
    /// Everything may differ (a new map, none): far terrain samples again
    /// all it drew from the map, cached tiles reach past the download radius.
pub fn announce_all(self: *Self) void {
}
    // rust: self.announce(Change {
            // The world's width, with room for `Lod::refresh` to widen it.
    // rust: area: [-Self::WORLD, -Self::WORLD, Self::WORLD, Self::WORLD],
    // rust: widths: (1, i32::MAX),
    // rust: });
}
    /// How far a tile is from the player, squared, if in reach.
pub fn near(self: *Self, lowres: *Lowres, key: Key, radius: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, z] = self.center?;
    // rust: let (x0, x1) = lowres.span(0, key.0, key.1);
    // rust: let (z0, z1) = lowres.span(1, key.0, key.2);
    // rust: let dx = (x0 - x).max(x - x1).max(0);
    // rust: let dz = (z0 - z).max(z - z1).max(0);
    // rust: (dx.max(dz) <= radius).then(|| i64::from(dx).pow(2) + i64::from(dz).pow(2))
}
pub fn online(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.offline_until.is_none_or(|t| t <= Instant::now())
}
    /// Wants `key` from the server, if it can: else it is `Unreached`.
pub fn want(self: *Self, key: Key, wake: *Condvar) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let queued = self.queue.len() < MAX_QUEUE || self.queue.contains(&key);
    // rust: if queued {
    // rust: self.queue.insert(key);
    // rust: wake.notify_one();
}
    // rust: self.tiles.insert(
    // rust: key,
    // rust: if queued {
    // rust: Slot::Waiting
    // rust: } else {
    // rust: Slot::Unreached
    // rust: },
    // rust: );
    // rust: queued
}
    /// Wants the `Unreached` tiles now in reach, the server answering.
pub fn reach(self: *Self, radius: i32, wake: *Condvar) void {
}
    // rust: let Some(map) = self.map.clone().filter(|_| self.online()) else {
    // rust: return;
}
    // rust: let reached: Vec<Key> = self
    // rust: .tiles
    // rust: .iter()
    // rust: .filter(|(key, slot)| {
    // rust: matches!(slot, Slot::Unreached) && self.near(&map.lowres, **key, radius).is_some()
    // rust: })
    // rust: .map(|(key, _)| *key)
    // rust: .collect();
    // rust: for key in reached {
    // rust: if !self.want(key, wake) {
    // rust: break;
}
}
}
}

    // rust: impl Inner {
    /// The level's map from settings files, cached or downloaded: `get`
    /// takes a file's path on the server and its name in the cache (the
    /// server's names never pick a path here).
pub fn map_info(self: *Self, mut get: impl FnMut([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = Root::parse(&get("settings.json", "settings.json")?)?;
    // rust: let id = pick_map(&root.maps, &self.level, &self.chosen)?;
    // rust: let lowres = Lowres::parse(&get(
    // rust: &format!("{}/{id}/settings.json", root.data_root),
    // rust: &format!("{}.json", crate::server_terrain::server_folder(&id)),
    // rust: )?)?;
    // rust: Some(MapInfo {
    // rust: id,
    // rust: root: root.data_root,
    // rust: lowres,
    // rust: })
}
pub fn tile_file(self: *Self, map: *MapInfo) void {
}
    // rust: self.dir
    // rust: .join(crate::server_terrain::server_folder(&map.id))
    // rust: .join(level.to_string())
    // rust: .join(format!("{x}_{z}"))
}
    /// Whether block (x, z)'s tile of `level` is out of reach (`Slot::Unreached`).
pub fn unreached(self: *Self, map: *MapInfo, level: u8, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tx, _) = map.lowres.locate(0, level, x);
    // rust: let (tz, _) = map.lowres.locate(1, level, z);
    // rust: matches!(
    // rust: self.state.lock().unwrap().tiles.get(&(level, tx, tz)),
    // rust: Some(Slot::Unreached)
    // rust: )
}
pub fn pixel(self: *Self, map: *MapInfo, last: *mut Last, level: u8, x: i32, z: i32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let level = level.min(map.lowres.levels);
    // rust: let (tx, px) = map.lowres.locate(0, level, x);
    // rust: let (tz, pz) = map.lowres.locate(1, level, z);
    // rust: let key = (level, tx, tz);
    // rust: let tile = match last {
    // rust: Some((k, tile)) if *k == key => tile.clone(),
    // rust: _ => {
    // rust: let tile = match self.tile(map, key) {
    // rust: Found::Ready(tile) => Some(tile),
    // rust: Found::Waiting => return Found::Waiting,
    // rust: Found::Absent => None,
}
    // rust: *last = Some((key, tile.clone()));
    // rust: tile
}
}
    // rust: tile.map_or(Found::Absent, |t| Found::Ready(t.pixel(px, pz)))
}
    /// A tile from memory, else the disk cache, else wanted from the server
    /// when it is in reach.
pub fn tile(self: *Self, map: *MapInfo, key: Key) F {
    // Implementation ported from Horizon
    return undefined;
}
        // Tiles are of the map in `state`: a lookup of an older one (new
        // settings came meanwhile) would read them with the wrong layout.
    // rust: let current = |state: &State| {
    // rust: state
    // rust: .map
    // rust: .as_deref()
    // rust: .is_some_and(|now| std::ptr::eq(now, map))
}
    // rust: {
    // rust: let state = self.state.lock().unwrap();
    // rust: if !current(&state) {
    // rust: return Found::Absent;
}
    // rust: if let Some(slot) = state.tiles.get(&key) {
    // rust: return slot.found();
}
}
    // rust: let cached = read_cached(&self.tile_file(map, key), &map.lowres);
    // rust: let mut state = self.state.lock().unwrap();
    // rust: if !current(&state) {
    // rust: return Found::Absent;
}
        // Another thread, or the download, put it in meanwhile: theirs.
    // rust: if let Some(slot) = state.tiles.get(&key) {
    // rust: return slot.found();
}
    // rust: let ready = state
    // rust: .tiles
    // rust: .values()
    // rust: .filter(|slot| matches!(slot, Slot::Ready(_)))
    // rust: .count();
    // rust: if state.tiles.len() >= MAX_TILES || ready >= map.lowres.tiles_in_memory() {
    // rust: state
    // rust: .tiles
    // rust: .retain(|_, slot| matches!(slot, Slot::Waiting | Slot::Unreached));
    // rust: if state.tiles.len() >= MAX_TILES {
    // rust: state.tiles.retain(|_, slot| matches!(slot, Slot::Waiting));
}
}
    // rust: let reachable = state.near(&map.lowres, key, self.radius).is_some() && state.online();
    // rust: match cached {
    // rust: Some((tile, fresh)) => {
    // rust: if !fresh && reachable && state.queue.len() < MAX_QUEUE && state.queue.insert(key) {
    // rust: self.wake.notify_one();
}
    // rust: let tile = tile.map(Arc::new);
    // rust: let slot = tile.clone().map_or(Slot::Missing, Slot::Ready);
    // rust: state.tiles.insert(key, slot);
    // rust: tile.map_or(Found::Absent, Found::Ready)
}
    // rust: None if reachable && state.want(key, &self.wake) => Found::Waiting,
    // rust: None => {
    // rust: state.tiles.insert(key, Slot::Unreached);
    // rust: Found::Absent
}
}
}
}
/// Writes a file whole or not at all: a crash or a full disk mid-write
/// leaves the old one (or none), never half a tile.
pub fn write_whole(path: *Path, bytes: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut part = path.as_os_str().to_owned();
    // rust: part.push(".part");
    // rust: std::fs::write(&part, bytes)?;
    // rust: std::fs::rename(&part, path)
}
/// A cached tile (`None` inside: the server has none there) and whether it
/// is fresh; `None`: not cached.
pub fn read_cached(file: *Path, lowres: *Lowres) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fresh = |path: &Path| {
    // rust: std::fs::metadata(path)
    // rust: .and_then(|m| m.modified())
    // rust: .ok()
    // rust: .and_then(|t| SystemTime::now().duration_since(t).ok())
    // rust: .is_some_and(|age| age < MAX_AGE)
}
    // One that doesn't decode (cut short, or of an older `tileSize`) is
    // fetched again: the worker keeps only those that do.
    // rust: let png = file.with_extension("png");
    // rust: if let Ok(bytes) = std::fs::read(&png) {
    // rust: return decode_tile(&bytes, lowres).map(|tile| (Some(tile), fresh(&png)));
}
    // rust: let none = file.with_extension("none");
    // rust: none.exists().then(|| (None, fresh(&none)))
}

/// The download worker's own state.
pub const Worker = struct {
    agent: ureq::Agent,
    backoff: Duration,
    /// Bytes in the disk cache, counted on the first download.
    disk: ?u64,
    /// The settings were fetched on this visit.
    settings: bool,
    /// Candidates tried while looking for the map, and the right to look.
    probed: usize,
    claim: ?crate::bluemap_detect::Claim,
    /// Nothing more to do: no map was found.
    done: bool,
};

/// The download worker: settings first, then the wanted tile nearest the
/// player, one request at a time. A failure leaves the server alone for a
/// while, and lookups stop waiting for it meanwhile.
pub fn fetch(inner: Weak<Inner>) void {
}
    // rust: let mut worker = Worker {
    // rust: agent: ureq::AgentBuilder::new()
    // rust: .timeout(Duration::from_secs(10))
    // rust: .user_agent(&format!("Horizon/{}", horizon_core::release::VERSION))
    // rust: .build(),
    // rust: backoff: BACKOFF,
    // rust: disk: None,
    // rust: settings: false,
    // rust: probed: 0,
    // rust: claim: None,
    // rust: done: false,
}
    // rust: while !worker.done {
    // rust: let Some(inner) = inner.upgrade() else { return };
    // rust: let pause = worker.step(&inner);
    // rust: drop(inner);
    // rust: if !pause.is_zero() {
    // rust: std::thread::sleep(pause);
}
}
}

    // rust: impl Worker {
    /// `Err`: the server didn't answer; `Ok(None)`: it has nothing there.
pub fn get(self: *Self, inner: *Inner, path: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::io::Read;
    // rust: let base = inner.base.get().ok_or(())?;
    // rust: match self.agent.get(&format!("{base}/{path}")).call() {
    // rust: Ok(response) if response.status() == 204 => Ok(None),
    // rust: Ok(response) => {
    // rust: let mut body = Vec::new();
    // rust: response
    // rust: .into_reader()
    // rust: .take(8 << 20)
    // rust: .read_to_end(&mut body)
    // rust: .map_err(|_| ())?;
    // rust: Ok(Some(body))
}
    // rust: Err(ureq::Error::Status(404, _)) => Ok(None),
    // rust: Err(_) => Err(()),
}
}
pub fn failed(self: *Self, inner: *Inner) void {
}
    // rust: let mut state = inner.state.lock().unwrap();
    // rust: state.offline_until = Some(Instant::now() + self.backoff);
        // What waited for the server won't come: it is drawn without, and
        // wanted again once the server is given another try (`step`).
    // rust: for slot in state.tiles.values_mut() {
    // rust: if matches!(slot, Slot::Waiting) {
    // rust: *slot = Slot::Unreached;
}
}
    // rust: state.queue.clear();
    // rust: let base = inner.base.get().map_or("", String::as_str);
    // rust: log::debug!("Horizon: BlueMap at {base} isn't answering");
    // rust: self.backoff = (self.backoff * 2).min(MAX_BACKOFF);
}
pub fn answered(self: *Self) void {
}
    // rust: self.backoff = BACKOFF;
}
    /// One request, or a wait for one; how long to pause after it.
pub fn step(self: *Self, inner: *Inner) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: {
    // rust: let mut state = inner.state.lock().unwrap();
    // rust: if let Some(until) = state.offline_until {
    // rust: if let Some(wait) = until.checked_duration_since(Instant::now()) {
    // rust: return wait.min(Duration::from_secs(1));
}
                // Another try: what lookups found missing meanwhile is wanted.
    // rust: state.offline_until = None;
    // rust: state.reach(inner.radius, &inner.wake);
}
}
    // rust: if inner.base.get().is_none() {
    // rust: return self.look(inner);
}
    // rust: let started = Instant::now();
        // The settings, once a visit: the cached ones serve until then.
    // rust: if !self.settings {
    // rust: let mut files = Vec::new();
    // rust: let mut unanswered = false;
    // rust: let map = inner.map_info(|path, name| {
    // rust: let body = self.get(inner, path).unwrap_or_else(|()| {
    // rust: unanswered = true;
    // rust: None
    // rust: })?;
    // rust: files.push((name.to_owned(), body.clone()));
    // rust: Some(body)
    // rust: });
    // rust: let Some(map) = map else {
                // The server answered, with no map of this level: nothing to
                // wait for on this visit.
    // rust: if !unanswered {
    // rust: self.answered();
    // rust: return self.found_nothing(inner);
}
    // rust: self.failed(inner);
    // rust: return Duration::ZERO;
}
    // rust: let (changed, stale) = {
    // rust: let state = inner.state.lock().unwrap();
    // rust: let old = state.map.as_deref();
    // rust: (
    // rust: old != Some(&map),
    // rust: old.is_some_and(|old| old != &map && old.id == map.id),
    // rust: )
}
            // Tiles cut for other lowres settings would be read wrong: gone
            // before the new settings are kept, or they'd pass for theirs.
    // rust: let tiles = inner
    // rust: .dir
    // rust: .join(crate::server_terrain::server_folder(&map.id));
    // rust: self.settings = true;
    // rust: self.answered();
            // Not gone (a file held open): no map this visit, not the wrong one.
    // rust: if stale && std::fs::remove_dir_all(&tiles).is_err() && tiles.exists() {
    // rust: return self.found_nothing(inner);
}
    // rust: for (name, body) in files {
    // rust: let _ = std::fs::create_dir_all(&inner.dir);
                // Not kept (a file held open): none cached rather than the
                // old, which would read the new tiles wrong next time.
    // rust: if write_whole(&inner.dir.join(&name), &body).is_err() {
    // rust: let _ = std::fs::remove_file(inner.dir.join(name));
}
}
    // rust: let mut state = inner.state.lock().unwrap();
    // rust: if changed {
    // rust: state.map = Some(Arc::new(map));
    // rust: state.tiles.clear();
    // rust: state.chunks.clear();
    // rust: state.queue.clear();
    // rust: state.generation += 1;
    // rust: state.announce_all();
}
    // rust: return REQUEST_GAP;
}
    // rust: let next = {
    // rust: let mut state = inner.state.lock().unwrap();
    // rust: let picked = state.map.clone().and_then(|map| {
    // rust: let mut far = Vec::new();
    // rust: let mut best = None;
    // rust: for &key in &state.queue {
    // rust: match state.near(&map.lowres, key, inner.radius) {
    // rust: Some(d) if best.is_none_or(|(b, _)| d < b) => best = Some((d, key)),
    // rust: Some(_) => {}
    // rust: None => far.push(key),
}
}
                // Out of reach since: forgotten, wanted again if it comes back.
    // rust: for key in far {
    // rust: state.queue.remove(&key);
    // rust: if let Some(slot @ Slot::Waiting) = state.tiles.get_mut(&key) {
    // rust: *slot = Slot::Unreached;
}
}
    // rust: let (_, key) = best?;
    // rust: state.queue.remove(&key);
    // rust: Some((map, key))
    // rust: });
    // rust: if picked.is_none() {
    // rust: let _ = inner.wake.wait_timeout(state, Duration::from_secs(1));
}
    // rust: picked
}
    // rust: let Some((map, key)) = next else {
    // rust: return Duration::ZERO;
}
    // rust: let (level, x, z) = key;
    // rust: let path = format!(
    // rust: "{}/{}/tiles/{level}/{}.png",
    // rust: map.root,
    // rust: map.id,
    // rust: tile_path(x, z)
    // rust: );
    // rust: let body = match self.get(inner, &path) {
    // rust: Ok(body) => body,
    // rust: Err(()) => {
    // rust: self.failed(inner);
    // rust: return Duration::ZERO;
}
}
    // rust: self.answered();
    // rust: let tile = body.as_deref().and_then(|b| decode_tile(b, &map.lowres));
    // rust: let file = inner.tile_file(&map, key);
    // rust: let _ = std::fs::create_dir_all(file.parent().unwrap_or(&inner.dir));
    // rust: let (png, none) = (file.with_extension("png"), file.with_extension("none"));
        // Whether what is cached (and drawn) stays as it was, and the bytes
        // written (`None` also when a write failed: the new tile is still
        // drawn this visit).
    // rust: let (unchanged, written) = match (&tile, &body) {
    // rust: (Some(_), Some(body)) if std::fs::read(&png).is_ok_and(|old| old == *body) => {
                // Unchanged: fresh for another `MAX_AGE`.
    // rust: let _ = std::fs::File::options()
    // rust: .append(true)
    // rust: .open(&png)
    // rust: .and_then(|f| f.set_modified(SystemTime::now()));
    // rust: (true, None)
}
    // rust: (Some(_), Some(body)) => {
    // rust: let _ = std::fs::remove_file(&none);
    // rust: (
    // rust: false,
    // rust: write_whole(&png, body).ok().map(|()| body.len() as u64),
    // rust: )
}
            // Not a tile (an error page): a cached one is kept.
    // rust: (None, Some(_)) if png.exists() => (true, None),
    // rust: _ => {
    // rust: let _ = std::fs::remove_file(&png);
    // rust: (false, write_whole(&none, &[]).ok().map(|()| 0))
}
}
        // The disk walks outside the lock: lookups and the frame wait on it.
    // rust: if let Some(bytes) = written {
    // rust: let disk = self.disk.get_or_insert_with(|| folder_size(&inner.dir));
    // rust: *disk += bytes;
    // rust: if *disk > DISK_CAP {
    // rust: *disk = prune(&inner.dir, DISK_CAP * 3 / 4);
}
}
    // rust: let mut state = inner.state.lock().unwrap();
    // rust: let waited = matches!(state.tiles.get(&key), Some(Slot::Waiting));
        // Unchanged and drawn already: nothing to tell.
    // rust: if unchanged && !waited {
    // rust: return REQUEST_GAP.saturating_sub(started.elapsed());
}
    // rust: let slot = tile.map_or(Slot::Missing, |t| Slot::Ready(Arc::new(t)));
    // rust: state.tiles.insert(key, slot);
        // Chunks are made of level 1, their depth read a pixel around, and
        // of the coarser levels where level 1 is out of reach, theirs read a
        // cell around: any level makes the chunks over it again.
    // rust: let margin = if level > 1 {
    // rust: map.lowres.scale(level)
    // rust: } else {
    // rust: 0
}
    // rust: let (x0, x1) = map.lowres.span(0, level, x);
    // rust: let (z0, z1) = map.lowres.span(1, level, z);
    // rust: let (x0, x1) = (x0.saturating_sub(margin), x1.saturating_add(margin));
    // rust: let (z0, z1) = (z0.saturating_sub(margin), z1.saturating_add(margin));
    // rust: state.generation += 1;
    // rust: state.chunks.retain(|&(cx, cz), _| {
    // rust: cx * 16 > x1 || (cx + 1) * 16 < x0 || cz * 16 > z1 || (cz + 1) * 16 < z0
    // rust: });
        // A coarser level also stands in for chunk-wide cells whose finest
        // tile is on its way (`coarser_column`): those are sampled again too.
    // rust: let (min, max) = map.lowres.widths(level);
    // rust: let widths = if level > 1 {
    // rust: (1, max.max(16))
    // rust: } else {
    // rust: (min, max)
}
    // rust: state.announce(Change {
    // rust: area: [x0, z0, x1, z1],
    // rust: widths,
    // rust: });
    // rust: REQUEST_GAP.saturating_sub(started.elapsed())
}
}

    // rust: impl Worker {
    /// One step of looking for the map: the next candidate, one at a time
    /// and one look a server at a time (another level's map may be looking).
pub fn look(self: *Self, inner: *Inner) D {
    // Implementation ported from Horizon
    return undefined;
}
//         use crate::bluemap_detect::{self as detect, Claim, Remembered};
    // rust: if self.claim.is_none() {
    // rust: let Some(claim) = Claim::take(&inner.dir) else {
    // rust: return Duration::from_secs(1);
}
    // rust: self.claim = Some(claim);
            // What a look finished meanwhile found: one of this server's
            // addresses only (`bluemap_detect::source`).
    // rust: match detect::remembered(&inner.dir, SystemTime::now()) {
    // rust: Remembered::Found(url) if !inner.probes.contains(&url) => {}
    // rust: Remembered::Found(url) => {
    // rust: let _ = inner.base.set(url);
    // rust: self.claim = None;
    // rust: return Duration::ZERO;
}
    // rust: Remembered::Nothing => return self.found_nothing(inner),
    // rust: Remembered::Stale(_) => {}
}
}
    // rust: let Some(candidate) = inner.probes.get(self.probed) else {
    // rust: detect::remember(&inner.dir, None, SystemTime::now());
    // rust: log::debug!("Horizon: no BlueMap found for {}", inner.level);
    // rust: return self.found_nothing(inner);
}
    // rust: self.probed += 1;
    // rust: let started = Instant::now();
    // rust: if detect::probe(&self.agent, candidate) {
    // rust: log::info!("Horizon: found the server's BlueMap");
    // rust: log::debug!("Horizon: BlueMap at {candidate}");
    // rust: detect::remember(&inner.dir, Some(candidate), SystemTime::now());
    // rust: let _ = inner.base.set(candidate.clone());
    // rust: self.claim = None;
    // rust: return Duration::ZERO;
}
    // rust: log::debug!("Horizon: no BlueMap at {candidate}");
    // rust: detect::GAP.saturating_sub(started.elapsed())
}
    /// The server has no map: what was cached of an earlier one isn't drawn.
pub fn found_nothing(self: *Self, inner: *Inner) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut state = inner.state.lock().unwrap();
    // rust: if state.map.take().is_some() {
    // rust: state.tiles.clear();
    // rust: state.chunks.clear();
    // rust: state.generation += 1;
    // rust: state.announce_all();
}
    // rust: self.claim = None;
    // rust: self.done = true;
    // rust: Duration::ZERO
}
}

pub fn cached_files(dir: *Path, out: *mut Vec<(SystemTime) void {
}
    // rust: for entry in std::fs::read_dir(dir).into_iter().flatten().flatten() {
    // rust: let path = entry.path();
    // rust: let Ok(meta) = entry.metadata() else { continue };
    // rust: if meta.is_dir() {
    // rust: cached_files(&path, out);
    // rust: } else if path.extension().is_some_and(|e| e == "png" || e == "none") {
    // rust: out.push((
    // rust: meta.modified().unwrap_or(SystemTime::UNIX_EPOCH),
    // rust: meta.len(),
    // rust: path,
    // rust: ));
}
}
}
pub fn folder_size(dir: *Path) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut files = Vec::new();
    // rust: cached_files(dir, &mut files);
    // rust: files.iter().map(|(_, len, _)| len).sum()
}
/// Deletes the oldest tiles until at most `keep` bytes are left; the bytes left.
pub fn prune(dir: *Path, keep: u64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut files = Vec::new();
    // rust: cached_files(dir, &mut files);
    // rust: files.sort_unstable();
    // rust: let mut total: u64 = files.iter().map(|(_, len, _)| len).sum();
    // rust: for (_, len, path) in files {
    // rust: if total <= keep {
    // rust: break;
}
    // rust: if std::fs::remove_file(&path).is_ok() {
    // rust: total -= len;
}
}
    // rust: total
}

    // rust: mod tests {
//     use super::*;

    // rust: const LOWRES: Lowres = Lowres {
    // rust: tile: [32, 32],
    // rust: factor: 5,
    // rust: levels: 3,
}

    /// A lowres tile as BlueMap writes it: `pixel` gives each column.
pub fn tile_png(lowres: *Lowres, pixel: impl Fn(usize) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, h) = (lowres.tile[0] as usize + 1, lowres.tile[1] as usize + 1);
    // rust: let mut data = vec![0u8; w * h * 2 * 4];
    // rust: for z in 0..h {
    // rust: for x in 0..w {
    // rust: let p = pixel(x, z);
    // rust: let [a, r, g, b] = p.color.to_be_bytes();
    // rust: let [hi, lo] = p.height.to_be_bytes();
    // rust: data[(z * w + x) * 4..][..4].copy_from_slice(&[r, g, b, a]);
    // rust: data[((z + h) * w + x) * 4..][..4].copy_from_slice(&[p.block_light, hi, lo, 255]);
}
}
    // rust: let mut out = Vec::new();
    // rust: let mut encoder = png::Encoder::new(&mut out, w as u32, (h * 2) as u32);
    // rust: encoder.set_color(png::ColorType::Rgba);
    // rust: encoder.set_depth(png::BitDepth::Eight);
    // rust: let mut writer = encoder.write_header().unwrap();
    // rust: writer.write_image_data(&data).unwrap();
    // rust: writer.finish().unwrap();
    // rust: out
}
pub fn sample(x: usize, z: usize) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Pixel {
    // rust: color: 0xFF00_0000 | (x as u32) << 16 | (z as u32) << 8 | 0x40,
    // rust: height: x as i16 * 3 - 60,
    // rust: block_light: (z % 16) as u8,
}
}

pub fn tiles_decode_colour_height_and_light() void {
}
    // rust: let png = tile_png(&LOWRES, sample);
    // rust: let tile = decode_tile(&png, &LOWRES).expect("tile");
    // rust: for (x, z) in [(0, 0), (5, 31), (32, 32), (20, 3)] {
    // rust: assert_eq!(tile.pixel(x, z), sample(x, z));
}
    // rust: assert_eq!(tile.pixel(0, 0).height, -60);
        // Gzipped by a web server, still the same tile.
    // rust: let mut gz = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::fast());
    // rust: std::io::Write::write_all(&mut gz, &png).unwrap();
    // rust: assert_eq!(decode_tile(&gz.finish().unwrap(), &LOWRES), Some(tile));
        // Another tile size is refused.
    // rust: let small = Lowres {
    // rust: tile: [16, 16],
    // rust: ..LOWRES
}
    // rust: assert_eq!(decode_tile(&png, &small), None);
    // rust: assert_eq!(decode_tile(b"not a png", &LOWRES), None);
}

pub fn tile_paths_split_digits_as_the_web_app() void {
}
    // rust: assert_eq!(tile_path(0, 0), "x0/z0");
    // rust: assert_eq!(tile_path(12, -3), "x1/2/z-3");
    // rust: assert_eq!(tile_path(-120, 45), "x-1/2/0/z4/5");
}

pub fn blocks_find_their_tile_and_pixel_at_every_level() void {
}
        // Level 1: a pixel a block.
    // rust: assert_eq!(LOWRES.locate(0, 1, 0), (0, 0));
    // rust: assert_eq!(LOWRES.locate(0, 1, 33), (1, 1));
    // rust: assert_eq!(LOWRES.locate(0, 1, -1), (-1, 31));
        // Level 2: five level-1 tiles a tile, six pixels of five blocks each.
    // rust: assert_eq!(LOWRES.locate(0, 2, 0), (0, 0));
    // rust: assert_eq!(LOWRES.locate(0, 2, 4), (0, 0));
    // rust: assert_eq!(LOWRES.locate(0, 2, 5), (0, 1));
    // rust: assert_eq!(LOWRES.locate(0, 2, 32 + 7), (0, 7));
    // rust: assert_eq!(
    // rust: LOWRES.locate(0, 2, 31),
    // rust: (0, 5),
    // rust: "the leftover blocks join the last pixel"
    // rust: );
    // rust: assert_eq!(LOWRES.locate(0, 2, -1), (-1, 29));
    // rust: assert_eq!(LOWRES.locate(0, 2, 5 * 32), (1, 0));
        // Level 3: level 2's tiles packed the same way.
    // rust: assert_eq!(LOWRES.locate(0, 3, 5 * 32 * 2 + 10), (0, 12));
    // rust: assert_eq!(LOWRES.locate(0, 3, -1), (-1, 29));
        // Every block of a level-3 tile's span lands in that tile.
    // rust: let (min, max) = LOWRES.span(0, 3, -2);
    // rust: assert_eq!((min, max), (-1600, -800));
    // rust: assert!(
    // rust: (min..max)
    // rust: .step_by(7)
    // rust: .all(|b| LOWRES.locate(0, 3, b).0 == -2)
    // rust: );
    // rust: assert_eq!(LOWRES.level_for(1), 1);
    // rust: assert_eq!(LOWRES.level_for(16), 2);
    // rust: assert_eq!(LOWRES.level_for(1024), 3);
}

pub fn settings_files_parse() void {
}
    // rust: let root = Root::parse(br#"{"version":"5.4","maps":["world","world_nether","world_the_end"],"mapDataRoot":"maps/","liveDataRoot":"maps"}"#).unwrap();
    // rust: assert_eq!(root.data_root, "maps");
    // rust: let map = br#"{"name":"World","hires":{"tileSize":[32,32]},"lowres":{"tileSize":[50,40],"lodFactor":4,"lodCount":2}}"#;
    // rust: assert_eq!(
    // rust: Lowres::parse(map),
    // rust: Some(Lowres {
    // rust: tile: [50, 40],
    // rust: factor: 4,
    // rust: levels: 2
    // rust: })
    // rust: );
    // rust: assert_eq!(Lowres::parse(br#"{"lowres":{}}"#), Some(LOWRES));
    // rust: assert_eq!(Lowres::parse(br#"{"lowres":{"lodFactor":0}}"#), None);
    // rust: assert_eq!(
    // rust: pick_map(&root.maps, "minecraft:overworld", &[]).as_deref(),
    // rust: Some("world")
    // rust: );
    // rust: assert_eq!(
    // rust: pick_map(&root.maps, "minecraft:the_nether", &[]).as_deref(),
    // rust: Some("world_nether")
    // rust: );
    // rust: assert_eq!(
    // rust: pick_map(&root.maps, "minecraft:the_end", &[]).as_deref(),
    // rust: Some("world_the_end")
    // rust: );
    // rust: let chosen = [("minecraft:overworld".to_owned(), "survival".to_owned())];
    // rust: assert_eq!(
    // rust: pick_map(&root.maps, "minecraft:overworld", &chosen).as_deref(),
    // rust: Some("survival")
    // rust: );
    // rust: assert_eq!(pick_map(&root.maps, "mod:moon", &[]), None);
    // rust: assert_eq!(
    // rust: base_url(" https://map.example.net/#world:1:2:3 "),
    // rust: "https://map.example.net"
    // rust: );
    // rust: assert_eq!(
    // rust: base_url("http://example.net:8100/index.html"),
    // rust: "http://example.net:8100"
    // rust: );
}

pub fn player_settings_round_trip() void {
}
    // rust: let server = Settings::parse_server(
    // rust: "play.example.net:25566 https://map.example.net nether=world_nether mod:moon=moon",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: server.maps,
    // rust: [
    // rust: ("minecraft:the_nether".to_owned(), "world_nether".to_owned()),
    // rust: ("mod:moon".to_owned(), "moon".to_owned())
    // rust: ]
    // rust: );
    // rust: let settings = Settings {
    // rust: radius: 32,
    // rust: auto_detect: true,
    // rust: servers: vec![server.clone()],
}
    // rust: let text = settings.serialize();
    // rust: let mut parsed = Settings::default();
    // rust: for line in text.lines() {
    // rust: match line.split_once(':') {
    // rust: Some(("blueMapRadius", v)) => parsed.radius = Settings::parse_radius(v).unwrap(),
    // rust: Some(("blueMapAutoDetect", v)) => parsed.auto_detect = v == "true",
    // rust: _ => panic!("{line}: no map in the graphics settings"),
}
}
    // rust: parsed.servers = Settings::parse_servers(
    // rust: "\u{feff}# a comment\r\nblueMap: play.example.net:25566 https://map.example.net nether=world_nether mod:moon=moon\nlodDistance:64\n",
    // rust: );
    // rust: assert_eq!(parsed, settings);
    // rust: assert!(settings.server("Play.Example.net:25566").is_some());
    // rust: assert!(settings.server("play.example.net").is_none());
    // rust: assert_eq!(Settings::parse_radius("48"), Some(48));
    // rust: assert_eq!(Settings::parse_radius("2000b"), Some(125));
    // rust: assert_eq!(Settings::parse_radius("1024 blocks"), Some(64));
    // rust: assert_eq!(Settings::parse_radius("lots"), None);
    // rust: assert_eq!(
    // rust: Settings::default().radius_blocks(),
    // rust: DEFAULT_RADIUS as i32 * 16
    // rust: );
}

pub fn palette() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names = [
    // rust: "stone",
    // rust: "dirt",
    // rust: "sand",
    // rust: "grass_block",
    // rust: "oak_leaves",
    // rust: "water",
    // rust: "snow_block",
    // rust: ];
    // rust: Palette::new(
    // rust: |name| {
    // rust: let name = name.strip_prefix("minecraft:")?;
    // rust: names
    // rust: .iter()
    // rust: .position(|n| *n == name)
    // rust: .map(|i| BlockStateId(i as u32 + 1))
    // rust: },
    // rust: &[
    // rust: Tints {
    // rust: id: 0,
    // rust: grass: 0x91BD59,
    // rust: foliage: 0x77AB2F,
    // rust: water: 0x3F76E4,
    // rust: },
    // rust: Tints {
    // rust: id: 1,
    // rust: grass: 0xBFB755,
    // rust: foliage: 0xAEA42A,
    // rust: water: 0x3F76E4,
    // rust: },
    // rust: ],
    // rust: 0,
    // rust: )
}

pub fn colours_become_the_nearest_block() void {
}
    // rust: let palette = palette();
    // rust: let at = |color: u32, height: i16| {
    // rust: let pixel = Pixel {
    // rust: color: 0xFF00_0000 | color,
    // rust: height,
    // rust: block_light: 0,
}
    // rust: palette.column(pixel, i32::from(height) + 1)
}
    // rust: let grass = at(0x577133, 70);
    // rust: let surface = grass.surface.unwrap();
    // rust: assert_eq!(
    // rust: (surface.height, surface.state, surface.biome),
    // rust: (71, BlockStateId(4), 0)
    // rust: );
    // rust: assert_eq!(grass.spans.last().unwrap().max, 71);
    // rust: assert_eq!(
    // rust: grass.spans[grass.spans.len() - 2].state,
    // rust: BlockStateId(2),
    // rust: "dirt under grass"
    // rust: );
        // As deep as its neighbours need, not down to the void.
    // rust: assert_eq!(grass.spans[0].min, 71 - SKIRT as i16);
    // rust: let cliff = palette.column(
    // rust: Pixel {
    // rust: color: 0xFF57_7133,
    // rust: height: 70,
    // rust: block_light: 0,
    // rust: },
    // rust: 40,
    // rust: );
    // rust: assert_eq!(cliff.spans[0].min, 40 - SKIRT as i16);
        // A savanna-ish green picks that biome's tint.
    // rust: assert_eq!(at(0x736E33, 70).surface.unwrap().biome, 1);
    // rust: let sea = at(0x2C52A0, 62).surface.unwrap();
    // rust: assert_eq!(sea.water, Some((63, BlockStateId(6))));
    // rust: assert_eq!(sea.state, BlockStateId(3));
    // rust: assert_eq!(at(0xF0F5F5, 90).surface.unwrap().state, BlockStateId(7));
    // rust: assert_eq!(at(0x7A7A7A, -10).surface.unwrap().state, BlockStateId(1));
        // Nothing rendered there: no column.
    // rust: assert_eq!(
    // rust: palette.column(
    // rust: Pixel {
    // rust: color: 0x00FF_FFFF,
    // rust: height: 64,
    // rust: block_light: 0
    // rust: },
    // rust: 65
    // rust: ),
    // rust: Column::default()
    // rust: );
}

pub fn scratch(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-bluemap-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: dir
}

    /// Cached settings and tiles serve without the server; a missing tile
    /// is wanted only near the player, and real data waits for it.
pub fn cached_tiles_serve_and_far_ones_are_not_wanted() void {
}
    // rust: let dir = scratch("cache");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join("settings.json"), br#"{"maps":["world"]}"#).unwrap();
    // rust: std::fs::write(dir.join("world.json"), br#"{"lowres":{}}"#).unwrap();
    // rust: let green = |_: usize, _: usize| Pixel {
    // rust: color: 0xFF57_7133,
    // rust: height: 70,
    // rust: block_light: 0,
}
    // rust: let tiles = dir.join("world/1");
    // rust: std::fs::create_dir_all(&tiles).unwrap();
    // rust: std::fs::write(tiles.join("0_-1.png"), tile_png(&LOWRES, green)).unwrap();
    // rust: std::fs::write(tiles.join("1_-1.none"), []).unwrap();
    // rust: let map = BlueMap::new(
    // rust: "https://map.example.net/",
    // rust: "minecraft:overworld",
    // rust: Vec::new(),
    // rust: dir.clone(),
    // rust: 256,
    // rust: palette(),
    // rust: );
        // Chunk (1, -1) lies in tile (0, -1).
    // rust: let Found::Ready(columns) = map.chunk(1, -1) else {
    // rust: panic!("cached tile")
}
    // rust: assert_eq!(columns[0].surface.map(|s| s.height), Some(71));
    // rust: assert_eq!(
    // rust: map.chunk(2, -1),
    // rust: Found::Absent,
    // rust: "the server has nothing there"
    // rust: );
        // No player yet: nothing is near, nothing waited for.
    // rust: assert_eq!(map.chunk(40, 40), Found::Absent);
    // rust: let queued = |key| map.inner.state.lock().unwrap().queue.contains(&key);
        // The player comes: what was looked up in reach is wanted, and far
        // terrain has nothing to sample again until it arrives.
    // rust: map.set_center(40 * 16, 40 * 16);
    // rust: assert!(map.take_changed().is_empty());
    // rust: assert_eq!(map.chunk(40, 40), Found::Waiting);
    // rust: assert!(queued((1, 20, 20)));
    // rust: assert_eq!(map.chunk(-400, 0), Found::Absent, "past the radius");
        // A wide cell reads the coarsest level, here not cached either.
    // rust: assert_eq!(map.reduced_column(40 * 16, 40 * 16, 1024), Found::Waiting);
    // rust: assert!(queued((3, 1, 1)));
        // Out of level 1's reach, not looked up on disk again (wanted once
        // in reach); the coarsest level stands in, and it is on its way.
    // rust: assert_eq!(map.chunk(60, 40), Found::Waiting);
    // rust: assert!(matches!(
    // rust: map.inner.state.lock().unwrap().tiles.get(&(1, 30, 20)),
    // rust: Some(Slot::Unreached)
    // rust: ));
    // rust: map.set_center(40 * 16 + 10, 40 * 16);
    // rust: assert!(!queued((1, 30, 20)), "moving a little wants nothing");
    // rust: map.set_center(40 * 16 + 100, 40 * 16);
    // rust: assert!(queued((1, 30, 20)));
    // rust: assert!(map.take_changed().is_empty());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

    /// Real chunks the server sent come first; BlueMap fills the rest.
pub fn stored_chunks_win_over_the_map() void {
}
//         use crate::{server_terrain::ServerTerrain, streaming::LodSource};
    // rust: let dir = scratch("terrain");
    // rust: let maps = dir.join("map");
    // rust: std::fs::create_dir_all(&maps).unwrap();
    // rust: std::fs::write(maps.join("settings.json"), br#"{"maps":["world"]}"#).unwrap();
    // rust: std::fs::write(maps.join("world.json"), br#"{"lowres":{}}"#).unwrap();
    // rust: let green = |_: usize, _: usize| Pixel {
    // rust: color: 0xFF57_7133,
    // rust: height: 70,
    // rust: block_light: 0,
}
    // rust: for level in 1..=3 {
    // rust: let tiles = maps.join(format!("world/{level}"));
    // rust: std::fs::create_dir_all(&tiles).unwrap();
    // rust: std::fs::write(tiles.join("0_0.png"), tile_png(&LOWRES, green)).unwrap();
}
    // rust: let map = BlueMap::new(
    // rust: "http://map.example.net",
    // rust: "minecraft:overworld",
    // rust: Vec::new(),
    // rust: maps,
    // rust: 256,
    // rust: palette(),
    // rust: );
    // rust: let terrain = ServerTerrain::new(dir.join("chunks"), Some(Arc::new(map)));
    // rust: let real = Column::from_surface(Some(crate::lod::Surface {
    // rust: height: 100,
    // rust: state: BlockStateId(9),
    // rust: water: None,
    // rust: biome: 0,
    // rust: }));
    // rust: let columns = Arc::new(std::array::from_fn(|_| real.clone()));
    // rust: terrain.store((0, 0), &columns).unwrap();
    // rust: let mut sampler = terrain.clone().sampler();
    // rust: assert_eq!(sampler.sample(3, 3).map(|s| s.height), Some(100));
    // rust: assert_eq!(sampler.sample(20, 3).map(|s| s.height), Some(71));
    // rust: assert_eq!(sampler.sample(-1, 3), None, "neither has it");
        // Wider cells are reduced to spans: their top.
    // rust: let mut top = |x, z, width| {
    // rust: let column = sampler.reduced_column(x, z, width);
    // rust: column.spans.last().map(|s| s.max)
}
    // rust: assert_eq!(top(16, 0, 8), Some(71));
    // rust: assert_eq!(top(0, 0, 16), Some(100));
        // A wide cell: the stored chunk at its middle, else the map.
    // rust: assert_eq!(top(0, 0, 64), Some(71));
    // rust: assert_eq!(top(-16, -16, 32), Some(100));
    // rust: sampler.request_detail(&[(0, 0), (1, 0), (-1, 0)], [0, 0]);
    // rust: let details = sampler.drain_details();
    // rust: assert_eq!(details.len(), 3);
    // rust: assert_eq!(details[0].1, columns);
    // rust: assert_eq!(details[1].1[0].surface.map(|s| s.height), Some(71));
    // rust: assert_eq!(details[2].1[0], Column::default());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

    /// The finest level on its way: a chunk-sized cell is drawn from a
    /// coarser one meanwhile, and sampled again once it comes.
pub fn coarser_levels_stand_in_for_the_finest_on_its_way() void {
}
//         use crate::{server_terrain::ServerTerrain, streaming::LodSource};
    // rust: let dir = scratch("coarser");
    // rust: let maps = dir.join("map");
    // rust: std::fs::create_dir_all(&maps).unwrap();
    // rust: std::fs::write(maps.join("settings.json"), br#"{"maps":["world"]}"#).unwrap();
    // rust: std::fs::write(maps.join("world.json"), br#"{"lowres":{}}"#).unwrap();
        // The finest coarser level wins: level 3 is lower.
    // rust: for (level, height) in [(2, 70), (3, 50)] {
    // rust: let green = |_: usize, _: usize| Pixel {
    // rust: color: 0xFF57_7133,
    // rust: height,
    // rust: block_light: 0,
}
    // rust: let tiles = maps.join(format!("world/{level}"));
    // rust: std::fs::create_dir_all(&tiles).unwrap();
    // rust: std::fs::write(tiles.join("0_0.png"), tile_png(&LOWRES, green)).unwrap();
}
    // rust: let map = Arc::new(BlueMap::new(
    // rust: "http://map.example.net",
    // rust: "minecraft:overworld",
    // rust: Vec::new(),
    // rust: maps,
    // rust: 256,
    // rust: palette(),
    // rust: ));
    // rust: map.set_center(3, 3);
    // rust: assert_eq!(map.chunk(0, 0), Found::Waiting);
    // rust: let Found::Ready(coarse) = map.coarser_column(3, 3) else {
    // rust: panic!("level 2 is cached")
}
    // rust: assert_eq!(coarse.spans.last().map(|s| s.max), Some(71));
    // rust: let terrain = ServerTerrain::new(dir.join("chunks"), Some(map));
    // rust: let mut sampler = terrain.clone().sampler();
    // rust: assert!(!sampler.waited());
    // rust: for width in [1, 4, 16] {
    // rust: assert_eq!(
    // rust: sampler
    // rust: .reduced_column(0, 0, width)
    // rust: .spans
    // rust: .last()
    // rust: .map(|s| s.max),
    // rust: Some(71)
    // rust: );
            // Stood in for: drawn, and sampled again once level 1 comes.
    // rust: assert!(!sampler.waited());
}
        // On its way with no coarser level cached there either: a hole, so
        // the sample isn't drawn.
        // (Level 2 and 3 are cached only east of 0.)
    // rust: assert_eq!(sampler.reduced_column(-100, 3, 1), Column::default());
    // rust: assert!(sampler.waited());
        // Level 1 out of reach there (past 256 blocks), level 3 cached: the
        // coarser level, and nothing waited for.
    // rust: assert_eq!(
    // rust: sampler
    // rust: .reduced_column(400, 3, 1)
    // rust: .spans
    // rust: .last()
    // rust: .map(|s| s.max),
    // rust: Some(51)
    // rust: );
    // rust: assert!(!sampler.waited());
        // Nowhere near any level: nothing to stand in, and not waited for.
    // rust: assert_eq!(sampler.reduced_column(-4000, 0, 1), Column::default());
    // rust: assert!(!sampler.waited());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn arrivals_name_the_cells_they_change_and_come_in_bursts() void {
}
        // Cells up to a chunk read level 1, wider ones level 3 (level 2's
        // 5-block pixels suit no power-of-two cell).
    // rust: assert_eq!(LOWRES.widths(1), (1, 16));
    // rust: assert_eq!(LOWRES.widths(2), (17, 24));
    // rust: assert_eq!(LOWRES.widths(3), (25, i32::MAX));
    // rust: let map = BlueMap::new(
    // rust: "http://map.example.net",
    // rust: "minecraft:overworld",
    // rust: Vec::new(),
    // rust: scratch("bursts"),
    // rust: 256,
    // rust: palette(),
    // rust: );
    // rust: let change = |x| Change {
    // rust: area: [x, 0, x + 32, 32],
    // rust: widths: LOWRES.widths(1),
}
    // rust: let announce = |x| map.inner.state.lock().unwrap().announce(change(x));
    // rust: announce(0);
    // rust: assert_eq!(map.take_changed(), [change(0)]);
    // rust: announce(32);
    // rust: announce(64);
    // rust: assert!(map.take_changed().is_empty(), "within CHANGE_GAP");
    // rust: map.inner.state.lock().unwrap().taken_at = Some(Instant::now() - CHANGE_GAP);
    // rust: assert_eq!(map.take_changed(), [change(32), change(64)]);
}

    /// A chunk's columns reach under their neighbours' tops, the ones
    /// beside the map's edge no further than their own.
pub fn chunks_are_as_deep_as_their_neighbours() void {
}
    // rust: let dir = scratch("depth");
    // rust: std::fs::create_dir_all(dir.join("world/1")).unwrap();
    // rust: std::fs::write(dir.join("settings.json"), br#"{"maps":["world"]}"#).unwrap();
    // rust: std::fs::write(dir.join("world.json"), br#"{"lowres":{}}"#).unwrap();
        // A step down at x = 8, and nothing rendered from x = 24.
    // rust: let step = |x: usize, _: usize| Pixel {
    // rust: color: if x >= 24 { 0 } else { 0xFF57_7133 },
    // rust: height: if x < 8 { 90 } else { 70 },
    // rust: block_light: 0,
}
    // rust: std::fs::write(dir.join("world/1/0_0.png"), tile_png(&LOWRES, step)).unwrap();
    // rust: let map = BlueMap::new(
    // rust: "http://map.example.net",
    // rust: "minecraft:overworld",
    // rust: Vec::new(),
    // rust: dir.clone(),
    // rust: 256,
    // rust: palette(),
    // rust: );
    // rust: let Found::Ready(left) = map.chunk(0, 0) else {
    // rust: panic!("cached tile")
}
    // rust: let Found::Ready(right) = map.chunk(1, 0) else {
    // rust: panic!("cached tile")
}
    // rust: let bottom = |c: &Column| c.spans[0].min;
    // rust: assert_eq!(bottom(&left[16 + 7]), 71 - SKIRT as i16, "the cliff's top");
    // rust: assert_eq!(bottom(&left[16 + 3]), 91 - SKIRT as i16);
    // rust: assert_eq!(
    // rust: bottom(&right[16 + 7]),
    // rust: 71 - SKIRT as i16,
    // rust: "by the map's edge"
    // rust: );
    // rust: assert_eq!(right[16 + 8], Column::default());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn the_oldest_tiles_go_past_the_cap() void {
}
    // rust: let dir = scratch("prune");
    // rust: std::fs::create_dir_all(dir.join("a/1")).unwrap();
    // rust: for (i, name) in ["old", "mid", "new"].iter().enumerate() {
    // rust: let path = dir.join(format!("a/1/{name}.png"));
    // rust: std::fs::write(&path, [0u8; 100]).unwrap();
    // rust: let time = SystemTime::UNIX_EPOCH + Duration::from_secs(1_000_000 + i as u64);
    // rust: std::fs::File::options()
    // rust: .append(true)
    // rust: .open(&path)
    // rust: .unwrap()
    // rust: .set_modified(time)
    // rust: .unwrap();
}
    // rust: std::fs::write(dir.join("settings.json"), [0u8; 50]).unwrap();
    // rust: assert_eq!(folder_size(&dir), 300);
    // rust: assert_eq!(prune(&dir, 150), 100);
    // rust: assert!(dir.join("a/1/new.png").exists() && !dir.join("a/1/mid.png").exists());
    // rust: assert!(dir.join("settings.json").exists(), "only tiles are pruned");
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
