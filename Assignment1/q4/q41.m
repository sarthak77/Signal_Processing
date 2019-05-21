a=imread('image.png');
scale=10;
x = NNI(a,scale);
imshow(x);

function ImgScaled = NNI(a, scale)

[l,b,h]=size(a);
ln=scale*l;
bn=scale*b;
hn=h;
an=uint8(zeros(ln,bn,hn));

for i=1:ln
    for j=1:bn
        x=floor((i-1)/scale);
        y=floor((j-1)/scale);
        for k=1:hn
            an(i,j,k)=a(x+1,y+1,k);
        end
    end
end
ImgScaled=an;
end
