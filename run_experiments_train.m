function run_experiments_train()
% Fine-tune the CNN model on the NARRstyle radar dataset

%{
[opts, imdb] = model_setup('dataset', 'radar-sweeps', ...
			  'encoders', {}, ...
			  'prefix', 'cnn-train-narrstyle-1', ...
			  'model', 'imagenet-vgg-m.mat',...
			  'batchSize', 128, ...
			  'useGpu', true);
          
imdb_cnn_train_binary(imdb, opts);
%}

% Fine-tune the CNN model on the entire radar dataset
[opts, imdb] = model_setup('dataset', 'radar-sweep03', ...
			  'encoders', {}, ...
			  'prefix', 'cnn-train-full-sweep03', ...
			  'model', 'imagenet-vgg-m.mat',...
			  'batchSize', 128, ...
			  'useGpu', true);
          
imdb_cnn_train_binary(imdb, opts);