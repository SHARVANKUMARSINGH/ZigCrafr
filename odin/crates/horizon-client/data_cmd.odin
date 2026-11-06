//! Transpiled from Horizon Rust crate
package horizon_client_data_cmd

import "core:fmt"
import "core:mem"
import "core:math"

// The pure parts of `/data` (DataCommands): merging compounds, the
// `modify` operations over an NBT path, string sources and the numeric
// result of `get`.
// use crate::{
    // rust: command::CommandError,
    // rust: nbt_path::{CollectionError, NbtPath, PathError, too_deep},
    // rust: snbt::to_snbt,
    // rust: text::Text,
}
// use horizon_world::nbt::{Compound, Tag};

// `CompoundTag.merge`: compounds merge recursively, anything else replaces.
merge_compound :: proc(target: ^Compound, source: ^Compound) {
}
    // rust: for (k, v) in source {
    // rust: match (target.get_mut(k), v) {
    // rust: (Some(Tag::Compound(t)), Tag::Compound(s)) => merge_compound(t, s),
    // rust: _ => {
    // rust: target.insert(k.clone(), v.clone());
}
}
}
}
// `old.copy().merge(nbt)`.
merged :: proc(old: ^Tag, nbt: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut result = old.clone();
    // rust: if let (Tag::Compound(t), Tag::Compound(s)) = (&mut result, nbt) {
    // rust: merge_compound(t, s);
}
    // rust: result
}

path_error :: proc(e: PathError) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let args: Vec<&dyn std::fmt::Display> =
    // rust: e.args.iter().map(|a| a as &dyn std::fmt::Display).collect();
    // rust: CommandError::tr(e.key, &args)
}
collection_error :: proc(e: CollectionError) -> C {
    // Ported from Horizon
    return {}
}
    // rust: match e {
    // rust: CollectionError::Path(p) => path_error(p),
    // rust: CollectionError::ExpectedList(t) => {
    // rust: CommandError::tr("commands.data.modify.expected_list", &[&t])
}
    // rust: CollectionError::InvalidIndex(i) => {
    // rust: CommandError::tr("commands.data.modify.invalid_index", &[&i])
}
}
}

// The `modify` operation words.
Op :: enum {
    Insert(i32),
    Prepend,
    Append,
    Set,
    Merge,
}
// Run a `modify` operation; the count is how many tags changed (0 = fail).
    // rust: pub fn modify(
    // rust: op: Op,
    // rust: target: &mut Tag,
    // rust: path: &NbtPath,
    // rust: sources: &[Tag],
    // rust: ) -> Result<usize, CommandError> {
    // rust: match op {
    // rust: Op::Insert(i) => path.insert(i, target, sources).map_err(collection_error),
    // rust: Op::Prepend => path.insert(0, target, sources).map_err(collection_error),
    // rust: Op::Append => path.insert(-1, target, sources).map_err(collection_error),
    // rust: Op::Set => {
    // rust: let Some(last) = sources.last() else {
    // rust: return Ok(0);
}
    // rust: path.set(target, last).map_err(path_error)
}
    // rust: Op::Merge => {
    // rust: let mut combined = Compound::new();
    // rust: for s in sources {
    // rust: if too_deep(s, 0) {
    // rust: return Err(CommandError::tr("arguments.nbtpath.too_deep", &[]));
}
    // rust: let Tag::Compound(c) = s else {
    // rust: return Err(CommandError::tr(
    // rust: "commands.data.modify.expected_object",
    // rust: &[&to_snbt(s)],
    // rust: ));
}
    // rust: merge_compound(&mut combined, c);
}
    // rust: let mut changed = 0;
    // rust: let mut error = None;
    // rust: path.get_or_create(target, &|| Tag::Compound(Compound::new()), &mut |t| {
    // rust: if error.is_some() {
    // rust: return;
}
    // rust: match t {
    // rust: Tag::Compound(c) => {
    // rust: let before = c.clone();
    // rust: merge_compound(c, &combined);
    // rust: changed += usize::from(before != *c);
}
    // rust: other => {
    // rust: error = Some(CommandError::tr(
    // rust: "commands.data.modify.expected_object",
    // rust: &[&to_snbt(other)],
    // rust: ));
}
}
    // rust: })
    // rust: .map_err(path_error)?;
    // rust: match error {
    // rust: Some(e) => Err(e),
    // rust: None => Ok(changed),
}
}
}
}
// `getAsText`: strings and numbers as text, anything else is an error.
as_text :: proc(tag: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::String(s) => Ok(s.to_string_lossy()),
    // rust: Tag::Byte(_)
    // rust: | Tag::Short(_)
    // rust: | Tag::Int(_)
    // rust: | Tag::Long(_)
    // rust: | Tag::Float(_)
    // rust: | Tag::Double(_) => {
            // PrimitiveTag.toString: the SNBT form (with its suffix).
    // rust: Ok(to_snbt(tag))
}
    // rust: other => Err(CommandError::tr(
    // rust: "commands.data.modify.expected_value",
    // rust: &[&to_snbt(other)],
    // rust: )),
}
}
// `substring(input, start[, end])` with negative offsets from the end.
substring :: proc(input: string, start: i32, end: Maybe(i32)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let chars: Vec<u16> = input.encode_utf16().collect();
    // rust: let len = chars.len() as i32;
    // rust: let offset = |i: i32| if i >= 0 { i } else { len + i };
    // rust: let (s, e) = (offset(start), end.map_or(len, offset));
    // rust: if s >= 0 && e <= len && s <= e {
    // rust: Ok(String::from_utf16_lossy(&chars[s as usize..e as usize]))
    // rust: } else {
    // rust: Err(CommandError::tr(
    // rust: "commands.data.modify.invalid_substring",
    // rust: &[&s, &e],
    // rust: ))
}
}
// `getSingleTag`: exactly one tag at the path.
single_tag :: proc(path: ^NbtPath, data: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut tags = path.get(data).map_err(path_error)?;
    // rust: if tags.len() > 1 {
    // rust: return Err(CommandError::tr("commands.data.get.multiple", &[]));
}
    // rust: Ok(tags.remove(0))
}
// The value of a tag as a double (NumericTag.doubleValue).
numeric :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match tag {
    // rust: Tag::Byte(v) => f64::from(*v),
    // rust: Tag::Short(v) => f64::from(*v),
    // rust: Tag::Int(v) => f64::from(*v),
    // rust: Tag::Long(v) => *v as f64,
    // rust: Tag::Float(v) => f64::from(f32::from_bits(*v)),
    // rust: Tag::Double(v) => f64::from_bits(*v),
    // rust: _ => return None,
    // rust: })
}
// `data get <path>`'s return value: the number's floor, or a size.
get_value :: proc(tag: ^Tag, path: ^NbtPath) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match tag {
    // rust: Tag::List(l) => l.len() as i32,
    // rust: Tag::ByteArray(a) => a.len() as i32,
    // rust: Tag::IntArray(a) => a.len() as i32,
    // rust: Tag::LongArray(a) => a.len() as i32,
    // rust: Tag::Compound(c) => c.len() as i32,
    // rust: Tag::String(s) => s.0.len() as i32,
    // rust: Tag::End => {
    // rust: return Err(CommandError::tr(
    // rust: "commands.data.get.unknown",
    // rust: &[&path.as_str()],
    // rust: ));
}
    // rust: other => numeric(other).map_or(0, |v| v.floor() as i32),
    // rust: })
}
// `Mth.floor(value * scale)` for `data get <path> <scale>`.
scaled_value :: proc(tag: ^Tag, path: ^NbtPath, scale: f64) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match numeric(tag) {
    // rust: Some(v) => Ok((v * scale).floor() as i32),
    // rust: None => Err(CommandError::tr(
    // rust: "commands.data.get.invalid",
    // rust: &[&path.as_str()],
    // rust: )),
}
}
// The text `data get ... <scale>` prints for the scale (`%.2f`).
scale_text :: proc(scale: f64) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Text::literal(crate::java_text::format_fixed(scale, 2))
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::parse_snbt;

tag :: proc(s: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: parse_snbt(s).unwrap().0
}
path :: proc(s: string) -> N {
    // Ported from Horizon
    return {}
}
    // rust: NbtPath::parse(s).unwrap()
}

merge_is_recursive :: proc() {
}
    // rust: let old = tag("{a:{b:1,c:2},d:[1]}");
    // rust: assert_eq!(
    // rust: to_snbt(&merged(&old, &tag("{a:{b:9},e:1}"))),
    // rust: "{a:{b:9,c:2},d:[1],e:1}"
    // rust: );
    // rust: assert_eq!(merged(&old, &tag("{}")), old);
        // Lists and scalars are replaced, not merged.
    // rust: assert_eq!(
    // rust: to_snbt(&merged(&old, &tag("{d:[2]}"))),
    // rust: "{a:{b:1,c:2},d:[2]}"
    // rust: );
}

modify_operations :: proc() {
}
    // rust: let mut t = tag("{l:[1,2],o:{a:1}}");
    // rust: assert_eq!(
    // rust: modify(Op::Append, &mut t, &path("l"), &[tag("3")]).unwrap(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(
    // rust: modify(Op::Prepend, &mut t, &path("l"), &[tag("0")]).unwrap(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(
    // rust: modify(Op::Insert(2), &mut t, &path("l"), &[tag("9")]).unwrap(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(to_snbt(&t), "{l:[0,1,9,2,3],o:{a:1}}");
    // rust: assert_eq!(
    // rust: modify(Op::Set, &mut t, &path("o.a"), &[tag("1"), tag("2")]).unwrap(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(
    // rust: modify(Op::Set, &mut t, &path("o.a"), &[tag("2")]).unwrap(),
    // rust: 0
    // rust: );
    // rust: assert_eq!(
    // rust: modify(Op::Merge, &mut t, &path("o"), &[tag("{b:1}")]).unwrap(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(
    // rust: modify(Op::Merge, &mut t, &path("o"), &[tag("{b:1}")]).unwrap(),
    // rust: 0
    // rust: );
    // rust: assert_eq!(to_snbt(&t), "{l:[0,1,9,2,3],o:{a:2,b:1}}");
    // rust: let e = modify(Op::Merge, &mut t, &path("o"), &[tag("3")]).unwrap_err();
    // rust: assert_eq!(e.message.plain(), "commands.data.modify.expected_object");
    // rust: let e = modify(Op::Append, &mut t, &path("o"), &[tag("3")]).unwrap_err();
    // rust: assert_eq!(e.message.plain(), "commands.data.modify.expected_list");
        // Merge creates the target compound when missing.
    // rust: assert_eq!(
    // rust: modify(Op::Merge, &mut t, &path("new.deep"), &[tag("{x:1}")]).unwrap(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(single_tag(&path("new.deep.x"), &t).unwrap(), Tag::Int(1));
}

strings_and_values :: proc() {
}
    // rust: assert_eq!(substring("abcdef", 1, Some(3)).unwrap(), "bc");
    // rust: assert_eq!(substring("abcdef", -2, None).unwrap(), "ef");
    // rust: assert_eq!(substring("abcdef", 0, Some(-1)).unwrap(), "abcde");
    // rust: assert!(substring("abc", 2, Some(1)).is_err());
    // rust: assert!(substring("abc", 0, Some(9)).is_err());
    // rust: assert_eq!(as_text(&tag("\"x\"")).unwrap(), "x");
    // rust: assert_eq!(as_text(&tag("5b")).unwrap(), "5b");
    // rust: assert!(as_text(&tag("[1]")).is_err());
    // rust: let data = tag("{n:2.7d,s:\"abcd\",l:[1,2,3],c:{a:1,b:2},m:[1,2]}");
    // rust: assert_eq!(
    // rust: get_value(&single_tag(&path("n"), &data).unwrap(), &path("n")).unwrap(),
    // rust: 2
    // rust: );
    // rust: assert_eq!(
    // rust: get_value(&single_tag(&path("s"), &data).unwrap(), &path("s")).unwrap(),
    // rust: 4
    // rust: );
    // rust: assert_eq!(
    // rust: get_value(&single_tag(&path("l"), &data).unwrap(), &path("l")).unwrap(),
    // rust: 3
    // rust: );
    // rust: assert_eq!(
    // rust: get_value(&single_tag(&path("c"), &data).unwrap(), &path("c")).unwrap(),
    // rust: 2
    // rust: );
    // rust: assert_eq!(scaled_value(&Tag::Int(7), &path("n"), 0.5).unwrap(), 3);
    // rust: assert_eq!(
    // rust: scaled_value(&Tag::Double((-0.5f64).to_bits()), &path("n"), 1.0).unwrap(),
    // rust: -1
    // rust: );
    // rust: assert!(scaled_value(&tag("\"x\""), &path("s"), 1.0).is_err());
    // rust: assert_eq!(
    // rust: single_tag(&path("m[]"), &data).unwrap_err().message.plain(),
    // rust: "commands.data.get.multiple"
    // rust: );
    // rust: assert_eq!(scale_text(1.0).plain(), "1.00");
    // rust: assert_eq!(scale_text(0.125).plain(), "0.13");
}
}
