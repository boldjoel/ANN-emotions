% This function is used to handle the output data. It transfer the
% probability matrix output by the neural network to the same famot as our
% target data.
function result = prop_to_index(prop_matrix)

    [r,c] = size(prop_matrix);
    result =zeros(r,c);

    for i = 1 : c
        
        % Get the index of the maximum value.
        [~, m] = max(prop_matrix(:, i));
        
        % Set this maximum position to 1 and others to 0.
        result(m, i) = 1;
    end
    
end