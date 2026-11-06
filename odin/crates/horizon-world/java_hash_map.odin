//! Transpiled from Horizon Rust crate
package horizon_world_java_hash_map

import "core:fmt"
import "core:mem"
import "core:math"

// Java HashMap traversal for non-null keys with pure hash/equality/order
// operations. Tree bins preserve native linked iteration order.
// This is the storage/iterator subset needed by simulation callback lifecycles.
// use std::{cmp::Ordering, sync::Arc};
    // rust: pub trait JavaKey: Eq {
java_hash :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // Comparable comparison when both keys have the appropriate same Java
    // class. None and Equal both require subtree searches for unequal keys.
comparable_compare :: proc(self: ^Self, _other: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // Native class-name ordering, then identity-hash ordering. Equal identity
    // hashes break to Less, even for two different objects. Never return Equal.
tie_break :: proc(self: ^Self, other: ^Self) -> O {
    // Ported from Horizon
    return {}
}
}
    // rust: type Link = Option<usize>;
Node :: struct {
    key: K,
    value: V,
    hash: i32,
    next: Link,
    prev: Link,
    parent: Link,
    left: Link,
    right: Link,
    red: bool,
    tree: bool,
}
JavaHashMap :: struct {
    table: [dynamic]Link,
    nodes: Vec<Option<Node<K,
    free: [dynamic]uint,
    size: uint,
    threshold: uint,
    modification: u32,
    owner: ^(),
}
Cursor :: struct {
    next: Link,
    current: Link,
    bucket: uint,
    expected: u32,
    owner: ^(),
}
CursorError :: enum {
    ConcurrentModification,
    NoCurrentEntry,
    WrongMap,
}
    // rust: impl Cursor {
has_next :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.next.is_some()
}
}
    // rust: impl<K: JavaKey, V> Default for JavaHashMap<K, V> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: table: Vec::new(),
    // rust: nodes: Vec::new(),
    // rust: free: Vec::new(),
    // rust: size: 0,
    // rust: threshold: 0,
    // rust: modification: 0,
    // rust: owner: Arc::new(()),
}
}
}
    // rust: impl<K: JavaKey, V> JavaHashMap<K, V> {
node :: proc(self: ^Self, i: uint) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[i].as_ref().unwrap()
}
node_mut :: proc(self: ^Self, i: uint) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes[i].as_mut().unwrap()
}
parent :: proc(self: ^Self, i: Link) -> L {
    // Ported from Horizon
    return {}
}
    // rust: i.and_then(|i| self.node(i).parent)
}
left :: proc(self: ^Self, i: Link) -> L {
    // Ported from Horizon
    return {}
}
    // rust: i.and_then(|i| self.node(i).left)
}
right :: proc(self: ^Self, i: Link) -> L {
    // Ported from Horizon
    return {}
}
    // rust: i.and_then(|i| self.node(i).right)
}
red :: proc(self: ^Self, i: Link) -> b {
    // Ported from Horizon
    return {}
}
    // rust: i.is_some_and(|i| self.node(i).red)
}
color :: proc(self: ^Self, i: Link, red: bool) {
}
    // rust: if let Some(i) = i {
    // rust: self.node_mut(i).red = red;
}
}
hash :: proc(key: ^K) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let h = key.java_hash() as u32;
    // rust: (h ^ (h >> 16)) as i32
}
allocate :: proc(self: ^Self, key: K, value: V, hash: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let node = Some(Node {
    // rust: key,
    // rust: value,
    // rust: hash,
    // rust: next: None,
    // rust: prev: None,
    // rust: parent: None,
    // rust: left: None,
    // rust: right: None,
    // rust: red: false,
    // rust: tree: false,
    // rust: });
    // rust: if let Some(i) = self.free.pop() {
    // rust: self.nodes[i] = node;
    // rust: i
    // rust: } else {
    // rust: self.nodes.push(node);
    // rust: self.nodes.len() - 1
}
}
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.size
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.size == 0
}
find :: proc(self: ^Self, key: ^K) -> L {
    // Ported from Horizon
    return {}
}
    // rust: if self.table.is_empty() {
    // rust: return None;
}
    // rust: let h = Self::hash(key);
    // rust: let mut p = self.table[h as usize & (self.table.len() - 1)];
    // rust: if let Some(first) = p.filter(|i| self.node(*i).tree) {
    // rust: return self.find_tree(Some(self.root(first)), h, key);
}
    // rust: while let Some(i) = p {
    // rust: let n = self.node(i);
    // rust: if n.hash == h && n.key == *key {
    // rust: return Some(i);
}
    // rust: p = n.next;
}
    // rust: None
}
find_tree :: proc(self: ^Self, mut p: Link, hash: i32, key: ^K) -> L {
    // Ported from Horizon
    return {}
}
    // rust: while let Some(i) = p {
    // rust: let node = self.node(i);
    // rust: if hash < node.hash {
    // rust: p = node.left;
    // rust: } else if hash > node.hash {
    // rust: p = node.right;
    // rust: } else if key == &node.key {
    // rust: return Some(i);
    // rust: } else if node.left.is_none() {
    // rust: p = node.right;
    // rust: } else if node.right.is_none() {
    // rust: p = node.left;
    // rust: } else {
    // rust: match key.comparable_compare(&node.key) {
    // rust: Some(Ordering::Less) => p = node.left,
    // rust: Some(Ordering::Greater) => p = node.right,
    // rust: _ => {
    // rust: if let Some(found) = self.find_tree(node.right, hash, key) {
    // rust: return Some(found);
}
    // rust: p = node.left;
}
}
}
}
    // rust: None
}
    // Native new HashMap(source), including sizing before entry insertion.
    // Values are cloned according to their storage semantics (shared handles
    // retain identity). This may change bucket order relative to the source.
copied :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: K: Clone,
    // rust: V: Clone,
    // rust: {
    // rust: let mut result = Self::default();
    // rust: if self.size > 0 {
    // rust: let capacity = ((self.size as f64 / 0.75).ceil() as usize).min(1 << 30);
    // rust: result.threshold = capacity.next_power_of_two();
    // rust: for (key, value) in self.entries() {
    // rust: result.put(key.clone(), value.clone());
}
}
    // rust: result
}
get :: proc(self: ^Self, key: ^K) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.find(key).map(|i| &self.node(i).value)
}
entries :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.table
    // rust: .iter()
    // rust: .flat_map(|first| std::iter::successors(*first, |i| self.node(*i).next))
    // rust: .map(|i| {
    // rust: let n = self.node(i);
    // rust: (&n.key, &n.value)
    // rust: })
}
root :: proc(self: ^Self, mut p: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: while let Some(parent) = self.node(p).parent {
    // rust: p = parent;
}
    // rust: p
}
compare :: proc(self: ^Self, a: uint, b: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.node(a).hash.cmp(&self.node(b).hash).then_with(|| {
    // rust: let a = &self.node(a).key;
    // rust: let b = &self.node(b).key;
    // rust: a.comparable_compare(b)
    // rust: .filter(|v| *v != Ordering::Equal)
    // rust: .unwrap_or_else(|| a.tie_break(b))
    // rust: })
}
rotate_left :: proc(self: ^Self, mut root: uint, p: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let Some(r) = self.node(p).right else {
    // rust: return root;
}
    // rust: let rl = self.node(r).left;
    // rust: self.node_mut(p).right = rl;
    // rust: if let Some(rl) = rl {
    // rust: self.node_mut(rl).parent = Some(p);
}
    // rust: let pp = self.node(p).parent;
    // rust: self.node_mut(r).parent = pp;
    // rust: if let Some(pp) = pp {
    // rust: if self.node(pp).left == Some(p) {
    // rust: self.node_mut(pp).left = Some(r);
    // rust: } else {
    // rust: self.node_mut(pp).right = Some(r);
}
    // rust: } else {
    // rust: root = r;
    // rust: self.node_mut(r).red = false;
}
    // rust: self.node_mut(r).left = Some(p);
    // rust: self.node_mut(p).parent = Some(r);
    // rust: root
}
rotate_right :: proc(self: ^Self, mut root: uint, p: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let Some(l) = self.node(p).left else {
    // rust: return root;
}
    // rust: let lr = self.node(l).right;
    // rust: self.node_mut(p).left = lr;
    // rust: if let Some(lr) = lr {
    // rust: self.node_mut(lr).parent = Some(p);
}
    // rust: let pp = self.node(p).parent;
    // rust: self.node_mut(l).parent = pp;
    // rust: if let Some(pp) = pp {
    // rust: if self.node(pp).right == Some(p) {
    // rust: self.node_mut(pp).right = Some(l);
    // rust: } else {
    // rust: self.node_mut(pp).left = Some(l);
}
    // rust: } else {
    // rust: root = l;
    // rust: self.node_mut(l).red = false;
}
    // rust: self.node_mut(l).right = Some(p);
    // rust: self.node_mut(p).parent = Some(l);
    // rust: root
}
balance_insert :: proc(self: ^Self, mut root: uint, mut x: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.node_mut(x).red = true;
    // rust: loop {
    // rust: let Some(mut p) = self.node(x).parent else {
    // rust: self.node_mut(x).red = false;
    // rust: return x;
}
    // rust: let Some(mut g) = self.node(p).parent else {
    // rust: return root;
}
    // rust: if !self.node(p).red {
    // rust: return root;
}
    // rust: let left = self.node(g).left == Some(p);
    // rust: let uncle = if left {
    // rust: self.node(g).right
    // rust: } else {
    // rust: self.node(g).left
}
    // rust: if self.red(uncle) {
    // rust: self.color(uncle, false);
    // rust: self.node_mut(p).red = false;
    // rust: self.node_mut(g).red = true;
    // rust: x = g;
    // rust: continue;
}
    // rust: if (if left {
    // rust: self.node(p).right
    // rust: } else {
    // rust: self.node(p).left
    // rust: }) == Some(x)
    // rust: {
    // rust: x = p;
    // rust: root = if left {
    // rust: self.rotate_left(root, x)
    // rust: } else {
    // rust: self.rotate_right(root, x)
}
    // rust: p = self.node(x).parent.unwrap();
    // rust: g = self.node(p).parent.unwrap();
}
    // rust: self.node_mut(p).red = false;
    // rust: self.node_mut(g).red = true;
    // rust: root = if left {
    // rust: self.rotate_right(root, g)
    // rust: } else {
    // rust: self.rotate_left(root, g)
}
}
}
front :: proc(self: ^Self, bucket: uint, root: uint) {
}
    // rust: let first = self.table[bucket];
    // rust: if first == Some(root) {
    // rust: return;
}
    // rust: let (prev, next) = (self.node(root).prev, self.node(root).next);
    // rust: if let Some(next) = next {
    // rust: self.node_mut(next).prev = prev;
}
    // rust: if let Some(prev) = prev {
    // rust: self.node_mut(prev).next = next;
}
    // rust: if let Some(first) = first {
    // rust: self.node_mut(first).prev = Some(root);
}
    // rust: self.node_mut(root).next = first;
    // rust: self.node_mut(root).prev = None;
    // rust: self.table[bucket] = Some(root);
}
treeify :: proc(self: ^Self, bucket: uint) {
}
    // rust: let mut current = self.table[bucket];
    // rust: let mut root = None;
    // rust: while let Some(x) = current {
    // rust: current = self.node(x).next;
    // rust: {
    // rust: let n = self.node_mut(x);
    // rust: n.tree = true;
    // rust: n.left = None;
    // rust: n.right = None;
    // rust: n.parent = None;
    // rust: n.red = false;
}
    // rust: if let Some(r) = root {
    // rust: let mut p = r;
    // rust: loop {
    // rust: let left = self.compare(x, p) != Ordering::Greater;
    // rust: let child = if left {
    // rust: self.node(p).left
    // rust: } else {
    // rust: self.node(p).right
}
    // rust: if let Some(c) = child {
    // rust: p = c;
    // rust: } else {
    // rust: self.node_mut(x).parent = Some(p);
    // rust: if left {
    // rust: self.node_mut(p).left = Some(x);
    // rust: } else {
    // rust: self.node_mut(p).right = Some(x);
}
    // rust: root = Some(self.balance_insert(r, x));
    // rust: break;
}
}
    // rust: } else {
    // rust: root = Some(x);
}
}
    // rust: if let Some(root) = root {
    // rust: self.front(bucket, root);
}
}
untreeify :: proc(self: ^Self, mut p: Link) {
}
    // rust: while let Some(i) = p {
    // rust: let n = self.node_mut(i);
    // rust: n.tree = false;
    // rust: n.parent = None;
    // rust: n.left = None;
    // rust: n.right = None;
    // rust: n.red = false;
    // rust: p = n.next;
}
}
resize :: proc(self: ^Self) {
}
    // rust: let old_len = self.table.len();
    // rust: if old_len >= 1 << 30 {
    // rust: self.threshold = i32::MAX as usize;
    // rust: return;
}
    // rust: let new_len = if old_len == 0 {
    // rust: if self.threshold > 0 {
    // rust: self.threshold
    // rust: } else {
    // rust: 16
}
    // rust: } else {
    // rust: old_len * 2
}
    // rust: let old = std::mem::replace(&mut self.table, vec![None; new_len]);
    // rust: self.threshold = new_len * 3 / 4;
    // rust: for (bucket, first) in old.into_iter().enumerate() {
    // rust: let Some(first) = first else {
    // rust: continue;
}
    // rust: let tree = self.node(first).tree;
    // rust: let mut groups = [Vec::new(), Vec::new()];
    // rust: let mut p = Some(first);
    // rust: while let Some(i) = p {
    // rust: p = self.node(i).next;
    // rust: groups[usize::from((self.node(i).hash as usize & old_len) != 0)].push(i);
}
    // rust: for side in 0..2 {
    // rust: let group = &groups[side];
    // rust: if group.is_empty() {
    // rust: continue;
}
    // rust: let at = bucket + side * old_len;
    // rust: self.table[at] = Some(group[0]);
    // rust: for (j, &i) in group.iter().enumerate() {
    // rust: let n = self.node_mut(i);
    // rust: n.prev = j.checked_sub(1).map(|j| group[j]);
    // rust: n.next = group.get(j + 1).copied();
}
    // rust: if tree {
    // rust: if group.len() <= 6 {
    // rust: self.untreeify(Some(group[0]));
    // rust: } else if !groups[1 - side].is_empty() {
    // rust: self.treeify(at);
}
}
}
}
}
put :: proc(self: ^Self, key: K, value: V) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(i) = self.find(&key) {
    // rust: return Some(std::mem::replace(&mut self.node_mut(i).value, value));
}
    // rust: if self.table.is_empty() {
    // rust: self.resize();
}
    // rust: let hash = Self::hash(&key);
    // rust: let bucket = hash as usize & (self.table.len() - 1);
    // rust: let x = self.allocate(key, value, hash);
    // rust: if let Some(first) = self.table[bucket] {
    // rust: if self.node(first).tree {
    // rust: self.node_mut(x).tree = true;
    // rust: let root = self.root(first);
    // rust: let mut p = root;
    // rust: loop {
    // rust: let left = self.compare(x, p) != Ordering::Greater;
    // rust: let child = if left {
    // rust: self.node(p).left
    // rust: } else {
    // rust: self.node(p).right
}
    // rust: if let Some(child) = child {
    // rust: p = child;
    // rust: } else {
    // rust: let next = self.node(p).next;
    // rust: {
    // rust: let n = self.node_mut(x);
    // rust: n.parent = Some(p);
    // rust: n.prev = Some(p);
    // rust: n.next = next;
}
    // rust: if let Some(next) = next {
    // rust: self.node_mut(next).prev = Some(x);
}
    // rust: self.node_mut(p).next = Some(x);
    // rust: if left {
    // rust: self.node_mut(p).left = Some(x);
    // rust: } else {
    // rust: self.node_mut(p).right = Some(x);
}
    // rust: let root = self.balance_insert(root, x);
    // rust: self.front(bucket, root);
    // rust: break;
}
}
    // rust: } else {
    // rust: let mut tail = first;
    // rust: let mut count = 1;
    // rust: while let Some(next) = self.node(tail).next {
    // rust: tail = next;
    // rust: count += 1;
}
    // rust: self.node_mut(tail).next = Some(x);
    // rust: self.node_mut(x).prev = Some(tail);
    // rust: if count >= 8 {
    // rust: if self.table.len() < 64 {
    // rust: self.resize();
    // rust: } else {
    // rust: self.treeify(bucket);
}
}
}
    // rust: } else {
    // rust: self.table[bucket] = Some(x);
}
    // rust: self.size += 1;
    // rust: self.modification = self.modification.wrapping_add(1);
    // rust: if self.size > self.threshold {
    // rust: self.resize();
}
    // rust: None
}
balance_delete :: proc(self: ^Self, mut root: uint, mut x: Link) -> u {
    // Ported from Horizon
    return {}
}
    // rust: loop {
    // rust: let Some(xi) = x else {
    // rust: return root;
}
    // rust: if xi == root {
    // rust: return root;
}
    // rust: let Some(p) = self.parent(x) else {
    // rust: self.color(x, false);
    // rust: return xi;
}
    // rust: if self.red(x) {
    // rust: self.color(x, false);
    // rust: return root;
}
    // rust: let left = self.left(Some(p)) == x;
    // rust: let mut sibling = if left {
    // rust: self.right(Some(p))
    // rust: } else {
    // rust: self.left(Some(p))
}
    // rust: if self.red(sibling) {
    // rust: self.color(sibling, false);
    // rust: self.color(Some(p), true);
    // rust: root = if left {
    // rust: self.rotate_left(root, p)
    // rust: } else {
    // rust: self.rotate_right(root, p)
}
    // rust: let parent = self.parent(x);
    // rust: sibling = if left {
    // rust: self.right(parent)
    // rust: } else {
    // rust: self.left(parent)
}
}
    // rust: let parent = self.parent(x);
    // rust: let Some(s) = sibling else {
    // rust: x = parent;
    // rust: continue;
}
    // rust: let near = if left {
    // rust: self.left(sibling)
    // rust: } else {
    // rust: self.right(sibling)
}
    // rust: let far = if left {
    // rust: self.right(sibling)
    // rust: } else {
    // rust: self.left(sibling)
}
    // rust: if !self.red(near) && !self.red(far) {
    // rust: self.color(sibling, true);
    // rust: x = parent;
    // rust: continue;
}
    // rust: if !self.red(far) {
    // rust: self.color(near, false);
    // rust: self.color(sibling, true);
    // rust: root = if left {
    // rust: self.rotate_right(root, s)
    // rust: } else {
    // rust: self.rotate_left(root, s)
}
    // rust: let parent = self.parent(x);
    // rust: sibling = if left {
    // rust: self.right(parent)
    // rust: } else {
    // rust: self.left(parent)
}
}
    // rust: let parent = self.parent(x);
    // rust: self.color(sibling, self.red(parent));
    // rust: let far = if left {
    // rust: self.right(sibling)
    // rust: } else {
    // rust: self.left(sibling)
}
    // rust: self.color(far, false);
    // rust: self.color(parent, false);
    // rust: if let Some(parent) = parent {
    // rust: root = if left {
    // rust: self.rotate_left(root, parent)
    // rust: } else {
    // rust: self.rotate_right(root, parent)
}
}
    // rust: x = Some(root);
}
}
remove_tree :: proc(self: ^Self, bucket: uint, p: uint, movable: bool) {
}
    // rust: let first = self.table[bucket].unwrap();
    // rust: let mut root = self.root(first);
    // rust: let (prev, next) = (self.node(p).prev, self.node(p).next);
    // rust: if let Some(prev) = prev {
    // rust: self.node_mut(prev).next = next;
    // rust: } else {
    // rust: self.table[bucket] = next;
}
    // rust: if let Some(next) = next {
    // rust: self.node_mut(next).prev = prev;
}
    // rust: if self.table[bucket].is_none() {
    // rust: return;
}
    // rust: if movable && (self.node(root).right.is_none() || self.left(self.node(root).left).is_none())
    // rust: {
    // rust: self.untreeify(self.table[bucket]);
    // rust: return;
}
    // rust: let (left, right) = (self.node(p).left, self.node(p).right);
    // rust: let replacement;
    // rust: if let (Some(left), Some(right)) = (left, right) {
    // rust: let mut successor = right;
    // rust: while let Some(l) = self.node(successor).left {
    // rust: successor = l;
}
    // rust: let red = self.node(successor).red;
    // rust: self.node_mut(successor).red = self.node(p).red;
    // rust: self.node_mut(p).red = red;
    // rust: let sr = self.node(successor).right;
    // rust: let pp = self.node(p).parent;
    // rust: if successor == right {
    // rust: self.node_mut(p).parent = Some(successor);
    // rust: self.node_mut(successor).right = Some(p);
    // rust: } else {
    // rust: let sp = self.node(successor).parent;
    // rust: self.node_mut(p).parent = sp;
    // rust: if let Some(sp) = sp {
    // rust: if self.node(sp).left == Some(successor) {
    // rust: self.node_mut(sp).left = Some(p);
    // rust: } else {
    // rust: self.node_mut(sp).right = Some(p);
}
}
    // rust: self.node_mut(successor).right = Some(right);
    // rust: self.node_mut(right).parent = Some(successor);
}
    // rust: self.node_mut(p).left = None;
    // rust: self.node_mut(p).right = sr;
    // rust: if let Some(sr) = sr {
    // rust: self.node_mut(sr).parent = Some(p);
}
    // rust: self.node_mut(successor).left = Some(left);
    // rust: self.node_mut(left).parent = Some(successor);
    // rust: self.node_mut(successor).parent = pp;
    // rust: if let Some(pp) = pp {
    // rust: if self.node(pp).left == Some(p) {
    // rust: self.node_mut(pp).left = Some(successor);
    // rust: } else {
    // rust: self.node_mut(pp).right = Some(successor);
}
    // rust: } else {
    // rust: root = successor;
}
    // rust: replacement = sr.unwrap_or(p);
    // rust: } else {
    // rust: replacement = left.or(right).unwrap_or(p);
}
    // rust: if replacement != p {
    // rust: let pp = self.node(p).parent;
    // rust: self.node_mut(replacement).parent = pp;
    // rust: if let Some(pp) = pp {
    // rust: if self.node(pp).left == Some(p) {
    // rust: self.node_mut(pp).left = Some(replacement);
    // rust: } else {
    // rust: self.node_mut(pp).right = Some(replacement);
}
    // rust: } else {
    // rust: root = replacement;
    // rust: self.node_mut(replacement).red = false;
}
    // rust: let n = self.node_mut(p);
    // rust: n.left = None;
    // rust: n.right = None;
    // rust: n.parent = None;
}
    // rust: if !self.node(p).red {
    // rust: root = self.balance_delete(root, Some(replacement));
}
    // rust: if replacement == p {
    // rust: if let Some(pp) = self.node(p).parent {
    // rust: self.node_mut(p).parent = None;
    // rust: if self.node(pp).left == Some(p) {
    // rust: self.node_mut(pp).left = None;
    // rust: } else if self.node(pp).right == Some(p) {
    // rust: self.node_mut(pp).right = None;
}
}
}
    // rust: if movable {
    // rust: self.front(bucket, root);
}
}
remove_node :: proc(self: ^Self, i: uint, movable: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let bucket = self.node(i).hash as usize & (self.table.len() - 1);
    // rust: if self.node(i).tree {
    // rust: self.remove_tree(bucket, i, movable);
    // rust: } else {
    // rust: let (prev, next) = (self.node(i).prev, self.node(i).next);
    // rust: if let Some(prev) = prev {
    // rust: self.node_mut(prev).next = next;
    // rust: } else {
    // rust: self.table[bucket] = next;
}
    // rust: if let Some(next) = next {
    // rust: self.node_mut(next).prev = prev;
}
}
    // rust: self.size -= 1;
    // rust: self.modification = self.modification.wrapping_add(1);
    // rust: let n = self.nodes[i].take().unwrap();
    // rust: self.free.push(i);
    // rust: n.value
}
remove :: proc(self: ^Self, key: ^K) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.find(key).map(|i| self.remove_node(i, true))
}
clear :: proc(self: ^Self) {
}
    // rust: self.modification = self.modification.wrapping_add(1);
    // rust: if self.size != 0 {
    // rust: self.table.fill(None);
    // rust: self.nodes.clear();
    // rust: self.free.clear();
    // rust: self.size = 0;
}
}
cursor :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut c = Cursor {
    // rust: next: None,
    // rust: current: None,
    // rust: bucket: 0,
    // rust: expected: self.modification,
    // rust: owner: self.owner.clone(),
}
    // rust: self.advance_bucket(&mut c);
    // rust: c
}
advance_bucket :: proc(self: ^Self, c: ^Cursor) {
}
    // rust: while c.next.is_none() && c.bucket < self.table.len() {
    // rust: c.next = self.table[c.bucket];
    // rust: c.bucket += 1;
}
}
check_cursor :: proc(self: ^Self, c: ^Cursor) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !Arc::ptr_eq(&self.owner, &c.owner) {
    // rust: Err(CursorError::WrongMap)
    // rust: } else if self.modification != c.expected {
    // rust: Err(CursorError::ConcurrentModification)
    // rust: } else {
    // rust: Ok(())
}
}
    // Call while has_next is true. The returned values reflect replacements made
    // after iterator creation; structural changes are rejected before access.
next_entry :: proc(self: ^Self, c: ^Cursor) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.check_cursor(c)?;
    // rust: let Some(i) = c.next else {
    // rust: return Ok(None);
}
    // rust: c.current = Some(i);
    // rust: c.next = self.node(i).next;
    // rust: self.advance_bucket(c);
    // rust: let n = self.node(i);
    // rust: Ok(Some((&n.key, &n.value)))
}
remove_current :: proc(self: ^Self, c: ^Cursor) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !Arc::ptr_eq(&self.owner, &c.owner) {
    // rust: return Err(CursorError::WrongMap);
}
    // rust: let Some(i) = c.current else {
    // rust: return Err(CursorError::NoCurrentEntry);
}
    // rust: self.check_cursor(c)?;
    // rust: c.current = None;
    // rust: self.remove_node(i, false);
    // rust: c.expected = self.modification;
    // rust: Ok(())
}
}
