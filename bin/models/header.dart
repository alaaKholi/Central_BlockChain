class Header {
  final int? version;
  final String? previousHash;
  final String? merkleRoot;
  final int? timestamps;
  final int? difficultyBits;
  int? nonce = 0;

  Header(this.version, this.previousHash, this.merkleRoot, this.timestamps,
      this.difficultyBits,
      {this.nonce = 0});

  Map<String, dynamic> toJSON() {
    return {
      "version": version,
      "prevHash": previousHash,
      "merkleRoot": merkleRoot,
      "time": timestamps,
      "bits": difficultyBits,
      "nonce": nonce
    };
  }

  factory Header.fromJSON(Map<String, dynamic> map) {
    return Header(map['version'], map['previousHash'], map['merkleRoot'],
        map['timestamps'], map['difficultyBits']);
  }
}
