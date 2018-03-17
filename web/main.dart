import 'dart:html';
import 'dart:async';
import 'SortGame.dart';
import 'SortView.dart';

/**
 * The sorting game.
 * Author: Nane Kratzke
 */
void main() {
  final game = new SortGame(); // Game logic
  final view = new SortView(); // Interface to view
  view.update(game);           // Initial view rendering

  // Event Processing (controller logic)

  // Periodic events
  //
  final watch = new Stopwatch();
  final timer = new Timer.periodic(new Duration(milliseconds: 10), (ev) {
    view.updateTime(watch.elapsedMilliseconds);
  });

  // Click user interaction
  //
  querySelectorAll("#output td").onClick.listen((ev) {
    if (!game.finished) {
      if (!watch.isRunning) watch.start();
      final elem = ev.target as HtmlElement;
      game.mark(int.parse(elem.text, onError: (_) => 0));
      game.swap();
      view.update(game);
    }
    if (game.finished) {
      timer.cancel();
      watch.stop();
    }
  });
}