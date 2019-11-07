%%Masking swir
function[Filtering_Mask]=Masking_swir(mFn1,mFn2,mask_th1,mask_th2) % medfilt2(spectral_image(:,:,80,1)) 30 150

[xxm yym]=find(mFn1 < mask_th1); % mFn1에서 mask_th1보다 작은 값을 찾음  
[xxm1 yym1]=find(mFn2 >= mask_th2); % mFn2에서 mask_th2보다 큰값을 찾음  
leng_xxm = length(xxm);
leng_xxm1 = length(xxm1);
[mFn_x mFn_y]=size(mFn1);
tmBW1=ones([mFn_x mFn_y]); %기본 이미지의 크기로 1인 값을 만든다.
for ixm = 1:leng_xxm
    tmBW1(xxm(ixm), yym(ixm)) = 0; % mFn1에서 mask_th1보다 큰값을 0으로 바꿈
end
for ixm1 = 1:leng_xxm1
    tmBW1(xxm1(ixm1), yym1(ixm1)) = 0; % mFn2에서 mask_th2보다 큰값을 1으로 바꿈
end

Filtering_Mask=tmBW1;
end