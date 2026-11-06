//! Transpiled from Horizon Rust crate
package horizon_protocol_play

import "core:fmt"
import "core:mem"
import "core:math"

// Play state packets: world, entities, player state, inventory and chat.
// use crate::{
    // rust: Error, Result,
    // rust: buf::{
    // rust: Bool, Byte, BytesN, ChunkPos, Codec, Double, Float, Ident, Int, List, Long, LpVec3, Nbt,
    // rust: Opt, OptVarInt, Pos, Reader, SectionPos, Short, Str, StrN, UByte, Uuid, VarInt, VarLong,
    // rust: VarVec3i, Vec3d, Writer,
    // rust: },
    // rust: chunk::{ChunkData, LightData},
    // rust: entity_data::{EntityData, Particle, Value},
    // rust: item::{Component, DelimitedSlot, Hashed, HashedSlot, Slot, Stack},
    // rust: packet, packet_enum,
    // rust: packets::{
    // rust: Empty,
    // rust: configuration::{
    // rust: ClientInformation, CookieRequest, CookieResponse, CustomClickAction, CustomPayload,
    // rust: Disconnect, KeepAlive, Ping, ResourcePackPop, ResourcePackPush, ResourcePackResponse,
    // rust: ServerLinks, StoreCookie, Transfer, UpdateTags,
    // rust: },
    // rust: login::Property,
    // rust: },
}
// use horizon_world::nbt::Tag;

// ---- shared structures -------------------------------------------------

    // rust: packet!(
    // GlobalPos: a dimension and a block position.
    // rust: GlobalPos { dimension: String => Ident, pos: [i32; 3] => Pos }
    // rust: );
    // rust: packet!(
    // CommonPlayerSpawnInfo.
    // rust: SpawnInfo {
    // rust: dimension_type: i32 => VarInt,
    // rust: dimension: String => Ident,
    // rust: seed: i64 => Long,
    // rust: game_type: i32 => VarInt,
    // rust: previous_game_type: Option<i32> => OptVarInt,
    // rust: debug: bool => Bool,
    // rust: flat: bool => Bool,
    // rust: last_death: Option<GlobalPos> => Opt<GlobalPos>,
    // rust: portal_cooldown: i32 => VarInt,
    // rust: sea_level: i32 => VarInt,
}
    // rust: );

// Relative flags (Relative.pack): X, Y, Z, Y_ROT, X_ROT, DELTA_X/Y/Z, ROTATE_DELTA.
    // rust: pub mod relative {
X :: 1
Y :: 2
Z :: 4
Y_ROT :: 8
X_ROT :: 16
DELTA_X :: 32
DELTA_Y :: 64
DELTA_Z :: 128
ROTATE_DELTA :: 256
}

// ---- clientbound -------------------------------------------------------

    // rust: packet!(AddEntity {
    // rust: id: i32 => VarInt,
    // rust: uuid: u128 => Uuid,
    // rust: kind: i32 => VarInt,
    // rust: position: [f64; 3] => Vec3d,
    // rust: velocity: [f64; 3] => LpVec3,
    // rust: pitch: i8 => Byte,
    // rust: yaw: i8 => Byte,
    // rust: head_yaw: i8 => Byte,
    // rust: data: i32 => VarInt,
    // rust: });
    // rust: packet!(Animate { id: i32 => VarInt, action: u8 => UByte });
    // rust: packet!(BlockChangedAck { sequence: i32 => VarInt });
    // rust: packet!(
    // ClientboundSelectAdvancementsTabPacket: the advancement tab the server keeps for the
    // player, or none. `ClientPacketListener.handleSelectAdvancementsTab` opens the screen on
    // that tab, and closes it for none.
    // rust: SelectAdvancementsTab { tab: Option<String> => Opt<Ident> }
    // rust: );
    // rust: packet!(BlockDestruction { id: i32 => VarInt, pos: [i32; 3] => Pos, progress: u8 => UByte });
    // rust: packet!(BlockEntityData { pos: [i32; 3] => Pos, kind: i32 => VarInt, tag: Tag => Nbt });
    // rust: packet!(BlockUpdate { pos: [i32; 3] => Pos, state: i32 => VarInt });
// ClientboundAddTransientBlockPacket: a block the client shows for a moment
// while its section mesh catches up (a falling block that landed).
    // rust: packet!(AddTransientBlock { pos: [i32; 3] => Pos, state: i32 => VarInt });
    // rust: packet!(ChangeDifficulty { difficulty: i32 => VarInt, locked: bool => Bool });
// ResourceKey<GameRule<?>> is an identifier, followed by its string value.
    // rust: packet!(GameRuleEntry { name: String => Ident, value: String => Str });
    // rust: packet!(GameRuleValues { entries: Vec<GameRuleEntry> => List<GameRuleEntry> });
    // rust: packet!(ChunkBatchFinished { size: i32 => VarInt });
    // rust: packet!(ContainerClose { container: i32 => VarInt });
    // rust: packet!(ContainerSetContent {
    // rust: container: i32 => VarInt,
    // rust: state: i32 => VarInt,
    // rust: items: Vec<Option<Stack>> => List<Slot>,
    // rust: carried: Option<Stack> => Slot,
    // rust: });
// ItemCost.STREAM_CODEC: item, count, then the exact component predicate
// (a list of typed component values, with no patch removal count).
NetCost :: struct {
    item: i32,
    count: i32,
    components: Vec<(i32,
}
    // rust: impl From<Stack> for NetCost {
from :: proc(stack: Stack) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: item: stack.item,
    // rust: count: stack.count,
    // rust: components: stack.added,
}
}
}
    // rust: impl From<NetCost> for Stack {
from :: proc(cost: NetCost) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: item: cost.item,
    // rust: count: cost.count,
    // rust: added: cost.components,
    // rust: removed: Vec::new(),
    // rust: wire: Default::default(),
}
}
}
// MerchantOffer.STREAM_CODEC.
NetOffer :: struct {
    cost_a: NetCost,
    result: Stack,
    cost_b: Maybe(NetCost),
    out_of_stock: bool,
    uses: i32,
    max_uses: i32,
    xp: i32,
    special_price: i32,
    price_multiplier: f32,
    demand: i32,
}
Offers :: struct {
    // rust: impl Codec<Vec<NetOffer>> for Offers {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
cost :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let item = r.varint()?;
    // rust: let count = r.varint()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut components = Vec::with_capacity(n.min(64));
    // rust: for _ in 0..n {
    // rust: let kind = r.varint()?;
    // rust: components.push((kind, Component::read(kind, r)?));
}
    // rust: Ok(NetCost {
    // rust: item,
    // rust: count,
    // rust: components,
    // rust: })
}
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut out = Vec::with_capacity(n.min(64));
    // rust: for _ in 0..n {
    // rust: let cost_a = cost(r)?;
    // rust: let result = Slot::read(r)?.ok_or_else(|| Error::new("empty merchant result"))?;
    // rust: let cost_b = if r.bool()? { Some(cost(r)?) } else { None };
    // rust: out.push(NetOffer {
    // rust: cost_a,
    // rust: result,
    // rust: cost_b,
    // rust: out_of_stock: r.bool()?,
    // rust: uses: r.i32()?,
    // rust: max_uses: r.i32()?,
    // rust: xp: r.i32()?,
    // rust: special_price: r.i32()?,
    // rust: price_multiplier: r.f32()?,
    // rust: demand: r.i32()?,
    // rust: });
}
    // rust: Ok(out)
}
write :: proc(v: ^[dynamic]NetOffer, w: ^Writer) {
}
cost :: proc(c: ^NetCost, w: ^Writer) {
}
    // rust: w.varint(c.item);
    // rust: w.varint(c.count);
    // rust: w.varint(c.components.len() as i32);
    // rust: for (kind, value) in &c.components {
    // rust: w.varint(*kind);
    // rust: value.write(*kind, w);
}
}
    // rust: w.varint(v.len() as i32);
    // rust: for o in v {
    // rust: cost(&o.cost_a, w);
    // rust: Slot::write(&Some(o.result.clone()), w);
    // rust: w.bool(o.cost_b.is_some());
    // rust: if let Some(b) = &o.cost_b {
    // rust: cost(b, w);
}
    // rust: w.bool(o.out_of_stock);
    // rust: w.i32(o.uses);
    // rust: w.i32(o.max_uses);
    // rust: w.i32(o.xp);
    // rust: w.i32(o.special_price);
    // rust: w.f32(o.price_multiplier);
    // rust: w.i32(o.demand);
}
}
}
    // rust: packet!(
    // ClientboundMerchantOffersPacket.
    // rust: MerchantOffers {
    // rust: container: i32 => VarInt,
    // rust: offers: Vec<NetOffer> => Offers,
    // rust: level: i32 => VarInt,
    // rust: xp: i32 => VarInt,
    // rust: show_progress: bool => Bool,
    // rust: can_restock: bool => Bool,
}
    // rust: );
    // rust: packet!(ContainerSetData { container: i32 => VarInt, id: i16 => Short, value: i16 => Short });
// ClientboundCooldownPacket: the cooldown group (an identifier) and the ticks
// its entry lasts (0 ends it).
    // rust: packet!(Cooldown { group: String => Ident, duration: i32 => VarInt });
    // rust: packet!(
    // ClientboundCustomChatCompletionsPacket: how the server changes the
    // extra chat completions (`custom_chat_action`) and the entries.
    // rust: CustomChatCompletions { action: i32 => VarInt, entries: Vec<String> => List<Str> }
    // rust: );
// ClientboundCustomChatCompletionsPacket.Action, by id (`ByIdMap.continuous`
// with `OutOfBoundsStrategy.ZERO`: an unknown id is `ADD`).
    // rust: pub mod custom_chat_action {
ADD :: 0
REMOVE :: 1
SET :: 2
}
    // rust: packet!(ContainerSetSlot { container: i32 => VarInt, state: i32 => VarInt, slot: i16 => Short, item: Option<Stack> => Slot });
// A holder reference: registry id + 1, or 0 for an inline value (unsupported).
HolderId :: struct {
    // rust: impl Codec<i32> for HolderId {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match r.varint()? {
    // rust: 0 => Err(Error::new("inline registry values are not supported")),
    // rust: id => Ok(id - 1),
}
}
write :: proc(v: ^i32, w: ^Writer) {
}
    // rust: w.varint(v + 1)
}
}
// `Holder<Dialog>` as Dialog.STREAM_CODEC sends it: an entry of the
// `minecraft:dialog` registry the server sent in configuration, or the
// dialog itself.
DialogHolder :: enum {
    Registry(i32),
    Direct(Tag),
}
    // rust: impl Codec<DialogHolder> for DialogHolder {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match r.varint()? {
    // rust: 0 => Self::Direct(r.nbt()?),
    // rust: id => Self::Registry(id - 1),
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: match v {
    // rust: Self::Registry(id) => w.varint(id + 1),
    // rust: Self::Direct(tag) => {
    // rust: w.varint(0);
    // rust: w.nbt(tag);
}
}
}
}
    // rust: packet!(
    // ClientboundShowDialogPacket.
    // rust: ShowDialog { dialog: DialogHolder => DialogHolder }
    // rust: );
    // rust: packet!(
    // ChatType.Bound.
    // rust: ChatTypeBound { chat_type: i32 => HolderId, name: Tag => Nbt, target: Option<Tag> => Opt<Nbt> }
    // rust: );
    // rust: packet!(DisguisedChat { message: Tag => Nbt, chat_type: ChatTypeBound => ChatTypeBound });
    // rust: packet!(EntityEvent { id: i32 => Int, event: i8 => Byte });
// PositionPath: Linear(end position) or Stepped(list of (position, tick offset)).
PositionPath :: enum {
    Linear([f64; 3]),
    Stepped(Vec<([f64; 3], i32)>),
}
    // rust: impl PositionPath {
end :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Linear(p) => *p,
    // rust: Self::Stepped(steps) => steps.last().map_or([0.0; 3], |s| s.0),
}
}
}
    // rust: impl Codec<PositionPath> for PositionPath {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match r.varint()? {
    // rust: 1 => {
    // rust: let n = r.count(r.remaining() / 25)?;
    // rust: Self::Stepped(
    // rust: (0..n)
    // rust: .map(|_| Ok((Vec3d::read(r)?, r.varint()?)))
    // rust: .collect::<Result<_>>()?,
    // rust: )
}
    // rust: _ => Self::Linear(Vec3d::read(r)?),
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: match v {
    // rust: Self::Linear(p) => {
    // rust: w.varint(0);
    // rust: Vec3d::write(p, w);
}
    // rust: Self::Stepped(steps) => {
    // rust: w.varint(1);
    // rust: w.varint(steps.len() as i32);
    // rust: for (p, t) in steps {
    // rust: Vec3d::write(p, w);
    // rust: w.varint(*t);
}
}
}
}
}
    // rust: packet!(EntityPositionSync { id: i32 => VarInt, path: PositionPath => PositionPath, yaw: f32 => Float, pitch: f32 => Float, on_ground: bool => Bool });
    // rust: packet!(ForgetLevelChunk { pos: [i32; 2] => ChunkPos });
    // rust: packet!(
    // ClientboundChunksBiomesPacket.ChunkBiomeData: a column and its
    // sections' biome containers, in order (`extractChunkData`).
    // rust: ChunkBiomeData { pos: [i32; 2] => ChunkPos, buffer: Vec<u8> => BytesN<2097152> }
    // rust: );
    // rust: impl ChunkBiomeData {
    // `LevelChunk.replaceBiomes`' read: `count` sections' biome
    // containers, one after another.
biomes :: proc(self: ^Self, count: uint, biome_bits: u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut r = Reader::new(&self.buffer);
    // rust: (0..count)
    // rust: .map(|_| {
    // rust: crate::chunk::Paletted::read(&mut r, crate::chunk::Strategy::Biomes, biome_bits)
    // rust: })
    // rust: .collect()
}
    // `extractChunkData`: the sections' biome containers, in order.
from_biomes :: proc(pos: [i32; 2], biomes: ^[crate::chunk::Paletted]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = Writer::new();
    // rust: for b in biomes {
    // rust: b.write(&mut w);
}
    // rust: Self {
    // rust: pos,
    // rust: buffer: w.data,
}
}
}
    // rust: packet!(
    // ClientboundChunksBiomesPacket: columns whose biomes changed
    // (`/fillbiome`, through `ChunkMap.resendBiomesForChunks`).
    // rust: ChunksBiomes { chunks: Vec<ChunkBiomeData> => List<ChunkBiomeData> }
    // rust: );
    // rust: packet!(GameEvent { event: u8 => UByte, param: f32 => Float });
    // rust: packet!(HurtAnimation { id: i32 => VarInt, yaw: f32 => Float });
    // rust: packet!(
    // ClientboundDamageEventPacket: the hurt entity, the damage type's
    // registry id, the causing and the direct entity (none: -1 on the wire's
    // id + 1) and the source's position.
    // rust: DamageEvent {
    // rust: id: i32 => VarInt,
    // rust: source_type: i32 => VarInt,
    // rust: cause: Option<i32> => OptVarInt,
    // rust: direct: Option<i32> => OptVarInt,
    // rust: position: Option<[f64; 3]> => Opt<Vec3d>,
}
    // rust: );
    // rust: packet!(LevelChunkWithLight { x: i32 => Int, z: i32 => Int, chunk: ChunkData => ChunkData, light: LightData => LightData });
    // rust: packet!(LevelEvent { kind: i32 => Int, pos: [i32; 3] => Pos, data: i32 => Int, global: bool => Bool });
    // rust: packet!(LightUpdate { x: i32 => VarInt, z: i32 => VarInt, light: LightData => LightData });
    // rust: packet!(Login {
    // rust: player_id: i32 => Int,
    // rust: hardcore: bool => Bool,
    // rust: levels: Vec<String> => List<Ident>,
    // rust: max_players: i32 => VarInt,
    // rust: chunk_radius: i32 => VarInt,
    // rust: simulation_distance: i32 => VarInt,
    // rust: reduced_debug_info: bool => Bool,
    // rust: show_death_screen: bool => Bool,
    // rust: limited_crafting: bool => Bool,
    // rust: spawn: SpawnInfo => SpawnInfo,
    // rust: online_mode: bool => Bool,
    // rust: enforces_secure_chat: bool => Bool,
    // rust: });
    // rust: packet!(
// MapDecoration: a registry holder, its map position and rotation, and an
// optional name.
    // rust: MapDecoration {
    // rust: kind: i32 => VarInt,
    // rust: x: i8 => Byte,
    // rust: y: i8 => Byte,
    // rust: rot: i8 => Byte,
    // rust: name: Option<Tag> => Opt<Nbt>,
}
    // rust: );

// MapItemSavedData.MapPatch: an empty patch is a zero width.
MapPatch :: struct {
    start_x: i32,
    start_y: i32,
    width: i32,
    height: i32,
    colors: [dynamic]u8,
}
MapPatchOpt :: struct {
    // rust: impl Codec<Option<MapPatch>> for MapPatchOpt {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let width = i32::from(r.u8()?);
    // rust: if width == 0 {
    // rust: return Ok(None);
}
    // rust: let height = i32::from(r.u8()?);
    // rust: let start_x = i32::from(r.u8()?);
    // rust: let start_y = i32::from(r.u8()?);
    // rust: let n = r.count(r.remaining())?;
    // rust: let colors = r.bytes(n)?.to_vec();
    // rust: Ok(Some(MapPatch {
    // rust: start_x,
    // rust: start_y,
    // rust: width,
    // rust: height,
    // rust: colors,
    // rust: }))
}
write :: proc(patch: ^Maybe(MapPatch), w: ^Writer) {
}
    // rust: let Some(patch) = patch else {
    // rust: w.u8(0);
    // rust: return;
}
    // rust: w.u8(patch.width as u8);
    // rust: w.u8(patch.height as u8);
    // rust: w.u8(patch.start_x as u8);
    // rust: w.u8(patch.start_y as u8);
    // rust: w.varint(patch.colors.len() as i32);
    // rust: w.bytes(&patch.colors);
}
}

    // rust: packet!(MapItemData {
    // rust: map_id: i32 => VarInt,
    // rust: scale: i8 => Byte,
    // rust: locked: bool => Bool,
    // rust: decorations: Option<Vec<MapDecoration>> => Opt<List<MapDecoration>>,
    // rust: patch: Option<MapPatch> => MapPatchOpt,
    // rust: });
// VecDelta: per-axis deltas in 1/4096 blocks, linear or in timed steps.
VecDelta :: enum {
    Linear([i16; 3]),
    Stepped(Vec<([i16; 3], i32)>),
}
    // rust: impl VecDelta {
    // VecDeltaCodec.decode against a base position: zero deltas keep the
    // base coordinate exactly, others add to its 1/4096 quantization.
apply :: proc(base: [f64; 3], delta: [i16; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = base;
    // rust: for i in 0..3 {
    // rust: if delta[i] != 0 {
    // rust: out[i] = (horizon_core::jmath::round(base[i] * 4096.0) + i64::from(delta[i]))
    // rust: as f64
    // rust: / 4096.0;
}
}
    // rust: out
}
    // The final position after all steps.
end :: proc(self: ^Self, base: [f64; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Linear(d) => Self::apply(base, *d),
    // rust: Self::Stepped(steps) => steps.iter().fold(base, |p, (d, _)| Self::apply(p, *d)),
}
}
read :: proc(r: ^Reader, steps: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if steps == 0 {
    // rust: return Ok(Self::Linear([r.i16()?, r.i16()?, r.i16()?]));
}
    // rust: if steps > r.remaining() / 7 {
    // rust: return Err(Error::new("VecDelta with too many steps"));
}
    // rust: Ok(Self::Stepped(
    // rust: (0..steps)
    // rust: .map(|_| {
    // rust: let ticks = r.varint()?;
    // rust: Ok(([r.i16()?, r.i16()?, r.i16()?], ticks))
    // rust: })
    // rust: .collect::<Result<_>>()?,
    // rust: ))
}
steps :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Linear(_) => 0,
    // rust: Self::Stepped(s) => s.len(),
}
}
write :: proc(self: ^Self, w: ^Writer) {
}
    // rust: match self {
    // rust: Self::Linear(d) => d.iter().for_each(|v| w.i16(*v)),
    // rust: Self::Stepped(steps) => {
    // rust: for (d, ticks) in steps {
    // rust: w.varint(*ticks);
    // rust: d.iter().for_each(|v| w.i16(*v));
}
}
}
}
}
// ClientboundMoveEntityPacket.Pos / PosRot / Rot.
MoveEntity :: struct {
    id: i32,
    delta: Maybe(VecDelta),
    rotation: Option<(i8,
    on_ground: bool,
}
    // rust: macro_rules! move_entity {
    // rust: ($name:ident, pos: $pos:expr, rot: $rot:expr) => {
    // rust: pub struct $name(pub MoveEntity);
    // rust: impl Codec<$name> for $name {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::read_inner(r).map($name)
}
write :: proc(v: ^$name, w: ^Writer) {
}
    // rust: Self::write_inner(&v.0, w)
}
}
    // rust: impl $name {
read_inner :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = r.varint()?;
    // rust: if !$pos {
    // rust: let on_ground = r.bool()?;
    // rust: let rotation = Some((r.i8()?, r.i8()?));
    // rust: return Ok(MoveEntity {
    // rust: id,
    // rust: delta: None,
    // rust: rotation,
    // rust: on_ground,
    // rust: });
}
    // rust: let properties = r.varint()?;
    // rust: let delta = Some(VecDelta::read(r, (properties as u32 >> 1) as usize)?);
    // rust: let rotation = if $rot { Some((r.i8()?, r.i8()?)) } else { None };
    // rust: Ok(MoveEntity {
    // rust: id,
    // rust: delta,
    // rust: rotation,
    // rust: on_ground: properties & 1 != 0,
    // rust: })
}
write_inner :: proc(v: ^MoveEntity, w: ^Writer) {
}
    // rust: w.varint(v.id);
    // rust: if !$pos {
    // rust: w.bool(v.on_ground);
    // rust: } else {
    // rust: let delta = v.delta.clone().unwrap_or(VecDelta::Linear([0; 3]));
    // rust: w.varint(i32::from(v.on_ground) | (delta.steps() as i32) << 1);
    // rust: delta.write(w);
}
    // rust: if let Some((y, x)) = v.rotation.filter(|_| $rot) {
    // rust: w.i8(y);
    // rust: w.i8(x);
}
}
}
}
}
    // rust: move_entity!(MoveEntityPos, pos: true, rot: false);
    // rust: move_entity!(MoveEntityPosRot, pos: true, rot: true);
    // rust: move_entity!(MoveEntityRot, pos: false, rot: true);
    // rust: packet!(OpenScreen { container: i32 => VarInt, menu: i32 => VarInt, title: Tag => Nbt });
// ClientboundMountScreenOpenPacket: a horse's or llama's inventory, with its
// chest's columns (`getInventoryColumns`).
    // rust: packet!(MountScreenOpen { container: i32 => VarInt, columns: i32 => VarInt, entity: i32 => Int });
    // rust: packet!(
    // ClientboundOpenSignEditorPacket: the sign whose side the player edits.
    // rust: OpenSignEditor { pos: [i32; 3] => Pos, front: bool => SignSide }
    // rust: );
    // rust: packet!(
    // ClientboundOpenBookPacket: the hand (InteractionHand, 0 main, 1 off)
    // whose written book the player reads.
    // rust: OpenBook { hand: i32 => VarInt }
    // rust: );
    // rust: packet!(PlayerAbilities { flags: i8 => Byte, flying_speed: f32 => Float, walking_speed: f32 => Float });
// MessageSignature.Packed: an index into the last-seen cache or a full signature.
PackedSignature :: struct {
    // rust: impl Codec<(i32, Option<Vec<u8>>)> for PackedSignature {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = r.varint()? - 1;
    // rust: Ok(if id == -1 {
    // rust: (-1, Some(r.bytes(256)?.to_vec()))
    // rust: } else {
    // rust: (id, None)
    // rust: })
}
write :: proc(v: ^(i32) {
}
    // rust: w.varint(v.0 + 1);
    // rust: if let Some(sig) = &v.1 {
    // rust: w.bytes(sig);
}
}
}
// MessageSignature: 256 raw bytes.
Signature :: struct {
    // rust: impl Codec<Vec<u8>> for Signature {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(r.bytes(256)?.to_vec())
}
write :: proc(v: ^[dynamic]u8, w: ^Writer) {
}
    // rust: w.bytes(v)
}
}
// FilterMask: 0 pass-through, 1 fully filtered, 2 partially (with a BitSet).
FilterMask :: struct {
    // rust: impl Codec<(i32, Vec<i64>)> for FilterMask {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let kind = r.varint()?;
    // rust: Ok((
    // rust: kind,
    // rust: if kind == 2 {
    // rust: r.long_array()?
    // rust: } else {
    Vec: :new(),
    // rust: },
    // rust: ))
}
write :: proc(v: ^(i32) {
}
    // rust: w.varint(v.0);
    // rust: if v.0 == 2 {
    // rust: w.long_array(&v.1);
}
}
}
    // rust: packet!(PlayerChat {
    // rust: global_index: i32 => VarInt,
    // rust: sender: u128 => Uuid,
    // rust: index: i32 => VarInt,
    // rust: signature: Option<Vec<u8>> => Opt<Signature>,
    // rust: content: String => StrN<256>,
    // rust: timestamp: i64 => Long,
    // rust: salt: i64 => Long,
    // rust: last_seen: Vec<(i32, Option<Vec<u8>>)> => List<PackedSignature>,
    // rust: unsigned_content: Option<Tag> => Opt<Nbt>,
    // rust: filter: (i32, Vec<i64>) => FilterMask,
    // rust: chat_type: ChatTypeBound => ChatTypeBound,
    // rust: });
    // rust: packet!(
    // ClientboundDeleteChatPacket: the server deleted a player message,
    // named by its packed signature.
    // rust: DeleteChat { signature: (i32, Option<Vec<u8>>) => PackedSignature }
    // rust: );
    // rust: packet!(PlayerCombatKill { id: i32 => VarInt, message: Tag => Nbt });
    // rust: packet!(PlayerInfoRemove { uuids: Vec<u128> => List<Uuid> });
// One ClientboundPlayerInfoUpdatePacket entry; fields are set for the
// actions in the packet.
PlayerInfo :: struct {
    uuid: u128,
    name: Maybe(string),
    properties: [dynamic]Property,
    // RemoteChatSession.Data: session id, key expiry, key, key signature.
    chat_session: Option<(u128,
    game_mode: Maybe(i32),
    listed: Maybe(bool),
    latency: Maybe(i32),
    display_name: Maybe(Option<Tag)>,
    list_order: Maybe(i32),
    show_hat: Maybe(bool),
}
// Actions bits: ADD_PLAYER, INITIALIZE_CHAT, UPDATE_GAME_MODE, UPDATE_LISTED,
// UPDATE_LATENCY, UPDATE_DISPLAY_NAME, UPDATE_LIST_ORDER, UPDATE_HAT.
PlayerInfoUpdate :: struct {
    actions: u8,
    entries: [dynamic]PlayerInfo,
}
    // rust: impl Codec<PlayerInfoUpdate> for PlayerInfoUpdate {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let actions = r.u8()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut entries = Vec::with_capacity(n.min(256));
    // rust: for _ in 0..n {
    // rust: let mut e = PlayerInfo {
    // rust: uuid: r.uuid()?,
    // rust: ..PlayerInfo::default()
}
    // rust: if actions & 1 != 0 {
    // rust: e.name = Some(r.string(16)?);
    // rust: let count = r.count(16)?;
    // rust: e.properties = (0..count)
    // rust: .map(|_| Property::read(r))
    // rust: .collect::<Result<_>>()?;
}
    // rust: if actions & 2 != 0 && r.bool()? {
    // rust: e.chat_session =
    // rust: Some((r.uuid()?, r.i64()?, r.byte_array(512)?, r.byte_array(4096)?));
}
    // rust: if actions & 4 != 0 {
    // rust: e.game_mode = Some(r.varint()?);
}
    // rust: if actions & 8 != 0 {
    // rust: e.listed = Some(r.bool()?);
}
    // rust: if actions & 16 != 0 {
    // rust: e.latency = Some(r.varint()?);
}
    // rust: if actions & 32 != 0 {
    // rust: e.display_name = Some(if r.bool()? { Some(r.nbt()?) } else { None });
}
    // rust: if actions & 64 != 0 {
    // rust: e.list_order = Some(r.varint()?);
}
    // rust: if actions & 128 != 0 {
    // rust: e.show_hat = Some(r.bool()?);
}
    // rust: entries.push(e);
}
    // rust: Ok(Self { actions, entries })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: w.u8(v.actions);
    // rust: w.varint(v.entries.len() as i32);
    // rust: for e in &v.entries {
    // rust: w.uuid(e.uuid);
    // rust: if v.actions & 1 != 0 {
    // rust: w.string(e.name.as_deref().unwrap_or(""));
    // rust: w.varint(e.properties.len() as i32);
    // rust: e.properties.iter().for_each(|p| Property::write(p, w));
}
    // rust: if v.actions & 2 != 0 {
    // rust: w.bool(e.chat_session.is_some());
    // rust: if let Some((id, expires, key, sig)) = &e.chat_session {
    // rust: w.uuid(*id);
    // rust: w.i64(*expires);
    // rust: w.byte_array(key);
    // rust: w.byte_array(sig);
}
}
    // rust: if v.actions & 4 != 0 {
    // rust: w.varint(e.game_mode.unwrap_or(0));
}
    // rust: if v.actions & 8 != 0 {
    // rust: w.bool(e.listed.unwrap_or(false));
}
    // rust: if v.actions & 16 != 0 {
    // rust: w.varint(e.latency.unwrap_or(0));
}
    // rust: if v.actions & 32 != 0 {
    // rust: let name = e.display_name.clone().flatten();
    // rust: w.bool(name.is_some());
    // rust: if let Some(t) = &name {
    // rust: w.nbt(t);
}
}
    // rust: if v.actions & 64 != 0 {
    // rust: w.varint(e.list_order.unwrap_or(0));
}
    // rust: if v.actions & 128 != 0 {
    // rust: w.bool(e.show_hat.unwrap_or(false));
}
}
}
}
    // rust: packet!(PlayerPosition {
    // rust: teleport: i32 => VarInt,
    // rust: position: [f64; 3] => Vec3d,
    // rust: delta: [f64; 3] => Vec3d,
    // rust: yaw: f32 => Float,
    // rust: pitch: f32 => Float,
    // rust: relatives: i32 => Int,
    // rust: });
    // rust: packet!(
    // ClientboundProjectilePowerPacket: an AbstractHurtingProjectile's accelerationPower.
    // rust: ProjectilePower { id: i32 => VarInt, power: f64 => Double }
    // rust: );
    // rust: packet!(
    // ClientboundPlayerLookAtPacket's entity target: its id and the anchor
    // (`EntityAnchorArgument.Anchor`: 0 feet, 1 eyes) to look at on it.
    // rust: LookAtEntity { id: i32 => VarInt, anchor: i32 => VarInt }
    // rust: );
    // rust: packet!(
    // ClientboundPlayerLookAtPacket: turn this player's `from` anchor towards
    // a point, or towards an entity when the client knows it.
    // rust: PlayerLookAt {
    // rust: from: i32 => VarInt,
    // rust: target: [f64; 3] => Vec3d,
    // rust: entity: Option<LookAtEntity> => Opt<LookAtEntity>,
}
    // rust: );
    // rust: packet!(
    // ClientboundPostEffectsPacket: the `post_effect` chains (ids) the player's
    // screen runs, in order (`ServerPlayer.postEffects`).
    // rust: PostEffects { effects: Vec<String> => List<Ident> }
    // rust: );
    // rust: packet!(PlayerRotation { yaw: f32 => Float, relative_yaw: bool => Bool, pitch: f32 => Float, relative_pitch: bool => Bool });
    // rust: packet!(RemoveEntities { ids: Vec<i32> => List<VarInt> });
    // rust: packet!(Respawn { spawn: SpawnInfo => SpawnInfo, keep: i8 => Byte });
    // rust: packet!(RotateHead { id: i32 => VarInt, head_yaw: i8 => Byte });
    // rust: packet!(
    // Each change is `state << 12 | x << 8 | z << 4 | y` within the section.
    // rust: SectionBlocksUpdate { section: [i32; 3] => SectionPos, changes: Vec<i64> => List<VarLong> }
    // rust: );
    // rust: packet!(Text { text: Tag => Nbt });
    // rust: packet!(SetChunkCacheCenter { x: i32 => VarInt, z: i32 => VarInt });
    // rust: packet!(
    // ClientboundTickingStatePacket: the tick rate and whether the level is frozen.
    // rust: TickingState { rate: f32 => Float, frozen: bool => Bool }
    // rust: );
    // rust: packet!(
    // ClientboundTickingStepPacket: the ticks a frozen level runs (`/tick step`).
    // rust: TickingStep { steps: i32 => VarInt }
    // rust: );
    // rust: packet!(Distance { distance: i32 => VarInt });
    // rust: packet!(SetCursorItem { item: Option<Stack> => Slot });
    // rust: packet!(SetDefaultSpawnPosition { pos: GlobalPos => GlobalPos, yaw: f32 => Float, pitch: f32 => Float });
    // rust: packet!(SetEntityData { id: i32 => VarInt, values: Vec<(u8, i32, Value)> => EntityData });
    // rust: packet!(SetEntityMotion { id: i32 => VarInt, velocity: [f64; 3] => LpVec3 });
    // rust: packet!(
    // ClientboundSetEntityLinkPacket: the entity holding a leashed entity's
    // lead, 0 when none (Leashable.setDelayedLeashHolderId).
    // rust: SetEntityLink { source: i32 => Int, dest: i32 => Int }
    // rust: );
    // rust: packet!(
    // ClientboundSetPassengersPacket: a vehicle and every entity riding it.
    // rust: SetPassengers { vehicle: i32 => VarInt, passengers: Vec<i32> => List<VarInt> }
    // rust: );
    // rust: packet!(
    // ClientboundMoveVehiclePacket: the server puts a vehicle its rider
    // controls back where it was (PositionAndRotation: x, y, z, yRot, xRot).
    // rust: MoveVehicle { position: [f64; 3] => Vec3d, yaw: f32 => Float, pitch: f32 => Float }
    // rust: );
    // rust: packet!(
    // NewMinecartBehavior.MinecartStep: where a minecart is at the end of one
    // of the server's steps along the track, its motion, its rotation (yRot,
    // xRot) and the step's weight in the 3 ticks they are played over.
    // rust: MinecartStep {
    // rust: position: [f64; 3] => Vec3d,
    // rust: movement: [f64; 3] => Vec3d,
    // rust: yaw: i8 => Byte,
    // rust: pitch: i8 => Byte,
    // rust: weight: f32 => Float,
}
    // rust: );
    // rust: packet!(
    // ClientboundMoveMinecartPacket: the steps a minecart took along the
    // track since the last one (the `minecart_improvements` experiment sends
    // these in place of move packets).
    // rust: MoveMinecartAlongTrack { id: i32 => VarInt, steps: Vec<MinecartStep> => List<MinecartStep> }
    // rust: );
// ClientboundSetEquipmentPacket: (EquipmentSlot ordinal, stack) pairs.
Equipment :: struct {
    // rust: impl Codec<Vec<(u8, Option<Stack>)>> for Equipment {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: loop {
    // rust: let slot = r.u8()?;
    // rust: out.push((slot & 127, Slot::read(r)?));
    // rust: if slot & 128 == 0 {
    // rust: return Ok(out);
}
}
}
write :: proc(v: ^Vec<(u8) {
}
    // rust: for (i, (slot, stack)) in v.iter().enumerate() {
    // rust: w.u8(if i + 1 < v.len() { slot | 128 } else { *slot });
    // rust: Slot::write(stack, w);
}
}
}
    // rust: packet!(SetEquipment { id: i32 => VarInt, slots: Vec<(u8, Option<Stack>)> => Equipment });
    // rust: packet!(SetExperience { progress: f32 => Float, level: i32 => VarInt, total: i32 => VarInt });
    // rust: packet!(SetHealth { health: f32 => Float, food: i32 => VarInt, saturation: f32 => Float });
    // rust: packet!(SetHeldSlot { slot: i32 => VarInt });
    // rust: packet!(
    // ClientboundSetCameraPacket: the entity the view is attached to (the
    // player's own id puts it back on the player).
    // rust: SetCamera { camera_id: i32 => VarInt }
    // rust: );
    // rust: packet!(SetPlayerInventory { slot: i32 => VarInt, item: Option<Stack> => Slot });
    // rust: packet!(
    // ClockNetworkState for one world clock (registry id).
    //
    // `ClientboundSetTimePacket` keys its map by `Holder<WorldClock>`, but
    // `WorldClock.STREAM_CODEC` is `ByteBufCodecs.holderRegistry`, not
    // `holder`: the key is the plain registry id, with no inline form and no
    // off-by-one. The test below is a join packet captured from a vanilla
    // 26.3 server.
    // rust: ClockState { clock: i32 => VarInt, total_ticks: i64 => VarLong, partial_tick: f32 => Float, rate: f32 => Float }
    // rust: );
    // rust: packet!(SetTime { game_time: i64 => Long, clocks: Vec<ClockState> => List<ClockState> });
    // rust: packet!(TitlesAnimation { fade_in: i32 => Int, stay: i32 => Int, fade_out: i32 => Int });
// SoundEvent holder: a registry id, or an inline location with optional range.
SoundHolder :: struct {
    // rust: impl Codec<(i32, Option<(String, Option<f32>)>)> for SoundHolder {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = r.varint()?;
    // rust: if id != 0 {
    // rust: return Ok((crate::adapter::ids::sound_event(id - 1), None));
}
    // rust: let location = r.string(32767)?;
    // rust: let range = if r.bool()? { Some(r.f32()?) } else { None };
    // rust: Ok((-1, Some((location, range))))
}
write :: proc(v: ^(i32) {
}
    // rust: match &v.1 {
    // rust: None => w.varint(v.0 + 1),
    // rust: Some((location, range)) => {
    // rust: w.varint(0);
    // rust: w.string(location);
    // rust: <Opt<Float> as Codec<Option<f32>>>::write(range, w);
}
}
}
}
    // rust: packet!(Sound {
    // rust: sound: (i32, Option<(String, Option<f32>)>) => SoundHolder,
    // rust: source: i32 => VarInt,
    // rust: x: i32 => Int,
    // rust: y: i32 => Int,
    // rust: z: i32 => Int,
    // rust: volume: f32 => Float,
    // rust: pitch: f32 => Float,
    // rust: seed: i64 => Long,
    // rust: });
    // rust: packet!(SystemChat { content: Tag => Nbt, overlay: bool => Bool });
    // rust: packet!(
    // ClientboundTagQueryPacket: the answer to a debug NBT query (F3+I), with
    // the transaction it answers; `Tag::End` when there was no block entity.
    // rust: TagQuery { transaction: i32 => VarInt, tag: Tag => Nbt }
    // rust: );
    // rust: packet!(TakeItemEntity { item: i32 => VarInt, player: i32 => VarInt, amount: i32 => VarInt });
    // rust: packet!(TeleportEntity {
    // rust: id: i32 => VarInt,
    // rust: position: [f64; 3] => Vec3d,
    // rust: delta: [f64; 3] => Vec3d,
    // rust: yaw: f32 => Float,
    // rust: pitch: f32 => Float,
    // rust: relatives: i32 => Int,
    // rust: on_ground: bool => Bool,
    // rust: });

    // rust: packet!(BlockEvent { pos: [i32; 3] => Pos, b0: u8 => UByte, b1: u8 => UByte, block: i32 => VarInt });
    // rust: packet!(
    // ClientboundInitializeBorderPacket.
    // rust: InitializeBorder {
    // rust: center_x: f64 => Double,
    // rust: center_z: f64 => Double,
    // rust: old_size: f64 => Double,
    // rust: new_size: f64 => Double,
    // rust: lerp_time: i64 => VarLong,
    // rust: absolute_max_size: i32 => VarInt,
    // rust: warning_blocks: i32 => VarInt,
    // rust: warning_time: i32 => VarInt,
}
    // rust: );
    // rust: packet!(TabList { header: Tag => Nbt, footer: Tag => Nbt });
    // rust: packet!(
    // ClientboundSetBorderCenterPacket.
    // rust: SetBorderCenter { x: f64 => Double, z: f64 => Double }
    // rust: );
    // rust: packet!(
    // ClientboundSetBorderLerpSizePacket.
    // rust: SetBorderLerpSize { old_size: f64 => Double, new_size: f64 => Double, lerp_time: i64 => VarLong }
    // rust: );
    // rust: packet!(
    // ClientboundSetBorderSizePacket.
    // rust: SetBorderSize { size: f64 => Double }
    // rust: );
    // rust: packet!(
    // ClientboundSetBorderWarningDelayPacket (ticks).
    // rust: SetBorderWarningDelay { delay: i32 => VarInt }
    // rust: );
    // rust: packet!(
    // ClientboundSetBorderWarningDistancePacket.
    // rust: SetBorderWarningDistance { blocks: i32 => VarInt }
    // rust: );
    // rust: packet!(
    // ClientboundSetDisplayObjectivePacket: `DisplaySlot` id (0 list,
    // 1 sidebar, 2 below name, 3.. team sidebars) and the objective ("" clears).
    // rust: SetDisplayObjective { slot: i32 => VarInt, objective: String => Str }
    // rust: );
    // rust: packet!(
    // ClientboundResetScorePacket: one objective, or all of them when absent.
    // rust: ResetScore { owner: String => Str, objective: Option<String> => Opt<Str> }
    // rust: );
// `NumberFormatTypes.STREAM_CODEC`, by `number_format_type` registry id.
NumberFormat :: enum {
    // 0: `minecraft:blank`.
    Blank,
    // 1: `minecraft:styled`, a style compound.
    Styled(Tag),
    // 2: `minecraft:fixed`, a component.
    Fixed(Tag),
}
    // rust: impl Codec<NumberFormat> for NumberFormat {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match r.varint()? {
    // rust: 0 => NumberFormat::Blank,
    // rust: 1 => NumberFormat::Styled(r.nbt()?),
    // rust: 2 => NumberFormat::Fixed(r.nbt()?),
    // rust: other => return Err(crate::Error::new(format!("unknown number format {other}"))),
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: match v {
    // rust: NumberFormat::Blank => w.varint(0),
    // rust: NumberFormat::Styled(t) => {
    // rust: w.varint(1);
    // rust: w.nbt(t);
}
    // rust: NumberFormat::Fixed(t) => {
    // rust: w.varint(2);
    // rust: w.nbt(t);
}
}
}
}
    // rust: packet!(
    // ClientboundSetScorePacket.
    // rust: SetScore {
    // rust: owner: String => Str,
    // rust: objective: String => Str,
    // rust: score: i32 => VarInt,
    // rust: display: Option<Tag> => Opt<Nbt>,
    // rust: number_format: Option<NumberFormat> => Opt<NumberFormat>,
}
    // rust: );
// ClientboundSetObjectivePacket: method 0 adds, 1 removes, 2 changes;
// adds and changes carry the display name, render type (0 integer,
// 1 hearts) and number format.
SetObjective :: struct {
    name: string,
    method: i8,
    display: Option<(Tag,
}
    // rust: impl Codec<SetObjective> for SetObjective {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let name = r.string(32767)?;
    // rust: let method = r.i8()?;
    // rust: let display = if method == 0 || method == 2 {
    // rust: Some((r.nbt()?, r.varint()?, <Opt<NumberFormat>>::read(r)?))
    // rust: } else {
    // rust: None
}
    // rust: Ok(Self {
    // rust: name,
    // rust: method,
    // rust: display,
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: w.string(&v.name);
    // rust: w.i8(v.method);
    // rust: if v.method == 0 || v.method == 2 {
    // rust: let (name, render, format) = v.display.clone().unwrap_or((Tag::End, 0, None));
    // rust: w.nbt(&name);
    // rust: w.varint(render);
    // rust: <Opt<NumberFormat>>::write(&format, w);
}
}
}
// ClientboundLevelParticlesPacket: a particle, whether it ignores the
// client's particle setting (`overrideLimiter`) and its distance limit
// (`alwaysShow`), where, the spread and the speed on each axis, how many
// (0: one, moving by speed times spread) and the randomization type
// (0 default: gaussian spread and speed; 1 ALTERNATIVE: nextDouble times
// spread, the packet's max speed as velocity).
LevelParticles :: struct {
    particle: Particle,
    override_limiter: bool,
    always_show: bool,
    pos: [f64,
    dist: [f32,
    max_speed: [f32,
    count: i32,
    randomization: i32,
}
    // rust: impl Codec<LevelParticles> for LevelParticles {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Self {
    // rust: particle: Particle::read(r)?,
    // rust: override_limiter: r.bool()?,
    // rust: always_show: r.bool()?,
    // rust: pos: Vec3d::read(r)?,
    // rust: dist: [r.f32()?, r.f32()?, r.f32()?],
    // rust: max_speed: [r.f32()?, r.f32()?, r.f32()?],
    // rust: count: r.varint()?,
    // rust: randomization: r.varint()?,
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: v.particle.write(w);
    // rust: w.bool(v.override_limiter);
    // rust: w.bool(v.always_show);
    // rust: Vec3d::write(&v.pos, w);
    // rust: for f in v.dist.iter().chain(&v.max_speed) {
    // rust: w.f32(*f);
}
    // rust: w.varint(v.count);
    // rust: w.varint(v.randomization);
}
}
// `ExplosionParticleInfo` in a `WeightedList`: a particle the blast
// scatters, its scaling and speed, then its weight.
ExplosionParticle :: struct {
    particle: Particle,
    scaling: f32,
    speed: f32,
    weight: i32,
}
// ClientboundExplodePacket: the centre, radius and blocks destroyed, the
// push the receiving player takes, the particle at the centre, the sound,
// the particles the blast scatters, and whether the sound plays.
Explode :: struct {
    center: [f64,
    radius: f32,
    block_count: i32,
    knockback: Option<[f64,
    particle: Particle,
    sound: (i32,
    block_particles: [dynamic]ExplosionParticle,
    play_sound: bool,
}
    // rust: impl Codec<Explode> for Explode {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let center = Vec3d::read(r)?;
    // rust: let radius = r.f32()?;
    // rust: let block_count = r.i32()?;
    // rust: let knockback = <Opt<Vec3d>>::read(r)?;
    // rust: let particle = Particle::read(r)?;
    // rust: let sound = SoundHolder::read(r)?;
    // rust: let n = r.varint()?;
    // rust: let mut block_particles = Vec::new();
    // rust: for _ in 0..n {
    // rust: block_particles.push(ExplosionParticle {
    // rust: particle: Particle::read(r)?,
    // rust: scaling: r.f32()?,
    // rust: speed: r.f32()?,
    // rust: weight: r.varint()?,
    // rust: });
}
    // rust: Ok(Self {
    // rust: center,
    // rust: radius,
    // rust: block_count,
    // rust: knockback,
    // rust: particle,
    // rust: sound,
    // rust: block_particles,
    // rust: play_sound: r.bool()?,
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: Vec3d::write(&v.center, w);
    // rust: w.f32(v.radius);
    // rust: w.i32(v.block_count);
    // rust: <Opt<Vec3d>>::write(&v.knockback, w);
    // rust: v.particle.write(w);
    // rust: SoundHolder::write(&v.sound, w);
    // rust: w.varint(v.block_particles.len() as i32);
    // rust: for b in &v.block_particles {
    // rust: b.particle.write(w);
    // rust: w.f32(b.scaling);
    // rust: w.f32(b.speed);
    // rust: w.varint(b.weight);
}
    // rust: w.bool(v.play_sound);
}
}
// `ClientboundSetPlayerTeamPacket.Parameters`.
TeamParameters :: struct {
    display_name: Tag,
    prefix: Tag,
    suffix: Tag,
    // `Team.Visibility` id.
    name_tag_visibility: i32,
    // `Team.CollisionRule` id.
    collision_rule: i32,
    // `TeamColor` id (0 black .. 15 white), absent for no colour.
    color: Maybe(i32),
    // 1: friendly fire, 2: see friendly invisibles.
    options: i8,
}
// ClientboundSetPlayerTeamPacket: method 0 adds (parameters and players),
// 1 removes, 2 changes (parameters), 3 joins and 4 leaves (players).
SetPlayerTeam :: struct {
    name: string,
    method: i8,
    parameters: Maybe(TeamParameters),
    players: [dynamic]string,
}
    // rust: impl Codec<SetPlayerTeam> for SetPlayerTeam {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let name = r.string(32767)?;
    // rust: let method = r.i8()?;
    // rust: let parameters = if method == 0 || method == 2 {
    // rust: Some(TeamParameters {
    // rust: display_name: r.nbt()?,
    // rust: prefix: r.nbt()?,
    // rust: suffix: r.nbt()?,
    // rust: name_tag_visibility: r.varint()?,
    // rust: collision_rule: r.varint()?,
    // rust: color: <Opt<VarInt>>::read(r)?,
    // rust: options: r.i8()?,
    // rust: })
    // rust: } else {
    // rust: None
}
    // rust: let players = if matches!(method, 0 | 3 | 4) {
    // rust: <List<Str>>::read(r)?
    // rust: } else {
    // rust: Vec::new()
}
    // rust: Ok(Self {
    // rust: name,
    // rust: method,
    // rust: parameters,
    // rust: players,
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: w.string(&v.name);
    // rust: w.i8(v.method);
    // rust: if v.method == 0 || v.method == 2 {
    // rust: let p = v.parameters.clone().unwrap_or(TeamParameters {
    // rust: display_name: Tag::End,
    // rust: prefix: Tag::End,
    // rust: suffix: Tag::End,
    // rust: name_tag_visibility: 0,
    // rust: collision_rule: 0,
    // rust: color: None,
    // rust: options: 0,
    // rust: });
    // rust: w.nbt(&p.display_name);
    // rust: w.nbt(&p.prefix);
    // rust: w.nbt(&p.suffix);
    // rust: w.varint(p.name_tag_visibility);
    // rust: w.varint(p.collision_rule);
    // rust: <Opt<VarInt>>::write(&p.color, w);
    // rust: w.i8(p.options);
}
    // rust: if matches!(v.method, 0 | 3 | 4) {
    // rust: <List<Str>>::write(&v.players, w);
}
}
}
    // rust: packet!(ServerData { motd: Tag => Nbt, icon: Option<Vec<u8>> => Opt<crate::buf::Bytes> });
    // rust: packet!(
    // ClientboundUpdateMobEffectPacket; flags: 1 ambient, 2 visible, 4 icon, 8 blend.
    // rust: UpdateMobEffect { id: i32 => VarInt, effect: i32 => VarInt, amplifier: i32 => VarInt, duration: i32 => VarInt, flags: i8 => Byte }
    // rust: );
    // rust: packet!(RemoveMobEffect { id: i32 => VarInt, effect: i32 => VarInt });
    // rust: packet!(
    // AttributeModifier.STREAM_CODEC: id, amount and operation (0 add_value,
    // 1 add_multiplied_base, 2 add_multiplied_total).
    // rust: AttributeModifier { id: String => Ident, amount: f64 => Double, operation: i32 => VarInt }
    // rust: );
    // rust: packet!(
    // ClientboundUpdateAttributesPacket.AttributeSnapshot: the attribute's
    // registry id, its base value and every modifier.
    // rust: AttributeSnapshot {
    // rust: attribute: i32 => VarInt,
    // rust: base: f64 => Double,
    // rust: modifiers: Vec<AttributeModifier> => List<AttributeModifier>,
}
    // rust: );
    // rust: packet!(
    // ClientboundUpdateAttributesPacket: an entity's synced attribute instances.
    // rust: UpdateAttributes { id: i32 => VarInt, values: Vec<AttributeSnapshot> => List<AttributeSnapshot> }
    // rust: );
    // rust: packet!(
    // ClientboundSwingAnimationPacket: hand (0 main, 1 off) and the swing
    // type (0 none, 1 whack, 2 stab) with its duration in ticks.
    // rust: SwingAnimation { id: i32 => VarInt, hand: i32 => VarInt, kind: i32 => VarInt, duration: i32 => VarInt }
    // rust: );
    // rust: packet!(SoundEntity {
    // rust: sound: (i32, Option<(String, Option<f32>)>) => SoundHolder,
    // rust: source: i32 => VarInt,
    // rust: id: i32 => VarInt,
    // rust: volume: f32 => Float,
    // rust: pitch: f32 => Float,
    // rust: seed: i64 => Long,
    // rust: });

// ClientboundStopSoundPacket: bit 0 selects a source, bit 1 an event id.
StopSound :: struct {
    source: Maybe(i32),
    sound: Maybe(string),
}
    // rust: impl Codec<StopSound> for StopSound {
read :: proc(r: ^Reader) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let flags = r.u8()?;
    // rust: let source = if flags & 1 != 0 {
    // rust: let value = r.varint()?;
    // rust: if !(0..11).contains(&value) {
    // rust: return Err(crate::Error::new("invalid sound source"));
}
    // rust: Some(value)
    // rust: } else {
    // rust: None
}
    // rust: let sound = if flags & 2 != 0 {
    // rust: Some(r.string(32767)?)
    // rust: } else {
    // rust: None
}
    // rust: Ok(Self { source, sound })
}
write :: proc(p: ^Self, w: ^Writer) {
}
    // rust: w.u8(u8::from(p.source.is_some()) | (u8::from(p.sound.is_some()) << 1));
    // rust: if let Some(source) = p.source {
    // rust: w.varint(source);
}
    // rust: if let Some(sound) = &p.sound {
    // rust: w.string(sound);
}
}
}
// One entry of ClientboundCommandsPacket: a literal or an argument node.
CommandNode :: struct {
    // 0 root, 1 literal, 2 argument.
    kind: u8,
    executable: bool,
    restricted: bool,
    children: [dynamic]i32,
    redirect: Maybe(i32),
    name: string,
    // Argument parser registry id and its raw property bytes.
    parser: Option<(i32,
    // Custom suggestion provider (`minecraft:ask_server`).
    suggestions: Maybe(string),
}
// The `minecraft:command_argument_type` registry of 26.3 in id order
// (ArgumentTypeInfos.bootstrap).
    // rust: pub const ARGUMENT_TYPES: &[&str] = &[
    // rust: "brigadier:bool",
    // rust: "brigadier:float",
    // rust: "brigadier:double",
    // rust: "brigadier:integer",
    // rust: "brigadier:long",
    // rust: "brigadier:string",
    // rust: "minecraft:entity",
    // rust: "minecraft:game_profile",
    // rust: "minecraft:block_pos",
    // rust: "minecraft:column_pos",
    // rust: "minecraft:vec3",
    // rust: "minecraft:vec2",
    // rust: "minecraft:block_state",
    // rust: "minecraft:block_predicate",
    // rust: "minecraft:item_stack",
    // rust: "minecraft:item_predicate",
    // rust: "minecraft:team_color",
    // rust: "minecraft:hex_color",
    // rust: "minecraft:component",
    // rust: "minecraft:style",
    // rust: "minecraft:message",
    // rust: "minecraft:nbt_compound_tag",
    // rust: "minecraft:nbt_tag",
    // rust: "minecraft:nbt_path",
    // rust: "minecraft:objective",
    // rust: "minecraft:objective_criteria",
    // rust: "minecraft:operation",
    // rust: "minecraft:particle",
    // rust: "minecraft:angle",
    // rust: "minecraft:rotation",
    // rust: "minecraft:scoreboard_slot",
    // rust: "minecraft:score_holder",
    // rust: "minecraft:swizzle",
    // rust: "minecraft:team",
    // rust: "minecraft:item_slot",
    // rust: "minecraft:item_slots",
    // rust: "minecraft:resource_location",
    // rust: "minecraft:function",
    // rust: "minecraft:entity_anchor",
    // rust: "minecraft:int_range",
    // rust: "minecraft:float_range",
    // rust: "minecraft:dimension",
    // rust: "minecraft:gamemode",
    // rust: "minecraft:time",
    // rust: "minecraft:resource_or_tag",
    // rust: "minecraft:resource_or_tag_key",
    // rust: "minecraft:resource",
    // rust: "minecraft:resource_key",
    // rust: "minecraft:resource_selector",
    // rust: "minecraft:template_mirror",
    // rust: "minecraft:template_rotation",
    // rust: "minecraft:heightmap",
    // rust: "minecraft:loot_table",
    // rust: "minecraft:loot_predicate",
    // rust: "minecraft:loot_modifier",
    // rust: "minecraft:context_float_provider",
    // rust: "minecraft:context_int_provider",
    // rust: "minecraft:slot_source",
    // rust: "minecraft:dialog",
    // rust: "minecraft:feature",
    // rust: "minecraft:swing_animation",
    // rust: "minecraft:uuid",
    // rust: ];

// The properties of an argument parser (`ArgumentTypeInfo.Template`) as
// one of the 26.3 parsers decoded from the network.
ArgumentProperties :: enum {
    None,
    Integer {,
    min: Option<i32>,
    max: Option<i32>,
    // rust: },
    Long {,
    min: Option<i64>,
    max: Option<i64>,
    // rust: },
    Float {,
    min: Option<f32>,
    max: Option<f32>,
    // rust: },
    Double {,
    min: Option<f64>,
    max: Option<f64>,
    // rust: },
    // StringArgumentType.StringType: 0 word, 1 phrase, 2 greedy.
    String(i32),
    Entity {,
    single: bool,
    players_only: bool,
    // rust: },
    ScoreHolder {,
    multiple: bool,
    // rust: },
    Time {,
    min: i32,
    // rust: },
    // The resource arguments' registry.
    Registry(String),
}

    // rust: impl ArgumentProperties {
    // ArgumentTypeInfo.deserializeFromNetwork for parser `id`.
read :: proc(r: ^Reader, id: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let name = usize::try_from(id)
    // rust: .ok()
    // rust: .and_then(|i| ARGUMENT_TYPES.get(i))
    // rust: .ok_or_else(|| crate::Error::new(format!("unknown argument type {id}")))?;
    // rust: let flagged = |r: &mut Reader| -> Result<(bool, bool)> {
    // rust: let f = r.u8()?;
    // rust: Ok((f & 1 != 0, f & 2 != 0))
}
    // rust: Ok(match *name {
    // rust: "brigadier:integer" => {
    // rust: let (min, max) = flagged(r)?;
    // rust: let min = if min { Some(r.i32()?) } else { None };
    // rust: let max = if max { Some(r.i32()?) } else { None };
    // rust: Self::Integer { min, max }
}
    // rust: "brigadier:long" => {
    // rust: let (min, max) = flagged(r)?;
    // rust: let min = if min { Some(r.i64()?) } else { None };
    // rust: let max = if max { Some(r.i64()?) } else { None };
    // rust: Self::Long { min, max }
}
    // rust: "brigadier:float" => {
    // rust: let (min, max) = flagged(r)?;
    // rust: let min = if min { Some(r.f32()?) } else { None };
    // rust: let max = if max { Some(r.f32()?) } else { None };
    // rust: Self::Float { min, max }
}
    // rust: "brigadier:double" => {
    // rust: let (min, max) = flagged(r)?;
    // rust: let min = if min { Some(r.f64()?) } else { None };
    // rust: let max = if max { Some(r.f64()?) } else { None };
    // rust: Self::Double { min, max }
}
    // rust: "brigadier:string" => Self::String(r.varint()?),
    // rust: "minecraft:entity" => {
    // rust: let f = r.u8()?;
    // rust: Self::Entity {
    // rust: single: f & 1 != 0,
    // rust: players_only: f & 2 != 0,
}
}
    // rust: "minecraft:score_holder" => Self::ScoreHolder {
    // rust: multiple: r.u8()? & 1 != 0,
    // rust: },
    // rust: "minecraft:time" => Self::Time { min: r.i32()? },
    // rust: "minecraft:resource"
    // rust: | "minecraft:resource_key"
    // rust: | "minecraft:resource_or_tag"
    // rust: | "minecraft:resource_or_tag_key"
    // rust: | "minecraft:resource_selector" => Self::Registry(r.string(32767)?),
    // rust: _ => Self::None,
    // rust: })
}
    // Decodes a node's raw `parser` bytes.
decode :: proc(id: i32, bytes: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::read(&mut Reader::new(bytes), id)
}
}

// Reads past an argument node's parser properties.
read_argument_properties :: proc(r: ^Reader, id: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: ArgumentProperties::read(r, id).map(|_| ())
}

// Whether following `edges` from any node never comes back to it. An index
// outside the nodes leads nowhere (the dispatcher drops it).
acyclic :: proc(nodes: ^[CommandNode], edges: impl Fn(^CommandNode) -> ^ {
    // Ported from Horizon
    return {}
}
NEW :: 0
ON_PATH :: 1
DONE :: 2
    // rust: let mut state = vec![NEW; nodes.len()];
    // Depth first without recursion: a node and how many of its edges are followed.
    // rust: let mut path: Vec<(usize, usize)> = Vec::new();
    // rust: for start in 0..nodes.len() {
    // rust: if state[start] != NEW {
    // rust: continue;
}
    // rust: state[start] = ON_PATH;
    // rust: path.push((start, 0));
    // rust: while let Some(&(node, followed)) = path.last() {
    // rust: let Some(&edge) = edges(&nodes[node]).get(followed) else {
    // rust: state[node] = DONE;
    // rust: path.pop();
    // rust: continue;
}
    // rust: if let Some(top) = path.last_mut() {
    // rust: top.1 += 1;
}
    // rust: let Some(next) = usize::try_from(edge).ok().filter(|&e| e < nodes.len()) else {
    // rust: continue;
}
    // rust: match state[next] {
    // rust: ON_PATH => return false,
    // rust: NEW => {
    // rust: state[next] = ON_PATH;
    // rust: path.push((next, 0));
}
    // rust: _ => {}
}
}
}
    // rust: true
}

// The command tree: nodes and the index of the root.
Commands :: struct {
    nodes: [dynamic]CommandNode,
    root: i32,
}
    // rust: impl Codec<Commands> for Commands {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut nodes = Vec::with_capacity(n.min(4096));
    // rust: for _ in 0..n {
    // rust: let flags = r.u8()?;
    // rust: let count = r.count(r.remaining())?;
    // rust: let children = (0..count).map(|_| r.varint()).collect::<Result<_>>()?;
    // rust: let redirect = if flags & 8 != 0 {
    // rust: Some(r.varint()?)
    // rust: } else {
    // rust: None
}
    // rust: let kind = flags & 3;
    // rust: let (mut name, mut parser, mut suggestions) = (String::new(), None, None);
    // rust: if kind >= 1 {
    // rust: name = r.string(32767)?;
}
    // rust: if kind == 2 {
    // rust: let id = r.varint()?;
    // rust: let start = r.position();
    // rust: read_argument_properties(r, id)?;
    // rust: parser = Some((id, r.since(start).to_vec()));
    // rust: if flags & 16 != 0 {
    // rust: suggestions = Some(r.string(32767)?);
}
}
    // rust: nodes.push(CommandNode {
    // rust: kind,
    // rust: executable: flags & 4 != 0,
    // rust: restricted: flags & 32 != 0,
    // rust: children,
    // rust: redirect,
    // rust: name,
    // rust: parser,
    // rust: suggestions,
    // rust: });
}
        // ClientboundCommandsPacket.validateEntries: every node's redirect builds
        // first (canBuild), then its children (canResolve). A cycle in either never
        // does, and walking it would recurse without end.
    // rust: if !acyclic(&nodes, |n| n.redirect.as_slice()) || !acyclic(&nodes, |n| &n.children) {
    // rust: return Err(crate::Error::new("Server sent an impossible command tree"));
}
    // rust: Ok(Self {
    // rust: nodes,
    // rust: root: r.varint()?,
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: w.varint(v.nodes.len() as i32);
    // rust: for n in &v.nodes {
    // rust: let mut flags = n.kind & 3;
    // rust: if n.executable {
    // rust: flags |= 4;
}
    // rust: if n.redirect.is_some() {
    // rust: flags |= 8;
}
    // rust: if n.suggestions.is_some() {
    // rust: flags |= 16;
}
    // rust: if n.restricted {
    // rust: flags |= 32;
}
    // rust: w.u8(flags);
    // rust: w.varint(n.children.len() as i32);
    // rust: n.children.iter().for_each(|c| w.varint(*c));
    // rust: if let Some(r) = n.redirect {
    // rust: w.varint(r);
}
    // rust: if n.kind >= 1 {
    // rust: w.string(&n.name);
}
    // rust: if n.kind == 2 {
    // rust: let (id, props) = n.parser.clone().unwrap_or((5, Vec::new()));
    // rust: w.varint(id);
    // rust: w.bytes(&props);
    // rust: if let Some(s) = &n.suggestions {
    // rust: w.string(s);
}
}
}
    // rust: w.varint(v.root);
}
}

// `DisplayInfo` of an advancement as sent.
AdvancementDisplay :: struct {
    title: Tag,
    description: Tag,
    icon: crate::item::Stack,
    // `AdvancementType` ordinal: task, challenge, goal.
    frame: i32,
    show_toast: bool,
    hidden: bool,
    background: Maybe(string),
}
// `ClientboundUpdateAdvancementsPacket.PositionedAdvancement`.
Advancement :: struct {
    id: string,
    parent: Maybe(string),
    display: Maybe(AdvancementDisplay),
    requirements: [dynamic]Vec<string>,
    telemetry: bool,
    x: f32,
    y: f32,
}
// `ClientboundUpdateAdvancementsPacket`: whether it replaces what the
// client has, the advancements added and removed, the progress of each
// changed one (criterion, when obtained in epoch milliseconds), and whether
// to show toasts.
UpdateAdvancements :: struct {
    reset: bool,
    added: [dynamic]Advancement,
    removed: [dynamic]string,
    progress: Vec<(string,
    show: bool,
}
    // rust: impl Codec<UpdateAdvancements> for UpdateAdvancements {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let reset = r.bool()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut added = Vec::with_capacity(n.min(1024));
    // rust: for _ in 0..n {
    // rust: let id = r.string(32767)?;
    // rust: let parent = if r.bool()? {
    // rust: Some(r.string(32767)?)
    // rust: } else {
    // rust: None
}
    // rust: let display = if r.bool()? {
    // rust: let title = r.nbt()?;
    // rust: let description = r.nbt()?;
    // rust: let icon = crate::item::Template::read(r)?;
    // rust: let frame = r.varint()?;
    // rust: let flags = r.i32()?;
    // rust: let background = if flags & 1 != 0 {
    // rust: Some(r.string(32767)?)
    // rust: } else {
    // rust: None
}
    // rust: Some(AdvancementDisplay {
    // rust: title,
    // rust: description,
    // rust: icon,
    // rust: frame,
    // rust: show_toast: flags & 2 != 0,
    // rust: hidden: flags & 4 != 0,
    // rust: background,
    // rust: })
    // rust: } else {
    // rust: None
}
    // rust: let groups = r.count(r.remaining())?;
    // rust: let mut requirements = Vec::with_capacity(groups.min(256));
    // rust: for _ in 0..groups {
    // rust: let k = r.count(r.remaining())?;
    // rust: requirements.push((0..k).map(|_| r.string(32767)).collect::<Result<_>>()?);
}
    // rust: let telemetry = r.bool()?;
    // rust: let (x, y) = (r.f32()?, r.f32()?);
    // rust: added.push(Advancement {
    // rust: id,
    // rust: parent,
    // rust: display,
    // rust: requirements,
    // rust: telemetry,
    // rust: x,
    // rust: y,
    // rust: });
}
    // rust: let n = r.count(r.remaining())?;
    // rust: let removed = (0..n).map(|_| r.string(32767)).collect::<Result<_>>()?;
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut progress = Vec::with_capacity(n.min(1024));
    // rust: for _ in 0..n {
    // rust: let id = r.string(32767)?;
    // rust: let k = r.count(r.remaining())?;
    // rust: let mut criteria = Vec::with_capacity(k.min(256));
    // rust: for _ in 0..k {
    // rust: let name = r.string(32767)?;
    // rust: let at = if r.bool()? { Some(r.i64()?) } else { None };
    // rust: criteria.push((name, at));
}
    // rust: progress.push((id, criteria));
}
    // rust: let show = r.bool()?;
    // rust: Ok(Self {
    // rust: reset,
    // rust: added,
    // rust: removed,
    // rust: progress,
    // rust: show,
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: w.bool(v.reset);
    // rust: w.varint(v.added.len() as i32);
    // rust: for a in &v.added {
    // rust: w.string(&a.id);
    // rust: w.bool(a.parent.is_some());
    // rust: if let Some(p) = &a.parent {
    // rust: w.string(p);
}
    // rust: w.bool(a.display.is_some());
    // rust: if let Some(d) = &a.display {
    // rust: w.nbt(&d.title);
    // rust: w.nbt(&d.description);
    // rust: crate::item::Template::write(&d.icon, w);
    // rust: w.varint(d.frame);
    // rust: w.i32(
    // rust: i32::from(d.background.is_some())
    // rust: | i32::from(d.show_toast) << 1
    // rust: | i32::from(d.hidden) << 2,
    // rust: );
    // rust: if let Some(b) = &d.background {
    // rust: w.string(b);
}
}
    // rust: w.varint(a.requirements.len() as i32);
    // rust: for g in &a.requirements {
    // rust: w.varint(g.len() as i32);
    // rust: for c in g {
    // rust: w.string(c);
}
}
    // rust: w.bool(a.telemetry);
    // rust: w.f32(a.x);
    // rust: w.f32(a.y);
}
    // rust: w.varint(v.removed.len() as i32);
    // rust: for id in &v.removed {
    // rust: w.string(id);
}
    // rust: w.varint(v.progress.len() as i32);
    // rust: for (id, criteria) in &v.progress {
    // rust: w.string(id);
    // rust: w.varint(criteria.len() as i32);
    // rust: for (name, at) in criteria {
    // rust: w.string(name);
    // rust: w.bool(at.is_some());
    // rust: if let Some(at) = at {
    // rust: w.i64(*at);
}
}
}
    // rust: w.bool(v.show);
}
}
    // rust: packet!(
    // ClientboundAwardStatsPacket: (stat type, value, count) by network id.
    // rust: AwardStats { stats: Vec<(i32, i32, i32)> => StatList }
    // rust: );
// `Object2IntMap<Stat<?>>`: each stat's type and value ids, then its count.
StatList :: struct {
    // rust: impl Codec<Vec<(i32, i32, i32)>> for StatList {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = r.count(r.remaining())?;
    // rust: (0..n)
    // rust: .map(|_| Ok((r.varint()?, r.varint()?, r.varint()?)))
    // rust: .collect()
}
write :: proc(v: ^Vec<(i32) {
}
    // rust: w.varint(v.len() as i32);
    // rust: for &(a, b, c) in v {
    // rust: w.varint(a);
    // rust: w.varint(b);
    // rust: w.varint(c);
}
}
}

// `ClientboundBossEventPacket` (`boss_event`).
BossAction :: enum {
    Add {,
    name: Tag,
    progress: f32,
        // `BossBarColor` ordinal.
    color: i32,
        // `BossBarOverlay` ordinal.
    overlay: i32,
    darken: bool,
    music: bool,
    fog: bool,
    // rust: },
    Remove,
    UpdateProgress {,
    progress: f32,
    // rust: },
    UpdateName {,
    name: Tag,
    // rust: },
    UpdateStyle {,
    color: i32,
    overlay: i32,
    // rust: },
    UpdateProperties {,
    darken: bool,
    music: bool,
    fog: bool,
    // rust: },
}

BossEvent :: struct {
    id: u128,
    action: BossAction,
}
boss_flags :: proc(darken: bool, music: bool, fog: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: u8::from(darken) | (u8::from(music) << 1) | (u8::from(fog) << 2)
}
split_flags :: proc(flags: u8) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (flags & 1 != 0, flags & 2 != 0, flags & 4 != 0)
}
    // rust: impl Codec<BossEvent> for BossEvent {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = r.uuid()?;
    // rust: let action = match r.varint()? {
    // rust: 0 => {
    // rust: let name = r.nbt()?;
    // rust: let progress = r.f32()?;
    // rust: let color = r.varint()?;
    // rust: let overlay = r.varint()?;
    // rust: let (darken, music, fog) = split_flags(r.u8()?);
    // rust: BossAction::Add {
    // rust: name,
    // rust: progress,
    // rust: color,
    // rust: overlay,
    // rust: darken,
    // rust: music,
    // rust: fog,
}
}
    // rust: 1 => BossAction::Remove,
    // rust: 2 => BossAction::UpdateProgress { progress: r.f32()? },
    // rust: 3 => BossAction::UpdateName { name: r.nbt()? },
    // rust: 4 => BossAction::UpdateStyle {
    // rust: color: r.varint()?,
    // rust: overlay: r.varint()?,
    // rust: },
    // rust: 5 => {
    // rust: let (darken, music, fog) = split_flags(r.u8()?);
    // rust: BossAction::UpdateProperties { darken, music, fog }
}
    // rust: op => return Err(Error::new(format!("unknown boss event operation {op}"))),
}
    // rust: Ok(BossEvent { id, action })
}
write :: proc(v: ^BossEvent, w: ^Writer) {
}
    // rust: w.uuid(v.id);
    // rust: match &v.action {
    // rust: BossAction::Add {
    // rust: name,
    // rust: progress,
    // rust: color,
    // rust: overlay,
    // rust: darken,
    // rust: music,
    // rust: fog,
    // rust: } => {
    // rust: w.varint(0);
    // rust: w.nbt(name);
    // rust: w.f32(*progress);
    // rust: w.varint(*color);
    // rust: w.varint(*overlay);
    // rust: w.u8(boss_flags(*darken, *music, *fog));
}
    // rust: BossAction::Remove => w.varint(1),
    // rust: BossAction::UpdateProgress { progress } => {
    // rust: w.varint(2);
    // rust: w.f32(*progress);
}
    // rust: BossAction::UpdateName { name } => {
    // rust: w.varint(3);
    // rust: w.nbt(name);
}
    // rust: BossAction::UpdateStyle { color, overlay } => {
    // rust: w.varint(4);
    // rust: w.varint(*color);
    // rust: w.varint(*overlay);
}
    // rust: BossAction::UpdateProperties { darken, music, fog } => {
    // rust: w.varint(5);
    // rust: w.u8(boss_flags(*darken, *music, *fog));
}
}
}
}

    // rust: packet_enum!(Clientbound, crate::ids::play::clientbound {
    // rust: BundleDelimiter(Empty) = BUNDLE_DELIMITER,
    // rust: AddEntity(AddEntity) = ADD_ENTITY,
    // rust: Animate(Animate) = ANIMATE,
    // rust: AwardStats(AwardStats) = AWARD_STATS,
    // rust: BlockChangedAck(BlockChangedAck) = BLOCK_CHANGED_ACK,
    // rust: BlockDestruction(BlockDestruction) = BLOCK_DESTRUCTION,
    // rust: BlockEntityData(BlockEntityData) = BLOCK_ENTITY_DATA,
    // rust: BlockEvent(BlockEvent) = BLOCK_EVENT,
    // rust: BlockUpdate(BlockUpdate) = BLOCK_UPDATE,
    // rust: BossEvent(BossEvent) = BOSS_EVENT,
    // rust: ChangeDifficulty(ChangeDifficulty) = CHANGE_DIFFICULTY,
    // rust: ChunkBatchFinished(ChunkBatchFinished) = CHUNK_BATCH_FINISHED,
    // rust: ChunkBatchStart(Empty) = CHUNK_BATCH_START,
    // rust: ClearTitles(Bool1) = CLEAR_TITLES,
    // rust: LowDiskSpaceWarning(Empty) = LOW_DISK_SPACE_WARNING,
    // rust: Commands(Commands) = COMMANDS,
    // rust: RecipeBookAdd(super::recipes::RecipeBookAdd) = RECIPE_BOOK_ADD,
    // rust: RecipeBookRemove(super::recipes::RecipeBookRemove) = RECIPE_BOOK_REMOVE,
    // rust: RecipeBookSettings(super::recipes::RecipeBookSettings) = RECIPE_BOOK_SETTINGS,
    // rust: PlaceGhostRecipe(super::recipes::PlaceGhostRecipe) = PLACE_GHOST_RECIPE,
    // rust: ContainerClose(ContainerClose) = CONTAINER_CLOSE,
    // rust: ContainerSetContent(ContainerSetContent) = CONTAINER_SET_CONTENT,
    // rust: ContainerSetData(ContainerSetData) = CONTAINER_SET_DATA,
    // rust: ContainerSetSlot(ContainerSetSlot) = CONTAINER_SET_SLOT,
    // rust: CookieRequest(CookieRequest) = COOKIE_REQUEST,
    // rust: Cooldown(Cooldown) = COOLDOWN,
    // rust: CustomChatCompletions(CustomChatCompletions) = CUSTOM_CHAT_COMPLETIONS,
    // rust: CustomPayload(CustomPayload) = CUSTOM_PAYLOAD,
    // rust: Disconnect(Disconnect) = DISCONNECT,
    // rust: DeleteChat(DeleteChat) = DELETE_CHAT,
    // rust: DisguisedChat(DisguisedChat) = DISGUISED_CHAT,
    // rust: EntityEvent(EntityEvent) = ENTITY_EVENT,
    // rust: EntityPositionSync(EntityPositionSync) = ENTITY_POSITION_SYNC,
    // rust: ChunksBiomes(ChunksBiomes) = CHUNKS_BIOMES,
    // rust: ForgetLevelChunk(ForgetLevelChunk) = FORGET_LEVEL_CHUNK,
    // rust: GameEvent(GameEvent) = GAME_EVENT,
    // rust: GameTestHighlightPos(GameTestHighlightPos) = GAME_TEST_HIGHLIGHT_POS,
    // rust: GameRuleValues(GameRuleValues) = GAME_RULE_VALUES,
    // rust: HurtAnimation(HurtAnimation) = HURT_ANIMATION,
    // rust: DamageEvent(DamageEvent) = DAMAGE_EVENT,
    // rust: KeepAlive(KeepAlive) = KEEP_ALIVE,
    // rust: InitializeBorder(InitializeBorder) = INITIALIZE_BORDER,
    // rust: LevelChunkWithLight(LevelChunkWithLight) = LEVEL_CHUNK_WITH_LIGHT,
    // rust: LevelEvent(LevelEvent) = LEVEL_EVENT,
    // rust: LightUpdate(LightUpdate) = LIGHT_UPDATE,
    // rust: Login(Login) = LOGIN,
    // rust: MapItemData(MapItemData) = MAP_ITEM_DATA,
    // rust: MoveEntityPos(MoveEntityPos) = MOVE_ENTITY_POS,
    // rust: MoveEntityPosRot(MoveEntityPosRot) = MOVE_ENTITY_POS_ROT,
    // rust: MoveEntityRot(MoveEntityRot) = MOVE_ENTITY_ROT,
    // rust: MerchantOffers(MerchantOffers) = MERCHANT_OFFERS,
    // rust: MountScreenOpen(MountScreenOpen) = MOUNT_SCREEN_OPEN,
    // rust: OpenScreen(OpenScreen) = OPEN_SCREEN,
    // rust: OpenBook(OpenBook) = OPEN_BOOK,
    // rust: OpenSignEditor(OpenSignEditor) = OPEN_SIGN_EDITOR,
    // rust: Ping(Ping) = PING,
    // rust: PongResponse(crate::packets::status::Ping) = PONG_RESPONSE,
    // rust: PlayerAbilities(PlayerAbilities) = PLAYER_ABILITIES,
    // rust: PlayerChat(PlayerChat) = PLAYER_CHAT,
    // rust: PlayerCombatKill(PlayerCombatKill) = PLAYER_COMBAT_KILL,
    // rust: PlayerInfoRemove(PlayerInfoRemove) = PLAYER_INFO_REMOVE,
    // rust: PlayerInfoUpdate(PlayerInfoUpdate) = PLAYER_INFO_UPDATE,
    // rust: PlayerLookAt(PlayerLookAt) = PLAYER_LOOK_AT,
    // rust: PlayerPosition(PlayerPosition) = PLAYER_POSITION,
    // rust: PlayerRotation(PlayerRotation) = PLAYER_ROTATION,
    // rust: PostEffects(PostEffects) = POST_EFFECTS,
    // rust: RemoveEntities(RemoveEntities) = REMOVE_ENTITIES,
    // rust: RemoveMobEffect(RemoveMobEffect) = REMOVE_MOB_EFFECT,
    // rust: ResetScore(ResetScore) = RESET_SCORE,
    // rust: ResourcePackPop(ResourcePackPop) = RESOURCE_PACK_POP,
    // rust: ResourcePackPush(ResourcePackPush) = RESOURCE_PACK_PUSH,
    // rust: Respawn(Respawn) = RESPAWN,
    // rust: RotateHead(RotateHead) = ROTATE_HEAD,
    // rust: SectionBlocksUpdate(SectionBlocksUpdate) = SECTION_BLOCKS_UPDATE,
    // rust: ServerData(ServerData) = SERVER_DATA,
    // rust: SetActionBarText(Text) = SET_ACTION_BAR_TEXT,
    // rust: SetBorderCenter(SetBorderCenter) = SET_BORDER_CENTER,
    // rust: SetBorderLerpSize(SetBorderLerpSize) = SET_BORDER_LERP_SIZE,
    // rust: SetBorderSize(SetBorderSize) = SET_BORDER_SIZE,
    // rust: SetBorderWarningDelay(SetBorderWarningDelay) = SET_BORDER_WARNING_DELAY,
    // rust: SetBorderWarningDistance(SetBorderWarningDistance) = SET_BORDER_WARNING_DISTANCE,
    // rust: SetChunkCacheCenter(SetChunkCacheCenter) = SET_CHUNK_CACHE_CENTER,
    // rust: SetCamera(SetCamera) = SET_CAMERA,
    // rust: SetChunkCacheRadius(Distance) = SET_CHUNK_CACHE_RADIUS,
    // rust: SetCursorItem(SetCursorItem) = SET_CURSOR_ITEM,
    // rust: SetDefaultSpawnPosition(SetDefaultSpawnPosition) = SET_DEFAULT_SPAWN_POSITION,
    // rust: SetDisplayObjective(SetDisplayObjective) = SET_DISPLAY_OBJECTIVE,
    // rust: SetEntityData(SetEntityData) = SET_ENTITY_DATA,
    // rust: SetEntityMotion(SetEntityMotion) = SET_ENTITY_MOTION,
    // rust: SetEntityLink(SetEntityLink) = SET_ENTITY_LINK,
    // rust: SetEquipment(SetEquipment) = SET_EQUIPMENT,
    // rust: SetExperience(SetExperience) = SET_EXPERIENCE,
    // rust: SetHealth(SetHealth) = SET_HEALTH,
    // rust: SetHeldSlot(SetHeldSlot) = SET_HELD_SLOT,
    // rust: SetObjective(SetObjective) = SET_OBJECTIVE,
    // rust: SetPassengers(SetPassengers) = SET_PASSENGERS,
    // rust: MoveVehicle(MoveVehicle) = MOVE_VEHICLE,
    // rust: MoveMinecartAlongTrack(MoveMinecartAlongTrack) = MOVE_MINECART_ALONG_TRACK,
    // rust: ProjectilePower(ProjectilePower) = PROJECTILE_POWER,
    // rust: SetPlayerInventory(SetPlayerInventory) = SET_PLAYER_INVENTORY,
    // rust: SetPlayerTeam(SetPlayerTeam) = SET_PLAYER_TEAM,
    // rust: SetScore(SetScore) = SET_SCORE,
    // rust: SetSimulationDistance(Distance) = SET_SIMULATION_DISTANCE,
    // rust: SetSubtitleText(Text) = SET_SUBTITLE_TEXT,
    // rust: SetTime(SetTime) = SET_TIME,
    // rust: SetTitleText(Text) = SET_TITLE_TEXT,
    // rust: SetTitlesAnimation(TitlesAnimation) = SET_TITLES_ANIMATION,
    // rust: Sound(Sound) = SOUND,
    // rust: SoundEntity(SoundEntity) = SOUND_ENTITY,
    // rust: StopSound(StopSound) = STOP_SOUND,
    // rust: StartConfiguration(Empty) = START_CONFIGURATION,
    // rust: StoreCookie(StoreCookie) = STORE_COOKIE,
    // A common packet: the same `configuration::ServerLinks` the
    // configuration phase sends.
    // rust: ServerLinks(ServerLinks) = SERVER_LINKS,
    // rust: SelectAdvancementsTab(SelectAdvancementsTab) = SELECT_ADVANCEMENTS_TAB,
    // rust: SwingAnimation(SwingAnimation) = SWING_ANIMATION,
    // rust: SystemChat(SystemChat) = SYSTEM_CHAT,
    // rust: TabList(TabList) = TAB_LIST,
    // rust: TagQuery(TagQuery) = TAG_QUERY,
    // rust: TakeItemEntity(TakeItemEntity) = TAKE_ITEM_ENTITY,
    // rust: TeleportEntity(TeleportEntity) = TELEPORT_ENTITY,
    // rust: TestInstanceBlockStatus(TestInstanceBlockStatus) = TEST_INSTANCE_BLOCK_STATUS,
    // rust: TickingState(TickingState) = TICKING_STATE,
    // rust: TickingStep(TickingStep) = TICKING_STEP,
    // rust: Transfer(Transfer) = TRANSFER,
    // rust: UpdateAdvancements(UpdateAdvancements) = UPDATE_ADVANCEMENTS,
    // rust: UpdateAttributes(UpdateAttributes) = UPDATE_ATTRIBUTES,
    // rust: LevelParticles(LevelParticles) = LEVEL_PARTICLES,
    // rust: Explode(Explode) = EXPLODE,
    // rust: AddTransientBlock(AddTransientBlock) = ADD_TRANSIENT_BLOCK,
    // rust: UpdateMobEffect(UpdateMobEffect) = UPDATE_MOB_EFFECT,
    // rust: UpdateTags(UpdateTags) = UPDATE_TAGS,
    // rust: TrackedWaypoint(TrackedWaypoint) = WAYPOINT,
    // rust: ClearDialog(Empty) = CLEAR_DIALOG,
    // rust: ShowDialog(ShowDialog) = SHOW_DIALOG,
    // rust: });
    // rust: packet!(
    // ClientboundClearTitlesPacket: whether to also reset the timings.
    // rust: Bool1 { value: bool => Bool }
    // rust: );

// ClientboundTrackedWaypointPacket.Operation, by ordinal.
    // rust: pub mod waypoint_operation {
TRACK :: 0
UNTRACK :: 1
UPDATE :: 2
}

// TrackedWaypoint's identifier: `Either<UUID, String>`.
WaypointId :: enum {
    Uuid(u128),
    Name(String),
}

// What a TrackedWaypoint points at (its `Type` and contents).
WaypointTarget :: enum {
    // `TrackedWaypoint.empty`: an untracked waypoint.
    Empty,
    // A block position (`Vec3iWaypoint`).
    Block([i32; 3]),
    // A chunk (`ChunkWaypoint`).
    Chunk([i32; 2]),
    // An angle in radians (`AzimuthWaypoint`).
    Azimuth(f32),
}

// ClientboundTrackedWaypointPacket: the locator bar's waypoints.
TrackedWaypoint :: struct {
    // `waypoint_operation`.
    operation: i32,
    id: WaypointId,
    // Waypoint.Icon: the style (a `waypoint_style_asset` key) and an RGB colour.
    style: string,
    color: Maybe(i32),
    target: WaypointTarget,
}

    // rust: impl Codec<TrackedWaypoint> for TrackedWaypoint {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let operation = r.varint()?;
    // rust: if !(0..=2).contains(&operation) {
    // rust: return Err(Error::new(format!("waypoint operation {operation}")));
}
    // rust: let id = if r.bool()? {
    // rust: WaypointId::Uuid(r.uuid()?)
    // rust: } else {
    // rust: WaypointId::Name(r.string(32767)?)
}
    // rust: let style = Ident::read(r)?;
        // ByteBufCodecs.RGB_COLOR: three bytes, read back as an opaque ARGB colour.
    // rust: let color = if r.bool()? {
    // rust: let [red, green, blue] = [r.u8()?, r.u8()?, r.u8()?].map(i32::from);
    // rust: Some(-16_777_216 | red << 16 | green << 8 | blue)
    // rust: } else {
    // rust: None
}
    // rust: let target = match r.varint()? {
    // rust: 0 => WaypointTarget::Empty,
    // rust: 1 => WaypointTarget::Block([r.varint()?, r.varint()?, r.varint()?]),
    // rust: 2 => WaypointTarget::Chunk([r.varint()?, r.varint()?]),
    // rust: 3 => WaypointTarget::Azimuth(r.f32()?),
    // rust: other => return Err(Error::new(format!("waypoint type {other}"))),
}
    // rust: Ok(TrackedWaypoint {
    // rust: operation,
    // rust: id,
    // rust: style,
    // rust: color,
    // rust: target,
    // rust: })
}
write :: proc(v: ^TrackedWaypoint, w: ^Writer) {
}
    // rust: w.varint(v.operation);
    // rust: match &v.id {
    // rust: WaypointId::Uuid(uuid) => {
    // rust: w.bool(true);
    // rust: w.uuid(*uuid);
}
    // rust: WaypointId::Name(name) => {
    // rust: w.bool(false);
    // rust: w.string(name);
}
}
    // rust: w.string(&v.style);
    // rust: w.bool(v.color.is_some());
    // rust: if let Some(color) = v.color {
    // rust: for shift in [16, 8, 0] {
    // rust: w.u8((color >> shift) as u8);
}
}
    // rust: match v.target {
    // rust: WaypointTarget::Empty => w.varint(0),
    // rust: WaypointTarget::Block([x, y, z]) => {
    // rust: w.varint(1);
    // rust: w.varint(x);
    // rust: w.varint(y);
    // rust: w.varint(z);
}
    // rust: WaypointTarget::Chunk([x, z]) => {
    // rust: w.varint(2);
    // rust: w.varint(x);
    // rust: w.varint(z);
}
    // rust: WaypointTarget::Azimuth(angle) => {
    // rust: w.varint(3);
    // rust: w.f32(angle);
}
}
}
}

// ---- serverbound -------------------------------------------------------

    // rust: packet!(AcceptTeleportation { id: i32 => VarInt, x: f64 => Double, y: f64 => Double, z: f64 => Double, yaw: f32 => Float, pitch: f32 => Float });
    // rust: packet!(Attack { id: i32 => VarInt });
    // rust: packet!(TeleportToEntity { uuid: u128 => Uuid });
    // rust: packet!(
    // ServerboundSpectatorActionPacket: the entity a spectator clicked, or
    // none for a click on nothing.
    // rust: SpectatorAction { target: Option<i32> => OptVarInt }
    // rust: );
    // rust: packet!(
    // GameType ids: 0 survival, 1 creative, 2 adventure, 3 spectator.
    // rust: ChangeGameMode { mode: i32 => VarInt }
    // rust: );
    // rust: packet!(LastSeenUpdate { offset: i32 => VarInt, acknowledged: [u8; 3] => Fixed3, checksum: i8 => Byte });
// LastSeenMessages.Update's fixed 20-bit BitSet (3 bytes).
Fixed3 :: struct {
    // rust: impl Codec<[u8; 3]> for Fixed3 {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(r.bytes(3)?.try_into().expect("3 bytes"))
}
write :: proc(v: ^[u8; 3], w: ^Writer) {
}
    // rust: w.bytes(v)
}
}
    // rust: packet!(Chat {
    // rust: message: String => StrN<256>,
    // rust: timestamp: i64 => Long,
    // rust: salt: i64 => Long,
    // rust: signature: Option<Vec<u8>> => Opt<Signature>,
    // rust: last_seen: LastSeenUpdate => LastSeenUpdate,
    // rust: });
    // rust: packet!(ChatCommand { command: String => Str });
    // rust: packet!(ChatAck { offset: i32 => VarInt });
// ArgumentSignatures: each signed argument's name (at most 16 chars) and
// signature, at most 8.
ArgumentSignatures :: struct {
    // rust: impl Codec<Vec<(String, Vec<u8>)>> for ArgumentSignatures {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = r.count(8)?;
    // rust: (0..n)
    // rust: .map(|_| Ok((r.string(16)?, r.bytes(256)?.to_vec())))
    // rust: .collect()
}
write :: proc(v: ^Vec<(string) {
}
    // rust: w.varint(v.len() as i32);
    // rust: for (name, signature) in v {
    // rust: w.string(name);
    // rust: w.bytes(signature);
}
}
}
    // rust: packet!(ChatCommandSigned {
    // rust: command: String => Str,
    // rust: timestamp: i64 => Long,
    // rust: salt: i64 => Long,
    // rust: arguments: Vec<(String, Vec<u8>)> => ArgumentSignatures,
    // rust: last_seen: LastSeenUpdate => LastSeenUpdate,
    // rust: });
    // rust: packet!(
    // RemoteChatSession.Data: the session id, then ProfilePublicKey.Data
    // (expiry in epoch milliseconds, X.509 key, the services' signature).
    // rust: ChatSessionUpdate {
    // rust: session: u128 => Uuid,
    // rust: expires_at: i64 => Long,
    // rust: key: Vec<u8> => BytesN<512>,
    // rust: key_signature: Vec<u8> => BytesN<4096>,
}
    // rust: );
    // rust: packet!(ChangeDifficultyRequest { difficulty: i32 => VarInt });
    // rust: packet!(LockDifficulty { locked: bool => Bool });
// ServerboundPlayerAbilitiesPacket: only whether the player flies (2).
    // rust: packet!(PlayerAbilitiesRequest { flags: i8 => Byte });
    // rust: packet!(SetGameRule { entries: Vec<GameRuleEntry> => List<GameRuleEntry> });
    // rust: packet!(ChunkBatchReceived { chunks_per_tick: f32 => Float });
    // rust: packet!(
    // ServerboundClientCommandPacket.Action: 0 respawn, 1 request stats, 2 request game rules.
    // rust: ClientCommand { action: i32 => VarInt }
    // rust: );
// Changed slots: (slot, hashed stack) pairs.
ChangedSlots :: struct {
    // rust: impl Codec<Vec<(i16, Option<Hashed>)>> for ChangedSlots {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = r.count(128)?;
    // rust: (0..n)
    // rust: .map(|_| Ok((r.i16()?, HashedSlot::read(r)?)))
    // rust: .collect()
}
write :: proc(v: ^Vec<(i16) {
}
    // rust: w.varint(v.len() as i32);
    // rust: for (slot, h) in v {
    // rust: w.i16(*slot);
    // rust: HashedSlot::write(h, w);
}
}
}
    // rust: packet!(
    // ContainerInput: 0 pickup, 1 quick move, 2 swap, 3 clone, 4 throw, 5 quick craft, 6 pickup all.
    // rust: ContainerClick {
    // rust: container: i32 => VarInt,
    // rust: state: i32 => VarInt,
    // rust: slot: i16 => Short,
    // rust: button: i8 => Byte,
    // rust: input: i32 => VarInt,
    // rust: changed: Vec<(i16, Option<Hashed>)> => ChangedSlots,
    // rust: carried: Option<Hashed> => HashedSlot,
}
    // rust: );
// ServerboundSeenAdvancementsPacket: the tab the player opened (action 0, `OPENED_TAB`), or
// that its screen closed (1, `CLOSED_SCREEN`, which carries no tab).
SeenAdvancements :: struct {
    action: i32,
    tab: Maybe(string),
}
    // rust: impl Codec<SeenAdvancements> for SeenAdvancements {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let action = r.varint()?;
        // The identifier is there for OPENED_TAB only (`readIdentifier` in the other branch).
    // rust: let tab = match action {
    // rust: 0 => Some(r.string(32767)?),
    // rust: _ => None,
}
    // rust: Ok(SeenAdvancements { action, tab })
}
write :: proc(v: ^SeenAdvancements, w: ^Writer) {
}
    // rust: w.varint(v.action);
    // rust: if v.action == 0 {
    // rust: w.string(v.tab.as_deref().unwrap_or_default());
}
}
}
    // rust: packet!(SelectTrade { item: i32 => VarInt });
    // rust: packet!(
    // ServerboundBlockEntityTagQueryPacket: an operator's F3+I asks for the
    // block entity's data at a position.
    // rust: BlockEntityTagQuery { transaction: i32 => VarInt, pos: [i32; 3] => Pos }
    // rust: );
    // rust: packet!(
    // ServerboundEntityTagQueryPacket: an operator's F3+I asks for an
    // entity's data, by its network id.
    // rust: EntityTagQuery { transaction: i32 => VarInt, entity: i32 => VarInt }
    // rust: );
    // rust: packet!(
    // ServerboundContainerButtonClickPacket: `AbstractContainerMenu.clickMenuButton`
    // (the loom's patterns, the stonecutter's recipes, the enchanting table's offers).
    // rust: ContainerButtonClick { container: i32 => VarInt, button: i32 => VarInt }
    // rust: );
    // rust: packet!(
    // ServerboundContainerSlotStateChangedPacket: the crafter's slot toggle
    // (`CrafterBlockEntity.setSlotState`).
    // rust: ContainerSlotStateChanged { slot: i32 => VarInt, container: i32 => VarInt, enabled: bool => Bool }
    // rust: );
    // rust: packet!(
    // ServerboundRenameItemPacket: `AnvilMenu.setItemName`.
    // rust: RenameItem { name: String => Str }
    // rust: );
    // rust: packet!(
    // ServerboundSignUpdatePacket: the four lines the player wrote on a side.
    // rust: SignUpdate { pos: [i32; 3] => Pos, lines: [String; 4] => SignLines, front: bool => SignSide }
    // rust: );
    // rust: packet!(
    // ServerboundSetJigsawBlockPacket: the jigsaw block's edit screen. The
    // joint is `JointType.getSerializedName`; an unknown one reads as aligned.
    // rust: SetJigsawBlock {
    // rust: pos: [i32; 3] => Pos,
    // rust: name: String => Ident,
    // rust: target: String => Ident,
    // rust: pool: String => Ident,
    // rust: final_state: String => Str,
    // rust: joint: String => Str,
    // rust: selection_priority: i32 => VarInt,
    // rust: placement_priority: i32 => VarInt
}
    // rust: );
    // rust: packet!(
    // ServerboundSetTestBlockPacket: the test block's edit screen; `mode` is
    // a `TestBlockMode` id.
    // rust: SetTestBlock { pos: [i32; 3] => Pos, mode: i32 => VarInt, message: String => Str }
    // rust: );
    // rust: packet!(
    // `TestInstanceBlockEntity.Data.STREAM_CODEC`: the test, size, rotation
    // (ordinal), ignore-entities flag, status (index) and error message.
    // rust: TestInstanceData {
    // rust: test: Option<String> => Opt<Ident>,
    // rust: size: [i32; 3] => VarVec3i,
    // rust: rotation: i32 => VarInt,
    // rust: ignore_entities: bool => Bool,
    // rust: status: i32 => VarInt,
    // rust: error_message: Option<Tag> => Opt<Nbt>
}
    // rust: );
    // rust: packet!(
    // ServerboundTestInstanceBlockActionPacket: `action` is the `Action` id
    // (INIT 0, QUERY 1, SET 2, RESET 3, SAVE 4, EXPORT 5, RUN 6).
    // rust: TestInstanceBlockAction { pos: [i32; 3] => Pos, action: i32 => VarInt, data: TestInstanceData => TestInstanceData }
    // rust: );
    // rust: packet!(
    // ClientboundGameTestHighlightPosPacket: the absolute position and the
    // position relative to the test's origin.
    // rust: GameTestHighlightPos { absolute: [i32; 3] => Pos, relative: [i32; 3] => Pos }
    // rust: );
    // rust: packet!(
    // ClientboundTestInstanceBlockStatus: the test's description and, for a
    // query, the size of its structure.
    // rust: TestInstanceBlockStatus { status: Tag => Nbt, size: Option<[i32; 3]> => Opt<VarVec3i> }
    // rust: );
    // rust: packet!(
    // ServerboundJigsawGeneratePacket: the jigsaw block's Generate button.
    // rust: JigsawGenerate { pos: [i32; 3] => Pos, levels: i32 => VarInt, keep_jigsaws: bool => Bool }
    // rust: );
    // rust: packet!(
    // ServerboundSetCommandBlockPacket: the command block's command, its
    // mode (`CommandBlockEntity.Mode` ordinal) and the track output (1),
    // conditional (2) and automatic (4) flags.
    // rust: SetCommandBlock { pos: [i32; 3] => Pos, command: String => Str, mode: i32 => VarInt, flags: i8 => Byte }
    // rust: );
    // rust: packet!(
    // ServerboundSetCommandMinecartPacket: the command minecart's entity id,
    // its command and whether it tracks output.
    // rust: SetCommandMinecart { entity: i32 => VarInt, command: String => Str, track_output: bool => Bool }
    // rust: );
// ServerboundSetStructureBlockPacket: the structure block's edit screen.
// `update_type` and `mode` are `StructureBlockEntity.UpdateType` and
// `StructureMode` ordinals, `mirror` and `rotation` the enums' ordinals.
SetStructureBlock :: struct {
    pos: [i32,
    update_type: i32,
    mode: i32,
    name: string,
    offset: [i32,
    size: [i32,
    mirror: i32,
    rotation: i32,
    data: string,
    ignore_entities: bool,
    strict: bool,
    show_air: bool,
    show_bounding_box: bool,
    integrity: f32,
    seed: i64,
}
    // rust: impl SetStructureBlock {
FLAG_IGNORE_ENTITIES :: 1
FLAG_SHOW_AIR :: 2
FLAG_SHOW_BOUNDING_BOX :: 4
FLAG_STRICT :: 8
}
    // rust: impl Codec<SetStructureBlock> for SetStructureBlock {
    // `ServerboundSetStructureBlockPacket(FriendlyByteBuf)`: the offsets,
    // sizes and integrity are clamped as they are read.
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let pos = Pos::read(r)?;
    // rust: let update_type = r.varint()?;
    // rust: let mode = r.varint()?;
    // rust: let name = r.string(32767)?;
    // rust: let mut offset = [0; 3];
    // rust: for v in &mut offset {
    // rust: *v = i32::from(r.i8()?).clamp(-48, 48);
}
    // rust: let mut size = [0; 3];
    // rust: for v in &mut size {
    // rust: *v = i32::from(r.i8()?).clamp(0, 48);
}
    // rust: let mirror = r.varint()?;
    // rust: let rotation = r.varint()?;
    // rust: let data = r.string(128)?;
    // rust: let integrity = r.f32()?.clamp(0.0, 1.0);
    // rust: let seed = r.varlong()?;
    // rust: let flags = r.i8()?;
    // rust: Ok(Self {
    // rust: pos,
    // rust: update_type,
    // rust: mode,
    // rust: name,
    // rust: offset,
    // rust: size,
    // rust: mirror,
    // rust: rotation,
    // rust: data,
    // rust: ignore_entities: flags & Self::FLAG_IGNORE_ENTITIES != 0,
    // rust: strict: flags & Self::FLAG_STRICT != 0,
    // rust: show_air: flags & Self::FLAG_SHOW_AIR != 0,
    // rust: show_bounding_box: flags & Self::FLAG_SHOW_BOUNDING_BOX != 0,
    // rust: integrity,
    // rust: seed,
    // rust: })
}
write :: proc(v: ^Self, w: ^Writer) {
}
    // rust: Pos::write(&v.pos, w);
    // rust: w.varint(v.update_type);
    // rust: w.varint(v.mode);
    // rust: w.string(&v.name);
    // rust: for o in v.offset {
    // rust: w.i8(o as i8);
}
    // rust: for s in v.size {
    // rust: w.i8(s as i8);
}
    // rust: w.varint(v.mirror);
    // rust: w.varint(v.rotation);
    // rust: w.string(&v.data);
    // rust: w.f32(v.integrity);
    // rust: w.varlong(v.seed);
    // rust: let mut flags = 0;
    // rust: if v.ignore_entities {
    // rust: flags |= Self::FLAG_IGNORE_ENTITIES;
}
    // rust: if v.show_air {
    // rust: flags |= Self::FLAG_SHOW_AIR;
}
    // rust: if v.show_bounding_box {
    // rust: flags |= Self::FLAG_SHOW_BOUNDING_BOX;
}
    // rust: if v.strict {
    // rust: flags |= Self::FLAG_STRICT;
}
    // rust: w.i8(flags);
}
}
    // rust: packet!(
    // ServerboundEditBookPacket: the book's slot (a hotbar slot, or 40 for
    // the off hand), its pages and, to sign it, its title.
    // rust: EditBook {
    // rust: slot: i32 => VarInt,
    // rust: pages: Vec<String> => BookPages,
    // rust: title: Option<String> => Opt<StrN<32>>,
}
    // rust: );
// `stringUtf8(1024)` in `list(100)`: a book's pages.
BookPages :: struct {
    // rust: impl Codec<Vec<String>> for BookPages {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = r.varint()?;
    // rust: if !(0..=100).contains(&n) {
    // rust: return Err(Error::new(format!("{n} book pages, at most 100")));
}
    // rust: (0..n).map(|_| r.string(1024)).collect()
}
write :: proc(v: ^[dynamic]string, w: ^Writer) {
}
    // rust: List::<StrN<1024>>::write(v, w);
}
}
// SignTextSlot.STREAM_CODEC: VarInt 0 for the back, 1 for the front (any
// other id reads as the back, ByIdMap's ZERO strategy).
SignSide :: struct {
    // rust: impl Codec<bool> for SignSide {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(r.varint()? == 1)
}
write :: proc(v: ^bool, w: ^Writer) {
}
    // rust: w.varint(i32::from(*v));
}
}
// `stringUtf8(384)` in `fixedSizeList(4)`: four lines, no count.
SignLines :: struct {
    // rust: impl Codec<[String; 4]> for SignLines {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok([
    // rust: r.string(384)?,
    // rust: r.string(384)?,
    // rust: r.string(384)?,
    // rust: r.string(384)?,
    // rust: ])
}
write :: proc(v: ^[string; 4], w: ^Writer) {
}
    // rust: for line in v {
    // rust: w.string(line);
}
}
}
    // rust: packet!(
    // ServerboundSetBeaconPacket: `BeaconMenu.updateEffects`, each power an
    // optional `mob_effect` id.
    // rust: SetBeacon { primary: Option<i32> => Opt<VarInt>, secondary: Option<i32> => Opt<VarInt> }
    // rust: );
    // rust: packet!(Interact { id: i32 => VarInt, hand: i32 => VarInt, location: [f64; 3] => LpVec3, secondary: bool => Bool });
    // rust: packet!(
    // ServerboundMovePlayerPacket flags: 1 on ground, 2 horizontal collision.
    // rust: MovePlayerPos { x: f64 => Double, y: f64 => Double, z: f64 => Double, flags: u8 => UByte }
    // rust: );
    // rust: packet!(MovePlayerPosRot { x: f64 => Double, y: f64 => Double, z: f64 => Double, yaw: f32 => Float, pitch: f32 => Float, flags: u8 => UByte });
    // rust: packet!(MovePlayerRot { yaw: f32 => Float, pitch: f32 => Float, flags: u8 => UByte });
    // rust: packet!(MovePlayerStatus { flags: u8 => UByte });
    // rust: packet!(
    // ServerboundMoveVehiclePacket: where the rider moved the vehicle it
    // controls (PositionAndRotation, then onGround).
    // rust: MoveVehicleRequest { position: [f64; 3] => Vec3d, yaw: f32 => Float, pitch: f32 => Float, on_ground: bool => Bool }
    // rust: );
    // rust: packet!(
    // ServerboundPaddleBoatPacket: the boat's left and right paddles.
    // rust: PaddleBoat { left: bool => Bool, right: bool => Bool }
    // rust: );
    // rust: packet!(PickItemFromBlock { pos: [i32; 3] => Pos, include_data: bool => Bool });
    // rust: packet!(PickItemFromEntity { id: i32 => VarInt, include_data: bool => Bool });
    // rust: packet!(
    // ServerboundPlayerActionPacket.Action: 0 start destroy, 1 change destroy
    // direction, 2 abort, 3 stop destroy, 4 drop all, 5 drop item, 6 release
    // use item, 7 swap offhand, 8 stab. Direction is the 3D data value.
    // rust: PlayerAction { action: i32 => VarInt, pos: [i32; 3] => Pos, direction: u8 => UByte, sequence: i32 => VarInt }
    // rust: );
    // rust: packet!(
    // ServerboundPlayerCommandPacket.Action: 0 stop sleeping, 1 start sprinting,
    // 2 stop sprinting, 3/4 riding jump, 5 open inventory, 6 start fall flying.
    // rust: PlayerCommand { id: i32 => VarInt, action: i32 => VarInt, data: i32 => VarInt }
    // rust: );
    // rust: packet!(
    // Input flags: forward 1, backward 2, left 4, right 8, jump 16, shift 32, sprint 64.
    // rust: PlayerInput { flags: u8 => UByte }
    // rust: );
    // rust: packet!(
    // ServerboundSelectBundleItemPacket: the menu slot of a bundle and the
    // index of its selected item (-1: none).
    // rust: SelectBundleItem { slot: i32 => VarInt, index: i32 => VarInt }
    // rust: );
    // rust: packet!(SetCarriedItem { slot: i16 => Short });
    // rust: packet!(SetCreativeModeSlot { slot: i16 => Short, item: Option<Stack> => DelimitedSlot });
    // rust: packet!(UseItem { hand: i32 => VarInt, sequence: i32 => VarInt, yaw: f32 => Float, pitch: f32 => Float });
    // rust: packet!(UseItemOn {
    // rust: hand: i32 => VarInt,
    // rust: pos: [i32; 3] => Pos,
    // rust: face: i32 => VarInt,
    // rust: cursor: [f32; 3] => Cursor,
    // rust: inside: bool => Bool,
    // rust: world_border: bool => Bool,
    // rust: sequence: i32 => VarInt,
    // rust: });
// The click location relative to the block (three floats).
Cursor :: struct {
    // rust: impl Codec<[f32; 3]> for Cursor {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok([r.f32()?, r.f32()?, r.f32()?])
}
write :: proc(v: ^[f32; 3], w: ^Writer) {
}
    // rust: v.iter().for_each(|f| w.f32(*f));
}
}

    // rust: packet_enum!(Serverbound, crate::ids::play::serverbound {
    // rust: ChangeDifficulty(ChangeDifficultyRequest) = CHANGE_DIFFICULTY,
    // rust: LockDifficulty(LockDifficulty) = LOCK_DIFFICULTY,
    // rust: SetGameRule(SetGameRule) = SET_GAME_RULE,
    // rust: AcceptTeleportation(AcceptTeleportation) = ACCEPT_TELEPORTATION,
    // rust: Attack(Attack) = ATTACK,
    // rust: BlockEntityTagQuery(BlockEntityTagQuery) = BLOCK_ENTITY_TAG_QUERY,
    // rust: EntityTagQuery(EntityTagQuery) = ENTITY_TAG_QUERY,
    // rust: TeleportToEntity(TeleportToEntity) = TELEPORT_TO_ENTITY,
    // rust: SpectatorAction(SpectatorAction) = SPECTATOR_ACTION,
    // rust: ChangeGameMode(ChangeGameMode) = CHANGE_GAME_MODE,
    // rust: Chat(Chat) = CHAT,
    // rust: ChatAck(ChatAck) = CHAT_ACK,
    // rust: ChatCommand(ChatCommand) = CHAT_COMMAND,
    // rust: ChatCommandSigned(ChatCommandSigned) = CHAT_COMMAND_SIGNED,
    // rust: ChatSessionUpdate(ChatSessionUpdate) = CHAT_SESSION_UPDATE,
    // rust: PlaceRecipe(super::recipes::PlaceRecipe) = PLACE_RECIPE,
    // rust: RecipeBookChangeSettings(super::recipes::RecipeBookChangeSettings) = RECIPE_BOOK_CHANGE_SETTINGS,
    // rust: RecipeBookSeenRecipe(super::recipes::RecipeBookSeenRecipe) = RECIPE_BOOK_SEEN_RECIPE,
    // rust: ChunkBatchReceived(ChunkBatchReceived) = CHUNK_BATCH_RECEIVED,
    // rust: ClientCommand(ClientCommand) = CLIENT_COMMAND,
    // rust: ClientInformation(ClientInformation) = CLIENT_INFORMATION,
    // rust: ClientTickEnd(Empty) = CLIENT_TICK_END,
    // rust: ConfigurationAcknowledged(Empty) = CONFIGURATION_ACKNOWLEDGED,
    // rust: ContainerButtonClick(ContainerButtonClick) = CONTAINER_BUTTON_CLICK,
    // rust: ContainerClick(ContainerClick) = CONTAINER_CLICK,
    // rust: ContainerClose(ContainerClose) = CONTAINER_CLOSE,
    // rust: CookieResponse(CookieResponse) = COOKIE_RESPONSE,
    // rust: CustomPayload(CustomPayload) = CUSTOM_PAYLOAD,
    // rust: CustomClickAction(CustomClickAction) = CUSTOM_CLICK_ACTION,
    // rust: EditBook(EditBook) = EDIT_BOOK,
    // rust: Interact(Interact) = INTERACT,
    // rust: KeepAlive(KeepAlive) = KEEP_ALIVE,
    // rust: MovePlayerPos(MovePlayerPos) = MOVE_PLAYER_POS,
    // rust: MovePlayerPosRot(MovePlayerPosRot) = MOVE_PLAYER_POS_ROT,
    // rust: MovePlayerRot(MovePlayerRot) = MOVE_PLAYER_ROT,
    // rust: MovePlayerStatus(MovePlayerStatus) = MOVE_PLAYER_STATUS_ONLY,
    // rust: MoveVehicle(MoveVehicleRequest) = MOVE_VEHICLE,
    // rust: PaddleBoat(PaddleBoat) = PADDLE_BOAT,
    // rust: PickItemFromBlock(PickItemFromBlock) = PICK_ITEM_FROM_BLOCK,
    // rust: PickItemFromEntity(PickItemFromEntity) = PICK_ITEM_FROM_ENTITY,
    // rust: PingRequest(crate::packets::status::Ping) = PING_REQUEST,
    // rust: PlayerAbilities(PlayerAbilitiesRequest) = PLAYER_ABILITIES,
    // rust: PlayerAction(PlayerAction) = PLAYER_ACTION,
    // rust: PlayerCommand(PlayerCommand) = PLAYER_COMMAND,
    // rust: PlayerInput(PlayerInput) = PLAYER_INPUT,
    // rust: PlayerLoaded(Empty) = PLAYER_LOADED,
    // rust: Pong(Ping) = PONG,
    // rust: RenameItem(RenameItem) = RENAME_ITEM,
    // rust: SeenAdvancements(SeenAdvancements) = SEEN_ADVANCEMENTS,
    // rust: ContainerSlotStateChanged(ContainerSlotStateChanged) = CONTAINER_SLOT_STATE_CHANGED,
    // rust: Punch(Empty) = PUNCH,
    // rust: JigsawGenerate(JigsawGenerate) = JIGSAW_GENERATE,
    // rust: ResourcePack(ResourcePackResponse) = RESOURCE_PACK,
    // rust: SelectBundleItem(SelectBundleItem) = BUNDLE_ITEM_SELECTED,
    // rust: SelectTrade(SelectTrade) = SELECT_TRADE,
    // rust: SetBeacon(SetBeacon) = SET_BEACON,
    // rust: SetCarriedItem(SetCarriedItem) = SET_CARRIED_ITEM,
    // rust: SetCommandBlock(SetCommandBlock) = SET_COMMAND_BLOCK,
    // rust: SetCommandMinecart(SetCommandMinecart) = SET_COMMAND_MINECART,
    // rust: SetCreativeModeSlot(SetCreativeModeSlot) = SET_CREATIVE_MODE_SLOT,
    // rust: SetJigsawBlock(SetJigsawBlock) = SET_JIGSAW_BLOCK,
    // rust: SetTestBlock(SetTestBlock) = SET_TEST_BLOCK,
    // rust: TestInstanceBlockAction(TestInstanceBlockAction) = TEST_INSTANCE_BLOCK_ACTION,
    // rust: SetStructureBlock(SetStructureBlock) = SET_STRUCTURE_BLOCK,
    // rust: SignUpdate(SignUpdate) = SIGN_UPDATE,
    // rust: UseItem(UseItem) = USE_ITEM,
    // rust: UseItemOn(UseItemOn) = USE_ITEM_ON,
    // rust: });

    // rust: mod tests {
//     use super::*;
//     use crate::{
    // rust: chunk::BlockEntityInfo,
    // rust: packets::{recipes::RecipeBookSeenRecipe, round_trip},
    // rust: text::literal,
}

a_command_tree_with_a_cycle_is_refused :: proc() {
}
    // rust: let node = |kind: u8, name: &str, children: Vec<i32>, redirect: Option<i32>| CommandNode {
    // rust: kind,
    // rust: executable: false,
    // rust: restricted: false,
    // rust: children,
    // rust: redirect,
    // rust: name: name.into(),
    // rust: parser: None,
    // rust: suggestions: None,
}
    // rust: let read = |nodes: Vec<CommandNode>| {
    // rust: let mut w = Writer::new();
    // rust: Commands::write(&Commands { nodes, root: 0 }, &mut w);
    // rust: Commands::read(&mut Reader::new(&w.data))
}
        // `execute` with `run` redirecting back to the root, as vanilla's tree has it.
    // rust: let execute = vec![
    // rust: node(0, "", vec![1], None),
    // rust: node(1, "execute", vec![2], None),
    // rust: node(1, "run", vec![], Some(0)),
    // rust: ];
    // rust: assert!(read(execute).is_ok());
        // root -> a -> b -> a
    // rust: let children = vec![
    // rust: node(0, "", vec![1], None),
    // rust: node(1, "a", vec![2], None),
    // rust: node(1, "b", vec![1], None),
    // rust: ];
    // rust: assert!(read(children).is_err());
    // rust: assert!(read(vec![node(0, "", vec![0], None)]).is_err());
        // a redirects to b, b to a
    // rust: let redirects = vec![
    // rust: node(0, "", vec![1, 2], None),
    // rust: node(1, "a", vec![], Some(2)),
    // rust: node(1, "b", vec![], Some(1)),
    // rust: ];
    // rust: assert!(read(redirects).is_err());
        // A long chain is fine and checked without recursing.
    // rust: let mut chain: Vec<_> = (1..=100_000).map(|i| node(1, "x", vec![i], None)).collect();
    // rust: chain[0].kind = 0;
    // rust: chain.push(node(1, "x", vec![], None));
    // rust: assert!(read(chain.clone()).is_ok());
    // rust: chain.last_mut().unwrap().children.push(50_000);
    // rust: assert!(read(chain).is_err());
}

vec_delta_quantizes_the_base_like_math_round :: proc() {
}
        // Math.round(-2.5) is -2, so a delta of 1 lands on -1/4096, not -2/4096.
    // rust: let out = VecDelta::apply([-2.5 / 4096.0, 0.0, 0.0], [1, 0, 0]);
    // rust: assert_eq!(out[0], -1.0 / 4096.0);
}

merchant_cost_predicate_is_a_typed_list_without_patch_counts :: proc() {
}
        // ItemCost.STREAM_CODEC: item=7, count=1, one typed component,
        // potion_contents=53, potion present (water=0), no color/effects/name.
        // Result: count=1, item=8, empty component patch. Secondary cost:
        // item=9, count=2, empty predicate, followed by the offer fields.
    // rust: let mut bytes = vec![1, 7, 1, 1, 53, 1, 0, 0, 0, 0, 1, 8, 0, 0, 1, 9, 2, 0, 0];
    // rust: bytes.extend_from_slice(&[0; 4]); // uses
    // rust: bytes.extend_from_slice(&2i32.to_be_bytes()); // max uses
    // rust: bytes.extend_from_slice(&[0; 16]); // xp, special price, multiplier, demand
    // rust: let mut r = Reader::new(&bytes);
    // rust: let offers = Offers::read(&mut r).unwrap();
    // rust: assert_eq!(r.remaining(), 0);
    // rust: assert_eq!(
    // rust: offers[0].cost_a.components,
    // rust: vec![(
    // rust: 53,
    // rust: Component::Potion {
    // rust: potion: Some(0),
    // rust: color: None,
    // rust: rest: Vec::new()
}
    // rust: )]
    // rust: );
    // rust: assert!(offers[0].cost_b.as_ref().unwrap().components.is_empty());
    // rust: let mut w = Writer::new();
    // rust: Offers::write(&offers, &mut w);
    // rust: assert_eq!(w.data, bytes);
    // rust: for len in 0..bytes.len() {
    // rust: assert!(Offers::read(&mut Reader::new(&bytes[..len])).is_err());
}
}

custom_chat_completions_are_an_action_and_a_string_list :: proc() {
}
        // ClientboundCustomChatCompletionsPacket.STREAM_CODEC: Action.STREAM_CODEC
        // (ByteBufCodecs.idMapper, a VarInt), then STRING_UTF8 in a list.
    // rust: let payload = b"Steve#tag";
    // rust: let packet = Clientbound::CustomChatCompletions(CustomChatCompletions {
    // rust: action: custom_chat_action::SET,
    // rust: entries: vec!["Steve".into(), "#tag".into()],
    // rust: });
    // rust: assert_eq!(
    // rust: Clientbound::decode(
    // rust: crate::ids::play::clientbound::CUSTOM_CHAT_COMPLETIONS,
    // rust: payload
    // rust: )
    // rust: .unwrap(),
    // rust: packet
    // rust: );
    // rust: assert_eq!(&packet.encode()[1..], payload);
    // rust: round_trip(packet, Clientbound::encode, Clientbound::decode);
    // rust: assert!(
    // rust: Clientbound::decode(
    // rust: crate::ids::play::clientbound::CUSTOM_CHAT_COMPLETIONS,
    // rust: &payload[..payload.len() - 1]
    // rust: )
    // rust: .is_err()
    // rust: );
}

serverbound_abilities_carry_only_flying :: proc() {
}
        // ServerboundPlayerAbilitiesPacket.write: one byte, 2 when flying.
    // rust: let flying = Serverbound::PlayerAbilities(PlayerAbilitiesRequest { flags: 2 });
    // rust: assert_eq!(
    // rust: flying.encode(),
    // rust: [crate::ids::play::serverbound::PLAYER_ABILITIES as u8, 2]
    // rust: );
    // rust: round_trip(flying, Serverbound::encode, Serverbound::decode);
}

world_options_packets_match_vanilla_stream_codecs :: proc() {
}
        // mcsrc.dev 26.3: difficulty is a VarInt, locking is a Boolean,
        // rule entries are ResourceKey identifiers followed by UTF-8 values.
    // rust: let difficulty = Serverbound::ChangeDifficulty(ChangeDifficultyRequest { difficulty: 3 });
    // rust: assert_eq!(&difficulty.encode()[1..], &[3]);
    // rust: round_trip(difficulty, Serverbound::encode, Serverbound::decode);
    // rust: let lock = Serverbound::LockDifficulty(LockDifficulty { locked: true });
    // rust: assert_eq!(&lock.encode()[1..], &[1]);
    // rust: round_trip(lock, Serverbound::encode, Serverbound::decode);
    // rust: let payload = b"\x01\x18minecraft:keep_inventory\x04true";
    // rust: let entry = GameRuleEntry {
    // rust: name: "minecraft:keep_inventory".into(),
    // rust: value: "true".into(),
}
    // rust: let set = Serverbound::SetGameRule(SetGameRule {
    // rust: entries: vec![entry.clone()],
    // rust: });
    // rust: assert_eq!(&set.encode()[1..], payload);
    // rust: assert_eq!(
    // rust: Serverbound::decode(crate::ids::play::serverbound::SET_GAME_RULE, payload).unwrap(),
    // rust: set
    // rust: );
    // rust: let values = Clientbound::GameRuleValues(GameRuleValues {
    // rust: entries: vec![entry],
    // rust: });
    // rust: assert_eq!(&values.encode()[1..], payload);
    // rust: assert_eq!(
    // rust: Clientbound::decode(crate::ids::play::clientbound::GAME_RULE_VALUES, payload).unwrap(),
    // rust: values
    // rust: );
    // rust: assert!(
    // rust: Serverbound::decode(
    // rust: crate::ids::play::serverbound::SET_GAME_RULE,
    // rust: &payload[..payload.len() - 1]
    // rust: )
    // rust: .is_err()
    // rust: );
}

    // ServerboundRecipeBookSeenRecipePacket is one `RecipeDisplayId`, a
    // VarInt: display 300 is the two bytes `AC 02`, and a byte list that
    // stops early is not a display id.
a_seen_recipe_is_one_varint_display_id :: proc() {
}
    // rust: let payload = [0xAC, 0x02];
    // rust: let seen = Serverbound::RecipeBookSeenRecipe(RecipeBookSeenRecipe { recipe: 300 });
    // rust: assert_eq!(
    // rust: Serverbound::decode(
    // rust: crate::ids::play::serverbound::RECIPE_BOOK_SEEN_RECIPE,
    // rust: &payload
    // rust: )
    // rust: .unwrap(),
    // rust: seen
    // rust: );
    // rust: assert_eq!(&seen.encode()[1..], payload);
    // rust: assert!(
    // rust: Serverbound::decode(
    // rust: crate::ids::play::serverbound::RECIPE_BOOK_SEEN_RECIPE,
    // rust: &payload[..1]
    // rust: )
    // rust: .is_err()
    // rust: );
}

    // ServerboundSeenAdvancementsPacket: the action, then the tab only when the player opened
    // one — a closed screen is the action on its own.
a_seen_advancements_packet_carries_its_tab_only_when_one_was_opened :: proc() {
}
    // rust: let opened = SeenAdvancements {
    // rust: action: 0,
    // rust: tab: Some("minecraft:story/root".into()),
}
    // rust: let mut w = crate::buf::Writer::new();
    // rust: w.varint(0);
    // rust: w.string("minecraft:story/root");
    // rust: assert_eq!(
    // rust: Serverbound::decode(crate::ids::play::serverbound::SEEN_ADVANCEMENTS, &w.data).unwrap(),
    // rust: Serverbound::SeenAdvancements(opened.clone())
    // rust: );
    // rust: assert_eq!(
    // rust: &Serverbound::SeenAdvancements(opened).encode()[1..],
    // rust: &w.data[..]
    // rust: );
        // CLOSED_SCREEN: the action alone, with nothing after it.
    // rust: let closed = [0x01];
    // rust: assert_eq!(
    // rust: Serverbound::decode(crate::ids::play::serverbound::SEEN_ADVANCEMENTS, &closed).unwrap(),
    // rust: Serverbound::SeenAdvancements(SeenAdvancements {
    // rust: action: 1,
    // rust: tab: None,
    // rust: })
    // rust: );
        // Both packets are typed now, so neither reads as an unknown opcode, and a packet too
        // short for its tab is malformed rather than a tab-less open.
    // rust: assert!(!matches!(
    // rust: Serverbound::decode(crate::ids::play::serverbound::SEEN_ADVANCEMENTS, &closed).unwrap(),
    // rust: Serverbound::Unknown(..)
    // rust: ));
    // rust: assert!(
    // rust: Serverbound::decode(crate::ids::play::serverbound::SEEN_ADVANCEMENTS, &[0x00]).is_err()
    // rust: );
    // rust: let tab = Clientbound::SelectAdvancementsTab(SelectAdvancementsTab {
    // rust: tab: Some("minecraft:story/root".into()),
    // rust: });
    // rust: assert_eq!(
    // rust: Clientbound::decode(
    // rust: crate::ids::play::clientbound::SELECT_ADVANCEMENTS_TAB,
    // rust: &tab.encode()[1..]
    // rust: )
    // rust: .unwrap(),
    // rust: tab
    // rust: );
    // rust: let none = Clientbound::SelectAdvancementsTab(SelectAdvancementsTab { tab: None });
    // rust: assert_eq!(
    // rust: &none.encode()[1..],
    // rust: &[0x00],
    // rust: "no tab is the absence flag alone"
    // rust: );
}

spawn :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: SpawnInfo {
    // rust: dimension_type: 0,
    // rust: dimension: "minecraft:overworld".into(),
    // rust: seed: -123,
    // rust: game_type: 0,
    // rust: previous_game_type: None,
    // rust: debug: false,
    // rust: flat: false,
    // rust: last_death: Some(GlobalPos {
    // rust: dimension: "minecraft:the_nether".into(),
    // rust: pos: [1, 2, 3],
    // rust: }),
    // rust: portal_cooldown: 0,
    // rust: sea_level: 63,
}
}

tracked_waypoint_bytes :: proc() {
}
        // TRACK, a UUID, the default style, red (#FF5555), a block position.
    // rust: let track = Clientbound::TrackedWaypoint(TrackedWaypoint {
    // rust: operation: waypoint_operation::TRACK,
    // rust: id: WaypointId::Uuid(0x0102_0304_0506_0708_090a_0b0c_0d0e_0f10),
    // rust: style: "minecraft:default".into(),
    // rust: color: Some(0xFFFF_5555_u32 as i32),
    // rust: target: WaypointTarget::Block([1, -2, 300]),
    // rust: });
    // rust: let mut expected = vec![141, 1, 0, 1];
    // rust: expected.extend(1..=16u8);
    // rust: expected.push(17);
    // rust: expected.extend(b"minecraft:default");
    // rust: expected.extend([
    // rust: 1, 0xFF, 0x55, 0x55, 1, 1, 0xFE, 0xFF, 0xFF, 0xFF, 0x0F, 0xAC, 0x02,
    // rust: ]);
    // rust: assert_eq!(track.encode(), expected);
    // rust: assert_eq!(Clientbound::decode(141, &expected[2..]).unwrap(), track);
    // rust: for target in [
    // rust: WaypointTarget::Empty,
    // rust: WaypointTarget::Chunk([-3, 4]),
    // rust: WaypointTarget::Azimuth(-1.25),
    // rust: ] {
    // rust: let packet = Clientbound::TrackedWaypoint(TrackedWaypoint {
    // rust: operation: waypoint_operation::UPDATE,
    // rust: id: WaypointId::Name("spawn".into()),
    // rust: style: "minecraft:bowtie".into(),
    // rust: color: None,
    // rust: target,
    // rust: });
    // rust: let bytes = packet.encode();
    // rust: assert_eq!(Clientbound::decode(141, &bytes[2..]).unwrap(), packet);
}
}

clientbound_round_trips :: proc() {
}
    // rust: let packets = vec![
    // rust: Clientbound::BundleDelimiter(Empty),
    // rust: Clientbound::LowDiskSpaceWarning(Empty),
    // rust: Clientbound::PongResponse(crate::packets::status::Ping { time: 1_234_567 }),
    // rust: Clientbound::SetBorderCenter(SetBorderCenter { x: 1.5, z: -2.0 }),
    // rust: Clientbound::SetBorderLerpSize(SetBorderLerpSize {
    // rust: old_size: 10.0,
    // rust: new_size: 200.0,
    // rust: lerp_time: 1200,
    // rust: }),
    // rust: Clientbound::SetBorderSize(SetBorderSize { size: 30.0 }),
    // rust: Clientbound::SetBorderWarningDelay(SetBorderWarningDelay { delay: 300 }),
    // rust: Clientbound::SetBorderWarningDistance(SetBorderWarningDistance { blocks: 5 }),
    // rust: Clientbound::SetDisplayObjective(SetDisplayObjective {
    // rust: slot: 0,
    // rust: objective: "kills".into(),
    // rust: }),
    // rust: Clientbound::ResetScore(ResetScore {
    // rust: owner: "Steve".into(),
    // rust: objective: Some("kills".into()),
    // rust: }),
    // rust: Clientbound::SetScore(SetScore {
    // rust: owner: "Steve".into(),
    // rust: objective: "kills".into(),
    // rust: score: -3,
    // rust: display: Some(Tag::String("S".into())),
    // rust: number_format: Some(NumberFormat::Styled(Tag::compound([(
    // rust: "color",
    // rust: Tag::String("red".into()),
    // rust: )]))),
    // rust: }),
    // rust: Clientbound::SetObjective(SetObjective {
    // rust: name: "kills".into(),
    // rust: method: 0,
    // rust: display: Some((Tag::String("Kills".into()), 1, Some(NumberFormat::Blank))),
    // rust: }),
    // rust: Clientbound::SetObjective(SetObjective {
    // rust: name: "kills".into(),
    // rust: method: 1,
    // rust: display: None,
    // rust: }),
    // rust: Clientbound::SetPlayerTeam(SetPlayerTeam {
    // rust: name: "red".into(),
    // rust: method: 0,
    // rust: parameters: Some(TeamParameters {
    // rust: display_name: Tag::String("Red".into()),
    // rust: prefix: Tag::String("[R] ".into()),
    // rust: suffix: Tag::String("".into()),
    // rust: name_tag_visibility: 0,
    // rust: collision_rule: 0,
    // rust: color: Some(12),
    // rust: options: 3,
    // rust: }),
    // rust: players: vec!["Steve".into(), "Alex".into()],
    // rust: }),
    // rust: Clientbound::SetPlayerTeam(SetPlayerTeam {
    // rust: name: "red".into(),
    // rust: method: 4,
    // rust: parameters: None,
    // rust: players: vec!["Alex".into()],
    // rust: }),
    // rust: Clientbound::AddEntity(AddEntity {
    // rust: id: 5,
    // rust: uuid: 9,
    // rust: kind: 100,
    // rust: position: [1.5, 64.0, -3.25],
    // rust: velocity: [0.0; 3],
    // rust: pitch: 0,
    // rust: yaw: 64,
    // rust: head_yaw: 64,
    // rust: data: 0,
    // rust: }),
    // rust: Clientbound::BlockUpdate(BlockUpdate {
    // rust: pos: [-5, -60, 7],
    // rust: state: 1,
    // rust: }),
    // rust: Clientbound::AddTransientBlock(AddTransientBlock {
    // rust: pos: [-5, -60, 7],
    // rust: state: 1,
    // rust: }),
    // rust: Clientbound::ContainerSetContent(ContainerSetContent {
    // rust: container: 0,
    // rust: state: 3,
    // rust: items: vec![None, Some(Stack::new(1, 64))],
    // rust: carried: None,
    // rust: }),
    // rust: Clientbound::ContainerSetSlot(ContainerSetSlot {
    // rust: container: 0,
    // rust: state: 4,
    // rust: slot: 36,
    // rust: item: Some(Stack::new(2, 1)),
    // rust: }),
    // rust: Clientbound::Disconnect(Disconnect {
    // rust: reason: literal("kicked"),
    // rust: }),
    // rust: Clientbound::EntityPositionSync(EntityPositionSync {
    // rust: id: 1,
    // rust: path: PositionPath::Stepped(vec![([1.0, 2.0, 3.0], 0), ([1.5, 2.0, 3.0], 2)]),
    // rust: yaw: 1.0,
    // rust: pitch: 2.0,
    // rust: on_ground: true,
    // rust: }),
    // rust: Clientbound::ChunksBiomes(ChunksBiomes {
    // rust: chunks: vec![
    // rust: ChunkBiomeData {
    // rust: pos: [-3, 7],
    // rust: buffer: vec![0, 4, 1, 2],
    // rust: },
    // rust: ChunkBiomeData {
    // rust: pos: [i32::MAX, i32::MIN],
    // rust: buffer: Vec::new(),
    // rust: },
    // rust: ],
    // rust: }),
    // rust: Clientbound::ForgetLevelChunk(ForgetLevelChunk { pos: [-1, 2] }),
    // rust: Clientbound::GameEvent(GameEvent {
    // rust: event: 13,
    // rust: param: 0.0,
    // rust: }),
    // rust: Clientbound::LevelChunkWithLight(LevelChunkWithLight {
    // rust: x: 3,
    // rust: z: -4,
    // rust: chunk: ChunkData {
    // rust: heightmaps: vec![(4, vec![0; 37])],
    // rust: buffer: vec![0, 0, 0, 0, 0, 0, 0, 0],
    // rust: block_entities: vec![BlockEntityInfo {
    // rust: packed_xz: 1,
    // rust: y: 70,
    // rust: kind: 3,
    // rust: tag: Tag::End,
    // rust: }],
    // rust: },
    // rust: light: LightData {
    // rust: sky_mask: vec![1],
    // rust: block_mask: vec![],
    // rust: empty_sky_mask: vec![],
    // rust: empty_block_mask: vec![2],
    // rust: sky: vec![vec![0xFF; 2048]],
    // rust: block: vec![],
    // rust: },
    // rust: }),
    // rust: Clientbound::Login(Login {
    // rust: player_id: 42,
    // rust: hardcore: false,
    // rust: levels: vec!["minecraft:overworld".into(), "minecraft:the_nether".into()],
    // rust: max_players: 20,
    // rust: chunk_radius: 10,
    // rust: simulation_distance: 10,
    // rust: reduced_debug_info: false,
    // rust: show_death_screen: true,
    // rust: limited_crafting: false,
    // rust: spawn: spawn(),
    // rust: online_mode: false,
    // rust: enforces_secure_chat: false,
    // rust: }),
    // rust: Clientbound::MoveEntityPos(MoveEntityPos(MoveEntity {
    // rust: id: 3,
    // rust: delta: Some(VecDelta::Linear([4096, 0, -4096])),
    // rust: rotation: None,
    // rust: on_ground: true,
    // rust: })),
    // rust: Clientbound::MoveEntityPosRot(MoveEntityPosRot(MoveEntity {
    // rust: id: 3,
    // rust: delta: Some(VecDelta::Stepped(vec![([1, 2, 3], 1), ([0, 0, 1], 2)])),
    // rust: rotation: Some((10, -10)),
    // rust: on_ground: false,
    // rust: })),
    // rust: Clientbound::MoveEntityRot(MoveEntityRot(MoveEntity {
    // rust: id: 3,
    // rust: delta: None,
    // rust: rotation: Some((1, 2)),
    // rust: on_ground: true,
    // rust: })),
    // rust: Clientbound::OpenScreen(OpenScreen {
    // rust: container: 1,
    // rust: menu: 2,
    // rust: title: literal("Chest"),
    // rust: }),
    // rust: Clientbound::MountScreenOpen(MountScreenOpen {
    // rust: container: 4,
    // rust: columns: 5,
    // rust: entity: 300,
    // rust: }),
    // rust: Clientbound::MerchantOffers(MerchantOffers {
    // rust: container: 3,
    // rust: offers: vec![NetOffer {
    // rust: cost_a: Stack::new(5, 24).into(),
    // rust: result: Stack::new(7, 1),
    // rust: cost_b: Some(Stack::new(9, 1).into()),
    // rust: out_of_stock: false,
    // rust: uses: 2,
    // rust: max_uses: 16,
    // rust: xp: 2,
    // rust: special_price: -3,
    // rust: price_multiplier: 0.05,
    // rust: demand: 4,
    // rust: }],
    // rust: level: 2,
    // rust: xp: 12,
    // rust: show_progress: true,
    // rust: can_restock: true,
    // rust: }),
    // rust: Clientbound::DeleteChat(DeleteChat {
    // rust: signature: (4, None),
    // rust: }),
    // rust: Clientbound::DeleteChat(DeleteChat {
    // rust: signature: (-1, Some(vec![9; 256])),
    // rust: }),
    // rust: Clientbound::PlayerChat(PlayerChat {
    // rust: global_index: 0,
    // rust: sender: 5,
    // rust: index: 0,
    // rust: signature: None,
    // rust: content: "hello".into(),
    // rust: timestamp: 1,
    // rust: salt: 2,
    // rust: last_seen: vec![(3, None), (-1, Some(vec![7; 256]))],
    // rust: unsigned_content: None,
    // rust: filter: (0, vec![]),
    // rust: chat_type: ChatTypeBound {
    // rust: chat_type: 0,
    // rust: name: literal("Steve"),
    // rust: target: None,
    // rust: },
    // rust: }),
    // rust: Clientbound::PlayerInfoUpdate(PlayerInfoUpdate {
    // rust: actions: 0b0001_1101,
    // rust: entries: vec![PlayerInfo {
    // rust: uuid: 1,
    // rust: name: Some("Steve".into()),
    // rust: game_mode: Some(1),
    // rust: listed: Some(true),
    // rust: latency: Some(12),
    // rust: ..PlayerInfo::default()
    // rust: }],
    // rust: }),
    // rust: Clientbound::PlayerPosition(PlayerPosition {
    // rust: teleport: 1,
    // rust: position: [0.5, 70.0, 0.5],
    // rust: delta: [0.0; 3],
    // rust: yaw: 90.0,
    // rust: pitch: 0.0,
    // rust: relatives: relative::DELTA_X,
    // rust: }),
    // rust: Clientbound::Respawn(Respawn {
    // rust: spawn: spawn(),
    // rust: keep: 3,
    // rust: }),
    // rust: Clientbound::SectionBlocksUpdate(SectionBlocksUpdate {
    // rust: section: [1, -4, 2],
    // rust: changes: vec![(9 << 12) | 0x123],
    // rust: }),
    // rust: Clientbound::SetEntityData(SetEntityData {
    // rust: id: 2,
    // rust: values: vec![(8, 7, Value::Item(Some(Stack::new(5, 3))))],
    // rust: }),
    // rust: Clientbound::SetEntityMotion(SetEntityMotion {
    // rust: id: 2,
    // rust: velocity: [0.0; 3],
    // rust: }),
    // rust: Clientbound::SetPassengers(SetPassengers {
    // rust: vehicle: 2,
    // rust: passengers: vec![3, 300],
    // rust: }),
    // rust: Clientbound::SetEntityLink(SetEntityLink { source: 2, dest: 0 }),
    // rust: Clientbound::LevelParticles(LevelParticles {
    // rust: particle: Particle {
    // rust: id: 21,
    // rust: data: Some(crate::entity_data::ParticleData::ColorScale(0xFF0000, 1.5)),
    // rust: },
    // rust: override_limiter: true,
    // rust: always_show: false,
    // rust: pos: [0.5, 101.0, 3.0],
    // rust: dist: [0.2, 0.0, 0.2],
    // rust: max_speed: [0.0; 3],
    // rust: count: 60,
    // rust: randomization: 0,
    // rust: }),
    // rust: Clientbound::Explode(Explode {
    // rust: center: [1.0, 2.0, 3.0],
    // rust: radius: 4.0,
    // rust: block_count: 12,
    // rust: knockback: Some([0.5, 0.1, 0.0]),
    // rust: particle: Particle { id: 29, data: None },
    // rust: sound: (-1, Some(("minecraft:entity.generic.explode".into(), None))),
    // rust: block_particles: vec![ExplosionParticle {
    // rust: particle: Particle { id: 69, data: None },
    // rust: scaling: 0.5,
    // rust: speed: 1.0,
    // rust: weight: 1,
    // rust: }],
    // rust: play_sound: true,
    // rust: }),
    // rust: Clientbound::ProjectilePower(ProjectilePower { id: 4, power: 0.1 }),
    // rust: Clientbound::SetEquipment(SetEquipment {
    // rust: id: 2,
    // rust: slots: vec![(0, None), (5, Some(Stack::new(1, 1)))],
    // rust: }),
    // rust: Clientbound::UpdateAttributes(UpdateAttributes {
    // rust: id: 2,
    // rust: values: vec![AttributeSnapshot {
    // rust: attribute: 26,
    // rust: base: 0.23,
    // rust: modifiers: vec![AttributeModifier {
    // rust: id: "minecraft:baby".into(),
    // rust: amount: 0.5,
    // rust: operation: 1,
    // rust: }],
    // rust: }],
    // rust: }),
    // rust: Clientbound::DamageEvent(DamageEvent {
    // rust: id: 7,
    // rust: source_type: 31,
    // rust: cause: Some(0),
    // rust: direct: None,
    // rust: position: Some([1.5, -2.0, 3.25]),
    // rust: }),
    // rust: Clientbound::SetHealth(SetHealth {
    // rust: health: 17.5,
    // rust: food: 18,
    // rust: saturation: 3.0,
    // rust: }),
    // rust: Clientbound::SetTime(SetTime {
    // rust: game_time: 100,
    // rust: clocks: vec![ClockState {
    // rust: clock: 0,
    // rust: total_ticks: 6000,
    // rust: partial_tick: 0.0,
    // rust: rate: 1.0,
    // rust: }],
    // rust: }),
    // rust: Clientbound::Sound(Sound {
    // rust: sound: (12, None),
    // rust: source: 4,
    // rust: x: 8,
    // rust: y: 9,
    // rust: z: 10,
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: seed: 3,
    // rust: }),
    // rust: Clientbound::Sound(Sound {
    // rust: sound: (-1, Some(("minecraft:x".into(), Some(16.0)))),
    // rust: source: 0,
    // rust: x: 0,
    // rust: y: 0,
    // rust: z: 0,
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: seed: 0,
    // rust: }),
    // rust: Clientbound::SystemChat(SystemChat {
    // rust: content: literal("hi"),
    // rust: overlay: false,
    // rust: }),
    // rust: Clientbound::TeleportEntity(TeleportEntity {
    // rust: id: 1,
    // rust: position: [1.0; 3],
    // rust: delta: [0.0; 3],
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: relatives: 0,
    // rust: on_ground: true,
    // rust: }),
    // rust: Clientbound::TickingState(TickingState {
    // rust: rate: 40.0,
    // rust: frozen: true,
    // rust: }),
    // rust: Clientbound::TickingStep(TickingStep { steps: 7 }),
    // rust: Clientbound::AwardStats(AwardStats {
    // rust: stats: vec![(8, 3, 120), (0, 1, 2)],
    // rust: }),
    // rust: Clientbound::UpdateAdvancements(UpdateAdvancements {
    // rust: reset: true,
    // rust: added: vec![Advancement {
    // rust: id: "minecraft:story/root".into(),
    // rust: parent: None,
    // rust: display: Some(AdvancementDisplay {
    // rust: title: literal("Minecraft"),
    // rust: description: literal("The heart and story of the game"),
    // rust: icon: crate::item::Stack::new(42, 1),
    // rust: frame: 0,
    // rust: show_toast: false,
    // rust: hidden: false,
    // rust: background: Some("minecraft:block/stone".into()),
    // rust: }),
    // rust: requirements: vec![vec!["crafting_table".into()]],
    // rust: telemetry: false,
    // rust: x: 0.0,
    // rust: y: 1.5,
    // rust: }],
    // rust: removed: vec!["minecraft:story/gone".into()],
    // rust: progress: vec![(
    // rust: "minecraft:story/root".into(),
    // rust: vec![("crafting_table".into(), Some(1_792_216_800_000))],
    // rust: )],
    // rust: show: true,
    // rust: }),
    // rust: ];
    // rust: for p in packets {
    // rust: round_trip(p, Clientbound::encode, Clientbound::decode);
}
}

delete_chat_decodes_a_packed_signature :: proc() {
}
//         use crate::ids::play::clientbound::DELETE_CHAT;
        // MessageSignature.Packed: id + 1, so 5 names cache slot 4...
    // rust: assert_eq!(
    // rust: Clientbound::decode(DELETE_CHAT, &[5]).unwrap(),
    // rust: Clientbound::DeleteChat(DeleteChat {
    // rust: signature: (4, None)
    // rust: })
    // rust: );
        // ...and 0 carries the full 256-byte signature.
    // rust: let mut full = vec![0];
    // rust: full.extend([3; 256]);
    // rust: assert_eq!(
    // rust: Clientbound::decode(DELETE_CHAT, &full).unwrap(),
    // rust: Clientbound::DeleteChat(DeleteChat {
    // rust: signature: (-1, Some(vec![3; 256]))
    // rust: })
    // rust: );
}

serverbound_round_trips :: proc() {
}
    // rust: let packets = vec![
    // rust: Serverbound::PingRequest(crate::packets::status::Ping { time: -7 }),
    // rust: Serverbound::AcceptTeleportation(AcceptTeleportation {
    // rust: id: 1,
    // rust: x: 0.5,
    // rust: y: 64.0,
    // rust: z: 0.5,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: }),
    // rust: Serverbound::Chat(Chat {
    // rust: message: "hello".into(),
    // rust: timestamp: 1,
    // rust: salt: 0,
    // rust: signature: None,
    // rust: last_seen: LastSeenUpdate {
    // rust: offset: 0,
    // rust: acknowledged: [0; 3],
    // rust: checksum: 0,
    // rust: },
    // rust: }),
    // rust: Serverbound::ChatCommand(ChatCommand {
    // rust: command: "time set day".into(),
    // rust: }),
    // rust: Serverbound::ChatAck(ChatAck { offset: 3 }),
    // rust: Serverbound::ChatCommandSigned(ChatCommandSigned {
    // rust: command: "say hi".into(),
    // rust: timestamp: 1_700_000_000_000,
    // rust: salt: -5,
    // rust: arguments: vec![("message".into(), vec![9; 256])],
    // rust: last_seen: LastSeenUpdate {
    // rust: offset: 1,
    // rust: acknowledged: [1, 0, 8],
    // rust: checksum: -3,
    // rust: },
    // rust: }),
    // rust: Serverbound::ChatSessionUpdate(ChatSessionUpdate {
    // rust: session: 0x1234,
    // rust: expires_at: 1_800_000_000_000,
    // rust: key: vec![0x30; 294],
    // rust: key_signature: vec![7; 512],
    // rust: }),
    // rust: Serverbound::ChunkBatchReceived(ChunkBatchReceived {
    // rust: chunks_per_tick: 9.5,
    // rust: }),
    // rust: Serverbound::ClientCommand(ClientCommand { action: 0 }),
    // rust: Serverbound::ClientTickEnd(Empty),
    // rust: Serverbound::ContainerClick(ContainerClick {
    // rust: container: 0,
    // rust: state: 5,
    // rust: slot: 36,
    // rust: button: 0,
    // rust: input: 0,
    // rust: changed: vec![(36, None)],
    // rust: carried: Some(Hashed::of(&Stack::new(1, 64))),
    // rust: }),
    // rust: Serverbound::MovePlayerPosRot(MovePlayerPosRot {
    // rust: x: 1.0,
    // rust: y: 2.0,
    // rust: z: 3.0,
    // rust: yaw: 4.0,
    // rust: pitch: 5.0,
    // rust: flags: 1,
    // rust: }),
    // rust: Serverbound::MovePlayerStatus(MovePlayerStatus { flags: 3 }),
    // rust: Serverbound::PlayerAction(PlayerAction {
    // rust: action: 0,
    // rust: pos: [1, 2, 3],
    // rust: direction: 1,
    // rust: sequence: 7,
    // rust: }),
    // rust: Serverbound::PlayerInput(PlayerInput { flags: 0b0101_0001 }),
    // rust: Serverbound::PlayerLoaded(Empty),
    // rust: Serverbound::Punch(Empty),
    // rust: Serverbound::SetCarriedItem(SetCarriedItem { slot: 4 }),
    // rust: Serverbound::UseItemOn(UseItemOn {
    // rust: hand: 0,
    // rust: pos: [1, 64, 1],
    // rust: face: 1,
    // rust: cursor: [0.5, 1.0, 0.5],
    // rust: inside: false,
    // rust: world_border: false,
    // rust: sequence: 8,
    // rust: }),
    // rust: Serverbound::Interact(Interact {
    // rust: id: 9,
    // rust: hand: 0,
    // rust: location: [0.25, 1.0, 0.0],
    // rust: secondary: false,
    // rust: }),
    // rust: ];
    // rust: for p in packets {
    // rust: if let Serverbound::Interact(_) = &p {
                // LpVec3 is lossy; check bytes instead.
    // rust: let body = p.encode();
    // rust: let mut r = Reader::new(&body);
    // rust: let id = r.varint().unwrap();
    // rust: assert!(matches!(
    // rust: Serverbound::decode(id, r.rest()).unwrap(),
    // rust: Serverbound::Interact(Interact { id: 9, .. })
    // rust: ));
    // rust: continue;
}
    // rust: round_trip(p, Serverbound::encode, Serverbound::decode);
}
    // rust: round_trip(
    // rust: Serverbound::SelectTrade(SelectTrade { item: 3 }),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
        // CONTAINER_ID and the button, both VarInts.
    // rust: let button = Serverbound::ContainerButtonClick(ContainerButtonClick {
    // rust: container: 3,
    // rust: button: 200,
    // rust: });
    // rust: assert_eq!(&button.encode()[1..], &[3, 0xC8, 1]);
    // rust: round_trip(button, Serverbound::encode, Serverbound::decode);
        // The name, a UTF-8 string with its VarInt length.
    // rust: let rename = Serverbound::RenameItem(RenameItem {
    // rust: name: "Blade".into(),
    // rust: });
    // rust: assert_eq!(&rename.encode()[1..], &[5, b'B', b'l', b'a', b'd', b'e']);
    // rust: round_trip(rename, Serverbound::encode, Serverbound::decode);
        // The slot, the container id (VarInts), then the new state.
    // rust: let toggle = Serverbound::ContainerSlotStateChanged(ContainerSlotStateChanged {
    // rust: slot: 4,
    // rust: container: 2,
    // rust: enabled: false,
    // rust: });
    // rust: assert_eq!(&toggle.encode()[1..], &[4, 2, 0]);
    // rust: round_trip(toggle, Serverbound::encode, Serverbound::decode);
        // Two optional mob effect ids: a presence byte, then the VarInt.
    // rust: let beacon = Serverbound::SetBeacon(SetBeacon {
    // rust: primary: Some(2),
    // rust: secondary: None,
    // rust: });
    // rust: assert_eq!(&beacon.encode()[1..], &[1, 2, 0]);
    // rust: round_trip(beacon, Serverbound::encode, Serverbound::decode);
}

a_cooldown_packet_carries_its_group_and_ticks :: proc() {
}
    // rust: let packet = Clientbound::Cooldown(Cooldown {
    // rust: group: "minecraft:ender_pearl".into(),
    // rust: duration: 20,
    // rust: });
    // rust: round_trip(packet, Clientbound::encode, Clientbound::decode);
        // The group is an identifier, the ticks a VarInt; a duration of 0
        // removes the entry.
    // rust: let body = Clientbound::encode(&Clientbound::Cooldown(Cooldown {
    // rust: group: "minecraft:ender_pearl".into(),
    // rust: duration: 0,
    // rust: }));
    // rust: assert_eq!(body[0], crate::ids::play::clientbound::COOLDOWN as u8);
    // rust: assert_eq!(&body[1..3], [21, b'm']);
    // rust: assert_eq!(body[body.len() - 1], 0);
}

debug_tag_queries_decode_as_their_packets :: proc() {
}
//         use crate::ids::play::{clientbound, serverbound};
        // ServerboundBlockEntityTagQueryPacket: VarInt transaction, BlockPos.
    // rust: let pos = [3, 64, -2];
    // rust: let mut body = vec![7];
    // rust: body.extend_from_slice(&crate::buf::pack_block_pos(pos).to_be_bytes());
    // rust: let packet = Serverbound::decode(serverbound::BLOCK_ENTITY_TAG_QUERY, &body).unwrap();
    // rust: assert_eq!(
    // rust: packet,
    // rust: Serverbound::BlockEntityTagQuery(BlockEntityTagQuery {
    // rust: transaction: 7,
    // rust: pos
    // rust: })
    // rust: );
    // rust: round_trip(packet, Serverbound::encode, Serverbound::decode);
        // ServerboundEntityTagQueryPacket: VarInt transaction, VarInt entity id.
    // rust: let packet = Serverbound::decode(serverbound::ENTITY_TAG_QUERY, &[0, 42]).unwrap();
    // rust: assert_eq!(
    // rust: packet,
    // rust: Serverbound::EntityTagQuery(EntityTagQuery {
    // rust: transaction: 0,
    // rust: entity: 42
    // rust: })
    // rust: );
    // rust: round_trip(packet, Serverbound::encode, Serverbound::decode);
        // ClientboundTagQueryPacket: VarInt transaction, then the nullable
        // compound of FriendlyByteBuf.writeNbt (a bare End tag for null).
    // rust: let packet = Clientbound::decode(clientbound::TAG_QUERY, &[1, 0]).unwrap();
    // rust: assert_eq!(
    // rust: packet,
    // rust: Clientbound::TagQuery(TagQuery {
    // rust: transaction: 1,
    // rust: tag: Tag::End
    // rust: })
    // rust: );
    // rust: let mut items = horizon_world::nbt::Compound::new();
    // rust: items.insert("Lock".into(), Tag::String("key".into()));
    // rust: round_trip(
    // rust: Clientbound::TagQuery(TagQuery {
    // rust: transaction: 2,
    // rust: tag: Tag::Compound(items),
    // rust: }),
    // rust: Clientbound::encode,
    // rust: Clientbound::decode,
    // rust: );
}

change_game_mode_uses_the_game_type_varint :: proc() {
}
    // rust: for mode in 0..=3 {
    // rust: let packet = Serverbound::ChangeGameMode(ChangeGameMode { mode });
    // rust: assert_eq!(packet.encode(), vec![5, mode as u8]);
    // rust: round_trip(packet, Serverbound::encode, Serverbound::decode);
}
}

move_entity_deltas_decode_like_vec_delta_codec :: proc() {
}
    // rust: let base = [10.0, 64.0, -3.5];
    // rust: assert_eq!(
    // rust: VecDelta::Linear([4096, 0, -2048]).end(base),
    // rust: [11.0, 64.0, -4.0]
    // rust: );
        // Zero deltas keep unquantized base coordinates exactly.
    // rust: assert_eq!(
    // rust: VecDelta::Linear([0, 0, 0]).end([0.123_456_789, 1.0, 2.0]),
    // rust: [0.123_456_789, 1.0, 2.0]
    // rust: );
    // rust: assert_eq!(
    // rust: VecDelta::Stepped(vec![([4096, 0, 0], 1), ([4096, 0, 0], 2)]).end(base),
    // rust: [12.0, 64.0, -3.5]
    // rust: );
}

player_look_at_round_trips :: proc() {
}
    // rust: let at_point = PlayerLookAt {
    // rust: from: 1,
    // rust: target: [1.5, 64.0, -2.25],
    // rust: entity: None,
}
    // rust: let at_entity = PlayerLookAt {
    // rust: from: 0,
    // rust: target: [0.0, 70.0, 0.0],
    // rust: entity: Some(LookAtEntity { id: 42, anchor: 1 }),
}
    // rust: for p in [at_point, at_entity] {
    // rust: let bytes = Clientbound::PlayerLookAt(p.clone()).encode();
            // 1 id byte, 1 anchor, 3 doubles, the flag; the entity adds 2 VarInts.
    // rust: let len = 1 + 1 + 24 + 1 + if p.entity.is_some() { 2 } else { 0 };
    // rust: assert_eq!(bytes.len(), len);
    // rust: assert_eq!(
    // rust: Clientbound::decode(crate::ids::play::clientbound::PLAYER_LOOK_AT, &bytes[1..])
    // rust: .unwrap(),
    // rust: Clientbound::PlayerLookAt(p)
    // rust: );
}
}

post_effects_round_trips :: proc() {
}
    // rust: let p = PostEffects {
    // rust: effects: vec!["minecraft:invert".into(), "pack:glow".into()],
}
    // rust: let bytes = Clientbound::PostEffects(p.clone()).encode();
    // rust: assert_eq!(
    // rust: Clientbound::decode(crate::ids::play::clientbound::POST_EFFECTS, &bytes[1..]).unwrap(),
    // rust: Clientbound::PostEffects(p)
    // rust: );
        // The empty list the server sends on join.
    // rust: assert_eq!(
    // rust: Clientbound::decode(crate::ids::play::clientbound::POST_EFFECTS, &[0]).unwrap(),
    // rust: Clientbound::PostEffects(PostEffects {
    // rust: effects: Vec::new()
    // rust: })
    // rust: );
}

    // ClientboundChunksBiomesPacket is read, not passed through as an
    // unknown packet: one column (1, -2) with two bytes of biomes.
chunks_biomes_is_a_known_packet :: proc() {
}
    // rust: let id = crate::ids::play::clientbound::CHUNKS_BIOMES;
    // rust: let payload = [1, 0xFF, 0xFF, 0xFF, 0xFE, 0, 0, 0, 1, 2, 5, 6];
    // rust: let p = Clientbound::decode(id, &payload).unwrap();
    // rust: assert!(!matches!(p, Clientbound::Unknown(..)), "{p:?}");
    // rust: assert_eq!(p.encode()[1..], payload);
        // Cut short, it is an error rather than a packet.
    // rust: assert!(Clientbound::decode(id, &payload[..10]).is_err());
}

    // ClientboundChunksBiomesPacket.STREAM_CODEC: a list of (ChunkPos as
    // one long, x low and z high; `byteArray(2097152)`), the bytes being
    // each section's biome container (`ChunkBiomeData.extractChunkData`).
chunks_biomes_wire_and_biomes :: proc() {
}
    // rust: let p = Clientbound::ChunksBiomes(ChunksBiomes {
    // rust: chunks: vec![ChunkBiomeData {
    // rust: pos: [1, -2],
    // rust: buffer: vec![5, 6],
    // rust: }],
    // rust: });
    // rust: let bytes = p.encode();
    // rust: assert_eq!(
    // rust: bytes,
    // rust: [
    // rust: crate::ids::play::clientbound::CHUNKS_BIOMES as u8,
    // rust: 1,
    // rust: 0xFF,
    // rust: 0xFF,
    // rust: 0xFF,
    // rust: 0xFE,
    // rust: 0,
    // rust: 0,
    // rust: 0,
    // rust: 1,
    // rust: 2,
    // rust: 5,
    // rust: 6
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: Clientbound::decode(bytes[0].into(), &bytes[1..]).unwrap(),
    // rust: p
    // rust: );
//         use crate::chunk::{Paletted, Strategy};
    // rust: let sections = [
    // rust: Paletted::from_values(&[3; 64], Strategy::Biomes, 6),
    // rust: Paletted::from_values(
    // rust: &(0..64).map(|i| i % 5).collect::<Vec<_>>(),
    // rust: Strategy::Biomes,
    // rust: 6,
    // rust: ),
    // rust: ];
    // rust: let data = ChunkBiomeData::from_biomes([4, 4], &sections);
    // rust: assert_eq!(data.biomes(2, 6).unwrap(), sections);
}

    // ClientboundSetCameraPacket: one VarInt, the camera entity's id.
set_camera_is_the_camera_entity_id :: proc() {
}
        // 300 as a VarInt: 0xAC 0x02.
    // rust: let p =
    // rust: Clientbound::decode(crate::ids::play::clientbound::SET_CAMERA, &[0xAC, 0x02]).unwrap();
    // rust: assert!(!matches!(p, Clientbound::Unknown(..)), "{p:?}");
    // rust: assert!(format!("{p:?}").contains("camera_id: 300"), "{p:?}");
    // rust: assert_eq!(p.encode()[1..], [0xAC, 0x02]);
}

    // ServerboundSpectatorActionPacket: `OPTIONAL_VAR_INT`, the clicked
    // entity's id plus one, or 0 for a click on nothing.
spectator_action_is_an_optional_entity_id :: proc() {
}
    // rust: let id = crate::ids::play::serverbound::SPECTATOR_ACTION;
    // rust: for (bytes, shown) in [([8u8], "Some(7)"), ([0u8], "None")] {
    // rust: let p = Serverbound::decode(id, &bytes).unwrap();
    // rust: assert!(!matches!(p, Serverbound::Unknown(..)), "{p:?}");
    // rust: assert!(format!("{p:?}").contains(shown), "{p:?}");
    // rust: assert_eq!(p.encode()[1..], bytes);
}
}

unknown_packets_keep_their_payload :: proc() {
}
    // rust: let p =
    // rust: Clientbound::decode(crate::ids::play::clientbound::DEBUG_SAMPLE, &[1, 2, 3]).unwrap();
    // rust: assert_eq!(
    // rust: p,
    // rust: Clientbound::Unknown(crate::ids::play::clientbound::DEBUG_SAMPLE, vec![1, 2, 3])
    // rust: );
    // rust: assert_eq!(p.encode()[1..], [1, 2, 3]);
}

update_attributes_encode_like_vanilla :: proc() {
}
    // rust: let p = Clientbound::UpdateAttributes(UpdateAttributes {
    // rust: id: 5,
    // rust: values: vec![AttributeSnapshot {
    // rust: attribute: 1,
    // rust: base: 0.0,
    // rust: modifiers: vec![AttributeModifier {
    // rust: id: "minecraft:armor.helmet".into(),
    // rust: amount: 3.0,
    // rust: operation: 0,
    // rust: }],
    // rust: }],
    // rust: });
    // rust: let body = p.encode();
        // The packet id (134) is a two-byte VarInt.
    // rust: let mut expected = vec![134, 1, 5, 1, 1];
    // rust: expected.extend(0.0f64.to_be_bytes());
    // rust: expected.extend([1, 22]);
    // rust: expected.extend(b"minecraft:armor.helmet");
    // rust: expected.extend(3.0f64.to_be_bytes());
    // rust: expected.push(0);
    // rust: assert_eq!(body, expected);
    // rust: assert_eq!(crate::ids::play::clientbound::UPDATE_ATTRIBUTES, 134);
    // rust: assert_eq!(Clientbound::decode(134, &body[2..]).unwrap(), p);
}

map_item_data_carries_a_server_patch :: proc() {
}
    // rust: let patch = MapPatch {
    // rust: start_x: 3,
    // rust: start_y: 4,
    // rust: width: 2,
    // rust: height: 1,
    // rust: colors: vec![1, 2],
}
    // rust: let mut w = Writer::new();
    // rust: MapPatchOpt::write(&Some(patch.clone()), &mut w);
    // rust: assert_eq!(w.data, [2, 1, 3, 4, 2, 1, 2]);
    // rust: let p = Clientbound::MapItemData(MapItemData {
    // rust: map_id: 2146483647,
    // rust: scale: 1,
    // rust: locked: true,
    // rust: decorations: None,
    // rust: patch: Some(patch),
    // rust: });
    // rust: round_trip(p, Clientbound::encode, Clientbound::decode);
}

sign_packets_match_vanilla_stream_codecs :: proc() {
}
        // ClientboundOpenSignEditorPacket: BlockPos, then SignTextSlot as a VarInt (FRONT is 1).
    // rust: let open = Clientbound::OpenSignEditor(OpenSignEditor {
    // rust: pos: [1, 2, 3],
    // rust: front: true,
    // rust: });
    // rust: let body = open.encode();
    // rust: assert_eq!(
    // rust: body[1..9],
    // rust: crate::buf::pack_block_pos([1, 2, 3]).to_be_bytes()
    // rust: );
    // rust: assert_eq!(body[9..], [1]);
    // rust: round_trip(open, Clientbound::encode, Clientbound::decode);
        // ServerboundSignUpdatePacket: BlockPos, four strings with no count, then the slot.
    // rust: let update = Serverbound::SignUpdate(SignUpdate {
    // rust: pos: [-4, 70, 9],
    // rust: lines: ["Hi".into(), String::new(), "x".into(), String::new()],
    // rust: front: false,
    // rust: });
    // rust: let body = update.encode();
    // rust: assert_eq!(body[9..], [2, b'H', b'i', 0, 1, b'x', 0, 0]);
    // rust: round_trip(update, Serverbound::encode, Serverbound::decode);
}

book_packets_match_vanilla_stream_codecs :: proc() {
}
        // ClientboundOpenBookPacket: InteractionHand as a VarInt.
    // rust: let open = Clientbound::OpenBook(OpenBook { hand: 1 });
    // rust: assert_eq!(open.encode()[1..], [1]);
    // rust: round_trip(open, Clientbound::encode, Clientbound::decode);
        // ServerboundEditBookPacket: the slot, the pages (a counted list), then an optional title.
    // rust: let sign = Serverbound::EditBook(EditBook {
    // rust: slot: 40,
    // rust: pages: vec!["a".into(), String::new()],
    // rust: title: Some("T".into()),
    // rust: });
    // rust: assert_eq!(sign.encode()[1..], [40, 2, 1, b'a', 0, 1, 1, b'T']);
    // rust: round_trip(sign, Serverbound::encode, Serverbound::decode);
    // rust: let mut w = Writer::new();
    // rust: w.varint(101);
    // rust: assert!(BookPages::read(&mut Reader::new(&w.data)).is_err());
}

boss_event_round_trips :: proc() {
}
    // rust: let add = Clientbound::BossEvent(BossEvent {
    // rust: id: 0x0123_4567_89ab_cdef_fedc_ba98_7654_3210,
    // rust: action: BossAction::Add {
    // rust: name: Tag::String("Wither".into()),
    // rust: progress: 0.5,
    // rust: color: 5,
    // rust: overlay: 0,
    // rust: darken: true,
    // rust: music: false,
    // rust: fog: true,
    // rust: },
    // rust: });
    // rust: let body = add.encode();
        // Packet id 9, then the uuid, operation 0, and the property byte
        // (darken 1, fog 4).
    // rust: assert_eq!(body[0], 9);
    // rust: assert_eq!(*body.last().unwrap(), 5);
    // rust: round_trip(add, Clientbound::encode, Clientbound::decode);
    // rust: round_trip(
    // rust: Clientbound::BossEvent(BossEvent {
    // rust: id: 7,
    // rust: action: BossAction::UpdateProgress { progress: 0.25 },
    // rust: }),
    // rust: Clientbound::encode,
    // rust: Clientbound::decode,
    // rust: );
    // rust: round_trip(
    // rust: Clientbound::BossEvent(BossEvent {
    // rust: id: 7,
    // rust: action: BossAction::Remove,
    // rust: }),
    // rust: Clientbound::encode,
    // rust: Clientbound::decode,
    // rust: );
}

    // A registry entry is its id + 1, the dialog itself a 0 then its NBT.
dialogs_round_trip :: proc() {
}
    // rust: let notice = Tag::compound([("type", Tag::String("minecraft:notice".into()))]);
    // rust: for dialog in [DialogHolder::Registry(3), DialogHolder::Direct(notice)] {
    // rust: crate::packets::round_trip(
    // rust: Clientbound::ShowDialog(ShowDialog { dialog }),
    // rust: Clientbound::encode,
    // rust: Clientbound::decode,
    // rust: );
}
    // rust: let mut w = Writer::new();
    // rust: DialogHolder::write(&DialogHolder::Registry(3), &mut w);
    // rust: assert_eq!(w.data, [4]);
    // rust: crate::packets::round_trip(
    // rust: Serverbound::CustomClickAction(CustomClickAction {
    // rust: id: "minecraft:custom".into(),
    // rust: payload: None,
    // rust: }),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
}

set_command_minecart_writes_entity_command_then_track_output :: proc() {
}
    // rust: let packet = SetCommandMinecart {
    // rust: entity: 300,
    // rust: command: "say hi".into(),
    // rust: track_output: true,
}
    // rust: round_trip(
    // rust: Serverbound::SetCommandMinecart(packet.clone()),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
        // ServerboundSetCommandMinecartPacket.write: VarInt, UTF, boolean.
    // rust: let mut w = Writer::new();
    // rust: SetCommandMinecart::write(&packet, &mut w);
    // rust: assert_eq!(
    // rust: w.data,
    // rust: [0xAC, 0x02, 6, b's', b'a', b'y', b' ', b'h', b'i', 1]
    // rust: );
}

set_structure_block_round_trips_and_clamps_like_vanilla :: proc() {
}
    // rust: let packet = SetStructureBlock {
    // rust: pos: [-3, 70, 12],
    // rust: update_type: 1,
    // rust: mode: 0,
    // rust: name: "minecraft:house".into(),
    // rust: offset: [-48, 1, 48],
    // rust: size: [0, 48, 5],
    // rust: mirror: 2,
    // rust: rotation: 3,
    // rust: data: "meta".into(),
    // rust: ignore_entities: true,
    // rust: strict: false,
    // rust: show_air: true,
    // rust: show_bounding_box: true,
    // rust: integrity: 0.5,
    // rust: seed: -7,
}
    // rust: round_trip(
    // rust: Serverbound::SetStructureBlock(packet.clone()),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
        // The flag byte: ignoreEntities 1, showAir 2, showBoundingBox 4, strict 8.
    // rust: let mut w = Writer::new();
    // rust: SetStructureBlock::write(&packet, &mut w);
    // rust: assert_eq!(*w.data.last().unwrap(), 1 | 2 | 4);
        // Offsets clamp to +-48, sizes to 0..=48 and the integrity to 0..=1.
    // rust: let wild = SetStructureBlock {
    // rust: offset: [-100, 100, 0],
    // rust: size: [-5, 100, 7],
    // rust: integrity: 4.0,
    // rust: ..packet
}
    // rust: let mut w = Writer::new();
    // rust: SetStructureBlock::write(&wild, &mut w);
    // rust: let read = SetStructureBlock::read(&mut Reader::new(&w.data)).unwrap();
    // rust: assert_eq!(read.offset, [-48, 48, 0]);
    // rust: assert_eq!(read.size, [0, 48, 7]);
    // rust: assert_eq!(read.integrity, 1.0);
}

test_instance_packets_round_trip :: proc() {
}
    // rust: let data = TestInstanceData {
    // rust: test: Some("minecraft:always_pass".into()),
    // rust: size: [3, 4, 5],
    // rust: rotation: 2,
    // rust: ignore_entities: true,
    // rust: status: 1,
    // rust: error_message: Some(Tag::String("bad".into())),
}
    // rust: round_trip(
    // rust: Serverbound::TestInstanceBlockAction(TestInstanceBlockAction {
    // rust: pos: [1, 2, 3],
    // rust: action: 6,
    // rust: data: data.clone(),
    // rust: }),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
    // rust: let empty = TestInstanceData {
    // rust: test: None,
    // rust: error_message: None,
    // rust: ..data
}
    // rust: let mut w = Writer::new();
    // rust: TestInstanceData::write(&empty, &mut w);
        // Absent test, three sizes, rotation, flag, status, absent error.
    // rust: assert_eq!(w.data, [0, 3, 4, 5, 2, 1, 1, 0]);
    // rust: round_trip(
    // rust: Clientbound::TestInstanceBlockStatus(TestInstanceBlockStatus {
    // rust: status: Tag::String("ok".into()),
    // rust: size: Some([1, 2, 3]),
    // rust: }),
    // rust: Clientbound::encode,
    // rust: Clientbound::decode,
    // rust: );
}

game_test_highlight_pos_round_trips :: proc() {
}
    // rust: round_trip(
    // rust: Clientbound::GameTestHighlightPos(GameTestHighlightPos {
    // rust: absolute: [10, -64, 30],
    // rust: relative: [1, 2, 3],
    // rust: }),
    // rust: Clientbound::encode,
    // rust: Clientbound::decode,
    // rust: );
}

set_test_block_round_trips :: proc() {
}
    // rust: round_trip(
    // rust: Serverbound::SetTestBlock(SetTestBlock {
    // rust: pos: [1, 2, 3],
    // rust: mode: 3,
    // rust: message: "passed".into(),
    // rust: }),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
}

    // A `SetTime` packet captured from a vanilla 26.3 server at join, two
    // clocks: `Long 13071`, then `VarInt 2`, `(0, 66678, 0.0, 1.0)` and
    // `(1, 13071, 0.0, 1.0)`. Reading the clock as a holder id + 1 turns the
    // first key into an inline definition and the packet stops decoding.
a_time_clock_is_a_plain_registry_id :: proc() {
}
    // rust: let payload = [
    // rust: 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x0f, // game_time 13071
    // rust: 0x02, // two clocks
    // rust: 0x00, 0xf6, 0x88, 0x04, 0x00, 0x00, 0x00, 0x00, 0x3f, 0x80, 0x00, 0x00, // clock 0
    // rust: 0x01, 0x8f, 0x66, 0x00, 0x00, 0x00, 0x00, 0x3f, 0x80, 0x00, 0x00, // clock 1
    // rust: ];
    // rust: let decoded =
    // rust: Clientbound::decode(crate::ids::play::clientbound::SET_TIME, &payload).unwrap();
    // rust: let Clientbound::SetTime(t) = decoded else {
    // rust: panic!("expected SetTime")
}
    // rust: assert_eq!(t.game_time, 13071);
    // rust: assert_eq!(t.clocks.len(), 2);
    // rust: assert_eq!((t.clocks[0].clock, t.clocks[0].total_ticks), (0, 66678));
    // rust: assert_eq!((t.clocks[1].clock, t.clocks[1].total_ticks), (1, 13071));
    // rust: assert_eq!(t.clocks[0].rate, 1.0);
}

jigsaw_packets_round_trip :: proc() {
}
    // rust: round_trip(
    // rust: Serverbound::SetJigsawBlock(SetJigsawBlock {
    // rust: pos: [4, -60, 9],
    // rust: name: "minecraft:bottom".into(),
    // rust: target: "minecraft:top".into(),
    // rust: pool: "minecraft:village/plains/houses".into(),
    // rust: final_state: "minecraft:oak_planks".into(),
    // rust: joint: "aligned".into(),
    // rust: selection_priority: 3,
    // rust: placement_priority: -2,
    // rust: }),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
    // rust: round_trip(
    // rust: Serverbound::JigsawGenerate(JigsawGenerate {
    // rust: pos: [0, 64, 0],
    // rust: levels: 20,
    // rust: keep_jigsaws: true,
    // rust: }),
    // rust: Serverbound::encode,
    // rust: Serverbound::decode,
    // rust: );
}
}
