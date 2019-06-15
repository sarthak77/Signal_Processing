I=imread('inp2.png');
imshow(I);
figure;

I=double(I);
I2=fftshift(fft2(I));

%Creating the filter
fltr=[zeros(120,238);ones(70,238);zeros(128,238)];
temp=I2.*fltr;

final=ifft2(temp);

imshow(mat2gray(log(abs(I2))))
figure;
imagesc(log(abs(temp)));
figure;
imshow(mat2gray(log(abs(final))))
