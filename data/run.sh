
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
