//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_integer_bounds
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Resolve the scalar signed/unsigned clamp case still ambiguous in Naga.
//! Only an unambiguous `int` value with two unsigned literal bounds is changed.
// use crate::macros::lex;
// use std::collections::{BTreeMap, BTreeSet};

    // rust: pub(super) fn rewrite(text: &str) -> String {
    // rust: let tokens = lex(text);
    // rust: let words: Vec<_> = tokens
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|t| !t.trim().is_empty())
    // rust: .collect();
    // rust: let mut types: BTreeMap<&str, BTreeSet<&str>> = BTreeMap::new();
    // rust: for pair in words.windows(2) {
    // rust: if matches!(
    // rust: pair[0],
    // rust: "int"
    // rust: | "uint"
    // rust: | "float"
    // rust: | "double"
    // rust: | "bool"
    // rust: | "vec2"
    // rust: | "vec3"
    // rust: | "vec4"
    // rust: | "ivec2"
    // rust: | "ivec3"
    // rust: | "ivec4"
    // rust: | "uvec2"
    // rust: | "uvec3"
    // rust: | "uvec4"
    // rust: ) {
    // rust: types.entry(pair[1]).or_default().insert(pair[0]);
}
}
    // A pack may overload clamp itself; let upstream resolve its own function.
    // rust: if types.contains_key("clamp") {
    // rust: return text.to_owned();
}
    // rust: let significant: Vec<usize> = (0..tokens.len())
    // rust: .filter(|&i| !tokens[i].trim().is_empty())
    // rust: .collect();
    // rust: let mut replacements = BTreeMap::new();
    // rust: for w in significant.windows(8) {
    // rust: let t: Vec<_> = w.iter().map(|&i| tokens[i]).collect();
    // rust: if t[0] != "clamp" || t[1] != "(" || t[3] != "," || t[5] != "," || t[7] != ")" {
    // rust: continue;
}
    // rust: let uint = |t: &str| {
    // rust: t.strip_suffix(['u', 'U'])
    // rust: .is_some_and(|n| !n.is_empty() && n.bytes().all(|b| b.is_ascii_digit()))
}
    // rust: if uint(t[4])
    // rust: && uint(t[6])
    // rust: && types
    // rust: .get(t[2])
    // rust: .is_some_and(|s| s.len() == 1 && s.contains("int"))
    // rust: {
            // GLSL promotes the signed argument to the unsigned overload. Do not
            // narrow the bounds to int, which changes negative-value behavior.
    // rust: replacements.insert(w[2], format!("uint({})", t[2]));
}
}
    // rust: tokens
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, t)| replacements.get(&i).map_or(*t, String::as_str))
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;
pub fn signed_value_promotes_without_changing_unsigned_bounds_or_lines() void {
}
    // rust: let input = "int index=3;\nuint n=clamp(index, 0u, 47u);";
    // rust: let custom =
    // rust: "uint clamp(int value,uint lo,uint hi){return lo;}int value;clamp(value,0u,47u)";
    // rust: assert_eq!(rewrite(custom), custom);
    // rust: let output = rewrite(input);
    // rust: assert!(output.contains("clamp(uint(index), 0u, 47u)"));
    // rust: assert_eq!(input.matches('\n').count(), output.matches('\n').count());
    // rust: assert_eq!(
    // rust: rewrite("float index; clamp(index,0u,47u)"),
    // rust: "float index; clamp(index,0u,47u)"
    // rust: );
    // rust: assert_eq!(
    // rust: rewrite("int index;void f(){float index;}clamp(index,0u,47u)"),
    // rust: "int index;void f(){float index;}clamp(index,0u,47u)"
    // rust: );
}
}
