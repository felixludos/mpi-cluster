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

