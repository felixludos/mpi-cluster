
#unbuffer fig train hybrid a/conv m/ae d/3ds
#unbuffer fig train hybrid a/conv m/wae d/3ds
#unbuffer fig train hybrid a/conv m/vae d/3ds
#unbuffer fig train hybrid a/conv m/vae d/3ds --reg-wt 16

#unbuffer fig train hybrid a/dislib m/ae d/3ds
#unbuffer fig train hybrid a/dislib m/wae d/3ds
#unbuffer fig train hybrid a/dislib m/vae d/3ds
#unbuffer fig train hybrid a/dislib m/vae d/3ds --reg-wt 16

#unbuffer fig train hybrid a/ladder/4 m/vae d/3ds --info.extra l4
#unbuffer fig train hybrid a/ladder/6 m/vae d/3ds --info.extra l6
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra l12
#unbuffer fig train hybrid a/ladder/12 m/ae d/3ds --info.extra l12

#unbuffer fig train hybrid a/d/old/4 a/e/conv m/ae d/3ds --info.extra s4
#unbuffer fig train hybrid a/d/old/6 a/e/conv m/ae d/3ds --info.extra s6
#unbuffer fig train hybrid a/d/old/12 a/e/conv m/ae d/3ds --info.extra s12
#unbuffer fig train hybrid a/d/old/12 a/e/conv m/wae d/3ds --info.extra s12
#unbuffer fig train hybrid a/d/old/12 a/e/conv m/ae d/3ds --info.extra s12-s2 --seed 2

##

#unbuffer fig train hybrid a/conv m/ae d/3ds --info.extra 2xlr --model.optim.lr 0.001
#unbuffer fig train hybrid a/conv m/wae d/3ds --info.extra 2xlr --model.optim.lr 0.001
#unbuffer fig train hybrid a/conv m/vae d/3ds --info.extra 2xlr --model.optim.lr 0.001
#unbuffer fig train hybrid a/conv m/vae d/3ds --reg-wt 4 --info.extra beta4-2xlr --model.optim.lr 0.001
#unbuffer fig train hybrid a/d/old/12 a/e/conv m/ae d/3ds --info.extra s12-2xlr --model.optim.lr 0.001

#unbuffer fig train hybrid a/large/d/old16 a/large/e/conv m/ae d/celeba --info.extra s16
#unbuffer fig train hybrid a/large/conv m/ae d/celeba
#unbuffer fig train hybrid a/large/conv m/wae d/celeba
#unbuffer fig train hybrid a/large/conv m/vae d/celeba
#unbuffer fig train hybrid a/large/conv m/vae d/celeba --reg-wt 4 --info.extra beta4

#unbuffer fig train hybrid a/conv m/vae d/3ds --info.extra dim24 --latent-dim 24
#unbuffer fig train hybrid a/conv m/vae d/3ds --info.extra dim36 --latent-dim 36
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra l12-dim24 --latent-dim 24
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra l12-dim36 --latent-dim 36

#unbuffer fig train hybrid a/ladder/4 m/vae d/3ds --info.extra l4-reg01 --reg-wt 0.1
#unbuffer fig train hybrid a/ladder/6 m/vae d/3ds --info.extra l6-reg01 --reg-wt 0.1
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra l12-reg01 --reg-wt 0.1

#unbuffer fig train nosplit hybrid a/d/old/4 a/e/conv m/ae d/3ds --info.extra s4-nosplit
#unbuffer fig train nosplit hybrid a/d/old/6 a/e/conv m/ae d/3ds --info.extra s6-nosplit
#unbuffer fig train nosplit hybrid a/d/old/12 a/e/conv m/ae d/3ds --info.extra s12-nosplit


#unbuffer fig train hybrid a/d/new/12 a/e/conv m/ae d/3ds --info.extra s12-new
#unbuffer fig train hybrid a/d/new/12 a/e/conv m/ae d/3ds --info.extra s12-new-lr1e4 --model.optim.lr 0.0001
#unbuffer fig train scheduler hybrid a/d/new/12 a/e/conv m/ae d/3ds --info.extra s12-new-sch
#
#unbuffer fig train hybrid a/d/old/12 a/e/conv m/ae d/3ds --info.extra s12-lr1e4 --model.optim.lr 0.0001
#unbuffer fig train scheduler hybrid a/d/old/12 a/e/conv m/ae d/3ds --info.extra s12-sch

#unbuffer fig train hybrid a/lconv m/ae d/3ds --info.extra lconv
#unbuffer fig train hybrid a/lconv m/wae d/3ds --info.extra lconv
#unbuffer fig train hybrid a/lconv m/vae d/3ds --info.extra lconv
#unbuffer fig train hybrid a/lconv m/vae d/3ds --reg-wt 0.1 --info.extra lconv-betap1
#unbuffer fig train hybrid a/lconv m/vae d/3ds --reg-wt 0.01 --info.extra lconv-betap01


#unbuffer fig train hybrid a/large/d/old16 a/large/e/conv m/ae d/celeba --info.extra s16-betap001 --reg-wt 0.005
#unbuffer fig train hybrid a/large/d/old16 a/large/e/conv m/ae d/celeba --info.extra s16-betap005 --reg-wt 0.005
#unbuffer fig train hybrid a/large/d/old16 a/large/e/conv m/ae d/celeba --info.extra s16-betap01 --reg-wt 0.01

## 0.0078125, 0.03125

## ------------------------------------- vae fix

# todo:
# ladder celeba
# random seeds (5x)
# mpi datasets
# test: mish, residual, narrow/wide, coord


# dislib 3ds
unbuffer fig train hybrid a/dislib m/ae d/3ds
unbuffer fig train hybrid a/dislib m/wae d/3ds
unbuffer fig train hybrid a/dislib m/vae d/3ds
unbuffer fig train hybrid a/dislib m/vae d/3ds --reg-wt 4


# conv 3ds
#unbuffer fig train hybrid a/conv12 m/ae d/3ds
#unbuffer fig train hybrid a/conv12 m/wae d/3ds
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 100
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 1000
#unbuffer fig train hybrid a/conv12 m/vae d/3ds
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 2
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 4
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 8
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 16

# conv 3ds mish
#unbuffer fig train hybrid a/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 100 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 1000 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 2 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 4 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 8 --info.extra mish --model.nonlin mish


# conv extra
#unbuffer fig train coord hybrid a/conv12 m/ae d/3ds --info.extra coord
#unbuffer fig train hybrid a/conv12 m/ae d/3ds --info.extra res --model.residual
#unbuffer fig train hybrid a/conv12 m/ae d/3ds --info.extra res-nn --model.residual --model.norm None
#unbuffer fig train hybrid a/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish


# strc 3ds
#unbuffer fig train hybrid a/d/strc/2 a/e/conv12 m/ae d/3ds
#unbuffer fig train hybrid a/d/strc/3 a/e/conv12 m/ae d/3ds
#unbuffer fig train hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds
#unbuffer fig train hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds
#unbuffer fig train hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds --seed 2 --info.extra seed2
#unbuffer fig train hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds --seed 2 --info.extra seed2


# strc 3ds mish
unbuffer fig train hybrid a/d/strc/2 a/e/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish
unbuffer fig train hybrid a/d/strc/3 a/e/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish


# strc nosplit 3ds
#unbuffer fig train nosplit hybrid a/d/strc/2 a/e/conv12 m/ae d/3ds --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/3 a/e/conv12 m/ae d/3ds --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra nosplit
unbuffer fig train nosplit hybrid a/d/strc/2 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train nosplit hybrid a/d/strc/3 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train nosplit hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish


# strc 3ds extra
unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/wae d/3ds
unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/vae d/3ds
#unbuffer fig train coord hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra coord
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra res --model.residual
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra res-nn --model.residual --model.norm None
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish


# strc 3ds seeds
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --seed 2 --info.extra seed2
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --seed 3 --info.extra seed3
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --seed 4 --info.extra seed4
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --seed 5 --info.extra seed5
#
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --seed 2 --info.extra seed2
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --seed 3 --info.extra seed3
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --seed 4 --info.extra seed4
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --seed 5 --info.extra seed5


# ladders 3ds
#unbuffer fig train hybrid a/ladder/2 m/vae d/3ds
#unbuffer fig train hybrid a/ladder/3 m/vae d/3ds
#unbuffer fig train hybrid a/ladder/4 m/vae d/3ds
#unbuffer fig train hybrid a/ladder/6 m/vae d/3ds
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds


# ladders 3ds mish
unbuffer fig train hybrid a/ladder/2 m/vae d/3ds --info.extra mish --model.nonlin mish
unbuffer fig train hybrid a/ladder/3 m/vae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/4 m/vae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/6 m/vae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra mish --model.nonlin mish


# ladder 3ds extra
unbuffer fig train hybrid a/ladder/12 m/ae d/3ds


# region celeba

#unbuffer fig train hybrid a/conv16 m/ae d/celeba
#unbuffer fig train hybrid a/conv16 m/wae d/celeba
unbuffer fig train hybrid a/conv16 m/vae d/celeba
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --reg-wt 2
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --reg-wt 4
#unbuffer fig train hybrid a/d/strc/16 a/e/conv16 m/ae d/celeba
#unbuffer fig train nosplit hybrid a/d/strc/16 a/e/conv16 m/ae d/celeba --info.extra nosplit
#unbuffer fig train hybrid a/ladder/16 m/vae d/celeba
#unbuffer fig train hybrid a/ladder/16 m/ae d/celeba

# celeba mish
#unbuffer fig train hybrid a/conv16 m/ae d/celeba --info.extra mish --model.nonlin mish
unbuffer fig train hybrid a/conv16 m/vae d/celeba --info.extra mish --model.nonlin mish
unbuffer fig train hybrid a/conv16 m/vae d/celeba --reg-wt 2 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/16 a/e/conv16 m/ae d/celeba --info.extra mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/16 a/e/conv16 m/ae d/celeba --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train hybrid a/ladder/16 m/vae d/celeba --info.extra mish --model.nonlin mish

# endregion



##########################################
# submitted

#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 100
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 1000
#
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 100 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 1000 --info.extra mish --model.nonlin mish
#
#
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --seed 2 --info.extra seed2
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --seed 3 --info.extra seed3
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --seed 4 --info.extra seed4
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --seed 5 --info.extra seed5
#
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --seed 2 --info.extra seed2
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --seed 3 --info.extra seed3
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --seed 4 --info.extra seed4
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --seed 5 --info.extra seed5
#
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --seed 2 --info.extra seed2
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --info.extra lrp0004 --model.optim.lr 0.0004
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --info.extra lrp0003 --model.optim.lr 0.0003


#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra seed2-mish --model.nonlin mish --seed 2
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra seed3-mish --model.nonlin mish --seed 3
#
#
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra wdec1e4 --model.optim.weight_decay 0.0001
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra wdec1e4 --model.optim.weight_decay 0.0001
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 100
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 1000

#########################################

#unbuffer fig train hybrid a/d/strc/2 a/e/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish
#
#unbuffer fig train nosplit hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat real --info.extra nosplit
#
#unbuffer fig train nosplit hybrid a/d/strc/2 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat real --info.extra nosplit-mish --model.nonlin mish
#
#unbuffer fig train nosplit hybrid a/d/strc/3 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/3 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/3 a/e/conv12 m/ae d/mpi --cat real --info.extra nosplit-mish --model.nonlin mish
#
#unbuffer fig train nosplit hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/4 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/4 a/e/conv12 m/ae d/mpi --cat real --info.extra nosplit-mish --model.nonlin mish
#
#unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat real --info.extra nosplit-mish --model.nonlin mish
#
#unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish
#
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat real --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat real --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat real --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat real --info.extra mish-seed5 --seed 5 --model.nonlin mish
#
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish-seed5 --seed 5 --model.nonlin mish
#
#unbuffer fig train hybrid a/ladder/2 m/vae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/2 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/2 m/vae d/mpi --cat sim --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/2 m/vae d/mpi --cat real --info.extra mish --model.nonlin mish
#
#unbuffer fig train hybrid a/ladder/3 m/vae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/3 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/3 m/vae d/mpi --cat sim --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/3 m/vae d/mpi --cat real --info.extra mish --model.nonlin mish
#
#unbuffer fig train hybrid a/ladder/4 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/6 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/12 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
#
#unbuffer fig train hybrid a/ladder/4 m/vae d/mpi --cat real --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/6 m/vae d/mpi --cat real --info.extra mish --model.nonlin mish

##########################

#unbuffer fig train hybrid a/conv12 m/ae d/3ds --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/ae d/3ds --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/ae d/3ds --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/ae d/3ds --info.extra mish-seed5 --seed 5 --model.nonlin mish
#
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 1 --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 1 --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 1 --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 1 --info.extra mish-seed5 --seed 5 --model.nonlin mish
#
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 2 --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 2 --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 2 --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/3ds --reg-wt 2 --info.extra mish-seed5 --seed 5 --model.nonlin mish
#
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 100 --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 100 --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 100 --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 100 --info.extra mish-seed5 --seed 5 --model.nonlin mish
#
#unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra nosplit-mish-seed5 --seed 5 --model.nonlin mish
#
#unbuffer fig train hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/6 a/e/conv12 m/ae d/3ds --info.extra mish-seed5 --seed 5 --model.nonlin mish
#
#unbuffer fig train hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/4 a/e/conv12 m/ae d/3ds --info.extra mish-seed5 --seed 5 --model.nonlin mish

#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/ladder/12 m/vae d/3ds --info.extra mish-seed5 --seed 5 --model.nonlin mish

#####

#unbuffer fig train hybrid a/conv16 m/wae d/celeba --reg-wt 10 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv16 m/wae d/celeba --reg-wt 100 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv16 m/wae d/celeba --reg-wt 1000 --info.extra mish --model.nonlin mish

##### 026

#unbuffer fig train hybrid a/conv16 m/vae d/celeba --reg-wt 2 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --reg-wt 4 --info.extra mish --model.nonlin mish

##

#unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat sim --info.extra nosplit-mish-seed2 --model.nonlin mish --seed 2
#unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat sim --info.extra nosplit-mish-seed3 --model.nonlin mish --seed 3
#unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat sim --info.extra nosplit-mish-lrp0004 --model.nonlin mish --model.optim.lr 0.0004

## 28

#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 10 --info.extra mish-seed2 --seed 2 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 10 --info.extra mish-seed3 --seed 3 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 10 --info.extra mish-seed4 --seed 4 --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 10 --info.extra mish-seed5 --seed 5 --model.nonlin mish

## 29

#unbuffer fig train hybrid a/d/strc/3 a/e/conv12 m/ae d/3ds --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/3ds --reg-wt 10 --info.extra mish-seed5 --seed 5 --model.nonlin mish

##


#### final: fid.batch_size 32 for celeba

#fig eval --path 3ds_ae0_e-c12_d-c12_mish_210125-050038 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-c12_mish_210125-222234 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-c12_mish_210126-035850 --mode test --ident final
#fig eval --path real_ae_e-c12_d-c12_mish_210126-035928 --mode test --ident final
#fig eval --path 3ds_vae1_e-c12_d-c12_mish_210125-140254 --mode test --ident final
#fig eval --path toy_vae1_e-c12_d-c12_mish_210126-122537 --mode test --ident final
#fig eval --path sim_vae1_e-c12_d-c12_mish_210126-123641 --mode test --ident final
#fig eval --path real_vae1_e-c12_d-c12_mish_210126-123340 --mode test --ident final
#fig eval --path 3ds_vae2_e-c12_d-c12_mish_210125-140255 --mode test --ident final
#fig eval --path toy_vae2_e-c12_d-c12_mish_210126-122537 --mode test --ident final
#fig eval --path sim_vae2_e-c12_d-c12_mish_210126-123642 --mode test --ident final
#fig eval --path real_vae2_e-c12_d-c12_mish_210126-123340 --mode test --ident final
#fig eval --path 3ds_vae4_e-c12_d-c12_mish_210125-140302 --mode test --ident final
#fig eval --path toy_vae4_e-c12_d-c12_mish_210127-231812 --mode test --ident final
#fig eval --path sim_vae4_e-c12_d-c12_mish_210127-231257 --mode test --ident final
#fig eval --path real_vae4_e-c12_d-c12_mish_210127-231852 --mode test --ident final
#fig eval --path 3ds_vae8_e-c12_d-c12_mish_210125-140550 --mode test --ident final
#fig eval --path toy_vae8_e-c12_d-c12_mish_210127-231816 --mode test --ident final
#fig eval --path sim_vae8_e-c12_d-c12_mish_210127-231257 --mode test --ident final
#fig eval --path real_vae8_e-c12_d-c12_mish_210127-231853 --mode test --ident final
#fig eval --path 3ds_wae10_e-c12_d-c12_mish_210125-140253 --mode test --ident final
#fig eval --path toy_wae10_e-c12_d-c12_mish_210126-122537 --mode test --ident final
#fig eval --path sim_wae10_e-c12_d-c12_mish_210126-123641 --mode test --ident final
#fig eval --path real_wae10_e-c12_d-c12_mish_210126-123340 --mode test --ident final
#fig eval --path 3ds_wae100_e-c12_d-c12_mish_210125-221143 --mode test --ident final
#fig eval --path toy_wae100_e-c12_d-c12_mish_210126-122537 --mode test --ident final
#fig eval --path sim_wae100_e-c12_d-c12_mish_210126-123641 --mode test --ident final
#fig eval --path real_wae100_e-c12_d-c12_mish_210126-123340 --mode test --ident final
#fig eval --path 3ds_wae1000_e-c12_d-c12_mish_210125-221142 --mode test --ident final
#fig eval --path toy_wae1000_e-c12_d-c12_mish_210126-122537 --mode test --ident final
#fig eval --path sim_wae1000_e-c12_d-c12_mish_210126-123641 --mode test --ident final
#fig eval --path real_wae1000_e-c12_d-c12_mish_210126-123339 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s2_mish_210131-150237 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s2_mish_210127-231820 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s2_mish_210127-231304 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s2_mish_210127-231829 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s2_nosplit-mish_210131-150234 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s2_nosplit-mish_210131-150234 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s2_nosplit-mish_210127-231312 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s2_nosplit-mish_210131-150234 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s3_mish_210127-231823 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s3_mish_210127-231307 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s3_mish_210127-231829 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s3_nosplit-mish_210131-150234 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s3_nosplit-mish_210131-150236 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s3_nosplit-mish_210127-231312 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s3_nosplit-mish_210131-150234 --mode test --ident final
#fig eval --path 3ds_ae0_e-c12_d-s4_mish_210125-140253 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s4_mish_210126-122536 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s4_mish_210127-231308 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s4_mish_210126-123339 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s4_nosplit-mish_210131-150234 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s4_nosplit-mish_210131-150235 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s4_nosplit-mish_210127-231315 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s4_nosplit-mish_210131-150234 --mode test --ident final
#fig eval --path 3ds_ae0_e-c12_d-s6_mish_210125-140253 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s6_mish_210126-122536 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s6_mish_210127-231308 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s6_mish_210126-123339 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s6_nosplit-mish_210131-150234 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s6_nosplit-mish_210131-150236 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s6_nosplit-mish_210127-231313 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s6_nosplit-mish_210131-150236 --mode test --ident final
#fig eval --path 3ds_ae0_e-c12_d-s12_mish_210125-050335 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s12_mish_210125-222233 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s12_mish_210126-035851 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s12_mish_210127-231831 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s12_nosplit-mish_210131-150236 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s12_nosplit-mish_210131-150234 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s12_nosplit-mish_210127-231314 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s12_nosplit-mish_210127-231851 --mode test --ident final
#fig eval --path 3ds_vae1_e-l2_d-l2_mish_210131-150235 --mode test --ident final
#fig eval --path toy_vae1_e-l2_d-l2_mish_210131-150234 --mode test --ident final
#fig eval --path sim_vae1_e-l2_d-l2_mish_210131-150238 --mode test --ident final
#fig eval --path real_vae1_e-l2_d-l2_mish_210131-150240 --mode test --ident final
#fig eval --path 3ds_vae1_e-l3_d-l3_mish_210131-150235 --mode test --ident final
#fig eval --path toy_vae1_e-l3_d-l3_mish_210131-150234 --mode test --ident final
#fig eval --path sim_vae1_e-l3_d-l3_mish_210131-150236 --mode test --ident final
#fig eval --path real_vae1_e-l3_d-l3_mish_210131-150236 --mode test --ident final
#fig eval --path 3ds_vae1_e-l4_d-l4_mish_210125-134914 --mode test --ident final
#fig eval --path toy_vae1_e-l4_d-l4_mish_210131-150235 --mode test --ident final
#fig eval --path sim_vae1_e-l4_d-l4_mish_210127-231449 --mode test --ident final
#fig eval --path real_vae1_e-l4_d-l4_mish_210131-150236 --mode test --ident final
#fig eval --path 3ds_vae1_e-l6_d-l6_mish_210125-140021 --mode test --ident final
#fig eval --path toy_vae1_e-l6_d-l6_mish_210131-150235 --mode test --ident final
#fig eval --path sim_vae1_e-l6_d-l6_mish_210127-231447 --mode test --ident final
#fig eval --path real_vae1_e-l6_d-l6_mish_210131-150236 --mode test --ident final
#fig eval --path 3ds_vae1_e-l12_d-l12_mish_210125-140249 --mode test --ident final
#fig eval --path toy_vae1_e-l12_d-l12_mish_210131-150237 --mode test --ident final
#fig eval --path sim_vae1_e-l12_d-l12_mish_210127-231450 --mode test --ident final
#fig eval --path real_vae1_e-l12_d-l12_mish_210127-231847 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-c12_mish-seed2_210131-230456 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-c12_mish-seed3_210131-230456 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-c12_mish-seed4_210131-230456 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-c12_mish-seed5_210131-230456 --mode test --ident final
#fig eval --path 3ds_vae1_e-c12_d-c12_mish-seed2_210131-230457 --mode test --ident final
#fig eval --path 3ds_vae1_e-c12_d-c12_mish-seed3_210131-230501 --mode test --ident final
#fig eval --path 3ds_vae1_e-c12_d-c12_mish-seed4_210131-230501 --mode test --ident final
#fig eval --path 3ds_vae1_e-c12_d-c12_mish-seed5_210131-230500 --mode test --ident final
#fig eval --path 3ds_vae2_e-c12_d-c12_mish-seed2_210131-230501 --mode test --ident final
#fig eval --path 3ds_vae2_e-c12_d-c12_mish-seed3_210131-230459 --mode test --ident final
#fig eval --path 3ds_vae2_e-c12_d-c12_mish-seed4_210131-230503 --mode test --ident final
#fig eval --path 3ds_vae2_e-c12_d-c12_mish-seed5_210131-230501 --mode test --ident final
#fig eval --path 3ds_wae100_e-c12_d-c12_mish-seed2_210131-230501 --mode test --ident final
#fig eval --path 3ds_wae100_e-c12_d-c12_mish-seed3_210131-230503 --mode test --ident final
#fig eval --path 3ds_wae100_e-c12_d-c12_mish-seed4_210131-230503 --mode test --ident final
#fig eval --path 3ds_wae100_e-c12_d-c12_mish-seed5_210131-230503 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s4_mish-seed2_210131-230504 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s4_mish-seed3_210131-230506 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s4_mish-seed4_210131-230506 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s4_mish-seed5_210131-230505 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s6_mish-seed2_210131-230505 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s6_mish-seed3_210131-230503 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s6_mish-seed4_210131-230505 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s6_mish-seed5_210131-230504 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s12_mish-seed2_210131-150235 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s12_mish-seed2_210126-122537 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s12_mish-seed2_210126-123640 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s12_mish-seed2_210131-150234 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s12_mish-seed3_210131-150236 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s12_mish-seed3_210126-122537 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s12_mish-seed3_210126-123641 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s12_mish-seed3_210131-150234 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s12_mish-seed4_210131-150235 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s12_mish-seed4_210126-122537 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s12_mish-seed4_210126-123641 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s12_mish-seed4_210131-150234 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s12_mish-seed5_210131-150235 --mode test --ident final
#fig eval --path toy_ae_e-c12_d-s12_mish-seed5_210126-122537 --mode test --ident final
#fig eval --path sim_ae_e-c12_d-s12_mish-seed5_210126-123641 --mode test --ident final
#fig eval --path real_ae_e-c12_d-s12_mish-seed5_210131-150235 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s12_nosplit-mish-seed2_210131-230501 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s12_nosplit-mish-seed3_210131-230502 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s12_nosplit-mish-seed4_210131-230506 --mode test --ident final
#fig eval --path 3ds_ae_e-c12_d-s12_nosplit-mish-seed5_210131-230503 --mode test --ident final
#fig eval --path 3ds_vae1_e-l12_d-l12_mish-seed2_210131-230506 --mode test --ident final
#fig eval --path 3ds_vae1_e-l12_d-l12_mish-seed3_210131-230505 --mode test --ident final
#fig eval --path 3ds_vae1_e-l12_d-l12_mish-seed5_210131-230507 --mode test --ident final
#
#fig eval --path celeba_ae0_e-c16_d-c16_mish_210125-132401 --mode test --ident final --fid.batch_size 32
#fig eval --path celeba_ae0_e-c16_d-s16_mish_210125-132401 --mode test --ident final --fid.batch_size 32
#fig eval --path celeba_ae0_e-c16_d-s16_nosplit-mish_210125-132401 --mode test --ident final --fid.batch_size 32
#fig eval --path celeba_vae1_e-c16_d-c16_mish_210125-132401 --mode test --ident final --fid.batch_size 32
#fig eval --path celeba_vae1_e-l16_d-l16_mish_210125-132401 --mode test --ident final --fid.batch_size 32


#fig eval --path 3ds_vae1_e-l12_d-l12_mish-seed4_210131-230507 --mode test --ident final

#unbuffer fig eval --path 3ds_ae_e-c12_d-s12_seed2_210125-221143 --mode test --ident final


#unbuffer fig eval --path 3ds_ae_e-c12_d-s12_seed3-mish_210126-004805 --mode test --ident final
#unbuffer fig train hybrid nosplit a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish-nosplit-seed6 --model.nonlin mish --seed 6
#unbuffer fig train hybrid nosplit a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish-nosplit-seed7 --model.nonlin mish --seed 7
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish-seed6 --model.nonlin mish --seed 6
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish-seed7 --model.nonlin mish --seed 7
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/3ds --info.extra mish-seed8 --model.nonlin mish --seed 8

# 32

#unbuffer fig train hybrid a/ladder/16 m/vae d/celeba --info.extra mish-lrp0004 --model.nonlin mish --model.optim.lr 0.0004
#unbuffer fig train hybrid a/ladder/16 m/vae d/celeba --info.extra mish-lrp0003 --model.nonlin mish --model.optim.lr 0.0003
#unbuffer fig train hybrid a/ladder/16 m/vae d/celeba --info.extra mish-seed2 --model.nonlin mish --seed 2
#unbuffer fig train hybrid a/ladder/16 m/vae d/celeba --info.extra mish-seed2 --model.nonlin mish --seed 3

###

#unbuffer fig eval --path 3ds_ae_e-c12_d-s3_mish_210201-021841 --mode test --ident final
#unbuffer fig eval --path 3ds_wae10_e-c12_d-c12_mish-seed2_210201-021010 --mode test --ident final
#unbuffer fig eval --path 3ds_wae10_e-c12_d-c12_mish-seed4_210201-021011 --mode test --ident final
#unbuffer fig eval --path 3ds_wae10_e-c12_d-c12_mish-seed3_210201-021013 --mode test --ident final
#unbuffer fig eval --path 3ds_wae10_e-c12_d-c12_mish-seed5_210201-021840 --mode test --ident final

## 36

#unbuffer fig eval --path 3ds_ae_e-c12_d-s12_mish-seed8_210201-035456 --mode test --ident final
#unbuffer fig eval --path 3ds_ae_e-c12_d-s12_mish-seed6_210201-035456 --mode test --ident final
#unbuffer fig eval --path 3ds_ae_e-c12_d-s12_mish-nosplit-seed7_210201-035456 --mode test --ident final
#unbuffer fig eval --path 3ds_ae_e-c12_d-s12_mish-nosplit-seed6_210201-035459 --mode test --ident final

##

#unbuffer fig eval --path celeba_wae100_e-c16_d-c16_mish_210201-000430 --mode test --ident final --fid.batch_size 32
#unbuffer fig eval --path celeba_wae1000_e-c16_d-c16_mish_210201-000430 --mode test --ident final --fid.batch_size 32
#
#unbuffer fig eval --path celeba_vae1_e-c16_d-c16_seed2_210125-221143 --mode test --ident final --fid.batch_size 32
#
###
#
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --info.extra mish-lrp0003 --reg-wt 2 --model.nonlin mish --model.optim.lr 0.0003
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --info.extra mish-lrp0004 --reg-wt 4 --model.nonlin mish --model.optim.lr 0.0004
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --info.extra mish-lrp0003-seed2 --reg-wt 2 --model.nonlin mish --model.optim.lr 0.0003 --seed 2
#unbuffer fig train hybrid a/conv16 m/vae d/celeba --info.extra mish-lrp0004-seed2 --reg-wt 4 --model.nonlin mish --model.optim.lr 0.0004 --seed 2

##

#unbuffer fig eval --path celeba_vae2_e-c16_d-c16_210125-132401 --mode test --ident final --fid.batch_size 32

## 039

#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae0_e-c12_d-c12_mish_210125-050038
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-c12_d-c12_mish_210125-140254
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae2_e-c12_d-c12_mish_210125-140255
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae4_e-c12_d-c12_mish_210125-140302
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae8_e-c12_d-c12_mish_210125-140550
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae10_e-c12_d-c12_mish_210125-140253
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae100_e-c12_d-c12_mish_210125-221143
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae1000_e-c12_d-c12_mish_210125-221142
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s2_mish_210131-150237
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s2_nosplit-mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s3_mish_210201-021841
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s3_nosplit-mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae0_e-c12_d-s4_mish_210125-140253
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s4_nosplit-mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae0_e-c12_d-s6_mish_210125-140253
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s6_nosplit-mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae0_e-c12_d-s12_mish_210125-050335
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_nosplit-mish_210131-150236
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-l2_d-l2_mish_210131-150235
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-l3_d-l3_mish_210131-150235
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-l4_d-l4_mish_210125-134914
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-l6_d-l6_mish_210125-140021
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-l12_d-l12_mish_210125-140249
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-c12_mish-seed2_210131-230456
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-c12_mish-seed3_210131-230456
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-c12_mish-seed4_210131-230456
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-c12_mish-seed5_210131-230456
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-c12_d-c12_mish-seed2_210131-230457
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-c12_d-c12_mish-seed3_210131-230501
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-c12_d-c12_mish-seed4_210131-230501
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-c12_d-c12_mish-seed5_210131-230500
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae2_e-c12_d-c12_mish-seed2_210131-230501
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae2_e-c12_d-c12_mish-seed3_210131-230459
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae2_e-c12_d-c12_mish-seed4_210131-230503
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae2_e-c12_d-c12_mish-seed5_210131-230501
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae10_e-c12_d-c12_mish-seed2_210201-021010
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae10_e-c12_d-c12_mish-seed3_210201-021013
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae10_e-c12_d-c12_mish-seed4_210201-021011
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae10_e-c12_d-c12_mish-seed5_210201-021840
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae100_e-c12_d-c12_mish-seed2_210131-230501
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae100_e-c12_d-c12_mish-seed3_210131-230503
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae100_e-c12_d-c12_mish-seed4_210131-230503
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_wae100_e-c12_d-c12_mish-seed5_210131-230503
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s4_mish-seed2_210131-230504
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s4_mish-seed3_210131-230506
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s4_mish-seed4_210131-230506
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s4_mish-seed5_210131-230505
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s6_mish-seed2_210131-230505
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s6_mish-seed3_210131-230503
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s6_mish-seed4_210131-230505
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s6_mish-seed5_210131-230504
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_seed3-mish_210126-004805
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_mish-seed2_210131-150235
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_mish-seed5_210131-150235
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_mish-seed8_210201-035456
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_mish-seed6_210201-035456
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_nosplit-mish-seed3_210131-230502
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_nosplit-mish-seed5_210131-230503
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_nosplit-mish-seed4_210131-230506
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_ae_e-c12_d-s12_mish-nosplit-seed7_210201-035456
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-l12_d-l12_mish-seed2_210131-230506
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-l12_d-l12_mish-seed3_210131-230505
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-l12_d-l12_mish-seed4_210131-230507
#unbuffer fig eval-multiple-metrics eval/3ds --run-name 3ds_vae1_e-l12_d-l12_mish-seed5_210131-230507
#
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-c12_mish_210125-222234
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_vae1_e-c12_d-c12_mish_210126-122537
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_vae2_e-c12_d-c12_mish_210126-122537
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_vae4_e-c12_d-c12_mish_210127-231812
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_vae8_e-c12_d-c12_mish_210127-231816
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_wae10_e-c12_d-c12_mish_210126-122537
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_wae100_e-c12_d-c12_mish_210126-122537
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_wae1000_e-c12_d-c12_mish_210126-122537
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s2_mish_210127-231820
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s2_nosplit-mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s3_mish_210127-231823
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s3_nosplit-mish_210131-150236
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s4_mish_210126-122536
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s4_nosplit-mish_210131-150235
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s6_mish_210126-122536
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s6_nosplit-mish_210131-150236
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s12_mish_210125-222233
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s12_nosplit-mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_vae1_e-l2_d-l2_mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_vae1_e-l3_d-l3_mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_vae1_e-l4_d-l4_mish_210131-150235
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_vae1_e-l6_d-l6_mish_210131-150235
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_vae1_e-l12_d-l12_mish_210131-150237
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s12_mish-seed2_210126-122537
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s12_mish-seed3_210126-122537
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s12_mish-seed4_210126-122537
#unbuffer fig eval-multiple-metrics eval/mpi --cat toy --run-name toy_ae_e-c12_d-s12_mish-seed5_210126-122537
#
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-c12_mish_210126-035850
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_vae1_e-c12_d-c12_mish_210126-123641
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_vae2_e-c12_d-c12_mish_210126-123642
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_vae4_e-c12_d-c12_mish_210127-231257
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_vae8_e-c12_d-c12_mish_210127-231257
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_wae10_e-c12_d-c12_mish_210126-123641
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_wae100_e-c12_d-c12_mish_210126-123641
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_wae1000_e-c12_d-c12_mish_210126-123641
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s2_mish_210127-231304
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s2_nosplit-mish_210127-231312
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s3_mish_210127-231307
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s3_nosplit-mish_210127-231312
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s4_mish_210127-231308
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s4_nosplit-mish_210127-231315
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s6_mish_210127-231308
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s6_nosplit-mish_210127-231313
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s12_mish_210126-035851
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s12_nosplit-mish_210127-231314
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_vae1_e-l2_d-l2_mish_210131-150238
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_vae1_e-l3_d-l3_mish_210131-150236
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_vae1_e-l4_d-l4_mish_210127-231449
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_vae1_e-l6_d-l6_mish_210127-231447
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_vae1_e-l12_d-l12_mish_210127-231450
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s12_mish-seed2_210126-123640
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s12_mish-seed3_210126-123641
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s12_mish-seed4_210126-123641
#unbuffer fig eval-multiple-metrics eval/mpi --cat sim --run-name sim_ae_e-c12_d-s12_mish-seed5_210126-123641
#
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-c12_mish_210126-035928
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_vae1_e-c12_d-c12_mish_210126-123340
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_vae2_e-c12_d-c12_mish_210126-123340
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_vae4_e-c12_d-c12_mish_210127-231852
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_vae8_e-c12_d-c12_mish_210127-231853
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_wae10_e-c12_d-c12_mish_210126-123340
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_wae100_e-c12_d-c12_mish_210126-123340
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_wae1000_e-c12_d-c12_mish_210126-123339
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s2_mish_210127-231829
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s2_nosplit-mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s3_mish_210127-231829
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s3_nosplit-mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s4_mish_210126-123339
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s4_nosplit-mish_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s6_mish_210126-123339
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s6_nosplit-mish_210131-150236
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s12_mish_210127-231831
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s12_nosplit-mish_210127-231851
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_vae1_e-l2_d-l2_mish_210131-150240
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_vae1_e-l3_d-l3_mish_210131-150236
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_vae1_e-l4_d-l4_mish_210131-150236
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_vae1_e-l6_d-l6_mish_210131-150236
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_vae1_e-l12_d-l12_mish_210127-231847
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s12_mish-seed2_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s12_mish-seed3_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s12_mish-seed4_210131-150234
#unbuffer fig eval-multiple-metrics eval/mpi --cat real --run-name real_ae_e-c12_d-s12_mish-seed5_210131-150235

##
#unbuffer fig eval --path toy_ae_e-c12_d-c12_mish_210125-222234 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-c12_mish_210126-035850 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-c12_mish_210126-035928 --mode val --ident eval
#unbuffer fig eval --path toy_vae1_e-c12_d-c12_mish_210126-122537 --mode val --ident eval
#unbuffer fig eval --path sim_vae1_e-c12_d-c12_mish_210126-123641 --mode val --ident eval
#unbuffer fig eval --path real_vae1_e-c12_d-c12_mish_210126-123340 --mode val --ident eval
#unbuffer fig eval --path toy_vae2_e-c12_d-c12_mish_210126-122537 --mode val --ident eval
#unbuffer fig eval --path sim_vae2_e-c12_d-c12_mish_210126-123642 --mode val --ident eval
#unbuffer fig eval --path real_vae2_e-c12_d-c12_mish_210126-123340 --mode val --ident eval
#unbuffer fig eval --path toy_vae4_e-c12_d-c12_mish_210127-231812 --mode val --ident eval
#unbuffer fig eval --path sim_vae4_e-c12_d-c12_mish_210127-231257 --mode val --ident eval
#unbuffer fig eval --path real_vae4_e-c12_d-c12_mish_210127-231852 --mode val --ident eval
#unbuffer fig eval --path toy_vae8_e-c12_d-c12_mish_210127-231816 --mode val --ident eval
#unbuffer fig eval --path sim_vae8_e-c12_d-c12_mish_210127-231257 --mode val --ident eval
#unbuffer fig eval --path real_vae8_e-c12_d-c12_mish_210127-231853 --mode val --ident eval
#unbuffer fig eval --path toy_wae10_e-c12_d-c12_mish_210126-122537 --mode val --ident eval
#unbuffer fig eval --path sim_wae10_e-c12_d-c12_mish_210126-123641 --mode val --ident eval
#unbuffer fig eval --path real_wae10_e-c12_d-c12_mish_210126-123340 --mode val --ident eval
#unbuffer fig eval --path toy_wae100_e-c12_d-c12_mish_210126-122537 --mode val --ident eval
#unbuffer fig eval --path sim_wae100_e-c12_d-c12_mish_210126-123641 --mode val --ident eval
#unbuffer fig eval --path real_wae100_e-c12_d-c12_mish_210126-123340 --mode val --ident eval
#unbuffer fig eval --path toy_wae1000_e-c12_d-c12_mish_210126-122537 --mode val --ident eval
#unbuffer fig eval --path sim_wae1000_e-c12_d-c12_mish_210126-123641 --mode val --ident eval
#unbuffer fig eval --path real_wae1000_e-c12_d-c12_mish_210126-123339 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s2_mish_210127-231820 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s2_mish_210127-231304 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s2_mish_210127-231829 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s2_nosplit-mish_210131-150234 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s2_nosplit-mish_210127-231312 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s2_nosplit-mish_210131-150234 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s3_mish_210127-231823 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s3_mish_210127-231307 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s3_mish_210127-231829 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s3_nosplit-mish_210131-150236 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s3_nosplit-mish_210127-231312 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s3_nosplit-mish_210131-150234 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s4_mish_210126-122536 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s4_mish_210127-231308 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s4_mish_210126-123339 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s4_nosplit-mish_210131-150235 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s4_nosplit-mish_210127-231315 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s4_nosplit-mish_210131-150234 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s6_mish_210126-122536 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s6_mish_210127-231308 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s6_mish_210126-123339 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s6_nosplit-mish_210131-150236 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s6_nosplit-mish_210127-231313 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s6_nosplit-mish_210131-150236 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s12_mish_210125-222233 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s12_mish_210126-035851 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s12_mish_210127-231831 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s12_nosplit-mish_210131-150234 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s12_nosplit-mish_210127-231314 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s12_nosplit-mish_210127-231851 --mode val --ident eval
#unbuffer fig eval --path toy_vae1_e-l2_d-l2_mish_210131-150234 --mode val --ident eval
#unbuffer fig eval --path sim_vae1_e-l2_d-l2_mish_210131-150238 --mode val --ident eval
#unbuffer fig eval --path real_vae1_e-l2_d-l2_mish_210131-150240 --mode val --ident eval
#unbuffer fig eval --path toy_vae1_e-l3_d-l3_mish_210131-150234 --mode val --ident eval
#unbuffer fig eval --path sim_vae1_e-l3_d-l3_mish_210131-150236 --mode val --ident eval
#unbuffer fig eval --path real_vae1_e-l3_d-l3_mish_210131-150236 --mode val --ident eval
#unbuffer fig eval --path toy_vae1_e-l4_d-l4_mish_210131-150235 --mode val --ident eval
#unbuffer fig eval --path sim_vae1_e-l4_d-l4_mish_210127-231449 --mode val --ident eval
#unbuffer fig eval --path real_vae1_e-l4_d-l4_mish_210131-150236 --mode val --ident eval
#unbuffer fig eval --path toy_vae1_e-l6_d-l6_mish_210131-150235 --mode val --ident eval
#unbuffer fig eval --path sim_vae1_e-l6_d-l6_mish_210127-231447 --mode val --ident eval
#unbuffer fig eval --path real_vae1_e-l6_d-l6_mish_210131-150236 --mode val --ident eval
#unbuffer fig eval --path toy_vae1_e-l12_d-l12_mish_210131-150237 --mode val --ident eval
#unbuffer fig eval --path sim_vae1_e-l12_d-l12_mish_210127-231450 --mode val --ident eval
#unbuffer fig eval --path real_vae1_e-l12_d-l12_mish_210127-231847 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s12_mish-seed2_210126-122537 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s12_mish-seed2_210126-123640 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s12_mish-seed2_210131-150234 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s12_mish-seed3_210126-122537 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s12_mish-seed3_210126-123641 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s12_mish-seed3_210131-150234 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s12_mish-seed4_210126-122537 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s12_mish-seed4_210126-123641 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s12_mish-seed4_210131-150234 --mode val --ident eval
#unbuffer fig eval --path toy_ae_e-c12_d-s12_mish-seed5_210126-122537 --mode val --ident eval
#unbuffer fig eval --path sim_ae_e-c12_d-s12_mish-seed5_210126-123641 --mode val --ident eval
#unbuffer fig eval --path real_ae_e-c12_d-s12_mish-seed5_210131-150235 --mode val --ident eval

##
#unbuffer fig eval --path celeba_wae10_e-c16_d-c16_mish_210201-000430 --mode test --ident final --fid.batch_size 32

### final celeb


#unbuffer fig eval --path celeba_vae1_e-l16_d-l16_mish-lrp0004_210201-034237 --mode test --ident final --fid.batch_size 32
#unbuffer fig eval --path celeba_vae2_e-c16_d-c16_mish-lrp0003_210201-101817 --mode test --ident final --fid.batch_size 32
#unbuffer fig eval --path celeba_vae4_e-c16_d-c16_mish-lrp0004_210201-101817 --mode test --ident final --fid.batch_size 32


#fig eval _local --path 3ds_ae0_e-c12_d-s6_mish_210125-140253
#fig eval _local --path 3ds_ae0_e-c12_d-s4_mish_210125-140253
#fig eval _local --path 3ds_ae_e-c12_d-s3_mish_210201-021841
#fig eval _local --path 3ds_ae_e-c12_d-s2_mish_210131-150237

#fig eval _local --path toy_ae_e-c12_d-s6_mish_210126-122536
#fig eval _local --path toy_ae_e-c12_d-s4_mish_210126-122536
#fig eval _local --path toy_ae_e-c12_d-s3_mish_210127-231823
#fig eval _local --path toy_ae_e-c12_d-s2_mish_210127-231820

#fig eval _local --path real_ae_e-c12_d-s6_mish_210126-123339
#fig eval _local --path real_ae_e-c12_d-s4_mish_210126-123339
#fig eval _local --path real_ae_e-c12_d-s3_mish_210127-231829
#fig eval _local --path real_ae_e-c12_d-s2_mish_210127-231829

#fig eval _local --path sim_ae_e-c12_d-s6_mish_210127-231308
#fig eval _local --path sim_ae_e-c12_d-s4_mish_210127-231308
#fig eval _local --path sim_ae_e-c12_d-s3_mish_210127-231307
#fig eval _local --path sim_ae_e-c12_d-s2_mish_210127-231304

#fig eval _local --path celeba_ae0_e-c16_d-s16_mish_210125-132401

