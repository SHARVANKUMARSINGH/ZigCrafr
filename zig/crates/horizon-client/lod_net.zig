//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lod_net
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Far terrain from a server (`horizon:lod`): a Horizon client playing on
//! another machine's world has neither the seed nor the generator its far
//! terrain samples, so the server samples the tiles for it, up to the distance
//! its owner allows (`horizon-lod-distance`). Only a dedicated server can offer
//! it for now: an open-to-LAN world has no setting for that distance yet, so
//! its `LanConfig::lod_distance` stays 0.
//!
//! The server offers it with an [`Offer`] payload in the configuration phase,
//! to Horizon clients only (a vanilla client never hears of it). The client
//! then asks for one far tile at a time ([`Request`]: 16 x 16 columns, as
//! `lod::Lod` samples them) and the server answers each with the tile's
//! columns, or a refusal. The offer carries the server's limits, which the
//! client keeps to: requests in flight and tiles a second. The server checks
//! them again, with the tile's distance from the player, and samples on one
//! background thread for every player in turn (`server`), so far terrain
//! never takes more than that thread's time from the ticks.
//!
//! It is off unless the owner sets the key: far tiles show the generator's
//! terrain far beyond view distance, which helps crack a world's seed.
// use crate::lod::{Column, Span, Spans, Surface};
// use horizon_protocol::{
    // rust: Error, Result,
    // rust: buf::{Reader, Writer},
}
// use horizon_world::registry::BlockStateId;
// use std::{collections::HashMap, time::Instant};

    // rust: mod client;
    // rust: mod server;
    // rust: pub use client::{Inbox, RemoteSource};
    // rust: pub use server::{Delivery, Job, Service, Verdict};

/// The custom payload channel, both ways.
pub const CHANNEL: []const u8 = "horizon:lod";
/// The server.properties key (Horizon's own): the farthest a player's far
/// terrain may reach, in chunks; 0 turns serving it off.
pub const PROPERTY: []const u8 = "horizon-lod-distance";
/// [`PROPERTY`] when the file doesn't set it: off.
pub const DEFAULT_DISTANCE: u32 = 0;
/// The protocol's version, first in an [`Offer`]: a client serves itself
/// from a server that speaks its own only. Requests and replies follow it.
pub const VERSION: u32 = 1;
/// The most [`PROPERTY`] may be (the client's own LOD Distance cap).
pub const MAX_DISTANCE: u32 = 1024;
/// Requests a player may have waiting at the server at once.
pub const IN_FLIGHT: u32 = 8;
/// Tiles a second a player may ask for, on average.
pub const PER_SECOND: u32 = 64;
/// Columns on a tile's side (`lod::CELLS`).
pub const SIDE: usize = 16;
/// How much farther than the allowed distance a tile may be, in chunks: the
/// player moved between the client's request and the server's check.
pub const SLACK: u32 = 8;
/// Biomes one tile may name at most.
pub const MAX_BIOMES: usize = 256;
/// A biome name's length at most.
pub const MAX_BIOME_NAME: usize = 256;
/// Spans one tile may hold at most, all its columns together (a mean of 64
/// a column): a bigger tile is refused, so what the client decodes and
/// meshes stays small.
pub const MAX_SPANS: usize = 16 * 1024;
/// A reply's size at most, in bytes.
pub const MAX_REPLY: usize = 512 * 1024;
/// The lowest and highest a span or surface may reach (a dimension's limits).
pub const HEIGHTS: std::ops::RangeInclusive<i32> = -2048..=4096;

/// [`PROPERTY`]'s value: [`DEFAULT_DISTANCE`] when absent or unreadable,
/// at most [`MAX_DISTANCE`].
pub fn distance_property(value: ?[]const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: value
    // rust: .and_then(|v| v.trim().parse::<u32>().ok())
    // rust: .unwrap_or(DEFAULT_DISTANCE)
    // rust: .min(MAX_DISTANCE)
}

/// What the server serves, as it tells a Horizon client while it configures.
pub const Offer = struct {
    /// Chunks from the player at most.
    distance: u32,
    /// Requests waiting at once at most.
    in_flight: u32,
    /// Tiles a second at most.
    per_second: u32,
};
    // rust: impl Offer {
pub fn new(distance: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: distance: distance.min(MAX_DISTANCE),
    // rust: in_flight: IN_FLIGHT,
    // rust: per_second: PER_SECOND,
}
}
pub fn encode(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(VERSION as i32);
    // rust: w.varint(self.distance as i32);
    // rust: w.varint(self.in_flight as i32);
    // rust: w.varint(self.per_second as i32);
    // rust: w.data
}
    /// An offer, None when it serves nothing or speaks another version.
pub fn decode(data: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(data);
    // rust: let mut next = || r.varint().ok().and_then(|v| u32::try_from(v).ok());
    // rust: if next()? != VERSION {
    // rust: return None;
}
    // rust: let offer = Self {
    // rust: distance: next()?.min(MAX_DISTANCE),
    // rust: in_flight: next()?.min(64),
    // rust: per_second: next()?,
}
    // rust: (offer.distance > 0 && offer.in_flight > 0 && offer.per_second > 0).then_some(offer)
}
}

/// One far tile: [`SIDE`] x [`SIDE`] columns from block (`x`, `z`), each
/// `stride` blocks wide, as `LodSampler::grid` samples them.
pub const Request = struct {
    id: u32,
    x: i32,
    z: i32,
    stride: i32,
    /// Reduced far detail (`LodSampler::set_approximate`).
    approximate: bool,
};
    // rust: impl Request {
pub fn encode(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(self.id as i32);
    // rust: w.i32(self.x);
    // rust: w.i32(self.z);
    // rust: w.varint(self.stride);
    // rust: w.bool(self.approximate);
    // rust: w.data
}
pub fn decode(data: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = Reader::new(data);
    // rust: let request = Self {
    // rust: id: r.varint()? as u32,
    // rust: x: r.i32()?,
    // rust: z: r.i32()?,
    // rust: stride: r.varint()?,
    // rust: approximate: r.bool()?,
}
    // rust: if r.remaining() > 0 {
    // rust: return Err(Error::new("far terrain request: trailing bytes"));
}
    // rust: Ok(request)
}
    /// Whether the server serves it to a player at `position` when it allows
    /// `distance` chunks: a whole tile (aligned, a power-of-two stride no
    /// coarser than the client's coarsest tile at that distance) whose
    /// nearest point is within the distance.
pub fn allowed(self: *Self, distance: u32, position: [f64; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let coarsest = distance.next_power_of_two().min(MAX_DISTANCE) as i32;
    // rust: if distance == 0
    // rust: || self.stride < 1
    // rust: || self.stride > coarsest
    // rust: || self.stride.count_ones() != 1
    // rust: {
    // rust: return false;
}
    // rust: let size = self.stride * SIDE as i32;
    // rust: if self.x.rem_euclid(size) != 0 || self.z.rem_euclid(size) != 0 {
    // rust: return false;
}
    // rust: let gap = |c: f64, lo: i32| {
    // rust: (f64::from(lo) - c)
    // rust: .max(c - f64::from(lo) - f64::from(size))
    // rust: .max(0.0)
}
    // rust: let (dx, dz) = (gap(position[0], self.x), gap(position[2], self.z));
    // rust: let reach = f64::from((distance + SLACK) * 16);
    // rust: dx * dx + dz * dz <= reach * reach
}
}

/// A tile's columns as the server sends them: the request's id, then 0 and
/// the columns' biome names and columns, or 1 for a refusal. A tile the
/// client would refuse (past [`MAX_SPANS`] or [`MAX_REPLY`]) is refused.
pub fn encode_reply(id: u32, columns: ?*[Column], biome_names: *[[]const u8]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(id as i32);
    // rust: let spans: usize = columns.map_or(0, |c| c.iter().map(|c| c.spans.len()).sum());
    // rust: let Some(columns) = columns.filter(|_| spans <= MAX_SPANS) else {
    // rust: w.u8(1);
    // rust: return w.data;
}
    // rust: w.u8(0);
    // rust: let mut palette: Vec<u16> = Vec::new();
    // rust: let mut local = |biome: u16| -> i32 {
    // rust: let at = palette.iter().position(|&b| b == biome).unwrap_or_else(|| {
    // rust: palette.push(biome);
    // rust: palette.len() - 1
    // rust: });
    // rust: at as i32
}
    // rust: let mut body = Writer::new();
    // rust: body.varint(columns.len() as i32);
    // rust: for column in columns {
    // rust: match &column.surface {
    // rust: Some(s) => {
    // rust: body.bool(true);
    // rust: body.i32(s.height);
    // rust: body.varint(s.state.0 as i32);
    // rust: match s.water {
    // rust: Some((height, state)) => {
    // rust: body.bool(true);
    // rust: body.i32(height);
    // rust: body.varint(state.0 as i32);
}
    // rust: None => body.bool(false),
}
    // rust: body.varint(local(s.biome));
}
    // rust: None => body.bool(false),
}
    // rust: body.varint(column.spans.len() as i32);
    // rust: for span in &column.spans {
    // rust: body.i16(span.min);
    // rust: body.i16(span.max);
    // rust: body.varint(span.state.0 as i32);
    // rust: body.varint(local(span.biome));
    // rust: body.u16(span.light);
}
}
    // rust: if palette.len() > MAX_BIOMES {
    // rust: return refusal(id);
}
    // rust: w.varint(palette.len() as i32);
    // rust: for biome in palette {
    // rust: w.string(
    // rust: biome_names
    // rust: .get(usize::from(biome))
    // rust: .filter(|name| name.len() <= MAX_BIOME_NAME)
    // rust: .map_or("minecraft:plains", String::as_str),
    // rust: );
}
    // rust: w.bytes(&body.data);
    // rust: if w.data.len() > MAX_REPLY {
    // rust: return refusal(id);
}
    // rust: w.data
}

/// A refusal's payload: the tile isn't served.
pub fn refusal(id: u32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: encode_reply(id, None, &[])
}

/// The id a reply answers.
pub fn reply_id(data: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Reader::new(data).varint().ok().map(|id| id as u32)
}

/// A reply's columns (None: refused), biomes by this client's indices
/// (unknown ones as the first), block states below `states`. A reply a
/// Horizon server doesn't send is an error before it costs memory: too big,
/// too many spans, spans out of order or overlapping, heights out of range.
    // rust: pub fn decode_reply(
    // rust: data: &[u8],
    // rust: biomes: &HashMap<String, u16>,
    // rust: states: u32,
    // rust: ) -> Result<Option<Vec<Column>>> {
    // rust: if data.len() > MAX_REPLY {
    // rust: return Err(Error::new("far terrain: reply too big"));
}
    // rust: let mut r = Reader::new(data);
    // rust: r.varint()?;
    // rust: if r.u8()? != 0 {
    // rust: return Ok(None);
}
    // rust: let count = r.varint()?;
    // rust: if !(0..=MAX_BIOMES as i32).contains(&count) {
    // rust: return Err(Error::new("far terrain: too many biomes"));
}
    // rust: let palette: Vec<u16> = (0..count)
    // rust: .map(|_| Ok(biomes.get(&r.string(MAX_BIOME_NAME)?).copied().unwrap_or(0)))
    // rust: .collect::<Result<_>>()?;
    // rust: let biome = |r: &mut Reader| -> Result<u16> {
    // rust: palette
    // rust: .get(r.varint()? as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| Error::new("far terrain: biome out of the palette"))
}
    // rust: let state = |r: &mut Reader| -> Result<BlockStateId> {
    // rust: let id = r.varint()? as u32;
    // rust: if id >= states {
    // rust: return Err(Error::new("far terrain: unknown block state"));
}
    // rust: Ok(BlockStateId(id))
}
    // rust: let columns = r.varint()?;
    // rust: if columns != (SIDE * SIDE) as i32 {
    // rust: return Err(Error::new("far terrain: not a whole tile"));
}
    // rust: let height = |r: &mut Reader| -> Result<i32> {
    // rust: let y = r.i32()?;
    // rust: if !HEIGHTS.contains(&y) {
    // rust: return Err(Error::new("far terrain: height out of range"));
}
    // rust: Ok(y)
}
    // rust: let mut out = Vec::with_capacity(SIDE * SIDE);
    // rust: let mut total = 0;
    // rust: for _ in 0..columns {
    // rust: let surface = if r.bool()? {
    // rust: let height_ = height(&mut r)?;
    // rust: let top = state(&mut r)?;
    // rust: let water = if r.bool()? {
    // rust: Some((height(&mut r)?, state(&mut r)?))
    // rust: } else {
    // rust: None
}
    // rust: Some(Surface {
    // rust: height: height_,
    // rust: state: top,
    // rust: water,
    // rust: biome: biome(&mut r)?,
    // rust: })
    // rust: } else {
    // rust: None
}
    // rust: let count =
    // rust: usize::try_from(r.varint()?).map_err(|_| Error::new("far terrain: too many spans"))?;
    // rust: total += count;
    // rust: if total > MAX_SPANS {
    // rust: return Err(Error::new("far terrain: too many spans"));
}
    // rust: let mut spans = Spans::with_capacity(count);
    // rust: for _ in 0..count {
    // rust: let span = Span {
    // rust: min: r.i16()?,
    // rust: max: r.i16()?,
    // rust: state: state(&mut r)?,
    // rust: biome: biome(&mut r)?,
    // rust: light: r.u16()?,
}
    // rust: let floor = spans.last().map_or(*HEIGHTS.start(), |s| i32::from(s.max));
    // rust: if i32::from(span.min) < floor
    // rust: || span.min >= span.max
    // rust: || !HEIGHTS.contains(&i32::from(span.max))
    // rust: {
    // rust: return Err(Error::new("far terrain: spans out of order"));
}
    // rust: spans.push(span);
}
    // rust: out.push(Column { surface, spans });
}
    // rust: Ok(Some(out))
}

/// A token bucket: `rate` a second, `burst` at once.
pub const Bucket = struct {
    tokens: f64,
    rate: f64,
    burst: f64,
    at: Instant,
};
    // rust: impl Bucket {
pub fn new(rate: f64, burst: f64, now: Instant) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: tokens: burst,
    // rust: rate,
    // rust: burst,
    // rust: at: now,
}
}
    /// Takes a token when there is one.
pub fn take(self: *Self, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let elapsed = now.saturating_duration_since(self.at).as_secs_f64();
    // rust: self.tokens = (self.tokens + elapsed * self.rate).min(self.burst);
    // rust: self.at = now;
    // rust: if self.tokens >= 1.0 {
    // rust: self.tokens -= 1.0;
    // rust: true
    // rust: } else {
    // rust: false
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn tile() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..SIDE * SIDE)
    // rust: .map(|i| Column {
    // rust: surface: (i % 3 != 0).then_some(Surface {
    // rust: height: 60 + i as i32 % 7,
    // rust: state: BlockStateId(9),
    // rust: water: (i % 5 == 0).then_some((62, BlockStateId(86))),
    // rust: biome: (i % 4) as u16,
    // rust: }),
    // rust: spans: Spans::from(vec![Span {
    // rust: min: -64,
    // rust: max: 60,
    // rust: state: BlockStateId(1),
    // rust: biome: (i % 2) as u16,
    // rust: light: 240,
    // rust: }]),
    // rust: })
    // rust: .collect()
}

pub fn a_tile_crosses_by_biome_name() void {
}
    // rust: let server: Vec<String> = ["a", "b", "c", "d"].map(String::from).into();
    // rust: let data = encode_reply(7, Some(&tile()), &server);
    // rust: assert_eq!(reply_id(&data), Some(7));
        // The client lists the same biomes in another order.
    // rust: let client: HashMap<String, u16> = [("d", 0), ("c", 1), ("b", 2), ("a", 3)]
    // rust: .map(|(n, i)| (n.to_owned(), i))
    // rust: .into();
    // rust: let got = decode_reply(&data, &client, 100).unwrap().unwrap();
    // rust: let back = |b: u16| 3 - b;
    // rust: for (sent, got) in tile().iter().zip(&got) {
    // rust: assert_eq!(
    // rust: sent.surface.map(|s| s.height),
    // rust: got.surface.map(|s| s.height)
    // rust: );
    // rust: assert_eq!(sent.surface.map(|s| s.water), got.surface.map(|s| s.water));
    // rust: assert_eq!(
    // rust: sent.surface.map(|s| s.biome),
    // rust: got.surface.map(|s| back(s.biome))
    // rust: );
    // rust: assert_eq!(sent.spans[0].biome, back(got.spans[0].biome));
    // rust: assert_eq!(sent.spans[0].state, got.spans[0].state);
}
        // States the client doesn't have are refused, not drawn.
    // rust: assert!(decode_reply(&data, &client, 50).is_err());
    // rust: assert_eq!(decode_reply(&refusal(3), &client, 100).unwrap(), None);
}

pub fn hostile_replies_are_refused_before_they_cost_memory() void {
}
    // rust: let names: Vec<String> = ["a"].map(String::from).into();
    // rust: let client: HashMap<String, u16> = [("a".to_owned(), 0)].into();
    // rust: let span = |min, max| Span {
    // rust: min,
    // rust: max,
    // rust: state: BlockStateId(1),
    // rust: biome: 0,
    // rust: light: 0,
}
    // rust: let with = |spans: Vec<Span>| {
    // rust: let mut tile = vec![Column::default(); SIDE * SIDE];
    // rust: tile[0].spans = spans.into();
    // rust: encode_reply(1, Some(&tile), &names)
}
    // rust: assert!(decode_reply(&with(vec![span(0, 4), span(4, 9)]), &client, 9).is_ok());
        // Overlapping, out of order, empty or inverted spans.
    // rust: for spans in [
    // rust: vec![span(0, 4), span(2, 9)],
    // rust: vec![span(4, 9), span(0, 4)],
    // rust: vec![span(3, 3)],
    // rust: vec![span(-4000, 0)],
    // rust: ] {
    // rust: assert!(decode_reply(&with(spans), &client, 9).is_err());
}
        // A tile past the span cap is refused by the server and by the client.
    // rust: let many: Vec<Span> = (0..=MAX_SPANS as i16 / 4)
    // rust: .map(|i| span(i - 2048, i - 2047))
    // rust: .collect();
    // rust: let mut tile = vec![Column::default(); SIDE * SIDE];
    // rust: for column in &mut tile[..4] {
    // rust: column.spans = many.clone().into();
}
    // rust: assert_eq!(
    // rust: decode_reply(&with(Vec::new()), &client, 9)
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .len(),
    // rust: 256
    // rust: );
    // rust: assert_eq!(
    // rust: decode_reply(&encode_reply(2, Some(&tile), &names), &client, 9).unwrap(),
    // rust: None
    // rust: );
    // rust: let mut forged = Writer::new();
    // rust: forged.varint(2);
    // rust: forged.u8(0);
    // rust: forged.varint(1);
    // rust: forged.string("a");
    // rust: forged.varint(256);
    // rust: for i in 0..256 {
    // rust: forged.bool(false);
    // rust: forged.varint(if i < 4 { many.len() as i32 } else { 0 });
    // rust: for s in many.iter().take(if i < 4 { many.len() } else { 0 }) {
    // rust: forged.i16(s.min);
    // rust: forged.i16(s.max);
    // rust: forged.varint(1);
    // rust: forged.varint(0);
    // rust: forged.u16(0);
}
}
    // rust: let err = decode_reply(&forged.data, &client, 9).unwrap_err();
    // rust: assert!(err.to_string().contains("too many spans"), "{err}");
    // rust: assert!(decode_reply(&vec![0; MAX_REPLY + 1], &client, 9).is_err());
}

pub fn requests_and_offers_round_trip() void {
}
    // rust: let r = Request {
    // rust: id: 300,
    // rust: x: -512,
    // rust: z: 4096,
    // rust: stride: 2,
    // rust: approximate: true,
}
    // rust: assert_eq!(Request::decode(&r.encode()).unwrap(), r);
    // rust: let offer = Offer::new(96);
    // rust: assert_eq!(Offer::decode(&offer.encode()), Some(offer));
    // rust: assert_eq!(Offer::decode(&Offer::new(0).encode()), None);
        // Another version's offer is ignored.
    // rust: let mut other = offer.encode();
    // rust: other[0] = VERSION as u8 + 1;
    // rust: assert_eq!(Offer::decode(&other), None);
        // Off unless the owner sets it.
    // rust: assert_eq!(distance_property(None), 0);
    // rust: assert_eq!(distance_property(Some(" 64 ")), 64);
    // rust: assert_eq!(distance_property(Some("5000")), MAX_DISTANCE);
    // rust: assert_eq!(distance_property(Some("far")), 0);
}

pub fn only_tiles_within_the_distance_are_served() void {
}
    // rust: let at = [8.0, 70.0, 8.0];
    // rust: let tile = |x: i32, z: i32, stride: i32| Request {
    // rust: id: 0,
    // rust: x,
    // rust: z,
    // rust: stride,
    // rust: approximate: false,
}
        // 64 chunks, 8 more for movement: 1152 blocks.
    // rust: assert!(tile(1136, 0, 1).allowed(64, at));
    // rust: assert!(!tile(1168, 0, 1).allowed(64, at));
    // rust: assert!(!tile(1136, 1136, 1).allowed(64, at));
        // The coarsest tile 64 chunks plan: 64 blocks a cell.
    // rust: assert!(tile(0, 0, 64).allowed(64, at));
    // rust: assert!(!tile(0, 0, 128).allowed(64, at));
        // Whole tiles only, power-of-two strides.
    // rust: assert!(!tile(8, 0, 1).allowed(64, at));
    // rust: assert!(!tile(0, 0, 3).allowed(64, at));
    // rust: assert!(!tile(0, 0, 0).allowed(64, at));
    // rust: assert!(!tile(0, 0, -2).allowed(64, at));
    // rust: assert!(!tile(0, 0, 1).allowed(0, at));
}
}
