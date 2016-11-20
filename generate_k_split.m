% This functuon is used to split the training data into k sets by returning
% the index of each data. After splitting the data, we can use them to do
% 10 cross validation. In order to avoid over-fittting problem and improfve
% the robustness of our network, we evenly split the data.
function result = generate_k_split(target, k)

    random_iter = 5;
    [r, c] = size(target);
    
    distribute = cell(r, 2);
    result = cell(k,1);

    % Calculate the distribution of the sample.
    for i = 1 : c
        [~,v] = max(target(:, i));
        distribute{v}(end+1) = i; 
    end

    % Balanced select samples for each validation set.
    for i = 1 : r
        
        sample = distribute{i};
        [~, s] = size(sample);

        for j = 1 : random_iter
            sample = sample(randperm(s));
        end

        group = 1 : s/k : s+1;

        for j = 1 : k
            
            up_bound = round(group(j));
            low_bound = round(group(j+1)) - 1;

            selected_index = up_bound : low_bound;

            result{j} = [result{j}, sample(selected_index)];
        end
        
    end
    
    for i = 1 : k
        
        [~, s] = size(result{i});
        
        for j = 1 : random_iter
            result{i} = result{i}(randperm(s));
        end
        
    end
    
end