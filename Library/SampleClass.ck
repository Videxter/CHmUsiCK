public class Sampler extends Chmusick
{
    
    SndBuf buffer => Echo echo => Gain Normalize => Gain vol => Envelope envelope => Master;
    
    0.6 => Normalize.gain;
    
    0.05 => echo.mix;
    
    16 => int Division;
    //32 => int Division; midi map
    
    "" => string fileName;
	
    [0] @=> int gains[];
	
    public string file(string name, string letter)
    {
        me.dir() + "Samples/" + name + "/" + letter + ".wav" => fileName; //Mac/Linux conflict with path
        //"Samples/" + name + "/" + letter + ".wav" => fileName; //Mac/Linux conflict with path
        fileName => buffer.read;
        
        return fileName;
    }
    public string file(string name, int num)
    {
        me.dir() + "Samples/" + name + "/" + num + ".wav" => fileName; //Mac/Linux conflict with path
		//"Samples/" + name + "/" + num + ".wav" => fileName; //Mac/Linux conflict with path
        fileName => buffer.read;
		
        return fileName;
    }
	public string file(string name)
	{
		file(name, 1);
		return fileName;
	}
    public int[] changeStress(int parameters[])
    {
        int toReturn[parameters.cap()];
        
        parameters.cap() => gains.size;
        parameters @=> gains;
        
        return gains;
    }
    public int[] accelerate(int patterns[], int parameter)
    {
        parameter*Division => Division;
        
        return patterns;
    }
    public int[] accelerate(int patterns[], int parameter)
    {
        parameter/Division => Division;
        
        return patterns;
    }
    public void sound(string S, int sample[])
    {
	file(S);
	sound(sample);
    }
	public void sound()
    {
        while(true) {
            envelope.keyOn();
            0 => buffer.pos;
            buffer.length() => now;
        }
    }
    public void sound(int sample[])
    {
		2 => CYCLES;
		
        while(true)
        {
            for(0 => int i; i < sample.cap(); i++)
            {
                if (sample[i] == 1)
                {
                    stress(sample.cap(),gains)[i] => buffer.gain;
                    envelope.keyOn();
                    0 => buffer.pos;
                }
                Dur(convert(TEMPO),Division) => now;
                
                if (sample[i] == 0)
                {
                    envelope.keyOff();
                }
                Dur(convert(TEMPO),Division) => now;
            }
        }
    }
    public void sound(string sample[])
    {
        60 => TEMPO;
        1 => CYCLES;
        
        while(true)
        {
            for(0 => int i; i < sample.cap(); i++)
            {
                if (sample[i] != "~")
                {
                    file(sample[i]);
                    stress(sample.cap(),gains)[i] => buffer.gain;
                    envelope.keyOn();
                    0 => buffer.pos;
                }
                Dur(convert(TEMPO),Division)/sample.cap() => now;
                
                if (sample[i] == "~")
                {
                    envelope.keyOff();
                }
                Dur(convert(TEMPO),Division)/sample.cap() => now;
            }
        }
    }
}
