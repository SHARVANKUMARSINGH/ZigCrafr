//! Transpiled from Horizon Rust crate
package horizon_optifine_expr

import "core:fmt"
import "core:mem"
import "core:math"

// CEM animation expressions (`"head.rx": "sin(limb_swing * 0.6662) * limb_speed"`), compiled
// once when the packs load into a flat stack program, then evaluated per entity per frame
// without allocating or touching strings.
//
// Variables are slots: the caller resolves each name (`limb_swing`, `head.rx`, `var.x`...) to
// an index into its own `f32` array when compiling. Booleans are 1 and 0, and any value but 0
// is true, NaN included. `if`, `&&` and `||` evaluate only the branch they take.

// use super::curves::{self, Curve, Ease};
// use std::cell::{Cell, RefCell};
// use std::fmt;

// The value stack on the program's own frame; deeper programs (long `keyframe` tracks) use a
// buffer kept per thread.
STACK :: 64
// Deepest nesting of brackets, unary operators and calls, so that no pack can overflow the
// thread's stack while it parses.
NESTING :: 64
// Most nodes an expression may parse to, which bounds the folding, the code and its stack.
NODES :: 1024

// Why an expression doesn't compile.
Error :: struct {
    // What is wrong, in English.
    message: string,
    // Byte offset in the expression where it went wrong.
    offset: uint,
}
    // rust: impl fmt::Display for Error {
fmt :: proc(self: ^Self, f: ^fmt::Formatter) -> f {
    // Ported from Horizon
    return {}
}
    // rust: write!(f, "{} at {}", self.message, self.offset)
}
}
    // rust: impl std::error::Error for Error {}

    // rust: fn err<T>(message: impl Into<String>, offset: usize) -> Result<T, Error> {
    // rust: Err(Error {
    // rust: message: message.into(),
    // rust: offset,
    // rust: })
}

// A compiled expression.
Expr :: struct {
    code: [dynamic]Op,
    // The most values on its stack at once.
    depth: uint,
}

Op :: enum {
    Const(f32),
    Slot(u32),
    Neg,
    Bin(Bin),
    Call(Func, u16),
    // Pops; jumps when the value is 0 (not when it is NaN).
    JumpIfZero(u32),
    Jump(u32),
}

Bin :: enum {
    Add,
    Sub,
    Mul,
    Div,
    Rem,
    Lt,
    Le,
    Gt,
    Ge,
    Eq,
    Ne,
}
    // rust: impl Bin {
apply :: proc(self: ^Self, a: f32, b: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let t = |c: bool| if c { 1.0 } else { 0.0 };
    // rust: match self {
    // rust: Bin::Add => a + b,
    // rust: Bin::Sub => a - b,
    // rust: Bin::Mul => a * b,
    // rust: Bin::Div => a / b,
    // rust: Bin::Rem => a % b,
    // rust: Bin::Lt => t(a < b),
    // rust: Bin::Le => t(a <= b),
    // rust: Bin::Gt => t(a > b),
    // rust: Bin::Ge => t(a >= b),
    // rust: Bin::Eq => t(a == b),
    // rust: Bin::Ne => t(a != b),
}
}
}

    // rust: macro_rules! funcs {
    // rust: ($($name:literal => $f:ident ($min:literal, $max:expr)),* $(,)?) => {
Func :: enum {
    // rust: $($f,)*
            // `ease{in,out,inout}{quad,cubic...}(k, x, y)`
    Ease(Curve, Ease),
}
    // rust: impl Func {
named :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(rest) = name.strip_prefix("ease") {
    // rust: let (ease, curve) = if let Some(c) = rest.strip_prefix("inout") {
    // rust: (Ease::InOut, c)
    // rust: } else if let Some(c) = rest.strip_prefix("in") {
    // rust: (Ease::In, c)
    // rust: } else {
    // rust: (Ease::Out, rest.strip_prefix("out")?)
}
    // rust: return Some((Func::Ease(Curve::named(curve)?, ease), 3, 3));
}
    // rust: Some(match name { $($name => (Func::$f, $min, $max),)* _ => return None })
}
}
}
}
MANY :: usize::MAX
    // rust: funcs! {
    // rust: "sin" => Sin(1, 1), "cos" => Cos(1, 1), "asin" => Asin(1, 1), "acos" => Acos(1, 1),
    // rust: "tan" => Tan(1, 1), "atan" => Atan(1, 1), "atan2" => Atan2(2, 2), "torad" => Torad(1, 1),
    // rust: "todeg" => Todeg(1, 1), "min" => Min(1, MANY), "max" => Max(1, MANY),
    // rust: "clamp" => Clamp(3, 3), "abs" => Abs(1, 1), "floor" => Floor(1, 1), "ceil" => Ceil(1, 1),
    // rust: "exp" => Exp(1, 1), "frac" => Frac(1, 1), "log" => Log(1, 1), "pow" => Pow(2, 2),
    // rust: "random" => Random(0, 1), "randomb" => Randomb(0, 1), "round" => Round(1, 1),
    // rust: "signum" => Signum(1, 1), "sqrt" => Sqrt(1, 1), "fmod" => Fmod(2, 2), "lerp" => Lerp(3, 3),
    // rust: "print" => Print(3, 3), "printb" => Printb(3, 3), "between" => Between(3, 3),
    // rust: "equals" => Equals(3, 3), "in" => In(2, MANY), "wrapdeg" => Wrapdeg(1, 1),
    // rust: "wraprad" => Wraprad(1, 1), "degdiff" => Degdiff(2, 2), "raddiff" => Raddiff(2, 2),
    // rust: "catch" => Catch(2, 3), "keyframe" => Keyframe(2, MANY), "keyframeloop" => Keyframeloop(2, MANY),
    // rust: "catmullrom" => Catmullrom(5, 5), "hermite" => Hermite(5, 5), "cubicbezier" => Cubicbezier(5, 5),
    // rust: "quadbezier" => Quadbezier(4, 4),
}

PI :: std::f32::consts::PI

wrap :: proc(x: f32, turn: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let r = x % turn;
    // rust: if r >= turn / 2.0 {
    // rust: r - turn
    // rust: } else if r < -turn / 2.0 {
    // rust: r + turn
    // rust: } else {
    // rust: r
}
}

GOLDEN :: 0x9E37_79B9_7F4A_7C15

    // rust: thread_local! {
    // The unseeded `random()` sequence: every thread starts somewhere else, every launch too.
RANDOM :: Cell::new(random_start())
}

random_start :: proc() -> u {
    // Ported from Horizon
    return {}
}
//     use std::sync::atomic::{AtomicU64, Ordering};
//     use std::time::{SystemTime, UNIX_EPOCH};
THREADS :: AtomicU64::new(0)
    // rust: let now = SystemTime::now()
    // rust: .duration_since(UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos() as u64);
    // rust: now ^ THREADS.fetch_add(1, Ordering::Relaxed).wrapping_mul(GOLDEN)
}

random :: proc(seed: Maybe(f32)) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut x = match seed {
    // rust: Some(s) => u64::from(s.to_bits()).wrapping_mul(GOLDEN) ^ 0xD1B5_4A32_D192_ED03,
    // rust: None => RANDOM.with(|s| {
    // rust: let v = s.get().wrapping_add(GOLDEN);
    // rust: s.set(v);
    // rust: v
    // rust: }),
}
    // splitmix64's finaliser.
    // rust: x = (x ^ (x >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
    // rust: x = (x ^ (x >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
    // rust: x ^= x >> 31;
    // rust: (x >> 40) as f32 / (1u64 << 24) as f32
}

    // rust: impl Func {
    // Whether two calls with the same arguments may give different results.
varies :: proc(self: ^Self, argc: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Func::Random | Func::Randomb) && argc == 0
}

apply :: proc(self: ^Self, a: ^[f32]) -> f {
    // Ported from Horizon
    return {}
}
//         use Func::*;
    // rust: let t = |c: bool| if c { 1.0 } else { 0.0 };
    // rust: match self {
    // rust: Sin => a[0].sin(),
    // rust: Cos => a[0].cos(),
    // rust: Asin => a[0].asin(),
    // rust: Acos => a[0].acos(),
    // rust: Tan => a[0].tan(),
    // rust: Atan => a[0].atan(),
    // rust: Atan2 => a[0].atan2(a[1]),
    // rust: Torad => a[0].to_radians(),
    // rust: Todeg => a[0].to_degrees(),
            // Java's `Math.min` and `max`: NaN if any argument is.
    // rust: Min | Max if a.iter().any(|v| v.is_nan()) => f32::NAN,
    // rust: Min => a.iter().copied().fold(f32::INFINITY, f32::min),
    // rust: Max => a.iter().copied().fold(f32::NEG_INFINITY, f32::max),
            // Java's `x < lo ? lo : Math.min(x, hi)`: a NaN `x` stays NaN.
    // rust: Clamp if a[0] < a[1] => a[1],
    // rust: Clamp if a[0].is_nan() || a[2].is_nan() => f32::NAN,
    // rust: Clamp => a[0].min(a[2]),
    // rust: Abs => a[0].abs(),
    // rust: Floor => a[0].floor(),
    // rust: Ceil => a[0].ceil(),
    // rust: Exp => a[0].exp(),
    // rust: Frac => a[0] - a[0].floor(),
    // rust: Log => a[0].ln(),
            // Java's `Math.pow`, where C's differs: a NaN exponent is NaN, and so is 1 or -1 to
            // an infinite one. Any `x` to 0 is 1, NaN too, in both.
    // rust: Pow if a[1].is_nan() || (a[0].abs() == 1.0 && a[1].is_infinite()) => f32::NAN,
    // rust: Pow => a[0].powf(a[1]),
    // rust: Random => random(a.first().copied()),
    // rust: Randomb => t(random(a.first().copied()) >= 0.5),
            // Java's `Math.round(float)`, an `int`: halves go up, NaN is 0 and the rest saturates
            // at the `int`'s ends. `x - floor(x)` is exact, `x + 0.5` isn't.
    // rust: Round => {
    // rust: let f = a[0].floor();
    // rust: (if a[0] - f >= 0.5 { f + 1.0 } else { f }) as i32 as f32
}
    // rust: Signum if a[0] == 0.0 || a[0].is_nan() => a[0],
    // rust: Signum => a[0].signum(),
    // rust: Sqrt => a[0].sqrt(),
    // rust: Fmod => {
    // rust: let r = a[0] % a[1];
    // rust: if r != 0.0 && (r < 0.0) != (a[1] < 0.0) {
    // rust: r + a[1]
    // rust: } else {
    // rust: r
}
}
    // rust: Lerp => curves::lerp(a[0], a[1], a[2]),
            // Printing to the log is a debugging aid: only the value matters here.
    // rust: Print | Printb => a[2],
    // rust: Between => t(a[1] <= a[0] && a[0] <= a[2]),
    // rust: Equals => t((a[0] - a[1]).abs() <= a[2]),
    // rust: In => t(a[1..].contains(&a[0])),
    // rust: Wrapdeg => wrap(a[0], 360.0),
    // rust: Wraprad => wrap(a[0], 2.0 * PI),
    // rust: Degdiff => wrap(a[1] - a[0], 360.0),
    // rust: Raddiff => wrap(a[1] - a[0], 2.0 * PI),
            // EMF: x unless it is NaN; infinities pass.
    // rust: Catch if a[0].is_nan() => a[1],
    // rust: Catch => a[0],
    // rust: Keyframe => curves::keyframe(a[0], &a[1..], false),
    // rust: Keyframeloop => curves::keyframe(a[0], &a[1..], true),
    // rust: Catmullrom => curves::catmullrom(a[0], a[1], a[2], a[3], a[4]),
    // rust: Hermite => curves::hermite(a[0], a[1], a[2], a[3], a[4]),
    // rust: Cubicbezier => curves::cubic_bezier(a[0], a[1], a[2], a[3], a[4]),
    // rust: Quadbezier => curves::quad_bezier(a[0], a[1], a[2], a[3]),
            // `lerp` along the curve.
    // rust: Ease(curve, ease) => curves::lerp(curve.at(ease, a[0]), a[1], a[2]),
}
}
}

// The parsed form, folded before it becomes code. `!`, `&&`, `||` and `ifb` are lowered to
// comparisons with 0 and `if`s.
Node :: enum {
    Num(f32),
    Slot(u32),
    Neg(Box<Node>),
    Bin(Bin, Box<Node>, Box<Node>),
    // cond, value, [cond, value...], else
    If(Vec<Node>),
    Call(Func, Vec<Node>),
}

bin :: proc(op: Bin, a: Node, b: Node) -> N {
    // Ported from Horizon
    return {}
}
    // rust: Node::Bin(op, Box::new(a), Box::new(b))
}

// `a` as a boolean, 1 or 0.
truth :: proc(a: Node) -> N {
    // Ported from Horizon
    return {}
}
    // rust: bin(Bin::Ne, a, Node::Num(0.0))
}

Tok :: enum {
    Num(f32),
    Name(&'a str),
    Sym(&'a str),
    End,
}

Parser :: struct {
    src: ^'a str,
    pos: uint,
    tok: Tok<'a>,
    at: uint,
    // Open brackets, unary operators and calls around the current token.
    nesting: uint,
    nodes: uint,
    resolve: ^'r mut dyn FnMut(string) -> Maybe(u32),
}

    // rust: impl<'a> Parser<'a, '_> {
next :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.src.as_bytes();
    // rust: while self.pos < b.len() && b[self.pos].is_ascii_whitespace() {
    // rust: self.pos += 1;
}
    // rust: self.at = self.pos;
    // rust: let Some(&c) = b.get(self.pos) else {
    // rust: self.tok = Tok::End;
    // rust: return Ok(());
}
    // rust: let start = self.pos;
    // rust: let word = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b':');
    // rust: if c.is_ascii_digit() || c == b'.' && b.get(start + 1).is_some_and(u8::is_ascii_digit) {
    // rust: while self.pos < b.len() && (b[self.pos].is_ascii_digit() || b[self.pos] == b'.') {
    // rust: self.pos += 1;
}
    // rust: let text = &self.src[start..self.pos];
    // rust: self.tok = Tok::Num(match text.parse() {
    // rust: Ok(v) => v,
    // rust: Err(_) => return err(format!("bad number {text}"), start),
    // rust: });
    // rust: } else if c.is_ascii_alphabetic() || c == b'_' {
    // rust: while self.pos < b.len() && word(b[self.pos]) {
    // rust: self.pos += 1;
}
    // rust: self.tok = Tok::Name(&self.src[start..self.pos]);
    // rust: } else {
    // rust: let two = self.src.get(start..start + 2);
    // rust: let len = match two {
    // rust: Some("&&" | "||" | "<=" | ">=" | "==" | "!=") => 2,
    // rust: _ if b"+-*/%!<>(),".contains(&c) => 1,
    // rust: _ => return err(format!("unexpected {:?}", c as char), start),
}
    // rust: self.pos += len;
    // rust: self.tok = Tok::Sym(&self.src[start..self.pos]);
}
    // rust: Ok(())
}

eat :: proc(self: ^Self, sym: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.tok == Tok::Sym(sym) {
    // rust: self.next()?;
    // rust: return Ok(true);
}
    // rust: Ok(false)
}

expect :: proc(self: ^Self, sym: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !self.eat(sym)? {
    // rust: return err(format!("expected {sym}"), self.at);
}
    // rust: Ok(())
}

    // One more level of nesting, opened at `at`.
enter :: proc(self: ^Self, at: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.nesting += 1;
    // rust: if self.nesting > NESTING {
    // rust: return err("expression too deep", at);
}
    // rust: Ok(())
}

    // `n` more nodes.
grow :: proc(self: ^Self, n: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes += n;
    // rust: if self.nodes > NODES {
    // rust: return err("expression too long", self.at);
}
    // rust: Ok(())
}

or :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = self.and()?;
    // rust: while self.eat("||")? {
    // rust: let b = self.and()?;
    // rust: self.grow(4)?;
    // rust: a = Node::If(vec![a, Node::Num(1.0), truth(b)]);
}
    // rust: Ok(a)
}

and :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut a = self.binary(0)?;
    // rust: while self.eat("&&")? {
    // rust: let b = self.binary(0)?;
    // rust: self.grow(4)?;
    // rust: a = Node::If(vec![a, truth(b), Node::Num(0.0)]);
}
    // rust: Ok(a)
}

    // Equality, then comparisons, then sums, then products.
binary :: proc(self: ^Self, level: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: const LEVELS: [&[(&str, Bin)]; 4] = [
    // rust: &[("==", Bin::Eq), ("!=", Bin::Ne)],
    // rust: &[
    // rust: ("<=", Bin::Le),
    // rust: (">=", Bin::Ge),
    // rust: ("<", Bin::Lt),
    // rust: (">", Bin::Gt),
    // rust: ],
    // rust: &[("+", Bin::Add), ("-", Bin::Sub)],
    // rust: &[("*", Bin::Mul), ("/", Bin::Div), ("%", Bin::Rem)],
    // rust: ];
    // rust: let Some(ops) = LEVELS.get(level) else {
    // rust: return self.unary();
}
    // rust: let mut a = self.binary(level + 1)?;
    // rust: 'more: loop {
    // rust: for (sym, op) in ops.iter() {
    // rust: if self.eat(sym)? {
    // rust: let b = self.binary(level + 1)?;
    // rust: self.grow(1)?;
    // rust: a = bin(*op, a, b);
    // rust: continue 'more;
}
}
    // rust: return Ok(a);
}
}

unary :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let at = self.at;
    // rust: if let Tok::Sym(sym @ ("-" | "+" | "!")) = self.tok {
    // rust: self.next()?;
    // rust: self.enter(at)?;
    // rust: let a = self.unary()?;
    // rust: self.nesting -= 1;
    // rust: self.grow(2)?;
    // rust: return Ok(match sym {
    // rust: "-" => Node::Neg(Box::new(a)),
    // rust: "!" => bin(Bin::Eq, a, Node::Num(0.0)),
    // rust: _ => a,
    // rust: });
}
    // rust: self.grow(1)?;
    // rust: match self.tok {
    // rust: Tok::Num(v) => {
    // rust: self.next()?;
    // rust: Ok(Node::Num(v))
}
    // rust: Tok::Sym("(") => {
    // rust: self.next()?;
    // rust: self.enter(at)?;
    // rust: let e = self.or()?;
    // rust: self.nesting -= 1;
    // rust: self.expect(")")?;
    // rust: Ok(e)
}
    // rust: Tok::Name(name) => {
    // rust: self.next()?;
    // rust: if self.tok == Tok::Sym("(") {
    // rust: return self.call(name, at);
}
    // rust: Ok(match name {
    // rust: "pi" => Node::Num(PI),
    // rust: "e" => Node::Num(std::f32::consts::E),
    // rust: "nan" => Node::Num(f32::NAN),
    // rust: "true" => Node::Num(1.0),
    // rust: "false" => Node::Num(0.0),
    // rust: _ => match (self.resolve)(name) {
    // rust: Some(slot) => Node::Slot(slot),
    // rust: None => return err(format!("unknown variable {name}"), at),
    // rust: },
    // rust: })
}
    // rust: Tok::End => err("unexpected end", at),
    // rust: Tok::Sym(s) => err(format!("unexpected {s}"), at),
}
}

    // Skips the raw text of a call, which isn't an expression, to its closing bracket.
skip_call :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.src.as_bytes();
    // rust: let mut open = 1;
    // rust: while open > 0 {
    // rust: match b.get(self.pos) {
    // rust: None => return err("expected )", self.pos),
    // rust: Some(b'(') => open += 1,
    // rust: Some(b')') => open -= 1,
    // rust: _ => {}
}
    // rust: self.pos += 1;
}
    // rust: self.next()
}

call :: proc(self: ^Self, name: string, at: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if name == "nbt" {
            // EMF's `nbt(key, test)` needs the entity's NBT, which the client model doesn't
            // have; its test (`exists:false`...) isn't an expression either.
    // rust: self.skip_call()?;
    // rust: return Ok(Node::Num(0.0));
}
    // rust: self.enter(self.at)?;
    // rust: self.expect("(")?;
    // rust: let mut args = Vec::new();
    // rust: if !self.eat(")")? {
    // rust: loop {
    // rust: args.push(self.or()?);
    // rust: if self.eat(")")? {
    // rust: break;
}
    // rust: self.expect(",")?;
}
}
    // rust: self.nesting -= 1;
    // rust: if name == "if" || name == "ifb" {
    // rust: if args.len() < 3 || args.len() % 2 == 0 {
    // rust: return err(format!("{name} takes cond, value pairs and an else"), at);
}
    // rust: if name == "ifb" {
    // rust: self.grow(2)?;
    // rust: return Ok(truth(Node::If(args)));
}
    // rust: return Ok(Node::If(args));
}
    // rust: let Some((f, min, max)) = Func::named(name) else {
    // rust: return err(format!("unknown function {name}"), at);
}
    // rust: if args.len() < min || args.len() > max.min(u16::MAX as usize) {
    // rust: return err(format!("wrong number of arguments to {name}"), at);
}
    // rust: Ok(Node::Call(f, args))
}
}

// Folds the constant parts of `n`.
fold :: proc(n: Node) -> N {
    // Ported from Horizon
    return {}
}
    // rust: let num = |n: &Node| match n {
    // rust: Node::Num(v) => Some(*v),
    // rust: _ => None,
}
    // rust: match n {
    // rust: Node::Neg(a) => match fold(*a) {
    // rust: Node::Num(v) => Node::Num(-v),
    // rust: a => Node::Neg(Box::new(a)),
    // rust: },
    // rust: Node::Bin(op, a, b) => match (fold(*a), fold(*b)) {
    // rust: (Node::Num(x), Node::Num(y)) => Node::Num(op.apply(x, y)),
    // rust: (a, b) => bin(op, a, b),
    // rust: },
    // rust: Node::If(args) => {
    // rust: let mut out = Vec::new();
    // rust: let mut args = args.into_iter();
    // rust: while args.len() > 1 {
    // rust: let (c, v) = (fold(args.next().unwrap()), args.next().unwrap());
    // rust: match num(&c) {
                    // A false branch is dropped, a true one (NaN too) ends the chain.
    // rust: Some(0.0) => continue,
    // rust: Some(_) if out.is_empty() => return fold(v),
    // rust: Some(_) => {
    // rust: out.push(fold(v));
    // rust: return Node::If(out);
}
    // rust: None => out.extend([c, fold(v)]),
}
}
    // rust: let otherwise = fold(args.next().unwrap());
    // rust: if out.is_empty() {
    // rust: return otherwise;
}
    // rust: out.push(otherwise);
    // rust: Node::If(out)
}
    // rust: Node::Call(f, args) => {
    // rust: let args: Vec<Node> = args.into_iter().map(fold).collect();
    // rust: match args.iter().map(num).collect::<Option<Vec<f32>>>() {
    // rust: Some(values) if !f.varies(values.len()) => Node::Num(f.apply(&values)),
    // rust: _ => Node::Call(f, args),
}
}
    // rust: n => n,
}
}

Emit :: struct {
    code: [dynamic]Op,
    depth: uint,
    max: uint,
}
    // rust: impl Emit {
push :: proc(self: ^Self, op: Op, change: int) {
}
    // rust: self.code.push(op);
    // rust: self.depth = self
    // rust: .depth
    // rust: .checked_add_signed(change)
    // rust: .expect("stack underflow");
    // rust: self.max = self.max.max(self.depth);
}
here :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.code.len() as u32
}
patch :: proc(self: ^Self, at: u32) {
}
    // rust: let to = self.here();
    // rust: match &mut self.code[at as usize] {
    // rust: Op::JumpIfZero(t) | Op::Jump(t) => *t = to,
    // rust: _ => unreachable!(),
}
}
node :: proc(self: ^Self, n: ^Node) {
}
    // rust: match n {
    // rust: Node::Num(v) => self.push(Op::Const(*v), 1),
    // rust: Node::Slot(s) => self.push(Op::Slot(*s), 1),
    // rust: Node::Neg(a) => {
    // rust: self.node(a);
    // rust: self.push(Op::Neg, 0);
}
    // rust: Node::Bin(op, a, b) => {
    // rust: self.node(a);
    // rust: self.node(b);
    // rust: self.push(Op::Bin(*op), -1);
}
    // rust: Node::If(args) => {
    // rust: let mut ends = Vec::new();
    // rust: for pair in args.chunks_exact(2) {
    // rust: self.node(&pair[0]);
    // rust: let next = self.here();
    // rust: self.push(Op::JumpIfZero(0), -1);
    // rust: self.node(&pair[1]);
    // rust: ends.push(self.here());
    // rust: self.push(Op::Jump(0), -1);
    // rust: self.patch(next);
}
    // rust: self.node(args.last().unwrap());
    // rust: for end in ends {
    // rust: self.patch(end);
}
}
    // rust: Node::Call(f, args) => {
    // rust: for a in args {
    // rust: self.node(a);
}
    // rust: self.push(Op::Call(*f, args.len() as u16), 1 - args.len() as isize);
}
}
}
}

// Compiles `src`. `resolve` gives the slot of a variable name, None for one that doesn't
// exist.
compile :: proc(src: string, resolve: ^dyn FnMut(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut p = Parser {
    // rust: src,
    // rust: pos: 0,
    // rust: tok: Tok::End,
    // rust: at: 0,
    // rust: nesting: 0,
    // rust: nodes: 0,
    // rust: resolve,
}
    // rust: p.next()?;
    // rust: let tree = p.or()?;
    // rust: if p.tok != Tok::End {
    // rust: return err("unexpected text after the expression", p.at);
}
    // rust: let tree = fold(tree);
    // rust: let mut emit = Emit {
    // rust: code: Vec::new(),
    // rust: depth: 0,
    // rust: max: 0,
}
    // rust: emit.node(&tree);
    // rust: Ok(Expr {
    // rust: code: emit.code,
    // rust: depth: emit.max,
    // rust: })
}

    // rust: thread_local! {
    // The stack of programs too deep for `STACK`, grown once and kept.
DEEP :: const { RefCell::new(Vec::new()) }
}

    // rust: impl Expr {
    // The value with the variables in `slots`.
eval :: proc(self: ^Self, slots: ^[f32]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.depth <= STACK {
    // rust: return self.run(slots, &mut [0.0; STACK]);
}
    // rust: DEEP.with_borrow_mut(|stack| {
    // rust: if stack.len() < self.depth {
    // rust: stack.resize(self.depth, 0.0);
}
    // rust: self.run(slots, stack)
    // rust: })
}

run :: proc(self: ^Self, slots: ^[f32], stack: ^[f32]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut sp = 0;
    // rust: let mut pc = 0;
    // rust: while let Some(op) = self.code.get(pc) {
    // rust: pc += 1;
    // rust: match *op {
    // rust: Op::Const(v) => {
    // rust: stack[sp] = v;
    // rust: sp += 1;
}
    // rust: Op::Slot(s) => {
    // rust: stack[sp] = slots.get(s as usize).copied().unwrap_or(0.0);
    // rust: sp += 1;
}
    // rust: Op::Neg => stack[sp - 1] = -stack[sp - 1],
    // rust: Op::Bin(op) => {
    // rust: sp -= 1;
    // rust: stack[sp - 1] = op.apply(stack[sp - 1], stack[sp]);
}
    // rust: Op::Call(f, n) => {
    // rust: let n = n as usize;
    // rust: let v = f.apply(&stack[sp - n..sp]);
    // rust: sp -= n;
    // rust: stack[sp] = v;
    // rust: sp += 1;
}
    // rust: Op::JumpIfZero(to) => {
    // rust: sp -= 1;
    // rust: if stack[sp] == 0.0 {
    // rust: pc = to as usize;
}
}
    // rust: Op::Jump(to) => pc = to as usize,
}
}
    // rust: stack[0]
}

    // The value, when it doesn't depend on any variable or on chance.
constant :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.code.as_slice() {
    // rust: [Op::Const(v)] => Some(*v),
    // rust: _ => None,
}
}
}

    // rust: mod tests {
//     use super::*;

    // Slots: `a` 0, `b` 1, `var.n` 2, `head.rx` 3.
NAMES :: ["a", "b", "var.n", "head.rx"]
names :: proc(n: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: NAMES.iter().position(|x| *x == n).map(|i| i as u32)
}
expr :: proc(src: string) -> E {
    // Ported from Horizon
    return {}
}
    // rust: compile(src, &mut names).unwrap_or_else(|e| panic!("{src}: {e}"))
}
eval :: proc(src: string, slots: ^[f32]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: expr(src).eval(slots)
}
value :: proc(src: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: eval(src, &[])
}
close :: proc(a: f32, b: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (a - b).abs() < 1e-5
}

precedence_and_booleans :: proc() {
}
    // rust: assert_eq!(value("1 + 2 * 3"), 7.0);
    // rust: assert_eq!(value("(1 + 2) * 3"), 9.0);
    // rust: assert_eq!(value("-2 * 3 + 10 % 4"), -4.0);
    // rust: assert_eq!(value("1 < 2 == 1"), 1.0);
    // rust: assert_eq!(value("1 + 1 == 2 && !(3 > 4) || false"), 1.0);
    // rust: assert_eq!(value("2 && 0.5"), 1.0);
    // rust: assert_eq!(value("1 - -1"), 2.0);
    // rust: assert_eq!(value("+2 * +(1 + 2) - +-1"), 7.0);
    // rust: assert_eq!(eval("a * 2 + b", &[3.0, 1.0]), 7.0);
    // rust: assert_eq!(eval("head.rx + var.n", &[0.0, 0.0, 2.0, 0.5]), 2.5);
        // The same through slots, so nothing folds.
    // rust: let neg_not = expr("-a + !a");
    // rust: assert_eq!([0.0, 3.0].map(|a| neg_not.eval(&[a])), [1.0, -3.0]);
    // rust: let and = expr("1 && a");
    // rust: assert_eq!([5.0, 0.0].map(|a| and.eval(&[a])), [1.0, 0.0]);
    // rust: assert_eq!(eval("a || b", &[0.0, 7.0]), 1.0);
        // NaN is true.
    // rust: assert_eq!(eval("a && 1", &[f32::NAN]), 1.0);
    // rust: assert_eq!(eval("!a", &[f32::NAN]), 0.0);
    // rust: assert_eq!(eval("if(a, 2, 3)", &[f32::NAN]), 2.0);
    // rust: assert_eq!(value("if(nan, 2, 3)"), 2.0);
}

branches_not_taken_are_not_evaluated :: proc() {
}
        // A `random()` that runs advances the thread's sequence: replay it from one start.
    // rust: RANDOM.with(|s| s.set(12345));
    // rust: let first = value("random()");
    // rust: RANDOM.with(|s| s.set(12345));
    // rust: for (src, slots, want) in [
    // rust: ("if(a, random(), b)", [0.0, 5.0], 5.0),
    // rust: ("if(a > 1, random(), b > 1, random(), 4)", [0.0, 0.0], 4.0),
    // rust: ("a && random()", [0.0, 0.0], 0.0),
    // rust: ("b || random()", [0.0, 1.0], 1.0),
    // rust: ] {
    // rust: assert_eq!(expr(src).eval(&slots), want, "{src}");
}
    // rust: assert_eq!(value("random()"), first);
        // Each condition in order, then the else.
    // rust: let chain = expr("if(a > 2, 10, a > 1, 20, 30)");
    // rust: assert_eq!(
    // rust: [3.0, 1.5, 0.0].map(|a| chain.eval(&[a])),
    // rust: [10.0, 20.0, 30.0]
    // rust: );
}

unseeded_random_differs_between_threads :: proc() {
}
    // rust: let draw = || std::thread::spawn(|| value("random()")).join().unwrap();
    // rust: assert_ne!(draw(), draw());
}

functions :: proc() {
}
    // rust: let pi = std::f32::consts::PI;
    // rust: assert_eq!(value("min(4, 2, 8, 3)"), 2.0);
    // rust: assert_eq!(value("max(4, 2, 8, 3)"), 8.0);
    // rust: assert!(value("min(nan, 1)").is_nan());
    // rust: assert!(eval("max(1, a)", &[f32::NAN]).is_nan());
    // rust: assert_eq!(value("clamp(5, 0, 2)"), 2.0);
    // rust: assert_eq!(value("clamp(-1, 0, 2)"), 0.0);
    // rust: assert_eq!(value("clamp(1 / 0, 0, 2)"), 2.0);
    // rust: assert_eq!(value("clamp(-1 / 0, 0, 2)"), 0.0);
    // rust: assert!(value("clamp(nan, 0, 2)").is_nan());
    // rust: assert!(eval("clamp(a, 0, 2)", &[f32::NAN]).is_nan());
    // rust: assert!(value("clamp(1, 0, nan)").is_nan());
        // Java's `Math.pow`, not C's.
    // rust: assert!(value("pow(1, nan)").is_nan());
    // rust: assert!(eval("pow(a, b)", &[1.0, f32::NAN]).is_nan());
    // rust: assert!(value("pow(1, 1 / 0)").is_nan());
    // rust: assert!(value("pow(-1, -1 / 0)").is_nan());
    // rust: assert!(eval("pow(a, b)", &[-1.0, f32::INFINITY]).is_nan());
    // rust: assert_eq!(value("pow(nan, 0)"), 1.0);
    // rust: assert_eq!(eval("pow(a, 0)", &[f32::NAN]), 1.0);
    // rust: assert_eq!(value("pow(1 / 0, 0)"), 1.0);
    // rust: assert_eq!(value("-7 % 3"), -1.0);
    // rust: assert_eq!(value("fmod(-7, 3)"), 2.0);
    // rust: assert_eq!(value("frac(-1.25)"), 0.75);
    // rust: assert_eq!(value("round(2.5) + round(-2.5)"), 1.0);
    // rust: assert_eq!(value("round(-2.5)"), -2.0);
    // rust: assert_eq!(value("round(0.49999997)"), 0.0);
    // rust: assert_eq!(value("round(16777215)"), 16_777_215.0);
        // An `int`: NaN is 0, the rest stops at its ends.
    // rust: assert_eq!(value("round(nan)"), 0.0);
    // rust: assert_eq!(eval("round(a)", &[f32::NAN]), 0.0);
    // rust: assert_eq!(value("round(1 / 0)"), 2_147_483_648.0);
    // rust: assert_eq!(value("round(-1 / 0)"), -2_147_483_648.0);
    // rust: assert_eq!(value("round(10000000000)"), 2_147_483_648.0);
    // rust: assert_eq!(eval("round(a)", &[-1e10]), -2_147_483_648.0);
    // rust: assert_eq!(value("signum(-3) + signum(0)"), -1.0);
    // rust: assert!(close(value("torad(180)"), pi));
    // rust: assert!(close(value("todeg(pi / 2)"), 90.0));
    // rust: assert_eq!(value("lerp(0.25, 4, 8)"), 5.0);
    // rust: assert_eq!(value("between(2, 1, 3) + between(4, 1, 3)"), 1.0);
    // rust: assert_eq!(value("equals(1, 1.05, 0.1) + in(3, 1, 2, 3)"), 2.0);
    // rust: assert_eq!(value("print(1, 20, 6)"), 6.0);
    // rust: assert_eq!(value("random(4)"), value("random(4)"));
    // rust: assert!((0.0..1.0).contains(&value("random(4)")));
    // rust: assert_eq!(value("catch(0 / 0, 3)"), 3.0);
    // rust: assert_eq!(value("catch(1 / 0, 3)"), f32::INFINITY);
    // rust: assert_eq!(value("catch(2, 3, 1)"), 2.0);
        // `ifb` is a boolean.
    // rust: let ifb = expr("ifb(a, 5, 0)");
    // rust: assert_eq!([1.0, 0.0].map(|a| ifb.eval(&[a])), [1.0, 0.0]);
        // EMF's form; the client has no NBT, so never a match.
    // rust: assert_eq!(value("nbt(SaddleItem, exists:false)"), 0.0);
    // rust: assert_eq!(eval("a + nbt(Tags, raw:(x)) + 1", &[2.0]), 3.0);
        // The runtime path of the maths.
    // rust: let atan2 = expr("atan2(a, 1)");
    // rust: assert!(close(atan2.eval(&[1.0]), pi / 4.0));
    // rust: assert!(close(
    // rust: eval("pow(a, 3) + sqrt(16) + ceil(-1.5) + log(e)", &[2.0]),
    // rust: 12.0
    // rust: ));
        // EMF's documented examples.
    // rust: assert_eq!(value("wrapdeg(370)"), 10.0);
    // rust: assert_eq!(value("wrapdeg(350)"), -10.0);
    // rust: assert_eq!(value("degdiff(10, 350)"), -20.0);
    // rust: assert_eq!(value("degdiff(10, 370)"), 0.0);
}

keyframes_and_curves :: proc() {
}
    // rust: let at = |k: f32, f: &str| eval(&format!("{f}(a, 5, 10, 20)"), &[k]);
    // rust: assert_eq!(at(0.0, "keyframe"), 5.0);
    // rust: assert_eq!(at(1.0, "keyframe"), 10.0);
    // rust: assert_eq!(at(1.5, "keyframe"), 15.0);
    // rust: assert_eq!(at(7.0, "keyframe"), 20.0);
    // rust: assert_eq!(at(-1.5, "keyframe"), 15.0);
    // rust: assert_eq!(at(f32::INFINITY, "keyframe"), 20.0);
    // rust: assert!(at(f32::NAN, "keyframe").is_nan());
    // rust: assert!(at(f32::INFINITY, "keyframeloop").is_nan());
    // rust: assert_eq!(value("keyframe(1 / 0, 5, 10)"), 10.0);
        // The loop goes from the last frame back to the first.
    // rust: assert_eq!(at(2.5, "keyframeloop"), 12.5);
    // rust: assert_eq!(at(3.5, "keyframeloop"), 7.5);
        // A long track: frames 0 to 299, deeper than the fixed stack, more arguments than a byte
        // counts.
    // rust: let frames: Vec<String> = (0..300).map(|i| i.to_string()).collect();
    // rust: let track = expr(&format!("keyframe(a, {})", frames.join(", ")));
    // rust: assert_eq!(track.eval(&[298.5]), 298.5);
    // rust: assert_eq!(track.eval(&[3.0]), 3.0);
    // rust: assert_eq!(track.eval(&[1000.0]), 299.0);
        // Ends of every curve are its two values.
    // rust: for f in [
    // rust: "easeinoutexpo",
    // rust: "easeinquad",
    // rust: "easeoutbounce",
    // rust: "easeinoutelastic",
    // rust: "easeinoutback",
    // rust: "easeincirc",
    // rust: "easeoutsine",
    // rust: "easeinoutquint",
    // rust: "easeoutelastic",
    // rust: "easeinbounce",
    // rust: ] {
    // rust: assert!(close(eval(&format!("{f}(a, 2, 6)"), &[0.0]), 2.0), "{f}");
    // rust: assert!(close(eval(&format!("{f}(a, 2, 6)"), &[1.0]), 6.0), "{f}");
}
    // rust: assert_eq!(value("easeinquad(0.5, 0, 8)"), 2.0);
    // rust: assert_eq!(value("easeoutquad(0.5, 0, 8)"), 6.0);
        // Mid-curve, from 0 to 1.
    // rust: for (f, t, want) in [
    // rust: ("easeoutbounce", 0.5, 0.765625),
    // rust: ("easeoutelastic", 0.5, 1.015625),
    // rust: ("easeinoutexpo", 0.25, 0.015625),
    // rust: ("easeinoutcubic", 0.25, 0.0625),
    // rust: ("easeinback", 0.5, -0.0876975),
    // rust: ] {
    // rust: let got = eval(&format!("{f}(a, 0, 1)"), &[t]);
    // rust: assert!(close(got, want), "{f}({t}) = {got}, not {want}");
}
    // rust: assert_eq!(value("quadbezier(0.5, 0, 4, 2)"), 2.0);
    // rust: assert_eq!(value("cubicbezier(0.5, 0, 8, 0, 8)"), 4.0);
    // rust: assert_eq!(value("catmullrom(0, 0, 1, 2, 3)"), 1.0);
    // rust: assert_eq!(value("catmullrom(1, 0, 1, 2, 3)"), 2.0);
    // rust: assert_eq!(value("hermite(1, 3, 7, 0, 0)"), 7.0);
}

constants_fold :: proc() {
}
    // rust: let pi = std::f32::consts::PI;
    // rust: assert!(close(expr("torad(180)").constant().unwrap(), pi));
    // rust: assert_eq!(expr("if(true, 2, a)").constant(), Some(2.0));
    // rust: assert_eq!(expr("if(false, a, 1 > 0, 3, b)").constant(), Some(3.0));
    // rust: assert_eq!(expr("0 && a").constant(), Some(0.0));
    // rust: assert_eq!(expr("1 || a").constant(), Some(1.0));
    // rust: assert_eq!(expr("random()").constant(), None);
    // rust: assert_eq!(expr("a + 1").constant(), None);
        // A false branch goes; the variable ones stay.
    // rust: let partly = expr("if(false, a, b > 1, b, 4)");
    // rust: assert!(!partly.code.iter().any(|op| matches!(op, Op::Slot(0))));
    // rust: assert_eq!(partly.eval(&[9.0, 2.0]), 2.0);
    // rust: assert_eq!(partly.eval(&[9.0, 0.0]), 4.0);
}

errors_say_where :: proc() {
}
    // rust: let e = |src: &str| compile(src, &mut names).unwrap_err();
    // rust: assert_eq!(e("a + nope").offset, 4);
    // rust: assert!(e("a + nope").message.contains("nope"));
    // rust: assert_eq!(e("sinh(a)").offset, 0);
    // rust: assert!(e("clamp(1, 2)").message.contains("arguments"));
    // rust: assert!(e("if(a, b)").message.contains("if"));
    // rust: assert_eq!(e("(a + 1").offset, 6);
    // rust: assert_eq!(e("a + 1)").offset, 5);
    // rust: assert_eq!(e("a # b").offset, 2);
    // rust: assert_eq!(e("nbt(SaddleItem, (x)").offset, 19);
        // The 65th bracket is one too many.
    // rust: let deep = format!("{}a{}", "(a + ".repeat(70), ")".repeat(70));
    // rust: assert!(e(&deep).message.contains("deep"));
    // rust: assert_eq!(e(&deep).offset, 64 * 5);
    // rust: assert!(compile(&format!("{}a", "-".repeat(64)), &mut names).is_ok());
    // rust: assert!(e(&format!("{}a", "-".repeat(65))).message.contains("deep"));
    // rust: let calls = format!("{}a{}", "abs(".repeat(65), ")".repeat(65));
    // rust: assert_eq!(e(&calls).offset, 64 * 4 + 3);
        // A long chain fails instead of folding thousands deep, somewhere inside the chain.
    // rust: let long = ["a"; 2000].join("+");
    // rust: assert!(e(&long).message.contains("long"));
    // rust: assert!((1..long.len()).contains(&e(&long).offset));
        // `a+a...` is 2n - 1 nodes: 512 terms are 1023, under the cap of 1024, and run on a
        // shallow stack; 513 terms are 1025, one too many.
    // rust: let most = expr(&["a"; 512].join("+"));
    // rust: assert_eq!(most.eval(&[1.0]), 512.0);
    // rust: assert!(most.depth <= STACK);
    // rust: assert!(e(&["a"; 513].join("+")).message.contains("long"));
}
}
