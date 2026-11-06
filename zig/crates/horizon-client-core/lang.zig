//! Transpiled from Horizon Rust crate
//! Module: horizon-client-core_lang
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Languages (ClientLanguage / LanguageManager): `lang/<code>.json` from the
//! resource root and enabled packs layered over `en_us`, the language list
//! from `pack.mcmeta` `language` sections, and a process-wide current
//! language used by every screen.
// use std::{
    // rust: cell::RefCell,
    // rust: collections::{BTreeMap, HashMap},
    // rust: sync::{
    // rust: Arc, RwLock,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: },
}

pub const LanguageInfo = struct {
    code: []const u8,
    name: []const u8,
    region: []const u8,
    bidirectional: bool,
};
    // rust: impl LanguageInfo {
    /// LanguageInfo.toComponent: "Name (Region)".
pub fn label(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("{} ({})", self.name, self.region)
}
}
pub const Language = struct {
    code: []const u8,
    /// `LanguageInfo.bidirectional`: text without a strong character reads
    /// right to left (`ClientLanguage.defaultRightToLeft`).
    bidirectional: bool,
    map: HashMap<[]const u8,
};
pub const DEFAULT: []const u8 = "en_us";

pub const CURRENT: RwLock<?*Language> = RwLock::new(None);
/// A language that only the calling thread sees, and the keys it was asked for and did not have
/// (`scoped`).
pub const Scope = struct {
    language: *Language,
    missed: std.ArrayList([]const u8),
};
    // rust: thread_local! {
pub const SCOPE: RefCell<?Scope> = const { RefCell::new(None) };
}
/// The current language's `bidirectional`, read for every drawn string.
pub const BIDIRECTIONAL: AtomicBool = AtomicBool::new(false);

/// A source of resource files: the prepared root plus packs, highest priority last.
    // rust: pub trait ResourceSource {
pub fn read(self: *Self, path: []const u8) O;
    /// Whether `path` is there, without reading it where the source can tell.
pub fn exists(self: *Self, path: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.read(path).is_some()
}
    /// The namespaces under `assets/` (resource packs may add their own).
pub fn namespaces(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vec!["minecraft".into()]
}
}
/// Horizon's own strings, compiled in so they need no prepared resources.
pub const Bundled = struct {};
    // rust: impl ResourceSource for Bundled {
pub fn read(self: *Self, path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let body = match path {
    // rust: "assets/horizon/lang/en_us.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/en_us.json")
}
    // rust: "assets/horizon/lang/zh_cn.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/zh_cn.json")
}
    // rust: "assets/horizon/lang/ru_ru.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ru_ru.json")
}
    // rust: "assets/horizon/lang/pl_pl.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/pl_pl.json")
}
    // rust: "assets/horizon/lang/uk_ua.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/uk_ua.json")
}
    // rust: "assets/horizon/lang/hi_in.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/hi_in.json")
}
    // rust: "assets/horizon/lang/id_id.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/id_id.json")
}
    // rust: "assets/horizon/lang/tr_tr.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/tr_tr.json")
}
    // rust: "assets/horizon/lang/ko_kr.json" | "assets/horizon/lang/ko.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ko_kr.json")
}
    // rust: "assets/horizon/lang/hr_hr.json" | "assets/horizon/lang/hr.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/hr_hr.json")
}
    // rust: "assets/horizon/lang/pt_pt.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/pt_pt.json")
}
    // rust: "assets/horizon/lang/ur_pk.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ur_pk.json")
}
    // rust: "assets/horizon/lang/fa_ir.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/fa_ir.json")
}
    // rust: "assets/horizon/lang/he_il.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/he_il.json")
}
    // rust: "assets/horizon/lang/hu_hu.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/hu_hu.json")
}
    // rust: "assets/horizon/lang/ro_ro.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ro_ro.json")
}
    // rust: "assets/horizon/lang/da_dk.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/da_dk.json")
}
    // rust: "assets/horizon/lang/fi_fi.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/fi_fi.json")
}
    // rust: "assets/horizon/lang/no_no.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/no_no.json")
}
    // rust: "assets/horizon/lang/bg_bg.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/bg_bg.json")
}
    // rust: "assets/horizon/lang/sk_sk.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/sk_sk.json")
}
    // rust: "assets/horizon/lang/lt_lt.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/lt_lt.json")
}
    // rust: "assets/horizon/lang/it_it.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/it_it.json")
}
    // rust: "assets/horizon/lang/nl_nl.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/nl_nl.json")
}
    // rust: "assets/horizon/lang/vi_vn.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/vi_vn.json")
}
    // rust: "assets/horizon/lang/th_th.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/th_th.json")
}
    // rust: "assets/horizon/lang/ja_jp.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ja_jp.json")
}
    // rust: "assets/horizon/lang/ar_sa.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ar_sa.json")
}
    // rust: "assets/horizon/lang/pt_br.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/pt_br.json")
}
    // rust: "assets/horizon/lang/cs_cz.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/cs_cz.json")
}
    // rust: "assets/horizon/lang/sv_se.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/sv_se.json")
}
    // rust: "assets/horizon/lang/el_gr.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/el_gr.json")
}
    // rust: "assets/horizon/lang/ca_es.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ca_es.json")
}
    // rust: "assets/horizon/lang/et_ee.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/et_ee.json")
}
    // rust: "assets/horizon/lang/lv_lv.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/lv_lv.json")
}
    // rust: "assets/horizon/lang/sl_si.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/sl_si.json")
}
    // rust: "assets/horizon/lang/sr_cs.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/sr_cs.json")
}
    // rust: "assets/horizon/lang/is_is.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/is_is.json")
}
    // rust: "assets/horizon/lang/af_za.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/af_za.json")
}
    // rust: "assets/horizon/lang/ms_my.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ms_my.json")
}
    // rust: "assets/horizon/lang/be_by.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/be_by.json")
}
    // rust: "assets/horizon/lang/sr_sp.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/sr_sp.json")
}
    // rust: "assets/horizon/lang/az_az.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/az_az.json")
}
    // rust: "assets/horizon/lang/uz_uz.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/uz_uz.json")
}
    // rust: "assets/horizon/lang/kk_kz.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/kk_kz.json")
}
    // rust: "assets/horizon/lang/ka_ge.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ka_ge.json")
}
    // rust: "assets/horizon/lang/hy_am.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/hy_am.json")
}
    // rust: "assets/horizon/lang/bs_ba.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/bs_ba.json")
}
    // rust: "assets/horizon/lang/mk_mk.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/mk_mk.json")
}
    // rust: "assets/horizon/lang/sq_al.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/sq_al.json")
}
    // rust: "assets/horizon/lang/cy_gb.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/cy_gb.json")
}
    // rust: "assets/horizon/lang/ga_ie.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ga_ie.json")
}
    // rust: "assets/horizon/lang/eu_es.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/eu_es.json")
}
    // rust: "assets/horizon/lang/gl_es.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/gl_es.json")
}
    // rust: "assets/horizon/lang/fil_ph.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/fil_ph.json")
}
    // rust: "assets/horizon/lang/ta_in.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ta_in.json")
}
    // rust: "assets/horizon/lang/mn_mn.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/mn_mn.json")
}
    // rust: "assets/horizon/lang/lo_la.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/lo_la.json")
}
    // rust: "assets/horizon/lang/so_so.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/so_so.json")
}
    // rust: "assets/horizon/lang/fy_nl.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/fy_nl.json")
}
    // rust: "assets/horizon/lang/gd_gb.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/gd_gb.json")
}
    // rust: "assets/horizon/lang/lb_lu.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/lb_lu.json")
}
    // rust: "assets/horizon/lang/ky_kg.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ky_kg.json")
}
    // rust: "assets/horizon/lang/kn_in.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/kn_in.json")
}
    // rust: "assets/horizon/lang/mt_mt.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/mt_mt.json")
}
    // rust: "assets/horizon/lang/eo_uy.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/eo_uy.json")
}
    // rust: "assets/horizon/lang/haw_us.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/haw_us.json")
}
    // rust: "assets/horizon/lang/ig_ng.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ig_ng.json")
}
    // rust: "assets/horizon/lang/la_la.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/la_la.json")
}
    // rust: "assets/horizon/lang/tt_ru.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/tt_ru.json")
}
    // rust: "assets/horizon/lang/yi_de.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/yi_de.json")
}
    // rust: "assets/horizon/lang/yo_ng.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/yo_ng.json")
}
    // rust: "assets/horizon/lang/ba_ru.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/ba_ru.json")
}
    // rust: "assets/horizon/lang/br_fr.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/br_fr.json")
}
    // rust: "assets/horizon/lang/cv_cu.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/cv_cu.json")
}
    // rust: "assets/horizon/lang/fo_fo.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/fo_fo.json")
}
    // rust: "assets/horizon/lang/fur_it.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/fur_it.json")
}
    // rust: "assets/horizon/lang/li_li.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/li_li.json")
}
    // rust: "assets/horizon/lang/lmo.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/lmo.json")
}
    // rust: "assets/horizon/lang/oc_fr.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/oc_fr.json")
}
    // rust: "assets/horizon/lang/sah_sah.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/sah_sah.json")
}
    // rust: "assets/horizon/lang/se_no.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/se_no.json")
}
    // rust: "assets/horizon/lang/szl.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/szl.json")
}
    // rust: "assets/horizon/lang/vec_it.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/vec_it.json")
}
    // rust: "assets/horizon/lang/de_de.json" | "assets/horizon/lang/de_at.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/de_de.json")
}
            // Swiss German writes "ss" for "ß", as vanilla's de_ch does.
    // rust: "assets/horizon/lang/de_ch.json" => {
    // rust: let de = include_str!("../../horizon-client/assets/horizon/lang/de_de.json");
    // rust: return Some(de.replace('ß', "ss").into_bytes());
}
    // rust: "assets/horizon/lang/fr_fr.json"
    // rust: | "assets/horizon/lang/fr_ca.json"
    // rust: | "assets/horizon/lang/fr_ch.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/fr_fr.json")
}
    // rust: "assets/horizon/lang/es_es.json"
    // rust: | "assets/horizon/lang/es_ar.json"
    // rust: | "assets/horizon/lang/es_cl.json"
    // rust: | "assets/horizon/lang/es_ec.json"
    // rust: | "assets/horizon/lang/es_mx.json"
    // rust: | "assets/horizon/lang/es_uy.json"
    // rust: | "assets/horizon/lang/es_ve.json" => {
    // rust: include_str!("../../horizon-client/assets/horizon/lang/es_es.json")
}
    // rust: _ => return None,
}
    // rust: Some(body.as_bytes().to_vec())
}
pub fn namespaces(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vec!["horizon".into()]
}
}
    // rust: impl ResourceSource for std::path::PathBuf {
pub fn read(self: *Self, path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::read(self.join(path)).ok()
}
pub fn exists(self: *Self, path: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.join(path).is_file()
}
pub fn namespaces(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::read_dir(self.join("assets"))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter(|e| e.path().is_dir())
    // rust: .filter_map(|e| e.file_name().to_str().map(str::to_owned))
    // rust: .collect()
}
}

/// DeprecatedTranslationsInfo.applyToMap: drop removed keys, then move each
/// renamed key's text to its new key (a missing old key removes the new one).
pub fn apply_deprecated(map: *mut HashMap<[]const u8, json: []const u8) void {
}
    // rust: let Ok(info) = serde_json::from_slice::<serde_json::Value>(json) else {
    // rust: return;
}
    // rust: for key in info["removed"].as_array().into_iter().flatten() {
    // rust: if let Some(k) = key.as_str() {
    // rust: map.remove(k);
}
}
    // rust: for (from, to) in info["renamed"].as_object().into_iter().flatten() {
    // rust: let Some(to) = to.as_str() else { continue };
    // rust: match map.remove(from) {
    // rust: Some(value) => {
    // rust: map.insert(to.to_owned(), value);
}
    // rust: None => {
    // rust: map.remove(to);
}
}
}
}

/// `Language.loadFromJson` for one `lang/<code>.json`: its entries go into `map` in file order.
/// A file that is plain JSON reads as before; any other goes through Gson's lenient reader
/// (`#`, `//` and `/* */` comments, unquoted or single-quoted names and values, raw control
/// characters in strings, `=` or `=>` and `;`), which vanilla reads lang files with (expected
/// from `Language.loadFromJson`, Gson). A file that is not JSON even so adds nothing; a value
/// that is not a string, number or boolean (`GsonHelper.convertToString`) ends the file there.
pub fn read_lang_file(bytes: []const u8, map: *mut HashMap<[]const u8) void {
}
//     use horizon_world::datafix::json::{Json, parse_lenient};
    // rust: if let Ok(entries) = serde_json::from_slice::<HashMap<String, String>>(bytes) {
    // rust: map.extend(entries);
    // rust: return;
}
    // rust: let text = String::from_utf8_lossy(bytes);
    // Gson's JsonReader skips a leading byte order mark.
    // rust: let text = text.strip_prefix('\u{feff}').unwrap_or(&text);
    // rust: let utf16: Vec<u16> = text.encode_utf16().collect();
    // rust: let Some(Json::Obj(entries)) = parse_lenient(&utf16) else {
    // rust: return;
}
    // rust: for (key, value) in entries {
    // rust: let value = match value {
    // rust: Json::Str(s) => String::from_utf16_lossy(&s),
    // rust: Json::Num(n) => n,
    // rust: Json::Bool(b) => b.to_string(),
    // rust: Json::Null | Json::Arr(_) | Json::Obj(_) => break,
}
    // rust: map.insert(String::from_utf16_lossy(&key), value);
}
}

    // rust: impl Language {
    /// ClientLanguage.loadFrom: en_us first, then the selected language, each
    /// from every namespace and every source in priority order (later sources
    /// override).
pub fn load(sources: *[*dyn ResourceSource], code: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut map = HashMap::new();
    // rust: let mut codes = vec![DEFAULT];
    // rust: if code != DEFAULT {
    // rust: codes.push(code);
}
        // Horizon's own strings first, so a pack or the prepared root can still
        // override them. Vanilla has no key for "Controller vibration".
    // rust: let bundled = Bundled;
    // rust: let mut all: Vec<&dyn ResourceSource> = vec![&bundled];
    // rust: all.extend_from_slice(sources);
    // rust: let sources = all.as_slice();
    // rust: let namespaces: std::collections::BTreeSet<String> =
    // rust: sources.iter().flat_map(|s| s.namespaces()).collect();
    // rust: for c in codes {
    // rust: for namespace in &namespaces {
    // rust: for source in sources {
    // rust: let Some(bytes) = source.read(&format!("assets/{namespace}/lang/{c}.json"))
    // rust: else {
    // rust: continue;
}
    // rust: read_lang_file(&bytes, &mut map);
}
}
}
        // DeprecatedTranslationsInfo.loadFromDefaultResource().applyToMap: the
        // game's own deprecated.json, not a resource pack's.
    // rust: if let Some(bytes) = sources
    // rust: .iter()
    // rust: .find_map(|s| s.read("assets/minecraft/lang/deprecated.json"))
    // rust: {
    // rust: apply_deprecated(&mut map, &bytes);
}
    // rust: let bidirectional = available(sources)
    // rust: .iter()
    // rust: .any(|info| info.code == code && info.bidirectional);
    // rust: Self {
    // rust: code: code.to_owned(),
    // rust: bidirectional,
    // rust: map,
}
}
pub fn get(self: *Self, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.get(key).map(String::as_str)
}
    /// The resolved map, for `horizon_protocol::text::plain`: a server's
    /// components carry keys, and the network layer resolves them with this.
pub fn map(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.map
}
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.len()
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.is_empty()
}
}

/// Languages declared by `pack.mcmeta` files (the vanilla asset root first).
pub fn available(sources: *[*dyn ResourceSource]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut found: BTreeMap<String, LanguageInfo> = BTreeMap::new();
    // rust: found.insert(
    // rust: DEFAULT.into(),
    // rust: LanguageInfo {
    // rust: code: DEFAULT.into(),
    // rust: name: "English".into(),
    // rust: region: "US".into(),
    // rust: bidirectional: false,
    // rust: },
    // rust: );
    // rust: for source in sources {
    // rust: for path in ["assets/pack.mcmeta", "pack.mcmeta"] {
    // rust: let Some(bytes) = source.read(path) else {
    // rust: continue;
}
    // rust: let Ok(value) = serde_json::from_slice::<serde_json::Value>(&bytes) else {
    // rust: continue;
}
    // rust: for (code, info) in value["language"].as_object().into_iter().flatten() {
                // Only languages whose file exists somewhere are selectable.
    // rust: let file = format!("assets/minecraft/lang/{code}.json");
    // rust: if code != DEFAULT && !sources.iter().any(|s| s.exists(&file)) {
    // rust: continue;
}
    // rust: found.insert(
    // rust: code.clone(),
    // rust: LanguageInfo {
    // rust: code: code.clone(),
    // rust: name: info["name"].as_str().unwrap_or(code).to_owned(),
    // rust: region: info["region"].as_str().unwrap_or("").to_owned(),
    // rust: bidirectional: info["bidirectional"].as_bool().unwrap_or(false),
    // rust: },
    // rust: );
}
}
}
    // rust: found.into_values().collect()
}

pub fn set(language: Language) void {
}
    // rust: BIDIRECTIONAL.store(language.bidirectional, Ordering::Relaxed);
    // rust: *CURRENT.write().unwrap_or_else(|e| e.into_inner()) = Some(Arc::new(language));
}
pub fn current() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(language) = SCOPE.with(|s| s.borrow().as_ref().map(|s| s.language.clone())) {
    // rust: return Some(language);
}
    // rust: CURRENT.read().unwrap_or_else(|e| e.into_inner()).clone()
}
/// Runs `f` with `language` as the current language of this thread only, and returns what it
/// returned with the keys `get` and `get_or` looked up and `language` did not have, in the order
/// asked and without repeats. Nothing is set process-wide, so a test can draw a screen in another
/// language while the tests beside it read theirs. Scopes nest: the inner one wins, and the outer
/// one's misses do not include the inner one's. For tests: `bidirectional` stays the process-wide
/// language's.
    // rust: pub fn scoped<R>(language: Language, f: impl FnOnce() -> R) -> (R, Vec<String>) {
    /// Puts the outer scope back, also when `f` panics.
pub const Restore = struct {};
    // rust: impl Drop for Restore {
pub fn drop(self: *Self) void {
}
    // rust: SCOPE.with(|s| *s.borrow_mut() = self.0.take());
}
}
    // rust: let outer = SCOPE.with(|s| {
    // rust: s.borrow_mut().replace(Scope {
    // rust: language: Arc::new(language),
    // rust: missed: Vec::new(),
    // rust: })
    // rust: });
    // rust: let _restore = Restore(outer);
    // rust: let result = f();
    // rust: let missed = SCOPE.with(|s| {
    // rust: s.borrow_mut()
    // rust: .as_mut()
    // rust: .map(|s| std::mem::take(&mut s.missed))
    // rust: });
    // rust: (result, missed.unwrap_or_default())
}
/// `key` was asked for in a `scoped` language that has no text for it.
pub fn missed(key: []const u8) void {
}
    // rust: SCOPE.with(|s| {
    // rust: if let Some(scope) = s.borrow_mut().as_mut()
    // rust: && !scope.missed.iter().any(|m| m == key)
    // rust: {
    // rust: scope.missed.push(key.to_owned());
}
    // rust: });
}
/// `ClientLanguage.defaultRightToLeft` of the current language.
pub fn bidirectional() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BIDIRECTIONAL.load(Ordering::Relaxed)
}
pub fn code() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: current().map_or_else(|| DEFAULT.to_owned(), |l| l.code.clone())
}
/// Language.getOrDefault: the translation, or the key itself.
pub fn get(key: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: current()
    // rust: .and_then(|l| l.get(key).map(str::to_owned))
    // rust: .unwrap_or_else(|| {
    // rust: missed(key);
    // rust: key.to_owned()
    // rust: })
}
/// The translation, or `fallback` when the key is missing.
pub fn get_or(key: []const u8, fallback: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: current()
    // rust: .and_then(|l| l.get(key).map(str::to_owned))
    // rust: .unwrap_or_else(|| {
    // rust: missed(key);
    // rust: fallback.to_owned()
    // rust: })
}
pub fn has(key: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: current().is_some_and(|l| l.get(key).is_some())
}
/// I18n.get with plain string arguments.
pub fn tr(key: []const u8, args: *[*dyn std::fmt::Display]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::text::Text::tr(key, args).plain()
}

    // rust: mod tests {
//     use super::*;
pub const Mem = struct {};
    // rust: impl ResourceSource for Mem {
pub fn read(self: *Self, path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.get(path).cloned()
}
}
pub fn bundled_horizon_strings_follow_the_language() void {
}
        // No prepared resources at all: the namespace is compiled in.
    // rust: let empty = Mem(HashMap::new());
    // rust: let en = Language::load(&[&empty], "en_us");
    // rust: assert_eq!(en.get("horizon.options.controller"), Some("Controller"));
    // rust: let ru = Language::load(&[&empty], "ru_ru");
    // rust: assert_eq!(ru.get("horizon.options.controller"), Some("Геймпад"));
        // Every bundled string carries both languages: a key added to one file
        // and forgotten in the other shows as a key name on screen.
    // rust: for key in en.map().keys() {
    // rust: assert!(ru.get(key).is_some(), "{key} has no ru_ru value");
}
    // rust: assert_eq!(en.get("horizon.pages.mods"), Some("Mods"));
    // rust: assert_eq!(ru.get("horizon.pages.mods"), Some("Моды"));
    // rust: let zh = Language::load(&[&empty], "zh_cn");
    // rust: assert_eq!(zh.get("horizon.options.controller"), Some("手柄"));
    // rust: assert_eq!(zh.get("horizon.pages.mods"), Some("模组"));
    // rust: assert_eq!(zh.get("Preset"), Some("预设"));
    // rust: assert_eq!(zh.get("%s chunks"), Some("%s 个区块"));
        // Not every bundle is complete: the en_us layer is in every map, so a
        // missing key falls back to English (`horizon.mods.not_built` is not
        // in ru_ru either).
    // rust: assert_eq!(zh.get("LOD Distance"), Some("LOD 距离"));
    // rust: assert_eq!(ru.get("horizon.mods.not_built"), Some(" (Not built)"));
    // rust: let pl = Language::load(&[&empty], "pl_pl");
    // rust: assert_eq!(pl.get("horizon.options.controller"), Some("Kontroler"));
    // rust: assert_eq!(pl.get("horizon.options.vibration"), Some("Wibracje"));
    // rust: let uk = Language::load(&[&empty], "uk_ua");
    // rust: assert_eq!(
    // rust: uk.get("horizon.options.on_screen_keyboard"),
    // rust: Some("Екранна клавіатура")
    // rust: );
    // rust: let tr = Language::load(&[&empty], "tr_tr");
    // rust: assert_eq!(tr.get("horizon.options.controller"), Some("Kontrolcü"));
    // rust: let es = Language::load(&[&empty], "es_es");
    // rust: assert_eq!(es.get("horizon.options.controller"), Some("Mando"));
        // German and French, and their regional variants on the same file
        // (Swiss German without "ß").
    // rust: let de = Language::load(&[&empty], "de_de");
    // rust: assert_eq!(de.get("horizon.osk.close"), Some("Schließen"));
    // rust: let fr = Language::load(&[&empty], "fr_fr");
    // rust: assert_eq!(fr.get("horizon.osk.close"), Some("Fermer"));
    // rust: for (code, base) in [("de_at", &de), ("fr_ca", &fr), ("fr_ch", &fr)] {
    // rust: let variant = Language::load(&[&empty], code);
    // rust: assert_eq!(variant.map(), base.map(), "{code}");
}
    // rust: let de_ch = Language::load(&[&empty], "de_ch");
    // rust: assert_eq!(de_ch.get("horizon.osk.close"), Some("Schliessen"));
    // rust: assert!(de_ch.map().values().all(|v| !v.contains('ß')));
    // rust: assert_eq!(de_ch.len(), de.len());
    // rust: let es_ve = Language::load(&[&empty], "es_ve");
    // rust: assert_eq!(
    // rust: es_ve.get("horizon.options.on_screen_keyboard"),
    // rust: Some("Teclado en pantalla")
    // rust: );
}

pub fn a_scoped_language_is_the_calling_threads_and_reports_what_it_lacks() void {
}
    // rust: let empty = Mem(HashMap::new());
    // rust: let outside = code();
    // rust: let ((german, english_only, fallback, elsewhere), missed) =
    // rust: scoped(Language::load(&[&empty], "de_de"), || {
    // rust: (
    // rust: get("horizon.osk.close"),
    // rust: get("horizon.no_such_key"),
    // rust: get_or("horizon.no_fallback", "English"),
                    // Another thread keeps the process-wide language.
    // rust: std::thread::spawn(code).join().unwrap(),
    // rust: )
    // rust: });
    // rust: assert_eq!(german, "Schließen");
    // rust: assert_eq!(english_only, "horizon.no_such_key");
    // rust: assert_eq!(fallback, "English");
    // rust: assert_eq!(elsewhere, outside);
    // rust: assert_eq!(missed, ["horizon.no_such_key", "horizon.no_fallback"]);
        // The scope ends with its closure.
    // rust: assert_eq!(code(), outside);
}

pub fn scopes_nest_and_end_when_their_closure_panics() void {
}
    // rust: let empty = Mem(HashMap::new());
    // rust: let outside = code();
    // rust: let (inner, missed) = scoped(Language::load(&[&empty], "fr_fr"), || {
    // rust: let (inner, inner_missed) = scoped(Language::load(&[&empty], "pl_pl"), || {
    // rust: (code(), get("horizon.inner_miss"))
    // rust: });
    // rust: assert_eq!(inner_missed, ["horizon.inner_miss"]);
    // rust: assert_eq!(code(), "fr_fr");
    // rust: inner.0
    // rust: });
    // rust: assert_eq!(inner, "pl_pl");
    // rust: assert!(missed.is_empty());
    // rust: let panicked = std::panic::catch_unwind(|| {
    // rust: scoped(Language::load(&[&Mem(HashMap::new())], "de_de"), || {
    // rust: panic!("a test failed inside a scope")
    // rust: })
    // rust: });
    // rust: assert!(panicked.is_err());
    // rust: assert_eq!(code(), outside);
}

    /// `crates/horizon-client/assets/horizon/lang`, where Horizon's own strings live.
pub fn bundled_dir() s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../horizon-client/assets/horizon/lang")
}
    /// The keys of a flat bundled file in file order, duplicates included (a map
    /// would keep only the last of two equal keys). One `"key": "value"` per line.
pub fn file_keys(body: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: body.lines()
    // rust: .filter(|line| line.starts_with("  \""))
    // rust: .map(|line| {
    // rust: serde_json::Deserializer::from_str(line.trim_start())
    // rust: .into_iter::<String>()
    // rust: .next()
    // rust: .and_then(Result::ok)
    // rust: .unwrap_or_else(|| panic!("no key on line {line}"))
    // rust: })
    // rust: .collect()
}
    /// The fields the code fills in (`%s`, `%d`, `%1$s`, `%.2f`, `%%`), sorted. A
    /// percent sign that starts none of them ("100% is") is plain text.
pub fn placeholders(text: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut found = Vec::new();
    // rust: let mut rest = text;
    // rust: while let Some(at) = rest.find('%') {
    // rust: rest = &rest[at + 1..];
    // rust: let spec = rest
    // rust: .find(|c: char| !(c.is_ascii_digit() || c == '$' || c == '.'))
    // rust: .unwrap_or(rest.len());
    // rust: let after = rest[spec..].chars().next();
    // rust: if after.is_some_and(|c| matches!(c, 's' | 'd' | 'f' | '%')) {
    // rust: let end = spec + 1;
    // rust: found.push(format!("%{}", &rest[..end]));
    // rust: rest = &rest[end..];
}
}
    // rust: found.sort();
    // rust: found
}

pub fn bundled_files_are_served_and_have_no_stale_or_repeated_keys() void {
}
    // rust: let dir = bundled_dir();
    // rust: let en_body = std::fs::read_to_string(dir.join("en_us.json")).unwrap();
    // rust: let en: HashMap<String, String> = serde_json::from_str(&en_body).unwrap();
    // rust: let mut seen = 0;
    // rust: for entry in std::fs::read_dir(&dir).unwrap().flatten() {
    // rust: let name = entry.file_name().into_string().unwrap();
    // rust: let Some(code) = name.strip_suffix(".json") else {
    // rust: continue;
}
    // rust: seen += 1;
            // A file that Bundled::read does not name is never loaded.
    // rust: let path = format!("assets/horizon/lang/{name}");
    // rust: assert!(
    // rust: Bundled.read(&path).is_some(),
    // rust: "{name} is not served by Bundled"
    // rust: );
    // rust: let body = std::fs::read_to_string(entry.path()).unwrap();
    // rust: let map: HashMap<String, String> = serde_json::from_str(&body)
    // rust: .unwrap_or_else(|e| panic!("{name} is not a flat string map: {e}"));
    // rust: let keys = file_keys(&body);
    // rust: assert_eq!(
    // rust: keys.len(),
    // rust: map.len(),
    // rust: "{name} repeats a key or has a multi-line entry"
    // rust: );
    // rust: for (key, value) in &map {
                // Stale: the code no longer asks for it, or it was renamed in en_us only.
    // rust: let english = en
    // rust: .get(key)
    // rust: .unwrap_or_else(|| panic!("{code}: {key} is not in en_us.json"));
                // A translation keeps the fields the code fills in.
    // rust: assert_eq!(
    // rust: placeholders(value),
    // rust: placeholders(english),
    // rust: "{code}: {key} changes the placeholders of the English text"
    // rust: );
    // rust: assert!(!value.trim().is_empty(), "{code}: {key} is empty");
}
}
    // rust: assert!(
    // rust: seen >= 7,
    // rust: "found {seen} bundled lang files in {}",
    // rust: dir.display()
    // rust: );
}

pub fn every_horizon_key_the_code_names_is_in_en_us() void {
}
pub fn rust_files(dir: *std::path::Path, out: *mut std.ArrayList(std::path::PathBuf)) void {
}
    // rust: for entry in std::fs::read_dir(dir).into_iter().flatten().flatten() {
    // rust: let path = entry.path();
    // rust: if path.is_dir() {
    // rust: rust_files(&path, out);
    // rust: } else if path.extension().is_some_and(|e| e == "rs") {
    // rust: out.push(path);
}
}
}
    // rust: let en: HashMap<String, String> = serde_json::from_str(
    // rust: &std::fs::read_to_string(bundled_dir().join("en_us.json")).unwrap(),
    // rust: )
    // rust: .unwrap();
    // rust: let crates = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("..");
    // rust: let mut files = Vec::new();
    // rust: for krate in [
    // rust: "horizon-client",
    // rust: "horizon-client-render",
    // rust: "horizon-client-core",
    // rust: ] {
    // rust: rust_files(&crates.join(krate).join("src"), &mut files);
}
    // rust: assert!(files.len() > 100, "found only {} sources", files.len());
    // rust: let mut found = 0;
    // rust: for file in files {
    // rust: let text = std::fs::read_to_string(&file).unwrap();
    // rust: for (at, _) in text.match_indices("\"horizon.") {
    // rust: let rest = &text[at + 1..];
    // rust: let Some(end) = rest.find('"') else { continue };
    // rust: let key = &rest[..end];
                // A key is `horizon.<group>.<name>`: lower-case letters, digits and `_`
                // between the dots. A key built at run time has a brace; a file name
                // has one dot; the server addresses that look like keys are listed.
pub const NOT_KEYS: *[[]const u8] = &["horizon.bunchy7s.dev"];
    // rust: let key_like = key
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b"_.".contains(&b));
    // rust: if key.matches('.').count() < 2 || !key_like || NOT_KEYS.contains(&key) {
    // rust: continue;
}
    // rust: found += 1;
    // rust: assert!(
    // rust: en.contains_key(key),
    // rust: "{} names {key}, which is not in en_us.json",
    // rust: file.display()
    // rust: );
}
}
    // rust: assert!(found > 50, "found only {found} key names");
}

pub fn layers_selected_language_over_english() void {
}
    // rust: let base = Mem(HashMap::from([
    // rust: ("assets/minecraft/lang/en_us.json".into(), br#"{"a":"Apple","b":"Banana"}"#.to_vec()),
    // rust: ("assets/minecraft/lang/fr_fr.json".into(), br#"{"a":"Pomme"}"#.to_vec()),
    // rust: ("assets/pack.mcmeta".into(), r#"{"language":{"fr_fr":{"name":"Français","region":"France"},"de_de":{"name":"Deutsch","region":"Deutschland"}}}"#.as_bytes().to_vec()),
    // rust: ]));
    // rust: let pack = Mem(HashMap::from([(
    // rust: "assets/minecraft/lang/fr_fr.json".into(),
    // rust: br#"{"b":"Banane"}"#.to_vec(),
    // rust: )]));
    // rust: let sources: [&dyn ResourceSource; 2] = [&base, &pack];
    // rust: let fr = Language::load(&sources, "fr_fr");
    // rust: assert_eq!(fr.get("a"), Some("Pomme"));
    // rust: assert_eq!(fr.get("b"), Some("Banane"));
    // rust: let langs = available(&sources);
        // de_de has no file, so only English and French are offered.
    // rust: assert_eq!(
    // rust: langs.iter().map(|l| l.code.as_str()).collect::<Vec<_>>(),
    // rust: ["en_us", "fr_fr"]
    // rust: );
    // rust: assert_eq!(langs[1].label(), "Français (France)");
}

pub fn languages_are_listed_without_reading_their_files() void {
}
pub const NoLangReads = struct {};
    // rust: impl ResourceSource for NoLangReads {
pub fn read(self: *Self, path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: assert!(!path.contains("/lang/"), "read {path}");
    // rust: (path == "assets/pack.mcmeta").then(|| {
    // rust: br#"{"language":{"fr_fr":{"name":"French"},"de_de":{"name":"German"}}}"#
    // rust: .to_vec()
    // rust: })
}
pub fn exists(self: *Self, path: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: path == "assets/minecraft/lang/fr_fr.json"
}
}
    // rust: let langs = available(&[&NoLangReads]);
    // rust: assert_eq!(
    // rust: langs.iter().map(|l| l.code.as_str()).collect::<Vec<_>>(),
    // rust: ["en_us", "fr_fr"]
    // rust: );
}

pub fn read(body: []const u8) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut map = HashMap::new();
    // rust: read_lang_file(body.as_bytes(), &mut map);
    // rust: map
}
pub fn entries(pairs: *[([]const u8) void {
}
    // rust: pairs
    // rust: .iter()
    // rust: .map(|(k, v)| ((*k).to_owned(), (*v).to_owned()))
    // rust: .collect()
}

pub fn a_plain_json_lang_file_reads_as_before() void {
}
    // rust: let body = "{\"a\": \"Apple \\\"quoted\\\" \\u00e9\", \"b\": \"\", \"a\": \"Again\"}";
    // rust: let strict: HashMap<String, String> = serde_json::from_str(body).unwrap();
    // rust: assert_eq!(read(body), strict);
    // rust: assert_eq!(read(body), entries(&[("a", "Again"), ("b", "")]));
}

pub fn lang_files_read_with_comments() void {
}
    // rust: let want = entries(&[("a", "Apple"), ("b", "Banana # not a comment // either")]);
    // rust: for body in [
    // rust: "# header\n{\n# a comment\n\"a\": \"Apple\",\n\"b\": \"Banana # not a comment // either\"\n}\n",
    // rust: "// header\n{\"a\": \"Apple\", // after\n\"b\": \"Banana # not a comment // either\"}",
    // rust: "/* header\n over lines */{\"a\": /* inline */ \"Apple\", \"b\": \"Banana # not a comment // either\"}",
    // rust: ] {
    // rust: assert_eq!(read(body), want, "{body}");
}
}

pub fn lang_files_read_unquoted_and_single_quoted_names_and_values() void {
}
    // rust: assert_eq!(
    // rust: read("{a: 'Apple', 'b': \"Banana\", c: Cherry}"),
    // rust: entries(&[("a", "Apple"), ("b", "Banana"), ("c", "Cherry")])
    // rust: );
        // A single-quoted string may hold a double quote, and the reverse.
    // rust: assert_eq!(
    // rust: read("{'a': 'say \"hi\"', \"b\": \"it's\"}"),
    // rust: entries(&[("a", "say \"hi\""), ("b", "it's")])
    // rust: );
}

pub fn lang_files_read_raw_control_characters_in_strings() void {
}
    // rust: assert_eq!(
    // rust: read("{\"a\": \"tab\there\", \"b\": \"two\nlines\"}"),
    // rust: entries(&[("a", "tab\there"), ("b", "two\nlines")])
    // rust: );
}

pub fn lang_files_read_gson_separators_and_a_byte_order_mark() void {
}
    // rust: assert_eq!(
    // rust: read("\u{feff}{\"a\" = \"Apple\"; \"b\" => \"Banana\"}"),
    // rust: entries(&[("a", "Apple"), ("b", "Banana")])
    // rust: );
        // A trailing comma before `}` is not JSON even to Gson's lenient reader.
    // rust: assert_eq!(read("{# c\n\"a\": \"Apple\",}"), HashMap::new());
}

pub fn numbers_and_booleans_read_as_their_text() void {
}
        // GsonHelper.convertToString: a primitive reads as its text.
    // rust: assert_eq!(
    // rust: read("{\"a\": 1.50, \"b\": true, \"c\": -2e3}"),
    // rust: entries(&[("a", "1.50"), ("b", "true"), ("c", "-2e3")])
    // rust: );
}

pub fn a_value_that_is_no_text_ends_the_file_there() void {
}
    // rust: assert_eq!(
    // rust: read("# c\n{\"a\": \"Apple\", \"b\": [\"x\"], \"c\": \"Cherry\"}"),
    // rust: entries(&[("a", "Apple")])
    // rust: );
    // rust: assert_eq!(read("{\"a\": null, \"b\": \"Banana\"}"), HashMap::new());
}

pub fn a_lang_file_that_is_not_json_adds_nothing() void {
}
    // rust: for body in [
    // rust: "# c\n{\"a\": \"Apple\"",
    // rust: "[\"a\"]",
    // rust: "\"a\"",
    // rust: "",
    // rust: "{\"a\": \"Apple\"} {",
    // rust: ] {
    // rust: assert_eq!(read(body), HashMap::new(), "{body:?}");
}
}

pub fn a_pack_lang_file_with_comments_layers_over_english() void {
}
    // rust: let base = Mem(HashMap::from([(
    // rust: "assets/minecraft/lang/en_us.json".into(),
    // rust: br#"{"a":"Apple","b":"Banana"}"#.to_vec(),
    // rust: )]));
    // rust: let pack = Mem(HashMap::from([(
    // rust: "assets/minecraft/lang/fr_fr.json".into(),
    // rust: b"{\n# Fruits\n\"a\": \"Pomme\"\n}\n".to_vec(),
    // rust: )]));
    // rust: let sources: [&dyn ResourceSource; 2] = [&base, &pack];
    // rust: let fr = Language::load(&sources, "fr_fr");
    // rust: assert_eq!(fr.get("a"), Some("Pomme"));
    // rust: assert_eq!(fr.get("b"), Some("Banana"));
}

    /// Every lang file of a downloaded pack, e.g. BACAP Language Pack:
    /// `HORIZON_LANG_PACK_DIR=<pack>/assets/minecraft/lang cargo test -p horizon-client-core
    /// lang::tests::every_lang_file_of_a_pack_reads -- --ignored --nocapture`.
pub fn every_lang_file_of_a_pack_reads() void {
}
    // rust: let Ok(dir) = std::env::var("HORIZON_LANG_PACK_DIR") else {
    // rust: return;
}
    // rust: let mut failed = Vec::new();
    // rust: let mut paths: Vec<_> = std::fs::read_dir(dir)
    // rust: .unwrap()
    // rust: .map(|e| e.unwrap().path())
    // rust: .collect();
    // rust: paths.sort();
    // rust: for path in paths {
    // rust: let bytes = std::fs::read(&path).unwrap();
    // rust: let strict = serde_json::from_slice::<HashMap<String, String>>(&bytes).is_ok();
    // rust: let mut map = HashMap::new();
    // rust: read_lang_file(&bytes, &mut map);
            // An independent count: the distinct `"name":` that start a line.
    // rust: let text = String::from_utf8_lossy(&bytes);
    // rust: let names: std::collections::HashSet<&str> = text
    // rust: .lines()
    // rust: .filter_map(|line| {
    // rust: let rest = line.trim_start().strip_prefix('"')?;
    // rust: let mut escaped = false;
    // rust: let end = rest.char_indices().find_map(|(i, c)| {
    // rust: let close = c == '"' && !escaped;
    // rust: escaped = c == '\\' && !escaped;
    // rust: close.then_some(i)
    // rust: })?;
    // rust: rest[end + 1..]
    // rust: .trim_start()
    // rust: .starts_with(':')
    // rust: .then(|| &rest[..end])
    // rust: })
    // rust: .collect();
    // rust: println!(
    // rust: "{}: strict {strict}, {} keys, {} names",
    // rust: path.display(),
    // rust: map.len(),
    // rust: names.len()
    // rust: );
    // rust: if map.is_empty() || map.len() != names.len() {
    // rust: failed.push(path);
}
}
    // rust: assert!(failed.is_empty(), "{failed:?}");
}
}
