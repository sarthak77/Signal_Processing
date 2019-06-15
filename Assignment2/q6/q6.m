I1=imread('cameraman.tif');
imshow(I1);
figure;

I2=fft2(fft2(I1));
I3=log(abs(I2));
imshow(mat2gray(I3));
figure;

%flip in both dimensions
I4=fft2(flip(flip(fft2(I1),1),2)+1000);

I5=log(abs(I4));
imshow(mat2gray(I5));