function printfunction2(numFrames,cellcount,count,x,locs,descrips,fid,i,j)

%     fprintf(fid,'Sift Vectors for// Cell(%d,%d)\n\n',i,j);
    count
    if(x==0)
        
        
%         fprintf(fid,'0 keypoints so no sift vectors\n\n');  
    else
        for i=1:x
            
                    fprintf(fid,' %d, %d, %d, ',count,numFrames,cellcount);

%             fprintf(fid,'[ ');
            for j=1:4
            fprintf(fid,' %.6f,',locs(i,j));
            end
            for k=1:128
                if(k==128)
                    fprintf(fid,' %.6f',descrips(i,k));
                else
                    fprintf(fid,' %.6f,',descrips(i,k));
                end
                
            end
            fprintf(fid,'\n');
        end
    end
end