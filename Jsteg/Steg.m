
A=imread('kinkakuji01.jpg');
I=rgb2gray(A); %RGBͼת��Ϊ�Ҷ�ͼ
imwrite(I,'kinkakuji01g.jpg','quality',100);
originobj= jpeg_read('kinkakuji01g.jpg');
activedobj=originobj;
subplot(2,2,1)
histogram(originobj.coef_arrays{1,1});%display Frequency distribution histogram
title("Original Frequency distribution histogram");
plain='010000010110001101110010011011110111001101110011001000000111010001101000011001010010000001000111011100100110010101100001011101000010000001010111011000010110110001101100001000000101011101100101001000000110001101100001011011100010000001010010011001010110000101100011011010000010000001000101011101100110010101110010011110010010000001000011011011110111001001101110011001010111001000100000011011110110011000100000011101000110100001100101001000000101011101101111011100100110110001100100001000000101010100110010001100000011000100110110001100010011010000111000001101000011100000001010';%Across the Great Wall We can Reach Every Corner of the World U201614848
ran=rng(7742085);%Seed No repeat in this seed

%DCT Table's Size=256*400
randtable=randperm(256*400);
FrequencyStatic=tabulate(randtable(:));
RandTableIndex=1;
index=1;
while index<=length(plain)
    %Get Location
    location=randtable(RandTableIndex);
    %Try to Resolve
    row=ceil(location/400);
    column=mod(location,400)+1;
    %Try to Replace
    if activedobj.coef_arrays{1,1}(row,column)==0||activedobj.coef_arrays{1,1}(row,column)==1
        %Fail to Fetch, Throw
        RandTableIndex=RandTableIndex+1;%Fetch the Next One
        continue
    end

    if plain(index)=='1'
         
        if mod(activedobj.coef_arrays{1,1}(row,column),2)==0%Even
            
           activedobj.coef_arrays{1,1}(row,column)=activedobj.coef_arrays{1,1}(row,column)+1;%eg. -4->-3,2->3
           
           %fprintf("1,+1");
        end
        %Odd Number Won't Be Changed
        index=index+1;
        %Debug
        fprintf("1-RandTableIndex%d\tLocation%d\n",RandTableIndex,randtable(RandTableIndex));
        RandTableIndex=RandTableIndex+1; 
        continue%Warning: Unknown Bug, Patched temporarily
    end
   
    if plain(index)=='0'
        location=randtable(RandTableIndex);%Unknown bug occurred. Patch it temporarily
        if mod(activedobj.coef_arrays{1,1}(row,column),2)==1%Odd
           activedobj.coef_arrays{1,1}(row,column)=activedobj.coef_arrays{1,1}(row,column)-1;%eg.-3->-4,3->2
           %fprintf("0,-1");
        end
        %Even Number Won't Be Changed
        index=index+1;
        %Debug
        fprintf("0-RandTableIndex%d\tLocation%d\n",RandTableIndex,randtable(RandTableIndex));
        RandTableIndex=RandTableIndex+1; 
    end 
   
end
subplot(2,2,2)
histogram(activedobj.coef_arrays{1,1});%display Frequency distribution histogram
title("Current Frequency distribution histogram");

result=isequal(originobj.coef_arrays{1,1},activedobj.coef_arrays{1,1});
jpeg_write(activedobj,'kinkakuji-Jsteg.jpg');
%Show DCT coefficient histogram
Aft=imread('kinkakuji-Jsteg.jpg');
subplot(2,2,3)
imhist(I);
title("DCT coefficient histogram-1");

subplot(2,2,4)
imhist(Aft);
title("DCT coefficient histogram-2");

