Chmusick livemda;
Gain master => dac;
// set classes
Drum drum2 => PRCRev rev => NRev rev2 => LPF lpf => master;
Drum drums => rev => rev2 => lpf => master; 
Melody clip3 => rev2 => lpf =>  master;
Melody clip4 => LPF lpf1 => rev => master;
Melody clips => rev2 => lpf => master; // bass/chords/melodys
FMSynth clips2 => lpf => HPF hpf => Gain fm => master; // fmsynth me sirve para bajos medio y altos 
// set tempo
livemda.tempo(140); //BUG
// establece un control general del volumen
master.gain(0.9);
// change drums
1 => drums.BDSound; // BDsound es para los kick   1
2 => drums.SNSound; // SNsound es para Snare      2  
7 => drums.HHSound; // HHsound es para hithat     1  
// change drum2
3 => drum2.BDSound; // BDsound es para los kick   1
5 => drum2.SNSound; // SNsound es para Snare      2  
0 => drum2.HHSound; // HHSound HitHats

// gain controls
drum2.gain(0.03);
drums.gain(0.04);// gain del drumrack
clips.gain(0.06);
clips2.gain(0.03);
clip3.gain(0.04);
clip4.gain(0.01);
// Gain bass
0.7 => fm.gain;

// FX
0.01 => rev.mix;
0.02 => rev2.mix;
1000 => lpf.freq;
1000 => lpf1.freq;
100 => hpf.freq;

// sintesis bass
clips2.ratio(1,1);
clips2.mgain(2);

// sintesis de los objetos melody
clips.controlChange(4); //4
clip3.controlChange(17); //9 
clip4.controlChange(8); //11

spork~drums.drum(drums.favorite(0));
spork~drum2.drum(drum2.favorite(1));

//spork~clips2.fmBass(clips2.melodies(1));
//spork~clips.synth(clips.melodies(1));

//spork~clips2.fmBass([32,32,32,32,32,32,31,31,31,31,31,31,31,31,31,31,36,36,36,36,36,0,36,36,36,36,36,0,36,36,29,29]);
//spork~clips.synth([44,32,44,32,44,32,43,31,43,31,43,31,43,31,43,31,48,36,48,36,48,36,48,36,48,36,48,0,48,36,31,29]);
//spork~clip3.synth([48,48,48,48,48,48,46,46,46,46,46,46,46,46,46,46,55,55,55,55,55,55,55,55,55,55,55,55,55,55,34,34]);
//spork~clip3.synth([72,72,72,72,72,0,72,72,72,0,72,72,72,0,72,72,72,0,72,72,72,0,72,72,72,0,72,0,62,62,62]);
spork~clip4.synth([67,67,68,67,67,68,67,67,68,67,67,68,67,67,68,67]);
// clips: MelodyArray 
// drums: favoriteArray
while (true){samp => now;}