[y,fs]=audioread('signal_3.wav');
fc=80;
[b,a]=butter(6,fc/(fs/2),'low');
filteredSignal=filter(b,a,y);
player=audioplayer(filteredSignal,fs);
play(player);