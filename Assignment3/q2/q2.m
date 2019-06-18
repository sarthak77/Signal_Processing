I1=imread('s1.jpg');
I2=imread('s2.png');

I3=fft2(I1);
I4=fft2(I2);
I5=times(I3,I4);
I6=ifft2(I5);

I7=conv2(I1,I2,'same');

%1st_part%
imshow(mat2gray(log(abs(I6))));
figure;
imshow(mat2gray(log(abs(I7))));

%2nd_part%
temp=I6-I7;
temp=temp.*temp;
temp=mean(mean(temp));
disp("error before padding");
disp(temp);

%3rd_part%

%padding%
I11=padarray(I1,[255 255],'post');
%I11=padarray(I11,[128 128],'post');
I21=padarray(I2,[255 255],'post');
%I21=padarray(I21,[128 128],'post');

%calculating again%
I3=fft2(I11);
I4=fft2(I21);
I5=times(I3,I4);
I6=ifft2(I5);

I7=conv2(I1,I2);

temp=I6-I7;
temp=temp.*temp;
temp=mean(mean(temp));
disp("error after padding");
disp(temp);