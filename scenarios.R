sourceDir("datamakers")

library(AlgDesign)

meanfn = c(spikes.fn, bumps.fn, blocks.fn, angles.fn, doppler.fn, blip.fn, cor.fn)
meanfn.short = c("sp", "bump", "blk", "ang", "dop", "blip", "cor")
rsnr = sqrt(c(1, 3))
varfn = c(cons.fn, texp.fn, doppler.fn, bumps.fn, cblocks.fn)
varfn.short = c("cons", "texp", "dop", "bump", "cblk")

design = gen.factorial(c(length(varfn), length(rsnr), length(meanfn)), center = FALSE)

for (i in 1:dim(design)[1]) {
  scenario.name = paste(meanfn.short[design[i, 3]], rsnr[design[i, 2]]^2, varfn.short[design[i, 1]], sep = ".")
  scenario.args = list(n = 1024, rsnr = rsnr[design[i, 2]], meanfn = meanfn[[design[i, 3]]], varfn = varfn[[design[i, 1]]])
  add_scenario(dsc_smash, name = scenario.name, fn = gaussian.1d, args = scenario.args, seed = 1:100)
}

# scenarios=list()
# scenarios[[1]]=list(name='sp.1.v1',fn=datamaker,args=list(n=1024,meanfn='spikes',varfn=1,rsnr=1),seed=1:100) 