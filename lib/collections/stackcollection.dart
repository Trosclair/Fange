import "dart:collection" show Queue;

// Dart doesn't have an implementation of a generic stack collection... TwT
// So here is something I modified from the internet because I am not about to go back to Data Structures class :3
class StackCollection<T> {
  final Queue<T> _underlyingQueue;

  StackCollection() : _underlyingQueue = Queue<T>();

  int get length => this._underlyingQueue.length;
  bool get isEmpty => this._underlyingQueue.isEmpty;
  bool get isNotEmpty => this._underlyingQueue.isNotEmpty;

  void clear() => this._underlyingQueue.clear();

  T peek() {
    if (this.isEmpty) {
      throw StateError("Cannot peek() on empty stack.");
    }
    return this._underlyingQueue.last;
  }

  T pop() {
    if (this.isEmpty) {
      throw StateError("Cannot pop() on empty stack.");
    }
    return this._underlyingQueue.removeLast();
  }

  void push(final T element) => this._underlyingQueue.addLast(element);
}