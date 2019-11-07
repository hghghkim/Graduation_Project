% clear all, close all, clc;

Total_Correct_percent=30;
Total_Correct_percent1=30;


h = waitbar(0,'Please wait...');
steps = 10;% # times to loop

for nnn1=1:steps
    close all
    if (round(Total_Correct_percent)>=85)&&(round(Total_Correct_percent1)>=95)%validation, calibration max accuracy
        return
        close all;

    else
        cal_val
        PLS_DA
        
      

    end
    
    TT(:,nnn1)=cat(2,Total_Correct_percent1,Total_Correct_percent);
    
    TT(:,nnn1)
    
    waitbar(nnn1/steps)
end
close(h)