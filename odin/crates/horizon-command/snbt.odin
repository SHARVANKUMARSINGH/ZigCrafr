//! Transpiled from Horizon Rust crate
package horizon_command_snbt

import "core:fmt"
import "core:mem"
import "core:math"

// SnbtGrammar and TagParser: vanilla's packrat SNBT grammar, with its
// error messages and completion suggestions, producing NBT tags.
// use super::packrat::{Grammar, Reason, State, Sugg, Term, Value, alt, ch, chs, look, opt, seq};
// use super::{CmdResult, CommandError, Reader, SuggestionsBuilder};
// use horizon_world::nbt::{Compound, JavaString, Tag};
// use std::rc::Rc;

TypeSuffix :: enum {
    Float,
    Double,
    Byte,
    Short,
    Int,
    Long,
}
Base :: enum {
    Binary,
    Decimal,
    Hex,
}
ArrayPrefix :: enum {
    Byte,
    Int,
    Long,
}
IntLit :: struct {
    minus: bool,
    base: Base,
    digits: string,
    // Some(true) signed, Some(false) unsigned.
    signed: Maybe(bool),
    ty: Maybe(TypeSuffix),
}

// The values SnbtGrammar's rules produce.
SV :: enum {
    Tag(Tag),
    Str(String),
    // A sign: true for minus.
    Sign(bool),
    Suffix(Option<bool>, Option<TypeSuffix>),
    Type(TypeSuffix),
    Int(IntLit),
    // float exponent: (minus, digits)
    Exp(bool, String),
    Prefix(ArrayPrefix),
    List(Vec<SV>),
    Entry(String, Tag),
}
    // rust: impl Value for SV {
list :: proc(items: [dynamic]Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: SV::List(items)
}
}
delayed :: proc(key: ^'static str) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Reason::Delayed(key, Vec::new())
}

can_start_number :: proc(c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(c, '+' | '-' | '.' | '0'..='9')
}

// NumberRunParseRule.
    // rust: fn number_run(
    // rust: state: &mut State<SV>,
    // rust: accept: fn(char) -> bool,
    // rust: no_value: &'static str,
    // rust: ) -> Option<SV> {
    // rust: let mut r = state.reader();
    // rust: r.skip_whitespace();
    // rust: state.set_reader(&r);
    // rust: let start = state.cursor;
    // rust: let rest = &state.input[start..];
    // rust: let len: usize = rest
    // rust: .chars()
    // rust: .take_while(|c| accept(*c))
    // rust: .map(char::len_utf8)
    // rust: .sum();
    // rust: if len == 0 {
    // rust: state.store_at_mark(delayed(no_value));
    // rust: return None;
}
    // rust: let s = &rest[..len];
    // rust: if s.starts_with('_') || s.ends_with('_') {
    // rust: state.store_at_mark(delayed("snbt.parser.underscore_not_allowed"));
    // rust: return None;
}
    // rust: state.cursor = start + len;
    // rust: Some(SV::Str(s.to_owned()))
}
// GreedyPredicateParseRule (no whitespace skipping).
    // rust: fn greedy(
    // rust: state: &mut State<SV>,
    // rust: accept: fn(char) -> bool,
    // rust: min: usize,
    // rust: max: usize,
    // rust: error: Reason,
    // rust: ) -> Option<SV> {
    // rust: let start = state.cursor;
    // rust: let rest = &state.input[start..];
    // rust: let mut len = 0;
    // rust: let mut count = 0;
    // rust: for c in rest.chars() {
    // rust: if !accept(c) || count >= max {
    // rust: break;
}
    // rust: len += c.len_utf8();
    // rust: count += c.len_utf16();
}
    // rust: if count < min {
    // rust: state.store_at_mark(error);
    // rust: return None;
}
    // rust: state.cursor = start + len;
    // rust: Some(SV::Str(rest[..len].to_owned()))
}

number_error :: proc(message: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Reason::Delayed("snbt.parser.number_parse_failure", vec![message])
}
for_input :: proc(s: string, radix: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if radix == 10 {
    // rust: format!("For input string: \"{s}\"")
    // rust: } else {
    // rust: format!("For input string: \"{s}\" under radix {radix}")
}
}
// Long.parseLong(s, radix) with its NumberFormatException messages.
parse_long :: proc(s: string, radix: u32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let digits = s.strip_prefix(['-', '+']).unwrap_or(s);
    // rust: if digits.is_empty() {
    // rust: return Err(for_input(s, radix));
}
    // rust: i64::from_str_radix(s.strip_prefix('+').unwrap_or(s), radix).map_err(|_| for_input(s, radix))
}
parse_int :: proc(s: string, radix: u32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let v = parse_long(s, radix).map_err(|_| for_input(s, radix))?;
    // rust: i32::try_from(v).map_err(|_| for_input(s, radix))
}
parse_small :: proc(s: string, radix: u32, lo: i32, hi: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let v = parse_int(s, radix)?;
    // rust: if v < lo || v > hi {
    // rust: return Err(format!("Value out of range. Value:\"{s}\" Radix:{radix}"));
}
    // rust: Ok(v)
}
parse_unsigned_int :: proc(s: string, radix: u32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if s.starts_with('-') {
    // rust: return Err(format!(
    // rust: "Illegal leading minus sign on unsigned string {s}."
    // rust: ));
}
    // rust: let len = s.chars().count();
    // rust: if len <= 5 || (radix == 10 && len <= 9) {
    // rust: return parse_int(s, radix);
}
    // rust: let v = parse_long(s, radix)?;
    // rust: if (v as u64) & 0xffff_ffff_0000_0000 == 0 {
    // rust: Ok(v as u32 as i32)
    // rust: } else {
    // rust: Err(format!("String value {s} exceeds range of unsigned int."))
}
}
parse_unsigned_long :: proc(s: string, radix: u32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if s.starts_with('-') {
    // rust: return Err(format!(
    // rust: "Illegal leading minus sign on unsigned string {s}."
    // rust: ));
}
    // rust: let digits = s.strip_prefix('+').unwrap_or(s);
    // rust: match u64::from_str_radix(digits, radix) {
    // rust: Ok(v) => Ok(v as i64),
    // rust: Err(_) => {
    // rust: if digits.chars().all(|c| c.is_digit(radix)) && !digits.is_empty() {
    // rust: Err(format!("String value {s} exceeds range of unsigned long."))
    // rust: } else {
    // rust: Err(for_input(s, radix))
}
}
}
}

    // rust: impl IntLit {
signed_or_default :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.signed.unwrap_or(self.base == Base::Decimal)
}
cleaned :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: if self.minus {
    // rust: out.push('-');
}
    // rust: out.extend(self.digits.chars().filter(|c| *c != '_'));
    // rust: out
}
    // IntegerLiteral.create with the given type.
create :: proc(self: ^Self, ty: TypeSuffix, state: ^State<SV>) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let signed = self.signed_or_default();
    // rust: if !signed && self.minus {
    // rust: state.store_at_mark(delayed("snbt.parser.expected_non_negative_number"));
    // rust: return None;
}
    // rust: let s = self.cleaned();
    // rust: let radix = match self.base {
    // rust: Base::Binary => 2,
    // rust: Base::Decimal => 10,
    // rust: Base::Hex => 16,
}
    // rust: let r = if signed {
    // rust: match ty {
    // rust: TypeSuffix::Byte => parse_small(&s, radix, -128, 127).map(|v| Tag::Byte(v as i8)),
    // rust: TypeSuffix::Short => {
    // rust: parse_small(&s, radix, -32768, 32767).map(|v| Tag::Short(v as i16))
}
    // rust: TypeSuffix::Int => parse_int(&s, radix).map(Tag::Int),
    // rust: TypeSuffix::Long => parse_long(&s, radix).map(Tag::Long),
    // rust: _ => {
    // rust: state.store_at_mark(delayed("snbt.parser.expected_integer_type"));
    // rust: return None;
}
}
    // rust: } else {
    // rust: match ty {
    // rust: TypeSuffix::Byte => parse_int(&s, radix).and_then(|v| {
    // rust: if v >> 8 == 0 {
    // rust: Ok(Tag::Byte(v as u8 as i8))
    // rust: } else {
    // rust: Err(format!("out of range: {v}"))
}
    // rust: }),
    // rust: TypeSuffix::Short => parse_int(&s, radix).and_then(|v| {
    // rust: if v >> 16 == 0 {
    // rust: Ok(Tag::Short(v as u16 as i16))
    // rust: } else {
    // rust: Err(format!("out of range: {v}"))
}
    // rust: }),
    // rust: TypeSuffix::Int => parse_unsigned_int(&s, radix).map(Tag::Int),
    // rust: TypeSuffix::Long => parse_unsigned_long(&s, radix).map(Tag::Long),
    // rust: _ => {
    // rust: state.store_at_mark(delayed("snbt.parser.expected_integer_type"));
    // rust: return None;
}
}
}
    // rust: match r {
    // rust: Ok(t) => Some(t),
    // rust: Err(m) => {
    // rust: state.store_at_mark(number_error(m));
    // rust: None
}
}
}
}

float_tag :: proc(text: string, ty: Maybe(TypeSuffix), state: ^State<SV>) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match ty {
    // rust: Some(TypeSuffix::Float) => {
    // rust: let v: f32 = text.parse().unwrap_or(f32::NAN);
    // rust: if !v.is_finite() {
    // rust: state.store_at_mark(delayed("snbt.parser.infinity_not_allowed"));
    // rust: return None;
}
    // rust: Some(Tag::Float(v.to_bits()))
}
    // rust: None | Some(TypeSuffix::Double) => {
    // rust: let v: f64 = text.parse().unwrap_or(f64::NAN);
    // rust: if !v.is_finite() {
    // rust: state.store_at_mark(delayed("snbt.parser.infinity_not_allowed"));
    // rust: return None;
}
    // rust: Some(Tag::Double(v.to_bits()))
}
    // rust: _ => {
    // rust: state.store_at_mark(delayed("snbt.parser.expected_float_type"));
    // rust: None
}
}
}

get_str :: proc(state: ^State<SV>, atom: ^'static str) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match state.scope.get(atom) {
    // rust: Some(SV::Str(s)) => Some(s),
    // rust: _ => None,
}
}
get_tag :: proc(state: ^State<SV>, atom: ^'static str) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match state.scope.get(atom) {
    // rust: Some(SV::Tag(t)) => Some(t),
    // rust: _ => None,
}
}
get_list :: proc(state: ^State<SV>, atom: ^'static str) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match state.scope.get(atom) {
    // rust: Some(SV::List(l)) => l,
    // rust: _ => Vec::new(),
}
}

hex :: proc(c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: c.is_ascii_hexdigit()
}

// SnbtGrammar.createParser over NBT.
grammar :: proc() -> G {
    // Ported from Horizon
    return {}
}
    // rust: let mut g: Grammar<SV> = Grammar::new();
    // rust: g.put_term(
    // rust: "sign",
    // rust: alt(vec![
    // rust: seq(vec![ch('+'), Term::Marker("sign", SV::Sign(false))]),
    // rust: seq(vec![ch('-'), Term::Marker("sign", SV::Sign(true))]),
    // rust: ]),
    // rust: |s| s.scope.get("sign"),
    // rust: );
    // rust: let suffix = |signed: Option<bool>, ty: TypeSuffix| {
    // rust: Term::Marker("integer_suffix", SV::Suffix(signed, Some(ty)))
}
    // rust: let types = |signed: Option<bool>| {
    // rust: alt(vec![
    // rust: seq(vec![chs('b', 'B'), suffix(signed, TypeSuffix::Byte)]),
    // rust: seq(vec![chs('s', 'S'), suffix(signed, TypeSuffix::Short)]),
    // rust: seq(vec![chs('i', 'I'), suffix(signed, TypeSuffix::Int)]),
    // rust: seq(vec![chs('l', 'L'), suffix(signed, TypeSuffix::Long)]),
    // rust: ])
}
    // rust: g.put_term(
    // rust: "integer_suffix",
    // rust: alt(vec![
    // rust: seq(vec![chs('u', 'U'), types(Some(false))]),
    // rust: seq(vec![chs('s', 'S'), types(Some(true))]),
    // rust: seq(vec![chs('b', 'B'), suffix(None, TypeSuffix::Byte)]),
    // rust: seq(vec![chs('s', 'S'), suffix(None, TypeSuffix::Short)]),
    // rust: seq(vec![chs('i', 'I'), suffix(None, TypeSuffix::Int)]),
    // rust: seq(vec![chs('l', 'L'), suffix(None, TypeSuffix::Long)]),
    // rust: ]),
    // rust: |s| s.scope.get("integer_suffix"),
    // rust: );
    // rust: g.put_custom("binary_numeral", |s| {
    // rust: number_run(
    // rust: s,
    // rust: |c| matches!(c, '0' | '1' | '_'),
    // rust: "snbt.parser.expected_binary_numeral",
    // rust: )
    // rust: });
    // rust: g.put_custom("decimal_numeral", |s| {
    // rust: number_run(
    // rust: s,
    // rust: |c| c.is_ascii_digit() || c == '_',
    // rust: "snbt.parser.expected_decimal_numeral",
    // rust: )
    // rust: });
    // rust: g.put_custom("hex_numeral", |s| {
    // rust: number_run(
    // rust: s,
    // rust: |c| c.is_ascii_hexdigit() || c == '_',
    // rust: "snbt.parser.expected_hex_numeral",
    // rust: )
    // rust: });
    // rust: let sign = g.named("sign");
    // rust: let hex_numeral = g.named("hex_numeral");
    // rust: let binary_numeral = g.named("binary_numeral");
    // rust: let decimal = g.named("decimal_numeral");
    // rust: let decimal2 = g.named("decimal_numeral");
    // rust: let isuffix = g.named("integer_suffix");
    // rust: g.put_term(
    // rust: "integer_literal",
    // rust: seq(vec![
    // rust: opt(sign),
    // rust: alt(vec![
    // rust: seq(vec![
    // rust: ch('0'),
    // rust: Term::Cut,
    // rust: alt(vec![
    // rust: seq(vec![chs('x', 'X'), Term::Cut, hex_numeral]),
    // rust: seq(vec![chs('b', 'B'), binary_numeral]),
    // rust: seq(vec![
    // rust: decimal,
    // rust: Term::Cut,
    // rust: Term::Fail(delayed("snbt.parser.leading_zero_not_allowed")),
    // rust: ]),
    // rust: Term::Marker("decimal_numeral", SV::Str("0".into())),
    // rust: ]),
    // rust: ]),
    // rust: decimal2,
    // rust: ]),
    // rust: opt(isuffix),
    // rust: ]),
    // rust: |s| {
    // rust: let (signed, ty) = match s.scope.get("integer_suffix") {
    // rust: Some(SV::Suffix(a, b)) => (a, b),
    // rust: _ => (None, None),
}
    // rust: let minus = matches!(s.scope.get("sign"), Some(SV::Sign(true)));
    // rust: let (base, digits) = if let Some(d) = get_str(s, "decimal_numeral") {
    // rust: (Base::Decimal, d)
    // rust: } else if let Some(h) = get_str(s, "hex_numeral") {
    // rust: (Base::Hex, h)
    // rust: } else {
    // rust: (
    // rust: Base::Binary,
    // rust: get_str(s, "binary_numeral").unwrap_or_default(),
    // rust: )
}
    // rust: Some(SV::Int(IntLit {
    // rust: minus,
    // rust: base,
    // rust: digits,
    // rust: signed,
    // rust: ty,
    // rust: }))
    // rust: },
    // rust: );
    // rust: g.put_term(
    // rust: "float_type_suffix",
    // rust: alt(vec![
    // rust: seq(vec![
    // rust: chs('f', 'F'),
    // rust: Term::Marker("float_type_suffix", SV::Type(TypeSuffix::Float)),
    // rust: ]),
    // rust: seq(vec![
    // rust: chs('d', 'D'),
    // rust: Term::Marker("float_type_suffix", SV::Type(TypeSuffix::Double)),
    // rust: ]),
    // rust: ]),
    // rust: |s| s.scope.get("float_type_suffix"),
    // rust: );
    // rust: let sign = g.named("sign");
    // rust: let decimal = g.named("decimal_numeral");
    // rust: g.put_term(
    // rust: "float_exponent_part",
    // rust: seq(vec![chs('e', 'E'), opt(sign), decimal]),
    // rust: |s| {
    // rust: let minus = matches!(s.scope.get("sign"), Some(SV::Sign(true)));
    // rust: Some(SV::Exp(
    // rust: minus,
    // rust: get_str(s, "decimal_numeral").unwrap_or_default(),
    // rust: ))
    // rust: },
    // rust: );
    // rust: let sign = g.named("sign");
    // rust: let mut whole = || g.named_as("decimal_numeral", "float_whole_part");
    // rust: let (w1, w2, w3) = (whole(), whole(), whole());
    // rust: let f1 = g.named_as("decimal_numeral", "float_fraction_part");
    // rust: let f2 = g.named_as("decimal_numeral", "float_fraction_part");
    // rust: let mut exp = || g.named("float_exponent_part");
    // rust: let (e1, e2, e3, e4) = (exp(), exp(), exp(), exp());
    // rust: let mut fs = || g.named("float_type_suffix");
    // rust: let (s1, s2, s3, s4) = (fs(), fs(), fs(), fs());
    // rust: g.put_term(
    // rust: "float_literal",
    // rust: seq(vec![
    // rust: opt(sign),
    // rust: alt(vec![
    // rust: seq(vec![w1, ch('.'), Term::Cut, opt(f1), opt(e1), opt(s1)]),
    // rust: seq(vec![ch('.'), Term::Cut, f2, opt(e2), opt(s2)]),
    // rust: seq(vec![w2, e3, Term::Cut, opt(s3)]),
    // rust: seq(vec![w3, opt(e4), s4]),
    // rust: ]),
    // rust: ]),
    // rust: |s| {
    // rust: let minus = matches!(s.scope.get("sign"), Some(SV::Sign(true)));
    // rust: let mut text = String::new();
    // rust: if minus {
    // rust: text.push('-');
}
    // rust: if let Some(w) = get_str(s, "float_whole_part") {
    // rust: text.extend(w.chars().filter(|c| *c != '_'));
}
    // rust: if let Some(f) = get_str(s, "float_fraction_part") {
    // rust: text.push('.');
    // rust: text.extend(f.chars().filter(|c| *c != '_'));
}
    // rust: if let Some(SV::Exp(m, d)) = s.scope.get("float_exponent_part") {
    // rust: text.push('e');
    // rust: if m {
    // rust: text.push('-');
}
    // rust: text.extend(d.chars().filter(|c| *c != '_'));
}
    // rust: let ty = match s.scope.get("float_type_suffix") {
    // rust: Some(SV::Type(t)) => Some(t),
    // rust: _ => None,
}
    // rust: float_tag(&text, ty, s).map(SV::Tag)
    // rust: },
    // rust: );
    // rust: for (name, n) in [
    // rust: ("string_hex_2", 2),
    // rust: ("string_hex_4", 4),
    // rust: ("string_hex_8", 8),
    // rust: ] {
    // rust: g.put_custom(name, move |s| {
    // rust: greedy(
    // rust: s,
    // rust: hex,
    // rust: n,
    // rust: n,
    // rust: Reason::Delayed("snbt.parser.expected_hex_escape", vec![n.to_string()]),
    // rust: )
    // rust: });
}
    // rust: g.put_custom("string_unicode_name", |s| {
    // rust: greedy(
    // rust: s,
    // rust: |c| c.is_ascii_alphanumeric() || c == '-' || c == ' ',
    // rust: 1,
    // rust: usize::MAX,
    // rust: delayed("snbt.parser.invalid_character_name"),
    // rust: )
    // rust: });
    // rust: let esc = |c: char, v: &str| {
    // rust: seq(vec![
    // rust: ch(c),
    // rust: Term::Marker("string_escape_sequence", SV::Str(v.into())),
    // rust: ])
}
    // rust: let h2 = g.named("string_hex_2");
    // rust: let h4 = g.named("string_hex_4");
    // rust: let h8 = g.named("string_hex_8");
    // rust: let un = g.named("string_unicode_name");
    // rust: g.put_term(
    // rust: "string_escape_sequence",
    // rust: alt(vec![
    // rust: esc('b', "\u{8}"),
    // rust: esc('s', " "),
    // rust: esc('t', "\t"),
    // rust: esc('n', "\n"),
    // rust: esc('f', "\u{c}"),
    // rust: esc('r', "\r"),
    // rust: esc('\\', "\\"),
    // rust: esc('\'', "'"),
    // rust: esc('"', "\""),
    // rust: seq(vec![ch('x'), h2]),
    // rust: seq(vec![ch('u'), h4]),
    // rust: seq(vec![ch('U'), h8]),
    // rust: seq(vec![ch('N'), ch('{'), un, ch('}')]),
    // rust: ]),
    // rust: |s| {
    // rust: if let Some(SV::Str(plain)) = s.scope.get_any(&["string_escape_sequence"]) {
    // rust: return Some(SV::Str(plain));
}
    // rust: if let Some(SV::Str(h)) =
    // rust: s.scope
    // rust: .get_any(&["string_hex_2", "string_hex_4", "string_hex_8"])
    // rust: {
    // rust: let cp = u32::from_str_radix(&h, 16).unwrap_or(u32::MAX);
    // rust: if cp > 0x10ffff {
    // rust: s.store_at_mark(Reason::Delayed(
    // rust: "snbt.parser.invalid_codepoint",
    // rust: vec![format!("U+{cp:08X}")],
    // rust: ));
    // rust: return None;
}
    // rust: return Some(SV::Str(
    // rust: char::from_u32(cp).unwrap_or('\u{fffd}').to_string(),
    // rust: ));
}
            // Character.codePointOf: Unicode names are not tabulated here.
    // rust: s.store_at_mark(delayed("snbt.parser.invalid_character_name"));
    // rust: None
    // rust: },
    // rust: );
    // rust: g.put_custom("string_plain_contents", |s| {
    // rust: greedy(
    // rust: s,
    // rust: |c| !matches!(c, '"' | '\'' | '\\'),
    // rust: 1,
    // rust: usize::MAX,
    // rust: delayed("snbt.parser.invalid_string_contents"),
    // rust: )
    // rust: });
    // rust: for (chunk, contents, other) in [
    // rust: (
    // rust: "single_quoted_string_chunk",
    // rust: "single_quoted_string_contents",
    // rust: '"',
    // rust: ),
    // rust: (
    // rust: "double_quoted_string_chunk",
    // rust: "double_quoted_string_contents",
    // rust: '\'',
    // rust: ),
    // rust: ] {
    // rust: let plain = g.named_as("string_plain_contents", "string_contents");
    // rust: let escape = g.named_as("string_escape_sequence", "string_contents");
    // rust: g.put_term(
    // rust: chunk,
    // rust: alt(vec![
    // rust: plain,
    // rust: seq(vec![ch('\\'), escape]),
    // rust: seq(vec![
    // rust: ch(other),
    // rust: Term::Marker("string_contents", SV::Str(other.to_string())),
    // rust: ]),
    // rust: ]),
    // rust: |s| s.scope.get("string_contents"),
    // rust: );
    // rust: let rule = g.id(chunk);
    // rust: g.put_term(
    // rust: contents,
    // rust: Term::Repeated {
    // rust: rule,
    // rust: list: "string_chunks",
    // rust: min: 0,
    // rust: },
    // rust: |s| {
    // rust: let mut out = String::new();
    // rust: for v in get_list(s, "string_chunks") {
    // rust: if let SV::Str(x) = v {
    // rust: out.push_str(&x);
}
}
    // rust: Some(SV::Str(out))
    // rust: },
    // rust: );
}
    // rust: let dq = g.named_as("double_quoted_string_contents", "string_contents");
    // rust: let sq = g.named_as("single_quoted_string_contents", "string_contents");
    // rust: g.put_term(
    // rust: "quoted_string_literal",
    // rust: alt(vec![
    // rust: seq(vec![ch('"'), Term::Cut, opt(dq), ch('"')]),
    // rust: seq(vec![ch('\''), opt(sq), ch('\'')]),
    // rust: ]),
    // rust: |s| s.scope.get("string_contents"),
    // rust: );
    // rust: g.put_custom("unquoted_string", |s| {
    // rust: let mut r = s.reader();
    // rust: r.skip_whitespace();
    // rust: s.set_reader(&r);
    // rust: let cursor = s.cursor;
    // rust: let v = r.read_unquoted_string();
    // rust: s.set_reader(&r);
    // rust: if v.is_empty() {
    // rust: s.store(
    // rust: cursor,
    // rust: Sugg::Empty,
    // rust: delayed("snbt.parser.expected_unquoted_string"),
    // rust: );
    // rust: return None;
}
    // rust: Some(SV::Str(v.to_owned()))
    // rust: });
    // rust: let literal = g.id("literal");
    // rust: g.put_term(
    // rust: "arguments",
    // rust: Term::RepeatedSep {
    // rust: rule: literal,
    // rust: list: "arguments",
    // rust: sep: Box::new(ch(',')),
    // rust: min: 0,
    // rust: trailing: true,
    // rust: },
    // rust: |s| s.scope.get("arguments"),
    // rust: );
    // rust: let uq = g.named("unquoted_string");
    // rust: let args = g.named("arguments");
    // rust: g.put_term(
    // rust: "unquoted_string_or_builtin",
    // rust: seq(vec![uq, opt(seq(vec![ch('('), args, ch(')')]))]),
    // rust: |s| {
    // rust: let contents = get_str(s, "unquoted_string").unwrap_or_default();
    // rust: let first = contents.chars().next();
    // rust: if first.is_some_and(|c| !can_start_number(c)) {
    // rust: if let Some(SV::List(arguments)) = s.scope.get("arguments") {
    // rust: return builtin(&contents, arguments, s);
}
    // rust: if contents.eq_ignore_ascii_case("true") {
    // rust: return Some(SV::Tag(Tag::Byte(1)));
}
    // rust: if contents.eq_ignore_ascii_case("false") {
    // rust: return Some(SV::Tag(Tag::Byte(0)));
}
    // rust: return Some(SV::Tag(Tag::String(JavaString::from(contents.as_str()))));
}
    // rust: let ids = ["false", "true", "bool", "uuid"].map(String::from).to_vec();
    // rust: s.store(
    // rust: s.cursor,
    // rust: Sugg::Values(Rc::new(ids)),
    // rust: delayed("snbt.parser.invalid_unquoted_start"),
    // rust: );
    // rust: None
    // rust: },
    // rust: );
    // rust: let qs = g.named("quoted_string_literal");
    // rust: let uq = g.named("unquoted_string");
    // rust: g.put_term("map_key", alt(vec![qs, uq]), |s| {
    // rust: s.scope
    // rust: .get_any(&["quoted_string_literal", "unquoted_string"])
    // rust: });
    // rust: let key = g.named("map_key");
    // rust: let lit = g.named("literal");
    // rust: g.put_term("map_entry", seq(vec![key, ch(':'), lit]), |s| {
    // rust: let key = get_str(s, "map_key").unwrap_or_default();
    // rust: if key.is_empty() {
    // rust: s.store_at_mark(delayed("snbt.parser.empty_key"));
    // rust: return None;
}
    // rust: let value = get_tag(s, "literal")?;
    // rust: Some(SV::Entry(key, value))
    // rust: });
    // rust: let entry = g.id("map_entry");
    // rust: g.put_term(
    // rust: "map_entries",
    // rust: Term::RepeatedSep {
    // rust: rule: entry,
    // rust: list: "map_entries",
    // rust: sep: Box::new(ch(',')),
    // rust: min: 0,
    // rust: trailing: true,
    // rust: },
    // rust: |s| s.scope.get("map_entries"),
    // rust: );
    // rust: let entries = g.named("map_entries");
    // rust: g.put_term("map_literal", seq(vec![ch('{'), entries, ch('}')]), |s| {
    // rust: let mut map = Compound::new();
    // rust: for e in get_list(s, "map_entries") {
    // rust: if let SV::Entry(k, v) = e {
    // rust: map.insert(JavaString::from(k.as_str()), v);
}
}
    // rust: Some(SV::Tag(Tag::Compound(map)))
    // rust: });
    // rust: g.put_term(
    // rust: "list_entries",
    // rust: Term::RepeatedSep {
    // rust: rule: literal,
    // rust: list: "list_entries",
    // rust: sep: Box::new(ch(',')),
    // rust: min: 0,
    // rust: trailing: true,
    // rust: },
    // rust: |s| s.scope.get("list_entries"),
    // rust: );
    // rust: g.put_term(
    // rust: "array_prefix",
    // rust: alt(vec![
    // rust: seq(vec![
    // rust: ch('B'),
    // rust: Term::Marker("array_prefix", SV::Prefix(ArrayPrefix::Byte)),
    // rust: ]),
    // rust: seq(vec![
    // rust: ch('L'),
    // rust: Term::Marker("array_prefix", SV::Prefix(ArrayPrefix::Long)),
    // rust: ]),
    // rust: seq(vec![
    // rust: ch('I'),
    // rust: Term::Marker("array_prefix", SV::Prefix(ArrayPrefix::Int)),
    // rust: ]),
    // rust: ]),
    // rust: |s| s.scope.get("array_prefix"),
    // rust: );
    // rust: let int_lit = g.id("integer_literal");
    // rust: g.put_term(
    // rust: "int_array_entries",
    // rust: Term::RepeatedSep {
    // rust: rule: int_lit,
    // rust: list: "int_array_entries",
    // rust: sep: Box::new(ch(',')),
    // rust: min: 0,
    // rust: trailing: true,
    // rust: },
    // rust: |s| s.scope.get("int_array_entries"),
    // rust: );
    // rust: let prefix = g.named("array_prefix");
    // rust: let ia = g.named("int_array_entries");
    // rust: let le = g.named("list_entries");
    // rust: g.put_term(
    // rust: "list_literal",
    // rust: seq(vec![
    // rust: ch('['),
    // rust: alt(vec![seq(vec![prefix, ch(';'), ia]), le]),
    // rust: ch(']'),
    // rust: ]),
    // rust: |s| {
    // rust: if let Some(SV::Prefix(p)) = s.scope.get("array_prefix") {
    // rust: let entries = get_list(s, "int_array_entries");
    // rust: return array(p, entries, s).map(SV::Tag);
}
    // rust: let items: Vec<Tag> = get_list(s, "list_entries")
    // rust: .into_iter()
    // rust: .filter_map(|v| match v {
    // rust: SV::Tag(t) => Some(t),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: Some(SV::Tag(Tag::List(items)))
    // rust: },
    // rust: );
    // rust: let float_lit = g.named_as("float_literal", "literal");
    // rust: let int_named = g.named("integer_literal");
    // rust: let quoted = g.named("quoted_string_literal");
    // rust: let map = g.named_as("map_literal", "literal");
    // rust: let list = g.named_as("list_literal", "literal");
    // rust: let builtin_term = g.named_as("unquoted_string_or_builtin", "literal");
    // rust: g.put_term(
    // rust: "literal",
    // rust: alt(vec![
    // rust: seq(vec![
    // rust: look(Term::Chars {
    // rust: values: Vec::new(),
    // rust: accept: Some(can_start_number),
    // rust: }),
    // rust: alt(vec![float_lit, int_named]),
    // rust: ]),
    // rust: seq(vec![look(chs('"', '\'')), Term::Cut, quoted]),
    // rust: seq(vec![look(ch('{')), Term::Cut, map]),
    // rust: seq(vec![look(ch('[')), Term::Cut, list]),
    // rust: builtin_term,
    // rust: ]),
    // rust: |s| {
    // rust: if let Some(q) = get_str(s, "quoted_string_literal") {
    // rust: return Some(SV::Tag(Tag::String(JavaString::from(q.as_str()))));
}
    // rust: if let Some(SV::Int(i)) = s.scope.get("integer_literal") {
    // rust: let ty = i.ty.unwrap_or(TypeSuffix::Int);
    // rust: return i.create(ty, s).map(SV::Tag);
}
    // rust: s.scope.get("literal")
    // rust: },
    // rust: );
    // rust: g.top = literal;
    // rust: g
}

array :: proc(p: ArrayPrefix, entries: [dynamic]SV, s: ^State<SV>) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (default, allowed): (TypeSuffix, &[TypeSuffix]) = match p {
    // rust: ArrayPrefix::Byte => (TypeSuffix::Byte, &[]),
    // rust: ArrayPrefix::Int => (TypeSuffix::Int, &[TypeSuffix::Byte, TypeSuffix::Short]),
    // rust: ArrayPrefix::Long => (
    // rust: TypeSuffix::Long,
    // rust: &[TypeSuffix::Byte, TypeSuffix::Short, TypeSuffix::Int],
    // rust: ),
}
    // rust: let mut values: Vec<i64> = Vec::new();
    // rust: for e in entries {
    // rust: let SV::Int(lit) = e else { continue };
    // rust: let ty = match lit.ty {
    // rust: None => default,
    // rust: Some(t) if t == default || allowed.contains(&t) => t,
    // rust: Some(_) => {
    // rust: s.store_at_mark(delayed("snbt.parser.invalid_array_element_type"));
    // rust: return None;
}
}
    // rust: let v = match lit.create(ty, s)? {
    // rust: Tag::Byte(v) => i64::from(v),
    // rust: Tag::Short(v) => i64::from(v),
    // rust: Tag::Int(v) => i64::from(v),
    // rust: Tag::Long(v) => v,
    // rust: _ => 0,
}
    // rust: values.push(v);
}
    // rust: Some(match p {
    // rust: ArrayPrefix::Byte => Tag::ByteArray(values.iter().map(|v| *v as i8 as u8).collect()),
    // rust: ArrayPrefix::Int => Tag::IntArray(values.iter().map(|v| *v as i32).collect()),
    // rust: ArrayPrefix::Long => Tag::LongArray(values),
    // rust: })
}

builtin :: proc(id: string, arguments: [dynamic]SV, s: ^State<SV>) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let args: Vec<Tag> = arguments
    // rust: .into_iter()
    // rust: .filter_map(|v| match v {
    // rust: SV::Tag(t) => Some(t),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: match (id, args.len()) {
    // rust: ("bool", 1) => {
    // rust: let b = match &args[0] {
    // rust: Tag::Byte(v) => Some(*v != 0),
    // rust: Tag::Short(v) => Some(*v != 0),
    // rust: Tag::Int(v) => Some(*v != 0),
    // rust: Tag::Long(v) => Some(*v != 0),
    // rust: Tag::Float(v) => Some(f32::from_bits(*v) != 0.0),
    // rust: Tag::Double(v) => Some(f64::from_bits(*v) != 0.0),
    // rust: _ => None,
}
    // rust: match b {
    // rust: Some(b) => Some(SV::Tag(Tag::Byte(i8::from(b)))),
    // rust: None => {
    // rust: s.store_at_mark(delayed("snbt.parser.expected_number_or_boolean"));
    // rust: None
}
}
}
    // rust: ("uuid", 1) => {
    // rust: let parsed = match &args[0] {
    // rust: Tag::String(text) => super::selector::java_uuid(&text.to_string_lossy()),
    // rust: _ => None,
}
    // rust: match parsed {
    // rust: Some(u) => Some(SV::Tag(Tag::IntArray(vec![
    // rust: (u >> 96) as u32 as i32,
    // rust: (u >> 64) as u32 as i32,
    // rust: (u >> 32) as u32 as i32,
    // rust: u as u32 as i32,
    // rust: ]))),
    // rust: None => {
    // rust: s.store_at_mark(delayed("snbt.parser.expected_string_uuid"));
    // rust: None
}
}
}
    // rust: _ => {
    // rust: s.store_at_mark(Reason::Delayed(
    // rust: "snbt.parser.no_such_operation",
    // rust: vec![format!("{id}/{}", args.len())],
    // rust: ));
    // rust: None
}
}
}

    // rust: thread_local! {
GRAMMAR :: grammar()
}

// TagParser.parseAsArgument: one SNBT value at the reader's cursor.
parse_tag_argument :: proc(reader: ^Reader) -> C {
    // Ported from Horizon
    return {}
}
    // rust: GRAMMAR.with(|g| match g.parse_for_commands(reader)? {
    // rust: SV::Tag(t) => Ok(t),
    // rust: _ => Err(CommandError::tr_at(
    // rust: "argument.nbt.expected.compound",
    // rust: &[],
    // rust: reader,
    // rust: )),
    // rust: })
}
// TagParser.parseCompoundAsArgument.
parse_compound_argument :: proc(reader: ^Reader) -> C {
    // Ported from Horizon
    return {}
}
    // rust: match parse_tag_argument(reader)? {
    // rust: Tag::Compound(c) => Ok(c),
    // rust: _ => Err(CommandError::tr_at(
    // rust: "argument.nbt.expected.compound",
    // rust: &[],
    // rust: reader,
    // rust: )),
}
}
// TagParser.parseFully.
parse_fully :: proc(text: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut reader = Reader::new(text);
    // rust: let tag = parse_tag_argument(&mut reader)?;
    // rust: reader.skip_whitespace();
    // rust: if reader.can_read() {
    // rust: return Err(CommandError::tr_at("argument.nbt.trailing", &[], &reader));
}
    // rust: Ok(tag)
}
// The grammar's completion suggestions (ParserBasedArgument.listSuggestions).
suggest :: proc(builder: ^SuggestionsBuilder) {
}
    // rust: GRAMMAR.with(|g| g.parse_for_suggestions(builder));
}
// Parse with an outer state (TagParseRule inside another grammar).
    // rust: pub fn rule_in<V: super::packrat::Value>(
    // rust: state: &mut State<V>,
    // rust: wrap: impl Fn(Tag) -> V,
    // rust: ) -> Option<V> {
    // rust: let mut r = state.reader();
    // rust: r.skip_whitespace();
    // rust: state.set_reader(&r);
    // rust: let mark = state.cursor;
    // rust: let mut reader = state.reader();
    // rust: match parse_tag_argument(&mut reader) {
    // rust: Ok(t) => {
    // rust: state.set_reader(&reader);
    // rust: Some(wrap(t))
}
    // rust: Err(e) => {
    // rust: state.store(mark, Sugg::Empty, Reason::Error(e));
    // rust: None
}
}
}

    // rust: mod tests {
//     use super::parse_fully;

    // A crafted over-deep value must be rejected, never overflow the stack.
deeply_nested_compound_is_rejected_not_overflowed :: proc() {
}
    // rust: let mut deep = String::from("1");
    // rust: for _ in 0..400 {
    // rust: deep = format!("{{a:{deep}}}");
}
    // rust: assert!(parse_fully(&deep).is_err());
}

    // The `extra` chain of a JSON text component is the same SNBT shape.
deeply_nested_list_is_rejected_not_overflowed :: proc() {
}
    // rust: let mut deep = String::from("\"x\"");
    // rust: for _ in 0..400 {
    // rust: deep = format!("[{deep}]");
}
    // rust: assert!(parse_fully(&deep).is_err());
}

    // Shallow, real command values must still parse (the cap is not too low).
shallow_values_still_parse :: proc() {
}
    // rust: assert!(parse_fully("{a:{b:{c:1}}}").is_ok());
    // rust: assert!(parse_fully("[[1,2],[3,4]]").is_ok());
}

    // Deep but real values parse: 50 nested compounds, and an item whose
    // `container` holds an item with a `container`, ten levels down.
deep_real_values_still_parse :: proc() {
}
    // rust: let mut compound = String::from("1");
    // rust: for _ in 0..50 {
    // rust: compound = format!("{{a:{compound}}}");
}
    // rust: assert!(parse_fully(&compound).is_ok());
    // rust: let mut item = String::from("{id:\"minecraft:stone\",count:1}");
    // rust: for _ in 0..10 {
    // rust: item = format!(
    // rust: "{{id:\"minecraft:shulker_box\",count:1,components:{{\"minecraft:container\":[{{slot:0,item:{item}}}]}}}}"
    // rust: );
}
    // rust: assert!(parse_fully(&item).is_ok());
}
}
