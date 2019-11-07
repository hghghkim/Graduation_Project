%%SWIR_images_resize2.m

function[spectral_image]=SWIR_images_resize(D,W,Y,Z,V)
% D는 dark 영상 파일명(문자)
% W는 white 영상 파일명(문자)
% Y는 측정 샘플 초분광 영상 파일명(문자)
% Z는 측정 샘플 초분광 영상의 스캔수(숫자)
% V는 이미지 사이즈 축소값 0~1사이 값이며, 0.1일 경우 영상의 1/10으로 축소됨(숫자)

%%    Input Hyperspectral Object Image filename (file) samples
input_file1 = Y;
headfile1 = strcat(input_file1, '.hdr');
imfile1 = strcat(input_file1,'.img');

% Read head file
     fid=fopen(headfile1);
     c=textscan(fid, '%s %s %s');
     fclose(fid);

% Read samples, lines, and bands number of headfile
     samples = str2double(char(c{3}(4))); %정해진 카메라 스펙
%    samples = samples_range;             %세로
     lines = str2double(char(c{3}(5)));
     bands = str2double(char(c{3}(6)));
     wavelength_orign=c{1}(23:297);
     wavelength=str2double(strrep(wavelength_orign,',',''));


% Wavelength, Samples, Line, Band counting, 
     [fid1,msg1] = fopen(imfile1,'r');
     [NormalData, count]= fread(fid1, [samples, lines*bands], 'uint16');
     fclose(fid1);

%   If you change samples range
%   Original image range = [1:320]
%   Original image length = 320
%
samples_range=[1:384];
samples_total_length=384;
bands_range_cut3=size(wavelength,1);
     
%%   Input Hyperspectral White Image filename (file) 
input_file2 = W; 
headfile2 = strcat(input_file2, '.hdr'); 
imfile2 = strcat(input_file2,'.img'); 

%   Read White head file
fid2=fopen(headfile2);
c2=textscan(fid2, '%s %s %s');
fclose(fid2);

% band_count1=size(bands_range1,2);
% band_count2=size(bands_range2,2);
%    Read White samples, lines, and bands number of headfile
samples_white = str2double(char(c2{3}(4))); %정해진 카메라 스펙
lines_white = str2double(char(c2{3}(5)));
bands_white = str2double(char(c2{3}(6)));


% White average
[fid2,msg2] = fopen(imfile2,'r');
[NormalData2, count2]= fread(fid2, [samples_white, lines_white*bands_white], 'uint16');
fclose(fid2);


% NormalData2=abs(NormalData2);
% white image's each wavelength intensity graph(원본이미지와 white,dark의lines 수가
% 같을때 쓰인다.
for ib = 1:bands_range_cut3
    for il = 1:lines
         BandImage(samples_range,lines-il+1) = NormalData2(samples_range,ib);
     end
     www(:,:,ib) = BandImage;
end

%% Read Black head file

input_file3 = D;
headfile3 = strcat(input_file3, '.hdr');
imfile3 = strcat(input_file3,'.img');


fid3=fopen(headfile3);
c3=textscan(fid3, '%s %s %s');
fclose(fid3);

% Read Black samples, lines, and bands number of headfile
samples_Black = str2double(char(c3{3}(4))); %정해진 카메라 스펙
%samples = samples_range;
lines_Black = str2double(char(c3{3}(5)));
bands_Black = str2double(char(c3{3}(6)));

% Black average
[fid3,msg3] = fopen(imfile3,'r');
[NormalData3, count3]= fread(fid3, [samples_Black, lines_Black*bands_Black], 'uint16');
fclose(fid3);

% Black image's each wavelength intensity graph
for ib = 1:bands_range_cut3
    for il = 1:lines
         BandImage(samples_range,lines-il+1) = NormalData3(samples_range,ib);
     end
     bbb(:,:,ib) = BandImage;
end


%% Object, white, black data calibration
%% 3-d and 2-d variables to storehold the image

     I = zeros(samples_total_length, lines, bands); 
     BandImage = zeros(samples_total_length, lines);
     minus = zeros(samples_total_length, lines, bands);
     nII = imresize(zeros(samples_total_length, lines, bands),V); 

% image show in each wavebands( ib=bands, 
         
for ib = 1:bands_range_cut3
    for il = 1:lines
         BandImage(samples_range,lines-il+1) = NormalData(samples_range,(il-1)*bands + ib);
     end
     I(:,:,ib) = BandImage;
     nII(:,:,ib)= imresize((I(:,:,ib) - bbb(:,:,ib) +0.0001)./(www(:,:,ib)-bbb(:,:,ib) +0.0001)*100,V);
end
spectral_image=nII;