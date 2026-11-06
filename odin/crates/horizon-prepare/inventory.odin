//! Transpiled from Horizon Rust crate
package horizon_prepare_inventory

import "core:fmt"
import "core:mem"
import "core:math"

// Class inventories of the imported jars (tools/lab.py's `inventory` and `ClassReader`): each
// class's SourceFile and method count, read from the bytecode; no Java text is published.

// use crate::pyjson::Value;
// use std::path::Path;

ClassReader :: struct {
    data: ^'a [u8],
    offset: uint,
}

    // rust: impl ClassReader<'_> {
take :: proc(self: ^Self, count: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let value = self
    // rust: .data
    // rust: .get(self.offset..self.offset + count)
    // rust: .ok_or("Truncated class file")?;
    // rust: self.offset += count;
    // rust: Ok(value)
}

number :: proc(self: ^Self, count: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self
    // rust: .take(count)?
    // rust: .iter()
    // rust: .fold(0usize, |n, b| (n << 8) | *b as usize))
}

attributes :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let count = self.number(2)?;
    // rust: let mut attributes = Vec::with_capacity(count);
    // rust: for _ in 0..count {
    // rust: let name = self.number(2)?;
    // rust: let length = self.number(4)?;
    // rust: attributes.push((name, self.take(length)?.to_vec()));
}
    // rust: Ok(attributes)
}

    // `(SourceFile, method count)`.
metadata :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.take(4)? != b"\xca\xfe\xba\xbe" {
    // rust: return Err("Invalid class file magic".into());
}
    // rust: self.take(4)?; // Minor and major version.
    // rust: let mut pool: Vec<Option<String>> = vec![None; self.number(2)?];
    // rust: let mut i = 1;
    // rust: while i < pool.len() {
    // rust: let tag = self.number(1)?;
    // rust: if tag == 1 {
    // rust: let length = self.number(2)?;
    // rust: pool[i] = Some(String::from_utf8_lossy(self.take(length)?).into_owned());
    // rust: } else {
    // rust: let size = match tag {
    // rust: 3 | 4 | 9 | 10 | 11 | 12 | 17 | 18 => 4,
    // rust: 5 | 6 => 8,
    // rust: 7 | 8 | 16 | 19 | 20 => 2,
    // rust: 15 => 3,
    // rust: _ => return Err(format!("Unknown constant pool tag: {tag}")),
}
    // rust: self.take(size)?;
}
    // rust: i += if tag == 5 || tag == 6 { 2 } else { 1 };
}
    // rust: self.take(6)?; // Access, this class, super class.
    // rust: let interfaces = self.number(2)?;
    // rust: self.take(interfaces * 2)?;
    // rust: for _ in 0..self.number(2)? {
    // rust: self.take(6)?; // Fields.
    // rust: self.attributes()?;
}
    // rust: let methods = self.number(2)?;
    // rust: for _ in 0..methods {
    // rust: self.take(6)?;
    // rust: self.attributes()?;
}
    // rust: let mut source = None;
    // rust: for (name, data) in self.attributes()? {
    // rust: if pool.get(name).and_then(Option::as_deref) == Some("SourceFile") {
    // rust: let [high, low] = data[..] else {
    // rust: return Err("Malformed SourceFile attribute".into());
}
    // rust: let index = ((high as usize) << 8) | low as usize;
    // rust: source = Some(
    // rust: pool.get(index)
    // rust: .cloned()
    // rust: .flatten()
    // rust: .ok_or("SourceFile points outside the constant pool")?,
    // rust: );
}
}
    // rust: Ok((source, methods))
}
}

// PurePosixPath(name).parent as text.
parent :: proc(name: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match name.trim_end_matches('/').rsplit_once('/') {
    // rust: Some((parent, _)) if !parent.is_empty() => parent,
    // rust: Some(_) => "/",
    // rust: None => ".",
}
}

inventory :: proc(jar: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut archive = crate::open_zip(jar)?;
    // rust: let mut classes = Vec::new();
    // rust: let mut packages: Vec<(String, usize)> = Vec::new();
    // rust: let mut sources = std::collections::BTreeSet::new();
    // rust: let mut method_count = 0;
    // rust: for index in 0..archive.len() {
    // rust: let mut item = archive.by_index(index).map_err(|e| e.to_string())?;
    // rust: let name = item.name().map_err(|e| e.to_string())?.into_owned();
    // rust: if !name.ends_with(".class") {
    // rust: continue;
}
    // rust: let size = item.size();
    // rust: let mut data = Vec::with_capacity(size as usize);
    // rust: std::io::Read::read_to_end(&mut item, &mut data).map_err(|e| e.to_string())?;
    // rust: let (source, methods) = ClassReader {
    // rust: data: &data,
    // rust: offset: 0,
}
    // rust: .metadata()
    // rust: .map_err(|e| format!("{name}: {e}"))?;
    // rust: let file = name.rsplit('/').next().unwrap();
    // rust: let source = source.filter(|s| !s.is_empty()).unwrap_or_else(|| {
    // rust: let stem = file.split('$').next().unwrap();
    // rust: format!("{}.java", stem.strip_suffix(".class").unwrap_or(stem))
    // rust: });
    // rust: if source.contains('/') || source.contains('\\') || source == "." {
    // rust: return Err(format!("Unsafe SourceFile attribute in {name}"));
}
    // rust: let directory = parent(&name);
    // rust: let source_path = if directory == "." {
    // rust: source
    // rust: } else {
    // rust: format!("{directory}/{source}")
}
    // rust: match packages.iter_mut().find(|(p, _)| p == directory) {
    // rust: Some(entry) => entry.1 += 1,
    // rust: None => packages.push((directory.to_string(), 1)),
}
    // rust: sources.insert(source_path.clone());
    // rust: method_count += methods;
    // rust: classes.push(Value::Object(vec![
    // rust: ("class".into(), Value::Str(name)),
    // rust: ("source".into(), Value::Str(source_path)),
    // rust: ("bytecode_bytes".into(), Value::Int(size.to_string())),
    // rust: ("methods".into(), Value::Int(methods.to_string())),
    // rust: ]));
}
    // Counter.most_common: by count, ties in first-seen order.
    // rust: packages.sort_by_key(|(_, count)| std::cmp::Reverse(*count));
    // rust: Ok(Value::Object(vec![
    // rust: (
    // rust: "jar_sha256".into(),
    // rust: Value::Str(crate::digest(jar, "sha256")?),
    // rust: ),
    // rust: ("class_count".into(), Value::Int(classes.len().to_string())),
    // rust: (
    // rust: "expected_source_files".into(),
    // rust: Value::Array(sources.into_iter().map(Value::Str).collect()),
    // rust: ),
    // rust: ("method_count".into(), Value::Int(method_count.to_string())),
    // rust: (
    // rust: "packages".into(),
    // rust: Value::Object(
    // rust: packages
    // rust: .into_iter()
    // rust: .map(|(p, n)| (p, Value::Int(n.to_string())))
    // rust: .collect(),
    // rust: ),
    // rust: ),
    // rust: ("classes".into(), Value::Array(classes)),
    // rust: ]))
}
