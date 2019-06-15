I1=imread('cameraman.tif');
disp("For img1")
tic
I2=tddft(I1);
I3=fftshift(I2);
toc
figure, imagesc(mat2gray(log(abs(I3)+1))), colormap gray;

J1=imread('s1.jpg');
disp("For img2")
tic
J2=tddft(J1);
J3=fftshift(J2);
toc
figure, imagesc(mat2gray(log(abs(J3)+1))), colormap gray;

K1=imread('s2.png');
disp("For img3")
tic
K2=tddft(K1);
K3=fftshift(K2);
toc
figure, imagesc(mat2gray(log(abs(K3)+1))), colormap gray;

function y=tddft(I)
    [a,b]=size(I);
    x=zeros([a b]);
    y=zeros([a b]);
    I=double(I);
    for i=1:a
        x(i,:)=oddft(I(i,:));
    end
    for i=1:b
        y(:,i)=oddft(x(:,i).');
    end
end
function y=oddft(I)
    len=size(I,2);
    zmat=exp(-1j*2*pi/len);
    a=0:len-1;
    [b,c]=meshgrid(a);
    Wmat=zmat.^(b.*c);
    y=Wmat*I';
end