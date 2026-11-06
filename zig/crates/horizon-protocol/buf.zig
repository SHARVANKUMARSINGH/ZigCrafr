//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_buf
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Byte buffers with vanilla's primitive encodings (FriendlyByteBuf, VarInt,
//! VarLong, ByteBufCodecs) and the `Codec` building blocks packets are
//! composed from, mirroring `StreamCodec.composite`.
// use crate::{Error, Result};
// use horizon_world::nbt::{self, Tag};
// use std::marker::PhantomData;

/// Vanilla's default NBT quota for network tags (NbtAccounter.defaultQuota).
pub const NBT_QUOTA: usize = 2_097_152;

/// A cursor over a received packet body.
pub const Reader = struct {
    data: *'a [u8],
    pos: usize,
};
    // rust: impl<'a> Reader<'a> {
pub fn new(data: *'a [u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self { data, pos: 0 }
}
pub fn remaining(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data.len() - self.pos
}
pub fn position(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pos
}
    /// The bytes read since `start` (a `position()`).
pub fn since(self: *Self, start: usize) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.data[start.min(self.pos)..self.pos]
}
pub fn rest(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rest = &self.data[self.pos..];
    // rust: self.pos = self.data.len();
    // rust: rest
}
pub fn bytes(self: *Self, n: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.remaining() < n {
    // rust: return Err(Error::new(format!(
    // rust: "needed {n} bytes, {} left",
    // rust: self.remaining()
    // rust: )));
}
    // rust: let out = &self.data[self.pos..self.pos + n];
    // rust: self.pos += n;
    // rust: Ok(out)
}
    // rust: fn array<const N: usize>(&mut self) -> Result<[u8; N]> {
    // rust: Ok(self.bytes(N)?.try_into().expect("length checked"))
}
pub fn u8(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.array::<1>()?[0])
}
pub fn i8(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.u8()? as i8)
}
pub fn bool(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.u8()? != 0)
}
pub fn i16(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(i16::from_be_bytes(self.array()?))
}
pub fn u16(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(u16::from_be_bytes(self.array()?))
}
pub fn i32(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(i32::from_be_bytes(self.array()?))
}
pub fn u32(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(u32::from_be_bytes(self.array()?))
}
pub fn i64(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(i64::from_be_bytes(self.array()?))
}
pub fn f32(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(f32::from_be_bytes(self.array()?))
}
pub fn f64(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(f64::from_be_bytes(self.array()?))
}
    /// VarInt.read: at most five 7-bit groups, least significant first.
pub fn varint(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut value = 0u32;
    // rust: for i in 0..5 {
    // rust: let b = self.u8()?;
    // rust: value |= u32::from(b & 0x7F) << (7 * i);
    // rust: if b & 0x80 == 0 {
    // rust: return Ok(value as i32);
}
}
    // rust: Err(Error::new("VarInt too big"))
}
    /// VarLong.read: at most ten 7-bit groups.
pub fn varlong(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut value = 0u64;
    // rust: for i in 0..10 {
    // rust: let b = self.u8()?;
    // rust: value |= u64::from(b & 0x7F) << (7 * i);
    // rust: if b & 0x80 == 0 {
    // rust: return Ok(value as i64);
}
}
    // rust: Err(Error::new("VarLong too big"))
}
    /// A VarInt count that must fit in what is left (ByteBufCodecs.readCount).
pub fn count(self: *Self, max: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = self.varint()?;
    // rust: let n = usize::try_from(n).map_err(|_| Error::new(format!("negative count {n}")))?;
    // rust: if n > max {
    // rust: return Err(Error::new(format!(
    // rust: "{n} elements is more than allowed {max}"
    // rust: )));
}
    // rust: Ok(n)
}
    /// Utf8String.read: VarInt byte length, UTF-8, at most `max` chars of Java's
    /// String (UTF-16 units: a character outside the BMP counts twice).
pub fn string(self: *Self, max: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = self.count(max.saturating_mul(3))?;
    // rust: let s = packet_utf8(self.bytes(len)?);
    // rust: if s.encode_utf16().count() > max {
    // rust: return Err(Error::new(format!("string longer than {max} chars")));
}
    // rust: Ok(s)
}
pub fn byte_array(self: *Self, max: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = self.count(max)?;
    // rust: Ok(self.bytes(len)?.to_vec())
}
pub fn uuid(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(u128::from_be_bytes(self.array()?))
}
    /// A network NBT tag (NbtIo.readAnyTag without a root name); `End` means none.
pub fn nbt(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let limits = nbt::Limits {
    // rust: max_bytes: NBT_QUOTA,
    // rust: ..nbt::Limits::default()
}
    // rust: let (tag, used) = nbt::read_network(&self.data[self.pos..], limits)
    // rust: .map_err(|e| Error::new(format!("NBT: {e}")))?;
    // rust: self.pos += used;
    // rust: Ok(tag)
}
pub fn long_array(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = self.count(self.remaining() / 8)?;
    // rust: (0..n).map(|_| self.i64()).collect()
}
pub fn fixed_longs(self: *Self, n: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.remaining() < n * 8 {
    // rust: return Err(Error::new("fixed long array past the end"));
}
    // rust: (0..n).map(|_| self.i64()).collect()
}
}

/// Java's UTF-8 replacement decoder, as used by Utf8String.read. Most malformed
/// sequences have Rust's maximal-subpart grouping, but Java consumes an encoded
/// surrogate (including its truncated two-byte prefix) as one replacement.
pub fn packet_utf8(mut bytes: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut output = String::with_capacity(bytes.len());
    // rust: loop {
    // rust: match std::str::from_utf8(bytes) {
    // rust: Ok(valid) => {
    // rust: output.push_str(valid);
    // rust: return output;
}
    // rust: Err(error) => {
    // rust: let (valid, rest) = bytes.split_at(error.valid_up_to());
    // rust: output.push_str(std::str::from_utf8(valid).expect("validated UTF-8 prefix"));
    // rust: bytes = rest;
    // rust: let surrogate = bytes[0] == 0xed
    // rust: && bytes
    // rust: .get(1)
    // rust: .is_some_and(|byte| (0xa0..=0xbf).contains(byte));
    // rust: let consumed = if surrogate {
    // rust: if bytes.get(2).is_some_and(|byte| byte & 0xc0 == 0x80) {
    // rust: 3
    // rust: } else {
    // rust: 2
}
    // rust: } else {
    // rust: error.error_len().unwrap_or(bytes.len())
}
    // rust: output.push('\u{fffd}');
    // rust: bytes = &bytes[consumed..];
}
}
}
}

/// An outgoing packet body.
pub const Writer = struct {
    data: std.ArrayList(u8),
};
    // rust: impl Writer {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::default()
}
pub fn u8(self: *Self, v: u8) void {
}
    // rust: self.data.push(v);
}
pub fn i8(self: *Self, v: i8) void {
}
    // rust: self.data.push(v as u8);
}
pub fn bool(self: *Self, v: bool) void {
}
    // rust: self.data.push(u8::from(v));
}
pub fn i16(self: *Self, v: i16) void {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
pub fn u16(self: *Self, v: u16) void {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
pub fn i32(self: *Self, v: i32) void {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
pub fn u32(self: *Self, v: u32) void {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
pub fn i64(self: *Self, v: i64) void {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
pub fn f32(self: *Self, v: f32) void {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
pub fn f64(self: *Self, v: f64) void {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
pub fn varint(self: *Self, v: i32) void {
}
    // rust: write_varint(&mut self.data, v);
}
pub fn varlong(self: *Self, v: i64) void {
}
    // rust: let mut v = v as u64;
    // rust: loop {
    // rust: if v & !0x7F == 0 {
    // rust: self.data.push(v as u8);
    // rust: return;
}
    // rust: self.data.push((v as u8 & 0x7F) | 0x80);
    // rust: v >>= 7;
}
}
pub fn string(self: *Self, s: []const u8) void {
}
    // rust: self.varint(s.len() as i32);
    // rust: self.data.extend_from_slice(s.as_bytes());
}
pub fn byte_array(self: *Self, b: []const u8) void {
}
    // rust: self.varint(b.len() as i32);
    // rust: self.data.extend_from_slice(b);
}
pub fn bytes(self: *Self, b: []const u8) void {
}
    // rust: self.data.extend_from_slice(b);
}
pub fn uuid(self: *Self, v: u128) void {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
pub fn nbt(self: *Self, tag: *Tag) void {
}
    // rust: match nbt::write_network(tag, nbt::Limits::default()) {
    // rust: Ok(bytes) => self.data.extend_from_slice(&bytes),
            // Unencodable tags (too deep) are sent as "no tag".
    // rust: Err(_) => self.data.push(0),
}
}
pub fn long_array(self: *Self, v: *[i64]) void {
}
    // rust: self.varint(v.len() as i32);
    // rust: for &l in v {
    // rust: self.i64(l);
}
}
}
pub fn write_varint(out: *mut std.ArrayList(u8), v: i32) void {
}
    // rust: let mut v = v as u32;
    // rust: loop {
    // rust: if v & !0x7F == 0 {
    // rust: out.push(v as u8);
    // rust: return;
}
    // rust: out.push((v as u8 & 0x7F) | 0x80);
    // rust: v >>= 7;
}
}
pub fn varint_size(v: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = v as u32;
    // rust: (1..5).find(|i| v >> (7 * i) == 0).unwrap_or(5)
}

/// A wire encoding for values of type `T` (vanilla's StreamCodec).
    // rust: pub trait Codec<T> {
pub fn read(r: *mut Reader) R;
pub fn write(v: *T, w: *mut Writer) void;
}
    // rust: macro_rules! primitive {
    // rust: ($name:ident, $ty:ty, $read:ident, $write:ident) => {
    // rust: pub struct $name;
    // rust: impl Codec<$ty> for $name {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.$read()
}
pub fn write(v: *$ty, w: *mut Writer) void {
}
    // rust: w.$write(*v)
}
}
}
}
    // rust: primitive!(Bool, bool, bool, bool);
    // rust: primitive!(Byte, i8, i8, i8);
    // rust: primitive!(UByte, u8, u8, u8);
    // rust: primitive!(Short, i16, i16, i16);
    // rust: primitive!(UShort, u16, u16, u16);
    // rust: primitive!(Int, i32, i32, i32);
    // rust: primitive!(Long, i64, i64, i64);
    // rust: primitive!(Float, f32, f32, f32);
    // rust: primitive!(Double, f64, f64, f64);
    // rust: primitive!(VarInt, i32, varint, varint);
    // rust: primitive!(VarLong, i64, varlong, varlong);
    // rust: primitive!(Uuid, u128, uuid, uuid);

/// ByteBufCodecs.STRING_UTF8 (32767 chars).
pub const Str = struct {};
    // rust: impl Codec<String> for Str {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.string(32767)
}
pub fn write(v: *[]const u8, w: *mut Writer) void {
}
    // rust: w.string(v)
}
}
/// A string with a smaller vanilla limit, e.g. player names (16).
pub const StrN = struct {};
    // rust: impl<const N: usize> Codec<String> for StrN<N> {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.string(N)
}
pub fn write(v: *[]const u8, w: *mut Writer) void {
}
    // rust: w.string(v)
}
}
/// Identifier.STREAM_CODEC: a resource location string.
    // rust: pub type Ident = StrN<32767>;
/// VarInt-prefixed bytes.
pub const Bytes = struct {};
    // rust: impl Codec<Vec<u8>> for Bytes {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.byte_array(r.remaining())
}
pub fn write(v: *std.ArrayList(u8), w: *mut Writer) void {
}
    // rust: w.byte_array(v)
}
}
/// ByteBufCodecs.byteArray(N): VarInt-prefixed bytes, at most N.
pub const BytesN = struct {};
    // rust: impl<const N: usize> Codec<Vec<u8>> for BytesN<N> {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.byte_array(N)
}
pub fn write(v: *std.ArrayList(u8), w: *mut Writer) void {
}
    // rust: w.byte_array(v)
}
}
/// Everything left in the packet (custom payloads).
pub const Rest = struct {};
    // rust: impl Codec<Vec<u8>> for Rest {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(r.rest().to_vec())
}
pub fn write(v: *std.ArrayList(u8), w: *mut Writer) void {
}
    // rust: w.bytes(v)
}
}
/// Any network NBT tag (`Tag::End` when absent).
pub const Nbt = struct {};
    // rust: impl Codec<Tag> for Nbt {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.nbt()
}
pub fn write(v: *Tag, w: *mut Writer) void {
}
    // rust: w.nbt(v)
}
}
/// ByteBufCodecs.LONG_ARRAY.
pub const Longs = struct {};
    // rust: impl Codec<Vec<i64>> for Longs {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.long_array()
}
pub fn write(v: *std.ArrayList(i64), w: *mut Writer) void {
}
    // rust: w.long_array(v)
}
}
/// ByteBufCodecs.list(): VarInt count then elements.
pub const List = struct {};
    // rust: impl<T, C: Codec<T>> Codec<Vec<T>> for List<C> {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = r.count(r.remaining())?;
    // rust: (0..n).map(|_| C::read(r)).collect()
}
pub fn write(v: *std.ArrayList(T), w: *mut Writer) void {
}
    // rust: w.varint(v.len() as i32);
    // rust: for e in v {
    // rust: C::write(e, w);
}
}
}
/// ByteBufCodecs.optional(): a boolean presence flag.
pub const Opt = struct {};
    // rust: impl<T, C: Codec<T>> Codec<Option<T>> for Opt<C> {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if r.bool()? {
    // rust: Ok(Some(C::read(r)?))
    // rust: } else {
    // rust: Ok(None)
}
}
pub fn write(v: *?T, w: *mut Writer) void {
}
    // rust: w.bool(v.is_some());
    // rust: if let Some(v) = v {
    // rust: C::write(v, w);
}
}
}
/// ByteBufCodecs.OPTIONAL_VAR_INT: 0 = empty, otherwise value + 1.
pub const OptVarInt = struct {};
    // rust: impl Codec<Option<i32>> for OptVarInt {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = r.varint()?;
    // rust: Ok(if v == 0 { None } else { Some(v - 1) })
}
pub fn write(v: *?i32, w: *mut Writer) void {
}
    // rust: w.varint(v.map_or(0, |v| v + 1))
}
}
/// Vec3i.STREAM_CODEC: three var ints.
pub const VarVec3i = struct {};
    // rust: impl Codec<[i32; 3]> for VarVec3i {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok([r.varint()?, r.varint()?, r.varint()?])
}
pub fn write(v: *[i32; 3], w: *mut Writer) void {
}
    // rust: for n in v {
    // rust: w.varint(*n);
}
}
}
/// Vec3.STREAM_CODEC: three doubles.
pub const Vec3d = struct {};
    // rust: impl Codec<[f64; 3]> for Vec3d {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok([r.f64()?, r.f64()?, r.f64()?])
}
pub fn write(v: *[f64; 3], w: *mut Writer) void {
}
    // rust: for c in v {
    // rust: w.f64(*c);
}
}
}
/// BlockPos.STREAM_CODEC: x (26 bits), z (26 bits), y (12 bits) in one long.
pub const Pos = struct {};
    // rust: impl Codec<[i32; 3]> for Pos {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(unpack_block_pos(r.i64()?))
}
pub fn write(v: *[i32; 3], w: *mut Writer) void {
}
    // rust: w.i64(pack_block_pos(*v))
}
}
pub fn pack_block_pos(p: [i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((i64::from(p[0]) & 0x3FF_FFFF) << 38)
    // rust: | ((i64::from(p[2]) & 0x3FF_FFFF) << 12)
    // rust: | (i64::from(p[1]) & 0xFFF)
}
pub fn unpack_block_pos(v: i64) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: (v >> 38) as i32,
    // rust: (v << 52 >> 52) as i32,
    // rust: (v << 26 >> 38) as i32,
    // rust: ]
}
/// ChunkPos packed as x in the low and z in the high 32 bits.
pub const ChunkPos = struct {};
    // rust: impl Codec<[i32; 2]> for ChunkPos {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = r.i64()?;
    // rust: Ok([v as i32, (v >> 32) as i32])
}
pub fn write(v: *[i32; 2], w: *mut Writer) void {
}
    // rust: w.i64((i64::from(v[0]) & 0xFFFF_FFFF) | (i64::from(v[1]) << 32))
}
}
/// SectionPos: x (22 bits), z (22 bits), y (20 bits).
pub const SectionPos = struct {};
    // rust: impl Codec<[i32; 3]> for SectionPos {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = r.i64()?;
    // rust: Ok([
    // rust: (v >> 42) as i32,
    // rust: (v << 44 >> 44) as i32,
    // rust: (v << 22 >> 42) as i32,
    // rust: ])
}
pub fn write(v: *[i32; 3], w: *mut Writer) void {
}
    // rust: w.i64(
    // rust: ((i64::from(v[0]) & 0x3F_FFFF) << 42)
    // rust: | ((i64::from(v[2]) & 0x3F_FFFF) << 20)
    // rust: | (i64::from(v[1]) & 0xF_FFFF),
    // rust: )
}
}
/// ByteBufCodecs.BIT_SET: java.util.BitSet as a VarInt-prefixed byte array.
pub const BitSet = struct {};
    // rust: impl Codec<Vec<u8>> for BitSet {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.byte_array(r.remaining())
}
pub fn write(v: *std.ArrayList(u8), w: *mut Writer) void {
}
        // BitSet.toByteArray drops trailing zero bytes.
    // rust: let len = v.iter().rposition(|&b| b != 0).map_or(0, |i| i + 1);
    // rust: w.byte_array(&v[..len])
}
}
pub fn bit(set: []const u8, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: set.get(i / 8).is_some_and(|b| b >> (i % 8) & 1 != 0)
}
pub fn set_bit(set: *mut std.ArrayList(u8), i: usize) void {
}
    // rust: if set.len() <= i / 8 {
    // rust: set.resize(i / 8 + 1, 0);
}
    // rust: set[i / 8] |= 1 << (i % 8);
}
/// LpVec3: a low-precision velocity (Vec3.LP_STREAM_CODEC).
pub const LpVec3 = struct {};
    // rust: impl LpVec3 {
pub fn unpack(v: u64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((v & 32767) as f64).min(32766.0) * 2.0 / 32766.0 - 1.0
}
pub fn pack(v: f64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((v * 0.5 + 0.5) * 32766.0).round() as u64
}
    /// `v` as a reader decodes it after it was written.
pub fn quantize(v: [f64; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = Writer::new();
    // rust: Self::write(&v, &mut w);
    // rust: Self::read(&mut Reader::new(&w.data)).unwrap_or([0.0; 3])
}
pub fn sanitize(v: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v.is_nan() {
    // rust: 0.0
    // rust: } else {
    // rust: v.clamp(-1.717_986_918_3e10, 1.717_986_918_3e10)
}
}
}
    // rust: impl Codec<[f64; 3]> for LpVec3 {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lowest = u64::from(r.u8()?);
    // rust: if lowest == 0 {
    // rust: return Ok([0.0; 3]);
}
    // rust: let middle = u64::from(r.u8()?);
    // rust: let highest = u64::from(r.u32()?);
    // rust: let buffer = highest << 16 | middle << 8 | lowest;
    // rust: let mut scale = lowest & 3;
    // rust: if lowest & 4 == 4 {
    // rust: scale |= (u64::from(r.varint()? as u32)) << 2;
}
    // rust: let s = scale as f64;
    // rust: Ok([
    // rust: Self::unpack(buffer >> 3) * s,
    // rust: Self::unpack(buffer >> 18) * s,
    // rust: Self::unpack(buffer >> 33) * s,
    // rust: ])
}
pub fn write(v: *[f64; 3], w: *mut Writer) void {
}
    // rust: let [x, y, z] = v.map(Self::sanitize);
    // rust: let length = x.abs().max(y.abs()).max(z.abs());
    // rust: if length < 3.051_944_088_384_301e-5 {
    // rust: w.u8(0);
    // rust: return;
}
    // rust: let scale = length.ceil() as u64;
    // rust: let partial = scale & 3 != scale;
    // rust: let markers = if partial { scale & 3 | 4 } else { scale };
    // rust: let s = scale as f64;
    // rust: let buffer =
    // rust: markers | Self::pack(x / s) << 3 | Self::pack(y / s) << 18 | Self::pack(z / s) << 33;
    // rust: w.u8(buffer as u8);
    // rust: w.u8((buffer >> 8) as u8);
    // rust: w.i32((buffer >> 16) as i32);
    // rust: if partial {
    // rust: w.varint((scale >> 2) as i32);
}
}
}
/// A degree angle sent as a byte (Mth.packDegrees / unpackDegrees).
pub fn pack_degrees(deg: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (deg * 256.0 / 360.0).floor() as i32 as i8
}
pub fn unpack_degrees(b: i8) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f32::from(b) * 360.0 / 256.0
}

/// Define a packet struct and its codec from (field: type => codec) triples,
/// like vanilla's `StreamCodec.composite`.
    // rust: macro_rules! packet {
    // rust: ($(#[$meta:meta])* $name:ident { $($field:ident : $ty:ty => $codec:ty),* $(,)? }) => {
    // rust: $(#[$meta])*
    // rust: pub struct $name {
    // rust: $(pub $field: $ty),*
}
    // rust: impl $crate::buf::Codec<$name> for $name {
pub fn read(r: *mut $crate::buf::Reader) $ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok($name { $($field: <$codec as $crate::buf::Codec<$ty>>::read(r)?),* })
}
pub fn write(v: *$name, w: *mut $crate::buf::Writer) void {
}
    // rust: $(<$codec as $crate::buf::Codec<$ty>>::write(&v.$field, w);)*
}
}
}
}

    // rust: mod tests {
//     use super::*;

    // rust: fn round<T: PartialEq + std::fmt::Debug, C: Codec<T>>(v: T) -> Vec<u8> {
    // rust: let mut w = Writer::new();
    // rust: C::write(&v, &mut w);
    // rust: let mut r = Reader::new(&w.data);
    // rust: assert_eq!(C::read(&mut r).unwrap(), v);
    // rust: assert_eq!(r.remaining(), 0);
    // rust: w.data
}

pub fn varint_matches_vanilla_examples() void {
}
        // wiki.vg / VarInt.java examples.
    // rust: assert_eq!(round::<i32, VarInt>(0), [0x00]);
    // rust: assert_eq!(round::<i32, VarInt>(1), [0x01]);
    // rust: assert_eq!(round::<i32, VarInt>(127), [0x7f]);
    // rust: assert_eq!(round::<i32, VarInt>(128), [0x80, 0x01]);
    // rust: assert_eq!(round::<i32, VarInt>(255), [0xff, 0x01]);
    // rust: assert_eq!(round::<i32, VarInt>(25565), [0xdd, 0xc7, 0x01]);
    // rust: assert_eq!(round::<i32, VarInt>(2097151), [0xff, 0xff, 0x7f]);
    // rust: assert_eq!(
    // rust: round::<i32, VarInt>(i32::MAX),
    // rust: [0xff, 0xff, 0xff, 0xff, 0x07]
    // rust: );
    // rust: assert_eq!(round::<i32, VarInt>(-1), [0xff, 0xff, 0xff, 0xff, 0x0f]);
    // rust: assert_eq!(
    // rust: round::<i32, VarInt>(i32::MIN),
    // rust: [0x80, 0x80, 0x80, 0x80, 0x08]
    // rust: );
    // rust: for v in [0, 1, 127, 128, 16383, 16384, 2097151, 2097152, i32::MAX, -1] {
    // rust: assert_eq!(varint_size(v), round::<i32, VarInt>(v).len());
}
    // rust: assert!(Reader::new(&[0xff; 6]).varint().is_err());
}

pub fn varlong_matches_vanilla_examples() void {
}
    // rust: assert_eq!(round::<i64, VarLong>(0), [0x00]);
    // rust: assert_eq!(
    // rust: round::<i64, VarLong>(2147483647),
    // rust: [0xff, 0xff, 0xff, 0xff, 0x07]
    // rust: );
    // rust: assert_eq!(
    // rust: round::<i64, VarLong>(i64::MAX),
    // rust: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f]
    // rust: );
    // rust: assert_eq!(
    // rust: round::<i64, VarLong>(-1),
    // rust: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x01]
    // rust: );
    // rust: assert_eq!(
    // rust: round::<i64, VarLong>(i64::MIN),
    // rust: [0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x01]
    // rust: );
}

pub fn strings_positions_and_options() void {
}
    // rust: assert_eq!(round::<String, Str>("héllo".into()), b"\x06h\xc3\xa9llo");
    // rust: let mut w = Writer::new();
    // rust: w.string("seventeen chars!!");
    // rust: assert!(Reader::new(&w.data).string(16).is_err());
        // Java counts UTF-16 units: 8 emoji are 16 of them, more than 15.
    // rust: let mut w = Writer::new();
    // rust: w.string(&"😀".repeat(8));
    // rust: assert!(Reader::new(&w.data).string(16).is_ok());
    // rust: assert!(Reader::new(&w.data).string(15).is_err());
    // rust: for p in [
    // rust: [0, 0, 0],
    // rust: [-1, -64, -1],
    // rust: [33_554_431, 2047, -33_554_432],
    // rust: [123, -2048, -456],
    // rust: ] {
    // rust: round::<[i32; 3], Pos>(p);
    // rust: assert_eq!(unpack_block_pos(pack_block_pos(p)), p);
}
        // BlockPos.asLong(1, 2, 3)
    // rust: assert_eq!(pack_block_pos([1, 2, 3]), (1 << 38) | (3 << 12) | 2);
    // rust: round::<[i32; 3], SectionPos>([-5, -4, 1_000]);
    // rust: round::<[i32; 2], ChunkPos>([-7, 12]);
    // rust: round::<Option<String>, Opt<Str>>(Some("x".into()));
    // rust: round::<Option<String>, Opt<Str>>(None);
    // rust: round::<Option<i32>, OptVarInt>(Some(0));
    // rust: round::<Vec<i32>, List<VarInt>>(vec![1, 300, -1]);
    // rust: round::<u128, Uuid>(0x0123_4567_89ab_cdef_0011_2233_4455_6677);
}

pub fn packet_strings_replace_malformed_utf8_like_java() void {
}
        // Captured from the pinned Utf8String.read, including Java's grouping
        // of encoded surrogates (different from String::from_utf8_lossy).
    // rust: for (bytes, expected) in [
    // rust: (&b"\xff"[..], "\u{fffd}"),
    // rust: (&b"\xed\xa0\x80"[..], "\u{fffd}"),
    // rust: (&b"\xed\xa0"[..], "\u{fffd}"),
    // rust: (&b"\xe0\x80\x80"[..], "\u{fffd}\u{fffd}\u{fffd}"),
    // rust: (&b"\xe2\x82A"[..], "\u{fffd}A"),
    // rust: (&b"\xf0\x9f\x98"[..], "\u{fffd}"),
    // rust: ] {
    // rust: let mut packet = Writer::new();
    // rust: packet.byte_array(bytes);
    // rust: packet.u8(42);
    // rust: let mut reader = Reader::new(&packet.data);
    // rust: assert_eq!(reader.string(16).unwrap(), expected, "{bytes:x?}");
    // rust: assert_eq!(reader.u8().unwrap(), 42);
}
}

pub fn replacement_strings_keep_the_length_limits_and_cursor() void {
}
        // Three bytes decode to one replacement, so they fit a one-unit limit.
    // rust: let mut reader = Reader::new(b"\x03\xed\xa0\x80");
    // rust: assert_eq!(reader.string(1).unwrap(), "\u{fffd}");
    // rust: assert_eq!(reader.position(), 4);
        // Two invalid bytes produce two replacements: the decoded limit fails
        // after consuming the string, as Utf8String.read does.
    // rust: let mut reader = Reader::new(b"\x02\xff\xff*");
    // rust: assert!(reader.string(1).is_err());
    // rust: assert_eq!(reader.position(), 3);
    // rust: assert_eq!(reader.u8().unwrap(), 42);
        // Encoded length and truncation failures leave the body unread.
    // rust: for bytes in [&b"\x04\xff\xff\xff\xff"[..], &b"\x02\xff"[..]] {
    // rust: let mut reader = Reader::new(bytes);
    // rust: assert!(reader.string(1).is_err());
    // rust: assert_eq!(reader.position(), 1);
}
}

pub fn bitset_drops_trailing_zero_bytes() void {
}
    // rust: let mut set = vec![0u8; 4];
    // rust: set_bit(&mut set, 3);
    // rust: set_bit(&mut set, 9);
    // rust: let mut w = Writer::new();
    // rust: BitSet::write(&set, &mut w);
    // rust: assert_eq!(w.data, [2, 0b1000, 0b10]);
    // rust: let read = BitSet::read(&mut Reader::new(&w.data)).unwrap();
    // rust: assert!(bit(&read, 3) && bit(&read, 9) && !bit(&read, 4) && !bit(&read, 100));
}

pub fn lp_vec3_round_trips_within_precision() void {
}
    // rust: for v in [
    // rust: [0.0, 0.0, 0.0],
    // rust: [0.1, -0.2, 0.3],
    // rust: [1.5, -3.25, 0.0],
    // rust: [12.0, 0.0, -40.5],
    // rust: [0.0, -3.92, 0.0],
    // rust: ] {
    // rust: let mut w = Writer::new();
    // rust: LpVec3::write(&v, &mut w);
    // rust: let back = LpVec3::read(&mut Reader::new(&w.data)).unwrap();
    // rust: let scale = v.iter().fold(0.0f64, |m, c| m.max(c.abs())).ceil().max(1.0);
    // rust: for i in 0..3 {
    // rust: assert!(
    // rust: (back[i] - v[i]).abs() <= scale / 32766.0 * 1.01,
    // rust: "{v:?} -> {back:?}"
    // rust: );
}
}
        // Zero is a single byte.
    // rust: let mut w = Writer::new();
    // rust: LpVec3::write(&[0.0, 1e-9, 0.0], &mut w);
    // rust: assert_eq!(w.data, [0]);
}

pub fn angles_pack_like_mth() void {
}
    // rust: assert_eq!(pack_degrees(90.0), 64);
    // rust: assert_eq!(pack_degrees(-90.0), -64);
    // rust: assert_eq!(pack_degrees(180.0), -128);
    // rust: assert_eq!(unpack_degrees(64), 90.0);
}
}
