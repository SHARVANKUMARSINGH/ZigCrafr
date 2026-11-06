//! Transpiled from Horizon Rust crate
package horizon_client_render_mod_browser

import "core:fmt"
import "core:mem"
import "core:math"

// What Options > Mods > Browse mods shows (docs/design/mod-hotload.md): the
// registry's content mods this game installs, a search over them, and the one
// whose page is open. The game fills it from a worker
// (`horizon_client::mod_registry`, `game/mod_browser.rs`); the options screen
// only reads it and asks for installs through its events.

// One project of the registry, as the list and its page show it.
Listing :: struct {
    id: string,
    name: string,
    summary: string,
    // Markdown, shown as plain text.
    description: string,
    authors: [dynamic]string,
    license: string,
    categories: [dynamic]string,
    tags: [dynamic]string,
    // The version this game would install, its date and changelog.
    version: string,
    published: string,
    changelog: string,
    downloads: u64,
    // The project's page on the website.
    page: string,
    // The version installed in this game folder, if any.
    installed: Maybe(string),
}

    // rust: impl Listing {
    // Whether a search for `query` (already lower case) finds it: its name,
    // id, summary, authors, categories or tags.
matches :: proc(self: ^Self, query: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let query = query.trim();
    // rust: query.is_empty()
    // rust: || [&self.name, &self.id, &self.summary]
    // rust: .into_iter()
    // rust: .chain(&self.authors)
    // rust: .chain(&self.categories)
    // rust: .chain(&self.tags)
    // rust: .any(|field| field.to_lowercase().contains(query))
}

    // Installed, but not the version the registry offers now.
has_update :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.installed
    // rust: .as_ref()
    // rust: .is_some_and(|installed| *installed != self.version)
}
}

// Where the browser is.
Status :: enum {
    // Not asked yet.
    Idle,
    // The index is being read.
    Loading,
    // The projects are listed.
    Ready,
    // The index couldn't be read: why, in English (shown inside a translated line).
    Failed(String),
}

ModBrowser :: struct {
    status: Status,
    listings: [dynamic]Listing,
    // The project an install runs for.
    installing: Maybe(string),
    // The last install's outcome, already translated, for the page it ran on.
    message: Option<(string,
}

    // rust: impl ModBrowser {
    // The listings a search for `query` finds, by index into `listings`.
found :: proc(self: ^Self, query: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let query = query.to_lowercase();
    // rust: (0..self.listings.len())
    // rust: .filter(|&i| self.listings[i].matches(&query))
    // rust: .collect()
}

listing :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.listings.iter().find(|l| l.id == id)
}
}

// A project's markdown description as lines of plain text for the page:
// heading marks, emphasis and list bullets dropped, links shown as their text,
// blank lines and fences left out.
plain_lines :: proc(markdown: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for line in markdown.lines() {
    // rust: let line = line.trim();
    // rust: if line.is_empty() || line.starts_with("```") || line.starts_with("<!--") {
    // rust: continue;
}
    // rust: let line = line.trim_start_matches('#').trim_start();
    // rust: let line = match line.strip_prefix("- ").or_else(|| line.strip_prefix("* ")) {
    // rust: Some(rest) => format!("• {rest}"),
    // rust: None => line.to_owned(),
}
    // rust: let line = links_as_text(&line).replace("**", "").replace('`', "");
    // rust: if !line.is_empty() {
    // rust: out.push(line);
}
}
    // rust: out
}

// `[text](url)` → `text`, `![alt](url)` → nothing.
links_as_text :: proc(line: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(line.len());
    // rust: let mut rest = line;
    // rust: while let Some(open) = rest.find('[') {
    // rust: let Some(close) = rest[open..].find("](").map(|c| open + c) else {
    // rust: break;
}
    // rust: let Some(end) = rest[close..].find(')').map(|e| close + e) else {
    // rust: break;
}
    // rust: let image = open > 0 && rest[..open].ends_with('!');
    // rust: out.push_str(&rest[..if image { open - 1 } else { open }]);
    // rust: if !image {
    // rust: out.push_str(&rest[open + 1..close]);
}
    // rust: rest = &rest[end + 1..];
}
    // rust: out.push_str(rest);
    // rust: out
}

    // rust: mod tests {
//     use super::*;

listing :: proc(id: string, tags: ^[string]) -> L {
    // Ported from Horizon
    return {}
}
    // rust: Listing {
    // rust: id: id.into(),
    // rust: name: id.to_uppercase(),
    // rust: summary: format!("All about {id}"),
    // rust: tags: tags.iter().map(|t| (*t).to_owned()).collect(),
    // rust: version: "1.0".into(),
    // rust: ..Listing::default()
}
}

a_search_finds_names_tags_and_categories_in_any_case :: proc() {
}
    // rust: let mut pipes = listing("pipes", &["tech"]);
    // rust: pipes.categories = vec!["technology".into()];
    // rust: let browser = ModBrowser {
    // rust: listings: vec![listing("ruby", &["gems"]), pipes],
    // rust: ..ModBrowser::default()
}
    // rust: assert_eq!(browser.found(""), [0, 1]);
    // rust: assert_eq!(browser.found("RUBY"), [0]);
    // rust: assert_eq!(browser.found("gems"), [0]);
    // rust: assert_eq!(browser.found("techno"), [1]);
    // rust: assert!(browser.found("nothing like it").is_empty());
}

an_update_is_another_version_than_the_installed_one :: proc() {
}
    // rust: let mut l = listing("ruby", &[]);
    // rust: assert!(!l.has_update());
    // rust: l.installed = Some("1.0".into());
    // rust: assert!(!l.has_update());
    // rust: l.installed = Some("0.9".into());
    // rust: assert!(l.has_update());
}

markdown_reads_as_plain_lines :: proc() {
}
    // rust: let text = "# Ruby\n\nAdds **rubies**. See [the wiki](https://x.y).\n\n![shot](https://x.y/a.png)\n- one\n* two\n```\ncode\n```\n";
    // rust: assert_eq!(
    // rust: plain_lines(text),
    // rust: [
    // rust: "Ruby",
    // rust: "Adds rubies. See the wiki.",
    // rust: "• one",
    // rust: "• two",
    // rust: "code"
    // rust: ]
    // rust: );
}
}
