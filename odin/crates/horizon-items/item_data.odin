//! Transpiled from Horizon Rust crate
package horizon_items_item_data

import "core:fmt"
import "core:mem"
import "core:math"

// Item stack components beyond count and damage: enchantments, stored
// (book) enchantments, `repair_cost`, `custom_name`, `potion_contents` and
// `trim`, with their NBT form in vanilla's `components` compound.
// use crate::items::ItemStack;
// use horizon_world::nbt::{JavaString, Tag};
// use std::sync::Arc;

// Enchantment id and level, in insertion order.
    // rust: pub type Levels = Vec<(Arc<str>, u32)>;

StackData :: struct {
    // `minecraft:enchantments`.
    enchantments: Levels,
    // `minecraft:stored_enchantments` (enchanted books).
    stored_enchantments: Levels,
    // `minecraft:repair_cost` (anvil prior-work penalty).
    repair_cost: u32,
    // The original `minecraft:custom_name` component; plain text is derived
    // when gameplay needs it, so styled names have one source of truth.
    custom_name: Maybe(Tag),
    // `minecraft:potion_contents.potion`.
    potion: Maybe(^str),
    // The rest of `minecraft:potion_contents` (`custom_color`, `custom_effects`,
    // `custom_name`), kept as saved.
    potion_extra: Vec<(string,
    // `minecraft:trim`: (material, pattern).
    trim: Maybe((Arc<str),
    // `minecraft:container` (shulker boxes): the non-empty slots.
    container: Vec<(u8,
    // `minecraft:charged_projectiles` (a loaded crossbow).
    charged: [dynamic]ItemStack,
    // `minecraft:fireworks`: flight duration and explosions (None: the
    // item's default).
    fireworks: Option<(u8,
    // `minecraft:map_id` (filled maps).
    map_id: Maybe(i32),
    // `minecraft:writable_book_content` pages.
    writable_pages: [dynamic]string,
    // `minecraft:written_book_content`.
    written: Maybe(WrittenBook),
    // `minecraft:banner_patterns` (banners and shields).
    banner_patterns: [dynamic]crate::banner_layer::BannerLayer,
    // `minecraft:base_color` (a shield's dye).
    base_color: Maybe(^str),
    // The raid captain's banner: `minecraft:banner_patterns` with the
    // ominous layers, its item name, rarity and hidden tooltip.
    ominous_banner: bool,
    // `minecraft:ominous_bottle_amplifier` (None: the item's default, 0).
    ominous_amplifier: Maybe(u8),
    // `minecraft:dyed_color` (leather armour, wolf armour, ... as RGB).
    dyed_color: Maybe(i32),
    // `minecraft:firework_explosion` (a firework star).
    firework_explosion: Maybe(crate::firework::FireworkExplosion),
    // `minecraft:pot_decorations`: back, left, right, front sherds.
    pot_decorations: Maybe(Box<[Option<ItemStack),
    // `minecraft:bundle_contents`.
    bundle_contents: [dynamic]ItemStack,
    // `BundleContents.selectedItem`: runtime only, never saved or sent.
    bundle_selected: BundleSelected,
    // `minecraft:suspicious_stew_effects`: (effect id, duration).
    stew_effects: [dynamic](Arc<str,
    // `minecraft:map_post_processing`: 0 lock, 1 scale.
    map_post_processing: Maybe(u8),
    // Components Horizon does not model (lore, custom data, item name,
    // max stack size...), kept as their saved values in key order.
    other: Vec<(string,
    // What the server sent for this stack, for sending it back unchanged.
    wire: Wire,
}
// The component patch a server sent for a stack, as the creative slot packet
// writes it, and the stack Horizon decoded from it, to tell whether anything
// changed since. Like vanilla's `BundleContents.selectedItem` it is left out
// when stacks are compared.
Wire :: struct {
    // rust: impl Wire {
new :: proc(decoded: ItemStack, patch: ^[u8]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(Some(Arc::new((decoded, patch))))
}
    // The server's patch, whether or not the stack changed since.
patch :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0.as_deref().map(|(_, patch)| &**patch)
}
}
    // rust: impl PartialEq for Wire {
eq :: proc(self: ^Self, _: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
}
// A bundle's selected item index (-1: none). Like vanilla's
// `BundleContents.equals` it is left out when stacks are compared.
BundleSelected :: struct {
    // rust: impl Default for BundleSelected {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(-1)
}
}
    // rust: impl PartialEq for BundleSelected {
eq :: proc(self: ^Self, _: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
}
// The components `components_tag` writes from modelled fields.
    // rust: const MODELLED: &[&str] = &[
    // rust: "minecraft:banner_patterns",
    // rust: "minecraft:base_color",
    // rust: "minecraft:bundle_contents",
    // rust: "minecraft:charged_projectiles",
    // rust: "minecraft:container",
    // rust: "minecraft:custom_name",
    // rust: "minecraft:damage",
    // rust: "minecraft:dyed_color",
    // rust: "minecraft:enchantments",
    // rust: "minecraft:firework_explosion",
    // rust: "minecraft:fireworks",
    // rust: "minecraft:map_id",
    // rust: "minecraft:map_post_processing",
    // rust: "minecraft:ominous_bottle_amplifier",
    // rust: "minecraft:pot_decorations",
    // rust: "minecraft:potion_contents",
    // rust: "minecraft:repair_cost",
    // rust: "minecraft:stored_enchantments",
    // rust: "minecraft:suspicious_stew_effects",
    // rust: "minecraft:trim",
    // rust: "minecraft:writable_book_content",
    // rust: "minecraft:written_book_content",
    // rust: ];
    // rust: impl StackData {
custom_name_plain :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.custom_name.as_ref().and_then(read_text)
}

    // A preserved component's saved value.
other :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if id == "minecraft:custom_name" {
    // rust: return self.custom_name.as_ref();
}
    // rust: self.other.iter().find(|(k, _)| k == id).map(|(_, v)| v)
}
    // `SetNameFunction.run`: retain a loot name as its original component.
set_loot_name :: proc(self: ^Self, id: string, text: ^serde_json::Value) {
}
    // rust: let tag = horizon_client_core::scoreboard::json_to_tag(text);
    // rust: self.set_other(id, Some(tag));
}
    // `SetComponentsFunction`: one component of a loot patch, in its JSON
    // form. Trim is modelled; the rest keep their saved components.
    // A null value removes the component.
set_loot_component :: proc(self: ^Self, id: string, value: ^serde_json::Value) {
}
    // rust: let tag = (!value.is_null()).then(|| horizon_client_core::scoreboard::json_to_tag(value));
    // rust: match id {
    // rust: "minecraft:trim" => {
    // rust: self.trim = match (value["material"].as_str(), value["pattern"].as_str()) {
    // rust: (Some(material), Some(pattern)) => {
    // rust: Some((Arc::from(material), Arc::from(pattern)))
}
    // rust: _ => None,
}
}
    // rust: _ => self.set_other(id, tag),
}
}
    // Set (or with None remove) a preserved component.
set_other :: proc(self: ^Self, id: string, value: Maybe(Tag)) {
}
    // rust: self.other.retain(|(k, _)| k != id);
    // rust: if id == "minecraft:custom_name" {
    // rust: self.custom_name = value
    // rust: .filter(|tag| read_text(tag).is_some())
    // rust: .map(collapsed_text);
    // rust: return;
}
    // rust: if let Some(v) = value {
    // rust: self.other.push((id.to_owned(), v));
    // rust: self.other.sort_by(|a, b| a.0.cmp(&b.0));
}
}
    // `DebugStickState.properties().get(block)`: the property selected for
    // `block` in `minecraft:debug_stick_state`.
debug_stick_property :: proc(self: ^Self, block: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Tag::Compound(map) = self.other("minecraft:debug_stick_state")? else {
    // rust: return None;
}
    // rust: match map.get(&JavaString::from(block))? {
    // rust: Tag::String(property) => Some(property.to_string_lossy()),
    // rust: _ => None,
}
}
    // `DebugStickState.withProperty(block, property)`.
set_debug_stick_property :: proc(self: ^Self, block: string, property: string) {
}
    // rust: let mut map = match self.other("minecraft:debug_stick_state") {
    // rust: Some(Tag::Compound(map)) => map.clone(),
    // rust: _ => Default::default(),
}
    // rust: map.insert(
    // rust: JavaString::from(block),
    // rust: Tag::String(JavaString::from(property)),
    // rust: );
    // rust: self.set_other("minecraft:debug_stick_state", Some(Tag::Compound(map)));
}
}
// `Raid.getBannerComponentPatch`: the ominous banner's pattern layers.
    // rust: pub const OMINOUS_LAYERS: [(&str, &str); 8] = [
    // rust: ("rhombus", "cyan"),
    // rust: ("stripe_bottom", "light_gray"),
    // rust: ("stripe_center", "gray"),
    // rust: ("border", "light_gray"),
    // rust: ("stripe_middle", "black"),
    // rust: ("half_horizontal", "light_gray"),
    // rust: ("circle", "light_gray"),
    // rust: ("border", "black"),
    // rust: ];

// The raid captain banner's default tooltip setting, stored by vanilla as a
// component but represented by `StackData::ominous_banner` in Horizon.
ominous_tooltip_display :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound([(
    // rust: "hidden_components",
    // rust: Tag::List(vec![Tag::String("minecraft:banner_patterns".into())]),
    // rust: )])
}

// `WrittenBookContent` with the pages as plain text.
WrittenBook :: struct {
    title: string,
    author: string,
    generation: u8,
    pages: [dynamic]string,
    // Each page's component when it is not a plain string, so that its
    // click events survive; empty or one per page.
    page_tags: [dynamic]Tag,
}
    // rust: impl StackData {
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.wire.0.is_none() && *self == Self::default()
}
}

// `BlockItem.onDestroyed` (`ItemStack.onDestroyed` for a container item): the
// stack's `container` is emptied and the stacks it held come back in slot
// order — `ItemUtils.onContainerDestroyed` drops each where the entity lay.
destroyed_container :: proc(stack: ^ItemStack) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(data) = stack.extra.as_deref_mut() else {
    // rust: return Vec::new();
}
    // rust: if data.container.is_empty() {
    // rust: return Vec::new();
}
    // `set(CONTAINER, ItemContainerContents.EMPTY)`: no slot left filled.
    // rust: let mut held = std::mem::take(&mut data.container);
    // rust: stack.tidy();
    // `nonEmptyItemCopyStream` walks the 256 slots in order.
    // rust: held.sort_by_key(|(slot, _)| *slot);
    // rust: held.into_iter().map(|(_, stack)| stack).collect()
}

// `NbtOps.getBooleanValue`, used by boolean component codecs: every numeric tag
// is true unless its double value is zero. In particular, fractions stay true.
component_bool :: proc(value: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match value {
    // rust: Tag::Byte(v) => *v != 0,
    // rust: Tag::Short(v) => *v != 0,
    // rust: Tag::Int(v) => *v != 0,
    // rust: Tag::Long(v) => *v != 0,
    // rust: Tag::Float(bits) => f32::from_bits(*bits) != 0.0,
    // rust: Tag::Double(bits) => f64::from_bits(*bits) != 0.0,
    // rust: _ => return None,
    // rust: })
}

    // rust: impl ItemStack {
new :: proc(item: string, count: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: item: Arc::from(item),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
}
}
data :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.extra.as_deref()
}
    // The patch the server sent for this stack, while the stack is still what
    // it decoded to (its count aside); None once anything else changed.
wire_patch :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (decoded, patch) = &**self.data()?.wire.0.as_ref()?;
    // rust: let none = StackData::default();
    // rust: (decoded.item == self.item
    // rust: && decoded.damage == self.damage
    // rust: && decoded.data().unwrap_or(&none) == self.data().unwrap_or(&none))
    // rust: .then(|| patch.clone())
}
data_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.extra.get_or_insert_with(Box::default)
}
    // Drops an all-default component box so equal stacks compare equal.
tidy :: proc(self: ^Self) {
}
    // rust: if self.extra.as_ref().is_some_and(|d| d.is_empty()) {
    // rust: self.extra = None;
}
}
enchantments :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.data().map_or(&[], |d| &d.enchantments)
}
stored_enchantments :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.data().map_or(&[], |d| &d.stored_enchantments)
}
    // `EnchantmentHelper.getItemEnchantmentLevel` (0 when absent).
enchantment_level :: proc(self: ^Self, id: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.enchantments()
    // rust: .iter()
    // rust: .find(|(e, _)| &**e == id)
    // rust: .map_or(0, |(_, l)| *l)
}
    // The component an anvil/grindstone works on: stored for books.
crafting_enchantments :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if &*self.item == "minecraft:enchanted_book" {
    // rust: self.stored_enchantments()
    // rust: } else {
    // rust: self.enchantments()
}
}
set_crafting_enchantments :: proc(self: ^Self, levels: Levels) {
}
    // rust: if &*self.item == "minecraft:enchanted_book" {
    // rust: self.data_mut().stored_enchantments = levels;
    // rust: } else {
    // rust: self.data_mut().enchantments = levels;
}
    // rust: self.tidy();
}
    // `ItemStack.enchant`: upgrade to the higher level.
enchant :: proc(self: ^Self, id: string, level: u32) {
}
    // rust: let book = &*self.item == "minecraft:enchanted_book";
    // rust: let data = self.data_mut();
    // rust: let list = if book {
    // rust: &mut data.stored_enchantments
    // rust: } else {
    // rust: &mut data.enchantments
}
    // rust: upgrade(list, id, level);
}
has_any_enchantments :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.enchantments().is_empty() || !self.stored_enchantments().is_empty()
}
    // `ItemStack.hasFoil`: an explicit `minecraft:enchantment_glint_override`
    // component wins, then the item's default override (`item_glint`), then a
    // non-empty `minecraft:enchantments` component (`Item.isFoil` is
    // `ItemStack.isEnchanted`; stored book enchantments do not count).
has_foil :: proc(self: ^Self, item_glint: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(flag) = self
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:enchantment_glint_override"))
    // rust: .and_then(component_bool)
    // rust: {
    // rust: return flag;
}
    // rust: item_glint || !self.enchantments().is_empty()
}
repair_cost :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.data().map_or(0, |d| d.repair_cost)
}
custom_name :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.data()?.custom_name_plain()
}
    // `ResolvableProfile.name`: a bare profile string or its `name` field.
profile_name :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let profile = self.data()?.other("minecraft:profile")?;
    // rust: string(profile).or_else(|| profile.get("name").and_then(string))
}
    // `minecraft:item_name` in the current language (`getItemName`'s
    // component). It stays in the patch as loaded, so a translatable name
    // saves and reaches clients unchanged; the ominous banner's is modelled
    // by `ominous_banner` instead.
item_name :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = self.data()?.other("minecraft:item_name")?;
    // rust: Some(horizon_client_core::component::name_text(name).plain())
}
potion :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.data().and_then(|d| d.potion.as_deref())
}
    // `PotionContents.customEffects` as saved: (id, duration, amplifier). Both
    // default to 0 like `MobEffectInstance.CODEC`.
custom_potion_effects :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some((_, Tag::List(list))) = self
    // rust: .data()
    // rust: .and_then(|d| d.potion_extra.iter().find(|(k, _)| k == "custom_effects"))
    // rust: else {
    // rust: return Vec::new();
}
    // rust: list.iter()
    // rust: .filter_map(|e| {
    // rust: Some((
    // rust: string(e.get("id")?)?,
    // rust: e.get("duration").and_then(int).unwrap_or(0) as i32,
    // rust: e.get("amplifier").and_then(int).unwrap_or(0).clamp(0, 255) as i32,
    // rust: ))
    // rust: })
    // rust: .collect()
}
    // `DataComponents.POTION_DURATION_SCALE` with the item's default: 0.125
    // for a tipped arrow, 0.25 for a lingering potion, else 1.
potion_duration_scale :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:potion_duration_scale"))
    // rust: {
    // rust: Some(Tag::Float(bits)) => f32::from_bits(*bits),
    // rust: Some(Tag::Double(bits)) => f64::from_bits(*bits) as f32,
    // rust: Some(t) if int(t).is_some() => int(t).unwrap_or(1) as f32,
    // rust: _ => match &*self.item {
    // rust: "minecraft:tipped_arrow" => 0.125,
    // rust: "minecraft:lingering_potion" => 0.25,
    // rust: _ => 1.0,
    // rust: },
}
}
with_potion :: proc(potion: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.data_mut().potion = Some(Arc::from(potion));
    // rust: self
}
    // `ItemStack.isSameItemSameComponents`.
same_item_same_components :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.item == other.item && self.damage == other.damage && self.data() == other.data()
}
    // `ItemStack.transmuteCopy`: another item keeping every component.
transmute :: proc(self: ^Self, item: string, count: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut stack = Self {
    // rust: item: Arc::from(item),
    // rust: count,
    // rust: ..self.clone()
}
    // rust: stack.tidy();
    // rust: stack
}
}
// `ItemEnchantments.Mutable.upgrade`.
upgrade :: proc(list: ^Levels, id: string, level: u32) {
}
    // rust: if level == 0 {
    // rust: return;
}
    // rust: match list.iter_mut().find(|(e, _)| &**e == id) {
    // rust: Some((_, l)) => *l = (*l).max(level),
    // rust: None => list.push((Arc::from(id), level)),
}
}
// `ItemEnchantments.Mutable.set` (level 0 removes).
set_level :: proc(list: ^Levels, id: string, level: u32) {
}
    // rust: if level == 0 {
    // rust: list.retain(|(e, _)| &**e != id);
    // rust: } else {
    // rust: match list.iter_mut().find(|(e, _)| &**e == id) {
    // rust: Some((_, l)) => *l = level,
    // rust: None => list.push((Arc::from(id), level)),
}
}
}

levels_tag :: proc(levels: ^Levels) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound(levels.iter().map(|(id, l)| (&**id, Tag::Int(*l as i32))))
}
int :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tag::Byte(v) => Some(i64::from(*v)),
    // rust: Tag::Short(v) => Some(i64::from(*v)),
    // rust: Tag::Int(v) => Some(i64::from(*v)),
    // rust: Tag::Long(v) => Some(*v),
    // rust: _ => None,
}
}
string :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
// The persistent `ItemEnchantments` codec uses integer levels in 1..=255.
// `TagValueInput.read` keeps the partial map when an entry fails decoding.
read_levels :: proc(t: Maybe(^Tag)) -> L {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Tag::Compound(map)) = t else {
    // rust: return Vec::new();
}
    // Pre-1.21.5 worlds wrap the map in {levels: {...}}.
    // rust: let map = match map.get(&JavaString::from("levels")) {
    // rust: Some(Tag::Compound(inner)) => inner,
    // rust: _ => map,
}
    // The keys are enchantment Identifiers: `knockback` is `minecraft:knockback`.
    // rust: map.iter()
    // rust: .filter_map(|(k, v)| {
    // rust: let level = horizon_world::datafix::dynamic::as_number(v)?.int_value();
    // rust: if !(1..=255).contains(&level) {
    // rust: return None;
}
    // rust: let id = horizon_world::datafix::dynamic::namespaced(&k.to_string_lossy());
    // rust: Some((Arc::from(id), level as u32))
    // rust: })
    // rust: .collect()
}
// A text component as stored by vanilla: a plain string or `{"text": ...}`.
// A `Filterable<String/Component>`: the value itself or `{raw: value}`.
// `ComponentSerialization.CODEC`'s short form: a plain text component with
// no style and no siblings is written as its string.
plain_component :: proc(t: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if let Tag::Compound(c) = t
    // rust: && let Some(text @ Tag::String(_)) = c.get(&"text".into())
    // rust: && c.iter().all(|(k, v)| {
    // rust: k.to_string_lossy() == "text"
    // rust: || (k.to_string_lossy() == "type"
    // rust: && matches!(v, Tag::String(s) if s.to_string_lossy() == "text"))
    // rust: })
    // rust: {
    // rust: return text.clone();
}
    // rust: t.clone()
}
filterable_text :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t.get("raw") {
    // rust: Some(raw) => read_text(raw),
    // rust: None => read_text(t),
}
}
read_text :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
        // A component's root `text` may be empty with the visible words in
        // `extra` (every legacy display name ViaVersion produces looks like
        // this), so flatten the whole component instead of reading one key.
        // ComponentSerialization.CODEC also takes a list (its first element
        // styling the rest), as servers behind ViaVersion send book pages.
    // rust: Tag::Compound(_) | Tag::List(_) => {
    // rust: Some(horizon_client_core::component::name_text(t).plain())
}
    // rust: _ => None,
}
}

// `Component.tryCollapseToString`: `ComponentSerialization.CODEC` writes
// plain text with no style and no siblings as a bare string.
collapsed_text :: proc(tag: Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if let Tag::Compound(map) = &tag
    // rust: && let Some(Tag::String(text)) = tag.get("text")
    // rust: && map
    // rust: .iter()
    // rust: .all(|(key, value)| match key.to_string_lossy().as_str() {
    // rust: "text" => true,
    // rust: "type" => matches!(value, Tag::String(s) if s.to_string_lossy() == "text"),
    // rust: "extra" => matches!(value, Tag::List(l) if l.is_empty()),
    // rust: _ => false,
    // rust: })
    // rust: {
    // rust: return Tag::String(text.clone());
}
    // rust: tag
}

// A `FireworkExplosion` as vanilla's codec writes it (defaults omitted).
explosion_tag :: proc(e: ^crate::firework::FireworkExplosion) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let colors = |c: &[u32]| Tag::List(c.iter().map(|c| Tag::Int(*c as i32)).collect());
    // rust: let mut fields = vec![("shape", Tag::String(e.shape.name().into()))];
    // rust: if !e.colors.is_empty() {
    // rust: fields.push(("colors", colors(&e.colors)));
}
    // rust: if !e.fade.is_empty() {
    // rust: fields.push(("fade_colors", colors(&e.fade)));
}
    // rust: if e.trail {
    // rust: fields.push(("has_trail", Tag::Byte(1)));
}
    // rust: if e.twinkle {
    // rust: fields.push(("has_twinkle", Tag::Byte(1)));
}
    // rust: Tag::compound(fields)
}
explosion_from :: proc(e: ^Tag) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let ints = |t: Option<&Tag>| match t {
    // rust: Some(Tag::IntArray(v)) => v.iter().map(|c| *c as u32).collect(),
    // rust: Some(Tag::List(v)) => v.iter().filter_map(int).map(|c| c as u32).collect(),
    // rust: _ => Vec::new(),
}
    // rust: crate::firework::FireworkExplosion {
    // rust: shape: crate::firework::FireworkShape::from_name(
    // rust: e.get("shape")
    // rust: .and_then(string)
    // rust: .as_deref()
    // rust: .map_or("small_ball", |s| s.strip_prefix("minecraft:").unwrap_or(s)),
    // rust: ),
    // rust: colors: ints(e.get("colors")),
    // rust: fade: ints(e.get("fade_colors")),
    // rust: trail: e.get("has_trail").and_then(int).unwrap_or(0) != 0,
    // rust: twinkle: e.get("has_twinkle").and_then(int).unwrap_or(0) != 0,
}
}
// An `ItemStackTemplate`: `{id, count?, components?}`.
template_tag :: proc(stack: ^ItemStack) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries = vec![("id", Tag::String((&*stack.item).into()))];
    // rust: if stack.count != 1 {
    // rust: entries.push(("count", Tag::Int(stack.count as i32)));
}
    // rust: if let Some(components) = encode_components(stack) {
    // rust: entries.push(("components", components));
}
    // rust: Tag::compound(entries)
}
// The pot prototype's decorations: a brick on every side.
all_bricks :: proc(sides: ^[Maybe(ItemStack); 4]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: sides.iter().all(|s| {
    // rust: s.as_ref()
    // rust: .is_some_and(|s| &*s.item == "minecraft:brick" && s.count == 1 && s.extra.is_none())
    // rust: })
}
template_from :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: Tag::String(id) => Some(ItemStack::new(&id.to_string_lossy(), 1)),
    // rust: _ => {
    // rust: let id = tag.get("id").and_then(string)?;
    // rust: let (damage, extra) = decode_components(tag.get("components"));
    // rust: Some(ItemStack {
    // rust: item: Arc::from(id.as_str()),
    // rust: count: tag.get("count").and_then(int).unwrap_or(1).max(1) as u32,
    // rust: damage,
    // rust: extra,
    // rust: })
}
}
}
// The stack a `show_item` hover event holds (`HoverEvent.ShowItem`): its
// `{id, count?, components?}` object.
stack_from_hover :: proc(event: ^serde_json::Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: template_from(&horizon_client_core::scoreboard::json_to_tag(event))
}
// Sorted-key, type-annotated text of a tag (the differential harnesses
// print the same form from the vanilla side).
canon_tag :: proc(tag: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
list :: proc(out: ^string, prefix: string, items: impl Iterator<Item = string>) {
}
    // rust: out.push_str(prefix);
    // rust: out.push_str(&items.collect::<Vec<_>>().join(","));
    // rust: out.push(']');
}
go :: proc(tag: ^Tag, out: ^string) {
}
//         use std::fmt::Write as _;
    // rust: match tag {
    // rust: Tag::End => {}
    // rust: Tag::Byte(v) => write!(out, "{v}b").unwrap(),
    // rust: Tag::Short(v) => write!(out, "{v}s").unwrap(),
    // rust: Tag::Int(v) => write!(out, "{v}").unwrap(),
    // rust: Tag::Long(v) => write!(out, "{v}L").unwrap(),
    // rust: Tag::Float(v) => write!(out, "{}f", f32::from_bits(*v)).unwrap(),
    // rust: Tag::Double(v) => write!(out, "{}d", f64::from_bits(*v)).unwrap(),
    // rust: Tag::String(s) => write!(
    // rust: out,
    // rust: "\"{}\"",
    // rust: s.to_string_lossy()
    // rust: .replace('\\', "\\\\")
    // rust: .replace('"', "\\\"")
    // rust: )
    // rust: .unwrap(),
    // rust: Tag::ByteArray(v) => list(out, "[B;", v.iter().map(|b| (*b as i8).to_string())),
    // rust: Tag::IntArray(v) => list(out, "[I;", v.iter().map(i32::to_string)),
    // rust: Tag::LongArray(v) => list(out, "[L;", v.iter().map(i64::to_string)),
    // rust: Tag::List(items) => {
    // rust: out.push('[');
    // rust: for (i, t) in items.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: go(t, out);
}
    // rust: out.push(']');
}
    // rust: Tag::Compound(map) => {
    // rust: let mut keys: Vec<(String, &Tag)> =
    // rust: map.iter().map(|(k, v)| (k.to_string_lossy(), v)).collect();
    // rust: keys.sort_by(|a, b| a.0.cmp(&b.0));
    // rust: out.push('{');
    // rust: for (i, (k, v)) in keys.into_iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: out.push_str(&k);
    // rust: out.push(':');
    // rust: go(v, out);
}
    // rust: out.push('}');
}
}
}
    // rust: let mut out = String::new();
    // rust: go(tag, &mut out);
    // rust: out
}
// `canon_tag` of a stack as `ItemStack.CODEC` writes it; "-" for none.
canon_stack :: proc(stack: Maybe(^ItemStack)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: stack.map_or_else(
    // rust: || "-".to_owned(),
    // rust: |s| canon_tag(&crate::item_nbt::item_to_nbt(s)),
    // rust: )
}
// The stack of an SNBT `ItemStack.CODEC` compound; None for "-".
parse_stack :: proc(snbt: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if snbt == "-" {
    // rust: return Ok(None);
}
    // rust: let (tag, _) = horizon_world::nbt::parse_snbt(snbt)?;
    // rust: Ok(crate::item_nbt::item_from_nbt(&tag))
}
// `MapDecorations.Entry.CODEC`: a bare type ID uses the default resource namespace.
// Keep preserved entry keys and numeric tags intact; this is not registry validation.
canonical_other_component :: proc(id: string, tag: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut value = tag.clone();
    // rust: if id == "minecraft:map_decorations"
    // rust: && let Tag::Compound(entries) = &mut value
    // rust: {
    // rust: for entry in entries.values_mut() {
    // rust: if let Some(Tag::String(kind)) = entry.get_mut("type") {
    // rust: let text = kind.to_string_lossy();
    // rust: if !text.is_empty()
    // rust: && !text.contains(':')
    // rust: && let Ok(id) = horizon_world::identifier::Identifier::parse(&text)
    // rust: {
    // rust: *kind = id.to_string().as_str().into();
}
}
}
}
    // rust: value
}
// The saved `DataComponentPatch.CODEC` compound, or None when default.
// A filled map's empty decorations equal its prototype (`Items.mapProperties`).
encode_components :: proc(stack: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut components = components_tag(stack.damage, stack.data())?;
    // rust: if &*stack.item == "minecraft:filled_map"
    // rust: && matches!(components.get("minecraft:map_decorations"), Some(Tag::Compound(entries)) if entries.is_empty())
    // rust: && let Tag::Compound(entries) = &mut components
    // rust: {
    // rust: entries.remove(&JavaString::from("minecraft:map_decorations"));
    // rust: if entries.is_empty() {
    // rust: return None;
}
}
    // rust: Some(components)
}
// `encode_components` from the damage value and extra components.
components_tag :: proc(damage: u32, data: Maybe(^StackData)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries: Vec<(&str, Tag)> = Vec::new();
    // rust: if damage > 0 {
    // rust: entries.push(("minecraft:damage", Tag::Int(damage as i32)));
}
    // rust: if let Some(d) = data {
    // rust: if !d.enchantments.is_empty() {
    // rust: entries.push(("minecraft:enchantments", levels_tag(&d.enchantments)));
}
    // rust: if !d.stored_enchantments.is_empty() {
    // rust: entries.push((
    // rust: "minecraft:stored_enchantments",
    // rust: levels_tag(&d.stored_enchantments),
    // rust: ));
}
    // rust: if d.repair_cost > 0 {
    // rust: entries.push(("minecraft:repair_cost", Tag::Int(d.repair_cost as i32)));
}
    // rust: if let Some(name) = &d.custom_name {
    // rust: entries.push(("minecraft:custom_name", name.clone()));
}
    // rust: if d.potion.is_some() || !d.potion_extra.is_empty() {
    // rust: let potion = d
    // rust: .potion
    // rust: .as_ref()
    // rust: .map(|p| ("potion", Tag::String((&**p).into())));
    // rust: let extra = d.potion_extra.iter().map(|(k, v)| (k.as_str(), v.clone()));
    // rust: entries.push((
    // rust: "minecraft:potion_contents",
    // rust: Tag::compound(potion.into_iter().chain(extra)),
    // rust: ));
}
    // rust: if let Some((material, pattern)) = &d.trim {
    // rust: entries.push((
    // rust: "minecraft:trim",
    // rust: Tag::compound([
    // rust: ("material", Tag::String((&**material).into())),
    // rust: ("pattern", Tag::String((&**pattern).into())),
    // rust: ]),
    // rust: ));
}
    // rust: if let Some(id) = d.map_id {
    // rust: entries.push(("minecraft:map_id", Tag::Int(id)));
}
    // rust: if !d.banner_patterns.is_empty() {
    // rust: entries.push((
    // rust: "minecraft:banner_patterns",
    // rust: crate::banner_layer::layers_to_nbt(&d.banner_patterns),
    // rust: ));
}
    // rust: if let Some(color) = &d.base_color {
    // rust: entries.push(("minecraft:base_color", Tag::String((&**color).into())));
}
        // Filterable values are saved as {raw: ..}.
    // rust: let raw = |t: Tag| Tag::compound([("raw", t)]);
    // rust: if !d.writable_pages.is_empty() {
    // rust: let pages = d
    // rust: .writable_pages
    // rust: .iter()
    // rust: .map(|p| raw(Tag::String(p.as_str().into())))
    // rust: .collect();
    // rust: entries.push((
    // rust: "minecraft:writable_book_content",
    // rust: Tag::compound([("pages", Tag::List(pages))]),
    // rust: ));
}
    // rust: if let Some(w) = &d.written {
    // rust: let pages = if w.page_tags.len() == w.pages.len() {
    // rust: w.page_tags.iter().cloned().map(raw).collect()
    // rust: } else {
    // rust: w.pages
    // rust: .iter()
    // rust: .map(|p| raw(Tag::String(p.as_str().into())))
    // rust: .collect()
}
    // rust: entries.push((
    // rust: "minecraft:written_book_content",
    // rust: Tag::compound({
    // rust: let mut fields = vec![
    // rust: ("title", raw(Tag::String(w.title.as_str().into()))),
    // rust: ("author", Tag::String(w.author.as_str().into())),
    // rust: ];
                    // `optionalFieldOf("pages", List.of())`: no pages, no field.
    // rust: if !w.pages.is_empty() {
    // rust: fields.push(("pages", Tag::List(pages)));
}
    // rust: if w.generation != 0 {
    // rust: fields.push(("generation", Tag::Int(i32::from(w.generation))));
}
    // rust: fields
    // rust: }),
    // rust: ));
}
    // rust: if let Some((flight, explosions)) = &d.fireworks {
    // rust: let mut fields = Vec::new();
    // rust: if *flight != 0 {
    // rust: fields.push(("flight_duration", Tag::Byte(*flight as i8)));
}
    // rust: if !explosions.is_empty() {
    // rust: fields.push((
    // rust: "explosions",
    // rust: Tag::List(explosions.iter().map(explosion_tag).collect()),
    // rust: ));
}
    // rust: entries.push(("minecraft:fireworks", Tag::compound(fields)));
}
    // rust: if let Some(e) = &d.firework_explosion {
    // rust: entries.push(("minecraft:firework_explosion", explosion_tag(e)));
}
    // rust: if let Some(color) = d.dyed_color {
    // rust: entries.push(("minecraft:dyed_color", Tag::Int(color)));
}
    // rust: if let Some(sides) = &d.pot_decorations {
    // rust: let mut sherds = Vec::new();
    // rust: for (name, side) in ["back", "left", "right", "front"].iter().zip(sides.iter()) {
    // rust: if let Some(stack) = side {
    // rust: sherds.push((*name, template_tag(stack)));
}
}
    // rust: entries.push(("minecraft:pot_decorations", Tag::compound(sherds)));
}
    // rust: if !d.bundle_contents.is_empty() {
    // rust: entries.push((
    // rust: "minecraft:bundle_contents",
    // rust: Tag::List(d.bundle_contents.iter().map(template_tag).collect()),
    // rust: ));
}
    // rust: if !d.stew_effects.is_empty() {
    // rust: entries.push((
    // rust: "minecraft:suspicious_stew_effects",
    // rust: Tag::List(
    // rust: d.stew_effects
    // rust: .iter()
    // rust: .map(|(id, duration)| {
                            // The codec leaves out the default duration (160).
    // rust: let mut e = vec![("id", Tag::String((&**id).into()))];
    // rust: if *duration != 160 {
    // rust: e.push(("duration", Tag::Int(*duration)));
}
    // rust: Tag::compound(e)
    // rust: })
    // rust: .collect(),
    // rust: ),
    // rust: ));
}
        // minecraft:map_post_processing is transient: ItemStack.CODEC never
        // saves it (only the network carries it).
    // rust: if !d.charged.is_empty() {
    // rust: entries.push((
    // rust: "minecraft:charged_projectiles",
    // rust: Tag::List(d.charged.iter().map(template_tag).collect()),
    // rust: ));
}
    // rust: if d.ominous_banner {
    // rust: let layer = |pattern: &str, color: &str| {
    // rust: Tag::compound([
    // rust: (
    // rust: "pattern",
    // rust: Tag::String(format!("minecraft:{pattern}").as_str().into()),
    // rust: ),
    // rust: ("color", Tag::String(color.into())),
    // rust: ])
}
    // rust: entries.push((
    // rust: "minecraft:banner_patterns",
    // rust: Tag::List(OMINOUS_LAYERS.iter().map(|(p, c)| layer(p, c)).collect()),
    // rust: ));
    // rust: if d.other("minecraft:tooltip_display").is_none() {
    // rust: entries.push(("minecraft:tooltip_display", ominous_tooltip_display()));
}
    // rust: entries.push((
    // rust: "minecraft:item_name",
    // rust: Tag::compound([(
    // rust: "translate",
    // rust: Tag::String("block.minecraft.ominous_banner".into()),
    // rust: )]),
    // rust: ));
    // rust: entries.push(("minecraft:rarity", Tag::String("uncommon".into())));
}
    // rust: if let Some(a) = d.ominous_amplifier {
    // rust: entries.push(("minecraft:ominous_bottle_amplifier", Tag::Int(i32::from(a))));
}
    // rust: if !d.container.is_empty() {
    // rust: let slots = d
    // rust: .container
    // rust: .iter()
    // rust: .map(|(slot, stack)| {
    // rust: Tag::compound([
    // rust: ("slot", Tag::Int(i32::from(*slot))),
    // rust: ("item", template_tag(stack)),
    // rust: ])
    // rust: })
    // rust: .collect();
    // rust: entries.push(("minecraft:container", Tag::List(slots)));
}
}
    // rust: let mut out: horizon_world::nbt::Compound = entries
    // rust: .into_iter()
    // rust: .map(|(k, v)| (JavaString::from(k), v))
    // rust: .collect();
    // rust: if let Some(d) = data {
    // rust: for (k, v) in &d.other {
    // rust: out.entry(JavaString::from(k.as_str()))
    // rust: .or_insert_with(|| canonical_other_component(k, v));
}
}
    // rust: (!out.is_empty()).then_some(Tag::Compound(out))
}
// Damage and extra components from a stack's `components` compound.
decode_components :: proc(components: Maybe(^Tag)) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let Some(c) = components else {
    // rust: return (0, None);
}
    // NbtOps.getNumberValue supplies a boxed number; Codec.INT truncates its value.
    // rust: let damage =
    // rust: horizon_world::datafix::dynamic::as_int(c.get("minecraft:damage"), 0).max(0) as u32;
    // rust: let potion = match c.get("minecraft:potion_contents") {
    // rust: Some(Tag::String(s)) => Some(Arc::from(s.to_string_lossy().as_str())),
    // rust: Some(t) => t
    // rust: .get("potion")
    // rust: .and_then(string)
    // rust: .map(|s| Arc::from(s.as_str())),
    // rust: None => None,
}
    // rust: let potion_extra = match c.get("minecraft:potion_contents") {
    // rust: Some(Tag::Compound(map)) => map
    // rust: .iter()
    // rust: .filter(|(k, _)| k.to_string_lossy() != "potion")
    // rust: .map(|(k, v)| (k.to_string_lossy(), v.clone()))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: let data = StackData {
    // rust: enchantments: read_levels(c.get("minecraft:enchantments")),
    // rust: stored_enchantments: read_levels(c.get("minecraft:stored_enchantments")),
    // rust: repair_cost: c
    // rust: .get("minecraft:repair_cost")
    // rust: .and_then(int)
    // rust: .unwrap_or(0)
    // rust: .max(0) as u32,
    // rust: custom_name: c
    // rust: .get("minecraft:custom_name")
    // rust: .filter(|tag| read_text(tag).is_some())
    // rust: .cloned()
    // rust: .map(collapsed_text),
    // rust: potion,
    // rust: potion_extra,
    // rust: map_id: c.get("minecraft:map_id").and_then(int).map(|v| v as i32),
    // rust: banner_patterns: crate::banner_layer::layers_from_nbt(c.get("minecraft:banner_patterns")),
    // rust: base_color: c
    // rust: .get("minecraft:base_color")
    // rust: .and_then(string)
    // rust: .map(|s| Arc::from(s.as_str())),
    // rust: writable_pages: match c
    // rust: .get("minecraft:writable_book_content")
    // rust: .and_then(|b| b.get("pages"))
    // rust: {
    // rust: Some(Tag::List(pages)) => pages.iter().filter_map(filterable_text).collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: written: c
    // rust: .get("minecraft:written_book_content")
    // rust: .map(|b| WrittenBook {
    // rust: title: b.get("title").and_then(filterable_text).unwrap_or_default(),
    // rust: author: b.get("author").and_then(string).unwrap_or_default(),
    // rust: generation: b.get("generation").and_then(int).unwrap_or(0).clamp(0, 3) as u8,
    // rust: pages: match b.get("pages") {
    // rust: Some(Tag::List(pages)) => pages.iter().filter_map(filterable_text).collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: page_tags: match b.get("pages") {
    // rust: Some(Tag::List(pages)) => pages
    // rust: .iter()
    // rust: .map(|p| plain_component(p.get("raw").unwrap_or(p)))
    // rust: .collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: }),
    // rust: fireworks: c
    // rust: .get("minecraft:fireworks")
    // rust: .map(|f| {
    // rust: let flight = f
    // rust: .get("flight_duration")
    // rust: .and_then(int)
    // rust: .unwrap_or(0)
    // rust: .clamp(0, 255) as u8;
    // rust: let explosions = match f.get("explosions") {
    // rust: Some(Tag::List(list)) => list.iter().map(explosion_from).collect(),
    // rust: _ => Vec::new(),
}
    // rust: (flight, explosions)
    // rust: })
    // rust: .filter(|(flight, explosions)| !(*flight == 1 && explosions.is_empty())),
    // rust: firework_explosion: c.get("minecraft:firework_explosion").map(explosion_from),
    // rust: dyed_color: c
    // rust: .get("minecraft:dyed_color")
    // rust: .and_then(int)
    // rust: .map(|v| v as i32),
    // rust: pot_decorations: c
    // rust: .get("minecraft:pot_decorations")
    // rust: .map(|p| {
    // rust: let side = |name: &str| p.get(name).and_then(template_from);
    // rust: Box::new([side("back"), side("left"), side("right"), side("front")])
    // rust: })
    // rust: .filter(|sides| !all_bricks(sides)),
    // rust: bundle_contents: match c.get("minecraft:bundle_contents") {
    // rust: Some(Tag::List(list)) => list.iter().filter_map(template_from).collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: stew_effects: match c.get("minecraft:suspicious_stew_effects") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter_map(|e| {
    // rust: Some((
    // rust: Arc::from(e.get("id").and_then(string)?.as_str()),
    // rust: e.get("duration").and_then(int).unwrap_or(160) as i32,
    // rust: ))
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: map_post_processing: match c.get("minecraft:map_post_processing") {
    // rust: Some(Tag::String(s)) => Some(u8::from(s.to_string_lossy() != "lock")),
    // rust: Some(t) => int(t).map(|v| v.clamp(0, 1) as u8),
    // rust: None => None,
    // rust: },
    // rust: charged: match c.get("minecraft:charged_projectiles") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter_map(crate::item_nbt::item_from_nbt)
    // rust: .collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: container: match c.get("minecraft:container") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter_map(|e| {
    // rust: Some((
    // rust: e.get("slot").and_then(int)?.clamp(0, 255) as u8,
    // rust: template_from(e.get("item")?)?,
    // rust: ))
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: ominous_banner: c
    // rust: .get("minecraft:item_name")
    // rust: .and_then(|n| n.get("translate"))
    // rust: .and_then(string)
    // rust: .as_deref()
    // rust: == Some("block.minecraft.ominous_banner")
    // rust: && matches!(
    // rust: c.get("minecraft:banner_patterns"),
    // rust: Some(Tag::List(layers)) if layers.len() == OMINOUS_LAYERS.len()),
    // rust: ominous_amplifier: c
    // rust: .get("minecraft:ominous_bottle_amplifier")
    // rust: .and_then(int)
    // rust: .map(|v| v.clamp(0, 4) as u8),
    // rust: trim: c.get("minecraft:trim").and_then(|t| {
    // rust: Some((
    // rust: Arc::from(t.get("material").and_then(string)?.as_str()),
    // rust: Arc::from(t.get("pattern").and_then(string)?.as_str()),
    // rust: ))
    // rust: }),
    // rust: bundle_selected: BundleSelected::default(),
    // rust: other: Vec::new(),
    // rust: wire: Wire::default(),
}
    // rust: let mut data = data;
    // rust: if let Tag::Compound(map) = c {
    // rust: for (k, v) in map {
    // rust: let key = k.to_string_lossy();
    // rust: let ominous_part = data.ominous_banner
    // rust: && (matches!(key.as_str(), "minecraft:item_name" | "minecraft:rarity")
    // rust: || (key == "minecraft:tooltip_display" && v == &ominous_tooltip_display()));
    // rust: if !MODELLED.contains(&key.as_str()) && !ominous_part {
    // rust: let value = canonical_other_component(&key, v);
    // rust: data.other.push((key, value));
}
}
    // rust: data.other.sort_by(|a, b| a.0.cmp(&b.0));
}
    // rust: (damage, (!data.is_empty()).then(|| Box::new(data)))
}

// The `[id=value,...]` component list of an item argument (`ItemParser`)
// as a `components` compound; `!id` removals are skipped.
command_components :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let inner = text
    // rust: .strip_prefix('[')
    // rust: .and_then(|t| t.strip_suffix(']'))
    // rust: .ok_or("expected '['")?;
    // rust: let mut entries = horizon_world::nbt::Compound::new();
    // rust: let mut rest = inner.trim_start();
    // rust: while !rest.is_empty() {
    // rust: let end = rest.find(['=', ',']).unwrap_or(rest.len());
    // rust: let key = rest[..end].trim();
    // rust: rest = &rest[end..];
    // rust: if let Some(value) = rest.strip_prefix('=') {
    // rust: let (tag, used) = horizon_world::nbt::parse_snbt(value)?;
    // rust: let id = if key.contains(':') {
    // rust: key.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{key}")
}
    // rust: entries.insert(JavaString::from(id.as_str()), tag);
    // rust: rest = &value[used..];
}
    // rust: rest = rest.trim_start();
    // rust: rest = rest.strip_prefix(',').unwrap_or(rest).trim_start();
}
    // rust: Ok(Tag::Compound(entries))
}
    // rust: mod tests {
//     use super::*;

numeric_damage_decodes_and_saves_as_a_modelled_int :: proc() {
}
    // rust: let keep = Tag::compound([("keep", Tag::Int(87))]);
    // rust: for (raw, expected) in [
    // rust: (None, 0),
    // rust: (Some(Tag::Byte(1)), 1),
    // rust: (Some(Tag::Short(1)), 1),
    // rust: (Some(Tag::Int(1)), 1),
    // rust: (Some(Tag::Long(4_294_967_297)), 1),
    // rust: (Some(Tag::Float(1.5_f32.to_bits())), 1),
    // rust: (Some(Tag::Double(2.75_f64.to_bits())), 2),
    // rust: (Some(Tag::Float((-0.5_f32).to_bits())), 0),
    // rust: (
    // rust: Some(Tag::Float(2_147_483_648_f32.to_bits())),
    // rust: i32::MAX as u32,
    // rust: ),
    // rust: (Some(Tag::Double(1.0e20_f64.to_bits())), i32::MAX as u32),
    // rust: ] {
    // rust: let mut entries = vec![("minecraft:custom_data", keep.clone())];
    // rust: if let Some(raw) = &raw {
    // rust: entries.push(("minecraft:damage", raw.clone()));
}
    // rust: let (damage, extra) = decode_components(Some(&Tag::compound(entries)));
    // rust: let loaded = ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..ItemStack::new("minecraft:diamond_pickaxe", 1)
}
    // rust: assert_eq!(loaded.damage, expected, "{raw:?}");
    // rust: assert!(loaded.wire_patch().is_none());
    // rust: assert!(loaded.data().unwrap().other("minecraft:damage").is_none());
    // rust: let saved = crate::item_nbt::item_to_nbt(&loaded);
    // rust: assert_eq!(
    // rust: saved
    // rust: .get("components")
    // rust: .and_then(|c| c.get("minecraft:damage")),
    // rust: (expected > 0).then_some(&Tag::Int(expected as i32)),
    // rust: "{raw:?}"
    // rust: );
    // rust: assert_eq!(
    // rust: saved
    // rust: .get("components")
    // rust: .unwrap()
    // rust: .get("minecraft:custom_data"),
    // rust: Some(&keep)
    // rust: );
            // No retained source or wire patch: only modelled damage is saved.
    // rust: let mut fresh = ItemStack::new("minecraft:diamond_pickaxe", 1);
    // rust: fresh.damage = expected;
    // rust: fresh
    // rust: .data_mut()
    // rust: .set_other("minecraft:custom_data", Some(keep.clone()));
    // rust: assert_eq!(crate::item_nbt::item_to_nbt(&fresh), saved);
}
}

map_decoration_types_round_trip_with_default_namespaces :: proc() {
}
    // rust: let parse = |text| horizon_world::nbt::parse_snbt(text).unwrap().0;
    // rust: let source = parse(
    // rust: r#"{"minecraft:map_decorations":{a:{type:"minecraft:mansion",x:10.5d,z:-20.0d,rotation:90.0f},"a+b":{type:"red_x",x:-1.25d,z:2.75d,rotation:-45.5f}},"minecraft:custom_data":{keep:7}}"#,
    // rust: );
    // rust: let expected = parse(
    // rust: r#"{"minecraft:map_decorations":{a:{type:"minecraft:mansion",x:10.5d,z:-20.0d,rotation:90.0f},"a+b":{type:"minecraft:red_x",x:-1.25d,z:2.75d,rotation:-45.5f}},"minecraft:custom_data":{keep:7}}"#,
    // rust: );
    // rust: assert!(decode_components(None).1.is_none());
    // rust: for input in [&source, &expected] {
    // rust: let (damage, extra) = decode_components(Some(input));
    // rust: assert_eq!(
    // rust: extra.as_ref().unwrap().other("minecraft:map_decorations"),
    // rust: expected.get("minecraft:map_decorations")
    // rust: );
    // rust: let loaded = ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..ItemStack::new("minecraft:filled_map", 1)
}
    // rust: assert_eq!(encode_components(&loaded), Some(expected.clone()));
            // A fresh model has no original NBT or retained component source.
    // rust: let mut fresh = ItemStack::new("minecraft:filled_map", 1);
    // rust: assert!(fresh.extra.is_none());
    // rust: for id in ["minecraft:map_decorations", "minecraft:custom_data"] {
    // rust: fresh.data_mut().set_other(id, input.get(id).cloned());
}
    // rust: assert_eq!(encode_components(&fresh), Some(expected.clone()));
    // rust: assert!(fresh.data().unwrap().map_id.is_none());
}
}

empty_map_decoration_patch_uses_filled_map_prototype :: proc() {
}
    // rust: let parse = |text| horizon_world::nbt::parse_snbt(text).unwrap().0;
    // rust: let empty = parse(r#"{"minecraft:map_decorations":{}}"#);
    // rust: assert!(decode_components(None).1.is_none());
    // rust: assert!(encode_components(&ItemStack::new("minecraft:filled_map", 1)).is_none());
    // rust: let mut fresh = ItemStack::new("minecraft:filled_map", 1);
    // rust: fresh
    // rust: .data_mut()
    // rust: .other
    // rust: .push(("minecraft:map_decorations".into(), parse("{}")));
        // The value codec has no item prototype; only the saved patch elides it.
    // rust: assert_eq!(components_tag(0, fresh.data()), Some(empty.clone()));
    // rust: assert!(encode_components(&fresh).is_none());
    // rust: let (damage, extra) = decode_components(Some(&empty));
    // rust: let loaded = ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..ItemStack::new("minecraft:filled_map", 1)
}
    // rust: let saved = crate::item_nbt::item_to_nbt(&loaded);
    // rust: assert_eq!(saved, parse(r#"{id:"minecraft:filled_map",count:1}"#));
    // rust: let back = crate::item_nbt::item_from_nbt(&saved).unwrap();
    // rust: assert!(encode_components(&back).is_none());
    // rust: let keep = parse(r#"{"minecraft:map_decorations":{},"minecraft:custom_data":{keep:7}}"#);
    // rust: let (damage, extra) = decode_components(Some(&keep));
    // rust: let stack = ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..ItemStack::new("minecraft:filled_map", 1)
}
    // rust: assert_eq!(
    // rust: encode_components(&stack),
    // rust: Some(parse(r#"{"minecraft:custom_data":{keep:7}}"#))
    // rust: );
}

nondefault_map_decoration_patches_round_trip :: proc() {
}
    // rust: let parse = |text| horizon_world::nbt::parse_snbt(text).unwrap().0;
    // rust: let nonempty = parse(
    // rust: r#"{"minecraft:map_decorations":{"a+b":{type:"minecraft:red_x",x:-1.25d,z:2.75d,rotation:-45.5f}},"minecraft:custom_data":{keep:7}}"#,
    // rust: );
    // rust: let removed =
    // rust: parse(r#"{"!minecraft:map_decorations":{},"minecraft:custom_data":{keep:7}}"#);
    // rust: let empty = parse(r#"{"minecraft:map_decorations":{}}"#);
    // rust: for (item, components) in [
    // rust: ("minecraft:filled_map", &nonempty),
    // rust: ("minecraft:stone", &nonempty),
    // rust: ("minecraft:filled_map", &removed),
    // rust: ("minecraft:stone", &empty),
    // rust: ("minecraft:map", &empty),
    // rust: ] {
    // rust: let (damage, extra) = decode_components(Some(components));
    // rust: let stack = ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..ItemStack::new(item, 1)
}
    // rust: assert_eq!(
    // rust: encode_components(&stack),
    // rust: Some(components.clone()),
    // rust: "{item}"
    // rust: );
    // rust: let back =
    // rust: crate::item_nbt::item_from_nbt(&crate::item_nbt::item_to_nbt(&stack)).unwrap();
    // rust: assert_eq!(encode_components(&back), Some(components.clone()), "{item}");
}
}

components_round_trip :: proc() {
}
    // rust: let mut stack = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: stack.damage = 12;
    // rust: stack.enchant("minecraft:sharpness", 3);
    // rust: stack.enchant("minecraft:unbreaking", 2);
    // rust: stack.data_mut().repair_cost = 3;
    // rust: stack.data_mut().custom_name = Some(Tag::String("Blade".into()));
    // rust: let tag = encode_components(&stack).expect("components");
    // rust: let (damage, extra) = decode_components(Some(&tag));
    // rust: assert_eq!(damage, 12);
    // rust: let back = ItemStack {
    // rust: damage,
    // rust: extra,
    // rust: ..ItemStack::new("minecraft:diamond_sword", 1)
}
    // rust: assert_eq!(back.enchantment_level("minecraft:sharpness"), 3);
    // rust: assert_eq!(back.enchantment_level("minecraft:unbreaking"), 2);
    // rust: assert_eq!(back.repair_cost(), 3);
    // rust: assert_eq!(back.custom_name().as_deref(), Some("Blade"));
}

enchantment_ids_without_a_namespace_are_minecraft_ones :: proc() {
}
    // rust: let levels = Tag::compound([
    // rust: ("knockback", Tag::Int(2)),
    // rust: ("minecraft:sharpness", Tag::Int(1)),
    // rust: ]);
    // rust: let components = Tag::compound([("minecraft:enchantments", levels)]);
    // rust: let (_, extra) = decode_components(Some(&components));
    // rust: let stack = ItemStack {
    // rust: extra,
    // rust: ..ItemStack::new("minecraft:wooden_sword", 1)
}
    // rust: assert_eq!(stack.enchantment_level("minecraft:knockback"), 2);
    // rust: assert_eq!(stack.enchantment_level("minecraft:sharpness"), 1);
}

invalid_enchantment_levels_leave_the_other_entries_intact :: proc() {
}
    // rust: for component in ["minecraft:enchantments", "minecraft:stored_enchantments"] {
    // rust: for level in [-1, 0, 256, i32::MAX] {
    // rust: let components = Tag::compound([
    // rust: ("minecraft:damage", Tag::Int(12)),
    // rust: (
    // rust: component,
    // rust: Tag::compound([("looting", Tag::Int(level)), ("sharpness", Tag::Int(3))]),
    // rust: ),
    // rust: ]);
    // rust: let (damage, extra) = decode_components(Some(&components));
    // rust: let data = extra.unwrap();
    // rust: let levels = if component == "minecraft:enchantments" {
    // rust: data.enchantments
    // rust: } else {
    // rust: data.stored_enchantments
}
    // rust: assert_eq!(damage, 12);
    // rust: assert_eq!(levels, vec![(Arc::from("minecraft:sharpness"), 3)]);
}
}
}

custom_name_reads_the_extra_spans :: proc() {
}
    // rust: let name = Tag::compound([
    // rust: (
    // rust: "extra",
    // rust: Tag::List(vec![
    // rust: Tag::compound([("text", Tag::String("Games ".into()))]),
    // rust: Tag::compound([("text", Tag::String("Right click".into()))]),
    // rust: ]),
    // rust: ),
    // rust: ("text", Tag::String("".into())),
    // rust: ]);
    // rust: let components = Tag::compound([("minecraft:custom_name", name)]);
    // rust: let (_, extra) = decode_components(Some(&components));
    // rust: assert_eq!(
    // rust: extra.and_then(|d| d.custom_name_plain()).as_deref(),
    // rust: Some("Games Right click")
    // rust: );
}

plain_custom_name_is_saved_as_a_string :: proc() {
}
        // Component.tryCollapseToString: `{text:"Cool"}` is written "Cool";
        // a style or a sibling keeps the compound.
    // rust: let decode = |name: Tag| {
    // rust: let components = Tag::compound([("minecraft:custom_name", name)]);
    // rust: decode_components(Some(&components)).1.unwrap().custom_name
}
    // rust: let plain = Tag::compound([("text", Tag::String("Cool".into()))]);
    // rust: assert_eq!(decode(plain), Some(Tag::String("Cool".into())));
    // rust: let styled = Tag::compound([
    // rust: ("text", Tag::String("Cool".into())),
    // rust: ("color", Tag::String("red".into())),
    // rust: ]);
    // rust: assert_eq!(decode(styled.clone()), Some(styled));
    // rust: let mut data = StackData::default();
    // rust: data.set_other(
    // rust: "minecraft:custom_name",
    // rust: Some(Tag::compound([("text", Tag::String("Loot".into()))])),
    // rust: );
    // rust: assert_eq!(data.custom_name, Some(Tag::String("Loot".into())));
}

rich_custom_name_is_the_single_saved_value_after_rename :: proc() {
}
    // rust: let name = Tag::compound([
    // rust: ("text", Tag::String("".into())),
    // rust: (
    // rust: "extra",
    // rust: Tag::List(vec![
    // rust: Tag::compound([
    // rust: ("text", Tag::String("A".into())),
    // rust: ("color", Tag::String("#ff0000".into())),
    // rust: ]),
    // rust: Tag::compound([
    // rust: ("text", Tag::String("B".into())),
    // rust: ("color", Tag::String("#0000ff".into())),
    // rust: ]),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: let components = Tag::compound([("minecraft:custom_name", name.clone())]);
    // rust: let (_, extra) = decode_components(Some(&components));
    // rust: let mut stack = ItemStack {
    // rust: extra,
    // rust: ..ItemStack::new("minecraft:stick", 1)
}
    // rust: assert_eq!(stack.custom_name().as_deref(), Some("AB"));
    // rust: assert_eq!(encode_components(&stack), Some(components));
    // rust: stack
    // rust: .data_mut()
    // rust: .set_other("minecraft:custom_name", Some(Tag::String("Changed".into())));
    // rust: assert_eq!(stack.custom_name().as_deref(), Some("Changed"));
    // rust: assert_eq!(
    // rust: encode_components(&stack)
    // rust: .unwrap()
    // rust: .get("minecraft:custom_name"),
    // rust: Some(&Tag::String("Changed".into()))
    // rust: );
}

loot_name_preserves_plain_and_styled_components :: proc() {
}
    // rust: let mut stack = ItemStack::new("minecraft:stone", 1);
    // rust: stack
    // rust: .data_mut()
    // rust: .set_loot_name("minecraft:custom_name", &serde_json::json!("Rock"));
    // rust: assert_eq!(
    // rust: encode_components(&stack)
    // rust: .unwrap()
    // rust: .get("minecraft:custom_name"),
    // rust: Some(&Tag::String("Rock".into()))
    // rust: );
    // rust: let styled = serde_json::json!({"text": "Rock", "color": "red"});
    // rust: stack
    // rust: .data_mut()
    // rust: .set_loot_name("minecraft:custom_name", &styled);
    // rust: assert_eq!(
    // rust: encode_components(&stack)
    // rust: .unwrap()
    // rust: .get("minecraft:custom_name"),
    // rust: Some(&horizon_client_core::scoreboard::json_to_tag(&styled))
    // rust: );
}

loot_component_keeps_a_styled_custom_name :: proc() {
}
    // rust: let name = serde_json::json!({"text":"Prize","color":"#ff8800"});
    // rust: let mut stack = ItemStack::new("minecraft:stick", 1);
    // rust: stack
    // rust: .data_mut()
    // rust: .set_loot_component("minecraft:custom_name", &name);
    // rust: assert_eq!(stack.custom_name().as_deref(), Some("Prize"));
    // rust: let expected = horizon_client_core::scoreboard::json_to_tag(&name);
    // rust: assert_eq!(
    // rust: encode_components(&stack)
    // rust: .unwrap()
    // rust: .get("minecraft:custom_name"),
    // rust: Some(&expected)
    // rust: );
    // rust: stack
    // rust: .data_mut()
    // rust: .set_loot_component("minecraft:custom_name", &serde_json::Value::Null);
    // rust: assert!(stack.custom_name().is_none());
}

written_book_pages_may_be_component_lists :: proc() {
}
        // A page as Hypixel sends it through ViaVersion: a list, not a compound.
    // rust: let page = Tag::List(vec![
    // rust: Tag::compound([("text", Tag::String("".into()))]),
    // rust: Tag::compound([("text", Tag::String("Please read ".into()))]),
    // rust: Tag::compound([("text", Tag::String("the rules".into()))]),
    // rust: ]);
    // rust: let book = Tag::compound([
    // rust: (
    // rust: "title",
    // rust: Tag::compound([("raw", Tag::String("Rules".into()))]),
    // rust: ),
    // rust: ("author", Tag::String("Server".into())),
    // rust: (
    // rust: "pages",
    // rust: Tag::List(vec![
    // rust: page,
    // rust: Tag::compound([("raw", Tag::String("Two".into()))]),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: let components = Tag::compound([("minecraft:written_book_content", book)]);
    // rust: let (_, extra) = decode_components(Some(&components));
    // rust: let pages = extra.and_then(|d| d.written.clone()).map(|w| w.pages);
    // rust: assert_eq!(
    // rust: pages,
    // rust: Some(vec!["Please read the rules".to_owned(), "Two".to_owned()])
    // rust: );
}

banner_layers_and_shield_base_round_trip :: proc() {
}
    // rust: let mut stack = ItemStack::new("minecraft:shield", 1);
    // rust: stack.data_mut().base_color = Some(Arc::from("red"));
    // rust: stack.data_mut().banner_patterns = vec![
    // rust: crate::banner_layer::BannerLayer::new("minecraft:flower", "black"),
    // rust: crate::banner_layer::BannerLayer::new("minecraft:border", "white"),
    // rust: ];
    // rust: let tag = encode_components(&stack).expect("components");
    // rust: let (_, extra) = decode_components(Some(&tag));
    // rust: let extra = extra.expect("data");
    // rust: assert_eq!(extra.base_color.as_deref(), Some("red"));
    // rust: assert_eq!(extra.banner_patterns, stack.data().unwrap().banner_patterns);
}

ominous_items_round_trip :: proc() {
}
    // rust: let mut banner = ItemStack::new("minecraft:white_banner", 1);
    // rust: banner.data_mut().ominous_banner = true;
    // rust: let tag = encode_components(&banner).unwrap();
    // rust: assert!(tag.get("minecraft:banner_patterns").is_some());
    // rust: let (_, back) = decode_components(Some(&tag));
    // rust: let back = back.unwrap();
    // rust: assert!(back.ominous_banner);
    // rust: assert!(back.other("minecraft:tooltip_display").is_none());

    // rust: banner.data_mut().set_other(
    // rust: "minecraft:tooltip_display",
    // rust: Some(Tag::Compound(Default::default())),
    // rust: );
    // rust: let (_, custom_display) = decode_components(encode_components(&banner).as_ref());
    // rust: assert_eq!(
    // rust: custom_display.unwrap().other("minecraft:tooltip_display"),
    // rust: Some(&Tag::Compound(Default::default()))
    // rust: );
    // rust: let mut bottle = ItemStack::new("minecraft:ominous_bottle", 1);
    // rust: bottle.data_mut().ominous_amplifier = Some(3);
    // rust: let (_, back) = decode_components(encode_components(&bottle).as_ref());
    // rust: assert_eq!(back.unwrap().ominous_amplifier, Some(3));
}
plain_stacks_have_no_components :: proc() {
}
    // rust: let stack = ItemStack::new("minecraft:stone", 64);
    // rust: assert!(encode_components(&stack).is_none());
    // rust: let mut named = stack.clone();
    // rust: named.data_mut();
    // rust: named.tidy();
    // rust: assert_eq!(named, stack);
}

books_store_enchantments :: proc() {
}
    // rust: let mut book = ItemStack::new("minecraft:enchanted_book", 1);
    // rust: book.enchant("minecraft:mending", 1);
    // rust: assert!(book.enchantments().is_empty());
    // rust: assert_eq!(book.stored_enchantments().len(), 1);
    // rust: upgrade(
    // rust: &mut book.data_mut().stored_enchantments,
    // rust: "minecraft:mending",
    // rust: 1,
    // rust: );
    // rust: assert_eq!(book.crafting_enchantments()[0].1, 1);
    // rust: let book = ItemStack::new("minecraft:book", 1).transmute("minecraft:enchanted_book", 1);
    // rust: assert!(book.extra.is_none());
}
command_components_decode_fireworks :: proc() {
}
    // rust: let tag = command_components(
    // rust: "[fireworks={flight_duration:2,explosions:[{shape:large_ball,colors:[I;16711680],has_twinkle:true}]},damage=3]",
    // rust: )
    // rust: .unwrap();
    // rust: let (damage, data) = decode_components(Some(&tag));
    // rust: assert_eq!(damage, 3);
    // rust: let (flight, explosions) = data.unwrap().fireworks.unwrap();
    // rust: assert_eq!(flight, 2);
    // rust: assert_eq!(
    // rust: explosions[0].shape,
    // rust: crate::firework::FireworkShape::LargeBall
    // rust: );
    // rust: assert_eq!(explosions[0].colors, vec![0xFF0000]);
    // rust: assert!(explosions[0].twinkle && !explosions[0].trail);
}

debug_stick_state_round_trips :: proc() {
}
    // rust: let mut stack = ItemStack::new("minecraft:debug_stick", 1);
    // rust: stack
    // rust: .data_mut()
    // rust: .set_debug_stick_property("minecraft:oak_stairs", "facing");
    // rust: stack
    // rust: .data_mut()
    // rust: .set_debug_stick_property("minecraft:oak_stairs", "half");
    // rust: stack
    // rust: .data_mut()
    // rust: .set_debug_stick_property("minecraft:stone", "axis");

    // rust: let tag = encode_components(&stack).expect("debug stick components");
    // rust: let (_, extra) = decode_components(Some(&tag));
    // rust: let data = extra.expect("debug stick state");
    // rust: assert_eq!(
    // rust: data.debug_stick_property("minecraft:oak_stairs").as_deref(),
    // rust: Some("half")
    // rust: );
    // rust: assert_eq!(
    // rust: data.debug_stick_property("minecraft:stone").as_deref(),
    // rust: Some("axis")
    // rust: );
    // rust: assert_eq!(data.debug_stick_property("minecraft:dirt"), None);
}
}

    // rust: mod charged_projectile_template_tests {
//     use super::*;

charged_templates_omit_default_count_and_keep_components :: proc() {
}
    // rust: for count in [1, 2] {
    // rust: let mut projectile = ItemStack::new("minecraft:arrow", count);
    // rust: let marker = Tag::compound([("audit", Tag::Int(7))]);
    // rust: projectile
    // rust: .data_mut()
    // rust: .other
    // rust: .push(("minecraft:custom_data".into(), marker.clone()));
    // rust: let mut outer = ItemStack::new("minecraft:crossbow", 1);
    // rust: outer.data_mut().charged.push(projectile.clone());
    // rust: outer.data_mut().other.push((
    // rust: "minecraft:custom_data".into(),
    // rust: Tag::compound([("audit", Tag::Int(9))]),
    // rust: ));
    // rust: let encoded = encode_components(&outer).unwrap();
    // rust: let Tag::List(list) = encoded.get("minecraft:charged_projectiles").unwrap() else {
    // rust: panic!("projectile list")
}
    // rust: assert_eq!(list.len(), 1);
    // rust: assert_eq!(
    // rust: list[0].get("count"),
    // rust: (count != 1).then_some(Tag::Int(count as i32)).as_ref()
    // rust: );
    // rust: assert_eq!(
    // rust: list[0]
    // rust: .get("components")
    // rust: .unwrap()
    // rust: .get("minecraft:custom_data"),
    // rust: Some(&marker)
    // rust: );
    // rust: assert_eq!(
    // rust: encoded.get("minecraft:custom_data"),
    // rust: Some(&Tag::compound([("audit", Tag::Int(9))]))
    // rust: );
            // Generic ItemStack/inventory encoding retains its required count.
    // rust: assert_eq!(
    // rust: crate::item_nbt::item_to_nbt(&projectile).get("count"),
    // rust: Some(&Tag::Int(count as i32))
    // rust: );
    // rust: let (_, decoded) = decode_components(Some(&encoded));
    // rust: let restored = decoded.unwrap();
    // rust: assert_eq!(restored.charged[0].count, count);
    // rust: assert_eq!(
    // rust: restored.charged[0]
    // rust: .data()
    // rust: .unwrap()
    // rust: .other("minecraft:custom_data"),
    // rust: Some(&marker)
    // rust: );
}
}
}
