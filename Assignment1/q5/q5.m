[a1,f1]=audioread('sa_re_ga_ma.wav');
c=smoothdata(a1,'gaussian');
d=smoothdata(a1,'movmean');
e=smoothdata(a1,'movmedian');
f=smoothdata(a1,'lowess');%linear regression


a1=a1(:,1);
c=c(:,1);
d=d(:,1);
e=e(:,1);
f=f(:,1);

%to play
x1=audioplayer(a1,f1);
x2=audioplayer(c,f1);
x3=audioplayer(d,f1);
x4=audioplayer(e,f1);
x5=audioplayer(f,f1);
%play(x1);
%stop(x1);

dt=1/f1;
t = 0:dt:(length(a1)*dt)/150-dt;

subplot(5,1,1);
plot(t,a1(1:length(t))); xlabel('Seconds'); ylabel('Amplitude');
title('Original');


subplot(5,1,2);
plot(t,c(1:length(t))); xlabel('Seconds'); ylabel('Amplitude');
title('gaussian');

subplot(5,1,3);
plot(t,d(1:length(t))); xlabel('Seconds'); ylabel('Amplitude');
title('movemean(default)');

subplot(5,1,4);
plot(t,e(1:length(t))); xlabel('Seconds'); ylabel('Amplitude');
title('movemedian');

subplot(5,1,5);
plot(t,f(1:length(t))); xlabel('Seconds'); ylabel('Amplitude');
title('lowess');
