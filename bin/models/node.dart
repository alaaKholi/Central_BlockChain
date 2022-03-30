class Node {
  Node? left;
  Node? right;
  String? hash;

  Node(this.left, this.right, this.hash);

  Node? getLeft() {
    return left;
  }

  void setLeft(Node left) {
    this.left = left;
  }

  Node? getRight() {
    return right;
  }

  void setRight(Node right) {
    this.right = right;
  }

  String? getHash() {
    return hash;
  }

  void setHash(String hash) {
    this.hash = hash;
  }
}
