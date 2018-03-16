/**
 * Conceptual model of the sort game.
 * Author: Nane Kratzke
 */
class SortGame {
  /**
   * Game state. This state has to be sorted by user interactions.
   */
  var values = [
    [5, 6, 4, 10],
    [2, 3, 1, 11],
    [8, 7, 9, 12],
    [13, 14, 15, 16]
  ];

  /**
   * Indicates marked fields as a list row, value positions.
   */
  final marked = [];

  /**
   * Game field width.
   */
  get width => this.values.first.length;

  /**
   * Game field height.
   */
  get height => this.values.length;

  /**
   * Marks all fields with a given value.
   * (row, col) must be a valid position, otherwise the game state is not changed.
   */
  void mark(int value) {
    for (int row = 0; row < this.height; row++) {
      for (int col = 0; col < this.width; col++) {
        if (this.value(row, col) == value) {
          this.marked.add([row, col]);
        }
      }
    }
  }

  /**
   * Returns whether a field is marked.
   */
  bool isMarked(int row, int col) {
    for (var entry in this.marked) {
      print(entry);
      if (entry[0] == row && entry[1] == col) return true;
    }
    return false;
  }

  /**
   * Swaps values along marked positions.
   */
  void swap() {
    if (this.marked.length < 2) return;
    var start = this.marked.first;
    this.marked.remove(this.marked.first);
    while (!this.marked.isEmpty) {
      var next = this.marked.first;
      this.marked.remove(this.marked.first);
      final v1 = this.value(start[0], start[1]);
      final v2 = this.value(next[0], next[1]);
      this.values[next[0]][next[1]] = v1;
      this.values[start[0]][start[1]] = v2;
      start = next;
    }
    this.unmark();
  }

  /**
   * Checks whether the game has been solved.
   * All values at valid positions.
   */
  get finished {
    for (int row = 0; row < this.height; row++) {
      for (int col =0; col < this.width; col++) {
        if (!this.isValid(row, col)) return false;
      }
    }
    return true;
  }

  /**
   * Deletes all marks.
   */
  void unmark() => this.marked.removeRange(0, this.marked.length);

  /**
   * Returns value of game field at position (row, col).
   * row and col must indicate a valid position.
   */
  int value(int row, int col) => this.values[row][col];

  /**
   * Checks whether a position (row, col) is on the game field.
   */
  bool isValidPosition(int row, int col) =>
      row >= 0 && row < height && col >= 0 && col < width;

  /**
   * Checks whether value on field (row, col) is valid.
   */
  bool isValid(int row, int col) => value(row, col) == row * width + col + 1;
}