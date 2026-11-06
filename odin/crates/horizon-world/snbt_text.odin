//! Transpiled from Horizon Rust crate
package horizon_world_snbt_text

import "core:fmt"
import "core:mem"
import "core:math"

// `StringTagVisitor` (compact SNBT, `Tag.toString`) and Java's number
// formatting, below the text-component layer so that the protocol can hash
// a tag's string form.
// use crate::nbt::Tag;

// `Double.toString`.
java_double :: proc(v: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: java_float_text(v, &format!("{v}"), &format!("{v:e}"))
}
// `Float.toString`.
java_float :: proc(v: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: java_float_text(f64::from(v), &format!("{v}"), &format!("{v:e}"))
}
java_float_text :: proc(v: f64, plain: string, sci: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if v.is_nan() {
    // rust: return "NaN".into();
}
    // rust: if v.is_infinite() {
    // rust: return if v > 0.0 { "Infinity" } else { "-Infinity" }.into();
}
    // rust: if v == 0.0 {
    // rust: return if v.is_sign_negative() { "-0.0" } else { "0.0" }.into();
}
    // rust: let a = v.abs();
    // rust: if (1.0e-3..1.0e7).contains(&a) {
    // rust: if plain.contains('.') {
    // rust: plain.to_owned()
    // rust: } else {
    // rust: format!("{plain}.0")
}
    // rust: } else {
    // rust: let (mantissa, exponent) = sci.split_once('e').unwrap_or((sci, "0"));
    // rust: if !mantissa.contains('.') {
            // Java also considers two-digit decimals when one digit round-trips,
            // choosing the closest value. Padding Rust's choice loses that step
            // for tiny subnormals (Float.MIN_VALUE is 1.4E-45, not 1.0E-45).
    // rust: return format!("{v:.1e}").replace('e', "E");
}
    // rust: format!("{mantissa}E{exponent}")
}
}

// `SnbtGrammar.escapeControlCharacters`.
escape_control :: proc(c: char) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match c {
    // rust: '\u{8}' => "b",
    // rust: '\u{c}' => "f",
    // rust: '\n' => "n",
    // rust: '\r' => "r",
    // rust: '\t' => "t",
    // rust: _ => return None,
    // rust: })
}
// `StringTag.quoteAndEscape`.
quote_and_escape :: proc(input: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::from(" ");
    // rust: let mut quote = '\0';
    // rust: for c in input.chars() {
    // rust: if c == '\\' {
    // rust: out.push_str("\\\\");
    // rust: } else if c != '"' && c != '\'' {
    // rust: match escape_control(c) {
    // rust: Some(e) => {
    // rust: out.push('\\');
    // rust: out.push_str(e);
}
    // rust: None => out.push(c),
}
    // rust: } else {
    // rust: if quote == '\0' {
    // rust: quote = if c == '"' { '\'' } else { '"' };
}
    // rust: if quote == c {
    // rust: out.push('\\');
}
    // rust: out.push(c);
}
}
    // rust: if quote == '\0' {
    // rust: quote = '"';
}
    // rust: out.replace_range(0..1, &quote.to_string());
    // rust: out.push(quote);
    // rust: out
}
unquoted_key :: proc(key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if key.eq_ignore_ascii_case("true") || key.eq_ignore_ascii_case("false") {
    // rust: return false;
}
    // rust: let mut chars = key.chars();
    // rust: let first_ok = chars
    // rust: .next()
    // rust: .is_some_and(|c| c.is_ascii_alphabetic() || c == '.' || c == '_');
    // `[A-Za-z._]+[A-Za-z0-9._+-]*`
    // rust: first_ok && chars.all(|c| c.is_ascii_alphanumeric() || matches!(c, '.' | '_' | '+' | '-'))
}
string_of :: proc(t: ^crate::nbt::JavaString) -> S {
    // Ported from Horizon
    return {}
}
    // rust: t.to_string_lossy()
}

// `Tag.toString` (StringTagVisitor).
to_snbt :: proc(tag: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: visit(tag, &mut out);
    // rust: out
}
visit :: proc(tag: ^Tag, out: ^string) {
}
    // rust: match tag {
    // rust: Tag::End => out.push_str("END"),
    // rust: Tag::Byte(v) => out.push_str(&format!("{v}b")),
    // rust: Tag::Short(v) => out.push_str(&format!("{v}s")),
    // rust: Tag::Int(v) => out.push_str(&v.to_string()),
    // rust: Tag::Long(v) => out.push_str(&format!("{v}L")),
    // rust: Tag::Float(v) => {
    // rust: out.push_str(&java_float(f32::from_bits(*v)));
    // rust: out.push('f');
}
    // rust: Tag::Double(v) => {
    // rust: out.push_str(&java_double(f64::from_bits(*v)));
    // rust: out.push('d');
}
    // rust: Tag::String(s) => out.push_str(&quote_and_escape(&string_of(s))),
    // rust: Tag::ByteArray(a) => {
    // rust: out.push_str("[B;");
    // rust: out.push_str(
    // rust: &a.iter()
    // rust: .map(|v| format!("{}B", *v as i8))
    // rust: .collect::<Vec<_>>()
    // rust: .join(","),
    // rust: );
    // rust: out.push(']');
}
    // rust: Tag::IntArray(a) => {
    // rust: out.push_str("[I;");
    // rust: out.push_str(&a.iter().map(i32::to_string).collect::<Vec<_>>().join(","));
    // rust: out.push(']');
}
    // rust: Tag::LongArray(a) => {
    // rust: out.push_str("[L;");
    // rust: out.push_str(
    // rust: &a.iter()
    // rust: .map(|v| format!("{v}L"))
    // rust: .collect::<Vec<_>>()
    // rust: .join(","),
    // rust: );
    // rust: out.push(']');
}
    // rust: Tag::List(l) => {
    // rust: out.push('[');
    // rust: for (i, t) in l.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: visit(t, out);
}
    // rust: out.push(']');
}
    // rust: Tag::Compound(c) => {
    // rust: out.push('{');
    // rust: let mut entries: Vec<(String, &Tag)> =
    // rust: c.iter().map(|(k, v)| (string_of(k), v)).collect();
    // rust: entries.sort_by(|a, b| a.0.cmp(&b.0));
    // rust: for (i, (k, v)) in entries.iter().enumerate() {
    // rust: if i > 0 {
    // rust: out.push(',');
}
    // rust: if unquoted_key(k) {
    // rust: out.push_str(k);
    // rust: } else {
    // rust: out.push_str(&quote_and_escape(k));
}
    // rust: out.push(':');
    // rust: visit(v, out);
}
    // rust: out.push('}');
}
}
}

    // rust: mod tests {
//     use super::*;

scientific_text_selects_the_closest_two_digit_decimal :: proc() {
}
    // rust: for (bits, expected) in [
    // rust: (1, "1.4E-45"),
    // rust: (2, "2.8E-45"),
    // rust: (7, "9.8E-45"),
    // rust: (71, "9.9E-44"),
    // rust: (100, "1.4E-43"),
    // rust: ] {
    // rust: for (sign, prefix) in [(0, ""), (1 << 31, "-")] {
    // rust: let bits = bits | sign;
    // rust: assert_eq!(
    // rust: java_float(f32::from_bits(bits)),
    // rust: format!("{prefix}{expected}")
    // rust: );
    // rust: assert_eq!(to_snbt(&Tag::Float(bits)), format!("{prefix}{expected}f"));
}
}
    // rust: for (bits, expected) in [
    // rust: (1, "4.9E-324"),
    // rust: (2, "9.9E-324"),
    // rust: (12, "5.9E-323"),
    // rust: (100, "4.94E-322"),
    // rust: ] {
    // rust: for (sign, prefix) in [(0, ""), (1 << 63, "-")] {
    // rust: let bits = bits | sign;
    // rust: assert_eq!(
    // rust: java_double(f64::from_bits(bits)),
    // rust: format!("{prefix}{expected}")
    // rust: );
    // rust: assert_eq!(to_snbt(&Tag::Double(bits)), format!("{prefix}{expected}d"));
}
}
}
}
