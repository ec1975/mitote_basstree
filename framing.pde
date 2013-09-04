/// mitote basstree v1.0, by deadman
//  MIT license 

class RootFrame extends ImageFrame {
  boolean isUiActive = true;
  RootFrame () {
    super (70, 100, 100, 100);
  }

  void update (PImage input_img) {
    int i, dh;

    // parent call
    super.update (input_img);

    // clear hue counter
    for (i=0; i<256; i++) hue_counter [i] = 0;
    // count 1 for every hue you meet
    for (i=0; i<w; i++) 
      for (int j=0; j<h; j++) hue_counter [(int)hue (img.get (i, j))]++;

    // get dominant hue
    hue_dominant = 0;
    for (i=0; i<256; i++) if (hue_counter [i]>hue_counter[hue_dominant]) hue_dominant = i;

    // Calc average hue 
    hue_average = 0;
    for (i=0; i<256; i++) {
      hue_average+=hue_counter [i];
      hue_average/= 2;
    }

    switch (mode) {
    case 0:
      // dominant hue
      hue = hue_dominant;
      break;
    case 1:
      // average hue
      hue = hue_average;
      break;
    }

    note_index = (int)map ((float)hue, 0, 255, 0, 6);
  }

  void draw () {
    super.draw ();

    pushStyle ();
    stroke (0, 0, 255);
    noFill ();
    line (x+1, y+1, x+w-1, y+1);

    strokeWeight (2);
    image (img, input_w+20, 20, 50, 50);
    rect (input_w+20, 20, 50, 50);
 
    if (isUiActive) {   
      for (int i=0; i<255; i++) {
        stroke (i, 255, 127);
        line (0, i+20, hue_counter [i], i+15);
      }
    }
    
    
    stroke (0, 0, 255);
    fill (hue, 255, 255);
    rect (input_w+20+60, 20, 10, 50);
    
    drawRootPad (input_w+20+60+20, 20, hue, note_index, 0, 45, 0, 0);
    popStyle ();
  }
  void switchMode () {
    if (mode==0) mode = 1; else mode = 0;
  }
  void setMode (int _mode) {
    mode = _mode;
  }

  int hue_counter [] = new int [256];
  int hue_average;
  int hue_dominant;

  int hue;
  int note_index;

  int mode = 0;
}

// Truths are not realities. You are being manipulated.
class RhythmFrame extends DiffFrame {
  RhythmFrame () {
    super (200, 100, 100, 100);
  }
  void update (PImage input_img) {
    int i, dh;

    // parent call
    super.update (input_img);
  }
  void draw () {
    super.draw ();

    pushStyle ();
    stroke (0, 0, 255);
    noFill ();

    strokeWeight (2);
    image (diff_img, input_w+20, 90, 50, 50);
    rect (input_w+20, 90, 50, 50);
    
    
    //note_index = (int)map (diff_pels, 0, total_pels, 0, con_notes);
    
    //length_index = constrain ((int)map (diff_pels, 0, pass_band, 4, 0), 0, 4);
    int d1 = 4;
    int d2 = 0;
    if (mode==1) {
      d1 = 0;
      d2 = 4;
    }
    
    length_index = (int)map (constrain (diff_pels, 0, pass_band), 0, pass_band, d1, d2); 
    
    fill (0);
    rect (input_w+20+60, 90,10, 50);
    
    fill (255);
    rect (input_w+20+60, 90, 10, (int)map (diff_pels, 0, total_pels, 0, 50));
    
    line (input_w+20+60, 90+(int)map (pass_band, 0, total_pels, 0, 50),
           input_w+20+75, 90+(int)map (pass_band, 0, total_pels, 0, 50)); 
    
    drawRhythmPad (input_w+20+60+20, 90, length_index, 0, 0, 0, 0);
    
    popStyle ();
  }

  int band_increase = 100;  
  void incBand () {
    if (pass_band<total_pels-band_increase) pass_band+=band_increase;
  }
  void decBand () {
    if (pass_band>=band_increase) pass_band-=band_increase;
  }
  void switchMode () {
    if (mode==0) mode=1; else mode=0;
  }
  
  
  int note_index = 0;
  
  int length_index;
  long pass_band = 1000;
  
  int mode = 0;
}


// Free yourself! Reprogram your mind out of it!
///==============================================
class DiffFrame extends ImageFrame {
  DiffFrame (int _x, int _y, int _w, int _h) {
    super (_x, _y, _w, _h);

    
    past_img = createImage (w, h, ARGB);
    diff_img = createImage (w, h, ARGB);
  }
  void update (PImage input_img) {
    float u, s, b;
    color c;
    
    super.update (input_img);
    
    img.filter (POSTERIZE, 3);
    
    diff_pels = 0;
  
    for (int i=0; i<diff_img.pixels.length; i++) {
      diff_img.pixels [i] = 0;
    }
    img.loadPixels ();
    for (int i=0; i<w; i++) {
      for (int j=0; j<h; j++) {
        c = img.get (i, j);
        u = hue (c);
        s = saturation (c);
        b = brightness (c);
        
        c = past_img.get (i, j);
        if (brightness (c)!=b || hue (c)!=u || saturation (c)!=s) {
          diff_img.set (i, j, color (255));
          diff_pels++;
        }
      }
    }
    img.updatePixels ();
    
    img.loadPixels ();
    arrayCopy (img.pixels, past_img.pixels);
    past_img.updatePixels ();
  }
  void resizeToMouse () {
    super.resizeToMouse ();
    
    past_img.resize (w, h);
    diff_img = createImage (w, h, ARGB);
  }
  
  PImage past_img;
  PImage diff_img;
  int diff_pels;
 
}
class ImageFrame {
  int x, y;
  int w, h;

  long total_pels;

  PImage img;

  boolean isVisible = true;
  boolean isActive = false;

  ImageFrame (int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;

    total_pels = w * h;

    img = createImage (w, h, ARGB);
  }
  void update (PImage input_img) {
    img = input_img.get (x, y, w, h);
    img.updatePixels ();
  }
  void draw () {
    if (isVisible) {
      pushStyle ();
      if (isActive) stroke (0, 0, 255);
      else stroke (0, 0, 127);
      noFill ();
      strokeWeight (2);
      rect (x, y, w, h);
      popStyle ();
    }
  }

  void jumpToMouse () {
    x = mouseX;
    y = mouseY;
  }
  void resizeToMouse () {
    w = abs (x-mouseX);
    h = abs (y-mouseY);

    total_pels = w * h;
    img.resize (w, h);
    
  }

  boolean mouseInside () {
    if ((mouseX>x && mouseX<x+w) && (mouseY>y && mouseY<y+h)) return true;
    else return false;
  }
}
// So you think reality is just mass and matter? nope... it is an illusion.
