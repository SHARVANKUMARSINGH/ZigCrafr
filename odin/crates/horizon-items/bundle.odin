//! Transpiled from Horizon Rust crate
package horizon_items_bundle

import "core:fmt"
import "core:mem"
import "core:math"

// `BundleContents.Mutable`: what a bundle takes in and gives back, by
// weight. The menus (`menu`, `lan::menu`) run `BundleItem`'s click
// overrides on it.
// use crate::item_data::BundleSelected;
// use crate::items::{ItemStack, Items};
// use horizon_world::nbt::Tag;

// A bundle weight: vanilla's `Fraction`, exact and kept reduced.
Weight :: struct {
    n: i128,
    d: i128,
}

gcd :: proc(a: i128, b: i128) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let (mut a, mut b) = (a.abs(), b.abs());
    // rust: while b != 0 {
    // rust: (a, b) = (b, a % b);
}
    // rust: a.max(1)
}

    // rust: impl Weight {
ZERO :: Self { n: 0, d: 1 }
ONE :: Self { n: 1, d: 1 }

new :: proc(n: i128, d: i128) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let g = gcd(n, d);
    // rust: Self { n: n / g, d: d / g }
}

add :: proc(self: ^Self, o: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(self.n * o.d + o.n * self.d, self.d * o.d)
}

sub :: proc(self: ^Self, o: Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.add(Self { n: -o.n, d: o.d })
}

times :: proc(self: ^Self, count: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(self.n * i128::from(count), self.d)
}

    // `this.divideBy(item).intValue()` (truncated), at least 0.
how_many :: proc(self: ^Self, item: Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let q = (self.n * item.d) / (self.d * item.n);
    // rust: u32::try_from(q.max(0)).unwrap_or(u32::MAX)
}
}

// The sounds of `BundleItem` (`Entity.playSound` at the player): insert
// and remove one at volume 0.8 and pitch `0.8 + random * 0.4`, a failed
// insert at 1, 1; the drop of its contents is played at the player's block
// like remove one.
INSERT :: "minecraft:item.bundle.insert"
INSERT_FAIL :: "minecraft:item.bundle.insert_fail"
REMOVE_ONE :: "minecraft:item.bundle.remove_one"
DROP_CONTENTS :: "minecraft:item.bundle.drop_contents"

max_stack :: proc(items: ^Items, stack: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: items.get(&stack.item).map_or(64, |i| i.max_stack).max(1)
}

// The stack's `bundle_contents`, when it has the component.
    // rust: fn contents_of<'a>(items: &Items, stack: &'a ItemStack) -> Option<&'a [ItemStack]> {
    // rust: let inside = stack.data().map_or(&[][..], |d| &d.bundle_contents[..]);
    // rust: let bundle = items.get(&stack.item).is_some_and(|i| i.bundle);
    // rust: (bundle || !inside.is_empty()).then_some(inside)
}

// `BundleContents.getWeight`: a nested bundle weighs its contents plus
// 1/16, a beehive with bees 1, the rest 1 / max stack size.
item_weight :: proc(items: ^Items, stack: ^ItemStack) -> W {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(inside) = contents_of(items, stack) {
    // rust: return contents_weight(items, inside).add(Weight::new(1, 16));
}
    // rust: let bees = stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:bees"))
    // rust: .is_some_and(|b| matches!(b, Tag::List(l) if !l.is_empty()));
    // rust: if bees {
    // rust: Weight::ONE
    // rust: } else {
    // rust: Weight::new(1, i128::from(max_stack(items, stack)))
}
}

contents_weight :: proc(items: ^Items, inside: ^[ItemStack]) -> W {
    // Ported from Horizon
    return {}
}
    // rust: inside.iter().fold(Weight::ZERO, |w, s| {
    // rust: w.add(item_weight(items, s).times(s.count))
    // rust: })
}

// `BundleContents.canItemBeInBundle`: shulker boxes don't fit.
can_be_in_bundle :: proc(stack: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: stack.count > 0 && !stack.item.ends_with("shulker_box")
}

// `BundleItem.onDestroyed` (`ItemStack.onDestroyed` for a bundle): the stack
// is emptied and every stack it held comes back as its own item copy, which
// `ItemUtils.onContainerDestroyed` drops where the entity lay.
destroyed :: proc(stack: ^ItemStack) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(data) = stack.extra.as_deref_mut() else {
    // rust: return Vec::new();
}
    // rust: if data.bundle_contents.is_empty() {
    // rust: return Vec::new();
}
    // `set(BUNDLE_CONTENTS, BundleContents.EMPTY)`: no contents and no
    // selected index left.
    // rust: let spilled = std::mem::take(&mut data.bundle_contents);
    // rust: data.bundle_selected = BundleSelected(-1);
    // rust: stack.tidy();
    // rust: spilled
}

// `BundleContents.Mutable`.
Contents :: struct {
    items: [dynamic]ItemStack,
    weight: Weight,
    // `selectedItem`: an index into `items`, -1 for none.
    selected: i32,
}

    // rust: impl Contents {
    // A component collection may belong to any item, including an item with
    // no previous bundle_contents component. Reuse the same weight model.
from_items :: proc(items: ^Items, inside: [dynamic]ItemStack) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let weight = contents_weight(items, &inside);
    // rust: Self {
    // rust: items: inside,
    // rust: weight,
    // rust: selected: -1,
}
}
    // The bundle's contents; None when the stack is no bundle.
of :: proc(items: ^Items, stack: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let inside = contents_of(items, stack)?.to_vec();
    // rust: let weight = contents_weight(items, &inside);
    // rust: let selected = stack.data().map_or(-1, |d| d.bundle_selected.0);
    // rust: Some(Self {
    // rust: items: inside,
    // rust: weight,
    // rust: selected,
    // rust: })
}

    // `getMaxAmountToAdd` for `stack`'s kind of item.
room_for :: proc(self: ^Self, items: ^Items, stack: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: Weight::ONE
    // rust: .sub(self.weight)
    // rust: .how_many(item_weight(items, stack))
}

    // `tryInsert`: what fits moves to the front, merged with its kind.
try_insert :: proc(self: ^Self, items: ^Items, stack: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if !can_be_in_bundle(stack) {
    // rust: return 0;
}
    // rust: let weight = item_weight(items, stack);
    // rust: let amount = stack
    // rust: .count
    // rust: .min(Weight::ONE.sub(self.weight).how_many(weight));
    // rust: if amount == 0 {
    // rust: return 0;
}
    // rust: self.weight = self.weight.add(weight.times(amount));
        // ItemStack.isStackable: a damaged stack is damageable.
    // rust: let stackable = max_stack(items, stack) > 1 && stack.damage == 0;
    // rust: let same = self
    // rust: .items
    // rust: .iter()
    // rust: .position(|s| stackable && s.same_item_same_components(stack));
    // rust: let added = match same {
    // rust: Some(i) => {
    // rust: let mut merged = self.items.remove(i);
    // rust: merged.count += amount;
    // rust: stack.count -= amount;
    // rust: merged
}
    // rust: None => {
    // rust: let mut part = stack.clone();
    // rust: part.count = amount;
    // rust: stack.count -= amount;
    // rust: part
}
}
    // rust: self.items.insert(0, added);
    // rust: amount
}

    // `removeOne`: the selected stack, else the first; nothing is selected after.
remove_one :: proc(self: ^Self, items: ^Items) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.items.is_empty() {
    // rust: return None;
}
    // rust: let at =
    // rust: usize::try_from(self.selected).map_or(0, |i| if i < self.items.len() { i } else { 0 });
    // rust: let stack = self.items.remove(at);
    // rust: self.weight = self
    // rust: .weight
    // rust: .sub(item_weight(items, &stack).times(stack.count));
    // rust: self.selected = -1;
    // rust: Some(stack)
}

    // `getSelectedItemIndex`.
selected :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.selected
}

    // The stacks inside, in display order (the first is the next out).
items :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.items
}

    // `getNumberOfItemsToShow`: a full grid shows 11 and a `+N`, so the last
    // row keeps its fourth cell for the count.
shown_count :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let count = self.items.len();
    // rust: let available: usize = if count > 12 { 11 } else { 12 };
    // rust: let on_last_row = count % 4;
    // rust: let empty = if on_last_row == 0 { 0 } else { 4 - on_last_row };
    // rust: count.min(available.saturating_sub(empty))
}

    // The items the tooltip shows, and how many sit beyond them.
shown :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let n = self.shown_count();
    // rust: let hidden = self.items[n..].iter().map(|s| s.count).sum();
    // rust: (&self.items[..n], hidden)
}

    // The `Fraction` weight as the float the progress bar reads.
weight_fraction :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.weight.n as f32 / self.weight.d as f32
}

    // `Fraction.ONE`: a full bundle draws the full bar and says so.
is_full :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.weight.n >= self.weight.d
}

    // `BundleItem.isBarVisible`, `getBarWidth` and `getBarColor`: the fullness bar
    // (width, RGB), blue until the bundle is full, then red.
bar :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.weight.n <= 0 {
    // rust: return None;
}
    // rust: let width = (1 + self.weight.n * 12 / self.weight.d).min(13) as i32;
    // rust: let color = if self.is_full() { 0xFF5454 } else { 0x7087FF };
    // rust: Some((width, color))
}

    // `toImmutable`, written back into the bundle's component.
store :: proc(self: ^Self, bundle: ^ItemStack) {
}
    // rust: let data = bundle.data_mut();
    // rust: data.bundle_contents = self.items;
    // rust: data.bundle_selected = BundleSelected(self.selected);
    // rust: bundle.tidy();
}
}

// `BundleItem.toggleSelectedItem`: select `index`, or nothing when it is the
// selected one already or outside the contents.
toggle_selected :: proc(bundle: ^ItemStack, index: i32) {
}
    // rust: let Some(data) = bundle.extra.as_deref_mut() else {
    // rust: return;
}
    // rust: let inside = (0..data.bundle_contents.len() as i32).contains(&index);
    // rust: let selected = if data.bundle_selected.0 != index && inside {
    // rust: index
    // rust: } else {
    // rust: -1
}
    // rust: data.bundle_selected = BundleSelected(selected);
}

    // rust: mod tests {
//     use super::Weight;

weights_add_up_exactly :: proc() {
}
    // rust: let w = Weight::new(1, 64)
    // rust: .times(32)
    // rust: .add(Weight::new(1, 16).times(4));
    // rust: assert_eq!(w, Weight::new(3, 4));
    // rust: assert_eq!(Weight::ONE.sub(w).how_many(Weight::new(1, 64)), 16);
    // rust: assert_eq!(Weight::ONE.sub(Weight::ONE).how_many(Weight::ONE), 0);
        // An over-full bundle (made by a command) has no room.
    // rust: let over = Weight::ONE.sub(Weight::new(5, 4));
    // rust: assert_eq!(over.how_many(Weight::new(1, 64)), 0);
}
}

// ------------------------------------------------------------- the tooltip

// `ClientBundleTooltip`'s geometry, relative to the tooltip box's top-left:
// the 96 pixel column of a 4 wide slot grid and the progress bar under it.
TooltipLayout :: struct {
    // The component's own width (96) and height, the text's excluded.
    width: f32,
    height: f32,
    // Each slot's top-left and the stack in it, in drawing order.
    slots: Vec<([f32,
    // The position in `slots` of the selected item, which is drawn highlighted.
    selected: Maybe(uint),
    // The `+N` of the items past the grid: its top-left and the count.
    overflow: Option<([f32,
    // The progress bar's top-left, its fill's width out of 94, and whether
    // the weight fills it (the full sprite).
    bar: [f32,
    fill: f32,
    full: bool,
    // `item.minecraft.bundle.empty` / `.full`, centred over the bar.
    label: Maybe(^'static str),
    // An empty bundle's description, wrapped at `width` from here.
    empty_description: Option<[f32,
}

// The tooltip of a bundle's contents (`ClientBundleTooltip`), or None when
// the stack is not a bundle. `x`/`y` are the box's top-left, `box_width` the
// tooltip's width, which the component is centred in.
    // rust: pub fn tooltip_layout(
    // rust: items: &Items,
    // rust: stack: &ItemStack,
    // rust: x: f32,
    // rust: y: f32,
    // rust: box_width: f32,
    // rust: ) -> Option<TooltipLayout> {
    // rust: let contents = Contents::of(items, stack)?;
    // rust: let offset = ((box_width - 96.0) / 2.0).floor();
    // rust: if contents.items().is_empty() {
        // The description takes the top; the bar follows it.
    // rust: let description_height = 9.0 * 2.0;
    // rust: return Some(TooltipLayout {
    // rust: width: 96.0,
    // rust: height: description_height + 13.0 + 8.0,
    // rust: slots: Vec::new(),
    // rust: selected: None,
    // rust: overflow: None,
    // rust: bar: [x + offset, y + description_height + 4.0],
    // rust: fill: 0.0,
    // rust: full: false,
    // rust: label: Some("item.minecraft.bundle.empty"),
    // rust: empty_description: Some([x + offset, y]),
    // rust: });
}
    // rust: let (shown, hidden) = contents.shown();
    // `gridSizeY` counts `slotCount()` (at most twelve), not the slots the
    // overflow count leaves room for.
    // rust: let rows = contents.items().len().min(12).div_ceil(4).max(1);
    // rust: let grid_height = rows as f32 * 24.0;
    // rust: let x_start = x + offset + 96.0;
    // rust: let y_start = y + grid_height;
    // rust: let mut slots = Vec::with_capacity(shown.len());
    // rust: let mut selected = None;
    // rust: let mut overflow = None;
    // Rows fill bottom-up and columns right-to-left, as vanilla draws them.
    // rust: let mut slot = 0;
    // rust: for row in 1..=rows {
    // rust: for column in 1..=4 {
    // rust: let at = [x_start - column as f32 * 24.0, y_start - row as f32 * 24.0];
    // rust: if hidden > 0 && row == 1 && column == 1 {
    // rust: overflow = Some((at, hidden));
    // rust: } else if slot < shown.len() {
                // `extractSlot`: the cell of slot number n holds item `size - n`.
    // rust: let index = shown.len() - 1 - slot;
    // rust: if usize::try_from(contents.selected()) == Ok(index) {
    // rust: selected = Some(slots.len());
}
    // rust: slots.push((at, shown[index].clone()));
    // rust: slot += 1;
}
}
}
    // rust: let weight = contents.weight_fraction();
    // rust: Some(TooltipLayout {
    // rust: width: 96.0,
    // rust: height: grid_height + 13.0 + 8.0,
    // rust: slots,
    // rust: selected,
    // rust: overflow,
    // rust: bar: [x + offset, y + grid_height + 4.0],
        // `Mth.mulAndTruncate(weight, 94)`, kept within the bar.
    // rust: fill: (weight * 94.0).trunc().clamp(0.0, 94.0),
    // rust: full: contents.is_full(),
    // rust: label: if contents.is_full() {
    // rust: Some("item.minecraft.bundle.full")
    // rust: } else {
    // rust: None
    // rust: },
    // rust: empty_description: None,
    // rust: })
}

    // rust: mod tooltip_tests {
//     use super::*;

    // The prepared resources, when they are on this machine: the tooltip
    // asks the item registry whether a stack is a bundle.
items :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: crate::items::prepared_items()
}

bundle_with :: proc(counts: ^[(string) {
}
    // rust: let mut bundle = ItemStack::new("minecraft:bundle", 1);
    // rust: bundle.data_mut().bundle_contents = counts
    // rust: .iter()
    // rust: .map(|(item, n)| ItemStack::new(item, *n))
    // rust: .collect();
    // rust: bundle
}

a_grid_shows_twelve_stacks_and_counts_the_rest :: proc() {
}
    // rust: let Some(items) = items() else { return };
    // rust: let twelve: Vec<(&str, u32)> = (0..12).map(|_| ("minecraft:stone", 1)).collect();
    // rust: let layout = tooltip_layout(&items, &bundle_with(&twelve), 0.0, 0.0, 96.0).unwrap();
    // rust: assert_eq!(layout.slots.len(), 12);
    // rust: assert_eq!(layout.overflow, None);
    // rust: assert_eq!(layout.height, 3.0 * 24.0 + 13.0 + 8.0);
        // Rows fill bottom-up and columns right-to-left: the twelfth item is in
        // the bottom-right cell, the first in the top-left.
    // rust: assert_eq!(layout.slots[0].0, [96.0 - 24.0, 3.0 * 24.0 - 24.0]);
    // rust: assert_eq!(&*layout.slots[0].1.item, "minecraft:stone");
    // rust: assert_eq!(layout.slots[11].0, [0.0, 0.0]);
        // A wider tooltip centres the 96 pixel column in it.
    // rust: let centred = tooltip_layout(&items, &bundle_with(&twelve), 0.0, 0.0, 120.0).unwrap();
    // rust: assert_eq!(centred.slots[0].0[0], 12.0 + 96.0 - 24.0);
        // Thirteen stacks: `getNumberOfItemsToShow` leaves the last row room
        // for the count, so 8 slots show and `+6` (four stones and two dirt)
        // takes the first cell.
    // rust: let mut counts = twelve;
    // rust: counts.push(("minecraft:dirt", 2));
    // rust: let layout = tooltip_layout(&items, &bundle_with(&counts), 0.0, 0.0, 96.0).unwrap();
    // rust: assert_eq!(layout.slots.len(), 8);
    // rust: assert_eq!(layout.overflow, Some(([96.0 - 24.0, 48.0], 6)));
}

the_bar_fills_with_the_weight_and_an_empty_bundle_explains_itself :: proc() {
}
    // rust: let Some(items) = items() else { return };
    // rust: let layout = tooltip_layout(&items, &bundle_with(&[]), 4.0, 8.0, 96.0).unwrap();
    // rust: assert!(layout.slots.is_empty());
    // rust: assert_eq!(layout.fill, 0.0);
    // rust: assert_eq!(layout.label, Some("item.minecraft.bundle.empty"));
    // rust: assert_eq!(layout.empty_description, Some([4.0, 8.0]));
    // rust: assert_eq!(layout.bar, [4.0, 8.0 + 18.0 + 4.0]);
        // A bundle holding one 64 stack is full: the whole bar, the full label.
    // rust: let layout = tooltip_layout(
    // rust: &items,
    // rust: &bundle_with(&[("minecraft:stone", 64)]),
    // rust: 0.0,
    // rust: 0.0,
    // rust: 96.0,
    // rust: )
    // rust: .unwrap();
    // rust: assert!(layout.full);
    // rust: assert_eq!(layout.fill, 94.0);
    // rust: assert_eq!(layout.label, Some("item.minecraft.bundle.full"));
        // Something that is not a bundle has no component.
    // rust: let dirt = ItemStack::new("minecraft:dirt", 1);
    // rust: assert!(tooltip_layout(&items, &dirt, 0.0, 0.0, 96.0).is_none());
}
}
