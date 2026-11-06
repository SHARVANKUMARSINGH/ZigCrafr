//! Transpiled from Horizon Rust crate
package horizon_shaders_condition

import "core:fmt"
import "core:mem"
import "core:math"

// The arithmetic of `#if` and `#elif` (spec 1.5, GLSL 4.60 §3.3): `defined`, integer
// literals, macros expanded to their values, and the C operators with C precedence. Float
// literals count as numbers too, as GL drivers take them (a pack's `#define AMOUNT 0.`).
// An identifier that is not a macro counts as 0, as in C: GLSL would reject the line, and a
// pack would then lose a whole section of its settings over one unknown name.

// use crate::Macros;
// use crate::macros::{is_ident, is_ident_start};

// The value of a condition; `Err` says what is wrong with it.
eval_condition :: proc(expr: string, macros: ^Macros) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let tokens = tokens(&resolve_defined(expr, macros)?, macros)?;
    // rust: let real = tokens
    // rust: .iter()
    // rust: .any(|t| matches!(t, Token::Num(n) if n.fract() != 0.0))
    // rust: || expr.contains('.');
    // rust: let mut parser = Parser {
    // rust: tokens: &tokens,
    // rust: at: 0,
    // rust: real,
    // rust: quiet: false,
}
    // rust: let value = parser.binary(0)?;
    // rust: match parser.tokens.get(parser.at) {
        // A fraction is true, as any value but zero.
    // rust: None if value != 0.0 && value.abs() < 1.0 => Ok(value.signum() as i64),
    // rust: None => Ok(value as i64),
    // rust: Some(t) => Err(format!("unexpected `{}`", t.text())),
}
}

// The text after a line's `#`, split into the directive word and the rest without its `//`
// comment. `None` when the first word is followed by something other than white space, `//` or
// the end of the line (`#ifdefault=1` is a comment, not `#ifdef`).
    // rust: pub(crate) fn split_directive(after_hash: &str) -> Option<(&str, &str)> {
    // rust: let line = after_hash.trim_start();
    // rust: let len = line
    // rust: .find(|c: char| !c.is_ascii_alphabetic())
    // rust: .unwrap_or(line.len());
    // rust: let (word, rest) = line.split_at(len);
    // rust: let ok = rest.is_empty() || rest.starts_with(char::is_whitespace) || rest.starts_with("//");
    // rust: ok.then(|| (word, rest.split("//").next().unwrap_or("").trim()))
}

// One level of `#if` ... `#endif`.
Branch :: struct {
    // This branch's lines are read.
    on: bool,
    // A branch of this `#if` was already taken (the rest are skipped).
    taken: bool,
    // The enclosing level is read.
    outer: bool,
    seen_else: bool,
}

// The state of nested conditional directives.
    // rust: pub(crate) struct Conditionals(Vec<Branch>);

    // rust: impl Conditionals {
    // Lines here are read.
    // rust: pub(crate) fn active(&self) -> bool {
    // rust: self.0.last().is_none_or(|b| b.on)
}

    // An `#if` is still open.
    // rust: pub(crate) fn open(&self) -> bool {
    // rust: !self.0.is_empty()
}

    // Applies `#word rest` when it is a conditional directive (`Ok(false)` when it is not). A
    // condition that can't be evaluated reads as false and returns why.
    // rust: pub(crate) fn apply(
    // rust: &mut self,
    // rust: word: &str,
    // rust: rest: &str,
    // rust: macros: &Macros,
    // rust: ) -> Result<bool, String> {
    // rust: let on = self.active();
    // rust: match word {
    // rust: "if" | "ifdef" | "ifndef" => {
    // rust: let value = if on {
    // rust: test(word, rest, macros)
    // rust: } else {
    // rust: Ok(false)
}
    // rust: let v = *value.as_ref().unwrap_or(&false);
    // rust: self.0.push(Branch {
    // rust: on: v,
    // rust: taken: v,
    // rust: outer: on,
    // rust: seen_else: false,
    // rust: });
    // rust: value.map(|_| true)
}
    // rust: "elif" | "else" => {
    // rust: let b = self
    // rust: .0
    // rust: .last_mut()
    // rust: .ok_or_else(|| format!("`#{word}` without `#if`"))?;
    // rust: if b.seen_else {
    // rust: return Err(format!("`#{word}` after `#else`"));
}
    // rust: b.seen_else = word == "else";
    // rust: let take = b.outer && !b.taken;
    // rust: let value = match word {
    // rust: "else" => Ok(take),
    // rust: _ if take => test("if", rest, macros),
    // rust: _ => Ok(false),
}
    // rust: b.on = *value.as_ref().unwrap_or(&false);
    // rust: b.taken |= b.on;
    // rust: value.map(|_| true)
}
    // rust: "endif" => self
    // rust: .0
    // rust: .pop()
    // rust: .map(|_| true)
    // rust: .ok_or_else(|| "`#endif` without `#if`".into()),
    // rust: _ => Ok(false),
}
}
}

test :: proc(word: string, rest: string, macros: ^Macros) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let name = rest.split_whitespace().next().unwrap_or("");
    // rust: match word {
    // rust: "ifdef" => Ok(macros.is_defined(name)),
    // rust: "ifndef" => Ok(!macros.is_defined(name)),
    // rust: _ => eval_condition(rest, macros)
    // rust: .map(|v| v != 0)
    // rust: .map_err(|e| format!("`#{word} {rest}`: {e}; read as false")),
}
}

// `defined X` and `defined(X)` become `1` or `0` before anything is expanded.
resolve_defined :: proc(expr: string, macros: ^Macros) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(expr.len());
    // rust: let mut rest = expr;
    // rust: while let Some(at) = find_word(rest, "defined") {
    // rust: out.push_str(&rest[..at]);
    // rust: let after = rest[at + "defined".len()..].trim_start();
    // rust: let (inner, tail) = match after.strip_prefix('(') {
    // rust: Some(open) => {
    // rust: let close = open.find(')').ok_or("`defined(` without `)`")?;
    // rust: (open[..close].trim(), &open[close + 1..])
}
    // rust: None => {
    // rust: let len = after.find(|c: char| !is_ident(c)).unwrap_or(after.len());
    // rust: (&after[..len], &after[len..])
}
}
    // rust: if inner.is_empty() || !inner.starts_with(is_ident_start) || !inner.chars().all(is_ident) {
    // rust: return Err("`defined` needs a macro name".into());
}
    // rust: out.push_str(if macros.is_defined(inner) {
    // rust: " 1 "
    // rust: } else {
    // rust: " 0 "
    // rust: });
    // rust: rest = tail;
}
    // rust: out.push_str(rest);
    // rust: Ok(out)
}

// Where `word` starts in `text` as a whole identifier.
find_word :: proc(text: string, word: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut from = 0;
    // rust: while let Some(i) = text[from..].find(word).map(|i| i + from) {
    // rust: let before = text[..i].chars().next_back().is_some_and(is_ident);
    // rust: let after = text[i + word.len()..].chars().next().is_some_and(is_ident);
    // rust: if !before && !after {
    // rust: return Some(i);
}
    // rust: from = i + word.len();
}
    // rust: None
}

Token :: enum {
    Num(f64),
    Op(&'static str),
}

    // rust: impl Token {
text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Token::Num(n) => n.to_string(),
    // rust: Token::Op(op) => (*op).to_owned(),
}
}
}

    // rust: const OPS: [&str; 22] = [
    // rust: "<<", ">>", "<=", ">=", "==", "!=", "&&", "||", "(", ")", "!", "~", "+", "-", "*", "/", "%",
    // rust: "<", ">", "&", "^", "|",
    // rust: ];

tokens :: proc(expr: string, macros: ^Macros) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let expanded = macros.expand(expr);
    // rust: let mut out = Vec::new();
    // rust: let mut rest = expanded.trim_start();
    // rust: while let Some(c) = rest.chars().next() {
    // rust: let fraction = c == '.' && rest[1..].starts_with(|c: char| c.is_ascii_digit());
    // rust: if c.is_ascii_digit() || fraction {
    // rust: let len = rest
    // rust: .find(|c: char| !c.is_ascii_alphanumeric())
    // rust: .unwrap_or(rest.len());
    // rust: if fraction || rest[len..].starts_with('.') {
    // rust: let len = rest
    // rust: .find(|c: char| !(c.is_ascii_alphanumeric() || c == '.'))
    // rust: .unwrap_or(rest.len());
    // rust: let text = rest[..len].trim_end_matches(['f', 'F']);
    // rust: let n = text
    // rust: .parse::<f64>()
    // rust: .map_err(|_| format!("`{text}` is not a number"))?;
    // rust: out.push(Token::Num(n));
    // rust: rest = &rest[len..];
    // rust: } else {
    // rust: out.push(Token::Num(int_literal(&rest[..len])? as f64));
    // rust: rest = &rest[len..];
}
    // rust: } else if is_ident_start(c) {
            // Not a macro: 0, as the C preprocessor counts it.
    // rust: let len = rest.find(|c: char| !is_ident(c)).unwrap_or(rest.len());
    // rust: out.push(Token::Num(0.0));
    // rust: rest = &rest[len..];
    // rust: } else {
    // rust: let op = OPS
    // rust: .iter()
    // rust: .find(|op| rest.starts_with(**op))
    // rust: .ok_or_else(|| format!("unexpected `{c}`"))?;
    // rust: out.push(Token::Op(op));
    // rust: rest = &rest[op.len()..];
}
    // rust: rest = rest.trim_start();
}
    // rust: Ok(out)
}

// Decimal, `0x` hexadecimal or leading-zero octal, with an optional `u` suffix.
int_literal :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let digits = text.strip_suffix(['u', 'U']).unwrap_or(text);
    // rust: let parsed = if let Some(hex) = digits.strip_prefix("0x").or(digits.strip_prefix("0X")) {
    // rust: i64::from_str_radix(hex, 16)
    // rust: } else if digits.len() > 1 && digits.starts_with('0') {
    // rust: i64::from_str_radix(&digits[1..], 8)
    // rust: } else {
    // rust: digits.parse()
}
    // rust: parsed.map_err(|_| format!("`{text}` is not an integer"))
}

Parser :: struct {
    tokens: ^'a [Token],
    at: uint,
    // A float literal appears: `/` and `%` divide as floats.
    real: bool,
    // Inside a side that `&&` / `||` skips: a division by zero is not an error.
    quiet: bool,
}

// Binary operators from the loosest to the tightest (GLSL §5.1 / §3.3).
    // rust: const LEVELS: [&[&str]; 10] = [
    // rust: &["||"],
    // rust: &["&&"],
    // rust: &["|"],
    // rust: &["^"],
    // rust: &["&"],
    // rust: &["==", "!="],
    // rust: &["<", ">", "<=", ">="],
    // rust: &["<<", ">>"],
    // rust: &["+", "-"],
    // rust: &["*", "/", "%"],
    // rust: ];

    // rust: impl Parser<'_> {
next :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let t = self.tokens.get(self.at).copied();
    // rust: self.at += 1;
    // rust: t
}

binary :: proc(self: ^Self, level: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if level == LEVELS.len() {
    // rust: return self.unary();
}
    // rust: let mut left = self.binary(level + 1)?;
    // rust: while let Some(&Token::Op(op)) = self.tokens.get(self.at) {
    // rust: if !LEVELS[level].contains(&op) {
    // rust: break;
}
    // rust: self.at += 1;
            // C does not evaluate the side `&&` / `||` skips, so a guarded division by zero
            // there is no error.
    // rust: let skipped = (op == "||" && left != 0.0) || (op == "&&" && left == 0.0);
    // rust: let outer = self.quiet;
    // rust: self.quiet |= skipped;
    // rust: let right = self.binary(level + 1);
    // rust: self.quiet = outer;
    // rust: left = apply(op, left, right?, self.real, skipped || outer)?;
}
    // rust: Ok(left)
}

unary :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match self.next() {
    // rust: Some(Token::Num(n)) => Ok(n),
    // rust: Some(Token::Op("(")) => {
    // rust: let value = self.binary(0)?;
    // rust: match self.next() {
    // rust: Some(Token::Op(")")) => Ok(value),
    // rust: _ => Err("missing `)`".into()),
}
}
    // rust: Some(Token::Op("-")) => Ok(-self.unary()?),
    // rust: Some(Token::Op("+")) => self.unary(),
    // rust: Some(Token::Op("!")) => Ok(f64::from(u8::from(self.unary()? == 0.0))),
    // rust: Some(Token::Op("~")) => Ok(!(self.unary()? as i64) as f64),
    // rust: Some(t) => Err(format!("unexpected `{}`", t.text())),
    // rust: None => Err("the condition ends too early".into()),
}
}
}

apply :: proc(op: string, a: f64, b: f64, real: bool, quiet: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let truth = |v: bool| f64::from(u8::from(v));
    // rust: let (i, j) = (a as i64, b as i64);
    // rust: Ok(match op {
    // rust: "||" => truth(a != 0.0 || b != 0.0),
    // rust: "&&" => truth(a != 0.0 && b != 0.0),
    // rust: "|" => (i | j) as f64,
    // rust: "^" => (i ^ j) as f64,
    // rust: "&" => (i & j) as f64,
    // rust: "==" => truth(a == b),
    // rust: "!=" => truth(a != b),
    // rust: "<" => truth(a < b),
    // rust: ">" => truth(a > b),
    // rust: "<=" => truth(a <= b),
    // rust: ">=" => truth(a >= b),
    // rust: "<<" => i.wrapping_shl(j as u32) as f64,
    // rust: ">>" => i.wrapping_shr(j as u32) as f64,
    // rust: "+" => a + b,
    // rust: "-" => a - b,
    // rust: "*" => a * b,
    // rust: "/" | "%" if b == 0.0 && quiet => 0.0,
    // rust: "/" | "%" if b == 0.0 => return Err("division by zero".into()),
    // rust: "/" if real => a / b,
    // rust: "%" if real => a % b,
    // rust: "/" => i.wrapping_div(j) as f64,
    // rust: _ => i.wrapping_rem(j) as f64,
    // rust: })
}

    // rust: mod tests {
//     use super::*;

eval :: proc(expr: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut m = Macros::standard();
    // rust: m.define("SHADOW_RES", "2048");
    // rust: m.define("WAVES", "");
    // rust: m.define("QUALITY", "SHADOW_RES / 1024");
    // rust: eval_condition(expr, &m)
}

precedence_and_operators_follow_c :: proc() {
}
    // rust: assert_eq!(eval("1 + 2 * 3"), Ok(7));
    // rust: assert_eq!(eval("(1 + 2) * 3"), Ok(9));
    // rust: assert_eq!(eval("1 << 2 + 1"), Ok(8));
    // rust: assert_eq!(eval("6 & 3 == 3"), Ok(0));
    // rust: assert_eq!(eval("1 || 0 && 0"), Ok(1));
    // rust: assert_eq!(eval("-7 / 2"), Ok(-3));
    // rust: assert_eq!(eval("-7 % 2"), Ok(-1));
    // rust: assert_eq!(eval("!0 + ~0"), Ok(0));
    // rust: assert_eq!(eval("0x10 + 010 + 3u"), Ok(27));
}

macros_and_defined :: proc() {
}
    // rust: assert_eq!(eval("MC_VERSION >= 11300"), Ok(1));
    // rust: assert_eq!(eval("MC_VERSION <= 12111"), Ok(0));
    // rust: assert_eq!(eval("QUALITY == 2"), Ok(1));
    // rust: assert_eq!(eval("defined WAVES && defined(SHADOW_RES)"), Ok(1));
    // rust: assert_eq!(eval("!defined NOPE"), Ok(1));
    // rust: assert_eq!(eval("NOPE == 0"), Ok(1));
    // rust: assert_eq!(eval("undefinedFeature"), Ok(0));
}

    // Float values, as GL drivers read them (I Like Vanilla's `#if AMBIENT_CEL_AMOUNT != 0` with
    // `#define AMBIENT_CEL_AMOUNT 0.0`).
float_values_count :: proc() {
}
    // rust: assert_eq!(eval("0. != 0"), Ok(0));
    // rust: assert_eq!(eval("4. != 0"), Ok(1));
    // rust: assert_eq!(eval("0.7 > 0.5"), Ok(1));
    // rust: assert_eq!(eval(".25 * 4.0 == 1"), Ok(1));
    // rust: assert_eq!(eval("1.5f"), Ok(1));
    // rust: assert_eq!(eval("7 / 2"), Ok(3));
    // rust: assert_eq!(eval("SHADOW_RES == 2048.0"), Ok(1));
}

short_circuit_skips_guarded_division :: proc() {
}
    // rust: let mut m = Macros::standard();
    // rust: m.define("AMOUNT", "0");
    // rust: assert_eq!(eval_condition("AMOUNT != 0 && 100 / AMOUNT > 5", &m), Ok(0));
    // rust: assert_eq!(eval_condition("AMOUNT == 0 || 100 / AMOUNT > 5", &m), Ok(1));
    // rust: assert_eq!(eval_condition("AMOUNT && (1 % AMOUNT)", &m), Ok(0));
        // The unskipped side still errors.
    // rust: assert!(eval_condition("AMOUNT == 0 && 100 / AMOUNT > 5", &m).is_err());
    // rust: assert!(eval_condition("AMOUNT != 0 || 100 / AMOUNT > 5", &m).is_err());
}

bad_conditions_say_why :: proc() {
}
    // rust: assert!(eval("1 / 0").is_err());
    // rust: assert!(eval("SHADOW_RES == 0.5 0").is_err());
    // rust: assert!(eval("(1 + 2").is_err());
    // rust: assert!(eval("1 2").is_err());
    // rust: assert!(eval("").is_err());
    // rust: assert!(eval("defined").is_err());
    // rust: assert!(eval("1 @ 2").is_err());
}
}
