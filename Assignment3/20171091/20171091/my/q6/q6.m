%initialising%
I=imread('cameraman.tif');
I=double(I);
k=16;
afilter=ones(k)/(k^2);

%normal filter%
I1=conv2(I,afilter);
imshow(I1,[]);
figure;

%optimised filter%
row=ones(1,k);
col=ones(k,1);
I2=conv2(I,col);
I2=conv2(I2,row);
I2=I2/(k^2);
imshow(I2,[]);
figure;

samples=100;
a=ones(samples,1);
b=ones(samples,1);

for i=1:samples
    
afilter=ones(i)/(i^2);
tic
I1=conv2(I,afilter);
a(i)=toc;

col=ones(i,1);
row=ones(1,i);
tic
I2=conv2(I,col);
I2=conv2(I2,row);
I2=I2/(i^2);
b(i)=toc;

end
x=1:samples;
plot(x,a,x,b,'--');