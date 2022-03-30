import '../hashing/hash.dart';
import 'header.dart';
import 'transaction.dart';

class Block {
  final int? index;
  final Header? header;
  int? transactionsCount;
  final List<Transaction> transactions;
  // int? _size;
  String? hash;

  Block(
    this.index,
    this.header,
    this.transactions,
  ) {
    transactionsCount = transactions.length;
    hash = calcHash();
  }

  String calcHash() {
    return SHA256.hash(index.toString() +
        header!.toJSON().toString() +
        transactionsCount.toString() +
        transactions.toString());
  }

  Map<String, dynamic> toJSON() {
    return {
      'index': index,
      'header': header!.toJSON(),
      'transactionsCount': transactionsCount,
      'transactions': transactions.map((e) => e.toJSON()).toList(),
      'hash': hash
      //'size': _size,
    };
  }

  factory Block.fromJSON(Map<String, dynamic> map) {
    List<Transaction> transactionList = [];

    if (map['transactions'] != null) {
      map['transactions'].forEach((v) {
        transactionList.add(Transaction.fromJSON(v));
      });
    }
    return Block(
        map['index'] as int,
        Header.fromJSON(map['header'] as Map<String, dynamic>),
        transactionList);
  }

  // List<String> merkleTree() {
  //   List<String> tree = [];
  //   // Start by adding all the hashes of the transactions as leaves of the
  //   // tree.
  //   for (Transaction t in transactions) {
  //     tree.add(t.hash!);
  //   }
  //   int levelOffset = 0; // Offset in the list where the currently processed
  //   // level starts.
  //   // Step through each level, stopping when we reach the root (levelSize
  //   // == 1).
  //   for (int levelSize = transactions.length;
  //       levelSize > 1;
  //       levelSize =((levelSize + 1) / 2).round() ) {
  //     // For each pair of nodes on that level:
  //     for (int left = 0; left < levelSize; left += 2) {
  //       // The right hand node can be the same as the left hand, in the
  //       // case where we don't have enough
  //       // transactions.
  //       int right = min(left + 1, levelSize - 1);
  //       String tleft = tree.elementAt(levelOffset + left);
  //       String tright = tree.elementAt(levelOffset + right);
  //       tree.add(SHA256.hash(tleft + tright));
  //     }
  //     // Move to the next level.
  //     levelOffset += levelSize;
  //   }
  //   return tree;
  // }
}
