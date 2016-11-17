function res = save_model_to_dir(folderdir, model, rbfsigma)

supportvectors = model.SupportVectors;
alpha = model.Alpha;
bias = model.Bias;
group = model.SupportVectorLabels;
scalefactor = model.Sigma;
shift = model.Mu;
beta = model.Beta;
sigma = rbfsigma;
scale = model.KernelParameters.Scale;

supportvectors(find(abs(supportvectors) < 0.000001)) = 0;
alpha(find(abs(alpha) < 0.000001)) = 0;
beta(find(abs(beta) < 0.000001)) = 0;
bias(find(abs(bias) < 0.000001)) = 0;
group(find(abs(group) < 0.000001)) = 0;
scalefactor(find(abs(scalefactor) < 0.000001)) = 0;
shift(find(abs(shift) < 0.000001)) = 0;

dlmwrite([folderdir '/supportvectors.txt'], supportvectors);
dlmwrite([folderdir '/alpha.txt'], alpha);
dlmwrite([folderdir '/bias.txt'], bias);
dlmwrite([folderdir '/group.txt'], group);
dlmwrite([folderdir '/scalefactor.txt'], scalefactor);
dlmwrite([folderdir '/shift.txt'], shift);
dlmwrite([folderdir '/sigma.txt'], sigma);
dlmwrite([folderdir '/beta.txt'], beta);
dlmwrite([folderdir '/lscale.txt'], scale);

end