function [] = Task4Combo(videoDirectory, dataFileName, m, seed1Str, seed2Str, seed3Str)
    
   task4( videoDirectory, dataFileName, m, seed1Str, seed2Str, seed3Str ); %robust personalized page rank
    personalizedAscosMeasures(videoDirectory, dataFileName, m ,seed1Str, seed2Str, seed3Str);

end