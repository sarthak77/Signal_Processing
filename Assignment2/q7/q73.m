X=dial_tone("20171091");
I=spectrogram(X,200);
imagesc(log(abs(I)));
%sound(X);
%plot(X);
%figure;
%stem(X);

function output=dial_tone(x)

v1=[697,770,852,941];
v2=[1209,1336,1477];
v3=str2double(regexp(num2str(x),'\d','match'));

fs = 6000;
t = 0:1/fs:.5;
output=[0];

for i=1:length(v3)
    if(v3(i)~=0)
        if(mod(v3(i),3)~=0)
            r=floor((v3(i)/3))+1;
            c=mod(v3(i),3);
        else
            r=v3(i)/3;
            c=3;
        end
    else
        r=4;
        c=2;
    end
    y=sin(2*pi*v1(r)*t)+sin(2*pi*v2(c)*t);
    output=[output,y];
    output=[output,sin(t)]; 
end
end