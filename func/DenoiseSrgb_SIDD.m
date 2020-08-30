function [DenoisedBlocksSrgb, TimeMP] =  DenoiseSrgb_SIDD(siddDataDir)

% block positions
load(fullfile(siddDataDir, 'BenchmarkNoisyBlocksSrgb.mat'));
% 40  32   256   256  3  uint8
nImages = size(BenchmarkNoisyBlocksSrgb, 1);
nBlocks = size(BenchmarkNoisyBlocksSrgb, 2);

DenoisedBlocksSrgb = cell(nImages, nBlocks);
TimeMP = 0; % denoising time (in seconds) per megapixel

% for each image
for i = 1 : nImages
    % for each block
    for b = 1 : nBlocks
        fprintf('Denoising sRGB image %02d, block %02d ... ', i, b);
        t0 = tic; % start timer
        noisyBlock = im2single(BenchmarkNoisyBlocksSrgb(i, b, :, :, :));
        noisyBlock = squeeze(noisyBlock);
        noisyBlock = squeeze(noisyBlock);
        % 0~1
        denoisedBlock = denoiser(noisyBlock);
        t1 = toc(t0); % stop timer

        DenoisedBlocksSrgb{i, b} = im2uint8(denoisedBlock);
       %  imwrite(im2uint8(denoisedBlock), ['./test_s1/',num2str(i), '_',num2str(b),'_s1.png']);
        % total time
        TimeMP = TimeMP + t1;
        fprintf('Time = %f seconds\n', t1);
    end
end

TimeMP = TimeMP * 1024 * 1024 /  (nImages * nBlocks * 256 * 256); % seconds per megapixel

end