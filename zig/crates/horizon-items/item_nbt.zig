//! Transpiled from Horizon Rust crate
//! Module: horizon-items_item_nbt
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Item stacks in NBT (`ItemStack.CODEC`): id, count and components, alone or in
//! slot lists.
// use horizon_client_core::nbt_value::{number, string, text};
// use horizon_world::nbt::Tag;
// use std::sync::Arc;

pub fn encode_item(stack: *crate::items::ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries = vec![
    // rust: ("id", string(&stack.item)),
    // rust: ("count", Tag::Int(stack.count as i32)),
    // rust: ];
    // rust: if let Some(components) = crate::item_data::encode_components(stack) {
    // rust: entries.push(("components", components));
}
    // rust: entries
}
/// ItemStack.CODEC (id, count, components).
pub fn item_to_nbt(stack: *crate::items::ItemStack) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound(encode_item(stack))
}
/// ItemStack.CODEC's count range is independent of the item's stack limit;
/// an out-of-range count uses the field's default of one. The id is read as an
/// `Identifier`: `stone` is `minecraft:stone` (a summoned display's or a
/// command's NBT often leaves the namespace out), and an id that is no valid
/// identifier makes no stack.
pub fn item_from_nbt(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = horizon_world::datafix::identifier(&text(tag.get("id"))?)?;
    // rust: let id = format!("{namespace}:{path}");
    // rust: if id == "minecraft:air" {
    // rust: return None;
}
    // rust: let count = number(tag.get("count"))
    // rust: .or_else(|| number(tag.get("Count")))
    // rust: .filter(|count| (1..=99).contains(count))
    // rust: .unwrap_or(1) as u32;
    // rust: let (damage, extra) = crate::item_data::decode_components(tag.get("components"));
    // rust: Some(crate::items::ItemStack {
    // rust: item: Arc::from(id.as_str()),
    // rust: count,
    // rust: damage,
    // rust: extra,
    // rust: })
}
pub fn encode_items(slots: *[?crate::items::ItemStack]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::List(
    // rust: slots
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, s)| {
    // rust: let mut entries = vec![("Slot", Tag::Byte(i as i8))];
    // rust: entries.extend(encode_item(s.as_ref()?));
    // rust: Some(Tag::compound(entries))
    // rust: })
    // rust: .collect(),
    // rust: )
}
pub fn decode_items(tag: ?*Tag, size: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut slots = vec![None; size];
    // rust: if let Some(Tag::List(items)) = tag {
    // rust: for it in items {
    // rust: let slot = number(it.get("Slot")).unwrap_or(0) as u8 as usize;
    // rust: if let Some(cell) = slots.get_mut(slot) {
    // rust: *cell = item_from_nbt(it);
}
}
}
    // rust: slots
}

    // rust: mod tests {
//     use super::*;

pub fn nbt_count_defaults_to_one_outside_codec_range() void {
}
    // rust: for item in ["minecraft:stone", "minecraft:diamond_sword"] {
    // rust: for (raw, expected) in [
    // rust: (None, 1),
    // rust: (Some(Tag::Int(-1)), 1),
    // rust: (Some(Tag::Int(0)), 1),
    // rust: (Some(Tag::Int(1)), 1),
    // rust: (Some(Tag::Int(2)), 2),
    // rust: (Some(Tag::Int(64)), 64),
    // rust: (Some(Tag::Int(99)), 99),
    // rust: (Some(Tag::Int(100)), 1),
    // rust: (Some(Tag::Int(255)), 1),
    // rust: (Some(Tag::Int(256)), 1),
    // rust: (Some(Tag::Int(i32::MAX)), 1),
    // rust: (Some(Tag::Byte(1)), 1),
    // rust: (Some(Tag::Float(1.5_f32.to_bits())), 1),
    // rust: (Some(string("1")), 1),
    // rust: ] {
    // rust: let mut tag = Tag::compound([("id", string(item))]);
    // rust: if let (Tag::Compound(map), Some(raw)) = (&mut tag, &raw) {
    // rust: map.insert("count".into(), raw.clone());
}
    // rust: let stack = item_from_nbt(&tag).unwrap();
    // rust: assert_eq!(stack.count, expected, "{item}: {raw:?}");
    // rust: assert_eq!(
    // rust: number(item_to_nbt(&stack).get("count")),
    // rust: Some(i64::from(expected))
    // rust: );
}
}
}

    /// `/summon item_display ~ ~ ~ {item:{id:"stone"}}` shows stone in vanilla:
    /// the id reads as an Identifier, with the default namespace (#8570).
pub fn an_id_without_a_namespace_is_a_minecraft_item() void {
}
    // rust: let read = |id: &str| item_from_nbt(&Tag::compound([("id", string(id))]));
    // rust: assert_eq!(
    // rust: read("stone").map(|s| s.item),
    // rust: Some("minecraft:stone".into())
    // rust: );
    // rust: assert_eq!(
    // rust: read(":diamond").map(|s| s.item),
    // rust: Some("minecraft:diamond".into())
    // rust: );
    // rust: assert_eq!(read("nexo:ruby").map(|s| s.item), Some("nexo:ruby".into()));
    // rust: assert!(read("air").is_none());
    // rust: assert!(read("Stone").is_none(), "not a valid identifier");
}

pub fn runtime_counts_remain_independent_of_the_nbt_decode_range() void {
}
    // rust: let stack = crate::items::ItemStack::new("minecraft:diamond_sword", 1000);
    // rust: assert_eq!(stack.count, 1000);
    // rust: assert_eq!(number(item_to_nbt(&stack).get("count")), Some(1000));
}
}
