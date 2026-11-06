//! Transpiled from Horizon Rust crate
package horizon_command_packrat

import "core:fmt"
import "core:mem"
import "core:math"

// A port of vanilla's packrat parsing library (`net.minecraft.util.parsing.packrat`):
// terms, named rules with per-position memoisation, scopes with frames,
// cuts, and the "longest only" error collector whose entries become both
// the parse error and the completion suggestions.
// use super::{CmdResult, CommandError, Reader, SuggestionsBuilder, args};
// use std::collections::HashMap;
// use std::rc::Rc;

    // rust: pub type Atom = &'static str;
    // rust: pub type RuleId = usize;

// A value a rule produces (an element of `Scope`).
    // rust: pub trait Value: Clone {
list :: proc(items: [dynamic]Self) -> S {
    // Ported from Horizon
    return {}
}
}

// Why a term failed (DelayedException or a ready exception).
Reason :: enum {
    // A translatable exception created at the error cursor.
    Delayed(&'static str, Vec<String>),
    // An exception with its own cursor.
    Error(CommandError),
}

// SuggestionSupplier.
Sugg :: enum {
    Empty,
    Values(Rc<Vec<String>>),
    // ResourceSuggestion: ids completed with suggestResource.
    Resources(Rc<Vec<String>>),
}

Key :: enum {
    Frame(usize),
    Atom(Atom),
}

// Scope: a stack of frames of atom values.
Scope :: struct {
    stack: Vec<(Key,
    top_entry: uint,
    top_marker: uint,
}
    // rust: impl<V: Clone> Scope<V> {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: stack: vec![(Key::Frame(0), None)],
    // rust: top_entry: 0,
    // rust: top_marker: 0,
}
}
set :: proc(self: ^Self, i: uint, key: Key, value: Maybe(V)) {
}
    // rust: while self.stack.len() <= i {
    // rust: self.stack.push((Key::Frame(0), None));
}
    // rust: self.stack[i] = (key, value);
}
value_index :: proc(self: ^Self, atoms: ^[Atom]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut i = self.top_entry;
    // rust: while i > self.top_marker {
    // rust: if let Key::Atom(a) = self.stack[i].0
    // rust: && atoms.contains(&a)
    // rust: {
    // rust: return Some(i);
}
    // rust: i -= 1;
}
    // rust: None
}
setup_new_frame :: proc(self: ^Self) {
}
    // rust: self.top_entry += 1;
    // rust: let prev = self.top_marker;
    // rust: self.set(self.top_entry, Key::Frame(prev), None);
    // rust: self.top_marker = self.top_entry;
}
previous_marker :: proc(self: ^Self, marker: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self.stack[marker].0 {
    // rust: Key::Frame(p) => p,
    // rust: Key::Atom(_) => 0,
}
}
push_frame :: proc(self: ^Self) {
}
    // rust: self.setup_new_frame();
}
pop_frame :: proc(self: ^Self) {
}
    // rust: let marker = self.top_marker;
    // rust: self.top_entry = marker - 1;
    // rust: self.top_marker = self.previous_marker(marker);
}
split_frame :: proc(self: ^Self) {
}
    // rust: let current = self.top_marker;
    // rust: let n = self.top_entry - self.top_marker;
    // rust: self.setup_new_frame();
    // rust: let mut target = self.top_entry;
    // rust: for source in current + 1..current + 1 + n {
    // rust: target += 1;
    // rust: let key = self.stack[source].0;
    // rust: self.set(target, key, None);
}
    // rust: self.top_entry = target;
}
clear_frame_values :: proc(self: ^Self) {
}
    // rust: let mut i = self.top_entry;
    // rust: while i > self.top_marker {
    // rust: self.stack[i].1 = None;
    // rust: i -= 1;
}
}
merge_frame :: proc(self: ^Self) {
}
    // rust: let previous_marker = self.previous_marker(self.top_marker);
    // rust: let mut previous = previous_marker;
    // rust: let mut current = self.top_marker;
    // rust: while current < self.top_entry {
    // rust: previous += 1;
    // rust: current += 1;
    // rust: let (new_key, new_value) = self.stack[current].clone();
    // rust: let old_key = self.stack.get(previous).map(|e| e.0);
    // rust: if old_key != Some(new_key) {
    // rust: self.set(previous, new_key, new_value);
    // rust: } else if new_value.is_some() {
    // rust: self.stack[previous].1 = new_value;
}
}
    // rust: self.top_entry = previous;
    // rust: self.top_marker = previous_marker;
}
put :: proc(self: ^Self, atom: Atom, value: V) {
}
    // rust: match self.value_index(&[atom]) {
    // rust: Some(i) => self.stack[i].1 = Some(value),
    // rust: None => {
    // rust: self.top_entry += 1;
    // rust: self.set(self.top_entry, Key::Atom(atom), Some(value));
}
}
}
get :: proc(self: ^Self, atom: Atom) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.value_index(&[atom])
    // rust: .and_then(|i| self.stack[i].1.clone())
}
    // Scope.getAny: the newest of several atoms.
get_any :: proc(self: ^Self, atoms: ^[Atom]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.value_index(atoms)
    // rust: .and_then(|i| self.stack[i].1.clone())
}
    // Whether the atom has an entry (even a null one).
has :: proc(self: ^Self, atom: Atom) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.value_index(&[atom]).is_some()
}
}

// A rule: a term with an action, or hand-written parsing.
Rule :: enum {
    Term(Term<V>, Rc<dyn Fn(&mut State<V>) -> Option<V>>),
    Custom(Rc<dyn Fn(&mut State<V>) -> Option<V>>),
}

Term :: enum {
    Seq(Vec<Term<V>>),
    Alt(Vec<Term<V>>),
    Opt(Box<Term<V>>),
    Repeated {,
    rule: RuleId,
    list: Atom,
    min: usize,
    // rust: },
    RepeatedSep {,
    rule: RuleId,
    list: Atom,
    sep: Box<Term<V>>,
    min: usize,
    trailing: bool,
    // rust: },
    Look(Box<Term<V>>, bool),
    Marker(Atom, V),
    Cut,
    Empty,
    Fail(Reason),
    Named {,
    rule: RuleId,
    store: Atom,
    // rust: },
    // StringReaderTerms.TerminalCharacters: one of `values` (or `accept`).
    Chars {,
    values: Vec<char>,
    accept: Option<fn(char) -> bool>,
    // rust: },
    // StringReaderTerms.TerminalWord.
    Word(String),
}

    // rust: pub fn seq<V>(t: Vec<Term<V>>) -> Term<V> {
    // rust: Term::Seq(t)
}
    // rust: pub fn alt<V>(t: Vec<Term<V>>) -> Term<V> {
    // rust: Term::Alt(t)
}
    // rust: pub fn opt<V>(t: Term<V>) -> Term<V> {
    // rust: Term::Opt(Box::new(t))
}
    // rust: pub fn ch<V>(c: char) -> Term<V> {
    // rust: Term::Chars {
    // rust: values: vec![c],
    // rust: accept: None,
}
}
    // rust: pub fn chs<V>(a: char, b: char) -> Term<V> {
    // rust: Term::Chars {
    // rust: values: vec![a, b],
    // rust: accept: None,
}
}
    // rust: pub fn look<V>(t: Term<V>) -> Term<V> {
    // rust: Term::Look(Box::new(t), true)
}

// Dictionary: named rules, with forward references.
Grammar :: struct {
    names: [dynamic]Atom,
    rules: [dynamic]Maybe(Rule<V)>,
    top: RuleId,
}
    // rust: impl<V: Value> Default for Grammar<V> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new()
}
}
    // rust: impl<V: Value> Grammar<V> {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: names: Vec::new(),
    // rust: rules: Vec::new(),
    // rust: top: 0,
}
}
    // Dictionary.forward / getOrCreateEntry.
id :: proc(self: ^Self, name: Atom) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(i) = self.names.iter().position(|n| *n == name) {
    // rust: return i;
}
    // rust: self.names.push(name);
    // rust: self.rules.push(None);
    // rust: self.names.len() - 1
}
put :: proc(self: ^Self, name: Atom, rule: Rule<V>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = self.id(name);
    // rust: assert!(self.rules[id].is_none(), "Trying to override rule: {name}");
    // rust: self.rules[id] = Some(rule);
    // rust: id
}
    // rust: pub fn put_term(
    // rust: &mut self,
    // rust: name: Atom,
    // rust: term: Term<V>,
    // rust: action: impl Fn(&mut State<V>) -> Option<V> + 'static,
    // rust: ) -> RuleId {
    // rust: self.put(name, Rule::Term(term, Rc::new(action)))
}
    // rust: pub fn put_custom(
    // rust: &mut self,
    // rust: name: Atom,
    // rust: f: impl Fn(&mut State<V>) -> Option<V> + 'static,
    // rust: ) -> RuleId {
    // rust: self.put(name, Rule::Custom(Rc::new(f)))
}
    // Dictionary.named: parse the rule and store it under its own name.
named :: proc(self: ^Self, name: Atom) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let rule = self.id(name);
    // rust: Term::Named { rule, store: name }
}
    // Dictionary.namedWithAlias.
named_as :: proc(self: ^Self, name: Atom, store: Atom) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let rule = self.id(name);
    // rust: Term::Named { rule, store }
}

    // Grammar.parseForCommands: parse at the reader's cursor; on failure
    // the first error stored at the furthest position.
parse_for_commands :: proc(self: ^Self, reader: ^Reader) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.parse_for_commands_with(reader, None)
}
    // parse_for_commands with a context value the rules can read (`State::ctx`).
    // rust: pub fn parse_for_commands_with(
    // rust: &self,
    // rust: reader: &mut Reader,
    // rust: ctx: Option<&dyn std::any::Any>,
    // rust: ) -> CmdResult<V> {
    // rust: let mut state = State::new(self, reader.string, reader.cursor);
    // rust: state.ctx = ctx;
    // rust: let result = state.parse_top();
    // rust: reader.cursor = state.cursor;
    // rust: match result {
    // rust: Some(v) => Ok(v),
    // rust: None => Err(state.first_error()),
}
}
    // Grammar.parseForSuggestions.
parse_for_suggestions :: proc(self: ^Self, builder: ^SuggestionsBuilder) {
}
    // rust: self.parse_for_suggestions_with(builder, None)
}
    // rust: pub fn parse_for_suggestions_with(
    // rust: &self,
    // rust: builder: &mut SuggestionsBuilder,
    // rust: ctx: Option<&dyn std::any::Any>,
    // rust: ) {
    // rust: let mut state = State::new(self, builder.input, builder.start);
    // rust: state.ctx = ctx;
    // rust: state.parse_top();
    // rust: if state.errors.is_empty() {
    // rust: return;
}
    // rust: let mut offset = builder.offset(state.last_cursor.max(0) as usize);
    // rust: for (sugg, _) in &state.errors {
    // rust: match sugg {
    // rust: Sugg::Empty => {}
    // rust: Sugg::Values(v) => offset.suggest_matching(v.iter().map(String::as_str)),
    // rust: Sugg::Resources(ids) => args::suggest_resources(&mut offset, ids.iter(), ""),
}
}
    // rust: builder.add(offset);
}
}

// CachedParseState over a string (StringReaderParserState) with a
// LongestOnly error collector.
State :: struct {
    grammar: ^'g Grammar<V>,
    input: ^'g str,
    cursor: uint,
    cache: HashMap<(uint,
    scope: Scope<V>,
    controls: [dynamic]bool,
    errors: Vec<(Sugg,
    last_cursor: int,
    // Current rule-recursion depth, bounded by `MAX_DEPTH` so a crafted
    // deeply nested value (SNBT compound/list or a JSON text component's
    // `extra` chain) fails to parse instead of overflowing the stack.
    depth: uint,
    // Context for the rules (e.g. the registries a lookup checks).
    ctx: Maybe(^'g dyn std::any::Any),
}
// The deepest rule nesting the parser accepts. A level of SNBT nesting costs
// about four rules: 256 takes 63 nested compounds, 36 levels of a text
// component's `extra` list, or 13 containers in an item in a container. It
// stays under the stack overflow of a 2 MiB thread (the server thread's,
// Rust's default) in a debug build, where frames are largest: 384 overflows.
MAX_DEPTH :: 256
UNBOUND :: usize::MAX
    // rust: impl<'g, V: Value> State<'g, V> {
new :: proc(grammar: ^'g Grammar<V>, input: ^'g str, cursor: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: grammar,
    // rust: input,
    // rust: cursor,
    // rust: cache: HashMap::new(),
    // rust: scope: Scope::new(),
    // rust: controls: Vec::new(),
    // rust: errors: Vec::new(),
    // rust: last_cursor: -1,
    // rust: depth: 0,
    // rust: ctx: None,
}
}
reader :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Reader {
    // rust: string: self.input,
    // rust: cursor: self.cursor,
}
}
set_reader :: proc(self: ^Self, r: ^Reader) {
}
    // rust: self.cursor = r.cursor;
}
discard_shorter :: proc(self: ^Self, cursor: uint) {
}
    // rust: if cursor as isize > self.last_cursor {
    // rust: self.last_cursor = cursor as isize;
    // rust: self.errors.clear();
}
}
    // ErrorCollector.store.
store :: proc(self: ^Self, cursor: uint, sugg: Sugg, reason: Reason) {
}
    // rust: self.discard_shorter(cursor);
    // rust: if cursor as isize == self.last_cursor {
    // rust: self.errors.push((sugg, reason));
}
}
store_at_mark :: proc(self: ^Self, reason: Reason) {
}
    // rust: self.store(self.cursor, Sugg::Empty, reason);
}
parse_top :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let r = self.parse(self.grammar.top);
    // rust: if r.is_some() {
    // rust: self.discard_shorter(self.cursor);
}
    // rust: r
}
first_error :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: if let Some((_, reason)) = self.errors.first() {
    // rust: return match reason {
    // rust: Reason::Delayed(key, args) => {
    // rust: let args: Vec<&dyn std::fmt::Display> =
    // rust: args.iter().map(|a| a as &dyn std::fmt::Display).collect();
    // rust: CommandError::tr_at(
    // rust: key,
    // rust: &args,
    // rust: &Reader {
    // rust: string: self.input,
    // rust: cursor: self.last_cursor.max(0) as usize,
    // rust: },
    // rust: )
}
    // rust: Reason::Error(e) => e.clone(),
}
}
    // rust: CommandError::new(horizon_client_core::text::Text::literal("Failed to parse"))
}
    // CachedParseState.parse: a named rule, memoised per position.
parse :: proc(self: ^Self, rule: RuleId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mark = self.cursor;
    // rust: if let Some(entry) = self.cache.get(&(mark, rule)) {
    // rust: return match entry {
    // rust: None => None,
    // rust: Some((v, after)) => {
    // rust: let v = v.clone();
    // rust: self.cursor = *after;
    // rust: Some(v)
}
}
}
    // rust: if self.depth >= MAX_DEPTH {
    // rust: return None;
}
    // rust: self.depth += 1;
    // rust: let result = match self.grammar.rules[rule].as_ref() {
    // rust: Some(Rule::Term(term, action)) => {
    // rust: let action = action.clone();
    // rust: self.scope.push_frame();
    // rust: let ok = self.term(term, UNBOUND, false);
    // rust: let r = if ok { action(self) } else { None };
    // rust: self.scope.pop_frame();
    // rust: r
}
    // rust: Some(Rule::Custom(f)) => {
    // rust: let f = f.clone();
    // rust: f(self)
}
    // rust: None => panic!("Unbound rule {}", self.grammar.names[rule]),
}
    // rust: self.depth -= 1;
    // rust: let entry = result.clone().map(|v| (v, self.cursor));
    // rust: self.cache.insert((mark, rule), entry);
    // rust: result
}
skip_whitespace :: proc(self: ^Self) {
}
    // rust: let mut r = self.reader();
    // rust: r.skip_whitespace();
    // rust: self.cursor = r.cursor;
}
term :: proc(self: ^Self, term: ^'g Term<V>, control: uint, silent: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match term {
    // rust: Term::Seq(items) => {
    // rust: let mark = self.cursor;
    // rust: for t in items {
    // rust: if !self.term(t, control, silent) {
    // rust: self.cursor = mark;
    // rust: return false;
}
}
    // rust: true
}
    // rust: Term::Alt(items) => {
    // rust: self.controls.push(false);
    // rust: let ctl = self.controls.len() - 1;
    // rust: let mark = self.cursor;
    // rust: self.scope.split_frame();
    // rust: let mut ok = false;
    // rust: for t in items {
    // rust: if self.term(t, ctl, silent) {
    // rust: self.scope.merge_frame();
    // rust: ok = true;
    // rust: break;
}
    // rust: self.scope.clear_frame_values();
    // rust: self.cursor = mark;
    // rust: if self.controls[ctl] {
    // rust: break;
}
}
    // rust: if !ok {
    // rust: self.scope.pop_frame();
}
    // rust: self.controls.pop();
    // rust: ok
}
    // rust: Term::Opt(t) => {
    // rust: let mark = self.cursor;
    // rust: if !self.term(t, control, silent) {
    // rust: self.cursor = mark;
}
    // rust: true
}
    // rust: Term::Repeated { rule, list, min } => {
    // rust: let mark = self.cursor;
    // rust: let mut items = Vec::new();
    // rust: loop {
    // rust: let entry = self.cursor;
    // rust: match self.parse(*rule) {
    // rust: Some(v) => items.push(v),
    // rust: None => {
    // rust: self.cursor = entry;
    // rust: if items.len() < *min {
    // rust: self.cursor = mark;
    // rust: return false;
}
    // rust: self.scope.put(list, V::list(items));
    // rust: return true;
}
}
}
}
    // rust: Term::RepeatedSep {
    // rust: rule,
    // rust: list,
    // rust: sep,
    // rust: min,
    // rust: trailing,
    // rust: } => {
    // rust: let list_mark = self.cursor;
    // rust: let mut items = Vec::new();
    // rust: let mut first = true;
    // rust: loop {
    // rust: let before = self.cursor;
    // rust: if !first && !self.term(sep, control, silent) {
    // rust: self.cursor = before;
    // rust: break;
}
    // rust: let after = self.cursor;
    // rust: match self.parse(*rule) {
    // rust: Some(v) => items.push(v),
    // rust: None => {
    // rust: if first {
    // rust: self.cursor = after;
    // rust: } else {
    // rust: if !*trailing {
    // rust: self.cursor = list_mark;
    // rust: return false;
}
    // rust: self.cursor = after;
}
    // rust: break;
}
}
    // rust: first = false;
}
    // rust: if items.len() < *min {
    // rust: self.cursor = list_mark;
    // rust: return false;
}
    // rust: self.scope.put(list, V::list(items));
    // rust: true
}
    // rust: Term::Look(t, positive) => {
    // rust: let mark = self.cursor;
    // rust: let r = self.term(t, control, true);
    // rust: self.cursor = mark;
    // rust: *positive == r
}
    // rust: Term::Marker(atom, v) => {
    // rust: self.scope.put(atom, v.clone());
    // rust: true
}
    // rust: Term::Cut => {
    // rust: if control != UNBOUND {
    // rust: self.controls[control] = true;
}
    // rust: true
}
    // rust: Term::Empty => true,
    // rust: Term::Fail(reason) => {
    // rust: if !silent {
    // rust: self.store(self.cursor, Sugg::Empty, reason.clone());
}
    // rust: false
}
    // rust: Term::Named { rule, store } => match self.parse(*rule) {
    // rust: Some(v) => {
    // rust: self.scope.put(store, v);
    // rust: true
}
    // rust: None => false,
    // rust: },
    // rust: Term::Chars { values, accept } => {
    // rust: self.skip_whitespace();
    // rust: let cursor = self.cursor;
    // rust: let mut r = self.reader();
    // rust: if r.can_read() {
    // rust: let c = r.read();
    // rust: self.cursor = r.cursor;
    // rust: let ok = match accept {
    // rust: Some(f) => f(c),
    // rust: None => values.contains(&c),
}
    // rust: if ok {
    // rust: return true;
}
}
    // rust: if !silent {
    // rust: let joined = values
    // rust: .iter()
    // rust: .map(char::to_string)
    // rust: .collect::<Vec<_>>()
    // rust: .join("|");
    // rust: let sugg = Sugg::Values(Rc::new(values.iter().map(char::to_string).collect()));
    // rust: self.store(
    // rust: cursor,
    // rust: sugg,
    // rust: Reason::Delayed("argument.literal.incorrect", vec![joined]),
    // rust: );
}
    // rust: false
}
    // rust: Term::Word(word) => {
    // rust: self.skip_whitespace();
    // rust: let cursor = self.cursor;
    // rust: let mut r = self.reader();
    // rust: let value = r.read_unquoted_string();
    // rust: self.cursor = r.cursor;
    // rust: if value != word {
    // rust: if !silent {
    // rust: self.store(
    // rust: cursor,
    // rust: Sugg::Values(Rc::new(vec![word.clone()])),
    // rust: Reason::Delayed("argument.literal.incorrect", vec![word.clone()]),
    // rust: );
}
    // rust: return false;
}
    // rust: true
}
}
}
}
