file='s1.png';
img = imread(file);
 scale=5;
 x = BI(img,scale);
 imshow(x);

function ImgScaled = BI(Img, X)

%new dimensions
[l,b,h] = size(Img);
ln = X*(l-1)+1;
bn = X*(b-1)+1;
hn=h;

%initialising with zeros
ImgScaled = zeros(ln,bn,hn);
 
%copying original pixels into new matrix
for i= 1:l
   for j= 1:b
      ImgScaled(X*(i-1)+1, X*(j-1)+1, : ) = Img(i, j, : );
   end
end
 
for i= 0:X:ln-X
    for j= 0:X:bn-X
        for k= 1:hn
            %corner pixels
            A = ImgScaled(i+1, j+1, k);
            B = ImgScaled(i+1, j+X+1, k);
            C = ImgScaled(i+X+1, j+1, k);
            D = ImgScaled(i+X+1, j+X+1, k);
            
            %calculating ratios for formula
            x1 = A;
            x2 = (B-A)/X;
            x3 = (C-A)/X;
            x4 = (D-C-B+A)/(X*X);
            
            %interpolating pixels
            for l= 0:X%length
                for m= 0:X%breadth
                    ImgScaled(i+l+1, j+m+1, k) = x1 + x2*m + x3*l + x4*m*l;
                end
            end
        end
    end
end
%ImgScaled = uint8(ImgScaled);
end