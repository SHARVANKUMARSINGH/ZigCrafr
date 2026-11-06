//! Transpiled from Horizon Rust crate
package horizon_client_recipe_book_screen

import "core:fmt"
import "core:mem"
import "core:math"

// The recipe book's drawing (`RecipeBookComponent.extractRenderState`,
// `extractTooltip` and `GhostSlots.extractRenderState`) as the list of GUI
// calls vanilla's widgets make: the background, the search `EditBox`, the
// `RecipeBookTabButton`s, the craftable filter `CycleButton`, the
// `RecipeBookPage` with its `RecipeButton`s, page number and arrows, the
// `OverlayRecipeComponent` and the ghost slots, each with the pose it is
// drawn under. The game paints them; the render parity harness compares them.
// use crate::{
    // rust: items::ItemStack,
    // rust: recipe_book::{Book, BookType, Display, Entry},
}

// A styled run of text: its characters, colour (`-1` for the call's own) and italics.
Run :: struct {
    text: string,
    color: i32,
    italic: bool,
}
    // rust: impl Run {
plain :: proc(text: impl Into<string>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Run {
    // rust: text: text.into(),
    // rust: color: -1,
    // rust: italic: false,
}
}
}

// How an item is drawn: `GuiGraphicsExtractor.item`, `fakeItem` or `itemDecorations`.
ItemCall :: enum {
    Item,
    Fake,
    Decorations,
}

// One GUI call.
Call :: enum {
    // `blit` of a texture region (the book's background).
    Blit {,
    texture: &'static str,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    u: f32,
    v: f32,
    tw: i32,
    th: i32,
    // rust: },
    // `blitSprite`, the id without its namespace.
    Sprite {,
    id: String,
    x: i32,
    y: i32,
    w: i32,
    h: i32,
    // rust: },
    Fill {,
    x0: i32,
    y0: i32,
    x1: i32,
    y1: i32,
    color: i32,
    // rust: },
    // `textHighlight` (the search box's selection).
    Highlight { x0: i32, y0: i32, x1: i32, y1: i32 },
    Text {,
    runs: Vec<Run>,
    x: i32,
    y: i32,
    color: i32,
    shadow: bool,
    // rust: },
    Item {,
    call: ItemCall,
    stack: ItemStack,
    x: i32,
    y: i32,
    // rust: },
    // A widget's tooltip lines.
    Tooltip(Vec<Vec<Run>>),
    // The hovered recipe button's tooltip: its display stack's own tooltip,
    // then "Right Click for More" when it has several recipes.
    ItemTooltip { stack: ItemStack, more: bool },
    // `nextStratum`.
    Stratum,
}

// A call and the pose (`Matrix3x2f` m00, m01, m10, m11, m20, m21) it is made under.
Drawn :: struct {
    call: Call,
    pose: [f32,
}

IDENTITY :: [1.0, 0.0, 0.0, 1.0, 0.0, 0.0]

// JOML `Matrix3x2f.translate`.
translate :: proc(m: [f32; 6], x: f32, y: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: m[0],
    // rust: m[1],
    // rust: m[2],
    // rust: m[3],
    // rust: m[0] * x + m[2] * y + m[4],
    // rust: m[1] * x + m[3] * y + m[5],
    // rust: ]
}
// JOML `Matrix3x2f.scale`.
scale :: proc(m: [f32; 6], x: f32, y: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [m[0] * x, m[1] * x, m[2] * y, m[3] * y, m[4], m[5]]
}

// The search box (`EditBox` fields).
Search :: struct {
    value: string,
    // Cursor, selection end and first shown character, in characters.
    cursor: uint,
    highlight: uint,
    display: uint,
    focused: bool,
    // Milliseconds since the box was focused (`TextCursorUtils.isCursorVisible`).
    blink_ms: u64,
}

// A visible tab, in order: its icons, whether selected, its squeeze time left.
TabView :: struct {
    icons: (string,
    selected: bool,
    anim: f32,
}

// A recipe button: its collection has a craftable recipe; the display
// stacks of each selected recipe; the squeeze time left.
ButtonView :: struct {
    has_craftable: bool,
    entries: [dynamic]Vec<ItemStack>,
    anim: f32,
}

// A recipe of the overlay: craftable, and its ingredient cells (grid
// x, y and the stacks the cell cycles through).
OverlayRecipe :: struct {
    craftable: bool,
    cells: Vec<(i32,
}

// The alternatives overlay of a button, at the corner [`overlay_origin`] gives.
OverlayView :: struct {
    x: i32,
    y: i32,
    // Craftable recipes first.
    recipes: [dynamic]OverlayRecipe,
}

// A ghost slot: its position in the menu, the stacks it cycles through,
// and whether it is the result slot.
GhostView :: struct {
    x: i32,
    y: i32,
    items: [dynamic]ItemStack,
    result: bool,
}

// What the recipe book shows.
Screen :: struct {
    book: BookType,
    // GUI size and `widthTooNarrow`.
    width: i32,
    height: i32,
    narrow: bool,
    mouse: (i32,
    // `slotSelectTime.currentIndex()`.
    index: uint,
    filtering: bool,
    search: ^'a Search,
    tabs: ^'a [TabView],
    // The current page's buttons.
    buttons: ^'a [ButtonView],
    page: uint,
    pages: uint,
    overlay: Maybe(^'a OverlayView),
    // The container's corner, whether its result slot is big, and the ghost slots.
    ghost: Option<(i32,
    // Translations.
    translate: ^'a dyn Fn(string) -> string,
    // `Font.width`.
    text_width: ^'a dyn Fn(string) -> i32,
}

    // rust: impl Screen<'_> {
    // `RecipeBookComponent.getXOrigin` and `getYOrigin`.
origin :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let offset = if self.narrow { 0 } else { 86 };
    // rust: ((self.width - 147) / 2 - offset, (self.height - 166) / 2)
}
hovered :: proc(self: ^Self, x: i32, y: i32, w: i32, h: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (mx, my) = self.mouse;
    // rust: mx >= x && my >= y && mx < x + w && my < y + h
}
    // `Font.plainSubstrByWidth`.
    // rust: fn substr_by_width<'s>(&self, s: &'s str, max: i32) -> &'s str {
    // rust: let mut end = 0;
    // rust: for (i, c) in s.char_indices() {
    // rust: if (self.text_width)(&s[..i + c.len_utf8()]) > max {
    // rust: break;
}
    // rust: end = i + c.len_utf8();
}
    // rust: &s[..end]
}
}

// The recipe book's calls, in vanilla's order.
draw :: proc(s: ^Screen) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut put = |call: Call, pose: [f32; 6]| out.push(Drawn { call, pose });
    // rust: let (xo, yo) = s.origin();
    // rust: put(
    // rust: Call::Blit {
    // rust: texture: "textures/gui/recipe_book.png",
    // rust: x: xo,
    // rust: y: yo,
    // rust: w: 147,
    // rust: h: 166,
    // rust: u: 1.0,
    // rust: v: 1.0,
    // rust: tw: 256,
    // rust: th: 256,
    // rust: },
    // rust: IDENTITY,
    // rust: );
    // rust: search_box(s, xo + 25, yo + 13, &mut put);
    // updateTabs.
    // rust: let offset = if s.narrow { 0 } else { 86 };
    // rust: let tab_x = (s.width - 147) / 2 - offset - 30;
    // rust: let tab_y = (s.height - 166) / 2 + 3;
    // rust: for (n, tab) in s.tabs.iter().enumerate() {
    // rust: let (x, y) = (tab_x, tab_y + 27 * n as i32);
    // rust: let mut pose = IDENTITY;
    // rust: if tab.anim > 0.0 {
    // rust: let squeeze = squeeze(tab.anim);
    // rust: let (cx, cy) = ((x + 8) as f32, (y + 12) as f32);
    // rust: pose = translate(scale(translate(pose, cx, cy), 1.0, squeeze), -cx, -cy);
}
    // rust: let sprite = if tab.selected {
    // rust: "recipe_book/tab_selected"
    // rust: } else {
    // rust: "recipe_book/tab"
}
    // rust: let left = if tab.selected { -2 } else { 0 };
    // rust: put(sprite_call(sprite, x + left, y, 35, 27), pose);
    // rust: let fake = |id: &str, x: i32| Call::Item {
    // rust: call: ItemCall::Fake,
    // rust: stack: ItemStack::new(id, 1),
    // rust: x,
    // rust: y: y + 5,
}
    // rust: match &tab.icons.1 {
    // rust: Some(second) => {
    // rust: put(fake(&tab.icons.0, x + 3 + left), pose);
    // rust: put(fake(second, x + 14 + left), pose);
}
    // rust: None => put(fake(&tab.icons.0, x + 9 + left), pose),
}
}
    // The craftable filter.
    // rust: let (fx, fy) = (xo + 110, yo + 12);
    // rust: let hover = s.hovered(fx, fy, 26, 16);
    // rust: let prefix = if s.book == BookType::Crafting {
    // rust: "recipe_book/"
    // rust: } else {
    // rust: "recipe_book/furnace_"
}
    // rust: let state = if s.filtering {
    // rust: "filter_enabled"
    // rust: } else {
    // rust: "filter_disabled"
}
    // rust: put(
    // rust: sprite_call(
    // rust: &format!("{prefix}{state}{}", if hover { "_highlighted" } else { "" }),
    // rust: fx,
    // rust: fy,
    // rust: 26,
    // rust: 16,
    // rust: ),
    // rust: IDENTITY,
    // rust: );
    // rust: if hover {
    // rust: let key = if !s.filtering {
    // rust: "gui.recipebook.toggleRecipes.all"
    // rust: } else {
    // rust: match s.book {
    // rust: BookType::Crafting => "gui.recipebook.toggleRecipes.craftable",
    // rust: BookType::Furnace => "gui.recipebook.toggleRecipes.smeltable",
    // rust: BookType::BlastFurnace => "gui.recipebook.toggleRecipes.blastable",
    // rust: BookType::Smoker => "gui.recipebook.toggleRecipes.smokable",
}
}
    // rust: put(
    // rust: Call::Tooltip(vec![vec![Run::plain((s.translate)(key))]]),
    // rust: IDENTITY,
    // rust: );
}
    // RecipeBookPage.extractRenderState.
    // rust: if s.pages > 1 {
    // rust: let text = (s.translate)("gui.recipebook.page")
    // rust: .replacen("%s", &(s.page + 1).to_string(), 1)
    // rust: .replacen("%s", &s.pages.to_string(), 1);
    // rust: let w = (s.text_width)(&text);
    // rust: put(
    // rust: Call::Text {
    // rust: runs: vec![Run::plain(text)],
    // rust: x: xo - w / 2 + 73,
    // rust: y: yo + 141,
    // rust: color: -1,
    // rust: shadow: true,
    // rust: },
    // rust: IDENTITY,
    // rust: );
}
    // rust: let mut hovered = None;
    // rust: for (i, b) in s.buttons.iter().enumerate().take(20) {
    // rust: let (x, y) = (xo + 11 + 25 * (i as i32 % 5), yo + 31 + 25 * (i as i32 / 5));
    // rust: let many = b.entries.len() > 1;
    // rust: let sprite = match (b.has_craftable, many) {
    // rust: (true, true) => "recipe_book/slot_many_craftable",
    // rust: (true, false) => "recipe_book/slot_craftable",
    // rust: (false, true) => "recipe_book/slot_many_uncraftable",
    // rust: (false, false) => "recipe_book/slot_uncraftable",
}
    // rust: let mut pose = IDENTITY;
    // rust: if b.anim > 0.0 {
    // rust: let squeeze = squeeze(b.anim);
    // rust: let (cx, cy) = ((x + 8) as f32, (y + 12) as f32);
    // rust: pose = translate(scale(translate(pose, cx, cy), squeeze, squeeze), -cx, -cy);
}
    // rust: put(sprite_call(sprite, x, y, 25, 25), pose);
    // rust: let stack = display_stack(&b.entries, s.index);
    // rust: let mut offset = 4;
    // rust: if many && same_result_display(&b.entries) {
    // rust: put(
    // rust: Call::Item {
    // rust: call: ItemCall::Item,
    // rust: stack: stack.clone(),
    // rust: x: x + offset + 1,
    // rust: y: y + offset + 1,
    // rust: },
    // rust: pose,
    // rust: );
    // rust: offset -= 1;
}
    // rust: put(
    // rust: Call::Item {
    // rust: call: ItemCall::Fake,
    // rust: stack: stack.clone(),
    // rust: x: x + offset,
    // rust: y: y + offset,
    // rust: },
    // rust: pose,
    // rust: );
    // rust: if s.hovered(x, y, 25, 25) {
    // rust: hovered = Some((stack, many));
}
}
    // rust: let arrows = [
    // rust: (
    // rust: s.pages > 1 && s.page + 1 < s.pages,
    // rust: xo + 93,
    // rust: "recipe_book/page_forward",
    // rust: "gui.recipebook.next_page",
    // rust: ),
    // rust: (
    // rust: s.pages > 1 && s.page > 0,
    // rust: xo + 38,
    // rust: "recipe_book/page_backward",
    // rust: "gui.recipebook.previous_page",
    // rust: ),
    // rust: ];
    // rust: for (visible, x, sprite, key) in arrows {
    // rust: if !visible {
    // rust: continue;
}
    // rust: let hover = s.hovered(x, yo + 137, 12, 17);
    // rust: let id = if hover {
    // rust: format!("{sprite}_highlighted")
    // rust: } else {
    // rust: sprite.to_owned()
}
    // rust: put(sprite_call(&id, x, yo + 137, 12, 17), IDENTITY);
    // rust: if hover {
    // rust: put(
    // rust: Call::Tooltip(vec![vec![Run::plain((s.translate)(key))]]),
    // rust: IDENTITY,
    // rust: );
}
}
    // rust: put(Call::Stratum, IDENTITY);
    // rust: if let Some(o) = s.overlay {
    // rust: overlay(s, o, &mut put);
}
    // RecipeBookPage.extractTooltip.
    // rust: if let Some((stack, more)) = hovered
    // rust: && s.overlay.is_none()
    // rust: {
    // rust: put(Call::ItemTooltip { stack, more }, IDENTITY);
}
    // rust: if let Some((left, top, big, ghosts)) = s.ghost {
    // rust: out.extend(ghost(s.index, left, top, big, ghosts));
}
    // rust: out
}

// `GhostSlots.extractRenderState` for a container whose corner is `(left, top)`.
ghost :: proc(index: uint, left: i32, top: i32, big: bool, ghosts: ^[GhostView]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut put = |call: Call, pose: [f32; 6]| out.push(Drawn { call, pose });
    // rust: let pose = translate(IDENTITY, left as f32, top as f32);
    // rust: for g in ghosts.iter().filter(|g| !g.items.is_empty()) {
    // rust: let (x, y) = (g.x, g.y);
    // rust: if g.result && big {
    // rust: put(fill(x - 4, y - 4, x + 20, y + 20, 822_018_048), pose);
    // rust: } else {
    // rust: put(fill(x, y, x + 16, y + 16, 822_018_048), pose);
}
    // rust: let stack = g.items[index % g.items.len()].clone();
    // rust: put(
    // rust: Call::Item {
    // rust: call: ItemCall::Fake,
    // rust: stack: stack.clone(),
    // rust: x,
    // rust: y,
    // rust: },
    // rust: pose,
    // rust: );
    // rust: put(fill(x, y, x + 16, y + 16, 822_083_583), pose);
    // rust: if g.result {
    // rust: put(
    // rust: Call::Item {
    // rust: call: ItemCall::Decorations,
    // rust: stack,
    // rust: x,
    // rust: y,
    // rust: },
    // rust: pose,
    // rust: );
}
}
    // rust: out
}

// `1 + 0.1 sin(t / 15 * PI)`, the squeeze of new recipes' buttons and tabs.
squeeze :: proc(time: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 1.0 + 0.1 * f64::from(time / 15.0 * std::f32::consts::PI).sin() as f32
}

sprite_call :: proc(id: string, x: i32, y: i32, w: i32, h: i32) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Call::Sprite {
    // rust: id: id.to_owned(),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
}
}
fill :: proc(x0: i32, y0: i32, x1: i32, y1: i32, color: i32) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Call::Fill {
    // rust: x0,
    // rust: y0,
    // rust: x1,
    // rust: y1,
    // rust: color,
}
}

// `RecipeButton.getDisplayStack`.
display_stack :: proc(entries: ^[[dynamic]ItemStack], index: uint) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let n = entries.len().max(1);
    // rust: let (offset, entry) = (index / n, index % n);
    // rust: match entries.get(entry) {
    // rust: Some(items) if !items.is_empty() => items[offset % items.len()].clone(),
    // rust: _ => ItemStack::new("minecraft:air", 0),
}
}
// `RecipeButton.allRecipesHaveSameResultDisplay`.
same_result_display :: proc(entries: ^[[dynamic]ItemStack]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut items = entries.iter().flatten();
    // rust: let Some(first) = items.next() else {
    // rust: return true;
}
    // rust: items.all(|s| first.same_item_same_components(s))
}

// `EditBox.extractWidgetRenderState` for the recipe book's search box.
search_box :: proc(s: ^Screen, x: i32, y: i32, put: ^impl FnMut(Call) {
}
    // rust: let b = s.search;
    // rust: let (w, h) = (81, 9 + 5);
    // rust: let sprite = if b.focused {
    // rust: "widget/text_field_highlighted"
    // rust: } else {
    // rust: "widget/text_field"
}
    // rust: put(sprite_call(sprite, x, y, w, h), IDENTITY);
    // rust: let (text_x, text_y) = (x + 4, y + (h - 8) / 2);
    // rust: let color = -1;
    // rust: let chars: Vec<char> = b.value.chars().collect();
    // rust: let tail: String = chars[b.display.min(chars.len())..].iter().collect();
    // rust: let displayed = s.substr_by_width(&tail, w - 8).to_owned();
    // rust: let shown = displayed.chars().count();
    // rust: let rel_cursor = b.cursor as i64 - b.display as i64;
    // rust: let on_screen = rel_cursor >= 0 && rel_cursor <= shown as i64;
    // rust: let visible = b.focused && (b.blink_ms / 300).is_multiple_of(2) && on_screen;
    // rust: let mut draw_x = text_x;
    // rust: let rel_highlight = (b.highlight as i64 - b.display as i64).clamp(0, shown as i64) as usize;
    // rust: let prefix = |n: usize| displayed.chars().take(n).collect::<String>();
    // rust: if !displayed.is_empty() {
    // rust: let half = if on_screen {
    // rust: prefix(rel_cursor as usize)
    // rust: } else {
    // rust: displayed.clone()
}
    // rust: let width = (s.text_width)(&half);
    // rust: put(
    // rust: Call::Text {
    // rust: runs: runs_of(half),
    // rust: x: draw_x,
    // rust: y: text_y,
    // rust: color,
    // rust: shadow: true,
    // rust: },
    // rust: IDENTITY,
    // rust: );
    // rust: draw_x += width + 1;
}
    // rust: let insert = b.cursor < chars.len() || chars.len() >= 50;
    // rust: let mut cursor_x = draw_x;
    // rust: if !on_screen {
    // rust: cursor_x = if rel_cursor > 0 { text_x + w } else { text_x };
    // rust: } else if insert {
    // rust: cursor_x -= 1;
    // rust: draw_x -= 1;
}
    // rust: if !displayed.is_empty() && on_screen && (rel_cursor as usize) < shown {
    // rust: let rest: String = displayed.chars().skip(rel_cursor as usize).collect();
    // rust: put(
    // rust: Call::Text {
    // rust: runs: runs_of(rest),
    // rust: x: draw_x,
    // rust: y: text_y,
    // rust: color,
    // rust: shadow: true,
    // rust: },
    // rust: IDENTITY,
    // rust: );
}
    // rust: if displayed.is_empty() && !b.focused {
        // SEARCH_HINT: gray, italic.
    // rust: put(
    // rust: Call::Text {
    // rust: runs: vec![Run {
    // rust: text: (s.translate)("gui.recipebook.search_hint"),
    // rust: color: 0xAAAAAA,
    // rust: italic: true,
    // rust: }],
    // rust: x: draw_x,
    // rust: y: text_y,
    // rust: color,
    // rust: shadow: true,
    // rust: },
    // rust: IDENTITY,
    // rust: );
}
    // rust: if rel_highlight as i64 != rel_cursor {
    // rust: let highlight_x = text_x + (s.text_width)(&prefix(rel_highlight));
    // rust: put(
    // rust: Call::Highlight {
    // rust: x0: cursor_x.min(x + w),
    // rust: y0: text_y - 1,
    // rust: x1: (highlight_x - 1).min(x + w),
    // rust: y1: text_y + 1 + 9,
    // rust: },
    // rust: IDENTITY,
    // rust: );
}
    // rust: if visible {
    // rust: if insert {
    // rust: put(
    // rust: fill(cursor_x, text_y - 1, cursor_x + 1, text_y + 10, color),
    // rust: IDENTITY,
    // rust: );
    // rust: } else {
    // rust: put(
    // rust: Call::Text {
    // rust: runs: vec![Run::plain("_")],
    // rust: x: cursor_x,
    // rust: y: text_y,
    // rust: color,
    // rust: shadow: true,
    // rust: },
    // rust: IDENTITY,
    // rust: );
}
}
}
runs_of :: proc(text: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if text.is_empty() {
    // rust: Vec::new()
    // rust: } else {
    // rust: vec![Run::plain(text)]
}
}

// `OverlayRecipeComponent.init`'s corner for `total` recipes opened from the
// button at `(button_x, button_y)` of the book at `(xo, yo)`.
overlay_origin :: proc(button_x: i32, button_y: i32, total: uint, xo: i32, yo: i32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let total = total as i32;
    // rust: let max_row = if total <= 16 { 4 } else { 5 };
    // rust: let rows = (total as f32 / max_row as f32).ceil() as i32;
    // rust: let (mut x, mut y) = (button_x, button_y);
    // rust: let width = 25.0f32;
    // rust: let (center_x, center_y) = (xo + 147 / 2, yo + 13 + 166 / 2);
    // rust: let right = (x + total.min(max_row) * 25) as f32;
    // rust: let max_left = (center_x + 50) as f32;
    // rust: if right > max_left {
    // rust: x = (x as f32 - width * ((right - max_left) / width) as i32 as f32) as i32;
}
    // rust: let bottom = (y + rows * 25) as f32;
    // rust: let max_bottom = (center_y + 50) as f32;
    // rust: if bottom > max_bottom {
    // rust: y = (y as f32 - width * ((bottom - max_bottom) / width).ceil()) as i32;
}
    // rust: let top = y as f32;
    // rust: let max_top = (center_y - 100) as f32;
    // rust: if top < max_top {
    // rust: y = (y as f32 - width * ((top - max_top) / width).ceil()) as i32;
}
    // rust: (x, y)
}

// `OverlayRecipeComponent.extractRenderState`.
overlay :: proc(s: ^Screen, o: ^OverlayView, put: ^impl FnMut(Call) {
}
    // rust: let total = o.recipes.len() as i32;
    // rust: let max_row = if total <= 16 { 4 } else { 5 };
    // rust: let (x, y) = (o.x, o.y);
    // rust: let columns = total.min(max_row);
    // rust: let height = (total as f32 / max_row as f32).ceil() as i32;
    // rust: put(
    // rust: sprite_call(
    // rust: "recipe_book/overlay_recipe",
    // rust: x,
    // rust: y,
    // rust: columns * 25 + 8,
    // rust: height * 25 + 8,
    // rust: ),
    // rust: IDENTITY,
    // rust: );
    // rust: let family = if s.book == BookType::Crafting {
    // rust: "crafting"
    // rust: } else {
    // rust: "furnace"
}
    // rust: for (i, r) in o.recipes.iter().enumerate() {
    // rust: let i = i as i32;
    // rust: let (bx, by) = (x + 4 + 25 * (i % max_row), y + 5 + 25 * (i / max_row));
    // rust: let hover = s.hovered(bx, by, 24, 24);
    // rust: let id = format!(
    // rust: "recipe_book/{family}_overlay{}{}",
    // rust: if r.craftable { "" } else { "_disabled" },
    // rust: if hover { "_highlighted" } else { "" }
    // rust: );
    // rust: put(sprite_call(&id, bx, by, 24, 24), IDENTITY);
    // rust: let (gx, gy) = ((bx + 2) as f32, (by + 2) as f32);
    // rust: for (cx, cy, items) in &r.cells {
    // rust: let pose = translate(
    // rust: scale(
    // rust: translate(IDENTITY, gx + (3 + cx * 7) as f32, gy + (3 + cy * 7) as f32),
    // rust: 0.375,
    // rust: 0.375,
    // rust: ),
    // rust: -8.0,
    // rust: -8.0,
    // rust: );
    // rust: put(
    // rust: Call::Item {
    // rust: call: ItemCall::Item,
    // rust: stack: items[s.index % items.len()].clone(),
    // rust: x: 0,
    // rust: y: 0,
    // rust: },
    // rust: pose,
    // rust: );
}
}
}

// The ingredient cells a recipe shows in the overlay
// (`OverlayCraftingRecipeButton` / `OverlaySmeltingRecipeButton.calculateIngredientsPositions`).
overlay_cells :: proc(book: ^Book, entry: ^Entry) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let stacks = |ingredient| -> Vec<ItemStack> {
    // rust: book.items_of(ingredient)
    // rust: .iter()
    // rust: .map(|i| ItemStack::new(i, 1))
    // rust: .collect()
}
    // rust: let mut out = Vec::new();
    // rust: match &entry.display {
    // rust: Display::Furnace(i) => out.push((1, 1, stacks(i))),
    // rust: Display::Shaped { .. } => {
    // rust: let requirements = entry.requirements();
    // rust: for (ingredient, grid) in entry.grid_cells(3, 3) {
    // rust: if let Some(i) = ingredient {
    // rust: out.push((grid as i32 % 3, grid as i32 / 3, stacks(requirements[i])));
}
}
}
    // rust: Display::Shapeless(list) => {
    // rust: for (i, ingredient) in list.iter().enumerate() {
    // rust: out.push((i as i32 % 3, i as i32 / 3, stacks(ingredient)));
}
}
}
    // rust: out.retain(|c| !c.2.is_empty());
    // rust: out
}
