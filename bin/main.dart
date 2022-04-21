import 'models/block.dart';
import 'models/blockchain.dart';
import 'models/transaction.dart';
import 'storage/storage.dart';

void main(List<String> arguments) async {
  BlockStorage blockStorage = BlockStorage();

  List<Block> blocks = await blockStorage.readJson();
  Blockchain blockchain = Blockchain(blocks, blockStorage);

  blockchain.addTransaction(Transaction("ahmed1", "raed1", 50, "2"));
  blockchain.addTransaction(Transaction("ahmed1", "raed11", 50, "5"));

  blockchain.mine();

  blockchain.addTransaction(Transaction("ahmed2", "raed1", 50, "6"));
  blockchain.addTransaction(Transaction("ahmed2", "raed1", 50, "8"));
  blockchain.mine();

  blockchain.explorBlockChain();
}
