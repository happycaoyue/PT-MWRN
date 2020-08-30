% Utility function for denoising all bounding boxes in all sRGB images of
% the DND dataset.
%
% denoiser      Function handle
%               It is called as Idenoised = denoiser(Inoisy, nlf) where Inoisy is the noisy image patch 
%               and nlf is a struct containing the  mean noise strength (nlf.sigma)
% data_folder   Folder where the DND dataset resides
% out_folder    Folder where denoised output should be written to
%
% You can parallelize by having a parfor over the bounding boxes.
%
% Author: Tobias Pl√∂tz, TU Darmstadt (tobias.ploetz@visinf.tu-darmstadt.de)
%
% This file is part of the implementation as described in the CVPR 2017 paper:
% Tobias Pl√∂tz and Stefan Roth, Benchmarking Denoising Algorithms with Real Photographs.
% Please see the file LICENSE.txt for the license governing this code.

function denoise_srgb(data_folder, output_folder )
    infos = load(fullfile(data_folder, 'info.mat'));
    info = infos.info;

    % iterate over images
    for i=1:50
        % 0001.mat  4028°¡3020°¡3 single
        img = load(fullfile(data_folder, 'images_srgb', sprintf('%04d.mat', i)));
        % InoisySRGB
        Inoisy = img.InoisySRGB;

        % iterate over bounding boxes
        Idenoised_crop_bbs = cell(1,20);
        Inoisy_crop_bbs = cell(1,20);
        % 50°¡20
        for b = 1:20
            % 50 °¡ 20 °¡ 4
            bb = info(i).boundingboxes(b,:);
            % 512 °¡ 512 °¡ 3   0~1
            Inoisy_crop = Inoisy(bb(1):bb(3), bb(2):bb(4), :);
            % noise level function
            nlf = info(i).nlf;
            % sigma 
            nlf.sigma = info(i).sigma_srgb(b);

            % 0~1
            Idenoised_crop = denoiser_self(single(Inoisy_crop));
            
            Idenoised_crop_bbs{b} = Idenoised_crop;
            Inoisy_crop_bbs{b} = Inoisy_crop;
        end
        % save denoised image
        for b=1:20
            Idenoised_crop = Idenoised_crop_bbs{b};
            % save denoised mat
            save(fullfile(output_folder, sprintf('%04d_%02d.mat', i, b)), 'Idenoised_crop');

        end
        fprintf('Image %d/%d done\n', i,50);
    end

end

