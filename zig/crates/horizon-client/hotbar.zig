//! Transpiled from Horizon Rust crate
//! Module: horizon-client_hotbar
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The creative mode toolbars of `hotbar.nbt` (`HotbarManager`,
//! `Hotbar`): nine saved rows of nine stacks, read through the `HOTBAR`
//! data fixers when the file is from an older version.
// use crate::{items::ItemStack, save};
// use horizon_world::nbt::{JavaString, Tag};
// use std::path::Path;

/// `HotbarManager.NUM_HOTBAR_GROUPS`.
pub const GROUPS: usize = 9;
/// `Inventory.getSelectionSize`: the stacks of one saved row.
pub const SIZE: usize = 9;

/// One saved toolbar row.
    // rust: pub type Hotbar = Vec<Option<ItemStack>>;

pub fn empty() H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vec![None; SIZE]
}

/// `Hotbar.CODEC` and `Hotbar.load` on the row's tag: a row of fewer than nine
/// entries is lost, a longer one is cut (`Util.fixedSize` returns the first
/// nine as a partial result), an entry that is not a stack is empty.
pub fn row(tag: ?*Tag, known: *dyn Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::List(items)) = tag else {
    // rust: return empty();
}
    // rust: if items.len() < SIZE {
    // rust: return empty();
}
    // rust: items.iter().take(SIZE).map(|t| stack(t, known)).collect()
}

/// `ItemStack.OPTIONAL_CODEC` of a saved stack: the count is lenient (1
/// unless it is a number from 1 to 99), an item that is not registered is an
/// error.
pub fn stack(tag: *Tag, known: *dyn Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stack = save::item_from_nbt(tag)?;
    // rust: if !known(&stack.item) {
    // rust: return None;
}
    // rust: let count = match tag.get("count") {
    // rust: Some(Tag::Byte(n)) => i32::from(*n),
    // rust: Some(Tag::Short(n)) => i32::from(*n),
    // rust: Some(Tag::Int(n)) => *n,
    // rust: _ => 1,
}
    // rust: Some(ItemStack {
    // rust: count: if (1..=99).contains(&count) {
    // rust: count as u32
    // rust: } else {
    // rust: 1
    // rust: },
    // rust: ..stack
    // rust: })
}

/// `HotbarManager.load` on the file's tag.
pub fn from_tag(mut tag: Tag, known: *dyn Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let version = match tag.get("DataVersion") {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: _ => 1343,
}
    // Until the last fixer that rewrites item stacks (`UnfilledBuriedTreasureMapFix`,
    // 5016) the fixers read each row as a list of stacks: an entry that is
    // none is dropped from its row (a bare item id is a stack from 3818.5 on)
    // and a row that is no list ends the reading. After that fixer nothing
    // reads the rows and bare ids are no stacks.
pub const LAST_STACK_FIXER: i32 = 5016;
    // rust: if version < horizon_world::DATA_VERSION
    // rust: && let Tag::Compound(rows) = &mut tag
    // rust: {
    // rust: if version < LAST_STACK_FIXER {
            // A row that is no list stops the traversal there: it and the
            // rows after it (in key order) are lost.
    // rust: let broken = (0..GROUPS).find(|i| {
    // rust: rows.get(&JavaString::from(i.to_string().as_str()))
    // rust: .is_some_and(|r| {
    // rust: !matches!(
    // rust: r,
    // rust: Tag::List(_) | Tag::ByteArray(_) | Tag::IntArray(_) | Tag::LongArray(_)
    // rust: )
    // rust: })
    // rust: });
    // rust: if let Some(broken) = broken {
    // rust: for i in broken..GROUPS {
    // rust: rows.remove(&JavaString::from(i.to_string().as_str()));
}
}
            // Entries that are no stacks are dropped from their row.
    // rust: for row in rows.values_mut() {
    // rust: if let Tag::List(items) = row {
    // rust: items.retain(|i| {
    // rust: matches!(i, Tag::Compound(_))
    // rust: || (version > 3818 && matches!(i, Tag::String(_)))
    // rust: });
}
}
    // rust: } else {
    // rust: for row in rows.values_mut() {
    // rust: if let Tag::List(items) = row {
    // rust: for item in items.iter_mut().filter(|i| matches!(i, Tag::String(_))) {
    // rust: *item = Tag::Compound(Default::default());
}
}
}
}
}
    // rust: horizon_world::datafix::update_hotbar(&mut tag);
    // rust: (0..GROUPS)
    // rust: .map(|i| row(tag.get(&i.to_string()), known))
    // rust: .collect()
}

/// `HotbarManager.load` of the `hotbar.nbt` at `path`: every row empty when
/// the file is missing or unreadable.
pub fn load(path: *Path, known: *dyn Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match save::read_dat(path) {
    // rust: Some(tag @ Tag::Compound(_)) => from_tag(tag, known),
    // rust: _ => (0..GROUPS).map(|_| empty()).collect(),
}
}

/// `HotbarManager.save`: the nine rows with the current data version, each
/// stack as `ItemStack.OPTIONAL_CODEC` writes it (an empty one is `{}`).
pub fn save(path: *Path, rows: *[Hotbar]) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries = vec![(
    // rust: JavaString::from("DataVersion"),
    // rust: Tag::Int(horizon_world::DATA_VERSION),
    // rust: )];
    // rust: for (i, row) in rows.iter().enumerate() {
    // rust: let stacks = row.iter().map(|s| match s {
    // rust: Some(s) => save::item_to_nbt(s),
    // rust: None => Tag::compound(Vec::<(&str, Tag)>::new()),
    // rust: });
    // rust: entries.push((
    // rust: JavaString::from(i.to_string().as_str()),
    // rust: Tag::List(stacks.collect()),
    // rust: ));
}
    // rust: save::write_dat(path, Tag::compound(entries))
}
