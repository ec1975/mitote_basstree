/// mitote basstree v1.0, by deadman
//  MIT license 

class SoundEngine {
  Minim minim;
  AudioOutput aout;
  
  int bpm;
  // quarter beat click
  long click_q;
  // sixteenth beat click
  long click_s;
  
  long click_n;
  
  long click_beat;
  
  long timer_q;
  long timer_s;
  long timer_n;
  long timer_beat;
  
  int metric_count = 0;

  boolean note_on = false;

  SineWave signal;  
  
  SineWave signal_a;
  
  
  int current_note_index;
  int current_length_index;

  SoundEngine (PApplet parent) {
    minim = new Minim (parent);
    aout = minim.getLineOut (Minim.STEREO, 512);
    
    setBPM (120);
  }
  void update (int note_index, int length_index) {
    if (millis()-timer_q>=click_q) {
      if (++metric_count>4) metric_count=1;
      timer_q = millis ();
    }

    
    if (millis ()-timer_s>=click_s) {
      
      if (!note_on) {
        ///*********** MAKE CONVERSION HERE!
        // this one picks the chord, but not the note itself...
        // would be nice if it was math
        int i = 0;
        switch (note_index) {
          case 0:
            i = chords_cmaj [(int)random (5)];
            break;
          case 1:
            i = chords_dmaj [(int)random (5)];
            break;
          case 2:
            i = chords_emaj [(int)random (5)];
            break;
          case 3:
            i = chords_fmaj [(int)random (5)];
            break;
          case 4:
            i = chords_gmaj [(int)random (5)];
            break;
          case 5:
            i = chords_amaj [(int)random (5)];
            break;
          case 6:
            i = chords_bmaj [(int)random (5)];
            break;
            
          
        }
        
        current_note_index = i;
        current_length_index = length_index;
        
        float f = note_freqs [i];
        
        int d = length_times [length_index];
        click_n =  (long)(((float)d/bpm)*1000);


        String s = note_names [current_note_index];
        s+= " - "+length_names [current_length_index];
        text_wall.post (s);
        
        signal = new SineWave (f, 1, 44100);
        aout.addSignal (signal);
        note_on = true;
        timer_n = millis ();
      }
      timer_s = millis ();
    }
    if (note_on) {
      if (millis ()-timer_n>click_n) {
        
          aout.removeSignal (signal);
          note_on = false;
          
       }
    }
    
  }

  void stop () {
    minim.stop ();
  }
  void toggleMute () {
    if (aout.isMuted ())
        aout.unmute ();
      else
        aout.mute ();
  }
  void setNoteParams (int note_index, int length_index) {
    
  }
  void setBPM (int _bpm) {
    bpm = _bpm;
    click_q = (long)(((float)length_times[2]/bpm)*1000);
    click_s = (long)(((float)length_times[4]/bpm)*1000);
  }
  void incBPM () {
    if (bpm<250) setBPM (bpm+1);
  }
  void decBPM () {
    if (bpm>60) setBPM (bpm-1);
  }
}
