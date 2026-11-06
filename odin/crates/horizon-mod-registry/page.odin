//! Transpiled from Horizon Rust crate
package horizon_mod_registry_page

import "core:fmt"
import "core:mem"
import "core:math"

// A project's page in a submission: its categories, tags and description
// (`horizon_mods::index::page`), and its images, uploaded with the form and
// written into the registry (`icons/<id>.png`, `screenshots/<id>/<n>.<ext>`)
// so the site and the launcher load them only from the registry's own host.
// Also "Edit project": an owner changes the page with no new version.
// use crate::{Config, Form, Ownership, Refusal, bad, github::GitHub, github_down, now, ownership};
// use axum::http::StatusCode;
// use horizon_mods::index::{Kind, page as rules, registry::Entry};

// The biggest image part: a screenshot (an icon is smaller, checked when added).
MAX_IMAGE :: rules::MAX_SCREENSHOT 
// All of a submission's images together.
MAX_IMAGES :: MAX_IMAGE * rules::MAX_SCREENSHOTS + MAX_ICON
MAX_ICON :: 256 << 10

// The images a submission uploads, checked.
Uploads :: struct {
    icon: Maybe([dynamic]u8),
    // Extension and bytes, in the order sent.
    screenshots: Vec<(string,
}

    // rust: impl Uploads {
    // Takes one image part (`icon` or `screenshot`) named `name` by the browser.
add :: proc(self: ^Self, part: string, name: string, bytes: [dynamic]u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if part == "icon" {
    // rust: if bytes.len() > MAX_ICON {
    // rust: return Err(format!("the icon is over {} KiB", MAX_ICON >> 10));
}
    // rust: rules::check_icon(&bytes)?;
    // rust: self.icon = Some(bytes);
    // rust: return Ok(());
}
    // rust: if self.screenshots.len() == rules::MAX_SCREENSHOTS {
    // rust: return Err(format!("at most {} screenshots", rules::MAX_SCREENSHOTS));
}
    // rust: rules::check_screenshot(name, &bytes)?;
    // rust: let (format, ..) = rules::image_size(&bytes).ok_or("not an image")?;
    // rust: self.screenshots
    // rust: .push((format.extensions()[0].to_owned(), bytes));
    // rust: Ok(())
}

is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.icon.is_none() && self.screenshots.is_empty()
}
}

// The page's own rules, for any submission: categories of the kind, plain tags, no icon address,
// and a `shaderpack`'s statement that it is the submitter's to hand out.
check_form :: proc(form: ^Form, kind: ^Kind) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut errors = rules::check(kind, &form.description, &form.categories, &form.tags);
    // rust: if form.icon.is_some() {
    // rust: errors.push("upload the icon (a square PNG) instead of giving its address".into());
}
    // rust: if *kind == Kind::ShaderPack && !form.own_work {
    // rust: errors.push(
    // rust: "a shaders/-folder pack is listed only by its author, under a licence that lets the registry hand it out: \
    // rust: confirm both"
    // rust: .into(),
    // rust: );
}
    // rust: if errors.is_empty() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(errors.join("; "))
}
}

// What a new project must have: a description, a category and an icon.
check_new :: proc(form: ^Form, images: ^Uploads) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut errors = Vec::new();
    // rust: let length = form.description.trim().chars().count();
    // rust: if length < rules::MIN_DESCRIPTION {
    // rust: errors.push(format!(
    // rust: "the description is {length} characters: write at least {} (what it does, how to use it)",
    // rust: rules::MIN_DESCRIPTION
    // rust: ));
}
    // rust: if form.categories.is_empty() {
    // rust: errors.push(format!("pick 1 to {} categories", rules::MAX_CATEGORIES));
}
    // rust: if images.icon.is_none() {
    // rust: errors.push("upload an icon: a square PNG, 64 to 1024 pixels".into());
}
    // rust: if errors.is_empty() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(errors.join("; "))
}
}

// Puts the uploaded images in `entry` and returns the files to write. The form's `screenshots`
// keeps those of the entry it lists, in its order (absent: all of them); uploads come after.
    // rust: pub fn place(
    // rust: entry: &mut Entry,
    // rust: form: &Form,
    // rust: images: &Uploads,
    // rust: ) -> Result<Vec<(String, Vec<u8>)>, String> {
    // rust: let id = entry.id.clone();
    // rust: let mut writes = Vec::new();
    // rust: if let Some(icon) = &images.icon {
    // rust: let path = format!("icons/{id}.png");
    // rust: entry.icon = Some(path.clone());
    // rust: writes.push((path, icon.clone()));
}
    // rust: let mut kept = match &form.screenshots {
    // rust: None => entry.screenshots.clone(),
    // rust: Some(list) => {
    // rust: if let Some(stranger) = list.iter().find(|s| !entry.screenshots.contains(s)) {
    // rust: return Err(format!("{stranger:?} is not one of {id}'s screenshots"));
}
    // rust: list.clone()
}
}
    // rust: if kept.len() + images.screenshots.len() > rules::MAX_SCREENSHOTS {
    // rust: return Err(format!("at most {} screenshots", rules::MAX_SCREENSHOTS));
}
    // New names never reuse one the entry has had, so a page cached elsewhere never shows the wrong image.
    // rust: let taken: Vec<String> = entry
    // rust: .screenshots
    // rust: .iter()
    // rust: .filter_map(|s| s.rsplit('/').next()?.split('.').next().map(str::to_owned))
    // rust: .collect();
    // rust: let mut n = 1;
    // rust: for (extension, bytes) in &images.screenshots {
    // rust: while taken.contains(&n.to_string()) {
    // rust: n += 1;
}
    // rust: let path = format!("screenshots/{id}/{n}.{extension}");
    // rust: kept.push(path.clone());
    // rust: writes.push((path, bytes.clone()));
    // rust: n += 1;
}
    // rust: entry.screenshots = kept;
    // rust: Ok(writes)
}

// Writes the images on `branch`, each replacing what main has at its path.
    // rust: pub fn write(
    // rust: gh: &GitHub,
    // rust: writes: &[(String, Vec<u8>)],
    // rust: branch: &str,
    // rust: message: &str,
    // rust: ) -> Result<(), Refusal> {
    // rust: for (path, bytes) in writes {
    // rust: let blob = gh.blob(path).map_err(github_down)?;
    // rust: gh.put(path, bytes, branch, blob.as_deref(), message)
    // rust: .map_err(github_down)?;
}
    // rust: Ok(())
}

// "Edit project": an owner (by GitHub ID) changes the page of `form.id`, no version added. Opens
// a pull request labelled `owner-edit`; returns its address.
    // rust: pub fn edit(
    // rust: config: &Config,
    // rust: login: &str,
    // rust: user_id: u64,
    // rust: form: &Form,
    // rust: images: &Uploads,
    // rust: ) -> Result<String, Refusal> {
    // rust: let gh = &config.github;
    // rust: let Some((before, blob)) = gh.entry(&form.id).map_err(github_down)? else {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::NOT_FOUND,
    // rust: format!("{} is not in the registry", form.id),
    // rust: ));
}
    // rust: if ownership(&before, login, user_id) != Ownership::ById {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::FORBIDDEN,
    // rust: format!(
    // rust: "{} is {}'s: only its owners edit its page",
    // rust: form.id,
    // rust: before.owners.join(", ")
    // rust: ),
    // rust: ));
}
    // rust: check_form(form, &before.kind).map_err(bad)?;
    // rust: let mut entry = before.clone();
    // rust: entry.name = form.name.trim().to_owned();
    // rust: entry.summary = form.summary.trim().to_owned();
    // rust: entry.description = form.description.clone();
    // rust: entry.authors = form.authors.clone();
    // rust: entry.license = form.license.trim().to_owned();
    // rust: entry.source = form.source.trim().to_owned();
    // rust: entry.categories = form.categories.clone();
    // rust: entry.tags = form.tags.clone();
    // rust: let writes = place(&mut entry, form, images).map_err(bad)?;
    // rust: let problems = entry.check_fields();
    // rust: if !problems.is_empty() {
    // rust: return Err(bad(problems.join("; ")));
}
    // rust: if entry == before && writes.is_empty() {
    // rust: return Err(bad("nothing changed"));
}
    // rust: let changed: Vec<&str> = [
    // rust: ("name", entry.name != before.name),
    // rust: ("summary", entry.summary != before.summary),
    // rust: ("description", entry.description != before.description),
    // rust: ("authors", entry.authors != before.authors),
    // rust: ("licence", entry.license != before.license),
    // rust: ("source", entry.source != before.source),
    // rust: ("categories", entry.categories != before.categories),
    // rust: ("tags", entry.tags != before.tags),
    // rust: ("icon", images.icon.is_some()),
    // rust: ("screenshots", entry.screenshots != before.screenshots),
    // rust: ]
    // rust: .into_iter()
    // rust: .filter_map(|(field, changed)| changed.then_some(field))
    // rust: .collect();
    // rust: let branch = format!("edit/{}-{}", form.id, now());
    // rust: if !gh.branch(&branch).map_err(github_down)? {
    // rust: return Err(Refusal::new(
    // rust: StatusCode::CONFLICT,
    // rust: "an edit of this project was just sent: wait a second and send it again",
    // rust: ));
}
    // rust: let message = format!(
    // rust: "Edit {}'s page\n\nSubmitted by @{login} through the form.\n\nCo-authored-by: {login} <{user_id}+{login}@users.noreply.github.com>",
    // rust: form.id
    // rust: );
    // rust: let text = entry.to_toml().map_err(bad)?;
    // rust: gh.put(
    // rust: &format!("mods/{}.toml", form.id),
    // rust: &text,
    // rust: &branch,
    // rust: Some(&blob),
    // rust: &message,
    // rust: )
    // rust: .map_err(github_down)?;
    // rust: write(gh, &writes, &branch, &message)?;
    // rust: let body = format!(
    // rust: "<!-- submitted-by: {login} -->\n🤖 Page edit sent through the form by @{login}, an owner of `{id}` (GitHub ID \
    // rust: {user_id}). The form opens the pull request with the registry's token: neither Ludovic nor a reviewer wrote it.\n\n\
    // rust: No new version: it changes the {fields}. Reviewers: read the new page text and look at the images.",
    // rust: id = form.id,
    // rust: fields = changed.join(", "),
    // rust: );
    // rust: let (url, number) = gh
    // rust: .pull(&format!("Edit {}'s page", form.id), &branch, &body)
    // rust: .map_err(github_down)?;
    // rust: if let Err(e) = gh.label(number, "owner-edit") {
    // rust: eprintln!("labelling {url}: {} {}", e.status, e.message);
}
    // rust: Ok(url)
}
