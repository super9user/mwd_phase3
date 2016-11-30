function convertFiletoCsv(filePath, outputFilename)
    text = fileread(filePath);
    text = strrep(text, '{', '');
    text = strrep(text, '}', '');
    text = strrep(text, '<', '');
    text = strrep(text, '>', '');
    text = strrep(text, '[', '');
    text = strrep(text, ']', '');
    
    fileID = fopen(outputFilename, 'w');
    fprintf(fileID, text);
end