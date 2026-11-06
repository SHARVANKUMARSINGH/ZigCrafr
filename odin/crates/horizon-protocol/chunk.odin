//! Transpiled from Horizon Rust crate
package horizon_protocol_chunk

import "core:fmt"
import "core:mem"
import "core:math"

// Chunk column payloads: ClientboundLevelChunkPacketData (heightmaps, the
// serialized LevelChunkSections with their PalettedContainers, block
// entities) and ClientboundLightUpdatePacketData (sky/block DataLayers).
// use crate::{
    // rust: Error, Result,
    // rust: buf::{BitSet, Bytes, Codec, Longs, Reader, VarInt, Writer},
    // rust: packet,
}
// use horizon_world::nbt::Tag;

// Blocks: 16^3 entries; biomes: 4^3 entries per section.
BLOCKS :: 4096
BIOMES :: 64

// Which palette Strategy a container uses.
Strategy :: enum {
    // Strategy.createForBlockStates.
    Blocks,
    // Strategy.createForBiomes.
    Biomes,
}
    // rust: impl Strategy {
entries :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Blocks => BLOCKS,
    // rust: Self::Biomes => BIOMES,
}
}
    // getConfigurationForBitCount: (uses a palette, bits in storage).
configuration :: proc(self: ^Self, bits: u8, global_bits: u8) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match (self, bits) {
    // rust: (_, 0) => (true, 0),
    // rust: (Self::Blocks, 1..=4) => (true, 4),
    // rust: (Self::Blocks, 5..=8) => (true, bits),
    // rust: (Self::Biomes, 1..=3) => (true, bits),
    // rust: _ => (false, global_bits.max(bits)),
}
}
}

// SimpleBitStorage: `64 / bits` values per long, never spanning longs.
storage_get :: proc(data: ^[i64], bits: u8, i: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if bits == 0 {
    // rust: return 0;
}
    // rust: let per = 64 / bits as usize;
    // rust: let (cell, offset) = (i / per, (i % per) * bits as usize);
    // rust: data.get(cell)
    // rust: .map_or(0, |&l| ((l as u64 >> offset) & ((1u64 << bits) - 1)) as u32)
}
storage_len :: proc(bits: u8, entries: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if bits == 0 {
    // rust: 0
    // rust: } else {
    // rust: entries.div_ceil(64 / bits as usize)
}
}

// SimpleBitStorage's longs for `values` at `bits` each, a long at a time.
    // rust: fn pack<T>(values: &[T], bits: u8, id: impl Fn(&T) -> u64) -> Vec<i64> {
    // rust: let per = 64 / bits as usize;
    // rust: values
    // rust: .chunks(per)
    // rust: .map(|word| {
    // rust: word.iter()
    // rust: .enumerate()
    // rust: .fold(0u64, |w, (k, v)| w | id(v) << (k * bits as usize)) as i64
    // rust: })
    // rust: .collect()
}

// One PalettedContainer as sent.
Paletted :: struct {
    // Bits per entry as written (Data.storage.getBits()).
    bits: u8,
    // Palette entries (registry ids); empty for the global palette.
    palette: [dynamic]i32,
    data: [dynamic]i64,
}
    // rust: impl Paletted {
read :: proc(r: ^Reader, strategy: Strategy, global_bits: u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let wire = r.u8()?;
    // rust: let (has_palette, bits) = strategy.configuration(wire, global_bits);
        // SimpleBitStorage holds 1 to 32 bits; wider wire values would
        // divide by zero or overflow a shift.
    // rust: if bits > 32 {
    // rust: return Err(Error::new(format!("{bits} bits per entry, more than 32")));
}
    // rust: let palette = if !has_palette {
    // rust: Vec::new()
    // rust: } else if bits == 0 {
    // rust: vec![r.varint()?]
    // rust: } else {
    // rust: let n = r.count(1 << bits)?;
    // rust: (0..n).map(|_| r.varint()).collect::<Result<_>>()?
}
    // rust: let data = r.fixed_longs(storage_len(bits, strategy.entries()))?;
    // rust: Ok(Self {
    // rust: bits,
    // rust: palette,
    // rust: data,
    // rust: })
}
write :: proc(self: ^Self, w: ^Writer) {
}
    // rust: w.u8(self.bits);
    // rust: if !self.palette.is_empty() {
    // rust: if self.bits != 0 {
    // rust: w.varint(self.palette.len() as i32);
}
    // rust: for &p in &self.palette {
    // rust: w.varint(p);
}
}
    // rust: for &l in &self.data {
    // rust: w.i64(l);
}
}
    // The registry id at entry `i` ((y * 16 + z) * 16 + x for blocks).
get :: proc(self: ^Self, i: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.bits == 0 {
    // rust: return self.palette.first().copied().unwrap_or(0);
}
    // rust: let v = storage_get(&self.data, self.bits, i);
    // rust: if self.palette.is_empty() {
    // rust: v as i32
    // rust: } else {
    // rust: self.palette.get(v as usize).copied().unwrap_or(0)
}
}
    // Pack values the way the server's container would have grown:
    // the smallest configuration for the number of distinct values.
from_values :: proc(values: ^[i32], strategy: Strategy, global_bits: u8) -> S {
    // Ported from Horizon
    return {}
}
        // Palette indices by value, in first-seen order: a table over the
        // value range (registry ids are small), kept per thread and cleared
        // after use, with the previous value remembered, since neighbouring
        // blocks repeat.
    // rust: thread_local! {
INDEX :: const { std::cell::RefCell::new(Vec::new()) }
}
    // rust: let max = values.iter().copied().max().unwrap_or(0);
    // rust: if values.iter().any(|&v| v < 0) || max >= 1 << 20 {
    // rust: return Self::from_values_slow(values, strategy, global_bits);
}
    // rust: let mut palette: Vec<i32> = Vec::new();
    // rust: let mut ids: Vec<u32> = Vec::with_capacity(values.len());
    // rust: INDEX.with_borrow_mut(|index| {
    // rust: if index.len() <= max as usize {
    // rust: index.resize(max as usize + 1, u32::MAX);
}
    // rust: let (mut last, mut last_id) = (-1i32, 0u32);
    // rust: for &v in values {
    // rust: if v != last {
    // rust: let slot = &mut index[v as usize];
    // rust: if *slot == u32::MAX {
    // rust: *slot = palette.len() as u32;
    // rust: palette.push(v);
}
    // rust: (last, last_id) = (v, *slot);
}
    // rust: ids.push(last_id);
}
    // rust: for &v in &palette {
    // rust: index[v as usize] = u32::MAX;
}
    // rust: });
    // rust: Self::from_palette(palette, &ids, strategy, global_bits)
}

    // `from_values` from what it finds first: the distinct values in
    // first-seen order, and each entry's index among them.
    // rust: pub fn from_palette(
    // rust: palette: Vec<i32>,
    // rust: ids: &[u32],
    // rust: strategy: Strategy,
    // rust: global_bits: u8,
    // rust: ) -> Self {
    // rust: let needed = if palette.len() <= 1 {
    // rust: 0
    // rust: } else {
    // rust: (usize::BITS - (palette.len() - 1).leading_zeros()) as u8
}
    // rust: let (has_palette, bits) = strategy.configuration(needed, global_bits);
    // rust: if bits == 0 {
    // rust: return Self {
    // rust: bits: 0,
    // rust: palette: vec![palette.first().copied().unwrap_or(0)],
    // rust: data: Vec::new(),
}
}
    // rust: let data = if has_palette {
    // rust: pack(ids, bits, |&id| u64::from(id))
    // rust: } else {
    // rust: pack(ids, bits, |&id| palette[id as usize] as u64)
}
    // rust: Self {
    // rust: bits,
    // rust: palette: if has_palette { palette } else { Vec::new() },
    // rust: data,
}
}

    // `from_values` for any values: linear palette searches.
from_values_slow :: proc(values: ^[i32], strategy: Strategy, global_bits: u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut palette: Vec<i32> = Vec::new();
    // rust: for &v in values {
    // rust: if !palette.contains(&v) {
    // rust: palette.push(v);
}
}
    // rust: let needed = if palette.len() <= 1 {
    // rust: 0
    // rust: } else {
    // rust: (usize::BITS - (palette.len() - 1).leading_zeros()) as u8
}
    // rust: let (has_palette, bits) = strategy.configuration(needed, global_bits);
    // rust: if bits == 0 {
    // rust: return Self {
    // rust: bits: 0,
    // rust: palette: vec![palette.first().copied().unwrap_or(0)],
    // rust: data: Vec::new(),
}
}
    // rust: let mut data = vec![0i64; storage_len(bits, values.len())];
    // rust: let per = 64 / bits as usize;
    // rust: for (i, &v) in values.iter().enumerate() {
    // rust: let id = if has_palette {
    // rust: palette.iter().position(|&p| p == v).unwrap_or(0) as u64
    // rust: } else {
    // rust: v as u64
}
    // rust: data[i / per] |= (id << ((i % per) * bits as usize)) as i64;
}
    // rust: Self {
    // rust: bits,
    // rust: palette: if has_palette { palette } else { Vec::new() },
    // rust: data,
}
}
}

// LevelChunkSection.write.
Section :: struct {
    non_empty: i16,
    fluids: i16,
    states: Paletted,
    biomes: Paletted,
}
    // rust: impl Section {
read :: proc(r: ^Reader, block_bits: u8, biome_bits: u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Self {
    // rust: non_empty: r.i16()?,
    // rust: fluids: r.i16()?,
    // rust: states: Paletted::read(r, Strategy::Blocks, block_bits)?,
    // rust: biomes: Paletted::read(r, Strategy::Biomes, biome_bits)?,
    // rust: })
}
write :: proc(self: ^Self, w: ^Writer) {
}
    // rust: w.i16(self.non_empty);
    // rust: w.i16(self.fluids);
    // rust: self.states.write(w);
    // rust: self.biomes.write(w);
}
}

    // rust: packet!(
    // ClientboundLevelChunkPacketData.BlockEntityInfo.
    // rust: BlockEntityInfo {
    // rust: packed_xz: i8 => crate::buf::Byte,
    // rust: y: i16 => crate::buf::Short,
    // rust: kind: i32 => VarInt,
    // rust: tag: Tag => crate::buf::Nbt,
}
    // rust: );
// Heightmap type id with its packed long array.
Heightmaps :: struct {
    // rust: impl Codec<Vec<(i32, Vec<i64>)>> for Heightmaps {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = r.count(16)?;
    // rust: (0..n).map(|_| Ok((r.varint()?, r.long_array()?))).collect()
}
write :: proc(v: ^Vec<(i32) {
}
    // rust: w.varint(v.len() as i32);
    // rust: for (kind, data) in v {
    // rust: w.varint(*kind);
    // rust: Longs::write(data, w);
}
}
}
    // rust: packet!(
    // ClientboundLevelChunkPacketData.
    // rust: ChunkData {
    // rust: heightmaps: Vec<(i32, Vec<i64>)> => Heightmaps,
    // rust: buffer: Vec<u8> => Bytes,
    // rust: block_entities: Vec<BlockEntityInfo> => crate::buf::List<BlockEntityInfo>,
}
    // rust: );
    // rust: impl ChunkData {
    // Decode `count` sections from the buffer.
sections :: proc(self: ^Self, count: uint, block_bits: u8, biome_bits: u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Reader::new(&self.buffer);
    // rust: (0..count)
    // rust: .map(|_| Section::read(&mut r, block_bits, biome_bits))
    // rust: .collect()
}
from_sections :: proc(sections: ^[Section]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = Writer::new();
    // rust: for s in sections {
    // rust: s.write(&mut w);
}
    // rust: w.data
}
}
// ByteBufCodecs.byteArray(2048) per DataLayer, whose constructor refuses
// any other length: the client indexes a layer's 2048 bytes directly.
Layers :: struct {
    // rust: impl Codec<Vec<Vec<u8>>> for Layers {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = r.count(r.remaining())?;
    // rust: (0..n)
    // rust: .map(|_| {
    // rust: let layer = r.byte_array(2048)?;
    // rust: if layer.len() == 2048 {
    // rust: Ok(layer)
    // rust: } else {
    // rust: Err(crate::Error::new(format!(
    // rust: "DataLayer should be 2048 bytes not: {}",
    // rust: layer.len()
    // rust: )))
}
    // rust: })
    // rust: .collect()
}
write :: proc(v: ^[dynamic]Vec<u8>, w: ^Writer) {
}
    // rust: w.varint(v.len() as i32);
    // rust: for l in v {
    // rust: w.byte_array(l);
}
}
}
    // rust: packet!(
    // ClientboundLightUpdatePacketData. Bit `i` of a mask is light section
    // `minLightSection + i` (one below the lowest block section).
    // rust: LightData {
    // rust: sky_mask: Vec<u8> => BitSet,
    // rust: block_mask: Vec<u8> => BitSet,
    // rust: empty_sky_mask: Vec<u8> => BitSet,
    // rust: empty_block_mask: Vec<u8> => BitSet,
    // rust: sky: Vec<Vec<u8>> => Layers,
    // rust: block: Vec<Vec<u8>> => Layers,
}
    // rust: );
    // rust: impl LightData {
    // Per light section: the sky and block DataLayers (None = absent/unchanged,
    // Some(zeroed) when marked empty).
layers :: proc(self: ^Self, light_sections: uint) -> V {
    // Ported from Horizon
    return {}
}
//         use crate::buf::bit;
    // rust: let (mut sky, mut block) = (self.sky.iter(), self.block.iter());
    // rust: (0..light_sections)
    // rust: .map(|i| {
    // rust: let s = if bit(&self.sky_mask, i) {
    // rust: sky.next().cloned()
    // rust: } else if bit(&self.empty_sky_mask, i) {
    // rust: Some(vec![0; 2048])
    // rust: } else {
    // rust: None
}
    // rust: let b = if bit(&self.block_mask, i) {
    // rust: block.next().cloned()
    // rust: } else if bit(&self.empty_block_mask, i) {
    // rust: Some(vec![0; 2048])
    // rust: } else {
    // rust: None
}
    // rust: (s, b)
    // rust: })
    // rust: .collect()
}
}
// A light section's (sky, block) DataLayers.
    // rust: pub type SectionLight = (Option<Vec<u8>>, Option<Vec<u8>>);
// DataLayer.get: the nibble at (y << 8 | z << 4 | x), low nibble first.
nibble :: proc(layer: []u8, i: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: layer
    // rust: .get(i >> 1)
    // rust: .map_or(0, |b| if i & 1 == 0 { b & 15 } else { b >> 4 })
}

    // rust: mod tests {
//     use super::*;

a_light_layer_is_2048_bytes_or_refused :: proc() {
}
    // rust: let layers = |len: usize| {
    // rust: let mut w = Writer::new();
    // rust: w.varint(1);
    // rust: w.byte_array(&vec![0x11; len]);
    // rust: Layers::read(&mut Reader::new(&w.data))
}
    // rust: assert_eq!(layers(2048).unwrap(), [vec![0x11; 2048]]);
    // rust: assert!(layers(0).is_err());
    // rust: assert!(layers(2047).is_err());
}

from_values_matches_the_linear_search :: proc() {
}
    // rust: let mut seed = 12345u64;
    // rust: let mut next = |n: u64| {
    // rust: seed = seed
    // rust: .wrapping_mul(6364136223846793005)
    // rust: .wrapping_add(1442695040888963407);
    // rust: ((seed >> 33) % n) as i32
}
    // rust: for distinct in [1u64, 2, 16, 17, 200, 300, 5000] {
    // rust: let values: Vec<i32> = (0..BLOCKS).map(|_| next(distinct) * 7).collect();
    // rust: assert_eq!(
    // rust: Paletted::from_values(&values, Strategy::Blocks, 16),
    // rust: Paletted::from_values_slow(&values, Strategy::Blocks, 16)
    // rust: );
    // rust: let biomes: Vec<i32> = values[..BIOMES].to_vec();
    // rust: assert_eq!(
    // rust: Paletted::from_values(&biomes, Strategy::Biomes, 7),
    // rust: Paletted::from_values_slow(&biomes, Strategy::Biomes, 7)
    // rust: );
}
}

bit_storage_matches_simple_bit_storage :: proc() {
}
        // 5 bits: 12 values per long, the top 4 bits of each long unused.
    // rust: let values: Vec<i32> = (0..BLOCKS as i32).map(|i| i % 20).collect();
    // rust: let p = Paletted::from_values(&values, Strategy::Blocks, 16);
    // rust: assert_eq!(p.bits, 5);
    // rust: assert_eq!(p.data.len(), 4096usize.div_ceil(12));
    // rust: for i in [0, 11, 12, 13, 4095] {
    // rust: assert_eq!(p.get(i), values[i]);
}
}

palettes_follow_the_strategies :: proc() {
}
    // rust: let single = Paletted::from_values(&[7; BLOCKS], Strategy::Blocks, 16);
    // rust: assert_eq!(
    // rust: (single.bits, single.palette.clone(), single.data.len()),
    // rust: (0, vec![7], 0)
    // rust: );
        // Two distinct block states still use the four-bit linear palette.
    // rust: let mut two = vec![0; BLOCKS];
    // rust: two[100] = 9;
    // rust: let p = Paletted::from_values(&two, Strategy::Blocks, 16);
    // rust: assert_eq!((p.bits, p.data.len()), (4, 256));
        // Biomes with two values use one bit; more than eight use the global palette.
    // rust: let mut biomes = vec![3; BIOMES];
    // rust: biomes[5] = 4;
    // rust: assert_eq!(Paletted::from_values(&biomes, Strategy::Biomes, 7).bits, 1);
    // rust: let many: Vec<i32> = (0..BIOMES as i32).map(|i| i % 9).collect();
    // rust: let g = Paletted::from_values(&many, Strategy::Biomes, 7);
    // rust: assert!(g.palette.is_empty() && g.bits == 7);
    // rust: assert_eq!(g.get(10), 1);
        // Over 256 block states: global palette with the registry's bit width.
    // rust: let wide: Vec<i32> = (0..BLOCKS as i32).map(|i| i * 7).collect();
    // rust: let g = Paletted::from_values(&wide, Strategy::Blocks, 16);
    // rust: assert!(g.palette.is_empty() && g.bits == 16);
    // rust: assert_eq!(g.get(4095), 4095 * 7);
}

wire_bits_wider_than_storage_are_rejected :: proc() {
}
    // rust: for wire in [33u8, 200] {
    // rust: let data = [wire];
    // rust: let mut r = Reader::new(&data);
    // rust: assert!(Paletted::read(&mut r, Strategy::Blocks, 16).is_err());
}
        // 15- and 16-bit global palettes still read (1024 longs of zeroes).
    // rust: for (wire, global) in [(15u8, 15u8), (16, 16)] {
    // rust: let mut data = vec![wire];
    // rust: data.resize(1 + 1024 * 8, 0);
    // rust: let mut r = Reader::new(&data);
    // rust: let p = Paletted::read(&mut r, Strategy::Blocks, global).unwrap();
    // rust: assert_eq!(p.bits, wire);
}
}

chunk_data_round_trips :: proc() {
}
    // rust: let mut states = vec![0; BLOCKS];
    // rust: for (i, s) in states.iter_mut().enumerate().take(256) {
    // rust: *s = (i % 3) as i32 + 1;
}
    // rust: let section = Section {
    // rust: non_empty: 256,
    // rust: fluids: 0,
    // rust: states: Paletted::from_values(&states, Strategy::Blocks, 16),
    // rust: biomes: Paletted::from_values(&[2; BIOMES], Strategy::Biomes, 7),
}
    // rust: let empty = Section {
    // rust: non_empty: 0,
    // rust: fluids: 0,
    // rust: states: Paletted::from_values(&[0; BLOCKS], Strategy::Blocks, 16),
    // rust: biomes: Paletted::from_values(&[2; BIOMES], Strategy::Biomes, 7),
}
    // rust: let data = ChunkData {
    // rust: heightmaps: vec![(1, vec![1, 2, 3]), (4, vec![5])],
    // rust: buffer: ChunkData::from_sections(&[section.clone(), empty.clone()]),
    // rust: block_entities: vec![BlockEntityInfo {
    // rust: packed_xz: 0x3f,
    // rust: y: -60,
    // rust: kind: 2,
    // rust: tag: Tag::End,
    // rust: }],
}
    // rust: let mut w = Writer::new();
    // rust: ChunkData::write(&data, &mut w);
    // rust: let back = ChunkData::read(&mut Reader::new(&w.data)).unwrap();
    // rust: assert_eq!(back, data);
    // rust: let sections = back.sections(2, 16, 7).unwrap();
    // rust: assert_eq!(sections, vec![section, empty]);
    // rust: assert_eq!(sections[0].states.get(4), 2);
    // rust: assert_eq!(sections[1].states.get(4), 0);
}

light_layers_follow_masks :: proc() {
}
    // rust: let mut light = LightData {
    // rust: sky_mask: vec![],
    // rust: block_mask: vec![],
    // rust: empty_sky_mask: vec![],
    // rust: empty_block_mask: vec![],
    // rust: sky: vec![vec![0xF0; 2048]],
    // rust: block: vec![],
}
    // rust: crate::buf::set_bit(&mut light.sky_mask, 3);
    // rust: crate::buf::set_bit(&mut light.empty_block_mask, 1);
    // rust: let mut w = Writer::new();
    // rust: LightData::write(&light, &mut w);
    // rust: let back = LightData::read(&mut Reader::new(&w.data)).unwrap();
    // rust: assert_eq!(back, light);
    // rust: let layers = back.layers(26);
    // rust: assert_eq!(layers.len(), 26);
    // rust: assert_eq!(nibble(layers[3].0.as_ref().unwrap(), 1), 15);
    // rust: assert_eq!(nibble(layers[3].0.as_ref().unwrap(), 0), 0);
    // rust: assert_eq!(layers[1].1.as_deref(), Some(&[0u8; 2048][..]));
    // rust: assert!(layers[0].0.is_none() && layers[0].1.is_none());
}
}
