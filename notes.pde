/// mitote basstree v1.0, by deadman
//  MIT license 

int con_notes = 24;
String [] note_names = new String [con_notes];
float  [] note_freqs = new float  [con_notes];

String [] straight_notes = new String [7];

int [] chords_cmaj = new int [5];
int [] chords_dmaj = new int [5];
int [] chords_emaj = new int [5];
int [] chords_fmaj = new int [5];
int [] chords_gmaj = new int [5];
int [] chords_amaj = new int [5];
int [] chords_bmaj = new int [5];


int con_lengths = 5;
String [] length_names = new String [con_lengths];
int    [] length_times = new int    [con_lengths];

void initNotes () {
  length_names [0] = "half";
  length_names [1] = "half";
  length_names [2] = "4th";
  length_names [3] = "8th";
  length_names [4] = "16th";
  
  length_times [0] = 120;
  length_times [1] = 120;
  length_times [2] = 60;
  length_times [3] = 30;
  length_times [4] = 15;
  
  straight_notes [0] = "C";
  straight_notes [1] = "D";
  straight_notes [2] = "E";
  straight_notes [3] = "F";
  straight_notes [4] = "G";
  straight_notes [5] = "A";
  straight_notes [6] = "B";
  
  chords_cmaj = new int [5];
  chords_cmaj [0] = 0;
  chords_cmaj [1] = 2; 
  chords_cmaj [2] = 4;
  chords_cmaj [3] = 5;
  chords_cmaj [4] = 7;
  
  chords_dmaj = new int [5];
  chords_dmaj [0] = 2;
  chords_dmaj [1] = 4; 
  chords_dmaj [2] = 6;
  chords_dmaj [3] = 7;
  chords_dmaj [4] = 9;
  
  chords_emaj = new int [5];
  chords_emaj [0] = 4;
  chords_emaj [1] = 6; 
  chords_emaj [2] = 8;
  chords_emaj [3] = 9;
  chords_emaj [4] = 11;
  
  chords_fmaj = new int [5];
  chords_fmaj [0] = 5;
  chords_fmaj [1] = 7; 
  chords_fmaj [2] = 9;
  chords_fmaj [3] = 10;
  chords_fmaj [4] = 0;
  
  chords_gmaj = new int [5];
  chords_gmaj [0] = 7;
  chords_gmaj [1] = 9; 
  chords_gmaj [2] = 11;
  chords_gmaj [3] = 0;
  chords_gmaj [4] = 2;
  
  chords_amaj = new int [5];
  chords_amaj [0] = 9;
  chords_amaj [1] = 11; 
  chords_amaj [2] = 1;
  chords_amaj [3] = 2;
  chords_amaj [4] = 4;
  
  chords_bmaj = new int [5];
  chords_bmaj [0] = 11;
  chords_bmaj [1] = 1; 
  chords_bmaj [2] = 3;
  chords_bmaj [3] = 4;
  chords_bmaj [4] = 6;
  
  
  

  note_names [0] = "C2";
  note_names [1] = "C#2";
  note_names [2] = "D2";
  note_names [3] = "D#2";
  note_names [4] = "E2";
  note_names [5] = "F2";
  note_names [6] = "F#2";
  note_names [7] = "G2";
  note_names [8] = "G#2";
  note_names [9] = "A2";
  note_names [10] = "A#2";
  note_names [11] = "B2";
  
  note_names [12] = "C3";
  note_names [13] = "C#3";
  note_names [14] = "D3";
  note_names [15] = "D#3";
  note_names [16] = "E3";
  note_names [17] = "F3";
  note_names [18] = "F#3";
  note_names [19] = "G3";
  note_names [20] = "G#3";
  note_names [21] = "A3";
  note_names [22] = "A#3";
  note_names [23] = "B3";
  
  
  
  note_freqs [0] = 65.406;
  note_freqs [1] = 69.296;
  note_freqs [2] = 73.416;
  note_freqs [3] = 77.782;
  note_freqs [4] = 82.407;
  note_freqs [5] = 87.307;
  note_freqs [6] = 92.499;
  note_freqs [7] = 97.999;
  note_freqs [8] = 103.83;
  note_freqs [9] = 110.00;
  note_freqs [10] = 116.54;
  note_freqs [11] = 123.47;
  
  note_freqs [12] = 130.81;
  note_freqs [13] = 138.59;
  note_freqs [14] = 146.83;
  note_freqs [15] = 155.56;
  note_freqs [16] = 164.81;
  note_freqs [17] = 174.61;
  note_freqs [18] = 185.00;
  note_freqs [19] = 196.00;
  note_freqs [20] = 207.65;
  note_freqs [21] = 220.00;
  note_freqs [22] = 233.08;
  note_freqs [23] = 246.94;
  
  
  
}
