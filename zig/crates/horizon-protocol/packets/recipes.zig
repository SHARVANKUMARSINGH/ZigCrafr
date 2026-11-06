//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_recipes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The recipe book's packets and the recipe displays they carry
//! (`RecipeDisplay`, `SlotDisplay`, `RecipeDisplayEntry`): the 26.3
//! `minecraft:recipe_display` and `minecraft:slot_display` types in id order.
// use crate::{
    // rust: Result,
    // rust: buf::{Codec, Reader, Writer},
    // rust: item::{Stack, Template},
}
// use horizon_world::nbt::Tag;

/// `HolderSet<Item>` on the network: a tag by name, or item ids.
pub const HolderSet = enum {
    Tag(String),
    Items(Vec<i32>),
};
    // rust: impl HolderSet {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = r.varint()? - 1;
    // rust: if n == -1 {
    // rust: return Ok(Self::Tag(r.string(32767)?));
}
    // rust: let n = usize::try_from(n).map_err(|_| crate::Error::new("negative holder set size"))?;
    // rust: if n > r.remaining() {
    // rust: return Err(crate::Error::new("holder set larger than the packet"));
}
    // rust: Ok(Self::Items(
    // rust: (0..n)
    // rust: .map(|_| r.varint().map(crate::adapter::ids::item))
    // rust: .collect::<Result<_>>()?,
    // rust: ))
}
pub fn write(self: *Self, w: *mut Writer) void {
}
    // rust: match self {
    // rust: Self::Tag(name) => {
    // rust: w.varint(0);
    // rust: w.string(name);
}
    // rust: Self::Items(ids) => {
    // rust: w.varint(ids.len() as i32 + 1);
    // rust: ids.iter().for_each(|id| w.varint(*id));
}
}
}
}

/// A trim pattern as `ByteBufCodecs.holder` sends it: a registry id, or
/// the pattern itself.
pub const TrimPattern = enum {
    Id(i32),
    Direct {,
    asset: String,
    description: Tag,
    decal: bool,
    // rust: },
};

/// `SlotDisplay`: what a recipe book slot shows.
pub const SlotDisplay = enum {
    Empty,
    AnyFuel,
    WithAnyPotion(Box<SlotDisplay>),
    /// The source, kept to the stacks with this data component type.
    OnlyWithComponent(Box<SlotDisplay>, i32),
    Item(i32),
    ItemStack(Stack),
    Tag(HolderSet),
    Dyed {,
    dye: Box<SlotDisplay>,
    target: Box<SlotDisplay>,
    // rust: },
    SmithingTrim {,
    base: Box<SlotDisplay>,
    material: Box<SlotDisplay>,
    pattern: TrimPattern,
    // rust: },
    WithRemainder {,
    input: Box<SlotDisplay>,
    remainder: Box<SlotDisplay>,
    // rust: },
    Composite(Vec<SlotDisplay>),
};

/// How deep slot displays may nest (composites of composites…).
pub const MAX_DEPTH: u32 = 32;

    // rust: impl SlotDisplay {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::read_at(r, 0)
}
pub fn read_at(r: *mut Reader, depth: u32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if depth > MAX_DEPTH {
    // rust: return Err(crate::Error::new("slot displays nest too deep"));
}
    // rust: let inner = |r: &mut Reader| Self::read_at(r, depth + 1).map(Box::new);
    // rust: Ok(match crate::adapter::ids::slot_display(r.varint()?) {
    // rust: 0 => Self::Empty,
    // rust: 1 => Self::AnyFuel,
    // rust: 2 => Self::WithAnyPotion(inner(r)?),
    // rust: 3 => {
    // rust: let source = inner(r)?;
    // rust: Self::OnlyWithComponent(source, crate::adapter::ids::component(r.varint()?))
}
    // rust: 4 => Self::Item(crate::adapter::ids::item(r.varint()?)),
    // rust: 5 => Self::ItemStack(Template::read(r)?),
    // rust: 6 if crate::adapter::ids::quirks().tag_slot_display_is_id => {
    // rust: Self::Tag(HolderSet::Tag(r.string(32767)?))
}
    // rust: 6 => Self::Tag(HolderSet::read(r)?),
    // rust: 7 => Self::Dyed {
    // rust: dye: inner(r)?,
    // rust: target: inner(r)?,
    // rust: },
    // rust: 8 => {
    // rust: let base = inner(r)?;
    // rust: let material = inner(r)?;
    // rust: let pattern = match r.varint()? {
    // rust: 0 => TrimPattern::Direct {
    // rust: asset: r.string(32767)?,
    // rust: description: r.nbt()?,
    // rust: decal: r.bool()?,
    // rust: },
    // rust: id => TrimPattern::Id(id - 1),
}
    // rust: Self::SmithingTrim {
    // rust: base,
    // rust: material,
    // rust: pattern,
}
}
    // rust: 9 => Self::WithRemainder {
    // rust: input: inner(r)?,
    // rust: remainder: inner(r)?,
    // rust: },
    // rust: 10 => {
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut out = Vec::with_capacity(n.min(256));
    // rust: for _ in 0..n {
    // rust: out.push(Self::read_at(r, depth + 1)?);
}
    // rust: Self::Composite(out)
}
    // rust: id => return Err(crate::Error::new(format!("unknown slot display {id}"))),
    // rust: })
}
pub fn write(self: *Self, w: *mut Writer) void {
}
    // rust: match self {
    // rust: Self::Empty => w.varint(0),
    // rust: Self::AnyFuel => w.varint(1),
    // rust: Self::WithAnyPotion(d) => {
    // rust: w.varint(2);
    // rust: d.write(w);
}
    // rust: Self::OnlyWithComponent(d, component) => {
    // rust: w.varint(3);
    // rust: d.write(w);
    // rust: w.varint(*component);
}
    // rust: Self::Item(id) => {
    // rust: w.varint(4);
    // rust: w.varint(*id);
}
    // rust: Self::ItemStack(stack) => {
    // rust: w.varint(5);
    // rust: Template::write(stack, w);
}
    // rust: Self::Tag(set) => {
    // rust: w.varint(6);
    // rust: set.write(w);
}
    // rust: Self::Dyed { dye, target } => {
    // rust: w.varint(7);
    // rust: dye.write(w);
    // rust: target.write(w);
}
    // rust: Self::SmithingTrim {
    // rust: base,
    // rust: material,
    // rust: pattern,
    // rust: } => {
    // rust: w.varint(8);
    // rust: base.write(w);
    // rust: material.write(w);
    // rust: match pattern {
    // rust: TrimPattern::Id(id) => w.varint(id + 1),
    // rust: TrimPattern::Direct {
    // rust: asset,
    // rust: description,
    // rust: decal,
    // rust: } => {
    // rust: w.varint(0);
    // rust: w.string(asset);
    // rust: w.nbt(description);
    // rust: w.bool(*decal);
}
}
}
    // rust: Self::WithRemainder { input, remainder } => {
    // rust: w.varint(9);
    // rust: input.write(w);
    // rust: remainder.write(w);
}
    // rust: Self::Composite(list) => {
    // rust: w.varint(10);
    // rust: w.varint(list.len() as i32);
    // rust: list.iter().for_each(|d| d.write(w));
}
}
}
}

pub fn read_list(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut out = Vec::with_capacity(n.min(256));
    // rust: for _ in 0..n {
    // rust: out.push(SlotDisplay::read(r)?);
}
    // rust: Ok(out)
}
pub fn write_list(list: *[SlotDisplay], w: *mut Writer) void {
}
    // rust: w.varint(list.len() as i32);
    // rust: list.iter().for_each(|d| d.write(w));
}

/// `RecipeDisplay`: a recipe as the recipe book draws it.
pub const RecipeDisplay = enum {
    Shapeless {,
    ingredients: Vec<SlotDisplay>,
    result: SlotDisplay,
    station: SlotDisplay,
    // rust: },
    Shaped {,
    width: i32,
    height: i32,
    ingredients: Vec<SlotDisplay>,
    result: SlotDisplay,
    station: SlotDisplay,
    // rust: },
    Furnace {,
    ingredient: SlotDisplay,
    fuel: SlotDisplay,
    result: SlotDisplay,
    station: SlotDisplay,
    duration: i32,
    experience: f32,
    // rust: },
    Stonecutter {,
    input: SlotDisplay,
    result: SlotDisplay,
    station: SlotDisplay,
    // rust: },
    Smithing {,
    template: SlotDisplay,
    base: SlotDisplay,
    addition: SlotDisplay,
    result: SlotDisplay,
    station: SlotDisplay,
    // rust: },
};
    // rust: impl RecipeDisplay {
pub fn result(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Shapeless { result, .. }
    // rust: | Self::Shaped { result, .. }
    // rust: | Self::Furnace { result, .. }
    // rust: | Self::Stonecutter { result, .. }
    // rust: | Self::Smithing { result, .. } => result,
}
}
}
    // rust: impl Codec<RecipeDisplay> for RecipeDisplay {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slot = SlotDisplay::read;
    // rust: Ok(match r.varint()? {
    // rust: 0 => Self::Shapeless {
    // rust: ingredients: read_list(r)?,
    // rust: result: slot(r)?,
    // rust: station: slot(r)?,
    // rust: },
    // rust: 1 => {
    // rust: let (width, height) = (r.varint()?, r.varint()?);
    // rust: let ingredients = read_list(r)?;
    // rust: if i64::from(width) * i64::from(height) != ingredients.len() as i64 {
    // rust: return Err(crate::Error::new("shaped display size mismatch"));
}
    // rust: Self::Shaped {
    // rust: width,
    // rust: height,
    // rust: ingredients,
    // rust: result: slot(r)?,
    // rust: station: slot(r)?,
}
}
    // rust: 2 => Self::Furnace {
    // rust: ingredient: slot(r)?,
    // rust: fuel: slot(r)?,
    // rust: result: slot(r)?,
    // rust: station: slot(r)?,
    // rust: duration: r.varint()?,
    // rust: experience: r.f32()?,
    // rust: },
    // rust: 3 => Self::Stonecutter {
    // rust: input: slot(r)?,
    // rust: result: slot(r)?,
    // rust: station: slot(r)?,
    // rust: },
    // rust: 4 => Self::Smithing {
    // rust: template: slot(r)?,
    // rust: base: slot(r)?,
    // rust: addition: slot(r)?,
    // rust: result: slot(r)?,
    // rust: station: slot(r)?,
    // rust: },
    // rust: id => return Err(crate::Error::new(format!("unknown recipe display {id}"))),
    // rust: })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: match v {
    // rust: Self::Shapeless {
    // rust: ingredients,
    // rust: result,
    // rust: station,
    // rust: } => {
    // rust: w.varint(0);
    // rust: write_list(ingredients, w);
    // rust: result.write(w);
    // rust: station.write(w);
}
    // rust: Self::Shaped {
    // rust: width,
    // rust: height,
    // rust: ingredients,
    // rust: result,
    // rust: station,
    // rust: } => {
    // rust: w.varint(1);
    // rust: w.varint(*width);
    // rust: w.varint(*height);
    // rust: write_list(ingredients, w);
    // rust: result.write(w);
    // rust: station.write(w);
}
    // rust: Self::Furnace {
    // rust: ingredient,
    // rust: fuel,
    // rust: result,
    // rust: station,
    // rust: duration,
    // rust: experience,
    // rust: } => {
    // rust: w.varint(2);
    // rust: ingredient.write(w);
    // rust: fuel.write(w);
    // rust: result.write(w);
    // rust: station.write(w);
    // rust: w.varint(*duration);
    // rust: w.f32(*experience);
}
    // rust: Self::Stonecutter {
    // rust: input,
    // rust: result,
    // rust: station,
    // rust: } => {
    // rust: w.varint(3);
    // rust: input.write(w);
    // rust: result.write(w);
    // rust: station.write(w);
}
    // rust: Self::Smithing {
    // rust: template,
    // rust: base,
    // rust: addition,
    // rust: result,
    // rust: station,
    // rust: } => {
    // rust: w.varint(4);
    // rust: template.write(w);
    // rust: base.write(w);
    // rust: addition.write(w);
    // rust: result.write(w);
    // rust: station.write(w);
}
}
}
}

/// `RecipeDisplayEntry` with `ClientboundRecipeBookAddPacket.Entry`'s flags
/// (1 show a notification, 2 highlight as new).
pub const RecipeBookEntry = struct {
    id: i32,
    display: RecipeDisplay,
    /// The recipe group (0 none, else the group's index + 1).
    group: i32,
    /// `minecraft:recipe_book_category` id.
    category: i32,
    /// The ingredients the "craftable" filter checks, if the recipe has any.
    requirements: ?std.ArrayList(HolderSet),
    flags: i8,
};

/// ClientboundRecipeBookAddPacket: the entries, and whether they replace the
/// client's book.
pub const RecipeBookAdd = struct {
    entries: std.ArrayList(RecipeBookEntry),
    replace: bool,
};
    // rust: impl RecipeBookEntry {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = r.varint()?;
    // rust: let display = RecipeDisplay::read(r)?;
    // rust: let group = r.varint()?;
    // rust: let category = r.varint()?;
    // rust: let requirements = if r.bool()? {
    // rust: let k = r.count(r.remaining())?;
    // rust: let mut list = Vec::with_capacity(k.min(64));
    // rust: for _ in 0..k {
    // rust: list.push(HolderSet::read(r)?);
}
    // rust: Some(list)
    // rust: } else {
    // rust: None
}
    // rust: Ok(Self {
    // rust: id,
    // rust: display,
    // rust: group,
    // rust: category,
    // rust: requirements,
    // rust: flags: r.i8()?,
    // rust: })
}
}
    // rust: impl Codec<RecipeBookAdd> for RecipeBookAdd {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = r.count(r.remaining())?;
    // rust: let mut entries = Vec::with_capacity(n.min(4096));
    // rust: for _ in 0..n {
    // rust: entries.push(RecipeBookEntry::read(r)?);
}
    // rust: Ok(Self {
    // rust: entries,
    // rust: replace: r.bool()?,
    // rust: })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: w.varint(v.entries.len() as i32);
    // rust: for e in &v.entries {
    // rust: w.varint(e.id);
    // rust: RecipeDisplay::write(&e.display, w);
    // rust: w.varint(e.group);
    // rust: w.varint(e.category);
    // rust: w.bool(e.requirements.is_some());
    // rust: if let Some(list) = &e.requirements {
    // rust: w.varint(list.len() as i32);
    // rust: list.iter().for_each(|s| s.write(w));
}
    // rust: w.i8(e.flags);
}
    // rust: w.bool(v.replace);
}
}

/// ClientboundRecipeBookRemovePacket: the display ids.
pub const RecipeBookRemove = struct {
    ids: std.ArrayList(i32),
};
    // rust: impl Codec<RecipeBookRemove> for RecipeBookRemove {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = r.count(r.remaining())?;
    // rust: Ok(Self {
    // rust: ids: (0..n).map(|_| r.varint()).collect::<Result<_>>()?,
    // rust: })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: w.varint(v.ids.len() as i32);
    // rust: v.ids.iter().for_each(|id| w.varint(*id));
}
}

/// RecipeBookSettings: each book's (open, filtering), in `RecipeBookType`
/// order (crafting, furnace, blast furnace, smoker).
pub const RecipeBookSettings = struct {
    books: [(bool,
};
    // rust: impl Codec<RecipeBookSettings> for RecipeBookSettings {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut books = [(false, false); 4];
    // rust: for b in &mut books {
    // rust: *b = (r.bool()?, r.bool()?);
}
    // rust: Ok(Self { books })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: for (open, filtering) in v.books {
    // rust: w.bool(open);
    // rust: w.bool(filtering);
}
}
}

/// ServerboundRecipeBookSeenRecipePacket: the `RecipeDisplayId` the player
/// has looked at, so the server stops treating it as a new one.
pub const RecipeBookSeenRecipe = struct {
    recipe: i32,
};
    // rust: impl Codec<RecipeBookSeenRecipe> for RecipeBookSeenRecipe {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Self {
    // rust: recipe: r.varint()?,
    // rust: })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: w.varint(v.recipe);
}
}

/// ServerboundRecipeBookChangeSettingsPacket: the active book's open and
/// filtering flags, with its `RecipeBookType` ordinal as a VarInt.
pub const RecipeBookChangeSettings = struct {
    book_type: i32,
    open: bool,
    filtering: bool,
};
    // rust: impl Codec<RecipeBookChangeSettings> for RecipeBookChangeSettings {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let book_type = r.varint()?;
    // rust: if !(0..4).contains(&book_type) {
    // rust: return Err(crate::Error::new("invalid recipe book type"));
}
    // rust: Ok(Self {
    // rust: book_type,
    // rust: open: r.bool()?,
    // rust: filtering: r.bool()?,
    // rust: })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: w.varint(v.book_type);
    // rust: w.bool(v.open);
    // rust: w.bool(v.filtering);
}
}

/// ClientboundPlaceGhostRecipePacket: the recipe to show faded in a menu
/// whose items were missing.
pub const PlaceGhostRecipe = struct {
    container: i32,
    display: RecipeDisplay,
};
    // rust: impl Codec<PlaceGhostRecipe> for PlaceGhostRecipe {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Self {
    // rust: container: r.varint()?,
    // rust: display: RecipeDisplay::read(r)?,
    // rust: })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: w.varint(v.container);
    // rust: RecipeDisplay::write(&v.display, w);
}
}

/// ServerboundPlaceRecipePacket: place the recipe with this display id in
/// the open menu, as many times as possible when `use_max` (shift).
pub const PlaceRecipe = struct {
    container: i32,
    recipe: i32,
    use_max: bool,
};
    // rust: impl Codec<PlaceRecipe> for PlaceRecipe {
pub fn read(r: *mut Reader) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Self {
    // rust: container: r.varint()?,
    // rust: recipe: r.varint()?,
    // rust: use_max: r.bool()?,
    // rust: })
}
pub fn write(v: *Self, w: *mut Writer) void {
}
    // rust: w.varint(v.container);
    // rust: w.varint(v.recipe);
    // rust: w.bool(v.use_max);
}
}

    // rust: mod tests {
//     use super::*;

pub fn book_entries_round_trip() void {
}
    // rust: let add = RecipeBookAdd {
    // rust: entries: vec![
    // rust: RecipeBookEntry {
    // rust: id: 7,
    // rust: display: RecipeDisplay::Shaped {
    // rust: width: 2,
    // rust: height: 1,
    // rust: ingredients: vec![
    // rust: SlotDisplay::Tag(HolderSet::Tag("minecraft:planks".into())),
    // rust: SlotDisplay::Empty,
    // rust: ],
    // rust: result: SlotDisplay::ItemStack(Stack::new(12, 4)),
    // rust: station: SlotDisplay::Item(300),
    // rust: },
    // rust: group: 3,
    // rust: category: 3,
    // rust: requirements: Some(vec![HolderSet::Items(vec![1, 2])]),
    // rust: flags: 3,
    // rust: },
    // rust: RecipeBookEntry {
    // rust: id: 8,
    // rust: display: RecipeDisplay::Smithing {
    // rust: template: SlotDisplay::Composite(vec![SlotDisplay::Item(1)]),
    // rust: base: SlotDisplay::WithRemainder {
    // rust: input: Box::new(SlotDisplay::AnyFuel),
    // rust: remainder: Box::new(SlotDisplay::Item(2)),
    // rust: },
    // rust: addition: SlotDisplay::OnlyWithComponent(
    // rust: Box::new(SlotDisplay::WithAnyPotion(Box::new(SlotDisplay::Item(3)))),
    // rust: 9,
    // rust: ),
    // rust: result: SlotDisplay::SmithingTrim {
    // rust: base: Box::new(SlotDisplay::Item(4)),
    // rust: material: Box::new(SlotDisplay::Dyed {
    // rust: dye: Box::new(SlotDisplay::Item(5)),
    // rust: target: Box::new(SlotDisplay::Item(6)),
    // rust: }),
    // rust: pattern: TrimPattern::Id(2),
    // rust: },
    // rust: station: SlotDisplay::Item(7),
    // rust: },
    // rust: group: 0,
    // rust: category: 11,
    // rust: requirements: None,
    // rust: flags: 0,
    // rust: },
    // rust: ],
    // rust: replace: true,
}
    // rust: let mut w = Writer::new();
    // rust: RecipeBookAdd::write(&add, &mut w);
    // rust: let mut r = Reader::new(&w.data);
    // rust: assert_eq!(RecipeBookAdd::read(&mut r).unwrap(), add);
    // rust: assert_eq!(r.remaining(), 0);
}
}
