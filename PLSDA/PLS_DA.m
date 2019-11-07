
clear all, close all, clc

delete('Cal_accuracy.txt');
delete('Val_accuracy.txt');
delete('PLS_results.txt');
delete('beta.xlsx');


size_spectrum1 = xlsread('New_SWIR_wavelength.xlsx');
wavelength1 = size_spectrum1(:,1)';
wave_range = '2:275';

rowdata1 = xlsread('Cal_new_2.xlsx');
rowdata2 = rowdata1(:,str2num(wave_range));

Prediction_data1 = xlsread('Val_new_3.xlsx');
Prediction_data2 = Prediction_data1(:,str2num(wave_range));

% sample=Prediction_data2;%prediction data
% training=rowdata2;% calibration data
% 
% group=rowdata1(:,1); %calibration group labels
% pr_group=Prediction_data1(:,1);%validation group labels


%  M = 3;
%  rowdata2 = smoothing_mean(rowdata2,M);
%  Prediction_data2 = smoothing_mean(Prediction_data2,M);
%  
 
 %% if data set has same number of samples
%  cal=0.5*size(rowdata2,1);
%  test=0.5*size(Prediction_data2,1);
%  
 %% if not
 cal =186;
 test = 84;
 
 %%
for k = 7;
    
    if k==1;
% 1. Mean normalization
        [P_rowdata] = Mean_normalize (rowdata2);     
         P_rowdata = cat(2,rowdata1(:,1),P_rowdata);
        [Prediction_data3] = Mean_normalize (Prediction_data2);     
         Prediction_data3 = cat(2,Prediction_data1(:,1),Prediction_data3);
         
    elseif k==2;
% 2. Maximum normalization
        [P_rowdata] = Max_normalize (rowdata2);   
         P_rowdata = cat(2,rowdata1(:,1),P_rowdata);
        [Prediction_data3] = Max_normalize (Prediction_data2);     
         Prediction_data3 = cat(2,Prediction_data1(:,1),Prediction_data3);
         
    elseif k==3;
% 3. Range normalization
        [P_rowdata] = Range_normalize (rowdata2); 
         P_rowdata = cat(2,rowdata1(:,1),P_rowdata);
        [Prediction_data3] = Range_normalize (Prediction_data2);     
         Prediction_data3 = cat(2,Prediction_data1(:,1),Prediction_data3);
         
    elseif k==4;
% 4. MSC
        [P_rowdata] = MSC (rowdata2); 
         P_rowdata = cat(2,rowdata1(:,1),P_rowdata);
        [Prediction_data3] = MSC (Prediction_data2);     
         Prediction_data3 = cat(2,Prediction_data1(:,1),Prediction_data3);

    elseif k==5;
% 5. SNV
        [P_rowdata] = SNV (rowdata2); 
         P_rowdata = cat(2,rowdata1(:,1),P_rowdata);
        [Prediction_data3] = SNV (Prediction_data2);     
         Prediction_data3 = cat(2,Prediction_data1(:,1),Prediction_data3);


    elseif k==6;
% 6. Savitzky_Golay_1st
        [P_rowdata] = Savitzky_Golay_1st (rowdata2); 
         P_rowdata = cat(2,rowdata1(:,1),P_rowdata);
        [Prediction_data3] = Savitzky_Golay_1st (Prediction_data2);     
         Prediction_data3 = cat(2,Prediction_data1(:,1),Prediction_data3);
         
    elseif k==7;
% 7. Savitzky_Golay_2st
        [P_rowdata] = Savitzky_Golay_2nd (rowdata2); 
         P_rowdata = cat(2,rowdata1(:,1),P_rowdata);
        [Prediction_data3] = Savitzky_Golay_2nd (Prediction_data2);     
         Prediction_data3 = cat(2,Prediction_data1(:,1),Prediction_data3);

% 8. raw
    elseif k==8;
        [P_rowdata] = rowdata2; 
         P_rowdata = cat(2,rowdata1(:,1),P_rowdata);
        [Prediction_data3] = Prediction_data2;     
         Prediction_data3 = cat(2,Prediction_data1(:,1),Prediction_data3);
       

%9. Smoothing
    elseif k==9;
        [P_rowdata] = smoothing_mean(rowdata2,M); 
         P_rowdata = cat(2,rowdata1(:,1),P_rowdata);
        [Prediction_data3] = smoothing_mean(Prediction_data2,M);     
         Prediction_data3 = cat(2,Prediction_data1(:,1),Prediction_data3);
       
    end

   [Rc2,SEC,Rp2,SEP,PCn,Prediction_value,Prediction_R2,Prediction_SEP,Opimal_PCn1,BETA2,Cal_Prediction_value] = PLS_DA_SIMPLS (P_rowdata,Prediction_data3);

   
 
%    %% svm model
% [classes,classCV,score,scoreCV,CVSVMModel,outlierRate,aa,t_aa,u_aa,aa1,t_aa1,u_aa1,beta,bias,sv_indices,n,sensitivity,specificity,sensitivity1,specificity1,svmStruct] = colsvm(P_rowdata,Prediction_data3,group,pr_group); 
% %open function colsvm to adjsut function to suit data //linear SVM//
% %redefine if need be
%    %cross validation
% 
%   figure(),h1 = gscatter(group, scoreCV(:,2), group,'rb','o^',8,'off');
%     set(h1,'LineWidth',1.5)
%     xlim([-0.5 1.5]); 
%     xlabel('Actual values')
%     ylabel('Predicted values')
%     legend('treated','untreated','Location','NW')
%     title('K-Fold Crossvalidation')
%     
%     %prediction plot
%   figure(),h1 = gscatter(pr_group, score(:,2), pr_group,'rb','o^',8,'off');
%     set(h1,'LineWidth',1.5)
%     xlim([-0.5 1.5]); 
%     xlabel('Actual values')
%     ylabel('Predicted values')
%     legend('treated','untreated','Location','NW')
%     title('SVM Prediction')
%    
%     % cross validation
%     %         treated group
% cvcorrect_treated=t_aa1*cal;
% cvmisclas_treated=cal-cvcorrect_treated;
% 
% %         untreated group
% cvcorrect_untreated=u_aa1*cal;
% cvmisclas_untreated=cal-cvcorrect_untreated;
% 
%    
%         
%   CVmodel_results = cat(2,cal,cvcorrect_treated,cvmisclas_treated,cvcorrect_untreated,cvmisclas_untreated,(100*t_aa1),(100*u_aa1),(100*aa1));
%  CVclassification_results = cat(2,sensitivity1,specificity1);
%   
%   dlmwrite('CVmodel_results_SVM.txt', CVmodel_results, 'delimiter', '\t', 'newline', 'pc', '-append');
%         dlmwrite('CVclassification_results_SVM.txt', CVclassification_results, 'delimiter', '\t', 'newline', 'pc', '-append');
%     
%     %validation
% %         treated group
% correct_treated=t_aa*test;
% misclas_treated=test-correct_treated;
% 
% %         untreated group
% correct_untreated=u_aa*test;
% misclas_untreated=test-correct_untreated;
% 
%    
%         
%   model_results = cat(2,cal,test,correct_treated,misclas_treated,correct_untreated,misclas_untreated,(100*t_aa),(100*u_aa),(100*aa));
%   classification_results = cat(2,n,bias,sensitivity,specificity);
%         
%         
%       
%         dlmwrite('model_results_SVM.txt', model_results, 'delimiter', '\t', 'newline', 'pc', '-append');
%         dlmwrite('classification_results_SVM.txt', classification_results, 'delimiter', '\t', 'newline', 'pc', '-append');
%    
%    %% for LDA
%    % LDA Model
% [dm,inverse_cov_matrix,BETA2,Prediction_value] = LDA_collins (P_rowdata,Prediction_data3,group,pr_group);
% %open function colda to adjsut function to suit data
% %//'DiscrimType','diagLinear','SaveMemory','on'// redefine if need be
% 
%    
% %     %classisfication plot
%    figure(),h1 = gscatter(pr_group, Prediction_value, pr_group,'rb','o^',8,'off');
%     set(h1,'LineWidth',1.5)
%     xlim([-0.5 1.5]); 
%     xlabel('Actual values')
%     ylabel('Predicted values')
%     legend('treated','untreated','Location','NW')
%     title('Classification')
%     
%     
%     base=0.65; %give appropriate value betwween 1 and 0
%     
% predicted_groups=double(im2bw(Prediction_value,base));
% 
% % treated group
% misclas_treated1=sum(predicted_groups(1:test,:));
% correct_treated1=test-misclas_treated1;
% t_bb=(correct_treated1)/test;
% 
% %         untreated group
% correct_untreated1=sum(predicted_groups((test+1):end,:));
% misclas_untreated1=test-correct_untreated1;
% u_bb=(correct_untreated1)/test;
% 
% bb=0.5*(t_bb+u_bb);
% 
%    
%         
%   model_results1 = cat(2,cal,test,correct_treated1,misclas_treated1,correct_untreated1,misclas_untreated1,(100*t_bb),(100*u_bb),(100*bb));
% %   classification_results1 = cat(2,sensitivity1,specificity1);
%         
% %  sigma=obj.Sigma;
%       
%         dlmwrite('model_results_LDA.txt', model_results1, 'delimiter', '\t', 'newline', 'pc', '-append');
% %         dlmwrite('classification_results_LDA.txt', classification_results1, 'delimiter', '\t', 'newline', 'pc');
   %%
%plot for calibration
    figure(k),h1 = gscatter(rowdata1(:,1), Cal_Prediction_value, rowdata1(:,1),'rb','v^',4,'off');
    set(h1,'LineWidth',1.5)
%     annotation('textbox', [0.68 0.13 0.21 0.07],'String',{'Baseline = 0.5'},'FontSize',12, 'FontName','Times New Roman','FontWeight', 'bold');
    %(starting point of box, distant from base of the box, inside space, distance from lower
    %line and lower part of writing inside the box)
    xlim([-0.5 1.5]); 
    xlabel('Actual values')
    ylabel('Predicted values')
    legend('Treated','Untreated','Location','NW')
    title('Classification for Calibration')
    
    % plot for validation
%  
    figure(k),h1 = gscatter(Prediction_data1(:,1), Prediction_value, Prediction_data1(:,1),'rb','v^',4,'off');
    set(h1,'LineWidth',1.5)
%     annotation('textbox', [0.68 0.13 0.21 0.07],'String',{'Baseline = 0.5'},'FontSize',12, 'FontName','Times New Roman','FontWeight', 'bold');
    %(starting point of box, distant from base of the box, inside space, distance from lower
    %line and lower part of writing inside the box)
    xlim([-0.5 1.5]); 
    xlabel('Actual values')
    ylabel('Predicted values')
    legend('Non-viable','Viable','Location','NW')
    title('Classification for Validation')
   
    
    
%     % plot for validation
%   figure(k),h1 = gscatter(Prediction_data1(:,1), Prediction_value, Prediction_data1(:,1),'rb','o^',8,'off');
%         
%     
    [s1 s2] = size(Prediction_data1(:,1));
%     
%      test = Numbers of non-viable samples in test (validation)set  
%         test =259;
    
         baseline = 0.5;% change baseline according to the sample in calib and valid
                         
            Correct_value = zeros(s1,1);
        
        for ia = 1:test
            if Prediction_value(ia,1) < baseline;
                Correct_value(ia,1) = 1;
            else
                Correct_value(ia,1) = 0;
            end
        end
        
        for ia = test +1 : s1
            if Prediction_value(ia,1) > baseline;
                Correct_value(ia,1) = 1;
            else
                Correct_value(ia,1) = 0;
            end
        end
        
         Non_ct_percent = (sum(Correct_value(1:test)) / (test))*100;
        ct_percent = (sum(Correct_value(test+1:end)) / (s1-test))*100;
        Total_Correct_percent = (sum(Correct_value) / s1)*100;
        
        Num_Non_ct = sum(Correct_value(1:test));
        Num_ct = sum(Correct_value(test+1:end));
        
        results = cat(2,Rc2,SEC,Rp2,SEP,Prediction_R2,Prediction_SEP,PCn);
        
        [s11 s12] = size(rowdata1(:,1));
        
        %cal = Numbers of non-viable samples in calibration set
%     cal=517;
    
     baseline1 = 0.5;
        Correct_value1 = zeros(s11,1);
        
        
        for ib = 1:cal
            if Cal_Prediction_value(ib,1) < baseline1;
                Correct_value1(ib,1) = 1;
            else
                Correct_value1(ib,1) = 0;
            end
        end
        
        for ib = cal +1 : s11
            if Cal_Prediction_value(ib,1) > baseline1;
                Correct_value1(ib,1) = 1;
            else
                Correct_value1(ib,1) = 0;
            end
        end
        
        Non_ct_percent1 = (sum(Correct_value1(1:cal)) / (cal))*100;
        ct_percent1 = (sum(Correct_value1(cal+1:end)) / (s11-cal))*100;
        Total_Correct_percent1 = (sum(Correct_value1) / s11)*100;
        
        Num_Non_ct1 = sum(Correct_value1(1:cal));
        Num_ct1 = sum(Correct_value1(cal+1:end));
        
        Cal_results = cat(2,s11, Num_Non_ct1,Num_ct1,Non_ct_percent1,ct_percent1,Total_Correct_percent1);
        Val_results = cat(2,s1, Num_Non_ct,Num_ct,Non_ct_percent,ct_percent,Total_Correct_percent);

        dlmwrite('PLS_results.txt', results, 'delimiter', '\t', 'newline', 'pc', '-append');
        dlmwrite('Cal_accuracy.txt', Cal_results, 'delimiter', '\t', 'newline', 'pc', '-append');
        dlmwrite('Val_accuracy.txt', Val_results, 'delimiter', '\t', 'newline', 'pc', '-append');


    disp(Total_Correct_percent1)
    disp(Total_Correct_percent)

end




%calibration data plot
Mean_raw = P_rowdata(1:cal,2:end);
Mean_Nonraw = P_rowdata(cal+1:end,2:end);


 figure(10),plot(wavelength1(str2num(wave_range)),Mean_raw,'LineWidth',1.5);

hold on
figure(10),plot(wavelength1(str2num(wave_range)),Mean_Nonraw,'LineWidth',1.5);
xlabel('Wavelength(nm)')
ylabel('Log(1/R)')
xlim([900 2500]); 


%[sr sc] = size(P_rowdata);
     
% Calibaration data mean plot
Mean_Non_ct = mean(Mean_raw,1);
Mean_ct = mean(Mean_Nonraw,1);
figure(11), plot(wavelength1(str2num(wave_range)),Mean_Non_ct,'r','LineWidth',2)
hold on
figure(11), plot(wavelength1(str2num(wave_range)),Mean_ct,'b','LineWidth',2)
legend('treated','Untreated','Location','NW')
xlim([900 2500])
 
xlabel('Wavelength(nm)')
ylabel('Log(1/R)')

beta1 = BETA2(2:end,1)';
%   
% plot for Beta coefficient        
figure(12), plot(wavelength1(str2num(wave_range)),beta1,'b','LineWidth',1)
legend('Beta coefficients curve of PLS model','ct','Location','NW')
xlim([900 2500])
xlabel('Wavelength(nm)')
ylabel('Log(1/R)')

 %test_value=[Prediction_value Prediction_data1(:,1)];
% xlswrite('prediction_value.xlsx', test_value);

% cal_value=[Cal_Prediction_value rowdata1(:,1)];
% xlswrite('calibration_value.xlsx', cal_value);
b1=BETA2';
xlswrite('beta_use_it.xlsx',b1);


%test_value=[Prediction_value Prediction_data1(:,1)];
% xlswrite('prediction_value.xlsx', test_value);

% cal_value=[Cal_Prediction_value rowdata1(:,1)];
% xlswrite('calibration_value.xlsx', cal_value);


