import '../hashing/hash.dart';

class Transaction {
  String? to;
  String? from;
  double? amount;
  String? id;
  String? hash;
  Map<String, dynamic> toJSON() {
    return {
      "to": to,
      "from": from,
      "amount": amount,
      "id": id,
      "hash": hash,
    };
  }

  Transaction(this.to, this.from, this.amount, this.id) {
    hash = SHA256.hash(to! + from! + amount.toString());
  }
  factory Transaction.fromJSON(Map<String, dynamic> map) {
    return Transaction(map['to'], map['from'], map['amount'], map['id']);
  }
}
