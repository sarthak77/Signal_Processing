noc=35;%no of components
path='E:\work\dsaa\Assignments\Assignment4\q2\dataset';%path from where images picked
cpath='E:\work\dsaa\Assignments\Assignment4\q2\compressed_images';%path where images stored after compressing
files=dir(strcat(path,'\*.jpg'));%set of all images
L=length(files);
A = zeros(L,256*256*3);%declare matrix

%concatanate images
for xx = 1:1:L
    Img=double(imread(strcat(path,'\',files(xx).name)));
    A(xx,:)=Img(:);
end

%calculate E and V
C=A*A';
[V,E]=eig(C);
E=sort(E,2);
E=E(:,L);
[~,~]=sort(E);
[E,I]=sort(E,'descend');
V=V(:,I);

[compressed_space,basis]=calcs(A,V,noc);%calculate compressed images

%calculate image from compressed image and store
for i = 1:L
    xx = compressed_space(i,:);
    img = basis*xx';
    sz=[256 256];
    
    %3 channels
    x=1;
    c1 = col2im(img((x-1)*256*256+1:x*256*256),sz,sz, 'distinct');
    x=x+1;
    c2 = col2im(img((x-1)*256*256+1:x*256*256),sz,sz, 'distinct');
    x=x+1;
    c3 = col2im(img((x-1)*256*256+1:x*256*256),sz,sz, 'distinct');

    Img_compressed = cat(3,c1,c2,c3);%concatanate all
    
    name=strcat(cpath,'\',files(i).name);
    imwrite(Img_compressed/260,name)

end

%for 1d plots
[cs1,b1]=calcs(A,V,1);%calculate compressed images
%for 2d plots
[cs2,b2]=calcs(A,V,2);%calculate compressed images
%for 3d plots
[cs3,b3]=calcs(A,V,3);%calculate compressed images

figure;
scatter(cs1(:,1),cs1(:,1));
figure;
scatter(cs2(:,1),cs2(:,2));
figure;
scatter3(cs3(:,1),cs3(:,2),cs3(:,3));

function [compressed_space,basis]=calcs(A,V,noc)
    normfunc = @(m) m.*sqrt((m.^2) ./ sum(m.^2))./abs(m);
    basis = normfunc(A'*V(:,1:noc));
    compressed_space = A*basis;
end
