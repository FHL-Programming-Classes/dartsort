import 'SortGame.dart';
import 'dart:html';

/**
 * The view part of the sort game.
 * It interfaces the DOM-Tree.
 *
 * Author: Nane Kratzke
 */
class SortView {

  /**
   * References the output div element of the HTML document.
   */
  HtmlElement output = querySelector('#output');

  /**
   * References the timer div element of the HTML document.
   */
  HtmlElement timer = querySelector('#timer');

  /**
   * Renders the game field initially into the DOM-tree of the HTML document.
   * Normally, this method is only called once while initial setup.
   */
  void render(SortGame game) {
    var table = "";
    for (int row = 0; row < game.width; row++) {
      var line = "";
      for (int col = 0; col < game.height; col++) {
        line += "<td id='pos-$row-$col'>${game.value(row, col)}</td>";
      }
      table += "<tr>$line</tr>";
    }
    output.innerHtml = "<table>$table</table>";
  }

  void updateTime(int milliseconds) {
    timer.text = "$milliseconds ms";
  }

  /**
   * Updates the DOM-Tree to reflect the latest game state for the user.
   */
  void update(SortGame game) {
    if (output.text.isEmpty) render(game);

    for (int row = 0; row < game.width; row++) {
      for (int col = 0; col < game.height; col++) {
        final elem = querySelector("#pos-$row-$col");
        elem.text = "${game.value(row, col)}";
        elem.classes.remove('sorted');
        elem.classes.remove('marked');
        if (game.isValid(row, col)) elem.classes.add('sorted');
        if (game.isMarked(row, col)) elem.classes.add('marked');
      }
    }
  }
}
