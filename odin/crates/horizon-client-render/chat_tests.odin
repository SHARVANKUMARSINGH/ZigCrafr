//! Transpiled from Horizon Rust crate
package horizon_client_render_chat_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;
// use crate::{font::Font, hud::Rect};
// use std::{collections::HashMap, path::Path};

// The Chat option's default: no restriction.
full :: proc() -> C {
    // Ported from Horizon
    return {}
}
    // rust: ChatAbilities::new(ChatVisibility::Full)
}

font :: proc() -> F {
    // Ported from Horizon
    return {}
}
    // The missing-glyph metrics let these tests run without game assets.
    // rust: Font::load(
    // rust: Path::new("/nonexistent-horizon-chat-test-resources"),
    // rust: &HashMap::new(),
    // rust: &[],
    // rust: (1, 1),
    // rust: (0, 0),
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 1,
    // rust: h: 1,
    // rust: },
    // rust: )
}

add :: proc(chat: ^Chat, font: ^Font, content: Text) {
}
    // rust: for content in font.wrap_components(&content, chat.max_width()) {
    // rust: chat.lines.insert(
    // rust: 0,
    // rust: Line {
    // rust: added: 0,
    // rust: content,
    // rust: tag: None,
    // rust: message: "".into(),
    // rust: },
    // rust: );
}
}

smooth_chat_slides_a_line_in_and_can_hide_the_indicator :: proc() {
}
    // rust: let mut chat = Chat {
    // rust: smooth: true,
    // rust: ..Chat::default()
}
    // rust: chat.lines.push(Line {
    // rust: added: 0,
    // rust: content: Text::literal("hi"),
    // rust: tag: Some(std::sync::Arc::new(Tag::system_single_player(
    // rust: SYSTEM_INDICATOR,
    // rust: ))),
    // rust: message: "hi".into(),
    // rust: });
    // rust: let text_alpha = |draws: &[GuiDraw]| {
    // rust: draws.iter().find_map(|d| match d {
    // rust: GuiDraw::Text { color, .. } => Some(color >> 24),
    // rust: _ => None,
    // rust: })
}
    // The slide is the negative translate the line carries while it moves.
    // rust: let slide = |draws: &[GuiDraw]| {
    // rust: draws.iter().find_map(|d| match d {
    // rust: GuiDraw::Push(ops) => ops.iter().find_map(|op| match op {
    // rust: PoseOp::Translate(x, _) if *x < 0.0 => Some(*x),
    // rust: _ => None,
    // rust: }),
    // rust: _ => None,
    // rust: })
}
    // The tick it arrives: fully faded out, so nothing is drawn.
    // rust: assert_eq!(text_alpha(&chat.layout(361, 0.0, false)), None);
    // Halfway through the intro: left of its place and still faint.
    // rust: let halfway = chat.layout(361, INTRO_TICKS / 2.0, false);
    // rust: assert!(slide(&halfway).is_some_and(|x| (-INTRO_WIDTH..0.0).contains(&x)));
    // rust: let faded = text_alpha(&halfway).expect("the line shows halfway through");
    // Settled: in place and as opaque as vanilla's line.
    // rust: let settled = chat.layout(361, INTRO_TICKS, false);
    // rust: assert_eq!(slide(&settled), None);
    // rust: assert!(text_alpha(&settled).expect("settled") > faded);
    // The extra off draws the line whole on the tick it arrives, as vanilla.
    // rust: chat.smooth = false;
    // rust: let plain = chat.layout(361, 0.0, false);
    // rust: assert_eq!(slide(&plain), None);
    // rust: assert_eq!(text_alpha(&plain), text_alpha(&settled));
    // The indicator bar is the -4 to -2 fill at the left of the line.
    // rust: let bar = |draws: &[GuiDraw]| {
    // rust: draws
    // rust: .iter()
    // rust: .any(|d| matches!(d, GuiDraw::Fill { x0: -4, x1: -2, .. }))
}
    // rust: assert!(bar(&plain));
    // rust: chat.hide_indicator = true;
    // rust: assert!(!bar(&chat.layout(361, 0.0, false)));
}

clicking_seed_copies_the_raw_value_only_inside_the_link :: proc() {
}
    // rust: let font = font();
    // rust: for seed in [1, -42, i64::MIN, i64::MAX] {
    // rust: let mut chat = Chat::default();
    // rust: let seed_text = Text::copyable(seed.to_string()).with_color(text::GOLD);
    // rust: assert_eq!(seed_text.plain(), format!("[{seed}]"));
    // rust: assert_eq!(seed_text.spans[0].style.color, Some(text::GOLD));
    // rust: assert_eq!(seed_text.spans[1].style.color, Some(text::GREEN));
    // rust: assert_eq!(seed_text.spans[2].style.color, Some(text::GOLD));
    // rust: add(&mut chat, &font, Text::literal("Seed: ").append(seed_text));
    // rust: let expected = Some(ClickEvent::CopyToClipboard(seed.to_string()));
    // rust: let start = 4.0 + f64::from(font.width("Seed: ["));
    // rust: let end = start + f64::from(font.width(&seed.to_string()));
    // rust: assert_eq!(chat.click_at(&font, 360, start, 315.0), expected);
    // rust: assert_eq!(chat.click_at(&font, 360, end - 0.5, 315.0), expected);
    // rust: for (x, y) in [
    // rust: (start - 0.5, 315.0),
    // rust: (end, 315.0),
    // rust: (3.0, 315.0),
    // rust: (start, 320.0),
    // rust: (start, 310.0),
    // rust: ] {
    // rust: assert_eq!(chat.click_at(&font, 360, x, y), None, "{x}, {y}");
}
}
}

click_targets_match_rendered_spans_when_scaled_wrapped_and_scrolled :: proc() {
}
    // rust: let font = font();
    // rust: let screenshot = ClickEvent::OpenFile("/tmp/My screenshots/世界.png".into());
    // rust: for scale in [0.5, 0.75, 1.0] {
    // rust: for line_spacing in [0.0, 0.5, 1.0] {
    // rust: let mut chat = Chat::default();
    // rust: chat.options.scale = scale;
    // rust: chat.options.width = 0.0;
    // rust: chat.options.line_spacing = line_spacing;
    // rust: for _ in 0..20 {
    // rust: add(
    // rust: &mut chat,
    // rust: &font,
    // rust: Text::literal("Saved screenshot as ").append(Text::styled(
    // rust: "2026-10-14_18.55.14.png",
    // rust: Style {
    // rust: click: Some(screenshot.clone()),
    // rust: bold: Some(true),
    // rust: underlined: Some(true),
    // rust: ..Style::default()
    // rust: },
    // rust: )),
    // rust: );
}
    // rust: for scroll in [0, 3, 12] {
    // rust: chat.scroll = scroll;
    // rust: let mut links = 0;
    // rust: for draw in chat.layout(361, 0.0, true) {
    // rust: if let GuiDraw::Text { text, x, y, .. } = draw {
    // rust: let mut at = x as f64;
    // rust: for (c, style) in text.chars() {
    // rust: let width = f64::from(font.advance(c, style));
    // rust: let cursor_x = (4.0 + at + width / 2.0) * scale;
    // rust: let cursor_y = (y as f64 + 3.0) * scale;
    // rust: assert_eq!(
    // rust: chat.click_at(&font, 361, cursor_x, cursor_y),
    // rust: style.click,
    // rust: "scale={scale}, spacing={line_spacing}, scroll={scroll}, char={c}"
    // rust: );
    // rust: links += usize::from(style.click.is_some());
    // rust: at += width;
}
}
}
    // rust: assert!(links > 0);
                // The history above the focused viewport is not clickable.
    // rust: let top = ((361 - 40) as f64 / scale).floor()
    // rust: - chat.lines_per_page(true) as f64 * chat.options.line_height() as f64;
    // rust: assert_eq!(
    // rust: chat.click_at(&font, 361, 10.0 * scale, (top - 1.0) * scale),
    // rust: None
    // rust: );
}
}
}
}

locate_coordinates_fill_chat_with_teleport_without_submitting :: proc() {
}
    // rust: let font = font();
    // rust: let m = Measure(&font);
    // rust: let registries = Registries::default();
    // rust: let commands = Commands {
    // rust: dispatcher: crate::command::vanilla::game_dispatcher(),
    // rust: registries: &registries,
}
    // Structures and POIs use relative Y; biome results include absolute Y.
    // rust: for (y, expected) in [
    // rust: (None, "/tp @s -1136 ~ 848"),
    // rust: (Some(73), "/tp @s -1136 73 848"),
    // rust: ] {
    // rust: let link = Text::teleport_link(-1136, y, 848);
    // rust: assert_eq!(link.component()["click_event"]["action"], "suggest_command");
    // rust: assert_eq!(link.component()["click_event"]["command"], expected);
    // rust: let mut chat = Chat::default();
    // rust: add(&mut chat, &font, Text::literal("Found at ").append(link));
    // rust: let mut screen = ChatScreen::new(&m, &commands, "draft", 0, 640, 360, full());
    // rust: let x = 4.0 + f64::from(font.width("Found at "));
    // rust: assert!(!screen.click(&m, &commands, x, 315.0));
    // rust: let Some(ClickEvent::SuggestCommand(command)) = chat.click_at(&font, 360, x, 315.0) else {
    // rust: panic!("locate coordinates must suggest a command");
}
    // rust: screen.suggest_command(&m, &commands, &command);
    // rust: assert_eq!(screen.value(), expected);
    // rust: assert_eq!(screen.input.cursor, expected.chars().count());
    // rust: assert_eq!(screen.input.highlight, screen.input.cursor);
        // Submission is a separate, explicit Enter press.
    // rust: assert_eq!(
    // rust: screen.key(
    // rust: &m,
    // rust: &commands,
    // rust: &[],
    // rust: winit::keyboard::KeyCode::Enter,
    // rust: false,
    // rust: false
    // rust: ),
    // rust: ChatAction::Submit(expected.to_owned())
    // rust: );
}
}

history_arrows_recall_messages_and_restore_the_draft :: proc() {
}
//     use winit::keyboard::KeyCode::{ArrowDown, ArrowUp};

    // rust: let font = font();
    // rust: let m = Measure(&font);
    // rust: let registries = Registries::default();
    // rust: let commands = Commands {
    // rust: dispatcher: crate::command::vanilla::game_dispatcher(),
    // rust: registries: &registries,
}
    // rust: let history = vec!["first message".to_owned(), "latest message".to_owned()];
    // rust: let mut screen = ChatScreen::new(
    // rust: &m,
    // rust: &commands,
    // rust: "unfinished draft",
    // rust: history.len(),
    // rust: 640,
    // rust: 360,
    // rust: full(),
    // rust: );
    // rust: for (key, expected) in [
    // rust: (ArrowUp, "latest message"),
    // rust: (ArrowUp, "first message"),
    // rust: (ArrowUp, "first message"),
    // rust: (ArrowDown, "latest message"),
    // rust: (ArrowDown, "unfinished draft"),
    // rust: (ArrowDown, "unfinished draft"),
    // rust: ] {
    // rust: assert_eq!(
    // rust: screen.key(&m, &commands, &history, key, false, false),
    // rust: ChatAction::None
    // rust: );
    // rust: assert_eq!(screen.value(), expected);
}
}

mod_commands_are_coloured_and_complete_like_vanilla_ones :: proc() {
}
    // rust: let font = font();
    // rust: let m = Measure(&font);
    // Allow Commands off: a mod's command needs no level.
    // rust: let registries = Registries::default();
    // rust: let vanilla = crate::command::vanilla::game_dispatcher();
    // rust: let modded = vanilla.with_mod_commands(["where", "coords"]);
    // rust: let red = |screen: &ChatScreen| {
    // rust: screen
    // rust: .format(screen.value(), 0)
    // rust: .spans
    // rust: .iter()
    // rust: .any(|s| s.style.color == Some(text::RED))
}
    // rust: let typed = |dispatcher: &crate::command::Dispatcher, line: &str| {
    // rust: let c = Commands {
    // rust: dispatcher,
    // rust: registries: &registries,
}
    // rust: let mut screen = ChatScreen::new(&m, &c, "", 0, 640, 360, full());
    // rust: screen.type_text(&m, &c, line);
    // rust: screen
}
    // Unknown without the mod's tree (#456).
    // rust: assert!(red(&typed(vanilla, "/coords")));
    // rust: for line in ["/coords", "/where", "/where me and you"] {
    // rust: assert!(!red(&typed(&modded, line)), "{line}");
}
    // rust: let c = Commands {
    // rust: dispatcher: &modded,
    // rust: registries: &registries,
}
    // rust: let mut screen = typed(&modded, "/coo");
    // rust: screen.key(&m, &c, &[], winit::keyboard::KeyCode::Tab, false, false);
    // rust: assert_eq!(screen.value(), "/coords");
}

chat_completes_the_servers_custom_completions_with_the_players :: proc() {
}
    // CommandSuggestions.updateCommandInfo completes chat from
    // ClientSuggestionProvider.getCustomTabSuggestions: the online players
    // and what ClientboundCustomChatCompletionsPacket added.
//     use crate::command::{CustomCompletionAction as Action, modify_custom_completions};
    // rust: let font = font();
    // rust: let m = Measure(&font);
    // rust: let mut registries = Registries {
    // rust: players: vec!["Steve".into()],
    // rust: ..Registries::default()
}
    // rust: let entries = |e: &[&str]| e.iter().map(|s| s.to_string()).collect::<Vec<_>>();
    // rust: let set = &mut registries.custom_completions;
    // rust: modify_custom_completions(set, Action::from_id(0), &entries(&["Alex", "#trade"]));
    // rust: modify_custom_completions(set, Action::Add, &entries(&["Notch", "Steve"]));
    // rust: modify_custom_completions(set, Action::Remove, &entries(&["Alex"]));
    // An id past the last action is ADD (OutOfBoundsStrategy.ZERO).
    // rust: modify_custom_completions(set, Action::from_id(7), &entries(&["Zuri"]));
    // rust: assert_eq!(
    // rust: registries
    // rust: .custom_tab_suggestions()
    // rust: .into_iter()
    // rust: .collect::<Vec<_>>(),
    // rust: ["#trade", "Notch", "Steve", "Zuri"]
    // rust: );
    // rust: let completed = |registries: &Registries, line: &str| {
    // rust: let dispatcher = crate::command::vanilla::game_dispatcher();
    // rust: let c = Commands {
    // rust: dispatcher,
    // rust: registries,
}
    // rust: let mut screen = ChatScreen::new(&m, &c, "", 0, 640, 360, full());
    // rust: screen.type_text(&m, &c, line);
        // Chat shows no list by itself: Tab shows it, Tab again uses it.
    // rust: for _ in 0..2 {
    // rust: screen.key(&m, &c, &[], winit::keyboard::KeyCode::Tab, false, false);
}
    // rust: screen.value().to_owned()
}
    // rust: assert_eq!(completed(&registries, "hi no"), "hi Notch");
    // rust: assert_eq!(completed(&registries, "sell #tr"), "sell #trade");
    // rust: assert_eq!(completed(&registries, "hi st"), "hi Steve");
    // rust: assert_eq!(completed(&registries, "hi al"), "hi al");
    // SET replaces them all; the players stay.
    // rust: let set = &mut registries.custom_completions;
    // rust: modify_custom_completions(set, Action::Set, &entries(&["Alex"]));
    // rust: assert_eq!(completed(&registries, "hi no"), "hi no");
    // rust: assert_eq!(completed(&registries, "hi al"), "hi Alex");
    // rust: assert_eq!(completed(&registries, "hi st"), "hi Steve");
}

ask_server_nodes_wait_for_the_servers_completions :: proc() {
}
    // ClientSuggestionProvider.customSuggestion: an `ask_server` node at the
    // cursor sends the command so far, and the list is done with the reply.
    // rust: let font = font();
    // rust: let m = Measure(&font);
    // rust: let registries = Registries {
    // rust: permission: 4,
    // rust: ..Registries::default()
}
    // rust: let mut d = crate::command::vanilla::game_dispatcher().clone();
    // rust: let child = |d: &crate::command::Dispatcher, n: usize, name: &str| {
    // rust: d.nodes[n]
    // rust: .children
    // rust: .iter()
    // rust: .copied()
    // rust: .find(|&c| d.nodes[c].name() == name)
    // rust: .expect(name)
}
    // rust: let id = child(&d, child(&d, child(&d, 0, "bossbar"), "get"), "id");
    // rust: d.nodes[id].suggests = Some(crate::command::Suggests::AskServer);
    // rust: let c = Commands {
    // rust: dispatcher: &d,
    // rust: registries: &registries,
}
    // rust: let tab = |screen: &mut ChatScreen| {
    // rust: screen.key(&m, &c, &[], winit::keyboard::KeyCode::Tab, false, false);
}
    // rust: let mut screen = ChatScreen::new(&m, &c, "", 0, 640, 360, full());
    // rust: screen.type_text(&m, &c, "/bossbar get pt");
    // rust: let (request, sent) = screen.take_request().expect("the server is asked");
    // rust: assert_eq!(sent, "/bossbar get pt");
    // rust: assert_eq!(screen.take_request(), None);
    // Nothing to complete until the reply.
    // rust: tab(&mut screen);
    // rust: assert_eq!(screen.value(), "/bossbar get pt");
    // A reply to an older request is dropped; the range is in UTF-16 units.
    // rust: let reply = |text: &str| vec![(text.to_owned(), None)];
    // rust: screen.server_suggestions(&m, &c, request - 1, (13, 2), reply("pt6:old"));
    // rust: tab(&mut screen);
    // rust: assert_eq!(screen.value(), "/bossbar get pt");
    // rust: screen.server_suggestions(&m, &c, request, (13, 2), reply("pt6:check"));
    // rust: tab(&mut screen);
    // rust: assert_eq!(screen.value(), "/bossbar get pt6:check");
    // Without the server's provider the local list is done at once.
    // rust: let local = crate::command::vanilla::game_dispatcher();
    // rust: let c = Commands {
    // rust: dispatcher: local,
    // rust: registries: &registries,
}
    // rust: let mut screen = ChatScreen::new(&m, &c, "", 0, 640, 360, full());
    // rust: screen.type_text(&m, &c, "/bossbar get pt");
    // rust: assert_eq!(screen.take_request(), None);
}

legacy_codes_colour_the_line_or_vanish_without_chat_colours :: proc() {
}
    // rust: let mut chat = Chat::default();
    // rust: let red = Text::literal("\u{a7}cRED");
    // rust: let shown = chat.displayed(&red);
    // rust: assert_eq!(shown.plain(), "RED");
    // rust: assert!(shown.chars().all(|(_, s)| s.color == Some(0xFF5555)));
    // rust: chat.options.colors = false;
    // rust: let shown = chat.displayed(&red);
    // rust: assert_eq!(shown.plain(), "RED");
    // rust: assert!(shown.chars().all(|(_, s)| s.color.is_none()));
    // A lone section sign or an unknown code stays as written.
    // rust: assert_eq!(
    // rust: chat.displayed(&Text::literal("a\u{a7}zb")).plain(),
    // rust: "a\u{a7}zb"
    // rust: );
}

a_server_component_keeps_its_click_and_hover_events :: proc() {
}
    // rust: let font = font();
    // rust: let json = serde_json::json!({
    // rust: "text": "CLICK", "color": "green", "bold": true,
    // rust: "click_event": {"action": "suggest_command", "command": "/say clicked"},
    // rust: "hover_event": {"action": "show_text", "value": {"text": "Tip", "color": "aqua"}},
    // rust: });
    // rust: let line = crate::component::to_text(&json, &mut |s| Text::literal(s));
    // rust: let mut chat = Chat::default();
    // rust: add(&mut chat, &font, line);
    // rust: let x = 4.0 + f64::from(font.width("CL"));
    // rust: let Some(ClickEvent::SuggestCommand(command)) = chat.click_at(&font, 360, x, 315.0) else {
    // rust: panic!("the line must suggest its command");
}
    // rust: assert_eq!(command, "/say clicked");
    // rust: let hover = chat.hover_at(&font, 360, x, 315.0).expect("a hover text");
    // rust: assert_eq!(hover.plain(), "Tip");
    // rust: assert_eq!(hover.spans[0].style.color, Some(text::AQUA));
    // Past the (bold, so wider) text, nothing.
    // rust: let past = 4.0 + f64::from(font.width("CLICK")) + 20.0;
    // rust: assert!(chat.hover_at(&font, 360, past, 315.0).is_none());
}

// `ChatVisiblity`: Commands Only keeps the chat out, Hidden takes the
// commands too (`ChatAbilities`), and Enter sends nothing the option hides.
the_chat_option_decides_what_may_be_sent :: proc() {
}
    // rust: let font = font();
    // rust: let m = Measure(&font);
    // rust: let registries = Registries::default();
    // rust: let c = Commands {
    // rust: dispatcher: crate::command::vanilla::game_dispatcher(),
    // rust: registries: &registries,
}
    // rust: let enter = |screen: &mut ChatScreen| {
    // rust: screen.key(&m, &c, &[], winit::keyboard::KeyCode::Enter, false, false)
}
    // rust: for (visibility, chat, command) in [
    // rust: (ChatVisibility::Full, true, true),
    // rust: (ChatVisibility::System, false, true),
    // rust: (ChatVisibility::Hidden, false, false),
    // rust: ] {
    // rust: let abilities = ChatAbilities::new(visibility);
    // rust: assert_eq!(abilities.allows("hi"), chat, "{visibility:?}");
    // rust: assert_eq!(abilities.allows("/time set day"), command, "{visibility:?}");
    // rust: for (line, allowed) in [("hi", chat), ("/time set day", command)] {
    // rust: let mut screen = ChatScreen::new(&m, &c, "", 0, 640, 360, abilities);
    // rust: screen.type_text(&m, &c, line);
    // rust: match enter(&mut screen) {
    // rust: ChatAction::Submit(sent) => {
    // rust: assert!(allowed, "{visibility:?} sent {sent}");
    // rust: assert_eq!(sent, line);
}
    // rust: ChatAction::None => assert!(!allowed, "{visibility:?} kept {line}"),
    // rust: ChatAction::Close => panic!("Enter does not close the chat"),
}
}
}
}

// The restriction the option sets is a usage line: red, under the input, for
// a command the Chat option takes and for a message it takes.
restricted_input_says_why_it_will_not_send :: proc() {
}
    // rust: let font = font();
    // rust: let m = Measure(&font);
    // rust: let registries = Registries::default();
    // rust: let c = Commands {
    // rust: dispatcher: crate::command::vanilla::game_dispatcher(),
    // rust: registries: &registries,
}
    // rust: let usage = |visibility, line: &str| {
    // rust: let mut screen = ChatScreen::new(&m, &c, "", 0, 640, 360, ChatAbilities::new(visibility));
    // rust: screen.type_text(&m, &c, line);
    // rust: screen.usage.iter().map(|t| t.plain()).collect::<Vec<_>>()
}
    // rust: assert_eq!(usage(ChatVisibility::Full, "hi"), Vec::<String>::new());
    // The font has no language files here, so the line is its key.
    // rust: assert_eq!(
    // rust: usage(ChatVisibility::System, "hi"),
    // rust: ["chat_screen.messages_not_allowed"]
    // rust: );
    // A command the option allows says nothing about the restriction.
    // rust: assert!(
    // rust: !usage(ChatVisibility::System, "/time set day")
    // rust: .iter()
    // rust: .any(|line| line == "chat_screen.commands_not_allowed")
    // rust: );
    // rust: assert!(
    // rust: usage(ChatVisibility::Hidden, "/time set day")
    // rust: .iter()
    // rust: .any(|line| line == "chat_screen.commands_not_allowed")
    // rust: );
}

// `ChatComponent.setVisibleMessageFilter`: a message the Chat option hides
// on arrival is dropped; one already in the chat leaves it while the option
// hides its kind and comes back when it shows it again.
the_chat_option_filters_the_lines_both_ways :: proc() {
}
    // rust: let font = font();
    // rust: let mut chat = Chat::default();
    // rust: let says = |chat: &mut Chat, text: &str, source| {
    // rust: chat.add_message(&font, Text::literal(text), None, source, 0, false);
}
    // rust: let shown =
    // rust: |chat: &Chat| -> Vec<String> { chat.lines.iter().map(|l| l.content.plain()).collect() };
    // rust: says(&mut chat, "player", ChatSource::Player);
    // rust: says(&mut chat, "server", ChatSource::Server);
    // rust: chat.set_abilities(&font, ChatAbilities::new(ChatVisibility::System));
    // rust: assert_eq!(shown(&chat), ["server"]);
    // rust: says(&mut chat, "dropped", ChatSource::Player);
    // rust: chat.set_abilities(&font, ChatAbilities::new(ChatVisibility::Hidden));
    // rust: says(&mut chat, "client", ChatSource::Client);
    // rust: assert_eq!(shown(&chat), ["client"]);
    // rust: chat.set_abilities(&font, ChatAbilities::new(ChatVisibility::Full));
    // rust: assert_eq!(shown(&chat), ["client", "server", "player"]);
}

// A server's own chat: a guest's line is a player message, so the
// Chat option's player-message permission hides it at Commands Only and
// Hidden; command feedback (`/list`, `/tp`) is a system message and stays
// at Commands Only.
a_guests_line_follows_the_player_message_permission :: proc() {
}
    // rust: let font = font();
    // rust: let shown = |visibility, source| {
    // rust: let mut chat = Chat::default();
    // rust: chat.set_abilities(&font, ChatAbilities::new(visibility));
    // rust: chat.add_message(&font, Text::literal("line"), None, source, 0, false);
    // rust: chat.messages.len()
}
    // rust: for (visibility, player, system) in [
    // rust: (ChatVisibility::Full, 1, 1),
    // rust: (ChatVisibility::System, 0, 1),
    // rust: (ChatVisibility::Hidden, 0, 0),
    // rust: ] {
    // rust: assert_eq!(
    // rust: shown(visibility, ChatSource::Player),
    // rust: player,
    // rust: "{visibility:?}"
    // rust: );
    // rust: assert_eq!(
    // rust: shown(visibility, ChatSource::Server),
    // rust: system,
    // rust: "{visibility:?}"
    // rust: );
}
}

// `ChatComponent.deleteMessageOrDelay`: a deleted message shows for 60
// ticks from when it was added, then becomes the grey italic
// `chat.deleted_marker` line with the system bar; the other lines stay.
a_deleted_message_shows_60_ticks_then_becomes_the_marker :: proc() {
}
    // rust: let font = font();
    // rust: let mut chat = Chat::default();
    // rust: let secret = [7; 256];
    // rust: chat.add_signed_message(
    // rust: &font,
    // rust: Text::literal("<Steve> secret"),
    // rust: Some(secret),
    // rust: 100,
    // rust: false,
    // rust: );
    // rust: chat.add_signed_message(
    // rust: &font,
    // rust: Text::literal("<Alex> hi"),
    // rust: Some([8; 256]),
    // rust: 110,
    // rust: false,
    // rust: );
    // rust: let lines =
    // rust: |chat: &Chat| -> Vec<String> { chat.lines.iter().map(|l| l.content.plain()).collect() };
    // rust: let marker = Chat::deleted_marker().plain();
    // rust: chat.delete_message_with(&font, &secret, 130);
    // rust: assert_eq!(
    // rust: lines(&chat),
    // rust: ["<Alex> hi", "<Steve> secret"],
    // rust: "too new: delayed"
    // rust: );
    // rust: chat.process_deletions(&font, 159);
    // rust: assert_eq!(lines(&chat), ["<Alex> hi", "<Steve> secret"]);
    // rust: chat.process_deletions(&font, 160);
    // rust: assert_eq!(lines(&chat), ["<Alex> hi".to_owned(), marker.clone()]);
    // rust: assert!(chat.deletions.is_empty());
    // rust: let line = &chat.lines[1];
    // rust: assert_eq!(line.tag.as_ref().map(|t| t.color), Some(SYSTEM_INDICATOR));
    // rust: assert_eq!(line.added, 100, "the marker keeps the message's time");
    // rust: assert!(
    // rust: line.content
    // rust: .spans
    // rust: .iter()
    // rust: .all(|s| s.style.color == Some(text::GRAY) && s.style.is_italic())
    // rust: );
    // rust: assert_eq!(
    // rust: chat.messages[1].content.translation_key(),
    // rust: Some("chat.deleted_marker")
    // rust: );
    // A message shown 60 ticks already is replaced at once; an unknown or
    // already deleted signature changes nothing.
    // rust: chat.delete_message_with(&font, &[8; 256], 170);
    // rust: assert_eq!(lines(&chat), [marker.clone(), marker.clone()]);
    // rust: chat.delete_message_with(&font, &secret, 200);
    // rust: chat.delete_message_with(&font, &[9; 256], 200);
    // rust: assert_eq!(lines(&chat), [marker.clone(), marker]);
    // rust: assert!(chat.deletions.is_empty());
}

// `SuggestionsList.select` says an entry once (`lastNarratedEntry`), as
// "suggestion N out of M", with its tooltip when it has one.
a_suggestion_is_narrated_by_its_place_once :: proc() {
}
    // rust: let suggestion = |text: &str, tooltip: Option<&str>| Suggestion {
    // rust: range: (1, 1),
    // rust: text: text.into(),
    // rust: tooltip: tooltip.map(str::to_owned),
    // rust: int_value: None,
}
    // rust: let mut l = SuggestionList {
    // rust: rect: [0; 4],
    // rust: original: "/".into(),
    // rust: list: vec![
    // rust: suggestion("give", None),
    // rust: suggestion("gamemode", Some("Mode")),
    // rust: ],
    // rust: offset: 0,
    // rust: current: 1,
    // rust: last_mouse: (0, 0),
    // rust: tab_cycles: false,
    // rust: last_narrated: 0,
}
    // rust: let said = l.narration_message().component();
    // rust: assert_eq!(l.last_narrated, 1);
    // rust: assert_eq!(said["translate"], "narration.suggestion.tooltip");
    // rust: assert_eq!(said["with"].as_array().map(Vec::len), Some(4));
    // rust: l.current = 0;
    // rust: let said = l.narration_message().component();
    // rust: assert_eq!(said["translate"], "narration.suggestion");
    // rust: assert_eq!(said["with"].as_array().map(Vec::len), Some(3));
}

a_chat_message_is_trimmed_and_its_whitespace_runs_collapsed :: proc() {
}
    // ChatScreen.normalizeChatMessage: String.trim, then StringUtils
    // .normalizeSpace, so a command gets the arguments the player meant.
    // rust: assert_eq!(normalize_chat_message("  hello   there  "), "hello there");
    // rust: assert_eq!(normalize_chat_message("/msg  Alex\thi"), "/msg Alex hi");
    // rust: assert_eq!(normalize_chat_message("a\n\nb\r\nc"), "a b c");
    // rust: assert_eq!(normalize_chat_message("\t \n"), "");
    // rust: assert_eq!(normalize_chat_message(""), "");
    // Character.isWhitespace is not str::trim's Unicode whitespace: U+00A0 is
    // no Java whitespace, so it is neither trimmed nor collapsed, while the
    // ideographic space U+3000 and Java's U+001C separators are.
    // rust: assert_eq!(normalize_chat_message(" \u{a0} hi"), "\u{a0} hi");
    // rust: assert_eq!(normalize_chat_message("a\u{a0}\u{a0}b"), "a\u{a0}\u{a0}b");
    // rust: assert_eq!(normalize_chat_message("a\u{3000}\u{3000}b"), "a b");
    // rust: assert_eq!(normalize_chat_message("a\u{1c}b"), "a b");
}

a_chat_message_is_cut_to_the_256_utf16_units_the_packet_holds :: proc() {
}
    // StringUtil.trimChatMessage counts String.length(), UTF-16 code units:
    // 256 ASCII characters are all kept, 257 are cut to 256.
    // rust: assert_eq!(normalize_chat_message(&"a".repeat(256)).len(), 256);
    // rust: assert_eq!(normalize_chat_message(&"a".repeat(300)).len(), 256);
    // An emoji is two units, so 128 of them fill the packet and the 129th is
    // dropped: chars().take(256) would keep all 129 and the server would
    // reject the message.
    // rust: let emoji = normalize_chat_message(&"\u{1f600}".repeat(129));
    // rust: assert_eq!(emoji, "\u{1f600}".repeat(128));
    // rust: assert_eq!(emoji.encode_utf16().count(), 256);
    // A cut between the halves of a pair keeps the character below it.
    // rust: let mixed = format!("{}\u{1f600}", "b".repeat(255));
    // rust: assert_eq!(normalize_chat_message(&mixed), "b".repeat(255));
}

// PvP & HUD's chat options: the time before each message, and a repeated message counted on
// its own lines instead of filling the chat.
timestamps_and_compact_chat_change_the_lines_not_the_messages :: proc() {
}
    // rust: let font = font();
    // rust: let mut chat = Chat {
    // rust: clock: Some((9, 5)),
    // rust: ..Chat::default()
}
    // rust: chat.qol.compact = true;
    // rust: let says = |chat: &mut Chat, text: &str| {
    // rust: chat.add_message(
    // rust: &font,
    // rust: Text::literal(text),
    // rust: None,
    // rust: ChatSource::Server,
    // rust: 0,
    // rust: false,
    // rust: );
}
    // rust: let shown =
    // rust: |chat: &Chat| -> Vec<String> { chat.lines.iter().map(|l| l.content.plain()).collect() };
    // rust: says(&mut chat, "gg");
    // rust: says(&mut chat, "gg");
    // rust: says(&mut chat, "gg");
    // rust: assert_eq!(shown(&chat), ["gg (x3)"]);
    // rust: says(&mut chat, "wp");
    // rust: says(&mut chat, "gg");
    // rust: assert_eq!(shown(&chat), ["gg", "wp", "gg (x3)"]);
    // rust: assert_eq!(chat.received, 5, "every message still counts as received");
    // rust: chat.qol.timestamps = true;
    // rust: chat.rewrap(&font);
    // rust: assert_eq!(
    // rust: shown(&chat),
    // rust: ["[09:05] gg", "[09:05] wp", "[09:05] gg (x3)"]
    // rust: );
    // Copying takes the message as it came: no time, no count.
    // rust: assert_eq!(&*chat.lines[2].message, "gg");
    // Turned off, the history shows each repeat as it was counted.
    // rust: chat.qol = ChatQol::default();
    // rust: chat.rewrap(&font);
    // rust: assert_eq!(shown(&chat), ["gg", "wp", "gg (x3)"]);
}

// PvP & HUD's chat search: only the messages holding the query show, in any case; clearing
// it brings every line back.
the_chat_search_keeps_the_matching_messages :: proc() {
}
    // rust: let font = font();
    // rust: let mut chat = Chat::default();
    // rust: for text in ["Alpha one", "beta", "ALPHABET soup"] {
    // rust: chat.add_message(
    // rust: &font,
    // rust: Text::literal(text),
    // rust: None,
    // rust: ChatSource::Server,
    // rust: 0,
    // rust: false,
    // rust: );
}
    // rust: let shown =
    // rust: |chat: &Chat| -> Vec<String> { chat.lines.iter().map(|l| l.content.plain()).collect() };
    // rust: chat.set_search_with(&font, Some("alpha"));
    // rust: assert!(chat.searching());
    // rust: assert_eq!(shown(&chat), ["ALPHABET soup", "Alpha one"]);
    // A new message that doesn't match stays out of sight until the search ends.
    // rust: chat.add_message(
    // rust: &font,
    // rust: Text::literal("gamma"),
    // rust: None,
    // rust: ChatSource::Server,
    // rust: 0,
    // rust: false,
    // rust: );
    // rust: assert_eq!(shown(&chat).len(), 2);
    // rust: chat.set_search_with(&font, Some("  "));
    // rust: assert!(!chat.searching());
    // rust: assert_eq!(
    // rust: shown(&chat),
    // rust: ["gamma", "ALPHABET soup", "beta", "Alpha one"]
    // rust: );
}

// Search and copy read a message as the chat shows it: legacy `§` codes format it, they
// aren't text.
the_chat_search_and_copy_skip_legacy_codes :: proc() {
}
    // rust: let font = font();
    // rust: let mut chat = Chat::default();
    // rust: for text in ["He§cllo", "§aplain"] {
    // rust: chat.add_message(
    // rust: &font,
    // rust: Text::literal(text),
    // rust: None,
    // rust: ChatSource::Server,
    // rust: 0,
    // rust: false,
    // rust: );
}
    // rust: assert_eq!(&*chat.lines[1].message, "Hello");
    // rust: chat.set_search_with(&font, Some("hello"));
    // rust: assert_eq!(chat.lines.len(), 1);
    // `c` and `a` are codes here, not letters of either message.
    // rust: chat.set_search_with(&font, Some("c"));
    // rust: assert_eq!(chat.lines.len(), 0);
}

// A repeat merged by compact chat leaves a reader scrolled up where they were.
a_compact_repeat_keeps_the_scrolled_view_still :: proc() {
}
    // rust: let font = font();
    // rust: let mut chat = Chat::default();
    // rust: chat.qol.compact = true;
    // rust: let says = |chat: &mut Chat, text: &str| {
    // rust: chat.add_message(
    // rust: &font,
    // rust: Text::literal(text),
    // rust: None,
    // rust: ChatSource::Server,
    // rust: 0,
    // rust: true,
    // rust: );
}
    // rust: for i in 0..60 {
    // rust: says(&mut chat, &format!("line {i}"));
}
    // rust: says(&mut chat, "gg");
    // rust: chat.scroll_by(5, true);
    // rust: assert_eq!(chat.scroll, 5);
    // rust: says(&mut chat, "gg");
    // rust: assert_eq!(chat.lines[0].content.plain(), "gg (x2)");
    // rust: assert_eq!(chat.scroll, 5);
    // A new message still pushes the view up by its line.
    // rust: says(&mut chat, "new");
    // rust: assert_eq!(chat.scroll, 6);
}
