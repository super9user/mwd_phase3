function [ M ] = preProcess( dataFileName, temp )

    text=fileread(dataFileName);
    text = strrep(text,'<','');
    text = strrep(text,'>','');
    text = strrep(text,'{','');
    text = strrep(text,'}','');
    text = strrep(text,';',',');
    text = strrep(text,'[','');
    text = strrep(text,']','');

    fileID = fopen(temp','w');
    fprintf(fileID,text);
    fclose(fileID);
    M = csvread(temp);

end

