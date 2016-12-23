
%----------------------------------------------------------
% Author: Shrobon Biswas
% Student ID : 1505851
% Organization : University of Alberta
% Date: 2016 - November-18
% JPEG encoder for a [ Grayscale Image ] 
%----------------------------------------------------------


%----------------------------------------------------------
% clearing interpreter and workspace
%----------------------------------------------------------
clc;
clear;

%----------------------------------------------------------
% User gets an image chooser
%----------------------------------------------------------
[filename,pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif'});
IMAGE = imread(fullfile(pathname,filename));

%Just to make full-proof, convert to grayscale if RGB selected
[row,coln,dim] = size(IMAGE);
dct_restored = zeros(row,coln);
if dim ~=1
    image = rgb2gray(IMAGE);
end
I1=IMAGE;

%--------------------------------------------------------------------
% Since DCT part involves Block by block operations,
% We have to check if the row and columns are divisible by 8
% If not, then zero padding is performed to so that row & col are divisible
% by 8.
% Resizing the image to the divisible dimentions, seems a better idea. 
%---------------------------------------------------------------------


if mod(row,8)~=0
  size=mod(row,8);
  rsize = 8-size;
  row = row+rsize;
end

if mod(coln,8)~=0
  size=mod(coln,8);
  csize = 8-size;
  coln = coln+csize;
end





IMAGE= imresize(IMAGE,[row coln]);
imshow(uint8(IMAGE));
IMAGE= double(IMAGE);


zig = [];
diff_coding=[];
dc_coefficient=[];
ac_coefficient=[];


%----------------------------------------------------------
% Quantization Table :: Obtained from Wikipedia 
%----------------------------------------------------------
Qtable = [ 16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62; 
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];

%------------------------------------------
% Obtaining DCT and Inverse DCT Matrix
%------------------------------------------
DCT = dct(eye(8));
iDCT = DCT';

dct_restored = zeros(row,coln);
QX = double(Qtable);


%----------------------------------------------------------
% Computing Resultant Matrix :: Block by Block
%----------------------------------------------------------

for i1=[1:8:row]
    for i2=[1:8:coln]
        zBLOCK=IMAGE(i1:i1+7,i2:i2+7);
        win1=DCT*zBLOCK*iDCT;
        dct_domain(i1:i1+7,i2:i2+7)=win1;
    end
end




%-----------------------------------------------------------
% Quantization of the DCT 
%-----------------------------------------------------------
for i1=[1:8:row]
    for i2=[1:8:coln]
        win1 = dct_domain(i1:i1+7,i2:i2+7);
        win2=round(win1./QX);
        dct_quantized(i1:i1+7,i2:i2+7)=win2;
        
        temp= zigzag(dct_quantized(i1:i1+7,i2:i2+7));
        temp_order = reshape(temp,[8,8]);
        zig(i1:i1+7,i2:i2+7) = temp_order; 
        dc_coefficient =[dc_coefficient,temp(1)];
        
        run_length_encoded_ac=rle(temp(2:64));
        ac_coefficient = [ac_coefficient,run_length_encoded_ac,999];
        %the 999 value used above will be used as a delimiter value for
        %decoding
    end
end


%-----------------------------------------------------------
% Performing Difference Coding on the DC components
%-----------------------------------------------------------
diff_coding(1)= dc_coefficient(1); 
for IMAGE=drange(2:(row*coln)/64)
    diff_coding(IMAGE)= dc_coefficient(IMAGE) - dc_coefficient(IMAGE-1);
end


%-----------------------------------------------------------
% Writing the encodings to separate files
%1. dimm.txt contains the rows and columns
%2. dc_coefficient.txt contains the dc_coefficient values
%3. ac_coefficient.txt contains the ac_coefficient values
% These files will be used by the decoder function
%-----------------------------------------------------------
dlmwrite('dimm.txt',row);
dlmwrite('dimm.txt',coln,'-append');

dlmwrite('dc_coefficient.txt',diff_coding);
dlmwrite('ac_coefficient.txt',ac_coefficient);


