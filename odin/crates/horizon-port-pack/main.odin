//! Transpiled from Horizon Rust crate
package horizon_port_pack_main

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-port-pack`: port a Java modpack to Horizon (`docs/modpacks.md`).
//
// - `import <pack> <work>`: a `.mrpack`, CurseForge zip or instance folder
//   to `<work>/pack.json`.
// - `inventory <work> [--offline]`: Modrinth metadata (cached in
//   `<work>/modrinth.json`), the jars in the instance or `<work>/jars/`,
//   classes, tiers and dependency layers in `<work>/inventory.json` and
//   `inventory.csv`.
// - `fetch <work> [--from <folder>] [<mod id>...]`: the jars of the
//   portable mods (content, data tier; or the ones named) into
//   `<work>/jars/`: copied from the player's folder, or downloaded from the
//   pack's own links or Modrinth's CDN, hash checked. What only CurseForge
//   has needs a key and is listed in `<work>/fetch.json`.
// - `carry <work> [--resources <prepared>] [<mod id>...]`: the content
//   mods' data and assets into `<work>/mods/<id>/carry/`, a folder mod for
//   local use. With the NeoForge oracle's `<work>/oracle/facts.json`
//   (`tools/neoforge_oracle.py`), blocks and items come from its facts;
//   `--resources` limits templates to the blocks Horizon's tables have.
// - `report <work>`: the coverage report, per mod ported, partial, not yet
//   or not needed with the reason, in `<work>/coverage.json` and
//   `coverage.md`.
// - `check <jar> <out>`: one mod jar on its own, as the launcher's mod
//   browser installs it: carried over into `<out>/carry/`, its classes
//   read, and the verdict (Works, Partly, Doesn't run) in
//   `<out>/check.json`.
// - `port <pack> <work> [--from <folder>] [--resources <prepared>]`: every
//   step for the portable mods, as the launcher's "Import modpack" runs it.
// - `upgrade-datapack <pack> <out> | --world <world>`: a 26.2 data pack
//   (zip or folder) with its world generation rewritten in 26.3's formats
//   (`docs/datapack-upgrade.md`), into the folder `<out>`, or into
//   `<world>/datapacks/<pack name>-26.3`.
//
// The work folder belongs to the user: jars and carried-over files stay
// there and are never uploaded or committed.
// use horizon_port_pack::{fetch, inventory::Record, pipeline, upgrade};
// use std::{
    // rust: path::{Path, PathBuf},
    // rust: process::ExitCode,
}

USAGE :: "usage: horizon-port-pack import <pack> <work> | inventory <work> [--offline] | fetch <work> [--from <folder>] [<mod id>...] | carry <work> [--resources <prepared>] [<mod id>...] | report <work> | check <jar> <out> | port <pack> <work> [--from <folder>] [--resources <prepared>] | upgrade-datapack <pack> (<out> | --world <world>)"

main :: proc() -> E {
    // Ported from Horizon
    return {}
}
    // rust: let mut args: Vec<String> = std::env::args().skip(1).collect();
    // rust: let result = (|| {
    // rust: let from = option(&mut args, "--from")?;
    // rust: let resources = option(&mut args, "--resources")?;
    // rust: let world = option(&mut args, "--world")?;
    // rust: let offline = take_flag(&mut args, "--offline");
    // rust: let path = |i: usize| args.get(i).map(Path::new).ok_or(USAGE.to_owned());
    // rust: let rest = || args.get(2..).unwrap_or_default().to_vec();
    // rust: let log = &|line: String| println!("{line}");
    // rust: match args.first().map(String::as_str) {
    // rust: Some("import") => pipeline::import(path(1)?, path(2)?, log).map(drop),
    // rust: Some("inventory") => pipeline::inventory(path(1)?, offline, log).map(drop),
    // rust: Some("fetch") => {
    // rust: let work = path(1)?;
    // rust: let records: Vec<Record> = pipeline::read_json(&work.join("inventory.json"))?;
    // rust: let only = rest();
    // rust: let want = |r: &Record| {
    // rust: if only.is_empty() {
    // rust: pipeline::portable(r)
    // rust: } else {
    // rust: only.contains(&r.key)
}
}
    // rust: fetch::fetch(work, &records, from.as_deref(), &want, log).map(drop)
}
    // rust: Some("carry") => {
    // rust: pipeline::carry(path(1)?, resources.as_deref(), &rest(), log).map(drop)
}
    // rust: Some("report") => {
    // rust: let work = path(1)?;
    // rust: pipeline::report(work, log)?;
    // rust: println!("{}", work.join("coverage.md").display());
    // rust: Ok(())
}
    // rust: Some("check") => {
    // rust: let c = horizon_port_pack::check::check(path(1)?, path(2)?)?;
    // rust: println!("{}: {}. {}", c.mod_id, c.verdict.label(), c.summary);
    // rust: for p in &c.ports {
    // rust: println!("  ports: {p}");
}
    // rust: for s in &c.skipped {
    // rust: println!("  skipped: {s}");
}
    // rust: Ok(())
}
    // rust: Some("port") => {
    // rust: let work = path(2)?;
    // rust: pipeline::import(path(1)?, work, log)?;
    // rust: pipeline::inventory(work, offline, log)?;
    // rust: pipeline::port(work, resources.as_deref(), from.as_deref(), log)?;
    // rust: println!("{}", work.join("coverage.md").display());
    // rust: Ok(())
}
    // rust: Some("upgrade-datapack") => {
    // rust: let pack = path(1)?;
    // rust: let out = match &world {
    // rust: Some(world) => {
    // rust: let name = pack.file_stem().unwrap_or_default().to_string_lossy();
    // rust: world.join("datapacks").join(format!("{name}-26.3"))
}
    // rust: None => path(2)?.to_path_buf(),
}
    // rust: let report = upgrade::upgrade_into(pack, &out)?;
    // rust: for line in report.lines() {
    // rust: println!("{line}");
}
    // rust: println!("{}", out.display());
    // rust: Ok(())
}
    // rust: _ => Err(USAGE.to_owned()),
}
    // rust: })();
    // rust: match result {
    // rust: Ok(()) => ExitCode::SUCCESS,
    // rust: Err(e) => {
    // rust: eprintln!("error: {e}");
    // rust: ExitCode::FAILURE
}
}
}

// Removes `--name <value>` from `args`.
option :: proc(args: ^[dynamic]string, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match args.iter().position(|a| a == name) {
    // rust: Some(i) if i + 1 < args.len() => {
    // rust: let value = args.remove(i + 1);
    // rust: args.remove(i);
    // rust: Ok(Some(PathBuf::from(value)))
}
    // rust: Some(_) => Err(USAGE.to_owned()),
    // rust: None => Ok(None),
}
}

take_flag :: proc(args: ^[dynamic]string, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let before = args.len();
    // rust: args.retain(|a| a != name);
    // rust: args.len() != before
}
