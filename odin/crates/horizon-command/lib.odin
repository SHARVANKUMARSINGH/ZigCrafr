//! Transpiled from Horizon Rust crate
package horizon_command_lib

import "core:fmt"
import "core:mem"
import "core:math"

// A port of Brigadier (the command library vanilla uses): a string reader,
// literal/argument node trees with redirects, parsing that tries every
// relevant child and keeps the best result, completion suggestions, smart
// usage text and the vanilla error messages. Argument types live in
// [`args`]; the vanilla command tree in [`vanilla`].
    // rust: pub mod args;
    // rust: pub mod block;
    // rust: pub mod codec;
    // rust: pub mod component;
    // rust: pub mod item;
    // rust: pub mod network;
    // rust: pub mod packrat;
    // rust: pub mod selector;
    // rust: pub mod snbt;
    // rust: pub mod tree_data;
    // rust: pub mod tree_execute;
    // rust: pub mod tree_extra;
    // rust: pub mod tree_misc;
    // rust: pub mod tree_scoreboard;
    // rust: pub mod tree_world;
    // rust: pub mod vanilla;
    // rust: mod vanilla_order;

    // rust: pub use args::{Arg, ArgType, CustomCompletionAction, Registries, modify_custom_completions};
// use horizon_client_core::text::Text;

// The command id of a mod's command (`Dispatcher::with_mod_commands`).
MOD_COMMAND :: "mod"

// A command error (CommandSyntaxException): the message and, for parse
// errors, the input and cursor it occurred at.
CommandError :: struct {
    message: Text,
    input: Maybe(string),
    cursor: uint,
    // BuiltInExceptions.literalIncorrect (summarised specially by the chat UI).
    literal_incorrect: bool,
    // The translation key of the exception type, when known (the
    // exception "type" vanilla code compares against).
    key: string,
}
    // rust: impl CommandError {
new :: proc(message: Text) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: message,
    // rust: input: None,
    // rust: cursor: 0,
    // rust: literal_incorrect: false,
    // rust: key: String::new(),
}
}
tr :: proc(key: string, args: ^[^dyn std::fmt::Display]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut e = Self::new(Text::tr(key, args));
    // rust: e.key = key.to_owned();
    // rust: e
}
at :: proc(message: Text, reader: ^Reader) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: message,
    // rust: input: Some(reader.string.to_owned()),
    // rust: cursor: reader.cursor,
    // rust: literal_incorrect: false,
    // rust: key: String::new(),
}
}
tr_at :: proc(key: string, args: ^[^dyn std::fmt::Display], reader: ^Reader) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut e = Self::at(Text::tr(key, args), reader);
    // rust: e.key = key.to_owned();
    // rust: e
}
    // CommandSyntaxException.getContext: up to ten characters before the
    // cursor followed by "<--[HERE]".
context :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let input = self.input.as_ref()?;
    // rust: let cursor = self.cursor.min(input.len());
    // rust: let start = (0..=cursor.saturating_sub(10))
    // rust: .rev()
    // rust: .find(|&i| input.is_char_boundary(i))
    // rust: .unwrap_or(0);
    // rust: let mut out = String::new();
    // rust: if cursor > 10 {
    // rust: out.push_str("...");
}
    // rust: out.push_str(&input[start..cursor]);
    // rust: out.push_str("<--[HERE]");
    // rust: Some(out)
}
    // The message as shown by command suggestions ("... at position N: ...").
with_context :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match self.context() {
    // rust: Some(context) => Text::translate(
    // rust: "command.context.parse_error",
    // rust: &[
    // rust: self.message.clone(),
    // rust: Text::literal(self.cursor.to_string()),
    // rust: Text::literal(context),
    // rust: ],
    // rust: ),
    // rust: None => self.message.clone(),
}
}
}
    // rust: pub type CmdResult<T> = Result<T, CommandError>;

// Brigadier StringReader over a command line (byte cursor on char boundaries).
Reader :: struct {
    string: ^'a str,
    cursor: uint,
}
    // rust: impl<'a> Reader<'a> {
new :: proc(string: ^'a str) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { string, cursor: 0 }
}
can_read :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.cursor < self.string.len()
}
can_read_n :: proc(self: ^Self, n: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.string[self.cursor..].chars().take(n).count() == n
}
peek :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
    // rust: self.string[self.cursor..].chars().next().unwrap_or('\0')
}
peek_at :: proc(self: ^Self, offset: uint) -> c {
    // Ported from Horizon
    return {}
}
    // rust: self.string[self.cursor..]
    // rust: .chars()
    // rust: .nth(offset)
    // rust: .unwrap_or('\0')
}
skip :: proc(self: ^Self) {
}
    // rust: self.cursor += self.peek().len_utf8();
}
read :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let c = self.peek();
    // rust: self.skip();
    // rust: c
}
remaining :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.string[self.cursor..]
}
skip_whitespace :: proc(self: ^Self) {
}
    // rust: while self.can_read() && Self::is_java_whitespace(self.peek()) {
    // rust: self.skip();
}
}
is_java_whitespace :: proc(c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: c,
    // rust: '\t'..='\r'
    // rust: | '\u{1C}'..='\u{20}'
    // rust: | '\u{1680}'
    // rust: | '\u{2000}'..='\u{2006}'
    // rust: | '\u{2008}'..='\u{200A}'
    // rust: | '\u{2028}'
    // rust: | '\u{2029}'
    // rust: | '\u{205F}'
    // rust: | '\u{3000}'
    // rust: )
}
is_allowed_number :: proc(c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: c.is_ascii_digit() || c == '.' || c == '-'
}
is_allowed_in_unquoted :: proc(c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: c.is_ascii_alphanumeric() || matches!(c, '_' | '-' | '.' | '+')
}
read_number_text :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.cursor;
    // rust: while self.can_read() && Self::is_allowed_number(self.peek()) {
    // rust: self.skip();
}
    // rust: &self.string[start..self.cursor]
}
    // rust: fn number<T: std::str::FromStr>(&mut self, kind: &str) -> CmdResult<T> {
    // rust: let start = self.cursor;
    // rust: let text = self.read_number_text();
    // rust: if text.is_empty() {
    // rust: return Err(CommandError::tr_at(
    // rust: &format!("parsing.{kind}.expected"),
    // rust: &[],
    // rust: self,
    // rust: ));
}
        // Java's parsers reject a trailing '.'-less exponent etc. the same way.
    // rust: match text.parse::<T>() {
    // rust: Ok(v) if !(kind == "int" || kind == "long") || !text.contains('.') => Ok(v),
    // rust: _ => {
    // rust: self.cursor = start;
    // rust: Err(CommandError::tr_at(
    // rust: &format!("parsing.{kind}.invalid"),
    // rust: &[&text],
    // rust: self,
    // rust: ))
}
}
}
read_int :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.number("int")
}
read_double :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.number("double")
}
read_float :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.number("float")
}
read_unquoted_string :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.cursor;
    // rust: while self.can_read() && Self::is_allowed_in_unquoted(self.peek()) {
    // rust: self.skip();
}
    // rust: &self.string[start..self.cursor]
}
read_string_until :: proc(self: ^Self, terminator: char) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: let mut escaped = false;
    // rust: while self.can_read() {
    // rust: let c = self.read();
    // rust: if escaped {
    // rust: if c == terminator || c == '\\' {
    // rust: out.push(c);
    // rust: escaped = false;
    // rust: } else {
    // rust: self.cursor -= c.len_utf8();
    // rust: return Err(CommandError::tr_at("parsing.quote.escape", &[&c], self));
}
    // rust: } else if c == '\\' {
    // rust: escaped = true;
    // rust: } else if c == terminator {
    // rust: return Ok(out);
    // rust: } else {
    // rust: out.push(c);
}
}
    // rust: Err(CommandError::tr_at("parsing.quote.expected.end", &[], self))
}
read_string :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: if !self.can_read() {
    // rust: return Ok(String::new());
}
    // rust: let next = self.peek();
    // rust: if next == '"' || next == '\'' {
    // rust: self.skip();
    // rust: return self.read_string_until(next);
}
    // rust: Ok(self.read_unquoted_string().to_owned())
}
read_boolean :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let start = self.cursor;
    // rust: let value = self.read_string()?;
    // rust: if value.is_empty() {
    // rust: return Err(CommandError::tr_at("parsing.bool.expected", &[], self));
}
    // rust: match value.as_str() {
    // rust: "true" => Ok(true),
    // rust: "false" => Ok(false),
    // rust: _ => {
    // rust: self.cursor = start;
    // rust: Err(CommandError::tr_at("parsing.bool.invalid", &[&value], self))
}
}
}
expect :: proc(self: ^Self, c: char) -> C {
    // Ported from Horizon
    return {}
}
    // rust: if !self.can_read() || self.peek() != c {
    // rust: return Err(CommandError::tr_at("parsing.expected", &[&c], self));
}
    // rust: self.skip();
    // rust: Ok(())
}
}

    // rust: pub type Range = (usize, usize);
NodeKind :: enum {
    Root,
    Literal(String),
    Argument { name: String, ty: ArgType },
}
Node :: struct {
    kind: NodeKind,
    children: [dynamic]uint,
    // The command id run when parsing ends here.
    command: Maybe(^'static str),
    redirect: Maybe(uint),
    // Required permission level (0 everyone, 2 game masters, 4 owners).
    permission: u8,
    // A custom suggestion provider (`.suggests(...)`), used instead of the
    // argument type's own suggestions.
    suggests: Maybe(Suggests),
    // ArgumentNodeStub's RESTRICTED_COMMAND: the server marked this node as
    // needing elevated permissions.
    restricted: bool,
}
// The custom SuggestionProviders vanilla command nodes use.
Suggests :: enum {
    // FunctionCommand.SUGGEST_FUNCTION: `#tags` and functions.
    Functions,
    // A fixed list (SharedSuggestionProvider.suggest).
    Fixed(&'static [&'static str]),
    // No candidates (providers over state an empty world lacks).
    Nothing,
    // AdvancementCommands: the criteria of the parsed `advancement`.
    AdvancementCriteria,
    // SuggestionProviders.SUMMONABLE_ENTITIES (with the type names as tooltips).
    SummonableEntities,
    // TimeCommand.suggestTimeMarkers for the parsed `clock` (or the overworld clock).
    TimeMarkers,
    // TriggerCommand.suggestObjectives: the source's enabled trigger objectives.
    Triggers,
    // ScoreboardCommand.suggestTriggers: trigger objectives some of the
    // parsed `targets` have no score in, or a locked one.
    EnableTriggers,
    // SuggestionProviders.ASK_SERVER: the server completes the node
    // (ClientSuggestionProvider.customSuggestion); nothing locally.
    AskServer,
    // OpCommand: the online players who are not operators.
    NonOperators,
    // DeOpCommands: the operators' names (PlayerList.getOpNames).
    Operators,
    // PardonCommand: the banned players' names (UserBanList.getUserList).
    BannedPlayers,
    // PardonIpCommand: the banned addresses (IpBanList.getUserList).
    BannedIps,
    // WhitelistCommand `add`: the online players who are not whitelisted.
    NonWhitelisted,
    // WhitelistCommand `remove`: the whitelisted names (PlayerList.getWhiteListNames).
    Whitelisted,
}
    // rust: impl Node {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match &self.kind {
    // rust: NodeKind::Root => "",
    // rust: NodeKind::Literal(l) => l,
    // rust: NodeKind::Argument { name, .. } => name,
}
}
    // CommandNode.getUsageText.
usage_text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match &self.kind {
    // rust: NodeKind::Root => String::new(),
    // rust: NodeKind::Literal(l) => l.clone(),
    // rust: NodeKind::Argument { name, .. } => format!("<{name}>"),
}
}
}
ParsedArg :: struct {
    name: string,
    value: Arg,
    range: Range,
}
// CommandContextBuilder: the nodes and arguments parsed so far.
Context :: struct {
    root: uint,
    nodes: Vec<(uint,
    args: [dynamic]ParsedArg,
    command: Maybe(^'static str),
    range: Range,
    child: Maybe(^Context),
    // Literal words parsed so far (mode keywords such as `masked`).
    literals: [dynamic]string,
}
    // rust: impl Context {
new :: proc(root: uint, start: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: root,
    // rust: nodes: Vec::new(),
    // rust: args: Vec::new(),
    // rust: command: None,
    // rust: range: (start, start),
    // rust: child: None,
    // rust: literals: Vec::new(),
}
}
    // Whether the literal `word` was parsed (in this context).
has :: proc(self: ^Self, word: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.literals.iter().any(|l| l == word)
}
with_node :: proc(self: ^Self, node: uint, range: Range) {
}
    // rust: self.nodes.push((node, range));
    // rust: self.range = (self.range.0.min(range.0), self.range.1.max(range.1));
}
last_child :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let mut c = self;
    // rust: while let Some(child) = &c.child {
    // rust: c = child;
}
    // rust: c
}
get :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.args
    // rust: .iter()
    // rust: .rev()
    // rust: .find(|a| a.name == name)
    // rust: .map(|a| &a.value)
}
    // CommandContextBuilder.findSuggestionContext: the node whose children
    // complete the text at `cursor`, and where that text starts.
suggestion_context :: proc(self: ^Self, cursor: uint) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if self.range.1 < cursor {
    // rust: if let Some(child) = &self.child {
    // rust: return child.suggestion_context(cursor);
}
    // rust: if let Some((node, range)) = self.nodes.last() {
    // rust: return (*node, range.1 + 1, self);
}
    // rust: return (self.root, self.range.0, self);
}
    // rust: let mut prev = self.root;
    // rust: for (node, range) in &self.nodes {
    // rust: if range.0 <= cursor && cursor <= range.1 {
    // rust: return (prev, range.0, self);
}
    // rust: prev = *node;
}
    // rust: (prev, self.range.0, self)
}
}
ParseResults :: struct {
    context: Context,
    input: string,
    cursor: uint,
    errors: Vec<(uint,
}
    // rust: impl ParseResults {
can_read :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.cursor < self.input.len()
}
    // Commands.getParseException.
error :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.can_read() {
    // rust: return None;
}
    // rust: if self.errors.len() == 1 {
    // rust: return Some(self.errors[0].1.clone());
}
    // rust: let reader = Reader {
    // rust: string: &self.input,
    // rust: cursor: self.cursor,
}
    // rust: Some(if self.context.range.0 == self.context.range.1 {
    // rust: CommandError::tr_at("command.unknown.command", &[], &reader)
    // rust: } else {
    // rust: CommandError::tr_at("command.unknown.argument", &[], &reader)
    // rust: })
}
    // ClientPacketListener.isValidCommand: all of it read, no errors, and it
    // ends on a node that runs something.
is_valid :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.can_read() && self.errors.is_empty() && self.context.last_child().command.is_some()
}
    // SignableCommand.of: the message arguments a signed command signs, by
    // name, with their text, not past a redirect to the root (`execute ...
    // run`). `dispatcher` is the one that made this parse.
signable_arguments :: proc(self: ^Self, dispatcher: ^Dispatcher) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let root = self.context.root;
    // rust: let mut out = Vec::new();
    // rust: let mut context = Some(&self.context);
    // rust: while let Some(c) = context {
    // rust: for &(node, (start, end)) in &c.nodes {
    // rust: if let NodeKind::Argument {
    // rust: ty: ArgType::Message,
    // rust: name,
    // rust: } = &dispatcher.nodes[node].kind
    // rust: && let Some(text) = self.input.get(start..end)
    // rust: {
    // rust: out.push((name.clone(), text.to_owned()));
}
}
    // rust: context = c.child.as_deref().filter(|child| child.root != root);
}
    // rust: out
}
    // The executable context and command id, or the vanilla error.
executable :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(e) = self.error() {
    // rust: return Err(e);
}
    // rust: let last = self.context.last_child();
    // rust: match last.command {
    // rust: Some(id) => Ok((last, id)),
    // rust: None => Err(CommandError::tr_at(
    // rust: "command.unknown.command",
    // rust: &[],
    // rust: &Reader {
    // rust: string: &self.input,
    // rust: cursor: self.cursor,
    // rust: },
    // rust: )),
}
}
}
// A completion: replace `range` of the input with `text`.
Suggestion :: struct {
    range: Range,
    text: string,
    tooltip: Maybe(string),
    // IntegerSuggestion: sorted numerically against other integers.
    int_value: Maybe(i32),
}
    // rust: impl Suggestion {
    // Suggestion.apply.
apply :: proc(self: ^Self, input: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (s, e) = (self.range.0.min(input.len()), self.range.1.min(input.len()));
    // rust: format!("{}{}{}", &input[..s], self.text, &input[e..])
}
}
// SuggestionsBuilder: suggestions for the text from `start` to the cursor.
SuggestionsBuilder :: struct {
    input: ^'a str,
    start: uint,
    out: [dynamic]Suggestion,
}
    // rust: impl<'a> SuggestionsBuilder<'a> {
new :: proc(input: ^'a str, start: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: input,
    // rust: start: start.min(input.len()),
    // rust: out: Vec::new(),
}
}
remaining :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.input[self.start..]
}
remaining_lower :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.remaining().to_lowercase()
}
suggest :: proc(self: ^Self, text: impl Into<string>) {
}
    // rust: let text = text.into();
    // rust: if text != self.remaining() {
    // rust: self.out.push(Suggestion {
    // rust: range: (self.start, self.input.len()),
    // rust: text,
    // rust: tooltip: None,
    // rust: int_value: None,
    // rust: });
}
}
    // SuggestionsBuilder.suggest(int).
suggest_int :: proc(self: ^Self, value: i32) {
}
    // rust: self.out.push(Suggestion {
    // rust: range: (self.start, self.input.len()),
    // rust: text: value.to_string(),
    // rust: tooltip: None,
    // rust: int_value: Some(value),
    // rust: });
}
suggest_tooltip :: proc(self: ^Self, text: impl Into<string>, tooltip: impl Into<string>) {
}
    // rust: let text = text.into();
    // rust: if text != self.remaining() {
    // rust: self.out.push(Suggestion {
    // rust: range: (self.start, self.input.len()),
    // rust: text,
    // rust: tooltip: Some(tooltip.into()),
    // rust: int_value: None,
    // rust: });
}
}
offset :: proc(self: ^Self, start: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: SuggestionsBuilder::new(self.input, start)
}
    // SuggestionsBuilder.add: keep another builder's suggestions (with their own ranges).
add :: proc(self: ^Self, other: SuggestionsBuilder) {
}
    // rust: self.out.extend(other.out);
}
    // SharedSuggestionProvider.suggest: candidates matching the remaining
    // text at the start or after a `.`, `_` or `/`.
    // rust: pub fn suggest_matching<'b>(&mut self, candidates: impl IntoIterator<Item = &'b str>) {
    // rust: let lower = self.remaining_lower();
    // rust: for c in candidates {
    // rust: if args::matches_sub_str(&lower, &c.to_lowercase()) {
    // rust: self.suggest(c);
}
}
}
}
// String.compareToIgnoreCase.
compare_ignore_case :: proc(a: string, b: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let fold = |c: char| -> char {
    // rust: let u = c.to_uppercase().next().unwrap_or(c);
    // rust: u.to_lowercase().next().unwrap_or(u)
}
    // rust: let mut x = a.chars();
    // rust: let mut y = b.chars();
    // rust: loop {
    // rust: match (x.next(), y.next()) {
    // rust: (None, None) => return std::cmp::Ordering::Equal,
    // rust: (None, Some(_)) => return std::cmp::Ordering::Less,
    // rust: (Some(_), None) => return std::cmp::Ordering::Greater,
    // rust: (Some(c1), Some(c2)) => {
    // rust: if c1 != c2 {
    // rust: let (l1, l2) = (fold(c1), fold(c2));
    // rust: if l1 != l2 {
    // rust: return l1.cmp(&l2);
}
}
}
}
}
}
// Suggestion.compareToIgnoreCase (IntegerSuggestion compares numerically).
compare_suggestions :: proc(a: ^Suggestion, b: ^Suggestion) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match (a.int_value, b.int_value) {
    // rust: (Some(x), Some(y)) => x.cmp(&y),
    // rust: (Some(_), None) => a.text.cmp(&b.text),
    // rust: _ => compare_ignore_case(&a.text, &b.text),
}
}
// Suggestions.create: merged, expanded to a common range and sorted case-insensitively.
merge_suggestions :: proc(input: string, list: [dynamic]Suggestion) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if list.is_empty() {
    // rust: return ((0, 0), Vec::new());
}
    // rust: let start = list.iter().map(|s| s.range.0).min().unwrap_or(0);
    // rust: let end = list.iter().map(|s| s.range.1).max().unwrap_or(0);
    // rust: let mut out: Vec<Suggestion> = Vec::new();
    // rust: let mut seen: std::collections::HashSet<(String, Option<String>)> =
    // rust: std::collections::HashSet::new();
    // rust: for s in list {
        // Suggestion.expand: pad the text with the input around it.
    // rust: let text = format!(
    // rust: "{}{}{}",
    // rust: &input[start..s.range.0],
    // rust: s.text,
    // rust: &input[s.range.1..end]
    // rust: );
    // rust: let expanded = Suggestion {
    // rust: range: (start, end),
    // rust: text,
    // rust: tooltip: s.tooltip,
    // rust: int_value: if s.range == (start, end) {
    // rust: s.int_value
    // rust: } else {
    // rust: None
    // rust: },
}
    // rust: if seen.insert((expanded.text.clone(), expanded.tooltip.clone())) {
    // rust: out.push(expanded);
}
}
    // rust: let ints = out.iter().filter(|s| s.int_value.is_some()).count();
    // rust: if ints == 0 || ints == out.len() {
    // rust: out.sort_by(compare_suggestions);
    // rust: return ((start, end), out);
}
    // A stable insertion sort (the comparator mixes numeric and text order).
    // rust: let mut sorted: Vec<Suggestion> = Vec::with_capacity(out.len());
    // rust: for s in out {
    // rust: let pos =
    // rust: sorted.partition_point(|x| compare_suggestions(x, &s) != std::cmp::Ordering::Greater);
    // rust: sorted.insert(pos, s);
}
    // rust: ((start, end), sorted)
}

    // rust: impl Suggests {
    // The provider's candidates; `context` is the whole parse context
    // (CommandContextBuilder.build), whose arguments some providers read.
suggest :: proc(self: ^Self, builder: ^SuggestionsBuilder, reg: ^Registries, context: ^Context) {
}
    // rust: match self {
    // rust: Suggests::AdvancementCriteria => {
    // rust: if let Some(Arg::Resource(id)) = context.get("advancement")
    // rust: && let Some(criteria) = reg.advancement_criteria.get(id)
    // rust: {
    // rust: builder.suggest_matching(criteria.iter().map(String::as_str));
}
}
    // rust: Suggests::Functions => {
    // rust: args::suggest_resources(builder, &reg.function_tags, "#");
    // rust: args::suggest_resources(builder, &reg.functions, "");
}
    // rust: Suggests::Fixed(values) => builder.suggest_matching(values.iter().copied()),
    // rust: Suggests::SummonableEntities => {
    // rust: let contents = builder.remaining_lower();
    // rust: for id in &reg.summonable {
    // rust: if args::resource_matches(&contents, id) {
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: let name = horizon_client_core::lang::get(&format!(
    // rust: "entity.{ns}.{}",
    // rust: path.replace('/', ".")
    // rust: ));
    // rust: builder.suggest_tooltip(id.clone(), name);
}
}
}
    // rust: Suggests::TimeMarkers => {
    // rust: let clock = match context.get("clock") {
    // rust: Some(Arg::Resource(id)) => id.clone(),
    // rust: _ => "minecraft:overworld".to_owned(),
}
    // rust: match reg.clock_time_markers.get(&clock) {
    // rust: Some(markers) => args::suggest_resources(builder, markers, ""),
    // rust: None if clock == "minecraft:overworld" => {
    // rust: args::suggest_resources(builder, &reg.time_markers, "")
}
    // rust: None => {}
}
}
    // rust: Suggests::EnableTriggers => {
                // getNamesWithDefaultWildcard: `*` means every tracked holder.
    // rust: let targets: Vec<String> = match context.get("targets") {
    // rust: Some(Arg::ScoreHolder(args::ScoreHolderArg::Name(n))) => vec![n.clone()],
    // rust: Some(Arg::ScoreHolder(args::ScoreHolderArg::Wildcard)) => reg.tracked.clone(),
    // rust: _ => reg.players.clone(),
}
    // rust: let available: Vec<&str> = reg
    // rust: .trigger_scores
    // rust: .iter()
    // rust: .filter(|(_, scores)| {
    // rust: targets
    // rust: .iter()
    // rust: .any(|t| scores.get(t).is_none_or(|locked| *locked))
    // rust: })
    // rust: .map(|(o, _)| o.as_str())
    // rust: .collect();
    // rust: builder.suggest_matching(available);
}
    // rust: Suggests::Triggers => {
    // rust: builder.suggest_matching(reg.trigger_objectives.iter().map(String::as_str))
}
    // rust: Suggests::NonOperators => {
    // rust: let listed = |name: &&String| !reg.ops.iter().any(|o| o.eq_ignore_ascii_case(name));
    // rust: builder.suggest_matching(reg.players.iter().filter(listed).map(String::as_str))
}
    // rust: Suggests::Operators => builder.suggest_matching(reg.ops.iter().map(String::as_str)),
    // rust: Suggests::BannedPlayers => {
    // rust: builder.suggest_matching(reg.banned_players.iter().map(String::as_str))
}
    // rust: Suggests::BannedIps => {
    // rust: builder.suggest_matching(reg.banned_ips.iter().map(String::as_str))
}
    // rust: Suggests::NonWhitelisted => {
    // rust: let listed =
    // rust: |name: &&String| !reg.whitelisted.iter().any(|w| w.eq_ignore_ascii_case(name));
    // rust: builder.suggest_matching(reg.players.iter().filter(listed).map(String::as_str))
}
    // rust: Suggests::Whitelisted => {
    // rust: builder.suggest_matching(reg.whitelisted.iter().map(String::as_str))
}
    // rust: Suggests::Nothing | Suggests::AskServer => {}
}
}
}

// The deepest node/redirect recursion `parse_nodes` accepts. `execute … run`
// redirects back to the root, so a crafted deeply nested command would recurse
// once per level and overflow the parsing thread's stack (measured at ~300 on
// the server thread). Far above any real command chain; vanilla likewise caps
// command nesting.
MAX_PARSE_DEPTH :: 128

// The command tree (CommandDispatcher). Node 0 is the root.
Dispatcher :: struct {
    nodes: [dynamic]Node,
}
    // rust: impl Default for Dispatcher {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new()
}
}
    // rust: impl Dispatcher {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: nodes: vec![Node {
    // rust: kind: NodeKind::Root,
    // rust: children: Vec::new(),
    // rust: command: None,
    // rust: redirect: None,
    // rust: permission: 0,
    // rust: suggests: None,
    // rust: restricted: false,
    // rust: }],
}
}
    // This tree as a player without elevated permissions has it
    // (ClientPacketListener.restrictedSuggestionsProvider): no restricted node.
without_restricted :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut tree = self.clone();
    // rust: for node in &mut tree.nodes {
    // rust: node.children.retain(|&child| !self.nodes[child].restricted);
}
    // rust: tree
}
add :: proc(self: ^Self, parent: uint, kind: NodeKind) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let name = match &kind {
    // rust: NodeKind::Literal(l) => l.clone(),
    // rust: NodeKind::Argument { name, .. } => name.clone(),
    // rust: NodeKind::Root => String::new(),
}
        // CommandNode.addChild merges same-named children.
    // rust: if let Some(&existing) = self.nodes[parent]
    // rust: .children
    // rust: .iter()
    // rust: .find(|&&c| self.nodes[c].name() == name)
    // rust: {
    // rust: return existing;
}
    // rust: let permission = self.nodes[parent].permission;
    // rust: self.nodes.push(Node {
    // rust: kind,
    // rust: children: Vec::new(),
    // rust: command: None,
    // rust: redirect: None,
    // rust: permission,
    // rust: suggests: None,
    // rust: restricted: false,
    // rust: });
    // rust: let id = self.nodes.len() - 1;
    // rust: self.nodes[parent].children.push(id);
    // rust: id
}
literal :: proc(self: ^Self, parent: uint, name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.add(parent, NodeKind::Literal(name.to_owned()))
}
argument :: proc(self: ^Self, parent: uint, name: string, ty: ArgType) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.add(
    // rust: parent,
    // rust: NodeKind::Argument {
    // rust: name: name.to_owned(),
    // rust: ty,
    // rust: },
    // rust: )
}
executes :: proc(self: ^Self, node: uint, command: ^'static str) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[node].command = Some(command);
    // rust: node
}
redirect :: proc(self: ^Self, node: uint, target: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[node].redirect = Some(target);
    // rust: node
}
suggests :: proc(self: ^Self, node: uint, provider: Suggests) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[node].suggests = Some(provider);
    // rust: node
}
requires :: proc(self: ^Self, node: uint, level: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[node].permission = level;
    // rust: node
}
    // This tree plus the commands mods own (`docs/mods.md`), so the chat
    // colours and completes them like the others. Every player may use one,
    // and the text after its name goes to the mod as it was typed.
    // rust: pub fn with_mod_commands<'a>(&self, names: impl IntoIterator<Item = &'a str>) -> Dispatcher {
    // rust: let mut d = self.clone();
    // rust: for name in names {
    // rust: let command = d.literal(0, name);
    // rust: d.executes(command, MOD_COMMAND);
    // rust: let args = d.argument(command, "args", ArgType::Greedy);
    // rust: d.executes(args, MOD_COMMAND);
}
    // rust: d
}
    // A root literal by name.
find :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[0]
    // rust: .children
    // rust: .iter()
    // rust: .copied()
    // rust: .find(|&c| self.nodes[c].name() == name)
}
relevant :: proc(self: ^Self, node: uint, reader: ^Reader) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let children = &self.nodes[node].children;
    // rust: let literals: Vec<usize> = children
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&c| matches!(self.nodes[c].kind, NodeKind::Literal(_)))
    // rust: .collect();
    // rust: let arguments: Vec<usize> = children
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&c| matches!(self.nodes[c].kind, NodeKind::Argument { .. }))
    // rust: .collect();
    // rust: if literals.is_empty() {
    // rust: return arguments;
}
    // rust: let rest = reader.remaining();
    // rust: let word = rest.split(' ').next().unwrap_or("");
    // rust: match literals.iter().find(|&&l| self.nodes[l].name() == word) {
    // rust: Some(&l) => vec![l],
    // rust: None => arguments,
}
}
    // rust: fn parse_node(
    // rust: &self,
    // rust: node: usize,
    // rust: reader: &mut Reader,
    // rust: context: &mut Context,
    // rust: reg: &Registries,
    // rust: ) -> CmdResult<()> {
    // rust: let start = reader.cursor;
    // rust: match &self.nodes[node].kind {
    // rust: NodeKind::Root => Ok(()),
    // rust: NodeKind::Literal(literal) => {
    // rust: if reader.remaining().starts_with(literal.as_str()) {
    // rust: let end = start + literal.len();
    // rust: reader.cursor = end;
    // rust: if !reader.can_read() || reader.peek() == ' ' {
    // rust: context.with_node(node, (start, end));
    // rust: context.literals.push(literal.clone());
    // rust: return Ok(());
}
    // rust: reader.cursor = start;
}
    // rust: let mut e = CommandError::tr_at("argument.literal.incorrect", &[literal], reader);
    // rust: e.literal_incorrect = true;
    // rust: Err(e)
}
    // rust: NodeKind::Argument { name, ty } => {
    // rust: let value = ty.parse(reader, reg)?;
    // rust: let range = (start, reader.cursor);
    // rust: context.args.push(ParsedArg {
    // rust: name: name.clone(),
    // rust: value,
    // rust: range,
    // rust: });
    // rust: context.with_node(node, range);
    // rust: Ok(())
}
}
}
    // rust: fn parse_nodes(
    // rust: &self,
    // rust: node: usize,
    // rust: input: &str,
    // rust: cursor: usize,
    // rust: so_far: &Context,
    // rust: reg: &Registries,
    // rust: level: u8,
    // rust: depth: usize,
    // rust: ) -> ParseResults {
    // rust: if depth >= MAX_PARSE_DEPTH {
            // A crafted command nested through `execute … run` (which redirects
            // back to the root) recurses here per level; stop before it
            // overflows the parsing thread's stack. The branch yields no result,
            // so the whole command simply fails to parse.
    // rust: return ParseResults {
    // rust: context: so_far.clone(),
    // rust: input: input.to_owned(),
    // rust: cursor,
    // rust: errors: Vec::new(),
}
}
    // rust: let mut errors = Vec::new();
    // rust: let mut potentials: Vec<ParseResults> = Vec::new();
    // rust: let original = Reader {
    // rust: string: input,
    // rust: cursor,
}
    // rust: for child in self.relevant(node, &original) {
    // rust: if self.nodes[child].permission > level {
    // rust: continue;
}
    // rust: let mut context = so_far.clone();
    // rust: let mut reader = original.clone();
    // rust: let parsed = self
    // rust: .parse_node(child, &mut reader, &mut context, reg)
    // rust: .and_then(|()| {
    // rust: if reader.can_read() && reader.peek() != ' ' {
    // rust: Err(CommandError::tr_at(
    // rust: "command.expected.separator",
    // rust: &[],
    // rust: &reader,
    // rust: ))
    // rust: } else {
    // rust: Ok(())
}
    // rust: });
    // rust: if let Err(e) = parsed {
    // rust: errors.push((child, e));
    // rust: continue;
}
    // rust: context.command = self.nodes[child].command;
    // rust: let redirect = self.nodes[child].redirect;
    // rust: if reader.can_read_n(if redirect.is_none() { 2 } else { 1 }) {
    // rust: reader.skip();
    // rust: if let Some(target) = redirect {
    // rust: let child_context = Context::new(target, reader.cursor);
    // rust: let parse = self.parse_nodes(
    // rust: target,
    // rust: input,
    // rust: reader.cursor,
    // rust: &child_context,
    // rust: reg,
    // rust: level,
    // rust: depth + 1,
    // rust: );
    // rust: context.child = Some(Box::new(parse.context));
    // rust: return ParseResults {
    // rust: context,
    // rust: input: input.to_owned(),
    // rust: cursor: parse.cursor,
    // rust: errors: parse.errors,
}
}
    // rust: potentials.push(self.parse_nodes(
    // rust: child,
    // rust: input,
    // rust: reader.cursor,
    // rust: &context,
    // rust: reg,
    // rust: level,
    // rust: depth + 1,
    // rust: ));
    // rust: } else {
    // rust: potentials.push(ParseResults {
    // rust: context,
    // rust: input: input.to_owned(),
    // rust: cursor: reader.cursor,
    // rust: errors: Vec::new(),
    // rust: });
}
}
    // rust: if !potentials.is_empty() {
            // Prefer fully read input, then results without errors (stable sort).
    // rust: potentials.sort_by_key(|p| (p.can_read(), !p.errors.is_empty()));
    // rust: return potentials.swap_remove(0);
}
    // rust: ParseResults {
    // rust: context: so_far.clone(),
    // rust: input: input.to_owned(),
    // rust: cursor,
    // rust: errors,
}
}
    // CommandDispatcher.parse from the start of `input` (no leading slash).
parse :: proc(self: ^Self, input: string, reg: ^Registries) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.parse_at(input, 0, reg)
}
    // Parse starting at byte `start` (after a leading '/').
parse_at :: proc(self: ^Self, input: string, start: uint, reg: ^Registries) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let context = Context::new(0, start);
    // rust: self.parse_nodes(0, input, start, &context, reg, reg.permission, 0)
}
    // CommandDispatcher.getCompletionSuggestions at `cursor`: brigadier
    // lists every child, whatever its requirement.
    // rust: pub fn suggestions(
    // rust: &self,
    // rust: parse: &ParseResults,
    // rust: cursor: usize,
    // rust: reg: &Registries,
    // rust: ) -> (Range, Vec<Suggestion>) {
    // rust: let (range, list, _) = self.suggestions_within(parse, cursor, reg, u8::MAX);
    // rust: (range, list)
}
    // The suggestions the player's chat shows: the client's tree only holds
    // the nodes the player may use (Commands.sendCommands prunes by canUse).
    // rust: pub fn client_suggestions(
    // rust: &self,
    // rust: parse: &ParseResults,
    // rust: cursor: usize,
    // rust: reg: &Registries,
    // rust: ) -> (Range, Vec<Suggestion>) {
    // rust: let (range, list, _) = self.suggestions_within(parse, cursor, reg, reg.permission);
    // rust: (range, list)
}
    // [`Self::client_suggestions`], and whether a node at the cursor asks
    // the server (`ask_server`): its completions come with the server's
    // reply, to be merged with these.
    // rust: pub fn client_suggestions_asking(
    // rust: &self,
    // rust: parse: &ParseResults,
    // rust: cursor: usize,
    // rust: reg: &Registries,
    // rust: ) -> (Range, Vec<Suggestion>, bool) {
    // rust: self.suggestions_within(parse, cursor, reg, reg.permission)
}
    // rust: fn suggestions_within(
    // rust: &self,
    // rust: parse: &ParseResults,
    // rust: cursor: usize,
    // rust: reg: &Registries,
    // rust: permission: u8,
    // rust: ) -> (Range, Vec<Suggestion>, bool) {
    // rust: let (parent, start, context) = parse.context.suggestion_context(cursor);
    // rust: let start = start.min(cursor);
    // rust: let truncated = &parse.input[..cursor.min(parse.input.len())];
    // rust: let mut all = Vec::new();
    // rust: let mut ask = false;
    // rust: for &child in &self.nodes[parent].children {
    // rust: if self.nodes[child].permission > permission {
    // rust: continue;
}
    // rust: ask |= matches!(self.nodes[child].suggests, Some(Suggests::AskServer));
    // rust: let mut builder = SuggestionsBuilder::new(truncated, start);
    // rust: match &self.nodes[child].kind {
    // rust: NodeKind::Literal(l) => {
    // rust: if l.to_lowercase().starts_with(&builder.remaining_lower()) {
    // rust: builder.suggest(l.clone());
}
}
    // rust: NodeKind::Argument { ty, name } => match &self.nodes[child].suggests {
    // rust: Some(provider) => provider.suggest(&mut builder, reg, &parse.context),
    // rust: None => ty.suggest(&mut builder, reg, context, name),
    // rust: },
    // rust: NodeKind::Root => {}
}
    // rust: all.extend(builder.out);
}
    // rust: let (range, list) = merge_suggestions(truncated, all);
    // rust: (range, list, ask)
}
smart_usage_of :: proc(self: ^Self, node: uint, optional: bool, deep: bool, level: u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let n = &self.nodes[node];
    // rust: if n.permission > level {
    // rust: return None;
}
    // rust: let this = if optional {
    // rust: format!("[{}]", n.usage_text())
    // rust: } else {
    // rust: n.usage_text()
}
    // rust: let child_optional = n.command.is_some();
    // rust: let (open, close) = if child_optional {
    // rust: ("[", "]")
    // rust: } else {
    // rust: ("(", ")")
}
    // rust: if !deep {
    // rust: if let Some(r) = n.redirect {
    // rust: let target = if r == 0 {
    // rust: "...".to_owned()
    // rust: } else {
    // rust: format!("-> {}", self.nodes[r].usage_text())
}
    // rust: return Some(format!("{this} {target}"));
}
    // rust: let children: Vec<usize> = n
    // rust: .children
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&c| self.nodes[c].permission <= level)
    // rust: .collect();
    // rust: if children.len() == 1 {
    // rust: if let Some(usage) =
    // rust: self.smart_usage_of(children[0], child_optional, child_optional, level)
    // rust: {
    // rust: return Some(format!("{this} {usage}"));
}
    // rust: } else if children.len() > 1 {
    // rust: let mut child_usage: Vec<String> = Vec::new();
    // rust: for &c in &children {
    // rust: if let Some(u) = self.smart_usage_of(c, child_optional, true, level)
    // rust: && !child_usage.contains(&u)
    // rust: {
    // rust: child_usage.push(u);
}
}
    // rust: if child_usage.len() == 1 {
    // rust: let usage = &child_usage[0];
    // rust: return Some(format!(
    // rust: "{this} {}",
    // rust: if child_optional {
    // rust: format!("[{usage}]")
    // rust: } else {
    // rust: usage.clone()
}
    // rust: ));
}
    // rust: if child_usage.len() > 1 {
    // rust: let alternatives: Vec<String> = children
    // rust: .iter()
    // rust: .map(|&c| self.nodes[c].usage_text())
    // rust: .collect();
    // rust: return Some(format!("{this} {open}{}{close}", alternatives.join("|")));
}
}
}
    // rust: Some(this)
}
    // CommandDispatcher.getSmartUsage: one line per child of `node`.
smart_usage :: proc(self: ^Self, node: uint, level: u8) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let optional = self.nodes[node].command.is_some();
    // rust: self.nodes[node]
    // rust: .children
    // rust: .iter()
    // rust: .filter_map(|&c| {
    // rust: self.smart_usage_of(c, optional, false, level)
    // rust: .map(|u| (c, u))
    // rust: })
    // rust: .collect()
}
}

    // rust: mod tests;
