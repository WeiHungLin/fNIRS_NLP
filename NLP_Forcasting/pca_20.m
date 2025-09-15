function score_20 = pca_20(data)
%PCA_20 Computes the first 20 principal components of the input data.
% 
% Inputs:
%   data - A matrix where rows are observations and columns are variables.
%
% Outputs:
%   score_20 - The data projected onto the first 20 principal components.
%   coeff_20 - The first 20 principal component coefficients (eigenvectors).
%   explained_20 - The variance explained by the first 20 principal components.
data = zscore(data);

% Perform PCA
[coeff, score, ~, ~, explained,~] = pca(data, 'NumComponents', 20);

% Get the first 20 principal components
% coeff_20 = coeff(:, 1:20); % Principal component coefficients
score_20 = score(:, 1:20); % Projected data on the first 20 PCs
% explained_20 = explained(1:20); % Variance explained by the first 20 PCs

% Optional: Display variance explained
% disp('Variance explained by the first 20 PCs:');
% disp(explained_20);

end