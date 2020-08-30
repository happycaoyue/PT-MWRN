function bundle_submission_srgb(submission_folder)
    out_folder = fullfile(submission_folder, 'bundled/');
    mkdir(out_folder);

    israw = false;
    eval_version = '1.0';

    for i=1:50
        Idenoised = cell(1,20);
        parfor b=1:20
            filename = sprintf('%04d_%02d.mat', i,b);
            s = load(fullfile(submission_folder, filename));

            Idenoised{b} = s.Idenoised_crop;        
        end
        filename = sprintf('%04d.mat', i);
        save(fullfile(out_folder, filename), 'Idenoised', 'israw', 'eval_version', '-v7.3');
    end
end


