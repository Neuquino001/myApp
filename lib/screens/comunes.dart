bool checkBit(int value, int bit) => (value & (1 << bit)) != 0;
int bitSet(int value, int bit) => (value | (1 << bit));
int bitClear(int value, int bit) {
  int _bit = (1 << bit);
  int _bitN = ~_bit;
  return (value & _bitN);
}

class Item {
  int? id;
  int? itemData;
}
