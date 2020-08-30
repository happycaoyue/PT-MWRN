function [output] = denoiser(input)
%% testing set
addpath(genpath('./.'));
run('D:\Program Files (x86)\matconvnet-1.0-beta25\matconvnet-1.0-beta25\matlab\vl_setupnn');
gpu         = 1;

load('.\models\PT-MWRN_Real.mat');


net = dagnn.DagNN.loadobj(net) ;

% net.removeLayer('loss') ;
% net.removeLayer('objective_2') ;
net.removeLayer('objective') ;
out1 = net.getVarIndex('prediction') ;
net.vars(net.getVarIndex('prediction')).precious = 1 ;

net.mode = 'test';

if gpu
    net.move('gpu');
end


        if gpu
            input = gpuArray(input*4-2);
            % input = gpuArray(input);
        end
        net.eval({'input', input}) ;
        % output (single)
         output = gather(squeeze(gather(net.vars(out1).value+2)/4));
         % output = gather(squeeze(gather(net.vars(out1).value)));

   
end