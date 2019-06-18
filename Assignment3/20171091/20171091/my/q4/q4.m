load('Q4.mat');
samples=size(X)/Fs;
samples=uint32(samples(1));

X2=fft(X);
X3=abs(X2)>30000;
denoise=times(X3,X2);
denoise=ifft(denoise);
obj=audioplayer(denoise,Fs);
play(obj);

X4=uint32(find(X3));
X4=X4/samples;
rowlimit=size(X4);
rowlimit=.5*rowlimit(1);
X5=X4(1:rowlimit,1);
disp("Frequencies are::")
disp(X5);