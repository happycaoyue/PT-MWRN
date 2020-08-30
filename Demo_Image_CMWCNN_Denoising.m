
% clear; %clc;
addpath(genpath('./.'));
% You should change the dir of local matconvnet
run('D:\Program Files (x86)\matconvnet-1.0-beta25\matconvnet-1.0-beta25\matlab\vl_setupnn');
%% testing set
imageSets   = {'CBSD68','Kodak24','McMaster'};

WF = 1;
gpu = 1;

if gpu 
    gpuDevice(gpu); 
end

list_sig = [15 25 50 75];
modelName   = 'CMWCNN_Sigma';


% different datasets    
for cc = 1:3 % 1 = 'CBSD68' 2 = 'Kodak24' 3 = 'McMaster'

    image_set   = imageSets{cc};

    folderTest = fullfile('testsets',image_set);

    ext         =  {'*.jpg','*.png','*.bmp','*.tif'};
    filePaths   =  [];
    for i = 1 : length(ext)
        filePaths = cat(1,filePaths, dir(fullfile(folderTest,ext{i})));
    end

    %%% PSNR and SSIM
    PSNRs = zeros(1,length(filePaths));
    SSIMs = zeros(1,length(filePaths));
    times = zeros(1,length(filePaths));

    % different noise level (Sigma)    
    for Sigma = list_sig %  15 25 50 75
        %% load model
        load(fullfile('models', [modelName num2str(Sigma)]));

        net = dagnn.DagNN.loadobj(net) ;   
        net.removeLayer('loss') ;
        out_idx = net.getVarIndex('prediction') ;
        net.vars(net.getVarIndex('prediction')).precious = 1 ;
        net.mode = 'test';  
        if gpu
            net.move('gpu');
        end
        for i = 1 : length(filePaths)
            %%read images
            im = imread(fullfile(folderTest,filePaths(i).name));
            [~,nameCur,extCur] = fileparts(filePaths(i).name);
            im  = modcrop(im, 8);
            label = im;
            sz = size(label);
            [~,nameCur,extCur] = fileparts(filePaths(i).name);
            label = im2single(label);


          %% fixed random seed is needed in testing stage
            randn('seed',0);

            input = label + Sigma/255*randn(sz,'single');

            tic;
            output = Processing_Im(input, net, gpu, out_idx);
            times(i) = toc;

            [PSNRCur, SSIMCur] = Cal_PSNRSSIM(im2uint8(label),im2uint8(output), 0, 0);
           
            if WF 
                path =  ['./results/' modelName num2str(Sigma) '_' image_set];
                if ~exist(path, 'dir'), mkdir(path) ; end
                imwrite(output, fullfile(path, [ nameCur '_' modelName num2str(Sigma) '_PSNR_' num2str(PSNRCur*100,'%4.0f') '_SSIM_' num2str(SSIMCur*10000,'%4.0f') '.png']));

            end

            PSNRs(i) = PSNRCur;
            SSIMs(i) = SSIMCur;
        end
       fprintf([modelName num2str(Sigma) '_' image_set ': PSNR / SSIM : %.02f / %0.4f, %0.4f.\n'], mean(PSNRs),mean(SSIMs), mean(times));
    end   
end








