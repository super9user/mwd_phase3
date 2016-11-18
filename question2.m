
dir_video_list=dir('P2DemoVideos/*.mp4'); %the videos must be in the same folder
list_size=length(dir_video_list); 

input_r=3;


fid = fopen('sift.csv', 'w');
count=1;
for i=1 :list_size %for all videos
    disp(i);
    disp(i);
    disp(i);
    disp(i);
    disp(i);
    disp(i);
    video_name=dir_video_list(i).name;
     obj= VideoReader(dir_video_list(i).name) 
     numFrames=obj.NumberOfFrames;
%      fprintf(fid,'Sift Vectors for Video - %s with %d frames\n\n',video_name,numFrames);
     for k = 1 : numFrames  
    
%         fprintf(fid,'Sift Vectors for frame %d\n\n',k);
        this_frame=rgb2gray(read(obj,k)); 
        [height,width,depth]=size(this_frame);
        min_dimension=min(height,width);

        q1=floor(height/input_r);
        q2=floor(width/input_r);
        r1=mod(height,input_r);
        r2=mod(width,input_r);
        r=input_r;
        indexatj=1;
        cellcount=1;
        %loop to divide the frame into cells
        for i=1:r 
        indexati=1;
            for j=1:r
                
                if(i==r && j~=r)
                    submat=this_frame(indexati:(indexati-1+q1)+r1,indexatj:indexatj-1+q2);
                    [image, descrips, locs] = sift(submat); %finding sift for cells.
                    [x,y]=size(locs);
                    printfunction2(k,cellcount,count,x,locs,descrips,fid,i,j);
                    
                end
                if(j==r && i~=r)
                    submat=this_frame(indexati:indexati-1+q1,indexatj:(indexatj+q2-1)+r2);
                    [image, descrips, locs] = sift(submat);
                    [x,y]=size(locs);
                    printfunction2(k,cellcount,count,x,locs,descrips,fid,i,j);

                end
                if(j==r && i==r)
                    submat=this_frame(indexati:(indexati+q1-1)+r1,indexatj:(indexatj+q2-1)+r2);
                    [image, descrips, locs] = sift(submat);
                    [x,y]=size(locs);
                    printfunction2(k,cellcount,count,x,locs,descrips,fid,i,j);
                end
                if(j~=r && i~=r)
                    submat=this_frame(indexati:indexati-1+q1,indexatj:indexatj-1+q2);    
                    [image, descrips, locs] = sift(submat);
                    [x,y]=size(locs);
                    printfunction2(k,cellcount,count,x,locs,descrips,fid,i,j);
                end
                indexati=indexati+q1;
            cellcount=cellcount+1;
            end
            indexatj=indexatj+q2;
        end
     end
     count=count+1;
end
fclose(fid);

