% This function is the main function that we use to traning the network.
% We try to change the number of neuros, transfer function, training function,
% regularization rate, and data divided ratio to get a best network. 
function [cross_valid_eval_matrixs, net, ann_c_matrix, ann_eval_matrix] = train_cross_validation(input, target, neros)

    k = 10;
    class = 6;
    
    % If we dont specify the number of nueros, we set it to 20 by default.
    if (nargin < 3)
        neros = 20;
    end
    
   % transfer the initial data  to the proper format.
   [input, target] = transform(input, target);
   
   [~, sample_num] = size(input);
    
    % Divide the data into k subsets, the variable 'group' stores the index of each subsets.
    group = generate_k_split(target, k);
    
    net = newff(input, target, neros);
    
    % Set the transfer function for output layer.
    net.layers{2}.transferFcn='tansig';
    
    % Set the number of iteration
    net.trainParam.epochs = 1000;
   
    % Set the regularization parameter.
    net.performParam.regularization = 0.04;
    
    % Set the data divide function and divide ratio
    net.divideFcn='dividerand';
    net.divideParam.trainRatio = 0.8;
    net.divideParam.valRatio = 0.2;
    net.divideParam.testRatio = 0.0;
    
    % The main body of 10 cross validation. 90% of the data is used to
    % train the network, and other 10% is used for the validation process.
    cross_valid_c_matrixs = zeros(class, class, k);
    cross_valid_eval_matrixs = zeros(class + 1, 3, k);
    
    for i = 1 : k
        
        valid_index = group{i};
        
        train_index = 1 : sample_num;
        
        % Delete the validation set from the train set.
        train_index = setdiff(train_index, valid_index);
        train_index = train_index(randperm(length(train_index)));
        
        valid_input = input(:, valid_index);
        valid_target = target(:, valid_index);
        
        train_input = input(:, train_index);
        train_target = target(:, train_index);
   
        net = train(net, train_input, train_target);
        
        [c_matrix, eval_matrix] = network_analyze(net, valid_input, valid_target);
        
        cross_valid_c_matrixs(:,:,i) = c_matrix;
        cross_valid_eval_matrixs(:,:,i) = eval_matrix;
        
    end  
    
    ann_c_matrix = sum(cross_valid_c_matrixs, 3);
    ann_eval_matrix = cmatrix_to_evalmatrix(ann_c_matrix);
    
end