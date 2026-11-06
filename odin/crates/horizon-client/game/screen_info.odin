//! Transpiled from Horizon Rust crate
package horizon_client_screen_info

import "core:fmt"
import "core:mem"
import "core:math"

// What the in-game screens narrate where vanilla's override
// `getNarrationMessage` or `updateNarrationState`: the `ScreenInfo`s their
// drawers begin. Built only while the narrator records (`begin_screen`'s
// closure), with the translator given so tests can see the keys.
// use horizon_client::widgets::{ElementType, ScreenInfo, join_for_narration};

// A translation of `key` with plain arguments (`I18n.get`).
    // rust: pub(super) type Tr<'a> = &'a dyn Fn(&str, &[&str]) -> String;

// The game's translator.
    // rust: pub(super) fn tr(key: &str, args: &[&str]) -> String {
    // rust: horizon_client::screen_narrator::translate(key, args)
}

// `CommonComponents.joinLines`: the parts, a line each.
join_lines :: proc(parts: ^[string]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: parts.join("\n")
}

// `ChatScreen.updateNarrationState` (and `InBedChatScreen`'s): its title,
// how to send (and that the chat is restricted), and the message typed so
// far one level in. No widget and no navigation.
    // rust: pub(super) fn chat(in_bed: bool, value: &str, restricted: bool, tr: Tr<'_>) -> ScreenInfo {
    // rust: let usage = tr("chat_screen.usage", &[]);
    // rust: let usage = if restricted {
    // rust: join_for_narration(&[&usage, &tr("chat_screen.restricted.narration", &[])])
    // rust: } else {
    // rust: usage
}
    // rust: let id = if in_bed { "chat/in_bed" } else { "chat" };
    // rust: let info = ScreenInfo::new(id, tr("chat_screen.title", &[]))
    // rust: .without_widgets()
    // rust: .without_navigation()
    // rust: .element(ElementType::Usage, 0, usage);
    // rust: if value.is_empty() {
    // rust: info
    // rust: } else {
    // rust: info.element(ElementType::Title, 1, tr("chat_screen.message", &[value]))
}
}

// `LevelLoadingScreen`: no title and no navigation; `updateNarratedWidget`
// says the server's progress (`loading.progress`, floored to a percent) in
// the title's place when there is one, and `extractRenderState` narrates
// what changed every 2 s.
    // rust: pub(super) fn level_loading(progress: Option<f32>, tr: Tr<'_>) -> ScreenInfo {
    // rust: let info = ScreenInfo::new("level_loading", "")
    // rust: .without_widgets()
    // rust: .without_navigation()
    // rust: .repeat_every(2000);
    // rust: match progress {
    // rust: Some(p) => {
    // rust: let percent = ((p * 100.0).floor() as i32).to_string();
    // rust: info.element(ElementType::Title, 0, tr("loading.progress", &[&percent]))
}
    // rust: None => info,
}
}

// `BookEditScreen.getNarrationMessage`: its title and the page indicator.
    // rust: pub(super) fn book_edit(page: usize, pages: usize, tr: Tr<'_>) -> ScreenInfo {
    // rust: let indicator = tr(
    // rust: "book.pageIndicator",
    // rust: &[&(page + 1).to_string(), &pages.max(1).to_string()],
    // rust: );
    // rust: ScreenInfo::new(
    // rust: "book/edit",
    // rust: join_for_narration(&[&tr("book.edit.title", &[]), &indicator]),
    // rust: )
}

// `BookViewScreen.getNarrationMessage` (and `LecternScreen`'s): its title,
// the page indicator and the page's text, a line each.
    // rust: pub(super) fn book_view(page: usize, pages: usize, text: &str, tr: Tr<'_>) -> ScreenInfo {
    // rust: let indicator = tr(
    // rust: "book.pageIndicator",
    // rust: &[&(page + 1).to_string(), &pages.to_string()],
    // rust: );
    // rust: ScreenInfo::new(
    // rust: "book/view",
    // rust: join_lines(&[&tr("book.view.title", &[]), &indicator, text]),
    // rust: )
}

// An `AbstractContainerScreen` opens: its narration is its title, which
// its drawer names with `name_container` once it knows the menu (the
// creative inventory's is empty). Slots are never narrated.
    // rust: pub(super) fn begin_container(id: &'static str) {
    // rust: horizon_client::widgets::begin_screen(|| ScreenInfo::new(id, ""));
}

// The open container screen's title (`AbstractContainerScreen`'s `title`).
    // rust: pub(super) fn name_container(title: impl FnOnce() -> String) {
    // rust: horizon_client::widgets::screen_mut(|s| s.title = title());
}

// `ConfirmScreen.getNarrationMessage` (`PackConfirmScreen`,
// `ConfirmLinkScreen`, `DialogScreen.WarningScreen`): the title and the
// message.
    // rust: pub(super) fn confirm(id: &str, title: &str, message: &str) -> ScreenInfo {
    // rust: ScreenInfo::new(id, join_for_narration(&[title, message]))
}

// `PopupScreen.getNarrationMessage`: the title and the messages, a line each.
    // rust: pub(super) fn popup(id: &str, title: &str, messages: &[&str]) -> ScreenInfo {
    // rust: ScreenInfo::new(id, join_for_narration(&[title, &join_lines(messages)]))
}

    // rust: mod tests {
//     use super::*;

    // "key(arg, …)": which key and arguments the narration says.
keys :: proc(key: string, args: ^[string]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if args.is_empty() {
    // rust: key.to_owned()
    // rust: } else {
    // rust: format!("{key}({})", args.join(", "))
}
}

the_chat_narrates_its_usage_and_the_message_typed_but_no_widget :: proc() {
}
    // rust: let empty = chat(false, "", false, &keys);
    // rust: assert_eq!(empty.id, "chat");
    // rust: assert_eq!(empty.title, "chat_screen.title");
    // rust: assert!(!empty.widgets && !empty.navigation);
    // rust: assert_eq!(
    // rust: empty.extra,
    // rust: [(ElementType::Usage, 0, vec!["chat_screen.usage".to_owned()])]
    // rust: );
    // rust: let typed = chat(true, "hello", true, &keys);
    // rust: assert_eq!(typed.id, "chat/in_bed");
    // rust: assert_eq!(
    // rust: typed.extra,
    // rust: [
    // rust: (
    // rust: ElementType::Usage,
    // rust: 0,
    // rust: vec!["chat_screen.usage. chat_screen.restricted.narration".to_owned()]
    // rust: ),
    // rust: (
    // rust: ElementType::Title,
    // rust: 1,
    // rust: vec!["chat_screen.message(hello)".to_owned()]
    // rust: ),
    // rust: ]
    // rust: );
}

level_loading_says_its_progress_in_the_title_place_every_two_seconds :: proc() {
}
    // rust: let waiting = level_loading(None, &keys);
    // rust: assert_eq!(waiting.title, "");
    // rust: assert!(waiting.extra.is_empty());
    // rust: assert!(!waiting.navigation);
    // rust: assert_eq!(waiting.repeat_ms, Some(2000));
    // rust: let loading = level_loading(Some(0.567), &keys);
    // rust: assert_eq!(
    // rust: loading.extra,
    // rust: [(
    // rust: ElementType::Title,
    // rust: 0,
    // rust: vec!["loading.progress(56)".to_owned()]
    // rust: )]
    // rust: );
}

books_name_their_page :: proc() {
}
        // An empty book still counts one page while it is written.
    // rust: assert_eq!(
    // rust: book_edit(0, 0, &keys).title,
    // rust: "book.edit.title. book.pageIndicator(1, 1)"
    // rust: );
    // rust: assert_eq!(
    // rust: book_view(1, 3, "Second page", &keys).title,
    // rust: "book.view.title\nbook.pageIndicator(2, 3)\nSecond page"
    // rust: );
}

confirm_and_popup_screens_join_their_title_and_message :: proc() {
}
    // rust: assert_eq!(
    // rust: confirm("link", "Open this?", "https://example.com").title,
    // rust: "Open this?. https://example.com"
    // rust: );
    // rust: assert_eq!(
    // rust: popup("lock", "Lock difficulty", &["Are you sure?", "Really?"]).title,
    // rust: "Lock difficulty. Are you sure?\nReally?"
    // rust: );
}
}
