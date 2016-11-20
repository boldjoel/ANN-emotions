How to run the code:
1. load('emotions_data.mat');
2. [cross_valid_eval_matrixs, net, ann_c_matrix, ann_eval_matrix] = train_cross_validation(x, y, (optional) neuron_number);
3. result:
	cross_valid_eval_matrixs : recall, precision, F1 measure for each validation
			     net : trained network
	            ann_c_matrix : confusion matrix for the network after 10-fold cross validation
		 ann_eval_matrix : recall, precision, F1 measure for the network after 10-fold cross validation