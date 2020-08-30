addpath(genpath('./.'));
SiddDataDir = '.\testsets\SIDD_Benchmark_mat\';
submitDir = '.\results\SIDD_sibmit\';
if ~exist(submitDir, 'dir'), mkdir(submitDir); end
[DenoisedBlocksSrgb, TimeMPSrgb] = DenoiseSrgb_SIDD(SiddDataDir);
fprintf('Saving resutls...\n');
OptionalData.MethodName = 'PT_MWRN';
OptionalData.Authors = 'Yue Cao and Wangmeng Zuo';
OptionalData.PaperTitle = 'PT_MWRN';
OptionalData.Venue = 'SIDD Demo';
% Specs of the machine used to run the benchmark (useful for time
% comparison)
OptionalData.MachineSpecs = 'Intel Core i7 6700 @ 3.4 GHz, 32 GB RAM'; 
save(fullfile(submitDir, 'SubmitSrgb.mat'), 'DenoisedBlocksSrgb','TimeMPSrgb', 'OptionalData', '-v7.3');
fprintf('Done!\n');

