%reading digits
[y0,f0]=audioread('0.ogg');
[y1,f1]=audioread('1.ogg');
[y2,f2]=audioread('2.ogg');
[y3,f3]=audioread('3.ogg');
[y4,f4]=audioread('4.ogg');
[y5,f5]=audioread('5.ogg');
[y6,f6]=audioread('6.ogg');
[y7,f7]=audioread('7.ogg');
[y8,f8]=audioread('8.ogg');
[y9,f9]=audioread('9.ogg');

%reading file
[y,f]=audioread('Police.ogg');

%preprocessing
y0=y0(1:f);
y1=y1(1:f);
y2=y2(1:f);
y3=y3(1:f);
y4=y4(1:f);
y5=y5(1:f);
y6=y6(1:f);
y7=y7(1:f);
y8=y8(1:f);
y9=y9(1:f);

%concatanating
digitvector=[y0,y1,y2,y3,y4,y5,y6,y7,y8,y9];

%expected inputs
len=length(y)/f;
len=floor(len);

%for faster calculations
result=zeros([1,len]);

for i=1:len
    
    %taking each sample ony by one
    sample=y((i-1)*f+1:i*f);
    max=-100;
    pos=-100;
    
    %doing dot product for max match
    for j = 1:10
        temp = dot(digitvector(:,j),sample)/(norm(sample)*norm(digitvector(:,j)));
        if temp > max
            max = temp;
            pos = j;
        end
    end
    result(i)=pos-1;
end
disp(result);

