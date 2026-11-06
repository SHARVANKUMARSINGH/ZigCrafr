//! Transpiled from Horizon Rust crate
package horizon_release_sign_main

import "core:fmt"
import "core:mem"
import "core:math"

// horizon-release-sign: checks a release's signed checksums, and makes new keys
// (docs/release-flow.md, "Signed checksums"). The signing itself is tools/ci/sign_release.sh: the
// job that holds the private key runs only the runner's sha256sum and OpenSSL, no code from the
// repository.
//
//     horizon-release-sign verify --tag v2026.10.19 [--key <base64>] [--signature <file>] [--publishing] <folder>
//     horizon-release-sign keygen --public-out key.pub | gh secret set RELEASE_SIGNING_KEY --env release
//
// `verify` checks SHA256SUMS.sig (or `--signature`, e.g. a Nightly's SHA256SUMS.v2.sig with
// `--tag nightly-<date>-<commit>`) and every file SHA256SUMS lists with the keys built in from
// release-keys.txt (or `--key`), as the launcher does. With `--publishing` (release.yml) a release
// may go out unsigned, or signed with a key nobody can check yet, only while release-keys.txt
// lists no key; once it lists one, anything launchers would refuse fails the release.

// use horizon_release_sign::{SIGNATURE, SUMS, Sha256, SigningKey, parse_keys, trusted_keys, verify};
// use std::io::{IsTerminal, Read, Write};
// use std::path::{Path, PathBuf};
// use std::process::ExitCode;

main :: proc() -> E {
    // Ported from Horizon
    return {}
}
    // rust: let args: Vec<String> = std::env::args().skip(1).collect();
    // rust: let result = match args.first().map(String::as_str) {
    // rust: Some("verify") => check_folder(&args[1..]),
    // rust: Some("keygen") => keygen(&args[1..]),
    // rust: _ => Err(
    // rust: "usage: horizon-release-sign verify --tag <tag> [--key <base64>]... [--signature <file>] \
    // rust: [--publishing] <folder> | keygen --public-out <file>"
    // rust: .into(),
    // rust: ),
}
    // rust: match result {
    // rust: Ok(()) => ExitCode::SUCCESS,
    // rust: Err(e) => {
    // rust: eprintln!("horizon-release-sign: {e}");
    // rust: ExitCode::FAILURE
}
}
}

// The values of every `--name value` in `args`, and the other arguments.
options :: proc(args: ^[string], name: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut values = Vec::new();
    // rust: let mut rest = Vec::new();
    // rust: let mut it = args.iter();
    // rust: while let Some(arg) = it.next() {
    // rust: if arg == name {
    // rust: values.extend(it.next().cloned());
    // rust: } else {
    // rust: rest.push(arg.clone());
}
}
    // rust: (values, rest)
}

tag_of :: proc(args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (tags, rest) = options(args, "--tag");
    // rust: let tag = tags.into_iter().next().ok_or("--tag <tag> is needed")?;
    // rust: Ok((tag, rest))
}

file_hash :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut file = std::fs::File::open(path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let mut hash = Sha256::default();
    // rust: let mut buffer = vec![0; 1 << 16];
    // rust: loop {
    // rust: let n = file
    // rust: .read(&mut buffer)
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: if n == 0 {
    // rust: return Ok(hash.hex());
}
    // rust: hash.update(&buffer[..n]);
}
}

// Checks a folder holding a release's assets, as the launcher does.
check_folder :: proc(args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (tag, rest) = tag_of(args)?;
    // rust: let (keys, rest) = options(&rest, "--key");
    // rust: let (signature_file, rest) = options(&rest, "--signature");
    // rust: let signature_file = signature_file
    // rust: .into_iter()
    // rust: .next()
    // rust: .unwrap_or_else(|| SIGNATURE.to_owned());
    // rust: if signature_file.contains(['/', '\\']) {
    // rust: return Err(format!(
    // rust: "--signature names a file of the folder, not {signature_file:?}"
    // rust: ));
}
    // rust: let publishing = rest.iter().any(|a| a == "--publishing");
    // rust: let folder = PathBuf::from(
    // rust: rest.iter()
    // rust: .find(|a| *a != "--publishing")
    // rust: .ok_or("verify needs the release's folder")?,
    // rust: );
    // rust: let keys = if keys.is_empty() {
    // rust: trusted_keys()
    // rust: } else {
    // rust: parse_keys(&keys.join("\n"))?
}
    // rust: let sums = std::fs::read(folder.join(SUMS)).map_err(|e| format!("{SUMS}: {e}"))?;
    // rust: let listed = match std::fs::read_to_string(folder.join(&signature_file)) {
    // rust: Ok(signature) if !keys.is_empty() => verify(&tag, &sums, &signature, &keys)?,
    // rust: Ok(_) if publishing => {
    // rust: println!(
    // rust: "::warning::{tag}: signed, but release-keys.txt lists no key yet, so launchers can't check it"
    // rust: );
    // rust: horizon_release_sign::parse_sums(&String::from_utf8_lossy(&sums))?
}
    // rust: Err(_) if publishing && keys.is_empty() => {
    // rust: println!(
    // rust: "::warning::{tag}: published with {SUMS} but unsigned: release-keys.txt lists no key yet"
    // rust: );
    // rust: horizon_release_sign::parse_sums(&String::from_utf8_lossy(&sums))?
}
    // rust: Ok(_) => return Err("no key to check the signature with".into()),
    // rust: Err(_) => {
    // rust: return Err(format!(
    // rust: "{tag} has no {signature_file}: launchers would refuse it (is the release environment's \
    // rust: RELEASE_SIGNING_KEY set?)"
    // rust: ));
}
}
    // rust: for (name, hex) in &listed {
    // rust: horizon_release_sign::check(name, hex, &file_hash(&folder.join(name))?)?;
}
    // rust: println!("{tag}: {} files match {SUMS}", listed.len());
    // rust: Ok(())
}

// Prints a new private key to stdout, which must be a pipe (into `gh secret set`), never a
// terminal, and writes its public key to `--public-out`.
keygen :: proc(args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (public_out, _) = options(args, "--public-out");
    // rust: let public_out = public_out
    // rust: .into_iter()
    // rust: .next()
    // rust: .ok_or("keygen needs --public-out <file>")?;
    // rust: if std::io::stdout().is_terminal() {
    // rust: return Err(
    // rust: "keygen writes the private key to its output: pipe it into `gh secret set`".into(),
    // rust: );
}
    // rust: let (key, secret) = SigningKey::generate()?;
    // rust: std::fs::write(&public_out, key.public_base64() + "\n").map_err(|e| e.to_string())?;
    // rust: let mut out = std::io::stdout().lock();
    // rust: out.write_all(secret.as_bytes())
    // rust: .and_then(|()| out.flush())
    // rust: .map_err(|e| e.to_string())
}
