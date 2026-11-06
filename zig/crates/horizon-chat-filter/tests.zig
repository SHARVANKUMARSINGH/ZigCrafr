//! Transpiled from Horizon Rust crate
//! Module: horizon-chat-filter_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// The test texts spell the slurs the filter must refuse: that is what they test.
// use super::*;

pub fn filter() F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Filter::default_list()
}

pub fn the_list_compiles() void {
}
    // rust: let f = filter();
    // rust: assert!(f.len() > 30, "{} entries", f.len());
    // rust: assert_eq!(f.allowed.len(), 2);
}

pub fn normalising_catches_the_usual_disguises() void {
}
    // rust: let f = filter();
    // rust: for text in [
    // rust: "nigger",
    // rust: "NIGGER",
    // rust: "shut up nigga",
    // rust: "Niggers",
    // rust: "n1gg3r",
    // rust: "ni99a",
    // rust: "N!GGA",
    // rust: "nigg@",
    // rust: "n.i.g.g.e.r",
    // rust: "n_i_g_g_a",
    // rust: "n i g g e r",
    // rust: "n i gg a",
    // rust: "nig ger",
    // rust: "nig  gaaa",
    // rust: "niiiiggggggerrrrr",
    // rust: "ñíggér",
    // rust: "ｎｉｇｇｅｒ",
    // rust: "Niggeг",         // Cyrillic ghe for r
    // rust: "nіgger",         // Cyrillic i
    // rust: "nigg\u{0435}r",  // Cyrillic e
    // rust: "n\u{200B}igger", // a zero-width space
    // rust: "n\u{0301}igger", // a combining accent
    // rust: "𝐧𝐢𝐠𝐠𝐞𝐫",
    // rust: "ⓝⓘⓖⓖⓐ",
    // rust: "ɴɪɢɢᴀ",
    // rust: "hi nig",
    // rust: "f a g",
    // rust: "fag!",
    // rust: "you $pic",
    // rust: "FAGGOTINO-CHAN",
    // rust: "sandnigger",
    // rust: "lol kike",
    // rust: ] {
    // rust: assert!(f.matches(text), "{text:?} should be refused");
}
}

pub fn ordinary_words_pass() void {
}
    // rust: let f = filter();
    // rust: for text in [
    // rust: "hello",
    // rust: "Niger",
    // rust: "I live in Niger",
    // rust: "Nigeria and the Niger river",
    // rust: "nigerian food",
    // rust: "proud2benigerian",
    // rust: "don't snigger",
    // rust: "sniggering at that",
    // rust: "a niggardly offer",
    // rust: "knight",
    // rust: "qKnights",
    // rust: "its still night",
    // rust: "anyone able to boot the latest nightly version?",
    // rust: "i hate nighbours",
    // rust: "can someune give mi night vision",
    // rust: "suspicious stew",
    // rust: "spicy food",
    // rust: "a raccoon in a cocoon",
    // rust: "Scunthorpe",
    // rust: "bigger trigger digger",
    // rust: "gg",
    // rust: "gg ez",
    // rust: "mini gg all",
    // rust: "kniga",
    // rust: "shenanigans",
    // rust: "dignity and signing",
    // rust: "Pakistan",
    // rust: "chinking glasses",
    // rust: "the trannys? no: transmission",
    // rust: "1nicerOli",
    // rust: "ask me evernig",
    // rust: "冰淇淋",
    // rust: "привет",
    // rust: "",
    // rust: "!!!",
    // rust: ] {
    // rust: assert!(!f.matches(text), "{text:?} should pass");
}
}

pub fn a_custom_list_has_the_same_syntax() void {
}
    // rust: let f = Filter::new("# comment\n=bad\n~worse\nmeh\n!mehish*\n");
    // rust: assert!(f.matches("so bad"));
    // rust: assert!(!f.matches("badly"));
    // rust: assert!(f.matches("wor se"));
    // rust: assert!(f.matches("xxmehxx"));
    // rust: assert!(!f.matches("mehishness"));
    // rust: assert!(!f.matches("me h"));
}

pub fn guard(config: Config) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Guard::new(config, filter(), None)
}

pub const NOW: i64 = 1_793_469_939_000;
pub const MIN: i64 = 60_000;

pub fn the_second_hit_mutes_and_the_third_bans() void {
}
    // rust: let mut g = guard(Config::default());
    // rust: let id = 7;
    // rust: assert_eq!(g.strike(id, "Ann", NOW), (1, Action::Refused));
    // rust: assert_eq!(g.muted(id, NOW), None);
    // rust: let until = NOW + 3 * MIN + 10 * MIN;
    // rust: assert_eq!(
    // rust: g.strike(id, "Ann", NOW + 3 * MIN),
    // rust: (2, Action::Muted { until })
    // rust: );
    // rust: assert_eq!(g.muted(id, NOW + 4 * MIN).unwrap().until, Some(until));
    // rust: assert_eq!(g.muted(id, until), None);
    // The time spent muted doesn't count: 8 minutes after the mute ended is still within the window.
    // rust: assert_eq!(
    // rust: g.strike(id, "Ann", until + 8 * MIN),
    // rust: (
    // rust: 3,
    // rust: Action::Banned {
    // rust: until: until + 8 * MIN + 24 * 60 * MIN
}
    // rust: )
    // rust: );
    // Then it starts again.
    // rust: assert_eq!(g.strike(id, "Ann", until + 9 * MIN), (1, Action::Refused));
}

pub fn hits_far_apart_dont_add_up() void {
}
    // rust: let mut g = guard(Config::default());
    // rust: assert_eq!(g.strike(1, "Bo", NOW), (1, Action::Refused));
    // rust: assert_eq!(g.strike(1, "Bo", NOW + 11 * MIN), (1, Action::Refused));
    // Players are counted apart.
    // rust: assert_eq!(g.strike(2, "Cy", NOW + 12 * MIN), (1, Action::Refused));
}

pub fn thresholds_are_configurable() void {
}
    // rust: let mut g = guard(Config {
    // rust: mute_after: 0,
    // rust: tempban_after: 2,
    // rust: tempban_hours: 1,
    // rust: ..Config::default()
    // rust: });
    // rust: assert_eq!(g.strike(1, "Bo", NOW), (1, Action::Refused));
    // rust: assert_eq!(
    // rust: g.strike(1, "Bo", NOW + MIN),
    // rust: (
    // rust: 2,
    // rust: Action::Banned {
    // rust: until: NOW + MIN + 60 * MIN
}
    // rust: )
    // rust: );
    // rust: let mut off = guard(Config {
    // rust: mute_after: 0,
    // rust: tempban_after: 0,
    // rust: ..Config::default()
    // rust: });
    // rust: for k in 1..5 {
    // rust: assert_eq!(off.strike(1, "Bo", NOW + k), (k as u32, Action::Refused));
}
}

pub fn mutes_survive_a_restart_and_unmute_lifts_them() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("chat-filter-test-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let now = now_millis();
    // rust: let (mut g, problem) = Guard::load(Config::default(), &dir);
    // rust: assert_eq!(problem, None);
    // rust: g.strike(5, "Dee", now);
    // rust: let (_, action) = g.strike(5, "Dee", now);
    // rust: assert!(matches!(action, Action::Muted { .. }));
    // rust: let (mut again, _) = Guard::load(Config::default(), &dir);
    // rust: assert!(again.muted(5, now).is_some());
    // rust: assert_eq!(again.unmute("dee").as_deref(), Some("Dee"));
    // rust: assert_eq!(again.unmute("dee"), None);
    // rust: assert_eq!(again.muted(5, now), None);
    // An operator's mutes are kept too, with who and why.
    // rust: again.mute(6, "Eve", None, "Op", Some("spam".into()));
    // rust: again.mute(7, "Fay", Some(now + MIN), "Op", None);
    // rust: let (reloaded, _) = Guard::load(Config::default(), &dir);
    // rust: assert_eq!(reloaded.muted(5, now), None);
    // rust: let names: Vec<_> = reloaded
    // rust: .mutes(now)
    // rust: .iter()
    // rust: .map(|m| m.name.as_str())
    // rust: .collect();
    // rust: assert_eq!(names, ["Eve", "Fay"]);
    // rust: let eve = reloaded.muted(6, now).unwrap();
    // rust: assert_eq!(
    // rust: (eve.until, eve.by.as_deref(), eve.reason.as_deref()),
    // rust: (None, Some("Op"), Some("spam"))
    // rust: );
    // rust: assert_eq!(reloaded.mutes(now + MIN).len(), 1);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn a_mute_file_from_before_manual_mutes_still_loads() void {
}
    // rust: let saved: MutesFile = serde_json::from_str(
    // rust: r#"{"mutes":[{"uuid":"00000000-0000-0000-0000-000000000005","name":"Dee","until":5}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(saved.mutes[0].until, Some(5));
    // rust: assert_eq!(saved.mutes[0].by, None);
}

pub fn the_filter_never_shortens_an_operators_mute() void {
}
    // rust: let mut g = guard(Config::default());
    // rust: g.mute(1, "Bo", None, "Op", None);
    // rust: g.strike(1, "Bo", NOW);
    // rust: g.strike(1, "Bo", NOW + MIN);
    // rust: assert_eq!(
    // rust: g.muted(1, NOW + 60 * MIN).unwrap().by.as_deref(),
    // rust: Some("Op")
    // rust: );
    // A shorter one is replaced by the filter's.
    // rust: g.mute(2, "Cy", Some(NOW + MIN), "Op", None);
    // rust: g.strike(2, "Cy", NOW);
    // rust: g.strike(2, "Cy", NOW);
    // rust: assert_eq!(g.muted(2, NOW).unwrap().until, Some(NOW + 10 * MIN));
}

pub fn durations_read_and_print() void {
}
    // rust: assert_eq!(parse_duration("10m"), Some(10 * MIN));
    // rust: assert_eq!(parse_duration("2h"), Some(120 * MIN));
    // rust: assert_eq!(parse_duration("1d"), Some(24 * 60 * MIN));
    // rust: assert_eq!(parse_duration("1w"), Some(7 * 24 * 60 * MIN));
    // rust: assert_eq!(parse_duration("30s"), Some(30_000));
    // rust: for bad in [
    // rust: "",
    // rust: "m",
    // rust: "0m",
    // rust: "-1m",
    // rust: "1.5h",
    // rust: "10",
    // rust: "10x",
    // rust: "99999999999999999w",
    // rust: ] {
    // rust: assert_eq!(parse_duration(bad), None, "{bad}");
}
    // rust: assert_eq!(duration_text(61_000), "2 minutes");
    // rust: assert_eq!(duration_text(MIN), "1 minute");
    // rust: assert_eq!(duration_text(2 * 60 * MIN), "2 hours");
    // rust: assert_eq!(duration_text(24 * 60 * MIN), "24 hours");
    // rust: assert_eq!(duration_text(3 * 24 * 60 * MIN), "3 days");
}

pub fn a_missing_words_file_falls_back_to_the_built_in_list() void {
}
    // rust: let config = Config {
    // rust: words_file: "nope.txt".into(),
    // rust: ..Config::default()
}
    // rust: let (g, problem) = Guard::load(config, Path::new("/nonexistent-horizon"));
    // rust: assert!(problem.unwrap().contains("nope.txt"));
    // rust: assert!(g.filter.matches("nigger"));
}

pub fn the_section_reads_from_server_toml() void {
}
    // rust: let c = Config::from_server_toml("[server]\nport = 25565\n").unwrap();
    // rust: assert_eq!(c, Config::default());
    // rust: assert!(c.enabled);
    // rust: let c = Config::from_server_toml(
    // rust: "[chat_filter]\nenabled = true\nmute_after = 3\ntempban_after = 5\nwords_file = \"slurs.txt\"\n",
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!((c.mute_after, c.tempban_after), (3, 5));
    // rust: assert_eq!(c.words_file, "slurs.txt");
    // rust: assert!(
    // rust: !Config::from_server_toml("[chat_filter]\nenabled = false\n")
    // rust: .unwrap()
    // rust: .enabled
    // rust: );
    // rust: assert!(Config::from_server_toml("[chat_filter]\nmute = 2\n").is_err());
    // rust: assert!(Config::from_server_toml("[chat_filter]\nwindow_minutes = 0\n").is_err());
}

pub fn log_lines_have_the_time_the_player_and_the_text() void {
}
    // rust: assert_eq!(utc(0), "1970-01-01T00:00:00Z");
    // rust: assert_eq!(utc(951_782_400_000), "2000-02-29T00:00:00Z");
    // rust: assert_eq!(
    // rust: log_line(NOW, "Ann", 1, "chat", 2, Action::Muted { until: 0 }, "a\nb"),
    // rust: "2026-10-31T18:05:39Z Ann 00000000-0000-0000-0000-000000000001 chat hit 2 muted: a b"
    // rust: );
}

pub fn a_message_costs_little() void {
}
    // A long message through the whole list stays far below a tick (debug builds included).
    // rust: let f = filter();
    // rust: let text = "the quick brown fox jumps over the lazy dog ".repeat(6);
    // rust: let start = std::time::Instant::now();
    // rust: for _ in 0..1000 {
    // rust: assert!(!f.matches(&text));
}
    // rust: assert!(start.elapsed().as_millis() < 2000, "{:?}", start.elapsed());
}

pub fn an_allow_line_without_letters_allows_nothing() void {
}
    // rust: for line in ["!*", "!-*", "!", "!-"] {
    // rust: let f = Filter::new(&format!("nigger\n{line}\n"));
    // rust: assert!(f.matches("nigger"), "{line}");
}
}

pub fn duration_parts_preserve_rounding_without_overflow() void {
}
    // rust: for (millis, expected) in [
    // rust: (1, (1, DurationUnit::Minute)),
    // rust: (60_000, (1, DurationUnit::Minute)),
    // rust: (61_000, (2, DurationUnit::Minute)),
    // rust: (3_600_000, (60, DurationUnit::Minute)),
    // rust: (3_600_001, (2, DurationUnit::Hour)),
    // rust: (172_800_000, (48, DurationUnit::Hour)),
    // rust: (172_800_001, (3, DurationUnit::Day)),
    // rust: (i64::MAX, (106_751_991_168, DurationUnit::Day)),
    // rust: ] {
    // rust: assert_eq!(duration_parts(millis), expected);
}
}
