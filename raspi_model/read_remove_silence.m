function [yEdited_1st_second,fs] = read_remove_silence(fs, y)

%[y, fs] = audioread(file); 
%y = coder.load('cough_data.mat');
%fs = coder.load('cough_fs.mat');
%y = y.y;
%fs = fs.fs;
%{
deviceReader = audioDeviceReader('SampleRate', fs, 'SamplesPerFrame', fs);

y = [];
for i=1:5
    y = [y; deviceReader()];
end
%}

%{
r = raspi();
captureObj = audiocapture(r, 'plughw:2,0', 'SampleRate', fs, 'SamplesPerFrame', fs, 'NumberOfChannels', 1);
y = capture(captureObj);

%}


if size(y,2)==2
y(:,2)=[];
end

%}
% if size(y,2)>2
% y=y';
% end
% Find the envelope by taking a moving max operation, imdilate.
y(1:100) = 0;
envelope = imdilate(abs(y), true(1501, 1));

quietParts = envelope < 0.13; % Or whatever value you want.

% find where the first quiet part ends 
idx_not_quiet = find(quietParts < 1);
if isempty(idx_not_quiet)
    idx_last_quiet=1;
else
    idx_last_quiet=idx_not_quiet(1);
end
yEdited_1st_quiet=y;
yEdited_1st_quiet(1:idx_last_quiet) = [];

%if array <fs padd with zeros
if size(yEdited_1st_quiet,1)<fs
    yEdited_1st_second = [yEdited_1st_quiet;zeros((fs-size(yEdited_1st_quiet,1)),1,'like',yEdited_1st_quiet)];
else
    yEdited_1st_second=yEdited_1st_quiet(1:fs);
end

end

