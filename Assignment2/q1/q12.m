img=imread('inp1.png');
img2=imread('cameraman.tif');
imshow(img);
figure;
imshow(img2);
figure;

b=median_filter(img,3);
c=median_filter(img2,7);
d=median_filter(img2,9);

imshow(b);
figure;
imshow(c);
figure;
imshow(d);


function y=median_filter(I,n)
img=padarray(I,[floor(n/2) floor(n/2)],'both');
img2col=im2col(img,[n n],'sliding');
med=median(img2col);
y=col2im(med,[1 1],size(I),'distinct');
end
