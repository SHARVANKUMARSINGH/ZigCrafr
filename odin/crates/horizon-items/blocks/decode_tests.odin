//! Transpiled from Horizon Rust crate
package horizon_items_decode_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

shape_identity_and_geometry_match_the_value_loader :: proc() -> c {
    // Ported from Horizon
    return {}
}
    // rust: let inputs = [
    // rust: "[]",
    // rust: "[ ]",
    // rust: "[[0,0,0,1,1,1]]",
    // rust: "[ [0, 0, 0, 1, 1, 1] ]",
    // rust: "[[0.0,0,0,1,1,1]]",
    // rust: "[[0e0,0,0,1,1,1]]",
    // rust: "[[-0.0,0,0,1,1,1]]",
    // rust: "[[0,0,0,1,1,1,7]]",
    // rust: "[[0,0,0,1,1,1,8]]",
    // rust: "[[1,null,\"2\"],true,{}]",
    // rust: "[[1,null,\"\\u0032\"],true,{}]",
    // rust: "[{\"z\":0,\"a\":1}]",
    // rust: "[{\"a\":1,\"z\":0}]",
    // rust: "[[18446744073709551615,-9223372036854775808,1e20]]",
    // rust: "[{\"a\":2,\"a\":1,\"z\":0}]",
    // rust: ];
    // rust: let values = inputs
    // rust: .iter()
    // rust: .map(|s| serde_json::from_str::<Value>(s))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // Value equality merges signed zero; the legacy string keys do not.
    // rust: let keys: Vec<_> = values.iter().map(Value::to_string).collect();
    // rust: let mut shapes = Shapes::default();
    // rust: let actual = inputs
    // rust: .iter()
    // rust: .map(|s| {
    // rust: shapes.intern(Some(serde_json::from_str::<&RawValue>(s)?), || {
    // rust: panic!("array fallback")
    // rust: })
    // rust: })
    // rust: .collect::<crate::Result<Vec<_>>>()?;
    // rust: for (i, value) in values.iter().enumerate() {
    // rust: let expected: Vec<[f64; 6]> = value
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .filter_map(|b| {
    // rust: let b = b.as_array()?;
    // rust: Some(std::array::from_fn(|i| {
    // rust: b.get(i).and_then(Value::as_f64).unwrap_or(0.0)
    // rust: }))
    // rust: })
    // rust: .collect();
        // Bit comparisons include negative zero.
    // rust: assert_eq!(
    // rust: actual[i]
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(|v| v.to_bits())
    // rust: .collect::<Vec<_>>(),
    // rust: expected
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(|v| v.to_bits())
    // rust: .collect::<Vec<_>>()
    // rust: );
    // rust: for j in 0..values.len() {
    // rust: assert_eq!(
    // rust: Arc::ptr_eq(&actual[i], &actual[j]),
    // rust: keys[i] == keys[j],
    // rust: "{i}, {j}"
    // rust: );
}
}
    // rust: for input in ["null", "false", "7", "{}", "\"shape\""] {
    // rust: let raw = serde_json::from_str(input)?;
    // rust: let a = shapes.intern(Some(raw), || vec![[7.0; 6]])?;
    // rust: let b = shapes.intern(Some(raw), || vec![[7.0; 6]])?;
    // rust: assert_eq!(&*a, &[[7.0; 6]]);
    // rust: assert!(!Arc::ptr_eq(&a, &b)); // Fallbacks were never interned.
}
    // rust: Ok(())
}

typed_fields_keep_defaults_duplicates_and_wrong_type_behavior :: proc() -> c {
    // Ported from Horizon
    return {}
}
    // rust: let input = r#"{"states":[null,[],{"id":0,"id":2,"emission":4.5,"dampening":"15",
    // rust: "hardness":-0.0,"skylight_down":true,"offset":true,"outline_offset":"true",
    // rust: "item":42,"render_shape":false,"sound":{"volume":null,"pitch":2,"break":{"id":"a\u0062"},
    // rust: "step":false,"hit":{"id":2}},"outline":[[0,1]],"unknown":{"nested":true}}]}"#;
    // rust: let parsed: Gameplay<'_> = serde_json::from_str(input)?;
    // rust: let entries = parsed.states.0.unwrap();
    // rust: assert_eq!(entries[0].id, None);
    // rust: assert_eq!(entries[1].id, None);
    // rust: let e = &entries[2];
    // rust: assert_eq!(e.id, Some(2));
    // rust: assert_eq!(e.emission.as_f64(), Some(4.5));
    // rust: assert_eq!(e.dampening.as_f64().unwrap_or(0.0), 0.0);
    // rust: assert_eq!(e.hardness.as_f64().unwrap().to_bits(), (-0.0f64).to_bits());
    // rust: assert!(e.skylight_down && e.outline_offset.unwrap_or(e.offset));
    // rust: assert_eq!(e.item, None);
    // rust: assert_eq!(e.render_shape, None);
    // rust: assert_eq!((e.sound.volume, e.sound.pitch), (1.0, 2.0));
    // rust: assert_eq!(e.sound.r#break.id.as_deref(), Some("ab"));
    // rust: assert_eq!(e.sound.step.id, None);
    // rust: assert_eq!(e.sound.hit.id, None);
    // rust: assert_eq!(e.outline.unwrap().get(), "[[0,1]]");
    // rust: for input in ["null", "[]", "{}", r#"{"states":null}"#, r#"{"states":{}}"#] {
    // rust: let parsed: Gameplay<'_> = serde_json::from_str(input)?;
    // rust: assert!(parsed.states.0.is_none());
}
    // rust: for input in [
    // rust: r#"{"states":["#,
    // rust: r#"{"states":[{"id":1e400}]}"#,
    // rust: "{} trailing",
    // rust: r#"{"unknown":1e400}"#,
    // rust: ] {
    // rust: let before = serde_json::from_str::<Value>(input).err().unwrap();
    // rust: let after = serde_json::from_str::<Gameplay<'_>>(input).err().unwrap();
    // rust: assert_eq!(before.classify(), after.classify());
}
    // rust: Ok(())
}

raw_shape_capture_keeps_original_json_errors :: proc() {
}
    // rust: let deep = format!("{}0{}", "[".repeat(130), "]".repeat(130));
    // rust: let inputs = [
    // rust: br#"{"states":[{"outline":[[1e400]],"outline":[]}]}"#.to_vec(),
    // rust: format!("{{\"states\":[{{\"outline\":{deep}}}]}}").into_bytes(),
    // rust: br#"{"states":[{"outline":[[0]]}]} trailing"#.to_vec(),
    // rust: b"{\"states\":[{\"outline\":[[\"\xff\"]]}]}".to_vec(),
    // rust: ];
    // rust: for input in inputs {
    // rust: let old = serde_json::from_slice::<Value>(&input).err().unwrap();
    // rust: let new = serde_json::from_slice::<Validate>(&input).err().unwrap();
    // rust: assert_eq!(
    // rust: (old.classify(), old.line(), old.column()),
    // rust: (new.classify(), new.line(), new.column())
    // rust: );
}
}

the_validation_error_still_fails_the_load_first :: proc() {
}
    // The typed decode reads this shape (raw), the validation pass rejects
    // its number, and the empty behaviour document would fail the load next.
    // rust: let facts = br#"{"states":[{"id":0,"outline":[[1e400]]}]}"#;
    // rust: let expected = serde_json::from_slice::<Value>(facts)
    // rust: .unwrap_err()
    // rust: .to_string();
    // rust: let root = std::env::temp_dir().join(format!("horizon-facts-validate-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: std::fs::write(root.join("gameplay-facts.json"), facts).unwrap();
    // rust: let registry = horizon_world::registry::BlockRegistry::from_facts_json(
    // rust: &br#"{"states":[["minecraft:air",true,false,"","minecraft:air"]],"defaults":{"minecraft:air":0}}"#[..],
    // rust: )
    // rust: .unwrap();
    // rust: let expected = format!("{}: {expected}", root.join("gameplay-facts.json").display());
    // rust: for parallel in [false, true] {
    // rust: let error = super::super::BlockFacts::load_with_projection(
    // rust: &root,
    // rust: &registry,
    // rust: &Value::Null,
    // rust: parallel,
    // rust: )
    // rust: .err()
    // rust: .unwrap();
    // rust: assert_eq!(error.to_string(), expected, "parallel: {parallel}");
}
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

a_state_past_the_registry_has_airs_facts :: proc() {
}
    // rust: let registry = horizon_world::registry::BlockRegistry::from_facts_json(
    // rust: &br#"{"states":[["minecraft:air",true,false,"","minecraft:air"],["minecraft:stone",true,false,"","minecraft:stone"]],"defaults":{"minecraft:air":0,"minecraft:stone":1}}"#[..],
    // rust: )
    // rust: .unwrap();
    // rust: let root = std::env::temp_dir().join(format!("horizon-facts-unknown-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: std::fs::write(
    // rust: root.join("gameplay-facts.json"),
    // rust: br#"{"states":[{"id":0},{"id":1}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let behaviours = serde_json::json!({
    // rust: "states": [[0, 0], [0, 0]],
    // rust: "blocks": [
    // rust: {"name": "minecraft:air", "class": ["Block"]},
    // rust: {"name": "minecraft:stone", "class": ["Block"]},
    // rust: ],
    // rust: });
    // rust: let facts =
    // rust: super::super::BlockFacts::load_with_behaviour_json(&root, &registry, &behaviours).unwrap();
    // rust: std::fs::remove_dir_all(&root).unwrap();

    // rust: let id = horizon_world::registry::BlockStateId;
    // rust: assert_eq!(&*facts.get(id(1)).name, "minecraft:stone");
    // rust: assert!(!facts.is_air(id(1)));
    // rust: assert_eq!(&*facts.get(id(2)).name, "minecraft:air");
    // rust: assert!(facts.is_air(id(2)));
}
