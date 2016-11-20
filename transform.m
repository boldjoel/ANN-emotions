% This function is used to transform the raw data load from the emtion file
% to the proper format. The raw_sample data are transform to a 132 x 612
% matrix so that each column represent one sample with 132 features. The
% raw label data is transformed to a 6x612 matrix so that each column
% represents one target result. In each column, the correct label
% represents as 1 and others represents as 0. 
function [sample, label] = transform(raw_sample, raw_label)

    sample = raw_sample';

    label_count = size(raw_label,1);
    label = zeros(6, label_count);

    for i = 1 : label_count
        label(raw_label(i,1),i) = 1;
    end
    
end