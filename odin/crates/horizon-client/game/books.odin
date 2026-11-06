//! Transpiled from Horizon Rust crate
package horizon_client_books

import "core:fmt"
import "core:mem"
import "core:math"

// Books (`BookEditScreen`, `BookSignScreen`, `BookViewScreen`,
// `LecternScreen`): writing pages of a book and quill (14 lines of 114
// pixels, 1024 characters, 100 pages), signing it into a written book,
// reading written books, and lecterns (placing a book, turning its pages
// with a redstone pulse, the comparator output and taking the book).
// use super::{Game, lan::LanHost, screen_info};
// use horizon_client::{
    // rust: containers::{BlockEntity, Lectern},
    // rust: first_person::Hand,
    // rust: hud::{HudBatch, rgba},
    // rust: item_data::{StackData, WrittenBook},
    // rust: items::ItemStack,
    // rust: menu::{Kind, Menu},
    // rust: text::Text,
    // rust: ui,
    // rust: widgets::{self, Narratable, ScreenInfo},
}
// use horizon_core::position::BlockPos;
// use horizon_protocol::packets::play::{self, Clientbound as C, Serverbound as S};
// use horizon_world::level::flags as level_flags;
// use winit::{
    // rust: event::{ElementState, KeyEvent},
    // rust: keyboard::{KeyCode, PhysicalKey},
}

BLACK :: 0xFF00_0000
PAGE_CHARS :: 1024
MAX_PAGES :: 100
LINES :: 14

book_title_box :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut edit = ui::EditBox::new(0.0, 0.0, 114.0, 9.0);
    // rust: edit.bordered = false;
    // rust: edit.max_length = 15;
    // rust: edit.text_color = BLACK;
    // rust: edit.focused = true;
    // rust: edit
}
book_page_box :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut edit = ui::EditBox::new(0.0, 0.0, 114.0, 9.0);
    // rust: edit.bordered = false;
    // rust: edit.multiline = true;
    // rust: edit.max_length = PAGE_CHARS;
    // rust: edit.text_color = BLACK;
    // rust: edit.focused = true;
    // rust: edit
}

    // rust: pub(super) enum BookScreen {
    // rust: Edit {
        // Inventory slot of the book (the selected hotbar slot).
    // rust: slot: usize,
    // rust: pages: Vec<String>,
    // rust: page: usize,
    // rust: signing: bool,
    // rust: title: String,
        // BookSignScreen's title box (`EditBox` of 15).
    // rust: title_edit: ui::EditBox,
        // BookEditScreen's page (`MultiLineEditBox`).
    // rust: page_edit: ui::EditBox,
    // rust: },
    // rust: View {
    // rust: pages: Vec<Text>,
    // rust: page: usize,
    // rust: lectern: Option<(i32, i32, i32)>,
    // rust: },
}
// The pages a book screen reads: a written book's components (so their
// click events stay), else a writable book's text.
view_pages :: proc(data: Maybe(^StackData)) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(data) = data else { return Vec::new() };
    // rust: let Some(w) = &data.written else {
    // rust: return data.writable_pages.iter().map(Text::literal).collect();
}
    // rust: let tagged = w.page_tags.len() == w.pages.len();
    // rust: w.pages
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, page)| match tagged.then(|| &w.page_tags[i]) {
            // A component object, or a component list (`ComponentSerialization`
            // takes both; servers behind ViaVersion send the list form).
    // rust: Some(
    // rust: tag @ (horizon_world::nbt::Tag::Compound(_) | horizon_world::nbt::Tag::List(_)),
    // rust: ) => horizon_client::entity_nbt::name_text(tag),
    // rust: _ => Text::literal(page),
    // rust: })
    // rust: .collect()
}
    // rust: impl Game<'_> {
book_lines :: proc(self: ^Self, page: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.page_lines(&Text::literal(page))
}
page_lines :: proc(self: ^Self, page: ^Text) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.gui.atlas.font.split(page, 114.0)
}
    // `BookViewScreen.mouseClicked`: the click event of the text under the
    // cursor on the page.
book_link_at :: proc(self: ^Self, page: ^Text, left: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.book_style_at(page, left)?.click
}
    // `ActiveTextCollector` over the page: the style of the character
    // under the cursor, for its click and hover events.
book_style_at :: proc(self: ^Self, page: ^Text, left: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (mx, my) = self.cursor;
    // rust: let row = ((my - 32.0) / 9.0).floor();
    // rust: if row < 0.0 || row >= LINES as f32 {
    // rust: return None;
}
    // rust: let lines = self.page_lines(page);
    // rust: let line = lines.get(row as usize)?.resolve_legacy();
    // rust: let mut x = mx - (left + 36.0);
    // rust: if x < 0.0 {
    // rust: return None;
}
    // rust: for (c, style) in line.chars() {
    // rust: x -= self.gui.atlas.font.advance(c, style);
    // rust: if x < 0.0 {
    // rust: return Some(style.clone());
}
}
    // rust: None
}
    // `BookViewScreen.handleClickEvent`: a page link turns to its page
    // (`forcePage`), a web link goes through the confirm-link flow.
    // rust: fn book_follow_link(
    // rust: &mut self,
    // rust: link: horizon_client::text::ClickEvent,
    // rust: count: usize,
    // rust: lectern: Option<(i32, i32, i32)>,
    // rust: ) {
//         use horizon_client::text::ClickEvent;
    // rust: match link {
    // rust: ClickEvent::ChangePage(target) => {
    // rust: let target = (target - 1).clamp(0, count.saturating_sub(1) as i32);
    // rust: let Some(BookScreen::View { page, .. }) = self.book.as_mut() else {
    // rust: return;
}
    // rust: if let Some(key) = lectern {
                    // LecternScreen.forcePage: the menu's button 100 + page.
    // rust: if target != *page as i32 {
    // rust: self.lectern_button(key, 100 + target);
}
    // rust: } else if target != *page as i32 {
    // rust: *page = target as usize;
}
}
    // rust: ClickEvent::OpenUrl(url) => self.click_url(url),
            // closeContainerOnServer, then clickCommandAction with no screen
            // after the command: the book closes and the command runs. A
            // lectern's screen goes with its menu; a book is still the screen
            // a confirmation returns to.
    // rust: ClickEvent::RunCommand(command) => {
    // rust: let book = if lectern.is_none() {
    // rust: self.book.take()
    // rust: } else {
    // rust: None
}
    // rust: self.close_book();
    // rust: self.click_command(&command);
    // rust: if let Some(book) = book {
    // rust: self.command_prompt_returns_to(super::remote_chat::Behind::Book(Box::new(
    // rust: book,
    // rust: )));
}
}
            // Screen.defaultHandleClickEvent: copied, the book stays open.
    // rust: ClickEvent::CopyToClipboard(value) => {
//                 use horizon_client::clipboard::Clipboard;
    // rust: self.clipboard.set(&value);
}
            // defaultHandleGameClickEvent: the dialog opens over the book.
    // rust: ClickEvent::ShowDialog(dialog) => self.show_dialog_ref(&dialog),
            // Screen.defaultHandleGameClickEvent: custom actions retain the book.
    // rust: ClickEvent::Custom { id, payload } => {
    // rust: if let Some(remote) = &self.remote {
    // rust: remote.session.send_custom_click(&id, payload);
}
}
            // SuggestCommand's insertText does nothing on a book; a server's
            // text never opens a file.
    // rust: ClickEvent::SuggestCommand(_) | ClickEvent::OpenFile(_) => {}
}
}
    // `WritableBookItem.use` / `WrittenBookItem.use` (`Player.openItemGui`).
    // A server's player writes in its own client's editor
    // (`LocalPlayer.openItemGui`), and reads on its own client once told to
    // (`ServerPlayer.openItemGui`'s ClientboundOpenBookPacket).
    // rust: pub(super) fn use_book(&mut self, stack: &ItemStack) -> bool {
    // rust: let written = match &*stack.item {
    // rust: "minecraft:writable_book" => false,
    // rust: "minecraft:written_book" => true,
    // rust: _ => return false,
}
    // rust: if self.lan_acting.is_some() {
    // rust: if written {
    // rust: let hand = i32::from(self.hand == Hand::Off);
    // rust: self.guest_packets
    // rust: .push(C::OpenBook(play::OpenBook { hand }));
}
    // rust: } else if let Some(screen) = self.book_screen(stack) {
    // rust: self.open_book(screen);
}
        // WritableBookItem.use / WrittenBookItem.use count every open.
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
    // rust: true
}
    // The screen a book in hand opens: `BookEditScreen` for a book and
    // quill, `BookViewScreen` for a written book.
book_screen :: proc(self: ^Self, stack: ^ItemStack) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match &*stack.item {
    // rust: "minecraft:writable_book" => {
    // rust: let mut pages = stack
    // rust: .data()
    // rust: .map(|d| d.writable_pages.clone())
    // rust: .unwrap_or_default();
    // rust: if pages.is_empty() {
    // rust: pages.push(String::new());
}
    // rust: let mut page_edit = book_page_box();
    // rust: page_edit.set_value(&pages[0]);
    // rust: BookScreen::Edit {
    // rust: slot: self.held_slot(),
    // rust: pages,
    // rust: page: 0,
    // rust: signing: false,
    // rust: title: String::new(),
    // rust: title_edit: book_title_box(),
    // rust: page_edit,
}
}
    // rust: "minecraft:written_book" => BookScreen::View {
    // rust: pages: view_pages(stack.data()),
    // rust: page: 0,
    // rust: lectern: None,
    // rust: },
    // rust: _ => return None,
    // rust: })
}
    // `MultiPlayerGameMode.useItem`'s own use of a book and quill on a
    // server's client: its editor opens here at once.
    // rust: pub(super) fn remote_use_book(&mut self, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:writable_book" {
    // rust: return false;
}
    // rust: if let Some(screen) = self.book_screen(stack) {
    // rust: self.open_book(screen);
}
    // rust: true
}
    // `ClientPacketListener.handleOpenBook`: the written book in that hand.
    // rust: pub(super) fn remote_open_book(&mut self, hand: i32) {
    // rust: let hand = if hand == 1 { Hand::Off } else { Hand::Main };
    // rust: let screen = self.with_hand(hand, |g| {
    // rust: let stack = g.held().filter(|s| &*s.item == "minecraft:written_book")?;
    // rust: g.book_screen(&stack.clone())
    // rust: });
    // rust: if let Some(screen) = screen {
    // rust: self.open_book(screen);
}
}
open_book :: proc(self: ^Self, screen: BookScreen) {
}
    // rust: self.book = Some(screen);
    // rust: self.keys.clear();
    // rust: self.right = false;
    // rust: self.capture(false);
}
    // rust: pub(super) fn close_book(&mut self) {
        // A server's lectern: LecternScreen's menu closes (closeContainer).
    // rust: if matches!(
    // rust: self.book,
    // rust: Some(BookScreen::View {
    // rust: lectern: Some(_),
    // rust: ..
    // rust: })
    // rust: ) && self.remote.is_some()
    // rust: {
    // rust: self.remote_close_container();
}
    // rust: self.book = None;
    // rust: self.capture(self.screen == super::Screen::Playing && !self.screen_over_playing());
}
    // `BookEditScreen.saveChanges` and `BookSignScreen`'s Sign and Close:
    // trailing empty pages dropped, the book in hand updated here and, on a
    // server's client, sent (ServerboundEditBookPacket).
save_book :: proc(self: ^Self, sign: bool) {
}
    // rust: let Some(BookScreen::Edit {
    // rust: slot, pages, title, ..
    // rust: }) = self.book.take()
    // rust: else {
    // rust: return;
}
    // rust: let mut pages = pages;
    // rust: while pages.len() > 1 && pages.last().is_some_and(String::is_empty) {
    // rust: pages.pop();
}
    // rust: let title = sign.then(|| title.trim().to_owned());
    // rust: if self.remote.is_some() {
    // rust: self.send(S::EditBook(play::EditBook {
    // rust: slot: slot as i32,
    // rust: pages: pages.clone(),
    // rust: title: title.clone(),
    // rust: }));
}
    // rust: self.write_book(slot, pages, title);
    // rust: self.capture(true);
}
    // The book and quill at `slot` takes the pages, or with a title becomes
    // the written book its writer signed.
write_book :: proc(self: ^Self, slot: uint, pages: [dynamic]string, title: Maybe(string)) {
}
    // rust: let author = self
    // rust: .lan_acting_name
    // rust: .clone()
    // rust: .unwrap_or_else(|| super::chat::PLAYER_NAME.to_owned());
    // rust: let Some(stack) = self
    // rust: .stack_in_mut(slot)
    // rust: .as_mut()
    // rust: .filter(|s| &*s.item == "minecraft:writable_book")
    // rust: else {
    // rust: return;
}
    // rust: if let Some(title) = title {
    // rust: let mut written = ItemStack::new("minecraft:written_book", 1);
    // rust: written.data_mut().written = Some(WrittenBook {
    // rust: title,
    // rust: author,
    // rust: generation: 0,
    // rust: pages,
    // rust: page_tags: Vec::new(),
    // rust: });
    // rust: *stack = written;
    // rust: } else {
    // rust: stack.data_mut().writable_pages = if pages.iter().all(String::is_empty) {
    // rust: Vec::new()
    // rust: } else {
    // rust: pages
}
    // rust: stack.tidy();
}
}
    // `ServerGamePacketListenerImpl.handleEditBook`: a guest's book in a
    // hotbar slot or its off hand (`updateBookContents`, `signBook`).
    // rust: pub(super) fn lan_edit_book(&mut self, host: &mut LanHost, conn: u32, p: play::EditBook) {
    // rust: if !((0..9).contains(&p.slot) || p.slot == super::shield::OFFHAND_SLOT as i32) {
    // rust: return;
}
    // rust: if let Some(title) = &p.title
    // rust: && !self.chat_filter_text(
    // rust: host,
    // rust: conn,
    // rust: &[title],
    // rust: horizon_client::lan::hub::chat_filter::Place::Book,
    // rust: )
    // rust: {
    // rust: return;
}
    // rust: let menu_slot = if p.slot == super::shield::OFFHAND_SLOT as i32 {
    // rust: 45
    // rust: } else {
    // rust: 36 + p.slot as usize
}
    // rust: let cancelled = self.as_guest(host, conn, |g| {
    // rust: let mut cancel = false;
    // rust: let writable = g
    // rust: .stack_in(p.slot as usize)
    // rust: .is_some_and(|stack| &*stack.item == "minecraft:writable_book");
    // rust: if writable
    // rust: && let (Some(player), Some(name)) = (g.lan_acting_uuid, g.lan_acting_name.clone())
    // rust: {
    // rust: g.native_player_edit_book(
    // rust: player,
    // rust: &name,
    // rust: p.pages.len() as i32,
    // rust: p.title.is_some(),
    // rust: &mut cancel,
    // rust: );
}
    // rust: if cancel {
    // rust: return true;
}
    // rust: g.write_book(p.slot as usize, p.pages, p.title);
    // rust: false
    // rust: });
        // A cancelled edit leaves the client's own copy of the book: forget
        // what was sent so the next broadcast resends the server's stack.
    // rust: if cancelled == Some(true)
    // rust: && let Some(g) = host.hub.guests.iter_mut().find(|g| g.conn == conn)
    // rust: {
    // rust: g.menu_sent[menu_slot] = None;
}
}
    // rust: pub(super) fn book_key(&mut self, event: &KeyEvent) {
    // rust: if event.state != ElementState::Pressed {
    // rust: return;
}
    // rust: if let Some(shortcut) = self.edit_shortcut(event) {
    // rust: self.book_shortcut(shortcut);
    // rust: return;
}
    // rust: let key = match event.physical_key {
    // rust: PhysicalKey::Code(k) => Some(k),
    // rust: _ => None,
}
    // rust: self.book_input(key, event.text.as_deref());
}
    // A key and the text it typed in the open book (the keyboard, or a
    // controller's on-screen keyboard).
    // rust: pub(super) fn book_input(&mut self, key: Option<KeyCode>, text: Option<&str>) {
    // rust: match self.book.as_mut() {
    // rust: Some(BookScreen::View { .. }) => match key {
    // rust: Some(KeyCode::Escape) => self.close_book(),
    // rust: Some(KeyCode::PageUp) => self.turn_page(false),
    // rust: Some(KeyCode::PageDown) => self.turn_page(true),
    // rust: _ => {}
    // rust: },
    // rust: Some(BookScreen::Edit { signing: true, .. }) => match key {
    // rust: Some(KeyCode::Escape) => {
    // rust: if let Some(BookScreen::Edit { signing, .. }) = self.book.as_mut() {
    // rust: *signing = false;
}
}
    // rust: Some(KeyCode::Enter | KeyCode::NumpadEnter) => {
    // rust: let blank = self.book.as_ref().is_some_and(
    // rust: |b| matches!(b, BookScreen::Edit { title, .. } if title.trim().is_empty()),
    // rust: );
    // rust: if !blank {
    // rust: self.save_book(true);
}
}
    // rust: Some(key) if self.book_title_key(key) => {}
    // rust: _ => {
    // rust: if let Some(typed) = text {
    // rust: self.book_title_insert(typed);
}
}
    // rust: },
    // rust: Some(BookScreen::Edit { .. }) => match key {
    // rust: Some(KeyCode::Escape) => self.save_book(false),
    // rust: Some(KeyCode::PageUp) => self.turn_page(false),
    // rust: Some(KeyCode::PageDown) => self.turn_page(true),
    // rust: Some(KeyCode::ArrowUp) => self.book_move_line(-1),
    // rust: Some(KeyCode::ArrowDown) => self.book_move_line(1),
                // MultilineTextField.keyPressed: Home and End seek the caret's
                // line; with Ctrl they go to the page's start and end.
    // rust: Some(edge @ (KeyCode::Home | KeyCode::End)) if !self.has_control_down() => {
    // rust: self.book_line_edge(edge == KeyCode::End)
}
    // rust: Some(KeyCode::Enter | KeyCode::NumpadEnter) => self.page_insert("\n"),
    // rust: Some(key) if self.book_page_key(key) => {}
    // rust: _ => {
    // rust: if let Some(typed) = text {
    // rust: self.page_insert(typed);
}
}
    // rust: },
    // rust: None => {}
}
}
    // Typing for `horizon-ctl type` (`\n` is a line break).
    // rust: pub(super) fn book_type(&mut self, text: &str) {
    // rust: let text = text.replace("\\n", "\n");
    // rust: match self.book.as_mut() {
    // rust: Some(BookScreen::Edit { signing: true, .. }) => self.book_title_insert(&text),
    // rust: Some(BookScreen::Edit { .. }) => self.page_insert(&text),
    // rust: _ => {}
}
}
    // `BookSignScreen.keyPressed` on the title box.
book_title_key :: proc(self: ^Self, key: KeyCode) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (ctrl, shift) = (self.has_control_down(), self.has_shift_down());
    // rust: let Some(BookScreen::Edit {
    // rust: title, title_edit, ..
    // rust: }) = self.book.as_mut()
    // rust: else {
    // rust: return false;
}
    // rust: if !title_edit.key(key, ctrl, shift) {
    // rust: return false;
}
    // rust: title.clone_from(&title_edit.value);
    // rust: true
}
book_title_insert :: proc(self: ^Self, text: string) {
}
    // rust: let Some(BookScreen::Edit {
    // rust: title, title_edit, ..
    // rust: }) = self.book.as_mut()
    // rust: else {
    // rust: return;
}
    // rust: title_edit.insert_text(text);
    // rust: title.clone_from(&title_edit.value);
}
    // `BookEditScreen.keyPressed` on the page, apart from the line moves.
book_page_key :: proc(self: ^Self, key: KeyCode) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (ctrl, shift) = (self.has_control_down(), self.has_shift_down());
    // rust: let before = match self.book.as_ref() {
    // rust: Some(BookScreen::Edit { page_edit, .. }) => Some((
    // rust: page_edit.value.clone(),
    // rust: page_edit.cursor,
    // rust: page_edit.highlight,
    // rust: )),
    // rust: _ => return false,
}
    // rust: let handled = if let Some(BookScreen::Edit { page_edit, .. }) = self.book.as_mut() {
    // rust: page_edit.key(key, ctrl, shift)
    // rust: } else {
    // rust: false
}
    // rust: if handled {
    // rust: self.page_keep(before);
}
    // rust: handled
}
    // One character at a time, so a page stops at the last character that fits.
page_insert :: proc(self: ^Self, text: string) {
}
    // rust: for c in text.chars() {
    // rust: self.page_change(|edit| edit.insert_text(&c.to_string()));
}
}
    // Ctrl+A/C/V/X: the title box while signing, else the page.
    // rust: pub(super) fn book_shortcut(&mut self, shortcut: horizon_client::clipboard::EditShortcut) {
    // rust: let signing = matches!(self.book, Some(BookScreen::Edit { signing: true, .. }));
    // rust: if signing {
    // rust: if let Some(BookScreen::Edit {
    // rust: title, title_edit, ..
    // rust: }) = self.book.as_mut()
    // rust: {
    // rust: title_edit.shortcut(shortcut, &mut self.clipboard);
    // rust: title.clone_from(&title_edit.value);
}
    // rust: return;
}
    // rust: let before = match self.book.as_ref() {
    // rust: Some(BookScreen::Edit { page_edit, .. }) => Some((
    // rust: page_edit.value.clone(),
    // rust: page_edit.cursor,
    // rust: page_edit.highlight,
    // rust: )),
    // rust: _ => None,
}
    // rust: if let Some(BookScreen::Edit { page_edit, .. }) = self.book.as_mut() {
    // rust: page_edit.shortcut(shortcut, &mut self.clipboard);
}
    // rust: self.page_keep(before);
}
    // Edit the page box, then keep it only within 14 lines and 1024 characters.
page_change :: proc(self: ^Self, f: impl FnOnce(^ui::EditBox) {
}
    // rust: let before = match self.book.as_ref() {
    // rust: Some(BookScreen::Edit { page_edit, .. }) => Some((
    // rust: page_edit.value.clone(),
    // rust: page_edit.cursor,
    // rust: page_edit.highlight,
    // rust: )),
    // rust: _ => return false,
}
    // rust: let ran = if let Some(BookScreen::Edit { page_edit, .. }) = self.book.as_mut() {
    // rust: f(page_edit);
    // rust: true
    // rust: } else {
    // rust: false
}
    // rust: ran && self.page_keep(before)
}
    // Write the page, or put the previous text back when it no longer fits.
page_keep :: proc(self: ^Self, before: Option<(string) {
}
    // rust: let next = match self.book.as_ref() {
    // rust: Some(BookScreen::Edit { page_edit, .. }) => page_edit.value.clone(),
    // rust: _ => return false,
}
    // rust: let ok = next.chars().count() <= PAGE_CHARS && self.book_lines(&next).len() <= LINES;
    // rust: let Some(BookScreen::Edit {
    // rust: pages,
    // rust: page,
    // rust: page_edit,
    // rust: ..
    // rust: }) = self.book.as_mut()
    // rust: else {
    // rust: return false;
}
    // rust: if ok {
    // rust: pages[*page].clone_from(&page_edit.value);
    // rust: } else if let Some((value, cursor, highlight)) = before {
    // rust: page_edit.value = value;
    // rust: page_edit.cursor = cursor;
    // rust: page_edit.highlight = highlight;
}
    // rust: ok
}
    // ArrowUp and ArrowDown move a visual line, keeping the column.
book_move_line :: proc(self: ^Self, dir: int) {
}
    // rust: let shift = self.has_shift_down();
    // rust: let (text, cursor) = match self.book.as_ref() {
    // rust: Some(BookScreen::Edit {
    // rust: pages,
    // rust: page,
    // rust: page_edit,
    // rust: ..
    // rust: }) => (pages[*page].clone(), page_edit.cursor),
    // rust: _ => return,
}
    // rust: let rows = self.page_rows(&text);
    // rust: let (x, line) = self.caret_on(&text, &rows, cursor);
    // rust: let next = (line as isize + dir).clamp(0, rows.len() as isize - 1) as usize;
    // rust: let (start, end) = rows[next];
    // rust: let chars: Vec<char> = text.chars().collect();
    // rust: let slice: String = chars[start..end].iter().collect();
        // MultilineTextField.LINE_SEEK_PIXEL_BIAS: vanilla biases this seek, not the drawn caret.
    // rust: let pos = start + self.gui.atlas.font.fit(&slice, x + 2.0);
    // rust: if let Some(BookScreen::Edit { page_edit, .. }) = self.book.as_mut() {
    // rust: page_edit.set_cursor(pos, shift);
}
}
    // Home and End: the start or end of the visual line holding the caret
    // (`getCursorLineView`'s beginIndex and endIndex).
book_line_edge :: proc(self: ^Self, end: bool) {
}
    // rust: let shift = self.has_shift_down();
    // rust: let (text, cursor) = match self.book.as_ref() {
    // rust: Some(BookScreen::Edit {
    // rust: pages,
    // rust: page,
    // rust: page_edit,
    // rust: ..
    // rust: }) => (pages[*page].clone(), page_edit.cursor),
    // rust: _ => return,
}
    // rust: let rows = self.page_rows(&text);
    // rust: let (_, line) = self.caret_on(&text, &rows, cursor);
    // rust: let (start, stop) = rows[line];
    // rust: if let Some(BookScreen::Edit { page_edit, .. }) = self.book.as_mut() {
    // rust: page_edit.set_cursor(if end { stop } else { start }, shift);
}
}
    // Wrapped rows of a page as character ranges, the same breaks as `font.split`.
page_rows :: proc(self: ^Self, page: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let font = &self.gui.atlas.font;
    // rust: let chars: Vec<char> = page.chars().collect();
    // rust: let mut rows = Vec::new();
    // rust: let mut start = 0;
    // rust: while start < chars.len() {
    // rust: let mut end = chars.len();
    // rust: let mut next = chars.len();
    // rust: let mut last_space = None;
    // rust: for i in start..chars.len() {
    // rust: if chars[i] == '\n' {
    // rust: end = i;
    // rust: next = i + 1;
    // rust: break;
}
    // rust: if chars[i] == ' ' {
    // rust: last_space = Some(i);
}
    // rust: let slice: String = chars[start..=i].iter().collect();
    // rust: if font.width(&slice) > 114.0 {
    // rust: match last_space {
    // rust: Some(s) if s > start => {
    // rust: end = s;
    // rust: next = s + 1;
}
    // rust: _ => {
    // rust: end = i.max(start + 1);
    // rust: next = end;
}
}
    // rust: break;
}
}
    // rust: rows.push((start, end));
    // rust: start = next;
    // rust: if start == chars.len() && chars.last() == Some(&'\n') {
    // rust: rows.push((chars.len(), chars.len()));
}
}
    // rust: if rows.is_empty() {
    // rust: rows.push((0, 0));
}
    // rust: rows
}
    // GUI x of the caret and the row it sits on.
caret_on :: proc(self: ^Self, page: string, rows: ^[(uint) {
}
    // rust: let chars: Vec<char> = page.chars().collect();
    // rust: for (i, &(start, end)) in rows.iter().enumerate() {
    // rust: if cursor <= end || i + 1 == rows.len() {
    // rust: let take = cursor.saturating_sub(start).min(end.saturating_sub(start));
    // rust: let prefix: String = chars.iter().skip(start).take(take).collect();
    // rust: return (self.gui.atlas.font.width(&prefix), i);
}
}
    // rust: (0.0, 0)
}
page_index_at :: proc(self: ^Self, page: string, local_x: f32, local_y: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let rows = self.page_rows(page);
    // rust: let line = (local_y / 9.0).floor().max(0.0) as usize;
    // rust: let line = line.min(rows.len().saturating_sub(1));
    // rust: let (start, end) = rows[line];
    // rust: let chars: Vec<char> = page.chars().collect();
    // rust: let slice: String = chars[start..end].iter().collect();
    // rust: start + self.gui.atlas.font.fit(&slice, local_x.max(0.0))
}
    // A click on the centred title (`EditBox.onClick`).
book_title_click :: proc(self: ^Self, field_x: f32, mx: f32) {
}
    // rust: let shift = self.has_shift_down();
    // rust: let Some(BookScreen::Edit {
    // rust: title, title_edit, ..
    // rust: }) = self.book.as_mut()
    // rust: else {
    // rust: return;
}
    // rust: let tx = field_x + ((114.0 - self.gui.atlas.font.width(title)) / 2.0).floor();
    // rust: let rel = (mx - tx).max(0.0);
    // rust: let pos = self.gui.atlas.font.fit(title, rel);
    // rust: title_edit.set_cursor(pos, shift);
}
    // A click on the open page (`MultiLineEditBox.onClick`): a double click
    // selects the word before the cursor and leaves the cursor where it is.
book_page_click :: proc(self: ^Self, origin_x: f32, origin_y: f32, mx: f32, my: f32, double: bool) {
}
    // rust: if double {
    // rust: if let Some(BookScreen::Edit { page_edit, .. }) = self.book.as_mut() {
    // rust: page_edit.select_word_at_cursor();
}
    // rust: return;
}
    // rust: let shift = self.has_shift_down();
    // rust: let text = match self.book.as_ref() {
    // rust: Some(BookScreen::Edit { pages, page, .. }) => pages[*page].clone(),
    // rust: _ => return,
}
    // rust: let pos = self.page_index_at(&text, mx - origin_x, my - origin_y);
    // rust: if let Some(BookScreen::Edit { page_edit, .. }) = self.book.as_mut() {
    // rust: page_edit.set_cursor(pos, shift);
}
}
    // The page buttons (`pageForward` adds a page while editing).
turn_page :: proc(self: ^Self, forward: bool) {
}
    // rust: let mut lectern_page = None;
    // rust: match self.book.as_mut() {
    // rust: Some(BookScreen::Edit {
    // rust: pages,
    // rust: page,
    // rust: page_edit,
    // rust: ..
    // rust: }) => {
    // rust: let before = *page;
    // rust: if forward {
    // rust: if *page + 1 >= pages.len() && pages.len() < MAX_PAGES {
    // rust: pages.push(String::new());
}
    // rust: if *page + 1 < pages.len() {
    // rust: *page += 1;
}
    // rust: } else if *page > 0 {
    // rust: *page -= 1;
}
    // rust: if *page != before {
    // rust: let text = pages[*page].clone();
    // rust: page_edit.set_value(&text);
}
}
    // rust: Some(BookScreen::View {
    // rust: lectern: Some(key), ..
    // rust: }) => lectern_page = Some(*key),
    // rust: Some(BookScreen::View { pages, page, .. }) => {
    // rust: if forward && *page + 1 < pages.len() {
    // rust: *page += 1;
    // rust: } else if !forward && *page > 0 {
    // rust: *page -= 1;
}
}
    // rust: None => return,
}
        // LecternScreen's page buttons click the menu's (1 back, 2 forward);
        // the page turns with the server's data slot and level event 1043.
    // rust: if let Some(key) = lectern_page {
    // rust: self.lectern_button(key, if forward { 2 } else { 1 });
    // rust: return;
}
    // rust: self.audio
    // rust: .play("minecraft:item.book.page_turn", None, 1.0, 1.0);
}
set_lectern_powered :: proc(self: ^Self, key: (i32) {
}
    // rust: self.set_lectern_property(key, "powered", powered);
    // rust: let p = BlockPos::new(key.0, key.1, key.2);
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.lectern_update_below(level, ticks, p, state);
    // rust: });
}
set_lectern_property :: proc(self: ^Self, key: (i32) {
}
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: let registry = self.pack.assets.registry;
    // rust: let Some(mut s) = registry.state(state).cloned() else {
    // rust: return;
}
    // rust: if !s.properties.contains_key(name) {
    // rust: return;
}
    // rust: s.properties.insert(name.into(), value.to_string());
    // rust: if let Some(new) = registry.id(&s) {
    // rust: let p = BlockPos::new(key.0, key.1, key.2);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.set_block(level, ticks, p, new, level_flags::UPDATE_ALL)
    // rust: });
}
}
    // The 2-tick pulses of turned lecterns.
    // rust: pub(super) fn tick_lecterns(&mut self) {
    // rust: self.follow_lectern();
    // rust: let mut done = Vec::new();
    // rust: for (key, left) in &mut self.lectern_pulses {
    // rust: *left -= 1;
    // rust: if *left <= 0 {
    // rust: done.push(*key);
}
}
    // rust: self.lectern_pulses.retain(|(_, left)| *left > 0);
    // rust: for key in done {
    // rust: self.set_lectern_powered(key, false);
}
}
    // `LecternBlock.useItemOn`: a book goes onto an empty lectern.
    // rust: pub(super) fn use_lectern(&mut self, pos: [i32; 3], held: Option<&ItemStack>) -> bool {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: if &*self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]))
    // rust: .name
    // rust: != "minecraft:lectern"
    // rust: {
    // rust: return false;
}
    // rust: let has_book = matches!(self.world.block_entities.get(&key), Some(BlockEntity::Lectern(l)) if l.book.is_some());
    // rust: let Some(book) = held.filter(|h| {
    // rust: matches!(
    // rust: &*h.item,
    // rust: "minecraft:writable_book" | "minecraft:written_book"
    // rust: )
    // rust: }) else {
    // rust: return false;
}
    // rust: if has_book {
    // rust: return false;
}
    // rust: let mut one = book.clone();
    // rust: one.count = 1;
    // rust: self.world.block_entities.insert(
    // rust: key,
    // rust: BlockEntity::Lectern(Lectern {
    // rust: book: Some(one),
    // rust: page: 0,
    // rust: }),
    // rust: );
    // rust: self.set_lectern_property(key, "has_book", true);
    // rust: if !self.creative {
    // rust: self.consume_held();
}
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.audio
    // rust: .play("minecraft:item.book.put", Some(at), 1.0, 1.0);
    // rust: self.container_changed(key);
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: self.native_player_insert_lectern_book(player, &name, pos, &book.item);
}
    // rust: true
}
    // `LecternBlock.openScreen`: reading the lectern's book.
    // rust: pub(super) fn open_lectern(&mut self, pos: [i32; 3]) -> bool {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(BlockEntity::Lectern(l)) = self.world.block_entities.get(&key) else {
    // rust: return false;
}
    // rust: let Some(book) = &l.book else { return false };
    // rust: let pages = view_pages(book.data());
    // rust: let page = (l.page.max(0) as usize).min(pages.len().saturating_sub(1));
    // rust: self.award_custom_stat("interact_with_lectern", 1);
    // rust: self.open_book(BookScreen::View {
    // rust: pages,
    // rust: page,
    // rust: lectern: Some(key),
    // rust: });
    // rust: true
}
    // A `LecternMenu` button of the open lectern screen: on a server it is
    // sent (`handleInventoryButtonClick`); here the lectern's menu takes it
    // with the player's inventory, and the screen follows the block entity.
lectern_button :: proc(self: ^Self, key: (i32) {
}
    // rust: if self.remote.is_some() {
    // rust: if let Some((container, _)) = self.remote.as_ref().and_then(|r| r.menu.as_ref()) {
    // rust: self.send(
    // rust: horizon_protocol::packets::play::Serverbound::ContainerButtonClick(
    // rust: horizon_protocol::packets::play::ContainerButtonClick {
    // rust: container: *container,
    // rust: button: id,
    // rust: },
    // rust: ),
    // rust: );
}
    // rust: return;
}
    // rust: let Some(mut menu) = self.lectern_menu(key) else {
    // rust: return;
}
    // rust: for i in 0..36 {
    // rust: menu.set_player_item(i, self.inventory[i].clone());
}
    // rust: menu.set_player_item(40, self.offhand.clone());
    // rust: menu.creative = self.creative;
    // rust: menu.selected = self.selected;
    // rust: menu.may_build = self.may_build();
    // rust: if !menu.button(&self.menu_env(), id) {
    // rust: return;
}
    // rust: for i in 0..36 {
    // rust: self.inventory[i] = menu.player_item(i).cloned();
}
    // rust: self.offhand = menu.player_item(40).cloned();
    // rust: for stack in std::mem::take(&mut menu.dropped) {
    // rust: self.player_drop(stack);
}
    // rust: self.lectern_menu_done(key, &menu);
    // rust: self.follow_lectern();
}
    // LecternScreen's Take Book: the menu's button 3. The book leaves the
    // lectern, so the screen closes (the server closes the menu once the
    // book is gone; a server's client closes at once rather than wait).
take_lectern_book :: proc(self: ^Self, key: (i32) {
}
    // rust: let before = match self.world.block_entities.get(&key) {
    // rust: Some(BlockEntity::Lectern(l)) => l.book.clone(),
    // rust: _ => None,
}
    // rust: self.lectern_button(key, 3);
    // rust: if let (Some(book), Some(player), Some(name)) = (
    // rust: before.filter(|_| {
    // rust: matches!(self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::Lectern(l)) if l.book.is_none())
    // rust: }),
    // rust: self.lan_acting_uuid,
    // rust: self.lan_acting_name.clone(),
    // rust: ) {
    // rust: self.native_player_take_lectern_book(player, &name, [key.0, key.1, key.2], &book.item);
}
    // rust: if self.may_build()
    // rust: && matches!(
    // rust: self.book,
    // rust: Some(BookScreen::View {
    // rust: lectern: Some(_),
    // rust: ..
    // rust: })
    // rust: )
    // rust: {
    // rust: self.close_book();
}
}
    // The `book` control command: a button of the open book or lectern
    // screen (the page arrows, Take Book, Done), then its page.
    // rust: pub(super) fn book_control(
    // rust: &mut self,
    // rust: action: Option<&str>,
    // rust: ) -> horizon_client::Result<serde_json::Value> {
    // rust: let lectern = match &self.book {
    // rust: Some(BookScreen::View { lectern, .. }) => *lectern,
    // rust: Some(BookScreen::Edit { .. }) => None,
    // rust: None => return Err("no book is open".into()),
}
    // rust: match action {
    // rust: None => {}
    // rust: Some("next") => self.turn_page(true),
    // rust: Some("back") => self.turn_page(false),
    // rust: Some("take") => match lectern {
    // rust: Some(key) => self.take_lectern_book(key),
    // rust: None => return Err("not a lectern".into()),
    // rust: },
            // The book and quill's buttons: Sign, then Sign and Close; Done
            // (which saves), then Cancel.
    // rust: Some("sign") => match self.book.as_mut() {
    // rust: Some(BookScreen::Edit {
    // rust: signing: true,
    // rust: title,
    // rust: ..
    // rust: }) if !title.trim().is_empty() => self.save_book(true),
    // rust: Some(BookScreen::Edit { signing, .. }) => *signing = true,
    // rust: _ => return Err("not a book and quill".into()),
    // rust: },
    // rust: Some("done") => match self.book.as_mut() {
    // rust: Some(BookScreen::Edit { signing: true, .. }) => {
    // rust: if let Some(BookScreen::Edit { signing, .. }) = self.book.as_mut() {
    // rust: *signing = false;
}
}
    // rust: Some(BookScreen::Edit { .. }) => self.save_book(false),
    // rust: _ => self.close_book(),
    // rust: },
    // rust: Some(other) => return Err(format!("unknown book button {other}").into()),
}
    // rust: Ok(match &self.book {
    // rust: Some(BookScreen::View {
    // rust: pages,
    // rust: page,
    // rust: lectern,
    // rust: }) => serde_json::json!({
    // rust: "page": page, "pages": pages.len(), "lectern": lectern.map(|k| [k.0, k.1, k.2]),
    // rust: }),
    // rust: Some(BookScreen::Edit { pages, page, .. }) => {
    // rust: serde_json::json!({ "page": page, "pages": pages.len(), "lectern": null })
}
    // rust: None => serde_json::json!({ "closed": true }),
    // rust: })
}
    // A server's `minecraft:lectern` menu: LecternScreen, its book and
    // page to come (`remote_lectern_book`, `remote_lectern_page`).
    // rust: pub(super) fn remote_open_lectern(&mut self, key: (i32, i32, i32)) {
    // rust: self.open_book(BookScreen::View {
    // rust: pages: Vec::new(),
    // rust: page: 0,
    // rust: lectern: Some(key),
    // rust: });
}
    // `LecternScreen.bookChanged`: the menu's book slot.
    // rust: pub(super) fn remote_lectern_book(&mut self, book: Option<ItemStack>) {
    // rust: if let Some(BookScreen::View {
    // rust: lectern: Some(_),
    // rust: pages,
    // rust: page,
    // rust: }) = self.book.as_mut()
    // rust: {
    // rust: *pages = view_pages(book.as_ref().and_then(ItemStack::data));
    // rust: *page = (*page).min(pages.len().saturating_sub(1));
}
}
    // `LecternScreen.pageChanged`: the menu's page data slot.
    // rust: pub(super) fn remote_lectern_page(&mut self, value: i32) {
    // rust: if let Some(BookScreen::View {
    // rust: lectern: Some(_),
    // rust: pages,
    // rust: page,
    // rust: }) = self.book.as_mut()
    // rust: {
    // rust: *page = (value.max(0) as usize).min(pages.len().saturating_sub(1));
}
}
    // The server closed its lectern menu; false when none is open.
    // rust: pub(super) fn remote_lectern_closed(&mut self) -> bool {
    // rust: if !matches!(
    // rust: self.book,
    // rust: Some(BookScreen::View {
    // rust: lectern: Some(_),
    // rust: ..
    // rust: })
    // rust: ) {
    // rust: return false;
}
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.menu = None;
    // rust: r.menu_title = None;
}
    // rust: self.book = None;
    // rust: self.capture(true);
    // rust: true
}
    // `LecternMenu` over the lectern at `key` (the menu engine, for the
    // local player and LAN guests alike): its book and page.
    // rust: pub(super) fn lectern_menu(&self, key: (i32, i32, i32)) -> Option<Menu> {
    // rust: let Some(BlockEntity::Lectern(l)) = self.world.block_entities.get(&key) else {
    // rust: return None;
}
    // rust: let mut menu = Menu::new(Kind::Lectern);
    // rust: menu.set_slot(&self.menu_env(), 0, l.book.clone());
    // rust: menu.data[0] = l.page;
    // rust: Some(menu)
}
    // The lectern menu's book and page back in the block entity: a new page
    // is `LecternBlock.signalPageChange` (the 2-tick pulse, level event
    // 1043), a book gone `onBookItemRemove` (`resetBookState`).
    // rust: pub(super) fn lectern_menu_done(&mut self, key: (i32, i32, i32), menu: &Menu) {
    // rust: let Some(BlockEntity::Lectern(l)) = self.world.block_entities.get_mut(&key) else {
    // rust: return;
}
    // rust: let (had, before) = (l.book.is_some(), l.page);
    // rust: l.book = menu.slot(0).cloned();
    // rust: l.page = menu.data[0];
    // rust: if had && l.book.is_none() {
    // rust: self.set_lectern_powered(key, false);
    // rust: self.set_lectern_property(key, "has_book", false);
    // rust: self.container_changed(key);
    // rust: } else if menu.data[0] != before {
    // rust: self.set_lectern_powered(key, true);
    // rust: self.lectern_pulses.push((key, 2));
    // rust: self.level_event_at(1043, [key.0, key.1, key.2], 0);
    // rust: self.container_changed(key);
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_lectern_page_change(
    // rust: player,
    // rust: &name,
    // rust: [key.0, key.1, key.2],
    // rust: menu.data[0],
    // rust: );
}
}
}
    // The open lectern screen follows its block entity (`LecternScreen`'s
    // menu listener): the page, and closing once the book is gone.
    // rust: pub(super) fn follow_lectern(&mut self) {
    // rust: let Some(BookScreen::View {
    // rust: lectern: Some(key),
    // rust: page,
    // rust: pages,
    // rust: }) = self.book.as_mut()
    // rust: else {
    // rust: return;
}
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: match self.world.block_entities.get(key) {
    // rust: Some(BlockEntity::Lectern(l)) if l.book.is_some() => {
    // rust: *page = (l.page.max(0) as usize).min(pages.len().saturating_sub(1));
}
    // rust: _ => self.close_book(),
}
}
    // rust: pub(super) fn book_click(&mut self, size: [u32; 2]) {
    // rust: let b = HudBatch::new(size);
    // rust: let (w, left) = (b.width, ((b.width - 192.0) / 2.0).floor());
    // rust: let (mx, my) = self.cursor;
        // MouseHandler: a click within 250 ms of the last one on this screen is a double click.
    // rust: let now = std::time::Instant::now();
    // rust: let double = self
    // rust: .book_last_click
    // rust: .is_some_and(|at| now.duration_since(at).as_millis() < 250);
    // rust: self.book_last_click = Some(now);
    // rust: let inside =
    // rust: |x: f32, y: f32, bw: f32, bh: f32| mx >= x && my >= y && mx < x + bw && my < y + bh;
    // rust: let click = |game: &mut Self| {
    // rust: game.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0)
}
    // rust: match &self.book {
    // rust: Some(BookScreen::Edit {
    // rust: signing: true,
    // rust: title,
    // rust: ..
    // rust: }) => {
    // rust: let blank = title.trim().is_empty();
    // rust: if inside(w / 2.0 - 100.0, 196.0, 98.0, 20.0) && !blank {
    // rust: click(self);
    // rust: self.save_book(true);
    // rust: } else if inside(w / 2.0 + 2.0, 196.0, 98.0, 20.0) {
    // rust: click(self);
    // rust: if let Some(BookScreen::Edit { signing, .. }) = self.book.as_mut() {
    // rust: *signing = false;
}
    // rust: } else if inside(left + 36.0, 50.0, 114.0, 9.0) {
    // rust: self.book_title_click(left + 36.0, mx);
}
}
    // rust: Some(BookScreen::Edit { page, .. }) => {
    // rust: let page = *page;
    // rust: if inside(left + 116.0, 159.0, 23.0, 13.0) {
    // rust: self.turn_page(true);
    // rust: } else if page > 0 && inside(left + 43.0, 159.0, 23.0, 13.0) {
    // rust: self.turn_page(false);
    // rust: } else if inside(w / 2.0 - 100.0, 196.0, 98.0, 20.0) {
    // rust: click(self);
    // rust: if let Some(BookScreen::Edit { signing, .. }) = self.book.as_mut() {
    // rust: *signing = true;
}
    // rust: } else if inside(w / 2.0 + 2.0, 196.0, 98.0, 20.0) {
    // rust: click(self);
    // rust: self.save_book(false);
    // rust: } else if inside(left + 36.0, 32.0, 114.0, 14.0 * 9.0) {
    // rust: self.book_page_click(left + 36.0, 32.0, mx, my, double);
}
}
    // rust: Some(BookScreen::View {
    // rust: pages,
    // rust: page,
    // rust: lectern,
    // rust: }) => {
    // rust: let (page, count, lectern) = (*page, pages.len(), *lectern);
                // The text's click event first, then the buttons.
    // rust: if let Some(link) = pages.get(page).and_then(|t| self.book_link_at(t, left)) {
    // rust: self.book_follow_link(link, count, lectern);
    // rust: } else if page + 1 < count && inside(left + 116.0, 159.0, 23.0, 13.0) {
    // rust: self.turn_page(true);
    // rust: } else if page > 0 && inside(left + 43.0, 159.0, 23.0, 13.0) {
    // rust: self.turn_page(false);
    // rust: } else if let Some(key) = lectern.filter(|_| self.may_build()) {
    // rust: if inside(w / 2.0 - 100.0, 196.0, 98.0, 20.0) {
    // rust: click(self);
    // rust: self.close_book();
    // rust: } else if inside(w / 2.0 + 2.0, 196.0, 98.0, 20.0) {
    // rust: click(self);
    // rust: self.take_lectern_book(key);
}
    // rust: } else if inside((w - 200.0) / 2.0, 196.0, 200.0, 20.0) {
    // rust: click(self);
    // rust: self.close_book();
}
}
    // rust: None => {}
}
}
    // rust: pub(super) fn draw_book(&self, batch: &mut HudBatch) {
    // rust: let Some(book) = &self.book else { return };
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let (mx, my) = self.cursor;
    // rust: let hover =
    // rust: |x: f32, y: f32, bw: f32, bh: f32| mx >= x && my >= y && mx < x + bw && my < y + bh;
    // rust: batch.fill(atlas, 0.0, 0.0, w, h, rgba(16, 16, 16, 160));
    // rust: let left = ((w - 192.0) / 2.0).floor();
    // rust: let top = 2.0;
    // rust: if let Some(mut r) = atlas.sprites.get("gui/book").copied() {
    // rust: let (du, dv) = ((r.u1 - r.u0) / r.w as f32, (r.v1 - r.v0) / r.h as f32);
    // rust: r.u1 = r.u0 + 192.0 * du;
    // rust: r.v1 = r.v0 + 192.0 * dv;
    // rust: batch.rect_uv(left, top, 192.0, 192.0, r, u32::MAX);
}
    // rust: let tr = |key: &str, fallback: &str| self.translate(key, fallback);
    // rust: let page_buttons = |batch: &mut HudBatch, back: bool, forward: bool| {
    // rust: for (show, x, name) in [
    // rust: (forward, 116.0, "page_forward"),
    // rust: (back, 43.0, "page_backward"),
    // rust: ] {
    // rust: if show {
    // rust: let sprite = if hover(left + x, top + 157.0, 23.0, 13.0) {
    // rust: format!("gui/sprites/widget/{name}_highlighted")
    // rust: } else {
    // rust: format!("gui/sprites/widget/{name}")
}
    // rust: batch.sprite(atlas, &sprite, left + x, top + 157.0);
}
}
}
    // rust: let indicator = |batch: &mut HudBatch, page: usize, count: usize| {
            // BookViewScreen.getPageNumberMessage: 26.3's en_us template is
            // positional ("Page %1$s of %2$s").
    // rust: let text = horizon_protocol::text::format_java(
    // rust: &tr("book.pageIndicator", "Page %1$s of %2$s"),
    // rust: &[(page + 1).to_string(), count.max(1).to_string()],
    // rust: );
    // rust: let tw = HudBatch::text_width(atlas, &text);
    // rust: batch.text(atlas, &text, left + 148.0 - tw, top + 16.0, BLACK, false);
}
        // PageButton: a button named for where it turns, there while it can;
        // the view adds the forward one first, the editor the back one.
    // rust: let page_narratables = |back: bool, forward: bool, view: bool| {
    // rust: let back = (back, 43.0, "book.page_button.previous");
    // rust: let forward = (forward, 116.0, "book.page_button.next");
    // rust: let order = if view {
    // rust: [forward, back]
    // rust: } else {
    // rust: [back, forward]
}
    // rust: for (show, x, key) in order {
    // rust: if show {
    // rust: widgets::narratable(|| {
    // rust: let rect = [left + x, top + 157.0, 23.0, 13.0];
    // rust: Narratable::button(screen_info::tr(key, &[]), rect, true)
    // rust: .hovered(hover(rect[0], rect[1], rect[2], rect[3]))
    // rust: .order(i32::from(view))
    // rust: });
}
}
}
    // rust: let button = |batch: &mut HudBatch, x: f32, bw: f32, label: &str, active: bool| {
    // rust: ui::button(
    // rust: batch,
    // rust: atlas,
    // rust: x,
    // rust: 196.0,
    // rust: bw,
    // rust: 20.0,
    // rust: &Text::literal(label),
    // rust: active,
    // rust: hover(x, 196.0, bw, 20.0),
    // rust: );
}
    // rust: let action_button = |batch: &mut HudBatch, action, x: f32, bw: f32, label: &str| {
    // rust: ui::action_button(
    // rust: batch,
    // rust: atlas,
    // rust: action,
    // rust: x,
    // rust: 196.0,
    // rust: bw,
    // rust: 20.0,
    // rust: &Text::literal(label),
    // rust: true,
    // rust: hover(x, 196.0, bw, 20.0),
    // rust: );
}
    // rust: match book {
    // rust: BookScreen::Edit {
    // rust: signing: true,
    // rust: title,
    // rust: title_edit,
    // rust: ..
    // rust: } => {
                // BookSignScreen: its title, and the title box focused.
    // rust: widgets::begin_screen(|| {
    // rust: ScreenInfo::new("book/sign", screen_info::tr("book.sign.title", &[]))
    // rust: });
    // rust: widgets::narratable(|| {
    // rust: let rect = [((w - 114.0) / 2.0).floor() - 3.0, 50.0, 114.0, 20.0];
    // rust: Narratable::edit_box(
    // rust: screen_info::tr("book.sign.titlebox", &[]),
    // rust: title_edit.value.clone(),
    // rust: rect,
    // rust: )
    // rust: .focused(title_edit.focused)
    // rust: });
    // rust: let edit = tr("book.editTitle", "Enter Book Title:");
    // rust: let tw = HudBatch::text_width(atlas, &edit);
    // rust: batch.text(
    // rust: atlas,
    // rust: &edit,
    // rust: left + 36.0 + (114.0 - tw) / 2.0,
    // rust: 34.0,
    // rust: BLACK,
    // rust: false,
    // rust: );
                // The title box: an unbordered, centred EditBox of 114 with
                // black text and no shadow; the value alone is centred, the
                // cursor follows it.
    // rust: let value = &title_edit.value;
    // rust: let x = left + 36.0;
    // rust: let tx = x + ((114.0 - HudBatch::text_width(atlas, value)) / 2.0).floor();
    // rust: batch.text(atlas, value, tx, 50.0, BLACK, false);
    // rust: if title_edit.cursor != title_edit.highlight {
    // rust: let (a, b) = (
    // rust: title_edit.cursor.min(title_edit.highlight),
    // rust: title_edit.cursor.max(title_edit.highlight),
    // rust: );
    // rust: let pre: String = value.chars().take(a).collect();
    // rust: let sel: String = value.chars().skip(a).take(b - a).collect();
    // rust: let sx = tx + HudBatch::text_width(atlas, &pre);
    // rust: batch.text_highlight(
    // rust: atlas,
    // rust: (sx, 49.0, HudBatch::text_width(atlas, &sel), 11.0),
    // rust: true,
    // rust: );
}
    // rust: if title_edit.cursor_visible() {
    // rust: let pre: String = value.chars().take(title_edit.cursor).collect();
    // rust: batch.fill(
    // rust: atlas,
    // rust: tx + HudBatch::text_width(atlas, &pre),
    // rust: 49.0,
    // rust: 1.0,
    // rust: 9.0,
    // rust: BLACK,
    // rust: );
}
                // BookSignScreen: `owner.getName()`, the account's name on a server.
    // rust: let owner = self
    // rust: .remote
    // rust: .as_ref()
    // rust: .map_or(super::chat::PLAYER_NAME, |r| r.profile_name.as_str());
    // rust: let by = tr("book.byAuthor", "by %1$s").replace("%1$s", owner);
    // rust: let tw = HudBatch::text_width(atlas, &by);
    // rust: batch.text(
    // rust: atlas,
    // rust: &by,
    // rust: left + 36.0 + (114.0 - tw) / 2.0,
    // rust: 60.0,
    // rust: rgba(64, 64, 64, 255),
    // rust: false,
    // rust: );
    // rust: let warning = tr(
    // rust: "book.finalizeWarning",
    // rust: "Note! When you sign the book, it will no longer be editable.",
    // rust: );
    // rust: for (i, line) in atlas
    // rust: .font
    // rust: .split(&Text::literal(&warning), 114.0)
    // rust: .iter()
    // rust: .enumerate()
    // rust: {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: line,
    // rust: left + 36.0,
    // rust: 82.0 + i as f32 * 9.0,
    // rust: BLACK,
    // rust: false,
    // rust: );
}
    // rust: button(
    // rust: batch,
    // rust: w / 2.0 - 100.0,
    // rust: 98.0,
    // rust: &tr("book.finalizeButton", "Sign and Close"),
    // rust: !title.trim().is_empty(),
    // rust: );
    // rust: action_button(
    // rust: batch,
    // rust: widgets::Action::Cancel,
    // rust: w / 2.0 + 2.0,
    // rust: 98.0,
    // rust: &tr("gui.cancel", "Cancel"),
    // rust: );
}
    // rust: BookScreen::Edit {
    // rust: pages,
    // rust: page,
    // rust: page_edit,
    // rust: ..
    // rust: } => {
    // rust: widgets::begin_screen(|| {
    // rust: screen_info::book_edit(*page, pages.len(), &screen_info::tr)
    // rust: });
                // The page's MultiLineEditBox (no message), focused, then the
                // page buttons.
    // rust: widgets::narratable(|| {
    // rust: let rect = [((w - 114.0) / 2.0).floor() - 8.0, 28.0, 122.0, 134.0];
    // rust: Narratable::edit_box("", pages[*page].clone(), rect).focused(page_edit.focused)
    // rust: });
    // rust: page_narratables(*page > 0, true, false);
    // rust: indicator(batch, *page, pages.len());
    // rust: let text = &pages[*page];
    // rust: let lines = self.book_lines(text);
    // rust: for (i, line) in lines.iter().take(LINES).enumerate() {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: line,
    // rust: left + 36.0,
    // rust: top + 30.0 + i as f32 * 9.0,
    // rust: BLACK,
    // rust: false,
    // rust: );
}
    // rust: let rows = self.page_rows(text);
    // rust: let (sel_a, sel_b) = (
    // rust: page_edit.cursor.min(page_edit.highlight),
    // rust: page_edit.cursor.max(page_edit.highlight),
    // rust: );
    // rust: if sel_a != sel_b {
    // rust: let chars: Vec<char> = text.chars().collect();
    // rust: for (i, &(start, end)) in rows.iter().enumerate().take(LINES) {
    // rust: let from = sel_a.max(start);
    // rust: let to = sel_b.min(end);
    // rust: if from >= to {
    // rust: continue;
}
    // rust: let pre: String = chars[start..from].iter().collect();
    // rust: let sel: String = chars[from..to].iter().collect();
    // rust: batch.text_highlight(
    // rust: atlas,
    // rust: (
    // rust: left + 36.0 + atlas.font.width(&pre),
    // rust: top + 29.0 + i as f32 * 9.0,
    // rust: atlas.font.width(&sel),
    // rust: 9.0,
    // rust: ),
    // rust: true,
    // rust: );
}
}
    // rust: if page_edit.cursor_visible() {
    // rust: let (x, row) = self.caret_on(text, &rows, page_edit.cursor);
    // rust: batch.fill(
    // rust: atlas,
    // rust: left + 36.0 + x,
    // rust: top + 29.0 + row as f32 * 9.0,
    // rust: 1.0,
    // rust: 9.0,
    // rust: BLACK,
    // rust: );
}
    // rust: page_buttons(batch, *page > 0, true);
    // rust: button(
    // rust: batch,
    // rust: w / 2.0 - 100.0,
    // rust: 98.0,
    // rust: &tr("book.signButton", "Sign"),
    // rust: true,
    // rust: );
    // rust: action_button(
    // rust: batch,
    // rust: widgets::Action::Done,
    // rust: w / 2.0 + 2.0,
    // rust: 98.0,
    // rust: &tr("gui.done", "Done"),
    // rust: );
}
    // rust: BookScreen::View {
    // rust: pages,
    // rust: page,
    // rust: lectern,
    // rust: } => {
    // rust: widgets::begin_screen(|| {
    // rust: let text = pages.get(*page).map(Text::plain).unwrap_or_default();
    // rust: screen_info::book_view(*page, pages.len(), &text, &screen_info::tr)
    // rust: });
                // createMenuControls comes before createPageControlButtons
                // (forward, then back).
    // rust: page_narratables(*page > 0, *page + 1 < pages.len(), true);
    // rust: indicator(batch, *page, pages.len());
    // rust: if let Some(text) = pages.get(*page) {
    // rust: for (i, line) in self.page_lines(text).iter().take(LINES).enumerate() {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: line,
    // rust: left + 36.0,
    // rust: top + 30.0 + i as f32 * 9.0,
    // rust: BLACK,
    // rust: false,
    // rust: );
}
}
    // rust: page_buttons(batch, *page > 0, *page + 1 < pages.len());
                // LecternScreen.createMenuControls: Done and Take Book only with
                // build permission, else BookViewScreen's wide Done.
    // rust: if lectern.is_some() && self.may_build() {
    // rust: action_button(
    // rust: batch,
    // rust: widgets::Action::Done,
    // rust: w / 2.0 - 100.0,
    // rust: 98.0,
    // rust: &tr("gui.done", "Done"),
    // rust: );
    // rust: button(
    // rust: batch,
    // rust: w / 2.0 + 2.0,
    // rust: 98.0,
    // rust: &tr("lectern.take_book", "Take Book"),
    // rust: true,
    // rust: );
    // rust: } else {
    // rust: action_button(
    // rust: batch,
    // rust: widgets::Action::Done,
    // rust: (w - 200.0) / 2.0,
    // rust: 200.0,
    // rust: &tr("gui.done", "Done"),
    // rust: );
}
                // HoveredTextEffects.TOOLTIP_AND_CURSOR: the hovered words'
                // show_text hover event, as the chat shows it.
    // rust: if let Some(hover) = pages
    // rust: .get(*page)
    // rust: .and_then(|t| self.book_style_at(t, left))
    // rust: .and_then(|s| s.hover)
    // rust: {
    // rust: let lines = self.wrapped_rows(&hover, (w as i32 / 2).max(200));
    // rust: self.draw_tooltip_lines(batch, &lines, mx, my);
}
}
}
}
}
// `LecternBlockEntity.getRedstoneSignal`.
    // rust: pub(super) fn lectern_signal(world: &horizon_client::world::World, pos: BlockPos) -> Option<i32> {
    // rust: match world.block_entities.get(&(pos.x, pos.y, pos.z)) {
    // rust: Some(BlockEntity::Lectern(l)) => Some(l.book.as_ref().map_or(0, |b| {
    // rust: let data = b.data();
    // rust: let count = data
    // rust: .and_then(|d| d.written.as_ref().map(|w| w.pages.len()))
    // rust: .or_else(|| data.map(|d| d.writable_pages.len()))
    // rust: .unwrap_or(0)
    // rust: .max(1);
    // rust: let f = if count > 1 {
    // rust: l.page as f32 / (count - 1) as f32
    // rust: } else {
    // rust: 1.0
}
    // rust: (f * 14.0).floor() as i32 + 1
    // rust: })),
    // rust: _ => None,
}
}
