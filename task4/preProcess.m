function [ M ] = preProcess( dataFileName )

    text=fileread(dataFileName);
    text = strrep(text,'<','');
    text = strrep(text,'>','');
    text = strrep(text,'{','');
    text = strrep(text,'}','');

    fileID = fopen('temp.txt','w');
    fprintf(fileID,text);
    fclose(fileID);
    M = csvread('temp.txt');

end

