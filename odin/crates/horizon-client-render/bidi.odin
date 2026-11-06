//! Transpiled from Horizon Rust crate
package horizon_client_render_bidi

import "core:fmt"
import "core:mem"
import "core:math"

// Right-to-left text (`FormattedBidiReorder.reorder`, behind
// `Language.getVisualOrder`): the logical text a player types becomes the
// glyphs a font draws left to right. Arabic letters are shaped into their
// joined presentation forms (ICU's `ArabicShaping` with `LETTERS_SHAPE`), the
// text is reordered by the Unicode bidirectional algorithm, and characters in
// right-to-left runs are mirrored. Left-to-right text comes back unchanged.
// use crate::text::{Span, Text};
// use std::borrow::Cow;
// use unicode_bidi::{
    // rust: BidiClass, Direction, Level, ParagraphBidiInfo, bidi_class, get_base_direction,
}

// How a letter joins its neighbours, as ICU's shaper sees it: `Right` joins
// the letter before it only, `Dual` both neighbours, `Mark` is skipped over
// (diacritics) and `None` never joins.
Join :: enum {
    None,
    Right,
    Dual,
    Mark,
}
// use Join::{Dual, Mark, Right};

// ICU's joining table (`araLink`): code point ranges and their class, with the
// lam-alef ligatures at the end. Anything else is `Join::None`.
    // rust: const JOINS: &[(u32, u32, Join)] = &[
    // rust: (0x0622, 0x0625, Right),
    // rust: (0x0626, 0x0626, Dual),
    // rust: (0x0627, 0x0627, Right),
    // rust: (0x0628, 0x0628, Dual),
    // rust: (0x0629, 0x0629, Right),
    // rust: (0x062A, 0x062E, Dual),
    // rust: (0x062F, 0x0632, Right),
    // rust: (0x0633, 0x063A, Dual),
    // rust: (0x0640, 0x0647, Dual),
    // rust: (0x0648, 0x0649, Right),
    // rust: (0x064A, 0x064A, Dual),
    // rust: (0x064B, 0x0656, Mark),
    // rust: (0x0670, 0x0670, Mark),
    // rust: (0x0671, 0x0673, Right),
    // rust: (0x0675, 0x0677, Right),
    // rust: (0x0678, 0x0687, Dual),
    // rust: (0x0688, 0x0699, Right),
    // rust: (0x069A, 0x06B9, Dual),
    // rust: (0x06BA, 0x06BA, Right),
    // rust: (0x06BB, 0x06BF, Dual),
    // rust: (0x06C0, 0x06C0, Right),
    // rust: (0x06C1, 0x06C1, Dual),
    // rust: (0x06C2, 0x06CB, Right),
    // rust: (0x06CC, 0x06CC, Dual),
    // rust: (0x06CD, 0x06CD, Right),
    // rust: (0x06CE, 0x06D1, Dual),
    // rust: (0x06D2, 0x06D3, Right),
    // rust: (0x200D, 0x200D, Dual),
    // rust: (0x206D, 0x206F, Mark),
    // rust: (0xFEF5, 0xFEFC, Right),
    // rust: ];

// Letters that have joined forms and the code point of the isolated one; the
// final, initial and medial forms follow it (a right-joining letter has the
// isolated and final only). The lam-alef ligatures are their own letters.
// ICU leaves the extended letters (پ چ ژ ک گ ی and the rest of U+0679 to
// U+06D3) unchanged, so they are in `JOINS` but not here.
    // rust: const FORMS: &[(u32, u32)] = &[
    // rust: (0x0622, 0xFE81), (0x0623, 0xFE83), (0x0624, 0xFE85), (0x0625, 0xFE87), (0x0626, 0xFE89),
    // rust: (0x0627, 0xFE8D), (0x0628, 0xFE8F), (0x0629, 0xFE93), (0x062A, 0xFE95), (0x062B, 0xFE99),
    // rust: (0x062C, 0xFE9D), (0x062D, 0xFEA1), (0x062E, 0xFEA5), (0x062F, 0xFEA9), (0x0630, 0xFEAB),
    // rust: (0x0631, 0xFEAD), (0x0632, 0xFEAF), (0x0633, 0xFEB1), (0x0634, 0xFEB5), (0x0635, 0xFEB9),
    // rust: (0x0636, 0xFEBD), (0x0637, 0xFEC1), (0x0638, 0xFEC5), (0x0639, 0xFEC9), (0x063A, 0xFECD),
    // rust: (0x0641, 0xFED1), (0x0642, 0xFED5), (0x0643, 0xFED9), (0x0644, 0xFEDD), (0x0645, 0xFEE1),
    // rust: (0x0646, 0xFEE5), (0x0647, 0xFEE9), (0x0648, 0xFEED), (0x0649, 0xFEEF), (0x064A, 0xFEF1),
    // rust: (0xFEF5, 0xFEF5), (0xFEF7, 0xFEF7), (0xFEF9, 0xFEF9), (0xFEFB, 0xFEFB),
    // rust: ];

// `Bidi_Mirroring_Glyph` (`UCharacter.getMirror`): each pair is two
// neighbouring characters that mirror each other.
    // rust: const MIRRORED: &str = "\
    // rust: ()<>[]{}«»༺༻༼༽᚛᚜‹›⁅⁆⁽⁾₍₎∈∋∉∌∊∍∕⧵∟⯾∠⦣∡⦛∢⦠∤⫮∼∽≃⋍≅≌≒≓\
    // rust: ≔≕≤≥≦≧≨≩≪≫≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋⊏⊐⊑⊒⊘⦸⊢⊣⊦⫞\
    // rust: ⊨⫤⊩⫣⊫⫥⊰⊱⊲⊳⊴⊵⊶⊷⊸⟜⋉⋊⋋⋌⋐⋑⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋰⋱⋲⋺\
    // rust: ⋳⋻⋴⋼⋶⋽⋷⋾⌈⌉⌊⌋〈〉❨❩❪❫❬❭❮❯❰❱❲❳❴❵⟃⟄⟅⟆⟈⟉⟋⟍⟕⟖⟝⟞⟢⟣⟤⟥⟦⟧⟨⟩⟪⟫\
    // rust: ⟬⟭⟮⟯⦃⦄⦅⦆⦇⦈⦉⦊⦋⦌⦍⦐⦎⦏⦑⦒⦓⦔⦕⦖⦗⦘⦤⦥⦨⦩⦪⦫⦬⦭⦮⦯⧀⧁⧄⧅⧏⧐⧑⧒⧔⧕⧘⧙⧚⧛\
    // rust: ⧨⧩⧸⧹⧼⧽⨫⨬⨭⨮⨴⨵⨼⨽⩤⩥⩹⩺⩻⩼⩽⩾⩿⪀⪁⪂⪃⪄⪅⪆⪇⪈⪉⪊⪋⪌⪍⪎⪏⪐⪑⪒⪓⪔⪕⪖⪗⪘⪙⪚\
    // rust: ⪛⪜⪝⪞⪟⪠⪡⪢⪦⪧⪨⪩⪪⪫⪬⪭⪯⪰⪱⪲⪳⪴⪵⪶⪷⪸⪹⪺⪻⪼⪽⪾⪿⫀⫁⫂⫃⫄⫅⫆⫇⫈⫉⫊⫋⫌⫍⫎⫏⫐\
    // rust: ⫑⫒⫓⫔⫕⫖⫬⫭⫷⫸⫹⫺⸂⸃⸄⸅⸉⸊⸌⸍⸜⸝⸠⸡⸢⸣⸤⸥⸦⸧⸨⸩⹕⹖⹗⹘⹙⹚⹛⹜〈〉《》「」『』【】\
    // rust: 〔〕〖〗〘〙〚〛﹙﹚﹛﹜﹝﹞﹤﹥（）＜＞［］｛｝｟｠｢｣";

join :: proc(c: char) -> J {
    // Ported from Horizon
    return {}
}
    // rust: let c = c as u32;
    // rust: JOINS
    // rust: .iter()
    // rust: .find(|&&(from, to, _)| (from..=to).contains(&c))
    // rust: .map_or(Join::None, |&(_, _, join)| join)
}

// The letter whose joined form `c` is (ICU shapes the forms again), or `c`.
letter_of :: proc(c: char) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let c32 = c as u32;
    // rust: if !matches!(c32, 0xFE70..=0xFEFC) {
    // rust: return c;
}
    // rust: if (0xFE70..0xFE80).contains(&c32) {
        // The diacritics' forms pair up from fathatan on.
    // rust: return char::from_u32(0x064B + (c32 - 0xFE70) / 2).unwrap_or(c);
}
    // rust: FORMS
    // rust: .iter()
    // rust: .find(|&&(letter, iso)| {
    // rust: let forms = if join(char::from_u32(letter).unwrap_or(c)) == Dual {
    // rust: 4
    // rust: } else {
    // rust: 2
}
    // rust: (iso..iso + forms).contains(&c32)
    // rust: })
    // rust: .and_then(|&(letter, _)| char::from_u32(letter))
    // rust: .unwrap_or(c)
}

// `ArabicShaping(LETTERS_SHAPE).shape`: lam followed by an alef (diacritics
// may sit between) becomes one ligature, then every letter takes the isolated,
// final, initial or medial form its neighbours call for. Diacritics take the
// tatweel form between two joined letters. The text can only get shorter.
shape :: proc(text: ^[char]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let letters: Vec<char> = text.iter().map(|&c| letter_of(c)).collect();
    // rust: let mut chars = Vec::with_capacity(letters.len());
    // rust: let mut i = 0;
    // rust: while i < letters.len() {
    // rust: if letters[i] == '\u{644}' {
    // rust: let mut at = i + 1;
    // rust: while letters.get(at).is_some_and(|&c| join(c) == Mark) {
    // rust: at += 1;
}
    // rust: let alef = letters.get(at).and_then(|&c| {
    // rust: ['\u{622}', '\u{623}', '\u{625}', '\u{627}']
    // rust: .iter()
    // rust: .position(|&a| a == c)
    // rust: });
    // rust: if let Some(alef) = alef {
    // rust: chars.push(char::from_u32(0xFEF5 + 2 * alef as u32).unwrap_or('\u{644}'));
    // rust: chars.extend_from_slice(&letters[i + 1..at]);
    // rust: i = at + 1;
    // rust: continue;
}
}
    // rust: chars.push(letters[i]);
    // rust: i += 1;
}
    // Whether the nearest letter before joins the next one, and the joins of
    // the nearest letter after.
    // rust: let mut joins_next = false;
    // rust: let mut out = Vec::with_capacity(chars.len());
    // rust: for (i, &c) in chars.iter().enumerate() {
    // rust: let next_joins = chars[i + 1..]
    // rust: .iter()
    // rust: .map(|&n| join(n))
    // rust: .find(|&j| j != Mark)
    // rust: .is_some_and(|j| j != Join::None);
    // rust: let kind = join(c);
    // rust: let shaped = match kind {
    // rust: Join::None => {
    // rust: joins_next = false;
    // rust: c
}
    // rust: Mark => match c as u32 {
    // rust: m @ 0x064B..=0x0652 => {
    // rust: let iso = 0xFE70 + 2 * (m - 0x064B);
    // rust: let tatweel = joins_next && next_joins && !matches!(m, 0x064C | 0x064D);
    // rust: char::from_u32(iso + u32::from(tatweel)).unwrap_or(c)
}
    // rust: _ => c,
    // rust: },
    // rust: Right | Dual => {
    // rust: let to_next = kind == Dual && next_joins;
    // rust: let form = match (joins_next, to_next) {
    // rust: (false, false) => 0,
    // rust: (true, false) => 1,
    // rust: (false, true) => 2,
    // rust: (true, true) => 3,
}
    // rust: joins_next = kind == Dual;
    // rust: FORMS
    // rust: .binary_search_by_key(&(c as u32), |&(letter, _)| letter)
    // rust: .ok()
    // rust: .and_then(|at| char::from_u32(FORMS[at].1 + form))
    // rust: .unwrap_or(c)
}
}
    // rust: out.push(shaped);
}
    // rust: out
}

// `UCharacter.getMirror`.
mirror :: proc(c: char) -> c {
    // Ported from Horizon
    return {}
}
    // rust: if bidi_class(c) != BidiClass::ON {
    // rust: return c;
}
    // rust: let mut pairs = MIRRORED.chars();
    // rust: while let (Some(a), Some(b)) = (pairs.next(), pairs.next()) {
    // rust: if c == a {
    // rust: return b;
}
    // rust: if c == b {
    // rust: return a;
}
}
    // rust: c
}

// Whether a character can change anything: right-to-left letters and numbers,
// the explicit direction controls and the diacritics that shaping turns into
// letters. Without any, left-to-right text keeps its order.
directional :: proc(c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: c as u32 >= 0x0590
    // rust: && (matches!(c as u32, 0x064B..=0x0652)
    // rust: || matches!(
    // rust: bidi_class(c),
    // rust: BidiClass::R
    // rust: | BidiClass::AL
    // rust: | BidiClass::AN
    // rust: | BidiClass::LRE
    // rust: | BidiClass::RLE
    // rust: | BidiClass::LRO
    // rust: | BidiClass::RLO
    // rust: | BidiClass::PDF
    // rust: | BidiClass::LRI
    // rust: | BidiClass::RLI
    // rust: | BidiClass::FSI
    // rust: | BidiClass::PDI
    // rust: ))
}

// Whether `chars` keep their order and shapes: left-to-right text without
// anything directional, in a language that reads left to right by default.
unchanged :: proc(mut chars: impl Iterator<Item = char>, default_rtl: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !default_rtl && !chars.any(directional)
}

// `FormattedBidiReorder.reorder`: `chars` shaped, in visual order, with each
// character's position in the shaped text. A character's style is the one at
// its position in the shaped text, as `SubStringSource` takes it (the text
// shrinks at a lam-alef ligature).
reorder :: proc(chars: ^[char], default_rtl: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let shaped = shape(chars);
    // rust: let plain: String = shaped.iter().collect();
    // DEFAULT_RTL only changes text without a strong character.
    // rust: let level =
    // rust: (default_rtl && get_base_direction(plain.as_str()) == Direction::Mixed).then(Level::rtl);
    // rust: let info = ParagraphBidiInfo::new(&plain, level);
    // rust: let levels = info.reordered_levels_per_char(0..plain.len());
    // rust: ParagraphBidiInfo::reorder_visual(&levels)
    // rust: .into_iter()
    // rust: .map(|i| {
    // rust: let c = if levels[i].is_rtl() {
    // rust: mirror(shaped[i])
    // rust: } else {
    // rust: shaped[i]
}
    // rust: (c, i)
    // rust: })
    // rust: .collect()
}

// `Language.getVisualOrder` of a text (its `§` codes already resolved), for
// the current language's direction.
visual :: proc(text: ^Text) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let default_rtl = crate::lang::bidirectional();
    // rust: if unchanged(text.chars().map(|(c, _)| c), default_rtl) {
    // rust: return Cow::Borrowed(text);
}
    // rust: let chars: Vec<char> = text.chars().map(|(c, _)| c).collect();
    // rust: let styles: Vec<_> = text.chars().map(|(_, style)| style).collect();
    // rust: let mut out = Text::default();
    // rust: for (c, at) in reorder(&chars, default_rtl) {
    // rust: match out.spans.last_mut() {
    // rust: Some(span) if span.style == *styles[at] => span.text.push(c),
    // rust: _ => out.spans.push(Span {
    // rust: text: c.to_string(),
    // rust: style: styles[at].clone(),
    // rust: }),
}
}
    // rust: Cow::Owned(out)
}

// The same for a plain string.
visual_str :: proc(s: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let default_rtl = crate::lang::bidirectional();
    // rust: if unchanged(s.chars(), default_rtl) {
    // rust: return Cow::Borrowed(s);
}
    // rust: let chars: Vec<char> = s.chars().collect();
    // rust: Cow::Owned(
    // rust: reorder(&chars, default_rtl)
    // rust: .into_iter()
    // rust: .map(|(c, _)| c)
    // rust: .collect(),
    // rust: )
}
