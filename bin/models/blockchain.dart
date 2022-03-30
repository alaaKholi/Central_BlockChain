
import '../storage/storage.dart';
import 'block.dart';
import 'header.dart';
import 'merkle.dart';
import 'transaction.dart';

class Blockchain {
  final List<Block> _blocks = [];
  List<Transaction> _unconfirmedTransactions = [];
  BlockStorage blockStorage = BlockStorage();
  Blockchain() {
    createGenesisBlock();
    blockStorage.readJson().then((List<Block> value) {
      if (value.isEmpty) {
        createGenesisBlock();
      } else {
        _blocks.clear();
        _blocks.addAll(value);
      }
    });
  }

// first transaction to generate GENESIS Block from minig it
  void createGenesisBlock() {
    addTransaction(Transaction("ahmed", "raed", 50, "4"));
    mine();
  }

// Addin new Transactions to minning pools as unconfirmed Tansactions
  void addTransaction(Transaction t) {
    _unconfirmedTransactions.add(t);
  }

// Explore Chains' Blocks
  void explorBlockChain() {
    Map json = {
      'length': _blocks.length,
      'chain': _blocks.map((e) => e.toJSON()).toList()
    };
    print(json);
  }

// Mine a block according to POW
  int? mine() {
    Header newHeader;
    Block newBlock;
    if (_blocks.isEmpty) {
      newHeader = Header(
          0,
          "0",
          MerkleTree.getMerkleRoot(_unconfirmedTransactions),
          DateTime.now().millisecondsSinceEpoch,
          3);
      newBlock = Block(0, newHeader, _unconfirmedTransactions);
      print('genens done');
    } else {
      newHeader = Header(
          1,
          _blocks.last.hash,
          MerkleTree.getMerkleRoot(_unconfirmedTransactions),
          DateTime.now().millisecondsSinceEpoch,
          3);
      newBlock =
          Block(_blocks.last.index! + 1, newHeader, _unconfirmedTransactions);
    }
    String proof = proofOfWork(newBlock);
    addBlock(newBlock, proof);

    _unconfirmedTransactions = [];
    return newBlock.index;
  }

// Adding a proofed block to the chain
  bool addBlock(Block block, String proof) {
    late String previousHash;
    if (_blocks.isEmpty) {
      previousHash = '0';
    } else {
      previousHash = _blocks.last.hash!;
    }

    if (previousHash != block.header!.previousHash) {
      return false;
    }

    if (!checkProofed(block, proof)) {
      return false;
    }
    block.hash = proof;
    _blocks.add(block);
     blockStorage.writeJson(block);
    return true;
  }

// Validate the generated hash is matching
  bool checkProofed(Block block, String blockHash) {
    return (blockHash.startsWith('0' * 3) && blockHash == block.calcHash());
  }

// Consensus Algo : POW
  String proofOfWork(Block block) {
    String calculatedHash = block.calcHash();
    while (!calculatedHash
        .startsWith('0' * block.header!.difficultyBits!.toInt())) {
      block.header!.nonce = block.header!.nonce! + 1;
      calculatedHash = block.calcHash();
    }
    return calculatedHash;
  }
}
