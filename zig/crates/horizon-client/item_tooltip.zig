//! Transpiled from Horizon Rust crate
//! Module: horizon-client_item_tooltip
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Item tooltip formatting: equipment modifiers with a player's base values,
//! and lines without player context for the recipe book's search tree.
// use crate::text::{GRAY, Text};
// use crate::{
    // rust: bundle::TooltipLayout,
    // rust: hud::rgba,
    // rust: items::{ItemInfo, ItemStack, Items},
}
// use horizon_world::nbt::Tag;

/// The `minecraft:tooltip_display` component applied by `ItemStack` while it
/// builds a hover tooltip.
pub const TooltipDisplay = struct {
    component: ?*'a Tag,
    ominous_banner: bool,
};

    // rust: impl<'a> TooltipDisplay<'a> {
pub fn for_stack(stack: *'a ItemStack) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: component: stack
    // rust: .data()
    // rust: .and_then(|data| data.other("minecraft:tooltip_display")),
    // rust: ominous_banner: stack.data().is_some_and(|data| data.ominous_banner),
}
}

pub fn hides_tooltip(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self.component.and_then(|display| display.get("hide_tooltip")),
    // rust: Some(Tag::Byte(value)) if *value != 0
    // rust: )
}

    /// `ItemStack.getTooltipLines`: `hide_tooltip` suppresses the name unless
    /// the tooltip flag is creative.
pub fn name_visible(self: *Self, creative: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: creative || !self.hides_tooltip()
}

    /// `TooltipDisplay.shows`: whether details for a data component are shown.
pub fn shows(self: *Self, component: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.hides_tooltip() {
    // rust: return false;
}
        // `item_data::decode_components` models the raid captain banner's
        // default hidden pattern tooltip as `ominous_banner` instead of
        // retaining its redundant `tooltip_display` component.
    // rust: if self.ominous_banner
    // rust: && self.component.is_none()
    // rust: && component == "minecraft:banner_patterns"
    // rust: {
    // rust: return false;
}
    // rust: let Some(Tag::List(hidden)) = self
    // rust: .component
    // rust: .and_then(|display| display.get("hidden_components"))
    // rust: else {
    // rust: return true;
}
    // rust: !hidden.iter().any(|tag| {
    // rust: matches!(tag, Tag::String(id) if id.0.iter().copied().eq(component.encode_utf16()))
    // rust: })
}
}

/// `EquipmentSlotGroup` in declaration order, the order tooltips list them in.
    // rust: const SLOT_GROUPS: [&str; 11] = [
    // rust: "any", "mainhand", "offhand", "hand", "feet", "legs", "chest", "head", "armor", "body",
    // rust: "saddle",
    // rust: ];

/// `ItemAttributeModifiers.ATTRIBUTE_MODIFIER_FORMAT`, `DecimalFormat("#.##")`
/// of a positive amount (half-even on the exact value).
pub fn format_amount(value: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = format!("{:.2}", value);
    // rust: text.trim_end_matches('0').trim_end_matches('.').to_owned()
}

/// `ItemAttributeModifiers.Display.Default.apply`: a modifier's line, none
/// for a zero amount. `percent` is the modifier's operation id (0: added
/// value, 1 and 2: multiplied).
    // rust: fn modifier_line(
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: attribute: &str,
    // rust: amount: f64,
    // rust: operation: usize,
    // rust: total: bool,
    // rust: ) -> Option<String> {
    // rust: let text = |key: &str| translate(key).unwrap_or_else(|| key.to_owned());
    // rust: let scale = match operation {
    // rust: 0 if attribute == "knockback_resistance" => 10.0,
    // rust: 0 => 1.0,
    // rust: _ => 100.0,
}
    // rust: let (kind, shown) = if total {
    // rust: ("equals", amount * scale)
    // rust: } else if amount > 0.0 {
    // rust: ("plus", amount * scale)
    // rust: } else if amount < 0.0 {
    // rust: ("take", -amount * scale)
    // rust: } else {
    // rust: return None;
}
    // TranslatableContents: `%s` and numbered `%1$s` arguments, `%%` a percent sign.
    // rust: Some(
    // rust: crate::text::format_translation(
    // rust: &text(&format!("attribute.modifier.{kind}.{operation}")),
    // rust: &[
    // rust: crate::text::Text::literal(format_amount(shown)),
    // rust: crate::text::Text::literal(text(&format!("attribute.name.{attribute}"))),
    // rust: ],
    // rust: )
    // rust: .plain(),
    // rust: )
}

/// `Attribute.getStyle`: the colour of a line for an attribute whose value
/// rises or falls. Gravity, scale and the waypoint ranges are neutral, burning
/// time and fall damage are negative, every other attribute is positive.
pub fn attribute_color(attribute: []const u8, rises: bool) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (blue, red) = (rgba(85, 85, 255, 255), rgba(255, 85, 85, 255));
    // rust: match attribute {
    // rust: "burning_time" | "fall_damage_multiplier" => {
    // rust: if rises {
    // rust: red
    // rust: } else {
    // rust: blue
}
}
    // rust: "gravity" | "scale" | "waypoint_transmit_range" | "waypoint_receive_range" => {
    // rust: rgba(170, 170, 170, 255)
}
    // rust: _ => {
    // rust: if rises {
    // rust: blue
    // rust: } else {
    // rust: red
}
}
}
}

/// `ItemStack.addAttributeTooltips`: slot groups, colors and optional player
/// attack damage/speed bases. Recipe search has no player context.
    // rust: pub fn attribute_lines(
    // rust: modifiers: &[(String, String, f64, String, String)],
    // rust: player_base: Option<[f64; 2]>,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<(String, u32)> {
    // rust: let mut lines = Vec::new();
    // rust: for group in SLOT_GROUPS {
    // rust: let mut first = true;
    // rust: for (attribute, modifier, amount, operation, slot) in modifiers {
    // rust: if slot != group {
    // rust: continue;
}
    // rust: if std::mem::take(&mut first) {
    // rust: lines.push((String::new(), u32::MAX));
    // rust: lines.push((
    // rust: translate(&format!("item.modifiers.{group}"))
    // rust: .unwrap_or_else(|| format!("item.modifiers.{group}")),
    // rust: rgba(170, 170, 170, 255),
    // rust: ));
}
    // rust: let id = match operation.as_str() {
    // rust: "add_multiplied_base" => 1,
    // rust: "add_multiplied_total" => 2,
    // rust: _ => 0,
}
    // rust: let path = attribute.strip_prefix("minecraft:").unwrap_or(attribute);
    // rust: let base = player_base.and_then(|[damage, speed]| match modifier.as_str() {
    // rust: "minecraft:base_attack_damage" => Some(damage),
    // rust: "minecraft:base_attack_speed" => Some(speed),
    // rust: _ => None,
    // rust: });
    // rust: if let Some(line) = modifier_line(
    // rust: translate,
    // rust: path,
    // rust: amount + base.unwrap_or(0.0),
    // rust: id,
    // rust: base.is_some(),
    // rust: ) {
    // rust: let (line, color) = if base.is_some() {
    // rust: (format!(" {line}"), rgba(0, 170, 0, 255))
    // rust: } else {
    // rust: (line, attribute_color(path, *amount > 0.0))
}
    // rust: lines.push((line, color));
}
}
}
    // rust: lines
}

/// The attribute modifiers a mob effect adds per amplifier level
/// (`MobEffects`): attribute, amount, operation id.
pub fn effect_modifier(effect: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match effect {
    // rust: "speed" => ("movement_speed", 0.2, 2),
    // rust: "slowness" => ("movement_speed", -0.15, 2),
    // rust: "strength" => ("attack_damage", 3.0, 0),
    // rust: "weakness" => ("attack_damage", -4.0, 0),
    // rust: "jump_boost" => ("safe_fall_distance", 1.0, 0),
    // rust: "luck" => ("luck", 1.0, 0),
    // rust: "invisibility" => ("waypoint_transmit_range", -1.0, 2),
    // rust: _ => return None,
    // rust: })
}

pub fn is_potion_item(item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: item.ends_with("potion") || item == "minecraft:tipped_arrow"
}

/// `PlayerHeadItem.getName`: a player head whose profile has a name is titled
/// after it.
pub const PlayerHeadName = struct {};

    // rust: impl PlayerHeadName {
    /// The title as `getName`'s `%s's Head` translation.
pub fn title(self: *Self, translate: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: translate("block.minecraft.player_head.named")
    // rust: .unwrap_or_else(|| "%s's Head".to_owned())
    // rust: .replacen("%s", &self.0, 1)
}
    /// The title as a component, for command feedback.
pub fn text(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::text::Text::translate(
    // rust: "block.minecraft.player_head.named",
    // rust: &[crate::text::Text::literal(self.0.clone())],
    // rust: )
}
}

/// The name in a player head's `minecraft:profile`, if it has one.
pub fn player_head_name(stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if &*stack.item != "minecraft:player_head" {
    // rust: return None;
}
    // rust: Some(PlayerHeadName(stack.profile_name()?))
}

/// The name line of `stack`, as the item's translation or, for potions and
/// smithing templates, its name component gives it.
pub fn name_line(stack: *ItemStack, translate: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = stack
    // rust: .item
    // rust: .split_once(':')
    // rust: .unwrap_or(("minecraft", &stack.item));
    // rust: if let Some(name) = stack.custom_name() {
    // rust: return name.to_owned();
}
    // rust: if let Some(name) = stack.item_name() {
    // rust: return name;
}
    // rust: if stack.data().is_some_and(|d| d.ominous_banner) {
    // rust: return translate("block.minecraft.ominous_banner")
    // rust: .unwrap_or_else(|| "Ominous Banner".to_owned());
}
    // rust: if let Some(head) = player_head_name(stack) {
    // rust: return head.title(translate);
}
    // rust: let key = if is_potion_item(&stack.item) {
    // rust: Some(crate::brewing::potion_name_key(&stack.item, stack.potion()))
    // rust: } else if let Some(pattern) = path.strip_suffix("_armor_trim_smithing_template") {
    // rust: Some(format!("trim_pattern.minecraft.{pattern}"))
    // rust: } else if path == "netherite_upgrade_smithing_template" {
    // rust: Some("upgrade.minecraft.netherite_upgrade".to_owned())
    // rust: } else if path.ends_with("_banner_pattern") {
        // The item name component of the pattern items that have one.
    // rust: Some(format!("item.minecraft.{path}.new"))
    // rust: } else if &*stack.item == "minecraft:shield"
    // rust: && let Some(color) = stack.data().and_then(|d| d.base_color.as_deref())
    // rust: {
        // `ShieldItem.getName`: the banner's base colour names the shield.
    // rust: Some(format!("item.minecraft.shield.{color}"))
    // rust: } else {
    // rust: None
}
    // `Item.getDescriptionId`: `Util.makeDescriptionId("item", id)`, or the
    // block's for a block item, in the item's own namespace.
    // rust: let id = format!("{namespace}.{}", path.replace('/', "."));
    // rust: key.and_then(|k| translate(&k))
    // rust: .or_else(|| translate(&format!("item.{id}")))
    // rust: .or_else(|| translate(&format!("block.{id}")))
    // rust: .unwrap_or_else(|| path.replace('_', " "))
}

/// ItemStack.getRarity: the stack's `minecraft:rarity` (the item's default
/// unless a command or server set it; the ominous banner's uncommon), then
/// the enchantment upgrade.
    // rust: pub fn rarity<'a>(stack: &ItemStack, default: &'a str) -> &'a str {
    // rust: let set = match stack.data().and_then(|d| d.other("minecraft:rarity")) {
    // rust: Some(Tag::String(s)) => match &*s.to_string_lossy() {
    // rust: "common" => Some("common"),
    // rust: "uncommon" => Some("uncommon"),
    // rust: "rare" => Some("rare"),
    // rust: "epic" => Some("epic"),
    // rust: _ => None,
    // rust: },
    // rust: _ => None,
}
    // rust: let rarity = if stack.data().is_some_and(|d| d.ominous_banner) {
    // rust: "uncommon"
    // rust: } else {
    // rust: set.unwrap_or(default)
}
    // rust: if stack.enchantments().is_empty() {
    // rust: rarity
    // rust: } else {
    // rust: match rarity {
    // rust: "common" | "uncommon" => "rare",
    // rust: "rare" => "epic",
    // rust: r => r,
}
}
}

/// `BundleItem.getTooltipImage`: the contents grid of a bundle, or None when
/// the stack is not one or `minecraft:tooltip_display` hides
/// `minecraft:bundle_contents` - the image is that component's tooltip
/// detail, so a display that hides the component hides the grid too.
    // rust: pub fn bundle_tooltip(
    // rust: items: &Items,
    // rust: stack: &ItemStack,
    // rust: x: f32,
    // rust: y: f32,
    // rust: box_width: f32,
    // rust: ) -> Option<TooltipLayout> {
    // rust: TooltipDisplay::for_stack(stack)
    // rust: .shows("minecraft:bundle_contents")
    // rust: .then(|| crate::bundle::tooltip_layout(items, stack, x, y, box_width))
    // rust: .flatten()
}

pub fn is_beehive(path: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(path, "beehive" | "bee_nest")
}

/// `InstrumentComponent.addToTooltip`: the instrument's description. A goat
/// horn without the component has the item's default, the ponder horn.
    // rust: pub fn instrument_line(
    // rust: stack: &ItemStack,
    // rust: display: &TooltipDisplay,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Option<String> {
    // rust: if !display.shows("minecraft:instrument") {
    // rust: return None;
}
    // rust: let id = match stack.data().and_then(|d| d.other("minecraft:instrument")) {
    // rust: Some(Tag::String(id)) => id.to_string_lossy(),
        // An inline instrument carries its own description.
    // rust: Some(inline) => {
    // rust: return inline
    // rust: .get("description")
    // rust: .map(|d| crate::entity_nbt::name_text(d).plain());
}
    // rust: None if &*stack.item == "minecraft:goat_horn" => "minecraft:ponder_goat_horn".to_owned(),
    // rust: None => return None,
}
    // rust: let key = format!("instrument.{}", id.replacen(':', ".", 1));
    // rust: Some(translate(&key).unwrap_or(key))
}

/// `TropicalFish.COMMON_VARIANTS`: pattern, base colour and pattern colour of
/// the 22 named fish (`entity.minecraft.tropical_fish.predefined.<index>`).
    // rust: const COMMON_TROPICAL_FISH: [(&str, &str, &str); 22] = [
    // rust: ("stripey", "orange", "gray"),
    // rust: ("flopper", "gray", "gray"),
    // rust: ("flopper", "gray", "blue"),
    // rust: ("clayfish", "white", "gray"),
    // rust: ("sunstreak", "blue", "gray"),
    // rust: ("kob", "orange", "white"),
    // rust: ("spotty", "pink", "light_blue"),
    // rust: ("blockfish", "purple", "yellow"),
    // rust: ("clayfish", "white", "red"),
    // rust: ("spotty", "white", "yellow"),
    // rust: ("glitter", "white", "gray"),
    // rust: ("clayfish", "white", "orange"),
    // rust: ("dasher", "cyan", "pink"),
    // rust: ("brinely", "lime", "light_blue"),
    // rust: ("betty", "red", "white"),
    // rust: ("snooper", "gray", "red"),
    // rust: ("blockfish", "red", "white"),
    // rust: ("flopper", "white", "yellow"),
    // rust: ("kob", "red", "white"),
    // rust: ("sunstreak", "gray", "white"),
    // rust: ("dasher", "cyan", "yellow"),
    // rust: ("flopper", "yellow", "yellow"),
    // rust: ];

/// `TropicalFish.Pattern.addToTooltip`: a bucket of tropical fish names a
/// common variant, or else shows the pattern and then the base colour (with
/// the pattern colour when it differs), all in italic gray. Only a stack that
/// has the pattern component shows it.
pub fn tropical_fish_lines(stack: *ItemStack, display: *TooltipDisplay) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !display.shows("minecraft:tropical_fish/pattern") {
    // rust: return Vec::new();
}
    // rust: let Some(data) = stack.data() else {
    // rust: return Vec::new();
}
    // rust: let name = |key: &str, default: &'static str| match data.other(key) {
    // rust: Some(Tag::String(s)) => s
    // rust: .to_string_lossy()
    // rust: .trim_start_matches("minecraft:")
    // rust: .to_owned(),
    // rust: _ => default.to_owned(),
}
    // rust: let Some(Tag::String(pattern)) = data.other("minecraft:tropical_fish/pattern") else {
    // rust: return Vec::new();
}
    // rust: let pattern = pattern
    // rust: .to_string_lossy()
    // rust: .trim_start_matches("minecraft:")
    // rust: .to_owned();
    // rust: let base = name("minecraft:tropical_fish/base_color", "white");
    // rust: let color = name("minecraft:tropical_fish/pattern_color", "white");
    // rust: let styled = |t: Text| t.italic().with_color(GRAY);
    // rust: let common = COMMON_TROPICAL_FISH
    // rust: .iter()
    // rust: .position(|(p, b, c)| *p == pattern && *b == base && *c == color);
    // rust: if let Some(index) = common {
    // rust: let key = format!("entity.minecraft.tropical_fish.predefined.{index}");
    // rust: return vec![styled(Text::translate(&key, &[]))];
}
    // rust: let mut colors = Text::translate(&format!("color.minecraft.{base}"), &[]);
    // rust: if base != color {
    // rust: colors = colors
    // rust: .append(", ")
    // rust: .append(Text::translate(&format!("color.minecraft.{color}"), &[]));
}
    // rust: vec![
    // rust: styled(Text::translate(
    // rust: &format!("entity.minecraft.tropical_fish.type.{pattern}"),
    // rust: &[],
    // rust: )),
    // rust: styled(colors),
    // rust: ]
}

/// `MapId.addToTooltip`: a map whose data is not known (`map` is `None`, else
/// its `locked` flag and `scale`) reads "Unknown Map"; a known one gives its
/// id (unless it has a custom name or is to be locked or scaled), "Locked"
/// when it is or is being locked, and with advanced tooltips its scale (a
/// copy being scaled one up, at most 4) and level.
    // rust: pub fn map_id_lines(
    // rust: stack: &ItemStack,
    // rust: display: &TooltipDisplay,
    // rust: advanced: bool,
    // rust: map: Option<(bool, u8)>,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<String> {
    // rust: let Some(id) = stack.data().and_then(|d| d.map_id) else {
    // rust: return Vec::new();
}
    // rust: if !display.shows("minecraft:map_id") {
    // rust: return Vec::new();
}
    // rust: let text = |key: &str, fallback: &str| translate(key).unwrap_or_else(|| fallback.to_owned());
    // rust: let Some((locked, scale)) = map else {
    // rust: return vec![text("filled_map.unknown", "Unknown Map")];
}
    // MapPostProcessing: 0 lock, 1 scale.
    // rust: let post = stack.data().and_then(|d| d.map_post_processing);
    // rust: let mut lines = Vec::new();
    // rust: if stack.custom_name().is_none() && post.is_none() {
    // rust: lines.push(text("filled_map.id", "ID #%s").replacen("%s", &id.to_string(), 1));
}
    // rust: if locked || post == Some(0) {
    // rust: lines.push(text("filled_map.locked", "Locked"));
}
    // rust: if advanced {
    // rust: let scale = (scale + u8::from(post == Some(1))).min(4);
    // rust: lines.push(text("filled_map.scale", "Scaling at 1:%s").replacen(
    // rust: "%s",
    // rust: &(1u32 << scale).to_string(),
    // rust: 1,
    // rust: ));
    // rust: lines.push(
    // rust: text("filled_map.level", "(Level %s/%s)")
    // rust: .replacen("%s", &scale.to_string(), 1)
    // rust: .replacen("%s", "4", 1),
    // rust: );
}
    // rust: lines
}

/// `Bees.addToTooltip`: how many bees a hive item holds (a hive item without
/// the component has the item's default, none).
    // rust: pub fn bees_line(
    // rust: stack: &ItemStack,
    // rust: display: &TooltipDisplay,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Option<String> {
    // rust: if !display.shows("minecraft:bees") {
    // rust: return None;
}
    // rust: let bees = match stack.data().and_then(|d| d.other("minecraft:bees")) {
    // rust: Some(Tag::List(bees)) => bees.len(),
    // rust: Some(_) => return None,
    // rust: None if is_beehive(stack.item.trim_start_matches("minecraft:")) => 0,
    // rust: None => return None,
}
    // rust: let text =
    // rust: translate("container.beehive.bees").unwrap_or_else(|| "container.beehive.bees".into());
    // rust: Some(
    // rust: text.replacen("%s", &bees.to_string(), 1)
    // rust: .replacen("%s", "3", 1),
    // rust: )
}

/// `TypedEntityData.addToTooltip` for a spawn egg: in Peaceful, the red
/// "Disabled in Peaceful" under an egg whose entity type is not allowed there
/// (`EntityType.isAllowedInPeaceful`). The type is the one in the egg's
/// `entity_data` component, else the egg's own (`zombie_spawn_egg`).
/// `allowed_in_peaceful` answers for an entity type id; one it does not know
/// is allowed.
    // rust: pub fn spawn_egg_peaceful_line(
    // rust: stack: &ItemStack,
    // rust: peaceful: bool,
    // rust: display: &TooltipDisplay,
    // rust: allowed_in_peaceful: &dyn Fn(&str) -> bool,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Option<String> {
    // rust: if !peaceful || !display.shows("minecraft:entity_data") {
    // rust: return None;
}
    // `TypedEntityData.addToTooltip` hangs on the `entity_data` component, whatever the item;
    // a spawn egg without the component has its own mob as the default.
    // rust: let id = match stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:entity_data"))
    // rust: .and_then(|data| data.get("id"))
    // rust: {
    // rust: Some(Tag::String(id)) => {
    // rust: let id = id.to_string_lossy();
    // rust: if id.contains(':') {
    // rust: id
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}
    // rust: _ if stack.item.ends_with("_spawn_egg") => format!(
    // rust: "minecraft:{}",
    // rust: stack
    // rust: .item
    // rust: .trim_start_matches("minecraft:")
    // rust: .trim_end_matches("_spawn_egg")
    // rust: ),
    // rust: _ => return None,
}
    // rust: (!allowed_in_peaceful(&id)).then(|| {
    // rust: translate("item.spawn_egg.peaceful").unwrap_or_else(|| "item.spawn_egg.peaceful".into())
    // rust: })
}

/// `BlockItemStateProperties.addToTooltip`: a hive item's honey level (a hive
/// item without the component has the item's default, 0).
    // rust: pub fn honey_line(
    // rust: stack: &ItemStack,
    // rust: display: &TooltipDisplay,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Option<String> {
    // rust: if !display.shows("minecraft:block_state") {
    // rust: return None;
}
    // rust: let level = match stack.data().and_then(|d| d.other("minecraft:block_state")) {
    // rust: Some(Tag::Compound(state)) => {
    // rust: match state.get(&horizon_world::nbt::JavaString::from("honey_level")) {
    // rust: Some(Tag::String(level)) => level.to_string_lossy().parse::<u32>().ok()?,
    // rust: _ => return None,
}
}
    // rust: Some(_) => return None,
    // rust: None if is_beehive(stack.item.trim_start_matches("minecraft:")) => 0,
    // rust: None => return None,
}
    // rust: let text =
    // rust: translate("container.beehive.honey").unwrap_or_else(|| "container.beehive.honey".into());
    // rust: Some(
    // rust: text.replacen("%s", &level.to_string(), 1)
    // rust: .replacen("%s", "5", 1),
    // rust: )
}

/// `WrittenBookContent.addToTooltip`: "by <author>" and the generation.
    // rust: pub fn written_book_lines(
    // rust: stack: &ItemStack,
    // rust: display: &TooltipDisplay,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<String> {
    // rust: let text = |key: &str| translate(key).unwrap_or_else(|| key.to_owned());
    // rust: let Some(book) = stack
    // rust: .data()
    // rust: .and_then(|d| d.written.as_ref())
    // rust: .filter(|_| display.shows("minecraft:written_book_content"))
    // rust: else {
    // rust: return Vec::new();
}
    // rust: let mut lines = Vec::new();
    // rust: if !book.author.trim().is_empty() {
    // rust: lines.push(
    // rust: crate::text::format_translation(
    // rust: &text("book.byAuthor"),
    // rust: &[crate::text::Text::literal(&book.author)],
    // rust: )
    // rust: .plain(),
    // rust: );
}
    // rust: lines.push(text(&format!("book.generation.{}", book.generation)));
    // rust: lines
}

/// `JukeboxPlayable.addToTooltip`: the song's description.
    // rust: pub fn jukebox_line(
    // rust: stack: &ItemStack,
    // rust: info: Option<&ItemInfo>,
    // rust: display: &TooltipDisplay,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Option<String> {
    // rust: if !display.shows("minecraft:jukebox_playable") {
    // rust: return None;
}
    // rust: let song = match stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:jukebox_playable"))
    // rust: {
    // rust: Some(Tag::String(song)) => song.to_string_lossy(),
        // An inline song carries its own description.
    // rust: Some(inline) => {
    // rust: return inline
    // rust: .get("description")
    // rust: .map(|d| crate::entity_nbt::name_text(d).plain());
}
    // rust: None => info?.jukebox_song.clone()?,
}
    // rust: let key = format!("jukebox_song.{}", song.replacen(':', ".", 1));
    // rust: Some(translate(&key).unwrap_or(key))
}

/// `DyedItemColor.addToTooltip`: "Dyed" (italic, the flag), or with advanced
/// tooltips the colour's hex code.
    // rust: pub fn dyed_line(
    // rust: stack: &ItemStack,
    // rust: display: &TooltipDisplay,
    // rust: advanced: bool,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Option<(String, bool)> {
    // rust: let rgb = stack.data()?.dyed_color?;
    // rust: if !display.shows("minecraft:dyed_color") {
    // rust: return None;
}
    // rust: let text = |key: &str| translate(key).unwrap_or_else(|| key.to_owned());
    // rust: Some(if advanced {
    // rust: let hex = format!("#{:06X}", rgb & 0xFF_FFFF);
    // rust: (text("item.color").replacen("%s", &hex, 1), false)
    // rust: } else {
    // rust: (text("item.dyed"), true)
    // rust: })
}

/// `ItemStack.UNBREAKABLE_TOOLTIP`.
    // rust: pub fn unbreakable_line(
    // rust: stack: &ItemStack,
    // rust: display: &TooltipDisplay,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Option<String> {
    // rust: (stack.data()?.other("minecraft:unbreakable").is_some()
    // rust: && display.shows("minecraft:unbreakable"))
    // rust: .then(|| translate("item.unbreakable").unwrap_or_else(|| "item.unbreakable".into()))
}

/// `OminousBottleAmplifier.addToTooltip`: the effect the bottle gives,
/// `MobEffectInstance(BAD_OMEN, 120000, amplifier)`, listed as
/// `PotionContents.addPotionTooltip` lists it, in the colour of Bad Omen's
/// category (NEUTRAL, blue). An ominous bottle without the component has the
/// item's default amplifier, 0.
    // rust: pub fn ominous_bottle_line(
    // rust: stack: &ItemStack,
    // rust: display: &TooltipDisplay,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Option<(String, u32)> {
pub const BAD_OMEN_TICKS: i32 = 120_000;
    // rust: let amplifier = stack
    // rust: .data()
    // rust: .and_then(|d| d.ominous_amplifier)
    // rust: .or_else(|| (&*stack.item == "minecraft:ominous_bottle").then_some(0))?;
    // rust: if !display.shows("minecraft:ominous_bottle_amplifier") {
    // rust: return None;
}
//     use crate::text::{Text, format_translation};
    // rust: let text = |key: &str, fallback: &str| translate(key).unwrap_or_else(|| fallback.to_owned());
    // PotionContents.getPotionDescription.
    // rust: let mut line = Text::literal(text(
    // rust: "effect.minecraft.bad_omen",
    // rust: "effect.minecraft.bad_omen",
    // rust: ));
    // rust: if amplifier > 0 {
    // rust: let potency = translate(&format!("potion.potency.{amplifier}"))
    // rust: .unwrap_or_else(|| crate::enchant::level_name(u32::from(amplifier) + 1));
    // rust: line = format_translation(
    // rust: &text("potion.withAmplifier", "%s %s"),
    // rust: &[line, Text::literal(potency)],
    // rust: );
}
    // rust: let duration = Text::literal(crate::brewing::format_duration(BAD_OMEN_TICKS));
    // rust: let line = format_translation(&text("potion.withDuration", "%s (%s)"), &[line, duration]);
    // rust: Some((line.plain(), rgba(85, 85, 255, 255)))
}

/// `PotionContents.addPotionTooltip`'s attribute block: an empty line, "When
/// Applied:" and the modifiers of the potion's effects (blue for a gain, red
/// for a loss); nothing for a potion whose effects add none.
    // rust: pub fn potion_modifier_lines(
    // rust: stack: &ItemStack,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<(String, u32)> {
    // rust: if !is_potion_item(&stack.item) {
    // rust: return Vec::new();
}
    // rust: let effects = stack
    // rust: .potion()
    // rust: .and_then(crate::brewing::potion)
    // rust: .into_iter()
    // rust: .flat_map(|p| p.effects.iter())
    // rust: .map(|(effect, _, amplifier)| (*effect, *amplifier));
    // rust: effect_modifier_lines(effects, translate)
}

/// `addPotionTooltip`'s attribute block for (effect id, amplifier) entries.
    // rust: fn effect_modifier_lines<'a>(
    // rust: effects: impl IntoIterator<Item = (&'a str, i32)>,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<(String, u32)> {
    // rust: let applied: Vec<(String, u32)> = effects
    // rust: .into_iter()
    // rust: .filter_map(|(effect, amplifier)| {
    // rust: let (attribute, amount, operation) =
    // rust: effect_modifier(effect.trim_start_matches("minecraft:"))?;
    // rust: let amount = amount * (amplifier + 1) as f64;
    // rust: let line = modifier_line(translate, attribute, amount, operation, false)?;
    // rust: let color = if amount > 0.0 {
    // rust: rgba(85, 85, 255, 255)
    // rust: } else {
    // rust: rgba(255, 85, 85, 255)
}
    // rust: Some((line, color))
    // rust: })
    // rust: .collect();
    // rust: if applied.is_empty() {
    // rust: return applied;
}
    // rust: let mut lines = vec![
    // rust: (String::new(), u32::MAX),
    // rust: (
    // rust: translate("potion.whenDrank").unwrap_or_else(|| "potion.whenDrank".into()),
    // rust: rgba(170, 0, 170, 255),
    // rust: ),
    // rust: ];
    // rust: lines.extend(applied);
    // rust: lines
}

/// `SuspiciousStewEffects.addToTooltip`: only with the creative tooltip flag,
/// the stew's effects as `PotionContents.addPotionTooltip` lists them (each in
/// its `MobEffectCategory` colour, "No Effects" for none), then their
/// attribute modifiers.
    // rust: pub fn stew_lines(
    // rust: stack: &ItemStack,
    // rust: creative: bool,
    // rust: display: &TooltipDisplay,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<(String, u32)> {
    // rust: let effects = stack.data().map_or(&[][..], |d| &d.stew_effects[..]);
    // The component is the item's default (empty) on a suspicious stew.
    // rust: if !creative
    // rust: || (effects.is_empty() && &*stack.item != "minecraft:suspicious_stew")
    // rust: || !display.shows("minecraft:suspicious_stew_effects")
    // rust: {
    // rust: return Vec::new();
}
    // rust: if effects.is_empty() {
    // rust: let none = translate("effect.none").unwrap_or_else(|| "No Effects".into());
    // rust: return vec![(none, rgba(170, 170, 170, 255))];
}
    // `Entry.createEffectInstance`: amplifier 0.
    // rust: let entries = effects.iter().map(|(id, duration)| (&**id, *duration, 0));
    // rust: let mut lines: Vec<(String, u32)> = crate::brewing::effect_lines(entries, 1.0, translate)
    // rust: .into_iter()
    // rust: .map(|(line, category)| {
            // MobEffectCategory.getTooltipFormatting: harmful red, else blue.
    // rust: let color = match category {
    // rust: crate::brewing::Category::Harmful => rgba(255, 85, 85, 255),
    // rust: _ => rgba(85, 85, 255, 255),
}
    // rust: (line, color)
    // rust: })
    // rust: .collect();
    // rust: lines.extend(effect_modifier_lines(
    // rust: effects.iter().map(|(id, _)| (&**id, 0)),
    // rust: translate,
    // rust: ));
    // rust: lines
}

/// `ItemStack.components.size()`: the item's default components with the
/// stack's own changes applied.
pub fn component_count(stack: *ItemStack, info: ?*ItemInfo) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut keys: std::collections::HashSet<String> = info
    // rust: .map(|i| i.components.iter().cloned().collect())
    // rust: .unwrap_or_default();
    // rust: if let Some(Tag::Compound(patch)) = crate::item_data::components_tag(stack.damage, stack.data())
    // rust: {
    // rust: for key in patch.keys() {
    // rust: let key = key.to_string_lossy();
    // rust: match key.strip_prefix('!') {
    // rust: Some(removed) => keys.remove(removed),
    // rust: None => keys.insert(key),
}
}
}
    // rust: keys.len()
}

/// `SmithingTemplateItem.appendHoverText`: the template's kind, what it applies to
/// and its ingredients (gray titles over blue descriptions); none for other items.
    // rust: pub fn smithing_template_lines(
    // rust: stack: &ItemStack,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<(String, u32)> {
    // rust: let path = stack.item.trim_start_matches("minecraft:");
    // rust: if !path.ends_with("_smithing_template") {
    // rust: return Vec::new();
}
    // rust: let text = |key: &str| translate(key).unwrap_or_else(|| key.to_owned());
    // rust: let kind = if path == "netherite_upgrade_smithing_template" {
    // rust: "netherite_upgrade"
    // rust: } else {
    // rust: "armor_trim"
}
    // rust: let (title, description) = (rgba(170, 170, 170, 255), rgba(85, 85, 255, 255));
    // rust: let described = |what: &str| {
    // rust: let key = format!("item.minecraft.smithing_template.{kind}.{what}");
    // rust: (format!(" {}", text(&key)), description)
}
    // rust: vec![
    // rust: (text("item.minecraft.smithing_template"), title),
    // rust: (String::new(), u32::MAX),
    // rust: (text("item.minecraft.smithing_template.applies_to"), title),
    // rust: described("applies_to"),
    // rust: (text("item.minecraft.smithing_template.ingredients"), title),
    // rust: described("ingredients"),
    // rust: ]
}

/// `DiscFragmentItem.appendHoverText`: the gray "Music Disc - 5" line; none for
/// other items.
    // rust: pub fn disc_fragment_line(
    // rust: stack: &ItemStack,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Option<String> {
    // rust: if &*stack.item != "minecraft:disc_fragment_5" {
    // rust: return None;
}
    // rust: let key = "item.minecraft.disc_fragment_5.desc";
    // rust: Some(translate(key).unwrap_or_else(|| key.to_owned()))
}

/// The lines of `stack` below its name that its components give, in
/// `ItemStack.addDetailsToTooltip` order.
    // rust: pub fn detail_lines(
    // rust: stack: &ItemStack,
    // rust: info: Option<&ItemInfo>,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<String> {
    // rust: let text = |key: &str| translate(key).unwrap_or_else(|| key.to_owned());
    // rust: let path = stack.item.trim_start_matches("minecraft:");
    // rust: let mut lines = Vec::new();
    // rust: lines.extend(
    // rust: smithing_template_lines(stack, translate)
    // rust: .into_iter()
    // rust: .map(|l| l.0),
    // rust: );
    // rust: lines.extend(disc_fragment_line(stack, translate));
    // rust: let display = TooltipDisplay::for_stack(stack);
    // rust: lines.extend(bees_line(stack, &display, translate));
    // rust: lines.extend(honey_line(stack, &display, translate));
    // rust: let data = stack.data();
    // PotDecorations.addToTooltip.
    // rust: if let Some(sherds) = data
    // rust: .and_then(|d| d.pot_decorations.as_ref())
    // rust: .filter(|s| s.iter().any(Option::is_some))
    // rust: {
    // rust: lines.push(String::new());
    // rust: for sherd in sherds.iter() {
    // rust: let item = sherd.as_ref().map_or("minecraft:brick", |s| &*s.item);
    // rust: lines.push(name_line(&ItemStack::new(item, 1), translate));
}
}
    // rust: lines.extend(firework_lines(stack, translate));
    // PotionContents.addToTooltip: the effects, then their attribute modifiers.
    // rust: if is_potion_item(&stack.item) {
    // rust: let scale = match path {
    // rust: "lingering_potion" => 0.25,
    // rust: "tipped_arrow" => 0.125,
    // rust: _ => 1.0,
}
    // rust: lines.extend(
    // rust: crate::brewing::tooltip(stack.potion(), scale, translate)
    // rust: .into_iter()
    // rust: .map(|l| l.0),
    // rust: );
    // rust: lines.extend(
    // rust: potion_modifier_lines(stack, translate)
    // rust: .into_iter()
    // rust: .map(|l| l.0),
    // rust: );
}
    // rust: lines.extend(jukebox_line(stack, info, &display, translate));
    // Trim.addToTooltip.
    // rust: if let Some((material, pattern)) = data.and_then(|d| d.trim.as_ref()) {
    // rust: let short = |s: &str| s.trim_start_matches("minecraft:").to_owned();
    // rust: lines.push(text("item.minecraft.smithing_template.upgrade"));
    // rust: lines.push(format!(
    // rust: " {}",
    // rust: text(&format!("trim_pattern.minecraft.{}", short(pattern)))
    // rust: ));
    // rust: lines.push(format!(
    // rust: " {}",
    // rust: text(&format!("trim_material.minecraft.{}", short(material)))
    // rust: ));
}
    // rust: lines.extend(dyed_line(stack, &display, false, translate).map(|l| l.0));
    // rust: if let Some(info) = info {
    // rust: lines.extend(
    // rust: attribute_lines(&info.modifiers, None, translate)
    // rust: .into_iter()
    // rust: .map(|(line, _)| line),
    // rust: );
}
    // rust: lines.extend(ominous_bottle_line(stack, &display, translate).map(|l| l.0));
    // rust: lines
}

/// `Fireworks.addToTooltip` (a rocket's flight duration, its explosions with
/// runs of equal ones counted) and `FireworkExplosion.addToTooltip` (a
/// star's), unless the stack's tooltip display hides them. A rocket without
/// the component has the item's default: flight duration 1, no explosions.
    // rust: pub fn firework_lines(
    // rust: stack: &ItemStack,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<String> {
//     use crate::particles::FireworkExplosion;
    // rust: let text = |key: &str| translate(key).unwrap_or_else(|| key.to_owned());
    // rust: let shape = |e: &FireworkExplosion| {
    // rust: text(&format!(
    // rust: "item.minecraft.firework_star.shape.{}",
    // rust: e.shape.name()
    // rust: ))
}
    // FireworkExplosion.appendColors: dye names (getColorName), comma-separated.
    // rust: let colors = |colors: &[u32]| {
    // rust: colors
    // rust: .iter()
    // rust: .map(|c| {
    // rust: match crate::particles::DYE_FIREWORK_COLORS
    // rust: .iter()
    // rust: .find(|(_, firework)| firework == c)
    // rust: {
    // rust: Some((name, _)) => text(&format!("item.minecraft.firework_star.{name}")),
    // rust: None => text("item.minecraft.firework_star.custom_color"),
}
    // rust: })
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ")
}
    // FireworkExplosion.addAdditionalTooltip.
    // rust: let details = |e: &FireworkExplosion, indent: &str, lines: &mut Vec<String>| {
    // rust: if !e.colors.is_empty() {
    // rust: lines.push(format!("{indent}{}", colors(&e.colors)));
}
    // rust: if !e.fade.is_empty() {
    // rust: let fade = text("item.minecraft.firework_star.fade_to");
    // rust: lines.push(format!("{indent}{fade} {}", colors(&e.fade)));
}
    // rust: if e.trail {
    // rust: lines.push(format!(
    // rust: "{indent}{}",
    // rust: text("item.minecraft.firework_star.trail")
    // rust: ));
}
    // rust: if e.twinkle {
    // rust: lines.push(format!(
    // rust: "{indent}{}",
    // rust: text("item.minecraft.firework_star.flicker")
    // rust: ));
}
}
    // rust: let display = TooltipDisplay::for_stack(stack);
    // rust: let data = stack.data();
    // rust: let mut lines = Vec::new();
    // rust: let fireworks = match data.and_then(|d| d.fireworks.as_ref()) {
    // rust: Some((flight, explosions)) => Some((*flight, explosions.as_slice())),
    // rust: None => (&*stack.item == "minecraft:firework_rocket").then_some((1, &[][..])),
}
    // rust: if let Some((flight, explosions)) = fireworks
    // rust: && display.shows("minecraft:fireworks")
    // rust: {
    // rust: if flight > 0 {
    // rust: lines.push(
    // rust: text("item.minecraft.firework_rocket.flight_duration").replacen(
    // rust: "%s",
    // rust: &flight.to_string(),
    // rust: 1,
    // rust: ),
    // rust: );
}
        // Fireworks.addExplosionTooltip for each run of equal explosions.
    // rust: for run in explosions.chunk_by(|a, b| a == b) {
    // rust: let e = &run[0];
    // rust: lines.push(if run.len() == 1 {
    // rust: text("item.minecraft.firework_rocket.single_star").replacen("%s", &shape(e), 1)
    // rust: } else {
    // rust: text("item.minecraft.firework_rocket.multiple_stars")
    // rust: .replacen("%s", &run.len().to_string(), 1)
    // rust: .replacen("%s", &shape(e), 1)
    // rust: });
    // rust: details(e, "  ", &mut lines);
}
}
    // rust: if let Some(e) = data.and_then(|d| d.firework_explosion.as_ref())
    // rust: && display.shows("minecraft:firework_explosion")
    // rust: {
    // rust: lines.push(shape(e));
    // rust: details(e, "", &mut lines);
}
    // rust: lines
}

/// `ItemContainerContents.addToTooltip`: "count x name" for the first five
/// stacks, by slot, then how many more there are (an italic line).
    // rust: pub fn container_lines(
    // rust: stack: &ItemStack,
    // rust: name: &dyn Fn(&ItemStack) -> String,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<String> {
    // rust: let Some(data) = stack.data() else {
    // rust: return Vec::new();
}
    // rust: let mut slots: Vec<&(u8, ItemStack)> = data.container.iter().collect();
    // rust: slots.sort_by_key(|(slot, _)| *slot);
    // rust: let count = translate("item.container.item_count").unwrap_or_else(|| "%s x %s".into());
    // rust: let mut lines: Vec<String> = slots
    // rust: .iter()
    // rust: .take(5)
    // rust: .map(|(_, s)| horizon_protocol::text::format_java(&count, &[s.count.to_string(), name(s)]))
    // rust: .collect();
    // rust: if slots.len() > 5 {
    // rust: let more =
    // rust: translate("item.container.more_items").unwrap_or_else(|| "and %s more...".into());
    // rust: lines.push(horizon_protocol::text::format_java(
    // rust: &more,
    // rust: &[(slots.len() - 5).to_string()],
    // rust: ));
}
    // rust: lines
}

/// Every line of `stack`'s tooltip, name first.
    // rust: pub fn lines(
    // rust: stack: &ItemStack,
    // rust: info: Option<&ItemInfo>,
    // rust: translate: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Vec<String> {
    // rust: let mut lines = vec![name_line(stack, translate)];
    // rust: if TooltipDisplay::for_stack(stack).shows("minecraft:lore") {
    // rust: lines.extend(lore_texts(stack).into_iter().map(|t| t.plain()));
}
    // rust: lines.extend(detail_lines(stack, info, translate));
    // rust: lines
}

/// `ItemLore.addToTooltip`: each lore component under dark purple italic, with
/// the component's own styles (including explicit `false`) winning on children.
pub fn lore_texts(stack: *ItemStack) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(raw) = stack.data().and_then(|d| d.other("minecraft:lore")) else {
    // rust: return Vec::new();
}
    // rust: let base = crate::text::Style {
    // rust: color: Some(crate::text::DARK_PURPLE),
    // rust: italic: Some(true),
    // rust: ..Default::default()
}
    // rust: let lines: Vec<crate::text::Text> = match raw {
    // rust: Tag::List(entries) => entries
    // rust: .iter()
    // rust: .map(|entry| crate::entity_nbt::name_text(entry).resolve_legacy())
    // rust: .collect(),
    // rust: Tag::Compound(_) | Tag::String(_) => {
    // rust: vec![crate::entity_nbt::name_text(raw).resolve_legacy()]
}
    // rust: _ => Vec::new(),
}
    // rust: lines
    // rust: .into_iter()
    // rust: .map(|mut text| {
    // rust: for span in &mut text.spans {
    // rust: span.style.inherit(&base);
}
    // rust: text
    // rust: })
    // rust: .collect()
}

/// Preserve child colours and explicit styles in the stored hover name.
/// A custom name inherits italic from `ItemStack.getStyledHoverName`.
pub fn styled_name(stack: *ItemStack, fallback: impl FnOnce() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(component) = stack.data().and_then(|d| d.custom_name.as_ref()) {
    // rust: return crate::entity_nbt::name_text(component).with_style(&crate::text::Style {
    // rust: italic: Some(true),
    // rust: ..Default::default()
    // rust: });
}
    // rust: if let Some(component) = stack.data().and_then(|d| d.other("minecraft:item_name")) {
    // rust: return crate::entity_nbt::name_text(component);
}
    // rust: crate::text::Text::legacy(&fallback())
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::loot::PackOverlay;
//     use std::sync::Arc;

pub fn disc_fragment_shows_music_disc_line_first() void {
}
    // rust: let translate = |k: &str| {
    // rust: (k == "item.minecraft.disc_fragment_5.desc").then(|| "Music Disc - 5".to_owned())
}
    // rust: let stack = ItemStack::new("minecraft:disc_fragment_5", 1);
    // rust: assert_eq!(
    // rust: disc_fragment_line(&stack, &translate).as_deref(),
    // rust: Some("Music Disc - 5")
    // rust: );
    // rust: let lines = detail_lines(&stack, None, &translate);
    // rust: assert_eq!(lines.first().map(String::as_str), Some("Music Disc - 5"));
    // rust: let other = ItemStack::new("minecraft:stick", 1);
    // rust: assert_eq!(disc_fragment_line(&other, &translate), None);
    // rust: assert!(
    // rust: !detail_lines(&other, None, &translate)
    // rust: .iter()
    // rust: .any(|l| l == "Music Disc - 5")
    // rust: );
}

pub fn styled_name_keeps_gradient_spans_and_explicit_italic() void {
}
    // rust: let component = Tag::compound([
    // rust: ("text", Tag::String("".into())),
    // rust: (
    // rust: "extra",
    // rust: Tag::List(vec![
    // rust: Tag::compound([
    // rust: ("text", Tag::String("A".into())),
    // rust: ("color", Tag::String("#ff0000".into())),
    // rust: ("italic", Tag::Byte(0)),
    // rust: ]),
    // rust: Tag::compound([
    // rust: ("text", Tag::String("B".into())),
    // rust: ("color", Tag::String("#0000ff".into())),
    // rust: ]),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: let mut stack = ItemStack::new("minecraft:stick", 1);
    // rust: stack.data_mut().custom_name = Some(component);
    // rust: let text = styled_name(&stack, || "unused".into());
    // rust: assert_eq!(text.plain(), "AB");
    // rust: assert_eq!(text.spans[0].style.color, Some(0xff0000));
    // rust: assert_eq!(text.spans[1].style.color, Some(0x0000ff));
    // rust: assert!(!text.spans[0].style.is_italic());
    // rust: assert!(text.spans[1].style.is_italic());
}

pub fn lore_keeps_component_colours_under_dark_purple_italic() void {
}
    // rust: let mut stack = ItemStack::new("minecraft:stick", 1);
    // rust: stack.data_mut().set_other(
    // rust: "minecraft:lore",
    // rust: Some(Tag::List(vec![
    // rust: Tag::compound([
    // rust: ("text", Tag::String("Gold line".into())),
    // rust: ("color", Tag::String("gold".into())),
    // rust: ("italic", Tag::Byte(0)),
    // rust: ]),
    // rust: Tag::String("Plain lore".into()),
    // rust: ])),
    // rust: );
    // rust: let lines = lore_texts(&stack);
    // rust: assert_eq!(lines.len(), 2);
    // rust: assert_eq!(lines[0].plain(), "Gold line");
    // rust: assert_eq!(lines[0].spans[0].style.color, Some(crate::text::GOLD));
    // rust: assert!(!lines[0].spans[0].style.is_italic());
    // rust: assert_eq!(lines[1].plain(), "Plain lore");
    // rust: assert_eq!(
    // rust: lines[1].spans[0].style.color,
    // rust: Some(crate::text::DARK_PURPLE)
    // rust: );
    // rust: assert!(lines[1].spans[0].style.is_italic());
    // rust: assert!(TooltipDisplay::for_stack(&stack).shows("minecraft:lore"));
    // rust: stack.data_mut().set_other(
    // rust: "minecraft:tooltip_display",
    // rust: Some(Tag::compound([(
    // rust: "hidden_components",
    // rust: Tag::List(vec![Tag::String("minecraft:lore".into())]),
    // rust: )])),
    // rust: );
    // rust: assert!(!TooltipDisplay::for_stack(&stack).shows("minecraft:lore"));
}

pub fn tooltip_display_controls_name_and_component_visibility() void {
}
    // rust: let mut stack = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: let display = TooltipDisplay::for_stack(&stack);
    // rust: assert!(display.name_visible(false));
    // rust: assert!(display.shows("minecraft:attribute_modifiers"));

    // rust: stack.data_mut().set_other(
    // rust: "minecraft:tooltip_display",
    // rust: Some(Tag::compound([(
    // rust: "hidden_components",
    // rust: Tag::List(vec![Tag::String("minecraft:attribute_modifiers".into())]),
    // rust: )])),
    // rust: );
    // rust: let display = TooltipDisplay::for_stack(&stack);
    // rust: assert!(display.name_visible(false));
    // rust: assert!(!display.shows("minecraft:attribute_modifiers"));
    // rust: assert!(display.shows("minecraft:enchantments"));

    // rust: stack.data_mut().set_other(
    // rust: "minecraft:tooltip_display",
    // rust: Some(Tag::compound([("hide_tooltip", Tag::Byte(1))])),
    // rust: );
    // rust: let display = TooltipDisplay::for_stack(&stack);
    // rust: assert!(!display.name_visible(false));
    // rust: assert!(display.name_visible(true));
    // rust: assert!(!display.shows("minecraft:attribute_modifiers"));
}

    /// `BundleItem.getTooltipImage` is a tooltip detail of
    /// `minecraft:bundle_contents`, so a `minecraft:tooltip_display` that
    /// hides the component - or the whole tooltip - takes the contents grid
    /// with it. The draw path asks for the grid through the same function.
pub fn a_bundle_contents_grid_follows_the_tooltip_display() void {
}
    // rust: let items = Items::for_tests(Default::default());
    // rust: let mut bundle = ItemStack::new("minecraft:bundle", 1);
    // rust: bundle.data_mut().bundle_contents = vec![ItemStack::new("minecraft:stone", 3)];
    // rust: assert!(bundle_tooltip(&items, &bundle, 0.0, 0.0, 96.0).is_some());
        // A stack that is not a bundle has no grid.
    // rust: let stone = ItemStack::new("minecraft:stone", 1);
    // rust: assert!(bundle_tooltip(&items, &stone, 0.0, 0.0, 96.0).is_none());
        // A display that hides the contents component hides the grid.
    // rust: bundle.data_mut().set_other(
    // rust: "minecraft:tooltip_display",
    // rust: Some(Tag::compound([(
    // rust: "hidden_components",
    // rust: Tag::List(vec![Tag::String("minecraft:bundle_contents".into())]),
    // rust: )])),
    // rust: );
    // rust: assert!(bundle_tooltip(&items, &bundle, 0.0, 0.0, 96.0).is_none());
        // So does one that hides the whole tooltip.
    // rust: bundle.data_mut().set_other(
    // rust: "minecraft:tooltip_display",
    // rust: Some(Tag::compound([("hide_tooltip", Tag::Byte(1))])),
    // rust: );
    // rust: assert!(bundle_tooltip(&items, &bundle, 0.0, 0.0, 96.0).is_none());
        // A component the display does not name leaves the grid alone.
    // rust: bundle.data_mut().set_other(
    // rust: "minecraft:tooltip_display",
    // rust: Some(Tag::compound([(
    // rust: "hidden_components",
    // rust: Tag::List(vec![Tag::String("minecraft:lore".into())]),
    // rust: )])),
    // rust: );
    // rust: assert!(bundle_tooltip(&items, &bundle, 0.0, 0.0, 96.0).is_some());
}

pub fn stew_effects_show_only_with_the_creative_flag() void {
}
    // rust: let translate = |key: &str| {
    // rust: Some(
    // rust: match key {
    // rust: "effect.minecraft.fire_resistance" => "Fire Resistance",
    // rust: "effect.minecraft.weakness" => "Weakness",
    // rust: "effect.minecraft.saturation" => "Saturation",
    // rust: "effect.none" => "No Effects",
    // rust: "potion.whenDrank" => "When Applied:",
    // rust: "attribute.modifier.take.0" => "-%s %s",
    // rust: "attribute.name.attack_damage" => "Attack Damage",
    // rust: _ => return None,
}
    // rust: .to_owned(),
    // rust: )
}
    // rust: let (blue, red) = (rgba(85, 85, 255, 255), rgba(255, 85, 85, 255));
    // rust: let lines = |stack: &ItemStack, creative: bool| {
    // rust: stew_lines(
    // rust: stack,
    // rust: creative,
    // rust: &TooltipDisplay::for_stack(stack),
    // rust: &translate,
    // rust: )
}
    // rust: let mut stew = ItemStack::new("minecraft:suspicious_stew", 1);
        // The item's default, an empty list.
    // rust: assert_eq!(
    // rust: lines(&stew, true),
    // rust: [("No Effects".to_owned(), rgba(170, 170, 170, 255))]
    // rust: );
    // rust: stew.data_mut().stew_effects = vec![
    // rust: (Arc::from("minecraft:fire_resistance"), 60),
    // rust: (Arc::from("minecraft:weakness"), 140),
    // rust: (Arc::from("minecraft:saturation"), 7),
    // rust: ];
    // rust: assert!(lines(&stew, false).is_empty());
    // rust: assert_eq!(
    // rust: lines(&stew, true),
    // rust: [
    // rust: ("Fire Resistance (00:03)".to_owned(), blue),
    // rust: ("Weakness (00:07)".to_owned(), red),
                // 20 ticks or less: no duration.
    // rust: ("Saturation".to_owned(), blue),
    // rust: (String::new(), u32::MAX),
    // rust: ("When Applied:".to_owned(), rgba(170, 0, 170, 255)),
    // rust: ("-4 Attack Damage".to_owned(), red),
    // rust: ]
    // rust: );
    // rust: assert!(lines(&ItemStack::new("minecraft:bowl", 1), true).is_empty());
}

pub fn ominous_bottle_lists_bad_omen_at_its_amplifier_for_100_minutes() void {
}
    // rust: let lang = |key: &str| {
    // rust: Some(
    // rust: match key {
    // rust: "effect.minecraft.bad_omen" => "Bad Omen",
    // rust: "potion.withAmplifier" => "%s %s",
    // rust: "potion.withDuration" => "%s (%s)",
    // rust: "potion.potency.3" => "IV",
    // rust: _ => return None,
}
    // rust: .to_owned(),
    // rust: )
}
    // rust: let duration = crate::brewing::format_duration(120_000);
    // rust: let blue = rgba(85, 85, 255, 255);
        // The item's default amplifier, 0: no potency.
    // rust: let mut bottle = ItemStack::new("minecraft:ominous_bottle", 1);
    // rust: let line = |s: &ItemStack| ominous_bottle_line(s, &TooltipDisplay::for_stack(s), &lang);
    // rust: assert_eq!(
    // rust: line(&bottle),
    // rust: Some((format!("Bad Omen ({duration})"), blue))
    // rust: );
    // rust: bottle.data_mut().ominous_amplifier = Some(3);
    // rust: assert_eq!(
    // rust: line(&bottle),
    // rust: Some((format!("Bad Omen IV ({duration})"), blue))
    // rust: );
    // rust: assert!(
    // rust: lines(&bottle, None, &lang).contains(&format!("Bad Omen IV ({duration})")),
    // rust: "{:?}",
    // rust: lines(&bottle, None, &lang)
    // rust: );
        // A numbered template, as some languages write it.
    // rust: let numbered = |key: &str| match key {
    // rust: "potion.withDuration" => Some("%2$s: %1$s".to_owned()),
    // rust: other => lang(other),
}
    // rust: assert_eq!(
    // rust: ominous_bottle_line(&bottle, &TooltipDisplay::for_stack(&bottle), &numbered)
    // rust: .map(|l| l.0),
    // rust: Some(format!("{duration}: Bad Omen IV"))
    // rust: );
    // rust: bottle.data_mut().set_other(
    // rust: "minecraft:tooltip_display",
    // rust: Some(Tag::compound([(
    // rust: "hidden_components",
    // rust: Tag::List(vec![Tag::String(
    // rust: "minecraft:ominous_bottle_amplifier".into(),
    // rust: )]),
    // rust: )])),
    // rust: );
    // rust: assert_eq!(line(&bottle), None);
    // rust: assert_eq!(line(&ItemStack::new("minecraft:glass_bottle", 1)), None);
}

pub fn ominous_banner_keeps_its_default_hidden_pattern_tooltip() void {
}
    // rust: let mut banner = crate::mobs::raider::ominous_banner();
    // rust: let display = TooltipDisplay::for_stack(&banner);
    // rust: assert!(!display.shows("minecraft:banner_patterns"));

    // rust: banner.data_mut().set_other(
    // rust: "minecraft:tooltip_display",
    // rust: Some(Tag::Compound(Default::default())),
    // rust: );
    // rust: let display = TooltipDisplay::for_stack(&banner);
    // rust: assert!(display.shows("minecraft:banner_patterns"));
}

pub fn ominous_banner_name_and_rarity_use_the_stack() void {
}
    // rust: let translate = |key: &str| match key {
    // rust: "block.minecraft.ominous_banner" => Some("Ominous Banner".to_owned()),
    // rust: "block.minecraft.white_banner" => Some("White Banner".to_owned()),
    // rust: _ => None,
}
    // rust: let mut banner = crate::mobs::raider::ominous_banner();
    // rust: assert_eq!(name_line(&banner, &translate), "Ominous Banner");
    // rust: assert_eq!(name_line(&banner, &|_| None), "Ominous Banner");
    // rust: assert_eq!(rarity(&banner, "common"), "uncommon");
    // rust: banner.data_mut().custom_name = Some(Tag::String("Captain's Standard".into()));
    // rust: assert_eq!(name_line(&banner, &translate), "Captain's Standard");
    // rust: let mut custom_item = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: custom_item.data_mut().other.push((
    // rust: "minecraft:item_name".into(),
    // rust: Tag::String("Excalibur".into()),
    // rust: ));
    // rust: assert_eq!(name_line(&custom_item, &translate), "Excalibur");
    // rust: custom_item.data_mut().custom_name = Some(Tag::String("Custom Blade".into()));
    // rust: assert_eq!(name_line(&custom_item, &translate), "Custom Blade");
    // rust: banner.enchant("minecraft:unbreaking", 1);
    // rust: assert_eq!(rarity(&banner, "common"), "rare");
    // rust: let plain = ItemStack::new("minecraft:white_banner", 1);
    // rust: assert_eq!(name_line(&plain, &translate), "White Banner");
    // rust: assert_eq!(rarity(&plain, "common"), "common");
}

    /// `/give @a stick[rarity=epic,enchantments={aqua_affinity:1}]`: the
    /// stack's rarity wins over the item's, and stays epic when enchanted.
pub fn a_stacks_rarity_component_sets_its_rarity() void {
}
    // rust: let mut stick = ItemStack::new("minecraft:stick", 1);
    // rust: stick
    // rust: .data_mut()
    // rust: .other
    // rust: .push(("minecraft:rarity".into(), Tag::String("epic".into())));
    // rust: assert_eq!(rarity(&stick, "common"), "epic");
    // rust: stick.enchant("minecraft:aqua_affinity", 1);
    // rust: assert_eq!(rarity(&stick, "common"), "epic");
    // rust: let mut sword = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: sword
    // rust: .data_mut()
    // rust: .other
    // rust: .push(("minecraft:rarity".into(), Tag::String("uncommon".into())));
    // rust: sword.enchant("minecraft:sharpness", 1);
    // rust: assert_eq!(rarity(&sword, "common"), "rare");
}

pub fn lore_texts_handles_compound_lists() void {
}
        // Direct command components from issue #6405
    // rust: let cmd = r#"[custom_name=[{"text":"Simple Custom Name","italic":false}],lore=[[{"text":"Simple Custom Lore","italic":false}]],rarity=epic,enchantments={aqua_affinity:1},unbreakable={}]"#;
    // rust: let comp = horizon_items::item_data::command_components(cmd).unwrap();
    // rust: let (damage, extra) = horizon_items::item_data::decode_components(Some(&comp));
    // rust: let stack = ItemStack {
    // rust: item: "minecraft:stick".into(),
    // rust: count: 1,
    // rust: damage,
    // rust: extra,
}
    // rust: assert_eq!(rarity(&stack, "common"), "epic");
    // rust: let name = styled_name(&stack, || "fallback".into());
    // rust: assert_eq!(name.plain(), "Simple Custom Name");
    // rust: assert_eq!(name.spans[0].style.italic, Some(false));

    // rust: let lore = lore_texts(&stack);
    // rust: assert_eq!(lore.len(), 1);
    // rust: assert_eq!(lore[0].plain(), "Simple Custom Lore");
    // rust: assert_eq!(lore[0].spans[0].style.italic, Some(false));
    // rust: assert_eq!(lore[0].spans[0].style.color, Some(crate::text::DARK_PURPLE));
    // rust: assert!(TooltipDisplay::for_stack(&stack).shows("minecraft:lore"));
}

pub fn name_line_translates_items_of_any_namespace() void {
}
    // rust: let translate = |key: &str| match key {
    // rust: "item.example.ruby" => Some("Ruby".to_owned()),
    // rust: "block.example.ruby_block" => Some("Block of Ruby".to_owned()),
    // rust: "item.example.tools.chisel" => Some("Chisel".to_owned()),
    // rust: "item.minecraft.diamond" => Some("Diamond".to_owned()),
    // rust: _ => None,
}
    // rust: let name = |id: &str| name_line(&ItemStack::new(id, 1), &translate);
        // `Util.makeDescriptionId`: the item's own namespace, `/` as `.`.
    // rust: assert_eq!(name("example:ruby"), "Ruby");
    // rust: assert_eq!(name("example:ruby_block"), "Block of Ruby");
    // rust: assert_eq!(name("example:tools/chisel"), "Chisel");
    // rust: assert_eq!(name("minecraft:diamond"), "Diamond");
        // No translation: the path, as the creative names fall back to.
    // rust: assert_eq!(name("example:raw_ruby"), "raw ruby");
}

pub fn player_head_names_use_the_profile() void {
}
    // rust: let translate = |key: &str| match key {
    // rust: "block.minecraft.player_head.named" => Some("%s's Head".to_owned()),
    // rust: "block.minecraft.player_head" => Some("Player Head".to_owned()),
    // rust: _ => None,
}
    // rust: let mut named = ItemStack::new("minecraft:player_head", 1);
    // rust: named
    // rust: .data_mut()
    // rust: .set_other("minecraft:profile", Some(Tag::String("Notch".into())));
    // rust: assert_eq!(name_line(&named, &translate), "Notch's Head");

    // rust: let mut compound = ItemStack::new("minecraft:player_head", 1);
    // rust: compound.data_mut().set_other(
    // rust: "minecraft:profile",
    // rust: Some(Tag::compound([("name", Tag::String("Notch".into()))])),
    // rust: );
    // rust: assert_eq!(name_line(&compound, &translate), "Notch's Head");

    // rust: let mut id_only = ItemStack::new("minecraft:player_head", 1);
    // rust: id_only.data_mut().set_other(
    // rust: "minecraft:profile",
    // rust: Some(Tag::compound([("id", Tag::IntArray(vec![1, 2, 3, 4]))])),
    // rust: );
    // rust: assert_eq!(name_line(&id_only, &translate), "Player Head");

    // rust: named.data_mut().custom_name = Some(Tag::String("Trophy".into()));
    // rust: assert_eq!(name_line(&named, &translate), "Trophy");
}

pub fn container_lines_list_five_stacks_then_how_many_more() void {
}
    // rust: let mut chest = ItemStack::new("minecraft:chest", 1);
    // rust: for slot in [9u8, 1, 2, 3, 4, 5, 6] {
    // rust: chest
    // rust: .data_mut()
    // rust: .container
    // rust: .push((slot, ItemStack::new("minecraft:stone", u32::from(slot))));
}
    // rust: let lang = |k: &str| {
    // rust: Some(
    // rust: match k {
    // rust: "item.container.item_count" => "%s x %s",
    // rust: "item.container.more_items" => "and %s more...",
    // rust: _ => return None,
}
    // rust: .to_owned(),
    // rust: )
}
    // rust: let name = |s: &ItemStack| s.item.trim_start_matches("minecraft:").to_owned();
    // rust: assert_eq!(
    // rust: container_lines(&chest, &name, &lang),
    // rust: [
    // rust: "1 x stone",
    // rust: "2 x stone",
    // rust: "3 x stone",
    // rust: "4 x stone",
    // rust: "5 x stone",
    // rust: "and 2 more..."
    // rust: ]
    // rust: );
    // rust: assert!(container_lines(&ItemStack::new("minecraft:chest", 1), &name, &lang).is_empty());
        // German writes the count after the name: "%2$s× %1$s".
    // rust: let german = |k: &str| match k {
    // rust: "item.container.item_count" => Some("%2$s× %1$s".to_owned()),
    // rust: other => lang(other),
}
    // rust: assert_eq!(container_lines(&chest, &name, &german)[0], "stone× 1");
}

pub fn fireworks_use_loaded_tooltip_translations() void {
}
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-firework-tooltip-language-{}-{}",
    // rust: std::process::id(),
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos(),
    // rust: ));
    // rust: let dir = root.join("assets/minecraft/lang");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(
    // rust: dir.join("en_us.json"),
    // rust: serde_json::to_vec(&serde_json::json!({
    // rust: "item.minecraft.firework_rocket.flight_duration": "Flight Duration: %s",
    // rust: "item.minecraft.firework_rocket.multiple_stars": "%s x %s",
    // rust: "item.minecraft.firework_star.shape.small_ball": "Small Ball",
    // rust: "item.minecraft.firework_star.red": "Red",
    // rust: "item.minecraft.firework_star.custom_color": "Custom",
    // rust: "item.minecraft.firework_star.fade_to": "Fade to",
    // rust: "item.minecraft.firework_star.trail": "Trail",
    // rust: "item.minecraft.firework_star.flicker": "Twinkle",
    // rust: }))
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let enchantments = crate::enchant::Enchantments::load(&root);
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: let translate = |key: &str| enchantments.translate(key).map(str::to_owned);
    // rust: let mut rocket = ItemStack::new("minecraft:firework_rocket", 1);
    // rust: assert_eq!(firework_lines(&rocket, &translate), ["Flight Duration: 1"]);
    // rust: let explosion = crate::particles::FireworkExplosion {
    // rust: colors: vec![0xB3312C],
    // rust: fade: vec![0x123456],
    // rust: trail: true,
    // rust: twinkle: true,
    // rust: ..Default::default()
}
    // rust: rocket.data_mut().fireworks = Some((3, vec![explosion.clone(), explosion.clone()]));
    // rust: assert_eq!(
    // rust: firework_lines(&rocket, &translate),
    // rust: [
    // rust: "Flight Duration: 3",
    // rust: "2 x Small Ball",
    // rust: "  Red",
    // rust: "  Fade to Custom",
    // rust: "  Trail",
    // rust: "  Twinkle",
    // rust: ]
    // rust: );
    // rust: let mut star = ItemStack::new("minecraft:firework_star", 1);
    // rust: star.data_mut().firework_explosion = Some(explosion);
    // rust: assert_eq!(
    // rust: firework_lines(&star, &translate),
    // rust: ["Small Ball", "Red", "Fade to Custom", "Trail", "Twinkle"]
    // rust: );
}

pub fn amounts_use_two_decimals_at_most() void {
}
    // rust: assert_eq!(format_amount(8.0), "8");
    // rust: assert_eq!(format_amount(3.2000000953674316), "3.2");
    // rust: assert_eq!(format_amount(2.8200000524520874), "2.82");
    // rust: assert_eq!(format_amount(0.125), "0.12");
    // rust: assert_eq!(format_amount(0.375), "0.38");
}

pub fn equipment_attributes_use_player_totals_and_slot_group_colors() void {
}
    // rust: let modifiers = [
    // rust: ("attack_damage", "base_attack_damage", 6.0, "mainhand"),
    // rust: ("attack_speed", "base_attack_speed", -2.4, "mainhand"),
    // rust: ("armor", "armor", 3.0, "head"),
    // rust: ]
    // rust: .map(|(attribute, id, amount, slot)| {
    // rust: (
    // rust: format!("minecraft:{attribute}"),
    // rust: format!("minecraft:{id}"),
    // rust: amount,
    // rust: "add_value".to_owned(),
    // rust: slot.to_owned(),
    // rust: )
    // rust: });
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-tooltip-language-{}-{}",
    // rust: std::process::id(),
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .unwrap()
    // rust: .as_nanos(),
    // rust: ));
    // rust: let dir = root.join("assets/minecraft/lang");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(
    // rust: dir.join("en_us.json"),
    // rust: serde_json::to_vec(&serde_json::json!({
    // rust: "item.modifiers.mainhand": "When in Main Hand:",
    // rust: "item.modifiers.head": "When on Head:",
    // rust: "attribute.modifier.equals.0": "%s %s",
    // rust: "attribute.modifier.plus.0": "+%s %s",
    // rust: "attribute.modifier.take.0": "-%s %s",
    // rust: "attribute.name.attack_damage": "Attack Damage",
    // rust: "attribute.name.attack_speed": "Attack Speed",
    // rust: "attribute.name.armor": "Armor",
    // rust: }))
    // rust: .unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let enchantments = crate::enchant::Enchantments::load(&root);
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: let lang = |key: &str| enchantments.translate(key).map(str::to_owned);
    // rust: let green = rgba(0, 170, 0, 255);
    // rust: let gray = rgba(170, 170, 170, 255);
    // rust: let blue = rgba(85, 85, 255, 255);
    // rust: let red = rgba(255, 85, 85, 255);
    // rust: assert_eq!(
    // rust: attribute_lines(&modifiers, Some([1.0, 4.0]), &lang),
    // rust: [
    // rust: (String::new(), u32::MAX),
    // rust: ("When in Main Hand:".into(), gray),
    // rust: (" 7 Attack Damage".into(), green),
    // rust: (" 1.6 Attack Speed".into(), green),
    // rust: (String::new(), u32::MAX),
    // rust: ("When on Head:".into(), gray),
    // rust: ("+3 Armor".into(), blue),
    // rust: ]
    // rust: );
    // rust: let recipe = attribute_lines(&modifiers, None, &lang);
    // rust: assert_eq!(recipe[2], ("+6 Attack Damage".into(), blue));
    // rust: assert_eq!(recipe[3], ("-2.4 Attack Speed".into(), red));
    // rust: let custom_base = attribute_lines(&modifiers, Some([2.0, 6.0]), &lang);
    // rust: assert_eq!(custom_base[2].0, " 8 Attack Damage");
    // rust: assert_eq!(custom_base[3].0, " 3.6 Attack Speed");
    // rust: assert_eq!(
    // rust: modifier_line(&lang, "attack_damage", 0.0, 0, true).as_deref(),
    // rust: Some("0 Attack Damage")
    // rust: );
}

pub fn equipment_attributes_with_prepared_items_and_language() void {
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("HORIZON_TEST_RESOURCES"),
    // rust: );
    // rust: let items = crate::items::Items::catalog(&root, &PackOverlay::NONE).unwrap();
    // rust: let enchantments = crate::enchant::Enchantments::load(&root);
    // rust: let translate = |key: &str| enchantments.translate(key).map(str::to_owned);
    // rust: for (item, expected) in [
    // rust: (
    // rust: "minecraft:diamond_sword",
    // rust: [
    // rust: "",
    // rust: "When in Main Hand:",
    // rust: " 7 Attack Damage",
    // rust: " 1.6 Attack Speed",
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "minecraft:diamond_helmet",
    // rust: ["", "When on Head:", "+3 Armor", "+2 Armor Toughness"],
    // rust: ),
    // rust: ] {
    // rust: let info = items.get(item).unwrap();
    // rust: let lines = attribute_lines(&info.modifiers, Some([1.0, 4.0]), &translate);
    // rust: assert_eq!(
    // rust: lines
    // rust: .iter()
    // rust: .map(|(text, _)| text.as_str())
    // rust: .collect::<Vec<_>>(),
    // rust: expected,
    // rust: "{item}"
    // rust: );
}
}

pub fn modifier_lines_follow_the_sign_and_operation() void {
}
    // rust: let lang = |k: &str| {
    // rust: Some(
    // rust: match k {
    // rust: "attribute.modifier.plus.2" => "+%s%% %s",
    // rust: "attribute.modifier.take.2" => "-%s%% %s",
    // rust: "attribute.name.movement_speed" => "Speed",
    // rust: _ => return None,
}
    // rust: .to_owned(),
    // rust: )
}
    // rust: assert_eq!(
    // rust: modifier_line(&lang, "movement_speed", 0.2, 2, false).as_deref(),
    // rust: Some("+20% Speed")
    // rust: );
    // rust: assert_eq!(
    // rust: modifier_line(&lang, "movement_speed", -0.6, 2, false).as_deref(),
    // rust: Some("-60% Speed")
    // rust: );
    // rust: assert_eq!(modifier_line(&lang, "movement_speed", 0.0, 2, false), None);
}

pub fn modifier_lines_support_positional_format() void {
}
    // rust: let lang = |k: &str| {
    // rust: Some(
    // rust: match k {
    // rust: "attribute.modifier.equals.0" => "%2$s: %1$s",
    // rust: "attribute.modifier.plus.2" => "+%1$s%% %2$s",
    // rust: "attribute.name.attack_damage" => "Damage",
    // rust: _ => return None,
}
    // rust: .to_owned(),
    // rust: )
}
    // rust: assert_eq!(
    // rust: modifier_line(&lang, "attack_damage", 5.0, 0, true).as_deref(),
    // rust: Some("Damage: 5")
    // rust: );
    // rust: assert_eq!(
    // rust: modifier_line(&lang, "attack_damage", 0.2, 2, false).as_deref(),
    // rust: Some("+20% Damage")
    // rust: );
}

pub fn a_spawn_egg_of_a_monster_says_so_in_peaceful() void {
}
    // rust: let lang =
    // rust: |k: &str| (k == "item.spawn_egg.peaceful").then(|| "Disabled in Peaceful".to_owned());
    // rust: let monsters = |id: &str| !matches!(id, "minecraft:zombie" | "minecraft:creeper");
    // rust: let line = |s: &ItemStack, peaceful| {
    // rust: spawn_egg_peaceful_line(s, peaceful, &TooltipDisplay::for_stack(s), &monsters, &lang)
}
    // rust: let zombie = ItemStack::new("minecraft:zombie_spawn_egg", 1);
    // rust: assert_eq!(line(&zombie, true).as_deref(), Some("Disabled in Peaceful"));
        // Not in Peaceful, or an egg of a mob that is allowed there, or no egg.
    // rust: assert_eq!(line(&zombie, false), None);
    // rust: assert_eq!(
    // rust: line(&ItemStack::new("minecraft:pig_spawn_egg", 1), true),
    // rust: None
    // rust: );
    // rust: assert_eq!(line(&ItemStack::new("minecraft:stone", 1), true), None);
        // The entity data's type wins over the egg's own.
    // rust: let mut pig = ItemStack::new("minecraft:pig_spawn_egg", 1);
    // rust: pig.data_mut().set_other(
    // rust: "minecraft:entity_data",
    // rust: Some(Tag::compound([(
    // rust: "id",
    // rust: Tag::String("minecraft:creeper".into()),
    // rust: )])),
    // rust: );
    // rust: assert_eq!(line(&pig, true).as_deref(), Some("Disabled in Peaceful"));
        // Any item with the component, and an id without its namespace.
    // rust: let mut stand = ItemStack::new("minecraft:armor_stand", 1);
    // rust: stand.data_mut().set_other(
    // rust: "minecraft:entity_data",
    // rust: Some(Tag::compound([("id", Tag::String("zombie".into()))])),
    // rust: );
    // rust: assert_eq!(line(&stand, true).as_deref(), Some("Disabled in Peaceful"));
}
}
