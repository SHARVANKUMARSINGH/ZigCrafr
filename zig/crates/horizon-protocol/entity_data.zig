//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_entity_data
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! SynchedEntityData values (ClientboundSetEntityDataPacket): an entry index,
//! the EntityDataSerializers id, and the serializer's value, ending with 0xFF.
//! Serializers Horizon cannot decode end the list early; the entries before
//! them are kept.
// use crate::{
    // rust: Result,
    // rust: adapter::ids,
    // rust: buf::{Codec, Reader, Writer},
    // rust: item::{Slot, Stack, Template},
}
// use horizon_world::nbt::Tag;

pub const Value = enum {
    Byte(i8),
    Int(i32),
    Long(i64),
    Float(f32),
    String(String),
    Text(Tag),
    OptText(Option<Tag>),
    Item(Option<Stack>),
    Bool(bool),
    Floats(Vec<f32>),
    Pos([i32; 3]),
    OptPos(Option<[i32; 3]>),
    OptUuid(Option<u128>),
    /// Any VarInt-valued serializer (direction, block state, pose, variants ...).
    Id(i32),
    /// Several VarInts (VillagerData).
    Ids(Vec<i32>),
    /// A particle choice: the `minecraft:particle_type` id plus its data.
    /// Rendered nowhere (the client spawns no world particles yet); decoded
    /// so the rest of an entry list survives a particle slot.
    Particle(Particle),
    /// A particle list (PARTICLES: a VarInt count, then each particle).
    Particles(Vec<Particle>),
    /// A `ResolvableProfile` (a mannequin's DATA_PROFILE).
    Profile(Profile),
};
/// `ResolvableProfile.STREAM_CODEC`: the GameProfile a mannequin or player
/// head resolves — either a full profile (id, name and properties on the
/// wire) or a partial one (a name and/or id to look up) — followed by a
/// `PlayerSkin.Patch` of texture overrides.
pub const Profile = struct {
    name: ?[]const u8,
    uuid: ?u128,
    /// `PropertyMap`: its `textures` property carries the skin.
    properties: std.ArrayList(crate::packets::login::Property),
    /// `PlayerSkin.Patch`: texture asset ids overriding the profile's.
    body: ?[]const u8,
    cape: ?[]const u8,
    elytra: ?[]const u8,
    /// `PlayerModelType`: true is the slim (4px arms) model.
    slim: ?bool,
};
/// `ByteBufCodecs.GAME_PROFILE_PROPERTIES`.
pub fn read_properties(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use crate::buf::Codec;
    // rust: let n = r.count(16)?;
    // rust: (0..n)
    // rust: .map(|_| crate::packets::login::Property::read(r))
    // rust: .collect()
}
pub fn write_properties(p: *[crate::packets::login::Property], w: *mut Writer) void {
}
//     use crate::buf::Codec;
    // rust: w.varint(p.len() as i32);
    // rust: p.iter()
    // rust: .for_each(|p| crate::packets::login::Property::write(p, w));
}
pub fn read_profile(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = Profile::default();
    // ByteBufCodecs.either: true is the full GameProfile, false a Partial.
    // rust: if r.bool()? {
    // rust: p.uuid = Some(r.uuid()?);
    // rust: p.name = Some(r.string(16)?);
    // rust: p.properties = read_properties(r)?;
    // rust: } else {
    // rust: if r.bool()? {
    // rust: p.name = Some(r.string(16)?);
}
    // rust: if r.bool()? {
    // rust: p.uuid = Some(r.uuid()?);
}
    // rust: p.properties = read_properties(r)?;
}
    // PlayerSkin.Patch: three optional texture ids, then the model type.
    // rust: if r.bool()? {
    // rust: p.body = Some(r.string(32767)?);
}
    // rust: if r.bool()? {
    // rust: p.cape = Some(r.string(32767)?);
}
    // rust: if r.bool()? {
    // rust: p.elytra = Some(r.string(32767)?);
}
    // rust: if r.bool()? {
    // rust: p.slim = Some(r.bool()?);
}
    // rust: Ok(p)
}
pub fn write_profile(p: *Profile, w: *mut Writer) void {
}
    // rust: let full = p.uuid.is_some() && p.name.is_some();
    // rust: w.bool(full);
    // rust: if full {
    // rust: w.uuid(p.uuid.unwrap_or(0));
    // rust: w.string(p.name.as_deref().unwrap_or(""));
    // rust: } else {
    // rust: w.bool(p.name.is_some());
    // rust: if let Some(name) = &p.name {
    // rust: w.string(name);
}
    // rust: w.bool(p.uuid.is_some());
    // rust: if let Some(uuid) = p.uuid {
    // rust: w.uuid(uuid);
}
}
    // rust: write_properties(&p.properties, w);
    // rust: for texture in [&p.body, &p.cape, &p.elytra] {
    // rust: w.bool(texture.is_some());
    // rust: if let Some(texture) = texture {
    // rust: w.string(texture);
}
}
    // rust: w.bool(p.slim.is_some());
    // rust: if let Some(slim) = p.slim {
    // rust: w.bool(slim);
}
}
/// One `ParticleTypes.STREAM_CODEC` value: the `minecraft:particle_type` id,
/// then the data its type carries (26.3 registry order).
pub const Particle = struct {
    id: i32,
    data: ?ParticleData,
};
pub const ParticleData = enum {
    /// Block state id (block, block_marker, falling_dust, dust_pillar,
    /// block_crumble).
    State(i32),
    /// ARGB color (entity_effect, tinted_leaves, flash).
    Color(i32),
    /// Dust: color then scale.
    ColorScale(i32, f32),
    /// Dust color transition: from color, to color, scale.
    ColorScale2(i32, i32, f32),
    /// Spell (effect, instant_effect): color then power.
    ColorPower(i32, f32),
    /// A bare float (dragon_breath power, sculk_charge roll).
    Scalar(f32),
    /// Delay in ticks (shriek).
    Delay(i32),
    /// Trail: target (3 doubles), ARGB color, duration.
    Trail([f64; 3], i32, i32),
    /// An item (ItemStackTemplate: item, count, patch).
    Item(Stack),
    /// Geyser and geyser_plume: water blocks.
    Geyser(i32),
    /// Geyser_base and geyser_poof: water blocks, then the burst impulse.
    GeyserBase(i32, f32),
    /// Vibration: where it travels to, then its arrival time in ticks.
    Vibration { source: PositionSource, ticks: i32 },
    /// Horizon extension: a native mod's own particle type, by its namespaced
    /// name (`mymod:spark`). Vanilla has no id for it; see `MOD_PARTICLE_ID`.
    Mod(String),
};
/// Horizon extension for a native mod's particle type. Vanilla's
/// `minecraft:particle_type` ids are registry ids and never negative, so this
/// one cannot collide with a vanilla type.
pub const MOD_PARTICLE_ID: i32 = -1;
/// `PositionSource.STREAM_CODEC`: a `minecraft:position_source_type` id
/// (block 0, entity 1), then that type's data.
pub const PositionSource = enum {
    Block([i32; 3]),
    Entity { id: i32, y_offset: f32 },
};
    // rust: impl Particle {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = r.varint()?;
    // rust: let id = if id == MOD_PARTICLE_ID {
    // rust: id
    // rust: } else {
    // rust: ids::particle(id)
}
        // A native mod's type: the namespaced name follows the sentinel id.
    // rust: if id == MOD_PARTICLE_ID {
    // rust: return Ok(Particle {
    // rust: id,
    // rust: data: Some(ParticleData::Mod(r.string(32767)?)),
    // rust: });
}
        // `minecraft:particle_type` registry order as of 26.3.
    // rust: let data = match id {
    // rust: 1 | 2 | 36 | 121 | 125 => Some(ParticleData::State(ids::block_state(r.varint()?))),
    // rust: 28 | 46 | 52 => Some(ParticleData::Color(r.i32()?)),
    // rust: 21 => {
    // rust: let color = r.i32()?;
    // rust: Some(ParticleData::ColorScale(color, r.f32()?))
}
    // rust: 22 => {
    // rust: let from = r.i32()?;
    // rust: let to = r.i32()?;
    // rust: Some(ParticleData::ColorScale2(from, to, r.f32()?))
}
    // rust: 23 | 56 => {
    // rust: let color = r.i32()?;
    // rust: Some(ParticleData::ColorPower(color, r.f32()?))
}
    // rust: 15 | 48 => Some(ParticleData::Scalar(r.f32()?)),
    // rust: 115 => Some(ParticleData::Delay(r.varint()?)),
    // rust: 59 => {
    // rust: let at = [r.f64()?, r.f64()?, r.f64()?];
    // rust: let color = r.i32()?;
    // rust: Some(ParticleData::Trail(at, color, r.varint()?))
}
    // rust: 57 => Some(ParticleData::Item(Template::read(r)?)),
    // rust: 58 => {
    // rust: let source = match r.varint()? {
    // rust: 0 => PositionSource::Block(crate::buf::Pos::read(r)?),
    // rust: 1 => {
    // rust: let id = r.varint()?;
    // rust: PositionSource::Entity {
    // rust: id,
    // rust: y_offset: r.f32()?,
}
}
    // rust: kind => return Err(crate::Error::new(format!("position source type {kind}"))),
}
    // rust: Some(ParticleData::Vibration {
    // rust: source,
    // rust: ticks: r.varint()?,
    // rust: })
}
    // rust: 7 | 10 => Some(ParticleData::Geyser(r.i32()?)),
    // rust: 8 | 9 => {
    // rust: let water = r.i32()?;
    // rust: Some(ParticleData::GeyserBase(water, r.f32()?))
}
            // Every other registered particle carries no data.
    // rust: _ => None,
}
    // rust: Ok(Particle { id, data })
}
pub fn write(self: *Self, w: *mut Writer) void {
}
    // rust: w.varint(self.id);
    // rust: let Some(data) = &self.data else { return };
    // rust: match data {
    // rust: ParticleData::State(s) | ParticleData::Delay(s) => w.varint(*s),
    // rust: ParticleData::Color(c) | ParticleData::Geyser(c) => w.i32(*c),
    // rust: ParticleData::ColorScale(c, f)
    // rust: | ParticleData::ColorPower(c, f)
    // rust: | ParticleData::GeyserBase(c, f) => {
    // rust: w.i32(*c);
    // rust: w.f32(*f);
}
    // rust: ParticleData::ColorScale2(a, b, f) => {
    // rust: w.i32(*a);
    // rust: w.i32(*b);
    // rust: w.f32(*f);
}
    // rust: ParticleData::Scalar(f) => w.f32(*f),
    // rust: ParticleData::Trail(at, c, d) => {
    // rust: at.iter().for_each(|v| w.f64(*v));
    // rust: w.i32(*c);
    // rust: w.varint(*d);
}
    // rust: ParticleData::Item(s) => Template::write(s, w),
    // rust: ParticleData::Mod(name) => w.string(name),
    // rust: ParticleData::Vibration { source, ticks } => {
    // rust: match source {
    // rust: PositionSource::Block(pos) => {
    // rust: w.varint(0);
    // rust: crate::buf::Pos::write(pos, w);
}
    // rust: PositionSource::Entity { id, y_offset } => {
    // rust: w.varint(1);
    // rust: w.varint(*id);
    // rust: w.f32(*y_offset);
}
}
    // rust: w.varint(*ticks);
}
}
}
}
/// Serializer ids in EntityDataSerializers registration order.
    // rust: pub mod serializer {
pub const BYTE: i32 = 0;
pub const INT: i32 = 1;
pub const LONG: i32 = 2;
pub const FLOAT: i32 = 3;
pub const STRING: i32 = 4;
pub const COMPONENT: i32 = 5;
pub const OPTIONAL_COMPONENT: i32 = 6;
pub const ITEM_STACK: i32 = 7;
pub const BOOLEAN: i32 = 8;
pub const ROTATIONS: i32 = 9;
pub const BLOCK_POS: i32 = 10;
pub const OPTIONAL_BLOCK_POS: i32 = 11;
pub const DIRECTION: i32 = 12;
pub const OPTIONAL_LIVING_ENTITY_REFERENCE: i32 = 13;
pub const BLOCK_STATE: i32 = 14;
pub const OPTIONAL_BLOCK_STATE: i32 = 15;
pub const PARTICLE: i32 = 16;
pub const PARTICLES: i32 = 17;
pub const VILLAGER_DATA: i32 = 18;
pub const OPTIONAL_UNSIGNED_INT: i32 = 19;
pub const POSE: i32 = 20;
pub const CAT_VARIANT: i32 = 21;
pub const CAT_SOUND_VARIANT: i32 = 22;
pub const COW_VARIANT: i32 = 23;
pub const COW_SOUND_VARIANT: i32 = 24;
pub const WOLF_VARIANT: i32 = 25;
pub const WOLF_SOUND_VARIANT: i32 = 26;
pub const FROG_VARIANT: i32 = 27;
pub const PIG_VARIANT: i32 = 28;
pub const PIG_SOUND_VARIANT: i32 = 29;
pub const CHICKEN_VARIANT: i32 = 30;
pub const CHICKEN_SOUND_VARIANT: i32 = 31;
pub const ZOMBIE_NAUTILUS_VARIANT: i32 = 32;
pub const OPTIONAL_GLOBAL_POS: i32 = 33;
pub const PAINTING_VARIANT: i32 = 34;
pub const SNIFFER_STATE: i32 = 35;
pub const ARMADILLO_STATE: i32 = 36;
pub const COPPER_GOLEM_STATE: i32 = 37;
pub const WEATHERING_COPPER_STATE: i32 = 38;
pub const VECTOR3: i32 = 39;
pub const QUATERNION: i32 = 40;
pub const RESOLVABLE_PROFILE: i32 = 41;
pub const HUMANOID_ARM: i32 = 42;
pub const DYE_COLOR: i32 = 43;
}
pub fn read_value(kind: i32, r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use serializer::*;
    // rust: Ok(Some(match kind {
    // rust: BYTE => Value::Byte(r.i8()?),
    // rust: INT => Value::Int(r.varint()?),
    // rust: LONG => Value::Long(r.varlong()?),
    // rust: FLOAT => Value::Float(r.f32()?),
    // rust: STRING => Value::String(r.string(32767)?),
    // rust: COMPONENT => Value::Text(r.nbt()?),
    // rust: OPTIONAL_COMPONENT => Value::OptText(if r.bool()? { Some(r.nbt()?) } else { None }),
    // rust: ITEM_STACK => Value::Item(Slot::read(r)?),
    // rust: BOOLEAN => Value::Bool(r.bool()?),
    // rust: ROTATIONS | VECTOR3 => Value::Floats(vec![r.f32()?, r.f32()?, r.f32()?]),
    // rust: QUATERNION => Value::Floats(vec![r.f32()?, r.f32()?, r.f32()?, r.f32()?]),
    // rust: BLOCK_POS => Value::Pos(crate::buf::Pos::read(r)?),
    // rust: OPTIONAL_BLOCK_POS => Value::OptPos(if r.bool()? {
    // rust: Some(crate::buf::Pos::read(r)?)
    // rust: } else {
    // rust: None
    // rust: }),
    // rust: OPTIONAL_LIVING_ENTITY_REFERENCE => {
    // rust: Value::OptUuid(if r.bool()? { Some(r.uuid()?) } else { None })
}
        // VillagerData: type, profession and level.
    // rust: VILLAGER_DATA => Value::Ids(vec![r.varint()?, r.varint()?, r.varint()?]),
        // VarInt-encoded: direction, block states, optional ints, pose, the
        // holder-registry variants (cat to zombie nautilus, painting) and the
        // enum states (sniffer to weathering copper), arm, dye.
        // Block states as an older server numbers them (the optional one sends air, 0, for none).
    // rust: BLOCK_STATE | OPTIONAL_BLOCK_STATE => Value::Id(ids::block_state(r.varint()?)),
    // rust: DIRECTION
    // rust: | OPTIONAL_UNSIGNED_INT
    // rust: | POSE
    // rust: | CAT_VARIANT..=ZOMBIE_NAUTILUS_VARIANT
    // rust: | PAINTING_VARIANT..=WEATHERING_COPPER_STATE
    // rust: | HUMANOID_ARM
    // rust: | DYE_COLOR => Value::Id(r.varint()?),
    // rust: PARTICLE => Value::Particle(Particle::read(r)?),
    // rust: RESOLVABLE_PROFILE => Value::Profile(read_profile(r)?),
    // rust: PARTICLES => {
    // rust: let n = r.count(65536)?;
    // rust: let mut list = Vec::with_capacity(n.min(64));
    // rust: for _ in 0..n {
    // rust: list.push(Particle::read(r)?);
}
    // rust: Value::Particles(list)
}
    // rust: _ => return Ok(None),
    // rust: }))
}
pub fn write_value(kind: i32, v: *Value, w: *mut Writer) void {
}
    // rust: match v {
    // rust: Value::Byte(b) => w.i8(*b),
    // rust: Value::Int(i) | Value::Id(i) => w.varint(*i),
    // rust: Value::Ids(ids) => ids.iter().for_each(|i| w.varint(*i)),
    // rust: Value::Long(l) => w.varlong(*l),
    // rust: Value::Float(f) => w.f32(*f),
    // rust: Value::String(s) => w.string(s),
    // rust: Value::Text(t) => w.nbt(t),
    // rust: Value::OptText(t) => {
    // rust: w.bool(t.is_some());
    // rust: if let Some(t) = t {
    // rust: w.nbt(t);
}
}
    // rust: Value::Item(s) => Slot::write(s, w),
    // rust: Value::Bool(b) => w.bool(*b),
    // rust: Value::Floats(f) => f.iter().for_each(|f| w.f32(*f)),
    // rust: Value::Pos(p) => crate::buf::Pos::write(p, w),
    // rust: Value::OptPos(p) => {
    // rust: w.bool(p.is_some());
    // rust: if let Some(p) = p {
    // rust: crate::buf::Pos::write(p, w);
}
}
    // rust: Value::OptUuid(u) => {
    // rust: w.bool(u.is_some());
    // rust: if let Some(u) = u {
    // rust: w.uuid(*u);
}
}
    // rust: Value::Particle(p) => p.write(w),
    // rust: Value::Particles(list) => {
    // rust: w.varint(list.len() as i32);
    // rust: list.iter().for_each(|p| p.write(w));
}
    // rust: Value::Profile(p) => write_profile(p, w),
}
    // rust: let _ = kind;
}

/// (index, serializer id, value) entries.
pub const EntityData = struct {};
    // rust: impl Codec<Vec<(u8, i32, Value)>> for EntityData {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: loop {
    // rust: let index = r.u8()?;
    // rust: if index == 0xFF {
    // rust: return Ok(out);
}
    // rust: let kind = ids::entity_data_serializer(r.varint()?);
    // rust: match read_value(kind, r)? {
    // rust: Some(v) => out.push((index, kind, v)),
    // rust: None => {
    // rust: r.rest();
    // rust: return Ok(out);
}
}
}
}
pub fn write(v: *Vec<(u8) void {
}
    // rust: for (index, kind, value) in v {
    // rust: w.u8(*index);
    // rust: w.varint(*kind);
    // rust: write_value(*kind, value, w);
}
    // rust: w.u8(0xFF);
}
}

/// ItemEntity.DATA_ITEM (after the eight Entity data entries).
pub const ITEM_ENTITY_ITEM: u8 = 8;

    // rust: mod tests {
//     use super::*;

pub fn round_trips_and_stops_at_unknown_serializers() void {
}
    // rust: let entries = vec![
    // rust: (0u8, serializer::BYTE, Value::Byte(0x02)),
    // rust: (1, serializer::INT, Value::Int(300)),
    // rust: (2, serializer::OPTIONAL_COMPONENT, Value::OptText(None)),
    // rust: (6, serializer::POSE, Value::Id(5)),
    // rust: (
    // rust: 8,
    // rust: serializer::ITEM_STACK,
    // rust: Value::Item(Some(Stack::new(3, 12))),
    // rust: ),
    // rust: ];
    // rust: let mut w = Writer::new();
    // rust: EntityData::write(&entries, &mut w);
    // rust: assert_eq!(*w.data.last().unwrap(), 0xFF);
    // rust: assert_eq!(
    // rust: EntityData::read(&mut Reader::new(&w.data)).unwrap(),
    // rust: entries
    // rust: );
        // Serializer 200 is unknown: the list stops there, earlier entries kept.
    // rust: let mut bytes = vec![0, 0, 7, 9, 200, 1, 2, 3];
    // rust: bytes.push(0xFF);
    // rust: let read = EntityData::read(&mut Reader::new(&bytes)).unwrap();
    // rust: assert_eq!(read, vec![(0, 0, Value::Byte(7))]);
        // A block particle decodes fully and round-trips.
    // rust: let entries = vec![(
    // rust: 10u8,
    // rust: serializer::PARTICLE,
    // rust: Value::Particle(Particle {
    // rust: id: 1,
    // rust: data: Some(ParticleData::State(2)),
    // rust: }),
    // rust: )];
    // rust: let mut w = Writer::new();
    // rust: EntityData::write(&entries, &mut w);
    // rust: assert_eq!(
    // rust: EntityData::read(&mut Reader::new(&w.data)).unwrap(),
    // rust: entries
    // rust: );
}

    /// `EntityDataSerializers.VECTOR3` and `QUATERNION`
    /// (`FriendlyByteBuf.writeVector3f`, `writeQuaternion`): three or four
    /// big-endian floats.
pub fn vectors_and_quaternions_are_big_endian_floats() void {
}
//         use std::f32::consts::FRAC_1_SQRT_2;
    // rust: let entries = vec![
    // rust: (
    // rust: 11u8,
    // rust: serializer::VECTOR3,
    // rust: Value::Floats(vec![1.0, -2.0, 0.25]),
    // rust: ),
    // rust: (
    // rust: 13,
    // rust: serializer::QUATERNION,
    // rust: Value::Floats(vec![0.0, 0.0, FRAC_1_SQRT_2, FRAC_1_SQRT_2]),
    // rust: ),
    // rust: ];
    // rust: let mut w = Writer::new();
    // rust: EntityData::write(&entries, &mut w);
    // rust: let bytes = [
    // rust: 11, 39, 0x3F, 0x80, 0, 0, 0xC0, 0, 0, 0, 0x3E, 0x80, 0, 0,
    // rust: 13, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0x3F, 0x35, 0x04, 0xF3, 0x3F, 0x35, 0x04, 0xF3,
    // rust: 0xFF,
    // rust: ];
    // rust: assert_eq!(w.data, bytes);
    // rust: assert_eq!(EntityData::read(&mut Reader::new(&bytes)).unwrap(), entries);
}

    /// Every particle data shape (26.3 codecs) round-trips, and a PARTICLES
    /// list is a VarInt count then each particle, so the entry after it
    /// still decodes.
pub fn particles_round_trip() void {
}
    // rust: let all = [
    // rust: (1, Some(ParticleData::State(2))),
    // rust: (7, Some(ParticleData::Geyser(5))),
    // rust: (8, Some(ParticleData::GeyserBase(3, 0.5))),
    // rust: (15, Some(ParticleData::Scalar(1.0))),
    // rust: (21, Some(ParticleData::ColorScale(0xff0000, 1.5))),
    // rust: (22, Some(ParticleData::ColorScale2(1, 2, 0.75))),
    // rust: (23, Some(ParticleData::ColorPower(-1, 2.0))),
    // rust: (28, Some(ParticleData::Color(0x7f00ff00))),
    // rust: (
    // rust: 57,
    // rust: Some(ParticleData::Item(Stack {
    // rust: item: 42,
    // rust: count: 3,
    // rust: added: Vec::new(),
    // rust: removed: vec![7],
    // rust: wire: Default::default(),
    // rust: })),
    // rust: ),
            // A native mod's type: the sentinel id, then the namespaced name.
    // rust: (
    // rust: MOD_PARTICLE_ID,
    // rust: Some(ParticleData::Mod("mymod:spark".to_owned())),
    // rust: ),
    // rust: (
    // rust: 58,
    // rust: Some(ParticleData::Vibration {
    // rust: source: PositionSource::Block([-12, 64, 300]),
    // rust: ticks: 20,
    // rust: }),
    // rust: ),
    // rust: (
    // rust: 58,
    // rust: Some(ParticleData::Vibration {
    // rust: source: PositionSource::Entity {
    // rust: id: 99,
    // rust: y_offset: 1.25,
    // rust: },
    // rust: ticks: 8,
    // rust: }),
    // rust: ),
    // rust: (59, Some(ParticleData::Trail([1.5, -2.0, 3.25], 9, 40))),
    // rust: (115, Some(ParticleData::Delay(6))),
    // rust: (0, None),
    // rust: ]
    // rust: .map(|(id, data)| Particle { id, data });
    // rust: let mut entries: Vec<_> = all
    // rust: .iter()
    // rust: .map(|p| (10u8, serializer::PARTICLE, Value::Particle(p.clone())))
    // rust: .collect();
    // rust: entries.push((11, serializer::PARTICLES, Value::Particles(all.to_vec())));
    // rust: entries.push((12, serializer::BYTE, Value::Byte(4)));
    // rust: let mut w = Writer::new();
    // rust: EntityData::write(&entries, &mut w);
    // rust: assert_eq!(
    // rust: EntityData::read(&mut Reader::new(&w.data)).unwrap(),
    // rust: entries
    // rust: );
        // Wire shape: an empty list is one 0 byte, then the next entry.
    // rust: let bytes = [11, serializer::PARTICLES as u8, 0, 12, 0, 4, 0xFF];
    // rust: assert_eq!(
    // rust: EntityData::read(&mut Reader::new(&bytes)).unwrap(),
    // rust: vec![
    // rust: (11, serializer::PARTICLES, Value::Particles(Vec::new())),
    // rust: (12, serializer::BYTE, Value::Byte(4)),
    // rust: ]
    // rust: );
}

    /// RESOLVABLE_PROFILE (a mannequin's DATA_PROFILE): both ResolvableProfile
    /// contents round-trip, and an entry after it still decodes.
pub fn resolvable_profile_round_trips() void {
}
//         use crate::packets::login::Property;
    // rust: let full = Profile {
    // rust: name: Some("Gommunity".into()),
    // rust: uuid: Some(0x0123_4567_89AB_CDEF_0123_4567_89AB_CDEF),
    // rust: properties: vec![Property {
    // rust: name: "textures".into(),
    // rust: value: "e30=".into(),
    // rust: signature: Some("sig".into()),
    // rust: }],
    // rust: body: Some("minecraft:entity/player/wide/steve".into()),
    // rust: cape: None,
    // rust: elytra: None,
    // rust: slim: Some(false),
}
    // rust: let partial = Profile {
    // rust: name: Some("Gommunity".into()),
    // rust: ..Profile::default()
}
    // rust: let mut w = Writer::new();
    // rust: EntityData::write(
    // rust: &vec![
    // rust: (
    // rust: 17,
    // rust: serializer::RESOLVABLE_PROFILE,
    // rust: Value::Profile(full.clone()),
    // rust: ),
    // rust: (
    // rust: 17,
    // rust: serializer::RESOLVABLE_PROFILE,
    // rust: Value::Profile(partial.clone()),
    // rust: ),
    // rust: (18, serializer::BOOLEAN, Value::Bool(true)),
    // rust: ],
    // rust: &mut w,
    // rust: );
    // rust: assert_eq!(
    // rust: EntityData::read(&mut Reader::new(&w.data)).unwrap(),
    // rust: vec![
    // rust: (17, serializer::RESOLVABLE_PROFILE, Value::Profile(full)),
    // rust: (17, serializer::RESOLVABLE_PROFILE, Value::Profile(partial)),
    // rust: (18, serializer::BOOLEAN, Value::Bool(true)),
    // rust: ]
    // rust: );
}
}
