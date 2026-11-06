//! Transpiled from Horizon Rust crate
package horizon_protocol_buf

import "core:fmt"
import "core:mem"
import "core:math"

// Byte buffers with vanilla's primitive encodings (FriendlyByteBuf, VarInt,
// VarLong, ByteBufCodecs) and the `Codec` building blocks packets are
// composed from, mirroring `StreamCodec.composite`.
// use crate::{Error, Result};
// use horizon_world::nbt::{self, Tag};
// use std::marker::PhantomData;

// Vanilla's default NBT quota for network tags (NbtAccounter.defaultQuota).
NBT_QUOTA :: 2_097_152

// A cursor over a received packet body.
Reader :: struct {
    data: ^'a [u8],
    pos: uint,
}
    // rust: impl<'a> Reader<'a> {
new :: proc(data: ^'a [u8]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { data, pos: 0 }
}
remaining :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.data.len() - self.pos
}
position :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.pos
}
    // The bytes read since `start` (a `position()`).
since :: proc(self: ^Self, start: uint) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.data[start.min(self.pos)..self.pos]
}
rest :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let rest = &self.data[self.pos..];
    // rust: self.pos = self.data.len();
    // rust: rest
}
bytes :: proc(self: ^Self, n: uint) -> R {
    // Ported from Horizon
    return {}
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
u8 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.array::<1>()?[0])
}
i8 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.u8()? as i8)
}
bool :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.u8()? != 0)
}
i16 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(i16::from_be_bytes(self.array()?))
}
u16 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(u16::from_be_bytes(self.array()?))
}
i32 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(i32::from_be_bytes(self.array()?))
}
u32 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(u32::from_be_bytes(self.array()?))
}
i64 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(i64::from_be_bytes(self.array()?))
}
f32 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(f32::from_be_bytes(self.array()?))
}
f64 :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(f64::from_be_bytes(self.array()?))
}
    // VarInt.read: at most five 7-bit groups, least significant first.
varint :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
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
    // VarLong.read: at most ten 7-bit groups.
varlong :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
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
    // A VarInt count that must fit in what is left (ByteBufCodecs.readCount).
count :: proc(self: ^Self, max: uint) -> R {
    // Ported from Horizon
    return {}
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
    // Utf8String.read: VarInt byte length, UTF-8, at most `max` chars of Java's
    // String (UTF-16 units: a character outside the BMP counts twice).
string :: proc(self: ^Self, max: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let len = self.count(max.saturating_mul(3))?;
    // rust: let s = packet_utf8(self.bytes(len)?);
    // rust: if s.encode_utf16().count() > max {
    // rust: return Err(Error::new(format!("string longer than {max} chars")));
}
    // rust: Ok(s)
}
byte_array :: proc(self: ^Self, max: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let len = self.count(max)?;
    // rust: Ok(self.bytes(len)?.to_vec())
}
uuid :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(u128::from_be_bytes(self.array()?))
}
    // A network NBT tag (NbtIo.readAnyTag without a root name); `End` means none.
nbt :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
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
long_array :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = self.count(self.remaining() / 8)?;
    // rust: (0..n).map(|_| self.i64()).collect()
}
fixed_longs :: proc(self: ^Self, n: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.remaining() < n * 8 {
    // rust: return Err(Error::new("fixed long array past the end"));
}
    // rust: (0..n).map(|_| self.i64()).collect()
}
}

// Java's UTF-8 replacement decoder, as used by Utf8String.read. Most malformed
// sequences have Rust's maximal-subpart grouping, but Java consumes an encoded
// surrogate (including its truncated two-byte prefix) as one replacement.
packet_utf8 :: proc(mut bytes: []u8) -> S {
    // Ported from Horizon
    return {}
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

// An outgoing packet body.
Writer :: struct {
    data: [dynamic]u8,
}
    // rust: impl Writer {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::default()
}
u8 :: proc(self: ^Self, v: u8) {
}
    // rust: self.data.push(v);
}
i8 :: proc(self: ^Self, v: i8) {
}
    // rust: self.data.push(v as u8);
}
bool :: proc(self: ^Self, v: bool) {
}
    // rust: self.data.push(u8::from(v));
}
i16 :: proc(self: ^Self, v: i16) {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
u16 :: proc(self: ^Self, v: u16) {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
i32 :: proc(self: ^Self, v: i32) {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
u32 :: proc(self: ^Self, v: u32) {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
i64 :: proc(self: ^Self, v: i64) {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
f32 :: proc(self: ^Self, v: f32) {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
f64 :: proc(self: ^Self, v: f64) {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
varint :: proc(self: ^Self, v: i32) {
}
    // rust: write_varint(&mut self.data, v);
}
varlong :: proc(self: ^Self, v: i64) {
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
string :: proc(self: ^Self, s: string) {
}
    // rust: self.varint(s.len() as i32);
    // rust: self.data.extend_from_slice(s.as_bytes());
}
byte_array :: proc(self: ^Self, b: []u8) {
}
    // rust: self.varint(b.len() as i32);
    // rust: self.data.extend_from_slice(b);
}
bytes :: proc(self: ^Self, b: []u8) {
}
    // rust: self.data.extend_from_slice(b);
}
uuid :: proc(self: ^Self, v: u128) {
}
    // rust: self.data.extend_from_slice(&v.to_be_bytes());
}
nbt :: proc(self: ^Self, tag: ^Tag) {
}
    // rust: match nbt::write_network(tag, nbt::Limits::default()) {
    // rust: Ok(bytes) => self.data.extend_from_slice(&bytes),
            // Unencodable tags (too deep) are sent as "no tag".
    // rust: Err(_) => self.data.push(0),
}
}
long_array :: proc(self: ^Self, v: ^[i64]) {
}
    // rust: self.varint(v.len() as i32);
    // rust: for &l in v {
    // rust: self.i64(l);
}
}
}
write_varint :: proc(out: ^[dynamic]u8, v: i32) {
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
varint_size :: proc(v: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let v = v as u32;
    // rust: (1..5).find(|i| v >> (7 * i) == 0).unwrap_or(5)
}

// A wire encoding for values of type `T` (vanilla's StreamCodec).
    // rust: pub trait Codec<T> {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
write :: proc(v: ^T, w: ^Writer) {
}
}
    // rust: macro_rules! primitive {
    // rust: ($name:ident, $ty:ty, $read:ident, $write:ident) => {
    // rust: pub struct $name;
    // rust: impl Codec<$ty> for $name {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.$read()
}
write :: proc(v: ^$ty, w: ^Writer) {
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

// ByteBufCodecs.STRING_UTF8 (32767 chars).
Str :: struct {
    // rust: impl Codec<String> for Str {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.string(32767)
}
write :: proc(v: ^string, w: ^Writer) {
}
    // rust: w.string(v)
}
}
// A string with a smaller vanilla limit, e.g. player names (16).
StrN :: struct {
    // rust: impl<const N: usize> Codec<String> for StrN<N> {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.string(N)
}
write :: proc(v: ^string, w: ^Writer) {
}
    // rust: w.string(v)
}
}
// Identifier.STREAM_CODEC: a resource location string.
    // rust: pub type Ident = StrN<32767>;
// VarInt-prefixed bytes.
Bytes :: struct {
    // rust: impl Codec<Vec<u8>> for Bytes {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.byte_array(r.remaining())
}
write :: proc(v: ^[dynamic]u8, w: ^Writer) {
}
    // rust: w.byte_array(v)
}
}
// ByteBufCodecs.byteArray(N): VarInt-prefixed bytes, at most N.
BytesN :: struct {
    // rust: impl<const N: usize> Codec<Vec<u8>> for BytesN<N> {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.byte_array(N)
}
write :: proc(v: ^[dynamic]u8, w: ^Writer) {
}
    // rust: w.byte_array(v)
}
}
// Everything left in the packet (custom payloads).
Rest :: struct {
    // rust: impl Codec<Vec<u8>> for Rest {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(r.rest().to_vec())
}
write :: proc(v: ^[dynamic]u8, w: ^Writer) {
}
    // rust: w.bytes(v)
}
}
// Any network NBT tag (`Tag::End` when absent).
Nbt :: struct {
    // rust: impl Codec<Tag> for Nbt {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.nbt()
}
write :: proc(v: ^Tag, w: ^Writer) {
}
    // rust: w.nbt(v)
}
}
// ByteBufCodecs.LONG_ARRAY.
Longs :: struct {
    // rust: impl Codec<Vec<i64>> for Longs {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.long_array()
}
write :: proc(v: ^[dynamic]i64, w: ^Writer) {
}
    // rust: w.long_array(v)
}
}
// ByteBufCodecs.list(): VarInt count then elements.
List :: struct {
    // rust: impl<T, C: Codec<T>> Codec<Vec<T>> for List<C> {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let n = r.count(r.remaining())?;
    // rust: (0..n).map(|_| C::read(r)).collect()
}
write :: proc(v: ^[dynamic]T, w: ^Writer) {
}
    // rust: w.varint(v.len() as i32);
    // rust: for e in v {
    // rust: C::write(e, w);
}
}
}
// ByteBufCodecs.optional(): a boolean presence flag.
Opt :: struct {
    // rust: impl<T, C: Codec<T>> Codec<Option<T>> for Opt<C> {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if r.bool()? {
    // rust: Ok(Some(C::read(r)?))
    // rust: } else {
    // rust: Ok(None)
}
}
write :: proc(v: ^Maybe(T), w: ^Writer) {
}
    // rust: w.bool(v.is_some());
    // rust: if let Some(v) = v {
    // rust: C::write(v, w);
}
}
}
// ByteBufCodecs.OPTIONAL_VAR_INT: 0 = empty, otherwise value + 1.
OptVarInt :: struct {
    // rust: impl Codec<Option<i32>> for OptVarInt {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let v = r.varint()?;
    // rust: Ok(if v == 0 { None } else { Some(v - 1) })
}
write :: proc(v: ^Maybe(i32), w: ^Writer) {
}
    // rust: w.varint(v.map_or(0, |v| v + 1))
}
}
// Vec3i.STREAM_CODEC: three var ints.
VarVec3i :: struct {
    // rust: impl Codec<[i32; 3]> for VarVec3i {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok([r.varint()?, r.varint()?, r.varint()?])
}
write :: proc(v: ^[i32; 3], w: ^Writer) {
}
    // rust: for n in v {
    // rust: w.varint(*n);
}
}
}
// Vec3.STREAM_CODEC: three doubles.
Vec3d :: struct {
    // rust: impl Codec<[f64; 3]> for Vec3d {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok([r.f64()?, r.f64()?, r.f64()?])
}
write :: proc(v: ^[f64; 3], w: ^Writer) {
}
    // rust: for c in v {
    // rust: w.f64(*c);
}
}
}
// BlockPos.STREAM_CODEC: x (26 bits), z (26 bits), y (12 bits) in one long.
Pos :: struct {
    // rust: impl Codec<[i32; 3]> for Pos {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(unpack_block_pos(r.i64()?))
}
write :: proc(v: ^[i32; 3], w: ^Writer) {
}
    // rust: w.i64(pack_block_pos(*v))
}
}
pack_block_pos :: proc(p: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: ((i64::from(p[0]) & 0x3FF_FFFF) << 38)
    // rust: | ((i64::from(p[2]) & 0x3FF_FFFF) << 12)
    // rust: | (i64::from(p[1]) & 0xFFF)
}
unpack_block_pos :: proc(v: i64) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: (v >> 38) as i32,
    // rust: (v << 52 >> 52) as i32,
    // rust: (v << 26 >> 38) as i32,
    // rust: ]
}
// ChunkPos packed as x in the low and z in the high 32 bits.
ChunkPos :: struct {
    // rust: impl Codec<[i32; 2]> for ChunkPos {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let v = r.i64()?;
    // rust: Ok([v as i32, (v >> 32) as i32])
}
write :: proc(v: ^[i32; 2], w: ^Writer) {
}
    // rust: w.i64((i64::from(v[0]) & 0xFFFF_FFFF) | (i64::from(v[1]) << 32))
}
}
// SectionPos: x (22 bits), z (22 bits), y (20 bits).
SectionPos :: struct {
    // rust: impl Codec<[i32; 3]> for SectionPos {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let v = r.i64()?;
    // rust: Ok([
    // rust: (v >> 42) as i32,
    // rust: (v << 44 >> 44) as i32,
    // rust: (v << 22 >> 42) as i32,
    // rust: ])
}
write :: proc(v: ^[i32; 3], w: ^Writer) {
}
    // rust: w.i64(
    // rust: ((i64::from(v[0]) & 0x3F_FFFF) << 42)
    // rust: | ((i64::from(v[2]) & 0x3F_FFFF) << 20)
    // rust: | (i64::from(v[1]) & 0xF_FFFF),
    // rust: )
}
}
// ByteBufCodecs.BIT_SET: java.util.BitSet as a VarInt-prefixed byte array.
BitSet :: struct {
    // rust: impl Codec<Vec<u8>> for BitSet {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
}
    // rust: r.byte_array(r.remaining())
}
write :: proc(v: ^[dynamic]u8, w: ^Writer) {
}
        // BitSet.toByteArray drops trailing zero bytes.
    // rust: let len = v.iter().rposition(|&b| b != 0).map_or(0, |i| i + 1);
    // rust: w.byte_array(&v[..len])
}
}
bit :: proc(set: []u8, i: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: set.get(i / 8).is_some_and(|b| b >> (i % 8) & 1 != 0)
}
set_bit :: proc(set: ^[dynamic]u8, i: uint) {
}
    // rust: if set.len() <= i / 8 {
    // rust: set.resize(i / 8 + 1, 0);
}
    // rust: set[i / 8] |= 1 << (i % 8);
}
// LpVec3: a low-precision velocity (Vec3.LP_STREAM_CODEC).
LpVec3 :: struct {
    // rust: impl LpVec3 {
unpack :: proc(v: u64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((v & 32767) as f64).min(32766.0) * 2.0 / 32766.0 - 1.0
}
pack :: proc(v: f64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((v * 0.5 + 0.5) * 32766.0).round() as u64
}
    // `v` as a reader decodes it after it was written.
quantize :: proc(v: [f64; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut w = Writer::new();
    // rust: Self::write(&v, &mut w);
    // rust: Self::read(&mut Reader::new(&w.data)).unwrap_or([0.0; 3])
}
sanitize :: proc(v: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_nan() {
    // rust: 0.0
    // rust: } else {
    // rust: v.clamp(-1.717_986_918_3e10, 1.717_986_918_3e10)
}
}
}
    // rust: impl Codec<[f64; 3]> for LpVec3 {
read :: proc(r: ^Reader) -> R {
    // Ported from Horizon
    return {}
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
write :: proc(v: ^[f64; 3], w: ^Writer) {
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
// A degree angle sent as a byte (Mth.packDegrees / unpackDegrees).
pack_degrees :: proc(deg: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (deg * 256.0 / 360.0).floor() as i32 as i8
}
unpack_degrees :: proc(b: i8) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f32::from(b) * 360.0 / 256.0
}

// Define a packet struct and its codec from (field: type => codec) triples,
// like vanilla's `StreamCodec.composite`.
    // rust: macro_rules! packet {
    // rust: ($(#[$meta:meta])* $name:ident { $($field:ident : $ty:ty => $codec:ty),* $(,)? }) => {
    // rust: $(#[$meta])*
    // rust: pub struct $name {
    // rust: $(pub $field: $ty),*
}
    // rust: impl $crate::buf::Codec<$name> for $name {
read :: proc(r: ^$crate::buf::Reader) -> $ {
    // Ported from Horizon
    return {}
}
    // rust: Ok($name { $($field: <$codec as $crate::buf::Codec<$ty>>::read(r)?),* })
}
write :: proc(v: ^$name, w: ^$crate::buf::Writer) {
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

varint_matches_vanilla_examples :: proc() {
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

varlong_matches_vanilla_examples :: proc() {
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

strings_positions_and_options :: proc() {
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

packet_strings_replace_malformed_utf8_like_java :: proc() {
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

replacement_strings_keep_the_length_limits_and_cursor :: proc() {
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

bitset_drops_trailing_zero_bytes :: proc() {
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

lp_vec3_round_trips_within_precision :: proc() {
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

angles_pack_like_mth :: proc() {
}
    // rust: assert_eq!(pack_degrees(90.0), 64);
    // rust: assert_eq!(pack_degrees(-90.0), -64);
    // rust: assert_eq!(pack_degrees(180.0), -128);
    // rust: assert_eq!(unpack_degrees(64), 90.0);
}
}
