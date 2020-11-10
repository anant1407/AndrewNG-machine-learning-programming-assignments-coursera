function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
c1=1;
i=1;
C=0.01;
m_val=size(Xval,1);
max=0;
count=0;
C_arr=[0.01,0.03,0.1,0.3,1,3,10,30];
sigma_arr=C_arr;

while c1<=8
  
  c2=1;
  C = C_arr(c1);
  while c2 <= 8
    sigma = sigma_arr(c2);
    model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    predictions = svmPredict(model, Xval);
    acc = 0;
    for i = 1:m_val
      
      if yval(i,1) == predictions(i,1)
        acc = acc+1;
      endif
      
    endfor
    
    accuracy = (acc/m_val)*100;
    count = count+1;
    
    if accuracy >= max
      max = accuracy;
      C_opt = C;
      sigma_opt = sigma;
     
    endif
      
    c2 = c2+1; 

  endwhile
 
  c1 = c1+1;
  
endwhile

C = C_opt;
sigma = sigma_opt;

% =========================================================================

end
