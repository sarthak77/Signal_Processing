[y,f]=audioread('signal_3.wav');
Y=fft(y);
meanY=mean(abs(Y));
Y(abs(Y)<2*meanY)=0;
out=ifft(Y);