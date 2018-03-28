import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
Oscil[]     LstWave;

int touchNumber = 14;
int octave =       4;

float[] Do  = new float[] {32.70,  65.41, 130.81, 261.63, 523.25, 1046.50, 2093.00, 4186.01};
float[] Re  = new float[] {36.71,  73.42, 146.83, 293.66, 587.33, 1174.66, 2349.32, 4698.64};
float[] Mi  = new float[] {41.20,  82.41, 164.81, 329.63, 659.26, 1318.51, 2637.02, 5274.04};
float[] Fa  = new float[] {43.65,  87.31, 174.61, 349.23, 698.46, 1396.91, 2793.83, 5587.65};
float[] Sol = new float[] {49.00,  98.00, 196.00, 392.00, 783.99, 1567.98, 3135.96, 6271.93};
float[] La  = new float[] {55.00, 110.00, 220.00, 440.00, 880.00, 1760.00, 3520.00, 7040.00};
float[] Si  = new float[] {61.74, 123.47, 246.94, 493.88, 987.77, 1975.53, 3951.07, 7902.13};

void setup()
{
  size(800, 200, P3D);
  
  minim = new Minim(this);
  out = minim.getLineOut();
  
  LstWave =     new Oscil[touchNumber];
  LstWave [0] = new Oscil( Do[octave],     0.0, Waves.SINE);
  LstWave [1] = new Oscil( Re[octave],     0.0, Waves.SINE);
  LstWave [2] = new Oscil( Mi[octave],     0.0, Waves.SINE);
  LstWave [3] = new Oscil( Fa[octave],     0.0, Waves.SINE);
  LstWave [4] = new Oscil(Sol[octave],     0.0, Waves.SINE);
  LstWave [5] = new Oscil( La[octave],     0.0, Waves.SINE);
  LstWave [6] = new Oscil( Si[octave],     0.0, Waves.SINE);
  LstWave [7] = new Oscil( Do[octave + 1], 0.0, Waves.SINE);
  LstWave [8] = new Oscil( Re[octave + 1], 0.0, Waves.SINE);
  LstWave [9] = new Oscil( Mi[octave + 1], 0.0, Waves.SINE);
  LstWave[10] = new Oscil( Fa[octave + 1], 0.0, Waves.SINE);
  LstWave[11] = new Oscil(Sol[octave + 1], 0.0, Waves.SINE);
  LstWave[12] = new Oscil( La[octave + 1], 0.0, Waves.SINE);
  LstWave[13] = new Oscil( Si[octave + 1], 0.0, Waves.SINE);
  
  for(int i = 0; i<touchNumber;i++)
  {
    LstWave[i].patch(out);
  }
}

void draw()
{
  background(0);
  stroke(255);
  strokeWeight(1);
  
  for(int i = 0; i < touchNumber; i++)
  {
    line((width / touchNumber) * i, 0, (width / touchNumber) * i, height);
  }
  
  // draw the waveform of the output
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    line(i,  50 -  out.left.get(i)*50, i+1,  50  - out.left.get(i+1)*50);
    line(i, 150 - out.right.get(i)*50, i+1, 150 - out.right.get(i+1)*50);
  }
}

void mouseMoved()
{
  int touchOn = get_touchOn();
  if (touchOn >=0 && touchOn < touchNumber)
  {
    float                          amp = 0.0;
    if      (mouseY > height - 20) amp = 0.0;
    else if (mouseY < 20)          amp = 1.0/touchNumber;
    else                           amp = map(mouseY, 20.0, height - 20.0, 1.0/touchNumber, 0);
    
    LstWave[touchOn].setAmplitude(amp);
  }
}

int get_touchOn()
{
  return ((touchNumber * mouseX) / width);
}

void keyPressed()
{ 
  switch( key )
  {
    case '1':
      LstWave[get_touchOn()].setWaveform(Waves.SINE);
      break;
    case '2':
      LstWave[get_touchOn()].setWaveform(Waves.TRIANGLE);
      break;
    case '3':
      LstWave[get_touchOn()].setWaveform(Waves.SAW);
      break;
    case '4':
      LstWave[get_touchOn()].setWaveform(Waves.SQUARE);
      break;
    case '5':
      LstWave[get_touchOn()].setWaveform(Waves.QUARTERPULSE);
      break;
    default:
      break;
  }
}