//! Transpiled from Horizon Rust crate
package horizon_client_core_nbt_path

import "core:fmt"
import "core:mem"
import "core:math"

// NBT paths (`NbtPathArgument`): `foo.bar[0]`, `[]`, `list[{id:1}]`,
// `{root:match}`, with get, set, insert and remove on a tag tree, and the
// partial NBT comparison (`NbtUtils.compareNbt`) selectors and conditions use.
// use horizon_world::nbt::{Compound, JavaString, Tag, parse_snbt};

// An error carrying the translation key and its arguments.
PathError :: struct {
    key: ^'static str,
    args: [dynamic]string,
    // Byte offset in the path text (parse errors).
    cursor: uint,
}
    // rust: impl PathError {
new :: proc(key: ^'static str, args: [dynamic]string, cursor: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { key, args, cursor }
}
}

Node :: enum {
    // `name`
    Child(String),
    // `name{pattern}`
    MatchChild(String, Tag),
    // `[]`
    AllElements,
    // `[n]`
    Index(i32),
    // `[{pattern}]`
    MatchElement(Tag),
    // `{pattern}` at the start.
    MatchRoot(Tag),
}
NbtPath :: struct {
    original: string,
    nodes: [dynamic]Node,
    // Byte offset just after each node in `original`.
    ends: [dynamic]uint,
}

key :: proc(s: string) -> J {
    // Ported from Horizon
    return {}
}
    // rust: JavaString::from(s)
}
    // rust: fn get_child<'a>(c: &'a Compound, name: &str) -> Option<&'a Tag> {
    // rust: c.get(&key(name))
}

// `NbtUtils.compareNbt(expected, actual, true)`.
compare_nbt :: proc(expected: ^Tag, actual: Maybe(^Tag)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(actual) = actual else { return false };
    // rust: if std::mem::discriminant(expected) != std::mem::discriminant(actual) {
    // rust: return false;
}
    // rust: match (expected, actual) {
    // rust: (Tag::Compound(e), Tag::Compound(a)) => {
    // rust: a.len() >= e.len() && e.iter().all(|(k, v)| compare_nbt(v, a.get(k)))
}
    // rust: (Tag::List(e), Tag::List(a)) => {
    // rust: if e.is_empty() {
    // rust: return a.is_empty();
}
    // rust: a.len() >= e.len() && e.iter().all(|x| a.iter().any(|y| compare_nbt(x, Some(y))))
}
    // rust: _ => expected == actual,
}
}

// ---- list-like tags ----------------------------------------------------------

// The elements of a list or array tag.
elements :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match tag {
    // rust: Tag::List(l) => l.clone(),
    // rust: Tag::ByteArray(a) => a.iter().map(|b| Tag::Byte(*b as i8)).collect(),
    // rust: Tag::IntArray(a) => a.iter().map(|v| Tag::Int(*v)).collect(),
    // rust: Tag::LongArray(a) => a.iter().map(|v| Tag::Long(*v)).collect(),
    // rust: _ => return None,
    // rust: })
}
// `DoubleTag.intValue` / `FloatTag.intValue` floor before the i32 conversion;
// integral tags use their intValue narrowing. Byte arrays then keep the low byte.
int_value :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match t {
    // rust: Tag::Byte(v) => i32::from(*v),
    // rust: Tag::Short(v) => i32::from(*v),
    // rust: Tag::Int(v) => *v,
    // rust: Tag::Long(v) => *v as i32,
    // rust: Tag::Float(v) => f32::from_bits(*v).floor() as i32,
    // rust: Tag::Double(v) => f64::from_bits(*v).floor() as i32,
    // rust: _ => return None,
    // rust: })
}
// `FloatTag.longValue` truncates; `DoubleTag.longValue` floors before narrowing.
long_value :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match t {
    // rust: Tag::Byte(v) => i64::from(*v),
    // rust: Tag::Short(v) => i64::from(*v),
    // rust: Tag::Int(v) => i64::from(*v),
    // rust: Tag::Long(v) => *v,
        // FloatTag.longValue truncates; DoubleTag.longValue floors first.
    // rust: Tag::Float(v) => f32::from_bits(*v) as i64,
    // rust: Tag::Double(v) => f64::from_bits(*v).floor() as i64,
    // rust: _ => return None,
    // rust: })
}
ElementKind :: enum {
    List,
    NumericArray,
}
    // rust: impl ElementKind {
    // Admission only: arrays require NumericTag; lists accept every tag type.
accepts :: proc(self: ^Self, value: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Self::List)
    // rust: || matches!(
    // rust: value,
    // rust: Tag::Byte(_)
    // rust: | Tag::Short(_)
    // rust: | Tag::Int(_)
    // rust: | Tag::Long(_)
    // rust: | Tag::Float(_)
    // rust: | Tag::Double(_)
    // rust: )
}
}
// Rust view adapter: run `f` over the elements, then write arrays using their numeric accessor.
// None when `tag` is not list-like.
    // rust: fn with_elements<R>(tag: &mut Tag, f: impl FnOnce(&mut Vec<Tag>, ElementKind) -> R) -> Option<R> {
    // rust: match tag {
    // rust: Tag::List(l) => Some(f(l, ElementKind::List)),
    // rust: Tag::ByteArray(_) | Tag::IntArray(_) | Tag::LongArray(_) => {
    // rust: let mut v = elements(tag)?;
    // rust: let r = f(&mut v, ElementKind::NumericArray);
    // rust: match tag {
                // Float/double byteValue uses intValue's floor, then narrows.
    // rust: Tag::ByteArray(a) => *a = v.iter().filter_map(int_value).map(|n| n as u8).collect(),
    // rust: Tag::IntArray(a) => *a = v.iter().filter_map(int_value).collect(),
    // rust: Tag::LongArray(a) => *a = v.iter().filter_map(long_value).collect(),
    // rust: _ => {}
}
    // rust: Some(r)
}
    // rust: _ => None,
}
}

    // rust: impl NbtPath {
    // `NbtPathArgument.parse` from the start of `text`; returns the path and
    // the bytes consumed (it stops at a space).
parse_prefix :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let b = text.as_bytes();
    // rust: let mut i = 0;
    // rust: let mut nodes = Vec::new();
    // rust: let mut ends = Vec::new();
    // rust: let mut first = true;
    // rust: while i < b.len() && b[i] != b' ' {
    // rust: let (node, next) = parse_node(text, i, first)?;
    // rust: nodes.push(node);
    // rust: i = next;
    // rust: ends.push(i);
    // rust: first = false;
    // rust: if i < b.len() && !matches!(b[i], b' ' | b'[' | b'{') {
    // rust: if b[i] != b'.' {
    // rust: return Err(PathError::new("parsing.expected", vec![".".into()], i));
}
    // rust: i += 1;
}
}
    // rust: Ok((
    // rust: NbtPath {
    // rust: original: text[..i].to_owned(),
    // rust: nodes,
    // rust: ends,
    // rust: },
    // rust: i,
    // rust: ))
}
parse :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (p, used) = Self::parse_prefix(text)?;
    // rust: if used != text.len() {
    // rust: return Err(PathError::new(
    // rust: "arguments.nbtpath.node.invalid",
    // rust: vec![],
    // rust: used,
    // rust: ));
}
    // rust: Ok(p)
}
as_str :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.original
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes.is_empty()
}
    // Whether this selects a compound-field chain, including filtered or quoted fields.
    // Matching a root or child does not change that subtree's writer provenance.
is_field_path :: proc(self: ^Self, fields: ^[string]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut fields = fields.iter();
    // rust: for node in &self.nodes {
    // rust: match node {
    // rust: Node::MatchRoot(_) => {}
    // rust: Node::Child(name) | Node::MatchChild(name, _)
    // rust: if fields.next().copied() == Some(name.as_str()) => {}
    // rust: _ => return false,
}
}
    // rust: fields.next().is_none()
}
not_found :: proc(self: ^Self, node: uint) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let end = self.ends[node];
    // rust: PathError::new(
    // rust: "arguments.nbtpath.nothing_found",
    // rust: vec![self.original[..end.min(self.original.len())].to_owned()],
    // rust: 0,
    // rust: )
}

    // ---- reading --------------------------------------------------------

    // rust: fn step<'a>(node: &Node, parent: &'a Tag, out: &mut Vec<&'a Tag>) {
    // rust: match node {
    // rust: Node::Child(name) => {
    // rust: if let Tag::Compound(c) = parent
    // rust: && let Some(t) = get_child(c, name)
    // rust: {
    // rust: out.push(t);
}
}
    // rust: Node::MatchChild(name, pattern) => {
    // rust: if let Tag::Compound(c) = parent
    // rust: && let Some(t) = get_child(c, name)
    // rust: && compare_nbt(pattern, Some(t))
    // rust: {
    // rust: out.push(t);
}
}
    // rust: Node::AllElements => {
    // rust: if let Tag::List(l) = parent {
    // rust: out.extend(l.iter());
}
}
    // rust: Node::Index(i) => {
    // rust: if let Tag::List(l) = parent {
    // rust: let n = l.len() as i64;
    // rust: let idx = if *i < 0 {
    // rust: n + i64::from(*i)
    // rust: } else {
    // rust: i64::from(*i)
}
    // rust: if (0..n).contains(&idx) {
    // rust: out.push(&l[idx as usize]);
}
}
}
    // rust: Node::MatchElement(pattern) => {
    // rust: if let Tag::List(l) = parent {
    // rust: out.extend(l.iter().filter(|t| compare_nbt(pattern, Some(t))));
}
}
    // rust: Node::MatchRoot(pattern) => {
    // rust: if matches!(parent, Tag::Compound(_)) && compare_nbt(pattern, Some(parent)) {
    // rust: out.push(parent);
}
}
}
}
    // Array tags read as lists of their elements.
read_steps :: proc(self: ^Self, root: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut current: Vec<Tag> = vec![root.clone()];
    // rust: for (i, node) in self.nodes.iter().enumerate() {
    // rust: let mut next = Vec::new();
    // rust: for parent in &current {
                // Arrays expose their elements to element nodes.
    // rust: let list;
    // rust: let p = if matches!(node, Node::AllElements | Node::Index(_)) {
    // rust: match elements(parent) {
    // rust: Some(l) if !matches!(parent, Tag::List(_)) => {
    // rust: list = Tag::List(l);
    // rust: &list
}
    // rust: _ => parent,
}
    // rust: } else {
    // rust: parent
}
    // rust: let mut out = Vec::new();
    // rust: Self::step(node, p, &mut out);
    // rust: next.extend(out.into_iter().cloned());
}
    // rust: if next.is_empty() {
    // rust: return Err(self.not_found(i));
}
    // rust: current = next;
}
    // rust: Ok(current)
}
    // `get`: every matching tag (an error when nothing matches).
get :: proc(self: ^Self, root: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.read_steps(root)
}
    // `countMatching`.
count :: proc(self: ^Self, root: ^Tag) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.read_steps(root).map_or(0, |v| v.len())
}

    // ---- writing --------------------------------------------------------

    // The parents of the last node, creating the missing ones (`getOrCreateParents`).
    // rust: fn visit_parents(
    // rust: &self,
    // rust: root: &mut Tag,
    // rust: create: bool,
    // rust: f: &mut dyn FnMut(&mut Tag),
    // rust: ) -> Result<(), PathError> {
    // rust: self.descend(0, self.nodes.len().saturating_sub(1), root, create, None, f)
}
    // Walk `nodes[from..to]` from `tag`, calling `f` on every tag reached.
    // rust: fn descend(
    // rust: &self,
    // rust: from: usize,
    // rust: to: usize,
    // rust: tag: &mut Tag,
    // rust: create: bool,
    // rust: last_value: Option<&dyn Fn() -> Tag>,
    // rust: f: &mut dyn FnMut(&mut Tag),
    // rust: ) -> Result<(), PathError> {
    // rust: if from >= to {
    // rust: f(tag);
    // rust: return Ok(());
}
    // rust: let node = &self.nodes[from];
        // What a created child should be: the next node's preferred parent,
        // or the caller's value for the last node.
    // rust: let default_child = || -> Tag {
    // rust: match (self.nodes.get(from + 1), last_value) {
    // rust: (Some(next), _) if from + 1 < to => preferred_parent(next),
    // rust: (_, Some(v)) => v(),
    // rust: (Some(next), None) => preferred_parent(next),
    // rust: _ => Tag::Compound(Compound::new()),
}
}
    // rust: let mut found = false;
    // rust: let mut error = None;
    // rust: let mut visit = |child: &mut Tag| {
    // rust: found = true;
    // rust: if error.is_none()
    // rust: && let Err(e) = self.descend(from + 1, to, child, create, last_value, f)
    // rust: {
    // rust: error = Some(e);
}
}
    // rust: step_mut(
    // rust: node,
    // rust: tag,
    // rust: create.then_some(&default_child as &dyn Fn() -> Tag),
    // rust: &mut visit,
    // rust: );
    // rust: if let Some(e) = error {
    // rust: return Err(e);
}
    // rust: if !found {
    // rust: return Err(self.not_found(from));
}
    // rust: Ok(())
}
    // `getOrCreate`: the tags at the path, creating missing ones as
    // `new_value` (used for the last node).
    // rust: pub fn get_or_create(
    // rust: &self,
    // rust: root: &mut Tag,
    // rust: new_value: &dyn Fn() -> Tag,
    // rust: f: &mut dyn FnMut(&mut Tag),
    // rust: ) -> Result<(), PathError> {
    // rust: self.descend(0, self.nodes.len(), root, true, Some(new_value), f)
}
    // `set`: returns how many tags changed.
set :: proc(self: ^Self, root: ^Tag, value: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if too_deep(value, self.nodes.len()) {
    // rust: return Err(PathError::new("arguments.nbtpath.too_deep", vec![], 0));
}
    // rust: let Some(last) = self.nodes.last() else {
    // rust: return Ok(0);
}
    // rust: let mut changed = 0;
    // rust: self.visit_parents(root, true, &mut |parent| {
    // rust: changed += set_tag(last, parent, value);
    // rust: })?;
    // rust: Ok(changed)
}
    // `remove`: returns how many tags were removed.
remove :: proc(self: ^Self, root: ^Tag) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let Some(last) = self.nodes.last() else {
    // rust: return 0;
}
    // rust: let mut removed = 0;
    // rust: let _ = self.visit_parents(root, false, &mut |parent| {
    // rust: removed += remove_tag(last, parent);
    // rust: });
    // rust: removed
}
    // `NbtPathArgument.NbtPath.insert`: insert accepted tags into every reached collection.
    // rust: pub fn insert(
    // rust: &self,
    // rust: index: i32,
    // rust: root: &mut Tag,
    // rust: values: &[Tag],
    // rust: ) -> Result<usize, CollectionError> {
    // rust: for v in values {
    // rust: if too_deep(v, self.nodes.len()) {
    // rust: return Err(CollectionError::Path(PathError::new(
    // rust: "arguments.nbtpath.too_deep",
    // rust: vec![],
    // rust: 0,
    // rust: )));
}
}
    // rust: let mut modified = 0;
    // rust: let mut error: Option<CollectionError> = None;
    // rust: self.get_or_create(root, &|| Tag::List(Vec::new()), &mut |target| {
    // rust: if error.is_some() {
    // rust: return;
}
    // rust: let shown = crate::snbt::to_snbt(target);
    // rust: let result = with_elements(target, |list, kind| {
    // rust: let start = if index < 0 {
    // rust: list.len() as i64 + i64::from(index) + 1
    // rust: } else {
    // rust: i64::from(index)
}
    // rust: let mut any = false;
    // rust: let mut at = start;
    // rust: for v in values {
    // rust: if !kind.accepts(v) {
    // rust: continue;
}
    // rust: if at < 0 || at as usize > list.len() {
    // rust: return Err(CollectionError::InvalidIndex(at as i32));
}
    // rust: list.insert(at as usize, v.clone());
    // rust: at += 1;
    // rust: any = true;
}
    // rust: Ok(any)
    // rust: });
    // rust: match result {
    // rust: None => error = Some(CollectionError::ExpectedList(shown)),
    // rust: Some(Err(e)) => error = Some(e),
    // rust: Some(Ok(any)) => modified += usize::from(any),
}
    // rust: })
    // rust: .map_err(CollectionError::Path)?;
    // rust: match error {
    // rust: Some(e) => Err(e),
    // rust: None => Ok(modified),
}
}
}
CollectionError :: enum {
    Path(PathError),
    // `commands.data.modify.expected_list` with the offending tag.
    ExpectedList(String),
    // `commands.data.modify.invalid_index`.
    InvalidIndex(i32),
}

// `isTooDeep`.
too_deep :: proc(tag: ^Tag, depth: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if depth >= 512 {
    // rust: return true;
}
    // rust: match tag {
    // rust: Tag::Compound(c) => c.values().any(|t| too_deep(t, depth + 1)),
    // rust: Tag::List(l) => l.iter().any(|t| too_deep(t, depth + 1)),
    // rust: _ => false,
}
}
preferred_parent :: proc(node: ^Node) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match node {
    // rust: Node::AllElements | Node::Index(_) | Node::MatchElement(_) => Tag::List(Vec::new()),
    // rust: _ => Tag::Compound(Compound::new()),
}
}
// Children of `parent`; the array creation arm follows
// `NbtPathArgument.AllElementsNode.getOrCreateTag` admission.
    // rust: fn step_mut(
    // rust: node: &Node,
    // rust: parent: &mut Tag,
    // rust: create: Option<&dyn Fn() -> Tag>,
    // rust: out: &mut dyn FnMut(&mut Tag),
    // rust: ) {
    // rust: match node {
    // rust: Node::Child(name) => {
    // rust: if let Tag::Compound(c) = parent {
    // rust: let k = key(name);
    // rust: if !c.contains_key(&k) {
    // rust: let Some(make) = create else { return };
    // rust: c.insert(k.clone(), make());
}
    // rust: if let Some(t) = c.get_mut(&k) {
    // rust: out(t);
}
}
}
    // rust: Node::MatchChild(name, pattern) => {
    // rust: if let Tag::Compound(c) = parent {
    // rust: let k = key(name);
    // rust: if !c.contains_key(&k) {
    // rust: if create.is_none() {
    // rust: return;
}
    // rust: c.insert(k.clone(), pattern.clone());
    // rust: if let Some(t) = c.get_mut(&k) {
    // rust: out(t);
}
    // rust: } else if let Some(t) = c.get_mut(&k)
    // rust: && compare_nbt(pattern, Some(t))
    // rust: {
    // rust: out(t);
}
}
}
    // rust: Node::AllElements => {
    // rust: let make = create;
    // rust: let _ = with_elements(parent, |list, kind| {
    // rust: if list.is_empty() {
    // rust: if let Some(make) = make {
    // rust: let value = make();
    // rust: if kind.accepts(&value) {
    // rust: list.push(value);
    // rust: out(&mut list[0]);
}
}
    // rust: } else {
    // rust: for t in list.iter_mut() {
    // rust: out(t);
}
}
    // rust: });
}
    // rust: Node::Index(i) => {
    // rust: let _ = with_elements(parent, |list, _kind| {
    // rust: let n = list.len() as i64;
    // rust: let idx = if *i < 0 {
    // rust: n + i64::from(*i)
    // rust: } else {
    // rust: i64::from(*i)
}
    // rust: if (0..n).contains(&idx) {
    // rust: out(&mut list[idx as usize]);
}
    // rust: });
}
    // rust: Node::MatchElement(pattern) => {
    // rust: if let Tag::List(list) = parent {
    // rust: let mut any = false;
    // rust: for t in list.iter_mut() {
    // rust: if compare_nbt(pattern, Some(t)) {
    // rust: any = true;
    // rust: out(t);
}
}
    // rust: if !any && create.is_some() {
    // rust: list.push(pattern.clone());
    // rust: if let Some(t) = list.last_mut() {
    // rust: out(t);
}
}
}
}
    // rust: Node::MatchRoot(pattern) => {
    // rust: if matches!(parent, Tag::Compound(_)) && compare_nbt(pattern, Some(parent)) {
    // rust: out(parent);
}
}
}
}
// Element setters follow `NbtPathArgument.AllElementsNode.setTag` and
// `NbtPathArgument.IndexedElementNode.setTag`; object nodes replace their children.
set_tag :: proc(node: ^Node, parent: ^Tag, value: ^Tag) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match node {
    // rust: Node::Child(name) => {
    // rust: if let Tag::Compound(c) = parent {
    // rust: let prev = c.insert(key(name), value.clone());
    // rust: return usize::from(prev.as_ref() != Some(value));
}
    // rust: 0
}
    // rust: Node::MatchChild(name, pattern) => {
    // rust: if let Tag::Compound(c) = parent {
    // rust: let k = key(name);
    // rust: if compare_nbt(pattern, c.get(&k)) && c.get(&k) != Some(value) {
    // rust: c.insert(k, value.clone());
    // rust: return 1;
}
}
    // rust: 0
}
    // rust: Node::AllElements => with_elements(parent, |list, kind| {
    // rust: let len = list.len();
    // rust: if len == 0 {
    // rust: if kind.accepts(value) {
    // rust: list.push(value.clone());
}
                // AllElementsNode returns 1 here even when addTag rejects.
    // rust: return 1;
}
            // Compare the original tags, before numeric conversion.
    // rust: let changed = list.iter().filter(|t| *t != value).count();
    // rust: if changed == 0 {
    // rust: return 0;
}
    // rust: list.clear();
    // rust: if !kind.accepts(value) {
    // rust: return 0;
}
    // rust: list.resize(len, value.clone());
    // rust: changed
    // rust: })
    // rust: .unwrap_or(0),
    // rust: Node::Index(i) => with_elements(parent, |list, kind| {
    // rust: let n = list.len() as i64;
    // rust: let idx = if *i < 0 {
    // rust: n + i64::from(*i)
    // rust: } else {
    // rust: i64::from(*i)
}
    // rust: if (0..n).contains(&idx) && list[idx as usize] != *value && kind.accepts(value) {
    // rust: list[idx as usize] = value.clone();
    // rust: 1
    // rust: } else {
    // rust: 0
}
    // rust: })
    // rust: .unwrap_or(0),
    // rust: Node::MatchElement(pattern) => {
    // rust: let Tag::List(list) = parent else { return 0 };
    // rust: if list.is_empty() {
    // rust: list.push(value.clone());
    // rust: return 1;
}
    // rust: let mut changed = 0;
    // rust: for t in list.iter_mut() {
    // rust: if compare_nbt(pattern, Some(t)) && t != value {
    // rust: *t = value.clone();
    // rust: changed += 1;
}
}
    // rust: changed
}
    // rust: Node::MatchRoot(_) => 0,
}
}
// Removal arms, including `NbtPathArgument.AllElementsNode.removeTag`.
remove_tag :: proc(node: ^Node, parent: ^Tag) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match node {
    // rust: Node::Child(name) => match parent {
    // rust: Tag::Compound(c) => usize::from(c.remove(&key(name)).is_some()),
    // rust: _ => 0,
    // rust: },
    // rust: Node::MatchChild(name, pattern) => match parent {
    // rust: Tag::Compound(c) => {
    // rust: let k = key(name);
    // rust: if compare_nbt(pattern, c.get(&k)) {
    // rust: usize::from(c.remove(&k).is_some())
    // rust: } else {
    // rust: 0
}
}
    // rust: _ => 0,
    // rust: },
    // rust: Node::AllElements => with_elements(parent, |l, _kind| {
    // rust: let n = l.len();
    // rust: l.clear();
    // rust: n
    // rust: })
    // rust: .unwrap_or(0),
    // rust: Node::Index(i) => with_elements(parent, |l, _kind| {
    // rust: let n = l.len() as i64;
    // rust: let idx = if *i < 0 {
    // rust: n + i64::from(*i)
    // rust: } else {
    // rust: i64::from(*i)
}
    // rust: if (0..n).contains(&idx) {
    // rust: l.remove(idx as usize);
    // rust: 1
    // rust: } else {
    // rust: 0
}
    // rust: })
    // rust: .unwrap_or(0),
    // rust: Node::MatchElement(pattern) => match parent {
    // rust: Tag::List(l) => {
    // rust: let before = l.len();
    // rust: l.retain(|t| !compare_nbt(pattern, Some(t)));
    // rust: before - l.len()
}
    // rust: _ => 0,
    // rust: },
    // rust: Node::MatchRoot(_) => 0,
}
}

// ---- parsing -------------------------------------------------------------------

parse_node :: proc(text: string, i: uint, first: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let b = text.as_bytes();
    // rust: let invalid = |at: usize| PathError::new("arguments.nbtpath.node.invalid", vec![], at);
    // rust: match b[i] {
    // rust: b'"' | b'\'' => {
    // rust: let (name, next) = read_quoted(text, i)?;
    // rust: read_object_node(text, name, next)
}
    // rust: b'[' => {
    // rust: let mut j = i + 1;
    // rust: match b.get(j) {
    // rust: Some(b'{') => {
    // rust: let (pattern, next) = parse_compound(text, j)?;
    // rust: j = next;
    // rust: expect(text, j, b']')?;
    // rust: Ok((Node::MatchElement(pattern), j + 1))
}
    // rust: Some(b']') => Ok((Node::AllElements, j + 1)),
    // rust: _ => {
    // rust: let start = j;
    // rust: if b.get(j) == Some(&b'-') {
    // rust: j += 1;
}
    // rust: while b.get(j).is_some_and(u8::is_ascii_digit) {
    // rust: j += 1;
}
    // rust: let n: i32 = text[start..j].parse().map_err(|_| {
    // rust: PathError::new(
    // rust: "parsing.int.invalid",
    // rust: vec![text[start..j].to_owned()],
    // rust: start,
    // rust: )
    // rust: })?;
    // rust: expect(text, j, b']')?;
    // rust: Ok((Node::Index(n), j + 1))
}
}
}
    // rust: b'{' => {
    // rust: if !first {
    // rust: return Err(invalid(i));
}
    // rust: let (pattern, next) = parse_compound(text, i)?;
    // rust: Ok((Node::MatchRoot(pattern), next))
}
    // rust: _ => {
    // rust: let mut j = i;
    // rust: while j < b.len()
    // rust: && !matches!(b[j], b' ' | b'"' | b'\'' | b'[' | b']' | b'.' | b'{' | b'}')
    // rust: {
    // rust: j += 1;
}
    // rust: if j == i {
    // rust: return Err(invalid(i));
}
    // rust: read_object_node(text, text[i..j].to_owned(), j)
}
}
}
read_object_node :: proc(text: string, name: string, i: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if name.is_empty() {
    // rust: return Err(PathError::new("arguments.nbtpath.node.invalid", vec![], i));
}
    // rust: if text.as_bytes().get(i) == Some(&b'{') {
    // rust: let (pattern, next) = parse_compound(text, i)?;
    // rust: return Ok((Node::MatchChild(name, pattern), next));
}
    // rust: Ok((Node::Child(name), i))
}
expect :: proc(text: string, i: uint, c: u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if text.as_bytes().get(i) == Some(&c) {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(PathError::new(
    // rust: "parsing.expected",
    // rust: vec![(c as char).to_string()],
    // rust: i,
    // rust: ))
}
}
read_quoted :: proc(text: string, i: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let quote = text.as_bytes()[i] as char;
    // rust: let mut out = String::new();
    // rust: let mut escaped = false;
    // rust: for (o, c) in text[i + 1..].char_indices() {
    // rust: if escaped {
    // rust: out.push(c);
    // rust: escaped = false;
    // rust: } else if c == '\\' {
    // rust: escaped = true;
    // rust: } else if c == quote {
    // rust: return Ok((out, i + 1 + o + c.len_utf8()));
    // rust: } else {
    // rust: out.push(c);
}
}
    // rust: Err(PathError::new(
    // rust: "parsing.quote.expected.end",
    // rust: vec![],
    // rust: text.len(),
    // rust: ))
}
parse_compound :: proc(text: string, i: uint) -> R {
    // Ported from Horizon
    return {}
}
    // Find the balanced end of the braces, then parse the SNBT inside.
    // rust: let b = text.as_bytes();
    // rust: let mut depth = 0;
    // rust: let mut quote: Option<u8> = None;
    // rust: let mut j = i;
    // rust: while j < b.len() {
    // rust: let c = b[j];
    // rust: match quote {
    // rust: Some(_) if c == b'\\' => j += 1,
    // rust: Some(q) if c == q => quote = None,
    // rust: Some(_) => {}
    // rust: None if c == b'"' || c == b'\'' => quote = Some(c),
    // rust: None if c == b'{' || c == b'[' => depth += 1,
    // rust: None if c == b'}' || c == b']' => {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: let (tag, _) = parse_snbt(&text[i..=j])
    // rust: .map_err(|e| PathError::new("argument.nbt.invalid", vec![e], i))?;
    // rust: return Ok((tag, j + 1));
}
}
    // rust: None => {}
}
    // rust: j += 1;
}
    // rust: Err(PathError::new("argument.nbt.expected.compound", vec![], i))
}

    // rust: mod tests {
//     use super::*;
field_provenance_handles_quotes_and_filters_without_matching_lists :: proc() {
}
    // rust: for text in [
    // rust: "blockState.properties",
    // rust: "\"blockState\".\"properties\"",
    // rust: "{source:1b}.blockState.properties",
    // rust: "blockState{id:\"minecraft:piston_head\"}.properties",
    // rust: ] {
    // rust: let path = NbtPath::parse(text).unwrap();
    // rust: assert!(path.is_field_path(&["blockState", "properties"]));
    // rust: assert!(!path.is_field_path(&["blockState"]));
}
    // rust: assert!(NbtPath::parse("{source:1b}").unwrap().is_field_path(&[]));
    // rust: assert!(
    // rust: !NbtPath::parse("blockState[].properties")
    // rust: .unwrap()
    // rust: .is_field_path(&["blockState", "properties"])
    // rust: );
}

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
    // rust: NbtPath::parse(s).unwrap_or_else(|e| panic!("{s}: {e:?}"))
}
show :: proc(v: ^[Tag]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: v.iter().map(crate::snbt::to_snbt).collect()
}

get_follows_the_path :: proc() {
}
    // rust: let root = tag("{a:{b:[{id:1,n:\"x\"},{id:2,n:\"y\"},{id:3}]},c:5,\"d e\":7}");
    // rust: assert_eq!(show(&path("c").get(&root).unwrap()), ["5"]);
    // rust: assert_eq!(show(&path("\"d e\"").get(&root).unwrap()), ["7"]);
    // rust: assert_eq!(show(&path("a.b[0].n").get(&root).unwrap()), ["\"x\""]);
    // rust: assert_eq!(show(&path("a.b[-1]").get(&root).unwrap()), ["{id:3}"]);
    // rust: assert_eq!(show(&path("a.b[].id").get(&root).unwrap()), ["1", "2", "3"]);
    // rust: assert_eq!(show(&path("a.b[{id:2}].n").get(&root).unwrap()), ["\"y\""]);
    // rust: assert_eq!(
    // rust: show(&path("a{b:[{id:1}]}.b[0].id").get(&root).unwrap()),
    // rust: ["1"]
    // rust: );
    // rust: assert_eq!(show(&path("{c:5}.c").get(&root).unwrap()), ["5"]);
    // rust: assert!(path("{c:6}.c").get(&root).is_err());
    // rust: let e = path("a.zzz.q").get(&root).unwrap_err();
    // rust: assert_eq!(e.key, "arguments.nbtpath.nothing_found");
    // rust: assert_eq!(e.args, ["a.zzz"]);
    // rust: assert_eq!(path("a.b[].id").count(&root), 3);
    // rust: assert_eq!(path("a.nope").count(&root), 0);
        // Arrays act like lists.
    // rust: let arr = tag("{v:[I;4,5,6]}");
    // rust: assert_eq!(show(&path("v[1]").get(&arr).unwrap()), ["5"]);
    // rust: assert_eq!(show(&path("v[]").get(&arr).unwrap()), ["4", "5", "6"]);
}

parse_errors :: proc() {
}
    // rust: assert_eq!(
    // rust: NbtPath::parse("a..b").unwrap_err().key,
    // rust: "arguments.nbtpath.node.invalid"
    // rust: );
    // rust: assert_eq!(
    // rust: NbtPath::parse("a.{b:1}").unwrap_err().key,
    // rust: "arguments.nbtpath.node.invalid"
    // rust: );
    // rust: assert_eq!(NbtPath::parse("a[1").unwrap_err().key, "parsing.expected");
    // rust: assert_eq!(NbtPath::parse("a]").unwrap_err().key, "parsing.expected");
    // rust: let (p, used) = NbtPath::parse_prefix("a.b[0] rest").unwrap();
    // rust: assert_eq!((p.as_str(), used), ("a.b[0]", 6));
}

set_creates_and_reports_changes :: proc() {
}
    // rust: let mut root = tag("{a:{x:1}}");
    // rust: assert_eq!(path("a.x").set(&mut root, &tag("2")).unwrap(), 1);
    // rust: assert_eq!(path("a.x").set(&mut root, &tag("2")).unwrap(), 0);
    // rust: assert_eq!(path("b.c.d").set(&mut root, &tag("\"deep\"")).unwrap(), 1);
    // rust: assert_eq!(crate::snbt::to_snbt(&root), "{a:{x:2},b:{c:{d:\"deep\"}}}");
    // rust: let mut root = tag("{l:[1,2,3]}");
    // rust: assert_eq!(path("l[1]").set(&mut root, &tag("9")).unwrap(), 1);
    // rust: assert_eq!(path("l[7]").set(&mut root, &tag("9")).unwrap(), 0);
    // rust: assert_eq!(path("l[]").set(&mut root, &tag("0")).unwrap(), 3);
    // rust: assert_eq!(crate::snbt::to_snbt(&root), "{l:[0,0,0]}");
    // rust: let mut root = tag("{l:[{id:1,v:0},{id:2,v:0}]}");
    // rust: assert_eq!(path("l[{id:2}].v").set(&mut root, &tag("5")).unwrap(), 1);
    // rust: assert_eq!(crate::snbt::to_snbt(&root), "{l:[{id:1,v:0},{id:2,v:5}]}");
        // A missing match is created from the pattern.
    // rust: assert_eq!(path("l[{id:3}].v").set(&mut root, &tag("1")).unwrap(), 1);
    // rust: assert_eq!(path("l[{id:3}].v").count(&root), 1);
        // New lists come from index nodes.
    // rust: let mut root = tag("{}");
    // rust: assert_eq!(path("x[].y").set(&mut root, &tag("1")).unwrap(), 1);
    // rust: assert_eq!(crate::snbt::to_snbt(&root), "{x:[{y:1}]}");
}

remove_counts :: proc() {
}
    // rust: let mut root = tag("{a:1,l:[1,2,3,2],c:{d:1}}");
    // rust: assert_eq!(path("a").remove(&mut root), 1);
    // rust: assert_eq!(path("a").remove(&mut root), 0);
    // rust: assert_eq!(path("l[1]").remove(&mut root), 1);
    // rust: assert_eq!(path("c.d").remove(&mut root), 1);
    // rust: assert_eq!(crate::snbt::to_snbt(&root), "{c:{},l:[1,3,2]}");
    // rust: let mut root = tag("{l:[{k:1},{k:2},{k:1}]}");
    // rust: assert_eq!(path("l[{k:1}]").remove(&mut root), 2);
    // rust: assert_eq!(crate::snbt::to_snbt(&root), "{l:[{k:2}]}");
    // rust: assert_eq!(path("l[]").remove(&mut root), 1);
}

insert_positions :: proc() {
}
    // rust: let mut root = tag("{l:[1,2]}");
    // rust: assert_eq!(path("l").insert(0, &mut root, &[tag("0")]).unwrap(), 1);
    // rust: assert_eq!(path("l").insert(-1, &mut root, &[tag("9")]).unwrap(), 1);
    // rust: assert_eq!(
    // rust: path("l")
    // rust: .insert(1, &mut root, &[tag("5"), tag("6")])
    // rust: .unwrap(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(crate::snbt::to_snbt(&root), "{l:[0,5,6,1,2,9]}");
    // rust: assert_eq!(
    // rust: path("l").insert(99, &mut root, &[tag("1")]).unwrap_err(),
    // rust: CollectionError::InvalidIndex(99)
    // rust: );
        // A missing list is created.
    // rust: assert_eq!(path("n").insert(-1, &mut root, &[tag("1")]).unwrap(), 1);
    // rust: assert!(matches!(
    // rust: path("l[0]").insert(0, &mut root, &[tag("1")]).unwrap_err(),
    // rust: CollectionError::ExpectedList(_)
    // rust: ));
}

numeric_array_edits_use_the_destination_numeric_accessor :: proc() {
}
    // rust: for (initial, value, inserted, indexed, all) in [
    // rust: (
    // rust: "{v:[B;1b,2b]}",
    // rust: "-3.5f",
    // rust: "{v:[B;1b,-4b,2b]}",
    // rust: "{v:[B;-4b,2b]}",
    // rust: "{v:[B;-4b,-4b]}",
    // rust: ),
    // rust: (
    // rust: "{v:[B;1b,2b]}",
    // rust: "-3.5d",
    // rust: "{v:[B;1b,-4b,2b]}",
    // rust: "{v:[B;-4b,2b]}",
    // rust: "{v:[B;-4b,-4b]}",
    // rust: ),
    // rust: (
    // rust: "{v:[I;1,2]}",
    // rust: "-3.5f",
    // rust: "{v:[I;1,-4,2]}",
    // rust: "{v:[I;-4,2]}",
    // rust: "{v:[I;-4,-4]}",
    // rust: ),
    // rust: (
    // rust: "{v:[I;1,2]}",
    // rust: "-3.5d",
    // rust: "{v:[I;1,-4,2]}",
    // rust: "{v:[I;-4,2]}",
    // rust: "{v:[I;-4,-4]}",
    // rust: ),
    // rust: (
    // rust: "{v:[L;1L,2L]}",
    // rust: "-3.5f",
    // rust: "{v:[L;1L,-3L,2L]}",
    // rust: "{v:[L;-3L,2L]}",
    // rust: "{v:[L;-3L,-3L]}",
    // rust: ),
    // rust: (
    // rust: "{v:[L;1L,2L]}",
    // rust: "-3.5d",
    // rust: "{v:[L;1L,-4L,2L]}",
    // rust: "{v:[L;-4L,2L]}",
    // rust: "{v:[L;-4L,-4L]}",
    // rust: ),
    // rust: ] {
    // rust: let value = tag(value);
    // rust: let mut root = tag(initial);
    // rust: assert_eq!(
    // rust: path("v")
    // rust: .insert(1, &mut root, std::slice::from_ref(&value))
    // rust: .unwrap(),
    // rust: 1
    // rust: );
    // rust: assert_eq!(root, tag(inserted));
    // rust: let mut root = tag(initial);
    // rust: assert_eq!(path("v[0]").set(&mut root, &value).unwrap(), 1);
    // rust: assert_eq!(root, tag(indexed));
    // rust: let mut root = tag(initial);
    // rust: assert_eq!(path("v[]").set(&mut root, &value).unwrap(), 2);
    // rust: assert_eq!(root, tag(all));
}
}

numeric_arrays_reject_nonnumeric_insert_and_indexed_set :: proc() {
}
    // rust: for initial in ["{v:[B;1b,2b]}", "{v:[I;1,2]}", "{v:[L;1L,2L]}"] {
    // rust: let original = tag(initial);
    // rust: let value = tag("\"bad\"");
    // rust: for index in [0, 99, -99] {
    // rust: let mut root = original.clone();
    // rust: assert_eq!(
    // rust: path("v")
    // rust: .insert(index, &mut root, std::slice::from_ref(&value))
    // rust: .unwrap(),
    // rust: 0
    // rust: );
    // rust: assert_eq!(root, original);
}
    // rust: let mut root = original.clone();
    // rust: assert_eq!(path("v[0]").set(&mut root, &value).unwrap(), 0);
    // rust: assert_eq!(root, original);
}
}

empty_array_wildcard_set_preserves_vanillas_count_on_rejection :: proc() {
}
    // rust: for initial in ["{v:[B;]}", "{v:[I;]}", "{v:[L;]}"] {
    // rust: let mut root = tag(initial);
    // rust: assert_eq!(path("v[]").set(&mut root, &tag("\"bad\"")).unwrap(), 1);
    // rust: assert_eq!(root, tag(initial));
}
}

partial_comparison :: proc() {
}
    // rust: let actual = tag("{a:1,b:{c:[1,2,3],d:\"x\"},e:2}");
    // rust: assert!(compare_nbt(&tag("{b:{c:[2]}}"), Some(&actual)));
    // rust: assert!(compare_nbt(&tag("{a:1}"), Some(&actual)));
    // rust: assert!(!compare_nbt(&tag("{a:2}"), Some(&actual)));
    // rust: assert!(!compare_nbt(&tag("{a:1L}"), Some(&actual)));
    // rust: assert!(!compare_nbt(&tag("{z:1}"), Some(&actual)));
    // rust: assert!(compare_nbt(&tag("{b:{c:[]}}"), Some(&tag("{b:{c:[]}}"))));
    // rust: assert!(!compare_nbt(&tag("{b:{c:[]}}"), Some(&actual)));
}
}
