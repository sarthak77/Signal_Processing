[y,f]=audioread('chirp.wav');

window1=700;
overlap1=100;
window2=700;
overlap2=400;
window3=500;
overlap3=100;
window4=500;
overlap4=400;

spectrogram(y,window4,overlap4,'centered','yaxis');
figure;

yy1=spectre(y,window1,overlap1);
yy2=spectre(y,window2,overlap2);
yy3=spectre(y,window3,overlap3);
yy4=spectre(y,window4,overlap4);

imagesc(log(yy1(:,1:window1)).');
figure;
imagesc(log(yy2(:,1:window2)).');
figure;
imagesc(log(yy3(:,1:window3)).');
figure;
imagesc(log(yy4(:,1:window4)).');

function yyy =spectre(signal,window,overlap)
    step=abs(window-overlap);
    limit=length(signal)-window+1;
    %starting point of each window
    startpt=1:step:limit;
    %initialise answer with zeros
    yyy=ones(length(startpt),window);
    
    for i=1:length(startpt)
        temp=fft(signal(startpt(i):startpt(i)+window-1));
        temp2=abs(fftshift(temp));
        yyy(i,:)=temp2;
    end
end