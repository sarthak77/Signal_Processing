disp("For img1");
I1=imread('cameraman.tif');
tic
I2=tdfft(I1);
I3=fftshift(I2);
toc
figure, imagesc(mat2gray(log(abs(I3)+1))), colormap gray;
tic
I4=fftshift(fft2(I1));
toc
figure, imagesc(mat2gray(log(abs(I4)+1))), colormap gray;

disp("For img2");
J1=imread('s1.jpg');
tic
J2=tdfft(J1);
J3=fftshift(J2);
toc
figure, imagesc(mat2gray(log(abs(J3)+1))), colormap gray;
tic
J4=fftshift(fft2(J1));
toc
figure, imagesc(mat2gray(log(abs(J4)+1))), colormap gray;

disp("For img3");
K1=imread('s2.png');
tic
K2=tdfft(K1);
K3=fftshift(K2);
toc
figure, imagesc(mat2gray(log(abs(K3)+1))), colormap gray;
tic
K4=fftshift(fft2(K1));
toc
figure, imagesc(mat2gray(log(abs(K4)+1))), colormap gray;

function y=tdfft(I)
    [a,b]=size(I);
    x=zeros([a b]);
    y=zeros([a b]);
    I=double(I);
    for i=1:a
        x(i,:)=odfft(I(i,:));
    end
    for i=1:b
        y(:,i)=odfft(x(:,i).');
    end
end
function y=odfft(I)
len=size(I,2);
if len==1
    y=I;
else
    oddsignal=I(1:2:len);
    evensignal=I(2:2:len);
    fodd=odfft(oddsignal);
    feven=odfft(evensignal);  
    X = exp(-1i*2*pi*((0:len/2-1)')/len);
    temp=X.*fodd;
    y=[feven+temp;feven-temp];
end
end