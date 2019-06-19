F=create_mat_dct();
I=imread('cameraman.tif');
J=imresize(I,[8 8]);
J=im2double(J);

I2=myDCT(J,F);
imshow(I2);
figure;

I3=myIDCT(I2,F);
imshow(I3);
figure;

%Q50
qm=[16 11 10 16 24 40 51 61; 
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56; 
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];
c=2;

I4=myDCT_quantization(I2,qm,c);
imshow(I4);
figure;

I5=myDCT_dequantization(I4,qm,c);
imshow(I5);
figure;

e=RMSE(J,I5);%give smaller image first
disp("root mean square error is:");
disp(e);

etr=My_entropy(I);
disp("entropy is:");
disp(etr);

%------------------2---------------------------%

I=imread('LAKE.TIF');

tl1=[420 45];
part2(tl1,I,F,qm,c);

tl1=[427 298];
part2(tl1,I,F,qm,c);

tl1=[30 230];
part2(tl1,I,F,qm,c);

%------------------3---------------------------%

a=8*ones(1,64);
b=mat2cell(I,a,a);
for i = 1:4096
    II=b{i};    
    I1=double(II);
    I2=myDCT(I1,F);
    I3=myDCT_quantization(I2,qm,c);
    b{i}=I3;
end
b=cell2mat(b);
imshow(b);
figure;

%-------------------4--------------------------%

nos=100;%how many values to test
R=ones(1,nos);
E=ones(1,nos);
C=(1:nos);
for j=1:nos
    c=C(j);
    a=8*ones(1,64);
    b=mat2cell(I,a,a);
    for i = 1:4096
        II=b{i};    
        I1=double(II);
        I2=myDCT(I1,F);
        I3=myDCT_quantization(I2,qm,c);
        I4=myDCT_dequantization(I3,qm,c);
        I5=myIDCT(I4,F);
        b{i}=I5;
    end
    b=uint8(cell2mat(b));
    R(j)=mean(RMSE(I,b));
    E(j)=My_entropy(b);
%     imshow(b);
%     figure;
end
plot(C,R,C,E,'--');
figure;
%---------------------------------------------%

function t2=create_mat_dct()
    a=(0:7);
    t=pi*(2*a+1)*(1/16);
    [~,y]=meshgrid(a);
    t2=(1/2)*cos(y.*t);
    t2(1,:)=t2(1,:)*(1/sqrt(2));
end

function t=myDCT(I,F)
    t=F*I*F';
end

function t=myIDCT(I,F)
    t=F'*I*F;
end

function t=myDCT_quantization(I,qm,c)
    t=round(I./(qm*c));
end

function t=myDCT_dequantization(I,qm,c)
    t=round(I.*(qm*c));
end

function t=RMSE(I1,I2)
    %I2=double(imread('cameraman.tif'));
    s=abs(size(I1)-size(I2));
    s=s(1);
    s=s/2;
    I11=padarray(I1,[s s],'post');
    I11=padarray(I11,[s s],'pre');
    t=sqrt(mean((I11-I2).^2));
end

function t=My_entropy(I)
    p=imhist(I);
    p=p/sum(p);
    p=p(p~=0);
    t=-sum(p.*log2(p));
end

function part2(tl1,I,F,qm,c)
    I1=double(I(tl1(1)-7:tl1(1),tl1(2):tl1(2)+7));
    I2=myDCT(I1,F);
    I3=myDCT_quantization(I2,qm,c);
    I4=myDCT_dequantization(I3,qm,c);
    I5=myIDCT(I4,F);
  
    subplot(1,4,1)
    imshow(uint8(I1));
    title('ORIGINAL');
    
    subplot(1,4,2)
    imshow(I2);
    title('DCT');
    
    subplot(1,4,3)
    imshow(I3);
    title('QUANTISED DCT');
    
    subplot(1,4,4)
    imshow(uint8(I5));
    title('RECONSTRUCTED IMAGE');
    figure;
    
    e=RMSE(I1,I5);
    disp("error:")
    disp(mean(e));
end