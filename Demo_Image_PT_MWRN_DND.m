addpath(genpath('./.'));
% test DND
DND_dir = 'D:\dataset\DND';
save_path =  '.\results\denoised_DND_rgb\';
if ~exist(save_path, 'dir'), mkdir(save_path) ; end
denoise_srgb(DND_dir, save_path);
bundle_submission_srgb(save_path);






