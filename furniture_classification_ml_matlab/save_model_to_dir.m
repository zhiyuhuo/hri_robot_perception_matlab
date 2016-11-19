function res = save_model_to_dir(folderdir, model, rbfsigma)

supportvectors = model.SupportVectors;
alpha = model.Alpha;
bias = model.Bias;
group = model.GroupNames(model.SupportVectorIndices);
shift = model.ScaleData.shift;
scale = model.ScaleData.scaleFactor;

supportvectors(find(abs(supportvectors) < 0.000000001)) = 0;
alpha(find(abs(alpha) < 0.000000001)) = 0;
bias(find(abs(bias) < 0.000000001)) = 0;
group(find(abs(group) < 0.000000001)) = 0;
scale(find(abs(scale) < 0.000000001)) = 0;
shift(find(abs(shift) < 0.000000001)) = 0;

dlmwrite([folderdir '/supportvectors.txt'], supportvectors);
dlmwrite([folderdir '/alpha.txt'], alpha);
dlmwrite([folderdir '/bias.txt'], bias);
dlmwrite([folderdir '/group.txt'], group);
dlmwrite([folderdir '/scale.txt'], scale);
dlmwrite([folderdir '/shift.txt'], shift);

end