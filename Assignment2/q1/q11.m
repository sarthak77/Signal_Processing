I=imread('cameraman.tif');

a1=gauss_filter(65,1);
a2=gauss_filter(65,2);
a3=gauss_filter(100,1);
a4=gauss_filter(100,2);
a5=fspecial('gaussian',65,1);
a6=fspecial('gaussian',65,2);
a7=fspecial('gaussian',100,1);
a8=fspecial('gaussian',100,2);

img1=imfilter(I,a1);
img2=imfilter(I,a2);
img3=imfilter(I,a3);
img4=imfilter(I,a4);
img5=imfilter(I,a5);
img6=imfilter(I,a6);
img7=imfilter(I,a7);
img8=imfilter(I,a8);

imshow(I)
figure
imshow(img1)
figure
imshow(img2)
figure
imshow(img3)
figure
imshow(img4)
figure
imshow(img5)
figure
imshow(img6)
figure
imshow(img7)
figure
imshow(img8)

%n=odd
function y=gauss_filter(n,s)
x=-floor(n/2):floor(n/2);
[r,c]=meshgrid(x,x);
y=exp(-(r.*r+c.*c)/2*s*s);
nfactor=sum(y(:));
y=y/nfactor;
end


