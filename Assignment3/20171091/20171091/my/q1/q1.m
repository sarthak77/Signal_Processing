File=csvread('houses.csv');
dim=size(File);
rowlimit=.9*dim(1);
rowlimit=floor(rowlimit);

X=ones(rowlimit,dim(2));

soh=File(1:rowlimit,1);
nob=File(1:rowlimit,2);
price=File(1:rowlimit,3);

X(:,2)=soh;
X(:,3)=nob;
Y=price;

%1st part%
temp1=X'*X;
temp2=X'*Y;
B=temp1\temp2;

%l2 norm%
orig=File(rowlimit+1:dim(1),3);
cal=ones(dim(1)-rowlimit,3);
cal(:,2:3)=File(rowlimit+1:dim(1),1:2);
cal=cal*B;
error=abs(orig-cal);
error=mean(error);
disp("Error without normalising");
disp(error);

%prediction%
houseprice=B(1)+B(2)*1400+B(3)*4;
disp("House Price");
disp(houseprice);

%2nd part%
low1=min(X(:,2));
high1=max(X(:,2));
X(:,2)=(X(:,2)-low1)/(high1-low1);

low2=min(X(:,3));
high2=max(X(:,3));
X(:,3)=(X(:,3)-low2)/(high2-low2);

temp1=X'*X;
temp2=X'*Y;
B2=temp1\temp2;

%l2 norm%
orig=File(rowlimit+1:dim(1),3);
cal=ones(dim(1)-rowlimit,3);
cal(:,2:3)=File(rowlimit+1:dim(1),1:2);
cal(:,2)=(cal(:,2)-low1)/(high1-low1);
cal(:,3)=(cal(:,3)-low2)/(high2-low2);
cal=cal*B2;
error=abs(orig-cal);
error=mean(error);
disp("Error with normalising");
disp(error);

%3rd part%
Test=mean(File(1:rowlimit,:));
Error=B(1)+B(2)*Test(1)+B(3)*Test(2)-Test(3);
disp("Error")
disp(Error);