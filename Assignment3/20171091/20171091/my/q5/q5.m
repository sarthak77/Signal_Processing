%initialising variables%
fans=ones(1,5);
anspos=1;%postion in output order
check=zeros(1,5);%to check if already encountered
s=4;%time

%take input%
[y1,f1]=audioread('1.wav');
[y2,f2]=audioread('2.wav');
[y3,f3]=audioread('3.wav');
[y4,f4]=audioread('4.wav');
[y5,f5]=audioread('5.wav');

%start array%
start(1,:)=y1(1:f1*s);
start(2,:)=y2(1:f2*s);
start(3,:)=y3(1:f3*s);
start(4,:)=y4(1:f4*s);
start(5,:)=y5(1:f5*s);

%end array%
fin(1,:)=y1(length(y1)-f1*s+1:length(y1));
fin(2,:)=y2(length(y2)-f2*s+1:length(y2));
fin(3,:)=y3(length(y3)-f3*s+1:length(y3));
fin(4,:)=y4(length(y4)-f4*s+1:length(y4));
fin(5,:)=y5(length(y5)-f5*s+1:length(y5));

%find 1st packet%
inf=10000000000;
temp=[-inf,-inf,-inf,-inf,-inf];

i=1;
while i<6
    j=1;
    while j<6
        temp(i)=max(temp(i),max(xcorr(start(i,:),fin(j,:))));
        j=j+1;
    end
   i=i+1;
end

[value,index]=min(temp);
fans(anspos)=index;
anspos=anspos+1;
check(index)=1;

%find the order%
while anspos<6
    inf=10000000000;
    temp=[-inf,-inf,-inf,-inf,-inf];

    j=1;
    while j<6
        if check(j)==0
            temp(j)=max(temp(j),max(xcorr(fin(index,:),start(j,:))));
        end
        j=j+1;
    end
    
    [value,index]=max(temp);
    fans(anspos)=index;
    check(index)=1;
    anspos=anspos+1;
end

disp("Order of packets");
disp(fans);

%denoise data%
nos=25000;
y1d=dn(y1,nos);
a=y1d(1:length(y1d)-4*f1,:);

nos=28000;
y2d=dn(y2,nos);
b=y2d(1:length(y2d)-4*f2,:);

nos=36000;
y3d=dn(y3,nos);
c=y3d(1:length(y3d)-4*f3,:);

nos=28000;
y4d=dn(y4,nos);
d=y4d(1:length(y4d)-4*f4,:);

nos=37000;
y5d=dn(y5,nos);
e=y5d(1:length(y5d)-4*f5,:);

%concatanate packets%
o={a b c d e};
a1=o{fans(1)};
b1=o{fans(2)};
c1=o{fans(3)};
d1=o{fans(4)};
e1=o{fans(5)};

order=[a1;b1;c1;d1;e1];
obj=audioplayer(order,f1);

function c = dn(sig,nos)
a=fft(sig);
row=size(a,1);
b=zeros(1,row);
b(1:nos)=a(1:nos,1);
b(row-nos:row)=a(row-nos:row,1);
c=abs(ifft(b));
c=c';
end