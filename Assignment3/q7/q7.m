File=csvread('Altitude.csv');
dim=size(File);
rowlimit=.9*dim(1);
rowlimit=floor(rowlimit);

alpha=.01;
B=zeros(dim(2),1);

X=File(1:rowlimit,1:dim(2)-1);
Altitude=File(1:rowlimit,3);

%1st method%
low1=min(X(:,1));
high1=max(X(:,1));
X(:,1)=(X(:,1)-high1)/(high1-low1);

low2=min(X(:,2));
high2=max(X(:,2));
X(:,2)=(X(:,2)-high2)/(high2-low2);
X = padarray(X,[0 1],1,'pre');

%2nd method%
% X(:,1) = (X(:,1)-mean(X(:,1)))/(std(X(:,1)));
% X(:,2) = (X(:,2)-mean(X(:,2)))/(std(X(:,2)));
% X = padarray(X,[0 1],1,'pre');

for i=1:150000
    
    Error=(X*B-Altitude);
    Error=Error';
    
    temp1=alpha*Error*(1/rowlimit)*(X(:,1));
    B(1)=B(1)-temp1;
    
    temp2=alpha*Error*(1/rowlimit)*(X(:,2));
    B(2)=B(2)-temp2;
    
    temp3=alpha*Error*(1/rowlimit)*(X(:,3));
    B(3)=B(3)-temp3;

end

%l2 norm%
orig=File(rowlimit+1:dim(1),3);
cal=ones(dim(1)-rowlimit,3);
cal(:,2:3)=File(rowlimit+1:dim(1),1:2);
cal=cal*B;
error=abs(orig-cal);
error=mean(error);
disp("Error");
disp(error);