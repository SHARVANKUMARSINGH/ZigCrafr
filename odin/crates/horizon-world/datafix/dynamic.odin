//! Transpiled from Horizon Rust crate
package horizon_world_dynamic

import "core:fmt"
import "core:mem"
import "core:math"

// What DataFixerUpper's `Dynamic` over `NbtOps` does with values: number and
// string views, maps and lists, field edits. Fixes use these to stay close to
// the Java they port.
// use crate::nbt::{Compound, JavaString, Tag};

key :: proc(s: string) -> J {
    // Ported from Horizon
    return {}
}
    // rust: JavaString::from(s)
}
string :: proc(s: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::String(JavaString::from(s))
}
empty_map :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::Compound(Compound::new())
}
boolean :: proc(b: bool) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::Byte(i8::from(b))
}
int_list :: proc(values: ^[i32]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::IntArray(values.to_vec())
}

// A Java `Number` from a numeric tag (`Tag.asNumber`).
Number :: enum {
    Byte(i8),
    Short(i16),
    Int(i32),
    Long(i64),
    Float(f32),
    Double(f64),
}
    // rust: impl Number {
int_value :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
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
long_value :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
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
double_value :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
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
float_value :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Double(v) => v as f32,
    // rust: Self::Long(v) => v as f32,
    // rust: other => other.double_value() as f32,
}
}
byte_value :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
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
    // `Number.toString` of the boxed value.
java_string :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
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

as_number :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
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
as_int :: proc(tag: Maybe(^Tag), default: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: tag.and_then(as_number).map_or(default, Number::int_value)
}
as_long :: proc(tag: Maybe(^Tag), default: i64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: tag.and_then(as_number).map_or(default, Number::long_value)
}
as_double :: proc(tag: Maybe(^Tag), default: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: tag.and_then(as_number)
    // rust: .map_or(default, Number::double_value)
}
as_float :: proc(tag: Maybe(^Tag), default: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: tag.and_then(as_number).map_or(default, Number::float_value)
}
// `NbtOps.getBooleanValue`: a number that is not zero.
as_bool_opt :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: tag.and_then(as_number).map(|n| n.double_value() != 0.0)
}
as_bool :: proc(tag: Maybe(^Tag), default: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: as_bool_opt(tag).unwrap_or(default)
}
as_str :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
as_string :: proc(tag: Maybe(^Tag), default: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: as_str(tag).unwrap_or_else(|| default.to_owned())
}

// `NbtOps.getStream`: the elements of a list or of a number array.
stream :: proc(tag: Maybe(^Tag)) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Some(Tag::List(v)) => v.clone(),
    // rust: Some(Tag::ByteArray(v)) => v.iter().map(|b| Tag::Byte(*b as i8)).collect(),
    // rust: Some(Tag::IntArray(v)) => v.iter().map(|i| Tag::Int(*i)).collect(),
    // rust: Some(Tag::LongArray(v)) => v.iter().map(|l| Tag::Long(*l)).collect(),
    // rust: _ => Vec::new(),
}
}
is_list :: proc(tag: Maybe(^Tag)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: tag,
    // rust: Some(Tag::List(_) | Tag::ByteArray(_) | Tag::IntArray(_) | Tag::LongArray(_))
    // rust: )
}

    // rust: pub fn get<'a>(tag: &'a Tag, field: &str) -> Option<&'a Tag> {
    // rust: tag.get(field)
}
map :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::Compound(c) => Some(c),
    // rust: _ => None,
}
}
// `Dynamic.set`: only maps change.
set :: proc(tag: ^Tag, field: string, value: Tag) {
}
    // rust: if let Tag::End = tag {
    // rust: *tag = empty_map();
}
    // rust: if let Tag::Compound(c) = tag {
    // rust: c.insert(key(field), value);
}
}
remove :: proc(tag: ^Tag, field: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::Compound(c) => c.remove(&key(field)),
    // rust: _ => None,
}
}
has :: proc(tag: ^Tag, field: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: tag.get(field).is_some()
}
// `Dynamic.renameField`.
rename :: proc(tag: ^Tag, from: string, to: string) {
}
    // rust: if let Some(v) = remove(tag, from) {
    // rust: set(tag, to, v);
}
}
// `Dynamic.update`: apply `f` to a field that is present.
update :: proc(tag: ^Tag, field: string, f: impl FnOnce(Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(v) = remove(tag, field) {
    // rust: set(tag, field, f(v));
}
}
// `Dynamic.renameAndFixField`: the fixed value under the new name, removed when
// the fix gives nothing.
rename_and_fix :: proc(tag: ^Tag, from: string, to: string, f: impl FnOnce(Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(v) = remove(tag, from)
    // rust: && let Some(v) = f(v)
    // rust: {
    // rust: set(tag, to, v);
}
}
// `Dynamic.copyField`.
copy_field :: proc(from: ^Tag, field: string, to: ^Tag, to_field: string) {
}
    // rust: if let Some(v) = from.get(field) {
    // rust: set(to, to_field, v.clone());
}
}
// `Dynamic.equals(emptyMap())`: the map a record remembers it was read from
// (see `datafix::mark_read`) is not part of the value.
is_empty_map :: proc(tag: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(tag, Tag::Compound(c) if c.keys().all(|k| *k == key(super::LAST_READ)))
}
// `Dynamic.orElseEmptyMap` of an optional field.
or_empty_map :: proc(tag: Maybe(^Tag)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: tag.cloned().unwrap_or_else(empty_map)
}
// `NamespacedSchema.ensureNamespaced`.
namespaced :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match crate::datafix::identifier(id) {
    // rust: Some((ns, path)) => format!("{ns}:{path}"),
    // rust: None => id.to_owned(),
}
}

// `Dynamic.asLongStreamOpt` over `NbtOps`: a long array, or a list or array
// whose elements are all numbers.
as_long_stream :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
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
// `Dynamic.asIntStreamOpt` over `NbtOps`.
as_int_stream :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
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
// `Dynamic.asByteBufferOpt` over `NbtOps`.
as_byte_buffer :: proc(tag: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
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
// `ChunkHeightAndBiomeFix.ceillog2` (`Math.ceil(Math.log(n) / Math.log(2))`,
// which is exact for every palette size).
ceillog2 :: proc(n: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if n <= 1 {
    // rust: 0
    // rust: } else {
    // rust: usize::BITS - (n - 1).leading_zeros()
}
}
