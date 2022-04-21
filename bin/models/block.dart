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
}
