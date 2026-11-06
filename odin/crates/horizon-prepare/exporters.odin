//! Transpiled from Horizon Rust crate
package horizon_prepare_exporters

import "core:fmt"
import "core:mem"
import "core:math"

// Only original Horizon classes are packaged. The pinned jars remain player supplied.
// use crate::*;

SETTINGS :: "exporters-v1 --release -proc:none -encoding UTF-8"
    // rust: const SERVER: &[&str] = &[
    // rust: "VanillaHeightmapOracle",
    // rust: "VanillaBlockLandingOracle",
    // rust: "VanillaEntityAttributeOracle",
    // rust: "VanillaPlayerHealthOracle",
    // rust: "VanillaDamageSourceOracle",
    // rust: "VanillaCollisionOracle",
    // rust: "VanillaFaceVisibilityOracle",
    // rust: "VanillaGameplayFactsExporter",
    // rust: "VanillaEntityTypesExporter",
    // rust: "VanillaBlockBehaviourExporter",
    // rust: "VanillaCommandParseOracle",
    // rust: "VanillaCreativeTabsExporter",
    // rust: "VanillaSimpleBlockOracle",
    // rust: "VanillaStructureBlockExporter",
    // rust: "PrepareWorker",
    // rust: ];
    // rust: const CLIENT: &[&str] = &[
    // rust: "VanillaBlockStateBindingOracle",
    // rust: "VanillaEntityModelExporter",
    // rust: "VanillaMobDataExporter",
    // rust: "PrepareWorker",
    // rust: ];

files :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut result = Vec::new();
    // rust: for entry in fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))? {
    // rust: let path = entry.map_err(|e| e.to_string())?.path();
    // rust: if path.is_dir() {
    // rust: result.extend(files(&path)?);
    // rust: } else {
    // rust: result.push(path);
}
}
    // rust: result.sort();
    // rust: Ok(result)
}

// research-lock pins both jars and every accepted client manifest (which pins its libraries).
// artifacts::verify/client_libraries check those dependencies before any bundle is used.
    // rust: pub(crate) fn key(root: &Path) -> Result<String, String> {
    // rust: let mut hash = sha2::Sha256::new();
    // rust: hash.update(SETTINGS);
    // The launcher's bundled preparer may differ from the selected game's. Hash that
    // version's compiler settings so a newer release still selects a runtime correctly.
    // rust: let compiler = fs::read_to_string(root.join("crates/horizon-prepare/src/exporters.rs"))
    // rust: .unwrap_or_else(|_| include_str!("exporters.rs").into());
    // rust: hash.update(compiler.replace('\r', ""));
    // rust: let mut sources = files(&root.join(PARITY))?;
    // rust: sources.retain(|p| p.extension().is_some_and(|e| e == "java"));
    // rust: sources.push(root.join("research-lock.json"));
    // rust: for path in sources {
    // rust: let data: Vec<_> = read(&path)?.into_iter().filter(|b| *b != b'\r').collect();
    // rust: hash.update(format!(
    // rust: "{}\0{}\0",
    // rust: relative_display(&path, root)?.replace('\\', "/"),
    // rust: data.len()
    // rust: ));
    // rust: hash.update(data);
}
    // rust: Ok(hex(&hash.finalize()))
}

outputs :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut hashes = Value::Object(Vec::new());
    // rust: for path in files(dir)? {
    // rust: if path.extension().is_some_and(|e| e == "class") {
    // rust: let name = relative_display(&path, dir)?.replace('\\', "/");
            // javac's sourcepath contains our sources only; enforce that at packaging too.
    // rust: if !name.starts_with("server/dev/horizonlab/parity/")
    // rust: && !name.starts_with("client/dev/horizonlab/parity/")
    // rust: {
    // rust: return Err(format!("Non-Horizon class in exporter bundle: {name}"));
}
    // rust: hashes.insert(&name, Value::Str(digest(&path, "sha256")?));
}
}
    // rust: Ok(hashes)
}

valid :: proc(dir: ^Path, key: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(manifest) = read_json(&dir.join("manifest.json")) else {
    // rust: return false;
}
    // rust: manifest.get("key").and_then(Value::as_str) == Some(key)
    // rust: && outputs(dir).is_ok_and(|hashes| {
    // rust: !hashes.as_object().unwrap().is_empty() && manifest.get("classes") == Some(&hashes)
    // rust: })
}

// Whether the version ships a matching, intact bundle and needs only a Java runtime.
available :: proc(root: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: key(root).is_ok_and(|key| valid(&root.join("exporters"), &key))
}

    // rust: pub(crate) fn classes(run: &Run) -> Result<PathBuf, String> {
    // rust: let key = key(&run.root)?;
    // rust: let shipped = run.root.join("exporters");
    // rust: if valid(&shipped, &key) {
    // rust: return Ok(shipped);
}
    // rust: let cached = run.local.join("exporters").join(&key);
    // rust: if valid(&cached, &key) {
    // rust: return Ok(cached);
}
    // Build privately: an interrupted compiler or another preparer cannot publish partial classes.
    // rust: let destination = cached;
    // rust: let cached = run
    // rust: .local
    // rust: .join("exporters")
    // rust: .join(format!(".{key}-{}", std::process::id()));
    // rust: if cached.exists() {
    // rust: fs::remove_dir_all(&cached).map_err(|e| e.to_string())?;
}
    // rust: mkdir(&cached)?;
    // rust: let jdk = java::find(run.java_major, &[run.jdk.home()])?;
    // The two sides compile at once: neither reads the other's classes.
    // rust: let sides = [
    // rust: ("server", SERVER, &run.server_classpath),
    // rust: ("client", CLIENT, &run.client_classpath),
    // rust: ];
    // rust: crate::pool::map(&sides, |(side, mains, cp)| {
    // rust: (run.log)(&format!("Compiling {side} exporters (shared helpers once)"));
    // rust: let started = std::time::Instant::now();
    // rust: let classes = cached.join(side);
    // rust: mkdir(&classes)?;
    // rust: let log = run.log_file(&cached.join(format!("{side}.log")))?;
    // rust: let mut args = vec![
    // rust: "-encoding".into(),
    // rust: "UTF-8".into(),
    // rust: "-cp".into(),
    // rust: cp.to_string(),
    // rust: "-sourcepath".into(),
    // rust: arg(&run.root.join("mods/horizon/src/test/java")),
    // rust: "-d".into(),
    // rust: arg(&classes),
    // rust: ];
    // rust: args.extend(mains.iter().map(|n| arg(&run.oracle(&format!("{n}.java")))));
    // rust: jdk.javac(run.java_major, &args, &log)?;
    // rust: let validate = vec![
    // rust: "-Xverify:all".into(),
    // rust: "-cp".into(),
    // rust: format!(
    // rust: "{}{}{}",
    // rust: classes.display(),
    // rust: if cfg!(windows) { ";" } else { ":" },
    // rust: cp
    // rust: ),
    // rust: "dev.horizonlab.parity.PrepareWorker".into(),
    // rust: "validate".into(),
    // rust: arg(&classes),
    // rust: ];
        // No exporter executes here: resolve every class and its signatures against pinned jars.
    // rust: run.jdk.java(&validate, Some(&run.local), &log)?;
    // rust: (run.log)(&format!(
    // rust: "Compiled {side} exporters{}",
    // rust: crate::took(started)
    // rust: ));
    // rust: Ok(())
    // rust: })?;
    // rust: let manifest = Value::Object(vec![
    // rust: ("key".into(), Value::Str(key.clone())),
    // rust: ("classes".into(), outputs(&cached)?),
    // rust: ]);
    // rust: write_json(&cached.join("manifest.json"), &manifest)?;
    // rust: if valid(&destination, &key) {
    // rust: fs::remove_dir_all(&cached).map_err(|e| e.to_string())?;
    // rust: } else {
    // rust: if destination.exists() {
    // rust: fs::remove_dir_all(&destination).map_err(|e| e.to_string())?;
}
    // rust: fs::rename(&cached, &destination).map_err(|e| e.to_string())?;
}
    // rust: Ok(destination)
}

    // rust: mod tests {
//     use super::*;

bundles_invalidate_sources_pins_and_damaged_classes :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("prepare-bundle-{}", std::process::id()));
    // rust: let source = root.join(PARITY).join("VanillaHeightmapOracle.java");
    // rust: mkdir(source.parent().unwrap()).unwrap();
    // rust: write(&source, b"original\n").unwrap();
    // rust: let compiler = root.join("crates/horizon-prepare/src/exporters.rs");
    // rust: mkdir(compiler.parent().unwrap()).unwrap();
    // rust: write(&compiler, b"--release 25 -proc:none").unwrap();
    // rust: write(&root.join("research-lock.json"), b"pins").unwrap();
    // rust: let original = key(&root).unwrap();
    // rust: write(&compiler, b"--release 26 -proc:none").unwrap();
    // rust: assert_ne!(key(&root).unwrap(), original);
    // rust: write(&compiler, b"--release 25 -proc:none").unwrap();
    // rust: write(&source, b"original\r\n").unwrap();
    // rust: assert_eq!(key(&root).unwrap(), original);
    // rust: write(&source, b"changed").unwrap();
    // rust: assert_ne!(key(&root).unwrap(), original);
    // rust: write(&source, b"original\n").unwrap();
    // rust: write(&root.join("research-lock.json"), b"new dependencies").unwrap();
    // rust: assert_ne!(key(&root).unwrap(), original);
    // rust: write(&root.join("research-lock.json"), b"pins").unwrap();
    // rust: let bundle = root.join("exporters");
    // rust: let class = bundle.join("server/dev/horizonlab/parity/Helper.class");
    // rust: mkdir(class.parent().unwrap()).unwrap();
    // rust: write(&class, b"compiled").unwrap();
    // rust: write_json(
    // rust: &bundle.join("manifest.json"),
    // rust: &Value::Object(vec![
    // rust: ("key".into(), Value::Str(original)),
    // rust: ("classes".into(), outputs(&bundle).unwrap()),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(available(&root));
    // rust: write(&class, b"damaged").unwrap();
    // rust: assert!(!available(&root));
    // rust: fs::remove_file(&class).unwrap();
    // rust: assert!(!available(&root));
    // rust: fs::remove_dir_all(root).unwrap();
}
}
