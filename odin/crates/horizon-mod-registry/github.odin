//! Transpiled from Horizon Rust crate
package horizon_mod_registry_github

import "core:fmt"
import "core:mem"
import "core:math"

// What the service asks of GitHub: the sign-in (OAuth, no scope: only the
// public profile), and with the bot's token on the registry repository
// alone, an entry, the `staging` release, a branch, a file, a pull request.
// Blocking (ureq): called from tokio's blocking pool.
// use base64::{Engine, engine::general_purpose::STANDARD};
// use horizon_mods::index::registry::Entry;
// use serde_json::{Value, json};
// use std::{path::Path, time::Duration};

// Where GitHub is: the real one, or a test's mock.
Endpoints :: struct {
    // `https://github.com`: OAuth.
    web: string,
    // `https://api.github.com`.
    api: string,
    // `https://uploads.github.com`: release assets.
    uploads: string,
}

    // rust: impl Default for Endpoints {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Endpoints {
    // rust: web: "https://github.com".into(),
    // rust: api: "https://api.github.com".into(),
    // rust: uploads: "https://uploads.github.com".into(),
}
}
}

GitHub :: struct {
    at: Endpoints,
    // `owner/name` of the registry repository.
    repo: string,
    client_id: string,
    client_secret: string,
    // Fine-grained, this repository only: contents and pull requests.
    bot_token: string,
    // How long one call may take, and the file's upload: past it, the
    // submitter is told GitHub is slow rather than left waiting.
    call_timeout: Duration,
    upload_timeout: Duration,
    agent: ureq::Agent,
}

// A failed call: `status` is GitHub's, 0 when it wasn't reached.
Failure :: struct {
    status: u16,
    message: string,
    // GitHub didn't answer in time.
    timed_out: bool,
}

// Whether `e`, or what caused it, is a timeout.
timed_out :: proc(e: ^(dyn std::error::Error + 'static) {
}
    // rust: let mut cause = Some(e);
    // rust: while let Some(e) = cause {
    // rust: if e.downcast_ref::<std::io::Error>().is_some_and(|e| {
    // rust: matches!(
    // rust: e.kind(),
    // rust: std::io::ErrorKind::TimedOut | std::io::ErrorKind::WouldBlock
    // rust: )
    // rust: }) {
    // rust: return true;
}
    // rust: cause = e.source();
}
    // rust: false
}

    // rust: type Result<T> = std::result::Result<T, Failure>;

failure :: proc(e: ureq::Error) -> F {
    // Ported from Horizon
    return {}
}
    // rust: match e {
    // rust: ureq::Error::Status(status, response) => Failure {
    // rust: status,
    // rust: message: response
    // rust: .into_string()
    // rust: .unwrap_or_default()
    // rust: .chars()
    // rust: .take(300)
    // rust: .collect(),
    // rust: timed_out: false,
    // rust: },
    // rust: other => Failure {
    // rust: status: 0,
    // rust: timed_out: timed_out(&other),
    // rust: message: other.to_string(),
    // rust: },
}
}

read :: proc(response: ureq::Response) -> R {
    // Ported from Horizon
    return {}
}
    // rust: response.into_json().map_err(|e| Failure {
    // rust: status: 0,
    // rust: timed_out: timed_out(&e),
    // rust: message: e.to_string(),
    // rust: })
}

    // rust: impl GitHub {
    // rust: pub fn new(
    // rust: at: Endpoints,
    // rust: repo: String,
    // rust: client_id: String,
    // rust: client_secret: String,
    // rust: bot_token: String,
    // rust: ) -> GitHub {
    // rust: let agent = ureq::AgentBuilder::new()
    // rust: .timeout_connect(Duration::from_secs(10))
    // rust: .user_agent("horizon-mod-registry")
    // rust: .build();
    // rust: GitHub {
    // rust: at,
    // rust: repo,
    // rust: client_id,
    // rust: client_secret,
    // rust: bot_token,
    // rust: call_timeout: Duration::from_secs(30),
    // rust: upload_timeout: Duration::from_secs(300),
    // rust: agent,
}
}

    // Where the sign-in starts.
authorize_url :: proc(self: ^Self, redirect: string, state: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "{}/login/oauth/authorize?client_id={}&redirect_uri={}&state={state}&allow_signup=true",
    // rust: self.at.web,
    // rust: self.client_id,
    // rust: encode(redirect)
    // rust: )
}

    // The signed-in account (login, id) for an OAuth `code`. Its token is
    // used once and dropped.
sign_in :: proc(self: ^Self, code: string, redirect: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let token = self
    // rust: .agent
    // rust: .post(&format!("{}/login/oauth/access_token", self.at.web))
    // rust: .timeout(self.call_timeout)
    // rust: .set("Accept", "application/json")
    // rust: .send_json(json!({
    // rust: "client_id": self.client_id,
    // rust: "client_secret": self.client_secret,
    // rust: "code": code,
    // rust: "redirect_uri": redirect,
    // rust: }))
    // rust: .map_err(failure)
    // rust: .and_then(read)?;
    // rust: let Some(token) = token["access_token"].as_str() else {
    // rust: return Err(Failure {
    // rust: status: 401,
    // rust: message: "GitHub refused the sign-in".into(),
    // rust: timed_out: false,
    // rust: });
}
    // rust: let user = self
    // rust: .agent
    // rust: .get(&format!("{}/user", self.at.api))
    // rust: .timeout(self.call_timeout)
    // rust: .set("Authorization", &format!("Bearer {token}"))
    // rust: .set("Accept", "application/vnd.github+json")
    // rust: .call()
    // rust: .map_err(failure)
    // rust: .and_then(read)?;
    // rust: match (user["login"].as_str(), user["id"].as_u64()) {
    // rust: (Some(login), Some(id)) => Ok((login.to_owned(), id)),
    // rust: _ => Err(Failure {
    // rust: status: 0,
    // rust: message: "GitHub sent no login".into(),
    // rust: timed_out: false,
    // rust: }),
}
}

call :: proc(self: ^Self, method: string, path: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.agent
    // rust: .request(
    // rust: method,
    // rust: &format!("{}/repos/{}{path}", self.at.api, self.repo),
    // rust: )
    // rust: .timeout(self.call_timeout)
    // rust: .set("Authorization", &format!("Bearer {}", self.bot_token))
    // rust: .set("Accept", "application/vnd.github+json")
    // rust: .set("X-GitHub-Api-Version", "2022-11-28")
}

    // `mods/<id>.toml` on main, with its blob sha; None when it isn't there.
entry :: proc(self: ^Self, id: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let response = self
    // rust: .call("GET", &format!("/contents/mods/{id}.toml"))
    // rust: .query("ref", "main")
    // rust: .call();
    // rust: let file = match response {
    // rust: Ok(r) => read(r)?,
    // rust: Err(ureq::Error::Status(404, _)) => return Ok(None),
    // rust: Err(e) => return Err(failure(e)),
}
    // rust: let bytes = file["content"]
    // rust: .as_str()
    // rust: .map(|c| c.replace('\n', ""))
    // rust: .and_then(|c| STANDARD.decode(c).ok())
    // rust: .unwrap_or_default();
    // rust: let entry = toml::from_str(&String::from_utf8_lossy(&bytes)).map_err(|e| Failure {
    // rust: status: 0,
    // rust: message: format!("mods/{id}.toml on main: {e}"),
    // rust: timed_out: false,
    // rust: })?;
    // rust: Ok(Some((entry, file["sha"].as_str().unwrap_or("").to_owned())))
}

    // The blob sha of `path` on main, None when it isn't there: what replacing it needs.
blob :: proc(self: ^Self, path: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match self
    // rust: .call("GET", &format!("/contents/{path}"))
    // rust: .query("ref", "main")
    // rust: .call()
    // rust: {
    // rust: Ok(r) => Ok(read(r)?["sha"].as_str().map(str::to_owned)),
    // rust: Err(ureq::Error::Status(404, _)) => Ok(None),
    // rust: Err(e) => Err(failure(e)),
}
}

    // Uploads `path` as asset `name` of the `staging` prerelease, unless it
    // is already there (the same file submitted again).
stage :: proc(self: ^Self, name: string, path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let release = self
    // rust: .call("GET", "/releases/tags/staging")
    // rust: .call()
    // rust: .map_err(failure)
    // rust: .and_then(read)?;
    // rust: let there = release["assets"]
    // rust: .as_array()
    // rust: .is_some_and(|a| a.iter().any(|x| x["name"] == name));
    // rust: if there {
    // rust: return Ok(());
}
    // rust: let id = release["id"].as_u64().unwrap_or(0);
    // rust: let bytes = std::fs::read(path).map_err(|e| Failure {
    // rust: status: 0,
    // rust: message: e.to_string(),
    // rust: timed_out: false,
    // rust: })?;
    // rust: self.agent
    // rust: .post(&format!(
    // rust: "{}/repos/{}/releases/{id}/assets",
    // rust: self.at.uploads, self.repo
    // rust: ))
    // rust: .query("name", name)
    // rust: .timeout(self.upload_timeout)
    // rust: .set("Authorization", &format!("Bearer {}", self.bot_token))
    // rust: .set("Accept", "application/vnd.github+json")
    // rust: .set("Content-Type", "application/octet-stream")
    // rust: .send_bytes(&bytes)
    // rust: .map_err(failure)?;
    // rust: Ok(())
}

    // Makes branch `name` from main; false when it already exists.
branch :: proc(self: ^Self, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let main = self
    // rust: .call("GET", "/git/ref/heads/main")
    // rust: .call()
    // rust: .map_err(failure)
    // rust: .and_then(read)?;
    // rust: let sha = main["object"]["sha"].as_str().unwrap_or("");
    // rust: match self
    // rust: .call("POST", "/git/refs")
    // rust: .send_json(json!({"ref": format!("refs/heads/{name}"), "sha": sha}))
    // rust: {
    // rust: Ok(_) => Ok(true),
    // rust: Err(ureq::Error::Status(422, _)) => Ok(false),
    // rust: Err(e) => Err(failure(e)),
}
}

    // The address of the open pull request from `branch`, if there is one.
open_pull :: proc(self: ^Self, branch: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let owner = self.repo.split('/').next().unwrap_or("");
    // rust: let pulls = self
    // rust: .call("GET", "/pulls")
    // rust: .query("head", &format!("{owner}:{branch}"))
    // rust: .query("state", "open")
    // rust: .call()
    // rust: .map_err(failure)
    // rust: .and_then(read)?;
    // rust: Ok(pulls
    // rust: .as_array()
    // rust: .and_then(|p| p.first())
    // rust: .map(|p| p["html_url"].as_str().unwrap_or("").to_owned()))
}

    // The messages of `branch`'s commits that aren't on main.
commits :: proc(self: ^Self, branch: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let compare = self
    // rust: .call("GET", &format!("/compare/main...{branch}"))
    // rust: .call()
    // rust: .map_err(failure)
    // rust: .and_then(read)?;
    // rust: Ok(compare["commits"]
    // rust: .as_array()
    // rust: .map(|c| {
    // rust: c.iter()
    // rust: .map(|c| c["commit"]["message"].as_str().unwrap_or("").to_owned())
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default())
}

    // Moves branch `name` back to main, dropping its own commits.
reset :: proc(self: ^Self, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let main = self
    // rust: .call("GET", "/git/ref/heads/main")
    // rust: .call()
    // rust: .map_err(failure)
    // rust: .and_then(read)?;
    // rust: let sha = main["object"]["sha"].as_str().unwrap_or("");
    // rust: self.call("PATCH", &format!("/git/refs/heads/{name}"))
    // rust: .send_json(json!({"sha": sha, "force": true}))
    // rust: .map_err(failure)?;
    // rust: Ok(())
}

    // Writes `path` on `branch` in one commit; `sha` is the blob it replaces.
    // rust: pub fn put(
    // rust: &self,
    // rust: path: &str,
    // rust: content: impl AsRef<[u8]>,
    // rust: branch: &str,
    // rust: sha: Option<&str>,
    // rust: message: &str,
    // rust: ) -> Result<()> {
    // rust: let mut body = json!({
    // rust: "message": message,
    // rust: "content": STANDARD.encode(content),
    // rust: "branch": branch,
    // rust: });
    // rust: if let Some(sha) = sha {
    // rust: body["sha"] = json!(sha);
}
    // rust: self.call("PUT", &format!("/contents/{path}"))
    // rust: .send_json(body)
    // rust: .map_err(failure)?;
    // rust: Ok(())
}

    // Opens the pull request; its address and number.
pull :: proc(self: ^Self, title: string, head: string, body: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let pr = self
    // rust: .call("POST", "/pulls")
    // rust: .send_json(json!({"title": title, "head": head, "base": "main", "body": body}))
    // rust: .map_err(failure)
    // rust: .and_then(read)?;
    // rust: Ok((
    // rust: pr["html_url"].as_str().unwrap_or("").to_owned(),
    // rust: pr["number"].as_u64().unwrap_or(0),
    // rust: ))
}

    // Adds `label` to pull request `number` (GitHub creates it when new).
label :: proc(self: ^Self, number: u64, label: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.call("POST", &format!("/issues/{number}/labels"))
    // rust: .send_json(json!({"labels": [label]}))
    // rust: .map_err(failure)?;
    // rust: Ok(())
}
}

// Percent-encodes a query value.
encode :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: s.bytes()
    // rust: .map(|b| match b {
    // rust: b'A'..=b'Z' | b'a'..=b'z' | b'0'..=b'9' | b'-' | b'.' | b'_' | b'~' => {
    // rust: (b as char).to_string()
}
    // rust: _ => format!("%{b:02X}"),
    // rust: })
    // rust: .collect()
}
