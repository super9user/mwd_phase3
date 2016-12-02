function [ obj ] = getInputObject( text )

    text = strrep(text,'<','');
    text = strrep(text,'>','');
    text = strrep(text,' ','');
    text = strrep(text,';',',');
    C = strsplit(text, ',');
    
    obj = InputObject(char(C(1)), char(C(2)), char(C(3)), char(C(4)), char(C(5)), char(C(6)));

end

