//! Transpiled from Horizon Rust crate
package horizon_client_dialog

import "core:fmt"
import "core:mem"
import "core:math"

// Server dialogs (`net.minecraft.server.dialog`): what `Dialog.DIRECT_CODEC`
// decodes from a `show_dialog` packet, the values its inputs hold, and the
// click event an action makes of them (`Action.createAction`).
// use crate::text::Text;
// use horizon_world::nbt::Tag;
// use serde_json::{Value, json};

// `CommonDialogData` and the type's own fields.
Dialog :: struct {
    kind: Kind,
    title: Text,
    external_title: Maybe(Text),
    can_close_with_escape: bool,
    pause: bool,
    after_action: AfterAction,
    body: [dynamic]Body,
    inputs: [dynamic]Input,
}

// The dialog types (`DialogTypes`).
Kind :: enum {
    // `NoticeDialog`: one button, "OK" when the server names none.
    Notice(Button),
    Confirmation {,
    yes: Button,
    no: Button,
    // rust: },
    MultiAction {,
    actions: Vec<Button>,
    exit: Option<Button>,
    columns: i32,
    // rust: },
    ServerLinks {,
    exit: Option<Button>,
    columns: i32,
    button_width: i32,
    // rust: },
    // `DialogListDialog`: its dialogs as sent (ids, a tag or inline dialogs),
    // and one button per dialog they resolve to (`set_list`).
    DialogList {,
    dialogs: Tag,
    entries: Vec<Button>,
    exit: Option<Button>,
    columns: i32,
    button_width: i32,
    // rust: },
}

// `DialogAction`: the screen after an action runs.
AfterAction :: enum {
    Close,
    None,
    WaitForResponse,
}

// `ActionButton`: `CommonButtonData` and what it does.
Button :: struct {
    label: Text,
    tooltip: Maybe(Text),
    width: i32,
    action: Maybe(Action),
}

// `Action`: a fixed click event, or one made from the inputs' values.
Action :: enum {
    // `StaticAction`: a click event as it is.
    Static(Click),
    // `CommandTemplate`: a command with `$(key)` replaced by input values.
    RunCommand(String),
    // `CustomAll`: a custom click event whose payload is `additions` plus
    // every input's value under its key.
    Custom { id: String, additions: Option<Tag> },
}

// `ClickEvent`, the kinds a server may send (`isAllowedFromServer`).
Click :: enum {
    OpenUrl(String),
    RunCommand(String),
    SuggestCommand(String),
    // The dialog: an id of the `minecraft:dialog` registry or the dialog itself.
    ShowDialog(Tag),
    ChangePage(i32),
    CopyToClipboard(String),
    Custom {,
    id: String,
    payload: Option<Tag>,
    // rust: },
}

// `DialogBody`.
Body :: enum {
    // `PlainMessage`: centred text wrapped to `width`.
    Message { contents: Text, width: i32 },
    // `ItemBody`: the item as `ItemStackTemplate` sent it.
    Item {,
    item: Tag,
    description: Option<(Text, i32)>,
    show_decorations: bool,
    show_tooltip: bool,
    width: i32,
    height: i32,
    // rust: },
}

// `Input`: the key its value goes by, and its control.
Input :: struct {
    key: string,
    control: Control,
}

// `InputControl`.
Control :: enum {
    Text {,
    width: i32,
    label: Text,
    label_visible: bool,
    initial: String,
    max_length: i32,
        // `MultilineOptions`: the most lines and the height, when set.
    multiline: Option<(Option<i32>, Option<i32>)>,
    // rust: },
    Boolean {,
    label: Text,
    initial: bool,
    on_true: String,
    on_false: String,
    // rust: },
    SingleOption {,
    width: i32,
        // Each option's id, its label and whether it is the initial one.
    options: Vec<(String, Option<Text>, bool)>,
    label: Text,
    label_visible: bool,
    // rust: },
    NumberRange {,
    width: i32,
    label: Text,
    label_format: String,
    start: f32,
    end: f32,
    initial: Option<f32>,
    step: Option<f32>,
    // rust: },
}

// What an input holds while the dialog is open.
InputValue :: enum {
    Text(String),
    Bool(bool),
    // The chosen option's index.
    Option(usize),
    // The slider's position, 0 to 1.
    Slider(f32),
}

text :: proc(t: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: crate::scoreboard::comp_text(&crate::scoreboard::tag_to_json(t))
}
string :: proc(t: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t? {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
number :: proc(t: Maybe(^Tag)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match t? {
    // rust: Tag::Byte(v) => f64::from(*v),
    // rust: Tag::Short(v) => f64::from(*v),
    // rust: Tag::Int(v) => f64::from(*v),
    // rust: Tag::Long(v) => *v as f64,
    // rust: Tag::Float(v) => f64::from(f32::from_bits(*v)),
    // rust: Tag::Double(v) => f64::from_bits(*v),
    // rust: _ => return None,
    // rust: })
}
int :: proc(t: ^Tag, key: string, default: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: number(t.get(key)).map_or(default, |v| v as i32)
}
boolean :: proc(t: ^Tag, key: string, default: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: number(t.get(key)).map_or(default, |v| v != 0.0)
}
list :: proc(t: Maybe(^Tag)) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Some(Tag::List(items)) => items,
    // rust: _ => &[],
}
}
// A registry name without its default namespace.
path :: proc(id: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: id.strip_prefix("minecraft:").unwrap_or(id)
}

    // rust: impl Button {
    // `ActionButton.CODEC`.
parse :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(Self {
    // rust: label: text(t.get("label")?),
    // rust: tooltip: t.get("tooltip").map(text),
    // rust: width: int(t, "width", 150),
    // rust: action: t.get("action").and_then(Action::parse),
    // rust: })
}
    // `NoticeDialog.DEFAULT_ACTION`.
ok :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: label: Text::translate("gui.ok", &[]),
    // rust: tooltip: None,
    // rust: width: 150,
    // rust: action: None,
}
}
}

    // rust: impl Click {
    // `ClickEvent.CODEC`, from its `action` (a click event in a component)
    // or `type` (an action) field.
parse :: proc(t: ^Tag, kind: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let s = |key| string(t.get(key));
    // rust: Some(match path(kind) {
            // ClickEvent.OpenUrl's url is an ExtraCodecs.UNTRUSTED_URI.
    // rust: "open_url" => {
    // rust: Self::OpenUrl(s("url").filter(|url| crate::component::untrusted_http_url(url))?)
}
    // rust: "run_command" => Self::RunCommand(s("command")?),
    // rust: "suggest_command" => Self::SuggestCommand(s("command")?),
    // rust: "show_dialog" => Self::ShowDialog(t.get("dialog")?.clone()),
    // rust: "change_page" => Self::ChangePage(int(t, "page", 1)),
    // rust: "copy_to_clipboard" => Self::CopyToClipboard(s("value")?),
    // rust: "custom" => Self::Custom {
    // rust: id: s("id")?,
    // rust: payload: t.get("payload").cloned(),
    // rust: },
    // rust: _ => return None,
    // rust: })
}
}

    // rust: impl Action {
    // `Action.CODEC`, dispatched on `type`.
parse :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let kind = string(t.get("type"))?;
    // rust: Some(match path(&kind) {
    // rust: "dynamic/run_command" => Self::RunCommand(string(t.get("template"))?),
    // rust: "dynamic/custom" => Self::Custom {
    // rust: id: string(t.get("id"))?,
    // rust: additions: t.get("additions").cloned(),
    // rust: },
    // rust: other => Self::Static(Click::parse(t, other)?),
    // rust: })
}
    // `createAction`: the click event, given each input's key, control and value.
click :: proc(self: ^Self, inputs: ^[Input], values: ^[InputValue]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let values = || inputs.iter().zip(values);
    // rust: Some(match self {
    // rust: Self::Static(click) => click.clone(),
    // rust: Self::RunCommand(template) => Click::RunCommand(substitute(template, &|key| {
    // rust: values()
    // rust: .find(|(i, _)| i.key == key)
    // rust: .map(|(i, v)| i.control.substitution(v))
    // rust: })),
    // rust: Self::Custom { id, additions } => {
    // rust: let mut tag = match additions {
    // rust: Some(t @ Tag::Compound(_)) => t.clone(),
    // rust: _ => Tag::Compound(Default::default()),
}
    // rust: for (input, value) in values() {
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.insert(input.key.as_str().into(), input.control.tag(value));
}
}
    // rust: Click::Custom {
    // rust: id: id.clone(),
    // rust: payload: Some(tag),
}
}
    // rust: })
}
}

// `ParsedTemplate.instantiate`: each `$(key)` replaced by its value, or by
// nothing for a key no input has.
substitute :: proc(template: string, value: ^dyn Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: let mut rest = template;
    // rust: while let Some(at) = rest.find("$(") {
    // rust: let Some(end) = rest[at..].find(')') else {
    // rust: break;
}
    // rust: out.push_str(&rest[..at]);
    // rust: out.push_str(&value(&rest[at + 2..at + end]).unwrap_or_default());
    // rust: rest = &rest[at + end + 1..];
}
    // rust: out.push_str(rest);
    // rust: out
}

// `StringTag.escapeWithoutQuotes`.
escape :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(s.len());
    // rust: for c in s.chars() {
    // rust: match c {
    // rust: '"' | '\'' | '\\' => {
    // rust: out.push('\\');
    // rust: out.push(c);
}
    // rust: '\u{8}' => out.push_str("\\b"),
    // rust: '\t' => out.push_str("\\t"),
    // rust: '\n' => out.push_str("\\n"),
    // rust: '\u{c}' => out.push_str("\\f"),
    // rust: '\r' => out.push_str("\\r"),
    // rust: c if c < ' ' => out.push_str(&format!("\\x{:02x}", c as u32)),
    // rust: c => out.push(c),
}
}
    // rust: out
}

    // rust: impl Control {
    // `InputControl.MAP_CODEC`, dispatched on `type`.
parse :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let label = || t.get("label").map(text);
    // rust: Some(match path(&string(t.get("type"))?) {
    // rust: "text" => {
    // rust: let initial = string(t.get("initial")).unwrap_or_default();
    // rust: let max_length = int(t, "max_length", 32);
                // TextInput: the default text may not be longer than the length.
    // rust: if initial.encode_utf16().count() > max_length.max(0) as usize {
    // rust: return None;
}
    // rust: Self::Text {
    // rust: width: int(t, "width", 200),
    // rust: label: label()?,
    // rust: label_visible: boolean(t, "label_visible", true),
    // rust: initial,
    // rust: max_length,
    // rust: multiline: t.get("multiline").map(|m| {
    // rust: let get = |key| number(m.get(key)).map(|v| v as i32);
    // rust: (get("max_lines"), get("height"))
    // rust: }),
}
}
    // rust: "boolean" => Self::Boolean {
    // rust: label: label()?,
    // rust: initial: boolean(t, "initial", false),
    // rust: on_true: string(t.get("on_true")).unwrap_or_else(|| "true".into()),
    // rust: on_false: string(t.get("on_false")).unwrap_or_else(|| "false".into()),
    // rust: },
    // rust: "single_option" => {
                // SingleOptionInput.Entry.CODEC: a full entry or just its id.
    // rust: let options: Vec<_> = list(t.get("options"))
    // rust: .iter()
    // rust: .map(|o| match o {
    // rust: Tag::String(id) => Some((id.to_string_lossy(), None, false)),
    // rust: o => Some((
    // rust: string(o.get("id"))?,
    // rust: o.get("display").map(text),
    // rust: boolean(o, "initial", false),
    // rust: )),
    // rust: })
    // rust: .collect::<Option<_>>()?;
                // A non-empty list with at most one initial entry.
    // rust: if options.is_empty() || options.iter().filter(|o| o.2).count() > 1 {
    // rust: return None;
}
    // rust: Self::SingleOption {
    // rust: width: int(t, "width", 200),
    // rust: options,
    // rust: label: label()?,
    // rust: label_visible: boolean(t, "label_visible", true),
}
}
    // rust: "number_range" => {
    // rust: let float = |key| number(t.get(key)).map(|v| v as f32);
    // rust: Self::NumberRange {
    // rust: width: int(t, "width", 200),
    // rust: label: label()?,
    // rust: label_format: string(t.get("label_format"))
    // rust: .unwrap_or_else(|| "options.generic_value".into()),
    // rust: start: float("start")?,
    // rust: end: float("end")?,
    // rust: initial: float("initial"),
    // rust: step: float("step"),
}
}
    // rust: _ => return None,
    // rust: })
}
    // The value it starts with.
initial :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Text { initial, .. } => InputValue::Text(initial.clone()),
    // rust: Self::Boolean { initial, .. } => InputValue::Bool(*initial),
    // rust: Self::SingleOption { options, .. } => {
    // rust: InputValue::Option(options.iter().position(|o| o.2).unwrap_or(0))
}
    // rust: Self::NumberRange {
    // rust: start,
    // rust: end,
    // rust: initial,
    // rust: ..
    // rust: } => InputValue::Slider(to_slider(
    // rust: initial.unwrap_or((start + end) / 2.0),
    // rust: *start,
    // rust: *end,
    // rust: )),
}
}
    // The text on a cycle button or slider holding `value`
    // (`CycleButton.createFullName`, `NumberRangeInput.computeLabel`).
message :: proc(self: ^Self, value: ^InputValue) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match (self, value) {
    // rust: (
    // rust: Self::SingleOption {
    // rust: options,
    // rust: label,
    // rust: label_visible,
    // rust: ..
    // rust: },
    // rust: InputValue::Option(i),
    // rust: ) => {
    // rust: let (id, display, _) = options.get(*i)?;
    // rust: let shown = display.clone().unwrap_or_else(|| Text::literal(id));
    // rust: Some(if *label_visible {
    // rust: Text::translate("options.generic_value", &[label.clone(), shown])
    // rust: } else {
    // rust: shown
    // rust: })
}
    // rust: (
    // rust: Self::NumberRange {
    // rust: label,
    // rust: label_format,
    // rust: ..
    // rust: },
    // rust: InputValue::Slider(_),
    // rust: ) => {
    // rust: let shown = number_string(self.scaled(value)?);
    // rust: Some(Text::translate(
    // rust: label_format,
    // rust: &[label.clone(), Text::literal(shown)],
    // rust: ))
}
    // rust: _ => None,
}
}
    // `ValueGetter.asTemplateSubstitution`.
substitution :: proc(self: ^Self, value: ^InputValue) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match (self, value) {
    // rust: (Self::Text { .. }, InputValue::Text(s)) => escape(s),
    // rust: (
    // rust: Self::Boolean {
    // rust: on_true, on_false, ..
    // rust: },
    // rust: InputValue::Bool(b),
    // rust: ) => if *b { on_true } else { on_false }.clone(),
    // rust: (Self::SingleOption { options, .. }, InputValue::Option(i)) => {
    // rust: options.get(*i).map(|o| o.0.clone()).unwrap_or_default()
}
    // rust: (Self::NumberRange { .. }, InputValue::Slider(_)) => {
    // rust: number_string(self.scaled(value).unwrap_or(0.0))
}
    // rust: _ => String::new(),
}
}
    // `ValueGetter.asTag`.
tag :: proc(self: ^Self, value: ^InputValue) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match (self, value) {
    // rust: (Self::Boolean { .. }, InputValue::Bool(b)) => Tag::Byte(i8::from(*b)),
    // rust: (Self::NumberRange { .. }, _) => {
    // rust: Tag::Float(self.scaled(value).unwrap_or(0.0).to_bits())
}
    // rust: (Self::Text { .. }, InputValue::Text(s)) => Tag::String(s.as_str().into()),
    // rust: _ => Tag::String(self.substitution(value).as_str().into()),
}
}
    // `RangeInfo.computeScaledValue`: a number range's value at its slider position.
scaled :: proc(self: ^Self, value: ^InputValue) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (
    // rust: Self::NumberRange {
    // rust: start,
    // rust: end,
    // rust: initial,
    // rust: step,
    // rust: ..
    // rust: },
    // rust: InputValue::Slider(slider),
    // rust: ) = (self, value)
    // rust: else {
    // rust: return None;
}
    // rust: let (start, end) = (*start, *end);
    // rust: let in_range = start + slider * (end - start);
    // rust: let Some(step) = step else {
    // rust: return Some(in_range);
}
    // rust: let first = initial.unwrap_or((start + end) / 2.0);
        // Math.round: half up.
    // rust: let steps = ((in_range - first) / step + 0.5).floor() as i32;
    // rust: let result = first + steps as f32 * step;
    // rust: let position = to_slider(result, start, end);
    // rust: if (0.0..=1.0).contains(&position) {
    // rust: return Some(result);
}
    // rust: Some(first + (steps - steps.signum()) as f32 * step)
}
}

// `RangeInfo.scaledValueToSlider`.
to_slider :: proc(value: f32, start: f32, end: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if start == end {
    // rust: 0.5
    // rust: } else {
    // rust: (value - start) / (end - start)
}
}

// `SliderImpl.valueToString`: whole numbers without a fraction, the rest as
// Java's `Float.toString`.
number_string :: proc(v: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if v == (v as i32) as f32 {
    // rust: (v as i32).to_string()
    // rust: } else {
    // rust: crate::snbt::java_float(v)
}
}

    // rust: impl Body {
    // `DialogBody.DIALOG_BODY_CODEC`.
parse :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let message = |t: &Tag| -> Option<(Text, i32)> {
            // PlainMessage.CODEC: the full form or just its contents.
    // rust: match t {
    // rust: Tag::Compound(_) if t.get("contents").is_some() => {
    // rust: Some((text(t.get("contents")?), int(t, "width", 200)))
}
    // rust: t => Some((text(t), 200)),
}
}
    // rust: Some(match path(&string(t.get("type"))?) {
    // rust: "plain_message" => {
    // rust: let (contents, width) = message(t)?;
    // rust: Self::Message { contents, width }
}
    // rust: "item" => Self::Item {
    // rust: item: t.get("item")?.clone(),
    // rust: description: t.get("description").and_then(message),
    // rust: show_decorations: boolean(t, "show_decorations", true),
    // rust: show_tooltip: boolean(t, "show_tooltip", true),
    // rust: width: int(t, "width", 16),
    // rust: height: int(t, "height", 16),
    // rust: },
    // rust: _ => return None,
    // rust: })
}
}

    // rust: impl Dialog {
    // `Dialog.DIRECT_CODEC`; `None` for a type or field it can't read
    // (vanilla fails the whole packet then).
parse :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let button = |key: &str| t.get(key).and_then(Button::parse);
    // rust: let kind = match path(&string(t.get("type"))?) {
    // rust: "notice" => Kind::Notice(match t.get("action") {
    // rust: Some(b) => Button::parse(b)?,
    // rust: None => Button::ok(),
    // rust: }),
    // rust: "confirmation" => Kind::Confirmation {
    // rust: yes: button("yes")?,
    // rust: no: button("no")?,
    // rust: },
    // rust: "multi_action" => Kind::MultiAction {
    // rust: actions: list(t.get("actions"))
    // rust: .iter()
    // rust: .map(Button::parse)
    // rust: .collect::<Option<Vec<_>>>()
    // rust: .filter(|a| !a.is_empty())?,
    // rust: exit: button("exit_action"),
    // rust: columns: int(t, "columns", 2),
    // rust: },
    // rust: "server_links" => Kind::ServerLinks {
    // rust: exit: button("exit_action"),
    // rust: columns: int(t, "columns", 2),
    // rust: button_width: int(t, "button_width", 150),
    // rust: },
    // rust: "dialog_list" => Kind::DialogList {
    // rust: dialogs: t.get("dialogs")?.clone(),
    // rust: entries: Vec::new(),
    // rust: exit: button("exit_action"),
    // rust: columns: int(t, "columns", 2),
    // rust: button_width: int(t, "button_width", 150),
    // rust: },
    // rust: _ => return None,
}
        // DialogBody.COMPACT_LIST_CODEC: one body, or a list of them.
        // A body or input it cannot read fails the whole dialog.
    // rust: let body = match t.get("body") {
    // rust: Some(Tag::List(items)) => items.iter().map(Body::parse).collect::<Option<_>>()?,
    // rust: Some(one) => vec![Body::parse(one)?],
    // rust: None => Vec::new(),
}
    // rust: let inputs = list(t.get("inputs"))
    // rust: .iter()
    // rust: .map(|i| {
    // rust: Some(Input {
    // rust: key: string(i.get("key"))?,
    // rust: control: Control::parse(i)?,
    // rust: })
    // rust: })
    // rust: .collect::<Option<_>>()?;
    // rust: Some(Self {
    // rust: kind,
    // rust: title: text(t.get("title")?),
    // rust: external_title: t.get("external_title").map(text),
    // rust: can_close_with_escape: boolean(t, "can_close_with_escape", true),
    // rust: pause: boolean(t, "pause", true),
    // rust: after_action: match string(t.get("after_action")).as_deref() {
    // rust: Some("none") => AfterAction::None,
    // rust: Some("wait_for_response") => AfterAction::WaitForResponse,
    // rust: _ => AfterAction::Close,
    // rust: },
    // rust: body,
    // rust: inputs,
    // rust: })
}
    // `onCancel`: what Escape (or closing it) does.
on_cancel :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match &self.kind {
    // rust: Kind::Notice(b) => b.action.as_ref(),
    // rust: Kind::Confirmation { no, .. } => no.action.as_ref(),
    // rust: Kind::MultiAction { exit, .. }
    // rust: | Kind::ServerLinks { exit, .. }
    // rust: | Kind::DialogList { exit, .. } => exit.as_ref().and_then(|b| b.action.as_ref()),
}
}
    // Which of [`Self::buttons`] does what Escape does, if Escape does anything.
escape_button :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.can_close_with_escape {
    // rust: return None;
}
    // rust: let last = self.buttons().len().checked_sub(1);
    // rust: match &self.kind {
    // rust: Kind::Notice(_) | Kind::Confirmation { .. } => last,
    // rust: Kind::MultiAction { exit, .. }
    // rust: | Kind::ServerLinks { exit, .. }
    // rust: | Kind::DialogList { exit, .. } => exit.as_ref().and(last),
}
}
    // The buttons it draws, in order: the list, then the footer's.
buttons :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match &self.kind {
    // rust: Kind::Notice(b) => vec![b],
    // rust: Kind::Confirmation { yes, no } => vec![yes, no],
    // rust: Kind::MultiAction { actions, exit, .. } => actions.iter().chain(exit).collect(),
    // rust: Kind::ServerLinks { exit, .. } => exit.iter().collect(),
    // rust: Kind::DialogList { entries, exit, .. } => entries.iter().chain(exit).collect(),
}
}
    // `DialogListDialogScreen.createListActions`: a button for each of `dialogs`
    // (what the list names), labelled by its external title, opening it.
set_list :: proc(self: ^Self, dialogs: ^[Tag]) {
}
    // rust: let Kind::DialogList {
    // rust: entries,
    // rust: button_width,
    // rust: ..
    // rust: } = &mut self.kind
    // rust: else {
    // rust: return;
}
    // rust: *entries = dialogs
    // rust: .iter()
    // rust: .filter_map(|tag| {
    // rust: let sub = Dialog::parse(tag)?;
    // rust: Some(Button {
    // rust: label: sub.external_title.unwrap_or(sub.title),
    // rust: tooltip: None,
    // rust: width: *button_width,
    // rust: action: Some(Action::Static(Click::ShowDialog(tag.clone()))),
    // rust: })
    // rust: })
    // rust: .collect();
}
    // The dialogs a `dialog_list`'s `dialogs` names: the entries of a `#tag`
    // (by `tag`), registry ids (by `registry`) and dialogs written inline.
    // rust: pub fn list_entries(
    // rust: dialogs: &Tag,
    // rust: tag: &dyn Fn(&str) -> Vec<Tag>,
    // rust: registry: &dyn Fn(&str) -> Option<Tag>,
    // rust: ) -> Vec<Tag> {
    // rust: let one = |t: &Tag| match t {
    // rust: Tag::String(id) => registry(&id.to_string_lossy()),
    // rust: inline => Some(inline.clone()),
}
    // rust: match dialogs {
    // rust: Tag::String(id) if id.to_string_lossy().starts_with('#') => {
    // rust: tag(&id.to_string_lossy()[1..])
}
    // rust: Tag::List(items) => items.iter().filter_map(one).collect(),
    // rust: single => one(single).into_iter().collect(),
}
}
    // What `status` reports of it.
json :: proc(self: ^Self, values: ^[InputValue]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let kind = match &self.kind {
    // rust: Kind::Notice(_) => "notice",
    // rust: Kind::Confirmation { .. } => "confirmation",
    // rust: Kind::MultiAction { .. } => "multi_action",
    // rust: Kind::ServerLinks { .. } => "server_links",
    // rust: Kind::DialogList { .. } => "dialog_list",
}
    // rust: let inputs: Vec<Value> = self
    // rust: .inputs
    // rust: .iter()
    // rust: .zip(values)
    // rust: .map(|(i, v)| {
    // rust: let kind = match i.control {
    // rust: Control::Text { .. } => "text",
    // rust: Control::Boolean { .. } => "boolean",
    // rust: Control::SingleOption { .. } => "single_option",
    // rust: Control::NumberRange { .. } => "number_range",
}
    // rust: json!({"key": i.key, "type": kind, "value": i.control.substitution(v)})
    // rust: })
    // rust: .collect();
    // rust: json!({
    // rust: "type": kind,
    // rust: "title": self.title.plain(),
    // rust: "body": self.body.iter().map(|b| match b {
    // rust: Body::Message { contents, .. } => contents.plain(),
    // rust: Body::Item { item, .. } => string(item.get("id")).unwrap_or_default(),
    // rust: }).collect::<Vec<_>>(),
    // rust: "inputs": inputs,
    // rust: "buttons": self.buttons().iter().map(|b| b.label.plain()).collect::<Vec<_>>(),
    // rust: "can_close_with_escape": self.can_close_with_escape,
    // rust: "after_action": match self.after_action {
    // rust: AfterAction::Close => "close",
    // rust: AfterAction::None => "none",
    // rust: AfterAction::WaitForResponse => "wait_for_response",
    // rust: },
    // rust: })
}
}

    // rust: mod tests {
//     use super::*;

s :: proc(v: string) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::String(v.into())
}

    // The register dialog AuthMe 6 sends in configuration (the shape its
    // `show_dialog` packet has on the test bed).
register :: proc() -> T {
    // Ported from Horizon
    return {}
}
    // rust: Tag::compound([
    // rust: ("type", s("minecraft:multi_action")),
    // rust: ("title", s("Register")),
    // rust: ("can_close_with_escape", Tag::Byte(0)),
    // rust: ("after_action", s("wait_for_response")),
    // rust: (
    // rust: "body",
    // rust: Tag::compound([
    // rust: ("type", s("minecraft:plain_message")),
    // rust: ("contents", s("Choose a password")),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "inputs",
    // rust: Tag::List(vec![Tag::compound([
    // rust: ("type", s("minecraft:text")),
    // rust: ("key", s("password")),
    // rust: ("label", s("Password")),
    // rust: ])]),
    // rust: ),
    // rust: (
    // rust: "actions",
    // rust: Tag::List(vec![
    // rust: Tag::compound([
    // rust: ("label", s("Register")),
    // rust: (
    // rust: "action",
    // rust: Tag::compound([
    // rust: ("type", s("minecraft:dynamic/custom")),
    // rust: ("id", s("authme:prejoin-register/submit")),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: Tag::compound([
    // rust: ("label", s("Cancel")),
    // rust: (
    // rust: "action",
    // rust: Tag::compound([
    // rust: ("type", s("minecraft:dynamic/run_command")),
    // rust: ("template", s("say $(password) $(missing)!")),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: ]),
    // rust: ),
    // rust: ])
}

decodes_a_multi_action_dialog_with_defaults :: proc() {
}
    // rust: let d = Dialog::parse(&register()).unwrap();
    // rust: assert_eq!(d.title.plain(), "Register");
    // rust: assert!(!d.can_close_with_escape);
    // rust: assert!(d.pause);
    // rust: assert_eq!(d.after_action, AfterAction::WaitForResponse);
    // rust: assert!(matches!(&d.body[..], [Body::Message { width: 200, .. }]));
    // rust: let Kind::MultiAction {
    // rust: actions,
    // rust: exit,
    // rust: columns,
    // rust: } = &d.kind
    // rust: else {
    // rust: panic!("{:?}", d.kind)
}
    // rust: assert_eq!((actions.len(), exit.is_none(), *columns), (2, true, 2));
    // rust: assert_eq!(actions[0].width, 150);
    // rust: assert!(d.on_cancel().is_none());
    // rust: let [
    // rust: Input {
    // rust: key,
    // rust: control:
    // rust: Control::Text {
    // rust: max_length: 32,
    // rust: width: 200,
    // rust: ..
    // rust: },
    // rust: },
    // rust: ] = &d.inputs[..]
    // rust: else {
    // rust: panic!("{:?}", d.inputs)
}
    // rust: assert_eq!(key, "password");
}

open_url_actions_take_only_web_links :: proc() {
}
    // rust: let open = |url: &str| {
    // rust: let action = Tag::compound([("type", s("minecraft:open_url")), ("url", s(url))]);
    // rust: Action::parse(&action).and_then(|a| a.click(&[], &[]))
}
    // rust: assert_eq!(
    // rust: open("https://example.com/a"),
    // rust: Some(Click::OpenUrl("https://example.com/a".into()))
    // rust: );
    // rust: assert!(open("HTTP://example.com").is_some());
    // rust: for url in [
    // rust: "file:///C:/Windows/System32/cmd.exe",
    // rust: "\\\\attacker\\share\\x.exe",
    // rust: "search-ms:query=x&crumb=location:\\\\attacker\\share",
    // rust: "javascript:alert(1)",
    // rust: "/usr/bin/xterm",
    // rust: ] {
    // rust: assert_eq!(open(url), None, "{url}");
}
}

actions_carry_the_input_values :: proc() {
}
    // rust: let d = Dialog::parse(&register()).unwrap();
    // rust: let values = [InputValue::Text("p\"w".into())];
    // rust: let Kind::MultiAction { actions, .. } = &d.kind else {
    // rust: unreachable!()
}
    // rust: let custom = actions[0]
    // rust: .action
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .click(&d.inputs, &values);
    // rust: assert_eq!(
    // rust: custom,
    // rust: Some(Click::Custom {
    // rust: id: "authme:prejoin-register/submit".into(),
    // rust: payload: Some(Tag::compound([("password", s("p\"w"))])),
    // rust: })
    // rust: );
        // The template escapes the text; a key no input has becomes nothing.
    // rust: let command = actions[1]
    // rust: .action
    // rust: .as_ref()
    // rust: .unwrap()
    // rust: .click(&d.inputs, &values);
    // rust: assert_eq!(command, Some(Click::RunCommand("say p\\\"w !".into())));
}

the_button_that_does_what_escape_does :: proc() {
}
    // rust: let notice = |escape: i8| {
    // rust: Dialog::parse(&Tag::compound([
    // rust: ("type", s("notice")),
    // rust: ("title", s("Hi")),
    // rust: ("can_close_with_escape", Tag::Byte(escape)),
    // rust: ]))
    // rust: .unwrap()
}
    // rust: assert_eq!(notice(1).escape_button(), Some(0));
    // rust: assert_eq!(notice(0).escape_button(), None);
        // Multi-action with no exit button: Escape has no button to be.
    // rust: assert_eq!(Dialog::parse(&register()).unwrap().escape_button(), None);
}

a_notice_without_an_action_has_ok :: proc() {
}
    // rust: let d = Dialog::parse(&Tag::compound([("type", s("notice")), ("title", s("Hi"))])).unwrap();
    // rust: let Kind::Notice(b) = &d.kind else {
    // rust: unreachable!()
}
    // rust: assert_eq!(b.label, Text::translate("gui.ok", &[]));
        // Without a title, or with an unknown type, there is no dialog.
    // rust: assert!(Dialog::parse(&Tag::compound([("type", s("notice"))])).is_none());
    // rust: assert!(Dialog::parse(&Tag::compound([("type", s("x")), ("title", s("Hi"))])).is_none());
}

number_ranges_snap_to_their_step :: proc() {
}
    // rust: let mut range = Control::NumberRange {
    // rust: width: 200,
    // rust: label: Text::literal("n"),
    // rust: label_format: "options.generic_value".into(),
    // rust: start: 0.0,
    // rust: end: 10.0,
    // rust: initial: Some(4.0),
    // rust: step: Some(3.0),
}
    // rust: assert_eq!(range.initial(), InputValue::Slider(0.4));
    // rust: assert_eq!(range.scaled(&InputValue::Slider(0.62)), Some(7.0));
    // rust: assert_eq!(range.scaled(&InputValue::Slider(1.0)), Some(10.0));
    // rust: let Control::NumberRange { step, .. } = &mut range else {
    // rust: unreachable!()
}
    // rust: *step = Some(4.0);
        // 12 is out of range: one step less.
    // rust: assert_eq!(range.scaled(&InputValue::Slider(1.0)), Some(8.0));
    // rust: assert_eq!(range.substitution(&InputValue::Slider(0.0)), "0");
    // rust: assert_eq!(number_string(2.5), "2.5");
}
}
