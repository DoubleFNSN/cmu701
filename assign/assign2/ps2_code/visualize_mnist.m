addpath helper

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%1 load data
images = load_mnist_images('data/train-images-idx3-ubyte');
labels = load_mnist_labels('data/train-labels-idx1-ubyte');
display_network(images(:,1:100)); % print first 100 images

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%2 explore data
% use the following code, we could get the answer for question 1

% size of each image
image_size = length(images(:,1));

% range of labels
min_l = min(labels);
max_l = max(labels);

% range of pixel values
min_p = min(images(:));
max_p = max(images(:));

% max and min l2-norm of images
min_n = min(sqrt(dot(images,images)));
max_n = max(sqrt(dot(images,images)));

% sparsity
ratio = sum(sum(images(:)==0)) / (60000*784);

% label distribution
[a, b] = histc(labels,unique(labels));