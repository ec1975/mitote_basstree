/// mitote basstree v1.0, by deadman
//  MIT license 

class TextWall {
  int x, y;
  int w, h;
  
  boolean isVisible = true;
  
  int max_posts = 47;
  String posts [] = new String [max_posts];
  
  TextWall () {
    reset ();
  }
  
  void reset () {
    for (int i=0; i<max_posts; i++) posts [i] = "";
  }
  
  void post (String _text) {
    for (int i=max_posts-1; i>0; i--) { 
      posts [i] = posts [i-1]; 
    }
    
    posts [0] = _text;
  }
  void draw () {
    if (isVisible) {
      pushStyle ();
      textFont (font_system, 9);
      textAlign (RIGHT, TOP);
      for (int i=0; i<max_posts; i++) {
        text (posts [i], input_w-3, 3+(i*10));
      }
      popStyle ();
    }
  }
}
// The matrix, the holographic spectrum, the smoking mirror... your life.
// Those are exactly the same, pal...
void drawRootPad (int x, int y, int hue, int note_index) {
  drawPad (x, y, 0, 0, 45, 0, hue, 255, 127);
  
  fill (0, 0, 255);
  textAlign (CENTER, CENTER);
  if (straight_notes[note_index].length ()>2) textFont (font_big, 15);
  else textFont (font_big, 25);
  text (straight_notes[note_index], x+25, y+25);
  
  textAlign (CENTER, TOP);
  textFont (font_system, 9);
  text ("root", x+25, y+2);
}
void drawCNotePad (int x, int y, int note_index, int r1, int r2, int r3, int r4) {
  drawPad (x, y, r1, r2, r3, r4, 0, 0, 0);
  
  fill (0, 0, 255);
  textAlign (CENTER, CENTER);
  if (note_names[note_index].length ()>2) textFont (font_big, 15);
  else textFont (font_big, 25);
  text (note_names[note_index], x+25, y+25);
  
  textAlign (CENTER, TOP);
  textFont (font_system, 9);
  text ("note", x+25, y+2);
}
void drawCLengthPad (int x, int y, int length_index, int r1, int r2, int r3, int r4) {
  drawPad (x, y, r1, r2, r3, r4, 0, 0, 0);
  
  fill (0, 0, 255);
  textAlign (CENTER, CENTER);
  if (length_names[length_index].length ()>2) textFont (font_big, 15);
  else textFont (font_big, 25);
  text (length_names[length_index], x+25, y+25);
  
  textAlign (CENTER, TOP);
  textFont (font_system, 9);
  text ("measure", x+25, y+2);
}
void drawRootPad (int x, int y, int hue, int note_index, int r1, int r2, int r3, int r4) {
  drawPad (x, y, r1, r2, r3, r4, hue, 255, 127);
  
  fill (0, 0, 255);
  textAlign (CENTER, CENTER);
  if (straight_notes[note_index].length ()>2) textFont (font_big, 15);
  else textFont (font_big, 25);
  text (straight_notes[note_index], x+25, y+25);
  
  textAlign (CENTER, TOP);
  textFont (font_system, 9);
  text ("root", x+25, y+2);
}
void drawRhythmPad (int x, int y, int length_index) {
  drawPad (x, y, 0, 0, 45, 0, 0, 0, 0);
  
  fill (0, 0, 255);
  textAlign (CENTER, CENTER);
  if (length_names[length_index].length ()>2) textFont (font_big, 15);
  else textFont (font_big, 25);
  text (length_names[length_index], x+25, y+25);
  
  textAlign (CENTER, TOP);
  textFont (font_system, 9);
  text ("measure", x+25, y+2);
}
void drawRhythmPad (int x, int y, int length_index, int r1, int r2, int r3, int r4) {
  drawPad (x, y, r1, r2, r3, r4, 0, 0, 0);
  
  fill (0, 0, 255);
  textAlign (CENTER, CENTER);
  if (length_names[length_index].length ()>2) textFont (font_big, 15);
  else textFont (font_big, 25);
  text (length_names[length_index], x+25, y+25);
  
  textAlign (CENTER, TOP);
  textFont (font_system, 9);
  text ("measure", x+25, y+2);
}

void drawPad (int x, int y, int r1, int r2, int r3, int r4, int hue, int sat, int bri) {
  fill (hue, sat, bri);
  stroke (0, 0, 255);
  strokeWeight (2);
  rect (x, y, 50, 50, r1, r2, r3, r4);
}

