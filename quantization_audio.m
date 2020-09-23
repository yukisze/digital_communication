%% part a
[yorg,fs]=audioread('oilyrag.wav');
yorg =  yorg(:,1);
l = length(yorg);
t = (0:l-1)/fs;

%% part b 
%subplot(3,1,1)
figure(1)
plot(t,yorg);
title('Waveform of the speech signal');
ylabel('Amplitude');
xlabel('Time')
figure(2);
histogram(yorg,50);
title('Waveform of the speech signal');
info = audioinfo('oilyrag.wav') %tell the bits
%% part c 
soundsc(yorg);
%% d
b = 3;
n = 2^b;
steps = (max(yorg) -min(yorg))/(n-1);
max_y = max(yorg);
min_y = min(yorg);
rescale =(yorg-(min(yorg)))/steps;%shift to positive area, than scale by delta as divide to delta
rescale =floor(rescale);%rounded to nearest level
y =rescale*steps+(min(yorg));%remapping by using this equation
figure(3);
plot(t,y);
title('3 bits Quantization');
xlabel('Time (s)');

%% e
y_scaled = yorg*0.5; %scale down

%% f
%FOR CLIPPING
new_notclipped = zeros(1,l);
for i = 1:l
    if y_scaled(i) > 0.2365
        new_notclipped (i) =0.2365;
    elseif y_scaled(i) < -0.2114
        new_notclipped(i) = -0.2114;
    else
         new_notclipped(i) = y_scaled(i);
    end
end

rescale2 =(new_notclipped-(min(new_notclipped)))/steps;%shift to positive area, than scale by delta as divide to delta
rescale2 =round(rescale2);%rounded to nearest level
y3bits =rescale2*steps+(min(new_notclipped));%remapping by using this equation
round(y3bits);

figure(4);
plot(t,y_scaled);
title('3 bits level Rescale');
xlabel('Time (s)');
figure(5);
plot(t,y3bits);
xlabel('time')
ylabel('amplitude')
title('New rescaled down quantization graph')
e=y_scaled-y3bits;
figure(6);
title('Quantiation error')
histogram(e,50);
title('Histogram of quantization error');
%%
filename = 'y3bit.wav';
audiowrite(filename,y3bits,fs);
info = audioinfo('y3bit.wav') 
soundsc(y3bits);

%% part g %%
y_pclip = yorg*10;%the maximum part is being clipped off
new = zeros(1,l);
%FOR CLIPPING
for i = 1:l
    if y_pclip(i) > 0.2365
        new(i) = 0.2365;
    elseif y_pclip(i) < -0.2114
        new(i) = -0.2114;
    else
         new(i) = y_pclip(i);
    end
end
rescale1 =(new-(min(new)))/steps;%shift to positive area, than scale by delta as divide to delta
rescale1 =floor(rescale1);%rounded to nearest level
y3bits_pclip =rescale1*steps+(min(new));%remapping by using this equation
figure(5);
plot(t,y_pclip);
title('Rescaling to greatly exceed peak clipping');
xlabel('Time (s)');
figure(6);
plot(t,y3bits_pclip);
xlabel('time')
ylabel('amplitude')
title('Greatly Exceed peak clipping 3 bits quantization graph ')
e=y_pclip-y3bits_pclip;
figure(7);
histogram(e,50);
title('Histogram of quantization error exceed clip');


%% 
soundsc(y3bits_pclip);
