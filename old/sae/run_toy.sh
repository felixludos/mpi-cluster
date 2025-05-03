
# conv mpi --cat toy
#unbuffer fig train hybrid a/conv12 m/ae d/mpi --cat toy
#unbuffer fig train hybrid a/conv12 m/wae d/mpi --cat toy
#unbuffer fig train hybrid a/conv12 m/wae d/mpi --cat toy --reg-wt 100
#unbuffer fig train hybrid a/conv12 m/wae d/mpi --cat toy --reg-wt 1000
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 2
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 4
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 8
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 16

# conv mpi --cat toy mish
#unbuffer fig train hybrid a/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/mpi --cat toy --reg-wt 100 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/wae d/mpi --cat toy --reg-wt 1000 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 2 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 4 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 8 --info.extra mish --model.nonlin mish


# strc mpi --cat toy
#unbuffer fig train hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat toy
#unbuffer fig train hybrid a/d/strc/3 a/e/conv12 m/ae d/mpi --cat toy
#unbuffer fig train hybrid a/d/strc/4 a/e/conv12 m/ae d/mpi --cat toy
#unbuffer fig train hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat toy
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy


# strc mpi --cat toy mish
#unbuffer fig train hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/3 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/4 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish


# strc nosplit mpi --cat toy
#unbuffer fig train nosplit hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/3 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/4 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
unbuffer fig train nosplit hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train nosplit hybrid a/d/strc/3 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train nosplit hybrid a/d/strc/4 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit-mish --model.nonlin mish


# strc mpi --cat toy seeds
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --seed 2 --info.extra seed2
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --seed 3 --info.extra seed3
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --seed 4 --info.extra seed4
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --seed 5 --info.extra seed5
##
#unbuffer fig train hybrid a/ladder/12 m/vae d/mpi --cat toy --seed 2 --info.extra seed2
#unbuffer fig train hybrid a/ladder/12 m/vae d/mpi --cat toy --seed 3 --info.extra seed3
#unbuffer fig train hybrid a/ladder/12 m/vae d/mpi --cat toy --seed 4 --info.extra seed4
#unbuffer fig train hybrid a/ladder/12 m/vae d/mpi --cat toy --seed 5 --info.extra seed5

#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish --seed 2 --info.extra seed2
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish --seed 3 --info.extra seed3
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish --seed 4 --info.extra seed4
#unbuffer fig train hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish --seed 5 --info.extra seed5


# ladders mpi --cat toy
#unbuffer fig train hybrid a/ladder/2 m/vae d/mpi --cat toy
#unbuffer fig train hybrid a/ladder/3 m/vae d/mpi --cat toy
#unbuffer fig train hybrid a/ladder/4 m/vae d/mpi --cat toy
#unbuffer fig train hybrid a/ladder/6 m/vae d/mpi --cat toy
#unbuffer fig train hybrid a/ladder/12 m/vae d/mpi --cat toy


# ladders mpi --cat toy mish
unbuffer fig train hybrid a/ladder/2 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
unbuffer fig train hybrid a/ladder/3 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/4 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/6 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/ladder/12 m/vae d/mpi --cat toy --info.extra mish --model.nonlin mish



########################################
# submitted

#unbuffer fig train nosplit hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/3 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/4 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/6 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
#unbuffer fig train nosplit hybrid a/d/strc/12 a/e/conv12 m/ae d/mpi --cat toy --info.extra nosplit
#
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 8
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 16
#
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 4 --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/conv12 m/vae d/mpi --cat toy --reg-wt 8 --info.extra mish --model.nonlin mish
#
#unbuffer fig train hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat toy
#unbuffer fig train hybrid a/d/strc/3 a/e/conv12 m/ae d/mpi --cat toy
#
#unbuffer fig train hybrid a/d/strc/2 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish
#unbuffer fig train hybrid a/d/strc/3 a/e/conv12 m/ae d/mpi --cat toy --info.extra mish --model.nonlin mish
#
#unbuffer fig train hybrid a/ladder/2 m/vae d/mpi --cat toy
#unbuffer fig train hybrid a/ladder/3 m/vae d/mpi --cat toy


