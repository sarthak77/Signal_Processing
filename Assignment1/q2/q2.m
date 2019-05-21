%%sound recording
%recObj = audiorecorder(44100,24,1,-1);
%disp('Start speaking.')
%recordblocking(recObj,5);
%disp('End of Recording.');
%play(recObj);

%%subsampling
[y,f] = audioread('sample.wav');
a = audioplayer(y,24000);
b = audioplayer(y,16000);
c = audioplayer(y,8000);
d = audioplayer(y,4000);
%play(a);
%play(b);
%play(c);
%play(d);

%%convolution
[y1,f]=audioread('MINI CAVES E001 M2S.wav');
[y2,f]=audioread('SMALL CHURCH E001 M2S.wav');
[y3,f]=audioread('BIG HALL E001 M2S.wav');

y=y(:,1);
y1=y1(:,1);
y2=y2(:,1);
y3=y3(:,1);

o1=conv(y,y1);
o2=conv(y,y2);
o3=conv(y,y3);

e = audioplayer(o1,f);
g = audioplayer(o2,f);
h = audioplayer(o3,f);
%play(e);
%play(g);
%play(h);
