#!/bin/sh

# python create_job.py --script /home/fleeb/run.sh --dir /home/fleeb/workspace/foundation/hybrid/ --gpu 1 --mem 8 --cpu 4 --bid 1000

export FOUNDATION_RUN_MODE="cluster"

export FOUNDATION_SAVE_DIR="/home/fleeb/trained_nets/"
export FOUNDATION_DATA_DIR="/home/fleeb/local_data/"

export JOB_REGISTRY_PATH="/home/fleeb/registry.txt"

export RESTART_AFTER="5"

#export DISENTANGLEMENT_LIB_DATA="/home/fleeb/local_data"

echo '-- starting job --'

#cd /home/fleeb/workspace/foundation/mnist
#
#unbuffer python project.py model --name test-cls

cd /home/fleeb/workspace/gh-projects/hybrid


#unbuffer python hybrid.py dspr --name test-cls

exit

# WAE

unbuffer python hybrid.py dspr --name wae --model.gan_wt 0

#unbuffer python hybrid.py dspr --name wae-lr5e-4 --model.gan_wt 0 --optim.lr 0.0005
#
#unbuffer python hybrid.py dspr --name wae-defadam --model.gan_wt 0 --optim.beta1 0.9 --optim.beta2 0.999
#
#unbuffer python hybrid.py dspr --name wae-bs256 --model.gan_wt 0 --dataset.batch_size 256
#
#unbuffer python hybrid.py dspr --name wae-bs256 --model.gan_wt 0 --dataset.batch_size 256 --optim.lr 0.0005


unbuffer python hybrid.py dspr --name wae-noisep1 --model.gan_wt 0 --model.rec_noise 0.1

unbuffer python hybrid.py dspr --name wae-noisep2 --model.gan_wt 0 --model.rec_noise 0.2

unbuffer python hybrid.py dspr --name wae-noisep4 --model.gan_wt 0 --model.rec_noise 0.4


unbuffer python hybrid.py dspr --name wae-noisep2-beta200 --model.gan_wt 0 --model.rec_noise 0.2 --model.latent_reg_wt 200

unbuffer python hybrid.py dspr --name wae-noisep2-beta400 --model.gan_wt 0 --model.rec_noise 0.2 --model.latent_reg_wt 400



## WGAN
#
unbuffer python hybrid.py dspr --name wgan-step4 --model.gan_wt 1
#
unbuffer python hybrid.py dspr --name wgan-lr3x --model.gan_wt 1 --model.disc_steps 1 --model.discriminator.optim.lr 0.0003

unbuffer python hybrid.py dspr --name wgan-lr5x --model.gan_wt 1 --model.disc_steps 1 --model.discriminator.optim.lr 0.0005

unbuffer python hybrid.py dspr --name wgan-lr8x --model.gan_wt 1 --model.disc_steps 1 --model.discriminator.optim.lr 0.0008

unbuffer python hybrid.py dspr --name wgan-lr10x --model.gan_wt 1 --model.disc_steps 1 --model.discriminator.optim.lr 0.001
#
#
## WPP
#
unbuffer python hybrid.py dspr --name wpp-ganwt5 --model.gan_wt 1e-5

unbuffer python hybrid.py dspr --name wpp-ganwt4 --model.gan_wt 1e-4
#
#unbuffer python hybrid.py dspr --name wpp-ganwt3 --model.gan_wt 1e-3
#
#
## FWAE
#
unbuffer python hybrid.py factor --name fwae

unbuffer python hybrid.py factor --name fwae-beta200-noisep2 --model.latent_reg_wt 200 --model.rec_noise 0.2

unbuffer python hybrid.py factor --name fwae-priorp2 --model.reg_prior 0.2
#
#unbuffer python hybrid.py factor --name fwae-priorp2-beta500 --model.reg_prior 0.2 --model.latent_reg_wt 500
#
#
#unbuffer python hybrid.py factor --name fwae-priorp2-beta500-noisep1 --model.reg_prior 0.2 --model.latent_reg_wt 500 --model.rec_noise 0.1
#
#unbuffer python hybrid.py factor --name fwae-priorp2-beta500-noisep2 --model.reg_prior 0.2 --model.latent_reg_wt 500 --model.rec_noise 0.2
#
#
#unbuffer python hybrid.py factor --name fwae-priorp1-beta500 --model.reg_prior 0.1 --model.latent_reg_wt 500
#
#unbuffer python hybrid.py factor --name fwae-priorp1-beta1k --model.reg_prior 0.1 --model.latent_reg_wt 1000
#
#unbuffer python hybrid.py factor --name fwae-priorp1-beta2k --model.reg_prior 0.1 --model.latent_reg_wt 2000
#
#
#unbuffer python hybrid.py factor --name fwae-gan1e-3 --model.gan_wt 1e-3
#
#unbuffer python hybrid.py factor --name fwae-gan1e-4 --model.gan_wt 1e-4
#
#
## Dropin
#
#
unbuffer python hybrid.py dropin --name dropin-ganwt5 --model.gan_wt 1e-5

unbuffer python hybrid.py dropin --name dropin-ganwt4  --model.gan_wt 1e-4

unbuffer python hybrid.py dropin --name dropin-ganwt3 --model.gan_wt 1e-3

unbuffer python hybrid.py dropin --name dropin-ganwt2 --model.gan_wt 1e-2
#
#unbuffer python hybrid.py dropin --name dropin --model.gan_wt 1e-3 --model.prob 1
#
#unbuffer python hybrid.py dropin --name dropin --model.reg_prior 0.1 --model.latent_reg_wt 400
#
#
## Dropin-FWAE
#
#
unbuffer python hybrid.py dropin_factor --name fwaedin-ganwt3-priorp2 --model.gan_wt 1e-3 --model.reg_prior 0.2

unbuffer python hybrid.py dropin_factor --name fwaedin-ganwt3-priorp5 --model.gan_wt 1e-3 --model.reg_prior 0.5

unbuffer python hybrid.py dropin_factor --name fwaedin-ganwt4-priorp2 --model.gan_wt 1e-4 --model.reg_prior 0.2


#unbuffer python hybrid.py dropin_factor --name fwaedin-ganwt3-priorp2-beta500 --model.gan_wt 1e-3 --model.reg_prior 0.2 --model.latent_reg_wt 500
#
#unbuffer python hybrid.py dropin_factor --name fwaedin-ganwt2-priorp2-beta500 --model.gan_wt 1e-2 --model.reg_prior 0.2 --model.latent_reg_wt 500



if [ $? -eq 3 ]
then
  echo '-- pausing for restart --'
  exit 3
fi

echo '-- job complete --'


# unbuffer fig train hybrid  a/e/conv12 a/d/strc/12 m/ae d/3ds --info.extra d24 --latent-dim 24 # job_052 9647102.12
# unbuffer fig train hybrid  a/e/conv12 a/d/strc/12 m/ae d/3ds # job_052 9647102.13

# unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/wae d/3ds # job_054 9660268.0

# unbuffer fig train hybrid  a/e/conv12 a/d/strc/12 m/ae d/3ds --info.extra d24-lr0001 --latent-dim 24 --model.optim.lr 0.0001 # job_055 9660271.0

# unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/wae d/3ds --model.optim.lr 0.0001 # job_056 9666816.0
# unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/wae d/3ds --info.extra seed2 --seed 2 --model.optim.lr 0.0001 # job_056 9666816.1
# unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/wae d/3ds --info.extra seed3 --seed 3 --model.optim.lr 0.0001 # job_056 9666816.2

# unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/3ds --info.extra relu-seed10 --seed 10 --model.nonlin relu # job_055 9660271.2
# unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/3ds --info.extra lrelu-seed10 --seed 10 --model.nonlin lrelu # job_055 9660271.3
# unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/3ds --info.extra tanh-seed10 --seed 10 --model.nonlin tanh # job_055 9660271.4

# unbuffer fig train hybrid a/conv12 m/vae d/3ds # job_052 9647102.8
# unbuffer fig train hybrid a/conv12 m/vae d/3ds --info.extra b2 --reg-wt 2 # job_052 9647102.9
# unbuffer fig train hybrid a/conv12 m/vae d/3ds --info.extra b4 --reg-wt 4 # job_052 9647102.10
# unbuffer fig train hybrid a/conv12 m/vae d/3ds --info.extra b8 --reg-wt 8 # job_052 9647102.11

# unbuffer fig train hybrid a/conv m/wae d/3ds # job_051 9612252.1

######

# 57
#unbuffer fig train hybrid a/conv12 m/ae d/syn/cppn
#unbuffer fig train hybrid a/conv12 m/wae d/syn/cppn
#unbuffer fig train hybrid a/conv12 m/vae d/syn/cppn
#unbuffer fig train hybrid a/conv12 m/vae d/syn/cppn --reg-wt 2
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/syn/cppn
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/syn/cppn

##

#unbuffer fig train hybrid a/conv12 m/ae ex/angle-shape --info.extra xas
#unbuffer fig train hybrid a/conv12 m/wae ex/angle-shape --info.extra xas
#unbuffer fig train hybrid a/conv12 m/vae ex/angle-shape --info.extra xas
#unbuffer fig train hybrid a/conv12 m/vae ex/angle-shape --info.extra xas --reg-wt 2
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae ex/angle-shape --info.extra xas
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae ex/angle-shape --info.extra xas-s2 --seed 2

##

#unbuffer fig train hybrid a/conv12 m/ae ex/angle --info.extra xa
#unbuffer fig train hybrid a/conv12 m/wae ex/angle --info.extra xa
#unbuffer fig train hybrid a/conv12 m/vae ex/angle --info.extra xa
#unbuffer fig train hybrid a/conv12 m/vae ex/angle --info.extra xa --reg-wt 2
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae ex/angle --info.extra xa
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae ex/angle --info.extra xa-s2 --seed 2

##

#unbuffer fig train hybrid a/conv12 m/vae d/syn/scm d/syn/vec --info.extra scm-n6 --num-nodes 6
#unbuffer fig train hybrid a/conv12 m/vae d/syn/vec --info.extra n6 --num-nodes 6
#
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/syn/scm d/syn/vec --info.extra scm-n6 --num-nodes 6
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/syn/vec --info.extra n6 --num-nodes 6
#
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/syn/scm d/syn/vec --info.extra scm-nlin-n6 --num-nodes 6 --dataset.sampler.equation.hidden "[16,16]"
#unbuffer fig train hybrid a/conv12 m/vae d/syn/scm d/syn/vec --info.extra scm-nlin-n6 --num-nodes 6 --dataset.sampler.equation.hidden "[16,16]"
#
#
#unbuffer fig train hybrid a/conv12 m/vae d/syn/scm d/syn/cppn --info.extra scm-n6 --num-nodes 6
#unbuffer fig train hybrid a/conv12 m/vae d/syn/cppn --info.extra n6 --num-nodes 6
#
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/syn/scm d/syn/cppn --info.extra scm-n6 --num-nodes 6
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/syn/cppn --info.extra n6 --num-nodes 6
#
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae d/syn/scm d/syn/cppn --info.extra scm-nlin-n6 --num-nodes 6 --dataset.sampler.equation.hidden "[16,16]"
#unbuffer fig train hybrid a/conv12 m/vae d/syn/scm d/syn/cppn --info.extra scm-nlin-n6 --num-nodes 6 --dataset.sampler.equation.hidden "[16,16]"

##

unbuffer fig train hybrid a/conv12 m/ae ex/angle-shape --info.extra xas
unbuffer fig train hybrid a/conv12 m/wae ex/angle-shape --info.extra xas
unbuffer fig train hybrid a/conv12 m/vae ex/angle-shape --info.extra xas
unbuffer fig train hybrid a/conv12 m/vae ex/angle-shape --info.extra xas --reg-wt 2
unbuffer fig train hybrid a/conv12 m/vae ex/angle-shape --info.extra xas --reg-wt 4
unbuffer fig train hybrid a/e/conv12 a/d/strc/6 m/ae ex/angle-shape --info.extra xas
unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae ex/angle-shape --info.extra xas
unbuffer fig train hybrid a/ladder/12 m/vae ex/angle-shape --info.extra xas
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae ex/angle-shape --info.extra xas-s2 --seed 2

#

unbuffer fig train hybrid a/conv12 m/ae ex/angle --info.extra xa
unbuffer fig train hybrid a/conv12 m/wae ex/angle --info.extra xa
unbuffer fig train hybrid a/conv12 m/vae ex/angle --info.extra xa
unbuffer fig train hybrid a/conv12 m/vae ex/angle --info.extra xa --reg-wt 2
unbuffer fig train hybrid a/e/conv12 a/d/strc/6 m/ae ex/angle --info.extra xa
unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae ex/angle --info.extra xa
unbuffer fig train hybrid a/ladder/12 m/vae ex/angle --info.extra xa
#unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae ex/angle --info.extra xa-s2 --seed 2

unbuffer fig train hybrid nosplit a/e/conv12 a/d/strc/12 m/ae ex/angle --info.extra xa
unbuffer fig train hybrid a/e/conv12 a/d/strc/12 m/ae ex/angle-shape --info.extra xas

##3ds_vae2_e-c12_d-c12_xas_210424-022528
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_vae2_e-c12_d-c12_xas_210424-022528 --info.extra xas-vae2-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_vae2_e-c12_d-c12_xas_210424-022528 --info.extra xas-vae2-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_vae2_e-c12_d-c12_xas_210424-022528 --info.extra xas-vae2-both
#
##3ds_wae10_e-c12_d-c12_xas_210424-022529
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_wae10_e-c12_d-c12_xas_210424-022529 --info.extra xas-wae-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_wae10_e-c12_d-c12_xas_210424-022529 --info.extra xas-wae-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_wae10_e-c12_d-c12_xas_210424-022529 --info.extra xas-wae-both
#
##3ds_ae_e-c12_d-s12_xas_210424-022530
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_ae_e-c12_d-s12_xas_210424-022530 --info.extra xas-s12-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_ae_e-c12_d-s12_xas_210424-022530 --info.extra xas-s12-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_ae_e-c12_d-s12_xas_210424-022530 --info.extra xas-s12-both
#
##3ds_vae1_e-c12_d-c12_xas_210424-022530
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_vae1_e-c12_d-c12_xas_210424-022530 --info.extra xas-vae-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_vae1_e-c12_d-c12_xas_210424-022530 --info.extra xas-vae-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_vae1_e-c12_d-c12_xas_210424-022530 --info.extra xas-vae-both
#
##3ds_ae_e-c12_d-c12_xas_210424-022530
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_ae_e-c12_d-c12_xas_210424-022530 --info.extra xas-ae-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_ae_e-c12_d-c12_xas_210424-022530 --info.extra xas-ae-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_ae_e-c12_d-c12_xas_210424-022530 --info.extra xas-ae-both --info.extra xas-ae-both
#
##3ds_wae10_e-c12_d-c12_xa_210424-022636
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_wae10_e-c12_d-c12_xa_210424-022636 --info.extra xa-wae-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_wae10_e-c12_d-c12_xa_210424-022636 --info.extra xa-wae-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_wae10_e-c12_d-c12_xa_210424-022636 --info.extra xa-wae-both
#
##3ds_ae_e-c12_d-c12_xa_210424-022637
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_ae_e-c12_d-c12_xa_210424-022637 --info.extra xa-ae-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_ae_e-c12_d-c12_xa_210424-022637 --info.extra xa-ae-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_ae_e-c12_d-c12_xa_210424-022637 --info.extra xa-ae-both
#
##3ds_vae2_e-c12_d-c12_xa_210424-022637
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_vae2_e-c12_d-c12_xa_210424-022637 --info.extra xa-vae2-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_vae2_e-c12_d-c12_xa_210424-022637 --info.extra xa-vae2-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_vae2_e-c12_d-c12_xa_210424-022637 --info.extra xa-vae2-both
#
##3ds_ae_e-c12_d-s12_xa_210424-022637
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_ae_e-c12_d-s12_xa_210424-022637 --info.extra xa-s12-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_ae_e-c12_d-s12_xa_210424-022637 --info.extra xa-s12-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_ae_e-c12_d-s12_xa_210424-022637 --info.extra xa-s12-both
#
##3ds_vae1_e-c12_d-c12_xa_210424-022638
#unbuffer fig train ex/load-3ds --model-override.freeze-encoder --load-model 3ds_vae1_e-c12_d-c12_xa_210424-022638 --info.extra xa-vae-dec
#unbuffer fig train ex/load-3ds --model-override.freeze-decoder --load-model 3ds_vae1_e-c12_d-c12_xa_210424-022638 --info.extra xa-vae-enc
#unbuffer fig train ex/load-3ds --load-model 3ds_vae1_e-c12_d-c12_xa_210424-022638 --info.extra xa-vae-both


unbuffer fig train hybrid a/conv16 m/ae d/rfd --info.extra mish --model.nonlin mish
unbuffer fig train hybrid a/conv16 m/vae d/rfd --info.extra mish --model.nonlin mish
unbuffer fig train hybrid a/conv16 m/vae d/rfd --reg-wt 2 --info.extra mish --model.nonlin mish
unbuffer fig train hybrid a/d/strc/16 a/e/conv16 m/ae d/rfd --info.extra mish --model.nonlin mish
unbuffer fig train nosplit hybrid a/d/strc/16 a/e/conv16 m/ae d/rfd --info.extra nosplit-mish --model.nonlin mish
unbuffer fig train hybrid a/ladder/16 m/vae d/rfd --info.extra mish --model.nonlin mish


unbuffer fig train hybrid a/d/strc/16 a/e/conv16 m/ae d/rfd --info.extra mish --model.nonlin mish --model.optim.lr 0.0005



