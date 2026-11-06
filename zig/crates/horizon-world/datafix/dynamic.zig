//! Transpiled from Horizon Rust crate
//! Module: horizon-world_dynamic
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What DataFixerUpper's `Dynamic` over `NbtOps` does with values: number and
//! string views, maps and lists, field edits. Fixes use these to stay close to
//! the Java they port.
// use crate::nbt::{Compound, JavaString, Tag};

pub fn key(s: []const u8) J {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: JavaString::from(s)
}
pub fn string(s: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::String(JavaString::from(s))
}
pub fn empty_map() T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::Compound(Compound::new())
}
pub fn boolean(b: bool) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::Byte(i8::from(b))
}
pub fn int_list(values: *[i32]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::IntArray(values.to_vec())
}

/// A Java `Number` from a numeric tag (`Tag.asNumber`).
pub const Number = enum {
    Byte(i8),
    Short(i16),
    Int(i32),
    Long(i64),
    Float(f32),
    Double(f64),
};
    // rust: impl Number {
pub fn int_value(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Byte(v) => i32::from(v),
    // rust: Self::Short(v) => i32::from(v),
    // rust: Self::Int(v) => v,
    // rust: Self::Long(v) => v as i32,
    // rust: Self::Float(v) => v as i32,
    // rust: Self::Double(v) => v as i32,
}
}
pub fn long_value(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Byte(v) => i64::from(v),
    // rust: Self::Short(v) => i64::from(v),
    // rust: Self::Int(v) => i64::from(v),
    // rust: Self::Long(v) => v,
    // rust: Self::Float(v) => v as i64,
    // rust: Self::Double(v) => v as i64,
}
}
pub fn double_value(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Byte(v) => f64::from(v),
    // rust: Self::Short(v) => f64::from(v),
    // rust: Self::Int(v) => f64::from(v),
    // rust: Self::Long(v) => v as f64,
    // rust: Self::Float(v) => f64::from(v),
    // rust: Self::Double(v) => v,
}
}
pub fn float_value(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Double(v) => v as f32,
    // rust: Self::Long(v) => v as f32,
    // rust: other => other.double_value() as f32,
}
}
pub fn byte_value(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Byte(v) => v,
    // rust: Self::Short(v) => v as i8,
    // rust: Self::Int(v) => v as i8,
    // rust: Self::Long(v) => v as i8,
    // rust: Self::Float(v) => (v as i32) as i8,
    // rust: Self::Double(v) => (v as i32) as i8,
}
}
    /// `Number.toString` of the boxed value.
pub fn java_string(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Byte(v) => v.to_string(),
    // rust: Self::Short(v) => v.to_string(),
    // rust: Self::Int(v) => v.to_string(),
    // rust: Self::Long(v) => v.to_string(),
    // rust: Self::Float(v) => crate::datafix::json::java_float_string(v),
    // rust: Self::Double(v) => crate::datafix::json::java_double_string(v),
}
}
}

pub fn as_number(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match tag {
    // rust: Tag::Byte(v) => Number::Byte(*v),
    // rust: Tag::Short(v) => Number::Short(*v),
    // rust: Tag::Int(v) => Number::Int(*v),
    // rust: Tag::Long(v) => Number::Long(*v),
    // rust: Tag::Float(v) => Number::Float(f32::from_bits(*v)),
    // rust: Tag::Double(v) => Number::Double(f64::from_bits(*v)),
    // rust: _ => return None,
    // rust: })
}
pub fn as_int(tag: ?*Tag, default: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.and_then(as_number).map_or(default, Number::int_value)
}
pub fn as_long(tag: ?*Tag, default: i64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.and_then(as_number).map_or(default, Number::long_value)
}
pub fn as_double(tag: ?*Tag, default: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.and_then(as_number)
    // rust: .map_or(default, Number::double_value)
}
pub fn as_float(tag: ?*Tag, default: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.and_then(as_number).map_or(default, Number::float_value)
}
/// `NbtOps.getBooleanValue`: a number that is not zero.
pub fn as_bool_opt(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.and_then(as_number).map(|n| n.double_value() != 0.0)
}
pub fn as_bool(tag: ?*Tag, default: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: as_bool_opt(tag).unwrap_or(default)
}
pub fn as_str(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
pub fn as_string(tag: ?*Tag, default: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: as_str(tag).unwrap_or_else(|| default.to_owned())
}

/// `NbtOps.getStream`: the elements of a list or of a number array.
pub fn stream(tag: ?*Tag) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Some(Tag::List(v)) => v.clone(),
    // rust: Some(Tag::ByteArray(v)) => v.iter().map(|b| Tag::Byte(*b as i8)).collect(),
    // rust: Some(Tag::IntArray(v)) => v.iter().map(|i| Tag::Int(*i)).collect(),
    // rust: Some(Tag::LongArray(v)) => v.iter().map(|l| Tag::Long(*l)).collect(),
    // rust: _ => Vec::new(),
}
}
pub fn is_list(tag: ?*Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: tag,
    // rust: Some(Tag::List(_) | Tag::ByteArray(_) | Tag::IntArray(_) | Tag::LongArray(_))
    // rust: )
}

    // rust: pub fn get<'a>(tag: &'a Tag, field: &str) -> Option<&'a Tag> {
    // rust: tag.get(field)
}
pub fn map(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::Compound(c) => Some(c),
    // rust: _ => None,
}
}
/// `Dynamic.set`: only maps change.
pub fn set(tag: *mut Tag, field: []const u8, value: Tag) void {
}
    // rust: if let Tag::End = tag {
    // rust: *tag = empty_map();
}
    // rust: if let Tag::Compound(c) = tag {
    // rust: c.insert(key(field), value);
}
}
pub fn remove(tag: *mut Tag, field: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::Compound(c) => c.remove(&key(field)),
    // rust: _ => None,
}
}
pub fn has(tag: *Tag, field: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.get(field).is_some()
}
/// `Dynamic.renameField`.
pub fn rename(tag: *mut Tag, from: []const u8, to: []const u8) void {
}
    // rust: if let Some(v) = remove(tag, from) {
    // rust: set(tag, to, v);
}
}
/// `Dynamic.update`: apply `f` to a field that is present.
pub fn update(tag: *mut Tag, field: []const u8, f: impl FnOnce(Tag) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(v) = remove(tag, field) {
    // rust: set(tag, field, f(v));
}
}
/// `Dynamic.renameAndFixField`: the fixed value under the new name, removed when
/// the fix gives nothing.
pub fn rename_and_fix(tag: *mut Tag, from: []const u8, to: []const u8, f: impl FnOnce(Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(v) = remove(tag, from)
    // rust: && let Some(v) = f(v)
    // rust: {
    // rust: set(tag, to, v);
}
}
/// `Dynamic.copyField`.
pub fn copy_field(from: *Tag, field: []const u8, to: *mut Tag, to_field: []const u8) void {
}
    // rust: if let Some(v) = from.get(field) {
    // rust: set(to, to_field, v.clone());
}
}
/// `Dynamic.equals(emptyMap())`: the map a record remembers it was read from
/// (see `datafix::mark_read`) is not part of the value.
pub fn is_empty_map(tag: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(tag, Tag::Compound(c) if c.keys().all(|k| *k == key(super::LAST_READ)))
}
/// `Dynamic.orElseEmptyMap` of an optional field.
pub fn or_empty_map(tag: ?*Tag) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.cloned().unwrap_or_else(empty_map)
}
/// `NamespacedSchema.ensureNamespaced`.
pub fn namespaced(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match crate::datafix::identifier(id) {
    // rust: Some((ns, path)) => format!("{ns}:{path}"),
    // rust: None => id.to_owned(),
}
}

/// `Dynamic.asLongStreamOpt` over `NbtOps`: a long array, or a list or array
/// whose elements are all numbers.
pub fn as_long_stream(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag? {
    // rust: Tag::LongArray(v) => Some(v.clone()),
    // rust: t if is_list(Some(t)) => stream(Some(t))
    // rust: .iter()
    // rust: .map(|e| as_number(e).map(Number::long_value))
    // rust: .collect(),
    // rust: _ => None,
}
}
/// `Dynamic.asIntStreamOpt` over `NbtOps`.
pub fn as_int_stream(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag? {
    // rust: Tag::IntArray(v) => Some(v.clone()),
    // rust: t if is_list(Some(t)) => stream(Some(t))
    // rust: .iter()
    // rust: .map(|e| as_number(e).map(Number::int_value))
    // rust: .collect(),
    // rust: _ => None,
}
}
/// `Dynamic.asByteBufferOpt` over `NbtOps`.
pub fn as_byte_buffer(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag? {
    // rust: Tag::ByteArray(v) => Some(v.clone()),
    // rust: t if is_list(Some(t)) => stream(Some(t))
    // rust: .iter()
    // rust: .map(|e| as_number(e).map(|n| n.byte_value() as u8))
    // rust: .collect(),
    // rust: _ => None,
}
}
/// `ChunkHeightAndBiomeFix.ceillog2` (`Math.ceil(Math.log(n) / Math.log(2))`,
/// which is exact for every palette size).
pub fn ceillog2(n: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if n <= 1 {
    // rust: 0
    // rust: } else {
    // rust: usize::BITS - (n - 1).leading_zeros()
}
}
