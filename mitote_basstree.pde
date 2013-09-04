/// mitote basstree v1.0, by deadman
//  MIT license 

// mental dualism says reality is not the final truth
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import processing.video.*;

// params
boolean process_frame = true;
boolean use_movie = false;


// fonts & UI
PFont font_system;
PFont font_big;

TextWall text_wall;

// image buffers
PImage diff_img;
PImage work_img;
PImage last_img;

PGraphics canvas;

// note and audio systems
RootFrame frame_root;
RhythmFrame frame_rhythm;

SoundEngine sound_engine;

// Camera and video holders
Capture cam;
Movie video;
// input params
int input_w = 640;
int input_h = 480;



// truth is usually subjective, based upon perception, while reality just is.
void setup () {
  size (820, 480);
  colorMode (HSB, 255);
  frameRate (60);


  // fonts  & ui
  font_system  = loadFont ("DejaVuSans-9.vlw");
  font_big     = loadFont ("Ubuntu-Bold-40.vlw");
  
  text_wall = new TextWall ();
  text_wall.post ("initialized OK");
  text_wall.post ("mitote, by deadman");
  
  // image buffers init 
  last_img = createImage (input_w, input_h, ARGB);
  work_img = createImage (input_w, input_h, ARGB);
  diff_img = createImage (input_w, input_h, ARGB);
  
  canvas = createGraphics (input_w, input_h);
  
  // note systems init
  frame_root = new RootFrame ();
  frame_rhythm = new RhythmFrame ();
  
  sound_engine = new SoundEngine (this);
  initNotes ();
  
  
  // change to another namefile of your choice
  video = new Movie (this, "trees.mov");
  video.loop ();
  
  //println (cam.list ());
  //cam = new Capture (this, input_w, input_h, "/dev/video0");
  cam = new Capture (this, input_w, input_h);
  cam.start ();
}
// Keep up!
void draw () {
  readInput ();
  
  frame_root.update (work_img);
  frame_rhythm.update (work_img);
  if (frame_root.isActive && frame_rhythm.isActive) {    
    sound_engine.update (frame_root.note_index, frame_rhythm.length_index);
  }
  
  
  background (8, 64, 16);
  image (work_img, 0, 0);
  
  frame_root.draw ();
  frame_rhythm.draw ();
  
  drawCNotePad (input_w+20+60+20, 160, sound_engine.current_note_index, 0, 0, 45, 45);
  drawCLengthPad (input_w+20, 160, sound_engine.current_length_index, 0, 0, 45, 45);
  
  fill (0, 0, 255);
  String s = "bpm: "+str (sound_engine.bpm);
  s+= "\nb: "+str (sound_engine.metric_count);
  s+= "\ncnote: "+note_names [sound_engine.current_note_index];
  s+= "\nclen:  "+length_names [sound_engine.current_length_index]+"/"+length_times [sound_engine.current_length_index];
  textFont (font_system, 10);
  textAlign (LEFT, BOTTOM);
  text (s, input_w+3, height-3);
  
  text (quickhelp_string, 3, height-3);
  
  text_wall.draw ();
}
void stop () {
  sound_engine.stop ();
  super.stop ();
}
void readInput () {
  if (process_frame) {
    if (use_movie) {
      if (video.available ()) {
          video.read ();
          video.loadPixels ();
          arrayCopy (video.pixels, work_img.pixels);
          work_img.updatePixels ();
      }
    } else {
      if (cam.available ()) {
        cam.read ();
        cam.loadPixels ();
        arrayCopy (cam.pixels, work_img.pixels);
        work_img.updatePixels ();
      }
    }
  }
}
String help_string = "";
String quickhelp_string = "[Q/A/Z] (root) or [E/D/C] (rhythm) = move, resize, activate [M] mute";

// Mind vs Matter - matter does not define a universe, a monad does.
void keyTyped () {
  switch (key) {
    case '+':
      sound_engine.incBPM ();
      break;
    case '-':
      sound_engine.decBPM ();
      break;
      
    case 'p':
    case 'P':
      process_frame = !process_frame;
      break;
    case 'i':
    case 'I':
      use_movie = !use_movie;
      break;
    case 'm':
    case 'M':
      sound_engine.toggleMute ();
      break;
    case 't':
    case 'T':
      text_wall.isVisible = !text_wall.isVisible;
      break;
    
    
    case 'q':
    case 'Q':
      frame_root.jumpToMouse ();
      break;
    case 'a':
    case 'A':
      frame_root.resizeToMouse ();
      break;
    case 'z':
    case 'Z':
      frame_root.isActive = !frame_root.isActive;
      break;
      
    case 'w':
    case 'W':
      frame_root.isUiActive = !frame_root.isUiActive;      
      break;
    case 's':
    case 'S':
      
      break;
    case 'x':
    case 'X':
      frame_root.switchMode ();
      break;
      
      
    case 'e':
    case 'E':
      frame_rhythm.jumpToMouse ();
      break;
    case 'd':
    case 'D':
      frame_rhythm.resizeToMouse ();
      break;
    case 'c':
    case 'C':
      frame_rhythm.isActive = !frame_rhythm.isActive;
      break;
      
    case 'r':
    case 'R':
      frame_rhythm.decBand ();
      break;
    case 'f':
    case 'F':
      frame_rhythm.incBand ();
      break;
    case 'v':
    case 'V':
      frame_rhythm.switchMode ();
      break;
  }
}
// Mind is the key to everything. Reality is not just a perception, it is facts.
