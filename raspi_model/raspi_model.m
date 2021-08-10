function x = raspi_model()

    %assert(all(size(fileName) <= 50));
    %assert(isa(fileName,'char'));
    %input = coder.load(fileName);

    fid = fopen('data.csv','r');
    y = fread(fid, 'char');
    fclose(fid);
    b = find(y==10);
    b = [1; b];
    data = zeros(8000,1);
    for i = 1:8000
        data(i) = real(str2double(char(y(b(i):b(i+1)))));
    end
    
    [xPadded, fs1] = read_remove_silence(8000, data);
    features = extractFeatures(xPadded);
    
    epsil = 1e-6;
    features = log10(features + epsil);
    
    features = reshape(features, [98,50]);
    
    net = coder.loadDeepLearningNetwork('net_1.mat');
    
    [label,score] = net.classify(features);
    labelStr  = cellstr(label);
    [maxScore, x]  = max(score);
    outputStr = sprintf('Label : %s \nScore : %f',labelStr{:},maxScore);
    %Print label and score to stdout
    fprintf('%s\n',outputStr);
    
    %probs = predict(net, features);
    %[~, YPredicted] = max(probs);
    %fprintf("Predicted:\t %f \t %f \n", probs(1), probs(2));


end
