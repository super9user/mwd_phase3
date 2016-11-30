function array = frameVideos()
dir_video_list=dir('*.mp4'); %the videos must be in the same folder
list_size=length(dir_video_list);
count=1;
array=[];
for i=1 :list_size %for all videos
     video_name=dir_video_list(i).name;
     obj= VideoReader(video_name); 
     numFrames=obj.NumberOfFrames;
     for j=1:numFrames
        temp=horzcat(array,frameObject(i,j));
        array=temp;
        count=count+1;        
     end
end
end