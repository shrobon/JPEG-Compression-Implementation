%----------------------------------------------------------
% Author: Shrobon Biswas
% Student ID : 1505851
% Organization : University of Alberta
% Date: 2016 - November-18
% JPEG decoder for a [ Grayscale Image ] 
%----------------------------------------------------------


%----------------------------------------------------------
% clearing interpreter and workspace
%----------------------------------------------------------
clc;
clear;

%-----------------------------------------
% Reading the files created by encoder :::
%-----------------------------------------
dimm=  dlmread('dimm.txt'); % contains the height and width of an image
diff = dlmread('dc_coefficient.txt'); % contains the difference coded DC values
ac = dlmread('ac_coefficient.txt'); %contains the RLE ac_coefficient values


%-------------------------
% INITIALIZATION BLOCK
%-------------------------
a=length(ac);
row = dimm(1);
coln = dimm(2);
dc_counter = 0;
temp_ac= [];
col_zigs = [];
dc = [];
dc(1)= diff(1);


%---------------------------------------
% Decoding the differnce coded DC values
%---------------------------------------
for i=drange(2,(row*coln)/64)
    dc(i)= diff(i)+dc(i-1);
end

dct_quantized = zeros(row,coln);
row_index  = 1;
col_index  = 1;
%----------------------------------------------
% Decoding and forming the DCT quantized Matrix
%----------------------------------------------

for i = drange(1:a)
    
    if ac(i)~=999
        temp_ac=[temp_ac,ac(i)];
    end
    
    if ac(i)==999
        inverse_rle = irle(temp_ac);
        temp_ac = [];
        dc_counter= dc_counter+1;
        dc_value  = dc(dc_counter);
        tot_block=[dc_value,inverse_rle];
        inverse_zigzag = invzigzag(tot_block,8,8);
        
        if col_index > coln 
            row_index= row_index+8;
            col_index= 1;
            dct_quantized(row_index:row_index+7,col_index:col_index+7)=inverse_zigzag;
            col_index = col_index+8;
            
        else
            dct_quantized(row_index:row_index+7,col_index:col_index+7)=inverse_zigzag;
            col_index = col_index+8;
        end
        
        if row_index >row
            break;
        end
    end
end

%----------------------------------------------
% Quantization Table :: Obtained from Wikipedia 
%----------------------------------------------

Qtable = [ 16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62; 
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];

     QX = Qtable;
     
     
DCT = dct(eye(8));
IDCT = DCT'; 

%-----------------------------------------------------------
% Dequantization of DCT Coefficients
%-----------------------------------------------------------
for i1=[1:8:row]
    for i2=[1:8:coln]
        win2 = dct_quantized(i1:i1+7,i2:i2+7);
        win3 = win2.*QX;
        dct_dequantized(i1:i1+7,i2:i2+7) = win3;
    end
end
%-----------------------------------------------------------
% Inverse DISCRETE COSINE TRANSFORM
%-----------------------------------------------------------
for i1=[1:8:row]
    for i2=[1:8:coln]
        win3 = dct_dequantized(i1:i1+7,i2:i2+7);
        win4=IDCT*win3*DCT;
        dct_restored(i1:i1+7,i2:i2+7)=win4;
    end
end
I2=dct_restored;
K=mat2gray(I2);


%----------------------------------------------------------
%Decoded JPEG Image
%----------------------------------------------------------
figure(2);imshow(K);title('restored image from dct');


