for i = 1 : size(results, 1)
   figure;
   hold on
   title(strcat('Dataset:', num2str(i)));
   for j = 1 : size(results,3)
      plot(size_windows,results(i, :, j), '-'); 
   end
   hold off
   lgd = legend('5', '10', '15');
   title(lgd, 'nb neighbors');
   xlabel('window size');
   ylabel('F1 score');
end

max(sum(results, 1) / 4)