function [ minX, maxX, minY, maxY ] = getMinMaxXY( inputObject )

    if(inputObject.x1 < inputObject.x2)
        minX = inputObject.x1;
        maxX = inputObject.x2;
    else
        minX = inputObject.x2;
        maxX = inputObject.x1;
    end
    
    if(inputObject.y1 < inputObject.y2)
        minY = inputObject.y1;
        maxY = inputObject.y2;
    else
        minY = inputObject.y2;
        maxY = inputObject.y1;
    end

end

