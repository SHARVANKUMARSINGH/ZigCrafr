//! Transpiled from Horizon Rust crate
package horizon_protocol_hash_ops

import "core:fmt"
import "core:mem"
import "core:math"

// `net.minecraft.util.HashOps` over Guava's CRC32C: the canonical hash of a
// codec-encoded value that `HashedStack` sends for each data component.
//
// Vanilla runs a `Codec` against `HashOps` (a `DynamicOps<HashCode>`), so every
// value is hashed as its codec form: a tag byte per type, map entries sorted by
// their hashes, lists in order. The functions here are `HashOps`' `create*`
// methods and its record builder; a component's codec form is built from them.
// use horizon_world::nbt::Tag;

// Guava `Hashing.crc32c()`: the CRC-32C (Castagnoli) of the bytes.
crc32c :: proc(bytes: []u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: const TABLE: [u32; 256] = {
    // rust: let mut table = [0u32; 256];
    // rust: let mut i = 0;
    // rust: while i < 256 {
    // rust: let mut crc = i as u32;
    // rust: let mut bit = 0;
    // rust: while bit < 8 {
    // rust: crc = if crc & 1 != 0 {
    // rust: (crc >> 1) ^ 0x82F6_3B78
    // rust: } else {
    // rust: crc >> 1
}
    // rust: bit += 1;
}
    // rust: table[i] = crc;
    // rust: i += 1;
}
    // rust: table
}
    // rust: let mut crc = !0u32;
    // rust: for &b in bytes {
    // rust: crc = TABLE[((crc ^ b as u32) & 0xFF) as usize] ^ (crc >> 8);
}
    // rust: !crc
}

// A Guava `HashCode` of CRC32C: four bytes (`IntHashCode`).
HashCode :: struct {
    // rust: impl HashCode {
    // `HashCode.asInt`: what `HashedPatchMap` sends for a component.
as_int :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0 as i32
}
    // `HashCode.asBytes`: little-endian, as `IntHashCode` stores it.
as_bytes :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.0.to_le_bytes()
}
}

// A Guava `Hasher`: little-endian primitives, then the CRC of everything put.
Hasher :: struct {
    // rust: impl Hasher {
byte :: proc(v: u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.0.push(v);
    // rust: self
}
bytes :: proc(v: []u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.0.extend_from_slice(v);
    // rust: self
}
hash :: proc(self: ^Self) -> H {
    // Ported from Horizon
    return {}
}
    // rust: HashCode(crc32c(&self.0))
}
}

// `HashOps.CRC32C_INSTANCE`.
HashOps :: struct {
    // rust: impl HashOps {
    // `HashOps.empty`: the hash of the payload `[TAG_EMPTY]`.
empty :: proc() -> H {
    // Ported from Horizon
    return {}
}
    Hasher: :default().byte(1).hash(),
}
empty_map :: proc() -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(2).byte(3).hash()
}
empty_list :: proc() -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(4).byte(5).hash()
}
create_byte :: proc(v: i8) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(6).byte(v as u8).hash()
}
create_short :: proc(v: i16) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(7).bytes(&v.to_le_bytes()).hash()
}
create_int :: proc(v: i32) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(8).bytes(&v.to_le_bytes()).hash()
}
create_long :: proc(v: i64) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(9).bytes(&v.to_le_bytes()).hash()
}
    // From the float's raw bits (`putFloat` writes `floatToRawIntBits`).
create_float :: proc(bits: u32) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(10).bytes(&bits.to_le_bytes()).hash()
}
create_double :: proc(bits: u64) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(11).bytes(&bits.to_le_bytes()).hash()
}
create_f32 :: proc(v: f32) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Self::create_float(v.to_bits())
}
    // `createString`: the length in UTF-16 units, then each unit (`putUnencodedChars`).
create_string_units :: proc(units: ^[u16]) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let mut h = Hasher::default()
    // rust: .byte(12)
    // rust: .bytes(&(units.len() as i32).to_le_bytes());
    // rust: for u in units {
    // rust: h = h.bytes(&u.to_le_bytes());
}
    // rust: h.hash()
}
create_string :: proc(v: string) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let units: Vec<u16> = v.encode_utf16().collect();
    // rust: Self::create_string_units(&units)
}
create_boolean :: proc(v: bool) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(13).byte(v as u8).hash()
}
    // `createMap`: the entries sorted by key hash, then value hash (both as
    // unsigned ints, `HashCode.padToLong`).
create_map :: proc(mut entries: Vec<(HashCode) {
}
    // rust: entries.sort_by_key(|(k, v)| (k.0, v.0));
    // rust: let mut h = Hasher::default().byte(2);
    // rust: for (k, v) in entries {
    // rust: h = h.bytes(&k.as_bytes()).bytes(&v.as_bytes());
}
    // rust: h.byte(3).hash()
}
create_list :: proc(values: impl IntoIterator<Item = HashCode>) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let mut h = Hasher::default().byte(4);
    // rust: for v in values {
    // rust: h = h.bytes(&v.as_bytes());
}
    // rust: h.byte(5).hash()
}
create_byte_list :: proc(values: []u8) -> H {
    // Ported from Horizon
    return {}
}
    // rust: Hasher::default().byte(14).bytes(values).byte(15).hash()
}
create_int_list :: proc(values: ^[i32]) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let mut h = Hasher::default().byte(16);
    // rust: for v in values {
    // rust: h = h.bytes(&v.to_le_bytes());
}
    // rust: h.byte(17).hash()
}
create_long_list :: proc(values: ^[i64]) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let mut h = Hasher::default().byte(18);
    // rust: for v in values {
    // rust: h = h.bytes(&v.to_le_bytes());
}
    // rust: h.byte(19).hash()
}

    // `NbtOps.convertTo(HashOps, tag)`: how an NBT-valued codec (`CompoundTag.CODEC`,
    // so `custom_data`) is hashed. `bool_keys` names the compound keys whose byte
    // value is a `Codec.BOOL` (`NbtOps.createBoolean` writes a byte, `HashOps` hashes
    // a boolean), for the text component codec.
from_nbt :: proc(tag: ^Tag, bool_keys: ^[string]) -> H {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::End => Self::empty(),
    // rust: Tag::Byte(v) => Self::create_byte(*v),
    // rust: Tag::Short(v) => Self::create_short(*v),
    // rust: Tag::Int(v) => Self::create_int(*v),
    // rust: Tag::Long(v) => Self::create_long(*v),
    // rust: Tag::Float(bits) => Self::create_float(*bits),
    // rust: Tag::Double(bits) => Self::create_double(*bits),
    // rust: Tag::ByteArray(v) => Self::create_byte_list(v),
    // rust: Tag::String(s) => Self::create_string_units(&s.0),
    // rust: Tag::List(items) => {
    // rust: Self::create_list(items.iter().map(|t| Self::from_nbt(t, bool_keys)))
}
    // rust: Tag::Compound(map) => Self::create_map(
    // rust: map.iter()
    // rust: .map(|(k, v)| {
    // rust: let value = match v {
    // rust: Tag::Byte(b)
    // rust: if bool_keys
    // rust: .iter()
    // rust: .any(|n| k.0.iter().copied().eq(n.encode_utf16())) =>
    // rust: {
    // rust: Self::create_boolean(*b != 0)
}
    // rust: _ => Self::from_nbt(v, bool_keys),
}
    // rust: (Self::create_string_units(&k.0), value)
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: Tag::IntArray(v) => Self::create_int_list(v),
    // rust: Tag::LongArray(v) => Self::create_long_list(v),
}
}
}

// `HashOps.MapHashBuilder`: a record codec's fields, hashed as a map. A field
// that is `None` is absent, as `optionalFieldOf` leaves it out.
RecordHash :: struct {
    // rust: impl RecordHash {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    Self: :default(),
}
field :: proc(name: string, value: HashCode) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.0.push((HashOps::create_string(name), value));
    // rust: self
}
optional :: proc(self: ^Self, name: string, value: Maybe(HashCode)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match value {
    // rust: Some(v) => self.field(name, v),
    // rust: None => self,
}
}
build :: proc(self: ^Self) -> H {
    // Ported from Horizon
    return {}
}
    // rust: HashOps::create_map(self.0)
}
}

    // rust: mod tests {
//     use super::*;

    // The CRC-32C check value (RFC 3720, appendix B.4).
crc32c_matches_the_standard_check_value :: proc() {
}
    // rust: assert_eq!(crc32c(b"123456789"), 0xE306_9283);
    // rust: assert_eq!(crc32c(&[0u8; 32]), 0x8A91_36AA);
    // rust: assert_eq!(crc32c(&[0xFFu8; 32]), 0x62A8_AB43);
}

the_fixed_payload_hashes_are_the_crc_of_their_bytes :: proc() {
}
    // rust: assert_eq!(HashOps::empty(), HashCode(crc32c(&[1])));
    // rust: assert_eq!(HashOps::empty_map(), HashCode(crc32c(&[2, 3])));
    // rust: assert_eq!(HashOps::empty_list(), HashCode(crc32c(&[4, 5])));
    // rust: assert_eq!(HashOps::create_boolean(false), HashCode(crc32c(&[13, 0])));
    // rust: assert_eq!(HashOps::create_boolean(true), HashCode(crc32c(&[13, 1])));
        // An empty map builds to the same hash as the constant.
    // rust: assert_eq!(RecordHash::new().build(), HashOps::empty_map());
    // rust: assert_eq!(HashOps::create_list([]), HashOps::empty_list());
}

primitives_are_a_tag_byte_and_little_endian_payload :: proc() {
}
    // rust: assert_eq!(HashOps::create_int(1), HashCode(crc32c(&[8, 1, 0, 0, 0])));
    // rust: assert_eq!(
    // rust: HashOps::create_short(-2),
    // rust: HashCode(crc32c(&[7, 0xFE, 0xFF]))
    // rust: );
    // rust: assert_eq!(HashOps::create_byte(-1), HashCode(crc32c(&[6, 0xFF])));
    // rust: assert_eq!(
    // rust: HashOps::create_long(1),
    // rust: HashCode(crc32c(&[9, 1, 0, 0, 0, 0, 0, 0, 0]))
    // rust: );
        // 1.0f is 0x3F800000.
    // rust: assert_eq!(
    // rust: HashOps::create_f32(1.0),
    // rust: HashCode(crc32c(&[10, 0, 0, 0x80, 0x3F]))
    // rust: );
        // Strings: their UTF-16 length, then each unit.
    // rust: assert_eq!(
    // rust: HashOps::create_string("ab"),
    // rust: HashCode(crc32c(&[12, 2, 0, 0, 0, b'a', 0, b'b', 0]))
    // rust: );
        // A non-BMP character is two units.
    // rust: assert_eq!(
    // rust: HashOps::create_string("\u{1F600}"),
    // rust: HashCode(crc32c(&[12, 2, 0, 0, 0, 0x3D, 0xD8, 0x00, 0xDE]))
    // rust: );
}

maps_sort_their_entries_by_unsigned_hash_and_lists_keep_order :: proc() {
}
    // rust: let a = (HashOps::create_string("a"), HashOps::create_int(1));
    // rust: let b = (HashOps::create_string("b"), HashOps::create_int(2));
    // rust: assert_eq!(
    // rust: HashOps::create_map(vec![a, b]),
    // rust: HashOps::create_map(vec![b, a])
    // rust: );
    // rust: let (first, second) = if a.0.0 < b.0.0 { (a, b) } else { (b, a) };
    // rust: let mut bytes = vec![2];
    // rust: for (k, v) in [first, second] {
    // rust: bytes.extend(k.as_bytes());
    // rust: bytes.extend(v.as_bytes());
}
    // rust: bytes.push(3);
    // rust: assert_eq!(HashOps::create_map(vec![b, a]), HashCode(crc32c(&bytes)));
    // rust: let (x, y) = (HashOps::create_int(1), HashOps::create_int(2));
    // rust: assert_ne!(HashOps::create_list([x, y]), HashOps::create_list([y, x]));
}

nbt_converts_like_nbt_ops_convert_to :: proc() {
}
    // rust: let tag = Tag::compound([
    // rust: ("n", Tag::Int(7)),
    // rust: ("l", Tag::List(vec![Tag::Byte(1)])),
    // rust: ("flag", Tag::Byte(1)),
    // rust: ]);
    // rust: let expected = HashOps::create_map(vec![
    // rust: (HashOps::create_string("n"), HashOps::create_int(7)),
    // rust: (
    // rust: HashOps::create_string("l"),
    // rust: HashOps::create_list([HashOps::create_byte(1)]),
    // rust: ),
    // rust: (HashOps::create_string("flag"), HashOps::create_byte(1)),
    // rust: ]);
    // rust: assert_eq!(HashOps::from_nbt(&tag, &[]), expected);
        // A text component's `bold` is a boolean in the hash.
    // rust: let text = Tag::compound([("bold", Tag::Byte(1))]);
    // rust: assert_eq!(
    // rust: HashOps::from_nbt(&text, &["bold"]),
    // rust: HashOps::create_map(vec![(
    // rust: HashOps::create_string("bold"),
    // rust: HashOps::create_boolean(true)
    // rust: )])
    // rust: );
    // rust: assert_eq!(
    // rust: HashOps::from_nbt(&Tag::List(vec![]), &[]),
    // rust: HashOps::empty_list()
    // rust: );
    // rust: assert_eq!(
    // rust: HashOps::from_nbt(&Tag::IntArray(vec![1, 2]), &[]),
    // rust: HashCode(crc32c(&[16, 1, 0, 0, 0, 2, 0, 0, 0, 17]))
    // rust: );
}

    // Values printed by vanilla's own `HashOps.CRC32C_INSTANCE` (`Codec.X.encodeStart`
    // then `HashCode.asInt`) on the pinned 26.3 jars.
matches_the_hashes_vanilla_prints :: proc() {
}
    // rust: assert_eq!(HashOps::create_int(1).as_int(), 1565579036);
    // rust: assert_eq!(HashOps::create_string("ab").as_int(), 1228822133);
    // rust: assert_eq!(HashOps::create_f32(1.0).as_int(), 1694772624);
    // rust: assert_eq!(HashOps::create_boolean(true).as_int(), -1019818302);
    // rust: let ints = [1, 2, 3].map(HashOps::create_int);
    // rust: assert_eq!(HashOps::create_list(ints).as_int(), -1179931408);
    // rust: assert_eq!(HashOps::create_list([]).as_int(), -1978007022);
        // `Unit.CODEC` encodes an empty map.
    // rust: assert_eq!(HashOps::empty_map().as_int(), -982207288);
        // CompoundTag.CODEC: {n: 7, flag: 1b, s: "hi", l: [1b], ia: [I;1,2], d: 0.5}.
    // rust: let tag = Tag::compound([
    // rust: ("n", Tag::Int(7)),
    // rust: ("flag", Tag::Byte(1)),
    // rust: ("s", Tag::String("hi".into())),
    // rust: ("l", Tag::List(vec![Tag::Byte(1)])),
    // rust: ("ia", Tag::IntArray(vec![1, 2])),
    // rust: ("d", Tag::Double(0.5f64.to_bits())),
    // rust: ]);
    // rust: assert_eq!(HashOps::from_nbt(&tag, &[]).as_int(), 675583264);
}
}
