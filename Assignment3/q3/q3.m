I1=imread('temp.jpg');
I2=padarray(I1,[64 64],'post');
I3=padarray(I2,[128 128],'post');
I4=padarray(I3,[256 256],'post');

F1=fft2(I1);
F2=fft2(I2);
F3=fft2(I3);
F4=fft2(I4);

imshow(mat2gray(log(abs(fftshift(F1)))));
figure;
imshow(mat2gray(log(abs(fftshift(F2)))));
figure;
imshow(mat2gray(log(abs(fftshift(F3)))));
figure;
imshow(mat2gray(log(abs(fftshift(F4)))));
