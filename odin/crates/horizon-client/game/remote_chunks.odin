//! Transpiled from Horizon Rust crate
package horizon_client_remote_chunks

import "core:fmt"
import "core:mem"
import "core:math"

// A server's chunk columns (`ClientboundLevelChunkWithLightPacket`): the
// sections and light of each packet become a client column on a decoder
// thread as soon as the packet arrives, so the frame that handles it in
// order only inserts the result (`ClientPacketListener.handleLevelChunkWithLight`).
// use super::Game;
// use horizon_client::{
    // rust: chunk::{
    // rust: BIOME_STRATEGY, Chunk, ColumnLayout, Light, Section, block_strategy, known_blocks_only,
    // rust: },
    // rust: streaming::Streaming,
}
// use horizon_core::paletted::{PalettedContainer, Strategy};
// use horizon_protocol::{
    // rust: chunk::{LightData, Paletted, SectionLight},
    // rust: packets::play::{self, Clientbound as C},
    // rust: registry::DimensionType,
}
// use horizon_world::attachments::Holder;
// use std::sync::{
    // rust: Arc,
    // rust: mpsc::{self, TryRecvError},
}

// What turning a chunk packet into a client column depends on: the
// dimension's height and sky, and the server's biome registry mapped to
// ours. The connection replaces it when either changes, so a column decoded
// with an older one is decoded again.
    // rust: pub(super) struct ChunkFormat {
    // The column decoded chunks hold: the client's for the level.
    // rust: column: ColumnLayout,
    // rust: min_y: i32,
    // rust: sections: usize,
    // rust: has_skylight: bool,
    // rust: biome_map: Vec<u16>,
    // rust: biome_bits: u8,
}

    // rust: impl ChunkFormat {
    // rust: pub(super) fn new(dimension: &DimensionType, biome_map: Vec<u16>, biome_bits: u8) -> Self {
    // rust: Self {
    // rust: column: ColumnLayout::VANILLA,
    // rust: min_y: dimension.min_y,
    // rust: sections: dimension.sections(),
    // rust: has_skylight: dimension.has_skylight,
    // rust: biome_map,
    // rust: biome_bits,
}
}
    // Decodes into chunks of `column`.
    // rust: pub(super) fn in_column(self, column: ColumnLayout) -> Self {
    // rust: Self { column, ..self }
}
    // The column decoded chunks hold.
    // rust: pub(super) fn layout(&self) -> ColumnLayout {
    // rust: self.column
}
    // rust: pub(super) fn with_dimension(&self, dimension: &DimensionType) -> Self {
    // rust: Self {
    // rust: column: self.column,
    // rust: ..Self::new(dimension, self.biome_map.clone(), self.biome_bits)
}
}

    // LevelChunkSection data into the client's column.
column :: proc(self: ^Self, p: ^play::LevelChunkWithLight) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let sections = p
    // rust: .chunk
    // rust: .sections(self.sections, 16, self.biome_bits)
    // rust: .map_err(|e| e.to_string())?;
    // rust: let mut chunk = Chunk::with_layout(p.x, p.z, self.column);
    // rust: let offset = (self.min_y - self.column.min_y()).div_euclid(16);
    // rust: let column = self.column.sections() as i32;
    // rust: for (i, s) in sections.iter().enumerate() {
    // rust: let target = offset + i as i32;
    // rust: if !(0..column).contains(&target) {
    // rust: continue;
}
            // A global section is as wide as the server's registry: 16 bits
            // from a vanilla server, wider from a Horizon host with the same
            // content mods. Read it at that width, then widen it to ours.
    // rust: let ours = block_strategy();
    // rust: let strategy = if ours.wire_has_palette(s.states.bits) {
    // rust: ours
    // rust: } else {
    // rust: Strategy::blocks(s.states.bits)
}
    // rust: let palette = s.states.palette.iter().map(|&p| p as u32).collect();
    // rust: let words = s.states.data.iter().map(|&w| w as u64).collect();
    // rust: let blocks = known_blocks_only(
    // rust: PalettedContainer::from_wire(strategy, s.states.bits, palette, words)
    // rust: .map_err(|e| e.to_string())?,
    // rust: );
    // rust: let mut section = Section {
    // rust: blocks,
    // rust: biomes: PalettedContainer::new(BIOME_STRATEGY, 0),
    // rust: light: Light::Uniform(0xF0),
}
    // rust: section.compact();
    // rust: chunk.sections[target as usize] = Arc::new(section);
}
    // rust: let biomes: Vec<_> = sections.iter().map(|s| &s.biomes).collect();
    // rust: self.put_biomes(&mut chunk, &biomes);
        // ClientPacketListener.applyLightData: the column keeps the light
        // the server sent; nothing is relit.
    // rust: let (layers, above) = self.light(&p.light);
    // rust: horizon_client::light::light_from_layers(&mut chunk, &layers, above, self.has_skylight);
        // From the single-player server thread: its own sections where they
        // are the same.
    // rust: horizon_client::lan::handoff::take(&mut chunk);
    // rust: Ok(chunk)
}

    // The dimension's sections' biome containers (in the server's
    // registry) into the column's sections. Sections outside the
    // dimension's range take its nearest biomes (the column's top or bottom
    // cell layer repeated).
put_biomes :: proc(self: ^Self, chunk: ^Chunk, biomes: ^[^Paletted]) {
}
    // rust: if biomes.is_empty() {
    // rust: return;
}
    // rust: let offset = (self.min_y - self.column.min_y()).div_euclid(16);
        // Biome table index per quart cell of the dimension's own sections.
    // rust: let biome_cells: Vec<[u32; 64]> = biomes
    // rust: .iter()
    // rust: .map(|b| {
    // rust: std::array::from_fn(|j| {
    // rust: u32::from(self.biome_map.get(b.get(j) as usize).copied().unwrap_or(0))
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let last = biome_cells.len() - 1;
    // rust: for si in 0..self.column.sections() as i32 {
    // rust: let i = si - offset;
    // rust: let cells = if (0..biome_cells.len() as i32).contains(&i) {
    // rust: biome_cells[i as usize]
    // rust: } else {
    // rust: let (edge, layer) = if i < 0 { (0, 0) } else { (last, 3) };
    // rust: std::array::from_fn(|j| biome_cells[edge][layer * 16 + j % 16])
}
    // rust: let mut container = PalettedContainer::from_values(BIOME_STRATEGY, &cells);
    // rust: if let Some(v) = container.uniform() {
    // rust: container = PalettedContainer::new(BIOME_STRATEGY, v);
}
    // rust: Arc::make_mut(&mut chunk.sections[si as usize]).biomes = container;
}
}

    // `LevelChunk.replaceBiomes`: each of the dimension's sections reads
    // its biome container from the packet's buffer, in order.
replace_biomes :: proc(self: ^Self, chunk: ^Chunk, data: ^play::ChunkBiomeData) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let biomes = data
    // rust: .biomes(self.sections, self.biome_bits)
    // rust: .map_err(|e| e.to_string())?;
    // rust: self.put_biomes(chunk, &biomes.iter().collect::<Vec<_>>());
    // rust: Ok(())
}

    // `ClientPacketListener.readSectionList`: the sky and block layers of a
    // light packet, by section of the client's column, and the sky light
    // above the column's top section (from the light section just above
    // it, else open sky).
    // rust: pub(super) fn light(&self, light: &LightData) -> (Vec<SectionLight>, [u8; 256]) {
    // rust: let column = self.column.sections() as i32;
    // rust: let mut layers: Vec<SectionLight> = vec![(None, None); self.column.sections()];
    // rust: let sky = self.has_skylight;
    // rust: let mut above = [if sky { 15 } else { 0 }; 256];
        // Light section b is the dimension's section b - 1.
    // rust: let first = (self.min_y - self.column.min_y()).div_euclid(16) - 1;
    // rust: for (b, layer) in light.layers(self.sections + 2).into_iter().enumerate() {
    // rust: let si = first + b as i32;
    // rust: if (0..column).contains(&si) {
    // rust: layers[si as usize] = layer;
    // rust: } else if si == column
    // rust: && sky
    // rust: && let Some(l) = &layer.0
    // rust: {
    // rust: for (i, a) in above.iter_mut().enumerate() {
    // rust: *a = (l[i >> 1] >> ((i & 1) * 4)) & 15;
}
}
}
    // rust: (layers, above)
}
}

    // rust: type Decoded = (Box<C>, Result<Chunk, String>);

// One thread that decodes chunk packets in the order they arrived; its
// results come back in that order, one per `submit`.
    // rust: pub(super) struct ChunkDecoder {
    // rust: jobs: mpsc::Sender<(Arc<ChunkFormat>, Box<C>)>,
    // rust: done: mpsc::Receiver<Decoded>,
}

    // rust: impl ChunkDecoder {
    // rust: pub(super) fn new() -> Self {
    // rust: let (jobs, todo) = mpsc::channel::<(Arc<ChunkFormat>, Box<C>)>();
    // rust: let (finished, done) = mpsc::channel();
        // The thread ends with the connection, when `jobs` is dropped.
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Chunk decoder".into())
    // rust: .spawn(move || {
                // A frame waits for its columns, as it would for the render
                // thread's own work.
    // rust: horizon_threads::favour_current();
    // rust: for (format, packet) in todo {
    // rust: let column = match &*packet {
    // rust: C::LevelChunkWithLight(p) => format.column(p),
    // rust: _ => Err("not a chunk packet".into()),
}
    // rust: if finished.send((packet, column)).is_err() {
    // rust: break;
}
}
    // rust: });
    // rust: if let Err(e) = spawned {
    // rust: log::warn!("Horizon: no chunk decoder thread ({e}); chunks decode in the frame");
}
    // rust: Self { jobs, done }
}

    // Start decoding a chunk packet with the format it arrived under.
    // Without a decoder thread the packet comes back undecoded.
    // rust: pub(super) fn submit(&self, format: Arc<ChunkFormat>, packet: Box<C>) -> Option<Box<C>> {
    // rust: self.jobs.send((format, packet)).err().map(|e| (e.0).1)
}

    // The oldest submitted packet and its column, unless it is still
    // decoding: a frame never waits for the decoder.
    // rust: pub(super) fn next(&self) -> Next {
    // rust: match self.done.try_recv() {
    // rust: Ok(decoded) => Next::Ready(decoded),
    // rust: Err(TryRecvError::Empty) => Next::Decoding,
            // The decoder thread panicked: its columns are gone.
    // rust: Err(TryRecvError::Disconnected) => Next::Lost,
}
}
}

    // rust: pub(super) enum Next {
    // rust: Ready(Decoded),
    // rust: Decoding,
    // rust: Lost,
}

    // rust: impl Game<'_> {
    // `handleLevelChunkWithLight`: the column replaces any loaded one, and
    // its block entities load their update tags. `decoded` is the column the
    // decoder made with `format`; another format since means decode again.
    // rust: pub(super) fn remote_chunk(
    // rust: &mut self,
    // rust: p: &play::LevelChunkWithLight,
    // rust: decoded: Option<(&Arc<ChunkFormat>, Result<Chunk, String>)>,
    // rust: ) {
        // ClientChunkCache.replaceWithPacketData: a column outside the
        // storage around the view centre is ignored.
    // rust: if !self.remote_chunk_in_range(p.x, p.z) {
    // rust: log::warn!(
    // rust: "Ignoring chunk since it's not in the view range: {}, {}",
    // rust: p.x,
    // rust: p.z
    // rust: );
    // rust: return;
}
    // rust: let Some(format) = self.remote.as_ref().map(|r| r.chunk_format.clone()) else {
    // rust: return;
}
    // rust: let column = match decoded {
    // rust: Some((used, column)) if Arc::ptr_eq(used, &format) => column,
    // rust: _ => format.column(p),
}
    // rust: let chunk = match column {
    // rust: Ok(chunk) => chunk,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: chunk {} {}: {e}", p.x, p.z);
    // rust: return;
}
}
    // rust: let (x, z) = (p.x, p.z);
        // A column sent again while it is resident (a bulk edit): only what changed is lit and meshed again.
    // rust: if self.world.chunks.contains_key(&(x, z)) {
    // rust: horizon_client::spans::time("replace_remote", || {
    // rust: self.streaming.replace_remote(&mut self.world, chunk)
    // rust: });
    // rust: } else {
    // rust: self.streaming.insert_remote(&mut self.world, chunk);
}
    // rust: self.world
    // rust: .block_entities
    // rust: .retain(|k, _| (k.0 >> 4, k.2 >> 4) != (x, z));
    // rust: for info in &p.chunk.block_entities {
    // rust: let pos = (
    // rust: x * 16 + i32::from(info.packed_xz as u8 >> 4),
    // rust: i32::from(info.y),
    // rust: z * 16 + i32::from(info.packed_xz as u8 & 15),
    // rust: );
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: self.sync_block_entity(pos, None, state);
            // LevelChunk.replaceWithPacketData: the block entity loads its update tag.
    // rust: self.remote_block_entity_data([pos.0, pos.1, pos.2], info.kind, &info.tag);
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.attachments.retain(|holder, _| match *holder {
    // rust: Holder::BlockEntity([bx, by, bz]) => {
    // rust: (bx >> 4, bz >> 4) != (x, z)
    // rust: || self.world.block_entities.contains_key(&(bx, by, bz))
}
    // rust: _ => true,
    // rust: });
}
}

    // `ClientPacketListener.handleChunksBiomes`: each loaded column takes
    // its new biomes (`ClientChunkCache.replaceBiomes`), then every section
    // of it and of its neighbours is drawn again, as their colours blend
    // across columns (`LevelExtractor.setSectionDirty`).
    // rust: pub(super) fn remote_chunks_biomes(&mut self, p: &play::ChunksBiomes) {
    // rust: let Some(format) = self.remote.as_ref().map(|r| r.chunk_format.clone()) else {
    // rust: return;
}
    // rust: for data in &p.chunks {
    // rust: let [x, z] = data.pos;
    // rust: if !self.remote_chunk_in_range(x, z) {
    // rust: log::warn!("Ignoring chunk since it's not in the view range: {x}, {z}");
    // rust: continue;
}
    // rust: let Some(chunk) = self.world.chunks.get_mut(&(x, z)) else {
    // rust: log::warn!("Ignoring chunk since it's not present: {x}, {z}");
    // rust: continue;
}
    // rust: if let Err(e) = format.replace_biomes(Arc::make_mut(chunk), data) {
    // rust: log::warn!("Horizon: biomes of chunk {x} {z}: {e}");
}
}
    // rust: for data in &p.chunks {
    // rust: let [x, z] = data.pos;
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: if !self.world.chunks.contains_key(&(x + dx, z + dz)) {
    // rust: continue;
}
    // rust: for sy in 0..self.world.layout().sections() as i32 {
    // rust: self.world.dirty_sections.insert((x + dx, sy, z + dz));
}
}
}
}
}

    // `handleLightUpdatePacket`: the sections it names take its light.
    // rust: pub(super) fn remote_light_update(&mut self, p: &play::LightUpdate) {
    // rust: let Some(format) = self.remote.as_ref().map(|r| r.chunk_format.clone()) else {
    // rust: return;
}
    // rust: if !self.world.chunks.contains_key(&(p.x, p.z)) {
    // rust: return;
}
    // rust: let (layers, _) = format.light(&p.light);
    // rust: let Some(chunk) = self.world.chunks.get_mut(&(p.x, p.z)) else {
    // rust: return;
}
    // rust: let changed = horizon_client::light::update_light_layers(
    // rust: Arc::make_mut(chunk),
    // rust: &layers,
    // rust: format.has_skylight,
    // rust: );
    // rust: Streaming::light_updated(&mut self.world, p.x, p.z, &changed);
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_protocol::chunk::{ChunkData, Paletted, Section as Wire, Strategy as Wiring};

    // A column of `state` with biome 1 everywhere, unlit.
packet :: proc(x: i32, state: i32) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let section = Wire {
    // rust: non_empty: 4096,
    // rust: fluids: 0,
    // rust: states: Paletted::from_values(&[state; 4096], Wiring::Blocks, 16),
    // rust: biomes: Paletted::from_values(&[1; 64], Wiring::Biomes, 2),
}
    // rust: let none = LightData {
    // rust: sky_mask: Vec::new(),
    // rust: block_mask: Vec::new(),
    // rust: empty_sky_mask: Vec::new(),
    // rust: empty_block_mask: Vec::new(),
    // rust: sky: Vec::new(),
    // rust: block: Vec::new(),
}
    // rust: Box::new(C::LevelChunkWithLight(play::LevelChunkWithLight {
    // rust: x,
    // rust: z: -3,
    // rust: chunk: ChunkData {
    // rust: heightmaps: Vec::new(),
    // rust: buffer: ChunkData::from_sections(&vec![section; 24]),
    // rust: block_entities: Vec::new(),
    // rust: },
    // rust: light: none,
    // rust: }))
}

    // Columns come back one per packet, in the order the packets went in,
    // as the frame would have decoded them itself.
the_decoder_returns_columns_in_order :: proc() {
}
    // rust: let overworld = DimensionType::vanilla("minecraft:overworld");
    // rust: let format = Arc::new(ChunkFormat::new(&overworld, vec![0, 7, 9], 2));
    // rust: let decoder = ChunkDecoder::new();
    // rust: for x in 0..20 {
    // rust: assert!(decoder.submit(format.clone(), packet(x, 1 + x)).is_none());
}
    // rust: for x in 0..20 {
    // rust: let (packet, column) = loop {
    // rust: match decoder.next() {
    // rust: Next::Ready(decoded) => break decoded,
    // rust: Next::Decoding => std::thread::yield_now(),
    // rust: Next::Lost => panic!("the decoder stopped"),
}
}
    // rust: let C::LevelChunkWithLight(p) = *packet else {
    // rust: panic!("not a chunk packet");
}
    // rust: let (column, direct) = (column.unwrap(), format.column(&p).unwrap());
    // rust: assert_eq!((column.x, column.z), (x, -3));
    // rust: for (cx, y, cz) in [(0, -64, 0), (5, 70, 9), (15, 319, 15)] {
    // rust: assert_eq!(column.get(cx, y, cz), 1 + x as u32);
    // rust: assert_eq!(column.get(cx, y, cz), direct.get(cx, y, cz));
                // Wire biome 1 is our biome 7.
    // rust: assert_eq!(column.biome(cx, y, cz), 7);
}
}
    // rust: assert!(matches!(decoder.next(), Next::Decoding));
}

    // `LevelChunk.replaceBiomes`: the packet's containers go to the
    // dimension's sections (y 0 to 255 in the Nether), mapped to our biome
    // table; the blocks stay, and the sections outside the dimension take
    // its nearest biomes as a chunk packet's do.
chunks_biomes_replace_a_columns_biomes :: proc() {
}
    // rust: let nether = DimensionType::vanilla("minecraft:the_nether");
    // rust: let format = ChunkFormat::new(&nether, vec![0, 7, 9], 2);
    // rust: let mut chunk = Chunk::empty(2, -3);
    // rust: chunk.set(3, 70, 4, 5);
        // Wire biome 1 everywhere, with 2 in the lowest and the highest cells.
    // rust: let containers: Vec<Paletted> = (0..nether.sections())
    // rust: .map(|i| {
    // rust: let mut cells = [1; 64];
    // rust: if i == 0 {
    // rust: cells[0] = 2;
}
    // rust: if i == nether.sections() - 1 {
    // rust: cells[63] = 2;
}
    // rust: Paletted::from_values(&cells, Wiring::Biomes, 2)
    // rust: })
    // rust: .collect();
    // rust: let data = play::ChunkBiomeData::from_biomes([2, -3], &containers);
    // rust: format.replace_biomes(&mut chunk, &data).unwrap();
    // rust: assert_eq!(chunk.get(3, 70, 4), 5);
    // rust: assert_eq!(chunk.biome(8, 70, 8), 7);
    // rust: assert_eq!(chunk.biome(0, 0, 0), 9);
    // rust: assert_eq!(chunk.biome(4, 0, 0), 7);
    // rust: assert_eq!(chunk.biome(15, 255, 15), 9);
        // Below and above the Nether: its bottom and top cell layers.
    // rust: assert_eq!(chunk.biome(0, -64, 0), 9);
    // rust: assert_eq!(chunk.biome(15, 319, 15), 9);
    // rust: assert_eq!(chunk.biome(0, 319, 0), 7);
        // A buffer short of the dimension's sections changes nothing.
    // rust: let short = play::ChunkBiomeData::from_biomes([2, -3], &containers[..3]);
    // rust: let mut other = Chunk::empty(2, -3);
    // rust: assert!(format.replace_biomes(&mut other, &short).is_err());
    // rust: assert_eq!(other.biome(8, 70, 8), 0);
}
}
