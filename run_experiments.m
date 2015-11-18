function run_experiments()
  % RCNN encoders
  rcnn.name = 'rcnn' ;
  rcnn.opts = {...
    'type', 'rcnn', ...
    'model', 'data/models/imagenet-vgg-m.mat', ...
    'layer', 19} ;

  rcnnft.name = 'rcnn-ft' ;
  rcnnft.opts = {...
    'type', 'rcnn', ...
    'model', 'data/models/ft-sweeps-full-vgg-m.mat', ...
    'layer', 19} ;

  rcnnft2.name = 'rcnn-ft-2' ;
  rcnnft2.opts = {...
    'type', 'rcnn', ...
    'model', 'data/models/ft-sweeps-full-vgg-m.mat', ...
    'layer', 19} ;

  rcnnvd.name = 'rcnnvd' ;
  rcnnvd.opts = {...
    'type', 'rcnn', ...
    'model', 'data/models/ft-sweeps-full-vgg-vd.mat', ...
    'layer', 35} ;

  % DCNN encoders
  dcnn.name = 'dcnn' ;
  dcnn.opts = {...
    'type', 'dcnn', ...
    'model', 'data/models/ft-sweeps-rcnn.mat', ...
    'layer', 14, ...
    'numWords', 64} ;

  dcnnft.name = 'dcnn-ft' ;
  dcnnft.opts = {...
    'type', 'dcnn', ...
    'model', 'data/models/ft-sweeps-full-vgg-m.mat', ...
    'layer', 14, ...
    'numWords', 64} ;


  dcnnvd.name = 'dcnnvd' ;
  dcnnvd.opts = {...
    'type', 'dcnn', ...
    'model', 'data/models/imagenet-vgg-verydeep-16.mat', ...
    'layer', 30, ...
    'numWords', 64} ;

  dcnnvdft.name = 'dcnnvd-ft' ;
  dcnnvdft.opts = {...
    'type', 'dcnn', ...
    'model', 'data/models/ft-sweeps-full-vgg-vd.mat', ...
    'layer', 30, ...
    'numWords', 64} ;

  % Dense SIFT
  dsift.name = 'dsift' ;
  dsift.opts = {...
    'type', 'dsift', ...
    'numWords', 64, ...
    'numPcaDimensions', 80} ;

  dsift2.name = 'dsift-2' ;
  dsift2.opts = {...
    'type', 'dsift', ...
    'numWords', 128, ...
    'numPcaDimensions', 80} ;

  % Bilinear CNN encoders
  bcnnmm.name = 'bcnnmm' ;
  bcnnmm.opts = {...
    'type', 'bcnn', ...
    'modela', 'data/models/imagenet-vgg-m.mat', ...
    'layera', 14,...
    'modelb', 'data/models/imagenet-vgg-m.mat', ...
    'layerb', 14,...
    } ;

  bcnnvdm.name = 'bcnnvdm' ;
  bcnnvdm.opts = {...
    'type', 'bcnn', ...
    'modela', 'data/models/imagenet-vgg-verydeep-16.mat', ...
    'layera', 30,...
    'modelb', 'data/models/imagenet-vgg-m.mat', ...
    'layerb', 14,...
    } ;
 

  bcnnvdvd.name = 'bcnnvdvd' ;
  bcnnvdvd.opts = {...
    'type', 'bcnn', ...
    'modela', 'data/models/imagenet-vgg-verydeep-16.mat', ...
    'layera', 30,...
    'modelb', 'data/models/imagenet-vgg-verydeep-16.mat', ...
    'layerb', 30,...
    };

    
  %setupNameList = {'rcnnvdft', 'dcnnvdft', 'bcnnvdftmft', 'bcnnvdftvdft'};
  %encoderList = {{rcnnvdft}, {dcnnvdft}, {bcnnvdftmft}, {bcnnvdftvdft}};
  %setupNameList = {'bcnnvdm', 'bcnnvdvd'};
  %encoderList = {{bcnnvdm}, {bcnnvdvd}};
  %setupNameList = {'dcnnfts', 'bcnnvdmfts', 'bcnnmftsmfts'};
  %encoderList = {{dcnnfts}, {bcnnvdmfts},  {bcnnmftsmfts}};
  
  %{
  setupNameList = {'rcnn', 'dsift', 'dcnn', 'rcnnvd', 'dcnnvd'};
  encoderList = {{rcnn}, {dsift}, {dcnn}, {rcnnvd}, {dcnnvd}};
  datasetList = {{'radar-sw-sweep02', 1}, ...
                 {'radar-vr-sweep02', 1}, ...
                 {'radar-sw-sweep03', 1}, ...
                 {'radar-vr-sweep03', 1}, ...
                 {'radar-sw-sweeps', 1}, ...
                 {'radar-vr-sweeps', 1}};
  %}
  
  setupNameList = {'dcnnvd'};
  encoderList = {{dcnnvd}};
  datasetList = {{'flickr8k', 1}};

  for ii = 1 : numel(datasetList)
    dataset = datasetList{ii} ;
    if iscell(dataset)
      numSplits = dataset{2} ;
      dataset = dataset{1} ;
    else
      numSplits = 1 ;
    end
    for jj = 1 : numSplits
      for ee = 1: numel(encoderList)
        model_train(...
          'dataset', dataset, ...
          'seed', jj, ...
          'encoders', encoderList{ee}, ...
          'prefix', 'v1', ...
          'suffix', setupNameList{ee}, ...
          'printDatasetInfo', ee == 1, ...
          'useGpu', false) ;
      end
    end
  end
end
