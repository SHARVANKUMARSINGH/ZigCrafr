//! Transpiled from Horizon Rust crate
package horizon_cosmetics_prefs

import "core:fmt"
import "core:mem"
import "core:math"

// The cosmetics switches: three lines of the game's `horizon-extras.txt` (in the game's home,
// beside `options.txt`), so the launcher's Wardrobe and the game's settings read and write the
// same ones.
//
// "Show my cosmetics" is the account's, kept by the cosmetics service: its line here is what the
// player last asked for, and `cosmetics-visible.txt` what the service confirmed per account.
// While the two differ, the game (or the launcher) sends the wish again.
//
// "Other players' cosmetics" has no line until the player picks one: then it follows whether the
// signed-in account owns a cosmetic (`effective`), as the service last said (`cosmetics-owned.txt`
// per account). A player who owns none sees a vanilla game, as CONTRIBUTING.md asks of Horizon-only
// features that change the look (Ludovic, 2026-11-04).
// use std::{fs, io, path::Path};

// The game's extras file.
FILE :: "horizon-extras.txt"
// Other players' cosmetics: `shown`, `name_tags` or `hidden` (`true` and `false` from before);
// no line, not chosen yet (`effective`).
OTHERS :: "cosmeticsOthers"
// Hide other players' trails and auras: `true` or `false` (the default).
HIDE_FX :: "cosmeticsHideFx"
// The line before trails and auras existed ("show them", off): dropped when the file is saved.
OLD_AURAS :: "cosmeticsAuras"
// Show my cosmetics: `true` (the default) or `false`.
MINE :: "cosmeticsMine"
// Horizon's mark by other Horizon players' names: `true` (the default) or `false`. The game's.
MARKS :: "horizonMarks"
// Show me as a Horizon player: `true` (the default) or `false`. The game's; the launcher reads it
// to draw your name tag as others see it.
LISTED :: "horizonListed"
// What the service confirmed, a `<uuid hex>:<true|false>` line per account.
CONFIRMED :: "cosmetics-visible.txt"
// Whether the account owns a cosmetic, as the service last said: a `<uuid hex>:<true|false>`
// line per account.
OWNED :: "cosmetics-owned.txt"

// How much of other players' cosmetics this player sees.
Others :: enum {
    Shown,
    // Only their name tag styles: no models on their bodies.
    NameTags,
    // None: others look like plain players, and the game never asks what they wear.
    Hidden,
}

    // rust: impl Others {
parse :: proc(value: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match value.trim() {
    // rust: "shown" | "true" => Some(Self::Shown),
    // rust: "name_tags" => Some(Self::NameTags),
    // rust: "hidden" | "false" => Some(Self::Hidden),
    // rust: _ => None,
}
}

name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Shown => "shown",
    // rust: Self::NameTags => "name_tags",
    // rust: Self::Hidden => "hidden",
}
}

    // The next one in the game's button: shown, name tags only, hidden.
next :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Shown => Self::NameTags,
    // rust: Self::NameTags => Self::Hidden,
    // rust: Self::Hidden => Self::Shown,
}
}

    // What the player sees: what they `chose`, else everything when the account `owns` a
    // cosmetic and nothing when it doesn't (a vanilla game, no request about other players).
effective :: proc(chose: Maybe(Self), owns: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: chose.unwrap_or(if owns { Self::Shown } else { Self::Hidden })
}
}

Prefs :: struct {
    // Show my cosmetics, as last asked for.
    mine: bool,
    // None until the player chooses (`Others::effective`).
    others: Maybe(Others),
    // Hide other players' trails and auras.
    hide_fx: bool,
}

    // rust: impl Default for Prefs {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: mine: true,
    // rust: others: None,
    // rust: hide_fx: false,
}
}
}

    // rust: impl Prefs {
    // The switches in an extras file's `text`; a missing or unknown line keeps its default.
parse :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut prefs = Self::default();
    // rust: for (key, value) in text.lines().filter_map(|l| l.split_once(':')) {
    // rust: match key.trim() {
    // rust: OTHERS => prefs.others = Others::parse(value).or(prefs.others),
    // rust: HIDE_FX => prefs.hide_fx = value.trim() == "true",
    // rust: MINE => prefs.mine = value.trim() != "false",
    // rust: _ => {}
}
}
    // rust: prefs
}

    // The switches of the game whose home is `home`.
load :: proc(home: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: fs::read_to_string(home.join(FILE)).map_or_else(|_| Self::default(), |t| Self::parse(&t))
}

    // `text` with these lines set (others' only once chosen), every other line kept as it was.
write_into :: proc(self: ^Self, text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: String = text
    // rust: .lines()
    // rust: .filter(|l| {
    // rust: l.split_once(':')
    // rust: .is_none_or(|(k, _)| ![MINE, OTHERS, HIDE_FX, OLD_AURAS].contains(&k.trim()))
    // rust: })
    // rust: .flat_map(|l| [l, "\n"])
    // rust: .collect();
    // rust: out.push_str(&format!("{MINE}:{}\n", self.mine));
    // rust: if let Some(others) = self.others {
    // rust: out.push_str(&format!("{OTHERS}:{}\n", others.name()));
}
    // rust: out.push_str(&format!("{HIDE_FX}:{}\n", self.hide_fx));
    // rust: out
}

    // Saves these switches for the game in `home`, keeping the file's other settings.
save :: proc(self: ^Self, home: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let path = home.join(FILE);
    // rust: let text = match fs::read_to_string(&path) {
    // rust: Ok(text) => text,
    // rust: Err(e) if e.kind() == io::ErrorKind::NotFound => String::new(),
    // rust: Err(e) => return Err(e),
}
    // rust: fs::create_dir_all(home)?;
    // rust: fs::write(path, self.write_into(&text))
}
}

// Whether the game in `home` lets the service say its player plays Horizon (on unless off).
listed :: proc(home: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: fs::read_to_string(home.join(FILE)).map_or(true, |t| {
    // rust: !t.lines()
    // rust: .filter_map(|l| l.split_once(':'))
    // rust: .any(|(k, v)| k.trim() == LISTED && v.trim() == "false")
    // rust: })
}

// Whether the service last confirmed `uuid`'s cosmetics shown; None: never told this game.
confirmed :: proc(home: ^Path, uuid: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: read_account(home, CONFIRMED, uuid)
}

// Notes what the service confirmed for `uuid`, keeping the other accounts' lines.
set_confirmed :: proc(home: ^Path, uuid: string, visible: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: write_account(home, CONFIRMED, uuid, visible)
}

// Whether the service last said `uuid` owns a cosmetic; None: never asked from this game.
owned :: proc(home: ^Path, uuid: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: read_account(home, OWNED, uuid)
}

// Notes whether `uuid` owns a cosmetic, keeping the other accounts' lines.
set_owned :: proc(home: ^Path, uuid: string, owns: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: write_account(home, OWNED, uuid, owns)
}

// `uuid`'s line of the per-account file `name`.
read_account :: proc(home: ^Path, name: string, uuid: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let text = fs::read_to_string(home.join(name)).ok()?;
    // rust: text.lines()
    // rust: .filter_map(|l| l.split_once(':'))
    // rust: .find(|(u, _)| u.trim() == uuid)
    // rust: .map(|(_, v)| v.trim() == "true")
}

write_account :: proc(home: ^Path, name: string, uuid: string, value: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let path = home.join(name);
    // rust: let text = fs::read_to_string(&path).unwrap_or_default();
    // rust: let mut out: String = text
    // rust: .lines()
    // rust: .filter(|l| l.split_once(':').is_some_and(|(u, _)| u.trim() != uuid))
    // rust: .flat_map(|l| [l, "\n"])
    // rust: .collect();
    // rust: out.push_str(&format!("{uuid}:{value}\n"));
    // rust: fs::create_dir_all(home)?;
    // rust: fs::write(path, out)
}

// Whether the wish for `uuid` still has to reach the service: the player asked for something
// it never confirmed (shown is its default for an account it never heard about).
unsent :: proc(home: ^Path, uuid: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let wish = Prefs::load(home).mine;
    // rust: (confirmed(home, uuid).unwrap_or(true) != wish).then_some(wish)
}

    // rust: mod tests {
//     use super::*;

reads_the_old_switch_and_keeps_the_other_settings :: proc() {
}
    // rust: assert_eq!(Prefs::parse(""), Prefs::default());
    // rust: assert!(!Prefs::default().hide_fx);
        // The line from before trails and auras ("show them") hides nothing and goes on save.
    // rust: let old = "cosmeticsAuras:true\n";
    // rust: assert!(!Prefs::parse(old).hide_fx);
    // rust: assert!(!Prefs::default().write_into(old).contains("cosmeticsAuras"));
        // The game's earlier on/off line still means what it meant.
    // rust: assert_eq!(
    // rust: Prefs::parse("cosmeticsOthers:false").others,
    // rust: Some(Others::Hidden)
    // rust: );
    // rust: assert_eq!(
    // rust: Prefs::parse("cosmeticsOthers:true").others,
    // rust: Some(Others::Shown)
    // rust: );
    // rust: let text = "zoom:true\ncosmeticsOthers:false\nnoAi:true\n";
    // rust: let prefs = Prefs {
    // rust: mine: false,
    // rust: others: Some(Others::NameTags),
    // rust: hide_fx: true,
}
    // rust: let written = prefs.write_into(text);
    // rust: assert_eq!(
    // rust: written,
    // rust: "zoom:true\nnoAi:true\ncosmeticsMine:false\ncosmeticsOthers:name_tags\ncosmeticsHideFx:true\n"
    // rust: );
    // rust: assert_eq!(Prefs::parse(&written), prefs);
}

others_stay_unchosen_until_the_player_picks :: proc() {
}
        // No line, or one this game doesn't know: not chosen, and saving writes none.
    // rust: assert_eq!(Prefs::parse("zoom:true\n").others, None);
    // rust: assert_eq!(Prefs::parse("cosmeticsOthers:maybe").others, None);
    // rust: let written = Prefs::default().write_into("zoom:true\n");
    // rust: assert_eq!(
    // rust: written,
    // rust: "zoom:true\ncosmeticsMine:true\ncosmeticsHideFx:false\n"
    // rust: );
    // rust: assert_eq!(Prefs::parse(&written), Prefs::default());
        // Not chosen: everything for an owner, a vanilla game for anyone else.
    // rust: assert_eq!(Others::effective(None, true), Others::Shown);
    // rust: assert_eq!(Others::effective(None, false), Others::Hidden);
        // A choice wins either way.
    // rust: for owns in [false, true] {
    // rust: for o in [Others::Shown, Others::NameTags, Others::Hidden] {
    // rust: assert_eq!(Others::effective(Some(o), owns), o);
}
}
}

the_game_button_cycles_through_the_three :: proc() {
}
    // rust: let mut o = Others::Shown;
    // rust: let seen: Vec<Others> = (0..3)
    // rust: .map(|_| {
    // rust: o = o.next();
    // rust: o
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(seen, [Others::NameTags, Others::Hidden, Others::Shown]);
}

a_wish_waits_until_the_service_confirms_it :: proc() {
}
    // rust: let home = std::env::temp_dir().join(format!("cosmetics-prefs-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&home);
    // rust: let (alex, steve) = ("a".repeat(32), "b".repeat(32));
        // Nothing asked: shown, which the service assumes too.
    // rust: assert_eq!(unsent(&home, &alex), None);
    // rust: let hide = Prefs {
    // rust: mine: false,
    // rust: ..Prefs::default()
}
    // rust: hide.save(&home).unwrap();
    // rust: assert_eq!(unsent(&home, &alex), Some(false));
    // rust: set_confirmed(&home, &steve, true).unwrap();
    // rust: set_confirmed(&home, &alex, false).unwrap();
    // rust: assert_eq!(unsent(&home, &alex), None);
        // Each account keeps its own line; Steve's account still shows its cosmetics.
    // rust: assert_eq!(unsent(&home, &steve), Some(false));
    // rust: assert_eq!(confirmed(&home, &steve), Some(true));
        // Ownership is kept the same way, per account, in a file of its own.
    // rust: assert_eq!(owned(&home, &alex), None);
    // rust: set_owned(&home, &alex, true).unwrap();
    // rust: set_owned(&home, &steve, false).unwrap();
    // rust: set_owned(&home, &alex, false).unwrap();
    // rust: assert_eq!(
    // rust: (owned(&home, &alex), owned(&home, &steve)),
    // rust: (Some(false), Some(false))
    // rust: );
    // rust: assert_eq!(confirmed(&home, &alex), Some(false));
    // rust: let _ = fs::remove_dir_all(&home);
}
}
