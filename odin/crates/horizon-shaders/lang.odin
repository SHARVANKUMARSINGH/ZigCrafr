//! Transpiled from Horizon Rust crate
package horizon_shaders_lang

import "core:fmt"
import "core:mem"
import "core:math"

// A pack's `lang/<locale>.lang` files (spec 8.4): `key=value` lines naming options, values,
// screens and profiles.

// use std::collections::HashMap;

// use crate::Pack;

Lang :: struct {

    // rust: impl Lang {
    // English with the player's locale over it, so a key the locale lacks still has a name.
    // File names match ignoring case: packs ship `en_US.lang` for Minecraft's `en_us`.
    // Strings keep their `§` formatting codes for the game's text renderer.
load :: proc(pack: ^Pack, locale: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let files = pack.list("lang");
    // rust: let mut lang = Self::default();
    // rust: for wanted in ["en_us", locale] {
    // rust: let file = files.iter().find(|f| {
    // rust: f.strip_suffix(".lang")
    // rust: .is_some_and(|stem| stem.eq_ignore_ascii_case(wanted))
    // rust: });
    // rust: if let Some(text) = file.and_then(|f| pack.read_text(&format!("lang/{f}"))) {
    // rust: lang.read(&text);
}
}
    // rust: lang
}

    // The names one `.lang` file's text gives.
parse :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut lang = Self::default();
    // rust: lang.read(text);
    // rust: lang
}

read :: proc(self: ^Self, text: string) {
}
    // rust: for line in text.lines().map(str::trim) {
    // rust: if line.starts_with('#') {
    // rust: continue;
}
    // rust: if let Some((key, value)) = line.split_once('=') {
    // rust: self.0
    // rust: .insert(key.trim().to_owned(), value.trim().to_owned());
}
}
}

get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0.get(key).map(String::as_str)
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::pack::tests::zip;

lang_falls_back_by_case_then_english :: proc() {
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: zip(&[
    // rust: (
    // rust: "shaders/lang/en_US.lang",
    // rust: "# names\noption.A=Alpha\noption.B = §6Beta§r\n",
    // rust: ),
    // rust: ("shaders/lang/fr_FR.lang", "option.A=Alpha (fr)\n"),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let fr = Lang::load(&pack, "fr_fr");
    // rust: assert_eq!(fr.get("option.A"), Some("Alpha (fr)"));
    // rust: assert_eq!(fr.get("option.B"), Some("§6Beta§r"));
    // rust: assert_eq!(fr.get("# names"), None);
    // rust: let de = Lang::load(&pack, "de_de");
    // rust: assert_eq!(de.get("option.A"), Some("Alpha"));
    // rust: let none = Pack::from_zip_bytes("Q.zip", zip(&[("shaders/final.fsh", "")])).unwrap();
    // rust: assert_eq!(Lang::load(&none, "en_us"), Lang::default());
}
}
