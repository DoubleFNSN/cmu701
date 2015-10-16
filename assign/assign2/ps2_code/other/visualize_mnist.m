addpath helper

images = load_mnist_images('data/train-images-idx3-ubyte');
labels = load_mnist_labels('data/train-labels-idx1-ubyte');
display_network(images(:,1:100)); % print first 100 images

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TODO: Explore the data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Size of each image
% TODO: 28*28 or 784?
fprintf('The size of each image is %d\n', size(images, 1));

% Range of labels
fprintf('Labels are %s\n', mat2str(unique(labels)'));

% Range of pixel values
fprintf('The range of pixel values is [%f, %f]\n', ...
    min(min(images)), max(max(images)));

% Maximum and minimum l2-norm of the images
normimages = sqrt(sum(abs(images) .^ 2));
fprintf('Maximum l2-norm of images: %f\n', max(normimages));
fprintf('Minimum l2-norm of images: %f\n', min(normimages));

% Whether the data is sparse or dense
% TODO: How the hell would I know what is sparse
N = numel(images);
zerospercent = numel(find(images == 0)) * 100 / N;
fprintf('0s: %f%%\n', zerospercent); % Anyway it should be sparse...

% Whether the label distribution is skewed or uniform
figure;
hist(labels)    % uniform
%{
[h, p] = chi2gof(labels, 'cdf', {@unifcdf, min(labels), max(labels)});
if (h == 0)
    disp 'The label distribution is uniform.'
else
    disp 'The label distribution is skewed.'
end
%}