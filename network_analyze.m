% This function takes the input data and target data as input and out a
% confusion matrix and eval_matrix as output. The eval_matrix is getted by
% calculated the confusion matrix
function [c_matrix, eval_matrix] = network_analyze(network, input, target)

    result = prop_to_index(sim(network, input));
    
    [r, c] = size(target);
    c_matrix = zeros(r, r);
   
    for i = 1 : c
        [~, t_index] = max(target(:,i));
        [~, r_index] = max(result(:,i));
        
        c_matrix(t_index, r_index) = c_matrix(t_index, r_index ) + 1;
    end
    
    eval_matrix = cmatrix_to_evalmatrix(c_matrix);
end