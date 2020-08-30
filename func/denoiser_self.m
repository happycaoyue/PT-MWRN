function [output] = denoiser_self(input)
    addpath(genpath('../.'));
    % You should change the dir of local matconvnet
    run('D:\Program Files (x86)\matconvnet-1.0-beta25\matconvnet-1.0-beta25\matlab\vl_setupnn');
    gpu         = 1;

    load('.\models\PT-MWRN_Real.mat');
    net = dagnn.DagNN.loadobj(net) ;

    net.removeLayer('objective') ;
    out1 = net.getVarIndex('prediction') ;
    net.vars(net.getVarIndex('prediction')).precious = 1 ;

    net.mode = 'test';

    if gpu
        net.move('gpu');
    end
    result = zeros(size(input,1), size(input,2), size(input,3), 8,'single');
    begin_input = input;
    for ii = 1:8
            input = data_augmentation(begin_input, ii);
            input = gpuArray(input*4-2);
            net.eval({'input', input}) ;
            output = gather(squeeze(gather(net.vars(out1).value+2)/4));
            result(:, :, :, ii) = undata_augmentation(output, ii); 
    end
    output = mean(result, 4);
   
end