import 'models/blockchain.dart';
import 'models/transaction.dart';

void main(List<String> arguments) {
  
  Blockchain blockchain = Blockchain();

  blockchain.addTransaction(Transaction("ahmed1", "raed1", 50,"2"));
  blockchain.addTransaction(Transaction("ahmed1", "raed11", 50,"5"));

  blockchain.mine();

  blockchain.addTransaction(Transaction("ahmed2", "raed1", 50, "6"));
  blockchain.addTransaction(Transaction("ahmed2", "raed1", 50, "8"));
  blockchain.mine();

  blockchain.explorBlockChain();
}
