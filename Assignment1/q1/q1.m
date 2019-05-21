[a,f]=audioread('q11.wav');
b=resample(a,2,1);%half speed
c=resample(a,1,2);%double speed

dt=1/f;
t = 0:dt:(length(a)*dt)-dt;

subplot(3,1,1)
plot(t,a); xlabel('Seconds'); ylabel('Amplitude');

subplot(3,1,2)
t = 0:dt:(length(b)*dt)-dt;
plot(t,b); xlabel('Seconds'); ylabel('Amplitude');

subplot(3,1,3)
t = 0:dt:(length(c)*dt)-dt;
plot(t,c); xlabel('Seconds'); ylabel('Amplitude');
