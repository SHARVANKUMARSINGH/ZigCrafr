//! Transpiled from Horizon Rust crate
package horizon_client_core_key_display

import "core:fmt"
import "core:mem"
import "core:math"

// Key display names (`InputConstants.Key.getDisplayName`), shared by key
// mappings and `keybind` text components.
// use crate::text::Text;
// use std::{collections::BTreeMap, sync::RwLock};

// The keys that write a symbol, with what they write on a US layout.
    // rust: const SYMBOLS: [(&str, &str); 11] = [
    // rust: ("key.keyboard.minus", "-"),
    // rust: ("key.keyboard.equal", "="),
    // rust: ("key.keyboard.left.bracket", "["),
    // rust: ("key.keyboard.right.bracket", "]"),
    // rust: ("key.keyboard.backslash", "\\"),
    // rust: ("key.keyboard.semicolon", ";"),
    // rust: ("key.keyboard.apostrophe", "'"),
    // rust: ("key.keyboard.grave.accent", "`"),
    // rust: ("key.keyboard.comma", ","),
    // rust: ("key.keyboard.period", "."),
    // rust: ("key.keyboard.slash", "/"),
    // rust: ];

// What the player's keyboard layout writes on each key that writes
// something, by key name, as the window reported it (`learn_layout`).
LAYOUT :: RwLock::new(BTreeMap::new())

// The keyboard layout writes `text` on the key `key` (`key.keyboard.q`):
// its name from now on, as `SDL_GetKeyFromScancode` names it with SDL's
// default keycode options. Only letter and symbol keys take it; a letter
// key keeps its Latin letter on a non-Latin layout (`latin_letters`), and
// the number row keeps its digits (`french_numbers`).
learn_layout :: proc(key: string, text: string) {
}
    // rust: let Some(rest) = key.strip_prefix("key.keyboard.") else {
    // rust: return;
}
    // rust: let mut chars = text.chars();
    // rust: let (Some(c), None) = (chars.next(), chars.next()) else {
    // rust: return;
}
    // rust: let letter_key = rest.len() == 1 && rest.as_bytes()[0].is_ascii_lowercase();
    // rust: let latin = c.is_ascii() || ('\u{C0}'..='\u{24F}').contains(&c);
    // rust: if c.is_control()
    // rust: || c.is_whitespace()
    // rust: || !(letter_key || SYMBOLS.iter().any(|(k, _)| *k == key))
    // rust: || (letter_key && c.is_alphabetic() && !latin)
    // rust: {
    // rust: return;
}
    // rust: if let Ok(mut layout) = LAYOUT.write() {
    // rust: layout.insert(key.to_owned(), c.to_uppercase().collect());
}
}

// InputConstants.Key.getDisplayName: what the layout writes on the key,
// upper-case, else the US layout's character, else by translation.
display_name :: proc(key: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(label) = LAYOUT.read().ok().and_then(|l| l.get(key).cloned()) {
    // rust: return Text::literal(label);
}
    // rust: if let Some(rest) = key.strip_prefix("key.keyboard.")
    // rust: && rest.chars().count() == 1
    // rust: {
    // rust: let c = rest.to_uppercase();
    // rust: return Text::literal(c);
}
    // rust: if let Some((_, s)) = SYMBOLS.iter().find(|(k, _)| *k == key) {
    // rust: return Text::literal(*s);
}
    // rust: if let Some(n) = key.strip_prefix("key.mouse.")
    // rust: && n.parse::<u32>().is_ok()
    // rust: && !crate::lang::has(key)
    // rust: {
    // rust: return Text::translate("key.mouse", &[Text::literal(n)]);
}
    // rust: Text::translate(key, &[])
}

    // rust: mod tests {
//     use super::*;

keys_show_what_the_layout_writes :: proc() {
}
        // The layout table is shared: these keys are this test's alone.
    // rust: assert_eq!(display_name("key.keyboard.q").plain(), "Q");
        // AZERTY: A on the Q key, M on the semicolon key, a dead ^ on the
        // left bracket, a comma on the M key.
    // rust: learn_layout("key.keyboard.q", "a");
    // rust: learn_layout("key.keyboard.semicolon", "m");
    // rust: learn_layout("key.keyboard.left.bracket", "^");
    // rust: learn_layout("key.keyboard.m", ",");
    // rust: assert_eq!(display_name("key.keyboard.q").plain(), "A");
    // rust: assert_eq!(display_name("key.keyboard.semicolon").plain(), "M");
    // rust: assert_eq!(display_name("key.keyboard.left.bracket").plain(), "^");
    // rust: assert_eq!(display_name("key.keyboard.m").plain(), ",");
        // The number row keeps its digits; a Cyrillic letter, nothing
        // printable and keys that write nothing are left alone.
    // rust: learn_layout("key.keyboard.1", "&");
    // rust: learn_layout("key.keyboard.f", "а");
    // rust: learn_layout("key.keyboard.g", "\u{8}");
    // rust: learn_layout("key.keyboard.tab", "\t");
    // rust: learn_layout("key.keyboard.h", "ab");
    // rust: assert_eq!(display_name("key.keyboard.1").plain(), "1");
    // rust: assert_eq!(display_name("key.keyboard.f").plain(), "F");
    // rust: assert_eq!(display_name("key.keyboard.g").plain(), "G");
    // rust: assert_eq!(display_name("key.keyboard.h").plain(), "H");
    // rust: assert_eq!(display_name("key.keyboard.slash").plain(), "/");
}
}
