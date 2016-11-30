function intermediate = findSum(objI, objJ, gm, gom)
intermediate = 0;
sVideo = num2str(objI.video);
sFrame = num2str(objI.frame);
dVideo = num2str(objJ.video);
dFrame = num2str(objJ.frame);
mapKey = strcat(sVideo,',',sFrame);
if (strcmp(sVideo, dVideo) == 1 && strcmp(sFrame, dFrame) == 1)
    intermediate = 1/0.9;
    return 
end
if (isKey(gom, mapKey))
    arrayPoint = gom(mapKey);
    arraySize = size(arrayPoint, 2);
    overWeight = 0;
    sim = zeros(arraySize, 1);
    for i = 1:arraySize
        kVideo = num2str(arrayPoint(i).destinationVideo);
        kFrame = num2str(arrayPoint(i).destinationFrame);
        gmKey = strcat(kVideo, ',', kFrame, ',', dVideo, ',', dFrame);
        overWeight = overWeight + arrayPoint(i).simValue;
        if (isKey(gm, gmKey))
            sim(i) = gm(gmKey).similarityValue;
        else
            sim(i) = 0;
        end
    end
    for i = 1:arraySize
        ikWeight = arrayPoint(i).simValue;
        intermediate = intermediate + ((ikWeight/overWeight) * (1 - exp(-ikWeight)) * sim(i));
    end
end