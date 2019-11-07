%% test_HSI_image_ectraction.m
%% 각 종자의 객체 인식 및 저장

% 특정 폴더 내부에 있는 초분광 파일을 'numbers'개까지 불러온다.
% name은 문자형으로 작성 예)name='2x*.HDR';
% 예) numbers = 11 %폴더 내부에 name으로 불러들인 파일중 11개 까지 불러옴
% image_lines= 스캔수
% resize_value는 영상데이터의 2차원(가로세로)의 크기를 축소 또는 크게해줌
% ex) resize_value는=0.1(1/10 축소) or 1(원본 크기) or 2(2배크기) 

%   자세한 설명 위치
%%

clear all
close all
clc

name='plate1';
white_name='white';
dark_name='dark';
numbers=1;
resize_value=1;

%     f = waitbar(0,'Please wait...');
%     ti=1/(numbers);
save_number=1;
    
for FN=1:numbers%length(filelist)불러올 갯수 설정
FN

spectral_image1=SWIR_images_resize2(dark_name,white_name,name,830,1);
spectral_image(:,:,:)=fliplr(spectral_image1(:,40:740,:));% 좌우 대칭 변환
%spectral_image = imrotate(spectral_image1,90)

mFn(:,:,1)= medfilt2(spectral_image(:,:,80,1));
figure(100)
imshow(mFn,[])
Filtering_Mask(:,:,1)=Masking_swir(mFn,mFn,30,150);
Filtering_Mask(:,:,1)=bwareaopen(Filtering_Mask(:,:,1),250);

%% 종자별 라벨링
label_data=Filtering_Mask(:,:,1);
[L,n]=bwlabel(label_data);
center_point=zeros(n,2);
figure(115),imshow(label_data)
hold on
for k=1:n
    [r, c]=find(L==k);
    center_point(k,:)=[mean(c),mean(r)];
%     center_point(i,2)=mean(r);
    plot(center_point(k,1),center_point(k,2),'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10);
    plot(center_point(k,1),center_point(k,2),'Marker','*','MarkerEdgeColor','W');
end

%% 5*7 종자 배열의 위치별 오름차순 정렬
center_point=sortrows(center_point,1);
for k=1:(n/5)
    center_point((5*k-4):(5*k),:)=sortrows(center_point((5*k-4):(5*k),:),2);
%     if k==7
%         center_point((5*k-4):(5*k)-1,:)=sortrows(center_point((5*k-4):(5*k)-1,:),2);% 마지막 열에 한개가 없으로 -1
%     end
end

%% pc1 객체인식 및 데이터 출력

for k=1:n
    L_point(k,:)=round([center_point(k,1)-29,center_point(k,2)-29,center_point(k,1)+30,center_point(k,2)+30]);% vis nir파일 기준으로 +-30 픽셀 추출
%     figure(k+10),imshow(pca2_image1(L_point(k,2):L_point(k,4),L_point(k,1):L_point(k,3)),[])
end

%% 종자 데이터 추출 및 저장
% k1=1;
% k2=1;
saving_folder='/Users/kimhangi/Data/Project/test'; % 저장 위치

% k3=1;
for k=1:n
    for i=1:length(spectral_image(1,1,:))
        selected_data(:,:,i)=spectral_image(L_point(k,2):L_point(k,4),L_point(k,1):L_point(k,3),i);
    end
    
    for i=1:length(spectral_image(1,1,:))
        selected_data(:,:,i)=mat2gray(selected_data(:,:,i),[0 100]).*label_data(L_point(k,2):L_point(k,4),L_point(k,1):L_point(k,3));
				%% 음수 제거 및 영상 데이터의 8비트화
    end
  
%     selected_data2=cat(3,selected_data(:,:,1),selected_data(:,:,2),selected_data(:,:,3));
    selected_data3=imresize(selected_data,resize_value,'lanczos3');% nearest, bilinear,bicubic(디폴트),box,triangle,cubic,lanczos2,lanczos3
    selected_data3_mask=imresize(label_data(L_point(k,2):L_point(k,4),L_point(k,1):L_point(k,3)),resize_value,'lanczos3');
    
    [g1 g2]=find(selected_data3_mask~=0);
    for i=1:length(g1)
        selected_data3_mask(g1(i,1),g2(i,1))=1;
    end
    %     figure(save_number),imshow(selected_data3)
    for i=1:length(spectral_image(1,1,:))
        selected_data3_1(:,:,i)=selected_data3(:,:,i).*selected_data3_mask;%% 음수 제거 및 영상 데이터의 8비트화
    end
    
    figure(100),imshow(selected_data3_mask)
    figure(101),imshow(selected_data3_1(:,:,50),[])
        clear g1 g2 selected_data3_mask 
    
    name2=strcat(name,'_',num2str(save_number),'.mat');
    full_destination = fullfile(saving_folder,name2);
%     imwrite(selected_data3,full_destination)
    save(full_destination, 'selected_data3_1','-v6')
    save_number=save_number+1;
    
        clear selected_data3 selected_data selected_data3_1

end
 
%     if FN==1
%         waitbar(ti,f,'Control Please wait...');
%         ti2=ti;
%     elseif FN>1
%         ti2=ti2+ti;
%         waitbar(ti2,f,'Control Please wait...');
%     end
end
data_results2='end'
% close(f)
% for i=1:275
% figure(i),imshow(selected_data3_1(:,:,i),[])
% end