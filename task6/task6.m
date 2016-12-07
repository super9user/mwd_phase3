function [  ] = task6(  )
    tic;
    lshFile = 'filename_d.lsh';
    object = '<54;10;<0,0>;<200,300>>';
    pcaFile = 'filename_d10.spca';
    k = 5;
    n = 20;
    layers = 3;
    matfileName = 'hashFunctionFamily.mat';
    videoDirectory = '/Users/tanmay/Development/Matlab/mwd_phase3/Demo_Videos_Phase3/Demo_Videos/';
    
    M_VideoMapFile=csvread('video_mappings_task3.csv');
    globalVideoIndex=containers.Map();
    for i=1:size(M_VideoMapFile)
        x=M_VideoMapFile(i,:);
        key=num2str(x(1));
        vidnum=num2str(x(2));
        videostr=strcat(vidnum,'.mp4');
        globalVideoIndex(key)=videostr;
    end
    
    LSHMatrix = preProcess(lshFile, 'tmp1.txt');
    disp(size(LSHMatrix));
    
    PCAMatrix = preProcess(pcaFile, 'tmp2.txt');
    disp(size(PCAMatrix));
    
    load(matfileName)
    buckets = 2^k;
    
    inputObject = getInputObject(object);
    [ minX, maxX, minY, maxY ] = getMinMaxXY(inputObject);
    allSiftVectors = getSIFTVectorsinRectangle(PCAMatrix, inputObject, minX, maxX, minY, maxY);
    allSiftVectorsTrans = transpose(allSiftVectors);
    
%     dimension = size(allSiftVectors, 1);
    hashTable = hashVectors(allSiftVectorsTrans, hashFunctionFamily, w, layers, buckets);
    set1 = getSet1(hashTable);
    [videoFramePairSimMap, tl, ul] = getSiftsInInputSets( inputObject.videoNum, set1, LSHMatrix, PCAMatrix, allSiftVectors);
    
    disp(tl);
    disp(ul);
    
    vals = values(videoFramePairSimMap);
    vals = cell2mat(vals);
    [~, idx] = sort(vals);
    
    mapKeys = keys(videoFramePairSimMap);
    toc;
    
    for j=1:n
        currIdx = idx(j);

        currVal = mapKeys(currIdx);
        currValArr = strsplit(char(currVal), ',');
        videoNum=char(currValArr(1));
        frameNum=char(currValArr(2));
        
        vidKey=globalVideoIndex(videoNum);
        videoObj=VideoReader(strcat(videoDirectory,vidKey));
        img=read(videoObj,str2num(frameNum));
        videostr=strcat (' Video Number - ',videoNum);
        videoName=strcat(' Video Name - ',vidKey);
        frameName=strcat (' Frame Number - ',frameNum);
       
        imshow(img)
        title(strcat(videoName,videostr,frameName))
        if(j~=n) 
            figure();
        end
        imwrite(img,'task6_part2.tif','WriteMode','append');
    end

end