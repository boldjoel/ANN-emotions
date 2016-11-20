% The function is used to change the number of node for the  hidden layer and
% train the neural network automatically. For example,result = batch_train_model(x, y, 10, 2)
% means that train the network with 2,4,6,8,10 nodes and save the final
% result to the "result" variable. By default, this function will train the network 5
% times for each different number of neuros.
function result = batch_train_model(x, y, max_nero, intergral)

    run_number = 5;
    result = num2cell((intergral : intergral : max_nero)');

    for i = 1 : length(result)
        nets = cell(1, run_number);
        rs = cell(1, run_number);
        
        for j = 1 : run_number
            [~, rs{j}, nets{j}] = train_cross_validation(x, y, result{i});
        end
        
        result{i, 2} = rs;
        result{i, 3} = nets;
    end
end