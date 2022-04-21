import '../hashing/hash.dart';
import 'block.dart';
import 'node.dart';
import 'transaction.dart';

class MerkleTree {

  static late Node root;
  static late List<Node> childNodes;

  static Node _generateTree(List<Transaction> transactions) {
    childNodes = [];

    for (Transaction transaction in transactions) {
      childNodes.add(Node(null, null, transaction.hash));
    }

    return _buildTree(childNodes);
  }

  static Node _buildTree(List<Node> children) {
    List<Node> parents = [];

    while (children.length != 1) {
      int index = 0, length = children.length;
      while (index < length) {
        Node leftChild = children.elementAt(index);
        Node? rightChild;

        if ((index + 1) < length) {
          rightChild = children.elementAt(index + 1);
        } else {
          rightChild = Node(null, null, leftChild.getHash()); // duplicate
        }

        String parentHash =
            SHA256.hash(leftChild.getHash()! + rightChild.getHash()!);
        parents.add(Node(leftChild, rightChild, parentHash));
        index += 2;
      }
      children = parents;
      parents = [];
    }

    root = children.first;
    return root;
  }

  static String? getMerkleRoot(List<Transaction> transactions) {
    return _generateTree(transactions).hash;
  }

  static bool verify(Transaction t, Block block) {
    bool isExist =
        block.transactions.where((trans) => trans.id == t.id).isNotEmpty;
    if (!isExist) {
      return false;
    } else {
      return block.header!.merkleRoot == getMerkleRoot(block.transactions);
    }
  }
//   verify(Transaction transaction) {
//   int position =  childNodes.map((e) => null).indexWhere((Transaction t) => t.hash == transaction.hash) ;
//   print(position);
//   if (position != null) {

//     String? verifyHash = transaction.hash;

//     for (int index = childNodes.length - 2; index > 0; index--) {

//       Node? neighbour ;
//       if (position % 2 == 0) {
//         neighbour = this.root[index][position + 1];
//         position = Math.floor((position) / 2)
//         verifyHash = sha256(verifyHash + neighbour);
//       }
//       else {
//         neighbour = this.root[index][position - 1];
//         position = Math.floor((position - 1) / 2)
//         verifyHash = sha256(neighbour + verifyHash);
//       }

//     }
//     console.log(verifyHash == this.root[0][0] ? "Valid" : "Not Valid");
//   }
//   else {
//     console.log("Data not found with the id");

//   }
// }
}



