//! Transpiled from Horizon Rust crate
//! Module: horizon-world_nbt
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Java Edition NBT with lossless UTF-16 strings and 26.3 mixed-list wrappers.
// use std::collections::BTreeMap;

/// Java strings can contain unpaired surrogates, which Rust UTF-8 strings cannot.
pub const JavaString = struct {};

    // rust: impl From<&str> for JavaString {
pub fn from(value: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(value.encode_utf16().collect())
}
}
/// `key` in UTF-16 in a buffer kept per thread, to search a compound
/// without allocating a key every time.
    // rust: fn with_key<R>(key: &str, f: impl FnOnce(&JavaString) -> R) -> R {
    // rust: thread_local! {
pub const KEY: std::cell::RefCell<JavaString> = Default::default();
}
    // rust: KEY.with_borrow_mut(|units| {
    // rust: units.0.clear();
    // rust: units.0.extend(key.encode_utf16());
    // rust: f(units)
    // rust: })
}

    // rust: impl JavaString {
pub fn to_string(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: String::from_utf16(&self.0)
}
pub fn to_string_lossy(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: String::from_utf16_lossy(&self.0)
}
}

    // rust: pub type Compound = BTreeMap<JavaString, Tag>;

/// Float and double variants hold their IEEE bit patterns. Java's disk output
/// canonicalizes NaNs (`DataOutputStream.writeFloat`); its network output
/// keeps their bits (Netty's `ByteBuf.writeFloat`). Loading, like vanilla's
/// valueOf factories, normalizes negative zero to positive zero.
pub const Tag = enum {
    End,
    Byte(i8),
    Short(i16),
    Int(i32),
    Long(i64),
    Float(u32),
    Double(u64),
    ByteArray(Vec<u8>),
    String(JavaString),
    List(Vec<Tag>),
    Compound(Compound),
    IntArray(Vec<i32>),
    LongArray(Vec<i64>),
};

    // rust: impl Tag {
pub fn id(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::End => 0,
    // rust: Self::Byte(_) => 1,
    // rust: Self::Short(_) => 2,
    // rust: Self::Int(_) => 3,
    // rust: Self::Long(_) => 4,
    // rust: Self::Float(_) => 5,
    // rust: Self::Double(_) => 6,
    // rust: Self::ByteArray(_) => 7,
    // rust: Self::String(_) => 8,
    // rust: Self::List(_) => 9,
    // rust: Self::Compound(_) => 10,
    // rust: Self::IntArray(_) => 11,
    // rust: Self::LongArray(_) => 12,
}
}
pub fn get(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Compound(map) => with_key(key, |key| map.get(key)),
    // rust: _ => None,
}
}
pub fn get_mut(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Compound(map) => with_key(key, |key| map.get_mut(key)),
    // rust: _ => None,
}
}
pub fn compound(entries: impl IntoIterator<Item = (impl Into<JavaString>) void {
}
    // rust: Self::Compound(entries.into_iter().map(|(k, v)| (k.into(), v)).collect())
}
}

pub const NamedTag = struct {
    name: JavaString,
    tag: Tag,
};

pub const Limits = struct {
    max_bytes: usize,
    max_nodes: usize,
    max_depth: usize,
};
    // rust: impl Default for Limits {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: max_bytes: 64 * 1024 * 1024,
    // rust: max_nodes: 1_000_000,
    // rust: max_depth: 512,
}
}
}
    // rust: impl Limits {
    /// The prepared per-state block tables (`cached-collision.nbt`,
    /// `block-properties.nbt`, ...): trusted files with a row per block
    /// state, which content mods' states grow past the default caps
    /// (vanilla's 35,723 states fill about a tenth of these; ATM10's ported
    /// mods, 193,762 states, about half).
pub fn tables() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: max_bytes: 1 << 30,
    // rust: max_nodes: 128_000_000,
    // rust: max_depth: 512,
}
}

    /// Chunks, entities, POI and the world's `.dat` files: vanilla reads and
    /// writes them with `NbtAccounter.unlimitedHeap()` (`NbtIo.read`), so a
    /// chunk past the default node cap (a few thousand full containers) still
    /// loads. The byte cap stays as the only guard on the decompressed data.
pub fn saved() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: max_bytes: 1 << 30,
    // rust: max_nodes: usize::MAX,
    // rust: max_depth: 512,
}
}

    /// Structure templates (`structure/*.nbt`): vanilla reads them with
    /// `NbtAccounter.unlimitedHeap()` (TemplateSource.readStructure), and
    /// mods ship templates past the default node cap (YUNG's Better Ocean
    /// Monuments' start piece, 115x64x126 blocks, holds millions of tags).
    /// The byte cap stays as the only guard on the decompressed file.
pub fn templates() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: max_bytes: 1 << 28,
    // rust: max_nodes: usize::MAX,
    // rust: max_depth: 512,
}
}
}

pub const Error = struct {
    offset: usize,
    reason: *'static str,
};
    // rust: impl std::fmt::Display for Error {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "NBT at byte {}: {}", self.offset, self.reason)
}
}
    // rust: impl std::error::Error for Error {}

/// Hands a streamed list's elements to the caller one at a time (see
/// [`read_named_streaming`]).
    // rust: type Visit<'s> = &'s mut dyn FnMut(&mut ListElements<'_, '_, '_>) -> Result<(), Error>;

pub const Reader = struct {
    bytes: *'a [u8],
    offset: usize,
    limits: Limits,
    nodes: usize,
    /// Lists with this key in the root compound or in a compound directly
    /// under it are streamed to the visitor instead of kept.
    stream: Option<(*'s str,
};
    // rust: impl<'a> Reader<'a, '_> {
pub fn error(self: *Self, reason: *'static str) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Error {
    // rust: offset: self.offset,
    // rust: reason,
}
}
pub fn take(self: *Self, len: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let end = self
    // rust: .offset
    // rust: .checked_add(len)
    // rust: .ok_or_else(|| self.error("length overflow"))?;
    // rust: if end > self.limits.max_bytes {
    // rust: return Err(self.error("byte limit exceeded"));
}
    // rust: let value = self
    // rust: .bytes
    // rust: .get(self.offset..end)
    // rust: .ok_or_else(|| self.error("truncated input"))?;
    // rust: self.offset = end;
    // rust: Ok(value)
}
    // rust: fn number<const N: usize>(&mut self) -> Result<[u8; N], Error> {
    // rust: Ok(self.take(N)?.try_into().unwrap())
}
pub fn byte(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.take(1)?[0])
}
pub fn count(self: *Self, element_bytes: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let count = i32::from_be_bytes(self.number()?);
    // rust: if count < 0 {
    // rust: return Err(self.error("negative collection length"));
}
    // rust: let count = count as usize;
    // rust: let size = count
    // rust: .checked_mul(element_bytes)
    // rust: .ok_or_else(|| self.error("length overflow"))?;
    // rust: if size > self.bytes.len().saturating_sub(self.offset)
    // rust: || size > self.limits.max_bytes.saturating_sub(self.offset)
    // rust: {
    // rust: return Err(self.error("collection exceeds available bytes"));
}
    // rust: Ok(count)
}
pub fn string(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = u16::from_be_bytes(self.number()?) as usize;
    // rust: let bytes = self.take(len)?;
    // rust: modified_utf8(bytes).ok_or_else(|| self.error("invalid Java modified UTF-8"))
}
    /// `StringTag.skipString`: vanilla skips a file root's name unread, so a
    /// name that isn't modified UTF-8 is read as empty rather than refused.
pub fn root_name(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = u16::from_be_bytes(self.number()?) as usize;
    // rust: Ok(modified_utf8(self.take(len)?).unwrap_or_default())
}
pub fn payload(self: *Self, id: u8, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.nodes >= self.limits.max_nodes {
    // rust: return Err(self.error("node limit exceeded"));
}
    // rust: self.nodes += 1;
    // rust: if matches!(id, 9 | 10) && depth >= self.limits.max_depth {
    // rust: return Err(self.error("depth limit exceeded"));
}
    // rust: Ok(match id {
    // rust: 0 => Tag::End,
    // rust: 1 => Tag::Byte(self.byte()? as i8),
    // rust: 2 => Tag::Short(i16::from_be_bytes(self.number()?)),
    // rust: 3 => Tag::Int(i32::from_be_bytes(self.number()?)),
    // rust: 4 => Tag::Long(i64::from_be_bytes(self.number()?)),
    // rust: 5 => {
    // rust: let bits = u32::from_be_bytes(self.number()?);
    // rust: Tag::Float(if f32::from_bits(bits) == 0.0 { 0 } else { bits })
}
    // rust: 6 => {
    // rust: let bits = u64::from_be_bytes(self.number()?);
    // rust: Tag::Double(if f64::from_bits(bits) == 0.0 { 0 } else { bits })
}
    // rust: 7 => {
    // rust: let len = self.count(1)?;
    // rust: Tag::ByteArray(self.take(len)?.to_vec())
}
    // rust: 8 => Tag::String(self.string()?),
    // rust: 9 => {
    // rust: let element_id = self.byte()?;
    // rust: let len = self.count(0)?;
    // rust: if len > 0 && (element_id == 0 || element_id > 12) {
    // rust: return Err(self.error("invalid list element type"));
}
    // rust: if len > self.limits.max_nodes.saturating_sub(self.nodes) {
    // rust: return Err(self.error("node limit exceeded"));
}
                // At least one byte per valid non-End payload; do not allocate from an unchecked count.
    // rust: if len > self.bytes.len().saturating_sub(self.offset) {
    // rust: return Err(self.error("truncated list"));
}
    // rust: let mut values = Vec::with_capacity(len);
    // rust: for _ in 0..len {
    // rust: let mut value = self.payload(element_id, depth + 1)?;
    // rust: if let Tag::Compound(map) = &mut value {
    // rust: if map.len() == 1 && map.contains_key(&JavaString::default()) {
    // rust: value = map.remove(&JavaString::default()).unwrap();
}
}
    // rust: values.push(value);
}
    // rust: Tag::List(values)
}
    // rust: 10 => {
    // rust: let mut map = Compound::new();
    // rust: loop {
    // rust: let id = self.byte()?;
    // rust: if id == 0 {
    // rust: break;
}
    // rust: let name = self.string()?;
    // rust: let value = if id == 9 && depth <= 1 && self.streams(&name) {
    // rust: self.stream_list(depth + 1)?
    // rust: } else {
    // rust: self.payload(id, depth + 1)?
}
    // rust: map.insert(name, value); // Java maps retain the last duplicate key.
}
    // rust: Tag::Compound(map)
}
    // rust: 11 => {
    // rust: let len = self.count(4)?;
    // rust: let mut values = Vec::with_capacity(len);
    // rust: for _ in 0..len {
    // rust: values.push(i32::from_be_bytes(self.number()?));
}
    // rust: Tag::IntArray(values)
}
    // rust: 12 => {
    // rust: let len = self.count(8)?;
    // rust: let mut values = Vec::with_capacity(len);
    // rust: for _ in 0..len {
    // rust: values.push(i64::from_be_bytes(self.number()?));
}
    // rust: Tag::LongArray(values)
}
    // rust: _ => return Err(self.error("unknown tag type")),
    // rust: })
}
pub fn streams(self: *Self, name: *JavaString) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stream
    // rust: .as_ref()
    // rust: .is_some_and(|(key, _)| name.0.iter().copied().eq(key.encode_utf16()))
}
    /// A list's payload handed to the visitor element by element; the tree
    /// keeps it empty. Elements the visitor leaves are read and dropped.
pub fn stream_list(self: *Self, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.nodes >= self.limits.max_nodes {
    // rust: return Err(self.error("node limit exceeded"));
}
    // rust: self.nodes += 1;
    // rust: if depth >= self.limits.max_depth {
    // rust: return Err(self.error("depth limit exceeded"));
}
    // rust: let element_id = self.byte()?;
    // rust: let len = self.count(0)?;
    // rust: if len > 0 && (element_id == 0 || element_id > 12) {
    // rust: return Err(self.error("invalid list element type"));
}
    // rust: if len > self.bytes.len().saturating_sub(self.offset) {
    // rust: return Err(self.error("truncated list"));
}
    // rust: let (key, visit) = self.stream.take().expect("streams() checked the visitor");
    // rust: let mut elements = ListElements {
    // rust: reader: self,
    // rust: element_id,
    // rust: depth: depth + 1,
    // rust: len,
    // rust: left: len,
}
    // rust: let rest = visit(&mut elements).and_then(|()| {
    // rust: while elements.next_element()?.is_some() {}
    // rust: Ok(())
    // rust: });
    // rust: self.stream = Some((key, visit));
    // rust: rest.map(|()| Tag::List(Vec::new()))
}
}

/// The elements of a list [`read_named_streaming`] streams, read one at a
/// time.
pub const ListElements = struct {
    reader: *'r mut Reader<'a,
    element_id: u8,
    depth: usize,
    len: usize,
    left: usize,
};
    // rust: impl ListElements<'_, '_, '_> {
    /// The list's length, as its header gives it.
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.len
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.len == 0
}
    /// The next element, unwrapped as [`read_named`] unwraps mixed-list
    /// elements; `None` past the last.
pub fn next_element(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.left == 0 {
    // rust: return Ok(None);
}
    // rust: self.left -= 1;
    // rust: let mut value = self.reader.payload(self.element_id, self.depth)?;
    // rust: if let Tag::Compound(map) = &mut value {
    // rust: if map.len() == 1 && map.contains_key(&JavaString::default()) {
    // rust: value = map.remove(&JavaString::default()).unwrap();
}
}
    // rust: Ok(Some(value))
}
    /// An error at the current position in the input.
pub fn error(self: *Self, reason: *'static str) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reader.error(reason)
}
}

/// `DataInput.readUTF`'s decoding, accepting its overlong sequences; `None`
/// for bytes that aren't modified UTF-8.
pub fn modified_utf8(bytes: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = bytes.len();
    // rust: let mut units = Vec::with_capacity(len);
    // rust: let mut i = 0;
    // rust: while i < bytes.len() {
    // rust: let b = bytes[i];
    // rust: let (unit, size) = match b {
    // rust: 0..=127 => (u16::from(b), 1),
    // rust: 192..=223 if i + 1 < len && bytes[i + 1] & 0xc0 == 0x80 => {
    // rust: ((u16::from(b & 31) << 6) | u16::from(bytes[i + 1] & 63), 2)
}
    // rust: 224..=239
    // rust: if i + 2 < len && bytes[i + 1] & 0xc0 == 0x80 && bytes[i + 2] & 0xc0 == 0x80 =>
    // rust: {
    // rust: (
    // rust: (u16::from(b & 15) << 12)
    // rust: | (u16::from(bytes[i + 1] & 63) << 6)
    // rust: | u16::from(bytes[i + 2] & 63),
    // rust: 3,
    // rust: )
}
    // rust: _ => return None,
}
        // Match DataInput.readUTF, including accepted overlong sequences.
    // rust: units.push(unit);
    // rust: i += size;
}
    // rust: Some(JavaString(units))
}

/// Read a file root (type, modified-UTF name, payload), returning bytes consumed.
pub fn read_named(bytes: []const u8, limits: Limits) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut reader = Reader {
    // rust: bytes,
    // rust: offset: 0,
    // rust: limits,
    // rust: nodes: 0,
    // rust: stream: None,
}
    // rust: let id = reader.byte()?;
    // rust: let name = if id == 0 {
    // rust: JavaString::default()
    // rust: } else {
    // rust: reader.root_name()?
}
    // rust: let tag = reader.payload(id, 0)?;
    // rust: Ok((NamedTag { name, tag }, reader.offset))
}

/// [`read_named`], except that lists keyed `key` in the root compound or in
/// a compound directly under it are not kept: `visit` reads each one's
/// elements as they come, and the tree holds it as an empty list. Per-state
/// tables check hundreds of thousands of state identities this way without
/// holding them as a tree (crate::registry::BlockTableFile).
    // rust: pub fn read_named_streaming(
    // rust: bytes: &[u8],
    // rust: limits: Limits,
    // rust: key: &str,
    // rust: visit: &mut dyn FnMut(&mut ListElements<'_, '_, '_>) -> Result<(), Error>,
    // rust: ) -> Result<(NamedTag, usize), Error> {
    // rust: let mut reader = Reader {
    // rust: bytes,
    // rust: offset: 0,
    // rust: limits,
    // rust: nodes: 0,
    // rust: stream: Some((key, visit)),
}
    // rust: let id = reader.byte()?;
    // rust: let name = if id == 0 {
    // rust: JavaString::default()
    // rust: } else {
    // rust: reader.root_name()?
}
    // rust: let tag = reader.payload(id, 0)?;
    // rust: Ok((NamedTag { name, tag }, reader.offset))
}

/// Read a network root (type and payload, without the file name field).
pub fn read_network(bytes: []const u8, limits: Limits) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut reader = Reader {
    // rust: bytes,
    // rust: offset: 0,
    // rust: limits,
    // rust: nodes: 0,
    // rust: stream: None,
}
    // rust: let id = reader.byte()?;
    // rust: let tag = reader.payload(id, 0)?;
    // rust: Ok((tag, reader.offset))
}

pub const Writer = struct {
    bytes: std.ArrayList(u8),
    limits: Limits,
    nodes: usize,
    /// `NbtIo.StringFallbackDataOutput`, the disk writer's: a string too long
    /// for modified UTF-8 is written empty and the rest of the tree goes on.
    /// shortcut: vanilla also logs "Failed to write NBT String"; this crate has no logger.
    empty_long_strings: bool,
    /// `DataOutputStream.writeFloat`/`writeDouble` (`floatToIntBits`): a NaN
    /// is written as the canonical one. The network writer keeps its bits.
    canonical_nan: bool,
};
    // rust: impl Writer {
pub fn error(self: *Self, reason: *'static str) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Error {
    // rust: offset: self.bytes.len(),
    // rust: reason,
}
}
pub fn put(self: *Self, bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if bytes.len() > self.limits.max_bytes.saturating_sub(self.bytes.len()) {
    // rust: return Err(self.error("byte limit exceeded"));
}
    // rust: self.bytes.extend_from_slice(bytes);
    // rust: Ok(())
}
pub fn count(self: *Self, len: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = i32::try_from(len).map_err(|_| self.error("collection too long"))?;
    // rust: self.put(&len.to_be_bytes())
}
pub fn string(self: *Self, string: *JavaString) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len: usize = string
    // rust: .0
    // rust: .iter()
    // rust: .map(|&c| match c {
    // rust: 1..=127 => 1,
    // rust: 0..=2047 => 2,
    // rust: _ => 3,
    // rust: })
    // rust: .sum();
    // rust: let Ok(len) = u16::try_from(len) else {
    // rust: if self.empty_long_strings {
    // rust: return self.put(&0u16.to_be_bytes());
}
    // rust: return Err(self.error("modified UTF-8 exceeds 65535 bytes"));
}
    // rust: self.put(&len.to_be_bytes())?;
    // rust: for &c in &string.0 {
    // rust: match c {
    // rust: 1..=127 => self.put(&[c as u8])?,
    // rust: 0..=2047 => self.put(&[0xc0 | (c >> 6) as u8, 0x80 | (c & 63) as u8])?,
    // rust: _ => self.put(&[
    // rust: 0xe0 | (c >> 12) as u8,
    // rust: 0x80 | ((c >> 6) & 63) as u8,
    // rust: 0x80 | (c & 63) as u8,
    // rust: ])?,
}
}
    // rust: Ok(())
}
pub fn payload(self: *Self, tag: *Tag, depth: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.nodes >= self.limits.max_nodes {
    // rust: return Err(self.error("node limit exceeded"));
}
    // rust: self.nodes += 1;
    // rust: if matches!(tag, Tag::List(_) | Tag::Compound(_)) && depth >= self.limits.max_depth {
    // rust: return Err(self.error("depth limit exceeded"));
}
    // rust: match tag {
    // rust: Tag::End => {}
    // rust: Tag::Byte(v) => self.put(&[*v as u8])?,
    // rust: Tag::Short(v) => self.put(&v.to_be_bytes())?,
    // rust: Tag::Int(v) => self.put(&v.to_be_bytes())?,
    // rust: Tag::Long(v) => self.put(&v.to_be_bytes())?,
    // rust: Tag::Float(v) => self.put(
    // rust: &if self.canonical_nan && f32::from_bits(*v).is_nan() {
    // rust: 0x7fc0_0000_u32
    // rust: } else {
    // rust: *v
}
    // rust: .to_be_bytes(),
    // rust: )?,
    // rust: Tag::Double(v) => self.put(
    // rust: &if self.canonical_nan && f64::from_bits(*v).is_nan() {
    // rust: 0x7ff8_0000_0000_0000_u64
    // rust: } else {
    // rust: *v
}
    // rust: .to_be_bytes(),
    // rust: )?,
    // rust: Tag::ByteArray(v) => {
    // rust: self.count(v.len())?;
    // rust: self.put(v)?;
}
    // rust: Tag::String(v) => self.string(v)?,
    // rust: Tag::List(values) => {
    // rust: if values.iter().any(|v| matches!(v, Tag::End)) {
    // rust: return Err(self.error("End cannot be a list element"));
}
    // rust: let first = values.first().map_or(0, Tag::id);
    // rust: let id = if values.iter().any(|v| v.id() != first) {
    // rust: 10
    // rust: } else {
    // rust: first
}
    // rust: self.put(&[id])?;
    // rust: self.count(values.len())?;
    // rust: for value in values {
    // rust: let wrapper = matches!(value, Tag::Compound(c) if c.len() == 1 && c.contains_key(&JavaString::default()));
    // rust: if id == 10 && (value.id() != 10 || wrapper) {
                        // Emit one synthetic compound layer without cloning the tree.
    // rust: if depth + 1 >= self.limits.max_depth {
    // rust: return Err(self.error("depth limit exceeded"));
}
    // rust: if self.nodes >= self.limits.max_nodes {
    // rust: return Err(self.error("node limit exceeded"));
}
    // rust: self.nodes += 1;
    // rust: self.put(&[value.id()])?;
    // rust: self.string(&JavaString::default())?;
    // rust: self.payload(value, depth + 2)?;
    // rust: self.put(&[0])?;
    // rust: } else {
    // rust: self.payload(value, depth + 1)?;
}
}
}
    // rust: Tag::Compound(values) => {
    // rust: for (name, value) in values {
    // rust: if matches!(value, Tag::End) {
    // rust: return Err(self.error("End cannot be a named value"));
}
    // rust: self.put(&[value.id()])?;
    // rust: self.string(name)?;
    // rust: self.payload(value, depth + 1)?;
}
    // rust: self.put(&[0])?;
}
    // rust: Tag::IntArray(v) => {
    // rust: self.count(v.len())?;
    // rust: for item in v {
    // rust: self.put(&item.to_be_bytes())?;
}
}
    // rust: Tag::LongArray(v) => {
    // rust: self.count(v.len())?;
    // rust: for item in v {
    // rust: self.put(&item.to_be_bytes())?;
}
}
}
    // rust: Ok(())
}
}

/// `NbtIo.write`: a file root. A string too long for modified UTF-8 is
/// written empty, as vanilla's disk writer does; [`write_network`] refuses it.
pub fn write_named(root: *NamedTag, limits: Limits) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut writer = Writer {
    // rust: bytes: Vec::new(),
    // rust: limits,
    // rust: nodes: 0,
    // rust: empty_long_strings: true,
    // rust: canonical_nan: true,
}
    // rust: writer.put(&[root.tag.id()])?;
    // rust: if root.tag.id() != 0 {
    // rust: writer.string(&root.name)?;
}
    // rust: writer.payload(&root.tag, 0)?;
    // rust: Ok(writer.bytes)
}

pub fn write_network(tag: *Tag, limits: Limits) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut writer = Writer {
    // rust: bytes: Vec::new(),
    // rust: limits,
    // rust: nodes: 0,
    // rust: empty_long_strings: false,
    // rust: canonical_nan: false,
}
    // rust: writer.put(&[tag.id()])?;
    // rust: writer.payload(tag, 0)?;
    // rust: Ok(writer.bytes)
}

/// SNBT (`TagParser`): compounds, lists, typed arrays, quoted and bare
/// strings, booleans and suffixed numbers. Returns the tag and the bytes read.
pub fn parse_snbt(text: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = Snbt {
    // rust: s: text.as_bytes(),
    // rust: i: 0,
    // rust: depth: 0,
}
    // rust: let tag = p.value()?;
    // rust: Ok((tag, p.i))
}
/// Nesting deeper than NBT's own limit (`NbtAccounter`'s 512) is refused
/// rather than overflowing the stack.
pub const SNBT_MAX_DEPTH: usize = 512;
pub const Snbt = struct {
    s: *'a [u8],
    i: usize,
    depth: usize,
};
    // rust: impl Snbt<'_> {
pub fn skip(self: *Self) void {
}
    // rust: while self.i < self.s.len() && self.s[self.i].is_ascii_whitespace() {
    // rust: self.i += 1;
}
}
pub fn peek(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.skip();
    // rust: self.s.get(self.i).copied()
}
pub fn expect(self: *Self, c: u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.peek() == Some(c) {
    // rust: self.i += 1;
    // rust: Ok(())
    // rust: } else {
    // rust: Err(format!("expected '{}' at {}", c as char, self.i))
}
}
pub fn bare(c: u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: c.is_ascii_alphanumeric() || matches!(c, b'_' | b'-' | b'.' | b'+')
}
pub fn string(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.peek() {
    // rust: Some(q @ (b'"' | b'\'')) => {
    // rust: self.i += 1;
    // rust: let mut out = Vec::new();
    // rust: while let Some(&c) = self.s.get(self.i) {
    // rust: self.i += 1;
    // rust: if c == b'\\' {
    // rust: if let Some(&n) = self.s.get(self.i) {
    // rust: self.i += 1;
    // rust: out.push(match n {
    // rust: b'n' => b'\n',
    // rust: b't' => b'\t',
    // rust: other => other,
    // rust: });
}
    // rust: } else if c == q {
    // rust: return String::from_utf8(out).map_err(|e| e.to_string());
    // rust: } else {
    // rust: out.push(c);
}
}
    // rust: Err("unterminated string".into())
}
    // rust: _ => {
    // rust: let start = self.i;
    // rust: while self.s.get(self.i).is_some_and(|&c| Self::bare(c)) {
    // rust: self.i += 1;
}
    // rust: if start == self.i {
    // rust: return Err(format!("expected a value at {start}"));
}
    // rust: Ok(String::from_utf8_lossy(&self.s[start..self.i]).into_owned())
}
}
}
pub fn value(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.peek() {
    // rust: Some(b'{') => {
    // rust: if self.depth >= SNBT_MAX_DEPTH {
    // rust: return Err(format!("tag nesting too deep at {}", self.i));
}
    // rust: self.depth += 1;
    // rust: let tag = self.compound();
    // rust: self.depth -= 1;
    // rust: tag
}
    // rust: Some(b'[') => {
    // rust: if self.depth >= SNBT_MAX_DEPTH {
    // rust: return Err(format!("tag nesting too deep at {}", self.i));
}
    // rust: self.depth += 1;
    // rust: let tag = self.list();
    // rust: self.depth -= 1;
    // rust: tag
}
    // rust: Some(b'"' | b'\'') => Ok(Tag::String(JavaString::from(self.string()?.as_str()))),
    // rust: _ => {
    // rust: let word = self.string()?;
    // rust: Ok(Self::scalar(&word))
}
}
}
pub fn compound(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.i += 1;
    // rust: let mut map = Compound::new();
    // rust: if self.peek() == Some(b'}') {
    // rust: self.i += 1;
    // rust: return Ok(Tag::Compound(map));
}
    // rust: loop {
    // rust: let key = self.string()?;
    // rust: self.expect(b':')?;
    // rust: map.insert(JavaString::from(key.as_str()), self.value()?);
    // rust: match self.peek() {
    // rust: Some(b',') => self.i += 1,
    // rust: Some(b'}') => {
    // rust: self.i += 1;
    // rust: return Ok(Tag::Compound(map));
}
    // rust: _ => return Err(format!("expected ',' or '}}' at {}", self.i)),
}
}
}
pub fn list(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.i += 1;
    // rust: let typed = match (self.s.get(self.i), self.s.get(self.i + 1)) {
    // rust: (Some(&t @ (b'B' | b'I' | b'L')), Some(b';')) => {
    // rust: self.i += 2;
    // rust: Some(t)
}
    // rust: _ => None,
}
    // rust: let mut items = Vec::new();
    // rust: if self.peek() != Some(b']') {
    // rust: loop {
    // rust: items.push(self.value()?);
    // rust: match self.peek() {
    // rust: Some(b',') => self.i += 1,
    // rust: Some(b']') => break,
    // rust: _ => return Err(format!("expected ',' or ']' at {}", self.i)),
}
}
}
    // rust: self.i += 1;
    // rust: let long = |t: &Tag| match *t {
    // rust: Tag::Byte(v) => i64::from(v),
    // rust: Tag::Short(v) => i64::from(v),
    // rust: Tag::Int(v) => i64::from(v),
    // rust: Tag::Long(v) => v,
    // rust: _ => 0,
}
    // rust: Ok(match typed {
    // rust: Some(b'B') => Tag::ByteArray(items.iter().map(|t| long(t) as u8).collect()),
    // rust: Some(b'I') => Tag::IntArray(items.iter().map(|t| long(t) as i32).collect()),
    // rust: Some(_) => Tag::LongArray(items.iter().map(long).collect()),
    // rust: None => Tag::List(items),
    // rust: })
}
    /// A bare word: a typed number, a boolean, or else a string.
pub fn scalar(word: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match word {
    // rust: "true" => return Tag::Byte(1),
    // rust: "false" => return Tag::Byte(0),
    // rust: _ => {}
}
    // rust: let lower = word.to_ascii_lowercase();
    // rust: let (body, suffix) = match lower.as_bytes().last() {
    // rust: Some(c @ (b'b' | b's' | b'l' | b'f' | b'd')) => (&word[..word.len() - 1], Some(*c)),
    // rust: _ => (word, None),
}
        // Only digits (and an exponent) make a number: a word like `nan` or
        // `infd` that Rust's float parse would take is a string here.
    // rust: if body
    // rust: .bytes()
    // rust: .any(|c| c.is_ascii_alphabetic() && c != b'e' && c != b'E')
    // rust: {
    // rust: return Tag::String(JavaString::from(word));
}
    // rust: let parsed = match suffix {
    // rust: Some(b'b') => body.parse::<i8>().ok().map(Tag::Byte),
    // rust: Some(b's') => body.parse::<i16>().ok().map(Tag::Short),
    // rust: Some(b'l') => body.parse::<i64>().ok().map(Tag::Long),
    // rust: Some(b'f') => body.parse::<f32>().ok().map(|v| Tag::Float(v.to_bits())),
    // rust: Some(_) => body.parse::<f64>().ok().map(|v| Tag::Double(v.to_bits())),
    // rust: None if body.contains('.') || body.contains('e') || body.contains('E') => {
    // rust: body.parse::<f64>().ok().map(|v| Tag::Double(v.to_bits()))
}
    // rust: None => body.parse::<i32>().ok().map(Tag::Int),
}
    // rust: parsed.unwrap_or_else(|| Tag::String(JavaString::from(word)))
}
}

    // rust: mod tests {
//     use super::*;
    /// `NbtIo.write` (`StringFallbackDataOutput`) writes a string too long for
    /// modified UTF-8 empty and goes on (#5064); the network writer refuses
    /// it. Vanilla 26.3's bytes for `{s: 32768 x U+0000}` (65536 encoded).
pub fn the_disk_writer_empties_a_string_too_long_for_modified_utf8() void {
}
    // rust: let long = Tag::String(JavaString(vec![0; 32768]));
    // rust: let root = NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([("s", long.clone())]),
}
    // rust: assert_eq!(
    // rust: write_named(&root, Limits::saved()).unwrap(),
    // rust: [0x0a, 0, 0, 0x08, 0, 1, b's', 0, 0, 0]
    // rust: );
    // rust: assert!(write_network(&root.tag, Limits::saved()).is_err());
        // The rest of the tree is kept.
    // rust: let root = NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([
    // rust: ("before", Tag::String("kept".into())),
    // rust: ("long", long),
    // rust: ("after", Tag::Int(7)),
    // rust: ]),
}
    // rust: let bytes = write_named(&root, Limits::saved()).unwrap();
    // rust: let back = read_named(&bytes, Limits::saved()).unwrap().0.tag;
    // rust: assert_eq!(back.get("before"), Some(&Tag::String("kept".into())));
    // rust: assert_eq!(back.get("long"), Some(&Tag::String("".into())));
    // rust: assert_eq!(back.get("after"), Some(&Tag::Int(7)));
}
    /// `NbtIo.readUnnamedTag` skips the root's name unread
    /// (`StringTag.skipString`), so a name that isn't modified UTF-8 still
    /// loads (#5064). Vanilla 26.3 reads these bytes the same way.
pub fn a_root_name_that_is_not_modified_utf8_is_skipped() void {
}
    // rust: let hex = |s: &str| -> Vec<u8> {
    // rust: (0..s.len())
    // rust: .step_by(2)
    // rust: .map(|i| u8::from_str_radix(&s[i..i + 2], 16).unwrap())
    // rust: .collect()
}
    // rust: let (root, used) = read_named(&hex("0a0002ffff00"), Limits::saved()).unwrap();
    // rust: assert_eq!((root.tag, used), (Tag::Compound(Compound::new()), 6));
    // rust: let (root, _) = read_named(&hex("0a0002ffff030001780000000700"), Limits::saved()).unwrap();
    // rust: assert_eq!(root.tag, Tag::compound([("x", Tag::Int(7))]));
    // rust: assert_eq!(
    // rust: read_named(&hex("0a00047465737400"), Limits::saved())
    // rust: .unwrap()
    // rust: .0
    // rust: .name,
    // rust: "test".into()
    // rust: );
        // A name cut short, or a key inside that isn't modified UTF-8, still fails.
    // rust: assert!(read_named(&hex("0a0009ff"), Limits::saved()).is_err());
    // rust: assert!(read_named(&hex("0a000003000278ff0000000700"), Limits::saved()).is_err());
}
pub fn streamed_lists_reach_the_visitor_and_stay_empty_in_the_tree() void {
}
    // rust: let list = |n: i32| Tag::List((0..n).map(Tag::Int).collect());
    // rust: let root = NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([
    // rust: ("states", list(3)),
    // rust: ("inner", Tag::compound([("states", list(2))])),
    // rust: (
    // rust: "deep",
    // rust: Tag::compound([("inner", Tag::compound([("states", list(1))]))]),
    // rust: ),
    // rust: ("other", list(4)),
    // rust: ]),
}
    // rust: let bytes = write_named(&root, Limits::default()).unwrap();
    // rust: let mut seen = Vec::new();
    // rust: let (read, used) = read_named_streaming(&bytes, Limits::default(), "states", &mut |l| {
    // rust: let mut values = vec![l.len() as i32];
            // Elements left unread are skipped.
    // rust: if let Some(Tag::Int(v)) = l.next_element()? {
    // rust: values.push(v);
}
    // rust: seen.push(values);
    // rust: Ok(())
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(used, bytes.len());
        // Compounds are written in key order: `inner` before `states`.
    // rust: assert_eq!(seen, [vec![2, 0], vec![3, 0]]);
    // rust: assert_eq!(read.tag.get("states"), Some(&Tag::List(Vec::new())));
    // rust: assert_eq!(
    // rust: read.tag.get("inner").unwrap().get("states"),
    // rust: Some(&Tag::List(Vec::new()))
    // rust: );
        // Only the root and its direct children stream.
    // rust: assert_eq!(read.tag.get("deep"), root.tag.get("deep"));
    // rust: assert_eq!(read.tag.get("other"), root.tag.get("other"));
        // A visitor's error stops the read.
    // rust: let failed = read_named_streaming(&bytes, Limits::default(), "states", &mut |l| {
    // rust: Err(l.error("refused"))
    // rust: });
    // rust: assert_eq!(failed.unwrap_err().reason, "refused");
}
pub fn wire_node_budget_includes_mixed_list_wrappers() void {
}
    // rust: let tag = Tag::List(vec![Tag::Int(1), Tag::Byte(2)]);
    // rust: let limits = Limits {
    // rust: max_nodes: 5,
    // rust: ..Limits::default()
}
    // rust: let bytes = write_network(&tag, limits).unwrap();
    // rust: assert_eq!(read_network(&bytes, limits).unwrap().0, tag);
    // rust: let limits = Limits {
    // rust: max_nodes: 4,
    // rust: ..limits
}
    // rust: assert!(write_network(&tag, limits).is_err());
    // rust: assert!(read_network(&bytes, limits).is_err());
}
pub fn templates_read_past_the_default_node_cap() void {
}
        // A big mod template (YUNG's monument start) holds more tags than the
        // default cap; vanilla reads templates with an unlimited accounter.
    // rust: let root = NamedTag {
    // rust: name: JavaString::default(),
    // rust: tag: Tag::compound([("blocks", Tag::List(vec![Tag::Byte(1); 1_000_001]))]),
}
    // rust: let bytes = write_named(&root, Limits::templates()).unwrap();
    // rust: assert!(read_named(&bytes, Limits::default()).is_err());
    // rust: assert_eq!(read_named(&bytes, Limits::templates()).unwrap().0, root);
}
pub fn depth_boundary_and_every_truncated_prefix() void {
}
    // rust: let mut tag = Tag::Int(1);
    // rust: for _ in 0..512 {
    // rust: tag = Tag::List(vec![tag]);
}
    // rust: let bytes = write_network(&tag, Limits::default()).unwrap();
    // rust: assert_eq!(read_network(&bytes, Limits::default()).unwrap().0, tag);
    // rust: tag = Tag::List(vec![tag]);
    // rust: assert!(write_network(&tag, Limits::default()).is_err());
    // rust: let deeper = write_network(
    // rust: &tag,
    // rust: Limits {
    // rust: max_depth: 513,
    // rust: ..Limits::default()
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: assert!(read_network(&deeper, Limits::default()).is_err());
    // rust: let short = Tag::compound([(
    // rust: "list",
    // rust: Tag::List(vec![Tag::Long(42), Tag::ByteArray(vec![1, 2, 3])]),
    // rust: )]);
    // rust: let bytes = write_network(&short, Limits::default()).unwrap();
    // rust: for end in 0..bytes.len() {
    // rust: assert!(read_network(&bytes[..end], Limits::default()).is_err());
}
}
pub fn modified_utf_and_mixed_lists_preserve_java_values() void {
}
    // rust: let tag = Tag::List(vec![
    // rust: Tag::Int(3),
    // rust: Tag::String(JavaString(vec![0, 0xd800, 0xdc00, 0xdfff])),
    // rust: Tag::compound([("", Tag::Int(9))]),
    // rust: Tag::compound([("x", Tag::Byte(1))]),
    // rust: ]);
    // rust: let data = write_network(&tag, Limits::default()).unwrap();
    // rust: assert_eq!(data[1], 10);
    // rust: assert_eq!(
    // rust: read_network(&data, Limits::default()).unwrap(),
    // rust: (tag, data.len())
    // rust: );
}
pub fn malformed_lengths_truncation_limits_and_utf_are_rejected() void {
}
    // rust: for data in [
    // rust: &[7, 0xff, 0xff, 0xff, 0xff][..],
    // rust: &[9, 0, 0, 0, 0, 1],
    // rust: &[8, 0, 1, 0xc0],
    // rust: &[13],
    // rust: &[4, 0],
    // rust: ] {
    // rust: assert!(read_network(data, Limits::default()).is_err());
}
    // rust: let tag = Tag::List(vec![Tag::List(vec![Tag::Int(1)])]);
    // rust: let bytes = write_network(&tag, Limits::default()).unwrap();
    // rust: assert!(
    // rust: read_network(
    // rust: &bytes,
    // rust: Limits {
    // rust: max_depth: 1,
    // rust: ..Limits::default()
}
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: assert!(
    // rust: read_network(
    // rust: &bytes,
    // rust: Limits {
    // rust: max_nodes: 2,
    // rust: ..Limits::default()
}
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: assert!(
    // rust: read_network(
    // rust: &bytes,
    // rust: Limits {
    // rust: max_bytes: bytes.len() - 1,
    // rust: ..Limits::default()
}
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: assert!(
    // rust: write_network(&Tag::String(JavaString(vec![0; 32768])), Limits::default()).is_err()
    // rust: );
}
pub fn duplicate_keys_last_wins_and_nan_output_is_canonical_on_disk() void {
}
    // rust: let bytes = [10, 1, 0, 1, b'x', 1, 1, 0, 1, b'x', 2, 0];
    // rust: assert_eq!(
    // rust: read_network(&bytes, Limits::default()).unwrap().0.get("x"),
    // rust: Some(&Tag::Byte(2))
    // rust: );
        // Vanilla 26.3 (#5064): `FriendlyByteBuf.writeNbt` keeps a NaN's bits,
        // `NbtIo.write` writes the canonical NaN.
    // rust: let nan = |bits: u32| NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([("v", Tag::Float(bits))]),
}
    // rust: assert_eq!(
    // rust: write_network(&Tag::Float(0xff80_0001), Limits::default()).unwrap(),
    // rust: [5, 0xff, 0x80, 0, 1]
    // rust: );
    // rust: assert_eq!(
    // rust: write_network(&Tag::Double(0x7ff0_0000_0000_0001), Limits::default()).unwrap(),
    // rust: [6, 0x7f, 0xf0, 0, 0, 0, 0, 0, 1]
    // rust: );
    // rust: assert_eq!(
    // rust: write_named(&nan(0x7f80_0001), Limits::default()).unwrap(),
    // rust: [10, 0, 0, 5, 0, 1, b'v', 0x7f, 0xc0, 0, 0, 0]
    // rust: );
    // rust: assert_eq!(
    // rust: write_network(&Tag::Double((-0.0_f64).to_bits()), Limits::default()).unwrap()[1],
    // rust: 0x80
    // rust: );
}
pub fn snbt_parses_typed_values() void {
}
    // rust: let text = "{a:1b,b:[I;1,2],c:'x y',d:[{e:2.5f}],f:true,g:id}";
    // rust: let (tag, used) = parse_snbt(&format!("{text}rest")).unwrap();
    // rust: assert_eq!(used, text.len());
    // rust: assert_eq!(tag.get("a"), Some(&Tag::Byte(1)));
    // rust: assert_eq!(tag.get("b"), Some(&Tag::IntArray(vec![1, 2])));
    // rust: assert_eq!(tag.get("c"), Some(&Tag::String("x y".into())));
    // rust: assert_eq!(tag.get("f"), Some(&Tag::Byte(1)));
    // rust: assert_eq!(tag.get("g"), Some(&Tag::String("id".into())));
    // rust: let Some(Tag::List(d)) = tag.get("d") else {
    // rust: panic!()
}
    // rust: assert_eq!(d[0].get("e"), Some(&Tag::Float(2.5f32.to_bits())));
}
pub fn snbt_nesting_is_bounded() void {
}
    // rust: let nest = |n: usize| format!("{}1{}", "[".repeat(n), "]".repeat(n));
    // rust: assert!(parse_snbt(&nest(512)).is_ok());
    // rust: assert!(parse_snbt(&nest(513)).is_err());
        // Far past any limit it errs instead of overflowing the stack.
    // rust: assert!(parse_snbt(&nest(100_000)).is_err());
}
pub fn snbt_bare_words_stay_strings() void {
}
    // rust: for word in ["nan", "NaN", "inf", "infd", "NaNf", "Infinityd", "nand"] {
    // rust: assert_eq!(
    // rust: parse_snbt(word).unwrap().0,
    // rust: Tag::String(JavaString::from(word)),
    // rust: "{word}"
    // rust: );
}
    // rust: assert_eq!(
    // rust: parse_snbt("1e5").unwrap().0,
    // rust: Tag::Double(100000f64.to_bits())
    // rust: );
    // rust: assert_eq!(parse_snbt("1.5f").unwrap().0, Tag::Float(1.5f32.to_bits()));
    // rust: assert_eq!(parse_snbt("3b").unwrap().0, Tag::Byte(3));
    // rust: assert_eq!(parse_snbt("-2L").unwrap().0, Tag::Long(-2));
}
}
